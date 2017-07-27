/*2017-05-03T18:45:46Z (mmarshik)
C:\Users\marsmi01\AppData\Roaming\HPCC Systems\eclide\mmarshik\DataLand\Models\FP1611_1_0\2017-05-03T18_45_46Z.ecl
*/
import ut, Risk_Indicators, RiskWise, RiskWiseFCRA, easi, std, Models;

EXPORT FP1611_1_0 (dataset(risk_indicators.Layout_Boca_Shell) clam,
                  integer1 num_reasons) := FUNCTION
		
blank_ip := dataset( [{0}], riskwise.Layout_IP2O )[1];

	MODEL_DEBUG := False;

	boolean isFCRA := false;

	#if(MODEL_DEBUG)
		Layout_Debug := RECORD
			/* Model Input Variables */
	 Integer seq;
   Integer	 sysdate;
   String	 iv_add_apt;
   Integer	 rv_s65_ssn_prior_dob;
   Integer	 rv_c16_inv_ssn_per_adl;
   Integer	 rv_s65_ssn_problem;
   Integer	 rv_p88_phn_dst_to_inp_add;
   Integer	 iv_phn_cell;
   Integer	 iv_phn_pcs;
   String	 add_ec3;
   String	 add_ec4;
   String	 rv_l70_add_standardized;
   Integer	 rv_l72_add_curr_vacant;
   Integer	 rv_l74_add_curr_throwback;
   String	 rv_l76_add_curr_seasonal;
   Integer	 rv_c19_add_prison_hist;
   Integer	 rv_f00_dob_score;
   Integer	 rv_f01_inp_addr_address_score;
   Integer	 rv_f00_input_dob_match_level;
   Integer	 rv_d30_derog_count;
   Integer	 rv_d32_criminal_count;
   Integer	 rv_d32_felony_count;
   String	 rv_d32_criminal_x_felony;
   Integer	 _criminal_last_date;
   Integer	 rv_d32_mos_since_crim_ls;
   Integer	 _felony_last_date;
   Real	 rv_d32_mos_since_fel_ls;
   String	 rv_d31_mostrec_bk;
   String	 rv_d31_all_bk;
   Integer	 rv_d31_bk_dism_recent_count;
   Integer	 rv_c21_stl_recency;
   Integer	 rv_d33_eviction_recency;
   Integer	 rv_d33_eviction_count;
   Real	 rv_d34_unrel_liens_ct;
   String	 iv_d34_liens_unrel_x_rel;
   Real	 _src_bureau_adl_fseen;
   Real	 rv_c20_m_bureau_adl_fs;
   Integer	 num_dob_match_level;
   Integer	 nas_summary_ver;
   Integer	 nap_summary_ver;
   Integer	 infutor_nap_ver;
   Integer	 dob_ver;
   Integer	 sufficiently_verified;
   String	 add_ec1;
   Integer	 addr_validation_problem;
   Integer	 phn_validation_problem;
   Integer	 validation_problem;
   Integer	 tot_liens;
   Integer	 tot_liens_w_type;
   Integer	 has_derog;
   String	 rv_6seg_riskview_5_0;
   String	 rv_4seg_riskview_5_0;
   Integer	 nf_m_bureau_adl_fs_all;
   Integer	 _src_bureau_adl_fseen_notu;
   Integer	 nf_m_bureau_adl_fs_notu;
   Real	 _header_first_seen;
   Integer	 rv_c10_m_hdr_fs;
   Real	 rv_c12_source_profile;
   Integer	 rv_s66_adlperssn_count;
   Integer	 _in_dob;
   Integer	 yr_in_dob;
   Integer	 yr_in_dob_int;
   Integer	 rv_comb_age;
   Integer	 rv_f01_inp_addr_not_verified;
   Integer	 rv_l80_inp_avm_autoval;
   Integer	 rv_a46_curr_avm_autoval;
   Real	 rv_a49_curr_avm_chg_1yr;
   Real	 rv_a49_curr_avm_chg_1yr_pct;
   Integer	 rv_c13_curr_addr_lres;
   Integer	 rv_c14_addr_stability_v2;
   Integer	 rv_c13_max_lres;
   Integer	 rv_c14_addrs_5yr;
   Integer	 rv_c14_addrs_10yr;
   Integer	 rv_c14_addrs_per_adl_c6;
   Integer	 rv_c14_addrs_15yr;
   Integer	 rv_c22_inp_addr_occ_index;
   Integer	 rv_c22_inp_addr_owned_not_occ;
   Integer	 rv_a41_prop_owner;
   String	 rv_a41_a42_prop_owner_history;
   Integer	 rv_email_count;
   Integer	 rv_email_domain_free_count;
   Integer	 rv_email_domain_isp_count;
   Integer	 rv_i60_inq_count12;
   Integer	 rv_i60_credit_seeking;
   Integer	 rv_i60_inq_recency;
   Integer	 rv_i61_inq_collection_count12;
   Integer	 rv_i61_inq_collection_recency;
   Integer	 rv_i60_inq_auto_count12;
   Integer	 rv_i60_inq_auto_recency;
   Integer	 rv_i60_inq_banking_count12;
   Integer	 rv_i60_inq_mortgage_count12;
   Integer	 rv_i60_inq_hiriskcred_count12;
   Integer	 rv_i60_inq_hiriskcred_recency;
   Integer	 rv_i60_inq_prepaidcards_recency;
   Integer	 rv_i60_inq_retail_recency;
   Integer	 rv_i60_inq_retpymt_count12;
   Integer	 rv_i60_inq_retpymt_recency;
   Integer	 rv_i60_inq_comm_count12;
   Integer	 rv_i60_inq_comm_recency;
   Integer	 rv_l79_adls_per_addr_curr;
   Integer	 rv_l79_adls_per_apt_addr;
   Integer	 rv_l79_adls_per_sfd_addr;
   Integer	 rv_l79_adls_per_addr_c6;
   Integer	 rv_l79_adls_per_apt_addr_c6;
   Integer	 rv_l79_adls_per_sfd_addr_c6;
   Integer	 rv_c18_invalid_addrs_per_adl;
   Integer	 rv_c13_attr_addrs_recency;
   Real	 rv_d32_attr_felonies_recency;
   Integer	 rv_d34_attr_liens_recency;
   Integer	 iv_f00_nas_summary;
   Integer	 iv_fname_non_phn_src_ct;
   Integer	 iv_lname_non_phn_src_ct;
   Integer	 iv_full_name_non_phn_src_ct;
   String	 iv_full_name_ver_sources;
   Integer	 iv_addr_non_phn_src_ct;
   String	 iv_c22_addr_ver_sources;
   Integer	 iv_dob_src_ct;
   Boolean	 _nap_ver;
   Boolean	 _inf_ver;
   String	 iv_phn_addr_verified;
   String	 iv_l77_dwelltype;
   Integer	 iv_c13_avg_lres;
   Integer	 rv_f01_inp_add_house_num_match;
   Integer	 rv_c13_inp_addr_lres;
   Integer	 rv_c12_inp_addr_source_count;
   String	 iv_inp_addr_mortgage_type;
   String	 iv_inp_addr_financing_type;
   Integer	 iv_inp_add_avm_chg_1yr;
   Real	 iv_inp_add_avm_pct_chg_1yr;
   Integer	 iv_inp_add_avm_chg_2yr;
   Real	 iv_inp_add_avm_pct_chg_2yr;
   Integer	 iv_inp_add_avm_chg_3yr;
   Real	 iv_inp_add_avm_pct_chg_3yr;
   String	 mortgage_type;
   Boolean	 mortgage_present;
   String	 iv_curr_add_mortgage_type;
   String	 iv_curr_add_financing_type;
   Integer	 rv_a49_curr_add_avm_chg_2yr;
   Real	 rv_a49_curr_add_avm_pct_chg_2yr;
   Integer	 rv_a49_curr_add_avm_chg_3yr;
   Real	 rv_a49_curr_add_avm_pct_chg_3yr;
   Integer	 iv_prv_addr_lres;
   Real	 iv_prv_addr_avm_auto_val;
   Integer	 iv_a46_l77_addrs_move_traj;
   Integer	 iv_a46_l77_addrs_move_traj_index;
   Integer	 iv_unverified_addr_count;
   Integer	 iv_c14_addrs_per_adl;
   Integer	 rv_i60_inq_other_count12;
   Real	 rv_i60_inq_other_recency;
   Real	 rv_i62_inq_ssns_per_adl;
   Integer	 rv_i62_inq_addrs_per_adl;
   Integer	 rv_i62_inq_num_names_per_adl;
   Integer	 rv_i62_inq_phones_per_adl;
   Integer	 rv_i62_inq_dobs_per_adl;
   Integer	 br_first_seen_char;
   Integer	 _br_first_seen;
   Integer	 rv_mos_since_br_first_seen;
   Integer	 rv_br_active_phone_count;
   Integer	 iv_br_source_count;
   String	 rv_e58_br_dead_bus_x_active_phn;
   String	 br_company_title1;
   String	 br_company_title2;
   Integer	 rv_bus_leadership_title;
   Integer	 iv_d34_liens_unrel_cj_ct;
   Integer	 iv_d34_liens_unrel_ft_ct;
   Integer	 iv_d34_liens_unrel_sc_ct;
   Integer	 iv_college_tier;
   Boolean	 major_medical;
   Boolean	 major_science;
   Boolean	 major_liberal;
   Boolean	 major_business;
   Boolean	 major_unknown;
   String	 iv_college_major;
   String	 iv_college_type;
   String	 iv_college_code_x_type;
   String	 iv_college_file_type;
   String	 iv_prof_license_source;
   Integer	 iv_prof_license_category;
   Integer	 iv_prof_license_category_pl;
	 Integer	 nf_bus_addr_match_count;
   Integer	 nf_bus_phone_match;
   String	 adl_util_i;
   String	 adl_util_c;
   String	 adl_util_m;
   String	 nf_util_adl_summary;
   Integer	 nf_util_adl_count;
   String	 inp_util_i;
   String	 inp_util_c;
   String	 inp_util_m;
   String	 nf_util_add_input_summary;
   String	 curr_util_i;
   String	 curr_util_c;
   String	 curr_util_m;
   String	 nf_util_add_curr_summary;
   Real	 nf_add_input_mobility_index;
   Real	 nf_add_input_nhood_bus_pct;
   Real	 nf_add_input_nhood_mfd_pct;
   Real	 nf_add_input_nhood_sfd_pct;
   Real	 add_input_nhood_prop_sum;
   Real	 nf_add_input_nhood_vac_pct;
   Real	 nf_add_curr_mobility_index;
   Real	 nf_add_curr_nhood_bus_pct;
   Real	 nf_add_curr_nhood_mfd_pct;
   Real	 nf_add_curr_nhood_sfd_pct;
   Real	 add_curr_nhood_prop_sum;
   Real	 nf_add_curr_nhood_vac_pct;
   Integer	 nf_recent_disconnects;
   Integer	 nf_phone_ver_insurance;
   Integer	 nf_phone_ver_experian;
   Integer	 nf_addrs_per_ssn;
   Integer	 nf_phones_per_addr_curr;
   Integer	 nf_phones_per_apt_addr_curr;
   Integer	 nf_phones_per_sfd_addr_curr;
   Integer	 nf_addrs_per_ssn_c6;
   Integer	 nf_phones_per_addr_c6;
   Integer	 nf_phones_per_sfd_addr_c6;
   Integer	 nf_inq_count_day;
   Integer	 nf_inq_count_week;
   Integer	 nf_inq_count24;
   Integer	 nf_inq_auto_count_week;
   Integer	 nf_inq_auto_count24;
   Integer	 nf_inq_banking_count_day;
   Integer	 nf_inq_banking_count24;
   Integer	 nf_inq_collection_count_week;
   Integer	 nf_inq_collection_count24;
   Integer	 nf_inq_communications_count_week;
   Integer	 nf_inq_communications_count24;
   Integer	 nf_inq_highriskcredit_count_day;
   Integer	 nf_inq_highriskcredit_count_week;
   Integer	 nf_inq_highriskcredit_count24;
   Integer	 nf_inq_other_count_week;
   Integer	 nf_inq_other_count24;
   Integer	 nf_inq_prepaidcards_count24;
   Integer	 nf_inq_quizprovider_count_week;
   Integer	 nf_inq_quizprovider_count24;
   Integer	 nf_inq_retail_count24;
   Integer	 nf_inq_retailpayments_count24;
   Integer	 nf_inq_utilities_count24;
   Integer	 nf_inq_per_ssn;
   Integer	 nf_inq_adls_per_ssn;
   Integer	 nf_inq_lnames_per_ssn;
   Integer	 nf_inq_addrs_per_ssn;
   Integer	 nf_inq_dobs_per_ssn;
   Integer	 nf_inq_per_addr;
   Integer	 nf_inq_per_apt_addr;
   Integer	 nf_inq_per_sfd_addr;
   Integer	 nf_inq_adls_per_addr;
   Integer	 nf_inq_adls_per_apt_addr;
   Integer	 nf_inq_adls_per_sfd_addr;
   Integer	 nf_inq_lnames_per_apt_addr;
   Integer	 nf_inq_lnames_per_sfd_addr;
   Integer	 nf_inq_ssns_per_addr;
   Integer	 nf_inq_ssns_per_apt_addr;
   Integer	 nf_inq_ssns_per_sfd_addr;
   Integer	 nf_inq_per_phone;
   Integer	 nf_inq_adls_per_phone;
   Integer	 nf_attr_arrest_recency;
   Integer	 _liens_unrel_cj_first_seen;
   Integer	 nf_mos_liens_unrel_cj_fseen;
   Integer	 _liens_unrel_cj_last_seen;
   Integer	 nf_mos_liens_unrel_cj_lseen;
   Integer	 nf_liens_unrel_cj_total_amt;
   Integer	 _liens_rel_cj_last_seen;
   Integer	 nf_mos_liens_rel_cj_lseen;
   Integer	 nf_liens_rel_cj_total_amt;
   Integer	 _liens_unrel_ft_last_seen;
   Integer	 nf_mos_liens_unrel_ft_lseen;
   Integer	 nf_liens_unrel_ft_total_amt;
   Integer	 _liens_rel_ft_first_seen;
   Integer	 nf_mos_liens_rel_ft_fseen;
   Integer	 _liens_rel_ft_last_seen;
   Integer	 nf_mos_liens_rel_ft_lseen;
   Integer	 _liens_unrel_fc_first_seen;
   Integer	 nf_mos_liens_unrel_fc_fseen;
   Integer	 nf_liens_unrel_fc_total_amt;
   Integer	 nf_liens_unrel_o_total_amt;
   Integer	 _liens_unrel_ot_last_seen;
   Integer	 nf_mos_liens_unrel_ot_lseen;
   Integer	 nf_liens_unrel_ot_total_amt;
   Integer	 _liens_unrel_sc_last_seen;
   Integer	 nf_mos_liens_unrel_sc_lseen;
   Integer	 nf_liens_unrel_sc_total_amt;
   Integer	 _liens_rel_sc_first_seen;
   Integer	 nf_mos_liens_rel_sc_fseen;
   Integer	 _liens_rel_sc_last_seen;
   Integer	 nf_mos_liens_rel_sc_lseen;
   Integer	 nf_liens_rel_sc_total_amt;
   Integer	 nf_liens_unrel_st_ct;
   Integer	 _liens_unrel_st_first_seen;
   Integer	 nf_mos_liens_unrel_st_fseen;
   Integer	 _liens_unrel_st_last_seen;
   Integer	 nf_mos_liens_unrel_st_lseen;
   Integer	 nf_liens_unrel_st_total_amt;
   Integer	 _foreclosure_last_date;
   Integer	 nf_mos_foreclosure_lseen;
   Integer	 iv_estimated_income;
   Integer	 iv_wealth_index;
   Integer	 nf_hh_members_ct;
   Integer	 nf_hh_property_owners_ct;
   Real	 nf_hh_pct_property_owners;
   Integer	 nf_hh_age_65_plus;
   Integer	 nf_hh_age_30_plus;
   Integer	 nf_hh_age_18_plus;
   Integer	 nf_hh_age_lt18;
   Integer	 nf_hh_collections_ct;
   Real	 nf_hh_collections_ct_avg;
   Integer	 nf_hh_workers_paw;
   Real	 nf_hh_workers_paw_pct;
   Integer	 nf_hh_payday_loan_users;
   Real	 nf_hh_payday_loan_users_pct;
   Real	 nf_hh_members_w_derog_pct;
   Integer	 nf_hh_tot_derog;
   Real	 nf_hh_tot_derog_avg;
   Real	 nf_hh_bankruptcies_pct;
   Integer	 nf_hh_lienholders;
   Real	 nf_hh_lienholders_pct;
   Integer	 nf_hh_prof_license_holders;
   Integer	 nf_hh_criminals;
   Real	 nf_hh_criminals_pct;
   Integer	 nf_hh_college_attendees;
   Real	 nf_hh_college_attendees_pct;
   Integer	 nf_rel_count;
   Integer	 nf_average_rel_income;
   Integer	 nf_lowest_rel_income;
   Integer	 nf_highest_rel_income;
   Integer	 nf_average_rel_home_val;
   Integer	 nf_lowest_rel_home_val;
   Integer	 nf_highest_rel_home_val;
   Integer	 nf_average_rel_age;
   Integer	 nf_youngest_rel_age;
   Integer	 nf_oldest_rel_age;
   Integer	 nf_average_rel_education;
   Integer	 nf_lowest_rel_education;
   Integer	 nf_average_rel_criminal_dist;
   Integer	 nf_furthest_rel_criminal;
   Integer	 nf_average_rel_distance;
   Integer	 nf_rel_bankrupt_count;
   Integer	 nf_rel_criminal_count;
   Integer	 nf_rel_felony_count;
   Integer	 nf_pct_rel_with_bk;
   Integer	 nf_pct_rel_with_criminal;
   Integer	 nf_pct_rel_with_felony;
   Integer	 nf_rel_derog_summary;
   Integer	 nf_pct_rel_prop_owned;
   Integer	 nf_pct_rel_prop_sold;
   Integer	 nf_current_count;
   Integer	 nf_historical_count;
   String	 nf_historic_x_current_ct;
   Unsigned	 nf_acc_damage_amt_total;
   Integer	 _acc_last_seen;
   Integer	 nf_mos_acc_lseen;
   Integer	 nf_accident_recency;
   Integer	 nf_fp_idrisktype;
   Integer	 nf_fp_idveraddressnotcurrent;
   Integer	 nf_fp_sourcerisktype;
   Integer	 nf_fp_varrisktype;
   Integer	 nf_fp_varmsrcssnunrelcount;
   Integer	 nf_fp_srchvelocityrisktype;
   Integer	 nf_fp_srchunvrfdssncount;
   Integer	 nf_fp_srchunvrfdaddrcount;
   Integer	 nf_fp_srchunvrfddobcount;
   Integer nf_fp_srchunvrfdphonecount;
   Integer	 nf_fp_srchfraudsrchcountyr;
   Integer	 nf_fp_srchfraudsrchcountmo;
   Integer	 nf_fp_srchfraudsrchcountwk;
   Integer	 nf_fp_srchfraudsrchcountday;
   Integer	 nf_fp_assocsuspicousidcount;
   Integer	 nf_fp_validationrisktype;
   Integer	 nf_fp_divrisktype;
   Integer	 nf_fp_divaddrsuspidcountnew;
   Integer	 nf_fp_srchcomponentrisktype;
   Integer	 nf_fp_srchssnsrchcountmo;
   Integer	 nf_fp_srchssnsrchcountwk;
   Integer	 nf_fp_srchssnsrchcountday;
   Integer	 nf_fp_srchaddrsrchcountmo;
   Integer	 nf_fp_srchaddrsrchcountwk;
   Integer	 nf_fp_srchaddrsrchcountday;
   Integer	 nf_fp_srchphonesrchcountmo;
   Integer	 nf_fp_srchphonesrchcountwk;
   Integer	 nf_fp_srchphonesrchcountday;
   Integer	 nf_fp_componentcharrisktype;
   Integer	 nf_fp_inputaddractivephonelist;
   Integer	 nf_fp_addrchangeincomediff;
   Integer	 nf_fp_addrchangevaluediff;
   Integer	 nf_fp_addrchangecrimediff;
   String	 nf_fp_addrchangeecontraj;
   Integer	 nf_fp_curraddractivephonelist;
   Integer	 nf_fp_curraddrmedianincome;
   Integer	 nf_fp_curraddrmedianvalue;
   Integer	 nf_fp_curraddrmurderindex;
   Integer	 nf_fp_curraddrcartheftindex;
   Integer	 nf_fp_curraddrburglaryindex;
   Integer	 nf_fp_curraddrcrimeindex;
   Integer	 nf_fp_prevaddrageoldest;
   Integer	 nf_fp_prevaddrlenofres;
   Integer	 nf_fp_prevaddrmedianincome;
   Integer	 nf_fp_prevaddrmedianvalue;
   Integer	 nf_fp_prevaddrmurderindex;
   Integer	 nf_fp_prevaddrcartheftindex;
   Integer	 nf_fp_prevaddrburglaryindex;
   Integer	 nf_fp_prevaddrcrimeindex;
   Integer	 record_count;
   Integer	 bureau_adl_eq_fseen_pos;
   String	 bureau_adl_fseen_eq;
   Integer	 _bureau_adl_fseen_eq;
   Integer	 bureau_adl_en_fseen_pos;
   String	 bureau_adl_fseen_en;
   Integer	 _bureau_adl_fseen_en;
   Integer bureau_adl_ts_fseen_pos;
   String	 bureau_adl_fseen_ts;
   Integer	 _bureau_adl_fseen_ts;
   Integer	 bureau_adl_tu_fseen_pos;
   String	 bureau_adl_fseen_tu;
   Integer	 _bureau_adl_fseen_tu;
   Integer	 bureau_adl_tn_fseen_pos;
   String	 bureau_adl_fseen_tn;
   Integer	 _bureau_adl_fseen_tn;
   Integer	 _src_bureau_adl_fseen_all;
   Integer	 credit_bureau_oldest;
   Integer	 num_sources;
   Integer	 nf_qb4987_synthetic_index;
   Boolean	 bureau_;
   Boolean	 behavioral_;
   Boolean	 government_;
   String30	 nf_source_type;
   Integer	 nf_number_non_bureau_sources;
   Integer	 nf_number_bureau_sources;
   Integer	 nf_inq_per_ssn_nas_479;
   Integer	 nf_inq_per_add_nas_479;
   Boolean	 _add_not_ver;
   Integer	 nf_inq_add_per_ssn_nas_479;
   Integer	 lic_adl_d_count_pos;
   Integer	 lic_adl_count_d;
   Integer	 lic_adl_dl_count_pos;
   Integer	 lic_adl_count_dl;
   Real	 _src_vehx_adl_count;
   Real	 iv_src_drivers_lic_adl_count;
   String	 iv_dl_val_flag;
   Integer	 voter_adl_v_count_pos;
   Integer	 iv_src_voter_adl_count;
   Integer	 vote_adl_vo_lseen_pos;
   String	 vote_adl_lseen_vo;
   Integer	 _vote_adl_lseen_vo;
   Integer	 _src_vote_adl_lseen;
   Integer	 iv_mos_src_voter_adl_lseen;
   Real	 final_score_0;
   Real	 final_score_1;
   Real	 final_score_2;
   Real	 final_score_3;
   Real	 final_score_4;
   Real	 final_score_5;
   Real	 final_score_6;
   Real	 final_score_7;
   Real	 final_score_8;
   Real	 final_score_9;
   Real	 final_score_10;
   Real	 final_score_11;
   Real	 final_score_12;
   Real	 final_score_13;
   Real	 final_score_14;
   Real	 final_score_15;
   Real	 final_score_16;
   Real	 final_score_17;
   Real	 final_score_18;
   Real	 final_score_19;
   Real	 final_score_20;
   Real	 final_score_21;
   Real	 final_score_22;
   Real	 final_score_23;
   Real	 final_score_24;
   Real	 final_score_25;
   Real	 final_score_26;
   Real	 final_score_27;
   Real	 final_score_28;
   Real	 final_score_29;
   Real	 final_score_30;
   Real	 final_score_31;
   Real	 final_score_32;
   Real	 final_score_33;
   Real	 final_score_34;
   Real	 final_score_35;
   Real	 final_score_36;
   Real	 final_score_37;
   Real	 final_score_38;
   Real	 final_score_39;
   Real	 final_score_40;
   Real	 final_score_41;
   Real	 final_score_42;
   Real	 final_score_43;
   Real	 final_score_44;
   Real	 final_score_45;
   Real	 final_score_46;
   Real	 final_score_47;
   Real	 final_score_48;
   Real	 final_score_49;
   Real	 final_score_50;
   Real	 final_score_51;
   Real	 final_score_52;
   Real	 final_score_53;
   Real	 final_score_54;
   Real	 final_score_55;
   Real	 final_score_56;
   Real	 final_score_57;
   Real	 final_score_58;
   Real	 final_score_59;
   Real	 final_score_60;
   Real	 final_score_61;
   Real	 final_score_62;
   Real	 final_score_63;
   Real	 final_score_64;
   Real	 final_score_65;
   Real	 final_score_66;
   Real	 final_score_67;
   Real	 final_score_68;
   Real	 final_score_69;
   Real	 final_score_70;
   Real	 final_score_71;
   Real	 final_score_72;
   Real	 final_score_73;
   Real	 final_score_74;
   Real	 final_score_75;
   Real	 final_score_76;
   Real	 final_score_77;
   Real	 final_score_78;
   Real	 final_score_79;
   Real	 final_score_80;
   Real	 final_score_81;
   Real	 final_score_82;
   Real	 final_score_83;
   Real	 final_score_84;
   Real	 final_score_85;
   Real	 final_score_86;
   Real	 final_score_87;
   Real	 final_score_88;
   Real	 final_score_89;
   Real	 final_score_90;
   Real	 final_score_91;
   Real	 final_score_92;
   Real	 final_score_93;
   Real	 final_score_94;
   Real	 final_score_95;
   Real	 final_score_96;
   Real	 final_score_97;
   Real	 final_score_98;
   Real	 final_score_99;
   Real	 final_score_100;
   Real	 final_score_101;
   Real	 final_score_102;
   Real	 final_score_103;
   Real	 final_score_104;
   Real	 final_score_105;
   Real	 final_score_106;
   Real	 final_score_107;
   Real	 final_score_108;
   Real	 final_score_109;
   Real	 final_score_110;
   Real	 final_score_111;
   Real	 final_score_112;
   Real	 final_score_113;
   Real	 final_score_114;
   Real	 final_score_115;
   Real	 final_score_116;
   Real	 final_score_117;
   Real	 final_score_118;
   Real	 final_score_119;
   Real	 final_score_120;
   Real	 final_score_121;
   Real	 final_score_122;
   Real	 final_score_123;
   Real	 final_score_124;
   Real	 final_score_125;
   Real	 final_score_126;
   Real	 final_score_127;
   Real	 final_score_128;
   Real	 final_score_129;
   Real	 final_score_130;
   Real	 final_score_131;
   Real	 final_score_132;
   Real	 final_score_133;
   Real	 final_score_134;
   Real	 final_score_135;
   Real	 final_score_136;
   Real	 final_score_137;
   Real	 final_score_138;
   Real	 final_score_139;
   Real	 final_score_140;
   Real	 final_score_141;
   Real	 final_score_142;
   Real	 final_score_143;
   Real	 final_score_144;
   Real	 final_score_145;
   Real	 final_score_146;
   Real	 final_score_147;
   Real	 final_score_148;
   Real	 final_score_149;
   Real	 final_score_150;
   Real	 final_score_151;
   Real	 final_score_152;
   Real	 final_score_153;
   Real	 final_score_154;
   Real	 final_score_155;
   Real	 final_score_156;
   Real	 final_score_157;
   Real	 final_score_158;
   Real	 final_score_159;
   Real	 final_score_160;
   Real	 final_score_161;
   Real	 final_score_162;
   Real	 final_score_163;
   Real	 final_score_164;
   Real	 final_score_165;
   Real	 final_score_166;
   Real	 final_score_167;
   Real	 final_score_168;
   Real	 final_score_169;
   Real	 final_score_170;
   Real	 final_score_171;
   Real	 final_score_172;
   Real	 final_score_173;
   Real	 final_score_174;
   Real	 final_score_175;
   Real	 final_score_176;
   Real	 final_score_177;
   Real	 final_score_178;
   Real	 final_score_179;
   Real	 final_score_180;
   Real	 final_score_181;
   Real	 final_score_182;
   Real	 final_score_183;
   Real	 final_score_184;
   Real	 final_score_185;
   Real	 final_score_186;
   Real	 final_score_187;
   Real	 final_score_188;
   Real	 final_score_189;
   Real	 final_score_190;
   Real	 final_score_191;
   Real	 final_score_192;
   Real	 final_score_193;
   Real	 final_score_194;
   Real	 final_score_195;
   Real	 final_score_196;
   Real	 final_score_197;
   Real	 final_score_198;
   Real	 final_score_199;
   Real	 final_score_200;
   Real	 final_score_201;
   Real	 final_score_202;
   Real	 final_score_203;
   Real	 final_score_204;
   Real	 final_score_205;
   Real	 final_score_206;
   Real	 final_score_207;
   Real	 final_score_208;
   Real	 final_score_209;
   Real	 final_score_210;
   Real	 final_score_211;
   Real	 final_score_212;
   Real	 final_score_213;
   Real	 final_score_214;
   Real	 final_score_215;
   Real	 final_score_216;
   Real	 final_score_217;
   Real	 final_score_218;
   Real	 final_score_219;
   Real	 final_score_220;
   Real	 final_score_221;
   Real	 final_score_222;
   Real	 final_score_223;
   Real	 final_score_224;
   Real	 final_score_225;
   Real	 final_score_226;
   Real	 final_score_227;
   Real	 final_score_228;
   Real	 final_score_229;
   Real	 final_score_230;
   Real	 final_score_231;
   Real	 final_score_232;
   Real	 final_score_233;
   Real	 final_score_234;
   Real	 final_score_235;
   Real	 final_score_236;
   Real	 final_score_237;
   Real	 final_score_238;
   Real	 final_score_239;
   Real	 final_score_240;
   Real	 final_score_241;
   Real	 final_score_242;
   Real	 final_score_243;
   Real	 final_score_244;
   Real	 final_score_245;
   Real	 final_score_246;
   Real	 final_score_247;
   Real	 final_score_248;
   Real	 final_score_249;
   Real	 final_score_250;
   Real	 final_score_251;
   Real	 final_score_252;
   Real	 final_score_253;
   Real	 final_score_254;
   Real	 final_score_255;
   Real	 final_score_256;
   Real	 final_score_257;
   Real	 final_score_258;
   Real	 final_score_259;
   Real	 final_score_260;
   Real	 final_score_261;
   Real	 final_score_262;
   Real	 final_score_263;
   Real	 final_score_264;
   Real	 final_score_265;
   Real	 final_score_266;
   Real	 final_score_267;
   Real	 final_score_268;
   Real	 final_score_269;
   Real	 final_score_270;
   Real	 final_score_271;
   Real	 final_score_272;
   Real	 final_score_273;
   Real	 final_score_274;
   Real	 final_score_275;
   Real	 final_score_276;
   Real	 final_score_277;
   Real	 final_score_278;
   Real	 final_score_279;
   Real	 final_score_280;
   Real	 final_score_281;
   Real	 final_score_282;
   Real	 final_score_283;
   Real	 final_score_284;
   Real	 final_score_285;
   Real	 final_score_286;
   Real	 final_score_287;
   Real	 final_score_288;
   Real	 final_score_289;
   Real	 final_score_290;
   Real	 final_score_291;
   Real	 final_score_292;
   Real	 final_score_293;
   Real	 final_score_294;
   Real	 final_score_295;
   Real	 final_score_296;
   Real	 final_score_297;
   Real	 final_score_298;
   Real	 final_score_299;
   Real	 final_score_300;
   Real	 final_score_301;
   Real	 final_score_302;
   Real	 final_score_303;
   Real	 final_score_304;
   Real	 final_score_305;
   Real	 final_score_306;
   Real	 final_score_307;
   Real	 final_score_308;
   Real	 final_score_309;
   Real	 final_score_310;
   Real	 final_score_311;
   Real	 final_score_312;
   Real	 final_score_313;
   Real	 final_score_314;
   Real	 final_score_315;
   Real	 final_score_316;
   Real	 final_score_317;
   Real	 final_score_318;
   Real	 final_score_319;
   Real	 final_score_320;
   Real	 final_score_321;
   Real	 final_score_322;
   Real	 final_score_323;
   Real	 final_score_324;
   Real	 final_score_325;
   Real	 final_score_326;
   Real	 final_score_327;
   Real	 final_score_328;
   Real	 final_score_329;
   Real	 final_score_330;
   Real	 final_score_331;
   Real	 final_score_332;
   Real	 final_score_333;
   Real	 final_score_334;
   Real	 final_score_335;
   Real	 final_score_336;
   Real	 final_score_337;
   Real	 final_score_338;
   Real	 final_score_339;
   Real	 final_score_340;
   Real	 final_score_341;
   Real	 final_score_342;
   Real	 final_score_343;
   Real	 final_score_344;
   Real	 final_score_345;
   Real	 final_score_346;
   Real	 final_score_347;
   Real	 final_score_348;
   Real	 final_score_349;
   Real	 final_score_350;
   Real	 final_score_351;
   Real	 final_score_352;
   Real	 final_score_353;
   Real	 final_score_354;
   Real	 final_score_355;
   Real	 final_score_356;
   Real	 final_score_357;
   Real	 final_score_358;
   Real	 final_score_359;
   Real	 final_score_360;
   Real	 final_score_361;
   Real	 final_score_362;
   Real	 final_score_363;
   Real	 final_score_364;
   Real	 final_score_365;
   Real	 final_score_366;
   Real	 final_score_367;
   Real	 final_score_368;
   Real	 final_score_369;
   Real	 final_score_370;
   Real	 final_score_371;
   Real	 final_score_372;
   Real	 final_score_373;
   Real	 final_score_374;
   Real	 final_score_375;
   Real	 final_score_376;
   Real	 final_score_377;
   Real	 final_score_378;
   Real	 final_score_379;
   Real	 final_score_380;
   Real	 final_score_381;
   Real	 final_score_382;
   Real	 final_score_383;
   Real	 final_score_384;
   Real	 final_score_385;
   Real	 final_score_386;
   Real	 final_score_387;
   Real	 final_score_388;
   Real	 final_score_389;
   Real	 final_score_390;
   Real	 final_score_391;
   Real	 final_score_392;
   Real	 final_score_393;
   Real	 final_score_394;
   Real	 final_score_395;
   Real	 final_score_396;
   Real	 final_score_397;
   Real	 final_score_398;
   Real	 final_score_399;
   Real	 final_score_400;
   Real	 final_score_401;
   Real	 final_score_402;
   Real	 final_score_403;
   Real	 final_score_404;
   Real	 final_score_405;
   Real	 final_score_406;
   Real	 final_score_407;
   Real	 final_score_408;
   Real	 final_score_409;
   Real	 final_score_410;
   Real	 final_score_411;
   Real	 final_score_412;
   Real	 final_score_413;
   Real	 final_score_414;
   Real	 final_score_415;
   Real	 final_score_416;
   Real	 final_score_417;
   Real	 final_score_418;
   Real	 final_score_419;
   Real	 final_score_420;
   Real	 final_score_421;
   Real	 final_score_422;
   Real	 final_score_423;
   Real	 final_score_424;
   Real	 final_score_425;
   Real	 final_score_426;
   Real	 final_score_427;
   Real	 final_score_428;
   Real	 final_score_429;
   Real	 final_score_430;
   Real	 final_score_431;
   Real	 final_score_432;
   Real	 final_score_433;
   Real	 final_score_434;
   Real	 final_score_435;
   Real	 final_score_436;
   Real	 final_score_437;
   Real	 final_score_438;
   Real	 final_score_439;
   Real	 final_score_440;
   Real	 final_score_441;
   Real	 final_score_442;
   Real	 final_score_443;
   Real	 final_score_444;
   Real	 final_score_445;
   Real	 final_score_446;
   Real	 final_score_447;
   Real	 final_score_448;
   Real	 final_score_449;
   Real	 final_score_450;
   Real	 final_score_451;
   Real	 final_score_452;
   Real	 final_score_453;
   Real	 final_score_454;
   Real	 final_score_455;
   Real	 final_score_456;
   Real	 final_score_457;
   Real	 final_score_458;
   Real	 final_score_459;
   Real	 final_score_460;
   Real	 final_score_461;
   Real	 final_score_462;
   Real	 final_score_463;
   Real	 final_score_464;
   Real	 final_score_465;
   Real	 final_score_466;
   Real	 final_score_467;
   Real	 final_score_468;
   Real	 final_score_469;
   Real	 final_score_470;
   Real	 final_score_471;
   Real	 final_score_472;
   Real	 final_score_473;
   Real	 final_score_474;
   Real	 final_score_475;
   Real	 final_score_476;
   Real	 final_score_477;
   Real	 final_score_478;
   Real	 final_score_479;
   Real	 final_score_480;
   Real	 final_score_481;
   Real	 final_score_482;
   Real	 final_score_483;
   Real	 final_score_484;
   Real	 final_score_485;
   Real	 final_score_486;
   Real	 final_score_487;
   Real	 final_score_488;
   Real	 final_score_489;
   Real	 final_score_490;
   Real	 final_score_491;
   Real	 final_score_492;
   Real	 final_score_493;
   Real	 final_score_494;
   Real	 final_score_495;
   Real	 final_score_496;
   Real	 final_score_497;
   Real	 final_score_498;
   Real	 final_score_499;
   Real	 final_score_500;
   Real	 final_score_501;
   Real	 final_score_502;
   Real	 final_score_503;
   Real	 final_score_504;
   Real	 final_score_505;
   Real	 final_score_506;
   Real	 final_score_507;
   Real	 final_score_508;
   Real	 final_score_509;
   Real	 final_score_510;
   Real	 final_score_511;
   Real	 final_score_512;
   Real	 final_score_513;
   Real	 final_score_514;
   Real	 final_score_515;
   Real	 final_score_516;
   Real	 final_score_517;
   Real	 final_score_518;
   Real	 final_score_519;
   Real	 final_score_520;
   Real	 final_score_521;
   Real	 final_score_522;
   Real	 final_score_523;
   Real	 final_score_524;
   Real	 final_score_525;
   Real	 final_score_526;
   Real	 final_score_527;
   Real	 final_score_528;
   Real	 final_score_529;
   Real	 final_score_530;
   Real	 final_score_531;
   Real	 final_score_532;
   Real	 final_score_533;
   Real	 final_score_534;
   Real	 final_score_535;
   Real	 final_score_536;
   Real	 final_score_537;
   Real	 final_score_538;
   Real	 final_score_539;
   Real	 final_score_540;
   Real	 final_score_541;
   Real	 final_score_542;
   Real	 final_score_543;
   Real	 final_score_544;
   Real	 final_score_545;
   Real	 final_score_546;
   Real	 final_score_547;
   Real	 final_score_548;
   Real	 final_score_549;
   Real	 final_score_550;
   Real	 final_score_551;
   Real	 final_score_552;
   Real	 final_score_553;
   Real	 final_score_554;
   Real	 final_score_555;
   Real	 final_score_556;
   Real	 final_score_557;
   Real	 final_score_558;
   Real	 final_score_559;
   Real	 final_score_560;
   Real	 final_score_561;
   Real	 final_score_562;
   Real	 final_score_563;
   Real	 final_score_564;
   Real	 final_score_565;
   Real	 final_score_566;
   Real	 final_score_567;
   Real	 final_score_568;
   Real	 final_score_569;
   Real	 final_score_570;
   Real	 final_score_571;
   Real	 final_score_572;
   Real	 final_score_573;
   Real	 final_score_574;
   Real	 final_score_575;
   Real	 final_score_576;
   Real	 final_score_577;
   Real	 final_score_578;
   Real	 final_score_579;
   Real	 final_score_580;
   Real	 final_score_581;
   Real	 final_score_582;
   Real	 final_score_583;
   Real	 final_score_584;
   Real	 final_score_585;
   Real	 final_score_586;
   Real	 final_score_587;
   Real	 final_score_588;
   Real	 final_score_589;
   Real	 final_score_590;
   Real	 final_score_591;
   Real	 final_score_592;
   Real	 final_score_593;
   Real	 final_score_594;
   Real	 final_score_595;
   Real	 final_score_596;
   Real	 final_score_597;
   Real	 final_score_598;
   Real	 final_score_599;
   Real	 final_score_600;
   Real	 final_score_601;
   Real	 final_score_602;
   Real	 final_score_603;
   Real	 final_score_604;
   Real	 final_score_605;
   Real	 final_score_606;
   Real	 final_score_607;
   Real	 final_score_608;
   Real	 final_score_609;
   Real	 final_score_610;
   Real	 final_score_611;
   Real	 final_score_612;
   Real	 final_score_613;
   Real	 final_score_614;
   Real	 final_score_615;
   Real	 final_score_616;
   Real	 final_score_617;
   Real	 final_score_618;
   Real	 final_score_619;
   Real	 final_score_620;
   Real	 final_score_621;
   Real	 final_score_622;
   Real	 final_score_623;
   Real	 final_score_624;
   Real	 final_score_625;
   Real	 final_score_626;
   Real	 final_score_627;
   Real	 final_score_628;
   Real	 final_score_629;
   Real	 final_score_630;
   Real	 final_score_631;
   Real	 final_score_632;
   Real	 final_score_633;
   Real	 final_score_634;
   Real	 final_score_635;
   Real	 final_score_636;
   Real	 final_score_637;
   Real	 final_score_638;
   Real	 final_score_639;
   Real	 final_score_640;
   Real	 final_score_641;
   Real	 final_score_642;
   Real	 final_score_643;
   Real	 final_score_644;
   Real	 final_score_645;
   Real	 final_score_646;
   Real	 final_score_647;
   Real	 final_score_648;
   Real	 final_score_649;
   Real	 final_score_650;
   Real	 final_score_651;
   Real	 final_score_652;
   Real	 final_score_653;
   Real	 final_score_654;
   Real	 final_score_655;
   Real	 final_score_656;
   Real	 final_score_657;
   Real	 final_score_658;
   Real	 final_score_659;
   Real	 final_score_660;
   Real	 final_score_661;
   Real	 final_score_662;
   Real	 final_score_663;
   Real	 final_score_664;
   Real	 final_score_665;
   Real	 final_score_666;
   Real	 final_score_667;
   Real	 final_score_668;
   Real	 final_score_669;
   Real	 final_score_670;
   Real	 final_score_671;
   Real	 final_score_672;
   Real	 final_score_673;
   Real	 final_score_674;
   Real	 final_score_675;
   Real	 final_score_676;
   Real	 final_score_677;
   Real	 final_score_678;
   Real	 final_score_679;
   Real	 final_score_680;
   Real	 final_score_681;
   Real	 final_score_682;
   Real	 final_score_683;
   Real	 final_score_684;
   Real	 final_score_685;
   Real	 final_score_686;
   Real	 final_score_687;
   Real	 final_score_688;
   Real	 final_score_689;
   Real	 final_score_690;
   Real	 final_score_691;
   Real	 final_score_692;
   Real	 final_score_693;
   Real	 final_score_694;
   Real	 final_score_695;
   Real	 final_score_696;
   Real	 final_score_697;
   Real	 final_score_698;
   Real	 final_score_699;
   Real	 final_score_700;
   Real	 final_score_701;
   Real	 final_score_702;
   Real	 final_score_703;
   Real	 final_score_704;
   Real	 final_score_705;
   Real	 final_score_706;
   Real	 final_score_707;
   Real	 final_score_708;
   Real	 final_score_709;
   Real	 final_score_710;
   Real	 final_score_711;
   Real	 final_score_712;
   Real	 final_score_713;
   Real	 final_score_714;
   Real	 final_score_715;
   Real	 final_score_716;
   Real	 final_score_717;
   Real	 final_score_718;
   Real	 final_score_719;
   Real	 final_score_720;
   Real	 final_score_721;
   Real	 final_score_722;
   Real	 final_score_723;
   Real	 final_score_724;
   Real	 final_score_725;
   Real	 final_score_726;
   Real	 final_score_727;
   Real	 final_score_728;
   Real	 final_score_729;
   Real	 final_score_730;
   Real	 final_score_731;
   Real	 final_score_732;
   Real	 final_score_733;
   Real	 final_score_734;
   Real	 final_score_735;
   Real	 final_score_736;
   Real	 final_score_737;
   Real	 final_score_738;
   Real	 final_score_739;
   Real	 final_score_740;
   Real	 final_score_741;
   Real	 final_score_742;
   Real	 final_score_743;
   Real	 final_score_744;
   Real	 final_score_745;
   Real	 final_score_746;
   Real	 final_score_747;
   Real	 final_score_748;
   Real	 final_score_749;
   Real	 final_score_750;
   Real	 final_score_751;
   Real	 final_score_752;
   Real	 final_score_753;
   Real	 final_score_754;
   Real	 final_score_755;
   Real	 final_score_756;
   Real	 final_score_757;
   Real	 final_score_758;
   Real	 final_score_759;
   Real	 final_score_760;
   Real	 final_score_761;
   Real	 final_score_762;
   Real	 final_score_763;
   Real	 final_score_764;
   Real	 final_score_765;
   Real	 final_score_766;
   Real	 final_score_767;
   Real	 final_score_768;
   Real	 final_score_769;
   Real	 final_score_770;
   Real	 final_score_771;
   Real	 final_score_772;
   Real	 final_score_773;
   Real	 final_score_774;
   Real	 final_score_775;
   Real	 final_score_776;
   Real	 final_score_777;
   Real	 final_score_778;
   Real	 final_score_779;
   Real	 final_score_780;
   Real	 final_score_781;
   Real	 final_score_782;
   Real	 final_score_783;
   Real	 final_score_784;
   Real	 final_score_785;
   Real	 final_score_786;
   Real	 final_score_787;
   Real	 final_score_788;
   Real	 final_score_789;
   Real	 final_score_790;
   Real	 final_score_791;
   Real	 final_score_792;
   Real	 final_score_793;
   Real	 final_score_794;
   Real	 final_score_795;
   Real	 final_score_796;
   Real	 final_score_797;
   Real	 final_score_798;
   Real	 final_score_799;
   Real	 final_score_800;
   Real	 final_score_801;
   Real	 final_score_802;
   Real	 final_score_803;
   Real	 final_score_804;
   Real	 final_score_805;
   Real	 final_score_806;
   Real	 final_score_807;
   Real	 final_score_808;
   Real	 final_score_809;
   Real	 final_score_810;
   Real	 final_score_811;
   Real	 final_score_812;
   Real	 final_score_813;
   Real	 final_score_814;
   Real	 final_score_815;
   Real	 final_score_816;
   Real	 final_score_817;
   Real	 final_score_818;
   Real	 final_score_819;
   Real	 final_score_820;
   Real	 final_score_821;
   Real	 final_score_822;
   Real	 final_score_823;
   Real	 final_score_824;
   Real	 final_score_825;
   Real	 final_score_826;
   Real	 final_score_827;
   Real	 final_score_828;
   Real	 final_score_829;
   Real	 final_score_830;
   Real	 final_score_831;
   Real	 final_score_832;
   Real	 final_score_833;
   Real	 final_score_834;
   Real	 final_score_835;
   Real	 final_score_836;
   Real	 final_score_837;
   Real	 final_score_838;
   Real	 final_score_839;
   Real	 final_score_840;
   Real	 final_score_841;
   Real	 final_score_842;
   Real	 final_score_843;
   Real	 final_score_844;
   Real	 final_score_845;
   Real	 final_score_846;
   Real	 final_score_847;
   Real	 final_score_848;
   Real	 final_score_849;
   Real	 final_score_850;
   Real	 final_score_851;
   Real	 final_score_852;
   Real	 final_score_853;
   Real	 final_score_854;
   Real	 final_score_855;
   Real	 final_score_856;
   Real	 final_score_857;
   Real	 final_score_858;
   Real	 final_score_859;
   Real	 final_score_860;
   Real	 final_score_861;
   Real	 final_score_862;
   Real	 final_score_863;
   Real	 final_score_864;
   Real	 final_score_865;
   Real	 final_score_866;
   Real	 final_score_867;
   Real	 final_score_868;
   Real	 final_score_869;
   Real	 final_score_870;
   Real	 final_score_871;
   Real	 final_score_872;
   Real	 final_score_873;
   Real	 final_score_874;
   Real	 final_score;
   Integer	 base;
   Integer	 pts;
   Real	 lgt;
   Integer	 fp1611_1_0;
   Boolean	 _ver_src_ds;
   Boolean	 _ver_src_de;
   Boolean	 _ver_src_eq;
   Boolean	 _ver_src_en;
   Boolean	 _ver_src_tn;
   Boolean	 _ver_src_tu;
   Real	 _credit_source_cnt;
   Real	 _ver_src_cnt;
   Boolean	 _bureauonly;
   Boolean	 _derog;
   Boolean	 _deceased;
   Boolean	 _ssnpriortodob;
   Boolean	 _inputmiskeys;
   Boolean	 _multiplessns;
   Real	 _hh_strikes;
   Integer	 stolenid;
   Integer	 manipulatedid;
   Integer	 manipulatedidpt2;
   Integer	 syntheticid;
   Integer	 suspiciousactivity;
   Integer	 vulnerablevictim;
   Integer	 friendlyfraud;
   Integer	 stolenc_fp1611_1_0;
   Integer	 manip2c_fp1611_1_0;
   Integer	 synthc_fp1611_1_0;
   Integer	 suspactc_fp1611_1_0;
   Integer	 vulnvicc_fp1611_1_0;
   Integer	 friendlyc_fp1611_1_0;
   Integer	 custstolidindex;
   Integer	 custmanipidindex;
   Integer	 custsynthidindex;
   Integer	 custsuspactindex;
   Integer	 custvulnvicindex;
   Integer	 custfriendfrdindex;


	models.layouts.layout_fp1109;
			Risk_Indicators.Layout_Boca_Shell clam;
			END;
			
    layout_debug doModel( clam le, easi.Key_Easi_Census rt ) := TRANSFORM
  #else
    models.layouts.layout_fp1109 doModel( clam le, easi.Key_Easi_Census rt ) := TRANSFORM
		
  #end	
	
	upcase := stringlib.stringtouppercase;	

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
   rc_dl_val_flag                   := if(isFCRA, '', le.iid.drlcvalflag);
   rc_ssndod                        := le.ssn_verification.validation.deceasedDate;
   rc_hriskphoneflag                := le.iid.hriskphoneflag;
   rc_hphonetypeflag                := le.iid.hphonetypeflag;
   rc_phonevalflag                  := le.iid.phonevalflag;
   rc_hphonevalflag                 := le.iid.hphonevalflag;
   rc_hriskaddrflag                 := le.iid.hriskaddrflag;
   rc_decsflag                      := le.iid.decsflag;
   rc_ssndobflag                    := le.iid.socsdobflag;
   rc_pwssndobflag                  := le.iid.pwsocsdobflag;
   rc_ssnvalflag                    := le.iid.socsvalflag;
   rc_pwssnvalflag                  := le.iid.pwsocsvalflag;
   rc_addrvalflag                   := le.iid.addrvalflag;
   rc_dwelltype                     := le.iid.dwelltype;
   rc_fnamecount                    := le.iid.firstcount;
   rc_lnamecount                    := if(isFCRA, 0, le.iid.lastcount);
   rc_addrcount                     := le.iid.addrcount;
   rc_phoneaddrcount                := le.iid.phoneaddrcount;
   rc_phoneaddr_addrcount           := le.iid.phoneaddr_addrcount;
   rc_ssnmiskeyflag                 := le.iid.socsmiskeyflag;
   rc_addrmiskeyflag                := le.iid.addrmiskeyflag;
   rc_addrcommflag                  := le.iid.addrcommflag;
   rc_hrisksic                      := le.iid.hrisksic;
   rc_hrisksicphone                 := le.iid.hrisksicphone;
   rc_disthphoneaddr                := le.iid.disthphoneaddr;
   rc_phonetype                     := le.iid.phonetype;
   rc_ziptypeflag                   := le.iid.ziptypeflag;
   combo_dobscore                   := le.iid.combo_dobscore;
   combo_dobcount                   := le.iid.combo_dobcount;
   hdr_source_profile               := le.source_profile;
   ver_sources                      := le.header_summary.ver_sources;
   ver_sources_first_seen           := le.header_summary.ver_sources_first_seen_date;
   ver_sources_last_seen            := le.header_summary.ver_sources_last_seen_date;
   ver_sources_count                := le.header_summary.ver_sources_recordcount;
   dl_avail                         := le.available_sources.dl;
   voter_avail                      := le.available_sources.voter;
   bus_addr_match_count             := le.business_header_address_summary.bus_addr_match_cnt;
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
   util_adl_type_list               := le.utility.utili_adl_type;
   util_adl_count                   := le.utility.utili_adl_count;
   util_add_input_type_list         := le.utility.utili_addr1_type;
   util_add_curr_type_list          := le.utility.utili_addr2_type;
   add_input_address_score          := le.address_verification.input_address_information.address_score;
   add_input_house_number_match     := le.address_verification.input_address_information.house_number_match;
   add_input_isbestmatch            := le.address_verification.input_address_information.isbestmatch;
   add_input_lres                   := le.lres;
   add_input_addr_not_verified      := le.address_verification.inputAddr_not_verified;
   add_input_owned_not_occ          := le.address_verification.inputaddr_owned_not_occupied;
   add_input_occ_index              := le.address_verification.inputaddr_occupancy_index;
   add_input_advo_vacancy           := le.advo_input_addr.Address_Vacancy_Indicator;
   add_input_advo_res_or_bus        := le.advo_input_addr.Residential_or_Business_Ind;
   add_input_avm_auto_val           := le.avm.input_address_information.avm_automated_valuation;
   add_input_avm_auto_val_2         := le.avm.input_address_information.avm_automated_valuation2;
   add_input_avm_auto_val_3         := le.avm.input_address_information.avm_automated_valuation3;
   add_input_avm_auto_val_4         := le.avm.input_address_information.avm_automated_valuation4;
   add_input_source_count           := le.address_verification.input_address_information.source_count;
   add_input_naprop                 := le.address_verification.input_address_information.naprop;
   add_input_mortgage_date          := le.address_verification.input_address_information.mortgage_date;
   add_input_mortgage_type          := le.address_verification.input_address_information.mortgage_type;
   add_input_financing_type         := le.address_verification.input_address_information.type_financing;
   add_input_occupants_1yr          := le.addr_risk_summary.occupants_1yr;
   add_input_turnover_1yr_in        := le.addr_risk_summary.turnover_1yr_in;
   add_input_turnover_1yr_out       := le.addr_risk_summary.turnover_1yr_out;
   add_input_nhood_vac_prop         := le.addr_risk_summary.N_Vacant_Properties;
   add_input_nhood_bus_ct           := le.addr_risk_summary.N_Business_Count;
   add_input_nhood_sfd_ct           := le.addr_risk_summary.N_SFD_Count;
   add_input_nhood_mfd_ct           := le.addr_risk_summary.N_MFD_Count;
   add_input_pop                    := le.addrPop;
   property_owned_total             := le.address_verification.owned.property_total;
   add_curr_lres                    := le.lres2;
   add_curr_advo_vacancy            := le.advo_addr_hist1.Address_Vacancy_Indicator;
   add_curr_advo_throw_back         := le.advo_addr_hist1.Throw_Back_Indicator;
   add_curr_advo_seasonal           := le.advo_addr_hist1.Seasonal_Delivery_Indicator;
   add_curr_avm_auto_val            := le.avm.address_history_1.avm_automated_valuation;
   add_curr_avm_auto_val_2          := le.avm.address_history_1.avm_automated_valuation2;
   add_curr_avm_auto_val_3          := le.avm.address_history_1.avm_automated_valuation3;
   add_curr_avm_auto_val_4          := le.avm.address_history_1.avm_automated_valuation4;
   add_curr_naprop                  := le.address_verification.address_history_1.naprop;
   add_curr_mortgage_date           := le.address_verification.address_history_1.mortgage_date;
   add_curr_mortgage_type           := le.address_verification.address_history_1.mortgage_type;
   add_curr_financing_type          := le.address_verification.address_history_1.type_financing;
   add_curr_occupants_1yr           := le.addr_risk_summary2.occupants_1yr;
   add_curr_turnover_1yr_in         := le.addr_risk_summary2.turnover_1yr_in;
   add_curr_turnover_1yr_out        := le.addr_risk_summary2.turnover_1yr_out;
   add_curr_nhood_vac_prop          := le.addr_risk_summary2.N_Vacant_Properties;
   add_curr_nhood_bus_ct            := le.addr_risk_summary2.N_Business_Count;
   add_curr_nhood_sfd_ct            := le.addr_risk_summary2.N_SFD_Count;
   add_curr_nhood_mfd_ct            := le.addr_risk_summary2.N_MFD_Count;
   add_curr_pop                     := le.addrPop2;
   add_prev_lres                    := le.lres3;
   add_prev_avm_auto_val            := le.avm.address_history_2.avm_automated_valuation;
   add_prev_naprop                  := le.address_verification.address_history_2.naprop;
   add_prev_pop                     := le.addrPop3;
   avg_lres                         := le.other_address_info.avg_lres;
   max_lres                         := le.other_address_info.max_lres;
   addrs_5yr                        := le.other_address_info.addrs_last_5years;
   addrs_10yr                       := le.other_address_info.addrs_last_10years;
   addrs_15yr                       := le.other_address_info.addrs_last_15years;
   addrs_move_trajectory            := le.economic_trajectory;
   addrs_move_trajectory_index      := le.economic_trajectory_index;
   addrs_prison_history             := le.other_address_info.isprison;
   unverified_addr_count            := le.address_verification.unverified_addr_count;
   telcordia_type                   := le.phone_verification.telcordia_type;
   recent_disconnects               := if(isFCRA, 0, le.phone_verification.recent_disconnects);
   phone_ver_insurance              := le.insurance_phones_summary.Insurance_Phone_Verification;
   phone_ver_experian               := le.Experian_Phone_Verification;
   header_first_seen                := le.ssn_verification.header_first_seen;
   inputssncharflag                 := le.ssn_verification.validation.inputsocscharflag;
   ssns_per_adl                     := le.velocity_counters.ssns_per_adl;
   addrs_per_adl                    := le.velocity_counters.addrs_per_adl;
   adls_per_ssn                     := le.SSN_Verification.adlPerSSN_count;
   addrs_per_ssn                    := if(isFCRA, 0, le.velocity_counters.addrs_per_ssn );
   adls_per_addr_curr               := le.velocity_counters.adls_per_addr_current;
   ssns_per_addr_curr               := le.velocity_counters.ssns_per_addr_current;
   phones_per_addr_curr             := le.velocity_counters.phones_per_addr_current;
   ssns_per_adl_c6                  := le.velocity_counters.ssns_per_adl_created_6months;
   addrs_per_adl_c6                 := le.velocity_counters.addrs_per_adl_created_6months;
   lnames_per_adl_c6                := if(isFCRA, 0, le.velocity_counters.lnames_per_adl180);
   addrs_per_ssn_c6                 := if(isFCRA, 0, le.velocity_counters.addrs_per_ssn_created_6months );
   adls_per_addr_c6                 := le.velocity_counters.adls_per_addr_created_6months;
   phones_per_addr_c6               := if(isFCRA, 0, le.velocity_counters.phones_per_addr_created_6months );
   invalid_ssns_per_adl             := le.velocity_counters.invalid_ssns_per_adl;
   invalid_ssns_per_adl_c6          := le.velocity_counters.invalid_ssns_per_adl_created_6months;
   invalid_addrs_per_adl            := le.velocity_counters.invalid_addrs_per_adl;
   inq_count                        := le.acc_logs.inquiries.counttotal;
   inq_count_day                    := if(isFCRA, 0, le.acc_logs.inquiries.countday);
   inq_count_week                   := if(isFCRA, 0, le.acc_logs.inquiries.countweek);
   inq_count01                      := le.acc_logs.inquiries.count01;
   inq_count03                      := le.acc_logs.inquiries.count03;
   inq_count06                      := le.acc_logs.inquiries.count06;
   inq_count12                      := le.acc_logs.inquiries.count12;
   inq_count24                      := le.acc_logs.inquiries.count24;
   inq_auto_count                   := le.acc_logs.auto.counttotal;
   inq_auto_count_week              := if(isFCRA, 0, le.acc_logs.auto.countweek);
   inq_auto_count01                 := le.acc_logs.auto.count01;
   inq_auto_count03                 := le.acc_logs.auto.count03;
   inq_auto_count06                 := le.acc_logs.auto.count06;
   inq_auto_count12                 := le.acc_logs.auto.count12;
   inq_auto_count24                 := le.acc_logs.auto.count24;
   inq_banking_count_day            := if(isFCRA, 0, le.acc_logs.banking.countday);
   inq_banking_count03              := le.acc_logs.banking.count03;
   inq_banking_count12              := le.acc_logs.banking.count12;
   inq_banking_count24              := le.acc_logs.banking.count24;
   inq_collection_count             := le.acc_logs.collection.counttotal;
   inq_collection_count_week        := if(isFCRA, 0, le.acc_logs.collection.countweek);
   inq_collection_count01           := le.acc_logs.collection.count01;
   inq_collection_count03           := le.acc_logs.collection.count03;
   inq_collection_count06           := le.acc_logs.collection.count06;
   inq_collection_count12           := le.acc_logs.collection.count12;
   inq_collection_count24           := le.acc_logs.collection.count24;
   inq_communications_count         := le.acc_logs.communications.counttotal;
   inq_communications_count_week    := if(isFCRA, 0, le.acc_logs.communications.countweek);
   inq_communications_count01       := le.acc_logs.communications.count01;
   inq_communications_count03       := le.acc_logs.communications.count03;
   inq_communications_count06       := le.acc_logs.communications.count06;
   inq_communications_count12       := le.acc_logs.communications.count12;
   inq_communications_count24       := le.acc_logs.communications.count24;
   inq_highriskcredit_count         := le.acc_logs.highriskcredit.counttotal;
   inq_highriskcredit_count_day     := if(isFCRA, 0, le.acc_logs.highriskcredit.countday);
   inq_highriskcredit_count_week    := if(isFCRA, 0, le.acc_logs.highriskcredit.countweek);
   inq_highriskcredit_count01       := le.acc_logs.highriskcredit.count01;
   inq_highriskcredit_count03       := le.acc_logs.highriskcredit.count03;
   inq_highriskcredit_count06       := le.acc_logs.highriskcredit.count06;
   inq_highriskcredit_count12       := le.acc_logs.highriskcredit.count12;
   inq_highriskcredit_count24       := le.acc_logs.highriskcredit.count24;
   inq_mortgage_count03             := le.acc_logs.mortgage.count03;
   inq_mortgage_count12             := le.acc_logs.mortgage.count12;
   inq_other_count                  := le.acc_logs.other.counttotal;
   inq_other_count_week             := if(isFCRA, 0, le.acc_logs.other.countweek);
   inq_other_count01                := le.acc_logs.other.count01;
   inq_other_count03                := le.acc_logs.other.count03;
   inq_other_count06                := le.acc_logs.other.count06;
   inq_other_count12                := le.acc_logs.other.count12;
   inq_other_count24                := le.acc_logs.other.count24;
   inq_prepaidcards_count           := le.acc_logs.prepaidcards.counttotal;
   inq_prepaidcards_count01         := le.acc_logs.prepaidcards.count01;
   inq_prepaidcards_count03         := le.acc_logs.prepaidcards.count03;
   inq_prepaidcards_count06         := le.acc_logs.prepaidcards.count06;
   inq_prepaidcards_count12         := le.acc_logs.prepaidcards.count12;
   inq_prepaidcards_count24         := le.acc_logs.prepaidcards.count24;
   inq_quizprovider_count_week      := if(isFCRA, 0, le.acc_logs.QuizProvider.countweek);
   inq_quizprovider_count24         := le.acc_logs.quizprovider.count24;
   inq_retail_count                 := le.acc_logs.retail.counttotal;
   inq_retail_count01               := le.acc_logs.retail.count01;
   inq_retail_count03               := le.acc_logs.retail.count03;
   inq_retail_count06               := le.acc_logs.retail.count06;
   inq_retail_count12               := le.acc_logs.retail.count12;
   inq_retail_count24               := le.acc_logs.retail.count24;
   inq_retailpayments_count         := le.acc_logs.retailpayments.counttotal;
   inq_retailpayments_count01       := le.acc_logs.retailpayments.count01;
   inq_retailpayments_count03       := le.acc_logs.retailpayments.count03;
   inq_retailpayments_count06       := le.acc_logs.retailpayments.count06;
   inq_retailpayments_count12       := le.acc_logs.retailpayments.count12;
   inq_retailpayments_count24       := le.acc_logs.retailpayments.count24;
   inq_utilities_count24            := le.acc_logs.utilities.count24;
   inq_ssnsperadl                   := le.acc_logs.inquiryssnsperadl;
   inq_addrsperadl                  := le.acc_logs.inquiryaddrsperadl;
   inq_lnamesperadl                 := if(isFCRA, 0, le.acc_logs.inquirylnamesperadl);
   inq_fnamesperadl                 := le.acc_logs.inquiryfnamesperadl;
   inq_phonesperadl                 := le.acc_logs.inquiryphonesperadl;
   inq_dobsperadl                   := le.acc_logs.inquirydobsperadl;
   inq_perssn                       := if(isFCRA, 0, le.acc_logs.inquiryPerSSN );
   inq_adlsperssn                   := if(isFCRA, 0, le.acc_logs.inquiryADLsPerSSN );
   inq_lnamesperssn                 := if(isFCRA, 0, le.acc_logs.inquiryLNamesPerSSN );
   inq_addrsperssn                  := if(isFCRA, 0, le.acc_logs.inquiryAddrsPerSSN );
   inq_dobsperssn                   := if(isFCRA, 0, le.acc_logs.inquiryDOBsPerSSN );
   inq_peraddr                      := if(isFCRA, 0, le.acc_logs.inquiryPerAddr );
   inq_adlsperaddr                  := if(isFCRA, 0, le.acc_logs.inquiryADLsPerAddr );
   inq_lnamesperaddr                := if(isFCRA, 0, le.acc_logs.inquiryLNamesPerAddr );
   inq_ssnsperaddr                  := if(isFCRA, 0, le.acc_logs.inquirySSNsPerAddr );
   inq_perphone                     := if(isFCRA, 0, le.acc_logs.inquiryPerPhone );
   inq_adlsperphone                 := if(isFCRA, 0, le.acc_logs.inquiryADLsPerPhone );
   br_company_title                 := le.employment.company_title;
   br_first_seen                    := le.employment.first_seen_date;
   br_dead_business_count           := le.employment.dead_business_ct;
   br_active_phone_count            := le.employment.business_active_phone_ct;
   br_source_count                  := le.employment.source_ct;
   infutor_nap                      := le.infutor_phone.infutor_nap;
   stl_inq_count                    := le.impulse.count;
   stl_inq_count90                  := le.impulse.count90;
   stl_inq_count180                 := le.impulse.count180;
   stl_inq_count12                  := le.impulse.count12;
   stl_inq_count24                  := le.impulse.count24;
   email_count                      := le.email_summary.email_ct;
   email_domain_free_count          := le.email_summary.email_domain_free_ct;
   email_domain_isp_count           := le.email_summary.email_domain_isp_ct;
   attr_addrs_last30                := le.other_address_info.addrs_last30;
   attr_addrs_last90                := le.other_address_info.addrs_last90;
   attr_addrs_last12                := le.other_address_info.addrs_last12;
   attr_addrs_last24                := le.other_address_info.addrs_last24;
   attr_addrs_last36                := le.other_address_info.addrs_last36;
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
   attr_num_unrel_liens30           := le.bjl.liens_unreleased_count30;
   attr_num_unrel_liens90           := le.bjl.liens_unreleased_count90;
   attr_num_unrel_liens180          := le.bjl.liens_unreleased_count180;
   attr_num_unrel_liens12           := le.bjl.liens_unreleased_count12;
   attr_num_unrel_liens24           := le.bjl.liens_unreleased_count24;
   attr_num_unrel_liens36           := le.bjl.liens_unreleased_count36;
   attr_num_unrel_liens60           := le.bjl.liens_unreleased_count60;
   attr_num_rel_liens30             := le.bjl.liens_released_count30;
   attr_num_rel_liens90             := le.bjl.liens_released_count90;
   attr_num_rel_liens180            := le.bjl.liens_released_count180;
   attr_num_rel_liens12             := le.bjl.liens_released_count12;
   attr_num_rel_liens24             := le.bjl.liens_released_count24;
   attr_num_rel_liens36             := le.bjl.liens_released_count36;
   attr_num_rel_liens60             := le.bjl.liens_released_count60;
   attr_eviction_count              := le.bjl.eviction_count;
   attr_eviction_count90            := le.bjl.eviction_count90;
   attr_eviction_count180           := le.bjl.eviction_count180;
   attr_eviction_count12            := le.bjl.eviction_count12;
   attr_eviction_count24            := le.bjl.eviction_count24;
   attr_eviction_count36            := le.bjl.eviction_count36;
   attr_eviction_count60            := le.bjl.eviction_count60;
   fp_idrisktype                    := le.fdattributesv2.identityrisklevel;
   fp_idveraddressnotcurrent        := le.fdattributesv2.idveraddressnotcurrent;
   fp_sourcerisktype                := le.fdattributesv2.sourcerisklevel;
   fp_varrisktype                   := le.fdattributesv2.variationrisklevel;
   fp_varmsrcssnunrelcount          := le.fdattributesv2.variationmsourcesssnunrelcount;
   fp_srchvelocityrisktype          := le.fdattributesv2.searchvelocityrisklevel;
   fp_srchunvrfdssncount            := le.fdattributesv2.searchunverifiedssncountyear;
   fp_srchunvrfdaddrcount           := le.fdattributesv2.searchunverifiedaddrcountyear;
   fp_srchunvrfddobcount            := le.fdattributesv2.searchunverifieddobcountyear;
   fp_srchunvrfdphonecount          := le.fdattributesv2.searchunverifiedphonecountyear;
   fp_srchfraudsrchcountyr          := le.fdattributesv2.searchfraudsearchcountyear;
   fp_srchfraudsrchcountmo          := le.fdattributesv2.searchfraudsearchcountmonth;
   fp_srchfraudsrchcountwk          := le.fdattributesv2.searchfraudsearchcountweek;
   fp_srchfraudsrchcountday         := le.fdattributesv2.searchfraudsearchcountday;
   fp_assocsuspicousidcount         := le.fdattributesv2.assocsuspicousidentitiescount;
   fp_validationrisktype            := le.fdattributesv2.validationrisklevel;
   fp_divrisktype                   := le.fdattributesv2.divrisklevel;
   fp_divaddrsuspidcountnew         := le.fdattributesv2.divaddrsuspidentitycountnew;
   fp_srchcomponentrisktype         := le.fdattributesv2.searchcomponentrisklevel;
   fp_srchssnsrchcountmo            := le.fdattributesv2.searchssnsearchcountmonth;
   fp_srchssnsrchcountwk            := le.fdattributesv2.searchssnsearchcountweek;
   fp_srchssnsrchcountday           := le.fdattributesv2.searchssnsearchcountday;
   fp_srchaddrsrchcountmo           := le.fdattributesv2.searchaddrsearchcountmonth;
   fp_srchaddrsrchcountwk           := le.fdattributesv2.searchaddrsearchcountweek;
   fp_srchaddrsrchcountday          := le.fdattributesv2.searchaddrsearchcountday;
   fp_srchphonesrchcountmo          := le.fdattributesv2.searchphonesearchcountmonth;
   fp_srchphonesrchcountwk          := le.fdattributesv2.searchphonesearchcountweek;
   fp_srchphonesrchcountday         := le.fdattributesv2.searchphonesearchcountday;
   fp_componentcharrisktype         := le.fdattributesv2.componentcharrisklevel;
   fp_inputaddractivephonelist      := le.fdattributesv2.inputaddractivephonelist;
   fp_addrchangeincomediff          := le.fdattributesv2.addrchangeincomediff;
   fp_addrchangevaluediff           := le.fdattributesv2.addrchangevaluediff;
   fp_addrchangecrimediff           := le.fdattributesv2.addrchangecrimediff;
   fp_addrchangeecontraj            := le.fdattributesv2.addrchangeecontrajectory;
   fp_curraddractivephonelist       := le.fdattributesv2.curraddractivephonelist;
   fp_curraddrmedianincome          := le.fdattributesv2.curraddrmedianincome;
   fp_curraddrmedianvalue           := le.fdattributesv2.curraddrmedianvalue;
   fp_curraddrmurderindex           := le.fdattributesv2.curraddrmurderindex;
   fp_curraddrcartheftindex         := le.fdattributesv2.curraddrcartheftindex;
   fp_curraddrburglaryindex         := le.fdattributesv2.curraddrburglaryindex;
   fp_curraddrcrimeindex            := le.fdattributesv2.curraddrcrimeindex;
   fp_prevaddrageoldest             := le.fdattributesv2.prevaddrageoldest;
   fp_prevaddrlenofres              := le.fdattributesv2.prevaddrlenofres;
   fp_prevaddrmedianincome          := le.fdattributesv2.prevaddrmedianincome;
   fp_prevaddrmedianvalue           := le.fdattributesv2.prevaddrmedianvalue;
   fp_prevaddrmurderindex           := le.fdattributesv2.prevaddrmurderindex;
   fp_prevaddrcartheftindex         := le.fdattributesv2.prevaddrcartheftindex;
   fp_prevaddrburglaryindex         := le.fdattributesv2.prevaddrburglaryindex;
   fp_prevaddrcrimeindex            := le.fdattributesv2.prevaddrcrimeindex;
   bankrupt                         := le.bjl.bankrupt;
   disposition                      := le.bjl.disposition;
   filing_count                     := le.bjl.filing_count;
   bk_dismissed_recent_count        := le.bjl.bk_dismissed_recent_count;
   bk_dismissed_historical_count    := le.bjl.bk_dismissed_historical_count;
   bk_disposed_recent_count         := le.bjl.bk_disposed_recent_count;
   bk_disposed_historical_count     := le.bjl.bk_disposed_historical_count;
   liens_recent_unreleased_count    := le.bjl.liens_recent_unreleased_count;
	 liens_historical_unreleased_ct   := le.bjl.liens_historical_unreleased_count;
	 liens_recent_released_count      := le.bjl.liens_recent_released_count;
	 liens_historical_released_count  := le.bjl.liens_historical_released_count;
   liens_unrel_cj_ct                := le.liens.liens_unreleased_civil_judgment.count;
   liens_unrel_cj_first_seen        := le.liens.liens_unreleased_civil_judgment.earliest_filing_date;
   liens_unrel_cj_last_seen         := le.liens.liens_unreleased_civil_judgment.most_recent_filing_date;
   liens_unrel_cj_total_amount      := le.liens.liens_unreleased_civil_judgment.total_amount;
   liens_rel_cj_ct                  := le.liens.liens_released_civil_judgment.count;
   liens_rel_cj_last_seen           := le.liens.liens_released_civil_judgment.most_recent_filing_date;
   liens_rel_cj_total_amount        := le.liens.liens_released_civil_judgment.total_amount;
   liens_unrel_ft_ct                := le.liens.liens_unreleased_federal_tax.count;
   liens_unrel_ft_last_seen         := le.liens.liens_unreleased_federal_tax.most_recent_filing_date;
   liens_unrel_ft_total_amount      := le.liens.liens_unreleased_federal_tax.total_amount;
   liens_rel_ft_ct                  := le.liens.liens_released_federal_tax.count;
   liens_rel_ft_first_seen          := le.liens.liens_released_federal_tax.earliest_filing_date;
   liens_rel_ft_last_seen           := le.liens.liens_released_federal_tax.most_recent_filing_date;
   liens_unrel_fc_ct                := le.liens.liens_unreleased_foreclosure.count;
   liens_unrel_fc_first_seen        := le.liens.liens_unreleased_foreclosure.earliest_filing_date;
   liens_unrel_fc_total_amount      := le.liens.liens_unreleased_foreclosure.total_amount;
   liens_rel_fc_ct                  := le.liens.liens_released_foreclosure.count;
   liens_unrel_lt_ct                := le.liens.liens_unreleased_landlord_tenant.count;
   liens_rel_lt_ct                  := le.liens.liens_released_landlord_tenant.count;
   liens_unrel_o_ct                 := le.liens.liens_unreleased_other_lj.count;
   liens_unrel_o_total_amount       := le.liens.liens_unreleased_other_lj.total_amount;
   liens_rel_o_ct                   := le.liens.liens_released_other_lj.count;
   liens_unrel_ot_ct                := le.liens.liens_unreleased_other_tax.count;
   liens_unrel_ot_last_seen         := le.liens.liens_unreleased_other_tax.most_recent_filing_date;
   liens_unrel_ot_total_amount      := le.liens.liens_unreleased_other_tax.total_amount;
   liens_rel_ot_ct                  := le.liens.liens_released_other_tax.count;
   liens_unrel_sc_ct                := le.liens.liens_unreleased_small_claims.count;
   liens_unrel_sc_last_seen         := le.liens.liens_unreleased_small_claims.most_recent_filing_date;
   liens_unrel_sc_total_amount      := le.liens.liens_unreleased_small_claims.total_amount;
   liens_rel_sc_ct                  := le.liens.liens_released_small_claims.count;
   liens_rel_sc_first_seen          := le.liens.liens_released_small_claims.earliest_filing_date;
   liens_rel_sc_last_seen           := le.liens.liens_released_small_claims.most_recent_filing_date;
   liens_rel_sc_total_amount        := le.liens.liens_released_small_claims.total_amount;
   liens_unrel_st_ct                := le.liens.liens_unreleased_suits.count;
   liens_unrel_st_first_seen        := le.liens.liens_unreleased_suits.earliest_filing_date;
   liens_unrel_st_last_seen         := le.liens.liens_unreleased_suits.most_recent_filing_date;
   liens_unrel_st_total_amount      := le.liens.liens_unreleased_suits.total_amount;
   liens_rel_st_ct                  := le.liens.liens_released_suits.count;
   criminal_count                   := le.bjl.criminal_count;
   criminal_last_date               := le.bjl.last_criminal_date;
   felony_count                     := le.bjl.felony_count;
   felony_last_date                 := le.bjl.last_felony_date;
   foreclosure_last_date            := le.bjl.last_foreclosure_date;
   hh_members_ct                    := le.hhid_summary.hh_members_ct;
   hh_property_owners_ct            := le.hhid_summary.hh_property_owners_ct;
   hh_age_65_plus                   := le.hhid_summary.hh_age_65_plus;
   hh_age_30_to_65                  := le.hhid_summary.hh_age_31_to_65;
   hh_age_18_to_30                  := le.hhid_summary.hh_age_18_to_30;
   hh_age_lt18                      := le.hhid_summary.hh_age_lt18;
   hh_collections_ct                := le.hhid_summary.hh_collections_ct;
   hh_workers_paw                   := le.hhid_summary.hh_workers_paw;
   hh_payday_loan_users             := le.hhid_summary.hh_payday_loan_users;
   hh_members_w_derog               := le.hhid_summary.hh_members_w_derog;
   hh_tot_derog                     := le.hhid_summary.hh_tot_derog;
   hh_bankruptcies                  := le.hhid_summary.hh_bankruptcies;
   hh_lienholders                   := le.hhid_summary.hh_lienholders;
   hh_prof_license_holders          := le.hhid_summary.hh_prof_license_holders;
   hh_criminals                     := le.hhid_summary.hh_criminals;
   hh_college_attendees             := le.hhid_summary.hh_college_attendees;
   rel_count                        := le.relatives.relative_count;
   rel_bankrupt_count               := le.relatives.relative_bankrupt_count;
   rel_criminal_count               := le.relatives.relative_criminal_count;
   rel_felony_count                 := le.relatives.relative_felony_count;
   crim_rel_within25miles           := le.relatives.criminal_relative_within25miles;
   crim_rel_within100miles          := le.relatives.criminal_relative_within100miles;
   crim_rel_within500miles          := le.relatives.criminal_relative_within500miles;
   crim_rel_withinother             := le.relatives.criminal_relative_withinother;
   rel_prop_owned_count             := le.relatives.owned.relatives_property_count;
   rel_prop_sold_count              := le.relatives.sold.relatives_property_count;
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
   rel_educationunder8_count        := le.relatives.relative_educationunder8_count;
   rel_educationunder12_count       := le.relatives.relative_educationunder12_count;
   rel_educationover12_count        := le.relatives.relative_educationover12_count;
   rel_ageunder20_count             := le.relatives.relative_ageunder20_count;
   rel_ageunder30_count             := le.relatives.relative_ageunder30_count;
   rel_ageunder40_count             := le.relatives.relative_ageunder40_count;
   rel_ageunder50_count             := le.relatives.relative_ageunder50_count;
   rel_ageunder60_count             := le.relatives.relative_ageunder60_count;
   rel_ageunder70_count             := le.relatives.relative_ageunder70_count;
   rel_ageover70_count              := le.relatives.relative_ageover70_count;
   current_count                    := le.vehicles.current_count;
   historical_count                 := le.vehicles.historical_count;
   acc_count                        := le.accident_data.acc.num_accidents;
   acc_damage_amt_total             := le.accident_data.acc.dmgamtaccidents;
   acc_last_seen                    := le.accident_data.acc.datelastaccident;
   acc_count_30                     := le.accident_data.acc.numaccidents30;
   acc_count_90                     := le.accident_data.acc.numaccidents90;
   acc_count_180                    := le.accident_data.acc.numaccidents180;
   acc_count_12                     := le.accident_data.acc.numaccidents12;
   acc_count_24                     := le.accident_data.acc.numaccidents24;
   acc_count_36                     := le.accident_data.acc.numaccidents36;
   acc_count_60                     := le.accident_data.acc.numaccidents60;
   college_date_first_seen          := (unsigned)le.student.date_first_seen;
   college_code                     := le.student.college_code;
   college_type                     := le.student.college_type;
   college_file_type                := le.student.file_type2;
   college_tier                     := le.student.college_tier;
   college_major                    := le.student.college_major;
   prof_license_category            := le.professional_license.plcategory;
   prof_license_source              := le.professional_license.proflic_source;
   wealth_index                     := le.wealth_indicator;
   input_dob_match_level            := le.dobmatchlevel;
   inferred_age                     := le.inferred_age;
   addr_stability_v2                := le.addr_stability;
   estimated_income                 := le.estimated_income;


	/* ***********************************************************
	 *                    Generated ECL                          *
	 ************************************************************* */

	NULL := -999999999;


INTEGER contains_i( string haystack, string needle ) := (INTEGER)(StringLib.StringFind(haystack, needle, 1) > 0);


BOOLEAN indexw(string source, string target, string delim) :=
	(source = target) OR
	(StringLib.StringFind(source, delim + target + delim, 1) > 0) OR
	(source[1..length(target)+1] = target + delim) OR
	(StringLib.StringReverse(source)[1..length(target)+1] = StringLib.StringReverse(target) + delim);

sysdate := __common__( common.sas_date(if(le.historydate=999999, (string8)Std.Date.Today(), (string6)le.historydate+'01')));
//sysdate :=(common.sas_date('20150501'));

iv_add_apt := __common__( if(StringLib.StringToUpperCase(trim(rc_dwelltype, LEFT, RIGHT)) = 'A' or StringLib.StringToUpperCase(trim(out_addr_type, LEFT, RIGHT)) = 'H' or not(out_unit_desig = '') or not(out_sec_range = ''), '1', '0'));

rv_s65_ssn_prior_dob := map(
    not(ssnlength > '0' and dobpop)            => NULL,
    rc_ssndobflag = '1' or rc_pwssndobflag = '1' => 1,
    rc_ssndobflag = '0' or rc_pwssndobflag = '0' => 0,
                                                NULL);


rv_c16_inv_ssn_per_adl := __common__( if(not(truedid), NULL, min(if(invalid_ssns_per_adl = NULL, -NULL, invalid_ssns_per_adl), 999)));

rv_s65_ssn_problem := __common__( map(
    not(ssnlength > '0')                                                                                                                                                                                                                                                => NULL,
    dobpop and (rc_ssndobflag = '1' or rc_pwssndobflag = '1') or truedid and invalid_ssns_per_adl >= 2 or truedid and invalid_ssns_per_adl_c6 >= 1                                                                                                                        => 2,
    rc_decsflag = '1' or contains_i(ver_sources, 'DE') > 0 or contains_i(ver_sources, 'DS') > 0 or rc_ssnvalflag = '1' or (rc_pwssnvalflag in ['1', '2', '3']) or (inputssncharflag in ['1', '2', '3']) or truedid and invalid_ssns_per_adl >= 1                          => 1,
    rc_decsflag = '0' or dobpop and (rc_ssndobflag = '0' or rc_pwssndobflag = '0') or rc_ssnvalflag = '0' or (rc_pwssnvalflag in ['0', '4', '5']) or (inputssncharflag in ['0', '4', '5']) or truedid and invalid_ssns_per_adl = 0 or truedid and invalid_ssns_per_adl_c6 = 0 => 0,
                                                                                                                                                                                                                                                                         NULL));

rv_p88_phn_dst_to_inp_add := __common__( if(rc_disthphoneaddr = 9999, NULL, rc_disthphoneaddr));

iv_phn_cell := map(
    not(hphnpop)                                                                                                                                                                                                                                            => NULL,
    rc_hriskphoneflag = '1' or trim(trim(rc_hphonetypeflag, LEFT), LEFT, RIGHT) = '1' or trim(trim(telcordia_type, LEFT), LEFT, RIGHT) = '04' or trim(trim(telcordia_type, LEFT), LEFT, RIGHT) = '55' or trim(trim(telcordia_type, LEFT), LEFT, RIGHT) = '60' => 1,
                                                                                                                                                                                                                                                               0);
iv_phn_pcs := __common__( map(
    not(hphnpop)                                                                                                                                                                                                                                                                                                                                                            => NULL,
    rc_hriskphoneflag = '3' or trim(trim(rc_hphonetypeflag, LEFT), LEFT, RIGHT) = '3' or trim(trim(telcordia_type, LEFT), LEFT, RIGHT) = '64' or trim(trim(telcordia_type, LEFT), LEFT, RIGHT) = '65' or trim(trim(telcordia_type, LEFT), LEFT, RIGHT) = '66' or trim(trim(telcordia_type, LEFT), LEFT, RIGHT) = '67' or trim(trim(telcordia_type, LEFT), LEFT, RIGHT) = '68' => 1,
                                                                                                                                                                                                                                                                                                                                                                               0));

add_ec1_1 := __common__( (StringLib.StringToUpperCase(trim(out_addr_status, LEFT)))[1..1]);

add_ec3 := __common__( (StringLib.StringToUpperCase(trim(out_addr_status, LEFT)))[3..3]);

add_ec4 := __common__( (StringLib.StringToUpperCase(trim(out_addr_status, LEFT)))[4..4]);

rv_l70_add_standardized := __common__( map(
    not(addrpop)                                           => '                           ',
    trim(trim(add_ec1_1, LEFT), LEFT, RIGHT) = 'E'         => '2 Standardization Error    ',
    add_ec1_1 = 'S' and (add_ec3 != '0' or add_ec4 != '0') => '1 Address was Standardized ',
                                                              '0 Address is Standard      '));

rv_l72_add_curr_vacant := __common__( map(
    not(add_curr_pop)                                          => NULL,
    trim(trim(add_curr_advo_vacancy, LEFT), LEFT, RIGHT) = 'Y' => 1,
                                                                  0));

rv_l74_add_curr_throwback := __common__( map(
    not(add_curr_pop)                                             => NULL,
    trim(trim(add_curr_advo_throw_back, LEFT), LEFT, RIGHT) = 'Y' => 1,
                                                                     0));

rv_l76_add_curr_seasonal := __common__( if(not(add_curr_pop), '', add_curr_advo_seasonal));

rv_c19_add_prison_hist := __common__( if(not(truedid), NULL, (Integer)addrs_prison_history));

rv_f00_dob_score := __common__( if(not(truedid and dobpop), NULL, min(if(combo_dobscore = NULL, -NULL, combo_dobscore), 999)));

rv_f01_inp_addr_address_score := __common__( if(not(add_input_pop and truedid), NULL, min(if(add_input_address_score = NULL, -NULL, add_input_address_score), 999)));

rv_f00_input_dob_match_level := __common__( if(not(truedid and dobpop), NULL, (Integer)input_dob_match_level));

rv_d30_derog_count := __common__( if(not(truedid), NULL, min(if(attr_total_number_derogs = NULL, -NULL, attr_total_number_derogs), 999)));

rv_d32_criminal_count := __common__( if(not(truedid), NULL, min(if(criminal_count = NULL, -NULL, criminal_count), 999)));

rv_d32_felony_count := __common__( if(not(truedid), NULL, min(if(felony_count = NULL, -NULL, felony_count), 999)));

	rv_d32_criminal_x_felony := __common__( if(not(truedid), '', 
			(trim((string)(min(if(criminal_count = NULL, -NULL, criminal_count), 3)), LEFT, RIGHT)
			+ trim('-', LEFT, RIGHT) 
			+ trim((string)(min(if(felony_count = NULL, -NULL, felony_count), 3)), LEFT, RIGHT))));

_criminal_last_date := __common__( common.sas_date((string)(criminal_last_date)));

rv_d32_mos_since_crim_ls := __common__( map(
    not(truedid)               => NULL,
    _criminal_last_date = NULL => -1,
                                  min(if(if ((sysdate - _criminal_last_date) / (365.25 / 12) >= 0, truncate((sysdate - _criminal_last_date) / (365.25 / 12)), roundup((sysdate - _criminal_last_date) / (365.25 / 12))) = NULL, -NULL, if ((sysdate - _criminal_last_date) / (365.25 / 12) >= 0, truncate((sysdate - _criminal_last_date) / (365.25 / 12)), roundup((sysdate - _criminal_last_date) / (365.25 / 12)))), 240)));

_felony_last_date := __common__( common.sas_date((string)(felony_last_date)));

rv_d32_mos_since_fel_ls := __common__( map(
    not(truedid)             => NULL,
    _felony_last_date = NULL => -1,
                                min(if(if ((sysdate - _felony_last_date) / (365.25 / 12) >= 0, truncate((sysdate - _felony_last_date) / (365.25 / 12)), roundup((sysdate - _felony_last_date) / (365.25 / 12))) = NULL, -NULL, if ((sysdate - _felony_last_date) / (365.25 / 12) >= 0, truncate((sysdate - _felony_last_date) / (365.25 / 12)), roundup((sysdate - _felony_last_date) / (365.25 / 12)))), 240)));

rv_d31_mostrec_bk := __common__( map(
    not(truedid)                                    => '',
		contains_i(UPCASE(disposition), 'CASE DISMISS') > 0  => '3 - BK OTHER',
    contains_i(UPCASE(disposition), 'DISMISS') > 0  => '1 - BK DISMISSED ',
    contains_i(UPCASE(disposition), 'DISCHARG') > 0  => '2 - BK DISCHARGED',
    bankrupt = true or filing_count > 0                => '3 - BK OTHER     ',
                                                       '0 - NO BK        ')); 
rv_d31_all_bk := __common__( map(
    not(truedid)                                                                                                                                                                                                                                                                                                   => '',
    contains_i(StringLib.StringToUpperCase(disposition), 'DISMISS') = 1 or if(max(bk_dismissed_recent_count, bk_dismissed_historical_count) = NULL, NULL, sum(if(bk_dismissed_recent_count = NULL, 0, bk_dismissed_recent_count), if(bk_dismissed_historical_count = NULL, 0, bk_dismissed_historical_count))) > 0 => '1 - BK DISMISSED ',
    contains_i(StringLib.StringToUpperCase(disposition), 'DISCHARG') = 1 or if(max(bk_disposed_recent_count, bk_disposed_historical_count) = NULL, NULL, sum(if(bk_disposed_recent_count = NULL, 0, bk_disposed_recent_count), if(bk_disposed_historical_count = NULL, 0, bk_disposed_historical_count))) > 0          => '2 - BK DISCHARGED',
    (Integer)bankrupt = 1 or filing_count > 0                                                                                                                                                                                                                                                                               => '3 - BK OTHER     ',
                                                                                                                                                                                                                                                                                                                      '0 - NO BK        '));

rv_d31_bk_dism_recent_count := __common__( if(not(truedid), NULL, min(if(bk_dismissed_recent_count = NULL, -NULL, bk_dismissed_recent_count), 999)));

rv_c21_stl_recency := __common__( map(
    not(truedid)         => NULL,
    stl_inq_count90 > 0  => 3,
    stl_inq_count180 > 0 => 6,
    stl_inq_count12 > 0  => 12,
    stl_inq_count24 > 0  => 24,
                            0));

	rv_d33_eviction_recency := map(
	    not(truedid)                                                		=> NULL,
	    (boolean)attr_eviction_count90                                  => 3,
	    (boolean)attr_eviction_count180                                 => 6,
	    (boolean)attr_eviction_count12                                  => 12,
	    (boolean)attr_eviction_count24 and attr_eviction_count >= 2 		=> 24,
	    (boolean)attr_eviction_count24                                  => 25,
	    (boolean)attr_eviction_count36 and attr_eviction_count >= 2 		=> 36,
	    (boolean)attr_eviction_count36                                  => 37,
	    (boolean)attr_eviction_count60 and attr_eviction_count >= 2 		=> 60,
	    (boolean)attr_eviction_count60                                  => 61,
	    attr_eviction_count >= 2                                    		=> 98,
	    attr_eviction_count >= 1                                    		=> 99,
																																				 0);

rv_d33_eviction_count := __common__( if(not(truedid), NULL, min(if(attr_eviction_count = NULL, -NULL, attr_eviction_count), 999)));

rv_d34_unrel_liens_ct := __common__( if(not(truedid), NULL, min(if(if(max(liens_recent_unreleased_count, liens_historical_unreleased_ct) = NULL, NULL, sum(if(liens_recent_unreleased_count = NULL, 0, liens_recent_unreleased_count), if(liens_historical_unreleased_ct = NULL, 0, liens_historical_unreleased_ct))) = NULL, -NULL, if(max(liens_recent_unreleased_count, liens_historical_unreleased_ct) = NULL, NULL, sum(if(liens_recent_unreleased_count = NULL, 0, liens_recent_unreleased_count), if(liens_historical_unreleased_ct = NULL, 0, liens_historical_unreleased_ct)))), 999)));

iv_d34_liens_unrel_x_rel := __common__( __common__( if(not(truedid), '   ', trim((String)min(if(if(max(liens_recent_unreleased_count, liens_historical_unreleased_ct) = NULL, NULL, sum(if(liens_recent_unreleased_count = NULL, 0, liens_recent_unreleased_count), if(liens_historical_unreleased_ct = NULL, 0, liens_historical_unreleased_ct))) = NULL, -NULL, if(max(liens_recent_unreleased_count, liens_historical_unreleased_ct) = NULL, NULL, sum(if(liens_recent_unreleased_count = NULL, 0, liens_recent_unreleased_count), if(liens_historical_unreleased_ct = NULL, 0, liens_historical_unreleased_ct)))), 3), LEFT, RIGHT) + trim('-', LEFT, RIGHT) + trim((String)min(if(if(max(liens_recent_released_count, liens_historical_released_count) = NULL, NULL, sum(if(liens_recent_released_count = NULL, 0, liens_recent_released_count), if(liens_historical_released_count = NULL, 0, liens_historical_released_count))) = NULL, -NULL, if(max(liens_recent_released_count, liens_historical_released_count) = NULL, NULL, sum(if(liens_recent_released_count = NULL, 0, liens_recent_released_count), if(liens_historical_released_count = NULL, 0, liens_historical_released_count)))), 2), LEFT, RIGHT))));

bureau_adl_eq_fseen_pos_3 := __common__( Models.Common.findw_cpp(ver_sources, 'EQ' , ', ', 'E'));

bureau_adl_fseen_eq_3 := __common__( if(bureau_adl_eq_fseen_pos_3 = 0, '       0', Models.Common.getw(ver_sources_first_seen, bureau_adl_eq_fseen_pos_3, ',')));

_bureau_adl_fseen_eq_3 := __common__( common.sas_date((string)(bureau_adl_fseen_eq_3)));

_src_bureau_adl_fseen := __common__( min(if(_bureau_adl_fseen_eq_3 = NULL, -NULL, _bureau_adl_fseen_eq_3), 999999));

rv_c20_m_bureau_adl_fs := __common__( map(
    not(truedid)                   => NULL,
    _src_bureau_adl_fseen = 999999 => -1,
                                      min(if(if ((sysdate - _src_bureau_adl_fseen) / (365.25 / 12) >= 0, truncate((sysdate - _src_bureau_adl_fseen) / (365.25 / 12)), roundup((sysdate - _src_bureau_adl_fseen) / (365.25 / 12))) = NULL, -NULL, if ((sysdate - _src_bureau_adl_fseen) / (365.25 / 12) >= 0, truncate((sysdate - _src_bureau_adl_fseen) / (365.25 / 12)), roundup((sysdate - _src_bureau_adl_fseen) / (365.25 / 12)))), 999)));

num_dob_match_level := __common__( (integer)input_dob_match_level);

nas_summary_ver := __common__( if(ssnlength > '0' and (nas_summary in [8, 9, 10, 11, 12]) or (nas_summary in [2, 4, 7]) and add_input_isbestmatch, 1, 0));

nap_summary_ver := __common__( if(hphnpop and (nap_summary in [9, 10, 11, 12]), 1, 0));

infutor_nap_ver := __common__( if(hphnpop and (infutor_nap in [9, 10, 11, 12]), 1, 0));

dob_ver := __common__( if(dobpop and num_dob_match_level >= 5, 1, 0));

sufficiently_verified := __common__( map(
    (boolean)(integer)nas_summary_ver and ((boolean)(integer)nap_summary_ver or (boolean)(integer)infutor_nap_ver)          => 1,
    (boolean)(integer)nas_summary_ver and ((boolean)(integer)dob_ver or not(dobpop))                                        => 1,
    ((boolean)(integer)dob_ver or not(dobpop)) and ((boolean)(integer)nap_summary_ver or (boolean)(integer)infutor_nap_ver) => 1,
                                                                                                                               0));

add_ec1 := __common__( (StringLib.StringToUpperCase(trim(out_addr_status, LEFT)))[1..1]);

addr_validation_problem := __common__( if(add_ec1 = 'E' and not(rc_addrvalflag = 'N') or rc_hriskaddrflag = '4' or rc_addrcommflag = '2' or (add_input_advo_res_or_bus in ['B', 'D']) or not(out_z5 = '') and (rc_hriskaddrflag = '2' or rc_ziptypeflag = '2') or add_input_advo_vacancy = 'Y', 1, 0));

phn_validation_problem := __common__( if(rc_hphonetypeflag = 'A' or rc_hriskphoneflag = '2' or rc_hphonetypeflag = '2' or (telcordia_type in ['02', '56', '61']) or rc_phonevalflag = '0' or rc_hphonevalflag = '0' or rc_phonetype = '5' or rc_hriskphoneflag = '6' or rc_hphonetypeflag = '5' or rc_hphonevalflag = '3' or rc_addrcommflag = '1', 1, 0));

validation_problem := __common__( if(adls_per_ssn >= 5 or ssns_per_adl >= 4 or invalid_ssns_per_adl >= 1 or adls_per_addr_curr >= 8 or ssns_per_addr_curr >= 7 or rc_hrisksic = '2225' or rc_hrisksicphone = '2225' or (boolean)(integer)addr_validation_problem or (boolean)(integer)phn_validation_problem, 1, 0));

tot_liens := __common__( if(max(liens_historical_unreleased_ct, liens_recent_unreleased_count, liens_recent_released_count, liens_historical_released_count) = NULL, NULL, sum(if(liens_historical_unreleased_ct = NULL, 0, liens_historical_unreleased_ct), if(liens_recent_unreleased_count = NULL, 0, liens_recent_unreleased_count), if(liens_recent_released_count = NULL, 0, liens_recent_released_count), if(liens_historical_released_count = NULL, 0, liens_historical_released_count))));

tot_liens_w_type := __common__( if(max(liens_unrel_LT_ct, liens_rel_LT_ct, liens_unrel_SC_ct, liens_rel_SC_ct, liens_unrel_CJ_ct, liens_rel_CJ_ct, liens_unrel_FT_ct, liens_rel_FT_ct, liens_unrel_OT_ct, liens_rel_OT_ct, liens_unrel_ST_ct, liens_rel_ST_ct, liens_unrel_FC_ct, liens_rel_FC_ct, liens_unrel_O_ct, liens_rel_O_ct) = NULL, NULL, sum(if(liens_unrel_LT_ct = NULL, 0, liens_unrel_LT_ct), if(liens_rel_LT_ct = NULL, 0, liens_rel_LT_ct), if(liens_unrel_SC_ct = NULL, 0, liens_unrel_SC_ct), if(liens_rel_SC_ct = NULL, 0, liens_rel_SC_ct), if(liens_unrel_CJ_ct = NULL, 0, liens_unrel_CJ_ct), if(liens_rel_CJ_ct = NULL, 0, liens_rel_CJ_ct), if(liens_unrel_FT_ct = NULL, 0, liens_unrel_FT_ct), if(liens_rel_FT_ct = NULL, 0, liens_rel_FT_ct), if(liens_unrel_OT_ct = NULL, 0, liens_unrel_OT_ct), if(liens_rel_OT_ct = NULL, 0, liens_rel_OT_ct), if(liens_unrel_ST_ct = NULL, 0, liens_unrel_ST_ct), if(liens_rel_ST_ct = NULL, 0, liens_rel_ST_ct), if(liens_unrel_FC_ct = NULL, 0, liens_unrel_FC_ct), if(liens_rel_FC_ct = NULL, 0, liens_rel_FC_ct), if(liens_unrel_O_ct = NULL, 0, liens_unrel_O_ct), if(liens_rel_O_ct = NULL, 0, liens_rel_O_ct))));

has_derog := __common__( if(felony_count > 0 or criminal_count > 0 or stl_inq_count24 > 0 or attr_eviction_count > 0 or liens_unrel_CJ_ct > 0 or liens_rel_CJ_ct > 0 or liens_unrel_SC_ct > 0 or liens_rel_SC_ct > 0 or liens_unrel_FC_ct > 0 or liens_rel_FC_ct > 0 or liens_unrel_O_ct > 0 or liens_rel_O_ct > 0 or tot_liens - tot_liens_w_type > 0 or bk_dismissed_recent_count > 0 or bk_dismissed_historical_count > 0, 1, 0));

rv_6seg_riskview_5_0 := __common__( map(
    (Integer)truedid = 0                                                                                                     => '0 TRUEDID = 0              ',
    not((boolean)sufficiently_verified)                                                                             => '1 VER/VAL PROBLEMS         ',
    (boolean)sufficiently_verified and (boolean)(integer)validation_problem                                         => '1 VER/VAL PROBLEMS         ',
    (boolean)sufficiently_verified and not(add_input_isbestmatch) and (boolean)(integer)has_derog                   => '2 ADDR NOT CURRENT - DEROG ',
    (boolean)sufficiently_verified and not(add_input_isbestmatch)                                                   => '3 ADDR NOT CURRENT - OTHER ',
    (boolean)sufficiently_verified and add_input_isbestmatch and (boolean)(integer)has_derog                        => '4 SUFFICIENTLY VERD - DEROG',
    (boolean)sufficiently_verified and add_input_isbestmatch and (add_input_naprop = 4 or property_owned_total > 0) => '5 SUFFICIENTLY VERD - OWNER',
                                                                                                                       '6 SUFFICIENTLY VERD - OTHER'));

rv_4seg_riskview_5_0 := __common__( map(
    (Integer)truedid = 0                                                             => '0 TRUEDID = 0     ',
    not((boolean)sufficiently_verified)                                     => '1 VER/VAL PROBLEMS',
    (boolean)sufficiently_verified and (boolean)(integer)validation_problem => '1 VER/VAL PROBLEMS',
    (Boolean)has_derog                                                               => '2 DEROG           ',
    add_input_naprop = 4 or property_owned_total > 0                        => '3 OWNER           ',
                                                                               '4 OTHER           '));

bureau_adl_eq_fseen_pos_2 := __common__( Models.Common.findw_cpp(ver_sources, 'EQ' , ', ', 'E'));

bureau_adl_fseen_eq_2 := __common__( if(bureau_adl_eq_fseen_pos_2 = 0, '       0', Models.Common.getw(ver_sources_first_seen, bureau_adl_eq_fseen_pos_2, ',')));

_bureau_adl_fseen_eq_2 := __common__( common.sas_date((string)(bureau_adl_fseen_eq_2)));

bureau_adl_en_fseen_pos_2 := __common__( Models.Common.findw_cpp(ver_sources, 'EN' , ',', 'E'));

bureau_adl_fseen_en_2 := __common__( if(bureau_adl_en_fseen_pos_2 = 0, '       0', Models.Common.getw(ver_sources_first_seen, bureau_adl_en_fseen_pos_2, ',')));

_bureau_adl_fseen_en_2 := __common__( common.sas_date((string)(bureau_adl_fseen_en_2)));

bureau_adl_ts_fseen_pos_2 := __common__( Models.Common.findw_cpp(ver_sources, 'TS' , ',', 'E'));

bureau_adl_fseen_ts_2 := __common__( if(bureau_adl_ts_fseen_pos_2 = 0, '       0', Models.Common.getw(ver_sources_first_seen, bureau_adl_ts_fseen_pos_2, ',')));

_bureau_adl_fseen_ts_2 := __common__( common.sas_date((string)(bureau_adl_fseen_ts_2)));

bureau_adl_tu_fseen_pos_2 := __common__( Models.Common.findw_cpp(ver_sources, 'TU' , ',', 'E'));

bureau_adl_fseen_tu_2 := __common__( if(bureau_adl_tu_fseen_pos_2 = 0, '       0', Models.Common.getw(ver_sources_first_seen, bureau_adl_tu_fseen_pos_2, ',')));

_bureau_adl_fseen_tu_2 := __common__( common.sas_date((string)(bureau_adl_fseen_tu_2)));

bureau_adl_tn_fseen_pos_2 := __common__( Models.Common.findw_cpp(ver_sources, 'TN' , ',', 'E'));

bureau_adl_fseen_tn_2 := __common__( if(bureau_adl_tn_fseen_pos_2 = 0, '       0', Models.Common.getw(ver_sources_first_seen, bureau_adl_tn_fseen_pos_2, ',')));

_bureau_adl_fseen_tn_2 := __common__( common.sas_date((string)(bureau_adl_fseen_tn_2)));

_src_bureau_adl_fseen_all_1 := __common__( min(if(_bureau_adl_fseen_tn_2 = NULL, -NULL, _bureau_adl_fseen_tn_2), if(_bureau_adl_fseen_ts_2 = NULL, -NULL, _bureau_adl_fseen_ts_2), if(_bureau_adl_fseen_tu_2 = NULL, -NULL, _bureau_adl_fseen_tu_2), if(_bureau_adl_fseen_en_2 = NULL, -NULL, _bureau_adl_fseen_en_2), if(_bureau_adl_fseen_eq_2 = NULL, -NULL, _bureau_adl_fseen_eq_2), 999999));

nf_m_bureau_adl_fs_all := __common__( map(
    not(truedid)                         => NULL,
    _src_bureau_adl_fseen_all_1 = 999999 => -1,
                                            if ((sysdate - _src_bureau_adl_fseen_all_1) / (365.25 / 12) >= 0, truncate((sysdate - _src_bureau_adl_fseen_all_1) / (365.25 / 12)), roundup((sysdate - _src_bureau_adl_fseen_all_1) / (365.25 / 12)))));

bureau_adl_eq_fseen_pos_1 := __common__( Models.Common.findw_cpp(ver_sources, 'EQ' , ', ', 'E'));

bureau_adl_fseen_eq_1 := __common__( if(bureau_adl_eq_fseen_pos_1 = 0, '       0', Models.Common.getw(ver_sources_first_seen, bureau_adl_eq_fseen_pos_1, ',')));

_bureau_adl_fseen_eq_1 := __common__( common.sas_date((string)(bureau_adl_fseen_eq_1)));

bureau_adl_en_fseen_pos_1 := __common__( Models.Common.findw_cpp(ver_sources, 'EN' , ',', 'E'));

bureau_adl_fseen_en_1 := __common__( if(bureau_adl_en_fseen_pos_1 = 0, '       0', Models.Common.getw(ver_sources_first_seen, bureau_adl_en_fseen_pos_1, ',')));

_bureau_adl_fseen_en_1 := __common__( common.sas_date((string)(bureau_adl_fseen_en_1)));

bureau_adl_ts_fseen_pos_1 := __common__( Models.Common.findw_cpp(ver_sources, 'TS' , ',', 'E'));

bureau_adl_fseen_ts_1 := __common__( if(bureau_adl_ts_fseen_pos_1 = 0, '       0', Models.Common.getw(ver_sources_first_seen, bureau_adl_ts_fseen_pos_1, ',')));

_bureau_adl_fseen_ts_1 := __common__( common.sas_date((string)(bureau_adl_fseen_ts_1)));

bureau_adl_tu_fseen_pos_1 := __common__( Models.Common.findw_cpp(ver_sources, 'TU' , ',', 'E'));

bureau_adl_fseen_tu_1 := __common__( if(bureau_adl_tu_fseen_pos_1 = 0, '       0', Models.Common.getw(ver_sources_first_seen, bureau_adl_tu_fseen_pos_1, ',')));

_bureau_adl_fseen_tu_1 := __common__( common.sas_date((string)(bureau_adl_fseen_tu_1)));

bureau_adl_tn_fseen_pos_1 := __common__( Models.Common.findw_cpp(ver_sources, 'TN' , ',', 'E'));

bureau_adl_fseen_tn_1 := __common__( if(bureau_adl_tn_fseen_pos_1 = 0, '       0', Models.Common.getw(ver_sources_first_seen, bureau_adl_tn_fseen_pos_1, ',')));

_bureau_adl_fseen_tn_1 := __common__( common.sas_date((string)(bureau_adl_fseen_tn_1)));

_src_bureau_adl_fseen_notu := __common__( min(if(_bureau_adl_fseen_en_1 = NULL, -NULL, _bureau_adl_fseen_en_1), if(_bureau_adl_fseen_eq_1 = NULL, -NULL, _bureau_adl_fseen_eq_1), 999999));

nf_m_bureau_adl_fs_notu := __common__( map(
    not(truedid)                        => NULL,
    _src_bureau_adl_fseen_notu = 999999 => -1,
                                           if ((sysdate - _src_bureau_adl_fseen_notu) / (365.25 / 12) >= 0, truncate((sysdate - _src_bureau_adl_fseen_notu) / (365.25 / 12)), roundup((sysdate - _src_bureau_adl_fseen_notu) / (365.25 / 12)))));

_header_first_seen := __common__( common.sas_date((string)(header_first_seen)));

rv_c10_m_hdr_fs := __common__( map(
    not(truedid)              => NULL,
    _header_first_seen = NULL => -1,
                                 min(if(if ((sysdate - _header_first_seen) / (365.25 / 12) >= 0, truncate((sysdate - _header_first_seen) / (365.25 / 12)), roundup((sysdate - _header_first_seen) / (365.25 / 12))) = NULL, -NULL, if ((sysdate - _header_first_seen) / (365.25 / 12) >= 0, truncate((sysdate - _header_first_seen) / (365.25 / 12)), roundup((sysdate - _header_first_seen) / (365.25 / 12)))), 999)));

rv_c12_source_profile := __common__( if(not(truedid), NULL, (Real)hdr_source_profile));

rv_s66_adlperssn_count := __common__( map(
    not(ssnlength > '0') => NULL,
    adls_per_ssn = 0   => 1,
                          min(if(adls_per_ssn = NULL, -NULL, adls_per_ssn), 999)));

_in_dob := __common__( common.sas_date((string)(in_dob)));

yr_in_dob := __common__( if(_in_dob = NULL, -1, (sysdate - _in_dob) / 365.25));

yr_in_dob_int := __common__( if (yr_in_dob >= 0, roundup(yr_in_dob), truncate(yr_in_dob)));

rv_comb_age := __common__( map(
    yr_in_dob_int > 0            => yr_in_dob_int,
    inferred_age > 0 and truedid => inferred_age,
                                    NULL));

rv_f01_inp_addr_not_verified := __common__( if(not(add_input_pop and truedid), NULL, (Integer)add_input_addr_not_verified));

rv_l80_inp_avm_autoval := __common__( if(not(add_input_pop), NULL, add_input_avm_auto_val));

rv_a46_curr_avm_autoval := __common__( if(not(truedid), NULL, add_curr_avm_auto_val));

rv_a49_curr_avm_chg_1yr := __common__( map(
    not(truedid)                                              => NULL,
    add_curr_lres < 12                                        => NULL,
    add_curr_avm_auto_val > 0 and add_curr_avm_auto_val_2 > 0 => add_curr_avm_auto_val - add_curr_avm_auto_val_2,
                                                                 NULL));

rv_a49_curr_avm_chg_1yr_pct := __common__( map(
    not(truedid)                                              => NULL,
    add_curr_lres < 12                                        => NULL,
    add_curr_avm_auto_val > 0 and add_curr_avm_auto_val_2 > 0 => round(100 * add_curr_avm_auto_val / add_curr_avm_auto_val_2/0.1)*0.1,
                                                                 NULL));

rv_c13_curr_addr_lres := __common__( if(not(truedid and add_curr_pop), NULL, min(if(add_curr_lres = NULL, -NULL, add_curr_lres), 999)));

rv_c14_addr_stability_v2 := __common__( if(not(truedid), NULL, (Integer)addr_stability_v2));

rv_c13_max_lres := __common__( if(not(truedid), NULL, min(if(max_lres = NULL, -NULL, max_lres), 999)));

rv_c14_addrs_5yr := __common__( map(
    not(truedid)     => NULL,
    (Integer)add_curr_pop = 0 => -1,
                        min(if(addrs_5yr = NULL, -NULL, addrs_5yr), 999)));

rv_c14_addrs_10yr := __common__( map(
    not(truedid)     => NULL,
    (Integer)add_curr_pop = 0 => -1,
                        min(if(addrs_10yr = NULL, -NULL, addrs_10yr), 999)));

rv_c14_addrs_per_adl_c6 := __common__( if(not(truedid), NULL, min(if(addrs_per_adl_c6 = NULL, -NULL, addrs_per_adl_c6), 999)));

rv_c14_addrs_15yr := __common__( if(not(truedid), NULL, min(if(addrs_15yr = NULL, -NULL, addrs_15yr), 999)));

rv_c22_inp_addr_occ_index := __common__( if(not(add_input_pop and truedid), NULL, (Integer)add_input_occ_index));

rv_c22_inp_addr_owned_not_occ := __common__( if(not(add_input_pop and truedid), NULL, (Integer)add_input_owned_not_occ));

rv_a41_prop_owner := __common__( map(
    not(truedid)                                                                                   => NULL,
    add_input_naprop = 4 or add_curr_naprop = 4 or add_prev_naprop = 4 or property_owned_total > 0 => 1,
                                                                                                      0));

rv_a41_a42_prop_owner_history := __common__( map(
    not(truedid)                                                                     => '',
    add_input_naprop = 4 or add_curr_naprop = 4 or property_owned_total > 0          => 'CURRENT',
    add_prev_naprop = 4 or Models.Common.findw_cpp(ver_sources, 'P' , ', ', 'E') > 0 => 'HISTORICAL',
                                                                                        'NEVER'));

rv_email_count := __common__( if(not(truedid), NULL, min(if(email_count = NULL, -NULL, email_count), 999)));

rv_email_domain_free_count := __common__( if(not(truedid), NULL, min(if(email_domain_free_count = NULL, -NULL, email_domain_free_count), 999)));

rv_email_domain_isp_count := __common__( if(not(truedid), NULL, min(if(email_domain_ISP_count = NULL, -NULL, email_domain_ISP_count), 999)));

rv_i60_inq_count12 := __common__( if(not(truedid), NULL, min(if(inq_count12 = NULL, -NULL, inq_count12), 999)));

rv_i60_credit_seeking := __common__( if(not(truedid), NULL, if(max(min(2, if(inq_auto_count03 = NULL, -NULL, inq_auto_count03)), min(2, if(inq_banking_count03 = NULL, -NULL, inq_banking_count03)), min(2, if(inq_mortgage_count03 = NULL, -NULL, inq_mortgage_count03)), min(2, if(inq_retail_count03 = NULL, -NULL, inq_retail_count03)), min(2, if(inq_communications_count03 = NULL, -NULL, inq_communications_count03))) = NULL, NULL, sum(if(min(2, if(inq_auto_count03 = NULL, -NULL, inq_auto_count03)) = NULL, 0, min(2, if(inq_auto_count03 = NULL, -NULL, inq_auto_count03))), if(min(2, if(inq_banking_count03 = NULL, -NULL, inq_banking_count03)) = NULL, 0, min(2, if(inq_banking_count03 = NULL, -NULL, inq_banking_count03))), if(min(2, if(inq_mortgage_count03 = NULL, -NULL, inq_mortgage_count03)) = NULL, 0, min(2, if(inq_mortgage_count03 = NULL, -NULL, inq_mortgage_count03))), if(min(2, if(inq_retail_count03 = NULL, -NULL, inq_retail_count03)) = NULL, 0, min(2, if(inq_retail_count03 = NULL, -NULL, inq_retail_count03))), if(min(2, if(inq_communications_count03 = NULL, -NULL, inq_communications_count03)) = NULL, 0, min(2, if(inq_communications_count03 = NULL, -NULL, inq_communications_count03)))))));

rv_i60_inq_recency := __common__( map(
	   not(truedid) 					=> NULL,
	   (boolean)inq_count01  => 1,
	   (boolean)inq_count03  => 3,
	   (boolean)inq_count06  => 6,
	   (boolean)inq_count12  => 12,
	   (boolean)inq_count24  => 24,
	   (boolean)inq_count    => 99,
																0));

rv_i61_inq_collection_count12 := __common__( if(not(truedid), NULL, min(if(inq_collection_count12 = NULL, -NULL, inq_collection_count12), 999)));

rv_i61_inq_collection_recency := __common__( map(
    not(truedid)           => NULL,
    (Boolean)inq_collection_count01 => 1,
    (Boolean)inq_collection_count03 => 3,
    (Boolean)inq_collection_count06 => 6,
    (Boolean)inq_collection_count12 => 12,
    (Boolean)inq_collection_count24 => 24,
    (Boolean)inq_collection_count   => 99,
                              0));

rv_i60_inq_auto_count12 := __common__( if(not(truedid), NULL, min(if(inq_auto_count12 = NULL, -NULL, inq_auto_count12), 999)));

rv_i60_inq_auto_recency := __common__( map(
    not(truedid)     => NULL,
    (Boolean)inq_auto_count01 => 1,
    (Boolean)inq_auto_count03 => 3,
    (Boolean)inq_auto_count06 => 6,
    (Boolean)inq_auto_count12 => 12,
    (Boolean)inq_auto_count24 => 24,
    (Boolean)inq_auto_count   => 99,
                        0));

rv_i60_inq_banking_count12 := __common__( if(not(truedid), NULL, min(if(inq_banking_count12 = NULL, -NULL, inq_banking_count12), 999)));

rv_i60_inq_mortgage_count12 := __common__( if(not(truedid), NULL, min(if(inq_mortgage_count12 = NULL, -NULL, inq_mortgage_count12), 999)));

rv_i60_inq_hiriskcred_count12 := __common__( if(not(truedid), NULL, min(if(inq_highRiskCredit_count12 = NULL, -NULL, inq_highRiskCredit_count12), 999)));

rv_i60_inq_hiriskcred_recency := __common__( map(
    not(truedid)               => NULL,
    (Boolean)inq_highRiskCredit_count01 => 1,
    (Boolean)inq_highRiskCredit_count03 => 3,
    (Boolean)inq_highRiskCredit_count06 => 6,
    (Boolean)inq_highRiskCredit_count12 => 12,
    (Boolean)inq_highRiskCredit_count24 => 24,
    (Boolean)inq_highRiskCredit_count   => 99,
                                  0));

rv_i60_inq_prepaidcards_recency := __common__( map(
    not(truedid)             => NULL,
    (Boolean)inq_PrepaidCards_count01 => 1,
    (Boolean)inq_PrepaidCards_count03 => 3,
    (Boolean)inq_PrepaidCards_count06 => 6,
    (Boolean)inq_PrepaidCards_count12 => 12,
    (Boolean)inq_PrepaidCards_count24 => 24,
    (Boolean)inq_PrepaidCards_count   => 99,
                                0));

rv_i60_inq_retail_recency := __common__( map(
    not(truedid)       => NULL,
    (Boolean)inq_retail_count01 => 1,
    (Boolean)inq_retail_count03 => 3,
    (Boolean)inq_retail_count06 => 6,
    (Boolean)inq_retail_count12 => 12,
    (Boolean)inq_retail_count24 => 24,
    (Boolean)inq_retail_count   => 99,
                          0));

rv_i60_inq_retpymt_count12 := __common__( if(not(truedid), NULL, min(if(inq_retailpayments_count12 = NULL, -NULL, inq_retailpayments_count12), 999)));

rv_i60_inq_retpymt_recency := __common__( map(
    not(truedid)               => NULL,
    (Boolean)inq_retailpayments_count01 => 1,
    (Boolean)inq_retailpayments_count03 => 3,
    (Boolean)inq_retailpayments_count06 => 6,
    (Boolean)inq_retailpayments_count12 => 12,
    (Boolean)inq_retailpayments_count24 => 24,
    (Boolean)inq_retailpayments_count   => 99,
                                  0));

rv_i60_inq_comm_count12 := __common__( if(not(truedid), NULL, min(if(inq_communications_count12 = NULL, -NULL, inq_communications_count12), 999)));

rv_i60_inq_comm_recency := __common__( map(
    not(truedid)               => NULL,
    (Boolean)inq_communications_count01 => 1,
    (Boolean)inq_communications_count03 => 3,
    (Boolean)inq_communications_count06 => 6,
    (Boolean)inq_communications_count12 => 12,
    (Boolean)inq_communications_count24 => 24,
    (Boolean)inq_communications_count   => 99,
                                  0));

rv_l79_adls_per_addr_curr := __common__( if(not(addrpop), NULL, min(if(adls_per_addr_curr = NULL, -NULL, adls_per_addr_curr), 999)));

rv_l79_adls_per_apt_addr := __common__( map(
    not(addrpop)     => NULL,
    iv_add_apt = '0' => -1,
                        min(if(adls_per_addr_curr = NULL, -NULL, adls_per_addr_curr), 999)));

rv_l79_adls_per_sfd_addr := __common__( map(
    not(addrpop)     => NULL,
    iv_add_apt = '1' => -1,
                        min(if(adls_per_addr_curr = NULL, -NULL, adls_per_addr_curr), 999)));

rv_l79_adls_per_addr_c6 := __common__( if(not(addrpop), NULL, min(if(adls_per_addr_c6 = NULL, -NULL, adls_per_addr_c6), 999)));

rv_l79_adls_per_apt_addr_c6 := __common__( map(
    not(addrpop)     => NULL,
    iv_add_apt = '0' => -1,
                        min(if(adls_per_addr_c6 = NULL, -NULL, adls_per_addr_c6), 999)));

rv_l79_adls_per_sfd_addr_c6 := __common__( map(
    not(addrpop)     => NULL,
    iv_add_apt = '1' => -1,
                        min(if(adls_per_addr_c6 = NULL, -NULL, adls_per_addr_c6), 999)));

rv_c18_invalid_addrs_per_adl := __common__( if(not(truedid), NULL, min(if(invalid_addrs_per_adl = NULL, -NULL, invalid_addrs_per_adl), 999)));

rv_c13_attr_addrs_recency := __common__( map(
	    not(truedid)      					=> NULL,
	    (boolean)attr_addrs_last30 	=> 1,
	    (boolean)attr_addrs_last90 	=> 3,
	    (boolean)attr_addrs_last12 	=> 12,
	    (boolean)attr_addrs_last24 	=> 24,
	    (boolean)attr_addrs_last36 	=> 36,
	    (boolean)addrs_5yr         	=> 60,
	    (boolean)addrs_10yr        	=> 120,
	    (boolean)addrs_15yr        	=> 180,
	    addrs_per_adl > 0 					=> 999,
																		 0));

	rv_d32_attr_felonies_recency := __common__( map(
	    not(truedid)     					=> NULL,
	    (boolean)attr_felonies30  => 1,
	    (boolean)attr_felonies90  => 3,
	    (boolean)attr_felonies180 => 6,
	    (boolean)attr_felonies12  => 12,
	    (boolean)attr_felonies24  => 24,
	    (boolean)attr_felonies36  => 36,
	    (boolean)attr_felonies60  => 60,
	    felony_count > 0 					=> 99,
																	0));

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
                                                                                 0));

iv_f00_nas_summary := __common__( if(not(truedid and ssnlength > '0'), NULL, (Integer)trim((string)nas_summary, LEFT)));

iv_fname_non_phn_src_ct := __common__( if(not(truedid and fnamepop), NULL, min(if(rc_fnamecount = NULL, -NULL, rc_fnamecount), 999)));

iv_lname_non_phn_src_ct := __common__( if(not(truedid and lnamepop), NULL, min(if(rc_lnamecount = NULL, -NULL, rc_lnamecount), 999)));

iv_full_name_non_phn_src_ct := __common__( if(not(truedid and fnamepop and lnamepop), NULL, min(if(source_count = NULL, -NULL, source_count), 999)));

iv_full_name_ver_sources := __common__( map(
    not((hphnpop or addrpop) and lnamepop and fnamepop)                                            => '             ',
    source_count > 0 and not(fname_eda_sourced_type = '') and not(lname_eda_sourced_type = '') => 'PHN & NONPHN ',
    source_count > 0                                                                               => 'NONPHN ONLY  ',
    not(fname_eda_sourced_type = '') and not(lname_eda_sourced_type = '')                      => 'PHN ONLY     ',
                                                                                                      'NAME NOT VERD'));

iv_addr_non_phn_src_ct := __common__( if(not(truedid and add_input_pop), NULL, min(if(rc_addrcount = NULL, -NULL, rc_addrcount), 999)));

iv_c22_addr_ver_sources := __common__( map(
    not(truedid and add_input_pop)                                             => '             ',
    rc_addrcount > 0 and (rc_phoneaddrcount > 0 or rc_phoneaddr_addrcount > 0) => 'PHN & NONPHN ',
    rc_addrcount > 0                                                           => 'NONPHN ONLY  ',
    rc_phoneaddrcount > 0 or rc_phoneaddr_addrcount > 0                        => 'PHN ONLY     ',
                                                                                  'ADDR NOT VERD'));

iv_dob_src_ct := __common__( if(not(truedid and dobpop), NULL, min(if(combo_dobcount = NULL, -NULL, combo_dobcount), 999)));

_nap_ver := __common__( (nap_summary in [6, 10, 11, 12]));

_inf_ver := __common__( (infutor_nap in [6, 10, 11, 12]));

iv_phn_addr_verified := __common__( map(
    not(_nap_ver) and not(_inf_ver) => '0 NONE VERD',
    not(_nap_ver) and _inf_ver      => '1 INF ONLY ',
    _nap_ver and not(_inf_ver)      => '2 NAP ONLY ',
                                       '3 BOTH VERD'));

iv_l77_dwelltype := __common__( map(
    not(add_input_pop)  => '   ',
    rc_dwelltype = '' => 'SFD',
    rc_dwelltype = 'A'  => 'MFD',
    rc_dwelltype = 'E'  => 'POB',
    rc_dwelltype = 'R'  => 'RR ',
    rc_dwelltype = 'S'  => 'GEN',
                           ''));

iv_c13_avg_lres := __common__( if(not(truedid), NULL, min(if(avg_lres = NULL, -NULL, avg_lres), 999)));

rv_f01_inp_add_house_num_match := __common__( if(not(add_input_pop and truedid), NULL, (Integer)add_input_house_number_match));

rv_c13_inp_addr_lres := __common__( if(not(add_input_pop and truedid), NULL, min(if(add_input_lres = NULL, -NULL, add_input_lres), 999)));

rv_c12_inp_addr_source_count := __common__( if(not(add_input_pop and truedid), NULL, min(if(add_input_source_count = NULL, -NULL, add_input_source_count), 999)));

mortgage_type_1 := __common__( add_input_mortgage_type);

mortgage_present_1 := __common__( not((add_input_mortgage_date in [0, NULL])));

iv_inp_addr_mortgage_type := __common__(__common__( map(
    not(truedid and add_input_pop)                          => '               ',
    (mortgage_type_1 in ['CNV', 'N'])                       => 'CONVENTIONAL   ',
    (mortgage_type_1 in ['FHA', 'G', 'VA'])                 => 'GOVERNMENT     ',
    (mortgage_type_1 in ['1', 'D'])                         => 'PIGGYBACK      ',
    (mortgage_type_1 in ['2', 'E', 'R', 'C'])               => 'EQUITY LOAN    ',
    (mortgage_type_1 in ['I', 'K', 'O', 'LHM', 'T', 'SBA']) => 'COMMERCIAL     ',
    (mortgage_type_1 in ['H', 'J'])                         => 'HIGH-RISK      ',
    (mortgage_type_1 in ['PMM', 'PP', 'S', 'L'])            => 'NON-TRADITIONAL',
    (mortgage_type_1 in ['U'])                              => 'UNKNOWN        ',
    not(mortgage_type_1 = '')                             => 'OTHER          ',
    mortgage_present_1                                        => 'UNKNOWN        ',
                                                               'NO MORTGAGE')));

iv_inp_addr_financing_type := __common__( map(
    not(truedid and add_input_pop)  => '     ',
    add_input_financing_type = '' => 'NONE ',
                                       trim(add_input_financing_type, LEFT)));

iv_inp_add_avm_chg_1yr := __common__( map(
    not(add_input_pop)                                          => NULL,
    add_input_lres < 12                                         => NULL,
    add_input_avm_auto_val > 0 and add_input_avm_auto_val_2 > 0 => add_input_avm_auto_val - add_input_avm_auto_val_2,
                                                                   NULL));

iv_inp_add_avm_pct_chg_1yr := __common__( map(
    not(add_input_pop)                                          => NULL,
    add_input_lres < 12                                         => NULL,
    add_input_avm_auto_val > 0 and add_input_avm_auto_val_2 > 0 => add_input_avm_auto_val / add_input_avm_auto_val_2,
                                                                   NULL));

iv_inp_add_avm_chg_2yr := __common__( map(
    not(add_input_pop)                                          => NULL,
    add_input_lres < 12 * 2                                     => NULL,
    add_input_avm_auto_val > 0 and add_input_avm_auto_val_3 > 0 => add_input_avm_auto_val - add_input_avm_auto_val_3,
                                                                   NULL));

iv_inp_add_avm_pct_chg_2yr := __common__( map(
    not(add_input_pop)                                          => NULL,
    add_input_lres < 12 * 2                                     => NULL,
    add_input_avm_auto_val > 0 and add_input_avm_auto_val_3 > 0 => add_input_avm_auto_val / add_input_avm_auto_val_3,
                                                                   NULL));

iv_inp_add_avm_chg_3yr := __common__( map(
    not(add_input_pop)                                          => NULL,
    add_input_lres < 12 * 3                                     => NULL,
    add_input_avm_auto_val > 0 and add_input_avm_auto_val_4 > 0 => add_input_avm_auto_val - add_input_avm_auto_val_4,
                                                                   NULL));

iv_inp_add_avm_pct_chg_3yr := __common__( map(
    not(add_input_pop)                                          => NULL,
    add_input_lres < 12 * 3                                     => NULL,
    add_input_avm_auto_val > 0 and add_input_avm_auto_val_4 > 0 => add_input_avm_auto_val / add_input_avm_auto_val_4,
                                                                   NULL));

mortgage_type := __common__( if(truedid and add_curr_pop, add_curr_mortgage_type, mortgage_type_1));

mortgage_present := __common__( if(truedid and add_curr_pop, not((add_curr_mortgage_date in [0, NULL])), mortgage_present_1));

iv_curr_add_mortgage_type := __common__( map(
    not(truedid and add_curr_pop)                         => '               ',
    (mortgage_type in ['CNV', 'N'])                       => 'CONVENTIONAL   ',
    (mortgage_type in ['FHA', 'G', 'VA'])                 => 'GOVERNMENT     ',
    (mortgage_type in ['1', 'D'])                         => 'PIGGYBACK      ',
    (mortgage_type in ['2', 'E', 'R', 'C'])               => 'EQUITY LOAN    ',
    (mortgage_type in ['I', 'K', 'O', 'LHM', 'T', 'SBA']) => 'COMMERCIAL     ',
    (mortgage_type in ['H', 'J'])                         => 'HIGH-RISK      ',
    (mortgage_type in ['PMM', 'PP', 'S', 'L'])            => 'NON-TRADITIONAL',
    (mortgage_type in ['U'])                              => 'UNKNOWN        ',
    not(mortgage_type = '')                             => 'OTHER          ',
    mortgage_present                                      => 'UNKNOWN        ',
                                                             'NO MORTGAGE'));

iv_curr_add_financing_type := __common__( map(
    not(truedid and add_curr_pop)  => '     ',
    add_curr_financing_type = '' => 'NONE ',
                                      add_curr_financing_type));

rv_a49_curr_add_avm_chg_2yr := __common__( map(
    not(add_curr_pop)                                         => NULL,
    add_curr_lres < 12 * 2                                    => NULL,
    add_curr_avm_auto_val > 0 and add_curr_avm_auto_val_3 > 0 => add_curr_avm_auto_val - add_curr_avm_auto_val_3,
                                                                 NULL));

rv_a49_curr_add_avm_pct_chg_2yr := __common__( map(
    not(add_curr_pop)                                         => NULL,
    add_curr_lres < 12 * 2                                    => NULL,
    add_curr_avm_auto_val > 0 and add_curr_avm_auto_val_3 > 0 => add_curr_avm_auto_val / add_curr_avm_auto_val_3,
                                                                 NULL));

rv_a49_curr_add_avm_chg_3yr := __common__( map(
    not(add_curr_pop)                                         => NULL,
    add_curr_lres < 12 * 3                                    => NULL,
    add_curr_avm_auto_val > 0 and add_curr_avm_auto_val_4 > 0 => add_curr_avm_auto_val - add_curr_avm_auto_val_4,
                                                                 NULL));

rv_a49_curr_add_avm_pct_chg_3yr := __common__( map(
    not(add_curr_pop)                                         => NULL,
    add_curr_lres < 12 * 3                                    => NULL,
    add_curr_avm_auto_val > 0 and add_curr_avm_auto_val_4 > 0 => add_curr_avm_auto_val / add_curr_avm_auto_val_4,
                                                                 NULL));

iv_prv_addr_lres := __common__( if(not(truedid and add_prev_pop), NULL, min(if(add_prev_lres = NULL, -NULL, add_prev_lres), 999)));

iv_prv_addr_avm_auto_val := __common__( if(not(add_prev_pop), NULL, add_prev_avm_auto_val));

iv_a46_l77_addrs_move_traj := __common__( if(not(truedid), NULL, (Integer)addrs_move_trajectory));

iv_a46_l77_addrs_move_traj_index := __common__( if(not(truedid), NULL, (Integer)addrs_move_trajectory_index));

iv_unverified_addr_count := __common__( if(not(truedid), NULL, min(if(unverified_addr_count = NULL, -NULL, unverified_addr_count), 999)));

iv_c14_addrs_per_adl := __common__( if(not(truedid), NULL, min(if(addrs_per_adl = NULL, -NULL, addrs_per_adl), 999)));

rv_i60_inq_other_count12 := __common__( if(not(truedid), NULL, min(if(inq_other_count12 = NULL, -NULL, inq_other_count12), 999)));

	rv_i60_inq_other_recency := __common__( map(
	    not(truedid)      				 => NULL,
	    (boolean)inq_other_count01 => 1,
	    (boolean)inq_other_count03 => 3,
	    (boolean)inq_other_count06 => 6,
	    (boolean)inq_other_count12 => 12,
	    (boolean)inq_other_count24 => 24,
	    (boolean)inq_other_count   => 99,
																		0));
rv_i62_inq_ssns_per_adl := __common__( if(not(truedid), NULL, min(if(inq_ssnsperadl = NULL, -NULL, inq_ssnsperadl), 999)));

rv_i62_inq_addrs_per_adl := __common__( if(not(truedid), NULL, min(if(inq_addrsperadl = NULL, -NULL, inq_addrsperadl), 999)));

rv_i62_inq_num_names_per_adl := __common__( if(not(truedid), NULL, max(inq_fnamesperadl, inq_lnamesperadl)));

rv_i62_inq_phones_per_adl := __common__( if(not(truedid), NULL, min(if(inq_phonesperadl = NULL, -NULL, inq_phonesperadl), 999)));

rv_i62_inq_dobs_per_adl := __common__( if(not(truedid), NULL, min(if(inq_dobsperadl = NULL, -NULL, inq_dobsperadl), 999)));

br_first_seen_char := __common__( br_first_seen);

_br_first_seen := __common__( common.sas_date((string)(br_first_seen_char)));

rv_mos_since_br_first_seen := __common__( map(
    not(truedid)          => NULL,
    _br_first_seen = NULL => -1,
                             min(if(if ((sysdate - _br_first_seen) / (365.25 / 12) >= 0, truncate((sysdate - _br_first_seen) / (365.25 / 12)), roundup((sysdate - _br_first_seen) / (365.25 / 12))) = NULL, -NULL, if ((sysdate - _br_first_seen) / (365.25 / 12) >= 0, truncate((sysdate - _br_first_seen) / (365.25 / 12)), roundup((sysdate - _br_first_seen) / (365.25 / 12)))), 999)));

rv_br_active_phone_count := __common__( if(not(truedid), NULL, min(if(br_active_phone_count = NULL, -NULL, br_active_phone_count), 999)));

iv_br_source_count := __common__( if(not(truedid), NULL, min(if(br_source_count = NULL, -NULL, br_source_count), 999)));

rv_e58_br_dead_bus_x_active_phn := __common__( __common__( if(not(truedid), '   ', trim((String)min(if(br_dead_business_count = NULL, -NULL, br_dead_business_count), 3), LEFT, RIGHT) + trim('-', LEFT, RIGHT) + trim((String)min(if(br_active_phone_count = NULL, -NULL, br_active_phone_count), 3), LEFT, RIGHT))));

	br_company_title1 := stringlib.StringSubstituteOut(br_company_title, '.,/\\-#:()*', ' '); 
	br_company_title2 := br_company_title1;

	rv_bus_leadership_title := map(
	    not(truedid)                                                                                    => NULL,
	    br_company_title2 = ''                                                                          => -1,
	    contains_i(Std.Str.ToUpperCase(br_company_title2), 'CEO') > 0                                                        => 1,
	    contains_i(Std.Str.ToUpperCase(br_company_title2), 'CFO') > 0                                                        => 1,
	    contains_i(Std.Str.ToUpperCase(br_company_title2), 'CHAIRMAN') > 0                                                   => 1,
	    contains_i(Std.Str.ToUpperCase(br_company_title2), 'DIRECTOR') > 0                                                   => 1,
	    contains_i(Std.Str.ToUpperCase(br_company_title2), 'FOUNDER') > 0                                                    => 1,
	    contains_i(Std.Str.ToUpperCase(br_company_title2), 'PRESIDENT') > 0                                                  => 1,
	    contains_i(Std.Str.ToUpperCase(br_company_title2), 'TREASURER') > 0                                                  => 1,
	    contains_i(Std.Str.ToUpperCase(br_company_title2), 'VP') > 0                                                         => 1,
	    contains_i(Std.Str.ToUpperCase(br_company_title2), 'DIRECTORS') > 0                                                  => 1,
	    contains_i(Std.Str.ToUpperCase(br_company_title2), 'CHIEF') > 0                                                      => 1,
	    //contains_i(Std.Str.ToUpperCase(br_company_title2), 'VICE') > 0                                                       => 1,
	    //contains_i(Std.Str.ToUpperCase(br_company_title2), 'PRES') > 0                                                       => 1,
	    indexw(Std.Str.ToUpperCase(br_company_title2), 'VICE', ' ')                                                    	 		 => 1,
	    contains_i(Std.Str.ToUpperCase(br_company_title2), 'OWNER') > 0                                                      => 1,
	    indexw(Std.Str.ToUpperCase(br_company_title2), 'PRES', ' ')                                                		   		 => 1,
	    contains_i(Std.Str.ToUpperCase(br_company_title2), 'TREAS') > 0                                                      => 1,
	    contains_i(Std.Str.ToUpperCase(br_company_title2), 'EXECUTIVE') > 0                                                  => 1,
	    contains_i(Std.Str.ToUpperCase(br_company_title2), 'PARTNER') > 0                                                    => 1,
	    (Std.Str.ToUpperCase(br_company_title2) in ['PRIN', 'PRINCIPAL', 'GENERAL MANAGER', 'VICEPRES', 'GEN MGR', 'PRESI']) => 1,
																																																															0);
																																																															
iv_d34_liens_unrel_cj_ct := __common__( if(not(truedid), NULL, min(if(liens_unrel_CJ_ct = NULL, -NULL, liens_unrel_CJ_ct), 999)));

iv_d34_liens_unrel_ft_ct := __common__( if(not(truedid), NULL, min(if(liens_unrel_FT_ct = NULL, -NULL, liens_unrel_FT_ct), 999)));

iv_d34_liens_unrel_sc_ct := __common__( if(not(truedid), NULL, min(if(liens_unrel_SC_ct = NULL, -NULL, liens_unrel_SC_ct), 999)));

iv_college_tier := __common__( map(
    not(truedid)        => NULL,
    college_tier = '' => -1,
                           (Integer)trim(college_tier, LEFT)));

major_medical := __common__( contains_i(StringLib.StringToUpperCase(college_major), 'A') > 0 or contains_i(StringLib.StringToUpperCase(college_major), 'E') > 0 or contains_i(StringLib.StringToUpperCase(college_major), 'L') > 0 or contains_i(StringLib.StringToUpperCase(college_major), 'Q') > 0 or contains_i(StringLib.StringToUpperCase(college_major), 'T') > 0 or contains_i(StringLib.StringToUpperCase(college_major), 'V') > 0 or contains_i(StringLib.StringToUpperCase(college_major), '040') > 0 or contains_i(StringLib.StringToUpperCase(college_major), '041') > 0 or contains_i(StringLib.StringToUpperCase(college_major), '044') > 0);

major_science := __common__( contains_i(StringLib.StringToUpperCase(college_major), 'D') > 0 or contains_i(StringLib.StringToUpperCase(college_major), 'H') > 0 or contains_i(StringLib.StringToUpperCase(college_major), 'M') > 0 or contains_i(StringLib.StringToUpperCase(college_major), 'N') > 0 or contains_i(StringLib.StringToUpperCase(college_major), '046') > 0 or contains_i(StringLib.StringToUpperCase(college_major), '006') > 0 or contains_i(StringLib.StringToUpperCase(college_major), '022') > 0 or contains_i(StringLib.StringToUpperCase(college_major), '026') > 0 or contains_i(StringLib.StringToUpperCase(college_major), '029') > 0 or contains_i(StringLib.StringToUpperCase(college_major), '031') > 0 or contains_i(StringLib.StringToUpperCase(college_major), '036') > 0);

major_liberal := __common__( contains_i(StringLib.StringToUpperCase(college_major), 'C') > 0 or contains_i(StringLib.StringToUpperCase(college_major), 'F') > 0 or contains_i(StringLib.StringToUpperCase(college_major), 'I') > 0 or contains_i(StringLib.StringToUpperCase(college_major), 'J') > 0 or contains_i(StringLib.StringToUpperCase(college_major), 'K') > 0 or contains_i(StringLib.StringToUpperCase(college_major), 'O') > 0 or contains_i(StringLib.StringToUpperCase(college_major), 'W') > 0 or contains_i(StringLib.StringToUpperCase(college_major), 'Y') > 0 or contains_i(StringLib.StringToUpperCase(college_major), '007') > 0 or contains_i(StringLib.StringToUpperCase(college_major), '013') > 0 or contains_i(StringLib.StringToUpperCase(college_major), '015') > 0 or contains_i(StringLib.StringToUpperCase(college_major), '027') > 0 or contains_i(StringLib.StringToUpperCase(college_major), '032') > 0 or contains_i(StringLib.StringToUpperCase(college_major), '033') > 0 or contains_i(StringLib.StringToUpperCase(college_major), '035') > 0 or contains_i(StringLib.StringToUpperCase(college_major), '037') > 0 or contains_i(StringLib.StringToUpperCase(college_major), '038') > 0 or contains_i(StringLib.StringToUpperCase(college_major), '039') > 0 or contains_i(StringLib.StringToUpperCase(college_major), '042') > 0 or contains_i(StringLib.StringToUpperCase(college_major), '043') > 0 or contains_i(StringLib.StringToUpperCase(college_major), '003') > 0);

major_business := __common__( contains_i(StringLib.StringToUpperCase(college_major), 'B') > 0 or contains_i(StringLib.StringToUpperCase(college_major), 'G') > 0 or contains_i(StringLib.StringToUpperCase(college_major), 'P') > 0 or contains_i(StringLib.StringToUpperCase(college_major), 'R') > 0 or contains_i(StringLib.StringToUpperCase(college_major), 'S') > 0 or contains_i(StringLib.StringToUpperCase(college_major), 'Z') > 0 or contains_i(StringLib.StringToUpperCase(college_major), '009') > 0 or contains_i(StringLib.StringToUpperCase(college_major), '045') > 0);

major_unknown := __common__( contains_i(StringLib.StringToUpperCase(college_major), 'U') > 0);

iv_college_major := __common__( map(
    not(truedid)                => '',
    major_medical               => 'MEDICAL',
    major_science               => 'SCIENCE',
    major_liberal               => 'LIBERAL ARTS',
    major_business              => 'BUSINESS',
    major_unknown               => 'UNCLASSIFIED',
    not(college_code = '')    => 'UNCLASSIFIED',
    not(((String)college_date_first_seen in [ '0', ' '])) => 'NO COLLEGE FOUND',
                  'NO AMS FOUND'));
iv_college_type := __common__( map(
    not(truedid)        => '',
    college_type = '' => '-1',
                           college_type));

iv_college_code_x_type := __common__( map(
    not(truedid)                               => '',
    college_code = '' or college_type = '' => '-1',
                                                  college_code + '-' + college_type));

iv_college_file_type := __common__( map(
    not(truedid)             => '',
    college_file_type = 'M'  => '',
    college_file_type = '' => '-1',
                                college_file_type));

iv_prof_license_source := __common__( if(not(truedid), '', trim(Prof_license_source, LEFT)));

iv_prof_license_category := __common__( map(
    not(truedid)                 => NULL,
    prof_license_category = '' => -1,
                                    (Integer)trim(prof_license_category, LEFT)));

	iv_prof_license_category_pl := __common__( map(
	    not(truedid) or prof_license_source != 'PL' 	=> NULL,
	    prof_license_category = ''		               	=> -1,
																											 (Integer)trim(prof_license_category, LEFT)));

nf_bus_addr_match_count := __common__( if(not(addrpop), NULL, bus_addr_match_count));

nf_bus_phone_match := __common__( if(not(addrpop), NULL, bus_phone_match));

adl_util_i := __common__( if(contains_i(StringLib.StringToUpperCase(util_adl_type_list), '1') > 0, 'I', ' '));

adl_util_c := __common__( if(contains_i(StringLib.StringToUpperCase(util_adl_type_list), '2') > 0, 'C', ' '));

adl_util_m := __common__( if(contains_i(StringLib.StringToUpperCase(util_adl_type_list), 'Z') > 0, 'M', ' '));

nf_util_adl_summary := __common__( __common__( if(not(truedid), '', '|' + (string)adl_util_i + (string)adl_util_c + (string)adl_util_m + '|')));

nf_util_adl_count := __common__( if(not(truedid), NULL, util_adl_count));

inp_util_i := __common__( if(contains_i(StringLib.StringToUpperCase(util_add_input_type_list), '1') > 0, 'I', ' '));

inp_util_c := __common__( if(contains_i(StringLib.StringToUpperCase(util_add_input_type_list), '2') > 0, 'C', ' '));

inp_util_m := __common__( if(contains_i(StringLib.StringToUpperCase(util_add_input_type_list), 'Z') > 0, 'M', ' '));

nf_util_add_input_summary := __common__( __common__( if(not(addrpop), '', '|' + (string)inp_util_i + (string)inp_util_c + (string)inp_util_m + '|')));

curr_util_i := __common__( if(contains_i(StringLib.StringToUpperCase(util_add_curr_type_list), '1') > 0, 'I', ' '));

curr_util_c := __common__( if(contains_i(StringLib.StringToUpperCase(util_add_curr_type_list), '2') > 0, 'C', ' '));

curr_util_m := __common__( if(contains_i(StringLib.StringToUpperCase(util_add_curr_type_list), 'Z') > 0, 'M', ' '));

nf_util_add_curr_summary := __common__( __common__( if(not(truedid) and add_curr_pop, '', '|' + (string)curr_util_i + (string)curr_util_c + (string)curr_util_m + '|')));

nf_add_input_mobility_index := __common__( map(
    not(addrpop)                 => NULL,
    add_input_occupants_1yr <= 0 => -1,
                                    if(max(add_input_turnover_1yr_in, add_input_turnover_1yr_out) = NULL, NULL, sum(if(add_input_turnover_1yr_in = NULL, 0, add_input_turnover_1yr_in), if(add_input_turnover_1yr_out = NULL, 0, add_input_turnover_1yr_out))) / add_input_occupants_1yr));

add_input_nhood_prop_sum_3 := __common__( if(max(add_input_nhood_BUS_ct, add_input_nhood_SFD_ct, add_input_nhood_MFD_ct) = NULL, NULL, sum(if(add_input_nhood_BUS_ct = NULL, 0, add_input_nhood_BUS_ct), if(add_input_nhood_SFD_ct = NULL, 0, add_input_nhood_SFD_ct), if(add_input_nhood_MFD_ct = NULL, 0, add_input_nhood_MFD_ct))));

nf_add_input_nhood_bus_pct := __common__( map(
    not(addrpop)               => NULL,
    add_input_nhood_BUS_ct = 0 => -1,
                                  add_input_nhood_BUS_ct / add_input_nhood_prop_sum_3));

add_input_nhood_prop_sum_2 := __common__( if(max(add_input_nhood_BUS_ct, add_input_nhood_SFD_ct, add_input_nhood_MFD_ct) = NULL, NULL, sum(if(add_input_nhood_BUS_ct = NULL, 0, add_input_nhood_BUS_ct), if(add_input_nhood_SFD_ct = NULL, 0, add_input_nhood_SFD_ct), if(add_input_nhood_MFD_ct = NULL, 0, add_input_nhood_MFD_ct))));

nf_add_input_nhood_mfd_pct := __common__( map(
    not(addrpop)               => NULL,
    add_input_nhood_MFD_ct = 0 => -1,
                                  add_input_nhood_MFD_ct / add_input_nhood_prop_sum_2));

add_input_nhood_prop_sum_1 := __common__( if(max(add_input_nhood_BUS_ct, add_input_nhood_SFD_ct, add_input_nhood_MFD_ct) = NULL, NULL, sum(if(add_input_nhood_BUS_ct = NULL, 0, add_input_nhood_BUS_ct), if(add_input_nhood_SFD_ct = NULL, 0, add_input_nhood_SFD_ct), if(add_input_nhood_MFD_ct = NULL, 0, add_input_nhood_MFD_ct))));

nf_add_input_nhood_sfd_pct := __common__( map(
    not(addrpop)               => NULL,
    add_input_nhood_SFD_ct = 0 => -1,
                                  add_input_nhood_SFD_ct / add_input_nhood_prop_sum_1));

add_input_nhood_prop_sum := __common__( if(max(add_input_nhood_BUS_ct, add_input_nhood_SFD_ct, add_input_nhood_MFD_ct) = NULL, NULL, sum(if(add_input_nhood_BUS_ct = NULL, 0, add_input_nhood_BUS_ct), if(add_input_nhood_SFD_ct = NULL, 0, add_input_nhood_SFD_ct), if(add_input_nhood_MFD_ct = NULL, 0, add_input_nhood_MFD_ct))));

nf_add_input_nhood_vac_pct := __common__( map(
    not(addrpop)                 => NULL,
    add_input_nhood_prop_sum = 0 => -1,
                                    add_input_nhood_VAC_prop / add_input_nhood_prop_sum));

nf_add_curr_mobility_index := __common__( map(
    not(addrpop)                => NULL,
    add_curr_occupants_1yr <= 0 => -1,
                                   if(max(add_curr_turnover_1yr_in, add_curr_turnover_1yr_out) = NULL, NULL, sum(if(add_curr_turnover_1yr_in = NULL, 0, add_curr_turnover_1yr_in), if(add_curr_turnover_1yr_out = NULL, 0, add_curr_turnover_1yr_out))) / add_curr_occupants_1yr));

add_curr_nhood_prop_sum_3 := __common__( if(max(add_curr_nhood_BUS_ct, add_curr_nhood_SFD_ct, add_curr_nhood_MFD_ct) = NULL, NULL, sum(if(add_curr_nhood_BUS_ct = NULL, 0, add_curr_nhood_BUS_ct), if(add_curr_nhood_SFD_ct = NULL, 0, add_curr_nhood_SFD_ct), if(add_curr_nhood_MFD_ct = NULL, 0, add_curr_nhood_MFD_ct))));

nf_add_curr_nhood_bus_pct := __common__( map(
    not(truedid) and add_curr_pop => NULL,
    add_curr_nhood_BUS_ct = 0     => -1,
                                     add_curr_nhood_BUS_ct / add_curr_nhood_prop_sum_3));

add_curr_nhood_prop_sum_2 := __common__( if(max(add_curr_nhood_BUS_ct, add_curr_nhood_SFD_ct, add_curr_nhood_MFD_ct) = NULL, NULL, sum(if(add_curr_nhood_BUS_ct = NULL, 0, add_curr_nhood_BUS_ct), if(add_curr_nhood_SFD_ct = NULL, 0, add_curr_nhood_SFD_ct), if(add_curr_nhood_MFD_ct = NULL, 0, add_curr_nhood_MFD_ct))));

nf_add_curr_nhood_mfd_pct := __common__( map(
    not(truedid) and add_curr_pop => NULL,
    add_curr_nhood_MFD_ct = 0     => -1,
                                     add_curr_nhood_MFD_ct / add_curr_nhood_prop_sum_2));

add_curr_nhood_prop_sum_1 := __common__( if(max(add_curr_nhood_BUS_ct, add_curr_nhood_SFD_ct, add_curr_nhood_MFD_ct) = NULL, NULL, sum(if(add_curr_nhood_BUS_ct = NULL, 0, add_curr_nhood_BUS_ct), if(add_curr_nhood_SFD_ct = NULL, 0, add_curr_nhood_SFD_ct), if(add_curr_nhood_MFD_ct = NULL, 0, add_curr_nhood_MFD_ct))));

nf_add_curr_nhood_sfd_pct := __common__( map(
    not(truedid) and add_curr_pop => NULL,
    add_curr_nhood_SFD_ct = 0     => -1,
                                     add_curr_nhood_SFD_ct / add_curr_nhood_prop_sum_1));

add_curr_nhood_prop_sum := __common__( if(max(add_curr_nhood_BUS_ct, add_curr_nhood_SFD_ct, add_curr_nhood_MFD_ct) = NULL, NULL, sum(if(add_curr_nhood_BUS_ct = NULL, 0, add_curr_nhood_BUS_ct), if(add_curr_nhood_SFD_ct = NULL, 0, add_curr_nhood_SFD_ct), if(add_curr_nhood_MFD_ct = NULL, 0, add_curr_nhood_MFD_ct))));

nf_add_curr_nhood_vac_pct := __common__( map(
    not(truedid) and add_curr_pop => NULL,
    add_curr_nhood_prop_sum = 0   => -1,
                                     add_curr_nhood_VAC_prop / add_curr_nhood_prop_sum));

nf_recent_disconnects := __common__( if(not(hphnpop), NULL, min(if(recent_disconnects = NULL, -NULL, recent_disconnects), 999)));

nf_phone_ver_insurance := __common__( if(not(truedid), NULL, (Integer)trim(phone_ver_insurance, LEFT)));

nf_phone_ver_experian := __common__( if(not(truedid), NULL, (Integer)trim(phone_ver_experian, LEFT)));

nf_addrs_per_ssn := __common__( if(not(ssnlength > '0'), NULL, min(if(addrs_per_ssn = NULL, -NULL, addrs_per_ssn), 999)));

nf_phones_per_addr_curr := __common__( if(not(addrpop), NULL, min(if(phones_per_addr_curr = NULL, -NULL, phones_per_addr_curr), 999)));

nf_phones_per_apt_addr_curr := __common__( map(
    not(addrpop)     => NULL,
    iv_add_apt = '0' => -1,
                        min(if(phones_per_addr_curr = NULL, -NULL, phones_per_addr_curr), 999)));

nf_phones_per_sfd_addr_curr := __common__( map(
    not(addrpop)     => NULL,
    iv_add_apt = '1' => -1,
                        min(if(phones_per_addr_curr = NULL, -NULL, phones_per_addr_curr), 999)));

nf_addrs_per_ssn_c6 := __common__( if(not(ssnlength > '0'), NULL, min(if(addrs_per_ssn_c6 = NULL, -NULL, addrs_per_ssn_c6), 999)));

nf_phones_per_addr_c6 := __common__( if(not(addrpop), NULL, min(if(phones_per_addr_c6 = NULL, -NULL, phones_per_addr_c6), 999)));

nf_phones_per_sfd_addr_c6 := __common__( map(
    not(addrpop)     => NULL,
    iv_add_apt = '1' => -1,
                        min(if(phones_per_addr_c6 = NULL, -NULL, phones_per_addr_c6), 999)));

nf_inq_count_day := __common__( if(not(truedid), NULL, min(if(inq_count_day = NULL, -NULL, inq_count_day), 999)));

nf_inq_count_week := __common__( if(not(truedid), NULL, min(if(inq_count_week = NULL, -NULL, inq_count_week), 999)));

nf_inq_count24 := __common__( if(not(truedid), NULL, min(if(inq_count24 = NULL, -NULL, inq_count24), 999)));

nf_inq_auto_count_week := __common__( if(not(truedid), NULL, min(if(inq_Auto_count_week = NULL, -NULL, inq_Auto_count_week), 999)));

nf_inq_auto_count24 := __common__( if(not(truedid), NULL, min(if(inq_Auto_count24 = NULL, -NULL, inq_Auto_count24), 999)));

nf_inq_banking_count_day := __common__( if(not(truedid), NULL, min(if(inq_Banking_count_day = NULL, -NULL, inq_Banking_count_day), 999)));

nf_inq_banking_count24 := __common__( if(not(truedid), NULL, min(if(inq_Banking_count24 = NULL, -NULL, inq_Banking_count24), 999)));

nf_inq_collection_count_week := __common__( if(not(truedid), NULL, min(if(inq_Collection_count_week = NULL, -NULL, inq_Collection_count_week), 999)));

nf_inq_collection_count24 := __common__( if(not(truedid), NULL, min(if(inq_Collection_count24 = NULL, -NULL, inq_Collection_count24), 999)));

nf_inq_communications_count_week := __common__( if(not(truedid), NULL, min(if(inq_Communications_count_week = NULL, -NULL, inq_Communications_count_week), 999)));

nf_inq_communications_count24 := __common__( if(not(truedid), NULL, min(if(inq_Communications_count24 = NULL, -NULL, inq_Communications_count24), 999)));

nf_inq_highriskcredit_count_day := __common__( if(not(truedid), NULL, min(if(inq_HighRiskCredit_count_day = NULL, -NULL, inq_HighRiskCredit_count_day), 999)));

nf_inq_highriskcredit_count_week := __common__( if(not(truedid), NULL, min(if(inq_HighRiskCredit_count_week = NULL, -NULL, inq_HighRiskCredit_count_week), 999)));

nf_inq_highriskcredit_count24 := __common__( if(not(truedid), NULL, min(if(inq_HighRiskCredit_count24 = NULL, -NULL, inq_HighRiskCredit_count24), 999)));

nf_inq_other_count_week := __common__( if(not(truedid), NULL, min(if(inq_Other_count_week = NULL, -NULL, inq_Other_count_week), 999)));

nf_inq_other_count24 := __common__( if(not(truedid), NULL, min(if(inq_Other_count24 = NULL, -NULL, inq_Other_count24), 999)));

nf_inq_prepaidcards_count24 := __common__( if(not(truedid), NULL, min(if(inq_PrepaidCards_count24 = NULL, -NULL, inq_PrepaidCards_count24), 999)));

nf_inq_quizprovider_count_week := __common__( if(not(truedid), NULL, min(if(inq_QuizProvider_count_week = NULL, -NULL, inq_QuizProvider_count_week), 999)));

nf_inq_quizprovider_count24 := __common__( if(not(truedid), NULL, min(if(inq_QuizProvider_count24 = NULL, -NULL, inq_QuizProvider_count24), 999)));

nf_inq_retail_count24 := __common__( if(not(truedid), NULL, min(if(inq_Retail_count24 = NULL, -NULL, inq_Retail_count24), 999)));

nf_inq_retailpayments_count24 := __common__( if(not(truedid), NULL, min(if(inq_RetailPayments_count24 = NULL, -NULL, inq_RetailPayments_count24), 999)));

nf_inq_utilities_count24 := __common__( if(not(truedid), NULL, min(if(inq_Utilities_count24 = NULL, -NULL, inq_Utilities_count24), 999)));

nf_inq_per_ssn := __common__( if(not(ssnlength > '0'), NULL, min(if(inq_perssn = NULL, -NULL, inq_perssn), 999)));

nf_inq_adls_per_ssn := __common__( if(not(ssnlength > '0'), NULL, min(if(inq_adlsperssn = NULL, -NULL, inq_adlsperssn), 999)));

nf_inq_lnames_per_ssn := __common__( if(not(ssnlength > '0'), NULL, min(if(inq_lnamesperssn = NULL, -NULL, inq_lnamesperssn), 999)));

nf_inq_addrs_per_ssn := __common__( if(not(ssnlength > '0'), NULL, min(if(inq_addrsperssn = NULL, -NULL, inq_addrsperssn), 999)));

nf_inq_dobs_per_ssn := __common__( if(not(ssnlength > '0'), NULL, min(if(inq_dobsperssn = NULL, -NULL, inq_dobsperssn), 999)));

nf_inq_per_addr := __common__( if(not(addrpop), NULL, min(if(inq_peraddr = NULL, -NULL, inq_peraddr), 999)));

nf_inq_per_apt_addr := __common__( map(
    not(addrpop)     => NULL,
    iv_add_apt = '0' => -1,
                        min(if(inq_peraddr = NULL, -NULL, inq_peraddr), 999)));

nf_inq_per_sfd_addr := __common__( map(
    not(addrpop)     => NULL,
    iv_add_apt = '1' => -1,
                        min(if(inq_peraddr = NULL, -NULL, inq_peraddr), 999)));

nf_inq_adls_per_addr := __common__( if(not(addrpop), NULL, min(if(inq_adlsperaddr = NULL, -NULL, inq_adlsperaddr), 999)));

nf_inq_adls_per_apt_addr := __common__( map(
    not(addrpop)     => NULL,
    iv_add_apt = '0' => -1,
                        min(if(inq_adlsperaddr = NULL, -NULL, inq_adlsperaddr), 999)));

nf_inq_adls_per_sfd_addr := __common__( map(
    not(addrpop)     => NULL,
    iv_add_apt = '1' => -1,
                        min(if(inq_adlsperaddr = NULL, -NULL, inq_adlsperaddr), 999)));

nf_inq_lnames_per_apt_addr := __common__( map(
    not(addrpop)     => NULL,
    iv_add_apt = '0' => -1,
                        min(if(inq_lnamesperaddr = NULL, -NULL, inq_lnamesperaddr), 999)));

nf_inq_lnames_per_sfd_addr := __common__( map(
    not(addrpop)     => NULL,
    iv_add_apt = '1' => -1,
                        min(if(inq_lnamesperaddr = NULL, -NULL, inq_lnamesperaddr), 999)));

nf_inq_ssns_per_addr := __common__( if(not(addrpop), NULL, min(if(inq_ssnsperaddr = NULL, -NULL, inq_ssnsperaddr), 999)));

nf_inq_ssns_per_apt_addr := __common__( map(
    not(addrpop)     => NULL,
    iv_add_apt = '0' => -1,
                        min(if(inq_ssnsperaddr = NULL, -NULL, inq_ssnsperaddr), 999)));

nf_inq_ssns_per_sfd_addr := __common__( map(
    not(addrpop)     => NULL,
    iv_add_apt = '1' => -1,
                        min(if(inq_ssnsperaddr = NULL, -NULL, inq_ssnsperaddr), 999)));

nf_inq_per_phone := __common__( if(not(hphnpop), NULL, min(if(inq_perphone = NULL, -NULL, inq_perphone), 999)));

nf_inq_adls_per_phone := __common__( if(not(hphnpop), NULL, min(if(inq_adlsperphone = NULL, -NULL, inq_adlsperphone), 999)));

	nf_attr_arrest_recency := map(
	    not(truedid)        => NULL,
	    attr_arrests30 > 0  => 1,
	    attr_arrests90 > 0  => 3,
	    attr_arrests180 > 0 => 6,
	    attr_arrests12 > 0  => 12,
	    attr_arrests24 > 0  => 24,
	    attr_arrests36 > 0  => 36,
	    attr_arrests60 > 0  => 60,
	    attr_arrests   > 0  => 99,
														 NULL);

_liens_unrel_cj_first_seen := __common__( common.sas_date((string)(liens_unrel_CJ_first_seen)));

nf_mos_liens_unrel_cj_fseen := __common__( map(
    not(truedid)                      => NULL,
    _liens_unrel_cj_first_seen = NULL => -1,
                                         min(if(if ((sysdate - _liens_unrel_cj_first_seen) / (365.25 / 12) >= 0, truncate((sysdate - _liens_unrel_cj_first_seen) / (365.25 / 12)), roundup((sysdate - _liens_unrel_cj_first_seen) / (365.25 / 12))) = NULL, -NULL, if ((sysdate - _liens_unrel_cj_first_seen) / (365.25 / 12) >= 0, truncate((sysdate - _liens_unrel_cj_first_seen) / (365.25 / 12)), roundup((sysdate - _liens_unrel_cj_first_seen) / (365.25 / 12)))), 999)));

_liens_unrel_cj_last_seen := __common__( common.sas_date((string)(liens_unrel_CJ_last_seen)));

nf_mos_liens_unrel_cj_lseen := __common__( map(
    not(truedid)                     => NULL,
    _liens_unrel_cj_last_seen = NULL => -1,
                                        min(if(if ((sysdate - _liens_unrel_cj_last_seen) / (365.25 / 12) >= 0, truncate((sysdate - _liens_unrel_cj_last_seen) / (365.25 / 12)), roundup((sysdate - _liens_unrel_cj_last_seen) / (365.25 / 12))) = NULL, -NULL, if ((sysdate - _liens_unrel_cj_last_seen) / (365.25 / 12) >= 0, truncate((sysdate - _liens_unrel_cj_last_seen) / (365.25 / 12)), roundup((sysdate - _liens_unrel_cj_last_seen) / (365.25 / 12)))), 999)));

nf_liens_unrel_cj_total_amt := __common__( if(not(truedid), NULL, liens_unrel_CJ_total_amount));

_liens_rel_cj_last_seen := __common__( common.sas_date((string)(liens_rel_CJ_last_seen)));

nf_mos_liens_rel_cj_lseen := __common__( map(
    not(truedid)                   => NULL,
    _liens_rel_cj_last_seen = NULL => -1,
                                      min(if(if ((sysdate - _liens_rel_cj_last_seen) / (365.25 / 12) >= 0, truncate((sysdate - _liens_rel_cj_last_seen) / (365.25 / 12)), roundup((sysdate - _liens_rel_cj_last_seen) / (365.25 / 12))) = NULL, -NULL, if ((sysdate - _liens_rel_cj_last_seen) / (365.25 / 12) >= 0, truncate((sysdate - _liens_rel_cj_last_seen) / (365.25 / 12)), roundup((sysdate - _liens_rel_cj_last_seen) / (365.25 / 12)))), 999)));

nf_liens_rel_cj_total_amt := __common__( if(not(truedid), NULL, liens_rel_CJ_total_amount));

_liens_unrel_ft_last_seen := __common__( common.sas_date((string)(liens_unrel_FT_last_seen)));

nf_mos_liens_unrel_ft_lseen := __common__( map(
    not(truedid)                     => NULL,
    _liens_unrel_ft_last_seen = NULL => -1,
                                        min(if(if ((sysdate - _liens_unrel_ft_last_seen) / (365.25 / 12) >= 0, truncate((sysdate - _liens_unrel_ft_last_seen) / (365.25 / 12)), roundup((sysdate - _liens_unrel_ft_last_seen) / (365.25 / 12))) = NULL, -NULL, if ((sysdate - _liens_unrel_ft_last_seen) / (365.25 / 12) >= 0, truncate((sysdate - _liens_unrel_ft_last_seen) / (365.25 / 12)), roundup((sysdate - _liens_unrel_ft_last_seen) / (365.25 / 12)))), 999)));

nf_liens_unrel_ft_total_amt := __common__( if(not(truedid), NULL, liens_unrel_FT_total_amount));

_liens_rel_ft_first_seen := __common__( common.sas_date((string)(liens_rel_FT_first_seen)));

nf_mos_liens_rel_ft_fseen := __common__( map(
    not(truedid)                    => NULL,
    _liens_rel_ft_first_seen = NULL => -1,
                                       min(if(if ((sysdate - _liens_rel_ft_first_seen) / (365.25 / 12) >= 0, truncate((sysdate - _liens_rel_ft_first_seen) / (365.25 / 12)), roundup((sysdate - _liens_rel_ft_first_seen) / (365.25 / 12))) = NULL, -NULL, if ((sysdate - _liens_rel_ft_first_seen) / (365.25 / 12) >= 0, truncate((sysdate - _liens_rel_ft_first_seen) / (365.25 / 12)), roundup((sysdate - _liens_rel_ft_first_seen) / (365.25 / 12)))), 999)));

_liens_rel_ft_last_seen := __common__( common.sas_date((string)(liens_rel_FT_last_seen)));

nf_mos_liens_rel_ft_lseen := __common__( map(
    not(truedid)                   => NULL,
    _liens_rel_ft_last_seen = NULL => -1,
                                      min(if(if ((sysdate - _liens_rel_ft_last_seen) / (365.25 / 12) >= 0, truncate((sysdate - _liens_rel_ft_last_seen) / (365.25 / 12)), roundup((sysdate - _liens_rel_ft_last_seen) / (365.25 / 12))) = NULL, -NULL, if ((sysdate - _liens_rel_ft_last_seen) / (365.25 / 12) >= 0, truncate((sysdate - _liens_rel_ft_last_seen) / (365.25 / 12)), roundup((sysdate - _liens_rel_ft_last_seen) / (365.25 / 12)))), 999)));

_liens_unrel_fc_first_seen := __common__( common.sas_date((string)(liens_unrel_FC_first_seen)));

nf_mos_liens_unrel_fc_fseen := __common__( map(
    not(truedid)                      => NULL,
    _liens_unrel_fc_first_seen = NULL => -1,
                                         min(if(if ((sysdate - _liens_unrel_fc_first_seen) / (365.25 / 12) >= 0, truncate((sysdate - _liens_unrel_fc_first_seen) / (365.25 / 12)), roundup((sysdate - _liens_unrel_fc_first_seen) / (365.25 / 12))) = NULL, -NULL, if ((sysdate - _liens_unrel_fc_first_seen) / (365.25 / 12) >= 0, truncate((sysdate - _liens_unrel_fc_first_seen) / (365.25 / 12)), roundup((sysdate - _liens_unrel_fc_first_seen) / (365.25 / 12)))), 999)));

nf_liens_unrel_fc_total_amt := __common__( if(not(truedid), NULL, liens_unrel_FC_total_amount));

nf_liens_unrel_o_total_amt := __common__( if(not(truedid), NULL, liens_unrel_O_total_amount));

_liens_unrel_ot_last_seen := __common__( common.sas_date((string)(liens_unrel_OT_last_seen)));

nf_mos_liens_unrel_ot_lseen := __common__( map(
    not(truedid)                     => NULL,
    _liens_unrel_ot_last_seen = NULL => -1,
                                        min(if(if ((sysdate - _liens_unrel_ot_last_seen) / (365.25 / 12) >= 0, truncate((sysdate - _liens_unrel_ot_last_seen) / (365.25 / 12)), roundup((sysdate - _liens_unrel_ot_last_seen) / (365.25 / 12))) = NULL, -NULL, if ((sysdate - _liens_unrel_ot_last_seen) / (365.25 / 12) >= 0, truncate((sysdate - _liens_unrel_ot_last_seen) / (365.25 / 12)), roundup((sysdate - _liens_unrel_ot_last_seen) / (365.25 / 12)))), 999)));

nf_liens_unrel_ot_total_amt := __common__( if(not(truedid), NULL, liens_unrel_OT_total_amount));

_liens_unrel_sc_last_seen := __common__( common.sas_date((string)(liens_unrel_SC_last_seen)));

nf_mos_liens_unrel_sc_lseen := __common__( map(
    not(truedid)                     => NULL,
    _liens_unrel_sc_last_seen = NULL => -1,
                                        min(if(if ((sysdate - _liens_unrel_sc_last_seen) / (365.25 / 12) >= 0, truncate((sysdate - _liens_unrel_sc_last_seen) / (365.25 / 12)), roundup((sysdate - _liens_unrel_sc_last_seen) / (365.25 / 12))) = NULL, -NULL, if ((sysdate - _liens_unrel_sc_last_seen) / (365.25 / 12) >= 0, truncate((sysdate - _liens_unrel_sc_last_seen) / (365.25 / 12)), roundup((sysdate - _liens_unrel_sc_last_seen) / (365.25 / 12)))), 999)));

nf_liens_unrel_sc_total_amt := __common__( if(not(truedid), NULL, liens_unrel_SC_total_amount));

_liens_rel_sc_first_seen := __common__( common.sas_date((string)(liens_rel_SC_first_seen)));

nf_mos_liens_rel_sc_fseen := __common__( map(
    not(truedid)                    => NULL,
    _liens_rel_sc_first_seen = NULL => -1,
                                       min(if(if ((sysdate - _liens_rel_sc_first_seen) / (365.25 / 12) >= 0, truncate((sysdate - _liens_rel_sc_first_seen) / (365.25 / 12)), roundup((sysdate - _liens_rel_sc_first_seen) / (365.25 / 12))) = NULL, -NULL, if ((sysdate - _liens_rel_sc_first_seen) / (365.25 / 12) >= 0, truncate((sysdate - _liens_rel_sc_first_seen) / (365.25 / 12)), roundup((sysdate - _liens_rel_sc_first_seen) / (365.25 / 12)))), 999)));

_liens_rel_sc_last_seen := __common__( common.sas_date((string)(liens_rel_SC_last_seen)));

nf_mos_liens_rel_sc_lseen := __common__( map(
    not(truedid)                   => NULL,
    _liens_rel_sc_last_seen = NULL => -1,
                                      min(if(if ((sysdate - _liens_rel_sc_last_seen) / (365.25 / 12) >= 0, truncate((sysdate - _liens_rel_sc_last_seen) / (365.25 / 12)), roundup((sysdate - _liens_rel_sc_last_seen) / (365.25 / 12))) = NULL, -NULL, if ((sysdate - _liens_rel_sc_last_seen) / (365.25 / 12) >= 0, truncate((sysdate - _liens_rel_sc_last_seen) / (365.25 / 12)), roundup((sysdate - _liens_rel_sc_last_seen) / (365.25 / 12)))), 999)));

nf_liens_rel_sc_total_amt := __common__( if(not(truedid), NULL, liens_rel_SC_total_amount));

nf_liens_unrel_st_ct := __common__( if(not(truedid), NULL, min(if(liens_unrel_ST_ct = NULL, -NULL, liens_unrel_ST_ct), 999)));

_liens_unrel_st_first_seen := __common__( common.sas_date((string)(liens_unrel_ST_first_seen)));

nf_mos_liens_unrel_st_fseen := __common__( map(
    not(truedid)                      => NULL,
    _liens_unrel_st_first_seen = NULL => -1,
                                         min(if(if ((sysdate - _liens_unrel_st_first_seen) / (365.25 / 12) >= 0, truncate((sysdate - _liens_unrel_st_first_seen) / (365.25 / 12)), roundup((sysdate - _liens_unrel_st_first_seen) / (365.25 / 12))) = NULL, -NULL, if ((sysdate - _liens_unrel_st_first_seen) / (365.25 / 12) >= 0, truncate((sysdate - _liens_unrel_st_first_seen) / (365.25 / 12)), roundup((sysdate - _liens_unrel_st_first_seen) / (365.25 / 12)))), 999)));

_liens_unrel_st_last_seen := __common__( common.sas_date((string)(liens_unrel_ST_last_seen)));

nf_mos_liens_unrel_st_lseen := __common__( map(
    not(truedid)                     => NULL,
    _liens_unrel_st_last_seen = NULL => -1,
                                        min(if(if ((sysdate - _liens_unrel_st_last_seen) / (365.25 / 12) >= 0, truncate((sysdate - _liens_unrel_st_last_seen) / (365.25 / 12)), roundup((sysdate - _liens_unrel_st_last_seen) / (365.25 / 12))) = NULL, -NULL, if ((sysdate - _liens_unrel_st_last_seen) / (365.25 / 12) >= 0, truncate((sysdate - _liens_unrel_st_last_seen) / (365.25 / 12)), roundup((sysdate - _liens_unrel_st_last_seen) / (365.25 / 12)))), 999)));

nf_liens_unrel_st_total_amt := __common__( if(not(truedid), NULL, liens_unrel_ST_total_amount));

_foreclosure_last_date := __common__( common.sas_date((string)(foreclosure_last_date)));

nf_mos_foreclosure_lseen := __common__( map(
    not(truedid)                  => NULL,
    _foreclosure_last_date = NULL => -1,
                                     min(if(if ((sysdate - _foreclosure_last_date) / (365.25 / 12) >= 0, truncate((sysdate - _foreclosure_last_date) / (365.25 / 12)), roundup((sysdate - _foreclosure_last_date) / (365.25 / 12))) = NULL, -NULL, if ((sysdate - _foreclosure_last_date) / (365.25 / 12) >= 0, truncate((sysdate - _foreclosure_last_date) / (365.25 / 12)), roundup((sysdate - _foreclosure_last_date) / (365.25 / 12)))), 999)));

iv_estimated_income := __common__( if(not(truedid), NULL, estimated_income));

iv_wealth_index := __common__( if(not(truedid), NULL, (Integer)wealth_index));

nf_hh_members_ct := __common__( if(not(truedid), NULL, min(if(hh_members_ct = NULL, -NULL, hh_members_ct), 999)));

nf_hh_property_owners_ct := __common__( if(not(truedid), NULL, min(if(hh_property_owners_ct = NULL, -NULL, hh_property_owners_ct), 999)));

nf_hh_pct_property_owners := __common__( map(
    not(truedid)      => NULL,
    hh_members_ct = 0 => -1,
                         min(if(hh_property_owners_ct / hh_members_ct = NULL, -NULL, hh_property_owners_ct / hh_members_ct), 1.0)));

nf_hh_age_65_plus := __common__( if(not(truedid), NULL, min(if(hh_age_65_plus = NULL, -NULL, hh_age_65_plus), 999)));

nf_hh_age_30_plus := __common__( if(not(truedid), NULL, min(if(if(max(hh_age_65_plus, hh_age_30_to_65) = NULL, NULL, sum(if(hh_age_65_plus = NULL, 0, hh_age_65_plus), if(hh_age_30_to_65 = NULL, 0, hh_age_30_to_65))) = NULL, -NULL, if(max(hh_age_65_plus, hh_age_30_to_65) = NULL, NULL, sum(if(hh_age_65_plus = NULL, 0, hh_age_65_plus), if(hh_age_30_to_65 = NULL, 0, hh_age_30_to_65)))), 999)));

nf_hh_age_18_plus_1 := __common__( if(not(truedid), NULL, min(if(if(max(hh_age_65_plus, hh_age_30_to_65, hh_age_18_to_30) = NULL, NULL, sum(if(hh_age_65_plus = NULL, 0, hh_age_65_plus), if(hh_age_30_to_65 = NULL, 0, hh_age_30_to_65), if(hh_age_18_to_30 = NULL, 0, hh_age_18_to_30))) = NULL, -NULL, if(max(hh_age_65_plus, hh_age_30_to_65, hh_age_18_to_30) = NULL, NULL, sum(if(hh_age_65_plus = NULL, 0, hh_age_65_plus), if(hh_age_30_to_65 = NULL, 0, hh_age_30_to_65), if(hh_age_18_to_30 = NULL, 0, hh_age_18_to_30)))), 999)));

nf_hh_age_18_plus := __common__( if(not(truedid), NULL, min(if(if(max(hh_age_65_plus, hh_age_30_to_65, hh_age_18_to_30) = NULL, NULL, sum(if(hh_age_65_plus = NULL, 0, hh_age_65_plus), if(hh_age_30_to_65 = NULL, 0, hh_age_30_to_65), if(hh_age_18_to_30 = NULL, 0, hh_age_18_to_30))) = NULL, -NULL, if(max(hh_age_65_plus, hh_age_30_to_65, hh_age_18_to_30) = NULL, NULL, sum(if(hh_age_65_plus = NULL, 0, hh_age_65_plus), if(hh_age_30_to_65 = NULL, 0, hh_age_30_to_65), if(hh_age_18_to_30 = NULL, 0, hh_age_18_to_30)))), 999)));

nf_hh_age_lt18 := __common__( if(not(truedid), NULL, min(if(hh_age_lt18 = NULL, -NULL, hh_age_lt18), 999)));

nf_hh_collections_ct := __common__( if(not(truedid), NULL, min(if(hh_collections_ct = NULL, -NULL, hh_collections_ct), 999)));

nf_hh_collections_ct_avg := __common__( map(
    not(truedid)      => NULL,
    hh_members_ct = 0 => -1,
                         hh_collections_ct / hh_members_ct));

nf_hh_workers_paw := __common__( if(not(truedid), NULL, min(if(hh_workers_paw = NULL, -NULL, hh_workers_paw), 999)));

nf_hh_workers_paw_pct := __common__( map(
    not(truedid)      => NULL,
    hh_members_ct = 0 => -1,
                         min(if(hh_workers_paw / hh_members_ct = NULL, -NULL, hh_workers_paw / hh_members_ct), 1.0)));

nf_hh_payday_loan_users := __common__( if(not(truedid), NULL, min(if(hh_payday_loan_users = NULL, -NULL, hh_payday_loan_users), 999)));

nf_hh_payday_loan_users_pct := __common__( map(
    not(truedid)      => NULL,
    hh_members_ct = 0 => -1,
                         min(if(hh_payday_loan_users / hh_members_ct = NULL, -NULL, hh_payday_loan_users / hh_members_ct), 1.0)));

nf_hh_members_w_derog_pct := __common__( map(
    not(truedid)      => NULL,
    hh_members_ct = 0 => -1,
                         min(if(hh_members_w_derog / hh_members_ct = NULL, -NULL, hh_members_w_derog / hh_members_ct), 1.0)));

nf_hh_tot_derog := __common__( if(not(truedid), NULL, min(if(hh_tot_derog = NULL, -NULL, hh_tot_derog), 999)));

nf_hh_tot_derog_avg := __common__( map(
    not(truedid)      => NULL,
    hh_members_ct = 0 => -1,
                         hh_tot_derog / hh_members_ct));

nf_hh_bankruptcies_pct := __common__( map(
    not(truedid)      => NULL,
    hh_members_ct = 0 => -1,
                         min(if(hh_bankruptcies / hh_members_ct = NULL, -NULL, hh_bankruptcies / hh_members_ct), 1.0)));

nf_hh_lienholders := __common__( if(not(truedid), NULL, min(if(hh_lienholders = NULL, -NULL, hh_lienholders), 999)));

nf_hh_lienholders_pct := __common__( map(
    not(truedid)      => NULL,
    hh_members_ct = 0 => -1,
                         min(if(hh_lienholders / hh_members_ct = NULL, -NULL, hh_lienholders / hh_members_ct), 1.0)));

nf_hh_prof_license_holders := __common__( if(not(truedid), NULL, min(if(hh_prof_license_holders = NULL, -NULL, hh_prof_license_holders), 999)));

nf_hh_criminals := __common__( if(not(truedid), NULL, min(if(hh_criminals = NULL, -NULL, hh_criminals), 999)));

nf_hh_criminals_pct := __common__( map(
    not(truedid)      => NULL,
    hh_members_ct = 0 => -1,
                         min(if(hh_criminals / hh_members_ct = NULL, -NULL, hh_criminals / hh_members_ct), 1.0)));

nf_hh_college_attendees := __common__( if(not(truedid), NULL, min(if(hh_college_attendees = NULL, -NULL, hh_college_attendees), 999)));

nf_hh_college_attendees_pct := __common__( map(
    not(truedid)      => NULL,
    hh_members_ct = 0 => -1,
                         min(if(hh_college_attendees / hh_members_ct = NULL, -NULL, hh_college_attendees / hh_members_ct), 1.0)));

nf_rel_count := __common__( if(not(truedid), NULL, min(if(rel_count = NULL, -NULL, rel_count), 999)));

nf_average_rel_income := __common__( map(
    not(truedid)                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  => NULL,
    rel_count = 0                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 => -1,
    if(max(rel_incomeunder25_count, rel_incomeunder50_count, rel_incomeunder75_count, rel_incomeunder100_count, rel_incomeover100_count) = NULL, NULL, sum(if(rel_incomeunder25_count = NULL, 0, rel_incomeunder25_count), if(rel_incomeunder50_count = NULL, 0, rel_incomeunder50_count), if(rel_incomeunder75_count = NULL, 0, rel_incomeunder75_count), if(rel_incomeunder100_count = NULL, 0, rel_incomeunder100_count), if(rel_incomeover100_count = NULL, 0, rel_incomeover100_count))) = 0 => 0,
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                     if (if(max(rel_incomeunder25_count * 25, rel_incomeunder50_count * 50, rel_incomeunder75_count * 75, rel_incomeunder100_count * 100, rel_incomeover100_count * 125) = NULL, NULL, sum(if(rel_incomeunder25_count * 25 = NULL, 0, rel_incomeunder25_count * 25), if(rel_incomeunder50_count * 50 = NULL, 0, rel_incomeunder50_count * 50), if(rel_incomeunder75_count * 75 = NULL, 0, rel_incomeunder75_count * 75), if(rel_incomeunder100_count * 100 = NULL, 0, rel_incomeunder100_count * 100), if(rel_incomeover100_count * 125 = NULL, 0, rel_incomeover100_count * 125))) / if(max(rel_incomeunder25_count, rel_incomeunder50_count, rel_incomeunder75_count, rel_incomeunder100_count, rel_incomeover100_count) = NULL, NULL, sum(if(rel_incomeunder25_count = NULL, 0, rel_incomeunder25_count), if(rel_incomeunder50_count = NULL, 0, rel_incomeunder50_count), if(rel_incomeunder75_count = NULL, 0, rel_incomeunder75_count), if(rel_incomeunder100_count = NULL, 0, rel_incomeunder100_count), if(rel_incomeover100_count = NULL, 0, rel_incomeover100_count))) >= 0, truncate(if(max(rel_incomeunder25_count * 25, rel_incomeunder50_count * 50, rel_incomeunder75_count * 75, rel_incomeunder100_count * 100, rel_incomeover100_count * 125) = NULL, NULL, sum(if(rel_incomeunder25_count * 25 = NULL, 0, rel_incomeunder25_count * 25), if(rel_incomeunder50_count * 50 = NULL, 0, rel_incomeunder50_count * 50), if(rel_incomeunder75_count * 75 = NULL, 0, rel_incomeunder75_count * 75), if(rel_incomeunder100_count * 100 = NULL, 0, rel_incomeunder100_count * 100), if(rel_incomeover100_count * 125 = NULL, 0, rel_incomeover100_count * 125))) / if(max(rel_incomeunder25_count, rel_incomeunder50_count, rel_incomeunder75_count, rel_incomeunder100_count, rel_incomeover100_count) = NULL, NULL, sum(if(rel_incomeunder25_count = NULL, 0, rel_incomeunder25_count), if(rel_incomeunder50_count = NULL, 0, rel_incomeunder50_count), if(rel_incomeunder75_count = NULL, 0, rel_incomeunder75_count), if(rel_incomeunder100_count = NULL, 0, rel_incomeunder100_count), if(rel_incomeover100_count = NULL, 0, rel_incomeover100_count)))), roundup(if(max(rel_incomeunder25_count * 25, rel_incomeunder50_count * 50, rel_incomeunder75_count * 75, rel_incomeunder100_count * 100, rel_incomeover100_count * 125) = NULL, NULL, sum(if(rel_incomeunder25_count * 25 = NULL, 0, rel_incomeunder25_count * 25), if(rel_incomeunder50_count * 50 = NULL, 0, rel_incomeunder50_count * 50), if(rel_incomeunder75_count * 75 = NULL, 0, rel_incomeunder75_count * 75), if(rel_incomeunder100_count * 100 = NULL, 0, rel_incomeunder100_count * 100), if(rel_incomeover100_count * 125 = NULL, 0, rel_incomeover100_count * 125))) / if(max(rel_incomeunder25_count, rel_incomeunder50_count, rel_incomeunder75_count, rel_incomeunder100_count, rel_incomeover100_count) = NULL, NULL, sum(if(rel_incomeunder25_count = NULL, 0, rel_incomeunder25_count), if(rel_incomeunder50_count = NULL, 0, rel_incomeunder50_count), if(rel_incomeunder75_count = NULL, 0, rel_incomeunder75_count), if(rel_incomeunder100_count = NULL, 0, rel_incomeunder100_count), if(rel_incomeover100_count = NULL, 0, rel_incomeover100_count))))) * 1000));

nf_lowest_rel_income := __common__( map(
    not(truedid)                 => NULL,
    rel_count = 0                => -1,
    rel_incomeunder25_count > 0  => 25,
    rel_incomeunder50_count > 0  => 50,
    rel_incomeunder75_count > 0  => 75,
    rel_incomeunder100_count > 0 => 100,
    rel_incomeover100_count > 0  => 125,
                                    0));

nf_highest_rel_income := __common__( map(
    not(truedid)                 => NULL,
    rel_count = 0                => -1,
    rel_incomeover100_count > 0  => 125,
    rel_incomeunder100_count > 0 => 100,
    rel_incomeunder75_count > 0  => 75,
    rel_incomeunder50_count > 0  => 50,
    rel_incomeunder25_count > 0  => 25,
                                    0));

nf_average_rel_home_val := __common__( map(
    not(truedid)                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      => NULL,
    rel_count = 0                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                     => -1,
    if(max(rel_homeunder50_count, rel_homeunder100_count, rel_homeunder150_count, rel_homeunder200_count, rel_homeunder300_count, rel_homeunder500_count, rel_homeover500_count) = NULL, NULL, sum(if(rel_homeunder50_count = NULL, 0, rel_homeunder50_count), if(rel_homeunder100_count = NULL, 0, rel_homeunder100_count), if(rel_homeunder150_count = NULL, 0, rel_homeunder150_count), if(rel_homeunder200_count = NULL, 0, rel_homeunder200_count), if(rel_homeunder300_count = NULL, 0, rel_homeunder300_count), if(rel_homeunder500_count = NULL, 0, rel_homeunder500_count), if(rel_homeover500_count = NULL, 0, rel_homeover500_count))) = 0 => 0,
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                         if (if(max(rel_homeunder50_count * 50, rel_homeunder100_count * 100, rel_homeunder150_count * 150, rel_homeunder200_count * 200, rel_homeunder300_count * 300, rel_homeunder500_count * 500, rel_homeover500_count * 750) = NULL, NULL, sum(if(rel_homeunder50_count * 50 = NULL, 0, rel_homeunder50_count * 50), if(rel_homeunder100_count * 100 = NULL, 0, rel_homeunder100_count * 100), if(rel_homeunder150_count * 150 = NULL, 0, rel_homeunder150_count * 150), if(rel_homeunder200_count * 200 = NULL, 0, rel_homeunder200_count * 200), if(rel_homeunder300_count * 300 = NULL, 0, rel_homeunder300_count * 300), if(rel_homeunder500_count * 500 = NULL, 0, rel_homeunder500_count * 500), if(rel_homeover500_count * 750 = NULL, 0, rel_homeover500_count * 750))) / if(max(rel_homeunder50_count, rel_homeunder100_count, rel_homeunder150_count, rel_homeunder200_count, rel_homeunder300_count, rel_homeunder500_count, rel_homeover500_count) = NULL, NULL, sum(if(rel_homeunder50_count = NULL, 0, rel_homeunder50_count), if(rel_homeunder100_count = NULL, 0, rel_homeunder100_count), if(rel_homeunder150_count = NULL, 0, rel_homeunder150_count), if(rel_homeunder200_count = NULL, 0, rel_homeunder200_count), if(rel_homeunder300_count = NULL, 0, rel_homeunder300_count), if(rel_homeunder500_count = NULL, 0, rel_homeunder500_count), if(rel_homeover500_count = NULL, 0, rel_homeover500_count))) >= 0, truncate(if(max(rel_homeunder50_count * 50, rel_homeunder100_count * 100, rel_homeunder150_count * 150, rel_homeunder200_count * 200, rel_homeunder300_count * 300, rel_homeunder500_count * 500, rel_homeover500_count * 750) = NULL, NULL, sum(if(rel_homeunder50_count * 50 = NULL, 0, rel_homeunder50_count * 50), if(rel_homeunder100_count * 100 = NULL, 0, rel_homeunder100_count * 100), if(rel_homeunder150_count * 150 = NULL, 0, rel_homeunder150_count * 150), if(rel_homeunder200_count * 200 = NULL, 0, rel_homeunder200_count * 200), if(rel_homeunder300_count * 300 = NULL, 0, rel_homeunder300_count * 300), if(rel_homeunder500_count * 500 = NULL, 0, rel_homeunder500_count * 500), if(rel_homeover500_count * 750 = NULL, 0, rel_homeover500_count * 750))) / if(max(rel_homeunder50_count, rel_homeunder100_count, rel_homeunder150_count, rel_homeunder200_count, rel_homeunder300_count, rel_homeunder500_count, rel_homeover500_count) = NULL, NULL, sum(if(rel_homeunder50_count = NULL, 0, rel_homeunder50_count), if(rel_homeunder100_count = NULL, 0, rel_homeunder100_count), if(rel_homeunder150_count = NULL, 0, rel_homeunder150_count), if(rel_homeunder200_count = NULL, 0, rel_homeunder200_count), if(rel_homeunder300_count = NULL, 0, rel_homeunder300_count), if(rel_homeunder500_count = NULL, 0, rel_homeunder500_count), if(rel_homeover500_count = NULL, 0, rel_homeover500_count)))), roundup(if(max(rel_homeunder50_count * 50, rel_homeunder100_count * 100, rel_homeunder150_count * 150, rel_homeunder200_count * 200, rel_homeunder300_count * 300, rel_homeunder500_count * 500, rel_homeover500_count * 750) = NULL, NULL, sum(if(rel_homeunder50_count * 50 = NULL, 0, rel_homeunder50_count * 50), if(rel_homeunder100_count * 100 = NULL, 0, rel_homeunder100_count * 100), if(rel_homeunder150_count * 150 = NULL, 0, rel_homeunder150_count * 150), if(rel_homeunder200_count * 200 = NULL, 0, rel_homeunder200_count * 200), if(rel_homeunder300_count * 300 = NULL, 0, rel_homeunder300_count * 300), if(rel_homeunder500_count * 500 = NULL, 0, rel_homeunder500_count * 500), if(rel_homeover500_count * 750 = NULL, 0, rel_homeover500_count * 750))) / if(max(rel_homeunder50_count, rel_homeunder100_count, rel_homeunder150_count, rel_homeunder200_count, rel_homeunder300_count, rel_homeunder500_count, rel_homeover500_count) = NULL, NULL, sum(if(rel_homeunder50_count = NULL, 0, rel_homeunder50_count), if(rel_homeunder100_count = NULL, 0, rel_homeunder100_count), if(rel_homeunder150_count = NULL, 0, rel_homeunder150_count), if(rel_homeunder200_count = NULL, 0, rel_homeunder200_count), if(rel_homeunder300_count = NULL, 0, rel_homeunder300_count), if(rel_homeunder500_count = NULL, 0, rel_homeunder500_count), if(rel_homeover500_count = NULL, 0, rel_homeover500_count))))) * 1000));

nf_lowest_rel_home_val := __common__( map(
    not(truedid)               => NULL,
    rel_count = 0              => -1,
    rel_homeunder50_count > 0  => 50,
    rel_homeunder100_count > 0 => 100,
    rel_homeunder150_count > 0 => 150,
    rel_homeunder200_count > 0 => 200,
    rel_homeunder300_count > 0 => 300,
    rel_homeunder500_count > 0 => 500,
    rel_homeover500_count > 0  => 750,
                                  0));

nf_highest_rel_home_val := __common__( map(
    not(truedid)               => NULL,
    rel_count = 0              => -1,
    rel_homeover500_count > 0  => 750,
    rel_homeunder500_count > 0 => 500,
    rel_homeunder300_count > 0 => 300,
    rel_homeunder200_count > 0 => 200,
    rel_homeunder150_count > 0 => 150,
    rel_homeunder100_count > 0 => 100,
    rel_homeunder50_count > 0  => 50,
                                  0));

nf_average_rel_age := __common__( map(
    not(truedid)                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               => NULL,
    rel_count = 0                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              => -1,
    if(max(rel_ageunder20_count, rel_ageunder30_count, rel_ageunder40_count, rel_ageunder50_count, rel_ageunder60_count, rel_ageunder70_count, rel_ageover70_count) = NULL, NULL, sum(if(rel_ageunder20_count = NULL, 0, rel_ageunder20_count), if(rel_ageunder30_count = NULL, 0, rel_ageunder30_count), if(rel_ageunder40_count = NULL, 0, rel_ageunder40_count), if(rel_ageunder50_count = NULL, 0, rel_ageunder50_count), if(rel_ageunder60_count = NULL, 0, rel_ageunder60_count), if(rel_ageunder70_count = NULL, 0, rel_ageunder70_count), if(rel_ageover70_count = NULL, 0, rel_ageover70_count))) = 0 => 0,
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  if (if(max(rel_ageunder20_count * 20, rel_ageunder30_count * 30, rel_ageunder40_count * 40, rel_ageunder50_count * 50, rel_ageunder60_count * 60, rel_ageunder70_count * 70, rel_ageover70_count * 80) = NULL, NULL, sum(if(rel_ageunder20_count * 20 = NULL, 0, rel_ageunder20_count * 20), if(rel_ageunder30_count * 30 = NULL, 0, rel_ageunder30_count * 30), if(rel_ageunder40_count * 40 = NULL, 0, rel_ageunder40_count * 40), if(rel_ageunder50_count * 50 = NULL, 0, rel_ageunder50_count * 50), if(rel_ageunder60_count * 60 = NULL, 0, rel_ageunder60_count * 60), if(rel_ageunder70_count * 70 = NULL, 0, rel_ageunder70_count * 70), if(rel_ageover70_count * 80 = NULL, 0, rel_ageover70_count * 80))) / if(max(rel_ageunder20_count, rel_ageunder30_count, rel_ageunder40_count, rel_ageunder50_count, rel_ageunder60_count, rel_ageunder70_count, rel_ageover70_count) = NULL, NULL, sum(if(rel_ageunder20_count = NULL, 0, rel_ageunder20_count), if(rel_ageunder30_count = NULL, 0, rel_ageunder30_count), if(rel_ageunder40_count = NULL, 0, rel_ageunder40_count), if(rel_ageunder50_count = NULL, 0, rel_ageunder50_count), if(rel_ageunder60_count = NULL, 0, rel_ageunder60_count), if(rel_ageunder70_count = NULL, 0, rel_ageunder70_count), if(rel_ageover70_count = NULL, 0, rel_ageover70_count))) >= 0, truncate(if(max(rel_ageunder20_count * 20, rel_ageunder30_count * 30, rel_ageunder40_count * 40, rel_ageunder50_count * 50, rel_ageunder60_count * 60, rel_ageunder70_count * 70, rel_ageover70_count * 80) = NULL, NULL, sum(if(rel_ageunder20_count * 20 = NULL, 0, rel_ageunder20_count * 20), if(rel_ageunder30_count * 30 = NULL, 0, rel_ageunder30_count * 30), if(rel_ageunder40_count * 40 = NULL, 0, rel_ageunder40_count * 40), if(rel_ageunder50_count * 50 = NULL, 0, rel_ageunder50_count * 50), if(rel_ageunder60_count * 60 = NULL, 0, rel_ageunder60_count * 60), if(rel_ageunder70_count * 70 = NULL, 0, rel_ageunder70_count * 70), if(rel_ageover70_count * 80 = NULL, 0, rel_ageover70_count * 80))) / if(max(rel_ageunder20_count, rel_ageunder30_count, rel_ageunder40_count, rel_ageunder50_count, rel_ageunder60_count, rel_ageunder70_count, rel_ageover70_count) = NULL, NULL, sum(if(rel_ageunder20_count = NULL, 0, rel_ageunder20_count), if(rel_ageunder30_count = NULL, 0, rel_ageunder30_count), if(rel_ageunder40_count = NULL, 0, rel_ageunder40_count), if(rel_ageunder50_count = NULL, 0, rel_ageunder50_count), if(rel_ageunder60_count = NULL, 0, rel_ageunder60_count), if(rel_ageunder70_count = NULL, 0, rel_ageunder70_count), if(rel_ageover70_count = NULL, 0, rel_ageover70_count)))), roundup(if(max(rel_ageunder20_count * 20, rel_ageunder30_count * 30, rel_ageunder40_count * 40, rel_ageunder50_count * 50, rel_ageunder60_count * 60, rel_ageunder70_count * 70, rel_ageover70_count * 80) = NULL, NULL, sum(if(rel_ageunder20_count * 20 = NULL, 0, rel_ageunder20_count * 20), if(rel_ageunder30_count * 30 = NULL, 0, rel_ageunder30_count * 30), if(rel_ageunder40_count * 40 = NULL, 0, rel_ageunder40_count * 40), if(rel_ageunder50_count * 50 = NULL, 0, rel_ageunder50_count * 50), if(rel_ageunder60_count * 60 = NULL, 0, rel_ageunder60_count * 60), if(rel_ageunder70_count * 70 = NULL, 0, rel_ageunder70_count * 70), if(rel_ageover70_count * 80 = NULL, 0, rel_ageover70_count * 80))) / if(max(rel_ageunder20_count, rel_ageunder30_count, rel_ageunder40_count, rel_ageunder50_count, rel_ageunder60_count, rel_ageunder70_count, rel_ageover70_count) = NULL, NULL, sum(if(rel_ageunder20_count = NULL, 0, rel_ageunder20_count), if(rel_ageunder30_count = NULL, 0, rel_ageunder30_count), if(rel_ageunder40_count = NULL, 0, rel_ageunder40_count), if(rel_ageunder50_count = NULL, 0, rel_ageunder50_count), if(rel_ageunder60_count = NULL, 0, rel_ageunder60_count), if(rel_ageunder70_count = NULL, 0, rel_ageunder70_count), if(rel_ageover70_count = NULL, 0, rel_ageover70_count)))))));

nf_youngest_rel_age := __common__( map(
    not(truedid)             => NULL,
    rel_count = 0            => -1,
    rel_ageunder20_count > 0 => 20,
    rel_ageunder30_count > 0 => 30,
    rel_ageunder40_count > 0 => 40,
    rel_ageunder50_count > 0 => 50,
    rel_ageunder60_count > 0 => 60,
    rel_ageunder70_count > 0 => 70,
    rel_ageover70_count > 0  => 80,
                                0));

nf_oldest_rel_age := __common__( map(
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

nf_average_rel_education := __common__( map(
    not(truedid)                                                                                                                                                                                                                                                                                                                  => NULL,
    rel_count = 0                                                                                                                                                                                                                                                                                                                 => -1,
    if(max(rel_educationunder8_count, rel_educationunder12_count, rel_educationover12_count) = NULL, NULL, sum(if(rel_educationunder8_count = NULL, 0, rel_educationunder8_count), if(rel_educationunder12_count = NULL, 0, rel_educationunder12_count), if(rel_educationover12_count = NULL, 0, rel_educationover12_count))) = 0 => 0,
                                                                                                                                                                                                                                                                                                                                     if (if(max(rel_educationunder8_count * 8, rel_educationunder12_count * 12, rel_educationover12_count * 16) = NULL, NULL, sum(if(rel_educationunder8_count * 8 = NULL, 0, rel_educationunder8_count * 8), if(rel_educationunder12_count * 12 = NULL, 0, rel_educationunder12_count * 12), if(rel_educationover12_count * 16 = NULL, 0, rel_educationover12_count * 16))) / if(max(rel_educationunder8_count, rel_educationunder12_count, rel_educationover12_count) = NULL, NULL, sum(if(rel_educationunder8_count = NULL, 0, rel_educationunder8_count), if(rel_educationunder12_count = NULL, 0, rel_educationunder12_count), if(rel_educationover12_count = NULL, 0, rel_educationover12_count))) >= 0, truncate(if(max(rel_educationunder8_count * 8, rel_educationunder12_count * 12, rel_educationover12_count * 16) = NULL, NULL, sum(if(rel_educationunder8_count * 8 = NULL, 0, rel_educationunder8_count * 8), if(rel_educationunder12_count * 12 = NULL, 0, rel_educationunder12_count * 12), if(rel_educationover12_count * 16 = NULL, 0, rel_educationover12_count * 16))) / if(max(rel_educationunder8_count, rel_educationunder12_count, rel_educationover12_count) = NULL, NULL, sum(if(rel_educationunder8_count = NULL, 0, rel_educationunder8_count), if(rel_educationunder12_count = NULL, 0, rel_educationunder12_count), if(rel_educationover12_count = NULL, 0, rel_educationover12_count)))), roundup(if(max(rel_educationunder8_count * 8, rel_educationunder12_count * 12, rel_educationover12_count * 16) = NULL, NULL, sum(if(rel_educationunder8_count * 8 = NULL, 0, rel_educationunder8_count * 8), if(rel_educationunder12_count * 12 = NULL, 0, rel_educationunder12_count * 12), if(rel_educationover12_count * 16 = NULL, 0, rel_educationover12_count * 16))) / if(max(rel_educationunder8_count, rel_educationunder12_count, rel_educationover12_count) = NULL, NULL, sum(if(rel_educationunder8_count = NULL, 0, rel_educationunder8_count), if(rel_educationunder12_count = NULL, 0, rel_educationunder12_count), if(rel_educationover12_count = NULL, 0, rel_educationover12_count)))))));

nf_lowest_rel_education := __common__( map(
    not(truedid)                   => NULL,
    rel_count = 0                  => -1,
    rel_educationunder8_count > 0  => 8,
    rel_educationunder12_count > 0 => 12,
    rel_educationover12_count > 0  => 16,
                                      0));

nf_average_rel_criminal_dist := __common__( map(
    not(truedid)                                                                                                                                                                                                                                                                                                                                                                          => NULL,
    rel_count = 0                                                                                                                                                                                                                                                                                                                                                                         => -1,
    if(max(crim_rel_within25miles, crim_rel_within100miles, crim_rel_within500miles, crim_rel_withinOther) = NULL, NULL, sum(if(crim_rel_within25miles = NULL, 0, crim_rel_within25miles), if(crim_rel_within100miles = NULL, 0, crim_rel_within100miles), if(crim_rel_within500miles = NULL, 0, crim_rel_within500miles), if(crim_rel_withinOther = NULL, 0, crim_rel_withinOther))) = 0 => 0,
                                                                                                                                                                                                                                                                                                                                                                                             if (if(max(crim_rel_within25miles * 25, crim_rel_within100miles * 100, crim_rel_within500miles * 500, crim_rel_withinOther * 1000) = NULL, NULL, sum(if(crim_rel_within25miles * 25 = NULL, 0, crim_rel_within25miles * 25), if(crim_rel_within100miles * 100 = NULL, 0, crim_rel_within100miles * 100), if(crim_rel_within500miles * 500 = NULL, 0, crim_rel_within500miles * 500), if(crim_rel_withinOther * 1000 = NULL, 0, crim_rel_withinOther * 1000))) / if(max(crim_rel_within25miles, crim_rel_within100miles, crim_rel_within500miles, crim_rel_withinOther) = NULL, NULL, sum(if(crim_rel_within25miles = NULL, 0, crim_rel_within25miles), if(crim_rel_within100miles = NULL, 0, crim_rel_within100miles), if(crim_rel_within500miles = NULL, 0, crim_rel_within500miles), if(crim_rel_withinOther = NULL, 0, crim_rel_withinOther))) >= 0, truncate(if(max(crim_rel_within25miles * 25, crim_rel_within100miles * 100, crim_rel_within500miles * 500, crim_rel_withinOther * 1000) = NULL, NULL, sum(if(crim_rel_within25miles * 25 = NULL, 0, crim_rel_within25miles * 25), if(crim_rel_within100miles * 100 = NULL, 0, crim_rel_within100miles * 100), if(crim_rel_within500miles * 500 = NULL, 0, crim_rel_within500miles * 500), if(crim_rel_withinOther * 1000 = NULL, 0, crim_rel_withinOther * 1000))) / if(max(crim_rel_within25miles, crim_rel_within100miles, crim_rel_within500miles, crim_rel_withinOther) = NULL, NULL, sum(if(crim_rel_within25miles = NULL, 0, crim_rel_within25miles), if(crim_rel_within100miles = NULL, 0, crim_rel_within100miles), if(crim_rel_within500miles = NULL, 0, crim_rel_within500miles), if(crim_rel_withinOther = NULL, 0, crim_rel_withinOther)))), roundup(if(max(crim_rel_within25miles * 25, crim_rel_within100miles * 100, crim_rel_within500miles * 500, crim_rel_withinOther * 1000) = NULL, NULL, sum(if(crim_rel_within25miles * 25 = NULL, 0, crim_rel_within25miles * 25), if(crim_rel_within100miles * 100 = NULL, 0, crim_rel_within100miles * 100), if(crim_rel_within500miles * 500 = NULL, 0, crim_rel_within500miles * 500), if(crim_rel_withinOther * 1000 = NULL, 0, crim_rel_withinOther * 1000))) / if(max(crim_rel_within25miles, crim_rel_within100miles, crim_rel_within500miles, crim_rel_withinOther) = NULL, NULL, sum(if(crim_rel_within25miles = NULL, 0, crim_rel_within25miles), if(crim_rel_within100miles = NULL, 0, crim_rel_within100miles), if(crim_rel_within500miles = NULL, 0, crim_rel_within500miles), if(crim_rel_withinOther = NULL, 0, crim_rel_withinOther)))))));

nf_furthest_rel_criminal := __common__( map(
    not(truedid)                => NULL,
    rel_count = 0               => -1,
    crim_rel_withinOther > 0    => 1000,
    crim_rel_within500miles > 0 => 500,
    crim_rel_within100miles > 0 => 100,
    crim_rel_within25miles > 0  => 25,
                                   0));

nf_average_rel_distance := __common__( map(
    not(truedid)                                                                                                                                                                                                                                                                                                                                                                                      => NULL,
    rel_count = 0                                                                                                                                                                                                                                                                                                                                                                                     => -1,
    if(max(rel_within25miles_count, rel_within100miles_count, rel_within500miles_count, rel_withinOther_count) = NULL, NULL, sum(if(rel_within25miles_count = NULL, 0, rel_within25miles_count), if(rel_within100miles_count = NULL, 0, rel_within100miles_count), if(rel_within500miles_count = NULL, 0, rel_within500miles_count), if(rel_withinOther_count = NULL, 0, rel_withinOther_count))) = 0 => 0,
                                                                                                                                                                                                                                                                                                                                                                                                         if (if(max(rel_within25miles_count * 25, rel_within100miles_count * 100, rel_within500miles_count * 500, rel_withinOther_count * 1000) = NULL, NULL, sum(if(rel_within25miles_count * 25 = NULL, 0, rel_within25miles_count * 25), if(rel_within100miles_count * 100 = NULL, 0, rel_within100miles_count * 100), if(rel_within500miles_count * 500 = NULL, 0, rel_within500miles_count * 500), if(rel_withinOther_count * 1000 = NULL, 0, rel_withinOther_count * 1000))) / if(max(rel_within25miles_count, rel_within100miles_count, rel_within500miles_count, rel_withinOther_count) = NULL, NULL, sum(if(rel_within25miles_count = NULL, 0, rel_within25miles_count), if(rel_within100miles_count = NULL, 0, rel_within100miles_count), if(rel_within500miles_count = NULL, 0, rel_within500miles_count), if(rel_withinOther_count = NULL, 0, rel_withinOther_count))) >= 0, truncate(if(max(rel_within25miles_count * 25, rel_within100miles_count * 100, rel_within500miles_count * 500, rel_withinOther_count * 1000) = NULL, NULL, sum(if(rel_within25miles_count * 25 = NULL, 0, rel_within25miles_count * 25), if(rel_within100miles_count * 100 = NULL, 0, rel_within100miles_count * 100), if(rel_within500miles_count * 500 = NULL, 0, rel_within500miles_count * 500), if(rel_withinOther_count * 1000 = NULL, 0, rel_withinOther_count * 1000))) / if(max(rel_within25miles_count, rel_within100miles_count, rel_within500miles_count, rel_withinOther_count) = NULL, NULL, sum(if(rel_within25miles_count = NULL, 0, rel_within25miles_count), if(rel_within100miles_count = NULL, 0, rel_within100miles_count), if(rel_within500miles_count = NULL, 0, rel_within500miles_count), if(rel_withinOther_count = NULL, 0, rel_withinOther_count)))), roundup(if(max(rel_within25miles_count * 25, rel_within100miles_count * 100, rel_within500miles_count * 500, rel_withinOther_count * 1000) = NULL, NULL, sum(if(rel_within25miles_count * 25 = NULL, 0, rel_within25miles_count * 25), if(rel_within100miles_count * 100 = NULL, 0, rel_within100miles_count * 100), if(rel_within500miles_count * 500 = NULL, 0, rel_within500miles_count * 500), if(rel_withinOther_count * 1000 = NULL, 0, rel_withinOther_count * 1000))) / if(max(rel_within25miles_count, rel_within100miles_count, rel_within500miles_count, rel_withinOther_count) = NULL, NULL, sum(if(rel_within25miles_count = NULL, 0, rel_within25miles_count), if(rel_within100miles_count = NULL, 0, rel_within100miles_count), if(rel_within500miles_count = NULL, 0, rel_within500miles_count), if(rel_withinOther_count = NULL, 0, rel_withinOther_count)))))));

nf_rel_bankrupt_count := __common__( map(
    not(truedid)  => NULL,
    rel_count = 0 => -1,
                     min(if(rel_bankrupt_count = NULL, -NULL, rel_bankrupt_count), 999)));

nf_rel_criminal_count := __common__( map(
    not(truedid)  => NULL,
    rel_count = 0 => -1,
                     min(if(rel_criminal_count = NULL, -NULL, rel_criminal_count), 999)));

nf_rel_felony_count := __common__( map(
    not(truedid)  => NULL,
    rel_count = 0 => -1,
                     min(if(rel_felony_count = NULL, -NULL, rel_felony_count), 999)));

nf_pct_rel_with_bk := __common__( map(
    not(truedid)  => NULL,
    rel_count = 0 => -1,
                     rel_bankrupt_count / rel_count));

nf_pct_rel_with_criminal := __common__( map(
    not(truedid)  => NULL,
    rel_count = 0 => -1,
                     rel_criminal_count / rel_count));

nf_pct_rel_with_felony := __common__( map(
    not(truedid)  => NULL,
    rel_count = 0 => -1,
                     rel_felony_count / rel_count));

nf_rel_derog_summary := __common__( map(
    not(truedid)  => NULL,
    rel_count = 0 => -1,
                     if(max(min(if(rel_bankrupt_count = NULL, -NULL, rel_bankrupt_count), 3), min(if(rel_felony_count = NULL, -NULL, rel_felony_count), 3), min(if(rel_criminal_count - rel_felony_count = NULL, -NULL, rel_criminal_count - rel_felony_count), 3)) = NULL, NULL, sum(if(min(if(rel_bankrupt_count = NULL, -NULL, rel_bankrupt_count), 3) = NULL, 0, min(if(rel_bankrupt_count = NULL, -NULL, rel_bankrupt_count), 3)), if(min(if(rel_felony_count = NULL, -NULL, rel_felony_count), 3) = NULL, 0, min(if(rel_felony_count = NULL, -NULL, rel_felony_count), 3)), if(min(if(rel_criminal_count - rel_felony_count = NULL, -NULL, rel_criminal_count - rel_felony_count), 3) = NULL, 0, min(if(rel_criminal_count - rel_felony_count = NULL, -NULL, rel_criminal_count - rel_felony_count), 3))))));

nf_pct_rel_prop_owned := __common__( map(
    not(truedid)  => NULL,
    rel_count = 0 => -1,
                     min(if(rel_prop_owned_count / rel_count = NULL, -NULL, rel_prop_owned_count / rel_count), 1.0)));

nf_pct_rel_prop_sold := __common__( map(
    not(truedid)  => NULL,
    rel_count = 0 => -1,
                     min(if(rel_prop_sold_count / rel_count = NULL, -NULL, rel_prop_sold_count / rel_count), 1.0)));

nf_current_count := __common__( if(not(truedid), NULL, min(if(current_count = NULL, -NULL, current_count), 999)));

nf_historical_count := __common__( if(not(truedid), NULL, min(if(historical_count = NULL, -NULL, historical_count), 999)));

nf_historic_x_current_ct := __common__( __common__( if(not(truedid), '', trim((String)min(if(historical_count = NULL, -NULL, historical_count), 3), LEFT, RIGHT) 
+ trim('-', LEFT, RIGHT) + trim((String)min(if(current_count = NULL, -NULL, current_count), 3), LEFT, RIGHT))));

	nf_acc_damage_amt_total := if(not(truedid), (Unsigned)NULL, acc_damage_amt_total);

_acc_last_seen := __common__( common.sas_date((string)(acc_last_seen)));

nf_mos_acc_lseen := __common__( map(
    not(truedid)          => NULL,
    _acc_last_seen = NULL => -1,
                             min(if(if ((sysdate - _acc_last_seen) / (365.25 / 12) >= 0, truncate((sysdate - _acc_last_seen) / (365.25 / 12)), roundup((sysdate - _acc_last_seen) / (365.25 / 12))) = NULL, -NULL, if ((sysdate - _acc_last_seen) / (365.25 / 12) >= 0, truncate((sysdate - _acc_last_seen) / (365.25 / 12)), roundup((sysdate - _acc_last_seen) / (365.25 / 12)))), 999)));

nf_accident_recency := __common__( map(
    not(truedid)  => NULL,
    (Boolean)acc_count_30  => 1,
    (Boolean)acc_count_90  => 3,
    (Boolean)acc_count_180 => 6,
    (Boolean)acc_count_12  => 12,
    (Boolean)acc_count_24  => 24,
    (Boolean)acc_count_36  => 36,
    (Boolean)acc_count_60  => 60,
    (Boolean)acc_count     => 99,
                     0));

nf_fp_idrisktype := __common__( map(
    not(truedid)         => NULL,
    fp_idrisktype = '' => NULL,
                            (Integer)trim(fp_idrisktype, LEFT)));

nf_fp_idveraddressnotcurrent_1 := __common__( if(not(truedid), NULL, NULL));

nf_fp_idveraddressnotcurrent := __common__( if(fp_idveraddressnotcurrent = '', NULL, (Integer)trim(fp_idveraddressnotcurrent, LEFT)));

nf_fp_sourcerisktype := __common__( map(
	  not(truedid)             => NULL,
	  fp_sourcerisktype = ''   => NULL,
	                                (Integer)trim(fp_sourcerisktype, LEFT)));

nf_fp_varrisktype := __common__( map(
    not(truedid)          => NULL,
    fp_varrisktype = '' => NULL,
            (Integer)trim(fp_varrisktype, LEFT)));

nf_fp_varmsrcssnunrelcount := __common__( if(not(truedid), NULL, min(if(fp_varmsrcssnunrelcount = '', -NULL, (Integer)fp_varmsrcssnunrelcount), 999)));

	nf_fp_srchvelocityrisktype := __common__( map(
	    not(truedid)                   => NULL,
	    fp_srchvelocityrisktype = ''	 => NULL,
	                                      (INTEGER)trim(fp_srchvelocityrisktype, LEFT)));

nf_fp_srchunvrfdssncount := __common__( __common__( if(not(truedid), NULL, min(if(fp_srchunvrfdssncount = '', -NULL, (Integer)fp_srchunvrfdssncount), 999))));

nf_fp_srchunvrfdaddrcount := __common__( if(not(truedid), NULL, min(if(fp_srchunvrfdaddrcount = '', -NULL, (Integer)fp_srchunvrfdaddrcount), 999)));

nf_fp_srchunvrfddobcount := __common__( if(not(truedid), NULL, min(if(fp_srchunvrfddobcount = '', -NULL, (Integer)fp_srchunvrfddobcount), 999)));

nf_fp_srchunvrfdphonecount := __common__( if(not(truedid), NULL, min(if(fp_srchunvrfdphonecount = '', -NULL, (Integer)fp_srchunvrfdphonecount), 999)));

nf_fp_srchfraudsrchcountyr := __common__( if(not(truedid), NULL, min(if(fp_srchfraudsrchcountyr = '', -NULL, (Integer)fp_srchfraudsrchcountyr), 999)));

nf_fp_srchfraudsrchcountmo := __common__( if(not(truedid), NULL, min(if(fp_srchfraudsrchcountmo = '', -NULL, (Integer)fp_srchfraudsrchcountmo), 999)));

nf_fp_srchfraudsrchcountwk := __common__( if(not(truedid), NULL, min(if(fp_srchfraudsrchcountwk = '', -NULL, (Integer)fp_srchfraudsrchcountwk), 999)));

nf_fp_srchfraudsrchcountday := __common__( if(not(truedid), NULL, min(if(fp_srchfraudsrchcountday = '', -NULL, (Integer)fp_srchfraudsrchcountday), 999)));

nf_fp_assocsuspicousidcount := __common__( if(not(truedid), NULL, min(if(fp_assocsuspicousidcount = '', -NULL, (Integer)fp_assocsuspicousidcount), 999)));

nf_fp_validationrisktype := __common__( map(
    not(truedid)                 => NULL,
    fp_validationrisktype = '' => NULL,
                                    (Integer)trim(fp_validationrisktype, LEFT)));

nf_fp_divrisktype := __common__( map(
    not(truedid)          => NULL,
    fp_divrisktype = '' => NULL,
                             (Integer)trim(fp_divrisktype, LEFT)));

nf_fp_divaddrsuspidcountnew := __common__( if(not(truedid), NULL, min(if(fp_divaddrsuspidcountnew = '', -NULL, (Integer)fp_divaddrsuspidcountnew), 999)));

nf_fp_srchcomponentrisktype := __common__( map(
    not(truedid)   => NULL,
    fp_srchcomponentrisktype = '' => NULL,
                      (Integer)trim(fp_srchcomponentrisktype, LEFT)));

nf_fp_srchssnsrchcountmo := __common__( if(not(truedid), NULL, min(if(fp_srchssnsrchcountmo = '', -NULL, (Integer)fp_srchssnsrchcountmo), 999)));

nf_fp_srchssnsrchcountwk := __common__( if(not(truedid), NULL, min(if(fp_srchssnsrchcountwk = '', -NULL, (Integer)fp_srchssnsrchcountwk), 999)));

nf_fp_srchssnsrchcountday := __common__( if(not(truedid), NULL, min(if(fp_srchssnsrchcountday = '', -NULL, (Integer)fp_srchssnsrchcountday), 999)));

nf_fp_srchaddrsrchcountmo := __common__( if(not(truedid), NULL, min(if(fp_srchaddrsrchcountmo = '', -NULL, (Integer)fp_srchaddrsrchcountmo), 999)));

nf_fp_srchaddrsrchcountwk := __common__( if(not(truedid), NULL, min(if(fp_srchaddrsrchcountwk = '', -NULL, (Integer)fp_srchaddrsrchcountwk), 999)));

nf_fp_srchaddrsrchcountday := __common__( if(not(truedid), NULL, min(if(fp_srchaddrsrchcountday = '', -NULL, (Integer)fp_srchaddrsrchcountday), 999)));

nf_fp_srchphonesrchcountmo := __common__( if(not(truedid), NULL, min(if(fp_srchphonesrchcountmo = '', -NULL, (Integer)fp_srchphonesrchcountmo), 999)));

nf_fp_srchphonesrchcountwk := __common__( if(not(truedid), NULL, min(if(fp_srchphonesrchcountwk = '', -NULL, (Integer)fp_srchphonesrchcountwk), 999)));

nf_fp_srchphonesrchcountday := __common__( if(not(truedid), NULL, min(if(fp_srchphonesrchcountday = '', -NULL, (Integer)fp_srchphonesrchcountday), 999)));

nf_fp_componentcharrisktype := __common__( map(
    not(truedid)                    => NULL,
    fp_componentcharrisktype = '' => NULL,
                                       (Integer)trim(fp_componentcharrisktype, LEFT)));

nf_fp_inputaddractivephonelist := __common__( map(
    not(truedid)                       => NULL,
    fp_inputaddractivephonelist = '' => NULL,
                                          (Integer)trim(fp_inputaddractivephonelist, LEFT)));

nf_fp_addrchangeincomediff := __common__( if(not(truedid), NULL, (Integer)fp_addrchangeincomediff));

nf_fp_addrchangevaluediff := __common__( if(not(truedid), NULL, (Integer)fp_addrchangevaluediff));

nf_fp_addrchangecrimediff := __common__( if(not(truedid), NULL, (Integer)fp_addrchangecrimediff));

nf_fp_addrchangeecontraj := __common__( if(not(truedid), '', trim(fp_addrchangeecontraj, LEFT)));

nf_fp_curraddractivephonelist := __common__( map(
    not(truedid)                      => NULL,
    fp_curraddractivephonelist = '' => NULL,
                                         (Integer)trim(fp_curraddractivephonelist, LEFT)));

nf_fp_curraddrmedianincome := __common__( if(not(truedid), NULL, (Integer)fp_curraddrmedianincome));

nf_fp_curraddrmedianvalue := __common__( if(not(truedid), NULL, (Integer)fp_curraddrmedianvalue));

nf_fp_curraddrmurderindex := __common__( if(not(truedid), NULL, (Integer)fp_curraddrmurderindex));

nf_fp_curraddrcartheftindex := __common__( if(not(truedid), NULL, (Integer)fp_curraddrcartheftindex));

nf_fp_curraddrburglaryindex := __common__( if(not(truedid), NULL, (Integer)fp_curraddrburglaryindex));

nf_fp_curraddrcrimeindex := __common__( if(not(truedid), NULL, (Integer)fp_curraddrcrimeindex));

nf_fp_prevaddrageoldest := __common__( if(not(truedid), NULL, min(if(fp_prevaddrageoldest = '', -NULL, (Integer)fp_prevaddrageoldest), 999)));

nf_fp_prevaddrlenofres := __common__( if(not(truedid), NULL, min(if(fp_prevaddrlenofres = '', -NULL, (Integer)fp_prevaddrlenofres), 999)));

nf_fp_prevaddrmedianincome := __common__( if(not(truedid), NULL, (Integer)fp_prevaddrmedianincome));

nf_fp_prevaddrmedianvalue := __common__( if(not(truedid), NULL, (Integer)fp_prevaddrmedianvalue));

nf_fp_prevaddrmurderindex := __common__( if(not(truedid), NULL, (Integer)fp_prevaddrmurderindex));

nf_fp_prevaddrcartheftindex := __common__( if(not(truedid), NULL, (Integer)fp_prevaddrcartheftindex));

nf_fp_prevaddrburglaryindex := __common__( if(not(truedid), NULL, (Integer)fp_prevaddrburglaryindex));

nf_fp_prevaddrcrimeindex := __common__( if(not(truedid), NULL, (Integer)fp_prevaddrcrimeindex));

Integer Sum_String(String source, string delimitor = ',') := Function
	lay1 := record
	string num;
	end;

	lay2 := record
	integer seq;
	integer num;
	end;

	str_set := STD.Str.SplitWords(source, delimitor);

	str_dataset := dataset(str_set, lay1);

	lay2 convertthem(lay1 le) := transform
	 self.num := (Integer)le.num;
	 SELF := [];
	end;

	convert := project(str_dataset, convertthem(left));

	final := ROLLUP(convert, LEFT.seq = RIGHT.seq,
									TRANSFORM(lay2, SELF.num := LEFT.num + RIGHT.num; SELF := LEFT;));

	Return final[1].num;																
END;



// number                 := __common__( std.str.CountWords(ver_sources_count,','));
// ver_sources_count_repl := __common__( std.str.FindReplace(ver_sources_count,',',' '));
 
// #DECLARE (i);
// #DECLARE (total);
// #SET (i, 1);
// #SET (total, 0);
// #LOOP
    // #IF (%i% > number)
        // #BREAK
    // #ELSE
        // #SET (total, %total% + (INTEGER)std.str.GetNthWord(ver_sources_count_repl, %i%));
        // #SET (i, %i% + 1);
    // #END
// #END

// record_count := __common__( %total%);

record_count := Sum_String(ver_sources_count);

// **************************************************************

bureau_adl_eq_fseen_pos := __common__( Models.Common.findw_cpp(ver_sources, 'EQ' , ', ', 'E'));

bureau_adl_fseen_eq := __common__( if(bureau_adl_eq_fseen_pos = 0, '       0', Models.Common.getw(ver_sources_first_seen, bureau_adl_eq_fseen_pos, ',')));

_bureau_adl_fseen_eq := __common__( common.sas_date((string)(bureau_adl_fseen_eq)));

bureau_adl_en_fseen_pos := __common__( Models.Common.findw_cpp(ver_sources, 'EN' , ',', 'E'));

bureau_adl_fseen_en := __common__( if(bureau_adl_en_fseen_pos = 0, '       0', Models.Common.getw(ver_sources_first_seen, bureau_adl_en_fseen_pos, ',')));

_bureau_adl_fseen_en := __common__( common.sas_date((string)(bureau_adl_fseen_en)));

bureau_adl_ts_fseen_pos := __common__( Models.Common.findw_cpp(ver_sources, 'TS' , ',', 'E'));

bureau_adl_fseen_ts := __common__( if(bureau_adl_ts_fseen_pos = 0, '       0', Models.Common.getw(ver_sources_first_seen, bureau_adl_ts_fseen_pos, ',')));

_bureau_adl_fseen_ts := __common__( common.sas_date((string)(bureau_adl_fseen_ts)));

bureau_adl_tu_fseen_pos := __common__( Models.Common.findw_cpp(ver_sources, 'TU' , ',', 'E'));

bureau_adl_fseen_tu := __common__( if(bureau_adl_tu_fseen_pos = 0, '       0', Models.Common.getw(ver_sources_first_seen, bureau_adl_tu_fseen_pos, ',')));

_bureau_adl_fseen_tu := __common__( common.sas_date((string)(bureau_adl_fseen_tu)));

bureau_adl_tn_fseen_pos := __common__( Models.Common.findw_cpp(ver_sources, 'TN' , ',', 'E'));

bureau_adl_fseen_tn := __common__( if(bureau_adl_tn_fseen_pos = 0, '       0', Models.Common.getw(ver_sources_first_seen, bureau_adl_tn_fseen_pos, ',')));

_bureau_adl_fseen_tn := __common__( common.sas_date((string)(bureau_adl_fseen_tn)));

_src_bureau_adl_fseen_all := __common__( min(if(_bureau_adl_fseen_tn = NULL, -NULL, _bureau_adl_fseen_tn), if(_bureau_adl_fseen_ts = NULL, -NULL, _bureau_adl_fseen_ts), if(_bureau_adl_fseen_tu = NULL, -NULL, _bureau_adl_fseen_tu), if(_bureau_adl_fseen_en = NULL, -NULL, _bureau_adl_fseen_en), if(_bureau_adl_fseen_eq = NULL, -NULL, _bureau_adl_fseen_eq), 999999));

credit_bureau_oldest := __common__( map(
    not(truedid)                       => NULL,
    _src_bureau_adl_fseen_all = 999999 => -1,
                                          if ((sysdate - _src_bureau_adl_fseen_all) / (365.25 / 12) >= 0, truncate((sysdate - _src_bureau_adl_fseen_all) / (365.25 / 12)), roundup((sysdate - _src_bureau_adl_fseen_all) / (365.25 / 12)))));

num_sources := __common__( (integer)(contains_i(ver_sources, 'EB') > 0) +
    (integer)(contains_i(ver_sources, 'EM') > 0) +
    (integer)(contains_i(ver_sources, 'E1') > 0) +
    (integer)(contains_i(ver_sources, 'E2') > 0) +
    (integer)(contains_i(ver_sources, 'E3') > 0) +
    (integer)(contains_i(ver_sources, 'P ') > 0) +
    (integer)(contains_i(ver_sources, 'PL') > 0) +
    (integer)(contains_i(ver_sources, 'SL') > 0) +
    (integer)(contains_i(ver_sources, 'V ') > 0) +
    (integer)(contains_i(ver_sources, 'VO') > 0) +
    (integer)(contains_i(ver_sources, 'W ') > 0) +
    (integer)(contains_i(ver_sources, 'D ') > 0 or (Boolean)contains_i(ver_sources, 'DL')));

nf_qb4987_synthetic_index := __common__( map(
    not(truedid)                                                                                                                                                                                                                        => NULL,
    (0 <= record_count AND record_count <= 17 and 1 <= credit_bureau_oldest AND credit_bureau_oldest <= 4 or record_count >= 18 and 1 <= credit_bureau_oldest AND credit_bureau_oldest <= 4) and 0 <= num_sources AND num_sources < 2   => 3,
    (0 <= record_count AND record_count <= 17 and 5 <= credit_bureau_oldest AND credit_bureau_oldest <= 15 or record_count >= 18 and 5 <= credit_bureau_oldest AND credit_bureau_oldest <= 15) and 0 <= num_sources AND num_sources < 2 => 2,
    (0 <= record_count AND record_count <= 17 and 16 <= credit_bureau_oldest AND credit_bureau_oldest <= 74 or record_count >= 18 and credit_bureau_oldest = 16) and 0 <= num_sources AND num_sources < 2                               => 1,
                                                                                                                                                                                                                                           0));

bureau_ := __common__( contains_i(ver_sources, 'EN') > 0 or contains_i(ver_sources, 'EQ') > 0 or contains_i(ver_sources, 'TN') > 0 or contains_i(ver_sources, 'TS') > 0 or contains_i(ver_sources, 'TU') > 0);

behavioral_ := __common__( contains_i(ver_sources, 'CY') > 0 or contains_i(ver_sources, 'PL') > 0 or contains_i(ver_sources, 'SL') > 0 or contains_i(ver_sources, 'WP') > 0);

government_ := __common__( contains_i(ver_sources, 'AK') > 0 or contains_i(ver_sources, 'AM') > 0 or contains_i(ver_sources, 'AR') > 0 or contains_i(ver_sources, 'BA') > 0 or contains_i(ver_sources, 'CG') > 0 or contains_i(ver_sources, 'DA') > 0 or contains_i(ver_sources, 'D ') > 0 or contains_i(ver_sources, 'DL') > 0 or contains_i(ver_sources, 'DS') > 0 or contains_i(ver_sources, 'DE') > 0 or contains_i(ver_sources, 'EB') > 0 or contains_i(ver_sources, 'EM') > 0 or contains_i(ver_sources, 'E1') > 0 or contains_i(ver_sources, 'E2') > 0 or contains_i(ver_sources, 'E3') > 0 or contains_i(ver_sources, 'E4') > 0 or contains_i(ver_sources, 'FE') > 0 or contains_i(ver_sources, 'FF') > 0 or contains_i(ver_sources, 'FR') > 0 or contains_i(ver_sources, 'L2') > 0 or contains_i(ver_sources, 'LI') > 0 or contains_i(ver_sources, 'MW') > 0 or contains_i(ver_sources, 'NT') > 0 or contains_i(ver_sources, 'P ') > 0 or contains_i(ver_sources, 'V ') > 0 or contains_i(ver_sources, 'VO') > 0 or contains_i(ver_sources, 'W ') > 0);

nf_source_type := __common__( map(
    not(truedid)                                      => ' ',
    bureau_ and behavioral_ and government_           => 'Bureau Behavioral and Government',
    not(bureau_) and behavioral_ and government_      => 'Behavioral and Government',
    bureau_ and not(behavioral_) and government_      => 'Bureau and Government',
    bureau_ and behavioral_ and not(government_)      => 'Bureau and Behavioral',
    not(bureau_) and not(behavioral_) and government_ => 'Government Only',
    not(bureau_) and behavioral_ and not(government_) => 'Behavioral Only',
    bureau_ and not(behavioral_) and not(government_) => 'Bureau Only',
                                                         'None'));

nf_number_non_bureau_sources := __common__( if(not(truedid), NULL, if((Integer)max((integer)contains_i(ver_sources, 'CY') > 0, (integer)contains_i(ver_sources, 'PL') > 0, (integer)contains_i(ver_sources, 'SL') > 0, 
(integer)contains_i(ver_sources, 'WP') > 0, (integer)contains_i(ver_sources, 'AK') > 0, (integer)contains_i(ver_sources, 'AM') > 0, (integer)contains_i(ver_sources, 'AR') > 0, 
(integer)contains_i(ver_sources, 'BA') > 0, (integer)contains_i(ver_sources, 'CG') > 0, (integer)contains_i(ver_sources, 'DA') > 0, (integer)contains_i(ver_sources, 'D ') > 0, 
(integer)contains_i(ver_sources, 'DL') > 0, (integer)contains_i(ver_sources, 'DS') > 0, (integer)contains_i(ver_sources, 'DE') > 0, (integer)contains_i(ver_sources, 'EB') > 0, 
(integer)contains_i(ver_sources, 'EM') > 0, (integer)contains_i(ver_sources, 'E1') > 0, (integer)contains_i(ver_sources, 'E2') > 0, (integer)contains_i(ver_sources, 'E3') > 0, 
(integer)contains_i(ver_sources, 'E4') > 0, (integer)contains_i(ver_sources, 'FE') > 0, (integer)contains_i(ver_sources, 'FF') > 0, (integer)contains_i(ver_sources, 'FR') > 0, 
(integer)contains_i(ver_sources, 'L2') > 0, (integer)contains_i(ver_sources, 'LI') > 0, (integer)contains_i(ver_sources, 'MW') > 0, (integer)contains_i(ver_sources, 'NT') > 0, 
(integer)contains_i(ver_sources, 'P ') > 0, (integer)contains_i(ver_sources, 'V ') > 0, (integer)contains_i(ver_sources, 'VO') > 0, (integer)contains_i(ver_sources, 'W ') > 0) = NULL, NULL, 
(Integer)sum((integer)contains_i(ver_sources, 'CY') > 0, (integer)contains_i(ver_sources, 'PL') > 0, (integer)contains_i(ver_sources, 'SL') > 0, (integer)contains_i(ver_sources, 'WP') > 0, 
 (integer)contains_i(ver_sources, 'AK') > 0, (integer)contains_i(ver_sources, 'AM') > 0, (integer)contains_i(ver_sources, 'AR') > 0, (integer)contains_i(ver_sources, 'BA') > 0, 
 (integer)contains_i(ver_sources, 'CG') > 0, (integer)contains_i(ver_sources, 'DA') > 0, (integer)contains_i(ver_sources, 'D ') > 0, (integer)contains_i(ver_sources, 'DL') > 0, 
 (integer)contains_i(ver_sources, 'DS') > 0, (integer)contains_i(ver_sources, 'DE') > 0, (integer)contains_i(ver_sources, 'EB') > 0, (integer)contains_i(ver_sources, 'EM') > 0, 
 (integer)contains_i(ver_sources, 'E1') > 0, (integer)contains_i(ver_sources, 'E2') > 0, (integer)contains_i(ver_sources, 'E3') > 0, (integer)contains_i(ver_sources, 'E4') > 0, 
 (integer)contains_i(ver_sources, 'FE') > 0, (integer)contains_i(ver_sources, 'FF') > 0, (integer)contains_i(ver_sources, 'FR') > 0, (integer)contains_i(ver_sources, 'L2') > 0, 
 (integer)contains_i(ver_sources, 'LI') > 0, (integer)contains_i(ver_sources, 'MW') > 0, (integer)contains_i(ver_sources, 'NT') > 0, (integer)contains_i(ver_sources, 'P ') > 0, 
 (integer)contains_i(ver_sources, 'V ') > 0, (integer)contains_i(ver_sources, 'VO') > 0, (integer)contains_i(ver_sources, 'W ') > 0))));

nf_number_bureau_sources := __common__( if(not(truedid), NULL, if((Integer)max((integer)contains_i(ver_sources, 'EN') > 0, (integer)contains_i(ver_sources, 'EQ') > 0, (integer)contains_i(ver_sources, 'TN') > 0 
or contains_i(ver_sources, 'TS') > 0 or contains_i(ver_sources, 'TU') > 0) = NULL, NULL, (Integer)sum((integer)contains_i(ver_sources, 'EN') > 0, (integer)contains_i(ver_sources, 'EQ') > 0, 
(integer)contains_i(ver_sources, 'TN') > 0 or contains_i(ver_sources, 'TS') > 0 or contains_i(ver_sources, 'TU') > 0))));

_add_not_ver_2 := __common__( (nas_summary in [4, 7, 9]));

nf_inq_per_ssn_nas_479 := __common__( map(
    not(truedid and ssnlength > '0') => NULL,
    not(_add_not_ver_2)            => -1,
                                      min(if(inq_perssn = NULL, -NULL, inq_perssn), 999)));

_add_not_ver_1 := __common__( (nas_summary in [4, 7, 9]));

nf_inq_per_add_nas_479 := __common__( map(
    not(truedid and ssnlength > '0' or addrpop) => NULL,
    not(_add_not_ver_1)                       => -1,
                                                 min(if(inq_peraddr = NULL, -NULL, inq_peraddr), 999)));

_add_not_ver := __common__( (nas_summary in [4, 7, 9]));

nf_inq_add_per_ssn_nas_479 := __common__( map(
    not(truedid and ssnlength > '0') => NULL,
    not(_add_not_ver)              => -1,
                                      min(if(Inq_AddrsPerSSN = NULL, -NULL, Inq_AddrsPerSSN), 999)));

lic_adl_d_count_pos := __common__( Models.Common.findw_cpp(ver_sources, 'D' , ', ', 'E'));

lic_adl_count_d := __common__( if(lic_adl_d_count_pos = 0, NULL, (integer)Models.Common.getw(ver_sources_count, lic_adl_d_count_pos, ',')));

lic_adl_dl_count_pos := __common__( Models.Common.findw_cpp(ver_sources, 'DL' , ', ', 'E'));

lic_adl_count_dl := __common__( if(lic_adl_dl_count_pos = 0, NULL, (integer)Models.Common.getw(ver_sources_count, lic_adl_dl_count_pos, ',')));

_src_vehx_adl_count := __common__( max(if(max(lic_adl_count_d, lic_adl_count_dl) = NULL, NULL, sum(if(lic_adl_count_d = NULL, 0, lic_adl_count_d), if(lic_adl_count_dl = NULL, 0, lic_adl_count_dl))), (real)0));

iv_src_drivers_lic_adl_count := __common__( map(
    not(truedid)               => NULL,
    not(dl_avail)              => -1,
    _src_vehx_adl_count = NULL => -1,
                                  _src_vehx_adl_count));

iv_dl_val_flag := __common__( map(
    not(truedid)         => '         ',
    not(dl_avail)        => 'Not Avail',
    rc_dl_val_flag = '0' => 'Valid    ',
    rc_dl_val_flag = '2' => 'Empty    ',
                            'Invalid  '));

voter_adl_v_count_pos := __common__( Models.Common.findw_cpp(ver_sources, 'VO' , ', ', 'E'));

iv_src_voter_adl_count := __common__( map(
    not(truedid)              => NULL,
    not(voter_avail)          => -1,
    voter_adl_v_count_pos = 0 => 0,
                                 (integer)Models.Common.getw(ver_sources_count, voter_adl_v_count_pos, ',')));

vote_adl_vo_lseen_pos := __common__( Models.Common.findw_cpp(ver_sources, 'VO' , ', ', 'E'));

vote_adl_lseen_vo := __common__( if(vote_adl_vo_lseen_pos = 0, '       0', Models.Common.getw(ver_sources_last_seen, vote_adl_vo_lseen_pos, ',')));

_vote_adl_lseen_vo := __common__( common.sas_date((string)(vote_adl_lseen_vo)));

_src_vote_adl_lseen := __common__( _vote_adl_lseen_vo);

iv_mos_src_voter_adl_lseen := __common__( map(
    not(truedid)               => NULL,
    not(voter_avail)           => -1,
    _src_vote_adl_lseen = NULL => -1,
                                  if ((sysdate - _src_vote_adl_lseen) / (365.25 / 12) >= 0, truncate((sysdate - _src_vote_adl_lseen) / (365.25 / 12)), roundup((sysdate - _src_vote_adl_lseen) / (365.25 / 12)))));
final_score_0 :=  -2.1127262544;

// Tree: 1
final_score_1 := map(
( NULL < nf_fp_srchfraudsrchcountmo and nf_fp_srchfraudsrchcountmo <= 1.5) => map(
   ( NULL < rv_I60_inq_hiRiskCred_recency and rv_I60_inq_hiRiskCred_recency <= 4.5) => 0.0070496061, 
   (rv_I60_inq_hiRiskCred_recency > 4.5) => -0.0516462505, -0.0277493495), 
(nf_fp_srchfraudsrchcountmo > 1.5) => map(
   ( NULL < nf_fp_srchfraudsrchcountwk and nf_fp_srchfraudsrchcountwk <= 0.5) => 0.0571138356, 
   (nf_fp_srchfraudsrchcountwk > 0.5) => 0.1513952585, 0.0984437418), -0.0001319727);

// Tree: 2
final_score_2 := map(
( NULL < nf_fp_srchcomponentrisktype and nf_fp_srchcomponentrisktype <= 1.5) => map(
   ( NULL < nf_phone_ver_experian and nf_phone_ver_experian <= 0.5) => 0.0089314793, 
   (nf_phone_ver_experian > 0.5) => -0.0517595789, -0.0345339017), 
(nf_fp_srchcomponentrisktype > 1.5) => map(
   ( NULL < nf_phone_ver_experian and nf_phone_ver_experian <= 0.5) => 0.1185963865, 
   (nf_phone_ver_experian > 0.5) => 0.0331350787, 0.0627255778), -0.0015678541);

// Tree: 3
final_score_3 := map(
( NULL < nf_fp_srchcomponentrisktype and nf_fp_srchcomponentrisktype <= 3.5) => map(
   ( NULL < rv_I60_inq_hiRiskCred_recency and rv_I60_inq_hiRiskCred_recency <= 4.5) => 0.0077848043, 
   (rv_I60_inq_hiRiskCred_recency > 4.5) => -0.0467452965, -0.0231876763), 
(nf_fp_srchcomponentrisktype > 3.5) => map(
   ( NULL < nf_fp_srchfraudsrchcountwk and nf_fp_srchfraudsrchcountwk <= 0.5) => 0.0526867055, 
   (nf_fp_srchfraudsrchcountwk > 0.5) => 0.1310078520, 0.0868670633), -0.0033165439);

// Tree: 4
final_score_4 := map(
( NULL < nf_fp_srchfraudsrchcountwk and nf_fp_srchfraudsrchcountwk <= 0.5) => map(
   ( NULL < rv_I60_inq_hiRiskCred_recency and rv_I60_inq_hiRiskCred_recency <= 4.5) => map(
      ( NULL < nf_phone_ver_experian and nf_phone_ver_experian <= 0.5) => 0.0568712902, 
      (nf_phone_ver_experian > 0.5) => -0.0092227537, 0.0122353413), 
   (rv_I60_inq_hiRiskCred_recency > 4.5) => -0.0476020671, -0.0200990472), 
(nf_fp_srchfraudsrchcountwk > 0.5) => 0.0880596839, -0.0045929130);

// Tree: 5
final_score_5 := map(
( NULL < nf_fp_srchfraudsrchcountmo and nf_fp_srchfraudsrchcountmo <= 1.5) => map(
   ( NULL < nf_phone_ver_experian and nf_phone_ver_experian <= 0.5) => 0.0128697004, 
   (nf_phone_ver_experian > 0.5) => -0.0388658967, -0.0237297942), 
(nf_fp_srchfraudsrchcountmo > 1.5) => map(
   ( NULL < nf_phone_ver_experian and nf_phone_ver_experian <= 0.5) => 0.0983693877, 
   (nf_phone_ver_experian > 0.5) => 0.0363468612, 0.0579827965), -0.0059139651);

// Tree: 6
final_score_6 := map(
( NULL < nf_fp_srchfraudsrchcountwk and nf_fp_srchfraudsrchcountwk <= 0.5) => map(
   ( NULL < nf_fp_varrisktype and nf_fp_varrisktype <= 2.5) => -0.0344680948, 
   (nf_fp_varrisktype > 2.5) => 0.0175566661, -0.0160576346), 
(nf_fp_srchfraudsrchcountwk > 0.5) => map(
   ( NULL < nf_phone_ver_experian and nf_phone_ver_experian <= 0.5) => 0.1061693294, 
   (nf_phone_ver_experian > 0.5) => 0.0424865594, 0.0660796873), -0.0041606158);

// Tree: 7
final_score_7 := map(
( NULL < nf_fp_srchphonesrchcountmo and nf_fp_srchphonesrchcountmo <= 0.5) => map(
   ( NULL < rv_comb_age and rv_comb_age <= 28.5) => 0.0236728482, 
   (rv_comb_age > 28.5) => -0.0359194294, -0.0257925713), 
(nf_fp_srchphonesrchcountmo > 0.5) => map(
   ( NULL < nf_fp_srchcomponentrisktype and nf_fp_srchcomponentrisktype <= 6.5) => 0.0243449940, 
   (nf_fp_srchcomponentrisktype > 6.5) => 0.0860410942, 0.0377714411), -0.0057739366);

// Tree: 8
final_score_8 := map(
( NULL < nf_fp_srchcomponentrisktype and nf_fp_srchcomponentrisktype <= 3.5) => map(
   ( NULL < rv_I60_inq_comm_recency and rv_I60_inq_comm_recency <= 0.5) => -0.0321670656, 
   (rv_I60_inq_comm_recency > 0.5) => 0.0186775885, -0.0158254209), 
(nf_fp_srchcomponentrisktype > 3.5) => map(
   ( NULL < iv_src_drivers_lic_adl_count and iv_src_drivers_lic_adl_count <= -0.5) => 0.0172474539, 
   (iv_src_drivers_lic_adl_count > -0.5) => 0.0772184118, 0.0478932152), -0.0044661897);

// Tree: 9
final_score_9 := map(
( NULL < nf_fp_srchfraudsrchcountwk and nf_fp_srchfraudsrchcountwk <= 0.5) => map(
   ( NULL < rv_I60_inq_hiRiskCred_recency and rv_I60_inq_hiRiskCred_recency <= 4.5) => map(
      (iv_dl_val_flag in ['Not Avail']) => -0.0181213739, 
      (iv_dl_val_flag in ['Empty','Invalid','Valid']) => 0.0379441971, 0.0094770931), 
   (rv_I60_inq_hiRiskCred_recency > 4.5) => -0.0388142854, -0.0165976806), 
(nf_fp_srchfraudsrchcountwk > 0.5) => 0.0499480018, -0.0070107650);

// Tree: 10
final_score_10 := map(
( NULL < nf_fp_srchphonesrchcountmo and nf_fp_srchphonesrchcountmo <= 0.5) => map(
   ( NULL < nf_phone_ver_experian and nf_phone_ver_experian <= 0.5) => 0.0125732110, 
   (nf_phone_ver_experian > 0.5) => -0.0373046117, -0.0224341642), 
(nf_fp_srchphonesrchcountmo > 0.5) => map(
   ( NULL < rv_I60_inq_comm_recency and rv_I60_inq_comm_recency <= 0.5) => 0.0084981160, 
   (rv_I60_inq_comm_recency > 0.5) => 0.0584249593, 0.0272790414), -0.0067650604);

// Tree: 11
final_score_11 := map(
( NULL < nf_fp_srchcomponentrisktype and nf_fp_srchcomponentrisktype <= 5.5) => map(
   ( NULL < rv_I60_inq_comm_recency and rv_I60_inq_comm_recency <= 0.5) => -0.0268684316, 
   (rv_I60_inq_comm_recency > 0.5) => map(
      ( NULL < nf_average_rel_home_val and nf_average_rel_home_val <= 181500) => 0.0438093646, 
      (nf_average_rel_home_val > 181500) => -0.0102484989, 0.0174275693), -0.0123599584), 
(nf_fp_srchcomponentrisktype > 5.5) => 0.0491771441, -0.0058683620);

// Tree: 12
final_score_12 := map(
( NULL < nf_fp_srchphonesrchcountwk and nf_fp_srchphonesrchcountwk <= 0.5) => map(
   ( NULL < rv_I60_inq_hiRiskCred_recency and rv_I60_inq_hiRiskCred_recency <= 9) => map(
      (iv_dl_val_flag in ['Not Avail']) => -0.0173759644, 
      (iv_dl_val_flag in ['Empty','Invalid','Valid']) => 0.0285941573, 0.0053724662), 
   (rv_I60_inq_hiRiskCred_recency > 9) => -0.0437243480, -0.0147140334), 
(nf_fp_srchphonesrchcountwk > 0.5) => 0.0411576119, -0.0079031193);

// Tree: 13
final_score_13 := map(
( NULL < nf_fp_srchcomponentrisktype and nf_fp_srchcomponentrisktype <= 4.5) => map(
   ( NULL < nf_phone_ver_experian and nf_phone_ver_experian <= 0.5) => 0.0164916050, 
   (nf_phone_ver_experian > 0.5) => -0.0240625060, -0.0121410463), 
(nf_fp_srchcomponentrisktype > 4.5) => map(
   ( NULL < iv_Estimated_Income and iv_Estimated_Income <= 35500) => 0.0728427392, 
   (iv_Estimated_Income > 35500) => 0.0229070024, 0.0378910270), -0.0053276230);

// Tree: 14
final_score_14 := map(
( NULL < nf_fp_srchunvrfdphonecount and nf_fp_srchunvrfdphonecount <= 1.5) => map(
   ( NULL < nf_phone_ver_experian and nf_phone_ver_experian <= 0.5) => 0.0118944363, 
   (nf_phone_ver_experian > 0.5) => -0.0323821478, -0.0205539169), 
(nf_fp_srchunvrfdphonecount > 1.5) => map(
   ( NULL < rv_I60_inq_other_recency and rv_I60_inq_other_recency <= 2) => 0.0455928938, 
   (rv_I60_inq_other_recency > 2) => 0.0113788205, 0.0245927840), -0.0053452125);

// Tree: 15
final_score_15 := map(
( NULL < nf_fp_varrisktype and nf_fp_varrisktype <= 2.5) => map(
   ( NULL < rv_comb_age and rv_comb_age <= 26.5) => 0.0338176346, 
   (rv_comb_age > 26.5) => -0.0239380799, -0.0188116459), 
(nf_fp_varrisktype > 2.5) => map(
   ( NULL < nf_fp_prevaddrmedianvalue and nf_fp_prevaddrmedianvalue <= 158787.5) => 0.0439860023, 
   (nf_fp_prevaddrmedianvalue > 158787.5) => -0.0000615610, 0.0211663384), -0.0032627653);

// Tree: 16
final_score_16 := map(
( NULL < nf_fp_varrisktype and nf_fp_varrisktype <= 3.5) => map(
   ( NULL < nf_fp_prevaddrmedianvalue and nf_fp_prevaddrmedianvalue <= 143573) => map(
      ( NULL < rv_D32_criminal_count and rv_D32_criminal_count <= 0.5) => -0.0071901722, 
      (rv_D32_criminal_count > 0.5) => 0.0439325618, 0.0067583756), 
   (nf_fp_prevaddrmedianvalue > 143573) => -0.0296249033, -0.0145688969), 
(nf_fp_varrisktype > 3.5) => 0.0287872348, -0.0047282180);

// Tree: 17
final_score_17 := map(
( NULL < rv_I60_inq_hiRiskCred_recency and rv_I60_inq_hiRiskCred_recency <= 4.5) => map(
   ( NULL < iv_src_voter_adl_count and iv_src_voter_adl_count <= -0.5) => -0.0046559678, 
   (iv_src_voter_adl_count > -0.5) => map(
      ( NULL < nf_phone_ver_experian and nf_phone_ver_experian <= 0.5) => 0.0476381590, 
      (nf_phone_ver_experian > 0.5) => 0.0189675418, 0.0286226393), 0.0136744201), 
(rv_I60_inq_hiRiskCred_recency > 4.5) => -0.0255252999, -0.0050273590);

// Tree: 18
final_score_18 := map(
( NULL < nf_average_rel_home_val and nf_average_rel_home_val <= 144500) => map(
   ( NULL < nf_pct_rel_with_criminal and nf_pct_rel_with_criminal <= 0.23166368515) => 0.0011721743, 
   (nf_pct_rel_with_criminal > 0.23166368515) => 0.0525619364, 0.0276757415), 
(nf_average_rel_home_val > 144500) => map(
   ( NULL < rv_P88_Phn_Dst_to_Inp_Add and rv_P88_Phn_Dst_to_Inp_Add <= 4.5) => -0.0260374331, 
   (rv_P88_Phn_Dst_to_Inp_Add > 4.5) => 0.0035594891, 0.0144648030), -0.0008440659);

// Tree: 19
final_score_19 := map(
( NULL < rv_comb_age and rv_comb_age <= 25.5) => 0.0457718627, 
(rv_comb_age > 25.5) => map(
   ( NULL < rv_I60_inq_PrepaidCards_recency and rv_I60_inq_PrepaidCards_recency <= 0.5) => map(
      ( NULL < nf_fp_srchssnsrchcountmo and nf_fp_srchssnsrchcountmo <= 5.5) => -0.0161189811, 
      (nf_fp_srchssnsrchcountmo > 5.5) => 0.0451974570, -0.0143252320), 
   (rv_I60_inq_PrepaidCards_recency > 0.5) => 0.0396459320, -0.0087842089), -0.0035284822);

// Tree: 20
final_score_20 := map(
( NULL < rv_I60_inq_comm_recency and rv_I60_inq_comm_recency <= 0.5) => map(
   ( NULL < rv_P88_Phn_Dst_to_Inp_Add and rv_P88_Phn_Dst_to_Inp_Add <= 8.5) => -0.0274703699, 
   (rv_P88_Phn_Dst_to_Inp_Add > 8.5) => 0.0023308991, 0.0117483794), 
(rv_I60_inq_comm_recency > 0.5) => map(
   ( NULL < nf_fp_srchaddrsrchcountwk and nf_fp_srchaddrsrchcountwk <= 0.5) => 0.0158793642, 
   (nf_fp_srchaddrsrchcountwk > 0.5) => 0.0562066174, 0.0212603995), -0.0030443963);

// Tree: 21
final_score_21 := map(
( NULL < nf_fp_srchcomponentrisktype and nf_fp_srchcomponentrisktype <= 6.5) => map(
   ( NULL < nf_average_rel_home_val and nf_average_rel_home_val <= 174500) => map(
      ( NULL < nf_hh_criminals_pct and nf_hh_criminals_pct <= 0.2158385093) => -0.0021900675, 
      (nf_hh_criminals_pct > 0.2158385093) => 0.0372184790, 0.0119271679), 
   (nf_average_rel_home_val > 174500) => -0.0217815841, -0.0079558778), 
(nf_fp_srchcomponentrisktype > 6.5) => 0.0341626576, -0.0046494762);

// Tree: 22
final_score_22 := map(
( NULL < rv_comb_age and rv_comb_age <= 25.5) => 0.0434098320, 
(rv_comb_age > 25.5) => map(
   ( NULL < rv_I60_inq_PrepaidCards_recency and rv_I60_inq_PrepaidCards_recency <= 0.5) => map(
      ( NULL < rv_I60_inq_hiRiskCred_count12 and rv_I60_inq_hiRiskCred_count12 <= 3.5) => -0.0228564029, 
      (rv_I60_inq_hiRiskCred_count12 > 3.5) => 0.0103482177, -0.0142865832), 
   (rv_I60_inq_PrepaidCards_recency > 0.5) => 0.0387038894, -0.0088065811), -0.0037453379);

// Tree: 23
final_score_23 := map(
( NULL < nf_inq_Communications_count24 and nf_inq_Communications_count24 <= 1.5) => map(
   ( NULL < nf_fp_srchphonesrchcountwk and nf_fp_srchphonesrchcountwk <= 0.5) => map(
      ( NULL < rv_comb_age and rv_comb_age <= 33.5) => 0.0081383322, 
      (rv_comb_age > 33.5) => -0.0218662106, -0.0118567930), 
   (nf_fp_srchphonesrchcountwk > 0.5) => 0.0226634154, -0.0078440574), 
(nf_inq_Communications_count24 > 1.5) => 0.0499007170, -0.0043761305);

// Tree: 24
final_score_24 := map(
( NULL < nf_inq_Communications_count24 and nf_inq_Communications_count24 <= 1.5) => map(
   ( NULL < rv_D32_criminal_count and rv_D32_criminal_count <= 0.5) => -0.0141991785, 
   (rv_D32_criminal_count > 0.5) => map(
      ( NULL < nf_fp_srchssnsrchcountmo and nf_fp_srchssnsrchcountmo <= 5.5) => 0.0134169107, 
      (nf_fp_srchssnsrchcountmo > 5.5) => 0.0723631511, 0.0154983252), -0.0059651886), 
(nf_inq_Communications_count24 > 1.5) => 0.0464418951, -0.0028217889);

// Tree: 25
final_score_25 := map(
( NULL < nf_phone_ver_experian and nf_phone_ver_experian <= 0.5) => map(
   ( NULL < nf_fp_srchfraudsrchcountwk and nf_fp_srchfraudsrchcountwk <= 0.5) => 0.0110903938, 
   (nf_fp_srchfraudsrchcountwk > 0.5) => 0.0395774804, 0.0162091390), 
(nf_phone_ver_experian > 0.5) => map(
   ( NULL < rv_I60_inq_hiRiskCred_count12 and rv_I60_inq_hiRiskCred_count12 <= 1.5) => -0.0337631432, 
   (rv_I60_inq_hiRiskCred_count12 > 1.5) => 0.0054314594, -0.0152794898), -0.0056865489);

// Tree: 26
final_score_26 := map(
( NULL < iv_Estimated_Income and iv_Estimated_Income <= 33500) => map(
   (rv_D32_criminal_x_felony in ['0-0','1-0','1-1','2-2']) => 0.0132645018, 
   (rv_D32_criminal_x_felony in ['2-0','2-1','3-0','3-1','3-2','3-3']) => 0.0638114247, 0.0205614441), 
(iv_Estimated_Income > 33500) => map(
   ( NULL < nf_fp_srchunvrfdphonecount and nf_fp_srchunvrfdphonecount <= 2.5) => -0.0155707638, 
   (nf_fp_srchunvrfdphonecount > 2.5) => 0.0238512471, -0.0118413660), -0.0040697297);

// Tree: 27
final_score_27 := map(
( NULL < iv_src_voter_adl_count and iv_src_voter_adl_count <= -0.5) => -0.0189702055, 
(iv_src_voter_adl_count > -0.5) => map(
   ( NULL < iv_mos_src_voter_adl_lseen and iv_mos_src_voter_adl_lseen <= 1) => 0.0288079188, 
   (iv_mos_src_voter_adl_lseen > 1) => map(
      ( NULL < iv_Estimated_Income and iv_Estimated_Income <= 125500) => -0.0032360908, 
      (iv_Estimated_Income > 125500) => 0.4230442654, -0.0024422169), 0.0086604943), -0.0032721728);

// Tree: 28
final_score_28 := map(
( NULL < rv_C13_inp_addr_lres and rv_C13_inp_addr_lres <= 19.5) => map(
   ( NULL < nf_fp_srchssnsrchcountmo and nf_fp_srchssnsrchcountmo <= 5.5) => 0.0199806451, 
   (nf_fp_srchssnsrchcountmo > 5.5) => 0.0663826319, 0.0218754421), 
(rv_C13_inp_addr_lres > 19.5) => map(
   ( NULL < nf_fp_srchunvrfdphonecount and nf_fp_srchunvrfdphonecount <= 1.5) => -0.0197985587, 
   (nf_fp_srchunvrfdphonecount > 1.5) => 0.0083334992, -0.0108044946), -0.0032003117);

// Tree: 29
final_score_29 := map(
( NULL < nf_phone_ver_experian and nf_phone_ver_experian <= 0.5) => map(
   ( NULL < rv_I60_inq_hiRiskCred_recency and rv_I60_inq_hiRiskCred_recency <= 2) => 0.0312683896, 
   (rv_I60_inq_hiRiskCred_recency > 2) => 0.0040418579, 0.0158150270), 
(nf_phone_ver_experian > 0.5) => map(
   ( NULL < nf_inq_per_phone and nf_inq_per_phone <= 4.5) => -0.0213577983, 
   (nf_inq_per_phone > 4.5) => 0.0138530691, -0.0117909245), -0.0033786229);

// Tree: 30
final_score_30 := map(
( NULL < rv_P88_Phn_Dst_to_Inp_Add and rv_P88_Phn_Dst_to_Inp_Add <= 4.5) => map(
   ( NULL < nf_average_rel_home_val and nf_average_rel_home_val <= 168500) => 0.0049490999, 
   (nf_average_rel_home_val > 168500) => -0.0260745519, -0.0142600672), 
(rv_P88_Phn_Dst_to_Inp_Add > 4.5) => 0.0070078146, map(
   ( NULL < nf_phone_ver_experian and nf_phone_ver_experian <= 0.5) => 0.0301580273, 
   (nf_phone_ver_experian > 0.5) => 0.0003776809, 0.0145541155));

// Tree: 31
final_score_31 := map(
( NULL < rv_D33_Eviction_Recency and rv_D33_Eviction_Recency <= 1.5) => map(
   ( NULL < rv_I60_inq_PrepaidCards_recency and rv_I60_inq_PrepaidCards_recency <= 2) => map(
      ( NULL < rv_I60_inq_hiRiskCred_recency and rv_I60_inq_hiRiskCred_recency <= 2) => 0.0033293755, 
      (rv_I60_inq_hiRiskCred_recency > 2) => -0.0266344225, -0.0152794000), 
   (rv_I60_inq_PrepaidCards_recency > 2) => 0.0286631774, -0.0111206691), 
(rv_D33_Eviction_Recency > 1.5) => 0.0318941862, -0.0042578686);

// Tree: 32
final_score_32 := map(
( NULL < nf_fp_srchfraudsrchcountyr and nf_fp_srchfraudsrchcountyr <= 6.5) => map(
   ( NULL < nf_hh_criminals_pct and nf_hh_criminals_pct <= 0.06458333335) => -0.0214835093, 
   (nf_hh_criminals_pct > 0.06458333335) => map(
      ( NULL < nf_fp_curraddrmedianvalue and nf_fp_curraddrmedianvalue <= 160138.5) => 0.0257393425, 
      (nf_fp_curraddrmedianvalue > 160138.5) => -0.0114235072, 0.0064618686), -0.0085493783), 
(nf_fp_srchfraudsrchcountyr > 6.5) => 0.0193270868, -0.0021538832);

// Tree: 33
final_score_33 := map(
( NULL < rv_comb_age and rv_comb_age <= 31.5) => map(
   ( NULL < nf_pct_rel_with_felony and nf_pct_rel_with_felony <= 0.0615530303) => 0.0104601834, 
   (nf_pct_rel_with_felony > 0.0615530303) => 0.0560492888, 0.0191841533), 
(rv_comb_age > 31.5) => map(
   ( NULL < rv_D30_Derog_Count and rv_D30_Derog_Count <= 6.5) => -0.0132081033, 
   (rv_D30_Derog_Count > 6.5) => 0.0237680156, -0.0085636575), -0.0007589050);

// Tree: 34
final_score_34 := map(
( NULL < rv_I60_inq_comm_recency and rv_I60_inq_comm_recency <= 0.5) => -0.0103906162, 
(rv_I60_inq_comm_recency > 0.5) => map(
   ( NULL < nf_M_Bureau_ADL_FS_all and nf_M_Bureau_ADL_FS_all <= 342.5) => map(
      ( NULL < nf_pct_rel_with_felony and nf_pct_rel_with_felony <= 0.0776772247) => 0.0136987713, 
      (nf_pct_rel_with_felony > 0.0776772247) => 0.0490252704, 0.0210354700), 
   (nf_M_Bureau_ADL_FS_all > 342.5) => -0.0278456610, 0.0139527247), -0.0022729315);

// Tree: 35
final_score_35 := map(
( NULL < rv_C14_addrs_5yr and rv_C14_addrs_5yr <= 3.5) => map(
   ( NULL < nf_inq_HighRiskCredit_count_week and nf_inq_HighRiskCredit_count_week <= 0.5) => -0.0108168749, 
   (nf_inq_HighRiskCredit_count_week > 0.5) => map(
      ( NULL < rv_email_domain_ISP_count and rv_email_domain_ISP_count <= 0.5) => 0.0347056902, 
      (rv_email_domain_ISP_count > 0.5) => -0.0004223565, 0.0163908536), -0.0080155921), 
(rv_C14_addrs_5yr > 3.5) => 0.0285382012, -0.0035318207);

// Tree: 36
final_score_36 := map(
( NULL < nf_inq_Communications_count24 and nf_inq_Communications_count24 <= 1.5) => map(
   ( NULL < rv_I60_inq_hiRiskCred_recency and rv_I60_inq_hiRiskCred_recency <= 18) => map(
      ( NULL < rv_I60_inq_other_recency and rv_I60_inq_other_recency <= 0.5) => 0.0566579819, 
      (rv_I60_inq_other_recency > 0.5) => -0.0000033820, 0.0038829904), 
   (rv_I60_inq_hiRiskCred_recency > 18) => -0.0316031833, -0.0052799966), 
(nf_inq_Communications_count24 > 1.5) => 0.0364694934, -0.0027882357);

// Tree: 37
final_score_37 := map(
(rv_D32_criminal_x_felony in ['0-0','1-0','2-0','3-0']) => map(
   ( NULL < nf_average_rel_home_val and nf_average_rel_home_val <= 137500) => 0.0146546535, 
   (nf_average_rel_home_val > 137500) => map(
      ( NULL < rv_comb_age and rv_comb_age <= 24.5) => 0.0222610933, 
      (rv_comb_age > 24.5) => -0.0114786229, -0.0093325523), -0.0036845545), 
(rv_D32_criminal_x_felony in ['1-1','2-1','2-2','3-1','3-2','3-3']) => 0.0715278446, -0.0024841764);

// Tree: 38
final_score_38 := map(
( NULL < rv_I60_inq_PrepaidCards_recency and rv_I60_inq_PrepaidCards_recency <= 0.5) => map(
   (iv_dl_val_flag in ['Empty','Invalid','Not Avail']) => -0.0159433771, 
   (iv_dl_val_flag in ['Valid']) => map(
      (rv_D32_criminal_x_felony in ['0-0','1-0','2-0']) => -0.0000372414, 
      (rv_D32_criminal_x_felony in ['1-1','2-1','2-2','3-0','3-1','3-2','3-3']) => 0.0449193479, 0.0046674568), -0.0057780972), 
(rv_I60_inq_PrepaidCards_recency > 0.5) => 0.0256863818, -0.0024294679);

// Tree: 39
final_score_39 := map(
( NULL < rv_I60_inq_PrepaidCards_recency and rv_I60_inq_PrepaidCards_recency <= 0.5) => map(
   ( NULL < rv_I60_inq_other_recency and rv_I60_inq_other_recency <= 2) => map(
      ( NULL < nf_phone_ver_experian and nf_phone_ver_experian <= 0.5) => 0.0223230277, 
      (nf_phone_ver_experian > 0.5) => -0.0026529009, 0.0060199116), 
   (rv_I60_inq_other_recency > 2) => -0.0131812874, -0.0071047068), 
(rv_I60_inq_PrepaidCards_recency > 0.5) => 0.0248469142, -0.0037314005);

// Tree: 40
final_score_40 := map(
( NULL < nf_fp_srchfraudsrchcountmo and nf_fp_srchfraudsrchcountmo <= 7.5) => map(
   ( NULL < rv_P88_Phn_Dst_to_Inp_Add and rv_P88_Phn_Dst_to_Inp_Add <= 4.5) => -0.0121528710, 
   (rv_P88_Phn_Dst_to_Inp_Add > 4.5) => 0.0059520965, map(
      ( NULL < rv_I60_inq_other_recency and rv_I60_inq_other_recency <= 0.5) => 0.0692595751, 
      (rv_I60_inq_other_recency > 0.5) => 0.0072447031, 0.0126456611)), 
(nf_fp_srchfraudsrchcountmo > 7.5) => 0.0446477704, -0.0024028276);

// Tree: 41
final_score_41 := map(
( NULL < nf_pct_rel_with_felony and nf_pct_rel_with_felony <= 0.02667140825) => map(
   ( NULL < rv_comb_age and rv_comb_age <= 26.5) => 0.0147876193, 
   (rv_comb_age > 26.5) => -0.0122577403, -0.0086095620), 
(nf_pct_rel_with_felony > 0.02667140825) => map(
   ( NULL < rv_C20_M_Bureau_ADL_FS and rv_C20_M_Bureau_ADL_FS <= 248.5) => 0.0306605980, 
   (rv_C20_M_Bureau_ADL_FS > 248.5) => -0.0013584822, 0.0157046283), -0.0020420078);

// Tree: 42
final_score_42 := map(
(rv_D32_criminal_x_felony in ['0-0','1-1','2-0']) => map(
   ( NULL < rv_I60_inq_hiRiskCred_count12 and rv_I60_inq_hiRiskCred_count12 <= 3.5) => -0.0149179867, 
   (rv_I60_inq_hiRiskCred_count12 > 3.5) => 0.0077918722, -0.0089217139), 
(rv_D32_criminal_x_felony in ['1-0','2-1','2-2','3-0','3-1','3-2','3-3']) => map(
   (iv_dl_val_flag in ['Empty','Not Avail']) => -0.0021138099, 
   (iv_dl_val_flag in ['Invalid','Valid']) => 0.0316642085, 0.0151722431), -0.0037374801);

// Tree: 43
final_score_43 := map(
( NULL < nf_hh_criminals_pct and nf_hh_criminals_pct <= 0.1091269841) => map(
   ( NULL < nf_inq_HighRiskCredit_count_week and nf_inq_HighRiskCredit_count_week <= 4.5) => -0.0122477517, 
   (nf_inq_HighRiskCredit_count_week > 4.5) => 0.1011284595, -0.0119138170), 
(nf_hh_criminals_pct > 0.1091269841) => map(
   ( NULL < rv_D33_Eviction_Recency and rv_D33_Eviction_Recency <= 1.5) => 0.0053419678, 
   (rv_D33_Eviction_Recency > 1.5) => 0.0342587860, 0.0105679576), -0.0016148550);

// Tree: 44
final_score_44 := map(
( NULL < rv_D33_Eviction_Recency and rv_D33_Eviction_Recency <= 1.5) => map(
   (iv_Phn_Addr_Verified in ['1 INF ONLY','2 NAP ONLY','3 BOTH VERD']) => -0.0119717611, 
   (iv_Phn_Addr_Verified in ['0 NONE VERD']) => map(
      ( NULL < nf_phone_ver_experian and nf_phone_ver_experian <= 0.5) => 0.0378146958, 
      (nf_phone_ver_experian > 0.5) => -0.0097613679, 0.0129792232), -0.0072170016), 
(rv_D33_Eviction_Recency > 1.5) => 0.0224102273, -0.0024030631);

// Tree: 45
final_score_45 := map(
( NULL < rv_D32_criminal_count and rv_D32_criminal_count <= 4.5) => map(
   ( NULL < nf_inq_adls_per_phone and nf_inq_adls_per_phone <= 1.5) => map(
      ( NULL < rv_comb_age and rv_comb_age <= 29.5) => 0.0114465128, 
      (rv_comb_age > 29.5) => -0.0100087853, -0.0052846947), 
   (nf_inq_adls_per_phone > 1.5) => 0.0203314405, -0.1091073506), 
(rv_D32_criminal_count > 4.5) => 0.0409388214, -0.0010926664);

// Tree: 46
final_score_46 := map(
( NULL < nf_rel_felony_count and nf_rel_felony_count <= 0.5) => map(
   ( NULL < rv_comb_age and rv_comb_age <= 26.5) => 0.0148151171, 
   (rv_comb_age > 26.5) => -0.0116357218, -0.0079875562), 
(nf_rel_felony_count > 0.5) => map(
   ( NULL < rv_C13_inp_addr_lres and rv_C13_inp_addr_lres <= 20.5) => 0.0320313279, 
   (rv_C13_inp_addr_lres > 20.5) => 0.0062845605, 0.0129519484), -0.0022782033);

// Tree: 47
final_score_47 := map(
( NULL < nf_inq_HighRiskCredit_count_week and nf_inq_HighRiskCredit_count_week <= 2.5) => map(
   (rv_D31_MostRec_Bk in ['2 - BK DISCHARGED']) => -0.0208053259, 
   (rv_D31_MostRec_Bk in ['0 - NO BK','1 - BK DISMISSED','3 - BK OTHER']) => map(
      (iv_dl_val_flag in ['Empty','Not Avail']) => -0.0071451000, 
      (iv_dl_val_flag in ['Invalid','Valid']) => 0.0123815816, 0.0025810071), -0.0027242060), 
(nf_inq_HighRiskCredit_count_week > 2.5) => 0.0387126883, -0.0019839757);

// Tree: 48
final_score_48 := map(
( NULL < nf_inq_per_phone and nf_inq_per_phone <= 6.5) => map(
   (iv_Phn_Addr_Verified in ['1 INF ONLY','2 NAP ONLY','3 BOTH VERD']) => -0.0115414689, 
   (iv_Phn_Addr_Verified in ['0 NONE VERD']) => map(
      ( NULL < rv_I60_inq_hiRiskCred_recency and rv_I60_inq_hiRiskCred_recency <= 2) => 0.0373485844, 
      (rv_I60_inq_hiRiskCred_recency > 2) => 0.0018833791, 0.0134742994), -0.0061705323), 
(nf_inq_per_phone > 6.5) => 0.0161246154, -0.0876369548);

// Tree: 49
final_score_49 := map(
( NULL < nf_fp_srchunvrfdphonecount and nf_fp_srchunvrfdphonecount <= 3.5) => map(
   ( NULL < nf_fp_curraddrmedianvalue and nf_fp_curraddrmedianvalue <= 116915.5) => 0.0111332266, 
   (nf_fp_curraddrmedianvalue > 116915.5) => -0.0070828067, -0.0016162399), 
(nf_fp_srchunvrfdphonecount > 3.5) => map(
   ( NULL < nf_M_Bureau_ADL_FS_noTU and nf_M_Bureau_ADL_FS_noTU <= 231.5) => 0.0639611002, 
   (nf_M_Bureau_ADL_FS_noTU > 231.5) => 0.0024389607, 0.0358989079), -0.0006476397);

// Tree: 50
final_score_50 := map(
( NULL < nf_attr_arrest_recency and nf_attr_arrest_recency <= 18) => 0.1681947853, 
(nf_attr_arrest_recency > 18) => 0.0425600814, map(
   ( NULL < rv_I60_inq_retail_recency and rv_I60_inq_retail_recency <= 0.5) => map(
      ( NULL < rv_C13_attr_addrs_recency and rv_C13_attr_addrs_recency <= 30) => 0.0164110785, 
      (rv_C13_attr_addrs_recency > 30) => -0.0038310226, 0.0038575678), 
   (rv_I60_inq_retail_recency > 0.5) => -0.0183656322, -0.0017136372));

// Tree: 51
final_score_51 := map(
( NULL < rv_L79_adls_per_addr_c6 and rv_L79_adls_per_addr_c6 <= 0.5) => -0.0137106104, 
(rv_L79_adls_per_addr_c6 > 0.5) => map(
   ( NULL < rv_D30_Derog_Count and rv_D30_Derog_Count <= 19.5) => map(
      ( NULL < nf_average_rel_home_val and nf_average_rel_home_val <= 125500) => 0.0209085155, 
      (nf_average_rel_home_val > 125500) => 0.0011897059, 0.0046900435), 
   (rv_D30_Derog_Count > 19.5) => 0.1122985439, 0.0053891982), -0.0029265453);

// Tree: 52
final_score_52 := map(
( NULL < rv_L79_adls_per_addr_c6 and rv_L79_adls_per_addr_c6 <= 2.5) => map(
   ( NULL < iv_Estimated_Income and iv_Estimated_Income <= 161500) => -0.0040927306, 
   (iv_Estimated_Income > 161500) => 0.3657027184, -0.0037887966), 
(rv_L79_adls_per_addr_c6 > 2.5) => map(
   ( NULL < nf_fp_srchphonesrchcountwk and nf_fp_srchphonesrchcountwk <= 1.5) => 0.0189854445, 
   (nf_fp_srchphonesrchcountwk > 1.5) => 0.0593732620, 0.0210304509), -0.0007414186);

// Tree: 53
final_score_53 := map(
( NULL < rv_I60_inq_hiRiskCred_count12 and rv_I60_inq_hiRiskCred_count12 <= 1.5) => map(
   ( NULL < rv_P88_Phn_Dst_to_Inp_Add and rv_P88_Phn_Dst_to_Inp_Add <= 1.5) => -0.0264218197, 
   (rv_P88_Phn_Dst_to_Inp_Add > 1.5) => -0.0060982677, map(
      ( NULL < nf_inq_Other_count24 and nf_inq_Other_count24 <= 0.5) => 0.0668530824, 
      (nf_inq_Other_count24 > 0.5) => -0.0053048864, 0.0118888834)), 
(rv_I60_inq_hiRiskCred_count12 > 1.5) => 0.0075475983, -0.0030376325);

// Tree: 54
final_score_54 := map(
( NULL < rv_I60_inq_hiRiskCred_recency and rv_I60_inq_hiRiskCred_recency <= 61.5) => map(
   ( NULL < nf_inq_Other_count24 and nf_inq_Other_count24 <= 0.5) => map(
      ( NULL < nf_fp_srchvelocityrisktype and nf_fp_srchvelocityrisktype <= 3.5) => 0.0869312217, 
      (nf_fp_srchvelocityrisktype > 3.5) => 0.0197688803, 0.0333109195), 
   (nf_inq_Other_count24 > 0.5) => 0.0010863929, 0.0054509248), 
(rv_I60_inq_hiRiskCred_recency > 61.5) => -0.0291212114, -0.0005243963);

// Tree: 55
final_score_55 := map(
(iv_Phn_Addr_Verified in ['1 INF ONLY','2 NAP ONLY','3 BOTH VERD']) => map(
   ( NULL < nf_inq_HighRiskCredit_count24 and nf_inq_HighRiskCredit_count24 <= 1.5) => -0.0266441297, 
   (nf_inq_HighRiskCredit_count24 > 1.5) => 0.0030061733, -0.0086653611), 
(iv_Phn_Addr_Verified in ['0 NONE VERD']) => map(
   ( NULL < nf_fp_srchvelocityrisktype and nf_fp_srchvelocityrisktype <= 1.5) => 0.1406244661, 
   (nf_fp_srchvelocityrisktype > 1.5) => 0.0144353937, 0.0176066024), -0.0035503967);

// Tree: 56
final_score_56 := map(
( NULL < nf_fp_srchunvrfdphonecount and nf_fp_srchunvrfdphonecount <= 4.5) => map(
   ( NULL < rv_C13_inp_addr_lres and rv_C13_inp_addr_lres <= 18.5) => 0.0119706801, 
   (rv_C13_inp_addr_lres > 18.5) => -0.0075248034, -0.0031774992), 
(nf_fp_srchunvrfdphonecount > 4.5) => map(
   ( NULL < nf_hh_collections_ct_avg and nf_hh_collections_ct_avg <= 0.26376811595) => 0.1585618894, 
   (nf_hh_collections_ct_avg > 0.26376811595) => 0.0408769918, 0.0628110945), -0.0027035494);

// Tree: 57
final_score_57 := map(
( NULL < rv_D32_felony_count and rv_D32_felony_count <= 0.5) => map(
   ( NULL < rv_D33_Eviction_Recency and rv_D33_Eviction_Recency <= 1.5) => -0.0067081853, 
   (rv_D33_Eviction_Recency > 1.5) => 0.0171477217, -0.0029166481), 
(rv_D32_felony_count > 0.5) => map(
   ( NULL < rv_I62_inq_phones_per_adl and rv_I62_inq_phones_per_adl <= 2.5) => 0.0419722832, 
   (rv_I62_inq_phones_per_adl > 2.5) => 0.1084903972, 0.0512915156), -0.0020849841);

// Tree: 58
final_score_58 := map(
( NULL < nf_inq_HighRiskCredit_count_day and nf_inq_HighRiskCredit_count_day <= 0.5) => map(
   ( NULL < rv_L79_adls_per_addr_c6 and rv_L79_adls_per_addr_c6 <= 1.5) => -0.0078182211, 
   (rv_L79_adls_per_addr_c6 > 1.5) => map(
      ( NULL < rv_D32_felony_count and rv_D32_felony_count <= 2.5) => 0.0092065355, 
      (rv_D32_felony_count > 2.5) => 0.1751386998, 0.0096170961), -0.0031017089), 
(nf_inq_HighRiskCredit_count_day > 0.5) => 0.0239324008, -0.0020654820);

// Tree: 59
final_score_59 := map(
( NULL < nf_fp_srchaddrsrchcountwk and nf_fp_srchaddrsrchcountwk <= 1.5) => -0.0031588736, 
(nf_fp_srchaddrsrchcountwk > 1.5) => map(
   (nf_fp_addrchangeecontraj in ['-1','AA','AB','BA','BB','BC','CC','CF','DA','DD','DF','EA','EB','EC','ED','EE','FC','FD','FE','FF','FU','UU']) => map(
      ( NULL < rv_C14_addrs_10yr and rv_C14_addrs_10yr <= 10.5) => 0.0165758137, 
      (rv_C14_addrs_10yr > 10.5) => 0.1479547182, 0.0191592023), 
   (nf_fp_addrchangeecontraj in ['AC','AD','AE','AF','AU','BD','BE','BF','BU','CA','CB','CD','CE','CU','DB','DC','DE','DU','EF','EU','FA','FB','UC','UD','UE','UF']) => 0.2107438775, 0.0219917058), -0.0018889137);

// Tree: 60
final_score_60 := map(
(rv_D31_ALL_Bk in ['2 - BK DISCHARGED','3 - BK OTHER']) => -0.0189823206, 
(rv_D31_ALL_Bk in ['0 - NO BK','1 - BK DISMISSED']) => map(
   ( NULL < nf_hh_criminals_pct and nf_hh_criminals_pct <= 0.1091269841) => -0.0033598351, 
   (nf_hh_criminals_pct > 0.1091269841) => map(
      ( NULL < nf_acc_damage_amt_total and nf_acc_damage_amt_total <= 775) => 0.0163414526, 
      (nf_acc_damage_amt_total > 775) => -0.0581385237, 0.0136351703), 0.0044981159), -0.0006879254);

// Tree: 61
final_score_61 := map(
( NULL < nf_fp_srchunvrfdphonecount and nf_fp_srchunvrfdphonecount <= 5.5) => map(
   ( NULL < rv_comb_age and rv_comb_age <= 24.5) => 0.0192242116, 
   (rv_comb_age > 24.5) => map(
      ( NULL < nf_inq_per_phone and nf_inq_per_phone <= 10.5) => -0.0034919010, 
      (nf_inq_per_phone > 10.5) => 0.0191460606, -0.0932924117), -0.0007132130), 
(nf_fp_srchunvrfdphonecount > 5.5) => 0.1008460774, -0.0005197617);

// Tree: 62
final_score_62 := map(
(rv_D32_criminal_x_felony in ['0-0','1-0','1-1','2-0','2-2','3-0','3-2']) => map(
   (iv_Phn_Addr_Verified in ['2 NAP ONLY','3 BOTH VERD']) => -0.0052714810, 
   (iv_Phn_Addr_Verified in ['0 NONE VERD','1 INF ONLY']) => map(
      ( NULL < rv_I60_inq_hiRiskCred_recency and rv_I60_inq_hiRiskCred_recency <= 18) => 0.0247075136, 
      (rv_I60_inq_hiRiskCred_recency > 18) => -0.0167208672, 0.0095597031), -0.0022310670), 
(rv_D32_criminal_x_felony in ['2-1','3-1','3-3']) => 0.0555354891, -0.0016109606);

// Tree: 63
final_score_63 := map(
( NULL < nf_fp_curraddrmedianvalue and nf_fp_curraddrmedianvalue <= 74973.5) => map(
   (nf_fp_addrchangeecontraj in ['AA','AB','AC','AE','BA','BB','BU','CB','DC','DD','DE','EA','EC','ED','EE','FB','FD','FE','FU','UF','UU']) => -0.0175971752, 
   (nf_fp_addrchangeecontraj in ['-1','AD','AF','AU','BC','BD','BE','BF','CA','CC','CD','CE','CF','CU','DA','DB','DF','DU','EB','EF','EU','FA','FC','FF','UC','UD','UE']) => 0.0257480058, 0.0165650114), 
(nf_fp_curraddrmedianvalue > 74973.5) => map(
   ( NULL < nf_rel_felony_count and nf_rel_felony_count <= 3.5) => -0.0051352473, 
   (nf_rel_felony_count > 3.5) => 0.0381407723, -0.0041411714), -0.0019068791);

// Tree: 64
final_score_64 := map(
( NULL < rv_D32_criminal_count and rv_D32_criminal_count <= 5.5) => map(
   ( NULL < nf_inq_Communications_count24 and nf_inq_Communications_count24 <= 2.5) => -0.0035801320, 
   (nf_inq_Communications_count24 > 2.5) => map(
      ( NULL < rv_C12_source_profile and rv_C12_source_profile <= 18.2) => 0.1292360007, 
      (rv_C12_source_profile > 18.2) => 0.0227675177, 0.0292859962), -0.0027465375), 
(rv_D32_criminal_count > 5.5) => 0.0354291686, -0.0015909040);

// Tree: 65
final_score_65 := map(
( NULL < nf_average_rel_home_val and nf_average_rel_home_val <= 128500) => 0.0122967658, 
(nf_average_rel_home_val > 128500) => map(
   (nf_util_add_input_summary in ['| C |','|I  |','|I M|','|IC |','|ICM|']) => -0.0192956344, 
   (nf_util_add_input_summary in ['|   |','|  M|','| CM|']) => map(
      ( NULL < nf_inq_HighRiskCredit_count_day and nf_inq_HighRiskCredit_count_day <= 0.5) => -0.0030664427, 
      (nf_inq_HighRiskCredit_count_day > 0.5) => 0.0281870840, -0.0018952828), -0.0064872791), -0.0029998428);

// Tree: 66
final_score_66 := map(
( NULL < rv_C14_addrs_5yr and rv_C14_addrs_5yr <= 3.5) => map(
   ( NULL < rv_L79_adls_per_sfd_addr and rv_L79_adls_per_sfd_addr <= 3.5) => -0.0092693501, 
   (rv_L79_adls_per_sfd_addr > 3.5) => map(
      (iv_full_name_ver_sources in ['NAME NOT VERD','PHN & NONPHN']) => 0.0005533541, 
      (iv_full_name_ver_sources in ['NONPHN ONLY','PHN ONLY']) => 0.0220118456, 0.0061564620), -0.0031424910), 
(rv_C14_addrs_5yr > 3.5) => 0.0182132222, -0.0005211665);

// Tree: 67
final_score_67 := map(
( NULL < rv_L79_adls_per_addr_curr and rv_L79_adls_per_addr_curr <= 5.5) => map(
   ( NULL < rv_I60_inq_PrepaidCards_recency and rv_I60_inq_PrepaidCards_recency <= 0.5) => -0.0067436576, 
   (rv_I60_inq_PrepaidCards_recency > 0.5) => map(
      ( NULL < iv_dob_src_ct and iv_dob_src_ct <= 16.5) => 0.0198289531, 
      (iv_dob_src_ct > 16.5) => 0.1268875167, -0.0421294333), -0.0042095485), 
(rv_L79_adls_per_addr_curr > 5.5) => 0.0164515092, -0.0002665234);

// Tree: 68
final_score_68 := map(
( NULL < nf_inq_adls_per_phone and nf_inq_adls_per_phone <= 1.5) => map(
   ( NULL < nf_acc_damage_amt_total and nf_acc_damage_amt_total <= 2) => -0.0012638517, 
	 nf_acc_damage_amt_total = (Unsigned)NULL => -0.0028889427, 
   (nf_acc_damage_amt_total > 2) => -0.0548099490, -0.0028889427), 
(nf_inq_adls_per_phone > 1.5) => map(
   ( NULL < rv_L79_adls_per_addr_c6 and rv_L79_adls_per_addr_c6 <= 3.5) => 0.0139976636, 
   (rv_L79_adls_per_addr_c6 > 3.5) => 0.0686435644, 0.0178466731), -0.1024312130);

// Tree: 69
final_score_69 := map(
( NULL < nf_fp_srchfraudsrchcountmo and nf_fp_srchfraudsrchcountmo <= 6.5) => map(
   ( NULL < nf_fp_srchunvrfdphonecount and nf_fp_srchunvrfdphonecount <= 5.5) => map(
      ( NULL < rv_comb_age and rv_comb_age <= 31.5) => 0.0078418308, 
      (rv_comb_age > 31.5) => -0.0066626571, -0.0026375459), 
   (nf_fp_srchunvrfdphonecount > 5.5) => 0.0921107076, -0.0024927281), 
(nf_fp_srchfraudsrchcountmo > 6.5) => 0.0249218815, -0.0018575916);

// Tree: 70
final_score_70 := map(
( NULL < rv_D30_Derog_Count and rv_D30_Derog_Count <= 13.5) => map(
   ( NULL < nf_inq_per_ssn and nf_inq_per_ssn <= 8.5) => -0.0043721180, 
   (nf_inq_per_ssn > 8.5) => map(
      ( NULL < rv_C10_M_Hdr_FS and rv_C10_M_Hdr_FS <= 325.5) => 0.0178361130, 
      (rv_C10_M_Hdr_FS > 325.5) => -0.0165062074, 0.0086858865), -0.0017850289), 
(rv_D30_Derog_Count > 13.5) => 0.0413787370, -0.0010033443);

// Tree: 71
final_score_71 := map(
( NULL < iv_Estimated_Income and iv_Estimated_Income <= 143500) => map(
   (iv_Phn_Addr_Verified in ['1 INF ONLY','2 NAP ONLY','3 BOTH VERD']) => -0.0052413989, 
   (iv_Phn_Addr_Verified in ['0 NONE VERD']) => 0.0128808646, -0.0017352447), 
(iv_Estimated_Income > 143500) => map(
   ( NULL < nf_fp_sourcerisktype and nf_fp_sourcerisktype <= 3.5) => 0.3643811292, 
   (nf_fp_sourcerisktype > 3.5) => 0.0428084478, 0.1438741477), -0.0013416754);

// Tree: 72
final_score_72 := map(
( NULL < nf_attr_arrest_recency and nf_attr_arrest_recency <= 18) => 0.1159810426, 
(nf_attr_arrest_recency > 18) => 0.0273854231, map(
   ( NULL < nf_hh_payday_loan_users_pct and nf_hh_payday_loan_users_pct <= 0.0425724638) => -0.0040912812, 
   (nf_hh_payday_loan_users_pct > 0.0425724638) => map(
      ( NULL < rv_C12_inp_addr_source_count and rv_C12_inp_addr_source_count <= 2.5) => 0.0583419670, 
      (rv_C12_inp_addr_source_count > 2.5) => 0.0086981731, 0.0121968569), -0.0003517112));

// Tree: 73
final_score_73 := map(
(iv_dl_val_flag in ['Empty','Invalid','Not Avail']) => -0.0074275003, 
(iv_dl_val_flag in ['Valid']) => map(
   ( NULL < nf_pct_rel_with_criminal and nf_pct_rel_with_criminal <= 0.16843971635) => -0.0076353790, 
   (nf_pct_rel_with_criminal > 0.16843971635) => map(
      ( NULL < nf_fp_prevaddrlenofres and nf_fp_prevaddrlenofres <= 19.5) => 0.0311320994, 
      (nf_fp_prevaddrlenofres > 19.5) => 0.0093159396, 0.0143217455), 0.0062163213), -0.0006875929);

// Tree: 74
final_score_74 := map(
( NULL < nf_inq_Communications_count24 and nf_inq_Communications_count24 <= 2.5) => map(
   ( NULL < nf_inq_Other_count24 and nf_inq_Other_count24 <= 0.5) => map(
      ( NULL < rv_I60_inq_hiRiskCred_recency and rv_I60_inq_hiRiskCred_recency <= 2) => 0.0372975551, 
      (rv_I60_inq_hiRiskCred_recency > 2) => -0.0085709336, 0.0065936285), 
   (nf_inq_Other_count24 > 0.5) => -0.0055407018, -0.0033228399), 
(nf_inq_Communications_count24 > 2.5) => 0.0266136994, -0.0025402482);

// Tree: 75
final_score_75 := map(
(nf_fp_addrchangeecontraj in ['-1','AA','AC','AE','BA','BB','BC','BD','BE','BU','CA','CB','CC','CD','CE','CF','CU','DA','DB','DC','DD','DE','DF','EA','EB','EC','ED','EE','EF','FC','FD','FE','FF','FU','UC','UE','UU']) => map(
   ( NULL < rv_L79_adls_per_sfd_addr_c6 and rv_L79_adls_per_sfd_addr_c6 <= 0.5) => -0.0061383541, 
   (rv_L79_adls_per_sfd_addr_c6 > 0.5) => map(
      ( NULL < rv_I60_inq_auto_count12 and rv_I60_inq_auto_count12 <= 1.5) => 0.0120796095, 
      (rv_I60_inq_auto_count12 > 1.5) => -0.0190346191, 0.0074679864), -0.0004813363), 
(nf_fp_addrchangeecontraj in ['AB','AD','AF','AU','BF','DU','EU','FA','FB','UD','UF']) => 0.2009645692, -0.0002350160);

// Tree: 76
final_score_76 := map(
( NULL < nf_fp_srchphonesrchcountwk and nf_fp_srchphonesrchcountwk <= 0.5) => -0.0032115574, 
(nf_fp_srchphonesrchcountwk > 0.5) => map(
   (nf_fp_addrchangeecontraj in ['-1','AA','AB','AC','AF','BB','BC','BF','BU','CC','CE','CF','DD','DE','DF','EA','EB','EC','EE','EF','EU','FA','FC','FE','FF','FU','UU']) => map(
      ( NULL < nf_fp_srchfraudsrchcountmo and nf_fp_srchfraudsrchcountmo <= 0.5) => 0.1469534219, 
      (nf_fp_srchfraudsrchcountmo > 0.5) => 0.0089714549, 0.0129687866), 
   (nf_fp_addrchangeecontraj in ['AD','AE','AU','BA','BD','BE','CA','CB','CD','CU','DA','DB','DC','DU','ED','FB','FD','UC','UD','UE','UF']) => 0.1375055210, 0.0148766394), -0.0010079511);

// Tree: 77
final_score_77 := map(
( NULL < rv_comb_age and rv_comb_age <= 37.5) => map(
   ( NULL < rv_D30_Derog_Count and rv_D30_Derog_Count <= 13.5) => 0.0080820969, 
   (rv_D30_Derog_Count > 13.5) => map(
      ( NULL < nf_hh_tot_derog_avg and nf_hh_tot_derog_avg <= 1.5277777778) => 0.1759519474, 
      (nf_hh_tot_derog_avg > 1.5277777778) => -0.0170204350, 0.1045678547), 0.0087360394), 
(rv_comb_age > 37.5) => -0.0080302264, -0.0001971803);

// Tree: 78
final_score_78 := map(
( NULL < rv_I60_inq_hiRiskCred_recency and rv_I60_inq_hiRiskCred_recency <= 61.5) => map(
   ( NULL < nf_inq_Other_count24 and nf_inq_Other_count24 <= 0.5) => map(
      (iv_Phn_Addr_Verified in ['2 NAP ONLY','3 BOTH VERD']) => 0.0163739558, 
      (iv_Phn_Addr_Verified in ['0 NONE VERD','1 INF ONLY']) => 0.0522095112, 0.0282448447), 
   (nf_inq_Other_count24 > 0.5) => -0.0002579477, 0.0035879624), 
(rv_I60_inq_hiRiskCred_recency > 61.5) => -0.0282074043, -0.0018743532);

// Tree: 79
final_score_79 := map(
( NULL < rv_D33_Eviction_Recency and rv_D33_Eviction_Recency <= 1.5) => map(
   ( NULL < nf_phone_ver_experian and nf_phone_ver_experian <= 0.5) => map(
      ( NULL < nf_fp_srchvelocityrisktype and nf_fp_srchvelocityrisktype <= 4.5) => 0.0458618516, 
      (nf_fp_srchvelocityrisktype > 4.5) => 0.0026838944, 0.0061707131), 
   (nf_phone_ver_experian > 0.5) => -0.0103133235, -0.0053906837), 
(rv_D33_Eviction_Recency > 1.5) => 0.0157244619, -0.0019797024);

// Tree: 80
final_score_80 := map(
( NULL < rv_D32_felony_count and rv_D32_felony_count <= 2.5) => map(
   ( NULL < nf_hh_pct_property_owners and nf_hh_pct_property_owners <= 0.6794871795) => map(
      ( NULL < rv_L79_adls_per_sfd_addr_c6 and rv_L79_adls_per_sfd_addr_c6 <= 0.5) => -0.0027263758, 
      (rv_L79_adls_per_sfd_addr_c6 > 0.5) => 0.0112427720, 0.0032079384), 
   (nf_hh_pct_property_owners > 0.6794871795) => -0.0201661960, 0.0001623485), 
(rv_D32_felony_count > 2.5) => 0.1026322462, 0.0003364443);

// Tree: 81
final_score_81 := map(
( NULL < nf_inq_adls_per_phone and nf_inq_adls_per_phone <= 2.5) => 0.0005554937, 
(nf_inq_adls_per_phone > 2.5) => map(
   ( NULL < nf_average_rel_distance and nf_average_rel_distance <= 171.5) => map(
      ( NULL < nf_hh_tot_derog_avg and nf_hh_tot_derog_avg <= 0.95) => 0.1411865176, 
      (nf_hh_tot_derog_avg > 0.95) => -0.0145349362, 0.0967489320), 
   (nf_average_rel_distance > 171.5) => -0.0053054791, 0.0486845964), -0.0913715290);

// Tree: 82
final_score_82 := map(
( NULL < nf_inq_per_phone and nf_inq_per_phone <= 6.5) => map(
   ( NULL < rv_I60_inq_PrepaidCards_recency and rv_I60_inq_PrepaidCards_recency <= 9) => -0.0062710912, 
   (rv_I60_inq_PrepaidCards_recency > 9) => 0.0138938640, -0.0042126659), 
(nf_inq_per_phone > 6.5) => map(
   ( NULL < nf_fp_srchfraudsrchcountyr and nf_fp_srchfraudsrchcountyr <= 2.5) => 0.1139483563, 
   (nf_fp_srchfraudsrchcountyr > 2.5) => 0.0142880365, 0.0168070437), -0.0736460036);

// Tree: 83
final_score_83 := map(
(rv_6seg_RiskView_5_0 in ['3 ADDR NOT CURRENT - OTHER','5 SUFFICIENTLY VERD - OWNER','6 SUFFICIENTLY VERD - OTHER']) => -0.0088131126, 
(rv_6seg_RiskView_5_0 in ['0 TRUEDID = 0','1 VER/VAL PROBLEMS','2 ADDR NOT CURRENT - DEROG','4 SUFFICIENTLY VERD - DEROG']) => map(
   ( NULL < iv_college_tier and iv_college_tier <= 4.5) => map(
      ( NULL < rv_C13_inp_addr_lres and rv_C13_inp_addr_lres <= 17.5) => 0.0147421021, 
      (rv_C13_inp_addr_lres > 17.5) => -0.0011712080, 0.0020938596), 
   (iv_college_tier > 4.5) => 0.0316483839, 0.0040493524), -0.0007510433);

// Tree: 84
final_score_84 := map(
( NULL < rv_D33_Eviction_Recency and rv_D33_Eviction_Recency <= 1.5) => map(
   ( NULL < nf_fp_srchunvrfdphonecount and nf_fp_srchunvrfdphonecount <= 4.5) => -0.0039023591, 
   (nf_fp_srchunvrfdphonecount > 4.5) => map(
      ( NULL < nf_average_rel_income and nf_average_rel_income <= 52500) => 0.1324423786, 
      (nf_average_rel_income > 52500) => 0.0290888456, 0.0491500964), -0.0035710051), 
(rv_D33_Eviction_Recency > 1.5) => 0.0156417772, -0.0004722809);

// Tree: 85
final_score_85 := map(
( NULL < rv_I60_inq_retail_recency and rv_I60_inq_retail_recency <= 0.5) => map(
   ( NULL < nf_inq_per_phone and nf_inq_per_phone <= 3.5) => map(
      ( NULL < nf_hh_criminals and nf_hh_criminals <= 2.5) => -0.0032004217, 
      (nf_hh_criminals > 2.5) => 0.0348119238, -0.0009154218), 
   (nf_inq_per_phone > 3.5) => 0.0112050200, -0.0784432978), 
(rv_I60_inq_retail_recency > 0.5) => -0.0139380901, -0.0013152707);

// Tree: 86
final_score_86 := map(
( NULL < rv_I60_inq_retail_recency and rv_I60_inq_retail_recency <= 0.5) => map(
   ( NULL < nf_inq_dobs_per_ssn and nf_inq_dobs_per_ssn <= 1.5) => map(
      ( NULL < rv_I60_inq_hiRiskCred_count12 and rv_I60_inq_hiRiskCred_count12 <= 1.5) => -0.0014192701, 
      (rv_I60_inq_hiRiskCred_count12 > 1.5) => 0.0161766879, 0.0054095034), 
   (nf_inq_dobs_per_ssn > 1.5) => -0.0094826238, 0.0022117372), 
(rv_I60_inq_retail_recency > 0.5) => -0.0135320887, -0.0016699634);

// Tree: 87
final_score_87 := map(
( NULL < iv_prof_license_category_PL and iv_prof_license_category_PL <= 4.5) => -0.0121847236, 
(iv_prof_license_category_PL > 4.5) => 0.1987995468, map(
   ( NULL < nf_inq_per_ssn and nf_inq_per_ssn <= 9.5) => map(
      ( NULL < nf_inq_HighRiskCredit_count_day and nf_inq_HighRiskCredit_count_day <= 0.5) => -0.0039685302, 
      (nf_inq_HighRiskCredit_count_day > 0.5) => 0.0245703247, -0.0030179649), 
   (nf_inq_per_ssn > 9.5) => 0.0136624240, -0.0002914165));

// Tree: 88
final_score_88 := map(
(rv_L70_Add_Standardized in ['1 Address was Standardized']) => -0.0105559625, 
(rv_L70_Add_Standardized in ['0 Address is Standard','2 Standardization Error']) => map(
   (iv_dl_val_flag in ['Empty','Invalid','Not Avail']) => -0.0039949336, 
   (iv_dl_val_flag in ['Valid']) => map(
      ( NULL < iv_mos_src_voter_adl_lseen and iv_mos_src_voter_adl_lseen <= 1) => 0.0251341593, 
      (iv_mos_src_voter_adl_lseen > 1) => 0.0028693668, 0.0107718850), 0.0030914208), -0.0010755341);

// Tree: 89
final_score_89 := map(
(rv_D31_MostRec_Bk in ['2 - BK DISCHARGED']) => -0.0168770121, 
(rv_D31_MostRec_Bk in ['0 - NO BK','1 - BK DISMISSED','3 - BK OTHER']) => map(
   ( NULL < nf_fp_srchunvrfdphonecount and nf_fp_srchunvrfdphonecount <= 3.5) => 0.0025599721, 
   (nf_fp_srchunvrfdphonecount > 3.5) => map(
      (nf_util_add_input_summary in ['|   |','| C |','| CM|','|I  |','|I M|']) => 0.0167815842, 
      (nf_util_add_input_summary in ['|  M|','|IC |','|ICM|']) => 0.1241665646, 0.0270680039), 0.0032290261), -0.0013404810);

// Tree: 90
final_score_90 := map(
(nf_fp_addrchangeecontraj in ['-1','AA','AB','AC','AD','AF','BA','BB','BC','BD','BE','BU','CA','CB','CC','CD','CE','CF','DA','DB','DC','DD','DE','DF','EA','EB','EC','ED','EE','EF','EU','FA','FB','FC','FD','FE','FF','FU','UC','UE','UU']) => map(
   ( NULL < iv_Estimated_Income and iv_Estimated_Income <= 158500) => map(
      ( NULL < rv_C14_addrs_5yr and rv_C14_addrs_5yr <= 3.5) => -0.0031280075, 
      (rv_C14_addrs_5yr > 3.5) => 0.0120377672, -0.0012927473), 
   (iv_Estimated_Income > 158500) => 0.1739603655, -0.0011324845), 
(nf_fp_addrchangeecontraj in ['AE','AU','BF','CU','DU','UD','UF']) => 0.2225876785, -0.0009827483);

// Tree: 91
final_score_91 := map(
( NULL < rv_email_domain_ISP_count and rv_email_domain_ISP_count <= 0.5) => map(
   (iv_full_name_ver_sources in ['PHN & NONPHN']) => 0.0034791102, 
   (iv_full_name_ver_sources in ['NAME NOT VERD','NONPHN ONLY','PHN ONLY']) => map(
      (nf_fp_addrchangeecontraj in ['-1','AA','AC','AD','AF','BA','BB','BC','BD','BE','CA','CB','CC','CF','CU','DA','DB','DC','DD','DF','DU','EA','EB','EC','ED','EE','EF','FC','FD','FE','FF','FU','UD','UE','UF','UU']) => 0.0127787118, 
      (nf_fp_addrchangeecontraj in ['AB','AE','AU','BF','BU','CD','CE','DE','EU','FA','FB','UC']) => 0.1440531145, 0.0139955470), 0.0070860049), 
(rv_email_domain_ISP_count > 0.5) => -0.0064263704, -0.0004086965);

// Tree: 92
final_score_92 := map(
( NULL < nf_fp_srchfraudsrchcountyr and nf_fp_srchfraudsrchcountyr <= 8.5) => map(
   ( NULL < nf_fp_srchaddrsrchcountwk and nf_fp_srchaddrsrchcountwk <= 0.5) => -0.0073432169, 
   (nf_fp_srchaddrsrchcountwk > 0.5) => 0.0136251014, -0.0052056994), 
(nf_fp_srchfraudsrchcountyr > 8.5) => map(
   ( NULL < rv_comb_age and rv_comb_age <= 50.5) => 0.0177339057, 
   (rv_comb_age > 50.5) => -0.0151671564, 0.0104122762), -0.0027758121);

// Tree: 93
final_score_93 := map(
( NULL < rv_I60_inq_PrepaidCards_recency and rv_I60_inq_PrepaidCards_recency <= 18) => map(
   (rv_6seg_RiskView_5_0 in ['5 SUFFICIENTLY VERD - OWNER','6 SUFFICIENTLY VERD - OTHER']) => -0.0142801174, 
   (rv_6seg_RiskView_5_0 in ['0 TRUEDID = 0','1 VER/VAL PROBLEMS','2 ADDR NOT CURRENT - DEROG','3 ADDR NOT CURRENT - OTHER','4 SUFFICIENTLY VERD - DEROG']) => 0.0013044958, -0.0032336959), 
(rv_I60_inq_PrepaidCards_recency > 18) => map(
   ( NULL < iv_mos_src_voter_adl_lseen and iv_mos_src_voter_adl_lseen <= 123.5) => 0.0124662437, 
   (iv_mos_src_voter_adl_lseen > 123.5) => 0.0993583060, 0.0145236806), -0.0013707655);

// Tree: 94
final_score_94 := map(
( NULL < rv_comb_age and rv_comb_age <= 22.5) => 0.0259460396, 
(rv_comb_age > 22.5) => map(
   ( NULL < nf_fp_curraddrmedianvalue and nf_fp_curraddrmedianvalue <= 76794.5) => 0.0169223149, 
   (nf_fp_curraddrmedianvalue > 76794.5) => map(
      (rv_D32_criminal_x_felony in ['0-0','1-0','1-1','2-0','2-1','3-0','3-1','3-2']) => -0.0029847854, 
      (rv_D32_criminal_x_felony in ['2-2','3-3']) => 0.0911648707, -0.0027891680), -0.0005600954), 0.0002128453);

// Tree: 95
final_score_95 := map(
( NULL < rv_I60_inq_auto_count12 and rv_I60_inq_auto_count12 <= 3.5) => map(
   ( NULL < rv_L79_adls_per_addr_curr and rv_L79_adls_per_addr_curr <= 3.5) => -0.0052484756, 
   (rv_L79_adls_per_addr_curr > 3.5) => 0.0083395334, 0.0010062573), 
(rv_I60_inq_auto_count12 > 3.5) => map(
   ( NULL < nf_fp_srchfraudsrchcountmo and nf_fp_srchfraudsrchcountmo <= 1.5) => -0.0076434288, 
   (nf_fp_srchfraudsrchcountmo > 1.5) => -0.0364348966, -0.0175810883), -0.0000860746);

// Tree: 96
final_score_96 := map(
( NULL < rv_I60_inq_auto_count12 and rv_I60_inq_auto_count12 <= 1.5) => map(
   ( NULL < nf_fp_srchaddrsrchcountwk and nf_fp_srchaddrsrchcountwk <= 1.5) => 0.0026324523, 
   (nf_fp_srchaddrsrchcountwk > 1.5) => map(
      ( NULL < nf_inq_adls_per_ssn and nf_inq_adls_per_ssn <= 0.5) => 0.1990396157, 
      (nf_inq_adls_per_ssn > 0.5) => 0.0164129447, 0.0216015264), 0.0035387868), 
(rv_I60_inq_auto_count12 > 1.5) => -0.0147437898, 0.0010306270);

// Tree: 97
final_score_97 := map(
( NULL < rv_D30_Derog_Count and rv_D30_Derog_Count <= 9.5) => map(
   ( NULL < nf_inq_adls_per_phone and nf_inq_adls_per_phone <= 2.5) => -0.0014296299, 
   (nf_inq_adls_per_phone > 2.5) => 0.0420218694, -0.1103965308), 
(rv_D30_Derog_Count > 9.5) => map(
   (nf_fp_addrchangeecontraj in ['-1','AA','AC','AD','BB','BD','BF','CB','CC','CD','CF','CU','DD','DF','EA','EC','ED','EE','EF','FD','FF']) => 0.0217163325, 
   (nf_fp_addrchangeecontraj in ['AB','AE','AF','AU','BA','BC','BE','BU','CA','CE','DA','DB','DC','DE','DU','EB','EU','FA','FB','FC','FE','FU','UC','UD','UE','UF','UU']) => 0.2435015169, 0.0250199216), -0.0000110923);

// Tree: 98
final_score_98 := map(
( NULL < nf_pct_rel_with_felony and nf_pct_rel_with_felony <= 0.22653958945) => map(
   ( NULL < rv_L79_adls_per_sfd_addr and rv_L79_adls_per_sfd_addr <= 7.5) => -0.0033070577, 
   (rv_L79_adls_per_sfd_addr > 7.5) => 0.0184817522, -0.0019915416), 
(nf_pct_rel_with_felony > 0.22653958945) => map(
   (iv_D34_liens_unrel_x_rel in ['0-0','0-1','0-2','1-0','1-1','2-2','3-0','3-2']) => 0.0222034699, 
   (iv_D34_liens_unrel_x_rel in ['1-2','2-0','2-1','3-1']) => 0.1284608157, 0.0306249297), -0.0012022540);

// Tree: 99
final_score_99 := map(
( NULL < nf_historical_count and nf_historical_count <= 7.5) => map(
   ( NULL < rv_I62_inq_phones_per_adl and rv_I62_inq_phones_per_adl <= 4.5) => map(
      ( NULL < nf_fp_srchfraudsrchcountwk and nf_fp_srchfraudsrchcountwk <= 7.5) => -0.0039208460, 
      (nf_fp_srchfraudsrchcountwk > 7.5) => 0.0820725162, -0.0038422473), 
   (rv_I62_inq_phones_per_adl > 4.5) => 0.0389494742, -0.0035260276), 
(nf_historical_count > 7.5) => 0.0144996421, -0.0013547437);

// Tree: 100
final_score_100 := map(
( NULL < rv_F01_inp_addr_not_verified and rv_F01_inp_addr_not_verified <= 0.5) => 0.0000273732, 
(rv_F01_inp_addr_not_verified > 0.5) => map(
   ( NULL < iv_prv_addr_lres and iv_prv_addr_lres <= 9.5) => map(
      (nf_fp_addrchangeecontraj in ['-1','BB','BD','CB','CC','CF','DA','DB','DD','DE','EA','EB','EC','UE']) => -0.0546006353, 
      (nf_fp_addrchangeecontraj in ['AA','AB','AC','AD','AE','AF','AU','BA','BC','BE','BF','BU','CA','CD','CE','CU','DC','DF','DU','ED','EE','EF','EU','FA','FB','FC','FD','FE','FF','FU','UC','UD','UF','UU']) => 0.1497425279, 0.0884395790), 
   (iv_prv_addr_lres > 9.5) => 0.0278773035, 0.0347800224), 0.0007947324);

// Tree: 101
final_score_101 := map(
( NULL < nf_inq_Other_count24 and nf_inq_Other_count24 <= 0.5) => map(
   ( NULL < rv_I60_inq_hiRiskCred_recency and rv_I60_inq_hiRiskCred_recency <= 18) => map(
      ( NULL < nf_phone_ver_experian and nf_phone_ver_experian <= 0.5) => 0.0429091894, 
      (nf_phone_ver_experian > 0.5) => 0.0142406366, 0.0238323457), 
   (rv_I60_inq_hiRiskCred_recency > 18) => -0.0203197088, 0.0036705722), 
(nf_inq_Other_count24 > 0.5) => -0.0047256776, -0.0032275978);

// Tree: 102
final_score_102 := map(
( NULL < iv_college_tier and iv_college_tier <= 4.5) => map(
   ( NULL < nf_inq_dobs_per_ssn and nf_inq_dobs_per_ssn <= 1.5) => map(
      ( NULL < rv_I60_inq_comm_recency and rv_I60_inq_comm_recency <= 0.5) => -0.0054964963, 
      (rv_I60_inq_comm_recency > 0.5) => 0.0107880234, -0.0004508571), 
   (nf_inq_dobs_per_ssn > 1.5) => -0.0114617799, -0.0027325740), 
(iv_college_tier > 4.5) => 0.0189792130, -0.0012076799);

// Tree: 103
final_score_103 := map(
( NULL < iv_mos_src_voter_adl_lseen and iv_mos_src_voter_adl_lseen <= 86.5) => map(
   ( NULL < rv_L79_adls_per_addr_c6 and rv_L79_adls_per_addr_c6 <= 2.5) => -0.0036493057, 
   (rv_L79_adls_per_addr_c6 > 2.5) => map(
      ( NULL < nf_inq_HighRiskCredit_count_day and nf_inq_HighRiskCredit_count_day <= 0.5) => 0.0077658850, 
      (nf_inq_HighRiskCredit_count_day > 0.5) => 0.0434545927, 0.0095641382), -0.0019986379), 
(iv_mos_src_voter_adl_lseen > 86.5) => 0.0248342480, -0.0005204132);

// Tree: 104
final_score_104 := map(
( NULL < iv_dob_src_ct and iv_dob_src_ct <= 17.5) => map(
   ( NULL < iv_br_source_count and iv_br_source_count <= 5.5) => -0.0002372530, 
   (iv_br_source_count > 5.5) => map(
      ( NULL < rv_I60_inq_hiRiskCred_recency and rv_I60_inq_hiRiskCred_recency <= 0.5) => 0.3937282741, 
      (rv_I60_inq_hiRiskCred_recency > 0.5) => 0.0413263293, 0.0778301164), 0.0002908832), 
(iv_dob_src_ct > 17.5) => 0.0548429444, -0.0256121328);

// Tree: 105
final_score_105 := map(
( NULL < rv_I62_inq_phones_per_adl and rv_I62_inq_phones_per_adl <= 4.5) => map(
   ( NULL < nf_inq_per_phone and nf_inq_per_phone <= 10.5) => map(
      ( NULL < iv_mos_src_voter_adl_lseen and iv_mos_src_voter_adl_lseen <= 123.5) => -0.0021077421, 
      (iv_mos_src_voter_adl_lseen > 123.5) => 0.0381163217, -0.0012667860), 
   (nf_inq_per_phone > 10.5) => 0.0166834272, -0.0956664185), 
(rv_I62_inq_phones_per_adl > 4.5) => 0.0390395365, -0.0000441429);

// Tree: 106
final_score_106 := map(
( NULL < nf_inq_dobs_per_ssn and nf_inq_dobs_per_ssn <= 1.5) => map(
   ( NULL < nf_inq_adls_per_phone and nf_inq_adls_per_phone <= 2.5) => 0.0022444777, 
   (nf_inq_adls_per_phone > 2.5) => 0.0567682017, -0.0571813625), 
(nf_inq_dobs_per_ssn > 1.5) => map(
   (nf_fp_addrchangeecontraj in ['-1','AA','AB','AC','AD','AE','AF','BB','BC','BD','BE','CA','CB','CC','CD','CE','CF','CU','DD','DE','DF','DU','EB','EE','EF','EU','FA','FC','FD','FE','FF','FU','UC','UE','UF','UU']) => -0.0126694596, 
   (nf_fp_addrchangeecontraj in ['AU','BA','BF','BU','DA','DB','DC','EA','EC','ED','FB','UD']) => 0.0882641523, -0.0117491483), -0.0004614708);

// Tree: 107
final_score_107 := map(
( NULL < nf_bus_addr_match_count and nf_bus_addr_match_count <= 3.5) => -0.0018401588, 
(nf_bus_addr_match_count > 3.5) => map(
   ( NULL < nf_inq_HighRiskCredit_count_week and nf_inq_HighRiskCredit_count_week <= 2.5) => map(
      ( NULL < iv_br_source_count and iv_br_source_count <= 5.5) => 0.0149981464, 
      (iv_br_source_count > 5.5) => 0.1394225483, 0.0191967510), 
   (nf_inq_HighRiskCredit_count_week > 2.5) => 0.0871018799, 0.0204698438), 0.0000591391);

// Tree: 108
final_score_108 := map(
( NULL < rv_F00_dob_score and rv_F00_dob_score <= 80) => 0.0783825242, 
(rv_F00_dob_score > 80) => map(
   ( NULL < nf_fp_srchfraudsrchcountyr and nf_fp_srchfraudsrchcountyr <= 9.5) => map(
      ( NULL < rv_I60_inq_comm_recency and rv_I60_inq_comm_recency <= 0.5) => -0.0087096073, 
      (rv_I60_inq_comm_recency > 0.5) => 0.0074626268, -0.0034570677), 
   (nf_fp_srchfraudsrchcountyr > 9.5) => 0.0120204037, -0.0015603942), -0.0198794793);

// Tree: 109
final_score_109 := map(
(iv_full_name_ver_sources in ['PHN & NONPHN','PHN ONLY']) => map(
   (rv_E58_br_dead_bus_x_active_phn in ['0-0','0-1','0-2','0-3','1-0','1-1','2-0','3-1','3-2']) => -0.0021797823, 
   (rv_E58_br_dead_bus_x_active_phn in ['1-2','1-3','2-1','2-2','2-3','3-0','3-3']) => map(
      ( NULL < nf_phone_ver_experian and nf_phone_ver_experian <= 0.5) => 0.1870057941, 
      (nf_phone_ver_experian > 0.5) => 0.0580644727, 0.0843975595), -0.0015153863), 
(iv_full_name_ver_sources in ['NAME NOT VERD','NONPHN ONLY']) => 0.0082603103, 0.0012754771);

// Tree: 110
final_score_110 := map(
( NULL < nf_pct_rel_prop_owned and nf_pct_rel_prop_owned <= 0.3162280702) => map(
   ( NULL < nf_inq_HighRiskCredit_count_day and nf_inq_HighRiskCredit_count_day <= 0.5) => 0.0067275854, 
   (nf_inq_HighRiskCredit_count_day > 0.5) => map(
      ( NULL < nf_add_input_nhood_MFD_pct and nf_add_input_nhood_MFD_pct <= 0.82756649265) => 0.0274944108, 
      (nf_add_input_nhood_MFD_pct > 0.82756649265) => 0.1605728177, 0.0359289577), 0.0078967368), 
(nf_pct_rel_prop_owned > 0.3162280702) => -0.0044031406, -0.0010303510);

// Tree: 111
final_score_111 := map(
(rv_6seg_RiskView_5_0 in ['5 SUFFICIENTLY VERD - OWNER','6 SUFFICIENTLY VERD - OTHER']) => -0.0140470129, 
(rv_6seg_RiskView_5_0 in ['0 TRUEDID = 0','1 VER/VAL PROBLEMS','2 ADDR NOT CURRENT - DEROG','3 ADDR NOT CURRENT - OTHER','4 SUFFICIENTLY VERD - DEROG']) => map(
   ( NULL < rv_comb_age and rv_comb_age <= 36.5) => map(
      (iv_dl_val_flag in ['Empty','Not Avail']) => 0.0014165015, 
      (iv_dl_val_flag in ['Invalid','Valid']) => 0.0188148022, 0.0100830443), 
   (rv_comb_age > 36.5) => -0.0018235340, 0.0029292279), -0.0019233112);

// Tree: 112
final_score_112 := map(
( NULL < rv_I60_credit_seeking and rv_I60_credit_seeking <= 1.5) => map(
   ( NULL < nf_pct_rel_prop_sold and nf_pct_rel_prop_sold <= 0.19586530265) => map(
      ( NULL < nf_rel_criminal_count and nf_rel_criminal_count <= 3.5) => -0.0000026078, 
      (nf_rel_criminal_count > 3.5) => 0.0183020842, 0.0072866625), 
   (nf_pct_rel_prop_sold > 0.19586530265) => -0.0053506938, 0.0019024459), 
(rv_I60_credit_seeking > 1.5) => -0.0214307311, 0.0004833904);

// Tree: 113
final_score_113 := map(
( NULL < nf_attr_arrest_recency and nf_attr_arrest_recency <= 48) => map(
   ( NULL < rv_L79_adls_per_sfd_addr_c6 and rv_L79_adls_per_sfd_addr_c6 <= 0.5) => 0.1405654827, 
   (rv_L79_adls_per_sfd_addr_c6 > 0.5) => -0.0042314115, 0.0664514326), 
(nf_attr_arrest_recency > 48) => map(
   ( NULL < nf_inq_Collection_count24 and nf_inq_Collection_count24 <= 2.5) => 0.0001605539, 
   (nf_inq_Collection_count24 > 2.5) => 0.1233901736, 0.0080507958), -0.0015304703);

// Tree: 114
final_score_114 := map(
( NULL < nf_acc_damage_amt_total and nf_acc_damage_amt_total <= 112.5) => map(
   ( NULL < rv_D30_Derog_Count and rv_D30_Derog_Count <= 14.5) => -0.0009747280, 
   (rv_D30_Derog_Count > 14.5) => map(
      ( NULL < rv_C10_M_Hdr_FS and rv_C10_M_Hdr_FS <= 225) => 0.1137626041, 
      (rv_C10_M_Hdr_FS > 225) => 0.0224937434, 0.0348603256), -0.0004770519),
			nf_acc_damage_amt_total = (Unsigned)NULL => -0.0019602052,
(nf_acc_damage_amt_total > 112.5) => -0.0520587855, -0.0019602052);

// Tree: 115
final_score_115 := map(
( NULL < rv_I61_inq_collection_count12 and rv_I61_inq_collection_count12 <= 0.5) => map(
   ( NULL < iv_Estimated_Income and iv_Estimated_Income <= 147500) => -0.0031054684, 
   (iv_Estimated_Income > 147500) => 0.1215105325, -0.0028722805), 
(rv_I61_inq_collection_count12 > 0.5) => map(
   ( NULL < rv_comb_age and rv_comb_age <= 32.5) => 0.0272832875, 
   (rv_comb_age > 32.5) => 0.0024049493, 0.0092704848), -0.0005020265);

// Tree: 116
final_score_116 := map(
( NULL < iv_br_source_count and iv_br_source_count <= 2.5) => map(
   ( NULL < nf_pct_rel_prop_owned and nf_pct_rel_prop_owned <= 0.29099462365) => 0.0089994652, 
   (nf_pct_rel_prop_owned > 0.29099462365) => -0.0053935653, -0.0017378575), 
(iv_br_source_count > 2.5) => map(
   ( NULL < nf_hh_collections_ct_avg and nf_hh_collections_ct_avg <= 0.0871212121) => 0.1710696959, 
   (nf_hh_collections_ct_avg > 0.0871212121) => 0.0248835099, 0.0314767339), -0.0003065516);

// Tree: 117
final_score_117 := map(
( NULL < rv_I62_inq_dobs_per_adl and rv_I62_inq_dobs_per_adl <= 1.5) => map(
   (nf_fp_addrchangeecontraj in ['-1','AA','AB','AE','AF','BB','BC','BE','BU','CA','CB','CC','CD','CE','CF','CU','DA','DB','DC','DD','DF','EA','EC','ED','EE','EF','EU','FB','FC','FE','FF','FU','UE','UU']) => map(
      ( NULL < nf_fp_prevaddrmedianincome and nf_fp_prevaddrmedianincome <= 22560) => 0.0352493577, 
      (nf_fp_prevaddrmedianincome > 22560) => 0.0017299488, 0.0028325758), 
   (nf_fp_addrchangeecontraj in ['AC','AD','AU','BA','BD','BF','DE','DU','EB','FA','FD','UC','UD','UF']) => 0.0716042142, 0.0035079243), 
(rv_I62_inq_dobs_per_adl > 1.5) => -0.0087091702, 0.0006908326);

// Tree: 118
final_score_118 := map(
( NULL < iv_Estimated_Income and iv_Estimated_Income <= 147500) => map(
   ( NULL < rv_I61_inq_collection_count12 and rv_I61_inq_collection_count12 <= 1.5) => -0.0025730471, 
   (rv_I61_inq_collection_count12 > 1.5) => 0.0196335361, -0.0010445997), 
(iv_Estimated_Income > 147500) => map(
   ( NULL < nf_inq_HighRiskCredit_count24 and nf_inq_HighRiskCredit_count24 <= 0.5) => 0.2409612492, 
   (nf_inq_HighRiskCredit_count24 > 0.5) => -0.0023936830, 0.0901497419), -0.0008779318);

// Tree: 119
final_score_119 := map(
( NULL < iv_br_source_count and iv_br_source_count <= 8.5) => map(
   ( NULL < nf_rel_derog_summary and nf_rel_derog_summary <= 6.5) => -0.0042887339, 
   (nf_rel_derog_summary > 6.5) => map(
      ( NULL < nf_M_Bureau_ADL_FS_noTU and nf_M_Bureau_ADL_FS_noTU <= 88.5) => 0.0499514749, 
      (nf_M_Bureau_ADL_FS_noTU > 88.5) => 0.0066204912, 0.0085007311), -0.0026183727), 
(iv_br_source_count > 8.5) => 0.1689186938, -0.0024947344);

// Tree: 120
final_score_120 := map(
( NULL < rv_I60_inq_retail_recency and rv_I60_inq_retail_recency <= 2) => map(
   ( NULL < nf_M_Bureau_ADL_FS_all and nf_M_Bureau_ADL_FS_all <= 360.5) => 0.0068913433, 
   (nf_M_Bureau_ADL_FS_all > 360.5) => -0.0134602640, 0.0037014643), 
(rv_I60_inq_retail_recency > 2) => map(
   (rv_D32_criminal_x_felony in ['0-0','1-0','2-0','2-1','3-0','3-1','3-2']) => -0.0122495496, 
   (rv_D32_criminal_x_felony in ['1-1','2-2','3-3']) => 0.1177595297, -0.0116864388), -0.0000025577);

// Tree: 121
final_score_121 := map(
( NULL < iv_src_voter_adl_count and iv_src_voter_adl_count <= 4.5) => map(
   ( NULL < nf_historical_count and nf_historical_count <= 5.5) => -0.0010939522, 
   (nf_historical_count > 5.5) => map(
      ( NULL < nf_hh_collections_ct and nf_hh_collections_ct <= 6.5) => 0.0156138526, 
      (nf_hh_collections_ct > 6.5) => 0.1320963857, 0.0167281148), 0.0020820403), 
(iv_src_voter_adl_count > 4.5) => -0.0184154833, 0.0000003142);

// Tree: 122
final_score_122 := map(
(nf_Source_Type in ['Behavioral Only','Bureau and Behavioral','Bureau Behavioral and Government','Bureau Only','Government Only']) => map(
   ( NULL < nf_historical_count and nf_historical_count <= 31.5) => -0.0022538964, 
   (nf_historical_count > 31.5) => 0.2067502959, -0.0020978375), 
(nf_Source_Type in ['Behavioral and Government','Bureau and Government','None']) => map(
   ( NULL < nf_fp_varrisktype and nf_fp_varrisktype <= 6.5) => 0.0130811669, 
   (nf_fp_varrisktype > 6.5) => 0.0549261616, 0.0154557489), -0.0005809473);

// Tree: 123
final_score_123 := map(
( NULL < iv_src_voter_adl_count and iv_src_voter_adl_count <= 4.5) => map(
   ( NULL < nf_average_rel_distance and nf_average_rel_distance <= 285.5) => 0.0073561610, 
   (nf_average_rel_distance > 285.5) => map(
      (nf_fp_addrchangeecontraj in ['-1','AA','AB','AD','AE','AF','BB','BD','BE','BF','BU','CA','CB','CC','CD','CE','CF','CU','DA','DB','DC','DD','DE','DF','EA','EB','EC','ED','EE','EF','FB','FC','FD','FE','FF','FU','UC','UE','UU']) => -0.0063779791, 
      (nf_fp_addrchangeecontraj in ['AC','AU','BA','BC','DU','EU','FA','UD','UF']) => 0.2037468511, -0.0057192493), 0.0034051812), 
(iv_src_voter_adl_count > 4.5) => -0.0182539722, 0.0011686261);

// Tree: 124
final_score_124 := map(
( NULL < rv_I61_inq_collection_count12 and rv_I61_inq_collection_count12 <= 3.5) => map(
   ( NULL < rv_F00_dob_score and rv_F00_dob_score <= 92) => 0.0427222202, 
   (rv_F00_dob_score > 92) => -0.0012165982, -0.0196614461), 
(rv_I61_inq_collection_count12 > 3.5) => map(
   ( NULL < nf_fp_srchssnsrchcountmo and nf_fp_srchssnsrchcountmo <= 4.5) => 0.0385638696, 
   (nf_fp_srchssnsrchcountmo > 4.5) => 0.1254875997, 0.0451293854), -0.0009232425);

// Tree: 125
final_score_125 := map(
( NULL < nf_fp_srchfraudsrchcountyr and nf_fp_srchfraudsrchcountyr <= 3.5) => map(
   ( NULL < nf_fp_srchphonesrchcountwk and nf_fp_srchphonesrchcountwk <= 1.5) => -0.0090173631, 
   (nf_fp_srchphonesrchcountwk > 1.5) => 0.0469194806, -0.0083398989), 
(nf_fp_srchfraudsrchcountyr > 3.5) => map(
   ( NULL < rv_I60_inq_auto_count12 and rv_I60_inq_auto_count12 <= 3.5) => 0.0082244154, 
   (rv_I60_inq_auto_count12 > 3.5) => -0.0202967847, 0.0047440303), -0.0027229977);

// Tree: 126
final_score_126 := map(
( NULL < nf_util_adl_count and nf_util_adl_count <= 5.5) => -0.0046603969, 
(nf_util_adl_count > 5.5) => map(
   (nf_Source_Type in ['Bureau and Behavioral','Bureau Behavioral and Government','Bureau Only']) => 0.0046231643, 
   (nf_Source_Type in ['Behavioral and Government','Behavioral Only','Bureau and Government','Government Only','None']) => map(
      ( NULL < nf_inq_per_sfd_addr and nf_inq_per_sfd_addr <= 4.5) => 0.0639457046, 
      (nf_inq_per_sfd_addr > 4.5) => -0.0099996248, 0.0423526108), 0.0073062467), -0.0010260293);

// Tree: 127
final_score_127 := map(
( NULL < nf_hh_college_attendees and nf_hh_college_attendees <= 4.5) => map(
   ( NULL < rv_D33_Eviction_Recency and rv_D33_Eviction_Recency <= 1.5) => -0.0031705277, 
   (rv_D33_Eviction_Recency > 1.5) => map(
      (nf_fp_addrchangeecontraj in ['AB','AC','BA','BC','BF','CA','CB','CD','CE','CF','DA','DB','FB','FC','FD','FU','UE','UU']) => -0.0983299104, 
      (nf_fp_addrchangeecontraj in ['-1','AA','AD','AE','AF','AU','BB','BD','BE','BU','CC','CU','DC','DD','DE','DF','DU','EA','EB','EC','ED','EE','EF','EU','FA','FE','FF','UC','UD','UF']) => 0.0123026880, 0.0108027644), -0.0009129726), 
(nf_hh_college_attendees > 4.5) => 0.1473078302, -0.0007546293);

// Tree: 128
final_score_128 := map(
( NULL < iv_college_tier and iv_college_tier <= 4.5) => map(
   ( NULL < nf_inq_HighRiskCredit_count_day and nf_inq_HighRiskCredit_count_day <= 1.5) => -0.0018612777, 
   (nf_inq_HighRiskCredit_count_day > 1.5) => map(
      ( NULL < nf_fp_prevaddrmurderindex and nf_fp_prevaddrmurderindex <= 178.5) => 0.0202233299, 
      (nf_fp_prevaddrmurderindex > 178.5) => 0.1467039652, 0.0287538008), -0.0015347112), 
(iv_college_tier > 4.5) => 0.0185403908, -0.0001365264);

// Tree: 129
final_score_129 := map(
(iv_D34_liens_unrel_x_rel in ['1-1','1-2','2-1','2-2','3-2']) => map(
   ( NULL < rv_D30_Derog_Count and rv_D30_Derog_Count <= 20.5) => -0.0207913004, 
   (rv_D30_Derog_Count > 20.5) => map(
      ( NULL < rv_C14_addrs_15yr and rv_C14_addrs_15yr <= 6.5) => 0.0168803678, 
      (rv_C14_addrs_15yr > 6.5) => 0.1712609145, 0.0848413694), -0.0190976431), 
(iv_D34_liens_unrel_x_rel in ['0-0','0-1','0-2','1-0','2-0','3-0','3-1']) => 0.0016103398, -0.0014485063);

// Tree: 130
final_score_130 := map(
( NULL < rv_D30_Derog_Count and rv_D30_Derog_Count <= 6.5) => -0.0005083831, 
(rv_D30_Derog_Count > 6.5) => map(
   ( NULL < nf_fp_curraddrcartheftindex and nf_fp_curraddrcartheftindex <= 59) => 0.0427890048, 
   (nf_fp_curraddrcartheftindex > 59) => map(
      ( NULL < nf_fp_srchcomponentrisktype and nf_fp_srchcomponentrisktype <= 3.5) => 0.0186106094, 
      (nf_fp_srchcomponentrisktype > 3.5) => -0.0180754266, 0.0110145221), 0.0201079882), 0.0014934949);

// Tree: 131
final_score_131 := map(
( NULL < nf_fp_curraddrmedianincome and nf_fp_curraddrmedianincome <= 168509) => map(
   ( NULL < nf_bus_addr_match_count and nf_bus_addr_match_count <= 4.5) => -0.0005988324, 
   (nf_bus_addr_match_count > 4.5) => map(
      ( NULL < iv_Estimated_Income and iv_Estimated_Income <= 134500) => 0.0194357663, 
      (iv_Estimated_Income > 134500) => 0.1734678716, 0.0213402911), 0.0008878133), 
(nf_fp_curraddrmedianincome > 168509) => 0.1566988505, 0.0010903633);

// Tree: 132
final_score_132 := map(
( NULL < nf_inq_Other_count24 and nf_inq_Other_count24 <= 0.5) => map(
   ( NULL < rv_I60_inq_hiRiskCred_recency and rv_I60_inq_hiRiskCred_recency <= 61.5) => map(
      ( NULL < nf_phone_ver_experian and nf_phone_ver_experian <= 0.5) => 0.0411207811, 
      (nf_phone_ver_experian > 0.5) => 0.0155901764, 0.0237907918), 
   (rv_I60_inq_hiRiskCred_recency > 61.5) => -0.0210995253, 0.0070404807), 
(nf_inq_Other_count24 > 0.5) => -0.0011799527, 0.0002908650);

// Tree: 133
final_score_133 := map(
(nf_fp_addrchangeecontraj in ['AF','BC','BU','CA','CF','CU','DB','FA','FC','FU','UC','UE','UU']) => -0.0876644021, 
(nf_fp_addrchangeecontraj in ['-1','AA','AB','AC','AD','AE','AU','BA','BB','BD','BE','BF','CB','CC','CD','CE','DA','DC','DD','DE','DF','DU','EA','EB','EC','ED','EE','EF','EU','FB','FD','FE','FF','UD','UF']) => map(
   (rv_L70_Add_Standardized in ['1 Address was Standardized']) => -0.0077012734, 
   (rv_L70_Add_Standardized in ['0 Address is Standard','2 Standardization Error']) => map(
      ( NULL < nf_inq_Other_count24 and nf_inq_Other_count24 <= 0.5) => 0.0207804288, 
      (nf_inq_Other_count24 > 0.5) => 0.0012792479, 0.0047867643), 0.0009600323), 0.0006258071);

// Tree: 134
final_score_134 := map(
( NULL < iv_prof_license_category_PL and iv_prof_license_category_PL <= 4.5) => -0.0123916872, 
(iv_prof_license_category_PL > 4.5) => 0.1339618321, map(
   ( NULL < rv_I60_credit_seeking and rv_I60_credit_seeking <= 1.5) => map(
      ( NULL < nf_rel_felony_count and nf_rel_felony_count <= 2.5) => -0.0010247368, 
      (nf_rel_felony_count > 2.5) => 0.0197331978, 0.0000679971), 
   (rv_I60_credit_seeking > 1.5) => -0.0169522375, -0.0009618769));

// Tree: 135
final_score_135 := map(
( NULL < rv_D31_bk_dism_recent_count and rv_D31_bk_dism_recent_count <= 0.5) => map(
   ( NULL < nf_fp_srchfraudsrchcountwk and nf_fp_srchfraudsrchcountwk <= 7.5) => -0.0006173352, 
   (nf_fp_srchfraudsrchcountwk > 7.5) => 0.0658949032, -0.0005546170), 
(rv_D31_bk_dism_recent_count > 0.5) => map(
   ( NULL < nf_average_rel_distance and nf_average_rel_distance <= 99) => 0.2503858362, 
   (nf_average_rel_distance > 99) => 0.0411761794, 0.0873363172), -0.0002367495);

// Tree: 136
final_score_136 := map(
( NULL < rv_comb_age and rv_comb_age <= 36.5) => map(
   (nf_fp_addrchangeecontraj in ['AB','AE','AF','BA','BU','CA','CF','DB','FE','UC','UE','UU']) => -0.0769674274, 
   (nf_fp_addrchangeecontraj in ['-1','AA','AC','AD','AU','BB','BC','BD','BE','BF','CB','CC','CD','CE','CU','DA','DC','DD','DE','DF','DU','EA','EB','EC','ED','EE','EF','EU','FA','FB','FC','FD','FF','FU','UD','UF']) => map(
      ( NULL < iv_unverified_addr_count and iv_unverified_addr_count <= 2.5) => -0.0001637786, 
      (iv_unverified_addr_count > 2.5) => 0.0180922552, 0.0070493041), 0.0061838188), 
(rv_comb_age > 36.5) => -0.0049311284, -0.0000977777);

// Tree: 137
final_score_137 := map(
( NULL < nf_fp_srchunvrfddobcount and nf_fp_srchunvrfddobcount <= 0.5) => map(
   ( NULL < rv_I60_inq_PrepaidCards_recency and rv_I60_inq_PrepaidCards_recency <= 4.5) => -0.0005206702, 
   (rv_I60_inq_PrepaidCards_recency > 4.5) => map(
      ( NULL < rv_mos_since_br_first_seen and rv_mos_since_br_first_seen <= 5.5) => 0.0115095557, 
      (rv_mos_since_br_first_seen > 5.5) => 0.0630109679, 0.0176292959), 0.0012903346), 
(nf_fp_srchunvrfddobcount > 0.5) => -0.0101661476, -0.0012485540);

// Tree: 138
final_score_138 := map(
( NULL < iv_prv_addr_lres and iv_prv_addr_lres <= 6.5) => map(
   (nf_fp_addrchangeecontraj in ['-1','AA','AD','BA','BB','BC','CA','CB','CC','CE','CF','DA','DB','DD','DE','EB','EC','ED','EE','EF','FC','FD','FE','FF','FU','UE','UF','UU']) => map(
      ( NULL < nf_fp_srchfraudsrchcountyr and nf_fp_srchfraudsrchcountyr <= 12.5) => 0.0047640759, 
      (nf_fp_srchfraudsrchcountyr > 12.5) => 0.0555518117, 0.0081969410), 
   (nf_fp_addrchangeecontraj in ['AB','AC','AE','AF','AU','BD','BE','BF','BU','CD','CU','DC','DF','DU','EA','EU','FA','FB','UC','UD']) => 0.2195145106, 0.0106283301), 
(iv_prv_addr_lres > 6.5) => -0.0009929357, -0.0338845880);

// Tree: 139
final_score_139 := map(
( NULL < nf_hh_payday_loan_users_pct and nf_hh_payday_loan_users_pct <= 0.0976190476) => -0.0016667636, 
(nf_hh_payday_loan_users_pct > 0.0976190476) => map(
   ( NULL < nf_add_input_nhood_BUS_pct and nf_add_input_nhood_BUS_pct <= 0.00093545695) => map(
      ( NULL < iv_inp_add_avm_pct_chg_2yr and iv_inp_add_avm_pct_chg_2yr <= 1.2606393606) => 0.1341763928, 
      (iv_inp_add_avm_pct_chg_2yr > 1.2606393606) => -0.0160552576, 0.0837546891), 
   (nf_add_input_nhood_BUS_pct > 0.00093545695) => 0.0085107992, 0.0106532637), 0.0010322609);

// Tree: 140
final_score_140 := map(
( NULL < nf_inq_per_addr and nf_inq_per_addr <= 7.5) => -0.0039221228, 
(nf_inq_per_addr > 7.5) => map(
   ( NULL < nf_inq_adls_per_ssn and nf_inq_adls_per_ssn <= 0.5) => 0.0843045155, 
   (nf_inq_adls_per_ssn > 0.5) => map(
      (nf_fp_addrchangeecontraj in ['-1','AA','AC','BA','BB','BC','BD','BF','CA','CB','CC','CD','CE','CF','DA','DB','DC','DD','DE','EA','EB','ED','EE','EF','EU','FA','FD','FE','FF','FU','UE','UU']) => 0.0058332033, 
      (nf_fp_addrchangeecontraj in ['AB','AD','AE','AF','AU','BE','BU','CU','DF','DU','EC','FB','FC','UC','UD','UF']) => 0.1368247831, 0.0062284300), 0.0086526985), -0.0009872964);

// Tree: 141
final_score_141 := map(
( NULL < nf_fp_srchvelocityrisktype and nf_fp_srchvelocityrisktype <= 1.5) => map(
   ( NULL < iv_Phn_Cell and iv_Phn_Cell <= 0.5) => map(
      (iv_curr_add_mortgage_type in ['GOVERNMENT','NO MORTGAGE','NON-TRADITIONAL']) => 0.0660278076, 
      (iv_curr_add_mortgage_type in ['COMMERCIAL','CONVENTIONAL','OTHER','UNKNOWN']) => 0.3337090655, 0.1373038822), 
   (iv_Phn_Cell > 0.5) => -0.0097856803, 0.0440781032), 
(nf_fp_srchvelocityrisktype > 1.5) => -0.0013309733, -0.0007903265);

// Tree: 142
final_score_142 := map(
( NULL < rv_D30_Derog_Count and rv_D30_Derog_Count <= 6.5) => -0.0013552643, 
(rv_D30_Derog_Count > 6.5) => map(
   (nf_fp_addrchangeecontraj in ['-1','AA','AB','AE','BA','BD','BF','CA','CB','CC','CD','CF','DA','DC','DD','DE','DF','EA','EC','ED','EE','EF','FB','FC','FD','FF','FU','UC']) => 0.0100023865, 
   (nf_fp_addrchangeecontraj in ['AC','AD','AF','AU','BB','BC','BE','BU','CE','CU','DB','DU','EB','EU','FA','FE','UD','UE','UF','UU']) => map(
      ( NULL < nf_fp_inputaddractivephonelist and nf_fp_inputaddractivephonelist <= 0.5) => 0.2110430565, 
      (nf_fp_inputaddractivephonelist > 0.5) => 0.0241217520, 0.1121340254), 0.0130019065), 0.0000478917);

// Tree: 143
final_score_143 := map(
( NULL < rv_I60_inq_comm_count12 and rv_I60_inq_comm_count12 <= 4.5) => 0.0003562451, 
(rv_I60_inq_comm_count12 > 4.5) => map(
   ( NULL < nf_inq_ssns_per_addr and nf_inq_ssns_per_addr <= 1.5) => -0.0456118758, 
   (nf_inq_ssns_per_addr > 1.5) => map(
      (nf_util_adl_summary in ['|  M|','| C |','|IC |']) => 0.0390793930, 
      (nf_util_adl_summary in ['|   |','| CM|','|I  |','|I M|','|ICM|']) => 0.1910236124, 0.1087204936), 0.0523769301), 0.0004827933);

// Tree: 144
final_score_144 := map(
( NULL < nf_pct_rel_prop_owned and nf_pct_rel_prop_owned <= 0.40175438595) => map(
   ( NULL < iv_college_tier and iv_college_tier <= 4.5) => 0.0047421896, 
   (iv_college_tier > 4.5) => map(
      ( NULL < nf_phones_per_addr_c6 and nf_phones_per_addr_c6 <= 2.5) => 0.0218479483, 
      (nf_phones_per_addr_c6 > 2.5) => 0.1253668815, 0.0305204787), 0.0064299176), 
(nf_pct_rel_prop_owned > 0.40175438595) => -0.0043816419, 0.0000097235);

// Tree: 145
final_score_145 := map(
( NULL < iv_mos_src_voter_adl_lseen and iv_mos_src_voter_adl_lseen <= 157.5) => map(
   ( NULL < nf_hh_payday_loan_users and nf_hh_payday_loan_users <= 1.5) => -0.0006210517, 
   (nf_hh_payday_loan_users > 1.5) => 0.0262997546, 0.0001523426), 
(iv_mos_src_voter_adl_lseen > 157.5) => map(
   ( NULL < rv_S66_adlperssn_count and rv_S66_adlperssn_count <= 2.5) => 0.0354485518, 
   (rv_S66_adlperssn_count > 2.5) => 0.2036432426, 0.0717087059), 0.0005069239);

// Tree: 146
final_score_146 := map(
( NULL < rv_C14_addrs_10yr and rv_C14_addrs_10yr <= 13.5) => map(
   ( NULL < nf_fp_srchunvrfdphonecount and nf_fp_srchunvrfdphonecount <= 6.5) => -0.0000990995, 
   (nf_fp_srchunvrfdphonecount > 6.5) => 0.0869511053, -0.0000373243), 
(rv_C14_addrs_10yr > 13.5) => map(
   ( NULL < iv_C13_avg_lres and iv_C13_avg_lres <= 29.5) => 0.0145072765, 
   (iv_C13_avg_lres > 29.5) => 0.1649742801, 0.0745381536), 0.0001479242);

// Tree: 147
final_score_147 := map(
(nf_util_add_curr_summary in ['|   |','| C |','|I  |']) => -0.0091613363, 
(nf_util_add_curr_summary in ['|  M|','| CM|','|I M|','|IC |','|ICM|']) => map(
   ( NULL < iv_Phn_Cell and iv_Phn_Cell <= 0.5) => -0.0042892438, 
   (iv_Phn_Cell > 0.5) => map(
      ( NULL < nf_hh_pct_property_owners and nf_hh_pct_property_owners <= 0.3798076923) => 0.0160940443, 
      (nf_hh_pct_property_owners > 0.3798076923) => -0.0043705943, 0.0092036591), -0.0514267338), -0.0002665339);

// Tree: 148
final_score_148 := map(
( NULL < nf_bus_addr_match_count and nf_bus_addr_match_count <= 2.5) => -0.0028380859, 
(nf_bus_addr_match_count > 2.5) => map(
   ( NULL < nf_fp_srchvelocityrisktype and nf_fp_srchvelocityrisktype <= 5.5) => map(
      ( NULL < nf_average_rel_income and nf_average_rel_income <= 89500) => 0.0478506485, 
      (nf_average_rel_income > 89500) => 0.2696228737, 0.0791049051), 
   (nf_fp_srchvelocityrisktype > 5.5) => 0.0095629431, 0.0150045772), -0.0008803975);

// Tree: 149
final_score_149 := map(
( NULL < nf_util_adl_count and nf_util_adl_count <= 4.5) => map(
   (rv_D32_criminal_x_felony in ['0-0','1-0','1-1','2-0','3-0','3-2']) => -0.0055528936, 
   (rv_D32_criminal_x_felony in ['2-1','2-2','3-1','3-3']) => 0.0398849602, -0.0050850734), 
(nf_util_adl_count > 4.5) => map(
   ( NULL < iv_C13_avg_lres and iv_C13_avg_lres <= 8.5) => 0.1403388124, 
   (iv_C13_avg_lres > 8.5) => 0.0063222061, 0.0067058995), -0.0007382430);

// Tree: 150
final_score_150 := map(
( NULL < rv_P88_Phn_Dst_to_Inp_Add and rv_P88_Phn_Dst_to_Inp_Add <= 8.5) => -0.0043124943, 
(rv_P88_Phn_Dst_to_Inp_Add > 8.5) => 0.0014838731, map(
   ( NULL < nf_fp_curraddrmedianincome and nf_fp_curraddrmedianincome <= 96181.5) => 0.0062293412, 
   (nf_fp_curraddrmedianincome > 96181.5) => map(
      ( NULL < rv_I60_inq_PrepaidCards_recency and rv_I60_inq_PrepaidCards_recency <= 18) => 0.0393338509, 
      (rv_I60_inq_PrepaidCards_recency > 18) => 0.1613365116, 0.0495424411), 0.0090057344));

// Tree: 151
final_score_151 := map(
( NULL < nf_acc_damage_amt_total and nf_acc_damage_amt_total <= 2) => map(
   ( NULL < nf_historical_count and nf_historical_count <= 3.5) => -0.0022421231, 
   (nf_historical_count > 3.5) => map(
      ( NULL < rv_comb_age and rv_comb_age <= 31.5) => 0.0276480768, 
      (rv_comb_age > 31.5) => 0.0058417955, 0.0085418442), 0.0013495755),
			nf_acc_damage_amt_total = (Unsigned)NULL => 0.0000176318,
(nf_acc_damage_amt_total > 2) => -0.0429356999, 0.0000176318);

// Tree: 152
final_score_152 := map(
( NULL < rv_I62_inq_dobs_per_adl and rv_I62_inq_dobs_per_adl <= 1.5) => 0.0021552426, 
(rv_I62_inq_dobs_per_adl > 1.5) => map(
   ( NULL < nf_fp_srchssnsrchcountmo and nf_fp_srchssnsrchcountmo <= 7.5) => -0.0113774255, 
   (nf_fp_srchssnsrchcountmo > 7.5) => map(
      ( NULL < nf_inq_lnames_per_sfd_addr and nf_inq_lnames_per_sfd_addr <= 1.5) => 0.0032884958, 
      (nf_inq_lnames_per_sfd_addr > 1.5) => 0.0936008714, 0.0287660923), -0.0103168453), -0.0007307476);

// Tree: 153
final_score_153 := map(
( NULL < nf_average_rel_distance and nf_average_rel_distance <= 297.5) => map(
   ( NULL < iv_src_voter_adl_count and iv_src_voter_adl_count <= 3.5) => map(
      ( NULL < rv_L79_adls_per_sfd_addr_c6 and rv_L79_adls_per_sfd_addr_c6 <= 0.5) => -0.0015892773, 
      (rv_L79_adls_per_sfd_addr_c6 > 0.5) => 0.0119860709, 0.0041744100), 
   (iv_src_voter_adl_count > 3.5) => -0.0141662241, 0.0012026788), 
(nf_average_rel_distance > 297.5) => -0.0116208732, -0.0025145966);

// Tree: 154
final_score_154 := map(
( NULL < nf_addrs_per_ssn_c6 and nf_addrs_per_ssn_c6 <= 1.5) => map(
   ( NULL < rv_I60_credit_seeking and rv_I60_credit_seeking <= 1.5) => -0.0004367697, 
   (rv_I60_credit_seeking > 1.5) => map(
      (nf_fp_addrchangeecontraj in ['-1','AA','AB','BA','BB','BC','BD','BE','CA','CB','CC','CD','CU','DA','DB','DC','DD','ED','EE','EF','FC','FD','FE','FF','FU']) => -0.0212607442, 
      (nf_fp_addrchangeecontraj in ['AC','AD','AE','AF','AU','BF','BU','CE','CF','DE','DF','DU','EA','EB','EC','EU','FA','FB','UC','UD','UE','UF','UU']) => 0.2257782874, -0.0185425830), -0.0015462279), 
(nf_addrs_per_ssn_c6 > 1.5) => 0.0497615448, -0.0011692125);

// Tree: 155
final_score_155 := map(
( NULL < nf_fp_srchssnsrchcountwk and nf_fp_srchssnsrchcountwk <= 7.5) => map(
   ( NULL < rv_D31_bk_dism_recent_count and rv_D31_bk_dism_recent_count <= 0.5) => map(
      ( NULL < rv_C14_addrs_10yr and rv_C14_addrs_10yr <= 4.5) => -0.0048178159, 
      (rv_C14_addrs_10yr > 4.5) => 0.0058333981, -0.0019490530), 
   (rv_D31_bk_dism_recent_count > 0.5) => 0.0745093633, -0.0016476827), 
(nf_fp_srchssnsrchcountwk > 7.5) => 0.0756400007, -0.0015899838);

// Tree: 156
final_score_156 := map(
( NULL < nf_fp_srchfraudsrchcountwk and nf_fp_srchfraudsrchcountwk <= 1.5) => map(
   ( NULL < nf_fp_srchphonesrchcountwk and nf_fp_srchphonesrchcountwk <= 1.5) => 0.0003418985, 
   (nf_fp_srchphonesrchcountwk > 1.5) => map(
      ( NULL < nf_average_rel_distance and nf_average_rel_distance <= 129.5) => 0.1472303935, 
      (nf_average_rel_distance > 129.5) => 0.0249320663, 0.0718858883), 0.0005616987), 
(nf_fp_srchfraudsrchcountwk > 1.5) => -0.0106965545, -0.0001313822);

// Tree: 157
final_score_157 := map(
(iv_college_major in ['BUSINESS','LIBERAL ARTS','NO AMS FOUND','NO COLLEGE FOUND','SCIENCE','UNCLASSIFIED']) => -0.0013285986, 
(iv_college_major in ['MEDICAL']) => map(
   ( NULL < iv_dob_src_ct and iv_dob_src_ct <= 8.5) => 0.0802131471, 
   (iv_dob_src_ct > 8.5) => map(
      ( NULL < nf_inq_Other_count24 and nf_inq_Other_count24 <= 3.5) => -0.0062275804, 
      (nf_inq_Other_count24 > 3.5) => 0.1227443573, 0.0233725365), 0.0386888687), -0.0009711296);

// Tree: 158
final_score_158 := map(
( NULL < iv_prv_addr_lres and iv_prv_addr_lres <= 0.5) => map(
   ( NULL < nf_inq_HighRiskCredit_count_week and nf_inq_HighRiskCredit_count_week <= 1.5) => 0.0253005176, 
   (nf_inq_HighRiskCredit_count_week > 1.5) => 0.1087622859, 0.0285253956), 
(iv_prv_addr_lres > 0.5) => 0.0005631409, map(
   ( NULL < iv_inp_add_avm_pct_chg_2yr and iv_inp_add_avm_pct_chg_2yr <= 1.13971446295) => 0.0559574949, 
   (iv_inp_add_avm_pct_chg_2yr > 1.13971446295) => -0.0426774392, -0.0157687213));

// Tree: 159
final_score_159 := map(
( NULL < rv_D33_Eviction_Recency and rv_D33_Eviction_Recency <= 1.5) => -0.0018444653, 
(rv_D33_Eviction_Recency > 1.5) => map(
   ( NULL < rv_D33_Eviction_Recency and rv_D33_Eviction_Recency <= 30.5) => map(
      ( NULL < nf_inq_Communications_count24 and nf_inq_Communications_count24 <= 1.5) => 0.0233794582, 
      (nf_inq_Communications_count24 > 1.5) => 0.0816280655, 0.0313066250), 
   (rv_D33_Eviction_Recency > 30.5) => 0.0046312257, 0.0092742309), -0.0000560624);

// Tree: 160
final_score_160 := map(
( NULL < iv_C13_avg_lres and iv_C13_avg_lres <= 354.5) => map(
   ( NULL < nf_fp_srchssnsrchcountday and nf_fp_srchssnsrchcountday <= 4.5) => 0.0006494700, 
   (nf_fp_srchssnsrchcountday > 4.5) => -0.0569299140, 0.0005781670), 
(iv_C13_avg_lres > 354.5) => map(
   ( NULL < rv_I60_inq_hiRiskCred_recency and rv_I60_inq_hiRiskCred_recency <= 2) => 0.2460556697, 
   (rv_I60_inq_hiRiskCred_recency > 2) => -0.0090269322, 0.0888536011), 0.0007735898);

// Tree: 161
final_score_161 := map(
( NULL < nf_inq_dobs_per_ssn and nf_inq_dobs_per_ssn <= 1.5) => 0.0024412779, 
(nf_inq_dobs_per_ssn > 1.5) => map(
   ( NULL < nf_fp_srchphonesrchcountmo and nf_fp_srchphonesrchcountmo <= 3.5) => -0.0139754037, 
   (nf_fp_srchphonesrchcountmo > 3.5) => map(
      ( NULL < rv_D32_criminal_count and rv_D32_criminal_count <= 6.5) => 0.0092135667, 
      (rv_D32_criminal_count > 6.5) => 0.1100733682, 0.0129742317), -0.0112829089), -0.0004509620);

// Tree: 162
final_score_162 := map(
( NULL < rv_email_domain_ISP_count and rv_email_domain_ISP_count <= 1.5) => map(
   ( NULL < nf_inq_dobs_per_ssn and nf_inq_dobs_per_ssn <= 1.5) => map(
      ( NULL < nf_inq_HighRiskCredit_count24 and nf_inq_HighRiskCredit_count24 <= 1.5) => -0.0019477154, 
      (nf_inq_HighRiskCredit_count24 > 1.5) => 0.0132285661, 0.0054829126), 
   (nf_inq_dobs_per_ssn > 1.5) => -0.0074681380, 0.0026536177), 
(rv_email_domain_ISP_count > 1.5) => -0.0077063090, -0.0007940910);

// Tree: 163
final_score_163 := map(
( NULL < nf_inq_Banking_count24 and nf_inq_Banking_count24 <= 0.5) => map(
   ( NULL < nf_bus_addr_match_count and nf_bus_addr_match_count <= 2.5) => map(
      ( NULL < nf_fp_srchfraudsrchcountday and nf_fp_srchfraudsrchcountday <= 1.5) => -0.0049965610, 
      (nf_fp_srchfraudsrchcountday > 1.5) => -0.0278780623, -0.0053692609), 
   (nf_bus_addr_match_count > 2.5) => 0.0157900982, -0.0030827941), 
(nf_inq_Banking_count24 > 0.5) => 0.0102758388, -0.0002116578);

// Tree: 164
final_score_164 := map(
(nf_fp_addrchangeecontraj in ['-1','AA','AC','AD','AF','BA','BB','BC','BD','BE','BF','BU','CA','CB','CC','CD','CE','CF','CU','DA','DB','DC','DD','DE','DF','DU','EA','EB','EC','ED','EE','EF','EU','FC','FD','FE','FF','FU','UC','UE','UU']) => map(
   ( NULL < rv_C19_Add_Prison_Hist and rv_C19_Add_Prison_Hist <= 0.5) => -0.0006619829, 
   (rv_C19_Add_Prison_Hist > 0.5) => map(
      ( NULL < iv_dob_src_ct and iv_dob_src_ct <= 8.5) => 0.2057799725, 
      (iv_dob_src_ct > 8.5) => 0.0075577928, 0.0623852042), -0.0004995801), 
(nf_fp_addrchangeecontraj in ['AB','AE','AU','FA','FB','UD','UF']) => 0.1640356760, -0.0003873431);

// Tree: 165
final_score_165 := map(
(rv_D32_criminal_x_felony in ['0-0','1-0','1-1','2-0','2-1','3-0','3-1','3-2']) => map(
   ( NULL < iv_C14_addrs_per_adl and iv_C14_addrs_per_adl <= 20.5) => -0.0019400460, 
   (iv_C14_addrs_per_adl > 20.5) => 0.1087906439, -0.0018129270), 
(rv_D32_criminal_x_felony in ['2-2','3-3']) => map(
   ( NULL < nf_average_rel_criminal_dist and nf_average_rel_criminal_dist <= 210) => 0.1464102083, 
   (nf_average_rel_criminal_dist > 210) => 0.0075461038, 0.0745839473), -0.0016418452);

// Tree: 166
final_score_166 := map(
(rv_6seg_RiskView_5_0 in ['3 ADDR NOT CURRENT - OTHER','5 SUFFICIENTLY VERD - OWNER','6 SUFFICIENTLY VERD - OTHER']) => -0.0067084696, 
(rv_6seg_RiskView_5_0 in ['0 TRUEDID = 0','1 VER/VAL PROBLEMS','2 ADDR NOT CURRENT - DEROG','4 SUFFICIENTLY VERD - DEROG']) => map(
   (nf_fp_addrchangeecontraj in ['-1','AA','AB','AC','AE','BA','BB','BC','BD','BE','BU','CA','CB','CC','CD','CE','CF','DA','DB','DC','DD','DE','DF','EA','EB','EC','ED','EE','EF','EU','FB','FC','FD','FE','FF','FU','UC','UE','UU']) => map(
      ( NULL < rv_comb_age and rv_comb_age <= 22.5) => 0.0372574671, 
      (rv_comb_age > 22.5) => 0.0044756273, 0.0049372862), 
   (nf_fp_addrchangeecontraj in ['AD','AF','AU','BF','CU','DU','FA','UD','UF']) => 0.1722417662, 0.0051164758), 0.0006809229);

// Tree: 167
final_score_167 := map(
( NULL < rv_D32_criminal_count and rv_D32_criminal_count <= 19.5) => map(
   ( NULL < rv_C19_Add_Prison_Hist and rv_C19_Add_Prison_Hist <= 0.5) => -0.0010826146, 
   (rv_C19_Add_Prison_Hist > 0.5) => map(
      ( NULL < iv_fname_non_phn_src_ct and iv_fname_non_phn_src_ct <= 8.5) => 0.2052774108, 
      (iv_fname_non_phn_src_ct > 8.5) => 0.0085944709, 0.0600821515), -0.0009320343), 
(rv_D32_criminal_count > 19.5) => -0.0750281278, -0.0010340845);

// Tree: 168
final_score_168 := map(
( NULL < nf_inq_Other_count24 and nf_inq_Other_count24 <= 6.5) => map(
   ( NULL < nf_inq_dobs_per_ssn and nf_inq_dobs_per_ssn <= 1.5) => 0.0007827788, 
   (nf_inq_dobs_per_ssn > 1.5) => map(
      ( NULL < nf_fp_srchfraudsrchcountmo and nf_fp_srchfraudsrchcountmo <= 4.5) => -0.0182180404, 
      (nf_fp_srchfraudsrchcountmo > 4.5) => 0.0125160401, -0.0154356581), -0.0024330412), 
(nf_inq_Other_count24 > 6.5) => 0.0147314808, -0.0008008077);

// Tree: 169
final_score_169 := map(
( NULL < rv_C12_source_profile and rv_C12_source_profile <= 20.15) => map(
   (nf_fp_addrchangeecontraj in ['-1','AA','AE','BB','BC','BE','CC','CE','CF','DA','DC','DD','DE','EB','ED','EE','EF','FC','FF','UE']) => map(
      ( NULL < nf_fp_prevaddrcrimeindex and nf_fp_prevaddrcrimeindex <= 192) => 0.0122854817, 
      (nf_fp_prevaddrcrimeindex > 192) => 0.1481410305, 0.0149107097), 
   (nf_fp_addrchangeecontraj in ['AB','AC','AD','AF','AU','BA','BD','BF','BU','CA','CB','CD','CU','DB','DF','DU','EA','EC','EU','FA','FB','FD','FE','FU','UC','UD','UF','UU']) => 0.1585003958, 0.0180132552), 
(rv_C12_source_profile > 20.15) => -0.0014474323, -0.0007055336);

// Tree: 170
final_score_170 := map(
( NULL < rv_I60_inq_auto_count12 and rv_I60_inq_auto_count12 <= 1.5) => map(
   ( NULL < rv_I60_inq_comm_count12 and rv_I60_inq_comm_count12 <= 3.5) => 0.0011460311, 
   (rv_I60_inq_comm_count12 > 3.5) => 0.0520620688, 0.0014032020), 
(rv_I60_inq_auto_count12 > 1.5) => map(
   ( NULL < nf_fp_srchfraudsrchcountmo and nf_fp_srchfraudsrchcountmo <= 2.5) => -0.0042871976, 
   (nf_fp_srchfraudsrchcountmo > 2.5) => -0.0316578376, -0.0097530440), -0.0001154478);

// Tree: 171
final_score_171 := map(
( NULL < iv_prv_addr_lres and iv_prv_addr_lres <= 7.5) => map(
   ( NULL < nf_phone_ver_experian and nf_phone_ver_experian <= 0.5) => map(
      ( NULL < iv_br_source_count and iv_br_source_count <= 1.5) => 0.0279299107, 
      (iv_br_source_count > 1.5) => 0.1444514070, 0.0335186158), 
   (nf_phone_ver_experian > 0.5) => 0.0003656408, 0.0121803106), 
(iv_prv_addr_lres > 7.5) => -0.0001507210, -0.0144273210);

// Tree: 172
final_score_172 := map(
( NULL < nf_fp_srchfraudsrchcountyr and nf_fp_srchfraudsrchcountyr <= 41.5) => map(
   ( NULL < nf_liens_unrel_ST_total_amt and nf_liens_unrel_ST_total_amt <= 5215) => -0.0014335542, 
   (nf_liens_unrel_ST_total_amt > 5215) => map(
      ( NULL < iv_inp_add_avm_pct_chg_2yr and iv_inp_add_avm_pct_chg_2yr <= 0.8433892973) => 0.2197283628, 
      (iv_inp_add_avm_pct_chg_2yr > 0.8433892973) => 0.0186506808, 0.0342672896), -0.0011054850), 
(nf_fp_srchfraudsrchcountyr > 41.5) => 0.0977138667, -0.0010278978);

// Tree: 173
final_score_173 := map(
( NULL < nf_inq_Banking_count24 and nf_inq_Banking_count24 <= 0.5) => -0.0026096259, 
(nf_inq_Banking_count24 > 0.5) => map(
   (nf_fp_addrchangeecontraj in ['-1','AA','AB','AE','BB','BD','BU','CA','CB','CC','CD','CE','CF','CU','DA','DB','DC','DD','DE','DF','DU','EC','ED','EE','EF','FC','FD','FE','FF','FU','UE','UU']) => map(
      (rv_D32_criminal_x_felony in ['0-0','1-0','1-1','2-0','3-0','3-2','3-3']) => 0.0082371967, 
      (rv_D32_criminal_x_felony in ['2-1','2-2','3-1']) => 0.0671902091, 0.0088318950), 
   (nf_fp_addrchangeecontraj in ['AC','AD','AF','AU','BA','BC','BE','BF','EA','EB','EU','FA','FB','UC','UD','UF']) => 0.2523588291, 0.0095899102), 0.0000135217);

// Tree: 174
final_score_174 := map(
(rv_D31_MostRec_Bk in ['0 - NO BK','2 - BK DISCHARGED','3 - BK OTHER']) => -0.0005280897, 
(rv_D31_MostRec_Bk in ['1 - BK DISMISSED']) => map(
   (rv_D32_criminal_x_felony in ['0-0','1-0','2-1','2-2','3-0','3-1','3-2','3-3']) => 0.0218982870, 
   (rv_D32_criminal_x_felony in ['1-1','2-0']) => map(
      (nf_util_adl_summary in ['| C |','| CM|']) => 0.0665613014, 
      (nf_util_adl_summary in ['|   |','|  M|','|I  |','|I M|','|IC |','|ICM|']) => 0.3483579898, 0.1495347708), 0.0319089916), 0.0004301173);

// Tree: 175
final_score_175 := map(
( NULL < nf_fp_prevaddrmedianincome and nf_fp_prevaddrmedianincome <= 29385) => 0.0161131491, 
(nf_fp_prevaddrmedianincome > 29385) => map(
   ( NULL < iv_prof_license_category_PL and iv_prof_license_category_PL <= 4.5) => map(
      ( NULL < iv_Estimated_Income and iv_Estimated_Income <= 134500) => -0.0087877500, 
      (iv_Estimated_Income > 134500) => 0.1955532659, -0.0068593048), 
   (iv_prof_license_category_PL > 4.5) => 0.1318325382, -0.0001772709), 0.0008534993);

// Tree: 176
final_score_176 := map(
( NULL < rv_br_active_phone_count and rv_br_active_phone_count <= 4.5) => map(
   ( NULL < rv_D30_Derog_Count and rv_D30_Derog_Count <= 20.5) => -0.0026116465, 
   (rv_D30_Derog_Count > 20.5) => map(
      (iv_D34_liens_unrel_x_rel in ['0-0','0-1','1-0','2-1','2-2','3-0']) => -0.0340498030, 
      (iv_D34_liens_unrel_x_rel in ['0-2','1-1','1-2','2-0','3-1','3-2']) => 0.1039338808, 0.0502941110), -0.0023573476), 
(rv_br_active_phone_count > 4.5) => 0.1712614161, -0.0021517573);

// Tree: 177
final_score_177 := map(
( NULL < rv_F01_inp_addr_address_score and rv_F01_inp_addr_address_score <= 25) => map(
   (nf_fp_addrchangeecontraj in ['-1','AA','AB','AE','BA','BC','BD','BE','BU','CA','CC','CD','CF','DC','DD','DE','EA','EB','EC','ED','EE','FA','FB','FC','FD','FE','UC','UE']) => -0.0012208781, 
   (nf_fp_addrchangeecontraj in ['AC','AD','AF','AU','BB','BF','CB','CE','CU','DA','DB','DF','DU','EF','EU','FF','FU','UD','UF','UU']) => map(
      ( NULL < nf_average_rel_education and nf_average_rel_education <= 13.5) => 0.1661006959, 
      (nf_average_rel_education > 13.5) => 0.0433218437, 0.0633134848), 0.0244273943), 
(rv_F01_inp_addr_address_score > 25) => -0.0002054799, 0.0003139949);

// Tree: 178
final_score_178 := map(
( NULL < nf_mos_acc_lseen and nf_mos_acc_lseen <= 78.5) => map(
   ( NULL < iv_mos_src_voter_adl_lseen and iv_mos_src_voter_adl_lseen <= 58.5) => 0.0004511452, 
   (iv_mos_src_voter_adl_lseen > 58.5) => map(
      ( NULL < nf_inq_dobs_per_ssn and nf_inq_dobs_per_ssn <= 2.5) => 0.0146712623, 
      (nf_inq_dobs_per_ssn > 2.5) => 0.1128228271, 0.0167704958), 0.0017620977), 
(nf_mos_acc_lseen > 78.5) => -0.0257843649, 0.0004229942);

// Tree: 179
final_score_179 := map(
( NULL < nf_fp_srchfraudsrchcountyr and nf_fp_srchfraudsrchcountyr <= 41.5) => map(
   ( NULL < nf_add_input_nhood_VAC_pct and nf_add_input_nhood_VAC_pct <= 0.009201043) => map(
      ( NULL < nf_fp_srchphonesrchcountmo and nf_fp_srchphonesrchcountmo <= 8.5) => 0.0064544852, 
      (nf_fp_srchphonesrchcountmo > 8.5) => 0.0818510779, 0.0067969318), 
   (nf_add_input_nhood_VAC_pct > 0.009201043) => -0.0040197312, 0.0001218097), 
(nf_fp_srchfraudsrchcountyr > 41.5) => 0.1094225073, 0.0001935542);

// Tree: 180
final_score_180 := map(
( NULL < nf_liens_unrel_ST_total_amt and nf_liens_unrel_ST_total_amt <= 4848.5) => -0.0002662331, 
(nf_liens_unrel_ST_total_amt > 4848.5) => map(
   (iv_college_file_type in ['-1']) => 0.0487430479, 
   (iv_college_file_type in ['A','C','H']) => map(
      ( NULL < rv_A46_Curr_AVM_AutoVal and rv_A46_Curr_AVM_AutoVal <= 66121) => 0.0038743354, 
      (rv_A46_Curr_AVM_AutoVal > 66121) => 0.2731702785, 0.1173792371), -0.0521658927), 0.0001133060);

// Tree: 181
final_score_181 := map(
( NULL < rv_email_domain_ISP_count and rv_email_domain_ISP_count <= 0.5) => 0.0058765010, 
(rv_email_domain_ISP_count > 0.5) => map(
   ( NULL < nf_fp_srchfraudsrchcountwk and nf_fp_srchfraudsrchcountwk <= 3.5) => -0.0032858177, 
   (nf_fp_srchfraudsrchcountwk > 3.5) => map(
      ( NULL < nf_inq_count24 and nf_inq_count24 <= 10.5) => -0.0122781939, 
      (nf_inq_count24 > 10.5) => -0.0906926351, -0.0305706329), -0.0036749569), 0.0005924150);

// Tree: 182
final_score_182 := map(
( NULL < rv_I60_inq_other_recency and rv_I60_inq_other_recency <= 4.5) => map(
   ( NULL < rv_C12_source_profile and rv_C12_source_profile <= 86.6) => map(
      ( NULL < nf_hh_bankruptcies_pct and nf_hh_bankruptcies_pct <= 0.16025641025) => 0.0084641949, 
      (nf_hh_bankruptcies_pct > 0.16025641025) => -0.0049142929, 0.0039191917), 
   (rv_C12_source_profile > 86.6) => 0.1127334550, 0.0045197450), 
(rv_I60_inq_other_recency > 4.5) => -0.0051565764, -0.0006434671);

// Tree: 183
final_score_183 := map(
( NULL < iv_br_source_count and iv_br_source_count <= 2.5) => -0.0019117587, 
(iv_br_source_count > 2.5) => map(
   ( NULL < rv_I61_inq_collection_recency and rv_I61_inq_collection_recency <= 2) => map(
      ( NULL < nf_hh_bankruptcies_pct and nf_hh_bankruptcies_pct <= 0.11805555555) => 0.1667431534, 
      (nf_hh_bankruptcies_pct > 0.11805555555) => 0.0177349544, 0.1018455997), 
   (rv_I61_inq_collection_recency > 2) => 0.0178298154, 0.0264563258), -0.0006706801);

// Tree: 184
final_score_184 := map(
( NULL < nf_inq_adls_per_phone and nf_inq_adls_per_phone <= 1.5) => map(
   ( NULL < nf_fp_srchfraudsrchcountwk and nf_fp_srchfraudsrchcountwk <= 6.5) => -0.0030509599, 
   (nf_fp_srchfraudsrchcountwk > 6.5) => map(
      ( NULL < nf_fp_curraddractivephonelist and nf_fp_curraddractivephonelist <= 0.5) => -0.0062310310, 
      (nf_fp_curraddractivephonelist > 0.5) => 0.1044673839, 0.0520757677), -0.0029478502), 
(nf_inq_adls_per_phone > 1.5) => 0.0103190807, -0.0920376918);

// Tree: 185
final_score_185 := map(
( NULL < nf_inq_Other_count24 and nf_inq_Other_count24 <= 0.5) => map(
   ( NULL < rv_I60_inq_hiRiskCred_recency and rv_I60_inq_hiRiskCred_recency <= 61.5) => map(
      ( NULL < nf_fp_prevaddrmedianincome and nf_fp_prevaddrmedianincome <= 94079.5) => 0.0163399193, 
      (nf_fp_prevaddrmedianincome > 94079.5) => 0.0890380877, 0.0222575965), 
   (rv_I60_inq_hiRiskCred_recency > 61.5) => -0.0228627371, 0.0054836992), 
(nf_inq_Other_count24 > 0.5) => -0.0019833010, -0.0006376956);

// Tree: 186
final_score_186 := map(
( NULL < nf_inq_Retail_count24 and nf_inq_Retail_count24 <= 0.5) => map(
   (rv_L70_Add_Standardized in ['1 Address was Standardized','2 Standardization Error']) => -0.0055303179, 
   (rv_L70_Add_Standardized in ['0 Address is Standard']) => map(
      ( NULL < iv_inp_add_avm_pct_chg_1yr and iv_inp_add_avm_pct_chg_1yr <= 1.7589523969) => 0.0009209713, 
      (iv_inp_add_avm_pct_chg_1yr > 1.7589523969) => -0.0230752702, 0.0094286884), 0.0010913466), 
(nf_inq_Retail_count24 > 0.5) => -0.0201276147, -0.0008218340);

// Tree: 187
final_score_187 := map(
(rv_D31_ALL_Bk in ['2 - BK DISCHARGED','3 - BK OTHER']) => -0.0120958654, 
(rv_D31_ALL_Bk in ['0 - NO BK','1 - BK DISMISSED']) => map(
   ( NULL < nf_attr_arrest_recency and nf_attr_arrest_recency <= 30) => 0.0817650845, 
   (nf_attr_arrest_recency > 30) => map(
      (nf_fp_addrchangeecontraj in ['-1','AA','CB','CC','CU','DA','DB','DD','DE','DF','ED','EE','EF','FD','FE','FF']) => -0.0062367061, 
      (nf_fp_addrchangeecontraj in ['AB','AC','AD','AE','AF','AU','BA','BB','BC','BD','BE','BF','BU','CA','CD','CE','CF','DC','DU','EA','EB','EC','EU','FA','FB','FC','FU','UC','UD','UE','UF','UU']) => 0.1863926607, 0.0035259017), 0.0024905913), -0.0006141502);

// Tree: 188
final_score_188 := map(
( NULL < nf_fp_srchunvrfdssncount and nf_fp_srchunvrfdssncount <= 0.5) => -0.0027334616, 
(nf_fp_srchunvrfdssncount > 0.5) => map(
   ( NULL < iv_fname_non_phn_src_ct and iv_fname_non_phn_src_ct <= 7.5) => map(
      (iv_D34_liens_unrel_x_rel in ['0-0','1-0','1-1','1-2','2-0','2-1','3-0','3-2']) => 0.0240131651, 
      (iv_D34_liens_unrel_x_rel in ['0-1','0-2','2-2','3-1']) => 0.2057920165, 0.0263079387), 
   (iv_fname_non_phn_src_ct > 7.5) => 0.0011911909, 0.0101252063), -0.0001533865);

// Tree: 189
final_score_189 := map(
( NULL < nf_pct_rel_prop_owned and nf_pct_rel_prop_owned <= 0.20881782945) => map(
   ( NULL < nf_fp_srchssnsrchcountday and nf_fp_srchssnsrchcountday <= 2.5) => map(
      ( NULL < rv_L79_adls_per_addr_curr and rv_L79_adls_per_addr_curr <= 4.5) => 0.0003045197, 
      (rv_L79_adls_per_addr_curr > 4.5) => 0.0230451082, 0.0086303293), 
   (nf_fp_srchssnsrchcountday > 2.5) => 0.0720221258, 0.0091039403), 
(nf_pct_rel_prop_owned > 0.20881782945) => -0.0020580722, -0.0002888966);

// Tree: 190
final_score_190 := map(
( NULL < rv_I61_inq_collection_count12 and rv_I61_inq_collection_count12 <= 0.5) => -0.0037809534, 
(rv_I61_inq_collection_count12 > 0.5) => map(
   (iv_college_type in ['-1','P','S']) => map(
      ( NULL < nf_M_Bureau_ADL_FS_all and nf_M_Bureau_ADL_FS_all <= 338.5) => 0.0147425736, 
      (nf_M_Bureau_ADL_FS_all > 338.5) => -0.0161682900, 0.0078235841), 
   (iv_college_type in ['N','R','U']) => 0.1396737689, 0.0085142654), -0.0013943573);

// Tree: 191
final_score_191 := map(
( NULL < rv_I61_inq_collection_count12 and rv_I61_inq_collection_count12 <= 0.5) => -0.0027903903, 
(rv_I61_inq_collection_count12 > 0.5) => map(
   ( NULL < nf_M_Bureau_ADL_FS_noTU and nf_M_Bureau_ADL_FS_noTU <= 36.5) => map(
      (nf_Source_Type in ['Bureau and Behavioral','Bureau and Government','Government Only']) => -0.0035368140, 
      (nf_Source_Type in ['Behavioral and Government','Behavioral Only','Bureau Behavioral and Government','Bureau Only','None']) => 0.1261273004, 0.0742616546), 
   (nf_M_Bureau_ADL_FS_noTU > 36.5) => 0.0076668330, 0.0086551474), -0.0005569098);

// Tree: 192
final_score_192 := map(
( NULL < nf_fp_srchssnsrchcountday and nf_fp_srchssnsrchcountday <= 4.5) => map(
   ( NULL < nf_inq_adls_per_phone and nf_inq_adls_per_phone <= 1.5) => -0.0010152046, 
   (nf_inq_adls_per_phone > 1.5) => map(
      (nf_fp_addrchangeecontraj in ['-1','AA','AC','AD','AE','AF','BB','BD','CA','CB','CC','CE','CU','DA','DC','DD','DE','DF','DU','EA','EB','EC','EE','FA','FD','FE','FF','FU','UU']) => 0.0111898164, 
      (nf_fp_addrchangeecontraj in ['AB','AU','BA','BC','BE','BF','BU','CD','CF','DB','ED','EF','EU','FB','FC','UC','UD','UE','UF']) => 0.1321686130, 0.0127066907), -0.0743050795), 
(nf_fp_srchssnsrchcountday > 4.5) => -0.0571191914, 0.0001158900);

// Tree: 193
final_score_193 := map(
(nf_Source_Type in ['Behavioral Only','Bureau and Behavioral','Bureau Behavioral and Government','Bureau Only','Government Only']) => map(
   ( NULL < nf_liens_unrel_ST_total_amt and nf_liens_unrel_ST_total_amt <= 223.5) => -0.0028498511, 
   (nf_liens_unrel_ST_total_amt > 223.5) => 0.0242842213, -0.0020576657), 
(nf_Source_Type in ['Behavioral and Government','Bureau and Government','None']) => map(
   ( NULL < rv_L79_adls_per_apt_addr_c6 and rv_L79_adls_per_apt_addr_c6 <= 4.5) => 0.0117712743, 
   (rv_L79_adls_per_apt_addr_c6 > 4.5) => 0.1285668328, 0.0129755296), -0.0007439954);

// Tree: 194
final_score_194 := map(
( NULL < nf_fp_srchssnsrchcountwk and nf_fp_srchssnsrchcountwk <= 1.5) => map(
   ( NULL < rv_I60_inq_hiRiskCred_count12 and rv_I60_inq_hiRiskCred_count12 <= 6.5) => -0.0001525433, 
   (rv_I60_inq_hiRiskCred_count12 > 6.5) => 0.0159292075, 0.0015002624), 
(nf_fp_srchssnsrchcountwk > 1.5) => map(
   ( NULL < nf_average_rel_income and nf_average_rel_income <= 70500) => -0.0188991901, 
   (nf_average_rel_income > 70500) => 0.0122381678, -0.0073975145), 0.0009750786);

// Tree: 195
final_score_195 := map(
( NULL < nf_mos_foreclosure_lseen and nf_mos_foreclosure_lseen <= 33.5) => map(
   (rv_D32_criminal_x_felony in ['0-0','1-1','2-1','3-2']) => -0.0026097988, 
   (rv_D32_criminal_x_felony in ['1-0','2-0','2-2','3-0','3-1','3-3']) => map(
      ( NULL < nf_fp_varmsrcssnunrelcount and nf_fp_varmsrcssnunrelcount <= 0.5) => 0.0870205423, 
      (nf_fp_varmsrcssnunrelcount > 0.5) => 0.0062160309, 0.0075800370), 0.0001728987), 
(nf_mos_foreclosure_lseen > 33.5) => -0.0330740468, -0.0010487862);

// Tree: 196
final_score_196 := map(
( NULL < nf_hh_collections_ct and nf_hh_collections_ct <= 7.5) => map(
   ( NULL < rv_L79_adls_per_addr_curr and rv_L79_adls_per_addr_curr <= 2.5) => -0.0097035650, 
   (rv_L79_adls_per_addr_curr > 2.5) => 0.0016457319, -0.0023317322), 
(nf_hh_collections_ct > 7.5) => map(
   ( NULL < nf_fp_srchcomponentrisktype and nf_fp_srchcomponentrisktype <= 4.5) => 0.0310087213, 
   (nf_fp_srchcomponentrisktype > 4.5) => 0.1469942963, 0.0507229834), -0.0020906830);

// Tree: 197
final_score_197 := map(
( NULL < nf_phone_ver_insurance and nf_phone_ver_insurance <= 1.5) => -0.0570911335, 
(nf_phone_ver_insurance > 1.5) => map(
   ( NULL < iv_inp_add_avm_chg_1yr and iv_inp_add_avm_chg_1yr <= -12790.5) => map(
      ( NULL < nf_fp_srchaddrsrchcountwk and nf_fp_srchaddrsrchcountwk <= 0.5) => 0.0113341424, 
      (nf_fp_srchaddrsrchcountwk > 0.5) => 0.0643332891, 0.0179926108), 
   (iv_inp_add_avm_chg_1yr > -12790.5) => -0.0040629246, 0.0032315480), 0.0004206039);

// Tree: 198
final_score_198 := map(
(nf_fp_addrchangeecontraj in ['AB','BA','BC','BU','CA','CE','CF','DB','DC','EA','EB','EC','ED','FA','FC','FU','UC','UE','UU']) => -0.0405597131, 
(nf_fp_addrchangeecontraj in ['-1','AA','AC','AD','AE','AF','AU','BB','BD','BE','BF','CB','CC','CD','CU','DA','DD','DE','DF','DU','EE','EF','EU','FB','FD','FE','FF','UD','UF']) => map(
   ( NULL < rv_F01_inp_addr_address_score and rv_F01_inp_addr_address_score <= 95) => map(
      ( NULL < nf_fp_srchssnsrchcountmo and nf_fp_srchssnsrchcountmo <= 6.5) => 0.0171766221, 
      (nf_fp_srchssnsrchcountmo > 6.5) => 0.0880051615, 0.0186355003), 
   (rv_F01_inp_addr_address_score > 95) => 0.0000160980, 0.0009618485), 0.0003194953);

// Tree: 199
final_score_199 := map(
( NULL < nf_add_curr_nhood_SFD_pct and nf_add_curr_nhood_SFD_pct <= 0.17960076495) => map(
   ( NULL < nf_fp_srchfraudsrchcountmo and nf_fp_srchfraudsrchcountmo <= 7.5) => -0.0187540362, 
   (nf_fp_srchfraudsrchcountmo > 7.5) => map(
      (rv_4seg_RiskView_5_0 in ['2 DEROG','3 OWNER']) => -0.0447706272, 
      (rv_4seg_RiskView_5_0 in ['0 TRUEDID = 0','1 VER/VAL PROBLEMS','4 OTHER']) => 0.1653662003, 0.0547678700), -0.0174440179), 
(nf_add_curr_nhood_SFD_pct > 0.17960076495) => 0.0017806942, 0.0001960972);

// Tree: 200
final_score_200 := map(
( NULL < nf_util_adl_count and nf_util_adl_count <= 5.5) => map(
   ( NULL < rv_C13_max_lres and rv_C13_max_lres <= 19.5) => -0.0528565810, 
   (rv_C13_max_lres > 19.5) => map(
      (iv_Phn_Addr_Verified in ['1 INF ONLY','2 NAP ONLY','3 BOTH VERD']) => -0.0068129739, 
      (iv_Phn_Addr_Verified in ['0 NONE VERD']) => 0.0088426130, -0.0036088156), -0.0040180440), 
(nf_util_adl_count > 5.5) => 0.0085122482, -0.0002024433);

// Tree: 201
final_score_201 := map(
( NULL < iv_dob_src_ct and iv_dob_src_ct <= 16.5) => map(
   ( NULL < rv_I60_inq_auto_count12 and rv_I60_inq_auto_count12 <= 2.5) => 0.0009124813, 
   (rv_I60_inq_auto_count12 > 2.5) => -0.0155298666, -0.0005708755), 
(iv_dob_src_ct > 16.5) => map(
   ( NULL < nf_fp_srchphonesrchcountwk and nf_fp_srchphonesrchcountwk <= 1.5) => 0.0267080541, 
   (nf_fp_srchphonesrchcountwk > 1.5) => 0.1186558551, 0.0310127264), -0.0136237885);

// Tree: 202
final_score_202 := map(
(nf_util_add_curr_summary in ['|   |','| C |','|I  |','|I M|','|ICM|']) => -0.0064500082, 
(nf_util_add_curr_summary in ['|  M|','| CM|','|IC |']) => map(
   (nf_fp_addrchangeecontraj in ['AC','AE','AF','BE','BF','BU','CA','CB','DA','DU','EA','EU','FA','FD','FU','UC','UD','UE','UU']) => -0.0644520978, 
   (nf_fp_addrchangeecontraj in ['-1','AA','AB','AD','AU','BA','BB','BC','BD','CC','CD','CE','CF','CU','DB','DC','DD','DE','DF','EB','EC','ED','EE','EF','FB','FC','FE','FF','UF']) => map(
      ( NULL < nf_fp_srchphonesrchcountwk and nf_fp_srchphonesrchcountwk <= 5.5) => 0.0047827170, 
      (nf_fp_srchphonesrchcountwk > 5.5) => 0.0631845565, 0.0048841567), 0.0043471132), 0.0004026979);

// Tree: 203
final_score_203 := map(
( NULL < nf_fp_srchvelocityrisktype and nf_fp_srchvelocityrisktype <= 1.5) => map(
   ( NULL < nf_fp_curraddrmedianincome and nf_fp_curraddrmedianincome <= 99711) => map(
      ( NULL < rv_C12_source_profile and rv_C12_source_profile <= 21.15) => 0.1154805774, 
      (rv_C12_source_profile > 21.15) => 0.0100132087, 0.0225427807), 
   (nf_fp_curraddrmedianincome > 99711) => 0.2314807983, 0.0360662770), 
(nf_fp_srchvelocityrisktype > 1.5) => -0.0012440723, -0.0007988895);

// Tree: 204
final_score_204 := map(
(nf_fp_addrchangeecontraj in ['AE','BC','BD','BF','BU','CA','CB','CF','EA','ED','FD','UC','UE','UF','UU']) => -0.0434768209, 
(nf_fp_addrchangeecontraj in ['-1','AA','AB','AC','AD','AF','AU','BA','BB','BE','CC','CD','CE','CU','DA','DB','DC','DD','DE','DF','DU','EB','EC','EE','EF','EU','FA','FB','FC','FE','FF','FU','UD']) => map(
   ( NULL < iv_Phn_PCS and iv_Phn_PCS <= 0.5) => 0.0036873224, 
   (iv_Phn_PCS > 0.5) => map(
      ( NULL < nf_inq_per_sfd_addr and nf_inq_per_sfd_addr <= 28.5) => -0.0087428154, 
      (nf_inq_per_sfd_addr > 28.5) => -0.0758430748, -0.0092166037), -0.0357079481), 0.0003911324);

// Tree: 205
final_score_205 := map(
( NULL < iv_br_source_count and iv_br_source_count <= 8.5) => map(
   ( NULL < iv_Estimated_Income and iv_Estimated_Income <= 140500) => 0.0012703570, 
   (iv_Estimated_Income > 140500) => map(
      ( NULL < rv_I60_inq_hiRiskCred_recency and rv_I60_inq_hiRiskCred_recency <= 0.5) => 0.1870911939, 
      (rv_I60_inq_hiRiskCred_recency > 0.5) => 0.0218660255, 0.0561200238), 0.0014441510), 
(iv_br_source_count > 8.5) => 0.1549473023, 0.0015468948);

// Tree: 206
final_score_206 := map(
( NULL < nf_hh_workers_paw and nf_hh_workers_paw <= 2.5) => map(
   ( NULL < nf_inq_per_apt_addr and nf_inq_per_apt_addr <= 7.5) => -0.0012590998, 
   (nf_inq_per_apt_addr > 7.5) => 0.0199387856, -0.0005324107), 
(nf_hh_workers_paw > 2.5) => map(
   (rv_D32_criminal_x_felony in ['0-0','1-0','2-0','2-2','3-0','3-1','3-2']) => 0.0156396016, 
   (rv_D32_criminal_x_felony in ['1-1','2-1','3-3']) => 0.1180205940, 0.0166361222), 0.0009433261);

// Tree: 207
final_score_207 := map(
(iv_curr_add_mortgage_type in ['GOVERNMENT','OTHER']) => map(
   ( NULL < nf_fp_srchssnsrchcountday and nf_fp_srchssnsrchcountday <= 1.5) => -0.0212741975, 
   (nf_fp_srchssnsrchcountday > 1.5) => -0.0933073391, -0.0220651910), 
(iv_curr_add_mortgage_type in ['COMMERCIAL','CONVENTIONAL','NO MORTGAGE','NON-TRADITIONAL','UNKNOWN']) => map(
   ( NULL < rv_I62_inq_phones_per_adl and rv_I62_inq_phones_per_adl <= 6.5) => 0.0007052702, 
   (rv_I62_inq_phones_per_adl > 6.5) => 0.0953879534, 0.0007708172), -0.0008352782);

// Tree: 208
final_score_208 := map(
( NULL < iv_mos_src_voter_adl_lseen and iv_mos_src_voter_adl_lseen <= 123.5) => -0.0014600818, 
(iv_mos_src_voter_adl_lseen > 123.5) => map(
   (rv_D32_criminal_x_felony in ['0-0','1-0','2-0','2-1','3-2','3-3']) => 0.0201685865, 
   (rv_D32_criminal_x_felony in ['1-1','2-2','3-0','3-1']) => map(
      ( NULL < rv_D32_Mos_Since_Crim_LS and rv_D32_Mos_Since_Crim_LS <= 35.5) => 0.2324551242, 
      (rv_D32_Mos_Since_Crim_LS > 35.5) => 0.0563911420, 0.0983880552), 0.0308795439), -0.0007974050);

// Tree: 209
final_score_209 := map(
( NULL < nf_hh_age_65_plus and nf_hh_age_65_plus <= 0.5) => -0.0016803359, 
(nf_hh_age_65_plus > 0.5) => map(
   ( NULL < nf_inq_Collection_count_week and nf_inq_Collection_count_week <= 0.5) => 0.0104408800, 
   (nf_inq_Collection_count_week > 0.5) => map(
      ( NULL < rv_C13_max_lres and rv_C13_max_lres <= 186) => 0.1974376140, 
      (rv_C13_max_lres > 186) => 0.0030881173, 0.1021682529), 0.0110565809), 0.0008109140);

// Tree: 210
final_score_210 := map(
( NULL < nf_inq_Auto_count_week and nf_inq_Auto_count_week <= 2.5) => map(
   ( NULL < nf_fp_srchfraudsrchcountmo and nf_fp_srchfraudsrchcountmo <= 12.5) => -0.0014643610, 
   (nf_fp_srchfraudsrchcountmo > 12.5) => map(
      ( NULL < nf_inq_count24 and nf_inq_count24 <= 11.5) => 0.1004497645, 
      (nf_inq_count24 > 11.5) => -0.0113640045, 0.0518749304), -0.0013804564), 
(nf_inq_Auto_count_week > 2.5) => -0.0712591373, -0.0015027776);

// Tree: 211
final_score_211 := map(
( NULL < rv_F01_inp_addr_address_score and rv_F01_inp_addr_address_score <= 95) => map(
   (nf_fp_addrchangeecontraj in ['-1','AA','BA','BD','BU','CA','CB','CD','CF','CU','DA','DC','DU','EA','EB','ED','EU','FA','FC','FD','UC','UD','UE','UF','UU']) => -0.0085399411, 
   (nf_fp_addrchangeecontraj in ['AB','AC','AD','AE','AF','AU','BB','BC','BE','BF','CC','CE','DB','DD','DE','DF','EC','EE','EF','FB','FE','FF','FU']) => map(
      ( NULL < nf_fp_addrchangevaluediff and nf_fp_addrchangevaluediff <= 115698.5) => 0.0231380108, 
      (nf_fp_addrchangevaluediff > 115698.5) => 0.1246567476, 0.0287836781), 0.0163284170), 
(rv_F01_inp_addr_address_score > 95) => -0.0013623552, -0.0003542003);

// Tree: 212
final_score_212 := map(
( NULL < iv_dob_src_ct and iv_dob_src_ct <= 15.5) => map(
   ( NULL < rv_I60_Inq_Count12 and rv_I60_Inq_Count12 <= 12.5) => 0.0001426577, 
   (rv_I60_Inq_Count12 > 12.5) => -0.0243157350, -0.0004327895), 
(iv_dob_src_ct > 15.5) => 0.0212377260, map(
   (rv_E58_br_dead_bus_x_active_phn in ['0-0','0-1','0-2','0-3','1-1','2-1','2-3','3-1','3-2']) => -0.0176094856, 
   (rv_E58_br_dead_bus_x_active_phn in ['1-0','1-2','1-3','2-0','2-2','3-0','3-3']) => 0.1348142784, -0.0134441079));

// Tree: 213
final_score_213 := map(
( NULL < nf_pct_rel_prop_sold and nf_pct_rel_prop_sold <= 0.0574175824) => map(
   ( NULL < nf_pct_rel_prop_owned and nf_pct_rel_prop_owned <= 0.2435728411) => map(
      ( NULL < rv_I60_inq_recency and rv_I60_inq_recency <= 0.5) => 0.1047287677, 
      (rv_I60_inq_recency > 0.5) => 0.0165173880, 0.0180194208), 
   (nf_pct_rel_prop_owned > 0.2435728411) => -0.0003325104, 0.0060385067), 
(nf_pct_rel_prop_sold > 0.0574175824) => -0.0042583822, -0.0014559469);

// Tree: 214
final_score_214 := map(
(iv_D34_liens_unrel_x_rel in ['0-0','0-2','1-0','1-1','1-2','2-1','2-2','3-2']) => map(
   ( NULL < iv_addr_non_phn_src_ct and iv_addr_non_phn_src_ct <= 2.5) => map(
      ( NULL < nf_pct_rel_with_bk and nf_pct_rel_with_bk <= 0.1856158484) => 0.0251762432, 
      (nf_pct_rel_with_bk > 0.1856158484) => -0.0068560373, 0.0127986217), 
   (iv_addr_non_phn_src_ct > 2.5) => -0.0030328828, -0.0015876899), 
(iv_D34_liens_unrel_x_rel in ['0-1','2-0','3-0','3-1']) => 0.0138669316, 0.0002324901);

// Tree: 215
final_score_215 := map(
( NULL < rv_D33_eviction_count and rv_D33_eviction_count <= 10.5) => -0.0002451983, 
(rv_D33_eviction_count > 10.5) => map(
   ( NULL < rv_C14_addrs_15yr and rv_C14_addrs_15yr <= 7.5) => -0.0001873254, 
   (rv_C14_addrs_15yr > 7.5) => map(
      (iv_D34_liens_unrel_x_rel in ['0-0','0-1','0-2','1-0','2-1','2-2','3-0']) => 0.0467144127, 
      (iv_D34_liens_unrel_x_rel in ['1-1','1-2','2-0','3-1','3-2']) => 0.2530162908, 0.1305769648), 0.0616742427), -0.0000379952);

// Tree: 216
final_score_216 := map(
( NULL < nf_phones_per_addr_c6 and nf_phones_per_addr_c6 <= 0.5) => -0.0026218641, 
(nf_phones_per_addr_c6 > 0.5) => map(
   ( NULL < rv_I60_inq_comm_recency and rv_I60_inq_comm_recency <= 61.5) => 0.0031221993, 
   (rv_I60_inq_comm_recency > 61.5) => map(
      ( NULL < iv_Phn_Cell and iv_Phn_Cell <= 0.5) => 0.0001467169, 
      (iv_Phn_Cell > 0.5) => 0.0380668685, 0.0213163304), 0.0070795115), 0.0003901478);

// Tree: 217
final_score_217 := map(
( NULL < nf_hh_age_30_plus and nf_hh_age_30_plus <= 2.5) => -0.0036574580, 
(nf_hh_age_30_plus > 2.5) => map(
   (nf_fp_addrchangeecontraj in ['-1','AA','AB','AC','BA','BB','BD','BF','BU','CA','CB','CC','CD','CF','CU','DB','DC','DD','DE','DF','EA','EB','EC','ED','EE','EF','EU','FB','FC','FD','FE','FF','FU','UE','UU']) => map(
      ( NULL < nf_inq_Other_count_week and nf_inq_Other_count_week <= 2.5) => 0.0070011646, 
      (nf_inq_Other_count_week > 2.5) => 0.0760177962, 0.0072576443), 
   (nf_fp_addrchangeecontraj in ['AD','AE','AF','AU','BC','BE','CE','DA','DU','FA','UC','UD','UF']) => 0.1936470409, 0.0077103542), -0.0002239100);

// Tree: 218
final_score_218 := map(
( NULL < nf_hh_payday_loan_users and nf_hh_payday_loan_users <= 1.5) => -0.0015876079, 
(nf_hh_payday_loan_users > 1.5) => map(
   ( NULL < nf_mos_acc_lseen and nf_mos_acc_lseen <= 48.5) => map(
      ( NULL < nf_add_input_nhood_VAC_pct and nf_add_input_nhood_VAC_pct <= 0.09598145365) => 0.0453325049, 
      (nf_add_input_nhood_VAC_pct > 0.09598145365) => -0.0339971792, 0.0333307421), 
   (nf_mos_acc_lseen > 48.5) => -0.0766214375, 0.0232270283), -0.0008785453);

// Tree: 219
final_score_219 := map(
( NULL < nf_fp_srchaddrsrchcountday and nf_fp_srchaddrsrchcountday <= 3.5) => map(
   ( NULL < nf_phone_ver_insurance and nf_phone_ver_insurance <= 1.5) => -0.0532889849, 
   (nf_phone_ver_insurance > 1.5) => 0.0001782056, -0.0002998822), 
(nf_fp_srchaddrsrchcountday > 3.5) => map(
   ( NULL < nf_inq_count24 and nf_inq_count24 <= 5.5) => -0.0019171748, 
   (nf_inq_count24 > 5.5) => -0.1000991598, -0.0483688667), -0.0004149686);

// Tree: 220
final_score_220 := map(
( NULL < nf_inq_Collection_count24 and nf_inq_Collection_count24 <= 3.5) => map(
   ( NULL < nf_add_input_nhood_BUS_pct and nf_add_input_nhood_BUS_pct <= 0.1415581487) => map(
      ( NULL < nf_fp_curraddrcartheftindex and nf_fp_curraddrcartheftindex <= 23.5) => 0.0147507512, 
      (nf_fp_curraddrcartheftindex > 23.5) => -0.0020715497, -0.0000192478), 
   (nf_add_input_nhood_BUS_pct > 0.1415581487) => -0.0137369983, -0.0016575978), 
(nf_inq_Collection_count24 > 3.5) => 0.0249792143, -0.0007271350);

// Tree: 221
final_score_221 := map(
( NULL < nf_phones_per_addr_c6 and nf_phones_per_addr_c6 <= 2.5) => -0.0003175167, 
(nf_phones_per_addr_c6 > 2.5) => map(
   ( NULL < iv_src_drivers_lic_adl_count and iv_src_drivers_lic_adl_count <= 0.5) => -0.0012280517, 
   (iv_src_drivers_lic_adl_count > 0.5) => map(
      ( NULL < iv_unverified_addr_count and iv_unverified_addr_count <= 2.5) => -0.0056933843, 
      (iv_unverified_addr_count > 2.5) => 0.0518041842, 0.0349445276), 0.0137950134), 0.0007475388);

// Tree: 222
final_score_222 := map(
( NULL < nf_fp_srchaddrsrchcountmo and nf_fp_srchaddrsrchcountmo <= 8.5) => -0.0005020866, 
(nf_fp_srchaddrsrchcountmo > 8.5) => map(
   ( NULL < nf_inq_count24 and nf_inq_count24 <= 10.5) => map(
      (rv_D32_criminal_x_felony in ['1-0','2-0','3-0','3-1','3-3']) => -0.0577292289, 
      (rv_D32_criminal_x_felony in ['0-0','1-1','2-1','2-2','3-2']) => 0.0246002499, -0.0012390887), 
   (nf_inq_count24 > 10.5) => -0.0723447296, -0.0236046612), -0.0007025105);

// Tree: 223
final_score_223 := map(
( NULL < nf_add_input_mobility_index and nf_add_input_mobility_index <= 0.9737821013) => map(
   (nf_fp_addrchangeecontraj in ['AB','AC','AD','AE','AF','BU','CA','DU','EU','FA','FC','UC','UE','UF','UU']) => -0.0744978211, 
   (nf_fp_addrchangeecontraj in ['-1','AA','AU','BA','BB','BC','BD','BE','BF','CB','CC','CD','CE','CF','CU','DA','DB','DC','DD','DE','DF','EA','EB','EC','ED','EE','EF','FB','FD','FE','FF','FU','UD']) => map(
      ( NULL < nf_average_rel_income and nf_average_rel_income <= 119500) => -0.0013281173, 
      (nf_average_rel_income > 119500) => 0.0910439996, -0.0010643751), -0.0012999701), 
(nf_add_input_mobility_index > 0.9737821013) => -0.0741115457, -0.0016579738);

// Tree: 224
final_score_224 := map(
(nf_fp_addrchangeecontraj in ['AC','AF','BD','BF','BU','CA','CE','CF','DA','DU','EA','EB','EF','EU','FC','FE','UC','UE','UU']) => -0.0401584846, 
(nf_fp_addrchangeecontraj in ['-1','AA','AB','AD','AE','AU','BA','BB','BC','BE','CB','CC','CD','CU','DB','DC','DD','DE','DF','EC','ED','EE','FA','FB','FD','FF','FU','UD','UF']) => map(
   ( NULL < nf_fp_srchphonesrchcountmo and nf_fp_srchphonesrchcountmo <= 0.5) => -0.0038465435, 
   (nf_fp_srchphonesrchcountmo > 0.5) => map(
      ( NULL < nf_fp_srchssnsrchcountmo and nf_fp_srchssnsrchcountmo <= 0.5) => 0.0550511763, 
      (nf_fp_srchssnsrchcountmo > 0.5) => 0.0045995527, 0.0072072491), -0.0003418380), -0.0010690382);

// Tree: 225
final_score_225 := map(
( NULL < rv_C20_M_Bureau_ADL_FS and rv_C20_M_Bureau_ADL_FS <= 329.5) => map(
   (rv_E58_br_dead_bus_x_active_phn in ['0-0','0-1','0-2','0-3','1-0','1-1','1-2','2-0','2-2','3-1','3-2']) => 0.0019166138, 
   (rv_E58_br_dead_bus_x_active_phn in ['1-3','2-1','2-3','3-0','3-3']) => map(
      ( NULL < nf_inq_per_phone and nf_inq_per_phone <= 3.5) => 0.0409689871, 
      (nf_inq_per_phone > 3.5) => 0.2418089112, 0.1083026032), 0.0022086419), 
(rv_C20_M_Bureau_ADL_FS > 329.5) => -0.0140023927, -0.0008524571);

// Tree: 226
final_score_226 := map(
( NULL < nf_fp_prevaddrageoldest and nf_fp_prevaddrageoldest <= 0) => -0.0751814582, 
(nf_fp_prevaddrageoldest > 0) => map(
   ( NULL < nf_fp_prevaddrmedianvalue and nf_fp_prevaddrmedianvalue <= 533922) => map(
      ( NULL < iv_fname_non_phn_src_ct and iv_fname_non_phn_src_ct <= 8.5) => 0.0070261929, 
      (iv_fname_non_phn_src_ct > 8.5) => -0.0010653711, 0.0021771376), 
   (nf_fp_prevaddrmedianvalue > 533922) => -0.0193839766, 0.0005114220), 0.0003341028);

// Tree: 227
final_score_227 := map(
(nf_fp_addrchangeecontraj in ['BA','BD','CA','CB','DF','EA','EB','UC','UE','UU']) => -0.0571398324, 
(nf_fp_addrchangeecontraj in ['-1','AA','AB','AC','AD','AE','AF','AU','BB','BC','BE','BF','BU','CC','CD','CE','CF','CU','DA','DB','DC','DD','DE','DU','EC','ED','EE','EF','EU','FA','FB','FC','FD','FE','FF','FU','UD','UF']) => map(
   ( NULL < rv_F01_inp_addr_address_score and rv_F01_inp_addr_address_score <= 16) => map(
      (nf_fp_addrchangeecontraj in ['-1','AA','AC','AD','AF','BB','CC','CF','CU','DA','DC','DD','DE','ED','EE','FA','FD','FE']) => 0.0130685601, 
      (nf_fp_addrchangeecontraj in ['AB','AE','AU','BA','BC','BD','BE','BF','BU','CA','CB','CD','CE','DB','DF','DU','EA','EB','EC','EF','EU','FB','FC','FF','FU','UC','UD','UE','UF','UU']) => 0.0731532507, 0.0347818577), 
   (rv_F01_inp_addr_address_score > 16) => 0.0002971748, 0.0008549147), 0.0004757275);

// Tree: 228
final_score_228 := map(
( NULL < nf_inq_Other_count24 and nf_inq_Other_count24 <= 18.5) => -0.0005387961, 
(nf_inq_Other_count24 > 18.5) => map(
   ( NULL < nf_M_Bureau_ADL_FS_noTU and nf_M_Bureau_ADL_FS_noTU <= 301.5) => map(
      ( NULL < nf_pct_rel_prop_owned and nf_pct_rel_prop_owned <= 0.4142156863) => 0.0091315142, 
      (nf_pct_rel_prop_owned > 0.4142156863) => 0.1581839209, 0.0920314483), 
   (nf_M_Bureau_ADL_FS_noTU > 301.5) => -0.0239098000, 0.0425557143), -0.0001943240);

// Tree: 229
final_score_229 := map(
( NULL < nf_add_input_nhood_VAC_pct and nf_add_input_nhood_VAC_pct <= 0.08090251265) => -0.0000887628, 
(nf_add_input_nhood_VAC_pct > 0.08090251265) => map(
   ( NULL < rv_comb_age and rv_comb_age <= 20.5) => -0.0736524410, 
   (rv_comb_age > 20.5) => map(
      ( NULL < rv_comb_age and rv_comb_age <= 24.5) => 0.0203365257, 
      (rv_comb_age > 24.5) => -0.0142478949, -0.0120325627), -0.0125281782), -0.0020794087);

// Tree: 230
final_score_230 := map(
( NULL < rv_D30_Derog_Count and rv_D30_Derog_Count <= 14.5) => 0.0001404205, 
(rv_D30_Derog_Count > 14.5) => map(
   ( NULL < iv_A46_L77_addrs_move_traj and iv_A46_L77_addrs_move_traj <= 6.5) => -0.0032888185, 
   (iv_A46_L77_addrs_move_traj > 6.5) => map(
      ( NULL < rv_C20_M_Bureau_ADL_FS and rv_C20_M_Bureau_ADL_FS <= 240.5) => 0.1555433441, 
      (rv_C20_M_Bureau_ADL_FS > 240.5) => 0.0455164793, 0.0681410511), 0.0264146917), 0.0005161392);

// Tree: 231
final_score_231 := map(
( NULL < nf_acc_damage_amt_total and nf_acc_damage_amt_total <= 5.5) => map(
   ( NULL < nf_inq_per_phone and nf_inq_per_phone <= 30.5) => 0.0021999611, 
   (nf_inq_per_phone > 30.5) => map(
      ( NULL < rv_I60_inq_recency and rv_I60_inq_recency <= 2) => 0.0043039518, 
      (rv_I60_inq_recency > 2) => 0.2350301326, 0.0739313791), -0.1065825516), 
			nf_acc_damage_amt_total = (Unsigned)NULL => 0.0009314682,
(nf_acc_damage_amt_total > 5.5) => -0.0409933738, 0.0009314682);

// Tree: 232
final_score_232 := map(
( NULL < nf_inq_Communications_count24 and nf_inq_Communications_count24 <= 2.5) => 0.0006655484, 
(nf_inq_Communications_count24 > 2.5) => map(
   ( NULL < iv_dob_src_ct and iv_dob_src_ct <= 12.5) => map(
      ( NULL < nf_inq_per_ssn and nf_inq_per_ssn <= 2.5) => 0.0855186057, 
      (nf_inq_per_ssn > 2.5) => -0.0031395374, 0.0174198125), 
   (iv_dob_src_ct > 12.5) => 0.0626053233, -0.0373869675), 0.0013584189);

// Tree: 233
final_score_233 := map(
(nf_fp_addrchangeecontraj in ['-1','AA','AC','AF','BA','BB','BC','BD','BE','BU','CA','CB','CC','CD','CE','CF','DA','DB','DC','DD','DE','DF','EA','EB','EC','ED','EE','EF','EU','FA','FC','FD','FE','FF','FU','UC','UE','UU']) => map(
   ( NULL < rv_C14_addrs_10yr and rv_C14_addrs_10yr <= 3.5) => -0.0025592351, 
   (rv_C14_addrs_10yr > 3.5) => map(
      ( NULL < iv_addr_non_phn_src_ct and iv_addr_non_phn_src_ct <= 2.5) => 0.0188894876, 
      (iv_addr_non_phn_src_ct > 2.5) => 0.0044746810, 0.0063201419), 0.0008695112), 
(nf_fp_addrchangeecontraj in ['AB','AD','AE','AU','BF','CU','DU','FB','UD','UF']) => 0.0922859217, 0.0009954097);

// Tree: 234
final_score_234 := map(
( NULL < nf_fp_curraddrmedianincome and nf_fp_curraddrmedianincome <= 149975) => -0.0008675709, 
(nf_fp_curraddrmedianincome > 149975) => map(
   ( NULL < nf_hh_lienholders and nf_hh_lienholders <= 0.5) => map(
      ( NULL < iv_C13_avg_lres and iv_C13_avg_lres <= 60.5) => 0.0331687503, 
      (iv_C13_avg_lres > 60.5) => 0.3255586795, 0.1724020499), 
   (nf_hh_lienholders > 0.5) => -0.0101956740, 0.0693593509), -0.0006497415);

// Tree: 235
final_score_235 := map(
( NULL < rv_I60_inq_recency and rv_I60_inq_recency <= 0.5) => map(
   ( NULL < nf_average_rel_distance and nf_average_rel_distance <= 30.5) => map(
      (nf_fp_addrchangeecontraj in ['-1','BC','CE','DD','DF','EE','EF']) => 0.0479879061, 
      (nf_fp_addrchangeecontraj in ['AA','AB','AC','AD','AE','AF','AU','BA','BB','BD','BE','BF','BU','CA','CB','CC','CD','CF','CU','DA','DB','DC','DE','DU','EA','EB','EC','ED','EU','FA','FB','FC','FD','FE','FF','FU','UC','UD','UE','UF','UU']) => 0.1966732089, 0.1058546185), 
   (nf_average_rel_distance > 30.5) => 0.0171667019, 0.0359823723), 
(rv_I60_inq_recency > 0.5) => -0.0006645843, -0.0002532660);

// Tree: 236
final_score_236 := map(
( NULL < nf_fp_prevaddrageoldest and nf_fp_prevaddrageoldest <= 5.5) => map(
   ( NULL < nf_fp_srchssnsrchcountmo and nf_fp_srchssnsrchcountmo <= 1.5) => -0.0082455982, 
   (nf_fp_srchssnsrchcountmo > 1.5) => map(
      (nf_historic_x_current_ct in ['0-0','1-0','1-1','2-0','2-1','2-2','3-0','3-2','3-3']) => -0.0391502155, 
      (nf_historic_x_current_ct in ['3-1']) => 0.0585074054, -0.0334629996), -0.0158064155), 
(nf_fp_prevaddrageoldest > 5.5) => 0.0006920827, -0.0001592266);

// Tree: 237
final_score_237 := map(
( NULL < rv_D32_criminal_count and rv_D32_criminal_count <= 19.5) => map(
   (iv_D34_liens_unrel_x_rel in ['0-1','0-2','1-1','2-1','3-0','3-1']) => map(
      ( NULL < rv_F00_input_dob_match_level and rv_F00_input_dob_match_level <= 4.5) => 0.1516033007, 
      (rv_F00_input_dob_match_level > 4.5) => -0.0104898206, -0.0304867177), 
   (iv_D34_liens_unrel_x_rel in ['0-0','1-0','1-2','2-0','2-2','3-2']) => 0.0019013539, -0.0000804978), 
(rv_D32_criminal_count > 19.5) => -0.0700912047, -0.0001679053);

// Tree: 238
final_score_238 := map(
( NULL < nf_fp_srchvelocityrisktype and nf_fp_srchvelocityrisktype <= 1.5) => map(
   ( NULL < rv_comb_age and rv_comb_age <= 41.5) => 0.0008381734, 
   (rv_comb_age > 41.5) => map(
      ( NULL < iv_inp_add_avm_pct_chg_3yr and iv_inp_add_avm_pct_chg_3yr <= 1.26700305885) => 0.2874557845, 
      (iv_inp_add_avm_pct_chg_3yr > 1.26700305885) => 0.0600028327, 0.0527886446), 0.0381912100), 
(nf_fp_srchvelocityrisktype > 1.5) => -0.0006287450, -0.0001675425);

// Tree: 239
final_score_239 := map(
( NULL < nf_historical_count and nf_historical_count <= 7.5) => map(
   ( NULL < rv_I60_inq_auto_recency and rv_I60_inq_auto_recency <= 9) => 0.0022250739, 
   (rv_I60_inq_auto_recency > 9) => -0.0089851125, -0.0023364276), 
(nf_historical_count > 7.5) => map(
   ( NULL < nf_inq_per_phone and nf_inq_per_phone <= 16.5) => 0.0154858947, 
   (nf_inq_per_phone > 16.5) => -0.0471462607, 0.0140862935), -0.0003651008);

// Tree: 240
final_score_240 := map(
(nf_fp_addrchangeecontraj in ['AB','AD','AE','AF','BD','CA','CU','DA','DB','EA','FC','FD','UC','UD','UE','UF','UU']) => -0.0587747655, 
(nf_fp_addrchangeecontraj in ['-1','AA','AC','AU','BA','BB','BC','BE','BF','BU','CB','CC','CD','CE','CF','DC','DD','DE','DF','DU','EB','EC','ED','EE','EF','EU','FA','FB','FE','FF','FU']) => map(
   ( NULL < nf_inq_Other_count24 and nf_inq_Other_count24 <= 0.5) => 0.0146704650, 
   (nf_inq_Other_count24 > 0.5) => map(
      ( NULL < nf_inq_HighRiskCredit_count24 and nf_inq_HighRiskCredit_count24 <= 1.5) => -0.0119946490, 
      (nf_inq_HighRiskCredit_count24 > 1.5) => 0.0028015258, -0.0027374138), 0.0003483302), -0.0001265358);

// Tree: 241
final_score_241 := map(
(rv_D31_MostRec_Bk in ['0 - NO BK','2 - BK DISCHARGED','3 - BK OTHER']) => -0.0014939598, 
(rv_D31_MostRec_Bk in ['1 - BK DISMISSED']) => map(
   ( NULL < iv_inp_add_avm_chg_2yr and iv_inp_add_avm_chg_2yr <= 21578) => 0.0676102476, 
   (iv_inp_add_avm_chg_2yr > 21578) => -0.0258308422, map(
      ( NULL < nf_average_rel_home_val and nf_average_rel_home_val <= 97500) => 0.2039273714, 
      (nf_average_rel_home_val > 97500) => 0.0183920800, 0.0262271852)), -0.0007630528);

// Tree: 242
final_score_242 := map(
( NULL < rv_C19_Add_Prison_Hist and rv_C19_Add_Prison_Hist <= 0.5) => map(
   ( NULL < rv_L79_adls_per_addr_c6 and rv_L79_adls_per_addr_c6 <= 8.5) => 0.0012782512, 
   (rv_L79_adls_per_addr_c6 > 8.5) => -0.0519145260, 0.0010406731), 
(rv_C19_Add_Prison_Hist > 0.5) => map(
   ( NULL < iv_prv_addr_lres and iv_prv_addr_lres <= 67.5) => 0.1252434189, 
   (iv_prv_addr_lres > 67.5) => -0.0107392710, 0.0569204089), 0.0011881169);

// Tree: 243
final_score_243 := map(
( NULL < nf_inq_per_sfd_addr and nf_inq_per_sfd_addr <= 42.5) => map(
   ( NULL < nf_fp_varrisktype and nf_fp_varrisktype <= 8.5) => -0.0003489778, 
   (nf_fp_varrisktype > 8.5) => map(
      (nf_fp_addrchangeecontraj in ['-1','AA','BA','BC','BD','CA','CC','CF','CU','DD','DU','EB','EC','EF','FC','FD','FE','FF','FU','UF']) => 0.0038975155, 
      (nf_fp_addrchangeecontraj in ['AB','AC','AD','AE','AF','AU','BB','BE','BF','BU','CB','CD','CE','DA','DB','DC','DE','DF','EA','ED','EE','EU','FA','FB','UC','UD','UE','UU']) => 0.0769190770, 0.0210790594), -0.0000765898), 
(nf_inq_per_sfd_addr > 42.5) => -0.0639460666, -0.0001670204);

// Tree: 244
final_score_244 := map(
( NULL < nf_inq_RetailPayments_count24 and nf_inq_RetailPayments_count24 <= 0.5) => -0.0014535802, 
(nf_inq_RetailPayments_count24 > 0.5) => map(
   ( NULL < iv_Estimated_Income and iv_Estimated_Income <= 21500) => 0.1151643276, 
   (iv_Estimated_Income > 21500) => map(
      ( NULL < nf_highest_rel_home_val and nf_highest_rel_home_val <= 175) => -0.0362375297, 
      (nf_highest_rel_home_val > 175) => 0.0208573802, 0.0152444444), 0.0169240770), -0.0001590358);

// Tree: 245
final_score_245 := map(
( NULL < rv_C20_M_Bureau_ADL_FS and rv_C20_M_Bureau_ADL_FS <= 355.5) => map(
   ( NULL < nf_fp_srchfraudsrchcountmo and nf_fp_srchfraudsrchcountmo <= 10.5) => 0.0011367581, 
   (nf_fp_srchfraudsrchcountmo > 10.5) => map(
      ( NULL < nf_add_input_mobility_index and nf_add_input_mobility_index <= 0.40358747855) => 0.0623025986, 
      (nf_add_input_mobility_index > 0.40358747855) => -0.0556213821, 0.0392705711), 0.0012799417), 
(rv_C20_M_Bureau_ADL_FS > 355.5) => -0.0160102779, -0.0008377186);

// Tree: 246
final_score_246 := map(
(nf_fp_addrchangeecontraj in ['AE','BA','BC','BU','CA','DA','EA','EC','FC','UC','UE','UF']) => -0.0818659784, 
(nf_fp_addrchangeecontraj in ['-1','AA','AB','AC','AD','AF','AU','BB','BD','BE','BF','CB','CC','CD','CE','CF','CU','DB','DC','DD','DE','DF','DU','EB','ED','EE','EF','EU','FA','FB','FD','FE','FF','FU','UD','UU']) => map(
   ( NULL < nf_phone_ver_experian and nf_phone_ver_experian <= 0.5) => map(
      ( NULL < nf_inq_adls_per_phone and nf_inq_adls_per_phone <= 0.5) => 0.0264233896, 
      (nf_inq_adls_per_phone > 0.5) => -0.0005274472, -0.0824953972), 
   (nf_phone_ver_experian > 0.5) => -0.0037919848, -0.0003014037), -0.0007454597);

// Tree: 247
final_score_247 := map(
(iv_D34_liens_unrel_x_rel in ['0-1','0-2','1-1','2-1','2-2','3-2']) => -0.0131569791, 
(iv_D34_liens_unrel_x_rel in ['0-0','1-0','1-2','2-0','3-0','3-1']) => map(
   ( NULL < nf_fp_prevaddrmedianincome and nf_fp_prevaddrmedianincome <= 152395.5) => 0.0019888297, 
   (nf_fp_prevaddrmedianincome > 152395.5) => map(
      ( NULL < nf_fp_prevaddrlenofres and nf_fp_prevaddrlenofres <= 73) => 0.0084004610, 
      (nf_fp_prevaddrlenofres > 73) => 0.1916632222, 0.0834274975), 0.0021762185), -0.0003776699);

// Tree: 248
final_score_248 := map(
( NULL < nf_add_curr_nhood_SFD_pct and nf_add_curr_nhood_SFD_pct <= 0.26312546615) => -0.0135781827, 
(nf_add_curr_nhood_SFD_pct > 0.26312546615) => map(
   ( NULL < nf_attr_arrest_recency and nf_attr_arrest_recency <= 79.5) => map(
      ( NULL < nf_pct_rel_prop_sold and nf_pct_rel_prop_sold <= 0.25462962965) => 0.0166709393, 
      (nf_pct_rel_prop_sold > 0.25462962965) => 0.1527733334, 0.0522087866), 
   (nf_attr_arrest_recency > 79.5) => 0.0227121109, 0.0008349026), -0.0002833328);

// Tree: 249
final_score_249 := map(
(nf_fp_addrchangeecontraj in ['AC','AD','AF','BD','BU','CA','CB','CF','DA','DC','EA','ED','FA','FC','FD','FE','FU','UC','UE','UF','UU']) => -0.0333232356, 
(nf_fp_addrchangeecontraj in ['-1','AA','AB','AE','AU','BA','BB','BC','BE','BF','CC','CD','CE','CU','DB','DD','DE','DF','DU','EB','EC','EE','EF','EU','FB','FF','UD']) => map(
   ( NULL < iv_prv_addr_lres and iv_prv_addr_lres <= 106.5) => -0.0026049725, 
   (iv_prv_addr_lres > 106.5) => map(
      ( NULL < nf_historical_count and nf_historical_count <= 14.5) => 0.0044425745, 
      (nf_historical_count > 14.5) => 0.0608183396, 0.0058971915), -0.0194897084), -0.0010560975);

// Tree: 250
final_score_250 := map(
( NULL < nf_bus_addr_match_count and nf_bus_addr_match_count <= 0.5) => -0.0034661489, 
(nf_bus_addr_match_count > 0.5) => map(
   ( NULL < nf_inq_per_phone and nf_inq_per_phone <= 29.5) => map(
      ( NULL < rv_D30_Derog_Count and rv_D30_Derog_Count <= 19.5) => 0.0086565671, 
      (rv_D30_Derog_Count > 19.5) => 0.1138691989, 0.0091986403), 
   (nf_inq_per_phone > 29.5) => 0.1231254578, 0.0095524503), -0.0006569410);

// Tree: 251
final_score_251 := map(
( NULL < rv_P88_Phn_Dst_to_Inp_Add and rv_P88_Phn_Dst_to_Inp_Add <= 1122) => -0.0020974003, 
(rv_P88_Phn_Dst_to_Inp_Add > 1122) => -0.0200112913, map(
   (nf_fp_addrchangeecontraj in ['AB','AC','BC','BU','CA','CB','CD','CF','DA','EA','EB','EC','EU','FA','FC','FE','FU','UC','UE','UF','UU']) => -0.0680492799, 
   (nf_fp_addrchangeecontraj in ['-1','AA','AD','AE','AF','AU','BA','BB','BD','BE','BF','CC','CE','CU','DB','DC','DD','DE','DF','DU','ED','EE','EF','FB','FD','FF','UD']) => map(
      ( NULL < nf_fp_curraddrmedianincome and nf_fp_curraddrmedianincome <= 96645) => 0.0061622926, 
      (nf_fp_curraddrmedianincome > 96645) => 0.0474978509, 0.0088261644), 0.0076222529));

// Tree: 252
final_score_252 := map(
( NULL < rv_I60_credit_seeking and rv_I60_credit_seeking <= 1.5) => 0.0015643226, 
(rv_I60_credit_seeking > 1.5) => map(
   ( NULL < nf_fp_srchfraudsrchcountmo and nf_fp_srchfraudsrchcountmo <= 1.5) => 0.0031340059, 
   (nf_fp_srchfraudsrchcountmo > 1.5) => map(
      ( NULL < nf_average_rel_home_val and nf_average_rel_home_val <= 163500) => -0.0506467065, 
      (nf_average_rel_home_val > 163500) => -0.0141244655, -0.0294521062), -0.0118903991), 0.0007436741);

// Tree: 253
final_score_253 := map(
(nf_fp_addrchangeecontraj in ['-1','AA','AB','AC','BA','BB','BC','BD','BE','BF','BU','CA','CB','CC','CD','CE','CF','CU','DA','DB','DC','DD','DE','DF','DU','EA','EB','EC','ED','EE','EF','EU','FA','FC','FD','FE','FF','FU','UC','UE','UU']) => map(
   ( NULL < nf_average_rel_home_val and nf_average_rel_home_val <= 135500) => map(
      (nf_fp_addrchangeecontraj in ['-1','AA','BB','BF','CB','CC','CD','DB','DD','DE','DF','DU','EE','EF','EU','FC','FE','FF','FU','UE','UU']) => 0.0065709148, 
      (nf_fp_addrchangeecontraj in ['AB','AC','AD','AE','AF','AU','BA','BC','BD','BE','BU','CA','CE','CF','CU','DA','DC','EA','EB','EC','ED','FA','FB','FD','UC','UD','UF']) => 0.1181335841, 0.0074488060), 
   (nf_average_rel_home_val > 135500) => -0.0029690257, -0.0006329904), 
(nf_fp_addrchangeecontraj in ['AD','AE','AF','AU','FB','UD','UF']) => 0.1440578338, -0.0005380111);

// Tree: 254
final_score_254 := map(
( NULL < nf_fp_prevaddrageoldest and nf_fp_prevaddrageoldest <= 0) => -0.0807188511, 
(nf_fp_prevaddrageoldest > 0) => map(
   ( NULL < iv_inp_add_avm_chg_1yr and iv_inp_add_avm_chg_1yr <= 119919.5) => -0.0048435860, 
   (iv_inp_add_avm_chg_1yr > 119919.5) => map(
      ( NULL < nf_fp_srchunvrfdaddrcount and nf_fp_srchunvrfdaddrcount <= 0.5) => 0.0187364605, 
      (nf_fp_srchunvrfdaddrcount > 0.5) => 0.1800022592, 0.0294152898), 0.0022181388), -0.0007711111);

// Tree: 255
final_score_255 := map(
( NULL < iv_mos_src_voter_adl_lseen and iv_mos_src_voter_adl_lseen <= 87.5) => -0.0006295195, 
(iv_mos_src_voter_adl_lseen > 87.5) => map(
   ( NULL < iv_mos_src_voter_adl_lseen and iv_mos_src_voter_adl_lseen <= 88.5) => map(
      ( NULL < rv_D34_attr_liens_recency and rv_D34_attr_liens_recency <= 48) => 0.0506029274, 
      (rv_D34_attr_liens_recency > 48) => 0.3434850970, 0.1347126786), 
   (iv_mos_src_voter_adl_lseen > 88.5) => 0.0126888528, 0.0184572518), 0.0003838265);

// Tree: 256
final_score_256 := map(
( NULL < nf_inq_per_phone and nf_inq_per_phone <= 30.5) => 0.0008190247, 
(nf_inq_per_phone > 30.5) => map(
   ( NULL < nf_inq_dobs_per_ssn and nf_inq_dobs_per_ssn <= 1.5) => -0.0406220904, 
   (nf_inq_dobs_per_ssn > 1.5) => map(
      ( NULL < nf_fp_prevaddrcartheftindex and nf_fp_prevaddrcartheftindex <= 115.5) => 0.2019329285, 
      (nf_fp_prevaddrcartheftindex > 115.5) => 0.0095152123, 0.1119026209), 0.0583373949), -0.0161083205);

// Tree: 257
final_score_257 := map(
(rv_L70_Add_Standardized in ['1 Address was Standardized','2 Standardization Error']) => map(
   ( NULL < rv_I60_inq_retail_recency and rv_I60_inq_retail_recency <= 2) => -0.0014827551, 
   (rv_I60_inq_retail_recency > 2) => map(
      ( NULL < nf_fp_srchphonesrchcountmo and nf_fp_srchphonesrchcountmo <= 4.5) => -0.0226249580, 
      (nf_fp_srchphonesrchcountmo > 4.5) => -0.0673834966, -0.0238802369), -0.0065488733), 
(rv_L70_Add_Standardized in ['0 Address is Standard']) => 0.0032434130, 0.0000643481);

// Tree: 258
final_score_258 := map(
( NULL < rv_email_domain_ISP_count and rv_email_domain_ISP_count <= 1.5) => map(
   ( NULL < iv_fname_non_phn_src_ct and iv_fname_non_phn_src_ct <= 14.5) => 0.0029166183, 
   (iv_fname_non_phn_src_ct > 14.5) => map(
      ( NULL < rv_C10_M_Hdr_FS and rv_C10_M_Hdr_FS <= 221.5) => 0.2034649629, 
      (rv_C10_M_Hdr_FS > 221.5) => 0.0341073435, 0.0484026738), 0.0038002090), 
(rv_email_domain_ISP_count > 1.5) => -0.0073551304, 0.0000885111);

// Tree: 259
final_score_259 := map(
( NULL < nf_mos_liens_unrel_ST_fseen and nf_mos_liens_unrel_ST_fseen <= 211.5) => map(
   ( NULL < nf_inq_Communications_count24 and nf_inq_Communications_count24 <= 2.5) => -0.0008240912, 
   (nf_inq_Communications_count24 > 2.5) => map(
      ( NULL < rv_C18_invalid_addrs_per_adl and rv_C18_invalid_addrs_per_adl <= 6.5) => 0.0108953293, 
      (rv_C18_invalid_addrs_per_adl > 6.5) => 0.1316843100, 0.0174680948), -0.0003288453), 
(nf_mos_liens_unrel_ST_fseen > 211.5) => -0.0725454538, -0.0006207084);

// Tree: 260
final_score_260 := map(
( NULL < rv_C14_addrs_5yr and rv_C14_addrs_5yr <= 7.5) => -0.0009697288, 
(rv_C14_addrs_5yr > 7.5) => map(
   (nf_fp_addrchangeecontraj in ['AA','CB','CD','DE','DF','DU','EC','ED','EE','FD','FU']) => -0.0634499424, 
   (nf_fp_addrchangeecontraj in ['-1','AB','AC','AD','AE','AF','AU','BA','BB','BC','BD','BE','BF','BU','CA','CC','CE','CF','CU','DA','DB','DC','DD','EA','EB','EF','EU','FA','FB','FC','FE','FF','UC','UD','UE','UF','UU']) => map(
      ( NULL < rv_D32_Mos_Since_Crim_LS and rv_D32_Mos_Since_Crim_LS <= 31.5) => 0.0271185616, 
      (rv_D32_Mos_Since_Crim_LS > 31.5) => 0.1559126950, 0.0597246713), 0.0355912228), -0.0007847995);

// Tree: 261
final_score_261 := map(
( NULL < iv_inp_add_avm_chg_1yr and iv_inp_add_avm_chg_1yr <= -12829) => map(
   ( NULL < nf_fp_srchcomponentrisktype and nf_fp_srchcomponentrisktype <= 7.5) => 0.0045482569, 
   (nf_fp_srchcomponentrisktype > 7.5) => map(
      ( NULL < nf_inq_HighRiskCredit_count24 and nf_inq_HighRiskCredit_count24 <= 8.5) => 0.1039317241, 
      (nf_inq_HighRiskCredit_count24 > 8.5) => -0.0255180304, 0.0618939172), 0.0075141482), 
(iv_inp_add_avm_chg_1yr > -12829) => -0.0059881836, 0.0032646189);

// Tree: 262
final_score_262 := map(
( NULL < nf_fp_prevaddrlenofres and nf_fp_prevaddrlenofres <= 0.5) => -0.0282559654, 
(nf_fp_prevaddrlenofres > 0.5) => map(
   ( NULL < rv_F01_inp_addr_address_score and rv_F01_inp_addr_address_score <= 11) => map(
      (iv_D34_liens_unrel_x_rel in ['0-0','1-1','1-2','2-0','2-2','3-0']) => 0.0074392136, 
      (iv_D34_liens_unrel_x_rel in ['0-1','0-2','1-0','2-1','3-1','3-2']) => 0.2470947364, 0.0656412691), 
   (rv_F01_inp_addr_address_score > 11) => -0.0001278913, 0.0000523287), -0.0003233323);

// Tree: 263
final_score_263 := map(
( NULL < nf_pct_rel_with_bk and nf_pct_rel_with_bk <= 0.23368794325) => map(
   (rv_D32_criminal_x_felony in ['0-0','1-0','1-1','2-0','2-1','3-0','3-1','3-2']) => map(
      ( NULL < nf_fp_srchvelocityrisktype and nf_fp_srchvelocityrisktype <= 1.5) => 0.0487840339, 
      (nf_fp_srchvelocityrisktype > 1.5) => 0.0018171327, 0.0023793180), 
   (rv_D32_criminal_x_felony in ['2-2','3-3']) => 0.0883515820, 0.0025755795), 
(nf_pct_rel_with_bk > 0.23368794325) => -0.0073167200, -0.0005680464);

// Tree: 264
final_score_264 := map(
( NULL < rv_F00_input_dob_match_level and rv_F00_input_dob_match_level <= 5.5) => 0.0373817189, 
(rv_F00_input_dob_match_level > 5.5) => map(
   ( NULL < nf_inq_Communications_count24 and nf_inq_Communications_count24 <= 2.5) => -0.0008966272, 
   (nf_inq_Communications_count24 > 2.5) => map(
      ( NULL < nf_fp_prevaddrcrimeindex and nf_fp_prevaddrcrimeindex <= 26) => 0.0979088458, 
      (nf_fp_prevaddrcrimeindex > 26) => 0.0118863665, 0.0198905491), -0.0003599396), -0.0167059060);

// Tree: 265
final_score_265 := map(
( NULL < nf_M_Bureau_ADL_FS_all and nf_M_Bureau_ADL_FS_all <= 17.5) => -0.0464443431, 
(nf_M_Bureau_ADL_FS_all > 17.5) => map(
   ( NULL < nf_fp_srchfraudsrchcountyr and nf_fp_srchfraudsrchcountyr <= 2.5) => -0.0058974965, 
   (nf_fp_srchfraudsrchcountyr > 2.5) => map(
      ( NULL < nf_fp_srchvelocityrisktype and nf_fp_srchvelocityrisktype <= 7.5) => 0.0181206431, 
      (nf_fp_srchvelocityrisktype > 7.5) => -0.0020506750, 0.0064877981), 0.0007060851), 0.0005434472);

// Tree: 266
final_score_266 := map(
( NULL < nf_inq_addrs_per_ssn and nf_inq_addrs_per_ssn <= 5.5) => map(
   ( NULL < rv_I60_Inq_Count12 and rv_I60_Inq_Count12 <= 4.5) => map(
      ( NULL < nf_fp_srchcomponentrisktype and nf_fp_srchcomponentrisktype <= 7.5) => -0.0010333362, 
      (nf_fp_srchcomponentrisktype > 7.5) => 0.0175740957, -0.0002793176), 
   (rv_I60_Inq_Count12 > 4.5) => -0.0084868007, -0.0020900065), 
(nf_inq_addrs_per_ssn > 5.5) => 0.0835810963, -0.0019929874);

// Tree: 267
final_score_267 := map(
( NULL < nf_fp_prevaddrmedianincome and nf_fp_prevaddrmedianincome <= 31102) => map(
   ( NULL < rv_A49_Curr_AVM_Chg_1yr_Pct and rv_A49_Curr_AVM_Chg_1yr_Pct <= 211.15) => map(
      ( NULL < nf_add_curr_nhood_MFD_pct and nf_add_curr_nhood_MFD_pct <= 0.7770269684) => -0.0062455938, 
      (nf_add_curr_nhood_MFD_pct > 0.7770269684) => 0.2429373212, -0.0012233025), 
   (rv_A49_Curr_AVM_Chg_1yr_Pct > 211.15) => 0.1123926221, 0.0157874719), 
(nf_fp_prevaddrmedianincome > 31102) => -0.0019274906, -0.0004879564);

// Tree: 268
final_score_268 := map(
( NULL < iv_src_drivers_lic_adl_count and iv_src_drivers_lic_adl_count <= 10.5) => map(
   ( NULL < nf_add_input_mobility_index and nf_add_input_mobility_index <= 1.1074346333) => -0.0002407980, 
   (nf_add_input_mobility_index > 1.1074346333) => -0.0798114429, -0.0004418902), 
(iv_src_drivers_lic_adl_count > 10.5) => map(
   ( NULL < iv_Phn_Cell and iv_Phn_Cell <= 0.5) => -0.0837028389, 
   (iv_Phn_Cell > 0.5) => -0.0304748439, -0.0524468651), -0.0007879609);

// Tree: 269
final_score_269 := map(
( NULL < nf_phones_per_addr_curr and nf_phones_per_addr_curr <= 15.5) => 0.0004620055, 
(nf_phones_per_addr_curr > 15.5) => map(
   ( NULL < nf_fp_srchfraudsrchcountyr and nf_fp_srchfraudsrchcountyr <= 10.5) => map(
      ( NULL < nf_inq_per_phone and nf_inq_per_phone <= 9.5) => 0.0272329869, 
      (nf_inq_per_phone > 9.5) => 0.1825846137, 0.0309087173), 
   (nf_fp_srchfraudsrchcountyr > 10.5) => -0.0285098059, 0.0232939163), 0.0012187297);

// Tree: 270
final_score_270 := map(
( NULL < nf_fp_srchphonesrchcountmo and nf_fp_srchphonesrchcountmo <= 6.5) => -0.0011962536, 
(nf_fp_srchphonesrchcountmo > 6.5) => map(
   ( NULL < iv_prv_addr_avm_auto_val and iv_prv_addr_avm_auto_val <= 189149.5) => map(
      ( NULL < rv_I60_Inq_Count12 and rv_I60_Inq_Count12 <= 1.5) => 0.1127817111, 
      (rv_I60_Inq_Count12 > 1.5) => -0.0041662746, 0.0059009838), 
   (iv_prv_addr_avm_auto_val > 189149.5) => 0.0940764580, 0.0231902925), -0.0009172184);

// Tree: 271
final_score_271 := map(
(rv_D32_criminal_x_felony in ['0-0','1-0','1-1','2-0','2-1','3-0','3-1','3-2']) => -0.0001414148, 
(rv_D32_criminal_x_felony in ['2-2','3-3']) => map(
   ( NULL < nf_fp_curraddrmedianincome and nf_fp_curraddrmedianincome <= 46711.5) => -0.0260364245, 
   (nf_fp_curraddrmedianincome > 46711.5) => map(
      ( NULL < nf_fp_curraddrmedianvalue and nf_fp_curraddrmedianvalue <= 155126) => 0.1629798758, 
      (nf_fp_curraddrmedianvalue > 155126) => 0.0368512653, 0.1029186327), 0.0496076034), -0.0000267931);

// Tree: 272
final_score_272 := map(
( NULL < nf_inq_RetailPayments_count24 and nf_inq_RetailPayments_count24 <= 0.5) => -0.0016780473, 
(nf_inq_RetailPayments_count24 > 0.5) => map(
   (nf_fp_addrchangeecontraj in ['-1','AC','BB','BD','BE','CA','CB','CF','DB','DC','DD','DE','DF','EA','EB','EC','EE','EF','EU','FA','FB','FC','FE','FF']) => 0.0092284887, 
   (nf_fp_addrchangeecontraj in ['AA','AB','AD','AE','AF','AU','BA','BC','BF','BU','CC','CD','CE','CU','DA','DU','ED','FD','FU','UC','UD','UE','UF','UU']) => map(
      ( NULL < rv_C14_addrs_15yr and rv_C14_addrs_15yr <= 2.5) => 0.0003241239, 
      (rv_C14_addrs_15yr > 2.5) => 0.1116871608, 0.0714565349), 0.0181248635), -0.0003159504);

// Tree: 273
final_score_273 := map(
( NULL < iv_prof_license_category and iv_prof_license_category <= 4.5) => map(
   ( NULL < iv_inp_add_avm_chg_3yr and iv_inp_add_avm_chg_3yr <= -46797) => 0.0499699911, 
   (iv_inp_add_avm_chg_3yr > -46797) => map(
      ( NULL < nf_fp_srchssnsrchcountmo and nf_fp_srchssnsrchcountmo <= 6.5) => -0.0066799137, 
      (nf_fp_srchssnsrchcountmo > 6.5) => 0.0281592421, -0.0060564162), 0.0016059652), 
(iv_prof_license_category > 4.5) => 0.1105660425, -0.0008140342);

// Tree: 274
final_score_274 := map(
( NULL < rv_C14_addrs_5yr and rv_C14_addrs_5yr <= 8.5) => map(
   ( NULL < rv_D32_criminal_count and rv_D32_criminal_count <= 19.5) => -0.0000086205, 
   (rv_D32_criminal_count > 19.5) => -0.0625771539, -0.0001094828), 
(rv_C14_addrs_5yr > 8.5) => map(
   ( NULL < nf_average_rel_distance and nf_average_rel_distance <= 370.5) => 0.0056727445, 
   (nf_average_rel_distance > 370.5) => 0.1302482255, 0.0640182229), 0.0000209184);

// Tree: 275
final_score_275 := map(
(nf_historic_x_current_ct in ['0-0','1-0','1-1','2-1','2-2','3-0','3-2','3-3']) => 0.0003606051, 
(nf_historic_x_current_ct in ['2-0','3-1']) => map(
   ( NULL < nf_fp_srchssnsrchcountwk and nf_fp_srchssnsrchcountwk <= 0.5) => 0.0116799258, 
   (nf_fp_srchssnsrchcountwk > 0.5) => map(
      ( NULL < nf_hh_collections_ct and nf_hh_collections_ct <= 4.5) => 0.0390556412, 
      (nf_hh_collections_ct > 4.5) => -0.0765871998, 0.0322843612), 0.0143390550), 0.0015748787);

// Tree: 276
final_score_276 := map(
( NULL < rv_C12_source_profile and rv_C12_source_profile <= 20.4) => map(
   ( NULL < nf_fp_srchssnsrchcountmo and nf_fp_srchssnsrchcountmo <= 3.5) => 0.0250454413, 
   (nf_fp_srchssnsrchcountmo > 3.5) => map(
      ( NULL < nf_hh_age_18_plus and nf_hh_age_18_plus <= 2.5) => 0.0202675211, 
      (nf_hh_age_18_plus > 2.5) => -0.0631985492, -0.0280916505), 0.0186418777), 
(rv_C12_source_profile > 20.4) => -0.0018162845, -0.0010319233);

// Tree: 277
final_score_277 := map(
( NULL < nf_addrs_per_ssn and nf_addrs_per_ssn <= 13.5) => map(
   ( NULL < nf_hh_collections_ct_avg and nf_hh_collections_ct_avg <= 0.4599358974) => -0.0108858688, 
   (nf_hh_collections_ct_avg > 0.4599358974) => 0.0018966613, -0.0033068624), 
(nf_addrs_per_ssn > 13.5) => map(
   (nf_fp_addrchangeecontraj in ['-1','AA','AD','AE','AF','BB','BC','BF','BU','CA','CB','CC','CE','DA','DC','DD','DF','DU','EA','EB','EC','EE','EF','EU','FB','FC','FD','FE','FU','UC']) => 0.0018069728, 
   (nf_fp_addrchangeecontraj in ['AB','AC','AU','BA','BD','BE','CD','CF','CU','DB','DE','ED','FA','FF','UD','UE','UF','UU']) => 0.0196286685, 0.0061537902), 0.0000898999);

// Tree: 278
final_score_278 := map(
( NULL < nf_fp_srchaddrsrchcountwk and nf_fp_srchaddrsrchcountwk <= 5.5) => -0.0013740708, 
(nf_fp_srchaddrsrchcountwk > 5.5) => map(
   ( NULL < nf_inq_lnames_per_sfd_addr and nf_inq_lnames_per_sfd_addr <= 1.5) => -0.0757337405, 
   (nf_inq_lnames_per_sfd_addr > 1.5) => map(
      ( NULL < nf_hh_pct_property_owners and nf_hh_pct_property_owners <= 0.29285714285) => 0.0498589979, 
      (nf_hh_pct_property_owners > 0.29285714285) => -0.0752372914, -0.0037536975), -0.0386531123), -0.0014849076);

// Tree: 279
final_score_279 := map(
(nf_fp_addrchangeecontraj in ['AD','AE','AF','BD','BU','CA','CF','CU','DA','DU','EA','EU','FA','FB','UC','UD','UE','UF','UU']) => -0.0818054796, 
(nf_fp_addrchangeecontraj in ['-1','AA','AB','AC','AU','BA','BB','BC','BE','BF','CB','CC','CD','CE','DB','DC','DD','DE','DF','EB','EC','ED','EE','EF','FC','FD','FE','FF','FU']) => map(
   ( NULL < iv_C13_avg_lres and iv_C13_avg_lres <= 318.5) => map(
      ( NULL < rv_L79_adls_per_sfd_addr_c6 and rv_L79_adls_per_sfd_addr_c6 <= 8.5) => -0.0013839217, 
      (rv_L79_adls_per_sfd_addr_c6 > 8.5) => -0.0720134159, -0.0014627401), 
   (iv_C13_avg_lres > 318.5) => 0.0936598379, -0.0010792507), -0.0013909751);

// Tree: 280
final_score_280 := map(
( NULL < iv_br_source_count and iv_br_source_count <= 3.5) => 0.0001338955, 
(iv_br_source_count > 3.5) => map(
   ( NULL < nf_fp_curraddrmedianvalue and nf_fp_curraddrmedianvalue <= 62303.5) => map(
      ( NULL < nf_M_Bureau_ADL_FS_noTU and nf_M_Bureau_ADL_FS_noTU <= 308) => 0.1933302929, 
      (nf_M_Bureau_ADL_FS_noTU > 308) => 0.0125063820, 0.0975090752), 
   (nf_fp_curraddrmedianvalue > 62303.5) => 0.0192295932, 0.0239384361), 0.0007298516);

// Tree: 281
final_score_281 := map(
( NULL < nf_inq_per_sfd_addr and nf_inq_per_sfd_addr <= 48.5) => map(
   ( NULL < nf_mos_acc_lseen and nf_mos_acc_lseen <= 119.5) => map(
      ( NULL < nf_addrs_per_ssn_c6 and nf_addrs_per_ssn_c6 <= 1.5) => -0.0005372373, 
      (nf_addrs_per_ssn_c6 > 1.5) => 0.0382430821, -0.0002595021), 
   (nf_mos_acc_lseen > 119.5) => -0.0415625515, -0.0011464753), 
(nf_inq_per_sfd_addr > 48.5) => -0.1070901494, -0.0012282882);

// Tree: 282
final_score_282 := map(
( NULL < nf_add_input_nhood_VAC_pct and nf_add_input_nhood_VAC_pct <= 0.074542145) => 0.0047534055, 
(nf_add_input_nhood_VAC_pct > 0.074542145) => map(
   ( NULL < nf_hh_criminals_pct and nf_hh_criminals_pct <= 0.68333333335) => map(
      ( NULL < nf_fp_srchaddrsrchcountwk and nf_fp_srchaddrsrchcountwk <= 2.5) => -0.0078654992, 
      (nf_fp_srchaddrsrchcountwk > 2.5) => 0.0440127081, -0.0067456054), 
   (nf_hh_criminals_pct > 0.68333333335) => -0.0366582727, -0.0097232445), 0.0022991423);

// Tree: 283
final_score_283 := map(
( NULL < nf_hh_payday_loan_users_pct and nf_hh_payday_loan_users_pct <= 0.0976190476) => -0.0020155543, 
(nf_hh_payday_loan_users_pct > 0.0976190476) => map(
   (iv_D34_liens_unrel_x_rel in ['0-0','0-1','0-2','1-0','1-1','2-1','2-2','3-1','3-2']) => map(
      ( NULL < nf_inq_Communications_count24 and nf_inq_Communications_count24 <= 4.5) => 0.0068894679, 
      (nf_inq_Communications_count24 > 4.5) => -0.0600561656, 0.0060062233), 
   (iv_D34_liens_unrel_x_rel in ['1-2','2-0','3-0']) => 0.0498441611, 0.0103317835), 0.0007241136);

// Tree: 284
final_score_284 := map(
( NULL < nf_inq_Other_count_week and nf_inq_Other_count_week <= 2.5) => map(
   ( NULL < nf_bus_phone_match and nf_bus_phone_match <= 2.5) => -0.0005848714, 
   (nf_bus_phone_match > 2.5) => 0.0359391505, 0.0001332843), 
(nf_inq_Other_count_week > 2.5) => map(
   ( NULL < iv_prv_addr_avm_auto_val and iv_prv_addr_avm_auto_val <= 169972.5) => -0.0552415209, 
   (iv_prv_addr_avm_auto_val > 169972.5) => 0.0417345386, -0.0363547977), 0.0000060124);

// Tree: 285
final_score_285 := map(
( NULL < nf_historical_count and nf_historical_count <= 5.5) => -0.0019114084, 
(nf_historical_count > 5.5) => map(
   ( NULL < nf_fp_srchphonesrchcountwk and nf_fp_srchphonesrchcountwk <= 4.5) => map(
      ( NULL < nf_average_rel_income and nf_average_rel_income <= 103500) => 0.0088530103, 
      (nf_average_rel_income > 103500) => 0.1740077026, 0.0099812827), 
   (nf_fp_srchphonesrchcountwk > 4.5) => -0.0672448309, 0.0096311582), 0.0005133358);

// Tree: 286
final_score_286 := map(
( NULL < nf_fp_idveraddressnotcurrent and nf_fp_idveraddressnotcurrent <= 0.5) => map(
   ( NULL < nf_hh_age_30_plus and nf_hh_age_30_plus <= 4.5) => map(
      ( NULL < nf_pct_rel_with_criminal and nf_pct_rel_with_criminal <= 0.65833333335) => 0.0309349863, 
      (nf_pct_rel_with_criminal > 0.65833333335) => -0.1251698918, 0.0232534285), 
   (nf_hh_age_30_plus > 4.5) => 0.1753945306, 0.0322099298), 
(nf_fp_idveraddressnotcurrent > 0.5) => 0.0000708472, 0.0006031416);

// Tree: 287
final_score_287 := map(
( NULL < rv_I60_inq_auto_count12 and rv_I60_inq_auto_count12 <= 6.5) => 0.0012771239, 
(rv_I60_inq_auto_count12 > 6.5) => map(
   ( NULL < nf_add_input_nhood_BUS_pct and nf_add_input_nhood_BUS_pct <= 0.0498651311) => map(
      ( NULL < nf_fp_curraddrmedianincome and nf_fp_curraddrmedianincome <= 39136.5) => 0.0871661494, 
      (nf_fp_curraddrmedianincome > 39136.5) => -0.0245823114, -0.0042122453), 
   (nf_add_input_nhood_BUS_pct > 0.0498651311) => -0.0709748240, -0.0306897359), 0.0007459476);

// Tree: 288
final_score_288 := map(
( NULL < nf_fp_srchaddrsrchcountwk and nf_fp_srchaddrsrchcountwk <= 4.5) => 0.0017692717, 
(nf_fp_srchaddrsrchcountwk > 4.5) => map(
   ( NULL < nf_hh_bankruptcies_pct and nf_hh_bankruptcies_pct <= 0.11805555555) => 0.0499417028, 
   (nf_hh_bankruptcies_pct > 0.11805555555) => map(
      ( NULL < nf_add_curr_nhood_BUS_pct and nf_add_curr_nhood_BUS_pct <= 0.0231711994) => -0.0902621310, 
      (nf_add_curr_nhood_BUS_pct > 0.0231711994) => 0.0340888702, -0.0198205234), 0.0248505071), 0.0019121666);

// Tree: 289
final_score_289 := map(
( NULL < nf_inq_RetailPayments_count24 and nf_inq_RetailPayments_count24 <= 0.5) => -0.0007570623, 
(nf_inq_RetailPayments_count24 > 0.5) => map(
   ( NULL < rv_D32_criminal_count and rv_D32_criminal_count <= 6.5) => map(
      ( NULL < nf_fp_curraddractivephonelist and nf_fp_curraddractivephonelist <= 0.5) => -0.0031869553, 
      (nf_fp_curraddractivephonelist > 0.5) => 0.0342961513, 0.0145185258), 
   (rv_D32_criminal_count > 6.5) => 0.1031837163, 0.0166962673), 0.0004593737);

// Tree: 290
final_score_290 := map(
( NULL < nf_inq_HighRiskCredit_count_day and nf_inq_HighRiskCredit_count_day <= 3.5) => map(
   ( NULL < nf_Inq_Per_Add_NAS_479 and nf_Inq_Per_Add_NAS_479 <= 0.5) => 0.0004517403, 
   (nf_Inq_Per_Add_NAS_479 > 0.5) => -0.0249689971, 0.0000706930), 
(nf_inq_HighRiskCredit_count_day > 3.5) => map(
   ( NULL < nf_fp_prevaddrageoldest and nf_fp_prevaddrageoldest <= 52.5) => -0.0120003799, 
   (nf_fp_prevaddrageoldest > 52.5) => 0.1197336458, 0.0495575761), 0.0001388462);

// Tree: 291
final_score_291 := map(
( NULL < rv_D31_bk_dism_recent_count and rv_D31_bk_dism_recent_count <= 0.5) => 0.0002005811, 
(rv_D31_bk_dism_recent_count > 0.5) => map(
   ( NULL < rv_email_domain_free_count and rv_email_domain_free_count <= 3.5) => map(
      ( NULL < nf_fp_prevaddrcartheftindex and nf_fp_prevaddrcartheftindex <= 141) => -0.0174998052, 
      (nf_fp_prevaddrcartheftindex > 141) => 0.1573988975, 0.0238264705), 
   (rv_email_domain_free_count > 3.5) => 0.1729207866, 0.0589357772), 0.0004349322);

// Tree: 292
final_score_292 := map(
( NULL < rv_S65_SSN_Problem and rv_S65_SSN_Problem <= 1.5) => map(
   ( NULL < nf_add_curr_nhood_BUS_pct and nf_add_curr_nhood_BUS_pct <= 0.56670139445) => 0.0000221637, 
   (nf_add_curr_nhood_BUS_pct > 0.56670139445) => map(
      ( NULL < rv_L80_Inp_AVM_AutoVal and rv_L80_Inp_AVM_AutoVal <= 54075.5) => 0.0238904114, 
      (rv_L80_Inp_AVM_AutoVal > 54075.5) => 0.2287257051, 0.0898710109), 0.0002634247), 
(rv_S65_SSN_Problem > 1.5) => -0.0568272628, 0.0000834252);

// Tree: 293
final_score_293 := map(
( NULL < rv_L72_Add_Curr_Vacant and rv_L72_Add_Curr_Vacant <= 0.5) => -0.0018366797, 
(rv_L72_Add_Curr_Vacant > 0.5) => map(
   (nf_historic_x_current_ct in ['1-1','2-0','2-1','2-2','3-2','3-3']) => map(
      ( NULL < iv_prv_addr_lres and iv_prv_addr_lres <= 17.5) => 0.1160301945, 
      (iv_prv_addr_lres > 17.5) => -0.0355075599, -0.0129572988), 
   (nf_historic_x_current_ct in ['0-0','1-0','3-0','3-1']) => 0.1224175487, 0.0416254550), -0.0015217448);

// Tree: 294
final_score_294 := map(
( NULL < nf_hh_criminals_pct and nf_hh_criminals_pct <= 0.54772727275) => map(
   (nf_fp_addrchangeecontraj in ['-1','AA','AB','AC','AD','BB','BC','BE','BF','BU','CA','CB','CC','CF','CU','DA','DC','DD','DE','EB','EC','ED','EE','EF','FB','FC','FD','FE','FF','FU','UE','UU']) => 0.0003446742, 
   (nf_fp_addrchangeecontraj in ['AE','AF','AU','BA','BD','CD','CE','DB','DF','DU','EA','EU','FA','UC','UD','UF']) => 0.0529918522, 0.0008222438), 
(nf_hh_criminals_pct > 0.54772727275) => map(
   ( NULL < rv_D32_criminal_count and rv_D32_criminal_count <= 19.5) => -0.0104734629, 
   (rv_D32_criminal_count > 19.5) => -0.1164806385, -0.0112172626), -0.0007457619);

// Tree: 295
final_score_295 := map(
(nf_util_adl_summary in ['|   |','|I M|','|IC |']) => -0.0103044367, 
(nf_util_adl_summary in ['|  M|','| C |','| CM|','|I  |','|ICM|']) => map(
   ( NULL < nf_hh_members_ct and nf_hh_members_ct <= 2.5) => -0.0041039967, 
   (nf_hh_members_ct > 2.5) => map(
      ( NULL < nf_phones_per_sfd_addr_curr and nf_phones_per_sfd_addr_curr <= 20.5) => 0.0067372381, 
      (nf_phones_per_sfd_addr_curr > 20.5) => 0.0973770853, 0.0071437306), 0.0021511562), -0.0004675049);

// Tree: 296
final_score_296 := map(
( NULL < nf_rel_count and nf_rel_count <= 1.5) => -0.0450252790, 
(nf_rel_count > 1.5) => map(
   ( NULL < rv_email_domain_ISP_count and rv_email_domain_ISP_count <= 0.5) => 0.0057838623, 
   (rv_email_domain_ISP_count > 0.5) => map(
      ( NULL < rv_L79_adls_per_addr_curr and rv_L79_adls_per_addr_curr <= 0.5) => -0.0309348753, 
      (rv_L79_adls_per_addr_curr > 0.5) => -0.0033658608, -0.0050784951), -0.0002463804), -0.0007627829);

// Tree: 297
final_score_297 := map(
( NULL < nf_phone_ver_insurance and nf_phone_ver_insurance <= 3.5) => map(
   (rv_E58_br_dead_bus_x_active_phn in ['0-0','0-1','0-2','0-3','1-0','1-1','1-2','1-3','2-0','3-0']) => map(
      ( NULL < nf_pct_rel_with_bk and nf_pct_rel_with_bk <= 0.05634920635) => 0.0064497880, 
      (nf_pct_rel_with_bk > 0.05634920635) => -0.0144270398, -0.0088091675), 
   (rv_E58_br_dead_bus_x_active_phn in ['2-1','2-2','2-3','3-1','3-2','3-3']) => 0.1777906477, -0.0082632450), 
(nf_phone_ver_insurance > 3.5) => 0.0026559520, -0.0003223174);

// Tree: 298
final_score_298 := map(
( NULL < nf_fp_srchunvrfddobcount and nf_fp_srchunvrfddobcount <= 0.5) => 0.0031880550, 
(nf_fp_srchunvrfddobcount > 0.5) => map(
   ( NULL < nf_fp_srchfraudsrchcountmo and nf_fp_srchfraudsrchcountmo <= 7.5) => -0.0086548116, 
   (nf_fp_srchfraudsrchcountmo > 7.5) => map(
      ( NULL < nf_inq_per_ssn and nf_inq_per_ssn <= 20.5) => 0.0500094418, 
      (nf_inq_per_ssn > 20.5) => -0.0381105403, 0.0270948767), -0.0075857346), 0.0007628326);

// Tree: 299
final_score_299 := map(
( NULL < nf_inq_Retail_count24 and nf_inq_Retail_count24 <= 0.5) => 0.0017482973, 
(nf_inq_Retail_count24 > 0.5) => map(
   ( NULL < nf_fp_curraddrmurderindex and nf_fp_curraddrmurderindex <= 195.5) => map(
      ( NULL < nf_pct_rel_prop_owned and nf_pct_rel_prop_owned <= 0.5694980695) => -0.0366474776, 
      (nf_pct_rel_prop_owned > 0.5694980695) => 0.0060008629, -0.0187634837), 
   (nf_fp_curraddrmurderindex > 195.5) => 0.1414749807, -0.0169122049), 0.0000643775);

// Tree: 300
final_score_300 := map(
( NULL < nf_inq_count_day and nf_inq_count_day <= 1.5) => 0.0003167085, 
(nf_inq_count_day > 1.5) => map(
   ( NULL < iv_C13_avg_lres and iv_C13_avg_lres <= 116.5) => map(
      ( NULL < nf_average_rel_home_val and nf_average_rel_home_val <= 163500) => -0.0803289429, 
      (nf_average_rel_home_val > 163500) => -0.0129099725, -0.0438328069), 
   (iv_C13_avg_lres > 116.5) => 0.0798939252, -0.0280072947), 0.0001599484);

// Tree: 301
final_score_301 := map(
( NULL < iv_inp_add_avm_pct_chg_3yr and iv_inp_add_avm_pct_chg_3yr <= 0.2030095696) => 0.1271123971, 
(iv_inp_add_avm_pct_chg_3yr > 0.2030095696) => -0.0027620169, map(
   ( NULL < rv_D31_bk_dism_recent_count and rv_D31_bk_dism_recent_count <= 0.5) => 0.0011217214, 
   (rv_D31_bk_dism_recent_count > 0.5) => map(
      (nf_fp_addrchangeecontraj in ['-1','AA','AB','BB','CC','DF','EE','EF','FC','FD']) => 0.0101754303, 
      (nf_fp_addrchangeecontraj in ['AC','AD','AE','AF','AU','BA','BC','BD','BE','BF','BU','CA','CB','CD','CE','CF','CU','DA','DB','DC','DD','DE','DU','EA','EB','EC','ED','EU','FA','FB','FE','FF','FU','UC','UD','UE','UF','UU']) => 0.1691425483, 0.0682595695), 0.0013353008));

// Tree: 302
final_score_302 := map(
( NULL < rv_D32_Mos_Since_Fel_LS and rv_D32_Mos_Since_Fel_LS <= 65.5) => -0.0010882200, 
(rv_D32_Mos_Since_Fel_LS > 65.5) => map(
   ( NULL < nf_inq_per_phone and nf_inq_per_phone <= 6.5) => -0.0205337252, 
   (nf_inq_per_phone > 6.5) => map(
      (nf_util_adl_summary in ['|   |','| CM|']) => -0.1127817409, 
      (nf_util_adl_summary in ['|  M|','| C |','|I  |','|I M|','|IC |','|ICM|']) => -0.0013423311, -0.0630953799), -0.0282946774), -0.0013904128);

// Tree: 303
final_score_303 := map(
( NULL < nf_inq_per_addr and nf_inq_per_addr <= 21.5) => 0.0000060620, 
(nf_inq_per_addr > 21.5) => map(
   ( NULL < nf_mos_acc_lseen and nf_mos_acc_lseen <= 37.5) => -0.0277876047, 
   (nf_mos_acc_lseen > 37.5) => map(
      ( NULL < rv_I60_inq_comm_recency and rv_I60_inq_comm_recency <= 4.5) => -0.0164866373, 
      (rv_I60_inq_comm_recency > 4.5) => 0.1369493248, 0.0349264600), -0.0215521095), -0.0005269956);

// Tree: 304
final_score_304 := map(
( NULL < iv_C14_addrs_per_adl and iv_C14_addrs_per_adl <= 17.5) => map(
   (iv_D34_liens_unrel_x_rel in ['0-0','0-1','1-0','1-1','2-1','2-2','3-2']) => 0.0001270736, 
   (iv_D34_liens_unrel_x_rel in ['0-2','1-2','2-0','3-0','3-1']) => map(
      ( NULL < nf_fp_srchfraudsrchcountyr and nf_fp_srchfraudsrchcountyr <= 7.5) => 0.0083788692, 
      (nf_fp_srchfraudsrchcountyr > 7.5) => 0.0364164861, 0.0135350633), 0.0016257790), 
(iv_C14_addrs_per_adl > 17.5) => -0.0427057899, 0.0013718754);

// Tree: 305
final_score_305 := map(
( NULL < iv_src_voter_adl_count and iv_src_voter_adl_count <= 3.5) => map(
   ( NULL < nf_fp_srchaddrsrchcountwk and nf_fp_srchaddrsrchcountwk <= 6.5) => 0.0017163530, 
   (nf_fp_srchaddrsrchcountwk > 6.5) => -0.0593281336, 0.0016110439), 
(iv_src_voter_adl_count > 3.5) => map(
   ( NULL < rv_L80_Inp_AVM_AutoVal and rv_L80_Inp_AVM_AutoVal <= 132984.5) => -0.0149046506, 
   (rv_L80_Inp_AVM_AutoVal > 132984.5) => 0.0073191370, -0.0109602893), -0.0004557825);

// Tree: 306
final_score_306 := map(
(iv_college_major in ['BUSINESS','UNCLASSIFIED']) => -0.0107375392, 
(iv_college_major in ['LIBERAL ARTS','MEDICAL','NO AMS FOUND','NO COLLEGE FOUND','SCIENCE']) => map(
   ( NULL < nf_inq_HighRiskCredit_count_day and nf_inq_HighRiskCredit_count_day <= 0.5) => 0.0014611290, 
   (nf_inq_HighRiskCredit_count_day > 0.5) => map(
      (iv_D34_liens_unrel_x_rel in ['0-1','0-2','1-1','2-1','2-2','3-0','3-1','3-2']) => -0.0273229988, 
      (iv_D34_liens_unrel_x_rel in ['0-0','1-0','1-2','2-0']) => 0.0279557260, 0.0173819872), 0.0020554418), 0.0004929767);

// Tree: 307
final_score_307 := map(
( NULL < rv_D33_eviction_count and rv_D33_eviction_count <= 2.5) => -0.0001938756, 
(rv_D33_eviction_count > 2.5) => map(
   ( NULL < iv_inp_add_avm_chg_2yr and iv_inp_add_avm_chg_2yr <= 72662) => 0.0137344746, 
   (iv_inp_add_avm_chg_2yr > 72662) => 0.2065748120, map(
      ( NULL < nf_rel_criminal_count and nf_rel_criminal_count <= 15.5) => 0.0192647119, 
      (nf_rel_criminal_count > 15.5) => -0.0795743063, 0.0157087351)), 0.0006877982);

// Tree: 308
final_score_308 := map(
(nf_fp_addrchangeecontraj in ['-1','AA','AC','AD','AE','AF','BA','BB','BC','BD','BE','BF','BU','CA','CB','CC','CD','CE','CF','CU','DA','DB','DC','DD','DE','DF','EA','EB','EC','ED','EE','EF','FA','FB','FC','FD','FE','FF','UC','UE','UU']) => map(
   ( NULL < nf_hh_college_attendees and nf_hh_college_attendees <= 4.5) => map(
      ( NULL < rv_I60_inq_hiRiskCred_count12 and rv_I60_inq_hiRiskCred_count12 <= 23.5) => -0.0003235360, 
      (rv_I60_inq_hiRiskCred_count12 > 23.5) => -0.0749669450, -0.0003995800), 
   (nf_hh_college_attendees > 4.5) => 0.0930236262, -0.0002912772), 
(nf_fp_addrchangeecontraj in ['AB','AU','DU','EU','FU','UD','UF']) => 0.1304014367, -0.0001886689);

// Tree: 309
final_score_309 := map(
( NULL < rv_F00_dob_score and rv_F00_dob_score <= 98) => map(
   ( NULL < rv_P88_Phn_Dst_to_Inp_Add and rv_P88_Phn_Dst_to_Inp_Add <= 7.5) => -0.0059414999, 
   (rv_P88_Phn_Dst_to_Inp_Add > 7.5) => 0.0360643850, map(
      (nf_fp_addrchangeecontraj in ['CA','DC','DD','DF','EF','FD','FE','FF']) => 0.0047648677, 
      (nf_fp_addrchangeecontraj in ['-1','AA','AB','AC','AD','AE','AF','AU','BA','BB','BC','BD','BE','BF','BU','CB','CC','CD','CE','CF','CU','DA','DB','DE','DU','EA','EB','EC','ED','EE','EU','FA','FB','FC','FU','UC','UD','UE','UF','UU']) => 0.1756888777, 0.1093821497)), 
(rv_F00_dob_score > 98) => 0.0010129975, -0.0080635839);

// Tree: 310
final_score_310 := map(
( NULL < nf_inq_per_sfd_addr and nf_inq_per_sfd_addr <= 20.5) => map(
   ( NULL < nf_inq_per_phone and nf_inq_per_phone <= 10.5) => -0.0005259218, 
   (nf_inq_per_phone > 10.5) => map(
      ( NULL < nf_fp_curraddrcartheftindex and nf_fp_curraddrcartheftindex <= 145.5) => 0.0048171198, 
      (nf_fp_curraddrcartheftindex > 145.5) => 0.0459116426, 0.0162421057), 0.0073571175), 
(nf_inq_per_sfd_addr > 20.5) => -0.0187694619, -0.0002116957);

// Tree: 311
final_score_311 := map(
( NULL < nf_fp_srchssnsrchcountmo and nf_fp_srchssnsrchcountmo <= 2.5) => -0.0004202120, 
(nf_fp_srchssnsrchcountmo > 2.5) => map(
   ( NULL < nf_rel_derog_summary and nf_rel_derog_summary <= 6.5) => -0.0033899626, 
   (nf_rel_derog_summary > 6.5) => map(
      ( NULL < nf_phones_per_sfd_addr_curr and nf_phones_per_sfd_addr_curr <= 12.5) => -0.0351708844, 
      (nf_phones_per_sfd_addr_curr > 12.5) => 0.0324621014, -0.0298229455), -0.0072761538), -0.0013013171);

// Tree: 312
final_score_312 := map(
( NULL < nf_inq_adls_per_phone and nf_inq_adls_per_phone <= 2.5) => 0.0000528557, 
(nf_inq_adls_per_phone > 2.5) => map(
   ( NULL < nf_liens_unrel_CJ_total_amt and nf_liens_unrel_CJ_total_amt <= 3976.5) => map(
      ( NULL < rv_A49_Curr_AVM_Chg_1yr and rv_A49_Curr_AVM_Chg_1yr <= 6662.5) => 0.1072413820, 
      (rv_A49_Curr_AVM_Chg_1yr > 6662.5) => 0.0088982136, -0.0028609868), 
   (nf_liens_unrel_CJ_total_amt > 3976.5) => 0.2051203568, 0.0358050606), -0.0450323579);

// Tree: 313
final_score_313 := map(
( NULL < nf_fp_prevaddrcartheftindex and nf_fp_prevaddrcartheftindex <= 14.5) => map(
   ( NULL < rv_D32_Mos_Since_Fel_LS and rv_D32_Mos_Since_Fel_LS <= 139.5) => 0.0132464763, 
   (rv_D32_Mos_Since_Fel_LS > 139.5) => 0.1291545524, 0.0143692209), 
(nf_fp_prevaddrcartheftindex > 14.5) => map(
   ( NULL < nf_fp_curraddrburglaryindex and nf_fp_curraddrburglaryindex <= 85.5) => -0.0082301058, 
   (nf_fp_curraddrburglaryindex > 85.5) => 0.0019157586, -0.0023988756), -0.0011733420);

// Tree: 314
final_score_314 := map(
( NULL < nf_liens_unrel_ST_ct and nf_liens_unrel_ST_ct <= 5.5) => map(
   ( NULL < nf_inq_dobs_per_ssn and nf_inq_dobs_per_ssn <= 3.5) => -0.0000647892, 
   (nf_inq_dobs_per_ssn > 3.5) => map(
      ( NULL < rv_C20_M_Bureau_ADL_FS and rv_C20_M_Bureau_ADL_FS <= 187.5) => 0.1399063056, 
      (rv_C20_M_Bureau_ADL_FS > 187.5) => 0.0100633160, 0.0533443125), 0.0000446148), 
(nf_liens_unrel_ST_ct > 5.5) => 0.1402676983, 0.0001835782);

// Tree: 315
final_score_315 := map(
( NULL < rv_I62_inq_ssns_per_adl and rv_I62_inq_ssns_per_adl <= 3.5) => -0.0005348876, 
(rv_I62_inq_ssns_per_adl > 3.5) => map(
   ( NULL < nf_fp_prevaddrmedianincome and nf_fp_prevaddrmedianincome <= 63066.5) => map(
      ( NULL < nf_fp_srchphonesrchcountmo and nf_fp_srchphonesrchcountmo <= 1.5) => 0.0277763753, 
      (nf_fp_srchphonesrchcountmo > 1.5) => 0.1623127817, 0.0932586970), 
   (nf_fp_prevaddrmedianincome > 63066.5) => -0.0367043481, 0.0458002817), -0.0004287306);

// Tree: 316
final_score_316 := map(
( NULL < rv_C14_addrs_5yr and rv_C14_addrs_5yr <= 6.5) => -0.0010545806, 
(rv_C14_addrs_5yr > 6.5) => map(
   ( NULL < rv_C12_source_profile and rv_C12_source_profile <= 30.05) => -0.0607053216, 
   (rv_C12_source_profile > 30.05) => map(
      (iv_full_name_ver_sources in ['PHN & NONPHN']) => 0.0172749823, 
      (iv_full_name_ver_sources in ['NAME NOT VERD','NONPHN ONLY','PHN ONLY']) => 0.0701395255, 0.0386142065), 0.0261198522), -0.0007264740);

// Tree: 317
final_score_317 := map(
( NULL < nf_fp_srchfraudsrchcountwk and nf_fp_srchfraudsrchcountwk <= 1.5) => 0.0005523651, 
(nf_fp_srchfraudsrchcountwk > 1.5) => map(
   (nf_fp_addrchangeecontraj in ['-1','AB','BA','BB','BC','BD','BE','CA','CB','CC','CE','CF','DC','DD','DF','EC','ED','EE','EF','FA','FD','FE','FF','FU','UU']) => map(
      ( NULL < nf_inq_HighRiskCredit_count24 and nf_inq_HighRiskCredit_count24 <= 6.5) => -0.0022319743, 
      (nf_inq_HighRiskCredit_count24 > 6.5) => -0.0298641177, -0.0118353160), 
   (nf_fp_addrchangeecontraj in ['AA','AC','AD','AE','AF','AU','BF','BU','CD','CU','DA','DB','DE','DU','EA','EB','EU','FB','FC','UC','UD','UE','UF']) => 0.0909392362, -0.0091788551), -0.0000388177);

// Tree: 318
final_score_318 := map(
( NULL < nf_fp_srchfraudsrchcountyr and nf_fp_srchfraudsrchcountyr <= 31.5) => map(
   ( NULL < nf_add_input_mobility_index and nf_add_input_mobility_index <= 0.2378228905) => -0.0082867915, 
   (nf_add_input_mobility_index > 0.2378228905) => 0.0023570533, 0.0000418590), 
(nf_fp_srchfraudsrchcountyr > 31.5) => map(
   ( NULL < nf_add_input_nhood_BUS_pct and nf_add_input_nhood_BUS_pct <= 0.0523999144) => -0.0125476955, 
   (nf_add_input_nhood_BUS_pct > 0.0523999144) => -0.0932293084, -0.0450058156), -0.0001100510);

// Tree: 319
final_score_319 := map(
( NULL < nf_hh_lienholders and nf_hh_lienholders <= 4.5) => map(
   ( NULL < iv_full_name_non_phn_src_ct and iv_full_name_non_phn_src_ct <= 0.5) => 0.1148700476, 
   (iv_full_name_non_phn_src_ct > 0.5) => 0.0005113896, 0.0006230578), 
(nf_hh_lienholders > 4.5) => map(
   ( NULL < nf_inq_HighRiskCredit_count_week and nf_inq_HighRiskCredit_count_week <= 0.5) => -0.0220723365, 
   (nf_inq_HighRiskCredit_count_week > 0.5) => -0.0872465478, -0.0301536394), 0.0002780178);

// Tree: 320
final_score_320 := map(
( NULL < rv_I62_inq_phones_per_adl and rv_I62_inq_phones_per_adl <= 2.5) => -0.0011160789, 
(rv_I62_inq_phones_per_adl > 2.5) => map(
   ( NULL < nf_fp_curraddrburglaryindex and nf_fp_curraddrburglaryindex <= 187.5) => map(
      ( NULL < nf_add_curr_nhood_VAC_pct and nf_add_curr_nhood_VAC_pct <= 0.0306869701) => 0.0163139361, 
      (nf_add_curr_nhood_VAC_pct > 0.0306869701) => -0.0148270517, 0.0056526413), 
   (nf_fp_curraddrburglaryindex > 187.5) => 0.0527798361, 0.0083696179), -0.0000677157);

// Tree: 321
final_score_321 := map(
( NULL < nf_inq_Auto_count24 and nf_inq_Auto_count24 <= 18.5) => map(
   ( NULL < nf_inq_per_phone and nf_inq_per_phone <= 34.5) => map(
      ( NULL < nf_inq_per_sfd_addr and nf_inq_per_sfd_addr <= 37.5) => 0.0008111975, 
      (nf_inq_per_sfd_addr > 37.5) => -0.0611904625, 0.0006581624), 
   (nf_inq_per_phone > 34.5) => 0.0670909115, -0.0488335830), 
(nf_inq_Auto_count24 > 18.5) => -0.0865173249, 0.0005639694);

// Tree: 322
final_score_322 := map(
( NULL < nf_fp_srchaddrsrchcountwk and nf_fp_srchaddrsrchcountwk <= 4.5) => -0.0006772744, 
(nf_fp_srchaddrsrchcountwk > 4.5) => map(
   ( NULL < nf_pct_rel_prop_owned and nf_pct_rel_prop_owned <= 0.1558704453) => 0.1187067502, 
   (nf_pct_rel_prop_owned > 0.1558704453) => map(
      ( NULL < nf_inq_Auto_count24 and nf_inq_Auto_count24 <= 1.5) => 0.0407553787, 
      (nf_inq_Auto_count24 > 1.5) => -0.0304650466, 0.0196040691), 0.0299058031), -0.0004879237);

// Tree: 323
final_score_323 := map(
( NULL < nf_inq_count_week and nf_inq_count_week <= 1.5) => 0.0007652830, 
(nf_inq_count_week > 1.5) => map(
   ( NULL < rv_A49_Curr_AVM_Chg_1yr and rv_A49_Curr_AVM_Chg_1yr <= 34696) => -0.0177358678, 
   (rv_A49_Curr_AVM_Chg_1yr > 34696) => map(
      ( NULL < nf_inq_per_addr and nf_inq_per_addr <= 13.5) => 0.0792170342, 
      (nf_inq_per_addr > 13.5) => -0.0450235181, 0.0422806538), -0.0252416651), 0.0003838839);

// Tree: 324
final_score_324 := map(
(iv_D34_liens_unrel_x_rel in ['0-1','1-1','2-1','3-2']) => map(
   (nf_fp_addrchangeecontraj in ['-1','AA','AB','AC','AD','AE','AF','BA','BB','BD','CA','CB','CC','CD','CF','DC','DD','DE','DF','DU','EA','EC','ED','EE','EF','EU','FB','FD','FE','FF','UU']) => -0.0137631789, 
   (nf_fp_addrchangeecontraj in ['AU','BC','BE','BF','BU','CE','CU','DA','DB','EB','FA','FC','FU','UC','UD','UE','UF']) => 0.2144107603, -0.0126717277), 
(iv_D34_liens_unrel_x_rel in ['0-0','0-2','1-0','1-2','2-0','2-2','3-0','3-1']) => map(
   ( NULL < rv_L79_adls_per_addr_curr and rv_L79_adls_per_addr_curr <= 7.5) => 0.0004631020, 
   (rv_L79_adls_per_addr_curr > 7.5) => 0.0156482006, 0.0016245010), -0.0004526989);

// Tree: 325
final_score_325 := map(
( NULL < rv_C12_source_profile and rv_C12_source_profile <= 0.05) => map(
   ( NULL < nf_fp_assocsuspicousidcount and nf_fp_assocsuspicousidcount <= 2.5) => map(
      (nf_fp_addrchangeecontraj in ['AA','AD','BD','CB','CC','CE','CF','EF','FE','FF']) => 0.0079570310, 
      (nf_fp_addrchangeecontraj in ['-1','AB','AC','AE','AF','AU','BA','BB','BC','BE','BF','BU','CA','CD','CU','DA','DB','DC','DD','DE','DF','DU','EA','EB','EC','ED','EE','EU','FA','FB','FC','FD','FU','UC','UD','UE','UF','UU']) => 0.0853683266, 0.0551622299), 
   (nf_fp_assocsuspicousidcount > 2.5) => -0.0628168146, 0.0320793733), 
(rv_C12_source_profile > 0.05) => -0.0014674543, -0.0011496632);

// Tree: 326
final_score_326 := map(
( NULL < rv_I60_inq_other_count12 and rv_I60_inq_other_count12 <= 0.5) => map(
   ( NULL < rv_comb_age and rv_comb_age <= 23.5) => map(
      ( NULL < nf_add_input_nhood_VAC_pct and nf_add_input_nhood_VAC_pct <= 0.00021003925) => 0.1333081549, 
      (nf_add_input_nhood_VAC_pct > 0.00021003925) => 0.0264572940, 0.0430696790), 
   (rv_comb_age > 23.5) => 0.0035868506, 0.0048915457), 
(rv_I60_inq_other_count12 > 0.5) => -0.0037581009, -0.0010459641);

// Tree: 327
final_score_327 := map(
( NULL < nf_pct_rel_with_criminal and nf_pct_rel_with_criminal <= 0.68588039865) => map(
   ( NULL < nf_add_input_nhood_VAC_pct and nf_add_input_nhood_VAC_pct <= 0.0426489758) => map(
      ( NULL < nf_mos_liens_rel_SC_fseen and nf_mos_liens_rel_SC_fseen <= 79.5) => 0.0033142057, 
      (nf_mos_liens_rel_SC_fseen > 79.5) => -0.0454862557, 0.0023280305), 
   (nf_add_input_nhood_VAC_pct > 0.0426489758) => -0.0061109874, -0.0000130847), 
(nf_pct_rel_with_criminal > 0.68588039865) => -0.0213472599, -0.0006204985);

// Tree: 328
final_score_328 := map(
( NULL < nf_hh_criminals_pct and nf_hh_criminals_pct <= 0.06458333335) => -0.0052021482, 
(nf_hh_criminals_pct > 0.06458333335) => map(
   (nf_fp_addrchangeecontraj in ['AB','AC','AD','AE','AF','BC','BU','CA','CB','CF','CU','DA','DF','EA','EB','EC','FC','FU','UC','UE']) => -0.0641514207, 
   (nf_fp_addrchangeecontraj in ['-1','AA','AU','BA','BB','BD','BE','BF','CC','CD','CE','DB','DC','DD','DE','DU','ED','EE','EF','EU','FA','FB','FD','FE','FF','UD','UF','UU']) => map(
      (nf_historic_x_current_ct in ['0-0','2-1','2-2','3-3']) => 0.0014860617, 
      (nf_historic_x_current_ct in ['1-0','1-1','2-0','3-0','3-1','3-2']) => 0.0143480162, 0.0052677064), 0.0045368403), -0.0005708139);

// Tree: 329
final_score_329 := map(
(nf_fp_addrchangeecontraj in ['-1','AA','AB','AC','AE','BB','BC','BE','BF','BU','CA','CC','CD','CE','CF','CU','DA','DB','DC','DD','DE','DF','DU','EA','EB','EC','ED','EE','EF','FD','FE','FF','FU','UC','UE','UU']) => 0.0006954452, 
(nf_fp_addrchangeecontraj in ['AD','AF','AU','BA','BD','CB','EU','FA','FB','FC','UD','UF']) => map(
   ( NULL < nf_pct_rel_prop_sold and nf_pct_rel_prop_sold <= 0.36038961035) => map(
      ( NULL < nf_add_curr_nhood_BUS_pct and nf_add_curr_nhood_BUS_pct <= 0.02445730745) => 0.2478424386, 
      (nf_add_curr_nhood_BUS_pct > 0.02445730745) => 0.0714552205, 0.1439579421), 
   (nf_pct_rel_prop_sold > 0.36038961035) => -0.0666193697, 0.0937736294), 0.0009518325);

// Tree: 330
final_score_330 := map(
( NULL < nf_inq_Other_count24 and nf_inq_Other_count24 <= 11.5) => -0.0009350339, 
(nf_inq_Other_count24 > 11.5) => map(
   ( NULL < rv_I60_inq_auto_recency and rv_I60_inq_auto_recency <= 0.5) => map(
      ( NULL < nf_fp_curraddrmurderindex and nf_fp_curraddrmurderindex <= 178.5) => -0.0167229763, 
      (nf_fp_curraddrmurderindex > 178.5) => 0.1494902753, -0.0061855334), 
   (rv_I60_inq_auto_recency > 0.5) => 0.0364212610, 0.0193130573), -0.0003924440);

// Tree: 331
final_score_331 := map(
(nf_historic_x_current_ct in ['0-0','1-1','2-1','2-2','3-2']) => -0.0039121344, 
(nf_historic_x_current_ct in ['1-0','2-0','3-0','3-1','3-3']) => map(
   ( NULL < rv_C20_M_Bureau_ADL_FS and rv_C20_M_Bureau_ADL_FS <= 35.5) => map(
      ( NULL < nf_fp_srchphonesrchcountmo and nf_fp_srchphonesrchcountmo <= 0.5) => 0.0069776012, 
      (nf_fp_srchphonesrchcountmo > 0.5) => 0.1102120531, 0.0501483720), 
   (rv_C20_M_Bureau_ADL_FS > 35.5) => 0.0060355777, 0.0063726206), -0.0001005243);

// Tree: 332
final_score_332 := map(
( NULL < iv_inp_add_avm_pct_chg_1yr and iv_inp_add_avm_pct_chg_1yr <= 3.977875731) => map(
   ( NULL < rv_P88_Phn_Dst_to_Inp_Add and rv_P88_Phn_Dst_to_Inp_Add <= 117.5) => -0.0061732861, 
   (rv_P88_Phn_Dst_to_Inp_Add > 117.5) => 0.0561444155, map(
      ( NULL < rv_F00_dob_score and rv_F00_dob_score <= 98) => 0.1188590605, 
      (rv_F00_dob_score > 98) => 0.0062758116, -0.0411520351)), 
(iv_inp_add_avm_pct_chg_1yr > 3.977875731) => 0.1312607465, 0.0022048465);

// Tree: 333
final_score_333 := map(
( NULL < nf_fp_srchunvrfdssncount and nf_fp_srchunvrfdssncount <= 0.5) => -0.0009208721, 
(nf_fp_srchunvrfdssncount > 0.5) => map(
   ( NULL < nf_inq_per_phone and nf_inq_per_phone <= 33.5) => map(
      (nf_fp_addrchangeecontraj in ['AB','AC','AF','BD','CA','CE','DA','EA','EC','ED','EF','EU','FA','FE','FU','UC','UE','UF','UU']) => -0.0498350426, 
      (nf_fp_addrchangeecontraj in ['-1','AA','AD','AE','AU','BA','BB','BC','BE','BF','BU','CB','CC','CD','CF','CU','DB','DC','DD','DE','DF','DU','EB','EE','FB','FC','FD','FF','UD']) => 0.0126039642, 0.0111544296), 
   (nf_inq_per_phone > 33.5) => -0.0984092011, 0.0107169090), 0.0014087811);

// Tree: 334
final_score_334 := map(
( NULL < nf_oldest_rel_age and nf_oldest_rel_age <= 35) => -0.0290271803, 
(nf_oldest_rel_age > 35) => map(
   ( NULL < nf_average_rel_income and nf_average_rel_income <= 35500) => map(
      ( NULL < nf_fp_curraddrmedianvalue and nf_fp_curraddrmedianvalue <= 47645) => 0.1352235547, 
      (nf_fp_curraddrmedianvalue > 47645) => 0.0220762195, 0.0396468808), 
   (nf_average_rel_income > 35500) => 0.0006198902, 0.0009197789), 0.0003674327);

// Tree: 335
final_score_335 := map(
( NULL < nf_inq_lnames_per_sfd_addr and nf_inq_lnames_per_sfd_addr <= 5.5) => map(
   ( NULL < nf_inq_count_week and nf_inq_count_week <= 1.5) => 0.0001460511, 
   (nf_inq_count_week > 1.5) => -0.0156600603, -0.0002254517), 
(nf_inq_lnames_per_sfd_addr > 5.5) => map(
   ( NULL < nf_fp_varrisktype and nf_fp_varrisktype <= 4.5) => -0.0253326139, 
   (nf_fp_varrisktype > 4.5) => -0.1308825355, -0.0521062526), -0.0003623404);

// Tree: 336
final_score_336 := map(
(nf_historic_x_current_ct in ['0-0','1-1','2-1','2-2']) => map(
   (nf_fp_addrchangeecontraj in ['-1','AA','AC','AD','AF','BB','BC','BD','BE','BU','CA','CB','CC','CE','CF','DB','DC','DD','DF','DU','EA','EB','EC','ED','EE','EF','EU','FA','FB','FC','FE','FF','UC','UE','UF']) => -0.0073127978, 
   (nf_fp_addrchangeecontraj in ['AB','AE','AU','BA','BF','CD','CU','DA','DE','FD','FU','UD','UU']) => map(
      ( NULL < nf_fp_srchfraudsrchcountwk and nf_fp_srchfraudsrchcountwk <= 0.5) => 0.0292937304, 
      (nf_fp_srchfraudsrchcountwk > 0.5) => 0.1403364557, 0.0450842097), -0.0067509963), 
(nf_historic_x_current_ct in ['1-0','2-0','3-0','3-1','3-2','3-3']) => 0.0037992272, -0.0017226186);

// Tree: 337
final_score_337 := map(
( NULL < nf_inq_per_addr and nf_inq_per_addr <= 10.5) => -0.0020278855, 
(nf_inq_per_addr > 10.5) => map(
   ( NULL < nf_inq_lnames_per_ssn and nf_inq_lnames_per_ssn <= 0.5) => map(
      ( NULL < iv_A46_L77_addrs_move_traj and iv_A46_L77_addrs_move_traj <= 7.5) => 0.0371947195, 
      (iv_A46_L77_addrs_move_traj > 7.5) => 0.2039180629, 0.0908610317), 
   (nf_inq_lnames_per_ssn > 0.5) => 0.0068492104, 0.0086222860), -0.0005145202);

// Tree: 338
final_score_338 := map(
( NULL < nf_Inq_Per_Add_NAS_479 and nf_Inq_Per_Add_NAS_479 <= 2.5) => map(
   (rv_D31_MostRec_Bk in ['0 - NO BK','2 - BK DISCHARGED']) => -0.0012489689, 
   (rv_D31_MostRec_Bk in ['1 - BK DISMISSED','3 - BK OTHER']) => map(
      ( NULL < nf_fp_curraddrmedianvalue and nf_fp_curraddrmedianvalue <= 179046.5) => 0.0411700588, 
      (nf_fp_curraddrmedianvalue > 179046.5) => -0.0091817063, 0.0195448272), -0.0004033811), 
(nf_Inq_Per_Add_NAS_479 > 2.5) => -0.0355310625, -0.0006859142);

// Tree: 339
final_score_339 := map(
( NULL < rv_C10_M_Hdr_FS and rv_C10_M_Hdr_FS <= 333.5) => map(
   ( NULL < nf_inq_per_ssn and nf_inq_per_ssn <= 18.5) => 0.0012764111, 
   (nf_inq_per_ssn > 18.5) => map(
      ( NULL < rv_comb_age and rv_comb_age <= 52.5) => 0.0296828278, 
      (rv_comb_age > 52.5) => -0.0769609716, 0.0241452101), 0.0019651168), 
(rv_C10_M_Hdr_FS > 333.5) => -0.0093048996, -0.0006781360);

// Tree: 340
final_score_340 := map(
( NULL < nf_hh_pct_property_owners and nf_hh_pct_property_owners <= 0.01923076925) => map(
   ( NULL < rv_P88_Phn_Dst_to_Inp_Add and rv_P88_Phn_Dst_to_Inp_Add <= 23.5) => map(
      ( NULL < rv_I60_inq_hiRiskCred_count12 and rv_I60_inq_hiRiskCred_count12 <= 5.5) => 0.0073508839, 
      (rv_I60_inq_hiRiskCred_count12 > 5.5) => 0.0255097206, 0.0100652052), 
   (rv_P88_Phn_Dst_to_Inp_Add > 23.5) => -0.0168867238, 0.0012417809), 
(nf_hh_pct_property_owners > 0.01923076925) => -0.0030083689, 0.0004480598);

// Tree: 341
final_score_341 := map(
( NULL < nf_mos_foreclosure_lseen and nf_mos_foreclosure_lseen <= 35.5) => map(
   ( NULL < iv_inp_add_avm_pct_chg_3yr and iv_inp_add_avm_pct_chg_3yr <= 1.14717020205) => 0.0081790913, 
   (iv_inp_add_avm_pct_chg_3yr > 1.14717020205) => map(
      ( NULL < rv_C12_source_profile and rv_C12_source_profile <= 6.4) => 0.0850962358, 
      (rv_C12_source_profile > 6.4) => -0.0101028684, -0.0093480929), 0.0012473487), 
(nf_mos_foreclosure_lseen > 35.5) => -0.0305233764, -0.0018680060);

// Tree: 342
final_score_342 := map(
( NULL < nf_fp_srchfraudsrchcountmo and nf_fp_srchfraudsrchcountmo <= 7.5) => 0.0002975493, 
(nf_fp_srchfraudsrchcountmo > 7.5) => map(
   ( NULL < nf_inq_HighRiskCredit_count_day and nf_inq_HighRiskCredit_count_day <= 0.5) => map(
      (rv_6seg_RiskView_5_0 in ['1 VER/VAL PROBLEMS','2 ADDR NOT CURRENT - DEROG','4 SUFFICIENTLY VERD - DEROG','5 SUFFICIENTLY VERD - OWNER','6 SUFFICIENTLY VERD - OTHER']) => 0.0263818875, 
      (rv_6seg_RiskView_5_0 in ['0 TRUEDID = 0','3 ADDR NOT CURRENT - OTHER']) => 0.1182016261, 0.0329137795), 
   (nf_inq_HighRiskCredit_count_day > 0.5) => -0.0266713622, 0.0232280245), 0.0006443368);

// Tree: 343
final_score_343 := map(
( NULL < iv_D34_liens_unrel_SC_ct and iv_D34_liens_unrel_SC_ct <= 1.5) => -0.0002900775, 
(iv_D34_liens_unrel_SC_ct > 1.5) => map(
   ( NULL < nf_liens_rel_SC_total_amt and nf_liens_rel_SC_total_amt <= 324) => map(
      ( NULL < nf_hh_bankruptcies_pct and nf_hh_bankruptcies_pct <= 0.875) => 0.0275612072, 
      (nf_hh_bankruptcies_pct > 0.875) => 0.1937415648, 0.0468009178), 
   (nf_liens_rel_SC_total_amt > 324) => -0.0163868289, 0.0236499054), 0.0004743480);

// Tree: 344
final_score_344 := map(
(nf_fp_addrchangeecontraj in ['AB','AC','AE','AF','BA','BC','BD','BU','CA','CB','CE','CF','DA','DB','DC','DU','EA','EB','EC','EE','EF','EU','FB','FC','FE','UC','UE','UF','UU']) => map(
   (nf_Source_Type in ['Bureau and Behavioral','Bureau Behavioral and Government','Bureau Only','None']) => -0.0117535432, 
   (nf_Source_Type in ['Behavioral and Government','Behavioral Only','Bureau and Government','Government Only']) => 0.0182868053, -0.0092244613), 
(nf_fp_addrchangeecontraj in ['-1','AA','AD','AU','BB','BE','BF','CC','CD','CU','DD','DE','DF','ED','FA','FD','FF','FU','UD']) => map(
   ( NULL < nf_inq_lnames_per_ssn and nf_inq_lnames_per_ssn <= 3.5) => 0.0030035830, 
   (nf_inq_lnames_per_ssn > 3.5) => -0.0905825880, 0.0028402835), 0.0001197181);

// Tree: 345
final_score_345 := map(
( NULL < nf_pct_rel_with_criminal and nf_pct_rel_with_criminal <= 0.6233108108) => map(
   ( NULL < rv_F01_inp_addr_address_score and rv_F01_inp_addr_address_score <= 11) => map(
      ( NULL < nf_average_rel_criminal_dist and nf_average_rel_criminal_dist <= 226.5) => 0.1351774238, 
      (nf_average_rel_criminal_dist > 226.5) => -0.0207256249, 0.0598367160), 
   (rv_F01_inp_addr_address_score > 11) => 0.0011769293, 0.0013431223), 
(nf_pct_rel_with_criminal > 0.6233108108) => -0.0200463565, 0.0002707713);

// Tree: 346
final_score_346 := map(
( NULL < rv_D32_Mos_Since_Crim_LS and rv_D32_Mos_Since_Crim_LS <= 117.5) => 0.0016925132, 
(rv_D32_Mos_Since_Crim_LS > 117.5) => map(
   ( NULL < rv_C13_Curr_Addr_LRes and rv_C13_Curr_Addr_LRes <= 299.5) => -0.0165226009, 
   (rv_C13_Curr_Addr_LRes > 299.5) => map(
      ( NULL < rv_P88_Phn_Dst_to_Inp_Add and rv_P88_Phn_Dst_to_Inp_Add <= 2.5) => -0.0054599115, 
      (rv_P88_Phn_Dst_to_Inp_Add > 2.5) => 0.1213555030, 0.1724385111), -0.0136779998), 0.0001284579);

// Tree: 347
final_score_347 := map(
( NULL < rv_comb_age and rv_comb_age <= 74.5) => -0.0002424065, 
(rv_comb_age > 74.5) => map(
   ( NULL < nf_inq_per_phone and nf_inq_per_phone <= 8.5) => map(
      ( NULL < iv_src_drivers_lic_adl_count and iv_src_drivers_lic_adl_count <= 1.5) => -0.0107226413, 
      (iv_src_drivers_lic_adl_count > 1.5) => 0.1319135294, 0.0351765745), 
   (nf_inq_per_phone > 8.5) => 0.1796652912, 0.0547639534), 0.0001624945);

// Tree: 348
final_score_348 := map(
( NULL < nf_liens_unrel_O_total_amt and nf_liens_unrel_O_total_amt <= 1177) => map(
   (rv_E58_br_dead_bus_x_active_phn in ['0-0','0-1','0-2','0-3','1-0','1-1','1-2','2-0','2-2','2-3','3-0']) => -0.0005061692, 
   (rv_E58_br_dead_bus_x_active_phn in ['1-3','2-1','3-1','3-2','3-3']) => 0.0656290108, -0.0002506555), 
(nf_liens_unrel_O_total_amt > 1177) => map(
   ( NULL < nf_fp_srchssnsrchcountmo and nf_fp_srchssnsrchcountmo <= 1.5) => -0.0312282140, 
   (nf_fp_srchssnsrchcountmo > 1.5) => -0.0867260099, -0.0433745288), -0.0005625923);

// Tree: 349
final_score_349 := map(
(rv_L70_Add_Standardized in ['1 Address was Standardized']) => -0.0063451876, 
(rv_L70_Add_Standardized in ['0 Address is Standard','2 Standardization Error']) => map(
   ( NULL < nf_inq_Retail_count24 and nf_inq_Retail_count24 <= 1.5) => map(
      ( NULL < rv_C19_Add_Prison_Hist and rv_C19_Add_Prison_Hist <= 0.5) => 0.0047097789, 
      (rv_C19_Add_Prison_Hist > 0.5) => 0.0724354154, 0.0048891931), 
   (nf_inq_Retail_count24 > 1.5) => -0.0387933842, 0.0037074007), 0.0006342419);

// Tree: 350
final_score_350 := map(
(rv_E58_br_dead_bus_x_active_phn in ['0-0','0-1','0-2','0-3','1-0','1-1','1-3','2-0','2-1','2-3','3-1']) => -0.0004183704, 
(rv_E58_br_dead_bus_x_active_phn in ['1-2','2-2','3-0','3-2','3-3']) => map(
   ( NULL < iv_C13_avg_lres and iv_C13_avg_lres <= 98) => 0.0022256780, 
   (iv_C13_avg_lres > 98) => map(
      ( NULL < rv_I60_inq_retail_recency and rv_I60_inq_retail_recency <= 3) => 0.0412634846, 
      (rv_I60_inq_retail_recency > 3) => 0.2413538412, 0.1342188471), 0.0512406853), -0.0001909615);

// Tree: 351
final_score_351 := map(
( NULL < nf_hh_bankruptcies_pct and nf_hh_bankruptcies_pct <= 0.8452380952) => map(
   ( NULL < nf_addrs_per_ssn and nf_addrs_per_ssn <= 5.5) => -0.0073251564, 
   (nf_addrs_per_ssn > 5.5) => 0.0041298421, 0.0021575256), 
(nf_hh_bankruptcies_pct > 0.8452380952) => map(
   (iv_D34_liens_unrel_x_rel in ['0-0','0-1','0-2','1-0','1-1','1-2','2-0']) => -0.0328125317, 
   (iv_D34_liens_unrel_x_rel in ['2-1','2-2','3-0','3-1','3-2']) => 0.0209941213, -0.0187726457), 0.0006604544);

// Tree: 352
final_score_352 := map(
( NULL < nf_inq_Banking_count24 and nf_inq_Banking_count24 <= 0.5) => -0.0028763509, 
(nf_inq_Banking_count24 > 0.5) => map(
   ( NULL < rv_C13_max_lres and rv_C13_max_lres <= 98.5) => -0.0039494781, 
   (rv_C13_max_lres > 98.5) => map(
      ( NULL < nf_inq_HighRiskCredit_count_week and nf_inq_HighRiskCredit_count_week <= 2.5) => 0.0172850820, 
      (nf_inq_HighRiskCredit_count_week > 2.5) => 0.0635360700, 0.0181645964), 0.0089476218), -0.0003514908);

// Tree: 353
final_score_353 := map(
( NULL < rv_C20_M_Bureau_ADL_FS and rv_C20_M_Bureau_ADL_FS <= 49.5) => map(
   (nf_fp_addrchangeecontraj in ['-1','AA','AD','AE','AF','BB','BC','CB','CC','CE','CF','DB','DD','DE','EE','EF','FC','FD','FE','FF','FU','UE','UU']) => map(
      ( NULL < rv_I61_inq_collection_recency and rv_I61_inq_collection_recency <= 0.5) => 0.0015152733, 
      (rv_I61_inq_collection_recency > 0.5) => 0.0339378506, 0.0109313088), 
   (nf_fp_addrchangeecontraj in ['AB','AC','AU','BA','BD','BE','BF','BU','CA','CD','CU','DA','DC','DF','DU','EA','EB','EC','ED','EU','FA','FB','UC','UD','UF']) => 0.1336462499, 0.0126516117), 
(rv_C20_M_Bureau_ADL_FS > 49.5) => -0.0015622854, -0.0008575729);

// Tree: 354
final_score_354 := map(
( NULL < nf_M_Bureau_ADL_FS_all and nf_M_Bureau_ADL_FS_all <= 25.5) => -0.0316468193, 
(nf_M_Bureau_ADL_FS_all > 25.5) => map(
   ( NULL < rv_comb_age and rv_comb_age <= 22.5) => map(
      (nf_fp_addrchangeecontraj in ['-1','AA','AF','BB','BC','CE','DA','DE','DU','EE','EF','FD','FF']) => 0.0030035459, 
      (nf_fp_addrchangeecontraj in ['AB','AC','AD','AE','AU','BA','BD','BE','BF','BU','CA','CB','CC','CD','CF','CU','DB','DC','DD','DF','EA','EB','EC','ED','EU','FA','FB','FC','FE','FU','UC','UD','UE','UF','UU']) => 0.0745864946, 0.0219074936), 
   (rv_comb_age > 22.5) => 0.0001617758, 0.0006427060), 0.0003738171);

// Tree: 355
final_score_355 := map(
( NULL < iv_src_voter_adl_count and iv_src_voter_adl_count <= 5.5) => 0.0014543488, 
(iv_src_voter_adl_count > 5.5) => map(
   ( NULL < rv_I60_inq_comm_count12 and rv_I60_inq_comm_count12 <= 1.5) => map(
      (iv_C22_addr_ver_sources in ['ADDR NOT VERD']) => -0.1089460040, 
      (iv_C22_addr_ver_sources in ['NONPHN ONLY','PHN & NONPHN','PHN ONLY']) => -0.0127697726, -0.0140852207), 
   (rv_I60_inq_comm_count12 > 1.5) => -0.0713607911, -0.0169759877), 0.0003216377);

// Tree: 356
final_score_356 := map(
( NULL < nf_fp_srchssnsrchcountmo and nf_fp_srchssnsrchcountmo <= 11.5) => map(
   ( NULL < nf_add_input_nhood_BUS_pct and nf_add_input_nhood_BUS_pct <= 0.1139745414) => 0.0001418661, 
   (nf_add_input_nhood_BUS_pct > 0.1139745414) => -0.0126340900, -0.0019737043), 
(nf_fp_srchssnsrchcountmo > 11.5) => map(
   ( NULL < iv_prv_addr_lres and iv_prv_addr_lres <= 49.5) => -0.0774208903, 
   (iv_prv_addr_lres > 49.5) => -0.0430823050, -0.0583131291), -0.0020665157);

// Tree: 357
final_score_357 := map(
( NULL < nf_M_Bureau_ADL_FS_all and nf_M_Bureau_ADL_FS_all <= 21.5) => map(
   ( NULL < nf_add_curr_mobility_index and nf_add_curr_mobility_index <= 0.2591845084) => -0.0939438291, 
   (nf_add_curr_mobility_index > 0.2591845084) => map(
      ( NULL < nf_hh_criminals_pct and nf_hh_criminals_pct <= 0.26136363635) => -0.0379685222, 
      (nf_hh_criminals_pct > 0.26136363635) => 0.0692707509, -0.0179270843), -0.0414888355), 
(nf_M_Bureau_ADL_FS_all > 21.5) => 0.0009493242, 0.0007078817);

// Tree: 358
final_score_358 := map(
( NULL < nf_fp_srchaddrsrchcountday and nf_fp_srchaddrsrchcountday <= 3.5) => map(
   ( NULL < nf_fp_srchphonesrchcountwk and nf_fp_srchphonesrchcountwk <= 2.5) => -0.0006505687, 
   (nf_fp_srchphonesrchcountwk > 2.5) => map(
      ( NULL < rv_A49_curr_add_avm_chg_2yr and rv_A49_curr_add_avm_chg_2yr <= 29245) => -0.0053677108, 
      (rv_A49_curr_add_avm_chg_2yr > 29245) => 0.0837952275, 0.0108416943), -0.0003418084), 
(nf_fp_srchaddrsrchcountday > 3.5) => -0.0421180011, -0.0004359074);

// Tree: 359
final_score_359 := map(
( NULL < rv_C14_addrs_15yr and rv_C14_addrs_15yr <= 8.5) => -0.0026616713, 
(rv_C14_addrs_15yr > 8.5) => map(
   ( NULL < nf_fp_prevaddrcartheftindex and nf_fp_prevaddrcartheftindex <= 12) => map(
      ( NULL < nf_average_rel_home_val and nf_average_rel_home_val <= 119500) => 0.1853035336, 
      (nf_average_rel_home_val > 119500) => 0.0410023524, 0.0523467849), 
   (nf_fp_prevaddrcartheftindex > 12) => 0.0053620362, 0.0084084528), -0.0012640672);

// Tree: 360
final_score_360 := map(
( NULL < iv_dob_src_ct and iv_dob_src_ct <= 15.5) => -0.0004398148, 
(iv_dob_src_ct > 15.5) => map(
   ( NULL < nf_liens_unrel_SC_total_amt and nf_liens_unrel_SC_total_amt <= 4998) => map(
      ( NULL < nf_inq_Other_count24 and nf_inq_Other_count24 <= 8.5) => -0.0000519638, 
      (nf_inq_Other_count24 > 8.5) => 0.0761521606, 0.0051840218), 
   (nf_liens_unrel_SC_total_amt > 4998) => 0.2060861514, 0.0100051446), -0.0174420615);

// Tree: 361
final_score_361 := map(
( NULL < rv_D32_Mos_Since_Crim_LS and rv_D32_Mos_Since_Crim_LS <= 216.5) => map(
   (rv_D32_criminal_x_felony in ['0-0','3-1','3-2']) => -0.0006994796, 
   (rv_D32_criminal_x_felony in ['1-0','1-1','2-0','2-1','2-2','3-0','3-3']) => 0.0092963813, 0.0018288977), 
(rv_D32_Mos_Since_Crim_LS > 216.5) => map(
   ( NULL < nf_fp_curraddrcrimeindex and nf_fp_curraddrcrimeindex <= 146.5) => -0.0106626508, 
   (nf_fp_curraddrcrimeindex > 146.5) => -0.0774232658, -0.0250190801), 0.0011121867);

// Tree: 362
final_score_362 := map(
( NULL < nf_bus_addr_match_count and nf_bus_addr_match_count <= 0.5) => -0.0025627154, 
(nf_bus_addr_match_count > 0.5) => map(
   (rv_D32_criminal_x_felony in ['0-0','1-0','1-1','2-0','2-2','3-0','3-1','3-2']) => map(
      ( NULL < nf_mos_liens_unrel_CJ_fseen and nf_mos_liens_unrel_CJ_fseen <= 92.5) => 0.0039188948, 
      (nf_mos_liens_unrel_CJ_fseen > 92.5) => 0.0345858647, 0.0082808812), 
   (rv_D32_criminal_x_felony in ['2-1','3-3']) => 0.1006214700, 0.0086798197), -0.0001175472);

// Tree: 363
final_score_363 := map(
( NULL < iv_src_drivers_lic_adl_count and iv_src_drivers_lic_adl_count <= 10.5) => map(
   ( NULL < nf_acc_damage_amt_total and nf_acc_damage_amt_total <= 112.5) => map(
      ( NULL < nf_fp_srchphonesrchcountmo and nf_fp_srchphonesrchcountmo <= 0.5) => 0.0001149584, 
      (nf_fp_srchphonesrchcountmo > 0.5) => 0.0064010542, 0.0021200142), 
   (nf_acc_damage_amt_total > 112.5) => -0.0402382384, 0.0009191401), 
(iv_src_drivers_lic_adl_count > 10.5) => -0.0556922092, 0.0005431544);

// Tree: 364
final_score_364 := map(
( NULL < nf_fp_srchphonesrchcountmo and nf_fp_srchphonesrchcountmo <= 5.5) => -0.0004535544, 
(nf_fp_srchphonesrchcountmo > 5.5) => map(
   ( NULL < nf_pct_rel_with_bk and nf_pct_rel_with_bk <= 0.0618622449) => -0.0465275523, 
   (nf_pct_rel_with_bk > 0.0618622449) => map(
      ( NULL < nf_accident_recency and nf_accident_recency <= 79.5) => -0.0114679715, 
      (nf_accident_recency > 79.5) => 0.0721817901, -0.0017273455), -0.0151770144), -0.0007186832);

// Tree: 365
final_score_365 := map(
( NULL < rv_I60_Inq_Count12 and rv_I60_Inq_Count12 <= 4.5) => map(
   ( NULL < nf_inq_per_ssn and nf_inq_per_ssn <= 9.5) => 0.0005467298, 
   (nf_inq_per_ssn > 9.5) => 0.0227041424, 0.0019824343), 
(rv_I60_Inq_Count12 > 4.5) => map(
   ( NULL < nf_fp_srchfraudsrchcountmo and nf_fp_srchfraudsrchcountmo <= 1.5) => 0.0023173539, 
   (nf_fp_srchfraudsrchcountmo > 1.5) => -0.0154598879, -0.0044396488), 0.0005582803);

// Tree: 366
final_score_366 := map(
( NULL < rv_C12_source_profile and rv_C12_source_profile <= 0.05) => map(
   ( NULL < nf_add_curr_mobility_index and nf_add_curr_mobility_index <= 0.29018861775) => -0.0105052152, 
   (nf_add_curr_mobility_index > 0.29018861775) => map(
      ( NULL < nf_hh_workers_paw_pct and nf_hh_workers_paw_pct <= 0.29285714285) => 0.0397057787, 
      (nf_hh_workers_paw_pct > 0.29285714285) => 0.1447221065, 0.0595737326), 0.0250629751), 
(rv_C12_source_profile > 0.05) => 0.0005389376, 0.0007690458);

// Tree: 367
final_score_367 := map(
(nf_fp_addrchangeecontraj in ['AD','AE','BA','CA','DB','EA','EB','FU','UC','UD','UE','UF','UU']) => -0.0838313727, 
(nf_fp_addrchangeecontraj in ['-1','AA','AB','AC','AF','AU','BB','BC','BD','BE','BF','BU','CB','CC','CD','CE','CF','CU','DA','DC','DD','DE','DF','DU','EC','ED','EE','EF','EU','FA','FB','FC','FD','FE','FF']) => map(
   ( NULL < nf_add_curr_nhood_MFD_pct and nf_add_curr_nhood_MFD_pct <= 0.03474693865) => -0.0053873801, 
   (nf_add_curr_nhood_MFD_pct > 0.03474693865) => map(
      ( NULL < iv_college_tier and iv_college_tier <= 4.5) => 0.0023792249, 
      (iv_college_tier > 4.5) => 0.0222940124, 0.0037979805), 0.0005839167), 0.0003177286);

// Tree: 368
final_score_368 := map(
( NULL < nf_fp_srchssnsrchcountwk and nf_fp_srchssnsrchcountwk <= 4.5) => 0.0005754183, 
(nf_fp_srchssnsrchcountwk > 4.5) => map(
   ( NULL < rv_mos_since_br_first_seen and rv_mos_since_br_first_seen <= 48.5) => map(
      ( NULL < nf_add_curr_nhood_BUS_pct and nf_add_curr_nhood_BUS_pct <= 0.0283769063) => 0.0077433101, 
      (nf_add_curr_nhood_BUS_pct > 0.0283769063) => -0.0661209719, -0.0323589718), 
   (rv_mos_since_br_first_seen > 48.5) => 0.0650700967, -0.0220737534), 0.0004235337);

// Tree: 369
final_score_369 := map(
( NULL < nf_fp_srchcomponentrisktype and nf_fp_srchcomponentrisktype <= 4.5) => 0.0005880036, 
(nf_fp_srchcomponentrisktype > 4.5) => map(
   (iv_prof_license_source in ['IN','PL']) => -0.0049680717, 
   (iv_prof_license_source in ['PM']) => 0.1281667529, map(
      ( NULL < nf_add_curr_nhood_VAC_pct and nf_add_curr_nhood_VAC_pct <= 1.34966266865) => -0.0082979369, 
      (nf_add_curr_nhood_VAC_pct > 1.34966266865) => 0.1239892272, -0.0075666945)), -0.0003953738);

// Tree: 370
final_score_370 := map(
(nf_fp_addrchangeecontraj in ['AC','AE','AF','BA','BF','CA','CB','DU','EU','FB','UC','UD','UE','UF']) => -0.0776062706, 
(nf_fp_addrchangeecontraj in ['-1','AA','AB','AD','AU','BB','BC','BD','BE','BU','CC','CD','CE','CF','CU','DA','DB','DC','DD','DE','DF','EA','EB','EC','ED','EE','EF','FA','FC','FD','FE','FF','FU','UU']) => map(
   ( NULL < rv_A49_curr_add_avm_pct_chg_2yr and rv_A49_curr_add_avm_pct_chg_2yr <= 0.3920088978) => -0.0551450054, 
   (rv_A49_curr_add_avm_pct_chg_2yr > 0.3920088978) => map(
      ( NULL < nf_attr_arrest_recency and nf_attr_arrest_recency <= 30) => 0.0913821363, 
      (nf_attr_arrest_recency > 30) => 0.0286881993, 0.0030571561), 0.0008968875), 0.0014760034);

// Tree: 371
final_score_371 := map(
( NULL < nf_rel_count and nf_rel_count <= 75.5) => map(
   (nf_historic_x_current_ct in ['0-0','1-1','2-1','2-2','3-2','3-3']) => -0.0020611785, 
   (nf_historic_x_current_ct in ['1-0','2-0','3-0','3-1']) => map(
      ( NULL < nf_pct_rel_prop_owned and nf_pct_rel_prop_owned <= 0.27429467085) => 0.0360196511, 
      (nf_pct_rel_prop_owned > 0.27429467085) => 0.0042806456, 0.0094955119), -0.0004331255), 
(nf_rel_count > 75.5) => 0.1486255130, -0.0003103487);

// Tree: 372
final_score_372 := map(
( NULL < nf_util_adl_count and nf_util_adl_count <= 4.5) => map(
   (nf_fp_addrchangeecontraj in ['-1','AA','AC','AF','BB','BE','BU','CA','CB','CC','CD','CE','CF','DA','DC','DD','DE','DF','DU','EA','EB','ED','EE','EF','EU','FA','FB','FC','FE','FF','UC','UD','UE','UF','UU']) => -0.0058142088, 
   (nf_fp_addrchangeecontraj in ['AB','AD','AE','AU','BA','BC','BD','BF','CU','DB','EC','FD','FU']) => map(
      ( NULL < nf_hh_workers_paw_pct and nf_hh_workers_paw_pct <= 0.13392857145) => 0.1266192588, 
      (nf_hh_workers_paw_pct > 0.13392857145) => 0.0002804127, 0.0540039407), -0.0052914595), 
(nf_util_adl_count > 4.5) => 0.0047910196, -0.0015644317);

// Tree: 373
final_score_373 := map(
( NULL < nf_hh_college_attendees and nf_hh_college_attendees <= 4.5) => map(
   ( NULL < nf_inq_lnames_per_ssn and nf_inq_lnames_per_ssn <= 3.5) => map(
      ( NULL < rv_S66_adlperssn_count and rv_S66_adlperssn_count <= 6.5) => -0.0011246083, 
      (rv_S66_adlperssn_count > 6.5) => 0.0729564863, -0.0009362382), 
   (nf_inq_lnames_per_ssn > 3.5) => -0.0696622923, -0.0010522487), 
(nf_hh_college_attendees > 4.5) => 0.0849156223, -0.0009570878);

// Tree: 374
final_score_374 := map(
( NULL < rv_I60_inq_mortgage_count12 and rv_I60_inq_mortgage_count12 <= 1.5) => -0.0004583851, 
(rv_I60_inq_mortgage_count12 > 1.5) => map(
   (iv_D34_liens_unrel_x_rel in ['0-1','0-2','1-0','1-1','2-0','2-1']) => -0.0370442469, 
   (iv_D34_liens_unrel_x_rel in ['0-0','1-2','2-2','3-0','3-1','3-2']) => map(
      (nf_util_adl_summary in ['|  M|','| CM|','|IC |']) => 0.0122077031, 
      (nf_util_adl_summary in ['|   |','| C |','|I  |','|I M|','|ICM|']) => 0.1966364104, 0.1085510576), 0.0648344518), -0.0001365096);

// Tree: 375
final_score_375 := map(
( NULL < rv_S66_adlperssn_count and rv_S66_adlperssn_count <= 2.5) => -0.0032558970, 
(rv_S66_adlperssn_count > 2.5) => map(
   ( NULL < rv_C12_source_profile and rv_C12_source_profile <= 48.9) => map(
      ( NULL < nf_fp_divrisktype and nf_fp_divrisktype <= 5.5) => 0.0219753173, 
      (nf_fp_divrisktype > 5.5) => 0.1174767097, 0.0243826856), 
   (rv_C12_source_profile > 48.9) => 0.0029036860, 0.0077510056), -0.0010639218);

// Tree: 376
final_score_376 := map(
( NULL < nf_rel_felony_count and nf_rel_felony_count <= 2.5) => map(
   ( NULL < rv_L79_adls_per_sfd_addr_c6 and rv_L79_adls_per_sfd_addr_c6 <= 0.5) => -0.0024837614, 
   (rv_L79_adls_per_sfd_addr_c6 > 0.5) => map(
      ( NULL < nf_fp_prevaddrmedianincome and nf_fp_prevaddrmedianincome <= 22786) => 0.0548149178, 
      (nf_fp_prevaddrmedianincome > 22786) => 0.0056261043, 0.0071570896), 0.0014691985), 
(nf_rel_felony_count > 2.5) => -0.0126151897, 0.0007261307);

// Tree: 377
final_score_377 := map(
( NULL < rv_C13_max_lres and rv_C13_max_lres <= 29.5) => -0.0221952999, 
(rv_C13_max_lres > 29.5) => map(
   ( NULL < nf_hh_collections_ct and nf_hh_collections_ct <= 7.5) => -0.0009409356, 
   (nf_hh_collections_ct > 7.5) => map(
      ( NULL < iv_prv_addr_avm_auto_val and iv_prv_addr_avm_auto_val <= 49720) => 0.0094266607, 
      (iv_prv_addr_avm_auto_val > 49720) => 0.1250932198, 0.0642160835), -0.0006508794), -0.0013274961);

// Tree: 378
final_score_378 := map(
( NULL < nf_fp_srchfraudsrchcountmo and nf_fp_srchfraudsrchcountmo <= 1.5) => map(
   ( NULL < nf_fp_srchphonesrchcountwk and nf_fp_srchphonesrchcountwk <= 1.5) => 0.0026372121, 
   (nf_fp_srchphonesrchcountwk > 1.5) => map(
      (nf_fp_addrchangeecontraj in ['AA','BC','CC','DD','DE','DF','FD','FF']) => 0.0018555804, 
      (nf_fp_addrchangeecontraj in ['-1','AB','AC','AD','AE','AF','AU','BA','BB','BD','BE','BF','BU','CA','CB','CD','CE','CF','CU','DA','DB','DC','DU','EA','EB','EC','ED','EE','EF','EU','FA','FB','FC','FE','FU','UC','UD','UE','UF','UU']) => 0.1636482230, 0.0761927405), 0.0028161588), 
(nf_fp_srchfraudsrchcountmo > 1.5) => -0.0065906356, 0.0007754308);

// Tree: 379
final_score_379 := map(
( NULL < nf_inq_Communications_count24 and nf_inq_Communications_count24 <= 10.5) => map(
   ( NULL < nf_fp_curraddractivephonelist and nf_fp_curraddractivephonelist <= 0.5) => map(
      ( NULL < rv_email_domain_free_count and rv_email_domain_free_count <= 13.5) => -0.0031238501, 
      (rv_email_domain_free_count > 13.5) => 0.1356348861, -0.0029149534), 
   (nf_fp_curraddractivephonelist > 0.5) => 0.0054843431, 0.0011005538), 
(nf_inq_Communications_count24 > 10.5) => 0.0776393974, 0.0011576929);

// Tree: 380
final_score_380 := map(
( NULL < nf_fp_srchaddrsrchcountday and nf_fp_srchaddrsrchcountday <= 3.5) => map(
   ( NULL < nf_oldest_rel_age and nf_oldest_rel_age <= 35) => map(
      ( NULL < nf_fp_srchssnsrchcountwk and nf_fp_srchssnsrchcountwk <= 0.5) => -0.0172491032, 
      (nf_fp_srchssnsrchcountwk > 0.5) => -0.0586062053, -0.0242910661), 
   (nf_oldest_rel_age > 35) => 0.0009253576, 0.0004592301), 
(nf_fp_srchaddrsrchcountday > 3.5) => -0.0460840913, 0.0003555941);

// Tree: 381
final_score_381 := map(
( NULL < nf_Inq_Per_Add_NAS_479 and nf_Inq_Per_Add_NAS_479 <= 9.5) => map(
   ( NULL < nf_Inq_Per_Add_NAS_479 and nf_Inq_Per_Add_NAS_479 <= 5.5) => -0.0006435046, 
   (nf_Inq_Per_Add_NAS_479 > 5.5) => map(
      (nf_fp_addrchangeecontraj in ['-1','AA','AC','AE','AF','CB','CC','CD','DA','DD','EA','EB','EC','EE','EF','FC','FD']) => -0.0306524869, 
      (nf_fp_addrchangeecontraj in ['AB','AD','AU','BA','BB','BC','BD','BE','BF','BU','CA','CE','CF','CU','DB','DC','DE','DF','DU','ED','EU','FA','FB','FE','FF','FU','UC','UD','UE','UF','UU']) => 0.1396378837, 0.0447781471), -0.0005562746), 
(nf_Inq_Per_Add_NAS_479 > 9.5) => -0.0649039255, -0.0006564724);

// Tree: 382
final_score_382 := map(
( NULL < nf_average_rel_distance and nf_average_rel_distance <= 297.5) => map(
   ( NULL < rv_P88_Phn_Dst_to_Inp_Add and rv_P88_Phn_Dst_to_Inp_Add <= 107.5) => 0.0013868838, 
   (rv_P88_Phn_Dst_to_Inp_Add > 107.5) => 0.0488966601, 0.0044398339), 
(nf_average_rel_distance > 297.5) => map(
   ( NULL < nf_inq_Other_count24 and nf_inq_Other_count24 <= 23.5) => -0.0078158811, 
   (nf_inq_Other_count24 > 23.5) => 0.1237509035, -0.0072455973), -0.0002335995);

// Tree: 383
final_score_383 := map(
(nf_fp_addrchangeecontraj in ['AC','AD','AF','BA','BE','BU','CA','CF','CU','DF','EA','ED','EF','FD','UC','UE','UU']) => -0.0345688624, 
(nf_fp_addrchangeecontraj in ['-1','AA','AB','AE','AU','BB','BC','BD','BF','CB','CC','CD','CE','DA','DB','DC','DD','DE','DU','EB','EC','EE','EU','FA','FB','FC','FE','FF','FU','UD','UF']) => map(
   ( NULL < nf_inq_HighRiskCredit_count24 and nf_inq_HighRiskCredit_count24 <= 1.5) => map(
      (nf_fp_addrchangeecontraj in ['-1','AA','BB','BC','BD','BF','CB','CC','CD','CE','DB','DC','DD','DE','EB','EC','EE','FC','FE','FF','FU','UF']) => -0.0078908928, 
      (nf_fp_addrchangeecontraj in ['AB','AC','AD','AE','AF','AU','BA','BE','BU','CA','CF','CU','DA','DF','DU','EA','ED','EF','EU','FA','FB','FD','UC','UD','UE','UU']) => 0.1746297526, -0.0075986350), 
   (nf_inq_HighRiskCredit_count24 > 1.5) => 0.0031567642, -0.0014353604), -0.0021326070);

// Tree: 384
final_score_384 := map(
( NULL < nf_inq_Collection_count24 and nf_inq_Collection_count24 <= 0.5) => -0.0025570500, 
(nf_inq_Collection_count24 > 0.5) => map(
   ( NULL < rv_C12_source_profile and rv_C12_source_profile <= 3) => map(
      ( NULL < nf_add_curr_mobility_index and nf_add_curr_mobility_index <= 0.3198196049) => 0.0157509808, 
      (nf_add_curr_mobility_index > 0.3198196049) => 0.1801203983, 0.0783174042), 
   (rv_C12_source_profile > 3) => 0.0053252226, 0.0057506969), 0.0002864106);

// Tree: 385
final_score_385 := map(
( NULL < rv_I60_Inq_Count12 and rv_I60_Inq_Count12 <= 12.5) => map(
   ( NULL < nf_phones_per_apt_addr_curr and nf_phones_per_apt_addr_curr <= 42.5) => 0.0009704827, 
   (nf_phones_per_apt_addr_curr > 42.5) => map(
      ( NULL < nf_fp_prevaddrmedianvalue and nf_fp_prevaddrmedianvalue <= 161227.5) => 0.0873380103, 
      (nf_fp_prevaddrmedianvalue > 161227.5) => 0.0031852792, 0.0397981032), 0.0012746731), 
(rv_I60_Inq_Count12 > 12.5) => -0.0217156278, 0.0006861039);

// Tree: 386
final_score_386 := map(
( NULL < rv_C14_addrs_10yr and rv_C14_addrs_10yr <= 15.5) => map(
   ( NULL < iv_inp_add_avm_pct_chg_2yr and iv_inp_add_avm_pct_chg_2yr <= 0.7527946608) => -0.0227250394, 
   (iv_inp_add_avm_pct_chg_2yr > 0.7527946608) => 0.0049454202, map(
      ( NULL < rv_C21_stl_recency and rv_C21_stl_recency <= 18) => 0.0000943935, 
      (rv_C21_stl_recency > 18) => 0.1046528490, 0.0003735395)), 
(rv_C14_addrs_10yr > 15.5) => 0.0919558443, 0.0016421342);

// Tree: 387
final_score_387 := map(
( NULL < rv_C13_max_lres and rv_C13_max_lres <= 45.5) => map(
   ( NULL < nf_add_input_nhood_BUS_pct and nf_add_input_nhood_BUS_pct <= 0.02257763055) => 0.0040636213, 
   (nf_add_input_nhood_BUS_pct > 0.02257763055) => -0.0198585668, -0.0113840116), 
(rv_C13_max_lres > 45.5) => map(
   ( NULL < nf_add_input_nhood_VAC_pct and nf_add_input_nhood_VAC_pct <= 0.2509991346) => 0.0025569502, 
   (nf_add_input_nhood_VAC_pct > 0.2509991346) => -0.0198380715, 0.0012809050), 0.0001276076);

// Tree: 388
final_score_388 := map(
( NULL < iv_unverified_addr_count and iv_unverified_addr_count <= 0.5) => map(
   ( NULL < nf_hh_criminals_pct and nf_hh_criminals_pct <= 0.22902097905) => -0.0219869498, 
   (nf_hh_criminals_pct > 0.22902097905) => map(
      ( NULL < nf_hh_members_w_derog_pct and nf_hh_members_w_derog_pct <= 0.5590277778) => 0.0352019466, 
      (nf_hh_members_w_derog_pct > 0.5590277778) => -0.0206929864, 0.0083979532), -0.0139877740), 
(iv_unverified_addr_count > 0.5) => 0.0009419910, -0.0007170852);

// Tree: 389
final_score_389 := map(
( NULL < nf_historical_count and nf_historical_count <= 25.5) => map(
   (nf_fp_addrchangeecontraj in ['AF','BA','BU','CA','CF','CU','EB','EU','UC','UE','UF','UU']) => -0.0893196901, 
   (nf_fp_addrchangeecontraj in ['-1','AA','AB','AC','AD','AE','AU','BB','BC','BD','BE','BF','CB','CC','CD','CE','DA','DB','DC','DD','DE','DF','DU','EA','EC','ED','EE','EF','FA','FB','FC','FD','FE','FF','FU','UD']) => -0.0015133462, -0.0017522797), 
(nf_historical_count > 25.5) => map(
   ( NULL < nf_inq_Auto_count24 and nf_inq_Auto_count24 <= 1.5) => 0.0171597807, 
   (nf_inq_Auto_count24 > 1.5) => 0.1759139853, 0.0735593008), -0.0016049387);

// Tree: 390
final_score_390 := map(
( NULL < rv_mos_since_br_first_seen and rv_mos_since_br_first_seen <= 309.5) => -0.0000303270, 
(rv_mos_since_br_first_seen > 309.5) => map(
   ( NULL < nf_M_Bureau_ADL_FS_noTU and nf_M_Bureau_ADL_FS_noTU <= 376.5) => map(
      ( NULL < nf_fp_prevaddrmurderindex and nf_fp_prevaddrmurderindex <= 30.5) => 0.1789508053, 
      (nf_fp_prevaddrmurderindex > 30.5) => -0.0060134534, 0.0286286820), 
   (nf_M_Bureau_ADL_FS_noTU > 376.5) => 0.3019724980, 0.0736769645), 0.0003093205);

// Tree: 391
final_score_391 := map(
( NULL < nf_mos_foreclosure_lseen and nf_mos_foreclosure_lseen <= 35.5) => map(
   (iv_prof_license_source in ['PL']) => -0.0058472301, 
   (iv_prof_license_source in ['IN','PM']) => map(
      (nf_fp_addrchangeecontraj in ['AA','AB','BC','DC','DD','DE','ED','FC','FD','FE','UU']) => -0.0441838199, 
      (nf_fp_addrchangeecontraj in ['-1','AC','AD','AE','AF','AU','BA','BB','BD','BE','BF','BU','CA','CB','CC','CD','CE','CF','CU','DA','DB','DF','DU','EA','EB','EC','EE','EF','EU','FA','FB','FF','FU','UC','UD','UE','UF']) => 0.0950590040, 0.0499820898), 0.0019937003), 
(nf_mos_foreclosure_lseen > 35.5) => -0.0264628724, 0.0007553716);

// Tree: 392
final_score_392 := map(
( NULL < rv_I62_inq_phones_per_adl and rv_I62_inq_phones_per_adl <= 6.5) => map(
   ( NULL < nf_inq_count_week and nf_inq_count_week <= 1.5) => -0.0001817375, 
   (nf_inq_count_week > 1.5) => map(
      ( NULL < rv_A49_curr_add_avm_chg_3yr and rv_A49_curr_add_avm_chg_3yr <= 12057.5) => -0.0422411035, 
      (rv_A49_curr_add_avm_chg_3yr > 12057.5) => 0.0215948327, 0.0223692862), 0.0001803815), 
(rv_I62_inq_phones_per_adl > 6.5) => 0.0853587181, 0.0002373877);

// Tree: 393
final_score_393 := map(
( NULL < nf_fp_srchphonesrchcountwk and nf_fp_srchphonesrchcountwk <= 2.5) => 0.0000072303, 
(nf_fp_srchphonesrchcountwk > 2.5) => map(
   ( NULL < nf_phones_per_apt_addr_curr and nf_phones_per_apt_addr_curr <= 5.5) => map(
      ( NULL < nf_fp_srchssnsrchcountmo and nf_fp_srchssnsrchcountmo <= 2.5) => 0.1068305246, 
      (nf_fp_srchssnsrchcountmo > 2.5) => 0.0149560044, 0.0226484998), 
   (nf_phones_per_apt_addr_curr > 5.5) => -0.0599152433, 0.0173966641), 0.0003102819);

// Tree: 394
final_score_394 := map(
( NULL < iv_mos_src_voter_adl_lseen and iv_mos_src_voter_adl_lseen <= 164.5) => map(
   ( NULL < nf_bus_addr_match_count and nf_bus_addr_match_count <= 0.5) => -0.0034787243, 
   (nf_bus_addr_match_count > 0.5) => map(
      ( NULL < nf_inq_HighRiskCredit_count_week and nf_inq_HighRiskCredit_count_week <= 4.5) => 0.0071463180, 
      (nf_inq_HighRiskCredit_count_week > 4.5) => 0.0933273002, 0.0074383701), -0.0011054123), 
(iv_mos_src_voter_adl_lseen > 164.5) => 0.0627411260, -0.0008498519);

// Tree: 395
final_score_395 := map(
( NULL < rv_I60_inq_recency and rv_I60_inq_recency <= 0.5) => map(
   ( NULL < nf_average_rel_home_val and nf_average_rel_home_val <= 410500) => 0.0173813330, 
   (nf_average_rel_home_val > 410500) => map(
      ( NULL < iv_prv_addr_avm_auto_val and iv_prv_addr_avm_auto_val <= 79595) => 0.2070761361, 
      (iv_prv_addr_avm_auto_val > 79595) => 0.0313720215, 0.1274602092), 0.0359294220), 
(rv_I60_inq_recency > 0.5) => 0.0002620096, 0.0006379876);

// Tree: 396
final_score_396 := map(
( NULL < nf_fp_prevaddrcartheftindex and nf_fp_prevaddrcartheftindex <= 17) => map(
   ( NULL < iv_C14_addrs_per_adl and iv_C14_addrs_per_adl <= 14.5) => 0.0122250860, 
   (iv_C14_addrs_per_adl > 14.5) => map(
      ( NULL < nf_fp_prevaddrburglaryindex and nf_fp_prevaddrburglaryindex <= 11.5) => 0.2072841781, 
      (nf_fp_prevaddrburglaryindex > 11.5) => 0.0101559341, 0.0904674409), 0.0139105365), 
(nf_fp_prevaddrcartheftindex > 17) => -0.0017948543, -0.0005279840);

// Tree: 397
final_score_397 := map(
(iv_college_major in ['BUSINESS','LIBERAL ARTS','NO AMS FOUND','NO COLLEGE FOUND','SCIENCE','UNCLASSIFIED']) => map(
   (iv_full_name_ver_sources in ['PHN & NONPHN']) => -0.0016505821, 
   (iv_full_name_ver_sources in ['NAME NOT VERD','NONPHN ONLY','PHN ONLY']) => 0.0044377379, 0.0000791630), 
(iv_college_major in ['MEDICAL']) => map(
   ( NULL < nf_fp_srchcomponentrisktype and nf_fp_srchcomponentrisktype <= 3.5) => 0.0203133823, 
   (nf_fp_srchcomponentrisktype > 3.5) => 0.0787558632, 0.0313722496), 0.0003707560);

// Tree: 398
final_score_398 := map(
( NULL < nf_fp_srchphonesrchcountmo and nf_fp_srchphonesrchcountmo <= 0.5) => -0.0024593145, 
(nf_fp_srchphonesrchcountmo > 0.5) => map(
   ( NULL < rv_I60_Inq_Count12 and rv_I60_Inq_Count12 <= 4.5) => map(
      (nf_fp_addrchangeecontraj in ['AA','AC','AD','AF','BB','BD','BU','CA','CC','CD','CE','CF','CU','DA','DD','DF','EB','EE','EF','EU','FB','FD','FF','FU','UC','UD','UE','UU']) => 0.0064657814, 
      (nf_fp_addrchangeecontraj in ['-1','AB','AE','AU','BA','BC','BE','BF','CB','DB','DC','DE','DU','EA','EC','ED','FA','FC','FE','UF']) => 0.0309069269, 0.0110760167), 
   (rv_I60_Inq_Count12 > 4.5) => -0.0057357047, 0.0056161782), 0.0001039430);

// Tree: 399
final_score_399 := map(
( NULL < iv_src_drivers_lic_adl_count and iv_src_drivers_lic_adl_count <= 11.5) => map(
   ( NULL < nf_average_rel_income and nf_average_rel_income <= 119500) => -0.0000001597, 
   (nf_average_rel_income > 119500) => map(
      ( NULL < rv_I60_inq_recency and rv_I60_inq_recency <= 2) => 0.1485579434, 
      (rv_I60_inq_recency > 2) => 0.0266496935, 0.0629068885), 0.0001884574), 
(iv_src_drivers_lic_adl_count > 11.5) => -0.0622723199, -0.0000671933);

// Tree: 400
final_score_400 := map(
( NULL < nf_add_input_nhood_BUS_pct and nf_add_input_nhood_BUS_pct <= 0.00244249955) => -0.0142813779, 
(nf_add_input_nhood_BUS_pct > 0.00244249955) => map(
   ( NULL < nf_pct_rel_prop_owned and nf_pct_rel_prop_owned <= 0.30662393165) => map(
      (iv_full_name_ver_sources in ['PHN & NONPHN','PHN ONLY']) => 0.0029004391, 
      (iv_full_name_ver_sources in ['NAME NOT VERD','NONPHN ONLY']) => 0.0159732246, 0.0072700527), 
   (nf_pct_rel_prop_owned > 0.30662393165) => -0.0014262284, 0.0008559796), -0.0002791615);

// Tree: 401
final_score_401 := map(
( NULL < nf_liens_unrel_ST_total_amt and nf_liens_unrel_ST_total_amt <= 13825) => map(
   ( NULL < rv_I60_inq_hiRiskCred_count12 and rv_I60_inq_hiRiskCred_count12 <= 8.5) => 0.0006088485, 
   (rv_I60_inq_hiRiskCred_count12 > 8.5) => map(
      ( NULL < rv_L79_adls_per_addr_c6 and rv_L79_adls_per_addr_c6 <= 3.5) => -0.0151728121, 
      (rv_L79_adls_per_addr_c6 > 3.5) => 0.0415429105, -0.0118246163), -0.0001948100), 
(nf_liens_unrel_ST_total_amt > 13825) => -0.0959476300, -0.0003414754);

// Tree: 402
final_score_402 := map(
( NULL < rv_D32_criminal_count and rv_D32_criminal_count <= 16.5) => map(
   ( NULL < iv_br_source_count and iv_br_source_count <= 1.5) => -0.0010207715, 
   (iv_br_source_count > 1.5) => 0.0149467273, 0.0003029697), 
(rv_D32_criminal_count > 16.5) => map(
   (nf_historic_x_current_ct in ['0-0','2-0','2-2','3-0']) => -0.1406500291, 
   (nf_historic_x_current_ct in ['1-0','1-1','2-1','3-1','3-2','3-3']) => -0.0223406350, -0.0555736109), 0.0001749493);

// Tree: 403
final_score_403 := map(
( NULL < rv_D32_attr_felonies_recency and rv_D32_attr_felonies_recency <= 79.5) => map(
   (nf_fp_addrchangeecontraj in ['-1','AA','AB','AE','AF','BA','BB','BD','BF','BU','CA','CB','CC','CD','CU','DA','DC','DD','DF','DU','EA','EC','ED','EE','EF','EU','FD','FF','UC','UE','UU']) => -0.0008523293, 
   (nf_fp_addrchangeecontraj in ['AC','AD','AU','BC','BE','CE','CF','DB','DE','EB','FA','FB','FC','FE','FU','UD','UF']) => 0.0373283579, -0.0002728082), 
(rv_D32_attr_felonies_recency > 79.5) => map(
   ( NULL < nf_fp_prevaddrmedianvalue and nf_fp_prevaddrmedianvalue <= 61042.5) => 0.0595453362, 
   (nf_fp_prevaddrmedianvalue > 61042.5) => -0.0370687766, -0.0278765518), -0.0006312799);

// Tree: 404
final_score_404 := map(
( NULL < iv_inp_add_avm_pct_chg_3yr and iv_inp_add_avm_pct_chg_3yr <= 1.14718706505) => map(
   ( NULL < nf_add_input_nhood_VAC_pct and nf_add_input_nhood_VAC_pct <= 0.1616897679) => map(
      ( NULL < nf_liens_unrel_ST_total_amt and nf_liens_unrel_ST_total_amt <= 172) => 0.0106628795, 
      (nf_liens_unrel_ST_total_amt > 172) => 0.0745205315, 0.0143946472), 
   (nf_add_input_nhood_VAC_pct > 0.1616897679) => -0.0344125478, 0.0083391049), 
(iv_inp_add_avm_pct_chg_3yr > 1.14718706505) => -0.0084197109, 0.0027411334);

// Tree: 405
final_score_405 := map(
( NULL < nf_QB4987_Synthetic_Index and nf_QB4987_Synthetic_Index <= 1.5) => map(
   ( NULL < iv_prv_addr_lres and iv_prv_addr_lres <= 7.5) => map(
      (nf_fp_addrchangeecontraj in ['-1','AA','AC','AD','BA','BB','BC','BF','CA','CB','CC','CD','CE','CF','DA','DB','DC','DD','DE','EA','EB','EC','ED','EE','FA','FC','FD','FE','FF','FU','UU']) => 0.0088631774, 
      (nf_fp_addrchangeecontraj in ['AB','AE','AF','AU','BD','BE','BU','CU','DF','DU','EF','EU','FB','UC','UD','UE','UF']) => 0.1259355963, 0.0104299459), 
   (iv_prv_addr_lres > 7.5) => -0.0021924461, -0.0134390353), 
(nf_QB4987_Synthetic_Index > 1.5) => 0.0672355177, -0.0013841549);

// Tree: 406
final_score_406 := map(
(nf_fp_addrchangeecontraj in ['AB','AE','BD','BU','CA','DC','DE','EA','EC','EF','FE','FU','UC','UE','UU']) => -0.0321769807, 
(nf_fp_addrchangeecontraj in ['-1','AA','AC','AD','AF','AU','BA','BB','BC','BE','BF','CB','CC','CD','CE','CF','CU','DA','DB','DD','DF','DU','EB','ED','EE','EU','FA','FB','FC','FD','FF','UD','UF']) => map(
   ( NULL < nf_fp_srchaddrsrchcountday and nf_fp_srchaddrsrchcountday <= 4.5) => map(
      ( NULL < nf_fp_addrchangevaluediff and nf_fp_addrchangevaluediff <= -310460) => 0.1158974470, 
      (nf_fp_addrchangevaluediff > -310460) => 0.0008182717, 0.0010244280), 
   (nf_fp_srchaddrsrchcountday > 4.5) => 0.0798155345, 0.0011052979), 0.0003766483);

// Tree: 407
final_score_407 := map(
( NULL < iv_Estimated_Income and iv_Estimated_Income <= 138500) => -0.0005163000, 
(iv_Estimated_Income > 138500) => map(
   ( NULL < nf_fp_prevaddrageoldest and nf_fp_prevaddrageoldest <= 57) => -0.0352463391, 
   (nf_fp_prevaddrageoldest > 57) => map(
      ( NULL < nf_pct_rel_with_bk and nf_pct_rel_with_bk <= 0.06458333335) => 0.1682366207, 
      (nf_pct_rel_with_bk > 0.06458333335) => 0.0478787456, 0.0922211206), 0.0476948162), -0.0003350995);

// Tree: 408
final_score_408 := map(
( NULL < nf_fp_srchunvrfdssncount and nf_fp_srchunvrfdssncount <= 2.5) => map(
   ( NULL < iv_prv_addr_lres and iv_prv_addr_lres <= 1.5) => 0.0212935326, 
   (iv_prv_addr_lres > 1.5) => 0.0001388919, -0.0081823123), 
(nf_fp_srchunvrfdssncount > 2.5) => map(
   ( NULL < nf_fp_prevaddrageoldest and nf_fp_prevaddrageoldest <= 50.5) => 0.1312610253, 
   (nf_fp_prevaddrageoldest > 50.5) => -0.0191058367, 0.0620922688), 0.0007132171);

// Tree: 409
final_score_409 := map(
(rv_D32_criminal_x_felony in ['0-0','1-0','2-0','2-1','3-0','3-1','3-2','3-3']) => -0.0001378878, 
(rv_D32_criminal_x_felony in ['1-1','2-2']) => map(
   ( NULL < nf_hh_workers_paw_pct and nf_hh_workers_paw_pct <= 0.48076923075) => map(
      ( NULL < nf_fp_prevaddrageoldest and nf_fp_prevaddrageoldest <= 62.5) => 0.1872542717, 
      (nf_fp_prevaddrageoldest > 62.5) => 0.0237993166, 0.1082063836), 
   (nf_hh_workers_paw_pct > 0.48076923075) => -0.0371244279, 0.0502172421), -0.0000063158);

// Tree: 410
final_score_410 := map(
( NULL < iv_inp_add_avm_pct_chg_1yr and iv_inp_add_avm_pct_chg_1yr <= 3.6391017678) => map(
   ( NULL < nf_fp_srchaddrsrchcountmo and nf_fp_srchaddrsrchcountmo <= 7.5) => -0.0034102742, 
   (nf_fp_srchaddrsrchcountmo > 7.5) => map(
      ( NULL < rv_A49_Curr_AVM_Chg_1yr and rv_A49_Curr_AVM_Chg_1yr <= 6269.5) => 0.0894705373, 
      (rv_A49_Curr_AVM_Chg_1yr > 6269.5) => 0.0139479051, -0.0331407046), -0.0028809141), 
(iv_inp_add_avm_pct_chg_1yr > 3.6391017678) => 0.1019350154, 0.0012816317);

// Tree: 411
final_score_411 := map(
( NULL < nf_inq_HighRiskCredit_count_day and nf_inq_HighRiskCredit_count_day <= 0.5) => -0.0005642296, 
(nf_inq_HighRiskCredit_count_day > 0.5) => map(
   (nf_fp_addrchangeecontraj in ['-1','AA','AC','AD','BB','BC','BE','CA','CC','CD','CE','CU','DB','DD','DE','EA','EB','EE','EF','FC','FE','FF','UU']) => map(
      ( NULL < nf_fp_prevaddrmedianincome and nf_fp_prevaddrmedianincome <= 24183) => 0.0747528492, 
      (nf_fp_prevaddrmedianincome > 24183) => 0.0071969850, 0.0109678637), 
   (nf_fp_addrchangeecontraj in ['AB','AE','AF','AU','BA','BD','BF','BU','CB','CF','DA','DC','DF','DU','EC','ED','EU','FA','FB','FD','FU','UC','UD','UE','UF']) => 0.1494626595, 0.0136329925), -0.0000134666);

// Tree: 412
final_score_412 := map(
( NULL < rv_L79_adls_per_addr_curr and rv_L79_adls_per_addr_curr <= 6.5) => -0.0017792846, 
(rv_L79_adls_per_addr_curr > 6.5) => map(
   ( NULL < rv_comb_age and rv_comb_age <= 21.5) => map(
      ( NULL < nf_fp_prevaddrlenofres and nf_fp_prevaddrlenofres <= 29.5) => 0.0025302495, 
      (nf_fp_prevaddrlenofres > 29.5) => 0.1846724238, 0.0594998282), 
   (rv_comb_age > 21.5) => 0.0088981743, 0.0101817944), -0.0003955185);

// Tree: 413
final_score_413 := map(
( NULL < nf_fp_srchfraudsrchcountmo and nf_fp_srchfraudsrchcountmo <= 1.5) => map(
   ( NULL < nf_fp_srchphonesrchcountwk and nf_fp_srchphonesrchcountwk <= 1.5) => -0.0004005460, 
   (nf_fp_srchphonesrchcountwk > 1.5) => map(
      ( NULL < rv_L79_adls_per_sfd_addr_c6 and rv_L79_adls_per_sfd_addr_c6 <= 1.5) => 0.0287144019, 
      (rv_L79_adls_per_sfd_addr_c6 > 1.5) => 0.1468726542, 0.0712807288), -0.0002090808), 
(nf_fp_srchfraudsrchcountmo > 1.5) => -0.0073012536, -0.0017652001);

// Tree: 414
final_score_414 := map(
(nf_fp_addrchangeecontraj in ['-1','AA','AB','AC','AD','AE','AF','BA','BB','BC','BD','BE','BF','BU','CA','CB','CC','CD','CE','CF','DA','DC','DD','DE','DF','DU','EA','EB','EC','ED','EE','EF','EU','FC','FD','FE','FF','FU','UC','UE','UU']) => map(
   ( NULL < iv_inp_add_avm_pct_chg_2yr and iv_inp_add_avm_pct_chg_2yr <= 3.1243182999) => 0.0009325742, 
   (iv_inp_add_avm_pct_chg_2yr > 3.1243182999) => -0.0703246841, map(
      ( NULL < nf_inq_lnames_per_sfd_addr and nf_inq_lnames_per_sfd_addr <= 3.5) => 0.0024455450, 
      (nf_inq_lnames_per_sfd_addr > 3.5) => -0.0296282009, 0.0018561562)), 
(nf_fp_addrchangeecontraj in ['AU','CU','DB','FA','FB','UD','UF']) => 0.1164593323, 0.0013106017);

// Tree: 415
final_score_415 := map(
( NULL < nf_Number_Non_Bureau_Sources and nf_Number_Non_Bureau_Sources <= 12.5) => map(
   ( NULL < nf_fp_srchunvrfdphonecount and nf_fp_srchunvrfdphonecount <= 4.5) => 0.0000859126, 
   (nf_fp_srchunvrfdphonecount > 4.5) => map(
      ( NULL < nf_liens_unrel_CJ_total_amt and nf_liens_unrel_CJ_total_amt <= 1134) => -0.0362430007, 
      (nf_liens_unrel_CJ_total_amt > 1134) => 0.0715242467, -0.0211513349), -0.0000527928), 
(nf_Number_Non_Bureau_Sources > 12.5) => 0.1389259588, 0.0000563322);

// Tree: 416
final_score_416 := map(
( NULL < nf_inq_Utilities_count24 and nf_inq_Utilities_count24 <= 0.5) => 0.0003015557, 
(nf_inq_Utilities_count24 > 0.5) => map(
   ( NULL < nf_fp_prevaddrmedianvalue and nf_fp_prevaddrmedianvalue <= 93260.5) => map(
      (rv_D32_criminal_x_felony in ['0-0','2-1','3-0','3-1','3-3']) => 0.0259538966, 
      (rv_D32_criminal_x_felony in ['1-0','1-1','2-0','2-2','3-2']) => 0.2481586150, 0.0748006235), 
   (nf_fp_prevaddrmedianvalue > 93260.5) => 0.0097309494, 0.0319311911), 0.0005783944);

// Tree: 417
final_score_417 := map(
( NULL < rv_I60_inq_comm_count12 and rv_I60_inq_comm_count12 <= 4.5) => -0.0005077782, 
(rv_I60_inq_comm_count12 > 4.5) => map(
   ( NULL < rv_comb_age and rv_comb_age <= 28.5) => 0.1216874684, 
   (rv_comb_age > 28.5) => map(
      ( NULL < iv_prv_addr_avm_auto_val and iv_prv_addr_avm_auto_val <= 15115) => 0.0601650592, 
      (iv_prv_addr_avm_auto_val > 15115) => -0.0523200333, 0.0058355247), 0.0398113351), -0.0003998344);

// Tree: 418
final_score_418 := map(
( NULL < rv_S65_SSN_Problem and rv_S65_SSN_Problem <= 0.5) => map(
   ( NULL < nf_fp_srchphonesrchcountwk and nf_fp_srchphonesrchcountwk <= 4.5) => -0.0007144887, 
   (nf_fp_srchphonesrchcountwk > 4.5) => map(
      ( NULL < nf_M_Bureau_ADL_FS_all and nf_M_Bureau_ADL_FS_all <= 261.5) => 0.0033679588, 
      (nf_M_Bureau_ADL_FS_all > 261.5) => -0.0878685084, -0.0316413832), -0.0008179580), 
(rv_S65_SSN_Problem > 0.5) => -0.0457936715, -0.0011501810);

// Tree: 419
final_score_419 := map(
( NULL < nf_fp_componentcharrisktype and nf_fp_componentcharrisktype <= 4.5) => 0.0022710008, 
(nf_fp_componentcharrisktype > 4.5) => map(
   (nf_fp_addrchangeecontraj in ['-1','AA','AC','AD','AE','AF','BA','BB','BC','BD','BF','CA','CC','CD','CE','DA','DB','DC','DD','DE','DF','EB','EC','ED','EE','EF','FA','FB','FE','FF','FU','UF','UU']) => map(
      ( NULL < nf_fp_srchcomponentrisktype and nf_fp_srchcomponentrisktype <= 3.5) => -0.0041615349, 
      (nf_fp_srchcomponentrisktype > 3.5) => -0.0126255148, -0.0057824471), 
   (nf_fp_addrchangeecontraj in ['AB','AU','BE','BU','CB','CF','CU','DU','EA','EU','FC','FD','UC','UD','UE']) => 0.1756060916, -0.0053413808), -0.0007914121);

// Tree: 420
final_score_420 := map(
( NULL < rv_I60_Inq_Count12 and rv_I60_Inq_Count12 <= 0.5) => map(
   ( NULL < rv_I60_inq_hiRiskCred_recency and rv_I60_inq_hiRiskCred_recency <= 9) => 0.0215312313, 
   (rv_I60_inq_hiRiskCred_recency > 9) => map(
      ( NULL < rv_C20_M_Bureau_ADL_FS and rv_C20_M_Bureau_ADL_FS <= 34.5) => 0.1968133250, 
      (rv_C20_M_Bureau_ADL_FS > 34.5) => -0.0067723789, -0.0055101330), 0.0064547225), 
(rv_I60_Inq_Count12 > 0.5) => -0.0013543021, 0.0001576310);

// Tree: 421
final_score_421 := map(
( NULL < rv_I60_inq_retpymt_recency and rv_I60_inq_retpymt_recency <= 61.5) => map(
   (nf_fp_addrchangeecontraj in ['AB','AD','AF','BE','BF','BU','CA','CB','DA','DB','DE','DU','EA','FA','FB','FC','FD','UC','UD','UE','UF','UU']) => -0.0360465469, 
   (nf_fp_addrchangeecontraj in ['-1','AA','AC','AE','AU','BA','BB','BC','BD','CC','CD','CE','CF','CU','DC','DD','DF','EB','EC','ED','EE','EF','EU','FE','FF','FU']) => 0.0026578008, 0.0021538856), 
(rv_I60_inq_retpymt_recency > 61.5) => map(
   ( NULL < iv_D34_liens_unrel_SC_ct and iv_D34_liens_unrel_SC_ct <= 2.5) => -0.0167917983, 
   (iv_D34_liens_unrel_SC_ct > 2.5) => 0.1315048581, -0.0147971104), 0.0004183372);

// Tree: 422
final_score_422 := map(
( NULL < nf_Inq_Per_SSN_NAS_479 and nf_Inq_Per_SSN_NAS_479 <= 16.5) => map(
   ( NULL < nf_Inq_Add_Per_SSN_NAS_479 and nf_Inq_Add_Per_SSN_NAS_479 <= 3.5) => map(
      ( NULL < iv_prof_license_category_PL and iv_prof_license_category_PL <= 1.5) => 0.0187999920, 
      (iv_prof_license_category_PL > 1.5) => -0.0152125064, -0.0011690832), 
   (nf_Inq_Add_Per_SSN_NAS_479 > 3.5) => -0.0849451089, -0.0008620519), 
(nf_Inq_Per_SSN_NAS_479 > 16.5) => 0.0767707121, -0.0007871120);

// Tree: 423
final_score_423 := map(
( NULL < nf_inq_count_week and nf_inq_count_week <= 3.5) => map(
   ( NULL < nf_inq_HighRiskCredit_count_day and nf_inq_HighRiskCredit_count_day <= 0.5) => -0.0003453009, 
   (nf_inq_HighRiskCredit_count_day > 0.5) => 0.0122063669, 0.0001253400), 
(nf_inq_count_week > 3.5) => map(
   ( NULL < nf_average_rel_age and nf_average_rel_age <= 42.5) => -0.0784279892, 
   (nf_average_rel_age > 42.5) => 0.0380596914, -0.0484053911), 0.0000041616);

// Tree: 424
final_score_424 := map(
( NULL < nf_inq_per_ssn and nf_inq_per_ssn <= 8.5) => -0.0011726339, 
(nf_inq_per_ssn > 8.5) => map(
   (nf_fp_addrchangeecontraj in ['-1','AA','AC','AE','AF','BA','BB','BC','BD','BE','CA','CC','CD','CE','CU','DB','DD','DE','DU','EA','EC','EE','EU','FA','FD','FE','UC','UE','UF','UU']) => 0.0033700033, 
   (nf_fp_addrchangeecontraj in ['AB','AD','AU','BF','BU','CB','CF','DA','DC','DF','EB','ED','EF','FB','FC','FF','FU','UD']) => map(
      ( NULL < rv_P88_Phn_Dst_to_Inp_Add and rv_P88_Phn_Dst_to_Inp_Add <= 225) => 0.0241063118, 
      (rv_P88_Phn_Dst_to_Inp_Add > 225) => 0.1449527784, 0.0108769566), 0.0078642462), 0.0006362074);

// Tree: 425
final_score_425 := map(
( NULL < rv_email_domain_ISP_count and rv_email_domain_ISP_count <= 3.5) => 0.0009072048, 
(rv_email_domain_ISP_count > 3.5) => map(
   (nf_fp_addrchangeecontraj in ['-1','AA','AB','AC','AE','BB','BC','BE','BU','CA','CC','CF','DA','DB','DC','DD','DE','DF','DU','EC','ED','EE','EF','EU','FA','FD','FE','FF','FU','UC','UU']) => map(
      ( NULL < rv_L80_Inp_AVM_AutoVal and rv_L80_Inp_AVM_AutoVal <= 88573) => -0.0232573487, 
      (rv_L80_Inp_AVM_AutoVal > 88573) => 0.0033481380, -0.0127503000), 
   (nf_fp_addrchangeecontraj in ['AD','AF','AU','BA','BD','BF','CB','CD','CE','CU','EA','EB','FB','FC','UD','UE','UF']) => 0.1908406234, -0.0112363002), -0.0006060055);

// Tree: 426
final_score_426 := map(
( NULL < nf_inq_per_apt_addr and nf_inq_per_apt_addr <= 29.5) => map(
   (rv_L76_Add_Curr_Seasonal in ['E','Y']) => -0.0781559084, 
   (rv_L76_Add_Curr_Seasonal in ['N']) => map(
      ( NULL < iv_Estimated_Income and iv_Estimated_Income <= 26500) => -0.0112678441, 
      (iv_Estimated_Income > 26500) => 0.0017403122, 0.0007144535), -0.0146963136), 
(nf_inq_per_apt_addr > 29.5) => 0.1289233871, -0.0000590340);

// Tree: 427
final_score_427 := map(
( NULL < nf_mos_acc_lseen and nf_mos_acc_lseen <= 106.5) => map(
   ( NULL < rv_I60_inq_other_count12 and rv_I60_inq_other_count12 <= 0.5) => map(
      (nf_fp_addrchangeecontraj in ['-1','AA','AE','AF','BA','BB','BC','BD','BF','CA','CB','CC','CD','CE','CF','CU','DC','DD','DE','DF','DU','EA','EC','ED','EE','EF','FA','FB','FC','FE','FF','UE','UU']) => 0.0077580711, 
      (nf_fp_addrchangeecontraj in ['AB','AC','AD','AU','BE','BU','DA','DB','EB','EU','FD','FU','UC','UD','UF']) => 0.1165057489, 0.0086985865), 
   (rv_I60_inq_other_count12 > 0.5) => -0.0022689464, 0.0011437953), 
(nf_mos_acc_lseen > 106.5) => -0.0344791263, 0.0001075521);

// Tree: 428
final_score_428 := map(
( NULL < nf_inq_HighRiskCredit_count_week and nf_inq_HighRiskCredit_count_week <= 0.5) => 0.0009376582, 
(nf_inq_HighRiskCredit_count_week > 0.5) => map(
   ( NULL < nf_inq_Communications_count24 and nf_inq_Communications_count24 <= 1.5) => map(
      ( NULL < rv_P88_Phn_Dst_to_Inp_Add and rv_P88_Phn_Dst_to_Inp_Add <= 26.5) => 0.0018936454, 
      (rv_P88_Phn_Dst_to_Inp_Add > 26.5) => -0.0419030839, -0.0042886062), 
   (nf_inq_Communications_count24 > 1.5) => -0.0395730239, -0.0056205888), 0.0002472320);

// Tree: 429
final_score_429 := map(
( NULL < nf_liens_unrel_ST_total_amt and nf_liens_unrel_ST_total_amt <= 156) => -0.0003683455, 
(nf_liens_unrel_ST_total_amt > 156) => map(
   ( NULL < rv_comb_age and rv_comb_age <= 62.5) => 0.0162963786, 
   (rv_comb_age > 62.5) => map(
      (iv_D34_liens_unrel_x_rel in ['0-0','0-1','0-2','1-0','1-2','3-1']) => -0.0030204082, 
      (iv_D34_liens_unrel_x_rel in ['1-1','2-0','2-1','2-2','3-0','3-2']) => 0.2321054371, 0.1358458628), 0.0245354504), 0.0003246465);

// Tree: 430
final_score_430 := map(
( NULL < nf_inq_count_week and nf_inq_count_week <= 1.5) => 0.0000645289, 
(nf_inq_count_week > 1.5) => map(
   ( NULL < nf_fp_prevaddrmedianvalue and nf_fp_prevaddrmedianvalue <= 86624.5) => -0.0539575466, 
   (nf_fp_prevaddrmedianvalue > 86624.5) => map(
      ( NULL < nf_inq_HighRiskCredit_count_day and nf_inq_HighRiskCredit_count_day <= 1.5) => -0.0122150733, 
      (nf_inq_HighRiskCredit_count_day > 1.5) => 0.0541106163, -0.0065623157), -0.0156935069), -0.0002891969);

// Tree: 431
final_score_431 := map(
( NULL < nf_add_curr_nhood_MFD_pct and nf_add_curr_nhood_MFD_pct <= 0.014589671) => -0.0083219116, 
(nf_add_curr_nhood_MFD_pct > 0.014589671) => map(
   ( NULL < nf_add_curr_nhood_SFD_pct and nf_add_curr_nhood_SFD_pct <= 0.96044954845) => 0.0028434297, 
   (nf_add_curr_nhood_SFD_pct > 0.96044954845) => map(
      ( NULL < nf_fp_srchfraudsrchcountmo and nf_fp_srchfraudsrchcountmo <= 3.5) => 0.0283640970, 
      (nf_fp_srchfraudsrchcountmo > 3.5) => 0.1002416326, 0.0344437794), 0.0036746001), 0.0002826874);

// Tree: 432
final_score_432 := map(
( NULL < nf_add_input_mobility_index and nf_add_input_mobility_index <= 0.2263975637) => map(
   ( NULL < rv_D34_unrel_liens_ct and rv_D34_unrel_liens_ct <= 12.5) => map(
      ( NULL < nf_fp_curraddrburglaryindex and nf_fp_curraddrburglaryindex <= 149.5) => -0.0063280193, 
      (nf_fp_curraddrburglaryindex > 149.5) => -0.0439546116, -0.0101394393), 
   (rv_D34_unrel_liens_ct > 12.5) => 0.1599846621, -0.0094767194), 
(nf_add_input_mobility_index > 0.2263975637) => 0.0007426769, -0.0009795410);

// Tree: 433
final_score_433 := map(
( NULL < nf_hh_collections_ct_avg and nf_hh_collections_ct_avg <= 0.2649122807) => map(
   ( NULL < nf_M_Bureau_ADL_FS_all and nf_M_Bureau_ADL_FS_all <= 280.5) => -0.0165272327, 
   (nf_M_Bureau_ADL_FS_all > 280.5) => map(
      ( NULL < nf_fp_srchvelocityrisktype and nf_fp_srchvelocityrisktype <= 3.5) => 0.1321797111, 
      (nf_fp_srchvelocityrisktype > 3.5) => 0.0020358259, 0.0123843980), -0.0077056575), 
(nf_hh_collections_ct_avg > 0.2649122807) => 0.0023038316, 0.0004877427);

// Tree: 434
final_score_434 := map(
( NULL < nf_phones_per_addr_c6 and nf_phones_per_addr_c6 <= 0.5) => -0.0032672456, 
(nf_phones_per_addr_c6 > 0.5) => map(
   ( NULL < nf_hh_members_ct and nf_hh_members_ct <= 12.5) => map(
      ( NULL < rv_D30_Derog_Count and rv_D30_Derog_Count <= 7.5) => 0.0098906747, 
      (rv_D30_Derog_Count > 7.5) => -0.0184080815, 0.0078289697), 
   (nf_hh_members_ct > 12.5) => -0.0523454264, 0.0066092690), -0.0002001346);

// Tree: 435
final_score_435 := map(
( NULL < nf_oldest_rel_age and nf_oldest_rel_age <= 35) => -0.0279185848, 
(nf_oldest_rel_age > 35) => map(
   ( NULL < nf_fp_srchaddrsrchcountwk and nf_fp_srchaddrsrchcountwk <= 4.5) => 0.0002369671, 
   (nf_fp_srchaddrsrchcountwk > 4.5) => map(
      ( NULL < iv_dob_src_ct and iv_dob_src_ct <= 5.5) => 0.0889214818, 
      (iv_dob_src_ct > 5.5) => 0.0113655077, 0.0265025290), 0.0003964236), -0.0001250804);

// Tree: 436
final_score_436 := map(
( NULL < nf_fp_srchfraudsrchcountyr and nf_fp_srchfraudsrchcountyr <= 1.5) => map(
   ( NULL < nf_inq_per_sfd_addr and nf_inq_per_sfd_addr <= 7.5) => -0.0131475228, 
   (nf_inq_per_sfd_addr > 7.5) => 0.0282293962, -0.0110552665), 
(nf_fp_srchfraudsrchcountyr > 1.5) => map(
   ( NULL < rv_I61_inq_collection_recency and rv_I61_inq_collection_recency <= 0.5) => -0.0079960113, 
   (rv_I61_inq_collection_recency > 0.5) => 0.0061046179, 0.0033835750), -0.0015927213);

// Tree: 437
final_score_437 := map(
( NULL < nf_mos_liens_rel_FT_lseen and nf_mos_liens_rel_FT_lseen <= 165.5) => map(
   ( NULL < iv_inp_add_avm_pct_chg_2yr and iv_inp_add_avm_pct_chg_2yr <= 1.69729020135) => -0.0020662462, 
   (iv_inp_add_avm_pct_chg_2yr > 1.69729020135) => -0.0223470768, 0.0005764394), 
(nf_mos_liens_rel_FT_lseen > 165.5) => map(
   ( NULL < rv_I60_inq_hiRiskCred_recency and rv_I60_inq_hiRiskCred_recency <= 2) => -0.0941524579, 
   (rv_I60_inq_hiRiskCred_recency > 2) => -0.0121150697, -0.0435271551), -0.0016596148);

// Tree: 438
final_score_438 := map(
( NULL < nf_util_adl_count and nf_util_adl_count <= 1.5) => map(
   ( NULL < nf_phones_per_addr_curr and nf_phones_per_addr_curr <= 11.5) => -0.0063844454, 
   (nf_phones_per_addr_curr > 11.5) => -0.0266592049, -0.0078144881), 
(nf_util_adl_count > 1.5) => map(
   ( NULL < nf_fp_curraddrmedianincome and nf_fp_curraddrmedianincome <= 152395.5) => 0.0010356510, 
   (nf_fp_curraddrmedianincome > 152395.5) => 0.0966013256, 0.0012708046), -0.0018266191);

// Tree: 439
final_score_439 := map(
( NULL < nf_fp_srchphonesrchcountmo and nf_fp_srchphonesrchcountmo <= 0.5) => -0.0053621023, 
(nf_fp_srchphonesrchcountmo > 0.5) => map(
   ( NULL < rv_I60_inq_hiRiskCred_recency and rv_I60_inq_hiRiskCred_recency <= 9) => map(
      ( NULL < nf_add_input_mobility_index and nf_add_input_mobility_index <= 0.40198799865) => 0.0049253698, 
      (nf_add_input_mobility_index > 0.40198799865) => -0.0116481897, 0.0015114260), 
   (rv_I60_inq_hiRiskCred_recency > 9) => 0.0436439324, 0.0062849502), -0.0016679827);

// Tree: 440
final_score_440 := map(
( NULL < nf_inq_Other_count24 and nf_inq_Other_count24 <= 11.5) => 0.0004128565, 
(nf_inq_Other_count24 > 11.5) => map(
   ( NULL < nf_pct_rel_prop_owned and nf_pct_rel_prop_owned <= 0.9128787879) => 0.0154787403, 
   (nf_pct_rel_prop_owned > 0.9128787879) => map(
      ( NULL < nf_fp_srchvelocityrisktype and nf_fp_srchvelocityrisktype <= 7.5) => -0.0220178278, 
      (nf_fp_srchvelocityrisktype > 7.5) => 0.1427380415, 0.0850210172), 0.0208730770), 0.0009458708);

// Tree: 441
final_score_441 := map(
( NULL < nf_addrs_per_ssn and nf_addrs_per_ssn <= 38.5) => map(
   ( NULL < nf_fp_srchaddrsrchcountday and nf_fp_srchaddrsrchcountday <= 3.5) => -0.0001959891, 
   (nf_fp_srchaddrsrchcountday > 3.5) => map(
      ( NULL < rv_I62_inq_dobs_per_adl and rv_I62_inq_dobs_per_adl <= 1.5) => -0.0832596326, 
      (rv_I62_inq_dobs_per_adl > 1.5) => 0.0268990616, -0.0433119743), -0.0002971390), 
(nf_addrs_per_ssn > 38.5) => -0.0990645481, -0.0004433067);

// Tree: 442
final_score_442 := map(
(nf_util_add_curr_summary in ['|   |','| C |','| CM|','|IC |','|ICM|']) => -0.0016956413, 
(nf_util_add_curr_summary in ['|  M|','|I  |','|I M|']) => map(
   ( NULL < nf_bus_addr_match_count and nf_bus_addr_match_count <= 9.5) => map(
      (nf_fp_addrchangeecontraj in ['-1','AA','AC','AD','BA','BB','BD','BE','CA','CC','CD','CE','CF','CU','DA','DB','DD','DE','DF','DU','EA','EC','ED','EE','EU','FC','FE','FF','FU','UD','UE','UU']) => 0.0078535934, 
      (nf_fp_addrchangeecontraj in ['AB','AE','AF','AU','BC','BF','BU','CB','DC','EB','EF','FA','FB','FD','UC','UF']) => 0.1269963888, 0.0096147810), 
   (nf_bus_addr_match_count > 9.5) => 0.1095000103, 0.0119671047), -0.0003068085);

// Tree: 443
final_score_443 := map(
( NULL < nf_mos_liens_unrel_CJ_lseen and nf_mos_liens_unrel_CJ_lseen <= 223.5) => map(
   ( NULL < nf_average_rel_income and nf_average_rel_income <= 45500) => map(
      ( NULL < nf_add_curr_mobility_index and nf_add_curr_mobility_index <= 0.3159819442) => 0.0350840173, 
      (nf_add_curr_mobility_index > 0.3159819442) => -0.0023138356, 0.0151886496), 
   (nf_average_rel_income > 45500) => -0.0020471253, -0.0011200214), 
(nf_mos_liens_unrel_CJ_lseen > 223.5) => -0.0446494125, -0.0016618136);

// Tree: 444
final_score_444 := map(
( NULL < nf_fp_prevaddrmedianvalue and nf_fp_prevaddrmedianvalue <= 459316) => map(
   ( NULL < iv_inp_add_avm_pct_chg_1yr and iv_inp_add_avm_pct_chg_1yr <= 1.40210021695) => map(
      (nf_fp_addrchangeecontraj in ['AA','AC','AD','BA','BB','BC','BE','BF','CA','CE','CF','DA','DE','DF','EA','EB','ED','FB','FC','FD']) => -0.0613249230, 
      (nf_fp_addrchangeecontraj in ['-1','AB','AE','AF','AU','BD','BU','CB','CC','CD','CU','DB','DC','DD','DU','EC','EE','EF','EU','FA','FE','FF','FU','UC','UD','UE','UF','UU']) => 0.0028861790, 0.0011614148), 
   (iv_inp_add_avm_pct_chg_1yr > 1.40210021695) => -0.0157006272, 0.0044321216), 
(nf_fp_prevaddrmedianvalue > 459316) => -0.0123577241, 0.0002266412);

// Tree: 445
final_score_445 := map(
( NULL < nf_average_rel_income and nf_average_rel_income <= 119500) => map(
   ( NULL < rv_comb_age and rv_comb_age <= 85.5) => 0.0007551611, 
   (rv_comb_age > 85.5) => 0.1171731761, 0.0008738508), 
(nf_average_rel_income > 119500) => map(
   (nf_util_adl_summary in ['| C |','|I  |','|ICM|']) => -0.0431151602, 
   (nf_util_adl_summary in ['|   |','|  M|','| CM|','|I M|','|IC |']) => 0.1419319604, 0.0778424699), 0.0010769394);

// Tree: 446
final_score_446 := map(
( NULL < nf_phones_per_sfd_addr_curr and nf_phones_per_sfd_addr_curr <= 1.5) => -0.0060700838, 
(nf_phones_per_sfd_addr_curr > 1.5) => map(
   (iv_full_name_ver_sources in ['PHN & NONPHN']) => 0.0014338223, 
   (iv_full_name_ver_sources in ['NAME NOT VERD','NONPHN ONLY','PHN ONLY']) => map(
      ( NULL < nf_fp_srchphonesrchcountmo and nf_fp_srchphonesrchcountmo <= 5.5) => 0.0090734534, 
      (nf_fp_srchphonesrchcountmo > 5.5) => 0.0415724683, 0.0096898652), 0.0034737918), 0.0004587919);

// Tree: 447
final_score_447 := map(
(nf_fp_addrchangeecontraj in ['AB','AF','BE','BU','DU','EA','FA','FB','UD','UU']) => -0.0955319046, 
(nf_fp_addrchangeecontraj in ['-1','AA','AC','AD','AE','AU','BA','BB','BC','BD','BF','CA','CB','CC','CD','CE','CF','CU','DA','DB','DC','DD','DE','DF','EB','EC','ED','EE','EF','EU','FC','FD','FE','FF','FU','UC','UE','UF']) => map(
   ( NULL < nf_liens_unrel_O_total_amt and nf_liens_unrel_O_total_amt <= 29) => 0.0000092209, 
   (nf_liens_unrel_O_total_amt > 29) => map(
      ( NULL < nf_fp_srchssnsrchcountmo and nf_fp_srchssnsrchcountmo <= 1.5) => -0.0202104231, 
      (nf_fp_srchssnsrchcountmo > 1.5) => -0.0644230023, -0.0307275031), -0.0003339052), -0.0004797152);

// Tree: 448
final_score_448 := map(
( NULL < nf_hh_age_30_plus and nf_hh_age_30_plus <= 8.5) => map(
   ( NULL < nf_hh_payday_loan_users_pct and nf_hh_payday_loan_users_pct <= 0.30384615385) => -0.0004191949, 
   (nf_hh_payday_loan_users_pct > 0.30384615385) => map(
      ( NULL < nf_phones_per_apt_addr_curr and nf_phones_per_apt_addr_curr <= 4.5) => 0.0153817742, 
      (nf_phones_per_apt_addr_curr > 4.5) => -0.0256618840, 0.0117032229), 0.0009608455), 
(nf_hh_age_30_plus > 8.5) => -0.0456077640, 0.0006305802);

// Tree: 449
final_score_449 := map(
( NULL < nf_historical_count and nf_historical_count <= 29.5) => map(
   (rv_L76_Add_Curr_Seasonal in ['E','Y']) => -0.0403323069, 
   (rv_L76_Add_Curr_Seasonal in ['N']) => 0.0029500578, map(
      ( NULL < nf_M_Bureau_ADL_FS_noTU and nf_M_Bureau_ADL_FS_noTU <= 63.5) => -0.0630692794, 
      (nf_M_Bureau_ADL_FS_noTU > 63.5) => -0.0121892997, -0.0150863325)), 
(nf_historical_count > 29.5) => 0.1549369370, 0.0021488052);

// Tree: 450
final_score_450 := map(
( NULL < iv_src_drivers_lic_adl_count and iv_src_drivers_lic_adl_count <= 11.5) => map(
   (nf_fp_addrchangeecontraj in ['-1','AA','AB','AD','BB','BD','BE','BU','CA','CB','CC','CE','CF','CU','DA','DB','DC','DD','DF','EA','EB','EC','ED','EE','EF','EU','FB','FD','FE','FF','FU','UC','UE','UF','UU']) => -0.0003729580, 
   (nf_fp_addrchangeecontraj in ['AC','AE','AF','AU','BA','BC','BF','CD','DE','DU','FA','FC','UD']) => map(
      ( NULL < rv_A49_Curr_AVM_Chg_1yr and rv_A49_Curr_AVM_Chg_1yr <= 7763) => 0.1921138931, 
      (rv_A49_Curr_AVM_Chg_1yr > 7763) => 0.0019883943, 0.0288437893), -0.0000537808), 
(iv_src_drivers_lic_adl_count > 11.5) => -0.0650780835, -0.0003391697);

// Tree: 451
final_score_451 := map(
( NULL < nf_mos_liens_unrel_ST_fseen and nf_mos_liens_unrel_ST_fseen <= 231.5) => map(
   ( NULL < rv_I60_inq_retpymt_recency and rv_I60_inq_retpymt_recency <= 4.5) => 0.0018626691, 
   (rv_I60_inq_retpymt_recency > 4.5) => map(
      ( NULL < nf_inq_per_addr and nf_inq_per_addr <= 7.5) => -0.0179556166, 
      (nf_inq_per_addr > 7.5) => 0.0084329011, -0.0113790521), -0.0002753687), 
(nf_mos_liens_unrel_ST_fseen > 231.5) => -0.0923457642, -0.0005040900);

// Tree: 452
final_score_452 := map(
( NULL < nf_mos_liens_unrel_CJ_fseen and nf_mos_liens_unrel_CJ_fseen <= 162.5) => -0.0017136667, 
(nf_mos_liens_unrel_CJ_fseen > 162.5) => map(
   (rv_D32_criminal_x_felony in ['0-0','1-0','1-1','2-1','3-0']) => 0.0111367365, 
   (rv_D32_criminal_x_felony in ['2-0','2-2','3-1','3-2','3-3']) => map(
      ( NULL < nf_hh_workers_paw_pct and nf_hh_workers_paw_pct <= 0.2111111111) => 0.1579433191, 
      (nf_hh_workers_paw_pct > 0.2111111111) => 0.0391387139, 0.0634276554), 0.0163507656), -0.0006643876);

// Tree: 453
final_score_453 := map(
( NULL < nf_add_input_nhood_BUS_pct and nf_add_input_nhood_BUS_pct <= 0.113936485) => 0.0023055990, 
(nf_add_input_nhood_BUS_pct > 0.113936485) => map(
   ( NULL < nf_fp_srchphonesrchcountmo and nf_fp_srchphonesrchcountmo <= 7.5) => map(
      ( NULL < iv_C13_avg_lres and iv_C13_avg_lres <= 53.5) => -0.0194061727, 
      (iv_C13_avg_lres > 53.5) => 0.0022285622, -0.0068742272), 
   (nf_fp_srchphonesrchcountmo > 7.5) => -0.0776993277, -0.0072806998), 0.0007146278);

// Tree: 454
final_score_454 := map(
( NULL < nf_hh_age_65_plus and nf_hh_age_65_plus <= 0.5) => -0.0018985079, 
(nf_hh_age_65_plus > 0.5) => map(
   (rv_D32_criminal_x_felony in ['0-0','1-0','1-1','2-1','3-0','3-1','3-3']) => 0.0072099782, 
   (rv_D32_criminal_x_felony in ['2-0','2-2','3-2']) => map(
      (nf_historic_x_current_ct in ['0-0','1-1','2-0','2-2','3-0','3-1','3-2','3-3']) => 0.0340353446, 
      (nf_historic_x_current_ct in ['1-0','2-1']) => 0.1981389890, 0.0452242294), 0.0095349165), 0.0003248092);

// Tree: 455
final_score_455 := map(
( NULL < rv_I60_Inq_Count12 and rv_I60_Inq_Count12 <= 12.5) => map(
   ( NULL < nf_inq_per_ssn and nf_inq_per_ssn <= 22.5) => 0.0005107518, 
   (nf_inq_per_ssn > 22.5) => 0.0356900496, 0.0007653040), 
(rv_I60_Inq_Count12 > 12.5) => map(
   ( NULL < rv_C12_source_profile and rv_C12_source_profile <= 16.3) => 0.0892862215, 
   (rv_C12_source_profile > 16.3) => -0.0255521427, -0.0220917425), 0.0001892589);

// Tree: 456
final_score_456 := map(
( NULL < rv_I60_credit_seeking and rv_I60_credit_seeking <= 1.5) => 0.0023376439, 
(rv_I60_credit_seeking > 1.5) => map(
   ( NULL < rv_I60_inq_auto_recency and rv_I60_inq_auto_recency <= 2) => -0.0286569389, 
   (rv_I60_inq_auto_recency > 2) => map(
      ( NULL < nf_add_input_nhood_MFD_pct and nf_add_input_nhood_MFD_pct <= 0.6635310405) => -0.0060064337, 
      (nf_add_input_nhood_MFD_pct > 0.6635310405) => 0.0799043956, 0.0025415778), -0.0118875746), 0.0014540149);

// Tree: 457
final_score_457 := map(
( NULL < rv_C14_addrs_5yr and rv_C14_addrs_5yr <= 2.5) => -0.0004733262, 
(rv_C14_addrs_5yr > 2.5) => map(
   ( NULL < nf_inq_per_sfd_addr and nf_inq_per_sfd_addr <= 13.5) => 0.0064493360, 
   (nf_inq_per_sfd_addr > 13.5) => map(
      ( NULL < nf_hh_age_18_plus and nf_hh_age_18_plus <= 4.5) => 0.0472664135, 
      (nf_hh_age_18_plus > 4.5) => -0.0243086997, 0.0323773549), 0.0081327727), 0.0015691782);

// Tree: 458
final_score_458 := map(
(rv_L70_Add_Standardized in ['1 Address was Standardized']) => -0.0068285469, 
(rv_L70_Add_Standardized in ['0 Address is Standard','2 Standardization Error']) => map(
   (rv_D31_MostRec_Bk in ['2 - BK DISCHARGED','3 - BK OTHER']) => -0.0092082581, 
   (rv_D31_MostRec_Bk in ['0 - NO BK','1 - BK DISMISSED']) => map(
      ( NULL < rv_A49_Curr_AVM_Chg_1yr and rv_A49_Curr_AVM_Chg_1yr <= -17021) => -0.0247830924, 
      (rv_A49_Curr_AVM_Chg_1yr > -17021) => 0.0097255960, 0.0032008934), 0.0015478568), -0.0010104648);

// Tree: 459
final_score_459 := map(
( NULL < nf_inq_Communications_count24 and nf_inq_Communications_count24 <= 5.5) => -0.0002142164, 
(nf_inq_Communications_count24 > 5.5) => map(
   ( NULL < nf_hh_collections_ct_avg and nf_hh_collections_ct_avg <= 0.2761904762) => 0.0716387884, 
   (nf_hh_collections_ct_avg > 0.2761904762) => map(
      ( NULL < iv_C13_avg_lres and iv_C13_avg_lres <= 58.5) => -0.0836038795, 
      (iv_C13_avg_lres > 58.5) => -0.0110535638, -0.0531795536), -0.0315443743), -0.0003654374);

// Tree: 460
final_score_460 := map(
( NULL < rv_C13_max_lres and rv_C13_max_lres <= 16.5) => -0.0404422738, 
(rv_C13_max_lres > 16.5) => map(
   ( NULL < rv_L79_adls_per_addr_c6 and rv_L79_adls_per_addr_c6 <= 11.5) => map(
      ( NULL < rv_comb_age and rv_comb_age <= 19.5) => 0.0663551059, 
      (rv_comb_age > 19.5) => 0.0006348326, 0.0006970443), 
   (rv_L79_adls_per_addr_c6 > 11.5) => -0.0633912234, 0.0005320906), 0.0003401287);

// Tree: 461
final_score_461 := map(
( NULL < nf_fp_srchfraudsrchcountwk and nf_fp_srchfraudsrchcountwk <= 0.5) => 0.0015495260, 
(nf_fp_srchfraudsrchcountwk > 0.5) => map(
   ( NULL < nf_average_rel_home_val and nf_average_rel_home_val <= 144500) => map(
      ( NULL < rv_C13_Curr_Addr_LRes and rv_C13_Curr_Addr_LRes <= 39.5) => -0.0338748699, 
      (rv_C13_Curr_Addr_LRes > 39.5) => -0.0052642432, -0.0176033118), 
   (nf_average_rel_home_val > 144500) => 0.0017323351, -0.0045665686), 0.0006687020);

// Tree: 462
final_score_462 := map(
( NULL < rv_I60_inq_hiRiskCred_count12 and rv_I60_inq_hiRiskCred_count12 <= 13.5) => -0.0010713998, 
(rv_I60_inq_hiRiskCred_count12 > 13.5) => map(
   (nf_util_add_input_summary in ['|   |','| CM|']) => map(
      ( NULL < rv_P88_Phn_Dst_to_Inp_Add and rv_P88_Phn_Dst_to_Inp_Add <= 8.5) => -0.0144812891, 
      (rv_P88_Phn_Dst_to_Inp_Add > 8.5) => -0.0520803344, -0.0757871621), 
   (nf_util_add_input_summary in ['|  M|','| C |','|I  |','|I M|','|IC |','|ICM|']) => 0.0101650599, -0.0201216891), -0.0013825501);

// Tree: 463
final_score_463 := map(
( NULL < nf_average_rel_home_val and nf_average_rel_home_val <= 107500) => map(
   ( NULL < nf_inq_count24 and nf_inq_count24 <= 22.5) => -0.0085869065, 
   (nf_inq_count24 > 22.5) => -0.1122824778, -0.0099996527), 
(nf_average_rel_home_val > 107500) => map(
   ( NULL < iv_prv_addr_avm_auto_val and iv_prv_addr_avm_auto_val <= 642500) => 0.0018007563, 
   (iv_prv_addr_avm_auto_val > 642500) => -0.0282002654, -0.0263072079), -0.0000431683);

// Tree: 464
final_score_464 := map(
(iv_full_name_ver_sources in ['NONPHN ONLY','PHN & NONPHN']) => map(
   ( NULL < nf_Inq_Per_Add_NAS_479 and nf_Inq_Per_Add_NAS_479 <= 3.5) => -0.0003706415, 
   (nf_Inq_Per_Add_NAS_479 > 3.5) => map(
      (nf_historic_x_current_ct in ['1-1','2-0','2-1','3-1','3-3']) => -0.0883233720, 
      (nf_historic_x_current_ct in ['0-0','1-0','2-2','3-0','3-2']) => -0.0012615967, -0.0331178804), -0.0005736185), 
(iv_full_name_ver_sources in ['NAME NOT VERD','PHN ONLY']) => 0.1275013474, -0.0004219607);

// Tree: 465
final_score_465 := map(
( NULL < rv_L79_adls_per_sfd_addr_c6 and rv_L79_adls_per_sfd_addr_c6 <= 5.5) => map(
   (nf_fp_addrchangeecontraj in ['-1','AE','AF','BC','BD','BE','BF','BU','CA','CD','CE','CF','CU','DB','DD','DU','EB','ED','EE','EU','FA','FC','FD','FU','UC','UE','UF']) => -0.0038431864, 
   (nf_fp_addrchangeecontraj in ['AA','AB','AC','AD','AU','BA','BB','CB','CC','DA','DC','DE','DF','EA','EC','EF','FB','FE','FF','UD','UU']) => 0.0053242718, -0.0000125355), 
(rv_L79_adls_per_sfd_addr_c6 > 5.5) => map(
   ( NULL < nf_add_curr_nhood_SFD_pct and nf_add_curr_nhood_SFD_pct <= 0.9933594439) => -0.0441583598, 
   (nf_add_curr_nhood_SFD_pct > 0.9933594439) => 0.0919583880, -0.0315267256), -0.0002660672);

// Tree: 466
final_score_466 := map(
( NULL < nf_add_curr_nhood_MFD_pct and nf_add_curr_nhood_MFD_pct <= 0.0371038417) => map(
   ( NULL < nf_fp_srchaddrsrchcountday and nf_fp_srchaddrsrchcountday <= 3.5) => map(
      ( NULL < nf_fp_srchssnsrchcountday and nf_fp_srchssnsrchcountday <= 2.5) => -0.0066324614, 
      (nf_fp_srchssnsrchcountday > 2.5) => 0.0514368637, -0.0063734396), 
   (nf_fp_srchaddrsrchcountday > 3.5) => -0.0719106209, -0.0065630246), 
(nf_add_curr_nhood_MFD_pct > 0.0371038417) => 0.0033428855, -0.0001844226);

// Tree: 467
final_score_467 := map(
( NULL < nf_liens_unrel_ST_ct and nf_liens_unrel_ST_ct <= 2.5) => map(
   ( NULL < rv_C12_inp_addr_source_count and rv_C12_inp_addr_source_count <= 0.5) => 0.0205935558, 
   (rv_C12_inp_addr_source_count > 0.5) => 0.0013024666, 0.0019694304), 
(nf_liens_unrel_ST_ct > 2.5) => map(
   ( NULL < nf_fp_srchphonesrchcountwk and nf_fp_srchphonesrchcountwk <= 0.5) => -0.0226981273, 
   (nf_fp_srchphonesrchcountwk > 0.5) => -0.0933278284, -0.0329222199), 0.0016653843);

// Tree: 468
final_score_468 := map(
( NULL < nf_phone_ver_insurance and nf_phone_ver_insurance <= 2.5) => map(
   ( NULL < nf_inq_count_week and nf_inq_count_week <= 1.5) => -0.0068856677, 
   (nf_inq_count_week > 1.5) => -0.0494470277, -0.0077358445), 
(nf_phone_ver_insurance > 2.5) => map(
   ( NULL < nf_inq_Communications_count24 and nf_inq_Communications_count24 <= 8.5) => 0.0009355857, 
   (nf_inq_Communications_count24 > 8.5) => -0.0893013646, 0.0008296394), -0.0005997603);

// Tree: 469
final_score_469 := map(
( NULL < iv_dob_src_ct and iv_dob_src_ct <= 17.5) => 0.0003564809, 
(iv_dob_src_ct > 17.5) => map(
   ( NULL < rv_C12_source_profile and rv_C12_source_profile <= 68) => 0.2113389164, 
   (rv_C12_source_profile > 68) => 0.0170620960, 0.0494415661), map(
   ( NULL < nf_inq_per_addr and nf_inq_per_addr <= 8.5) => -0.0211647253, 
   (nf_inq_per_addr > 8.5) => 0.0126476638, -0.0121025850));

// Tree: 470
final_score_470 := map(
( NULL < nf_M_Bureau_ADL_FS_noTU and nf_M_Bureau_ADL_FS_noTU <= 96.5) => map(
   ( NULL < nf_add_input_mobility_index and nf_add_input_mobility_index <= 0.3812319989) => map(
      (iv_full_name_ver_sources in ['NAME NOT VERD','PHN & NONPHN','PHN ONLY']) => 0.0031995042, 
      (iv_full_name_ver_sources in ['NONPHN ONLY']) => 0.0305809097, 0.0153442936), 
   (nf_add_input_mobility_index > 0.3812319989) => -0.0040997863, 0.0099760498), 
(nf_M_Bureau_ADL_FS_noTU > 96.5) => -0.0003191792, 0.0009648424);

// Tree: 471
final_score_471 := map(
(nf_fp_addrchangeecontraj in ['BD','BU','CA','CB','DA','DC','DE','EA','EB','EU','FC','FD','UC','UE','UF','UU']) => -0.0395458898, 
(nf_fp_addrchangeecontraj in ['-1','AA','AB','AC','AD','AE','AF','AU','BA','BB','BC','BE','BF','CC','CD','CE','CF','CU','DB','DD','DF','DU','EC','ED','EE','EF','FA','FB','FE','FF','FU','UD']) => map(
   ( NULL < iv_inp_add_avm_pct_chg_3yr and iv_inp_add_avm_pct_chg_3yr <= 1.0865112171) => map(
      ( NULL < rv_C22_inp_addr_owned_not_occ and rv_C22_inp_addr_owned_not_occ <= 0.5) => 0.0038771082, 
      (rv_C22_inp_addr_owned_not_occ > 0.5) => 0.0737847196, 0.0081168754), 
   (iv_inp_add_avm_pct_chg_3yr > 1.0865112171) => -0.0078047140, 0.0008421832), -0.0015261431);

// Tree: 472
final_score_472 := map(
(iv_college_major in ['BUSINESS','LIBERAL ARTS','NO AMS FOUND','NO COLLEGE FOUND','SCIENCE','UNCLASSIFIED']) => 0.0005058756, 
(iv_college_major in ['MEDICAL']) => map(
   ( NULL < nf_mos_liens_unrel_SC_lseen and nf_mos_liens_unrel_SC_lseen <= 9) => map(
      ( NULL < rv_C13_max_lres and rv_C13_max_lres <= 69.5) => 0.0832496677, 
      (rv_C13_max_lres > 69.5) => -0.0035949584, 0.0214934892), 
   (nf_mos_liens_unrel_SC_lseen > 9) => 0.2214863019, 0.0361988430), 0.0008182666);

// Tree: 473
final_score_473 := map(
( NULL < rv_C20_M_Bureau_ADL_FS and rv_C20_M_Bureau_ADL_FS <= 340.5) => map(
   ( NULL < nf_mos_liens_unrel_OT_lseen and nf_mos_liens_unrel_OT_lseen <= 100.5) => 0.0010195102, 
   (nf_mos_liens_unrel_OT_lseen > 100.5) => map(
      ( NULL < rv_I60_inq_comm_count12 and rv_I60_inq_comm_count12 <= 0.5) => 0.0326690034, 
      (rv_I60_inq_comm_count12 > 0.5) => 0.1619173673, 0.0403121970), 0.0018103645), 
(rv_C20_M_Bureau_ADL_FS > 340.5) => -0.0130702207, -0.0005191320);

// Tree: 474
final_score_474 := map(
( NULL < nf_M_Bureau_ADL_FS_all and nf_M_Bureau_ADL_FS_all <= 10.5) => 0.0646836347, 
(nf_M_Bureau_ADL_FS_all > 10.5) => map(
   ( NULL < nf_add_input_nhood_VAC_pct and nf_add_input_nhood_VAC_pct <= 2.09338709675) => map(
      ( NULL < nf_inq_HighRiskCredit_count_week and nf_inq_HighRiskCredit_count_week <= 1.5) => 0.0025585709, 
      (nf_inq_HighRiskCredit_count_week > 1.5) => -0.0094208158, 0.0020549190), 
   (nf_add_input_nhood_VAC_pct > 2.09338709675) => -0.0651302991, 0.0018686880), 0.0019592391);

// Tree: 475
final_score_475 := map(
( NULL < rv_S65_SSN_Prior_DoB and rv_S65_SSN_Prior_DoB <= 0.5) => map(
   ( NULL < nf_fp_srchaddrsrchcountmo and nf_fp_srchaddrsrchcountmo <= 0.5) => -0.0023651718, 
   (nf_fp_srchaddrsrchcountmo > 0.5) => 0.0054408965, 0.0001649792), 
(rv_S65_SSN_Prior_DoB > 0.5) => -0.0730661567, map(
   ( NULL < rv_L79_adls_per_addr_c6 and rv_L79_adls_per_addr_c6 <= 2.5) => -0.0062471914, 
   (rv_L79_adls_per_addr_c6 > 2.5) => -0.0439408906, -0.0130951399));

// Tree: 476
final_score_476 := map(
( NULL < nf_hh_pct_property_owners and nf_hh_pct_property_owners <= 0.10263157895) => map(
   ( NULL < iv_Phn_Cell and iv_Phn_Cell <= 0.5) => map(
      ( NULL < nf_inq_per_addr and nf_inq_per_addr <= 5.5) => -0.0125250961, 
      (nf_inq_per_addr > 5.5) => 0.0067832056, -0.0066399661), 
   (iv_Phn_Cell > 0.5) => 0.0105390389, 0.0044731310), 
(nf_hh_pct_property_owners > 0.10263157895) => -0.0031029892, -0.0000301790);

// Tree: 477
final_score_477 := map(
(nf_fp_addrchangeecontraj in ['AB','AC','AE','AF','BE','BF','BU','CA','CE','CF','DB','DE','DU','EA','EU','FB','FC','FE','UC','UE','UF']) => map(
   ( NULL < rv_I60_inq_hiRiskCred_recency and rv_I60_inq_hiRiskCred_recency <= 2) => -0.0512096969, 
   (rv_I60_inq_hiRiskCred_recency > 2) => -0.0125971609, -0.0267643503), 
(nf_fp_addrchangeecontraj in ['-1','AA','AD','AU','BA','BB','BC','BD','CB','CC','CD','CU','DA','DC','DD','DF','EB','EC','ED','EE','EF','FA','FD','FF','FU','UD','UU']) => map(
   ( NULL < nf_pct_rel_prop_sold and nf_pct_rel_prop_sold <= 0.8918128655) => 0.0002397476, 
   (nf_pct_rel_prop_sold > 0.8918128655) => -0.0796455423, -0.0001584039), -0.0005867975);

// Tree: 478
final_score_478 := map(
( NULL < nf_inq_dobs_per_ssn and nf_inq_dobs_per_ssn <= 1.5) => 0.0020405194, 
(nf_inq_dobs_per_ssn > 1.5) => map(
   (nf_fp_addrchangeecontraj in ['-1','AA','AB','AC','AD','AE','BA','BB','BD','CA','CB','CC','CD','CF','CU','DC','DD','DE','DF','DU','EA','EB','EC','EE','EF','EU','FA','FB','FD','FE','FF','FU','UC','UE','UF','UU']) => map(
      ( NULL < iv_inp_add_avm_chg_2yr and iv_inp_add_avm_chg_2yr <= 22121) => -0.0208527107, 
      (iv_inp_add_avm_chg_2yr > 22121) => 0.0085184523, -0.0093226772), 
   (nf_fp_addrchangeecontraj in ['AF','AU','BC','BE','BF','BU','CE','DA','DB','ED','FC','UD']) => 0.0926532284, -0.0069423032), 0.0001611169);

// Tree: 479
final_score_479 := map(
(nf_Source_Type in ['Behavioral Only','Bureau and Behavioral','Bureau Behavioral and Government','Bureau Only','Government Only','None']) => -0.0006301479, 
(nf_Source_Type in ['Behavioral and Government','Bureau and Government']) => map(
   (nf_fp_addrchangeecontraj in ['AB','AC','AE','AF','BA','BC','BD','BE','BF','CA','CB','CD','CE','CU','DA','DD','DU','EB','EF','EU','FE','FU','UE','UU']) => -0.0201818806, 
   (nf_fp_addrchangeecontraj in ['-1','AA','AD','AU','BB','BU','CC','CF','DB','DC','DE','DF','EA','EC','ED','EE','FA','FB','FC','FD','FF','UC','UD','UF']) => map(
      ( NULL < rv_F01_inp_addr_address_score and rv_F01_inp_addr_address_score <= 95) => 0.0642186210, 
      (rv_F01_inp_addr_address_score > 95) => 0.0137660699, 0.0173263413), 0.0101283534), 0.0003071982);

// Tree: 480
final_score_480 := map(
( NULL < nf_phone_ver_insurance and nf_phone_ver_insurance <= 2.5) => map(
   (rv_E58_br_dead_bus_x_active_phn in ['0-0','0-1','0-2','0-3','1-0','1-1','1-3','2-0','2-1','3-0']) => map(
      ( NULL < nf_fp_srchfraudsrchcountmo and nf_fp_srchfraudsrchcountmo <= 8.5) => -0.0121028397, 
      (nf_fp_srchfraudsrchcountmo > 8.5) => 0.0586190577, -0.0116272055), 
   (rv_E58_br_dead_bus_x_active_phn in ['1-2','2-2','2-3','3-1','3-2','3-3']) => 0.1583321328, -0.0109467400), 
(nf_phone_ver_insurance > 2.5) => 0.0007322469, -0.0012200883);

// Tree: 481
final_score_481 := map(
( NULL < nf_fp_srchaddrsrchcountwk and nf_fp_srchaddrsrchcountwk <= 5.5) => map(
   ( NULL < nf_fp_srchfraudsrchcountwk and nf_fp_srchfraudsrchcountwk <= 5.5) => 0.0012692620, 
   (nf_fp_srchfraudsrchcountwk > 5.5) => 0.0484115819, 0.0013489766), 
(nf_fp_srchaddrsrchcountwk > 5.5) => map(
   ( NULL < iv_prv_addr_lres and iv_prv_addr_lres <= 30) => -0.1069178499, 
   (iv_prv_addr_lres > 30) => -0.0147979776, -0.0391950214), 0.0012320870);

// Tree: 482
final_score_482 := map(
( NULL < rv_A49_curr_add_avm_pct_chg_2yr and rv_A49_curr_add_avm_pct_chg_2yr <= 0.3915381312) => -0.0643042027, 
(rv_A49_curr_add_avm_pct_chg_2yr > 0.3915381312) => 0.0012204913, map(
   ( NULL < nf_fp_srchcomponentrisktype and nf_fp_srchcomponentrisktype <= 3.5) => 0.0037357185, 
   (nf_fp_srchcomponentrisktype > 3.5) => map(
      ( NULL < nf_average_rel_income and nf_average_rel_income <= 70500) => -0.0141167308, 
      (nf_average_rel_income > 70500) => 0.0073315440, -0.0067177317), 0.0017156793));

// Tree: 483
final_score_483 := map(
(iv_college_code_x_type in ['1-P','1-S','2-R','4-S']) => map(
   ( NULL < nf_M_Bureau_ADL_FS_all and nf_M_Bureau_ADL_FS_all <= 40.5) => -0.0882168508, 
   (nf_M_Bureau_ADL_FS_all > 40.5) => map(
      ( NULL < nf_M_Bureau_ADL_FS_noTU and nf_M_Bureau_ADL_FS_noTU <= 45.5) => 0.0937039914, 
      (nf_M_Bureau_ADL_FS_noTU > 45.5) => -0.0179791816, -0.0167567450), -0.0176471801), 
(iv_college_code_x_type in ['-1','1-R','2-P','2-S','2-U','4-P','4-R']) => 0.0009096927, -0.0006812171);

// Tree: 484
final_score_484 := map(
( NULL < rv_I62_inq_addrs_per_adl and rv_I62_inq_addrs_per_adl <= 6.5) => map(
   ( NULL < rv_L79_adls_per_sfd_addr_c6 and rv_L79_adls_per_sfd_addr_c6 <= 4.5) => 0.0008122972, 
   (rv_L79_adls_per_sfd_addr_c6 > 4.5) => map(
      (iv_inp_addr_mortgage_type in ['CONVENTIONAL','GOVERNMENT','NO MORTGAGE']) => -0.0310374237, 
      (iv_inp_addr_mortgage_type in ['NON-TRADITIONAL','OTHER','UNKNOWN']) => 0.0809862529, -0.0192093691), 0.0004751679), 
(rv_I62_inq_addrs_per_adl > 6.5) => 0.0920043801, 0.0005434979);

// Tree: 485
final_score_485 := map(
( NULL < nf_inq_HighRiskCredit_count_week and nf_inq_HighRiskCredit_count_week <= 2.5) => -0.0005441944, 
(nf_inq_HighRiskCredit_count_week > 2.5) => map(
   ( NULL < rv_A49_curr_add_avm_chg_3yr and rv_A49_curr_add_avm_chg_3yr <= 16141) => -0.0144250501, 
   (rv_A49_curr_add_avm_chg_3yr > 16141) => 0.0588140849, map(
      ( NULL < iv_Estimated_Income and iv_Estimated_Income <= 82500) => 0.0213520774, 
      (iv_Estimated_Income > 82500) => -0.0505659124, 0.0093152770)), -0.0002360560);

// Tree: 486
final_score_486 := map(
( NULL < nf_attr_arrest_recency and nf_attr_arrest_recency <= 18) => 0.0822992220, 
(nf_attr_arrest_recency > 18) => map(
   ( NULL < iv_prv_addr_lres and iv_prv_addr_lres <= 189.5) => map(
      ( NULL < rv_A49_Curr_AVM_Chg_1yr and rv_A49_Curr_AVM_Chg_1yr <= 32968.5) => -0.0037230368, 
      (rv_A49_Curr_AVM_Chg_1yr > 32968.5) => 0.0875703516, -0.0122883562), 
   (iv_prv_addr_lres > 189.5) => -0.1129398055, -0.0066430313), -0.0003197864);

// Tree: 487
final_score_487 := map(
( NULL < nf_fp_srchfraudsrchcountday and nf_fp_srchfraudsrchcountday <= 3.5) => 0.0007941649, 
(nf_fp_srchfraudsrchcountday > 3.5) => map(
   ( NULL < nf_fp_prevaddrmedianincome and nf_fp_prevaddrmedianincome <= 70769) => map(
      ( NULL < nf_hh_pct_property_owners and nf_hh_pct_property_owners <= 0.19375) => -0.0211933752, 
      (nf_hh_pct_property_owners > 0.19375) => -0.1039427313, -0.0633203201), 
   (nf_fp_prevaddrmedianincome > 70769) => 0.0506109671, -0.0333116328), 0.0006958356);

// Tree: 488
final_score_488 := map(
( NULL < nf_fp_prevaddrmurderindex and nf_fp_prevaddrmurderindex <= 14.5) => map(
   ( NULL < rv_A49_curr_add_avm_chg_3yr and rv_A49_curr_add_avm_chg_3yr <= 8955) => map(
      ( NULL < nf_fp_prevaddrcrimeindex and nf_fp_prevaddrcrimeindex <= 1.5) => 0.2137399561, 
      (nf_fp_prevaddrcrimeindex > 1.5) => 0.0409436648, 0.0695079497), 
   (rv_A49_curr_add_avm_chg_3yr > 8955) => 0.0061714981, 0.0079217272), 
(nf_fp_prevaddrmurderindex > 14.5) => -0.0022872436, -0.0010234097);

// Tree: 489
final_score_489 := map(
( NULL < iv_inp_add_avm_pct_chg_1yr and iv_inp_add_avm_pct_chg_1yr <= 3.40277180355) => -0.0033741021, 
(iv_inp_add_avm_pct_chg_1yr > 3.40277180355) => map(
   ( NULL < nf_add_curr_mobility_index and nf_add_curr_mobility_index <= 0.28660594465) => 0.1966110843, 
   (nf_add_curr_mobility_index > 0.28660594465) => -0.0073082430, 0.0752603189), map(
   ( NULL < nf_mos_liens_unrel_ST_fseen and nf_mos_liens_unrel_ST_fseen <= 112.5) => 0.0010264033, 
   (nf_mos_liens_unrel_ST_fseen > 112.5) => -0.0319484974, 0.0001877765));

// Tree: 490
final_score_490 := map(
( NULL < nf_rel_felony_count and nf_rel_felony_count <= 4.5) => 0.0003101707, 
(nf_rel_felony_count > 4.5) => map(
   (iv_D34_liens_unrel_x_rel in ['0-1','0-2','1-2','2-0','3-0','3-1']) => -0.0532398827, 
   (iv_D34_liens_unrel_x_rel in ['0-0','1-0','1-1','2-1','2-2','3-2']) => map(
      (iv_college_major in ['BUSINESS','LIBERAL ARTS','NO AMS FOUND','SCIENCE']) => 0.0078251926, 
      (iv_college_major in ['MEDICAL','NO COLLEGE FOUND','UNCLASSIFIED']) => 0.0831553288, 0.0384253515), 0.0241722539), 0.0006262024);

// Tree: 491
final_score_491 := map(
( NULL < nf_add_curr_nhood_MFD_pct and nf_add_curr_nhood_MFD_pct <= 0.03139907025) => map(
   ( NULL < nf_fp_srchcomponentrisktype and nf_fp_srchcomponentrisktype <= 6.5) => -0.0035271418, 
   (nf_fp_srchcomponentrisktype > 6.5) => map(
      ( NULL < nf_pct_rel_with_felony and nf_pct_rel_with_felony <= 0.0425724638) => -0.0141967304, 
      (nf_pct_rel_with_felony > 0.0425724638) => -0.0531160356, -0.0252845617), -0.0050992643), 
(nf_add_curr_nhood_MFD_pct > 0.03139907025) => 0.0020684378, -0.0003749105);

// Tree: 492
final_score_492 := map(
( NULL < nf_fp_srchfraudsrchcountmo and nf_fp_srchfraudsrchcountmo <= 10.5) => 0.0004995406, 
(nf_fp_srchfraudsrchcountmo > 10.5) => map(
   ( NULL < nf_fp_srchfraudsrchcountyr and nf_fp_srchfraudsrchcountyr <= 12.5) => 0.1419913741, 
   (nf_fp_srchfraudsrchcountyr > 12.5) => map(
      ( NULL < nf_add_curr_nhood_MFD_pct and nf_add_curr_nhood_MFD_pct <= 0.4158377096) => 0.0286163338, 
      (nf_add_curr_nhood_MFD_pct > 0.4158377096) => -0.0723235739, 0.0079606770), 0.0296484921), 0.0006154686);

// Tree: 493
final_score_493 := map(
( NULL < rv_L79_adls_per_sfd_addr_c6 and rv_L79_adls_per_sfd_addr_c6 <= 6.5) => map(
   ( NULL < nf_phone_ver_insurance and nf_phone_ver_insurance <= 1.5) => -0.0539370093, 
   (nf_phone_ver_insurance > 1.5) => 0.0015301755, 0.0010412631), 
(rv_L79_adls_per_sfd_addr_c6 > 6.5) => map(
   ( NULL < rv_I60_inq_retail_recency and rv_I60_inq_retail_recency <= 4.5) => -0.0757721720, 
   (rv_I60_inq_retail_recency > 4.5) => 0.0835650876, -0.0396068072), 0.0008822098);

// Tree: 494
final_score_494 := map(
(iv_full_name_ver_sources in ['PHN & NONPHN']) => -0.0023369409, 
(iv_full_name_ver_sources in ['NAME NOT VERD','NONPHN ONLY','PHN ONLY']) => map(
   ( NULL < rv_I60_inq_hiRiskCred_count12 and rv_I60_inq_hiRiskCred_count12 <= 10.5) => 0.0069397974, 
   (rv_I60_inq_hiRiskCred_count12 > 10.5) => map(
      (nf_util_add_input_summary in ['|   |','| CM|']) => -0.0471264887, 
      (nf_util_add_input_summary in ['|  M|','| C |','|I  |','|I M|','|IC |','|ICM|']) => 0.0147663874, -0.0299820834), 0.0056208001), -0.0000766008);

// Tree: 495
final_score_495 := map(
( NULL < nf_fp_srchaddrsrchcountmo and nf_fp_srchaddrsrchcountmo <= 9.5) => -0.0001641724, 
(nf_fp_srchaddrsrchcountmo > 9.5) => map(
   ( NULL < nf_hh_members_ct and nf_hh_members_ct <= 8.5) => map(
      ( NULL < rv_D32_Mos_Since_Crim_LS and rv_D32_Mos_Since_Crim_LS <= 53.5) => 0.0319523458, 
      (rv_D32_Mos_Since_Crim_LS > 53.5) => -0.0551056319, 0.0120896033), 
   (nf_hh_members_ct > 8.5) => 0.1211563464, 0.0241034346), -0.0000195606);

// Tree: 496
final_score_496 := map(
(nf_historic_x_current_ct in ['0-0','2-1','2-2','3-0','3-2']) => -0.0036734221, 
(nf_historic_x_current_ct in ['1-0','1-1','2-0','3-1','3-3']) => map(
   ( NULL < nf_inq_dobs_per_ssn and nf_inq_dobs_per_ssn <= 1.5) => map(
      ( NULL < nf_inq_HighRiskCredit_count24 and nf_inq_HighRiskCredit_count24 <= 1.5) => -0.0008439816, 
      (nf_inq_HighRiskCredit_count24 > 1.5) => 0.0154399695, 0.0067991645), 
   (nf_inq_dobs_per_ssn > 1.5) => -0.0076725146, 0.0039301115), -0.0005812355);

// Tree: 497
final_score_497 := map(
( NULL < nf_Inq_Per_Add_NAS_479 and nf_Inq_Per_Add_NAS_479 <= 2.5) => -0.0003243754, 
(nf_Inq_Per_Add_NAS_479 > 2.5) => map(
   (nf_fp_addrchangeecontraj in ['-1','AA','AC','AF','BA','BB','BD','CB','DA','DB','DD','DE','DF','EA','EB','EF','FC','FD','FE','FF','UE']) => map(
      ( NULL < nf_phones_per_apt_addr_curr and nf_phones_per_apt_addr_curr <= 2.5) => -0.0735768932, 
      (nf_phones_per_apt_addr_curr > 2.5) => 0.0455458368, -0.0561168240), 
   (nf_fp_addrchangeecontraj in ['AB','AD','AE','AU','BC','BE','BF','BU','CA','CC','CD','CE','CF','CU','DC','DU','EC','ED','EE','EU','FA','FB','FU','UC','UD','UF','UU']) => 0.0308319183, -0.0291669691), -0.0005519033);

// Tree: 498
final_score_498 := map(
(iv_D34_liens_unrel_x_rel in ['0-2','1-1','2-2','3-1','3-2']) => -0.0124709791, 
(iv_D34_liens_unrel_x_rel in ['0-0','0-1','1-0','1-2','2-0','2-1','3-0']) => map(
   ( NULL < nf_inq_HighRiskCredit_count24 and nf_inq_HighRiskCredit_count24 <= 12.5) => 0.0028512368, 
   (nf_inq_HighRiskCredit_count24 > 12.5) => map(
      ( NULL < nf_fp_curraddrmedianincome and nf_fp_curraddrmedianincome <= 42918.5) => -0.0439337891, 
      (nf_fp_curraddrmedianincome > 42918.5) => -0.0031299203, -0.0136927627), 0.0020689632), -0.0000875698);

// Tree: 499
final_score_499 := map(
( NULL < iv_src_voter_adl_count and iv_src_voter_adl_count <= -0.5) => -0.0057887828, 
(iv_src_voter_adl_count > -0.5) => map(
   ( NULL < iv_Estimated_Income and iv_Estimated_Income <= 113500) => 0.0045730773, 
   (iv_Estimated_Income > 113500) => map(
      ( NULL < nf_hh_lienholders and nf_hh_lienholders <= 0.5) => 0.2182523532, 
      (nf_hh_lienholders > 0.5) => -0.0343621735, 0.1080896273), 0.0048841345), 0.0002914817);

// Tree: 500
final_score_500 := map(
( NULL < nf_inq_QuizProvider_count_week and nf_inq_QuizProvider_count_week <= 0.5) => map(
   ( NULL < rv_F01_inp_addr_address_score and rv_F01_inp_addr_address_score <= 95) => 0.0130721937, 
   (rv_F01_inp_addr_address_score > 95) => -0.0002818070, 0.0004811016), 
(nf_inq_QuizProvider_count_week > 0.5) => map(
   ( NULL < rv_email_domain_free_count and rv_email_domain_free_count <= 1.5) => 0.1805921853, 
   (rv_email_domain_free_count > 1.5) => 0.0054410617, 0.0785356251), 0.0006086958);

// Tree: 501
final_score_501 := map(
(nf_fp_addrchangeecontraj in ['-1','AA','AB','AC','AD','AE','AF','BA','BB','BD','BE','CA','CB','CC','CD','CE','CF','DA','DB','DC','DD','DE','DF','EA','EC','ED','EE','EF','FC','FD','FE','FF','UC','UD','UE','UF','UU']) => 0.0001902618, 
(nf_fp_addrchangeecontraj in ['AU','BC','BF','BU','CU','DU','EB','EU','FA','FB','FU']) => map(
   ( NULL < nf_fp_idveraddressnotcurrent and nf_fp_idveraddressnotcurrent <= 1.5) => map(
      ( NULL < nf_fp_srchfraudsrchcountyr and nf_fp_srchfraudsrchcountyr <= 2.5) => 0.0417891368, 
      (nf_fp_srchfraudsrchcountyr > 2.5) => 0.1882694423, 0.1193375338), 
   (nf_fp_idveraddressnotcurrent > 1.5) => -0.0354655200, 0.0698005566), 0.0003470559);

// Tree: 502
final_score_502 := map(
( NULL < nf_fp_curraddrburglaryindex and nf_fp_curraddrburglaryindex <= 85.5) => -0.0082850468, 
(nf_fp_curraddrburglaryindex > 85.5) => map(
   ( NULL < nf_add_input_nhood_VAC_pct and nf_add_input_nhood_VAC_pct <= 0.0719869823) => 0.0068455904, 
   (nf_add_input_nhood_VAC_pct > 0.0719869823) => map(
      ( NULL < nf_Inq_Per_SSN_NAS_479 and nf_Inq_Per_SSN_NAS_479 <= 6.5) => -0.0084347388, 
      (nf_Inq_Per_SSN_NAS_479 > 6.5) => 0.0857860117, -0.0076959645), 0.0032653197), -0.0019686422);

// Tree: 503
final_score_503 := map(
( NULL < rv_C14_addrs_per_adl_c6 and rv_C14_addrs_per_adl_c6 <= 2.5) => map(
   ( NULL < nf_inq_per_phone and nf_inq_per_phone <= 39.5) => map(
      ( NULL < iv_full_name_non_phn_src_ct and iv_full_name_non_phn_src_ct <= 4.5) => -0.0107958307, 
      (iv_full_name_non_phn_src_ct > 4.5) => 0.0017157661, 0.0005075984), 
   (nf_inq_per_phone > 39.5) => 0.0897128173, -0.0061531416), 
(rv_C14_addrs_per_adl_c6 > 2.5) => -0.0987354388, 0.0004773472);

// Tree: 504
final_score_504 := map(
( NULL < rv_C13_max_lres and rv_C13_max_lres <= 90.5) => map(
   ( NULL < nf_fp_srchssnsrchcountmo and nf_fp_srchssnsrchcountmo <= 2.5) => -0.0038697461, 
   (nf_fp_srchssnsrchcountmo > 2.5) => map(
      (iv_D34_liens_unrel_x_rel in ['0-0','0-2','1-0','1-1','2-0','2-1','2-2','3-1']) => -0.0195885182, 
      (iv_D34_liens_unrel_x_rel in ['0-1','1-2','3-0','3-2']) => 0.0305225153, -0.0158019932), -0.0055739615), 
(rv_C13_max_lres > 90.5) => 0.0043526837, 0.0010140744);

// Tree: 505
final_score_505 := map(
( NULL < rv_P88_Phn_Dst_to_Inp_Add and rv_P88_Phn_Dst_to_Inp_Add <= 2277.5) => -0.0023209578, 
(rv_P88_Phn_Dst_to_Inp_Add > 2277.5) => 0.0866664318, map(
   ( NULL < nf_fp_srchvelocityrisktype and nf_fp_srchvelocityrisktype <= 4.5) => map(
      ( NULL < rv_comb_age and rv_comb_age <= 44.5) => 0.0063101313, 
      (rv_comb_age > 44.5) => 0.1250044026, 0.0368513473), 
   (nf_fp_srchvelocityrisktype > 4.5) => -0.0003345337, 0.0023511896));

// Tree: 506
final_score_506 := map(
( NULL < rv_D30_Derog_Count and rv_D30_Derog_Count <= 24.5) => -0.0009947193, 
(rv_D30_Derog_Count > 24.5) => map(
   ( NULL < nf_fp_curraddrburglaryindex and nf_fp_curraddrburglaryindex <= 145) => map(
      ( NULL < nf_add_curr_nhood_SFD_pct and nf_add_curr_nhood_SFD_pct <= 0.743495594) => -0.0049238622, 
      (nf_add_curr_nhood_SFD_pct > 0.743495594) => 0.1643921463, 0.0981852456), 
   (nf_fp_curraddrburglaryindex > 145) => -0.0648698068, 0.0534399056), -0.0008440900);

// Tree: 507
final_score_507 := map(
( NULL < nf_mos_liens_unrel_ST_fseen and nf_mos_liens_unrel_ST_fseen <= 5.5) => map(
   ( NULL < iv_D34_liens_unrel_SC_ct and iv_D34_liens_unrel_SC_ct <= 2.5) => -0.0028187912, 
   (iv_D34_liens_unrel_SC_ct > 2.5) => 0.0463528035, -0.0022641110), 
(nf_mos_liens_unrel_ST_fseen > 5.5) => map(
   ( NULL < rv_C13_inp_addr_lres and rv_C13_inp_addr_lres <= 6.5) => -0.0448055952, 
   (rv_C13_inp_addr_lres > 6.5) => 0.0232816147, 0.0172347087), -0.0011869363);

// Tree: 508
final_score_508 := map(
( NULL < iv_inp_add_avm_chg_1yr and iv_inp_add_avm_chg_1yr <= -6174.5) => 0.0143814957, 
(iv_inp_add_avm_chg_1yr > -6174.5) => -0.0034659072, map(
   ( NULL < nf_inq_HighRiskCredit_count24 and nf_inq_HighRiskCredit_count24 <= 18.5) => -0.0013258957, 
   (nf_inq_HighRiskCredit_count24 > 18.5) => map(
      (nf_fp_addrchangeecontraj in ['-1','AA','BB','BD','CF','DB','DC','DD','DE','ED','EE','EU','FD','UU']) => 0.0063836448, 
      (nf_fp_addrchangeecontraj in ['AB','AC','AD','AE','AF','AU','BA','BC','BE','BF','BU','CA','CB','CC','CD','CE','CU','DA','DF','DU','EA','EB','EC','EF','FA','FB','FC','FE','FF','FU','UC','UD','UE','UF']) => 0.0956420143, 0.0344649296), -0.0008687621));

// Tree: 509
final_score_509 := map(
( NULL < rv_D32_criminal_count and rv_D32_criminal_count <= 25.5) => map(
   ( NULL < nf_bus_addr_match_count and nf_bus_addr_match_count <= 0.5) => -0.0011813512, 
   (nf_bus_addr_match_count > 0.5) => map(
      ( NULL < nf_fp_srchssnsrchcountwk and nf_fp_srchssnsrchcountwk <= 2.5) => 0.0071102120, 
      (nf_fp_srchssnsrchcountwk > 2.5) => 0.0402734624, 0.0080302617), 0.0008119172), 
(rv_D32_criminal_count > 25.5) => -0.1252280676, 0.0007210752);

// Tree: 510
final_score_510 := map(
(iv_college_file_type in ['H']) => map(
   ( NULL < nf_fp_prevaddrmedianvalue and nf_fp_prevaddrmedianvalue <= 77287.5) => -0.0555714132, 
   (nf_fp_prevaddrmedianvalue > 77287.5) => -0.0102031944, -0.0165950115), 
(iv_college_file_type in ['-1','A','C']) => 0.0006918498, map(
   ( NULL < nf_hh_members_w_derog_pct and nf_hh_members_w_derog_pct <= 0.8452380952) => 0.0082063909, 
   (nf_hh_members_w_derog_pct > 0.8452380952) => -0.0184664427, 0.0025453934));

// Tree: 511
final_score_511 := map(
( NULL < nf_inq_per_ssn and nf_inq_per_ssn <= 8.5) => -0.0021533520, 
(nf_inq_per_ssn > 8.5) => map(
   ( NULL < nf_inq_count24 and nf_inq_count24 <= 5.5) => map(
      ( NULL < iv_inp_add_avm_pct_chg_3yr and iv_inp_add_avm_pct_chg_3yr <= 1.73255213795) => -0.0023843505, 
      (iv_inp_add_avm_pct_chg_3yr > 1.73255213795) => 0.0772892811, 0.0242788008), 
   (nf_inq_count24 > 5.5) => 0.0014662837, 0.0069244716), -0.0003352639);

// Tree: 512
final_score_512 := map(
( NULL < nf_hh_prof_license_holders and nf_hh_prof_license_holders <= 1.5) => -0.0015550919, 
(nf_hh_prof_license_holders > 1.5) => map(
   ( NULL < nf_fp_srchvelocityrisktype and nf_fp_srchvelocityrisktype <= 5.5) => 0.1418485253, 
   (nf_fp_srchvelocityrisktype > 5.5) => map(
      ( NULL < nf_inq_per_ssn and nf_inq_per_ssn <= 16.5) => 0.0142282234, 
      (nf_inq_per_ssn > 16.5) => 0.1106024897, 0.0189160431), 0.0297505303), -0.0008556150);

// Tree: 513
final_score_513 := map(
( NULL < iv_Phn_Cell and iv_Phn_Cell <= 0.5) => map(
   ( NULL < nf_fp_srchvelocityrisktype and nf_fp_srchvelocityrisktype <= 2.5) => map(
      ( NULL < rv_bus_leadership_title and rv_bus_leadership_title <= 0.5) => 0.0209974140, 
      (rv_bus_leadership_title > 0.5) => 0.2515286538, 0.0300231069), 
   (nf_fp_srchvelocityrisktype > 2.5) => -0.0084507783, -0.0060792064), 
(iv_Phn_Cell > 0.5) => 0.0034642694, -0.0698125773);

// Tree: 514
final_score_514 := map(
(iv_inp_addr_financing_type in ['ADJ','NONE','OTH']) => -0.0012224388, 
(iv_inp_addr_financing_type in ['CNV']) => map(
   ( NULL < iv_inp_add_avm_pct_chg_1yr and iv_inp_add_avm_pct_chg_1yr <= 0.7622202115) => -0.0828299530, 
   (iv_inp_add_avm_pct_chg_1yr > 0.7622202115) => 0.0337862788, map(
      ( NULL < nf_hh_criminals_pct and nf_hh_criminals_pct <= 0.09166666665) => 0.2317503687, 
      (nf_hh_criminals_pct > 0.09166666665) => -0.0042991225, 0.1144773731)), -0.0005057198);

// Tree: 515
final_score_515 := map(
( NULL < nf_fp_prevaddrageoldest and nf_fp_prevaddrageoldest <= 1.5) => map(
   ( NULL < nf_hh_lienholders_pct and nf_hh_lienholders_pct <= 0.16228070175) => map(
      ( NULL < nf_add_curr_nhood_VAC_pct and nf_add_curr_nhood_VAC_pct <= 0.0106089583) => -0.0562623918, 
      (nf_add_curr_nhood_VAC_pct > 0.0106089583) => 0.0432212777, 0.0007106348), 
   (nf_hh_lienholders_pct > 0.16228070175) => -0.0624631413, -0.0290355255), 
(nf_fp_prevaddrageoldest > 1.5) => 0.0003871600, 0.0000622441);

// Tree: 516
final_score_516 := map(
( NULL < nf_fp_srchaddrsrchcountwk and nf_fp_srchaddrsrchcountwk <= 3.5) => -0.0004329101, 
(nf_fp_srchaddrsrchcountwk > 3.5) => map(
   ( NULL < rv_C13_Curr_Addr_LRes and rv_C13_Curr_Addr_LRes <= 250.5) => map(
      ( NULL < iv_inp_add_avm_chg_1yr and iv_inp_add_avm_chg_1yr <= 4125.5) => 0.0275834359, 
      (iv_inp_add_avm_chg_1yr > 4125.5) => -0.0508077961, -0.0275689850), 
   (rv_C13_Curr_Addr_LRes > 250.5) => 0.0778351835, -0.0188897707), -0.0006574086);

// Tree: 517
final_score_517 := map(
( NULL < rv_email_count and rv_email_count <= 15.5) => 0.0012774526, 
(rv_email_count > 15.5) => map(
   ( NULL < nf_M_Bureau_ADL_FS_noTU and nf_M_Bureau_ADL_FS_noTU <= 234.5) => map(
      ( NULL < nf_fp_srchcomponentrisktype and nf_fp_srchcomponentrisktype <= 2.5) => -0.0430782997, 
      (nf_fp_srchcomponentrisktype > 2.5) => -0.1055479812, -0.0587244814), 
   (nf_M_Bureau_ADL_FS_noTU > 234.5) => -0.0048663241, -0.0218396145), 0.0007647979);

// Tree: 518
final_score_518 := map(
( NULL < iv_mos_src_voter_adl_lseen and iv_mos_src_voter_adl_lseen <= 193.5) => map(
   ( NULL < rv_P88_Phn_Dst_to_Inp_Add and rv_P88_Phn_Dst_to_Inp_Add <= 734) => -0.0002150755, 
   (rv_P88_Phn_Dst_to_Inp_Add > 734) => -0.0262454911, map(
      ( NULL < nf_fp_srchphonesrchcountwk and nf_fp_srchphonesrchcountwk <= 3.5) => 0.0035378182, 
      (nf_fp_srchphonesrchcountwk > 3.5) => 0.0509566768, 0.0040954199)), 
(iv_mos_src_voter_adl_lseen > 193.5) => 0.1305637045, 0.0006943203);

// Tree: 519
final_score_519 := map(
( NULL < nf_hh_pct_property_owners and nf_hh_pct_property_owners <= 0.34166666665) => map(
   ( NULL < nf_inq_Other_count24 and nf_inq_Other_count24 <= 8.5) => 0.0018813787, 
   (nf_inq_Other_count24 > 8.5) => map(
      (nf_fp_addrchangeecontraj in ['-1','AA','AB','BA','CB','CC','CE','DC','DD','DE','EA','EC','ED','EE','EF','EU','FD','FE','FF','FU']) => 0.0175447224, 
      (nf_fp_addrchangeecontraj in ['AC','AD','AE','AF','AU','BB','BC','BD','BE','BF','BU','CA','CD','CF','CU','DA','DB','DF','DU','EB','FA','FB','FC','UC','UD','UE','UF','UU']) => 0.1666233518, 0.0234225810), 0.0030525342), 
(nf_hh_pct_property_owners > 0.34166666665) => -0.0067478727, -0.0007458551);

// Tree: 520
final_score_520 := map(
( NULL < iv_inp_add_avm_chg_1yr and iv_inp_add_avm_chg_1yr <= -22231.5) => map(
   ( NULL < nf_fp_srchphonesrchcountmo and nf_fp_srchphonesrchcountmo <= 0.5) => 0.0045547551, 
   (nf_fp_srchphonesrchcountmo > 0.5) => map(
      ( NULL < iv_inp_add_avm_chg_1yr and iv_inp_add_avm_chg_1yr <= -29954) => 0.0156427982, 
      (iv_inp_add_avm_chg_1yr > -29954) => 0.1323203179, 0.0485306543), 0.0175832842), 
(iv_inp_add_avm_chg_1yr > -22231.5) => -0.0015604038, -0.0010580057);

// Tree: 521
final_score_521 := map(
( NULL < nf_fp_addrchangevaluediff and nf_fp_addrchangevaluediff <= -444548.5) => 0.1513048765, 
(nf_fp_addrchangevaluediff > -444548.5) => map(
   ( NULL < nf_add_input_mobility_index and nf_add_input_mobility_index <= 0.1221409312) => map(
      ( NULL < rv_D32_Mos_Since_Crim_LS and rv_D32_Mos_Since_Crim_LS <= 12.5) => 0.0149450107, 
      (rv_D32_Mos_Since_Crim_LS > 12.5) => 0.1072015166, 0.0388231652), 
   (nf_add_input_mobility_index > 0.1221409312) => 0.0013380334, 0.0015432871), 0.0016550869);

// Tree: 522
final_score_522 := map(
( NULL < nf_hh_criminals and nf_hh_criminals <= 7.5) => map(
   ( NULL < nf_inq_Collection_count24 and nf_inq_Collection_count24 <= 3.5) => -0.0013069166, 
   (nf_inq_Collection_count24 > 3.5) => map(
      ( NULL < rv_C10_M_Hdr_FS and rv_C10_M_Hdr_FS <= 314.5) => 0.0391831441, 
      (rv_C10_M_Hdr_FS > 314.5) => -0.0194283217, 0.0189699627), -0.0006275467), 
(nf_hh_criminals > 7.5) => 0.1175619360, -0.0005317100);

// Tree: 523
final_score_523 := map(
( NULL < nf_fp_srchssnsrchcountday and nf_fp_srchssnsrchcountday <= 1.5) => 0.0001060279, 
(nf_fp_srchssnsrchcountday > 1.5) => map(
   ( NULL < nf_pct_rel_prop_sold and nf_pct_rel_prop_sold <= 0.3618181818) => map(
      (nf_historic_x_current_ct in ['0-0','1-1','2-2','3-2','3-3']) => 0.0155687388, 
      (nf_historic_x_current_ct in ['1-0','2-0','2-1','3-0','3-1']) => 0.0702621637, 0.0252452678), 
   (nf_pct_rel_prop_sold > 0.3618181818) => -0.0407617765, 0.0163491437), 0.0003573341);

// Tree: 524
final_score_524 := map(
( NULL < nf_mos_liens_unrel_ST_lseen and nf_mos_liens_unrel_ST_lseen <= 26.5) => map(
   ( NULL < nf_inq_HighRiskCredit_count_day and nf_inq_HighRiskCredit_count_day <= 0.5) => -0.0036417531, 
   (nf_inq_HighRiskCredit_count_day > 0.5) => map(
      ( NULL < nf_fp_srchfraudsrchcountday and nf_fp_srchfraudsrchcountday <= 0.5) => 0.0716234181, 
      (nf_fp_srchfraudsrchcountday > 0.5) => 0.0038753148, 0.0148267107), -0.0029463537), 
(nf_mos_liens_unrel_ST_lseen > 26.5) => 0.0167943658, -0.0020324174);

// Tree: 525
final_score_525 := map(
( NULL < nf_inq_Communications_count_week and nf_inq_Communications_count_week <= 1.5) => map(
   ( NULL < nf_bus_addr_match_count and nf_bus_addr_match_count <= 41.5) => map(
      (nf_historic_x_current_ct in ['1-1','2-1','2-2']) => -0.0075127264, 
      (nf_historic_x_current_ct in ['0-0','1-0','2-0','3-0','3-1','3-2','3-3']) => 0.0033690365, 0.0019873371), 
   (nf_bus_addr_match_count > 41.5) => -0.0569892475, 0.0017609161), 
(nf_inq_Communications_count_week > 1.5) => 0.0742016722, 0.0018140614);

// Tree: 526
final_score_526 := map(
( NULL < nf_average_rel_income and nf_average_rel_income <= 105500) => map(
   ( NULL < iv_inp_add_avm_pct_chg_1yr and iv_inp_add_avm_pct_chg_1yr <= 1.0619565035) => -0.0088652401, 
   (iv_inp_add_avm_pct_chg_1yr > 1.0619565035) => 0.0021850667, map(
      ( NULL < nf_average_rel_age and nf_average_rel_age <= 40.5) => 0.0070990060, 
      (nf_average_rel_age > 40.5) => -0.0063242070, 0.0015177616)), 
(nf_average_rel_income > 105500) => -0.0344363959, -0.0008269763);

// Tree: 527
final_score_527 := map(
( NULL < nf_mos_liens_unrel_ST_fseen and nf_mos_liens_unrel_ST_fseen <= 185.5) => map(
   ( NULL < nf_inq_HighRiskCredit_count_week and nf_inq_HighRiskCredit_count_week <= 3.5) => 0.0001857972, 
   (nf_inq_HighRiskCredit_count_week > 3.5) => map(
      ( NULL < iv_dob_src_ct and iv_dob_src_ct <= 14.5) => -0.0292809034, 
      (iv_dob_src_ct > 14.5) => 0.0544968277, -0.0206521109), 0.0000393615), 
(nf_mos_liens_unrel_ST_fseen > 185.5) => -0.0453129372, -0.0002904543);

// Tree: 528
final_score_528 := map(
( NULL < nf_average_rel_age and nf_average_rel_age <= 41.5) => map(
   (nf_fp_addrchangeecontraj in ['BD','BE','BU','DA','DB','DF','EA','FA','FC','FU','UC','UD','UE','UU']) => -0.0656080478, 
   (nf_fp_addrchangeecontraj in ['-1','AA','AB','AC','AD','AE','AF','AU','BA','BB','BC','BF','CA','CB','CC','CD','CE','CF','CU','DC','DD','DE','DU','EB','EC','ED','EE','EF','EU','FB','FD','FE','FF','UF']) => 0.0042385502, 0.0037847974), 
(nf_average_rel_age > 41.5) => map(
   ( NULL < nf_attr_arrest_recency and nf_attr_arrest_recency <= 79.5) => 0.0429948916, 
   (nf_attr_arrest_recency > 79.5) => -0.0561691712, -0.0056848002), 0.0004557641);

// Tree: 529
final_score_529 := map(
( NULL < nf_inq_HighRiskCredit_count_day and nf_inq_HighRiskCredit_count_day <= 0.5) => -0.0013387837, 
(nf_inq_HighRiskCredit_count_day > 0.5) => map(
   ( NULL < rv_I60_inq_hiRiskCred_count12 and rv_I60_inq_hiRiskCred_count12 <= 2.5) => 0.0360538241, 
   (rv_I60_inq_hiRiskCred_count12 > 2.5) => map(
      ( NULL < nf_hh_payday_loan_users_pct and nf_hh_payday_loan_users_pct <= 0.83333333335) => 0.0024190536, 
      (nf_hh_payday_loan_users_pct > 0.83333333335) => -0.1136190824, -0.0016601670), 0.0128403855), -0.0007905461);

// Tree: 530
final_score_530 := map(
( NULL < iv_mos_src_voter_adl_lseen and iv_mos_src_voter_adl_lseen <= 189.5) => map(
   (iv_D34_liens_unrel_x_rel in ['0-1','0-2','1-0','1-1','1-2','2-1','2-2','3-1','3-2']) => map(
      ( NULL < nf_fp_varrisktype and nf_fp_varrisktype <= 7.5) => -0.0061601794, 
      (nf_fp_varrisktype > 7.5) => -0.0436192333, -0.0068254717), 
   (iv_D34_liens_unrel_x_rel in ['0-0','2-0','3-0']) => 0.0022066553, -0.0006114903), 
(iv_mos_src_voter_adl_lseen > 189.5) => 0.0947675735, -0.0004875050);

// Tree: 531
final_score_531 := map(
( NULL < rv_D31_bk_dism_recent_count and rv_D31_bk_dism_recent_count <= 0.5) => -0.0019067388, 
(rv_D31_bk_dism_recent_count > 0.5) => map(
   (nf_fp_addrchangeecontraj in ['-1','AB','BA','BB','CC','CD','CE','DC','DE','DF','EF','FD','FF']) => -0.0143130496, 
   (nf_fp_addrchangeecontraj in ['AA','AC','AD','AE','AF','AU','BC','BD','BE','BF','BU','CA','CB','CF','CU','DA','DB','DD','DU','EA','EB','EC','ED','EE','EU','FA','FB','FC','FE','FU','UC','UD','UE','UF','UU']) => map(
      ( NULL < nf_util_adl_count and nf_util_adl_count <= 5.5) => 0.0697188289, 
      (nf_util_adl_count > 5.5) => 0.2052260530, 0.1270488084), 0.0488382959), -0.0017166629);

// Tree: 532
final_score_532 := map(
( NULL < nf_average_rel_income and nf_average_rel_income <= 45500) => map(
   ( NULL < nf_mos_liens_rel_SC_lseen and nf_mos_liens_rel_SC_lseen <= 62.5) => map(
      ( NULL < nf_M_Bureau_ADL_FS_all and nf_M_Bureau_ADL_FS_all <= 28.5) => 0.0895460125, 
      (nf_M_Bureau_ADL_FS_all > 28.5) => 0.0085569158, 0.0106757014), 
   (nf_mos_liens_rel_SC_lseen > 62.5) => 0.1464605628, 0.0135356985), 
(nf_average_rel_income > 45500) => -0.0011053996, -0.0003180635);

// Tree: 533
final_score_533 := map(
( NULL < nf_fp_srchaddrsrchcountmo and nf_fp_srchaddrsrchcountmo <= 14.5) => map(
   ( NULL < nf_inq_Communications_count_week and nf_inq_Communications_count_week <= 1.5) => map(
      ( NULL < rv_C12_source_profile and rv_C12_source_profile <= 85.95) => 0.0001577830, 
      (rv_C12_source_profile > 85.95) => 0.0545189103, 0.0004850696), 
   (nf_inq_Communications_count_week > 1.5) => -0.0770478608, 0.0004291346), 
(nf_fp_srchaddrsrchcountmo > 14.5) => -0.0657641309, 0.0003686445);

// Tree: 534
final_score_534 := map(
( NULL < nf_fp_srchphonesrchcountwk and nf_fp_srchphonesrchcountwk <= 1.5) => 0.0005168594, 
(nf_fp_srchphonesrchcountwk > 1.5) => map(
   ( NULL < nf_inq_per_ssn and nf_inq_per_ssn <= 5.5) => 0.0201897192, 
   (nf_inq_per_ssn > 5.5) => map(
      (nf_historic_x_current_ct in ['1-1','2-0']) => -0.0745300715, 
      (nf_historic_x_current_ct in ['0-0','1-0','2-1','2-2','3-0','3-1','3-2','3-3']) => -0.0165286940, -0.0215438507), -0.0097593714), 0.0000756275);

// Tree: 535
final_score_535 := map(
( NULL < nf_fp_srchfraudsrchcountyr and nf_fp_srchfraudsrchcountyr <= 4.5) => map(
   ( NULL < nf_fp_srchphonesrchcountwk and nf_fp_srchphonesrchcountwk <= 2.5) => -0.0051305905, 
   (nf_fp_srchphonesrchcountwk > 2.5) => map(
      ( NULL < nf_add_input_mobility_index and nf_add_input_mobility_index <= 0.278848263) => -0.0195042091, 
      (nf_add_input_mobility_index > 0.278848263) => 0.1049820063, 0.0543731243), -0.0048788002), 
(nf_fp_srchfraudsrchcountyr > 4.5) => 0.0045530254, -0.0015860736);

// Tree: 536
final_score_536 := map(
( NULL < rv_S66_adlperssn_count and rv_S66_adlperssn_count <= 7.5) => map(
   (rv_E58_br_dead_bus_x_active_phn in ['0-3','1-2','2-0','2-1','2-2','2-3','3-1','3-2']) => map(
      ( NULL < rv_C13_Curr_Addr_LRes and rv_C13_Curr_Addr_LRes <= 9.5) => -0.0938099913, 
      (rv_C13_Curr_Addr_LRes > 9.5) => -0.0208119887, -0.0304838188), 
   (rv_E58_br_dead_bus_x_active_phn in ['0-0','0-1','0-2','1-0','1-1','1-3','3-0','3-3']) => -0.0000981912, -0.0006271987), 
(rv_S66_adlperssn_count > 7.5) => 0.1102743172, -0.0004987529);

// Tree: 537
final_score_537 := map(
( NULL < nf_Inq_Per_SSN_NAS_479 and nf_Inq_Per_SSN_NAS_479 <= 19.5) => map(
   ( NULL < rv_comb_age and rv_comb_age <= 24.5) => map(
      ( NULL < nf_inq_Collection_count24 and nf_inq_Collection_count24 <= 3.5) => 0.0104750625, 
      (nf_inq_Collection_count24 > 3.5) => 0.1160759611, 0.0121833701), 
   (rv_comb_age > 24.5) => 0.0015222603, 0.0022607480), 
(nf_Inq_Per_SSN_NAS_479 > 19.5) => 0.1033236718, 0.0023257913);

// Tree: 538
final_score_538 := map(
(nf_util_add_curr_summary in ['|   |','| C |','| CM|','|I  |','|IC |','|ICM|']) => -0.0024875730, 
(nf_util_add_curr_summary in ['|  M|','|I M|']) => map(
   ( NULL < nf_fp_srchphonesrchcountmo and nf_fp_srchphonesrchcountmo <= 7.5) => map(
      ( NULL < nf_bus_addr_match_count and nf_bus_addr_match_count <= 26.5) => 0.0095851061, 
      (nf_bus_addr_match_count > 26.5) => 0.1346353254, 0.0105032901), 
   (nf_fp_srchphonesrchcountmo > 7.5) => 0.1050552596, 0.0113001781), -0.0010980987);

// Tree: 539
final_score_539 := map(
( NULL < rv_I60_inq_auto_count12 and rv_I60_inq_auto_count12 <= 3.5) => 0.0000013253, 
(rv_I60_inq_auto_count12 > 3.5) => map(
   ( NULL < rv_D32_Mos_Since_Crim_LS and rv_D32_Mos_Since_Crim_LS <= 219.5) => map(
      ( NULL < nf_average_rel_income and nf_average_rel_income <= 105500) => -0.0230103990, 
      (nf_average_rel_income > 105500) => 0.1474811534, -0.0210969136), 
   (rv_D32_Mos_Since_Crim_LS > 219.5) => 0.1119212922, -0.0180624996), -0.0010586132);

// Tree: 540
final_score_540 := map(
( NULL < nf_inq_per_sfd_addr and nf_inq_per_sfd_addr <= 33.5) => -0.0003998402, 
(nf_inq_per_sfd_addr > 33.5) => map(
   ( NULL < nf_add_input_nhood_VAC_pct and nf_add_input_nhood_VAC_pct <= 0.00744902205) => map(
      ( NULL < iv_prv_addr_avm_auto_val and iv_prv_addr_avm_auto_val <= 148500) => 0.0662367823, 
      (iv_prv_addr_avm_auto_val > 148500) => -0.0826201983, 0.0077205899), 
   (nf_add_input_nhood_VAC_pct > 0.00744902205) => -0.0803641023, -0.0448422101), -0.0006097708);

// Tree: 541
final_score_541 := map(
( NULL < nf_phones_per_apt_addr_curr and nf_phones_per_apt_addr_curr <= 4.5) => map(
   ( NULL < iv_src_voter_adl_count and iv_src_voter_adl_count <= 3.5) => 0.0025573848, 
   (iv_src_voter_adl_count > 3.5) => map(
      ( NULL < rv_L80_Inp_AVM_AutoVal and rv_L80_Inp_AVM_AutoVal <= 34875) => -0.0163149042, 
      (rv_L80_Inp_AVM_AutoVal > 34875) => -0.0016917579, -0.0092128633), 0.0006046483), 
(nf_phones_per_apt_addr_curr > 4.5) => -0.0134641590, -0.0004340784);

// Tree: 542
final_score_542 := map(
( NULL < rv_C10_M_Hdr_FS and rv_C10_M_Hdr_FS <= 10.5) => 0.0923326120, 
(rv_C10_M_Hdr_FS > 10.5) => map(
   ( NULL < nf_fp_srchphonesrchcountday and nf_fp_srchphonesrchcountday <= 2.5) => 0.0003398628, 
   (nf_fp_srchphonesrchcountday > 2.5) => map(
      ( NULL < iv_Estimated_Income and iv_Estimated_Income <= 38500) => -0.0747060996, 
      (iv_Estimated_Income > 38500) => -0.0009925548, -0.0297121177), 0.0002206351), 0.0002929551);

// Tree: 543
final_score_543 := map(
( NULL < rv_C14_addrs_10yr and rv_C14_addrs_10yr <= 3.5) => -0.0021662302, 
(rv_C14_addrs_10yr > 3.5) => map(
   (nf_historic_x_current_ct in ['0-0','1-0','1-1','2-0','2-1','2-2','3-1','3-3']) => 0.0024866736, 
   (nf_historic_x_current_ct in ['3-0','3-2']) => map(
      (rv_D32_criminal_x_felony in ['0-0','1-0','2-0','3-0','3-1','3-2']) => 0.0226198660, 
      (rv_D32_criminal_x_felony in ['1-1','2-1','2-2','3-3']) => 0.1172174548, 0.0237712925), 0.0054586328), 0.0007787828);

// Tree: 544
final_score_544 := map(
( NULL < rv_C10_M_Hdr_FS and rv_C10_M_Hdr_FS <= 14.5) => map(
   ( NULL < nf_inq_Other_count24 and nf_inq_Other_count24 <= 1.5) => 0.1337226733, 
   (nf_inq_Other_count24 > 1.5) => -0.0042872075, 0.0634157529), 
(rv_C10_M_Hdr_FS > 14.5) => map(
   ( NULL < rv_L79_adls_per_addr_curr and rv_L79_adls_per_addr_curr <= 10.5) => 0.0005056137, 
   (rv_L79_adls_per_addr_curr > 10.5) => -0.0227524575, 0.0000457050), 0.0001321580);

// Tree: 545
final_score_545 := map(
(rv_D32_criminal_x_felony in ['0-0','1-0','1-1','2-0','2-1','3-0','3-1']) => -0.0001952690, 
(rv_D32_criminal_x_felony in ['2-2','3-2','3-3']) => map(
   ( NULL < nf_average_rel_distance and nf_average_rel_distance <= 172.5) => map(
      ( NULL < iv_Estimated_Income and iv_Estimated_Income <= 33500) => -0.0019226752, 
      (iv_Estimated_Income > 33500) => 0.1481335737, 0.0873746018), 
   (nf_average_rel_distance > 172.5) => -0.0030733702, 0.0369891826), -0.0000191437);

// Tree: 546
final_score_546 := map(
( NULL < nf_M_Bureau_ADL_FS_noTU and nf_M_Bureau_ADL_FS_noTU <= 5.5) => -0.0809084406, 
(nf_M_Bureau_ADL_FS_noTU > 5.5) => map(
   ( NULL < iv_prv_addr_lres and iv_prv_addr_lres <= 351.5) => -0.0009974411, 
   (iv_prv_addr_lres > 351.5) => map(
      ( NULL < nf_inq_per_phone and nf_inq_per_phone <= 5.5) => 0.0160251174, 
      (nf_inq_per_phone > 5.5) => 0.1030872602, 0.0320779678), -0.0223416587), -0.0009528697);

// Tree: 547
final_score_547 := map(
( NULL < nf_Inq_Per_Add_NAS_479 and nf_Inq_Per_Add_NAS_479 <= 0.5) => 0.0013397602, 
(nf_Inq_Per_Add_NAS_479 > 0.5) => map(
   (nf_fp_addrchangeecontraj in ['-1','AA','AC','AD','AE','BA','BB','BD','BF','BU','CA','CB','CC','CD','CE','CF','CU','DD','DE','DF','EB','ED','EE','EF','EU','FB','FD','FE','FF','FU','UC','UD','UE','UF']) => map(
      ( NULL < nf_M_Bureau_ADL_FS_noTU and nf_M_Bureau_ADL_FS_noTU <= 45.5) => 0.0422250856, 
      (nf_M_Bureau_ADL_FS_noTU > 45.5) => -0.0483453859, -0.0414513443), 
   (nf_fp_addrchangeecontraj in ['AB','AF','AU','BC','BE','DA','DB','DC','DU','EA','EC','FA','FC','UU']) => 0.0720491441, -0.0324070847), 0.0008438088);

// Tree: 548
final_score_548 := map(
( NULL < rv_D30_Derog_Count and rv_D30_Derog_Count <= 30.5) => map(
   ( NULL < rv_A49_curr_add_avm_chg_3yr and rv_A49_curr_add_avm_chg_3yr <= -46449) => 0.0575151473, 
   (rv_A49_curr_add_avm_chg_3yr > -46449) => map(
      ( NULL < rv_P88_Phn_Dst_to_Inp_Add and rv_P88_Phn_Dst_to_Inp_Add <= 362.5) => -0.0037387039, 
      (rv_P88_Phn_Dst_to_Inp_Add > 362.5) => 0.0779004735, 0.0084171251), -0.0007210636), 
(rv_D30_Derog_Count > 30.5) => 0.0743106186, -0.0002358693);

// Tree: 549
final_score_549 := map(
( NULL < nf_fp_srchaddrsrchcountmo and nf_fp_srchaddrsrchcountmo <= 5.5) => 0.0015308901, 
(nf_fp_srchaddrsrchcountmo > 5.5) => map(
   ( NULL < rv_C10_M_Hdr_FS and rv_C10_M_Hdr_FS <= 152.5) => 0.0181583184, 
   (rv_C10_M_Hdr_FS > 152.5) => map(
      ( NULL < rv_P88_Phn_Dst_to_Inp_Add and rv_P88_Phn_Dst_to_Inp_Add <= 88.5) => -0.0093180452, 
      (rv_P88_Phn_Dst_to_Inp_Add > 88.5) => -0.0770138575, -0.0438185372), -0.0110449702), 0.0011365743);

// Tree: 550
final_score_550 := map(
( NULL < nf_inq_per_addr and nf_inq_per_addr <= 10.5) => -0.0016231146, 
(nf_inq_per_addr > 10.5) => map(
   (nf_fp_addrchangeecontraj in ['AA','BA','BB','BC','BD','BF','CD','CE','DA','DB','DC','DD','EA','EB','EE','EU','FA']) => -0.0024107440, 
   (nf_fp_addrchangeecontraj in ['-1','AB','AC','AD','AE','AF','AU','BE','BU','CA','CB','CC','CF','CU','DE','DF','DU','EC','ED','EF','FB','FC','FD','FE','FF','FU','UC','UD','UE','UF','UU']) => map(
      ( NULL < nf_inq_addrs_per_ssn and nf_inq_addrs_per_ssn <= 3.5) => 0.0181726217, 
      (nf_inq_addrs_per_ssn > 3.5) => -0.0471648309, 0.0159082844), 0.0071109270), -0.0003745271);

// Tree: 551
final_score_551 := map(
( NULL < nf_fp_srchphonesrchcountmo and nf_fp_srchphonesrchcountmo <= 0.5) => -0.0027514203, 
(nf_fp_srchphonesrchcountmo > 0.5) => map(
   ( NULL < iv_fname_non_phn_src_ct and iv_fname_non_phn_src_ct <= 6.5) => 0.0162796553, 
   (iv_fname_non_phn_src_ct > 6.5) => map(
      ( NULL < rv_C13_inp_addr_lres and rv_C13_inp_addr_lres <= 12.5) => -0.0142573581, 
      (rv_C13_inp_addr_lres > 12.5) => 0.0049081437, 0.0013065379), 0.0051041645), -0.0002580702);

// Tree: 552
final_score_552 := map(
( NULL < nf_phones_per_addr_c6 and nf_phones_per_addr_c6 <= 0.5) => -0.0019089829, 
(nf_phones_per_addr_c6 > 0.5) => map(
   ( NULL < nf_fp_srchfraudsrchcountday and nf_fp_srchfraudsrchcountday <= 2.5) => 0.0059169595, 
   (nf_fp_srchfraudsrchcountday > 2.5) => map(
      ( NULL < iv_dob_src_ct and iv_dob_src_ct <= 11.5) => -0.0051667695, 
      (iv_dob_src_ct > 11.5) => 0.0894965624, 0.0341469640), 0.0061391602), 0.0005915991);

// Tree: 553
final_score_553 := map(
( NULL < nf_add_curr_nhood_BUS_pct and nf_add_curr_nhood_BUS_pct <= 0.33946190925) => -0.0008879422, 
(nf_add_curr_nhood_BUS_pct > 0.33946190925) => map(
   ( NULL < iv_inp_add_avm_chg_3yr and iv_inp_add_avm_chg_3yr <= 9099.5) => 0.2276797010, 
   (iv_inp_add_avm_chg_3yr > 9099.5) => -0.0033039882, map(
      ( NULL < nf_fp_curraddrburglaryindex and nf_fp_curraddrburglaryindex <= 109) => -0.0153594998, 
      (nf_fp_curraddrburglaryindex > 109) => 0.0651502093, 0.0268450201)), -0.0003369941);

// Tree: 554
final_score_554 := map(
( NULL < rv_C20_M_Bureau_ADL_FS and rv_C20_M_Bureau_ADL_FS <= 4.5) => -0.0518259723, 
(rv_C20_M_Bureau_ADL_FS > 4.5) => map(
   ( NULL < nf_fp_curraddrmurderindex and nf_fp_curraddrmurderindex <= 178.5) => -0.0013547227, 
   (nf_fp_curraddrmurderindex > 178.5) => map(
      (nf_fp_addrchangeecontraj in ['-1','AC','AD','BA','BB','BC','BD','BF','CA','CB','CC','CD','CE','CF','DD','DE','DF','EA','EB','EC','EE','EF','FA','FC','FD','FE','FF','UU']) => 0.0101815562, 
      (nf_fp_addrchangeecontraj in ['AA','AB','AE','AF','AU','BE','BU','CU','DA','DB','DC','DU','ED','EU','FB','FU','UC','UD','UE','UF']) => 0.1850793913, 0.0123322785), -0.0002341030), -0.0003828440);

// Tree: 555
final_score_555 := map(
(iv_college_type in ['-1','N','P','S','U']) => map(
   ( NULL < nf_fp_srchfraudsrchcountmo and nf_fp_srchfraudsrchcountmo <= 14.5) => map(
      ( NULL < rv_A49_curr_add_avm_chg_3yr and rv_A49_curr_add_avm_chg_3yr <= 28116.5) => -0.0059183679, 
      (rv_A49_curr_add_avm_chg_3yr > 28116.5) => 0.0098361403, -0.0015665892), 
   (nf_fp_srchfraudsrchcountmo > 14.5) => 0.0705443997, 0.0000681908), 
(iv_college_type in ['R']) => 0.1357459753, 0.0001642341);

// Tree: 556
final_score_556 := map(
( NULL < nf_hh_tot_derog and nf_hh_tot_derog <= 14.5) => map(
   ( NULL < nf_fp_prevaddrcartheftindex and nf_fp_prevaddrcartheftindex <= 192.5) => -0.0016210532, 
   (nf_fp_prevaddrcartheftindex > 192.5) => map(
      (nf_fp_addrchangeecontraj in ['-1','AC','BB','BC','CB','CC','CD','CF','DB','DC','DD','DF','EE','FD','FE','FF','UU']) => 0.0138448553, 
      (nf_fp_addrchangeecontraj in ['AA','AB','AD','AE','AF','AU','BA','BD','BE','BF','BU','CA','CE','CU','DA','DE','DU','EA','EB','EC','ED','EF','EU','FA','FB','FC','FU','UC','UD','UE','UF']) => 0.1529395277, 0.0178428575), -0.0010366395), 
(nf_hh_tot_derog > 14.5) => 0.1276374025, -0.0009339599);

// Tree: 557
final_score_557 := map(
( NULL < nf_fp_srchssnsrchcountmo and nf_fp_srchssnsrchcountmo <= 1.5) => 0.0017693115, 
(nf_fp_srchssnsrchcountmo > 1.5) => map(
   (iv_prof_license_source in ['IN','PL']) => -0.0087244753, 
   (iv_prof_license_source in ['PM']) => 0.1096249162, map(
      ( NULL < nf_fp_srchphonesrchcountwk and nf_fp_srchphonesrchcountwk <= 0.5) => -0.0003169049, 
      (nf_fp_srchphonesrchcountwk > 0.5) => -0.0145172646, -0.0055594102)), 0.0003228344);

// Tree: 558
final_score_558 := map(
( NULL < nf_historical_count and nf_historical_count <= 7.5) => map(
   ( NULL < nf_Inq_Per_SSN_NAS_479 and nf_Inq_Per_SSN_NAS_479 <= 14.5) => -0.0014539998, 
   (nf_Inq_Per_SSN_NAS_479 > 14.5) => 0.0886813005, -0.0013748967), 
(nf_historical_count > 7.5) => map(
   ( NULL < rv_I60_Inq_Count12 and rv_I60_Inq_Count12 <= 20.5) => 0.0120364163, 
   (rv_I60_Inq_Count12 > 20.5) => -0.0777849475, 0.0111887723), 0.0001330411);

// Tree: 559
final_score_559 := map(
( NULL < nf_add_input_nhood_SFD_pct and nf_add_input_nhood_SFD_pct <= 0.95851690115) => map(
   ( NULL < nf_fp_addrchangeincomediff and nf_fp_addrchangeincomediff <= 68504) => -0.0034429247, 
   (nf_fp_addrchangeincomediff > 68504) => 0.2049114985, -0.0032695820), 
(nf_add_input_nhood_SFD_pct > 0.95851690115) => map(
   ( NULL < nf_inq_Communications_count24 and nf_inq_Communications_count24 <= 1.5) => 0.0045863761, 
   (nf_inq_Communications_count24 > 1.5) => 0.0336129460, 0.0060245775), -0.0011663433);

// Tree: 560
final_score_560 := map(
( NULL < rv_A49_Curr_AVM_Chg_1yr_Pct and rv_A49_Curr_AVM_Chg_1yr_Pct <= 421.05) => map(
   ( NULL < iv_fname_non_phn_src_ct and iv_fname_non_phn_src_ct <= 3.5) => map(
      ( NULL < nf_lowest_rel_education and nf_lowest_rel_education <= 14) => 0.0104335022, 
      (nf_lowest_rel_education > 14) => 0.1086177815, 0.0306699567), 
   (iv_fname_non_phn_src_ct > 3.5) => 0.0005472078, 0.0014431279), 
(rv_A49_Curr_AVM_Chg_1yr_Pct > 421.05) => -0.0961165878, -0.0007833793);

// Tree: 561
final_score_561 := map(
( NULL < nf_fp_srchphonesrchcountday and nf_fp_srchphonesrchcountday <= 2.5) => 0.0003761112, 
(nf_fp_srchphonesrchcountday > 2.5) => map(
   (nf_fp_addrchangeecontraj in ['AB','DB','DD','FF']) => -0.0763454157, 
   (nf_fp_addrchangeecontraj in ['-1','AA','AC','AD','AE','AF','AU','BA','BB','BC','BD','BE','BF','BU','CA','CB','CC','CD','CE','CF','CU','DA','DC','DE','DF','DU','EA','EB','EC','ED','EE','EF','EU','FA','FB','FC','FD','FE','FU','UC','UD','UE','UF','UU']) => map(
      ( NULL < iv_prv_addr_lres and iv_prv_addr_lres <= 57.5) => -0.0299589860, 
      (iv_prv_addr_lres > 57.5) => 0.0484833441, 0.0046479243), -0.0330645996), 0.0002383783);

// Tree: 562
final_score_562 := map(
( NULL < iv_D34_liens_unrel_CJ_ct and iv_D34_liens_unrel_CJ_ct <= 4.5) => -0.0010105899, 
(iv_D34_liens_unrel_CJ_ct > 4.5) => map(
   ( NULL < nf_pct_rel_prop_sold and nf_pct_rel_prop_sold <= 0.36038961035) => map(
      ( NULL < nf_add_curr_nhood_SFD_pct and nf_add_curr_nhood_SFD_pct <= 0.5891366242) => 0.1085177811, 
      (nf_add_curr_nhood_SFD_pct > 0.5891366242) => 0.0046182652, 0.0240025032), 
   (nf_pct_rel_prop_sold > 0.36038961035) => 0.1809549083, 0.0394231298), -0.0006239108);

// Tree: 563
final_score_563 := map(
( NULL < iv_unverified_addr_count and iv_unverified_addr_count <= 1.5) => map(
   ( NULL < rv_D32_criminal_count and rv_D32_criminal_count <= 10.5) => map(
      ( NULL < rv_L79_adls_per_addr_curr and rv_L79_adls_per_addr_curr <= 16.5) => -0.0068338150, 
      (rv_L79_adls_per_addr_curr > 16.5) => 0.1056713406, -0.0064813737), 
   (rv_D32_criminal_count > 10.5) => 0.1169408271, -0.0061280229), 
(iv_unverified_addr_count > 1.5) => 0.0032324375, 0.0009179241);

// Tree: 564
final_score_564 := map(
( NULL < iv_inp_add_avm_pct_chg_3yr and iv_inp_add_avm_pct_chg_3yr <= 1.5574241568) => -0.0064356563, 
(iv_inp_add_avm_pct_chg_3yr > 1.5574241568) => map(
   ( NULL < rv_I60_inq_hiRiskCred_recency and rv_I60_inq_hiRiskCred_recency <= 2) => map(
      ( NULL < rv_P88_Phn_Dst_to_Inp_Add and rv_P88_Phn_Dst_to_Inp_Add <= 68.5) => 0.0170300611, 
      (rv_P88_Phn_Dst_to_Inp_Add > 68.5) => 0.1142791709, 0.0471268339), 
   (rv_I60_inq_hiRiskCred_recency > 2) => -0.0051565609, 0.0051953738), 0.0003346485);

// Tree: 565
final_score_565 := map(
( NULL < iv_unverified_addr_count and iv_unverified_addr_count <= 1.5) => map(
   ( NULL < iv_inp_add_avm_pct_chg_1yr and iv_inp_add_avm_pct_chg_1yr <= 2.05825791855) => map(
      ( NULL < nf_fp_srchaddrsrchcountwk and nf_fp_srchaddrsrchcountwk <= 1.5) => -0.0012461711, 
      (nf_fp_srchaddrsrchcountwk > 1.5) => 0.0310342551, 0.0003354595), 
   (iv_inp_add_avm_pct_chg_1yr > 2.05825791855) => -0.0686086728, -0.0119017433), 
(iv_unverified_addr_count > 1.5) => 0.0025951949, 0.0003448273);

// Tree: 566
final_score_566 := map(
( NULL < rv_C12_inp_addr_source_count and rv_C12_inp_addr_source_count <= 2.5) => map(
   ( NULL < nf_hh_payday_loan_users_pct and nf_hh_payday_loan_users_pct <= 0.2403846154) => 0.0083923561, 
   (nf_hh_payday_loan_users_pct > 0.2403846154) => map(
      ( NULL < nf_M_Bureau_ADL_FS_noTU and nf_M_Bureau_ADL_FS_noTU <= 116.5) => 0.1414725048, 
      (nf_M_Bureau_ADL_FS_noTU > 116.5) => 0.0318940635, 0.0463335872), 0.0131320914), 
(rv_C12_inp_addr_source_count > 2.5) => 0.0004140012, 0.0014783451);

// Tree: 567
final_score_567 := map(
( NULL < nf_fp_srchphonesrchcountmo and nf_fp_srchphonesrchcountmo <= 0.5) => -0.0024896275, 
(nf_fp_srchphonesrchcountmo > 0.5) => map(
   ( NULL < nf_mos_liens_unrel_ST_fseen and nf_mos_liens_unrel_ST_fseen <= 86.5) => 0.0067442496, 
   (nf_mos_liens_unrel_ST_fseen > 86.5) => map(
      ( NULL < nf_fp_srchphonesrchcountwk and nf_fp_srchphonesrchcountwk <= 0.5) => -0.0011833933, 
      (nf_fp_srchphonesrchcountwk > 0.5) => -0.0502260794, -0.0205596331), 0.0057535523), 0.0001303571);

// Tree: 568
final_score_568 := map(
( NULL < rv_C20_M_Bureau_ADL_FS and rv_C20_M_Bureau_ADL_FS <= 94.5) => map(
   ( NULL < rv_A49_Curr_AVM_Chg_1yr_Pct and rv_A49_Curr_AVM_Chg_1yr_Pct <= 91.15) => map(
      ( NULL < nf_fp_srchphonesrchcountmo and nf_fp_srchphonesrchcountmo <= 1.5) => 0.0307978146, 
      (nf_fp_srchphonesrchcountmo > 1.5) => 0.1025290739, 0.0429988325), 
   (rv_A49_Curr_AVM_Chg_1yr_Pct > 91.15) => 0.0050095477, 0.0058464513), 
(rv_C20_M_Bureau_ADL_FS > 94.5) => -0.0022696298, -0.0010115026);

// Tree: 569
final_score_569 := map(
( NULL < nf_M_Bureau_ADL_FS_all and nf_M_Bureau_ADL_FS_all <= 21.5) => -0.0460036601, 
(nf_M_Bureau_ADL_FS_all > 21.5) => map(
   (nf_fp_addrchangeecontraj in ['AC','AF','BA','BD','BF','BU','CA','CE','CF','CU','DC','EB','EU','FB','FU','UC','UE','UU']) => -0.0606953197, 
   (nf_fp_addrchangeecontraj in ['-1','AA','AB','AD','AE','AU','BB','BC','BE','CB','CC','CD','DA','DB','DD','DE','DF','DU','EA','EC','ED','EE','EF','FA','FC','FD','FE','FF','UD','UF']) => map(
      ( NULL < iv_inp_add_avm_pct_chg_3yr and iv_inp_add_avm_pct_chg_3yr <= 1.1458171562) => 0.0104818910, 
      (iv_inp_add_avm_pct_chg_3yr > 1.1458171562) => -0.0067507399, -0.0005084535), -0.0014518535), -0.0017053015);

// Tree: 570
final_score_570 := map(
( NULL < nf_util_adl_count and nf_util_adl_count <= 25.5) => map(
   ( NULL < nf_fp_srchaddrsrchcountday and nf_fp_srchaddrsrchcountday <= 4.5) => 0.0001007612, 
   (nf_fp_srchaddrsrchcountday > 4.5) => 0.0604631194, 0.0001695083), 
(nf_util_adl_count > 25.5) => map(
   ( NULL < nf_pct_rel_prop_sold and nf_pct_rel_prop_sold <= 0.05409356725) => 0.1311378452, 
   (nf_pct_rel_prop_sold > 0.05409356725) => 0.0265882417, 0.0488172462), 0.0004374951);

// Tree: 571
final_score_571 := map(
( NULL < nf_inq_Communications_count24 and nf_inq_Communications_count24 <= 10.5) => map(
   ( NULL < iv_Phn_PCS and iv_Phn_PCS <= 0.5) => 0.0016539023, 
   (iv_Phn_PCS > 0.5) => map(
      ( NULL < nf_fp_srchphonesrchcountmo and nf_fp_srchphonesrchcountmo <= 7.5) => -0.0082681433, 
      (nf_fp_srchphonesrchcountmo > 7.5) => -0.0598597482, -0.0086785420), 0.0414665358), 
(nf_inq_Communications_count24 > 10.5) => 0.0963884231, -0.0003631826);

// Tree: 572
final_score_572 := map(
( NULL < nf_fp_srchfraudsrchcountwk and nf_fp_srchfraudsrchcountwk <= 7.5) => map(
   (nf_fp_addrchangeecontraj in ['AB','AE','AF','BC','BD','BF','BU','CA','CB','CF','EB','EU','FB','UC','UE']) => -0.0687201426, 
   (nf_fp_addrchangeecontraj in ['-1','AA','AC','AD','AU','BA','BB','BE','CC','CD','CE','CU','DA','DB','DC','DD','DE','DF','DU','EA','EC','ED','EE','EF','FA','FC','FD','FE','FF','FU','UD','UF','UU']) => map(
      ( NULL < nf_fp_srchunvrfddobcount and nf_fp_srchunvrfddobcount <= 0.5) => 0.0020839034, 
      (nf_fp_srchunvrfddobcount > 0.5) => -0.0057600344, 0.0003165400), -0.0000080936), 
(nf_fp_srchfraudsrchcountwk > 7.5) => 0.0561621534, 0.0000417937);

// Tree: 573
final_score_573 := map(
( NULL < nf_inq_per_apt_addr and nf_inq_per_apt_addr <= 2.5) => -0.0017864480, 
(nf_inq_per_apt_addr > 2.5) => map(
   ( NULL < nf_pct_rel_with_bk and nf_pct_rel_with_bk <= 0.55050505055) => 0.0070120562, 
   (nf_pct_rel_with_bk > 0.55050505055) => map(
      ( NULL < nf_pct_rel_with_bk and nf_pct_rel_with_bk <= 0.6449579832) => 0.1786801866, 
      (nf_pct_rel_with_bk > 0.6449579832) => 0.0063653407, 0.0847645123), 0.0090339651), -0.0006562460);

// Tree: 574
final_score_574 := map(
( NULL < nf_pct_rel_prop_owned and nf_pct_rel_prop_owned <= 0.18065268065) => map(
   (nf_fp_addrchangeecontraj in ['-1','AA','AC','AD','AE','BB','BC','BE','BU','CA','CB','CC','CD','CE','DA','DB','DD','DE','DF','DU','EA','ED','EE','EF','FA','FB','FC','FD','FE','FF','FU','UE']) => map(
      ( NULL < nf_M_Bureau_ADL_FS_all and nf_M_Bureau_ADL_FS_all <= 336.5) => 0.0132262746, 
      (nf_M_Bureau_ADL_FS_all > 336.5) => -0.0253843654, 0.0070037546), 
   (nf_fp_addrchangeecontraj in ['AB','AF','AU','BA','BD','BF','CF','CU','DC','EB','EC','EU','UC','UD','UF','UU']) => 0.1809509919, 0.0084242977), 
(nf_pct_rel_prop_owned > 0.18065268065) => -0.0019260093, -0.0005883414);

// Tree: 575
final_score_575 := map(
( NULL < nf_fp_curraddrmedianincome and nf_fp_curraddrmedianincome <= 20985) => map(
   ( NULL < rv_P88_Phn_Dst_to_Inp_Add and rv_P88_Phn_Dst_to_Inp_Add <= 0.5) => 0.0025997277, 
   (rv_P88_Phn_Dst_to_Inp_Add > 0.5) => -0.0350033129, map(
      ( NULL < nf_inq_per_phone and nf_inq_per_phone <= 1.5) => 0.0053933128, 
      (nf_inq_per_phone > 1.5) => -0.0610412246, -0.0319761145)), 
(nf_fp_curraddrmedianincome > 20985) => -0.0005119609, -0.0010092630);

// Tree: 576
final_score_576 := map(
( NULL < nf_inq_count24 and nf_inq_count24 <= 30.5) => map(
   ( NULL < nf_inq_Other_count24 and nf_inq_Other_count24 <= 22.5) => -0.0001714166, 
   (nf_inq_Other_count24 > 22.5) => map(
      (nf_historic_x_current_ct in ['1-0','1-1','2-1','3-1','3-2','3-3']) => -0.0110782885, 
      (nf_historic_x_current_ct in ['0-0','2-0','2-2','3-0']) => 0.1967907444, 0.0804363801), -0.0000055698), 
(nf_inq_count24 > 30.5) => -0.0487568469, -0.0002647216);

// Tree: 577
final_score_577 := map(
( NULL < rv_D32_Mos_Since_Crim_LS and rv_D32_Mos_Since_Crim_LS <= 120.5) => 0.0030200293, 
(rv_D32_Mos_Since_Crim_LS > 120.5) => map(
   ( NULL < iv_Wealth_Index and iv_Wealth_Index <= 1.5) => map(
      ( NULL < rv_I60_inq_comm_recency and rv_I60_inq_comm_recency <= 18) => -0.0202698635, 
      (rv_I60_inq_comm_recency > 18) => 0.1978051136, 0.0514653263), 
   (iv_Wealth_Index > 1.5) => -0.0151572579, -0.0138333420), 0.0013608307);

// Tree: 578
final_score_578 := map(
( NULL < rv_L79_adls_per_addr_curr and rv_L79_adls_per_addr_curr <= 0.5) => map(
   (nf_fp_addrchangeecontraj in ['AA','AB','AC','BA','BB','BU','CA','CB','CC','CF','DA','DB','DD','DU','EA','EB','ED','EE','FA','FB','FF','FU','UC','UD']) => -0.0341406881, 
   (nf_fp_addrchangeecontraj in ['-1','AD','AE','AF','AU','BC','BD','BE','BF','CD','CE','CU','DC','DE','DF','EC','EF','EU','FC','FD','FE','UE','UF','UU']) => map(
      ( NULL < iv_dob_src_ct and iv_dob_src_ct <= 8.5) => 0.0380043024, 
      (iv_dob_src_ct > 8.5) => -0.0205569269, 0.0138403704), -0.0164521623), 
(rv_L79_adls_per_addr_curr > 0.5) => -0.0010273684, -0.0020156638);

// Tree: 579
final_score_579 := map(
( NULL < rv_I60_inq_retpymt_count12 and rv_I60_inq_retpymt_count12 <= 1.5) => -0.0007603567, 
(rv_I60_inq_retpymt_count12 > 1.5) => map(
   ( NULL < nf_add_input_nhood_VAC_pct and nf_add_input_nhood_VAC_pct <= 0.01399092195) => 0.0006567247, 
   (nf_add_input_nhood_VAC_pct > 0.01399092195) => map(
      ( NULL < nf_pct_rel_prop_sold and nf_pct_rel_prop_sold <= 0.0435606061) => -0.0427280660, 
      (nf_pct_rel_prop_sold > 0.0435606061) => 0.1653681396, 0.1069371853), 0.0541925399), -0.0004753188);

// Tree: 580
final_score_580 := map(
( NULL < nf_inq_count24 and nf_inq_count24 <= 16.5) => -0.0020017534, 
(nf_inq_count24 > 16.5) => map(
   ( NULL < nf_fp_prevaddrburglaryindex and nf_fp_prevaddrburglaryindex <= 110.5) => -0.0020550430, 
   (nf_fp_prevaddrburglaryindex > 110.5) => map(
      ( NULL < rv_L79_adls_per_sfd_addr and rv_L79_adls_per_sfd_addr <= 6.5) => 0.0294685705, 
      (rv_L79_adls_per_sfd_addr > 6.5) => 0.1330056164, 0.0396661891), 0.0145202849), -0.0014686130);

// Tree: 581
final_score_581 := map(
( NULL < iv_full_name_non_phn_src_ct and iv_full_name_non_phn_src_ct <= 4.5) => map(
   ( NULL < rv_L79_adls_per_apt_addr_c6 and rv_L79_adls_per_apt_addr_c6 <= 4.5) => map(
      (nf_fp_addrchangeecontraj in ['-1','AA','AD','AF','BB','BC','BD','BE','BF','CA','CC','CD','CE','CF','DA','DC','DD','DF','DU','EA','EB','EC','ED','EE','EF','EU','FA','FD','FE','FF']) => -0.0097736359, 
      (nf_fp_addrchangeecontraj in ['AB','AC','AE','AU','BA','BU','CB','CU','DB','DE','FB','FC','FU','UC','UD','UE','UF','UU']) => 0.1454655354, -0.0087400862), 
   (rv_L79_adls_per_apt_addr_c6 > 4.5) => -0.1122193718, -0.0097497733), 
(iv_full_name_non_phn_src_ct > 4.5) => 0.0006072797, -0.0004040132);

// Tree: 582
final_score_582 := map(
( NULL < rv_A49_Curr_AVM_Chg_1yr and rv_A49_Curr_AVM_Chg_1yr <= -59036.5) => -0.0554173469, 
(rv_A49_Curr_AVM_Chg_1yr > -59036.5) => 0.0008708621, map(
   (iv_college_major in ['BUSINESS','LIBERAL ARTS','MEDICAL','NO AMS FOUND','NO COLLEGE FOUND','UNCLASSIFIED']) => -0.0006546225, 
   (iv_college_major in ['SCIENCE']) => map(
      ( NULL < iv_Estimated_Income and iv_Estimated_Income <= 37500) => 0.1559694632, 
      (iv_Estimated_Income > 37500) => -0.0011579140, 0.0606626934), -0.0003020580));

// Tree: 583
final_score_583 := map(
( NULL < rv_D32_attr_felonies_recency and rv_D32_attr_felonies_recency <= 79.5) => 0.0011941767, 
(rv_D32_attr_felonies_recency > 79.5) => map(
   ( NULL < nf_add_input_nhood_BUS_pct and nf_add_input_nhood_BUS_pct <= 0.1623954128) => map(
      ( NULL < nf_pct_rel_with_criminal and nf_pct_rel_with_criminal <= 0.1695402299) => 0.0307858871, 
      (nf_pct_rel_with_criminal > 0.1695402299) => -0.0453576249, -0.0321223793), 
   (nf_add_input_nhood_BUS_pct > 0.1623954128) => 0.0654286087, -0.0232714116), 0.0008711051);

// Tree: 584
final_score_584 := map(
( NULL < nf_inq_RetailPayments_count24 and nf_inq_RetailPayments_count24 <= 0.5) => map(
   ( NULL < nf_inq_lnames_per_apt_addr and nf_inq_lnames_per_apt_addr <= 2.5) => -0.0009126858, 
   (nf_inq_lnames_per_apt_addr > 2.5) => -0.0222843330, -0.0012958311), 
(nf_inq_RetailPayments_count24 > 0.5) => map(
   ( NULL < nf_average_rel_income and nf_average_rel_income <= 100500) => 0.0128157385, 
   (nf_average_rel_income > 100500) => 0.1387438554, 0.0162822990), -0.0000877122);

// Tree: 585
final_score_585 := map(
( NULL < rv_C14_addrs_10yr and rv_C14_addrs_10yr <= 15.5) => map(
   ( NULL < nf_add_input_nhood_MFD_pct and nf_add_input_nhood_MFD_pct <= 0.93539553325) => -0.0011470198, 
   (nf_add_input_nhood_MFD_pct > 0.93539553325) => map(
      ( NULL < nf_pct_rel_with_felony and nf_pct_rel_with_felony <= 0.2240143369) => 0.0149827092, 
      (nf_pct_rel_with_felony > 0.2240143369) => 0.1644020288, 0.0202775115), -0.0007575481), 
(rv_C14_addrs_10yr > 15.5) => 0.0834288975, -0.0006946997);

// Tree: 586
final_score_586 := map(
( NULL < rv_D34_unrel_liens_ct and rv_D34_unrel_liens_ct <= 15.5) => map(
   ( NULL < nf_add_input_nhood_MFD_pct and nf_add_input_nhood_MFD_pct <= 0.4565947989) => 0.0025446291, 
   (nf_add_input_nhood_MFD_pct > 0.4565947989) => -0.0064200059, 0.0007474487), 
(rv_D34_unrel_liens_ct > 15.5) => map(
   ( NULL < rv_email_count and rv_email_count <= 5.5) => 0.1594264208, 
   (rv_email_count > 5.5) => -0.0262799093, 0.0673535344), 0.0008494659);

// Tree: 587
final_score_587 := map(
( NULL < nf_inq_addrs_per_ssn and nf_inq_addrs_per_ssn <= 5.5) => map(
   ( NULL < rv_D32_Mos_Since_Fel_LS and rv_D32_Mos_Since_Fel_LS <= 4.5) => 0.0000591416, 
   (rv_D32_Mos_Since_Fel_LS > 4.5) => map(
      ( NULL < rv_D32_Mos_Since_Crim_LS and rv_D32_Mos_Since_Crim_LS <= 30.5) => 0.0824135478, 
      (rv_D32_Mos_Since_Crim_LS > 30.5) => 0.0102852885, 0.0208113518), 0.0003321442), 
(nf_inq_addrs_per_ssn > 5.5) => 0.0725760075, 0.0004148871);

// Tree: 588
final_score_588 := map(
( NULL < nf_add_input_nhood_VAC_pct and nf_add_input_nhood_VAC_pct <= 0.0423702413) => 0.0017294109, 
(nf_add_input_nhood_VAC_pct > 0.0423702413) => map(
   (rv_D32_criminal_x_felony in ['2-0','2-1','2-2','3-0','3-2','3-3']) => map(
      ( NULL < nf_add_curr_nhood_SFD_pct and nf_add_curr_nhood_SFD_pct <= 0.96148229515) => -0.0293330594, 
      (nf_add_curr_nhood_SFD_pct > 0.96148229515) => 0.0400435986, -0.0203812325), 
   (rv_D32_criminal_x_felony in ['0-0','1-0','1-1','3-1']) => -0.0032727641, -0.0059318955), -0.0004147648);

// Tree: 589
final_score_589 := map(
( NULL < iv_D34_liens_unrel_SC_ct and iv_D34_liens_unrel_SC_ct <= 4.5) => map(
   ( NULL < nf_phones_per_sfd_addr_c6 and nf_phones_per_sfd_addr_c6 <= 3.5) => 0.0019331815, 
   (nf_phones_per_sfd_addr_c6 > 3.5) => 0.0969188220, 0.0020461486), 
(iv_D34_liens_unrel_SC_ct > 4.5) => map(
   ( NULL < rv_C12_inp_addr_source_count and rv_C12_inp_addr_source_count <= 4.5) => 0.0087119116, 
   (rv_C12_inp_addr_source_count > 4.5) => -0.0795875605, -0.0569608208), 0.0018023495);

// Tree: 590
final_score_590 := map(
( NULL < nf_fp_srchssnsrchcountday and nf_fp_srchssnsrchcountday <= 4.5) => map(
   ( NULL < nf_fp_divrisktype and nf_fp_divrisktype <= 6.5) => -0.0005528077, 
   (nf_fp_divrisktype > 6.5) => map(
      ( NULL < nf_hh_pct_property_owners and nf_hh_pct_property_owners <= 0.1702898551) => 0.0785848112, 
      (nf_hh_pct_property_owners > 0.1702898551) => -0.0092571415, 0.0372474217), -0.0003623354), 
(nf_fp_srchssnsrchcountday > 4.5) => -0.0556488707, -0.0004334929);

// Tree: 591
final_score_591 := map(
( NULL < nf_fp_srchphonesrchcountwk and nf_fp_srchphonesrchcountwk <= 1.5) => 0.0008329318, 
(nf_fp_srchphonesrchcountwk > 1.5) => map(
   (nf_fp_addrchangeecontraj in ['-1','AA','AB','AD','BA','BB','BC','BD','BE','BF','BU','CA','CC','CE','DB','DC','DD','DF','EB','EC','EE','EF','FE','FF','FU','UU']) => map(
      ( NULL < nf_add_input_mobility_index and nf_add_input_mobility_index <= 0.7652836306) => -0.0130494211, 
      (nf_add_input_mobility_index > 0.7652836306) => 0.0846834579, -0.0113726315), 
   (nf_fp_addrchangeecontraj in ['AC','AE','AF','AU','CB','CD','CF','CU','DA','DE','DU','EA','ED','EU','FA','FB','FC','FD','UC','UD','UE','UF']) => 0.1153490145, -0.0093878346), 0.0003961919);

// Tree: 592
final_score_592 := map(
( NULL < nf_lowest_rel_income and nf_lowest_rel_income <= 37.5) => map(
   ( NULL < nf_inq_Other_count24 and nf_inq_Other_count24 <= 6.5) => 0.0015532069, 
   (nf_inq_Other_count24 > 6.5) => map(
      ( NULL < nf_rel_felony_count and nf_rel_felony_count <= 4.5) => 0.0136138287, 
      (nf_rel_felony_count > 4.5) => 0.0879110086, 0.0153086373), 0.0028861243), 
(nf_lowest_rel_income > 37.5) => -0.0051743094, -0.0002462986);

// Tree: 593
final_score_593 := map(
( NULL < nf_average_rel_home_val and nf_average_rel_home_val <= 52500) => map(
   (nf_fp_addrchangeecontraj in ['-1','BB','BD','CD','CE','DB','DC','DE','EC','EE','FE','FF']) => -0.0863698048, 
   (nf_fp_addrchangeecontraj in ['AA','AB','AC','AD','AE','AF','AU','BA','BC','BE','BF','BU','CA','CB','CC','CF','CU','DA','DD','DF','DU','EA','EB','ED','EF','EU','FA','FB','FC','FD','FU','UC','UD','UE','UF','UU']) => 0.0300788312, -0.0509998920), 
(nf_average_rel_home_val > 52500) => map(
   ( NULL < nf_average_rel_distance and nf_average_rel_distance <= 297.5) => 0.0033574869, 
   (nf_average_rel_distance > 297.5) => -0.0062441056, 0.0005463615), 0.0002624077);

// Tree: 594
final_score_594 := map(
(iv_D34_liens_unrel_x_rel in ['0-2','1-1','2-0','2-1','2-2','3-2']) => -0.0089007803, 
(iv_D34_liens_unrel_x_rel in ['0-0','0-1','1-0','1-2','3-0','3-1']) => map(
   ( NULL < rv_I60_inq_other_recency and rv_I60_inq_other_recency <= 4.5) => map(
      ( NULL < rv_I62_inq_phones_per_adl and rv_I62_inq_phones_per_adl <= 2.5) => 0.0046101900, 
      (rv_I62_inq_phones_per_adl > 2.5) => 0.0160801704, 0.0063936776), 
   (rv_I60_inq_other_recency > 4.5) => -0.0010623406, 0.0024537391), 0.0003851623);

// Tree: 595
final_score_595 := map(
( NULL < nf_inq_count24 and nf_inq_count24 <= 10.5) => 0.0024512645, 
(nf_inq_count24 > 10.5) => map(
   ( NULL < nf_addrs_per_ssn_c6 and nf_addrs_per_ssn_c6 <= 1.5) => map(
      (nf_fp_addrchangeecontraj in ['-1','AA','AB','AE','BA','BB','BC','BE','CA','CC','CD','CE','DC','DD','DF','EA','EB','ED','EE','EF','EU','FC','FD','FE','FF','FU','UU']) => -0.0113986099, 
      (nf_fp_addrchangeecontraj in ['AC','AD','AF','AU','BD','BF','BU','CB','CF','CU','DA','DB','DE','DU','EC','FA','FB','UC','UD','UE','UF']) => 0.1489409960, -0.0102968188), 
   (nf_addrs_per_ssn_c6 > 1.5) => 0.1214066396, -0.0091946978), 0.0011973100);

// Tree: 596
final_score_596 := map(
(nf_fp_addrchangeecontraj in ['-1','AA','AD','AE','BA','BB','BU','CA','CB','CC','CD','CF','CU','DA','DB','DC','DD','DE','DF','DU','EB','EC','ED','EE','EF','EU','FA','FC','FD','FF','UC','UE']) => -0.0015325590, 
(nf_fp_addrchangeecontraj in ['AB','AC','AF','AU','BC','BD','BE','BF','CE','EA','FB','FE','FU','UD','UF','UU']) => map(
   ( NULL < nf_fp_prevaddrmedianvalue and nf_fp_prevaddrmedianvalue <= 47030) => 0.1576667987, 
   (nf_fp_prevaddrmedianvalue > 47030) => map(
      ( NULL < nf_inq_Communications_count24 and nf_inq_Communications_count24 <= 0.5) => 0.0095209748, 
      (nf_inq_Communications_count24 > 0.5) => 0.1004400886, 0.0203752464), 0.0300413581), -0.0011920146);

// Tree: 597
final_score_597 := map(
(iv_college_code_x_type in ['-1','1-P','1-S','2-P','2-R','2-S','2-U','4-P','4-S']) => map(
   ( NULL < nf_fp_prevaddrcartheftindex and nf_fp_prevaddrcartheftindex <= 62) => 0.0076046450, 
   (nf_fp_prevaddrcartheftindex > 62) => map(
      ( NULL < nf_M_Bureau_ADL_FS_noTU and nf_M_Bureau_ADL_FS_noTU <= 10.5) => 0.0874888535, 
      (nf_M_Bureau_ADL_FS_noTU > 10.5) => -0.0013970724, -0.0012293754), 0.0013925204), 
(iv_college_code_x_type in ['1-R','4-R']) => 0.1107808046, 0.0014741807);

// Tree: 598
final_score_598 := map(
( NULL < nf_add_input_mobility_index and nf_add_input_mobility_index <= 0.22424848995) => map(
   ( NULL < nf_fp_srchaddrsrchcountmo and nf_fp_srchaddrsrchcountmo <= 4.5) => -0.0081756031, 
   (nf_fp_srchaddrsrchcountmo > 4.5) => map(
      (iv_D34_liens_unrel_x_rel in ['0-0','0-1','0-2','1-0','1-2','2-0','2-1','3-2']) => -0.0480678567, 
      (iv_D34_liens_unrel_x_rel in ['1-1','2-2','3-0','3-1']) => 0.0523497221, -0.0341255813), -0.0094374369), 
(nf_add_input_mobility_index > 0.22424848995) => 0.0026256341, 0.0006934808);

// Tree: 599
final_score_599 := map(
( NULL < rv_I60_inq_comm_count12 and rv_I60_inq_comm_count12 <= 2.5) => 0.0015590191, 
(rv_I60_inq_comm_count12 > 2.5) => map(
   ( NULL < iv_unverified_addr_count and iv_unverified_addr_count <= 7.5) => -0.0363931853, 
   (iv_unverified_addr_count > 7.5) => map(
      ( NULL < nf_phones_per_apt_addr_curr and nf_phones_per_apt_addr_curr <= 0.5) => 0.0977430967, 
      (nf_phones_per_apt_addr_curr > 0.5) => -0.0799485713, 0.0356727195), -0.0236242264), 0.0012919261);

// Tree: 600
final_score_600 := map(
(nf_fp_addrchangeecontraj in ['AF','BF','BU','CA','CF','CU','DC','EA','EC','ED','FC','UE','UF']) => -0.0471657219, 
(nf_fp_addrchangeecontraj in ['-1','AA','AB','AC','AD','AE','AU','BA','BB','BC','BD','BE','CB','CC','CD','CE','DA','DB','DD','DE','DF','DU','EB','EE','EF','EU','FA','FB','FD','FE','FF','FU','UC','UD','UU']) => map(
   ( NULL < rv_comb_age and rv_comb_age <= 69.5) => -0.0001039380, 
   (rv_comb_age > 69.5) => map(
      ( NULL < nf_fp_srchfraudsrchcountday and nf_fp_srchfraudsrchcountday <= 0.5) => 0.0262511772, 
      (nf_fp_srchfraudsrchcountday > 0.5) => 0.1319192787, 0.0312191551), 0.0004424353), -0.0000949319);

// Tree: 601
final_score_601 := map(
( NULL < nf_hh_tot_derog and nf_hh_tot_derog <= 12.5) => map(
   ( NULL < nf_inq_per_phone and nf_inq_per_phone <= 30.5) => -0.0002903546, 
   (nf_inq_per_phone > 30.5) => map(
      ( NULL < nf_fp_prevaddrageoldest and nf_fp_prevaddrageoldest <= 154.5) => 0.0090518356, 
      (nf_fp_prevaddrageoldest > 154.5) => 0.1530035976, 0.0526486549), -0.1038593994), 
(nf_hh_tot_derog > 12.5) => -0.0622932899, -0.0004696583);

// Tree: 602
final_score_602 := map(
( NULL < rv_comb_age and rv_comb_age <= 39.5) => map(
   ( NULL < nf_fp_curraddrcartheftindex and nf_fp_curraddrcartheftindex <= 199.5) => 0.0031727606, 
   (nf_fp_curraddrcartheftindex > 199.5) => 0.1162958950, 0.0033624907), 
(rv_comb_age > 39.5) => map(
   ( NULL < nf_inq_per_sfd_addr and nf_inq_per_sfd_addr <= 22.5) => -0.0046122024, 
   (nf_inq_per_sfd_addr > 22.5) => -0.0389617914, -0.0054336077), -0.0007757177);

// Tree: 603
final_score_603 := map(
( NULL < rv_I60_inq_hiRiskCred_count12 and rv_I60_inq_hiRiskCred_count12 <= 17.5) => -0.0002087230, 
(rv_I60_inq_hiRiskCred_count12 > 17.5) => map(
   ( NULL < nf_inq_count_week and nf_inq_count_week <= 0.5) => map(
      (iv_college_major in ['BUSINESS','NO AMS FOUND','UNCLASSIFIED']) => -0.0348653993, 
      (iv_college_major in ['LIBERAL ARTS','MEDICAL','NO COLLEGE FOUND','SCIENCE']) => 0.0772685490, -0.0160624506), 
   (nf_inq_count_week > 0.5) => -0.1018750969, -0.0327189594), -0.0003790257);

// Tree: 604
final_score_604 := map(
( NULL < nf_inq_per_addr and nf_inq_per_addr <= 3.5) => map(
   ( NULL < nf_hh_bankruptcies_pct and nf_hh_bankruptcies_pct <= 0.2264957265) => map(
      (nf_fp_addrchangeecontraj in ['-1','AA','AB','AC','AD','AE','AF','BB','BE','BF','BU','CA','CB','CC','CD','CE','CF','CU','DA','DB','DC','DD','DE','DU','EA','EB','EC','ED','EE','EF','EU','FA','FB','FC','FD','FE','FF','FU','UC','UE','UU']) => -0.0002567759, 
      (nf_fp_addrchangeecontraj in ['AU','BA','BC','BD','DF','UD','UF']) => 0.0750912244, 0.0002771108), 
   (nf_hh_bankruptcies_pct > 0.2264957265) => -0.0184263911, -0.0054057764), 
(nf_inq_per_addr > 3.5) => 0.0035833429, -0.0012492271);

// Tree: 605
final_score_605 := map(
( NULL < rv_I60_Inq_Count12 and rv_I60_Inq_Count12 <= 4.5) => 0.0014690638, 
(rv_I60_Inq_Count12 > 4.5) => map(
   ( NULL < rv_P88_Phn_Dst_to_Inp_Add and rv_P88_Phn_Dst_to_Inp_Add <= 12.5) => -0.0004312907, 
   (rv_P88_Phn_Dst_to_Inp_Add > 12.5) => -0.0260955700, map(
      ( NULL < nf_fp_srchphonesrchcountwk and nf_fp_srchphonesrchcountwk <= 0.5) => -0.0063517445, 
      (nf_fp_srchphonesrchcountwk > 0.5) => -0.0349189743, -0.0124208046)), -0.0001872464);

// Tree: 606
final_score_606 := map(
( NULL < nf_fp_srchaddrsrchcountmo and nf_fp_srchaddrsrchcountmo <= 0.5) => -0.0027776975, 
(nf_fp_srchaddrsrchcountmo > 0.5) => map(
   ( NULL < nf_liens_unrel_FC_total_amt and nf_liens_unrel_FC_total_amt <= 1796.5) => 0.0042115773, 
   (nf_liens_unrel_FC_total_amt > 1796.5) => map(
      ( NULL < nf_mos_acc_lseen and nf_mos_acc_lseen <= 4.5) => 0.1269946671, 
      (nf_mos_acc_lseen > 4.5) => -0.0476724487, 0.0757991332), 0.0046983581), -0.0003155390);

// Tree: 607
final_score_607 := map(
( NULL < rv_I60_inq_comm_count12 and rv_I60_inq_comm_count12 <= 0.5) => 0.0008500074, 
(rv_I60_inq_comm_count12 > 0.5) => map(
   ( NULL < nf_fp_varrisktype and nf_fp_varrisktype <= 6.5) => -0.0072674138, 
   (nf_fp_varrisktype > 6.5) => map(
      ( NULL < rv_C14_addrs_10yr and rv_C14_addrs_10yr <= 8.5) => -0.0263388890, 
      (rv_C14_addrs_10yr > 8.5) => -0.1217404086, -0.0377390706), -0.0105678181), -0.0000129687);

// Tree: 608
final_score_608 := map(
( NULL < nf_liens_unrel_ST_total_amt and nf_liens_unrel_ST_total_amt <= 836) => -0.0011938433, 
(nf_liens_unrel_ST_total_amt > 836) => map(
   ( NULL < nf_hh_members_ct and nf_hh_members_ct <= 6.5) => map(
      (iv_college_file_type in ['-1','C']) => 0.0289085034, 
      (iv_college_file_type in ['A','H']) => 0.1722091969, 0.0095792901), 
   (nf_hh_members_ct > 6.5) => -0.0483097377, 0.0211580136), -0.0006737048);

// Tree: 609
final_score_609 := map(
( NULL < nf_fp_srchaddrsrchcountday and nf_fp_srchaddrsrchcountday <= 2.5) => 0.0000429792, 
(nf_fp_srchaddrsrchcountday > 2.5) => map(
   ( NULL < nf_add_input_mobility_index and nf_add_input_mobility_index <= 0.3624860564) => map(
      (nf_fp_addrchangeecontraj in ['AA','BB','DC','DD','DF','EE','EF']) => -0.0003144710, 
      (nf_fp_addrchangeecontraj in ['-1','AB','AC','AD','AE','AF','AU','BA','BC','BD','BE','BF','BU','CA','CB','CC','CD','CE','CF','CU','DA','DB','DE','DU','EA','EB','EC','ED','EU','FA','FB','FC','FD','FE','FF','FU','UC','UD','UE','UF','UU']) => 0.0957725887, 0.0559891745), 
   (nf_add_input_mobility_index > 0.3624860564) => -0.0302670195, 0.0307330185), 0.0002021690);

// Tree: 610
final_score_610 := map(
( NULL < rv_I60_inq_comm_count12 and rv_I60_inq_comm_count12 <= 3.5) => -0.0008592894, 
(rv_I60_inq_comm_count12 > 3.5) => map(
   ( NULL < nf_hh_members_w_derog_pct and nf_hh_members_w_derog_pct <= 0.3875) => map(
      ( NULL < nf_fp_prevaddrlenofres and nf_fp_prevaddrlenofres <= 24.5) => 0.1468645349, 
      (nf_fp_prevaddrlenofres > 24.5) => 0.0455375597, 0.0804316174), 
   (nf_hh_members_w_derog_pct > 0.3875) => -0.0044734067, 0.0260519710), -0.0007138007);

// Tree: 611
final_score_611 := map(
( NULL < nf_pct_rel_with_felony and nf_pct_rel_with_felony <= 0.33908045975) => 0.0006705695, 
(nf_pct_rel_with_felony > 0.33908045975) => map(
   (nf_historic_x_current_ct in ['0-0','1-1','2-0','2-2','3-0','3-2','3-3']) => map(
      ( NULL < nf_fp_srchfraudsrchcountmo and nf_fp_srchfraudsrchcountmo <= 1.5) => -0.0381689578, 
      (nf_fp_srchfraudsrchcountmo > 1.5) => -0.1052998875, -0.0574380209), 
   (nf_historic_x_current_ct in ['1-0','2-1','3-1']) => 0.0817707055, -0.0332895684), 0.0004992324);

// Tree: 612
final_score_612 := map(
( NULL < rv_C10_M_Hdr_FS and rv_C10_M_Hdr_FS <= 15.5) => map(
   (nf_fp_addrchangeecontraj in ['AA','CC','DD','EE','FB']) => -0.0024357167, 
   (nf_fp_addrchangeecontraj in ['-1','AB','AC','AD','AE','AF','AU','BA','BB','BC','BD','BE','BF','BU','CA','CB','CD','CE','CF','CU','DA','DB','DC','DE','DF','DU','EA','EB','EC','ED','EF','EU','FA','FC','FD','FE','FF','FU','UC','UD','UE','UF','UU']) => 0.1239957537, 0.0602899740), 
(rv_C10_M_Hdr_FS > 15.5) => map(
   ( NULL < nf_liens_unrel_ST_total_amt and nf_liens_unrel_ST_total_amt <= 17415.5) => -0.0015374596, 
   (nf_liens_unrel_ST_total_amt > 17415.5) => -0.1058190904, -0.0016302296), -0.0015274158);

// Tree: 613
final_score_613 := map(
( NULL < rv_mos_since_br_first_seen and rv_mos_since_br_first_seen <= 314.5) => 0.0007585084, 
(rv_mos_since_br_first_seen > 314.5) => map(
   (nf_fp_addrchangeecontraj in ['-1','AA','CF','DA','DD','DE','EC','ED','EE','FF']) => map(
      ( NULL < nf_add_curr_nhood_VAC_pct and nf_add_curr_nhood_VAC_pct <= 0.0047157612) => 0.1706704950, 
      (nf_add_curr_nhood_VAC_pct > 0.0047157612) => -0.0176651169, 0.0216279244), 
   (nf_fp_addrchangeecontraj in ['AB','AC','AD','AE','AF','AU','BA','BB','BC','BD','BE','BF','BU','CA','CB','CC','CD','CE','CU','DB','DC','DF','DU','EA','EB','EF','EU','FA','FB','FC','FD','FE','FU','UC','UD','UE','UF','UU']) => 0.2544581591, 0.0673864677), 0.0010552272);

// Tree: 614
final_score_614 := map(
( NULL < rv_I62_inq_phones_per_adl and rv_I62_inq_phones_per_adl <= 4.5) => 0.0003990644, 
(rv_I62_inq_phones_per_adl > 4.5) => map(
   ( NULL < iv_inp_add_avm_pct_chg_3yr and iv_inp_add_avm_pct_chg_3yr <= 1.20480881315) => 0.1253597252, 
   (iv_inp_add_avm_pct_chg_3yr > 1.20480881315) => -0.0047178702, map(
      (nf_historic_x_current_ct in ['0-0','3-1','3-2','3-3']) => 0.0059750754, 
      (nf_historic_x_current_ct in ['1-0','1-1','2-0','2-1','2-2','3-0']) => 0.0836765591, 0.0206703915)), 0.0005873024);

// Tree: 615
final_score_615 := map(
( NULL < rv_C13_Curr_Addr_LRes and rv_C13_Curr_Addr_LRes <= 5.5) => map(
   ( NULL < nf_fp_curraddrburglaryindex and nf_fp_curraddrburglaryindex <= 7) => map(
      (nf_fp_addrchangeecontraj in ['-1','AB','AE','BB','CD','DB','DF','EC','ED','EE','FD']) => 0.0054012464, 
      (nf_fp_addrchangeecontraj in ['AA','AC','AD','AF','AU','BA','BC','BD','BE','BF','BU','CA','CB','CC','CE','CF','CU','DA','DC','DD','DE','DU','EA','EB','EF','EU','FA','FB','FC','FE','FF','FU','UC','UD','UE','UF','UU']) => 0.1561259440, 0.0574841262), 
   (nf_fp_curraddrburglaryindex > 7) => -0.0167244655, -0.0144551986), 
(rv_C13_Curr_Addr_LRes > 5.5) => 0.0012466503, -0.0000156250);

// Tree: 616
final_score_616 := map(
( NULL < nf_liens_unrel_ST_ct and nf_liens_unrel_ST_ct <= 2.5) => -0.0002462606, 
(nf_liens_unrel_ST_ct > 2.5) => map(
   ( NULL < nf_pct_rel_with_criminal and nf_pct_rel_with_criminal <= 0.0606617647) => 0.1021340038, 
   (nf_pct_rel_with_criminal > 0.0606617647) => map(
      ( NULL < nf_fp_srchunvrfdphonecount and nf_fp_srchunvrfdphonecount <= 1.5) => -0.0240107454, 
      (nf_fp_srchunvrfdphonecount > 1.5) => -0.0769495464, -0.0434386066), -0.0280054072), -0.0004956606);

// Tree: 617
final_score_617 := map(
( NULL < nf_phones_per_addr_curr and nf_phones_per_addr_curr <= 95.5) => map(
   ( NULL < nf_util_adl_count and nf_util_adl_count <= 16.5) => -0.0001078621, 
   (nf_util_adl_count > 16.5) => map(
      ( NULL < rv_C14_addrs_10yr and rv_C14_addrs_10yr <= 10.5) => 0.0262810529, 
      (rv_C14_addrs_10yr > 10.5) => -0.0672485467, 0.0195404829), 0.0005989148), 
(nf_phones_per_addr_curr > 95.5) => -0.0857190962, 0.0004355936);

// Tree: 618
final_score_618 := map(
( NULL < nf_inq_HighRiskCredit_count_week and nf_inq_HighRiskCredit_count_week <= 0.5) => 0.0004687200, 
(nf_inq_HighRiskCredit_count_week > 0.5) => map(
   ( NULL < rv_I60_inq_PrepaidCards_recency and rv_I60_inq_PrepaidCards_recency <= 2) => -0.0033399256, 
   (rv_I60_inq_PrepaidCards_recency > 2) => map(
      (iv_D34_liens_unrel_x_rel in ['0-1','0-2','3-0','3-1']) => -0.1000008240, 
      (iv_D34_liens_unrel_x_rel in ['0-0','1-0','1-1','1-2','2-0','2-1','2-2','3-2']) => -0.0180224838, -0.0256500337), -0.0064351873), -0.0002678141);

// Tree: 619
final_score_619 := map(
( NULL < rv_D33_Eviction_Recency and rv_D33_Eviction_Recency <= 1.5) => -0.0029649226, 
(rv_D33_Eviction_Recency > 1.5) => map(
   (nf_fp_addrchangeecontraj in ['AA','AB','AC','AD','AE','BD','BE','BF','CB','CD','CF','DB','DF','DU','EB','EC','ED','EF','FB','FC','FD','UE','UU']) => -0.0439838685, 
   (nf_fp_addrchangeecontraj in ['-1','AF','AU','BA','BB','BC','BU','CA','CC','CE','CU','DA','DC','DD','DE','EA','EE','EU','FA','FE','FF','FU','UC','UD','UF']) => map(
      ( NULL < iv_unverified_addr_count and iv_unverified_addr_count <= 19.5) => 0.0091522658, 
      (iv_unverified_addr_count > 19.5) => 0.1273379407, 0.0098266491), 0.0075602146), -0.0012796165);

// Tree: 620
final_score_620 := map(
( NULL < rv_C13_max_lres and rv_C13_max_lres <= 322.5) => -0.0014364373, 
(rv_C13_max_lres > 322.5) => map(
   ( NULL < rv_I60_inq_hiRiskCred_recency and rv_I60_inq_hiRiskCred_recency <= 0.5) => map(
      ( NULL < nf_hh_tot_derog and nf_hh_tot_derog <= 1.5) => 0.2846619742, 
      (nf_hh_tot_derog > 1.5) => 0.0125894156, 0.0885820958), 
   (rv_I60_inq_hiRiskCred_recency > 0.5) => 0.0130838200, 0.0188561637), -0.0004457835);

// Tree: 621
final_score_621 := map(
( NULL < nf_inq_per_sfd_addr and nf_inq_per_sfd_addr <= 21.5) => 0.0008733628, 
(nf_inq_per_sfd_addr > 21.5) => map(
   ( NULL < nf_inq_Other_count24 and nf_inq_Other_count24 <= 0.5) => 0.0838562216, 
   (nf_inq_Other_count24 > 0.5) => map(
      ( NULL < rv_A49_curr_add_avm_chg_3yr and rv_A49_curr_add_avm_chg_3yr <= 31697.5) => -0.0432328629, 
      (rv_A49_curr_add_avm_chg_3yr > 31697.5) => 0.0171467103, -0.0328374592), -0.0176379958), 0.0004371034);

// Tree: 622
final_score_622 := map(
( NULL < rv_C13_max_lres and rv_C13_max_lres <= 56.5) => -0.0085320718, 
(rv_C13_max_lres > 56.5) => map(
   ( NULL < nf_M_Bureau_ADL_FS_all and nf_M_Bureau_ADL_FS_all <= 38.5) => map(
      ( NULL < iv_C13_avg_lres and iv_C13_avg_lres <= 40.5) => 0.1242262703, 
      (iv_C13_avg_lres > 40.5) => 0.0071261779, 0.0540717104), 
   (nf_M_Bureau_ADL_FS_all > 38.5) => 0.0014324945, 0.0016098869), 0.0000674194);

// Tree: 623
final_score_623 := map(
( NULL < nf_Number_Bureau_Sources and nf_Number_Bureau_Sources <= 1.5) => -0.0921991619, 
(nf_Number_Bureau_Sources > 1.5) => map(
   ( NULL < nf_add_curr_nhood_VAC_pct and nf_add_curr_nhood_VAC_pct <= 0.10465591665) => 0.0014717821, 
   (nf_add_curr_nhood_VAC_pct > 0.10465591665) => map(
      ( NULL < nf_phones_per_sfd_addr_curr and nf_phones_per_sfd_addr_curr <= 8.5) => -0.0032280074, 
      (nf_phones_per_sfd_addr_curr > 8.5) => -0.0389198994, -0.0087431926), 0.0002433374), 0.0001576720);

// Tree: 624
final_score_624 := map(
( NULL < nf_fp_srchfraudsrchcountday and nf_fp_srchfraudsrchcountday <= 4.5) => map(
   ( NULL < nf_add_curr_nhood_MFD_pct and nf_add_curr_nhood_MFD_pct <= 0.98999198735) => -0.0007681829, 
   (nf_add_curr_nhood_MFD_pct > 0.98999198735) => -0.0502991170, -0.0010439825), 
(nf_fp_srchfraudsrchcountday > 4.5) => map(
   ( NULL < nf_fp_srchaddrsrchcountmo and nf_fp_srchaddrsrchcountmo <= 5.5) => 0.1162604251, 
   (nf_fp_srchaddrsrchcountmo > 5.5) => -0.0360091162, 0.0481398408), -0.0009718182);

// Tree: 625
final_score_625 := map(
( NULL < nf_inq_HighRiskCredit_count_week and nf_inq_HighRiskCredit_count_week <= 2.5) => 0.0004756467, 
(nf_inq_HighRiskCredit_count_week > 2.5) => map(
   ( NULL < rv_A49_curr_add_avm_pct_chg_2yr and rv_A49_curr_add_avm_pct_chg_2yr <= 1.48801253165) => map(
      ( NULL < nf_add_input_mobility_index and nf_add_input_mobility_index <= 0.35346267855) => 0.0145468175, 
      (nf_add_input_mobility_index > 0.35346267855) => -0.0538127134, -0.0032568933), 
   (rv_A49_curr_add_avm_pct_chg_2yr > 1.48801253165) => 0.0793341726, 0.0161352989), 0.0007194736);

// Tree: 626
final_score_626 := map(
( NULL < nf_mos_liens_unrel_ST_lseen and nf_mos_liens_unrel_ST_lseen <= 151.5) => -0.0003523226, 
(nf_mos_liens_unrel_ST_lseen > 151.5) => map(
   ( NULL < nf_hh_property_owners_ct and nf_hh_property_owners_ct <= 2.5) => map(
      ( NULL < nf_pct_rel_with_criminal and nf_pct_rel_with_criminal <= 0.47142857145) => 0.0048359760, 
      (nf_pct_rel_with_criminal > 0.47142857145) => 0.1094611111, 0.0237489812), 
   (nf_hh_property_owners_ct > 2.5) => 0.1450878235, 0.0393990496), -0.0000468852);

// Tree: 627
final_score_627 := map(
(nf_fp_addrchangeecontraj in ['AC','AF','BA','BD','BF','CA','CB','CD','DA','DF','DU','EB','EF','FA','FB','FC','FU','UC','UD','UE','UU']) => -0.0349686619, 
(nf_fp_addrchangeecontraj in ['-1','AA','AB','AD','AE','AU','BB','BC','BE','BU','CC','CE','CF','CU','DB','DC','DD','DE','EA','EC','ED','EE','EU','FD','FE','FF','UF']) => map(
   ( NULL < nf_pct_rel_with_felony and nf_pct_rel_with_felony <= 0.2076149425) => 0.0002338193, 
   (nf_pct_rel_with_felony > 0.2076149425) => map(
      (iv_college_code_x_type in ['-1','2-U','4-S']) => 0.0097027126, 
      (iv_college_code_x_type in ['1-P','1-R','1-S','2-P','2-R','2-S','4-P','4-R']) => 0.0969194381, 0.0185999893), 0.0007707014), 0.0002003214);

// Tree: 628
final_score_628 := map(
( NULL < nf_fp_srchssnsrchcountday and nf_fp_srchssnsrchcountday <= 1.5) => 0.0004106413, 
(nf_fp_srchssnsrchcountday > 1.5) => map(
   (nf_historic_x_current_ct in ['0-0','1-0','1-1','2-2','3-1','3-2','3-3']) => map(
      ( NULL < nf_fp_curraddrcrimeindex and nf_fp_curraddrcrimeindex <= 168.5) => 0.0015770409, 
      (nf_fp_curraddrcrimeindex > 168.5) => 0.0776083670, 0.0093889397), 
   (nf_historic_x_current_ct in ['2-0','2-1','3-0']) => 0.0868473465, 0.0160944814), 0.0006601551);

// Tree: 629
final_score_629 := map(
( NULL < rv_C10_M_Hdr_FS and rv_C10_M_Hdr_FS <= 29.5) => map(
   ( NULL < rv_C20_M_Bureau_ADL_FS and rv_C20_M_Bureau_ADL_FS <= 20.5) => map(
      ( NULL < iv_prv_addr_avm_auto_val and iv_prv_addr_avm_auto_val <= 41683.5) => -0.0441488644, 
      (iv_prv_addr_avm_auto_val > 41683.5) => 0.0935875728, -0.0173079519), 
   (rv_C20_M_Bureau_ADL_FS > 20.5) => -0.0743922619, -0.0310826315), 
(rv_C10_M_Hdr_FS > 29.5) => 0.0000130763, -0.0002070632);

// Tree: 630
final_score_630 := map(
( NULL < nf_fp_srchssnsrchcountmo and nf_fp_srchssnsrchcountmo <= 13.5) => map(
   ( NULL < rv_I60_inq_auto_count12 and rv_I60_inq_auto_count12 <= 1.5) => 0.0014088052, 
   (rv_I60_inq_auto_count12 > 1.5) => map(
      ( NULL < rv_C12_source_profile and rv_C12_source_profile <= 15.05) => -0.0595469365, 
      (rv_C12_source_profile > 15.05) => -0.0081009353, -0.0093459888), -0.0000564731), 
(nf_fp_srchssnsrchcountmo > 13.5) => -0.0769316188, -0.0001089152);

// Tree: 631
final_score_631 := map(
( NULL < rv_D33_eviction_count and rv_D33_eviction_count <= 2.5) => -0.0022146764, 
(rv_D33_eviction_count > 2.5) => map(
   ( NULL < nf_fp_componentcharrisktype and nf_fp_componentcharrisktype <= 7.5) => map(
      ( NULL < nf_rel_criminal_count and nf_rel_criminal_count <= 10.5) => 0.0163297329, 
      (nf_rel_criminal_count > 10.5) => -0.0358244747, 0.0101894624), 
   (nf_fp_componentcharrisktype > 7.5) => 0.1023298774, 0.0130582554), -0.0015202021);

// Tree: 632
final_score_632 := map(
( NULL < nf_inq_Other_count24 and nf_inq_Other_count24 <= 10.5) => -0.0017103360, 
(nf_inq_Other_count24 > 10.5) => map(
   ( NULL < rv_C12_source_profile and rv_C12_source_profile <= 33.45) => 0.0826984736, 
   (rv_C12_source_profile > 33.45) => map(
      ( NULL < nf_fp_srchaddrsrchcountmo and nf_fp_srchaddrsrchcountmo <= 8.5) => 0.0119964002, 
      (nf_fp_srchaddrsrchcountmo > 8.5) => -0.0821927247, 0.0083292823), 0.0154960266), -0.0011312246);

// Tree: 633
final_score_633 := map(
( NULL < nf_fp_srchfraudsrchcountyr and nf_fp_srchfraudsrchcountyr <= 41.5) => map(
   ( NULL < iv_inp_add_avm_pct_chg_2yr and iv_inp_add_avm_pct_chg_2yr <= 0.71260066715) => -0.0297265819, 
   (iv_inp_add_avm_pct_chg_2yr > 0.71260066715) => map(
      ( NULL < iv_fname_non_phn_src_ct and iv_fname_non_phn_src_ct <= 8.5) => 0.0066998793, 
      (iv_fname_non_phn_src_ct > 8.5) => -0.0078649509, -0.0022463068), 0.0013034343), 
(nf_fp_srchfraudsrchcountyr > 41.5) => 0.0741244677, -0.0006529241);

// Tree: 634
final_score_634 := map(
( NULL < nf_historical_count and nf_historical_count <= 23.5) => -0.0002058944, 
(nf_historical_count > 23.5) => map(
   ( NULL < nf_liens_unrel_OT_total_amt and nf_liens_unrel_OT_total_amt <= 55.5) => map(
      ( NULL < iv_prv_addr_lres and iv_prv_addr_lres <= 53.5) => -0.0803303656, 
      (iv_prv_addr_lres > 53.5) => 0.0874165002, 0.0285579508), 
   (nf_liens_unrel_OT_total_amt > 55.5) => 0.1763319047, 0.0619909721), -0.0000289782);

// Tree: 635
final_score_635 := map(
(iv_college_file_type in ['H']) => -0.0179391693, 
(iv_college_file_type in ['-1','A','C']) => -0.0005913047, map(
   ( NULL < iv_unverified_addr_count and iv_unverified_addr_count <= 15.5) => map(
      ( NULL < nf_add_input_mobility_index and nf_add_input_mobility_index <= 0.2095737365) => -0.0322214313, 
      (nf_add_input_mobility_index > 0.2095737365) => 0.0084696864, 0.0044541848), 
   (iv_unverified_addr_count > 15.5) => 0.1390571887, 0.0050081778));

// Tree: 636
final_score_636 := map(
( NULL < rv_I60_inq_other_count12 and rv_I60_inq_other_count12 <= 0.5) => 0.0055515677, 
(rv_I60_inq_other_count12 > 0.5) => map(
   ( NULL < nf_M_Bureau_ADL_FS_noTU and nf_M_Bureau_ADL_FS_noTU <= 129.5) => -0.0115452337, 
   (nf_M_Bureau_ADL_FS_noTU > 129.5) => map(
      ( NULL < nf_fp_srchfraudsrchcountyr and nf_fp_srchfraudsrchcountyr <= 3.5) => -0.0131088317, 
      (nf_fp_srchfraudsrchcountyr > 3.5) => 0.0051733355, -0.0030293401), -0.0049345768), -0.0016427180);

// Tree: 637
final_score_637 := map(
( NULL < nf_inq_Other_count_week and nf_inq_Other_count_week <= 2.5) => 0.0017542676, 
(nf_inq_Other_count_week > 2.5) => map(
   ( NULL < nf_fp_varrisktype and nf_fp_varrisktype <= 3.5) => map(
      ( NULL < rv_A41_Prop_Owner and rv_A41_Prop_Owner <= 0.5) => -0.0870488707, 
      (rv_A41_Prop_Owner > 0.5) => 0.0431882802, -0.0067769161), 
   (nf_fp_varrisktype > 3.5) => 0.0752303814, 0.0335717223), 0.0018824531);

// Tree: 638
final_score_638 := map(
( NULL < nf_fp_prevaddrmurderindex and nf_fp_prevaddrmurderindex <= 24.5) => 0.0127587591, 
(nf_fp_prevaddrmurderindex > 24.5) => map(
   ( NULL < nf_average_rel_distance and nf_average_rel_distance <= 196.5) => 0.0041297267, 
   (nf_average_rel_distance > 196.5) => map(
      (nf_historic_x_current_ct in ['0-0','1-0','1-1','2-1','2-2','3-3']) => -0.0100225409, 
      (nf_historic_x_current_ct in ['2-0','3-0','3-1','3-2']) => 0.0093478828, -0.0058265758), -0.0001979034), 0.0016622206);

// Tree: 639
final_score_639 := map(
( NULL < iv_unverified_addr_count and iv_unverified_addr_count <= 7.5) => -0.0009299217, 
(iv_unverified_addr_count > 7.5) => map(
   ( NULL < rv_comb_age and rv_comb_age <= 31.5) => map(
      ( NULL < nf_add_curr_nhood_BUS_pct and nf_add_curr_nhood_BUS_pct <= 0.00394706605) => 0.2231307464, 
      (nf_add_curr_nhood_BUS_pct > 0.00394706605) => 0.0347336957, 0.0585164917), 
   (rv_comb_age > 31.5) => 0.0075532821, 0.0092143661), 0.0006884587);

// Tree: 640
final_score_640 := map(
( NULL < nf_fp_srchcomponentrisktype and nf_fp_srchcomponentrisktype <= 4.5) => 0.0019649557, 
(nf_fp_srchcomponentrisktype > 4.5) => map(
   ( NULL < rv_C12_source_profile and rv_C12_source_profile <= 37.9) => -0.0217470904, 
   (rv_C12_source_profile > 37.9) => map(
      ( NULL < nf_fp_idrisktype and nf_fp_idrisktype <= 3) => -0.0050089828, 
      (nf_fp_idrisktype > 3) => 0.0698892126, -0.0033083785), -0.0071909450), 0.0007157434);

// Tree: 641
final_score_641 := map(
(iv_inp_addr_financing_type in ['ADJ','NONE','OTH']) => -0.0006887043, 
(iv_inp_addr_financing_type in ['CNV']) => map(
   ( NULL < nf_rel_bankrupt_count and nf_rel_bankrupt_count <= 3.5) => map(
      ( NULL < nf_hh_workers_paw_pct and nf_hh_workers_paw_pct <= 0.48333333335) => 0.0760025493, 
      (nf_hh_workers_paw_pct > 0.48333333335) => -0.0196675213, 0.0465361675), 
   (nf_rel_bankrupt_count > 3.5) => -0.0317294630, 0.0242545360), -0.0002397221);

// Tree: 642
final_score_642 := map(
( NULL < nf_fp_srchaddrsrchcountwk and nf_fp_srchaddrsrchcountwk <= 4.5) => 0.0005502599, 
(nf_fp_srchaddrsrchcountwk > 4.5) => map(
   ( NULL < nf_add_curr_nhood_MFD_pct and nf_add_curr_nhood_MFD_pct <= 0.47341645655) => map(
      ( NULL < nf_fp_curraddrcartheftindex and nf_fp_curraddrcartheftindex <= 147) => 0.0205282384, 
      (nf_fp_curraddrcartheftindex > 147) => 0.1098979693, 0.0379238065), 
   (nf_add_curr_nhood_MFD_pct > 0.47341645655) => -0.0728934473, 0.0225906016), 0.0006855724);

// Tree: 643
final_score_643 := map(
( NULL < rv_L79_adls_per_sfd_addr and rv_L79_adls_per_sfd_addr <= 21.5) => map(
   ( NULL < rv_I60_inq_auto_recency and rv_I60_inq_auto_recency <= 61.5) => map(
      ( NULL < nf_fp_curraddrmedianvalue and nf_fp_curraddrmedianvalue <= 34860.5) => -0.0230292401, 
      (nf_fp_curraddrmedianvalue > 34860.5) => 0.0034637136, 0.0027628465), 
   (rv_I60_inq_auto_recency > 61.5) => -0.0078216164, 0.0003833534), 
(rv_L79_adls_per_sfd_addr > 21.5) => 0.1154035990, 0.0004647748);

// Tree: 644
final_score_644 := map(
( NULL < nf_util_adl_count and nf_util_adl_count <= 29.5) => map(
   ( NULL < nf_fp_addrchangecrimediff and nf_fp_addrchangecrimediff <= -121.5) => -0.0857852522, 
   (nf_fp_addrchangecrimediff > -121.5) => map(
      ( NULL < rv_D32_Mos_Since_Fel_LS and rv_D32_Mos_Since_Fel_LS <= 111.5) => 0.0004707142, 
      (rv_D32_Mos_Since_Fel_LS > 111.5) => -0.0279267241, 0.0002172312), 0.0000008239), 
(nf_util_adl_count > 29.5) => -0.0718743580, -0.0001823494);

// Tree: 645
final_score_645 := map(
( NULL < rv_C16_Inv_SSN_Per_ADL and rv_C16_Inv_SSN_Per_ADL <= 0.5) => map(
   ( NULL < rv_C12_source_profile and rv_C12_source_profile <= 0.05) => map(
      (iv_full_name_ver_sources in ['PHN & NONPHN','PHN ONLY']) => -0.0021450044, 
      (iv_full_name_ver_sources in ['NAME NOT VERD','NONPHN ONLY']) => 0.0488074817, 0.0228842870), 
   (rv_C12_source_profile > 0.05) => -0.0007301857, -0.0005032852), 
(rv_C16_Inv_SSN_Per_ADL > 0.5) => -0.0450165329, -0.0007731354);

// Tree: 646
final_score_646 := map(
( NULL < nf_current_count and nf_current_count <= 7.5) => 0.0004908023, 
(nf_current_count > 7.5) => map(
   ( NULL < nf_inq_HighRiskCredit_count_week and nf_inq_HighRiskCredit_count_week <= 1.5) => map(
      ( NULL < iv_src_drivers_lic_adl_count and iv_src_drivers_lic_adl_count <= 6.5) => -0.0051218560, 
      (iv_src_drivers_lic_adl_count > 6.5) => -0.0917281279, -0.0191849323), 
   (nf_inq_HighRiskCredit_count_week > 1.5) => -0.0910582783, -0.0225969901), 0.0001027022);

// Tree: 647
final_score_647 := map(
( NULL < nf_inq_HighRiskCredit_count_week and nf_inq_HighRiskCredit_count_week <= 5.5) => map(
   ( NULL < nf_pct_rel_with_felony and nf_pct_rel_with_felony <= 0.5393939394) => 0.0012506457, 
   (nf_pct_rel_with_felony > 0.5393939394) => 0.1042432472, 0.0013210267), 
(nf_inq_HighRiskCredit_count_week > 5.5) => map(
   ( NULL < nf_hh_lienholders and nf_hh_lienholders <= 0.5) => -0.0981228384, 
   (nf_hh_lienholders > 0.5) => 0.0022181386, -0.0385218069), 0.0012528194);

// Tree: 648
final_score_648 := map(
( NULL < nf_inq_Communications_count24 and nf_inq_Communications_count24 <= 2.5) => 0.0004704582, 
(nf_inq_Communications_count24 > 2.5) => map(
   ( NULL < nf_average_rel_income and nf_average_rel_income <= 36500) => 0.1561793740, 
   (nf_average_rel_income > 36500) => map(
      ( NULL < rv_I62_inq_phones_per_adl and rv_I62_inq_phones_per_adl <= 4.5) => 0.0199189839, 
      (rv_I62_inq_phones_per_adl > 4.5) => -0.0661916897, 0.0161271161), 0.0200310118), 0.0009762326);

// Tree: 649
final_score_649 := map(
( NULL < nf_fp_prevaddrageoldest and nf_fp_prevaddrageoldest <= 373.5) => map(
   ( NULL < nf_add_curr_mobility_index and nf_add_curr_mobility_index <= 0.9479400749) => -0.0008013496, 
   (nf_add_curr_mobility_index > 0.9479400749) => -0.0662689852, -0.0010496434), 
(nf_fp_prevaddrageoldest > 373.5) => map(
   ( NULL < rv_I60_inq_hiRiskCred_count12 and rv_I60_inq_hiRiskCred_count12 <= 7.5) => -0.0351122244, 
   (rv_I60_inq_hiRiskCred_count12 > 7.5) => -0.1056063482, -0.0428954873), -0.0015618238);

// Tree: 650
final_score_650 := map(
( NULL < rv_I62_inq_dobs_per_adl and rv_I62_inq_dobs_per_adl <= 1.5) => 0.0022115930, 
(rv_I62_inq_dobs_per_adl > 1.5) => map(
   ( NULL < nf_inq_adls_per_addr and nf_inq_adls_per_addr <= 0.5) => map(
      ( NULL < rv_C13_inp_addr_lres and rv_C13_inp_addr_lres <= 104.5) => -0.0012028507, 
      (rv_C13_inp_addr_lres > 104.5) => 0.0531139822, 0.0130430592), 
   (nf_inq_adls_per_addr > 0.5) => -0.0117141333, -0.0073855983), -0.0000211882);

// Tree: 651
final_score_651 := map(
( NULL < rv_C10_M_Hdr_FS and rv_C10_M_Hdr_FS <= 14.5) => 0.0635750174, 
(rv_C10_M_Hdr_FS > 14.5) => map(
   ( NULL < nf_add_curr_nhood_VAC_pct and nf_add_curr_nhood_VAC_pct <= 0.0854873105) => 0.0003360040, 
   (nf_add_curr_nhood_VAC_pct > 0.0854873105) => map(
      ( NULL < rv_L79_adls_per_apt_addr and rv_L79_adls_per_apt_addr <= 4.5) => -0.0133662492, 
      (rv_L79_adls_per_apt_addr > 4.5) => 0.0542076500, -0.0114792754), -0.0013927865), -0.0013108409);

// Tree: 652
final_score_652 := map(
(nf_fp_addrchangeecontraj in ['AC','AF','BU','CU','DA','DB','DU','EC','FA','UC','UE','UU']) => -0.0665177212, 
(nf_fp_addrchangeecontraj in ['-1','AA','AB','AD','AE','AU','BA','BB','BC','BD','BE','BF','CA','CB','CC','CD','CE','CF','DC','DD','DE','DF','EA','EB','ED','EE','EF','EU','FB','FC','FD','FE','FF','FU','UD','UF']) => map(
   (iv_college_file_type in ['A','H']) => map(
      ( NULL < nf_inq_per_apt_addr and nf_inq_per_apt_addr <= 12.5) => -0.0102357047, 
      (nf_inq_per_apt_addr > 12.5) => -0.1123143784, -0.0112571959), 
   (iv_college_file_type in ['-1','C']) => 0.0003266575, 0.0056269398), 0.0002278785);

// Tree: 653
final_score_653 := map(
( NULL < iv_inp_add_avm_pct_chg_1yr and iv_inp_add_avm_pct_chg_1yr <= 5.3978097374) => -0.0022813088, 
(iv_inp_add_avm_pct_chg_1yr > 5.3978097374) => 0.1180354876, map(
   ( NULL < nf_hh_collections_ct_avg and nf_hh_collections_ct_avg <= 0.32575757575) => map(
      ( NULL < nf_add_input_mobility_index and nf_add_input_mobility_index <= 0.47858240995) => -0.0023422218, 
      (nf_add_input_mobility_index > 0.47858240995) => -0.0380834523, -0.0076386531), 
   (nf_hh_collections_ct_avg > 0.32575757575) => 0.0055517225, 0.0029214329));

// Tree: 654
final_score_654 := map(
( NULL < nf_pct_rel_with_criminal and nf_pct_rel_with_criminal <= 0.6306042885) => 0.0013910684, 
(nf_pct_rel_with_criminal > 0.6306042885) => map(
   ( NULL < rv_C13_Curr_Addr_LRes and rv_C13_Curr_Addr_LRes <= 39.5) => map(
      ( NULL < nf_fp_curraddrmedianincome and nf_fp_curraddrmedianincome <= 26693.5) => 0.0465974238, 
      (nf_fp_curraddrmedianincome > 26693.5) => -0.0425361421, -0.0359533177), 
   (rv_C13_Curr_Addr_LRes > 39.5) => -0.0004178909, -0.0171727299), 0.0005402326);

// Tree: 655
final_score_655 := map(
( NULL < nf_inq_QuizProvider_count_week and nf_inq_QuizProvider_count_week <= 0.5) => map(
   ( NULL < rv_I60_inq_comm_recency and rv_I60_inq_comm_recency <= 18) => -0.0026088617, 
   (rv_I60_inq_comm_recency > 18) => 0.0061365226, -0.0003453147), 
(nf_inq_QuizProvider_count_week > 0.5) => map(
   ( NULL < nf_add_input_nhood_BUS_pct and nf_add_input_nhood_BUS_pct <= 0.04087301585) => -0.0063217179, 
   (nf_add_input_nhood_BUS_pct > 0.04087301585) => 0.1965101889, 0.0864463635), -0.0002012167);

// Tree: 656
final_score_656 := map(
( NULL < rv_A49_curr_add_avm_pct_chg_3yr and rv_A49_curr_add_avm_pct_chg_3yr <= 2.1188458434) => map(
   (nf_fp_addrchangeecontraj in ['-1','AA','AB','AC','BB','BC','BD','BE','BF','BU','CA','CB','CC','CD','CE','CF','CU','DA','DB','DD','DE','DF','DU','EA','EC','ED','EE','EF','FC','FD','FE','FF','UC','UD']) => -0.0023610899, 
   (nf_fp_addrchangeecontraj in ['AD','AE','AF','AU','BA','DC','EB','EU','FA','FB','FU','UE','UF','UU']) => 0.2244480895, -0.0018882920), 
(rv_A49_curr_add_avm_pct_chg_3yr > 2.1188458434) => map(
   ( NULL < nf_M_Bureau_ADL_FS_noTU and nf_M_Bureau_ADL_FS_noTU <= 105.5) => 0.0957162552, 
   (nf_M_Bureau_ADL_FS_noTU > 105.5) => 0.0174790682, 0.0259668796), 0.0009096223);

// Tree: 657
final_score_657 := map(
( NULL < rv_C20_M_Bureau_ADL_FS and rv_C20_M_Bureau_ADL_FS <= 354.5) => map(
   ( NULL < nf_historical_count and nf_historical_count <= 6.5) => -0.0004859058, 
   (nf_historical_count > 6.5) => 0.0118865256, 0.0014137595), 
(rv_C20_M_Bureau_ADL_FS > 354.5) => map(
   (nf_fp_addrchangeecontraj in ['-1','AA','AB','AC','AD','AF','BA','BB','BC','BD','BE','BF','CA','CC','CD','CF','DA','DC','DD','DE','DF','DU','EA','EB','EC','ED','EE','EF','EU','FC','FD','FF','UC']) => -0.0156494454, 
   (nf_fp_addrchangeecontraj in ['AE','AU','BU','CB','CE','CU','DB','FA','FB','FE','FU','UD','UE','UF','UU']) => 0.1776756091, -0.0143302909), -0.0005759033);

// Tree: 658
final_score_658 := map(
( NULL < iv_src_voter_adl_count and iv_src_voter_adl_count <= 5.5) => 0.0009865630, 
(iv_src_voter_adl_count > 5.5) => map(
   (iv_L77_dwelltype in ['POB']) => -0.1192292351, 
   (iv_L77_dwelltype in ['GEN','MFD','RR','SFD']) => map(
      ( NULL < rv_D32_attr_felonies_recency and rv_D32_attr_felonies_recency <= 48) => -0.0183302742, 
      (rv_D32_attr_felonies_recency > 48) => 0.0844088218, -0.0168434878), -0.0184498703), -0.0002255403);

// Tree: 659
final_score_659 := map(
( NULL < nf_inq_dobs_per_ssn and nf_inq_dobs_per_ssn <= 3.5) => map(
   ( NULL < iv_prv_addr_lres and iv_prv_addr_lres <= 61.5) => -0.0054195641, 
   (iv_prv_addr_lres > 61.5) => 0.0027250924, map(
      ( NULL < rv_I62_inq_phones_per_adl and rv_I62_inq_phones_per_adl <= 3.5) => -0.0059737851, 
      (rv_I62_inq_phones_per_adl > 3.5) => 0.0911434290, -0.0018149195)), 
(nf_inq_dobs_per_ssn > 3.5) => 0.0549857102, -0.0012226490);

// Tree: 660
final_score_660 := map(
( NULL < nf_fp_srchunvrfddobcount and nf_fp_srchunvrfddobcount <= 0.5) => map(
   ( NULL < nf_fp_srchphonesrchcountmo and nf_fp_srchphonesrchcountmo <= 10.5) => 0.0012876975, 
   (nf_fp_srchphonesrchcountmo > 10.5) => 0.0724599808, 0.0013586133), 
(nf_fp_srchunvrfddobcount > 0.5) => map(
   (nf_fp_addrchangeecontraj in ['-1','AA','AC','AD','AE','AF','BA','BB','BD','BE','CA','CB','CC','CD','CE','CF','CU','DC','DD','DE','DF','DU','EA','EB','EC','EE','EF','EU','FA','FB','FC','FD','FE','FF','FU','UC','UF','UU']) => -0.0075053478, 
   (nf_fp_addrchangeecontraj in ['AB','AU','BC','BF','BU','DA','DB','ED','UD','UE']) => 0.0856079723, -0.0068662356), -0.0004920306);

// Tree: 661
final_score_661 := map(
( NULL < rv_A49_Curr_AVM_Chg_1yr_Pct and rv_A49_Curr_AVM_Chg_1yr_Pct <= 175.35) => -0.0012487886, 
(rv_A49_Curr_AVM_Chg_1yr_Pct > 175.35) => -0.0315548209, map(
   ( NULL < nf_fp_srchfraudsrchcountwk and nf_fp_srchfraudsrchcountwk <= 3.5) => 0.0006175662, 
   (nf_fp_srchfraudsrchcountwk > 3.5) => map(
      ( NULL < nf_bus_phone_match and nf_bus_phone_match <= 1.5) => 0.0054041988, 
      (nf_bus_phone_match > 1.5) => 0.0658645221, 0.0194687279), 0.0009331658));

// Tree: 662
final_score_662 := map(
( NULL < nf_inq_Banking_count24 and nf_inq_Banking_count24 <= 0.5) => map(
   ( NULL < nf_inq_per_sfd_addr and nf_inq_per_sfd_addr <= 16.5) => -0.0028230946, 
   (nf_inq_per_sfd_addr > 16.5) => -0.0191558828, -0.0035828214), 
(nf_inq_Banking_count24 > 0.5) => map(
   ( NULL < rv_D32_Mos_Since_Fel_LS and rv_D32_Mos_Since_Fel_LS <= 161.5) => 0.0064628544, 
   (rv_D32_Mos_Since_Fel_LS > 161.5) => 0.0891598547, 0.0070234952), -0.0013072893);

// Tree: 663
final_score_663 := map(
(iv_full_name_ver_sources in ['NAME NOT VERD','PHN & NONPHN']) => map(
   ( NULL < nf_fp_srchfraudsrchcountyr and nf_fp_srchfraudsrchcountyr <= 3.5) => -0.0110795276, 
   (nf_fp_srchfraudsrchcountyr > 3.5) => 0.0032612664, -0.0050088547), 
(iv_full_name_ver_sources in ['NONPHN ONLY','PHN ONLY']) => map(
   ( NULL < rv_I62_inq_num_names_per_adl and rv_I62_inq_num_names_per_adl <= 2.5) => 0.0073870593, 
   (rv_I62_inq_num_names_per_adl > 2.5) => -0.0430401359, 0.0062584354), -0.0018270859);

// Tree: 664
final_score_664 := map(
( NULL < nf_fp_prevaddrmedianincome and nf_fp_prevaddrmedianincome <= 15771.5) => map(
   ( NULL < nf_average_rel_income and nf_average_rel_income <= 46500) => -0.0630368614, 
   (nf_average_rel_income > 46500) => -0.0069288120, -0.0250124168), 
(nf_fp_prevaddrmedianincome > 15771.5) => map(
   ( NULL < nf_pct_rel_with_felony and nf_pct_rel_with_felony <= 0.36515151515) => 0.0008076245, 
   (nf_pct_rel_with_felony > 0.36515151515) => -0.0406817607, 0.0006217120), 0.0002429442);

// Tree: 665
final_score_665 := map(
(iv_D34_liens_unrel_x_rel in ['3-2']) => map(
   ( NULL < nf_historical_count and nf_historical_count <= 16.5) => -0.0249363253, 
   (nf_historical_count > 16.5) => 0.0856493694, -0.0213888680), 
(iv_D34_liens_unrel_x_rel in ['0-0','0-1','0-2','1-0','1-1','1-2','2-0','2-1','2-2','3-0','3-1']) => map(
   ( NULL < rv_F00_dob_score and rv_F00_dob_score <= 80) => 0.0527956685, 
   (rv_F00_dob_score > 80) => 0.0017129740, -0.0139040064), 0.0000330126);

// Tree: 666
final_score_666 := map(
( NULL < nf_fp_srchaddrsrchcountwk and nf_fp_srchaddrsrchcountwk <= 2.5) => 0.0003779233, 
(nf_fp_srchaddrsrchcountwk > 2.5) => map(
   ( NULL < iv_prv_addr_lres and iv_prv_addr_lres <= 6.5) => map(
      ( NULL < nf_fp_prevaddrlenofres and nf_fp_prevaddrlenofres <= 25.5) => 0.1048528399, 
      (nf_fp_prevaddrlenofres > 25.5) => -0.0090936034, 0.0364849739), 
   (iv_prv_addr_lres > 6.5) => -0.0203794559, -0.0460084309), -0.0000141884);

// Tree: 667
final_score_667 := map(
( NULL < rv_I60_inq_other_count12 and rv_I60_inq_other_count12 <= 17.5) => 0.0011983085, 
(rv_I60_inq_other_count12 > 17.5) => map(
   ( NULL < rv_C12_source_profile and rv_C12_source_profile <= 60) => map(
      (nf_historic_x_current_ct in ['1-0','1-1','2-1','2-2','3-1','3-2','3-3']) => 0.0246681140, 
      (nf_historic_x_current_ct in ['0-0','2-0','3-0']) => 0.1901251675, 0.1065934512), 
   (rv_C12_source_profile > 60) => -0.0046990263, 0.0387219024), 0.0013258231);

// Tree: 668
final_score_668 := map(
( NULL < nf_fp_srchaddrsrchcountmo and nf_fp_srchaddrsrchcountmo <= 10.5) => -0.0008898844, 
(nf_fp_srchaddrsrchcountmo > 10.5) => map(
   ( NULL < nf_add_input_nhood_BUS_pct and nf_add_input_nhood_BUS_pct <= 0.0142745604) => 0.0935237277, 
   (nf_add_input_nhood_BUS_pct > 0.0142745604) => map(
      ( NULL < rv_L79_adls_per_sfd_addr_c6 and rv_L79_adls_per_sfd_addr_c6 <= 0.5) => 0.0681033117, 
      (rv_L79_adls_per_sfd_addr_c6 > 0.5) => -0.0387435403, 0.0051934830), 0.0325473652), -0.0007564711);

// Tree: 669
final_score_669 := map(
( NULL < rv_D32_criminal_count and rv_D32_criminal_count <= 19.5) => map(
   ( NULL < iv_fname_non_phn_src_ct and iv_fname_non_phn_src_ct <= 12.5) => 0.0017959811, 
   (iv_fname_non_phn_src_ct > 12.5) => map(
      ( NULL < nf_rel_bankrupt_count and nf_rel_bankrupt_count <= 8.5) => -0.0100932040, 
      (nf_rel_bankrupt_count > 8.5) => 0.0350957385, -0.0075910606), 0.0003777062), 
(rv_D32_criminal_count > 19.5) => -0.0688008489, 0.0002761982);

// Tree: 670
final_score_670 := map(
( NULL < rv_I60_Inq_Count12 and rv_I60_Inq_Count12 <= 3.5) => map(
   ( NULL < nf_fp_srchfraudsrchcountmo and nf_fp_srchfraudsrchcountmo <= 5.5) => 0.0020974971, 
   (nf_fp_srchfraudsrchcountmo > 5.5) => map(
      ( NULL < nf_pct_rel_prop_owned and nf_pct_rel_prop_owned <= 0.7537878788) => 0.0401394484, 
      (nf_pct_rel_prop_owned > 0.7537878788) => -0.0399891495, 0.0260973044), 0.0024609821), 
(rv_I60_Inq_Count12 > 3.5) => -0.0063281255, -0.0002332733);

// Tree: 671
final_score_671 := map(
( NULL < iv_inp_add_avm_pct_chg_1yr and iv_inp_add_avm_pct_chg_1yr <= 3.37434941545) => -0.0001480942, 
(iv_inp_add_avm_pct_chg_1yr > 3.37434941545) => map(
   ( NULL < nf_fp_prevaddrburglaryindex and nf_fp_prevaddrburglaryindex <= 114) => 0.2111172085, 
   (nf_fp_prevaddrburglaryindex > 114) => 0.0003820713, 0.0786190683), map(
   ( NULL < nf_rel_count and nf_rel_count <= 55.5) => 0.0008926483, 
   (nf_rel_count > 55.5) => 0.0800937821, 0.0011544076));

// Tree: 672
final_score_672 := map(
( NULL < rv_I60_Inq_Count12 and rv_I60_Inq_Count12 <= 4.5) => 0.0029126546, 
(rv_I60_Inq_Count12 > 4.5) => map(
   ( NULL < nf_inq_Communications_count24 and nf_inq_Communications_count24 <= 0.5) => -0.0014868817, 
   (nf_inq_Communications_count24 > 0.5) => map(
      ( NULL < iv_inp_add_avm_chg_2yr and iv_inp_add_avm_chg_2yr <= 8357.5) => -0.0469722255, 
      (iv_inp_add_avm_chg_2yr > 8357.5) => 0.0044570184, -0.0190085562), -0.0048039321), 0.0011910269);

// Tree: 673
final_score_673 := map(
( NULL < nf_inq_per_sfd_addr and nf_inq_per_sfd_addr <= 29.5) => -0.0014391807, 
(nf_inq_per_sfd_addr > 29.5) => map(
   ( NULL < nf_average_rel_distance and nf_average_rel_distance <= 69.5) => 0.1236175340, 
   (nf_average_rel_distance > 69.5) => map(
      ( NULL < nf_inq_dobs_per_ssn and nf_inq_dobs_per_ssn <= 2.5) => -0.0086073394, 
      (nf_inq_dobs_per_ssn > 2.5) => 0.1097279483, 0.0047368526), 0.0292359119), -0.0012054386);

// Tree: 674
final_score_674 := map(
( NULL < nf_add_input_mobility_index and nf_add_input_mobility_index <= 0.66867656885) => 0.0008914168, 
(nf_add_input_mobility_index > 0.66867656885) => map(
   ( NULL < nf_fp_curraddrburglaryindex and nf_fp_curraddrburglaryindex <= 197.5) => map(
      ( NULL < nf_fp_curraddrburglaryindex and nf_fp_curraddrburglaryindex <= 154.5) => -0.0166679022, 
      (nf_fp_curraddrburglaryindex > 154.5) => -0.0713450028, -0.0277946921), 
   (nf_fp_curraddrburglaryindex > 197.5) => 0.1113009509, -0.0240060949), 0.0002318928);

// Tree: 675
final_score_675 := map(
( NULL < nf_add_input_nhood_BUS_pct and nf_add_input_nhood_BUS_pct <= 0.00420388975) => map(
   ( NULL < rv_A49_curr_add_avm_pct_chg_3yr and rv_A49_curr_add_avm_pct_chg_3yr <= 1.3309154106) => map(
      ( NULL < iv_prv_addr_lres and iv_prv_addr_lres <= 13.5) => 0.0723599120, 
      (iv_prv_addr_lres > 13.5) => -0.0350061808, -0.0224393212), 
   (rv_A49_curr_add_avm_pct_chg_3yr > 1.3309154106) => 0.0103773957, -0.0211345493), 
(nf_add_input_nhood_BUS_pct > 0.00420388975) => 0.0015213361, -0.0001197697);

// Tree: 676
final_score_676 := map(
(nf_fp_addrchangeecontraj in ['AC','AF','BD','BF','CE','DA','DU','FU','UE']) => -0.0750036342, 
(nf_fp_addrchangeecontraj in ['-1','AA','AB','AD','AE','AU','BA','BB','BC','BE','BU','CA','CB','CC','CD','CF','CU','DB','DC','DD','DE','DF','EA','EB','EC','ED','EE','EF','EU','FA','FB','FC','FD','FE','FF','UC','UD','UF','UU']) => map(
   (iv_curr_add_mortgage_type in ['GOVERNMENT','NON-TRADITIONAL','UNKNOWN']) => map(
      ( NULL < nf_inq_HighRiskCredit_count_day and nf_inq_HighRiskCredit_count_day <= 1.5) => -0.0081517524, 
      (nf_inq_HighRiskCredit_count_day > 1.5) => -0.0499173539, -0.0085993028), 
   (iv_curr_add_mortgage_type in ['COMMERCIAL','CONVENTIONAL','NO MORTGAGE','OTHER']) => 0.0012896989, -0.0008679317), -0.0011322488);

// Tree: 677
final_score_677 := map(
( NULL < nf_fp_srchssnsrchcountwk and nf_fp_srchssnsrchcountwk <= 6.5) => map(
   ( NULL < iv_Estimated_Income and iv_Estimated_Income <= 37500) => -0.0056472217, 
   (iv_Estimated_Income > 37500) => 0.0025977580, -0.0002480323), 
(nf_fp_srchssnsrchcountwk > 6.5) => map(
   ( NULL < nf_pct_rel_with_criminal and nf_pct_rel_with_criminal <= 0.26568627455) => -0.0118861549, 
   (nf_pct_rel_with_criminal > 0.26568627455) => 0.0999144449, 0.0510604013), -0.0001694447);

// Tree: 678
final_score_678 := map(
( NULL < nf_rel_bankrupt_count and nf_rel_bankrupt_count <= 13.5) => map(
   ( NULL < nf_fp_curraddrmedianvalue and nf_fp_curraddrmedianvalue <= 721685.5) => map(
      ( NULL < nf_hh_payday_loan_users_pct and nf_hh_payday_loan_users_pct <= 0.21240601505) => 0.0001666778, 
      (nf_hh_payday_loan_users_pct > 0.21240601505) => 0.0100677410, 0.0016115530), 
   (nf_fp_curraddrmedianvalue > 721685.5) => -0.0347191695, 0.0010181071), 
(nf_rel_bankrupt_count > 13.5) => -0.0627139046, 0.0007629920);

// Tree: 679
final_score_679 := map(
( NULL < nf_rel_count and nf_rel_count <= 43.5) => 0.0011438607, 
(nf_rel_count > 43.5) => map(
   ( NULL < nf_inq_adls_per_phone and nf_inq_adls_per_phone <= 1.5) => -0.0173077936, 
   (nf_inq_adls_per_phone > 1.5) => map(
      ( NULL < nf_inq_per_phone and nf_inq_per_phone <= 5.5) => -0.0041503183, 
      (nf_inq_per_phone > 5.5) => -0.1101761372, -0.0621212696), -0.0237295185), 0.0008326833);

// Tree: 680
final_score_680 := map(
( NULL < nf_fp_srchfraudsrchcountmo and nf_fp_srchfraudsrchcountmo <= 2.5) => 0.0022959608, 
(nf_fp_srchfraudsrchcountmo > 2.5) => map(
   ( NULL < nf_fp_addrchangeincomediff and nf_fp_addrchangeincomediff <= 6208) => -0.0071254770, 
   (nf_fp_addrchangeincomediff > 6208) => map(
      ( NULL < nf_fp_curraddrcartheftindex and nf_fp_curraddrcartheftindex <= 110.5) => -0.0005287347, 
      (nf_fp_curraddrcartheftindex > 110.5) => 0.1019680829, 0.0442892654), -0.0058368010), 0.0011975303);

// Tree: 681
final_score_681 := map(
( NULL < rv_D32_attr_felonies_recency and rv_D32_attr_felonies_recency <= 79.5) => 0.0014018500, 
(rv_D32_attr_felonies_recency > 79.5) => map(
   ( NULL < iv_src_voter_adl_count and iv_src_voter_adl_count <= 5.5) => map(
      ( NULL < rv_I62_inq_ssns_per_adl and rv_I62_inq_ssns_per_adl <= 0.5) => 0.0679139183, 
      (rv_I62_inq_ssns_per_adl > 0.5) => -0.0372006381, -0.0252214638), 
   (iv_src_voter_adl_count > 5.5) => 0.0620881027, -0.0196806644), 0.0011196535);

// Tree: 682
final_score_682 := map(
( NULL < nf_fp_prevaddrageoldest and nf_fp_prevaddrageoldest <= 0) => -0.0749087347, 
(nf_fp_prevaddrageoldest > 0) => map(
   ( NULL < rv_I60_inq_comm_count12 and rv_I60_inq_comm_count12 <= 4.5) => -0.0008615143, 
   (rv_I60_inq_comm_count12 > 4.5) => map(
      ( NULL < nf_hh_tot_derog_avg and nf_hh_tot_derog_avg <= 0.4365079365) => 0.1386343349, 
      (nf_hh_tot_derog_avg > 0.4365079365) => -0.0046805081, 0.0380764064), -0.0007706071), -0.0009318682);

// Tree: 683
final_score_683 := map(
( NULL < nf_add_input_nhood_BUS_pct and nf_add_input_nhood_BUS_pct <= 0.7640914496) => map(
   ( NULL < nf_fp_idrisktype and nf_fp_idrisktype <= 1.5) => -0.0022327659, 
   (nf_fp_idrisktype > 1.5) => map(
      (nf_fp_addrchangeecontraj in ['-1','AA','AC','AD','AE','BA','BB','BD','BE','CA','CB','CC','CD','CE','CF','DC','DD','DE','EA','EB','ED','EE','FB','FC','FF','FU','UU']) => 0.0103431148, 
      (nf_fp_addrchangeecontraj in ['AB','AF','AU','BC','BF','BU','CU','DA','DB','DF','DU','EC','EF','EU','FA','FD','FE','UC','UD','UE','UF']) => 0.1482280309, 0.0127717501), -0.0014535941), 
(nf_add_input_nhood_BUS_pct > 0.7640914496) => -0.1218783820, -0.0015372946);

// Tree: 684
final_score_684 := map(
( NULL < nf_mos_liens_unrel_OT_lseen and nf_mos_liens_unrel_OT_lseen <= 84.5) => -0.0009118959, 
(nf_mos_liens_unrel_OT_lseen > 84.5) => map(
   ( NULL < rv_C10_M_Hdr_FS and rv_C10_M_Hdr_FS <= 338.5) => map(
      ( NULL < nf_fp_varrisktype and nf_fp_varrisktype <= 4.5) => 0.0380232451, 
      (nf_fp_varrisktype > 4.5) => 0.1184689212, 0.0473079357), 
   (rv_C10_M_Hdr_FS > 338.5) => 0.0068443191, 0.0227448649), 0.0000481248);

// Tree: 685
final_score_685 := map(
( NULL < iv_inp_add_avm_chg_2yr and iv_inp_add_avm_chg_2yr <= -39303.5) => 0.0562716527, 
(iv_inp_add_avm_chg_2yr > -39303.5) => 0.0003865610, map(
   ( NULL < rv_I60_inq_hiRiskCred_recency and rv_I60_inq_hiRiskCred_recency <= 2) => -0.0042051301, 
   (rv_I60_inq_hiRiskCred_recency > 2) => map(
      ( NULL < nf_fp_srchphonesrchcountwk and nf_fp_srchphonesrchcountwk <= 0.5) => 0.0052035313, 
      (nf_fp_srchphonesrchcountwk > 0.5) => 0.0415206792, 0.0067775585), 0.0023617043));

// Tree: 686
final_score_686 := map(
( NULL < rv_I60_credit_seeking and rv_I60_credit_seeking <= 1.5) => -0.0000464759, 
(rv_I60_credit_seeking > 1.5) => map(
   ( NULL < nf_fp_addrchangeincomediff and nf_fp_addrchangeincomediff <= -10475) => 0.1093013080, 
   (nf_fp_addrchangeincomediff > -10475) => map(
      ( NULL < nf_hh_collections_ct and nf_hh_collections_ct <= 1.5) => 0.0027843692, 
      (nf_hh_collections_ct > 1.5) => -0.0326724468, -0.0166885173), -0.0141984928), -0.0008943874);

// Tree: 687
final_score_687 := map(
( NULL < nf_fp_addrchangevaluediff and nf_fp_addrchangevaluediff <= 175010.5) => -0.0006931163, 
(nf_fp_addrchangevaluediff > 175010.5) => map(
   (nf_fp_addrchangeecontraj in ['AA','AB','AC','AD','AF','BA','BC','BD','BE','CA','CD','CE','DA','DB','EA','EB','EC','ED','EF','FB','FC','FE']) => -0.0028442674, 
   (nf_fp_addrchangeecontraj in ['-1','AE','AU','BB','BF','BU','CB','CC','CF','CU','DC','DD','DE','DF','DU','EE','EU','FA','FD','FF','FU','UC','UD','UE','UF','UU']) => map(
      ( NULL < nf_fp_prevaddrmedianincome and nf_fp_prevaddrmedianincome <= 49218.5) => 0.2554486617, 
      (nf_fp_prevaddrmedianincome > 49218.5) => 0.0308700921, 0.1363124693), 0.0499837530), -0.0004113317);

// Tree: 688
final_score_688 := map(
( NULL < nf_M_Bureau_ADL_FS_all and nf_M_Bureau_ADL_FS_all <= 17.5) => map(
   ( NULL < rv_C13_max_lres and rv_C13_max_lres <= 14.5) => 0.0313775007, 
   (rv_C13_max_lres > 14.5) => map(
      ( NULL < nf_pct_rel_with_bk and nf_pct_rel_with_bk <= 0.2264957265) => -0.0441615043, 
      (nf_pct_rel_with_bk > 0.2264957265) => -0.1179766046, -0.0690741007), -0.0497955105), 
(nf_M_Bureau_ADL_FS_all > 17.5) => 0.0004520276, 0.0002599469);

// Tree: 689
final_score_689 := map(
( NULL < nf_liens_unrel_CJ_total_amt and nf_liens_unrel_CJ_total_amt <= 3997.5) => -0.0007668909, 
(nf_liens_unrel_CJ_total_amt > 3997.5) => map(
   ( NULL < nf_inq_ssns_per_apt_addr and nf_inq_ssns_per_apt_addr <= 0.5) => 0.0086285134, 
   (nf_inq_ssns_per_apt_addr > 0.5) => map(
      ( NULL < nf_average_rel_distance and nf_average_rel_distance <= 29.5) => 0.1941867764, 
      (nf_average_rel_distance > 29.5) => 0.0344652952, 0.0485411173), 0.0129873689), 0.0005580104);

// Tree: 690
final_score_690 := map(
( NULL < rv_C13_Curr_Addr_LRes and rv_C13_Curr_Addr_LRes <= 7.5) => map(
   ( NULL < nf_inq_ssns_per_addr and nf_inq_ssns_per_addr <= 2.5) => map(
      ( NULL < rv_C13_max_lres and rv_C13_max_lres <= 326.5) => -0.0073027802, 
      (rv_C13_max_lres > 326.5) => 0.1526833041, -0.0048499201), 
   (nf_inq_ssns_per_addr > 2.5) => -0.0362437828, -0.0096251741), 
(rv_C13_Curr_Addr_LRes > 7.5) => 0.0017223301, 0.0005198073);

// Tree: 691
final_score_691 := map(
( NULL < rv_D32_Mos_Since_Crim_LS and rv_D32_Mos_Since_Crim_LS <= 191.5) => map(
   ( NULL < rv_A49_curr_add_avm_chg_2yr and rv_A49_curr_add_avm_chg_2yr <= 149025) => map(
      ( NULL < nf_fp_srchaddrsrchcountmo and nf_fp_srchaddrsrchcountmo <= 4.5) => -0.0002585102, 
      (nf_fp_srchaddrsrchcountmo > 4.5) => 0.0200334502, 0.0007965049), 
   (rv_A49_curr_add_avm_chg_2yr > 149025) => -0.0325985445, 0.0005077498), 
(rv_D32_Mos_Since_Crim_LS > 191.5) => -0.0203575100, -0.0007972607);

// Tree: 692
final_score_692 := map(
( NULL < nf_fp_inputaddractivephonelist and nf_fp_inputaddractivephonelist <= 0.5) => map(
   ( NULL < rv_C21_stl_recency and rv_C21_stl_recency <= 18) => -0.0049183586, 
   (rv_C21_stl_recency > 18) => 0.0982493629, -0.0046689830), 
(nf_fp_inputaddractivephonelist > 0.5) => map(
   ( NULL < nf_util_adl_count and nf_util_adl_count <= 3.5) => -0.0007532552, 
   (nf_util_adl_count > 3.5) => 0.0119035836, 0.0047492591), -0.0001652019);

// Tree: 693
final_score_693 := map(
( NULL < nf_fp_srchssnsrchcountmo and nf_fp_srchssnsrchcountmo <= 9.5) => 0.0017363063, 
(nf_fp_srchssnsrchcountmo > 9.5) => map(
   ( NULL < nf_fp_srchphonesrchcountmo and nf_fp_srchphonesrchcountmo <= 8.5) => 0.0099952666, 
   (nf_fp_srchphonesrchcountmo > 8.5) => map(
      (nf_fp_addrchangeecontraj in ['-1','AD','BA','DC','EB','EE','FF']) => -0.1156587996, 
      (nf_fp_addrchangeecontraj in ['AA','AB','AC','AE','AF','AU','BB','BC','BD','BE','BF','BU','CA','CB','CC','CD','CE','CF','CU','DA','DB','DD','DE','DF','DU','EA','EC','ED','EF','EU','FA','FB','FC','FD','FE','FU','UC','UD','UE','UF','UU']) => 0.0340708096, -0.0628130552), -0.0270628613), 0.0016125011);

// Tree: 694
final_score_694 := map(
( NULL < nf_Inq_Add_Per_SSN_NAS_479 and nf_Inq_Add_Per_SSN_NAS_479 <= 3.5) => map(
   ( NULL < nf_inq_per_phone and nf_inq_per_phone <= 10.5) => -0.0015529720, 
   (nf_inq_per_phone > 10.5) => map(
      ( NULL < nf_average_rel_age and nf_average_rel_age <= 45.5) => 0.0148694604, 
      (nf_average_rel_age > 45.5) => -0.0360051620, 0.0101426446), 0.0188365645), 
(nf_Inq_Add_Per_SSN_NAS_479 > 3.5) => -0.0666955489, -0.0008982724);

// Tree: 695
final_score_695 := map(
( NULL < nf_fp_srchfraudsrchcountwk and nf_fp_srchfraudsrchcountwk <= 1.5) => -0.0000484351, 
(nf_fp_srchfraudsrchcountwk > 1.5) => map(
   ( NULL < iv_C13_avg_lres and iv_C13_avg_lres <= 224.5) => map(
      (iv_college_major in ['BUSINESS','LIBERAL ARTS','NO COLLEGE FOUND','UNCLASSIFIED']) => -0.0234244568, 
      (iv_college_major in ['MEDICAL','NO AMS FOUND','SCIENCE']) => -0.0010700695, -0.0093066508), 
   (iv_C13_avg_lres > 224.5) => 0.1229573665, -0.0078252490), -0.0005220866);

// Tree: 696
final_score_696 := map(
(nf_fp_addrchangeecontraj in ['AC','AD','AE','AF','BA','BC','BD','BU','CA','CU','DE','EA','EC','EU','FA','FB','FD','FE','UC','UE','UF','UU']) => -0.0276995569, 
(nf_fp_addrchangeecontraj in ['-1','AA','AB','AU','BB','BE','BF','CB','CC','CD','CE','CF','DA','DB','DC','DD','DF','DU','EB','ED','EE','EF','FC','FF','FU','UD']) => map(
   ( NULL < nf_inq_Banking_count_day and nf_inq_Banking_count_day <= 0.5) => map(
      ( NULL < iv_prv_addr_avm_auto_val and iv_prv_addr_avm_auto_val <= 1822101.5) => 0.0015577422, 
      (iv_prv_addr_avm_auto_val > 1822101.5) => 0.1600307440, 0.0027724630), 
   (nf_inq_Banking_count_day > 0.5) => 0.1013071261, 0.0017696188), 0.0011643060);

// Tree: 697
final_score_697 := map(
(nf_fp_addrchangeecontraj in ['AB','AE','BE','BU','CA','DA','DB','DC','EA','EU','FA','FB','FU','UC','UD','UE','UF']) => -0.0598485773, 
(nf_fp_addrchangeecontraj in ['-1','AA','AC','AD','AF','AU','BA','BB','BC','BD','BF','CB','CC','CD','CE','CF','CU','DD','DE','DF','DU','EB','EC','ED','EE','EF','FC','FD','FE','FF','UU']) => map(
   ( NULL < rv_I60_inq_other_count12 and rv_I60_inq_other_count12 <= 11.5) => 0.0002736378, 
   (rv_I60_inq_other_count12 > 11.5) => map(
      ( NULL < nf_liens_unrel_CJ_total_amt and nf_liens_unrel_CJ_total_amt <= 7224.5) => -0.0175559491, 
      (nf_liens_unrel_CJ_total_amt > 7224.5) => -0.1320905292, -0.0246137556), -0.0000242509), -0.0003445624);

// Tree: 698
final_score_698 := map(
( NULL < iv_inp_add_avm_pct_chg_1yr and iv_inp_add_avm_pct_chg_1yr <= 4.755764257) => -0.0007727765, 
(iv_inp_add_avm_pct_chg_1yr > 4.755764257) => -0.0979935330, map(
   ( NULL < rv_D32_criminal_count and rv_D32_criminal_count <= 9.5) => 0.0018420127, 
   (rv_D32_criminal_count > 9.5) => map(
      ( NULL < nf_hh_tot_derog and nf_hh_tot_derog <= 5.5) => 0.0606308297, 
      (nf_hh_tot_derog > 5.5) => -0.0657031289, 0.0419498684), 0.0022261009));

// Tree: 699
final_score_699 := map(
( NULL < rv_D32_criminal_count and rv_D32_criminal_count <= 9.5) => -0.0003360098, 
(rv_D32_criminal_count > 9.5) => map(
   ( NULL < nf_fp_srchaddrsrchcountwk and nf_fp_srchaddrsrchcountwk <= 0.5) => map(
      ( NULL < nf_inq_Banking_count24 and nf_inq_Banking_count24 <= 0.5) => -0.0105530928, 
      (nf_inq_Banking_count24 > 0.5) => 0.0898978629, 0.0139428420), 
   (nf_fp_srchaddrsrchcountwk > 0.5) => 0.0842308400, 0.0264182010), -0.0000973727);

// Tree: 700
final_score_700 := map(
( NULL < nf_fp_srchssnsrchcountmo and nf_fp_srchssnsrchcountmo <= 6.5) => 0.0011721113, 
(nf_fp_srchssnsrchcountmo > 6.5) => map(
   ( NULL < nf_fp_curraddrcrimeindex and nf_fp_curraddrcrimeindex <= 167.5) => map(
      ( NULL < nf_add_input_mobility_index and nf_add_input_mobility_index <= 0.1920473599) => 0.1184714003, 
      (nf_add_input_mobility_index > 0.1920473599) => 0.0154454538, 0.0198567857), 
   (nf_fp_curraddrcrimeindex > 167.5) => -0.0475521295, 0.0138366185), 0.0014312858);

// Tree: 701
final_score_701 := map(
( NULL < rv_I60_inq_other_count12 and rv_I60_inq_other_count12 <= 6.5) => -0.0008402863, 
(rv_I60_inq_other_count12 > 6.5) => map(
   ( NULL < nf_phone_ver_experian and nf_phone_ver_experian <= -0.5) => map(
      (rv_6seg_RiskView_5_0 in ['4 SUFFICIENTLY VERD - DEROG','5 SUFFICIENTLY VERD - OWNER']) => -0.0085250337, 
      (rv_6seg_RiskView_5_0 in ['0 TRUEDID = 0','1 VER/VAL PROBLEMS','2 ADDR NOT CURRENT - DEROG','3 ADDR NOT CURRENT - OTHER','6 SUFFICIENTLY VERD - OTHER']) => 0.1431510738, 0.0746954854), 
   (nf_phone_ver_experian > -0.5) => 0.0102613687, 0.0122255055), -0.0002169045);

// Tree: 702
final_score_702 := map(
( NULL < rv_I60_credit_seeking and rv_I60_credit_seeking <= 0.5) => -0.0018778153, 
(rv_I60_credit_seeking > 0.5) => map(
   ( NULL < nf_hh_collections_ct and nf_hh_collections_ct <= 4.5) => 0.0107390591, 
   (nf_hh_collections_ct > 4.5) => map(
      (nf_fp_addrchangeecontraj in ['-1','AA','BB','CC','DF','EE','EF','FD','FE','FF','UU']) => -0.0621401785, 
      (nf_fp_addrchangeecontraj in ['AB','AC','AD','AE','AF','AU','BA','BC','BD','BE','BF','BU','CA','CB','CD','CE','CF','CU','DA','DB','DC','DD','DE','DU','EA','EB','EC','ED','EU','FA','FB','FC','FU','UC','UD','UE','UF']) => 0.0733917078, -0.0384847158), 0.0082994114), -0.0005907625);

// Tree: 703
final_score_703 := map(
( NULL < nf_recent_disconnects and nf_recent_disconnects <= 1.5) => map(
   ( NULL < rv_L79_adls_per_addr_c6 and rv_L79_adls_per_addr_c6 <= 3.5) => -0.0011953648, 
   (rv_L79_adls_per_addr_c6 > 3.5) => 0.0098899057, -0.0005821376), 
(nf_recent_disconnects > 1.5) => map(
   ( NULL < nf_inq_count_week and nf_inq_count_week <= 0.5) => 0.0388436046, 
   (nf_inq_count_week > 0.5) => 0.1160148562, 0.0458025196), -0.0229651638);

// Tree: 704
final_score_704 := map(
(nf_historic_x_current_ct in ['1-1','2-1','2-2']) => map(
   ( NULL < nf_bus_addr_match_count and nf_bus_addr_match_count <= 22.5) => map(
      ( NULL < nf_fp_srchcomponentrisktype and nf_fp_srchcomponentrisktype <= 6.5) => -0.0087290440, 
      (nf_fp_srchcomponentrisktype > 6.5) => -0.0271576152, -0.0101518941), 
   (nf_bus_addr_match_count > 22.5) => 0.1361012496, -0.0088502037), 
(nf_historic_x_current_ct in ['0-0','1-0','2-0','3-0','3-1','3-2','3-3']) => 0.0013249933, 0.0000446792);

// Tree: 705
final_score_705 := map(
( NULL < nf_hh_age_30_plus and nf_hh_age_30_plus <= 8.5) => map(
   ( NULL < nf_inq_ssns_per_apt_addr and nf_inq_ssns_per_apt_addr <= 1.5) => -0.0001683858, 
   (nf_inq_ssns_per_apt_addr > 1.5) => map(
      ( NULL < nf_inq_count24 and nf_inq_count24 <= 9.5) => 0.0228864349, 
      (nf_inq_count24 > 9.5) => -0.0119743750, 0.0153639514), 0.0008190122), 
(nf_hh_age_30_plus > 8.5) => -0.0445706342, 0.0004930480);

// Tree: 706
final_score_706 := map(
( NULL < iv_F00_nas_summary and iv_F00_nas_summary <= 8.5) => map(
   ( NULL < nf_hh_lienholders_pct and nf_hh_lienholders_pct <= 0.4722222222) => map(
      ( NULL < iv_dob_src_ct and iv_dob_src_ct <= 2.5) => -0.0347921540, 
      (iv_dob_src_ct > 2.5) => 0.0264760432, 0.0062935783), 
   (nf_hh_lienholders_pct > 0.4722222222) => 0.1595746806, 0.0419710762), 
(iv_F00_nas_summary > 8.5) => -0.0019352884, -0.0018041808);

// Tree: 707
final_score_707 := map(
( NULL < rv_I60_inq_hiRiskCred_count12 and rv_I60_inq_hiRiskCred_count12 <= 19.5) => -0.0010453463, 
(rv_I60_inq_hiRiskCred_count12 > 19.5) => map(
   ( NULL < nf_inq_count24 and nf_inq_count24 <= 12.5) => map(
      ( NULL < nf_hh_members_w_derog_pct and nf_hh_members_w_derog_pct <= 0.3741258741) => 0.0115442751, 
      (nf_hh_members_w_derog_pct > 0.3741258741) => 0.1911751220, 0.1141904733), 
   (nf_inq_count24 > 12.5) => -0.0200461050, 0.0435959381), -0.0009011291);

// Tree: 708
final_score_708 := map(
( NULL < nf_mos_liens_unrel_ST_fseen and nf_mos_liens_unrel_ST_fseen <= 231.5) => map(
   ( NULL < iv_inp_add_avm_pct_chg_3yr and iv_inp_add_avm_pct_chg_3yr <= 1.26391074695) => map(
      ( NULL < nf_liens_unrel_SC_total_amt and nf_liens_unrel_SC_total_amt <= 6289) => 0.0073892166, 
      (nf_liens_unrel_SC_total_amt > 6289) => 0.2051568654, 0.0083005882), 
   (iv_inp_add_avm_pct_chg_3yr > 1.26391074695) => -0.0046922445, -0.0003683433), 
(nf_mos_liens_unrel_ST_fseen > 231.5) => -0.0916171161, -0.0002363583);

// Tree: 709
final_score_709 := map(
( NULL < nf_fp_srchfraudsrchcountmo and nf_fp_srchfraudsrchcountmo <= 7.5) => -0.0006329740, 
(nf_fp_srchfraudsrchcountmo > 7.5) => map(
   (nf_historic_x_current_ct in ['1-1','2-1','3-0','3-3']) => -0.0415270601, 
   (nf_historic_x_current_ct in ['0-0','1-0','2-0','2-2','3-1','3-2']) => map(
      ( NULL < nf_util_adl_count and nf_util_adl_count <= 4.5) => -0.0216947139, 
      (nf_util_adl_count > 4.5) => 0.0342289080, -0.0028610812), -0.0148904969), -0.0008394213);

// Tree: 710
final_score_710 := map(
( NULL < rv_C14_addrs_per_adl_c6 and rv_C14_addrs_per_adl_c6 <= 1.5) => -0.0010354055, 
(rv_C14_addrs_per_adl_c6 > 1.5) => map(
   (nf_historic_x_current_ct in ['0-0','1-0','1-1','2-1','3-1','3-3']) => 0.0147033353, 
   (nf_historic_x_current_ct in ['2-0','2-2','3-0','3-2']) => map(
      ( NULL < nf_inq_per_phone and nf_inq_per_phone <= 1.5) => 0.0025054246, 
      (nf_inq_per_phone > 1.5) => 0.1802513601, 0.1134390581), 0.0332162833), -0.0007038878);

// Tree: 711
final_score_711 := map(
( NULL < iv_college_tier and iv_college_tier <= 4.5) => -0.0015345049, 
(iv_college_tier > 4.5) => map(
   ( NULL < nf_pct_rel_prop_owned and nf_pct_rel_prop_owned <= 0.3858560794) => map(
      ( NULL < nf_fp_srchssnsrchcountwk and nf_fp_srchssnsrchcountwk <= 2.5) => 0.0250160983, 
      (nf_fp_srchssnsrchcountwk > 2.5) => 0.0873108784, 0.0280021290), 
   (nf_pct_rel_prop_owned > 0.3858560794) => 0.0014662919, 0.0103376392), -0.0007048867);

// Tree: 712
final_score_712 := map(
(nf_fp_addrchangeecontraj in ['AB','AD','DA','DB','DU','EB','FB','FU','UD','UE','UF']) => -0.0808252553, 
(nf_fp_addrchangeecontraj in ['-1','AA','AC','AE','AF','AU','BA','BB','BC','BD','BE','BF','BU','CA','CB','CC','CD','CE','CF','CU','DC','DD','DE','DF','EA','EC','ED','EE','EF','EU','FA','FC','FD','FE','FF','UC','UU']) => map(
   ( NULL < nf_add_curr_mobility_index and nf_add_curr_mobility_index <= 0.5760882798) => -0.0010622570, 
   (nf_add_curr_mobility_index > 0.5760882798) => map(
      ( NULL < nf_add_curr_nhood_VAC_pct and nf_add_curr_nhood_VAC_pct <= 0.02884124485) => -0.0106462696, 
      (nf_add_curr_nhood_VAC_pct > 0.02884124485) => 0.0393375801, 0.0138176013), -0.0004531793), -0.0006683517);

// Tree: 713
final_score_713 := map(
( NULL < nf_liens_unrel_ST_total_amt and nf_liens_unrel_ST_total_amt <= 55.5) => -0.0001085651, 
(nf_liens_unrel_ST_total_amt > 55.5) => map(
   ( NULL < rv_C13_max_lres and rv_C13_max_lres <= 140.5) => map(
      ( NULL < nf_accident_recency and nf_accident_recency <= 4.5) => 0.0196420368, 
      (nf_accident_recency > 4.5) => 0.1067795560, 0.0457125928), 
   (rv_C13_max_lres > 140.5) => -0.0024516083, 0.0190370353), 0.0004360651);

// Tree: 714
final_score_714 := map(
( NULL < nf_rel_felony_count and nf_rel_felony_count <= 5.5) => 0.0011251881, 
(nf_rel_felony_count > 5.5) => map(
   (nf_historic_x_current_ct in ['1-1','2-1','2-2','3-3']) => -0.0633184241, 
   (nf_historic_x_current_ct in ['0-0','1-0','2-0','3-0','3-1','3-2']) => map(
      (iv_D34_liens_unrel_x_rel in ['0-1','1-1','1-2','2-2','3-0','3-1','3-2']) => -0.1059787891, 
      (iv_D34_liens_unrel_x_rel in ['0-0','0-2','1-0','2-0','2-1']) => 0.0539825551, 0.0172346787), -0.0328017196), 0.0008692975);

// Tree: 715
final_score_715 := map(
( NULL < nf_add_curr_nhood_VAC_pct and nf_add_curr_nhood_VAC_pct <= 1.2515722329) => 0.0005923204, 
(nf_add_curr_nhood_VAC_pct > 1.2515722329) => map(
   (nf_historic_x_current_ct in ['0-0','1-0','1-1','2-0','2-1','2-2','3-3']) => map(
      ( NULL < nf_hh_members_w_derog_pct and nf_hh_members_w_derog_pct <= 0.36607142855) => -0.0569763083, 
      (nf_hh_members_w_derog_pct > 0.36607142855) => 0.0878934845, 0.0229842916), 
   (nf_historic_x_current_ct in ['3-0','3-1','3-2']) => 0.2195806647, 0.0554839631), 0.0008529792);

// Tree: 716
final_score_716 := map(
( NULL < nf_pct_rel_with_bk and nf_pct_rel_with_bk <= 0.1368092692) => map(
   ( NULL < nf_fp_curraddrmedianincome and nf_fp_curraddrmedianincome <= 92302) => 0.0024433744, 
   (nf_fp_curraddrmedianincome > 92302) => map(
      (nf_fp_addrchangeecontraj in ['-1','AA','AB','AC','BB','BC','BD','BE','CA','CB','CC','CF','DA','DB','DD','DE','EC','ED','EE','EF','EU','FC','FD','FF','FU']) => 0.0293037121, 
      (nf_fp_addrchangeecontraj in ['AD','AE','AF','AU','BA','BF','BU','CD','CE','CU','DC','DF','DU','EA','EB','FA','FB','FE','UC','UD','UE','UF','UU']) => 0.2617361135, 0.0330446527), 0.0053262241), 
(nf_pct_rel_with_bk > 0.1368092692) => -0.0042187447, 0.0000755391);

// Tree: 717
final_score_717 := map(
( NULL < nf_inq_dobs_per_ssn and nf_inq_dobs_per_ssn <= 3.5) => map(
   (nf_fp_addrchangeecontraj in ['-1','AA','AC','AE','BA','BB','BC','BE','BF','BU','CA','CB','CC','CF','CU','DA','DB','DD','DF','EA','EB','EC','ED','EE','EF','EU','FA','FB','FD','FE','FF','UC','UE','UU']) => -0.0006038024, 
   (nf_fp_addrchangeecontraj in ['AB','AD','AF','AU','BD','CD','CE','DC','DE','DU','FC','FU','UD','UF']) => 0.0346300993, -0.0001989403), 
(nf_inq_dobs_per_ssn > 3.5) => map(
   ( NULL < nf_average_rel_income and nf_average_rel_income <= 68500) => 0.0076938156, 
   (nf_average_rel_income > 68500) => 0.1394813177, 0.0626780052), -0.0000767581);

// Tree: 718
final_score_718 := map(
(iv_curr_add_mortgage_type in ['GOVERNMENT']) => -0.0186453927, 
(iv_curr_add_mortgage_type in ['COMMERCIAL','CONVENTIONAL','NO MORTGAGE','NON-TRADITIONAL','OTHER','UNKNOWN']) => map(
   ( NULL < nf_phones_per_apt_addr_curr and nf_phones_per_apt_addr_curr <= 4.5) => 0.0023527132, 
   (nf_phones_per_apt_addr_curr > 4.5) => map(
      (rv_E58_br_dead_bus_x_active_phn in ['0-0','0-1','0-2','0-3','1-0','2-1','2-2','2-3','3-0','3-1','3-2','3-3']) => -0.0145099737, 
      (rv_E58_br_dead_bus_x_active_phn in ['1-1','1-2','1-3','2-0']) => 0.1833584237, -0.0127162857), 0.0011800106), -0.0001965409);

// Tree: 719
final_score_719 := map(
( NULL < nf_fp_srchaddrsrchcountmo and nf_fp_srchaddrsrchcountmo <= 9.5) => 0.0002611558, 
(nf_fp_srchaddrsrchcountmo > 9.5) => map(
   (nf_fp_addrchangeecontraj in ['BC','CA','DC','DD','EC','ED','EE']) => -0.0247057090, 
   (nf_fp_addrchangeecontraj in ['-1','AA','AB','AC','AD','AE','AF','AU','BA','BB','BD','BE','BF','BU','CB','CC','CD','CE','CF','CU','DA','DB','DE','DF','DU','EA','EB','EF','EU','FA','FB','FC','FD','FE','FF','FU','UC','UD','UE','UF','UU']) => map(
      ( NULL < iv_prv_addr_avm_auto_val and iv_prv_addr_avm_auto_val <= 242704) => 0.0650890122, 
      (iv_prv_addr_avm_auto_val > 242704) => -0.0366310135, 0.0454847890), 0.0179207093), 0.0003670663);

// Tree: 720
final_score_720 := map(
( NULL < nf_hh_tot_derog and nf_hh_tot_derog <= 4.5) => map(
   (nf_fp_addrchangeecontraj in ['AE','AF','BE','BF','BU','CE','DB','DC','DF','DU','EU','FA','FU','UC','UE','UU']) => -0.0515296933, 
   (nf_fp_addrchangeecontraj in ['-1','AA','AB','AC','AD','AU','BA','BB','BC','BD','CA','CB','CC','CD','CF','CU','DA','DD','DE','EA','EB','EC','ED','EE','EF','FB','FC','FD','FE','FF','UD','UF']) => -0.0019513375, -0.0024751050), 
(nf_hh_tot_derog > 4.5) => map(
   ( NULL < rv_F01_inp_addr_address_score and rv_F01_inp_addr_address_score <= 25) => 0.0605181600, 
   (rv_F01_inp_addr_address_score > 25) => 0.0085089927, 0.0094518134), -0.0007633209);

// Tree: 721
final_score_721 := map(
( NULL < nf_fp_srchphonesrchcountmo and nf_fp_srchphonesrchcountmo <= 11.5) => map(
   (rv_6seg_RiskView_5_0 in ['2 ADDR NOT CURRENT - DEROG','3 ADDR NOT CURRENT - OTHER','5 SUFFICIENTLY VERD - OWNER','6 SUFFICIENTLY VERD - OTHER']) => -0.0034343229, 
   (rv_6seg_RiskView_5_0 in ['0 TRUEDID = 0','1 VER/VAL PROBLEMS','4 SUFFICIENTLY VERD - DEROG']) => map(
      (nf_fp_addrchangeecontraj in ['-1','AA','AC','AE','BA','BB','BC','BE','BU','CA','CB','CC','CD','CE','CF','CU','DB','DC','DD','DE','EA','EB','EC','ED','EE','EF','FA','FB','FC','FE','FF','FU','UE','UU']) => 0.0042335623, 
      (nf_fp_addrchangeecontraj in ['AB','AD','AF','AU','BD','BF','DA','DF','DU','EU','FD','UC','UD','UF']) => 0.1026907149, 0.0045643507), 0.0006144266), 
(nf_fp_srchphonesrchcountmo > 11.5) => 0.0694686476, 0.0006800079);

// Tree: 722
final_score_722 := map(
( NULL < nf_fp_srchssnsrchcountwk and nf_fp_srchssnsrchcountwk <= 2.5) => -0.0004530209, 
(nf_fp_srchssnsrchcountwk > 2.5) => map(
   ( NULL < nf_inq_HighRiskCredit_count24 and nf_inq_HighRiskCredit_count24 <= 7.5) => map(
      ( NULL < rv_C22_inp_addr_owned_not_occ and rv_C22_inp_addr_owned_not_occ <= 0.5) => 0.0195582173, 
      (rv_C22_inp_addr_owned_not_occ > 0.5) => 0.1441497267, 0.0241035753), 
   (nf_inq_HighRiskCredit_count24 > 7.5) => -0.0211458966, 0.0097655139), -0.0001574739);

// Tree: 723
final_score_723 := map(
( NULL < iv_src_drivers_lic_adl_count and iv_src_drivers_lic_adl_count <= 8.5) => -0.0013570976, 
(iv_src_drivers_lic_adl_count > 8.5) => map(
   ( NULL < rv_P88_Phn_Dst_to_Inp_Add and rv_P88_Phn_Dst_to_Inp_Add <= 15.5) => 0.0038020909, 
   (rv_P88_Phn_Dst_to_Inp_Add > 15.5) => 0.0506533966, map(
      ( NULL < rv_C13_max_lres and rv_C13_max_lres <= 162.5) => 0.0307986368, 
      (rv_C13_max_lres > 162.5) => 0.1901391916, 0.0528502315)), -0.0008895960);

// Tree: 724
final_score_724 := map(
( NULL < rv_C14_addrs_per_adl_c6 and rv_C14_addrs_per_adl_c6 <= 0.5) => -0.0007551505, 
(rv_C14_addrs_per_adl_c6 > 0.5) => map(
   ( NULL < nf_fp_curraddrcartheftindex and nf_fp_curraddrcartheftindex <= 192.5) => 0.0077189955, 
   (nf_fp_curraddrcartheftindex > 192.5) => map(
      ( NULL < nf_lowest_rel_home_val and nf_lowest_rel_home_val <= 75) => 0.1243862908, 
      (nf_lowest_rel_home_val > 75) => -0.0067951136, 0.0739959736), 0.0100361152), 0.0004963530);

// Tree: 725
final_score_725 := map(
( NULL < nf_fp_srchssnsrchcountmo and nf_fp_srchssnsrchcountmo <= 5.5) => 0.0000301521, 
(nf_fp_srchssnsrchcountmo > 5.5) => map(
   ( NULL < iv_fname_non_phn_src_ct and iv_fname_non_phn_src_ct <= 3.5) => 0.0926637266, 
   (iv_fname_non_phn_src_ct > 3.5) => map(
      ( NULL < rv_C13_max_lres and rv_C13_max_lres <= 37.5) => 0.0628465340, 
      (rv_C13_max_lres > 37.5) => 0.0034936205, 0.0074100537), 0.0109245928), 0.0003736926);

// Tree: 726
final_score_726 := map(
( NULL < nf_M_Bureau_ADL_FS_all and nf_M_Bureau_ADL_FS_all <= 25.5) => -0.0276440347, 
(nf_M_Bureau_ADL_FS_all > 25.5) => map(
   ( NULL < nf_M_Bureau_ADL_FS_noTU and nf_M_Bureau_ADL_FS_noTU <= 26.5) => map(
      ( NULL < nf_add_input_nhood_MFD_pct and nf_add_input_nhood_MFD_pct <= 0.36440318305) => 0.0850401042, 
      (nf_add_input_nhood_MFD_pct > 0.36440318305) => -0.0244743379, 0.0523924026), 
   (nf_M_Bureau_ADL_FS_noTU > 26.5) => -0.0004241737, -0.0002425179), -0.0004689505);

// Tree: 727
final_score_727 := map(
( NULL < nf_fp_srchaddrsrchcountwk and nf_fp_srchaddrsrchcountwk <= 5.5) => 0.0006773409, 
(nf_fp_srchaddrsrchcountwk > 5.5) => map(
   (iv_Phn_Addr_Verified in ['0 NONE VERD','1 INF ONLY','2 NAP ONLY']) => map(
      ( NULL < nf_hh_workers_paw_pct and nf_hh_workers_paw_pct <= 0.09545454545) => 0.0020881944, 
      (nf_hh_workers_paw_pct > 0.09545454545) => -0.0976695354, -0.0616125246), 
   (iv_Phn_Addr_Verified in ['3 BOTH VERD']) => 0.0597376917, -0.0326666015), 0.0005837770);

// Tree: 728
final_score_728 := map(
( NULL < rv_I61_inq_collection_count12 and rv_I61_inq_collection_count12 <= 1.5) => -0.0006840773, 
(rv_I61_inq_collection_count12 > 1.5) => map(
   ( NULL < rv_C13_inp_addr_lres and rv_C13_inp_addr_lres <= 207.5) => map(
      ( NULL < rv_comb_age and rv_comb_age <= 70.5) => 0.0154508821, 
      (rv_comb_age > 70.5) => 0.2242449082, 0.0176683208), 
   (rv_C13_inp_addr_lres > 207.5) => -0.0305504709, 0.0125753025), 0.0002144674);

// Tree: 729
final_score_729 := map(
( NULL < nf_phones_per_addr_c6 and nf_phones_per_addr_c6 <= 16.5) => map(
   ( NULL < iv_src_voter_adl_count and iv_src_voter_adl_count <= 5.5) => 0.0013364980, 
   (iv_src_voter_adl_count > 5.5) => -0.0171700641, 0.0002080520), 
(nf_phones_per_addr_c6 > 16.5) => map(
   ( NULL < nf_fp_curraddrmedianincome and nf_fp_curraddrmedianincome <= 49232) => 0.1908446910, 
   (nf_fp_curraddrmedianincome > 49232) => -0.0004261363, 0.0523934227), 0.0003685851);

// Tree: 730
final_score_730 := map(
( NULL < nf_fp_srchssnsrchcountmo and nf_fp_srchssnsrchcountmo <= 10.5) => -0.0011882483, 
(nf_fp_srchssnsrchcountmo > 10.5) => map(
   (nf_fp_addrchangeecontraj in ['-1','AA','AD','BC','BD','CE','DC','ED','EE']) => -0.0840684799, 
   (nf_fp_addrchangeecontraj in ['AB','AC','AE','AF','AU','BA','BB','BE','BF','BU','CA','CB','CC','CD','CF','CU','DA','DB','DD','DE','DF','DU','EA','EB','EC','EF','EU','FA','FB','FC','FD','FE','FF','FU','UC','UD','UE','UF','UU']) => map(
      ( NULL < rv_C12_source_profile and rv_C12_source_profile <= 55.7) => -0.0530915228, 
      (rv_C12_source_profile > 55.7) => 0.0543370266, -0.0001911007), -0.0361385490), -0.0012921586);

// Tree: 731
final_score_731 := map(
( NULL < nf_fp_addrchangeincomediff and nf_fp_addrchangeincomediff <= -21244.5) => map(
   (nf_fp_addrchangeecontraj in ['AA','AB','AC','AD','BA','BC','BD','BF','CA','CC','CD','CF','DA','DB','DD','DE','DF','ED','EE','EF','FU']) => 0.0081685151, 
   (nf_fp_addrchangeecontraj in ['-1','AE','AF','AU','BB','BE','BU','CB','CE','CU','DC','DU','EA','EB','EC','EU','FA','FB','FC','FD','FE','FF','UC','UD','UE','UF','UU']) => map(
      (rv_A41_A42_Prop_Owner_History in ['CURRENT','NEVER']) => 0.0507159080, 
      (rv_A41_A42_Prop_Owner_History in ['HISTORICAL']) => 0.2626056119, 0.0889927578), 0.0308843041), 
(nf_fp_addrchangeincomediff > -21244.5) => 0.0010376877, 0.0014614009);

// Tree: 732
final_score_732 := map(
( NULL < nf_historical_count and nf_historical_count <= 29.5) => map(
   ( NULL < rv_D33_Eviction_Recency and rv_D33_Eviction_Recency <= 60.5) => map(
      ( NULL < rv_D33_Eviction_Recency and rv_D33_Eviction_Recency <= 1.5) => 0.0006119912, 
      (rv_D33_Eviction_Recency > 1.5) => 0.0172278210, 0.0015950016), 
   (rv_D33_Eviction_Recency > 60.5) => -0.0092411185, 0.0004170471), 
(nf_historical_count > 29.5) => 0.0927498798, 0.0005026131);

// Tree: 733
final_score_733 := map(
( NULL < rv_C14_addrs_15yr and rv_C14_addrs_15yr <= 13.5) => 0.0006320083, 
(rv_C14_addrs_15yr > 13.5) => map(
   ( NULL < nf_inq_per_phone and nf_inq_per_phone <= 2.5) => -0.0164843904, 
   (nf_inq_per_phone > 2.5) => map(
      ( NULL < nf_add_input_nhood_SFD_pct and nf_add_input_nhood_SFD_pct <= 0.973487415) => -0.0575395905, 
      (nf_add_input_nhood_SFD_pct > 0.973487415) => 0.0752404831, -0.0434301330), -0.0302711927), 0.0002219226);

// Tree: 734
final_score_734 := map(
( NULL < rv_C12_inp_addr_source_count and rv_C12_inp_addr_source_count <= 0.5) => map(
   ( NULL < nf_fp_curraddrmurderindex and nf_fp_curraddrmurderindex <= 17) => -0.0521538378, 
   (nf_fp_curraddrmurderindex > 17) => map(
      ( NULL < nf_fp_prevaddrcrimeindex and nf_fp_prevaddrcrimeindex <= 193.5) => 0.0202982748, 
      (nf_fp_prevaddrcrimeindex > 193.5) => 0.1273598511, 0.0228714285), 0.0138865364), 
(rv_C12_inp_addr_source_count > 0.5) => -0.0009616690, -0.0004556344);

// Tree: 735
final_score_735 := map(
( NULL < nf_inq_adls_per_addr and nf_inq_adls_per_addr <= 1.5) => map(
   ( NULL < rv_D32_Mos_Since_Fel_LS and rv_D32_Mos_Since_Fel_LS <= 21.5) => 0.0023305462, 
   (rv_D32_Mos_Since_Fel_LS > 21.5) => map(
      ( NULL < rv_C20_M_Bureau_ADL_FS and rv_C20_M_Bureau_ADL_FS <= 232.5) => 0.0814874472, 
      (rv_C20_M_Bureau_ADL_FS > 232.5) => 0.0103081471, 0.0361426001), 0.0027070264), 
(nf_inq_adls_per_addr > 1.5) => -0.0036161430, 0.0002510545);

// Tree: 736
final_score_736 := map(
( NULL < nf_M_Bureau_ADL_FS_all and nf_M_Bureau_ADL_FS_all <= 18.5) => map(
   (nf_util_add_input_summary in ['|   |','| CM|','|I M|','|IC |','|ICM|']) => -0.0547325568, 
   (nf_util_add_input_summary in ['|  M|','| C |','|I  |']) => 0.0400411280, -0.0356688846), 
(nf_M_Bureau_ADL_FS_all > 18.5) => map(
   ( NULL < nf_inq_count_week and nf_inq_count_week <= 4.5) => 0.0007663353, 
   (nf_inq_count_week > 4.5) => 0.0797614812, 0.0008521263), 0.0006885447);

// Tree: 737
final_score_737 := map(
( NULL < nf_fp_srchssnsrchcountmo and nf_fp_srchssnsrchcountmo <= 13.5) => map(
   ( NULL < nf_hh_age_lt18 and nf_hh_age_lt18 <= 1.5) => 0.0011991636, 
   (nf_hh_age_lt18 > 1.5) => map(
      ( NULL < iv_mos_src_voter_adl_lseen and iv_mos_src_voter_adl_lseen <= 11) => -0.0079490405, 
      (iv_mos_src_voter_adl_lseen > 11) => 0.1599158237, 0.0630538524), 0.0015043100), 
(nf_fp_srchssnsrchcountmo > 13.5) => -0.0710212061, 0.0014511012);

// Tree: 738
final_score_738 := map(
( NULL < nf_fp_srchunvrfdssncount and nf_fp_srchunvrfdssncount <= 0.5) => -0.0027875154, 
(nf_fp_srchunvrfdssncount > 0.5) => map(
   ( NULL < nf_inq_Auto_count24 and nf_inq_Auto_count24 <= 11.5) => 0.0063579655, 
   (nf_inq_Auto_count24 > 11.5) => map(
      ( NULL < iv_A46_L77_addrs_move_traj_index and iv_A46_L77_addrs_move_traj_index <= 2.5) => 0.2067876919, 
      (iv_A46_L77_addrs_move_traj_index > 2.5) => -0.0192402606, 0.1020430310), 0.0071148313), -0.0008055931);

// Tree: 739
final_score_739 := map(
( NULL < rv_C22_inp_addr_occ_index and rv_C22_inp_addr_occ_index <= 5.5) => map(
   ( NULL < iv_C13_avg_lres and iv_C13_avg_lres <= 357) => -0.0007426822, 
   (iv_C13_avg_lres > 357) => map(
      ( NULL < rv_I60_inq_hiRiskCred_recency and rv_I60_inq_hiRiskCred_recency <= 2) => 0.1635009345, 
      (rv_I60_inq_hiRiskCred_recency > 2) => 0.0091203678, 0.0589824142), -0.0006185681), 
(rv_C22_inp_addr_occ_index > 5.5) => -0.0936992788, -0.0008546493);

// Tree: 740
final_score_740 := map(
( NULL < nf_pct_rel_with_criminal and nf_pct_rel_with_criminal <= 0.5505102041) => 0.0020070218, 
(nf_pct_rel_with_criminal > 0.5505102041) => map(
   (rv_E58_br_dead_bus_x_active_phn in ['0-0','0-3','1-3','2-0','2-2','2-3','3-0','3-1','3-3']) => -0.0148632476, 
   (rv_E58_br_dead_bus_x_active_phn in ['0-1','0-2','1-0','1-1','1-2','2-1','3-2']) => map(
      ( NULL < nf_pct_rel_with_felony and nf_pct_rel_with_felony <= 0.1091269841) => -0.0054371621, 
      (nf_pct_rel_with_felony > 0.1091269841) => 0.0931567126, 0.0298951139), -0.0108558527), 0.0009234019);

// Tree: 741
final_score_741 := map(
( NULL < nf_inq_per_addr and nf_inq_per_addr <= 41.5) => map(
   ( NULL < nf_pct_rel_with_criminal and nf_pct_rel_with_criminal <= 0.065942029) => -0.0099720103, 
   (nf_pct_rel_with_criminal > 0.065942029) => 0.0011663628, -0.0009989530), 
(nf_inq_per_addr > 41.5) => map(
   ( NULL < nf_fp_prevaddrageoldest and nf_fp_prevaddrageoldest <= 111.5) => -0.0944328628, 
   (nf_fp_prevaddrageoldest > 111.5) => 0.0344023840, -0.0528731058), -0.0011024436);

// Tree: 742
final_score_742 := map(
( NULL < nf_Inq_Per_SSN_NAS_479 and nf_Inq_Per_SSN_NAS_479 <= 9.5) => 0.0004849173, 
(nf_Inq_Per_SSN_NAS_479 > 9.5) => map(
   (nf_fp_addrchangeecontraj in ['AB','BA','BB','BE','CB','CC','CD','DD','DF','EA','EB','EC','ED','EF','EU','FC','FD']) => -0.1104060903, 
   (nf_fp_addrchangeecontraj in ['-1','AA','AC','AD','AE','AF','AU','BC','BD','BF','BU','CA','CE','CF','CU','DA','DB','DC','DE','DU','EE','FA','FB','FE','FF','FU','UC','UD','UE','UF','UU']) => map(
      ( NULL < nf_highest_rel_home_val and nf_highest_rel_home_val <= 625) => -0.0369943971, 
      (nf_highest_rel_home_val > 625) => 0.0893124122, 0.0084397070), -0.0461276241), 0.0003307301);

// Tree: 743
final_score_743 := map(
( NULL < nf_inq_per_apt_addr and nf_inq_per_apt_addr <= 26.5) => map(
   ( NULL < nf_fp_srchaddrsrchcountmo and nf_fp_srchaddrsrchcountmo <= 10.5) => 0.0006927027, 
   (nf_fp_srchaddrsrchcountmo > 10.5) => map(
      ( NULL < nf_fp_prevaddrmedianvalue and nf_fp_prevaddrmedianvalue <= 81694) => 0.0479339039, 
      (nf_fp_prevaddrmedianvalue > 81694) => -0.0420883882, -0.0272223216), 0.0005750711), 
(nf_inq_per_apt_addr > 26.5) => -0.0692927593, 0.0005013320);

// Tree: 744
final_score_744 := map(
(rv_E58_br_dead_bus_x_active_phn in ['0-0','0-1','0-2','0-3','1-0','1-1','1-3','2-0','2-2','2-3','3-0','3-1','3-3']) => 0.0000937805, 
(rv_E58_br_dead_bus_x_active_phn in ['1-2','2-1','3-2']) => map(
   (iv_D34_liens_unrel_x_rel in ['0-0','1-1','1-2','2-2','3-1']) => -0.0067064096, 
   (iv_D34_liens_unrel_x_rel in ['0-1','0-2','1-0','2-0','2-1','3-0','3-2']) => map(
      ( NULL < nf_pct_rel_prop_sold and nf_pct_rel_prop_sold <= 0.2462121212) => 0.0081660596, 
      (nf_pct_rel_prop_sold > 0.2462121212) => 0.2364246604, 0.1360695859), 0.0512027354), 0.0002819157);

// Tree: 745
final_score_745 := map(
( NULL < nf_inq_RetailPayments_count24 and nf_inq_RetailPayments_count24 <= 0.5) => -0.0001769482, 
(nf_inq_RetailPayments_count24 > 0.5) => map(
   ( NULL < nf_fp_curraddrmurderindex and nf_fp_curraddrmurderindex <= 14.5) => map(
      (rv_E58_br_dead_bus_x_active_phn in ['0-0','0-3','1-3']) => 0.0396483507, 
      (rv_E58_br_dead_bus_x_active_phn in ['0-1','0-2','1-0','1-1','1-2','2-0','2-1','2-2','2-3','3-0','3-1','3-2','3-3']) => 0.1654505800, 0.0622282380), 
   (nf_fp_curraddrmurderindex > 14.5) => 0.0100183456, 0.0149577774), 0.0008669536);

// Tree: 746
final_score_746 := map(
( NULL < nf_inq_Other_count24 and nf_inq_Other_count24 <= 33.5) => map(
   ( NULL < rv_C10_M_Hdr_FS and rv_C10_M_Hdr_FS <= 14.5) => map(
      ( NULL < nf_fp_curraddrcartheftindex and nf_fp_curraddrcartheftindex <= 127) => -0.0186090524, 
      (nf_fp_curraddrcartheftindex > 127) => 0.1529233823, 0.0608041118), 
   (rv_C10_M_Hdr_FS > 14.5) => 0.0001162904, 0.0002007485), 
(nf_inq_Other_count24 > 33.5) => 0.0831948093, 0.0002947540);

// Tree: 747
final_score_747 := map(
( NULL < nf_fp_srchssnsrchcountwk and nf_fp_srchssnsrchcountwk <= 2.5) => -0.0000044819, 
(nf_fp_srchssnsrchcountwk > 2.5) => map(
   ( NULL < nf_add_curr_nhood_VAC_pct and nf_add_curr_nhood_VAC_pct <= 0.11901968935) => map(
      ( NULL < iv_dob_src_ct and iv_dob_src_ct <= 15.5) => 0.0029337697, 
      (iv_dob_src_ct > 15.5) => 0.0803283462, 0.0059957103), 
   (nf_add_curr_nhood_VAC_pct > 0.11901968935) => 0.0545791135, 0.0109251049), 0.0003033225);

// Tree: 748
final_score_748 := map(
( NULL < nf_average_rel_distance and nf_average_rel_distance <= 307.5) => map(
   ( NULL < nf_inq_HighRiskCredit_count24 and nf_inq_HighRiskCredit_count24 <= 12.5) => 0.0035060525, 
   (nf_inq_HighRiskCredit_count24 > 12.5) => map(
      (iv_college_file_type in ['-1','A']) => -0.0312072526, 
      (iv_college_file_type in ['C','H']) => 0.0282819154, -0.0097378471), 0.0024622661), 
(nf_average_rel_distance > 307.5) => -0.0091832083, -0.0008030653);

// Tree: 749
final_score_749 := map(
( NULL < nf_inq_per_apt_addr and nf_inq_per_apt_addr <= 16.5) => -0.0011191553, 
(nf_inq_per_apt_addr > 16.5) => map(
   ( NULL < iv_C13_avg_lres and iv_C13_avg_lres <= 28.5) => -0.0766083287, 
   (iv_C13_avg_lres > 28.5) => map(
      ( NULL < rv_C13_Curr_Addr_LRes and rv_C13_Curr_Addr_LRes <= 89) => 0.0962277979, 
      (rv_C13_Curr_Addr_LRes > 89) => -0.0559030134, 0.0557223806), 0.0335535762), -0.0009459992);

// Tree: 750
final_score_750 := map(
( NULL < nf_inq_per_sfd_addr and nf_inq_per_sfd_addr <= 11.5) => -0.0025860844, 
(nf_inq_per_sfd_addr > 11.5) => map(
   ( NULL < iv_lname_non_phn_src_ct and iv_lname_non_phn_src_ct <= 12.5) => map(
      ( NULL < nf_pct_rel_with_felony and nf_pct_rel_with_felony <= 0.09600614435) => 0.0074423862, 
      (nf_pct_rel_with_felony > 0.09600614435) => 0.0330405677, 0.0104892010), 
   (iv_lname_non_phn_src_ct > 12.5) => -0.0113409436, 0.0080431567), -0.0014673825);

// Tree: 751
final_score_751 := map(
( NULL < rv_C13_max_lres and rv_C13_max_lres <= 31.5) => map(
   ( NULL < nf_pct_rel_prop_owned and nf_pct_rel_prop_owned <= 0.89009661835) => -0.0235433170, 
   (nf_pct_rel_prop_owned > 0.89009661835) => map(
      (nf_fp_addrchangeecontraj in ['-1','AA','AC','BB','CC','DD','EC','EE','EF','FE','UU']) => 0.0121125023, 
      (nf_fp_addrchangeecontraj in ['AB','AD','AE','AF','AU','BA','BC','BD','BE','BF','BU','CA','CB','CD','CE','CF','CU','DA','DB','DC','DE','DF','DU','EA','EB','ED','EU','FA','FB','FC','FD','FF','FU','UC','UD','UE','UF']) => 0.2199241702, 0.0757773485), -0.0173935406), 
(rv_C13_max_lres > 31.5) => -0.0002558893, -0.0008721866);

// Tree: 752
final_score_752 := map(
( NULL < nf_fp_srchssnsrchcountmo and nf_fp_srchssnsrchcountmo <= 6.5) => -0.0008692667, 
(nf_fp_srchssnsrchcountmo > 6.5) => map(
   ( NULL < rv_C13_Curr_Addr_LRes and rv_C13_Curr_Addr_LRes <= 169.5) => 0.0076354494, 
   (rv_C13_Curr_Addr_LRes > 169.5) => map(
      ( NULL < iv_prv_addr_lres and iv_prv_addr_lres <= 117.5) => 0.1184970529, 
      (iv_prv_addr_lres > 117.5) => -0.0255444001, 0.0680825444), 0.0158443142), -0.0005381961);

// Tree: 753
final_score_753 := map(
( NULL < nf_liens_unrel_FT_total_amt and nf_liens_unrel_FT_total_amt <= 228031.5) => map(
   ( NULL < rv_I62_inq_ssns_per_adl and rv_I62_inq_ssns_per_adl <= 3.5) => -0.0000330209, 
   (rv_I62_inq_ssns_per_adl > 3.5) => map(
      (nf_fp_addrchangeecontraj in ['AA','BE','CC','EF','FD','FE','FF','FU']) => -0.0367703595, 
      (nf_fp_addrchangeecontraj in ['-1','AB','AC','AD','AE','AF','AU','BA','BB','BC','BD','BF','BU','CA','CB','CD','CE','CF','CU','DA','DB','DC','DD','DE','DF','DU','EA','EB','EC','ED','EE','EU','FA','FB','FC','UC','UD','UE','UF','UU']) => 0.0998413981, 0.0451966950), 0.0000689397), 
(nf_liens_unrel_FT_total_amt > 228031.5) => -0.1218671523, -0.0000330726);

// Tree: 754
final_score_754 := map(
(nf_fp_addrchangeecontraj in ['-1','AA','AB','AD','AF','BB','BC','BD','BE','CA','CC','CD','CE','CF','DA','DB','DC','DD','DF','DU','EB','EC','ED','EE','EF','FB','FC','FE','FF','UC','UE','UF','UU']) => -0.0016158555, 
(nf_fp_addrchangeecontraj in ['AC','AE','AU','BA','BF','BU','CB','CU','DE','EA','EU','FA','FD','FU','UD']) => map(
   ( NULL < iv_dob_src_ct and iv_dob_src_ct <= 10.5) => map(
      ( NULL < nf_fp_addrchangeincomediff and nf_fp_addrchangeincomediff <= -10949.5) => 0.1488369864, 
      (nf_fp_addrchangeincomediff > -10949.5) => 0.0263126756, 0.0599732006), 
   (iv_dob_src_ct > 10.5) => -0.0161047390, 0.0265251409), -0.0013123333);

// Tree: 755
final_score_755 := map(
( NULL < nf_youngest_rel_age and nf_youngest_rel_age <= 55) => map(
   ( NULL < rv_L79_adls_per_addr_c6 and rv_L79_adls_per_addr_c6 <= 12.5) => -0.0015238588, 
   (rv_L79_adls_per_addr_c6 > 12.5) => map(
      ( NULL < nf_fp_srchcomponentrisktype and nf_fp_srchcomponentrisktype <= 3.5) => -0.0137135414, 
      (nf_fp_srchcomponentrisktype > 3.5) => -0.1142140501, -0.0479623181), -0.0016309357), 
(nf_youngest_rel_age > 55) => 0.1327324413, -0.0015427378);

// Tree: 756
final_score_756 := map(
( NULL < nf_fp_srchfraudsrchcountyr and nf_fp_srchfraudsrchcountyr <= 28.5) => 0.0012642747, 
(nf_fp_srchfraudsrchcountyr > 28.5) => map(
   ( NULL < nf_rel_count and nf_rel_count <= 14.5) => -0.0704609205, 
   (nf_rel_count > 14.5) => map(
      ( NULL < iv_prv_addr_lres and iv_prv_addr_lres <= 75.5) => 0.0472878654, 
      (iv_prv_addr_lres > 75.5) => -0.0439550673, 0.0047078301), -0.0409791508), 0.0010549470);

// Tree: 757
final_score_757 := map(
( NULL < rv_D34_unrel_liens_ct and rv_D34_unrel_liens_ct <= 13.5) => map(
   ( NULL < iv_inp_add_avm_chg_3yr and iv_inp_add_avm_chg_3yr <= 88490) => -0.0051098265, 
   (iv_inp_add_avm_chg_3yr > 88490) => 0.0110194263, 0.0013049442), 
(rv_D34_unrel_liens_ct > 13.5) => map(
   ( NULL < nf_mos_liens_unrel_CJ_lseen and nf_mos_liens_unrel_CJ_lseen <= 58.5) => -0.1073026452, 
   (nf_mos_liens_unrel_CJ_lseen > 58.5) => 0.0053364509, -0.0553602641), 0.0003674982);

// Tree: 758
final_score_758 := map(
( NULL < rv_C22_inp_addr_occ_index and rv_C22_inp_addr_occ_index <= 2) => 0.0028661545, 
(rv_C22_inp_addr_occ_index > 2) => map(
   ( NULL < nf_rel_count and nf_rel_count <= 53.5) => -0.0076236067, 
   (nf_rel_count > 53.5) => map(
      ( NULL < iv_A46_L77_addrs_move_traj and iv_A46_L77_addrs_move_traj <= 6) => -0.0196682484, 
      (iv_A46_L77_addrs_move_traj > 6) => 0.1930962644, 0.0800052171), -0.0071237712), 0.0003633356);

// Tree: 759
final_score_759 := map(
( NULL < rv_I60_inq_banking_count12 and rv_I60_inq_banking_count12 <= 3.5) => map(
   ( NULL < rv_F01_inp_addr_address_score and rv_F01_inp_addr_address_score <= 25) => map(
      ( NULL < nf_fp_assocsuspicousidcount and nf_fp_assocsuspicousidcount <= 6.5) => 0.0108704431, 
      (nf_fp_assocsuspicousidcount > 6.5) => 0.1613758054, 0.0176011177), 
   (rv_F01_inp_addr_address_score > 25) => -0.0001577579, 0.0002124822), 
(rv_I60_inq_banking_count12 > 3.5) => -0.0541970145, -0.0000984532);

// Tree: 760
final_score_760 := map(
( NULL < iv_inp_add_avm_pct_chg_2yr and iv_inp_add_avm_pct_chg_2yr <= 0.74744933665) => -0.0277507849, 
(iv_inp_add_avm_pct_chg_2yr > 0.74744933665) => -0.0001293975, map(
   ( NULL < nf_liens_unrel_CJ_total_amt and nf_liens_unrel_CJ_total_amt <= 4185) => -0.0010861307, 
   (nf_liens_unrel_CJ_total_amt > 4185) => map(
      ( NULL < iv_mos_src_voter_adl_lseen and iv_mos_src_voter_adl_lseen <= 139.5) => 0.0169918203, 
      (iv_mos_src_voter_adl_lseen > 139.5) => 0.1404907341, 0.0188575606), 0.0005600637));

// Tree: 761
final_score_761 := map(
( NULL < nf_fp_srchfraudsrchcountmo and nf_fp_srchfraudsrchcountmo <= 12.5) => map(
   ( NULL < nf_fp_srchfraudsrchcountmo and nf_fp_srchfraudsrchcountmo <= 11.5) => 0.0016545834, 
   (nf_fp_srchfraudsrchcountmo > 11.5) => -0.0802473633, 0.0015891100), 
(nf_fp_srchfraudsrchcountmo > 12.5) => map(
   ( NULL < nf_hh_pct_property_owners and nf_hh_pct_property_owners <= 0.4365079365) => 0.0921076637, 
   (nf_hh_pct_property_owners > 0.4365079365) => -0.0426341712, 0.0436393778), 0.0016643389);

// Tree: 762
final_score_762 := map(
( NULL < nf_fp_srchfraudsrchcountmo and nf_fp_srchfraudsrchcountmo <= 1.5) => map(
   ( NULL < nf_fp_srchaddrsrchcountwk and nf_fp_srchaddrsrchcountwk <= 1.5) => 0.0008422720, 
   (nf_fp_srchaddrsrchcountwk > 1.5) => 0.0474248297, 0.0012364131), 
(nf_fp_srchfraudsrchcountmo > 1.5) => map(
   ( NULL < nf_inq_Communications_count24 and nf_inq_Communications_count24 <= 4.5) => -0.0041592382, 
   (nf_inq_Communications_count24 > 4.5) => -0.0498171174, -0.0047917145), -0.0000966447);

// Tree: 763
final_score_763 := map(
( NULL < nf_inq_HighRiskCredit_count24 and nf_inq_HighRiskCredit_count24 <= 1.5) => map(
   ( NULL < nf_M_Bureau_ADL_FS_noTU and nf_M_Bureau_ADL_FS_noTU <= 48.5) => map(
      ( NULL < rv_A49_Curr_AVM_Chg_1yr and rv_A49_Curr_AVM_Chg_1yr <= 9091) => 0.0471801969, 
      (rv_A49_Curr_AVM_Chg_1yr > 9091) => -0.0383999607, 0.0370748365), 
   (nf_M_Bureau_ADL_FS_noTU > 48.5) => -0.0070421363, -0.0059335400), 
(nf_inq_HighRiskCredit_count24 > 1.5) => 0.0048591308, 0.0002236791);

// Tree: 764
final_score_764 := map(
( NULL < nf_add_input_mobility_index and nf_add_input_mobility_index <= 0.4698299896) => 0.0007355983, 
(nf_add_input_mobility_index > 0.4698299896) => map(
   ( NULL < nf_fp_srchphonesrchcountmo and nf_fp_srchphonesrchcountmo <= 0.5) => map(
      ( NULL < nf_fp_srchssnsrchcountwk and nf_fp_srchssnsrchcountwk <= 0.5) => -0.0068826451, 
      (nf_fp_srchssnsrchcountwk > 0.5) => 0.0632192945, -0.0047003412), 
   (nf_fp_srchphonesrchcountmo > 0.5) => -0.0212139045, -0.0102985132), -0.0005001665);

// Tree: 765
final_score_765 := map(
( NULL < nf_pct_rel_with_felony and nf_pct_rel_with_felony <= 0.541958042) => map(
   ( NULL < nf_pct_rel_with_felony and nf_pct_rel_with_felony <= 0.32795698925) => 0.0007240213, 
   (nf_pct_rel_with_felony > 0.32795698925) => map(
      ( NULL < nf_mos_acc_lseen and nf_mos_acc_lseen <= 50.5) => -0.0466868527, 
      (nf_mos_acc_lseen > 50.5) => 0.1393861152, -0.0322849202), 0.0004493436), 
(nf_pct_rel_with_felony > 0.541958042) => 0.0898585402, 0.0005195425);

// Tree: 766
final_score_766 := map(
( NULL < rv_D32_Mos_Since_Crim_LS and rv_D32_Mos_Since_Crim_LS <= 217.5) => 0.0018104988, 
(rv_D32_Mos_Since_Crim_LS > 217.5) => map(
   ( NULL < nf_fp_srchaddrsrchcountwk and nf_fp_srchaddrsrchcountwk <= 2.5) => map(
      ( NULL < rv_S66_adlperssn_count and rv_S66_adlperssn_count <= 4.5) => -0.0290942881, 
      (rv_S66_adlperssn_count > 4.5) => 0.1511255451, -0.0233542227), 
   (nf_fp_srchaddrsrchcountwk > 2.5) => -0.0950988942, -0.0255346980), 0.0010925185);

// Tree: 767
final_score_767 := map(
( NULL < iv_full_name_non_phn_src_ct and iv_full_name_non_phn_src_ct <= 0.5) => 0.1124811253, 
(iv_full_name_non_phn_src_ct > 0.5) => map(
   ( NULL < nf_fp_prevaddrmedianincome and nf_fp_prevaddrmedianincome <= 77725.5) => -0.0049852960, 
   (nf_fp_prevaddrmedianincome > 77725.5) => map(
      ( NULL < nf_historical_count and nf_historical_count <= 5.5) => 0.0017149549, 
      (nf_historical_count > 5.5) => 0.0338012828, 0.0073047036), -0.0026406028), -0.0025175969);

// Tree: 768
final_score_768 := map(
( NULL < rv_C14_addrs_10yr and rv_C14_addrs_10yr <= 11.5) => 0.0001632782, 
(rv_C14_addrs_10yr > 11.5) => map(
   ( NULL < nf_add_curr_mobility_index and nf_add_curr_mobility_index <= 0.56739930645) => map(
      ( NULL < nf_inq_HighRiskCredit_count_week and nf_inq_HighRiskCredit_count_week <= 0.5) => 0.0020634008, 
      (nf_inq_HighRiskCredit_count_week > 0.5) => 0.0812237490, 0.0123173319), 
   (nf_add_curr_mobility_index > 0.56739930645) => 0.1544772197, 0.0240325683), 0.0003574348);

// Tree: 769
final_score_769 := map(
( NULL < nf_inq_HighRiskCredit_count_week and nf_inq_HighRiskCredit_count_week <= 3.5) => 0.0024383318, 
(nf_inq_HighRiskCredit_count_week > 3.5) => map(
   ( NULL < nf_add_input_mobility_index and nf_add_input_mobility_index <= 0.36587822335) => map(
      ( NULL < nf_inq_HighRiskCredit_count24 and nf_inq_HighRiskCredit_count24 <= 6.5) => 0.0410707928, 
      (nf_inq_HighRiskCredit_count24 > 6.5) => -0.0259605049, 0.0031916107), 
   (nf_add_input_mobility_index > 0.36587822335) => -0.0650990249, -0.0201938893), 0.0022784125);

// Tree: 770
final_score_770 := map(
( NULL < nf_fp_srchfraudsrchcountmo and nf_fp_srchfraudsrchcountmo <= 9.5) => -0.0008836323, 
(nf_fp_srchfraudsrchcountmo > 9.5) => map(
   (nf_fp_addrchangeecontraj in ['AA','AD','BA','BD','DC','DF','ED','EE','FE','FF']) => -0.0030487479, 
   (nf_fp_addrchangeecontraj in ['-1','AB','AC','AE','AF','AU','BB','BC','BE','BF','BU','CA','CB','CC','CD','CE','CF','CU','DA','DB','DD','DE','DU','EA','EB','EC','EF','EU','FA','FB','FC','FD','FU','UC','UD','UE','UF','UU']) => map(
      ( NULL < nf_inq_count24 and nf_inq_count24 <= 5.5) => 0.1534329944, 
      (nf_inq_count24 > 5.5) => 0.0287230069, 0.0582878746), 0.0269725526), -0.0007136835);

// Tree: 771
final_score_771 := map(
( NULL < nf_fp_srchcomponentrisktype and nf_fp_srchcomponentrisktype <= 3.5) => 0.0010668701, 
(nf_fp_srchcomponentrisktype > 3.5) => map(
   (nf_util_adl_summary in ['|   |','|  M|','| C |','| CM|','|I  |','|I M|']) => -0.0073738480, 
   (nf_util_adl_summary in ['|IC |','|ICM|']) => map(
      ( NULL < nf_fp_srchaddrsrchcountwk and nf_fp_srchaddrsrchcountwk <= 1.5) => 0.0206665796, 
      (nf_fp_srchaddrsrchcountwk > 1.5) => 0.1119283600, 0.0382491245), -0.0059549440), -0.0002000713);

// Tree: 772
final_score_772 := map(
( NULL < nf_hh_lienholders and nf_hh_lienholders <= 3.5) => 0.0001294571, 
(nf_hh_lienholders > 3.5) => map(
   ( NULL < nf_fp_prevaddrlenofres and nf_fp_prevaddrlenofres <= 252.5) => map(
      ( NULL < rv_C13_max_lres and rv_C13_max_lres <= 116.5) => -0.0361682590, 
      (rv_C13_max_lres > 116.5) => 0.0107138244, -0.0064596801), 
   (nf_fp_prevaddrlenofres > 252.5) => -0.0824091965, -0.0180725661), -0.0004436173);

// Tree: 773
final_score_773 := map(
( NULL < nf_fp_srchaddrsrchcountmo and nf_fp_srchaddrsrchcountmo <= 10.5) => 0.0005246130, 
(nf_fp_srchaddrsrchcountmo > 10.5) => map(
   (iv_D34_liens_unrel_x_rel in ['0-0','1-1','2-2','3-0','3-1','3-2']) => map(
      ( NULL < nf_inq_HighRiskCredit_count24 and nf_inq_HighRiskCredit_count24 <= 11.5) => 0.0386864748, 
      (nf_inq_HighRiskCredit_count24 > 11.5) => -0.0596717013, 0.0107994823), 
   (iv_D34_liens_unrel_x_rel in ['0-1','0-2','1-0','1-2','2-0','2-1']) => 0.1166581531, 0.0319062725), 0.0006562939);

// Tree: 774
final_score_774 := map(
( NULL < nf_inq_per_apt_addr and nf_inq_per_apt_addr <= 30.5) => map(
   ( NULL < nf_mos_foreclosure_lseen and nf_mos_foreclosure_lseen <= 36.5) => map(
      ( NULL < nf_highest_rel_income and nf_highest_rel_income <= 62.5) => -0.0130720539, 
      (nf_highest_rel_income > 62.5) => 0.0010192973, 0.0002147500), 
   (nf_mos_foreclosure_lseen > 36.5) => -0.0266151267, -0.0007612715), 
(nf_inq_per_apt_addr > 30.5) => 0.1071710765, -0.0006890360);

// Tree: 775
final_score_775 := map(
( NULL < nf_inq_ssns_per_sfd_addr and nf_inq_ssns_per_sfd_addr <= 5.5) => 0.0006992841, 
(nf_inq_ssns_per_sfd_addr > 5.5) => map(
   ( NULL < nf_add_curr_nhood_BUS_pct and nf_add_curr_nhood_BUS_pct <= 0.12514876465) => map(
      (nf_historic_x_current_ct in ['1-0','1-1','2-1','3-2','3-3']) => -0.0958192422, 
      (nf_historic_x_current_ct in ['0-0','2-0','2-2','3-0','3-1']) => -0.0198174797, -0.0456962161), 
   (nf_add_curr_nhood_BUS_pct > 0.12514876465) => 0.0774480361, -0.0314497336), 0.0004381892);

// Tree: 776
final_score_776 := map(
( NULL < rv_A49_curr_add_avm_pct_chg_3yr and rv_A49_curr_add_avm_pct_chg_3yr <= 0.93377749555) => map(
   ( NULL < nf_add_input_nhood_SFD_pct and nf_add_input_nhood_SFD_pct <= 0.4614866042) => 0.0518208083, 
   (nf_add_input_nhood_SFD_pct > 0.4614866042) => -0.0190690263, -0.0127486216), 
(rv_A49_curr_add_avm_pct_chg_3yr > 0.93377749555) => 0.0041896186, map(
   ( NULL < iv_C13_avg_lres and iv_C13_avg_lres <= 345.5) => -0.0028673524, 
   (iv_C13_avg_lres > 345.5) => 0.1575507687, -0.0026919449));

// Tree: 777
final_score_777 := map(
( NULL < nf_Inq_Per_SSN_NAS_479 and nf_Inq_Per_SSN_NAS_479 <= 1.5) => -0.0011592585, 
(nf_Inq_Per_SSN_NAS_479 > 1.5) => map(
   ( NULL < nf_hh_tot_derog_avg and nf_hh_tot_derog_avg <= 0.68333333335) => map(
      (nf_fp_addrchangeecontraj in ['-1','AA','AB','AC','AE','BA','BB','BC','BU','CA','CD','CE','CF','CU','DD','DE','DU','EA','EB','ED','EF','FB','FC','FD','FE','FF','FU','UD','UE']) => -0.0201921754, 
      (nf_fp_addrchangeecontraj in ['AD','AF','AU','BD','BE','BF','CB','CC','DA','DB','DC','DF','EC','EE','EU','FA','UC','UF','UU']) => 0.0722702762, 0.0032939714), 
   (nf_hh_tot_derog_avg > 0.68333333335) => -0.0481864476, -0.0221086089), -0.0015909342);

// Tree: 778
final_score_778 := map(
( NULL < rv_C10_M_Hdr_FS and rv_C10_M_Hdr_FS <= 19.5) => map(
   ( NULL < rv_L79_adls_per_addr_curr and rv_L79_adls_per_addr_curr <= 5.5) => 0.0057415132, 
   (rv_L79_adls_per_addr_curr > 5.5) => 0.1181476388, 0.0475948578), 
(rv_C10_M_Hdr_FS > 19.5) => map(
   ( NULL < iv_inp_add_avm_chg_3yr and iv_inp_add_avm_chg_3yr <= -7545) => 0.0228434985, 
   (iv_inp_add_avm_chg_3yr > -7545) => -0.0012913132, -0.0019278000), -0.0007289018);

// Tree: 779
final_score_779 := map(
( NULL < iv_college_tier and iv_college_tier <= 4.5) => -0.0010526246, 
(iv_college_tier > 4.5) => map(
   ( NULL < iv_C13_avg_lres and iv_C13_avg_lres <= 27.5) => map(
      ( NULL < rv_P88_Phn_Dst_to_Inp_Add and rv_P88_Phn_Dst_to_Inp_Add <= 5.5) => 0.0218531536, 
      (rv_P88_Phn_Dst_to_Inp_Add > 5.5) => 0.1320445168, 0.0135865650), 
   (iv_C13_avg_lres > 27.5) => 0.0072284681, 0.0117478606), -0.0001489427);

// Tree: 780
final_score_780 := map(
( NULL < nf_phones_per_apt_addr_curr and nf_phones_per_apt_addr_curr <= 41.5) => -0.0012202064, 
(nf_phones_per_apt_addr_curr > 41.5) => map(
   ( NULL < nf_fp_prevaddrburglaryindex and nf_fp_prevaddrburglaryindex <= 178.5) => map(
      ( NULL < nf_fp_prevaddrburglaryindex and nf_fp_prevaddrburglaryindex <= 145.5) => 0.0445128784, 
      (nf_fp_prevaddrburglaryindex > 145.5) => -0.0930517439, 0.0205780847), 
   (nf_fp_prevaddrburglaryindex > 178.5) => 0.1355225594, 0.0341219298), -0.0009267729);

// Tree: 781
final_score_781 := map(
( NULL < nf_liens_rel_CJ_total_amt and nf_liens_rel_CJ_total_amt <= 14479.5) => map(
   ( NULL < rv_email_count and rv_email_count <= 13.5) => 0.0000201532, 
   (rv_email_count > 13.5) => map(
      ( NULL < nf_fp_addrchangevaluediff and nf_fp_addrchangevaluediff <= -1640.5) => 0.0895924168, 
      (nf_fp_addrchangevaluediff > -1640.5) => -0.0237819190, -0.0200070159), -0.0006705546), 
(nf_liens_rel_CJ_total_amt > 14479.5) => -0.0956645476, -0.0009053009);

// Tree: 782
final_score_782 := map(
( NULL < iv_Estimated_Income and iv_Estimated_Income <= 24500) => -0.0132333014, 
(iv_Estimated_Income > 24500) => map(
   ( NULL < nf_add_input_nhood_BUS_pct and nf_add_input_nhood_BUS_pct <= 0.5561906581) => 0.0002351358, 
   (nf_add_input_nhood_BUS_pct > 0.5561906581) => map(
      (nf_util_add_curr_summary in ['| C |','|I M|','|ICM|']) => -0.0980881244, 
      (nf_util_add_curr_summary in ['|   |','|  M|','| CM|','|I  |','|IC |']) => 0.0948533630, 0.0472879269), 0.0004188162), -0.0002678839);

// Tree: 783
final_score_783 := map(
( NULL < nf_inq_Retail_count24 and nf_inq_Retail_count24 <= 0.5) => 0.0020584856, 
(nf_inq_Retail_count24 > 0.5) => map(
   ( NULL < nf_inq_Communications_count24 and nf_inq_Communications_count24 <= 2.5) => -0.0172702219, 
   (nf_inq_Communications_count24 > 2.5) => map(
      ( NULL < nf_fp_prevaddrmedianvalue and nf_fp_prevaddrmedianvalue <= 108923.5) => 0.1416301908, 
      (nf_fp_prevaddrmedianvalue > 108923.5) => -0.0035456915, 0.0431179850), -0.0158047851), 0.0004667409);

// Tree: 784
final_score_784 := map(
( NULL < nf_inq_per_phone and nf_inq_per_phone <= 26.5) => 0.0005690761, 
(nf_inq_per_phone > 26.5) => map(
   ( NULL < nf_util_adl_count and nf_util_adl_count <= 7.5) => map(
      ( NULL < iv_dob_src_ct and iv_dob_src_ct <= 11.5) => -0.0009803717, 
      (iv_dob_src_ct > 11.5) => 0.0567713393, 0.0245636543), 
   (nf_util_adl_count > 7.5) => 0.1102869472, 0.0436776318), 0.0458054277);

// Tree: 785
final_score_785 := map(
( NULL < nf_pct_rel_with_felony and nf_pct_rel_with_felony <= 0.04095610845) => 0.0020558225, 
(nf_pct_rel_with_felony > 0.04095610845) => map(
   ( NULL < nf_fp_srchfraudsrchcountwk and nf_fp_srchfraudsrchcountwk <= 1.5) => -0.0040700194, 
   (nf_fp_srchfraudsrchcountwk > 1.5) => map(
      ( NULL < nf_add_curr_mobility_index and nf_add_curr_mobility_index <= 0.47251225515) => -0.0125564056, 
      (nf_add_curr_mobility_index > 0.47251225515) => -0.0694916927, -0.0215525008), -0.0053638066), 0.0002182481);

// Tree: 786
final_score_786 := map(
( NULL < iv_C13_avg_lres and iv_C13_avg_lres <= 11.5) => map(
   (nf_historic_x_current_ct in ['0-0','1-0','2-0','2-1','3-0','3-2']) => -0.0033621023, 
   (nf_historic_x_current_ct in ['1-1','2-2','3-1','3-3']) => map(
      (nf_fp_addrchangeecontraj in ['AA','BB','BD','CC','CE','ED','FD','FE','FF']) => 0.0049717384, 
      (nf_fp_addrchangeecontraj in ['-1','AB','AC','AD','AE','AF','AU','BA','BC','BE','BF','BU','CA','CB','CD','CF','CU','DA','DB','DC','DD','DE','DF','DU','EA','EB','EC','EE','EF','EU','FA','FB','FC','FU','UC','UD','UE','UF','UU']) => 0.1832695656, 0.1045529717), 0.0286379512), 
(iv_C13_avg_lres > 11.5) => -0.0013471083, -0.0011024300);

// Tree: 787
final_score_787 := map(
( NULL < iv_D34_liens_unrel_FT_ct and iv_D34_liens_unrel_FT_ct <= 2.5) => map(
   ( NULL < nf_add_input_nhood_VAC_pct and nf_add_input_nhood_VAC_pct <= 0.72059616725) => 0.0003802589, 
   (nf_add_input_nhood_VAC_pct > 0.72059616725) => map(
      ( NULL < nf_inq_HighRiskCredit_count_week and nf_inq_HighRiskCredit_count_week <= 0.5) => 0.0536014333, 
      (nf_inq_HighRiskCredit_count_week > 0.5) => -0.0471669380, 0.0424815703), 0.0010181162), 
(iv_D34_liens_unrel_FT_ct > 2.5) => -0.0563244944, 0.0006380021);

// Tree: 788
final_score_788 := map(
( NULL < nf_inq_per_sfd_addr and nf_inq_per_sfd_addr <= 18.5) => 0.0010660720, 
(nf_inq_per_sfd_addr > 18.5) => map(
   ( NULL < nf_fp_curraddrmurderindex and nf_fp_curraddrmurderindex <= 108) => 0.0021087985, 
   (nf_fp_curraddrmurderindex > 108) => map(
      (iv_curr_add_mortgage_type in ['CONVENTIONAL','GOVERNMENT','NO MORTGAGE']) => -0.0539230456, 
      (iv_curr_add_mortgage_type in ['COMMERCIAL','NON-TRADITIONAL','OTHER','UNKNOWN']) => 0.0338193216, -0.0395390510), -0.0123722493), 0.0005805663);

// Tree: 789
final_score_789 := map(
( NULL < nf_inq_lnames_per_sfd_addr and nf_inq_lnames_per_sfd_addr <= 5.5) => map(
   (nf_fp_addrchangeecontraj in ['-1','AA','AC','AD','AE','BA','BB','BC','BD','BE','BU','CA','CB','CC','CD','CE','CF','DA','DB','DC','DD','DE','DF','EA','EC','ED','EE','EF','EU','FB','FC','FD','FE','FF','UC','UD','UE','UF']) => map(
      ( NULL < nf_fp_srchfraudsrchcountmo and nf_fp_srchfraudsrchcountmo <= 1.5) => 0.0025465414, 
      (nf_fp_srchfraudsrchcountmo > 1.5) => -0.0047620043, 0.0009580476), 
   (nf_fp_addrchangeecontraj in ['AB','AF','AU','BF','CU','DU','EB','FA','FU','UU']) => 0.0891061134, 0.0011093796), 
(nf_inq_lnames_per_sfd_addr > 5.5) => -0.0686767384, 0.0009216449);

// Tree: 790
final_score_790 := map(
( NULL < nf_current_count and nf_current_count <= 7.5) => 0.0007744720, 
(nf_current_count > 7.5) => map(
   ( NULL < nf_fp_srchfraudsrchcountmo and nf_fp_srchfraudsrchcountmo <= 3.5) => -0.0164487379, 
   (nf_fp_srchfraudsrchcountmo > 3.5) => map(
      ( NULL < nf_inq_Other_count24 and nf_inq_Other_count24 <= 4.5) => -0.0313208645, 
      (nf_inq_Other_count24 > 4.5) => -0.1363513595, -0.0777945348), -0.0217202779), 0.0003937301);

// Tree: 791
final_score_791 := map(
( NULL < rv_C10_M_Hdr_FS and rv_C10_M_Hdr_FS <= 14.5) => map(
   (nf_fp_addrchangeecontraj in ['BD','CC','DB','DD','EE','FB','FE']) => -0.0258466972, 
   (nf_fp_addrchangeecontraj in ['-1','AA','AB','AC','AD','AE','AF','AU','BA','BB','BC','BE','BF','BU','CA','CB','CD','CE','CF','CU','DA','DC','DE','DF','DU','EA','EB','EC','ED','EF','EU','FA','FC','FD','FF','FU','UC','UD','UE','UF','UU']) => 0.1435057008, 0.0572011133), 
(rv_C10_M_Hdr_FS > 14.5) => map(
   (nf_fp_addrchangeecontraj in ['AD','BC','BE','BF','CA','CB','CF','DU','EB','FA','UD','UE','UF']) => -0.0723311861, 
   (nf_fp_addrchangeecontraj in ['-1','AA','AB','AC','AE','AF','AU','BA','BB','BD','BU','CC','CD','CE','CU','DA','DB','DC','DD','DE','DF','EA','EC','ED','EE','EF','EU','FB','FC','FD','FE','FF','FU','UC','UU']) => 0.0001297931, -0.0001951776), -0.0001183537);

// Tree: 792
final_score_792 := map(
( NULL < rv_email_count and rv_email_count <= 13.5) => 0.0017882295, 
(rv_email_count > 13.5) => map(
   ( NULL < rv_L79_adls_per_sfd_addr and rv_L79_adls_per_sfd_addr <= 8.5) => map(
      ( NULL < rv_D32_criminal_count and rv_D32_criminal_count <= 6.5) => -0.0284168656, 
      (rv_D32_criminal_count > 6.5) => 0.1146747959, -0.0251065361), 
   (rv_L79_adls_per_sfd_addr > 8.5) => 0.0845435564, -0.0212764825), 0.0009632493);

// Tree: 793
final_score_793 := map(
( NULL < nf_liens_unrel_ST_ct and nf_liens_unrel_ST_ct <= 2.5) => 0.0007391717, 
(nf_liens_unrel_ST_ct > 2.5) => map(
   ( NULL < nf_inq_Other_count_week and nf_inq_Other_count_week <= 0.5) => map(
      ( NULL < rv_mos_since_br_first_seen and rv_mos_since_br_first_seen <= 35.5) => -0.0394998823, 
      (rv_mos_since_br_first_seen > 35.5) => 0.0826121214, -0.0223962466), 
   (nf_inq_Other_count_week > 0.5) => -0.1098305259, -0.0308825149), 0.0004624097);

// Tree: 794
final_score_794 := map(
(iv_curr_add_financing_type in ['ADJ']) => -0.0295511399, 
(iv_curr_add_financing_type in ['CNV','NONE','OTH']) => map(
   ( NULL < rv_I60_inq_other_recency and rv_I60_inq_other_recency <= 2) => map(
      ( NULL < rv_L79_adls_per_addr_c6 and rv_L79_adls_per_addr_c6 <= 12.5) => 0.0048628129, 
      (rv_L79_adls_per_addr_c6 > 12.5) => -0.0782314910, 0.0045575062), 
   (rv_I60_inq_other_recency > 2) => -0.0024638235, -0.0001942111), -0.0009098651);

// Tree: 795
final_score_795 := map(
( NULL < nf_fp_srchssnsrchcountday and nf_fp_srchssnsrchcountday <= 2.5) => -0.0008609639, 
(nf_fp_srchssnsrchcountday > 2.5) => map(
   ( NULL < nf_add_curr_nhood_BUS_pct and nf_add_curr_nhood_BUS_pct <= 0.03100670855) => 0.0636334793, 
   (nf_add_curr_nhood_BUS_pct > 0.03100670855) => map(
      ( NULL < nf_average_rel_age and nf_average_rel_age <= 35.5) => -0.0935645056, 
      (nf_average_rel_age > 35.5) => 0.0100988428, -0.0086833667), 0.0238730678), -0.0006947842);

// Tree: 796
final_score_796 := map(
( NULL < rv_I62_inq_addrs_per_adl and rv_I62_inq_addrs_per_adl <= 3.5) => -0.0010825344, 
(rv_I62_inq_addrs_per_adl > 3.5) => map(
   ( NULL < nf_fp_prevaddrmedianvalue and nf_fp_prevaddrmedianvalue <= 24837) => 0.0907054372, 
   (nf_fp_prevaddrmedianvalue > 24837) => map(
      ( NULL < nf_inq_adls_per_apt_addr and nf_inq_adls_per_apt_addr <= 2.5) => -0.0165711144, 
      (nf_inq_adls_per_apt_addr > 2.5) => -0.1028580209, -0.0201808025), -0.0170221958), -0.0015579196);

// Tree: 797
final_score_797 := map(
( NULL < nf_mos_liens_rel_CJ_lseen and nf_mos_liens_rel_CJ_lseen <= 149.5) => -0.0001615014, 
(nf_mos_liens_rel_CJ_lseen > 149.5) => map(
   ( NULL < nf_fp_srchfraudsrchcountyr and nf_fp_srchfraudsrchcountyr <= 10.5) => 0.0234273446, 
   (nf_fp_srchfraudsrchcountyr > 10.5) => map(
      ( NULL < nf_pct_rel_prop_sold and nf_pct_rel_prop_sold <= 0.1311827957) => 0.1972253073, 
      (nf_pct_rel_prop_sold > 0.1311827957) => 0.0433132151, 0.1067578943), 0.0304610444), 0.0004502007);

// Tree: 798
final_score_798 := map(
( NULL < nf_mos_liens_unrel_FT_lseen and nf_mos_liens_unrel_FT_lseen <= 263.5) => map(
   ( NULL < nf_fp_prevaddrlenofres and nf_fp_prevaddrlenofres <= 21.5) => map(
      (nf_fp_addrchangeecontraj in ['-1','AA','AC','AD','AE','AF','BB','BC','BD','CA','CB','CC','CD','CE','CU','DA','DB','DC','DD','DE','EB','EC','ED','EE','EF','FA','FB','FC','FD','FE','FF','FU','UC','UF']) => 0.0060889278, 
      (nf_fp_addrchangeecontraj in ['AB','AU','BA','BE','BF','BU','CF','DF','DU','EA','EU','UD','UE','UU']) => 0.1268074265, 0.0069335252), 
   (nf_fp_prevaddrlenofres > 21.5) => -0.0000615712, 0.0016000143), 
(nf_mos_liens_unrel_FT_lseen > 263.5) => 0.1446150326, 0.0017307090);

// Tree: 799
final_score_799 := map(
( NULL < nf_fp_curraddrmedianvalue and nf_fp_curraddrmedianvalue <= 57625.5) => map(
   ( NULL < nf_fp_prevaddrmurderindex and nf_fp_prevaddrmurderindex <= 152.5) => map(
      ( NULL < rv_C20_M_Bureau_ADL_FS and rv_C20_M_Bureau_ADL_FS <= 37.5) => -0.0680331197, 
      (rv_C20_M_Bureau_ADL_FS > 37.5) => 0.0361659197, 0.0318598386), 
   (nf_fp_prevaddrmurderindex > 152.5) => -0.0045804378, 0.0169513081), 
(nf_fp_curraddrmedianvalue > 57625.5) => -0.0003280033, 0.0006374444);

// Tree: 800
final_score_800 := map(
( NULL < rv_D32_attr_felonies_recency and rv_D32_attr_felonies_recency <= 2) => 0.0021946121, 
(rv_D32_attr_felonies_recency > 2) => map(
   ( NULL < nf_fp_srchssnsrchcountmo and nf_fp_srchssnsrchcountmo <= 4.5) => -0.0276531030, 
   (nf_fp_srchssnsrchcountmo > 4.5) => map(
      ( NULL < nf_average_rel_education and nf_average_rel_education <= 14.5) => 0.1042366622, 
      (nf_average_rel_education > 14.5) => -0.0177525753, 0.0399150642), -0.0214799316), 0.0018277397);

// Tree: 801
final_score_801 := map(
( NULL < rv_C13_Curr_Addr_LRes and rv_C13_Curr_Addr_LRes <= 38.5) => map(
   ( NULL < nf_add_input_mobility_index and nf_add_input_mobility_index <= 0.4236860456) => -0.0094039031, 
   (nf_add_input_mobility_index > 0.4236860456) => map(
      (nf_fp_addrchangeecontraj in ['-1','AA','AB','AC','AD','AF','BA','BB','BD','BE','CA','CB','CC','CD','CE','DA','DC','DF','EA','EB','EC','EF','FD','UE','UU']) => -0.0218577058, 
      (nf_fp_addrchangeecontraj in ['AE','AU','BC','BF','BU','CF','CU','DB','DD','DE','DU','ED','EE','EU','FA','FB','FC','FE','FF','FU','UC','UD','UF']) => 0.0177518065, 0.0044412257), -0.0065455309), 
(rv_C13_Curr_Addr_LRes > 38.5) => 0.0029178626, -0.0008536588);

// Tree: 802
final_score_802 := map(
( NULL < nf_liens_unrel_SC_total_amt and nf_liens_unrel_SC_total_amt <= 105.5) => -0.0030873729, 
(nf_liens_unrel_SC_total_amt > 105.5) => map(
   ( NULL < nf_inq_Other_count_week and nf_inq_Other_count_week <= 0.5) => 0.0172114479, 
   (nf_inq_Other_count_week > 0.5) => map(
      ( NULL < rv_email_domain_free_count and rv_email_domain_free_count <= 2.5) => -0.0514445182, 
      (rv_email_domain_free_count > 2.5) => 0.0066154328, -0.0263799775), 0.0132082590), -0.0013150826);

// Tree: 803
final_score_803 := map(
( NULL < nf_phones_per_addr_curr and nf_phones_per_addr_curr <= 6.5) => map(
   (nf_fp_addrchangeecontraj in ['-1','AA','AB','AC','AD','AE','BB','BC','BD','BE','CA','CB','CC','CD','CF','DA','DC','DD','DE','DF','EB','ED','EE','EF','EU','FB','FD','FE','FF','FU','UC','UD','UE','UF','UU']) => -0.0038145565, 
   (nf_fp_addrchangeecontraj in ['AF','AU','BA','BF','BU','CE','CU','DB','DU','EA','EC','FA','FC']) => map(
      ( NULL < nf_pct_rel_with_criminal and nf_pct_rel_with_criminal <= 0.41277890465) => 0.0227401639, 
      (nf_pct_rel_with_criminal > 0.41277890465) => 0.1846540459, 0.0578986069), -0.0033971809), 
(nf_phones_per_addr_curr > 6.5) => 0.0046937943, -0.0006966136);

// Tree: 804
final_score_804 := map(
( NULL < rv_I60_inq_hiRiskCred_count12 and rv_I60_inq_hiRiskCred_count12 <= 14.5) => map(
   ( NULL < nf_inq_per_sfd_addr and nf_inq_per_sfd_addr <= 12.5) => 0.0001626623, 
   (nf_inq_per_sfd_addr > 12.5) => map(
      (nf_util_adl_summary in ['|   |','| C |','| CM|','|IC |','|ICM|']) => 0.0059621971, 
      (nf_util_adl_summary in ['|  M|','|I  |','|I M|']) => 0.0464215490, 0.0111741827), 0.0011017060), 
(rv_I60_inq_hiRiskCred_count12 > 14.5) => -0.0220068096, 0.0008197497);

// Tree: 805
final_score_805 := map(
( NULL < nf_fp_srchaddrsrchcountwk and nf_fp_srchaddrsrchcountwk <= 3.5) => -0.0001945254, 
(nf_fp_srchaddrsrchcountwk > 3.5) => map(
   ( NULL < nf_average_rel_distance and nf_average_rel_distance <= 63.5) => map(
      (rv_6seg_RiskView_5_0 in ['1 VER/VAL PROBLEMS','4 SUFFICIENTLY VERD - DEROG']) => -0.0191487406, 
      (rv_6seg_RiskView_5_0 in ['0 TRUEDID = 0','2 ADDR NOT CURRENT - DEROG','3 ADDR NOT CURRENT - OTHER','5 SUFFICIENTLY VERD - OWNER','6 SUFFICIENTLY VERD - OTHER']) => 0.0707679421, 0.0242438874), 
   (nf_average_rel_distance > 63.5) => -0.0309512260, -0.0185692865), -0.0004064363);

// Tree: 806
final_score_806 := map(
( NULL < rv_A49_curr_add_avm_pct_chg_2yr and rv_A49_curr_add_avm_pct_chg_2yr <= 2.0143951947) => map(
   ( NULL < nf_phones_per_sfd_addr_c6 and nf_phones_per_sfd_addr_c6 <= 2.5) => 0.0042505968, 
   (nf_phones_per_sfd_addr_c6 > 2.5) => 0.0893342815, 0.0046000817), 
(rv_A49_curr_add_avm_pct_chg_2yr > 2.0143951947) => -0.0312156158, map(
   ( NULL < rv_A49_Curr_AVM_Chg_1yr_Pct and rv_A49_Curr_AVM_Chg_1yr_Pct <= 145.1) => -0.0026243349, 
   (rv_A49_Curr_AVM_Chg_1yr_Pct > 145.1) => -0.0547392868, -0.0010948203));

// Tree: 807
final_score_807 := map(
( NULL < nf_average_rel_income and nf_average_rel_income <= 29500) => -0.0451490026, 
(nf_average_rel_income > 29500) => map(
   ( NULL < nf_inq_per_phone and nf_inq_per_phone <= 8.5) => -0.0012386178, 
   (nf_inq_per_phone > 8.5) => map(
      ( NULL < rv_I60_inq_retpymt_count12 and rv_I60_inq_retpymt_count12 <= 0.5) => 0.0128939148, 
      (rv_I60_inq_retpymt_count12 > 0.5) => -0.0342003695, 0.0099156458), -0.1036304081), -0.0006784274);

// Tree: 808
final_score_808 := map(
( NULL < nf_hh_age_18_plus and nf_hh_age_18_plus <= 7.5) => 0.0008087927, 
(nf_hh_age_18_plus > 7.5) => map(
   ( NULL < nf_fp_srchssnsrchcountmo and nf_fp_srchssnsrchcountmo <= 3.5) => map(
      ( NULL < nf_add_curr_nhood_BUS_pct and nf_add_curr_nhood_BUS_pct <= 0.02964902075) => 0.0142288445, 
      (nf_add_curr_nhood_BUS_pct > 0.02964902075) => -0.0289964690, -0.0094941894), 
   (nf_fp_srchssnsrchcountmo > 3.5) => -0.0485309586, -0.0132451403), 0.0002308919);

// Tree: 809
final_score_809 := map(
( NULL < nf_phones_per_apt_addr_curr and nf_phones_per_apt_addr_curr <= 80.5) => -0.0000882951, 
(nf_phones_per_apt_addr_curr > 80.5) => map(
   (iv_college_major in ['BUSINESS','NO AMS FOUND','SCIENCE']) => map(
      (iv_Phn_Addr_Verified in ['2 NAP ONLY']) => -0.0713645722, 
      (iv_Phn_Addr_Verified in ['0 NONE VERD','1 INF ONLY','3 BOTH VERD']) => 0.1514866144, 0.0236749044), 
   (iv_college_major in ['LIBERAL ARTS','MEDICAL','NO COLLEGE FOUND','UNCLASSIFIED']) => 0.1365005354, 0.0634325077), 0.0000834004);

// Tree: 810
final_score_810 := map(
(nf_fp_addrchangeecontraj in ['AB','AC','AE','AF','BA','BC','BE','BU','CA','CE','DF','EU','FA','UC','UE','UF']) => -0.0417968860, 
(nf_fp_addrchangeecontraj in ['-1','AA','AD','AU','BB','BD','BF','CB','CC','CD','CF','CU','DA','DB','DC','DD','DE','DU','EA','EB','EC','ED','EE','EF','FB','FC','FD','FE','FF','FU','UD','UU']) => map(
   ( NULL < nf_fp_varrisktype and nf_fp_varrisktype <= 5.5) => -0.0002686208, 
   (nf_fp_varrisktype > 5.5) => map(
      ( NULL < rv_D34_unrel_liens_ct and rv_D34_unrel_liens_ct <= 4.5) => 0.0120936657, 
      (rv_D34_unrel_liens_ct > 4.5) => -0.0567247350, 0.0096980086), 0.0004371850), 0.0000974513);

// Tree: 811
final_score_811 := map(
( NULL < iv_br_source_count and iv_br_source_count <= 3.5) => 0.0003762394, 
(iv_br_source_count > 3.5) => map(
   ( NULL < rv_I60_inq_hiRiskCred_recency and rv_I60_inq_hiRiskCred_recency <= 0.5) => map(
      ( NULL < iv_Phn_Cell and iv_Phn_Cell <= 0.5) => 0.1962132294, 
      (iv_Phn_Cell > 0.5) => -0.0287081995, 0.0938236237), 
   (rv_I60_inq_hiRiskCred_recency > 0.5) => 0.0169622316, 0.0222143614), 0.0009274133);

// Tree: 812
final_score_812 := map(
( NULL < rv_I62_inq_phones_per_adl and rv_I62_inq_phones_per_adl <= 4.5) => -0.0001893843, 
(rv_I62_inq_phones_per_adl > 4.5) => map(
   ( NULL < nf_fp_curraddrcrimeindex and nf_fp_curraddrcrimeindex <= 86.5) => 0.0584477038, 
   (nf_fp_curraddrcrimeindex > 86.5) => map(
      ( NULL < nf_rel_bankrupt_count and nf_rel_bankrupt_count <= 4.5) => -0.0270256383, 
      (nf_rel_bankrupt_count > 4.5) => 0.1005644629, -0.0056260328), 0.0241883117), -0.0000039466);

// Tree: 813
final_score_813 := map(
( NULL < nf_inq_HighRiskCredit_count_week and nf_inq_HighRiskCredit_count_week <= 0.5) => 0.0001766454, 
(nf_inq_HighRiskCredit_count_week > 0.5) => map(
   ( NULL < nf_inq_HighRiskCredit_count24 and nf_inq_HighRiskCredit_count24 <= 3.5) => 0.0046358033, 
   (nf_inq_HighRiskCredit_count24 > 3.5) => map(
      ( NULL < nf_fp_curraddrcartheftindex and nf_fp_curraddrcartheftindex <= 193.5) => -0.0157208094, 
      (nf_fp_curraddrcartheftindex > 193.5) => 0.0643266290, -0.0141637851), -0.0064291750), -0.0005288891);

// Tree: 814
final_score_814 := map(
( NULL < iv_dob_src_ct and iv_dob_src_ct <= 15.5) => -0.0008948195, 
(iv_dob_src_ct > 15.5) => map(
   ( NULL < nf_inq_per_ssn and nf_inq_per_ssn <= 16.5) => 0.0123834278, 
   (nf_inq_per_ssn > 16.5) => map(
      ( NULL < rv_I62_inq_num_names_per_adl and rv_I62_inq_num_names_per_adl <= 1.5) => 0.1525327448, 
      (rv_I62_inq_num_names_per_adl > 1.5) => -0.0230000893, 0.0868494908), 0.0161079324), 0.0012432378);

// Tree: 815
final_score_815 := map(
( NULL < nf_fp_srchphonesrchcountday and nf_fp_srchphonesrchcountday <= 0.5) => -0.0018666679, 
(nf_fp_srchphonesrchcountday > 0.5) => map(
   ( NULL < iv_dob_src_ct and iv_dob_src_ct <= 2.5) => map(
      ( NULL < nf_add_input_mobility_index and nf_add_input_mobility_index <= 0.2482669481) => -0.0426369398, 
      (nf_add_input_mobility_index > 0.2482669481) => 0.0574396407, 0.0292301348), 
   (iv_dob_src_ct > 2.5) => 0.0057192523, 0.0088962065), -0.0014030292);

// Tree: 816
final_score_816 := map(
( NULL < nf_hh_lienholders and nf_hh_lienholders <= 3.5) => 0.0003309251, 
(nf_hh_lienholders > 3.5) => map(
   ( NULL < rv_P88_Phn_Dst_to_Inp_Add and rv_P88_Phn_Dst_to_Inp_Add <= 54.5) => map(
      ( NULL < nf_hh_property_owners_ct and nf_hh_property_owners_ct <= 0.5) => 0.0871775697, 
      (nf_hh_property_owners_ct > 0.5) => -0.0262595721, -0.0172922091), 
   (rv_P88_Phn_Dst_to_Inp_Add > 54.5) => 0.0939424863, -0.0332497292), -0.0002816719);

// Tree: 817
final_score_817 := map(
( NULL < nf_inq_per_addr and nf_inq_per_addr <= 31.5) => -0.0007301562, 
(nf_inq_per_addr > 31.5) => map(
   ( NULL < nf_fp_srchfraudsrchcountday and nf_fp_srchfraudsrchcountday <= 0.5) => map(
      ( NULL < nf_mos_acc_lseen and nf_mos_acc_lseen <= 1) => 0.0263590058, 
      (nf_mos_acc_lseen > 1) => 0.1362951439, 0.0510040302), 
   (nf_fp_srchfraudsrchcountday > 0.5) => -0.0635306619, 0.0384522831), -0.0004724268);

// Tree: 818
final_score_818 := map(
( NULL < nf_inq_QuizProvider_count24 and nf_inq_QuizProvider_count24 <= 0.5) => map(
   ( NULL < nf_inq_adls_per_sfd_addr and nf_inq_adls_per_sfd_addr <= 6.5) => 0.0012809947, 
   (nf_inq_adls_per_sfd_addr > 6.5) => 0.1041207970, 0.0014083281), 
(nf_inq_QuizProvider_count24 > 0.5) => map(
   ( NULL < nf_add_input_nhood_SFD_pct and nf_add_input_nhood_SFD_pct <= 0.7256790806) => -0.0216765354, 
   (nf_add_input_nhood_SFD_pct > 0.7256790806) => -0.0006769052, -0.0096960759), -0.0003445023);

// Tree: 819
final_score_819 := map(
( NULL < rv_comb_age and rv_comb_age <= 36.5) => map(
   (nf_fp_addrchangeecontraj in ['-1','AA','AB','AC','AD','AF','BA','BB','BC','BF','BU','CA','CC','CU','DB','DC','DD','DF','DU','EA','EB','EC','ED','EE','EU','FA','FB','FE','FF','FU','UC','UD','UE','UF']) => 0.0031966259, 
   (nf_fp_addrchangeecontraj in ['AE','AU','BD','BE','CB','CD','CE','CF','DA','DE','EF','FC','FD','UU']) => map(
      ( NULL < iv_prv_addr_lres and iv_prv_addr_lres <= 79.5) => 0.0249737787, 
      (iv_prv_addr_lres > 79.5) => 0.1375391827, 0.0480310688), 0.0042372911), 
(rv_comb_age > 36.5) => -0.0053731382, -0.0011736229);

// Tree: 820
final_score_820 := map(
( NULL < iv_mos_src_voter_adl_lseen and iv_mos_src_voter_adl_lseen <= 47.5) => -0.0008966700, 
(iv_mos_src_voter_adl_lseen > 47.5) => map(
   (iv_inp_addr_mortgage_type in ['CONVENTIONAL','NO MORTGAGE','NON-TRADITIONAL']) => 0.0066149714, 
   (iv_inp_addr_mortgage_type in ['GOVERNMENT','OTHER','UNKNOWN']) => map(
      ( NULL < rv_I60_Inq_Count12 and rv_I60_Inq_Count12 <= 7.5) => 0.0207536988, 
      (rv_I60_Inq_Count12 > 7.5) => 0.1302531211, 0.0299739007), 0.0116040887), 0.0001860361);

// Tree: 821
final_score_821 := map(
( NULL < rv_I60_inq_auto_recency and rv_I60_inq_auto_recency <= 9) => 0.0037273333, 
(rv_I60_inq_auto_recency > 9) => map(
   ( NULL < iv_full_name_non_phn_src_ct and iv_full_name_non_phn_src_ct <= 5.5) => -0.0260909684, 
   (iv_full_name_non_phn_src_ct > 5.5) => map(
      (nf_fp_addrchangeecontraj in ['-1','AA','AB','AC','AD','AE','BB','BC','BD','BE','BF','CA','CB','CC','CD','CF','CU','DB','DC','DD','DE','DF','DU','EA','EB','EC','ED','EE','EF','FA','FB','FC','FD','FE','FF','FU','UE','UF','UU']) => -0.0017272240, 
      (nf_fp_addrchangeecontraj in ['AF','AU','BA','BU','CE','DA','EU','UC','UD']) => 0.2049967875, -0.0013225629), -0.0047193942), 0.0001223092);

// Tree: 822
final_score_822 := map(
( NULL < nf_liens_rel_SC_total_amt and nf_liens_rel_SC_total_amt <= 983.5) => map(
   ( NULL < iv_prof_license_category_PL and iv_prof_license_category_PL <= 2.5) => map(
      ( NULL < rv_D33_eviction_count and rv_D33_eviction_count <= 4.5) => -0.0098569176, 
      (rv_D33_eviction_count > 4.5) => 0.1005005230, -0.0078056640), 
   (iv_prof_license_category_PL > 2.5) => -0.0359387716, 0.0026128567), 
(nf_liens_rel_SC_total_amt > 983.5) => -0.0409221138, 0.0007472005);

// Tree: 823
final_score_823 := map(
( NULL < nf_fp_curraddrburglaryindex and nf_fp_curraddrburglaryindex <= 170.5) => -0.0014777305, 
(nf_fp_curraddrburglaryindex > 170.5) => map(
   ( NULL < nf_fp_srchaddrsrchcountmo and nf_fp_srchaddrsrchcountmo <= 8.5) => map(
      ( NULL < nf_fp_addrchangevaluediff and nf_fp_addrchangevaluediff <= -85130.5) => 0.1231971152, 
      (nf_fp_addrchangevaluediff > -85130.5) => 0.0084835115, 0.0099988149), 
   (nf_fp_srchaddrsrchcountmo > 8.5) => 0.0809921032, 0.0106133390), -0.0000754005);

// Tree: 824
final_score_824 := map(
( NULL < rv_F01_inp_add_house_num_match and rv_F01_inp_add_house_num_match <= 0.5) => map(
   (nf_fp_addrchangeecontraj in ['-1','AA','BA','BE','BF','BU','CA','CB','CF','DA','DB','DC','DE','EB','ED','EF','EU','FA','FC','FD','UC','UE']) => -0.0058078362, 
   (nf_fp_addrchangeecontraj in ['AB','AC','AD','AE','AF','AU','BB','BC','BD','CC','CD','CE','CU','DD','DF','DU','EA','EC','EE','FB','FE','FF','FU','UD','UF','UU']) => map(
      ( NULL < nf_fp_sourcerisktype and nf_fp_sourcerisktype <= 4.5) => 0.0106640320, 
      (nf_fp_sourcerisktype > 4.5) => 0.0776734351, 0.0373422487), 0.0191021497), 
(rv_F01_inp_add_house_num_match > 0.5) => 0.0002077178, 0.0007475587);

// Tree: 825
final_score_825 := map(
( NULL < nf_current_count and nf_current_count <= 7.5) => map(
   ( NULL < nf_historical_count and nf_historical_count <= 14.5) => 0.0001352041, 
   (nf_historical_count > 14.5) => map(
      (nf_fp_addrchangeecontraj in ['-1','AA','BB','CC','CD','CF','DC','DD','DF','EF','FD','FE','UU']) => -0.0299491744, 
      (nf_fp_addrchangeecontraj in ['AB','AC','AD','AE','AF','AU','BA','BC','BD','BE','BF','BU','CA','CB','CE','CU','DA','DB','DE','DU','EA','EB','EC','ED','EE','EU','FA','FB','FC','FF','FU','UC','UD','UE','UF']) => 0.0610574872, 0.0243645963), 0.0004135352), 
(nf_current_count > 7.5) => -0.0296014635, -0.0000732446);

// Tree: 826
final_score_826 := map(
( NULL < nf_add_curr_mobility_index and nf_add_curr_mobility_index <= 0.7778154405) => -0.0006878059, 
(nf_add_curr_mobility_index > 0.7778154405) => map(
   (nf_fp_addrchangeecontraj in ['-1','BE','CB','CC','CF','CU','DD','DE','EB','ED','EE','FC','FF','UU']) => map(
      ( NULL < iv_C14_addrs_per_adl and iv_C14_addrs_per_adl <= 11.5) => 0.0027163819, 
      (iv_C14_addrs_per_adl > 11.5) => 0.1539615307, 0.0214901870), 
   (nf_fp_addrchangeecontraj in ['AA','AB','AC','AD','AE','AF','AU','BA','BB','BC','BD','BF','BU','CA','CD','CE','DA','DB','DC','DF','DU','EA','EC','EF','EU','FA','FB','FD','FE','FU','UC','UD','UE','UF']) => 0.2023343875, 0.0369449847), -0.0003080584);

// Tree: 827
final_score_827 := map(
( NULL < nf_M_Bureau_ADL_FS_all and nf_M_Bureau_ADL_FS_all <= 65.5) => map(
   ( NULL < nf_inq_adls_per_phone and nf_inq_adls_per_phone <= 0.5) => map(
      (nf_util_add_curr_summary in ['|  M|','| C |','| CM|','|I  |','|I M|','|IC |']) => -0.0029835428, 
      (nf_util_add_curr_summary in ['|   |','|ICM|']) => 0.1293840070, 0.0142669379), 
   (nf_inq_adls_per_phone > 0.5) => -0.0194607975, -0.0134587321), 
(nf_M_Bureau_ADL_FS_all > 65.5) => 0.0000637806, -0.0006954085);

// Tree: 828
final_score_828 := map(
( NULL < nf_average_rel_distance and nf_average_rel_distance <= 510.5) => map(
   ( NULL < rv_S65_SSN_Problem and rv_S65_SSN_Problem <= 1.5) => 0.0015702822, 
   (rv_S65_SSN_Problem > 1.5) => -0.0634247395, 0.0013663658), 
(nf_average_rel_distance > 510.5) => map(
   (nf_fp_addrchangeecontraj in ['-1','AA','AB','AC','AD','AE','BB','BF','BU','CA','CB','CC','CD','CE','CF','CU','DB','DC','DD','DE','DF','EA','EC','EE','EF','FB','FC','FD','FE','FF','FU','UC','UD','UE','UF','UU']) => -0.0123493177, 
   (nf_fp_addrchangeecontraj in ['AF','AU','BA','BC','BD','BE','DA','DU','EB','ED','EU','FA']) => 0.0935004207, -0.0110989042), -0.0001548496);

// Tree: 829
final_score_829 := map(
( NULL < nf_average_rel_income and nf_average_rel_income <= 36500) => map(
   ( NULL < iv_prv_addr_lres and iv_prv_addr_lres <= 6.5) => -0.0588574436, 
   (iv_prv_addr_lres > 6.5) => map(
      ( NULL < rv_I62_inq_num_names_per_adl and rv_I62_inq_num_names_per_adl <= 1.5) => 0.0315640347, 
      (rv_I62_inq_num_names_per_adl > 1.5) => 0.1268260051, 0.0435790580), -0.0224596447), 
(nf_average_rel_income > 36500) => 0.0001070925, 0.0004843316);

// Tree: 830
final_score_830 := map(
( NULL < nf_fp_curraddrcrimeindex and nf_fp_curraddrcrimeindex <= 199.5) => map(
   ( NULL < nf_average_rel_income and nf_average_rel_income <= 45500) => map(
      (rv_D32_criminal_x_felony in ['1-1','2-0','2-1','3-2','3-3']) => -0.0440420460, 
      (rv_D32_criminal_x_felony in ['0-0','1-0','2-2','3-0','3-1']) => 0.0205985054, 0.0168385121), 
   (nf_average_rel_income > 45500) => 0.0001536971, 0.0010415971), 
(nf_fp_curraddrcrimeindex > 199.5) => -0.0749451337, 0.0008841349);

// Tree: 831
final_score_831 := map(
( NULL < nf_hh_age_65_plus and nf_hh_age_65_plus <= 0.5) => -0.0025403302, 
(nf_hh_age_65_plus > 0.5) => map(
   ( NULL < nf_rel_count and nf_rel_count <= 34.5) => map(
      (nf_fp_addrchangeecontraj in ['-1','AA','AB','AC','AD','AF','BA','BB','BC','BD','BE','BF','CA','CB','CC','CD','CE','CF','CU','DC','DD','DE','DU','EB','ED','EE','EF','EU','FA','FB','FC','FE','FF','FU','UE','UU']) => 0.0102428715, 
      (nf_fp_addrchangeecontraj in ['AE','AU','BU','DA','DB','DF','EA','EC','FD','UC','UD','UF']) => 0.1297702526, 0.0110386155), 
   (nf_rel_count > 34.5) => -0.0418086703, 0.0086754543), -0.0003612957);

// Tree: 832
final_score_832 := map(
(nf_fp_addrchangeecontraj in ['AB','AC','AE','AF','BA','BU','CA','CU','DA','DF','EA','EC','ED','EU','FC','FE','FU','UC','UD','UE']) => map(
   ( NULL < rv_A49_curr_add_avm_pct_chg_2yr and rv_A49_curr_add_avm_pct_chg_2yr <= 1.4647173836) => map(
      ( NULL < rv_I60_inq_hiRiskCred_count12 and rv_I60_inq_hiRiskCred_count12 <= 1.5) => 0.0016639989, 
      (rv_I60_inq_hiRiskCred_count12 > 1.5) => -0.1044417697, -0.0452378263), 
   (rv_A49_curr_add_avm_pct_chg_2yr > 1.4647173836) => 0.1446023053, -0.0258188800), 
(nf_fp_addrchangeecontraj in ['-1','AA','AD','AU','BB','BC','BD','BE','BF','CB','CC','CD','CE','CF','DB','DC','DD','DE','DU','EB','EE','EF','FA','FB','FD','FF','UF','UU']) => 0.0025797887, 0.0020550276);

// Tree: 833
final_score_833 := map(
(nf_fp_addrchangeecontraj in ['-1','AA','AD','AE','BA','BB','BC','BD','BE','BF','BU','CA','CC','CD','CE','CF','CU','DA','DB','DC','DD','DE','DF','DU','EC','ED','EE','EF','EU','FA','FB','FC','FD','FE','FF','UC','UD','UE','UU']) => -0.0003897172, 
(nf_fp_addrchangeecontraj in ['AB','AC','AF','AU','CB','EA','EB','FU','UF']) => map(
   ( NULL < nf_fp_srchunvrfdaddrcount and nf_fp_srchunvrfdaddrcount <= 0.5) => map(
      ( NULL < nf_fp_srchfraudsrchcountyr and nf_fp_srchfraudsrchcountyr <= 2.5) => 0.0436350738, 
      (nf_fp_srchfraudsrchcountyr > 2.5) => 0.2278195414, 0.1265180842), 
   (nf_fp_srchunvrfdaddrcount > 0.5) => -0.0492963599, 0.0705771247), -0.0002289583);

// Tree: 834
final_score_834 := map(
( NULL < nf_inq_per_phone and nf_inq_per_phone <= 32.5) => map(
   ( NULL < nf_fp_srchaddrsrchcountwk and nf_fp_srchaddrsrchcountwk <= 5.5) => map(
      ( NULL < nf_fp_srchaddrsrchcountwk and nf_fp_srchaddrsrchcountwk <= 4.5) => -0.0000806328, 
      (nf_fp_srchaddrsrchcountwk > 4.5) => 0.0388839383, 0.0000439949), 
   (nf_fp_srchaddrsrchcountwk > 5.5) => -0.0354145232, -0.0000622122), 
(nf_inq_per_phone > 32.5) => -0.0619505167, 0.0304166909);

// Tree: 835
final_score_835 := map(
( NULL < nf_fp_srchfraudsrchcountyr and nf_fp_srchfraudsrchcountyr <= 1.5) => -0.0084244615, 
(nf_fp_srchfraudsrchcountyr > 1.5) => map(
   (nf_fp_addrchangeecontraj in ['AB','AC','AE','BA','BD','BF','BU','CA','CB','CD','CE','CF','DB','EA','EB','ED','EF','EU','FA','FC','FD','UC','UE','UU']) => map(
      ( NULL < nf_util_adl_count and nf_util_adl_count <= 7.5) => -0.0139477600, 
      (nf_util_adl_count > 7.5) => -0.0871734278, -0.0332441377), 
   (nf_fp_addrchangeecontraj in ['-1','AA','AD','AF','AU','BB','BC','BE','CC','CU','DA','DC','DD','DE','DF','DU','EC','EE','FB','FE','FF','FU','UD','UF']) => 0.0044478448, 0.0035919435), -0.0004893127);

// Tree: 836
final_score_836 := map(
( NULL < nf_hh_collections_ct and nf_hh_collections_ct <= 7.5) => -0.0008950956, 
(nf_hh_collections_ct > 7.5) => map(
   ( NULL < iv_fname_non_phn_src_ct and iv_fname_non_phn_src_ct <= 11.5) => map(
      ( NULL < nf_inq_Other_count24 and nf_inq_Other_count24 <= 4.5) => 0.0491289354, 
      (nf_inq_Other_count24 > 4.5) => -0.0850314779, 0.0230538707), 
   (iv_fname_non_phn_src_ct > 11.5) => 0.1725442588, 0.0453777687), -0.0006717480);

// Tree: 837
final_score_837 := map(
( NULL < nf_inq_PrepaidCards_count24 and nf_inq_PrepaidCards_count24 <= 0.5) => -0.0010754873, 
(nf_inq_PrepaidCards_count24 > 0.5) => map(
   ( NULL < nf_fp_srchunvrfdaddrcount and nf_fp_srchunvrfdaddrcount <= 0.5) => map(
      (iv_D34_liens_unrel_x_rel in ['0-1','0-2','1-1','1-2','2-0','2-1','2-2','3-1','3-2']) => -0.0942480934, 
      (iv_D34_liens_unrel_x_rel in ['0-0','1-0','3-0']) => 0.0331818015, 0.0085263228), 
   (nf_fp_srchunvrfdaddrcount > 0.5) => 0.1028118671, 0.0242139007), -0.0008837679);

// Tree: 838
final_score_838 := map(
( NULL < nf_add_input_mobility_index and nf_add_input_mobility_index <= 0.96015737925) => map(
   ( NULL < nf_liens_unrel_SC_total_amt and nf_liens_unrel_SC_total_amt <= 15.5) => -0.0010218653, 
   (nf_liens_unrel_SC_total_amt > 15.5) => map(
      ( NULL < nf_phones_per_addr_curr and nf_phones_per_addr_curr <= 13.5) => 0.0073950315, 
      (nf_phones_per_addr_curr > 13.5) => 0.0720118397, 0.0107077421), 0.0002720636), 
(nf_add_input_mobility_index > 0.96015737925) => -0.0565072860, -0.0000268405);

// Tree: 839
final_score_839 := map(
( NULL < nf_fp_srchssnsrchcountmo and nf_fp_srchssnsrchcountmo <= 6.5) => -0.0028475382, 
(nf_fp_srchssnsrchcountmo > 6.5) => map(
   ( NULL < rv_D30_Derog_Count and rv_D30_Derog_Count <= 6.5) => map(
      ( NULL < nf_fp_prevaddrburglaryindex and nf_fp_prevaddrburglaryindex <= 162.5) => 0.0128741334, 
      (nf_fp_prevaddrburglaryindex > 162.5) => 0.0667966843, 0.0197071866), 
   (rv_D30_Derog_Count > 6.5) => -0.0447645338, 0.0127890834), -0.0025361864);

// Tree: 840
final_score_840 := map(
( NULL < rv_C13_max_lres and rv_C13_max_lres <= 608.5) => map(
   ( NULL < nf_add_input_nhood_MFD_pct and nf_add_input_nhood_MFD_pct <= 0.9969262166) => map(
      ( NULL < iv_mos_src_voter_adl_lseen and iv_mos_src_voter_adl_lseen <= 157.5) => -0.0002594511, 
      (iv_mos_src_voter_adl_lseen > 157.5) => 0.0440103997, -0.0000474860), 
   (nf_add_input_nhood_MFD_pct > 0.9969262166) => -0.0992729653, -0.0002175108), 
(rv_C13_max_lres > 608.5) => 0.1680735667, -0.0000918800);

// Tree: 841
final_score_841 := map(
( NULL < nf_inq_lnames_per_apt_addr and nf_inq_lnames_per_apt_addr <= 3.5) => 0.0000088534, 
(nf_inq_lnames_per_apt_addr > 3.5) => map(
   (iv_D34_liens_unrel_x_rel in ['1-0','1-1','3-1','3-2']) => -0.0517607946, 
   (iv_D34_liens_unrel_x_rel in ['0-0','0-1','0-2','1-2','2-0','2-1','2-2','3-0']) => map(
      (rv_D32_criminal_x_felony in ['0-0','1-1','3-0','3-1']) => 0.0388152042, 
      (rv_D32_criminal_x_felony in ['1-0','2-0','2-1','2-2','3-2','3-3']) => 0.1715614311, 0.0597602379), 0.0362920072), 0.0002862554);

// Tree: 842
final_score_842 := map(
(nf_util_add_input_summary in ['|I  |']) => -0.0833188272, 
(nf_util_add_input_summary in ['|   |','|  M|','| C |','| CM|','|I M|','|IC |','|ICM|']) => map(
   ( NULL < rv_I60_inq_mortgage_count12 and rv_I60_inq_mortgage_count12 <= 1.5) => -0.0001054644, 
   (rv_I60_inq_mortgage_count12 > 1.5) => map(
      ( NULL < nf_hh_payday_loan_users_pct and nf_hh_payday_loan_users_pct <= 0.26785714285) => 0.0238615894, 
      (nf_hh_payday_loan_users_pct > 0.26785714285) => 0.1699671950, 0.0452428975), 0.0001102769), -0.0000207254);

// Tree: 843
final_score_843 := map(
( NULL < nf_fp_srchaddrsrchcountmo and nf_fp_srchaddrsrchcountmo <= 5.5) => 0.0024126325, 
(nf_fp_srchaddrsrchcountmo > 5.5) => map(
   ( NULL < rv_D32_Mos_Since_Crim_LS and rv_D32_Mos_Since_Crim_LS <= 99.5) => map(
      (iv_college_file_type in ['-1','H']) => -0.0160429834, 
      (iv_college_file_type in ['A','C']) => 0.0368218911, 0.0137982669), 
   (rv_D32_Mos_Since_Crim_LS > 99.5) => -0.0552994915, -0.0118385635), 0.0019786325);

// Tree: 844
final_score_844 := map(
( NULL < nf_fp_srchfraudsrchcountyr and nf_fp_srchfraudsrchcountyr <= 32.5) => map(
   ( NULL < nf_inq_per_phone and nf_inq_per_phone <= 30.5) => -0.0002375570, 
   (nf_inq_per_phone > 30.5) => 0.1001228267, -0.0206082516), 
(nf_fp_srchfraudsrchcountyr > 32.5) => map(
   ( NULL < nf_M_Bureau_ADL_FS_noTU and nf_M_Bureau_ADL_FS_noTU <= 263) => 0.0096457738, 
   (nf_M_Bureau_ADL_FS_noTU > 263) => -0.0908154401, -0.0498312633), -0.0003161869);

// Tree: 845
final_score_845 := map(
( NULL < rv_A49_curr_add_avm_pct_chg_2yr and rv_A49_curr_add_avm_pct_chg_2yr <= 3.83784893265) => map(
   ( NULL < nf_fp_srchaddrsrchcountmo and nf_fp_srchaddrsrchcountmo <= 11.5) => -0.0013360142, 
   (nf_fp_srchaddrsrchcountmo > 11.5) => -0.0646174567, -0.0015802490), 
(rv_A49_curr_add_avm_pct_chg_2yr > 3.83784893265) => -0.0812501686, map(
   (iv_inp_addr_mortgage_type in ['CONVENTIONAL','GOVERNMENT','NO MORTGAGE','OTHER']) => 0.0004660096, 
   (iv_inp_addr_mortgage_type in ['NON-TRADITIONAL','UNKNOWN']) => 0.0186272207, 0.0020042978));

// Tree: 846
final_score_846 := map(
( NULL < nf_inq_per_apt_addr and nf_inq_per_apt_addr <= 28.5) => map(
   ( NULL < rv_D30_Derog_Count and rv_D30_Derog_Count <= 11.5) => 0.0012357807, 
   (rv_D30_Derog_Count > 11.5) => map(
      ( NULL < nf_fp_srchcomponentrisktype and nf_fp_srchcomponentrisktype <= 3.5) => -0.0059680914, 
      (nf_fp_srchcomponentrisktype > 3.5) => -0.0471083851, -0.0145260487), 0.0008053127), 
(nf_inq_per_apt_addr > 28.5) => 0.0967414262, 0.0008707610);

// Tree: 847
final_score_847 := map(
( NULL < nf_fp_srchssnsrchcountwk and nf_fp_srchssnsrchcountwk <= 4.5) => map(
   ( NULL < nf_fp_srchaddrsrchcountwk and nf_fp_srchaddrsrchcountwk <= 4.5) => -0.0004765801, 
   (nf_fp_srchaddrsrchcountwk > 4.5) => 0.0515256971, -0.0003565868), 
(nf_fp_srchssnsrchcountwk > 4.5) => map(
   (rv_D32_criminal_x_felony in ['0-0','1-0','1-1','2-0','2-1','3-2','3-3']) => -0.0300590955, 
   (rv_D32_criminal_x_felony in ['2-2','3-0','3-1']) => 0.0696674244, -0.0188983659), -0.0004887980);

// Tree: 848
final_score_848 := map(
( NULL < nf_phones_per_addr_curr and nf_phones_per_addr_curr <= 91.5) => map(
   ( NULL < nf_inq_Banking_count24 and nf_inq_Banking_count24 <= 15.5) => map(
      ( NULL < rv_I60_credit_seeking and rv_I60_credit_seeking <= 0.5) => -0.0005307731, 
      (rv_I60_credit_seeking > 0.5) => 0.0087597726, 0.0006315813), 
   (nf_inq_Banking_count24 > 15.5) => -0.0870426337, 0.0004415433), 
(nf_phones_per_addr_curr > 91.5) => -0.0739036850, 0.0002750388);

// Tree: 849
final_score_849 := map(
( NULL < rv_C14_addrs_5yr and rv_C14_addrs_5yr <= 3.5) => -0.0015992495, 
(rv_C14_addrs_5yr > 3.5) => map(
   ( NULL < rv_email_count and rv_email_count <= 19.5) => map(
      ( NULL < nf_add_input_nhood_BUS_pct and nf_add_input_nhood_BUS_pct <= 0.0184695193) => 0.0254287067, 
      (nf_add_input_nhood_BUS_pct > 0.0184695193) => 0.0004967663, 0.0081231309), 
   (rv_email_count > 19.5) => 0.1484408531, 0.0090950030), -0.0002876227);

// Tree: 850
final_score_850 := map(
( NULL < rv_I60_Inq_Count12 and rv_I60_Inq_Count12 <= 4.5) => 0.0013108480, 
(rv_I60_Inq_Count12 > 4.5) => map(
   ( NULL < nf_fp_curraddrmedianvalue and nf_fp_curraddrmedianvalue <= 830300) => map(
      ( NULL < nf_average_rel_criminal_dist and nf_average_rel_criminal_dist <= 529.5) => -0.0099451417, 
      (nf_average_rel_criminal_dist > 529.5) => 0.0140611463, -0.0064098694), 
   (nf_fp_curraddrmedianvalue > 830300) => 0.1202717287, -0.0057111372), -0.0002622163);

// Tree: 851
final_score_851 := map(
( NULL < rv_I60_inq_other_recency and rv_I60_inq_other_recency <= 18) => -0.0022350591, 
(rv_I60_inq_other_recency > 18) => map(
   ( NULL < nf_M_Bureau_ADL_FS_noTU and nf_M_Bureau_ADL_FS_noTU <= 67.5) => map(
      ( NULL < nf_phones_per_sfd_addr_c6 and nf_phones_per_sfd_addr_c6 <= 0.5) => 0.0343258746, 
      (nf_phones_per_sfd_addr_c6 > 0.5) => 0.1275634091, 0.0474747577), 
   (nf_M_Bureau_ADL_FS_noTU > 67.5) => 0.0078627918, 0.0092675511), 0.0003742108);

// Tree: 852
final_score_852 := map(
(nf_fp_addrchangeecontraj in ['-1','AA','AB','AC','AD','AF','BA','BB','BC','BF','BU','CA','CB','CC','CD','CE','CF','CU','DB','DC','DD','DE','DF','EB','EC','ED','EE','EF','EU','FA','FC','FE','FF','UC','UD','UE','UF']) => -0.0007675250, 
(nf_fp_addrchangeecontraj in ['AE','AU','BD','BE','DA','DU','EA','FB','FD','FU','UU']) => map(
   ( NULL < rv_C10_M_Hdr_FS and rv_C10_M_Hdr_FS <= 154) => map(
      ( NULL < nf_hh_tot_derog_avg and nf_hh_tot_derog_avg <= 0.29285714285) => -0.0082389413, 
      (nf_hh_tot_derog_avg > 0.29285714285) => 0.1736978358, 0.1038235663), 
   (rv_C10_M_Hdr_FS > 154) => 0.0087244924, 0.0361225555), -0.0005400957);

// Tree: 853
final_score_853 := map(
(iv_college_code_x_type in ['-1','1-P','1-R','1-S','2-R','2-S','2-U','4-P','4-R','4-S']) => map(
   ( NULL < nf_Inq_Per_Add_NAS_479 and nf_Inq_Per_Add_NAS_479 <= 4.5) => 0.0006693019, 
   (nf_Inq_Per_Add_NAS_479 > 4.5) => map(
      ( NULL < nf_fp_curraddrburglaryindex and nf_fp_curraddrburglaryindex <= 109.5) => -0.0025884664, 
      (nf_fp_curraddrburglaryindex > 109.5) => -0.0727228744, -0.0336249573), 0.0005155833), 
(iv_college_code_x_type in ['2-P']) => 0.1457126597, 0.0006183704);

// Tree: 854
final_score_854 := map(
( NULL < iv_unverified_addr_count and iv_unverified_addr_count <= 4.5) => -0.0034796640, 
(iv_unverified_addr_count > 4.5) => map(
   ( NULL < nf_fp_curraddrmedianincome and nf_fp_curraddrmedianincome <= 38951) => map(
      ( NULL < nf_hh_college_attendees_pct and nf_hh_college_attendees_pct <= 0.875) => 0.0149095490, 
      (nf_hh_college_attendees_pct > 0.875) => 0.0872377289, 0.0183847400), 
   (nf_fp_curraddrmedianincome > 38951) => 0.0012575541, 0.0046300844), -0.0003575513);

// Tree: 855
final_score_855 := map(
( NULL < nf_inq_HighRiskCredit_count24 and nf_inq_HighRiskCredit_count24 <= 8.5) => 0.0019734853, 
(nf_inq_HighRiskCredit_count24 > 8.5) => map(
   ( NULL < nf_fp_srchssnsrchcountmo and nf_fp_srchssnsrchcountmo <= 1.5) => 0.0032947875, 
   (nf_fp_srchssnsrchcountmo > 1.5) => map(
      ( NULL < iv_prv_addr_lres and iv_prv_addr_lres <= 29.5) => -0.0379987417, 
      (iv_prv_addr_lres > 29.5) => -0.0141306710, 0.0925940067), -0.0069721611), 0.0009611030);

// Tree: 856
final_score_856 := map(
( NULL < iv_dob_src_ct and iv_dob_src_ct <= 3.5) => map(
   ( NULL < nf_fp_divaddrsuspidcountnew and nf_fp_divaddrsuspidcountnew <= 1.5) => 0.0036948924, 
   (nf_fp_divaddrsuspidcountnew > 1.5) => map(
      ( NULL < rv_I60_inq_hiRiskCred_count12 and rv_I60_inq_hiRiskCred_count12 <= 8.5) => 0.0352951980, 
      (rv_I60_inq_hiRiskCred_count12 > 8.5) => 0.1417280574, 0.0418139144), 0.0063693890), 
(iv_dob_src_ct > 3.5) => -0.0024854475, -0.0140904134);

// Tree: 857
final_score_857 := map(
( NULL < rv_A49_curr_add_avm_chg_3yr and rv_A49_curr_add_avm_chg_3yr <= -89195.5) => map(
   ( NULL < nf_highest_rel_income and nf_highest_rel_income <= 112.5) => -0.0284922619, 
   (nf_highest_rel_income > 112.5) => 0.2849739397, 0.1223263822), 
(rv_A49_curr_add_avm_chg_3yr > -89195.5) => map(
   ( NULL < nf_mos_liens_unrel_FC_fseen and nf_mos_liens_unrel_FC_fseen <= 153.5) => -0.0036649882, 
   (nf_mos_liens_unrel_FC_fseen > 153.5) => 0.0927214824, -0.0029064025), 0.0019873652);

// Tree: 858
final_score_858 := map(
( NULL < rv_email_count and rv_email_count <= 3.5) => map(
   ( NULL < nf_add_input_nhood_VAC_pct and nf_add_input_nhood_VAC_pct <= 0.26892566095) => 0.0044898256, 
   (nf_add_input_nhood_VAC_pct > 0.26892566095) => -0.0172551773, 0.0033775439), 
(rv_email_count > 3.5) => map(
   ( NULL < rv_L79_adls_per_addr_curr and rv_L79_adls_per_addr_curr <= 10.5) => -0.0037295928, 
   (rv_L79_adls_per_addr_curr > 10.5) => -0.0490278884, -0.0044925826), -0.0002857550);

// Tree: 859
final_score_859 := map(
( NULL < nf_liens_unrel_ST_total_amt and nf_liens_unrel_ST_total_amt <= 16941.5) => map(
   ( NULL < nf_liens_unrel_ST_ct and nf_liens_unrel_ST_ct <= 5.5) => map(
      ( NULL < nf_fp_srchfraudsrchcountyr and nf_fp_srchfraudsrchcountyr <= 15.5) => -0.0015334614, 
      (nf_fp_srchfraudsrchcountyr > 15.5) => 0.0124570549, -0.0009709615), 
   (nf_liens_unrel_ST_ct > 5.5) => 0.1265590449, -0.0008575941), 
(nf_liens_unrel_ST_total_amt > 16941.5) => -0.1003863718, -0.0009485512);

// Tree: 860
final_score_860 := map(
( NULL < rv_L74_Add_Curr_ThrowBack and rv_L74_Add_Curr_ThrowBack <= 0.5) => map(
   ( NULL < iv_D34_liens_unrel_SC_ct and iv_D34_liens_unrel_SC_ct <= 2.5) => -0.0020555790, 
   (iv_D34_liens_unrel_SC_ct > 2.5) => map(
      ( NULL < iv_addr_non_phn_src_ct and iv_addr_non_phn_src_ct <= 4.5) => -0.0217317344, 
      (iv_addr_non_phn_src_ct > 4.5) => 0.0479002954, 0.0275776810), -0.0016378865), 
(rv_L74_Add_Curr_ThrowBack > 0.5) => 0.1398938943, -0.0014903343);

// Tree: 861
final_score_861 := map(
( NULL < nf_inq_per_phone and nf_inq_per_phone <= 2.5) => -0.0028248763, 
(nf_inq_per_phone > 2.5) => map(
   ( NULL < nf_fp_prevaddrmedianvalue and nf_fp_prevaddrmedianvalue <= 86652.5) => map(
      ( NULL < nf_pct_rel_prop_owned and nf_pct_rel_prop_owned <= 0.6012820513) => -0.0192459007, 
      (nf_pct_rel_prop_owned > 0.6012820513) => 0.0161521723, -0.0085364782), 
   (nf_fp_prevaddrmedianvalue > 86652.5) => 0.0085165975, 0.0056588233), 0.1098188252);

// Tree: 862
final_score_862 := map(
(nf_fp_addrchangeecontraj in ['AC','AE','AF','BD','BE','DF','DU','EA','FA','FB','UF']) => -0.0550746633, 
(nf_fp_addrchangeecontraj in ['-1','AA','AB','AD','AU','BA','BB','BC','BF','BU','CA','CB','CC','CD','CE','CF','CU','DA','DB','DC','DD','DE','EB','EC','ED','EE','EF','EU','FC','FD','FE','FF','FU','UC','UD','UE','UU']) => map(
   ( NULL < iv_br_source_count and iv_br_source_count <= 6.5) => 0.0005752100, 
   (iv_br_source_count > 6.5) => map(
      ( NULL < nf_inq_adls_per_phone and nf_inq_adls_per_phone <= 0.5) => 0.0598056601, 
      (nf_inq_adls_per_phone > 0.5) => -0.0863710313, -0.0491213725), 0.0004086264), 0.0001044049);

// Tree: 863
final_score_863 := map(
( NULL < rv_C12_source_profile and rv_C12_source_profile <= 0.05) => map(
   ( NULL < nf_phones_per_sfd_addr_curr and nf_phones_per_sfd_addr_curr <= 10.5) => map(
      (nf_fp_addrchangeecontraj in ['BD','BE','CB','CC','CE','CF','EF','FD','FE']) => -0.0803746567, 
      (nf_fp_addrchangeecontraj in ['-1','AA','AB','AC','AD','AE','AF','AU','BA','BB','BC','BF','BU','CA','CD','CU','DA','DB','DC','DD','DE','DF','DU','EA','EB','EC','ED','EE','EU','FA','FB','FC','FF','FU','UC','UD','UE','UF','UU']) => 0.0281097556, 0.0126362736), 
   (nf_phones_per_sfd_addr_curr > 10.5) => 0.1125572503, 0.0238930179), 
(rv_C12_source_profile > 0.05) => -0.0003139753, -0.0000899663);

// Tree: 864
final_score_864 := map(
( NULL < iv_inp_add_avm_pct_chg_3yr and iv_inp_add_avm_pct_chg_3yr <= 0.20467854475) => 0.1245057813, 
(iv_inp_add_avm_pct_chg_3yr > 0.20467854475) => map(
   ( NULL < nf_fp_srchvelocityrisktype and nf_fp_srchvelocityrisktype <= 1.5) => map(
      ( NULL < nf_hh_tot_derog_avg and nf_hh_tot_derog_avg <= 0.36038961035) => 0.1634454120, 
      (nf_hh_tot_derog_avg > 0.36038961035) => -0.0110858725, 0.0559628028), 
   (nf_fp_srchvelocityrisktype > 1.5) => -0.0037396793, -0.0030303964), 0.0008064111);

// Tree: 865
final_score_865 := map(
( NULL < nf_mos_liens_rel_FT_fseen and nf_mos_liens_rel_FT_fseen <= 307.5) => map(
   ( NULL < rv_L79_adls_per_addr_curr and rv_L79_adls_per_addr_curr <= 8.5) => -0.0016825683, 
   (rv_L79_adls_per_addr_curr > 8.5) => map(
      ( NULL < rv_A49_curr_add_avm_pct_chg_2yr and rv_A49_curr_add_avm_pct_chg_2yr <= 0.72431740885) => -0.0720562463, 
      (rv_A49_curr_add_avm_pct_chg_2yr > 0.72431740885) => 0.0267164869, 0.0132639501), -0.0008174599), 
(nf_mos_liens_rel_FT_fseen > 307.5) => 0.2117897838, -0.0006614872);

// Tree: 866
final_score_866 := map(
( NULL < nf_inq_count_week and nf_inq_count_week <= 5.5) => map(
   ( NULL < rv_L79_adls_per_sfd_addr_c6 and rv_L79_adls_per_sfd_addr_c6 <= 9.5) => map(
      (iv_college_major in ['BUSINESS','LIBERAL ARTS','NO AMS FOUND','UNCLASSIFIED']) => -0.0019992833, 
      (iv_college_major in ['MEDICAL','NO COLLEGE FOUND','SCIENCE']) => 0.0061141635, -0.0003271635), 
   (rv_L79_adls_per_sfd_addr_c6 > 9.5) => 0.1078544902, -0.0002574786), 
(nf_inq_count_week > 5.5) => 0.0946806547, -0.0001939356);

// Tree: 867
final_score_867 := map(
( NULL < nf_fp_validationrisktype and nf_fp_validationrisktype <= 3.5) => map(
   ( NULL < nf_mos_liens_unrel_ST_lseen and nf_mos_liens_unrel_ST_lseen <= 5.5) => -0.0005875028, 
   (nf_mos_liens_unrel_ST_lseen > 5.5) => map(
      ( NULL < iv_inp_add_avm_pct_chg_3yr and iv_inp_add_avm_pct_chg_3yr <= 1.04607985985) => 0.0612702841, 
      (iv_inp_add_avm_pct_chg_3yr > 1.04607985985) => 0.0170996295, 0.0032139559), 0.0002934394), 
(nf_fp_validationrisktype > 3.5) => -0.0870347430, 0.0001563077);

// Tree: 868
final_score_868 := map(
( NULL < nf_rel_felony_count and nf_rel_felony_count <= 8.5) => map(
   ( NULL < rv_I60_Inq_Count12 and rv_I60_Inq_Count12 <= 12.5) => 0.0001058738, 
   (rv_I60_Inq_Count12 > 12.5) => -0.0158898314, -0.0002839687), 
(nf_rel_felony_count > 8.5) => map(
   ( NULL < rv_I62_inq_addrs_per_adl and rv_I62_inq_addrs_per_adl <= 1.5) => 0.1410074749, 
   (rv_I62_inq_addrs_per_adl > 1.5) => -0.0160551503, 0.0624761623), -0.0002031859);

// Tree: 869
final_score_869 := map(
( NULL < nf_M_Bureau_ADL_FS_noTU and nf_M_Bureau_ADL_FS_noTU <= 70.5) => map(
   ( NULL < nf_inq_per_phone and nf_inq_per_phone <= 0.5) => 0.0328544142, 
   (nf_inq_per_phone > 0.5) => map(
      (iv_D34_liens_unrel_x_rel in ['0-0','0-2','1-0','1-2','2-2']) => 0.0014641792, 
      (iv_D34_liens_unrel_x_rel in ['0-1','1-1','2-0','2-1','3-0','3-1','3-2']) => 0.1111141855, 0.0032108165), 0.0087686580), 
(nf_M_Bureau_ADL_FS_noTU > 70.5) => -0.0014025643, -0.0006734768);

// Tree: 870
final_score_870 := map(
( NULL < nf_Inq_Per_Add_NAS_479 and nf_Inq_Per_Add_NAS_479 <= 0.5) => 0.0011751251, 
(nf_Inq_Per_Add_NAS_479 > 0.5) => map(
   (nf_fp_addrchangeecontraj in ['-1','AA','AF','BA','BB','BC','BD','BU','CA','CB','CC','CD','CF','CU','DB','DC','DD','DE','DF','EB','ED','EE','FA','FB','FC','FD','FE','FF','FU','UC','UD','UE']) => -0.0341513632, 
   (nf_fp_addrchangeecontraj in ['AB','AC','AD','AE','AU','BE','BF','CE','DA','DU','EA','EC','EF','EU','UF','UU']) => map(
      ( NULL < rv_C13_max_lres and rv_C13_max_lres <= 132.5) => -0.0143053071, 
      (rv_C13_max_lres > 132.5) => 0.1207083605, 0.0379832231), -0.0237084482), 0.0007924585);

// Tree: 871
final_score_871 := map(
( NULL < nf_average_rel_income and nf_average_rel_income <= 36500) => map(
   ( NULL < nf_furthest_rel_criminal and nf_furthest_rel_criminal <= 300) => 0.0071490491, 
   (nf_furthest_rel_criminal > 300) => map(
      ( NULL < rv_C14_Addr_Stability_v2 and rv_C14_Addr_Stability_v2 <= 5.5) => 0.1462606380, 
      (rv_C14_Addr_Stability_v2 > 5.5) => -0.0066885444, 0.0872151397), 0.0224505686), 
(nf_average_rel_income > 36500) => -0.0011468224, -0.0008051217);

// Tree: 872
final_score_872 := map(
(rv_D32_criminal_x_felony in ['0-0','1-1','2-1','2-2','3-1','3-2','3-3']) => -0.0041760109, 
(rv_D32_criminal_x_felony in ['1-0','2-0','3-0']) => map(
   ( NULL < nf_pct_rel_with_criminal and nf_pct_rel_with_criminal <= 0.5903263403) => 0.0091935598, 
   (nf_pct_rel_with_criminal > 0.5903263403) => map(
      ( NULL < rv_A49_curr_add_avm_pct_chg_3yr and rv_A49_curr_add_avm_pct_chg_3yr <= 1.61200265255) => -0.0190115160, 
      (rv_A49_curr_add_avm_pct_chg_3yr > 1.61200265255) => 0.0641787331, -0.0249066255), 0.0058265951), -0.0015443221);

// Tree: 873
final_score_873 := map(
(nf_fp_addrchangeecontraj in ['AC','AF','BA','BC','BU','CD','CF','DA','EA','EU','FD','UC','UD','UE']) => -0.0442768231, 
(nf_fp_addrchangeecontraj in ['-1','AA','AB','AD','AE','AU','BB','BD','BE','BF','CA','CB','CC','CE','CU','DB','DC','DD','DE','DF','DU','EB','EC','ED','EE','EF','FA','FB','FC','FE','FF','FU','UF','UU']) => map(
   ( NULL < iv_inp_add_avm_pct_chg_1yr and iv_inp_add_avm_pct_chg_1yr <= 1.06133692175) => -0.0080730638, 
   (iv_inp_add_avm_pct_chg_1yr > 1.06133692175) => 0.0034354507, map(
      ( NULL < nf_inq_Other_count_week and nf_inq_Other_count_week <= 2.5) => 0.0018379500, 
      (nf_inq_Other_count_week > 2.5) => 0.0449835951, 0.0020250852)), 0.0000167580);

// Tree: 874
final_score_874 := map(
( NULL < rv_L79_adls_per_addr_curr and rv_L79_adls_per_addr_curr <= 10.5) => 0.0010042769, 
(rv_L79_adls_per_addr_curr > 10.5) => map(
   ( NULL < rv_I62_inq_addrs_per_adl and rv_I62_inq_addrs_per_adl <= 2.5) => map(
      ( NULL < nf_fp_srchphonesrchcountwk and nf_fp_srchphonesrchcountwk <= 0.5) => -0.0239188196, 
      (nf_fp_srchphonesrchcountwk > 0.5) => -0.0726828544, -0.0306835633), 
   (rv_I62_inq_addrs_per_adl > 2.5) => 0.0421420355, -0.0227415779), 0.0005418660);

final_score := sum(
final_score_0, final_score_1, final_score_2,
final_score_3, final_score_4, final_score_5,
final_score_6, final_score_7, final_score_8,
final_score_9, final_score_10, final_score_11,
final_score_12, final_score_13, final_score_14,
final_score_15, final_score_16, final_score_17,
final_score_18, final_score_19, final_score_20,
final_score_21, final_score_22, final_score_23,
final_score_24, final_score_25, final_score_26,
final_score_27, final_score_28, final_score_29,
final_score_30, final_score_31, final_score_32,
final_score_33, final_score_34, final_score_35,
final_score_36, final_score_37, final_score_38,
final_score_39, final_score_40, final_score_41,
final_score_42, final_score_43, final_score_44,
final_score_45, final_score_46, final_score_47,
final_score_48, final_score_49, final_score_50,
final_score_51, final_score_52, final_score_53,
final_score_54, final_score_55, final_score_56,
final_score_57, final_score_58, final_score_59,
final_score_60, final_score_61, final_score_62,
final_score_63, final_score_64, final_score_65,
final_score_66, final_score_67, final_score_68,
final_score_69, final_score_70, final_score_71,
final_score_72, final_score_73, final_score_74,
final_score_75, final_score_76, final_score_77,
final_score_78, final_score_79, final_score_80,
final_score_81, final_score_82, final_score_83,
final_score_84, final_score_85, final_score_86,
final_score_87, final_score_88, final_score_89,
final_score_90, final_score_91, final_score_92,
final_score_93, final_score_94, final_score_95,
final_score_96, final_score_97, final_score_98,
final_score_99, final_score_100, final_score_101,
final_score_102, final_score_103, final_score_104,
final_score_105, final_score_106, final_score_107,
final_score_108, final_score_109, final_score_110,
final_score_111, final_score_112, final_score_113,
final_score_114, final_score_115, final_score_116,
final_score_117, final_score_118, final_score_119,
final_score_120, final_score_121, final_score_122,
final_score_123, final_score_124, final_score_125,
final_score_126, final_score_127, final_score_128,
final_score_129, final_score_130, final_score_131,
final_score_132, final_score_133, final_score_134,
final_score_135, final_score_136, final_score_137,
final_score_138, final_score_139, final_score_140,
final_score_141, final_score_142, final_score_143,
final_score_144, final_score_145, final_score_146,
final_score_147, final_score_148, final_score_149,
final_score_150, final_score_151, final_score_152,
final_score_153, final_score_154, final_score_155,
final_score_156, final_score_157, final_score_158,
final_score_159, final_score_160, final_score_161,
final_score_162, final_score_163, final_score_164,
final_score_165, final_score_166, final_score_167,
final_score_168, final_score_169, final_score_170,
final_score_171, final_score_172, final_score_173,
final_score_174, final_score_175, final_score_176,
final_score_177, final_score_178, final_score_179,
final_score_180, final_score_181, final_score_182,
final_score_183, final_score_184, final_score_185,
final_score_186, final_score_187, final_score_188,
final_score_189, final_score_190, final_score_191,
final_score_192, final_score_193, final_score_194,
final_score_195, final_score_196, final_score_197,
final_score_198, final_score_199, final_score_200,
final_score_201, final_score_202, final_score_203,
final_score_204, final_score_205, final_score_206,
final_score_207, final_score_208, final_score_209,
final_score_210, final_score_211, final_score_212,
final_score_213, final_score_214, final_score_215,
final_score_216, final_score_217, final_score_218,
final_score_219, final_score_220, final_score_221,
final_score_222, final_score_223, final_score_224,
final_score_225, final_score_226, final_score_227,
final_score_228, final_score_229, final_score_230,
final_score_231, final_score_232, final_score_233,
final_score_234, final_score_235, final_score_236,
final_score_237, final_score_238, final_score_239,
final_score_240, final_score_241, final_score_242,
final_score_243, final_score_244, final_score_245,
final_score_246, final_score_247, final_score_248,
final_score_249, final_score_250, final_score_251,
final_score_252, final_score_253, final_score_254,
final_score_255, final_score_256, final_score_257,
final_score_258, final_score_259, final_score_260,
final_score_261, final_score_262, final_score_263,
final_score_264, final_score_265, final_score_266,
final_score_267, final_score_268, final_score_269,
final_score_270, final_score_271, final_score_272,
final_score_273, final_score_274, final_score_275,
final_score_276, final_score_277, final_score_278,
final_score_279, final_score_280, final_score_281,
final_score_282, final_score_283, final_score_284,
final_score_285, final_score_286, final_score_287,
final_score_288, final_score_289, final_score_290,
final_score_291, final_score_292, final_score_293,
final_score_294, final_score_295, final_score_296,
final_score_297, final_score_298, final_score_299,
final_score_300, final_score_301, final_score_302,
final_score_303, final_score_304, final_score_305,
final_score_306, final_score_307, final_score_308,
final_score_309, final_score_310, final_score_311,
final_score_312, final_score_313, final_score_314,
final_score_315, final_score_316, final_score_317,
final_score_318, final_score_319, final_score_320,
final_score_321, final_score_322, final_score_323,
final_score_324, final_score_325, final_score_326,
final_score_327, final_score_328, final_score_329,
final_score_330, final_score_331, final_score_332,
final_score_333, final_score_334, final_score_335,
final_score_336, final_score_337, final_score_338,
final_score_339, final_score_340, final_score_341,
final_score_342, final_score_343, final_score_344,
final_score_345, final_score_346, final_score_347,
final_score_348, final_score_349, final_score_350,
final_score_351, final_score_352, final_score_353,
final_score_354, final_score_355, final_score_356,
final_score_357, final_score_358, final_score_359,
final_score_360, final_score_361, final_score_362,
final_score_363, final_score_364, final_score_365,
final_score_366, final_score_367, final_score_368,
final_score_369, final_score_370, final_score_371,
final_score_372, final_score_373, final_score_374,
final_score_375, final_score_376, final_score_377,
final_score_378, final_score_379, final_score_380,
final_score_381, final_score_382, final_score_383,
final_score_384, final_score_385, final_score_386,
final_score_387, final_score_388, final_score_389,
final_score_390, final_score_391, final_score_392,
final_score_393, final_score_394, final_score_395,
final_score_396, final_score_397, final_score_398,
final_score_399, final_score_400, final_score_401,
final_score_402, final_score_403, final_score_404,
final_score_405, final_score_406, final_score_407,
final_score_408, final_score_409, final_score_410,
final_score_411, final_score_412, final_score_413,
final_score_414, final_score_415, final_score_416,
final_score_417, final_score_418, final_score_419,
final_score_420, final_score_421, final_score_422,
final_score_423, final_score_424, final_score_425,
final_score_426, final_score_427, final_score_428,
final_score_429, final_score_430, final_score_431,
final_score_432, final_score_433, final_score_434,
final_score_435, final_score_436, final_score_437,
final_score_438, final_score_439, final_score_440,
final_score_441, final_score_442, final_score_443,
final_score_444, final_score_445, final_score_446,
final_score_447, final_score_448, final_score_449,
final_score_450, final_score_451, final_score_452,
final_score_453, final_score_454, final_score_455,
final_score_456, final_score_457, final_score_458,
final_score_459, final_score_460, final_score_461,
final_score_462, final_score_463, final_score_464,
final_score_465, final_score_466, final_score_467,
final_score_468, final_score_469, final_score_470,
final_score_471, final_score_472, final_score_473,
final_score_474, final_score_475, final_score_476,
final_score_477, final_score_478, final_score_479,
final_score_480, final_score_481, final_score_482,
final_score_483, final_score_484, final_score_485,
final_score_486, final_score_487, final_score_488,
final_score_489, final_score_490, final_score_491,
final_score_492, final_score_493, final_score_494,
final_score_495, final_score_496, final_score_497,
final_score_498, final_score_499, final_score_500,
final_score_501, final_score_502, final_score_503,
final_score_504, final_score_505, final_score_506,
final_score_507, final_score_508, final_score_509,
final_score_510, final_score_511, final_score_512,
final_score_513, final_score_514, final_score_515,
final_score_516, final_score_517, final_score_518,
final_score_519, final_score_520, final_score_521,
final_score_522, final_score_523, final_score_524,
final_score_525, final_score_526, final_score_527,
final_score_528, final_score_529, final_score_530,
final_score_531, final_score_532, final_score_533,
final_score_534, final_score_535, final_score_536,
final_score_537, final_score_538, final_score_539,
final_score_540, final_score_541, final_score_542,
final_score_543, final_score_544, final_score_545,
final_score_546, final_score_547, final_score_548,
final_score_549, final_score_550, final_score_551,
final_score_552, final_score_553, final_score_554,
final_score_555, final_score_556, final_score_557,
final_score_558, final_score_559, final_score_560,
final_score_561, final_score_562, final_score_563,
final_score_564, final_score_565, final_score_566,
final_score_567, final_score_568, final_score_569,
final_score_570, final_score_571, final_score_572,
final_score_573, final_score_574, final_score_575,
final_score_576, final_score_577, final_score_578,
final_score_579, final_score_580, final_score_581,
final_score_582, final_score_583, final_score_584,
final_score_585, final_score_586, final_score_587,
final_score_588, final_score_589, final_score_590,
final_score_591, final_score_592, final_score_593,
final_score_594, final_score_595, final_score_596,
final_score_597, final_score_598, final_score_599,
final_score_600, final_score_601, final_score_602,
final_score_603, final_score_604, final_score_605,
final_score_606, final_score_607, final_score_608,
final_score_609, final_score_610, final_score_611,
final_score_612, final_score_613, final_score_614,
final_score_615, final_score_616, final_score_617,
final_score_618, final_score_619, final_score_620,
final_score_621, final_score_622, final_score_623,
final_score_624, final_score_625, final_score_626,
final_score_627, final_score_628, final_score_629,
final_score_630, final_score_631, final_score_632,
final_score_633, final_score_634, final_score_635,
final_score_636, final_score_637, final_score_638,
final_score_639, final_score_640, final_score_641,
final_score_642, final_score_643, final_score_644,
final_score_645, final_score_646, final_score_647,
final_score_648, final_score_649, final_score_650,
final_score_651, final_score_652, final_score_653,
final_score_654, final_score_655, final_score_656,
final_score_657, final_score_658, final_score_659,
final_score_660, final_score_661, final_score_662,
final_score_663, final_score_664, final_score_665,
final_score_666, final_score_667, final_score_668,
final_score_669, final_score_670, final_score_671,
final_score_672, final_score_673, final_score_674,
final_score_675, final_score_676, final_score_677,
final_score_678, final_score_679, final_score_680,
final_score_681, final_score_682, final_score_683,
final_score_684, final_score_685, final_score_686,
final_score_687, final_score_688, final_score_689,
final_score_690, final_score_691, final_score_692,
final_score_693, final_score_694, final_score_695,
final_score_696, final_score_697, final_score_698,
final_score_699, final_score_700, final_score_701,
final_score_702, final_score_703, final_score_704,
final_score_705, final_score_706, final_score_707,
final_score_708, final_score_709, final_score_710,
final_score_711, final_score_712, final_score_713,
final_score_714, final_score_715, final_score_716,
final_score_717, final_score_718, final_score_719,
final_score_720, final_score_721, final_score_722,
final_score_723, final_score_724, final_score_725,
final_score_726, final_score_727, final_score_728,
final_score_729, final_score_730, final_score_731,
final_score_732, final_score_733, final_score_734,
final_score_735, final_score_736, final_score_737,
final_score_738, final_score_739, final_score_740,
final_score_741, final_score_742, final_score_743,
final_score_744, final_score_745, final_score_746,
final_score_747, final_score_748, final_score_749,
final_score_750, final_score_751, final_score_752,
final_score_753, final_score_754, final_score_755,
final_score_756, final_score_757, final_score_758,
final_score_759, final_score_760, final_score_761,
final_score_762, final_score_763, final_score_764,
final_score_765, final_score_766, final_score_767,
final_score_768, final_score_769, final_score_770,
final_score_771, final_score_772, final_score_773,
final_score_774, final_score_775, final_score_776,
final_score_777, final_score_778, final_score_779,
final_score_780, final_score_781, final_score_782,
final_score_783, final_score_784, final_score_785,
final_score_786, final_score_787, final_score_788,
final_score_789, final_score_790, final_score_791,
final_score_792, final_score_793, final_score_794,
final_score_795, final_score_796, final_score_797,
final_score_798, final_score_799, final_score_800,
final_score_801, final_score_802, final_score_803,
final_score_804, final_score_805, final_score_806,
final_score_807, final_score_808, final_score_809,
final_score_810, final_score_811, final_score_812,
final_score_813, final_score_814, final_score_815,
final_score_816, final_score_817, final_score_818,
final_score_819, final_score_820, final_score_821,
final_score_822, final_score_823, final_score_824,
final_score_825, final_score_826, final_score_827,
final_score_828, final_score_829, final_score_830,
final_score_831, final_score_832, final_score_833,
final_score_834, final_score_835, final_score_836,
final_score_837, final_score_838, final_score_839,
final_score_840, final_score_841, final_score_842,
final_score_843, final_score_844, final_score_845,
final_score_846, final_score_847, final_score_848,
final_score_849, final_score_850, final_score_851,
final_score_852, final_score_853, final_score_854,
final_score_855, final_score_856, final_score_857,
final_score_858, final_score_859, final_score_860,
final_score_861, final_score_862, final_score_863,
final_score_864, final_score_865, final_score_866,
final_score_867, final_score_868, final_score_869,
final_score_870, final_score_871, final_score_872,
final_score_873, final_score_874);


base := __common__( 700);

pts := __common__( -50);

lgt := __common__( ln(0.1075601 / (1 - 0.1075601)));

fp1611_1_0 := __common__( round(max((real)300, min(999, if(base + pts * (final_score - lgt) / ln(2) = NULL, -NULL, base + pts * (final_score - lgt) / ln(2))))));

_ver_src_ds := __common__( Models.Common.findw_cpp(ver_sources, 'DS' , ',', '') > 0);

_ver_src_de := __common__( Models.Common.findw_cpp(ver_sources, 'DE' , ',', '') > 0);

_ver_src_eq := __common__( Models.Common.findw_cpp(ver_sources, 'EQ' , ',', '') > 0);

_ver_src_en := __common__( Models.Common.findw_cpp(ver_sources, 'EN' , ',', '') > 0);

_ver_src_tn := __common__( Models.Common.findw_cpp(ver_sources, 'TN' , ',', '') > 0);

_ver_src_tu := __common__( Models.Common.findw_cpp(ver_sources, 'TU' , ',', '') > 0);

_credit_source_cnt := __common__( if(max((integer)_ver_src_eq, (integer)_ver_src_en, (integer)_ver_src_tn, (integer)_ver_src_tu) = NULL, NULL, sum((integer)_ver_src_eq, (integer)_ver_src_en, (integer)_ver_src_tn, (integer)_ver_src_tu)));

_ver_src_cnt := __common__( Models.Common.countw((string)(ver_sources), ' !$%&()*+,-./);<^|'));

_bureauonly := __common__( _credit_source_cnt > 0 AND _credit_source_cnt = _ver_src_cnt AND (StringLib.StringToUpperCase(nap_type) = 'U' or (nap_summary in [0, 1, 2, 3, 4, 6])));

_derog := __common__( felony_count > 0 OR (Integer)addrs_prison_history > 0 OR attr_num_unrel_liens60 > 0 OR attr_eviction_count > 0 OR stl_inq_count > 0 OR inq_highriskcredit_count12 > 0 OR inq_collection_count12 >= 2);

_deceased := __common__( rc_decsflag = '1' OR rc_ssndod != 0 OR _ver_src_ds OR _ver_src_de);

_ssnpriortodob := __common__( rc_ssndobflag = '1' OR rc_pwssndobflag = '1');

_inputmiskeys := __common__( rc_ssnmiskeyflag or rc_addrmiskeyflag or (Integer)add_input_house_number_match = 0);

_multiplessns := __common__( ssns_per_adl >= 2 OR ssns_per_adl_c6 >= 1 OR invalid_ssns_per_adl >= 1);

_hh_strikes := __common__( if((Real)max((integer)hh_members_w_derog > 0, (integer)hh_criminals > 0, (integer)hh_payday_loan_users > 0) = NULL, NULL, (Real)sum((integer)hh_members_w_derog > 0, (integer)hh_criminals > 0, (integer)hh_payday_loan_users > 0)));

stolenid := __common__( if(addrpop and (nas_summary in [4, 7, 9]) or fnamepop and lnamepop and addrpop and 1 <= nas_summary AND nas_summary <= 9 and inq_count03 > 0 and ssnlength = '9' or _deceased or _ssnpriortodob, 1, 0));

manipulatedid := __common__( if(_inputmiskeys and (_multiplessns or lnames_per_adl_c6 > 1), 1, 0));

manipulatedidpt2 := __common__( if(1 <= nas_summary AND nas_summary <= 9 and inq_count03 > 0 and ssnlength = '9', 1, 0));

syntheticid := __common__( if(fnamepop and lnamepop and addrpop and ssnlength = '9' and hphnpop and nap_summary <= 4 and nas_summary <= 4 or _ver_src_cnt = 0 or _bureauonly or (Integer)add_curr_pop = 0, 1, 0));

suspiciousactivity := __common__( if(_derog, 1, 0));

vulnerablevictim := __common__( if(0 < inferred_age AND inferred_age <= 17 or inferred_age >= 70, 1, 0));

friendlyfraud := __common__( if(hh_members_ct > 1 and (hh_payday_loan_users > 0 or _hh_strikes >= 2 or rel_felony_count >= 2), 1, 0));

stolenc_fp1611_1_0 := __common__( if((Boolean) (Integer)stolenid, fp1611_1_0, 299));

manip2c_fp1611_1_0 := __common__( if((boolean)(integer)manipulatedid or (boolean)(integer)manipulatedidpt2, fp1611_1_0, 299));

synthc_fp1611_1_0 := __common__( if((Boolean) (Integer)syntheticid, fp1611_1_0, 299));

suspactc_fp1611_1_0 := __common__( if((Boolean) (Integer)suspiciousactivity, fp1611_1_0, 299));

vulnvicc_fp1611_1_0 := __common__( if((Boolean) (Integer)vulnerablevictim, fp1611_1_0, 299));

friendlyc_fp1611_1_0 := __common__( if((Boolean) (Integer)friendlyfraud, fp1611_1_0, 299));

custstolidindex := __common__( map(
    stolenc_fp1611_1_0 = 299                                => 1,
    300 <= stolenc_fp1611_1_0 AND stolenc_fp1611_1_0 <= 540 => 9,
    540 < stolenc_fp1611_1_0 AND stolenc_fp1611_1_0 <= 580  => 8,
    580 < stolenc_fp1611_1_0 AND stolenc_fp1611_1_0 <= 620  => 7,
    620 < stolenc_fp1611_1_0 AND stolenc_fp1611_1_0 <= 640  => 6,
    640 < stolenc_fp1611_1_0 AND stolenc_fp1611_1_0 <= 680  => 5,
    680 < stolenc_fp1611_1_0 AND stolenc_fp1611_1_0 <= 720  => 4,
    720 < stolenc_fp1611_1_0 AND stolenc_fp1611_1_0 <= 760  => 3,
    760 < stolenc_fp1611_1_0 AND stolenc_fp1611_1_0 <= 999  => 2,
                                                               99));

custmanipidindex := __common__( map(
    manip2c_fp1611_1_0 = 299                                => 1,
    300 <= manip2c_fp1611_1_0 AND manip2c_fp1611_1_0 <= 560 => 9,
    560 < manip2c_fp1611_1_0 AND manip2c_fp1611_1_0 <= 600  => 8,
    600 < manip2c_fp1611_1_0 AND manip2c_fp1611_1_0 <= 640  => 7,
    640 < manip2c_fp1611_1_0 AND manip2c_fp1611_1_0 <= 660  => 6,
    660 < manip2c_fp1611_1_0 AND manip2c_fp1611_1_0 <= 680  => 5,
    680 < manip2c_fp1611_1_0 AND manip2c_fp1611_1_0 <= 720  => 4,
    720 < manip2c_fp1611_1_0 AND manip2c_fp1611_1_0 <= 760  => 3,
    760 < manip2c_fp1611_1_0 AND manip2c_fp1611_1_0 <= 999  => 2,
                                                               99));

custsynthidindex := __common__( map(
    synthc_fp1611_1_0 = 299                               => 1,
    300 <= synthc_fp1611_1_0 AND synthc_fp1611_1_0 <= 560 => 9,
    560 < synthc_fp1611_1_0 AND synthc_fp1611_1_0 <= 620  => 8,
    620 < synthc_fp1611_1_0 AND synthc_fp1611_1_0 <= 660  => 7,
    660 < synthc_fp1611_1_0 AND synthc_fp1611_1_0 <= 680  => 6,
    680 < synthc_fp1611_1_0 AND synthc_fp1611_1_0 <= 720  => 5,
    720 < synthc_fp1611_1_0 AND synthc_fp1611_1_0 <= 740  => 4,
    740 < synthc_fp1611_1_0 AND synthc_fp1611_1_0 <= 780  => 3,
    780 < synthc_fp1611_1_0 AND synthc_fp1611_1_0 <= 999  => 2,
                                                             99));

custsuspactindex := __common__( map(
    suspactc_fp1611_1_0 = 299                                 => 1,
    300 <= suspactc_fp1611_1_0 AND suspactc_fp1611_1_0 <= 520 => 9,
    520 < suspactc_fp1611_1_0 AND suspactc_fp1611_1_0 <= 560  => 8,
    560 < suspactc_fp1611_1_0 AND suspactc_fp1611_1_0 <= 600  => 7,
    600 < suspactc_fp1611_1_0 AND suspactc_fp1611_1_0 <= 640  => 6,
    640 < suspactc_fp1611_1_0 AND suspactc_fp1611_1_0 <= 680  => 5,
    680 < suspactc_fp1611_1_0 AND suspactc_fp1611_1_0 <= 720  => 4,
    720 < suspactc_fp1611_1_0 AND suspactc_fp1611_1_0 <= 780  => 3,
    780 < suspactc_fp1611_1_0 AND suspactc_fp1611_1_0 <= 999  => 2,
                                                                 99));

custvulnvicindex := __common__( map(
    vulnvicc_fp1611_1_0 = 299                                 => 1,
    300 <= vulnvicc_fp1611_1_0 AND vulnvicc_fp1611_1_0 <= 580 => 9,
    580 < vulnvicc_fp1611_1_0 AND vulnvicc_fp1611_1_0 <= 620  => 8,
    620 < vulnvicc_fp1611_1_0 AND vulnvicc_fp1611_1_0 <= 660  => 7,
    660 < vulnvicc_fp1611_1_0 AND vulnvicc_fp1611_1_0 <= 700  => 6,
    700 < vulnvicc_fp1611_1_0 AND vulnvicc_fp1611_1_0 <= 720  => 5,
    720 < vulnvicc_fp1611_1_0 AND vulnvicc_fp1611_1_0 <= 740  => 4,
    740 < vulnvicc_fp1611_1_0 AND vulnvicc_fp1611_1_0 <= 780  => 3,
    780 < vulnvicc_fp1611_1_0 AND vulnvicc_fp1611_1_0 <= 999  => 2,
                                                                 99));

custfriendfrdindex := __common__( map(
    friendlyc_fp1611_1_0 = 299                                  => 1,
    300 <= friendlyc_fp1611_1_0 AND friendlyc_fp1611_1_0 <= 540 => 9,
    540 < friendlyc_fp1611_1_0 AND friendlyc_fp1611_1_0 <= 580  => 8,
    580 < friendlyc_fp1611_1_0 AND friendlyc_fp1611_1_0 <= 620  => 7,
    620 < friendlyc_fp1611_1_0 AND friendlyc_fp1611_1_0 <= 640  => 6,
    640 < friendlyc_fp1611_1_0 AND friendlyc_fp1611_1_0 <= 680  => 5,
    680 < friendlyc_fp1611_1_0 AND friendlyc_fp1611_1_0 <= 720  => 4,
    720 < friendlyc_fp1611_1_0 AND friendlyc_fp1611_1_0 <= 760  => 3,
    760 < friendlyc_fp1611_1_0 AND friendlyc_fp1611_1_0 <= 999  => 2,
                                                                   99));



	#if(MODEL_DEBUG)
		/* Model Input Variables */
   //self.seq                              := seq;
	 self.sysdate                          := sysdate;
   self.iv_add_apt                       := iv_add_apt;
   self.rv_s65_ssn_prior_dob             := rv_s65_ssn_prior_dob;
   self.rv_c16_inv_ssn_per_adl           := rv_c16_inv_ssn_per_adl;
   self.rv_s65_ssn_problem               := rv_s65_ssn_problem;
   self.rv_p88_phn_dst_to_inp_add        := rv_p88_phn_dst_to_inp_add;
   self.iv_phn_cell                      := iv_phn_cell;
   self.iv_phn_pcs                       := iv_phn_pcs;
   self.add_ec3                          := add_ec3;
   self.add_ec4                          := add_ec4;
   self.rv_l70_add_standardized          := rv_l70_add_standardized;
   self.rv_l72_add_curr_vacant           := rv_l72_add_curr_vacant;
   self.rv_l74_add_curr_throwback        := rv_l74_add_curr_throwback;
   self.rv_l76_add_curr_seasonal         := rv_l76_add_curr_seasonal;
   self.rv_c19_add_prison_hist           := rv_c19_add_prison_hist;
   self.rv_f00_dob_score                 := rv_f00_dob_score;
   self.rv_f01_inp_addr_address_score    := rv_f01_inp_addr_address_score;
   self.rv_f00_input_dob_match_level     := rv_f00_input_dob_match_level;
   self.rv_d30_derog_count               := rv_d30_derog_count;
   self.rv_d32_criminal_count            := rv_d32_criminal_count;
   self.rv_d32_felony_count              := rv_d32_felony_count;
   self.rv_d32_criminal_x_felony         := rv_d32_criminal_x_felony;
   self._criminal_last_date              := _criminal_last_date;
   self.rv_d32_mos_since_crim_ls         := rv_d32_mos_since_crim_ls;
   self._felony_last_date                := _felony_last_date;
   self.rv_d32_mos_since_fel_ls          := rv_d32_mos_since_fel_ls;
   self.rv_d31_mostrec_bk                := rv_d31_mostrec_bk;
   self.rv_d31_all_bk   := rv_d31_all_bk;
   self.rv_d31_bk_dism_recent_count      := rv_d31_bk_dism_recent_count;
   self.rv_c21_stl_recency               := rv_c21_stl_recency;
   self.rv_d33_eviction_recency          := rv_d33_eviction_recency;
   self.rv_d33_eviction_count            := rv_d33_eviction_count;
   self.rv_d34_unrel_liens_ct            := rv_d34_unrel_liens_ct;
   self.iv_d34_liens_unrel_x_rel         := iv_d34_liens_unrel_x_rel;
   self._src_bureau_adl_fseen            := _src_bureau_adl_fseen;
   self.rv_c20_m_bureau_adl_fs           := rv_c20_m_bureau_adl_fs;
   self.num_dob_match_level              := num_dob_match_level;
   self.nas_summary_ver                  := nas_summary_ver;
   self.nap_summary_ver                  := nap_summary_ver;
   self.infutor_nap_ver                  := infutor_nap_ver;
   self.dob_ver         := dob_ver;
   self.sufficiently_verified            := sufficiently_verified;
   self.add_ec1         := add_ec1;
   self.addr_validation_problem          := addr_validation_problem;
   self.phn_validation_problem           := phn_validation_problem;
   self.validation_problem               := validation_problem;
   self.tot_liens       := tot_liens;
   self.tot_liens_w_type                 := tot_liens_w_type;
   self.has_derog       := has_derog;
   self.rv_6seg_riskview_5_0             := rv_6seg_riskview_5_0;
   self.rv_4seg_riskview_5_0             := rv_4seg_riskview_5_0;
   self.nf_m_bureau_adl_fs_all           := nf_m_bureau_adl_fs_all;
   self._src_bureau_adl_fseen_notu       := _src_bureau_adl_fseen_notu;
   self.nf_m_bureau_adl_fs_notu          := nf_m_bureau_adl_fs_notu;
   self._header_first_seen               := _header_first_seen;
   self.rv_c10_m_hdr_fs                  := rv_c10_m_hdr_fs;
   self.rv_c12_source_profile            := rv_c12_source_profile;
   self.rv_s66_adlperssn_count           := rv_s66_adlperssn_count;
   self._in_dob         := _in_dob;
   self.yr_in_dob       := yr_in_dob;
   self.yr_in_dob_int   := yr_in_dob_int;
   self.rv_comb_age     := rv_comb_age;
   self.rv_f01_inp_addr_not_verified     := rv_f01_inp_addr_not_verified;
   self.rv_l80_inp_avm_autoval           := rv_l80_inp_avm_autoval;
   self.rv_a46_curr_avm_autoval          := rv_a46_curr_avm_autoval;
   self.rv_a49_curr_avm_chg_1yr          := rv_a49_curr_avm_chg_1yr;
   self.rv_a49_curr_avm_chg_1yr_pct      := rv_a49_curr_avm_chg_1yr_pct;
   self.rv_c13_curr_addr_lres            := rv_c13_curr_addr_lres;
   self.rv_c14_addr_stability_v2         := rv_c14_addr_stability_v2;
   self.rv_c13_max_lres                  := rv_c13_max_lres;
   self.rv_c14_addrs_5yr                 := rv_c14_addrs_5yr;
   self.rv_c14_addrs_10yr                := rv_c14_addrs_10yr;
   self.rv_c14_addrs_per_adl_c6          := rv_c14_addrs_per_adl_c6;
   self.rv_c14_addrs_15yr                := rv_c14_addrs_15yr;
   self.rv_c22_inp_addr_occ_index        := rv_c22_inp_addr_occ_index;
   self.rv_c22_inp_addr_owned_not_occ    := rv_c22_inp_addr_owned_not_occ;
   self.rv_a41_prop_owner                := rv_a41_prop_owner;
   self.rv_a41_a42_prop_owner_history    := rv_a41_a42_prop_owner_history;
   self.rv_email_count                   := rv_email_count;
   self.rv_email_domain_free_count       := rv_email_domain_free_count;
   self.rv_email_domain_isp_count        := rv_email_domain_isp_count;
   self.rv_i60_inq_count12               := rv_i60_inq_count12;
   self.rv_i60_credit_seeking            := rv_i60_credit_seeking;
   self.rv_i60_inq_recency               := rv_i60_inq_recency;
   self.rv_i61_inq_collection_count12    := rv_i61_inq_collection_count12;
   self.rv_i61_inq_collection_recency    := rv_i61_inq_collection_recency;
   self.rv_i60_inq_auto_count12          := rv_i60_inq_auto_count12;
   self.rv_i60_inq_auto_recency          := rv_i60_inq_auto_recency;
   self.rv_i60_inq_banking_count12       := rv_i60_inq_banking_count12;
   self.rv_i60_inq_mortgage_count12      := rv_i60_inq_mortgage_count12;
   self.rv_i60_inq_hiriskcred_count12    := rv_i60_inq_hiriskcred_count12;
   self.rv_i60_inq_hiriskcred_recency    := rv_i60_inq_hiriskcred_recency;
   self.rv_i60_inq_prepaidcards_recency  := rv_i60_inq_prepaidcards_recency;
   self.rv_i60_inq_retail_recency        := rv_i60_inq_retail_recency;
   self.rv_i60_inq_retpymt_count12       := rv_i60_inq_retpymt_count12;
   self.rv_i60_inq_retpymt_recency       := rv_i60_inq_retpymt_recency;
   self.rv_i60_inq_comm_count12          := rv_i60_inq_comm_count12;
   self.rv_i60_inq_comm_recency          := rv_i60_inq_comm_recency;
   self.rv_l79_adls_per_addr_curr        := rv_l79_adls_per_addr_curr;
   self.rv_l79_adls_per_apt_addr         := rv_l79_adls_per_apt_addr;
   self.rv_l79_adls_per_sfd_addr         := rv_l79_adls_per_sfd_addr;
   self.rv_l79_adls_per_addr_c6          := rv_l79_adls_per_addr_c6;
   self.rv_l79_adls_per_apt_addr_c6      := rv_l79_adls_per_apt_addr_c6;
   self.rv_l79_adls_per_sfd_addr_c6      := rv_l79_adls_per_sfd_addr_c6;
   self.rv_c18_invalid_addrs_per_adl     := rv_c18_invalid_addrs_per_adl;
   self.rv_c13_attr_addrs_recency        := rv_c13_attr_addrs_recency;
   self.rv_d32_attr_felonies_recency     := rv_d32_attr_felonies_recency;
   self.rv_d34_attr_liens_recency        := rv_d34_attr_liens_recency;
   self.iv_f00_nas_summary               := iv_f00_nas_summary;
   self.iv_fname_non_phn_src_ct          := iv_fname_non_phn_src_ct;
   self.iv_lname_non_phn_src_ct          := iv_lname_non_phn_src_ct;
   self.iv_full_name_non_phn_src_ct      := iv_full_name_non_phn_src_ct;
   self.iv_full_name_ver_sources         := iv_full_name_ver_sources;
   self.iv_addr_non_phn_src_ct           := iv_addr_non_phn_src_ct;
   self.iv_c22_addr_ver_sources          := iv_c22_addr_ver_sources;
   self.iv_dob_src_ct   := iv_dob_src_ct;
   self._nap_ver        := _nap_ver;
   self._inf_ver        := _inf_ver;
   self.iv_phn_addr_verified             := iv_phn_addr_verified;
   self.iv_l77_dwelltype                 := iv_l77_dwelltype;
   self.iv_c13_avg_lres                  := iv_c13_avg_lres;
   self.rv_f01_inp_add_house_num_match   := rv_f01_inp_add_house_num_match;
   self.rv_c13_inp_addr_lres             := rv_c13_inp_addr_lres;
   self.rv_c12_inp_addr_source_count     := rv_c12_inp_addr_source_count;
   self.iv_inp_addr_mortgage_type        := iv_inp_addr_mortgage_type;
   self.iv_inp_addr_financing_type       := iv_inp_addr_financing_type;
   self.iv_inp_add_avm_chg_1yr           := iv_inp_add_avm_chg_1yr;
   self.iv_inp_add_avm_pct_chg_1yr       := iv_inp_add_avm_pct_chg_1yr;
   self.iv_inp_add_avm_chg_2yr           := iv_inp_add_avm_chg_2yr;
   self.iv_inp_add_avm_pct_chg_2yr       := iv_inp_add_avm_pct_chg_2yr;
   self.iv_inp_add_avm_chg_3yr           := iv_inp_add_avm_chg_3yr;
   self.iv_inp_add_avm_pct_chg_3yr       := iv_inp_add_avm_pct_chg_3yr;
   self.mortgage_type   := mortgage_type;
   self.mortgage_present                 := mortgage_present;
   self.iv_curr_add_mortgage_type        := iv_curr_add_mortgage_type;
   self.iv_curr_add_financing_type       := iv_curr_add_financing_type;
   self.rv_a49_curr_add_avm_chg_2yr      := rv_a49_curr_add_avm_chg_2yr;
   self.rv_a49_curr_add_avm_pct_chg_2yr  := rv_a49_curr_add_avm_pct_chg_2yr;
   self.rv_a49_curr_add_avm_chg_3yr      := rv_a49_curr_add_avm_chg_3yr;
   self.rv_a49_curr_add_avm_pct_chg_3yr  := rv_a49_curr_add_avm_pct_chg_3yr;
   self.iv_prv_addr_lres                 := iv_prv_addr_lres;
   self.iv_prv_addr_avm_auto_val         := iv_prv_addr_avm_auto_val;
   self.iv_a46_l77_addrs_move_traj       := iv_a46_l77_addrs_move_traj;
   self.iv_a46_l77_addrs_move_traj_index := iv_a46_l77_addrs_move_traj_index;
   self.iv_unverified_addr_count         := iv_unverified_addr_count;
   self.iv_c14_addrs_per_adl             := iv_c14_addrs_per_adl;
   self.rv_i60_inq_other_count12         := rv_i60_inq_other_count12;
   self.rv_i60_inq_other_recency         := rv_i60_inq_other_recency;
   self.rv_i62_inq_ssns_per_adl          := rv_i62_inq_ssns_per_adl;
   self.rv_i62_inq_addrs_per_adl         := rv_i62_inq_addrs_per_adl;
   self.rv_i62_inq_num_names_per_adl     := rv_i62_inq_num_names_per_adl;
   self.rv_i62_inq_phones_per_adl        := rv_i62_inq_phones_per_adl;
   self.rv_i62_inq_dobs_per_adl          := rv_i62_inq_dobs_per_adl;
   self.br_first_seen_char               := br_first_seen_char;
   self._br_first_seen                   := _br_first_seen;
   self.rv_mos_since_br_first_seen       := rv_mos_since_br_first_seen;
   self.rv_br_active_phone_count         := rv_br_active_phone_count;
   self.iv_br_source_count               := iv_br_source_count;
   self.rv_e58_br_dead_bus_x_active_phn  := rv_e58_br_dead_bus_x_active_phn;
   self.br_company_title1                := br_company_title1;
   self.br_company_title2                := br_company_title2;
   self.rv_bus_leadership_title          := rv_bus_leadership_title;
   self.iv_d34_liens_unrel_cj_ct         := iv_d34_liens_unrel_cj_ct;
   self.iv_d34_liens_unrel_ft_ct         := iv_d34_liens_unrel_ft_ct;
   self.iv_d34_liens_unrel_sc_ct         := iv_d34_liens_unrel_sc_ct;
   self.iv_college_tier                  := iv_college_tier;
   self.major_medical   := major_medical;
   self.major_science   := major_science;
   self.major_liberal   := major_liberal;
   self.major_business                   := major_business;
   self.major_unknown   := major_unknown;
   self.iv_college_major                 := iv_college_major;
   self.iv_college_type                  := iv_college_type;
   self.iv_college_code_x_type           := iv_college_code_x_type;
   self.iv_college_file_type             := iv_college_file_type;
   self.iv_prof_license_source           := iv_prof_license_source;
   self.iv_prof_license_category         := iv_prof_license_category;
   self.iv_prof_license_category_pl      := iv_prof_license_category_pl;
   self.nf_bus_addr_match_count          := nf_bus_addr_match_count;
   self.nf_bus_phone_match               := nf_bus_phone_match;
   self.adl_util_i      := adl_util_i;
   self.adl_util_c      := adl_util_c;
   self.adl_util_m      := adl_util_m;
   self.nf_util_adl_summary              := nf_util_adl_summary;
   self.nf_util_adl_count                := nf_util_adl_count;
   self.inp_util_i      := inp_util_i;
   self.inp_util_c      := inp_util_c;
   self.inp_util_m      := inp_util_m;
   self.nf_util_add_input_summary        := nf_util_add_input_summary;
   self.curr_util_i     := curr_util_i;
   self.curr_util_c     := curr_util_c;
   self.curr_util_m     := curr_util_m;
   self.nf_util_add_curr_summary         := nf_util_add_curr_summary;
   self.nf_add_input_mobility_index      := nf_add_input_mobility_index;
   self.nf_add_input_nhood_bus_pct       := nf_add_input_nhood_bus_pct;
   self.nf_add_input_nhood_mfd_pct       := nf_add_input_nhood_mfd_pct;
   self.nf_add_input_nhood_sfd_pct       := nf_add_input_nhood_sfd_pct;
   self.add_input_nhood_prop_sum         := add_input_nhood_prop_sum;
   self.nf_add_input_nhood_vac_pct       := nf_add_input_nhood_vac_pct;
   self.nf_add_curr_mobility_index       := nf_add_curr_mobility_index;
   self.nf_add_curr_nhood_bus_pct        := nf_add_curr_nhood_bus_pct;
   self.nf_add_curr_nhood_mfd_pct        := nf_add_curr_nhood_mfd_pct;
   self.nf_add_curr_nhood_sfd_pct        := nf_add_curr_nhood_sfd_pct;
   self.add_curr_nhood_prop_sum          := add_curr_nhood_prop_sum;
   self.nf_add_curr_nhood_vac_pct        := nf_add_curr_nhood_vac_pct;
   self.nf_recent_disconnects            := nf_recent_disconnects;
   self.nf_phone_ver_insurance           := nf_phone_ver_insurance;
   self.nf_phone_ver_experian            := nf_phone_ver_experian;
   self.nf_addrs_per_ssn                 := nf_addrs_per_ssn;
   self.nf_phones_per_addr_curr          := nf_phones_per_addr_curr;
   self.nf_phones_per_apt_addr_curr      := nf_phones_per_apt_addr_curr;
   self.nf_phones_per_sfd_addr_curr      := nf_phones_per_sfd_addr_curr;
   self.nf_addrs_per_ssn_c6              := nf_addrs_per_ssn_c6;
   self.nf_phones_per_addr_c6            := nf_phones_per_addr_c6;
   self.nf_phones_per_sfd_addr_c6        := nf_phones_per_sfd_addr_c6;
   self.nf_inq_count_day                 := nf_inq_count_day;
   self.nf_inq_count_week                := nf_inq_count_week;
   self.nf_inq_count24                   := nf_inq_count24;
   self.nf_inq_auto_count_week           := nf_inq_auto_count_week;
   self.nf_inq_auto_count24              := nf_inq_auto_count24;
   self.nf_inq_banking_count_day         := nf_inq_banking_count_day;
   self.nf_inq_banking_count24           := nf_inq_banking_count24;
   self.nf_inq_collection_count_week     := nf_inq_collection_count_week;
   self.nf_inq_collection_count24        := nf_inq_collection_count24;
   self.nf_inq_communications_count_week := nf_inq_communications_count_week;
   self.nf_inq_communications_count24    := nf_inq_communications_count24;
   self.nf_inq_highriskcredit_count_day  := nf_inq_highriskcredit_count_day;
   self.nf_inq_highriskcredit_count_week := nf_inq_highriskcredit_count_week;
   self.nf_inq_highriskcredit_count24    := nf_inq_highriskcredit_count24;
   self.nf_inq_other_count_week          := nf_inq_other_count_week;
   self.nf_inq_other_count24             := nf_inq_other_count24;
   self.nf_inq_prepaidcards_count24      := nf_inq_prepaidcards_count24;
   self.nf_inq_quizprovider_count_week   := nf_inq_quizprovider_count_week;
   self.nf_inq_quizprovider_count24      := nf_inq_quizprovider_count24;
   self.nf_inq_retail_count24            := nf_inq_retail_count24;
   self.nf_inq_retailpayments_count24    := nf_inq_retailpayments_count24;
   self.nf_inq_utilities_count24         := nf_inq_utilities_count24;
   self.nf_inq_per_ssn                   := nf_inq_per_ssn;
   self.nf_inq_adls_per_ssn              := nf_inq_adls_per_ssn;
   self.nf_inq_lnames_per_ssn            := nf_inq_lnames_per_ssn;
   self.nf_inq_addrs_per_ssn             := nf_inq_addrs_per_ssn;
   self.nf_inq_dobs_per_ssn              := nf_inq_dobs_per_ssn;
   self.nf_inq_per_addr                  := nf_inq_per_addr;
   self.nf_inq_per_apt_addr              := nf_inq_per_apt_addr;
   self.nf_inq_per_sfd_addr              := nf_inq_per_sfd_addr;
   self.nf_inq_adls_per_addr             := nf_inq_adls_per_addr;
   self.nf_inq_adls_per_apt_addr         := nf_inq_adls_per_apt_addr;
   self.nf_inq_adls_per_sfd_addr         := nf_inq_adls_per_sfd_addr;
   self.nf_inq_lnames_per_apt_addr       := nf_inq_lnames_per_apt_addr;
   self.nf_inq_lnames_per_sfd_addr       := nf_inq_lnames_per_sfd_addr;
   self.nf_inq_ssns_per_addr             := nf_inq_ssns_per_addr;
   self.nf_inq_ssns_per_apt_addr         := nf_inq_ssns_per_apt_addr;
   self.nf_inq_ssns_per_sfd_addr         := nf_inq_ssns_per_sfd_addr;
   self.nf_inq_per_phone                 := nf_inq_per_phone;
   self.nf_inq_adls_per_phone            := nf_inq_adls_per_phone;
   self.nf_attr_arrest_recency           := nf_attr_arrest_recency;
   self._liens_unrel_cj_first_seen       := _liens_unrel_cj_first_seen;
   self.nf_mos_liens_unrel_cj_fseen      := nf_mos_liens_unrel_cj_fseen;
   self._liens_unrel_cj_last_seen        := _liens_unrel_cj_last_seen;
   self.nf_mos_liens_unrel_cj_lseen      := nf_mos_liens_unrel_cj_lseen;
   self.nf_liens_unrel_cj_total_amt      := nf_liens_unrel_cj_total_amt;
   self._liens_rel_cj_last_seen          := _liens_rel_cj_last_seen;
   self.nf_mos_liens_rel_cj_lseen        := nf_mos_liens_rel_cj_lseen;
   self.nf_liens_rel_cj_total_amt        := nf_liens_rel_cj_total_amt;
   self._liens_unrel_ft_last_seen        := _liens_unrel_ft_last_seen;
   self.nf_mos_liens_unrel_ft_lseen      := nf_mos_liens_unrel_ft_lseen;
   self.nf_liens_unrel_ft_total_amt      := nf_liens_unrel_ft_total_amt;
   self._liens_rel_ft_first_seen         := _liens_rel_ft_first_seen;
   self.nf_mos_liens_rel_ft_fseen        := nf_mos_liens_rel_ft_fseen;
   self._liens_rel_ft_last_seen          := _liens_rel_ft_last_seen;
   self.nf_mos_liens_rel_ft_lseen        := nf_mos_liens_rel_ft_lseen;
   self._liens_unrel_fc_first_seen       := _liens_unrel_fc_first_seen;
   self.nf_mos_liens_unrel_fc_fseen      := nf_mos_liens_unrel_fc_fseen;
   self.nf_liens_unrel_fc_total_amt      := nf_liens_unrel_fc_total_amt;
   self.nf_liens_unrel_o_total_amt       := nf_liens_unrel_o_total_amt;
   self._liens_unrel_ot_last_seen        := _liens_unrel_ot_last_seen;
   self.nf_mos_liens_unrel_ot_lseen      := nf_mos_liens_unrel_ot_lseen;
   self.nf_liens_unrel_ot_total_amt      := nf_liens_unrel_ot_total_amt;
   self._liens_unrel_sc_last_seen        := _liens_unrel_sc_last_seen;
   self.nf_mos_liens_unrel_sc_lseen      := nf_mos_liens_unrel_sc_lseen;
   self.nf_liens_unrel_sc_total_amt      := nf_liens_unrel_sc_total_amt;
   self._liens_rel_sc_first_seen         := _liens_rel_sc_first_seen;
   self.nf_mos_liens_rel_sc_fseen        := nf_mos_liens_rel_sc_fseen;
   self._liens_rel_sc_last_seen          := _liens_rel_sc_last_seen;
   self.nf_mos_liens_rel_sc_lseen        := nf_mos_liens_rel_sc_lseen;
   self.nf_liens_rel_sc_total_amt        := nf_liens_rel_sc_total_amt;
   self.nf_liens_unrel_st_ct             := nf_liens_unrel_st_ct;
   self._liens_unrel_st_first_seen       := _liens_unrel_st_first_seen;
   self.nf_mos_liens_unrel_st_fseen      := nf_mos_liens_unrel_st_fseen;
   self._liens_unrel_st_last_seen        := _liens_unrel_st_last_seen;
   self.nf_mos_liens_unrel_st_lseen      := nf_mos_liens_unrel_st_lseen;
   self.nf_liens_unrel_st_total_amt      := nf_liens_unrel_st_total_amt;
   self._foreclosure_last_date           := _foreclosure_last_date;
   self.nf_mos_foreclosure_lseen         := nf_mos_foreclosure_lseen;
   self.iv_estimated_income              := iv_estimated_income;
   self.iv_wealth_index                  := iv_wealth_index;
   self.nf_hh_members_ct                 := nf_hh_members_ct;
   self.nf_hh_property_owners_ct         := nf_hh_property_owners_ct;
   self.nf_hh_pct_property_owners        := nf_hh_pct_property_owners;
   self.nf_hh_age_65_plus                := nf_hh_age_65_plus;
   self.nf_hh_age_30_plus                := nf_hh_age_30_plus;
   self.nf_hh_age_18_plus                := nf_hh_age_18_plus;
   self.nf_hh_age_lt18                   := nf_hh_age_lt18;
   self.nf_hh_collections_ct             := nf_hh_collections_ct;
   self.nf_hh_collections_ct_avg         := nf_hh_collections_ct_avg;
   self.nf_hh_workers_paw                := nf_hh_workers_paw;
   self.nf_hh_workers_paw_pct            := nf_hh_workers_paw_pct;
   self.nf_hh_payday_loan_users          := nf_hh_payday_loan_users;
   self.nf_hh_payday_loan_users_pct      := nf_hh_payday_loan_users_pct;
   self.nf_hh_members_w_derog_pct        := nf_hh_members_w_derog_pct;
   self.nf_hh_tot_derog                  := nf_hh_tot_derog;
   self.nf_hh_tot_derog_avg              := nf_hh_tot_derog_avg;
   self.nf_hh_bankruptcies_pct           := nf_hh_bankruptcies_pct;
   self.nf_hh_lienholders                := nf_hh_lienholders;
   self.nf_hh_lienholders_pct            := nf_hh_lienholders_pct;
   self.nf_hh_prof_license_holders       := nf_hh_prof_license_holders;
   self.nf_hh_criminals                  := nf_hh_criminals;
   self.nf_hh_criminals_pct              := nf_hh_criminals_pct;
   self.nf_hh_college_attendees          := nf_hh_college_attendees;
   self.nf_hh_college_attendees_pct      := nf_hh_college_attendees_pct;
   self.nf_rel_count    := nf_rel_count;
   self.nf_average_rel_income            := nf_average_rel_income;
   self.nf_lowest_rel_income             := nf_lowest_rel_income;
   self.nf_highest_rel_income            := nf_highest_rel_income;
   self.nf_average_rel_home_val          := nf_average_rel_home_val;
   self.nf_lowest_rel_home_val           := nf_lowest_rel_home_val;
   self.nf_highest_rel_home_val          := nf_highest_rel_home_val;
   self.nf_average_rel_age               := nf_average_rel_age;
   self.nf_youngest_rel_age              := nf_youngest_rel_age;
   self.nf_oldest_rel_age                := nf_oldest_rel_age;
   self.nf_average_rel_education         := nf_average_rel_education;
   self.nf_lowest_rel_education          := nf_lowest_rel_education;
   self.nf_average_rel_criminal_dist     := nf_average_rel_criminal_dist;
   self.nf_furthest_rel_criminal         := nf_furthest_rel_criminal;
   self.nf_average_rel_distance          := nf_average_rel_distance;
   self.nf_rel_bankrupt_count            := nf_rel_bankrupt_count;
   self.nf_rel_criminal_count            := nf_rel_criminal_count;
   self.nf_rel_felony_count              := nf_rel_felony_count;
   self.nf_pct_rel_with_bk               := nf_pct_rel_with_bk;
   self.nf_pct_rel_with_criminal         := nf_pct_rel_with_criminal;
   self.nf_pct_rel_with_felony           := nf_pct_rel_with_felony;
   self.nf_rel_derog_summary             := nf_rel_derog_summary;
   self.nf_pct_rel_prop_owned            := nf_pct_rel_prop_owned;
   self.nf_pct_rel_prop_sold             := nf_pct_rel_prop_sold;
   self.nf_current_count                 := nf_current_count;
   self.nf_historical_count              := nf_historical_count;
   self.nf_historic_x_current_ct         := nf_historic_x_current_ct;
   self.nf_acc_damage_amt_total          := nf_acc_damage_amt_total;
   self._acc_last_seen                   := _acc_last_seen;
   self.nf_mos_acc_lseen                 := nf_mos_acc_lseen;
   self.nf_accident_recency              := nf_accident_recency;
   self.nf_fp_idrisktype                 := nf_fp_idrisktype;
   self.nf_fp_idveraddressnotcurrent     := nf_fp_idveraddressnotcurrent;
   self.nf_fp_sourcerisktype             := nf_fp_sourcerisktype;
   self.nf_fp_varrisktype                := nf_fp_varrisktype;
   self.nf_fp_varmsrcssnunrelcount       := nf_fp_varmsrcssnunrelcount;
   self.nf_fp_srchvelocityrisktype       := nf_fp_srchvelocityrisktype;
   self.nf_fp_srchunvrfdssncount         := nf_fp_srchunvrfdssncount;
   self.nf_fp_srchunvrfdaddrcount        := nf_fp_srchunvrfdaddrcount;
   self.nf_fp_srchunvrfddobcount         := nf_fp_srchunvrfddobcount;
   self.nf_fp_srchunvrfdphonecount       := nf_fp_srchunvrfdphonecount;
   self.nf_fp_srchfraudsrchcountyr       := nf_fp_srchfraudsrchcountyr;
   self.nf_fp_srchfraudsrchcountmo       := nf_fp_srchfraudsrchcountmo;
   self.nf_fp_srchfraudsrchcountwk       := nf_fp_srchfraudsrchcountwk;
   self.nf_fp_srchfraudsrchcountday      := nf_fp_srchfraudsrchcountday;
   self.nf_fp_assocsuspicousidcount      := nf_fp_assocsuspicousidcount;
   self.nf_fp_validationrisktype         := nf_fp_validationrisktype;
   self.nf_fp_divrisktype                := nf_fp_divrisktype;
   self.nf_fp_divaddrsuspidcountnew      := nf_fp_divaddrsuspidcountnew;
   self.nf_fp_srchcomponentrisktype      := nf_fp_srchcomponentrisktype;
   self.nf_fp_srchssnsrchcountmo         := nf_fp_srchssnsrchcountmo;
   self.nf_fp_srchssnsrchcountwk         := nf_fp_srchssnsrchcountwk;
   self.nf_fp_srchssnsrchcountday        := nf_fp_srchssnsrchcountday;
   self.nf_fp_srchaddrsrchcountmo        := nf_fp_srchaddrsrchcountmo;
   self.nf_fp_srchaddrsrchcountwk        := nf_fp_srchaddrsrchcountwk;
   self.nf_fp_srchaddrsrchcountday       := nf_fp_srchaddrsrchcountday;
   self.nf_fp_srchphonesrchcountmo       := nf_fp_srchphonesrchcountmo;
   self.nf_fp_srchphonesrchcountwk       := nf_fp_srchphonesrchcountwk;
   self.nf_fp_srchphonesrchcountday      := nf_fp_srchphonesrchcountday;
   self.nf_fp_componentcharrisktype      := nf_fp_componentcharrisktype;
   self.nf_fp_inputaddractivephonelist   := nf_fp_inputaddractivephonelist;
   self.nf_fp_addrchangeincomediff       := nf_fp_addrchangeincomediff;
   self.nf_fp_addrchangevaluediff        := nf_fp_addrchangevaluediff;
   self.nf_fp_addrchangecrimediff        := nf_fp_addrchangecrimediff;
   self.nf_fp_addrchangeecontraj         := nf_fp_addrchangeecontraj;
   self.nf_fp_curraddractivephonelist    := nf_fp_curraddractivephonelist;
   self.nf_fp_curraddrmedianincome       := nf_fp_curraddrmedianincome;
   self.nf_fp_curraddrmedianvalue        := nf_fp_curraddrmedianvalue;
   self.nf_fp_curraddrmurderindex        := nf_fp_curraddrmurderindex;
   self.nf_fp_curraddrcartheftindex      := nf_fp_curraddrcartheftindex;
   self.nf_fp_curraddrburglaryindex      := nf_fp_curraddrburglaryindex;
   self.nf_fp_curraddrcrimeindex         := nf_fp_curraddrcrimeindex;
   self.nf_fp_prevaddrageoldest          := nf_fp_prevaddrageoldest;
   self.nf_fp_prevaddrlenofres           := nf_fp_prevaddrlenofres;
   self.nf_fp_prevaddrmedianincome       := nf_fp_prevaddrmedianincome;
   self.nf_fp_prevaddrmedianvalue        := nf_fp_prevaddrmedianvalue;
   self.nf_fp_prevaddrmurderindex        := nf_fp_prevaddrmurderindex;
   self.nf_fp_prevaddrcartheftindex      := nf_fp_prevaddrcartheftindex;
   self.nf_fp_prevaddrburglaryindex      := nf_fp_prevaddrburglaryindex;
   self.nf_fp_prevaddrcrimeindex         := nf_fp_prevaddrcrimeindex;
   self.record_count    := record_count;
   self.bureau_adl_eq_fseen_pos          := bureau_adl_eq_fseen_pos;
   self.bureau_adl_fseen_eq              := bureau_adl_fseen_eq;
   self._bureau_adl_fseen_eq             := _bureau_adl_fseen_eq;
   self.bureau_adl_en_fseen_pos          := bureau_adl_en_fseen_pos;
   self.bureau_adl_fseen_en              := bureau_adl_fseen_en;
   self._bureau_adl_fseen_en             := _bureau_adl_fseen_en;
   self.bureau_adl_ts_fseen_pos          := bureau_adl_ts_fseen_pos;
   self.bureau_adl_fseen_ts              := bureau_adl_fseen_ts;
   self._bureau_adl_fseen_ts             := _bureau_adl_fseen_ts;
   self.bureau_adl_tu_fseen_pos          := bureau_adl_tu_fseen_pos;
   self.bureau_adl_fseen_tu              := bureau_adl_fseen_tu;
   self._bureau_adl_fseen_tu             := _bureau_adl_fseen_tu;
   self.bureau_adl_tn_fseen_pos          := bureau_adl_tn_fseen_pos;
   self.bureau_adl_fseen_tn              := bureau_adl_fseen_tn;
   self._bureau_adl_fseen_tn             := _bureau_adl_fseen_tn;
   self._src_bureau_adl_fseen_all        := _src_bureau_adl_fseen_all;
   self.credit_bureau_oldest             := credit_bureau_oldest;
   self.num_sources     := num_sources;
   self.nf_qb4987_synthetic_index        := nf_qb4987_synthetic_index;
   self.bureau_         := bureau_;
   self.behavioral_     := behavioral_;
   self.government_     := government_;
   self.nf_source_type                   := nf_source_type;
   self.nf_number_non_bureau_sources     := nf_number_non_bureau_sources;
   self.nf_number_bureau_sources         := nf_number_bureau_sources;
   self.nf_inq_per_ssn_nas_479           := nf_inq_per_ssn_nas_479;
   self.nf_inq_per_add_nas_479           := nf_inq_per_add_nas_479;
   self._add_not_ver    := _add_not_ver;
   self.nf_inq_add_per_ssn_nas_479       := nf_inq_add_per_ssn_nas_479;
   self.lic_adl_d_count_pos              := lic_adl_d_count_pos;
   self.lic_adl_count_d                  := lic_adl_count_d;
   self.lic_adl_dl_count_pos             := lic_adl_dl_count_pos;
   self.lic_adl_count_dl                 := lic_adl_count_dl;
   self._src_vehx_adl_count              := _src_vehx_adl_count;
   self.iv_src_drivers_lic_adl_count     := iv_src_drivers_lic_adl_count;
   self.iv_dl_val_flag                   := iv_dl_val_flag;
   self.voter_adl_v_count_pos            := voter_adl_v_count_pos;
   self.iv_src_voter_adl_count           := iv_src_voter_adl_count;
   self.vote_adl_vo_lseen_pos            := vote_adl_vo_lseen_pos;
   self.vote_adl_lseen_vo                := vote_adl_lseen_vo;
   self._vote_adl_lseen_vo               := _vote_adl_lseen_vo;
   self._src_vote_adl_lseen              := _src_vote_adl_lseen;
   self.iv_mos_src_voter_adl_lseen       := iv_mos_src_voter_adl_lseen;
   self.final_score_0   := final_score_0;
   self.final_score_1   := final_score_1;
   self.final_score_2   := final_score_2;
   self.final_score_3   := final_score_3;
   self.final_score_4   := final_score_4;
   self.final_score_5   := final_score_5;
   self.final_score_6   := final_score_6;
   self.final_score_7   := final_score_7;
   self.final_score_8   := final_score_8;
   self.final_score_9   := final_score_9;
   self.final_score_10                   := final_score_10;
   self.final_score_11                   := final_score_11;
   self.final_score_12                   := final_score_12;
   self.final_score_13                   := final_score_13;
   self.final_score_14                   := final_score_14;
   self.final_score_15                   := final_score_15;
   self.final_score_16                   := final_score_16;
   self.final_score_17                   := final_score_17;
   self.final_score_18                   := final_score_18;
   self.final_score_19                   := final_score_19;
   self.final_score_20                   := final_score_20;
   self.final_score_21                   := final_score_21;
   self.final_score_22                   := final_score_22;
   self.final_score_23                   := final_score_23;
   self.final_score_24                   := final_score_24;
   self.final_score_25                   := final_score_25;
   self.final_score_26                   := final_score_26;
   self.final_score_27                   := final_score_27;
   self.final_score_28                   := final_score_28;
   self.final_score_29                   := final_score_29;
   self.final_score_30                   := final_score_30;
   self.final_score_31                   := final_score_31;
   self.final_score_32                   := final_score_32;
   self.final_score_33                   := final_score_33;
   self.final_score_34                   := final_score_34;
   self.final_score_35                   := final_score_35;
   self.final_score_36                   := final_score_36;
   self.final_score_37                   := final_score_37;
   self.final_score_38                   := final_score_38;
   self.final_score_39                   := final_score_39;
   self.final_score_40                   := final_score_40;
   self.final_score_41                   := final_score_41;
   self.final_score_42                   := final_score_42;
   self.final_score_43                   := final_score_43;
   self.final_score_44                   := final_score_44;
   self.final_score_45                   := final_score_45;
   self.final_score_46                   := final_score_46;
   self.final_score_47                   := final_score_47;
   self.final_score_48                   := final_score_48;
   self.final_score_49                   := final_score_49;
   self.final_score_50                   := final_score_50;
   self.final_score_51                   := final_score_51;
   self.final_score_52                   := final_score_52;
   self.final_score_53                   := final_score_53;
   self.final_score_54                   := final_score_54;
   self.final_score_55                   := final_score_55;
   self.final_score_56                   := final_score_56;
   self.final_score_57                   := final_score_57;
   self.final_score_58                   := final_score_58;
   self.final_score_59                   := final_score_59;
   self.final_score_60                   := final_score_60;
   self.final_score_61                   := final_score_61;
   self.final_score_62                   := final_score_62;
   self.final_score_63                   := final_score_63;
   self.final_score_64                   := final_score_64;
   self.final_score_65                   := final_score_65;
   self.final_score_66                   := final_score_66;
   self.final_score_67                   := final_score_67;
   self.final_score_68                   := final_score_68;
   self.final_score_69                   := final_score_69;
   self.final_score_70                   := final_score_70;
   self.final_score_71                   := final_score_71;
   self.final_score_72                   := final_score_72;
   self.final_score_73                   := final_score_73;
   self.final_score_74                   := final_score_74;
   self.final_score_75                   := final_score_75;
   self.final_score_76                   := final_score_76;
   self.final_score_77                   := final_score_77;
   self.final_score_78                   := final_score_78;
   self.final_score_79                   := final_score_79;
   self.final_score_80                   := final_score_80;
   self.final_score_81                   := final_score_81;
   self.final_score_82                   := final_score_82;
   self.final_score_83                   := final_score_83;
   self.final_score_84                   := final_score_84;
   self.final_score_85                   := final_score_85;
   self.final_score_86                   := final_score_86;
   self.final_score_87                   := final_score_87;
   self.final_score_88                   := final_score_88;
   self.final_score_89                   := final_score_89;
   self.final_score_90                   := final_score_90;
   self.final_score_91                   := final_score_91;
   self.final_score_92                   := final_score_92;
   self.final_score_93                   := final_score_93;
   self.final_score_94                   := final_score_94;
   self.final_score_95                   := final_score_95;
   self.final_score_96                   := final_score_96;
   self.final_score_97                   := final_score_97;
   self.final_score_98                   := final_score_98;
   self.final_score_99                   := final_score_99;
   self.final_score_100                  := final_score_100;
   self.final_score_101                  := final_score_101;
   self.final_score_102                  := final_score_102;
   self.final_score_103                  := final_score_103;
   self.final_score_104                  := final_score_104;
   self.final_score_105                  := final_score_105;
   self.final_score_106                  := final_score_106;
   self.final_score_107                  := final_score_107;
   self.final_score_108                  := final_score_108;
   self.final_score_109                  := final_score_109;
   self.final_score_110                  := final_score_110;
   self.final_score_111                  := final_score_111;
   self.final_score_112                  := final_score_112;
   self.final_score_113                  := final_score_113;
   self.final_score_114                  := final_score_114;
   self.final_score_115                  := final_score_115;
   self.final_score_116                  := final_score_116;
   self.final_score_117                  := final_score_117;
   self.final_score_118                  := final_score_118;
   self.final_score_119                  := final_score_119;
   self.final_score_120                  := final_score_120;
   self.final_score_121                  := final_score_121;
   self.final_score_122                  := final_score_122;
   self.final_score_123                  := final_score_123;
   self.final_score_124                  := final_score_124;
   self.final_score_125                  := final_score_125;
   self.final_score_126                  := final_score_126;
   self.final_score_127                  := final_score_127;
   self.final_score_128                  := final_score_128;
   self.final_score_129                  := final_score_129;
   self.final_score_130                  := final_score_130;
   self.final_score_131                  := final_score_131;
   self.final_score_132                  := final_score_132;
   self.final_score_133                  := final_score_133;
   self.final_score_134                  := final_score_134;
   self.final_score_135                  := final_score_135;
   self.final_score_136                  := final_score_136;
   self.final_score_137                  := final_score_137;
   self.final_score_138                  := final_score_138;
   self.final_score_139                  := final_score_139;
   self.final_score_140                  := final_score_140;
   self.final_score_141                  := final_score_141;
   self.final_score_142                  := final_score_142;
   self.final_score_143                  := final_score_143;
   self.final_score_144                  := final_score_144;
   self.final_score_145                  := final_score_145;
   self.final_score_146                  := final_score_146;
   self.final_score_147                  := final_score_147;
   self.final_score_148                  := final_score_148;
   self.final_score_149                  := final_score_149;
   self.final_score_150                  := final_score_150;
   self.final_score_151                  := final_score_151;
   self.final_score_152                  := final_score_152;
   self.final_score_153                  := final_score_153;
   self.final_score_154                  := final_score_154;
   self.final_score_155                  := final_score_155;
   self.final_score_156                  := final_score_156;
   self.final_score_157                  := final_score_157;
   self.final_score_158                  := final_score_158;
   self.final_score_159                  := final_score_159;
   self.final_score_160                  := final_score_160;
   self.final_score_161                  := final_score_161;
   self.final_score_162                  := final_score_162;
   self.final_score_163                  := final_score_163;
   self.final_score_164                  := final_score_164;
   self.final_score_165                  := final_score_165;
   self.final_score_166                  := final_score_166;
   self.final_score_167                  := final_score_167;
   self.final_score_168                  := final_score_168;
   self.final_score_169                  := final_score_169;
   self.final_score_170                  := final_score_170;
   self.final_score_171                  := final_score_171;
   self.final_score_172                  := final_score_172;
   self.final_score_173                  := final_score_173;
   self.final_score_174                  := final_score_174;
   self.final_score_175                  := final_score_175;
   self.final_score_176                  := final_score_176;
   self.final_score_177                  := final_score_177;
   self.final_score_178                  := final_score_178;
   self.final_score_179                  := final_score_179;
   self.final_score_180                  := final_score_180;
   self.final_score_181                  := final_score_181;
   self.final_score_182                  := final_score_182;
   self.final_score_183                  := final_score_183;
   self.final_score_184                  := final_score_184;
   self.final_score_185                  := final_score_185;
   self.final_score_186                  := final_score_186;
   self.final_score_187                  := final_score_187;
   self.final_score_188                  := final_score_188;
   self.final_score_189                  := final_score_189;
   self.final_score_190                  := final_score_190;
   self.final_score_191                  := final_score_191;
   self.final_score_192                  := final_score_192;
   self.final_score_193                  := final_score_193;
   self.final_score_194                  := final_score_194;
   self.final_score_195                  := final_score_195;
   self.final_score_196                  := final_score_196;
   self.final_score_197                  := final_score_197;
   self.final_score_198                  := final_score_198;
   self.final_score_199                  := final_score_199;
   self.final_score_200                  := final_score_200;
   self.final_score_201                  := final_score_201;
   self.final_score_202                  := final_score_202;
   self.final_score_203                  := final_score_203;
   self.final_score_204                  := final_score_204;
   self.final_score_205                  := final_score_205;
   self.final_score_206                  := final_score_206;
   self.final_score_207                  := final_score_207;
   self.final_score_208                  := final_score_208;
   self.final_score_209                  := final_score_209;
   self.final_score_210                  := final_score_210;
   self.final_score_211                  := final_score_211;
   self.final_score_212                  := final_score_212;
   self.final_score_213                  := final_score_213;
   self.final_score_214                  := final_score_214;
   self.final_score_215                  := final_score_215;
   self.final_score_216                  := final_score_216;
   self.final_score_217                  := final_score_217;
   self.final_score_218                  := final_score_218;
   self.final_score_219                  := final_score_219;
   self.final_score_220                  := final_score_220;
   self.final_score_221                  := final_score_221;
   self.final_score_222                  := final_score_222;
   self.final_score_223                  := final_score_223;
   self.final_score_224                  := final_score_224;
   self.final_score_225                  := final_score_225;
   self.final_score_226                  := final_score_226;
   self.final_score_227                  := final_score_227;
   self.final_score_228                  := final_score_228;
   self.final_score_229                  := final_score_229;
   self.final_score_230                  := final_score_230;
   self.final_score_231                  := final_score_231;
   self.final_score_232                  := final_score_232;
   self.final_score_233                  := final_score_233;
   self.final_score_234                  := final_score_234;
   self.final_score_235                  := final_score_235;
   self.final_score_236                  := final_score_236;
   self.final_score_237                  := final_score_237;
   self.final_score_238                  := final_score_238;
   self.final_score_239                  := final_score_239;
   self.final_score_240                  := final_score_240;
   self.final_score_241                  := final_score_241;
   self.final_score_242                  := final_score_242;
   self.final_score_243                  := final_score_243;
   self.final_score_244                  := final_score_244;
   self.final_score_245                  := final_score_245;
   self.final_score_246                  := final_score_246;
   self.final_score_247                  := final_score_247;
   self.final_score_248                  := final_score_248;
   self.final_score_249                  := final_score_249;
   self.final_score_250                  := final_score_250;
   self.final_score_251                  := final_score_251;
   self.final_score_252                  := final_score_252;
   self.final_score_253                  := final_score_253;
   self.final_score_254                  := final_score_254;
   self.final_score_255                  := final_score_255;
   self.final_score_256                  := final_score_256;
   self.final_score_257                  := final_score_257;
   self.final_score_258                  := final_score_258;
   self.final_score_259                  := final_score_259;
   self.final_score_260                  := final_score_260;
   self.final_score_261                  := final_score_261;
   self.final_score_262                  := final_score_262;
   self.final_score_263                  := final_score_263;
   self.final_score_264                  := final_score_264;
   self.final_score_265                  := final_score_265;
   self.final_score_266                  := final_score_266;
   self.final_score_267                  := final_score_267;
   self.final_score_268                  := final_score_268;
   self.final_score_269                  := final_score_269;
   self.final_score_270                  := final_score_270;
   self.final_score_271                  := final_score_271;
   self.final_score_272                  := final_score_272;
   self.final_score_273                  := final_score_273;
   self.final_score_274                  := final_score_274;
   self.final_score_275                  := final_score_275;
   self.final_score_276                  := final_score_276;
   self.final_score_277                  := final_score_277;
   self.final_score_278                  := final_score_278;
   self.final_score_279                  := final_score_279;
   self.final_score_280                  := final_score_280;
   self.final_score_281                  := final_score_281;
   self.final_score_282                  := final_score_282;
   self.final_score_283                  := final_score_283;
   self.final_score_284                  := final_score_284;
   self.final_score_285                  := final_score_285;
   self.final_score_286                  := final_score_286;
   self.final_score_287                  := final_score_287;
   self.final_score_288                  := final_score_288;
   self.final_score_289                  := final_score_289;
   self.final_score_290                  := final_score_290;
   self.final_score_291                  := final_score_291;
   self.final_score_292                  := final_score_292;
   self.final_score_293                  := final_score_293;
   self.final_score_294                  := final_score_294;
   self.final_score_295                  := final_score_295;
   self.final_score_296                  := final_score_296;
   self.final_score_297                  := final_score_297;
   self.final_score_298                  := final_score_298;
   self.final_score_299                  := final_score_299;
   self.final_score_300                  := final_score_300;
   self.final_score_301                  := final_score_301;
   self.final_score_302                  := final_score_302;
   self.final_score_303                  := final_score_303;
   self.final_score_304                  := final_score_304;
   self.final_score_305                  := final_score_305;
   self.final_score_306                  := final_score_306;
   self.final_score_307                  := final_score_307;
   self.final_score_308                  := final_score_308;
   self.final_score_309                  := final_score_309;
   self.final_score_310                  := final_score_310;
   self.final_score_311                  := final_score_311;
   self.final_score_312                  := final_score_312;
   self.final_score_313                  := final_score_313;
   self.final_score_314                  := final_score_314;
   self.final_score_315                  := final_score_315;
   self.final_score_316                  := final_score_316;
   self.final_score_317                  := final_score_317;
   self.final_score_318                  := final_score_318;
   self.final_score_319                  := final_score_319;
   self.final_score_320                  := final_score_320;
   self.final_score_321                  := final_score_321;
   self.final_score_322                  := final_score_322;
   self.final_score_323                  := final_score_323;
   self.final_score_324                  := final_score_324;
   self.final_score_325                  := final_score_325;
   self.final_score_326                  := final_score_326;
   self.final_score_327                  := final_score_327;
   self.final_score_328                  := final_score_328;
   self.final_score_329                  := final_score_329;
   self.final_score_330                  := final_score_330;
   self.final_score_331                  := final_score_331;
   self.final_score_332                  := final_score_332;
   self.final_score_333                  := final_score_333;
   self.final_score_334                  := final_score_334;
   self.final_score_335                  := final_score_335;
   self.final_score_336                  := final_score_336;
   self.final_score_337                  := final_score_337;
   self.final_score_338                  := final_score_338;
   self.final_score_339                  := final_score_339;
   self.final_score_340                  := final_score_340;
   self.final_score_341                  := final_score_341;
   self.final_score_342                  := final_score_342;
   self.final_score_343                  := final_score_343;
   self.final_score_344                  := final_score_344;
   self.final_score_345                  := final_score_345;
   self.final_score_346                  := final_score_346;
   self.final_score_347                  := final_score_347;
   self.final_score_348                  := final_score_348;
   self.final_score_349                  := final_score_349;
   self.final_score_350                  := final_score_350;
   self.final_score_351                  := final_score_351;
   self.final_score_352                  := final_score_352;
   self.final_score_353                  := final_score_353;
   self.final_score_354                  := final_score_354;
   self.final_score_355                  := final_score_355;
   self.final_score_356                  := final_score_356;
   self.final_score_357                  := final_score_357;
   self.final_score_358                  := final_score_358;
   self.final_score_359                  := final_score_359;
   self.final_score_360                  := final_score_360;
   self.final_score_361                  := final_score_361;
   self.final_score_362                  := final_score_362;
   self.final_score_363                  := final_score_363;
   self.final_score_364                  := final_score_364;
   self.final_score_365                  := final_score_365;
   self.final_score_366                  := final_score_366;
   self.final_score_367                  := final_score_367;
   self.final_score_368                  := final_score_368;
   self.final_score_369                  := final_score_369;
   self.final_score_370                  := final_score_370;
   self.final_score_371                  := final_score_371;
   self.final_score_372                  := final_score_372;
   self.final_score_373                  := final_score_373;
   self.final_score_374                  := final_score_374;
   self.final_score_375                  := final_score_375;
   self.final_score_376                  := final_score_376;
   self.final_score_377                  := final_score_377;
   self.final_score_378                  := final_score_378;
   self.final_score_379                  := final_score_379;
   self.final_score_380                  := final_score_380;
   self.final_score_381                  := final_score_381;
   self.final_score_382                  := final_score_382;
   self.final_score_383                  := final_score_383;
   self.final_score_384                  := final_score_384;
   self.final_score_385                  := final_score_385;
   self.final_score_386                  := final_score_386;
   self.final_score_387                  := final_score_387;
   self.final_score_388                  := final_score_388;
   self.final_score_389                  := final_score_389;
   self.final_score_390                  := final_score_390;
   self.final_score_391                  := final_score_391;
   self.final_score_392                  := final_score_392;
   self.final_score_393                  := final_score_393;
   self.final_score_394                  := final_score_394;
   self.final_score_395                  := final_score_395;
   self.final_score_396                  := final_score_396;
   self.final_score_397                  := final_score_397;
   self.final_score_398                  := final_score_398;
   self.final_score_399                  := final_score_399;
   self.final_score_400                  := final_score_400;
   self.final_score_401                  := final_score_401;
   self.final_score_402                  := final_score_402;
   self.final_score_403                  := final_score_403;
   self.final_score_404                  := final_score_404;
   self.final_score_405                  := final_score_405;
   self.final_score_406                  := final_score_406;
   self.final_score_407                  := final_score_407;
   self.final_score_408                  := final_score_408;
   self.final_score_409                  := final_score_409;
   self.final_score_410                  := final_score_410;
   self.final_score_411                  := final_score_411;
   self.final_score_412                  := final_score_412;
   self.final_score_413                  := final_score_413;
   self.final_score_414                  := final_score_414;
   self.final_score_415                  := final_score_415;
   self.final_score_416                  := final_score_416;
   self.final_score_417                  := final_score_417;
   self.final_score_418                  := final_score_418;
   self.final_score_419                  := final_score_419;
   self.final_score_420                  := final_score_420;
   self.final_score_421                  := final_score_421;
   self.final_score_422                  := final_score_422;
   self.final_score_423                  := final_score_423;
   self.final_score_424                  := final_score_424;
   self.final_score_425                  := final_score_425;
   self.final_score_426                  := final_score_426;
   self.final_score_427                  := final_score_427;
   self.final_score_428                  := final_score_428;
   self.final_score_429                  := final_score_429;
   self.final_score_430                  := final_score_430;
   self.final_score_431                  := final_score_431;
   self.final_score_432                  := final_score_432;
   self.final_score_433                  := final_score_433;
   self.final_score_434                  := final_score_434;
   self.final_score_435                  := final_score_435;
   self.final_score_436                  := final_score_436;
   self.final_score_437                  := final_score_437;
   self.final_score_438                  := final_score_438;
   self.final_score_439                  := final_score_439;
   self.final_score_440                  := final_score_440;
   self.final_score_441                  := final_score_441;
   self.final_score_442                  := final_score_442;
   self.final_score_443                  := final_score_443;
   self.final_score_444                  := final_score_444;
   self.final_score_445                  := final_score_445;
   self.final_score_446                  := final_score_446;
   self.final_score_447                  := final_score_447;
   self.final_score_448                  := final_score_448;
   self.final_score_449                  := final_score_449;
   self.final_score_450                  := final_score_450;
   self.final_score_451                  := final_score_451;
   self.final_score_452                  := final_score_452;
   self.final_score_453                  := final_score_453;
   self.final_score_454                  := final_score_454;
   self.final_score_455                  := final_score_455;
   self.final_score_456                  := final_score_456;
   self.final_score_457                  := final_score_457;
   self.final_score_458                  := final_score_458;
   self.final_score_459                  := final_score_459;
   self.final_score_460                  := final_score_460;
   self.final_score_461                  := final_score_461;
   self.final_score_462                  := final_score_462;
   self.final_score_463                  := final_score_463;
   self.final_score_464                  := final_score_464;
   self.final_score_465                  := final_score_465;
   self.final_score_466                  := final_score_466;
   self.final_score_467                  := final_score_467;
   self.final_score_468                  := final_score_468;
   self.final_score_469                  := final_score_469;
   self.final_score_470                  := final_score_470;
   self.final_score_471                  := final_score_471;
   self.final_score_472                  := final_score_472;
   self.final_score_473                  := final_score_473;
   self.final_score_474                  := final_score_474;
   self.final_score_475                  := final_score_475;
   self.final_score_476                  := final_score_476;
   self.final_score_477                  := final_score_477;
   self.final_score_478                  := final_score_478;
   self.final_score_479                  := final_score_479;
   self.final_score_480                  := final_score_480;
   self.final_score_481                  := final_score_481;
   self.final_score_482                  := final_score_482;
   self.final_score_483                  := final_score_483;
   self.final_score_484                  := final_score_484;
   self.final_score_485                  := final_score_485;
   self.final_score_486                  := final_score_486;
   self.final_score_487                  := final_score_487;
   self.final_score_488                  := final_score_488;
   self.final_score_489                  := final_score_489;
   self.final_score_490                  := final_score_490;
   self.final_score_491                  := final_score_491;
   self.final_score_492                  := final_score_492;
   self.final_score_493                  := final_score_493;
   self.final_score_494                  := final_score_494;
   self.final_score_495                  := final_score_495;
   self.final_score_496                  := final_score_496;
   self.final_score_497                  := final_score_497;
   self.final_score_498                  := final_score_498;
   self.final_score_499                  := final_score_499;
   self.final_score_500                  := final_score_500;
   self.final_score_501                  := final_score_501;
   self.final_score_502                  := final_score_502;
   self.final_score_503                  := final_score_503;
   self.final_score_504                  := final_score_504;
   self.final_score_505                  := final_score_505;
   self.final_score_506                  := final_score_506;
   self.final_score_507                  := final_score_507;
   self.final_score_508                  := final_score_508;
   self.final_score_509                  := final_score_509;
   self.final_score_510                  := final_score_510;
   self.final_score_511                  := final_score_511;
   self.final_score_512                  := final_score_512;
   self.final_score_513                  := final_score_513;
   self.final_score_514                  := final_score_514;
   self.final_score_515                  := final_score_515;
   self.final_score_516                  := final_score_516;
   self.final_score_517                  := final_score_517;
   self.final_score_518                  := final_score_518;
   self.final_score_519                  := final_score_519;
   self.final_score_520                  := final_score_520;
   self.final_score_521                  := final_score_521;
   self.final_score_522                  := final_score_522;
   self.final_score_523                  := final_score_523;
   self.final_score_524                  := final_score_524;
   self.final_score_525                  := final_score_525;
   self.final_score_526                  := final_score_526;
   self.final_score_527                  := final_score_527;
   self.final_score_528                  := final_score_528;
   self.final_score_529                  := final_score_529;
   self.final_score_530                  := final_score_530;
   self.final_score_531                  := final_score_531;
   self.final_score_532                  := final_score_532;
   self.final_score_533                  := final_score_533;
   self.final_score_534                  := final_score_534;
   self.final_score_535                  := final_score_535;
   self.final_score_536                  := final_score_536;
   self.final_score_537                  := final_score_537;
   self.final_score_538                  := final_score_538;
   self.final_score_539                  := final_score_539;
   self.final_score_540                  := final_score_540;
   self.final_score_541                  := final_score_541;
   self.final_score_542                  := final_score_542;
   self.final_score_543                  := final_score_543;
   self.final_score_544                  := final_score_544;
   self.final_score_545                  := final_score_545;
   self.final_score_546                  := final_score_546;
   self.final_score_547                  := final_score_547;
   self.final_score_548                  := final_score_548;
   self.final_score_549                  := final_score_549;
   self.final_score_550                  := final_score_550;
   self.final_score_551                  := final_score_551;
   self.final_score_552                  := final_score_552;
   self.final_score_553                  := final_score_553;
   self.final_score_554                  := final_score_554;
   self.final_score_555                  := final_score_555;
   self.final_score_556                  := final_score_556;
   self.final_score_557                  := final_score_557;
   self.final_score_558                  := final_score_558;
   self.final_score_559                  := final_score_559;
   self.final_score_560                  := final_score_560;
   self.final_score_561                  := final_score_561;
   self.final_score_562                  := final_score_562;
   self.final_score_563                  := final_score_563;
   self.final_score_564                  := final_score_564;
   self.final_score_565                  := final_score_565;
   self.final_score_566                  := final_score_566;
   self.final_score_567                  := final_score_567;
   self.final_score_568                  := final_score_568;
   self.final_score_569                  := final_score_569;
   self.final_score_570                  := final_score_570;
   self.final_score_571                  := final_score_571;
   self.final_score_572                  := final_score_572;
   self.final_score_573                  := final_score_573;
   self.final_score_574                  := final_score_574;
   self.final_score_575                  := final_score_575;
   self.final_score_576                  := final_score_576;
   self.final_score_577                  := final_score_577;
   self.final_score_578                  := final_score_578;
   self.final_score_579                  := final_score_579;
   self.final_score_580                  := final_score_580;
   self.final_score_581                  := final_score_581;
   self.final_score_582                  := final_score_582;
   self.final_score_583                  := final_score_583;
   self.final_score_584                  := final_score_584;
   self.final_score_585                  := final_score_585;
   self.final_score_586                  := final_score_586;
   self.final_score_587                  := final_score_587;
   self.final_score_588                  := final_score_588;
   self.final_score_589                  := final_score_589;
   self.final_score_590                  := final_score_590;
   self.final_score_591                  := final_score_591;
   self.final_score_592                  := final_score_592;
   self.final_score_593                  := final_score_593;
   self.final_score_594                  := final_score_594;
   self.final_score_595                  := final_score_595;
   self.final_score_596                  := final_score_596;
   self.final_score_597                  := final_score_597;
   self.final_score_598                  := final_score_598;
   self.final_score_599                  := final_score_599;
   self.final_score_600                  := final_score_600;
   self.final_score_601                  := final_score_601;
   self.final_score_602                  := final_score_602;
   self.final_score_603                  := final_score_603;
   self.final_score_604                  := final_score_604;
   self.final_score_605                  := final_score_605;
   self.final_score_606                  := final_score_606;
   self.final_score_607                  := final_score_607;
   self.final_score_608                  := final_score_608;
   self.final_score_609                  := final_score_609;
   self.final_score_610                  := final_score_610;
   self.final_score_611                  := final_score_611;
   self.final_score_612                  := final_score_612;
   self.final_score_613                  := final_score_613;
   self.final_score_614                  := final_score_614;
   self.final_score_615                  := final_score_615;
   self.final_score_616                  := final_score_616;
   self.final_score_617                  := final_score_617;
   self.final_score_618                  := final_score_618;
   self.final_score_619                  := final_score_619;
   self.final_score_620                  := final_score_620;
   self.final_score_621                  := final_score_621;
   self.final_score_622                  := final_score_622;
   self.final_score_623                  := final_score_623;
   self.final_score_624                  := final_score_624;
   self.final_score_625                  := final_score_625;
   self.final_score_626                  := final_score_626;
   self.final_score_627                  := final_score_627;
   self.final_score_628                  := final_score_628;
   self.final_score_629                  := final_score_629;
   self.final_score_630                  := final_score_630;
   self.final_score_631                  := final_score_631;
   self.final_score_632                  := final_score_632;
   self.final_score_633                  := final_score_633;
   self.final_score_634                  := final_score_634;
   self.final_score_635                  := final_score_635;
   self.final_score_636                  := final_score_636;
   self.final_score_637                  := final_score_637;
   self.final_score_638                  := final_score_638;
   self.final_score_639                  := final_score_639;
   self.final_score_640                  := final_score_640;
   self.final_score_641                  := final_score_641;
   self.final_score_642                  := final_score_642;
   self.final_score_643                  := final_score_643;
   self.final_score_644                  := final_score_644;
   self.final_score_645                  := final_score_645;
   self.final_score_646                  := final_score_646;
   self.final_score_647                  := final_score_647;
   self.final_score_648                  := final_score_648;
   self.final_score_649                  := final_score_649;
   self.final_score_650                  := final_score_650;
   self.final_score_651                  := final_score_651;
   self.final_score_652                  := final_score_652;
   self.final_score_653                  := final_score_653;
   self.final_score_654                  := final_score_654;
   self.final_score_655                  := final_score_655;
   self.final_score_656                  := final_score_656;
   self.final_score_657                  := final_score_657;
   self.final_score_658                  := final_score_658;
   self.final_score_659                  := final_score_659;
   self.final_score_660                  := final_score_660;
   self.final_score_661                  := final_score_661;
   self.final_score_662                  := final_score_662;
   self.final_score_663                  := final_score_663;
   self.final_score_664                  := final_score_664;
   self.final_score_665                  := final_score_665;
   self.final_score_666                  := final_score_666;
   self.final_score_667                  := final_score_667;
   self.final_score_668                  := final_score_668;
   self.final_score_669                  := final_score_669;
   self.final_score_670                  := final_score_670;
   self.final_score_671                  := final_score_671;
   self.final_score_672                  := final_score_672;
   self.final_score_673                  := final_score_673;
   self.final_score_674                  := final_score_674;
   self.final_score_675                  := final_score_675;
   self.final_score_676                  := final_score_676;
   self.final_score_677                  := final_score_677;
   self.final_score_678                  := final_score_678;
   self.final_score_679                  := final_score_679;
   self.final_score_680                  := final_score_680;
   self.final_score_681                  := final_score_681;
   self.final_score_682                  := final_score_682;
   self.final_score_683                  := final_score_683;
   self.final_score_684                  := final_score_684;
   self.final_score_685                  := final_score_685;
   self.final_score_686                  := final_score_686;
   self.final_score_687                  := final_score_687;
   self.final_score_688                  := final_score_688;
   self.final_score_689                  := final_score_689;
   self.final_score_690                  := final_score_690;
   self.final_score_691                  := final_score_691;
   self.final_score_692                  := final_score_692;
   self.final_score_693                  := final_score_693;
   self.final_score_694                  := final_score_694;
   self.final_score_695                  := final_score_695;
   self.final_score_696                  := final_score_696;
   self.final_score_697                  := final_score_697;
   self.final_score_698                  := final_score_698;
   self.final_score_699                  := final_score_699;
   self.final_score_700                  := final_score_700;
   self.final_score_701                  := final_score_701;
   self.final_score_702                  := final_score_702;
   self.final_score_703                  := final_score_703;
   self.final_score_704                  := final_score_704;
   self.final_score_705                  := final_score_705;
   self.final_score_706                  := final_score_706;
   self.final_score_707                  := final_score_707;
   self.final_score_708                  := final_score_708;
   self.final_score_709                  := final_score_709;
   self.final_score_710                  := final_score_710;
   self.final_score_711                  := final_score_711;
   self.final_score_712                  := final_score_712;
   self.final_score_713                  := final_score_713;
   self.final_score_714                  := final_score_714;
   self.final_score_715                  := final_score_715;
   self.final_score_716                  := final_score_716;
   self.final_score_717                  := final_score_717;
   self.final_score_718                  := final_score_718;
   self.final_score_719                  := final_score_719;
   self.final_score_720                  := final_score_720;
   self.final_score_721                  := final_score_721;
   self.final_score_722                  := final_score_722;
   self.final_score_723                  := final_score_723;
   self.final_score_724                  := final_score_724;
   self.final_score_725                  := final_score_725;
   self.final_score_726                  := final_score_726;
   self.final_score_727                  := final_score_727;
   self.final_score_728                  := final_score_728;
   self.final_score_729                  := final_score_729;
   self.final_score_730                  := final_score_730;
   self.final_score_731                  := final_score_731;
   self.final_score_732                  := final_score_732;
   self.final_score_733                  := final_score_733;
   self.final_score_734                  := final_score_734;
   self.final_score_735                  := final_score_735;
   self.final_score_736                  := final_score_736;
   self.final_score_737                  := final_score_737;
   self.final_score_738                  := final_score_738;
   self.final_score_739                  := final_score_739;
   self.final_score_740                  := final_score_740;
   self.final_score_741                  := final_score_741;
   self.final_score_742                  := final_score_742;
   self.final_score_743                  := final_score_743;
   self.final_score_744                  := final_score_744;
   self.final_score_745                  := final_score_745;
   self.final_score_746                  := final_score_746;
   self.final_score_747                  := final_score_747;
   self.final_score_748                  := final_score_748;
   self.final_score_749                  := final_score_749;
   self.final_score_750                  := final_score_750;
   self.final_score_751                  := final_score_751;
   self.final_score_752                  := final_score_752;
   self.final_score_753                  := final_score_753;
   self.final_score_754                  := final_score_754;
   self.final_score_755                  := final_score_755;
   self.final_score_756                  := final_score_756;
   self.final_score_757                  := final_score_757;
   self.final_score_758                  := final_score_758;
   self.final_score_759                  := final_score_759;
   self.final_score_760                  := final_score_760;
   self.final_score_761                  := final_score_761;
   self.final_score_762                  := final_score_762;
   self.final_score_763                  := final_score_763;
   self.final_score_764                  := final_score_764;
   self.final_score_765                  := final_score_765;
   self.final_score_766                  := final_score_766;
   self.final_score_767                  := final_score_767;
   self.final_score_768                  := final_score_768;
   self.final_score_769                  := final_score_769;
   self.final_score_770                  := final_score_770;
   self.final_score_771                  := final_score_771;
   self.final_score_772                  := final_score_772;
   self.final_score_773                  := final_score_773;
   self.final_score_774                  := final_score_774;
   self.final_score_775                  := final_score_775;
   self.final_score_776                  := final_score_776;
   self.final_score_777                  := final_score_777;
   self.final_score_778                  := final_score_778;
   self.final_score_779                  := final_score_779;
   self.final_score_780                  := final_score_780;
   self.final_score_781                  := final_score_781;
   self.final_score_782                  := final_score_782;
   self.final_score_783                  := final_score_783;
   self.final_score_784                  := final_score_784;
   self.final_score_785                  := final_score_785;
   self.final_score_786                  := final_score_786;
   self.final_score_787                  := final_score_787;
   self.final_score_788                  := final_score_788;
   self.final_score_789                  := final_score_789;
   self.final_score_790                  := final_score_790;
   self.final_score_791                  := final_score_791;
   self.final_score_792                  := final_score_792;
   self.final_score_793                  := final_score_793;
   self.final_score_794                  := final_score_794;
   self.final_score_795                  := final_score_795;
   self.final_score_796                  := final_score_796;
   self.final_score_797                  := final_score_797;
   self.final_score_798                  := final_score_798;
   self.final_score_799                  := final_score_799;
   self.final_score_800                  := final_score_800;
   self.final_score_801                  := final_score_801;
   self.final_score_802                  := final_score_802;
   self.final_score_803                  := final_score_803;
   self.final_score_804                  := final_score_804;
   self.final_score_805                  := final_score_805;
   self.final_score_806                  := final_score_806;
   self.final_score_807                  := final_score_807;
   self.final_score_808                  := final_score_808;
   self.final_score_809                  := final_score_809;
   self.final_score_810                  := final_score_810;
   self.final_score_811                  := final_score_811;
   self.final_score_812                  := final_score_812;
   self.final_score_813                  := final_score_813;
   self.final_score_814                  := final_score_814;
   self.final_score_815                  := final_score_815;
   self.final_score_816                  := final_score_816;
   self.final_score_817                  := final_score_817;
   self.final_score_818                  := final_score_818;
   self.final_score_819                  := final_score_819;
   self.final_score_820                  := final_score_820;
   self.final_score_821                  := final_score_821;
   self.final_score_822                  := final_score_822;
   self.final_score_823                  := final_score_823;
   self.final_score_824                  := final_score_824;
   self.final_score_825                  := final_score_825;
   self.final_score_826                  := final_score_826;
   self.final_score_827                  := final_score_827;
   self.final_score_828                  := final_score_828;
   self.final_score_829                  := final_score_829;
   self.final_score_830                  := final_score_830;
   self.final_score_831                  := final_score_831;
   self.final_score_832                  := final_score_832;
   self.final_score_833                  := final_score_833;
   self.final_score_834                  := final_score_834;
   self.final_score_835                  := final_score_835;
   self.final_score_836                  := final_score_836;
   self.final_score_837                  := final_score_837;
   self.final_score_838                  := final_score_838;
   self.final_score_839                  := final_score_839;
   self.final_score_840                  := final_score_840;
   self.final_score_841                  := final_score_841;
   self.final_score_842                  := final_score_842;
   self.final_score_843                  := final_score_843;
   self.final_score_844                  := final_score_844;
   self.final_score_845                  := final_score_845;
   self.final_score_846                  := final_score_846;
   self.final_score_847                  := final_score_847;
   self.final_score_848                  := final_score_848;
   self.final_score_849                  := final_score_849;
   self.final_score_850                  := final_score_850;
   self.final_score_851                  := final_score_851;
   self.final_score_852                  := final_score_852;
   self.final_score_853                  := final_score_853;
   self.final_score_854                  := final_score_854;
   self.final_score_855                  := final_score_855;
   self.final_score_856                  := final_score_856;
   self.final_score_857                  := final_score_857;
   self.final_score_858                  := final_score_858;
   self.final_score_859                  := final_score_859;
   self.final_score_860                  := final_score_860;
   self.final_score_861                  := final_score_861;
   self.final_score_862                  := final_score_862;
   self.final_score_863                  := final_score_863;
   self.final_score_864                  := final_score_864;
   self.final_score_865                  := final_score_865;
   self.final_score_866                  := final_score_866;
   self.final_score_867                  := final_score_867;
   self.final_score_868                  := final_score_868;
   self.final_score_869                  := final_score_869;
   self.final_score_870                  := final_score_870;
   self.final_score_871                  := final_score_871;
   self.final_score_872                  := final_score_872;
   self.final_score_873                  := final_score_873;
   self.final_score_874                  := final_score_874;
   self.final_score     := final_score;
   self.base            := base;
   self.pts             := pts;
   self.lgt             := lgt;
   self.fp1611_1_0      := fp1611_1_0;
   self._ver_src_ds     := _ver_src_ds;
   self._ver_src_de     := _ver_src_de;
   self._ver_src_eq     := _ver_src_eq;
   self._ver_src_en     := _ver_src_en;
   self._ver_src_tn     := _ver_src_tn;
   self._ver_src_tu     := _ver_src_tu;
   self._credit_source_cnt               := _credit_source_cnt;
   self._ver_src_cnt    := _ver_src_cnt;
   self._bureauonly     := _bureauonly;
   self._derog          := _derog;
   self._deceased       := _deceased;
   self._ssnpriortodob                   := _ssnpriortodob;
   self._inputmiskeys   := _inputmiskeys;
   self._multiplessns   := _multiplessns;
   self._hh_strikes     := _hh_strikes;
   self.stolenid        := stolenid;
   self.manipulatedid   := manipulatedid;
   self.manipulatedidpt2                 := manipulatedidpt2;
   self.syntheticid     := syntheticid;
   self.suspiciousactivity               := suspiciousactivity;
   self.vulnerablevictim                 := vulnerablevictim;
   self.friendlyfraud   := friendlyfraud;
   self.stolenc_fp1611_1_0               := stolenc_fp1611_1_0;
   self.manip2c_fp1611_1_0               := manip2c_fp1611_1_0;
   self.synthc_fp1611_1_0                := synthc_fp1611_1_0;
   self.suspactc_fp1611_1_0              := suspactc_fp1611_1_0;
   self.vulnvicc_fp1611_1_0              := vulnvicc_fp1611_1_0;
   self.friendlyc_fp1611_1_0             := friendlyc_fp1611_1_0;
   self.custstolidindex                  := custstolidindex;
   self.custmanipidindex                 := custmanipidindex;
   self.custsynthidindex                 := custsynthidindex;
   self.custsuspactindex                 := custsuspactindex;
   self.custvulnvicindex                 := custvulnvicindex;
   self.custfriendfrdindex               := custfriendfrdindex;


		SELF.clam := le;
#end

	self.seq := le.seq;
	self.StolenIdentityIndex := (string) custstolidindex;
	self.SyntheticIdentityIndex:= (string) custsynthidindex;
	self.ManipulatedIdentityIndex:= (string) custmanipidindex;
	self.VulnerableVictimIndex := (string) custvulnvicindex;
	self.FriendlyFraudIndex                := (string) custfriendfrdindex;
	self.SuspiciousActivityIndex := (string) custsuspactindex;
	ritmp :=  Models.fraudpoint3_reasons(le, blank_ip, num_reasons );
	reasons := Models.Common.checkFraudPointRC34(FP1611_1_0, ritmp, num_reasons);
	self.ri := reasons;
	self.score := (string)FP1611_1_0;
	self := [];
END;

model :=   join(clam, Easi.Key_Easi_Census,
		(left.shell_input.st<>'' and left.shell_input.county <>''	and left.shell_input.geo_blk <> '' and 
		 left.addrpop and 
		 keyed(right.geolink=left.shell_input.st+left.shell_input.county+left.shell_input.geo_blk)) or
		 //to match the modeler's code, search by current address as well but only if the input geo link fields are all blank
		// (left.shell_input.st= '' and left.shell_input.county =''	and left.shell_input.geo_blk = '' and
		(left.addrpop2 and ~left.addrpop and
		 left.Address_Verification.Address_History_1.st<>'' and left.Address_Verification.Address_History_1.county <>''	and left.Address_Verification.Address_History_1.geo_blk <> '' and 
		 keyed(right.geolink=left.Address_Verification.Address_History_1.st+left.Address_Verification.Address_History_1.county+left.Address_Verification.Address_History_1.geo_blk)), 
		doModel(left, right), left outer,
		atmost(RiskWise.max_atmost)
		,keep(1));
	
	return model;
END;
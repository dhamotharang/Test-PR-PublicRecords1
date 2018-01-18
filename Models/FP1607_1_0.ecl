
import Std, risk_indicators, riskwise, riskwisefcra, ut, easi, Models;

blank_ip := dataset( [{0}], riskwise.Layout_IP2O )[1];

export FP1607_1_0(dataset(risk_indicators.Layout_Boca_Shell) clam,
                  integer1 num_reasons)
									 := FUNCTION
									
		FP_DEBUG := False;
		
		isFCRA := False;

	#if(FP_DEBUG)
	Layout_Debug := RECORD
	
	/* Model Intermediate Variables */
	//STRING NULL;
																				Integer seq;
                    Integer sysdate                          ; // :=  sysdate;
                    Integer _acc_last_seen                   ; // :=  _acc_last_seen;
                    real f_mos_acc_lseen_d                ; // :=  f_mos_acc_lseen_d;
                    Integer f_curraddractivephonelist_d      ; // :=  f_curraddractivephonelist_d;
                    Integer f_inputaddractivephonelist_d     ; // :=  f_inputaddractivephonelist_d;
                    integer r_f03_address_match_d            ; // :=  r_f03_address_match_d;
                    Real r_l72_add_curr_vacant_i          ; // :=  r_l72_add_curr_vacant_i;
                    Integer r_l72_add_vacant_i               ; // :=  r_l72_add_vacant_i;
                    integer r_l75_add_curr_drop_delivery_i   ; // :=  r_l75_add_curr_drop_delivery_i;
                    Integer r_l75_add_drop_delivery_i        ; // :=  r_l75_add_drop_delivery_i;
                    Real r_c23_inp_addr_occ_index_d       ; // :=  r_c23_inp_addr_occ_index_d;
                    Integer r_f04_curr_add_occ_index_d       ; // :=  r_f04_curr_add_occ_index_d;
                    Real r_c14_addr_stability_v2_d        ; // :=  r_c14_addr_stability_v2_d;
                    Real r_c14_addrs_10yr_i               ; // :=  r_c14_addrs_10yr_i;
                    real r_c14_addrs_15yr_i               ; // :=  r_c14_addrs_15yr_i;
                    Real r_c14_addrs_5yr_i                ; // :=  r_c14_addrs_5yr_i;
                    real r_c14_addrs_per_adl_c6_i         ; // :=  r_c14_addrs_per_adl_c6_i;
                    string add_ec1                          ; // :=  add_ec1;
                    string add_ec3                          ; // :=  add_ec3;
                    string add_ec4                          ; // :=  add_ec4;
                    Real r_l70_add_standardized_i         ; // :=  r_l70_add_standardized_i;
                    Real _in_dob                          ; // :=  _in_dob;
                    Real yr_in_dob                        ; // :=  yr_in_dob;
                    Real yr_in_dob_int                    ; // :=  yr_in_dob_int;
                    Real k_comb_age_d                     ; // :=  k_comb_age_d;
                    Integer r_d31_bk_filing_count_i          ; // :=  r_d31_bk_filing_count_i;
                    Real f_attr_arrest_recency_d          ; // :=  f_attr_arrest_recency_d;
                    real f_attr_arrests_i                 ; // :=  f_attr_arrests_i;
                    Integer r_c19_add_prison_hist_i          ; // :=  r_c19_add_prison_hist_i;
                    Integer r_d32_criminal_count_i           ; // :=  r_d32_criminal_count_i;
                    Integer r_d32_felony_count_i             ; // :=  r_d32_felony_count_i;
                    Integer _criminal_last_date              ; // :=  _criminal_last_date;
                    Integer r_d32_mos_since_crim_ls_d        ; // :=  r_d32_mos_since_crim_ls_d;
                    Integer _felony_last_date                ; // :=  _felony_last_date;
                    Integer r_d32_mos_since_fel_ls_d         ; // :=  r_d32_mos_since_fel_ls_d;
                    Integer r_d30_derog_count_i              ; // :=  r_d30_derog_count_i;
                    Integer f_vardobcount_i                  ; // :=  f_vardobcount_i;
                    Integer f_vardobcountnew_i               ; // :=  f_vardobcountnew_i;
                    Real f_addrchangeecontrajindex_d      ; // :=  f_addrchangeecontrajindex_d;
                    Real r_c20_email_count_i              ; // :=  r_c20_email_count_i;
                    Real r_c20_email_domain_free_count_i  ; // :=  r_c20_email_domain_free_count_i;
                    Real r_c20_email_domain_isp_count_i   ; // :=  r_c20_email_domain_isp_count_i;
                    Real k_estimated_income_d             ; // :=  k_estimated_income_d;
                    real r_d33_eviction_count_i           ; // :=  r_d33_eviction_count_i;
                    Integer r_d33_eviction_recency_d         ; // :=  r_d33_eviction_recency_d;
                    Integer4 _foreclosure_last_date           ; // :=  _foreclosure_last_date;
                    Real f_mos_foreclosure_lseen_d        ; // :=  f_mos_foreclosure_lseen_d;
                    Real f_idverrisktype_i                ; // :=  f_idverrisktype_i;
                    Boolean _ver_src_ds                      ; // :=  _ver_src_ds;
                    Boolean _ver_src_de                      ; // :=  _ver_src_de;
                    Boolean _ver_src_eq                      ; // :=  _ver_src_eq;
                    Boolean _ver_src_en                      ; // :=  _ver_src_en;
                    Boolean _ver_src_tn                      ; // :=  _ver_src_tn;
                    Boolean	_ver_src_tu                      ; // :=  _ver_src_tu;
                    Real _credit_source_cnt               ; // :=  _credit_source_cnt;
                    integer _ver_src_cnt                     ; // :=  _ver_src_cnt;
                    Boolean _bureauonly                      ; // :=  _bureauonly;
                    Boolean _derog                           ; // :=  _derog;
                    Boolean _deceased                        ; // :=  _deceased;
                    Boolean _ssnpriortodob                   ; // :=  _ssnpriortodob;
                    Boolean _inputmiskeys                    ; // :=  _inputmiskeys;
                    Boolean _multiplessns                    ; // :=  _multiplessns;
                    Real _hh_strikes                      ; // :=  _hh_strikes;
                    string nf_seg_fraudpoint_3_0            ; // :=  nf_seg_fraudpoint_3_0;
                    Real f_varrisktype_i                  ; // :=  f_varrisktype_i;
                    Real f_hh_age_18_plus_d               ; // :=  f_hh_age_18_plus_d;
                    Real f_hh_age_65_plus_d               ; // :=  f_hh_age_65_plus_d;
                    real f_hh_age_30_plus_d               ; // :=  f_hh_age_30_plus_d;
                    Integer f_hh_bankruptcies_i              ; // :=  f_hh_bankruptcies_i;
                    Real f_hh_college_attendees_d         ; // :=  f_hh_college_attendees_d;
                    Real f_hh_members_ct_d                ; // :=  f_hh_members_ct_d;
                    Real f_hh_members_w_derog_i           ; // :=  f_hh_members_w_derog_i;
                    Integer f_hh_payday_loan_users_i         ; // :=  f_hh_payday_loan_users_i;
                    Integer f_hh_prof_license_holders_d      ; // :=  f_hh_prof_license_holders_d;
                    Integer f_hh_workers_paw_d               ; // :=  f_hh_workers_paw_d;
                    Real f_adl_util_conv_n                ; // :=  f_adl_util_conv_n;
                    Integer f_util_add_curr_conv_n           ; // :=  f_util_add_curr_conv_n;
                    Real f_util_add_curr_inf_n            ; // :=  f_util_add_curr_inf_n;
                    Integer f_util_add_input_conv_n          ; // :=  f_util_add_input_conv_n;
                    integer f_util_add_input_inf_n           ; // :=  f_util_add_input_inf_n;
                    Integer f_util_adl_count_n               ; // :=  f_util_adl_count_n;
                    Integer f_bus_name_nover_i               ; // :=  f_bus_name_nover_i;
                    Real r_e57_br_source_count_d          ; // :=  r_e57_br_source_count_d;
                    Integer r_l71_add_business_i             ; // :=  r_l71_add_business_i;
                    Integer f_addrs_per_ssn_i                ; // :=  f_addrs_per_ssn_i;
                    Integer f_srchaddrsrchcountmo_i          ; // :=  f_srchaddrsrchcountmo_i;
                    integer f_srchaddrsrchcountwk_i          ; // :=  f_srchaddrsrchcountwk_i;
                    Integer f_srchcomponentrisktype_i        ; // :=  f_srchcomponentrisktype_i;
                    Integer f_srchcountwk_i                  ; // :=  f_srchcountwk_i;
                    Integer f_srchfraudsrchcountwk_i         ; // :=  f_srchfraudsrchcountwk_i;
                    Integer f_srchfraudsrchcountyr_i         ; // :=  f_srchfraudsrchcountyr_i;
                    integer f_srchlocatesrchcountwk_i        ; // :=  f_srchlocatesrchcountwk_i;
                    Integer f_srchunvrfdaddrcount_i          ; // :=  f_srchunvrfdaddrcount_i;
                    Integer f_srchunvrfdssncount_i           ; // :=  f_srchunvrfdssncount_i;
                    Integer f_srchvelocityrisktype_i         ; // :=  f_srchvelocityrisktype_i;
                    integer k_inq_adls_per_addr_i            ; // :=  k_inq_adls_per_addr_i;
                    Integer k_inq_lnames_per_addr_i          ; // :=  k_inq_lnames_per_addr_i;
                    Integer k_inq_per_addr_i                 ; // :=  k_inq_per_addr_i;
                    Integer k_inq_ssns_per_addr_i            ; // :=  k_inq_ssns_per_addr_i;
                    Integer r_l79_adls_per_addr_c6_i         ; // :=  r_l79_adls_per_addr_c6_i;
                    Integer r_l79_adls_per_addr_curr_i       ; // :=  r_l79_adls_per_addr_curr_i;
                    Integer f_inq_collection_count24_i       ; // :=  f_inq_collection_count24_i;
                    Real f_inq_communications_cnt_week_i  ; // :=  f_inq_communications_cnt_week_i;
                    Real f_inq_communications_count24_i   ; // :=  f_inq_communications_count24_i;
                    Real f_inq_count24_i                  ; // :=  f_inq_count24_i;
                    Real f_inq_highriskcredit_count24_i   ; // :=  f_inq_highriskcredit_count24_i;
                    Real f_inq_other_count24_i            ; // :=  f_inq_other_count24_i;
                    Integer r_i60_credit_seeking_i           ; // :=  r_i60_credit_seeking_i;
                    Real r_i60_inq_auto_count12_i         ; // :=  r_i60_inq_auto_count12_i;
                    Real r_i60_inq_auto_recency_d         ; // :=  r_i60_inq_auto_recency_d;
                    Integer r_i60_inq_banking_count12_i      ; // :=  r_i60_inq_banking_count12_i;
                    Real r_i60_inq_banking_recency_d      ; // :=  r_i60_inq_banking_recency_d;
                    integer r_i60_inq_comm_count12_i         ; // :=  r_i60_inq_comm_count12_i;
                    integer r_i60_inq_comm_recency_d         ; // :=  r_i60_inq_comm_recency_d;
                    Real r_i60_inq_count12_i              ; // :=  r_i60_inq_count12_i;
                    Real r_i60_inq_recency_d              ; // :=  r_i60_inq_recency_d;
                    Integer r_i61_inq_collection_recency_d   ; // :=  r_i61_inq_collection_recency_d;
                    Integer r_i60_inq_hiriskcred_recency_d   ; // :=  r_i60_inq_hiriskcred_recency_d;
                    Integer r_i60_inq_prepaidcards_recency_d ; // :=  r_i60_inq_prepaidcards_recency_d;
                    Real r_i60_inq_retpymt_recency_d      ; // :=  r_i60_inq_retpymt_recency_d;
                    integer r_i60_inq_util_count12_i         ; // :=  r_i60_inq_util_count12_i;
                    Integer r_i60_inq_util_recency_d         ; // :=  r_i60_inq_util_recency_d;
                    Integer r_c16_inv_ssn_per_adl_i          ; // :=  r_c16_inv_ssn_per_adl_i;
                    Real r_c18_invalid_addrs_per_adl_i    ; // :=  r_c18_invalid_addrs_per_adl_i;
                    Real f_prevaddrlenofres_d             ; // :=  f_prevaddrlenofres_d;
                    Real r_c13_curr_addr_lres_d           ; // :=  r_c13_curr_addr_lres_d;
                    Real r_c13_max_lres_d                 ; // :=  r_c13_max_lres_d;
                    Real f_liens_rel_cj_total_amt_i       ; // :=  f_liens_rel_cj_total_amt_i;
                    Real f_liens_unrel_cj_total_amt_i     ; // :=  f_liens_unrel_cj_total_amt_i;
                    Real f_liens_unrel_ft_total_amt_i     ; // :=  f_liens_unrel_ft_total_amt_i;
                    Real f_liens_unrel_o_total_amt_i      ; // :=  f_liens_unrel_o_total_amt_i;
                    Real f_liens_unrel_ot_total_amt_i     ; // :=  f_liens_unrel_ot_total_amt_i;
                    Real f_liens_unrel_sc_total_amt_i     ; // :=  f_liens_unrel_sc_total_amt_i;
                    Real f_liens_unrel_st_ct_i            ; // :=  f_liens_unrel_st_ct_i;
                    Real f_liens_unrel_st_total_amt_i     ; // :=  f_liens_unrel_st_total_amt_i;
                    Real _liens_rel_cj_first_seen         ; // :=  _liens_rel_cj_first_seen;
                    Real f_mos_liens_rel_cj_fseen_d       ; // :=  f_mos_liens_rel_cj_fseen_d;
                    Real _liens_rel_cj_last_seen          ; // :=  _liens_rel_cj_last_seen;
                    Real f_mos_liens_rel_cj_lseen_d       ; // :=  f_mos_liens_rel_cj_lseen_d;
                    Real _liens_rel_o_last_seen           ; // :=  _liens_rel_o_last_seen;
                    Real f_mos_liens_rel_o_lseen_d        ; // :=  f_mos_liens_rel_o_lseen_d;
                    Real _liens_unrel_cj_last_seen        ; // :=  _liens_unrel_cj_last_seen;
                    Real f_mos_liens_unrel_cj_lseen_d     ; // :=  f_mos_liens_unrel_cj_lseen_d;
                    Integer _liens_unrel_ot_first_seen       ; // :=  _liens_unrel_ot_first_seen;
                    Integer f_mos_liens_unrel_ot_fseen_d     ; // :=  f_mos_liens_unrel_ot_fseen_d;
                    Integer _liens_unrel_sc_first_seen       ; // :=  _liens_unrel_sc_first_seen;
                    Integer f_mos_liens_unrel_sc_fseen_d     ; // :=  f_mos_liens_unrel_sc_fseen_d;
                    Integer _liens_unrel_st_last_seen        ; // :=  _liens_unrel_st_last_seen;
                    Integer f_mos_liens_unrel_st_lseen_d     ; // :=  f_mos_liens_unrel_st_lseen_d;
                    Real r_d34_unrel_liens_ct_i           ; // :=  r_d34_unrel_liens_ct_i;
                    Boolean k_nap_lname_verd_d               ; // :=  k_nap_lname_verd_d;
                    Boolean k_nap_nothing_found_i            ; // :=  k_nap_nothing_found_i;
                    Integer r_f01_inp_addr_address_score_d   ; // :=  r_f01_inp_addr_address_score_d;
                    integer r_f01_inp_addr_not_verified_i    ; // :=  r_f01_inp_addr_not_verified_i;
                    Real f_add_curr_mobility_index_i      ; // :=  f_add_curr_mobility_index_i;
                    Real f_add_input_mobility_index_i     ; // :=  f_add_input_mobility_index_i;
                    Real f_addrchangecrimediff_i          ; // :=  f_addrchangecrimediff_i;
                    Real f_curraddrburglaryindex_i        ; // :=  f_curraddrburglaryindex_i;
                    Real f_curraddrcrimeindex_i           ; // :=  f_curraddrcrimeindex_i;
                    Real f_curraddrmurderindex_i          ; // :=  f_curraddrmurderindex_i;
                    Real f_curraddrcartheftindex_i        ; // :=  f_curraddrcartheftindex_i;
                    Real f_fp_prevaddrburglaryindex_i     ; // :=  f_fp_prevaddrburglaryindex_i;
                    Real f_fp_prevaddrcrimeindex_i        ; // :=  f_fp_prevaddrcrimeindex_i;
                    Real f_prevaddrmurderindex_i          ; // :=  f_prevaddrmurderindex_i;
                    Real f_prevaddrcartheftindex_i        ; // :=  f_prevaddrcartheftindex_i;
                    Real f_add_curr_has_vac_ct_i          ; // :=  f_add_curr_has_vac_ct_i;
                    Real f_add_curr_nhood_vac_pct_i       ; // :=  f_add_curr_nhood_vac_pct_i;
                    Real f_add_curr_nhood_sfd_pct_d       ; // :=  f_add_curr_nhood_sfd_pct_d;
                    Real f_add_curr_nhood_mfd_pct_i       ; // :=  f_add_curr_nhood_mfd_pct_i;
                    Real add_curr_nhood_prop_sum          ; // :=  add_curr_nhood_prop_sum;
                    Real f_add_curr_nhood_bus_pct_i       ; // :=  f_add_curr_nhood_bus_pct_i;
                    integer f_add_input_has_sfd_ct_d         ; // :=  f_add_input_has_sfd_ct_d;
                    Real f_add_input_nhood_sfd_pct_d      ; // :=  f_add_input_nhood_sfd_pct_d;
                    integer f_add_input_has_vac_ct_i         ; // :=  f_add_input_has_vac_ct_i;
                    Real f_add_input_nhood_vac_pct_i      ; // :=  f_add_input_nhood_vac_pct_i;
                    Real f_add_input_nhood_mfd_pct_i      ; // :=  f_add_input_nhood_mfd_pct_i;
                    Real add_input_nhood_prop_sum         ; // :=  add_input_nhood_prop_sum;
                    Real f_add_input_nhood_bus_pct_i      ; // :=  f_add_input_nhood_bus_pct_i;
                    Real f_addrchangeincomediff_d         ; // :=  f_addrchangeincomediff_d;
                    Real f_curraddrmedianincome_d         ; // :=  f_curraddrmedianincome_d;
                    Real f_prevaddrmedianincome_d         ; // :=  f_prevaddrmedianincome_d;
                    Real f_addrchangevaluediff_d          ; // :=  f_addrchangevaluediff_d;
                    Real f_curraddrmedianvalue_d          ; // :=  f_curraddrmedianvalue_d;
                    Real f_prevaddrmedianvalue_d          ; // :=  f_prevaddrmedianvalue_d;
                    Real f_dl_addrs_per_adl_i             ; // :=  f_dl_addrs_per_adl_i;
                    Real f_divrisktype_i                  ; // :=  f_divrisktype_i;
                    Real f_phones_per_addr_c6_i           ; // :=  f_phones_per_addr_c6_i;
                    Integer f_phones_per_addr_curr_i         ; // :=  f_phones_per_addr_curr_i;
                    Real f_sourcerisktype_i               ; // :=  f_sourcerisktype_i;
                    Real r_a46_curr_avm_autoval_d         ; // :=  r_a46_curr_avm_autoval_d;
                    Real r_a49_curr_avm_chg_1yr_i         ; // :=  r_a49_curr_avm_chg_1yr_i;
                    Real r_a49_curr_avm_chg_1yr_pct_i     ; // :=  r_a49_curr_avm_chg_1yr_pct_i;
                    Real r_l80_inp_avm_autoval_d          ; // :=  r_l80_inp_avm_autoval_d;
                    Real f_current_count_d                ; // :=  f_current_count_d;
                    Real f_historical_count_d             ; // :=  f_historical_count_d;
                    Real f_assoccredbureaucount_i         ; // :=  f_assoccredbureaucount_i;
                    Real f_assocrisktype_i                ; // :=  f_assocrisktype_i;
                    Real f_assocsuspicousidcount_i        ; // :=  f_assocsuspicousidcount_i;
                    Real f_crim_rel_under25miles_cnt_i    ; // :=  f_crim_rel_under25miles_cnt_i;
                    Real f_crim_rel_under500miles_cnt_i   ; // :=  f_crim_rel_under500miles_cnt_i;
                    Real f_rel_ageover20_count_d          ; // :=  f_rel_ageover20_count_d;
                    Real f_rel_ageover30_count_d          ; // :=  f_rel_ageover30_count_d;
                    Real f_rel_ageover40_count_d          ; // :=  f_rel_ageover40_count_d;
                    Real f_rel_count_i                    ; // :=  f_rel_count_i;
                    Real f_rel_educationover8_count_d     ; // :=  f_rel_educationover8_count_d;
                    Real f_rel_educationover12_count_d    ; // :=  f_rel_educationover12_count_d;
                    Real f_rel_felony_count_i             ; // :=  f_rel_felony_count_i;
                    Real f_rel_homeover50_count_d         ; // :=  f_rel_homeover50_count_d;
                    Real f_rel_homeover100_count_d        ; // :=  f_rel_homeover100_count_d;
                    Real f_rel_homeover150_count_d        ; // :=  f_rel_homeover150_count_d;
                    Real f_rel_homeover200_count_d        ; // :=  f_rel_homeover200_count_d;
                    Real f_rel_homeover300_count_d        ; // :=  f_rel_homeover300_count_d;
                    Real f_rel_incomeover25_count_d       ; // :=  f_rel_incomeover25_count_d;
                    Real f_rel_incomeover50_count_d       ; // :=  f_rel_incomeover50_count_d;
                    Real f_rel_incomeover75_count_d       ; // :=  f_rel_incomeover75_count_d;
                    Real f_rel_incomeover100_count_d      ; // :=  f_rel_incomeover100_count_d;
                    Real f_rel_under100miles_cnt_d        ; // :=  f_rel_under100miles_cnt_d;
                    Real f_rel_under500miles_cnt_d        ; // :=  f_rel_under500miles_cnt_d;
                    Real f_rel_under25miles_cnt_d         ; // :=  f_rel_under25miles_cnt_d;
                    Real f_divaddrsuspidcountnew_i        ; // :=  f_divaddrsuspidcountnew_i;
                    Real _src_bureau_adl_fseen_all        ; // :=  _src_bureau_adl_fseen_all;
                    Real f_m_bureau_adl_fs_all_d          ; // :=  f_m_bureau_adl_fs_all_d;
                    Real bureau_adl_en_fseen_pos          ; // :=  bureau_adl_en_fseen_pos;
                    string bureau_adl_fseen_en              ; // :=  bureau_adl_fseen_en;
                    Real _bureau_adl_fseen_en             ; // :=  _bureau_adl_fseen_en;
                    Real bureau_adl_ts_fseen_pos          ; // :=  bureau_adl_ts_fseen_pos;
                    string bureau_adl_fseen_ts              ; // :=  bureau_adl_fseen_ts;
                    Real _bureau_adl_fseen_ts             ; // :=  _bureau_adl_fseen_ts;
                    Real bureau_adl_tu_fseen_pos          ; // :=  bureau_adl_tu_fseen_pos;
                    string bureau_adl_fseen_tu              ; // :=  bureau_adl_fseen_tu;
                    Real _bureau_adl_fseen_tu             ; // :=  _bureau_adl_fseen_tu;
                    Real bureau_adl_tn_fseen_pos          ; // :=  bureau_adl_tn_fseen_pos;
                    string bureau_adl_fseen_tn              ; // :=  bureau_adl_fseen_tn;
                    Real _bureau_adl_fseen_tn             ; // :=  _bureau_adl_fseen_tn;
                    Real _src_bureau_adl_fseen_notu       ; // :=  _src_bureau_adl_fseen_notu;
                    Real f_m_bureau_adl_fs_notu_d         ; // :=  f_m_bureau_adl_fs_notu_d;
                    Real _header_first_seen               ; // :=  _header_first_seen;
                    Real r_c10_m_hdr_fs_d                 ; // :=  r_c10_m_hdr_fs_d;
                    Real bureau_adl_eq_fseen_pos          ; // :=  bureau_adl_eq_fseen_pos;
                    string bureau_adl_fseen_eq              ; // :=  bureau_adl_fseen_eq;
                    Real _bureau_adl_fseen_eq             ; // :=  _bureau_adl_fseen_eq;
                    Real _src_bureau_adl_fseen            ; // :=  _src_bureau_adl_fseen;
                    Real r_c21_m_bureau_adl_fs_d          ; // :=  r_c21_m_bureau_adl_fs_d;
                    Real r_wealth_index_d                 ; // :=  r_wealth_index_d;
                    Real final_score_0                    ; // :=  final_score_0;
                    Real final_score_1                    ; // :=  final_score_1;
                    Real final_score_2                    ; // :=  final_score_2;
                    Real final_score_3                    ; // :=  final_score_3;
                    Real final_score_4                    ; // :=  final_score_4;
                    Real final_score_5                    ; // :=  final_score_5;
                    Real final_score_6                    ; // :=  final_score_6;
                    Real final_score_7                    ; // :=  final_score_7;
                    Real final_score_8                    ; // :=  final_score_8;
                    Real final_score_9                    ; // :=  final_score_9;
                    Real final_score_10                   ; // :=  final_score_10;
                    Real final_score_11                   ; // :=  final_score_11;
                    Real final_score_12                   ; // :=  final_score_12;
                    Real final_score_13                   ; // :=  final_score_13;
                    Real final_score_14                   ; // :=  final_score_14;
                    Real final_score_15                   ; // :=  final_score_15;
                    Real final_score_16                   ; // :=  final_score_16;
                    Real final_score_17                   ; // :=  final_score_17;
                    Real final_score_18                   ; // :=  final_score_18;
                    Real final_score_19                   ; // :=  final_score_19;
                    Real final_score_20                   ; // :=  final_score_20;
                    Real final_score_21                   ; // :=  final_score_21;
                    Real final_score_22                   ; // :=  final_score_22;
                    Real final_score_23                   ; // :=  final_score_23;
                    Real final_score_24                   ; // :=  final_score_24;
                    Real final_score_25                   ; // :=  final_score_25;
                    Real final_score_26                   ; // :=  final_score_26;
                    Real final_score_27                   ; // :=  final_score_27;
                    Real final_score_28                   ; // :=  final_score_28;
                    Real final_score_29                   ; // :=  final_score_29;
                    Real final_score_30                   ; // :=  final_score_30;
                    Real final_score_31                   ; // :=  final_score_31;
                    Real final_score_32                   ; // :=  final_score_32;
                    Real final_score_33                   ; // :=  final_score_33;
                    Real final_score_34                   ; // :=  final_score_34;
                    Real final_score_35                   ; // :=  final_score_35;
                    Real final_score_36                   ; // :=  final_score_36;
                    Real final_score_37                   ; // :=  final_score_37;
                    Real final_score_38                   ; // :=  final_score_38;
                    Real final_score_39                   ; // :=  final_score_39;
                    Real final_score_40                   ; // :=  final_score_40;
                    Real final_score_41                   ; // :=  final_score_41;
                    Real final_score_42                   ; // :=  final_score_42;
                    Real final_score_43                   ; // :=  final_score_43;
                    Real final_score_44                   ; // :=  final_score_44;
                    Real final_score_45                   ; // :=  final_score_45;
                    Real final_score_46                   ; // :=  final_score_46;
                    Real final_score_47                   ; // :=  final_score_47;
                    Real final_score_48                   ; // :=  final_score_48;
                    Real final_score_49                   ; // :=  final_score_49;
                    Real final_score_50                   ; // :=  final_score_50;
                    Real final_score_51                   ; // :=  final_score_51;
                    Real final_score_52                   ; // :=  final_score_52;
                    Real final_score_53                   ; // :=  final_score_53;
                    Real final_score_54                   ; // :=  final_score_54;
                    Real final_score_55                   ; // :=  final_score_55;
                    Real final_score_56                   ; // :=  final_score_56;
                    Real final_score_57                   ; // :=  final_score_57;
                    Real final_score_58                   ; // :=  final_score_58;
                    Real final_score_59                   ; // :=  final_score_59;
                    Real final_score_60                   ; // :=  final_score_60;
                    Real final_score_61                   ; // :=  final_score_61;
                    Real final_score_62                   ; // :=  final_score_62;
                    Real final_score_63                   ; // :=  final_score_63;
                    Real final_score_64                   ; // :=  final_score_64;
                    Real final_score_65                   ; // :=  final_score_65;
                    Real final_score_66                   ; // :=  final_score_66;
                    Real final_score_67                   ; // :=  final_score_67;
                    Real final_score_68                   ; // :=  final_score_68;
                    Real final_score_69                   ; // :=  final_score_69;
                    Real final_score_70                   ; // :=  final_score_70;
                    Real final_score_71                   ; // :=  final_score_71;
                    Real final_score_72                   ; // :=  final_score_72;
                    Real final_score_73                   ; // :=  final_score_73;
                    Real final_score_74                   ; // :=  final_score_74;
                    Real final_score_75                   ; // :=  final_score_75;
                    Real final_score_76                   ; // :=  final_score_76;
                    Real final_score_77                   ; // :=  final_score_77;
                    Real final_score_78                   ; // :=  final_score_78;
                    Real final_score_79                   ; // :=  final_score_79;
                    Real final_score_80                   ; // :=  final_score_80;
                    Real final_score_81                   ; // :=  final_score_81;
                    Real final_score_82                   ; // :=  final_score_82;
                    Real final_score_83                   ; // :=  final_score_83;
                    Real final_score_84                   ; // :=  final_score_84;
                    Real final_score_85                   ; // :=  final_score_85;
                    Real final_score_86                   ; // :=  final_score_86;
                    Real final_score_87                   ; // :=  final_score_87;
                    Real final_score_88                   ; // :=  final_score_88;
                    Real final_score_89                   ; // :=  final_score_89;
                    Real final_score_90                   ; // :=  final_score_90;
                    Real final_score_91                   ; // :=  final_score_91;
                    Real final_score_92                   ; // :=  final_score_92;
                    Real final_score_93                   ; // :=  final_score_93;
                    Real final_score_94                   ; // :=  final_score_94;
                    Real final_score_95                   ; // :=  final_score_95;
                    Real final_score_96                   ; // :=  final_score_96;
                    Real final_score_97                   ; // :=  final_score_97;
                    Real final_score_98                   ; // :=  final_score_98;
                    Real final_score_99                   ; // :=  final_score_99;
                    Real final_score_100                  ; // :=  final_score_100;
                    Real final_score_101                  ; // :=  final_score_101;
                    Real final_score_102                  ; // :=  final_score_102;
                    Real final_score_103                  ; // :=  final_score_103;
                    Real final_score_104                  ; // :=  final_score_104;
                    Real final_score_105                  ; // :=  final_score_105;
                    Real final_score_106                  ; // :=  final_score_106;
                    Real final_score_107                  ; // :=  final_score_107;
                    Real final_score_108                  ; // :=  final_score_108;
                    Real final_score_109                  ; // :=  final_score_109;
                    Real final_score_110                  ; // :=  final_score_110;
                    Real final_score_111                  ; // :=  final_score_111;
                    Real final_score_112                  ; // :=  final_score_112;
                    Real final_score_113                  ; // :=  final_score_113;
                    Real final_score_114                  ; // :=  final_score_114;
                    Real final_score_115                  ; // :=  final_score_115;
                    Real final_score_116                  ; // :=  final_score_116;
                    Real final_score_117                  ; // :=  final_score_117;
                    Real final_score_118                  ; // :=  final_score_118;
                    Real final_score_119                  ; // :=  final_score_119;
                    Real final_score_120                  ; // :=  final_score_120;
                    Real final_score_121                  ; // :=  final_score_121;
                    Real final_score_122                  ; // :=  final_score_122;
                    Real final_score_123                  ; // :=  final_score_123;
                    Real final_score_124                  ; // :=  final_score_124;
                    Real final_score_125                  ; // :=  final_score_125;
                    Real final_score_126                  ; // :=  final_score_126;
                    Real final_score_127                  ; // :=  final_score_127;
                    Real final_score_128                  ; // :=  final_score_128;
                    Real final_score_129                  ; // :=  final_score_129;
                    Real final_score_130                  ; // :=  final_score_130;
                    Real final_score_131                  ; // :=  final_score_131;
                    Real final_score_132                  ; // :=  final_score_132;
                    Real final_score_133                  ; // :=  final_score_133;
                    Real final_score_134                  ; // :=  final_score_134;
                    Real final_score_135                  ; // :=  final_score_135;
                    Real final_score_136                  ; // :=  final_score_136;
                    Real final_score_137                  ; // :=  final_score_137;
                    Real final_score_138                  ; // :=  final_score_138;
                    Real final_score_139                  ; // :=  final_score_139;
                    Real final_score_140                  ; // :=  final_score_140;
                    Real final_score_141                  ; // :=  final_score_141;
                    Real final_score_142                  ; // :=  final_score_142;
                    Real final_score_143                  ; // :=  final_score_143;
                    Real final_score_144                  ; // :=  final_score_144;
                    Real final_score_145                  ; // :=  final_score_145;
                    Real final_score_146                  ; // :=  final_score_146;
                    Real final_score_147                  ; // :=  final_score_147;
                    Real final_score_148                  ; // :=  final_score_148;
                    Real final_score_149                  ; // :=  final_score_149;
                    Real final_score_150                  ; // :=  final_score_150;
                    Real final_score_151                  ; // :=  final_score_151;
                    Real final_score_152                  ; // :=  final_score_152;
                    Real final_score_153                  ; // :=  final_score_153;
                    Real final_score_154                  ; // :=  final_score_154;
                    Real final_score_155                  ; // :=  final_score_155;
                    Real final_score_156                  ; // :=  final_score_156;
                    Real final_score_157                  ; // :=  final_score_157;
                    Real final_score_158                  ; // :=  final_score_158;
                    Real final_score_159                  ; // :=  final_score_159;
                    Real final_score_160                  ; // :=  final_score_160;
                    Real final_score_161                  ; // :=  final_score_161;
                    Real final_score_162                  ; // :=  final_score_162;
                    Real final_score_163                  ; // :=  final_score_163;
                    Real final_score_164                  ; // :=  final_score_164;
                    Real final_score_165                  ; // :=  final_score_165;
                    Real final_score_166                  ; // :=  final_score_166;
                    Real final_score_167                  ; // :=  final_score_167;
                    Real final_score_168                  ; // :=  final_score_168;
                    Real final_score_169                  ; // :=  final_score_169;
                    Real final_score_170                  ; // :=  final_score_170;
                    Real final_score_171                  ; // :=  final_score_171;
                    Real final_score_172                  ; // :=  final_score_172;
                    Real final_score_173                  ; // :=  final_score_173;
                    Real final_score_174                  ; // :=  final_score_174;
                    Real final_score_175                  ; // :=  final_score_175;
                    Real final_score_176                  ; // :=  final_score_176;
                    Real final_score_177                  ; // :=  final_score_177;
                    Real final_score_178                  ; // :=  final_score_178;
                    Real final_score_179                  ; // :=  final_score_179;
                    Real final_score_180                  ; // :=  final_score_180;
                    Real final_score_181                  ; // :=  final_score_181;
                    Real final_score_182                  ; // :=  final_score_182;
                    Real final_score_183                  ; // :=  final_score_183;
                    Real final_score_184                  ; // :=  final_score_184;
                    Real final_score_185                  ; // :=  final_score_185;
                    Real final_score_186                  ; // :=  final_score_186;
                    Real final_score_187                  ; // :=  final_score_187;
                    Real final_score_188                  ; // :=  final_score_188;
                    Real final_score_189                  ; // :=  final_score_189;
                    Real final_score_190                  ; // :=  final_score_190;
                    Real final_score_191                  ; // :=  final_score_191;
                    Real final_score_192                  ; // :=  final_score_192;
                    Real final_score_193                  ; // :=  final_score_193;
                    Real final_score_194                  ; // :=  final_score_194;
                    Real final_score_195                  ; // :=  final_score_195;
                    Real final_score_196                  ; // :=  final_score_196;
                    Real final_score_197                  ; // :=  final_score_197;
                    Real final_score_198                  ; // :=  final_score_198;
                    Real final_score_199                  ; // :=  final_score_199;
                    Real final_score_200                  ; // :=  final_score_200;
                    Real final_score_201                  ; // :=  final_score_201;
                    Real final_score_202                  ; // :=  final_score_202;
                    Real final_score_203                  ; // :=  final_score_203;
                    Real final_score_204                  ; // :=  final_score_204;
                    Real final_score_205                  ; // :=  final_score_205;
                    Real final_score_206                  ; // :=  final_score_206;
                    Real final_score_207                  ; // :=  final_score_207;
                    Real final_score_208                  ; // :=  final_score_208;
                    Real final_score_209                  ; // :=  final_score_209;
                    Real final_score_210                  ; // :=  final_score_210;
                    Real final_score_211                  ; // :=  final_score_211;
                    Real final_score_212                  ; // :=  final_score_212;
                    Real final_score_213                  ; // :=  final_score_213;
                    Real final_score_214                  ; // :=  final_score_214;
                    Real final_score_215                  ; // :=  final_score_215;
                    Real final_score_216                  ; // :=  final_score_216;
                    Real final_score_217                  ; // :=  final_score_217;
                    Real final_score_218                  ; // :=  final_score_218;
                    Real final_score_219                  ; // :=  final_score_219;
                    Real final_score_220                  ; // :=  final_score_220;
                    Real final_score_221                  ; // :=  final_score_221;
                    Real final_score_222                  ; // :=  final_score_222;
                    Real final_score_223                  ; // :=  final_score_223;
                    Real final_score_224                  ; // :=  final_score_224;
                    Real final_score_225                  ; // :=  final_score_225;
                    Real final_score_226                  ; // :=  final_score_226;
                    Real final_score_227                  ; // :=  final_score_227;
                    Real final_score_228                  ; // :=  final_score_228;
                    Real final_score_229                  ; // :=  final_score_229;
                    Real final_score_230                  ; // :=  final_score_230;
                    Real final_score_231                  ; // :=  final_score_231;
                    Real final_score_232                  ; // :=  final_score_232;
                    Real final_score_233                  ; // :=  final_score_233;
                    Real final_score_234                  ; // :=  final_score_234;
                    Real final_score_235                  ; // :=  final_score_235;
                    Real final_score_236                  ; // :=  final_score_236;
                    Real final_score_237                  ; // :=  final_score_237;
                    Real final_score_238                  ; // :=  final_score_238;
                    Real final_score_239                  ; // :=  final_score_239;
                    Real final_score_240                  ; // :=  final_score_240;
                    Real final_score_241                  ; // :=  final_score_241;
                    Real final_score_242                  ; // :=  final_score_242;
                    Real final_score_243                  ; // :=  final_score_243;
                    Real final_score_244                  ; // :=  final_score_244;
                    Real final_score_245                  ; // :=  final_score_245;
                    Real final_score_246                  ; // :=  final_score_246;
                    Real final_score_247                  ; // :=  final_score_247;
                    Real final_score_248                  ; // :=  final_score_248;
                    Real final_score_249                  ; // :=  final_score_249;
                    Real final_score_250                  ; // :=  final_score_250;
                    Real final_score_251                  ; // :=  final_score_251;
                    Real final_score_252                  ; // :=  final_score_252;
                    Real final_score_253                  ; // :=  final_score_253;
                    Real final_score_254                  ; // :=  final_score_254;
                    Real final_score_255                  ; // :=  final_score_255;
                    Real final_score_256                  ; // :=  final_score_256;
                    Real final_score_257                  ; // :=  final_score_257;
                    Real final_score_258                  ; // :=  final_score_258;
                    Real final_score_259                  ; // :=  final_score_259;
                    Real final_score_260                  ; // :=  final_score_260;
                    Real final_score_261                  ; // :=  final_score_261;
                    Real final_score_262                  ; // :=  final_score_262;
                    Real final_score_263                  ; // :=  final_score_263;
                    Real final_score_264                  ; // :=  final_score_264;
                    Real final_score_265                  ; // :=  final_score_265;
                    Real final_score_266                  ; // :=  final_score_266;
                    Real final_score_267                  ; // :=  final_score_267;
                    Real final_score_268                  ; // :=  final_score_268;
                    Real final_score_269                  ; // :=  final_score_269;
                    Real final_score_270                  ; // :=  final_score_270;
                    Real final_score_271                  ; // :=  final_score_271;
                    Real final_score_272                  ; // :=  final_score_272;
                    Real final_score_273                  ; // :=  final_score_273;
                    Real final_score_274                  ; // :=  final_score_274;
                    Real final_score_275                  ; // :=  final_score_275;
                    Real final_score_276                  ; // :=  final_score_276;
                    Real final_score_277                  ; // :=  final_score_277;
                    Real final_score_278                  ; // :=  final_score_278;
                    Real final_score_279                  ; // :=  final_score_279;
                    Real final_score_280                  ; // :=  final_score_280;
                    Real final_score_281                  ; // :=  final_score_281;
                    Real final_score_282                  ; // :=  final_score_282;
                    Real final_score_283                  ; // :=  final_score_283;
                    Real final_score_284                  ; // :=  final_score_284;
                    Real final_score_285                  ; // :=  final_score_285;
                    Real final_score_286                  ; // :=  final_score_286;
                    Real final_score_287                  ; // :=  final_score_287;
                    Real final_score_288                  ; // :=  final_score_288;
                    Real final_score_289                  ; // :=  final_score_289;
                    Real final_score_290                  ; // :=  final_score_290;
                    Real final_score_291                  ; // :=  final_score_291;
                    Real final_score_292                  ; // :=  final_score_292;
                    Real final_score_293                  ; // :=  final_score_293;
                    Real final_score_294                  ; // :=  final_score_294;
                    Real final_score_295                  ; // :=  final_score_295;
                    Real final_score_296                  ; // :=  final_score_296;
                    Real final_score_297                  ; // :=  final_score_297;
                    Real final_score_298                  ; // :=  final_score_298;
                    Real final_score_299                  ; // :=  final_score_299;
                    Real final_score_300                  ; // :=  final_score_300;
                    Real final_score_301                  ; // :=  final_score_301;
                    Real final_score_302                  ; // :=  final_score_302;
                    Real final_score_303                  ; // :=  final_score_303;
                    Real final_score_304                  ; // :=  final_score_304;
                    Real final_score_305                  ; // :=  final_score_305;
                    Real final_score_306                  ; // :=  final_score_306;
                    Real final_score_307                  ; // :=  final_score_307;
                    Real final_score_308                  ; // :=  final_score_308;
                    Real final_score_309                  ; // :=  final_score_309;
                    Real final_score_310                  ; // :=  final_score_310;
                    Real final_score_311                  ; // :=  final_score_311;
                    Real final_score_312                  ; // :=  final_score_312;
                    Real final_score_313                  ; // :=  final_score_313;
                    Real final_score_314                  ; // :=  final_score_314;
                    Real final_score_315                  ; // :=  final_score_315;
                    Real final_score_316                  ; // :=  final_score_316;
                    Real final_score_317                  ; // :=  final_score_317;
                    Real final_score_318                  ; // :=  final_score_318;
                    Real final_score_319                  ; // :=  final_score_319;
                    Real final_score_320                  ; // :=  final_score_320;
                    Real final_score_321                  ; // :=  final_score_321;
                    Real final_score_322                  ; // :=  final_score_322;
                    Real final_score_323                  ; // :=  final_score_323;
                    Real final_score_324                  ; // :=  final_score_324;
                    Real final_score_325                  ; // :=  final_score_325;
                    Real final_score_326                  ; // :=  final_score_326;
                    Real final_score_327                  ; // :=  final_score_327;
                    Real final_score_328                  ; // :=  final_score_328;
                    Real final_score_329                  ; // :=  final_score_329;
                    Real final_score_330                  ; // :=  final_score_330;
                    Real final_score_331                  ; // :=  final_score_331;
                    Real final_score_332                  ; // :=  final_score_332;
                    Real final_score_333                  ; // :=  final_score_333;
                    Real final_score_334                  ; // :=  final_score_334;
                    Real final_score_335                  ; // :=  final_score_335;
                    Real final_score_336                  ; // :=  final_score_336;
                    Real final_score_337                  ; // :=  final_score_337;
                    Real final_score_338                  ; // :=  final_score_338;
                    Real final_score_339                  ; // :=  final_score_339;
                    Real final_score_340                  ; // :=  final_score_340;
                    Real final_score                      ; // :=  final_score;
                    real pbr                              ; // :=  pbr;
                    real sbr                              ; // :=  sbr;
                    real offset                           ; // :=  offset;
                    Integer base                             ; // :=  base;
                    Integer pts                              ; // :=  pts;
                    Real lgt                              ; // :=  lgt;
                    Integer fp1607_1_0                       ; // :=  fp1607_1_0;
                    integer cust_stolid_index                ; // :=  cust_stolid_index;
                    integer cust_synthid_index               ; // :=  cust_synthid_index;
                    integer cust_manipid_index               ; // :=  cust_manipid_index;
                    integer cust_vulnvic_index               ; // :=  cust_vulnvic_index;
                    integer cust_friendfrd_index             ; // :=  cust_friendfrd_index;
                    integer cust_suspact_index               ; // :=  cust_suspact_index;


			models.layouts.layout_fp1109;
			Risk_Indicators.Layout_Boca_Shell clam;
			END;
			
    layout_debug doModel( clam le ) := TRANSFORM
  #else
    models.layouts.layout_fp1109 doModel( clam le ) := TRANSFORM
		
  #end	

	/* ***********************************************************
	 *             Model Input Variable Assignments              *
	 ************************************************************* */
		truedid                          := le.truedid;
	out_addr_status                  := le.shell_input.addr_status;
	in_dob                           := le.shell_input.dob;
	nas_summary                      := le.iid.nas_summary;
	nap_summary                      := le.iid.nap_summary;
	nap_type                         := le.iid.nap_type;
	rc_ssndod                        := le.ssn_verification.validation.deceasedDate;
	rc_decsflag                      := le.iid.decsflag;
	rc_ssndobflag                    := le.iid.socsdobflag;
	rc_pwssndobflag                  := le.iid.pwsocsdobflag;
	rc_ssnmiskeyflag                 := le.iid.socsmiskeyflag;
	rc_addrmiskeyflag                := le.iid.addrmiskeyflag;
	ver_sources                      := le.header_summary.ver_sources;
	ver_sources_first_seen           := le.header_summary.ver_sources_first_seen_date;
	bus_name_match                   := le.business_header_address_summary.bus_name_match;
	fnamepop                         := le.input_validation.firstname;
	lnamepop                         := le.input_validation.lastname;
	addrpop                          := le.input_validation.address;
	ssnlength                        := le.input_validation.ssn_length;
	hphnpop                          := le.input_validation.homephone;
	util_adl_type_list               := le.utility.utili_adl_type;
	util_adl_count                   := le.utility.utili_adl_count;
	util_add_input_type_list         := le.utility.utili_addr1_type;
	util_add_curr_type_list          := le.utility.utili_addr2_type;
	add_input_address_score          := le.address_verification.input_address_information.address_score;
	add_input_house_number_match     := le.address_verification.input_address_information.house_number_match;
	add_input_isbestmatch            := le.address_verification.input_address_information.isbestmatch;
	add_input_addr_not_verified      := le.address_verification.inputAddr_not_verified;
	add_input_occ_index              := le.address_verification.inputaddr_occupancy_index;
	add_input_advo_vacancy           := le.advo_input_addr.Address_Vacancy_Indicator;
	add_input_advo_drop              := le.advo_input_addr.Drop_Indicator;
	add_input_advo_res_or_bus        := le.advo_input_addr.Residential_or_Business_Ind;
	add_input_avm_auto_val           := le.avm.input_address_information.avm_automated_valuation;
	add_input_occupants_1yr          := le.addr_risk_summary.occupants_1yr;
	add_input_turnover_1yr_in        := le.addr_risk_summary.turnover_1yr_in;
	add_input_turnover_1yr_out       := le.addr_risk_summary.turnover_1yr_out;
	add_input_nhood_vac_prop         := le.addr_risk_summary.N_Vacant_Properties;
	add_input_nhood_bus_ct           := le.addr_risk_summary.N_Business_Count;
	add_input_nhood_sfd_ct           := le.addr_risk_summary.N_SFD_Count;
	add_input_nhood_mfd_ct           := le.addr_risk_summary.N_MFD_Count;
	add_input_pop                    := le.addrPop;
	add_curr_isbestmatch             := le.address_verification.address_history_1.isbestmatch;
	add_curr_lres                    := le.lres2;
	add_curr_occ_index               := le.address_verification.currAddr_occupancy_index;
	add_curr_advo_vacancy            := le.advo_addr_hist1.Address_Vacancy_Indicator;
	add_curr_advo_drop               := le.advo_addr_hist1.Drop_Indicator;
	add_curr_avm_auto_val            := le.avm.address_history_1.avm_automated_valuation;
	add_curr_avm_auto_val_2          := le.avm.address_history_1.avm_automated_valuation2;
	add_curr_occupants_1yr           := le.addr_risk_summary2.occupants_1yr;
	add_curr_turnover_1yr_in         := le.addr_risk_summary2.turnover_1yr_in;
	add_curr_turnover_1yr_out        := le.addr_risk_summary2.turnover_1yr_out;
	add_curr_nhood_vac_prop          := le.addr_risk_summary2.N_Vacant_Properties;
	add_curr_nhood_bus_ct            := le.addr_risk_summary2.N_Business_Count;
	add_curr_nhood_sfd_ct            := le.addr_risk_summary2.N_SFD_Count;
	add_curr_nhood_mfd_ct            := le.addr_risk_summary2.N_MFD_Count;
	add_curr_pop                     := le.addrPop2;
	max_lres                         := le.other_address_info.max_lres;
	addrs_5yr                        := le.other_address_info.addrs_last_5years;
	addrs_10yr                       := le.other_address_info.addrs_last_10years;
	addrs_15yr                       := le.other_address_info.addrs_last_15years;
	addrs_prison_history             := le.other_address_info.isprison;
	header_first_seen                := le.ssn_verification.header_first_seen;
	ssns_per_adl                     := le.velocity_counters.ssns_per_adl;
	addrs_per_ssn                    := if(isFCRA, 0, le.velocity_counters.addrs_per_ssn );
	adls_per_addr_curr               := le.velocity_counters.adls_per_addr_current;
	phones_per_addr_curr             := le.velocity_counters.phones_per_addr_current;
	ssns_per_adl_c6                  := le.velocity_counters.ssns_per_adl_created_6months;
	addrs_per_adl_c6                 := le.velocity_counters.addrs_per_adl_created_6months;
	lnames_per_adl_c6                := if(isFCRA, 0, le.velocity_counters.lnames_per_adl180);
	adls_per_addr_c6                 := le.velocity_counters.adls_per_addr_created_6months;
	phones_per_addr_c6               := if(isFCRA, 0, le.velocity_counters.phones_per_addr_created_6months );
	dl_addrs_per_adl                 := le.velocity_counters.dl_addrs_per_adl;
	invalid_ssns_per_adl             := le.velocity_counters.invalid_ssns_per_adl;
	invalid_addrs_per_adl            := le.velocity_counters.invalid_addrs_per_adl;
	inq_count                        := le.acc_logs.inquiries.counttotal;
	inq_count01                      := le.acc_logs.inquiries.count01;
	inq_count03                      := le.acc_logs.inquiries.count03;
	inq_count06                      := le.acc_logs.inquiries.count06;
	inq_count12                      := le.acc_logs.inquiries.count12;
	inq_count24                      := le.acc_logs.inquiries.count24;
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
	inq_collection_count             := le.acc_logs.collection.counttotal;
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
	inq_highriskcredit_count01       := le.acc_logs.highriskcredit.count01;
	inq_highriskcredit_count03       := le.acc_logs.highriskcredit.count03;
	inq_highriskcredit_count06       := le.acc_logs.highriskcredit.count06;
	inq_highriskcredit_count12       := le.acc_logs.highriskcredit.count12;
	inq_highriskcredit_count24       := le.acc_logs.highriskcredit.count24;
	inq_mortgage_count03             := le.acc_logs.mortgage.count03;
	inq_other_count24                := le.acc_logs.other.count24;
	inq_prepaidcards_count           := le.acc_logs.prepaidcards.counttotal;
	inq_prepaidcards_count01         := le.acc_logs.prepaidcards.count01;
	inq_prepaidcards_count03         := le.acc_logs.prepaidcards.count03;
	inq_prepaidcards_count06         := le.acc_logs.prepaidcards.count06;
	inq_prepaidcards_count12         := le.acc_logs.prepaidcards.count12;
	inq_prepaidcards_count24         := le.acc_logs.prepaidcards.count24;
	inq_retail_count03               := le.acc_logs.retail.count03;
	inq_retailpayments_count         := le.acc_logs.retailpayments.counttotal;
	inq_retailpayments_count01       := le.acc_logs.retailpayments.count01;
	inq_retailpayments_count03       := le.acc_logs.retailpayments.count03;
	inq_retailpayments_count06       := le.acc_logs.retailpayments.count06;
	inq_retailpayments_count12       := le.acc_logs.retailpayments.count12;
	inq_retailpayments_count24       := le.acc_logs.retailpayments.count24;
	inq_utilities_count              := le.acc_logs.utilities.counttotal;
	inq_utilities_count01            := le.acc_logs.utilities.count01;
	inq_utilities_count03            := le.acc_logs.utilities.count03;
	inq_utilities_count06            := le.acc_logs.utilities.count06;
	inq_utilities_count12            := le.acc_logs.utilities.count12;
	inq_utilities_count24            := le.acc_logs.utilities.count24;
	inq_peraddr                      := if(isFCRA, 0, le.acc_logs.inquiryPerAddr );
	inq_adlsperaddr                  := if(isFCRA, 0, le.acc_logs.inquiryADLsPerAddr );
	inq_lnamesperaddr                := if(isFCRA, 0, le.acc_logs.inquiryLNamesPerAddr );
	inq_ssnsperaddr                  := if(isFCRA, 0, le.acc_logs.inquirySSNsPerAddr );
	br_source_count                  := le.employment.source_ct;
	stl_inq_count                    := le.impulse.count;
	email_count                      := le.email_summary.email_ct;
	email_domain_free_count          := le.email_summary.email_domain_free_ct;
	email_domain_isp_count           := le.email_summary.email_domain_isp_ct;
	attr_total_number_derogs         := le.total_number_derogs;
	attr_arrests                     := le.bjl.arrests_count;
	attr_arrests30                   := le.bjl.arrests_count30;
	attr_arrests90                   := le.bjl.arrests_count90;
	attr_arrests180                  := le.bjl.arrests_count180;
	attr_arrests12                   := le.bjl.arrests_count12;
	attr_arrests24                   := le.bjl.arrests_count24;
	attr_arrests36                   := le.bjl.arrests_count36;
	attr_arrests60                   := le.bjl.arrests_count60;
	attr_num_unrel_liens60           := le.bjl.liens_unreleased_count60;
	attr_eviction_count              := le.bjl.eviction_count;
	attr_eviction_count90            := le.bjl.eviction_count90;
	attr_eviction_count180           := le.bjl.eviction_count180;
	attr_eviction_count12            := le.bjl.eviction_count12;
	attr_eviction_count24            := le.bjl.eviction_count24;
	attr_eviction_count36            := le.bjl.eviction_count36;
	attr_eviction_count60            := le.bjl.eviction_count60;
	fp_idverrisktype                 := le.fdattributesv2.idverrisklevel;
	fp_sourcerisktype                := le.fdattributesv2.sourcerisklevel;
	fp_varrisktype                   := le.fdattributesv2.variationrisklevel;
	fp_vardobcount                   := le.fdattributesv2.variationdobcount;
	fp_vardobcountnew                := le.fdattributesv2.variationdobcountnew;
	fp_srchvelocityrisktype          := le.fdattributesv2.searchvelocityrisklevel;
	fp_srchcountwk                   := le.fdattributesv2.searchcountweek;
	fp_srchunvrfdssncount            := le.fdattributesv2.searchunverifiedssncountyear;
	fp_srchunvrfdaddrcount           := le.fdattributesv2.searchunverifiedaddrcountyear;
	fp_srchfraudsrchcountyr          := le.fdattributesv2.searchfraudsearchcountyear;
	fp_srchfraudsrchcountwk          := le.fdattributesv2.searchfraudsearchcountweek;
	fp_srchlocatesrchcountwk         := le.fdattributesv2.searchlocatesearchcountweek;
	fp_assocrisktype                 := le.fdattributesv2.assocrisklevel;
	fp_assocsuspicousidcount         := le.fdattributesv2.assocsuspicousidentitiescount;
	fp_assoccredbureaucount          := le.fdattributesv2.assoccreditbureauonlycount;
	fp_divrisktype                   := le.fdattributesv2.divrisklevel;
	fp_divaddrsuspidcountnew         := le.fdattributesv2.divaddrsuspidentitycountnew;
	fp_srchcomponentrisktype         := le.fdattributesv2.searchcomponentrisklevel;
	fp_srchssnsrchcountmo            := le.fdattributesv2.searchssnsearchcountmonth;
	fp_srchaddrsrchcountmo           := le.fdattributesv2.searchaddrsearchcountmonth;
	fp_srchaddrsrchcountwk           := le.fdattributesv2.searchaddrsearchcountweek;
	fp_srchphonesrchcountmo          := le.fdattributesv2.searchphonesearchcountmonth;
	fp_inputaddractivephonelist      := le.fdattributesv2.inputaddractivephonelist;
	fp_addrchangeincomediff          := le.fdattributesv2.addrchangeincomediff;
	fp_addrchangevaluediff           := le.fdattributesv2.addrchangevaluediff;
	fp_addrchangecrimediff           := le.fdattributesv2.addrchangecrimediff;
	fp_addrchangeecontrajindex       := le.fdattributesv2.addrchangeecontrajectoryindex;
	fp_curraddractivephonelist       := le.fdattributesv2.curraddractivephonelist;
	fp_curraddrmedianincome          := le.fdattributesv2.curraddrmedianincome;
	fp_curraddrmedianvalue           := le.fdattributesv2.curraddrmedianvalue;
	fp_curraddrmurderindex           := le.fdattributesv2.curraddrmurderindex;
	fp_curraddrcartheftindex         := le.fdattributesv2.curraddrcartheftindex;
	fp_curraddrburglaryindex         := le.fdattributesv2.curraddrburglaryindex;
	fp_curraddrcrimeindex            := le.fdattributesv2.curraddrcrimeindex;
	fp_prevaddrlenofres              := le.fdattributesv2.prevaddrlenofres;
	fp_prevaddrmedianincome          := le.fdattributesv2.prevaddrmedianincome;
	fp_prevaddrmedianvalue           := le.fdattributesv2.prevaddrmedianvalue;
	fp_prevaddrmurderindex           := le.fdattributesv2.prevaddrmurderindex;
	fp_prevaddrcartheftindex         := le.fdattributesv2.prevaddrcartheftindex;
	fp_prevaddrburglaryindex         := le.fdattributesv2.prevaddrburglaryindex;
	fp_prevaddrcrimeindex            := le.fdattributesv2.prevaddrcrimeindex;
	filing_count                     := le.bjl.filing_count;
	liens_recent_unreleased_count    := le.bjl.liens_recent_unreleased_count;
	// liens_recent_unreleased_count    := le.iid.did2_liens_recent_unreleased_count;
	liens_historical_unreleased_ct   := le.bjl.liens_historical_unreleased_count;
	//liens_historical_unreleased_ct   := le.iid.did2_liens_historical_unreleased_count;
	liens_unrel_cj_last_seen         := le.liens.liens_unreleased_civil_judgment.most_recent_filing_date;
	liens_unrel_cj_total_amount      := le.liens.liens_unreleased_civil_judgment.total_amount;
	liens_rel_cj_first_seen          := le.liens.liens_released_civil_judgment.earliest_filing_date;
	liens_rel_cj_last_seen           := le.liens.liens_released_civil_judgment.most_recent_filing_date;
	liens_rel_cj_total_amount        := le.liens.liens_released_civil_judgment.total_amount;
	liens_unrel_ft_total_amount      := le.liens.liens_unreleased_federal_tax.total_amount;
	liens_unrel_o_total_amount       := le.liens.liens_unreleased_other_lj.total_amount;
	liens_rel_o_last_seen            := le.liens.liens_released_other_lj.most_recent_filing_date;
	liens_unrel_ot_first_seen        := le.liens.liens_unreleased_other_tax.earliest_filing_date;
	liens_unrel_ot_total_amount      := le.liens.liens_unreleased_other_tax.total_amount;
	liens_unrel_sc_first_seen        := le.liens.liens_unreleased_small_claims.earliest_filing_date;
	liens_unrel_sc_total_amount      := le.liens.liens_unreleased_small_claims.total_amount;
	liens_unrel_st_ct                := le.liens.liens_unreleased_suits.count;
	liens_unrel_st_last_seen         := le.liens.liens_unreleased_suits.most_recent_filing_date;
	liens_unrel_st_total_amount      := le.liens.liens_unreleased_suits.total_amount;
	criminal_count                   := le.bjl.criminal_count;
	criminal_last_date               := le.bjl.last_criminal_date;
	felony_count                     := le.bjl.felony_count;
	felony_last_date                 := le.bjl.last_felony_date;
	foreclosure_last_date            := le.bjl.last_foreclosure_date;
	hh_members_ct                    := le.hhid_summary.hh_members_ct;
	hh_age_65_plus                   := le.hhid_summary.hh_age_65_plus;
	hh_age_30_to_65                  := le.hhid_summary.hh_age_31_to_65;
	hh_age_18_to_30                  := le.hhid_summary.hh_age_18_to_30;
	hh_workers_paw                   := le.hhid_summary.hh_workers_paw;
	hh_payday_loan_users             := le.hhid_summary.hh_payday_loan_users;
	hh_members_w_derog               := le.hhid_summary.hh_members_w_derog;
	hh_bankruptcies                  := le.hhid_summary.hh_bankruptcies;
	hh_prof_license_holders          := le.hhid_summary.hh_prof_license_holders;
	hh_criminals                     := le.hhid_summary.hh_criminals;
	hh_college_attendees             := le.hhid_summary.hh_college_attendees;
	rel_count                        := le.relatives.relative_count;
	rel_felony_count                 := le.relatives.relative_felony_count;
	crim_rel_within25miles           := le.relatives.criminal_relative_within25miles;
	crim_rel_within100miles          := le.relatives.criminal_relative_within100miles;
	crim_rel_within500miles          := le.relatives.criminal_relative_within500miles;
	rel_within25miles_count          := le.relatives.relative_within25miles_count;
	rel_within100miles_count         := le.relatives.relative_within100miles_count;
	rel_within500miles_count         := le.relatives.relative_within500miles_count;
	rel_incomeunder50_count          := le.relatives.relative_incomeunder50_count;
	rel_incomeunder75_count          := le.relatives.relative_incomeunder75_count;
	rel_incomeunder100_count         := le.relatives.relative_incomeunder100_count;
	rel_incomeover100_count          := le.relatives.relative_incomeover100_count;
	rel_homeunder100_count           := le.relatives.relative_homeunder100_count;
	rel_homeunder150_count           := le.relatives.relative_homeunder150_count;
	rel_homeunder200_count           := le.relatives.relative_homeunder200_count;
	rel_homeunder300_count           := le.relatives.relative_homeunder300_count;
	rel_homeunder500_count           := le.relatives.relative_homeunder500_count;
	rel_homeover500_count            := le.relatives.relative_homeover500_count;
	rel_educationunder12_count       := le.relatives.relative_educationunder12_count;
	rel_educationover12_count        := le.relatives.relative_educationover12_count;
	rel_ageunder30_count             := le.relatives.relative_ageunder30_count;
	rel_ageunder40_count             := le.relatives.relative_ageunder40_count;
	rel_ageunder50_count             := le.relatives.relative_ageunder50_count;
	rel_ageunder60_count             := le.relatives.relative_ageunder60_count;
	rel_ageunder70_count             := le.relatives.relative_ageunder70_count;
	rel_ageover70_count              := le.relatives.relative_ageover70_count;
	current_count                    := le.vehicles.current_count;
	historical_count                 := le.vehicles.historical_count;
	acc_last_seen                    := le.accident_data.acc.datelastaccident;
	wealth_index                     := le.wealth_indicator;
	inferred_age                     := le.inferred_age;
	addr_stability_v2                := le.addr_stability;
	estimated_income                 := le.estimated_income;



	/* ***********************************************************
	 *   Generated ECL         *
	 ************************************************************* */

NULL := -999999999;


INTEGER contains_i( string haystack, string needle ) := (INTEGER)(StringLib.StringFind(haystack, needle, 1) > 0);

sysdate := common.sas_date(if(le.historydate=999999, (string8)Std.Date.Today(), (string6)le.historydate+'01'));

_acc_last_seen := common.sas_date((string)(acc_last_seen));

f_mos_acc_lseen_d := map(
    not(truedid)          => NULL,
    _acc_last_seen = NULL => 1000,
                             max(3, min(if(if ((sysdate - _acc_last_seen) / (365.25 / 12) >= 0, truncate((sysdate - _acc_last_seen) / (365.25 / 12)), roundup((sysdate - _acc_last_seen) / (365.25 / 12))) = NULL, -NULL, if ((sysdate - _acc_last_seen) / (365.25 / 12) >= 0, truncate((sysdate - _acc_last_seen) / (365.25 / 12)), roundup((sysdate - _acc_last_seen) / (365.25 / 12)))), 999)));

f_curraddractivephonelist_d := map(
    not(add_curr_pop)                 => NULL,
    fp_curraddractivephonelist = '-1' => NULL,
                                         (integer)fp_curraddractivephonelist);

f_inputaddractivephonelist_d := map(
    not(truedid)                       => NULL,
    fp_inputaddractivephonelist = '-1' => NULL,
                                          (integer)fp_inputaddractivephonelist);

r_f03_address_match_d := map(
    not(truedid)                                => NULL,
    add_input_isbestmatch                       => 4,
    not(add_input_pop) and add_curr_isbestmatch => 3,
    add_input_pop and add_curr_isbestmatch      => 2,
    add_curr_pop                                => 1,
    add_input_pop                               => 0,
                                                   NULL);

r_l72_add_curr_vacant_i := map(
    not(add_curr_pop)                                          => NULL,
    trim(trim(add_curr_advo_vacancy, LEFT), LEFT, RIGHT) = 'Y' => 1,
                                                                  0);

r_l72_add_vacant_i := map(
    not(add_input_pop)                                          => NULL,
    trim(trim(add_input_advo_vacancy, LEFT), LEFT, RIGHT) = 'Y' => 1,
                                                                   0);

r_l75_add_curr_drop_delivery_i := map(
    not(add_curr_pop)                                       => NULL,
    trim(trim(add_curr_advo_drop, LEFT), LEFT, RIGHT) = 'Y' => 1,
                                                               0);

r_l75_add_drop_delivery_i := map(
    not(add_input_pop)                                       => NULL,
    trim(trim(add_input_advo_drop, LEFT), LEFT, RIGHT) = 'Y' => 1,
                                                                0);

r_c23_inp_addr_occ_index_d := if(not(add_input_pop and truedid), NULL, add_input_occ_index);

r_f04_curr_add_occ_index_d := if(not(truedid and add_curr_pop), NULL, add_curr_occ_index);

r_c14_addr_stability_v2_d := map(
    not(truedid)            => NULL,
    addr_stability_v2 = '0' => NULL,
                               (integer)addr_stability_v2);

r_c14_addrs_10yr_i := if(not(truedid), NULL, min(if(addrs_10yr = NULL, -NULL, addrs_10yr), 999));

r_c14_addrs_15yr_i := if(not(truedid), NULL, min(if(addrs_15yr = NULL, -NULL, addrs_15yr), 999));

r_c14_addrs_5yr_i := if(not(truedid), NULL, min(if(addrs_5yr = NULL, -NULL, addrs_5yr), 999));

r_c14_addrs_per_adl_c6_i := if(not(truedid), NULL, min(if(addrs_per_adl_c6 = NULL, -NULL, addrs_per_adl_c6), 999));

add_ec1 := (StringLib.StringToUpperCase(trim(out_addr_status, LEFT)))[1..1];

add_ec3 := (StringLib.StringToUpperCase(trim(out_addr_status, LEFT)))[3..3];

add_ec4 := (StringLib.StringToUpperCase(trim(out_addr_status, LEFT)))[4..4];

r_l70_add_standardized_i := map(
    not(addrpop)                                         => NULL,
    trim(trim(add_ec1, LEFT), LEFT, RIGHT) = 'E'         => 2,
    add_ec1 = 'S' and (add_ec3 != '0' or add_ec4 != '0') => 1,
                                                            0);

_in_dob := common.sas_date((string)(in_dob));

yr_in_dob := if(_in_dob = NULL, NULL, (sysdate - _in_dob) / 365.25);

yr_in_dob_int := if (yr_in_dob >= 0, roundup(yr_in_dob), truncate(yr_in_dob));

k_comb_age_d := map(
    yr_in_dob_int > 0            => yr_in_dob_int,
    inferred_age > 0 and truedid => inferred_age,
                                    NULL);

r_d31_bk_filing_count_i := if(not(truedid), NULL, min(if(filing_count = NULL, -NULL, filing_count), 999));

f_attr_arrest_recency_d := map(
    not(truedid)        => NULL,
    attr_arrests30 > 0  => 1,
    attr_arrests90 > 0  => 3,
    attr_arrests180 > 0 => 6,
    attr_arrests12 > 0  => 12,
    attr_arrests24 > 0  => 24,
    attr_arrests36 > 0  => 36,
    attr_arrests60 > 0  => 60,
    attr_arrests > 0    => 99,
                           100);

f_attr_arrests_i := if(not(truedid), NULL, min(if(attr_arrests = NULL, -NULL, attr_arrests), 999));

r_c19_add_prison_hist_i := if(not(truedid), NULL, (integer)addrs_prison_history);

r_d32_criminal_count_i := if(not(truedid), NULL, min(if(criminal_count = NULL, -NULL, criminal_count), 999));

r_d32_felony_count_i := if(not(truedid), NULL, min(if(felony_count = NULL, -NULL, felony_count), 999));

_criminal_last_date := common.sas_date((string)(criminal_last_date));

r_d32_mos_since_crim_ls_d := map(
    not(truedid)               => NULL,
    _criminal_last_date = NULL => 241,
                                  max(3, min(if(if ((sysdate - _criminal_last_date) / (365.25 / 12) >= 0, truncate((sysdate - _criminal_last_date) / (365.25 / 12)), roundup((sysdate - _criminal_last_date) / (365.25 / 12))) = NULL, -NULL, if ((sysdate - _criminal_last_date) / (365.25 / 12) >= 0, truncate((sysdate - _criminal_last_date) / (365.25 / 12)), roundup((sysdate - _criminal_last_date) / (365.25 / 12)))), 240)));

_felony_last_date := common.sas_date((string)(felony_last_date));

r_d32_mos_since_fel_ls_d := map(
    not(truedid)             => NULL,
    _felony_last_date = NULL => 241,
                                max(3, min(if(if ((sysdate - _felony_last_date) / (365.25 / 12) >= 0, truncate((sysdate - _felony_last_date) / (365.25 / 12)), roundup((sysdate - _felony_last_date) / (365.25 / 12))) = NULL, -NULL, if ((sysdate - _felony_last_date) / (365.25 / 12) >= 0, truncate((sysdate - _felony_last_date) / (365.25 / 12)), roundup((sysdate - _felony_last_date) / (365.25 / 12)))), 240)));

r_d30_derog_count_i := if(not(truedid), NULL, min(if(attr_total_number_derogs = NULL, -NULL, attr_total_number_derogs), 999));

f_vardobcount_i := if(not(truedid), NULL, min(if(fp_vardobcount = '', -NULL, (integer)fp_vardobcount), 999));

f_vardobcountnew_i := if(not(truedid), NULL, min(if(fp_vardobcountnew = '', -NULL, (integer)fp_vardobcountnew), 999));

f_addrchangeecontrajindex_d := if(not(truedid) or fp_addrchangeecontrajindex = '' or fp_addrchangeecontrajindex = '-1', NULL, (integer)fp_addrchangeecontrajindex);

r_c20_email_count_i := if(not(truedid), NULL, min(if(email_count = NULL, -NULL, email_count), 999));

r_c20_email_domain_free_count_i := if(not(truedid), NULL, min(if(email_domain_free_count = NULL, -NULL, email_domain_free_count), 999));

r_c20_email_domain_isp_count_i := if(not(truedid), NULL, min(if(email_domain_ISP_count = NULL, -NULL, email_domain_ISP_count), 999));

k_estimated_income_d := if(not(truedid), NULL, estimated_income);

r_d33_eviction_count_i := if(not(truedid), NULL, min(if(attr_eviction_count = NULL, -NULL, attr_eviction_count), 999));

r_d33_eviction_recency_d := map(
    not(truedid)                 => NULL,
    attr_eviction_count90 > 0    => 3,
    attr_eviction_count180 > 0   => 6,
    attr_eviction_count12 > 0    => 12,
    attr_eviction_count24 > 0    => 24,
    attr_eviction_count36 > 0    => 36,
    attr_eviction_count60 > 0    => 60,
    attr_eviction_count >= 1     => 99,
                                    999);

_foreclosure_last_date := common.sas_date((string)(foreclosure_last_date));

f_mos_foreclosure_lseen_d := map(
    not(truedid)                  => NULL,
    _foreclosure_last_date = NULL => 1000,
                                     max(3, min(if(if ((sysdate - _foreclosure_last_date) / (365.25 / 12) >= 0, truncate((sysdate - _foreclosure_last_date) / (365.25 / 12)), roundup((sysdate - _foreclosure_last_date) / (365.25 / 12))) = NULL, -NULL, if ((sysdate - _foreclosure_last_date) / (365.25 / 12) >= 0, truncate((sysdate - _foreclosure_last_date) / (365.25 / 12)), roundup((sysdate - _foreclosure_last_date) / (365.25 / 12)))), 999)));

f_idverrisktype_i := if(not(truedid) or fp_idverrisktype = '', NULL, (integer)fp_idverrisktype);

_ver_src_ds := Models.Common.findw_cpp(ver_sources, 'DS' , ',', '') > 0;

_ver_src_de := Models.Common.findw_cpp(ver_sources, 'DE' , ',', '') > 0;

_ver_src_eq := Models.Common.findw_cpp(ver_sources, 'EQ' , ',', '') > 0;

_ver_src_en := Models.Common.findw_cpp(ver_sources, 'EN' , ',', '') > 0;

_ver_src_tn := Models.Common.findw_cpp(ver_sources, 'TN' , ',', '') > 0;

_ver_src_tu := Models.Common.findw_cpp(ver_sources, 'TU' , ',', '') > 0;

_credit_source_cnt := if(max((integer)_ver_src_eq, (integer)_ver_src_en, (integer)_ver_src_tn, (integer)_ver_src_tu) = NULL, NULL, sum((integer)_ver_src_eq, (integer)_ver_src_en, (integer)_ver_src_tn, (integer)_ver_src_tu));

_ver_src_cnt := Models.Common.countw((string)(ver_sources));

_bureauonly := _credit_source_cnt > 0 AND _credit_source_cnt = _ver_src_cnt AND (StringLib.StringToUpperCase(nap_type) = 'U' or (nap_summary in [0, 1, 2, 3, 4, 6]));

_derog := felony_count > 0 OR (integer)addrs_prison_history > 0 OR attr_num_unrel_liens60 > 0 OR attr_eviction_count > 0 OR stl_inq_count > 0 OR inq_highriskcredit_count12 > 0 OR inq_collection_count12 >= 2;

_deceased := rc_decsflag = '1' OR rc_ssndod != 0 OR _ver_src_ds OR _ver_src_de;

_ssnpriortodob := rc_ssndobflag = '1' OR rc_pwssndobflag = '1';

_inputmiskeys := rc_ssnmiskeyflag or rc_addrmiskeyflag or not add_input_house_number_match;

_multiplessns := ssns_per_adl >= 2 OR ssns_per_adl_c6 >= 1 OR invalid_ssns_per_adl >= 1;

//_hh_strikes := if(max(hh_members_w_derog > 0, hh_criminals > 0, hh_payday_loan_users > 0) = NULL, NULL, sum(hh_members_w_derog > 0, hh_criminals > 0, hh_payday_loan_users > 0));
// _hh_strikes := if(not(hh_members_w_derog > 0 and hh_criminals > 0 and hh_payday_loan_users > 0), NULL,
                 // if(hh_members_w_derog > 0, 1, 0) + 
                 // if(hh_criminals > 0, 1, 0) +
                 // if(hh_payday_loan_users > 0, 1, 0)
							   // );
_hh_strikes :=  if((Real)max((integer)hh_members_w_derog > 0, (integer)hh_criminals > 0, (integer)hh_payday_loan_users > 0) = NULL, NULL, (Real)sum((integer)hh_members_w_derog > 0, (integer)hh_criminals > 0, (integer)hh_payday_loan_users > 0));


nf_seg_fraudpoint_3_0 := map(
    addrpop and (nas_summary in [4, 7, 9]) or (fnamepop and lnamepop and addrpop and 1 <= nas_summary AND nas_summary <= 9 and inq_count03 > 0 and ssnlength = '9') or _deceased or _ssnpriortodob => '1: Stolen/Manip ID  ',
    _inputmiskeys and (_multiplessns or lnames_per_adl_c6 > 1)                                                                                                                                 => '1: Stolen/Manip ID  ',
    fnamepop and lnamepop and addrpop and ssnlength = '9' and hphnpop and nap_summary <= 4 and nas_summary <= 4 or _ver_src_cnt = 0 or _bureauonly or not add_curr_pop                           => '2: Synth ID         ',
    _derog                                                                                                                                                                                     => '3: Derog            ',
    Inq_count03 > 0 or Inq_count12 >= 4 or (integer)fp_srchfraudsrchcountyr >= 1 or (integer)fp_srchssnsrchcountmo >= 1 or (integer)fp_srchaddrsrchcountmo >= 1 or (integer)fp_srchphonesrchcountmo >= 1                           => '4: Recent Activity  ',
    0 < inferred_age AND inferred_age <= 17 or inferred_age >= 70                                                                                                                              => '5: Vuln Vic/Friendly',
    hh_members_ct > 1 and (hh_payday_loan_users > 0 or _hh_strikes >= 2 or rel_felony_count >= 2)                                                                                              => '5: Vuln Vic/Friendly',
                                                                                                                                                                                                  '6: Other            ');

f_varrisktype_i := map(
    not(truedid)          => NULL,
    fp_varrisktype = ''   => NULL,
                             (integer)fp_varrisktype);

f_hh_age_18_plus_d := if(not(truedid), NULL, min(if(if(max(hh_age_65_plus, hh_age_30_to_65, hh_age_18_to_30) = NULL, NULL, sum(if(hh_age_65_plus = NULL, 0, hh_age_65_plus), if(hh_age_30_to_65 = NULL, 0, hh_age_30_to_65), if(hh_age_18_to_30 = NULL, 0, hh_age_18_to_30))) = NULL, -NULL, if(max(hh_age_65_plus, hh_age_30_to_65, hh_age_18_to_30) = NULL, NULL, sum(if(hh_age_65_plus = NULL, 0, hh_age_65_plus), if(hh_age_30_to_65 = NULL, 0, hh_age_30_to_65), if(hh_age_18_to_30 = NULL, 0, hh_age_18_to_30)))), 999));

f_hh_age_65_plus_d := if(not(truedid), NULL, min(if(hh_age_65_plus = NULL, -NULL, hh_age_65_plus), 999));

f_hh_age_30_plus_d := if(not(truedid), NULL, min(if(if(max(hh_age_65_plus, hh_age_30_to_65) = NULL, NULL, sum(if(hh_age_65_plus = NULL, 0, hh_age_65_plus), if(hh_age_30_to_65 = NULL, 0, hh_age_30_to_65))) = NULL, -NULL, if(max(hh_age_65_plus, hh_age_30_to_65) = NULL, NULL, sum(if(hh_age_65_plus = NULL, 0, hh_age_65_plus), if(hh_age_30_to_65 = NULL, 0, hh_age_30_to_65)))), 999));

f_hh_bankruptcies_i := if(not(truedid), NULL, min(if(hh_bankruptcies = NULL, -NULL, hh_bankruptcies), 999));

f_hh_college_attendees_d := if(not(truedid), NULL, min(if(hh_college_attendees = NULL, -NULL, hh_college_attendees), 999));

f_hh_members_ct_d := if(not(truedid), NULL, min(if(hh_members_ct = NULL, -NULL, hh_members_ct), 999));

f_hh_members_w_derog_i := if(not(truedid), NULL, min(if(hh_members_w_derog = NULL, -NULL, hh_members_w_derog), 999));

f_hh_payday_loan_users_i := if(not(truedid), NULL, min(if(hh_payday_loan_users = NULL, -NULL, hh_payday_loan_users), 999));

f_hh_prof_license_holders_d := if(not(truedid), NULL, min(if(hh_prof_license_holders = NULL, -NULL, hh_prof_license_holders), 999));

f_hh_workers_paw_d := if(not(truedid), NULL, min(if(hh_workers_paw = NULL, -NULL, hh_workers_paw), 999));

f_adl_util_conv_n := if(contains_i(util_adl_type_list, '2') > 0, 1, 0);

f_util_add_curr_conv_n := if(contains_i(util_add_curr_type_list, '2') > 0, 1, 0);

f_util_add_curr_inf_n := if(contains_i(util_add_curr_type_list, '1') > 0, 1, 0);

f_util_add_input_conv_n := if(contains_i(util_add_input_type_list, '2') > 0, 1, 0);

f_util_add_input_inf_n := if(contains_i(util_add_input_type_list, '1') > 0, 1, 0);

f_util_adl_count_n := if(not(truedid), NULL, util_adl_count);

f_bus_name_nover_i := if(not(addrpop), NULL, (integer)(bus_name_match = 1));

r_e57_br_source_count_d := if(not(truedid), NULL, br_source_count);

r_l71_add_business_i := map(
    not(add_input_pop)                                                       => NULL,
    (trim(trim(add_input_advo_res_or_bus, LEFT), LEFT, RIGHT) in ['B', 'D']) => 1,
                                                                                0);

f_addrs_per_ssn_i := if(not((integer)ssnlength > 0), NULL, min(if(addrs_per_ssn = NULL, -NULL, addrs_per_ssn), 999));

f_srchaddrsrchcountmo_i := if(not(truedid), NULL, min(if(fp_srchaddrsrchcountmo = '', -NULL, (integer)fp_srchaddrsrchcountmo), 999));

f_srchaddrsrchcountwk_i := if(not(truedid), NULL, min(if(fp_srchaddrsrchcountwk = '', -NULL, (integer)fp_srchaddrsrchcountwk), 999));

f_srchcomponentrisktype_i := map(
    not(truedid)                    => NULL,
    fp_srchcomponentrisktype = '' => NULL,
                                       (integer)fp_srchcomponentrisktype);

f_srchcountwk_i := if(not(truedid), NULL, min(if(fp_srchcountwk = '', -NULL, (integer)fp_srchcountwk), 999));

f_srchfraudsrchcountwk_i := if(not(truedid), NULL, min(if(fp_srchfraudsrchcountwk = '', -NULL, (integer)fp_srchfraudsrchcountwk), 999));

f_srchfraudsrchcountyr_i := if(not(truedid), NULL, min(if(fp_srchfraudsrchcountyr = '', -NULL, (integer)fp_srchfraudsrchcountyr), 999));

f_srchlocatesrchcountwk_i := if(not(truedid), NULL, min(if(fp_srchlocatesrchcountwk = '', -NULL, (integer)fp_srchlocatesrchcountwk), 999));

f_srchunvrfdaddrcount_i := if(not(truedid), NULL, min(if(fp_srchunvrfdaddrcount = '', -NULL, (integer)fp_srchunvrfdaddrcount), 999));

f_srchunvrfdssncount_i := if(not(truedid), NULL, min(if(fp_srchunvrfdssncount = '', -NULL, (integer)fp_srchunvrfdssncount), 999));

f_srchvelocityrisktype_i := map(
    not(truedid)                   => NULL,
    fp_srchvelocityrisktype = ''   => NULL,
                                      (integer)fp_srchvelocityrisktype);

k_inq_adls_per_addr_i := if(not(addrpop), NULL, min(if(inq_adlsperaddr = NULL, -NULL, inq_adlsperaddr), 999));

k_inq_lnames_per_addr_i := if(not(addrpop), NULL, min(if(inq_lnamesperaddr = NULL, -NULL, inq_lnamesperaddr), 999));

k_inq_per_addr_i := if(not(addrpop), NULL, min(if(inq_peraddr = NULL, -NULL, inq_peraddr), 999));

k_inq_ssns_per_addr_i := if(not(addrpop), NULL, min(if(inq_ssnsperaddr = NULL, -NULL, inq_ssnsperaddr), 999));

r_l79_adls_per_addr_c6_i := if(not(addrpop), NULL, min(if(adls_per_addr_c6 = NULL, -NULL, adls_per_addr_c6), 999));

r_l79_adls_per_addr_curr_i := if(not(add_curr_pop), NULL, min(if(adls_per_addr_curr = NULL, -NULL, adls_per_addr_curr), 999));

f_inq_collection_count24_i := if(not(truedid), NULL, min(if(inq_Collection_count24 = NULL, -NULL, inq_Collection_count24), 999));

f_inq_communications_cnt_week_i := if(not(truedid), NULL, min(if(inq_Communications_count_week = NULL, -NULL, inq_Communications_count_week), 999));

f_inq_communications_count24_i := if(not(truedid), NULL, min(if(inq_Communications_count24 = NULL, -NULL, inq_Communications_count24), 999));

f_inq_count24_i := if(not(truedid), NULL, min(if(inq_count24 = NULL, -NULL, inq_count24), 999));

f_inq_highriskcredit_count24_i := if(not(truedid), NULL, min(if(inq_HighRiskCredit_count24 = NULL, -NULL, inq_HighRiskCredit_count24), 999));

f_inq_other_count24_i := if(not(truedid), NULL, min(if(inq_Other_count24 = NULL, -NULL, inq_Other_count24), 999));

r_i60_credit_seeking_i := if(not(truedid), NULL, if(max(min(2, if(inq_auto_count03 = NULL, -NULL, inq_auto_count03)), min(2, if(inq_banking_count03 = NULL, -NULL, inq_banking_count03)), min(2, if(inq_mortgage_count03 = NULL, -NULL, inq_mortgage_count03)), min(2, if(inq_retail_count03 = NULL, -NULL, inq_retail_count03)), min(2, if(inq_communications_count03 = NULL, -NULL, inq_communications_count03))) = NULL, NULL, sum(if(min(2, if(inq_auto_count03 = NULL, -NULL, inq_auto_count03)) = NULL, 0, min(2, if(inq_auto_count03 = NULL, -NULL, inq_auto_count03))), if(min(2, if(inq_banking_count03 = NULL, -NULL, inq_banking_count03)) = NULL, 0, min(2, if(inq_banking_count03 = NULL, -NULL, inq_banking_count03))), if(min(2, if(inq_mortgage_count03 = NULL, -NULL, inq_mortgage_count03)) = NULL, 0, min(2, if(inq_mortgage_count03 = NULL, -NULL, inq_mortgage_count03))), if(min(2, if(inq_retail_count03 = NULL, -NULL, inq_retail_count03)) = NULL, 0, min(2, if(inq_retail_count03 = NULL, -NULL, inq_retail_count03))), if(min(2, if(inq_communications_count03 = NULL, -NULL, inq_communications_count03)) = NULL, 0, min(2, if(inq_communications_count03 = NULL, -NULL, inq_communications_count03))))));

r_i60_inq_auto_count12_i := if(not(truedid), NULL, min(if(inq_auto_count12 = NULL, -NULL, inq_auto_count12), 999));

r_i60_inq_auto_recency_d := map(
    not(truedid)     => NULL,
    inq_auto_count01 > 0 => 1,
    inq_auto_count03 > 0 => 3,
    inq_auto_count06 > 0 => 6,
    inq_auto_count12 > 0 => 12,
    inq_auto_count24 > 0 => 24,
    inq_auto_count   > 0 => 99,
                        999);

r_i60_inq_banking_count12_i := if(not(truedid), NULL, min(if(inq_banking_count12 = NULL, -NULL, inq_banking_count12), 999));

r_i60_inq_banking_recency_d := map(
    not(truedid)        => NULL,
    inq_banking_count01 > 0 => 1,
    inq_banking_count03 > 0 => 3,
    inq_banking_count06 > 0 => 6,
    inq_banking_count12 > 0 => 12,
    inq_banking_count24 > 0 => 24,
    inq_banking_count   > 0 => 99,
                           999);

r_i60_inq_comm_count12_i := if(not(truedid), NULL, min(if(inq_communications_count12 = NULL, -NULL, inq_communications_count12), 999));

r_i60_inq_comm_recency_d := map(
    not(truedid)               => NULL,
    inq_communications_count01 > 0 => 1,
    inq_communications_count03 > 0 => 3,
    inq_communications_count06 > 0 => 6,
    inq_communications_count12 > 0 => 12,
    inq_communications_count24 > 0 => 24,
    inq_communications_count   > 0 => 99,
                                  999);

r_i60_inq_count12_i := if(not(truedid), NULL, min(if(inq_count12 = NULL, -NULL, inq_count12), 999));

r_i60_inq_recency_d := map(
    not(truedid) => NULL,
    inq_count01 > 0 => 1,
    inq_count03 > 0 => 3,
    inq_count06 > 0 => 6,
    inq_count12 > 0 => 12,
    inq_count24 > 0 => 24,
    inq_count   > 0 => 99,
                    999);

r_i61_inq_collection_recency_d := map(
    not(truedid)           => NULL,
    inq_collection_count01 > 0 => 1,
    inq_collection_count03 > 0 => 3,
    inq_collection_count06 > 0 => 6,
    inq_collection_count12 > 0 => 12,
    inq_collection_count24 > 0 => 24,
    inq_collection_count   > 0 => 99,
                              999);

r_i60_inq_hiriskcred_recency_d := map(
    not(truedid)               => NULL,
    inq_highRiskCredit_count01 > 0 => 1,
    inq_highRiskCredit_count03 > 0 => 3,
    inq_highRiskCredit_count06 > 0 => 6,
    inq_highRiskCredit_count12 > 0 => 12,
    inq_highRiskCredit_count24 > 0 => 24,
    inq_highRiskCredit_count   > 0 => 99,
                                  999);

r_i60_inq_prepaidcards_recency_d := map(
    not(truedid)             => NULL,
    inq_PrepaidCards_count01 > 0 => 1,
    inq_PrepaidCards_count03 > 0 => 3,
    inq_PrepaidCards_count06 > 0 => 6,
    inq_PrepaidCards_count12 > 0 => 12,
    inq_PrepaidCards_count24 > 0 => 24,
    inq_PrepaidCards_count   > 0 => 99,
                                999);

r_i60_inq_retpymt_recency_d := map(
    not(truedid)               => NULL,
    inq_retailpayments_count01 > 0 => 1,
    inq_retailpayments_count03 > 0 => 3,
    inq_retailpayments_count06 > 0 => 6,
    inq_retailpayments_count12 > 0 => 12,
    inq_retailpayments_count24 > 0 => 24,
    inq_retailpayments_count   > 0 => 99,
                                  999);

r_i60_inq_util_count12_i := if(not(truedid), NULL, min(if(inq_utilities_count12 = NULL, -NULL, inq_utilities_count12), 999));

r_i60_inq_util_recency_d := map(
    not(truedid)          => NULL,
    inq_utilities_count01 > 0 => 1,
    inq_utilities_count03 > 0 => 3,
    inq_utilities_count06 > 0 => 6,
    inq_utilities_count12 > 0 => 12,
    inq_utilities_count24 > 0 => 24,
    inq_utilities_count   > 0 => 99,
                             999);

r_c16_inv_ssn_per_adl_i := if(not(truedid), NULL, min(if(invalid_ssns_per_adl = NULL, -NULL, invalid_ssns_per_adl), 999));

r_c18_invalid_addrs_per_adl_i := if(not(truedid), NULL, min(if(invalid_addrs_per_adl = NULL, -NULL, invalid_addrs_per_adl), 999));

f_prevaddrlenofres_d := if(not(truedid), NULL, min(if(fp_prevaddrlenofres = '', -NULL, (integer)fp_prevaddrlenofres), 999));

r_c13_curr_addr_lres_d := if(not(truedid and add_curr_pop), NULL, min(if(add_curr_lres = NULL, -NULL, add_curr_lres), 999));

r_c13_max_lres_d := if(not(truedid), NULL, min(if(max_lres = NULL, -NULL, max_lres), 999));

f_liens_rel_cj_total_amt_i := if(not(truedid), NULL, liens_rel_CJ_total_amount);

f_liens_unrel_cj_total_amt_i := if(not(truedid), NULL, liens_unrel_CJ_total_amount);

f_liens_unrel_ft_total_amt_i := if(not(truedid), NULL, liens_unrel_FT_total_amount);

f_liens_unrel_o_total_amt_i := if(not(truedid), NULL, liens_unrel_O_total_amount);

f_liens_unrel_ot_total_amt_i := if(not(truedid), NULL, liens_unrel_OT_total_amount);

f_liens_unrel_sc_total_amt_i := if(not(truedid), NULL, liens_unrel_SC_total_amount);

f_liens_unrel_st_ct_i := if(not(truedid), NULL, min(if(liens_unrel_ST_ct = NULL, -NULL, liens_unrel_ST_ct), 999));

f_liens_unrel_st_total_amt_i := if(not(truedid), NULL, liens_unrel_ST_total_amount);

_liens_rel_cj_first_seen := common.sas_date((string)(liens_rel_CJ_first_seen));

f_mos_liens_rel_cj_fseen_d := map(
    not(truedid)                    => NULL,
    _liens_rel_cj_first_seen = NULL => 1000,
                                       min(if(if ((sysdate - _liens_rel_cj_first_seen) / (365.25 / 12) >= 0, truncate((sysdate - _liens_rel_cj_first_seen) / (365.25 / 12)), roundup((sysdate - _liens_rel_cj_first_seen) / (365.25 / 12))) = NULL, -NULL, if ((sysdate - _liens_rel_cj_first_seen) / (365.25 / 12) >= 0, truncate((sysdate - _liens_rel_cj_first_seen) / (365.25 / 12)), roundup((sysdate - _liens_rel_cj_first_seen) / (365.25 / 12)))), 999));

_liens_rel_cj_last_seen := common.sas_date((string)(liens_rel_CJ_last_seen));

f_mos_liens_rel_cj_lseen_d := map(
    not(truedid)                   => NULL,
    _liens_rel_cj_last_seen = NULL => 1000,
                                      max(3, min(if(if ((sysdate - _liens_rel_cj_last_seen) / (365.25 / 12) >= 0, truncate((sysdate - _liens_rel_cj_last_seen) / (365.25 / 12)), roundup((sysdate - _liens_rel_cj_last_seen) / (365.25 / 12))) = NULL, -NULL, if ((sysdate - _liens_rel_cj_last_seen) / (365.25 / 12) >= 0, truncate((sysdate - _liens_rel_cj_last_seen) / (365.25 / 12)), roundup((sysdate - _liens_rel_cj_last_seen) / (365.25 / 12)))), 999)));

_liens_rel_o_last_seen := common.sas_date((string)(liens_rel_O_last_seen));

f_mos_liens_rel_o_lseen_d := map(
    not(truedid)                  => NULL,
    _liens_rel_o_last_seen = NULL => 1000,
                                     max(3, min(if(if ((sysdate - _liens_rel_o_last_seen) / (365.25 / 12) >= 0, truncate((sysdate - _liens_rel_o_last_seen) / (365.25 / 12)), roundup((sysdate - _liens_rel_o_last_seen) / (365.25 / 12))) = NULL, -NULL, if ((sysdate - _liens_rel_o_last_seen) / (365.25 / 12) >= 0, truncate((sysdate - _liens_rel_o_last_seen) / (365.25 / 12)), roundup((sysdate - _liens_rel_o_last_seen) / (365.25 / 12)))), 999)));

_liens_unrel_cj_last_seen := common.sas_date((string)(liens_unrel_CJ_last_seen));

f_mos_liens_unrel_cj_lseen_d := map(
    not(truedid)                     => NULL,
    _liens_unrel_cj_last_seen = NULL => 1000,
                                        max(3, min(if(if ((sysdate - _liens_unrel_cj_last_seen) / (365.25 / 12) >= 0, truncate((sysdate - _liens_unrel_cj_last_seen) / (365.25 / 12)), roundup((sysdate - _liens_unrel_cj_last_seen) / (365.25 / 12))) = NULL, -NULL, if ((sysdate - _liens_unrel_cj_last_seen) / (365.25 / 12) >= 0, truncate((sysdate - _liens_unrel_cj_last_seen) / (365.25 / 12)), roundup((sysdate - _liens_unrel_cj_last_seen) / (365.25 / 12)))), 999)));

_liens_unrel_ot_first_seen := common.sas_date((string)(liens_unrel_OT_first_seen));

f_mos_liens_unrel_ot_fseen_d := map(
    not(truedid)                      => NULL,
    _liens_unrel_ot_first_seen = NULL => 1000,
                                         min(if(if ((sysdate - _liens_unrel_ot_first_seen) / (365.25 / 12) >= 0, truncate((sysdate - _liens_unrel_ot_first_seen) / (365.25 / 12)), roundup((sysdate - _liens_unrel_ot_first_seen) / (365.25 / 12))) = NULL, -NULL, if ((sysdate - _liens_unrel_ot_first_seen) / (365.25 / 12) >= 0, truncate((sysdate - _liens_unrel_ot_first_seen) / (365.25 / 12)), roundup((sysdate - _liens_unrel_ot_first_seen) / (365.25 / 12)))), 999));

_liens_unrel_sc_first_seen := common.sas_date((string)(liens_unrel_SC_first_seen));

f_mos_liens_unrel_sc_fseen_d := map(
    not(truedid)                      => NULL,
    _liens_unrel_sc_first_seen = NULL => 1000,
                                         min(if(if ((sysdate - _liens_unrel_sc_first_seen) / (365.25 / 12) >= 0, truncate((sysdate - _liens_unrel_sc_first_seen) / (365.25 / 12)), roundup((sysdate - _liens_unrel_sc_first_seen) / (365.25 / 12))) = NULL, -NULL, if ((sysdate - _liens_unrel_sc_first_seen) / (365.25 / 12) >= 0, truncate((sysdate - _liens_unrel_sc_first_seen) / (365.25 / 12)), roundup((sysdate - _liens_unrel_sc_first_seen) / (365.25 / 12)))), 999));

_liens_unrel_st_last_seen := common.sas_date((string)(liens_unrel_ST_last_seen));

f_mos_liens_unrel_st_lseen_d := map(
    not(truedid)                     => NULL,
    _liens_unrel_st_last_seen = NULL => 1000,
                                        max(3, min(if(if ((sysdate - _liens_unrel_st_last_seen) / (365.25 / 12) >= 0, truncate((sysdate - _liens_unrel_st_last_seen) / (365.25 / 12)), roundup((sysdate - _liens_unrel_st_last_seen) / (365.25 / 12))) = NULL, -NULL, if ((sysdate - _liens_unrel_st_last_seen) / (365.25 / 12) >= 0, truncate((sysdate - _liens_unrel_st_last_seen) / (365.25 / 12)), roundup((sysdate - _liens_unrel_st_last_seen) / (365.25 / 12)))), 999)));

r_d34_unrel_liens_ct_i := if(not(truedid), NULL, min(if(if(max(liens_recent_unreleased_count, liens_historical_unreleased_ct) = NULL, NULL, sum(if(liens_recent_unreleased_count = NULL, 0, liens_recent_unreleased_count), if(liens_historical_unreleased_ct = NULL, 0, liens_historical_unreleased_ct))) = NULL, -NULL, if(max(liens_recent_unreleased_count, liens_historical_unreleased_ct) = NULL, NULL, sum(if(liens_recent_unreleased_count = NULL, 0, liens_recent_unreleased_count), if(liens_historical_unreleased_ct = NULL, 0, liens_historical_unreleased_ct)))), 999));

k_nap_lname_verd_d := (nap_summary in [2, 5, 7, 8, 9, 11, 12]);

k_nap_nothing_found_i := (nap_summary in [0]);

r_f01_inp_addr_address_score_d := if(not(truedid and add_input_pop) or add_input_address_score = 255, NULL, min(if(add_input_address_score = NULL, -NULL, add_input_address_score), 999));

r_f01_inp_addr_not_verified_i := if(not(add_input_pop and truedid), NULL, (integer)add_input_addr_not_verified);

f_add_curr_mobility_index_i := map(
    not(add_curr_pop)           => NULL,
    add_curr_occupants_1yr <= 0 => NULL,
                                   if(max(add_curr_turnover_1yr_in, add_curr_turnover_1yr_out) = NULL, NULL, sum(if(add_curr_turnover_1yr_in = NULL, 0, add_curr_turnover_1yr_in), if(add_curr_turnover_1yr_out = NULL, 0, add_curr_turnover_1yr_out))) / add_curr_occupants_1yr);

f_add_input_mobility_index_i := map(
    not(addrpop)                 => NULL,
    add_input_occupants_1yr <= 0 => NULL,
                                    if(max(add_input_turnover_1yr_in, add_input_turnover_1yr_out) = NULL, NULL, sum(if(add_input_turnover_1yr_in = NULL, 0, add_input_turnover_1yr_in), if(add_input_turnover_1yr_out = NULL, 0, add_input_turnover_1yr_out))) / add_input_occupants_1yr);

f_addrchangecrimediff_i := map(
    not(truedid)                => NULL,
    fp_addrchangecrimediff = '-1' => NULL,
                                   (integer)fp_addrchangecrimediff);

f_curraddrburglaryindex_i := if(not(add_curr_pop), NULL, (integer)fp_curraddrburglaryindex);

f_curraddrcrimeindex_i := if(not(add_curr_pop), NULL, (integer)fp_curraddrcrimeindex);

f_curraddrmurderindex_i := if(not(add_curr_pop), NULL, (integer)fp_curraddrmurderindex);

f_curraddrcartheftindex_i := if(not(add_curr_pop), NULL, (integer)fp_curraddrcartheftindex);

f_fp_prevaddrburglaryindex_i := if(not(truedid), NULL, (integer)fp_prevaddrburglaryindex);

f_fp_prevaddrcrimeindex_i := if(not(truedid), NULL, (integer)fp_prevaddrcrimeindex);

f_prevaddrmurderindex_i := if(not(truedid), NULL, (integer)fp_prevaddrmurderindex);

f_prevaddrcartheftindex_i := if(not(truedid), NULL, (integer)fp_prevaddrcartheftindex);

add_curr_nhood_prop_sum_4 := if(max(add_curr_nhood_BUS_ct, add_curr_nhood_SFD_ct, add_curr_nhood_MFD_ct) = NULL, NULL, sum(if(add_curr_nhood_BUS_ct = NULL, 0, add_curr_nhood_BUS_ct), if(add_curr_nhood_SFD_ct = NULL, 0, add_curr_nhood_SFD_ct), if(add_curr_nhood_MFD_ct = NULL, 0, add_curr_nhood_MFD_ct)));

f_add_curr_has_vac_ct_i := if(add_curr_nhood_prop_sum_4 = 0, 0, 1);

add_curr_nhood_prop_sum_3 := if(max(add_curr_nhood_BUS_ct, add_curr_nhood_SFD_ct, add_curr_nhood_MFD_ct) = NULL, NULL, sum(if(add_curr_nhood_BUS_ct = NULL, 0, add_curr_nhood_BUS_ct), if(add_curr_nhood_SFD_ct = NULL, 0, add_curr_nhood_SFD_ct), if(add_curr_nhood_MFD_ct = NULL, 0, add_curr_nhood_MFD_ct)));

f_add_curr_nhood_vac_pct_i := map(
    not(add_curr_pop)             => NULL,
    add_curr_nhood_prop_sum_3 = 0 => -1,
                                     add_curr_nhood_VAC_prop / add_curr_nhood_prop_sum_3);

add_curr_nhood_prop_sum_2 := if(max(add_curr_nhood_BUS_ct, add_curr_nhood_SFD_ct, add_curr_nhood_MFD_ct) = NULL, NULL, sum(if(add_curr_nhood_BUS_ct = NULL, 0, add_curr_nhood_BUS_ct), if(add_curr_nhood_SFD_ct = NULL, 0, add_curr_nhood_SFD_ct), if(add_curr_nhood_MFD_ct = NULL, 0, add_curr_nhood_MFD_ct)));

f_add_curr_nhood_sfd_pct_d := map(
    not(add_curr_pop)         => NULL,
    add_curr_nhood_SFD_ct = 0 => -1,
                                 add_curr_nhood_SFD_ct / add_curr_nhood_prop_sum_2);

add_curr_nhood_prop_sum_1 := if(max(add_curr_nhood_BUS_ct, add_curr_nhood_SFD_ct, add_curr_nhood_MFD_ct) = NULL, NULL, sum(if(add_curr_nhood_BUS_ct = NULL, 0, add_curr_nhood_BUS_ct), if(add_curr_nhood_SFD_ct = NULL, 0, add_curr_nhood_SFD_ct), if(add_curr_nhood_MFD_ct = NULL, 0, add_curr_nhood_MFD_ct)));

f_add_curr_nhood_mfd_pct_i := map(
    not(add_curr_pop)         => NULL,
    add_curr_nhood_MFD_ct = 0 => NULL,
                                 add_curr_nhood_MFD_ct / add_curr_nhood_prop_sum_1);

add_curr_nhood_prop_sum := if(max(add_curr_nhood_BUS_ct, add_curr_nhood_SFD_ct, add_curr_nhood_MFD_ct) = NULL, NULL, sum(if(add_curr_nhood_BUS_ct = NULL, 0, add_curr_nhood_BUS_ct), if(add_curr_nhood_SFD_ct = NULL, 0, add_curr_nhood_SFD_ct), if(add_curr_nhood_MFD_ct = NULL, 0, add_curr_nhood_MFD_ct)));

f_add_curr_nhood_bus_pct_i := map(
    not(add_curr_pop)         => NULL,
    add_curr_nhood_BUS_ct = 0 => NULL,
                                 add_curr_nhood_BUS_ct / add_curr_nhood_prop_sum);

f_add_input_has_sfd_ct_d := if(add_input_nhood_SFD_ct = 0, 0, 1);

add_input_nhood_prop_sum_3 := if(max(add_input_nhood_BUS_ct, add_input_nhood_SFD_ct, add_input_nhood_MFD_ct) = NULL, NULL, sum(if(add_input_nhood_BUS_ct = NULL, 0, add_input_nhood_BUS_ct), if(add_input_nhood_SFD_ct = NULL, 0, add_input_nhood_SFD_ct), if(add_input_nhood_MFD_ct = NULL, 0, add_input_nhood_MFD_ct)));

f_add_input_nhood_sfd_pct_d := map(
    not(addrpop)               => NULL,
    add_input_nhood_SFD_ct = 0 => -1,
                                  add_input_nhood_SFD_ct / add_input_nhood_prop_sum_3);

f_add_input_has_vac_ct_i := if(add_input_nhood_prop_sum_3 = 0, 0, 1);

add_input_nhood_prop_sum_2 := if(max(add_input_nhood_BUS_ct, add_input_nhood_SFD_ct, add_input_nhood_MFD_ct) = NULL, NULL, sum(if(add_input_nhood_BUS_ct = NULL, 0, add_input_nhood_BUS_ct), if(add_input_nhood_SFD_ct = NULL, 0, add_input_nhood_SFD_ct), if(add_input_nhood_MFD_ct = NULL, 0, add_input_nhood_MFD_ct)));

f_add_input_nhood_vac_pct_i := map(
    not(addrpop)                   => NULL,
    add_input_nhood_prop_sum_2 = 0 => -1,
                                      add_input_nhood_VAC_prop / add_input_nhood_prop_sum_2);

add_input_nhood_prop_sum_1 := if(max(add_input_nhood_BUS_ct, add_input_nhood_SFD_ct, add_input_nhood_MFD_ct) = NULL, NULL, sum(if(add_input_nhood_BUS_ct = NULL, 0, add_input_nhood_BUS_ct), if(add_input_nhood_SFD_ct = NULL, 0, add_input_nhood_SFD_ct), if(add_input_nhood_MFD_ct = NULL, 0, add_input_nhood_MFD_ct)));

f_add_input_nhood_mfd_pct_i := map(
    not(addrpop)               => NULL,
    add_input_nhood_MFD_ct = 0 => NULL,
                                  add_input_nhood_MFD_ct / add_input_nhood_prop_sum_1);

add_input_nhood_prop_sum := if(max(add_input_nhood_BUS_ct, add_input_nhood_SFD_ct, add_input_nhood_MFD_ct) = NULL, NULL, sum(if(add_input_nhood_BUS_ct = NULL, 0, add_input_nhood_BUS_ct), if(add_input_nhood_SFD_ct = NULL, 0, add_input_nhood_SFD_ct), if(add_input_nhood_MFD_ct = NULL, 0, add_input_nhood_MFD_ct)));

f_add_input_nhood_bus_pct_i := map(
    not(addrpop)               => NULL,
    add_input_nhood_BUS_ct = 0 => NULL,
                                  add_input_nhood_BUS_ct / add_input_nhood_prop_sum);

f_addrchangeincomediff_d_1 := if(not(truedid), NULL, NULL);

f_addrchangeincomediff_d := if(fp_addrchangeincomediff = '-1', NULL, (integer)fp_addrchangeincomediff);

f_curraddrmedianincome_d := if(not(add_curr_pop), NULL, (integer)fp_curraddrmedianincome);

f_prevaddrmedianincome_d := if(not(truedid), NULL, (integer)fp_prevaddrmedianincome);

f_addrchangevaluediff_d := map(
    not(truedid)                => NULL,
    fp_addrchangevaluediff = '-1' => NULL,
                                   (integer)fp_addrchangevaluediff);

f_curraddrmedianvalue_d := if(not(add_curr_pop), NULL, (integer)fp_curraddrmedianvalue);

f_prevaddrmedianvalue_d := if(not(truedid), NULL, (integer)fp_prevaddrmedianvalue);

f_dl_addrs_per_adl_i := if(not(truedid), NULL, min(if(dl_addrs_per_adl = NULL, -NULL, dl_addrs_per_adl), 999));

f_divrisktype_i := map(
    not(truedid)          => NULL,
    fp_divrisktype = '' => NULL,
                             (integer)fp_divrisktype);

f_phones_per_addr_c6_i := if(not(addrpop), NULL, min(if(phones_per_addr_c6 = NULL, -NULL, phones_per_addr_c6), 999));

//f_phones_per_addr_curr_i := if(not(add_curr_pop), NULL, min(if(phones_per_addr_curr = NULL, -NULL, phones_per_addr_curr), 999));
f_phones_per_addr_curr_i := __common__( if(not(add_curr_pop), NULL, min(if(phones_per_addr_curr = NULL, -NULL, phones_per_addr_curr), 999)));
f_sourcerisktype_i := map(
    not(truedid)             => NULL,
    fp_sourcerisktype = '' => NULL,
                                (integer)fp_sourcerisktype);

r_a46_curr_avm_autoval_d := map(
    not(add_curr_pop)         => NULL,
    add_curr_avm_auto_val = 0 => NULL,
                                 min(if(add_curr_avm_auto_val = NULL, -NULL, add_curr_avm_auto_val), 300000));

r_a49_curr_avm_chg_1yr_i := map(
    not(add_curr_pop)                                         => NULL,
    add_curr_lres < 12                                        => NULL,
    add_curr_avm_auto_val > 0 and add_curr_avm_auto_val_2 > 0 => add_curr_avm_auto_val - add_curr_avm_auto_val_2,
                                                                 NULL);

r_a49_curr_avm_chg_1yr_pct_i := map(
    not(add_curr_pop)                                         => NULL,
    add_curr_lres < 12                                        => NULL,
    add_curr_avm_auto_val > 0 and add_curr_avm_auto_val_2 > 0 => round(100 * add_curr_avm_auto_val / add_curr_avm_auto_val_2/0.1)*0.1,
                                                                 NULL);

r_l80_inp_avm_autoval_d := map(
    not(add_input_pop)         => NULL,
    add_input_avm_auto_val = 0 => NULL,
                                  min(if(add_input_avm_auto_val = NULL, -NULL, add_input_avm_auto_val), 300000));

f_current_count_d := if(not(truedid), NULL, min(if(current_count = NULL, -NULL, current_count), 999));

f_historical_count_d := if(not(truedid), NULL, min(if(historical_count = NULL, -NULL, historical_count), 999));

f_assoccredbureaucount_i := if(not(truedid), NULL, min(if(fp_assoccredbureaucount = '', -NULL, (integer)fp_assoccredbureaucount), 999));

f_assocrisktype_i := map(
    not(truedid)            => NULL,
    fp_assocrisktype = '' => NULL,
                               (integer)fp_assocrisktype);

f_assocsuspicousidcount_i := if(not(truedid), NULL, min(if(fp_assocsuspicousidcount = '', -NULL, (integer)fp_assocsuspicousidcount), 999));

f_crim_rel_under25miles_cnt_i := map(
    not(truedid)  => NULL,
    rel_count = 0 => NULL,
                     crim_rel_within25miles);

f_crim_rel_under500miles_cnt_i := map(
    not(truedid)  => NULL,
    rel_count = 0 => NULL,
                     if(max(crim_rel_within25miles, crim_rel_within100miles, crim_rel_within500miles) = NULL, NULL, sum(if(crim_rel_within25miles = NULL, 0, crim_rel_within25miles), if(crim_rel_within100miles = NULL, 0, crim_rel_within100miles), if(crim_rel_within500miles = NULL, 0, crim_rel_within500miles))));

f_rel_ageover20_count_d := map(
    not(truedid)  => NULL,
    rel_count = 0 => NULL,
                     if(max(rel_ageunder30_count, rel_ageunder40_count, rel_ageunder50_count, rel_ageunder60_count, rel_ageunder70_count, rel_ageover70_count) = NULL, NULL, sum(if(rel_ageunder30_count = NULL, 0, rel_ageunder30_count), if(rel_ageunder40_count = NULL, 0, rel_ageunder40_count), if(rel_ageunder50_count = NULL, 0, rel_ageunder50_count), if(rel_ageunder60_count = NULL, 0, rel_ageunder60_count), if(rel_ageunder70_count = NULL, 0, rel_ageunder70_count), if(rel_ageover70_count = NULL, 0, rel_ageover70_count))));

f_rel_ageover30_count_d := map(
    not(truedid)  => NULL,
    rel_count = 0 => NULL,
                     if(max(rel_ageunder40_count, rel_ageunder50_count, rel_ageunder60_count, rel_ageunder70_count, rel_ageover70_count) = NULL, NULL, sum(if(rel_ageunder40_count = NULL, 0, rel_ageunder40_count), if(rel_ageunder50_count = NULL, 0, rel_ageunder50_count), if(rel_ageunder60_count = NULL, 0, rel_ageunder60_count), if(rel_ageunder70_count = NULL, 0, rel_ageunder70_count), if(rel_ageover70_count = NULL, 0, rel_ageover70_count))));

f_rel_ageover40_count_d := map(
    not(truedid)  => NULL,
    rel_count = 0 => NULL,
                     if(max(rel_ageunder50_count, rel_ageunder60_count, rel_ageunder70_count, rel_ageover70_count) = NULL, NULL, sum(if(rel_ageunder50_count = NULL, 0, rel_ageunder50_count), if(rel_ageunder60_count = NULL, 0, rel_ageunder60_count), if(rel_ageunder70_count = NULL, 0, rel_ageunder70_count), if(rel_ageover70_count = NULL, 0, rel_ageover70_count))));

f_rel_count_i := if(not(truedid), NULL, min(if(rel_count = NULL, -NULL, rel_count), 999));

f_rel_educationover8_count_d := map(
    not(truedid)  => NULL,
    rel_count = 0 => NULL,
                     if(max(rel_educationunder12_count, rel_educationover12_count) = NULL, NULL, sum(if(rel_educationunder12_count = NULL, 0, rel_educationunder12_count), if(rel_educationover12_count = NULL, 0, rel_educationover12_count))));

f_rel_educationover12_count_d := map(
    not(truedid)  => NULL,
    rel_count = 0 => NULL,
                     rel_educationover12_count);

f_rel_felony_count_i := map(
    not(truedid)  => NULL,
    rel_count = 0 => -1,
                     min(if(rel_felony_count = NULL, -NULL, rel_felony_count), 999));

f_rel_homeover50_count_d := map(
    not(truedid)  => NULL,
    rel_count = 0 => NULL,
                     if(max(rel_homeunder100_count, rel_homeunder150_count, rel_homeunder200_count, rel_homeunder300_count, rel_homeunder500_count, rel_homeover500_count) = NULL, NULL, sum(if(rel_homeunder100_count = NULL, 0, rel_homeunder100_count), if(rel_homeunder150_count = NULL, 0, rel_homeunder150_count), if(rel_homeunder200_count = NULL, 0, rel_homeunder200_count), if(rel_homeunder300_count = NULL, 0, rel_homeunder300_count), if(rel_homeunder500_count = NULL, 0, rel_homeunder500_count), if(rel_homeover500_count = NULL, 0, rel_homeover500_count))));

f_rel_homeover100_count_d := map(
    not(truedid)  => NULL,
    rel_count = 0 => NULL,
                     if(max(rel_homeunder150_count, rel_homeunder200_count, rel_homeunder300_count, rel_homeunder500_count, rel_homeover500_count) = NULL, NULL, sum(if(rel_homeunder150_count = NULL, 0, rel_homeunder150_count), if(rel_homeunder200_count = NULL, 0, rel_homeunder200_count), if(rel_homeunder300_count = NULL, 0, rel_homeunder300_count), if(rel_homeunder500_count = NULL, 0, rel_homeunder500_count), if(rel_homeover500_count = NULL, 0, rel_homeover500_count))));

f_rel_homeover150_count_d := map(
    not(truedid)  => NULL,
    rel_count = 0 => NULL,
                     if(max(rel_homeunder200_count, rel_homeunder300_count, rel_homeunder500_count, rel_homeover500_count) = NULL, NULL, sum(if(rel_homeunder200_count = NULL, 0, rel_homeunder200_count), if(rel_homeunder300_count = NULL, 0, rel_homeunder300_count), if(rel_homeunder500_count = NULL, 0, rel_homeunder500_count), if(rel_homeover500_count = NULL, 0, rel_homeover500_count))));

f_rel_homeover200_count_d := map(
    not(truedid)  => NULL,
    rel_count = 0 => NULL,
                     if(max(rel_homeunder300_count, rel_homeunder500_count, rel_homeover500_count) = NULL, NULL, sum(if(rel_homeunder300_count = NULL, 0, rel_homeunder300_count), if(rel_homeunder500_count = NULL, 0, rel_homeunder500_count), if(rel_homeover500_count = NULL, 0, rel_homeover500_count))));

f_rel_homeover300_count_d := map(
    not(truedid)  => NULL,
    rel_count = 0 => NULL,
                     if(max(rel_homeunder500_count, rel_homeover500_count) = NULL, NULL, sum(if(rel_homeunder500_count = NULL, 0, rel_homeunder500_count), if(rel_homeover500_count = NULL, 0, rel_homeover500_count))));

f_rel_incomeover25_count_d := map(
    not(truedid)  => NULL,
    rel_count = 0 => NULL,
                     if(max(rel_incomeover100_count, rel_incomeunder100_count, rel_incomeunder75_count, rel_incomeunder50_count) = NULL, NULL, sum(if(rel_incomeover100_count = NULL, 0, rel_incomeover100_count), if(rel_incomeunder100_count = NULL, 0, rel_incomeunder100_count), if(rel_incomeunder75_count = NULL, 0, rel_incomeunder75_count), if(rel_incomeunder50_count = NULL, 0, rel_incomeunder50_count))));

f_rel_incomeover50_count_d := map(
    not(truedid)  => NULL,
    rel_count = 0 => NULL,
                     if(max(rel_incomeover100_count, rel_incomeunder100_count, rel_incomeunder75_count) = NULL, NULL, sum(if(rel_incomeover100_count = NULL, 0, rel_incomeover100_count), if(rel_incomeunder100_count = NULL, 0, rel_incomeunder100_count), if(rel_incomeunder75_count = NULL, 0, rel_incomeunder75_count))));

f_rel_incomeover75_count_d := map(
    not(truedid)  => NULL,
    rel_count = 0 => NULL,
                     if(max(rel_incomeover100_count, rel_incomeunder100_count) = NULL, NULL, sum(if(rel_incomeover100_count = NULL, 0, rel_incomeover100_count), if(rel_incomeunder100_count = NULL, 0, rel_incomeunder100_count))));

f_rel_incomeover100_count_d := map(
    not(truedid)  => NULL,
    rel_count = 0 => NULL,
                     rel_incomeover100_count);

f_rel_under100miles_cnt_d := map(
    not(truedid)  => NULL,
    rel_count = 0 => NULL,
                     if(max(rel_within25miles_count, rel_within100miles_count) = NULL, NULL, sum(if(rel_within25miles_count = NULL, 0, rel_within25miles_count), if(rel_within100miles_count = NULL, 0, rel_within100miles_count))));

f_rel_under500miles_cnt_d := map(
    not(truedid)  => NULL,
    rel_count = 0 => NULL,
                     if(max(rel_within25miles_count, rel_within100miles_count, rel_within500miles_count) = NULL, NULL, sum(if(rel_within25miles_count = NULL, 0, rel_within25miles_count), if(rel_within100miles_count = NULL, 0, rel_within100miles_count), if(rel_within500miles_count = NULL, 0, rel_within500miles_count))));

f_rel_under25miles_cnt_d := map(
    not(truedid)  => NULL,
    rel_count = 0 => NULL,
                     rel_within25miles_count);

f_divaddrsuspidcountnew_i := if(not(truedid), NULL, min(if(fp_divaddrsuspidcountnew = '', -NULL, (integer)fp_divaddrsuspidcountnew), 999));

bureau_adl_eq_fseen_pos_2 := Models.Common.findw_cpp(ver_sources, 'EQ' , ', ', 'E');

bureau_adl_fseen_eq_2 := if(bureau_adl_eq_fseen_pos_2 = 0, '       0', Models.Common.getw(ver_sources_first_seen, bureau_adl_eq_fseen_pos_2, ','));

_bureau_adl_fseen_eq_2 := common.sas_date((string)(bureau_adl_fseen_eq_2));

bureau_adl_en_fseen_pos_1 := Models.Common.findw_cpp(ver_sources, 'EN' , ',', 'E');

bureau_adl_fseen_en_1 := if(bureau_adl_en_fseen_pos_1 = 0, '       0', Models.Common.getw(ver_sources_first_seen, bureau_adl_en_fseen_pos_1, ','));

_bureau_adl_fseen_en_1 := common.sas_date((string)(bureau_adl_fseen_en_1));

bureau_adl_ts_fseen_pos_1 := Models.Common.findw_cpp(ver_sources, 'TS' , ',', 'E');

bureau_adl_fseen_ts_1 := if(bureau_adl_ts_fseen_pos_1 = 0, '       0', Models.Common.getw(ver_sources_first_seen, bureau_adl_ts_fseen_pos_1, ','));

_bureau_adl_fseen_ts_1 := common.sas_date((string)(bureau_adl_fseen_ts_1));

bureau_adl_tu_fseen_pos_1 := Models.Common.findw_cpp(ver_sources, 'TU' , ',', 'E');

bureau_adl_fseen_tu_1 := if(bureau_adl_tu_fseen_pos_1 = 0, '       0', Models.Common.getw(ver_sources_first_seen, bureau_adl_tu_fseen_pos_1, ','));

_bureau_adl_fseen_tu_1 := common.sas_date((string)(bureau_adl_fseen_tu_1));

bureau_adl_tn_fseen_pos_1 := Models.Common.findw_cpp(ver_sources, 'TN' , ',', 'E');

bureau_adl_fseen_tn_1 := if(bureau_adl_tn_fseen_pos_1 = 0, '       0', Models.Common.getw(ver_sources_first_seen, bureau_adl_tn_fseen_pos_1, ','));

_bureau_adl_fseen_tn_1 := common.sas_date((string)(bureau_adl_fseen_tn_1));

_src_bureau_adl_fseen_all := min(if(_bureau_adl_fseen_tn_1 = NULL, -NULL, _bureau_adl_fseen_tn_1), if(_bureau_adl_fseen_ts_1 = NULL, -NULL, _bureau_adl_fseen_ts_1), if(_bureau_adl_fseen_tu_1 = NULL, -NULL, _bureau_adl_fseen_tu_1), if(_bureau_adl_fseen_en_1 = NULL, -NULL, _bureau_adl_fseen_en_1), if(_bureau_adl_fseen_eq_2 = NULL, -NULL, _bureau_adl_fseen_eq_2), 999999);

f_m_bureau_adl_fs_all_d := map(
    not(truedid)                       => NULL,
    _src_bureau_adl_fseen_all = 999999 => 1000,
                                          min(if(if ((sysdate - _src_bureau_adl_fseen_all) / (365.25 / 12) >= 0, truncate((sysdate - _src_bureau_adl_fseen_all) / (365.25 / 12)), roundup((sysdate - _src_bureau_adl_fseen_all) / (365.25 / 12))) = NULL, -NULL, if ((sysdate - _src_bureau_adl_fseen_all) / (365.25 / 12) >= 0, truncate((sysdate - _src_bureau_adl_fseen_all) / (365.25 / 12)), roundup((sysdate - _src_bureau_adl_fseen_all) / (365.25 / 12)))), 999));

bureau_adl_eq_fseen_pos_1 := Models.Common.findw_cpp(ver_sources, 'EQ' , ', ', 'E');

bureau_adl_fseen_eq_1 := if(bureau_adl_eq_fseen_pos_1 = 0, '       0', Models.Common.getw(ver_sources_first_seen, bureau_adl_eq_fseen_pos_1, ','));

_bureau_adl_fseen_eq_1 := common.sas_date((string)(bureau_adl_fseen_eq_1));

bureau_adl_en_fseen_pos := Models.Common.findw_cpp(ver_sources, 'EN' , ',', 'E');

bureau_adl_fseen_en := if(bureau_adl_en_fseen_pos = 0, '       0', Models.Common.getw(ver_sources_first_seen, bureau_adl_en_fseen_pos, ','));

_bureau_adl_fseen_en := common.sas_date((string)(bureau_adl_fseen_en));

bureau_adl_ts_fseen_pos := Models.Common.findw_cpp(ver_sources, 'TS' , ',', 'E');

bureau_adl_fseen_ts := if(bureau_adl_ts_fseen_pos = 0, '       0', Models.Common.getw(ver_sources_first_seen, bureau_adl_ts_fseen_pos, ','));

_bureau_adl_fseen_ts := common.sas_date((string)(bureau_adl_fseen_ts));

bureau_adl_tu_fseen_pos := Models.Common.findw_cpp(ver_sources, 'TU' , ',', 'E');

bureau_adl_fseen_tu := if(bureau_adl_tu_fseen_pos = 0, '       0', Models.Common.getw(ver_sources_first_seen, bureau_adl_tu_fseen_pos, ','));

_bureau_adl_fseen_tu := common.sas_date((string)(bureau_adl_fseen_tu));

bureau_adl_tn_fseen_pos := Models.Common.findw_cpp(ver_sources, 'TN' , ',', 'E');

bureau_adl_fseen_tn := if(bureau_adl_tn_fseen_pos = 0, '       0', Models.Common.getw(ver_sources_first_seen, bureau_adl_tn_fseen_pos, ','));

_bureau_adl_fseen_tn := common.sas_date((string)(bureau_adl_fseen_tn));

_src_bureau_adl_fseen_notu := min(if(_bureau_adl_fseen_en = NULL, -NULL, _bureau_adl_fseen_en), if(_bureau_adl_fseen_eq_1 = NULL, -NULL, _bureau_adl_fseen_eq_1), 999999);

f_m_bureau_adl_fs_notu_d := map(
    not(truedid)                        => NULL,
    _src_bureau_adl_fseen_notu = 999999 => 1000,
                                           min(if(if ((sysdate - _src_bureau_adl_fseen_notu) / (365.25 / 12) >= 0, truncate((sysdate - _src_bureau_adl_fseen_notu) / (365.25 / 12)), roundup((sysdate - _src_bureau_adl_fseen_notu) / (365.25 / 12))) = NULL, -NULL, if ((sysdate - _src_bureau_adl_fseen_notu) / (365.25 / 12) >= 0, truncate((sysdate - _src_bureau_adl_fseen_notu) / (365.25 / 12)), roundup((sysdate - _src_bureau_adl_fseen_notu) / (365.25 / 12)))), 999));

_header_first_seen := common.sas_date((string)(header_first_seen));

r_c10_m_hdr_fs_d := map(
    not(truedid)              => NULL,
    _header_first_seen = NULL => 1000,
                                 min(if(if ((sysdate - _header_first_seen) / (365.25 / 12) >= 0, truncate((sysdate - _header_first_seen) / (365.25 / 12)), roundup((sysdate - _header_first_seen) / (365.25 / 12))) = NULL, -NULL, if ((sysdate - _header_first_seen) / (365.25 / 12) >= 0, truncate((sysdate - _header_first_seen) / (365.25 / 12)), roundup((sysdate - _header_first_seen) / (365.25 / 12)))), 999));

bureau_adl_eq_fseen_pos := Models.Common.findw_cpp(ver_sources, 'EQ' , ', ', 'E');

bureau_adl_fseen_eq := if(bureau_adl_eq_fseen_pos = 0, '       0', Models.Common.getw(ver_sources_first_seen, bureau_adl_eq_fseen_pos, ','));

_bureau_adl_fseen_eq := common.sas_date((string)(bureau_adl_fseen_eq));

_src_bureau_adl_fseen := min(if(_bureau_adl_fseen_eq = NULL, -NULL, _bureau_adl_fseen_eq), 999999);

r_c21_m_bureau_adl_fs_d := map(
    not(truedid)                   => NULL,
    _src_bureau_adl_fseen = 999999 => 1000,
                                      min(if(if ((sysdate - _src_bureau_adl_fseen) / (365.25 / 12) >= 0, truncate((sysdate - _src_bureau_adl_fseen) / (365.25 / 12)), roundup((sysdate - _src_bureau_adl_fseen) / (365.25 / 12))) = NULL, -NULL, if ((sysdate - _src_bureau_adl_fseen) / (365.25 / 12) >= 0, truncate((sysdate - _src_bureau_adl_fseen) / (365.25 / 12)), roundup((sysdate - _src_bureau_adl_fseen) / (365.25 / 12)))), 999));

r_wealth_index_d := if(not(truedid), NULL, (integer)wealth_index);

final_score_0 := -0.9728181308;

final_score_1_c204 := map(
    NULL < f_inq_other_count24_i AND f_inq_other_count24_i <= 0.5 => -0.0158412566,
    f_inq_other_count24_i > 0.5                                   => 0.0028621204,
    f_inq_other_count24_i = NULL                                  => -0.0095777776,
                                                                     -0.0095777776);

final_score_1_c203 := map(
    NULL < k_comb_age_d AND k_comb_age_d <= 33.5 => 0.0112549813,
    k_comb_age_d > 33.5                          => final_score_1_c204,
    k_comb_age_d = NULL                          => -0.0029807576,
                                                    -0.0029807576);

final_score_1 := map(
    NULL < f_add_input_nhood_mfd_pct_i AND f_add_input_nhood_mfd_pct_i <= 0.6111706549 => final_score_1_c203,
    f_add_input_nhood_mfd_pct_i > 0.6111706549                                         => 0.0185405322,
    f_add_input_nhood_mfd_pct_i = NULL                                                 => -0.0177135515,
                                                                                          -0.0003746859);

final_score_2_c207 := map(
    NULL < f_phones_per_addr_curr_i AND f_phones_per_addr_curr_i <= 18.5 => 0.0005114724,
    f_phones_per_addr_curr_i > 18.5                                      => 0.0404044805,
    f_phones_per_addr_curr_i = NULL                                      => 0.0129042221,
                                                                            0.0033478815);

final_score_2_c206 := map(
    NULL < f_add_input_nhood_mfd_pct_i AND f_add_input_nhood_mfd_pct_i <= 0.1996670139 => -0.0118183212,
    f_add_input_nhood_mfd_pct_i > 0.1996670139                                         => final_score_2_c207,
    f_add_input_nhood_mfd_pct_i = NULL                                                 => -0.0192159790,
                                                                                          -0.0055256840);

final_score_2 := map(
    NULL < k_comb_age_d AND k_comb_age_d <= 31.5 => 0.0171287566,
    k_comb_age_d > 31.5                          => final_score_2_c206,
    k_comb_age_d = NULL                          => 0.0002709268,
                                                    0.0002709268);

final_score_3_c209 := map(
    NULL < k_comb_age_d AND k_comb_age_d <= 33.5 => 0.0082138917,
    k_comb_age_d > 33.5                          => -0.0108570311,
    k_comb_age_d = NULL                          => -0.0048854436,
                                                    -0.0048854436);

final_score_3_c210 := map(
    NULL < r_f01_inp_addr_address_score_d AND r_f01_inp_addr_address_score_d <= 85 => 0.0314820452,
    r_f01_inp_addr_address_score_d > 85                                            => 0.0067088979,
    r_f01_inp_addr_address_score_d = NULL                                          => 0.0146738043,
                                                                                      0.0146738043);

final_score_3 := map(
    NULL < f_add_input_nhood_mfd_pct_i AND f_add_input_nhood_mfd_pct_i <= 0.4507648888 => final_score_3_c209,
    f_add_input_nhood_mfd_pct_i > 0.4507648888                                         => final_score_3_c210,
    f_add_input_nhood_mfd_pct_i = NULL                                                 => -0.0152863469,
                                                                                          -0.0006137322);

final_score_4_c212 := map(
    NULL < f_add_input_nhood_mfd_pct_i AND f_add_input_nhood_mfd_pct_i <= 0.4684179029 => 0.0059968343,
    f_add_input_nhood_mfd_pct_i > 0.4684179029                                         => 0.0254620352,
    f_add_input_nhood_mfd_pct_i = NULL                                                 => -0.0008694477,
                                                                                          0.0102650518);

final_score_4_c213 := map(
    NULL < f_add_input_nhood_mfd_pct_i AND f_add_input_nhood_mfd_pct_i <= 0.42622556255 => -0.0145810908,
    f_add_input_nhood_mfd_pct_i > 0.42622556255                                         => 0.0043435425,
    f_add_input_nhood_mfd_pct_i = NULL                                                  => -0.0231545905,
                                                                                           -0.0096739575);

final_score_4 := map(
    NULL < k_comb_age_d AND k_comb_age_d <= 39.5 => final_score_4_c212,
    k_comb_age_d > 39.5                          => final_score_4_c213,
    k_comb_age_d = NULL                          => -0.0008563436,
                                                    -0.0008563436);

final_score_5_c215 := map(
    NULL < f_add_input_nhood_mfd_pct_i AND f_add_input_nhood_mfd_pct_i <= 0.49036605285 => 0.0055094090,
    f_add_input_nhood_mfd_pct_i > 0.49036605285                                         => 0.0251127442,
    f_add_input_nhood_mfd_pct_i = NULL                                                  => -0.0087176399,
                                                                                           0.0091013594);

final_score_5_c216 := map(
    NULL < k_comb_age_d AND k_comb_age_d <= 36.5 => 0.0038638341,
    k_comb_age_d > 36.5                          => -0.0146245573,
    k_comb_age_d = NULL                          => -0.0081938125,
                                                    -0.0081938125);

final_score_5 := map(
    NULL < r_f03_address_match_d AND r_f03_address_match_d <= 3 => final_score_5_c215,
    r_f03_address_match_d > 3                                   => final_score_5_c216,
    r_f03_address_match_d = NULL                                => 0.0047206218,
                                                                   0.0001287313);

final_score_6_c219 := map(
    NULL < f_inq_other_count24_i AND f_inq_other_count24_i <= 0.5 => -0.0099482011,
    f_inq_other_count24_i > 0.5                                   => 0.0044923200,
    f_inq_other_count24_i = NULL                                  => -0.0050897432,
                                                                     -0.0050897432);

final_score_6_c218 := map(
    NULL < f_phones_per_addr_curr_i AND f_phones_per_addr_curr_i <= 24.5 => final_score_6_c219,
    f_phones_per_addr_curr_i > 24.5                                      => 0.0394422185,
    f_phones_per_addr_curr_i = NULL                                      => 0.0043629746,
                                                                            -0.0036544050);

final_score_6 := map(
    NULL < k_comb_age_d AND k_comb_age_d <= 28.5 => 0.0173759943,
    k_comb_age_d > 28.5                          => final_score_6_c218,
    k_comb_age_d = NULL                          => 0.0002536413,
                                                    0.0002536413);

final_score_7_c221 := map(
    NULL < k_comb_age_d AND k_comb_age_d <= 43.5 => 0.0017720500,
    k_comb_age_d > 43.5                          => -0.0144830697,
    k_comb_age_d = NULL                          => -0.0066055795,
                                                    -0.0066055795);

final_score_7_c222 := map(
    NULL < f_add_input_nhood_mfd_pct_i AND f_add_input_nhood_mfd_pct_i <= 0.51204402445 => 0.0061037456,
    f_add_input_nhood_mfd_pct_i > 0.51204402445                                         => 0.0265406752,
    f_add_input_nhood_mfd_pct_i = NULL                                                  => -0.0071171368,
                                                                                           0.0099192331);

final_score_7 := map(
    NULL < f_idverrisktype_i AND f_idverrisktype_i <= 2 => final_score_7_c221,
    f_idverrisktype_i > 2                               => final_score_7_c222,
    f_idverrisktype_i = NULL                            => -0.0011724974,
                                                           0.0005466266);

final_score_8_c225 := map(
    NULL < r_f01_inp_addr_not_verified_i AND r_f01_inp_addr_not_verified_i <= 0.5 => -0.0019131236,
    r_f01_inp_addr_not_verified_i > 0.5                                           => 0.0196633758,
    r_f01_inp_addr_not_verified_i = NULL                                          => 0.0033242387,
                                                                                     0.0033242387);

final_score_8_c224 := map(
    NULL < f_add_input_nhood_mfd_pct_i AND f_add_input_nhood_mfd_pct_i <= 0.24279245595 => -0.0106606882,
    f_add_input_nhood_mfd_pct_i > 0.24279245595                                         => final_score_8_c225,
    f_add_input_nhood_mfd_pct_i = NULL                                                  => -0.0155559272,
                                                                                           -0.0052176188);

final_score_8 := map(
    NULL < k_comb_age_d AND k_comb_age_d <= 33.5 => 0.0141378849,
    k_comb_age_d > 33.5                          => final_score_8_c224,
    k_comb_age_d = NULL                          => 0.0006763088,
                                                    0.0006763088);

final_score_9_c227 := map(
    NULL < f_add_input_nhood_mfd_pct_i AND f_add_input_nhood_mfd_pct_i <= 0.3732751057 => -0.0109717126,
    f_add_input_nhood_mfd_pct_i > 0.3732751057                                         => 0.0048617393,
    f_add_input_nhood_mfd_pct_i = NULL                                                 => -0.0211882537,
                                                                                          -0.0070170665);

final_score_9_c228 := map(
    NULL < r_f03_address_match_d AND r_f03_address_match_d <= 3 => 0.0193959123,
    r_f03_address_match_d > 3                                   => 0.0006920468,
    r_f03_address_match_d = NULL                                => 0.0101572252,
                                                                   0.0101572252);

final_score_9 := map(
    NULL < f_inq_other_count24_i AND f_inq_other_count24_i <= 0.5 => final_score_9_c227,
    f_inq_other_count24_i > 0.5                                   => final_score_9_c228,
    f_inq_other_count24_i = NULL                                  => -0.0007920132,
                                                                     -0.0008662705);

final_score_10_c230 := map(
    NULL < k_comb_age_d AND k_comb_age_d <= 38.5 => 0.0070542922,
    k_comb_age_d > 38.5                          => -0.0097211336,
    k_comb_age_d = NULL                          => -0.0025245634,
                                                    -0.0025245634);

final_score_10_c231 := map(
    NULL < f_add_input_has_sfd_ct_d AND f_add_input_has_sfd_ct_d <= 0.5 => -0.0419681958,
    f_add_input_has_sfd_ct_d > 0.5                                      => -0.0031122005,
    f_add_input_has_sfd_ct_d = NULL                                     => -0.0147914592,
                                                                           -0.0147914592);

final_score_10 := map(
    NULL < f_add_input_nhood_mfd_pct_i AND f_add_input_nhood_mfd_pct_i <= 0.59814417015 => final_score_10_c230,
    f_add_input_nhood_mfd_pct_i > 0.59814417015                                         => 0.0146199088,
    f_add_input_nhood_mfd_pct_i = NULL                                                  => final_score_10_c231,
                                                                                           -0.0004922977);

final_score_11_c234 := map(
    NULL < f_inq_other_count24_i AND f_inq_other_count24_i <= 0.5 => 0.0010780617,
    f_inq_other_count24_i > 0.5                                   => 0.0181154673,
    f_inq_other_count24_i = NULL                                  => 0.0075967666,
                                                                     0.0075967666);

final_score_11_c233 := map(
    NULL < f_add_curr_nhood_mfd_pct_i AND f_add_curr_nhood_mfd_pct_i <= 0.9126794582 => final_score_11_c234,
    f_add_curr_nhood_mfd_pct_i > 0.9126794582                                        => 0.0415156450,
    f_add_curr_nhood_mfd_pct_i = NULL                                                => -0.0037949925,
                                                                                        0.0077302289);

final_score_11 := map(
    NULL < r_f03_address_match_d AND r_f03_address_match_d <= 3 => final_score_11_c233,
    r_f03_address_match_d > 3                                   => -0.0081598935,
    r_f03_address_match_d = NULL                                => -0.0017236419,
                                                                   -0.0004855080);

final_score_12_c236 := map(
    NULL < k_comb_age_d AND k_comb_age_d <= 28.5 => 0.0117599318,
    k_comb_age_d > 28.5                          => -0.0066475350,
    k_comb_age_d = NULL                          => -0.0031614642,
                                                    -0.0031614642);

final_score_12_c237 := map(
    NULL < f_addrchangevaluediff_d AND f_addrchangevaluediff_d <= 174927.5 => 0.0097596137,
    f_addrchangevaluediff_d > 174927.5                                     => 0.0680423002,
    f_addrchangevaluediff_d = NULL                                         => 0.0163228163,
                                                                              0.0135507984);

final_score_12 := map(
    NULL < f_add_input_nhood_mfd_pct_i AND f_add_input_nhood_mfd_pct_i <= 0.5141015444 => final_score_12_c236,
    f_add_input_nhood_mfd_pct_i > 0.5141015444                                         => final_score_12_c237,
    f_add_input_nhood_mfd_pct_i = NULL                                                 => -0.0097709023,
                                                                                          0.0000755433);

final_score_13_c239 := map(
    NULL < f_add_input_nhood_vac_pct_i AND f_add_input_nhood_vac_pct_i <= 0.00073048515 => -0.0129220611,
    f_add_input_nhood_vac_pct_i > 0.00073048515                                         => 0.0108647571,
    f_add_input_nhood_vac_pct_i = NULL                                                  => 0.0075534949,
                                                                                           0.0075534949);

final_score_13_c240 := map(
    NULL < k_comb_age_d AND k_comb_age_d <= 40.5 => 0.0010745397,
    k_comb_age_d > 40.5                          => -0.0145897165,
    k_comb_age_d = NULL                          => -0.0078625824,
                                                    -0.0078625824);

final_score_13 := map(
    NULL < r_f03_address_match_d AND r_f03_address_match_d <= 2.5 => final_score_13_c239,
    r_f03_address_match_d > 2.5                                   => final_score_13_c240,
    r_f03_address_match_d = NULL                                  => 0.0081333058,
                                                                     -0.0003424082);

final_score_14_c243 := map(
    NULL < r_d32_mos_since_crim_ls_d AND r_d32_mos_since_crim_ls_d <= 26.5 => 0.0356204007,
    r_d32_mos_since_crim_ls_d > 26.5                                       => 0.0022116517,
    r_d32_mos_since_crim_ls_d = NULL                                       => 0.0059969087,
                                                                              0.0059969087);

final_score_14_c242 := map(
    NULL < f_inq_other_count24_i AND f_inq_other_count24_i <= 0.5 => -0.0094418039,
    f_inq_other_count24_i > 0.5                                   => final_score_14_c243,
    f_inq_other_count24_i = NULL                                  => 0.0270785952,
                                                                     -0.0041622868);

final_score_14 := map(
    NULL < k_comb_age_d AND k_comb_age_d <= 32.5 => 0.0117954024,
    k_comb_age_d > 32.5                          => final_score_14_c242,
    k_comb_age_d = NULL                          => 0.0002903561,
                                                    0.0002903561);

final_score_15_c246 := map(
    NULL < f_phones_per_addr_curr_i AND f_phones_per_addr_curr_i <= 21.5 => 0.0019076051,
    f_phones_per_addr_curr_i > 21.5                                      => 0.0506499431,
    f_phones_per_addr_curr_i = NULL                                      => 0.0037607541,
                                                                            0.0037607541);

final_score_15_c245 := map(
    NULL < f_inq_other_count24_i AND f_inq_other_count24_i <= 0.5 => -0.0106910075,
    f_inq_other_count24_i > 0.5                                   => final_score_15_c246,
    f_inq_other_count24_i = NULL                                  => 0.0095836756,
                                                                     -0.0059261178);

final_score_15 := map(
    NULL < k_comb_age_d AND k_comb_age_d <= 33.5 => 0.0093418638,
    k_comb_age_d > 33.5                          => final_score_15_c245,
    k_comb_age_d = NULL                          => -0.0012245904,
                                                    -0.0012245904);

final_score_16_c248 := map(
    NULL < f_srchunvrfdaddrcount_i AND f_srchunvrfdaddrcount_i <= 0.5 => 0.0048890412,
    f_srchunvrfdaddrcount_i > 0.5                                     => 0.0244009674,
    f_srchunvrfdaddrcount_i = NULL                                    => 0.0119981945,
                                                                         0.0079387801);

final_score_16_c249 := map(
    NULL < f_add_input_has_sfd_ct_d AND f_add_input_has_sfd_ct_d <= 0.5 => -0.0380602948,
    f_add_input_has_sfd_ct_d > 0.5                                      => 0.0007346279,
    f_add_input_has_sfd_ct_d = NULL                                     => -0.0106038808,
                                                                           -0.0106038808);

final_score_16 := map(
    NULL < f_add_input_nhood_mfd_pct_i AND f_add_input_nhood_mfd_pct_i <= 0.24292862155 => -0.0055030201,
    f_add_input_nhood_mfd_pct_i > 0.24292862155                                         => final_score_16_c248,
    f_add_input_nhood_mfd_pct_i = NULL                                                  => final_score_16_c249,
                                                                                           -0.0002534007);

final_score_17_c252 := map(
    NULL < f_add_input_nhood_sfd_pct_d AND f_add_input_nhood_sfd_pct_d <= 0.39621009335 => 0.0163553850,
    f_add_input_nhood_sfd_pct_d > 0.39621009335                                         => 0.0033555135,
    f_add_input_nhood_sfd_pct_d = NULL                                                  => 0.0070622808,
                                                                                           0.0070622808);

final_score_17_c251 := map(
    NULL < f_add_input_has_vac_ct_i AND f_add_input_has_vac_ct_i <= 0.5 => -0.0400005711,
    f_add_input_has_vac_ct_i > 0.5                                      => final_score_17_c252,
    f_add_input_has_vac_ct_i = NULL                                     => 0.0056027302,
                                                                           0.0056027302);

final_score_17 := map(
    NULL < r_c10_m_hdr_fs_d AND r_c10_m_hdr_fs_d <= 258.5 => final_score_17_c251,
    r_c10_m_hdr_fs_d > 258.5                              => -0.0081396230,
    r_c10_m_hdr_fs_d = NULL                               => 0.0008555908,
                                                             -0.0002767927);

final_score_18_c255 := map(
    NULL < f_varrisktype_i AND f_varrisktype_i <= 1.5 => -0.0021056255,
    f_varrisktype_i > 1.5                             => 0.0132468103,
    f_varrisktype_i = NULL                            => 0.0034171193,
                                                         0.0034171193);

final_score_18_c254 := map(
    NULL < r_i60_credit_seeking_i AND r_i60_credit_seeking_i <= 1.5 => final_score_18_c255,
    r_i60_credit_seeking_i > 1.5                                    => -0.0108759386,
    r_i60_credit_seeking_i = NULL                                   => -0.0108820779,
                                                                       -0.0011924706);

final_score_18 := map(
    NULL < f_add_input_nhood_mfd_pct_i AND f_add_input_nhood_mfd_pct_i <= 0.61044933105 => final_score_18_c254,
    f_add_input_nhood_mfd_pct_i > 0.61044933105                                         => 0.0118616639,
    f_add_input_nhood_mfd_pct_i = NULL                                                  => -0.0105941855,
                                                                                           0.0003165472);

final_score_19_c257 := map(
    NULL < k_comb_age_d AND k_comb_age_d <= 29.5 => 0.0063781314,
    k_comb_age_d > 29.5                          => -0.0101122050,
    k_comb_age_d = NULL                          => -0.0069942741,
                                                    -0.0069942741);

final_score_19_c258 := map(
    NULL < f_add_curr_nhood_mfd_pct_i AND f_add_curr_nhood_mfd_pct_i <= 0.5410906298 => 0.0034287188,
    f_add_curr_nhood_mfd_pct_i > 0.5410906298                                        => 0.0215921701,
    f_add_curr_nhood_mfd_pct_i = NULL                                                => -0.0024406689,
                                                                                        0.0065774993);

final_score_19 := map(
    NULL < f_idverrisktype_i AND f_idverrisktype_i <= 2 => final_score_19_c257,
    f_idverrisktype_i > 2                               => final_score_19_c258,
    f_idverrisktype_i = NULL                            => 0.0059395968,
                                                           -0.0009769043);

final_score_20_c260 := map(
    NULL < r_c23_inp_addr_occ_index_d AND r_c23_inp_addr_occ_index_d <= 2 => -0.0024383379,
    r_c23_inp_addr_occ_index_d > 2                                        => 0.0124902017,
    r_c23_inp_addr_occ_index_d = NULL                                     => 0.0051843784,
                                                                             0.0051843784);

final_score_20_c261 := map(
    NULL < f_phones_per_addr_curr_i AND f_phones_per_addr_curr_i <= 13.5 => -0.0104657615,
    f_phones_per_addr_curr_i > 13.5                                      => 0.0183448819,
    f_phones_per_addr_curr_i = NULL                                      => -0.0084761751,
                                                                            -0.0084761751);

final_score_20 := map(
    NULL < f_m_bureau_adl_fs_notu_d AND f_m_bureau_adl_fs_notu_d <= 235.5 => final_score_20_c260,
    f_m_bureau_adl_fs_notu_d > 235.5                                      => final_score_20_c261,
    f_m_bureau_adl_fs_notu_d = NULL                                       => 0.0056097191,
                                                                             -0.0010859000);

final_score_21_c263 := map(
    NULL < f_phones_per_addr_curr_i AND f_phones_per_addr_curr_i <= 3.5 => -0.0181251942,
    f_phones_per_addr_curr_i > 3.5                                      => 0.0002490901,
    f_phones_per_addr_curr_i = NULL                                     => -0.0097962866,
                                                                           -0.0097962866);

final_score_21_c264 := map(
    NULL < r_l71_add_business_i AND r_l71_add_business_i <= 0.5 => 0.0029275992,
    r_l71_add_business_i > 0.5                                  => 0.0303512611,
    r_l71_add_business_i = NULL                                 => 0.0040431780,
                                                                   0.0040431780);

final_score_21 := map(
    NULL < r_c14_addrs_10yr_i AND r_c14_addrs_10yr_i <= 1.5 => final_score_21_c263,
    r_c14_addrs_10yr_i > 1.5                                => final_score_21_c264,
    r_c14_addrs_10yr_i = NULL                               => 0.0025400980,
                                                               -0.0004777103);

final_score_22_c267 := map(
    NULL < r_i60_inq_comm_recency_d AND r_i60_inq_comm_recency_d <= 2 => -0.0143402332,
    r_i60_inq_comm_recency_d > 2                                      => -0.0011933410,
    r_i60_inq_comm_recency_d = NULL                                   => -0.0048837085,
                                                                         -0.0048837085);

final_score_22_c266 := map(
    NULL < f_phones_per_addr_curr_i AND f_phones_per_addr_curr_i <= 11.5 => final_score_22_c267,
    f_phones_per_addr_curr_i > 11.5                                      => 0.0147533109,
    f_phones_per_addr_curr_i = NULL                                      => -0.0101936555,
                                                                            -0.0029636495);

final_score_22 := map(
    NULL < k_comb_age_d AND k_comb_age_d <= 25.5 => 0.0174113975,
    k_comb_age_d > 25.5                          => final_score_22_c266,
    k_comb_age_d = NULL                          => -0.0007548575,
                                                    -0.0007548575);

final_score_23_c270 := map(
    NULL < f_srchfraudsrchcountyr_i AND f_srchfraudsrchcountyr_i <= 0.5 => -0.0068101782,
    f_srchfraudsrchcountyr_i > 0.5                                      => 0.0097359355,
    f_srchfraudsrchcountyr_i = NULL                                     => -0.0021375138,
                                                                           -0.0021375138);

final_score_23_c269 := map(
    NULL < r_i60_credit_seeking_i AND r_i60_credit_seeking_i <= 1.5 => final_score_23_c270,
    r_i60_credit_seeking_i > 1.5                                    => -0.0161916325,
    r_i60_credit_seeking_i = NULL                                   => -0.0077753467,
                                                                       -0.0064040339);

final_score_23 := map(
    NULL < k_comb_age_d AND k_comb_age_d <= 39.5 => 0.0059324526,
    k_comb_age_d > 39.5                          => final_score_23_c269,
    k_comb_age_d = NULL                          => -0.0009761408,
                                                    -0.0009761408);

final_score_24_c273 := map(
    NULL < f_addrchangevaluediff_d AND f_addrchangevaluediff_d <= 283329.5 => 0.0081112964,
    f_addrchangevaluediff_d > 283329.5                                     => 0.0408996901,
    f_addrchangevaluediff_d = NULL                                         => -0.0054515871,
                                                                              0.0020621025);

final_score_24_c272 := map(
    NULL < k_comb_age_d AND k_comb_age_d <= 31.5 => 0.0174335594,
    k_comb_age_d > 31.5                          => final_score_24_c273,
    k_comb_age_d = NULL                          => 0.0064884383,
                                                    0.0064884383);

final_score_24 := map(
    NULL < f_idverrisktype_i AND f_idverrisktype_i <= 2 => -0.0050846530,
    f_idverrisktype_i > 2                               => final_score_24_c272,
    f_idverrisktype_i = NULL                            => -0.0060681180,
                                                           -0.0001402085);

final_score_25_c276 := map(
    NULL < r_i60_credit_seeking_i AND r_i60_credit_seeking_i <= 1.5 => 0.0021891823,
    r_i60_credit_seeking_i > 1.5                                    => -0.0104743225,
    r_i60_credit_seeking_i = NULL                                   => 0.0062637741,
                                                                       -0.0014522129);

final_score_25_c275 := map(
    NULL < k_comb_age_d AND k_comb_age_d <= 26.5 => 0.0143856757,
    k_comb_age_d > 26.5                          => final_score_25_c276,
    k_comb_age_d = NULL                          => 0.0007183976,
                                                    0.0007183976);

final_score_25 := map(
    NULL < f_add_input_nhood_bus_pct_i AND f_add_input_nhood_bus_pct_i <= 0.27744305725 => final_score_25_c275,
    f_add_input_nhood_bus_pct_i > 0.27744305725                                         => 0.0164746131,
    f_add_input_nhood_bus_pct_i = NULL                                                  => -0.0247733978,
                                                                                           0.0001139091);

final_score_26_c279 := map(
    NULL < f_prevaddrcartheftindex_i AND f_prevaddrcartheftindex_i <= 142.5 => -0.0088146312,
    f_prevaddrcartheftindex_i > 142.5                                       => 0.0031539386,
    f_prevaddrcartheftindex_i = NULL                                        => -0.0030504076,
                                                                               -0.0030504076);

final_score_26_c278 := map(
    NULL < k_comb_age_d AND k_comb_age_d <= 26.5 => 0.0132318329,
    k_comb_age_d > 26.5                          => final_score_26_c279,
    k_comb_age_d = NULL                          => -0.0009417050,
                                                    -0.0009417050);

final_score_26 := map(
    NULL < f_phones_per_addr_curr_i AND f_phones_per_addr_curr_i <= 58.5 => final_score_26_c278,
    f_phones_per_addr_curr_i > 58.5                                      => 0.0480299598,
    f_phones_per_addr_curr_i = NULL                                      => -0.0034944326,
                                                                            -0.0003046843);

final_score_27_c281 := map(
    NULL < f_add_input_nhood_mfd_pct_i AND f_add_input_nhood_mfd_pct_i <= 0.70960589375 => -0.0074668654,
    f_add_input_nhood_mfd_pct_i > 0.70960589375                                         => 0.0097691188,
    f_add_input_nhood_mfd_pct_i = NULL                                                  => -0.0094656052,
                                                                                           -0.0050450282);

final_score_27_c282 := map(
    NULL < r_f03_address_match_d AND r_f03_address_match_d <= 3 => 0.0144634946,
    r_f03_address_match_d > 3                                   => -0.0001314560,
    r_f03_address_match_d = NULL                                => 0.0070826821,
                                                                   0.0070826821);

final_score_27 := map(
    NULL < f_inq_other_count24_i AND f_inq_other_count24_i <= 0.5 => final_score_27_c281,
    f_inq_other_count24_i > 0.5                                   => final_score_27_c282,
    f_inq_other_count24_i = NULL                                  => -0.0022602087,
                                                                     -0.0007230470);

final_score_28_c284 := map(
    NULL < f_add_input_nhood_mfd_pct_i AND f_add_input_nhood_mfd_pct_i <= 0.7086899197 => -0.0066355056,
    f_add_input_nhood_mfd_pct_i > 0.7086899197                                         => 0.0097478786,
    f_add_input_nhood_mfd_pct_i = NULL                                                 => -0.0124593021,
                                                                                          -0.0048275918);

final_score_28_c285 := map(
    NULL < f_phones_per_addr_curr_i AND f_phones_per_addr_curr_i <= 19.5 => 0.0070146505,
    f_phones_per_addr_curr_i > 19.5                                      => 0.0470226031,
    f_phones_per_addr_curr_i = NULL                                      => 0.0086801022,
                                                                            0.0086801022);

final_score_28 := map(
    NULL < f_inq_other_count24_i AND f_inq_other_count24_i <= 0.5 => final_score_28_c284,
    f_inq_other_count24_i > 0.5                                   => final_score_28_c285,
    f_inq_other_count24_i = NULL                                  => -0.0017944301,
                                                                     -0.0000407182);

final_score_29_c288 := map(
    NULL < f_add_input_nhood_vac_pct_i AND f_add_input_nhood_vac_pct_i <= 0.00071590645 => -0.0261232120,
    f_add_input_nhood_vac_pct_i > 0.00071590645                                         => 0.0112411199,
    f_add_input_nhood_vac_pct_i = NULL                                                  => -0.0049483290,
                                                                                           -0.0049483290);

final_score_29_c287 := map(
    NULL < f_add_curr_nhood_mfd_pct_i AND f_add_curr_nhood_mfd_pct_i <= 0.7268815015 => 0.0025176943,
    f_add_curr_nhood_mfd_pct_i > 0.7268815015                                        => 0.0179343639,
    f_add_curr_nhood_mfd_pct_i = NULL                                                => final_score_29_c288,
                                                                                        0.0038553912);

final_score_29 := map(
    NULL < r_i60_credit_seeking_i AND r_i60_credit_seeking_i <= 1.5 => final_score_29_c287,
    r_i60_credit_seeking_i > 1.5                                    => -0.0084065687,
    r_i60_credit_seeking_i = NULL                                   => -0.0007134367,
                                                                       0.0002580310);

final_score_30_c291 := map(
    NULL < k_inq_ssns_per_addr_i AND k_inq_ssns_per_addr_i <= 7.5 => 0.0077613682,
    k_inq_ssns_per_addr_i > 7.5                                   => 0.0718488272,
    k_inq_ssns_per_addr_i = NULL                                  => 0.0088145212,
                                                                     0.0088145212);

final_score_30_c290 := map(
    NULL < f_addrchangevaluediff_d AND f_addrchangevaluediff_d <= 213005.5 => final_score_30_c291,
    f_addrchangevaluediff_d > 213005.5                                     => 0.0505930978,
    f_addrchangevaluediff_d = NULL                                         => 0.0015516459,
                                                                              0.0065125065);

final_score_30 := map(
    NULL < r_f03_address_match_d AND r_f03_address_match_d <= 2.5 => final_score_30_c290,
    r_f03_address_match_d > 2.5                                   => -0.0054430504,
    r_f03_address_match_d = NULL                                  => 0.0042767463,
                                                                     0.0003399225);

final_score_31_c294 := map(
    NULL < f_srchunvrfdaddrcount_i AND f_srchunvrfdaddrcount_i <= 0.5 => 0.0002548722,
    f_srchunvrfdaddrcount_i > 0.5                                     => 0.0193132565,
    f_srchunvrfdaddrcount_i = NULL                                    => 0.0040051292,
                                                                         0.0040051292);

final_score_31_c293 := map(
    NULL < f_inq_other_count24_i AND f_inq_other_count24_i <= 0.5 => -0.0064387765,
    f_inq_other_count24_i > 0.5                                   => final_score_31_c294,
    f_inq_other_count24_i = NULL                                  => 0.0040278128,
                                                                     -0.0027358775);

final_score_31 := map(
    NULL < k_comb_age_d AND k_comb_age_d <= 26.5 => 0.0133539919,
    k_comb_age_d > 26.5                          => final_score_31_c293,
    k_comb_age_d = NULL                          => -0.0005934479,
                                                    -0.0005934479);

final_score_32_c296 := map(
    NULL < r_f01_inp_addr_address_score_d AND r_f01_inp_addr_address_score_d <= 16 => 0.0226096501,
    r_f01_inp_addr_address_score_d > 16                                            => 0.0049514779,
    r_f01_inp_addr_address_score_d = NULL                                          => 0.0325342474,
                                                                                      0.0089321347);

final_score_32_c297 := map(
    NULL < f_add_curr_nhood_bus_pct_i AND f_add_curr_nhood_bus_pct_i <= 0.01489374815 => -0.0000333761,
    f_add_curr_nhood_bus_pct_i > 0.01489374815                                        => 0.0100177670,
    f_add_curr_nhood_bus_pct_i = NULL                                                 => -0.0334564474,
                                                                                         -0.0054487587);

final_score_32 := map(
    NULL < f_add_input_nhood_mfd_pct_i AND f_add_input_nhood_mfd_pct_i <= 0.49232993315 => -0.0027542836,
    f_add_input_nhood_mfd_pct_i > 0.49232993315                                         => final_score_32_c296,
    f_add_input_nhood_mfd_pct_i = NULL                                                  => final_score_32_c297,
                                                                                           -0.0001231304);

final_score_33_c300 := map(
    NULL < f_phones_per_addr_curr_i AND f_phones_per_addr_curr_i <= 96.5 => 0.0069618574,
    f_phones_per_addr_curr_i > 96.5                                      => 0.0558612106,
    f_phones_per_addr_curr_i = NULL                                      => 0.0077454224,
                                                                            0.0077454224);

final_score_33_c299 := map(
    NULL < f_add_input_nhood_vac_pct_i AND f_add_input_nhood_vac_pct_i <= 0.00103334025 => -0.0135536738,
    f_add_input_nhood_vac_pct_i > 0.00103334025                                         => final_score_33_c300,
    f_add_input_nhood_vac_pct_i = NULL                                                  => 0.0047359268,
                                                                                           0.0047359268);

final_score_33 := map(
    NULL < r_f03_address_match_d AND r_f03_address_match_d <= 2.5 => final_score_33_c299,
    r_f03_address_match_d > 2.5                                   => -0.0067236839,
    r_f03_address_match_d = NULL                                  => -0.0009347679,
                                                                     -0.0012159691);

final_score_34_c303 := map(
    NULL < f_curraddrcartheftindex_i AND f_curraddrcartheftindex_i <= 51.5 => -0.0227245052,
    f_curraddrcartheftindex_i > 51.5                                       => 0.0116091782,
    f_curraddrcartheftindex_i = NULL                                       => -0.0041125192,
                                                                              -0.0041125192);

final_score_34_c302 := map(
    NULL < f_add_input_nhood_mfd_pct_i AND f_add_input_nhood_mfd_pct_i <= 0.4673224733 => 0.0013830623,
    f_add_input_nhood_mfd_pct_i > 0.4673224733                                         => 0.0117850404,
    f_add_input_nhood_mfd_pct_i = NULL                                                 => final_score_34_c303,
                                                                                          0.0038089031);

final_score_34 := map(
    NULL < r_e57_br_source_count_d AND r_e57_br_source_count_d <= 0.5 => final_score_34_c302,
    r_e57_br_source_count_d > 0.5                                     => -0.0084518182,
    r_e57_br_source_count_d = NULL                                    => 0.0068553124,
                                                                         0.0003470961);

final_score_35_c306 := map(
    NULL < r_f03_address_match_d AND r_f03_address_match_d <= 3 => 0.0150902092,
    r_f03_address_match_d > 3                                   => -0.0001421876,
    r_f03_address_match_d = NULL                                => 0.0085085776,
                                                                   0.0085085776);

final_score_35_c305 := map(
    NULL < f_varrisktype_i AND f_varrisktype_i <= 1.5 => -0.0027297360,
    f_varrisktype_i > 1.5                             => final_score_35_c306,
    f_varrisktype_i = NULL                            => 0.0013004192,
                                                         0.0013004192);

final_score_35 := map(
    NULL < r_i60_inq_comm_recency_d AND r_i60_inq_comm_recency_d <= 2 => -0.0103856117,
    r_i60_inq_comm_recency_d > 2                                      => final_score_35_c305,
    r_i60_inq_comm_recency_d = NULL                                   => 0.0016747059,
                                                                         -0.0018532080);

final_score_36_c309 := map(
    NULL < f_curraddrmedianvalue_d AND f_curraddrmedianvalue_d <= 284338.5 => -0.0050776137,
    f_curraddrmedianvalue_d > 284338.5                                     => 0.0154678097,
    f_curraddrmedianvalue_d = NULL                                         => -0.0020372490,
                                                                              -0.0020372490);

final_score_36_c308 := map(
    NULL < f_prevaddrcartheftindex_i AND f_prevaddrcartheftindex_i <= 145.5 => final_score_36_c309,
    f_prevaddrcartheftindex_i > 145.5                                       => 0.0096958860,
    f_prevaddrcartheftindex_i = NULL                                        => 0.0037385280,
                                                                               0.0037385280);

final_score_36 := map(
    NULL < r_e57_br_source_count_d AND r_e57_br_source_count_d <= 0.5 => final_score_36_c308,
    r_e57_br_source_count_d > 0.5                                     => -0.0094898039,
    r_e57_br_source_count_d = NULL                                    => 0.0012617928,
                                                                         -0.0000907379);

final_score_37_c312 := map(
    NULL < f_add_input_nhood_sfd_pct_d AND f_add_input_nhood_sfd_pct_d <= 0.11374547945 => 0.0111341731,
    f_add_input_nhood_sfd_pct_d > 0.11374547945                                         => -0.0023250998,
    f_add_input_nhood_sfd_pct_d = NULL                                                  => -0.0006247040,
                                                                                           -0.0006247040);

final_score_37_c311 := map(
    NULL < k_comb_age_d AND k_comb_age_d <= 23.5 => 0.0191783943,
    k_comb_age_d > 23.5                          => final_score_37_c312,
    k_comb_age_d = NULL                          => 0.0005849167,
                                                    0.0005849167);

final_score_37 := map(
    NULL < f_add_curr_nhood_vac_pct_i AND f_add_curr_nhood_vac_pct_i <= -0.5 => -0.0348176455,
    f_add_curr_nhood_vac_pct_i > -0.5                                        => final_score_37_c311,
    f_add_curr_nhood_vac_pct_i = NULL                                        => -0.0100021219,
                                                                                -0.0007248036);

final_score_38_c315 := map(
    NULL < f_add_curr_nhood_mfd_pct_i AND f_add_curr_nhood_mfd_pct_i <= 0.53927732615 => 0.0017437550,
    f_add_curr_nhood_mfd_pct_i > 0.53927732615                                        => 0.0148629901,
    f_add_curr_nhood_mfd_pct_i = NULL                                                 => -0.0034259558,
                                                                                         0.0038794165);

final_score_38_c314 := map(
    NULL < f_add_input_mobility_index_i AND f_add_input_mobility_index_i <= 0.5349864082 => final_score_38_c315,
    f_add_input_mobility_index_i > 0.5349864082                                          => 0.0308020666,
    f_add_input_mobility_index_i = NULL                                                  => 0.0053567082,
                                                                                            0.0053567082);

final_score_38 := map(
    NULL < r_f03_address_match_d AND r_f03_address_match_d <= 2.5 => final_score_38_c314,
    r_f03_address_match_d > 2.5                                   => -0.0046165146,
    r_f03_address_match_d = NULL                                  => 0.0046120473,
                                                                     0.0002136578);

final_score_39_c317 := map(
    NULL < k_comb_age_d AND k_comb_age_d <= 29.5 => 0.0054568225,
    k_comb_age_d > 29.5                          => -0.0094121679,
    k_comb_age_d = NULL                          => -0.0064830653,
                                                    -0.0064830653);

final_score_39_c318 := map(
    NULL < r_d32_criminal_count_i AND r_d32_criminal_count_i <= 4.5 => 0.0015361058,
    r_d32_criminal_count_i > 4.5                                    => 0.0170282946,
    r_d32_criminal_count_i = NULL                                   => 0.0038834470,
                                                                       0.0038834470);

final_score_39 := map(
    NULL < f_prevaddrcartheftindex_i AND f_prevaddrcartheftindex_i <= 142.5 => final_score_39_c317,
    f_prevaddrcartheftindex_i > 142.5                                       => final_score_39_c318,
    f_prevaddrcartheftindex_i = NULL                                        => 0.0007347985,
                                                                               -0.0014167591);

final_score_40_c321 := map(
    NULL < k_inq_ssns_per_addr_i AND k_inq_ssns_per_addr_i <= 1.5 => -0.0014460399,
    k_inq_ssns_per_addr_i > 1.5                                   => 0.0107480421,
    k_inq_ssns_per_addr_i = NULL                                  => 0.0009434851,
                                                                     0.0009434851);

final_score_40_c320 := map(
    NULL < r_i60_inq_comm_recency_d AND r_i60_inq_comm_recency_d <= 4.5 => -0.0100654505,
    r_i60_inq_comm_recency_d > 4.5                                      => final_score_40_c321,
    r_i60_inq_comm_recency_d = NULL                                     => -0.0023432641,
                                                                           -0.0023432641);

final_score_40 := map(
    NULL < f_varrisktype_i AND f_varrisktype_i <= 3.5 => final_score_40_c320,
    f_varrisktype_i > 3.5                             => 0.0119896446,
    f_varrisktype_i = NULL                            => -0.0043092659,
                                                         -0.0001156769);

final_score_41_c324 := map(
    NULL < f_add_input_nhood_bus_pct_i AND f_add_input_nhood_bus_pct_i <= 0.36401081655 => 0.0001101000,
    f_add_input_nhood_bus_pct_i > 0.36401081655                                         => 0.0254004090,
    f_add_input_nhood_bus_pct_i = NULL                                                  => -0.0254849152,
                                                                                           -0.0009604396);

final_score_41_c323 := map(
    NULL < f_m_bureau_adl_fs_all_d AND f_m_bureau_adl_fs_all_d <= 286.5 => final_score_41_c324,
    f_m_bureau_adl_fs_all_d > 286.5                                     => -0.0122969371,
    f_m_bureau_adl_fs_all_d = NULL                                      => -0.0051824430,
                                                                           -0.0051824430);

final_score_41 := map(
    NULL < f_inq_other_count24_i AND f_inq_other_count24_i <= 0.5 => final_score_41_c323,
    f_inq_other_count24_i > 0.5                                   => 0.0063997388,
    f_inq_other_count24_i = NULL                                  => 0.0026506740,
                                                                     -0.0010070997);

final_score_42_c327 := map(
    NULL < r_i60_inq_comm_recency_d AND r_i60_inq_comm_recency_d <= 2 => -0.0086611738,
    r_i60_inq_comm_recency_d > 2                                      => 0.0062437714,
    r_i60_inq_comm_recency_d = NULL                                   => 0.0024054809,
                                                                         0.0024054809);

final_score_42_c326 := map(
    NULL < f_add_input_nhood_bus_pct_i AND f_add_input_nhood_bus_pct_i <= 0.04723147455 => -0.0019217491,
    f_add_input_nhood_bus_pct_i > 0.04723147455                                         => final_score_42_c327,
    f_add_input_nhood_bus_pct_i = NULL                                                  => -0.0233272952,
                                                                                           -0.0009363371);

final_score_42 := map(
    NULL < f_attr_arrests_i AND f_attr_arrests_i <= 0.5 => final_score_42_c326,
    f_attr_arrests_i > 0.5                              => 0.0222946806,
    f_attr_arrests_i = NULL                             => -0.0045288986,
                                                           0.0003461235);

final_score_43_c330 := map(
    NULL < r_d32_mos_since_crim_ls_d AND r_d32_mos_since_crim_ls_d <= 142.5 => 0.0182931038,
    r_d32_mos_since_crim_ls_d > 142.5                                       => 0.0031391439,
    r_d32_mos_since_crim_ls_d = NULL                                        => 0.0071702619,
                                                                               0.0071702619);

final_score_43_c329 := map(
    NULL < f_rel_ageover40_count_d AND f_rel_ageover40_count_d <= 3.5 => final_score_43_c330,
    f_rel_ageover40_count_d > 3.5                                     => -0.0043002204,
    f_rel_ageover40_count_d = NULL                                    => 0.0127527978,
                                                                         0.0036715457);

final_score_43 := map(
    NULL < f_prevaddrcartheftindex_i AND f_prevaddrcartheftindex_i <= 108 => -0.0065003257,
    f_prevaddrcartheftindex_i > 108                                       => final_score_43_c329,
    f_prevaddrcartheftindex_i = NULL                                      => -0.0023887604,
                                                                             -0.0001173325);

final_score_44_c332 := map(
    NULL < f_vardobcountnew_i AND f_vardobcountnew_i <= 0.5 => -0.0059070601,
    f_vardobcountnew_i > 0.5                                => 0.0066076387,
    f_vardobcountnew_i = NULL                               => -0.0150844014,
                                                               -0.0029288888);

final_score_44_c333 := map(
    NULL < f_idverrisktype_i AND f_idverrisktype_i <= 5.5 => 0.0021737792,
    f_idverrisktype_i > 5.5                               => 0.0192912908,
    f_idverrisktype_i = NULL                              => 0.0224749824,
                                                             0.0062922169);

final_score_44 := map(
    NULL < f_add_input_nhood_mfd_pct_i AND f_add_input_nhood_mfd_pct_i <= 0.45148049055 => final_score_44_c332,
    f_add_input_nhood_mfd_pct_i > 0.45148049055                                         => final_score_44_c333,
    f_add_input_nhood_mfd_pct_i = NULL                                                  => -0.0075966033,
                                                                                           -0.0009007872);

final_score_45_c336 := map(
    NULL < f_add_curr_nhood_vac_pct_i AND f_add_curr_nhood_vac_pct_i <= 0.010338355 => -0.0191424827,
    f_add_curr_nhood_vac_pct_i > 0.010338355                                        => 0.0017310286,
    f_add_curr_nhood_vac_pct_i = NULL                                               => -0.0060926397,
                                                                                       -0.0060926397);

final_score_45_c335 := map(
    NULL < f_addrchangevaluediff_d AND f_addrchangevaluediff_d <= 15884 => -0.0024761621,
    f_addrchangevaluediff_d > 15884                                     => 0.0108960856,
    f_addrchangevaluediff_d = NULL                                      => final_score_45_c336,
                                                                           -0.0019733397);

final_score_45 := map(
    NULL < f_inq_other_count24_i AND f_inq_other_count24_i <= 1.5 => final_score_45_c335,
    f_inq_other_count24_i > 1.5                                   => 0.0115839553,
    f_inq_other_count24_i = NULL                                  => -0.0054654159,
                                                                     0.0001010872);

final_score_46_c339 := map(
    NULL < f_addrchangevaluediff_d AND f_addrchangevaluediff_d <= 188322 => -0.0000947861,
    f_addrchangevaluediff_d > 188322                                     => 0.0431216369,
    f_addrchangevaluediff_d = NULL                                       => -0.0009772713,
                                                                            0.0001613633);

final_score_46_c338 := map(
    NULL < f_phones_per_addr_curr_i AND f_phones_per_addr_curr_i <= 9.5 => final_score_46_c339,
    f_phones_per_addr_curr_i > 9.5                                      => 0.0152567031,
    f_phones_per_addr_curr_i = NULL                                     => 0.0024591666,
                                                                           0.0024591666);

final_score_46 := map(
    NULL < r_e57_br_source_count_d AND r_e57_br_source_count_d <= 0.5 => final_score_46_c338,
    r_e57_br_source_count_d > 0.5                                     => -0.0083227620,
    r_e57_br_source_count_d = NULL                                    => -0.0021830614,
                                                                         -0.0006827360);

final_score_47_c342 := map(
    NULL < k_comb_age_d AND k_comb_age_d <= 22.5 => 0.0248955471,
    k_comb_age_d > 22.5                          => -0.0015889046,
    k_comb_age_d = NULL                          => -0.0005051664,
                                                    -0.0005051664);

final_score_47_c341 := map(
    NULL < r_i60_credit_seeking_i AND r_i60_credit_seeking_i <= 1.5 => final_score_47_c342,
    r_i60_credit_seeking_i > 1.5                                    => -0.0130583419,
    r_i60_credit_seeking_i = NULL                                   => -0.0041548889,
                                                                       -0.0041548889);

final_score_47 := map(
    NULL < f_inq_other_count24_i AND f_inq_other_count24_i <= 0.5 => final_score_47_c341,
    f_inq_other_count24_i > 0.5                                   => 0.0069615714,
    f_inq_other_count24_i = NULL                                  => -0.0042259801,
                                                                     -0.0002359154);

final_score_48_c345 := map(
    NULL < f_hh_workers_paw_d AND f_hh_workers_paw_d <= 0.5 => 0.0066256642,
    f_hh_workers_paw_d > 0.5                                => -0.0049391693,
    f_hh_workers_paw_d = NULL                               => 0.0009467250,
                                                               0.0009467250);

final_score_48_c344 := map(
    NULL < f_add_input_mobility_index_i AND f_add_input_mobility_index_i <= 0.23418020345 => -0.0101677668,
    f_add_input_mobility_index_i > 0.23418020345                                          => final_score_48_c345,
    f_add_input_mobility_index_i = NULL                                                   => -0.0018961567,
                                                                                             -0.0018961567);

final_score_48 := map(
    NULL < f_curraddrmedianvalue_d AND f_curraddrmedianvalue_d <= 276490 => final_score_48_c344,
    f_curraddrmedianvalue_d > 276490                                     => 0.0121729638,
    f_curraddrmedianvalue_d = NULL                                       => -0.0067465768,
                                                                            -0.0000610375);

final_score_49_c348 := map(
    NULL < f_hh_workers_paw_d AND f_hh_workers_paw_d <= 0.5 => 0.0070276085,
    f_hh_workers_paw_d > 0.5                                => -0.0022254132,
    f_hh_workers_paw_d = NULL                               => 0.0025644002,
                                                               0.0025644002);

final_score_49_c347 := map(
    NULL < f_add_input_nhood_bus_pct_i AND f_add_input_nhood_bus_pct_i <= 0.27518535605 => final_score_49_c348,
    f_add_input_nhood_bus_pct_i > 0.27518535605                                         => 0.0197970040,
    f_add_input_nhood_bus_pct_i = NULL                                                  => -0.0167361930,
                                                                                           0.0021896298);

final_score_49 := map(
    NULL < r_i60_credit_seeking_i AND r_i60_credit_seeking_i <= 1.5 => final_score_49_c347,
    r_i60_credit_seeking_i > 1.5                                    => -0.0081335184,
    r_i60_credit_seeking_i = NULL                                   => -0.0037355228,
                                                                       -0.0008259358);

final_score_50_c351 := map(
    NULL < f_rel_homeover100_count_d AND f_rel_homeover100_count_d <= 12.5 => 0.0053847487,
    f_rel_homeover100_count_d > 12.5                                       => 0.0247707865,
    f_rel_homeover100_count_d = NULL                                       => 0.0128253329,
                                                                              0.0084468467);

final_score_50_c350 := map(
    NULL < k_comb_age_d AND k_comb_age_d <= 37.5 => final_score_50_c351,
    k_comb_age_d > 37.5                          => -0.0012107048,
    k_comb_age_d = NULL                          => 0.0027358352,
                                                    0.0027358352);

final_score_50 := map(
    NULL < r_i60_inq_comm_recency_d AND r_i60_inq_comm_recency_d <= 2 => -0.0085169062,
    r_i60_inq_comm_recency_d > 2                                      => final_score_50_c350,
    r_i60_inq_comm_recency_d = NULL                                   => -0.0007790463,
                                                                         -0.0003748161);

final_score_51_c353 := map(
    NULL < f_prevaddrmedianvalue_d AND f_prevaddrmedianvalue_d <= 288246.5 => -0.0050970246,
    f_prevaddrmedianvalue_d > 288246.5                                     => 0.0090170426,
    f_prevaddrmedianvalue_d = NULL                                         => -0.0032045392,
                                                                              -0.0032045392);

final_score_51_c354 := map(
    NULL < r_d32_mos_since_crim_ls_d AND r_d32_mos_since_crim_ls_d <= 120.5 => 0.0155226642,
    r_d32_mos_since_crim_ls_d > 120.5                                       => 0.0017444742,
    r_d32_mos_since_crim_ls_d = NULL                                        => 0.0060290203,
                                                                               0.0060290203);

final_score_51 := map(
    NULL < f_inq_other_count24_i AND f_inq_other_count24_i <= 0.5 => final_score_51_c353,
    f_inq_other_count24_i > 0.5                                   => final_score_51_c354,
    f_inq_other_count24_i = NULL                                  => -0.0007361923,
                                                                     0.0001065335);

final_score_52_c357 := map(
    NULL < f_add_input_nhood_bus_pct_i AND f_add_input_nhood_bus_pct_i <= 0.27516338955 => 0.0043562709,
    f_add_input_nhood_bus_pct_i > 0.27516338955                                         => 0.0388851619,
    f_add_input_nhood_bus_pct_i = NULL                                                  => 0.0238160453,
                                                                                           0.0061446452);

final_score_52_c356 := map(
    NULL < f_add_curr_nhood_mfd_pct_i AND f_add_curr_nhood_mfd_pct_i <= 0.40700596005 => -0.0037700708,
    f_add_curr_nhood_mfd_pct_i > 0.40700596005                                        => final_score_52_c357,
    f_add_curr_nhood_mfd_pct_i = NULL                                                 => -0.0071086227,
                                                                                         -0.0012718799);

final_score_52 := map(
    NULL < f_varrisktype_i AND f_varrisktype_i <= 4.5 => final_score_52_c356,
    f_varrisktype_i > 4.5                             => 0.0138950903,
    f_varrisktype_i = NULL                            => -0.0019747983,
                                                         0.0001104286);

final_score_53_c360 := map(
    NULL < r_i60_credit_seeking_i AND r_i60_credit_seeking_i <= 1.5 => -0.0019407302,
    r_i60_credit_seeking_i > 1.5                                    => -0.0130836333,
    r_i60_credit_seeking_i = NULL                                   => -0.0052184976,
                                                                       -0.0052184976);

final_score_53_c359 := map(
    NULL < k_inq_ssns_per_addr_i AND k_inq_ssns_per_addr_i <= 4.5 => final_score_53_c360,
    k_inq_ssns_per_addr_i > 4.5                                   => 0.0373873800,
    k_inq_ssns_per_addr_i = NULL                                  => -0.0046595975,
                                                                     -0.0046595975);

final_score_53 := map(
    NULL < f_phones_per_addr_curr_i AND f_phones_per_addr_curr_i <= 4.5 => final_score_53_c359,
    f_phones_per_addr_curr_i > 4.5                                      => 0.0055066345,
    f_phones_per_addr_curr_i = NULL                                     => -0.0007684273,
                                                                           -0.0001631321);

final_score_54_c362 := map(
    NULL < f_prevaddrmedianvalue_d AND f_prevaddrmedianvalue_d <= 383876.5 => -0.0039883157,
    f_prevaddrmedianvalue_d > 383876.5                                     => 0.0136848896,
    f_prevaddrmedianvalue_d = NULL                                         => -0.0028064621,
                                                                              -0.0028064621);

final_score_54_c363 := map(
    NULL < f_srchunvrfdaddrcount_i AND f_srchunvrfdaddrcount_i <= 0.5 => 0.0034280083,
    f_srchunvrfdaddrcount_i > 0.5                                     => 0.0174554286,
    f_srchunvrfdaddrcount_i = NULL                                    => 0.0063559053,
                                                                         0.0063559053);

final_score_54 := map(
    NULL < f_inq_other_count24_i AND f_inq_other_count24_i <= 0.5 => final_score_54_c362,
    f_inq_other_count24_i > 0.5                                   => final_score_54_c363,
    f_inq_other_count24_i = NULL                                  => -0.0017161434,
                                                                     0.0004517273);

final_score_55_c366 := map(
    NULL < f_add_curr_nhood_mfd_pct_i AND f_add_curr_nhood_mfd_pct_i <= 0.74187996225 => -0.0037518701,
    f_add_curr_nhood_mfd_pct_i > 0.74187996225                                        => 0.0082451246,
    f_add_curr_nhood_mfd_pct_i = NULL                                                 => -0.0074448595,
                                                                                         -0.0026850872);

final_score_55_c365 := map(
    NULL < k_comb_age_d AND k_comb_age_d <= 29.5 => 0.0070581117,
    k_comb_age_d > 29.5                          => final_score_55_c366,
    k_comb_age_d = NULL                          => -0.0006798294,
                                                    -0.0006798294);

final_score_55 := map(
    NULL < f_phones_per_addr_curr_i AND f_phones_per_addr_curr_i <= 61.5 => final_score_55_c365,
    f_phones_per_addr_curr_i > 61.5                                      => 0.0353949454,
    f_phones_per_addr_curr_i = NULL                                      => 0.0044696849,
                                                                            -0.0001764605);

final_score_56_c369 := map(
    NULL < r_c21_m_bureau_adl_fs_d AND r_c21_m_bureau_adl_fs_d <= 257.5 => 0.0073112808,
    r_c21_m_bureau_adl_fs_d > 257.5                                     => -0.0038050345,
    r_c21_m_bureau_adl_fs_d = NULL                                      => 0.0031535164,
                                                                           0.0031535164);

final_score_56_c368 := map(
    NULL < f_attr_arrests_i AND f_attr_arrests_i <= 0.5 => final_score_56_c369,
    f_attr_arrests_i > 0.5                              => 0.0259522181,
    f_attr_arrests_i = NULL                             => 0.0044778656,
                                                           0.0044778656);

final_score_56 := map(
    NULL < f_prevaddrcartheftindex_i AND f_prevaddrcartheftindex_i <= 142.5 => -0.0034269360,
    f_prevaddrcartheftindex_i > 142.5                                       => final_score_56_c368,
    f_prevaddrcartheftindex_i = NULL                                        => 0.0068321622,
                                                                               0.0004748357);

final_score_57_c372 := map(
    NULL < r_l80_inp_avm_autoval_d AND r_l80_inp_avm_autoval_d <= 32447 => 0.0151803681,
    r_l80_inp_avm_autoval_d > 32447                                     => -0.0046968045,
    r_l80_inp_avm_autoval_d = NULL                                      => 0.0049654867,
                                                                           0.0023373375);

final_score_57_c371 := map(
    NULL < f_phones_per_addr_curr_i AND f_phones_per_addr_curr_i <= 4.5 => -0.0064218520,
    f_phones_per_addr_curr_i > 4.5                                      => final_score_57_c372,
    f_phones_per_addr_curr_i = NULL                                     => -0.0026465174,
                                                                           -0.0026465174);

final_score_57 := map(
    NULL < f_varrisktype_i AND f_varrisktype_i <= 3.5 => final_score_57_c371,
    f_varrisktype_i > 3.5                             => 0.0093677319,
    f_varrisktype_i = NULL                            => 0.0056385622,
                                                         -0.0006501294);

final_score_58_c375 := map(
    NULL < f_curraddrcartheftindex_i AND f_curraddrcartheftindex_i <= 191.5 => -0.0051901359,
    f_curraddrcartheftindex_i > 191.5                                       => 0.0091871391,
    f_curraddrcartheftindex_i = NULL                                        => -0.0034038220,
                                                                               -0.0034038220);

final_score_58_c374 := map(
    NULL < f_add_input_nhood_mfd_pct_i AND f_add_input_nhood_mfd_pct_i <= 0.87431650515 => final_score_58_c375,
    f_add_input_nhood_mfd_pct_i > 0.87431650515                                         => 0.0124631667,
    f_add_input_nhood_mfd_pct_i = NULL                                                  => -0.0056764636,
                                                                                           -0.0023485960);

final_score_58 := map(
    NULL < r_d32_mos_since_crim_ls_d AND r_d32_mos_since_crim_ls_d <= 37.5 => 0.0108611952,
    r_d32_mos_since_crim_ls_d > 37.5                                       => final_score_58_c374,
    r_d32_mos_since_crim_ls_d = NULL                                       => -0.0048771444,
                                                                              -0.0006402841);

final_score_59_c378 := map(
    NULL < f_add_input_nhood_mfd_pct_i AND f_add_input_nhood_mfd_pct_i <= 0.5145227147 => -0.0010254921,
    f_add_input_nhood_mfd_pct_i > 0.5145227147                                         => 0.0104416527,
    f_add_input_nhood_mfd_pct_i = NULL                                                 => 0.0032808592,
                                                                                          0.0021248493);

final_score_59_c377 := map(
    NULL < k_comb_age_d AND k_comb_age_d <= 49.5 => final_score_59_c378,
    k_comb_age_d > 49.5                          => -0.0081391022,
    k_comb_age_d = NULL                          => -0.0018393658,
                                                    -0.0018393658);

final_score_59 := map(
    NULL < f_srchfraudsrchcountyr_i AND f_srchfraudsrchcountyr_i <= 2.5 => final_score_59_c377,
    f_srchfraudsrchcountyr_i > 2.5                                      => 0.0148775007,
    f_srchfraudsrchcountyr_i = NULL                                     => -0.0010681563,
                                                                           -0.0000616355);

final_score_60_c381 := map(
    NULL < f_phones_per_addr_curr_i AND f_phones_per_addr_curr_i <= 1.5 => -0.0217150941,
    f_phones_per_addr_curr_i > 1.5                                      => 0.0139575077,
    f_phones_per_addr_curr_i = NULL                                     => 0.0003975885,
                                                                           0.0003975885);

final_score_60_c380 := map(
    NULL < f_add_curr_nhood_mfd_pct_i AND f_add_curr_nhood_mfd_pct_i <= 0.94046396795 => 0.0047730577,
    f_add_curr_nhood_mfd_pct_i > 0.94046396795                                        => 0.0367466091,
    f_add_curr_nhood_mfd_pct_i = NULL                                                 => final_score_60_c381,
                                                                                         0.0052348390);

final_score_60 := map(
    NULL < f_idverrisktype_i AND f_idverrisktype_i <= 2 => -0.0028621387,
    f_idverrisktype_i > 2                               => final_score_60_c380,
    f_idverrisktype_i = NULL                            => -0.0035261084,
                                                           0.0006152265);

final_score_61_c384 := map(
    NULL < k_inq_ssns_per_addr_i AND k_inq_ssns_per_addr_i <= 1.5 => -0.0048787210,
    k_inq_ssns_per_addr_i > 1.5                                   => 0.0053016733,
    k_inq_ssns_per_addr_i = NULL                                  => -0.0022723026,
                                                                     -0.0022723026);

final_score_61_c383 := map(
    NULL < r_d32_criminal_count_i AND r_d32_criminal_count_i <= 4.5 => final_score_61_c384,
    r_d32_criminal_count_i > 4.5                                    => 0.0094936852,
    r_d32_criminal_count_i = NULL                                   => -0.0004782777,
                                                                       -0.0004782777);

final_score_61 := map(
    NULL < f_curraddrmedianvalue_d AND f_curraddrmedianvalue_d <= 423095 => final_score_61_c383,
    f_curraddrmedianvalue_d > 423095                                     => 0.0183552880,
    f_curraddrmedianvalue_d = NULL                                       => 0.0023066284,
                                                                            0.0004460508);

final_score_62_c387 := map(
    NULL < f_srchfraudsrchcountyr_i AND f_srchfraudsrchcountyr_i <= 2.5 => 0.0005717007,
    f_srchfraudsrchcountyr_i > 2.5                                      => 0.0133301321,
    f_srchfraudsrchcountyr_i = NULL                                     => 0.0015635115,
                                                                           0.0015635115);

final_score_62_c386 := map(
    NULL < r_l71_add_business_i AND r_l71_add_business_i <= 0.5 => final_score_62_c387,
    r_l71_add_business_i > 0.5                                  => 0.0227136283,
    r_l71_add_business_i = NULL                                 => 0.0024264632,
                                                                   0.0024264632);

final_score_62 := map(
    NULL < r_i60_inq_comm_recency_d AND r_i60_inq_comm_recency_d <= 2 => -0.0075955018,
    r_i60_inq_comm_recency_d > 2                                      => final_score_62_c386,
    r_i60_inq_comm_recency_d = NULL                                   => 0.0007893114,
                                                                         -0.0002895816);

final_score_63_c389 := map(
    NULL < f_add_input_nhood_mfd_pct_i AND f_add_input_nhood_mfd_pct_i <= 0.4924088369 => -0.0079113560,
    f_add_input_nhood_mfd_pct_i > 0.4924088369                                         => 0.0045123812,
    f_add_input_nhood_mfd_pct_i = NULL                                                 => -0.0089620707,
                                                                                          -0.0045191979);

final_score_63_c390 := map(
    NULL < f_addrchangeecontrajindex_d AND f_addrchangeecontrajindex_d <= 3.5 => 0.0025846268,
    f_addrchangeecontrajindex_d > 3.5                                         => 0.0227709160,
    f_addrchangeecontrajindex_d = NULL                                        => 0.0046151060,
                                                                                 0.0044020344);

final_score_63 := map(
    NULL < f_phones_per_addr_curr_i AND f_phones_per_addr_curr_i <= 4.5 => final_score_63_c389,
    f_phones_per_addr_curr_i > 4.5                                      => final_score_63_c390,
    f_phones_per_addr_curr_i = NULL                                     => -0.0051923730,
                                                                           -0.0006264235);

final_score_64_c393 := map(
    NULL < f_prevaddrcartheftindex_i AND f_prevaddrcartheftindex_i <= 186.5 => -0.0039865688,
    f_prevaddrcartheftindex_i > 186.5                                       => 0.0062787976,
    f_prevaddrcartheftindex_i = NULL                                        => -0.0022346207,
                                                                               -0.0022346207);

final_score_64_c392 := map(
    NULL < f_varrisktype_i AND f_varrisktype_i <= 4.5 => final_score_64_c393,
    f_varrisktype_i > 4.5                             => 0.0112860459,
    f_varrisktype_i = NULL                            => -0.0010070031,
                                                         -0.0010070031);

final_score_64 := map(
    NULL < f_phones_per_addr_curr_i AND f_phones_per_addr_curr_i <= 18.5 => final_score_64_c392,
    f_phones_per_addr_curr_i > 18.5                                      => 0.0193141850,
    f_phones_per_addr_curr_i = NULL                                      => 0.0015364923,
                                                                            -0.0001673897);

final_score_65_c396 := map(
    NULL < f_phones_per_addr_curr_i AND f_phones_per_addr_curr_i <= 3.5 => -0.0067123842,
    f_phones_per_addr_curr_i > 3.5                                      => 0.0012519930,
    f_phones_per_addr_curr_i = NULL                                     => -0.0025214897,
                                                                           -0.0025214897);

final_score_65_c395 := map(
    NULL < k_comb_age_d AND k_comb_age_d <= 26.5 => 0.0093004868,
    k_comb_age_d > 26.5                          => final_score_65_c396,
    k_comb_age_d = NULL                          => -0.0009918115,
                                                    -0.0009918115);

final_score_65 := map(
    NULL < f_attr_arrest_recency_d AND f_attr_arrest_recency_d <= 99.5 => 0.0201419806,
    f_attr_arrest_recency_d > 99.5                                     => final_score_65_c395,
    f_attr_arrest_recency_d = NULL                                     => -0.0061271075,
                                                                          0.0000739390);

final_score_66_c399 := map(
    NULL < r_i60_credit_seeking_i AND r_i60_credit_seeking_i <= 1.5 => -0.0008517918,
    r_i60_credit_seeking_i > 1.5                                    => -0.0113281855,
    r_i60_credit_seeking_i = NULL                                   => -0.0039421559,
                                                                       -0.0039421559);

final_score_66_c398 := map(
    NULL < f_curraddrmedianvalue_d AND f_curraddrmedianvalue_d <= 283313.5 => final_score_66_c399,
    f_curraddrmedianvalue_d > 283313.5                                     => 0.0088355587,
    f_curraddrmedianvalue_d = NULL                                         => -0.0022326117,
                                                                              -0.0022326117);

final_score_66 := map(
    NULL < f_inq_other_count24_i AND f_inq_other_count24_i <= 1.5 => final_score_66_c398,
    f_inq_other_count24_i > 1.5                                   => 0.0086645865,
    f_inq_other_count24_i = NULL                                  => 0.0046277352,
                                                                     -0.0004472753);

final_score_67_c401 := map(
    NULL < f_addrchangeincomediff_d AND f_addrchangeincomediff_d <= -40510 => 0.0229084410,
    f_addrchangeincomediff_d > -40510                                      => -0.0023190312,
    f_addrchangeincomediff_d = NULL                                        => -0.0007200335,
                                                                              -0.0015418297);

final_score_67_c402 := map(
    NULL < f_add_curr_nhood_bus_pct_i AND f_add_curr_nhood_bus_pct_i <= 0.1330073174 => 0.0108232593,
    f_add_curr_nhood_bus_pct_i > 0.1330073174                                        => -0.0168922773,
    f_add_curr_nhood_bus_pct_i = NULL                                                => -0.0149003322,
                                                                                        -0.0003714525);

final_score_67 := map(
    NULL < f_add_curr_nhood_mfd_pct_i AND f_add_curr_nhood_mfd_pct_i <= 0.91272289825 => final_score_67_c401,
    f_add_curr_nhood_mfd_pct_i > 0.91272289825                                        => 0.0143390134,
    f_add_curr_nhood_mfd_pct_i = NULL                                                 => final_score_67_c402,
                                                                                         -0.0005652318);

final_score_68_c405 := map(
    NULL < f_addrchangecrimediff_i AND f_addrchangecrimediff_i <= 4.5 => -0.0025672284,
    f_addrchangecrimediff_i > 4.5                                     => 0.0131810505,
    f_addrchangecrimediff_i = NULL                                    => -0.0013647009,
                                                                         -0.0006287763);

final_score_68_c404 := map(
    NULL < f_addrs_per_ssn_i AND f_addrs_per_ssn_i <= 11.5 => final_score_68_c405,
    f_addrs_per_ssn_i > 11.5                               => 0.0108791456,
    f_addrs_per_ssn_i = NULL                               => 0.0029276920,
                                                              0.0029276920);

final_score_68 := map(
    NULL < r_c18_invalid_addrs_per_adl_i AND r_c18_invalid_addrs_per_adl_i <= 2.5 => final_score_68_c404,
    r_c18_invalid_addrs_per_adl_i > 2.5                                           => -0.0054840620,
    r_c18_invalid_addrs_per_adl_i = NULL                                          => 0.0050667063,
                                                                                     0.0003793722);

final_score_69_c408 := map(
    NULL < r_i60_inq_comm_recency_d AND r_i60_inq_comm_recency_d <= 2 => -0.0199060877,
    r_i60_inq_comm_recency_d > 2                                      => -0.0017570812,
    r_i60_inq_comm_recency_d = NULL                                   => -0.0047575218,
                                                                         -0.0047575218);

final_score_69_c407 := map(
    NULL < f_varrisktype_i AND f_varrisktype_i <= 1.5 => final_score_69_c408,
    f_varrisktype_i > 1.5                             => 0.0032602811,
    f_varrisktype_i = NULL                            => -0.0011999007,
                                                         -0.0011999007);

final_score_69 := map(
    NULL < f_phones_per_addr_curr_i AND f_phones_per_addr_curr_i <= 95.5 => final_score_69_c407,
    f_phones_per_addr_curr_i > 95.5                                      => 0.0434949709,
    f_phones_per_addr_curr_i = NULL                                      => -0.0061503153,
                                                                            -0.0009697102);

final_score_70_c411 := map(
    NULL < f_add_input_nhood_mfd_pct_i AND f_add_input_nhood_mfd_pct_i <= 0.1437108118 => -0.0150838684,
    f_add_input_nhood_mfd_pct_i > 0.1437108118                                         => -0.0006780650,
    f_add_input_nhood_mfd_pct_i = NULL                                                 => -0.0111429886,
                                                                                          -0.0062658866);

final_score_70_c410 := map(
    NULL < f_phones_per_addr_curr_i AND f_phones_per_addr_curr_i <= 3.5 => final_score_70_c411,
    f_phones_per_addr_curr_i > 3.5                                      => 0.0028553396,
    f_phones_per_addr_curr_i = NULL                                     => -0.0037735281,
                                                                           -0.0014793006);

final_score_70 := map(
    NULL < k_comb_age_d AND k_comb_age_d <= 28.5 => 0.0079009029,
    k_comb_age_d > 28.5                          => final_score_70_c410,
    k_comb_age_d = NULL                          => 0.0002584540,
                                                    0.0002584540);

final_score_71_c413 := map(
    NULL < r_i60_credit_seeking_i AND r_i60_credit_seeking_i <= 1.5 => -0.0006500579,
    r_i60_credit_seeking_i > 1.5                                    => -0.0117687941,
    r_i60_credit_seeking_i = NULL                                   => -0.0038001392,
                                                                       -0.0038001392);

final_score_71_c414 := map(
    NULL < f_curraddrmedianincome_d AND f_curraddrmedianincome_d <= 22430.5 => 0.0185234226,
    f_curraddrmedianincome_d > 22430.5                                      => 0.0036580481,
    f_curraddrmedianincome_d = NULL                                         => 0.0055129920,
                                                                               0.0055129920);

final_score_71 := map(
    NULL < r_c14_addrs_5yr_i AND r_c14_addrs_5yr_i <= 1.5 => final_score_71_c413,
    r_c14_addrs_5yr_i > 1.5                               => final_score_71_c414,
    r_c14_addrs_5yr_i = NULL                              => -0.0002389923,
                                                             0.0001785307);

final_score_72_c416 := map(
    NULL < k_comb_age_d AND k_comb_age_d <= 23.5 => 0.0113833186,
    k_comb_age_d > 23.5                          => -0.0044347581,
    k_comb_age_d = NULL                          => -0.0028360226,
                                                    -0.0028360226);

final_score_72_c417 := map(
    NULL < r_e57_br_source_count_d AND r_e57_br_source_count_d <= 0.5 => 0.0101395925,
    r_e57_br_source_count_d > 0.5                                     => -0.0018626103,
    r_e57_br_source_count_d = NULL                                    => 0.0049532237,
                                                                         0.0049532237);

final_score_72 := map(
    NULL < f_addrs_per_ssn_i AND f_addrs_per_ssn_i <= 11.5 => final_score_72_c416,
    f_addrs_per_ssn_i > 11.5                               => final_score_72_c417,
    f_addrs_per_ssn_i = NULL                               => 0.0004129899,
                                                              0.0004129899);

final_score_73_c420 := map(
    NULL < f_add_curr_nhood_mfd_pct_i AND f_add_curr_nhood_mfd_pct_i <= 0.9045804252 => 0.0039722683,
    f_add_curr_nhood_mfd_pct_i > 0.9045804252                                        => 0.0264946322,
    f_add_curr_nhood_mfd_pct_i = NULL                                                => -0.0037758350,
                                                                                        0.0040712907);

final_score_73_c419 := map(
    NULL < r_f03_address_match_d AND r_f03_address_match_d <= 3 => final_score_73_c420,
    r_f03_address_match_d > 3                                   => -0.0038572709,
    r_f03_address_match_d = NULL                                => -0.0000648218,
                                                                   -0.0000648218);

final_score_73 := map(
    NULL < k_estimated_income_d AND k_estimated_income_d <= 21500 => 0.0236382109,
    k_estimated_income_d > 21500                                  => final_score_73_c419,
    k_estimated_income_d = NULL                                   => 0.0016106429,
                                                                     0.0006592436);

final_score_74_c422 := map(
    NULL < f_hh_members_w_derog_i AND f_hh_members_w_derog_i <= 0.5 => -0.0045582929,
    f_hh_members_w_derog_i > 0.5                                    => 0.0067039605,
    f_hh_members_w_derog_i = NULL                                   => 0.0037319175,
                                                                       0.0037319175);

final_score_74_c423 := map(
    NULL < f_phones_per_addr_curr_i AND f_phones_per_addr_curr_i <= 12.5 => -0.0063119736,
    f_phones_per_addr_curr_i > 12.5                                      => 0.0135294670,
    f_phones_per_addr_curr_i = NULL                                      => -0.0047666789,
                                                                            -0.0047666789);

final_score_74 := map(
    NULL < f_m_bureau_adl_fs_notu_d AND f_m_bureau_adl_fs_notu_d <= 239.5 => final_score_74_c422,
    f_m_bureau_adl_fs_notu_d > 239.5                                      => final_score_74_c423,
    f_m_bureau_adl_fs_notu_d = NULL                                       => 0.0018991932,
                                                                             -0.0001264665);

final_score_75_c426 := map(
    NULL < r_c19_add_prison_hist_i AND r_c19_add_prison_hist_i <= 0.5 => -0.0042757593,
    r_c19_add_prison_hist_i > 0.5                                     => 0.0250357090,
    r_c19_add_prison_hist_i = NULL                                    => -0.0037126701,
                                                                         -0.0037126701);

final_score_75_c425 := map(
    NULL < k_comb_age_d AND k_comb_age_d <= 29.5 => 0.0049978384,
    k_comb_age_d > 29.5                          => final_score_75_c426,
    k_comb_age_d = NULL                          => -0.0018968993,
                                                    -0.0018968993);

final_score_75 := map(
    NULL < f_attr_arrests_i AND f_attr_arrests_i <= 0.5 => final_score_75_c425,
    f_attr_arrests_i > 0.5                              => 0.0160567936,
    f_attr_arrests_i = NULL                             => -0.0037571096,
                                                           -0.0009076211);

final_score_76_c429 := map(
    NULL < f_rel_homeover300_count_d AND f_rel_homeover300_count_d <= 3.5 => 0.0005553936,
    f_rel_homeover300_count_d > 3.5                                       => 0.0188027392,
    f_rel_homeover300_count_d = NULL                                      => 0.0122232490,
                                                                             0.0025931678);

final_score_76_c428 := map(
    NULL < k_comb_age_d AND k_comb_age_d <= 33.5 => final_score_76_c429,
    k_comb_age_d > 33.5                          => -0.0050475237,
    k_comb_age_d = NULL                          => -0.0027444559,
                                                    -0.0027444559);

final_score_76 := map(
    NULL < f_attr_arrests_i AND f_attr_arrests_i <= 0.5 => final_score_76_c428,
    f_attr_arrests_i > 0.5                              => 0.0127641657,
    f_attr_arrests_i = NULL                             => 0.0061706093,
                                                           -0.0017728091);

final_score_77_c431 := map(
    NULL < f_addrchangevaluediff_d AND f_addrchangevaluediff_d <= 221906 => 0.0064458120,
    f_addrchangevaluediff_d > 221906                                     => 0.0453557381,
    f_addrchangevaluediff_d = NULL                                       => 0.0091818655,
                                                                            0.0086588516);

final_score_77_c432 := map(
    NULL < f_prevaddrcartheftindex_i AND f_prevaddrcartheftindex_i <= 124.5 => -0.0100675092,
    f_prevaddrcartheftindex_i > 124.5                                       => 0.0203404749,
    f_prevaddrcartheftindex_i = NULL                                        => -0.0019519411,
                                                                               -0.0019519411);

final_score_77 := map(
    NULL < f_add_input_nhood_mfd_pct_i AND f_add_input_nhood_mfd_pct_i <= 0.7796422038 => -0.0015324137,
    f_add_input_nhood_mfd_pct_i > 0.7796422038                                         => final_score_77_c431,
    f_add_input_nhood_mfd_pct_i = NULL                                                 => final_score_77_c432,
                                                                                          -0.0003667270);

final_score_78_c435 := map(
    NULL < f_add_curr_nhood_mfd_pct_i AND f_add_curr_nhood_mfd_pct_i <= 0.3752386132 => -0.0082405945,
    f_add_curr_nhood_mfd_pct_i > 0.3752386132                                        => 0.0027493151,
    f_add_curr_nhood_mfd_pct_i = NULL                                                => -0.0043790879,
                                                                                        -0.0050607828);

final_score_78_c434 := map(
    NULL < f_prevaddrcartheftindex_i AND f_prevaddrcartheftindex_i <= 152.5 => final_score_78_c435,
    f_prevaddrcartheftindex_i > 152.5                                       => 0.0028080912,
    f_prevaddrcartheftindex_i = NULL                                        => -0.0016781775,
                                                                               -0.0016781775);

final_score_78 := map(
    NULL < f_phones_per_addr_curr_i AND f_phones_per_addr_curr_i <= 96.5 => final_score_78_c434,
    f_phones_per_addr_curr_i > 96.5                                      => 0.0376057451,
    f_phones_per_addr_curr_i = NULL                                      => 0.0055099925,
                                                                            -0.0013286134);

final_score_79_c437 := map(
    NULL < k_comb_age_d AND k_comb_age_d <= 28.5 => 0.0044913827,
    k_comb_age_d > 28.5                          => -0.0054344019,
    k_comb_age_d = NULL                          => -0.0033544508,
                                                    -0.0033544508);

final_score_79_c438 := map(
    NULL < f_inq_other_count24_i AND f_inq_other_count24_i <= 1.5 => 0.0017739518,
    f_inq_other_count24_i > 1.5                                   => 0.0158731481,
    f_inq_other_count24_i = NULL                                  => 0.0043073047,
                                                                     0.0043073047);

final_score_79 := map(
    NULL < r_d32_criminal_count_i AND r_d32_criminal_count_i <= 0.5 => final_score_79_c437,
    r_d32_criminal_count_i > 0.5                                    => final_score_79_c438,
    r_d32_criminal_count_i = NULL                                   => 0.0024987517,
                                                                       -0.0004301498);

final_score_80_c441 := map(
    NULL < f_hh_workers_paw_d AND f_hh_workers_paw_d <= 0.5 => 0.0046914834,
    f_hh_workers_paw_d > 0.5                                => -0.0024426246,
    f_hh_workers_paw_d = NULL                               => 0.0012639577,
                                                               0.0012639577);

final_score_80_c440 := map(
    NULL < f_add_input_nhood_vac_pct_i AND f_add_input_nhood_vac_pct_i <= 0.0010314664 => -0.0087029227,
    f_add_input_nhood_vac_pct_i > 0.0010314664                                         => final_score_80_c441,
    f_add_input_nhood_vac_pct_i = NULL                                                 => -0.0002516280,
                                                                                          -0.0002516280);

final_score_80 := map(
    NULL < f_curraddrmedianvalue_d AND f_curraddrmedianvalue_d <= 430046.5 => final_score_80_c440,
    f_curraddrmedianvalue_d > 430046.5                                     => 0.0157480472,
    f_curraddrmedianvalue_d = NULL                                         => 0.0014484969,
                                                                              0.0004696696);

final_score_81_c444 := map(
    NULL < f_add_input_nhood_mfd_pct_i AND f_add_input_nhood_mfd_pct_i <= 0.19260122805 => -0.0004380508,
    f_add_input_nhood_mfd_pct_i > 0.19260122805                                         => 0.0063950724,
    f_add_input_nhood_mfd_pct_i = NULL                                                  => 0.0229602913,
                                                                                           0.0049957965);

final_score_81_c443 := map(
    NULL < k_inq_ssns_per_addr_i AND k_inq_ssns_per_addr_i <= 1.5 => -0.0030125131,
    k_inq_ssns_per_addr_i > 1.5                                   => final_score_81_c444,
    k_inq_ssns_per_addr_i = NULL                                  => -0.0008981887,
                                                                     -0.0008981887);

final_score_81 := map(
    NULL < r_l71_add_business_i AND r_l71_add_business_i <= 0.5 => final_score_81_c443,
    r_l71_add_business_i > 0.5                                  => 0.0138580101,
    r_l71_add_business_i = NULL                                 => -0.0003067857,
                                                                   -0.0003067857);

final_score_82_c446 := map(
    NULL < r_i60_credit_seeking_i AND r_i60_credit_seeking_i <= 1.5 => -0.0012953615,
    r_i60_credit_seeking_i > 1.5                                    => -0.0107844087,
    r_i60_credit_seeking_i = NULL                                   => -0.0040317766,
                                                                       -0.0040317766);

final_score_82_c447 := map(
    NULL < k_estimated_income_d AND k_estimated_income_d <= 22500 => 0.0322965219,
    k_estimated_income_d > 22500                                  => 0.0024325619,
    k_estimated_income_d = NULL                                   => 0.0038564395,
                                                                     0.0038564395);

final_score_82 := map(
    NULL < f_crim_rel_under25miles_cnt_i AND f_crim_rel_under25miles_cnt_i <= 2.5 => final_score_82_c446,
    f_crim_rel_under25miles_cnt_i > 2.5                                           => final_score_82_c447,
    f_crim_rel_under25miles_cnt_i = NULL                                          => 0.0013977511,
                                                                                     -0.0014234436);

final_score_83_c449 := map(
    NULL < k_inq_lnames_per_addr_i AND k_inq_lnames_per_addr_i <= 7.5 => -0.0008034861,
    k_inq_lnames_per_addr_i > 7.5                                     => 0.0395445642,
    k_inq_lnames_per_addr_i = NULL                                    => -0.0005343172,
                                                                         -0.0005343172);

final_score_83_c450 := map(
    NULL < f_addrchangecrimediff_i AND f_addrchangecrimediff_i <= -1 => 0.0281964674,
    f_addrchangecrimediff_i > -1                                     => 0.0051571541,
    f_addrchangecrimediff_i = NULL                                   => 0.0028638373,
                                                                        0.0100855166);

final_score_83 := map(
    NULL < f_prevaddrmurderindex_i AND f_prevaddrmurderindex_i <= 193.5 => final_score_83_c449,
    f_prevaddrmurderindex_i > 193.5                                     => final_score_83_c450,
    f_prevaddrmurderindex_i = NULL                                      => -0.0125013817,
                                                                           0.0001946591);

final_score_84_c453 := map(
    NULL < r_d32_mos_since_crim_ls_d AND r_d32_mos_since_crim_ls_d <= 52.5 => 0.0062602301,
    r_d32_mos_since_crim_ls_d > 52.5                                       => -0.0030688460,
    r_d32_mos_since_crim_ls_d = NULL                                       => -0.0016115979,
                                                                              -0.0016115979);

final_score_84_c452 := map(
    NULL < f_phones_per_addr_curr_i AND f_phones_per_addr_curr_i <= 83.5 => final_score_84_c453,
    f_phones_per_addr_curr_i > 83.5                                      => 0.0323921992,
    f_phones_per_addr_curr_i = NULL                                      => -0.0013261579,
                                                                            -0.0013261579);

final_score_84 := map(
    NULL < f_inq_other_count24_i AND f_inq_other_count24_i <= 2.5 => final_score_84_c452,
    f_inq_other_count24_i > 2.5                                   => 0.0137305041,
    f_inq_other_count24_i = NULL                                  => -0.0018341180,
                                                                     -0.0002191465);

final_score_85_c456 := map(
    NULL < r_c19_add_prison_hist_i AND r_c19_add_prison_hist_i <= 0.5 => -0.0016209255,
    r_c19_add_prison_hist_i > 0.5                                     => 0.0211908719,
    r_c19_add_prison_hist_i = NULL                                    => -0.0012189811,
                                                                         -0.0012189811);

final_score_85_c455 := map(
    NULL < r_d33_eviction_count_i AND r_d33_eviction_count_i <= 6.5 => final_score_85_c456,
    r_d33_eviction_count_i > 6.5                                    => 0.0200966596,
    r_d33_eviction_count_i = NULL                                   => -0.0004781501,
                                                                       -0.0007781896);

final_score_85 := map(
    NULL < k_inq_ssns_per_addr_i AND k_inq_ssns_per_addr_i <= 6.5 => final_score_85_c455,
    k_inq_ssns_per_addr_i > 6.5                                   => 0.0312682942,
    k_inq_ssns_per_addr_i = NULL                                  => -0.0004489449,
                                                                     -0.0004489449);

final_score_86_c459 := map(
    NULL < f_srchcomponentrisktype_i AND f_srchcomponentrisktype_i <= 1.5 => 0.0008898191,
    f_srchcomponentrisktype_i > 1.5                                       => 0.0142117706,
    f_srchcomponentrisktype_i = NULL                                      => 0.0023443763,
                                                                             0.0023443763);

final_score_86_c458 := map(
    NULL < r_i60_inq_comm_recency_d AND r_i60_inq_comm_recency_d <= 4.5 => -0.0061910751,
    r_i60_inq_comm_recency_d > 4.5                                      => final_score_86_c459,
    r_i60_inq_comm_recency_d = NULL                                     => -0.0004254405,
                                                                           -0.0004254405);

final_score_86 := map(
    NULL < f_varrisktype_i AND f_varrisktype_i <= 5.5 => final_score_86_c458,
    f_varrisktype_i > 5.5                             => 0.0156293885,
    f_varrisktype_i = NULL                            => 0.0036770294,
                                                         0.0004868960);

final_score_87_c461 := map(
    NULL < f_crim_rel_under25miles_cnt_i AND f_crim_rel_under25miles_cnt_i <= 10.5 => 0.0035483124,
    f_crim_rel_under25miles_cnt_i > 10.5                                           => 0.0325124312,
    f_crim_rel_under25miles_cnt_i = NULL                                           => 0.0103953521,
                                                                                      0.0046142625);

final_score_87_c462 := map(
    NULL < f_add_input_nhood_mfd_pct_i AND f_add_input_nhood_mfd_pct_i <= 0.532957498 => -0.0025779764,
    f_add_input_nhood_mfd_pct_i > 0.532957498                                         => 0.0356977712,
    f_add_input_nhood_mfd_pct_i = NULL                                                => 0.0136644995,
                                                                                         0.0136644995);

final_score_87 := map(
    NULL < f_hh_workers_paw_d AND f_hh_workers_paw_d <= 0.5 => final_score_87_c461,
    f_hh_workers_paw_d > 0.5                                => -0.0042769754,
    f_hh_workers_paw_d = NULL                               => final_score_87_c462,
                                                               0.0004229744);

final_score_88_c465 := map(
    NULL < r_a49_curr_avm_chg_1yr_pct_i AND r_a49_curr_avm_chg_1yr_pct_i <= 95.15 => -0.0019756393,
    r_a49_curr_avm_chg_1yr_pct_i > 95.15                                          => 0.0194974533,
    r_a49_curr_avm_chg_1yr_pct_i = NULL                                           => -0.0004123515,
                                                                                     0.0013983175);

final_score_88_c464 := map(
    NULL < r_l80_inp_avm_autoval_d AND r_l80_inp_avm_autoval_d <= 12025.5 => 0.0503338495,
    r_l80_inp_avm_autoval_d > 12025.5                                     => 0.0051895025,
    r_l80_inp_avm_autoval_d = NULL                                        => final_score_88_c465,
                                                                             0.0031044471);

final_score_88 := map(
    NULL < f_varrisktype_i AND f_varrisktype_i <= 1.5 => -0.0042108082,
    f_varrisktype_i > 1.5                             => final_score_88_c464,
    f_varrisktype_i = NULL                            => 0.0090583746,
                                                         -0.0008503579);

final_score_89_c468 := map(
    NULL < f_add_input_nhood_mfd_pct_i AND f_add_input_nhood_mfd_pct_i <= 0.287881705 => -0.0275034920,
    f_add_input_nhood_mfd_pct_i > 0.287881705                                         => 0.0254965454,
    f_add_input_nhood_mfd_pct_i = NULL                                                => 0.0034677233,
                                                                                         0.0034677233);

final_score_89_c467 := map(
    NULL < r_d32_mos_since_crim_ls_d AND r_d32_mos_since_crim_ls_d <= 21.5 => 0.0102035402,
    r_d32_mos_since_crim_ls_d > 21.5                                       => -0.0011740005,
    r_d32_mos_since_crim_ls_d = NULL                                       => final_score_89_c468,
                                                                              -0.0001144389);

final_score_89 := map(
    NULL < r_l72_add_vacant_i AND r_l72_add_vacant_i <= 0.5 => final_score_89_c467,
    r_l72_add_vacant_i > 0.5                                => 0.0223279748,
    r_l72_add_vacant_i = NULL                               => 0.0003311703,
                                                               0.0003311703);

final_score_90_c470 := map(
    NULL < f_prevaddrmedianvalue_d AND f_prevaddrmedianvalue_d <= 362231 => -0.0045683817,
    f_prevaddrmedianvalue_d > 362231                                     => 0.0120713346,
    f_prevaddrmedianvalue_d = NULL                                       => -0.0032236367,
                                                                            -0.0032236367);

final_score_90_c471 := map(
    NULL < k_estimated_income_d AND k_estimated_income_d <= 25500 => 0.0145851894,
    k_estimated_income_d > 25500                                  => 0.0015641459,
    k_estimated_income_d = NULL                                   => 0.0037234334,
                                                                     0.0037234334);

final_score_90 := map(
    NULL < f_prevaddrcartheftindex_i AND f_prevaddrcartheftindex_i <= 151.5 => final_score_90_c470,
    f_prevaddrcartheftindex_i > 151.5                                       => final_score_90_c471,
    f_prevaddrcartheftindex_i = NULL                                        => 0.0034248377,
                                                                               -0.0001987660);

final_score_91_c474 := map(
    NULL < f_inq_count24_i AND f_inq_count24_i <= 3.5 => -0.0023800394,
    f_inq_count24_i > 3.5                             => 0.0075654991,
    f_inq_count24_i = NULL                            => 0.0006230772,
                                                         0.0006230772);

final_score_91_c473 := map(
    NULL < f_curraddrcartheftindex_i AND f_curraddrcartheftindex_i <= 88.5 => -0.0078579432,
    f_curraddrcartheftindex_i > 88.5                                       => final_score_91_c474,
    f_curraddrcartheftindex_i = NULL                                       => -0.0019127994,
                                                                              -0.0019127994);

final_score_91 := map(
    NULL < f_curraddrmedianvalue_d AND f_curraddrmedianvalue_d <= 321298.5 => final_score_91_c473,
    f_curraddrmedianvalue_d > 321298.5                                     => 0.0097597422,
    f_curraddrmedianvalue_d = NULL                                         => 0.0068710968,
                                                                              -0.0006180229);

final_score_92_c477 := map(
    NULL < r_c14_addr_stability_v2_d AND r_c14_addr_stability_v2_d <= 2.5 => 0.0096198851,
    r_c14_addr_stability_v2_d > 2.5                                       => 0.0020689957,
    r_c14_addr_stability_v2_d = NULL                                      => 0.0043072115,
                                                                             0.0043072115);

final_score_92_c476 := map(
    NULL < f_hh_workers_paw_d AND f_hh_workers_paw_d <= 0.5 => final_score_92_c477,
    f_hh_workers_paw_d > 0.5                                => -0.0030628797,
    f_hh_workers_paw_d = NULL                               => 0.0020031273,
                                                               0.0006999692);

final_score_92 := map(
    NULL < f_add_input_nhood_bus_pct_i AND f_add_input_nhood_bus_pct_i <= 0.47678224955 => final_score_92_c476,
    f_add_input_nhood_bus_pct_i > 0.47678224955                                         => 0.0278671364,
    f_add_input_nhood_bus_pct_i = NULL                                                  => -0.0153285059,
                                                                                           0.0001116981);

final_score_93_c480 := map(
    NULL < f_rel_ageover40_count_d AND f_rel_ageover40_count_d <= 4.5 => 0.0073529066,
    f_rel_ageover40_count_d > 4.5                                     => -0.0016160874,
    f_rel_ageover40_count_d = NULL                                    => 0.0031707358,
                                                                         0.0045767427);

final_score_93_c479 := map(
    NULL < f_addrs_per_ssn_i AND f_addrs_per_ssn_i <= 6.5 => -0.0045143672,
    f_addrs_per_ssn_i > 6.5                               => final_score_93_c480,
    f_addrs_per_ssn_i = NULL                              => 0.0014316027,
                                                             0.0014316027);

final_score_93 := map(
    NULL < r_c18_invalid_addrs_per_adl_i AND r_c18_invalid_addrs_per_adl_i <= 3.5 => final_score_93_c479,
    r_c18_invalid_addrs_per_adl_i > 3.5                                           => -0.0081672641,
    r_c18_invalid_addrs_per_adl_i = NULL                                          => 0.0058428399,
                                                                                     -0.0004575148);

final_score_94_c482 := map(
    NULL < r_i60_credit_seeking_i AND r_i60_credit_seeking_i <= 1.5 => 0.0014281400,
    r_i60_credit_seeking_i > 1.5                                    => -0.0056594168,
    r_i60_credit_seeking_i = NULL                                   => -0.0006247949,
                                                                       -0.0006247949);

final_score_94_c483 := map(
    NULL < f_inq_communications_count24_i AND f_inq_communications_count24_i <= 4.5 => 0.0106508956,
    f_inq_communications_count24_i > 4.5                                            => 0.0547135905,
    f_inq_communications_count24_i = NULL                                           => 0.0161292157,
                                                                                       0.0161292157);

final_score_94 := map(
    NULL < f_phones_per_addr_curr_i AND f_phones_per_addr_curr_i <= 18.5 => final_score_94_c482,
    f_phones_per_addr_curr_i > 18.5                                      => final_score_94_c483,
    f_phones_per_addr_curr_i = NULL                                      => -0.0039164968,
                                                                            -0.0000293741);

final_score_95_c485 := map(
    NULL < f_phones_per_addr_curr_i AND f_phones_per_addr_curr_i <= 61.5 => -0.0033727760,
    f_phones_per_addr_curr_i > 61.5                                      => 0.0223162490,
    f_phones_per_addr_curr_i = NULL                                      => 0.0067595583,
                                                                            -0.0028121246);

final_score_95_c486 := map(
    NULL < f_curraddrmedianincome_d AND f_curraddrmedianincome_d <= 91099 => 0.0052305027,
    f_curraddrmedianincome_d > 91099                                      => 0.0374114419,
    f_curraddrmedianincome_d = NULL                                       => 0.0060628121,
                                                                             0.0060628121);

final_score_95 := map(
    NULL < k_inq_adls_per_addr_i AND k_inq_adls_per_addr_i <= 1.5 => final_score_95_c485,
    k_inq_adls_per_addr_i > 1.5                                   => final_score_95_c486,
    k_inq_adls_per_addr_i = NULL                                  => -0.0004877364,
                                                                     -0.0004877364);

final_score_96_c489 := map(
    NULL < f_addrchangevaluediff_d AND f_addrchangevaluediff_d <= 67451 => -0.0026606607,
    f_addrchangevaluediff_d > 67451                                     => 0.0151005156,
    f_addrchangevaluediff_d = NULL                                      => -0.0043993059,
                                                                           -0.0023337982);

final_score_96_c488 := map(
    NULL < r_i60_inq_prepaidcards_recency_d AND r_i60_inq_prepaidcards_recency_d <= 549 => 0.0075915608,
    r_i60_inq_prepaidcards_recency_d > 549                                              => final_score_96_c489,
    r_i60_inq_prepaidcards_recency_d = NULL                                             => -0.0006049513,
                                                                                           -0.0006049513);

final_score_96 := map(
    NULL < f_curraddrcartheftindex_i AND f_curraddrcartheftindex_i <= 190.5 => final_score_96_c488,
    f_curraddrcartheftindex_i > 190.5                                       => 0.0098235563,
    f_curraddrcartheftindex_i = NULL                                        => 0.0126948499,
                                                                               0.0007428381);

final_score_97_c492 := map(
    NULL < f_fp_prevaddrburglaryindex_i AND f_fp_prevaddrburglaryindex_i <= 161.5 => 0.0006402679,
    f_fp_prevaddrburglaryindex_i > 161.5                                          => 0.0478339111,
    f_fp_prevaddrburglaryindex_i = NULL                                           => 0.0069287610,
                                                                                     0.0069287610);

final_score_97_c491 := map(
    NULL < f_rel_under25miles_cnt_d AND f_rel_under25miles_cnt_d <= 2.5 => 0.0085224420,
    f_rel_under25miles_cnt_d > 2.5                                      => -0.0003963583,
    f_rel_under25miles_cnt_d = NULL                                     => final_score_97_c492,
                                                                           0.0015762295);

final_score_97 := map(
    NULL < r_i60_inq_comm_recency_d AND r_i60_inq_comm_recency_d <= 2 => -0.0058605210,
    r_i60_inq_comm_recency_d > 2                                      => final_score_97_c491,
    r_i60_inq_comm_recency_d = NULL                                   => -0.0020118964,
                                                                         -0.0004477763);

final_score_98_c495 := map(
    NULL < f_rel_ageover40_count_d AND f_rel_ageover40_count_d <= 2.5 => 0.0122135202,
    f_rel_ageover40_count_d > 2.5                                     => -0.0070106482,
    f_rel_ageover40_count_d = NULL                                    => 0.0002699425,
                                                                         0.0002699425);

final_score_98_c494 := map(
    NULL < f_add_input_mobility_index_i AND f_add_input_mobility_index_i <= 0.3499272358 => final_score_98_c495,
    f_add_input_mobility_index_i > 0.3499272358                                          => 0.0247178544,
    f_add_input_mobility_index_i = NULL                                                  => 0.0076954131,
                                                                                            0.0076954131);

final_score_98 := map(
    NULL < r_d32_criminal_count_i AND r_d32_criminal_count_i <= 7.5 => -0.0021861805,
    r_d32_criminal_count_i > 7.5                                    => final_score_98_c494,
    r_d32_criminal_count_i = NULL                                   => -0.0008480771,
                                                                       -0.0012344679);

final_score_99_c498 := map(
    NULL < f_add_input_nhood_sfd_pct_d AND f_add_input_nhood_sfd_pct_d <= 0.0615128096 => 0.0329167399,
    f_add_input_nhood_sfd_pct_d > 0.0615128096                                         => -0.0047252402,
    f_add_input_nhood_sfd_pct_d = NULL                                                 => -0.0042272816,
                                                                                          -0.0042272816);

final_score_99_c497 := map(
    NULL < f_prevaddrmedianincome_d AND f_prevaddrmedianincome_d <= 33797 => 0.0038186795,
    f_prevaddrmedianincome_d > 33797                                      => final_score_99_c498,
    f_prevaddrmedianincome_d = NULL                                       => -0.0055219076,
                                                                             -0.0013838229);

final_score_99 := map(
    NULL < f_add_input_nhood_mfd_pct_i AND f_add_input_nhood_mfd_pct_i <= 0.8094468805 => final_score_99_c497,
    f_add_input_nhood_mfd_pct_i > 0.8094468805                                         => 0.0075736967,
    f_add_input_nhood_mfd_pct_i = NULL                                                 => 0.0013827589,
                                                                                          -0.0001401663);

final_score_100_c501 := map(
    NULL < r_a46_curr_avm_autoval_d AND r_a46_curr_avm_autoval_d <= 19087.5 => 0.0317344763,
    r_a46_curr_avm_autoval_d > 19087.5                                      => 0.0058107225,
    r_a46_curr_avm_autoval_d = NULL                                         => -0.0063387721,
                                                                               -0.0018029844);

final_score_100_c500 := map(
    NULL < f_addrchangevaluediff_d AND f_addrchangevaluediff_d <= 178170.5 => -0.0011568045,
    f_addrchangevaluediff_d > 178170.5                                     => 0.0245967898,
    f_addrchangevaluediff_d = NULL                                         => final_score_100_c501,
                                                                              -0.0009236869);

final_score_100 := map(
    NULL < r_c14_addrs_5yr_i AND r_c14_addrs_5yr_i <= 3.5 => final_score_100_c500,
    r_c14_addrs_5yr_i > 3.5                               => 0.0081401765,
    r_c14_addrs_5yr_i = NULL                              => 0.0013076066,
                                                             0.0003538249);

final_score_101_c503 := map(
    NULL < f_prevaddrmedianvalue_d AND f_prevaddrmedianvalue_d <= 237431.5 => -0.0053599620,
    f_prevaddrmedianvalue_d > 237431.5                                     => 0.0049241570,
    f_prevaddrmedianvalue_d = NULL                                         => -0.0019408252,
                                                                              -0.0032910189);

final_score_101_c504 := map(
    NULL < r_c21_m_bureau_adl_fs_d AND r_c21_m_bureau_adl_fs_d <= 223.5 => 0.0102438651,
    r_c21_m_bureau_adl_fs_d > 223.5                                     => -0.0006076904,
    r_c21_m_bureau_adl_fs_d = NULL                                      => 0.0035245632,
                                                                           0.0035245632);

final_score_101 := map(
    NULL < f_addrs_per_ssn_i AND f_addrs_per_ssn_i <= 11.5 => final_score_101_c503,
    f_addrs_per_ssn_i > 11.5                               => final_score_101_c504,
    f_addrs_per_ssn_i = NULL                               => -0.0004575840,
                                                              -0.0004575840);

final_score_102_c507 := map(
    NULL < f_add_input_mobility_index_i AND f_add_input_mobility_index_i <= 0.5729427568 => -0.0011016838,
    f_add_input_mobility_index_i > 0.5729427568                                          => 0.0153002394,
    f_add_input_mobility_index_i = NULL                                                  => -0.0005212504,
                                                                                            -0.0005212504);

final_score_102_c506 := map(
    NULL < k_inq_ssns_per_addr_i AND k_inq_ssns_per_addr_i <= 4.5 => final_score_102_c507,
    k_inq_ssns_per_addr_i > 4.5                                   => 0.0177027094,
    k_inq_ssns_per_addr_i = NULL                                  => -0.0000205837,
                                                                     -0.0000205837);

final_score_102 := map(
    NULL < f_prevaddrmedianvalue_d AND f_prevaddrmedianvalue_d <= 473553 => final_score_102_c506,
    f_prevaddrmedianvalue_d > 473553                                     => 0.0176338311,
    f_prevaddrmedianvalue_d = NULL                                       => -0.0050268164,
                                                                            0.0004200880);

final_score_103_c510 := map(
    NULL < r_l72_add_vacant_i AND r_l72_add_vacant_i <= 0.5 => -0.0010520829,
    r_l72_add_vacant_i > 0.5                                => 0.0230731484,
    r_l72_add_vacant_i = NULL                               => -0.0004540259,
                                                               -0.0004540259);

final_score_103_c509 := map(
    NULL < f_phones_per_addr_curr_i AND f_phones_per_addr_curr_i <= 6.5 => final_score_103_c510,
    f_phones_per_addr_curr_i > 6.5                                      => 0.0072844769,
    f_phones_per_addr_curr_i = NULL                                     => -0.0021822822,
                                                                           0.0019178049);

final_score_103 := map(
    NULL < k_comb_age_d AND k_comb_age_d <= 51.5 => final_score_103_c509,
    k_comb_age_d > 51.5                          => -0.0061502026,
    k_comb_age_d = NULL                          => -0.0007297567,
                                                    -0.0007297567);

final_score_104_c513 := map(
    NULL < f_addrchangeecontrajindex_d AND f_addrchangeecontrajindex_d <= 3.5 => -0.0023008770,
    f_addrchangeecontrajindex_d > 3.5                                         => 0.0118252459,
    f_addrchangeecontrajindex_d = NULL                                        => -0.0010487349,
                                                                                 -0.0012057678);

final_score_104_c512 := map(
    NULL < f_curraddrcartheftindex_i AND f_curraddrcartheftindex_i <= 191.5 => final_score_104_c513,
    f_curraddrcartheftindex_i > 191.5                                       => 0.0080960211,
    f_curraddrcartheftindex_i = NULL                                        => -0.0039763300,
                                                                               -0.0001948018);

final_score_104 := map(
    NULL < k_inq_ssns_per_addr_i AND k_inq_ssns_per_addr_i <= 6.5 => final_score_104_c512,
    k_inq_ssns_per_addr_i > 6.5                                   => 0.0283708223,
    k_inq_ssns_per_addr_i = NULL                                  => 0.0000812114,
                                                                     0.0000812114);

final_score_105_c516 := map(
    NULL < f_rel_felony_count_i AND f_rel_felony_count_i <= 4.5 => -0.0028278759,
    f_rel_felony_count_i > 4.5                                  => 0.0372588746,
    f_rel_felony_count_i = NULL                                 => 0.0088583553,
                                                                   -0.0008094147);

final_score_105_c515 := map(
    NULL < f_addrchangeecontrajindex_d AND f_addrchangeecontrajindex_d <= 3.5 => -0.0028279558,
    f_addrchangeecontrajindex_d > 3.5                                         => 0.0152615120,
    f_addrchangeecontrajindex_d = NULL                                        => final_score_105_c516,
                                                                                 -0.0014167618);

final_score_105 := map(
    NULL < k_inq_ssns_per_addr_i AND k_inq_ssns_per_addr_i <= 1.5 => final_score_105_c515,
    k_inq_ssns_per_addr_i > 1.5                                   => 0.0053317859,
    k_inq_ssns_per_addr_i = NULL                                  => 0.0003364079,
                                                                     0.0003364079);

final_score_106_c519 := map(
    NULL < k_estimated_income_d AND k_estimated_income_d <= 38500 => -0.0017921412,
    k_estimated_income_d > 38500                                  => 0.0326089718,
    k_estimated_income_d = NULL                                   => 0.0071545234,
                                                                     0.0071545234);

final_score_106_c518 := map(
    NULL < f_rel_under25miles_cnt_d AND f_rel_under25miles_cnt_d <= 15.5 => -0.0029006247,
    f_rel_under25miles_cnt_d > 15.5                                      => 0.0054532359,
    f_rel_under25miles_cnt_d = NULL                                      => final_score_106_c519,
                                                                            -0.0013212648);

final_score_106 := map(
    NULL < f_prevaddrcartheftindex_i AND f_prevaddrcartheftindex_i <= 191.5 => final_score_106_c518,
    f_prevaddrcartheftindex_i > 191.5                                       => 0.0084179695,
    f_prevaddrcartheftindex_i = NULL                                        => 0.0016507325,
                                                                               -0.0001394258);

final_score_107_c522 := map(
    NULL < r_i60_inq_comm_recency_d AND r_i60_inq_comm_recency_d <= 2 => -0.0095634511,
    r_i60_inq_comm_recency_d > 2                                      => -0.0006451707,
    r_i60_inq_comm_recency_d = NULL                                   => -0.0030678848,
                                                                         -0.0030678848);

final_score_107_c521 := map(
    NULL < r_c14_addr_stability_v2_d AND r_c14_addr_stability_v2_d <= 2.5 => 0.0034112851,
    r_c14_addr_stability_v2_d > 2.5                                       => final_score_107_c522,
    r_c14_addr_stability_v2_d = NULL                                      => -0.0014300947,
                                                                             -0.0014300947);

final_score_107 := map(
    NULL < r_c19_add_prison_hist_i AND r_c19_add_prison_hist_i <= 0.5 => final_score_107_c521,
    r_c19_add_prison_hist_i > 0.5                                     => 0.0201281632,
    r_c19_add_prison_hist_i = NULL                                    => -0.0044136171,
                                                                         -0.0010823743);

final_score_108_c525 := map(
    NULL < r_d33_eviction_count_i AND r_d33_eviction_count_i <= 7.5 => 0.0005266976,
    r_d33_eviction_count_i > 7.5                                    => 0.0343183935,
    r_d33_eviction_count_i = NULL                                   => 0.0009444582,
                                                                       0.0009444582);

final_score_108_c524 := map(
    NULL < f_rel_educationover8_count_d AND f_rel_educationover8_count_d <= 24.5 => final_score_108_c525,
    f_rel_educationover8_count_d > 24.5                                          => 0.0183911359,
    f_rel_educationover8_count_d = NULL                                          => 0.0047334995,
                                                                                    0.0022274990);

final_score_108 := map(
    NULL < r_e57_br_source_count_d AND r_e57_br_source_count_d <= 0.5 => final_score_108_c524,
    r_e57_br_source_count_d > 0.5                                     => -0.0050732857,
    r_e57_br_source_count_d = NULL                                    => -0.0090060584,
                                                                         -0.0000083614);

final_score_109_c528 := map(
    NULL < k_comb_age_d AND k_comb_age_d <= 35.5 => 0.0534098641,
    k_comb_age_d > 35.5                          => 0.0081866519,
    k_comb_age_d = NULL                          => 0.0202721655,
                                                    0.0202721655);

final_score_109_c527 := map(
    NULL < f_rel_incomeover75_count_d AND f_rel_incomeover75_count_d <= 8.5 => -0.0056125421,
    f_rel_incomeover75_count_d > 8.5                                        => final_score_109_c528,
    f_rel_incomeover75_count_d = NULL                                       => -0.0044839475,
                                                                               -0.0044839475);

final_score_109 := map(
    NULL < f_rel_ageover40_count_d AND f_rel_ageover40_count_d <= 2.5 => 0.0015141065,
    f_rel_ageover40_count_d > 2.5                                     => final_score_109_c527,
    f_rel_ageover40_count_d = NULL                                    => 0.0027694003,
                                                                         -0.0010189831);

final_score_110_c531 := map(
    NULL < f_add_input_mobility_index_i AND f_add_input_mobility_index_i <= 0.3675082975 => 0.0064841485,
    f_add_input_mobility_index_i > 0.3675082975                                          => 0.0319095307,
    f_add_input_mobility_index_i = NULL                                                  => 0.0122436142,
                                                                                            0.0122436142);

final_score_110_c530 := map(
    NULL < f_historical_count_d AND f_historical_count_d <= 1.5 => final_score_110_c531,
    f_historical_count_d > 1.5                                  => -0.0010989615,
    f_historical_count_d = NULL                                 => 0.0068797292,
                                                                   0.0068797292);

final_score_110 := map(
    NULL < f_inq_other_count24_i AND f_inq_other_count24_i <= 1.5 => -0.0018656030,
    f_inq_other_count24_i > 1.5                                   => final_score_110_c530,
    f_inq_other_count24_i = NULL                                  => -0.0010384692,
                                                                     -0.0005086672);

final_score_111_c534 := map(
    NULL < f_attr_arrest_recency_d AND f_attr_arrest_recency_d <= 99.5 => 0.0116026720,
    f_attr_arrest_recency_d > 99.5                                     => -0.0013216533,
    f_attr_arrest_recency_d = NULL                                     => -0.0006264479,
                                                                          -0.0006264479);

final_score_111_c533 := map(
    NULL < f_varrisktype_i AND f_varrisktype_i <= 7.5 => final_score_111_c534,
    f_varrisktype_i > 7.5                             => 0.0205635929,
    f_varrisktype_i = NULL                            => -0.0070383860,
                                                         -0.0003244251);

final_score_111 := map(
    NULL < k_inq_per_addr_i AND k_inq_per_addr_i <= 16.5 => final_score_111_c533,
    k_inq_per_addr_i > 16.5                              => 0.0279598255,
    k_inq_per_addr_i = NULL                              => 0.0000019139,
                                                            0.0000019139);

final_score_112_c537 := map(
    NULL < r_i60_inq_comm_count12_i AND r_i60_inq_comm_count12_i <= 2.5 => 0.0036708968,
    r_i60_inq_comm_count12_i > 2.5                                      => -0.0234560316,
    r_i60_inq_comm_count12_i = NULL                                     => 0.0022376700,
                                                                           0.0022376700);

final_score_112_c536 := map(
    NULL < f_srchfraudsrchcountyr_i AND f_srchfraudsrchcountyr_i <= 1.5 => final_score_112_c537,
    f_srchfraudsrchcountyr_i > 1.5                                      => 0.0127605538,
    f_srchfraudsrchcountyr_i = NULL                                     => 0.0048934233,
                                                                           0.0048934233);

final_score_112 := map(
    NULL < r_d32_criminal_count_i AND r_d32_criminal_count_i <= 0.5 => -0.0028544497,
    r_d32_criminal_count_i > 0.5                                    => final_score_112_c536,
    r_d32_criminal_count_i = NULL                                   => 0.0084666894,
                                                                       0.0001407763);

final_score_113_c540 := map(
    NULL < f_add_curr_nhood_sfd_pct_d AND f_add_curr_nhood_sfd_pct_d <= 0.0491403543 => 0.0453660425,
    f_add_curr_nhood_sfd_pct_d > 0.0491403543                                        => 0.0022589458,
    f_add_curr_nhood_sfd_pct_d = NULL                                                => 0.0056974118,
                                                                                        0.0056974118);

final_score_113_c539 := map(
    NULL < f_addrchangeincomediff_d AND f_addrchangeincomediff_d <= 369 => -0.0034763147,
    f_addrchangeincomediff_d > 369                                      => final_score_113_c540,
    f_addrchangeincomediff_d = NULL                                     => -0.0012994857,
                                                                           -0.0019750282);

final_score_113 := map(
    NULL < r_d32_criminal_count_i AND r_d32_criminal_count_i <= 4.5 => final_score_113_c539,
    r_d32_criminal_count_i > 4.5                                    => 0.0070645149,
    r_d32_criminal_count_i = NULL                                   => -0.0071067495,
                                                                       -0.0007341593);

final_score_114_c542 := map(
    NULL < r_l80_inp_avm_autoval_d AND r_l80_inp_avm_autoval_d <= 32002.5 => 0.0115494912,
    r_l80_inp_avm_autoval_d > 32002.5                                     => -0.0034685045,
    r_l80_inp_avm_autoval_d = NULL                                        => -0.0034454804,
                                                                             -0.0022559802);

final_score_114_c543 := map(
    NULL < f_curraddrcartheftindex_i AND f_curraddrcartheftindex_i <= 88.5 => -0.0087677932,
    f_curraddrcartheftindex_i > 88.5                                       => 0.0167791195,
    f_curraddrcartheftindex_i = NULL                                       => 0.0028239933,
                                                                              0.0007544863);

final_score_114 := map(
    NULL < f_add_curr_nhood_mfd_pct_i AND f_add_curr_nhood_mfd_pct_i <= 0.40099630265 => final_score_114_c542,
    f_add_curr_nhood_mfd_pct_i > 0.40099630265                                        => 0.0047228176,
    f_add_curr_nhood_mfd_pct_i = NULL                                                 => final_score_114_c543,
                                                                                         0.0001479837);

final_score_115_c546 := map(
    NULL < k_comb_age_d AND k_comb_age_d <= 22.5 => 0.0121587893,
    k_comb_age_d > 22.5                          => -0.0020583892,
    k_comb_age_d = NULL                          => -0.0015102406,
                                                    -0.0015102406);

final_score_115_c545 := map(
    NULL < k_estimated_income_d AND k_estimated_income_d <= 19999.5 => 0.0211907595,
    k_estimated_income_d > 19999.5                                  => final_score_115_c546,
    k_estimated_income_d = NULL                                     => -0.0011147393,
                                                                       -0.0011147393);

final_score_115 := map(
    NULL < f_phones_per_addr_curr_i AND f_phones_per_addr_curr_i <= 21.5 => final_score_115_c545,
    f_phones_per_addr_curr_i > 21.5                                      => 0.0139615765,
    f_phones_per_addr_curr_i = NULL                                      => -0.0021926132,
                                                                            -0.0006239932);

final_score_116_c549 := map(
    NULL < f_prevaddrcartheftindex_i AND f_prevaddrcartheftindex_i <= 185.5 => -0.0017402081,
    f_prevaddrcartheftindex_i > 185.5                                       => 0.0056914267,
    f_prevaddrcartheftindex_i = NULL                                        => -0.0004395240,
                                                                               -0.0004395240);

final_score_116_c548 := map(
    NULL < f_curraddrmedianvalue_d AND f_curraddrmedianvalue_d <= 577997 => final_score_116_c549,
    f_curraddrmedianvalue_d > 577997                                     => 0.0216449574,
    f_curraddrmedianvalue_d = NULL                                       => -0.0000958828,
                                                                            -0.0000958828);

final_score_116 := map(
    NULL < f_varrisktype_i AND f_varrisktype_i <= 5.5 => final_score_116_c548,
    f_varrisktype_i > 5.5                             => 0.0118876356,
    f_varrisktype_i = NULL                            => 0.0021512195,
                                                         0.0005649950);

final_score_117_c552 := map(
    NULL < f_add_input_nhood_mfd_pct_i AND f_add_input_nhood_mfd_pct_i <= 0.94308187785 => -0.0051597200,
    f_add_input_nhood_mfd_pct_i > 0.94308187785                                         => 0.0295253612,
    f_add_input_nhood_mfd_pct_i = NULL                                                  => -0.0125505422,
                                                                                           -0.0055278994);

final_score_117_c551 := map(
    NULL < r_a46_curr_avm_autoval_d AND r_a46_curr_avm_autoval_d <= 41098.5 => 0.0192494722,
    r_a46_curr_avm_autoval_d > 41098.5                                      => -0.0004772763,
    r_a46_curr_avm_autoval_d = NULL                                         => final_score_117_c552,
                                                                               -0.0024525873);

final_score_117 := map(
    NULL < f_addrchangecrimediff_i AND f_addrchangecrimediff_i <= -120.5 => 0.0375381057,
    f_addrchangecrimediff_i > -120.5                                     => 0.0007783481,
    f_addrchangecrimediff_i = NULL                                       => final_score_117_c551,
                                                                            0.0002871423);

final_score_118_c554 := map(
    NULL < r_f01_inp_addr_address_score_d AND r_f01_inp_addr_address_score_d <= 16 => 0.0308720791,
    r_f01_inp_addr_address_score_d > 16                                            => 0.0051298461,
    r_f01_inp_addr_address_score_d = NULL                                          => 0.0097382854,
                                                                                      0.0097382854);

final_score_118_c555 := map(
    NULL < f_prevaddrmedianvalue_d AND f_prevaddrmedianvalue_d <= 57837 => -0.0208474434,
    f_prevaddrmedianvalue_d > 57837                                     => 0.0072544098,
    f_prevaddrmedianvalue_d = NULL                                      => -0.0029577255,
                                                                           -0.0029577255);

final_score_118 := map(
    NULL < f_add_input_nhood_mfd_pct_i AND f_add_input_nhood_mfd_pct_i <= 0.87431650515 => -0.0007714163,
    f_add_input_nhood_mfd_pct_i > 0.87431650515                                         => final_score_118_c554,
    f_add_input_nhood_mfd_pct_i = NULL                                                  => final_score_118_c555,
                                                                                           -0.0002122027);

final_score_119_c558 := map(
    NULL < f_add_input_nhood_sfd_pct_d AND f_add_input_nhood_sfd_pct_d <= 0.9824798923 => 0.0009385654,
    f_add_input_nhood_sfd_pct_d > 0.9824798923                                         => 0.0196748907,
    f_add_input_nhood_sfd_pct_d = NULL                                                 => 0.0020233937,
                                                                                          0.0020233937);

final_score_119_c557 := map(
    NULL < f_addrs_per_ssn_i AND f_addrs_per_ssn_i <= 5.5 => -0.0062254790,
    f_addrs_per_ssn_i > 5.5                               => final_score_119_c558,
    f_addrs_per_ssn_i = NULL                              => 0.0000222809,
                                                             0.0000222809);

final_score_119 := map(
    NULL < r_l79_adls_per_addr_c6_i AND r_l79_adls_per_addr_c6_i <= 5.5 => final_score_119_c557,
    r_l79_adls_per_addr_c6_i > 5.5                                      => 0.0158561645,
    r_l79_adls_per_addr_c6_i = NULL                                     => 0.0006058519,
                                                                           0.0006058519);

final_score_120_c561 := map(
    NULL < f_curraddrcartheftindex_i AND f_curraddrcartheftindex_i <= 125.5 => -0.0053838171,
    f_curraddrcartheftindex_i > 125.5                                       => 0.0165884710,
    f_curraddrcartheftindex_i = NULL                                        => -0.0083603974,
                                                                               -0.0010883223);

final_score_120_c560 := map(
    NULL < f_add_curr_nhood_mfd_pct_i AND f_add_curr_nhood_mfd_pct_i <= 0.7339509416 => -0.0029217826,
    f_add_curr_nhood_mfd_pct_i > 0.7339509416                                        => 0.0059236317,
    f_add_curr_nhood_mfd_pct_i = NULL                                                => final_score_120_c561,
                                                                                        -0.0015497089);

final_score_120 := map(
    NULL < k_comb_age_d AND k_comb_age_d <= 23.5 => 0.0110685517,
    k_comb_age_d > 23.5                          => final_score_120_c560,
    k_comb_age_d = NULL                          => -0.0007656976,
                                                    -0.0007656976);

final_score_121_c564 := map(
    NULL < f_rel_ageover40_count_d AND f_rel_ageover40_count_d <= 3.5 => 0.0071958716,
    f_rel_ageover40_count_d > 3.5                                     => -0.0037870463,
    f_rel_ageover40_count_d = NULL                                    => 0.0035296349,
                                                                         0.0035296349);

final_score_121_c563 := map(
    NULL < f_hh_age_18_plus_d AND f_hh_age_18_plus_d <= 1.5 => final_score_121_c564,
    f_hh_age_18_plus_d > 1.5                                => -0.0032803792,
    f_hh_age_18_plus_d = NULL                               => -0.0005674760,
                                                               -0.0005674760);

final_score_121 := map(
    NULL < f_rel_incomeover75_count_d AND f_rel_incomeover75_count_d <= 8.5 => final_score_121_c563,
    f_rel_incomeover75_count_d > 8.5                                        => 0.0226389989,
    f_rel_incomeover75_count_d = NULL                                       => 0.0006465630,
                                                                               -0.0000087112);

final_score_122_c567 := map(
    NULL < f_add_input_nhood_bus_pct_i AND f_add_input_nhood_bus_pct_i <= 0.0059683682 => 0.0233396553,
    f_add_input_nhood_bus_pct_i > 0.0059683682                                         => 0.0032084264,
    f_add_input_nhood_bus_pct_i = NULL                                                 => -0.0170702881,
                                                                                          -0.0017223398);

final_score_122_c566 := map(
    NULL < f_add_input_nhood_mfd_pct_i AND f_add_input_nhood_mfd_pct_i <= 0.9608505558 => -0.0010206463,
    f_add_input_nhood_mfd_pct_i > 0.9608505558                                         => 0.0137238413,
    f_add_input_nhood_mfd_pct_i = NULL                                                 => final_score_122_c567,
                                                                                          -0.0006237485);

final_score_122 := map(
    NULL < f_phones_per_addr_curr_i AND f_phones_per_addr_curr_i <= 59.5 => final_score_122_c566,
    f_phones_per_addr_curr_i > 59.5                                      => 0.0199390066,
    f_phones_per_addr_curr_i = NULL                                      => 0.0035089189,
                                                                            -0.0003061093);

final_score_123_c570 := map(
    NULL < r_i60_inq_comm_count12_i AND r_i60_inq_comm_count12_i <= 2.5 => 0.0006883093,
    r_i60_inq_comm_count12_i > 2.5                                      => -0.0130633397,
    r_i60_inq_comm_count12_i = NULL                                     => -0.0005750316,
                                                                           -0.0005750316);

final_score_123_c569 := map(
    NULL < f_srchfraudsrchcountyr_i AND f_srchfraudsrchcountyr_i <= 2.5 => final_score_123_c570,
    f_srchfraudsrchcountyr_i > 2.5                                      => 0.0084933435,
    f_srchfraudsrchcountyr_i = NULL                                     => 0.0003949253,
                                                                           0.0003949253);

final_score_123 := map(
    NULL < f_liens_rel_cj_total_amt_i AND f_liens_rel_cj_total_amt_i <= 3153 => final_score_123_c569,
    f_liens_rel_cj_total_amt_i > 3153                                        => -0.0251417601,
    f_liens_rel_cj_total_amt_i = NULL                                        => 0.0061096265,
                                                                                0.0001195397);

final_score_124_c573 := map(
    NULL < k_estimated_income_d AND k_estimated_income_d <= 23500 => 0.0155132394,
    k_estimated_income_d > 23500                                  => 0.0008797406,
    k_estimated_income_d = NULL                                   => 0.0018073860,
                                                                     0.0018073860);

final_score_124_c572 := map(
    NULL < k_comb_age_d AND k_comb_age_d <= 20.5 => 0.0316366858,
    k_comb_age_d > 20.5                          => final_score_124_c573,
    k_comb_age_d = NULL                          => 0.0022270773,
                                                    0.0022270773);

final_score_124 := map(
    NULL < r_i60_credit_seeking_i AND r_i60_credit_seeking_i <= 1.5 => final_score_124_c572,
    r_i60_credit_seeking_i > 1.5                                    => -0.0057897363,
    r_i60_credit_seeking_i = NULL                                   => -0.0055369362,
                                                                       -0.0001651140);

final_score_125_c576 := map(
    NULL < f_prevaddrmurderindex_i AND f_prevaddrmurderindex_i <= 151.5 => 0.0052578996,
    f_prevaddrmurderindex_i > 151.5                                     => 0.0589684261,
    f_prevaddrmurderindex_i = NULL                                      => 0.0310558690,
                                                                           0.0310558690);

final_score_125_c575 := map(
    NULL < f_add_input_nhood_mfd_pct_i AND f_add_input_nhood_mfd_pct_i <= 0.31543599255 => final_score_125_c576,
    f_add_input_nhood_mfd_pct_i > 0.31543599255                                         => -0.0042974128,
    f_add_input_nhood_mfd_pct_i = NULL                                                  => 0.0148836231,
                                                                                           0.0148836231);

final_score_125 := map(
    NULL < r_l72_add_vacant_i AND r_l72_add_vacant_i <= 0.5 => -0.0015503201,
    r_l72_add_vacant_i > 0.5                                => final_score_125_c575,
    r_l72_add_vacant_i = NULL                               => -0.0012179964,
                                                               -0.0012179964);

final_score_126_c579 := map(
    NULL < f_add_curr_mobility_index_i AND f_add_curr_mobility_index_i <= 0.28422052015 => -0.0031927723,
    f_add_curr_mobility_index_i > 0.28422052015                                         => 0.0019808850,
    f_add_curr_mobility_index_i = NULL                                                  => -0.0226408836,
                                                                                           -0.0008093041);

final_score_126_c578 := map(
    NULL < k_estimated_income_d AND k_estimated_income_d <= 97500 => final_score_126_c579,
    k_estimated_income_d > 97500                                  => 0.0252769182,
    k_estimated_income_d = NULL                                   => -0.0046207171,
                                                                     -0.0005843833);

final_score_126 := map(
    NULL < k_inq_per_addr_i AND k_inq_per_addr_i <= 20.5 => final_score_126_c578,
    k_inq_per_addr_i > 20.5                              => 0.0308479670,
    k_inq_per_addr_i = NULL                              => -0.0003050188,
                                                            -0.0003050188);

final_score_127_c582 := map(
    NULL < r_a46_curr_avm_autoval_d AND r_a46_curr_avm_autoval_d <= 268630 => 0.0001402796,
    r_a46_curr_avm_autoval_d > 268630                                      => 0.0172580348,
    r_a46_curr_avm_autoval_d = NULL                                        => -0.0038286997,
                                                                              -0.0017916251);

final_score_127_c581 := map(
    NULL < f_add_curr_mobility_index_i AND f_add_curr_mobility_index_i <= 0.3278765633 => final_score_127_c582,
    f_add_curr_mobility_index_i > 0.3278765633                                         => 0.0050479390,
    f_add_curr_mobility_index_i = NULL                                                 => -0.0101966862,
                                                                                          0.0002007681);

final_score_127 := map(
    NULL < f_srchcomponentrisktype_i AND f_srchcomponentrisktype_i <= 8.5 => final_score_127_c581,
    f_srchcomponentrisktype_i > 8.5                                       => 0.0391640061,
    f_srchcomponentrisktype_i = NULL                                      => 0.0051598155,
                                                                             0.0004751501);

final_score_128_c584 := map(
    NULL < f_prevaddrmedianincome_d AND f_prevaddrmedianincome_d <= 16837.5 => 0.0123314586,
    f_prevaddrmedianincome_d > 16837.5                                      => -0.0027642210,
    f_prevaddrmedianincome_d = NULL                                         => -0.0019975058,
                                                                               -0.0019975058);

final_score_128_c585 := map(
    NULL < f_add_input_nhood_bus_pct_i AND f_add_input_nhood_bus_pct_i <= 0.00326175615 => 0.0330634803,
    f_add_input_nhood_bus_pct_i > 0.00326175615                                         => 0.0005459857,
    f_add_input_nhood_bus_pct_i = NULL                                                  => -0.0105599456,
                                                                                           -0.0003650763);

final_score_128 := map(
    NULL < f_addrchangevaluediff_d AND f_addrchangevaluediff_d <= 212888 => final_score_128_c584,
    f_addrchangevaluediff_d > 212888                                     => 0.0219553422,
    f_addrchangevaluediff_d = NULL                                       => final_score_128_c585,
                                                                            -0.0013554843);

final_score_129_c588 := map(
    NULL < f_curraddrcartheftindex_i AND f_curraddrcartheftindex_i <= 190.5 => -0.0066247087,
    f_curraddrcartheftindex_i > 190.5                                       => 0.0088743599,
    f_curraddrcartheftindex_i = NULL                                        => -0.0046791332,
                                                                               -0.0046791332);

final_score_129_c587 := map(
    NULL < f_util_add_curr_conv_n AND f_util_add_curr_conv_n <= 0.5 => final_score_129_c588,
    f_util_add_curr_conv_n > 0.5                                    => 0.0022971963,
    f_util_add_curr_conv_n = NULL                                   => 0.0001052806,
                                                                       0.0001052806);

final_score_129 := map(
    NULL < f_srchaddrsrchcountmo_i AND f_srchaddrsrchcountmo_i <= 5.5 => final_score_129_c587,
    f_srchaddrsrchcountmo_i > 5.5                                     => 0.0430148017,
    f_srchaddrsrchcountmo_i = NULL                                    => -0.0020333389,
                                                                         0.0002794335);

final_score_130_c590 := map(
    NULL < f_varrisktype_i AND f_varrisktype_i <= 6.5 => -0.0017627312,
    f_varrisktype_i > 6.5                             => 0.0139969818,
    f_varrisktype_i = NULL                            => -0.0151435916,
                                                         -0.0013103822);

final_score_130_c591 := map(
    NULL < r_l71_add_business_i AND r_l71_add_business_i <= 0.5 => 0.0047955872,
    r_l71_add_business_i > 0.5                                  => 0.0255499818,
    r_l71_add_business_i = NULL                                 => 0.0064924874,
                                                                   0.0064924874);

final_score_130 := map(
    NULL < (real)k_nap_nothing_found_i AND (real)k_nap_nothing_found_i <= 0.5 => final_score_130_c590,
    (real)k_nap_nothing_found_i > 0.5                                   => final_score_130_c591,
    (real)k_nap_nothing_found_i = NULL                                  => 0.0002576357,
                                                                     0.0002576357);

final_score_131_c594 := map(
    NULL < f_add_input_nhood_mfd_pct_i AND f_add_input_nhood_mfd_pct_i <= 0.5695505609 => -0.0007088502,
    f_add_input_nhood_mfd_pct_i > 0.5695505609                                         => -0.0177966898,
    f_add_input_nhood_mfd_pct_i = NULL                                                 => 0.0077638440,
                                                                                          -0.0010290800);

final_score_131_c593 := map(
    NULL < r_l80_inp_avm_autoval_d AND r_l80_inp_avm_autoval_d <= 8842.5 => 0.0425229715,
    r_l80_inp_avm_autoval_d > 8842.5                                     => final_score_131_c594,
    r_l80_inp_avm_autoval_d = NULL                                       => -0.0015159625,
                                                                            -0.0011693452);

final_score_131 := map(
    NULL < r_d32_criminal_count_i AND r_d32_criminal_count_i <= 23.5 => final_score_131_c593,
    r_d32_criminal_count_i > 23.5                                    => 0.0215724706,
    r_d32_criminal_count_i = NULL                                    => 0.0049636234,
                                                                        -0.0006700090);

final_score_132_c596 := map(
    NULL < k_inq_ssns_per_addr_i AND k_inq_ssns_per_addr_i <= 2.5 => -0.0030961433,
    k_inq_ssns_per_addr_i > 2.5                                   => 0.0073083412,
    k_inq_ssns_per_addr_i = NULL                                  => -0.0018959505,
                                                                     -0.0018959505);

final_score_132_c597 := map(
    NULL < f_prevaddrmedianvalue_d AND f_prevaddrmedianvalue_d <= 278409.5 => 0.0082623478,
    f_prevaddrmedianvalue_d > 278409.5                                     => 0.0488696382,
    f_prevaddrmedianvalue_d = NULL                                         => 0.0111657094,
                                                                              0.0111657094);

final_score_132 := map(
    NULL < r_d32_criminal_count_i AND r_d32_criminal_count_i <= 8.5 => final_score_132_c596,
    r_d32_criminal_count_i > 8.5                                    => final_score_132_c597,
    r_d32_criminal_count_i = NULL                                   => 0.0039753127,
                                                                       -0.0007362542);

final_score_133_c600 := map(
    NULL < f_prevaddrmedianincome_d AND f_prevaddrmedianincome_d <= 33954 => 0.0045611059,
    f_prevaddrmedianincome_d > 33954                                      => -0.0022697003,
    f_prevaddrmedianincome_d = NULL                                       => 0.0003765568,
                                                                             0.0003765568);

final_score_133_c599 := map(
    NULL < f_rel_under500miles_cnt_d AND f_rel_under500miles_cnt_d <= 27.5 => final_score_133_c600,
    f_rel_under500miles_cnt_d > 27.5                                       => 0.0227155045,
    f_rel_under500miles_cnt_d = NULL                                       => 0.0009984350,
                                                                              0.0009984350);

final_score_133 := map(
    NULL < f_rel_ageover40_count_d AND f_rel_ageover40_count_d <= 8.5 => final_score_133_c599,
    f_rel_ageover40_count_d > 8.5                                     => -0.0097144841,
    f_rel_ageover40_count_d = NULL                                    => 0.0001822568,
                                                                         -0.0001544917);

final_score_134_c603 := map(
    NULL < f_add_input_nhood_mfd_pct_i AND f_add_input_nhood_mfd_pct_i <= 0.52149873235 => 0.0064371186,
    f_add_input_nhood_mfd_pct_i > 0.52149873235                                         => -0.0100539951,
    f_add_input_nhood_mfd_pct_i = NULL                                                  => 0.0088486377,
                                                                                           0.0045700830);

final_score_134_c602 := map(
    NULL < f_rel_under25miles_cnt_d AND f_rel_under25miles_cnt_d <= 10.5 => -0.0023000661,
    f_rel_under25miles_cnt_d > 10.5                                      => final_score_134_c603,
    f_rel_under25miles_cnt_d = NULL                                      => 0.0027588531,
                                                                            -0.0001299916);

final_score_134 := map(
    NULL < r_c19_add_prison_hist_i AND r_c19_add_prison_hist_i <= 0.5 => final_score_134_c602,
    r_c19_add_prison_hist_i > 0.5                                     => 0.0189235275,
    r_c19_add_prison_hist_i = NULL                                    => -0.0104800452,
                                                                         0.0000770898);

final_score_135_c605 := map(
    NULL < r_d32_mos_since_fel_ls_d AND r_d32_mos_since_fel_ls_d <= 68.5 => 0.0203738947,
    r_d32_mos_since_fel_ls_d > 68.5                                      => 0.0010081041,
    r_d32_mos_since_fel_ls_d = NULL                                      => 0.0015162964,
                                                                            0.0015162964);

final_score_135_c606 := map(
    NULL < r_a49_curr_avm_chg_1yr_i AND r_a49_curr_avm_chg_1yr_i <= -9477.5 => 0.0294025610,
    r_a49_curr_avm_chg_1yr_i > -9477.5                                      => -0.0104905209,
    r_a49_curr_avm_chg_1yr_i = NULL                                         => -0.0118480184,
                                                                               -0.0092268772);

final_score_135 := map(
    NULL < f_liens_unrel_sc_total_amt_i AND f_liens_unrel_sc_total_amt_i <= 162.5 => final_score_135_c605,
    f_liens_unrel_sc_total_amt_i > 162.5                                          => final_score_135_c606,
    f_liens_unrel_sc_total_amt_i = NULL                                           => -0.0033773001,
                                                                                     0.0003436505);

final_score_136_c609 := map(
    NULL < r_a49_curr_avm_chg_1yr_pct_i AND r_a49_curr_avm_chg_1yr_pct_i <= 151.6 => 0.0023532437,
    r_a49_curr_avm_chg_1yr_pct_i > 151.6                                          => 0.0298839501,
    r_a49_curr_avm_chg_1yr_pct_i = NULL                                           => -0.0048694209,
                                                                                     -0.0023384012);

final_score_136_c608 := map(
    NULL < f_addrchangevaluediff_d AND f_addrchangevaluediff_d <= -35592.5 => 0.0086139853,
    f_addrchangevaluediff_d > -35592.5                                     => -0.0014781421,
    f_addrchangevaluediff_d = NULL                                         => final_score_136_c609,
                                                                              -0.0008876526);

final_score_136 := map(
    NULL < k_comb_age_d AND k_comb_age_d <= 20.5 => 0.0231862111,
    k_comb_age_d > 20.5                          => final_score_136_c608,
    k_comb_age_d = NULL                          => -0.0005431514,
                                                    -0.0005431514);

final_score_137_c612 := map(
    NULL < r_d32_mos_since_crim_ls_d AND r_d32_mos_since_crim_ls_d <= 3.5 => 0.0191860260,
    r_d32_mos_since_crim_ls_d > 3.5                                       => -0.0019240158,
    r_d32_mos_since_crim_ls_d = NULL                                      => -0.0014779097,
                                                                             -0.0014779097);

final_score_137_c611 := map(
    NULL < k_estimated_income_d AND k_estimated_income_d <= 23500 => 0.0107349742,
    k_estimated_income_d > 23500                                  => final_score_137_c612,
    k_estimated_income_d = NULL                                   => -0.0029058477,
                                                                     -0.0007009590);

final_score_137 := map(
    NULL < k_inq_per_addr_i AND k_inq_per_addr_i <= 20.5 => final_score_137_c611,
    k_inq_per_addr_i > 20.5                              => 0.0290005797,
    k_inq_per_addr_i = NULL                              => -0.0004636179,
                                                            -0.0004636179);

final_score_138_c615 := map(
    NULL < f_curraddrmedianincome_d AND f_curraddrmedianincome_d <= 14521 => 0.0237443703,
    f_curraddrmedianincome_d > 14521                                      => -0.0041348611,
    f_curraddrmedianincome_d = NULL                                       => -0.0079181058,
                                                                             -0.0028171317);

final_score_138_c614 := map(
    NULL < f_add_input_nhood_mfd_pct_i AND f_add_input_nhood_mfd_pct_i <= 0.4903055926 => final_score_138_c615,
    f_add_input_nhood_mfd_pct_i > 0.4903055926                                         => 0.0050070230,
    f_add_input_nhood_mfd_pct_i = NULL                                                 => -0.0040118588,
                                                                                          -0.0003946784);

final_score_138 := map(
    NULL < r_l80_inp_avm_autoval_d AND r_l80_inp_avm_autoval_d <= 51869.5 => 0.0080505148,
    r_l80_inp_avm_autoval_d > 51869.5                                     => -0.0029637653,
    r_l80_inp_avm_autoval_d = NULL                                        => final_score_138_c614,
                                                                             -0.0000332816);

final_score_139_c617 := map(
    NULL < r_a46_curr_avm_autoval_d AND r_a46_curr_avm_autoval_d <= 58734 => -0.0013148916,
    r_a46_curr_avm_autoval_d > 58734                                      => 0.0310217604,
    r_a46_curr_avm_autoval_d = NULL                                       => 0.0071901760,
                                                                             0.0116565049);

final_score_139_c618 := map(
    NULL < r_l72_add_vacant_i AND r_l72_add_vacant_i <= 0.5 => 0.0012409043,
    r_l72_add_vacant_i > 0.5                                => 0.0411988643,
    r_l72_add_vacant_i = NULL                               => 0.0019807408,
                                                               0.0019807408);

final_score_139 := map(
    NULL < f_addrchangecrimediff_i AND f_addrchangecrimediff_i <= 44.5 => -0.0017265972,
    f_addrchangecrimediff_i > 44.5                                     => final_score_139_c617,
    f_addrchangecrimediff_i = NULL                                     => final_score_139_c618,
                                                                          0.0000105626);

final_score_140_c621 := map(
    NULL < k_inq_adls_per_addr_i AND k_inq_adls_per_addr_i <= 3.5 => -0.0044475437,
    k_inq_adls_per_addr_i > 3.5                                   => 0.0298449656,
    k_inq_adls_per_addr_i = NULL                                  => -0.0037971988,
                                                                     -0.0037971988);

final_score_140_c620 := map(
    NULL < f_add_input_nhood_mfd_pct_i AND f_add_input_nhood_mfd_pct_i <= 0.99526433035 => final_score_140_c621,
    f_add_input_nhood_mfd_pct_i > 0.99526433035                                         => 0.0434391661,
    f_add_input_nhood_mfd_pct_i = NULL                                                  => -0.0082910468,
                                                                                           -0.0038388231);

final_score_140 := map(
    NULL < f_phones_per_addr_curr_i AND f_phones_per_addr_curr_i <= 3.5 => final_score_140_c620,
    f_phones_per_addr_curr_i > 3.5                                      => 0.0027891795,
    f_phones_per_addr_curr_i = NULL                                     => -0.0046947148,
                                                                           -0.0003302704);

final_score_141_c623 := map(
    NULL < f_inq_communications_count24_i AND f_inq_communications_count24_i <= 3.5 => 0.0014250745,
    f_inq_communications_count24_i > 3.5                                            => 0.0152257996,
    f_inq_communications_count24_i = NULL                                           => 0.0022970454,
                                                                                       0.0022970454);

final_score_141_c624 := map(
    NULL < f_rel_under500miles_cnt_d AND f_rel_under500miles_cnt_d <= 12.5 => -0.0086131686,
    f_rel_under500miles_cnt_d > 12.5                                       => 0.0032231764,
    f_rel_under500miles_cnt_d = NULL                                       => 0.0099844623,
                                                                              -0.0041076166);

final_score_141 := map(
    NULL < r_i60_credit_seeking_i AND r_i60_credit_seeking_i <= 1.5 => final_score_141_c623,
    r_i60_credit_seeking_i > 1.5                                    => final_score_141_c624,
    r_i60_credit_seeking_i = NULL                                   => 0.0052266351,
                                                                       0.0005041235);

final_score_142_c626 := map(
    (nf_seg_fraudpoint_3_0 in ['5: Vuln Vic/Friendly', '6: Other'])                                    => -0.0246132282,
    (nf_seg_fraudpoint_3_0 in ['1: Stolen/Manip ID', '2: Synth ID', '3: Derog', '4: Recent Activity']) => 0.0143373374,
    nf_seg_fraudpoint_3_0 = ''                                                                       => 0.0108428665,
                                                                                                          0.0108428665);

final_score_142_c627 := map(
    NULL < f_addrchangeincomediff_d AND f_addrchangeincomediff_d <= 50798.5 => -0.0006765778,
    f_addrchangeincomediff_d > 50798.5                                      => 0.0320016696,
    f_addrchangeincomediff_d = NULL                                         => -0.0016766905,
                                                                               -0.0007255406);

final_score_142 := map(
    NULL < f_attr_arrest_recency_d AND f_attr_arrest_recency_d <= 99.5 => final_score_142_c626,
    f_attr_arrest_recency_d > 99.5                                     => final_score_142_c627,
    f_attr_arrest_recency_d = NULL                                     => -0.0035375741,
                                                                          -0.0001149197);

final_score_143_c630 := map(
    NULL < f_bus_name_nover_i AND f_bus_name_nover_i <= 0.5 => -0.0013251894,
    f_bus_name_nover_i > 0.5                                => 0.0150226236,
    f_bus_name_nover_i = NULL                               => 0.0035191966,
                                                               0.0035191966);

final_score_143_c629 := map(
    NULL < f_add_curr_nhood_bus_pct_i AND f_add_curr_nhood_bus_pct_i <= 0.0177648277 => final_score_143_c630,
    f_add_curr_nhood_bus_pct_i > 0.0177648277                                        => -0.0017924440,
    f_add_curr_nhood_bus_pct_i = NULL                                                => -0.0151152709,
                                                                                        -0.0018278074);

final_score_143 := map(
    NULL < r_a46_curr_avm_autoval_d AND r_a46_curr_avm_autoval_d <= 235307 => 0.0013781956,
    r_a46_curr_avm_autoval_d > 235307                                      => 0.0141299011,
    r_a46_curr_avm_autoval_d = NULL                                        => final_score_143_c629,
                                                                              -0.0002756971);

final_score_144_c632 := map(
    NULL < f_prevaddrcartheftindex_i AND f_prevaddrcartheftindex_i <= 183.5 => -0.0031204919,
    f_prevaddrcartheftindex_i > 183.5                                       => 0.0049576556,
    f_prevaddrcartheftindex_i = NULL                                        => -0.0106351229,
                                                                               -0.0016262740);

final_score_144_c633 := map(
    NULL < f_add_input_mobility_index_i AND f_add_input_mobility_index_i <= 0.2745978109 => 0.0151002232,
    f_add_input_mobility_index_i > 0.2745978109                                          => 0.0005799122,
    f_add_input_mobility_index_i = NULL                                                  => 0.0065669984,
                                                                                            0.0065669984);

final_score_144 := map(
    NULL < f_add_input_nhood_mfd_pct_i AND f_add_input_nhood_mfd_pct_i <= 0.71253227195 => final_score_144_c632,
    f_add_input_nhood_mfd_pct_i > 0.71253227195                                         => final_score_144_c633,
    f_add_input_nhood_mfd_pct_i = NULL                                                  => 0.0005082365,
                                                                                           -0.0001906728);

final_score_145_c635 := map(
    NULL < f_inputaddractivephonelist_d AND f_inputaddractivephonelist_d <= 0.5 => -0.0003438285,
    f_inputaddractivephonelist_d > 0.5                                          => -0.0076349150,
    f_inputaddractivephonelist_d = NULL                                         => 0.0143527939,
                                                                                   -0.0023380235);

final_score_145_c636 := map(
    NULL < k_estimated_income_d AND k_estimated_income_d <= 21500 => 0.0266242863,
    k_estimated_income_d > 21500                                  => 0.0044594673,
    k_estimated_income_d = NULL                                   => 0.0053095384,
                                                                     0.0053095384);

final_score_145 := map(
    NULL < k_inq_ssns_per_addr_i AND k_inq_ssns_per_addr_i <= 1.5 => final_score_145_c635,
    k_inq_ssns_per_addr_i > 1.5                                   => final_score_145_c636,
    k_inq_ssns_per_addr_i = NULL                                  => -0.0003329081,
                                                                     -0.0003329081);

final_score_146_c638 := map(
    NULL < k_inq_per_addr_i AND k_inq_per_addr_i <= 18.5 => -0.0010490632,
    k_inq_per_addr_i > 18.5                              => 0.0242219998,
    k_inq_per_addr_i = NULL                              => -0.0008154422,
                                                            -0.0008154422);

final_score_146_c639 := map(
    NULL < f_add_curr_nhood_vac_pct_i AND f_add_curr_nhood_vac_pct_i <= 0.0793514802 => -0.0002287335,
    f_add_curr_nhood_vac_pct_i > 0.0793514802                                        => 0.0511795789,
    f_add_curr_nhood_vac_pct_i = NULL                                                => 0.0206590621,
                                                                                        0.0206590621);

final_score_146 := map(
    NULL < r_l72_add_vacant_i AND r_l72_add_vacant_i <= 0.5 => final_score_146_c638,
    r_l72_add_vacant_i > 0.5                                => final_score_146_c639,
    r_l72_add_vacant_i = NULL                               => -0.0003662873,
                                                               -0.0003662873);

final_score_147_c642 := map(
    NULL < f_hh_age_18_plus_d AND f_hh_age_18_plus_d <= 1.5 => 0.0097681589,
    f_hh_age_18_plus_d > 1.5                                => -0.0000327088,
    f_hh_age_18_plus_d = NULL                               => 0.0040297460,
                                                               0.0040297460);

final_score_147_c641 := map(
    NULL < f_historical_count_d AND f_historical_count_d <= 14.5 => final_score_147_c642,
    f_historical_count_d > 14.5                                  => 0.0528935405,
    f_historical_count_d = NULL                                  => -0.0004460536,
                                                                    0.0045832715);

final_score_147 := map(
    NULL < f_bus_name_nover_i AND f_bus_name_nover_i <= 0.5 => -0.0017363158,
    f_bus_name_nover_i > 0.5                                => final_score_147_c641,
    f_bus_name_nover_i = NULL                               => 0.0004225159,
                                                               0.0004225159);

final_score_148_c645 := map(
    NULL < f_assoccredbureaucount_i AND f_assoccredbureaucount_i <= 0.5 => 0.0000555790,
    f_assoccredbureaucount_i > 0.5                                      => 0.0093442754,
    f_assoccredbureaucount_i = NULL                                     => 0.0025232504,
                                                                           0.0025232504);

final_score_148_c644 := map(
    NULL < f_crim_rel_under25miles_cnt_i AND f_crim_rel_under25miles_cnt_i <= 1.5 => -0.0031652483,
    f_crim_rel_under25miles_cnt_i > 1.5                                           => final_score_148_c645,
    f_crim_rel_under25miles_cnt_i = NULL                                          => -0.0013172099,
                                                                                     -0.0006804065);

final_score_148 := map(
    NULL < r_l75_add_drop_delivery_i AND r_l75_add_drop_delivery_i <= 0.5 => final_score_148_c644,
    r_l75_add_drop_delivery_i > 0.5                                       => 0.0169775412,
    r_l75_add_drop_delivery_i = NULL                                      => -0.0002570996,
                                                                             -0.0002570996);

final_score_149_c648 := map(
    NULL < f_fp_prevaddrburglaryindex_i AND f_fp_prevaddrburglaryindex_i <= 167.5 => -0.0011147899,
    f_fp_prevaddrburglaryindex_i > 167.5                                          => 0.0423420463,
    f_fp_prevaddrburglaryindex_i = NULL                                           => 0.0036885726,
                                                                                     0.0036885726);

final_score_149_c647 := map(
    NULL < f_crim_rel_under25miles_cnt_i AND f_crim_rel_under25miles_cnt_i <= 4.5 => -0.0005130022,
    f_crim_rel_under25miles_cnt_i > 4.5                                           => 0.0129454335,
    f_crim_rel_under25miles_cnt_i = NULL                                          => final_score_149_c648,
                                                                                     0.0015678027);

final_score_149 := map(
    NULL < r_e57_br_source_count_d AND r_e57_br_source_count_d <= 0.5 => final_score_149_c647,
    r_e57_br_source_count_d > 0.5                                     => -0.0046058805,
    r_e57_br_source_count_d = NULL                                    => 0.0045720389,
                                                                         -0.0001508516);

final_score_150_c650 := map(
    NULL < f_hh_bankruptcies_i AND f_hh_bankruptcies_i <= 0.5 => 0.0230981649,
    f_hh_bankruptcies_i > 0.5                                 => -0.0172048256,
    f_hh_bankruptcies_i = NULL                                => 0.0163384861,
                                                                 0.0163384861);

final_score_150_c651 := map(
    NULL < f_addrs_per_ssn_i AND f_addrs_per_ssn_i <= 6.5 => -0.0047237276,
    f_addrs_per_ssn_i > 6.5                               => 0.0014792054,
    f_addrs_per_ssn_i = NULL                              => -0.0002904977,
                                                             -0.0002904977);

final_score_150 := map(
    NULL < k_comb_age_d AND k_comb_age_d <= 21.5 => final_score_150_c650,
    k_comb_age_d > 21.5                          => final_score_150_c651,
    k_comb_age_d = NULL                          => 0.0001678027,
                                                    0.0001678027);

final_score_151_c654 := map(
    NULL < f_add_curr_nhood_vac_pct_i AND f_add_curr_nhood_vac_pct_i <= 0.06168726775 => -0.0039475086,
    f_add_curr_nhood_vac_pct_i > 0.06168726775                                        => 0.0029002816,
    f_add_curr_nhood_vac_pct_i = NULL                                                 => -0.0012571982,
                                                                                         -0.0012571982);

final_score_151_c653 := map(
    NULL < f_fp_prevaddrburglaryindex_i AND f_fp_prevaddrburglaryindex_i <= 52.5 => 0.0081226697,
    f_fp_prevaddrburglaryindex_i > 52.5                                          => final_score_151_c654,
    f_fp_prevaddrburglaryindex_i = NULL                                          => -0.0020690886,
                                                                                    0.0001215728);

final_score_151 := map(
    NULL < f_add_input_nhood_mfd_pct_i AND f_add_input_nhood_mfd_pct_i <= 0.00167434335 => 0.0512095323,
    f_add_input_nhood_mfd_pct_i > 0.00167434335                                         => final_score_151_c653,
    f_add_input_nhood_mfd_pct_i = NULL                                                  => -0.0004259193,
                                                                                           0.0002701034);

final_score_152_c657 := map(
    NULL < f_add_curr_mobility_index_i AND f_add_curr_mobility_index_i <= 0.19683716895 => -0.0290000765,
    f_add_curr_mobility_index_i > 0.19683716895                                         => 0.0101861448,
    f_add_curr_mobility_index_i = NULL                                                  => 0.0038503881,
                                                                                           0.0038503881);

final_score_152_c656 := map(
    NULL < f_rel_incomeover75_count_d AND f_rel_incomeover75_count_d <= 6.5 => -0.0030353210,
    f_rel_incomeover75_count_d > 6.5                                        => 0.0131026789,
    f_rel_incomeover75_count_d = NULL                                       => final_score_152_c657,
                                                                               -0.0020385027);

final_score_152 := map(
    NULL < r_d32_criminal_count_i AND r_d32_criminal_count_i <= 1.5 => final_score_152_c656,
    r_d32_criminal_count_i > 1.5                                    => 0.0040395237,
    r_d32_criminal_count_i = NULL                                   => 0.0051905474,
                                                                       -0.0002973559);

final_score_153_c660 := map(
    NULL < f_varrisktype_i AND f_varrisktype_i <= 2.5 => 0.0035659277,
    f_varrisktype_i > 2.5                             => 0.0210498008,
    f_varrisktype_i = NULL                            => 0.0090747156,
                                                         0.0090747156);

final_score_153_c659 := map(
    NULL < r_d32_mos_since_crim_ls_d AND r_d32_mos_since_crim_ls_d <= 49.5 => final_score_153_c660,
    r_d32_mos_since_crim_ls_d > 49.5                                       => 0.0005241538,
    r_d32_mos_since_crim_ls_d = NULL                                       => 0.0018395529,
                                                                              0.0018395529);

final_score_153 := map(
    NULL < r_c20_email_domain_free_count_i AND r_c20_email_domain_free_count_i <= 1.5 => final_score_153_c659,
    r_c20_email_domain_free_count_i > 1.5                                             => -0.0047116785,
    r_c20_email_domain_free_count_i = NULL                                            => 0.0021758412,
                                                                                         0.0002634409);

final_score_154_c663 := map(
    NULL < f_rel_incomeover75_count_d AND f_rel_incomeover75_count_d <= 1.5 => 0.0038680600,
    f_rel_incomeover75_count_d > 1.5                                        => 0.0390865161,
    f_rel_incomeover75_count_d = NULL                                       => 0.0086090061,
                                                                               0.0086090061);

final_score_154_c662 := map(
    NULL < k_comb_age_d AND k_comb_age_d <= 22.5 => final_score_154_c663,
    k_comb_age_d > 22.5                          => -0.0024021703,
    k_comb_age_d = NULL                          => -0.0019497635,
                                                    -0.0019497635);

final_score_154 := map(
    NULL < f_curraddrmedianvalue_d AND f_curraddrmedianvalue_d <= 586672 => final_score_154_c662,
    f_curraddrmedianvalue_d > 586672                                     => 0.0170791757,
    f_curraddrmedianvalue_d = NULL                                       => -0.0048009325,
                                                                            -0.0017229193);

final_score_155_c665 := map(
    NULL < f_curraddrmedianvalue_d AND f_curraddrmedianvalue_d <= 436634 => -0.0003514074,
    f_curraddrmedianvalue_d > 436634                                     => 0.0126550645,
    f_curraddrmedianvalue_d = NULL                                       => 0.0027026844,
                                                                            0.0002428051);

final_score_155_c666 := map(
    NULL < f_add_input_nhood_sfd_pct_d AND f_add_input_nhood_sfd_pct_d <= 0.0824897433 => 0.0333906473,
    f_add_input_nhood_sfd_pct_d > 0.0824897433                                         => 0.0039643028,
    f_add_input_nhood_sfd_pct_d = NULL                                                 => 0.0110443256,
                                                                                          0.0110443256);

final_score_155 := map(
    NULL < f_add_input_nhood_bus_pct_i AND f_add_input_nhood_bus_pct_i <= 0.2764762697 => final_score_155_c665,
    f_add_input_nhood_bus_pct_i > 0.2764762697                                         => final_score_155_c666,
    f_add_input_nhood_bus_pct_i = NULL                                                 => -0.0110740379,
                                                                                          0.0000968258);

final_score_156_c668 := map(
    NULL < k_estimated_income_d AND k_estimated_income_d <= 19999.5 => 0.0192176035,
    k_estimated_income_d > 19999.5                                  => -0.0010109314,
    k_estimated_income_d = NULL                                     => -0.0054195209,
                                                                       -0.0007050699);

final_score_156_c669 := map(
    NULL < f_liens_unrel_cj_total_amt_i AND f_liens_unrel_cj_total_amt_i <= 5688.5 => -0.0034988655,
    f_liens_unrel_cj_total_amt_i > 5688.5                                          => 0.0474968743,
    f_liens_unrel_cj_total_amt_i = NULL                                            => -0.0015412183,
                                                                                      -0.0015412183);

final_score_156 := map(
    NULL < f_add_input_nhood_mfd_pct_i AND f_add_input_nhood_mfd_pct_i <= 0.99557766585 => final_score_156_c668,
    f_add_input_nhood_mfd_pct_i > 0.99557766585                                         => 0.0317949348,
    f_add_input_nhood_mfd_pct_i = NULL                                                  => final_score_156_c669,
                                                                                           -0.0006132367);

final_score_157_c671 := map(
    NULL < f_srchfraudsrchcountyr_i AND f_srchfraudsrchcountyr_i <= 1.5 => 0.0044694531,
    f_srchfraudsrchcountyr_i > 1.5                                      => 0.0234733340,
    f_srchfraudsrchcountyr_i = NULL                                     => 0.0094761926,
                                                                           0.0094761926);

final_score_157_c672 := map(
    NULL < f_add_curr_mobility_index_i AND f_add_curr_mobility_index_i <= 0.14586756915 => -0.0190238093,
    f_add_curr_mobility_index_i > 0.14586756915                                         => 0.0004891375,
    f_add_curr_mobility_index_i = NULL                                                  => 0.0278043586,
                                                                                           0.0000770194);

final_score_157 := map(
    NULL < r_d32_mos_since_crim_ls_d AND r_d32_mos_since_crim_ls_d <= 21.5 => final_score_157_c671,
    r_d32_mos_since_crim_ls_d > 21.5                                       => final_score_157_c672,
    r_d32_mos_since_crim_ls_d = NULL                                       => 0.0035476290,
                                                                              0.0009247991);

final_score_158_c675 := map(
    NULL < r_i60_credit_seeking_i AND r_i60_credit_seeking_i <= 1.5 => 0.0023304628,
    r_i60_credit_seeking_i > 1.5                                    => -0.0034493598,
    r_i60_credit_seeking_i = NULL                                   => 0.0006242926,
                                                                       0.0006242926);

final_score_158_c674 := map(
    NULL < f_add_curr_has_vac_ct_i AND f_add_curr_has_vac_ct_i <= 0.5 => -0.0226518767,
    f_add_curr_has_vac_ct_i > 0.5                                     => final_score_158_c675,
    f_add_curr_has_vac_ct_i = NULL                                    => -0.0001451920,
                                                                         -0.0001451920);

final_score_158 := map(
    NULL < r_l72_add_curr_vacant_i AND r_l72_add_curr_vacant_i <= 0.5 => final_score_158_c674,
    r_l72_add_curr_vacant_i > 0.5                                     => 0.0190071085,
    r_l72_add_curr_vacant_i = NULL                                    => 0.0008013823,
                                                                         0.0003729835);

final_score_159_c678 := map(
    NULL < f_curraddrmedianincome_d AND f_curraddrmedianincome_d <= 38594 => 0.0052299300,
    f_curraddrmedianincome_d > 38594                                      => -0.0047923043,
    f_curraddrmedianincome_d = NULL                                       => 0.0004483261,
                                                                             0.0004483261);

final_score_159_c677 := map(
    NULL < r_d30_derog_count_i AND r_d30_derog_count_i <= 7.5 => final_score_159_c678,
    r_d30_derog_count_i > 7.5                                 => 0.0129092987,
    r_d30_derog_count_i = NULL                                => 0.0021159467,
                                                                 0.0021159467);

final_score_159 := map(
    NULL < f_hh_workers_paw_d AND f_hh_workers_paw_d <= 0.5 => final_score_159_c677,
    f_hh_workers_paw_d > 0.5                                => -0.0030122935,
    f_hh_workers_paw_d = NULL                               => 0.0047802132,
                                                               -0.0003488751);

final_score_160_c681 := map(
    NULL < f_prevaddrmurderindex_i AND f_prevaddrmurderindex_i <= 81 => 0.0056394448,
    f_prevaddrmurderindex_i > 81                                     => -0.0115200491,
    f_prevaddrmurderindex_i = NULL                                   => -0.0066076197,
                                                                        -0.0066076197);

final_score_160_c680 := map(
    NULL < f_m_bureau_adl_fs_notu_d AND f_m_bureau_adl_fs_notu_d <= 318.5 => 0.0009641131,
    f_m_bureau_adl_fs_notu_d > 318.5                                      => final_score_160_c681,
    f_m_bureau_adl_fs_notu_d = NULL                                       => -0.0005351124,
                                                                             -0.0005351124);

final_score_160 := map(
    NULL < f_add_curr_nhood_bus_pct_i AND f_add_curr_nhood_bus_pct_i <= 0.48077219165 => final_score_160_c680,
    f_add_curr_nhood_bus_pct_i > 0.48077219165                                        => -0.0343119610,
    f_add_curr_nhood_bus_pct_i = NULL                                                 => -0.0072188068,
                                                                                         -0.0010931784);

final_score_161_c683 := map(
    NULL < k_comb_age_d AND k_comb_age_d <= 82.5 => -0.0023263091,
    k_comb_age_d > 82.5                          => 0.0276855347,
    k_comb_age_d = NULL                          => -0.0018717076,
                                                    -0.0018717076);

final_score_161_c684 := map(
    NULL < r_i60_inq_auto_recency_d AND r_i60_inq_auto_recency_d <= 61.5 => -0.0151141271,
    r_i60_inq_auto_recency_d > 61.5                                      => 0.0059124610,
    r_i60_inq_auto_recency_d = NULL                                      => 0.0042114093,
                                                                            0.0042114093);

final_score_161 := map(
    NULL < f_vardobcountnew_i AND f_vardobcountnew_i <= 0.5 => final_score_161_c683,
    f_vardobcountnew_i > 0.5                                => final_score_161_c684,
    f_vardobcountnew_i = NULL                               => -0.0009276763,
                                                               -0.0004167646);

final_score_162_c686 := map(
    NULL < r_a49_curr_avm_chg_1yr_pct_i AND r_a49_curr_avm_chg_1yr_pct_i <= 36.55 => -0.0293134794,
    r_a49_curr_avm_chg_1yr_pct_i > 36.55                                          => 0.0030716579,
    r_a49_curr_avm_chg_1yr_pct_i = NULL                                           => -0.0003324530,
                                                                                     0.0004800705);

final_score_162_c687 := map(
    NULL < k_comb_age_d AND k_comb_age_d <= 31.5 => -0.0273959964,
    k_comb_age_d > 31.5                          => 0.0163634433,
    k_comb_age_d = NULL                          => -0.0019779720,
                                                    -0.0019779720);

final_score_162 := map(
    NULL < f_mos_liens_unrel_ot_fseen_d AND f_mos_liens_unrel_ot_fseen_d <= 17.5 => 0.0350737381,
    f_mos_liens_unrel_ot_fseen_d > 17.5                                          => final_score_162_c686,
    f_mos_liens_unrel_ot_fseen_d = NULL                                          => final_score_162_c687,
                                                                                    0.0006344648);

final_score_163_c690 := map(
    NULL < f_add_input_mobility_index_i AND f_add_input_mobility_index_i <= 0.2326230919 => -0.0138933927,
    f_add_input_mobility_index_i > 0.2326230919                                          => 0.0268578225,
    f_add_input_mobility_index_i = NULL                                                  => 0.0207536183,
                                                                                            0.0207536183);

final_score_163_c689 := map(
    NULL < r_l79_adls_per_addr_curr_i AND r_l79_adls_per_addr_curr_i <= 7.5 => final_score_163_c690,
    r_l79_adls_per_addr_curr_i > 7.5                                        => -0.0058195721,
    r_l79_adls_per_addr_curr_i = NULL                                       => 0.0124416251,
                                                                               0.0124416251);

final_score_163 := map(
    NULL < f_divrisktype_i AND f_divrisktype_i <= 3.5 => -0.0005486980,
    f_divrisktype_i > 3.5                             => final_score_163_c689,
    f_divrisktype_i = NULL                            => 0.0027145561,
                                                         0.0000512831);

final_score_164_c693 := map(
    NULL < r_i60_credit_seeking_i AND r_i60_credit_seeking_i <= 1.5 => 0.0025919000,
    r_i60_credit_seeking_i > 1.5                                    => -0.0052516074,
    r_i60_credit_seeking_i = NULL                                   => 0.0004905985,
                                                                       0.0004905985);

final_score_164_c692 := map(
    NULL < f_inq_communications_count24_i AND f_inq_communications_count24_i <= 7.5 => final_score_164_c693,
    f_inq_communications_count24_i > 7.5                                            => 0.0198039659,
    f_inq_communications_count24_i = NULL                                           => 0.0009072064,
                                                                                       0.0009072064);

final_score_164 := map(
    NULL < r_c20_email_count_i AND r_c20_email_count_i <= 3.5 => final_score_164_c692,
    r_c20_email_count_i > 3.5                                 => -0.0069625807,
    r_c20_email_count_i = NULL                                => -0.0033865877,
                                                                 -0.0004478708);

final_score_165_c696 := map(
    NULL < f_bus_name_nover_i AND f_bus_name_nover_i <= 0.5 => 0.0007105054,
    f_bus_name_nover_i > 0.5                                => 0.0141065247,
    f_bus_name_nover_i = NULL                               => 0.0058628205,
                                                               0.0058628205);

final_score_165_c695 := map(
    NULL < (real)k_nap_nothing_found_i AND (real)k_nap_nothing_found_i <= 0.5 => -0.0012224494,
    (real)k_nap_nothing_found_i > 0.5                                   => final_score_165_c696,
    (real)k_nap_nothing_found_i = NULL                                  => 0.0001622300,
                                                                     0.0001622300);

final_score_165 := map(
    NULL < f_add_curr_nhood_vac_pct_i AND f_add_curr_nhood_vac_pct_i <= 0.000998005 => -0.0077467036,
    f_add_curr_nhood_vac_pct_i > 0.000998005                                        => final_score_165_c695,
    f_add_curr_nhood_vac_pct_i = NULL                                               => 0.0012133460,
                                                                                       -0.0011104189);

final_score_166_c699 := map(
    NULL < f_rel_ageover40_count_d AND f_rel_ageover40_count_d <= 3.5 => 0.0097934300,
    f_rel_ageover40_count_d > 3.5                                     => 0.0003338677,
    f_rel_ageover40_count_d = NULL                                    => 0.0053956896,
                                                                         0.0053956896);

final_score_166_c698 := map(
    NULL < f_liens_unrel_o_total_amt_i AND f_liens_unrel_o_total_amt_i <= 133.5 => final_score_166_c699,
    f_liens_unrel_o_total_amt_i > 133.5                                         => -0.0119749158,
    f_liens_unrel_o_total_amt_i = NULL                                          => 0.0038205729,
                                                                                   0.0038205729);

final_score_166 := map(
    NULL < f_addrs_per_ssn_i AND f_addrs_per_ssn_i <= 11.5 => -0.0025161140,
    f_addrs_per_ssn_i > 11.5                               => final_score_166_c698,
    f_addrs_per_ssn_i = NULL                               => 0.0001164218,
                                                              0.0001164218);

final_score_167_c702 := map(
    NULL < r_c13_max_lres_d AND r_c13_max_lres_d <= 196.5 => 0.0282767752,
    r_c13_max_lres_d > 196.5                              => -0.0136818198,
    r_c13_max_lres_d = NULL                               => 0.0160983168,
                                                             0.0160983168);

final_score_167_c701 := map(
    NULL < f_prevaddrmedianvalue_d AND f_prevaddrmedianvalue_d <= 555116.5 => -0.0016907881,
    f_prevaddrmedianvalue_d > 555116.5                                     => final_score_167_c702,
    f_prevaddrmedianvalue_d = NULL                                         => -0.0013161823,
                                                                              -0.0013161823);

final_score_167 := map(
    NULL < r_c14_addrs_5yr_i AND r_c14_addrs_5yr_i <= 3.5 => final_score_167_c701,
    r_c14_addrs_5yr_i > 3.5                               => 0.0075748454,
    r_c14_addrs_5yr_i = NULL                              => -0.0094689266,
                                                             -0.0002157394);

final_score_168_c705 := map(
    NULL < f_inq_communications_count24_i AND f_inq_communications_count24_i <= 7.5 => -0.0006667008,
    f_inq_communications_count24_i > 7.5                                            => 0.0213056963,
    f_inq_communications_count24_i = NULL                                           => -0.0001185842,
                                                                                       -0.0001185842);

final_score_168_c704 := map(
    NULL < f_rel_ageover40_count_d AND f_rel_ageover40_count_d <= 8.5 => final_score_168_c705,
    f_rel_ageover40_count_d > 8.5                                     => -0.0130972386,
    f_rel_ageover40_count_d = NULL                                    => 0.0009265108,
                                                                         -0.0012760659);

final_score_168 := map(
    NULL < r_a46_curr_avm_autoval_d AND r_a46_curr_avm_autoval_d <= 299952 => 0.0008718409,
    r_a46_curr_avm_autoval_d > 299952                                      => 0.0193063917,
    r_a46_curr_avm_autoval_d = NULL                                        => final_score_168_c704,
                                                                              -0.0001188268);

final_score_169_c708 := map(
    NULL < f_addrchangecrimediff_i AND f_addrchangecrimediff_i <= -100.5 => 0.0204091145,
    f_addrchangecrimediff_i > -100.5                                     => 0.0004810272,
    f_addrchangecrimediff_i = NULL                                       => 0.0104885427,
                                                                            0.0028031388);

final_score_169_c707 := map(
    NULL < f_add_curr_nhood_vac_pct_i AND f_add_curr_nhood_vac_pct_i <= 0.0458250332 => -0.0035242779,
    f_add_curr_nhood_vac_pct_i > 0.0458250332                                        => final_score_169_c708,
    f_add_curr_nhood_vac_pct_i = NULL                                                => -0.0005880924,
                                                                                        -0.0005880924);

final_score_169 := map(
    NULL < f_curraddrmedianvalue_d AND f_curraddrmedianvalue_d <= 283406.5 => final_score_169_c707,
    f_curraddrmedianvalue_d > 283406.5                                     => 0.0071559065,
    f_curraddrmedianvalue_d = NULL                                         => -0.0059540864,
                                                                              0.0003353551);

final_score_170_c711 := map(
    NULL < f_prevaddrmedianincome_d AND f_prevaddrmedianincome_d <= 58958 => 0.0203169360,
    f_prevaddrmedianincome_d > 58958                                      => -0.0234011862,
    f_prevaddrmedianincome_d = NULL                                       => 0.0137259604,
                                                                             0.0137259604);

final_score_170_c710 := map(
    NULL < f_attr_arrest_recency_d AND f_attr_arrest_recency_d <= 99.5 => final_score_170_c711,
    f_attr_arrest_recency_d > 99.5                                     => -0.0012199029,
    f_attr_arrest_recency_d = NULL                                     => -0.0042364910,
                                                                          -0.0006046787);

final_score_170 := map(
    NULL < r_a46_curr_avm_autoval_d AND r_a46_curr_avm_autoval_d <= 299952 => 0.0008365416,
    r_a46_curr_avm_autoval_d > 299952                                      => 0.0170850472,
    r_a46_curr_avm_autoval_d = NULL                                        => final_score_170_c710,
                                                                              0.0002565529);

final_score_171_c714 := map(
    NULL < r_i60_inq_banking_count12_i AND r_i60_inq_banking_count12_i <= 1.5 => 0.0040443271,
    r_i60_inq_banking_count12_i > 1.5                                         => -0.0290803569,
    r_i60_inq_banking_count12_i = NULL                                        => 0.0013485613,
                                                                                 0.0013485613);

final_score_171_c713 := map(
    NULL < f_assocrisktype_i AND f_assocrisktype_i <= 1.5 => 0.0179089401,
    f_assocrisktype_i > 1.5                               => final_score_171_c714,
    f_assocrisktype_i = NULL                              => 0.0068932487,
                                                             0.0068932487);

final_score_171 := map(
    NULL < f_srchfraudsrchcountyr_i AND f_srchfraudsrchcountyr_i <= 2.5 => -0.0008334155,
    f_srchfraudsrchcountyr_i > 2.5                                      => final_score_171_c713,
    f_srchfraudsrchcountyr_i = NULL                                     => 0.0034371127,
                                                                           0.0000680616);

final_score_172_c717 := map(
    NULL < r_c18_invalid_addrs_per_adl_i AND r_c18_invalid_addrs_per_adl_i <= 2.5 => 0.0005453346,
    r_c18_invalid_addrs_per_adl_i > 2.5                                           => -0.0061618995,
    r_c18_invalid_addrs_per_adl_i = NULL                                          => -0.0016003255,
                                                                                     -0.0016003255);

final_score_172_c716 := map(
    NULL < r_l75_add_curr_drop_delivery_i AND r_l75_add_curr_drop_delivery_i <= 0.5 => final_score_172_c717,
    r_l75_add_curr_drop_delivery_i > 0.5                                            => 0.0217945225,
    r_l75_add_curr_drop_delivery_i = NULL                                           => -0.0012808441,
                                                                                       -0.0012808441);

final_score_172 := map(
    NULL < f_rel_incomeover100_count_d AND f_rel_incomeover100_count_d <= 4.5 => final_score_172_c716,
    f_rel_incomeover100_count_d > 4.5                                         => 0.0233025728,
    f_rel_incomeover100_count_d = NULL                                        => -0.0001228246,
                                                                                 -0.0008653510);

final_score_173_c719 := map(
    NULL < f_add_input_nhood_sfd_pct_d AND f_add_input_nhood_sfd_pct_d <= 0.8551870918 => -0.0025630215,
    f_add_input_nhood_sfd_pct_d > 0.8551870918                                         => 0.0036346534,
    f_add_input_nhood_sfd_pct_d = NULL                                                 => -0.0005438140,
                                                                                          -0.0005438140);

final_score_173_c720 := map(
    NULL < f_add_curr_nhood_mfd_pct_i AND f_add_curr_nhood_mfd_pct_i <= 0.61537029905 => 0.0121247687,
    f_add_curr_nhood_mfd_pct_i > 0.61537029905                                        => -0.0148060518,
    f_add_curr_nhood_mfd_pct_i = NULL                                                 => 0.0368991686,
                                                                                         0.0130518720);

final_score_173 := map(
    NULL < f_rel_homeover50_count_d AND f_rel_homeover50_count_d <= 25.5 => final_score_173_c719,
    f_rel_homeover50_count_d > 25.5                                      => final_score_173_c720,
    f_rel_homeover50_count_d = NULL                                      => 0.0041596406,
                                                                            0.0005089958);

final_score_174_c723 := map(
    NULL < f_phones_per_addr_curr_i AND f_phones_per_addr_curr_i <= 5.5 => 0.0077998646,
    f_phones_per_addr_curr_i > 5.5                                      => 0.0400349935,
    f_phones_per_addr_curr_i = NULL                                     => 0.0205293524,
                                                                           0.0205293524);

final_score_174_c722 := map(
    NULL < f_add_curr_nhood_vac_pct_i AND f_add_curr_nhood_vac_pct_i <= 0.1775896626 => 0.0025245523,
    f_add_curr_nhood_vac_pct_i > 0.1775896626                                        => final_score_174_c723,
    f_add_curr_nhood_vac_pct_i = NULL                                                => 0.0047115297,
                                                                                        0.0047115297);

final_score_174 := map(
    NULL < f_srchfraudsrchcountyr_i AND f_srchfraudsrchcountyr_i <= 1.5 => -0.0006176826,
    f_srchfraudsrchcountyr_i > 1.5                                      => final_score_174_c722,
    f_srchfraudsrchcountyr_i = NULL                                     => 0.0126996394,
                                                                           0.0007272649);

final_score_175_c726 := map(
    NULL < r_d30_derog_count_i AND r_d30_derog_count_i <= 2.5 => -0.0027908992,
    r_d30_derog_count_i > 2.5                                 => 0.0192535133,
    r_d30_derog_count_i = NULL                                => 0.0079758461,
                                                                 0.0079758461);

final_score_175_c725 := map(
    NULL < f_inq_other_count24_i AND f_inq_other_count24_i <= 2.5 => -0.0015300013,
    f_inq_other_count24_i > 2.5                                   => final_score_175_c726,
    f_inq_other_count24_i = NULL                                  => -0.0008019166,
                                                                     -0.0008019166);

final_score_175 := map(
    NULL < f_rel_ageover40_count_d AND f_rel_ageover40_count_d <= 21.5 => final_score_175_c725,
    f_rel_ageover40_count_d > 21.5                                     => -0.0333978721,
    f_rel_ageover40_count_d = NULL                                     => 0.0070420950,
                                                                          -0.0005352178);

final_score_176_c728 := map(
    NULL < f_util_adl_count_n AND f_util_adl_count_n <= 1.5 => -0.0033652936,
    f_util_adl_count_n > 1.5                                => 0.0018247753,
    f_util_adl_count_n = NULL                               => 0.0038338218,
                                                               -0.0006695329);

final_score_176_c729 := map(
    NULL < f_m_bureau_adl_fs_notu_d AND f_m_bureau_adl_fs_notu_d <= 292.5 => 0.0355312246,
    f_m_bureau_adl_fs_notu_d > 292.5                                      => -0.0072578747,
    f_m_bureau_adl_fs_notu_d = NULL                                       => 0.0200279278,
                                                                             0.0200279278);

final_score_176 := map(
    NULL < r_l79_adls_per_addr_c6_i AND r_l79_adls_per_addr_c6_i <= 10.5 => final_score_176_c728,
    r_l79_adls_per_addr_c6_i > 10.5                                      => final_score_176_c729,
    r_l79_adls_per_addr_c6_i = NULL                                      => -0.0004298852,
                                                                            -0.0004298852);

final_score_177_c732 := map(
    NULL < f_rel_ageover40_count_d AND f_rel_ageover40_count_d <= 8.5 => 0.0392729764,
    f_rel_ageover40_count_d > 8.5                                     => 0.0034165894,
    f_rel_ageover40_count_d = NULL                                    => 0.0212426279,
                                                                         0.0212426279);

final_score_177_c731 := map(
    NULL < f_rel_ageover20_count_d AND f_rel_ageover20_count_d <= 27.5 => 0.0013796134,
    f_rel_ageover20_count_d > 27.5                                     => final_score_177_c732,
    f_rel_ageover20_count_d = NULL                                     => 0.0031342164,
                                                                          0.0023077848);

final_score_177 := map(
    NULL < r_c18_invalid_addrs_per_adl_i AND r_c18_invalid_addrs_per_adl_i <= 2.5 => final_score_177_c731,
    r_c18_invalid_addrs_per_adl_i > 2.5                                           => -0.0034754286,
    r_c18_invalid_addrs_per_adl_i = NULL                                          => -0.0023354539,
                                                                                     0.0004710367);

final_score_178_c734 := map(
    NULL < f_rel_under25miles_cnt_d AND f_rel_under25miles_cnt_d <= 32.5 => -0.0017585497,
    f_rel_under25miles_cnt_d > 32.5                                      => 0.0261618121,
    f_rel_under25miles_cnt_d = NULL                                      => 0.0012606152,
                                                                            -0.0012927953);

final_score_178_c735 := map(
    NULL < r_l80_inp_avm_autoval_d AND r_l80_inp_avm_autoval_d <= 229833.5 => 0.0034220204,
    r_l80_inp_avm_autoval_d > 229833.5                                     => 0.0270289096,
    r_l80_inp_avm_autoval_d = NULL                                         => -0.0019969450,
                                                                              0.0004181917);

final_score_178 := map(
    NULL < f_addrchangeecontrajindex_d AND f_addrchangeecontrajindex_d <= 4.5 => final_score_178_c734,
    f_addrchangeecontrajindex_d > 4.5                                         => 0.0230406992,
    f_addrchangeecontrajindex_d = NULL                                        => final_score_178_c735,
                                                                                 -0.0006251932);

final_score_179_c737 := map(
    NULL < f_add_input_mobility_index_i AND f_add_input_mobility_index_i <= 0.3107446377 => -0.0027445927,
    f_add_input_mobility_index_i > 0.3107446377                                          => 0.0027410568,
    f_add_input_mobility_index_i = NULL                                                  => -0.0132778925,
                                                                                            -0.0007215348);

final_score_179_c738 := map(
    NULL < f_add_input_nhood_bus_pct_i AND f_add_input_nhood_bus_pct_i <= 0.0863861904 => 0.0039257392,
    f_add_input_nhood_bus_pct_i > 0.0863861904                                         => 0.0301074136,
    f_add_input_nhood_bus_pct_i = NULL                                                 => 0.0139143207,
                                                                                          0.0139143207);

final_score_179 := map(
    NULL < f_divaddrsuspidcountnew_i AND f_divaddrsuspidcountnew_i <= 2.5 => final_score_179_c737,
    f_divaddrsuspidcountnew_i > 2.5                                       => final_score_179_c738,
    f_divaddrsuspidcountnew_i = NULL                                      => -0.0002672594,
                                                                             -0.0002464499);

final_score_180_c741 := map(
    NULL < f_add_curr_mobility_index_i AND f_add_curr_mobility_index_i <= 0.21437609 => -0.0133754512,
    f_add_curr_mobility_index_i > 0.21437609                                         => 0.0082703512,
    f_add_curr_mobility_index_i = NULL                                               => 0.0147917158,
                                                                                        0.0008503195);

final_score_180_c740 := map(
    NULL < f_add_curr_nhood_mfd_pct_i AND f_add_curr_nhood_mfd_pct_i <= 0.92853951235 => -0.0004280137,
    f_add_curr_nhood_mfd_pct_i > 0.92853951235                                        => 0.0121133857,
    f_add_curr_nhood_mfd_pct_i = NULL                                                 => final_score_180_c741,
                                                                                         0.0002996770);

final_score_180 := map(
    NULL < f_vardobcount_i AND f_vardobcount_i <= 2.5 => final_score_180_c740,
    f_vardobcount_i > 2.5                             => -0.0111947868,
    f_vardobcount_i = NULL                            => -0.0027869697,
                                                         -0.0005397259);

final_score_181_c744 := map(
    NULL < f_add_input_mobility_index_i AND f_add_input_mobility_index_i <= 0.376553789 => 0.0085191047,
    f_add_input_mobility_index_i > 0.376553789                                          => 0.0411093840,
    f_add_input_mobility_index_i = NULL                                                 => 0.0128097017,
                                                                                           0.0128097017);

final_score_181_c743 := map(
    NULL < f_m_bureau_adl_fs_notu_d AND f_m_bureau_adl_fs_notu_d <= 347.5 => final_score_181_c744,
    f_m_bureau_adl_fs_notu_d > 347.5                                      => -0.0268579184,
    f_m_bureau_adl_fs_notu_d = NULL                                       => 0.0091372397,
                                                                             0.0091372397);

final_score_181 := map(
    NULL < r_l80_inp_avm_autoval_d AND r_l80_inp_avm_autoval_d <= 32004.5 => final_score_181_c743,
    r_l80_inp_avm_autoval_d > 32004.5                                     => -0.0020013525,
    r_l80_inp_avm_autoval_d = NULL                                        => -0.0007897787,
                                                                             -0.0004712139);

final_score_182_c746 := map(
    NULL < f_util_add_curr_conv_n AND f_util_add_curr_conv_n <= 0.5 => -0.0025802380,
    f_util_add_curr_conv_n > 0.5                                    => 0.0025742472,
    f_util_add_curr_conv_n = NULL                                   => 0.0009328954,
                                                                       0.0009328954);

final_score_182_c747 := map(
    NULL < (real)k_nap_lname_verd_d AND (real)k_nap_lname_verd_d <= 0.5 => 0.0264653353,
    (real)k_nap_lname_verd_d > 0.5                                => -0.0233941743,
    (real)k_nap_lname_verd_d = NULL                               => 0.0065867073,
                                                               0.0065867073);

final_score_182 := map(
    NULL < f_mos_liens_rel_cj_lseen_d AND f_mos_liens_rel_cj_lseen_d <= 88.5 => -0.0190187729,
    f_mos_liens_rel_cj_lseen_d > 88.5                                        => final_score_182_c746,
    f_mos_liens_rel_cj_lseen_d = NULL                                        => final_score_182_c747,
                                                                                0.0006788735);

final_score_183_c749 := map(
    NULL < f_prevaddrmedianincome_d AND f_prevaddrmedianincome_d <= 77880.5 => 0.0002014513,
    f_prevaddrmedianincome_d > 77880.5                                      => 0.0115174206,
    f_prevaddrmedianincome_d = NULL                                         => 0.0008977356,
                                                                               0.0008977356);

final_score_183_c750 := map(
    NULL < f_add_input_nhood_vac_pct_i AND f_add_input_nhood_vac_pct_i <= 0.13360231335 => -0.0033887847,
    f_add_input_nhood_vac_pct_i > 0.13360231335                                         => -0.0246917545,
    f_add_input_nhood_vac_pct_i = NULL                                                  => -0.0064348796,
                                                                                           -0.0064348796);

final_score_183 := map(
    NULL < r_i60_inq_recency_d AND r_i60_inq_recency_d <= 549 => final_score_183_c749,
    r_i60_inq_recency_d > 549                                 => final_score_183_c750,
    r_i60_inq_recency_d = NULL                                => -0.0021842858,
                                                                 -0.0001123108);

final_score_184_c753 := map(
    NULL < f_hh_workers_paw_d AND f_hh_workers_paw_d <= 0.5 => 0.0069995842,
    f_hh_workers_paw_d > 0.5                                => -0.0017934507,
    f_hh_workers_paw_d = NULL                               => 0.0020546546,
                                                               0.0020546546);

final_score_184_c752 := map(
    NULL < f_crim_rel_under25miles_cnt_i AND f_crim_rel_under25miles_cnt_i <= 1.5 => -0.0027293493,
    f_crim_rel_under25miles_cnt_i > 1.5                                           => final_score_184_c753,
    f_crim_rel_under25miles_cnt_i = NULL                                          => -0.0005795621,
                                                                                     -0.0006390760);

final_score_184 := map(
    NULL < f_srchunvrfdaddrcount_i AND f_srchunvrfdaddrcount_i <= 2.5 => final_score_184_c752,
    f_srchunvrfdaddrcount_i > 2.5                                     => 0.0236166630,
    f_srchunvrfdaddrcount_i = NULL                                    => 0.0092803592,
                                                                         -0.0002730009);

final_score_185_c756 := map(
    NULL < f_addrchangeincomediff_d AND f_addrchangeincomediff_d <= 1976.5 => 0.0085207070,
    f_addrchangeincomediff_d > 1976.5                                      => 0.0465808580,
    f_addrchangeincomediff_d = NULL                                        => 0.0075667286,
                                                                              0.0103655088);

final_score_185_c755 := map(
    NULL < f_fp_prevaddrburglaryindex_i AND f_fp_prevaddrburglaryindex_i <= 45.5 => final_score_185_c756,
    f_fp_prevaddrburglaryindex_i > 45.5                                          => -0.0000713279,
    f_fp_prevaddrburglaryindex_i = NULL                                          => 0.0012533115,
                                                                                    0.0012533115);

final_score_185 := map(
    NULL < f_hh_members_w_derog_i AND f_hh_members_w_derog_i <= 0.5 => -0.0053752127,
    f_hh_members_w_derog_i > 0.5                                    => final_score_185_c755,
    f_hh_members_w_derog_i = NULL                                   => 0.0046818409,
                                                                       -0.0001297280);

final_score_186_c758 := map(
    NULL < f_liens_unrel_ot_total_amt_i AND f_liens_unrel_ot_total_amt_i <= 760 => -0.0000313921,
    f_liens_unrel_ot_total_amt_i > 760                                          => -0.0168428396,
    f_liens_unrel_ot_total_amt_i = NULL                                         => -0.0005544260,
                                                                                   -0.0005544260);

final_score_186_c759 := map(
    NULL < f_add_curr_nhood_bus_pct_i AND f_add_curr_nhood_bus_pct_i <= 0.1394077721 => 0.0042943198,
    f_add_curr_nhood_bus_pct_i > 0.1394077721                                        => -0.0278519203,
    f_add_curr_nhood_bus_pct_i = NULL                                                => -0.0091236204,
                                                                                        -0.0024347873);

final_score_186 := map(
    NULL < f_add_curr_nhood_mfd_pct_i AND f_add_curr_nhood_mfd_pct_i <= 0.93375045105 => final_score_186_c758,
    f_add_curr_nhood_mfd_pct_i > 0.93375045105                                        => 0.0116318762,
    f_add_curr_nhood_mfd_pct_i = NULL                                                 => final_score_186_c759,
                                                                                         -0.0002728569);

final_score_187_c762 := map(
    NULL < k_comb_age_d AND k_comb_age_d <= 28.5 => 0.0171563381,
    k_comb_age_d > 28.5                          => -0.0012714073,
    k_comb_age_d = NULL                          => 0.0012611684,
                                                    0.0012611684);

final_score_187_c761 := map(
    NULL < f_rel_incomeover75_count_d AND f_rel_incomeover75_count_d <= 0.5 => -0.0065019483,
    f_rel_incomeover75_count_d > 0.5                                        => final_score_187_c762,
    f_rel_incomeover75_count_d = NULL                                       => 0.0035331239,
                                                                               -0.0024032555);

final_score_187 := map(
    NULL < f_prevaddrcartheftindex_i AND f_prevaddrcartheftindex_i <= 152.5 => final_score_187_c761,
    f_prevaddrcartheftindex_i > 152.5                                       => 0.0030926094,
    f_prevaddrcartheftindex_i = NULL                                        => -0.0129041217,
                                                                               -0.0002065688);

final_score_188_c764 := map(
    NULL < f_crim_rel_under25miles_cnt_i AND f_crim_rel_under25miles_cnt_i <= 2.5 => -0.0026871324,
    f_crim_rel_under25miles_cnt_i > 2.5                                           => 0.0034219559,
    f_crim_rel_under25miles_cnt_i = NULL                                          => -0.0024321878,
                                                                                     -0.0008543707);

final_score_188_c765 := map(
    NULL < f_add_curr_mobility_index_i AND f_add_curr_mobility_index_i <= 0.3122868808 => 0.0044777141,
    f_add_curr_mobility_index_i > 0.3122868808                                         => 0.0352730805,
    f_add_curr_mobility_index_i = NULL                                                 => 0.0153850239,
                                                                                          0.0153850239);

final_score_188 := map(
    NULL < k_comb_age_d AND k_comb_age_d <= 73.5 => final_score_188_c764,
    k_comb_age_d > 73.5                          => final_score_188_c765,
    k_comb_age_d = NULL                          => -0.0001492600,
                                                    -0.0001492600);

final_score_189_c768 := map(
    NULL < r_c13_curr_addr_lres_d AND r_c13_curr_addr_lres_d <= 1.5 => 0.0163043670,
    r_c13_curr_addr_lres_d > 1.5                                    => 0.0007671636,
    r_c13_curr_addr_lres_d = NULL                                   => 0.0012897138,
                                                                       0.0012897138);

final_score_189_c767 := map(
    NULL < f_add_input_nhood_vac_pct_i AND f_add_input_nhood_vac_pct_i <= 0.4594944191 => final_score_189_c768,
    f_add_input_nhood_vac_pct_i > 0.4594944191                                         => -0.0133707072,
    f_add_input_nhood_vac_pct_i = NULL                                                 => 0.0007595957,
                                                                                          0.0007595957);

final_score_189 := map(
    NULL < f_hh_payday_loan_users_i AND f_hh_payday_loan_users_i <= 1.5 => final_score_189_c767,
    f_hh_payday_loan_users_i > 1.5                                      => -0.0169683802,
    f_hh_payday_loan_users_i = NULL                                     => -0.0075320182,
                                                                           0.0002983381);

final_score_190_c770 := map(
    NULL < f_addrs_per_ssn_i AND f_addrs_per_ssn_i <= 2.5 => -0.0079940085,
    f_addrs_per_ssn_i > 2.5                               => 0.0010530177,
    f_addrs_per_ssn_i = NULL                              => 0.0002985557,
                                                             0.0002985557);

final_score_190_c771 := map(
    NULL < f_mos_liens_unrel_sc_fseen_d AND f_mos_liens_unrel_sc_fseen_d <= 121.5 => 0.0200052400,
    f_mos_liens_unrel_sc_fseen_d > 121.5                                          => -0.0253114698,
    f_mos_liens_unrel_sc_fseen_d = NULL                                           => -0.0181489504,
                                                                                     -0.0181489504);

final_score_190 := map(
    NULL < r_d34_unrel_liens_ct_i AND r_d34_unrel_liens_ct_i <= 5.5 => final_score_190_c770,
    r_d34_unrel_liens_ct_i > 5.5                                    => final_score_190_c771,
    r_d34_unrel_liens_ct_i = NULL                                   => -0.0052025319,
                                                                       -0.0002571053);

final_score_191_c774 := map(
    NULL < f_mos_liens_rel_cj_fseen_d AND f_mos_liens_rel_cj_fseen_d <= 277 => 0.0463093036,
    f_mos_liens_rel_cj_fseen_d > 277                                        => 0.0053969785,
    f_mos_liens_rel_cj_fseen_d = NULL                                       => 0.0103737908,
                                                                               0.0103737908);

final_score_191_c773 := map(
    NULL < f_varrisktype_i AND f_varrisktype_i <= 3.5 => final_score_191_c774,
    f_varrisktype_i > 3.5                             => 0.0495265012,
    f_varrisktype_i = NULL                            => 0.0143111109,
                                                         0.0143111109);

final_score_191 := map(
    NULL < f_prevaddrmedianvalue_d AND f_prevaddrmedianvalue_d <= 409717 => 0.0008075785,
    f_prevaddrmedianvalue_d > 409717                                     => final_score_191_c773,
    f_prevaddrmedianvalue_d = NULL                                       => 0.0015732702,
                                                                            0.0015012904);

final_score_192_c777 := map(
    NULL < f_add_curr_nhood_bus_pct_i AND f_add_curr_nhood_bus_pct_i <= 0.15259799555 => 0.0084625182,
    f_add_curr_nhood_bus_pct_i > 0.15259799555                                        => 0.0393494612,
    f_add_curr_nhood_bus_pct_i = NULL                                                 => 0.0118969618,
                                                                                         0.0118969618);

final_score_192_c776 := map(
    NULL < r_i60_inq_retpymt_recency_d AND r_i60_inq_retpymt_recency_d <= 549 => -0.0222906793,
    r_i60_inq_retpymt_recency_d > 549                                         => final_score_192_c777,
    r_i60_inq_retpymt_recency_d = NULL                                        => 0.0090631056,
                                                                                 0.0090631056);

final_score_192 := map(
    NULL < k_comb_age_d AND k_comb_age_d <= 23.5 => final_score_192_c776,
    k_comb_age_d > 23.5                          => -0.0002908015,
    k_comb_age_d = NULL                          => 0.0003178432,
                                                    0.0003178432);

final_score_193_c780 := map(
    NULL < k_comb_age_d AND k_comb_age_d <= 74.5 => -0.0009518044,
    k_comb_age_d > 74.5                          => 0.0183572701,
    k_comb_age_d = NULL                          => -0.0001852680,
                                                    -0.0001852680);

final_score_193_c779 := map(
    NULL < r_l80_inp_avm_autoval_d AND r_l80_inp_avm_autoval_d <= 52206.5 => 0.0047147405,
    r_l80_inp_avm_autoval_d > 52206.5                                     => -0.0046016386,
    r_l80_inp_avm_autoval_d = NULL                                        => final_score_193_c780,
                                                                             -0.0006126709);

final_score_193 := map(
    NULL < k_comb_age_d AND k_comb_age_d <= 20.5 => 0.0170054725,
    k_comb_age_d > 20.5                          => final_score_193_c779,
    k_comb_age_d = NULL                          => -0.0003461865,
                                                    -0.0003461865);

final_score_194_c783 := map(
    NULL < f_curraddrburglaryindex_i AND f_curraddrburglaryindex_i <= 137.5 => 0.0330903950,
    f_curraddrburglaryindex_i > 137.5                                       => -0.0022026161,
    f_curraddrburglaryindex_i = NULL                                        => 0.0147531010,
                                                                               0.0147531010);

final_score_194_c782 := map(
    NULL < f_srchunvrfdssncount_i AND f_srchunvrfdssncount_i <= 1.5 => -0.0003992348,
    f_srchunvrfdssncount_i > 1.5                                    => final_score_194_c783,
    f_srchunvrfdssncount_i = NULL                                   => -0.0000298260,
                                                                       -0.0000298260);

final_score_194 := map(
    NULL < f_addrs_per_ssn_i AND f_addrs_per_ssn_i <= 1.5 => -0.0113830853,
    f_addrs_per_ssn_i > 1.5                               => final_score_194_c782,
    f_addrs_per_ssn_i = NULL                              => -0.0007093182,
                                                             -0.0007093182);

final_score_195_c785 := map(
    NULL < k_inq_ssns_per_addr_i AND k_inq_ssns_per_addr_i <= 1.5 => -0.0024425829,
    k_inq_ssns_per_addr_i > 1.5                                   => 0.0075227848,
    k_inq_ssns_per_addr_i = NULL                                  => 0.0005250919,
                                                                     0.0005250919);

final_score_195_c786 := map(
    NULL < f_hh_college_attendees_d AND f_hh_college_attendees_d <= 0.5 => -0.0003601373,
    f_hh_college_attendees_d > 0.5                                      => -0.0141127969,
    f_hh_college_attendees_d = NULL                                     => -0.0019590352,
                                                                           -0.0012934220);

final_score_195 := map(
    NULL < r_a46_curr_avm_autoval_d AND r_a46_curr_avm_autoval_d <= 269355.5 => final_score_195_c785,
    r_a46_curr_avm_autoval_d > 269355.5                                      => 0.0166755947,
    r_a46_curr_avm_autoval_d = NULL                                          => final_score_195_c786,
                                                                                -0.0002122640);

final_score_196_c789 := map(
    NULL < f_srchfraudsrchcountwk_i AND f_srchfraudsrchcountwk_i <= 0.5 => 0.0011627188,
    f_srchfraudsrchcountwk_i > 0.5                                      => -0.0078277728,
    f_srchfraudsrchcountwk_i = NULL                                     => -0.0026861849,
                                                                           -0.0000454684);

final_score_196_c788 := map(
    NULL < f_add_input_nhood_vac_pct_i AND f_add_input_nhood_vac_pct_i <= 0.244577668 => final_score_196_c789,
    f_add_input_nhood_vac_pct_i > 0.244577668                                         => 0.0165190555,
    f_add_input_nhood_vac_pct_i = NULL                                                => 0.0004563795,
                                                                                         0.0004563795);

final_score_196 := map(
    NULL < f_add_input_nhood_vac_pct_i AND f_add_input_nhood_vac_pct_i <= 0.378300131 => final_score_196_c788,
    f_add_input_nhood_vac_pct_i > 0.378300131                                         => -0.0117581008,
    f_add_input_nhood_vac_pct_i = NULL                                                => -0.0001207806,
                                                                                         -0.0001207806);

final_score_197_c792 := map(
    NULL < f_srchunvrfdaddrcount_i AND f_srchunvrfdaddrcount_i <= 0.5 => -0.0044522980,
    f_srchunvrfdaddrcount_i > 0.5                                     => 0.0347944908,
    f_srchunvrfdaddrcount_i = NULL                                    => 0.0017630300,
                                                                         0.0017630300);

final_score_197_c791 := map(
    NULL < f_fp_prevaddrcrimeindex_i AND f_fp_prevaddrcrimeindex_i <= 121 => final_score_197_c792,
    f_fp_prevaddrcrimeindex_i > 121                                       => -0.0176181776,
    f_fp_prevaddrcrimeindex_i = NULL                                      => -0.0092524193,
                                                                             -0.0092524193);

final_score_197 := map(
    NULL < f_util_add_curr_inf_n AND f_util_add_curr_inf_n <= 0.5 => 0.0010559445,
    f_util_add_curr_inf_n > 0.5                                   => final_score_197_c791,
    f_util_add_curr_inf_n = NULL                                  => 0.0002935761,
                                                                     0.0002935761);

final_score_198_c794 := map(
    NULL < f_add_curr_nhood_mfd_pct_i AND f_add_curr_nhood_mfd_pct_i <= 0.54573975715 => 0.0120178124,
    f_add_curr_nhood_mfd_pct_i > 0.54573975715                                        => -0.0098234094,
    f_add_curr_nhood_mfd_pct_i = NULL                                                 => 0.0005707512,
                                                                                         0.0083452408);

final_score_198_c795 := map(
    NULL < f_addrs_per_ssn_i AND f_addrs_per_ssn_i <= 2.5 => -0.0065991206,
    f_addrs_per_ssn_i > 2.5                               => 0.0165699041,
    f_addrs_per_ssn_i = NULL                              => 0.0030733848,
                                                             0.0030733848);

final_score_198 := map(
    NULL < f_rel_under25miles_cnt_d AND f_rel_under25miles_cnt_d <= 15.5 => -0.0014080266,
    f_rel_under25miles_cnt_d > 15.5                                      => final_score_198_c794,
    f_rel_under25miles_cnt_d = NULL                                      => final_score_198_c795,
                                                                            0.0001547869);

final_score_199_c797 := map(
    NULL < r_l80_inp_avm_autoval_d AND r_l80_inp_avm_autoval_d <= 31878 => 0.0084966809,
    r_l80_inp_avm_autoval_d > 31878                                     => -0.0028589485,
    r_l80_inp_avm_autoval_d = NULL                                      => -0.0001207095,
                                                                           -0.0003062811);

final_score_199_c798 := map(
    NULL < f_add_input_nhood_mfd_pct_i AND f_add_input_nhood_mfd_pct_i <= 0.23937520535 => -0.0083532346,
    f_add_input_nhood_mfd_pct_i > 0.23937520535                                         => 0.0225510624,
    f_add_input_nhood_mfd_pct_i = NULL                                                  => 0.0094808656,
                                                                                           0.0094808656);

final_score_199 := map(
    NULL < f_varrisktype_i AND f_varrisktype_i <= 6.5 => final_score_199_c797,
    f_varrisktype_i > 6.5                             => 0.0138894620,
    f_varrisktype_i = NULL                            => final_score_199_c798,
                                                         0.0002494298);

final_score_200_c801 := map(
    NULL < f_addrchangevaluediff_d AND f_addrchangevaluediff_d <= 214474 => -0.0000780140,
    f_addrchangevaluediff_d > 214474                                     => 0.0272673105,
    f_addrchangevaluediff_d = NULL                                       => -0.0007089149,
                                                                            0.0001095139);

final_score_200_c800 := map(
    NULL < f_srchunvrfdssncount_i AND f_srchunvrfdssncount_i <= 0.5 => final_score_200_c801,
    f_srchunvrfdssncount_i > 0.5                                    => 0.0134052930,
    f_srchunvrfdssncount_i = NULL                                   => 0.0015021867,
                                                                       0.0015021867);

final_score_200 := map(
    NULL < r_i60_inq_comm_count12_i AND r_i60_inq_comm_count12_i <= 1.5 => final_score_200_c800,
    r_i60_inq_comm_count12_i > 1.5                                      => -0.0037950565,
    r_i60_inq_comm_count12_i = NULL                                     => 0.0072948897,
                                                                           -0.0002775659);

final_score_201_c804 := map(
    NULL < f_hh_age_65_plus_d AND f_hh_age_65_plus_d <= 0.5 => -0.0214492842,
    f_hh_age_65_plus_d > 0.5                                => 0.0221182709,
    f_hh_age_65_plus_d = NULL                               => -0.0068985668,
                                                               -0.0068985668);

final_score_201_c803 := map(
    NULL < r_a49_curr_avm_chg_1yr_i AND r_a49_curr_avm_chg_1yr_i <= 46462 => 0.0032799847,
    r_a49_curr_avm_chg_1yr_i > 46462                                      => final_score_201_c804,
    r_a49_curr_avm_chg_1yr_i = NULL                                       => -0.0016984619,
                                                                             -0.0005100117);

final_score_201 := map(
    NULL < r_i60_inq_prepaidcards_recency_d AND r_i60_inq_prepaidcards_recency_d <= 9 => 0.0200177118,
    r_i60_inq_prepaidcards_recency_d > 9                                              => final_score_201_c803,
    r_i60_inq_prepaidcards_recency_d = NULL                                           => 0.0064102850,
                                                                                         -0.0001853926);

final_score_202_c806 := map(
    NULL < r_c20_email_count_i AND r_c20_email_count_i <= 4.5 => 0.0013335319,
    r_c20_email_count_i > 4.5                                 => -0.0070689037,
    r_c20_email_count_i = NULL                                => -0.0010782592,
                                                                 0.0003428406);

final_score_202_c807 := map(
    NULL < r_l79_adls_per_addr_curr_i AND r_l79_adls_per_addr_curr_i <= 6.5 => 0.0318175986,
    r_l79_adls_per_addr_curr_i > 6.5                                        => -0.0074569686,
    r_l79_adls_per_addr_curr_i = NULL                                       => 0.0204826602,
                                                                               0.0204826602);

final_score_202 := map(
    NULL < k_inq_ssns_per_addr_i AND k_inq_ssns_per_addr_i <= 5.5 => final_score_202_c806,
    k_inq_ssns_per_addr_i > 5.5                                   => final_score_202_c807,
    k_inq_ssns_per_addr_i = NULL                                  => 0.0006762052,
                                                                     0.0006762052);

final_score_203_c809 := map(
    NULL < r_d33_eviction_recency_d AND r_d33_eviction_recency_d <= 48 => 0.0396343495,
    r_d33_eviction_recency_d > 48                                      => 0.0047559775,
    r_d33_eviction_recency_d = NULL                                    => 0.0080493092,
                                                                          0.0080493092);

final_score_203_c810 := map(
    NULL < f_add_input_nhood_mfd_pct_i AND f_add_input_nhood_mfd_pct_i <= 0.5260372495 => -0.0021558703,
    f_add_input_nhood_mfd_pct_i > 0.5260372495                                         => -0.0131089449,
    f_add_input_nhood_mfd_pct_i = NULL                                                 => 0.0068651205,
                                                                                          -0.0020261401);

final_score_203 := map(
    NULL < r_l80_inp_avm_autoval_d AND r_l80_inp_avm_autoval_d <= 32009 => final_score_203_c809,
    r_l80_inp_avm_autoval_d > 32009                                     => final_score_203_c810,
    r_l80_inp_avm_autoval_d = NULL                                      => 0.0012383290,
                                                                           0.0008050555);

final_score_204_c813 := map(
    NULL < f_rel_homeover150_count_d AND f_rel_homeover150_count_d <= 11.5 => 0.0006354155,
    f_rel_homeover150_count_d > 11.5                                       => -0.0080756797,
    f_rel_homeover150_count_d = NULL                                       => -0.0001422316,
                                                                              -0.0001422316);

final_score_204_c812 := map(
    NULL < f_mos_liens_rel_cj_lseen_d AND f_mos_liens_rel_cj_lseen_d <= 62.5 => -0.0303351322,
    f_mos_liens_rel_cj_lseen_d > 62.5                                        => final_score_204_c813,
    f_mos_liens_rel_cj_lseen_d = NULL                                        => -0.0003871805,
                                                                                -0.0003871805);

final_score_204 := map(
    NULL < f_rel_incomeover100_count_d AND f_rel_incomeover100_count_d <= 6.5 => final_score_204_c812,
    f_rel_incomeover100_count_d > 6.5                                         => 0.0262604072,
    f_rel_incomeover100_count_d = NULL                                        => -0.0067941420,
                                                                                 -0.0005401099);

final_score_205_c816 := map(
    NULL < f_prevaddrmedianincome_d AND f_prevaddrmedianincome_d <= 19894 => 0.0106102811,
    f_prevaddrmedianincome_d > 19894                                      => -0.0008347286,
    f_prevaddrmedianincome_d = NULL                                       => 0.0003104828,
                                                                             0.0003104828);

final_score_205_c815 := map(
    NULL < f_fp_prevaddrburglaryindex_i AND f_fp_prevaddrburglaryindex_i <= 61.5 => 0.0085210710,
    f_fp_prevaddrburglaryindex_i > 61.5                                          => final_score_205_c816,
    f_fp_prevaddrburglaryindex_i = NULL                                          => 0.0014017457,
                                                                                    0.0014017457);

final_score_205 := map(
    NULL < f_curraddrmurderindex_i AND f_curraddrmurderindex_i <= 46.5 => -0.0066299559,
    f_curraddrmurderindex_i > 46.5                                     => final_score_205_c815,
    f_curraddrmurderindex_i = NULL                                     => -0.0058220118,
                                                                          0.0000711099);

final_score_206_c819 := map(
    NULL < f_phones_per_addr_c6_i AND f_phones_per_addr_c6_i <= 0.5 => 0.0012170881,
    f_phones_per_addr_c6_i > 0.5                                    => 0.0207029998,
    f_phones_per_addr_c6_i = NULL                                   => 0.0090706318,
                                                                       0.0090706318);

final_score_206_c818 := map(
    NULL < f_fp_prevaddrburglaryindex_i AND f_fp_prevaddrburglaryindex_i <= 61.5 => final_score_206_c819,
    f_fp_prevaddrburglaryindex_i > 61.5                                          => 0.0004712243,
    f_fp_prevaddrburglaryindex_i = NULL                                          => 0.0021151752,
                                                                                    0.0021151752);

final_score_206 := map(
    NULL < f_util_add_curr_conv_n AND f_util_add_curr_conv_n <= 0.5 => -0.0036793050,
    f_util_add_curr_conv_n > 0.5                                    => final_score_206_c818,
    f_util_add_curr_conv_n = NULL                                   => 0.0002269136,
                                                                       0.0002269136);

final_score_207_c822 := map(
    NULL < f_rel_under25miles_cnt_d AND f_rel_under25miles_cnt_d <= 17.5 => 0.0084394900,
    f_rel_under25miles_cnt_d > 17.5                                      => 0.0434509614,
    f_rel_under25miles_cnt_d = NULL                                      => 0.0120754172,
                                                                            0.0120754172);

final_score_207_c821 := map(
    NULL < f_attr_arrest_recency_d AND f_attr_arrest_recency_d <= 99.5 => final_score_207_c822,
    f_attr_arrest_recency_d > 99.5                                     => 0.0003979851,
    f_attr_arrest_recency_d = NULL                                     => 0.0010288771,
                                                                          0.0010288771);

final_score_207 := map(
    NULL < f_rel_ageover40_count_d AND f_rel_ageover40_count_d <= 8.5 => final_score_207_c821,
    f_rel_ageover40_count_d > 8.5                                     => -0.0076614990,
    f_rel_ageover40_count_d = NULL                                    => 0.0021540324,
                                                                         0.0002139854);

final_score_208_c824 := map(
    NULL < f_phones_per_addr_curr_i AND f_phones_per_addr_curr_i <= 3.5 => -0.0021586117,
    f_phones_per_addr_curr_i > 3.5                                      => 0.0022167093,
    f_phones_per_addr_curr_i = NULL                                     => 0.0001620146,
                                                                           0.0001620146);

final_score_208_c825 := map(
    NULL < (real)k_nap_lname_verd_d AND (real)k_nap_lname_verd_d <= 0.5 => 0.0093151223,
    (real)k_nap_lname_verd_d > 0.5                                => -0.0317045963,
    (real)k_nap_lname_verd_d = NULL                               => -0.0084126425,
                                                               -0.0084126425);

final_score_208 := map(
    NULL < r_c16_inv_ssn_per_adl_i AND r_c16_inv_ssn_per_adl_i <= 0.5 => final_score_208_c824,
    r_c16_inv_ssn_per_adl_i > 0.5                                     => -0.0317438116,
    r_c16_inv_ssn_per_adl_i = NULL                                    => final_score_208_c825,
                                                                         -0.0001491263);

final_score_209_c828 := map(
    NULL < f_rel_homeover50_count_d AND f_rel_homeover50_count_d <= 25.5 => 0.0010751515,
    f_rel_homeover50_count_d > 25.5                                      => 0.0315066165,
    f_rel_homeover50_count_d = NULL                                      => 0.0017057458,
                                                                            0.0017057458);

final_score_209_c827 := map(
    NULL < f_rel_ageover40_count_d AND f_rel_ageover40_count_d <= 3.5 => final_score_209_c828,
    f_rel_ageover40_count_d > 3.5                                     => -0.0036720186,
    f_rel_ageover40_count_d = NULL                                    => -0.0015273812,
                                                                         -0.0003068794);

final_score_209 := map(
    NULL < f_srchcountwk_i AND f_srchcountwk_i <= 2.5 => final_score_209_c827,
    f_srchcountwk_i > 2.5                             => -0.0179776051,
    f_srchcountwk_i = NULL                            => 0.0032928013,
                                                         -0.0006860651);

final_score_210_c830 := map(
    NULL < f_prevaddrcartheftindex_i AND f_prevaddrcartheftindex_i <= 42 => -0.0042785980,
    f_prevaddrcartheftindex_i > 42                                       => 0.0091305607,
    f_prevaddrcartheftindex_i = NULL                                     => 0.0039502228,
                                                                            0.0039502228);

final_score_210_c831 := map(
    NULL < f_curraddrmedianincome_d AND f_curraddrmedianincome_d <= 13486 => 0.0172330419,
    f_curraddrmedianincome_d > 13486                                      => -0.0026951279,
    f_curraddrmedianincome_d = NULL                                       => -0.0022091013,
                                                                             -0.0022091013);

final_score_210 := map(
    NULL < f_curraddrburglaryindex_i AND f_curraddrburglaryindex_i <= 68 => final_score_210_c830,
    f_curraddrburglaryindex_i > 68                                       => final_score_210_c831,
    f_curraddrburglaryindex_i = NULL                                     => 0.0129876709,
                                                                            -0.0005784405);

final_score_211_c834 := map(
    NULL < f_prevaddrmedianvalue_d AND f_prevaddrmedianvalue_d <= 47300.5 => 0.0236508591,
    f_prevaddrmedianvalue_d > 47300.5                                     => 0.0047882052,
    f_prevaddrmedianvalue_d = NULL                                        => 0.0070052562,
                                                                             0.0070052562);

final_score_211_c833 := map(
    NULL < f_add_curr_nhood_vac_pct_i AND f_add_curr_nhood_vac_pct_i <= 0.0412887122 => -0.0004082054,
    f_add_curr_nhood_vac_pct_i > 0.0412887122                                        => final_score_211_c834,
    f_add_curr_nhood_vac_pct_i = NULL                                                => 0.0031531707,
                                                                                        0.0031531707);

final_score_211 := map(
    NULL < f_hh_age_18_plus_d AND f_hh_age_18_plus_d <= 1.5 => final_score_211_c833,
    f_hh_age_18_plus_d > 1.5                                => -0.0015345539,
    f_hh_age_18_plus_d = NULL                               => 0.0066555706,
                                                               0.0004754956);

final_score_212_c836 := map(
    NULL < r_d32_felony_count_i AND r_d32_felony_count_i <= 4.5 => -0.0018950968,
    r_d32_felony_count_i > 4.5                                  => 0.0212002316,
    r_d32_felony_count_i = NULL                                 => -0.0015176528,
                                                                   -0.0015176528);

final_score_212_c837 := map(
    NULL < f_curraddrmedianvalue_d AND f_curraddrmedianvalue_d <= 71379 => -0.0053658080,
    f_curraddrmedianvalue_d > 71379                                     => 0.0062265378,
    f_curraddrmedianvalue_d = NULL                                      => 0.0033999550,
                                                                           0.0033999550);

final_score_212 := map(
    NULL < f_rel_under25miles_cnt_d AND f_rel_under25miles_cnt_d <= 9.5 => final_score_212_c836,
    f_rel_under25miles_cnt_d > 9.5                                      => final_score_212_c837,
    f_rel_under25miles_cnt_d = NULL                                     => -0.0007051316,
                                                                           0.0001196905);

final_score_213_c840 := map(
    NULL < f_m_bureau_adl_fs_all_d AND f_m_bureau_adl_fs_all_d <= 237.5 => 0.0436746004,
    f_m_bureau_adl_fs_all_d > 237.5                                     => -0.0163726412,
    f_m_bureau_adl_fs_all_d = NULL                                      => 0.0053286426,
                                                                           0.0053286426);

final_score_213_c839 := map(
    NULL < r_a46_curr_avm_autoval_d AND r_a46_curr_avm_autoval_d <= 81561.5 => -0.0288448333,
    r_a46_curr_avm_autoval_d > 81561.5                                      => final_score_213_c840,
    r_a46_curr_avm_autoval_d = NULL                                         => -0.0128493260,
                                                                               -0.0125354595);

final_score_213 := map(
    NULL < f_vardobcount_i AND f_vardobcount_i <= 2.5 => 0.0000504083,
    f_vardobcount_i > 2.5                             => final_score_213_c839,
    f_vardobcount_i = NULL                            => -0.0052022983,
                                                         -0.0008393093);

final_score_214_c843 := map(
    NULL < f_varrisktype_i AND f_varrisktype_i <= 5.5 => -0.0044377545,
    f_varrisktype_i > 5.5                             => 0.0110086043,
    f_varrisktype_i = NULL                            => -0.0029385802,
                                                         -0.0029385802);

final_score_214_c842 := map(
    NULL < r_i60_inq_comm_count12_i AND r_i60_inq_comm_count12_i <= 1.5 => 0.0034385284,
    r_i60_inq_comm_count12_i > 1.5                                      => final_score_214_c843,
    r_i60_inq_comm_count12_i = NULL                                     => 0.0011907707,
                                                                           0.0011907707);

final_score_214 := map(
    NULL < f_rel_ageover40_count_d AND f_rel_ageover40_count_d <= 8.5 => final_score_214_c842,
    f_rel_ageover40_count_d > 8.5                                     => -0.0086379060,
    f_rel_ageover40_count_d = NULL                                    => 0.0010771634,
                                                                         0.0001956288);

final_score_215_c846 := map(
    NULL < f_liens_unrel_o_total_amt_i AND f_liens_unrel_o_total_amt_i <= 294.5 => 0.0002044883,
    f_liens_unrel_o_total_amt_i > 294.5                                         => -0.0111544391,
    f_liens_unrel_o_total_amt_i = NULL                                          => -0.0004551154,
                                                                                   -0.0004551154);

final_score_215_c845 := map(
    NULL < r_d32_felony_count_i AND r_d32_felony_count_i <= 9.5 => final_score_215_c846,
    r_d32_felony_count_i > 9.5                                  => 0.0345856192,
    r_d32_felony_count_i = NULL                                 => -0.0002975822,
                                                                   -0.0002975822);

final_score_215 := map(
    NULL < f_assocsuspicousidcount_i AND f_assocsuspicousidcount_i <= 7.5 => final_score_215_c845,
    f_assocsuspicousidcount_i > 7.5                                       => 0.0165320314,
    f_assocsuspicousidcount_i = NULL                                      => -0.0053951525,
                                                                             0.0000869540);

final_score_216_c849 := map(
    NULL < r_c14_addrs_10yr_i AND r_c14_addrs_10yr_i <= 1.5 => -0.0058358802,
    r_c14_addrs_10yr_i > 1.5                                => 0.0170332197,
    r_c14_addrs_10yr_i = NULL                               => 0.0095894201,
                                                               0.0095894201);

final_score_216_c848 := map(
    NULL < k_comb_age_d AND k_comb_age_d <= 23.5 => final_score_216_c849,
    k_comb_age_d > 23.5                          => -0.0005553898,
    k_comb_age_d = NULL                          => 0.0000263041,
                                                    0.0000263041);

final_score_216 := map(
    NULL < f_vardobcount_i AND f_vardobcount_i <= 0.5 => -0.0198363077,
    f_vardobcount_i > 0.5                             => final_score_216_c848,
    f_vardobcount_i = NULL                            => 0.0050623267,
                                                         -0.0003115342);

final_score_217_c852 := map(
    NULL < f_rel_ageover40_count_d AND f_rel_ageover40_count_d <= 9.5 => 0.0047875770,
    f_rel_ageover40_count_d > 9.5                                     => -0.0310311183,
    f_rel_ageover40_count_d = NULL                                    => 0.0008672895,
                                                                         0.0008672895);

final_score_217_c851 := map(
    NULL < r_c20_email_count_i AND r_c20_email_count_i <= 1.5 => 0.0198211509,
    r_c20_email_count_i > 1.5                                 => final_score_217_c852,
    r_c20_email_count_i = NULL                                => 0.0087775731,
                                                                 0.0087775731);

final_score_217 := map(
    NULL < f_inq_other_count24_i AND f_inq_other_count24_i <= 2.5 => -0.0007701637,
    f_inq_other_count24_i > 2.5                                   => final_score_217_c851,
    f_inq_other_count24_i = NULL                                  => 0.0011764585,
                                                                     -0.0000276963);

final_score_218_c855 := map(
    NULL < r_a46_curr_avm_autoval_d AND r_a46_curr_avm_autoval_d <= 194945 => 0.0031848651,
    r_a46_curr_avm_autoval_d > 194945                                      => 0.0237426909,
    r_a46_curr_avm_autoval_d = NULL                                        => 0.0036586262,
                                                                              0.0044167061);

final_score_218_c854 := map(
    NULL < f_mos_liens_rel_cj_lseen_d AND f_mos_liens_rel_cj_lseen_d <= 88.5 => -0.0310485939,
    f_mos_liens_rel_cj_lseen_d > 88.5                                        => final_score_218_c855,
    f_mos_liens_rel_cj_lseen_d = NULL                                        => 0.0037575120,
                                                                                0.0037575120);

final_score_218 := map(
    NULL < f_varrisktype_i AND f_varrisktype_i <= 1.5 => -0.0020954980,
    f_varrisktype_i > 1.5                             => final_score_218_c854,
    f_varrisktype_i = NULL                            => 0.0016804436,
                                                         0.0005334922);

final_score_219_c857 := map(
    NULL < r_l72_add_vacant_i AND r_l72_add_vacant_i <= 0.5 => 0.0028283054,
    r_l72_add_vacant_i > 0.5                                => 0.0433247037,
    r_l72_add_vacant_i = NULL                               => 0.0035947208,
                                                               0.0035947208);

final_score_219_c858 := map(
    NULL < r_a46_curr_avm_autoval_d AND r_a46_curr_avm_autoval_d <= 129950 => -0.0047639371,
    r_a46_curr_avm_autoval_d > 129950                                      => 0.0192969069,
    r_a46_curr_avm_autoval_d = NULL                                        => 0.0005213829,
                                                                              0.0006194693);

final_score_219 := map(
    NULL < r_a49_curr_avm_chg_1yr_i AND r_a49_curr_avm_chg_1yr_i <= 61888 => final_score_219_c857,
    r_a49_curr_avm_chg_1yr_i > 61888                                      => -0.0220443575,
    r_a49_curr_avm_chg_1yr_i = NULL                                       => final_score_219_c858,
                                                                             0.0011611740);

final_score_220_c861 := map(
    NULL < f_rel_under100miles_cnt_d AND f_rel_under100miles_cnt_d <= 4.5 => -0.0060032968,
    f_rel_under100miles_cnt_d > 4.5                                       => 0.0226349618,
    f_rel_under100miles_cnt_d = NULL                                      => 0.0159228699,
                                                                             0.0159228699);

final_score_220_c860 := map(
    NULL < r_c10_m_hdr_fs_d AND r_c10_m_hdr_fs_d <= 167.5 => -0.0058500732,
    r_c10_m_hdr_fs_d > 167.5                              => final_score_220_c861,
    r_c10_m_hdr_fs_d = NULL                               => 0.0081752205,
                                                             0.0081752205);

final_score_220 := map(
    NULL < f_inq_other_count24_i AND f_inq_other_count24_i <= 2.5 => -0.0013054324,
    f_inq_other_count24_i > 2.5                                   => final_score_220_c860,
    f_inq_other_count24_i = NULL                                  => 0.0062170616,
                                                                     -0.0005152838);

final_score_221_c863 := map(
    NULL < f_assocsuspicousidcount_i AND f_assocsuspicousidcount_i <= 4.5 => -0.0008934978,
    f_assocsuspicousidcount_i > 4.5                                       => 0.0071255755,
    f_assocsuspicousidcount_i = NULL                                      => -0.0091359615,
                                                                             -0.0001591904);

final_score_221_c864 := map(
    NULL < f_curraddrmedianincome_d AND f_curraddrmedianincome_d <= 37462 => 0.0339013084,
    f_curraddrmedianincome_d > 37462                                      => -0.0041439539,
    f_curraddrmedianincome_d = NULL                                       => 0.0169840947,
                                                                             0.0169840947);

final_score_221 := map(
    NULL < r_l72_add_vacant_i AND r_l72_add_vacant_i <= 0.5 => final_score_221_c863,
    r_l72_add_vacant_i > 0.5                                => final_score_221_c864,
    r_l72_add_vacant_i = NULL                               => 0.0002084453,
                                                               0.0002084453);

final_score_222_c867 := map(
    NULL < f_rel_ageover30_count_d AND f_rel_ageover30_count_d <= 34.5 => -0.0004276662,
    f_rel_ageover30_count_d > 34.5                                     => -0.0212596759,
    f_rel_ageover30_count_d = NULL                                     => 0.0028175077,
                                                                          -0.0004953745);

final_score_222_c866 := map(
    NULL < r_l70_add_standardized_i AND r_l70_add_standardized_i <= 0.5 => final_score_222_c867,
    r_l70_add_standardized_i > 0.5                                      => -0.0278651145,
    r_l70_add_standardized_i = NULL                                     => -0.0007258352,
                                                                           -0.0007258352);

final_score_222 := map(
    NULL < k_comb_age_d AND k_comb_age_d <= 85.5 => final_score_222_c866,
    k_comb_age_d > 85.5                          => 0.0356234037,
    k_comb_age_d = NULL                          => -0.0004561205,
                                                    -0.0004561205);

final_score_223_c870 := map(
    NULL < k_comb_age_d AND k_comb_age_d <= 50.5 => 0.0199745989,
    k_comb_age_d > 50.5                          => -0.0103901206,
    k_comb_age_d = NULL                          => 0.0086097689,
                                                    0.0086097689);

final_score_223_c869 := map(
    NULL < f_rel_homeover200_count_d AND f_rel_homeover200_count_d <= 9.5 => 0.0478340385,
    f_rel_homeover200_count_d > 9.5                                       => final_score_223_c870,
    f_rel_homeover200_count_d = NULL                                      => 0.0144064590,
                                                                             0.0144064590);

final_score_223 := map(
    NULL < f_rel_homeover300_count_d AND f_rel_homeover300_count_d <= 7.5 => 0.0001119740,
    f_rel_homeover300_count_d > 7.5                                       => final_score_223_c869,
    f_rel_homeover300_count_d = NULL                                      => 0.0004159118,
                                                                             0.0006019341);

final_score_224_c873 := map(
    NULL < f_fp_prevaddrburglaryindex_i AND f_fp_prevaddrburglaryindex_i <= 171.5 => 0.0134410224,
    f_fp_prevaddrburglaryindex_i > 171.5                                          => -0.0061840141,
    f_fp_prevaddrburglaryindex_i = NULL                                           => 0.0078086641,
                                                                                     0.0078086641);

final_score_224_c872 := map(
    NULL < f_prevaddrcartheftindex_i AND f_prevaddrcartheftindex_i <= 82 => -0.0166859128,
    f_prevaddrcartheftindex_i > 82                                       => final_score_224_c873,
    f_prevaddrcartheftindex_i = NULL                                     => 0.0034787090,
                                                                            0.0034787090);

final_score_224 := map(
    NULL < r_l80_inp_avm_autoval_d AND r_l80_inp_avm_autoval_d <= 68016.5 => final_score_224_c872,
    r_l80_inp_avm_autoval_d > 68016.5                                     => -0.0058402811,
    r_l80_inp_avm_autoval_d = NULL                                        => 0.0001162254,
                                                                             -0.0005143778);

final_score_225_c876 := map(
    NULL < f_attr_arrest_recency_d AND f_attr_arrest_recency_d <= 99.5 => 0.0224285662,
    f_attr_arrest_recency_d > 99.5                                     => 0.0017387135,
    f_attr_arrest_recency_d = NULL                                     => 0.0028077152,
                                                                          0.0028077152);

final_score_225_c875 := map(
    NULL < f_curraddrmedianincome_d AND f_curraddrmedianincome_d <= 32960 => final_score_225_c876,
    f_curraddrmedianincome_d > 32960                                      => -0.0027234758,
    f_curraddrmedianincome_d = NULL                                       => -0.0007928250,
                                                                             -0.0007928250);

final_score_225 := map(
    NULL < f_rel_incomeover100_count_d AND f_rel_incomeover100_count_d <= 4.5 => final_score_225_c875,
    f_rel_incomeover100_count_d > 4.5                                         => 0.0180674391,
    f_rel_incomeover100_count_d = NULL                                        => -0.0007013276,
                                                                                 -0.0005049579);

final_score_226_c879 := map(
    NULL < r_c18_invalid_addrs_per_adl_i AND r_c18_invalid_addrs_per_adl_i <= 0.5 => 0.0370665449,
    r_c18_invalid_addrs_per_adl_i > 0.5                                           => 0.0110357017,
    r_c18_invalid_addrs_per_adl_i = NULL                                          => 0.0213327125,
                                                                                     0.0213327125);

final_score_226_c878 := map(
    NULL < f_rel_incomeover25_count_d AND f_rel_incomeover25_count_d <= 7.5 => final_score_226_c879,
    f_rel_incomeover25_count_d > 7.5                                        => 0.0011190718,
    f_rel_incomeover25_count_d = NULL                                       => 0.0082400422,
                                                                               0.0082400422);

final_score_226 := map(
    NULL < r_d32_mos_since_crim_ls_d AND r_d32_mos_since_crim_ls_d <= 17.5 => final_score_226_c878,
    r_d32_mos_since_crim_ls_d > 17.5                                       => -0.0004287979,
    r_d32_mos_since_crim_ls_d = NULL                                       => 0.0013132396,
                                                                              0.0002408398);

final_score_227_c881 := map(
    NULL < f_liens_unrel_st_total_amt_i AND f_liens_unrel_st_total_amt_i <= 540 => 0.0002841341,
    f_liens_unrel_st_total_amt_i > 540                                          => -0.0131487756,
    f_liens_unrel_st_total_amt_i = NULL                                         => -0.0001221945,
                                                                                   -0.0001221945);

final_score_227_c882 := map(
    NULL < k_inq_per_addr_i AND k_inq_per_addr_i <= 0.5 => 0.0253140778,
    k_inq_per_addr_i > 0.5                              => -0.0178768335,
    k_inq_per_addr_i = NULL                             => -0.0025800524,
                                                           -0.0025800524);

final_score_227 := map(
    NULL < f_divaddrsuspidcountnew_i AND f_divaddrsuspidcountnew_i <= 4.5 => final_score_227_c881,
    f_divaddrsuspidcountnew_i > 4.5                                       => 0.0245922276,
    f_divaddrsuspidcountnew_i = NULL                                      => final_score_227_c882,
                                                                             0.0000897626);

final_score_228_c884 := map(
    NULL < f_addrchangevaluediff_d AND f_addrchangevaluediff_d <= 242349.5 => -0.0015959790,
    f_addrchangevaluediff_d > 242349.5                                     => 0.0255448218,
    f_addrchangevaluediff_d = NULL                                         => -0.0013131892,
                                                                              -0.0012980447);

final_score_228_c885 := map(
    NULL < f_add_curr_nhood_sfd_pct_d AND f_add_curr_nhood_sfd_pct_d <= 0.12235724325 => 0.0333632467,
    f_add_curr_nhood_sfd_pct_d > 0.12235724325                                        => 0.0040772807,
    f_add_curr_nhood_sfd_pct_d = NULL                                                 => 0.0063368972,
                                                                                         0.0063368972);

final_score_228 := map(
    NULL < r_d32_felony_count_i AND r_d32_felony_count_i <= 0.5 => final_score_228_c884,
    r_d32_felony_count_i > 0.5                                  => final_score_228_c885,
    r_d32_felony_count_i = NULL                                 => 0.0024703699,
                                                                   -0.0004352948);

final_score_229_c888 := map(
    NULL < r_d32_criminal_count_i AND r_d32_criminal_count_i <= 12.5 => 0.0066679476,
    r_d32_criminal_count_i > 12.5                                    => 0.0366448207,
    r_d32_criminal_count_i = NULL                                    => 0.0090827201,
                                                                        0.0090827201);

final_score_229_c887 := map(
    NULL < f_srchunvrfdaddrcount_i AND f_srchunvrfdaddrcount_i <= 0.5 => 0.0010718959,
    f_srchunvrfdaddrcount_i > 0.5                                     => final_score_229_c888,
    f_srchunvrfdaddrcount_i = NULL                                    => 0.0022435799,
                                                                         0.0022435799);

final_score_229 := map(
    NULL < r_c20_email_domain_free_count_i AND r_c20_email_domain_free_count_i <= 1.5 => final_score_229_c887,
    r_c20_email_domain_free_count_i > 1.5                                             => -0.0033699414,
    r_c20_email_domain_free_count_i = NULL                                            => -0.0024025693,
                                                                                         0.0008187515);

final_score_230_c891 := map(
    NULL < f_util_adl_count_n AND f_util_adl_count_n <= 1.5 => -0.0040052336,
    f_util_adl_count_n > 1.5                                => 0.0010731289,
    f_util_adl_count_n = NULL                               => -0.0013939080,
                                                               -0.0013939080);

final_score_230_c890 := map(
    NULL < k_comb_age_d AND k_comb_age_d <= 81.5 => final_score_230_c891,
    k_comb_age_d > 81.5                          => 0.0222480270,
    k_comb_age_d = NULL                          => -0.0010221270,
                                                    -0.0010221270);

final_score_230 := map(
    NULL < r_d32_mos_since_fel_ls_d AND r_d32_mos_since_fel_ls_d <= 15.5 => 0.0290561451,
    r_d32_mos_since_fel_ls_d > 15.5                                      => final_score_230_c890,
    r_d32_mos_since_fel_ls_d = NULL                                      => -0.0006613932,
                                                                            -0.0008631885);

final_score_231_c893 := map(
    NULL < r_c13_max_lres_d AND r_c13_max_lres_d <= 128.5 => -0.0018596753,
    r_c13_max_lres_d > 128.5                              => 0.0060062460,
    r_c13_max_lres_d = NULL                               => 0.0024097517,
                                                             0.0024097517);

final_score_231_c894 := map(
    NULL < k_estimated_income_d AND k_estimated_income_d <= 58500 => -0.0074450098,
    k_estimated_income_d > 58500                                  => 0.0226127222,
    k_estimated_income_d = NULL                                   => -0.0035327058,
                                                                     -0.0018401371);

final_score_231 := map(
    NULL < f_crim_rel_under25miles_cnt_i AND f_crim_rel_under25miles_cnt_i <= 1.5 => -0.0025654315,
    f_crim_rel_under25miles_cnt_i > 1.5                                           => final_score_231_c893,
    f_crim_rel_under25miles_cnt_i = NULL                                          => final_score_231_c894,
                                                                                     -0.0004749239);

final_score_232_c897 := map(
    NULL < f_util_add_input_inf_n AND f_util_add_input_inf_n <= 0.5 => 0.0040635523,
    f_util_add_input_inf_n > 0.5                                    => -0.0150805177,
    f_util_add_input_inf_n = NULL                                   => 0.0027554551,
                                                                       0.0027554551);

final_score_232_c896 := map(
    NULL < f_addrchangeincomediff_d AND f_addrchangeincomediff_d <= -39741.5 => 0.0328336634,
    f_addrchangeincomediff_d > -39741.5                                      => final_score_232_c897,
    f_addrchangeincomediff_d = NULL                                          => 0.0046702241,
                                                                                0.0037215283);

final_score_232 := map(
    NULL < f_srchvelocityrisktype_i AND f_srchvelocityrisktype_i <= 2.5 => final_score_232_c896,
    f_srchvelocityrisktype_i > 2.5                                      => -0.0020045860,
    f_srchvelocityrisktype_i = NULL                                     => 0.0018763567,
                                                                           0.0002156129);

final_score_233_c899 := map(
    NULL < f_curraddrmedianvalue_d AND f_curraddrmedianvalue_d <= 161556.5 => 0.0042914295,
    f_curraddrmedianvalue_d > 161556.5                                     => 0.0439249237,
    f_curraddrmedianvalue_d = NULL                                         => 0.0176510343,
                                                                              0.0176510343);

final_score_233_c900 := map(
    NULL < f_add_input_mobility_index_i AND f_add_input_mobility_index_i <= 0.3020047258 => -0.0191215766,
    f_add_input_mobility_index_i > 0.3020047258                                          => 0.0199531933,
    f_add_input_mobility_index_i = NULL                                                  => -0.0029482447,
                                                                                            -0.0029482447);

final_score_233 := map(
    NULL < r_d33_eviction_count_i AND r_d33_eviction_count_i <= 7.5 => -0.0005892360,
    r_d33_eviction_count_i > 7.5                                    => final_score_233_c899,
    r_d33_eviction_count_i = NULL                                   => final_score_233_c900,
                                                                       -0.0003536376);

final_score_234_c903 := map(
    NULL < f_add_input_nhood_sfd_pct_d AND f_add_input_nhood_sfd_pct_d <= 0.8696882691 => -0.0067186862,
    f_add_input_nhood_sfd_pct_d > 0.8696882691                                         => 0.0425331818,
    f_add_input_nhood_sfd_pct_d = NULL                                                 => -0.0012462565,
                                                                                          -0.0012462565);

final_score_234_c902 := map(
    NULL < f_rel_under25miles_cnt_d AND f_rel_under25miles_cnt_d <= 36.5 => 0.0005317325,
    f_rel_under25miles_cnt_d > 36.5                                      => 0.0310652608,
    f_rel_under25miles_cnt_d = NULL                                      => final_score_234_c903,
                                                                            0.0006630711);

final_score_234 := map(
    NULL < f_inq_communications_cnt_week_i AND f_inq_communications_cnt_week_i <= 2.5 => final_score_234_c902,
    f_inq_communications_cnt_week_i > 2.5                                             => -0.0170924228,
    f_inq_communications_cnt_week_i = NULL                                            => 0.0030983474,
                                                                                         0.0003031782);

final_score_235_c905 := map(
    NULL < f_fp_prevaddrcrimeindex_i AND f_fp_prevaddrcrimeindex_i <= 73 => -0.0054902441,
    f_fp_prevaddrcrimeindex_i > 73                                       => 0.0431521319,
    f_fp_prevaddrcrimeindex_i = NULL                                     => 0.0149826546,
                                                                            0.0149826546);

final_score_235_c906 := map(
    NULL < r_c13_curr_addr_lres_d AND r_c13_curr_addr_lres_d <= 4.5 => 0.0193384214,
    r_c13_curr_addr_lres_d > 4.5                                    => -0.0007777352,
    r_c13_curr_addr_lres_d = NULL                                   => -0.0000311284,
                                                                       0.0012180252);

final_score_235 := map(
    NULL < f_addrchangeincomediff_d AND f_addrchangeincomediff_d <= -43493.5 => final_score_235_c905,
    f_addrchangeincomediff_d > -43493.5                                      => -0.0010886034,
    f_addrchangeincomediff_d = NULL                                          => final_score_235_c906,
                                                                                -0.0003358358);

final_score_236_c908 := map(
    NULL < f_util_add_curr_inf_n AND f_util_add_curr_inf_n <= 0.5 => 0.0002939239,
    f_util_add_curr_inf_n > 0.5                                   => -0.0080926464,
    f_util_add_curr_inf_n = NULL                                  => -0.0003344165,
                                                                     -0.0003344165);

final_score_236_c909 := map(
    NULL < f_add_input_nhood_mfd_pct_i AND f_add_input_nhood_mfd_pct_i <= 0.532957498 => -0.0193290939,
    f_add_input_nhood_mfd_pct_i > 0.532957498                                         => 0.0233079929,
    f_add_input_nhood_mfd_pct_i = NULL                                                => -0.0023396034,
                                                                                         -0.0023396034);

final_score_236 := map(
    NULL < f_mos_liens_rel_cj_fseen_d AND f_mos_liens_rel_cj_fseen_d <= 59.5 => -0.0353285225,
    f_mos_liens_rel_cj_fseen_d > 59.5                                        => final_score_236_c908,
    f_mos_liens_rel_cj_fseen_d = NULL                                        => final_score_236_c909,
                                                                                -0.0005344260);

final_score_237_c911 := map(
    NULL < f_inq_highriskcredit_count24_i AND f_inq_highriskcredit_count24_i <= 9.5 => -0.0009383780,
    f_inq_highriskcredit_count24_i > 9.5                                            => -0.0254735915,
    f_inq_highriskcredit_count24_i = NULL                                           => 0.0010841300,
                                                                                       -0.0011956222);

final_score_237_c912 := map(
    NULL < f_add_curr_nhood_bus_pct_i AND f_add_curr_nhood_bus_pct_i <= 0.08781049975 => 0.0123804600,
    f_add_curr_nhood_bus_pct_i > 0.08781049975                                        => -0.0015372948,
    f_add_curr_nhood_bus_pct_i = NULL                                                 => -0.0155272674,
                                                                                         0.0076414633);

final_score_237 := map(
    NULL < k_inq_ssns_per_addr_i AND k_inq_ssns_per_addr_i <= 2.5 => final_score_237_c911,
    k_inq_ssns_per_addr_i > 2.5                                   => final_score_237_c912,
    k_inq_ssns_per_addr_i = NULL                                  => -0.0001727714,
                                                                     -0.0001727714);

final_score_238_c915 := map(
    NULL < f_add_curr_nhood_bus_pct_i AND f_add_curr_nhood_bus_pct_i <= 0.0041450782 => 0.0300077339,
    f_add_curr_nhood_bus_pct_i > 0.0041450782                                        => -0.0005517368,
    f_add_curr_nhood_bus_pct_i = NULL                                                => -0.0002472595,
                                                                                        -0.0002472595);

final_score_238_c914 := map(
    NULL < f_add_curr_nhood_bus_pct_i AND f_add_curr_nhood_bus_pct_i <= 0.0032912791 => -0.0173785409,
    f_add_curr_nhood_bus_pct_i > 0.0032912791                                        => final_score_238_c915,
    f_add_curr_nhood_bus_pct_i = NULL                                                => -0.0023623534,
                                                                                        -0.0007482817);

final_score_238 := map(
    NULL < f_add_input_nhood_sfd_pct_d AND f_add_input_nhood_sfd_pct_d <= 0.99071754285 => final_score_238_c914,
    f_add_input_nhood_sfd_pct_d > 0.99071754285                                         => 0.0145084257,
    f_add_input_nhood_sfd_pct_d = NULL                                                  => -0.0002587584,
                                                                                           -0.0002587584);

final_score_239_c917 := map(
    NULL < r_d32_felony_count_i AND r_d32_felony_count_i <= 8.5 => 0.0012478729,
    r_d32_felony_count_i > 8.5                                  => 0.0352263628,
    r_d32_felony_count_i = NULL                                 => 0.0014537469,
                                                                   0.0014537469);

final_score_239_c918 := map(
    NULL < r_a46_curr_avm_autoval_d AND r_a46_curr_avm_autoval_d <= 140128.5 => -0.0050707831,
    r_a46_curr_avm_autoval_d > 140128.5                                      => 0.0146059041,
    r_a46_curr_avm_autoval_d = NULL                                          => -0.0058355846,
                                                                                -0.0037417703);

final_score_239 := map(
    NULL < r_c20_email_domain_free_count_i AND r_c20_email_domain_free_count_i <= 1.5 => final_score_239_c917,
    r_c20_email_domain_free_count_i > 1.5                                             => final_score_239_c918,
    r_c20_email_domain_free_count_i = NULL                                            => -0.0037751532,
                                                                                         0.0001383283);

final_score_240_c921 := map(
    NULL < f_util_add_input_conv_n AND f_util_add_input_conv_n <= 0.5 => -0.0109315635,
    f_util_add_input_conv_n > 0.5                                     => 0.0225449789,
    f_util_add_input_conv_n = NULL                                    => 0.0116566489,
                                                                         0.0116566489);

final_score_240_c920 := map(
    NULL < f_addrchangevaluediff_d AND f_addrchangevaluediff_d <= -20738.5 => 0.0345633185,
    f_addrchangevaluediff_d > -20738.5                                     => 0.0023892341,
    f_addrchangevaluediff_d = NULL                                         => final_score_240_c921,
                                                                              0.0085725925);

final_score_240 := map(
    NULL < k_comb_age_d AND k_comb_age_d <= 23.5 => final_score_240_c920,
    k_comb_age_d > 23.5                          => -0.0002445316,
    k_comb_age_d = NULL                          => 0.0003083360,
                                                    0.0003083360);

final_score_241_c924 := map(
    NULL < f_curraddrmedianvalue_d AND f_curraddrmedianvalue_d <= 96980 => -0.0040993192,
    f_curraddrmedianvalue_d > 96980                                     => 0.0317427005,
    f_curraddrmedianvalue_d = NULL                                      => 0.0126434928,
                                                                           0.0126434928);

final_score_241_c923 := map(
    NULL < f_rel_under25miles_cnt_d AND f_rel_under25miles_cnt_d <= 27.5 => -0.0006389621,
    f_rel_under25miles_cnt_d > 27.5                                      => final_score_241_c924,
    f_rel_under25miles_cnt_d = NULL                                      => 0.0032509641,
                                                                            -0.0001581034);

final_score_241 := map(
    NULL < f_phones_per_addr_curr_i AND f_phones_per_addr_curr_i <= 94.5 => final_score_241_c923,
    f_phones_per_addr_curr_i > 94.5                                      => 0.0209320117,
    f_phones_per_addr_curr_i = NULL                                      => 0.0059413103,
                                                                            0.0000693846);

final_score_242_c927 := map(
    NULL < r_a49_curr_avm_chg_1yr_i AND r_a49_curr_avm_chg_1yr_i <= -29797.5 => -0.0204897423,
    r_a49_curr_avm_chg_1yr_i > -29797.5                                      => 0.0082179323,
    r_a49_curr_avm_chg_1yr_i = NULL                                          => -0.0010859040,
                                                                                0.0008250875);

final_score_242_c926 := map(
    NULL < f_fp_prevaddrburglaryindex_i AND f_fp_prevaddrburglaryindex_i <= 43.5 => 0.0183306650,
    f_fp_prevaddrburglaryindex_i > 43.5                                          => final_score_242_c927,
    f_fp_prevaddrburglaryindex_i = NULL                                          => 0.0023730355,
                                                                                    0.0023730355);

final_score_242 := map(
    NULL < r_c14_addrs_15yr_i AND r_c14_addrs_15yr_i <= 5.5 => -0.0025887272,
    r_c14_addrs_15yr_i > 5.5                                => final_score_242_c926,
    r_c14_addrs_15yr_i = NULL                               => -0.0051596642,
                                                               -0.0011535642);

final_score_243_c930 := map(
    NULL < f_add_curr_nhood_mfd_pct_i AND f_add_curr_nhood_mfd_pct_i <= 0.0594383373 => -0.0115526610,
    f_add_curr_nhood_mfd_pct_i > 0.0594383373                                        => 0.0147321581,
    f_add_curr_nhood_mfd_pct_i = NULL                                                => -0.0144706399,
                                                                                        0.0074847421);

final_score_243_c929 := map(
    NULL < f_rel_under500miles_cnt_d AND f_rel_under500miles_cnt_d <= 2.5 => final_score_243_c930,
    f_rel_under500miles_cnt_d > 2.5                                       => -0.0031458093,
    f_rel_under500miles_cnt_d = NULL                                      => -0.0037527060,
                                                                             -0.0017109971);

final_score_243 := map(
    (nf_seg_fraudpoint_3_0 in ['1: Stolen/Manip ID', '2: Synth ID', '6: Other'])          => final_score_243_c929,
    (nf_seg_fraudpoint_3_0 in ['3: Derog', '4: Recent Activity', '5: Vuln Vic/Friendly']) => 0.0033034917,
    nf_seg_fraudpoint_3_0 = ''                                                          => 0.0014390047,
                                                                                             0.0014390047);

final_score_244_c933 := map(
    NULL < r_a46_curr_avm_autoval_d AND r_a46_curr_avm_autoval_d <= 12910 => 0.0250664485,
    r_a46_curr_avm_autoval_d > 12910                                      => -0.0031471958,
    r_a46_curr_avm_autoval_d = NULL                                       => -0.0034936450,
                                                                             -0.0028159695);

final_score_244_c932 := map(
    NULL < f_curraddrburglaryindex_i AND f_curraddrburglaryindex_i <= 125.5 => 0.0027534581,
    f_curraddrburglaryindex_i > 125.5                                       => final_score_244_c933,
    f_curraddrburglaryindex_i = NULL                                        => -0.0001290492,
                                                                               -0.0001290492);

final_score_244 := map(
    NULL < r_c19_add_prison_hist_i AND r_c19_add_prison_hist_i <= 0.5 => final_score_244_c932,
    r_c19_add_prison_hist_i > 0.5                                     => 0.0184736334,
    r_c19_add_prison_hist_i = NULL                                    => 0.0103638716,
                                                                         0.0003384998);

final_score_245_c935 := map(
    NULL < r_f01_inp_addr_address_score_d AND r_f01_inp_addr_address_score_d <= 11 => -0.0115315195,
    r_f01_inp_addr_address_score_d > 11                                            => 0.0010860078,
    r_f01_inp_addr_address_score_d = NULL                                          => 0.0002618595,
                                                                                      0.0005974589);

final_score_245_c936 := map(
    NULL < f_rel_homeover100_count_d AND f_rel_homeover100_count_d <= 9.5 => 0.0041540192,
    f_rel_homeover100_count_d > 9.5                                       => 0.0453925202,
    f_rel_homeover100_count_d = NULL                                      => 0.0169521747,
                                                                             0.0169521747);

final_score_245 := map(
    NULL < f_add_input_mobility_index_i AND f_add_input_mobility_index_i <= 0.6536150943 => final_score_245_c935,
    f_add_input_mobility_index_i > 0.6536150943                                          => final_score_245_c936,
    f_add_input_mobility_index_i = NULL                                                  => -0.0181031051,
                                                                                            0.0008401227);

final_score_246_c939 := map(
    NULL < f_add_input_nhood_vac_pct_i AND f_add_input_nhood_vac_pct_i <= 0.105845748 => -0.0051898091,
    f_add_input_nhood_vac_pct_i > 0.105845748                                         => 0.0190964092,
    f_add_input_nhood_vac_pct_i = NULL                                                => 0.0007128678,
                                                                                         0.0007128678);

final_score_246_c938 := map(
    NULL < r_l80_inp_avm_autoval_d AND r_l80_inp_avm_autoval_d <= 226127.5 => final_score_246_c939,
    r_l80_inp_avm_autoval_d > 226127.5                                     => 0.0352694960,
    r_l80_inp_avm_autoval_d = NULL                                         => -0.0008389759,
                                                                              0.0008242558);

final_score_246 := map(
    NULL < f_addrchangeecontrajindex_d AND f_addrchangeecontrajindex_d <= 4.5 => -0.0011197768,
    f_addrchangeecontrajindex_d > 4.5                                         => 0.0188559149,
    f_addrchangeecontrajindex_d = NULL                                        => final_score_246_c938,
                                                                                 -0.0004566731);

final_score_247_c941 := map(
    NULL < f_add_input_nhood_bus_pct_i AND f_add_input_nhood_bus_pct_i <= 0.41696183605 => -0.0009769968,
    f_add_input_nhood_bus_pct_i > 0.41696183605                                         => 0.0258267365,
    f_add_input_nhood_bus_pct_i = NULL                                                  => 0.0031047070,
                                                                                           -0.0005863045);

final_score_247_c942 := map(
    NULL < f_crim_rel_under25miles_cnt_i AND f_crim_rel_under25miles_cnt_i <= 0.5 => 0.0316388869,
    f_crim_rel_under25miles_cnt_i > 0.5                                           => -0.0094718233,
    f_crim_rel_under25miles_cnt_i = NULL                                          => 0.0142681643,
                                                                                     0.0142681643);

final_score_247 := map(
    NULL < f_addrchangevaluediff_d AND f_addrchangevaluediff_d <= 172709 => final_score_247_c941,
    f_addrchangevaluediff_d > 172709                                     => final_score_247_c942,
    f_addrchangevaluediff_d = NULL                                       => 0.0007601220,
                                                                            -0.0000358773);

final_score_248_c945 := map(
    NULL < f_add_curr_mobility_index_i AND f_add_curr_mobility_index_i <= 0.24464286165 => 0.0343539669,
    f_add_curr_mobility_index_i > 0.24464286165                                         => 0.0009485383,
    f_add_curr_mobility_index_i = NULL                                                  => 0.0161160087,
                                                                                           0.0161160087);

final_score_248_c944 := map(
    NULL < r_a46_curr_avm_autoval_d AND r_a46_curr_avm_autoval_d <= 112083.5 => 0.0082230914,
    r_a46_curr_avm_autoval_d > 112083.5                                      => final_score_248_c945,
    r_a46_curr_avm_autoval_d = NULL                                          => 0.0004916215,
                                                                                0.0042558148);

final_score_248 := map(
    (nf_seg_fraudpoint_3_0 in ['1: Stolen/Manip ID', '2: Synth ID', '4: Recent Activity', '5: Vuln Vic/Friendly', '6: Other']) => -0.0010629220,
    (nf_seg_fraudpoint_3_0 in ['3: Derog'])                                                                                    => final_score_248_c944,
    nf_seg_fraudpoint_3_0 = ''                                                                                               => 0.0006562131,
                                                                                                                                  0.0006562131);

final_score_249_c948 := map(
    NULL < f_add_input_nhood_mfd_pct_i AND f_add_input_nhood_mfd_pct_i <= 0.5155612245 => -0.0027931945,
    f_add_input_nhood_mfd_pct_i > 0.5155612245                                         => -0.0168779279,
    f_add_input_nhood_mfd_pct_i = NULL                                                 => 0.0058120760,
                                                                                          -0.0031848689);

final_score_249_c947 := map(
    NULL < r_l80_inp_avm_autoval_d AND r_l80_inp_avm_autoval_d <= 31878 => 0.0065125444,
    r_l80_inp_avm_autoval_d > 31878                                     => final_score_249_c948,
    r_l80_inp_avm_autoval_d = NULL                                      => 0.0002340164,
                                                                           -0.0002541813);

final_score_249 := map(
    NULL < f_mos_liens_unrel_sc_fseen_d AND f_mos_liens_unrel_sc_fseen_d <= 15.5 => -0.0355736829,
    f_mos_liens_unrel_sc_fseen_d > 15.5                                          => final_score_249_c947,
    f_mos_liens_unrel_sc_fseen_d = NULL                                          => -0.0018516580,
                                                                                    -0.0004839551);

final_score_250_c951 := map(
    NULL < r_c23_inp_addr_occ_index_d AND r_c23_inp_addr_occ_index_d <= 3.5 => 0.0567508907,
    r_c23_inp_addr_occ_index_d > 3.5                                        => 0.0056793219,
    r_c23_inp_addr_occ_index_d = NULL                                       => 0.0356241626,
                                                                               0.0356241626);

final_score_250_c950 := map(
    NULL < r_d30_derog_count_i AND r_d30_derog_count_i <= 1.5 => -0.0044289872,
    r_d30_derog_count_i > 1.5                                 => final_score_250_c951,
    r_d30_derog_count_i = NULL                                => 0.0181567646,
                                                                 0.0181567646);

final_score_250 := map(
    NULL < r_l72_add_vacant_i AND r_l72_add_vacant_i <= 0.5 => -0.0002235220,
    r_l72_add_vacant_i > 0.5                                => final_score_250_c950,
    r_l72_add_vacant_i = NULL                               => 0.0001534057,
                                                               0.0001534057);

final_score_251_c953 := map(
    NULL < r_c18_invalid_addrs_per_adl_i AND r_c18_invalid_addrs_per_adl_i <= 2.5 => 0.0016202728,
    r_c18_invalid_addrs_per_adl_i > 2.5                                           => -0.0043512317,
    r_c18_invalid_addrs_per_adl_i = NULL                                          => -0.0002131640,
                                                                                     -0.0002131640);

final_score_251_c954 := map(
    NULL < f_curraddrburglaryindex_i AND f_curraddrburglaryindex_i <= 181.5 => -0.0057509699,
    f_curraddrburglaryindex_i > 181.5                                       => -0.0331322041,
    f_curraddrburglaryindex_i = NULL                                        => -0.0093569506,
                                                                               -0.0093569506);

final_score_251 := map(
    NULL < r_c20_email_count_i AND r_c20_email_count_i <= 5.5 => final_score_251_c953,
    r_c20_email_count_i > 5.5                                 => final_score_251_c954,
    r_c20_email_count_i = NULL                                => 0.0025688905,
                                                                 -0.0009403728);

final_score_252_c957 := map(
    NULL < f_prevaddrmedianincome_d AND f_prevaddrmedianincome_d <= 74328.5 => -0.0001442761,
    f_prevaddrmedianincome_d > 74328.5                                      => 0.0124152658,
    f_prevaddrmedianincome_d = NULL                                         => 0.0007973492,
                                                                               0.0007973492);

final_score_252_c956 := map(
    NULL < k_comb_age_d AND k_comb_age_d <= 75.5 => final_score_252_c957,
    k_comb_age_d > 75.5                          => 0.0214329373,
    k_comb_age_d = NULL                          => 0.0014577362,
                                                    0.0014577362);

final_score_252 := map(
    NULL < r_i60_credit_seeking_i AND r_i60_credit_seeking_i <= 1.5 => final_score_252_c956,
    r_i60_credit_seeking_i > 1.5                                    => -0.0042288066,
    r_i60_credit_seeking_i = NULL                                   => 0.0050509077,
                                                                       -0.0001362204);

final_score_253_c960 := map(
    NULL < r_c14_addrs_15yr_i AND r_c14_addrs_15yr_i <= 8.5 => -0.0008811216,
    r_c14_addrs_15yr_i > 8.5                                => 0.0300398739,
    r_c14_addrs_15yr_i = NULL                               => 0.0010811207,
                                                               0.0010811207);

final_score_253_c959 := map(
    NULL < f_prevaddrlenofres_d AND f_prevaddrlenofres_d <= 84.5 => -0.0083572989,
    f_prevaddrlenofres_d > 84.5                                  => final_score_253_c960,
    f_prevaddrlenofres_d = NULL                                  => -0.0046580387,
                                                                    -0.0046580387);

final_score_253 := map(
    NULL < f_historical_count_d AND f_historical_count_d <= 1.5 => 0.0007823097,
    f_historical_count_d > 1.5                                  => final_score_253_c959,
    f_historical_count_d = NULL                                 => 0.0034142583,
                                                                   -0.0011369595);

final_score_254_c963 := map(
    NULL < r_c10_m_hdr_fs_d AND r_c10_m_hdr_fs_d <= 345 => -0.0077505468,
    r_c10_m_hdr_fs_d > 345                              => 0.0358685306,
    r_c10_m_hdr_fs_d = NULL                             => -0.0014703131,
                                                           -0.0014703131);

final_score_254_c962 := map(
    NULL < f_util_add_input_conv_n AND f_util_add_input_conv_n <= 0.5 => 0.0196549279,
    f_util_add_input_conv_n > 0.5                                     => final_score_254_c963,
    f_util_add_input_conv_n = NULL                                    => 0.0079255063,
                                                                         0.0079255063);

final_score_254 := map(
    NULL < f_addrchangecrimediff_i AND f_addrchangecrimediff_i <= 52.5 => -0.0019552391,
    f_addrchangecrimediff_i > 52.5                                     => final_score_254_c962,
    f_addrchangecrimediff_i = NULL                                     => -0.0014433205,
                                                                          -0.0012788227);

final_score_255_c966 := map(
    NULL < k_comb_age_d AND k_comb_age_d <= 20.5 => 0.0216684190,
    k_comb_age_d > 20.5                          => 0.0006003209,
    k_comb_age_d = NULL                          => 0.0008120872,
                                                    0.0008120872);

final_score_255_c965 := map(
    NULL < f_mos_liens_unrel_cj_lseen_d AND f_mos_liens_unrel_cj_lseen_d <= 5.5 => -0.0382123502,
    f_mos_liens_unrel_cj_lseen_d > 5.5                                          => final_score_255_c966,
    f_mos_liens_unrel_cj_lseen_d = NULL                                         => 0.0006460881,
                                                                                   0.0006460881);

final_score_255 := map(
    NULL < f_m_bureau_adl_fs_notu_d AND f_m_bureau_adl_fs_notu_d <= 11.5 => -0.0213171886,
    f_m_bureau_adl_fs_notu_d > 11.5                                      => final_score_255_c965,
    f_m_bureau_adl_fs_notu_d = NULL                                      => 0.0025420244,
                                                                            0.0004229677);

final_score_256_c969 := map(
    NULL < f_curraddrmedianincome_d AND f_curraddrmedianincome_d <= 38947 => 0.0035997108,
    f_curraddrmedianincome_d > 38947                                      => -0.0172015446,
    f_curraddrmedianincome_d = NULL                                       => -0.0088756006,
                                                                             -0.0088756006);

final_score_256_c968 := map(
    NULL < f_liens_unrel_o_total_amt_i AND f_liens_unrel_o_total_amt_i <= 170 => 0.0010100398,
    f_liens_unrel_o_total_amt_i > 170                                         => final_score_256_c969,
    f_liens_unrel_o_total_amt_i = NULL                                        => 0.0003828814,
                                                                                 0.0003828814);

final_score_256 := map(
    NULL < r_i60_inq_util_count12_i AND r_i60_inq_util_count12_i <= 0.5 => final_score_256_c968,
    r_i60_inq_util_count12_i > 0.5                                      => 0.0316187021,
    r_i60_inq_util_count12_i = NULL                                     => 0.0008158711,
                                                                           0.0005499087);

final_score_257_c972 := map(
    NULL < f_rel_incomeover75_count_d AND f_rel_incomeover75_count_d <= 8.5 => 0.0014739901,
    f_rel_incomeover75_count_d > 8.5                                        => 0.0332130946,
    f_rel_incomeover75_count_d = NULL                                       => -0.0080009098,
                                                                               0.0020400464);

final_score_257_c971 := map(
    NULL < f_addrchangevaluediff_d AND f_addrchangevaluediff_d <= -36800.5 => 0.0238171062,
    f_addrchangevaluediff_d > -36800.5                                     => final_score_257_c972,
    f_addrchangevaluediff_d = NULL                                         => 0.0004905653,
                                                                              0.0021227589);

final_score_257 := map(
    (nf_seg_fraudpoint_3_0 in ['1: Stolen/Manip ID', '2: Synth ID', '5: Vuln Vic/Friendly', '6: Other']) => -0.0027216415,
    (nf_seg_fraudpoint_3_0 in ['3: Derog', '4: Recent Activity'])                                        => final_score_257_c971,
    nf_seg_fraudpoint_3_0 = ''                                                                         => -0.0000821859,
                                                                                                            -0.0000821859);

final_score_258_c975 := map(
    NULL < f_hh_bankruptcies_i AND f_hh_bankruptcies_i <= 0.5 => 0.0315316328,
    f_hh_bankruptcies_i > 0.5                                 => -0.0156400164,
    f_hh_bankruptcies_i = NULL                                => 0.0223987759,
                                                                 0.0223987759);

final_score_258_c974 := map(
    NULL < f_add_curr_mobility_index_i AND f_add_curr_mobility_index_i <= 0.29800756915 => 0.0024987365,
    f_add_curr_mobility_index_i > 0.29800756915                                         => final_score_258_c975,
    f_add_curr_mobility_index_i = NULL                                                  => 0.0116410689,
                                                                                           0.0116410689);

final_score_258 := map(
    NULL < f_srchunvrfdaddrcount_i AND f_srchunvrfdaddrcount_i <= 1.5 => -0.0003890517,
    f_srchunvrfdaddrcount_i > 1.5                                     => final_score_258_c974,
    f_srchunvrfdaddrcount_i = NULL                                    => -0.0041862118,
                                                                         0.0001350723);

final_score_259_c977 := map(
    NULL < f_rel_under25miles_cnt_d AND f_rel_under25miles_cnt_d <= 20.5 => 0.0021328077,
    f_rel_under25miles_cnt_d > 20.5                                      => 0.0198061578,
    f_rel_under25miles_cnt_d = NULL                                      => 0.0151009934,
                                                                            0.0038099645);

final_score_259_c978 := map(
    NULL < (real)k_nap_lname_verd_d AND (real)k_nap_lname_verd_d <= 0.5 => 0.0345125279,
    (real)k_nap_lname_verd_d > 0.5                                => -0.0193847138,
    (real)k_nap_lname_verd_d = NULL                               => 0.0132282668,
                                                               0.0132282668);

final_score_259 := map(
    NULL < f_fp_prevaddrcrimeindex_i AND f_fp_prevaddrcrimeindex_i <= 166.5 => -0.0007852254,
    f_fp_prevaddrcrimeindex_i > 166.5                                       => final_score_259_c977,
    f_fp_prevaddrcrimeindex_i = NULL                                        => final_score_259_c978,
                                                                               0.0007460502);

final_score_260_c981 := map(
    NULL < f_util_add_curr_inf_n AND f_util_add_curr_inf_n <= 0.5 => -0.0018418427,
    f_util_add_curr_inf_n > 0.5                                   => -0.0131801988,
    f_util_add_curr_inf_n = NULL                                  => -0.0026359267,
                                                                     -0.0026359267);

final_score_260_c980 := map(
    NULL < f_mos_liens_unrel_ot_fseen_d AND f_mos_liens_unrel_ot_fseen_d <= 24.5 => 0.0297779286,
    f_mos_liens_unrel_ot_fseen_d > 24.5                                          => final_score_260_c981,
    f_mos_liens_unrel_ot_fseen_d = NULL                                          => -0.0023902945,
                                                                                    -0.0023902945);

final_score_260 := map(
    NULL < r_f04_curr_add_occ_index_d AND r_f04_curr_add_occ_index_d <= 2 => final_score_260_c980,
    r_f04_curr_add_occ_index_d > 2                                        => 0.0032289046,
    r_f04_curr_add_occ_index_d = NULL                                     => -0.0087554272,
                                                                             -0.0007960836);

final_score_261_c984 := map(
    NULL < f_add_input_nhood_mfd_pct_i AND f_add_input_nhood_mfd_pct_i <= 0.2063759214 => -0.0041668649,
    f_add_input_nhood_mfd_pct_i > 0.2063759214                                         => 0.0002521636,
    f_add_input_nhood_mfd_pct_i = NULL                                                 => 0.0031653756,
                                                                                          -0.0013064584);

final_score_261_c983 := map(
    NULL < r_f01_inp_addr_address_score_d AND r_f01_inp_addr_address_score_d <= 5 => 0.0275521464,
    r_f01_inp_addr_address_score_d > 5                                            => final_score_261_c984,
    r_f01_inp_addr_address_score_d = NULL                                         => 0.0037237592,
                                                                                     -0.0010702653);

final_score_261 := map(
    NULL < r_l79_adls_per_addr_c6_i AND r_l79_adls_per_addr_c6_i <= 23.5 => final_score_261_c983,
    r_l79_adls_per_addr_c6_i > 23.5                                      => 0.0365082814,
    r_l79_adls_per_addr_c6_i = NULL                                      => -0.0009124624,
                                                                            -0.0009124624);

final_score_262_c987 := map(
    NULL < f_curraddrmurderindex_i AND f_curraddrmurderindex_i <= 143 => 0.0017662590,
    f_curraddrmurderindex_i > 143                                     => -0.0194099574,
    f_curraddrmurderindex_i = NULL                                    => -0.0062148420,
                                                                         -0.0062148420);

final_score_262_c986 := map(
    NULL < f_srchvelocityrisktype_i AND f_srchvelocityrisktype_i <= 5.5 => final_score_262_c987,
    f_srchvelocityrisktype_i > 5.5                                      => 0.0311555773,
    f_srchvelocityrisktype_i = NULL                                     => -0.0075303309,
                                                                           -0.0035889252);

final_score_262 := map(
    NULL < f_rel_homeover100_count_d AND f_rel_homeover100_count_d <= 23.5 => 0.0006377110,
    f_rel_homeover100_count_d > 23.5                                       => -0.0144458823,
    f_rel_homeover100_count_d = NULL                                       => final_score_262_c986,
                                                                              0.0000308945);

final_score_263_c990 := map(
    NULL < f_add_input_nhood_mfd_pct_i AND f_add_input_nhood_mfd_pct_i <= 0.24962827715 => 0.0047174847,
    f_add_input_nhood_mfd_pct_i > 0.24962827715                                         => 0.0505231526,
    f_add_input_nhood_mfd_pct_i = NULL                                                  => 0.0248240424,
                                                                                           0.0248240424);

final_score_263_c989 := map(
    NULL < r_d30_derog_count_i AND r_d30_derog_count_i <= 0.5 => -0.0069535319,
    r_d30_derog_count_i > 0.5                                 => final_score_263_c990,
    r_d30_derog_count_i = NULL                                => 0.0130835593,
                                                                 0.0130835593);

final_score_263 := map(
    NULL < f_srchaddrsrchcountmo_i AND f_srchaddrsrchcountmo_i <= 2.5 => -0.0009797157,
    f_srchaddrsrchcountmo_i > 2.5                                     => final_score_263_c989,
    f_srchaddrsrchcountmo_i = NULL                                    => 0.0015766096,
                                                                         -0.0005979208);

final_score_264_c992 := map(
    NULL < f_prevaddrmedianvalue_d AND f_prevaddrmedianvalue_d <= 416615 => -0.0014687907,
    f_prevaddrmedianvalue_d > 416615                                     => 0.0099736680,
    f_prevaddrmedianvalue_d = NULL                                       => -0.0053254000,
                                                                            -0.0009497973);

final_score_264_c993 := map(
    NULL < r_l79_adls_per_addr_curr_i AND r_l79_adls_per_addr_curr_i <= 1.5 => 0.0555960241,
    r_l79_adls_per_addr_curr_i > 1.5                                        => 0.0078796190,
    r_l79_adls_per_addr_curr_i = NULL                                       => 0.0270224836,
                                                                               0.0270224836);

final_score_264 := map(
    NULL < k_comb_age_d AND k_comb_age_d <= 81.5 => final_score_264_c992,
    k_comb_age_d > 81.5                          => final_score_264_c993,
    k_comb_age_d = NULL                          => -0.0005574920,
                                                    -0.0005574920);

final_score_265_c995 := map(
    NULL < f_m_bureau_adl_fs_all_d AND f_m_bureau_adl_fs_all_d <= 309.5 => 0.0019864053,
    f_m_bureau_adl_fs_all_d > 309.5                                     => 0.0327430116,
    f_m_bureau_adl_fs_all_d = NULL                                      => -0.0028774506,
                                                                           0.0024475108);

final_score_265_c996 := map(
    NULL < k_comb_age_d AND k_comb_age_d <= 85.5 => -0.0030802222,
    k_comb_age_d > 85.5                          => 0.0256097629,
    k_comb_age_d = NULL                          => -0.0026158326,
                                                    -0.0026158326);

final_score_265 := map(
    NULL < k_comb_age_d AND k_comb_age_d <= 42.5 => final_score_265_c995,
    k_comb_age_d > 42.5                          => final_score_265_c996,
    k_comb_age_d = NULL                          => -0.0001031526,
                                                    -0.0001031526);

final_score_266_c998 := map(
    NULL < f_add_curr_nhood_bus_pct_i AND f_add_curr_nhood_bus_pct_i <= 0.00936924905 => -0.0089283680,
    f_add_curr_nhood_bus_pct_i > 0.00936924905                                        => 0.0004782212,
    f_add_curr_nhood_bus_pct_i = NULL                                                 => 0.0002827128,
                                                                                         -0.0003646113);

final_score_266_c999 := map(
    NULL < r_d32_criminal_count_i AND r_d32_criminal_count_i <= 5.5 => 0.0111876675,
    r_d32_criminal_count_i > 5.5                                    => 0.0549552775,
    r_d32_criminal_count_i = NULL                                   => 0.0169304239,
                                                                       0.0169304239);

final_score_266 := map(
    NULL < f_add_input_nhood_sfd_pct_d AND f_add_input_nhood_sfd_pct_d <= 0.9907089536 => final_score_266_c998,
    f_add_input_nhood_sfd_pct_d > 0.9907089536                                         => final_score_266_c999,
    f_add_input_nhood_sfd_pct_d = NULL                                                 => 0.0001945441,
                                                                                          0.0001945441);

final_score_267_c1001 := map(
    NULL < f_rel_homeover300_count_d AND f_rel_homeover300_count_d <= 9.5 => -0.0007615279,
    f_rel_homeover300_count_d > 9.5                                       => 0.0160773204,
    f_rel_homeover300_count_d = NULL                                      => -0.0015066573,
                                                                             -0.0004807543);

final_score_267_c1002 := map(
    NULL < r_i61_inq_collection_recency_d AND r_i61_inq_collection_recency_d <= 549 => 0.0530933471,
    r_i61_inq_collection_recency_d > 549                                            => 0.0114322296,
    r_i61_inq_collection_recency_d = NULL                                           => 0.0247952295,
                                                                                       0.0247952295);

final_score_267 := map(
    NULL < k_comb_age_d AND k_comb_age_d <= 81.5 => final_score_267_c1001,
    k_comb_age_d > 81.5                          => final_score_267_c1002,
    k_comb_age_d = NULL                          => -0.0000943186,
                                                    -0.0000943186);

final_score_268_c1005 := map(
    NULL < f_phones_per_addr_curr_i AND f_phones_per_addr_curr_i <= 3.5 => -0.0024205553,
    f_phones_per_addr_curr_i > 3.5                                      => 0.0019687943,
    f_phones_per_addr_curr_i = NULL                                     => -0.0000202931,
                                                                           -0.0000202931);

final_score_268_c1004 := map(
    NULL < f_mos_liens_unrel_ot_fseen_d AND f_mos_liens_unrel_ot_fseen_d <= 25.5 => 0.0241612787,
    f_mos_liens_unrel_ot_fseen_d > 25.5                                          => final_score_268_c1005,
    f_mos_liens_unrel_ot_fseen_d = NULL                                          => 0.0001838020,
                                                                                    0.0001838020);

final_score_268 := map(
    NULL < f_add_curr_nhood_bus_pct_i AND f_add_curr_nhood_bus_pct_i <= 0.4806953523 => final_score_268_c1004,
    f_add_curr_nhood_bus_pct_i > 0.4806953523                                        => -0.0262394822,
    f_add_curr_nhood_bus_pct_i = NULL                                                => -0.0040472964,
                                                                                        -0.0002194370);

final_score_269_c1007 := map(
    NULL < f_add_input_nhood_vac_pct_i AND f_add_input_nhood_vac_pct_i <= 0.05187999565 => 0.0054314611,
    f_add_input_nhood_vac_pct_i > 0.05187999565                                         => -0.0018883466,
    f_add_input_nhood_vac_pct_i = NULL                                                  => 0.0024808155,
                                                                                           0.0024808155);

final_score_269_c1008 := map(
    NULL < f_add_input_nhood_mfd_pct_i AND f_add_input_nhood_mfd_pct_i <= 0.3206050639 => -0.0107235826,
    f_add_input_nhood_mfd_pct_i > 0.3206050639                                         => 0.0243391600,
    f_add_input_nhood_mfd_pct_i = NULL                                                 => 0.0088132223,
                                                                                          0.0088132223);

final_score_269 := map(
    NULL < r_i60_inq_count12_i AND r_i60_inq_count12_i <= 1.5 => final_score_269_c1007,
    r_i60_inq_count12_i > 1.5                                 => -0.0027216763,
    r_i60_inq_count12_i = NULL                                => final_score_269_c1008,
                                                                 0.0002674578);

final_score_270_c1011 := map(
    NULL < f_prevaddrmurderindex_i AND f_prevaddrmurderindex_i <= 192.5 => -0.0072659969,
    f_prevaddrmurderindex_i > 192.5                                     => 0.0107679920,
    f_prevaddrmurderindex_i = NULL                                      => -0.0057404310,
                                                                           -0.0057404310);

final_score_270_c1010 := map(
    NULL < r_c13_curr_addr_lres_d AND r_c13_curr_addr_lres_d <= 1.5 => 0.0210938041,
    r_c13_curr_addr_lres_d > 1.5                                    => final_score_270_c1011,
    r_c13_curr_addr_lres_d = NULL                                   => -0.0000061666,
                                                                       -0.0046047940);

final_score_270 := map(
    NULL < f_addrs_per_ssn_i AND f_addrs_per_ssn_i <= 6.5 => final_score_270_c1010,
    f_addrs_per_ssn_i > 6.5                               => 0.0016210074,
    f_addrs_per_ssn_i = NULL                              => -0.0002440932,
                                                             -0.0002440932);

final_score_271_c1014 := map(
    NULL < f_curraddrcrimeindex_i AND f_curraddrcrimeindex_i <= 196.5 => -0.0020642251,
    f_curraddrcrimeindex_i > 196.5                                    => -0.0281235335,
    f_curraddrcrimeindex_i = NULL                                     => -0.0024720159,
                                                                         -0.0024720159);

final_score_271_c1013 := map(
    NULL < f_inq_other_count24_i AND f_inq_other_count24_i <= 2.5 => final_score_271_c1014,
    f_inq_other_count24_i > 2.5                                   => 0.0099287921,
    f_inq_other_count24_i = NULL                                  => -0.0015797882,
                                                                     -0.0015797882);

final_score_271 := map(
    NULL < f_fp_prevaddrcrimeindex_i AND f_fp_prevaddrcrimeindex_i <= 166.5 => final_score_271_c1013,
    f_fp_prevaddrcrimeindex_i > 166.5                                       => 0.0038540974,
    f_fp_prevaddrcrimeindex_i = NULL                                        => 0.0003061890,
                                                                               0.0000096574);

final_score_272_c1016 := map(
    NULL < f_rel_ageover40_count_d AND f_rel_ageover40_count_d <= 9.5 => 0.0002603772,
    f_rel_ageover40_count_d > 9.5                                     => -0.0089882888,
    f_rel_ageover40_count_d = NULL                                    => -0.0045943762,
                                                                         -0.0006913140);

final_score_272_c1017 := map(
    NULL < f_mos_liens_unrel_cj_lseen_d AND f_mos_liens_unrel_cj_lseen_d <= 50.5 => -0.0200281880,
    f_mos_liens_unrel_cj_lseen_d > 50.5                                          => 0.0132062884,
    f_mos_liens_unrel_cj_lseen_d = NULL                                          => 0.0085847629,
                                                                                    0.0085847629);

final_score_272 := map(
    NULL < f_liens_unrel_st_ct_i AND f_liens_unrel_st_ct_i <= 0.5 => final_score_272_c1016,
    f_liens_unrel_st_ct_i > 0.5                                   => final_score_272_c1017,
    f_liens_unrel_st_ct_i = NULL                                  => -0.0045956504,
                                                                     -0.0000575613);

final_score_273_c1019 := map(
    NULL < f_rel_ageover20_count_d AND f_rel_ageover20_count_d <= 27.5 => -0.0005594647,
    f_rel_ageover20_count_d > 27.5                                     => 0.0084680961,
    f_rel_ageover20_count_d = NULL                                     => 0.0055526441,
                                                                          0.0002066232);

final_score_273_c1020 := map(
    NULL < f_fp_prevaddrcrimeindex_i AND f_fp_prevaddrcrimeindex_i <= 179.5 => -0.0221696019,
    f_fp_prevaddrcrimeindex_i > 179.5                                       => 0.0176494962,
    f_fp_prevaddrcrimeindex_i = NULL                                        => -0.0146130840,
                                                                               -0.0146130840);

final_score_273 := map(
    NULL < r_d31_bk_filing_count_i AND r_d31_bk_filing_count_i <= 1.5 => final_score_273_c1019,
    r_d31_bk_filing_count_i > 1.5                                     => final_score_273_c1020,
    r_d31_bk_filing_count_i = NULL                                    => -0.0000258672,
                                                                         -0.0002452324);

final_score_274_c1023 := map(
    NULL < f_curraddractivephonelist_d AND f_curraddractivephonelist_d <= 0.5 => 0.0143280003,
    f_curraddractivephonelist_d > 0.5                                         => -0.0019624310,
    f_curraddractivephonelist_d = NULL                                        => 0.0092893087,
                                                                                 0.0092893087);

final_score_274_c1022 := map(
    NULL < f_srchunvrfdssncount_i AND f_srchunvrfdssncount_i <= 0.5 => -0.0005080394,
    f_srchunvrfdssncount_i > 0.5                                    => final_score_274_c1023,
    f_srchunvrfdssncount_i = NULL                                   => 0.0005279948,
                                                                       0.0005279948);

final_score_274 := map(
    NULL < r_i60_inq_comm_count12_i AND r_i60_inq_comm_count12_i <= 1.5 => final_score_274_c1022,
    r_i60_inq_comm_count12_i > 1.5                                      => -0.0047425972,
    r_i60_inq_comm_count12_i = NULL                                     => 0.0072325436,
                                                                           -0.0012420411);

final_score_275_c1026 := map(
    NULL < f_addrchangevaluediff_d AND f_addrchangevaluediff_d <= -26644 => 0.0286321741,
    f_addrchangevaluediff_d > -26644                                     => -0.0016848500,
    f_addrchangevaluediff_d = NULL                                       => 0.0091868267,
                                                                            0.0033427214);

final_score_275_c1025 := map(
    NULL < f_prevaddrmedianincome_d AND f_prevaddrmedianincome_d <= 62397.5 => final_score_275_c1026,
    f_prevaddrmedianincome_d > 62397.5                                      => 0.0305562994,
    f_prevaddrmedianincome_d = NULL                                         => 0.0079045351,
                                                                               0.0079045351);

final_score_275 := map(
    NULL < f_inq_collection_count24_i AND f_inq_collection_count24_i <= 1.5 => -0.0002099324,
    f_inq_collection_count24_i > 1.5                                        => final_score_275_c1025,
    f_inq_collection_count24_i = NULL                                       => 0.0061509066,
                                                                               0.0006121505);

final_score_276_c1029 := map(
    NULL < f_mos_acc_lseen_d AND f_mos_acc_lseen_d <= 138.5 => 0.0508021914,
    f_mos_acc_lseen_d > 138.5                               => 0.0107656305,
    f_mos_acc_lseen_d = NULL                                => 0.0168019120,
                                                               0.0168019120);

final_score_276_c1028 := map(
    NULL < f_mos_liens_unrel_cj_lseen_d AND f_mos_liens_unrel_cj_lseen_d <= 50.5 => -0.0158294340,
    f_mos_liens_unrel_cj_lseen_d > 50.5                                          => final_score_276_c1029,
    f_mos_liens_unrel_cj_lseen_d = NULL                                          => 0.0110191418,
                                                                                    0.0110191418);

final_score_276 := map(
    NULL < f_mos_liens_unrel_st_lseen_d AND f_mos_liens_unrel_st_lseen_d <= 122.5 => final_score_276_c1028,
    f_mos_liens_unrel_st_lseen_d > 122.5                                          => -0.0008338947,
    f_mos_liens_unrel_st_lseen_d = NULL                                           => 0.0002561000,
                                                                                     -0.0002477843);

final_score_277_c1032 := map(
    NULL < f_liens_unrel_o_total_amt_i AND f_liens_unrel_o_total_amt_i <= 203 => 0.0042468438,
    f_liens_unrel_o_total_amt_i > 203                                         => -0.0128863741,
    f_liens_unrel_o_total_amt_i = NULL                                        => 0.0030694524,
                                                                                 0.0030694524);

final_score_277_c1031 := map(
    NULL < f_add_curr_mobility_index_i AND f_add_curr_mobility_index_i <= 0.29668242255 => -0.0009366894,
    f_add_curr_mobility_index_i > 0.29668242255                                         => final_score_277_c1032,
    f_add_curr_mobility_index_i = NULL                                                  => 0.0349572167,
                                                                                           0.0010080824);

final_score_277 := map(
    NULL < f_hh_members_w_derog_i AND f_hh_members_w_derog_i <= 0.5 => -0.0052647870,
    f_hh_members_w_derog_i > 0.5                                    => final_score_277_c1031,
    f_hh_members_w_derog_i = NULL                                   => 0.0033861224,
                                                                       -0.0003136944);

final_score_278_c1034 := map(
    NULL < k_comb_age_d AND k_comb_age_d <= 81.5 => -0.0000059117,
    k_comb_age_d > 81.5                          => 0.0304439514,
    k_comb_age_d = NULL                          => 0.0003674920,
                                                    0.0003674920);

final_score_278_c1035 := map(
    NULL < f_add_input_nhood_mfd_pct_i AND f_add_input_nhood_mfd_pct_i <= 0.28076162825 => -0.0152531322,
    f_add_input_nhood_mfd_pct_i > 0.28076162825                                         => 0.0062364009,
    f_add_input_nhood_mfd_pct_i = NULL                                                  => -0.0245865009,
                                                                                           -0.0042131490);

final_score_278 := map(
    NULL < f_rel_incomeover75_count_d AND f_rel_incomeover75_count_d <= 8.5 => final_score_278_c1034,
    f_rel_incomeover75_count_d > 8.5                                        => 0.0175472120,
    f_rel_incomeover75_count_d = NULL                                       => final_score_278_c1035,
                                                                               0.0004924790);

final_score_279_c1038 := map(
    NULL < f_liens_unrel_o_total_amt_i AND f_liens_unrel_o_total_amt_i <= 330 => -0.0030336678,
    f_liens_unrel_o_total_amt_i > 330                                         => -0.0270873488,
    f_liens_unrel_o_total_amt_i = NULL                                        => -0.0041154807,
                                                                                 -0.0041154807);

final_score_279_c1037 := map(
    NULL < f_util_add_curr_conv_n AND f_util_add_curr_conv_n <= 0.5 => final_score_279_c1038,
    f_util_add_curr_conv_n > 0.5                                    => 0.0017637004,
    f_util_add_curr_conv_n = NULL                                   => -0.0001138932,
                                                                       -0.0001138932);

final_score_279 := map(
    NULL < f_hh_payday_loan_users_i AND f_hh_payday_loan_users_i <= 1.5 => final_score_279_c1037,
    f_hh_payday_loan_users_i > 1.5                                      => -0.0199613176,
    f_hh_payday_loan_users_i = NULL                                     => 0.0066404068,
                                                                           -0.0004307725);

final_score_280_c1041 := map(
    NULL < f_addrchangevaluediff_d AND f_addrchangevaluediff_d <= -177817 => -0.0211042076,
    f_addrchangevaluediff_d > -177817                                     => 0.0090147593,
    f_addrchangevaluediff_d = NULL                                        => 0.0006216920,
                                                                             0.0062475505);

final_score_280_c1040 := map(
    NULL < f_rel_incomeover50_count_d AND f_rel_incomeover50_count_d <= 3.5 => final_score_280_c1041,
    f_rel_incomeover50_count_d > 3.5                                        => -0.0019150235,
    f_rel_incomeover50_count_d = NULL                                       => 0.0097329237,
                                                                               0.0034642177);

final_score_280 := map(
    NULL < f_hh_age_18_plus_d AND f_hh_age_18_plus_d <= 1.5 => final_score_280_c1040,
    f_hh_age_18_plus_d > 1.5                                => -0.0013135687,
    f_hh_age_18_plus_d = NULL                               => 0.0000984146,
                                                               0.0006342777);

final_score_281_c1043 := map(
    NULL < r_d30_derog_count_i AND r_d30_derog_count_i <= 9.5 => -0.0047716123,
    r_d30_derog_count_i > 9.5                                 => -0.0302604410,
    r_d30_derog_count_i = NULL                                => -0.0084825383,
                                                                 -0.0084825383);

final_score_281_c1044 := map(
    NULL < f_add_input_nhood_bus_pct_i AND f_add_input_nhood_bus_pct_i <= 0.0656626969 => -0.0197704847,
    f_add_input_nhood_bus_pct_i > 0.0656626969                                         => 0.0156609372,
    f_add_input_nhood_bus_pct_i = NULL                                                 => -0.0049256992,
                                                                                          -0.0049256992);

final_score_281 := map(
    NULL < r_c10_m_hdr_fs_d AND r_c10_m_hdr_fs_d <= 373.5 => 0.0009281315,
    r_c10_m_hdr_fs_d > 373.5                              => final_score_281_c1043,
    r_c10_m_hdr_fs_d = NULL                               => final_score_281_c1044,
                                                             0.0000393398);

final_score_282_c1046 := map(
    NULL < f_rel_under25miles_cnt_d AND f_rel_under25miles_cnt_d <= 0.5 => 0.0103405345,
    f_rel_under25miles_cnt_d > 0.5                                      => -0.0002601284,
    f_rel_under25miles_cnt_d = NULL                                     => -0.0018601502,
                                                                           0.0001037349);

final_score_282_c1047 := map(
    NULL < f_curraddrmedianvalue_d AND f_curraddrmedianvalue_d <= 74372.5 => -0.0289620938,
    f_curraddrmedianvalue_d > 74372.5                                     => -0.0036862771,
    f_curraddrmedianvalue_d = NULL                                        => -0.0118450565,
                                                                             -0.0118450565);

final_score_282 := map(
    NULL < f_add_input_nhood_vac_pct_i AND f_add_input_nhood_vac_pct_i <= 0.3606948992 => final_score_282_c1046,
    f_add_input_nhood_vac_pct_i > 0.3606948992                                         => final_score_282_c1047,
    f_add_input_nhood_vac_pct_i = NULL                                                 => -0.0005027657,
                                                                                          -0.0005027657);

final_score_283_c1049 := map(
    NULL < r_c14_addrs_15yr_i AND r_c14_addrs_15yr_i <= 5.5 => -0.0010754081,
    r_c14_addrs_15yr_i > 5.5                                => 0.0107938255,
    r_c14_addrs_15yr_i = NULL                               => 0.0021960288,
                                                               0.0021960288);

final_score_283_c1050 := map(
    NULL < r_a46_curr_avm_autoval_d AND r_a46_curr_avm_autoval_d <= 93247.5 => -0.0096297468,
    r_a46_curr_avm_autoval_d > 93247.5                                      => 0.0136136091,
    r_a46_curr_avm_autoval_d = NULL                                         => -0.0011866983,
                                                                               -0.0010748545);

final_score_283 := map(
    NULL < r_a49_curr_avm_chg_1yr_i AND r_a49_curr_avm_chg_1yr_i <= 64587 => final_score_283_c1049,
    r_a49_curr_avm_chg_1yr_i > 64587                                      => -0.0165993334,
    r_a49_curr_avm_chg_1yr_i = NULL                                       => final_score_283_c1050,
                                                                             -0.0003817490);

final_score_284_c1053 := map(
    NULL < f_rel_ageover40_count_d AND f_rel_ageover40_count_d <= 6.5 => 0.0011544345,
    f_rel_ageover40_count_d > 6.5                                     => -0.0074337829,
    f_rel_ageover40_count_d = NULL                                    => 0.0034018034,
                                                                         -0.0001023777);

final_score_284_c1052 := map(
    NULL < f_hh_college_attendees_d AND f_hh_college_attendees_d <= 1.5 => final_score_284_c1053,
    f_hh_college_attendees_d > 1.5                                      => 0.0333957282,
    f_hh_college_attendees_d = NULL                                     => 0.0020109308,
                                                                           0.0002585891);

final_score_284 := map(
    NULL < r_l80_inp_avm_autoval_d AND r_l80_inp_avm_autoval_d <= 8842 => 0.0303910190,
    r_l80_inp_avm_autoval_d > 8842                                     => -0.0017824058,
    r_l80_inp_avm_autoval_d = NULL                                     => final_score_284_c1052,
                                                                          -0.0002794811);

final_score_285_c1056 := map(
    NULL < f_add_input_nhood_sfd_pct_d AND f_add_input_nhood_sfd_pct_d <= 0.9413261488 => -0.0087360757,
    f_add_input_nhood_sfd_pct_d > 0.9413261488                                         => 0.0241261062,
    f_add_input_nhood_sfd_pct_d = NULL                                                 => 0.0034760143,
                                                                                          0.0034760143);

final_score_285_c1055 := map(
    NULL < f_add_curr_mobility_index_i AND f_add_curr_mobility_index_i <= 0.22634551575 => final_score_285_c1056,
    f_add_curr_mobility_index_i > 0.22634551575                                         => -0.0123560706,
    f_add_curr_mobility_index_i = NULL                                                  => -0.0069782834,
                                                                                           -0.0069782834);

final_score_285 := map(
    NULL < f_rel_ageover40_count_d AND f_rel_ageover40_count_d <= 7.5 => 0.0008161760,
    f_rel_ageover40_count_d > 7.5                                     => final_score_285_c1055,
    f_rel_ageover40_count_d = NULL                                    => -0.0000369540,
                                                                         -0.0002382750);

final_score_286_c1058 := map(
    NULL < f_srchunvrfdssncount_i AND f_srchunvrfdssncount_i <= 0.5 => 0.0015826617,
    f_srchunvrfdssncount_i > 0.5                                    => 0.0128177312,
    f_srchunvrfdssncount_i = NULL                                   => 0.0027571946,
                                                                       0.0027571946);

final_score_286_c1059 := map(
    NULL < f_add_input_nhood_vac_pct_i AND f_add_input_nhood_vac_pct_i <= 0.02396340145 => -0.0092065589,
    f_add_input_nhood_vac_pct_i > 0.02396340145                                         => 0.0015741270,
    f_add_input_nhood_vac_pct_i = NULL                                                  => -0.0026958112,
                                                                                           -0.0026958112);

final_score_286 := map(
    NULL < r_i60_inq_comm_count12_i AND r_i60_inq_comm_count12_i <= 1.5 => final_score_286_c1058,
    r_i60_inq_comm_count12_i > 1.5                                      => final_score_286_c1059,
    r_i60_inq_comm_count12_i = NULL                                     => -0.0048245187,
                                                                           0.0007478847);

final_score_287_c1061 := map(
    (nf_seg_fraudpoint_3_0 in ['5: Vuln Vic/Friendly', '6: Other'])                                    => -0.0144524236,
    (nf_seg_fraudpoint_3_0 in ['1: Stolen/Manip ID', '2: Synth ID', '3: Derog', '4: Recent Activity']) => -0.0021535053,
    nf_seg_fraudpoint_3_0 = ''                                                                       => -0.0051212833,
                                                                                                          -0.0051212833);

final_score_287_c1062 := map(
    NULL < f_historical_count_d AND f_historical_count_d <= 17.5 => 0.0010765778,
    f_historical_count_d > 17.5                                  => 0.0353655678,
    f_historical_count_d = NULL                                  => 0.0013497527,
                                                                    0.0013497527);

final_score_287 := map(
    NULL < f_addrs_per_ssn_i AND f_addrs_per_ssn_i <= 5.5 => final_score_287_c1061,
    f_addrs_per_ssn_i > 5.5                               => final_score_287_c1062,
    f_addrs_per_ssn_i = NULL                              => -0.0002202544,
                                                             -0.0002202544);

final_score_288_c1065 := map(
    NULL < r_wealth_index_d AND r_wealth_index_d <= 2.5 => 0.0295256296,
    r_wealth_index_d > 2.5                              => 0.0004984430,
    r_wealth_index_d = NULL                             => 0.0087868863,
                                                           0.0087868863);

final_score_288_c1064 := map(
    NULL < f_add_curr_nhood_vac_pct_i AND f_add_curr_nhood_vac_pct_i <= 0.09929577465 => final_score_288_c1065,
    f_add_curr_nhood_vac_pct_i > 0.09929577465                                        => 0.0521181592,
    f_add_curr_nhood_vac_pct_i = NULL                                                 => 0.0136066715,
                                                                                         0.0136066715);

final_score_288 := map(
    NULL < f_add_input_nhood_bus_pct_i AND f_add_input_nhood_bus_pct_i <= 0.004369995 => final_score_288_c1064,
    f_add_input_nhood_bus_pct_i > 0.004369995                                         => 0.0003063320,
    f_add_input_nhood_bus_pct_i = NULL                                                => -0.0021847837,
                                                                                         0.0006999972);

final_score_289_c1068 := map(
    NULL < f_hh_age_30_plus_d AND f_hh_age_30_plus_d <= 0.5 => 0.0102257382,
    f_hh_age_30_plus_d > 0.5                                => -0.0042055134,
    f_hh_age_30_plus_d = NULL                               => -0.0053169478,
                                                               -0.0017940978);

final_score_289_c1067 := map(
    NULL < f_add_input_nhood_mfd_pct_i AND f_add_input_nhood_mfd_pct_i <= 0.97973260965 => final_score_289_c1068,
    f_add_input_nhood_mfd_pct_i > 0.97973260965                                         => 0.0295357944,
    f_add_input_nhood_mfd_pct_i = NULL                                                  => 0.0001805846,
                                                                                           -0.0008041321);

final_score_289 := map(
    NULL < f_addrchangecrimediff_i AND f_addrchangecrimediff_i <= -128.5 => 0.0259557529,
    f_addrchangecrimediff_i > -128.5                                     => 0.0001706021,
    f_addrchangecrimediff_i = NULL                                       => final_score_289_c1067,
                                                                            0.0001001194);

final_score_290_c1070 := map(
    NULL < f_prevaddrmedianincome_d AND f_prevaddrmedianincome_d <= 13904 => 0.0178826615,
    f_prevaddrmedianincome_d > 13904                                      => -0.0011118553,
    f_prevaddrmedianincome_d = NULL                                       => -0.0006176282,
                                                                             -0.0006176282);

final_score_290_c1071 := map(
    NULL < f_liens_unrel_sc_total_amt_i AND f_liens_unrel_sc_total_amt_i <= 512 => 0.0011819959,
    f_liens_unrel_sc_total_amt_i > 512                                          => -0.0197664377,
    f_liens_unrel_sc_total_amt_i = NULL                                         => -0.0000167633,
                                                                                   -0.0004670887);

final_score_290 := map(
    NULL < f_addrchangecrimediff_i AND f_addrchangecrimediff_i <= -103.5 => 0.0194094719,
    f_addrchangecrimediff_i > -103.5                                     => final_score_290_c1070,
    f_addrchangecrimediff_i = NULL                                       => final_score_290_c1071,
                                                                            -0.0003419312);

final_score_291_c1073 := map(
    NULL < f_m_bureau_adl_fs_notu_d AND f_m_bureau_adl_fs_notu_d <= 408.5 => -0.0060593813,
    f_m_bureau_adl_fs_notu_d > 408.5                                      => 0.0208936096,
    f_m_bureau_adl_fs_notu_d = NULL                                       => -0.0051041635,
                                                                             -0.0051041635);

final_score_291_c1074 := map(
    NULL < f_add_curr_nhood_mfd_pct_i AND f_add_curr_nhood_mfd_pct_i <= 0.09978592405 => 0.0063797015,
    f_add_curr_nhood_mfd_pct_i > 0.09978592405                                        => -0.0007754181,
    f_add_curr_nhood_mfd_pct_i = NULL                                                 => 0.0048873181,
                                                                                         0.0016522596);

final_score_291 := map(
    NULL < f_prevaddrcartheftindex_i AND f_prevaddrcartheftindex_i <= 76 => final_score_291_c1073,
    f_prevaddrcartheftindex_i > 76                                       => final_score_291_c1074,
    f_prevaddrcartheftindex_i = NULL                                     => -0.0099819600,
                                                                            -0.0001761900);

final_score_292_c1076 := map(
    NULL < f_add_input_nhood_bus_pct_i AND f_add_input_nhood_bus_pct_i <= 0.087392817 => 0.0015216612,
    f_add_input_nhood_bus_pct_i > 0.087392817                                         => 0.0273142328,
    f_add_input_nhood_bus_pct_i = NULL                                                => 0.0040425641,
                                                                                         0.0040425641);

final_score_292_c1077 := map(
    NULL < f_add_input_mobility_index_i AND f_add_input_mobility_index_i <= 0.2132137266 => -0.0084666002,
    f_add_input_mobility_index_i > 0.2132137266                                          => 0.0122630775,
    f_add_input_mobility_index_i = NULL                                                  => 0.0045157008,
                                                                                            0.0045157008);

final_score_292 := map(
    NULL < f_add_input_nhood_mfd_pct_i AND f_add_input_nhood_mfd_pct_i <= 0.8427473253 => -0.0011124597,
    f_add_input_nhood_mfd_pct_i > 0.8427473253                                         => final_score_292_c1076,
    f_add_input_nhood_mfd_pct_i = NULL                                                 => final_score_292_c1077,
                                                                                          -0.0000111504);

final_score_293_c1080 := map(
    NULL < f_util_add_input_conv_n AND f_util_add_input_conv_n <= 0.5 => -0.0423186753,
    f_util_add_input_conv_n > 0.5                                     => 0.0030436398,
    f_util_add_input_conv_n = NULL                                    => -0.0162253082,
                                                                         -0.0162253082);

final_score_293_c1079 := map(
    NULL < f_sourcerisktype_i AND f_sourcerisktype_i <= 6.5 => 0.0132852869,
    f_sourcerisktype_i > 6.5                                => final_score_293_c1080,
    f_sourcerisktype_i = NULL                               => 0.0067975491,
                                                               0.0067975491);

final_score_293 := map(
    NULL < k_estimated_income_d AND k_estimated_income_d <= 23500 => final_score_293_c1079,
    k_estimated_income_d > 23500                                  => -0.0009922572,
    k_estimated_income_d = NULL                                   => 0.0054680850,
                                                                     -0.0004219398);

final_score_294_c1083 := map(
    NULL < f_rel_educationover12_count_d AND f_rel_educationover12_count_d <= 3.5 => 0.0050753268,
    f_rel_educationover12_count_d > 3.5                                           => -0.0028856037,
    f_rel_educationover12_count_d = NULL                                          => -0.0011427847,
                                                                                     -0.0007346470);

final_score_294_c1082 := map(
    NULL < f_add_input_nhood_sfd_pct_d AND f_add_input_nhood_sfd_pct_d <= 0.8626194376 => final_score_294_c1083,
    f_add_input_nhood_sfd_pct_d > 0.8626194376                                         => 0.0060719346,
    f_add_input_nhood_sfd_pct_d = NULL                                                 => 0.0011588506,
                                                                                          0.0011588506);

final_score_294 := map(
    NULL < f_add_curr_nhood_vac_pct_i AND f_add_curr_nhood_vac_pct_i <= 0.01044477335 => -0.0045535342,
    f_add_curr_nhood_vac_pct_i > 0.01044477335                                        => final_score_294_c1082,
    f_add_curr_nhood_vac_pct_i = NULL                                                 => -0.0060200690,
                                                                                         -0.0005805673);

final_score_295_c1086 := map(
    NULL < f_add_input_nhood_mfd_pct_i AND f_add_input_nhood_mfd_pct_i <= 0.6151813346 => 0.0053761725,
    f_add_input_nhood_mfd_pct_i > 0.6151813346                                         => -0.0045875776,
    f_add_input_nhood_mfd_pct_i = NULL                                                 => 0.0112670096,
                                                                                          0.0034107213);

final_score_295_c1085 := map(
    NULL < f_add_input_mobility_index_i AND f_add_input_mobility_index_i <= 0.3079088023 => -0.0015661270,
    f_add_input_mobility_index_i > 0.3079088023                                          => final_score_295_c1086,
    f_add_input_mobility_index_i = NULL                                                  => 0.0130140979,
                                                                                            0.0004841571);

final_score_295 := map(
    NULL < f_rel_ageover40_count_d AND f_rel_ageover40_count_d <= 21.5 => final_score_295_c1085,
    f_rel_ageover40_count_d > 21.5                                     => -0.0341129305,
    f_rel_ageover40_count_d = NULL                                     => -0.0054471216,
                                                                          -0.0000092595);

final_score_296_c1089 := map(
    NULL < f_add_input_nhood_sfd_pct_d AND f_add_input_nhood_sfd_pct_d <= 0.4046234361 => -0.0239829600,
    f_add_input_nhood_sfd_pct_d > 0.4046234361                                         => 0.0034843769,
    f_add_input_nhood_sfd_pct_d = NULL                                                 => -0.0107493038,
                                                                                          -0.0107493038);

final_score_296_c1088 := map(
    NULL < f_curraddrcartheftindex_i AND f_curraddrcartheftindex_i <= 197.5 => 0.0026617175,
    f_curraddrcartheftindex_i > 197.5                                       => final_score_296_c1089,
    f_curraddrcartheftindex_i = NULL                                        => 0.0021462218,
                                                                               0.0021462218);

final_score_296 := map(
    NULL < f_mos_acc_lseen_d AND f_mos_acc_lseen_d <= 64.5 => -0.0055818123,
    f_mos_acc_lseen_d > 64.5                               => final_score_296_c1088,
    f_mos_acc_lseen_d = NULL                               => -0.0044334693,
                                                              0.0011881955);

final_score_297_c1092 := map(
    NULL < r_c13_curr_addr_lres_d AND r_c13_curr_addr_lres_d <= 45.5 => -0.0459525543,
    r_c13_curr_addr_lres_d > 45.5                                    => -0.0029045467,
    r_c13_curr_addr_lres_d = NULL                                    => -0.0201710552,
                                                                        -0.0201710552);

final_score_297_c1091 := map(
    NULL < f_mos_liens_rel_cj_fseen_d AND f_mos_liens_rel_cj_fseen_d <= 102.5 => final_score_297_c1092,
    f_mos_liens_rel_cj_fseen_d > 102.5                                        => -0.0008323097,
    f_mos_liens_rel_cj_fseen_d = NULL                                         => -0.0011246153,
                                                                                 -0.0011246153);

final_score_297 := map(
    NULL < f_srchlocatesrchcountwk_i AND f_srchlocatesrchcountwk_i <= 0.5 => final_score_297_c1091,
    f_srchlocatesrchcountwk_i > 0.5                                       => 0.0318497716,
    f_srchlocatesrchcountwk_i = NULL                                      => 0.0026529909,
                                                                             -0.0009130846);

final_score_298_c1095 := map(
    NULL < k_inq_per_addr_i AND k_inq_per_addr_i <= 16.5 => 0.0015759085,
    k_inq_per_addr_i > 16.5                              => 0.0379890450,
    k_inq_per_addr_i = NULL                              => 0.0019637584,
                                                            0.0019637584);

final_score_298_c1094 := map(
    NULL < r_a46_curr_avm_autoval_d AND r_a46_curr_avm_autoval_d <= 30328.5 => 0.0147664440,
    r_a46_curr_avm_autoval_d > 30328.5                                      => 0.0003377888,
    r_a46_curr_avm_autoval_d = NULL                                         => final_score_298_c1095,
                                                                               0.0023437198);

final_score_298 := map(
    NULL < f_rel_ageover40_count_d AND f_rel_ageover40_count_d <= 3.5 => final_score_298_c1094,
    f_rel_ageover40_count_d > 3.5                                     => -0.0040688974,
    f_rel_ageover40_count_d = NULL                                    => 0.0001324533,
                                                                         -0.0000224907);

final_score_299_c1098 := map(
    NULL < r_c13_curr_addr_lres_d AND r_c13_curr_addr_lres_d <= 202.5 => -0.0039203683,
    r_c13_curr_addr_lres_d > 202.5                                    => 0.0368841386,
    r_c13_curr_addr_lres_d = NULL                                     => 0.0013033971,
                                                                         0.0013033971);

final_score_299_c1097 := map(
    NULL < f_curraddrmurderindex_i AND f_curraddrmurderindex_i <= 115.5 => final_score_299_c1098,
    f_curraddrmurderindex_i > 115.5                                     => -0.0140736737,
    f_curraddrmurderindex_i = NULL                                      => -0.0075754356,
                                                                           -0.0075754356);

final_score_299 := map(
    NULL < f_inq_communications_cnt_week_i AND f_inq_communications_cnt_week_i <= 1.5 => 0.0006518102,
    f_inq_communications_cnt_week_i > 1.5                                             => final_score_299_c1097,
    f_inq_communications_cnt_week_i = NULL                                            => 0.0016408930,
                                                                                         -0.0003216978);

final_score_300_c1101 := map(
    NULL < f_mos_liens_rel_o_lseen_d AND f_mos_liens_rel_o_lseen_d <= 300.5 => 0.0319088117,
    f_mos_liens_rel_o_lseen_d > 300.5                                       => -0.0000162280,
    f_mos_liens_rel_o_lseen_d = NULL                                        => 0.0001225645,
                                                                               0.0001225645);

final_score_300_c1100 := map(
    NULL < f_add_input_mobility_index_i AND f_add_input_mobility_index_i <= 0.14593000865 => -0.0169270681,
    f_add_input_mobility_index_i > 0.14593000865                                          => final_score_300_c1101,
    f_add_input_mobility_index_i = NULL                                                   => -0.0170771651,
                                                                                             -0.0004805517);

final_score_300 := map(
    NULL < f_mos_foreclosure_lseen_d AND f_mos_foreclosure_lseen_d <= 37.5 => 0.0319970375,
    f_mos_foreclosure_lseen_d > 37.5                                       => final_score_300_c1100,
    f_mos_foreclosure_lseen_d = NULL                                       => -0.0100404217,
                                                                              -0.0004003412);

final_score_301_c1103 := map(
    NULL < f_add_curr_nhood_sfd_pct_d AND f_add_curr_nhood_sfd_pct_d <= 0.9833610188 => 0.0007240240,
    f_add_curr_nhood_sfd_pct_d > 0.9833610188                                        => -0.0108927770,
    f_add_curr_nhood_sfd_pct_d = NULL                                                => 0.0000367519,
                                                                                        0.0000367519);

final_score_301_c1104 := map(
    NULL < f_crim_rel_under500miles_cnt_i AND f_crim_rel_under500miles_cnt_i <= 1.5 => 0.0086693383,
    f_crim_rel_under500miles_cnt_i > 1.5                                            => -0.0171848881,
    f_crim_rel_under500miles_cnt_i = NULL                                           => -0.0104574325,
                                                                                       -0.0104574325);

final_score_301 := map(
    NULL < f_vardobcount_i AND f_vardobcount_i <= 2.5 => final_score_301_c1103,
    f_vardobcount_i > 2.5                             => final_score_301_c1104,
    f_vardobcount_i = NULL                            => 0.0002998195,
                                                         -0.0006653445);

final_score_302_c1107 := map(
    NULL < f_prevaddrmedianincome_d AND f_prevaddrmedianincome_d <= 102749.5 => 0.0008701204,
    f_prevaddrmedianincome_d > 102749.5                                      => -0.0345476409,
    f_prevaddrmedianincome_d = NULL                                          => 0.0006899545,
                                                                                0.0006899545);

final_score_302_c1106 := map(
    NULL < f_curraddrmedianincome_d AND f_curraddrmedianincome_d <= 78762 => final_score_302_c1107,
    f_curraddrmedianincome_d > 78762                                      => 0.0110413510,
    f_curraddrmedianincome_d = NULL                                       => 0.0013164065,
                                                                             0.0013164065);

final_score_302 := map(
    NULL < f_addrs_per_ssn_i AND f_addrs_per_ssn_i <= 3.5 => -0.0060018738,
    f_addrs_per_ssn_i > 3.5                               => final_score_302_c1106,
    f_addrs_per_ssn_i = NULL                              => 0.0003040563,
                                                             0.0003040563);

final_score_303_c1110 := map(
    NULL < f_prevaddrmedianvalue_d AND f_prevaddrmedianvalue_d <= 539991 => -0.0020416352,
    f_prevaddrmedianvalue_d > 539991                                     => 0.0209128675,
    f_prevaddrmedianvalue_d = NULL                                       => -0.0044891616,
                                                                            -0.0014079269);

final_score_303_c1109 := map(
    NULL < f_add_input_mobility_index_i AND f_add_input_mobility_index_i <= 0.34828261015 => final_score_303_c1110,
    f_add_input_mobility_index_i > 0.34828261015                                          => 0.0067101739,
    f_add_input_mobility_index_i = NULL                                                   => -0.0074208618,
                                                                                             0.0007108511);

final_score_303 := map(
    NULL < r_l80_inp_avm_autoval_d AND r_l80_inp_avm_autoval_d <= 68073 => 0.0042400295,
    r_l80_inp_avm_autoval_d > 68073                                     => -0.0050070676,
    r_l80_inp_avm_autoval_d = NULL                                      => final_score_303_c1109,
                                                                           0.0001481365);

final_score_304_c1112 := map(
    NULL < r_i60_inq_auto_recency_d AND r_i60_inq_auto_recency_d <= 18 => -0.0209287991,
    r_i60_inq_auto_recency_d > 18                                      => -0.0013968056,
    r_i60_inq_auto_recency_d = NULL                                    => -0.0022036563,
                                                                          -0.0022036563);

final_score_304_c1113 := map(
    NULL < r_a49_curr_avm_chg_1yr_i AND r_a49_curr_avm_chg_1yr_i <= 54003.5 => 0.0036327157,
    r_a49_curr_avm_chg_1yr_i > 54003.5                                      => -0.0226025524,
    r_a49_curr_avm_chg_1yr_i = NULL                                         => 0.0018526169,
                                                                               0.0019780520);

final_score_304 := map(
    NULL < r_c13_max_lres_d AND r_c13_max_lres_d <= 111.5 => final_score_304_c1112,
    r_c13_max_lres_d > 111.5                              => final_score_304_c1113,
    r_c13_max_lres_d = NULL                               => -0.0009126122,
                                                             0.0003323025);

final_score_305_c1115 := map(
    NULL < f_add_curr_nhood_mfd_pct_i AND f_add_curr_nhood_mfd_pct_i <= 0.9486822812 => -0.0013340859,
    f_add_curr_nhood_mfd_pct_i > 0.9486822812                                        => 0.0116148315,
    f_add_curr_nhood_mfd_pct_i = NULL                                                => -0.0021317963,
                                                                                        -0.0009165692);

final_score_305_c1116 := map(
    NULL < f_add_curr_nhood_vac_pct_i AND f_add_curr_nhood_vac_pct_i <= 0.04155770585 => -0.0015378967,
    f_add_curr_nhood_vac_pct_i > 0.04155770585                                        => 0.0129566960,
    f_add_curr_nhood_vac_pct_i = NULL                                                 => 0.0058456413,
                                                                                         0.0058456413);

final_score_305 := map(
    NULL < f_dl_addrs_per_adl_i AND f_dl_addrs_per_adl_i <= 2.5 => final_score_305_c1115,
    f_dl_addrs_per_adl_i > 2.5                                  => final_score_305_c1116,
    f_dl_addrs_per_adl_i = NULL                                 => 0.0005874399,
                                                                   0.0001576711);

final_score_306_c1118 := map(
    NULL < f_hh_payday_loan_users_i AND f_hh_payday_loan_users_i <= 1.5 => -0.0005768197,
    f_hh_payday_loan_users_i > 1.5                                      => -0.0176691101,
    f_hh_payday_loan_users_i = NULL                                     => -0.0009099776,
                                                                           -0.0009099776);

final_score_306_c1119 := map(
    NULL < f_adl_util_conv_n AND f_adl_util_conv_n <= 0.5 => 0.0004128056,
    f_adl_util_conv_n > 0.5                               => 0.0403469899,
    f_adl_util_conv_n = NULL                              => 0.0185382728,
                                                             0.0185382728);

final_score_306 := map(
    NULL < r_c19_add_prison_hist_i AND r_c19_add_prison_hist_i <= 0.5 => final_score_306_c1118,
    r_c19_add_prison_hist_i > 0.5                                     => final_score_306_c1119,
    r_c19_add_prison_hist_i = NULL                                    => 0.0029822547,
                                                                         -0.0005339517);

final_score_307_c1122 := map(
    NULL < f_prevaddrmedianincome_d AND f_prevaddrmedianincome_d <= 33989.5 => 0.0099806239,
    f_prevaddrmedianincome_d > 33989.5                                      => 0.0004613099,
    f_prevaddrmedianincome_d = NULL                                         => 0.0038382964,
                                                                               0.0038382964);

final_score_307_c1121 := map(
    NULL < f_addrs_per_ssn_i AND f_addrs_per_ssn_i <= 11.5 => -0.0012347933,
    f_addrs_per_ssn_i > 11.5                               => final_score_307_c1122,
    f_addrs_per_ssn_i = NULL                               => 0.0008375200,
                                                              0.0008375200);

final_score_307 := map(
    NULL < f_vardobcount_i AND f_vardobcount_i <= 2.5 => final_score_307_c1121,
    f_vardobcount_i > 2.5                             => -0.0092400166,
    f_vardobcount_i = NULL                            => -0.0031180682,
                                                         0.0000866599);

final_score_308_c1125 := map(
    NULL < f_add_curr_nhood_vac_pct_i AND f_add_curr_nhood_vac_pct_i <= 0.01453804345 => -0.0221639548,
    f_add_curr_nhood_vac_pct_i > 0.01453804345                                        => 0.0195092350,
    f_add_curr_nhood_vac_pct_i = NULL                                                 => 0.0010426793,
                                                                                         0.0010426793);

final_score_308_c1124 := map(
    NULL < r_c20_email_domain_isp_count_i AND r_c20_email_domain_isp_count_i <= 0.5 => final_score_308_c1125,
    r_c20_email_domain_isp_count_i > 0.5                                            => 0.0305290556,
    r_c20_email_domain_isp_count_i = NULL                                           => 0.0136910978,
                                                                                       0.0136910978);

final_score_308 := map(
    NULL < f_rel_incomeover75_count_d AND f_rel_incomeover75_count_d <= 7.5 => -0.0010608919,
    f_rel_incomeover75_count_d > 7.5                                        => final_score_308_c1124,
    f_rel_incomeover75_count_d = NULL                                       => -0.0011753684,
                                                                               -0.0006225643);

final_score_309_c1128 := map(
    NULL < f_add_curr_nhood_vac_pct_i AND f_add_curr_nhood_vac_pct_i <= 0.0645095661 => -0.0054563177,
    f_add_curr_nhood_vac_pct_i > 0.0645095661                                        => 0.0358041034,
    f_add_curr_nhood_vac_pct_i = NULL                                                => 0.0100978366,
                                                                                        0.0100978366);

final_score_309_c1127 := map(
    NULL < r_a49_curr_avm_chg_1yr_pct_i AND r_a49_curr_avm_chg_1yr_pct_i <= 122.45 => -0.0093169231,
    r_a49_curr_avm_chg_1yr_pct_i > 122.45                                          => final_score_309_c1128,
    r_a49_curr_avm_chg_1yr_pct_i = NULL                                            => -0.0033203637,
                                                                                      -0.0034528422);

final_score_309 := map(
    NULL < r_c13_max_lres_d AND r_c13_max_lres_d <= 93.5 => final_score_309_c1127,
    r_c13_max_lres_d > 93.5                              => 0.0016226544,
    r_c13_max_lres_d = NULL                              => 0.0079360833,
                                                            0.0001614041);

final_score_310_c1131 := map(
    NULL < r_a46_curr_avm_autoval_d AND r_a46_curr_avm_autoval_d <= 48000 => 0.0376255649,
    r_a46_curr_avm_autoval_d > 48000                                      => -0.0076350922,
    r_a46_curr_avm_autoval_d = NULL                                       => 0.0016612537,
                                                                             0.0042404683);

final_score_310_c1130 := map(
    NULL < f_rel_educationover12_count_d AND f_rel_educationover12_count_d <= 18.5 => final_score_310_c1131,
    f_rel_educationover12_count_d > 18.5                                           => 0.0436765658,
    f_rel_educationover12_count_d = NULL                                           => 0.0117955944,
                                                                                      0.0117955944);

final_score_310 := map(
    NULL < f_current_count_d AND f_current_count_d <= 5.5 => -0.0005321468,
    f_current_count_d > 5.5                               => final_score_310_c1130,
    f_current_count_d = NULL                              => -0.0033574170,
                                                             -0.0000876107);

final_score_311_c1134 := map(
    NULL < f_add_curr_nhood_vac_pct_i AND f_add_curr_nhood_vac_pct_i <= 0.0401686865 => -0.0024237157,
    f_add_curr_nhood_vac_pct_i > 0.0401686865                                        => 0.0088605091,
    f_add_curr_nhood_vac_pct_i = NULL                                                => 0.0021928364,
                                                                                        0.0021928364);

final_score_311_c1133 := map(
    NULL < f_addrchangevaluediff_d AND f_addrchangevaluediff_d <= 152407 => -0.0002437656,
    f_addrchangevaluediff_d > 152407                                     => 0.0156744320,
    f_addrchangevaluediff_d = NULL                                       => final_score_311_c1134,
                                                                            0.0006045335);

final_score_311 := map(
    NULL < f_liens_unrel_ft_total_amt_i AND f_liens_unrel_ft_total_amt_i <= 6392 => final_score_311_c1133,
    f_liens_unrel_ft_total_amt_i > 6392                                          => -0.0276912151,
    f_liens_unrel_ft_total_amt_i = NULL                                          => 0.0067670121,
                                                                                    0.0003418525);

final_score_312_c1136 := map(
    NULL < f_fp_prevaddrburglaryindex_i AND f_fp_prevaddrburglaryindex_i <= 52.5 => 0.0055032638,
    f_fp_prevaddrburglaryindex_i > 52.5                                          => -0.0019031446,
    f_fp_prevaddrburglaryindex_i = NULL                                          => -0.0006759051,
                                                                                    -0.0006759051);

final_score_312_c1137 := map(
    NULL < f_hh_workers_paw_d AND f_hh_workers_paw_d <= 0.5 => 0.0074841267,
    f_hh_workers_paw_d > 0.5                                => -0.0296914264,
    f_hh_workers_paw_d = NULL                               => -0.0071037488,
                                                               -0.0002636828);

final_score_312 := map(
    NULL < f_rel_ageover40_count_d AND f_rel_ageover40_count_d <= 21.5 => final_score_312_c1136,
    f_rel_ageover40_count_d > 21.5                                     => -0.0450740682,
    f_rel_ageover40_count_d = NULL                                     => final_score_312_c1137,
                                                                          -0.0008491446);

final_score_313_c1139 := map(
    NULL < f_add_input_nhood_bus_pct_i AND f_add_input_nhood_bus_pct_i <= 0.03963624645 => 0.0345355020,
    f_add_input_nhood_bus_pct_i > 0.03963624645                                         => 0.0052940225,
    f_add_input_nhood_bus_pct_i = NULL                                                  => 0.0188529208,
                                                                                           0.0188529208);

final_score_313_c1140 := map(
    NULL < r_l70_add_standardized_i AND r_l70_add_standardized_i <= 0.5 => -0.0006039313,
    r_l70_add_standardized_i > 0.5                                      => -0.0250327659,
    r_l70_add_standardized_i = NULL                                     => -0.0008040930,
                                                                           -0.0008040930);

final_score_313 := map(
    NULL < k_comb_age_d AND k_comb_age_d <= 20.5 => final_score_313_c1139,
    k_comb_age_d > 20.5                          => final_score_313_c1140,
    k_comb_age_d = NULL                          => -0.0005131808,
                                                    -0.0005131808);

final_score_314_c1143 := map(
    NULL < f_add_input_nhood_mfd_pct_i AND f_add_input_nhood_mfd_pct_i <= 0.53219690255 => 0.0016202178,
    f_add_input_nhood_mfd_pct_i > 0.53219690255                                         => -0.0155582763,
    f_add_input_nhood_mfd_pct_i = NULL                                                  => 0.0008090523,
                                                                                           -0.0001995268);

final_score_314_c1142 := map(
    NULL < r_l80_inp_avm_autoval_d AND r_l80_inp_avm_autoval_d <= 9348.5 => 0.0271898323,
    r_l80_inp_avm_autoval_d > 9348.5                                     => final_score_314_c1143,
    r_l80_inp_avm_autoval_d = NULL                                       => 0.0007934160,
                                                                            0.0006045959);

final_score_314 := map(
    NULL < f_phones_per_addr_curr_i AND f_phones_per_addr_curr_i <= 95.5 => final_score_314_c1142,
    f_phones_per_addr_curr_i > 95.5                                      => 0.0242898827,
    f_phones_per_addr_curr_i = NULL                                      => 0.0008195662,
                                                                            0.0007676534);

final_score_315_c1146 := map(
    NULL < f_add_input_nhood_mfd_pct_i AND f_add_input_nhood_mfd_pct_i <= 0.9949839928 => -0.0005686916,
    f_add_input_nhood_mfd_pct_i > 0.9949839928                                         => 0.0243145316,
    f_add_input_nhood_mfd_pct_i = NULL                                                 => 0.0014166596,
                                                                                          -0.0001828480);

final_score_315_c1145 := map(
    NULL < f_add_curr_nhood_vac_pct_i AND f_add_curr_nhood_vac_pct_i <= 1.10905756125 => final_score_315_c1146,
    f_add_curr_nhood_vac_pct_i > 1.10905756125                                        => 0.0249590856,
    f_add_curr_nhood_vac_pct_i = NULL                                                 => 0.0000771961,
                                                                                         0.0000771961);

final_score_315 := map(
    NULL < f_curraddrcartheftindex_i AND f_curraddrcartheftindex_i <= 197.5 => final_score_315_c1145,
    f_curraddrcartheftindex_i > 197.5                                       => -0.0114309710,
    f_curraddrcartheftindex_i = NULL                                        => 0.0055746480,
                                                                               -0.0003380902);

final_score_316_c1148 := map(
    NULL < f_add_curr_mobility_index_i AND f_add_curr_mobility_index_i <= 0.373848651 => 0.0251493281,
    f_add_curr_mobility_index_i > 0.373848651                                         => -0.0121966655,
    f_add_curr_mobility_index_i = NULL                                                => 0.0158717971,
                                                                                         0.0158717971);

final_score_316_c1149 := map(
    NULL < k_comb_age_d AND k_comb_age_d <= 22.5 => 0.0094700512,
    k_comb_age_d > 22.5                          => -0.0008322762,
    k_comb_age_d = NULL                          => -0.0004023437,
                                                    -0.0004023437);

final_score_316 := map(
    NULL < r_i60_inq_hiriskcred_recency_d AND r_i60_inq_hiriskcred_recency_d <= 4.5 => final_score_316_c1148,
    r_i60_inq_hiriskcred_recency_d > 4.5                                            => final_score_316_c1149,
    r_i60_inq_hiriskcred_recency_d = NULL                                           => 0.0110269996,
                                                                                       0.0000554024);

final_score_317_c1152 := map(
    NULL < f_rel_under100miles_cnt_d AND f_rel_under100miles_cnt_d <= 8.5 => -0.0053028413,
    f_rel_under100miles_cnt_d > 8.5                                       => 0.0226911550,
    f_rel_under100miles_cnt_d = NULL                                      => 0.0052262439,
                                                                             0.0052262439);

final_score_317_c1151 := map(
    NULL < f_rel_ageover30_count_d AND f_rel_ageover30_count_d <= 1.5 => 0.0372764605,
    f_rel_ageover30_count_d > 1.5                                     => final_score_317_c1152,
    f_rel_ageover30_count_d = NULL                                    => 0.0094247807,
                                                                         0.0094247807);

final_score_317 := map(
    NULL < f_phones_per_addr_curr_i AND f_phones_per_addr_curr_i <= 20.5 => -0.0007739993,
    f_phones_per_addr_curr_i > 20.5                                      => final_score_317_c1151,
    f_phones_per_addr_curr_i = NULL                                      => -0.0039612908,
                                                                            -0.0004700767);

final_score_318_c1155 := map(
    NULL < r_i60_inq_banking_recency_d AND r_i60_inq_banking_recency_d <= 549 => 0.0037212022,
    r_i60_inq_banking_recency_d > 549                                         => 0.0483332971,
    r_i60_inq_banking_recency_d = NULL                                        => 0.0295962173,
                                                                                 0.0295962173);

final_score_318_c1154 := map(
    NULL < k_comb_age_d AND k_comb_age_d <= 32.5 => final_score_318_c1155,
    k_comb_age_d > 32.5                          => 0.0043559878,
    k_comb_age_d = NULL                          => 0.0088122430,
                                                    0.0088122430);

final_score_318 := map(
    NULL < f_rel_homeover50_count_d AND f_rel_homeover50_count_d <= 25.5 => -0.0004224727,
    f_rel_homeover50_count_d > 25.5                                      => final_score_318_c1154,
    f_rel_homeover50_count_d = NULL                                      => -0.0018615812,
                                                                            0.0000340798);

final_score_319_c1158 := map(
    NULL < f_rel_incomeover25_count_d AND f_rel_incomeover25_count_d <= 9.5 => 0.0125662391,
    f_rel_incomeover25_count_d > 9.5                                        => -0.0036414710,
    f_rel_incomeover25_count_d = NULL                                       => 0.0050925853,
                                                                               0.0050925853);

final_score_319_c1157 := map(
    NULL < f_add_input_nhood_bus_pct_i AND f_add_input_nhood_bus_pct_i <= 0.2461189442 => final_score_319_c1158,
    f_add_input_nhood_bus_pct_i > 0.2461189442                                         => 0.0399844340,
    f_add_input_nhood_bus_pct_i = NULL                                                 => 0.0070137139,
                                                                                          0.0070137139);

final_score_319 := map(
    NULL < f_inq_communications_count24_i AND f_inq_communications_count24_i <= 4.5 => -0.0011599900,
    f_inq_communications_count24_i > 4.5                                            => final_score_319_c1157,
    f_inq_communications_count24_i = NULL                                           => 0.0050715643,
                                                                                       -0.0004014427);

final_score_320_c1161 := map(
    NULL < r_c13_curr_addr_lres_d AND r_c13_curr_addr_lres_d <= 94.5 => 0.0036032770,
    r_c13_curr_addr_lres_d > 94.5                                    => 0.0627888672,
    r_c13_curr_addr_lres_d = NULL                                    => 0.0202539546,
                                                                        0.0202539546);

final_score_320_c1160 := map(
    NULL < f_add_input_mobility_index_i AND f_add_input_mobility_index_i <= 0.34978634735 => 0.0034122224,
    f_add_input_mobility_index_i > 0.34978634735                                          => final_score_320_c1161,
    f_add_input_mobility_index_i = NULL                                                   => 0.0077645802,
                                                                                             0.0077645802);

final_score_320 := map(
    NULL < f_rel_count_i AND f_rel_count_i <= 28.5 => -0.0009892722,
    f_rel_count_i > 28.5                           => final_score_320_c1160,
    f_rel_count_i = NULL                           => 0.0025813982,
                                                      -0.0003987703);

final_score_321_c1164 := map(
    NULL < k_estimated_income_d AND k_estimated_income_d <= 19999.5 => 0.0220504538,
    k_estimated_income_d > 19999.5                                  => -0.0001754828,
    k_estimated_income_d = NULL                                     => 0.0001726429,
                                                                       0.0001726429);

final_score_321_c1163 := map(
    NULL < f_rel_educationover12_count_d AND f_rel_educationover12_count_d <= 0.5 => 0.0099067409,
    f_rel_educationover12_count_d > 0.5                                           => final_score_321_c1164,
    f_rel_educationover12_count_d = NULL                                          => 0.0080272207,
                                                                                     0.0010380799);

final_score_321 := map(
    NULL < r_i60_inq_util_recency_d AND r_i60_inq_util_recency_d <= 18 => 0.0360178338,
    r_i60_inq_util_recency_d > 18                                      => final_score_321_c1163,
    r_i60_inq_util_recency_d = NULL                                    => -0.0073905466,
                                                                          0.0011040105);

final_score_322_c1166 := map(
    NULL < k_comb_age_d AND k_comb_age_d <= 44.5 => -0.0280858953,
    k_comb_age_d > 44.5                          => 0.0014911289,
    k_comb_age_d = NULL                          => -0.0135822757,
                                                    -0.0135822757);

final_score_322_c1167 := map(
    NULL < r_l72_add_vacant_i AND r_l72_add_vacant_i <= 0.5 => -0.0020064798,
    r_l72_add_vacant_i > 0.5                                => 0.0310019521,
    r_l72_add_vacant_i = NULL                               => -0.0013522891,
                                                               -0.0013522891);

final_score_322 := map(
    NULL < f_addrchangevaluediff_d AND f_addrchangevaluediff_d <= -131392 => final_score_322_c1166,
    f_addrchangevaluediff_d > -131392                                     => -0.0002112380,
    f_addrchangevaluediff_d = NULL                                        => final_score_322_c1167,
                                                                             -0.0007947929);

final_score_323_c1169 := map(
    NULL < f_curraddrcartheftindex_i AND f_curraddrcartheftindex_i <= 197.5 => 0.0000195051,
    f_curraddrcartheftindex_i > 197.5                                       => -0.0100100852,
    f_curraddrcartheftindex_i = NULL                                        => -0.0003806104,
                                                                               -0.0003806104);

final_score_323_c1170 := map(
    NULL < k_inq_adls_per_addr_i AND k_inq_adls_per_addr_i <= 0.5 => 0.0147286308,
    k_inq_adls_per_addr_i > 0.5                                   => -0.0233830544,
    k_inq_adls_per_addr_i = NULL                                  => -0.0061337290,
                                                                     -0.0061337290);

final_score_323 := map(
    NULL < f_srchaddrsrchcountwk_i AND f_srchaddrsrchcountwk_i <= 2.5 => final_score_323_c1169,
    f_srchaddrsrchcountwk_i > 2.5                                     => 0.0250129887,
    f_srchaddrsrchcountwk_i = NULL                                    => final_score_323_c1170,
                                                                         -0.0002937334);

final_score_324_c1173 := map(
    NULL < r_c13_max_lres_d AND r_c13_max_lres_d <= 97.5 => -0.0012308755,
    r_c13_max_lres_d > 97.5                              => 0.0101414487,
    r_c13_max_lres_d = NULL                              => 0.0056782612,
                                                            0.0056782612);

final_score_324_c1172 := map(
    NULL < r_c21_m_bureau_adl_fs_d AND r_c21_m_bureau_adl_fs_d <= 282.5 => final_score_324_c1173,
    r_c21_m_bureau_adl_fs_d > 282.5                                     => -0.0023440446,
    r_c21_m_bureau_adl_fs_d = NULL                                      => 0.0023220225,
                                                                           0.0023220225);

final_score_324 := map(
    NULL < f_addrs_per_ssn_i AND f_addrs_per_ssn_i <= 11.5 => -0.0025028469,
    f_addrs_per_ssn_i > 11.5                               => final_score_324_c1172,
    f_addrs_per_ssn_i = NULL                               => -0.0004932715,
                                                              -0.0004932715);

final_score_325_c1175 := map(
    NULL < k_comb_age_d AND k_comb_age_d <= 76.5 => 0.0001484004,
    k_comb_age_d > 76.5                          => 0.0140700867,
    k_comb_age_d = NULL                          => 0.0005647021,
                                                    0.0005647021);

final_score_325_c1176 := map(
    NULL < k_inq_lnames_per_addr_i AND k_inq_lnames_per_addr_i <= 0.5 => 0.0313396687,
    k_inq_lnames_per_addr_i > 0.5                                     => -0.0127121205,
    k_inq_lnames_per_addr_i = NULL                                    => 0.0019239789,
                                                                         0.0019239789);

final_score_325 := map(
    NULL < f_liens_unrel_ft_total_amt_i AND f_liens_unrel_ft_total_amt_i <= 6892.5 => final_score_325_c1175,
    f_liens_unrel_ft_total_amt_i > 6892.5                                          => -0.0231046496,
    f_liens_unrel_ft_total_amt_i = NULL                                            => final_score_325_c1176,
                                                                                      0.0003144121);

final_score_326_c1179 := map(
    NULL < f_hh_members_ct_d AND f_hh_members_ct_d <= 2.5 => 0.0366345332,
    f_hh_members_ct_d > 2.5                               => -0.0041653192,
    f_hh_members_ct_d = NULL                              => 0.0170896937,
                                                             0.0170896937);

final_score_326_c1178 := map(
    NULL < k_comb_age_d AND k_comb_age_d <= 20.5 => final_score_326_c1179,
    k_comb_age_d > 20.5                          => -0.0003529722,
    k_comb_age_d = NULL                          => -0.0001107432,
                                                    -0.0001107432);

final_score_326 := map(
    NULL < f_curraddrmedianvalue_d AND f_curraddrmedianvalue_d <= 643415 => final_score_326_c1178,
    f_curraddrmedianvalue_d > 643415                                     => 0.0239709836,
    f_curraddrmedianvalue_d = NULL                                       => 0.0135243772,
                                                                            0.0002306583);

final_score_327_c1182 := map(
    NULL < f_rel_under25miles_cnt_d AND f_rel_under25miles_cnt_d <= 19.5 => 0.0063650499,
    f_rel_under25miles_cnt_d > 19.5                                      => 0.0493210879,
    f_rel_under25miles_cnt_d = NULL                                      => 0.0112881015,
                                                                            0.0112881015);

final_score_327_c1181 := map(
    NULL < r_d33_eviction_count_i AND r_d33_eviction_count_i <= 4.5 => -0.0001658962,
    r_d33_eviction_count_i > 4.5                                    => final_score_327_c1182,
    r_d33_eviction_count_i = NULL                                   => 0.0002668649,
                                                                       0.0002668649);

final_score_327 := map(
    NULL < f_liens_unrel_ft_total_amt_i AND f_liens_unrel_ft_total_amt_i <= 2383.5 => final_score_327_c1181,
    f_liens_unrel_ft_total_amt_i > 2383.5                                          => -0.0194543111,
    f_liens_unrel_ft_total_amt_i = NULL                                            => 0.0082071609,
                                                                                      0.0000565199);

final_score_328_c1185 := map(
    NULL < f_add_input_nhood_sfd_pct_d AND f_add_input_nhood_sfd_pct_d <= 0.85144393495 => 0.0036734732,
    f_add_input_nhood_sfd_pct_d > 0.85144393495                                         => 0.0239437124,
    f_add_input_nhood_sfd_pct_d = NULL                                                  => 0.0104235823,
                                                                                           0.0104235823);

final_score_328_c1184 := map(
    NULL < f_srchvelocityrisktype_i AND f_srchvelocityrisktype_i <= 2.5 => final_score_328_c1185,
    f_srchvelocityrisktype_i > 2.5                                      => 0.0004658005,
    f_srchvelocityrisktype_i = NULL                                     => 0.0037190168,
                                                                           0.0037190168);

final_score_328 := map(
    NULL < k_inq_adls_per_addr_i AND k_inq_adls_per_addr_i <= 1.5 => -0.0016268858,
    k_inq_adls_per_addr_i > 1.5                                   => final_score_328_c1184,
    k_inq_adls_per_addr_i = NULL                                  => -0.0002505251,
                                                                     -0.0002505251);

final_score_329_c1188 := map(
    NULL < f_prevaddrmurderindex_i AND f_prevaddrmurderindex_i <= 172.5 => -0.0027838148,
    f_prevaddrmurderindex_i > 172.5                                     => -0.0140932609,
    f_prevaddrmurderindex_i = NULL                                      => -0.0055738281,
                                                                           -0.0055738281);

final_score_329_c1187 := map(
    NULL < f_rel_homeover150_count_d AND f_rel_homeover150_count_d <= 16.5 => final_score_329_c1188,
    f_rel_homeover150_count_d > 16.5                                       => 0.0148206076,
    f_rel_homeover150_count_d = NULL                                       => -0.0045799067,
                                                                              -0.0045799067);

final_score_329 := map(
    NULL < r_c20_email_domain_free_count_i AND r_c20_email_domain_free_count_i <= 1.5 => 0.0010730652,
    r_c20_email_domain_free_count_i > 1.5                                             => final_score_329_c1187,
    r_c20_email_domain_free_count_i = NULL                                            => -0.0032864143,
                                                                                         -0.0003452186);

final_score_330_c1191 := map(
    NULL < r_a49_curr_avm_chg_1yr_i AND r_a49_curr_avm_chg_1yr_i <= 14227 => -0.0122600117,
    r_a49_curr_avm_chg_1yr_i > 14227                                      => 0.0328818572,
    r_a49_curr_avm_chg_1yr_i = NULL                                       => -0.0019577013,
                                                                             -0.0011413213);

final_score_330_c1190 := map(
    NULL < f_add_input_nhood_bus_pct_i AND f_add_input_nhood_bus_pct_i <= 0.03881182645 => final_score_330_c1191,
    f_add_input_nhood_bus_pct_i > 0.03881182645                                         => 0.0092515391,
    f_add_input_nhood_bus_pct_i = NULL                                                  => -0.0135366241,
                                                                                           0.0036046893);

final_score_330 := map(
    NULL < (real)k_nap_nothing_found_i AND (real)k_nap_nothing_found_i <= 0.5 => -0.0021759667,
    (real)k_nap_nothing_found_i > 0.5                                   => final_score_330_c1190,
    (real)k_nap_nothing_found_i = NULL                                  => -0.0010220980,
                                                                     -0.0010220980);

final_score_331_c1194 := map(
    NULL < f_rel_homeover300_count_d AND f_rel_homeover300_count_d <= 1.5 => 0.0198723768,
    f_rel_homeover300_count_d > 1.5                                       => -0.0284061940,
    f_rel_homeover300_count_d = NULL                                      => 0.0007218770,
                                                                             0.0007218770);

final_score_331_c1193 := map(
    NULL < f_add_input_mobility_index_i AND f_add_input_mobility_index_i <= 0.2625133195 => 0.0278407100,
    f_add_input_mobility_index_i > 0.2625133195                                          => final_score_331_c1194,
    f_add_input_mobility_index_i = NULL                                                  => 0.0129431932,
                                                                                            0.0129431932);

final_score_331 := map(
    NULL < r_l75_add_drop_delivery_i AND r_l75_add_drop_delivery_i <= 0.5 => -0.0003289934,
    r_l75_add_drop_delivery_i > 0.5                                       => final_score_331_c1193,
    r_l75_add_drop_delivery_i = NULL                                      => 0.0000000109,
                                                                             0.0000000109);

final_score_332_c1197 := map(
    NULL < f_prevaddrlenofres_d AND f_prevaddrlenofres_d <= 36.5 => -0.0030404090,
    f_prevaddrlenofres_d > 36.5                                  => 0.0388505988,
    f_prevaddrlenofres_d = NULL                                  => 0.0179927330,
                                                                    0.0179927330);

final_score_332_c1196 := map(
    NULL < f_phones_per_addr_curr_i AND f_phones_per_addr_curr_i <= 69.5 => -0.0006007431,
    f_phones_per_addr_curr_i > 69.5                                      => final_score_332_c1197,
    f_phones_per_addr_curr_i = NULL                                      => -0.0004163514,
                                                                            -0.0004163514);

final_score_332 := map(
    NULL < r_l79_adls_per_addr_curr_i AND r_l79_adls_per_addr_curr_i <= 25.5 => final_score_332_c1196,
    r_l79_adls_per_addr_curr_i > 25.5                                        => -0.0285559252,
    r_l79_adls_per_addr_curr_i = NULL                                        => -0.0088436066,
                                                                                -0.0006542166);

final_score_333_c1200 := map(
    NULL < r_i60_inq_auto_recency_d AND r_i60_inq_auto_recency_d <= 18 => -0.0119157363,
    r_i60_inq_auto_recency_d > 18                                      => 0.0006747226,
    r_i60_inq_auto_recency_d = NULL                                    => 0.0002701719,
                                                                          0.0002701719);

final_score_333_c1199 := map(
    NULL < f_current_count_d AND f_current_count_d <= 10.5 => final_score_333_c1200,
    f_current_count_d > 10.5                               => -0.0417643648,
    f_current_count_d = NULL                               => 0.0000815822,
                                                              0.0000815822);

final_score_333 := map(
    NULL < f_hh_prof_license_holders_d AND f_hh_prof_license_holders_d <= 1.5 => final_score_333_c1199,
    f_hh_prof_license_holders_d > 1.5                                         => -0.0364478131,
    f_hh_prof_license_holders_d = NULL                                        => -0.0083758785,
                                                                                 -0.0002278670);

final_score_334_c1202 := map(
    NULL < r_i60_inq_auto_count12_i AND r_i60_inq_auto_count12_i <= 1.5 => 0.0007284456,
    r_i60_inq_auto_count12_i > 1.5                                      => -0.0186868583,
    r_i60_inq_auto_count12_i = NULL                                     => 0.0004020061,
                                                                           0.0004020061);

final_score_334_c1203 := map(
    NULL < f_add_input_nhood_bus_pct_i AND f_add_input_nhood_bus_pct_i <= 0.12864949135 => -0.0173897932,
    f_add_input_nhood_bus_pct_i > 0.12864949135                                         => 0.0175908258,
    f_add_input_nhood_bus_pct_i = NULL                                                  => -0.0117988315,
                                                                                           -0.0117988315);

final_score_334 := map(
    NULL < f_inq_highriskcredit_count24_i AND f_inq_highriskcredit_count24_i <= 4.5 => final_score_334_c1202,
    f_inq_highriskcredit_count24_i > 4.5                                            => final_score_334_c1203,
    f_inq_highriskcredit_count24_i = NULL                                           => -0.0040051745,
                                                                                       -0.0000146454);

final_score_335_c1206 := map(
    NULL < r_i60_inq_retpymt_recency_d AND r_i60_inq_retpymt_recency_d <= 549 => -0.0157326534,
    r_i60_inq_retpymt_recency_d > 549                                         => 0.0155011226,
    r_i60_inq_retpymt_recency_d = NULL                                        => 0.0122476043,
                                                                                 0.0122476043);

final_score_335_c1205 := map(
    NULL < f_m_bureau_adl_fs_all_d AND f_m_bureau_adl_fs_all_d <= 113.5 => final_score_335_c1206,
    f_m_bureau_adl_fs_all_d > 113.5                                     => 0.0011658124,
    f_m_bureau_adl_fs_all_d = NULL                                      => 0.0033228522,
                                                                           0.0033228522);

final_score_335 := map(
    NULL < f_inq_other_count24_i AND f_inq_other_count24_i <= 0.5 => -0.0014115624,
    f_inq_other_count24_i > 0.5                                   => final_score_335_c1205,
    f_inq_other_count24_i = NULL                                  => -0.0068757454,
                                                                     0.0001853406);

final_score_336_c1209 := map(
    NULL < r_a46_curr_avm_autoval_d AND r_a46_curr_avm_autoval_d <= 13939.5 => 0.0290079643,
    r_a46_curr_avm_autoval_d > 13939.5                                      => 0.0039444378,
    r_a46_curr_avm_autoval_d = NULL                                         => 0.0020859967,
                                                                               0.0031553789);

final_score_336_c1208 := map(
    NULL < f_addrs_per_ssn_i AND f_addrs_per_ssn_i <= 6.5 => -0.0033985529,
    f_addrs_per_ssn_i > 6.5                               => final_score_336_c1209,
    f_addrs_per_ssn_i = NULL                              => 0.0013904822,
                                                             0.0013904822);

final_score_336 := map(
    NULL < f_rel_ageover30_count_d AND f_rel_ageover30_count_d <= 31.5 => final_score_336_c1208,
    f_rel_ageover30_count_d > 31.5                                     => -0.0210251008,
    f_rel_ageover30_count_d = NULL                                     => -0.0008350111,
                                                                          0.0008909311);

final_score_337_c1212 := map(
    NULL < k_comb_age_d AND k_comb_age_d <= 72.5 => -0.0009177991,
    k_comb_age_d > 72.5                          => 0.0158290281,
    k_comb_age_d = NULL                          => -0.0001476601,
                                                    -0.0001476601);

final_score_337_c1211 := map(
    NULL < f_inq_communications_cnt_week_i AND f_inq_communications_cnt_week_i <= 2.5 => final_score_337_c1212,
    f_inq_communications_cnt_week_i > 2.5                                             => -0.0226516713,
    f_inq_communications_cnt_week_i = NULL                                            => 0.0021061872,
                                                                                         -0.0005870654);

final_score_337 := map(
    NULL < r_a49_curr_avm_chg_1yr_i AND r_a49_curr_avm_chg_1yr_i <= 15244.5 => 0.0047156956,
    r_a49_curr_avm_chg_1yr_i > 15244.5                                      => -0.0038863551,
    r_a49_curr_avm_chg_1yr_i = NULL                                         => final_score_337_c1211,
                                                                               0.0001547268);

final_score_338_c1214 := map(
    NULL < f_curraddrcartheftindex_i AND f_curraddrcartheftindex_i <= 40 => -0.0025490347,
    f_curraddrcartheftindex_i > 40                                       => 0.0091687078,
    f_curraddrcartheftindex_i = NULL                                     => 0.0037941855,
                                                                            0.0037941855);

final_score_338_c1215 := map(
    NULL < f_add_input_nhood_mfd_pct_i AND f_add_input_nhood_mfd_pct_i <= 0.8560399552 => -0.0016866877,
    f_add_input_nhood_mfd_pct_i > 0.8560399552                                         => -0.0131139956,
    f_add_input_nhood_mfd_pct_i = NULL                                                 => 0.0030021265,
                                                                                          -0.0019243556);

final_score_338 := map(
    NULL < f_curraddrburglaryindex_i AND f_curraddrburglaryindex_i <= 72 => final_score_338_c1214,
    f_curraddrburglaryindex_i > 72                                       => final_score_338_c1215,
    f_curraddrburglaryindex_i = NULL                                     => -0.0002332281,
                                                                            -0.0005003879);

final_score_339_c1218 := map(
    NULL < f_add_curr_mobility_index_i AND f_add_curr_mobility_index_i <= 0.36376398825 => 0.0149858927,
    f_add_curr_mobility_index_i > 0.36376398825                                         => -0.0173189160,
    f_add_curr_mobility_index_i = NULL                                                  => 0.0094535708,
                                                                                           0.0094535708);

final_score_339_c1217 := map(
    NULL < r_a46_curr_avm_autoval_d AND r_a46_curr_avm_autoval_d <= 126052.5 => -0.0050894297,
    r_a46_curr_avm_autoval_d > 126052.5                                      => final_score_339_c1218,
    r_a46_curr_avm_autoval_d = NULL                                          => -0.0075202474,
                                                                                -0.0049883514);

final_score_339 := map(
    NULL < r_c20_email_domain_free_count_i AND r_c20_email_domain_free_count_i <= 1.5 => 0.0004354431,
    r_c20_email_domain_free_count_i > 1.5                                             => final_score_339_c1217,
    r_c20_email_domain_free_count_i = NULL                                            => 0.0029252952,
                                                                                         -0.0008406396);

final_score_340_c1221 := map(
    NULL < k_comb_age_d AND k_comb_age_d <= 56.5 => 0.0010344621,
    k_comb_age_d > 56.5                          => -0.0068468014,
    k_comb_age_d = NULL                          => -0.0004590668,
                                                    -0.0004590668);

final_score_340_c1220 := map(
    NULL < k_comb_age_d AND k_comb_age_d <= 73.5 => final_score_340_c1221,
    k_comb_age_d > 73.5                          => 0.0124399123,
    k_comb_age_d = NULL                          => 0.0001147023,
                                                    0.0001147023);

final_score_340 := map(
    NULL < r_c14_addrs_per_adl_c6_i AND r_c14_addrs_per_adl_c6_i <= 1.5 => final_score_340_c1220,
    r_c14_addrs_per_adl_c6_i > 1.5                                      => -0.0187506458,
    r_c14_addrs_per_adl_c6_i = NULL                                     => 0.0068735900,
                                                                           -0.0001066567);

final_score := final_score_0 +
    final_score_1 +
    final_score_2 +
    final_score_3 +
    final_score_4 +
    final_score_5 +
    final_score_6 +
    final_score_7 +
    final_score_8 +
    final_score_9 +
    final_score_10 +
    final_score_11 +
    final_score_12 +
    final_score_13 +
    final_score_14 +
    final_score_15 +
    final_score_16 +
    final_score_17 +
    final_score_18 +
    final_score_19 +
    final_score_20 +
    final_score_21 +
    final_score_22 +
    final_score_23 +
    final_score_24 +
    final_score_25 +
    final_score_26 +
    final_score_27 +
    final_score_28 +
    final_score_29 +
    final_score_30 +
    final_score_31 +
    final_score_32 +
    final_score_33 +
    final_score_34 +
    final_score_35 +
    final_score_36 +
    final_score_37 +
    final_score_38 +
    final_score_39 +
    final_score_40 +
    final_score_41 +
    final_score_42 +
    final_score_43 +
    final_score_44 +
    final_score_45 +
    final_score_46 +
    final_score_47 +
    final_score_48 +
    final_score_49 +
    final_score_50 +
    final_score_51 +
    final_score_52 +
    final_score_53 +
    final_score_54 +
    final_score_55 +
    final_score_56 +
    final_score_57 +
    final_score_58 +
    final_score_59 +
    final_score_60 +
    final_score_61 +
    final_score_62 +
    final_score_63 +
    final_score_64 +
    final_score_65 +
    final_score_66 +
    final_score_67 +
    final_score_68 +
    final_score_69 +
    final_score_70 +
    final_score_71 +
    final_score_72 +
    final_score_73 +
    final_score_74 +
    final_score_75 +
    final_score_76 +
    final_score_77 +
    final_score_78 +
    final_score_79 +
    final_score_80 +
    final_score_81 +
    final_score_82 +
    final_score_83 +
    final_score_84 +
    final_score_85 +
    final_score_86 +
    final_score_87 +
    final_score_88 +
    final_score_89 +
    final_score_90 +
    final_score_91 +
    final_score_92 +
    final_score_93 +
    final_score_94 +
    final_score_95 +
    final_score_96 +
    final_score_97 +
    final_score_98 +
    final_score_99 +
    final_score_100 +
    final_score_101 +
    final_score_102 +
    final_score_103 +
    final_score_104 +
    final_score_105 +
    final_score_106 +
    final_score_107 +
    final_score_108 +
    final_score_109 +
    final_score_110 +
    final_score_111 +
    final_score_112 +
    final_score_113 +
    final_score_114 +
    final_score_115 +
    final_score_116 +
    final_score_117 +
    final_score_118 +
    final_score_119 +
    final_score_120 +
    final_score_121 +
    final_score_122 +
    final_score_123 +
    final_score_124 +
    final_score_125 +
    final_score_126 +
    final_score_127 +
    final_score_128 +
    final_score_129 +
    final_score_130 +
    final_score_131 +
    final_score_132 +
    final_score_133 +
    final_score_134 +
    final_score_135 +
    final_score_136 +
    final_score_137 +
    final_score_138 +
    final_score_139 +
    final_score_140 +
    final_score_141 +
    final_score_142 +
    final_score_143 +
    final_score_144 +
    final_score_145 +
    final_score_146 +
    final_score_147 +
    final_score_148 +
    final_score_149 +
    final_score_150 +
    final_score_151 +
    final_score_152 +
    final_score_153 +
    final_score_154 +
    final_score_155 +
    final_score_156 +
    final_score_157 +
    final_score_158 +
    final_score_159 +
    final_score_160 +
    final_score_161 +
    final_score_162 +
    final_score_163 +
    final_score_164 +
    final_score_165 +
    final_score_166 +
    final_score_167 +
    final_score_168 +
    final_score_169 +
    final_score_170 +
    final_score_171 +
    final_score_172 +
    final_score_173 +
    final_score_174 +
    final_score_175 +
    final_score_176 +
    final_score_177 +
    final_score_178 +
    final_score_179 +
    final_score_180 +
    final_score_181 +
    final_score_182 +
    final_score_183 +
    final_score_184 +
    final_score_185 +
    final_score_186 +
    final_score_187 +
    final_score_188 +
    final_score_189 +
    final_score_190 +
    final_score_191 +
    final_score_192 +
    final_score_193 +
    final_score_194 +
    final_score_195 +
    final_score_196 +
    final_score_197 +
    final_score_198 +
    final_score_199 +
    final_score_200 +
    final_score_201 +
    final_score_202 +
    final_score_203 +
    final_score_204 +
    final_score_205 +
    final_score_206 +
    final_score_207 +
    final_score_208 +
    final_score_209 +
    final_score_210 +
    final_score_211 +
    final_score_212 +
    final_score_213 +
    final_score_214 +
    final_score_215 +
    final_score_216 +
    final_score_217 +
    final_score_218 +
    final_score_219 +
    final_score_220 +
    final_score_221 +
    final_score_222 +
    final_score_223 +
    final_score_224 +
    final_score_225 +
    final_score_226 +
    final_score_227 +
    final_score_228 +
    final_score_229 +
    final_score_230 +
    final_score_231 +
    final_score_232 +
    final_score_233 +
    final_score_234 +
    final_score_235 +
    final_score_236 +
    final_score_237 +
    final_score_238 +
    final_score_239 +
    final_score_240 +
    final_score_241 +
    final_score_242 +
    final_score_243 +
    final_score_244 +
    final_score_245 +
    final_score_246 +
    final_score_247 +
    final_score_248 +
    final_score_249 +
    final_score_250 +
    final_score_251 +
    final_score_252 +
    final_score_253 +
    final_score_254 +
    final_score_255 +
    final_score_256 +
    final_score_257 +
    final_score_258 +
    final_score_259 +
    final_score_260 +
    final_score_261 +
    final_score_262 +
    final_score_263 +
    final_score_264 +
    final_score_265 +
    final_score_266 +
    final_score_267 +
    final_score_268 +
    final_score_269 +
    final_score_270 +
    final_score_271 +
    final_score_272 +
    final_score_273 +
    final_score_274 +
    final_score_275 +
    final_score_276 +
    final_score_277 +
    final_score_278 +
    final_score_279 +
    final_score_280 +
    final_score_281 +
    final_score_282 +
    final_score_283 +
    final_score_284 +
    final_score_285 +
    final_score_286 +
    final_score_287 +
    final_score_288 +
    final_score_289 +
    final_score_290 +
    final_score_291 +
    final_score_292 +
    final_score_293 +
    final_score_294 +
    final_score_295 +
    final_score_296 +
    final_score_297 +
    final_score_298 +
    final_score_299 +
    final_score_300 +
    final_score_301 +
    final_score_302 +
    final_score_303 +
    final_score_304 +
    final_score_305 +
    final_score_306 +
    final_score_307 +
    final_score_308 +
    final_score_309 +
    final_score_310 +
    final_score_311 +
    final_score_312 +
    final_score_313 +
    final_score_314 +
    final_score_315 +
    final_score_316 +
    final_score_317 +
    final_score_318 +
    final_score_319 +
    final_score_320 +
    final_score_321 +
    final_score_322 +
    final_score_323 +
    final_score_324 +
    final_score_325 +
    final_score_326 +
    final_score_327 +
    final_score_328 +
    final_score_329 +
    final_score_330 +
    final_score_331 +
    final_score_332 +
    final_score_333 +
    final_score_334 +
    final_score_335 +
    final_score_336 +
    final_score_337 +
    final_score_338 +
    final_score_339 +
    final_score_340;

pbr := 0.2765;

sbr := 0.2753;

offset := ln(((1 - pbr) * sbr) / (pbr * (1 - sbr)));

base := 700;

pts := -55;

lgt := ln(0.2765 / 0.7235);

fp1607_1_0 := round(max((real)300, min(999, if(base + pts * (final_score - offset - lgt) / ln(2) = NULL, -NULL, base + pts * (final_score - offset - lgt) / ln(2)))));

cust_stolid_index := 1;

cust_synthid_index := 1;

cust_manipid_index := 1;

cust_vulnvic_index := 1;

cust_friendfrd_index := 1;

cust_suspact_index := 1;


																																	 
//*************************************************************************************//
//     End Generated ECL Code
//*************************************************************************************//

	#if(FP_DEBUG)
		/* Model Input Variables */
                                        self.sysdate                          := sysdate;
                    self._acc_last_seen                   := _acc_last_seen;
                    self.f_mos_acc_lseen_d                := f_mos_acc_lseen_d;
                    self.f_curraddractivephonelist_d      := f_curraddractivephonelist_d;
                    self.f_inputaddractivephonelist_d     := f_inputaddractivephonelist_d;
                    self.r_f03_address_match_d            := r_f03_address_match_d;
                    self.r_l72_add_curr_vacant_i          := r_l72_add_curr_vacant_i;
                    self.r_l72_add_vacant_i               := r_l72_add_vacant_i;
                    self.r_l75_add_curr_drop_delivery_i   := r_l75_add_curr_drop_delivery_i;
                    self.r_l75_add_drop_delivery_i        := r_l75_add_drop_delivery_i;
                    self.r_c23_inp_addr_occ_index_d       := r_c23_inp_addr_occ_index_d;
                    self.r_f04_curr_add_occ_index_d       := r_f04_curr_add_occ_index_d;
                    self.r_c14_addr_stability_v2_d        := r_c14_addr_stability_v2_d;
                    self.r_c14_addrs_10yr_i               := r_c14_addrs_10yr_i;
                    self.r_c14_addrs_15yr_i               := r_c14_addrs_15yr_i;
                    self.r_c14_addrs_5yr_i                := r_c14_addrs_5yr_i;
                    self.r_c14_addrs_per_adl_c6_i         := r_c14_addrs_per_adl_c6_i;
                    self.add_ec1                          := add_ec1;
                    self.add_ec3                          := add_ec3;
                    self.add_ec4                          := add_ec4;
                    self.r_l70_add_standardized_i         := r_l70_add_standardized_i;
                    self._in_dob                          := _in_dob;
                    self.yr_in_dob                        := yr_in_dob;
                    self.yr_in_dob_int                    := yr_in_dob_int;
                    self.k_comb_age_d                     := k_comb_age_d;
                    self.r_d31_bk_filing_count_i          := r_d31_bk_filing_count_i;
                    self.f_attr_arrest_recency_d          := f_attr_arrest_recency_d;
                    self.f_attr_arrests_i                 := f_attr_arrests_i;
                    self.r_c19_add_prison_hist_i          := r_c19_add_prison_hist_i;
                    self.r_d32_criminal_count_i           := r_d32_criminal_count_i;
                    self.r_d32_felony_count_i             := r_d32_felony_count_i;
                    self._criminal_last_date              := _criminal_last_date;
                    self.r_d32_mos_since_crim_ls_d        := r_d32_mos_since_crim_ls_d;
                    self._felony_last_date                := _felony_last_date;
                    self.r_d32_mos_since_fel_ls_d         := r_d32_mos_since_fel_ls_d;
                    self.r_d30_derog_count_i              := r_d30_derog_count_i;
                    self.f_vardobcount_i                  := f_vardobcount_i;
                    self.f_vardobcountnew_i               := f_vardobcountnew_i;
                    self.f_addrchangeecontrajindex_d      := f_addrchangeecontrajindex_d;
                    self.r_c20_email_count_i              := r_c20_email_count_i;
                    self.r_c20_email_domain_free_count_i  := r_c20_email_domain_free_count_i;
                    self.r_c20_email_domain_isp_count_i   := r_c20_email_domain_isp_count_i;
                    self.k_estimated_income_d             := k_estimated_income_d;
                    self.r_d33_eviction_count_i           := r_d33_eviction_count_i;
                    self.r_d33_eviction_recency_d         := r_d33_eviction_recency_d;
                    self._foreclosure_last_date           := _foreclosure_last_date;
                    self.f_mos_foreclosure_lseen_d        := f_mos_foreclosure_lseen_d;
                    self.f_idverrisktype_i                := f_idverrisktype_i;
                    self._ver_src_ds                      := _ver_src_ds;
                    self._ver_src_de                      := _ver_src_de;
                    self._ver_src_eq                      := _ver_src_eq;
                    self._ver_src_en                      := _ver_src_en;
                    self._ver_src_tn                      := _ver_src_tn;
                    self._ver_src_tu                      := _ver_src_tu;
                    self._credit_source_cnt               := _credit_source_cnt;
                    self._ver_src_cnt                     := _ver_src_cnt;
                    self._bureauonly                      := _bureauonly;
                    self._derog                           := _derog;
                    self._deceased                        := _deceased;
                    self._ssnpriortodob                   := _ssnpriortodob;
                    self._inputmiskeys                    := _inputmiskeys;
                    self._multiplessns                    := _multiplessns;
                    self._hh_strikes                      := _hh_strikes;
                    self.nf_seg_fraudpoint_3_0            := nf_seg_fraudpoint_3_0;
                    self.f_varrisktype_i                  := f_varrisktype_i;
                    self.f_hh_age_18_plus_d               := f_hh_age_18_plus_d;
                    self.f_hh_age_65_plus_d               := f_hh_age_65_plus_d;
                    self.f_hh_age_30_plus_d               := f_hh_age_30_plus_d;
                    self.f_hh_bankruptcies_i              := f_hh_bankruptcies_i;
                    self.f_hh_college_attendees_d         := f_hh_college_attendees_d;
                    self.f_hh_members_ct_d                := f_hh_members_ct_d;
                    self.f_hh_members_w_derog_i           := f_hh_members_w_derog_i;
                    self.f_hh_payday_loan_users_i         := f_hh_payday_loan_users_i;
                    self.f_hh_prof_license_holders_d      := f_hh_prof_license_holders_d;
                    self.f_hh_workers_paw_d               := f_hh_workers_paw_d;
                    self.f_adl_util_conv_n                := f_adl_util_conv_n;
                    self.f_util_add_curr_conv_n           := f_util_add_curr_conv_n;
                    self.f_util_add_curr_inf_n            := f_util_add_curr_inf_n;
                    self.f_util_add_input_conv_n          := f_util_add_input_conv_n;
                    self.f_util_add_input_inf_n           := f_util_add_input_inf_n;
                    self.f_util_adl_count_n               := f_util_adl_count_n;
                    self.f_bus_name_nover_i               := f_bus_name_nover_i;
                    self.r_e57_br_source_count_d          := r_e57_br_source_count_d;
                    self.r_l71_add_business_i             := r_l71_add_business_i;
                    self.f_addrs_per_ssn_i                := f_addrs_per_ssn_i;
                    self.f_srchaddrsrchcountmo_i          := f_srchaddrsrchcountmo_i;
                    self.f_srchaddrsrchcountwk_i          := f_srchaddrsrchcountwk_i;
                    self.f_srchcomponentrisktype_i        := f_srchcomponentrisktype_i;
                    self.f_srchcountwk_i                  := f_srchcountwk_i;
                    self.f_srchfraudsrchcountwk_i         := f_srchfraudsrchcountwk_i;
                    self.f_srchfraudsrchcountyr_i         := f_srchfraudsrchcountyr_i;
                    self.f_srchlocatesrchcountwk_i        := f_srchlocatesrchcountwk_i;
                    self.f_srchunvrfdaddrcount_i          := f_srchunvrfdaddrcount_i;
                    self.f_srchunvrfdssncount_i           := f_srchunvrfdssncount_i;
                    self.f_srchvelocityrisktype_i         := f_srchvelocityrisktype_i;
                    self.k_inq_adls_per_addr_i            := k_inq_adls_per_addr_i;
                    self.k_inq_lnames_per_addr_i          := k_inq_lnames_per_addr_i;
                    self.k_inq_per_addr_i                 := k_inq_per_addr_i;
                    self.k_inq_ssns_per_addr_i            := k_inq_ssns_per_addr_i;
                    self.r_l79_adls_per_addr_c6_i         := r_l79_adls_per_addr_c6_i;
                    self.r_l79_adls_per_addr_curr_i       := r_l79_adls_per_addr_curr_i;
                    self.f_inq_collection_count24_i       := f_inq_collection_count24_i;
                    self.f_inq_communications_cnt_week_i  := f_inq_communications_cnt_week_i;
                    self.f_inq_communications_count24_i   := f_inq_communications_count24_i;
                    self.f_inq_count24_i                  := f_inq_count24_i;
                    self.f_inq_highriskcredit_count24_i   := f_inq_highriskcredit_count24_i;
                    self.f_inq_other_count24_i            := f_inq_other_count24_i;
                    self.r_i60_credit_seeking_i           := r_i60_credit_seeking_i;
                    self.r_i60_inq_auto_count12_i         := r_i60_inq_auto_count12_i;
                    self.r_i60_inq_auto_recency_d         := r_i60_inq_auto_recency_d;
                    self.r_i60_inq_banking_count12_i      := r_i60_inq_banking_count12_i;
                    self.r_i60_inq_banking_recency_d      := r_i60_inq_banking_recency_d;
                    self.r_i60_inq_comm_count12_i         := r_i60_inq_comm_count12_i;
                    self.r_i60_inq_comm_recency_d         := r_i60_inq_comm_recency_d;
                    self.r_i60_inq_count12_i              := r_i60_inq_count12_i;
                    self.r_i60_inq_recency_d              := r_i60_inq_recency_d;
                    self.r_i61_inq_collection_recency_d   := r_i61_inq_collection_recency_d;
                    self.r_i60_inq_hiriskcred_recency_d   := r_i60_inq_hiriskcred_recency_d;
                    self.r_i60_inq_prepaidcards_recency_d := r_i60_inq_prepaidcards_recency_d;
                    self.r_i60_inq_retpymt_recency_d      := r_i60_inq_retpymt_recency_d;
                    self.r_i60_inq_util_count12_i         := r_i60_inq_util_count12_i;
                    self.r_i60_inq_util_recency_d         := r_i60_inq_util_recency_d;
                    self.r_c16_inv_ssn_per_adl_i          := r_c16_inv_ssn_per_adl_i;
                    self.r_c18_invalid_addrs_per_adl_i    := r_c18_invalid_addrs_per_adl_i;
                    self.f_prevaddrlenofres_d             := f_prevaddrlenofres_d;
                    self.r_c13_curr_addr_lres_d           := r_c13_curr_addr_lres_d;
                    self.r_c13_max_lres_d                 := r_c13_max_lres_d;
                    self.f_liens_rel_cj_total_amt_i       := f_liens_rel_cj_total_amt_i;
                    self.f_liens_unrel_cj_total_amt_i     := f_liens_unrel_cj_total_amt_i;
                    self.f_liens_unrel_ft_total_amt_i     := f_liens_unrel_ft_total_amt_i;
                    self.f_liens_unrel_o_total_amt_i      := f_liens_unrel_o_total_amt_i;
                    self.f_liens_unrel_ot_total_amt_i     := f_liens_unrel_ot_total_amt_i;
                    self.f_liens_unrel_sc_total_amt_i     := f_liens_unrel_sc_total_amt_i;
                    self.f_liens_unrel_st_ct_i            := f_liens_unrel_st_ct_i;
                    self.f_liens_unrel_st_total_amt_i     := f_liens_unrel_st_total_amt_i;
                    self._liens_rel_cj_first_seen         := _liens_rel_cj_first_seen;
                    self.f_mos_liens_rel_cj_fseen_d       := f_mos_liens_rel_cj_fseen_d;
                    self._liens_rel_cj_last_seen          := _liens_rel_cj_last_seen;
                    self.f_mos_liens_rel_cj_lseen_d       := f_mos_liens_rel_cj_lseen_d;
                    self._liens_rel_o_last_seen           := _liens_rel_o_last_seen;
                    self.f_mos_liens_rel_o_lseen_d        := f_mos_liens_rel_o_lseen_d;
                    self._liens_unrel_cj_last_seen        := _liens_unrel_cj_last_seen;
                    self.f_mos_liens_unrel_cj_lseen_d     := f_mos_liens_unrel_cj_lseen_d;
                    self._liens_unrel_ot_first_seen       := _liens_unrel_ot_first_seen;
                    self.f_mos_liens_unrel_ot_fseen_d     := f_mos_liens_unrel_ot_fseen_d;
                    self._liens_unrel_sc_first_seen       := _liens_unrel_sc_first_seen;
                    self.f_mos_liens_unrel_sc_fseen_d     := f_mos_liens_unrel_sc_fseen_d;
                    self._liens_unrel_st_last_seen        := _liens_unrel_st_last_seen;
                    self.f_mos_liens_unrel_st_lseen_d     := f_mos_liens_unrel_st_lseen_d;
                    self.r_d34_unrel_liens_ct_i           := r_d34_unrel_liens_ct_i;
                    self.k_nap_lname_verd_d               := k_nap_lname_verd_d;
                    self.k_nap_nothing_found_i            := k_nap_nothing_found_i;
                    self.r_f01_inp_addr_address_score_d   := r_f01_inp_addr_address_score_d;
                    self.r_f01_inp_addr_not_verified_i    := r_f01_inp_addr_not_verified_i;
                    self.f_add_curr_mobility_index_i      := f_add_curr_mobility_index_i;
                    self.f_add_input_mobility_index_i     := f_add_input_mobility_index_i;
                    self.f_addrchangecrimediff_i          := f_addrchangecrimediff_i;
                    self.f_curraddrburglaryindex_i        := f_curraddrburglaryindex_i;
                    self.f_curraddrcrimeindex_i           := f_curraddrcrimeindex_i;
                    self.f_curraddrmurderindex_i          := f_curraddrmurderindex_i;
                    self.f_curraddrcartheftindex_i        := f_curraddrcartheftindex_i;
                    self.f_fp_prevaddrburglaryindex_i     := f_fp_prevaddrburglaryindex_i;
                    self.f_fp_prevaddrcrimeindex_i        := f_fp_prevaddrcrimeindex_i;
                    self.f_prevaddrmurderindex_i          := f_prevaddrmurderindex_i;
                    self.f_prevaddrcartheftindex_i        := f_prevaddrcartheftindex_i;
                    self.f_add_curr_has_vac_ct_i          := f_add_curr_has_vac_ct_i;
                    self.f_add_curr_nhood_vac_pct_i       := f_add_curr_nhood_vac_pct_i;
                    self.f_add_curr_nhood_sfd_pct_d       := f_add_curr_nhood_sfd_pct_d;
                    self.f_add_curr_nhood_mfd_pct_i       := f_add_curr_nhood_mfd_pct_i;
                    self.add_curr_nhood_prop_sum          := add_curr_nhood_prop_sum;
                    self.f_add_curr_nhood_bus_pct_i       := f_add_curr_nhood_bus_pct_i;
                    self.f_add_input_has_sfd_ct_d         := f_add_input_has_sfd_ct_d;
                    self.f_add_input_nhood_sfd_pct_d      := f_add_input_nhood_sfd_pct_d;
                    self.f_add_input_has_vac_ct_i         := f_add_input_has_vac_ct_i;
                    self.f_add_input_nhood_vac_pct_i      := f_add_input_nhood_vac_pct_i;
                    self.f_add_input_nhood_mfd_pct_i      := f_add_input_nhood_mfd_pct_i;
                    self.add_input_nhood_prop_sum         := add_input_nhood_prop_sum;
                    self.f_add_input_nhood_bus_pct_i      := f_add_input_nhood_bus_pct_i;
                    self.f_addrchangeincomediff_d         := f_addrchangeincomediff_d;
                    self.f_curraddrmedianincome_d         := f_curraddrmedianincome_d;
                    self.f_prevaddrmedianincome_d         := f_prevaddrmedianincome_d;
                    self.f_addrchangevaluediff_d          := f_addrchangevaluediff_d;
                    self.f_curraddrmedianvalue_d          := f_curraddrmedianvalue_d;
                    self.f_prevaddrmedianvalue_d          := f_prevaddrmedianvalue_d;
                    self.f_dl_addrs_per_adl_i             := f_dl_addrs_per_adl_i;
                    self.f_divrisktype_i                  := f_divrisktype_i;
                    self.f_phones_per_addr_c6_i           := f_phones_per_addr_c6_i;
                    self.f_phones_per_addr_curr_i         := f_phones_per_addr_curr_i;
                    self.f_sourcerisktype_i               := f_sourcerisktype_i;
                    self.r_a46_curr_avm_autoval_d         := r_a46_curr_avm_autoval_d;
                    self.r_a49_curr_avm_chg_1yr_i         := r_a49_curr_avm_chg_1yr_i;
                    self.r_a49_curr_avm_chg_1yr_pct_i     := r_a49_curr_avm_chg_1yr_pct_i;
                    self.r_l80_inp_avm_autoval_d          := r_l80_inp_avm_autoval_d;
                    self.f_current_count_d                := f_current_count_d;
                    self.f_historical_count_d             := f_historical_count_d;
                    self.f_assoccredbureaucount_i         := f_assoccredbureaucount_i;
                    self.f_assocrisktype_i                := f_assocrisktype_i;
                    self.f_assocsuspicousidcount_i        := f_assocsuspicousidcount_i;
                    self.f_crim_rel_under25miles_cnt_i    := f_crim_rel_under25miles_cnt_i;
                    self.f_crim_rel_under500miles_cnt_i   := f_crim_rel_under500miles_cnt_i;
                    self.f_rel_ageover20_count_d          := f_rel_ageover20_count_d;
                    self.f_rel_ageover30_count_d          := f_rel_ageover30_count_d;
                    self.f_rel_ageover40_count_d          := f_rel_ageover40_count_d;
                    self.f_rel_count_i                    := f_rel_count_i;
                    self.f_rel_educationover8_count_d     := f_rel_educationover8_count_d;
                    self.f_rel_educationover12_count_d    := f_rel_educationover12_count_d;
                    self.f_rel_felony_count_i             := f_rel_felony_count_i;
                    self.f_rel_homeover50_count_d         := f_rel_homeover50_count_d;
                    self.f_rel_homeover100_count_d        := f_rel_homeover100_count_d;
                    self.f_rel_homeover150_count_d        := f_rel_homeover150_count_d;
                    self.f_rel_homeover200_count_d        := f_rel_homeover200_count_d;
                    self.f_rel_homeover300_count_d        := f_rel_homeover300_count_d;
                    self.f_rel_incomeover25_count_d       := f_rel_incomeover25_count_d;
                    self.f_rel_incomeover50_count_d       := f_rel_incomeover50_count_d;
                    self.f_rel_incomeover75_count_d       := f_rel_incomeover75_count_d;
                    self.f_rel_incomeover100_count_d      := f_rel_incomeover100_count_d;
                    self.f_rel_under100miles_cnt_d        := f_rel_under100miles_cnt_d;
                    self.f_rel_under500miles_cnt_d        := f_rel_under500miles_cnt_d;
                    self.f_rel_under25miles_cnt_d         := f_rel_under25miles_cnt_d;
                    self.f_divaddrsuspidcountnew_i        := f_divaddrsuspidcountnew_i;
                    self._src_bureau_adl_fseen_all        := _src_bureau_adl_fseen_all;
                    self.f_m_bureau_adl_fs_all_d          := f_m_bureau_adl_fs_all_d;
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
                    self._src_bureau_adl_fseen_notu       := _src_bureau_adl_fseen_notu;
                    self.f_m_bureau_adl_fs_notu_d         := f_m_bureau_adl_fs_notu_d;
                    self._header_first_seen               := _header_first_seen;
                    self.r_c10_m_hdr_fs_d                 := r_c10_m_hdr_fs_d;
                    self.bureau_adl_eq_fseen_pos          := bureau_adl_eq_fseen_pos;
                    self.bureau_adl_fseen_eq              := bureau_adl_fseen_eq;
                    self._bureau_adl_fseen_eq             := _bureau_adl_fseen_eq;
                    self._src_bureau_adl_fseen            := _src_bureau_adl_fseen;
                    self.r_c21_m_bureau_adl_fs_d          := r_c21_m_bureau_adl_fs_d;
                    self.r_wealth_index_d                 := r_wealth_index_d;
                    self.final_score_0                    := final_score_0;
                    self.final_score_1                    := final_score_1;
                    self.final_score_2                    := final_score_2;
                    self.final_score_3                    := final_score_3;
                    self.final_score_4                    := final_score_4;
                    self.final_score_5                    := final_score_5;
                    self.final_score_6                    := final_score_6;
                    self.final_score_7                    := final_score_7;
                    self.final_score_8                    := final_score_8;
                    self.final_score_9                    := final_score_9;
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
                    self.final_score                      := final_score;
                    self.pbr                              := pbr;
                    self.sbr                              := sbr;
                    self.offset                           := offset;
                    self.base                             := base;
                    self.pts                              := pts;
                    self.lgt                              := lgt;
                    self.fp1607_1_0                       := fp1607_1_0;
                    self.cust_stolid_index                := cust_stolid_index;
                    self.cust_synthid_index               := cust_synthid_index;
                    self.cust_manipid_index               := cust_manipid_index;
                    self.cust_vulnvic_index               := cust_vulnvic_index;
                    self.cust_friendfrd_index             := cust_friendfrd_index;
                    self.cust_suspact_index               := cust_suspact_index;


	 SELF.clam := le;
#end

	self.seq := le.seq;
	self.StolenIdentityIndex := (string) cust_stolid_index;
	self.SyntheticIdentityIndex:= (string) cust_synthid_index;
	self.ManipulatedIdentityIndex:= (string) cust_manipid_index;
	self.VulnerableVictimIndex := (string) cust_vulnvic_index;
	self.FriendlyFraudIndex                := (string) cust_friendfrd_index;
	self.SuspiciousActivityIndex := (string) cust_suspact_index;
	ritmp :=  Models.fraudpoint3_reasons(le, blank_ip, num_reasons, , , nf_seg_fraudpoint_3_0);
	reasons := Models.Common.checkFraudPointRC34(fp1607_1_0, ritmp, num_reasons);
	self.ri := reasons;
	self.score := (string)fp1607_1_0;
	self := [];
	
END;

model :=   project(clam, doModel(left) );
	
	return model;
END;


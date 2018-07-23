import ut, Models, STD;

export PhoneScore_wf8_v3(dataset(Phone_Shell.Layout_Phone_Shell.Phone_Shell_Layout) clam, Unsigned2 Score_Threshold	= Phone_Shell.Constants.Default_PhoneScore) := FUNCTION

  PHONE_DEBUG := FALSE;

  #if(PHONE_DEBUG)
 layout_debug := record
   integer sysdate                          ; // := sysdate;
   integer4 phone_pos_cr                     ; // := phone_pos_cr;
   integer4 phone_pos_edaca                  ; // := phone_pos_edaca;
   integer4 phone_pos_edadid                 ; // := phone_pos_edadid;
   integer4 phone_pos_edafa                  ; // := phone_pos_edafa;
   integer4 phone_pos_edafla                 ; // := phone_pos_edafla;
   integer4 phone_pos_edahistory             ; // := phone_pos_edahistory;
   integer4 phone_pos_edala                  ; // := phone_pos_edala;
   integer4 phone_pos_edalfa                 ; // := phone_pos_edalfa;
   integer4 phone_pos_exp                    ; // := phone_pos_exp;
   integer4 phone_pos_inf                    ; // := phone_pos_inf;
   integer4 phone_pos_input                  ; // := phone_pos_input;
   integer4 phone_pos_md                     ; // := phone_pos_md;
   integer4 phone_pos_ne                     ; // := phone_pos_ne;
   integer4 phone_pos_paw                    ; // := phone_pos_paw;
   integer4 phone_pos_pde                    ; // := phone_pos_pde;
   integer4 phone_pos_pf                     ; // := phone_pos_pf;
   integer4 phone_pos_pffla                  ; // := phone_pos_pffla;
   integer4 phone_pos_pfla                   ; // := phone_pos_pfla;
   integer4 phone_pos_ppca                   ; // := phone_pos_ppca;
   integer4 phone_pos_ppdid                  ; // := phone_pos_ppdid;
   integer4 phone_pos_ppfa                   ; // := phone_pos_ppfa;
   integer4 phone_pos_ppfla                  ; // := phone_pos_ppfla;
   integer4 phone_pos_ppla                   ; // := phone_pos_ppla;
   integer4 phone_pos_pplfa                  ; // := phone_pos_pplfa;
   integer4 phone_pos_ppth                   ; // := phone_pos_ppth;
   integer4 phone_pos_rel                    ; // := phone_pos_rel;
   integer4 phone_pos_rm                     ; // := phone_pos_rm;
   integer4 phone_pos_sp                     ; // := phone_pos_sp;
   integer4 phone_pos_sx                     ; // := phone_pos_sx;
   integer4 phone_pos_utildid                ; // := phone_pos_utildid;
   boolean source_cr                        ; // := source_cr;
   boolean source_edaca                     ; // := source_edaca;
   boolean source_edadid                    ; // := source_edadid;
   boolean source_edafa                     ; // := source_edafa;
   boolean source_edafla                    ; // := source_edafla;
   boolean source_edahistory                ; // := source_edahistory;
   boolean source_edala                     ; // := source_edala;
   boolean source_edalfa                    ; // := source_edalfa;
   boolean source_exp                       ; // := source_exp;
   boolean source_inf                       ; // := source_inf;
   boolean source_input                     ; // := source_input;
   boolean source_md                        ; // := source_md;
   boolean source_ne                        ; // := source_ne;
   boolean source_paw                       ; // := source_paw;
   boolean source_pde                       ; // := source_pde;
   boolean source_pf                        ; // := source_pf;
   boolean source_pffla                     ; // := source_pffla;
   boolean source_pfla                      ; // := source_pfla;
   boolean source_ppca                      ; // := source_ppca;
   boolean source_ppdid                     ; // := source_ppdid;
   boolean source_ppfa                      ; // := source_ppfa;
   boolean source_ppfla                     ; // := source_ppfla;
   boolean source_ppla                      ; // := source_ppla;
   boolean source_pplfa                     ; // := source_pplfa;
   boolean source_ppth                      ; // := source_ppth;
   boolean source_rel                       ; // := source_rel;
   boolean source_rm                        ; // := source_rm;
   boolean source_sp                        ; // := source_sp;
   boolean source_sx                        ; // := source_sx;
   boolean source_utildid                   ; // := source_utildid;
   string source_edaca_lseen               ; // := source_edaca_lseen;
   string source_edaca_fseen               ; // := source_edaca_fseen;
   string source_edahistory_lseen          ; // := source_edahistory_lseen;
   string source_inf_fseen                 ; // := source_inf_fseen;
   string source_md_fseen                  ; // := source_md_fseen;
   string source_paw_lseen                 ; // := source_paw_lseen;
   string source_paw_fseen                 ; // := source_paw_fseen;
   string source_ppca_lseen                ; // := source_ppca_lseen;
   string source_ppca_fseen                ; // := source_ppca_fseen;
   string source_ppdid_lseen               ; // := source_ppdid_lseen;
   string source_ppdid_fseen               ; // := source_ppdid_fseen;
   string source_ppfla_lseen               ; // := source_ppfla_lseen;
   string source_ppfla_fseen               ; // := source_ppfla_fseen;
   string source_ppla_lseen                ; // := source_ppla_lseen;
   string source_ppla_fseen                ; // := source_ppla_fseen;
   string source_ppth_lseen                ; // := source_ppth_lseen;
   string source_ppth_fseen                ; // := source_ppth_fseen;
   string source_rm_fseen                  ; // := source_rm_fseen;
   string source_sx_fseen                  ; // := source_sx_fseen;
   string source_utildid_fseen             ; // := source_utildid_fseen;
   integer source_pp_any_clean              ; // := source_pp_any_clean;
   integer number_of_sources                ; // := number_of_sources;
   integer source_edaca_lseen2              ; // := source_edaca_lseen2;
   integer mth_source_edaca_lseen           ; // := mth_source_edaca_lseen;
   integer source_edaca_fseen2              ; // := source_edaca_fseen2;
   integer mth_source_edaca_fseen           ; // := mth_source_edaca_fseen;
   integer source_edahistory_lseen2         ; // := source_edahistory_lseen2;
   integer mth_source_edahistory_lseen      ; // := mth_source_edahistory_lseen;
   integer source_inf_fseen2                ; // := source_inf_fseen2;
   integer mth_source_inf_fseen             ; // := mth_source_inf_fseen;
   integer source_md_fseen2                 ; // := source_md_fseen2;
   integer mth_source_md_fseen              ; // := mth_source_md_fseen;
   integer source_paw_lseen2                ; // := source_paw_lseen2;
   integer mth_source_paw_lseen             ; // := mth_source_paw_lseen;
   integer source_paw_fseen2                ; // := source_paw_fseen2;
   integer mth_source_paw_fseen             ; // := mth_source_paw_fseen;
   integer source_ppca_lseen2               ; // := source_ppca_lseen2;
   integer mth_source_ppca_lseen            ; // := mth_source_ppca_lseen;
   integer source_ppca_fseen2               ; // := source_ppca_fseen2;
   integer mth_source_ppca_fseen            ; // := mth_source_ppca_fseen;
   integer source_ppdid_lseen2              ; // := source_ppdid_lseen2;
   integer mth_source_ppdid_lseen           ; // := mth_source_ppdid_lseen;
   integer source_ppdid_fseen2              ; // := source_ppdid_fseen2;
   integer mth_source_ppdid_fseen           ; // := mth_source_ppdid_fseen;
   integer source_ppfla_lseen2              ; // := source_ppfla_lseen2;
   integer mth_source_ppfla_lseen           ; // := mth_source_ppfla_lseen;
   integer source_ppfla_fseen2              ; // := source_ppfla_fseen2;
   integer mth_source_ppfla_fseen           ; // := mth_source_ppfla_fseen;
   integer source_ppla_lseen2               ; // := source_ppla_lseen2;
   integer mth_source_ppla_lseen            ; // := mth_source_ppla_lseen;
   integer source_ppla_fseen2               ; // := source_ppla_fseen2;
   integer mth_source_ppla_fseen            ; // := mth_source_ppla_fseen;
   integer source_ppth_lseen2               ; // := source_ppth_lseen2;
   integer mth_source_ppth_lseen            ; // := mth_source_ppth_lseen;
   integer source_ppth_fseen2               ; // := source_ppth_fseen2;
   integer mth_source_ppth_fseen            ; // := mth_source_ppth_fseen;
   integer source_rm_fseen2                 ; // := source_rm_fseen2;
   integer mth_source_rm_fseen              ; // := mth_source_rm_fseen;
   integer source_sx_fseen2                 ; // := source_sx_fseen2;
   integer mth_source_sx_fseen              ; // := mth_source_sx_fseen;
   integer source_utildid_fseen2            ; // := source_utildid_fseen2;
   integer mth_source_utildid_fseen         ; // := mth_source_utildid_fseen;
   integer eda_dt_first_seen2               ; // := eda_dt_first_seen2;
   integer mth_eda_dt_first_seen            ; // := mth_eda_dt_first_seen;
   integer eda_dt_last_seen2                ; // := eda_dt_last_seen2;
   integer mth_eda_dt_last_seen             ; // := mth_eda_dt_last_seen;
   integer eda_deletion_date2               ; // := eda_deletion_date2;
   integer mth_eda_deletion_date            ; // := mth_eda_deletion_date;
   integer exp_last_update2                 ; // := exp_last_update2;
   integer mth_exp_last_update              ; // := mth_exp_last_update;
   integer internal_ver_first_seen2         ; // := internal_ver_first_seen2;
   integer mth_internal_ver_first_seen      ; // := mth_internal_ver_first_seen;
   integer internal_ver_last_seen2          ; // := internal_ver_last_seen2;
   integer mth_internal_ver_last_seen       ; // := mth_internal_ver_last_seen;
   integer phone_fb_rp_date2                ; // := phone_fb_rp_date2;
   integer mth_phone_fb_rp_date             ; // := mth_phone_fb_rp_date;
   integer pp_datefirstseen2                ; // := pp_datefirstseen2;
   integer mth_pp_datefirstseen             ; // := mth_pp_datefirstseen;
   integer pp_datelastseen2                 ; // := pp_datelastseen2;
   integer mth_pp_datelastseen              ; // := mth_pp_datelastseen;
   integer pp_datevendorfirstseen2          ; // := pp_datevendorfirstseen2;
   integer mth_pp_datevendorfirstseen       ; // := mth_pp_datevendorfirstseen;
   integer pp_orig_lastseen2                ; // := pp_orig_lastseen2;
   integer mth_pp_orig_lastseen             ; // := mth_pp_orig_lastseen;
   integer pp_app_npa_effective_dt2         ; // := pp_app_npa_effective_dt2;
   integer mth_pp_app_npa_effective_dt      ; // := mth_pp_app_npa_effective_dt;
   integer pp_app_npa_last_change_dt2       ; // := pp_app_npa_last_change_dt2;
   integer mth_pp_app_npa_last_change_dt    ; // := mth_pp_app_npa_last_change_dt;
   integer pp_eda_hist_ph_dt2               ; // := pp_eda_hist_ph_dt2;
   integer mth_pp_eda_hist_ph_dt            ; // := mth_pp_eda_hist_ph_dt;
   integer pp_eda_hist_did_dt2              ; // := pp_eda_hist_did_dt2;
   integer mth_pp_eda_hist_did_dt           ; // := mth_pp_eda_hist_did_dt;
   integer pp_eda_hist_nm_addr_dt2          ; // := pp_eda_hist_nm_addr_dt2;
   integer mth_pp_eda_hist_nm_addr_dt       ; // := mth_pp_eda_hist_nm_addr_dt;
   integer pp_first_build_date2             ; // := pp_first_build_date2;
   integer mth_pp_first_build_date          ; // := mth_pp_first_build_date;
   boolean _phone_match_code_a              ; // := _phone_match_code_a;
   boolean _phone_match_code_c              ; // := _phone_match_code_c;
   boolean _phone_match_code_l              ; // := _phone_match_code_l;
   boolean _phone_match_code_n              ; // := _phone_match_code_n;
   boolean _phone_match_code_s              ; // := _phone_match_code_s;
   boolean _phone_match_code_t              ; // := _phone_match_code_t;
   boolean _phone_match_code_z              ; // := _phone_match_code_z;
   integer _pp_rule_disconnected_eda        ; // := _pp_rule_disconnected_eda;
   integer _pp_rule_non_pub                 ; // := _pp_rule_non_pub;
   integer _pp_rule_port_neustar            ; // := _pp_rule_port_neustar;
   integer _pp_rule_high_vend_conf          ; // := _pp_rule_high_vend_conf;
   integer _pp_rule_cellphone_latest        ; // := _pp_rule_cellphone_latest;
   integer _pp_rule_source_latest           ; // := _pp_rule_source_latest;
   integer _pp_rule_med_vend_conf_cell      ; // := _pp_rule_med_vend_conf_cell;
   integer _pp_rule_gong_disc               ; // := _pp_rule_gong_disc;
   integer _pp_rule_consort_disc            ; // := _pp_rule_consort_disc;
   integer _pp_rule_f1_ver_above            ; // := _pp_rule_f1_ver_above;
   integer _pp_src_all_uw                   ; // := _pp_src_all_uw;
   integer _pp_srule_port_neustar           ; // := _pp_srule_port_neustar;
   integer inq_firstseen_n                  ; // := inq_firstseen_n;
   integer inq_lastseen_n                   ; // := inq_lastseen_n;
   integer inq_adl_firstseen_n              ; // := inq_adl_firstseen_n;
   integer inq_adl_lastseen_n               ; // := inq_adl_lastseen_n;
   string internal_ver_match_type          ; // := internal_ver_match_type;
   boolean _internal_ver_match_hhid         ; // := _internal_ver_match_hhid;
   boolean _inq_adl_ph_industry_flag        ; // := _inq_adl_ph_industry_flag;
   integer _phone_disconnected              ; // := _phone_disconnected;
   integer _phone_zip_match                 ; // := _phone_zip_match;
   integer _phone_timezone_match            ; // := _phone_timezone_match;
   integer _phone_fb_rp_result              ; // := _phone_fb_rp_result;
   integer _pp_app_fb_ph_disc               ; // := _pp_app_fb_ph_disc;
   integer _pp_app_fb_ph7_did_disc          ; // := _pp_app_fb_ph7_did_disc;
   integer _pp_app_fb_ph7_nm_addr_disc      ; // := _pp_app_fb_ph7_nm_addr_disc;
   integer _phone_fb_result_disc            ; // := _phone_fb_result_disc;
   integer _phone_fb_rp_result_disc         ; // := _phone_fb_rp_result_disc;
   integer _pp_rule_disc_flag               ; // := _pp_rule_disc_flag;
   integer _pp_app_fb_disc_flag             ; // := _pp_app_fb_disc_flag;
   integer _phone_fb_disc_flag              ; // := _phone_fb_disc_flag;
   integer pk_disconnect_flag               ; // := pk_disconnect_flag;
   boolean _phone_match_code_lns            ; // := _phone_match_code_lns;
   integer _phone_match_code_tcza           ; // := _phone_match_code_tcza;
   integer pk_phone_match_level             ; // := pk_phone_match_level;
   integer _pp_app_coctype_landline         ; // := _pp_app_coctype_landline;
   integer _pp_app_coctype_cell             ; // := _pp_app_coctype_cell;
   integer _phone_switch_type_cell          ; // := _phone_switch_type_cell;
   integer _pp_app_nxx_type_cell            ; // := _pp_app_nxx_type_cell;
   integer _pp_app_ph_type_cell             ; // := _pp_app_ph_type_cell;
   integer _pp_app_company_type_cell        ; // := _pp_app_company_type_cell;
   integer _exp_type_cell                   ; // := _exp_type_cell;
   integer pk_cell_indicator                ; // := pk_cell_indicator;
   boolean add_input_pop                    ; // := add_input_pop;
   boolean add_curr_pop                     ; // := add_curr_pop;
   integer add_curr_naprop                  ; // := add_curr_naprop;
   integer add_input_avm_auto_val           ; // := add_input_avm_auto_val;
   integer add_curr_avm_auto_val            ; // := add_curr_avm_auto_val;
   integer add_curr_lres                    ; // := add_curr_lres;
   integer add_curr_avm_auto_val_2          ; // := add_curr_avm_auto_val_2;
   integer add_input_naprop                 ; // := add_input_naprop;
   integer add_prev_naprop                  ; // := add_prev_naprop;
   integer add_input_occupants_1yr          ; // := add_input_occupants_1yr;
   integer add_input_turnover_1yr_in        ; // := add_input_turnover_1yr_in;
   integer add_input_turnover_1yr_out       ; // := add_input_turnover_1yr_out;
   integer add_input_nhood_bus_ct           ; // := add_input_nhood_bus_ct;
   integer add_input_nhood_sfd_ct           ; // := add_input_nhood_sfd_ct;
   integer add_input_nhood_mfd_ct           ; // := add_input_nhood_mfd_ct;
   integer add_curr_occupants_1yr           ; // := add_curr_occupants_1yr;
   integer add_curr_turnover_1yr_in         ; // := add_curr_turnover_1yr_in;
   integer add_curr_turnover_1yr_out        ; // := add_curr_turnover_1yr_out;
   integer add_curr_nhood_bus_ct            ; // := add_curr_nhood_bus_ct;
   integer add_curr_nhood_sfd_ct            ; // := add_curr_nhood_sfd_ct;
   integer add_curr_nhood_mfd_ct            ; // := add_curr_nhood_mfd_ct;
   integer add_curr_nhood_vac_prop          ; // := add_curr_nhood_vac_prop;
   integer _felony_last_date                ; // := _felony_last_date;
   integer r_d32_mos_since_fel_ls_d         ; // := r_d32_mos_since_fel_ls_d;
   integer r_d31_mostrec_bk_i               ; // := r_d31_mostrec_bk_i;
   integer bureau_adl_eq_fseen_pos          ; // := bureau_adl_eq_fseen_pos;
   string bureau_adl_fseen_eq              ; // := bureau_adl_fseen_eq;
   integer _bureau_adl_fseen_eq             ; // := _bureau_adl_fseen_eq;
   integer _src_bureau_adl_fseen            ; // := _src_bureau_adl_fseen;
   integer r_c21_m_bureau_adl_fs_d          ; // := r_c21_m_bureau_adl_fs_d;
   integer bureau_adl_en_fseen_pos          ; // := bureau_adl_en_fseen_pos;
   string bureau_adl_fseen_en              ; // := bureau_adl_fseen_en;
   integer _bureau_adl_fseen_en             ; // := _bureau_adl_fseen_en;
   integer bureau_adl_ts_fseen_pos          ; // := bureau_adl_ts_fseen_pos;
   string bureau_adl_fseen_ts              ; // := bureau_adl_fseen_ts;
   integer _bureau_adl_fseen_ts             ; // := _bureau_adl_fseen_ts;
   integer bureau_adl_tu_fseen_pos          ; // := bureau_adl_tu_fseen_pos;
   string bureau_adl_fseen_tu              ; // := bureau_adl_fseen_tu;
   integer _bureau_adl_fseen_tu             ; // := _bureau_adl_fseen_tu;
   integer bureau_adl_tn_fseen_pos          ; // := bureau_adl_tn_fseen_pos;
   string bureau_adl_fseen_tn              ; // := bureau_adl_fseen_tn;
   integer _bureau_adl_fseen_tn             ; // := _bureau_adl_fseen_tn;
   integer _src_bureau_adl_fseen_all        ; // := _src_bureau_adl_fseen_all;
   integer f_m_bureau_adl_fs_all_d          ; // := f_m_bureau_adl_fs_all_d;
   integer r_a44_curr_add_naprop_d          ; // := r_a44_curr_add_naprop_d;
   integer r_l80_inp_avm_autoval_d          ; // := r_l80_inp_avm_autoval_d;
   integer r_a49_curr_avm_chg_1yr_i         ; // := r_a49_curr_avm_chg_1yr_i;
   integer r_a49_curr_avm_chg_1yr_pct_i     ; // := r_a49_curr_avm_chg_1yr_pct_i;
   integer r_c13_max_lres_d                 ; // := r_c13_max_lres_d;
   integer r_c14_addrs_5yr_i                ; // := r_c14_addrs_5yr_i;
   integer r_c14_addrs_10yr_i               ; // := r_c14_addrs_10yr_i;
   integer r_c14_addrs_15yr_i               ; // := r_c14_addrs_15yr_i;
   integer r_a41_prop_owner_d               ; // := r_a41_prop_owner_d;
   integer r_prop_owner_history_d           ; // := r_prop_owner_history_d;
   integer r_c20_email_count_i              ; // := r_c20_email_count_i;
   integer r_c18_invalid_addrs_per_adl_i    ; // := r_c18_invalid_addrs_per_adl_i;
   integer r_i60_inq_hiriskcred_recency_d   ; // := r_i60_inq_hiriskcred_recency_d;
   integer r_i60_inq_comm_recency_d         ; // := r_i60_inq_comm_recency_d;
   integer f_util_adl_count_n               ; // := f_util_adl_count_n;
   integer f_add_input_mobility_index_n     ; // := f_add_input_mobility_index_n;
   integer add_input_nhood_prop_sum         ; // := add_input_nhood_prop_sum;
   integer f_add_input_nhood_bus_pct_i      ; // := f_add_input_nhood_bus_pct_i;
   integer f_add_input_nhood_mfd_pct_i      ; // := f_add_input_nhood_mfd_pct_i;
   integer f_add_input_nhood_sfd_pct_d      ; // := f_add_input_nhood_sfd_pct_d;
   integer f_add_curr_mobility_index_n      ; // := f_add_curr_mobility_index_n;
   integer add_curr_nhood_prop_sum          ; // := add_curr_nhood_prop_sum;
   integer f_add_curr_nhood_bus_pct_i       ; // := f_add_curr_nhood_bus_pct_i;
   integer f_add_curr_nhood_mfd_pct_i       ; // := f_add_curr_nhood_mfd_pct_i;
   integer f_add_curr_nhood_sfd_pct_d       ; // := f_add_curr_nhood_sfd_pct_d;
   integer f_add_curr_nhood_vac_pct_i       ; // := f_add_curr_nhood_vac_pct_i;
   integer f_inq_count_i                    ; // := f_inq_count_i;
   integer f_inq_collection_count_i         ; // := f_inq_collection_count_i;
   integer f_inq_communications_count_i     ; // := f_inq_communications_count_i;
   integer f_inq_highriskcredit_count_i     ; // := f_inq_highriskcredit_count_i;
   integer f_inq_highriskcredit_count24_i   ; // := f_inq_highriskcredit_count24_i;
   integer f_inq_mortgage_count_i           ; // := f_inq_mortgage_count_i;
   integer f_inq_mortgage_count24_i         ; // := f_inq_mortgage_count24_i;
   integer f_inq_per_ssn_i                  ; // := f_inq_per_ssn_i;
   integer f_inq_lnames_per_addr_i          ; // := f_inq_lnames_per_addr_i;
   integer _inq_banko_am_first_seen         ; // := _inq_banko_am_first_seen;
   integer f_mos_inq_banko_am_fseen_d       ; // := f_mos_inq_banko_am_fseen_d;
   integer _inq_banko_cm_first_seen         ; // := _inq_banko_cm_first_seen;
   integer f_mos_inq_banko_cm_fseen_d       ; // := f_mos_inq_banko_cm_fseen_d;
   integer _inq_banko_cm_last_seen          ; // := _inq_banko_cm_last_seen;
   integer f_mos_inq_banko_cm_lseen_d       ; // := f_mos_inq_banko_cm_lseen_d;
   integer _inq_banko_om_first_seen         ; // := _inq_banko_om_first_seen;
   integer f_mos_inq_banko_om_fseen_d       ; // := f_mos_inq_banko_om_fseen_d;
   integer _liens_unrel_cj_first_seen       ; // := _liens_unrel_cj_first_seen;
   integer f_mos_liens_unrel_cj_fseen_d     ; // := f_mos_liens_unrel_cj_fseen_d;
   integer _liens_unrel_cj_last_seen        ; // := _liens_unrel_cj_last_seen;
   integer f_mos_liens_unrel_cj_lseen_d     ; // := f_mos_liens_unrel_cj_lseen_d;
   integer _liens_unrel_sc_first_seen       ; // := _liens_unrel_sc_first_seen;
   integer f_mos_liens_unrel_sc_fseen_d     ; // := f_mos_liens_unrel_sc_fseen_d;
   integer f_estimated_income_d             ; // := f_estimated_income_d;
   integer f_wealth_index_d                 ; // := f_wealth_index_d;
   integer f_rel_incomeover50_count_d       ; // := f_rel_incomeover50_count_d;
   integer f_rel_incomeover75_count_d       ; // := f_rel_incomeover75_count_d;
   integer f_rel_homeover200_count_d        ; // := f_rel_homeover200_count_d;
   integer f_rel_educationover8_count_d     ; // := f_rel_educationover8_count_d;
   integer f_rel_under25miles_cnt_d         ; // := f_rel_under25miles_cnt_d;
   integer f_rel_under100miles_cnt_d        ; // := f_rel_under100miles_cnt_d;
   integer f_idrisktype_i                   ; // := f_idrisktype_i;
   integer f_idverrisktype_i                ; // := f_idverrisktype_i;
   integer f_varrisktype_i                  ; // := f_varrisktype_i;
   integer f_srchvelocityrisktype_i         ; // := f_srchvelocityrisktype_i;
   integer f_srchunvrfdssncount_i           ; // := f_srchunvrfdssncount_i;
   integer f_srchunvrfdphonecount_i         ; // := f_srchunvrfdphonecount_i;
   integer f_srchfraudsrchcount_i           ; // := f_srchfraudsrchcount_i;
   integer f_assocsuspicousidcount_i        ; // := f_assocsuspicousidcount_i;
   integer f_corraddrnamecount_d            ; // := f_corraddrnamecount_d;
   integer f_srchssnsrchcount_i             ; // := f_srchssnsrchcount_i;
   integer f_srchaddrsrchcount_i            ; // := f_srchaddrsrchcount_i;
   integer f_addrchangeincomediff_d         ; // := f_addrchangeincomediff_d;
   integer f_addrchangevaluediff_d          ; // := f_addrchangevaluediff_d;
   integer f_addrchangecrimediff_i          ; // := f_addrchangecrimediff_i;
   integer f_curraddrmedianincome_d         ; // := f_curraddrmedianincome_d;
   integer f_curraddrcartheftindex_i        ; // := f_curraddrcartheftindex_i;
   integer f_curraddrburglaryindex_i        ; // := f_curraddrburglaryindex_i;
   integer f_curraddrcrimeindex_i           ; // := f_curraddrcrimeindex_i;
   integer f_prevaddrcartheftindex_i        ; // := f_prevaddrcartheftindex_i;
   integer r_s65_ssn_deceased_i             ; // := r_s65_ssn_deceased_i;
   integer r_paw_active_phone_ct_d          ; // := r_paw_active_phone_ct_d;
   integer r_c13_avg_lres_d                 ; // := r_c13_avg_lres_d;
   integer _mod_disc_noexp_v01_w            ; // := _mod_disc_noexp_v01_w;
   integer _mod_disc_noexp_v02_w            ; // := _mod_disc_noexp_v02_w;
   integer _mod_disc_noexp_v03_w            ; // := _mod_disc_noexp_v03_w;
   integer _mod_disc_noexp_v04_w            ; // := _mod_disc_noexp_v04_w;
   integer _mod_disc_noexp_v05_w            ; // := _mod_disc_noexp_v05_w;
   integer _mod_disc_noexp_v06_w            ; // := _mod_disc_noexp_v06_w;
   integer _mod_disc_noexp_v07_w            ; // := _mod_disc_noexp_v07_w;
   integer _mod_disc_noexp_v08_w            ; // := _mod_disc_noexp_v08_w;
   integer _mod_disc_noexp_v09_w            ; // := _mod_disc_noexp_v09_w;
   integer _mod_disc_noexp_v10_w            ; // := _mod_disc_noexp_v10_w;
   integer _mod_disc_noexp_v11_w            ; // := _mod_disc_noexp_v11_w;
   integer _mod_disc_noexp_v12_w            ; // := _mod_disc_noexp_v12_w;
   integer _mod_disc_noexp_v13_w            ; // := _mod_disc_noexp_v13_w;
   integer _mod_disc_noexp_v14_w            ; // := _mod_disc_noexp_v14_w;
   integer _mod_disc_noexp_v15_w            ; // := _mod_disc_noexp_v15_w;
   integer _mod_disc_noexp_v16_w            ; // := _mod_disc_noexp_v16_w;
   integer _mod_disc_noexp_v17_w            ; // := _mod_disc_noexp_v17_w;
   integer _mod_disc_noexp_v18_w            ; // := _mod_disc_noexp_v18_w;
   integer _mod_disc_noexp_v19_w            ; // := _mod_disc_noexp_v19_w;
   integer _mod_disc_noexp_v20_w            ; // := _mod_disc_noexp_v20_w;
   integer _mod_disc_noexp_v21_w            ; // := _mod_disc_noexp_v21_w;
   integer _mod_disc_noexp_v22_w            ; // := _mod_disc_noexp_v22_w;
   integer _mod_disc_noexp_v23_w            ; // := _mod_disc_noexp_v23_w;
   integer _mod_disc_noexp_v24_w            ; // := _mod_disc_noexp_v24_w;
   integer _mod_disc_noexp_v25_w            ; // := _mod_disc_noexp_v25_w;
   integer _mod_disc_noexp_v26_w            ; // := _mod_disc_noexp_v26_w;
   integer _mod_disc_noexp_v27_w            ; // := _mod_disc_noexp_v27_w;
   integer _mod_disc_noexp_v28_w            ; // := _mod_disc_noexp_v28_w;
   integer _mod_disc_noexp_v29_w            ; // := _mod_disc_noexp_v29_w;
   integer _mod_disc_noexp_v30_w            ; // := _mod_disc_noexp_v30_w;
   integer _mod_disc_noexp_v31_w            ; // := _mod_disc_noexp_v31_w;
   integer _mod_disc_noexp_v32_w            ; // := _mod_disc_noexp_v32_w;
   integer _mod_disc_noexp_v33_w            ; // := _mod_disc_noexp_v33_w;
   integer _mod_disc_noexp_v34_w            ; // := _mod_disc_noexp_v34_w;
   integer _mod_disc_noexp_v35_w            ; // := _mod_disc_noexp_v35_w;
   integer _mod_disc_noexp_v36_w            ; // := _mod_disc_noexp_v36_w;
   integer _mod_disc_noexp_v37_w            ; // := _mod_disc_noexp_v37_w;
   integer _mod_disc_noexp_v38_w            ; // := _mod_disc_noexp_v38_w;
   integer _mod_disc_noexp_v39_w            ; // := _mod_disc_noexp_v39_w;
   integer _mod_disc_noexp_lgt              ; // := _mod_disc_noexp_lgt;
   real final_score_0                    ; // := final_score_0;
   real final_score_1                    ; // := final_score_1;
   real final_score_2                    ; // := final_score_2;
   real final_score_3                    ; // := final_score_3;
   real final_score_4                    ; // := final_score_4;
   real final_score_5                    ; // := final_score_5;
   real final_score_6                    ; // := final_score_6;
   real final_score_7                    ; // := final_score_7;
   real final_score_8                    ; // := final_score_8;
   real final_score_9                    ; // := final_score_9;
   real final_score_10                   ; // := final_score_10;
   real final_score_11                   ; // := final_score_11;
   real final_score_12                   ; // := final_score_12;
   real final_score_13                   ; // := final_score_13;
   real final_score_14                   ; // := final_score_14;
   real final_score_15                   ; // := final_score_15;
   real final_score_16                   ; // := final_score_16;
   real final_score_17                   ; // := final_score_17;
   real final_score_18                   ; // := final_score_18;
   real final_score_19                   ; // := final_score_19;
   real final_score_20                   ; // := final_score_20;
   real final_score_21                   ; // := final_score_21;
   real final_score_22                   ; // := final_score_22;
   real final_score_23                   ; // := final_score_23;
   real final_score_24                   ; // := final_score_24;
   real final_score_25                   ; // := final_score_25;
   real final_score_26                   ; // := final_score_26;
   real final_score_27                   ; // := final_score_27;
   real final_score_28                   ; // := final_score_28;
   real final_score_29                   ; // := final_score_29;
   real final_score_30                   ; // := final_score_30;
   real final_score_31                   ; // := final_score_31;
   real final_score_32                   ; // := final_score_32;
   real final_score_33                   ; // := final_score_33;
   real final_score_34                   ; // := final_score_34;
   real final_score_35                   ; // := final_score_35;
   real final_score_36                   ; // := final_score_36;
   real final_score_37                   ; // := final_score_37;
   real final_score_38                   ; // := final_score_38;
   real final_score_39                   ; // := final_score_39;
   real final_score_40                   ; // := final_score_40;
   real final_score_41                   ; // := final_score_41;
   real final_score_42                   ; // := final_score_42;
   real final_score_43                   ; // := final_score_43;
   real final_score_44                   ; // := final_score_44;
   real final_score_45                   ; // := final_score_45;
   real final_score_46                   ; // := final_score_46;
   real final_score_47                   ; // := final_score_47;
   real final_score_48                   ; // := final_score_48;
   real final_score_49                   ; // := final_score_49;
   real final_score_50                   ; // := final_score_50;
   real final_score_51                   ; // := final_score_51;
   real final_score_52                   ; // := final_score_52;
   real final_score_53                   ; // := final_score_53;
   real final_score_54                   ; // := final_score_54;
   real final_score_55                   ; // := final_score_55;
   real final_score_56                   ; // := final_score_56;
   real final_score_57                   ; // := final_score_57;
   real final_score_58                   ; // := final_score_58;
   real final_score_59                   ; // := final_score_59;
   real final_score_60                   ; // := final_score_60;
   real final_score_61                   ; // := final_score_61;
   real final_score_62                   ; // := final_score_62;
   real final_score_63                   ; // := final_score_63;
   real final_score_64                   ; // := final_score_64;
   real final_score_65                   ; // := final_score_65;
   real final_score_66                   ; // := final_score_66;
   real final_score_67                   ; // := final_score_67;
   real final_score_68                   ; // := final_score_68;
   real final_score_69                   ; // := final_score_69;
   real final_score_70                   ; // := final_score_70;
   real final_score_71                   ; // := final_score_71;
   real final_score_72                   ; // := final_score_72;
   real final_score_73                   ; // := final_score_73;
   real final_score_74                   ; // := final_score_74;
   real final_score_75                   ; // := final_score_75;
   real final_score_76                   ; // := final_score_76;
   real final_score_77                   ; // := final_score_77;
   real final_score_78                   ; // := final_score_78;
   real final_score_79                   ; // := final_score_79;
   real final_score_80                   ; // := final_score_80;
   real final_score_81                   ; // := final_score_81;
   real final_score_82                   ; // := final_score_82;
   real final_score_83                   ; // := final_score_83;
   real final_score_84                   ; // := final_score_84;
   real final_score_85                   ; // := final_score_85;
   real final_score_86                   ; // := final_score_86;
   real final_score_87                   ; // := final_score_87;
   real final_score_88                   ; // := final_score_88;
   real final_score_89                   ; // := final_score_89;
   real final_score_90                   ; // := final_score_90;
   real final_score_91                   ; // := final_score_91;
   real final_score_92                   ; // := final_score_92;
   real final_score_93                   ; // := final_score_93;
   real final_score_94                   ; // := final_score_94;
   real final_score_95                   ; // := final_score_95;
   real final_score_96                   ; // := final_score_96;
   real final_score_97                   ; // := final_score_97;
   real final_score_98                   ; // := final_score_98;
   real final_score_99                   ; // := final_score_99;
   real final_score_100                  ; // := final_score_100;
   real final_score_101                  ; // := final_score_101;
   real final_score_102                  ; // := final_score_102;
   real final_score_103                  ; // := final_score_103;
   real final_score_104                  ; // := final_score_104;
   real final_score_105                  ; // := final_score_105;
   real final_score                      ; // := final_score;
   integer phat                             ; // := phat;
   integer wf83                             ; // := wf83;
			
			// Save all of the Phone Shell fields for return
			Phone_Shell.Layout_Phone_Shell.Phone_Shell_Layout clam;
 END;
    layout_debug doModel( clam le ) := TRANSFORM
  #else
		Phone_Shell.Layout_Phone_Shell.Phone_Shell_Layout doModel( clam le ) := TRANSFORM
  #end

//Start: ECL SAS mapping variables 
	source_list                      := trim(le.Phone_Shell.Sources.Source_List, left, right);
	source_list_last_seen            := trim(le.Phone_Shell.Sources.Source_List_Last_Seen, left, right);
	source_list_first_seen           := trim(le.Phone_Shell.Sources.Source_List_First_Seen, left, right);
	eda_dt_first_seen                := le.Phone_Shell.EDA_Characteristics.EDA_Dt_First_Seen;
	eda_dt_last_seen                 := le.Phone_Shell.EDA_Characteristics.EDA_Dt_Last_Seen;
	eda_deletion_date                := le.Phone_Shell.EDA_Characteristics.EDA_Deletion_Date;
	exp_last_update                  := le.Phone_Shell.Experian_File_One_Verification.Experian_Last_Update;
	internal_ver_first_seen          := le.Phone_Shell.Internal_Corroboration.Internal_Verification_First_Seen;
	internal_ver_last_seen           := le.Phone_Shell.Internal_Corroboration.Internal_Verification_Last_Seen;
	internal_ver_match_types         := le.Phone_Shell.Internal_Corroboration.Internal_Verification_Match_Types;
 phone_fb_rp_date                 := le.Phone_Shell.Phone_Feedback.Phone_Feedback_RP_Date;
	pp_datefirstseen                 := le.Phone_Shell.PhonesPlus_Characteristics.PhonesPlus_DateFirstSeen;
	pp_datelastseen                  := le.Phone_Shell.PhonesPlus_Characteristics.PhonesPlus_DateLastSeen;
	pp_datevendorfirstseen           := le.Phone_Shell.PhonesPlus_Characteristics.PhonesPlus_DateVendorFirstSeen;
	pp_orig_lastseen                 := le.Phone_Shell.PhonesPlus_Characteristics.PhonesPlus_Orig_LastSeen;
	pp_app_npa_effective_dt          := le.Phone_Shell.PhonesPlus_Characteristics.PhonesPlus_Append_NPA_Effective_DT;
	pp_app_npa_last_change_dt        := le.Phone_Shell.PhonesPlus_Characteristics.PhonesPlus_Append_NPA_Last_Change_DT;
	pp_eda_hist_ph_dt                := le.Phone_Shell.PhonesPlus_Characteristics.PhonesPlus_EDA_Hist_Phone_Dt;
	pp_eda_hist_did_dt               := le.Phone_Shell.PhonesPlus_Characteristics.PhonesPlus_EDA_Hist_DID_Dt;
	pp_eda_hist_nm_addr_dt           := le.Phone_Shell.PhonesPlus_Characteristics.PhonesPlus_EDA_Hist_Nm_Addr_Dt;
	pp_first_build_date              := le.Phone_Shell.PhonesPlus_Characteristics.PhonesPlus_First_Build_Date;
	phone_match_code                 := le.Phone_Shell.Raw_Phone_Characteristics.Phone_Match_Code;
	pp_rules                         := le.Phone_Shell.PhonesPlus_Characteristics.PhonesPlus_Rules;
	pp_src_all                       := le.Phone_Shell.PhonesPlus_Characteristics.PhonesPlus_Src_All;
	pp_src_rule                      := le.Phone_Shell.PhonesPlus_Characteristics.PhonesPlus_Src_Rule;
	inq_firstseen                    := le.Phone_Shell.Inquiries.Inq_FirstSeen;
	inq_lastseen                     := le.Phone_Shell.Inquiries.Inq_LastSeen;
	inq_adl_firstseen                := le.Phone_Shell.Inquiries.Inq_ADL_FirstSeen;
	inq_adl_lastseen                 := le.Phone_Shell.Inquiries.Inq_ADL_LastSeen;
	inq_adl_ph_industry_list_12      := le.Phone_Shell.Inquiries.Inq_ADL_Phone_Industry_List_12;
	phone_disconnected               := (integer)le.Phone_Shell.Raw_Phone_Characteristics.Phone_Disconnected;
	phone_zip_match                  := le.Phone_Shell.Raw_Phone_Characteristics.Phone_Zip_Match;
	phone_timezone_match             := le.Phone_Shell.Raw_Phone_Characteristics.Phone_Timezone_Match;
	phone_fb_rp_result               := le.Phone_Shell.Phone_Feedback.Phone_Feedback_RP_Result;
	pp_app_fb_ph                     := le.Phone_Shell.PhonesPlus_Characteristics.PhonesPlus_Append_Feedback_Phone;
	pp_app_fb_ph7_did                := le.Phone_Shell.PhonesPlus_Characteristics.PhonesPlus_Append_Feedback_Phone7_DID;
	pp_app_fb_ph7_nm_addr            := le.Phone_Shell.PhonesPlus_Characteristics.PhonesPlus_Append_Feedback_Phone7_NM_Addr;
	phone_fb_result                  := le.Phone_Shell.Phone_Feedback.Phone_Feedback_Result;
	pp_app_coctype                   := le.Phone_Shell.PhonesPlus_Characteristics.PhonesPlus_Append_COCType;
	pp_app_scc                       := le.Phone_Shell.PhonesPlus_Characteristics.PhonesPlus_Append_SCC;
	phone_switch_type                := le.Phone_Shell.Raw_Phone_Characteristics.Phone_Switch_Type;
	pp_app_nxx_type                  := le.Phone_Shell.PhonesPlus_Characteristics.PhonesPlus_Append_NXX_Type;
	pp_app_ph_type                   := le.Phone_Shell.PhonesPlus_Characteristics.PhonesPlus_Append_Phone_Type;
	pp_app_company_type              := le.Phone_Shell.PhonesPlus_Characteristics.PhonesPlus_Append_Company_Type;
	exp_type                         := le.Phone_Shell.Experian_File_One_Verification.Experian_Type;
	eda_pfrd_address_ind             := le.Phone_Shell.EDA_Characteristics.EDA_Pfrd_Address_Ind;
	eda_address_match_best           := (integer) le.Phone_Shell.EDA_Characteristics.EDA_Address_Match_Best;
	inq_num_adls_06                  := (integer)le.Phone_Shell.Inquiries.Inq_Num_ADLs_06;
	phone_subject_title              := le.Phone_Shell.Raw_Phone_Characteristics.Phone_Subject_Title;
	exp_source                       := le.Phone_Shell.Experian_File_One_Verification.Experian_Source;
	pp_app_ind_ph_cnt                := le.Phone_Shell.PhonesPlus_Characteristics.PhonesPlus_Append_Indiv_Phone_Cnt;
	pp_src                           := le.Phone_Shell.PhonesPlus_Characteristics.PhonesPlus_Src;
	pp_origlistingtype               := le.Phone_Shell.PhonesPlus_Characteristics.PhonesPlus_OrigListingType;
	pp_app_best_addr_match_fl        := le.Phone_Shell.PhonesPlus_Characteristics.PhonesPlus_Append_Best_Addr_Match_Flag;
	pp_source                        := le.Phone_Shell.PhonesPlus_Characteristics.PhonesPlus_Source;
	eda_months_addr_last_seen        := le.Phone_Shell.EDA_Characteristics.EDA_Months_Addr_Last_Seen;
	pp_did_score                     := le.Phone_Shell.PhonesPlus_Characteristics.PhonesPlus_DID_Score;
	eda_days_ind_first_seen          := le.Phone_Shell.EDA_Characteristics.EDA_Days_Indiv_First_Seen;
	eda_max_days_interrupt           := le.Phone_Shell.EDA_Characteristics.EDA_Max_Days_Interrupt; 
	inq_num                          := (integer)le.Phone_Shell.Inquiries.Inq_Num;
	eda_days_in_service              := le.Phone_Shell.EDA_Characteristics.EDA_Days_In_Service;
	eda_num_ph_owners_cur            := le.Phone_Shell.EDA_Characteristics.EDA_Num_Phone_Owners_Cur;
	pp_type                          := le.Phone_Shell.PhonesPlus_Characteristics.PhonesPlus_Type;
	eda_max_days_connected_ind       := le.Phone_Shell.EDA_Characteristics.EDA_Max_Days_Connected_Indiv;
	pp_origphonetype                 := le.Phone_Shell.PhonesPlus_Characteristics.PhonesPlus_OrigPhoneType;
	eda_days_ph_first_seen           := le.Phone_Shell.EDA_Characteristics.EDA_Days_Phone_First_Seen;
	pp_did_type                      := le.Phone_Shell.PhonesPlus_Characteristics.PhonesPlus_DID_Type;
	phone_business_count             := le.Phone_Shell.Raw_Phone_Characteristics.Phone_Business_Count;
	eda_did_count                    := le.Phone_Shell.EDA_Characteristics.EDA_DID_Count;
	
	truedid                          := le.Boca_Shell.truedid;
	rc_decsflag                      := le.Boca_Shell.iid.decsflag;
	ver_sources                      := le.Boca_Shell.header_summary.ver_sources;
	ver_sources_first_seen           := le.Boca_Shell.header_summary.ver_sources_first_seen_date;
	addrpop                          := le.Boca_Shell.input_validation.address;
	ssnlength                        := le.Boca_Shell.input_validation.ssn_length;
	util_adl_count                   := le.Boca_Shell.utility.utili_adl_count;
	add1_isbestmatch                 := le.Boca_Shell.address_verification.input_address_information.isbestmatch;
	add1_lres                        := le.Boca_Shell.lres;
	add1_avm_automated_valuation     := le.Boca_Shell.avm.input_address_information.avm_automated_valuation;
	add1_avm_automated_valuation_2   := le.Boca_Shell.avm.input_address_information.avm_automated_valuation2;
	add1_naprop                      := le.Boca_Shell.address_verification.input_address_information.naprop;
	add1_occupants_1yr               := le.Boca_Shell.addr_risk_summary.occupants_1yr;
	add1_turnover_1yr_in             := le.Boca_Shell.addr_risk_summary.turnover_1yr_in;
	add1_nhood_vacant_properties     := le.Boca_Shell.addr_risk_summary.n_vacant_properties;
	add1_nhood_business_count        := le.Boca_Shell.addr_risk_summary.n_business_count;
	add1_nhood_sfd_count             := le.Boca_Shell.addr_risk_summary.n_sfd_count;
	add1_nhood_mfd_count             := le.Boca_Shell.addr_risk_summary.n_mfd_count;
	add1_pop                         := le.Boca_Shell.addrpop;
	property_owned_total             := le.Boca_Shell.address_verification.owned.property_total;
	add2_lres                        := le.Boca_Shell.lres2;
	add2_avm_automated_valuation     := le.Boca_Shell.avm.address_history_1.avm_automated_valuation;
	add2_avm_automated_valuation_2   := le.Boca_Shell.avm.address_history_1.avm_automated_valuation2;
	add2_naprop                      := le.Boca_Shell.address_verification.address_history_1.naprop;
	add2_occupants_1yr               := le.Boca_Shell.addr_risk_summary2.occupants_1yr;
	add2_turnover_1yr_in             := le.Boca_Shell.addr_risk_summary2.turnover_1yr_in;
	add2_nhood_vacant_properties     := le.Boca_Shell.addr_risk_summary2.n_vacant_properties;
	add2_nhood_business_count        := le.Boca_Shell.addr_risk_summary2.n_business_count;
	add2_nhood_sfd_count             := le.Boca_Shell.addr_risk_summary2.n_sfd_count;
	add2_nhood_mfd_count             := le.Boca_Shell.addr_risk_summary2.n_mfd_count;
	add2_pop                         := le.Boca_Shell.addrpop2;
	add3_naprop                      := le.Boca_Shell.address_verification.address_history_2.naprop;
	avg_lres                         := le.Boca_Shell.other_address_info.avg_lres;
	max_lres                         := le.Boca_Shell.other_address_info.max_lres;
	addrs_5yr                        := le.Boca_Shell.other_address_info.addrs_last_5years;
	addrs_10yr                       := le.Boca_Shell.other_address_info.addrs_last_10years;
	addrs_15yr                       := le.Boca_Shell.other_address_info.addrs_last_15years;
	invalid_addrs_per_adl            := le.Boca_Shell.velocity_counters.invalid_addrs_per_adl;
	inq_count                        := le.Boca_Shell.acc_logs.inquiries.counttotal;
	inq_collection_count             := le.Boca_Shell.acc_logs.collection.counttotal;
	inq_mortgage_count               := le.Boca_Shell.acc_logs.mortgage.counttotal;
	inq_mortgage_count24             := le.Boca_Shell.acc_logs.mortgage.count24;
	inq_highriskcredit_count         := le.Boca_Shell.acc_logs.highriskcredit.counttotal;
	inq_highriskcredit_count01       := le.Boca_Shell.acc_logs.highriskcredit.count01;
	inq_highriskcredit_count03       := le.Boca_Shell.acc_logs.highriskcredit.count03;
	inq_highriskcredit_count06       := le.Boca_Shell.acc_logs.highriskcredit.count06;
	inq_highriskcredit_count12       := le.Boca_Shell.acc_logs.highriskcredit.count12;
	inq_highriskcredit_count24       := le.Boca_Shell.acc_logs.highriskcredit.count24;
	inq_communications_count         := le.Boca_Shell.acc_logs.communications.counttotal;
	inq_communications_count01       := le.Boca_Shell.acc_logs.communications.count01;
	inq_communications_count03       := le.Boca_Shell.acc_logs.communications.count03;
	inq_communications_count06       := le.Boca_Shell.acc_logs.communications.count06;
	inq_communications_count12       := le.Boca_Shell.acc_logs.communications.count12;
	inq_communications_count24       := le.Boca_Shell.acc_logs.communications.count24;
	inq_perssn                       := le.Boca_Shell.acc_logs.inquiryperssn;
	inq_lnamesperaddr                := le.Boca_Shell.acc_logs.inquirylnamesperaddr;
	inq_banko_am_first_seen          := le.Boca_Shell.acc_logs.am_first_seen_date;
	inq_banko_cm_first_seen          := le.Boca_Shell.acc_logs.cm_first_seen_date;
	inq_banko_cm_last_seen           := le.Boca_Shell.acc_logs.cm_last_seen_date;
	inq_banko_om_first_seen          := le.Boca_Shell.acc_logs.om_first_seen_date;
	paw_active_phone_count           := le.Boca_Shell.employment.business_active_phone_ct;
	email_count                      := le.Boca_Shell.email_summary.email_ct;
	fp_idrisktype                    := le.Boca_Shell.fdattributesv2.identityrisklevel;
	fp_idverrisktype                 := le.Boca_Shell.fdattributesv2.idverrisklevel;
	fp_varrisktype                   := le.Boca_Shell.fdattributesv2.variationrisklevel;
	fp_srchvelocityrisktype          := le.Boca_Shell.fdattributesv2.searchvelocityrisklevel;
	fp_srchunvrfdssncount            := le.Boca_Shell.fdattributesv2.searchunverifiedssncountyear;
	fp_srchunvrfdphonecount          := le.Boca_Shell.fdattributesv2.searchunverifiedphonecountyear;
	fp_srchfraudsrchcount            := le.Boca_Shell.fdattributesv2.searchfraudsearchcount;
	fp_assocsuspicousidcount         := le.Boca_Shell.fdattributesv2.assocsuspicousidentitiescount;
	fp_corraddrnamecount             := le.Boca_Shell.fdattributesv2.correlationaddrnamecount;
	fp_srchssnsrchcount              := le.Boca_Shell.fdattributesv2.searchssnsearchcount;
	fp_srchaddrsrchcount             := le.Boca_Shell.fdattributesv2.searchaddrsearchcount;
	fp_addrchangeincomediff          := le.Boca_Shell.fdattributesv2.addrchangeincomediff;
	fp_addrchangevaluediff           := le.Boca_Shell.fdattributesv2.addrchangevaluediff;
	fp_addrchangecrimediff           := le.Boca_Shell.fdattributesv2.addrchangecrimediff;
	fp_curraddrmedianincome          := le.Boca_Shell.fdattributesv2.curraddrmedianincome;
	fp_curraddrcartheftindex         := le.Boca_Shell.fdattributesv2.curraddrcartheftindex;
	fp_curraddrburglaryindex         := le.Boca_Shell.fdattributesv2.curraddrburglaryindex;
	fp_curraddrcrimeindex            := le.Boca_Shell.fdattributesv2.curraddrcrimeindex;
	fp_prevaddrcartheftindex         := le.Boca_Shell.fdattributesv2.prevaddrcartheftindex;
	bankrupt                         := le.Boca_Shell.bjl.bankrupt;
	disposition                      := le.Boca_Shell.bjl.disposition;
	filing_count                     := le.Boca_Shell.bjl.filing_count;
	liens_unrel_cj_first_seen        := le.Boca_Shell.liens.liens_unreleased_civil_judgment.earliest_filing_date;
	liens_unrel_cj_last_seen         := le.Boca_Shell.liens.liens_unreleased_civil_judgment.most_recent_filing_date;
	liens_unrel_sc_first_seen        := le.Boca_Shell.liens.liens_unreleased_small_claims.earliest_filing_date;
	felony_last_date                 := le.Boca_Shell.bjl.last_felony_date;
	rel_count                        := le.Boca_Shell.relatives.relative_count;
	rel_within25miles_count          := le.Boca_Shell.relatives.relative_within25miles_count;
	rel_within100miles_count         := le.Boca_Shell.relatives.relative_within100miles_count;
	rel_incomeunder75_count          := le.Boca_Shell.relatives.relative_incomeunder75_count;
	rel_incomeunder100_count         := le.Boca_Shell.relatives.relative_incomeunder100_count;
	rel_incomeover100_count          := le.Boca_Shell.relatives.relative_incomeover100_count;
	rel_homeunder300_count           := le.Boca_Shell.relatives.relative_homeunder300_count;
	rel_homeunder500_count           := le.Boca_Shell.relatives.relative_homeunder500_count;
	rel_homeover500_count            := le.Boca_Shell.relatives.relative_homeover500_count;
	rel_educationunder12_count       := le.Boca_Shell.relatives.relative_educationunder12_count;
	rel_educationover12_count        := le.Boca_Shell.relatives.relative_educationover12_count;
	wealth_index                     := le.Boca_Shell.wealth_indicator;
	estimated_income                 := le.Boca_Shell.estimated_income;

//End: ECL SAS mapping variables 

NULL := -999999999;


INTEGER contains_i( string haystack, string needle ) := (INTEGER)(StringLib.StringFind(haystack, needle, 1) > 0);


BOOLEAN indexw(string source, string target, string delim) :=
	(source = target) OR
	(StringLib.StringFind(source, delim + target + delim, 1) > 0) OR
	(source[1..length(target)+1] = target + delim) OR
	(StringLib.StringReverse(source)[1..length(target)+1] = StringLib.StringReverse(target) + delim);

INTEGER year(integer sas_date) :=
	if(sas_date = NULL, NULL, (integer)((ut.DateFrom_DaysSince1900(sas_date + ut.DaysSince1900('1960', '1', '1')))[1..4]));

sysdate := Models.common.sas_date(if(le.Boca_Shell.historydate=999999, (string8)Std.Date.Today(), (string6)le.Boca_Shell.historydate+'01'));
// for debug, to get a specific sysdate
// sysdate := Models.common.sas_date('20180522');

phone_pos_cr := Models.Common.findw_cpp(source_list, 'CR' , ',', 'E');

phone_pos_edaca := Models.Common.findw_cpp(source_list, 'EDACA' , ',', 'E');

phone_pos_edadid := Models.Common.findw_cpp(source_list, 'EDADID' , ',', 'E');

phone_pos_edafa := Models.Common.findw_cpp(source_list, 'EDAFA' , ',', 'E');

phone_pos_edafla := Models.Common.findw_cpp(source_list, 'EDAFLA' , ',', 'E');

phone_pos_edahistory := Models.Common.findw_cpp(source_list, 'EDAHistory' , ',', 'E');

phone_pos_edala := Models.Common.findw_cpp(source_list, 'EDALA' , ',', 'E');

phone_pos_edalfa := Models.Common.findw_cpp(source_list, 'EDALFA' , ',', 'E');

phone_pos_exp := Models.Common.findw_cpp(source_list, 'EXP' , ',', 'E');

phone_pos_inf := Models.Common.findw_cpp(source_list, 'INF' , ',', 'E');

phone_pos_input := Models.Common.findw_cpp(source_list, 'Input' , ',', 'E');

phone_pos_md := Models.Common.findw_cpp(source_list, 'MD' , ',', 'E');

phone_pos_ne := Models.Common.findw_cpp(source_list, 'NE' , ',', 'E');

phone_pos_paw := Models.Common.findw_cpp(source_list, 'PAW' , ',', 'E');

phone_pos_pde := Models.Common.findw_cpp(source_list, 'PDE' , ',', 'E');

phone_pos_pf := Models.Common.findw_cpp(source_list, 'PF' , ',', 'E');

phone_pos_pffla := Models.Common.findw_cpp(source_list, 'PFFLA' , ',', 'E');

phone_pos_pfla := Models.Common.findw_cpp(source_list, 'PFLA' , ',', 'E');

phone_pos_ppca := Models.Common.findw_cpp(source_list, 'PPCA' , ',', 'E');

phone_pos_ppdid := Models.Common.findw_cpp(source_list, 'PPDID' , ',', 'E');

phone_pos_ppfa := Models.Common.findw_cpp(source_list, 'PPFA' , ',', 'E');

phone_pos_ppfla := Models.Common.findw_cpp(source_list, 'PPFLA' , ',', 'E');

phone_pos_ppla := Models.Common.findw_cpp(source_list, 'PPLA' , ',', 'E');

phone_pos_pplfa := Models.Common.findw_cpp(source_list, 'PPLFA' , ',', 'E');

phone_pos_ppth := Models.Common.findw_cpp(source_list, 'PPTH' , ',', 'E');

phone_pos_rel := Models.Common.findw_cpp(source_list, 'REL' , ',', 'E');

phone_pos_rm := Models.Common.findw_cpp(source_list, 'RM' , ',', 'E');

phone_pos_sp := Models.Common.findw_cpp(source_list, 'SP' , ',', 'E');

phone_pos_sx := Models.Common.findw_cpp(source_list, 'SX' , ',', 'E');

phone_pos_utildid := Models.Common.findw_cpp(source_list, 'UtilDID' , ',', 'E');

source_cr := phone_pos_cr > 0;

source_edaca := phone_pos_edaca > 0;

source_edadid := phone_pos_edadid > 0;

source_edafa := phone_pos_edafa > 0;

source_edafla := phone_pos_edafla > 0;

source_edahistory := phone_pos_edahistory > 0;

source_edala := phone_pos_edala > 0;

source_edalfa := phone_pos_edalfa > 0;

source_exp := phone_pos_exp > 0;

source_inf := phone_pos_inf > 0;

source_input := phone_pos_input > 0;

source_md := phone_pos_md > 0;

source_ne := phone_pos_ne > 0;

source_paw := phone_pos_paw > 0;

source_pde := phone_pos_pde > 0;

source_pf := phone_pos_pf > 0;

source_pffla := phone_pos_pffla > 0;

source_pfla := phone_pos_pfla > 0;

source_ppca := phone_pos_ppca > 0;

source_ppdid := phone_pos_ppdid > 0;

source_ppfa := phone_pos_ppfa > 0;

source_ppfla := phone_pos_ppfla > 0;

source_ppla := phone_pos_ppla > 0;

source_pplfa := phone_pos_pplfa > 0;

source_ppth := phone_pos_ppth > 0;

source_rel := phone_pos_rel > 0;

source_rm := phone_pos_rm > 0;

source_sp := phone_pos_sp > 0;

source_sx := phone_pos_sx > 0;

source_utildid := phone_pos_utildid > 0;

source_edaca_lseen := Models.Common.getw(source_list_last_seen, phone_pos_edaca);

source_edaca_fseen := Models.Common.getw(source_list_first_seen, phone_pos_edaca);

source_edahistory_lseen := Models.Common.getw(source_list_last_seen, phone_pos_edahistory);

source_inf_fseen := Models.Common.getw(source_list_first_seen, phone_pos_inf);

source_md_fseen := Models.Common.getw(source_list_first_seen, phone_pos_md);

source_paw_lseen := Models.Common.getw(source_list_last_seen, phone_pos_paw);

source_paw_fseen := Models.Common.getw(source_list_first_seen, phone_pos_paw);

source_ppca_lseen := Models.Common.getw(source_list_last_seen, phone_pos_ppca);

source_ppca_fseen := Models.Common.getw(source_list_first_seen, phone_pos_ppca);

source_ppdid_lseen := Models.Common.getw(source_list_last_seen, phone_pos_ppdid);

source_ppdid_fseen := Models.Common.getw(source_list_first_seen, phone_pos_ppdid);

source_ppfla_lseen := Models.Common.getw(source_list_last_seen, phone_pos_ppfla);

source_ppfla_fseen := Models.Common.getw(source_list_first_seen, phone_pos_ppfla);

source_ppla_lseen := Models.Common.getw(source_list_last_seen, phone_pos_ppla);

source_ppla_fseen := Models.Common.getw(source_list_first_seen, phone_pos_ppla);

source_ppth_lseen := Models.Common.getw(source_list_last_seen, phone_pos_ppth);

source_ppth_fseen := Models.Common.getw(source_list_first_seen, phone_pos_ppth);

source_rm_fseen := Models.Common.getw(source_list_first_seen, phone_pos_rm);

source_sx_fseen := Models.Common.getw(source_list_first_seen, phone_pos_sx);

source_utildid_fseen := Models.Common.getw(source_list_first_seen, phone_pos_utildid);

source_pp_any_clean := max((integer)source_ppca, (integer)(integer)source_ppdid, (integer)(integer)source_ppfa, (integer)(integer)source_ppfla, (integer)(integer)source_ppla, (integer)(integer)source_pplfa);

number_of_sources := if(max((integer)source_cr, (integer)source_edaca, (integer)source_edadid, (integer)source_edafa, (integer)source_edafla, (integer)source_edahistory, (integer)source_edala, (integer)source_edalfa, (integer)source_exp, (integer)source_inf, (integer)source_input, (integer)source_md, (integer)source_ne, (integer)source_paw, (integer)source_pde, (integer)source_pf, (integer)source_pffla, (integer)source_pfla, (integer)source_ppca, (integer)source_ppdid, (integer)source_ppfa, (integer)source_ppfla, (integer)source_ppla, (integer)source_pplfa, (integer)source_ppth, (integer)source_rel, (integer)source_rm, (integer)source_sp, (integer)source_sx, (integer)source_utildid) = NULL, NULL, sum((integer)source_cr, (integer)source_edaca, (integer)source_edadid, (integer)source_edafa, (integer)source_edafla, (integer)source_edahistory, (integer)source_edala, (integer)source_edalfa, (integer)source_exp, (integer)source_inf, (integer)source_input, (integer)source_md, (integer)source_ne, (integer)source_paw, (integer)source_pde, (integer)source_pf, (integer)source_pffla, (integer)source_pfla, (integer)source_ppca, (integer)source_ppdid, (integer)source_ppfa, (integer)source_ppfla, (integer)source_ppla, (integer)source_pplfa, (integer)source_ppth, (integer)source_rel, (integer)source_rm, (integer)source_sp, (integer)source_sx, (integer)source_utildid));

source_edaca_lseen2 := Models.common.sas_date((string)(source_edaca_lseen));

mth_source_edaca_lseen := if(min(sysdate, source_edaca_lseen2) = NULL, NULL, roundup((sysdate - source_edaca_lseen2) / 30.5));

source_edaca_fseen2 := Models.common.sas_date((string)(source_edaca_fseen));

mth_source_edaca_fseen := if(min(sysdate, source_edaca_fseen2) = NULL, NULL, roundup((sysdate - source_edaca_fseen2) / 30.5));

source_edahistory_lseen2 := Models.common.sas_date((string)(source_edahistory_lseen));

mth_source_edahistory_lseen := if(min(sysdate, source_edahistory_lseen2) = NULL, NULL, roundup((sysdate - source_edahistory_lseen2) / 30.5));

source_inf_fseen2 := Models.common.sas_date((string)(source_inf_fseen));

mth_source_inf_fseen := if(min(sysdate, source_inf_fseen2) = NULL, NULL, roundup((sysdate - source_inf_fseen2) / 30.5));

source_md_fseen2 := Models.common.sas_date((string)(source_md_fseen));

mth_source_md_fseen := if(min(sysdate, source_md_fseen2) = NULL, NULL, roundup((sysdate - source_md_fseen2) / 30.5));

source_paw_lseen2 := Models.common.sas_date((string)(source_paw_lseen));

mth_source_paw_lseen := if(min(sysdate, source_paw_lseen2) = NULL, NULL, roundup((sysdate - source_paw_lseen2) / 30.5));

source_paw_fseen2 := Models.common.sas_date((string)(source_paw_fseen));

mth_source_paw_fseen := if(min(sysdate, source_paw_fseen2) = NULL, NULL, roundup((sysdate - source_paw_fseen2) / 30.5));

source_ppca_lseen2 := Models.common.sas_date((string)(source_ppca_lseen));

mth_source_ppca_lseen := if(min(sysdate, source_ppca_lseen2) = NULL, NULL, roundup((sysdate - source_ppca_lseen2) / 30.5));

source_ppca_fseen2 := Models.common.sas_date((string)(source_ppca_fseen));

mth_source_ppca_fseen := if(min(sysdate, source_ppca_fseen2) = NULL, NULL, roundup((sysdate - source_ppca_fseen2) / 30.5));

source_ppdid_lseen2 := Models.common.sas_date((string)(source_ppdid_lseen));

mth_source_ppdid_lseen := if(min(sysdate, source_ppdid_lseen2) = NULL, NULL, roundup((sysdate - source_ppdid_lseen2) / 30.5));

source_ppdid_fseen2 := Models.common.sas_date((string)(source_ppdid_fseen));

mth_source_ppdid_fseen := if(min(sysdate, source_ppdid_fseen2) = NULL, NULL, roundup((sysdate - source_ppdid_fseen2) / 30.5));

source_ppfla_lseen2 := Models.common.sas_date((string)(source_ppfla_lseen));

mth_source_ppfla_lseen := if(min(sysdate, source_ppfla_lseen2) = NULL, NULL, roundup((sysdate - source_ppfla_lseen2) / 30.5));

source_ppfla_fseen2 := Models.common.sas_date((string)(source_ppfla_fseen));

mth_source_ppfla_fseen := if(min(sysdate, source_ppfla_fseen2) = NULL, NULL, roundup((sysdate - source_ppfla_fseen2) / 30.5));

source_ppla_lseen2 := Models.common.sas_date((string)(source_ppla_lseen));

mth_source_ppla_lseen := if(min(sysdate, source_ppla_lseen2) = NULL, NULL, roundup((sysdate - source_ppla_lseen2) / 30.5));

source_ppla_fseen2 := Models.common.sas_date((string)(source_ppla_fseen));

mth_source_ppla_fseen := if(min(sysdate, source_ppla_fseen2) = NULL, NULL, roundup((sysdate - source_ppla_fseen2) / 30.5));

source_ppth_lseen2 := Models.common.sas_date((string)(source_ppth_lseen));

mth_source_ppth_lseen := if(min(sysdate, source_ppth_lseen2) = NULL, NULL, roundup((sysdate - source_ppth_lseen2) / 30.5));

source_ppth_fseen2 := Models.common.sas_date((string)(source_ppth_fseen));

mth_source_ppth_fseen := if(min(sysdate, source_ppth_fseen2) = NULL, NULL, roundup((sysdate - source_ppth_fseen2) / 30.5));

source_rm_fseen2 := Models.common.sas_date((string)(source_rm_fseen));

mth_source_rm_fseen := if(min(sysdate, source_rm_fseen2) = NULL, NULL, roundup((sysdate - source_rm_fseen2) / 30.5));

source_sx_fseen2 := Models.common.sas_date((string)(source_sx_fseen));

mth_source_sx_fseen := if(min(sysdate, source_sx_fseen2) = NULL, NULL, roundup((sysdate - source_sx_fseen2) / 30.5));

source_utildid_fseen2 := Models.common.sas_date((string)(source_utildid_fseen));

mth_source_utildid_fseen := if(min(sysdate, source_utildid_fseen2) = NULL, NULL, roundup((sysdate - source_utildid_fseen2) / 30.5));

eda_dt_first_seen2 := Models.common.sas_date((string)(eda_dt_first_seen));

mth_eda_dt_first_seen := if(min(sysdate, eda_dt_first_seen2) = NULL, NULL, roundup((sysdate - eda_dt_first_seen2) / 30.5));

eda_dt_last_seen2 := Models.common.sas_date((string)(eda_dt_last_seen));

mth_eda_dt_last_seen := if(min(sysdate, eda_dt_last_seen2) = NULL, NULL, roundup((sysdate - eda_dt_last_seen2) / 30.5));

eda_deletion_date2 := Models.common.sas_date((string)(eda_deletion_date));

mth_eda_deletion_date := if(min(sysdate, eda_deletion_date2) = NULL, NULL, roundup((sysdate - eda_deletion_date2) / 30.5));

exp_last_update2 := Models.common.sas_date((string)(exp_last_update));

mth_exp_last_update := if(min(sysdate, exp_last_update2) = NULL, NULL, roundup((sysdate - exp_last_update2) / 30.5));

internal_ver_first_seen2 := Models.common.sas_date((string)(internal_ver_first_seen));

mth_internal_ver_first_seen := if(min(sysdate, internal_ver_first_seen2) = NULL, NULL, roundup((sysdate - internal_ver_first_seen2) / 30.5));

internal_ver_last_seen2 := Models.common.sas_date((string)(internal_ver_last_seen));

mth_internal_ver_last_seen := if(min(sysdate, internal_ver_last_seen2) = NULL, NULL, roundup((sysdate - internal_ver_last_seen2) / 30.5));

phone_fb_rp_date2 := Models.common.sas_date((string)(phone_fb_rp_date));

mth_phone_fb_rp_date := if(min(sysdate, phone_fb_rp_date2) = NULL, NULL, roundup((sysdate - phone_fb_rp_date2) / 30.5));

pp_datefirstseen2 := Models.common.sas_date((string)(pp_datefirstseen));

mth_pp_datefirstseen := if(min(sysdate, pp_datefirstseen2) = NULL, NULL, roundup((sysdate - pp_datefirstseen2) / 30.5));

pp_datelastseen2 := Models.common.sas_date((string)(pp_datelastseen));

mth_pp_datelastseen := if(min(sysdate, pp_datelastseen2) = NULL, NULL, roundup((sysdate - pp_datelastseen2) / 30.5));

pp_datevendorfirstseen2 := Models.common.sas_date((string)(pp_datevendorfirstseen));

mth_pp_datevendorfirstseen := if(min(sysdate, pp_datevendorfirstseen2) = NULL, NULL, roundup((sysdate - pp_datevendorfirstseen2) / 30.5));

pp_orig_lastseen2 := Models.common.sas_date((string)(pp_orig_lastseen));

mth_pp_orig_lastseen := if(min(sysdate, pp_orig_lastseen2) = NULL, NULL, roundup((sysdate - pp_orig_lastseen2) / 30.5));

pp_app_npa_effective_dt2 := Models.common.sas_date((string)(pp_app_npa_effective_dt));

mth_pp_app_npa_effective_dt := if(min(sysdate, pp_app_npa_effective_dt2) = NULL, NULL, roundup((sysdate - pp_app_npa_effective_dt2) / 30.5));

pp_app_npa_last_change_dt2 := Models.common.sas_date((string)(pp_app_npa_last_change_dt));

mth_pp_app_npa_last_change_dt := if(min(sysdate, pp_app_npa_last_change_dt2) = NULL, NULL, roundup((sysdate - pp_app_npa_last_change_dt2) / 30.5));

pp_eda_hist_ph_dt2 := Models.common.sas_date((string)(PP_EDA_Hist_ph_dt));

mth_pp_eda_hist_ph_dt := if(min(sysdate, pp_eda_hist_ph_dt2) = NULL, NULL, roundup((sysdate - pp_eda_hist_ph_dt2) / 30.5));

pp_eda_hist_did_dt2 := Models.common.sas_date((string)(PP_EDA_Hist_did_dt));

mth_pp_eda_hist_did_dt := if(min(sysdate, pp_eda_hist_did_dt2) = NULL, NULL, roundup((sysdate - pp_eda_hist_did_dt2) / 30.5));

pp_eda_hist_nm_addr_dt2 := Models.common.sas_date((string)(PP_EDA_Hist_nm_addr_dt));

mth_pp_eda_hist_nm_addr_dt := if(min(sysdate, pp_eda_hist_nm_addr_dt2) = NULL, NULL, roundup((sysdate - pp_eda_hist_nm_addr_dt2) / 30.5));

pp_first_build_date2 := Models.common.sas_date((string)(pp_first_build_date));

mth_pp_first_build_date := if(min(sysdate, pp_first_build_date2) = NULL, NULL, roundup((sysdate - pp_first_build_date2) / 30.5));

_phone_match_code_a := (integer)indexw(trim(phone_match_code, ALL), 'A', ',') > 0;

_phone_match_code_c := (integer)indexw(trim(phone_match_code, ALL), 'C', ',') > 0;

_phone_match_code_l := (integer)indexw(trim(phone_match_code, ALL), 'L', ',') > 0;

_phone_match_code_n := (integer)indexw(trim(phone_match_code, ALL), 'N', ',') > 0;

_phone_match_code_s := (integer)indexw(trim(phone_match_code, ALL), 'S', ',') > 0;

_phone_match_code_t := (integer)indexw(trim(phone_match_code, ALL), 'T', ',') > 0;

_phone_match_code_z := (integer)indexw(trim(phone_match_code, ALL), 'Z', ',') > 0;

_pp_rule_disconnected_eda_1 := 0;

_pp_rule_non_pub_1 := 0;

_pp_rule_port_neustar_1 := 0;

_pp_rule_high_vend_conf_1 := 0;

_pp_rule_cellphone_latest_1 := 0;

_pp_rule_source_latest_1 := 0;

_pp_rule_med_vend_conf_cell_1 := 0;

_pp_rule_gong_disc_1 := 0;

_pp_rule_consort_disc_1 := 0;

_pp_rule_f1_ver_above_1 := 0;

_pp_rule_disconnected_eda := if((pp_rules)[3..3] = '1', 1, _pp_rule_disconnected_eda_1);

_pp_rule_non_pub := if((pp_rules)[4..4] = '1', 1, _pp_rule_non_pub_1);

_pp_rule_port_neustar := if((pp_rules)[5..5] = '1', 1, _pp_rule_port_neustar_1);

_pp_rule_high_vend_conf := if((pp_rules)[7..7] = '1', 1, _pp_rule_high_vend_conf_1);

_pp_rule_cellphone_latest := if((pp_rules)[9..9] = '1', 1, _pp_rule_cellphone_latest_1);

_pp_rule_source_latest := if((pp_rules)[14..14] = '1', 1, _pp_rule_source_latest_1);

_pp_rule_med_vend_conf_cell := if((pp_rules)[15..15] = '1', 1, _pp_rule_med_vend_conf_cell_1);

_pp_rule_gong_disc := if((pp_rules)[21..21] = '1', 1, _pp_rule_gong_disc_1);

_pp_rule_consort_disc := if((pp_rules)[22..22] = '1', 1, _pp_rule_consort_disc_1);

_pp_rule_f1_ver_above := if((pp_rules)[28..28] = '1', 1, _pp_rule_f1_ver_above_1);

_pp_src_all_uw_1 := 0;

_pp_src_all_uw := if((PP_Src_All)[14..14] = '1', 1, _pp_src_all_uw_1);

_pp_srule_port_neustar_1 := 0;

_pp_srule_port_neustar := if((PP_Src_Rule)[5..5] = '1', 1, _pp_srule_port_neustar_1);

inq_firstseen_n := if(inq_firstseen='',NULL,(integer)inq_firstseen);

inq_lastseen_n := if(inq_lastseen='',NULL,(integer)inq_lastseen);

inq_adl_firstseen_n := if(inq_adl_firstseen='',NULL,(integer)inq_adl_firstseen);

inq_adl_lastseen_n := if(inq_adl_lastseen='',NULL,(integer)inq_adl_lastseen);

internal_ver_match_type := ' ';

_internal_ver_match_hhid := (integer)indexw(trim(internal_ver_match_types, ALL), '3', ',') > 0;

_inq_adl_ph_industry_flag := trim(StringLib.StringFilterOut((string)inq_adl_ph_industry_list_12, ','), LEFT, RIGHT) != '';

_phone_disconnected := if(phone_disconnected < 1, 0, 1);

_phone_zip_match := if(phone_zip_match < 1, 0, 1);

_phone_timezone_match := if(phone_timezone_match < 1, 0, 1);

_phone_fb_rp_result := map(
    phone_fb_rp_result < 3 => 0,
    phone_fb_rp_result < 9 => 1,
                              2);

_pp_app_fb_ph_disc := if(PP_app_fb_ph = 4, 1, 0);

_pp_app_fb_ph7_did_disc := if(PP_app_fb_ph7_DID = 4, 1, 0);

_pp_app_fb_ph7_nm_addr_disc := if(PP_app_fb_ph7_NM_Addr = 4, 1, 0);

_phone_fb_result_disc := if(Phone_fb_Result = 4, 1, 0);

_phone_fb_rp_result_disc := if(Phone_fb_RP_Result = 4, 1, 0);

_pp_rule_disc_flag := if(if(max(_pp_rule_disconnected_eda, _pp_rule_gong_disc, _pp_rule_consort_disc) = NULL, NULL, sum(if(_pp_rule_disconnected_eda = NULL, 0, _pp_rule_disconnected_eda), if(_pp_rule_gong_disc = NULL, 0, _pp_rule_gong_disc), if(_pp_rule_consort_disc = NULL, 0, _pp_rule_consort_disc))) > 0, 1, 0);

_pp_app_fb_disc_flag := if(if(max(_pp_app_fb_ph_disc, _pp_app_fb_ph7_did_disc, _pp_app_fb_ph7_nm_addr_disc) = NULL, NULL, sum(if(_pp_app_fb_ph_disc = NULL, 0, _pp_app_fb_ph_disc), if(_pp_app_fb_ph7_did_disc = NULL, 0, _pp_app_fb_ph7_did_disc), if(_pp_app_fb_ph7_nm_addr_disc = NULL, 0, _pp_app_fb_ph7_nm_addr_disc))) > 0, 1, 0);

_phone_fb_disc_flag := if(if(max(_phone_fb_result_disc, _phone_fb_rp_result_disc) = NULL, NULL, sum(if(_phone_fb_result_disc = NULL, 0, _phone_fb_result_disc), if(_phone_fb_rp_result_disc = NULL, 0, _phone_fb_rp_result_disc))) > 0, 1, 0);

pk_disconnect_flag := map(
    if(max(_phone_disconnected, _pp_rule_disc_flag, _pp_app_fb_disc_flag, _phone_fb_disc_flag) = NULL, NULL, sum(if(_phone_disconnected = NULL, 0, _phone_disconnected), if(_pp_rule_disc_flag = NULL, 0, _pp_rule_disc_flag), if(_pp_app_fb_disc_flag = NULL, 0, _pp_app_fb_disc_flag), if(_phone_fb_disc_flag = NULL, 0, _phone_fb_disc_flag))) = 4 => 4,
    _phone_disconnected = 1 and if(max(_pp_rule_disc_flag, _pp_app_fb_disc_flag, _phone_fb_disc_flag) = NULL, NULL, sum(if(_pp_rule_disc_flag = NULL, 0, _pp_rule_disc_flag), if(_pp_app_fb_disc_flag = NULL, 0, _pp_app_fb_disc_flag), if(_phone_fb_disc_flag = NULL, 0, _phone_fb_disc_flag))) >= 1                                                 => 3,
    _phone_disconnected = 1                                                                                                                                                                                                                                                                                                                           => 2,
    if(max(_pp_rule_disc_flag, _pp_app_fb_disc_flag, _phone_fb_disc_flag) = NULL, NULL, sum(if(_pp_rule_disc_flag = NULL, 0, _pp_rule_disc_flag), if(_pp_app_fb_disc_flag = NULL, 0, _pp_app_fb_disc_flag), if(_phone_fb_disc_flag = NULL, 0, _phone_fb_disc_flag))) >= 1                                                                             => 1,
                                                                                                                                                                                                                                                                                                                                                         0);

_phone_match_code_lns := if(max((integer)_phone_match_code_l, (integer)_phone_match_code_n, (integer)_phone_match_code_s) = NULL, NULL, sum((integer)_phone_match_code_l, (integer)_phone_match_code_n, (integer)_phone_match_code_s)) > 0;

_phone_match_code_tcza := map(
    _phone_match_code_t and _phone_match_code_c and _phone_match_code_z and _phone_match_code_a => 4,
    _phone_match_code_t and _phone_match_code_c                                                 => 3,
    _phone_match_code_t                                                                         => 2,
    _phone_match_code_c or _phone_match_code_z or _phone_match_code_a                           => 1,
                                                                                                   0);

pk_phone_match_level := map(
    _phone_match_code_lns and _phone_match_code_tcza = 4 => 4,
    _phone_match_code_lns and _phone_match_code_tcza > 0 => 3,
    _phone_match_code_lns                                => 2,
    _phone_match_code_tcza > 0                           => 1,
                                                            0);

_pp_app_coctype_landline := if((trim(trim((string)pp_app_coctype, LEFT), LEFT, RIGHT) in ['EOC']), 1, 0);

_pp_app_coctype_cell := map(
    (trim(trim((string)pp_app_coctype, LEFT), LEFT, RIGHT) in ['PMC', 'RCC', 'SP1', 'SP2']) and (trim(trim((string)PP_app_SCC, LEFT), LEFT, RIGHT) in ['C', 'R', 'S']) => 1,
    (trim(trim((string)pp_app_coctype, LEFT), LEFT, RIGHT) in ['EOC']) and (trim(trim((string)PP_app_SCC, LEFT), LEFT, RIGHT) in ['C', 'R'])                           => 1,
                                                                                                                                                                          0);

_phone_switch_type_cell := if(trim(trim((string)Phone_Switch_Type, LEFT), LEFT, RIGHT) = 'C', 1, 0);

_pp_app_nxx_type_cell := if((trim(pp_app_nxx_type) in ['04', '55', '65']), 1, 0);

_pp_app_ph_type_cell := if((trim(trim((string)PP_app_ph_Type, LEFT), LEFT, RIGHT) in ['CELL', 'LNDLN PRTD TO CELL']), 1, 0);

_pp_app_company_type_cell := if((PP_app_Company_Type in [5, 8]), 1, 0);

_exp_type_cell := if(trim(trim((string)Exp_Type, LEFT), LEFT, RIGHT) = 'C', 1, 0);

pk_cell_indicator := map(
    _exp_type_cell > 0 and if(max(_phone_switch_type_cell, _pp_rule_cellphone_latest, _pp_rule_med_vend_conf_cell, _pp_app_coctype_cell, _pp_app_nxx_type_cell, _pp_app_ph_type_cell, _pp_app_company_type_cell) = NULL, NULL, sum(if(_phone_switch_type_cell = NULL, 0, _phone_switch_type_cell), if(_pp_rule_cellphone_latest = NULL, 0, _pp_rule_cellphone_latest), if(_pp_rule_med_vend_conf_cell = NULL, 0, _pp_rule_med_vend_conf_cell), if(_pp_app_coctype_cell = NULL, 0, _pp_app_coctype_cell), if(_pp_app_nxx_type_cell = NULL, 0, _pp_app_nxx_type_cell), if(_pp_app_ph_type_cell = NULL, 0, _pp_app_ph_type_cell), if(_pp_app_company_type_cell = NULL, 0, _pp_app_company_type_cell))) > 0 => 4,
    if(max(_phone_switch_type_cell, _pp_rule_cellphone_latest, _pp_rule_med_vend_conf_cell, _pp_app_coctype_cell, _pp_app_nxx_type_cell, _pp_app_ph_type_cell, _pp_app_company_type_cell) = NULL, NULL, sum(if(_phone_switch_type_cell = NULL, 0, _phone_switch_type_cell), if(_pp_rule_cellphone_latest = NULL, 0, _pp_rule_cellphone_latest), if(_pp_rule_med_vend_conf_cell = NULL, 0, _pp_rule_med_vend_conf_cell), if(_pp_app_coctype_cell = NULL, 0, _pp_app_coctype_cell), if(_pp_app_nxx_type_cell = NULL, 0, _pp_app_nxx_type_cell), if(_pp_app_ph_type_cell = NULL, 0, _pp_app_ph_type_cell), if(_pp_app_company_type_cell = NULL, 0, _pp_app_company_type_cell))) = 7                        => 3,
    _phone_switch_type_cell = 1 and _pp_rule_cellphone_latest = 1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       => 2,
    _phone_switch_type_cell = 1 and _pp_rule_med_vend_conf_cell = 1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                     => 1,
    _pp_app_coctype_landline = 1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        => -1,
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           0);

add_input_pop := add1_pop;

add_curr_pop := if(add1_isbestmatch, add1_pop, add2_pop);

add_curr_naprop := if(add1_isbestmatch, add1_naprop, add2_naprop);

add_input_avm_auto_val := add1_avm_automated_valuation;

add_curr_avm_auto_val := if(add1_isbestmatch, add1_avm_automated_valuation, add2_avm_automated_valuation);

add_curr_lres := if(add1_isbestmatch, add1_lres, add2_lres);

add_curr_avm_auto_val_2 := if(add1_isbestmatch, add1_avm_automated_valuation_2, add2_avm_automated_valuation_2);

add_input_naprop := add1_naprop;

add_prev_naprop := if(add1_isbestmatch, add2_naprop, add3_naprop);

add_input_occupants_1yr := add1_occupants_1yr;

add_input_turnover_1yr_in := add1_turnover_1yr_in;

add_input_turnover_1yr_out := add1_turnover_1yr_in;

add_input_nhood_bus_ct := add1_Nhood_Business_count;

add_input_nhood_sfd_ct := add1_Nhood_SFD_count;

add_input_nhood_mfd_ct := add1_Nhood_MFD_count;

add_curr_occupants_1yr := if(add1_isbestmatch, add1_occupants_1yr, add2_occupants_1yr);

add_curr_turnover_1yr_in := if(add1_isbestmatch, add1_turnover_1yr_in, add2_turnover_1yr_in);

add_curr_turnover_1yr_out := if(add1_isbestmatch, add1_turnover_1yr_in, add2_turnover_1yr_in);

add_curr_nhood_bus_ct := if(add1_isbestmatch, add1_Nhood_Business_count, add2_Nhood_Business_count);

add_curr_nhood_sfd_ct := if(add1_isbestmatch, add1_Nhood_SFD_count, add2_Nhood_SFD_count);

add_curr_nhood_mfd_ct := if(add1_isbestmatch, add1_Nhood_MFD_count, add2_Nhood_MFD_count);

add_curr_nhood_vac_prop := if(add1_isbestmatch, add1_Nhood_Vacant_Properties, add2_Nhood_Vacant_Properties);

_felony_last_date := Models.common.sas_date((string)(felony_last_date));

r_d32_mos_since_fel_ls_d := map(
    not(truedid)             => NULL,
    _felony_last_date = NULL => 241,
                                max(3, min(if(if ((sysdate - _felony_last_date) / (365.25 / 12) >= 0, truncate((sysdate - _felony_last_date) / (365.25 / 12)), roundup((sysdate - _felony_last_date) / (365.25 / 12))) = NULL, -NULL, if ((sysdate - _felony_last_date) / (365.25 / 12) >= 0, truncate((sysdate - _felony_last_date) / (365.25 / 12)), roundup((sysdate - _felony_last_date) / (365.25 / 12)))), 240)));

r_d31_mostrec_bk_i := map(
    not(truedid)                                    => NULL,
    contains_i(StringLib.StringToUpperCase(disposition), 'DISMISS') = 1  => 1,
    contains_i(StringLib.StringToUpperCase(disposition), 'DISCHARG') = 1 => 2,
    bankrupt or filing_count > 0                => 3,
                                                       0);

bureau_adl_eq_fseen_pos := Models.Common.findw_cpp(ver_sources, 'EQ' , ', ', 'E');

bureau_adl_fseen_eq := if(bureau_adl_eq_fseen_pos = 0, '       0', Models.Common.getw(ver_sources_first_seen, bureau_adl_eq_fseen_pos, ','));

_bureau_adl_fseen_eq := Models.common.sas_date((string)(bureau_adl_fseen_eq));

_src_bureau_adl_fseen := min(if(_bureau_adl_fseen_eq = NULL, -NULL, _bureau_adl_fseen_eq), 999999);

r_c21_m_bureau_adl_fs_d := map(
    not(truedid)                   => NULL,
    _src_bureau_adl_fseen = 999999 => 1000,
                                      min(if(if ((sysdate - _src_bureau_adl_fseen) / (365.25 / 12) >= 0, truncate((sysdate - _src_bureau_adl_fseen) / (365.25 / 12)), roundup((sysdate - _src_bureau_adl_fseen) / (365.25 / 12))) = NULL, -NULL, if ((sysdate - _src_bureau_adl_fseen) / (365.25 / 12) >= 0, truncate((sysdate - _src_bureau_adl_fseen) / (365.25 / 12)), roundup((sysdate - _src_bureau_adl_fseen) / (365.25 / 12)))), 999));

bureau_adl_en_fseen_pos := Models.Common.findw_cpp(ver_sources, 'EN' , ',', 'E');

bureau_adl_fseen_en := if(bureau_adl_en_fseen_pos = 0, '       0', Models.Common.getw(ver_sources_first_seen, bureau_adl_en_fseen_pos, ','));

_bureau_adl_fseen_en := Models.common.sas_date((string)(bureau_adl_fseen_en));

bureau_adl_ts_fseen_pos := Models.Common.findw_cpp(ver_sources, 'TS' , ',', 'E');

bureau_adl_fseen_ts := if(bureau_adl_ts_fseen_pos = 0, '       0', Models.Common.getw(ver_sources_first_seen, bureau_adl_ts_fseen_pos, ','));

_bureau_adl_fseen_ts := Models.common.sas_date((string)(bureau_adl_fseen_ts));

bureau_adl_tu_fseen_pos := Models.Common.findw_cpp(ver_sources, 'TU' , ',', 'E');

bureau_adl_fseen_tu := if(bureau_adl_tu_fseen_pos = 0, '       0', Models.Common.getw(ver_sources_first_seen, bureau_adl_tu_fseen_pos, ','));

_bureau_adl_fseen_tu := Models.common.sas_date((string)(bureau_adl_fseen_tu));

bureau_adl_tn_fseen_pos := Models.Common.findw_cpp(ver_sources, 'TN' , ',', 'E');

bureau_adl_fseen_tn := if(bureau_adl_tn_fseen_pos = 0, '       0', Models.Common.getw(ver_sources_first_seen, bureau_adl_tn_fseen_pos, ','));

_bureau_adl_fseen_tn := Models.common.sas_date((string)(bureau_adl_fseen_tn));

_src_bureau_adl_fseen_all := min(if(_bureau_adl_fseen_tn = NULL, -NULL, _bureau_adl_fseen_tn), if(_bureau_adl_fseen_ts = NULL, -NULL, _bureau_adl_fseen_ts), if(_bureau_adl_fseen_tu = NULL, -NULL, _bureau_adl_fseen_tu), if(_bureau_adl_fseen_en = NULL, -NULL, _bureau_adl_fseen_en), if(_bureau_adl_fseen_eq = NULL, -NULL, _bureau_adl_fseen_eq), 999999);

f_m_bureau_adl_fs_all_d := map(
    not(truedid)                       => NULL,
    _src_bureau_adl_fseen_all = 999999 => 1000,
                                          min(if(if ((sysdate - _src_bureau_adl_fseen_all) / (365.25 / 12) >= 0, truncate((sysdate - _src_bureau_adl_fseen_all) / (365.25 / 12)), roundup((sysdate - _src_bureau_adl_fseen_all) / (365.25 / 12))) = NULL, -NULL, if ((sysdate - _src_bureau_adl_fseen_all) / (365.25 / 12) >= 0, truncate((sysdate - _src_bureau_adl_fseen_all) / (365.25 / 12)), roundup((sysdate - _src_bureau_adl_fseen_all) / (365.25 / 12)))), 999));

r_a44_curr_add_naprop_d := if(not(truedid and (boolean)(integer)add_curr_pop), NULL, add_curr_naprop);

r_l80_inp_avm_autoval_d := map(
    not(add_input_pop)         => NULL,
    add_input_avm_auto_val = 0 => NULL,
                                  min(if(add_input_avm_auto_val = NULL, -NULL, add_input_avm_auto_val), 300000));

r_a49_curr_avm_chg_1yr_i := map(
    not(truedid)                                              => NULL,
    add_curr_lres < 12                                        => NULL,
    add_curr_avm_auto_val > 0 and add_curr_avm_auto_val_2 > 0 => add_curr_avm_auto_val - add_curr_avm_auto_val_2,
                                                                 NULL);

r_a49_curr_avm_chg_1yr_pct_i := map(
    not(truedid)                                              => NULL,
    add_curr_lres < 12                                        => NULL,
    add_curr_avm_auto_val > 0 and add_curr_avm_auto_val_2 > 0 => round(100 * add_curr_avm_auto_val / add_curr_avm_auto_val_2/0.1)*0.1,
                                                                 NULL);

r_c13_max_lres_d := if(not(truedid), NULL, min(if(max_lres = NULL, -NULL, max_lres), 999));

r_c14_addrs_5yr_i := if(not(truedid), NULL, min(if(addrs_5yr = NULL, -NULL, addrs_5yr), 999));

r_c14_addrs_10yr_i := if(not(truedid), NULL, min(if(addrs_10yr = NULL, -NULL, addrs_10yr), 999));

r_c14_addrs_15yr_i := if(not(truedid), NULL, min(if(addrs_15yr = NULL, -NULL, addrs_15yr), 999));

r_a41_prop_owner_d := map(
    not(truedid)                                                                                   => NULL,
    add_input_naprop = 4 or add_curr_naprop = 4 or add_prev_naprop = 4 or property_owned_total > 0 => 1,
                                                                                                      0);

r_prop_owner_history_d := map(
    not(truedid)                                                                     => NULL,
    add_input_naprop = 4 or add_curr_naprop = 4 or property_owned_total > 0          => 2,
    add_prev_naprop = 4 or Models.Common.findw_cpp(ver_sources, 'P' , ', ', 'E') > 0 => 1,
                                                                                        0);

r_c20_email_count_i := if(not(truedid), NULL, min(if(email_count = NULL, -NULL, email_count), 999));

r_c18_invalid_addrs_per_adl_i := if(not(truedid), NULL, min(if(invalid_addrs_per_adl = NULL, -NULL, invalid_addrs_per_adl), 999));

r_i60_inq_hiriskcred_recency_d := map(
    not(truedid)               => NULL,
    inq_highRiskCredit_count01 > 0 => 1,
    inq_highRiskCredit_count03 > 0 => 3,
    inq_highRiskCredit_count06 > 0 => 6,
    inq_highRiskCredit_count12 > 0 => 12,
    inq_highRiskCredit_count24 > 0 => 24,
    inq_highRiskCredit_count > 0   => 99,
                                      999);

r_i60_inq_comm_recency_d := map(
    not(truedid)               => NULL,
    inq_communications_count01 > 0 => 1,
    inq_communications_count03 > 0 => 3,
    inq_communications_count06 > 0 => 6,
    inq_communications_count12 > 0 => 12,
    inq_communications_count24 > 0 => 24,
    inq_communications_count > 0   => 99,
                                      999);

f_util_adl_count_n := if(not(truedid), NULL, util_adl_count);

f_add_input_mobility_index_n := map(
    not(addrpop)                 => NULL,
    add_input_occupants_1yr <= 0 => NULL,
                                    if(max(add_input_turnover_1yr_in, add_input_turnover_1yr_out) = NULL, NULL, sum(if(add_input_turnover_1yr_in = NULL, 0, add_input_turnover_1yr_in), if(add_input_turnover_1yr_out = NULL, 0, add_input_turnover_1yr_out))) / add_input_occupants_1yr);

add_input_nhood_prop_sum := if(max(add_input_nhood_bus_ct, add_input_nhood_sfd_ct, add_input_nhood_mfd_ct) = NULL, NULL, sum(if(add_input_nhood_bus_ct = NULL, 0, add_input_nhood_bus_ct), if(add_input_nhood_sfd_ct = NULL, 0, add_input_nhood_sfd_ct), if(add_input_nhood_mfd_ct = NULL, 0, add_input_nhood_mfd_ct)));

f_add_input_nhood_bus_pct_i := map(
    not(addrpop)               => NULL,
    add_input_nhood_bus_ct = 0 => NULL,
                                  add_input_nhood_bus_ct / add_input_nhood_prop_sum);

f_add_input_nhood_mfd_pct_i := map(
    not(addrpop)               => NULL,
    add_input_nhood_mfd_ct = 0 => NULL,
                                  add_input_nhood_mfd_ct / add_input_nhood_prop_sum);

f_add_input_nhood_sfd_pct_d := map(
    not(addrpop)               => NULL,
    add_input_nhood_sfd_ct = 0 => -1,
                                  add_input_nhood_sfd_ct / add_input_nhood_prop_sum);

f_add_curr_mobility_index_n := map(
    not(addrpop)                => NULL,
    add_curr_occupants_1yr <= 0 => NULL,
                                   if(max(add_curr_turnover_1yr_in, add_curr_turnover_1yr_out) = NULL, NULL, sum(if(add_curr_turnover_1yr_in = NULL, 0, add_curr_turnover_1yr_in), if(add_curr_turnover_1yr_out = NULL, 0, add_curr_turnover_1yr_out))) / add_curr_occupants_1yr);

add_curr_nhood_prop_sum := if(max(add_curr_nhood_bus_ct, add_curr_nhood_sfd_ct, add_curr_nhood_mfd_ct) = NULL, NULL, sum(if(add_curr_nhood_bus_ct = NULL, 0, add_curr_nhood_bus_ct), if(add_curr_nhood_sfd_ct = NULL, 0, add_curr_nhood_sfd_ct), if(add_curr_nhood_mfd_ct = NULL, 0, add_curr_nhood_mfd_ct)));

f_add_curr_nhood_bus_pct_i := map(
    not(addrpop)              => NULL,
    add_curr_nhood_bus_ct = 0 => NULL,
                                 add_curr_nhood_bus_ct / add_curr_nhood_prop_sum);

f_add_curr_nhood_mfd_pct_i := map(
    not(addrpop)              => NULL,
    add_curr_nhood_mfd_ct = 0 => NULL,
                                 add_curr_nhood_mfd_ct / add_curr_nhood_prop_sum);

f_add_curr_nhood_sfd_pct_d := map(
    not(addrpop)              => NULL,
    add_curr_nhood_sfd_ct = 0 => -1,
                                 add_curr_nhood_sfd_ct / add_curr_nhood_prop_sum);

f_add_curr_nhood_vac_pct_i := map(
    not(addrpop)                => NULL,
    add_curr_nhood_prop_sum = 0 => -1,
                                   add_curr_nhood_vac_prop / add_curr_nhood_prop_sum);

f_inq_count_i := if(not(truedid), NULL, min(if(inq_count = NULL, -NULL, inq_count), 999));

f_inq_collection_count_i := if(not(truedid), NULL, min(if(inq_Collection_count = NULL, -NULL, inq_Collection_count), 999));

f_inq_communications_count_i := if(not(truedid), NULL, min(if(inq_Communications_count = NULL, -NULL, inq_Communications_count), 999));

f_inq_highriskcredit_count_i := if(not(truedid), NULL, min(if(inq_HighRiskCredit_count = NULL, -NULL, inq_HighRiskCredit_count), 999));

f_inq_highriskcredit_count24_i := if(not(truedid), NULL, min(if(inq_HighRiskCredit_count24 = NULL, -NULL, inq_HighRiskCredit_count24), 999));

f_inq_mortgage_count_i := if(not(truedid), NULL, min(if(inq_Mortgage_count = NULL, -NULL, inq_Mortgage_count), 999));

f_inq_mortgage_count24_i := if(not(truedid), NULL, min(if(inq_Mortgage_count24 = NULL, -NULL, inq_Mortgage_count24), 999));

f_inq_per_ssn_i := if(not((integer)ssnlength > 0), NULL, min(if(inq_perssn = NULL, -NULL, inq_perssn), 999));

f_inq_lnames_per_addr_i := if(not(addrpop), NULL, min(if(inq_lnamesperaddr = NULL, -NULL, inq_lnamesperaddr), 999));

_inq_banko_am_first_seen := Models.common.sas_date((string)(Inq_banko_am_first_seen));

f_mos_inq_banko_am_fseen_d := map(
    not(truedid)                    => NULL,
    _inq_banko_am_first_seen = NULL => 1000,
                                       min(if(if ((sysdate - _inq_banko_am_first_seen) / (365.25 / 12) >= 0, truncate((sysdate - _inq_banko_am_first_seen) / (365.25 / 12)), roundup((sysdate - _inq_banko_am_first_seen) / (365.25 / 12))) = NULL, -NULL, if ((sysdate - _inq_banko_am_first_seen) / (365.25 / 12) >= 0, truncate((sysdate - _inq_banko_am_first_seen) / (365.25 / 12)), roundup((sysdate - _inq_banko_am_first_seen) / (365.25 / 12)))), 999));

_inq_banko_cm_first_seen := Models.common.sas_date((string)(Inq_banko_cm_first_seen));

f_mos_inq_banko_cm_fseen_d := map(
    not(truedid)                    => NULL,
    _inq_banko_cm_first_seen = NULL => 1000,
                                       min(if(if ((sysdate - _inq_banko_cm_first_seen) / (365.25 / 12) >= 0, truncate((sysdate - _inq_banko_cm_first_seen) / (365.25 / 12)), roundup((sysdate - _inq_banko_cm_first_seen) / (365.25 / 12))) = NULL, -NULL, if ((sysdate - _inq_banko_cm_first_seen) / (365.25 / 12) >= 0, truncate((sysdate - _inq_banko_cm_first_seen) / (365.25 / 12)), roundup((sysdate - _inq_banko_cm_first_seen) / (365.25 / 12)))), 999));

_inq_banko_cm_last_seen := Models.common.sas_date((string)(Inq_banko_cm_last_seen));

f_mos_inq_banko_cm_lseen_d := map(
    not(truedid)                   => NULL,
    _inq_banko_cm_last_seen = NULL => 1000,
                                      max(3, min(if(if ((sysdate - _inq_banko_cm_last_seen) / (365.25 / 12) >= 0, truncate((sysdate - _inq_banko_cm_last_seen) / (365.25 / 12)), roundup((sysdate - _inq_banko_cm_last_seen) / (365.25 / 12))) = NULL, -NULL, if ((sysdate - _inq_banko_cm_last_seen) / (365.25 / 12) >= 0, truncate((sysdate - _inq_banko_cm_last_seen) / (365.25 / 12)), roundup((sysdate - _inq_banko_cm_last_seen) / (365.25 / 12)))), 999)));

_inq_banko_om_first_seen := Models.common.sas_date((string)(Inq_banko_om_first_seen));

f_mos_inq_banko_om_fseen_d := map(
    not(truedid)                    => NULL,
    _inq_banko_om_first_seen = NULL => 1000,
                                       min(if(if ((sysdate - _inq_banko_om_first_seen) / (365.25 / 12) >= 0, truncate((sysdate - _inq_banko_om_first_seen) / (365.25 / 12)), roundup((sysdate - _inq_banko_om_first_seen) / (365.25 / 12))) = NULL, -NULL, if ((sysdate - _inq_banko_om_first_seen) / (365.25 / 12) >= 0, truncate((sysdate - _inq_banko_om_first_seen) / (365.25 / 12)), roundup((sysdate - _inq_banko_om_first_seen) / (365.25 / 12)))), 999));

_liens_unrel_cj_first_seen := Models.common.sas_date((string)(liens_unrel_CJ_first_seen));

f_mos_liens_unrel_cj_fseen_d := map(
    not(truedid)                      => NULL,
    _liens_unrel_cj_first_seen = NULL => 1000,
                                         min(if(if ((sysdate - _liens_unrel_cj_first_seen) / (365.25 / 12) >= 0, truncate((sysdate - _liens_unrel_cj_first_seen) / (365.25 / 12)), roundup((sysdate - _liens_unrel_cj_first_seen) / (365.25 / 12))) = NULL, -NULL, if ((sysdate - _liens_unrel_cj_first_seen) / (365.25 / 12) >= 0, truncate((sysdate - _liens_unrel_cj_first_seen) / (365.25 / 12)), roundup((sysdate - _liens_unrel_cj_first_seen) / (365.25 / 12)))), 999));

_liens_unrel_cj_last_seen := Models.common.sas_date((string)(liens_unrel_CJ_last_seen));

f_mos_liens_unrel_cj_lseen_d := map(
    not(truedid)                     => NULL,
    _liens_unrel_cj_last_seen = NULL => 1000,
                                        max(3, min(if(if ((sysdate - _liens_unrel_cj_last_seen) / (365.25 / 12) >= 0, truncate((sysdate - _liens_unrel_cj_last_seen) / (365.25 / 12)), roundup((sysdate - _liens_unrel_cj_last_seen) / (365.25 / 12))) = NULL, -NULL, if ((sysdate - _liens_unrel_cj_last_seen) / (365.25 / 12) >= 0, truncate((sysdate - _liens_unrel_cj_last_seen) / (365.25 / 12)), roundup((sysdate - _liens_unrel_cj_last_seen) / (365.25 / 12)))), 999)));

_liens_unrel_sc_first_seen := Models.common.sas_date((string)(liens_unrel_SC_first_seen));

f_mos_liens_unrel_sc_fseen_d := map(
    not(truedid)                      => NULL,
    _liens_unrel_sc_first_seen = NULL => 1000,
                                         min(if(if ((sysdate - _liens_unrel_sc_first_seen) / (365.25 / 12) >= 0, truncate((sysdate - _liens_unrel_sc_first_seen) / (365.25 / 12)), roundup((sysdate - _liens_unrel_sc_first_seen) / (365.25 / 12))) = NULL, -NULL, if ((sysdate - _liens_unrel_sc_first_seen) / (365.25 / 12) >= 0, truncate((sysdate - _liens_unrel_sc_first_seen) / (365.25 / 12)), roundup((sysdate - _liens_unrel_sc_first_seen) / (365.25 / 12)))), 999));

f_estimated_income_d := if(not(truedid), NULL, estimated_income);

f_wealth_index_d := if(not(truedid), NULL, (integer)wealth_index);

f_rel_incomeover50_count_d := map(
    not(truedid)  => NULL,
    rel_count = 0 => NULL,
                     if(max(rel_incomeover100_count, rel_incomeunder100_count, rel_incomeunder75_count) = NULL, NULL, sum(if(rel_incomeover100_count = NULL, 0, rel_incomeover100_count), if(rel_incomeunder100_count = NULL, 0, rel_incomeunder100_count), if(rel_incomeunder75_count = NULL, 0, rel_incomeunder75_count))));

f_rel_incomeover75_count_d := map(
    not(truedid)  => NULL,
    rel_count = 0 => NULL,
                     if(max(rel_incomeover100_count, rel_incomeunder100_count) = NULL, NULL, sum(if(rel_incomeover100_count = NULL, 0, rel_incomeover100_count), if(rel_incomeunder100_count = NULL, 0, rel_incomeunder100_count))));

f_rel_homeover200_count_d := map(
    not(truedid)  => NULL,
    rel_count = 0 => NULL,
                     if(max(rel_homeunder300_count, rel_homeunder500_count, rel_homeover500_count) = NULL, NULL, sum(if(rel_homeunder300_count = NULL, 0, rel_homeunder300_count), if(rel_homeunder500_count = NULL, 0, rel_homeunder500_count), if(rel_homeover500_count = NULL, 0, rel_homeover500_count))));

f_rel_educationover8_count_d := map(
    not(truedid)  => NULL,
    rel_count = 0 => NULL,
                     if(max(rel_educationunder12_count, rel_educationover12_count) = NULL, NULL, sum(if(rel_educationunder12_count = NULL, 0, rel_educationunder12_count), if(rel_educationover12_count = NULL, 0, rel_educationover12_count))));

f_rel_under25miles_cnt_d := map(
    not(truedid)  => NULL,
    rel_count = 0 => NULL,
                     rel_within25miles_count);

f_rel_under100miles_cnt_d := map(
    not(truedid)  => NULL,
    rel_count = 0 => NULL,
                     if(max(rel_within25miles_count, rel_within100miles_count) = NULL, NULL, sum(if(rel_within25miles_count = NULL, 0, rel_within25miles_count), if(rel_within100miles_count = NULL, 0, rel_within100miles_count))));

f_idrisktype_i := if(not(truedid) or fp_idrisktype = '', NULL, (integer)fp_idrisktype);

f_idverrisktype_i := if(not(truedid) or fp_idverrisktype = '', NULL, (integer)fp_idverrisktype);

f_varrisktype_i := map(
    not(truedid)          => NULL,
    fp_varrisktype = ''   => NULL,
                             (integer)fp_varrisktype);

f_srchvelocityrisktype_i := map(
    not(truedid)                   => NULL,
    fp_srchvelocityrisktype = ''   => NULL,
                                      (integer)fp_srchvelocityrisktype);

f_srchunvrfdssncount_i := if(not(truedid), NULL, min(if(fp_srchunvrfdssncount = '', -NULL, (integer)fp_srchunvrfdssncount), 999));

f_srchunvrfdphonecount_i := if(not(truedid), NULL, min(if(fp_srchunvrfdphonecount = '', -NULL, (integer)fp_srchunvrfdphonecount), 999));

f_srchfraudsrchcount_i := if(not(truedid), NULL, min(if(fp_srchfraudsrchcount = '', -NULL, (integer)fp_srchfraudsrchcount), 999));

f_assocsuspicousidcount_i := if(not(truedid), NULL, min(if(fp_assocsuspicousidcount = '', -NULL, (integer)fp_assocsuspicousidcount), 999));

f_corraddrnamecount_d := if(not(truedid), NULL, min(if(fp_corraddrnamecount = '', -NULL, (integer)fp_corraddrnamecount), 999));

f_srchssnsrchcount_i := if(not(truedid), NULL, min(if(fp_srchssnsrchcount = '', -NULL, (integer)fp_srchssnsrchcount), 999));

f_srchaddrsrchcount_i := if(not(truedid), NULL, min(if(fp_srchaddrsrchcount = '', -NULL, (integer)fp_srchaddrsrchcount), 999));

f_addrchangeincomediff_d := if(fp_addrchangeincomediff = '-1', NULL, (integer)fp_addrchangeincomediff);

f_addrchangevaluediff_d := map(
    not(truedid)                => NULL,
    fp_addrchangevaluediff = '-1' => NULL,
                                   (integer)fp_addrchangevaluediff);

f_addrchangecrimediff_i := map(
    not(truedid)                => NULL,
    fp_addrchangecrimediff = '-1' => NULL,
                                   (integer)fp_addrchangecrimediff);

f_curraddrmedianincome_d := if(not(truedid), NULL, (integer)fp_curraddrmedianincome);

f_curraddrcartheftindex_i := if(not(truedid), NULL, (integer)fp_curraddrcartheftindex);

f_curraddrburglaryindex_i := if(not(truedid), NULL, (integer)fp_curraddrburglaryindex);

f_curraddrcrimeindex_i := if(not(truedid), NULL, (integer)fp_curraddrcrimeindex);

f_prevaddrcartheftindex_i := if(not(truedid), NULL, (integer)fp_prevaddrcartheftindex);

r_s65_ssn_deceased_i := map(
    not(truedid or (integer)ssnlength > 0)                                 => NULL,
    rc_decsflag = '1'                                                      => 1,
    contains_i(ver_sources, 'DE') > 0 or contains_i(ver_sources, 'DS') > 0 => 1,
    rc_decsflag = '0'                                                      => 0,
                                                                              NULL);

r_paw_active_phone_ct_d := if(not(truedid), NULL, paw_active_phone_count);

r_c13_avg_lres_d := if(not(truedid), NULL, avg_lres);

_mod_disc_noexp_v01_w := map(
    eda_pfrd_address_ind = ''                  => 0,
    (eda_pfrd_address_ind in ['1A'])             => -0.391729488192788,
    (eda_pfrd_address_ind in ['1C'])             => -0.62500898133756,
    (eda_pfrd_address_ind in ['1E', '1B', '1D']) => -0.898194694477778,
    (eda_pfrd_address_ind in ['XX'])             => 0.148560186200737,
                                                    0);

_mod_disc_noexp_v02_w := map(
    pk_disconnect_flag = NULL => 0,
    pk_disconnect_flag <= 0.5 => -0.709707799471629,
    pk_disconnect_flag <= 1.5 => 0.864999350622432,
    pk_disconnect_flag <= 2.5 => 2.11193377184992,
    pk_disconnect_flag <= 3.5 => 2.76567177212583,
                                 4.09772080957328);

_mod_disc_noexp_v03_w := map(
    inq_lastseen_n = NULL          => 0,
    (real)inq_lastseen_n <= 2.5  => -1.5277665921805,
    (real)inq_lastseen_n <= 4.5  => -1.3630565472091,
    (real)inq_lastseen_n <= 7.5  => -1.18564498006842,
    (real)inq_lastseen_n <= 9.5  => -1.03070495913777,
    (real)inq_lastseen_n <= 12.5 => -0.896999356381642,
    (real)inq_lastseen_n <= 14.5 => -0.755804886637615,
    (real)inq_lastseen_n <= 20.5 => -0.581790860879932,
    (real)inq_lastseen_n <= 40.5 => -0.277563593947457,
    (real)inq_lastseen_n <= 63.5 => 0.153590557870702,
                                    0.531529276289476);

_mod_disc_noexp_v04_w := map(
    _pp_rule_high_vend_conf = NULL => 0,
    _pp_rule_high_vend_conf <= 0.5 => 0.0952923887836663,
                                      -0.597497922037511);

_mod_disc_noexp_v05_w := map(
    _pp_rule_port_neustar = NULL => 0,
    _pp_rule_port_neustar <= 0.5 => 0.00594982008690099,
                                    -1.51190395443614);

_mod_disc_noexp_v06_w := map(
    mth_exp_last_update = NULL   => 0,
    mth_exp_last_update <= 5.5   => -2.42858956944484,
    mth_exp_last_update <= 7.5   => -2.1558503730929,
    mth_exp_last_update <= 19.5  => -1.81261477967284,
    mth_exp_last_update <= 44.5  => -0.985459877127799,
    mth_exp_last_update <= 47.5  => -0.236994307680155,
    mth_exp_last_update <= 53.5  => 0.161355984505376,
    mth_exp_last_update <= 85.5  => 0.709025588438524,
    mth_exp_last_update <= 129.5 => 1.89811500817363,
                                    2.8035896851368);

_mod_disc_noexp_v07_w := map(
    mth_source_ppdid_lseen = NULL  => 0,
    mth_source_ppdid_lseen <= 0.5  => -0.956867023577639,
    mth_source_ppdid_lseen <= 2.5  => -0.741371932562739,
    mth_source_ppdid_lseen <= 6.5  => -0.630115567627538,
    mth_source_ppdid_lseen <= 11.5 => -0.528714189359454,
    mth_source_ppdid_lseen <= 16.5 => -0.366591670262699,
    mth_source_ppdid_lseen <= 19.5 => -0.214304748623541,
    mth_source_ppdid_lseen <= 41.5 => 0.0354799220190693,
    mth_source_ppdid_lseen <= 76.5 => 0.33552203651027,
    mth_source_ppdid_lseen <= 82.5 => 0.595711069869169,
                                      0.787853902558962);

_mod_disc_noexp_v08_w := map(
    pp_app_coctype = ''                => 0,
    (pp_app_coctype in ['PMC'])        => -0.477731340359256,
    (pp_app_coctype in ['RCC', 'EOC']) => 1.14371355011624,
    (pp_app_coctype in ['SP2'])        => -0.262816028343113,
                                          0);

_mod_disc_noexp_v09_w := map(
    _pp_rule_f1_ver_above = NULL => 0,
    _pp_rule_f1_ver_above <= 0.5 => 0.0429543136367459,
                                    -0.268530810026287);

_mod_disc_noexp_v10_w := map(
    _pp_rule_cellphone_latest = NULL => 0,
    _pp_rule_cellphone_latest <= 0.5 => 0.0782626188658045,
                                        -0.31549018129032);

_mod_disc_noexp_v11_w := map(
    mth_pp_datelastseen = NULL  => 0,
    mth_pp_datelastseen <= 0.5  => -0.403704779809732,
    mth_pp_datelastseen <= 1.5  => -0.266241520779788,
    mth_pp_datelastseen <= 11.5 => -0.18760804082956,
    mth_pp_datelastseen <= 13.5 => -0.0938844774071574,
    mth_pp_datelastseen <= 27.5 => 0.117712462104651,
    mth_pp_datelastseen <= 33.5 => 0.282605782340535,
    mth_pp_datelastseen <= 40.5 => 0.339295182243797,
    mth_pp_datelastseen <= 76.5 => 0.582310755700784,
                                   0.975300784580934);

_mod_disc_noexp_v12_w := map(
    mth_source_md_fseen = NULL  => 0,
    mth_source_md_fseen <= 4.5  => -0.386589320183484,
    mth_source_md_fseen <= 37.5 => -0.332054645904123,
                                   -0.267789430862705);

_mod_disc_noexp_v13_w := map(
    _phone_fb_rp_result_disc = NULL => 0,
    _phone_fb_rp_result_disc <= 0.5 => -0.0176251268029753,
                                       0.457678937446649);

_mod_disc_noexp_v14_w := map(
    (integer)_inq_adl_ph_industry_flag = NULL => 0,
    (integer)_inq_adl_ph_industry_flag <= 0.5 => 0.0254519474586523,
                                        -0.549805034126373);

_mod_disc_noexp_v15_w := map(
    _pp_src_all_uw = NULL => 0,
    _pp_src_all_uw <= 0.5 => 0.00645154909191819,
                             -0.124948415098507);

_mod_disc_noexp_v16_w := map(
    _phone_fb_rp_result = NULL => 0,
    _phone_fb_rp_result <= 0.5 => -0.597055467600695,
                                  0.0216231756140137);

_mod_disc_noexp_v17_w := map(
    pp_app_scc = ''                           => 0,
    (pp_app_scc in ['A', 'O', 'R', 'B', 'N']) => 0.951501743775464,
    (pp_app_scc in ['C'])                     => -0.387849891136882,
    (pp_app_scc in ['J', '8'])                => 0.20419414804982,
    (pp_app_scc in ['S'])                     => -0.216015021203566,
                                                 0);

_mod_disc_noexp_v18_w := map(
    mth_source_utildid_fseen = NULL  => 0,
    mth_source_utildid_fseen <= 3.5  => -1.12205150088937,
    mth_source_utildid_fseen <= 6.5  => -1.01568409489599,
    mth_source_utildid_fseen <= 10.5 => -0.789523450125289,
    mth_source_utildid_fseen <= 15.5 => -0.577764467760259,
    mth_source_utildid_fseen <= 29.5 => -0.402998717441442,
    mth_source_utildid_fseen <= 42.5 => -0.19618163750366,
    mth_source_utildid_fseen <= 79.5 => -0.00532836490540886,
                                        0.583342251276534);

_mod_disc_noexp_v19_w := map(
    f_inq_count_i = NULL  => 0,
    f_inq_count_i <= 0.5  => -0.121519103301928,
    f_inq_count_i <= 4.5  => -0.0648073488558243,
    f_inq_count_i <= 26.5 => 0.0109297122652443,
                             0.125668581236632);

_mod_disc_noexp_v20_w := map(
    f_inq_highriskcredit_count24_i = NULL => 0,
    f_inq_highriskcredit_count24_i <= 0.5 => -0.0341150540318181,
                                             0.151502478699747);

_mod_disc_noexp_v21_w := map(
    r_c13_avg_lres_d = NULL   => 0,
    r_c13_avg_lres_d <= 13.5  => 0.373488707532057,
    r_c13_avg_lres_d <= 43.5  => 0.238445065886402,
    r_c13_avg_lres_d <= 70.5  => 0.146027815135237,
    r_c13_avg_lres_d <= 130.5 => 0.0231648920180982,
    r_c13_avg_lres_d <= 233.5 => -0.168423723864164,
    r_c13_avg_lres_d <= 311.5 => -0.525733718472877,
                                 -0.922761753393036);

_mod_disc_noexp_v22_w := map(
    f_wealth_index_d = NULL => 0,
    f_wealth_index_d <= 1.5 => 0.150617550799594,
    f_wealth_index_d <= 2.5 => 0.0586563731955665,
    f_wealth_index_d <= 4.5 => -0.00398142971726497,
                               -0.223447690985872);

_mod_disc_noexp_v23_w := map(
    mth_source_ppfla_fseen = NULL   => 0,
    mth_source_ppfla_fseen <= 6.5   => -0.762226247229003,
    mth_source_ppfla_fseen <= 14.5  => -0.63124717906716,
    mth_source_ppfla_fseen <= 25.5  => -0.447693950269755,
    mth_source_ppfla_fseen <= 49.5  => -0.343278631434623,
    mth_source_ppfla_fseen <= 109.5 => -0.142539329884936,
    mth_source_ppfla_fseen <= 128.5 => 0.149164162996837,
                                       0.316098258416707);

_mod_disc_noexp_v24_w := map(
    r_c14_addrs_5yr_i = NULL => 0,
    r_c14_addrs_5yr_i <= 0.5 => -0.113674321551057,
    r_c14_addrs_5yr_i <= 2.5 => -0.0190763412966609,
    r_c14_addrs_5yr_i <= 4.5 => 0.0663422182997623,
                                0.134626699220493);

_mod_disc_noexp_v25_w := map(
    eda_address_match_best = NULL => 0,
    eda_address_match_best <= 0.5 => 0.0173893408125175,
                                     -0.384952138092549);

_mod_disc_noexp_v26_w := map(
    f_m_bureau_adl_fs_all_d = NULL   => 0,
    f_m_bureau_adl_fs_all_d <= 259.5 => 0.0848480521889272,
    f_m_bureau_adl_fs_all_d <= 324.5 => 0.0375110120085443,
                                        -0.101668930752715);

_mod_disc_noexp_v27_w := map(
    f_mos_inq_banko_cm_lseen_d = NULL  => 0,
    f_mos_inq_banko_cm_lseen_d <= 30.5 => 0.121635090101052,
    f_mos_inq_banko_cm_lseen_d <= 91.5 => 0.0492181658987184,
                                          -0.144126756516026);

_mod_disc_noexp_v28_w := map(
    mth_source_ppla_lseen = NULL  => 0,
    mth_source_ppla_lseen <= 12.5 => -0.319774477109631,
    mth_source_ppla_lseen <= 42.5 => -0.0932171623574389,
    mth_source_ppla_lseen <= 48.5 => 0.0906700865229462,
    mth_source_ppla_lseen <= 80.5 => 0.132185884199899,
                                     0.279000318938337);

_mod_disc_noexp_v29_w := map(
    f_inq_communications_count_i = NULL => 0,
    f_inq_communications_count_i <= 0.5 => -0.0343190752709263,
    f_inq_communications_count_i <= 2.5 => 0.04407849741056,
                                           0.112855763316978);

_mod_disc_noexp_v30_w := map(
    r_prop_owner_history_d = NULL => 0,
    r_prop_owner_history_d <= 0.5 => 0.0834245906490045,
    r_prop_owner_history_d <= 1.5 => 0.0276848615163979,
                                     -0.094799143158837);

_mod_disc_noexp_v31_w := map(
    r_i60_inq_comm_recency_d = NULL  => 0,
    r_i60_inq_comm_recency_d <= 61.5 => 0.0933261128802957,
    r_i60_inq_comm_recency_d <= 549  => 0.0749572538192703,
                                        -0.0421346773292371);

_mod_disc_noexp_v32_w := map(
    inq_num_adls_06 = NULL => 0,
    inq_num_adls_06 <= 0.5 => 0.0167322186562142,
    inq_num_adls_06 <= 1.5 => -0.24540160679887,
                              -0.283756254542241);

_mod_disc_noexp_v33_w := map(
    f_srchfraudsrchcount_i = NULL => 0,
    f_srchfraudsrchcount_i <= 2.5 => -0.00941261645632187,
                                     0.0106330723218022);

_mod_disc_noexp_v34_w := map(
    r_a41_prop_owner_d = NULL => 0,
    r_a41_prop_owner_d <= 0.5 => 0.0476690399865608,
                                 -0.0580829682703541);

_mod_disc_noexp_v35_w := map(
    r_a44_curr_add_naprop_d = NULL => 0,
    r_a44_curr_add_naprop_d <= 0.5 => 0.0193589772481187,
    r_a44_curr_add_naprop_d <= 1.5 => 0.0172789026812821,
    r_a44_curr_add_naprop_d <= 3.5 => -0.017428221265042,
                                      -0.0511555752151251);

_mod_disc_noexp_v36_w := map(
    r_c14_addrs_10yr_i = NULL => 0,
    r_c14_addrs_10yr_i <= 0.5 => -0.0452828402368154,
    r_c14_addrs_10yr_i <= 1.5 => -0.0255897816827352,
    r_c14_addrs_10yr_i <= 3.5 => -0.0123219805670369,
    r_c14_addrs_10yr_i <= 7.5 => 0.00778016587456132,
                                 0.0299447971407314);

_mod_disc_noexp_v37_w := map(
    f_srchvelocityrisktype_i = NULL => 0,
    f_srchvelocityrisktype_i <= 1.5 => -0.026785966715813,
    f_srchvelocityrisktype_i <= 5.5 => -0.00965852963366483,
                                       0.017810419528772);

_mod_disc_noexp_v38_w := map(
    _pp_srule_port_neustar = NULL => 0,
    _pp_srule_port_neustar <= 0.5 => 4.57323203840133e-05,
                                     -0.0116210028243297);

_mod_disc_noexp_v39_w := map(
    f_inq_highriskcredit_count_i = NULL  => 0,
    f_inq_highriskcredit_count_i <= 0.5  => -1.41117535795419e-05,
    f_inq_highriskcredit_count_i <= 2.5  => 1.39878309614637e-05,
    f_inq_highriskcredit_count_i <= 14.5 => 2.49974845420346e-05,
                                            3.26044878731876e-05);

_mod_disc_noexp_lgt := 2.16837021116315 +
    _mod_disc_noexp_v01_w +
    _mod_disc_noexp_v02_w +
    _mod_disc_noexp_v03_w +
    _mod_disc_noexp_v04_w +
    _mod_disc_noexp_v05_w +
    _mod_disc_noexp_v06_w +
    _mod_disc_noexp_v07_w +
    _mod_disc_noexp_v08_w +
    _mod_disc_noexp_v09_w +
    _mod_disc_noexp_v10_w +
    _mod_disc_noexp_v11_w +
    _mod_disc_noexp_v12_w +
    _mod_disc_noexp_v13_w +
    _mod_disc_noexp_v14_w +
    _mod_disc_noexp_v15_w +
    _mod_disc_noexp_v16_w +
    _mod_disc_noexp_v17_w +
    _mod_disc_noexp_v18_w +
    _mod_disc_noexp_v19_w +
    _mod_disc_noexp_v20_w +
    _mod_disc_noexp_v21_w +
    _mod_disc_noexp_v22_w +
    _mod_disc_noexp_v23_w +
    _mod_disc_noexp_v24_w +
    _mod_disc_noexp_v25_w +
    _mod_disc_noexp_v26_w +
    _mod_disc_noexp_v27_w +
    _mod_disc_noexp_v28_w +
    _mod_disc_noexp_v29_w +
    _mod_disc_noexp_v30_w +
    _mod_disc_noexp_v31_w +
    _mod_disc_noexp_v32_w +
    _mod_disc_noexp_v33_w +
    _mod_disc_noexp_v34_w +
    _mod_disc_noexp_v35_w +
    _mod_disc_noexp_v36_w +
    _mod_disc_noexp_v37_w +
    _mod_disc_noexp_v38_w +
    _mod_disc_noexp_v39_w;

final_score_0 := -0.1194893161;

final_score_1_c169 := map(
    NULL < pk_phone_match_level AND pk_phone_match_level <= 2.5 => 0.0261377511,
    pk_phone_match_level > 2.5                                  => 0.1430491243,
    pk_phone_match_level = NULL                                 => 0.1101531747,
                                                                   0.1101531747);

final_score_1_c172 := map(
    NULL < mth_source_sx_fseen AND mth_source_sx_fseen <= 31.5 => 0.1458252571,
    mth_source_sx_fseen > 31.5                                 => 0.0090392827,
    mth_source_sx_fseen = NULL                                 => -0.1012003890,
                                                                  -0.0960532150);

final_score_1_c171 := map(
    (phone_subject_title in ['Associate', 'Associate By Address', 'Associate By Business', 'Associate By Shared Associates', 'Brother', 'Child', 'Grandchild', 'Granddaughter', 'Grandfather', 'Grandson', 'Neighbor', 'Sister', 'Subject'])                  => final_score_1_c172,
    (phone_subject_title in ['Associate By Property', 'Associate By SSN', 'Associate By Vehicle', 'Daughter', 'Father', 'Grandmother', 'Grandparent', 'Husband', 'Mother', 'Parent', 'Relative', 'Sibling', 'Son', 'Spouse', 'Subject at Household', 'Wife']) => -0.0231120806,
    phone_subject_title = ''                                                                                                                                                                                                                                => -0.0767626648,
                                                                                                                                                                                                                                                                 -0.0767626648);

final_score_1_c170 := map(
    NULL < mth_source_ppdid_lseen AND mth_source_ppdid_lseen <= 20.5 => 0.0405950325,
    mth_source_ppdid_lseen > 20.5                                    => -0.0545840251,
    mth_source_ppdid_lseen = NULL                                    => final_score_1_c171,
                                                                        -0.0614402879);

final_score_1 := map(
    NULL < _mod_disc_noexp_lgt AND _mod_disc_noexp_lgt <= -0.292710971160079 => final_score_1_c169,
    _mod_disc_noexp_lgt > -0.292710971160079                                 => final_score_1_c170,
    _mod_disc_noexp_lgt = NULL                                               => 0.0006007214,
                                                                                0.0006007214);

final_score_2_c174 := map(
    NULL < (integer)inq_adl_firstseen_n AND (integer)inq_adl_firstseen_n <= 0.5 => 0.0561726289,
    (integer)inq_adl_firstseen_n > 0.5                                 => 0.1535341438,
    (integer)inq_adl_firstseen_n = NULL                                => 0.1382571618,
                                                                 0.1215608832);

final_score_2_c177 := map(
    NULL < mth_source_sx_fseen AND mth_source_sx_fseen <= 22.5 => 0.1133840160,
    mth_source_sx_fseen > 22.5                                 => 0.0580912345,
    mth_source_sx_fseen = NULL                                 => -0.0916199689,
                                                                  -0.0865162115);

final_score_2_c176 := map(
    (phone_subject_title in ['Associate', 'Associate By Address', 'Associate By Business', 'Associate By Shared Associates', 'Associate By SSN', 'Brother', 'Child', 'Grandchild', 'Granddaughter', 'Grandfather', 'Grandson', 'Neighbor', 'Relative', 'Sibling', 'Sister', 'Spouse', 'Subject']) => final_score_2_c177,
    (phone_subject_title in ['Associate By Property', 'Associate By Vehicle', 'Daughter', 'Father', 'Grandmother', 'Grandparent', 'Husband', 'Mother', 'Parent', 'Son', 'Subject at Household', 'Wife'])                                                                                          => -0.0016006371,
    phone_subject_title = ''                                                                                                                                                                                                                                                                    => -0.0694202023,
                                                                                                                                                                                                                                                                                                     -0.0694202023);

final_score_2_c175 := map(
    NULL < mth_source_ppdid_lseen AND mth_source_ppdid_lseen <= 19.5 => 0.0518677793,
    mth_source_ppdid_lseen > 19.5                                    => -0.0304862852,
    mth_source_ppdid_lseen = NULL                                    => final_score_2_c176,
                                                                        -0.0490018895);

final_score_2 := map(
    NULL < _mod_disc_noexp_lgt AND _mod_disc_noexp_lgt <= -0.913879696534105 => final_score_2_c174,
    _mod_disc_noexp_lgt > -0.913879696534105                                 => final_score_2_c175,
    _mod_disc_noexp_lgt = NULL                                               => -0.0030921056,
                                                                                -0.0030921056);

final_score_3_c180 := map(
    NULL < mth_source_ppth_lseen AND mth_source_ppth_lseen <= 24.5 => -0.0062686444,
    mth_source_ppth_lseen > 24.5                                   => -0.1318419460,
    mth_source_ppth_lseen = NULL                                   => 0.1184683108,
                                                                      0.1119354887);

final_score_3_c179 := map(
    (phone_subject_title in ['Associate By Address', 'Associate By Business', 'Associate By Shared Associates', 'Brother', 'Daughter', 'Father', 'Grandfather', 'Neighbor', 'Parent', 'Relative', 'Sibling', 'Sister', 'Son', 'Spouse', 'Wife'])          => -0.0114377511,
    (phone_subject_title in ['Associate', 'Associate By Property', 'Associate By SSN', 'Associate By Vehicle', 'Child', 'Grandchild', 'Granddaughter', 'Grandmother', 'Grandparent', 'Grandson', 'Husband', 'Mother', 'Subject', 'Subject at Household']) => final_score_3_c180,
    phone_subject_title = ''                                                                                                                                                                                                                            => 0.0927435955,
                                                                                                                                                                                                                                                             0.0927435955);

final_score_3_c182 := map(
    NULL < _mod_disc_noexp_lgt AND _mod_disc_noexp_lgt <= 5.89600150416653 => -0.0565656460,
    _mod_disc_noexp_lgt > 5.89600150416653                                 => -0.1492129848,
    _mod_disc_noexp_lgt = NULL                                             => -0.0673738376,
                                                                              -0.0673738376);

final_score_3_c181 := map(
    NULL < mth_source_ppdid_lseen AND mth_source_ppdid_lseen <= 22.5 => 0.0406856556,
    mth_source_ppdid_lseen > 22.5                                    => -0.0485560249,
    mth_source_ppdid_lseen = NULL                                    => final_score_3_c182,
                                                                        -0.0521463358);

final_score_3 := map(
    NULL < _mod_disc_noexp_lgt AND _mod_disc_noexp_lgt <= -0.374539840785361 => final_score_3_c179,
    _mod_disc_noexp_lgt > -0.374539840785361                                 => final_score_3_c181,
    _mod_disc_noexp_lgt = NULL                                               => -0.0023059952,
                                                                                -0.0023059952);

final_score_4_c185 := map(
    NULL < mth_source_ppth_fseen AND mth_source_ppth_fseen <= 65 => -0.0141271869,
    mth_source_ppth_fseen > 65                                   => -0.1711465473,
    mth_source_ppth_fseen = NULL                                 => 0.1064022082,
                                                                    0.1007889246);

final_score_4_c184 := map(
    (phone_subject_title in ['Associate By Address', 'Associate By Business', 'Associate By Shared Associates', 'Associate By SSN', 'Brother', 'Daughter', 'Father', 'Granddaughter', 'Grandparent', 'Mother', 'Neighbor', 'Parent', 'Relative', 'Sibling', 'Sister', 'Son', 'Wife']) => -0.0207681954,
    (phone_subject_title in ['Associate', 'Associate By Property', 'Associate By Vehicle', 'Child', 'Grandchild', 'Grandfather', 'Grandmother', 'Grandson', 'Husband', 'Spouse', 'Subject', 'Subject at Household'])                                                                  => final_score_4_c185,
    phone_subject_title = ''                                                                                                                                                                                                                                                        => 0.0794652661,
                                                                                                                                                                                                                                                                                         0.0794652661);

final_score_4_c187 := map(
    NULL < number_of_sources AND number_of_sources <= 1.5 => -0.0586612170,
    number_of_sources > 1.5                               => 0.0202731306,
    number_of_sources = NULL                              => -0.0409572084,
                                                             -0.0409572084);

final_score_4_c186 := map(
    NULL < _mod_disc_noexp_lgt AND _mod_disc_noexp_lgt <= 6.49265045234927 => final_score_4_c187,
    _mod_disc_noexp_lgt > 6.49265045234927                                 => -0.1398830012,
    _mod_disc_noexp_lgt = NULL                                             => -0.0510007339,
                                                                              -0.0510007339);

final_score_4 := map(
    NULL < _mod_disc_noexp_lgt AND _mod_disc_noexp_lgt <= -0.214067819531338 => final_score_4_c184,
    _mod_disc_noexp_lgt > -0.214067819531338                                 => final_score_4_c186,
    _mod_disc_noexp_lgt = NULL                                               => -0.0010436075,
                                                                                -0.0010436075);

final_score_5_c189 := map(
    NULL < (integer)inq_adl_firstseen_n AND (integer)inq_adl_firstseen_n <= 0.5 => 0.0254830742,
    (integer)inq_adl_firstseen_n > 0.5                                 => 0.1204126499,
    (integer)inq_adl_firstseen_n = NULL                                => 0.1042837933,
                                                                 0.0880712635);

final_score_5_c192 := map(
    NULL < mth_source_sx_fseen AND mth_source_sx_fseen <= 31.5 => 0.1180323308,
    mth_source_sx_fseen > 31.5                                 => 0.0181615932,
    mth_source_sx_fseen = NULL                                 => -0.0684587753,
                                                                  -0.0646198435);

final_score_5_c191 := map(
    (phone_subject_title in ['Associate', 'Associate By Address', 'Associate By Business', 'Associate By Shared Associates', 'Associate By SSN', 'Brother', 'Child', 'Daughter', 'Grandchild', 'Granddaughter', 'Grandparent', 'Grandson', 'Neighbor', 'Relative', 'Sister', 'Spouse', 'Subject']) => final_score_5_c192,
    (phone_subject_title in ['Associate By Property', 'Associate By Vehicle', 'Father', 'Grandfather', 'Grandmother', 'Husband', 'Mother', 'Parent', 'Sibling', 'Son', 'Subject at Household', 'Wife'])                                                                                            => 0.0064354800,
    phone_subject_title = ''                                                                                                                                                                                                                                                                     => -0.0509669354,
                                                                                                                                                                                                                                                                                                      -0.0509669354);

final_score_5_c190 := map(
    NULL < mth_source_ppdid_lseen AND mth_source_ppdid_lseen <= 24.5 => 0.0306990080,
    mth_source_ppdid_lseen > 24.5                                    => -0.0365164918,
    mth_source_ppdid_lseen = NULL                                    => final_score_5_c191,
                                                                        -0.0379847325);

final_score_5 := map(
    NULL < _mod_disc_noexp_lgt AND _mod_disc_noexp_lgt <= -0.670362336360087 => final_score_5_c189,
    _mod_disc_noexp_lgt > -0.670362336360087                                 => final_score_5_c190,
    _mod_disc_noexp_lgt = NULL                                               => 0.0004954260,
                                                                                0.0004954260);

final_score_6_c195 := map(
    NULL < (integer)inq_adl_firstseen_n AND (integer)inq_adl_firstseen_n <= 0.5 => -0.0354065195,
    (integer)inq_adl_firstseen_n > 0.5                                 => 0.0703612011,
    (integer)inq_adl_firstseen_n = NULL                                => 0.0306766726,
                                                                 0.0082827316);

final_score_6_c197 := map(
    NULL < number_of_sources AND number_of_sources <= 2.5 => -0.0522823836,
    number_of_sources > 2.5                               => 0.0494167397,
    number_of_sources = NULL                              => -0.0450290371,
                                                             -0.0450290371);

final_score_6_c196 := map(
    NULL < _mod_disc_noexp_lgt AND _mod_disc_noexp_lgt <= 6.7133062982223 => final_score_6_c197,
    _mod_disc_noexp_lgt > 6.7133062982223                                 => -0.1320337927,
    _mod_disc_noexp_lgt = NULL                                            => -0.0557045739,
                                                                             -0.0557045739);

final_score_6_c194 := map(
    NULL < _mod_disc_noexp_lgt AND _mod_disc_noexp_lgt <= 0.519252778420959 => final_score_6_c195,
    _mod_disc_noexp_lgt > 0.519252778420959                                 => final_score_6_c196,
    _mod_disc_noexp_lgt = NULL                                              => -0.0330413310,
                                                                               -0.0330413310);

final_score_6 := map(
    NULL < _mod_disc_noexp_lgt AND _mod_disc_noexp_lgt <= -0.984338855182741 => 0.0882784827,
    _mod_disc_noexp_lgt > -0.984338855182741                                 => final_score_6_c194,
    _mod_disc_noexp_lgt = NULL                                               => -0.0014675190,
                                                                                -0.0014675190);

final_score_7_c202 := map(
    (exp_source in ['', 'P']) => -0.0303345228,
    (exp_source in ['S'])     => 0.0582382476,
    exp_source = ''         => -0.0223532480,
                                 -0.0223532480);

final_score_7_c201 := map(
    (phone_subject_title in ['Associate By Business', 'Associate By SSN', 'Child', 'Grandchild', 'Granddaughter', 'Grandson', 'Neighbor', 'Son'])                                                                                                                                                                                                        => -0.1168019583,
    (phone_subject_title in ['Associate', 'Associate By Address', 'Associate By Property', 'Associate By Shared Associates', 'Associate By Vehicle', 'Brother', 'Daughter', 'Father', 'Grandfather', 'Grandmother', 'Grandparent', 'Husband', 'Mother', 'Parent', 'Relative', 'Sibling', 'Sister', 'Spouse', 'Subject', 'Subject at Household', 'Wife']) => final_score_7_c202,
    phone_subject_title = ''                                                                                                                                                                                                                                                                                                                           => -0.0329681786,
                                                                                                                                                                                                                                                                                                                                                            -0.0329681786);

final_score_7_c200 := map(
    NULL < mth_source_ppth_lseen AND mth_source_ppth_lseen <= 10.5 => 0.0453457163,
    mth_source_ppth_lseen > 10.5                                   => -0.1050420633,
    mth_source_ppth_lseen = NULL                                   => final_score_7_c201,
                                                                      -0.0412560765);

final_score_7_c199 := map(
    NULL < mth_source_ppdid_lseen AND mth_source_ppdid_lseen <= 16.5 => 0.0560081117,
    mth_source_ppdid_lseen > 16.5                                    => -0.0195119960,
    mth_source_ppdid_lseen = NULL                                    => final_score_7_c200,
                                                                        -0.0255782596);

final_score_7 := map(
    NULL < _mod_disc_noexp_lgt AND _mod_disc_noexp_lgt <= -1.40920081812364 => 0.0977099013,
    _mod_disc_noexp_lgt > -1.40920081812364                                 => final_score_7_c199,
    _mod_disc_noexp_lgt = NULL                                              => 0.0006636233,
                                                                               0.0006636233);

final_score_8_c205 := map(
    NULL < mth_exp_last_update AND mth_exp_last_update <= 8.5 => 0.0640006702,
    mth_exp_last_update > 8.5                                 => 0.0468390371,
    mth_exp_last_update = NULL                                => -0.0273714124,
                                                                 -0.0029325256);

final_score_8_c204 := map(
    NULL < (integer)inq_adl_firstseen_n AND (integer)inq_adl_firstseen_n <= 0.5 => final_score_8_c205,
    (integer)inq_adl_firstseen_n > 0.5                                 => 0.0905433685,
    (integer)inq_adl_firstseen_n = NULL                                => 0.0612953939,
                                                                 0.0477571746);

final_score_8_c207 := map(
    NULL < number_of_sources AND number_of_sources <= 1.5 => -0.0511184313,
    number_of_sources > 1.5                               => 0.0124988103,
    number_of_sources = NULL                              => -0.0370105195,
                                                             -0.0370105195);

final_score_8_c206 := map(
    NULL < _mod_disc_noexp_lgt AND _mod_disc_noexp_lgt <= 6.92121396294699 => final_score_8_c207,
    _mod_disc_noexp_lgt > 6.92121396294699                                 => -0.1189974523,
    _mod_disc_noexp_lgt = NULL                                             => -0.0454172926,
                                                                              -0.0454172926);

final_score_8 := map(
    NULL < _mod_disc_noexp_lgt AND _mod_disc_noexp_lgt <= 0.296471486999646 => final_score_8_c204,
    _mod_disc_noexp_lgt > 0.296471486999646                                 => final_score_8_c206,
    _mod_disc_noexp_lgt = NULL                                              => -0.0013830000,
                                                                               -0.0013830000);

final_score_9_c210 := map(
    NULL < f_srchfraudsrchcount_i AND f_srchfraudsrchcount_i <= 2.5 => 0.0148660908,
    f_srchfraudsrchcount_i > 2.5                                    => -0.0712122392,
    f_srchfraudsrchcount_i = NULL                                   => -0.0298320647,
                                                                       -0.0298320647);

final_score_9_c212 := map(
    NULL < (integer)source_sx AND (integer)source_sx <= 0.5 => -0.0570288707,
    (integer)source_sx > 0.5                       => 0.0926043649,
    (integer)source_sx = NULL                      => -0.0537965291,
                                             -0.0537965291);

final_score_9_c211 := map(
    (phone_subject_title in ['Associate', 'Associate By Address', 'Associate By Business', 'Associate By Shared Associates', 'Brother', 'Child', 'Daughter', 'Grandchild', 'Granddaughter', 'Grandfather', 'Grandson', 'Neighbor', 'Relative', 'Sibling', 'Sister', 'Spouse', 'Subject']) => final_score_9_c212,
    (phone_subject_title in ['Associate By Property', 'Associate By SSN', 'Associate By Vehicle', 'Father', 'Grandmother', 'Grandparent', 'Husband', 'Mother', 'Parent', 'Son', 'Subject at Household', 'Wife'])                                                                          => 0.0155125622,
    phone_subject_title = ''                                                                                                                                                                                                                                                            => -0.0390772181,
                                                                                                                                                                                                                                                                                             -0.0390772181);

final_score_9_c209 := map(
    NULL < mth_source_ppdid_lseen AND mth_source_ppdid_lseen <= 16.5 => 0.0528175212,
    mth_source_ppdid_lseen > 16.5                                    => final_score_9_c210,
    mth_source_ppdid_lseen = NULL                                    => final_score_9_c211,
                                                                        -0.0252650448);

final_score_9 := map(
    NULL < mth_exp_last_update AND mth_exp_last_update <= 31.5 => 0.0737918074,
    mth_exp_last_update > 31.5                                 => 0.0344319305,
    mth_exp_last_update = NULL                                 => final_score_9_c209,
                                                                  0.0008101519);

final_score_10_c215 := map(
    NULL < mth_internal_ver_first_seen AND mth_internal_ver_first_seen <= 2.5 => 0.0884221428,
    mth_internal_ver_first_seen > 2.5                                         => 0.0361902244,
    mth_internal_ver_first_seen = NULL                                        => -0.0276589525,
                                                                                 -0.0055170016);

final_score_10_c214 := map(
    NULL < pk_phone_match_level AND pk_phone_match_level <= 2.5 => final_score_10_c215,
    pk_phone_match_level > 2.5                                  => 0.0679394725,
    pk_phone_match_level = NULL                                 => 0.0427044143,
                                                                   0.0427044143);

final_score_10_c217 := map(
    (exp_type in ['', 'C']) => -0.0361597023,
    (exp_type in ['N'])     => 0.0479362717,
    exp_type = ''         => -0.0289883272,
                               -0.0289883272);

final_score_10_c216 := map(
    NULL < _mod_disc_noexp_lgt AND _mod_disc_noexp_lgt <= 6.38975295088399 => final_score_10_c217,
    _mod_disc_noexp_lgt > 6.38975295088399                                 => -0.1072694097,
    _mod_disc_noexp_lgt = NULL                                             => -0.0386925949,
                                                                              -0.0386925949);

final_score_10 := map(
    NULL < _mod_disc_noexp_lgt AND _mod_disc_noexp_lgt <= 0.321704314141393 => final_score_10_c214,
    _mod_disc_noexp_lgt > 0.321704314141393                                 => final_score_10_c216,
    _mod_disc_noexp_lgt = NULL                                              => 0.0003299261,
                                                                               0.0003299261);

final_score_11_c221 := map(
    NULL < _mod_disc_noexp_lgt AND _mod_disc_noexp_lgt <= 1.39280844485288 => -0.0061855424,
    _mod_disc_noexp_lgt > 1.39280844485288                                 => -0.0550424313,
    _mod_disc_noexp_lgt = NULL                                             => -0.0234409350,
                                                                              -0.0234409350);

final_score_11_c220 := map(
    (phone_subject_title in ['Associate By Business', 'Grandchild', 'Granddaughter', 'Grandfather', 'Grandparent', 'Grandson', 'Neighbor'])                                                                                                                                                                                                                    => -0.1162774728,
    (phone_subject_title in ['Associate', 'Associate By Address', 'Associate By Property', 'Associate By Shared Associates', 'Associate By SSN', 'Associate By Vehicle', 'Brother', 'Child', 'Daughter', 'Father', 'Grandmother', 'Husband', 'Mother', 'Parent', 'Relative', 'Sibling', 'Sister', 'Son', 'Spouse', 'Subject', 'Subject at Household', 'Wife']) => final_score_11_c221,
    phone_subject_title = ''                                                                                                                                                                                                                                                                                                                                 => -0.0305720464,
                                                                                                                                                                                                                                                                                                                                                                  -0.0305720464);

final_score_11_c222 := map(
    NULL < _mod_disc_noexp_lgt AND _mod_disc_noexp_lgt <= 5.10676673541873 => 0.0349952764,
    _mod_disc_noexp_lgt > 5.10676673541873                                 => -0.0786268716,
    _mod_disc_noexp_lgt = NULL                                             => 0.0188760319,
                                                                              0.0188760319);

final_score_11_c219 := map(
    NULL < number_of_sources AND number_of_sources <= 1.5 => final_score_11_c220,
    number_of_sources > 1.5                               => final_score_11_c222,
    number_of_sources = NULL                              => -0.0168841873,
                                                             -0.0168841873);

final_score_11 := map(
    NULL < _mod_disc_noexp_lgt AND _mod_disc_noexp_lgt <= -1.42558423781196 => 0.0776346853,
    _mod_disc_noexp_lgt > -1.42558423781196                                 => final_score_11_c219,
    _mod_disc_noexp_lgt = NULL                                              => 0.0025954947,
                                                                               0.0025954947);

final_score_12_c224 := map(
    NULL < (integer)inq_adl_firstseen_n AND (integer)inq_adl_firstseen_n <= 0.5 => -0.0002924096,
    (integer)inq_adl_firstseen_n > 0.5                                 => 0.0777019448,
    (integer)inq_adl_firstseen_n = NULL                                => 0.0607015766,
                                                                 0.0474113559);

final_score_12_c227 := map(
    NULL < _mod_disc_noexp_lgt AND _mod_disc_noexp_lgt <= 1.48218677118725 => 0.0141679171,
    _mod_disc_noexp_lgt > 1.48218677118725                                 => -0.0306963401,
    _mod_disc_noexp_lgt = NULL                                             => -0.0037685404,
                                                                              -0.0037685404);

final_score_12_c226 := map(
    (phone_subject_title in ['Associate', 'Associate By Address', 'Associate By Business', 'Associate By Shared Associates', 'Child', 'Grandchild', 'Granddaughter', 'Grandfather', 'Grandmother', 'Grandson', 'Neighbor', 'Son', 'Spouse'])                  => -0.0487066631,
    (phone_subject_title in ['Associate By Property', 'Associate By SSN', 'Associate By Vehicle', 'Brother', 'Daughter', 'Father', 'Grandparent', 'Husband', 'Mother', 'Parent', 'Relative', 'Sibling', 'Sister', 'Subject', 'Subject at Household', 'Wife']) => final_score_12_c227,
    phone_subject_title = ''                                                                                                                                                                                                                                => -0.0216507465,
                                                                                                                                                                                                                                                                 -0.0216507465);

final_score_12_c225 := map(
    NULL < mth_source_ppth_fseen AND mth_source_ppth_fseen <= 14.5 => 0.0754073031,
    mth_source_ppth_fseen > 14.5                                   => -0.0840167775,
    mth_source_ppth_fseen = NULL                                   => final_score_12_c226,
                                                                      -0.0278528846);

final_score_12 := map(
    NULL < _mod_disc_noexp_lgt AND _mod_disc_noexp_lgt <= -0.212626548172976 => final_score_12_c224,
    _mod_disc_noexp_lgt > -0.212626548172976                                 => final_score_12_c225,
    _mod_disc_noexp_lgt = NULL                                               => 0.0005878055,
                                                                                0.0005878055);

final_score_13_c232 := map(
    NULL < mth_source_ppca_lseen AND mth_source_ppca_lseen <= 19.5 => 0.0014471555,
    mth_source_ppca_lseen > 19.5                                   => -0.0752661957,
    mth_source_ppca_lseen = NULL                                   => -0.0557011784,
                                                                      -0.0502710859);

final_score_13_c231 := map(
    NULL < (integer)source_sx AND (integer)source_sx <= 0.5 => final_score_13_c232,
    (integer)source_sx > 0.5                       => 0.0802040919,
    (integer)source_sx = NULL                      => -0.0475457525,
                                             -0.0475457525);

final_score_13_c230 := map(
    (phone_subject_title in ['Associate', 'Associate By Address', 'Associate By Business', 'Associate By Shared Associates', 'Brother', 'Child', 'Daughter', 'Grandchild', 'Granddaughter', 'Grandfather', 'Grandparent', 'Grandson', 'Neighbor', 'Relative', 'Sibling', 'Son', 'Spouse', 'Subject']) => final_score_13_c231,
    (phone_subject_title in ['Associate By Property', 'Associate By SSN', 'Associate By Vehicle', 'Father', 'Grandmother', 'Husband', 'Mother', 'Parent', 'Sister', 'Subject at Household', 'Wife'])                                                                                                  => 0.0111066996,
    phone_subject_title = ''                                                                                                                                                                                                                                                                        => -0.0351914335,
                                                                                                                                                                                                                                                                                                         -0.0351914335);

final_score_13_c229 := map(
    NULL < mth_source_ppdid_lseen AND mth_source_ppdid_lseen <= 22.5 => 0.0379519882,
    mth_source_ppdid_lseen > 22.5                                    => -0.0411670016,
    mth_source_ppdid_lseen = NULL                                    => final_score_13_c230,
                                                                        -0.0240885067);

final_score_13 := map(
    NULL < mth_exp_last_update AND mth_exp_last_update <= 29.5 => 0.0584552533,
    mth_exp_last_update > 29.5                                 => 0.0163091110,
    mth_exp_last_update = NULL                                 => final_score_13_c229,
                                                                  -0.0033121370);

final_score_14_c237 := map(
    NULL < (integer)_phone_match_code_n AND (integer)_phone_match_code_n <= 0.5 => -0.0450270114,
    (integer)_phone_match_code_n > 0.5                                 => 0.1308441141,
    (integer)_phone_match_code_n = NULL                                => -0.0382180684,
                                                                 -0.0382180684);

final_score_14_c236 := map(
    NULL < mth_internal_ver_first_seen AND mth_internal_ver_first_seen <= 14.5 => 0.0954999366,
    mth_internal_ver_first_seen > 14.5                                         => 0.0337325267,
    mth_internal_ver_first_seen = NULL                                         => final_score_14_c237,
                                                                                  -0.0290249418);

final_score_14_c235 := map(
    (phone_subject_title in ['Associate By Address', 'Associate By Business', 'Associate By Shared Associates', 'Associate By SSN', 'Brother', 'Child', 'Daughter', 'Father', 'Grandchild', 'Granddaughter', 'Grandparent', 'Grandson', 'Neighbor', 'Relative', 'Sister', 'Wife']) => final_score_14_c236,
    (phone_subject_title in ['Associate', 'Associate By Property', 'Associate By Vehicle', 'Grandfather', 'Grandmother', 'Husband', 'Mother', 'Parent', 'Sibling', 'Son', 'Spouse', 'Subject', 'Subject at Household'])                                                            => 0.0187237010,
    phone_subject_title = ''                                                                                                                                                                                                                                                     => -0.0007448643,
                                                                                                                                                                                                                                                                                      -0.0007448643);

final_score_14_c234 := map(
    NULL < _mod_disc_noexp_lgt AND _mod_disc_noexp_lgt <= 1.1878183262628 => final_score_14_c235,
    _mod_disc_noexp_lgt > 1.1878183262628                                 => -0.0434108271,
    _mod_disc_noexp_lgt = NULL                                            => -0.0178289918,
                                                                             -0.0178289918);

final_score_14 := map(
    NULL < _mod_disc_noexp_lgt AND _mod_disc_noexp_lgt <= -1.41630058409201 => 0.0618200882,
    _mod_disc_noexp_lgt > -1.41630058409201                                 => final_score_14_c234,
    _mod_disc_noexp_lgt = NULL                                              => -0.0010864721,
                                                                               -0.0010864721);

final_score_15_c241 := map(
    (phone_subject_title in ['Associate By Business', 'Child', 'Daughter', 'Grandchild', 'Granddaughter', 'Grandfather', 'Grandson', 'Husband', 'Neighbor'])                                                                                                                                                                                  => -0.0859037140,
    (phone_subject_title in ['Associate', 'Associate By Address', 'Associate By Property', 'Associate By Shared Associates', 'Associate By SSN', 'Associate By Vehicle', 'Brother', 'Father', 'Grandmother', 'Grandparent', 'Mother', 'Parent', 'Relative', 'Sibling', 'Sister', 'Son', 'Spouse', 'Subject', 'Subject at Household', 'Wife']) => -0.0116981865,
    phone_subject_title = ''                                                                                                                                                                                                                                                                                                                => -0.0190054240,
                                                                                                                                                                                                                                                                                                                                                 -0.0190054240);

final_score_15_c242 := map(
    NULL < f_srchfraudsrchcount_i AND f_srchfraudsrchcount_i <= 1.5 => 0.0610547697,
    f_srchfraudsrchcount_i > 1.5                                    => 0.0047332197,
    f_srchfraudsrchcount_i = NULL                                   => 0.0280705698,
                                                                       0.0280705698);

final_score_15_c240 := map(
    NULL < number_of_sources AND number_of_sources <= 1.5 => final_score_15_c241,
    number_of_sources > 1.5                               => final_score_15_c242,
    number_of_sources = NULL                              => -0.0054372036,
                                                             -0.0054372036);

final_score_15_c239 := map(
    NULL < mth_source_ppth_lseen AND mth_source_ppth_lseen <= 11.5 => 0.0753135000,
    mth_source_ppth_lseen > 11.5                                   => -0.0796444522,
    mth_source_ppth_lseen = NULL                                   => final_score_15_c240,
                                                                      -0.0108945726);

final_score_15 := map(
    NULL < _mod_disc_noexp_lgt AND _mod_disc_noexp_lgt <= -1.87780920912683 => 0.0720977514,
    _mod_disc_noexp_lgt > -1.87780920912683                                 => final_score_15_c239,
    _mod_disc_noexp_lgt = NULL                                              => 0.0023527017,
                                                                               0.0023527017);

final_score_16_c246 := map(
    (phone_subject_title in ['Associate By Business', 'Associate By Property', 'Brother', 'Child', 'Grandchild', 'Granddaughter', 'Grandfather', 'Grandparent', 'Grandson', 'Husband', 'Neighbor', 'Sibling', 'Son'])                                                                => -0.0717180641,
    (phone_subject_title in ['Associate', 'Associate By Address', 'Associate By Shared Associates', 'Associate By SSN', 'Associate By Vehicle', 'Daughter', 'Father', 'Grandmother', 'Mother', 'Parent', 'Relative', 'Sister', 'Spouse', 'Subject', 'Subject at Household', 'Wife']) => -0.0034496499,
    phone_subject_title = ''                                                                                                                                                                                                                                                       => -0.0122474723,
                                                                                                                                                                                                                                                                                        -0.0122474723);

final_score_16_c245 := map(
    NULL < number_of_sources AND number_of_sources <= 1.5 => final_score_16_c246,
    number_of_sources > 1.5                               => 0.0330279957,
    number_of_sources = NULL                              => 0.0015543513,
                                                             0.0015543513);

final_score_16_c247 := map(
    NULL < mth_pp_datelastseen AND mth_pp_datelastseen <= 13.5 => 0.0065078971,
    mth_pp_datelastseen > 13.5                                 => -0.0689569669,
    mth_pp_datelastseen = NULL                                 => -0.0320866903,
                                                                  -0.0402980065);

final_score_16_c244 := map(
    NULL < _mod_disc_noexp_lgt AND _mod_disc_noexp_lgt <= 1.45386934539789 => final_score_16_c245,
    _mod_disc_noexp_lgt > 1.45386934539789                                 => final_score_16_c247,
    _mod_disc_noexp_lgt = NULL                                             => -0.0112144787,
                                                                              -0.0112144787);

final_score_16 := map(
    NULL < _mod_disc_noexp_lgt AND _mod_disc_noexp_lgt <= -2.11035307717214 => 0.0757108336,
    _mod_disc_noexp_lgt > -2.11035307717214                                 => final_score_16_c244,
    _mod_disc_noexp_lgt = NULL                                              => 0.0009359889,
                                                                               0.0009359889);

final_score_17_c250 := map(
    NULL < mth_internal_ver_first_seen AND mth_internal_ver_first_seen <= 6.5 => 0.0746818749,
    mth_internal_ver_first_seen > 6.5                                         => 0.0333018943,
    mth_internal_ver_first_seen = NULL                                        => -0.0214669581,
                                                                                 -0.0090304132);

final_score_17_c251 := map(
    NULL < mth_source_ppth_fseen AND mth_source_ppth_fseen <= 20.5 => 0.0398513609,
    mth_source_ppth_fseen > 20.5                                   => -0.0802280040,
    mth_source_ppth_fseen = NULL                                   => 0.0464201546,
                                                                      0.0396335549);

final_score_17_c249 := map(
    NULL < pk_phone_match_level AND pk_phone_match_level <= 1.5 => final_score_17_c250,
    pk_phone_match_level > 1.5                                  => final_score_17_c251,
    pk_phone_match_level = NULL                                 => 0.0207868274,
                                                                   0.0207868274);

final_score_17_c252 := map(
    NULL < _mod_disc_noexp_lgt AND _mod_disc_noexp_lgt <= 6.92120372409884 => -0.0204802303,
    _mod_disc_noexp_lgt > 6.92120372409884                                 => -0.0982404335,
    _mod_disc_noexp_lgt = NULL                                             => -0.0325308152,
                                                                              -0.0325308152);

final_score_17 := map(
    NULL < _mod_disc_noexp_lgt AND _mod_disc_noexp_lgt <= 1.06304750228728 => final_score_17_c249,
    _mod_disc_noexp_lgt > 1.06304750228728                                 => final_score_17_c252,
    _mod_disc_noexp_lgt = NULL                                             => 0.0024089317,
                                                                              0.0024089317);

final_score_18_c257 := map(
    NULL < (integer)inq_adl_firstseen_n AND (integer)inq_adl_firstseen_n <= 0.5 => -0.0105975345,
    (integer)inq_adl_firstseen_n > 0.5                                 => 0.0347605677,
    (integer)inq_adl_firstseen_n = NULL                                => 0.0213103671,
                                                                 0.0119145597);

final_score_18_c256 := map(
    NULL < _mod_disc_noexp_lgt AND _mod_disc_noexp_lgt <= 1.33399162664721 => final_score_18_c257,
    _mod_disc_noexp_lgt > 1.33399162664721                                 => -0.0226489697,
    _mod_disc_noexp_lgt = NULL                                             => 0.0012982548,
                                                                              0.0012982548);

final_score_18_c255 := map(
    (phone_subject_title in ['Associate By Business', 'Associate By Shared Associates', 'Associate By SSN', 'Child', 'Grandchild', 'Granddaughter', 'Grandson', 'Neighbor', 'Sibling', 'Wife'])                                                                                                            => -0.0481449559,
    (phone_subject_title in ['Associate', 'Associate By Address', 'Associate By Property', 'Associate By Vehicle', 'Brother', 'Daughter', 'Father', 'Grandfather', 'Grandmother', 'Grandparent', 'Husband', 'Mother', 'Parent', 'Relative', 'Sister', 'Son', 'Spouse', 'Subject', 'Subject at Household']) => final_score_18_c256,
    phone_subject_title = ''                                                                                                                                                                                                                                                                             => -0.0058851086,
                                                                                                                                                                                                                                                                                                              -0.0058851086);

final_score_18_c254 := map(
    NULL < mth_source_ppth_fseen AND mth_source_ppth_fseen <= 27.5 => 0.0498437263,
    mth_source_ppth_fseen > 27.5                                   => -0.0722925704,
    mth_source_ppth_fseen = NULL                                   => final_score_18_c255,
                                                                      -0.0106159483);

final_score_18 := map(
    NULL < _mod_disc_noexp_lgt AND _mod_disc_noexp_lgt <= -1.77802651650296 => 0.0564685697,
    _mod_disc_noexp_lgt > -1.77802651650296                                 => final_score_18_c254,
    _mod_disc_noexp_lgt = NULL                                              => 0.0004807703,
                                                                               0.0004807703);

final_score_19_c260 := map(
    NULL < r_c14_addrs_5yr_i AND r_c14_addrs_5yr_i <= 2.5 => -0.0027904000,
    r_c14_addrs_5yr_i > 2.5                               => -0.0633642247,
    r_c14_addrs_5yr_i = NULL                              => -0.0265571186,
                                                             -0.0265571186);

final_score_19_c262 := map(
    NULL < (integer)_phone_match_code_n AND (integer)_phone_match_code_n <= 0.5 => 0.0067120570,
    (integer)_phone_match_code_n > 0.5                                 => 0.1320371280,
    (integer)_phone_match_code_n = NULL                                => 0.0132896980,
                                                                 0.0132896980);

final_score_19_c261 := map(
    (phone_subject_title in ['Associate', 'Associate By Address', 'Associate By Business', 'Associate By Shared Associates', 'Associate By SSN', 'Child', 'Daughter', 'Granddaughter', 'Grandfather', 'Grandson', 'Neighbor', 'Relative', 'Sister', 'Subject']) => -0.0271251911,
    (phone_subject_title in ['Associate By Property', 'Associate By Vehicle', 'Brother', 'Father', 'Grandchild', 'Grandmother', 'Grandparent', 'Husband', 'Mother', 'Parent', 'Sibling', 'Son', 'Spouse', 'Subject at Household', 'Wife'])                      => final_score_19_c262,
    phone_subject_title = ''                                                                                                                                                                                                                                  => -0.0178971828,
                                                                                                                                                                                                                                                                   -0.0178971828);

final_score_19_c259 := map(
    NULL < mth_source_ppdid_fseen AND mth_source_ppdid_fseen <= 15.5 => 0.0448777289,
    mth_source_ppdid_fseen > 15.5                                    => final_score_19_c260,
    mth_source_ppdid_fseen = NULL                                    => final_score_19_c261,
                                                                        -0.0142015243);

final_score_19 := map(
    NULL < mth_exp_last_update AND mth_exp_last_update <= 54.5 => 0.0314845723,
    mth_exp_last_update > 54.5                                 => 0.0440805442,
    mth_exp_last_update = NULL                                 => final_score_19_c259,
                                                                  -0.0005737500);

final_score_20_c266 := map(
    NULL < mth_internal_ver_last_seen AND mth_internal_ver_last_seen <= 0.5 => 0.0294915620,
    mth_internal_ver_last_seen > 0.5                                        => 0.0845379004,
    mth_internal_ver_last_seen = NULL                                       => -0.0125122096,
                                                                               -0.0030766092);

final_score_20_c265 := map(
    (phone_subject_title in ['Associate', 'Associate By Business', 'Brother', 'Child', 'Grandchild', 'Granddaughter', 'Grandfather', 'Grandmother', 'Grandson', 'Neighbor', 'Relative', 'Sibling', 'Subject'])                                                                              => -0.0477211814,
    (phone_subject_title in ['Associate By Address', 'Associate By Property', 'Associate By Shared Associates', 'Associate By SSN', 'Associate By Vehicle', 'Daughter', 'Father', 'Grandparent', 'Husband', 'Mother', 'Parent', 'Sister', 'Son', 'Spouse', 'Subject at Household', 'Wife']) => final_score_20_c266,
    phone_subject_title = ''                                                                                                                                                                                                                                                              => -0.0199871716,
                                                                                                                                                                                                                                                                                               -0.0199871716);

final_score_20_c264 := map(
    NULL < mth_source_ppdid_fseen AND mth_source_ppdid_fseen <= 14.5 => 0.0529747688,
    mth_source_ppdid_fseen > 14.5                                    => -0.0316628577,
    mth_source_ppdid_fseen = NULL                                    => final_score_20_c265,
                                                                        -0.0174950970);

final_score_20_c267 := map(
    NULL < _mod_disc_noexp_lgt AND _mod_disc_noexp_lgt <= 6.54946023731156 => 0.0350162466,
    _mod_disc_noexp_lgt > 6.54946023731156                                 => -0.0840354985,
    _mod_disc_noexp_lgt = NULL                                             => 0.0277274296,
                                                                              0.0277274296);

final_score_20 := map(
    NULL < number_of_sources AND number_of_sources <= 1.5 => final_score_20_c264,
    number_of_sources > 1.5                               => final_score_20_c267,
    number_of_sources = NULL                              => -0.0009342492,
                                                             -0.0009342492);

final_score_21_c272 := map(
    NULL < eda_address_match_best AND eda_address_match_best <= 0.5 => -0.0051132694,
    eda_address_match_best > 0.5                                    => 0.0886213780,
    eda_address_match_best = NULL                                   => -0.0005556898,
                                                                       -0.0005556898);

final_score_21_c271 := map(
    (phone_subject_title in ['Associate By Business', 'Child', 'Granddaughter', 'Grandson', 'Neighbor', 'Sibling'])                                                                                                                                                                                                                                                                    => -0.0821771785,
    (phone_subject_title in ['Associate', 'Associate By Address', 'Associate By Property', 'Associate By Shared Associates', 'Associate By SSN', 'Associate By Vehicle', 'Brother', 'Daughter', 'Father', 'Grandchild', 'Grandfather', 'Grandmother', 'Grandparent', 'Husband', 'Mother', 'Parent', 'Relative', 'Sister', 'Son', 'Spouse', 'Subject', 'Subject at Household', 'Wife']) => final_score_21_c272,
    phone_subject_title = ''                                                                                                                                                                                                                                                                                                                                                         => -0.0085045768,
                                                                                                                                                                                                                                                                                                                                                                                          -0.0085045768);

final_score_21_c270 := map(
    NULL < mth_source_ppth_fseen AND mth_source_ppth_fseen <= 11.5 => 0.1007014706,
    mth_source_ppth_fseen > 11.5                                   => -0.0605846471,
    mth_source_ppth_fseen = NULL                                   => final_score_21_c271,
                                                                      -0.0138390708);

final_score_21_c269 := map(
    NULL < mth_source_ppdid_lseen AND mth_source_ppdid_lseen <= 24.5 => 0.0293529210,
    mth_source_ppdid_lseen > 24.5                                    => -0.0262326554,
    mth_source_ppdid_lseen = NULL                                    => final_score_21_c270,
                                                                        -0.0063975516);

final_score_21 := map(
    NULL < number_of_sources AND number_of_sources <= 2.5 => final_score_21_c269,
    number_of_sources > 2.5                               => 0.0503262530,
    number_of_sources = NULL                              => 0.0022855487,
                                                             0.0022855487);

final_score_22_c274 := map(
    NULL < (integer)inq_adl_firstseen_n AND (integer)inq_adl_firstseen_n <= 0.5 => -0.0069406445,
    (integer)inq_adl_firstseen_n > 0.5                                 => 0.0415559685,
    (integer)inq_adl_firstseen_n = NULL                                => 0.0254493979,
                                                                 0.0180783354);

final_score_22_c276 := map(
    (pp_app_ph_type in ['', 'CELL', 'PAGE', 'POTS', 'Puerto Rico/US Virgin Isl']) => -0.0343499347,
    (pp_app_ph_type in ['LNDLN PRTD TO CELL', 'VOIP'])                            => 0.0743378274,
    pp_app_ph_type = ''                                                         => -0.0308097377,
                                                                                     -0.0308097377);

final_score_22_c277 := map(
    NULL < (integer)_phone_match_code_n AND (integer)_phone_match_code_n <= 0.5 => 0.0065490519,
    (integer)_phone_match_code_n > 0.5                                 => 0.1484690735,
    (integer)_phone_match_code_n = NULL                                => 0.0123395779,
                                                                 0.0123395779);

final_score_22_c275 := map(
    (phone_subject_title in ['Associate', 'Associate By Address', 'Associate By Business', 'Associate By SSN', 'Brother', 'Child', 'Daughter', 'Grandchild', 'Granddaughter', 'Grandfather', 'Grandson', 'Husband', 'Neighbor', 'Parent', 'Subject']) => final_score_22_c276,
    (phone_subject_title in ['Associate By Property', 'Associate By Shared Associates', 'Associate By Vehicle', 'Father', 'Grandmother', 'Grandparent', 'Mother', 'Relative', 'Sibling', 'Sister', 'Son', 'Spouse', 'Subject at Household', 'Wife'])  => final_score_22_c277,
    phone_subject_title = ''                                                                                                                                                                                                                        => -0.0189403041,
                                                                                                                                                                                                                                                         -0.0189403041);

final_score_22 := map(
    NULL < _mod_disc_noexp_lgt AND _mod_disc_noexp_lgt <= 0.591309391703079 => final_score_22_c274,
    _mod_disc_noexp_lgt > 0.591309391703079                                 => final_score_22_c275,
    _mod_disc_noexp_lgt = NULL                                              => 0.0010163841,
                                                                               0.0010163841);

final_score_23_c280 := map(
    NULL < mth_source_ppth_fseen AND mth_source_ppth_fseen <= 79.5 => 0.0044734504,
    mth_source_ppth_fseen > 79.5                                   => -0.1043930570,
    mth_source_ppth_fseen = NULL                                   => 0.0228163003,
                                                                      0.0203748294);

final_score_23_c279 := map(
    (phone_subject_title in ['Associate', 'Associate By Business', 'Associate By Shared Associates', 'Child', 'Grandchild', 'Granddaughter', 'Grandmother', 'Grandparent', 'Grandson', 'Husband', 'Neighbor', 'Relative', 'Sibling', 'Son'])                  => -0.0193358525,
    (phone_subject_title in ['Associate By Address', 'Associate By Property', 'Associate By SSN', 'Associate By Vehicle', 'Brother', 'Daughter', 'Father', 'Grandfather', 'Mother', 'Parent', 'Sister', 'Spouse', 'Subject', 'Subject at Household', 'Wife']) => final_score_23_c280,
    phone_subject_title = ''                                                                                                                                                                                                                                => 0.0137291794,
                                                                                                                                                                                                                                                                 0.0137291794);

final_score_23_c282 := map(
    NULL < mth_pp_datevendorfirstseen AND mth_pp_datevendorfirstseen <= 14.5 => 0.0078094275,
    mth_pp_datevendorfirstseen > 14.5                                        => -0.0673107617,
    mth_pp_datevendorfirstseen = NULL                                        => -0.0303259100,
                                                                                -0.0446587395);

final_score_23_c281 := map(
    NULL < (integer)inq_lastseen_n AND (integer)inq_lastseen_n <= 9.5 => 0.0535832275,
    (integer)inq_lastseen_n > 9.5                            => -0.0116913611,
    (integer)inq_lastseen_n = NULL                           => final_score_23_c282,
                                                       -0.0282497639);

final_score_23 := map(
    NULL < _mod_disc_noexp_lgt AND _mod_disc_noexp_lgt <= 1.31667653754452 => final_score_23_c279,
    _mod_disc_noexp_lgt > 1.31667653754452                                 => final_score_23_c281,
    _mod_disc_noexp_lgt = NULL                                             => 0.0016734280,
                                                                              0.0016734280);

final_score_24_c285 := map(
    NULL < source_pp_any_clean AND source_pp_any_clean <= 0.5 => -0.0467610130,
    source_pp_any_clean > 0.5                                 => 0.0150227036,
    source_pp_any_clean = NULL                                => 0.0034994394,
                                                                 0.0034994394);

final_score_24_c284 := map(
    NULL < mth_pp_first_build_date AND mth_pp_first_build_date <= 16.5 => final_score_24_c285,
    mth_pp_first_build_date > 16.5                                     => -0.0388184876,
    mth_pp_first_build_date = NULL                                     => -0.0165421684,
                                                                          -0.0117781296);

final_score_24_c287 := map(
    NULL < _mod_disc_noexp_lgt AND _mod_disc_noexp_lgt <= -1.12305320065123 => 0.0308683488,
    _mod_disc_noexp_lgt > -1.12305320065123                                 => -0.0677703891,
    _mod_disc_noexp_lgt = NULL                                              => -0.0220777589,
                                                                               -0.0220777589);

final_score_24_c286 := map(
    NULL < f_srchssnsrchcount_i AND f_srchssnsrchcount_i <= 7.5 => 0.0340661381,
    f_srchssnsrchcount_i > 7.5                                  => final_score_24_c287,
    f_srchssnsrchcount_i = NULL                                 => 0.0254339892,
                                                                   0.0254339892);

final_score_24 := map(
    NULL < number_of_sources AND number_of_sources <= 1.5 => final_score_24_c284,
    number_of_sources > 1.5                               => final_score_24_c286,
    number_of_sources = NULL                              => 0.0018650277,
                                                             0.0018650277);

final_score_25_c291 := map(
    NULL < mth_source_ppdid_fseen AND mth_source_ppdid_fseen <= 13.5 => 0.0326616506,
    mth_source_ppdid_fseen > 13.5                                    => -0.0172642428,
    mth_source_ppdid_fseen = NULL                                    => -0.0200735892,
                                                                        -0.0153034556);

final_score_25_c292 := map(
    NULL < _mod_disc_noexp_lgt AND _mod_disc_noexp_lgt <= 4.54271518617669 => 0.0491380133,
    _mod_disc_noexp_lgt > 4.54271518617669                                 => -0.0495809696,
    _mod_disc_noexp_lgt = NULL                                             => 0.0256085831,
                                                                              0.0256085831);

final_score_25_c290 := map(
    NULL < (integer)_internal_ver_match_hhid AND (integer)_internal_ver_match_hhid <= 0.5 => final_score_25_c291,
    (integer)_internal_ver_match_hhid > 0.5                                      => final_score_25_c292,
    (integer)_internal_ver_match_hhid = NULL                                     => -0.0106866213,
                                                                           -0.0106866213);

final_score_25_c289 := map(
    NULL < eda_address_match_best AND eda_address_match_best <= 0.5 => final_score_25_c290,
    eda_address_match_best > 0.5                                    => 0.0606145070,
    eda_address_match_best = NULL                                   => -0.0074248047,
                                                                       -0.0074248047);

final_score_25 := map(
    NULL < _mod_disc_noexp_lgt AND _mod_disc_noexp_lgt <= -2.03501813256585 => 0.0490693779,
    _mod_disc_noexp_lgt > -2.03501813256585                                 => final_score_25_c289,
    _mod_disc_noexp_lgt = NULL                                              => 0.0007908027,
                                                                               0.0007908027);

final_score_26_c296 := map(
    NULL < f_inq_collection_count_i AND f_inq_collection_count_i <= 14.5 => 0.0066140928,
    f_inq_collection_count_i > 14.5                                      => -0.0531241308,
    f_inq_collection_count_i = NULL                                      => 0.0033505378,
                                                                            0.0033505378);

final_score_26_c295 := map(
    NULL < mth_source_ppth_lseen AND mth_source_ppth_lseen <= 7.5 => 0.0700214387,
    mth_source_ppth_lseen > 7.5                                   => -0.0448416317,
    mth_source_ppth_lseen = NULL                                  => final_score_26_c296,
                                                                     -0.0015534521);

final_score_26_c294 := map(
    (phone_subject_title in ['Associate By Address', 'Associate By Business', 'Associate By Property', 'Associate By SSN', 'Grandchild', 'Granddaughter', 'Grandfather', 'Grandparent', 'Neighbor'])                                                                                                  => -0.0375262478,
    (phone_subject_title in ['Associate', 'Associate By Shared Associates', 'Associate By Vehicle', 'Brother', 'Child', 'Daughter', 'Father', 'Grandmother', 'Grandson', 'Husband', 'Mother', 'Parent', 'Relative', 'Sibling', 'Sister', 'Son', 'Spouse', 'Subject', 'Subject at Household', 'Wife']) => final_score_26_c295,
    phone_subject_title = ''                                                                                                                                                                                                                                                                        => -0.0098312424,
                                                                                                                                                                                                                                                                                                         -0.0098312424);

final_score_26_c297 := map(
    NULL < r_c14_addrs_10yr_i AND r_c14_addrs_10yr_i <= 9.5 => 0.0392695583,
    r_c14_addrs_10yr_i > 9.5                                => -0.0554571207,
    r_c14_addrs_10yr_i = NULL                               => 0.0294407131,
                                                               0.0294407131);

final_score_26 := map(
    (exp_source in ['', 'P']) => final_score_26_c294,
    (exp_source in ['S'])     => final_score_26_c297,
    exp_source = ''         => -0.0005967702,
                                 -0.0005967702);

final_score_27_c301 := map(
    NULL < r_i60_inq_hiriskcred_recency_d AND r_i60_inq_hiriskcred_recency_d <= 549 => -0.0589820880,
    r_i60_inq_hiriskcred_recency_d > 549                                            => 0.0058639911,
    r_i60_inq_hiriskcred_recency_d = NULL                                           => -0.0234210879,
                                                                                       -0.0234210879);

final_score_27_c300 := map(
    NULL < mth_source_ppdid_fseen AND mth_source_ppdid_fseen <= 22.5 => 0.0248505008,
    mth_source_ppdid_fseen > 22.5                                    => final_score_27_c301,
    mth_source_ppdid_fseen = NULL                                    => -0.0144771615,
                                                                        -0.0114078191);

final_score_27_c299 := map(
    NULL < mth_source_sx_fseen AND mth_source_sx_fseen <= 14.5 => 0.0857960696,
    mth_source_sx_fseen > 14.5                                 => 0.0285581586,
    mth_source_sx_fseen = NULL                                 => final_score_27_c300,
                                                                  -0.0078534664);

final_score_27_c302 := map(
    NULL < f_srchfraudsrchcount_i AND f_srchfraudsrchcount_i <= 7.5 => 0.0405232168,
    f_srchfraudsrchcount_i > 7.5                                    => -0.0260614659,
    f_srchfraudsrchcount_i = NULL                                   => 0.0278008417,
                                                                       0.0278008417);

final_score_27 := map(
    (exp_source in ['', 'P']) => final_score_27_c299,
    (exp_source in ['S'])     => final_score_27_c302,
    exp_source = ''         => 0.0003863764,
                                 0.0003863764);

final_score_28_c304 := map(
    NULL < (integer)inq_adl_firstseen_n AND (integer)inq_adl_firstseen_n <= 0.5 => -0.0075039007,
    (integer)inq_adl_firstseen_n > 0.5                                 => 0.0354108940,
    (integer)inq_adl_firstseen_n = NULL                                => 0.0218695699,
                                                                 0.0158322742);

final_score_28_c307 := map(
    (pp_src in ['', 'CY', 'E1', 'EB', 'EM', 'EN', 'EQ', 'FA', 'FF', 'KW', 'LA', 'MD', 'SV', 'TN', 'UT', 'VO', 'VW', 'YE']) => -0.0567707005,
    (pp_src in ['E2', 'E4', 'LP', 'NW', 'PL', 'SL', 'UW', 'ZK', 'ZT'])                                                     => 0.0456278331,
    pp_src = ''                                                                                                          => -0.0452665531,
                                                                                                                              -0.0452665531);

final_score_28_c306 := map(
    NULL < pp_app_ind_ph_cnt AND pp_app_ind_ph_cnt <= 5.5 => -0.0094169046,
    pp_app_ind_ph_cnt > 5.5                               => final_score_28_c307,
    pp_app_ind_ph_cnt = NULL                              => -0.0162043028,
                                                             -0.0162043028);

final_score_28_c305 := map(
    NULL < mth_source_edaca_lseen AND mth_source_edaca_lseen <= 6.5 => 0.0623133524,
    mth_source_edaca_lseen > 6.5                                    => -0.0654846197,
    mth_source_edaca_lseen = NULL                                   => final_score_28_c306,
                                                                       -0.0161585200);

final_score_28 := map(
    NULL < _mod_disc_noexp_lgt AND _mod_disc_noexp_lgt <= 0.313867728357088 => final_score_28_c304,
    _mod_disc_noexp_lgt > 0.313867728357088                                 => final_score_28_c305,
    _mod_disc_noexp_lgt = NULL                                              => -0.0008260515,
                                                                               -0.0008260515);

final_score_29_c311 := map(
    (phone_subject_title in ['Associate', 'Associate By Address', 'Associate By Business', 'Associate By Property', 'Associate By Shared Associates', 'Associate By SSN', 'Child', 'Daughter', 'Grandchild', 'Granddaughter', 'Grandfather', 'Grandmother', 'Grandson', 'Husband', 'Neighbor', 'Sister', 'Son', 'Spouse']) => -0.0125180692,
    (phone_subject_title in ['Associate By Vehicle', 'Brother', 'Father', 'Grandparent', 'Mother', 'Parent', 'Relative', 'Sibling', 'Subject', 'Subject at Household', 'Wife'])                                                                                                                                            => 0.0310698109,
    phone_subject_title = ''                                                                                                                                                                                                                                                                                             => 0.0155900404,
                                                                                                                                                                                                                                                                                                                              0.0155900404);

final_score_29_c312 := map(
    NULL < (integer)_inq_adl_ph_industry_flag AND (integer)_inq_adl_ph_industry_flag <= 0.5 => -0.0154518435,
    (integer)_inq_adl_ph_industry_flag > 0.5                                       => 0.0539140360,
    (integer)_inq_adl_ph_industry_flag = NULL                                      => -0.0083274460,
                                                                             -0.0083274460);

final_score_29_c310 := map(
    NULL < f_srchfraudsrchcount_i AND f_srchfraudsrchcount_i <= 1.5 => final_score_29_c311,
    f_srchfraudsrchcount_i > 1.5                                    => final_score_29_c312,
    f_srchfraudsrchcount_i = NULL                                   => 0.0016283853,
                                                                       0.0016283853);

final_score_29_c309 := map(
    (pp_app_coctype in ['', 'PMC', 'RCC', 'SP2']) => final_score_29_c310,
    (pp_app_coctype in ['EOC'])                   => 0.0666944550,
    pp_app_coctype = ''                         => 0.0048327475,
                                                     0.0048327475);

final_score_29 := map(
    NULL < _mod_disc_noexp_lgt AND _mod_disc_noexp_lgt <= 4.90251668051469 => final_score_29_c309,
    _mod_disc_noexp_lgt > 4.90251668051469                                 => -0.0597619907,
    _mod_disc_noexp_lgt = NULL                                             => -0.0006454733,
                                                                              -0.0006454733);

final_score_30_c317 := map(
    (phone_subject_title in ['Associate By Business', 'Associate By Property', 'Associate By SSN', 'Child', 'Father', 'Grandchild', 'Granddaughter', 'Grandfather', 'Grandmother', 'Grandparent', 'Grandson', 'Neighbor', 'Sibling'])                                => -0.0508000387,
    (phone_subject_title in ['Associate', 'Associate By Address', 'Associate By Shared Associates', 'Associate By Vehicle', 'Brother', 'Daughter', 'Husband', 'Mother', 'Parent', 'Relative', 'Sister', 'Son', 'Spouse', 'Subject', 'Subject at Household', 'Wife']) => 0.0140541926,
    phone_subject_title = ''                                                                                                                                                                                                                                       => 0.0057020238,
                                                                                                                                                                                                                                                                        0.0057020238);

final_score_30_c316 := map(
    NULL < mth_exp_last_update AND mth_exp_last_update <= 54.5 => 0.0336426397,
    mth_exp_last_update > 54.5                                 => 0.0850650039,
    mth_exp_last_update = NULL                                 => final_score_30_c317,
                                                                  0.0156774572);

final_score_30_c315 := map(
    NULL < f_inq_count_i AND f_inq_count_i <= 7.5 => final_score_30_c316,
    f_inq_count_i > 7.5                           => -0.0090157367,
    f_inq_count_i = NULL                          => 0.0024116878,
                                                     0.0024116878);

final_score_30_c314 := map(
    NULL < mth_source_paw_lseen AND mth_source_paw_lseen <= 23.5 => 0.1148625103,
    mth_source_paw_lseen > 23.5                                  => 0.0234387761,
    mth_source_paw_lseen = NULL                                  => final_score_30_c315,
                                                                    0.0040650231);

final_score_30 := map(
    NULL < _mod_disc_noexp_lgt AND _mod_disc_noexp_lgt <= 6.46503367674639 => final_score_30_c314,
    _mod_disc_noexp_lgt > 6.46503367674639                                 => -0.0762604936,
    _mod_disc_noexp_lgt = NULL                                             => -0.0010091316,
                                                                              -0.0010091316);

final_score_31_c319 := map(
    NULL < mth_source_ppth_fseen AND mth_source_ppth_fseen <= 39.5 => 0.0386397869,
    mth_source_ppth_fseen > 39.5                                   => -0.0955826631,
    mth_source_ppth_fseen = NULL                                   => -0.0108418235,
                                                                      -0.0144785423);

final_score_31_c322 := map(
    (phone_subject_title in ['Associate By Business', 'Father', 'Grandchild', 'Granddaughter', 'Neighbor', 'Son', 'Wife'])                                                                                                                                                                                                                                                      => -0.0368282666,
    (phone_subject_title in ['Associate', 'Associate By Address', 'Associate By Property', 'Associate By Shared Associates', 'Associate By SSN', 'Associate By Vehicle', 'Brother', 'Child', 'Daughter', 'Grandfather', 'Grandmother', 'Grandparent', 'Grandson', 'Husband', 'Mother', 'Parent', 'Relative', 'Sibling', 'Sister', 'Spouse', 'Subject', 'Subject at Household']) => 0.0241478113,
    phone_subject_title = ''                                                                                                                                                                                                                                                                                                                                                  => 0.0189905858,
                                                                                                                                                                                                                                                                                                                                                                                   0.0189905858);

final_score_31_c321 := map(
    NULL < mth_source_ppth_fseen AND mth_source_ppth_fseen <= 77.5 => 0.0264564521,
    mth_source_ppth_fseen > 77.5                                   => -0.0809194990,
    mth_source_ppth_fseen = NULL                                   => final_score_31_c322,
                                                                      0.0152509310);

final_score_31_c320 := map(
    NULL < r_s65_ssn_deceased_i AND r_s65_ssn_deceased_i <= 0.5 => final_score_31_c321,
    r_s65_ssn_deceased_i > 0.5                                  => -0.0820424867,
    r_s65_ssn_deceased_i = NULL                                 => 0.0241330022,
                                                                   0.0134832453);

final_score_31 := map(
    NULL < f_mos_inq_banko_cm_lseen_d AND f_mos_inq_banko_cm_lseen_d <= 57.5 => final_score_31_c319,
    f_mos_inq_banko_cm_lseen_d > 57.5                                        => final_score_31_c320,
    f_mos_inq_banko_cm_lseen_d = NULL                                        => -0.0004170643,
                                                                                -0.0004170643);

final_score_32_c327 := map(
    (pp_app_ph_type in ['', 'CELL'])                                                                => 0.0154838392,
    (pp_app_ph_type in ['LNDLN PRTD TO CELL', 'PAGE', 'POTS', 'Puerto Rico/US Virgin Isl', 'VOIP']) => 0.0891542033,
    pp_app_ph_type = ''                                                                           => 0.0185217978,
                                                                                                       0.0185217978);

final_score_32_c326 := map(
    NULL < r_c14_addrs_15yr_i AND r_c14_addrs_15yr_i <= 7.5 => final_score_32_c327,
    r_c14_addrs_15yr_i > 7.5                                => -0.0054949172,
    r_c14_addrs_15yr_i = NULL                               => 0.0073139209,
                                                               0.0073139209);

final_score_32_c325 := map(
    (phone_subject_title in ['Associate By Business', 'Associate By SSN', 'Child', 'Grandchild', 'Granddaughter', 'Grandfather', 'Grandparent', 'Grandson', 'Neighbor', 'Sibling', 'Son', 'Spouse'])                                                                                                  => -0.0566621125,
    (phone_subject_title in ['Associate', 'Associate By Address', 'Associate By Property', 'Associate By Shared Associates', 'Associate By Vehicle', 'Brother', 'Daughter', 'Father', 'Grandmother', 'Husband', 'Mother', 'Parent', 'Relative', 'Sister', 'Subject', 'Subject at Household', 'Wife']) => final_score_32_c326,
    phone_subject_title = ''                                                                                                                                                                                                                                                                        => 0.0032109435,
                                                                                                                                                                                                                                                                                                         0.0032109435);

final_score_32_c324 := map(
    NULL < _mod_disc_noexp_lgt AND _mod_disc_noexp_lgt <= 4.08457141092706 => final_score_32_c325,
    _mod_disc_noexp_lgt > 4.08457141092706                                 => -0.0530778470,
    _mod_disc_noexp_lgt = NULL                                             => -0.0020793832,
                                                                              -0.0020793832);

final_score_32 := map(
    (pp_app_ph_type in ['', 'CELL', 'PAGE', 'POTS', 'Puerto Rico/US Virgin Isl', 'VOIP']) => final_score_32_c324,
    (pp_app_ph_type in ['LNDLN PRTD TO CELL'])                                            => 0.1099812524,
    pp_app_ph_type = ''                                                                 => -0.0008667004,
                                                                                             -0.0008667004);

final_score_33_c331 := map(
    NULL < pk_cell_indicator AND pk_cell_indicator <= 1.5 => -0.0403066106,
    pk_cell_indicator > 1.5                               => 0.0073072621,
    pk_cell_indicator = NULL                              => -0.0196167521,
                                                             -0.0196167521);

final_score_33_c330 := map(
    NULL < (integer)inq_lastseen_n AND (integer)inq_lastseen_n <= 6.5 => -0.0791237064,
    (integer)inq_lastseen_n > 6.5                            => -0.0069193666,
    (integer)inq_lastseen_n = NULL                           => final_score_33_c331,
                                                       -0.0181284056);

final_score_33_c332 := map(
    NULL < mth_eda_dt_first_seen AND mth_eda_dt_first_seen <= 4.5 => 0.0505835630,
    mth_eda_dt_first_seen > 4.5                                   => -0.0024448689,
    mth_eda_dt_first_seen = NULL                                  => 0.0131628009,
                                                                     0.0063040339);

final_score_33_c329 := map(
    (pp_origlistingtype in ['BG', 'R', 'RB']) => final_score_33_c330,
    (pp_origlistingtype in ['', 'B'])         => final_score_33_c332,
    pp_origlistingtype = ''                 => -0.0026558273,
                                                 -0.0026558273);

final_score_33 := map(
    NULL < (integer)_inq_adl_ph_industry_flag AND (integer)_inq_adl_ph_industry_flag <= 0.5 => final_score_33_c329,
    (integer)_inq_adl_ph_industry_flag > 0.5                                       => 0.0723583618,
    (integer)_inq_adl_ph_industry_flag = NULL                                      => 0.0021660407,
                                                                             0.0021660407);

final_score_34_c335 := map(
    NULL < r_c14_addrs_10yr_i AND r_c14_addrs_10yr_i <= 1.5 => 0.0806912781,
    r_c14_addrs_10yr_i > 1.5                                => -0.0098160507,
    r_c14_addrs_10yr_i = NULL                               => 0.0044344102,
                                                               0.0044344102);

final_score_34_c337 := map(
    NULL < mth_source_inf_fseen AND mth_source_inf_fseen <= 184.5 => -0.0633023469,
    mth_source_inf_fseen > 184.5                                  => 0.0119938937,
    mth_source_inf_fseen = NULL                                   => -0.0043249904,
                                                                     -0.0066304220);

final_score_34_c336 := map(
    NULL < eda_address_match_best AND eda_address_match_best <= 0.5 => final_score_34_c337,
    eda_address_match_best > 0.5                                    => 0.0442344690,
    eda_address_match_best = NULL                                   => -0.0039024483,
                                                                       -0.0039024483);

final_score_34_c334 := map(
    NULL < mth_source_utildid_fseen AND mth_source_utildid_fseen <= 4.5 => 0.1341846090,
    mth_source_utildid_fseen > 4.5                                      => final_score_34_c335,
    mth_source_utildid_fseen = NULL                                     => final_score_34_c336,
                                                                           -0.0020978680);

final_score_34 := map(
    NULL < _mod_disc_noexp_lgt AND _mod_disc_noexp_lgt <= -2.66303798038086 => 0.0544781157,
    _mod_disc_noexp_lgt > -2.66303798038086                                 => final_score_34_c334,
    _mod_disc_noexp_lgt = NULL                                              => 0.0035221483,
                                                                               0.0035221483);

final_score_35_c342 := map(
    NULL < f_srchvelocityrisktype_i AND f_srchvelocityrisktype_i <= 6.5 => -0.0063660695,
    f_srchvelocityrisktype_i > 6.5                                      => -0.0558624513,
    f_srchvelocityrisktype_i = NULL                                     => -0.0112519042,
                                                                           -0.0112519042);

final_score_35_c341 := map(
    NULL < mth_source_ppca_lseen AND mth_source_ppca_lseen <= 15.5 => 0.0259282976,
    mth_source_ppca_lseen > 15.5                                   => -0.0209943565,
    mth_source_ppca_lseen = NULL                                   => final_score_35_c342,
                                                                      -0.0086796147);

final_score_35_c340 := map(
    NULL < mth_source_paw_lseen AND mth_source_paw_lseen <= 69.5 => 0.0737214092,
    mth_source_paw_lseen > 69.5                                  => -0.0256219314,
    mth_source_paw_lseen = NULL                                  => final_score_35_c341,
                                                                    -0.0073564191);

final_score_35_c339 := map(
    (pp_app_ph_type in ['', 'CELL', 'PAGE', 'POTS', 'Puerto Rico/US Virgin Isl', 'VOIP']) => final_score_35_c340,
    (pp_app_ph_type in ['LNDLN PRTD TO CELL'])                                            => 0.0873443840,
    pp_app_ph_type = ''                                                                 => -0.0060879581,
                                                                                             -0.0060879581);

final_score_35 := map(
    NULL < _mod_disc_noexp_lgt AND _mod_disc_noexp_lgt <= -1.95121708109923 => 0.0377032009,
    _mod_disc_noexp_lgt > -1.95121708109923                                 => final_score_35_c339,
    _mod_disc_noexp_lgt = NULL                                              => 0.0005465413,
                                                                               0.0005465413);

final_score_36_c346 := map(
    NULL < mth_exp_last_update AND mth_exp_last_update <= 58.5 => 0.0022684657,
    mth_exp_last_update > 58.5                                 => 0.1057595525,
    mth_exp_last_update = NULL                                 => -0.0122743929,
                                                                  -0.0086656041);

final_score_36_c347 := map(
    (phone_subject_title in ['Associate', 'Associate By Shared Associates', 'Associate By SSN', 'Daughter', 'Grandfather', 'Grandmother', 'Grandson', 'Husband', 'Mother', 'Sibling', 'Subject', 'Subject at Household'])                                                        => 0.0174109868,
    (phone_subject_title in ['Associate By Address', 'Associate By Business', 'Associate By Property', 'Associate By Vehicle', 'Brother', 'Child', 'Father', 'Grandchild', 'Granddaughter', 'Grandparent', 'Neighbor', 'Parent', 'Relative', 'Sister', 'Son', 'Spouse', 'Wife']) => 0.1160279702,
    phone_subject_title = ''                                                                                                                                                                                                                                                   => 0.0219366019,
                                                                                                                                                                                                                                                                                    0.0219366019);

final_score_36_c345 := map(
    NULL < (integer)_phone_match_code_lns AND (integer)_phone_match_code_lns <= 0.5 => final_score_36_c346,
    (integer)_phone_match_code_lns > 0.5                                   => final_score_36_c347,
    (integer)_phone_match_code_lns = NULL                                  => 0.0064750028,
                                                                     0.0064750028);

final_score_36_c344 := map(
    (pp_origlistingtype in ['R', 'RB'])     => -0.0210593173,
    (pp_origlistingtype in ['', 'B', 'BG']) => final_score_36_c345,
    pp_origlistingtype = ''               => -0.0028386274,
                                               -0.0028386274);

final_score_36 := map(
    NULL < (integer)_internal_ver_match_hhid AND (integer)_internal_ver_match_hhid <= 0.5 => final_score_36_c344,
    (integer)_internal_ver_match_hhid > 0.5                                      => 0.0334329464,
    (integer)_internal_ver_match_hhid = NULL                                     => 0.0015435717,
                                                                           0.0015435717);

final_score_37_c352 := map(
    NULL < eda_address_match_best AND eda_address_match_best <= 0.5 => -0.0102515622,
    eda_address_match_best > 0.5                                    => 0.0403864896,
    eda_address_match_best = NULL                                   => -0.0066193030,
                                                                       -0.0066193030);

final_score_37_c351 := map(
    NULL < (integer)_internal_ver_match_hhid AND (integer)_internal_ver_match_hhid <= 0.5 => final_score_37_c352,
    (integer)_internal_ver_match_hhid > 0.5                                      => 0.0282204880,
    (integer)_internal_ver_match_hhid = NULL                                     => -0.0026121860,
                                                                           -0.0026121860);

final_score_37_c350 := map(
    NULL < mth_source_utildid_fseen AND mth_source_utildid_fseen <= 4.5 => 0.1276484693,
    mth_source_utildid_fseen > 4.5                                      => 0.0099079235,
    mth_source_utildid_fseen = NULL                                     => final_score_37_c351,
                                                                           0.0002506052);

final_score_37_c349 := map(
    NULL < mth_source_paw_lseen AND mth_source_paw_lseen <= 0.5 => -0.0903942423,
    mth_source_paw_lseen > 0.5                                  => 0.0648937356,
    mth_source_paw_lseen = NULL                                 => final_score_37_c350,
                                                                   0.0014322026);

final_score_37 := map(
    NULL < mth_source_ppth_fseen AND mth_source_ppth_fseen <= 14.5 => 0.0916527533,
    mth_source_ppth_fseen > 14.5                                   => -0.0426646011,
    mth_source_ppth_fseen = NULL                                   => final_score_37_c349,
                                                                      -0.0011782231);

final_score_38_c356 := map(
    NULL < mth_source_ppca_lseen AND mth_source_ppca_lseen <= 18.5 => 0.0225467070,
    mth_source_ppca_lseen > 18.5                                   => -0.0536961405,
    mth_source_ppca_lseen = NULL                                   => -0.0115151469,
                                                                      -0.0099957823);

final_score_38_c355 := map(
    (pp_origlistingtype in ['BG', 'R', 'RB']) => final_score_38_c356,
    (pp_origlistingtype in ['', 'B'])         => 0.0173028015,
    pp_origlistingtype = ''                 => 0.0025679285,
                                                 0.0025679285);

final_score_38_c354 := map(
    (eda_pfrd_address_ind in ['1A', '1B'])             => -0.0237570695,
    (eda_pfrd_address_ind in ['1C', '1D', '1E', 'XX']) => final_score_38_c355,
    eda_pfrd_address_ind = ''                        => -0.0043271553,
                                                          -0.0043271553);

final_score_38_c357 := map(
    (phone_subject_title in ['Associate', 'Associate By Address', 'Associate By Property', 'Brother', 'Daughter', 'Grandfather', 'Husband', 'Mother', 'Neighbor', 'Relative', 'Sister', 'Son', 'Subject', 'Subject at Household'])                                      => 0.0289353063,
    (phone_subject_title in ['Associate By Business', 'Associate By Shared Associates', 'Associate By SSN', 'Associate By Vehicle', 'Child', 'Father', 'Grandchild', 'Granddaughter', 'Grandmother', 'Grandparent', 'Grandson', 'Parent', 'Sibling', 'Spouse', 'Wife']) => 0.1544689310,
    phone_subject_title = ''                                                                                                                                                                                                                                          => 0.0404946542,
                                                                                                                                                                                                                                                                           0.0404946542);

final_score_38 := map(
    NULL < eda_address_match_best AND eda_address_match_best <= 0.5 => final_score_38_c354,
    eda_address_match_best > 0.5                                    => final_score_38_c357,
    eda_address_match_best = NULL                                   => -0.0016690732,
                                                                       -0.0016690732);

final_score_39_c362 := map(
    NULL < (integer)inq_adl_lastseen_n AND (integer)inq_adl_lastseen_n <= 15.5 => -0.0003309036,
    (integer)inq_adl_lastseen_n > 15.5                                => -0.1349066744,
    (integer)inq_adl_lastseen_n = NULL                                => -0.0897914465,
                                                                -0.0540601108);

final_score_39_c361 := map(
    NULL < f_srchunvrfdphonecount_i AND f_srchunvrfdphonecount_i <= 0.5 => 0.0065036260,
    f_srchunvrfdphonecount_i > 0.5                                      => final_score_39_c362,
    f_srchunvrfdphonecount_i = NULL                                     => -0.0134737220,
                                                                           -0.0134737220);

final_score_39_c360 := map(
    NULL < mth_source_ppdid_fseen AND mth_source_ppdid_fseen <= 6.5 => 0.0547978161,
    mth_source_ppdid_fseen > 6.5                                    => final_score_39_c361,
    mth_source_ppdid_fseen = NULL                                   => -0.0077281160,
                                                                       -0.0058028321);

final_score_39_c359 := map(
    NULL < f_mos_inq_banko_cm_lseen_d AND f_mos_inq_banko_cm_lseen_d <= 57.5 => final_score_39_c360,
    f_mos_inq_banko_cm_lseen_d > 57.5                                        => 0.0151942502,
    f_mos_inq_banko_cm_lseen_d = NULL                                        => 0.0048411275,
                                                                                0.0048411275);

final_score_39 := map(
    NULL < (integer)_phone_match_code_t AND (integer)_phone_match_code_t <= 0.5 => -0.0341440006,
    (integer)_phone_match_code_t > 0.5                                 => final_score_39_c359,
    (integer)_phone_match_code_t = NULL                                => 0.0015081857,
                                                                 0.0015081857);

final_score_40_c364 := map(
    NULL < (integer)_internal_ver_match_hhid AND (integer)_internal_ver_match_hhid <= 0.5 => -0.0051360546,
    (integer)_internal_ver_match_hhid > 0.5                                      => 0.0563079794,
    (integer)_internal_ver_match_hhid = NULL                                     => 0.0065997283,
                                                                           0.0065997283);

final_score_40_c367 := map(
    (eda_pfrd_address_ind in ['1A', '1B', 'XX']) => -0.0178581693,
    (eda_pfrd_address_ind in ['1C', '1D', '1E']) => 0.0316906890,
    eda_pfrd_address_ind = ''                  => -0.0127035531,
                                                    -0.0127035531);

final_score_40_c366 := map(
    NULL < (integer)pp_app_best_addr_match_fl AND (integer)pp_app_best_addr_match_fl <= 0.5 => final_score_40_c367,
    (integer)pp_app_best_addr_match_fl > 0.5                                       => 0.0104382171,
    (integer)pp_app_best_addr_match_fl = NULL                                      => -0.0024144106,
                                                                             -0.0024144106);

final_score_40_c365 := map(
    NULL < eda_address_match_best AND eda_address_match_best <= 0.5 => final_score_40_c366,
    eda_address_match_best > 0.5                                    => 0.0438902048,
    eda_address_match_best = NULL                                   => 0.0007709094,
                                                                       0.0007709094);

final_score_40 := map(
    NULL < mth_source_ppca_lseen AND mth_source_ppca_lseen <= 76.5 => final_score_40_c364,
    mth_source_ppca_lseen > 76.5                                   => -0.1153577493,
    mth_source_ppca_lseen = NULL                                   => final_score_40_c365,
                                                                      0.0007760175);

final_score_41_c370 := map(
    (pp_app_scc in ['', 'B', 'C', 'R', 'V'])            => 0.0056968174,
    (pp_app_scc in ['8', 'A', 'J', 'M', 'N', 'O', 'S']) => 0.0347925324,
    pp_app_scc = ''                                   => 0.0098999324,
                                                           0.0098999324);

final_score_41_c372 := map(
    NULL < mth_pp_datelastseen AND mth_pp_datelastseen <= 14.5 => 0.0115944594,
    mth_pp_datelastseen > 14.5                                 => -0.0564214221,
    mth_pp_datelastseen = NULL                                 => -0.0227373099,
                                                                  -0.0310251003);

final_score_41_c371 := map(
    NULL < _pp_rule_port_neustar AND _pp_rule_port_neustar <= 0.5 => final_score_41_c372,
    _pp_rule_port_neustar > 0.5                                   => 0.0789838466,
    _pp_rule_port_neustar = NULL                                  => -0.0256015570,
                                                                     -0.0256015570);

final_score_41_c369 := map(
    NULL < _mod_disc_noexp_lgt AND _mod_disc_noexp_lgt <= 2.05882202506417 => final_score_41_c370,
    _mod_disc_noexp_lgt > 2.05882202506417                                 => final_score_41_c371,
    _mod_disc_noexp_lgt = NULL                                             => 0.0038763819,
                                                                              0.0038763819);

final_score_41 := map(
    NULL < f_inq_collection_count_i AND f_inq_collection_count_i <= 10.5 => final_score_41_c369,
    f_inq_collection_count_i > 10.5                                      => -0.0324712681,
    f_inq_collection_count_i = NULL                                      => -0.0001799204,
                                                                            -0.0001799204);

final_score_42_c377 := map(
    NULL < _phone_zip_match AND _phone_zip_match <= 0.5 => 0.0073901461,
    _phone_zip_match > 0.5                              => 0.0324585328,
    _phone_zip_match = NULL                             => 0.0166869490,
                                                           0.0166869490);

final_score_42_c376 := map(
    (pp_source in ['CELL', 'INTRADO', 'OTHER', 'PCNSR', 'THRIVE'])                              => -0.0665723599,
    (pp_source in ['', 'GONG', 'HEADER', 'IBEHAVIOR', 'INFUTOR', 'INQUIRY', 'TARGUS', 'WIRED']) => final_score_42_c377,
    pp_source = ''                                                                            => 0.0136310817,
                                                                                                   0.0136310817);

final_score_42_c375 := map(
    (phone_subject_title in ['Associate By Business', 'Associate By SSN', 'Brother', 'Child', 'Granddaughter', 'Grandfather', 'Neighbor', 'Relative', 'Son', 'Spouse'])                                                                                                                                                            => -0.0304656254,
    (phone_subject_title in ['Associate', 'Associate By Address', 'Associate By Property', 'Associate By Shared Associates', 'Associate By Vehicle', 'Daughter', 'Father', 'Grandchild', 'Grandmother', 'Grandparent', 'Grandson', 'Husband', 'Mother', 'Parent', 'Sibling', 'Sister', 'Subject', 'Subject at Household', 'Wife']) => final_score_42_c376,
    phone_subject_title = ''                                                                                                                                                                                                                                                                                                     => 0.0087438976,
                                                                                                                                                                                                                                                                                                                                      0.0087438976);

final_score_42_c374 := map(
    NULL < f_util_adl_count_n AND f_util_adl_count_n <= 7.5 => final_score_42_c375,
    f_util_adl_count_n > 7.5                                => -0.0261938957,
    f_util_adl_count_n = NULL                               => 0.0046364858,
                                                               0.0046364858);

final_score_42 := map(
    NULL < f_inq_count_i AND f_inq_count_i <= 23.5 => final_score_42_c374,
    f_inq_count_i > 23.5                           => -0.0266375828,
    f_inq_count_i = NULL                           => 0.0005992775,
                                                      0.0005992775);

final_score_43_c381 := map(
    NULL < (integer)inq_firstseen_n AND (integer)inq_firstseen_n <= 16.5 => -0.0409876564,
    (integer)inq_firstseen_n > 16.5                             => 0.0063564348,
    (integer)inq_firstseen_n = NULL                             => 0.0038161248,
                                                          0.0020588771);

final_score_43_c382 := map(
    NULL < mth_source_ppca_fseen AND mth_source_ppca_fseen <= 20.5 => 0.0370813115,
    mth_source_ppca_fseen > 20.5                                   => -0.0333128233,
    mth_source_ppca_fseen = NULL                                   => -0.0312457912,
                                                                      -0.0242562659);

final_score_43_c380 := map(
    NULL < r_c14_addrs_5yr_i AND r_c14_addrs_5yr_i <= 3.5 => final_score_43_c381,
    r_c14_addrs_5yr_i > 3.5                               => final_score_43_c382,
    r_c14_addrs_5yr_i = NULL                              => -0.0041738453,
                                                             -0.0041738453);

final_score_43_c379 := map(
    (phone_subject_title in ['Associate', 'Associate By Address', 'Associate By Business', 'Associate By Shared Associates', 'Associate By SSN', 'Brother', 'Child', 'Grandchild', 'Granddaughter', 'Grandfather', 'Grandmother', 'Grandson', 'Mother', 'Neighbor', 'Relative', 'Sibling', 'Sister', 'Spouse', 'Subject', 'Subject at Household', 'Wife']) => final_score_43_c380,
    (phone_subject_title in ['Associate By Property', 'Associate By Vehicle', 'Daughter', 'Father', 'Grandparent', 'Husband', 'Parent', 'Son'])                                                                                                                                                                                                            => 0.0417193800,
    phone_subject_title = ''                                                                                                                                                                                                                                                                                                                             => -0.0024027140,
                                                                                                                                                                                                                                                                                                                                                              -0.0024027140);

final_score_43 := map(
    NULL < (integer)_inq_adl_ph_industry_flag AND (integer)_inq_adl_ph_industry_flag <= 0.5 => final_score_43_c379,
    (integer)_inq_adl_ph_industry_flag > 0.5                                       => 0.0569361503,
    (integer)_inq_adl_ph_industry_flag = NULL                                      => 0.0014952580,
                                                                             0.0014952580);

final_score_44_c386 := map(
    NULL < _phone_zip_match AND _phone_zip_match <= 0.5 => -0.0041058352,
    _phone_zip_match > 0.5                              => 0.0220882392,
    _phone_zip_match = NULL                             => 0.0063864324,
                                                           0.0063864324);

final_score_44_c385 := map(
    (phone_subject_title in ['Associate By Address', 'Associate By Business', 'Child', 'Grandchild', 'Granddaughter', 'Grandson', 'Neighbor'])                                                                                                                                                                                                              => -0.0399796258,
    (phone_subject_title in ['Associate', 'Associate By Property', 'Associate By Shared Associates', 'Associate By SSN', 'Associate By Vehicle', 'Brother', 'Daughter', 'Father', 'Grandfather', 'Grandmother', 'Grandparent', 'Husband', 'Mother', 'Parent', 'Relative', 'Sibling', 'Sister', 'Son', 'Spouse', 'Subject', 'Subject at Household', 'Wife']) => final_score_44_c386,
    phone_subject_title = ''                                                                                                                                                                                                                                                                                                                              => 0.0007493957,
                                                                                                                                                                                                                                                                                                                                                               0.0007493957);

final_score_44_c387 := map(
    NULL < mth_source_rm_fseen AND mth_source_rm_fseen <= 28.5 => 0.0918174869,
    mth_source_rm_fseen > 28.5                                 => -0.0539541267,
    mth_source_rm_fseen = NULL                                 => -0.0353287693,
                                                                  -0.0276582376);

final_score_44_c384 := map(
    NULL < f_srchfraudsrchcount_i AND f_srchfraudsrchcount_i <= 8.5 => final_score_44_c385,
    f_srchfraudsrchcount_i > 8.5                                    => final_score_44_c387,
    f_srchfraudsrchcount_i = NULL                                   => -0.0035136890,
                                                                       -0.0035136890);

final_score_44 := map(
    NULL < mth_source_ppca_lseen AND mth_source_ppca_lseen <= 19.5 => 0.0271801012,
    mth_source_ppca_lseen > 19.5                                   => -0.0207973087,
    mth_source_ppca_lseen = NULL                                   => final_score_44_c384,
                                                                      -0.0013316648);

final_score_45_c392 := map(
    NULL < mth_source_ppca_fseen AND mth_source_ppca_fseen <= 19.5 => 0.0353743595,
    mth_source_ppca_fseen > 19.5                                   => -0.0068228813,
    mth_source_ppca_fseen = NULL                                   => -0.0049483804,
                                                                      -0.0017774053);

final_score_45_c391 := map(
    NULL < f_add_input_nhood_bus_pct_i AND f_add_input_nhood_bus_pct_i <= 0.179364609653016 => final_score_45_c392,
    f_add_input_nhood_bus_pct_i > 0.179364609653016                                         => -0.0415955859,
    f_add_input_nhood_bus_pct_i = NULL                                                      => -0.0335918338,
                                                                                               -0.0055191926);

final_score_45_c390 := map(
    (phone_subject_title in ['Associate', 'Associate By Address', 'Associate By Business', 'Associate By Property', 'Associate By Shared Associates', 'Brother', 'Child', 'Father', 'Granddaughter', 'Grandfather', 'Mother', 'Neighbor', 'Relative', 'Sister', 'Subject', 'Subject at Household']) => final_score_45_c391,
    (phone_subject_title in ['Associate By SSN', 'Associate By Vehicle', 'Daughter', 'Grandchild', 'Grandmother', 'Grandparent', 'Grandson', 'Husband', 'Parent', 'Sibling', 'Son', 'Spouse', 'Wife'])                                                                                              => 0.0497321985,
    phone_subject_title = ''                                                                                                                                                                                                                                                                      => -0.0035101061,
                                                                                                                                                                                                                                                                                                       -0.0035101061);

final_score_45_c389 := map(
    NULL < mth_source_ppth_fseen AND mth_source_ppth_fseen <= 75.5 => 0.0274960533,
    mth_source_ppth_fseen > 75.5                                   => -0.0811211049,
    mth_source_ppth_fseen = NULL                                   => final_score_45_c390,
                                                                      -0.0056736810);

final_score_45 := map(
    NULL < r_a49_curr_avm_chg_1yr_pct_i AND r_a49_curr_avm_chg_1yr_pct_i <= 107.45 => 0.0192798077,
    r_a49_curr_avm_chg_1yr_pct_i > 107.45                                          => -0.0082637394,
    r_a49_curr_avm_chg_1yr_pct_i = NULL                                            => final_score_45_c389,
                                                                                      -0.0008927496);

final_score_46_c396 := map(
    NULL < mth_source_rm_fseen AND mth_source_rm_fseen <= 6.5 => 0.0854366568,
    mth_source_rm_fseen > 6.5                                 => -0.0242742081,
    mth_source_rm_fseen = NULL                                => -0.0065873576,
                                                                 -0.0059436497);

final_score_46_c395 := map(
    (phone_subject_title in ['Associate By Address', 'Associate By Business', 'Associate By Property', 'Associate By Shared Associates', 'Associate By SSN', 'Child', 'Daughter', 'Father', 'Grandchild', 'Granddaughter', 'Grandfather', 'Grandparent', 'Grandson', 'Husband', 'Mother', 'Neighbor', 'Subject']) => final_score_46_c396,
    (phone_subject_title in ['Associate', 'Associate By Vehicle', 'Brother', 'Grandmother', 'Parent', 'Relative', 'Sibling', 'Sister', 'Son', 'Spouse', 'Subject at Household', 'Wife'])                                                                                                                          => 0.0293174808,
    phone_subject_title = ''                                                                                                                                                                                                                                                                                    => 0.0025313464,
                                                                                                                                                                                                                                                                                                                     0.0025313464);

final_score_46_c394 := map(
    NULL < mth_exp_last_update AND mth_exp_last_update <= 59.5 => 0.0193572892,
    mth_exp_last_update > 59.5                                 => 0.0620227253,
    mth_exp_last_update = NULL                                 => final_score_46_c395,
                                                                  0.0091141845);

final_score_46_c397 := map(
    NULL < (integer)_inq_adl_ph_industry_flag AND (integer)_inq_adl_ph_industry_flag <= 0.5 => -0.0199846823,
    (integer)_inq_adl_ph_industry_flag > 0.5                                       => 0.0412254505,
    (integer)_inq_adl_ph_industry_flag = NULL                                      => -0.0138024689,
                                                                             -0.0138024689);

final_score_46 := map(
    NULL < f_inq_count_i AND f_inq_count_i <= 9.5 => final_score_46_c394,
    f_inq_count_i > 9.5                           => final_score_46_c397,
    f_inq_count_i = NULL                          => -0.0010683202,
                                                     -0.0010683202);

final_score_47_c400 := map(
    NULL < eda_months_addr_last_seen AND eda_months_addr_last_seen <= 0.5 => 0.0066059178,
    eda_months_addr_last_seen > 0.5                                       => 0.1478357626,
    eda_months_addr_last_seen = NULL                                      => 0.0174748237,
                                                                             0.0174748237);

final_score_47_c402 := map(
    NULL < f_mos_inq_banko_om_fseen_d AND f_mos_inq_banko_om_fseen_d <= 22.5 => -0.0559943949,
    f_mos_inq_banko_om_fseen_d > 22.5                                        => -0.0021487434,
    f_mos_inq_banko_om_fseen_d = NULL                                        => -0.0066010494,
                                                                                -0.0066010494);

final_score_47_c401 := map(
    NULL < r_prop_owner_history_d AND r_prop_owner_history_d <= 1.5 => final_score_47_c402,
    r_prop_owner_history_d > 1.5                                    => 0.0142829155,
    r_prop_owner_history_d = NULL                                   => 0.0029034912,
                                                                       0.0029034912);

final_score_47_c399 := map(
    NULL < mth_source_rm_fseen AND mth_source_rm_fseen <= 48.5 => final_score_47_c400,
    mth_source_rm_fseen > 48.5                                 => -0.0540282613,
    mth_source_rm_fseen = NULL                                 => final_score_47_c401,
                                                                  0.0027306053);

final_score_47 := map(
    NULL < mth_source_ppth_fseen AND mth_source_ppth_fseen <= 11.5 => 0.0763417684,
    mth_source_ppth_fseen > 11.5                                   => -0.0306273538,
    mth_source_ppth_fseen = NULL                                   => final_score_47_c399,
                                                                      0.0006164340);

final_score_48_c406 := map(
    NULL < f_srchssnsrchcount_i AND f_srchssnsrchcount_i <= 5.5 => 0.0299275592,
    f_srchssnsrchcount_i > 5.5                                  => -0.0372808412,
    f_srchssnsrchcount_i = NULL                                 => 0.0142006944,
                                                                   0.0142006944);

final_score_48_c407 := map(
    NULL < pp_did_score AND pp_did_score <= 99.5 => 0.0026802169,
    pp_did_score > 99.5                          => -0.0272768383,
    pp_did_score = NULL                          => -0.0022642084,
                                                    -0.0022642084);

final_score_48_c405 := map(
    NULL < mth_source_utildid_fseen AND mth_source_utildid_fseen <= 7.5 => 0.0760441871,
    mth_source_utildid_fseen > 7.5                                      => final_score_48_c406,
    mth_source_utildid_fseen = NULL                                     => final_score_48_c407,
                                                                           0.0011893212);

final_score_48_c404 := map(
    NULL < f_rel_educationover8_count_d AND f_rel_educationover8_count_d <= 38.5 => final_score_48_c405,
    f_rel_educationover8_count_d > 38.5                                          => -0.0577216741,
    f_rel_educationover8_count_d = NULL                                          => -0.0391350267,
                                                                                    -0.0004204696);

final_score_48 := map(
    NULL < mth_source_paw_lseen AND mth_source_paw_lseen <= 23.5 => 0.0798180132,
    mth_source_paw_lseen > 23.5                                  => -0.0189026528,
    mth_source_paw_lseen = NULL                                  => final_score_48_c404,
                                                                    0.0002966187);

final_score_49_c412 := map(
    NULL < mth_source_utildid_fseen AND mth_source_utildid_fseen <= 28.5 => 0.0497251203,
    mth_source_utildid_fseen > 28.5                                      => 0.0006230853,
    mth_source_utildid_fseen = NULL                                      => 0.0004919474,
                                                                            0.0037236688);

final_score_49_c411 := map(
    NULL < mth_source_paw_lseen AND mth_source_paw_lseen <= 147.5 => 0.0472265976,
    mth_source_paw_lseen > 147.5                                  => -0.1094522979,
    mth_source_paw_lseen = NULL                                   => final_score_49_c412,
                                                                     0.0045527270);

final_score_49_c410 := map(
    (phone_subject_title in ['Associate', 'Associate By Address', 'Associate By Business', 'Associate By Shared Associates', 'Associate By SSN', 'Brother', 'Child', 'Father', 'Grandchild', 'Granddaughter', 'Grandson', 'Neighbor', 'Sibling', 'Sister', 'Subject', 'Subject at Household']) => final_score_49_c411,
    (phone_subject_title in ['Associate By Property', 'Associate By Vehicle', 'Daughter', 'Grandfather', 'Grandmother', 'Grandparent', 'Husband', 'Mother', 'Parent', 'Relative', 'Son', 'Spouse', 'Wife'])                                                                                    => 0.0409740682,
    phone_subject_title = ''                                                                                                                                                                                                                                                                 => 0.0070907784,
                                                                                                                                                                                                                                                                                                  0.0070907784);

final_score_49_c409 := map(
    NULL < pk_phone_match_level AND pk_phone_match_level <= 0.5 => -0.0390021626,
    pk_phone_match_level > 0.5                                  => final_score_49_c410,
    pk_phone_match_level = NULL                                 => 0.0050921828,
                                                                   0.0050921828);

final_score_49 := map(
    NULL < f_mos_inq_banko_om_fseen_d AND f_mos_inq_banko_om_fseen_d <= 31.5 => -0.0271425955,
    f_mos_inq_banko_om_fseen_d > 31.5                                        => final_score_49_c409,
    f_mos_inq_banko_om_fseen_d = NULL                                        => 0.0012292479,
                                                                                0.0012292479);

final_score_50_c417 := map(
    NULL < mth_eda_deletion_date AND mth_eda_deletion_date <= 3.5 => 0.1265295709,
    mth_eda_deletion_date > 3.5                                   => -0.0449447281,
    mth_eda_deletion_date = NULL                                  => 0.0121422986,
                                                                     0.0063724570);

final_score_50_c416 := map(
    NULL < (integer)inq_adl_firstseen_n AND (integer)inq_adl_firstseen_n <= 0.5 => 0.0001169452,
    (integer)inq_adl_firstseen_n > 0.5                                 => 0.0377223827,
    (integer)inq_adl_firstseen_n = NULL                                => final_score_50_c417,
                                                                 0.0098232164);

final_score_50_c415 := map(
    NULL < mth_source_edahistory_lseen AND mth_source_edahistory_lseen <= 13.5 => 0.0061713242,
    mth_source_edahistory_lseen > 13.5                                         => -0.1050165974,
    mth_source_edahistory_lseen = NULL                                         => final_score_50_c416,
                                                                                  0.0083054243);

final_score_50_c414 := map(
    NULL < r_s65_ssn_deceased_i AND r_s65_ssn_deceased_i <= 0.5 => final_score_50_c415,
    r_s65_ssn_deceased_i > 0.5                                  => -0.0790110081,
    r_s65_ssn_deceased_i = NULL                                 => -0.0004027232,
                                                                   0.0064257162);

final_score_50 := map(
    NULL < f_mos_inq_banko_om_fseen_d AND f_mos_inq_banko_om_fseen_d <= 46.5 => -0.0172161047,
    f_mos_inq_banko_om_fseen_d > 46.5                                        => final_score_50_c414,
    f_mos_inq_banko_om_fseen_d = NULL                                        => 0.0005241758,
                                                                                0.0005241758);

final_score_51_c421 := map(
    NULL < mth_exp_last_update AND mth_exp_last_update <= 58.5 => -0.0001140150,
    mth_exp_last_update > 58.5                                 => 0.0556805993,
    mth_exp_last_update = NULL                                 => -0.0018176319,
                                                                  0.0007576536);

final_score_51_c420 := map(
    NULL < f_mos_inq_banko_om_fseen_d AND f_mos_inq_banko_om_fseen_d <= 43.5 => -0.0252919002,
    f_mos_inq_banko_om_fseen_d > 43.5                                        => final_score_51_c421,
    f_mos_inq_banko_om_fseen_d = NULL                                        => -0.0051035810,
                                                                                -0.0051035810);

final_score_51_c419 := map(
    NULL < eda_days_ind_first_seen AND eda_days_ind_first_seen <= 442 => final_score_51_c420,
    eda_days_ind_first_seen > 442                                     => -0.0725331689,
    eda_days_ind_first_seen = NULL                                    => -0.0084907752,
                                                                         -0.0084907752);

final_score_51_c422 := map(
    NULL < r_s65_ssn_deceased_i AND r_s65_ssn_deceased_i <= 0.5 => 0.0132116949,
    r_s65_ssn_deceased_i > 0.5                                  => -0.1027072962,
    r_s65_ssn_deceased_i = NULL                                 => 0.0242399599,
                                                                   0.0108094314);

final_score_51 := map(
    NULL < r_c21_m_bureau_adl_fs_d AND r_c21_m_bureau_adl_fs_d <= 310.5 => final_score_51_c419,
    r_c21_m_bureau_adl_fs_d > 310.5                                     => final_score_51_c422,
    r_c21_m_bureau_adl_fs_d = NULL                                      => -0.0011187130,
                                                                           -0.0011187130);

final_score_52_c424 := map(
    NULL < r_c14_addrs_5yr_i AND r_c14_addrs_5yr_i <= 3.5 => -0.0036057500,
    r_c14_addrs_5yr_i > 3.5                               => 0.0796863486,
    r_c14_addrs_5yr_i = NULL                              => 0.0163103247,
                                                             0.0163103247);

final_score_52_c427 := map(
    NULL < mth_internal_ver_first_seen AND mth_internal_ver_first_seen <= 18.5 => 0.0205976496,
    mth_internal_ver_first_seen > 18.5                                         => -0.0105236953,
    mth_internal_ver_first_seen = NULL                                         => -0.0102400490,
                                                                                  0.0002299194);

final_score_52_c426 := map(
    NULL < mth_exp_last_update AND mth_exp_last_update <= 58.5 => 0.0225463416,
    mth_exp_last_update > 58.5                                 => 0.0571191464,
    mth_exp_last_update = NULL                                 => final_score_52_c427,
                                                                  0.0084325338);

final_score_52_c425 := map(
    NULL < f_mos_inq_banko_cm_fseen_d AND f_mos_inq_banko_cm_fseen_d <= 81.5 => -0.0125680564,
    f_mos_inq_banko_cm_fseen_d > 81.5                                        => final_score_52_c426,
    f_mos_inq_banko_cm_fseen_d = NULL                                        => -0.0016698892,
                                                                                -0.0016698892);

final_score_52 := map(
    NULL < mth_source_md_fseen AND mth_source_md_fseen <= 199.5 => final_score_52_c424,
    mth_source_md_fseen > 199.5                                 => 0.1015222081,
    mth_source_md_fseen = NULL                                  => final_score_52_c425,
                                                                   -0.0002514007);

final_score_53_c432 := map(
    NULL < mth_source_ppdid_lseen AND mth_source_ppdid_lseen <= 78.5 => 0.0110244501,
    mth_source_ppdid_lseen > 78.5                                    => -0.0742456831,
    mth_source_ppdid_lseen = NULL                                    => 0.0027284734,
                                                                        0.0036470049);

final_score_53_c431 := map(
    NULL < mth_source_inf_fseen AND mth_source_inf_fseen <= 79.5 => -0.1058708746,
    mth_source_inf_fseen > 79.5                                  => -0.0560020667,
    mth_source_inf_fseen = NULL                                  => final_score_53_c432,
                                                                    0.0006489324);

final_score_53_c430 := map(
    NULL < number_of_sources AND number_of_sources <= 2.5 => final_score_53_c431,
    number_of_sources > 2.5                               => 0.0367052721,
    number_of_sources = NULL                              => 0.0058194516,
                                                             0.0058194516);

final_score_53_c429 := map(
    NULL < f_util_adl_count_n AND f_util_adl_count_n <= 6.5 => final_score_53_c430,
    f_util_adl_count_n > 6.5                                => -0.0199815020,
    f_util_adl_count_n = NULL                               => 0.0012874869,
                                                               0.0012874869);

final_score_53 := map(
    (pp_app_ph_type in ['', 'CELL', 'PAGE', 'POTS', 'Puerto Rico/US Virgin Isl', 'VOIP']) => final_score_53_c429,
    (pp_app_ph_type in ['LNDLN PRTD TO CELL'])                                            => 0.0789027149,
    pp_app_ph_type = ''                                                                 => 0.0021883813,
                                                                                             0.0021883813);

final_score_54_c437 := map(
    NULL < f_mos_liens_unrel_cj_fseen_d AND f_mos_liens_unrel_cj_fseen_d <= 11.5 => -0.1151748880,
    f_mos_liens_unrel_cj_fseen_d > 11.5                                          => 0.0055931856,
    f_mos_liens_unrel_cj_fseen_d = NULL                                          => 0.0045931867,
                                                                                    0.0045931867);

final_score_54_c436 := map(
    NULL < f_inq_collection_count_i AND f_inq_collection_count_i <= 9.5 => final_score_54_c437,
    f_inq_collection_count_i > 9.5                                      => -0.0213070534,
    f_inq_collection_count_i = NULL                                     => 0.0011778040,
                                                                           0.0011778040);

final_score_54_c435 := map(
    NULL < mth_source_ppth_fseen AND mth_source_ppth_fseen <= 11.5 => 0.0518871782,
    mth_source_ppth_fseen > 11.5                                   => -0.0395548430,
    mth_source_ppth_fseen = NULL                                   => final_score_54_c436,
                                                                      -0.0015988649);

final_score_54_c434 := map(
    (pp_src in ['', 'CY', 'E2', 'E4', 'EB', 'EM', 'EN', 'EQ', 'FA', 'KW', 'LA', 'LP', 'MD', 'SL', 'SV', 'TN', 'UT', 'VO', 'VW', 'YE', 'ZK']) => final_score_54_c435,
    (pp_src in ['E1', 'FF', 'NW', 'PL', 'UW', 'ZT'])                                                                                         => 0.0362049127,
    pp_src = ''                                                                                                                            => 0.0009639570,
                                                                                                                                                0.0009639570);

final_score_54 := map(
    NULL < mth_source_edaca_lseen AND mth_source_edaca_lseen <= 9.5 => 0.0540348475,
    mth_source_edaca_lseen > 9.5                                    => -0.0655084482,
    mth_source_edaca_lseen = NULL                                   => final_score_54_c434,
                                                                       0.0009694069);

final_score_55_c441 := map(
    NULL < f_util_adl_count_n AND f_util_adl_count_n <= 6.5 => 0.0381214797,
    f_util_adl_count_n > 6.5                                => -0.0332508896,
    f_util_adl_count_n = NULL                               => 0.0222352063,
                                                               0.0222352063);

final_score_55_c442 := map(
    NULL < _mod_disc_noexp_lgt AND _mod_disc_noexp_lgt <= 4.77846721895782 => 0.0030914746,
    _mod_disc_noexp_lgt > 4.77846721895782                                 => -0.0612859738,
    _mod_disc_noexp_lgt = NULL                                             => -0.0047741520,
                                                                              -0.0047741520);

final_score_55_c440 := map(
    NULL < (integer)inq_adl_firstseen_n AND (integer)inq_adl_firstseen_n <= 0.5 => -0.0070533395,
    (integer)inq_adl_firstseen_n > 0.5                                 => final_score_55_c441,
    (integer)inq_adl_firstseen_n = NULL                                => final_score_55_c442,
                                                                 -0.0004272089);

final_score_55_c439 := map(
    NULL < f_inq_mortgage_count24_i AND f_inq_mortgage_count24_i <= 1.5 => final_score_55_c440,
    f_inq_mortgage_count24_i > 1.5                                      => 0.0853072741,
    f_inq_mortgage_count24_i = NULL                                     => 0.0006991658,
                                                                           0.0006991658);

final_score_55 := map(
    (eda_pfrd_address_ind in ['1A', '1B', 'XX']) => final_score_55_c439,
    (eda_pfrd_address_ind in ['1C', '1D', '1E']) => 0.0452098146,
    eda_pfrd_address_ind = ''                  => 0.0028010088,
                                                    0.0028010088);

final_score_56_c447 := map(
    NULL < eda_max_days_interrupt AND eda_max_days_interrupt <= 1266.5 => 0.0277442207,
    eda_max_days_interrupt > 1266.5                                    => -0.0650789524,
    eda_max_days_interrupt = NULL                                      => 0.0148871389,
                                                                          0.0148871389);

final_score_56_c446 := map(
    NULL < eda_max_days_interrupt AND eda_max_days_interrupt <= 2321 => final_score_56_c447,
    eda_max_days_interrupt > 2321                                    => 0.1092738828,
    eda_max_days_interrupt = NULL                                    => 0.0220940682,
                                                                        0.0220940682);

final_score_56_c445 := map(
    NULL < mth_eda_dt_first_seen AND mth_eda_dt_first_seen <= 16.5 => final_score_56_c446,
    mth_eda_dt_first_seen > 16.5                                   => -0.0079359267,
    mth_eda_dt_first_seen = NULL                                   => 0.0045107308,
                                                                      0.0025274612);

final_score_56_c444 := map(
    NULL < pp_did_score AND pp_did_score <= 78.5 => final_score_56_c445,
    pp_did_score > 78.5                          => -0.0225801360,
    pp_did_score = NULL                          => -0.0020495792,
                                                    -0.0020495792);

final_score_56 := map(
    NULL < f_inq_mortgage_count_i AND f_inq_mortgage_count_i <= 1.5 => final_score_56_c444,
    f_inq_mortgage_count_i > 1.5                                    => 0.0378193759,
    f_inq_mortgage_count_i = NULL                                   => 0.0005870378,
                                                                       0.0005870378);

final_score_57_c449 := map(
    NULL < _mod_disc_noexp_lgt AND _mod_disc_noexp_lgt <= 0.0506528372143607 => 0.0027391336,
    _mod_disc_noexp_lgt > 0.0506528372143607                                 => 0.0498575138,
    _mod_disc_noexp_lgt = NULL                                               => 0.0219400444,
                                                                                0.0219400444);

final_score_57_c450 := map(
    NULL < mth_pp_orig_lastseen AND mth_pp_orig_lastseen <= 14.5 => -0.0697528514,
    mth_pp_orig_lastseen > 14.5                                  => 0.0116259731,
    mth_pp_orig_lastseen = NULL                                  => -0.0133760435,
                                                                    -0.0133760435);

final_score_57_c452 := map(
    (phone_subject_title in ['Associate', 'Associate By Address', 'Associate By Business', 'Associate By Shared Associates', 'Associate By SSN', 'Associate By Vehicle', 'Brother', 'Grandfather', 'Grandparent', 'Grandson', 'Mother', 'Neighbor', 'Relative', 'Sibling', 'Sister', 'Son', 'Spouse', 'Subject', 'Wife']) => -0.0715484284,
    (phone_subject_title in ['Associate By Property', 'Child', 'Daughter', 'Father', 'Grandchild', 'Granddaughter', 'Grandmother', 'Husband', 'Parent', 'Subject at Household'])                                                                                                                                          => 0.0559087277,
    phone_subject_title = ''                                                                                                                                                                                                                                                                                            => -0.0539332145,
                                                                                                                                                                                                                                                                                                                             -0.0539332145);

final_score_57_c451 := map(
    NULL < r_c13_max_lres_d AND r_c13_max_lres_d <= 39.5 => final_score_57_c452,
    r_c13_max_lres_d > 39.5                              => -0.0017382500,
    r_c13_max_lres_d = NULL                              => -0.0043007528,
                                                            -0.0043007528);

final_score_57 := map(
    NULL < mth_source_ppca_lseen AND mth_source_ppca_lseen <= 15.5 => final_score_57_c449,
    mth_source_ppca_lseen > 15.5                                   => final_score_57_c450,
    mth_source_ppca_lseen = NULL                                   => final_score_57_c451,
                                                                      -0.0023620991);

final_score_58_c456 := map(
    NULL < f_curraddrburglaryindex_i AND f_curraddrburglaryindex_i <= 104 => 0.0188172558,
    f_curraddrburglaryindex_i > 104                                       => -0.0220457749,
    f_curraddrburglaryindex_i = NULL                                      => -0.0003186171,
                                                                             -0.0003186171);

final_score_58_c455 := map(
    NULL < r_i60_inq_comm_recency_d AND r_i60_inq_comm_recency_d <= 61.5 => -0.0616328048,
    r_i60_inq_comm_recency_d > 61.5                                      => final_score_58_c456,
    r_i60_inq_comm_recency_d = NULL                                      => -0.0117209860,
                                                                            -0.0117209860);

final_score_58_c457 := map(
    NULL < mth_source_ppca_lseen AND mth_source_ppca_lseen <= 20.5 => 0.0186434337,
    mth_source_ppca_lseen > 20.5                                   => -0.0354737994,
    mth_source_ppca_lseen = NULL                                   => -0.0093468839,
                                                                      -0.0082100691);

final_score_58_c454 := map(
    NULL < mth_source_ppdid_fseen AND mth_source_ppdid_fseen <= 6.5 => 0.0410243352,
    mth_source_ppdid_fseen > 6.5                                    => final_score_58_c455,
    mth_source_ppdid_fseen = NULL                                   => final_score_58_c457,
                                                                       -0.0067791917);

final_score_58 := map(
    NULL < r_a44_curr_add_naprop_d AND r_a44_curr_add_naprop_d <= 2.5 => final_score_58_c454,
    r_a44_curr_add_naprop_d > 2.5                                     => 0.0136548321,
    r_a44_curr_add_naprop_d = NULL                                    => -0.0007859648,
                                                                         -0.0007859648);

final_score_59_c462 := map(
    NULL < (integer)inq_lastseen_n AND (integer)inq_lastseen_n <= 11.5 => -0.0348601743,
    (integer)inq_lastseen_n > 11.5                            => 0.0401744837,
    (integer)inq_lastseen_n = NULL                            => 0.0096251095,
                                                        0.0130664876);

final_score_59_c461 := map(
    NULL < r_a49_curr_avm_chg_1yr_pct_i AND r_a49_curr_avm_chg_1yr_pct_i <= 110.15 => final_score_59_c462,
    r_a49_curr_avm_chg_1yr_pct_i > 110.15                                          => -0.0200934378,
    r_a49_curr_avm_chg_1yr_pct_i = NULL                                            => -0.0096223064,
                                                                                      -0.0060795893);

final_score_59_c460 := map(
    NULL < mth_pp_app_npa_last_change_dt AND mth_pp_app_npa_last_change_dt <= 32.5 => 0.0313084129,
    mth_pp_app_npa_last_change_dt > 32.5                                           => final_score_59_c461,
    mth_pp_app_npa_last_change_dt = NULL                                           => 0.0057055129,
                                                                                      -0.0000966620);

final_score_59_c459 := map(
    (phone_subject_title in ['Associate By Business', 'Associate By Property', 'Brother', 'Daughter', 'Grandchild', 'Granddaughter', 'Grandson', 'Husband', 'Neighbor'])                                                                                                                                                          => -0.0408615513,
    (phone_subject_title in ['Associate', 'Associate By Address', 'Associate By Shared Associates', 'Associate By SSN', 'Associate By Vehicle', 'Child', 'Father', 'Grandfather', 'Grandmother', 'Grandparent', 'Mother', 'Parent', 'Relative', 'Sibling', 'Sister', 'Son', 'Spouse', 'Subject', 'Subject at Household', 'Wife']) => final_score_59_c460,
    phone_subject_title = ''                                                                                                                                                                                                                                                                                                    => -0.0029281625,
                                                                                                                                                                                                                                                                                                                                     -0.0029281625);

final_score_59 := map(
    NULL < _pp_src_all_uw AND _pp_src_all_uw <= 0.5 => final_score_59_c459,
    _pp_src_all_uw > 0.5                            => 0.0388290540,
    _pp_src_all_uw = NULL                           => -0.0004265862,
                                                       -0.0004265862);

final_score_60_c466 := map(
    NULL < f_add_input_nhood_sfd_pct_d AND f_add_input_nhood_sfd_pct_d <= 0.442065000487017 => 0.1912193193,
    f_add_input_nhood_sfd_pct_d > 0.442065000487017                                         => 0.0038439045,
    f_add_input_nhood_sfd_pct_d = NULL                                                      => 0.0711140841,
                                                                                               0.0711140841);

final_score_60_c465 := map(
    NULL < mth_source_ppth_lseen AND mth_source_ppth_lseen <= 12.5 => final_score_60_c466,
    mth_source_ppth_lseen > 12.5                                   => -0.0190338638,
    mth_source_ppth_lseen = NULL                                   => 0.0021928081,
                                                                      0.0014973922);

final_score_60_c467 := map(
    NULL < mth_source_ppdid_fseen AND mth_source_ppdid_fseen <= 8.5 => 0.0299080170,
    mth_source_ppdid_fseen > 8.5                                    => -0.0735078833,
    mth_source_ppdid_fseen = NULL                                   => -0.0190019647,
                                                                       -0.0294204654);

final_score_60_c464 := map(
    NULL < r_c14_addrs_5yr_i AND r_c14_addrs_5yr_i <= 5.5 => final_score_60_c465,
    r_c14_addrs_5yr_i > 5.5                               => final_score_60_c467,
    r_c14_addrs_5yr_i = NULL                              => -0.0016132698,
                                                             -0.0016132698);

final_score_60 := map(
    NULL < mth_source_rm_fseen AND mth_source_rm_fseen <= 5.5 => 0.0702371859,
    mth_source_rm_fseen > 5.5                                 => -0.0073650047,
    mth_source_rm_fseen = NULL                                => final_score_60_c464,
                                                                 -0.0009338506);

final_score_61_c470 := map(
    NULL < f_srchvelocityrisktype_i AND f_srchvelocityrisktype_i <= 5.5 => 0.0653717494,
    f_srchvelocityrisktype_i > 5.5                                      => -0.0214764190,
    f_srchvelocityrisktype_i = NULL                                     => 0.0395919183,
                                                                           0.0395919183);

final_score_61_c472 := map(
    NULL < mth_source_edaca_lseen AND mth_source_edaca_lseen <= 8.5 => 0.0533135322,
    mth_source_edaca_lseen > 8.5                                    => -0.0467006203,
    mth_source_edaca_lseen = NULL                                   => -0.0011689072,
                                                                       -0.0010842588);

final_score_61_c471 := map(
    NULL < f_inq_collection_count_i AND f_inq_collection_count_i <= 14.5 => final_score_61_c472,
    f_inq_collection_count_i > 14.5                                      => -0.0521449425,
    f_inq_collection_count_i = NULL                                      => -0.0037535482,
                                                                            -0.0037535482);

final_score_61_c469 := map(
    NULL < mth_exp_last_update AND mth_exp_last_update <= 58.5 => 0.0004414966,
    mth_exp_last_update > 58.5                                 => final_score_61_c470,
    mth_exp_last_update = NULL                                 => final_score_61_c471,
                                                                  -0.0010537297);

final_score_61 := map(
    NULL < r_paw_active_phone_ct_d AND r_paw_active_phone_ct_d <= 1.5 => final_score_61_c469,
    r_paw_active_phone_ct_d > 1.5                                     => 0.0469597329,
    r_paw_active_phone_ct_d = NULL                                    => 0.0008073007,
                                                                         0.0008073007);

final_score_62_c476 := map(
    NULL < r_c14_addrs_5yr_i AND r_c14_addrs_5yr_i <= 3.5 => 0.0124834703,
    r_c14_addrs_5yr_i > 3.5                               => -0.0422123572,
    r_c14_addrs_5yr_i = NULL                              => -0.0001108935,
                                                             -0.0001108935);

final_score_62_c475 := map(
    NULL < mth_pp_datefirstseen AND mth_pp_datefirstseen <= 10.5 => -0.0968589917,
    mth_pp_datefirstseen > 10.5                                  => final_score_62_c476,
    mth_pp_datefirstseen = NULL                                  => -0.0059497814,
                                                                    -0.0059497814);

final_score_62_c477 := map(
    NULL < mth_source_ppfla_fseen AND mth_source_ppfla_fseen <= 66.5 => 0.1113994453,
    mth_source_ppfla_fseen > 66.5                                    => 0.0399802463,
    mth_source_ppfla_fseen = NULL                                    => -0.0005655476,
                                                                        0.0004738808);

final_score_62_c474 := map(
    NULL < mth_source_ppdid_fseen AND mth_source_ppdid_fseen <= 10.5 => 0.0330286049,
    mth_source_ppdid_fseen > 10.5                                    => final_score_62_c475,
    mth_source_ppdid_fseen = NULL                                    => final_score_62_c477,
                                                                        0.0016465888);

final_score_62 := map(
    NULL < f_idrisktype_i AND f_idrisktype_i <= 8.5 => final_score_62_c474,
    f_idrisktype_i > 8.5                            => -0.0722558086,
    f_idrisktype_i = NULL                           => 0.0005311041,
                                                       0.0005311041);

final_score_63_c481 := map(
    NULL < f_rel_incomeover50_count_d AND f_rel_incomeover50_count_d <= 1.5 => 0.0646228408,
    f_rel_incomeover50_count_d > 1.5                                        => -0.0719233977,
    f_rel_incomeover50_count_d = NULL                                       => -0.0533009598,
                                                                               -0.0533009598);

final_score_63_c480 := map(
    NULL < f_srchunvrfdssncount_i AND f_srchunvrfdssncount_i <= 0.5 => final_score_63_c481,
    f_srchunvrfdssncount_i > 0.5                                    => 0.0938605667,
    f_srchunvrfdssncount_i = NULL                                   => -0.0350715335,
                                                                       -0.0350715335);

final_score_63_c482 := map(
    NULL < pp_app_ind_ph_cnt AND pp_app_ind_ph_cnt <= 6.5 => 0.0069271524,
    pp_app_ind_ph_cnt > 6.5                               => -0.0183492094,
    pp_app_ind_ph_cnt = NULL                              => 0.0027949624,
                                                             0.0027949624);

final_score_63_c479 := map(
    NULL < mth_source_rm_fseen AND mth_source_rm_fseen <= 21.5 => 0.0260486141,
    mth_source_rm_fseen > 21.5                                 => final_score_63_c480,
    mth_source_rm_fseen = NULL                                 => final_score_63_c482,
                                                                  0.0025572741);

final_score_63 := map(
    NULL < mth_source_ppth_lseen AND mth_source_ppth_lseen <= 57.5 => 0.0262855837,
    mth_source_ppth_lseen > 57.5                                   => -0.0696168943,
    mth_source_ppth_lseen = NULL                                   => final_score_63_c479,
                                                                      0.0006763948);

final_score_64_c487 := map(
    NULL < (integer)inq_firstseen_n AND (integer)inq_firstseen_n <= 17.5 => -0.0351265012,
    (integer)inq_firstseen_n > 17.5                             => 0.0020709692,
    (integer)inq_firstseen_n = NULL                             => -0.0059800681,
                                                          -0.0052449678);

final_score_64_c486 := map(
    NULL < mth_source_edahistory_lseen AND mth_source_edahistory_lseen <= 6.5 => 0.0073817962,
    mth_source_edahistory_lseen > 6.5                                         => -0.1056166133,
    mth_source_edahistory_lseen = NULL                                        => final_score_64_c487,
                                                                                 -0.0066474157);

final_score_64_c485 := map(
    NULL < inq_num AND inq_num <= 0.5 => final_score_64_c486,
    inq_num > 0.5                     => 0.0171363500,
    inq_num = NULL                    => -0.0022865744,
                                         -0.0022865744);

final_score_64_c484 := map(
    NULL < mth_source_paw_fseen AND mth_source_paw_fseen <= 7.5 => -0.0896634034,
    mth_source_paw_fseen > 7.5                                  => 0.0454124744,
    mth_source_paw_fseen = NULL                                 => final_score_64_c485,
                                                                   -0.0018296647);

final_score_64 := map(
    NULL < r_paw_active_phone_ct_d AND r_paw_active_phone_ct_d <= 1.5 => final_score_64_c484,
    r_paw_active_phone_ct_d > 1.5                                     => 0.0473198913,
    r_paw_active_phone_ct_d = NULL                                    => 0.0001548213,
                                                                         0.0001548213);

final_score_65_c491 := map(
    NULL < r_c14_addrs_5yr_i AND r_c14_addrs_5yr_i <= 3.5 => -0.0114591403,
    r_c14_addrs_5yr_i > 3.5                               => -0.1721172866,
    r_c14_addrs_5yr_i = NULL                              => -0.0299893567,
                                                             -0.0299893567);

final_score_65_c490 := map(
    (phone_subject_title in ['Associate', 'Associate By Address', 'Associate By Property', 'Associate By SSN', 'Associate By Vehicle', 'Brother', 'Daughter', 'Father', 'Husband', 'Neighbor', 'Parent', 'Relative', 'Sibling', 'Sister', 'Son', 'Spouse', 'Subject at Household', 'Wife']) => -0.1599888327,
    (phone_subject_title in ['Associate By Business', 'Associate By Shared Associates', 'Child', 'Grandchild', 'Granddaughter', 'Grandfather', 'Grandmother', 'Grandparent', 'Grandson', 'Mother', 'Subject'])                                                                              => final_score_65_c491,
    phone_subject_title = ''                                                                                                                                                                                                                                                              => -0.0643751860,
                                                                                                                                                                                                                                                                                               -0.0643751860);

final_score_65_c492 := map(
    (pp_src in ['', 'E4', 'EB', 'EM', 'EN', 'EQ', 'FF', 'LA', 'MD', 'NW', 'PL', 'SL', 'SV', 'TN', 'UT', 'VW', 'YE', 'ZK']) => -0.0042056426,
    (pp_src in ['CY', 'E1', 'E2', 'FA', 'KW', 'LP', 'UW', 'VO', 'ZT'])                                                     => 0.0252011258,
    pp_src = ''                                                                                                          => -0.0008623686,
                                                                                                                              -0.0008623686);

final_score_65_c489 := map(
    (exp_source in ['P'])     => final_score_65_c490,
    (exp_source in ['', 'S']) => final_score_65_c492,
    exp_source = ''         => -0.0028402502,
                                 -0.0028402502);

final_score_65 := map(
    NULL < eda_address_match_best AND eda_address_match_best <= 0.5 => final_score_65_c489,
    eda_address_match_best > 0.5                                    => 0.0376335782,
    eda_address_match_best = NULL                                   => -0.0003505005,
                                                                       -0.0003505005);

final_score_66_c495 := map(
    NULL < r_c14_addrs_15yr_i AND r_c14_addrs_15yr_i <= 7.5 => 0.0026936760,
    r_c14_addrs_15yr_i > 7.5                                => -0.0146800788,
    r_c14_addrs_15yr_i = NULL                               => -0.0052616142,
                                                               -0.0052616142);

final_score_66_c497 := map(
    NULL < r_c14_addrs_10yr_i AND r_c14_addrs_10yr_i <= 7.5 => 0.0393540618,
    r_c14_addrs_10yr_i > 7.5                                => 0.1617136043,
    r_c14_addrs_10yr_i = NULL                               => 0.0758662088,
                                                               0.0758662088);

final_score_66_c496 := map(
    NULL < eda_days_in_service AND eda_days_in_service <= 610.5 => final_score_66_c497,
    eda_days_in_service > 610.5                                 => 0.0014684435,
    eda_days_in_service = NULL                                  => 0.0292206743,
                                                                   0.0292206743);

final_score_66_c494 := map(
    (phone_subject_title in ['Associate', 'Associate By Address', 'Associate By Business', 'Associate By Shared Associates', 'Associate By SSN', 'Child', 'Father', 'Grandchild', 'Granddaughter', 'Grandparent', 'Grandson', 'Neighbor', 'Relative', 'Sister', 'Son', 'Spouse', 'Subject', 'Subject at Household', 'Wife']) => final_score_66_c495,
    (phone_subject_title in ['Associate By Property', 'Associate By Vehicle', 'Brother', 'Daughter', 'Grandfather', 'Grandmother', 'Husband', 'Mother', 'Parent', 'Sibling'])                                                                                                                                                => final_score_66_c496,
    phone_subject_title = ''                                                                                                                                                                                                                                                                                               => -0.0035766393,
                                                                                                                                                                                                                                                                                                                                -0.0035766393);

final_score_66 := map(
    NULL < mth_source_paw_fseen AND mth_source_paw_fseen <= 152.5 => 0.0452602260,
    mth_source_paw_fseen > 152.5                                  => -0.0717802924,
    mth_source_paw_fseen = NULL                                   => final_score_66_c494,
                                                                     -0.0026428326);

final_score_67_c501 := map(
    NULL < r_i60_inq_comm_recency_d AND r_i60_inq_comm_recency_d <= 549 => -0.0374301307,
    r_i60_inq_comm_recency_d > 549                                      => 0.0103687936,
    r_i60_inq_comm_recency_d = NULL                                     => -0.0056490809,
                                                                           -0.0056490809);

final_score_67_c502 := map(
    NULL < mth_source_ppla_fseen AND mth_source_ppla_fseen <= 27.5 => 0.0315726933,
    mth_source_ppla_fseen > 27.5                                   => -0.0361017060,
    mth_source_ppla_fseen = NULL                                   => -0.0027323033,
                                                                      -0.0031269299);

final_score_67_c500 := map(
    NULL < mth_source_ppdid_fseen AND mth_source_ppdid_fseen <= 8.5 => 0.0343280604,
    mth_source_ppdid_fseen > 8.5                                    => final_score_67_c501,
    mth_source_ppdid_fseen = NULL                                   => final_score_67_c502,
                                                                       -0.0010092693);

final_score_67_c499 := map(
    NULL < mth_source_edaca_fseen AND mth_source_edaca_fseen <= 16.5 => 0.0593504520,
    mth_source_edaca_fseen > 16.5                                    => -0.0463976755,
    mth_source_edaca_fseen = NULL                                    => final_score_67_c500,
                                                                        -0.0017546678);

final_score_67 := map(
    NULL < r_paw_active_phone_ct_d AND r_paw_active_phone_ct_d <= 1.5 => final_score_67_c499,
    r_paw_active_phone_ct_d > 1.5                                     => 0.0418697640,
    r_paw_active_phone_ct_d = NULL                                    => -0.0000255157,
                                                                         -0.0000255157);

final_score_68_c504 := map(
    (pp_src in ['', 'CY', 'E1', 'E4', 'EB', 'EM', 'EN', 'EQ', 'FA', 'KW', 'LA', 'MD', 'NW', 'PL', 'SL', 'SV', 'TN', 'VO', 'VW', 'ZT']) => -0.0235944079,
    (pp_src in ['E2', 'FF', 'LP', 'UT', 'UW', 'YE', 'ZK'])                                                                             => 0.0218350451,
    pp_src = ''                                                                                                                      => -0.0148541183,
                                                                                                                                          -0.0148541183);

final_score_68_c507 := map(
    (phone_subject_title in ['Associate', 'Associate By Address', 'Associate By Property', 'Child', 'Daughter', 'Father', 'Subject', 'Subject at Household'])                                                                                                                                                                                => 0.0114539249,
    (phone_subject_title in ['Associate By Business', 'Associate By Shared Associates', 'Associate By SSN', 'Associate By Vehicle', 'Brother', 'Grandchild', 'Granddaughter', 'Grandfather', 'Grandmother', 'Grandparent', 'Grandson', 'Husband', 'Mother', 'Neighbor', 'Parent', 'Relative', 'Sibling', 'Sister', 'Son', 'Spouse', 'Wife']) => 0.0526564354,
    phone_subject_title = ''                                                                                                                                                                                                                                                                                                               => 0.0193985171,
                                                                                                                                                                                                                                                                                                                                                0.0193985171);

final_score_68_c506 := map(
    NULL < _phone_zip_match AND _phone_zip_match <= 0.5 => 0.0009175405,
    _phone_zip_match > 0.5                              => final_score_68_c507,
    _phone_zip_match = NULL                             => 0.0074320268,
                                                           0.0074320268);

final_score_68_c505 := map(
    (phone_subject_title in ['Associate By Business', 'Grandchild', 'Granddaughter', 'Grandfather', 'Grandson', 'Husband', 'Neighbor', 'Son', 'Wife'])                                                                                                                                                                                              => -0.0422930718,
    (phone_subject_title in ['Associate', 'Associate By Address', 'Associate By Property', 'Associate By Shared Associates', 'Associate By SSN', 'Associate By Vehicle', 'Brother', 'Child', 'Daughter', 'Father', 'Grandmother', 'Grandparent', 'Mother', 'Parent', 'Relative', 'Sibling', 'Sister', 'Spouse', 'Subject', 'Subject at Household']) => final_score_68_c506,
    phone_subject_title = ''                                                                                                                                                                                                                                                                                                                      => 0.0047996183,
                                                                                                                                                                                                                                                                                                                                                       0.0047996183);

final_score_68 := map(
    NULL < f_add_input_mobility_index_n AND f_add_input_mobility_index_n <= 0.198658356561776 => final_score_68_c504,
    f_add_input_mobility_index_n > 0.198658356561776                                          => final_score_68_c505,
    f_add_input_mobility_index_n = NULL                                                       => -0.0500958258,
                                                                                                 0.0004073759);

final_score_69_c511 := map(
    NULL < mth_pp_eda_hist_ph_dt AND mth_pp_eda_hist_ph_dt <= 22.5 => -0.0637311957,
    mth_pp_eda_hist_ph_dt > 22.5                                   => 0.1140930999,
    mth_pp_eda_hist_ph_dt = NULL                                   => 0.0693290762,
                                                                      0.0693290762);

final_score_69_c510 := map(
    NULL < (integer)inq_lastseen_n AND (integer)inq_lastseen_n <= 32.5 => final_score_69_c511,
    (integer)inq_lastseen_n > 32.5                            => -0.0411682156,
    (integer)inq_lastseen_n = NULL                            => -0.0746972736,
                                                        -0.0416476476);

final_score_69_c512 := map(
    NULL < (integer)_internal_ver_match_hhid AND (integer)_internal_ver_match_hhid <= 0.5 => -0.0001419919,
    (integer)_internal_ver_match_hhid > 0.5                                      => 0.0291581067,
    (integer)_internal_ver_match_hhid = NULL                                     => 0.0029269749,
                                                                           0.0029269749);

final_score_69_c509 := map(
    NULL < mth_eda_deletion_date AND mth_eda_deletion_date <= 3.5 => 0.1037428748,
    mth_eda_deletion_date > 3.5                                   => final_score_69_c510,
    mth_eda_deletion_date = NULL                                  => final_score_69_c512,
                                                                     -0.0003374147);

final_score_69 := map(
    (pp_app_ph_type in ['', 'CELL', 'PAGE', 'POTS', 'Puerto Rico/US Virgin Isl']) => final_score_69_c509,
    (pp_app_ph_type in ['LNDLN PRTD TO CELL', 'VOIP'])                            => 0.0666935612,
    pp_app_ph_type = ''                                                         => 0.0006470035,
                                                                                     0.0006470035);

final_score_70_c515 := map(
    (phone_subject_title in ['Associate', 'Associate By Address', 'Associate By Business', 'Associate By Shared Associates', 'Associate By SSN', 'Associate By Vehicle', 'Brother', 'Father', 'Granddaughter', 'Grandfather', 'Grandmother', 'Mother', 'Sibling', 'Son', 'Wife']) => -0.0415699824,
    (phone_subject_title in ['Associate By Property', 'Child', 'Daughter', 'Grandchild', 'Grandparent', 'Grandson', 'Husband', 'Neighbor', 'Parent', 'Relative', 'Sister', 'Spouse', 'Subject', 'Subject at Household'])                                                          => 0.0752121396,
    phone_subject_title = ''                                                                                                                                                                                                                                                    => 0.0053089277,
                                                                                                                                                                                                                                                                                     0.0053089277);

final_score_70_c514 := map(
    NULL < f_curraddrcartheftindex_i AND f_curraddrcartheftindex_i <= 98.5 => -0.0754807016,
    f_curraddrcartheftindex_i > 98.5                                       => final_score_70_c515,
    f_curraddrcartheftindex_i = NULL                                       => -0.0330748691,
                                                                              -0.0330748691);

final_score_70_c517 := map(
    NULL < (integer)_phone_match_code_lns AND (integer)_phone_match_code_lns <= 0.5 => 0.0185176537,
    (integer)_phone_match_code_lns > 0.5                                   => 0.1333329237,
    (integer)_phone_match_code_lns = NULL                                  => 0.0353333380,
                                                                     0.0353333380);

final_score_70_c516 := map(
    (phone_subject_title in ['Associate', 'Associate By Address', 'Associate By Business', 'Associate By Shared Associates', 'Associate By SSN', 'Child', 'Daughter', 'Father', 'Grandchild', 'Granddaughter', 'Grandmother', 'Grandson', 'Mother', 'Neighbor', 'Parent', 'Sibling', 'Sister', 'Spouse', 'Subject', 'Subject at Household']) => 0.0017548270,
    (phone_subject_title in ['Associate By Property', 'Associate By Vehicle', 'Brother', 'Grandfather', 'Grandparent', 'Husband', 'Relative', 'Son', 'Wife'])                                                                                                                                                                                => final_score_70_c517,
    phone_subject_title = ''                                                                                                                                                                                                                                                                                                               => 0.0035002466,
                                                                                                                                                                                                                                                                                                                                                0.0035002466);

final_score_70 := map(
    NULL < pk_phone_match_level AND pk_phone_match_level <= 0.5 => final_score_70_c514,
    pk_phone_match_level > 0.5                                  => final_score_70_c516,
    pk_phone_match_level = NULL                                 => 0.0018886575,
                                                                   0.0018886575);

final_score_71_c520 := map(
    NULL < mth_pp_datefirstseen AND mth_pp_datefirstseen <= 35.5 => -0.0075695962,
    mth_pp_datefirstseen > 35.5                                  => 0.0142300619,
    mth_pp_datefirstseen = NULL                                  => 0.0007307184,
                                                                    0.0009210491);

final_score_71_c522 := map(
    NULL < f_rel_under100miles_cnt_d AND f_rel_under100miles_cnt_d <= 8.5 => 0.0742566214,
    f_rel_under100miles_cnt_d > 8.5                                       => -0.0190951123,
    f_rel_under100miles_cnt_d = NULL                                      => 0.0268669260,
                                                                             0.0268669260);

final_score_71_c521 := map(
    NULL < f_idverrisktype_i AND f_idverrisktype_i <= 7 => final_score_71_c522,
    f_idverrisktype_i > 7                               => 0.1217699958,
    f_idverrisktype_i = NULL                            => 0.0430964687,
                                                           0.0430964687);

final_score_71_c519 := map(
    (eda_pfrd_address_ind in ['1A', '1B', 'XX']) => final_score_71_c520,
    (eda_pfrd_address_ind in ['1C', '1D', '1E']) => final_score_71_c521,
    eda_pfrd_address_ind = ''                  => 0.0026020538,
                                                    0.0026020538);

final_score_71 := map(
    NULL < eda_num_ph_owners_cur AND eda_num_ph_owners_cur <= 1.5 => final_score_71_c519,
    eda_num_ph_owners_cur > 1.5                                   => -0.0504813188,
    eda_num_ph_owners_cur = NULL                                  => 0.0011890151,
                                                                     0.0011890151);

final_score_72_c526 := map(
    NULL < f_mos_inq_banko_am_fseen_d AND f_mos_inq_banko_am_fseen_d <= 61.5 => 0.0602492438,
    f_mos_inq_banko_am_fseen_d > 61.5                                        => -0.0058265350,
    f_mos_inq_banko_am_fseen_d = NULL                                        => -0.0041798235,
                                                                                -0.0041798235);

final_score_72_c525 := map(
    NULL < mth_source_utildid_fseen AND mth_source_utildid_fseen <= 11.5 => 0.0731131884,
    mth_source_utildid_fseen > 11.5                                      => -0.0099642982,
    mth_source_utildid_fseen = NULL                                      => final_score_72_c526,
                                                                            -0.0030646318);

final_score_72_c524 := map(
    NULL < _pp_src_all_uw AND _pp_src_all_uw <= 0.5 => final_score_72_c525,
    _pp_src_all_uw > 0.5                            => 0.0346051391,
    _pp_src_all_uw = NULL                           => -0.0006576748,
                                                       -0.0006576748);

final_score_72_c527 := map(
    (phone_subject_title in ['Associate By Address', 'Associate By Business', 'Associate By Property', 'Associate By SSN', 'Daughter', 'Grandmother', 'Neighbor', 'Parent', 'Sibling', 'Sister', 'Subject at Household'])                                                        => -0.0430722734,
    (phone_subject_title in ['Associate', 'Associate By Shared Associates', 'Associate By Vehicle', 'Brother', 'Child', 'Father', 'Grandchild', 'Granddaughter', 'Grandfather', 'Grandparent', 'Grandson', 'Husband', 'Mother', 'Relative', 'Son', 'Spouse', 'Subject', 'Wife']) => 0.0533485896,
    phone_subject_title = ''                                                                                                                                                                                                                                                   => 0.0379060601,
                                                                                                                                                                                                                                                                                    0.0379060601);

final_score_72 := map(
    (eda_pfrd_address_ind in ['1A', '1B', '1E', 'XX']) => final_score_72_c524,
    (eda_pfrd_address_ind in ['1C', '1D'])             => final_score_72_c527,
    eda_pfrd_address_ind = ''                        => 0.0011057084,
                                                          0.0011057084);

final_score_73_c531 := map(
    NULL < f_srchaddrsrchcount_i AND f_srchaddrsrchcount_i <= 8.5 => -0.0081952175,
    f_srchaddrsrchcount_i > 8.5                                   => 0.0269918153,
    f_srchaddrsrchcount_i = NULL                                  => 0.0011492085,
                                                                     0.0011492085);

final_score_73_c530 := map(
    NULL < f_add_input_nhood_bus_pct_i AND f_add_input_nhood_bus_pct_i <= 0.167016397818567 => final_score_73_c531,
    f_add_input_nhood_bus_pct_i > 0.167016397818567                                         => -0.0587399238,
    f_add_input_nhood_bus_pct_i = NULL                                                      => -0.0019231414,
                                                                                               -0.0034310368);

final_score_73_c532 := map(
    NULL < mth_eda_dt_first_seen AND mth_eda_dt_first_seen <= 19.5 => 0.0294949122,
    mth_eda_dt_first_seen > 19.5                                   => -0.0208409141,
    mth_eda_dt_first_seen = NULL                                   => 0.0000089949,
                                                                      -0.0024425773);

final_score_73_c529 := map(
    NULL < (integer)inq_adl_firstseen_n AND (integer)inq_adl_firstseen_n <= 0.5 => final_score_73_c530,
    (integer)inq_adl_firstseen_n > 0.5                                 => 0.0230213458,
    (integer)inq_adl_firstseen_n = NULL                                => final_score_73_c532,
                                                                 0.0015998544);

final_score_73 := map(
    NULL < f_srchunvrfdphonecount_i AND f_srchunvrfdphonecount_i <= 1.5 => final_score_73_c529,
    f_srchunvrfdphonecount_i > 1.5                                      => -0.0388943584,
    f_srchunvrfdphonecount_i = NULL                                     => -0.0006844174,
                                                                           -0.0006844174);

final_score_74_c537 := map(
    NULL < f_add_curr_nhood_vac_pct_i AND f_add_curr_nhood_vac_pct_i <= 0.0466968976112598 => -0.0111010082,
    f_add_curr_nhood_vac_pct_i > 0.0466968976112598                                        => 0.2181373385,
    f_add_curr_nhood_vac_pct_i = NULL                                                      => 0.1062409205,
                                                                                              0.1062409205);

final_score_74_c536 := map(
    NULL < mth_source_ppth_lseen AND mth_source_ppth_lseen <= 33.5 => final_score_74_c537,
    mth_source_ppth_lseen > 33.5                                   => -0.0582981808,
    mth_source_ppth_lseen = NULL                                   => 0.0791099539,
                                                                      0.0385186784);

final_score_74_c535 := map(
    (pp_type in ['', 'B', 'M']) => -0.0050497316,
    (pp_type in ['R', 'U'])     => final_score_74_c536,
    pp_type = ''              => -0.0035018832,
                                   -0.0035018832);

final_score_74_c534 := map(
    NULL < _pp_rule_source_latest AND _pp_rule_source_latest <= 0.5 => final_score_74_c535,
    _pp_rule_source_latest > 0.5                                    => 0.0181128951,
    _pp_rule_source_latest = NULL                                   => 0.0021976469,
                                                                       0.0021976469);

final_score_74 := map(
    NULL < mth_pp_eda_hist_nm_addr_dt AND mth_pp_eda_hist_nm_addr_dt <= 78.5 => -0.0581572989,
    mth_pp_eda_hist_nm_addr_dt > 78.5                                        => -0.0208236023,
    mth_pp_eda_hist_nm_addr_dt = NULL                                        => final_score_74_c534,
                                                                                -0.0011151216);

final_score_75_c541 := map(
    NULL < _phone_zip_match AND _phone_zip_match <= 0.5 => -0.0178837755,
    _phone_zip_match > 0.5                              => 0.0709753359,
    _phone_zip_match = NULL                             => 0.0308843254,
                                                           0.0308843254);

final_score_75_c540 := map(
    NULL < f_add_curr_nhood_mfd_pct_i AND f_add_curr_nhood_mfd_pct_i <= 0.696597209292704 => final_score_75_c541,
    f_add_curr_nhood_mfd_pct_i > 0.696597209292704                                        => 0.1577187122,
    f_add_curr_nhood_mfd_pct_i = NULL                                                     => 0.0427190573,
                                                                                             0.0488318001);

final_score_75_c539 := map(
    (phone_subject_title in ['Associate', 'Associate By Business', 'Associate By Property', 'Associate By Shared Associates', 'Associate By SSN', 'Child', 'Grandchild', 'Granddaughter', 'Grandfather', 'Neighbor', 'Sister', 'Subject', 'Subject at Household']) => -0.0052886084,
    (phone_subject_title in ['Associate By Address', 'Associate By Vehicle', 'Brother', 'Daughter', 'Father', 'Grandmother', 'Grandparent', 'Grandson', 'Husband', 'Mother', 'Parent', 'Relative', 'Sibling', 'Son', 'Spouse', 'Wife'])                            => final_score_75_c540,
    phone_subject_title = ''                                                                                                                                                                                                                                     => 0.0159009184,
                                                                                                                                                                                                                                                                      0.0159009184);

final_score_75_c542 := map(
    NULL < r_c18_invalid_addrs_per_adl_i AND r_c18_invalid_addrs_per_adl_i <= 7.5 => 0.0063604284,
    r_c18_invalid_addrs_per_adl_i > 7.5                                           => -0.0440160446,
    r_c18_invalid_addrs_per_adl_i = NULL                                          => 0.0037510022,
                                                                                     0.0037510022);

final_score_75 := map(
    NULL < mth_eda_dt_first_seen AND mth_eda_dt_first_seen <= 16.5 => final_score_75_c539,
    mth_eda_dt_first_seen > 16.5                                   => -0.0097925525,
    mth_eda_dt_first_seen = NULL                                   => final_score_75_c542,
                                                                      0.0005480965);

final_score_76_c547 := map(
    NULL < r_a49_curr_avm_chg_1yr_pct_i AND r_a49_curr_avm_chg_1yr_pct_i <= 110.15 => -0.0352191192,
    r_a49_curr_avm_chg_1yr_pct_i > 110.15                                          => 0.0231611910,
    r_a49_curr_avm_chg_1yr_pct_i = NULL                                            => 0.0068483884,
                                                                                      0.0011282656);

final_score_76_c546 := map(
    NULL < mth_eda_dt_last_seen AND mth_eda_dt_last_seen <= 56.5 => final_score_76_c547,
    mth_eda_dt_last_seen > 56.5                                  => 0.0930251124,
    mth_eda_dt_last_seen = NULL                                  => 0.0024407322,
                                                                    0.0039339101);

final_score_76_c545 := map(
    NULL < (integer)inq_adl_lastseen_n AND (integer)inq_adl_lastseen_n <= 60.5 => final_score_76_c546,
    (integer)inq_adl_lastseen_n > 60.5                                => -0.0834263219,
    (integer)inq_adl_lastseen_n = NULL                                => -0.0024297084,
                                                                -0.0000882606);

final_score_76_c544 := map(
    NULL < mth_source_inf_fseen AND mth_source_inf_fseen <= 221.5 => -0.0343090755,
    mth_source_inf_fseen > 221.5                                  => 0.0345257780,
    mth_source_inf_fseen = NULL                                   => final_score_76_c545,
                                                                     -0.0011371575);

final_score_76 := map(
    NULL < r_paw_active_phone_ct_d AND r_paw_active_phone_ct_d <= 1.5 => final_score_76_c544,
    r_paw_active_phone_ct_d > 1.5                                     => 0.0393599378,
    r_paw_active_phone_ct_d = NULL                                    => 0.0005230130,
                                                                         0.0005230130);

final_score_77_c549 := map(
    NULL < f_srchvelocityrisktype_i AND f_srchvelocityrisktype_i <= 4.5 => 0.0143062365,
    f_srchvelocityrisktype_i > 4.5                                      => -0.0165359331,
    f_srchvelocityrisktype_i = NULL                                     => 0.0004094459,
                                                                           0.0004094459);

final_score_77_c551 := map(
    NULL < f_curraddrburglaryindex_i AND f_curraddrburglaryindex_i <= 183.5 => -0.0368849543,
    f_curraddrburglaryindex_i > 183.5                                       => 0.0759233961,
    f_curraddrburglaryindex_i = NULL                                        => -0.0276500420,
                                                                               -0.0276500420);

final_score_77_c552 := map(
    NULL < f_add_curr_mobility_index_n AND f_add_curr_mobility_index_n <= 0.158619759448574 => -0.0422230691,
    f_add_curr_mobility_index_n > 0.158619759448574                                         => 0.0036640112,
    f_add_curr_mobility_index_n = NULL                                                      => -0.0884304418,
                                                                                               -0.0007508632);

final_score_77_c550 := map(
    NULL < mth_source_ppca_lseen AND mth_source_ppca_lseen <= 76.5 => final_score_77_c551,
    mth_source_ppca_lseen > 76.5                                   => -0.1133604444,
    mth_source_ppca_lseen = NULL                                   => final_score_77_c552,
                                                                      -0.0061524192);

final_score_77 := map(
    NULL < mth_internal_ver_last_seen AND mth_internal_ver_last_seen <= 0.5 => final_score_77_c549,
    mth_internal_ver_last_seen > 0.5                                        => 0.0237688776,
    mth_internal_ver_last_seen = NULL                                       => final_score_77_c550,
                                                                               -0.0001627027);

final_score_78_c556 := map(
    NULL < f_add_curr_mobility_index_n AND f_add_curr_mobility_index_n <= 0.863111188465685 => 0.0021401905,
    f_add_curr_mobility_index_n > 0.863111188465685                                         => -0.0709609428,
    f_add_curr_mobility_index_n = NULL                                                      => -0.0592394345,
                                                                                               0.0009073890);

final_score_78_c557 := map(
    NULL < mth_source_ppfla_lseen AND mth_source_ppfla_lseen <= 21.5 => -0.1862609981,
    mth_source_ppfla_lseen > 21.5                                    => 0.0585021510,
    mth_source_ppfla_lseen = NULL                                    => -0.0825243406,
                                                                        -0.0710896896);

final_score_78_c555 := map(
    NULL < eda_max_days_connected_ind AND eda_max_days_connected_ind <= 38.5 => final_score_78_c556,
    eda_max_days_connected_ind > 38.5                                        => final_score_78_c557,
    eda_max_days_connected_ind = NULL                                        => -0.0020148656,
                                                                                -0.0020148656);

final_score_78_c554 := map(
    NULL < mth_source_sx_fseen AND mth_source_sx_fseen <= 9.5 => 0.0867432348,
    mth_source_sx_fseen > 9.5                                 => 0.0187279082,
    mth_source_sx_fseen = NULL                                => final_score_78_c555,
                                                                 -0.0001051114);

final_score_78 := map(
    NULL < r_s65_ssn_deceased_i AND r_s65_ssn_deceased_i <= 0.5 => final_score_78_c554,
    r_s65_ssn_deceased_i > 0.5                                  => -0.0682269286,
    r_s65_ssn_deceased_i = NULL                                 => -0.0044569981,
                                                                   -0.0013499667);

final_score_79_c560 := map(
    NULL < r_a49_curr_avm_chg_1yr_i AND r_a49_curr_avm_chg_1yr_i <= 3667.5 => -0.0486438830,
    r_a49_curr_avm_chg_1yr_i > 3667.5                                      => 0.0746456206,
    r_a49_curr_avm_chg_1yr_i = NULL                                        => 0.0423885640,
                                                                              0.0367000986);

final_score_79_c559 := map(
    (phone_subject_title in ['Associate', 'Associate By Address', 'Associate By Business', 'Associate By Shared Associates', 'Brother', 'Child', 'Daughter', 'Father', 'Grandchild', 'Granddaughter', 'Grandfather', 'Neighbor', 'Relative', 'Sibling', 'Son', 'Spouse', 'Subject', 'Subject at Household']) => 0.0012030071,
    (phone_subject_title in ['Associate By Property', 'Associate By SSN', 'Associate By Vehicle', 'Grandmother', 'Grandparent', 'Grandson', 'Husband', 'Mother', 'Parent', 'Sister', 'Wife'])                                                                                                                => final_score_79_c560,
    phone_subject_title = ''                                                                                                                                                                                                                                                                               => 0.0028828536,
                                                                                                                                                                                                                                                                                                                0.0028828536);

final_score_79_c562 := map(
    NULL < f_util_adl_count_n AND f_util_adl_count_n <= 14.5 => -0.0293801075,
    f_util_adl_count_n > 14.5                                => 0.1233013286,
    f_util_adl_count_n = NULL                                => -0.0186104089,
                                                                -0.0186104089);

final_score_79_c561 := map(
    NULL < mth_source_ppdid_fseen AND mth_source_ppdid_fseen <= 14.5 => 0.0092615222,
    mth_source_ppdid_fseen > 14.5                                    => -0.0692807428,
    mth_source_ppdid_fseen = NULL                                    => final_score_79_c562,
                                                                        -0.0300318635);

final_score_79 := map(
    NULL < f_inq_count_i AND f_inq_count_i <= 27.5 => final_score_79_c559,
    f_inq_count_i > 27.5                           => final_score_79_c561,
    f_inq_count_i = NULL                           => -0.0001358647,
                                                      -0.0001358647);

final_score_80_c565 := map(
    NULL < mth_pp_app_npa_last_change_dt AND mth_pp_app_npa_last_change_dt <= 32.5 => 0.0385742464,
    mth_pp_app_npa_last_change_dt > 32.5                                           => -0.0155145048,
    mth_pp_app_npa_last_change_dt = NULL                                           => -0.0102457516,
                                                                                      -0.0104000703);

final_score_80_c564 := map(
    NULL < mth_eda_deletion_date AND mth_eda_deletion_date <= 2.5 => 0.1291225726,
    mth_eda_deletion_date > 2.5                                   => -0.0033064215,
    mth_eda_deletion_date = NULL                                  => final_score_80_c565,
                                                                     -0.0088048627);

final_score_80_c567 := map(
    (pp_origphonetype in ['L', 'O', 'V', 'W']) => 0.0165861524,
    (pp_origphonetype in [''])                 => 0.1336768568,
    pp_origphonetype = ''                    => 0.0617186804,
                                                  0.0617186804);

final_score_80_c566 := map(
    NULL < mth_source_ppth_fseen AND mth_source_ppth_fseen <= 76.5 => final_score_80_c567,
    mth_source_ppth_fseen > 76.5                                   => -0.0173398633,
    mth_source_ppth_fseen = NULL                                   => 0.0063135437,
                                                                      0.0076433550);

final_score_80 := map(
    NULL < f_mos_inq_banko_cm_fseen_d AND f_mos_inq_banko_cm_fseen_d <= 81.5 => final_score_80_c564,
    f_mos_inq_banko_cm_fseen_d > 81.5                                        => final_score_80_c566,
    f_mos_inq_banko_cm_fseen_d = NULL                                        => -0.0002716451,
                                                                                -0.0002716451);

final_score_81_c572 := map(
    NULL < eda_days_ph_first_seen AND eda_days_ph_first_seen <= 5125.5 => 0.0038193729,
    eda_days_ph_first_seen > 5125.5                                    => 0.1039983745,
    eda_days_ph_first_seen = NULL                                      => 0.0281238300,
                                                                          0.0281238300);

final_score_81_c571 := map(
    NULL < r_c13_max_lres_d AND r_c13_max_lres_d <= 305.5 => final_score_81_c572,
    r_c13_max_lres_d > 305.5                              => -0.1434523843,
    r_c13_max_lres_d = NULL                               => 0.0174523786,
                                                             0.0174523786);

final_score_81_c570 := map(
    NULL < r_a49_curr_avm_chg_1yr_pct_i AND r_a49_curr_avm_chg_1yr_pct_i <= 109.45 => -0.0797528667,
    r_a49_curr_avm_chg_1yr_pct_i > 109.45                                          => 0.0614351712,
    r_a49_curr_avm_chg_1yr_pct_i = NULL                                            => final_score_81_c571,
                                                                                      0.0091117228);

final_score_81_c569 := map(
    NULL < _phone_match_code_tcza AND _phone_match_code_tcza <= 3.5 => final_score_81_c570,
    _phone_match_code_tcza > 3.5                                    => 0.0980342326,
    _phone_match_code_tcza = NULL                                   => 0.0188072234,
                                                                       0.0188072234);

final_score_81 := map(
    NULL < mth_source_rm_fseen AND mth_source_rm_fseen <= 48.5 => final_score_81_c569,
    mth_source_rm_fseen > 48.5                                 => -0.0488410304,
    mth_source_rm_fseen = NULL                                 => -0.0021501268,
                                                                  -0.0016535945);

final_score_82_c577 := map(
    NULL < mth_source_ppdid_fseen AND mth_source_ppdid_fseen <= 31.5 => 0.0006173843,
    mth_source_ppdid_fseen > 31.5                                    => -0.0731308855,
    mth_source_ppdid_fseen = NULL                                    => -0.0192849945,
                                                                        -0.0190399081);

final_score_82_c576 := map(
    NULL < mth_pp_datefirstseen AND mth_pp_datefirstseen <= 35.5 => final_score_82_c577,
    mth_pp_datefirstseen > 35.5                                  => 0.0135293824,
    mth_pp_datefirstseen = NULL                                  => -0.0042436907,
                                                                    -0.0042436907);

final_score_82_c575 := map(
    (pp_source in ['', 'CELL', 'IBEHAVIOR', 'INTRADO', 'OTHER', 'TARGUS', 'THRIVE']) => -0.0538021448,
    (pp_source in ['GONG', 'HEADER', 'INFUTOR', 'INQUIRY', 'PCNSR', 'WIRED'])        => final_score_82_c576,
    pp_source = ''                                                                 => -0.0106355445,
                                                                                        -0.0106355445);

final_score_82_c574 := map(
    (pp_origlistingtype in ['BG', 'R', 'RB']) => final_score_82_c575,
    (pp_origlistingtype in ['', 'B'])         => 0.0068104269,
    pp_origlistingtype = ''                 => 0.0002053712,
                                                 0.0002053712);

final_score_82 := map(
    NULL < eda_num_ph_owners_cur AND eda_num_ph_owners_cur <= 1.5 => final_score_82_c574,
    eda_num_ph_owners_cur > 1.5                                   => -0.0509267149,
    eda_num_ph_owners_cur = NULL                                  => -0.0011285735,
                                                                     -0.0011285735);

final_score_83_c580 := map(
    (phone_subject_title in ['Associate By Address', 'Associate By Business', 'Associate By Property', 'Associate By SSN', 'Child', 'Father', 'Granddaughter', 'Mother', 'Neighbor', 'Parent', 'Sibling', 'Sister', 'Son', 'Subject', 'Subject at Household', 'Wife']) => 0.0000258912,
    (phone_subject_title in ['Associate', 'Associate By Shared Associates', 'Associate By Vehicle', 'Brother', 'Daughter', 'Grandchild', 'Grandfather', 'Grandmother', 'Grandparent', 'Grandson', 'Husband', 'Relative', 'Spouse'])                                    => 0.0601116596,
    phone_subject_title = ''                                                                                                                                                                                                                                         => 0.0125936070,
                                                                                                                                                                                                                                                                          0.0125936070);

final_score_83_c581 := map(
    NULL < _mod_disc_noexp_lgt AND _mod_disc_noexp_lgt <= 0.48842523607922 => -0.0342037825,
    _mod_disc_noexp_lgt > 0.48842523607922                                 => 0.0024410233,
    _mod_disc_noexp_lgt = NULL                                             => -0.0163961418,
                                                                              -0.0163961418);

final_score_83_c579 := map(
    NULL < f_rel_incomeover75_count_d AND f_rel_incomeover75_count_d <= 0.5 => final_score_83_c580,
    f_rel_incomeover75_count_d > 0.5                                        => final_score_83_c581,
    f_rel_incomeover75_count_d = NULL                                       => -0.0062122379,
                                                                               -0.0062122379);

final_score_83_c582 := map(
    NULL < f_inq_highriskcredit_count24_i AND f_inq_highriskcredit_count24_i <= 2.5 => 0.0290587469,
    f_inq_highriskcredit_count24_i > 2.5                                            => -0.0499979745,
    f_inq_highriskcredit_count24_i = NULL                                           => 0.0190528125,
                                                                                       0.0190528125);

final_score_83 := map(
    NULL < (integer)inq_adl_firstseen_n AND (integer)inq_adl_firstseen_n <= 0.5 => final_score_83_c579,
    (integer)inq_adl_firstseen_n > 0.5                                 => final_score_83_c582,
    (integer)inq_adl_firstseen_n = NULL                                => -0.0003386165,
                                                                 0.0013221451);

final_score_84_c587 := map(
    (phone_subject_title in ['Associate', 'Associate By Address', 'Associate By Business', 'Associate By Shared Associates', 'Associate By SSN', 'Associate By Vehicle', 'Brother', 'Child', 'Grandchild', 'Granddaughter', 'Grandfather', 'Husband', 'Neighbor', 'Son', 'Spouse', 'Subject', 'Subject at Household', 'Wife']) => -0.0083154449,
    (phone_subject_title in ['Associate By Property', 'Daughter', 'Father', 'Grandmother', 'Grandparent', 'Grandson', 'Mother', 'Parent', 'Relative', 'Sibling', 'Sister'])                                                                                                                                                    => 0.0444224790,
    phone_subject_title = ''                                                                                                                                                                                                                                                                                                 => 0.0045961463,
                                                                                                                                                                                                                                                                                                                                  0.0045961463);

final_score_84_c586 := map(
    NULL < f_add_curr_nhood_sfd_pct_d AND f_add_curr_nhood_sfd_pct_d <= 0.801267321566542 => final_score_84_c587,
    f_add_curr_nhood_sfd_pct_d > 0.801267321566542                                        => -0.0284235619,
    f_add_curr_nhood_sfd_pct_d = NULL                                                     => -0.0121083391,
                                                                                             -0.0121083391);

final_score_84_c585 := map(
    NULL < eda_days_ph_first_seen AND eda_days_ph_first_seen <= 5202.5 => final_score_84_c586,
    eda_days_ph_first_seen > 5202.5                                    => 0.0301492313,
    eda_days_ph_first_seen = NULL                                      => -0.0021005791,
                                                                          -0.0021005791);

final_score_84_c584 := map(
    NULL < mth_pp_first_build_date AND mth_pp_first_build_date <= 31.5 => 0.0016631858,
    mth_pp_first_build_date > 31.5                                     => -0.0493824683,
    mth_pp_first_build_date = NULL                                     => final_score_84_c585,
                                                                          -0.0018844598);

final_score_84 := map(
    NULL < f_add_curr_nhood_bus_pct_i AND f_add_curr_nhood_bus_pct_i <= 0.55776137663552 => final_score_84_c584,
    f_add_curr_nhood_bus_pct_i > 0.55776137663552                                        => 0.0880336212,
    f_add_curr_nhood_bus_pct_i = NULL                                                    => -0.0076743831,
                                                                                            -0.0014227118);

final_score_85_c592 := map(
    NULL < f_rel_incomeover75_count_d AND f_rel_incomeover75_count_d <= 18.5 => -0.0008411273,
    f_rel_incomeover75_count_d > 18.5                                        => 0.0958926528,
    f_rel_incomeover75_count_d = NULL                                        => 0.0000211517,
                                                                                0.0000211517);

final_score_85_c591 := map(
    NULL < f_rel_under25miles_cnt_d AND f_rel_under25miles_cnt_d <= 48.5 => final_score_85_c592,
    f_rel_under25miles_cnt_d > 48.5                                      => -0.1590550804,
    f_rel_under25miles_cnt_d = NULL                                      => -0.0488956844,
                                                                            -0.0005893336);

final_score_85_c590 := map(
    NULL < mth_source_rm_fseen AND mth_source_rm_fseen <= 5.5 => 0.0618275112,
    mth_source_rm_fseen > 5.5                                 => -0.0007094199,
    mth_source_rm_fseen = NULL                                => final_score_85_c591,
                                                                 0.0003184755);

final_score_85_c589 := map(
    NULL < f_mos_liens_unrel_sc_fseen_d AND f_mos_liens_unrel_sc_fseen_d <= 42.5 => -0.0632536122,
    f_mos_liens_unrel_sc_fseen_d > 42.5                                          => final_score_85_c590,
    f_mos_liens_unrel_sc_fseen_d = NULL                                          => -0.0008786793,
                                                                                    -0.0008786793);

final_score_85 := map(
    NULL < _phone_timezone_match AND _phone_timezone_match <= 0.5 => -0.0333247706,
    _phone_timezone_match > 0.5                                   => final_score_85_c589,
    _phone_timezone_match = NULL                                  => -0.0034270450,
                                                                     -0.0034270450);

final_score_86_c596 := map(
    (pp_did_type in ['', 'CORE', 'NO_SSN'])           => -0.0299368274,
    (pp_did_type in ['AMBIG', 'C_MERGE', 'INACTIVE']) => 0.0671836456,
    pp_did_type = ''                                => -0.0257517874,
                                                         -0.0257517874);

final_score_86_c597 := map(
    NULL < mth_pp_orig_lastseen AND mth_pp_orig_lastseen <= 95.5 => 0.0037859410,
    mth_pp_orig_lastseen > 95.5                                  => -0.1035464738,
    mth_pp_orig_lastseen = NULL                                  => 0.0005950331,
                                                                    0.0006395211);

final_score_86_c595 := map(
    NULL < f_mos_inq_banko_cm_lseen_d AND f_mos_inq_banko_cm_lseen_d <= 34.5 => final_score_86_c596,
    f_mos_inq_banko_cm_lseen_d > 34.5                                        => final_score_86_c597,
    f_mos_inq_banko_cm_lseen_d = NULL                                        => -0.0045482679,
                                                                                -0.0045482679);

final_score_86_c594 := map(
    NULL < f_add_input_mobility_index_n AND f_add_input_mobility_index_n <= 0.364667253769964 => final_score_86_c595,
    f_add_input_mobility_index_n > 0.364667253769964                                          => 0.0152875340,
    f_add_input_mobility_index_n = NULL                                                       => -0.0039956116,
                                                                                                 -0.0005052760);

final_score_86 := map(
    NULL < f_inq_collection_count_i AND f_inq_collection_count_i <= 18.5 => final_score_86_c594,
    f_inq_collection_count_i > 18.5                                      => -0.0443665685,
    f_inq_collection_count_i = NULL                                      => -0.0017682170,
                                                                            -0.0017682170);

final_score_87_c601 := map(
    (phone_subject_title in ['Associate By Address', 'Father', 'Grandmother', 'Grandparent', 'Neighbor', 'Parent', 'Sister', 'Spouse', 'Subject', 'Subject at Household'])                                                                                                                                                      => 0.0208191316,
    (phone_subject_title in ['Associate', 'Associate By Business', 'Associate By Property', 'Associate By Shared Associates', 'Associate By SSN', 'Associate By Vehicle', 'Brother', 'Child', 'Daughter', 'Grandchild', 'Granddaughter', 'Grandfather', 'Grandson', 'Husband', 'Mother', 'Relative', 'Sibling', 'Son', 'Wife']) => 0.1462000699,
    phone_subject_title = ''                                                                                                                                                                                                                                                                                                  => 0.0546903938,
                                                                                                                                                                                                                                                                                                                                   0.0546903938);

final_score_87_c600 := map(
    NULL < f_add_input_nhood_mfd_pct_i AND f_add_input_nhood_mfd_pct_i <= 0.244556583496869 => -0.0415065108,
    f_add_input_nhood_mfd_pct_i > 0.244556583496869                                         => final_score_87_c601,
    f_add_input_nhood_mfd_pct_i = NULL                                                      => -0.0139750116,
                                                                                               0.0011598846);

final_score_87_c602 := map(
    NULL < mth_pp_app_npa_effective_dt AND mth_pp_app_npa_effective_dt <= 105.5 => -0.0892013619,
    mth_pp_app_npa_effective_dt > 105.5                                         => -0.0188889277,
    mth_pp_app_npa_effective_dt = NULL                                          => -0.0677250046,
                                                                                   -0.0468570935);

final_score_87_c599 := map(
    NULL < f_add_input_nhood_bus_pct_i AND f_add_input_nhood_bus_pct_i <= 0.0274662408529685 => final_score_87_c600,
    f_add_input_nhood_bus_pct_i > 0.0274662408529685                                         => final_score_87_c602,
    f_add_input_nhood_bus_pct_i = NULL                                                       => -0.0312404714,
                                                                                                -0.0289146421);

final_score_87 := map(
    NULL < f_corraddrnamecount_d AND f_corraddrnamecount_d <= 2.5 => final_score_87_c599,
    f_corraddrnamecount_d > 2.5                                   => -0.0001551585,
    f_corraddrnamecount_d = NULL                                  => -0.0031423064,
                                                                     -0.0031423064);

final_score_88_c606 := map(
    NULL < f_addrchangecrimediff_i AND f_addrchangecrimediff_i <= 0.5 => -0.0027113387,
    f_addrchangecrimediff_i > 0.5                                     => -0.0798034040,
    f_addrchangecrimediff_i = NULL                                    => -0.0223202961,
                                                                         -0.0281210916);

final_score_88_c605 := map(
    NULL < mth_pp_eda_hist_did_dt AND mth_pp_eda_hist_did_dt <= 106.5 => 0.0038979466,
    mth_pp_eda_hist_did_dt > 106.5                                    => final_score_88_c606,
    mth_pp_eda_hist_did_dt = NULL                                     => 0.0013038827,
                                                                         -0.0001115720);

final_score_88_c607 := map(
    NULL < _mod_disc_noexp_lgt AND _mod_disc_noexp_lgt <= 6.81480942428432 => 0.1311033584,
    _mod_disc_noexp_lgt > 6.81480942428432                                 => -0.1140950557,
    _mod_disc_noexp_lgt = NULL                                             => 0.0648572487,
                                                                              0.0648572487);

final_score_88_c604 := map(
    NULL < _pp_rule_non_pub AND _pp_rule_non_pub <= 0.5 => final_score_88_c605,
    _pp_rule_non_pub > 0.5                              => final_score_88_c607,
    _pp_rule_non_pub = NULL                             => 0.0004582399,
                                                           0.0004582399);

final_score_88 := map(
    NULL < f_srchaddrsrchcount_i AND f_srchaddrsrchcount_i <= 59.5 => final_score_88_c604,
    f_srchaddrsrchcount_i > 59.5                                   => 0.0868407374,
    f_srchaddrsrchcount_i = NULL                                   => 0.0012461366,
                                                                      0.0012461366);

final_score_89_c612 := map(
    NULL < r_d32_mos_since_fel_ls_d AND r_d32_mos_since_fel_ls_d <= 70.5 => -0.1121167793,
    r_d32_mos_since_fel_ls_d > 70.5                                      => 0.0100671228,
    r_d32_mos_since_fel_ls_d = NULL                                      => 0.0090034826,
                                                                            0.0090034826);

final_score_89_c611 := map(
    (phone_subject_title in ['Associate', 'Associate By Address', 'Associate By Business', 'Associate By Shared Associates', 'Brother', 'Child', 'Daughter', 'Father', 'Grandchild', 'Granddaughter', 'Grandparent', 'Grandson', 'Husband', 'Mother', 'Neighbor', 'Parent', 'Relative', 'Sister', 'Son', 'Spouse', 'Subject', 'Subject at Household', 'Wife']) => final_score_89_c612,
    (phone_subject_title in ['Associate By Property', 'Associate By SSN', 'Associate By Vehicle', 'Grandfather', 'Grandmother', 'Sibling'])                                                                                                                                                                                                                    => 0.1149610489,
    phone_subject_title = ''                                                                                                                                                                                                                                                                                                                                 => 0.0100276946,
                                                                                                                                                                                                                                                                                                                                                                  0.0100276946);

final_score_89_c610 := map(
    NULL < f_rel_incomeover50_count_d AND f_rel_incomeover50_count_d <= 7.5 => final_score_89_c611,
    f_rel_incomeover50_count_d > 7.5                                        => -0.0058735317,
    f_rel_incomeover50_count_d = NULL                                       => -0.0630961481,
                                                                               0.0033895657);

final_score_89_c609 := map(
    NULL < mth_source_edaca_lseen AND mth_source_edaca_lseen <= 6.5 => 0.0390481951,
    mth_source_edaca_lseen > 6.5                                    => -0.0500672634,
    mth_source_edaca_lseen = NULL                                   => final_score_89_c610,
                                                                       0.0031721092);

final_score_89 := map(
    NULL < r_c20_email_count_i AND r_c20_email_count_i <= 9.5 => final_score_89_c609,
    r_c20_email_count_i > 9.5                                 => -0.0425141632,
    r_c20_email_count_i = NULL                                => 0.0016903273,
                                                                 0.0016903273);

final_score_90_c615 := map(
    NULL < phone_business_count AND phone_business_count <= 3.5 => -0.0012771375,
    phone_business_count > 3.5                                  => 0.1377608935,
    phone_business_count = NULL                                 => -0.0002889919,
                                                                   -0.0002889919);

final_score_90_c614 := map(
    NULL < f_curraddrmedianincome_d AND f_curraddrmedianincome_d <= 143280 => final_score_90_c615,
    f_curraddrmedianincome_d > 143280                                      => 0.1115799517,
    f_curraddrmedianincome_d = NULL                                        => 0.0010039775,
                                                                              0.0010039775);

final_score_90_c617 := map(
    NULL < r_c18_invalid_addrs_per_adl_i AND r_c18_invalid_addrs_per_adl_i <= 3.5 => 0.0402501373,
    r_c18_invalid_addrs_per_adl_i > 3.5                                           => -0.0254665257,
    r_c18_invalid_addrs_per_adl_i = NULL                                          => 0.0225506336,
                                                                                     0.0225506336);

final_score_90_c616 := map(
    NULL < eda_days_ph_first_seen AND eda_days_ph_first_seen <= 5157.5 => -0.0077982367,
    eda_days_ph_first_seen > 5157.5                                    => final_score_90_c617,
    eda_days_ph_first_seen = NULL                                      => 0.0000810177,
                                                                          0.0000810177);

final_score_90 := map(
    NULL < mth_pp_app_npa_last_change_dt AND mth_pp_app_npa_last_change_dt <= 33.5 => 0.0344451621,
    mth_pp_app_npa_last_change_dt > 33.5                                           => final_score_90_c614,
    mth_pp_app_npa_last_change_dt = NULL                                           => final_score_90_c616,
                                                                                      0.0026251979);

final_score_91_c619 := map(
    NULL < f_assocsuspicousidcount_i AND f_assocsuspicousidcount_i <= 6.5 => 0.0038203331,
    f_assocsuspicousidcount_i > 6.5                                       => 0.1163149235,
    f_assocsuspicousidcount_i = NULL                                      => 0.0379681990,
                                                                             0.0379681990);

final_score_91_c621 := map(
    NULL < _phone_zip_match AND _phone_zip_match <= 0.5 => -0.1890637853,
    _phone_zip_match > 0.5                              => 0.0608929623,
    _phone_zip_match = NULL                             => 0.0406325100,
                                                           0.0406325100);

final_score_91_c622 := map(
    NULL < f_mos_inq_banko_cm_fseen_d AND f_mos_inq_banko_cm_fseen_d <= 44.5 => -0.1192899047,
    f_mos_inq_banko_cm_fseen_d > 44.5                                        => -0.0170347118,
    f_mos_inq_banko_cm_fseen_d = NULL                                        => -0.0234424095,
                                                                                -0.0234424095);

final_score_91_c620 := map(
    NULL < mth_pp_eda_hist_nm_addr_dt AND mth_pp_eda_hist_nm_addr_dt <= 20.5 => -0.1657316940,
    mth_pp_eda_hist_nm_addr_dt > 20.5                                        => final_score_91_c621,
    mth_pp_eda_hist_nm_addr_dt = NULL                                        => final_score_91_c622,
                                                                                -0.0174110263);

final_score_91 := map(
    NULL < mth_source_ppla_fseen AND mth_source_ppla_fseen <= 12.5 => final_score_91_c619,
    mth_source_ppla_fseen > 12.5                                   => final_score_91_c620,
    mth_source_ppla_fseen = NULL                                   => 0.0025079175,
                                                                      0.0016033306);

final_score_92_c625 := map(
    NULL < _phone_zip_match AND _phone_zip_match <= 0.5 => -0.0199901170,
    _phone_zip_match > 0.5                              => 0.0828184728,
    _phone_zip_match = NULL                             => 0.0186981532,
                                                           0.0186981532);

final_score_92_c624 := map(
    NULL < f_srchfraudsrchcount_i AND f_srchfraudsrchcount_i <= 1.5 => final_score_92_c625,
    f_srchfraudsrchcount_i > 1.5                                    => -0.0504398048,
    f_srchfraudsrchcount_i = NULL                                   => -0.0150140456,
                                                                       -0.0150140456);

final_score_92_c627 := map(
    (phone_subject_title in ['Associate', 'Associate By Business', 'Associate By SSN', 'Child', 'Father', 'Granddaughter', 'Grandfather', 'Grandmother', 'Grandson', 'Husband', 'Relative', 'Son', 'Spouse', 'Wife'])                                                                => -0.0933119544,
    (phone_subject_title in ['Associate By Address', 'Associate By Property', 'Associate By Shared Associates', 'Associate By Vehicle', 'Brother', 'Daughter', 'Grandchild', 'Grandparent', 'Mother', 'Neighbor', 'Parent', 'Sibling', 'Sister', 'Subject', 'Subject at Household']) => -0.0114222582,
    phone_subject_title = ''                                                                                                                                                                                                                                                       => -0.0385084666,
                                                                                                                                                                                                                                                                                        -0.0385084666);

final_score_92_c626 := map(
    NULL < pk_phone_match_level AND pk_phone_match_level <= 0.5 => final_score_92_c627,
    pk_phone_match_level > 0.5                                  => 0.0043875071,
    pk_phone_match_level = NULL                                 => 0.0023369343,
                                                                   0.0023369343);

final_score_92 := map(
    NULL < mth_source_ppla_lseen AND mth_source_ppla_lseen <= 10.5 => 0.0390850372,
    mth_source_ppla_lseen > 10.5                                   => final_score_92_c624,
    mth_source_ppla_lseen = NULL                                   => final_score_92_c626,
                                                                      0.0027717696);

final_score_93_c632 := map(
    NULL < pp_app_ind_ph_cnt AND pp_app_ind_ph_cnt <= 8.5 => 0.0086770080,
    pp_app_ind_ph_cnt > 8.5                               => -0.0234138782,
    pp_app_ind_ph_cnt = NULL                              => 0.0061411428,
                                                             0.0061411428);

final_score_93_c631 := map(
    (pp_src in ['E1', 'EB', 'EN', 'FF', 'MD', 'NW', 'PL', 'SL', 'SV', 'TN', 'VO', 'VW'])                 => -0.0327862508,
    (pp_src in ['', 'CY', 'E2', 'E4', 'EM', 'EQ', 'FA', 'KW', 'LA', 'LP', 'UT', 'UW', 'YE', 'ZK', 'ZT']) => final_score_93_c632,
    pp_src = ''                                                                                        => 0.0037927864,
                                                                                                            0.0037927864);

final_score_93_c630 := map(
    NULL < (integer)_phone_match_code_t AND (integer)_phone_match_code_t <= 0.5 => -0.0237544057,
    (integer)_phone_match_code_t > 0.5                                 => final_score_93_c631,
    (integer)_phone_match_code_t = NULL                                => 0.0014647743,
                                                                 0.0014647743);

final_score_93_c629 := map(
    NULL < f_curraddrcrimeindex_i AND f_curraddrcrimeindex_i <= 193.5 => final_score_93_c630,
    f_curraddrcrimeindex_i > 193.5                                    => 0.0445192106,
    f_curraddrcrimeindex_i = NULL                                     => 0.0028275518,
                                                                         0.0028275518);

final_score_93 := map(
    (phone_subject_title in ['Associate By Business', 'Associate By Property', 'Brother', 'Child', 'Grandchild', 'Granddaughter', 'Neighbor', 'Sibling'])                                                                                                                                                                                        => -0.0437365325,
    (phone_subject_title in ['Associate', 'Associate By Address', 'Associate By Shared Associates', 'Associate By SSN', 'Associate By Vehicle', 'Daughter', 'Father', 'Grandfather', 'Grandmother', 'Grandparent', 'Grandson', 'Husband', 'Mother', 'Parent', 'Relative', 'Sister', 'Son', 'Spouse', 'Subject', 'Subject at Household', 'Wife']) => final_score_93_c629,
    phone_subject_title = ''                                                                                                                                                                                                                                                                                                                   => 0.0001003852,
                                                                                                                                                                                                                                                                                                                                                    0.0001003852);

final_score_94_c636 := map(
    NULL < f_rel_homeover200_count_d AND f_rel_homeover200_count_d <= 36.5 => 0.0036408814,
    f_rel_homeover200_count_d > 36.5                                       => -0.1276526013,
    f_rel_homeover200_count_d = NULL                                       => 0.0031362254,
                                                                              0.0031362254);

final_score_94_c635 := map(
    NULL < f_inq_lnames_per_addr_i AND f_inq_lnames_per_addr_i <= 8.5 => final_score_94_c636,
    f_inq_lnames_per_addr_i > 8.5                                     => 0.0988088938,
    f_inq_lnames_per_addr_i = NULL                                    => 0.0040649696,
                                                                         0.0040649696);

final_score_94_c637 := map(
    (phone_subject_title in ['Associate', 'Associate By Vehicle', 'Grandmother', 'Mother', 'Spouse', 'Subject at Household', 'Wife'])                                                                                                                                                                                                                                => -0.1151722723,
    (phone_subject_title in ['Associate By Address', 'Associate By Business', 'Associate By Property', 'Associate By Shared Associates', 'Associate By SSN', 'Brother', 'Child', 'Daughter', 'Father', 'Grandchild', 'Granddaughter', 'Grandfather', 'Grandparent', 'Grandson', 'Husband', 'Neighbor', 'Parent', 'Relative', 'Sibling', 'Sister', 'Son', 'Subject']) => 0.0198028804,
    phone_subject_title = ''                                                                                                                                                                                                                                                                                                                                       => -0.0003471515,
                                                                                                                                                                                                                                                                                                                                                                        -0.0003471515);

final_score_94_c634 := map(
    NULL < r_s65_ssn_deceased_i AND r_s65_ssn_deceased_i <= 0.5 => final_score_94_c635,
    r_s65_ssn_deceased_i > 0.5                                  => -0.0834863561,
    r_s65_ssn_deceased_i = NULL                                 => final_score_94_c637,
                                                                   0.0029179823);

final_score_94 := map(
    (phone_subject_title in ['Associate By Business', 'Associate By Shared Associates', 'Associate By SSN', 'Brother', 'Child', 'Grandchild', 'Granddaughter', 'Grandfather', 'Grandson', 'Neighbor', 'Parent', 'Relative', 'Sibling'])                            => -0.0206645203,
    (phone_subject_title in ['Associate', 'Associate By Address', 'Associate By Property', 'Associate By Vehicle', 'Daughter', 'Father', 'Grandmother', 'Grandparent', 'Husband', 'Mother', 'Sister', 'Son', 'Spouse', 'Subject', 'Subject at Household', 'Wife']) => final_score_94_c634,
    phone_subject_title = ''                                                                                                                                                                                                                                     => -0.0006557345,
                                                                                                                                                                                                                                                                      -0.0006557345);

final_score_95_c640 := map(
    NULL < _mod_disc_noexp_lgt AND _mod_disc_noexp_lgt <= 5.34023737540031 => 0.0421410508,
    _mod_disc_noexp_lgt > 5.34023737540031                                 => -0.0050170503,
    _mod_disc_noexp_lgt = NULL                                             => 0.0266001522,
                                                                              0.0266001522);

final_score_95_c639 := map(
    (pp_app_coctype in ['', 'PMC'])           => 0.0007211648,
    (pp_app_coctype in ['EOC', 'RCC', 'SP2']) => final_score_95_c640,
    pp_app_coctype = ''                     => 0.0069857870,
                                                 0.0069857870);

final_score_95_c642 := map(
    (phone_subject_title in ['Associate', 'Associate By Address', 'Associate By Business', 'Associate By Property', 'Associate By Shared Associates', 'Associate By SSN', 'Child', 'Father', 'Grandmother', 'Grandparent', 'Grandson', 'Husband', 'Neighbor', 'Sister', 'Son', 'Spouse', 'Subject', 'Subject at Household']) => -0.0256717004,
    (phone_subject_title in ['Associate By Vehicle', 'Brother', 'Daughter', 'Grandchild', 'Granddaughter', 'Grandfather', 'Mother', 'Parent', 'Relative', 'Sibling', 'Wife'])                                                                                                                                                => 0.0378835966,
    phone_subject_title = ''                                                                                                                                                                                                                                                                                               => -0.0204344994,
                                                                                                                                                                                                                                                                                                                                -0.0204344994);

final_score_95_c641 := map(
    NULL < (integer)inq_adl_lastseen_n AND (integer)inq_adl_lastseen_n <= 36.5 => 0.0042679024,
    (integer)inq_adl_lastseen_n > 36.5                                => -0.0595495077,
    (integer)inq_adl_lastseen_n = NULL                                => final_score_95_c642,
                                                                -0.0094137802);

final_score_95 := map(
    NULL < f_inq_per_ssn_i AND f_inq_per_ssn_i <= 0.5 => final_score_95_c639,
    f_inq_per_ssn_i > 0.5                             => final_score_95_c641,
    f_inq_per_ssn_i = NULL                            => -0.0006046822,
                                                         -0.0006046822);

final_score_96_c647 := map(
    NULL < f_add_input_nhood_mfd_pct_i AND f_add_input_nhood_mfd_pct_i <= 0.527169873356779 => 0.0278260546,
    f_add_input_nhood_mfd_pct_i > 0.527169873356779                                         => 0.1321375981,
    f_add_input_nhood_mfd_pct_i = NULL                                                      => -0.0397315664,
                                                                                               0.0347991554);

final_score_96_c646 := map(
    NULL < (integer)inq_firstseen_n AND (integer)inq_firstseen_n <= 76.5 => 0.0466782140,
    (integer)inq_firstseen_n > 76.5                             => -0.1143104774,
    (integer)inq_firstseen_n = NULL                             => final_score_96_c647,
                                                          0.0343869380);

final_score_96_c645 := map(
    (phone_subject_title in ['Associate By Address', 'Associate By Business', 'Associate By Shared Associates', 'Associate By SSN', 'Associate By Vehicle', 'Father', 'Granddaughter', 'Grandson', 'Mother', 'Neighbor', 'Relative', 'Sister', 'Son', 'Spouse', 'Subject', 'Subject at Household']) => 0.0039123329,
    (phone_subject_title in ['Associate', 'Associate By Property', 'Brother', 'Child', 'Daughter', 'Grandchild', 'Grandfather', 'Grandmother', 'Grandparent', 'Husband', 'Parent', 'Sibling', 'Wife'])                                                                                              => final_score_96_c646,
    phone_subject_title = ''                                                                                                                                                                                                                                                                      => 0.0061777290,
                                                                                                                                                                                                                                                                                                       0.0061777290);

final_score_96_c644 := map(
    NULL < pp_did_score AND pp_did_score <= 98.5 => final_score_96_c645,
    pp_did_score > 98.5                          => -0.0201324412,
    pp_did_score = NULL                          => 0.0019257886,
                                                    0.0019257886);

final_score_96 := map(
    NULL < f_varrisktype_i AND f_varrisktype_i <= 3.5 => final_score_96_c644,
    f_varrisktype_i > 3.5                             => -0.0430392112,
    f_varrisktype_i = NULL                            => -0.0003437992,
                                                         -0.0003437992);

final_score_97_c649 := map(
    NULL < f_addrchangevaluediff_d AND f_addrchangevaluediff_d <= -10742 => -0.0713984126,
    f_addrchangevaluediff_d > -10742                                     => 0.0988530571,
    f_addrchangevaluediff_d = NULL                                       => 0.0768028943,
                                                                            0.0595654303);

final_score_97_c650 := map(
    NULL < r_a44_curr_add_naprop_d AND r_a44_curr_add_naprop_d <= 1.5 => 0.0156749693,
    r_a44_curr_add_naprop_d > 1.5                                     => -0.0684535591,
    r_a44_curr_add_naprop_d = NULL                                    => -0.0016818354,
                                                                         -0.0016818354);

final_score_97_c652 := map(
    (pp_app_scc in ['', '8', 'A', 'B', 'C', 'O', 'R', 'V']) => -0.0044669023,
    (pp_app_scc in ['J', 'M', 'N', 'S'])                    => 0.0163873488,
    pp_app_scc = ''                                       => 0.0011579973,
                                                               0.0011579973);

final_score_97_c651 := map(
    NULL < f_mos_liens_unrel_cj_lseen_d AND f_mos_liens_unrel_cj_lseen_d <= 10.5 => -0.0423068767,
    f_mos_liens_unrel_cj_lseen_d > 10.5                                          => final_score_97_c652,
    f_mos_liens_unrel_cj_lseen_d = NULL                                          => -0.0003776315,
                                                                                    -0.0003776315);

final_score_97 := map(
    NULL < mth_source_rm_fseen AND mth_source_rm_fseen <= 6.5 => final_score_97_c649,
    mth_source_rm_fseen > 6.5                                 => final_score_97_c650,
    mth_source_rm_fseen = NULL                                => final_score_97_c651,
                                                                 0.0005371559);

final_score_98_c657 := map(
    NULL < f_addrchangecrimediff_i AND f_addrchangecrimediff_i <= 32.5 => -0.0019057737,
    f_addrchangecrimediff_i > 32.5                                     => 0.1359007811,
    f_addrchangecrimediff_i = NULL                                     => 0.0810586837,
                                                                          0.0577431496);

final_score_98_c656 := map(
    (phone_subject_title in ['Associate By Address', 'Associate By Business', 'Associate By SSN', 'Child', 'Daughter', 'Granddaughter', 'Grandmother', 'Grandparent', 'Neighbor', 'Parent', 'Relative', 'Sibling', 'Son', 'Spouse', 'Subject', 'Subject at Household', 'Wife']) => -0.0135270590,
    (phone_subject_title in ['Associate', 'Associate By Property', 'Associate By Shared Associates', 'Associate By Vehicle', 'Brother', 'Father', 'Grandchild', 'Grandfather', 'Grandson', 'Husband', 'Mother', 'Sister'])                                                      => final_score_98_c657,
    phone_subject_title = ''                                                                                                                                                                                                                                                  => 0.0039889595,
                                                                                                                                                                                                                                                                                   0.0039889595);

final_score_98_c655 := map(
    NULL < mth_phone_fb_rp_date AND mth_phone_fb_rp_date <= 50.5 => final_score_98_c656,
    mth_phone_fb_rp_date > 50.5                                  => -0.0691081225,
    mth_phone_fb_rp_date = NULL                                  => -0.0010685556,
                                                                    -0.0014645493);

final_score_98_c654 := map(
    NULL < _pp_src_all_uw AND _pp_src_all_uw <= 0.5 => final_score_98_c655,
    _pp_src_all_uw > 0.5                            => 0.0353156161,
    _pp_src_all_uw = NULL                           => 0.0007979910,
                                                       0.0007979910);

final_score_98 := map(
    NULL < r_d31_mostrec_bk_i AND r_d31_mostrec_bk_i <= 2.5 => final_score_98_c654,
    r_d31_mostrec_bk_i > 2.5                                => 0.0611491823,
    r_d31_mostrec_bk_i = NULL                               => 0.0021192898,
                                                               0.0021192898);

final_score_99_c660 := map(
    (eda_pfrd_address_ind in ['1A', '1B', '1E', 'XX']) => -0.0048973462,
    (eda_pfrd_address_ind in ['1C', '1D'])             => 0.0306338754,
    eda_pfrd_address_ind = ''                        => -0.0031259176,
                                                          -0.0031259176);

final_score_99_c659 := map(
    NULL < _pp_src_all_uw AND _pp_src_all_uw <= 0.5 => final_score_99_c660,
    _pp_src_all_uw > 0.5                            => 0.0310460348,
    _pp_src_all_uw = NULL                           => -0.0010600405,
                                                       -0.0010600405);

final_score_99_c662 := map(
    NULL < f_estimated_income_d AND f_estimated_income_d <= 98500 => -0.0632334762,
    f_estimated_income_d > 98500                                  => 0.0521962663,
    f_estimated_income_d = NULL                                   => -0.0524471050,
                                                                     -0.0524471050);

final_score_99_c661 := map(
    NULL < f_srchaddrsrchcount_i AND f_srchaddrsrchcount_i <= 20.5 => final_score_99_c662,
    f_srchaddrsrchcount_i > 20.5                                   => 0.0473161851,
    f_srchaddrsrchcount_i = NULL                                   => -0.0363316009,
                                                                      -0.0363316009);

final_score_99 := map(
    NULL < pp_app_ind_ph_cnt AND pp_app_ind_ph_cnt <= 8.5 => final_score_99_c659,
    pp_app_ind_ph_cnt > 8.5                               => final_score_99_c661,
    pp_app_ind_ph_cnt = NULL                              => -0.0036882731,
                                                             -0.0036882731);

final_score_100_c664 := map(
    NULL < r_l80_inp_avm_autoval_d AND r_l80_inp_avm_autoval_d <= 101343.5 => 0.0507715523,
    r_l80_inp_avm_autoval_d > 101343.5                                     => -0.0893111117,
    r_l80_inp_avm_autoval_d = NULL                                         => -0.0761053001,
                                                                              -0.0515789643);

final_score_100_c667 := map(
    NULL < (integer)inq_lastseen_n AND (integer)inq_lastseen_n <= 18.5 => 0.0086350315,
    (integer)inq_lastseen_n > 18.5                            => -0.0749814114,
    (integer)inq_lastseen_n = NULL                            => -0.0212965050,
                                                        -0.0182812063);

final_score_100_c666 := map(
    NULL < f_varrisktype_i AND f_varrisktype_i <= 1.5 => 0.0154158320,
    f_varrisktype_i > 1.5                             => final_score_100_c667,
    f_varrisktype_i = NULL                            => 0.0064092737,
                                                         0.0064092737);

final_score_100_c665 := map(
    NULL < mth_source_ppdid_lseen AND mth_source_ppdid_lseen <= 80.5 => final_score_100_c666,
    mth_source_ppdid_lseen > 80.5                                    => -0.0523782519,
    mth_source_ppdid_lseen = NULL                                    => 0.0026119483,
                                                                        0.0028663048);

final_score_100 := map(
    NULL < r_d32_mos_since_fel_ls_d AND r_d32_mos_since_fel_ls_d <= 121.5 => final_score_100_c664,
    r_d32_mos_since_fel_ls_d > 121.5                                      => final_score_100_c665,
    r_d32_mos_since_fel_ls_d = NULL                                       => 0.0013397151,
                                                                             0.0013397151);

final_score_101_c671 := map(
    NULL < f_add_input_nhood_bus_pct_i AND f_add_input_nhood_bus_pct_i <= 0.101327664005554 => -0.0250388267,
    f_add_input_nhood_bus_pct_i > 0.101327664005554                                         => -0.1258942417,
    f_add_input_nhood_bus_pct_i = NULL                                                      => -0.0405105952,
                                                                                               -0.0405105952);

final_score_101_c672 := map(
    (phone_subject_title in ['Associate By Business', 'Associate By Shared Associates', 'Associate By SSN', 'Brother', 'Daughter', 'Grandchild', 'Granddaughter', 'Grandfather', 'Grandson', 'Husband', 'Neighbor', 'Parent', 'Relative', 'Sister', 'Son', 'Subject']) => -0.0192078607,
    (phone_subject_title in ['Associate', 'Associate By Address', 'Associate By Property', 'Associate By Vehicle', 'Child', 'Father', 'Grandmother', 'Grandparent', 'Mother', 'Sibling', 'Spouse', 'Subject at Household', 'Wife'])                                    => 0.0170170765,
    phone_subject_title = ''                                                                                                                                                                                                                                         => -0.0066726177,
                                                                                                                                                                                                                                                                          -0.0066726177);

final_score_101_c670 := map(
    NULL < (integer)inq_lastseen_n AND (integer)inq_lastseen_n <= 5.5 => final_score_101_c671,
    (integer)inq_lastseen_n > 5.5                            => final_score_101_c672,
    (integer)inq_lastseen_n = NULL                           => -0.0057131232,
                                                       -0.0082778402);

final_score_101_c669 := map(
    NULL < (integer)_inq_adl_ph_industry_flag AND (integer)_inq_adl_ph_industry_flag <= 0.5 => final_score_101_c670,
    (integer)_inq_adl_ph_industry_flag > 0.5                                       => 0.0465604725,
    (integer)_inq_adl_ph_industry_flag = NULL                                      => -0.0039182693,
                                                                             -0.0039182693);

final_score_101 := map(
    NULL < f_inq_count_i AND f_inq_count_i <= 3.5 => 0.0145123173,
    f_inq_count_i > 3.5                           => final_score_101_c669,
    f_inq_count_i = NULL                          => 0.0002173714,
                                                     0.0002173714);

final_score_102_c677 := map(
    NULL < f_add_input_nhood_mfd_pct_i AND f_add_input_nhood_mfd_pct_i <= 0.00805679513184584 => -0.0962438809,
    f_add_input_nhood_mfd_pct_i > 0.00805679513184584                                         => 0.0316585710,
    f_add_input_nhood_mfd_pct_i = NULL                                                        => 0.0347457556,
                                                                                                 0.0211379911);

final_score_102_c676 := map(
    NULL < f_curraddrburglaryindex_i AND f_curraddrburglaryindex_i <= 160.5 => -0.0140798555,
    f_curraddrburglaryindex_i > 160.5                                       => final_score_102_c677,
    f_curraddrburglaryindex_i = NULL                                        => -0.0035760371,
                                                                               -0.0035760371);

final_score_102_c675 := map(
    NULL < eda_days_ph_first_seen AND eda_days_ph_first_seen <= 576 => 0.0758904430,
    eda_days_ph_first_seen > 576                                    => final_score_102_c676,
    eda_days_ph_first_seen = NULL                                   => 0.0011492637,
                                                                       0.0011492637);

final_score_102_c674 := map(
    NULL < mth_pp_first_build_date AND mth_pp_first_build_date <= 21.5 => 0.0038844771,
    mth_pp_first_build_date > 21.5                                     => -0.0385122550,
    mth_pp_first_build_date = NULL                                     => final_score_102_c675,
                                                                          -0.0016825477);

final_score_102 := map(
    NULL < r_a49_curr_avm_chg_1yr_i AND r_a49_curr_avm_chg_1yr_i <= 190062.5 => 0.0083020162,
    r_a49_curr_avm_chg_1yr_i > 190062.5                                      => -0.1294852221,
    r_a49_curr_avm_chg_1yr_i = NULL                                          => final_score_102_c674,
                                                                                0.0018676192);

final_score_103_c681 := map(
    NULL < f_inq_count_i AND f_inq_count_i <= 5.5 => 0.0092021882,
    f_inq_count_i > 5.5                           => -0.0065296453,
    f_inq_count_i = NULL                          => -0.0010888562,
                                                     -0.0010888562);

final_score_103_c680 := map(
    NULL < mth_source_paw_lseen AND mth_source_paw_lseen <= 23.5 => 0.0710822187,
    mth_source_paw_lseen > 23.5                                  => -0.0161037744,
    mth_source_paw_lseen = NULL                                  => final_score_103_c681,
                                                                    -0.0003700389);

final_score_103_c679 := map(
    NULL < eda_did_count AND eda_did_count <= 1.5 => final_score_103_c680,
    eda_did_count > 1.5                           => -0.0627049127,
    eda_did_count = NULL                          => -0.0017135987,
                                                     -0.0017135987);

final_score_103_c682 := map(
    NULL < (integer)_phone_match_code_lns AND (integer)_phone_match_code_lns <= 0.5 => 0.0141871776,
    (integer)_phone_match_code_lns > 0.5                                   => 0.1147295728,
    (integer)_phone_match_code_lns = NULL                                  => 0.0281997369,
                                                                     0.0281997369);

final_score_103 := map(
    (phone_subject_title in ['Associate', 'Associate By Address', 'Associate By Business', 'Associate By Shared Associates', 'Associate By SSN', 'Grandchild', 'Granddaughter', 'Grandfather', 'Grandmother', 'Grandson', 'Mother', 'Neighbor', 'Parent', 'Relative', 'Sibling', 'Sister', 'Subject', 'Subject at Household']) => final_score_103_c679,
    (phone_subject_title in ['Associate By Property', 'Associate By Vehicle', 'Brother', 'Child', 'Daughter', 'Father', 'Grandparent', 'Husband', 'Son', 'Spouse', 'Wife'])                                                                                                                                                    => final_score_103_c682,
    phone_subject_title = ''                                                                                                                                                                                                                                                                                                 => -0.0001936399,
                                                                                                                                                                                                                                                                                                                                  -0.0001936399);

final_score_104_c686 := map(
    (phone_subject_title in ['Associate By Address', 'Associate By Business', 'Associate By Shared Associates', 'Associate By SSN', 'Child', 'Father', 'Granddaughter', 'Grandparent', 'Husband', 'Mother', 'Neighbor', 'Son', 'Spouse', 'Subject', 'Subject at Household', 'Wife']) => 0.0077065677,
    (phone_subject_title in ['Associate', 'Associate By Property', 'Associate By Vehicle', 'Brother', 'Daughter', 'Grandchild', 'Grandfather', 'Grandmother', 'Grandson', 'Parent', 'Relative', 'Sibling', 'Sister'])                                                                => 0.1280746407,
    phone_subject_title = ''                                                                                                                                                                                                                                                       => 0.0231929565,
                                                                                                                                                                                                                                                                                        0.0231929565);

final_score_104_c685 := map(
    NULL < f_prevaddrcartheftindex_i AND f_prevaddrcartheftindex_i <= 32 => final_score_104_c686,
    f_prevaddrcartheftindex_i > 32                                       => -0.0227842627,
    f_prevaddrcartheftindex_i = NULL                                     => -0.0153319247,
                                                                            -0.0153319247);

final_score_104_c687 := map(
    NULL < mth_source_rm_fseen AND mth_source_rm_fseen <= 59.5 => 0.0276768157,
    mth_source_rm_fseen > 59.5                                 => -0.0523270634,
    mth_source_rm_fseen = NULL                                 => 0.0018111903,
                                                                  0.0027903585);

final_score_104_c684 := map(
    NULL < f_mos_inq_banko_cm_fseen_d AND f_mos_inq_banko_cm_fseen_d <= 64.5 => final_score_104_c685,
    f_mos_inq_banko_cm_fseen_d > 64.5                                        => final_score_104_c687,
    f_mos_inq_banko_cm_fseen_d = NULL                                        => -0.0017414555,
                                                                                -0.0017414555);

final_score_104 := map(
    (pp_origlistingtype in ['', 'R', 'RB']) => final_score_104_c684,
    (pp_origlistingtype in ['B', 'BG'])     => 0.1146197193,
    pp_origlistingtype = ''               => -0.0008817812,
                                               -0.0008817812);

final_score_105_c690 := map(
    (phone_subject_title in ['Associate', 'Associate By Business', 'Associate By Property', 'Associate By Shared Associates', 'Associate By SSN', 'Associate By Vehicle', 'Brother', 'Child', 'Father', 'Grandson', 'Husband', 'Neighbor', 'Sibling', 'Sister', 'Son', 'Spouse', 'Subject', 'Wife']) => 0.0039890841,
    (phone_subject_title in ['Associate By Address', 'Daughter', 'Grandchild', 'Granddaughter', 'Grandfather', 'Grandmother', 'Grandparent', 'Mother', 'Parent', 'Relative', 'Subject at Household'])                                                                                                => 0.0764169784,
    phone_subject_title = ''                                                                                                                                                                                                                                                                       => 0.0340901585,
                                                                                                                                                                                                                                                                                                        0.0340901585);

final_score_105_c692 := map(
    NULL < mth_source_rm_fseen AND mth_source_rm_fseen <= 17.5 => 0.0532556000,
    mth_source_rm_fseen > 17.5                                 => -0.0152948663,
    mth_source_rm_fseen = NULL                                 => -0.0040175120,
                                                                  0.0017187400);

final_score_105_c691 := map(
    NULL < mth_pp_app_npa_last_change_dt AND mth_pp_app_npa_last_change_dt <= 66.5 => 0.0297655732,
    mth_pp_app_npa_last_change_dt > 66.5                                           => -0.0185380693,
    mth_pp_app_npa_last_change_dt = NULL                                           => final_score_105_c692,
                                                                                      -0.0026642935);

final_score_105_c689 := map(
    NULL < f_addrchangeincomediff_d AND f_addrchangeincomediff_d <= 48721 => 0.0008190958,
    f_addrchangeincomediff_d > 48721                                      => final_score_105_c690,
    f_addrchangeincomediff_d = NULL                                       => final_score_105_c691,
                                                                             0.0008606487);

final_score_105 := map(
    NULL < mth_source_paw_lseen AND mth_source_paw_lseen <= 147.5 => 0.0302126108,
    mth_source_paw_lseen > 147.5                                  => -0.1287470609,
    mth_source_paw_lseen = NULL                                   => final_score_105_c689,
                                                                     0.0013661340);

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
    final_score_105;

phat := exp(final_score) / (1 + exp(final_score));

wf83 := round(1000 * phat);

//Intermediate variables
	#if(PHONE_DEBUG)
   self.sysdate                          := sysdate;
   self.phone_pos_cr                     := phone_pos_cr;
   self.phone_pos_edaca                  := phone_pos_edaca;
   self.phone_pos_edadid                 := phone_pos_edadid;
   self.phone_pos_edafa                  := phone_pos_edafa;
   self.phone_pos_edafla                 := phone_pos_edafla;
   self.phone_pos_edahistory             := phone_pos_edahistory;
   self.phone_pos_edala                  := phone_pos_edala;
   self.phone_pos_edalfa                 := phone_pos_edalfa;
   self.phone_pos_exp                    := phone_pos_exp;
   self.phone_pos_inf                    := phone_pos_inf;
   self.phone_pos_input                  := phone_pos_input;
   self.phone_pos_md                     := phone_pos_md;
   self.phone_pos_ne                     := phone_pos_ne;
   self.phone_pos_paw                    := phone_pos_paw;
   self.phone_pos_pde                    := phone_pos_pde;
   self.phone_pos_pf                     := phone_pos_pf;
   self.phone_pos_pffla                  := phone_pos_pffla;
   self.phone_pos_pfla                   := phone_pos_pfla;
   self.phone_pos_ppca                   := phone_pos_ppca;
   self.phone_pos_ppdid                  := phone_pos_ppdid;
   self.phone_pos_ppfa                   := phone_pos_ppfa;
   self.phone_pos_ppfla                  := phone_pos_ppfla;
   self.phone_pos_ppla                   := phone_pos_ppla;
   self.phone_pos_pplfa                  := phone_pos_pplfa;
   self.phone_pos_ppth                   := phone_pos_ppth;
   self.phone_pos_rel                    := phone_pos_rel;
   self.phone_pos_rm                     := phone_pos_rm;
   self.phone_pos_sp                     := phone_pos_sp;
   self.phone_pos_sx                     := phone_pos_sx;
   self.phone_pos_utildid                := phone_pos_utildid;
   self.source_cr                        := source_cr;
   self.source_edaca                     := source_edaca;
   self.source_edadid                    := source_edadid;
   self.source_edafa                     := source_edafa;
   self.source_edafla                    := source_edafla;
   self.source_edahistory                := source_edahistory;
   self.source_edala                     := source_edala;
   self.source_edalfa                    := source_edalfa;
   self.source_exp                       := source_exp;
   self.source_inf                       := source_inf;
   self.source_input                     := source_input;
   self.source_md                        := source_md;
   self.source_ne                        := source_ne;
   self.source_paw                       := source_paw;
   self.source_pde                       := source_pde;
   self.source_pf                        := source_pf;
   self.source_pffla                     := source_pffla;
   self.source_pfla                      := source_pfla;
   self.source_ppca                      := source_ppca;
   self.source_ppdid                     := source_ppdid;
   self.source_ppfa                      := source_ppfa;
   self.source_ppfla                     := source_ppfla;
   self.source_ppla                      := source_ppla;
   self.source_pplfa                     := source_pplfa;
   self.source_ppth                      := source_ppth;
   self.source_rel                       := source_rel;
   self.source_rm                        := source_rm;
   self.source_sp                        := source_sp;
   self.source_sx                        := source_sx;
   self.source_utildid                   := source_utildid;
   self.source_edaca_lseen               := source_edaca_lseen;
   self.source_edaca_fseen               := source_edaca_fseen;
   self.source_edahistory_lseen          := source_edahistory_lseen;
   self.source_inf_fseen                 := source_inf_fseen;
   self.source_md_fseen                  := source_md_fseen;
   self.source_paw_lseen                 := source_paw_lseen;
   self.source_paw_fseen                 := source_paw_fseen;
   self.source_ppca_lseen                := source_ppca_lseen;
   self.source_ppca_fseen                := source_ppca_fseen;
   self.source_ppdid_lseen               := source_ppdid_lseen;
   self.source_ppdid_fseen               := source_ppdid_fseen;
   self.source_ppfla_lseen               := source_ppfla_lseen;
   self.source_ppfla_fseen               := source_ppfla_fseen;
   self.source_ppla_lseen                := source_ppla_lseen;
   self.source_ppla_fseen                := source_ppla_fseen;
   self.source_ppth_lseen                := source_ppth_lseen;
   self.source_ppth_fseen                := source_ppth_fseen;
   self.source_rm_fseen                  := source_rm_fseen;
   self.source_sx_fseen                  := source_sx_fseen;
   self.source_utildid_fseen             := source_utildid_fseen;
   self.source_pp_any_clean              := source_pp_any_clean;
   self.number_of_sources                := number_of_sources;
   self.source_edaca_lseen2              := source_edaca_lseen2;
   self.mth_source_edaca_lseen           := mth_source_edaca_lseen;
   self.source_edaca_fseen2              := source_edaca_fseen2;
   self.mth_source_edaca_fseen           := mth_source_edaca_fseen;
   self.source_edahistory_lseen2         := source_edahistory_lseen2;
   self.mth_source_edahistory_lseen      := mth_source_edahistory_lseen;
   self.source_inf_fseen2                := source_inf_fseen2;
   self.mth_source_inf_fseen             := mth_source_inf_fseen;
   self.source_md_fseen2                 := source_md_fseen2;
   self.mth_source_md_fseen              := mth_source_md_fseen;
   self.source_paw_lseen2                := source_paw_lseen2;
   self.mth_source_paw_lseen             := mth_source_paw_lseen;
   self.source_paw_fseen2                := source_paw_fseen2;
   self.mth_source_paw_fseen             := mth_source_paw_fseen;
   self.source_ppca_lseen2               := source_ppca_lseen2;
   self.mth_source_ppca_lseen            := mth_source_ppca_lseen;
   self.source_ppca_fseen2               := source_ppca_fseen2;
   self.mth_source_ppca_fseen            := mth_source_ppca_fseen;
   self.source_ppdid_lseen2              := source_ppdid_lseen2;
   self.mth_source_ppdid_lseen           := mth_source_ppdid_lseen;
   self.source_ppdid_fseen2              := source_ppdid_fseen2;
   self.mth_source_ppdid_fseen           := mth_source_ppdid_fseen;
   self.source_ppfla_lseen2              := source_ppfla_lseen2;
   self.mth_source_ppfla_lseen           := mth_source_ppfla_lseen;
   self.source_ppfla_fseen2              := source_ppfla_fseen2;
   self.mth_source_ppfla_fseen           := mth_source_ppfla_fseen;
   self.source_ppla_lseen2               := source_ppla_lseen2;
   self.mth_source_ppla_lseen            := mth_source_ppla_lseen;
   self.source_ppla_fseen2               := source_ppla_fseen2;
   self.mth_source_ppla_fseen            := mth_source_ppla_fseen;
   self.source_ppth_lseen2               := source_ppth_lseen2;
   self.mth_source_ppth_lseen            := mth_source_ppth_lseen;
   self.source_ppth_fseen2               := source_ppth_fseen2;
   self.mth_source_ppth_fseen            := mth_source_ppth_fseen;
   self.source_rm_fseen2                 := source_rm_fseen2;
   self.mth_source_rm_fseen              := mth_source_rm_fseen;
   self.source_sx_fseen2                 := source_sx_fseen2;
   self.mth_source_sx_fseen              := mth_source_sx_fseen;
   self.source_utildid_fseen2            := source_utildid_fseen2;
   self.mth_source_utildid_fseen         := mth_source_utildid_fseen;
   self.eda_dt_first_seen2               := eda_dt_first_seen2;
   self.mth_eda_dt_first_seen            := mth_eda_dt_first_seen;
   self.eda_dt_last_seen2                := eda_dt_last_seen2;
   self.mth_eda_dt_last_seen             := mth_eda_dt_last_seen;
   self.eda_deletion_date2               := eda_deletion_date2;
   self.mth_eda_deletion_date            := mth_eda_deletion_date;
   self.exp_last_update2                 := exp_last_update2;
   self.mth_exp_last_update              := mth_exp_last_update;
   self.internal_ver_first_seen2         := internal_ver_first_seen2;
   self.mth_internal_ver_first_seen      := mth_internal_ver_first_seen;
   self.internal_ver_last_seen2          := internal_ver_last_seen2;
   self.mth_internal_ver_last_seen       := mth_internal_ver_last_seen;
   self.phone_fb_rp_date2                := phone_fb_rp_date2;
   self.mth_phone_fb_rp_date             := mth_phone_fb_rp_date;
   self.pp_datefirstseen2                := pp_datefirstseen2;
   self.mth_pp_datefirstseen             := mth_pp_datefirstseen;
   self.pp_datelastseen2                 := pp_datelastseen2;
   self.mth_pp_datelastseen              := mth_pp_datelastseen;
   self.pp_datevendorfirstseen2          := pp_datevendorfirstseen2;
   self.mth_pp_datevendorfirstseen       := mth_pp_datevendorfirstseen;
   self.pp_orig_lastseen2                := pp_orig_lastseen2;
   self.mth_pp_orig_lastseen             := mth_pp_orig_lastseen;
   self.pp_app_npa_effective_dt2         := pp_app_npa_effective_dt2;
   self.mth_pp_app_npa_effective_dt      := mth_pp_app_npa_effective_dt;
   self.pp_app_npa_last_change_dt2       := pp_app_npa_last_change_dt2;
   self.mth_pp_app_npa_last_change_dt    := mth_pp_app_npa_last_change_dt;
   self.pp_eda_hist_ph_dt2               := pp_eda_hist_ph_dt2;
   self.mth_pp_eda_hist_ph_dt            := mth_pp_eda_hist_ph_dt;
   self.pp_eda_hist_did_dt2              := pp_eda_hist_did_dt2;
   self.mth_pp_eda_hist_did_dt           := mth_pp_eda_hist_did_dt;
   self.pp_eda_hist_nm_addr_dt2          := pp_eda_hist_nm_addr_dt2;
   self.mth_pp_eda_hist_nm_addr_dt       := mth_pp_eda_hist_nm_addr_dt;
   self.pp_first_build_date2             := pp_first_build_date2;
   self.mth_pp_first_build_date          := mth_pp_first_build_date;
   self._phone_match_code_a              := _phone_match_code_a;
   self._phone_match_code_c              := _phone_match_code_c;
   self._phone_match_code_l              := _phone_match_code_l;
   self._phone_match_code_n              := _phone_match_code_n;
   self._phone_match_code_s              := _phone_match_code_s;
   self._phone_match_code_t              := _phone_match_code_t;
   self._phone_match_code_z              := _phone_match_code_z;
   self._pp_rule_disconnected_eda        := _pp_rule_disconnected_eda;
   self._pp_rule_non_pub                 := _pp_rule_non_pub;
   self._pp_rule_port_neustar            := _pp_rule_port_neustar;
   self._pp_rule_high_vend_conf          := _pp_rule_high_vend_conf;
   self._pp_rule_cellphone_latest        := _pp_rule_cellphone_latest;
   self._pp_rule_source_latest           := _pp_rule_source_latest;
   self._pp_rule_med_vend_conf_cell      := _pp_rule_med_vend_conf_cell;
   self._pp_rule_gong_disc               := _pp_rule_gong_disc;
   self._pp_rule_consort_disc            := _pp_rule_consort_disc;
   self._pp_rule_f1_ver_above            := _pp_rule_f1_ver_above;
   self._pp_src_all_uw                   := _pp_src_all_uw;
   self._pp_srule_port_neustar           := _pp_srule_port_neustar;
   self.inq_firstseen_n                  := inq_firstseen_n;
   self.inq_lastseen_n                   := inq_lastseen_n;
   self.inq_adl_firstseen_n              := inq_adl_firstseen_n;
   self.inq_adl_lastseen_n               := inq_adl_lastseen_n;
   self.internal_ver_match_type          := internal_ver_match_type;
   self._internal_ver_match_hhid         := _internal_ver_match_hhid;
   self._inq_adl_ph_industry_flag        := _inq_adl_ph_industry_flag;
   self._phone_disconnected              := _phone_disconnected;
   self._phone_zip_match                 := _phone_zip_match;
   self._phone_timezone_match            := _phone_timezone_match;
   self._phone_fb_rp_result              := _phone_fb_rp_result;
   self._pp_app_fb_ph_disc               := _pp_app_fb_ph_disc;
   self._pp_app_fb_ph7_did_disc          := _pp_app_fb_ph7_did_disc;
   self._pp_app_fb_ph7_nm_addr_disc      := _pp_app_fb_ph7_nm_addr_disc;
   self._phone_fb_result_disc            := _phone_fb_result_disc;
   self._phone_fb_rp_result_disc         := _phone_fb_rp_result_disc;
   self._pp_rule_disc_flag               := _pp_rule_disc_flag;
   self._pp_app_fb_disc_flag             := _pp_app_fb_disc_flag;
   self._phone_fb_disc_flag              := _phone_fb_disc_flag;
   self.pk_disconnect_flag               := pk_disconnect_flag;
   self._phone_match_code_lns            := _phone_match_code_lns;
   self._phone_match_code_tcza           := _phone_match_code_tcza;
   self.pk_phone_match_level             := pk_phone_match_level;
   self._pp_app_coctype_landline         := _pp_app_coctype_landline;
   self._pp_app_coctype_cell             := _pp_app_coctype_cell;
   self._phone_switch_type_cell          := _phone_switch_type_cell;
   self._pp_app_nxx_type_cell            := _pp_app_nxx_type_cell;
   self._pp_app_ph_type_cell             := _pp_app_ph_type_cell;
   self._pp_app_company_type_cell        := _pp_app_company_type_cell;
   self._exp_type_cell                   := _exp_type_cell;
   self.pk_cell_indicator                := pk_cell_indicator;
   self.add_input_pop                    := add_input_pop;
   self.add_curr_pop                     := add_curr_pop;
   self.add_curr_naprop                  := add_curr_naprop;
   self.add_input_avm_auto_val           := add_input_avm_auto_val;
   self.add_curr_avm_auto_val            := add_curr_avm_auto_val;
   self.add_curr_lres                    := add_curr_lres;
   self.add_curr_avm_auto_val_2          := add_curr_avm_auto_val_2;
   self.add_input_naprop                 := add_input_naprop;
   self.add_prev_naprop                  := add_prev_naprop;
   self.add_input_occupants_1yr          := add_input_occupants_1yr;
   self.add_input_turnover_1yr_in        := add_input_turnover_1yr_in;
   self.add_input_turnover_1yr_out       := add_input_turnover_1yr_out;
   self.add_input_nhood_bus_ct           := add_input_nhood_bus_ct;
   self.add_input_nhood_sfd_ct           := add_input_nhood_sfd_ct;
   self.add_input_nhood_mfd_ct           := add_input_nhood_mfd_ct;
   self.add_curr_occupants_1yr           := add_curr_occupants_1yr;
   self.add_curr_turnover_1yr_in         := add_curr_turnover_1yr_in;
   self.add_curr_turnover_1yr_out        := add_curr_turnover_1yr_out;
   self.add_curr_nhood_bus_ct            := add_curr_nhood_bus_ct;
   self.add_curr_nhood_sfd_ct            := add_curr_nhood_sfd_ct;
   self.add_curr_nhood_mfd_ct            := add_curr_nhood_mfd_ct;
   self.add_curr_nhood_vac_prop          := add_curr_nhood_vac_prop;
   self._felony_last_date                := _felony_last_date;
   self.r_d32_mos_since_fel_ls_d         := r_d32_mos_since_fel_ls_d;
   self.r_d31_mostrec_bk_i               := r_d31_mostrec_bk_i;
   self.bureau_adl_eq_fseen_pos          := bureau_adl_eq_fseen_pos;
   self.bureau_adl_fseen_eq              := bureau_adl_fseen_eq;
   self._bureau_adl_fseen_eq             := _bureau_adl_fseen_eq;
   self._src_bureau_adl_fseen            := _src_bureau_adl_fseen;
   self.r_c21_m_bureau_adl_fs_d          := r_c21_m_bureau_adl_fs_d;
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
   self.f_m_bureau_adl_fs_all_d          := f_m_bureau_adl_fs_all_d;
   self.r_a44_curr_add_naprop_d          := r_a44_curr_add_naprop_d;
   self.r_l80_inp_avm_autoval_d          := r_l80_inp_avm_autoval_d;
   self.r_a49_curr_avm_chg_1yr_i         := r_a49_curr_avm_chg_1yr_i;
   self.r_a49_curr_avm_chg_1yr_pct_i     := r_a49_curr_avm_chg_1yr_pct_i;
   self.r_c13_max_lres_d                 := r_c13_max_lres_d;
   self.r_c14_addrs_5yr_i                := r_c14_addrs_5yr_i;
   self.r_c14_addrs_10yr_i               := r_c14_addrs_10yr_i;
   self.r_c14_addrs_15yr_i               := r_c14_addrs_15yr_i;
   self.r_a41_prop_owner_d               := r_a41_prop_owner_d;
   self.r_prop_owner_history_d           := r_prop_owner_history_d;
   self.r_c20_email_count_i              := r_c20_email_count_i;
   self.r_c18_invalid_addrs_per_adl_i    := r_c18_invalid_addrs_per_adl_i;
   self.r_i60_inq_hiriskcred_recency_d   := r_i60_inq_hiriskcred_recency_d;
   self.r_i60_inq_comm_recency_d         := r_i60_inq_comm_recency_d;
   self.f_util_adl_count_n               := f_util_adl_count_n;
   self.f_add_input_mobility_index_n     := f_add_input_mobility_index_n;
   self.add_input_nhood_prop_sum         := add_input_nhood_prop_sum;
   self.f_add_input_nhood_bus_pct_i      := f_add_input_nhood_bus_pct_i;
   self.f_add_input_nhood_mfd_pct_i      := f_add_input_nhood_mfd_pct_i;
   self.f_add_input_nhood_sfd_pct_d      := f_add_input_nhood_sfd_pct_d;
   self.f_add_curr_mobility_index_n      := f_add_curr_mobility_index_n;
   self.add_curr_nhood_prop_sum          := add_curr_nhood_prop_sum;
   self.f_add_curr_nhood_bus_pct_i       := f_add_curr_nhood_bus_pct_i;
   self.f_add_curr_nhood_mfd_pct_i       := f_add_curr_nhood_mfd_pct_i;
   self.f_add_curr_nhood_sfd_pct_d       := f_add_curr_nhood_sfd_pct_d;
   self.f_add_curr_nhood_vac_pct_i       := f_add_curr_nhood_vac_pct_i;
   self.f_inq_count_i                    := f_inq_count_i;
   self.f_inq_collection_count_i         := f_inq_collection_count_i;
   self.f_inq_communications_count_i     := f_inq_communications_count_i;
   self.f_inq_highriskcredit_count_i     := f_inq_highriskcredit_count_i;
   self.f_inq_highriskcredit_count24_i   := f_inq_highriskcredit_count24_i;
   self.f_inq_mortgage_count_i           := f_inq_mortgage_count_i;
   self.f_inq_mortgage_count24_i         := f_inq_mortgage_count24_i;
   self.f_inq_per_ssn_i                  := f_inq_per_ssn_i;
   self.f_inq_lnames_per_addr_i          := f_inq_lnames_per_addr_i;
   self._inq_banko_am_first_seen         := _inq_banko_am_first_seen;
   self.f_mos_inq_banko_am_fseen_d       := f_mos_inq_banko_am_fseen_d;
   self._inq_banko_cm_first_seen         := _inq_banko_cm_first_seen;
   self.f_mos_inq_banko_cm_fseen_d       := f_mos_inq_banko_cm_fseen_d;
   self._inq_banko_cm_last_seen          := _inq_banko_cm_last_seen;
   self.f_mos_inq_banko_cm_lseen_d       := f_mos_inq_banko_cm_lseen_d;
   self._inq_banko_om_first_seen         := _inq_banko_om_first_seen;
   self.f_mos_inq_banko_om_fseen_d       := f_mos_inq_banko_om_fseen_d;
   self._liens_unrel_cj_first_seen       := _liens_unrel_cj_first_seen;
   self.f_mos_liens_unrel_cj_fseen_d     := f_mos_liens_unrel_cj_fseen_d;
   self._liens_unrel_cj_last_seen        := _liens_unrel_cj_last_seen;
   self.f_mos_liens_unrel_cj_lseen_d     := f_mos_liens_unrel_cj_lseen_d;
   self._liens_unrel_sc_first_seen       := _liens_unrel_sc_first_seen;
   self.f_mos_liens_unrel_sc_fseen_d     := f_mos_liens_unrel_sc_fseen_d;
   self.f_estimated_income_d             := f_estimated_income_d;
   self.f_wealth_index_d                 := f_wealth_index_d;
   self.f_rel_incomeover50_count_d       := f_rel_incomeover50_count_d;
   self.f_rel_incomeover75_count_d       := f_rel_incomeover75_count_d;
   self.f_rel_homeover200_count_d        := f_rel_homeover200_count_d;
   self.f_rel_educationover8_count_d     := f_rel_educationover8_count_d;
   self.f_rel_under25miles_cnt_d         := f_rel_under25miles_cnt_d;
   self.f_rel_under100miles_cnt_d        := f_rel_under100miles_cnt_d;
   self.f_idrisktype_i                   := f_idrisktype_i;
   self.f_idverrisktype_i                := f_idverrisktype_i;
   self.f_varrisktype_i                  := f_varrisktype_i;
   self.f_srchvelocityrisktype_i         := f_srchvelocityrisktype_i;
   self.f_srchunvrfdssncount_i           := f_srchunvrfdssncount_i;
   self.f_srchunvrfdphonecount_i         := f_srchunvrfdphonecount_i;
   self.f_srchfraudsrchcount_i           := f_srchfraudsrchcount_i;
   self.f_assocsuspicousidcount_i        := f_assocsuspicousidcount_i;
   self.f_corraddrnamecount_d            := f_corraddrnamecount_d;
   self.f_srchssnsrchcount_i             := f_srchssnsrchcount_i;
   self.f_srchaddrsrchcount_i            := f_srchaddrsrchcount_i;
   self.f_addrchangeincomediff_d         := f_addrchangeincomediff_d;
   self.f_addrchangevaluediff_d          := f_addrchangevaluediff_d;
   self.f_addrchangecrimediff_i          := f_addrchangecrimediff_i;
   self.f_curraddrmedianincome_d         := f_curraddrmedianincome_d;
   self.f_curraddrcartheftindex_i        := f_curraddrcartheftindex_i;
   self.f_curraddrburglaryindex_i        := f_curraddrburglaryindex_i;
   self.f_curraddrcrimeindex_i           := f_curraddrcrimeindex_i;
   self.f_prevaddrcartheftindex_i        := f_prevaddrcartheftindex_i;
   self.r_s65_ssn_deceased_i             := r_s65_ssn_deceased_i;
   self.r_paw_active_phone_ct_d          := r_paw_active_phone_ct_d;
   self.r_c13_avg_lres_d                 := r_c13_avg_lres_d;
   self._mod_disc_noexp_v01_w            := _mod_disc_noexp_v01_w;
   self._mod_disc_noexp_v02_w            := _mod_disc_noexp_v02_w;
   self._mod_disc_noexp_v03_w            := _mod_disc_noexp_v03_w;
   self._mod_disc_noexp_v04_w            := _mod_disc_noexp_v04_w;
   self._mod_disc_noexp_v05_w            := _mod_disc_noexp_v05_w;
   self._mod_disc_noexp_v06_w            := _mod_disc_noexp_v06_w;
   self._mod_disc_noexp_v07_w            := _mod_disc_noexp_v07_w;
   self._mod_disc_noexp_v08_w            := _mod_disc_noexp_v08_w;
   self._mod_disc_noexp_v09_w            := _mod_disc_noexp_v09_w;
   self._mod_disc_noexp_v10_w            := _mod_disc_noexp_v10_w;
   self._mod_disc_noexp_v11_w            := _mod_disc_noexp_v11_w;
   self._mod_disc_noexp_v12_w            := _mod_disc_noexp_v12_w;
   self._mod_disc_noexp_v13_w            := _mod_disc_noexp_v13_w;
   self._mod_disc_noexp_v14_w            := _mod_disc_noexp_v14_w;
   self._mod_disc_noexp_v15_w            := _mod_disc_noexp_v15_w;
   self._mod_disc_noexp_v16_w            := _mod_disc_noexp_v16_w;
   self._mod_disc_noexp_v17_w            := _mod_disc_noexp_v17_w;
   self._mod_disc_noexp_v18_w            := _mod_disc_noexp_v18_w;
   self._mod_disc_noexp_v19_w            := _mod_disc_noexp_v19_w;
   self._mod_disc_noexp_v20_w            := _mod_disc_noexp_v20_w;
   self._mod_disc_noexp_v21_w            := _mod_disc_noexp_v21_w;
   self._mod_disc_noexp_v22_w            := _mod_disc_noexp_v22_w;
   self._mod_disc_noexp_v23_w            := _mod_disc_noexp_v23_w;
   self._mod_disc_noexp_v24_w            := _mod_disc_noexp_v24_w;
   self._mod_disc_noexp_v25_w            := _mod_disc_noexp_v25_w;
   self._mod_disc_noexp_v26_w            := _mod_disc_noexp_v26_w;
   self._mod_disc_noexp_v27_w            := _mod_disc_noexp_v27_w;
   self._mod_disc_noexp_v28_w            := _mod_disc_noexp_v28_w;
   self._mod_disc_noexp_v29_w            := _mod_disc_noexp_v29_w;
   self._mod_disc_noexp_v30_w            := _mod_disc_noexp_v30_w;
   self._mod_disc_noexp_v31_w            := _mod_disc_noexp_v31_w;
   self._mod_disc_noexp_v32_w            := _mod_disc_noexp_v32_w;
   self._mod_disc_noexp_v33_w            := _mod_disc_noexp_v33_w;
   self._mod_disc_noexp_v34_w            := _mod_disc_noexp_v34_w;
   self._mod_disc_noexp_v35_w            := _mod_disc_noexp_v35_w;
   self._mod_disc_noexp_v36_w            := _mod_disc_noexp_v36_w;
   self._mod_disc_noexp_v37_w            := _mod_disc_noexp_v37_w;
   self._mod_disc_noexp_v38_w            := _mod_disc_noexp_v38_w;
   self._mod_disc_noexp_v39_w            := _mod_disc_noexp_v39_w;
   self._mod_disc_noexp_lgt              := _mod_disc_noexp_lgt;
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
   self.final_score                      := final_score;
   self.phat                             := phat;
   self.wf83                             := wf83;
   
			self.clam.phone_shell.Phone_Model_Score := (string) wf83;
			self.clam                             := le;
                              
		#else
			self.phone_shell.Phone_Model_Score		:= (string) wf83;
		#end
			self := le;
	END;

  #if(PHONE_DEBUG)
  		model := project( clam, doModel(left) )((Integer)clam.phone_shell.Phone_Model_Score >= Score_Threshold); //score threshold defaulted to 217
  #else
		  model := project( clam, doModel(left) )((Integer)phone_shell.Phone_Model_Score >= Score_Threshold); //score threshold defaulted to 217
  #end
  
		return model;

END;
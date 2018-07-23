import ut, Models, STD;

export PhoneScore_cp3_v3(dataset(Phone_Shell.Layout_Phone_Shell.Phone_Shell_Layout) clam, Unsigned2 Score_Threshold	= Phone_Shell.Constants.Default_PhoneScore) := FUNCTION

  PHONE_DEBUG := FALSE;

  #if(PHONE_DEBUG)
 layout_debug := record
			integer sysdate                           ; // := sysdate;
   integer4 phone_pos_cr                     ; // := phone_pos_cr;
   integer4 phone_pos_edaca                  ; // := phone_pos_edaca;
   integer4 phone_pos_edadid                 ; // := phone_pos_edadid;
   integer4 phone_pos_edafa                  ; // := phone_pos_edafa;
   integer4 phone_pos_edafla                 ; // := phone_pos_edafla;
   integer4 phone_pos_edahistory             ; // := phone_pos_edahistory;
   integer4 phone_pos_edala                  ; // := phone_pos_edala;
   integer4 phone_pos_edalfa                 ; // := phone_pos_edalfa;
   integer4 phone_pos_exp                    ; // := phone_pos_exp;
   integer4 phone_pos_eqp                    ; // := phone_pos_eqp;
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
   string source_cr_lseen                  ; // := source_cr_lseen;
   string source_cr_fseen                  ; // := source_cr_fseen;
   string source_edaca_fseen               ; // := source_edaca_fseen;
   string source_edahistory_lseen          ; // := source_edahistory_lseen;
   string source_exp_lseen                 ; // := source_exp_lseen;
   string source_exp_fseen                 ; // := source_exp_fseen;
   string source_inf_fseen                 ; // := source_inf_fseen;
   string source_md_lseen                  ; // := source_md_lseen;
   string source_md_fseen                  ; // := source_md_fseen;
   string source_ne_fseen                  ; // := source_ne_fseen;
   string source_paw_lseen                 ; // := source_paw_lseen;
   string source_ppca_lseen                ; // := source_ppca_lseen;
   string source_ppca_fseen                ; // := source_ppca_fseen;
   string source_ppdid_lseen               ; // := source_ppdid_lseen;
   string source_ppdid_fseen               ; // := source_ppdid_fseen;
   string source_ppfla_lseen               ; // := source_ppfla_lseen;
   string source_ppla_lseen                ; // := source_ppla_lseen;
   string source_ppla_fseen                ; // := source_ppla_fseen;
   string source_ppth_lseen                ; // := source_ppth_lseen;
   string source_ppth_fseen                ; // := source_ppth_fseen;
   string source_rm_lseen                  ; // := source_rm_lseen;
   string source_rm_fseen                  ; // := source_rm_fseen;
   string source_sx_fseen                  ; // := source_sx_fseen;
   string source_utildid_fseen             ; // := source_utildid_fseen;
   integer number_of_sources                ; // := number_of_sources;
   boolean source_cr_lseen2                 ; // := source_cr_lseen2;
   integer mth_source_cr_lseen              ; // := mth_source_cr_lseen;
   boolean source_cr_fseen2                 ; // := source_cr_fseen2;
   integer mth_source_cr_fseen              ; // := mth_source_cr_fseen;
   boolean source_edaca_fseen2              ; // := source_edaca_fseen2;
   integer mth_source_edaca_fseen           ; // := mth_source_edaca_fseen;
   boolean source_edahistory_lseen2         ; // := source_edahistory_lseen2;
   integer mth_source_edahistory_lseen      ; // := mth_source_edahistory_lseen;
   boolean source_exp_lseen2                ; // := source_exp_lseen2;
   integer mth_source_exp_lseen             ; // := mth_source_exp_lseen;
   boolean source_exp_fseen2                ; // := source_exp_fseen2;
   integer mth_source_exp_fseen             ; // := mth_source_exp_fseen;
   boolean source_inf_fseen2                ; // := source_inf_fseen2;
   integer mth_source_inf_fseen             ; // := mth_source_inf_fseen;
   boolean source_md_lseen2                 ; // := source_md_lseen2;
   integer mth_source_md_lseen              ; // := mth_source_md_lseen;
   boolean source_md_fseen2                 ; // := source_md_fseen2;
   integer mth_source_md_fseen              ; // := mth_source_md_fseen;
   boolean source_paw_lseen2                ; // := source_paw_lseen2;
   integer mth_source_paw_lseen             ; // := mth_source_paw_lseen;
   boolean source_ppca_lseen2               ; // := source_ppca_lseen2;
   integer mth_source_ppca_lseen            ; // := mth_source_ppca_lseen;
   boolean source_ppca_fseen2               ; // := source_ppca_fseen2;
   integer mth_source_ppca_fseen            ; // := mth_source_ppca_fseen;
   boolean source_ppdid_lseen2              ; // := source_ppdid_lseen2;
   integer mth_source_ppdid_lseen           ; // := mth_source_ppdid_lseen;
   boolean source_ppdid_fseen2              ; // := source_ppdid_fseen2;
   integer mth_source_ppdid_fseen           ; // := mth_source_ppdid_fseen;
   boolean source_ppfla_lseen2              ; // := source_ppfla_lseen2;
   integer mth_source_ppfla_lseen           ; // := mth_source_ppfla_lseen;
   boolean source_ppla_lseen2               ; // := source_ppla_lseen2;
   integer mth_source_ppla_lseen            ; // := mth_source_ppla_lseen;
   boolean source_ppla_fseen2               ; // := source_ppla_fseen2;
   integer mth_source_ppla_fseen            ; // := mth_source_ppla_fseen;
   boolean source_ppth_lseen2               ; // := source_ppth_lseen2;
   integer mth_source_ppth_lseen            ; // := mth_source_ppth_lseen;
   boolean source_ppth_fseen2               ; // := source_ppth_fseen2;
   integer mth_source_ppth_fseen            ; // := mth_source_ppth_fseen;
   boolean source_rm_lseen2                 ; // := source_rm_lseen2;
   integer mth_source_rm_lseen              ; // := mth_source_rm_lseen;
   boolean source_rm_fseen2                 ; // := source_rm_fseen2;
   integer mth_source_rm_fseen              ; // := mth_source_rm_fseen;
   boolean source_sx_fseen2                 ; // := source_sx_fseen2;
   integer mth_source_sx_fseen              ; // := mth_source_sx_fseen;
   boolean source_ne_fseen2                 ; // := source_ne_fseen2;
   integer mth_source_ne_fseen              ; // := mth_source_ne_fseen;
   boolean source_utildid_fseen2            ; // := source_utildid_fseen2;
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
   integer pp_datevendorlastseen2           ; // := pp_datevendorlastseen2;
   integer mth_pp_datevendorlastseen        ; // := mth_pp_datevendorlastseen;
   integer pp_orig_lastseen2                ; // := pp_orig_lastseen2;
   integer mth_pp_orig_lastseen             ; // := mth_pp_orig_lastseen;
   integer pp_app_npa_effective_dt2         ; // := pp_app_npa_effective_dt2;
   integer mth_pp_app_npa_effective_dt      ; // := mth_pp_app_npa_effective_dt;
   integer pp_app_npa_last_change_dt2       ; // := pp_app_npa_last_change_dt2;
   integer mth_pp_app_npa_last_change_dt    ; // := mth_pp_app_npa_last_change_dt;
   integer pp_eda_hist_did_dt2              ; // := pp_eda_hist_did_dt2;
   integer mth_pp_eda_hist_did_dt           ; // := mth_pp_eda_hist_did_dt;
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
   integer _pp_rule_port_neustar            ; // := _pp_rule_port_neustar;
   integer _pp_rule_high_vend_conf          ; // := _pp_rule_high_vend_conf;
   integer _pp_rule_cellphone_latest        ; // := _pp_rule_cellphone_latest;
   integer _pp_rule_med_vend_conf_cell      ; // := _pp_rule_med_vend_conf_cell;
   integer _pp_rule_gong_disc               ; // := _pp_rule_gong_disc;
   integer _pp_rule_consort_disc            ; // := _pp_rule_consort_disc;
   integer _pp_rule_iq_wrong_party          ; // := _pp_rule_iq_wrong_party;
   integer _pp_rule_f1_ver_above            ; // := _pp_rule_f1_ver_above;
   integer _pp_src_all_uw                   ; // := _pp_src_all_uw;
   integer _pp_srule_port_neustar           ; // := _pp_srule_port_neustar;
   integer _pp_app_ported_match_10          ; // := _pp_app_ported_match_10;
   integer inq_lastseen_n                   ; // := inq_lastseen_n;
   integer inq_adl_firstseen_n              ; // := inq_adl_firstseen_n;
   integer inq_adl_lastseen_n               ; // := inq_adl_lastseen_n;
   string internal_ver_match_type          ; // := internal_ver_match_type;
   boolean _internal_ver_match_hhid         ; // := _internal_ver_match_hhid;
   boolean _inq_adl_ph_industry_flag        ; // := _inq_adl_ph_industry_flag;
   integer _phone_disconnected              ; // := _phone_disconnected;
   integer _phone_zip_match                 ; // := _phone_zip_match;
   integer _phone_timezone_match            ; // := _phone_timezone_match;
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
   boolean _phone_match_code_tcza           ; // := _phone_match_code_tcza;
   integer pk_phone_match_level             ; // := pk_phone_match_level;
   integer _pp_app_coctype_landline         ; // := _pp_app_coctype_landline;
   integer _pp_app_coctype_cell             ; // := _pp_app_coctype_cell;
   integer _phone_switch_type_cell          ; // := _phone_switch_type_cell;
   integer _pp_app_nxx_type_cell            ; // := _pp_app_nxx_type_cell;
   integer _pp_app_ph_type_cell             ; // := _pp_app_ph_type_cell;
   integer _pp_app_company_type_cell        ; // := _pp_app_company_type_cell;
   integer _exp_type_cell                   ; // := _exp_type_cell;
   integer pk_cell_indicator                ; // := pk_cell_indicator;
   integer pk_cell_flag                     ; // := pk_cell_flag;
   integer pk_exp_hit                       ; // := pk_exp_hit;
   string segment                          ; // := segment;
   boolean add_input_pop                    ; // := add_input_pop;
   boolean add_curr_pop                     ; // := add_curr_pop;
   integer add_input_address_score          ; // := add_input_address_score;
   integer add_curr_naprop                  ; // := add_curr_naprop;
   integer add_input_avm_auto_val           ; // := add_input_avm_auto_val;
   integer add_curr_avm_auto_val            ; // := add_curr_avm_auto_val;
   integer add_curr_lres                    ; // := add_curr_lres;
   integer add_curr_avm_auto_val_2          ; // := add_curr_avm_auto_val_2;
   integer add_input_naprop                 ; // := add_input_naprop;
   integer add_prev_naprop                  ; // := add_prev_naprop;
   integer add_input_nhood_bus_ct           ; // := add_input_nhood_bus_ct;
   integer add_input_nhood_sfd_ct           ; // := add_input_nhood_sfd_ct;
   integer add_input_nhood_mfd_ct           ; // := add_input_nhood_mfd_ct;
   integer add_curr_occupants_1yr           ; // := add_curr_occupants_1yr;
   integer add_curr_turnover_1yr_in         ; // := add_curr_turnover_1yr_in;
   integer add_curr_turnover_1yr_out        ; // := add_curr_turnover_1yr_out;
   integer add_curr_nhood_bus_ct            ; // := add_curr_nhood_bus_ct;
   integer add_curr_nhood_sfd_ct            ; // := add_curr_nhood_sfd_ct;
   integer add_curr_nhood_mfd_ct            ; // := add_curr_nhood_mfd_ct;
   integer r_f01_inp_addr_address_score_d   ; // := r_f01_inp_addr_address_score_d;
   integer _criminal_last_date              ; // := _criminal_last_date;
   integer r_d32_mos_since_crim_ls_d        ; // := r_d32_mos_since_crim_ls_d;
   integer r_d31_attr_bankruptcy_recency_d  ; // := r_d31_attr_bankruptcy_recency_d;
   integer r_d33_eviction_count_i           ; // := r_d33_eviction_count_i;
   integer bureau_adl_eq_fseen_pos          ; // := bureau_adl_eq_fseen_pos;
   string bureau_adl_fseen_eq              ; // := bureau_adl_fseen_eq;
   integer _bureau_adl_fseen_eq             ; // := _bureau_adl_fseen_eq;
   integer _src_bureau_adl_fseen            ; // := _src_bureau_adl_fseen;
   integer r_c21_m_bureau_adl_fs_d          ; // := r_c21_m_bureau_adl_fs_d;
   integer _header_first_seen               ; // := _header_first_seen;
   integer r_c10_m_hdr_fs_d                 ; // := r_c10_m_hdr_fs_d;
   integer r_a44_curr_add_naprop_d          ; // := r_a44_curr_add_naprop_d;
   integer r_l80_inp_avm_autoval_d          ; // := r_l80_inp_avm_autoval_d;
   integer r_a46_curr_avm_autoval_d         ; // := r_a46_curr_avm_autoval_d;
   integer r_a49_curr_avm_chg_1yr_i         ; // := r_a49_curr_avm_chg_1yr_i;
   integer r_a49_curr_avm_chg_1yr_pct_i     ; // := r_a49_curr_avm_chg_1yr_pct_i;
   integer r_c13_curr_addr_lres_d           ; // := r_c13_curr_addr_lres_d;
   integer r_c13_max_lres_d                 ; // := r_c13_max_lres_d;
   integer r_c14_addrs_5yr_i                ; // := r_c14_addrs_5yr_i;
   integer r_c14_addrs_10yr_i               ; // := r_c14_addrs_10yr_i;
   integer r_c14_addrs_15yr_i               ; // := r_c14_addrs_15yr_i;
   integer r_a41_prop_owner_d               ; // := r_a41_prop_owner_d;
   integer r_a41_prop_owner_inp_only_d      ; // := r_a41_prop_owner_inp_only_d;
   integer r_prop_owner_history_d           ; // := r_prop_owner_history_d;
   integer r_a50_pb_average_dollars_d       ; // := r_a50_pb_average_dollars_d;
   integer r_pb_order_freq_d                ; // := r_pb_order_freq_d;
   integer r_i60_inq_comm_recency_d         ; // := r_i60_inq_comm_recency_d;
   integer f_bus_lname_verd_d               ; // := f_bus_lname_verd_d;
   integer f_util_adl_count_n               ; // := f_util_adl_count_n;
   integer add_input_nhood_prop_sum         ; // := add_input_nhood_prop_sum;
   integer f_add_input_nhood_bus_pct_i      ; // := f_add_input_nhood_bus_pct_i;
   integer f_add_input_nhood_mfd_pct_i      ; // := f_add_input_nhood_mfd_pct_i;
   integer f_add_input_nhood_sfd_pct_d      ; // := f_add_input_nhood_sfd_pct_d;
   integer f_add_curr_mobility_index_n      ; // := f_add_curr_mobility_index_n;
   integer add_curr_nhood_prop_sum          ; // := add_curr_nhood_prop_sum;
   integer f_add_curr_nhood_mfd_pct_i       ; // := f_add_curr_nhood_mfd_pct_i;
   integer f_inq_count_i                    ; // := f_inq_count_i;
   integer f_inq_collection_count_i         ; // := f_inq_collection_count_i;
   integer f_inq_communications_count_i  ; // := f_inq_communications_count_i;
   integer f_inq_highriskcredit_count24_i; // := f_inq_highriskcredit_count24_i;
   integer f_inq_other_count_i           ; // := f_inq_other_count_i;
   integer _inq_banko_cm_last_seen       ; // := _inq_banko_cm_last_seen;
   integer f_mos_inq_banko_cm_lseen_d    ; // := f_mos_inq_banko_cm_lseen_d;
   integer _inq_banko_om_last_seen       ; // := _inq_banko_om_last_seen;
   integer f_mos_inq_banko_om_lseen_d    ; // := f_mos_inq_banko_om_lseen_d;
   integer _liens_unrel_cj_last_seen     ; // := _liens_unrel_cj_last_seen;
   integer f_mos_liens_unrel_cj_lseen_d  ; // := f_mos_liens_unrel_cj_lseen_d;
   integer f_liens_unrel_cj_total_amt_i  ; // := f_liens_unrel_cj_total_amt_i;
   integer f_liens_rel_cj_total_amt_i    ; // := f_liens_rel_cj_total_amt_i;
   integer f_liens_unrel_o_total_amt_i   ; // := f_liens_unrel_o_total_amt_i;
   integer _liens_unrel_ot_first_seen    ; // := _liens_unrel_ot_first_seen;
   integer f_mos_liens_unrel_ot_fseen_d  ; // := f_mos_liens_unrel_ot_fseen_d;
   integer f_wealth_index_d              ; // := f_wealth_index_d;
   integer f_rel_incomeover25_count_d    ; // := f_rel_incomeover25_count_d;
   integer f_rel_incomeover50_count_d    ; // := f_rel_incomeover50_count_d;
   integer f_rel_incomeover75_count_d    ; // := f_rel_incomeover75_count_d;
   integer f_rel_incomeover100_count_d   ; // := f_rel_incomeover100_count_d;
   integer f_rel_homeover50_count_d      ; // := f_rel_homeover50_count_d;
   integer f_rel_homeover100_count_d     ; // := f_rel_homeover100_count_d;
   integer f_rel_ageover40_count_d       ; // := f_rel_ageover40_count_d;
   integer f_rel_ageover50_count_d       ; // := f_rel_ageover50_count_d;
   integer f_crim_rel_under500miles_cnt_i; // := f_crim_rel_under500miles_cnt_i;
   integer f_rel_under25miles_cnt_d      ; // := f_rel_under25miles_cnt_d;
   integer f_rel_under500miles_cnt_d     ; // := f_rel_under500miles_cnt_d;
   integer f_rel_criminal_count_i        ; // := f_rel_criminal_count_i;
   integer f_idrisktype_i                ; // := f_idrisktype_i;
   integer f_sourcerisktype_i            ; // := f_sourcerisktype_i;
   integer f_varrisktype_i               ; // := f_varrisktype_i;
   integer f_srchvelocityrisktype_i      ; // := f_srchvelocityrisktype_i;
   integer f_srchunvrfdphonecount_i      ; // := f_srchunvrfdphonecount_i;
   integer f_srchfraudsrchcount_i        ; // := f_srchfraudsrchcount_i;
   integer f_assocsuspicousidcount_i     ; // := f_assocsuspicousidcount_i;
   integer f_corrrisktype_i              ; // := f_corrrisktype_i;
   integer f_corrssnnamecount_d          ; // := f_corrssnnamecount_d;
   integer f_corraddrnamecount_d         ; // := f_corraddrnamecount_d;
   integer f_srchaddrsrchcount_i         ; // := f_srchaddrsrchcount_i;
   integer f_inputaddractivephonelist_d  ; // := f_inputaddractivephonelist_d;
   integer f_addrchangevaluediff_d       ; // := f_addrchangevaluediff_d;
   integer f_addrchangecrimediff_i       ; // := f_addrchangecrimediff_i;
   integer f_curraddrmedianincome_d      ; // := f_curraddrmedianincome_d;
   integer f_curraddrmurderindex_i       ; // := f_curraddrmurderindex_i;
   integer f_curraddrcartheftindex_i     ; // := f_curraddrcartheftindex_i;
   integer f_curraddrcrimeindex_i        ; // := f_curraddrcrimeindex_i;
   integer f_prevaddrageoldest_d         ; // := f_prevaddrageoldest_d;
   integer f_prevaddrlenofres_d          ; // := f_prevaddrlenofres_d;
   integer f_prevaddrdwelltype_apt_n     ; // := f_prevaddrdwelltype_apt_n;
   integer f_prevaddrmedianincome_d      ; // := f_prevaddrmedianincome_d;
   integer f_prevaddrmedianvalue_d       ; // := f_prevaddrmedianvalue_d;
   integer f_fp_prevaddrcrimeindex_i     ; // := f_fp_prevaddrcrimeindex_i;
   integer r_paw_dead_business_ct_i      ; // := r_paw_dead_business_ct_i;
   integer r_paw_active_phone_ct_d       ; // := r_paw_active_phone_ct_d;
   integer r_c13_avg_lres_d              ; // := r_c13_avg_lres_d;
   integer _mod_disc_exp_v01_w           ; // := _mod_disc_exp_v01_w;
   integer _mod_disc_exp_v02_w           ; // := _mod_disc_exp_v02_w;
   integer _mod_disc_exp_v03_w           ; // := _mod_disc_exp_v03_w;
   integer _mod_disc_exp_v04_w           ; // := _mod_disc_exp_v04_w;
   integer _mod_disc_exp_v05_w           ; // := _mod_disc_exp_v05_w;
   integer _mod_disc_exp_v06_w           ; // := _mod_disc_exp_v06_w;
   integer _mod_disc_exp_v07_w           ; // := _mod_disc_exp_v07_w;
   integer _mod_disc_exp_v08_w           ; // := _mod_disc_exp_v08_w;
   integer _mod_disc_exp_v09_w           ; // := _mod_disc_exp_v09_w;
   integer _mod_disc_exp_v10_w           ; // := _mod_disc_exp_v10_w;
   integer _mod_disc_exp_v11_w           ; // := _mod_disc_exp_v11_w;
   integer _mod_disc_exp_v12_w           ; // := _mod_disc_exp_v12_w;
   integer _mod_disc_exp_v13_w           ; // := _mod_disc_exp_v13_w;
   integer _mod_disc_exp_v14_w           ; // := _mod_disc_exp_v14_w;
   integer _mod_disc_exp_v15_w           ; // := _mod_disc_exp_v15_w;
   integer _mod_disc_exp_v16_w           ; // := _mod_disc_exp_v16_w;
   integer _mod_disc_exp_v17_w           ; // := _mod_disc_exp_v17_w;
   integer _mod_disc_exp_v18_w           ; // := _mod_disc_exp_v18_w;
   integer _mod_disc_exp_v19_w           ; // := _mod_disc_exp_v19_w;
   integer _mod_disc_exp_v20_w           ; // := _mod_disc_exp_v20_w;
   integer _mod_disc_exp_v21_w           ; // := _mod_disc_exp_v21_w;
   integer _mod_disc_exp_v22_w           ; // := _mod_disc_exp_v22_w;
   integer _mod_disc_exp_v23_w           ; // := _mod_disc_exp_v23_w;
   integer _mod_disc_exp_v24_w           ; // := _mod_disc_exp_v24_w;
   integer _mod_disc_exp_v25_w           ; // := _mod_disc_exp_v25_w;
   integer _mod_disc_exp_v26_w           ; // := _mod_disc_exp_v26_w;
   integer _mod_disc_exp_v27_w           ; // := _mod_disc_exp_v27_w;
   integer _mod_disc_exp_v28_w           ; // := _mod_disc_exp_v28_w;
   integer _mod_disc_exp_v29_w           ; // := _mod_disc_exp_v29_w;
   integer _mod_disc_exp_v30_w           ; // := _mod_disc_exp_v30_w;
   integer _mod_disc_exp_v31_w           ; // := _mod_disc_exp_v31_w;
   integer _mod_disc_exp_v32_w           ; // := _mod_disc_exp_v32_w;
   integer _mod_disc_exp_v33_w           ; // := _mod_disc_exp_v33_w;
   integer _mod_disc_exp_v34_w           ; // := _mod_disc_exp_v34_w;
   integer _mod_disc_exp_v35_w           ; // := _mod_disc_exp_v35_w;
   integer _mod_disc_exp_v36_w           ; // := _mod_disc_exp_v36_w;
   integer _mod_disc_exp_v37_w           ; // := _mod_disc_exp_v37_w;
   integer _mod_disc_exp_v38_w           ; // := _mod_disc_exp_v38_w;
   integer _mod_disc_exp_lgt             ; // := _mod_disc_exp_lgt;
   integer _mod_binnr_exp_v01_w          ; // := _mod_binnr_exp_v01_w;
   integer _mod_binnr_exp_v02_w          ; // := _mod_binnr_exp_v02_w;
   integer _mod_binnr_exp_v03_w          ; // := _mod_binnr_exp_v03_w;
   integer _mod_binnr_exp_v04_w          ; // := _mod_binnr_exp_v04_w;
   integer _mod_binnr_exp_v05_w          ; // := _mod_binnr_exp_v05_w;
   integer _mod_binnr_exp_v06_w          ; // := _mod_binnr_exp_v06_w;
   integer _mod_binnr_exp_v07_w          ; // := _mod_binnr_exp_v07_w;
   integer _mod_binnr_exp_v08_w          ; // := _mod_binnr_exp_v08_w;
   integer _mod_binnr_exp_v09_w          ; // := _mod_binnr_exp_v09_w;
   integer _mod_binnr_exp_v10_w          ; // := _mod_binnr_exp_v10_w;
   integer _mod_binnr_exp_v11_w          ; // := _mod_binnr_exp_v11_w;
   integer _mod_binnr_exp_v12_w          ; // := _mod_binnr_exp_v12_w;
   integer _mod_binnr_exp_v13_w          ; // := _mod_binnr_exp_v13_w;
   integer _mod_binnr_exp_v14_w          ; // := _mod_binnr_exp_v14_w;
   integer _mod_binnr_exp_v15_w          ; // := _mod_binnr_exp_v15_w;
   integer _mod_binnr_exp_v16_w          ; // := _mod_binnr_exp_v16_w;
   integer _mod_binnr_exp_v17_w          ; // := _mod_binnr_exp_v17_w;
   integer _mod_binnr_exp_v18_w          ; // := _mod_binnr_exp_v18_w;
   integer _mod_binnr_exp_v19_w          ; // := _mod_binnr_exp_v19_w;
   integer _mod_binnr_exp_v20_w          ; // := _mod_binnr_exp_v20_w;
   integer _mod_binnr_exp_v21_w          ; // := _mod_binnr_exp_v21_w;
   integer _mod_binnr_exp_v22_w          ; // := _mod_binnr_exp_v22_w;
   integer _mod_binnr_exp_v23_w          ; // := _mod_binnr_exp_v23_w;
   integer _mod_binnr_exp_v24_w          ; // := _mod_binnr_exp_v24_w;
   integer _mod_binnr_exp_v25_w          ; // := _mod_binnr_exp_v25_w;
   integer _mod_binnr_exp_v26_w          ; // := _mod_binnr_exp_v26_w;
   integer _mod_binnr_exp_v27_w          ; // := _mod_binnr_exp_v27_w;
   integer _mod_binnr_exp_v28_w          ; // := _mod_binnr_exp_v28_w;
   integer _mod_binnr_exp_v29_w          ; // := _mod_binnr_exp_v29_w;
   integer _mod_binnr_exp_v30_w          ; // := _mod_binnr_exp_v30_w;
   integer _mod_binnr_exp_v31_w          ; // := _mod_binnr_exp_v31_w;
   integer _mod_binnr_exp_v32_w          ; // := _mod_binnr_exp_v32_w;
   integer _mod_binnr_exp_v33_w          ; // := _mod_binnr_exp_v33_w;
   integer _mod_binnr_exp_v34_w          ; // := _mod_binnr_exp_v34_w;
   integer _mod_binnr_exp_lgt            ; // := _mod_binnr_exp_lgt;
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
   real final_score                      ; // := final_score;
   integer phat                          ; // := phat;
   integer cp33                          ; // := cp33;
			// Save all of the Phone Shell fields for return
			Phone_Shell.Layout_Phone_Shell.Phone_Shell_Layout clam;
 END;
    layout_debug doModel( clam le ) := TRANSFORM
  #else
		Phone_Shell.Layout_Phone_Shell.Phone_Shell_Layout doModel( clam le ) := TRANSFORM
  #end

//Start: ECL SAS mapping variables 
	isFCRA													 := false;
  
	source_list                      := trim(le.Phone_Shell.Sources.Source_List, left, right);
	source_list_last_seen            := trim(le.Phone_Shell.Sources.Source_List_Last_Seen, left, right);
	source_list_first_seen           := trim(le.Phone_Shell.Sources.Source_List_First_Seen, left, right);
	eda_dt_first_seen                := le.Phone_Shell.EDA_Characteristics.EDA_Dt_First_Seen;
	eda_dt_last_seen                 := le.Phone_Shell.EDA_Characteristics.EDA_Dt_Last_Seen;
	eda_deletion_date                := le.Phone_Shell.EDA_Characteristics.EDA_deletion_date;
	exp_last_update                  := le.Phone_Shell.Experian_File_One_Verification.Experian_Last_Update;
	internal_ver_first_seen          := le.Phone_Shell.Internal_Corroboration.Internal_Verification_First_Seen;
	internal_ver_last_seen           := le.Phone_Shell.Internal_Corroboration.Internal_Verification_Last_Seen;
 internal_ver_match_types         := le.Phone_Shell.Internal_Corroboration.Internal_Verification_Match_Types;
 phone_fb_rp_date                 := le.Phone_Shell.Phone_Feedback.Phone_Feedback_RP_Date;
	pp_datefirstseen                 := le.Phone_Shell.PhonesPlus_Characteristics.PhonesPlus_DateFirstSeen;
	pp_datelastseen                  := le.Phone_Shell.PhonesPlus_Characteristics.PhonesPlus_DateLastSeen;
	pp_datevendorfirstseen           := le.Phone_Shell.PhonesPlus_Characteristics.PhonesPlus_DateVendorFirstSeen;
	pp_datevendorlastseen            := le.Phone_Shell.PhonesPlus_Characteristics.PhonesPlus_DateVendorLastSeen;
	pp_orig_lastseen                 := le.Phone_Shell.PhonesPlus_Characteristics.PhonesPlus_Orig_LastSeen;
	pp_app_npa_effective_dt          := le.Phone_Shell.PhonesPlus_Characteristics.PhonesPlus_Append_NPA_Effective_DT;
	pp_app_npa_last_change_dt        := le.Phone_Shell.PhonesPlus_Characteristics.PhonesPlus_Append_NPA_Last_Change_DT;
	pp_eda_hist_did_dt               := le.Phone_Shell.PhonesPlus_Characteristics.PhonesPlus_EDA_Hist_DID_Dt;
	pp_first_build_date              := le.Phone_Shell.PhonesPlus_Characteristics.PhonesPlus_First_Build_Date;
	phone_match_code                 := le.Phone_Shell.Raw_Phone_Characteristics.Phone_Match_Code;
	pp_rules                         := le.Phone_Shell.PhonesPlus_Characteristics.PhonesPlus_Rules;
	pp_src_all                       := le.Phone_Shell.PhonesPlus_Characteristics.PhonesPlus_Src_All;
	pp_src_rule                      := le.Phone_Shell.PhonesPlus_Characteristics.PhonesPlus_Src_Rule;
	pp_app_ported_match              := le.Phone_Shell.PhonesPlus_Characteristics.PhonesPlus_Append_Ported_Match;
	inq_lastseen                     := le.Phone_Shell.Inquiries.Inq_LastSeen;
	inq_adl_firstseen                := le.Phone_Shell.Inquiries.Inq_ADL_FirstSeen;
	inq_adl_lastseen                 := le.Phone_Shell.Inquiries.Inq_ADL_LastSeen;
	inq_adl_ph_industry_list_12      := le.Phone_Shell.Inquiries.Inq_ADL_Phone_Industry_List_12;
	phone_disconnected               := (integer)le.Phone_Shell.Raw_Phone_Characteristics.Phone_Disconnected;
	phone_zip_match                  := le.Phone_Shell.Raw_Phone_Characteristics.Phone_Zip_Match;
	phone_timezone_match             := le.Phone_Shell.Raw_Phone_Characteristics.Phone_Timezone_Match;
	pp_app_fb_ph                     := le.Phone_Shell.PhonesPlus_Characteristics.PhonesPlus_Append_Feedback_Phone;
	pp_app_fb_ph7_did                := le.Phone_Shell.PhonesPlus_Characteristics.PhonesPlus_Append_Feedback_Phone7_DID;
	pp_app_fb_ph7_nm_addr            := le.Phone_Shell.PhonesPlus_Characteristics.PhonesPlus_Append_Feedback_Phone7_NM_Addr;
	phone_fb_result                  := le.Phone_Shell.Phone_Feedback.Phone_Feedback_Result;
	phone_fb_rp_result               := le.Phone_Shell.Phone_Feedback.Phone_Feedback_RP_Result;
	pp_app_coctype                   := le.Phone_Shell.PhonesPlus_Characteristics.PhonesPlus_Append_COCType;
	pp_app_scc                       := le.Phone_Shell.PhonesPlus_Characteristics.PhonesPlus_Append_SCC;
	phone_switch_type                := le.Phone_Shell.Raw_Phone_Characteristics.Phone_Switch_Type;
	pp_app_nxx_type                  := le.Phone_Shell.PhonesPlus_Characteristics.PhonesPlus_Append_NXX_Type;
	pp_app_ph_type                   := le.Phone_Shell.PhonesPlus_Characteristics.PhonesPlus_Append_Phone_Type;
	pp_app_company_type              := le.Phone_Shell.PhonesPlus_Characteristics.PhonesPlus_Append_Company_Type;
	exp_type                         := le.Phone_Shell.Experian_File_One_Verification.Experian_Type;
	exp_verified                     := (integer)le.Phone_Shell.Experian_File_One_Verification.Experian_Verified;
	exp_source                       := le.Phone_Shell.Experian_File_One_Verification.Experian_Source;
	exp_ph_score_v1                  := le.Phone_Shell.Experian_File_One_Verification.Experian_Phone_Score_V1;
	eda_pfrd_address_ind             := le.Phone_Shell.EDA_Characteristics.EDA_pfrd_address_ind;
	eda_address_match_best           := (integer)le.Phone_Shell.EDA_Characteristics.EDA_address_match_best;
 inq_num_adls_06                  := le.Phone_Shell.Inquiries.Inq_Num_ADLs_06;
 phone_subject_title              := le.Phone_Shell.Raw_Phone_Characteristics.Phone_Subject_Title;
 eda_min_days_connected_ind       := le.Phone_Shell.EDA_Characteristics.EDA_min_days_connected_indiv;
 eda_max_days_interrupt           := le.Phone_Shell.EDA_Characteristics.EDA_max_days_interrupt;
 pp_origphonetype                 := le.Phone_Shell.PhonesPlus_Characteristics.PhonesPlus_OrigPhoneType;
 pp_source                        := le.Phone_Shell.PhonesPlus_Characteristics.PhonesPlus_Source;
 pp_rp_source                     := le.Phone_Shell.PhonesPlus_Characteristics.PhonesPlus_RP_Source;
 pp_src                           := le.Phone_Shell.PhonesPlus_Characteristics.PhonesPlus_Src;
 eda_min_days_interrupt           := le.Phone_Shell.EDA_Characteristics.EDA_min_days_interrupt;
 eda_avg_days_interrupt           := le.Phone_Shell.EDA_Characteristics.EDA_avg_days_interrupt;
 eda_days_in_service              := le.Phone_Shell.EDA_Characteristics.EDA_days_in_service;
 pp_app_ind_ph_cnt                := le.Phone_Shell.PhonesPlus_Characteristics.PhonesPlus_Append_Indiv_Phone_Cnt;
	pp_did_type                      := le.Phone_Shell.PhonesPlus_Characteristics.PhonesPlus_DID_Type;
	pp_avg_source_conf               := le.Phone_Shell.PhonesPlus_Characteristics.PhonesPlus_Avg_Source_Conf;
	truedid                          := le.Boca_Shell.truedid;
	ver_sources                      := le.Boca_Shell.header_summary.ver_sources;
	ver_sources_first_seen           := le.Boca_Shell.header_summary.ver_sources_first_seen_date;
	bus_name_match                   := le.Boca_Shell.business_header_address_summary.bus_name_match;
	addrpop                          := le.Boca_Shell.input_validation.address;
	util_adl_count                   := le.Boca_Shell.utility.utili_adl_count;
	add1_address_score               := le.Boca_Shell.address_verification.input_address_information.address_score;
	add1_isbestmatch                 := le.Boca_Shell.address_verification.input_address_information.isbestmatch;
	add1_lres                        := le.Boca_Shell.lres;
	add1_avm_automated_valuation     := le.Boca_Shell.avm.input_address_information.avm_automated_valuation;
	add1_avm_automated_valuation_2   := le.Boca_Shell.avm.input_address_information.avm_automated_valuation2;
	add1_naprop                      := le.Boca_Shell.address_verification.input_address_information.naprop;
	add1_occupants_1yr               := le.Boca_Shell.addr_risk_summary.occupants_1yr;
	add1_turnover_1yr_in             := le.Boca_Shell.addr_risk_summary.turnover_1yr_in;
	add1_nhood_business_count        := le.Boca_Shell.addr_risk_summary.n_business_count;
	add1_nhood_sfd_count             := le.Boca_Shell.addr_risk_summary.n_sfd_count;
	add1_nhood_mfd_count             := le.Boca_Shell.addr_risk_summary.n_mfd_count;
	add1_pop                         := le.Boca_Shell.addrpop;
	property_owned_total             := le.Boca_Shell.address_verification.owned.property_total;
	add2_address_score               := le.Boca_Shell.address_verification.address_history_1.address_score;
	add2_lres                        := le.Boca_Shell.lres2;
	add2_avm_automated_valuation     := le.Boca_Shell.avm.address_history_1.avm_automated_valuation;
	add2_avm_automated_valuation_2   := le.Boca_Shell.avm.address_history_1.avm_automated_valuation2;
	add2_naprop                      := le.Boca_Shell.address_verification.address_history_1.naprop;
	add2_occupants_1yr               := le.Boca_Shell.addr_risk_summary2.occupants_1yr;
	add2_turnover_1yr_in             := le.Boca_Shell.addr_risk_summary2.turnover_1yr_in;
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
	header_first_seen                := le.Boca_Shell.ssn_verification.header_first_seen;
	inq_count                        := le.Boca_Shell.acc_logs.inquiries.counttotal;
	inq_collection_count             := le.Boca_Shell.acc_logs.collection.counttotal;
	inq_highriskcredit_count24       := le.Boca_Shell.acc_logs.highriskcredit.count24;
	inq_communications_count         := le.Boca_Shell.acc_logs.communications.counttotal;
	inq_communications_count01       := le.Boca_Shell.acc_logs.communications.count01;
	inq_communications_count03       := le.Boca_Shell.acc_logs.communications.count03;
	inq_communications_count06       := le.Boca_Shell.acc_logs.communications.count06;
	inq_communications_count12       := le.Boca_Shell.acc_logs.communications.count12;
	inq_communications_count24       := le.Boca_Shell.acc_logs.communications.count24;
	inq_other_count                  := le.Boca_Shell.acc_logs.other.counttotal;
	inq_banko_cm_last_seen           := le.Boca_Shell.acc_logs.cm_last_seen_date;
	inq_banko_om_last_seen           := le.Boca_Shell.acc_logs.om_last_seen_date;
	pb_number_of_sources             := le.Boca_Shell.ibehavior.number_of_sources;
	pb_average_days_bt_orders        := le.Boca_Shell.ibehavior.average_days_between_orders;
	pb_average_dollars               := le.Boca_Shell.ibehavior.average_amount_per_order;
	paw_dead_business_count          := le.Boca_Shell.employment.dead_business_ct;
	paw_active_phone_count           := le.Boca_Shell.employment.business_active_phone_ct;
	attr_bankruptcy_count30          := le.Boca_Shell.bjl.bk_count30;
	attr_bankruptcy_count90          := le.Boca_Shell.bjl.bk_count90;
	attr_bankruptcy_count180         := le.Boca_Shell.bjl.bk_count180;
	attr_bankruptcy_count12          := le.Boca_Shell.bjl.bk_count12;
	attr_bankruptcy_count24          := le.Boca_Shell.bjl.bk_count24;
	attr_bankruptcy_count36          := le.Boca_Shell.bjl.bk_count36;
	attr_bankruptcy_count60          := le.Boca_Shell.bjl.bk_count60;
	attr_eviction_count              := le.Boca_Shell.bjl.eviction_count;
	fp_idrisktype                    := le.Boca_Shell.fdattributesv2.identityrisklevel;
	fp_sourcerisktype                := le.Boca_Shell.fdattributesv2.sourcerisklevel;
	fp_varrisktype                   := le.Boca_Shell.fdattributesv2.variationrisklevel;
	fp_srchvelocityrisktype          := le.Boca_Shell.fdattributesv2.searchvelocityrisklevel;
	fp_srchunvrfdphonecount          := le.Boca_Shell.fdattributesv2.searchunverifiedphonecountyear;
	fp_srchfraudsrchcount            := le.Boca_Shell.fdattributesv2.searchfraudsearchcount;
	fp_assocsuspicousidcount         := le.Boca_Shell.fdattributesv2.assocsuspicousidentitiescount;
	fp_corrrisktype                  := le.Boca_Shell.fdattributesv2.correlationrisklevel;
	fp_corrssnnamecount              := le.Boca_Shell.fdattributesv2.correlationssnnamecount;
	fp_corraddrnamecount             := le.Boca_Shell.fdattributesv2.correlationaddrnamecount;
	fp_srchaddrsrchcount             := le.Boca_Shell.fdattributesv2.searchaddrsearchcount;
	fp_inputaddractivephonelist      := le.Boca_Shell.fdattributesv2.inputaddractivephonelist;
	fp_addrchangevaluediff           := le.Boca_Shell.fdattributesv2.addrchangevaluediff;
	fp_addrchangecrimediff           := le.Boca_Shell.fdattributesv2.addrchangecrimediff;
	fp_curraddrmedianincome          := le.Boca_Shell.fdattributesv2.curraddrmedianincome;
	fp_curraddrmurderindex           := le.Boca_Shell.fdattributesv2.curraddrmurderindex;
	fp_curraddrcartheftindex         := le.Boca_Shell.fdattributesv2.curraddrcartheftindex;
	fp_curraddrcrimeindex            := le.Boca_Shell.fdattributesv2.curraddrcrimeindex;
	fp_prevaddrageoldest             := le.Boca_Shell.fdattributesv2.prevaddrageoldest;
	fp_prevaddrlenofres              := le.Boca_Shell.fdattributesv2.prevaddrlenofres;
	fp_prevaddrdwelltype             := le.Boca_Shell.fdattributesv2.prevaddrdwelltype;
	fp_prevaddrmedianincome          := le.Boca_Shell.fdattributesv2.prevaddrmedianincome;
	fp_prevaddrmedianvalue           := le.Boca_Shell.fdattributesv2.prevaddrmedianvalue;
	fp_prevaddrcrimeindex            := le.Boca_Shell.fdattributesv2.prevaddrcrimeindex;
	bankrupt                         := le.Boca_Shell.bjl.bankrupt;
	filing_count                     := le.Boca_Shell.bjl.filing_count;
	liens_unrel_cj_last_seen         := le.Boca_Shell.liens.liens_unreleased_civil_judgment.most_recent_filing_date;
	liens_unrel_cj_total_amount      := le.Boca_Shell.liens.liens_unreleased_civil_judgment.total_amount;
	liens_rel_cj_total_amount        := le.Boca_Shell.liens.liens_released_civil_judgment.total_amount;
	liens_unrel_o_total_amount       := le.Boca_Shell.liens.liens_unreleased_other_lj.total_amount;
	liens_unrel_ot_first_seen        := le.Boca_Shell.liens.liens_unreleased_other_tax.earliest_filing_date;
	criminal_last_date               := le.Boca_Shell.bjl.last_criminal_date;
	rel_count                        := le.Boca_Shell.relatives.relative_count;
	rel_criminal_count               := le.Boca_Shell.relatives.relative_criminal_count;
	crim_rel_within25miles           := le.Boca_Shell.relatives.criminal_relative_within25miles;
	crim_rel_within100miles          := le.Boca_Shell.relatives.criminal_relative_within100miles;
	crim_rel_within500miles          := le.Boca_Shell.relatives.criminal_relative_within500miles;
	rel_within25miles_count          := le.Boca_Shell.relatives.relative_within25miles_count;
	rel_within100miles_count         := le.Boca_Shell.relatives.relative_within100miles_count;
	rel_within500miles_count         := le.Boca_Shell.relatives.relative_within500miles_count;
	rel_incomeunder50_count          := le.Boca_Shell.relatives.relative_incomeunder50_count;
	rel_incomeunder75_count          := le.Boca_Shell.relatives.relative_incomeunder75_count;
	rel_incomeunder100_count         := le.Boca_Shell.relatives.relative_incomeunder100_count;
	rel_incomeover100_count          := le.Boca_Shell.relatives.relative_incomeover100_count;
	rel_homeunder100_count           := le.Boca_Shell.relatives.relative_homeunder100_count;
	rel_homeunder150_count           := le.Boca_Shell.relatives.relative_homeunder150_count;
	rel_homeunder200_count           := le.Boca_Shell.relatives.relative_homeunder200_count;
	rel_homeunder300_count           := le.Boca_Shell.relatives.relative_homeunder300_count;
	rel_homeunder500_count           := le.Boca_Shell.relatives.relative_homeunder500_count;
	rel_homeover500_count            := le.Boca_Shell.relatives.relative_homeover500_count;
	rel_ageunder50_count             := le.Boca_Shell.relatives.relative_ageunder50_count;
	rel_ageunder60_count             := le.Boca_Shell.relatives.relative_ageunder60_count;
	rel_ageunder70_count             := le.Boca_Shell.relatives.relative_ageunder70_count;
	rel_ageover70_count              := le.Boca_Shell.relatives.relative_ageover70_count;
	wealth_index                     := le.Boca_Shell.wealth_indicator;

//End SAS mapping variables

NULL := -999999999;


BOOLEAN indexw(string source, string target, string delim) :=
	(source = target) OR
	(StringLib.StringFind(source, delim + target + delim, 1) > 0) OR
	(source[1..length(target)+1] = target + delim) OR
	(StringLib.StringReverse(source)[1..length(target)+1] = StringLib.StringReverse(target) + delim);

sysdate := Models.Common.sas_date(if(le.Boca_Shell.historydate=999999, (string8)Std.Date.Today(), (string6)le.Boca_Shell.historydate+'01'));
// For debug, to get a specific date
// sysdate := Models.Common.sas_date(if(le.Boca_Shell.historydate=999999, '20180522', (string6)le.Boca_Shell.historydate+'01'));

phone_pos_cr := Models.Common.findw_cpp(source_list, 'CR' , ',', 'E');

phone_pos_edaca := Models.Common.findw_cpp(source_list, 'EDACA' , ',', 'E');

phone_pos_edadid := Models.Common.findw_cpp(source_list, 'EDADID' , ',', 'E');

phone_pos_edafa := Models.Common.findw_cpp(source_list, 'EDAFA' , ',', 'E');

phone_pos_edafla := Models.Common.findw_cpp(source_list, 'EDAFLA' , ',', 'E');

phone_pos_edahistory := Models.Common.findw_cpp(source_list, 'EDAHistory' , ',', 'E');

phone_pos_edala := Models.Common.findw_cpp(source_list, 'EDALA' , ',', 'E');

phone_pos_edalfa := Models.Common.findw_cpp(source_list, 'EDALFA' , ',', 'E');

phone_pos_exp := Models.Common.findw_cpp(source_list, 'EXP' , ',', 'E');

phone_pos_eqp := Models.Common.findw_cpp(source_list, 'EQP' , ',', 'E');

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

source_exp := phone_pos_exp > 0 or phone_pos_eqp > 0;

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

source_cr_lseen := Models.Common.getw(source_list_last_seen, phone_pos_cr);

source_cr_fseen := Models.Common.getw(source_list_first_seen, phone_pos_cr);

source_edaca_fseen := Models.Common.getw(source_list_first_seen, phone_pos_edaca);

source_edahistory_lseen := Models.Common.getw(source_list_last_seen, phone_pos_edahistory);

source_exp_fseen := if(phone_pos_exp > phone_pos_eqp, Models.Common.getw(source_list_first_seen, phone_pos_exp), Models.Common.getw(source_list_first_seen, phone_pos_eqp));

source_exp_lseen := if(phone_pos_exp > phone_pos_eqp, Models.Common.getw(source_list_last_seen, phone_pos_exp), Models.Common.getw(source_list_last_seen, phone_pos_eqp));

source_inf_fseen := Models.Common.getw(source_list_first_seen, phone_pos_inf);

source_md_lseen := Models.Common.getw(source_list_last_seen, phone_pos_md);

source_md_fseen := Models.Common.getw(source_list_first_seen, phone_pos_md);

source_ne_fseen := Models.Common.getw(source_list_first_seen, phone_pos_ne);

source_paw_lseen := Models.Common.getw(source_list_last_seen, phone_pos_paw);

source_ppca_lseen := Models.Common.getw(source_list_last_seen, phone_pos_ppca);

source_ppca_fseen := Models.Common.getw(source_list_first_seen, phone_pos_ppca);

source_ppdid_lseen := Models.Common.getw(source_list_last_seen, phone_pos_ppdid);

source_ppdid_fseen := Models.Common.getw(source_list_first_seen, phone_pos_ppdid);

source_ppfla_lseen := Models.Common.getw(source_list_last_seen, phone_pos_ppfla);

source_ppla_lseen := Models.Common.getw(source_list_last_seen, phone_pos_ppla);

source_ppla_fseen := Models.Common.getw(source_list_first_seen, phone_pos_ppla);

source_ppth_lseen := Models.Common.getw(source_list_last_seen, phone_pos_ppth);

source_ppth_fseen := Models.Common.getw(source_list_first_seen, phone_pos_ppth);

source_rm_lseen := Models.Common.getw(source_list_last_seen, phone_pos_rm);

source_rm_fseen := Models.Common.getw(source_list_first_seen, phone_pos_rm);

source_sx_fseen := Models.Common.getw(source_list_first_seen, phone_pos_sx);

source_utildid_fseen := Models.Common.getw(source_list_first_seen, phone_pos_utildid);

number_of_sources := if(max((integer)source_cr, (integer)source_edaca, (integer)source_edadid, (integer)source_edafa, (integer)source_edafla, (integer)source_edahistory, (integer)source_edala, (integer)source_edalfa, (integer)source_exp, (integer)source_inf, (integer)source_input, (integer)source_md, (integer)source_ne, (integer)source_paw, (integer)source_pde, (integer)source_pf, (integer)source_pffla, (integer)source_pfla, (integer)source_ppca, (integer)source_ppdid, (integer)source_ppfa, (integer)source_ppfla, (integer)source_ppla, (integer)source_pplfa, (integer)source_ppth, (integer)source_rel, (integer)source_rm, (integer)source_sp, (integer)source_sx, (integer)source_utildid) = NULL, NULL, sum((integer)source_cr, (integer)source_edaca, (integer)source_edadid, (integer)source_edafa, (integer)source_edafla, (integer)source_edahistory, (integer)source_edala, (integer)source_edalfa, (integer)source_exp, (integer)source_inf, (integer)source_input, (integer)source_md, (integer)source_ne, (integer)source_paw, (integer)source_pde, (integer)source_pf, (integer)source_pffla, (integer)source_pfla, (integer)source_ppca, (integer)source_ppdid, (integer)source_ppfa, (integer)source_ppfla, (integer)source_ppla, (integer)source_pplfa, (integer)source_ppth, (integer)source_rel, (integer)source_rm, (integer)source_sp, (integer)source_sx, (integer)source_utildid));

source_cr_lseen2 := Models.common.sas_date((string)(source_cr_lseen));

mth_source_cr_lseen := if(min(sysdate, source_cr_lseen2) = NULL, NULL, roundup((sysdate - source_cr_lseen2) / 30.5));

source_cr_fseen2 := Models.common.sas_date((string)(source_cr_fseen));

mth_source_cr_fseen := if(min(sysdate, source_cr_fseen2) = NULL, NULL, roundup((sysdate - source_cr_fseen2) / 30.5));

source_edaca_fseen2 := Models.common.sas_date((string)(source_edaca_fseen));

mth_source_edaca_fseen := if(min(sysdate, source_edaca_fseen2) = NULL, NULL, roundup((sysdate - source_edaca_fseen2) / 30.5));

source_edahistory_lseen2 := Models.common.sas_date((string)(source_edahistory_lseen));

mth_source_edahistory_lseen := if(min(sysdate, source_edahistory_lseen2) = NULL, NULL, roundup((sysdate - source_edahistory_lseen2) / 30.5));

source_exp_lseen2 := Models.common.sas_date((string)(source_exp_lseen));

mth_source_exp_lseen := if(min(sysdate, source_exp_lseen2) = NULL, NULL, roundup((sysdate - source_exp_lseen2) / 30.5));

source_exp_fseen2 := Models.common.sas_date((string)(source_exp_fseen));

mth_source_exp_fseen := if(min(sysdate, source_exp_fseen2) = NULL, NULL, roundup((sysdate - source_exp_fseen2) / 30.5));

source_inf_fseen2 := Models.common.sas_date((string)(source_inf_fseen));

mth_source_inf_fseen := if(min(sysdate, source_inf_fseen2) = NULL, NULL, roundup((sysdate - source_inf_fseen2) / 30.5));

source_md_lseen2 := Models.common.sas_date((string)(source_md_lseen));

mth_source_md_lseen := if(min(sysdate, source_md_lseen2) = NULL, NULL, roundup((sysdate - source_md_lseen2) / 30.5));

source_md_fseen2 := Models.common.sas_date((string)(source_md_fseen));

mth_source_md_fseen := if(min(sysdate, source_md_fseen2) = NULL, NULL, roundup((sysdate - source_md_fseen2) / 30.5));

source_paw_lseen2 := Models.common.sas_date((string)(source_paw_lseen));

mth_source_paw_lseen := if(min(sysdate, source_paw_lseen2) = NULL, NULL, roundup((sysdate - source_paw_lseen2) / 30.5));

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

source_ppla_lseen2 := Models.common.sas_date((string)(source_ppla_lseen));

mth_source_ppla_lseen := if(min(sysdate, source_ppla_lseen2) = NULL, NULL, roundup((sysdate - source_ppla_lseen2) / 30.5));

source_ppla_fseen2 := Models.common.sas_date((string)(source_ppla_fseen));

mth_source_ppla_fseen := if(min(sysdate, source_ppla_fseen2) = NULL, NULL, roundup((sysdate - source_ppla_fseen2) / 30.5));

source_ppth_lseen2 := Models.common.sas_date((string)(source_ppth_lseen));

mth_source_ppth_lseen := if(min(sysdate, source_ppth_lseen2) = NULL, NULL, roundup((sysdate - source_ppth_lseen2) / 30.5));

source_ppth_fseen2 := Models.common.sas_date((string)(source_ppth_fseen));

mth_source_ppth_fseen := if(min(sysdate, source_ppth_fseen2) = NULL, NULL, roundup((sysdate - source_ppth_fseen2) / 30.5));

source_rm_lseen2 := Models.common.sas_date((string)(source_rm_lseen));

mth_source_rm_lseen := if(min(sysdate, source_rm_lseen2) = NULL, NULL, roundup((sysdate - source_rm_lseen2) / 30.5));

source_rm_fseen2 := Models.common.sas_date((string)(source_rm_fseen));

mth_source_rm_fseen := if(min(sysdate, source_rm_fseen2) = NULL, NULL, roundup((sysdate - source_rm_fseen2) / 30.5));

source_sx_fseen2 := Models.common.sas_date((string)(source_sx_fseen));

mth_source_sx_fseen := if(min(sysdate, source_sx_fseen2) = NULL, NULL, roundup((sysdate - source_sx_fseen2) / 30.5));

source_ne_fseen2 := Models.common.sas_date((string)(source_ne_fseen));

mth_source_ne_fseen := if(min(sysdate, source_ne_fseen2) = NULL, NULL, roundup((sysdate - source_ne_fseen2) / 30.5));

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

pp_datevendorlastseen2 := Models.common.sas_date((string)(pp_datevendorlastseen));

mth_pp_datevendorlastseen := if(min(sysdate, pp_datevendorlastseen2) = NULL, NULL, roundup((sysdate - pp_datevendorlastseen2) / 30.5));

pp_orig_lastseen2 := Models.common.sas_date((string)(pp_orig_lastseen));

mth_pp_orig_lastseen := if(min(sysdate, pp_orig_lastseen2) = NULL, NULL, roundup((sysdate - pp_orig_lastseen2) / 30.5));

pp_app_npa_effective_dt2 := Models.common.sas_date((string)(pp_app_npa_effective_dt));

mth_pp_app_npa_effective_dt := if(min(sysdate, pp_app_npa_effective_dt2) = NULL, NULL, roundup((sysdate - pp_app_npa_effective_dt2) / 30.5));

pp_app_npa_last_change_dt2 := Models.common.sas_date((string)(pp_app_npa_last_change_dt));

mth_pp_app_npa_last_change_dt := if(min(sysdate, pp_app_npa_last_change_dt2) = NULL, NULL, roundup((sysdate - pp_app_npa_last_change_dt2) / 30.5));

pp_eda_hist_did_dt2 := Models.common.sas_date((string)(PP_EDA_Hist_did_dt));

mth_pp_eda_hist_did_dt := if(min(sysdate, pp_eda_hist_did_dt2) = NULL, NULL, roundup((sysdate - pp_eda_hist_did_dt2) / 30.5));

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

_pp_rule_port_neustar_1 := 0;

_pp_rule_high_vend_conf_1 := 0;

_pp_rule_cellphone_latest_1 := 0;

_pp_rule_med_vend_conf_cell_1 := 0;

_pp_rule_gong_disc_1 := 0;

_pp_rule_consort_disc_1 := 0;

_pp_rule_iq_wrong_party_1 := 0;

_pp_rule_f1_ver_above_1 := 0;

_pp_rule_disconnected_eda := if((pp_rules)[3..3] = '1', 1, _pp_rule_disconnected_eda_1);

_pp_rule_port_neustar := if((pp_rules)[5..5] = '1', 1, _pp_rule_port_neustar_1);

_pp_rule_high_vend_conf := if((pp_rules)[7..7] = '1', 1, _pp_rule_high_vend_conf_1);

_pp_rule_cellphone_latest := if((pp_rules)[9..9] = '1', 1, _pp_rule_cellphone_latest_1);

_pp_rule_med_vend_conf_cell := if((pp_rules)[15..15] = '1', 1, _pp_rule_med_vend_conf_cell_1);

_pp_rule_gong_disc := if((pp_rules)[21..21] = '1', 1, _pp_rule_gong_disc_1);

_pp_rule_consort_disc := if((pp_rules)[22..22] = '1', 1, _pp_rule_consort_disc_1);

_pp_rule_iq_wrong_party := if((pp_rules)[24..24] = '1', 1, _pp_rule_iq_wrong_party_1);

_pp_rule_f1_ver_above := if((pp_rules)[28..28] = '1', 1, _pp_rule_f1_ver_above_1);

_pp_src_all_uw_1 := 0;

_pp_src_all_uw := if((pp_src_all)[14..14] = '1', 1, _pp_src_all_uw_1);

_pp_srule_port_neustar_1 := 0;

_pp_srule_port_neustar := if((pp_src_rule)[5..5] = '1', 1, _pp_srule_port_neustar_1);

_pp_app_ported_match_10_1 := 0;

_pp_app_ported_match_10 := if((PP_app_Ported_Match)[1..1] = '1', 1, _pp_app_ported_match_10_1);

inq_lastseen_n := if(inq_lastseen='',NULL,(integer)inq_lastseen);

inq_adl_firstseen_n := if(inq_adl_firstseen='',NULL,(integer)inq_adl_firstseen);

inq_adl_lastseen_n := if(inq_adl_lastseen='',NULL,(integer)inq_adl_lastseen);

internal_ver_match_type := ' ';

_internal_ver_match_hhid := (integer)indexw(trim(internal_ver_match_types, ALL), '3', ',') > 0;

_inq_adl_ph_industry_flag := trim(StringLib.StringFilterOut((string)inq_adl_ph_industry_list_12, ','), LEFT, RIGHT) != '';

_phone_disconnected := if(phone_disconnected < 1, 0, 1);

_phone_zip_match := if(phone_zip_match < 1, 0, 1);

_phone_timezone_match := if(phone_timezone_match < 1, 0, 1);

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

_pp_app_nxx_type_cell := if((trim(pp_app_nxx_type,left,right) in ['04', '55', '65']), 1, 0);

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

pk_cell_flag := if(pk_cell_indicator > 0, 1, 0);

pk_exp_hit := if(exp_verified = 0 
                  and trim(trim((string)exp_type, LEFT), LEFT, RIGHT) = '' 
                  and trim(trim((string)exp_source, LEFT), LEFT, RIGHT) = '' 
                  and trim(trim((string)exp_last_update, LEFT), LEFT, RIGHT) = '' 
                  and trim(exp_ph_score_v1) = '', 
                 0, 
                 1);

segment := map(
    pk_exp_hit = 1          => '3 - ExpHit      ',
    pk_cell_flag = 1        => '2 - Cell Phone  ',
    _phone_disconnected = 1 => '0 - Disconnected',
                               '1 - Other       ');

add_input_pop := add1_pop;

add_curr_pop := if(add1_isbestmatch, add1_pop, add2_pop);

add_input_address_score := if(add1_isbestmatch, add1_address_score, add2_address_score);

add_curr_naprop := if(add1_isbestmatch, add1_naprop, add2_naprop);

add_input_avm_auto_val := add1_avm_automated_valuation;

add_curr_avm_auto_val := if(add1_isbestmatch, add1_avm_automated_valuation, add2_avm_automated_valuation);

add_curr_lres := if(add1_isbestmatch, add1_lres, add2_lres);

add_curr_avm_auto_val_2 := if(add1_isbestmatch, add1_avm_automated_valuation_2, add2_avm_automated_valuation_2);

add_input_naprop := add1_naprop;

add_prev_naprop := if(add1_isbestmatch, add2_naprop, add3_naprop);

add_input_nhood_bus_ct := add1_Nhood_Business_count;

add_input_nhood_sfd_ct := add1_Nhood_SFD_count;

add_input_nhood_mfd_ct := add1_Nhood_MFD_count;

add_curr_occupants_1yr := if(add1_isbestmatch, add1_occupants_1yr, add2_occupants_1yr);

add_curr_turnover_1yr_in := if(add1_isbestmatch, add1_turnover_1yr_in, add2_turnover_1yr_in);

add_curr_turnover_1yr_out := if(add1_isbestmatch, add1_turnover_1yr_in, add2_turnover_1yr_in);

add_curr_nhood_bus_ct := if(add1_isbestmatch, add1_Nhood_Business_count, add2_Nhood_Business_count);

add_curr_nhood_sfd_ct := if(add1_isbestmatch, add1_Nhood_SFD_count, add2_Nhood_SFD_count);

add_curr_nhood_mfd_ct := if(add1_isbestmatch, add1_Nhood_MFD_count, add2_Nhood_MFD_count);

r_f01_inp_addr_address_score_d := if(not(truedid and add_input_pop) or add_input_address_score = 255, NULL, min(if(add_input_address_score = NULL, -NULL, add_input_address_score), 999));

_criminal_last_date := Models.common.sas_date((string)(criminal_last_date));

r_d32_mos_since_crim_ls_d := map(
    not(truedid)               => NULL,
    _criminal_last_date = NULL => 241,
                                  max(3, min(if(if ((sysdate - _criminal_last_date) / (365.25 / 12) >= 0, truncate((sysdate - _criminal_last_date) / (365.25 / 12)), roundup((sysdate - _criminal_last_date) / (365.25 / 12))) = NULL, -NULL, if ((sysdate - _criminal_last_date) / (365.25 / 12) >= 0, truncate((sysdate - _criminal_last_date) / (365.25 / 12)), roundup((sysdate - _criminal_last_date) / (365.25 / 12)))), 240)));

r_d31_attr_bankruptcy_recency_d := map(
    not(truedid)                 => NULL,
    attr_bankruptcy_count30 > 0  => 1,
    attr_bankruptcy_count90 > 0  => 3,
    attr_bankruptcy_count180 > 0 => 6,
    attr_bankruptcy_count12 > 0  => 12,
    attr_bankruptcy_count24 > 0  => 24,
    attr_bankruptcy_count36 > 0  => 36,
    attr_bankruptcy_count60 > 0  => 60,
    bankrupt                     => 99,
    filing_count > 0             => 99,
                                    0);

r_d33_eviction_count_i := if(not(truedid), NULL, min(if(attr_eviction_count = NULL, -NULL, attr_eviction_count), 999));

bureau_adl_eq_fseen_pos := Models.Common.findw_cpp(ver_sources, 'EQ' , ', ', 'E');

bureau_adl_fseen_eq := if(bureau_adl_eq_fseen_pos = 0, '       0', Models.Common.getw(ver_sources_first_seen, bureau_adl_eq_fseen_pos, ','));

_bureau_adl_fseen_eq := Models.common.sas_date((string)(bureau_adl_fseen_eq));

_src_bureau_adl_fseen := min(if(_bureau_adl_fseen_eq = NULL, -NULL, _bureau_adl_fseen_eq), 999999);

r_c21_m_bureau_adl_fs_d := map(
    not(truedid)                   => NULL,
    _src_bureau_adl_fseen = 999999 => 1000,
                                      min(if(if ((sysdate - _src_bureau_adl_fseen) / (365.25 / 12) >= 0, truncate((sysdate - _src_bureau_adl_fseen) / (365.25 / 12)), roundup((sysdate - _src_bureau_adl_fseen) / (365.25 / 12))) = NULL, -NULL, if ((sysdate - _src_bureau_adl_fseen) / (365.25 / 12) >= 0, truncate((sysdate - _src_bureau_adl_fseen) / (365.25 / 12)), roundup((sysdate - _src_bureau_adl_fseen) / (365.25 / 12)))), 999));

_header_first_seen := Models.common.sas_date((string)(header_first_seen));

r_c10_m_hdr_fs_d := map(
    not(truedid)              => NULL,
    _header_first_seen = NULL => 1000,
                                 min(if(if ((sysdate - _header_first_seen) / (365.25 / 12) >= 0, truncate((sysdate - _header_first_seen) / (365.25 / 12)), roundup((sysdate - _header_first_seen) / (365.25 / 12))) = NULL, -NULL, if ((sysdate - _header_first_seen) / (365.25 / 12) >= 0, truncate((sysdate - _header_first_seen) / (365.25 / 12)), roundup((sysdate - _header_first_seen) / (365.25 / 12)))), 999));

r_a44_curr_add_naprop_d := if(not(truedid and (boolean)(integer)add_curr_pop), NULL, add_curr_naprop);

r_l80_inp_avm_autoval_d := map(
    not(add_input_pop)         => NULL,
    add_input_avm_auto_val = 0 => NULL,
                                  min(if(add_input_avm_auto_val = NULL, -NULL, add_input_avm_auto_val), 300000));

r_a46_curr_avm_autoval_d := map(
    not(truedid)              => NULL,
    add_curr_avm_auto_val = 0 => NULL,
                                 min(if(add_curr_avm_auto_val = NULL, -NULL, add_curr_avm_auto_val), 300000));

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

r_c13_curr_addr_lres_d := if(not(truedid and (boolean)(integer)add_curr_pop), NULL, min(if(add_curr_lres = NULL, -NULL, add_curr_lres), 999));

r_c13_max_lres_d := if(not(truedid), NULL, min(if(max_lres = NULL, -NULL, max_lres), 999));

r_c14_addrs_5yr_i := if(not(truedid), NULL, min(if(addrs_5yr = NULL, -NULL, addrs_5yr), 999));

r_c14_addrs_10yr_i := if(not(truedid), NULL, min(if(addrs_10yr = NULL, -NULL, addrs_10yr), 999));

r_c14_addrs_15yr_i := if(not(truedid), NULL, min(if(addrs_15yr = NULL, -NULL, addrs_15yr), 999));

r_a41_prop_owner_d := map(
    not(truedid)                                                                                   => NULL,
    add_input_naprop = 4 or add_curr_naprop = 4 or add_prev_naprop = 4 or property_owned_total > 0 => 1,
                                                                                                      0);

r_a41_prop_owner_inp_only_d := map(
    not(truedid)                                => NULL,
    add_input_naprop = 4 or add_curr_naprop = 4 => 1,
                                                   0);

r_prop_owner_history_d := map(
    not(truedid)                                                                     => NULL,
    add_input_naprop = 4 or add_curr_naprop = 4 or property_owned_total > 0          => 2,
    add_prev_naprop = 4 or Models.Common.findw_cpp(ver_sources, 'P' , ', ', 'E') > 0 => 1,
                                                                                        0);

r_a50_pb_average_dollars_d := map(
    not(truedid)              => NULL,
    pb_average_dollars = ''   => 5000,
                                 min(if(pb_average_dollars = '', -NULL, (real)pb_average_dollars), 5000));

r_pb_order_freq_d := map(
    not(truedid)                     => NULL,
    pb_number_of_sources = ''        => NULL,
    pb_average_days_bt_orders = ''   => -1,
                                        min(if(pb_average_days_bt_orders = '', -NULL, (real)pb_average_days_bt_orders), 999));

r_i60_inq_comm_recency_d := map(
    not(truedid)               => NULL,
    inq_communications_count01 > 0 => 1,
    inq_communications_count03 > 0 => 3,
    inq_communications_count06 > 0 => 6,
    inq_communications_count12 > 0 => 12,
    inq_communications_count24 > 0 => 24,
    inq_communications_count > 0   => 99,
                                      999);

f_bus_lname_verd_d := if(not(addrpop), NULL, (integer)(bus_name_match in [3, 4]));

f_util_adl_count_n := if(not(truedid), NULL, util_adl_count);

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

f_add_curr_nhood_mfd_pct_i := map(
    not(addrpop)              => NULL,
    add_curr_nhood_mfd_ct = 0 => NULL,
                                 add_curr_nhood_mfd_ct / add_curr_nhood_prop_sum);

f_inq_count_i := if(not(truedid), NULL, min(if(inq_count = NULL, -NULL, inq_count), 999));

f_inq_collection_count_i := if(not(truedid), NULL, min(if(inq_Collection_count = NULL, -NULL, inq_Collection_count), 999));

f_inq_communications_count_i := if(not(truedid), NULL, min(if(inq_Communications_count = NULL, -NULL, inq_Communications_count), 999));

f_inq_highriskcredit_count24_i := if(not(truedid), NULL, min(if(inq_HighRiskCredit_count24 = NULL, -NULL, inq_HighRiskCredit_count24), 999));

f_inq_other_count_i := if(not(truedid), NULL, min(if(inq_Other_count = NULL, -NULL, inq_Other_count), 999));

_inq_banko_cm_last_seen := Models.common.sas_date((string)(Inq_banko_cm_last_seen));

f_mos_inq_banko_cm_lseen_d := map(
    not(truedid)                   => NULL,
    _inq_banko_cm_last_seen = NULL => 1000,
                                      max(3, min(if(if ((sysdate - _inq_banko_cm_last_seen) / (365.25 / 12) >= 0, truncate((sysdate - _inq_banko_cm_last_seen) / (365.25 / 12)), roundup((sysdate - _inq_banko_cm_last_seen) / (365.25 / 12))) = NULL, -NULL, if ((sysdate - _inq_banko_cm_last_seen) / (365.25 / 12) >= 0, truncate((sysdate - _inq_banko_cm_last_seen) / (365.25 / 12)), roundup((sysdate - _inq_banko_cm_last_seen) / (365.25 / 12)))), 999)));

_inq_banko_om_last_seen := Models.common.sas_date((string)(Inq_banko_om_last_seen));

f_mos_inq_banko_om_lseen_d := map(
    not(truedid)                   => NULL,
    _inq_banko_om_last_seen = NULL => 1000,
                                      max(3, min(if(if ((sysdate - _inq_banko_om_last_seen) / (365.25 / 12) >= 0, truncate((sysdate - _inq_banko_om_last_seen) / (365.25 / 12)), roundup((sysdate - _inq_banko_om_last_seen) / (365.25 / 12))) = NULL, -NULL, if ((sysdate - _inq_banko_om_last_seen) / (365.25 / 12) >= 0, truncate((sysdate - _inq_banko_om_last_seen) / (365.25 / 12)), roundup((sysdate - _inq_banko_om_last_seen) / (365.25 / 12)))), 999)));

_liens_unrel_cj_last_seen := Models.common.sas_date((string)(liens_unrel_CJ_last_seen));

f_mos_liens_unrel_cj_lseen_d := map(
    not(truedid)                     => NULL,
    _liens_unrel_cj_last_seen = NULL => 1000,
                                        max(3, min(if(if ((sysdate - _liens_unrel_cj_last_seen) / (365.25 / 12) >= 0, truncate((sysdate - _liens_unrel_cj_last_seen) / (365.25 / 12)), roundup((sysdate - _liens_unrel_cj_last_seen) / (365.25 / 12))) = NULL, -NULL, if ((sysdate - _liens_unrel_cj_last_seen) / (365.25 / 12) >= 0, truncate((sysdate - _liens_unrel_cj_last_seen) / (365.25 / 12)), roundup((sysdate - _liens_unrel_cj_last_seen) / (365.25 / 12)))), 999)));

f_liens_unrel_cj_total_amt_i := if(not(truedid), NULL, liens_unrel_CJ_total_amount);

f_liens_rel_cj_total_amt_i := if(not(truedid), NULL, liens_rel_CJ_total_amount);

f_liens_unrel_o_total_amt_i := if(not(truedid), NULL, liens_unrel_O_total_amount);

_liens_unrel_ot_first_seen := Models.common.sas_date((string)(liens_unrel_OT_first_seen));

f_mos_liens_unrel_ot_fseen_d := map(
    not(truedid)                      => NULL,
    _liens_unrel_ot_first_seen = NULL => 1000,
                                         min(if(if ((sysdate - _liens_unrel_ot_first_seen) / (365.25 / 12) >= 0, truncate((sysdate - _liens_unrel_ot_first_seen) / (365.25 / 12)), roundup((sysdate - _liens_unrel_ot_first_seen) / (365.25 / 12))) = NULL, -NULL, if ((sysdate - _liens_unrel_ot_first_seen) / (365.25 / 12) >= 0, truncate((sysdate - _liens_unrel_ot_first_seen) / (365.25 / 12)), roundup((sysdate - _liens_unrel_ot_first_seen) / (365.25 / 12)))), 999));

f_wealth_index_d := if(not(truedid), NULL, (integer)wealth_index);

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

f_rel_homeover50_count_d := map(
    not(truedid)  => NULL,
    rel_count = 0 => NULL,
                     if(max(rel_homeunder100_count, rel_homeunder150_count, rel_homeunder200_count, rel_homeunder300_count, rel_homeunder500_count, rel_homeover500_count) = NULL, NULL, sum(if(rel_homeunder100_count = NULL, 0, rel_homeunder100_count), if(rel_homeunder150_count = NULL, 0, rel_homeunder150_count), if(rel_homeunder200_count = NULL, 0, rel_homeunder200_count), if(rel_homeunder300_count = NULL, 0, rel_homeunder300_count), if(rel_homeunder500_count = NULL, 0, rel_homeunder500_count), if(rel_homeover500_count = NULL, 0, rel_homeover500_count))));

f_rel_homeover100_count_d := map(
    not(truedid)  => NULL,
    rel_count = 0 => NULL,
                     if(max(rel_homeunder200_count, rel_homeunder300_count, rel_homeunder500_count, rel_homeover500_count) = NULL, NULL, sum(if(rel_homeunder200_count = NULL, 0, rel_homeunder200_count), if(rel_homeunder300_count = NULL, 0, rel_homeunder300_count), if(rel_homeunder500_count = NULL, 0, rel_homeunder500_count), if(rel_homeover500_count = NULL, 0, rel_homeover500_count))));

f_rel_ageover40_count_d := map(
    not(truedid)  => NULL,
    rel_count = 0 => NULL,
                     if(max(rel_ageunder50_count, rel_ageunder60_count, rel_ageunder70_count, rel_ageover70_count) = NULL, NULL, sum(if(rel_ageunder50_count = NULL, 0, rel_ageunder50_count), if(rel_ageunder60_count = NULL, 0, rel_ageunder60_count), if(rel_ageunder70_count = NULL, 0, rel_ageunder70_count), if(rel_ageover70_count = NULL, 0, rel_ageover70_count))));

f_rel_ageover50_count_d := map(
    not(truedid)  => NULL,
    rel_count = 0 => NULL,
                     if(max(rel_ageunder60_count, rel_ageunder70_count, rel_ageover70_count) = NULL, NULL, sum(if(rel_ageunder60_count = NULL, 0, rel_ageunder60_count), if(rel_ageunder70_count = NULL, 0, rel_ageunder70_count), if(rel_ageover70_count = NULL, 0, rel_ageover70_count))));

f_crim_rel_under500miles_cnt_i := map(
    not(truedid)  => NULL,
    rel_count = 0 => NULL,
                     if(max(crim_rel_within25miles, crim_rel_within100miles, crim_rel_within500miles) = NULL, NULL, sum(if(crim_rel_within25miles = NULL, 0, crim_rel_within25miles), if(crim_rel_within100miles = NULL, 0, crim_rel_within100miles), if(crim_rel_within500miles = NULL, 0, crim_rel_within500miles))));

f_rel_under25miles_cnt_d := map(
    not(truedid)  => NULL,
    rel_count = 0 => NULL,
                     rel_within25miles_count);

f_rel_under500miles_cnt_d := map(
    not(truedid)  => NULL,
    rel_count = 0 => NULL,
                     if(max(rel_within25miles_count, rel_within100miles_count, rel_within500miles_count) = NULL, NULL, sum(if(rel_within25miles_count = NULL, 0, rel_within25miles_count), if(rel_within100miles_count = NULL, 0, rel_within100miles_count), if(rel_within500miles_count = NULL, 0, rel_within500miles_count))));

f_rel_criminal_count_i := map(
    not(truedid)  => NULL,
    rel_count = 0 => -1,
                     min(if(rel_criminal_count = NULL, -NULL, rel_criminal_count), 999));

f_idrisktype_i := if(not(truedid) or fp_idrisktype = '', NULL, (integer)fp_idrisktype);

f_sourcerisktype_i := map(
    not(truedid)             => NULL,
    fp_sourcerisktype = ''   => NULL,
                                (integer)fp_sourcerisktype);

f_varrisktype_i := map(
    not(truedid)          => NULL,
    fp_varrisktype = ''   => NULL,
                             (integer)fp_varrisktype);

f_srchvelocityrisktype_i := map(
    not(truedid)                   => NULL,
    fp_srchvelocityrisktype = ''   => NULL,
                                      (integer)fp_srchvelocityrisktype);

f_srchunvrfdphonecount_i := if(not(truedid), NULL, 
                               min(if(fp_srchunvrfdphonecount = '', -NULL, (integer)fp_srchunvrfdphonecount), 999));

f_srchfraudsrchcount_i := if(not(truedid), NULL, 
                             min(if(fp_srchfraudsrchcount = '', -NULL, (integer)fp_srchfraudsrchcount), 999));

f_assocsuspicousidcount_i := if(not(truedid), NULL, 
                                min(if(fp_assocsuspicousidcount = '', -NULL, (integer)fp_assocsuspicousidcount), 999));

f_corrrisktype_i := map(
    not(truedid)           => NULL,
    fp_corrrisktype = ''   => NULL,
                              (integer)fp_corrrisktype);

f_corrssnnamecount_d := if(not(truedid), NULL, 
                           min(if(fp_corrssnnamecount = '', -NULL, (integer)fp_corrssnnamecount), 999));

f_corraddrnamecount_d := if(not(truedid), NULL, 
                            min(if(fp_corraddrnamecount = '', -NULL, (integer)fp_corraddrnamecount), 999));

f_srchaddrsrchcount_i := if(not(truedid), NULL, 
                            min(if(fp_srchaddrsrchcount = '', -NULL, (integer)fp_srchaddrsrchcount), 999));

f_inputaddractivephonelist_d := map(
    not(truedid)                       => NULL,
    fp_inputaddractivephonelist = '-1' => NULL,
                                          (integer)fp_inputaddractivephonelist);

f_addrchangevaluediff_d := map(
    not(truedid)                  => NULL,
    fp_addrchangevaluediff = '-1' => NULL,
                                     (integer)fp_addrchangevaluediff);

f_addrchangecrimediff_i := map(
    not(truedid)                  => NULL,
    fp_addrchangecrimediff = '-1' => NULL,
                                     (integer)fp_addrchangecrimediff);

f_curraddrmedianincome_d := if(not(truedid), NULL, (integer)fp_curraddrmedianincome);

f_curraddrmurderindex_i := if(not(truedid), NULL, (integer)fp_curraddrmurderindex);

f_curraddrcartheftindex_i := if(not(truedid), NULL, (integer)fp_curraddrcartheftindex);

f_curraddrcrimeindex_i := if(not(truedid), NULL, (integer)fp_curraddrcrimeindex);

f_prevaddrageoldest_d := if(not(truedid), NULL, min(if(fp_prevaddrageoldest = '', -NULL, (integer)fp_prevaddrageoldest), 999));

f_prevaddrlenofres_d := if(not(truedid), NULL, min(if(fp_prevaddrlenofres = '', -NULL, (integer)fp_prevaddrlenofres), 999));

f_prevaddrdwelltype_apt_n := if(not(truedid), NULL, (integer)(fp_prevaddrdwelltype = 'H'));

f_prevaddrmedianincome_d := if(not(truedid), NULL, (integer)fp_prevaddrmedianincome);

f_prevaddrmedianvalue_d := if(not(truedid), NULL, (integer)fp_prevaddrmedianvalue);

f_fp_prevaddrcrimeindex_i := if(not(truedid), NULL, (integer)fp_prevaddrcrimeindex);

r_paw_dead_business_ct_i := if(not(truedid), NULL, paw_dead_business_count);

r_paw_active_phone_ct_d := if(not(truedid), NULL, paw_active_phone_count);

r_c13_avg_lres_d := if(not(truedid), NULL, avg_lres);

_mod_disc_exp_v01_w := map(
    pk_disconnect_flag = NULL => 0,
    pk_disconnect_flag <= 0.5 => -0.375404170256296,
    pk_disconnect_flag <= 1.5 => 0.52455106225149,
                                 1.3694915751986);

_mod_disc_exp_v02_w := map(
    eda_pfrd_address_ind = ''                    => 0,
    (eda_pfrd_address_ind in ['1A'])             => -0.621627356816839,
    (eda_pfrd_address_ind in ['1B', '1E', '1D']) => -1.52802553536767,
    (eda_pfrd_address_ind in ['1C'])             => -1.01307910823737,
    (eda_pfrd_address_ind in ['XX'])             => 0.217521470171601,
                                                    0);

_mod_disc_exp_v03_w := map(
    pk_cell_indicator = NULL  => 0,
    pk_cell_indicator <= -0.5 => 0.726360138856706,
    pk_cell_indicator <= 2.5  => -0.154261315576182,
    pk_cell_indicator <= 3.5  => -0.396245715610412,
                                 -0.513946823907905);

_mod_disc_exp_v04_w := map(
    _pp_rule_high_vend_conf = NULL => 0,
    _pp_rule_high_vend_conf <= 0.5 => 0.123492290842009,
                                      -0.765232578785142);

_mod_disc_exp_v05_w := map(
    inq_lastseen_n = NULL          => 0,
    (real)inq_lastseen_n <= 2.5  => -0.95586867717203,
    (real)inq_lastseen_n <= 4.5  => -0.831122710237607,
    (real)inq_lastseen_n <= 6.5  => -0.777406499526008,
    (real)inq_lastseen_n <= 10.5 => -0.631963950023645,
    (real)inq_lastseen_n <= 12.5 => -0.525518704321957,
    (real)inq_lastseen_n <= 14.5 => -0.467822286955292,
    (real)inq_lastseen_n <= 20.5 => -0.356624518478402,
    (real)inq_lastseen_n <= 40.5 => -0.170542091320576,
    (real)inq_lastseen_n <= 58.5 => 0.0838150516218629,
                                    0.328191778558764);

_mod_disc_exp_v06_w := map(
    _pp_rule_port_neustar = NULL => 0,
    _pp_rule_port_neustar <= 0.5 => 0.0167016869412586,
                                    -4.85312882098508);

_mod_disc_exp_v07_w := map(
    mth_exp_last_update = NULL   => 0,
    mth_exp_last_update <= 6.5   => -0.592091691062843,
    mth_exp_last_update <= 19.5  => -0.431657668119702,
    mth_exp_last_update <= 37.5  => -0.229749925709727,
    mth_exp_last_update <= 56.5  => -0.00882666168155297,
    mth_exp_last_update <= 86.5  => 0.187268610507591,
    mth_exp_last_update <= 130.5 => 0.464963968401716,
                                    0.811704827578882);

_mod_disc_exp_v08_w := map(
    mth_source_ppdid_lseen = NULL  => 0,
    mth_source_ppdid_lseen <= 0.5  => -0.878202316663242,
    mth_source_ppdid_lseen <= 2.5  => -0.654715149349585,
    mth_source_ppdid_lseen <= 6.5  => -0.53979334175861,
    mth_source_ppdid_lseen <= 13.5 => -0.44827036105205,
    mth_source_ppdid_lseen <= 20.5 => -0.196426046689239,
    mth_source_ppdid_lseen <= 32.5 => 0.0683744757780947,
    mth_source_ppdid_lseen <= 41.5 => 0.151179606133854,
    mth_source_ppdid_lseen <= 77.5 => 0.344725818212203,
                                      0.699016826750109);

_mod_disc_exp_v09_w := map(
    mth_source_exp_fseen = NULL  => 0,
    mth_source_exp_fseen <= 1.5  => -1.40776834005628,
    mth_source_exp_fseen <= 2.5  => -1.31939250323783,
    mth_source_exp_fseen <= 6.5  => -1.10493485430552,
    mth_source_exp_fseen <= 12.5 => -0.839754113160298,
                                    -0.587979681197953);

_mod_disc_exp_v10_w := map(
    mth_source_md_lseen = NULL => 0,
    mth_source_md_lseen <= 1.5 => -0.399825375601331,
                                  -0.178367395054651);

_mod_disc_exp_v11_w := map(
    mth_pp_datelastseen = NULL  => 0,
    mth_pp_datelastseen <= 0.5  => -0.313083544026956,
    mth_pp_datelastseen <= 1.5  => -0.189419768944152,
    mth_pp_datelastseen <= 12.5 => -0.130121872438185,
    mth_pp_datelastseen <= 20.5 => 0.0131004205533009,
    mth_pp_datelastseen <= 29.5 => 0.15456435011073,
    mth_pp_datelastseen <= 39.5 => 0.212591579047442,
    mth_pp_datelastseen <= 58.5 => 0.372016983455488,
    mth_pp_datelastseen <= 76.5 => 0.451364961789709,
                                   0.670305979695463);

_mod_disc_exp_v12_w := map(
    _pp_rule_cellphone_latest = NULL => 0,
    _pp_rule_cellphone_latest <= 0.5 => 0.0670136194819055,
                                        -0.274023567924293);

_mod_disc_exp_v13_w := map(
    _pp_rule_f1_ver_above = NULL => 0,
    _pp_rule_f1_ver_above <= 0.5 => 0.0504300859261435,
                                    -0.322175385394378);

_mod_disc_exp_v14_w := map(
    (integer)_inq_adl_ph_industry_flag = NULL => 0,
    (integer)_inq_adl_ph_industry_flag <= 0.5    => 0.0432720095588201,
                                                 -0.911792876403879);

_mod_disc_exp_v15_w := map(
    _phone_fb_rp_result_disc = NULL => 0,
    _phone_fb_rp_result_disc <= 0.5 => -0.0439857999590749,
                                       1.1724682570618);

_mod_disc_exp_v16_w := map(
    f_inq_highriskcredit_count24_i = NULL => 0,
    f_inq_highriskcredit_count24_i <= 0.5 => -0.0136405148986956,
                                             0.0607263551948884);

_mod_disc_exp_v17_w := map(
    _pp_src_all_uw = NULL => 0,
    _pp_src_all_uw <= 0.5 => 0.0437798838048096,
                             -0.876293740151649);

_mod_disc_exp_v18_w := map(
    mth_source_utildid_fseen = NULL  => 0,
    mth_source_utildid_fseen <= 7.5  => -0.665171108411968,
    mth_source_utildid_fseen <= 14.5 => -0.406780457827425,
    mth_source_utildid_fseen <= 24.5 => -0.334760854715456,
    mth_source_utildid_fseen <= 29.5 => -0.240141753411244,
    mth_source_utildid_fseen <= 42.5 => -0.103836331027055,
    mth_source_utildid_fseen <= 79.5 => 0.0418906930951823,
                                        0.397357476946853);

_mod_disc_exp_v19_w := map(
    mth_source_ppla_lseen = NULL  => 0,
    mth_source_ppla_lseen <= 1.5  => -0.873548185124707,
    mth_source_ppla_lseen <= 12.5 => -0.722857683180128,
    mth_source_ppla_lseen <= 36.5 => -0.216611732504324,
    mth_source_ppla_lseen <= 75.5 => 0.225628247614856,
                                     0.728036907128784);

_mod_disc_exp_v20_w := map(
    eda_address_match_best = NULL => 0,
    eda_address_match_best <= 0.5 => 0.0100268383832486,
                                     -0.238675002407799);

_mod_disc_exp_v21_w := map(
    f_srchfraudsrchcount_i = NULL => 0,
    f_srchfraudsrchcount_i <= 2.5 => -0.0417831656831419,
    f_srchfraudsrchcount_i <= 9.5 => 0.0221412961126737,
                                     0.10224133856207);

_mod_disc_exp_v22_w := map(
    r_c14_addrs_5yr_i = NULL => 0,
    r_c14_addrs_5yr_i <= 0.5 => -0.156968912373735,
    r_c14_addrs_5yr_i <= 1.5 => -0.0391650476473132,
    r_c14_addrs_5yr_i <= 3.5 => 0.0395060964994791,
                                0.14425142496035);

_mod_disc_exp_v23_w := map(
    f_mos_inq_banko_cm_lseen_d = NULL  => 0,
    f_mos_inq_banko_cm_lseen_d <= 29.5 => 0.103736567991188,
    f_mos_inq_banko_cm_lseen_d <= 86.5 => 0.0425810253865398,
                                          -0.115988128251368);

_mod_disc_exp_v24_w := map(
    r_c10_m_hdr_fs_d = NULL   => 0,
    r_c10_m_hdr_fs_d <= 324.5 => 0.0551765927023692,
                                 -0.0825145730585828);

_mod_disc_exp_v25_w := map(
    f_inq_communications_count_i = NULL => 0,
    f_inq_communications_count_i <= 0.5 => -0.0752262640914363,
    f_inq_communications_count_i <= 2.5 => 0.106066757325898,
    f_inq_communications_count_i <= 5.5 => 0.198447368809212,
                                           0.325225039525038);

_mod_disc_exp_v26_w := map(
    f_wealth_index_d = NULL => 0,
    f_wealth_index_d <= 4.5 => 0.0198609248243876,
                               -0.188455755826124);

_mod_disc_exp_v27_w := map(
    f_mos_inq_banko_om_lseen_d = NULL  => 0,
    f_mos_inq_banko_om_lseen_d <= 10.5 => 0.151325596814171,
    f_mos_inq_banko_om_lseen_d <= 44.5 => 0.0729592762426577,
                                          -0.0449545464560864);

_mod_disc_exp_v28_w := map(
    r_c13_avg_lres_d = NULL   => 0,
    r_c13_avg_lres_d <= 30.5  => 0.0924449070794963,
    r_c13_avg_lres_d <= 80.5  => 0.049344767678098,
    r_c13_avg_lres_d <= 128.5 => 0.00198388756863696,
    r_c13_avg_lres_d <= 232.5 => -0.0577246775160423,
                                 -0.187073231872619);

_mod_disc_exp_v29_w := map(
    mth_source_ppfla_lseen = NULL  => 0,
    mth_source_ppfla_lseen <= 2.5  => -0.205182346776516,
    mth_source_ppfla_lseen <= 12.5 => -0.161018369758886,
    mth_source_ppfla_lseen <= 31.5 => -0.0653849314884957,
    mth_source_ppfla_lseen <= 77.5 => 0.0255031968901682,
                                      0.132443247493674);

_mod_disc_exp_v30_w := map(
    r_a44_curr_add_naprop_d = NULL => 0,
    r_a44_curr_add_naprop_d <= 1.5 => 0.0573690678639938,
    r_a44_curr_add_naprop_d <= 3.5 => -0.0425618194365372,
                                      -0.167770746729028);

_mod_disc_exp_v31_w := map(
    inq_num_adls_06 = ''         => 0,
    (real)inq_num_adls_06 <= 0.5 => 0.0326064045832189,
                                    -0.471983107529666);

_mod_disc_exp_v32_w := map(
    r_i60_inq_comm_recency_d = NULL => 0,
    r_i60_inq_comm_recency_d <= 549 => 0.0508761137540712,
                                       -0.0251313276774479);

_mod_disc_exp_v33_w := map(
    r_a41_prop_owner_d = NULL => 0,
    r_a41_prop_owner_d <= 0.5 => 0.0501326981648325,
                                 -0.0616189822612724);

_mod_disc_exp_v34_w := map(
    r_c14_addrs_15yr_i = NULL  => 0,
    r_c14_addrs_15yr_i <= 0.5  => -0.117570613269883,
    r_c14_addrs_15yr_i <= 1.5  => -0.0771366530361544,
    r_c14_addrs_15yr_i <= 4.5  => -0.0375874662649246,
    r_c14_addrs_15yr_i <= 10.5 => 0.00711503927569531,
                                  0.0432154562142062);

_mod_disc_exp_v35_w := map(
    f_srchvelocityrisktype_i = NULL => 0,
    f_srchvelocityrisktype_i <= 1.5 => -0.0292971583462784,
    f_srchvelocityrisktype_i <= 5.5 => -0.0160847590346756,
                                       0.0262437926593329);

_mod_disc_exp_v36_w := map(
    r_prop_owner_history_d = NULL => 0,
    r_prop_owner_history_d <= 0.5 => 0.02332701007113,
                                     -0.0203668244180371);

_mod_disc_exp_v37_w := map(
    _pp_srule_port_neustar = NULL => 0,
    _pp_srule_port_neustar <= 0.5 => 1.16230973670445e-05,
                                     -0.00337740666673452);

_mod_disc_exp_v38_w := map(
    _pp_app_ported_match_10 = NULL => 0,
    _pp_app_ported_match_10 <= 0.5 => 1.21888061788532e-05,
                                      -0.00354178872876991);

_mod_disc_exp_lgt := 2.14303850154752 +
    _mod_disc_exp_v01_w +
    _mod_disc_exp_v02_w +
    _mod_disc_exp_v03_w +
    _mod_disc_exp_v04_w +
    _mod_disc_exp_v05_w +
    _mod_disc_exp_v06_w +
    _mod_disc_exp_v07_w +
    _mod_disc_exp_v08_w +
    _mod_disc_exp_v09_w +
    _mod_disc_exp_v10_w +
    _mod_disc_exp_v11_w +
    _mod_disc_exp_v12_w +
    _mod_disc_exp_v13_w +
    _mod_disc_exp_v14_w +
    _mod_disc_exp_v15_w +
    _mod_disc_exp_v16_w +
    _mod_disc_exp_v17_w +
    _mod_disc_exp_v18_w +
    _mod_disc_exp_v19_w +
    _mod_disc_exp_v20_w +
    _mod_disc_exp_v21_w +
    _mod_disc_exp_v22_w +
    _mod_disc_exp_v23_w +
    _mod_disc_exp_v24_w +
    _mod_disc_exp_v25_w +
    _mod_disc_exp_v26_w +
    _mod_disc_exp_v27_w +
    _mod_disc_exp_v28_w +
    _mod_disc_exp_v29_w +
    _mod_disc_exp_v30_w +
    _mod_disc_exp_v31_w +
    _mod_disc_exp_v32_w +
    _mod_disc_exp_v33_w +
    _mod_disc_exp_v34_w +
    _mod_disc_exp_v35_w +
    _mod_disc_exp_v36_w +
    _mod_disc_exp_v37_w +
    _mod_disc_exp_v38_w;

_mod_binnr_exp_v01_w := map(
    _mod_disc_exp_lgt = NULL                => 0,
    _mod_disc_exp_lgt <= -2.81726478518863  => 1.82277212799823,
    _mod_disc_exp_lgt <= -1.61147642560388  => 1.58636358183176,
    _mod_disc_exp_lgt <= -0.81214798990566  => 1.23044831022212,
    _mod_disc_exp_lgt <= -0.380597222698149 => 0.989882115317653,
    _mod_disc_exp_lgt <= 0.264358224430672  => 0.624976719146795,
    _mod_disc_exp_lgt <= 0.485339091380237  => 0.249309440777145,
    _mod_disc_exp_lgt <= 2.32936973543229   => -0.225242105478395,
    _mod_disc_exp_lgt <= 4.56845487261055   => -0.88058424448463,
    _mod_disc_exp_lgt <= 5.57753726642881   => -2.09753514943136,
                                               -3.06894350653268);

_mod_binnr_exp_v02_w := map(
    phone_subject_title = ''                                                                                                   => 0,
    (phone_subject_title in ['Associate'])                                                                                       => 0.525247455760285,
    (phone_subject_title in ['Associate By SSN', 'Associate By Address'])                                                        => -0.532995971893797,
    (phone_subject_title in ['Father', 'Mother', 'Grandmother', 'Husband', 'Wife'])                                              => -0.0984216569328913,
    (phone_subject_title in ['Grandfather', 'Child', 'Neighbor', 'Associate By Business', 'Grandchild'])                         => -1.34115365524051,
    (phone_subject_title in ['Grandparent', 'Granddaughter', 'Brother', 'Sister', 'Relative', 'Associate By Shared Associates']) => -0.582456174486481,
    (phone_subject_title in ['Grandson', 'Spouse'])                                                                              => 0.271465314961553,
    (phone_subject_title in ['Parent', 'Associate By Vehicle', 'Associate By Property'])                                         => 0.0448094352993736,
    (phone_subject_title in ['Son', 'Sibling', 'Daughter'])                                                                      => -0.237434033780799,
    (phone_subject_title in ['Subject'])                                                                                         => 0.211641951197025,
    (phone_subject_title in ['Subject at Household'])                                                                            => 0.22710834157509,
                                                                                                                                    0);

_mod_binnr_exp_v03_w := map(
    mth_source_ppth_fseen = NULL   => 0,
    mth_source_ppth_fseen <= 6.5   => 0.347158322979175,
    mth_source_ppth_fseen <= 11.5  => 0.1178170578988,
    mth_source_ppth_fseen <= 14.5  => 0.0843235503613968,
    mth_source_ppth_fseen <= 29.5  => -0.556296460437031,
    mth_source_ppth_fseen <= 57.5  => -0.737070505823939,
    mth_source_ppth_fseen <= 77.5  => -1.16142993550054,
    mth_source_ppth_fseen <= 110.5 => -1.43467956865794,
    mth_source_ppth_fseen <= 159.5 => -1.63661992277377,
                                      -1.78751796444741);

_mod_binnr_exp_v04_w := map(
    eda_address_match_best = NULL => 0,
    eda_address_match_best <= 0.5 => -0.0401234421619818,
                                     0.783456260156799);

_mod_binnr_exp_v05_w := map(
    eda_min_days_connected_ind = NULL   => 0,
    eda_min_days_connected_ind <= 21.5  => 0.0371917837756908,
    eda_min_days_connected_ind <= 286.5 => -0.800757670910397,
                                           -0.839042982809917);

_mod_binnr_exp_v06_w := map(
    (integer)_phone_match_code_n = NULL => 0,
    (integer)_phone_match_code_n <= 0.5    => -0.173349448618372,
                                           0.154546169733743);

_mod_binnr_exp_v07_w := map(
    mth_exp_last_update = NULL   => 0,
    mth_exp_last_update <= 5.5   => 0.336001967331202,
    mth_exp_last_update <= 7.5   => 0.289168750862738,
    mth_exp_last_update <= 36.5  => 0.233534398139911,
    mth_exp_last_update <= 42.5  => 0.121908950460649,
    mth_exp_last_update <= 67.5  => 0.0569663495842564,
    mth_exp_last_update <= 86.5  => 0.0117262763778974,
    mth_exp_last_update <= 102.5 => -0.0415333886973698,
    mth_exp_last_update <= 130.5 => -0.122023065834426,
                                    -0.252241335205541);

_mod_binnr_exp_v08_w := map(
    mth_source_ppth_lseen = NULL  => 0,
    mth_source_ppth_lseen <= 11.5 => -0.0189995460251773,
    mth_source_ppth_lseen <= 14.5 => -0.233665363637559,
    mth_source_ppth_lseen <= 29.5 => -0.356386111513683,
    mth_source_ppth_lseen <= 32.5 => -0.381256458832407,
    mth_source_ppth_lseen <= 55.5 => -0.488050509365405,
    mth_source_ppth_lseen <= 73.5 => -0.668359461432071,
    mth_source_ppth_lseen <= 82.5 => -0.732527109694769,
                                     -1.01650420606712);

_mod_binnr_exp_v09_w := map(
    f_idrisktype_i = NULL => 0,
    f_idrisktype_i <= 8.5 => 0.0133734874431379,
                             -0.851742570535513);

_mod_binnr_exp_v10_w := map(
    f_srchvelocityrisktype_i = NULL => 0,
    f_srchvelocityrisktype_i <= 5.5 => 0.0746049555139297,
                                       -0.112067904507527);

_mod_binnr_exp_v11_w := map(
    mth_source_ppca_lseen = NULL   => 0,
    mth_source_ppca_lseen <= 1.5   => 0.2224813010825,
    mth_source_ppca_lseen <= 5.5   => 0.179913580328988,
    mth_source_ppca_lseen <= 8.5   => 0.158271047256155,
    mth_source_ppca_lseen <= 11.5  => 0.114744028474758,
    mth_source_ppca_lseen <= 15.5  => 0.0835840354930016,
    mth_source_ppca_lseen <= 19.5  => -0.0135292889863797,
    mth_source_ppca_lseen <= 20.5  => -0.144561513924183,
    mth_source_ppca_lseen <= 77.5  => -0.299967543342444,
    mth_source_ppca_lseen <= 105.5 => -0.803569528805822,
                                      -0.946464792131214);

_mod_binnr_exp_v12_w := map(
    mth_source_edaca_fseen = NULL   => 0,
    mth_source_edaca_fseen <= 4.5   => 0.247075400538546,
    mth_source_edaca_fseen <= 18.5  => 0.145040181031686,
    mth_source_edaca_fseen <= 25.5  => -0.00366959143831333,
    mth_source_edaca_fseen <= 85.5  => -0.237779883786966,
    mth_source_edaca_fseen <= 128.5 => -0.892794210997801,
                                       -1.33149622788585);

_mod_binnr_exp_v13_w := map(
    mth_source_edahistory_lseen = NULL  => 0,
    mth_source_edahistory_lseen <= 6.5  => 0.141618114309833,
    mth_source_edahistory_lseen <= 23.5 => -0.226696086302282,
    mth_source_edahistory_lseen <= 39.5 => -0.45538165979452,
    mth_source_edahistory_lseen <= 75.5 => -0.835096541150134,
                                           -1.15945159910283);

_mod_binnr_exp_v14_w := map(
    inq_adl_firstseen_n = NULL          => 0,
    (real)inq_adl_firstseen_n <= 0.5  => -0.0378543144531682,
    (real)inq_adl_firstseen_n <= 92.5 => 0.133506568921114,
                                         0.177449404595912);

_mod_binnr_exp_v15_w := map(
    mth_pp_first_build_date = NULL  => 0,
    mth_pp_first_build_date <= 5.5  => 0.0630829895855414,
    mth_pp_first_build_date <= 6.5  => 0.0550298218842514,
    mth_pp_first_build_date <= 13.5 => 0.0362730072365925,
    mth_pp_first_build_date <= 23.5 => -0.0138761033012539,
    mth_pp_first_build_date <= 26.5 => -0.083914515599838,
    mth_pp_first_build_date <= 29.5 => -0.0959844050822919,
    mth_pp_first_build_date <= 32.5 => -0.116866162311872,
    mth_pp_first_build_date <= 38.5 => -0.124883115796695,
                                       -0.396936530544821);

_mod_binnr_exp_v16_w := map(
    f_mos_inq_banko_cm_lseen_d = NULL  => 0,
    f_mos_inq_banko_cm_lseen_d <= 31.5 => -0.0700648328284994,
    f_mos_inq_banko_cm_lseen_d <= 45.5 => -0.0525276628069193,
    f_mos_inq_banko_cm_lseen_d <= 84.5 => -0.0208034581634702,
    f_mos_inq_banko_cm_lseen_d <= 86.5 => 0.0225440326103899,
                                          0.0805146832516069);

_mod_binnr_exp_v17_w := map(
    f_mos_inq_banko_om_lseen_d = NULL  => 0,
    f_mos_inq_banko_om_lseen_d <= 10.5 => -0.153692355904881,
    f_mos_inq_banko_om_lseen_d <= 44.5 => -0.0493859554897409,
                                          0.0355228351747226);

_mod_binnr_exp_v18_w := map(
    mth_source_md_fseen = NULL   => 0,
    mth_source_md_fseen <= 193.5 => 0.172933761263393,
                                    0.738279899102213);

_mod_binnr_exp_v19_w := map(
    mth_source_ppdid_lseen = NULL   => 0,
    mth_source_ppdid_lseen <= 0.5   => 0.174281503288412,
    mth_source_ppdid_lseen <= 6.5   => 0.123104905529586,
    mth_source_ppdid_lseen <= 12.5  => 0.101216307408678,
    mth_source_ppdid_lseen <= 18.5  => 0.0636066058206934,
    mth_source_ppdid_lseen <= 22.5  => 0.0282930505831798,
    mth_source_ppdid_lseen <= 40.5  => 0.00102590660666106,
    mth_source_ppdid_lseen <= 42.5  => -0.0110785880326563,
    mth_source_ppdid_lseen <= 77.5  => -0.0280467799120087,
    mth_source_ppdid_lseen <= 157.5 => -0.0851033374963819,
                                       -0.109626464879214);

_mod_binnr_exp_v20_w := map(
    r_i60_inq_comm_recency_d = NULL => 0,
    r_i60_inq_comm_recency_d <= 18  => -0.0914615016140716,
    r_i60_inq_comm_recency_d <= 549 => -0.0610461721075501,
                                       0.0327075138636461);

_mod_binnr_exp_v21_w := if(mth_source_ne_fseen = NULL, 0, -0.319009435673721);

_mod_binnr_exp_v22_w := map(
    mth_source_paw_lseen = NULL => 0,
    mth_source_paw_lseen <= 0.5 => -0.493557108831966,
                                   0.186259995138102);

_mod_binnr_exp_v23_w := map(
    r_c10_m_hdr_fs_d = NULL   => 0,
    r_c10_m_hdr_fs_d <= 324.5 => -0.0340861882362181,
    r_c10_m_hdr_fs_d <= 496.5 => 0.0459017993622346,
                                 0.125414470946014);

_mod_binnr_exp_v24_w := map(
    mth_source_ppdid_fseen = NULL   => 0,
    mth_source_ppdid_fseen <= 3.5   => 0.152115910580805,
    mth_source_ppdid_fseen <= 5.5   => 0.125632328393675,
    mth_source_ppdid_fseen <= 6.5   => 0.120342065164287,
    mth_source_ppdid_fseen <= 12.5  => 0.100467064517842,
    mth_source_ppdid_fseen <= 18.5  => 0.0729919854457133,
    mth_source_ppdid_fseen <= 25.5  => 0.0511914427787376,
    mth_source_ppdid_fseen <= 107.5 => 0.0173309311118955,
    mth_source_ppdid_fseen <= 177.5 => -0.0244454402242828,
                                       -0.0523147570385296);

_mod_binnr_exp_v25_w := map(
    (integer)_internal_ver_match_hhid = NULL => 0,
    (integer)_internal_ver_match_hhid <= 0.5 => -0.0136627886337765,
                                       0.113512274629603);

_mod_binnr_exp_v26_w := map(
    number_of_sources = NULL => 0,
    number_of_sources <= 1.5 => -0.0227495871969859,
    number_of_sources <= 2.5 => 0.0309294281919162,
    number_of_sources <= 3.5 => 0.0694940438146144,
    number_of_sources <= 4.5 => 0.0873109592986512,
    number_of_sources <= 5.5 => 0.114562648100279,
                                0.157999706020308);

_mod_binnr_exp_v27_w := map(
    mth_source_utildid_fseen = NULL  => 0,
    mth_source_utildid_fseen <= 2.5  => 0.243046578264569,
    mth_source_utildid_fseen <= 3.5  => 0.233047080277387,
    mth_source_utildid_fseen <= 5.5  => 0.185545720448127,
    mth_source_utildid_fseen <= 11.5 => 0.158278762813652,
    mth_source_utildid_fseen <= 14.5 => 0.127071781797154,
    mth_source_utildid_fseen <= 21.5 => 0.100909216921646,
    mth_source_utildid_fseen <= 29.5 => 0.0873853020255197,
    mth_source_utildid_fseen <= 37.5 => 0.062022975729174,
    mth_source_utildid_fseen <= 79.5 => 0.0310367277891659,
                                        -0.0327463141771117);

_mod_binnr_exp_v28_w := map(
    f_mos_liens_unrel_cj_lseen_d = NULL   => 0,
    f_mos_liens_unrel_cj_lseen_d <= 112.5 => -0.0555121348969927,
                                             0.0233362241597952);

_mod_binnr_exp_v29_w := map(
    (integer)_inq_adl_ph_industry_flag = NULL => 0,
    (integer)_inq_adl_ph_industry_flag <= 0.5    => -0.00479877102453891,
                                                 0.100868921881106);

_mod_binnr_exp_v30_w := map(
    r_c14_addrs_5yr_i = NULL => 0,
    r_c14_addrs_5yr_i <= 0.5 => 0.0322167386006068,
    r_c14_addrs_5yr_i <= 1.5 => 0.00878083055754838,
    r_c14_addrs_5yr_i <= 3.5 => -0.00631886730248227,
    r_c14_addrs_5yr_i <= 6.5 => -0.0289162577289468,
                                -0.0467662327090648);

_mod_binnr_exp_v31_w := map(
    f_wealth_index_d = NULL => 0,
    f_wealth_index_d <= 4.5 => -0.00698447198809968,
    f_wealth_index_d <= 5.5 => 0.0621811558982758,
                               0.0758224808545322);

_mod_binnr_exp_v32_w := map(
    r_c14_addrs_15yr_i = NULL  => 0,
    r_c14_addrs_15yr_i <= 1.5  => 0.0393858813651067,
    r_c14_addrs_15yr_i <= 6.5  => 0.0159805969515031,
    r_c14_addrs_15yr_i <= 12.5 => -0.00975308215727985,
    r_c14_addrs_15yr_i <= 15.5 => -0.0277267101701309,
                                  -0.0378905492896906);

_mod_binnr_exp_v33_w := map(
    r_c14_addrs_10yr_i = NULL  => 0,
    r_c14_addrs_10yr_i <= 0.5  => 0.0342142422751342,
    r_c14_addrs_10yr_i <= 1.5  => 0.0216586633506146,
    r_c14_addrs_10yr_i <= 5.5  => 0.00584149325257085,
    r_c14_addrs_10yr_i <= 10.5 => -0.0168522609955554,
                                  -0.035661370144757);

_mod_binnr_exp_v34_w := map(
    mth_source_exp_fseen = NULL  => 0,
    mth_source_exp_fseen <= 1.5  => 0.0685976628085262,
    mth_source_exp_fseen <= 2.5  => 0.0657916836236769,
    mth_source_exp_fseen <= 6.5  => 0.0594130269140891,
    mth_source_exp_fseen <= 13.5 => 0.0364448409540743,
                                    0.027669344550256);

_mod_binnr_exp_lgt := -1.97169353982768 +
    _mod_binnr_exp_v01_w +
    _mod_binnr_exp_v02_w +
    _mod_binnr_exp_v03_w +
    _mod_binnr_exp_v04_w +
    _mod_binnr_exp_v05_w +
    _mod_binnr_exp_v06_w +
    _mod_binnr_exp_v07_w +
    _mod_binnr_exp_v08_w +
    _mod_binnr_exp_v09_w +
    _mod_binnr_exp_v10_w +
    _mod_binnr_exp_v11_w +
    _mod_binnr_exp_v12_w +
    _mod_binnr_exp_v13_w +
    _mod_binnr_exp_v14_w +
    _mod_binnr_exp_v15_w +
    _mod_binnr_exp_v16_w +
    _mod_binnr_exp_v17_w +
    _mod_binnr_exp_v18_w +
    _mod_binnr_exp_v19_w +
    _mod_binnr_exp_v20_w +
    _mod_binnr_exp_v21_w +
    _mod_binnr_exp_v22_w +
    _mod_binnr_exp_v23_w +
    _mod_binnr_exp_v24_w +
    _mod_binnr_exp_v25_w +
    _mod_binnr_exp_v26_w +
    _mod_binnr_exp_v27_w +
    _mod_binnr_exp_v28_w +
    _mod_binnr_exp_v29_w +
    _mod_binnr_exp_v30_w +
    _mod_binnr_exp_v31_w +
    _mod_binnr_exp_v32_w +
    _mod_binnr_exp_v33_w +
    _mod_binnr_exp_v34_w;

final_score_0 := 0.0270733452;

final_score_1_c208 := map(
    NULL < _mod_binnr_exp_lgt AND _mod_binnr_exp_lgt <= -3.6128163298781 => -0.1764686830,
    _mod_binnr_exp_lgt > -3.6128163298781                                => -0.1113294569,
    _mod_binnr_exp_lgt = NULL                                            => -0.1352372953,
                                                                            -0.1352372953);

final_score_1_c209 := map(
    NULL < mth_source_exp_fseen AND mth_source_exp_fseen <= 43.5 => 0.0526875302,
    mth_source_exp_fseen > 43.5                                  => -0.1538950958,
    mth_source_exp_fseen = NULL                                  => -0.0333318725,
                                                                    -0.0282061991);

final_score_1_c207 := map(
    NULL < _mod_binnr_exp_lgt AND _mod_binnr_exp_lgt <= -2.61325182981215 => final_score_1_c208,
    _mod_binnr_exp_lgt > -2.61325182981215                                => final_score_1_c209,
    _mod_binnr_exp_lgt = NULL                                             => -0.0943331139,
                                                                             -0.0943331139);

final_score_1_c210 := map(
    NULL < _mod_binnr_exp_lgt AND _mod_binnr_exp_lgt <= -0.60361409982639 => 0.0515143652,
    _mod_binnr_exp_lgt > -0.60361409982639                                => 0.1456487821,
    _mod_binnr_exp_lgt = NULL                                             => 0.0954684560,
                                                                             0.0954684560);

final_score_1 := map(
    NULL < _mod_binnr_exp_lgt AND _mod_binnr_exp_lgt <= -1.83093721723149 => final_score_1_c207,
    _mod_binnr_exp_lgt > -1.83093721723149                                => final_score_1_c210,
    _mod_binnr_exp_lgt = NULL                                             => 0.0001247915,
                                                                             0.0001247915);

final_score_2_c212 := map(
    NULL < _mod_binnr_exp_lgt AND _mod_binnr_exp_lgt <= -2.79945216204112 => -0.1307824780,
    _mod_binnr_exp_lgt > -2.79945216204112                                => -0.0530486795,
    _mod_binnr_exp_lgt = NULL                                             => -0.0997817722,
                                                                             -0.0997817722);

final_score_2_c215 := map(
    NULL < mth_exp_last_update AND mth_exp_last_update <= 15.5 => 0.1006682202,
    mth_exp_last_update > 15.5                                 => 0.0516269343,
    mth_exp_last_update = NULL                                 => 0.0127053657,
                                                                  0.0323766623);

final_score_2_c214 := map(
    NULL < mth_source_exp_lseen AND mth_source_exp_lseen <= 26.5 => 0.0948980069,
    mth_source_exp_lseen > 26.5                                  => -0.0378581610,
    mth_source_exp_lseen = NULL                                  => final_score_2_c215,
                                                                    0.0374658144);

final_score_2_c213 := map(
    NULL < _mod_binnr_exp_lgt AND _mod_binnr_exp_lgt <= -0.628652936778437 => final_score_2_c214,
    _mod_binnr_exp_lgt > -0.628652936778437                                => 0.1321169615,
    _mod_binnr_exp_lgt = NULL                                              => 0.0785554664,
                                                                              0.0785554664);

final_score_2 := map(
    NULL < _mod_binnr_exp_lgt AND _mod_binnr_exp_lgt <= -2.02028899121675 => final_score_2_c212,
    _mod_binnr_exp_lgt > -2.02028899121675                                => final_score_2_c213,
    _mod_binnr_exp_lgt = NULL                                             => -0.0009199697,
                                                                             -0.0009199697);

final_score_3_c218 := map(
    NULL < mth_source_exp_lseen AND mth_source_exp_lseen <= 16.5 => 0.0874405888,
    mth_source_exp_lseen > 16.5                                  => -0.0634388787,
    mth_source_exp_lseen = NULL                                  => -0.0310561223,
                                                                    -0.0238180479);

final_score_3_c217 := map(
    NULL < _mod_binnr_exp_lgt AND _mod_binnr_exp_lgt <= -2.70747429190517 => -0.1120443684,
    _mod_binnr_exp_lgt > -2.70747429190517                                => final_score_3_c218,
    _mod_binnr_exp_lgt = NULL                                             => -0.0698771873,
                                                                             -0.0698771873);

final_score_3_c220 := map(
    NULL < (integer)inq_adl_firstseen_n AND (integer)inq_adl_firstseen_n <= 0.5 => 0.0075757556,
    (integer)inq_adl_firstseen_n > 0.5                                 => 0.1000897551,
    (integer)inq_adl_firstseen_n = NULL                                => 0.0662929666,
                                                                 0.0514833897);

final_score_3_c219 := map(
    NULL < number_of_sources AND number_of_sources <= 1.5 => final_score_3_c220,
    number_of_sources > 1.5                               => 0.1209733430,
    number_of_sources = NULL                              => 0.0891620272,
                                                             0.0891620272);

final_score_3 := map(
    NULL < _mod_binnr_exp_lgt AND _mod_binnr_exp_lgt <= -1.64559330154774 => final_score_3_c217,
    _mod_binnr_exp_lgt > -1.64559330154774                                => final_score_3_c219,
    _mod_binnr_exp_lgt = NULL                                             => -0.0010049872,
                                                                             -0.0010049872);

final_score_4_c223 := map(
    (segment in ['1 - Other', '2 - Cell Phone'])    => -0.0599894174,
    (segment in ['0 - Disconnected', '3 - ExpHit']) => 0.0266237512,
    segment = ''                                    => -0.0475432027,
                                                       -0.0475432027);

final_score_4_c222 := map(
    NULL < _mod_binnr_exp_lgt AND _mod_binnr_exp_lgt <= -3.56734639314913 => -0.1353975346,
    _mod_binnr_exp_lgt > -3.56734639314913                                => final_score_4_c223,
    _mod_binnr_exp_lgt = NULL                                             => -0.0694933068,
                                                                             -0.0694933068);

final_score_4_c225 := map(
    NULL < (integer)inq_adl_firstseen_n AND (integer)inq_adl_firstseen_n <= 0.5 => -0.0057382500,
    (integer)inq_adl_firstseen_n > 0.5                                          => 0.0605076777,
    (integer)inq_adl_firstseen_n = NULL                                         => 0.0532096634,
                                                                                   0.0343191060);

final_score_4_c224 := map(
    NULL < _mod_binnr_exp_lgt AND _mod_binnr_exp_lgt <= -0.707699148060548 => final_score_4_c225,
    _mod_binnr_exp_lgt > -0.707699148060548                                => 0.1098896132,
    _mod_binnr_exp_lgt = NULL                                              => 0.0714286348,
                                                                              0.0714286348);

final_score_4 := map(
    NULL < _mod_binnr_exp_lgt AND _mod_binnr_exp_lgt <= -1.89460342821848 => final_score_4_c222,
    _mod_binnr_exp_lgt > -1.89460342821848                                => final_score_4_c224,
    _mod_binnr_exp_lgt = NULL                                             => 0.0031306514,
                                                                             0.0031306514);

final_score_5_c228 := map(
    NULL < mth_source_exp_lseen AND mth_source_exp_lseen <= 15.5 => 0.0826865237,
    mth_source_exp_lseen > 15.5                                  => -0.0452097729,
    mth_source_exp_lseen = NULL                                  => -0.0257626759,
                                                                    -0.0178902656);

final_score_5_c227 := map(
    NULL < _mod_binnr_exp_lgt AND _mod_binnr_exp_lgt <= -2.62163022227424 => -0.0959908233,
    _mod_binnr_exp_lgt > -2.62163022227424                                => final_score_5_c228,
    _mod_binnr_exp_lgt = NULL                                             => -0.0622128208,
                                                                             -0.0622128208);

final_score_5_c230 := map(
    NULL < (integer)inq_adl_firstseen_n AND (integer)inq_adl_firstseen_n <= 0.5 => 0.0112695327,
    (integer)inq_adl_firstseen_n > 0.5                                 => 0.0823389441,
    (integer)inq_adl_firstseen_n = NULL                                => 0.0667672709,
                                                                 0.0523619931);

final_score_5_c229 := map(
    NULL < _mod_binnr_exp_lgt AND _mod_binnr_exp_lgt <= -0.0584284011532409 => final_score_5_c230,
    _mod_binnr_exp_lgt > -0.0584284011532409                                => 0.1236767073,
    _mod_binnr_exp_lgt = NULL                                               => 0.0763988927,
                                                                               0.0763988927);

final_score_5 := map(
    NULL < _mod_binnr_exp_lgt AND _mod_binnr_exp_lgt <= -1.65034293112848 => final_score_5_c227,
    _mod_binnr_exp_lgt > -1.65034293112848                                => final_score_5_c229,
    _mod_binnr_exp_lgt = NULL                                             => -0.0002679350,
                                                                             -0.0002679350);

final_score_6_c234 := map(
    NULL < (integer)source_sx AND (integer)source_sx <= 0.5 => -0.0316084949,
    (integer)source_sx > 0.5                       => 0.0964093516,
    (integer)source_sx = NULL                      => -0.0261758842,
                                             -0.0261758842);

final_score_6_c233 := map(
    NULL < mth_source_exp_lseen AND mth_source_exp_lseen <= 27.5 => 0.0696269911,
    mth_source_exp_lseen > 27.5                                  => -0.0713721991,
    mth_source_exp_lseen = NULL                                  => final_score_6_c234,
                                                                    -0.0170691664);

final_score_6_c232 := map(
    NULL < _mod_binnr_exp_lgt AND _mod_binnr_exp_lgt <= -2.72827614927974 => -0.0942780594,
    _mod_binnr_exp_lgt > -2.72827614927974                                => final_score_6_c233,
    _mod_binnr_exp_lgt = NULL                                             => -0.0557054670,
                                                                             -0.0557054670);

final_score_6_c235 := map(
    NULL < (integer)inq_adl_firstseen_n AND (integer)inq_adl_firstseen_n <= 0.5 => 0.0255864013,
    (integer)inq_adl_firstseen_n > 0.5                                 => 0.1030570800,
    (integer)inq_adl_firstseen_n = NULL                                => 0.0801387906,
                                                                 0.0728868417);

final_score_6 := map(
    NULL < _mod_binnr_exp_lgt AND _mod_binnr_exp_lgt <= -1.60051054646651 => final_score_6_c232,
    _mod_binnr_exp_lgt > -1.60051054646651                                => final_score_6_c235,
    _mod_binnr_exp_lgt = NULL                                             => -0.0011769858,
                                                                             -0.0011769858);

final_score_7_c237 := map(
    NULL < _mod_binnr_exp_lgt AND _mod_binnr_exp_lgt <= -2.50372145125615 => -0.0805204897,
    _mod_binnr_exp_lgt > -2.50372145125615                                => -0.0124889570,
    _mod_binnr_exp_lgt = NULL                                             => -0.0561689672,
                                                                             -0.0561689672);

final_score_7_c240 := map(
    NULL < mth_internal_ver_first_seen AND mth_internal_ver_first_seen <= 14.5 => 0.0653467999,
    mth_internal_ver_first_seen > 14.5                                         => 0.0427336211,
    mth_internal_ver_first_seen = NULL                                         => -0.0267585548,
                                                                                  0.0220047701);

final_score_7_c239 := map(
    NULL < mth_source_exp_lseen AND mth_source_exp_lseen <= 12.5 => 0.0761769197,
    mth_source_exp_lseen > 12.5                                  => -0.0261784738,
    mth_source_exp_lseen = NULL                                  => final_score_7_c240,
                                                                    0.0282054441);

final_score_7_c238 := map(
    NULL < number_of_sources AND number_of_sources <= 1.5 => final_score_7_c239,
    number_of_sources > 1.5                               => 0.0903499452,
    number_of_sources = NULL                              => 0.0619058871,
                                                             0.0619058871);

final_score_7 := map(
    NULL < _mod_binnr_exp_lgt AND _mod_binnr_exp_lgt <= -1.74940688982058 => final_score_7_c237,
    _mod_binnr_exp_lgt > -1.74940688982058                                => final_score_7_c238,
    _mod_binnr_exp_lgt = NULL                                             => 0.0001619719,
                                                                             0.0001619719);

final_score_8_c244 := map(
    NULL < _mod_binnr_exp_lgt AND _mod_binnr_exp_lgt <= -3.56428209273719 => -0.0985064332,
    _mod_binnr_exp_lgt > -3.56428209273719                                => -0.0243864735,
    _mod_binnr_exp_lgt = NULL                                             => -0.0369044000,
                                                                             -0.0369044000);

final_score_8_c243 := map(
    NULL < mth_source_exp_lseen AND mth_source_exp_lseen <= 23.5 => 0.0625517040,
    mth_source_exp_lseen > 23.5                                  => -0.0595068307,
    mth_source_exp_lseen = NULL                                  => final_score_8_c244,
                                                                    -0.0316091985);

final_score_8_c242 := map(
    (phone_subject_title in ['Associate', 'Associate By Business', 'Associate By Property', 'Associate By Shared Associates', 'Associate By Vehicle', 'Granddaughter', 'Grandparent', 'Husband', 'Neighbor', 'Parent'])                                                            => -0.1148216868,
    (phone_subject_title in ['Associate By Address', 'Associate By SSN', 'Brother', 'Child', 'Daughter', 'Father', 'Grandchild', 'Grandfather', 'Grandmother', 'Grandson', 'Mother', 'Relative', 'Sibling', 'Sister', 'Son', 'Spouse', 'Subject', 'Subject at Household', 'Wife']) => final_score_8_c243,
    phone_subject_title = ''                                                                                                                                                                                                                                                     => -0.0452478273,
                                                                                                                                                                                                                                                                                      -0.0452478273);

final_score_8_c245 := map(
    NULL < number_of_sources AND number_of_sources <= 1.5 => 0.0271992802,
    number_of_sources > 1.5                               => 0.0850313211,
    number_of_sources = NULL                              => 0.0592070710,
                                                             0.0592070710);

final_score_8 := map(
    NULL < _mod_binnr_exp_lgt AND _mod_binnr_exp_lgt <= -1.64576420648007 => final_score_8_c242,
    _mod_binnr_exp_lgt > -1.64576420648007                                => final_score_8_c245,
    _mod_binnr_exp_lgt = NULL                                             => 0.0009432865,
                                                                             0.0009432865);

final_score_9_c249 := map(
    NULL < mth_source_exp_lseen AND mth_source_exp_lseen <= 16.5 => 0.0687591585,
    mth_source_exp_lseen > 16.5                                  => -0.0507432204,
    mth_source_exp_lseen = NULL                                  => -0.0306945391,
                                                                    -0.0268070964);

final_score_9_c248 := map(
    NULL < mth_exp_last_update AND mth_exp_last_update <= 42.5 => 0.0518953584,
    mth_exp_last_update > 42.5                                 => -0.0319335049,
    mth_exp_last_update = NULL                                 => final_score_9_c249,
                                                                  -0.0186332910);

final_score_9_c247 := map(
    NULL < _mod_binnr_exp_lgt AND _mod_binnr_exp_lgt <= -3.17415205500192 => -0.0940741347,
    _mod_binnr_exp_lgt > -3.17415205500192                                => final_score_9_c248,
    _mod_binnr_exp_lgt = NULL                                             => -0.0402109301,
                                                                             -0.0402109301);

final_score_9_c250 := map(
    NULL < (integer)inq_adl_firstseen_n AND (integer)inq_adl_firstseen_n <= 0.5 => 0.0150410007,
    (integer)inq_adl_firstseen_n > 0.5                                 => 0.0908607926,
    (integer)inq_adl_firstseen_n = NULL                                => 0.0587111629,
                                                                 0.0582968517);

final_score_9 := map(
    NULL < _mod_binnr_exp_lgt AND _mod_binnr_exp_lgt <= -1.57265654287622 => final_score_9_c247,
    _mod_binnr_exp_lgt > -1.57265654287622                                => final_score_9_c250,
    _mod_binnr_exp_lgt = NULL                                             => 0.0005954216,
                                                                             0.0005954216);

final_score_10_c252 := map(
    NULL < _mod_disc_exp_lgt AND _mod_disc_exp_lgt <= 1.32530615074209 => 0.0577505323,
    _mod_disc_exp_lgt > 1.32530615074209                               => -0.0332063499,
    _mod_disc_exp_lgt = NULL                                           => 0.0366502134,
                                                                          0.0366502134);

final_score_10_c255 := map(
    NULL < mth_source_exp_lseen AND mth_source_exp_lseen <= 27.5 => 0.0581169936,
    mth_source_exp_lseen > 27.5                                  => -0.0914627894,
    mth_source_exp_lseen = NULL                                  => -0.0391251271,
                                                                    -0.0207071861);

final_score_10_c254 := map(
    NULL < mth_internal_ver_first_seen AND mth_internal_ver_first_seen <= 7.5 => 0.0532676948,
    mth_internal_ver_first_seen > 7.5                                         => 0.0223948422,
    mth_internal_ver_first_seen = NULL                                        => final_score_10_c255,
                                                                                 0.0081292867);

final_score_10_c253 := map(
    NULL < _mod_binnr_exp_lgt AND _mod_binnr_exp_lgt <= -2.12348594948879 => -0.0516659866,
    _mod_binnr_exp_lgt > -2.12348594948879                                => final_score_10_c254,
    _mod_binnr_exp_lgt = NULL                                             => -0.0264891078,
                                                                             -0.0264891078);

final_score_10 := map(
    NULL < mth_exp_last_update AND mth_exp_last_update <= 13.5 => 0.0798381548,
    mth_exp_last_update > 13.5                                 => final_score_10_c252,
    mth_exp_last_update = NULL                                 => final_score_10_c253,
                                                                  0.0034469998);

final_score_11_c259 := map(
    NULL < (integer)_phone_match_code_c AND (integer)_phone_match_code_c <= 0.5 => -0.0407747672,
    (integer)_phone_match_code_c > 0.5                                 => 0.0069468900,
    (integer)_phone_match_code_c = NULL                                => -0.0081007969,
                                                                 -0.0081007969);

final_score_11_c258 := map(
    (phone_subject_title in ['Associate', 'Associate By Business', 'Associate By Property', 'Associate By Vehicle', 'Daughter', 'Granddaughter', 'Grandfather', 'Grandparent', 'Neighbor', 'Parent'])                                                                                                => -0.0999855172,
    (phone_subject_title in ['Associate By Address', 'Associate By Shared Associates', 'Associate By SSN', 'Brother', 'Child', 'Father', 'Grandchild', 'Grandmother', 'Grandson', 'Husband', 'Mother', 'Relative', 'Sibling', 'Sister', 'Son', 'Spouse', 'Subject', 'Subject at Household', 'Wife']) => final_score_11_c259,
    phone_subject_title = ''                                                                                                                                                                                                                                                                       => -0.0166710682,
                                                                                                                                                                                                                                                                                                        -0.0166710682);

final_score_11_c257 := map(
    NULL < _mod_binnr_exp_lgt AND _mod_binnr_exp_lgt <= -3.59112508388413 => -0.1029036619,
    _mod_binnr_exp_lgt > -3.59112508388413                                => final_score_11_c258,
    _mod_binnr_exp_lgt = NULL                                             => -0.0338129509,
                                                                             -0.0338129509);

final_score_11_c260 := map(
    NULL < number_of_sources AND number_of_sources <= 1.5 => 0.0231378188,
    number_of_sources > 1.5                               => 0.0741646882,
    number_of_sources = NULL                              => 0.0523341868,
                                                             0.0523341868);

final_score_11 := map(
    NULL < _mod_binnr_exp_lgt AND _mod_binnr_exp_lgt <= -1.56169243867285 => final_score_11_c257,
    _mod_binnr_exp_lgt > -1.56169243867285                                => final_score_11_c260,
    _mod_binnr_exp_lgt = NULL                                             => 0.0013293188,
                                                                             0.0013293188);

final_score_12_c265 := map(
    NULL < number_of_sources AND number_of_sources <= 2.5 => -0.0079686235,
    number_of_sources > 2.5                               => 0.0549572854,
    number_of_sources = NULL                              => -0.0009881307,
                                                             -0.0009881307);

final_score_12_c264 := map(
    (phone_subject_title in ['Associate', 'Associate By Property', 'Associate By SSN', 'Associate By Vehicle', 'Daughter', 'Granddaughter', 'Grandparent', 'Neighbor', 'Parent', 'Spouse'])                                                                                                                    => -0.0890510548,
    (phone_subject_title in ['Associate By Address', 'Associate By Business', 'Associate By Shared Associates', 'Brother', 'Child', 'Father', 'Grandchild', 'Grandfather', 'Grandmother', 'Grandson', 'Husband', 'Mother', 'Relative', 'Sibling', 'Sister', 'Son', 'Subject', 'Subject at Household', 'Wife']) => final_score_12_c265,
    phone_subject_title = ''                                                                                                                                                                                                                                                                                 => -0.0085975871,
                                                                                                                                                                                                                                                                                                                  -0.0085975871);

final_score_12_c263 := map(
    NULL < mth_source_exp_lseen AND mth_source_exp_lseen <= 43.5 => 0.0463022153,
    mth_source_exp_lseen > 43.5                                  => -0.0737717162,
    mth_source_exp_lseen = NULL                                  => final_score_12_c264,
                                                                    -0.0040680971);

final_score_12_c262 := map(
    NULL < _mod_binnr_exp_lgt AND _mod_binnr_exp_lgt <= -2.91038768790988 => -0.0672381889,
    _mod_binnr_exp_lgt > -2.91038768790988                                => final_score_12_c263,
    _mod_binnr_exp_lgt = NULL                                             => -0.0257272141,
                                                                             -0.0257272141);

final_score_12 := map(
    NULL < _mod_binnr_exp_lgt AND _mod_binnr_exp_lgt <= -1.17372514056965 => final_score_12_c262,
    _mod_binnr_exp_lgt > -1.17372514056965                                => 0.0590272272,
    _mod_binnr_exp_lgt = NULL                                             => 0.0024999668,
                                                                             0.0024999668);

final_score_13_c269 := map(
    (phone_subject_title in ['Associate By Business', 'Associate By Property', 'Associate By Shared Associates', 'Associate By Vehicle', 'Granddaughter', 'Grandmother', 'Grandparent', 'Grandson', 'Neighbor', 'Parent', 'Sister', 'Spouse'])              => -0.1462015877,
    (phone_subject_title in ['Associate', 'Associate By Address', 'Associate By SSN', 'Brother', 'Child', 'Daughter', 'Father', 'Grandchild', 'Grandfather', 'Husband', 'Mother', 'Relative', 'Sibling', 'Son', 'Subject', 'Subject at Household', 'Wife']) => 0.0023606197,
    phone_subject_title = ''                                                                                                                                                                                                                              => -0.0012636515,
                                                                                                                                                                                                                                                               -0.0012636515);

final_score_13_c268 := map(
    NULL < mth_source_exp_lseen AND mth_source_exp_lseen <= 8.5 => 0.0834435906,
    mth_source_exp_lseen > 8.5                                  => -0.0238189900,
    mth_source_exp_lseen = NULL                                 => final_score_13_c269,
                                                                   0.0010276240);

final_score_13_c270 := map(
    (phone_subject_title in ['Associate', 'Associate By Address', 'Associate By Property', 'Father', 'Grandson', 'Mother', 'Parent', 'Relative', 'Spouse', 'Wife'])                                                                                                                                                                    => -0.0316094158,
    (phone_subject_title in ['Associate By Business', 'Associate By Shared Associates', 'Associate By SSN', 'Associate By Vehicle', 'Brother', 'Child', 'Daughter', 'Grandchild', 'Granddaughter', 'Grandfather', 'Grandmother', 'Grandparent', 'Husband', 'Neighbor', 'Sibling', 'Sister', 'Son', 'Subject', 'Subject at Household']) => 0.0627330804,
    phone_subject_title = ''                                                                                                                                                                                                                                                                                                         => 0.0553336274,
                                                                                                                                                                                                                                                                                                                                          0.0553336274);

final_score_13_c267 := map(
    NULL < _mod_binnr_exp_lgt AND _mod_binnr_exp_lgt <= -0.987464505969003 => final_score_13_c268,
    _mod_binnr_exp_lgt > -0.987464505969003                                => final_score_13_c270,
    _mod_binnr_exp_lgt = NULL                                              => 0.0252627632,
                                                                              0.0252627632);

final_score_13 := map(
    NULL < _mod_binnr_exp_lgt AND _mod_binnr_exp_lgt <= -2.54495936171624 => -0.0533141628,
    _mod_binnr_exp_lgt > -2.54495936171624                                => final_score_13_c267,
    _mod_binnr_exp_lgt = NULL                                             => -0.0005717205,
                                                                             -0.0005717205);

final_score_14_c272 := map(
    NULL < r_c14_addrs_5yr_i AND r_c14_addrs_5yr_i <= 3.5 => 0.0405378303,
    r_c14_addrs_5yr_i > 3.5                               => -0.0790694280,
    r_c14_addrs_5yr_i = NULL                              => 0.0263286279,
                                                             0.0263286279);

final_score_14_c275 := map(
    NULL < number_of_sources AND number_of_sources <= 1.5 => -0.0431289169,
    number_of_sources > 1.5                               => 0.0354811159,
    number_of_sources = NULL                              => -0.0369417744,
                                                             -0.0369417744);

final_score_14_c274 := map(
    NULL < mth_source_ppdid_fseen AND mth_source_ppdid_fseen <= 32.5 => 0.0398048371,
    mth_source_ppdid_fseen > 32.5                                    => -0.0300401544,
    mth_source_ppdid_fseen = NULL                                    => final_score_14_c275,
                                                                        -0.0267288991);

final_score_14_c273 := map(
    NULL < mth_source_exp_lseen AND mth_source_exp_lseen <= 43.5 => 0.0416689806,
    mth_source_exp_lseen > 43.5                                  => -0.0897523544,
    mth_source_exp_lseen = NULL                                  => final_score_14_c274,
                                                                    -0.0225070071);

final_score_14 := map(
    NULL < mth_exp_last_update AND mth_exp_last_update <= 11.5 => 0.0629413522,
    mth_exp_last_update > 11.5                                 => final_score_14_c272,
    mth_exp_last_update = NULL                                 => final_score_14_c273,
                                                                  0.0002982293);

final_score_15_c277 := map(
    NULL < _mod_binnr_exp_lgt AND _mod_binnr_exp_lgt <= -3.61500055312382 => -0.0890038608,
    _mod_binnr_exp_lgt > -3.61500055312382                                => -0.0278910986,
    _mod_binnr_exp_lgt = NULL                                             => -0.0505144286,
                                                                             -0.0505144286);

final_score_15_c280 := map(
    (segment in ['1 - Other', '2 - Cell Phone'])    => -0.0197471911,
    (segment in ['0 - Disconnected', '3 - ExpHit']) => 0.0379485319,
    segment = ''                                  => -0.0033259291,
                                                       -0.0033259291);

final_score_15_c279 := map(
    NULL < mth_source_exp_lseen AND mth_source_exp_lseen <= 10.5 => 0.0276868750,
    mth_source_exp_lseen > 10.5                                  => -0.0708044288,
    mth_source_exp_lseen = NULL                                  => final_score_15_c280,
                                                                    -0.0074899256);

final_score_15_c278 := map(
    NULL < (integer)inq_adl_firstseen_n AND (integer)inq_adl_firstseen_n <= 0.5 => final_score_15_c279,
    (integer)inq_adl_firstseen_n > 0.5                                 => 0.0544097033,
    (integer)inq_adl_firstseen_n = NULL                                => 0.0272722638,
                                                                 0.0229036521);

final_score_15 := map(
    NULL < _mod_binnr_exp_lgt AND _mod_binnr_exp_lgt <= -2.63137938617514 => final_score_15_c277,
    _mod_binnr_exp_lgt > -2.63137938617514                                => final_score_15_c278,
    _mod_binnr_exp_lgt = NULL                                             => 0.0002846950,
                                                                             0.0002846950);

final_score_16_c285 := map(
    NULL < (integer)_phone_match_code_n AND (integer)_phone_match_code_n <= 0.5 => -0.0218434501,
    (integer)_phone_match_code_n > 0.5                                 => 0.1427127135,
    (integer)_phone_match_code_n = NULL                                => -0.0143923131,
                                                                 -0.0143923131);

final_score_16_c284 := map(
    (phone_subject_title in ['Associate', 'Associate By Property', 'Associate By SSN', 'Associate By Vehicle', 'Grandmother', 'Grandparent', 'Grandson', 'Neighbor', 'Parent', 'Spouse', 'Subject'])                                                                                                  => -0.0671846292,
    (phone_subject_title in ['Associate By Address', 'Associate By Business', 'Associate By Shared Associates', 'Brother', 'Child', 'Daughter', 'Father', 'Grandchild', 'Granddaughter', 'Grandfather', 'Husband', 'Mother', 'Relative', 'Sibling', 'Sister', 'Son', 'Subject at Household', 'Wife']) => final_score_16_c285,
    phone_subject_title = ''                                                                                                                                                                                                                                                                        => -0.0331302285,
                                                                                                                                                                                                                                                                                                         -0.0331302285);

final_score_16_c283 := map(
    NULL < mth_source_exp_lseen AND mth_source_exp_lseen <= 34.5 => 0.0351103157,
    mth_source_exp_lseen > 34.5                                  => -0.0799135902,
    mth_source_exp_lseen = NULL                                  => final_score_16_c284,
                                                                    -0.0286517361);

final_score_16_c282 := map(
    NULL < mth_source_ppdid_lseen AND mth_source_ppdid_lseen <= 30.5 => 0.0309990468,
    mth_source_ppdid_lseen > 30.5                                    => -0.0472698349,
    mth_source_ppdid_lseen = NULL                                    => final_score_16_c283,
                                                                        -0.0209650246);

final_score_16 := map(
    NULL < mth_exp_last_update AND mth_exp_last_update <= 10.5 => 0.0615892831,
    mth_exp_last_update > 10.5                                 => 0.0205359712,
    mth_exp_last_update = NULL                                 => final_score_16_c282,
                                                                  -0.0001826422);

final_score_17_c289 := map(
    NULL < mth_source_ppdid_lseen AND mth_source_ppdid_lseen <= 20.5 => 0.0437750410,
    mth_source_ppdid_lseen > 20.5                                    => -0.0485921293,
    mth_source_ppdid_lseen = NULL                                    => -0.0158919270,
                                                                        -0.0123441802);

final_score_17_c288 := map(
    NULL < mth_source_exp_lseen AND mth_source_exp_lseen <= 36.5 => 0.0412350455,
    mth_source_exp_lseen > 36.5                                  => -0.0560346990,
    mth_source_exp_lseen = NULL                                  => final_score_17_c289,
                                                                    -0.0059575643);

final_score_17_c287 := map(
    (phone_subject_title in ['Associate', 'Associate By Property', 'Associate By Vehicle', 'Brother', 'Grandchild', 'Granddaughter', 'Grandparent', 'Grandson', 'Neighbor', 'Parent', 'Spouse', 'Wife'])                                                                                          => -0.0707279966,
    (phone_subject_title in ['Associate By Address', 'Associate By Business', 'Associate By Shared Associates', 'Associate By SSN', 'Child', 'Daughter', 'Father', 'Grandfather', 'Grandmother', 'Husband', 'Mother', 'Relative', 'Sibling', 'Sister', 'Son', 'Subject', 'Subject at Household']) => final_score_17_c288,
    phone_subject_title = ''                                                                                                                                                                                                                                                                    => -0.0175723473,
                                                                                                                                                                                                                                                                                                     -0.0175723473);

final_score_17_c290 := map(
    NULL < _mod_disc_exp_lgt AND _mod_disc_exp_lgt <= 1.33000425312348 => 0.0556672668,
    _mod_disc_exp_lgt > 1.33000425312348                               => -0.0096113682,
    _mod_disc_exp_lgt = NULL                                           => 0.0417244067,
                                                                          0.0417244067);

final_score_17 := map(
    NULL < number_of_sources AND number_of_sources <= 1.5 => final_score_17_c287,
    number_of_sources > 1.5                               => final_score_17_c290,
    number_of_sources = NULL                              => 0.0020406582,
                                                             0.0020406582);

final_score_18_c294 := map(
    NULL < mth_source_sx_fseen AND mth_source_sx_fseen <= 37.5 => 0.0388291020,
    mth_source_sx_fseen > 37.5                                 => 0.1022047613,
    mth_source_sx_fseen = NULL                                 => -0.0348748877,
                                                                  -0.0269814816);

final_score_18_c295 := map(
    NULL < f_prevaddrageoldest_d AND f_prevaddrageoldest_d <= 137.5 => -0.0186671007,
    f_prevaddrageoldest_d > 137.5                                   => 0.0205590055,
    f_prevaddrageoldest_d = NULL                                    => -0.0024604284,
                                                                       -0.0024604284);

final_score_18_c293 := map(
    NULL < mth_eda_dt_last_seen AND mth_eda_dt_last_seen <= 7.5 => final_score_18_c294,
    mth_eda_dt_last_seen > 7.5                                  => 0.0505205919,
    mth_eda_dt_last_seen = NULL                                 => final_score_18_c295,
                                                                   -0.0087804247);

final_score_18_c292 := map(
    NULL < _mod_binnr_exp_lgt AND _mod_binnr_exp_lgt <= -3.61501047267119 => -0.0839420065,
    _mod_binnr_exp_lgt > -3.61501047267119                                => final_score_18_c293,
    _mod_binnr_exp_lgt = NULL                                             => -0.0212363702,
                                                                             -0.0212363702);

final_score_18 := map(
    NULL < _mod_binnr_exp_lgt AND _mod_binnr_exp_lgt <= -1.0437435187915 => final_score_18_c292,
    _mod_binnr_exp_lgt > -1.0437435187915                                => 0.0430276000,
    _mod_binnr_exp_lgt = NULL                                            => -0.0012519962,
                                                                            -0.0012519962);

final_score_19_c300 := map(
    NULL < mth_internal_ver_first_seen AND mth_internal_ver_first_seen <= 7.5 => 0.1460564935,
    mth_internal_ver_first_seen > 7.5                                         => 0.0876302270,
    mth_internal_ver_first_seen = NULL                                        => -0.0115593260,
                                                                                 0.0139399932);

final_score_19_c299 := map(
    NULL < mth_source_ppca_lseen AND mth_source_ppca_lseen <= 35.5 => final_score_19_c300,
    mth_source_ppca_lseen > 35.5                                   => -0.0965509360,
    mth_source_ppca_lseen = NULL                                   => -0.0233622318,
                                                                      -0.0213520939);

final_score_19_c298 := map(
    NULL < mth_source_ppdid_lseen AND mth_source_ppdid_lseen <= 15.5 => 0.0314707603,
    mth_source_ppdid_lseen > 15.5                                    => -0.0344157857,
    mth_source_ppdid_lseen = NULL                                    => final_score_19_c299,
                                                                        -0.0154822321);

final_score_19_c297 := map(
    NULL < mth_source_exp_fseen AND mth_source_exp_fseen <= 45.5 => 0.0283923476,
    mth_source_exp_fseen > 45.5                                  => -0.0978035156,
    mth_source_exp_fseen = NULL                                  => final_score_19_c298,
                                                                    -0.0144409319);

final_score_19 := map(
    NULL < mth_exp_last_update AND mth_exp_last_update <= 33.5 => 0.0453873944,
    mth_exp_last_update > 33.5                                 => -0.0038773216,
    mth_exp_last_update = NULL                                 => final_score_19_c297,
                                                                  0.0023188945);

final_score_20_c304 := map(
    NULL < _mod_disc_exp_lgt AND _mod_disc_exp_lgt <= 0.462006176219491 => -0.0355667224,
    _mod_disc_exp_lgt > 0.462006176219491                               => 0.0070745546,
    _mod_disc_exp_lgt = NULL                                            => -0.0013195369,
                                                                           -0.0013195369);

final_score_20_c303 := map(
    NULL < f_varrisktype_i AND f_varrisktype_i <= 2.5 => final_score_20_c304,
    f_varrisktype_i > 2.5                             => -0.0478523724,
    f_varrisktype_i = NULL                            => -0.0067288957,
                                                         -0.0067288957);

final_score_20_c302 := map(
    NULL < _mod_binnr_exp_lgt AND _mod_binnr_exp_lgt <= -3.17411587002869 => -0.0608078723,
    _mod_binnr_exp_lgt > -3.17411587002869                                => final_score_20_c303,
    _mod_binnr_exp_lgt = NULL                                             => -0.0202707835,
                                                                             -0.0202707835);

final_score_20_c305 := map(
    NULL < _mod_binnr_exp_lgt AND _mod_binnr_exp_lgt <= 0.102128765100908 => 0.0200099910,
    _mod_binnr_exp_lgt > 0.102128765100908                                => 0.0785928844,
    _mod_binnr_exp_lgt = NULL                                             => 0.0411764326,
                                                                             0.0411764326);

final_score_20 := map(
    NULL < _mod_binnr_exp_lgt AND _mod_binnr_exp_lgt <= -1.17356020454495 => final_score_20_c302,
    _mod_binnr_exp_lgt > -1.17356020454495                                => final_score_20_c305,
    _mod_binnr_exp_lgt = NULL                                             => -0.0001584098,
                                                                             -0.0001584098);

final_score_21_c310 := map(
    NULL < mth_source_ppdid_lseen AND mth_source_ppdid_lseen <= 32.5 => 0.0254486024,
    mth_source_ppdid_lseen > 32.5                                    => -0.0292366272,
    mth_source_ppdid_lseen = NULL                                    => -0.0020259007,
                                                                        0.0026360552);

final_score_21_c309 := map(
    NULL < _mod_binnr_exp_lgt AND _mod_binnr_exp_lgt <= -3.91306574287261 => -0.0877242865,
    _mod_binnr_exp_lgt > -3.91306574287261                                => final_score_21_c310,
    _mod_binnr_exp_lgt = NULL                                             => -0.0041283728,
                                                                             -0.0041283728);

final_score_21_c308 := map(
    NULL < mth_source_exp_lseen AND mth_source_exp_lseen <= 32.5 => 0.0349217747,
    mth_source_exp_lseen > 32.5                                  => -0.0491972889,
    mth_source_exp_lseen = NULL                                  => final_score_21_c309,
                                                                    -0.0010568596);

final_score_21_c307 := map(
    (phone_subject_title in ['Associate', 'Associate By Property', 'Associate By Shared Associates', 'Associate By Vehicle', 'Grandchild', 'Grandparent', 'Husband', 'Neighbor', 'Parent', 'Spouse'])                                                                                                => -0.0566952539,
    (phone_subject_title in ['Associate By Address', 'Associate By Business', 'Associate By SSN', 'Brother', 'Child', 'Daughter', 'Father', 'Granddaughter', 'Grandfather', 'Grandmother', 'Grandson', 'Mother', 'Relative', 'Sibling', 'Sister', 'Son', 'Subject', 'Subject at Household', 'Wife']) => final_score_21_c308,
    phone_subject_title = ''                                                                                                                                                                                                                                                                       => -0.0093175891,
                                                                                                                                                                                                                                                                                                        -0.0093175891);

final_score_21 := map(
    NULL < number_of_sources AND number_of_sources <= 2.5 => final_score_21_c307,
    number_of_sources > 2.5                               => 0.0553921680,
    number_of_sources = NULL                              => 0.0004448946,
                                                             0.0004448946);

final_score_22_c315 := map(
    NULL < (integer)_phone_match_code_lns AND (integer)_phone_match_code_lns <= 0.5 => -0.0048210714,
    (integer)_phone_match_code_lns > 0.5                                   => 0.1165989207,
    (integer)_phone_match_code_lns = NULL                                  => 0.0064966429,
                                                                     0.0064966429);

final_score_22_c314 := map(
    (phone_subject_title in ['Associate', 'Associate By Address', 'Associate By Business', 'Associate By Property', 'Associate By Shared Associates', 'Associate By SSN', 'Associate By Vehicle', 'Brother', 'Grandfather', 'Grandparent', 'Grandson', 'Mother', 'Neighbor', 'Parent', 'Spouse', 'Subject']) => -0.0425203119,
    (phone_subject_title in ['Child', 'Daughter', 'Father', 'Grandchild', 'Granddaughter', 'Grandmother', 'Husband', 'Relative', 'Sibling', 'Sister', 'Son', 'Subject at Household', 'Wife'])                                                                                                                => final_score_22_c315,
    phone_subject_title = ''                                                                                                                                                                                                                                                                               => -0.0286015943,
                                                                                                                                                                                                                                                                                                                -0.0286015943);

final_score_22_c313 := map(
    NULL < mth_source_exp_lseen AND mth_source_exp_lseen <= 10.5 => 0.0625651725,
    mth_source_exp_lseen > 10.5                                  => -0.0422543609,
    mth_source_exp_lseen = NULL                                  => final_score_22_c314,
                                                                    -0.0249695462);

final_score_22_c312 := map(
    NULL < mth_internal_ver_first_seen AND mth_internal_ver_first_seen <= 8.5 => 0.0258312885,
    mth_internal_ver_first_seen > 8.5                                         => -0.0105441769,
    mth_internal_ver_first_seen = NULL                                        => final_score_22_c313,
                                                                                 -0.0147390127);

final_score_22 := map(
    NULL < mth_exp_last_update AND mth_exp_last_update <= 15.5 => 0.0403913208,
    mth_exp_last_update > 15.5                                 => 0.0118212217,
    mth_exp_last_update = NULL                                 => final_score_22_c312,
                                                                  0.0002284672);

final_score_23_c318 := map(
    NULL < mth_source_ppdid_lseen AND mth_source_ppdid_lseen <= 9.5 => 0.0270048922,
    mth_source_ppdid_lseen > 9.5                                    => -0.1303816367,
    mth_source_ppdid_lseen = NULL                                   => -0.0377693399,
                                                                       -0.0411189711);

final_score_23_c317 := map(
    NULL < f_srchvelocityrisktype_i AND f_srchvelocityrisktype_i <= 5.5 => 0.0410623842,
    f_srchvelocityrisktype_i > 5.5                                      => final_score_23_c318,
    f_srchvelocityrisktype_i = NULL                                     => 0.0080933377,
                                                                           0.0080933377);

final_score_23_c320 := map(
    NULL < mth_internal_ver_first_seen AND mth_internal_ver_first_seen <= 28.5 => 0.0106032765,
    mth_internal_ver_first_seen > 28.5                                         => -0.0311657038,
    mth_internal_ver_first_seen = NULL                                         => -0.0236562367,
                                                                                  -0.0141884787);

final_score_23_c319 := map(
    NULL < mth_source_exp_lseen AND mth_source_exp_lseen <= 10.5 => 0.0641578248,
    mth_source_exp_lseen > 10.5                                  => -0.0242065204,
    mth_source_exp_lseen = NULL                                  => final_score_23_c320,
                                                                    -0.0115683978);

final_score_23 := map(
    NULL < mth_exp_last_update AND mth_exp_last_update <= 13.5 => 0.0420913965,
    mth_exp_last_update > 13.5                                 => final_score_23_c317,
    mth_exp_last_update = NULL                                 => final_score_23_c319,
                                                                  0.0019409528);

final_score_24_c325 := map(
    NULL < f_prevaddrmedianincome_d AND f_prevaddrmedianincome_d <= 37480.5 => 0.0382474566,
    f_prevaddrmedianincome_d > 37480.5                                      => -0.0172345837,
    f_prevaddrmedianincome_d = NULL                                         => -0.0024813840,
                                                                               -0.0024813840);

final_score_24_c324 := map(
    (eda_pfrd_address_ind in ['1A', '1B', '1D', '1E']) => final_score_24_c325,
    (eda_pfrd_address_ind in ['1C', 'XX'])             => 0.0438508085,
    eda_pfrd_address_ind = ''                        => 0.0109138866,
                                                          0.0109138866);

final_score_24_c323 := map(
    NULL < mth_pp_app_npa_last_change_dt AND mth_pp_app_npa_last_change_dt <= 54.5 => 0.0254795025,
    mth_pp_app_npa_last_change_dt > 54.5                                           => -0.0143704558,
    mth_pp_app_npa_last_change_dt = NULL                                           => final_score_24_c324,
                                                                                      -0.0026280814);

final_score_24_c322 := map(
    (phone_subject_title in ['Associate', 'Associate By Property', 'Associate By SSN', 'Associate By Vehicle', 'Grandchild', 'Granddaughter', 'Grandparent', 'Neighbor', 'Parent', 'Sister'])                                                                                                                => -0.0651924752,
    (phone_subject_title in ['Associate By Address', 'Associate By Business', 'Associate By Shared Associates', 'Brother', 'Child', 'Daughter', 'Father', 'Grandfather', 'Grandmother', 'Grandson', 'Husband', 'Mother', 'Relative', 'Sibling', 'Son', 'Spouse', 'Subject', 'Subject at Household', 'Wife']) => final_score_24_c323,
    phone_subject_title = ''                                                                                                                                                                                                                                                                               => -0.0104258102,
                                                                                                                                                                                                                                                                                                                -0.0104258102);

final_score_24 := map(
    NULL < _mod_binnr_exp_lgt AND _mod_binnr_exp_lgt <= -0.214836171996587 => final_score_24_c322,
    _mod_binnr_exp_lgt > -0.214836171996587                                => 0.0509903734,
    _mod_binnr_exp_lgt = NULL                                              => -0.0000130376,
                                                                              -0.0000130376);

final_score_25_c330 := map(
    NULL < mth_source_exp_lseen AND mth_source_exp_lseen <= 8.5 => 0.0599360246,
    mth_source_exp_lseen > 8.5                                  => -0.0307003858,
    mth_source_exp_lseen = NULL                                 => -0.0303792163,
                                                                   -0.0209268944);

final_score_25_c329 := map(
    NULL < r_a49_curr_avm_chg_1yr_i AND r_a49_curr_avm_chg_1yr_i <= 363 => 0.0448934351,
    r_a49_curr_avm_chg_1yr_i > 363                                      => -0.0121573350,
    r_a49_curr_avm_chg_1yr_i = NULL                                     => final_score_25_c330,
                                                                           -0.0105468374);

final_score_25_c328 := map(
    NULL < mth_source_ppdid_lseen AND mth_source_ppdid_lseen <= 41.5 => 0.0087305454,
    mth_source_ppdid_lseen > 41.5                                    => -0.0703009426,
    mth_source_ppdid_lseen = NULL                                    => final_score_25_c329,
                                                                        -0.0087201493);

final_score_25_c327 := map(
    NULL < r_c14_addrs_5yr_i AND r_c14_addrs_5yr_i <= 1.5 => 0.0213569563,
    r_c14_addrs_5yr_i > 1.5                               => final_score_25_c328,
    r_c14_addrs_5yr_i = NULL                              => 0.0075638773,
                                                             0.0075638773);

final_score_25 := map(
    (phone_subject_title in ['Associate', 'Associate By Property', 'Associate By Vehicle', 'Daughter', 'Father', 'Grandmother', 'Grandparent', 'Husband', 'Neighbor', 'Parent', 'Sibling', 'Sister', 'Spouse'])                                                                            => -0.0446100347,
    (phone_subject_title in ['Associate By Address', 'Associate By Business', 'Associate By Shared Associates', 'Associate By SSN', 'Brother', 'Child', 'Grandchild', 'Granddaughter', 'Grandfather', 'Grandson', 'Mother', 'Relative', 'Son', 'Subject', 'Subject at Household', 'Wife']) => final_score_25_c327,
    phone_subject_title = ''                                                                                                                                                                                                                                                             => 0.0000399525,
                                                                                                                                                                                                                                                                                              0.0000399525);

final_score_26_c334 := map(
    NULL < f_util_adl_count_n AND f_util_adl_count_n <= 1.5 => 0.0374939233,
    f_util_adl_count_n > 1.5                                => -0.0088050099,
    f_util_adl_count_n = NULL                               => 0.0119564361,
                                                               0.0119564361);

final_score_26_c333 := map(
    NULL < f_inq_collection_count_i AND f_inq_collection_count_i <= 1.5 => final_score_26_c334,
    f_inq_collection_count_i > 1.5                                      => -0.0159355964,
    f_inq_collection_count_i = NULL                                     => -0.0052785539,
                                                                           -0.0052785539);

final_score_26_c332 := map(
    (phone_subject_title in ['Associate', 'Associate By Property', 'Associate By Vehicle', 'Daughter', 'Father', 'Grandchild', 'Grandfather', 'Grandmother', 'Grandparent', 'Neighbor', 'Parent'])                                                                                                      => -0.0609174777,
    (phone_subject_title in ['Associate By Address', 'Associate By Business', 'Associate By Shared Associates', 'Associate By SSN', 'Brother', 'Child', 'Granddaughter', 'Grandson', 'Husband', 'Mother', 'Relative', 'Sibling', 'Sister', 'Son', 'Spouse', 'Subject', 'Subject at Household', 'Wife']) => final_score_26_c333,
    phone_subject_title = ''                                                                                                                                                                                                                                                                          => -0.0140775302,
                                                                                                                                                                                                                                                                                                           -0.0140775302);

final_score_26_c335 := map(
    NULL < f_srchfraudsrchcount_i AND f_srchfraudsrchcount_i <= 3.5 => 0.0502942716,
    f_srchfraudsrchcount_i > 3.5                                    => 0.0012798717,
    f_srchfraudsrchcount_i = NULL                                   => 0.0296995646,
                                                                       0.0296995646);

final_score_26 := map(
    NULL < number_of_sources AND number_of_sources <= 1.5 => final_score_26_c332,
    number_of_sources > 1.5                               => final_score_26_c335,
    number_of_sources = NULL                              => 0.0001158315,
                                                             0.0001158315);

final_score_27_c337 := map(
    NULL < r_a49_curr_avm_chg_1yr_i AND r_a49_curr_avm_chg_1yr_i <= 6563.5 => 0.0104389238,
    r_a49_curr_avm_chg_1yr_i > 6563.5                                      => -0.0215683525,
    r_a49_curr_avm_chg_1yr_i = NULL                                        => -0.0404692856,
                                                                              -0.0260465407);

final_score_27_c339 := map(
    (phone_subject_title in ['Associate', 'Associate By Property', 'Associate By Shared Associates', 'Associate By SSN', 'Associate By Vehicle', 'Brother', 'Father', 'Grandfather', 'Grandson', 'Neighbor', 'Parent', 'Spouse', 'Wife'])                        => -0.0372053393,
    (phone_subject_title in ['Associate By Address', 'Associate By Business', 'Child', 'Daughter', 'Grandchild', 'Granddaughter', 'Grandmother', 'Grandparent', 'Husband', 'Mother', 'Relative', 'Sibling', 'Sister', 'Son', 'Subject', 'Subject at Household']) => 0.0315402632,
    phone_subject_title = ''                                                                                                                                                                                                                                   => 0.0264954476,
                                                                                                                                                                                                                                                                    0.0264954476);

final_score_27_c340 := map(
    NULL < mth_source_exp_lseen AND mth_source_exp_lseen <= 8.5 => 0.0348914196,
    mth_source_exp_lseen > 8.5                                  => -0.0470074097,
    mth_source_exp_lseen = NULL                                 => -0.0016934148,
                                                                   -0.0039001421);

final_score_27_c338 := map(
    NULL < f_inq_count_i AND f_inq_count_i <= 8.5 => final_score_27_c339,
    f_inq_count_i > 8.5                           => final_score_27_c340,
    f_inq_count_i = NULL                          => 0.0125128264,
                                                     0.0125128264);

final_score_27 := map(
    NULL < _mod_binnr_exp_lgt AND _mod_binnr_exp_lgt <= -2.45130944371694 => final_score_27_c337,
    _mod_binnr_exp_lgt > -2.45130944371694                                => final_score_27_c338,
    _mod_binnr_exp_lgt = NULL                                             => -0.0008183532,
                                                                             -0.0008183532);

final_score_28_c344 := map(
    NULL < _pp_rule_cellphone_latest AND _pp_rule_cellphone_latest <= 0.5 => -0.0082572417,
    _pp_rule_cellphone_latest > 0.5                                       => -0.0924027277,
    _pp_rule_cellphone_latest = NULL                                      => -0.0182177900,
                                                                             -0.0182177900);

final_score_28_c343 := map(
    NULL < mth_source_ppdid_fseen AND mth_source_ppdid_fseen <= 48.5 => 0.0128367929,
    mth_source_ppdid_fseen > 48.5                                    => -0.1019316572,
    mth_source_ppdid_fseen = NULL                                    => final_score_28_c344,
                                                                        -0.0189988467);

final_score_28_c345 := map(
    NULL < f_varrisktype_i AND f_varrisktype_i <= 2.5 => 0.0248336332,
    f_varrisktype_i > 2.5                             => -0.0219524618,
    f_varrisktype_i = NULL                            => 0.0197042052,
                                                         0.0197042052);

final_score_28_c342 := map(
    NULL < (integer)_phone_match_code_c AND (integer)_phone_match_code_c <= 0.5 => final_score_28_c343,
    (integer)_phone_match_code_c > 0.5                                 => final_score_28_c345,
    (integer)_phone_match_code_c = NULL                                => 0.0106141071,
                                                                 0.0106141071);

final_score_28 := map(
    NULL < _mod_binnr_exp_lgt AND _mod_binnr_exp_lgt <= -2.90569942204534 => -0.0350354970,
    _mod_binnr_exp_lgt > -2.90569942204534                                => final_score_28_c342,
    _mod_binnr_exp_lgt = NULL                                             => 0.0001294623,
                                                                             0.0001294623);

final_score_29_c347 := map(
    (phone_subject_title in ['Associate', 'Associate By Address', 'Associate By Business', 'Associate By Property', 'Associate By Shared Associates', 'Associate By SSN', 'Associate By Vehicle', 'Brother', 'Daughter', 'Father', 'Granddaughter', 'Grandmother', 'Grandparent', 'Grandson', 'Husband', 'Neighbor', 'Parent', 'Relative', 'Sibling', 'Sister', 'Spouse', 'Subject', 'Subject at Household', 'Wife']) => -0.0176975689,
    (phone_subject_title in ['Child', 'Grandchild', 'Grandfather', 'Mother', 'Son'])                                                                                                                                                                                                                                                                                                                                  => 0.0593808518,
    phone_subject_title = ''                                                                                                                                                                                                                                                                                                                                                                                        => -0.0145480389,
                                                                                                                                                                                                                                                                                                                                                                                                                         -0.0145480389);

final_score_29_c350 := map(
    (phone_subject_title in ['Associate', 'Associate By Property', 'Associate By Vehicle', 'Child', 'Father', 'Grandchild', 'Granddaughter', 'Grandmother', 'Mother', 'Neighbor', 'Parent', 'Sibling', 'Sister'])                                                                        => -0.0420408297,
    (phone_subject_title in ['Associate By Address', 'Associate By Business', 'Associate By Shared Associates', 'Associate By SSN', 'Brother', 'Daughter', 'Grandfather', 'Grandparent', 'Grandson', 'Husband', 'Relative', 'Son', 'Spouse', 'Subject', 'Subject at Household', 'Wife']) => 0.0249306181,
    phone_subject_title = ''                                                                                                                                                                                                                                                           => 0.0194168574,
                                                                                                                                                                                                                                                                                            0.0194168574);

final_score_29_c349 := map(
    NULL < f_inq_other_count_i AND f_inq_other_count_i <= 3.5 => final_score_29_c350,
    f_inq_other_count_i > 3.5                                 => -0.0262315979,
    f_inq_other_count_i = NULL                                => 0.0126755672,
                                                                 0.0126755672);

final_score_29_c348 := map(
    NULL < _mod_binnr_exp_lgt AND _mod_binnr_exp_lgt <= -3.70178743192143 => -0.0737749378,
    _mod_binnr_exp_lgt > -3.70178743192143                                => final_score_29_c349,
    _mod_binnr_exp_lgt = NULL                                             => 0.0021394331,
                                                                             0.0021394331);

final_score_29 := map(
    NULL < (integer)inq_adl_firstseen_n AND (integer)inq_adl_firstseen_n <= 0.5 => final_score_29_c347,
    (integer)inq_adl_firstseen_n > 0.5                                 => 0.0291082233,
    (integer)inq_adl_firstseen_n = NULL                                => final_score_29_c348,
                                                                 0.0012016098);

final_score_30_c354 := map(
    NULL < mth_pp_datevendorfirstseen AND mth_pp_datevendorfirstseen <= 33.5 => -0.0804059084,
    mth_pp_datevendorfirstseen > 33.5                                        => 0.0367892600,
    mth_pp_datevendorfirstseen = NULL                                        => -0.0562835756,
                                                                                -0.0367347839);

final_score_30_c353 := map(
    NULL < mth_source_exp_lseen AND mth_source_exp_lseen <= 10.5 => 0.0496386107,
    mth_source_exp_lseen > 10.5                                  => final_score_30_c354,
    mth_source_exp_lseen = NULL                                  => -0.0117361294,
                                                                    -0.0107668721);

final_score_30_c355 := map(
    (phone_subject_title in ['Associate By Property', 'Associate By Shared Associates', 'Associate By SSN', 'Associate By Vehicle', 'Child', 'Father', 'Grandchild', 'Grandson', 'Husband', 'Mother', 'Neighbor', 'Parent', 'Sibling', 'Spouse', 'Subject at Household', 'Wife']) => -0.0452207576,
    (phone_subject_title in ['Associate', 'Associate By Address', 'Associate By Business', 'Brother', 'Daughter', 'Granddaughter', 'Grandfather', 'Grandmother', 'Grandparent', 'Relative', 'Sister', 'Son', 'Subject'])                                                          => 0.0710428736,
    phone_subject_title = ''                                                                                                                                                                                                                                                    => 0.0336261123,
                                                                                                                                                                                                                                                                                     0.0336261123);

final_score_30_c352 := map(
    NULL < r_c13_max_lres_d AND r_c13_max_lres_d <= 382.5 => final_score_30_c353,
    r_c13_max_lres_d > 382.5                              => final_score_30_c355,
    r_c13_max_lres_d = NULL                               => -0.0073839195,
                                                             -0.0073839195);

final_score_30 := map(
    NULL < mth_exp_last_update AND mth_exp_last_update <= 34.5 => 0.0294057594,
    mth_exp_last_update > 34.5                                 => 0.0076133703,
    mth_exp_last_update = NULL                                 => final_score_30_c352,
                                                                  0.0034305652);

final_score_31_c358 := map(
    NULL < _phone_timezone_match AND _phone_timezone_match <= 0.5 => -0.1213381111,
    _phone_timezone_match > 0.5                                   => 0.0173871100,
    _phone_timezone_match = NULL                                  => 0.0078294118,
                                                                     0.0078294118);

final_score_31_c360 := map(
    (phone_subject_title in ['Associate', 'Associate By Address', 'Associate By Business', 'Associate By Property', 'Associate By Shared Associates', 'Associate By Vehicle', 'Daughter', 'Father', 'Grandchild', 'Grandfather', 'Grandmother', 'Grandparent', 'Husband', 'Neighbor', 'Parent', 'Relative', 'Subject', 'Subject at Household']) => -0.0157842950,
    (phone_subject_title in ['Associate By SSN', 'Brother', 'Child', 'Granddaughter', 'Grandson', 'Mother', 'Sibling', 'Sister', 'Son', 'Spouse', 'Wife'])                                                                                                                                                                                      => 0.0388602919,
    phone_subject_title = ''                                                                                                                                                                                                                                                                                                                  => -0.0115514763,
                                                                                                                                                                                                                                                                                                                                                   -0.0115514763);

final_score_31_c359 := map(
    NULL < mth_source_ppca_lseen AND mth_source_ppca_lseen <= 23.5 => 0.0135693611,
    mth_source_ppca_lseen > 23.5                                   => -0.0692784605,
    mth_source_ppca_lseen = NULL                                   => final_score_31_c360,
                                                                      -0.0111702364);

final_score_31_c357 := map(
    NULL < mth_source_exp_lseen AND mth_source_exp_lseen <= 43.5 => final_score_31_c358,
    mth_source_exp_lseen > 43.5                                  => -0.0694478600,
    mth_source_exp_lseen = NULL                                  => final_score_31_c359,
                                                                    -0.0100297367);

final_score_31 := map(
    NULL < number_of_sources AND number_of_sources <= 2.5 => final_score_31_c357,
    number_of_sources > 2.5                               => 0.0380039478,
    number_of_sources = NULL                              => -0.0026356200,
                                                             -0.0026356200);

final_score_32_c363 := map(
    (phone_subject_title in ['Associate', 'Associate By Address', 'Associate By Business', 'Associate By SSN', 'Brother', 'Father', 'Granddaughter', 'Grandmother', 'Husband', 'Neighbor', 'Relative', 'Sibling', 'Sister', 'Son', 'Subject', 'Subject at Household', 'Wife']) => -0.0389449833,
    (phone_subject_title in ['Associate By Property', 'Associate By Shared Associates', 'Associate By Vehicle', 'Child', 'Daughter', 'Grandchild', 'Grandfather', 'Grandparent', 'Grandson', 'Mother', 'Parent', 'Spouse'])                                                    => 0.1897289444,
    phone_subject_title = ''                                                                                                                                                                                                                                                 => -0.0335575170,
                                                                                                                                                                                                                                                                                  -0.0335575170);

final_score_32_c365 := map(
    NULL < (integer)_inq_adl_ph_industry_flag AND (integer)_inq_adl_ph_industry_flag <= 0.5 => -0.0260690382,
    (integer)_inq_adl_ph_industry_flag > 0.5                                       => 0.0525037371,
    (integer)_inq_adl_ph_industry_flag = NULL                                      => -0.0113080804,
                                                                             -0.0113080804);

final_score_32_c364 := map(
    NULL < f_inq_count_i AND f_inq_count_i <= 16.5 => 0.0159183059,
    f_inq_count_i > 16.5                           => final_score_32_c365,
    f_inq_count_i = NULL                           => 0.0097593815,
                                                      0.0097593815);

final_score_32_c362 := map(
    NULL < _mod_binnr_exp_lgt AND _mod_binnr_exp_lgt <= -2.94767276556849 => final_score_32_c363,
    _mod_binnr_exp_lgt > -2.94767276556849                                => final_score_32_c364,
    _mod_binnr_exp_lgt = NULL                                             => 0.0003184457,
                                                                             0.0003184457);

final_score_32 := map(
    NULL < _phone_timezone_match AND _phone_timezone_match <= 0.5 => -0.0468883671,
    _phone_timezone_match > 0.5                                   => final_score_32_c362,
    _phone_timezone_match = NULL                                  => -0.0034174186,
                                                                     -0.0034174186);

final_score_33_c368 := map(
    NULL < mth_source_exp_lseen AND mth_source_exp_lseen <= 43.5 => 0.0277164117,
    mth_source_exp_lseen > 43.5                                  => -0.1308722597,
    mth_source_exp_lseen = NULL                                  => -0.0179697285,
                                                                    -0.0151103339);

final_score_33_c370 := map(
    NULL < f_rel_incomeover25_count_d AND f_rel_incomeover25_count_d <= 26.5 => 0.0021628511,
    f_rel_incomeover25_count_d > 26.5                                        => -0.0412555988,
    f_rel_incomeover25_count_d = NULL                                        => -0.1837139729,
                                                                                -0.0019323675);

final_score_33_c369 := map(
    NULL < r_f01_inp_addr_address_score_d AND r_f01_inp_addr_address_score_d <= 5 => -0.0689861452,
    r_f01_inp_addr_address_score_d > 5                                            => final_score_33_c370,
    r_f01_inp_addr_address_score_d = NULL                                         => -0.0030637793,
                                                                                     -0.0030637793);

final_score_33_c367 := map(
    NULL < r_a49_curr_avm_chg_1yr_i AND r_a49_curr_avm_chg_1yr_i <= 4089 => 0.0194126204,
    r_a49_curr_avm_chg_1yr_i > 4089                                      => final_score_33_c368,
    r_a49_curr_avm_chg_1yr_i = NULL                                      => final_score_33_c369,
                                                                            -0.0009411035);

final_score_33 := map(
    NULL < _mod_binnr_exp_lgt AND _mod_binnr_exp_lgt <= 0.113952383043796 => final_score_33_c367,
    _mod_binnr_exp_lgt > 0.113952383043796                                => 0.0596255619,
    _mod_binnr_exp_lgt = NULL                                             => 0.0060261098,
                                                                             0.0060261098);

final_score_34_c373 := map(
    NULL < mth_source_ppdid_lseen AND mth_source_ppdid_lseen <= 28.5 => 0.0222178673,
    mth_source_ppdid_lseen > 28.5                                    => -0.0263324409,
    mth_source_ppdid_lseen = NULL                                    => -0.0035074720,
                                                                        0.0006735716);

final_score_34_c375 := map(
    NULL < f_assocsuspicousidcount_i AND f_assocsuspicousidcount_i <= 6.5 => 0.0305172273,
    f_assocsuspicousidcount_i > 6.5                                       => -0.1816767415,
    f_assocsuspicousidcount_i = NULL                                      => 0.0222762997,
                                                                             0.0222762997);

final_score_34_c374 := map(
    (phone_subject_title in ['Associate', 'Husband', 'Mother', 'Relative', 'Subject', 'Subject at Household', 'Wife'])                                                                                                                                                                                                                                                              => final_score_34_c375,
    (phone_subject_title in ['Associate By Address', 'Associate By Business', 'Associate By Property', 'Associate By Shared Associates', 'Associate By SSN', 'Associate By Vehicle', 'Brother', 'Child', 'Daughter', 'Father', 'Grandchild', 'Granddaughter', 'Grandfather', 'Grandmother', 'Grandparent', 'Grandson', 'Neighbor', 'Parent', 'Sibling', 'Sister', 'Son', 'Spouse']) => 0.1122225541,
    phone_subject_title = ''                                                                                                                                                                                                                                                                                                                                                      => 0.0382406244,
                                                                                                                                                                                                                                                                                                                                                                                       0.0382406244);

final_score_34_c372 := map(
    NULL < (integer)_internal_ver_match_hhid AND (integer)_internal_ver_match_hhid <= 0.5 => final_score_34_c373,
    (integer)_internal_ver_match_hhid > 0.5                                      => final_score_34_c374,
    (integer)_internal_ver_match_hhid = NULL                                     => 0.0049594100,
                                                                           0.0049594100);

final_score_34 := map(
    NULL < _mod_binnr_exp_lgt AND _mod_binnr_exp_lgt <= -3.91278968582422 => -0.0757317536,
    _mod_binnr_exp_lgt > -3.91278968582422                                => final_score_34_c372,
    _mod_binnr_exp_lgt = NULL                                             => -0.0012014255,
                                                                             -0.0012014255);

final_score_35_c378 := map(
    NULL < r_c13_avg_lres_d AND r_c13_avg_lres_d <= 78.5 => -0.0867315376,
    r_c13_avg_lres_d > 78.5                              => -0.0041774148,
    r_c13_avg_lres_d = NULL                              => -0.0360435265,
                                                            -0.0360435265);

final_score_35_c380 := map(
    NULL < eda_max_days_interrupt AND eda_max_days_interrupt <= 281.5 => -0.0017483356,
    eda_max_days_interrupt > 281.5                                    => -0.0346114604,
    eda_max_days_interrupt = NULL                                     => -0.0115194807,
                                                                         -0.0115194807);

final_score_35_c379 := map(
    (phone_subject_title in ['Associate', 'Associate By Address', 'Associate By Property', 'Associate By Shared Associates', 'Associate By Vehicle', 'Brother', 'Daughter', 'Father', 'Grandparent', 'Grandson', 'Mother', 'Neighbor', 'Parent', 'Relative', 'Sister', 'Spouse', 'Subject', 'Subject at Household', 'Wife']) => final_score_35_c380,
    (phone_subject_title in ['Associate By Business', 'Associate By SSN', 'Child', 'Grandchild', 'Granddaughter', 'Grandfather', 'Grandmother', 'Husband', 'Sibling', 'Son'])                                                                                                                                                => 0.0580152674,
    phone_subject_title = ''                                                                                                                                                                                                                                                                                               => -0.0092952851,
                                                                                                                                                                                                                                                                                                                                -0.0092952851);

final_score_35_c377 := map(
    NULL < mth_source_ppca_fseen AND mth_source_ppca_fseen <= 21.5 => 0.0310578551,
    mth_source_ppca_fseen > 21.5                                   => final_score_35_c378,
    mth_source_ppca_fseen = NULL                                   => final_score_35_c379,
                                                                      -0.0087021523);

final_score_35 := map(
    NULL < mth_exp_last_update AND mth_exp_last_update <= 61.5 => 0.0206259362,
    mth_exp_last_update > 61.5                                 => -0.0237709912,
    mth_exp_last_update = NULL                                 => final_score_35_c377,
                                                                  -0.0002135441);

final_score_36_c384 := map(
    (pp_source in ['CELL', 'GONG', 'IBEHAVIOR', 'PCNSR', 'THRIVE'])                   => -0.1174120233,
    (pp_source in ['', 'HEADER', 'INFUTOR', 'INQUIRY', 'INTRADO', 'OTHER', 'TARGUS']) => -0.0286812007,
    pp_source = ''                                                                  => -0.0348667909,
                                                                                         -0.0348667909);

final_score_36_c383 := map(
    NULL < mth_pp_first_build_date AND mth_pp_first_build_date <= 33.5 => final_score_36_c384,
    mth_pp_first_build_date > 33.5                                     => 0.0308100806,
    mth_pp_first_build_date = NULL                                     => -0.0252330240,
                                                                          -0.0252330240);

final_score_36_c382 := map(
    NULL < _mod_binnr_exp_lgt AND _mod_binnr_exp_lgt <= -0.295267115136119 => final_score_36_c383,
    _mod_binnr_exp_lgt > -0.295267115136119                                => 0.0236399254,
    _mod_binnr_exp_lgt = NULL                                              => -0.0129911364,
                                                                              -0.0129911364);

final_score_36_c385 := map(
    (phone_subject_title in ['Associate', 'Associate By Address', 'Associate By Property', 'Associate By Shared Associates', 'Associate By SSN', 'Associate By Vehicle', 'Child', 'Daughter', 'Granddaughter', 'Grandparent', 'Grandson', 'Mother', 'Neighbor', 'Sibling', 'Spouse']) => -0.0187223140,
    (phone_subject_title in ['Associate By Business', 'Brother', 'Father', 'Grandchild', 'Grandfather', 'Grandmother', 'Husband', 'Parent', 'Relative', 'Sister', 'Son', 'Subject', 'Subject at Household', 'Wife'])                                                                  => 0.0203898742,
    phone_subject_title = ''                                                                                                                                                                                                                                                        => 0.0075875558,
                                                                                                                                                                                                                                                                                         0.0075875558);

final_score_36 := map(
    (pp_origphonetype in ['V', 'W'])     => final_score_36_c382,
    (pp_origphonetype in ['', 'L', 'O']) => final_score_36_c385,
    pp_origphonetype = ''              => 0.0004464135,
                                            0.0004464135);

final_score_37_c388 := map(
    NULL < r_c10_m_hdr_fs_d AND r_c10_m_hdr_fs_d <= 207.5 => -0.0339467191,
    r_c10_m_hdr_fs_d > 207.5                              => 0.0211216438,
    r_c10_m_hdr_fs_d = NULL                               => 0.0167362058,
                                                             0.0167362058);

final_score_37_c387 := map(
    (pp_rp_source in ['GONG', 'HEADER', 'IBEHAVIOR', 'INQUIRY', 'INTRADO', 'PCNSR', 'TARGUS', 'THRIVE']) => -0.0495902414,
    (pp_rp_source in ['', 'CELL', 'INFUTOR', 'OTHER'])                                                   => final_score_37_c388,
    pp_rp_source = ''                                                                                  => 0.0126784934,
                                                                                                            0.0126784934);

final_score_37_c390 := map(
    NULL < (integer)inq_adl_lastseen_n AND (integer)inq_adl_lastseen_n <= 55.5 => -0.0085276373,
    (integer)inq_adl_lastseen_n > 55.5                                => -0.0882575375,
    (integer)inq_adl_lastseen_n = NULL                                => -0.0119252655,
                                                                -0.0125932034);

final_score_37_c389 := map(
    (phone_subject_title in ['Associate', 'Associate By Address', 'Associate By Property', 'Associate By Shared Associates', 'Associate By SSN', 'Associate By Vehicle', 'Brother', 'Father', 'Grandchild', 'Granddaughter', 'Grandmother', 'Grandparent', 'Husband', 'Mother', 'Neighbor', 'Parent', 'Relative', 'Sister', 'Son', 'Spouse', 'Subject', 'Subject at Household', 'Wife']) => final_score_37_c390,
    (phone_subject_title in ['Associate By Business', 'Child', 'Daughter', 'Grandfather', 'Grandson', 'Sibling'])                                                                                                                                                                                                                                                                        => 0.1344984046,
    phone_subject_title = ''                                                                                                                                                                                                                                                                                                                                                           => -0.0110991876,
                                                                                                                                                                                                                                                                                                                                                                                            -0.0110991876);

final_score_37 := map(
    NULL < f_inq_count_i AND f_inq_count_i <= 8.5 => final_score_37_c387,
    f_inq_count_i > 8.5                           => final_score_37_c389,
    f_inq_count_i = NULL                          => 0.0015256244,
                                                     0.0015256244);

final_score_38_c395 := map(
    NULL < mth_exp_last_update AND mth_exp_last_update <= 13.5 => 0.0271858775,
    mth_exp_last_update > 13.5                                 => -0.0395822291,
    mth_exp_last_update = NULL                                 => 0.0003161087,
                                                                  0.0010638575);

final_score_38_c394 := map(
    NULL < r_a49_curr_avm_chg_1yr_pct_i AND r_a49_curr_avm_chg_1yr_pct_i <= 163.35 => 0.0207762631,
    r_a49_curr_avm_chg_1yr_pct_i > 163.35                                          => -0.0412285581,
    r_a49_curr_avm_chg_1yr_pct_i = NULL                                            => final_score_38_c395,
                                                                                      0.0081376564);

final_score_38_c393 := map(
    (phone_subject_title in ['Associate', 'Associate By Business', 'Associate By Property', 'Associate By Shared Associates', 'Associate By Vehicle', 'Father', 'Granddaughter', 'Grandparent', 'Mother', 'Neighbor', 'Parent', 'Sibling', 'Spouse']) => -0.0281484357,
    (phone_subject_title in ['Associate By Address', 'Associate By SSN', 'Brother', 'Child', 'Daughter', 'Grandchild', 'Grandfather', 'Grandmother', 'Grandson', 'Husband', 'Relative', 'Sister', 'Son', 'Subject', 'Subject at Household', 'Wife'])  => final_score_38_c394,
    phone_subject_title = ''                                                                                                                                                                                                                        => 0.0023776065,
                                                                                                                                                                                                                                                         0.0023776065);

final_score_38_c392 := map(
    (pp_src in ['CY', 'E2', 'EB', 'EM', 'EQ', 'FA', 'KW', 'LP', 'MD', 'NW', 'SV', 'VO', 'VW', 'YE', 'ZK', 'ZT']) => -0.0542803916,
    (pp_src in ['', 'E1', 'EN', 'FF', 'LA', 'PL', 'SL', 'TN', 'UT', 'UW'])                                       => final_score_38_c393,
    pp_src = ''                                                                                                => -0.0002888425,
                                                                                                                    -0.0002888425);

final_score_38 := map(
    NULL < mth_source_inf_fseen AND mth_source_inf_fseen <= 228.5 => -0.0087944416,
    mth_source_inf_fseen > 228.5                                  => 0.0765669069,
    mth_source_inf_fseen = NULL                                   => final_score_38_c392,
                                                                     0.0020842274);

final_score_39_c399 := map(
    NULL < mth_eda_dt_first_seen AND mth_eda_dt_first_seen <= 8.5 => -0.0660678468,
    mth_eda_dt_first_seen > 8.5                                   => -0.0180472481,
    mth_eda_dt_first_seen = NULL                                  => -0.0002777240,
                                                                     -0.0094368013);

final_score_39_c400 := map(
    NULL < f_rel_incomeover25_count_d AND f_rel_incomeover25_count_d <= 3.5 => 0.1128914426,
    f_rel_incomeover25_count_d > 3.5                                        => 0.0137130716,
    f_rel_incomeover25_count_d = NULL                                       => 0.0197851061,
                                                                               0.0197851061);

final_score_39_c398 := map(
    (phone_subject_title in ['Associate', 'Associate By Address', 'Associate By Business', 'Associate By Property', 'Associate By Shared Associates', 'Associate By SSN', 'Associate By Vehicle', 'Brother', 'Grandchild', 'Grandmother', 'Grandparent', 'Grandson', 'Neighbor', 'Parent', 'Relative', 'Sibling', 'Spouse', 'Subject']) => final_score_39_c399,
    (phone_subject_title in ['Child', 'Daughter', 'Father', 'Granddaughter', 'Grandfather', 'Husband', 'Mother', 'Sister', 'Son', 'Subject at Household', 'Wife'])                                                                                                                                                                      => final_score_39_c400,
    phone_subject_title = ''                                                                                                                                                                                                                                                                                                          => -0.0048662242,
                                                                                                                                                                                                                                                                                                                                           -0.0048662242);

final_score_39_c397 := map(
    NULL < r_f01_inp_addr_address_score_d AND r_f01_inp_addr_address_score_d <= 5 => -0.0551349435,
    r_f01_inp_addr_address_score_d > 5                                            => final_score_39_c398,
    r_f01_inp_addr_address_score_d = NULL                                         => -0.0056453966,
                                                                                     -0.0056453966);

final_score_39 := map(
    NULL < number_of_sources AND number_of_sources <= 2.5 => final_score_39_c397,
    number_of_sources > 2.5                               => 0.0357069994,
    number_of_sources = NULL                              => 0.0010218310,
                                                             0.0010218310);

final_score_40_c404 := map(
    NULL < f_add_curr_mobility_index_n AND f_add_curr_mobility_index_n <= 0.310808505145237 => -0.0785986363,
    f_add_curr_mobility_index_n > 0.310808505145237                                         => 0.0768974139,
    f_add_curr_mobility_index_n = NULL                                                      => -0.0050609863,
                                                                                               -0.0050609863);

final_score_40_c403 := map(
    NULL < f_mos_liens_unrel_cj_lseen_d AND f_mos_liens_unrel_cj_lseen_d <= 29.5 => 0.1877701372,
    f_mos_liens_unrel_cj_lseen_d > 29.5                                          => final_score_40_c404,
    f_mos_liens_unrel_cj_lseen_d = NULL                                          => 0.0299799600,
                                                                                    0.0299799600);

final_score_40_c405 := map(
    NULL < mth_source_ppdid_lseen AND mth_source_ppdid_lseen <= 50.5 => 0.0110725351,
    mth_source_ppdid_lseen > 50.5                                    => -0.0488306365,
    mth_source_ppdid_lseen = NULL                                    => 0.0026313944,
                                                                        0.0028894464);

final_score_40_c402 := map(
    NULL < mth_source_ppth_lseen AND mth_source_ppth_lseen <= 40.5 => final_score_40_c403,
    mth_source_ppth_lseen > 40.5                                   => -0.0698011777,
    mth_source_ppth_lseen = NULL                                   => final_score_40_c405,
                                                                      0.0011535148);

final_score_40 := map(
    NULL < _phone_timezone_match AND _phone_timezone_match <= 0.5 => -0.0376318993,
    _phone_timezone_match > 0.5                                   => final_score_40_c402,
    _phone_timezone_match = NULL                                  => -0.0018870971,
                                                                     -0.0018870971);

final_score_41_c408 := map(
    NULL < (integer)_phone_match_code_l AND (integer)_phone_match_code_l <= 0.5 => 0.1306256789,
    (integer)_phone_match_code_l > 0.5                                 => 0.0158100003,
    (integer)_phone_match_code_l = NULL                                => 0.0201921842,
                                                                 0.0201921842);

final_score_41_c410 := map(
    (pp_source in ['', 'CELL', 'GONG', 'IBEHAVIOR', 'INFUTOR', 'INTRADO', 'OTHER', 'PCNSR', 'THRIVE']) => -0.0081784462,
    (pp_source in ['HEADER', 'INQUIRY', 'TARGUS'])                                                     => 0.0278841075,
    pp_source = ''                                                                                   => 0.0030880663,
                                                                                                          0.0030880663);

final_score_41_c409 := map(
    NULL < _mod_disc_exp_lgt AND _mod_disc_exp_lgt <= 3.24919871797233 => final_score_41_c410,
    _mod_disc_exp_lgt > 3.24919871797233                               => -0.0744207908,
    _mod_disc_exp_lgt = NULL                                           => -0.0040703005,
                                                                          -0.0040703005);

final_score_41_c407 := map(
    NULL < (integer)inq_adl_firstseen_n AND (integer)inq_adl_firstseen_n <= 0.5 => -0.0141906267,
    (integer)inq_adl_firstseen_n > 0.5                                 => final_score_41_c408,
    (integer)inq_adl_firstseen_n = NULL                                => final_score_41_c409,
                                                                 -0.0031341802);

final_score_41 := map(
    NULL < mth_source_sx_fseen AND mth_source_sx_fseen <= 13.5 => 0.0786559566,
    mth_source_sx_fseen > 13.5                                 => 0.0418983713,
    mth_source_sx_fseen = NULL                                 => final_score_41_c407,
                                                                  0.0002490846);

final_score_42_c412 := map(
    NULL < eda_min_days_interrupt AND eda_min_days_interrupt <= 1728.5 => -0.0069124781,
    eda_min_days_interrupt > 1728.5                                    => 0.1389949026,
    eda_min_days_interrupt = NULL                                      => -0.0060137816,
                                                                          -0.0060137816);

final_score_42_c415 := map(
    NULL < f_curraddrmedianincome_d AND f_curraddrmedianincome_d <= 24161 => -0.0996965515,
    f_curraddrmedianincome_d > 24161                                      => 0.0479713904,
    f_curraddrmedianincome_d = NULL                                       => 0.0422769095,
                                                                             0.0422769095);

final_score_42_c414 := map(
    NULL < f_rel_under25miles_cnt_d AND f_rel_under25miles_cnt_d <= 5.5 => 0.0041421435,
    f_rel_under25miles_cnt_d > 5.5                                      => final_score_42_c415,
    f_rel_under25miles_cnt_d = NULL                                     => 0.0291894419,
                                                                           0.0291894419);

final_score_42_c413 := map(
    NULL < mth_pp_orig_lastseen AND mth_pp_orig_lastseen <= 2.5 => -0.0248656621,
    mth_pp_orig_lastseen > 2.5                                  => final_score_42_c414,
    mth_pp_orig_lastseen = NULL                                 => 0.0091053322,
                                                                   0.0160739212);

final_score_42 := map(
    NULL < r_a41_prop_owner_inp_only_d AND r_a41_prop_owner_inp_only_d <= 0.5 => final_score_42_c412,
    r_a41_prop_owner_inp_only_d > 0.5                                         => final_score_42_c413,
    r_a41_prop_owner_inp_only_d = NULL                                        => 0.0017438380,
                                                                                 0.0017438380);

final_score_43_c419 := map(
    NULL < mth_pp_eda_hist_did_dt AND mth_pp_eda_hist_did_dt <= 38.5 => -0.0076635439,
    mth_pp_eda_hist_did_dt > 38.5                                    => -0.0822454272,
    mth_pp_eda_hist_did_dt = NULL                                    => 0.0715339531,
                                                                        0.0164486017);

final_score_43_c418 := map(
    NULL < mth_pp_orig_lastseen AND mth_pp_orig_lastseen <= 15.5 => -0.0744792099,
    mth_pp_orig_lastseen > 15.5                                  => final_score_43_c419,
    mth_pp_orig_lastseen = NULL                                  => -0.0267275738,
                                                                    -0.0237992049);

final_score_43_c420 := map(
    NULL < r_paw_active_phone_ct_d AND r_paw_active_phone_ct_d <= 0.5 => -0.0123201559,
    r_paw_active_phone_ct_d > 0.5                                     => 0.0214131162,
    r_paw_active_phone_ct_d = NULL                                    => -0.0081399104,
                                                                         -0.0081399104);

final_score_43_c417 := map(
    NULL < mth_source_exp_lseen AND mth_source_exp_lseen <= 12.5 => 0.0293925344,
    mth_source_exp_lseen > 12.5                                  => final_score_43_c418,
    mth_source_exp_lseen = NULL                                  => final_score_43_c420,
                                                                    -0.0064364823);

final_score_43 := map(
    NULL < _mod_binnr_exp_lgt AND _mod_binnr_exp_lgt <= -0.0583398679740188 => final_score_43_c417,
    _mod_binnr_exp_lgt > -0.0583398679740188                                => 0.0429282739,
    _mod_binnr_exp_lgt = NULL                                               => 0.0007331359,
                                                                               0.0007331359);

final_score_44_c423 := map(
    NULL < f_corraddrnamecount_d AND f_corraddrnamecount_d <= 7.5 => -0.0078029898,
    f_corraddrnamecount_d > 7.5                                   => 0.0518890192,
    f_corraddrnamecount_d = NULL                                  => 0.0097980684,
                                                                     0.0097980684);

final_score_44_c425 := map(
    NULL < r_a46_curr_avm_autoval_d AND r_a46_curr_avm_autoval_d <= 30081.5 => 0.1889902677,
    r_a46_curr_avm_autoval_d > 30081.5                                      => -0.0867184090,
    r_a46_curr_avm_autoval_d = NULL                                         => -0.0226835547,
                                                                               -0.0371497730);

final_score_44_c424 := map(
    NULL < mth_source_ppth_lseen AND mth_source_ppth_lseen <= 7.5 => 0.0579122249,
    mth_source_ppth_lseen > 7.5                                   => final_score_44_c425,
    mth_source_ppth_lseen = NULL                                  => 0.0072257352,
                                                                     0.0048863768);

final_score_44_c422 := map(
    NULL < mth_source_ppca_lseen AND mth_source_ppca_lseen <= 1.5 => 0.0945280405,
    mth_source_ppca_lseen > 1.5                                   => final_score_44_c423,
    mth_source_ppca_lseen = NULL                                  => final_score_44_c424,
                                                                     0.0070857539);

final_score_44 := map(
    (phone_subject_title in ['Associate', 'Associate By Property', 'Associate By SSN', 'Associate By Vehicle', 'Grandchild', 'Grandparent', 'Husband', 'Neighbor', 'Parent', 'Spouse'])                                                                                                                            => -0.0371392247,
    (phone_subject_title in ['Associate By Address', 'Associate By Business', 'Associate By Shared Associates', 'Brother', 'Child', 'Daughter', 'Father', 'Granddaughter', 'Grandfather', 'Grandmother', 'Grandson', 'Mother', 'Relative', 'Sibling', 'Sister', 'Son', 'Subject', 'Subject at Household', 'Wife']) => final_score_44_c422,
    phone_subject_title = ''                                                                                                                                                                                                                                                                                     => 0.0015724861,
                                                                                                                                                                                                                                                                                                                      0.0015724861);

final_score_45_c427 := map(
    NULL < mth_pp_first_build_date AND mth_pp_first_build_date <= 23.5 => -0.0041310910,
    mth_pp_first_build_date > 23.5                                     => 0.0241138369,
    mth_pp_first_build_date = NULL                                     => -0.0105209017,
                                                                          -0.0021352860);

final_score_45_c430 := map(
    NULL < f_liens_unrel_cj_total_amt_i AND f_liens_unrel_cj_total_amt_i <= 533.5 => 0.0832407902,
    f_liens_unrel_cj_total_amt_i > 533.5                                          => -0.0602209385,
    f_liens_unrel_cj_total_amt_i = NULL                                           => 0.0431331156,
                                                                                     0.0431331156);

final_score_45_c429 := map(
    NULL < f_add_input_nhood_bus_pct_i AND f_add_input_nhood_bus_pct_i <= 0.073721049676903 => final_score_45_c430,
    f_add_input_nhood_bus_pct_i > 0.073721049676903                                         => 0.1366008648,
    f_add_input_nhood_bus_pct_i = NULL                                                      => 0.0737945935,
                                                                                               0.0737945935);

final_score_45_c428 := map(
    NULL < f_inq_count_i AND f_inq_count_i <= 3.5 => -0.0583996820,
    f_inq_count_i > 3.5                           => final_score_45_c429,
    f_inq_count_i = NULL                          => 0.0527169544,
                                                     0.0527169544);

final_score_45 := map(
    (phone_subject_title in ['Associate', 'Associate By Address', 'Associate By Property', 'Associate By Shared Associates', 'Associate By SSN', 'Associate By Vehicle', 'Brother', 'Daughter', 'Grandchild', 'Granddaughter', 'Grandmother', 'Grandparent', 'Neighbor', 'Relative', 'Sibling', 'Son', 'Spouse', 'Subject', 'Subject at Household', 'Wife']) => final_score_45_c427,
    (phone_subject_title in ['Associate By Business', 'Child', 'Father', 'Grandfather', 'Grandson', 'Husband', 'Mother', 'Parent', 'Sister'])                                                                                                                                                                                                                => final_score_45_c428,
    phone_subject_title = ''                                                                                                                                                                                                                                                                                                                               => 0.0001846425,
                                                                                                                                                                                                                                                                                                                                                                0.0001846425);

final_score_46_c435 := map(
    NULL < r_a49_curr_avm_chg_1yr_pct_i AND r_a49_curr_avm_chg_1yr_pct_i <= 100.85 => 0.0755530544,
    r_a49_curr_avm_chg_1yr_pct_i > 100.85                                          => -0.0954232232,
    r_a49_curr_avm_chg_1yr_pct_i = NULL                                            => -0.0169774295,
                                                                                      -0.0128770086);

final_score_46_c434 := map(
    NULL < f_rel_incomeover50_count_d AND f_rel_incomeover50_count_d <= 15.5 => final_score_46_c435,
    f_rel_incomeover50_count_d > 15.5                                        => 0.1248062784,
    f_rel_incomeover50_count_d = NULL                                        => 0.0173236592,
                                                                                0.0173236592);

final_score_46_c433 := map(
    NULL < mth_source_cr_fseen AND mth_source_cr_fseen <= 116.5 => final_score_46_c434,
    mth_source_cr_fseen > 116.5                                 => -0.1129678524,
    mth_source_cr_fseen = NULL                                  => -0.0298711361,
                                                                   -0.0220182383);

final_score_46_c432 := map(
    NULL < (integer)_phone_match_code_c AND (integer)_phone_match_code_c <= 0.5 => final_score_46_c433,
    (integer)_phone_match_code_c > 0.5                                 => 0.0030473414,
    (integer)_phone_match_code_c = NULL                                => -0.0031048769,
                                                                 -0.0031048769);

final_score_46 := map(
    NULL < f_liens_unrel_o_total_amt_i AND f_liens_unrel_o_total_amt_i <= 209.5 => final_score_46_c432,
    f_liens_unrel_o_total_amt_i > 209.5                                         => 0.0354302803,
    f_liens_unrel_o_total_amt_i = NULL                                          => 0.0003900092,
                                                                                   0.0003900092);

final_score_47_c440 := map(
    NULL < r_l80_inp_avm_autoval_d AND r_l80_inp_avm_autoval_d <= 70500 => 0.1306299782,
    r_l80_inp_avm_autoval_d > 70500                                     => -0.0705125275,
    r_l80_inp_avm_autoval_d = NULL                                      => 0.0108421895,
                                                                           -0.0080411556);

final_score_47_c439 := map(
    NULL < f_add_curr_nhood_mfd_pct_i AND f_add_curr_nhood_mfd_pct_i <= 0.00637541894521492 => 0.0373194992,
    f_add_curr_nhood_mfd_pct_i > 0.00637541894521492                                        => -0.0413266057,
    f_add_curr_nhood_mfd_pct_i = NULL                                                       => final_score_47_c440,
                                                                                               -0.0306407813);

final_score_47_c438 := map(
    NULL < number_of_sources AND number_of_sources <= 1.5 => final_score_47_c439,
    number_of_sources > 1.5                               => 0.0093286290,
    number_of_sources = NULL                              => -0.0130526619,
                                                             -0.0130526619);

final_score_47_c437 := map(
    NULL < mth_pp_eda_hist_did_dt AND mth_pp_eda_hist_did_dt <= 32.5 => 0.0129318539,
    mth_pp_eda_hist_did_dt > 32.5                                    => final_score_47_c438,
    mth_pp_eda_hist_did_dt = NULL                                    => 0.0057237601,
                                                                        0.0018432052);

final_score_47 := map(
    NULL < mth_source_rm_fseen AND mth_source_rm_fseen <= 18.5 => 0.0212311317,
    mth_source_rm_fseen > 18.5                                 => -0.1005410424,
    mth_source_rm_fseen = NULL                                 => final_score_47_c437,
                                                                  0.0016883097);

final_score_48_c445 := map(
    NULL < f_add_input_nhood_mfd_pct_i AND f_add_input_nhood_mfd_pct_i <= 0.0488212916138298 => -0.0554930074,
    f_add_input_nhood_mfd_pct_i > 0.0488212916138298                                         => 0.0181986498,
    f_add_input_nhood_mfd_pct_i = NULL                                                       => 0.0531577546,
                                                                                                0.0073733563);

final_score_48_c444 := map(
    (phone_subject_title in ['Associate By Address', 'Associate By Property', 'Associate By Shared Associates', 'Associate By SSN', 'Associate By Vehicle', 'Daughter', 'Granddaughter', 'Grandfather', 'Grandmother', 'Grandparent', 'Grandson', 'Neighbor', 'Parent', 'Sibling', 'Son', 'Spouse', 'Subject']) => -0.0375385587,
    (phone_subject_title in ['Associate', 'Associate By Business', 'Brother', 'Child', 'Father', 'Grandchild', 'Husband', 'Mother', 'Relative', 'Sister', 'Subject at Household', 'Wife'])                                                                                                                      => final_score_48_c445,
    phone_subject_title = ''                                                                                                                                                                                                                                                                                  => -0.0242707083,
                                                                                                                                                                                                                                                                                                                   -0.0242707083);

final_score_48_c443 := map(
    NULL < mth_source_exp_lseen AND mth_source_exp_lseen <= 66.5 => 0.0045122012,
    mth_source_exp_lseen > 66.5                                  => -0.1189676124,
    mth_source_exp_lseen = NULL                                  => final_score_48_c444,
                                                                    -0.0189004229);

final_score_48_c442 := map(
    NULL < mth_source_ppdid_lseen AND mth_source_ppdid_lseen <= 15.5 => 0.0187965243,
    mth_source_ppdid_lseen > 15.5                                    => -0.0332935650,
    mth_source_ppdid_lseen = NULL                                    => final_score_48_c443,
                                                                        -0.0137727907);

final_score_48 := map(
    NULL < f_corrrisktype_i AND f_corrrisktype_i <= 5.5 => 0.0116659199,
    f_corrrisktype_i > 5.5                              => final_score_48_c442,
    f_corrrisktype_i = NULL                             => -0.0010395352,
                                                           -0.0010395352);

final_score_49_c447 := map(
    NULL < f_srchunvrfdphonecount_i AND f_srchunvrfdphonecount_i <= 1.5 => 0.0068701334,
    f_srchunvrfdphonecount_i > 1.5                                      => -0.0368960802,
    f_srchunvrfdphonecount_i = NULL                                     => 0.0042591620,
                                                                           0.0042591620);

final_score_49_c450 := map(
    NULL < pk_cell_flag AND pk_cell_flag <= 0.5 => -0.1275598606,
    pk_cell_flag > 0.5                          => 0.0471123687,
    pk_cell_flag = NULL                         => -0.0014815563,
                                                   -0.0014815563);

final_score_49_c449 := map(
    NULL < r_a49_curr_avm_chg_1yr_i AND r_a49_curr_avm_chg_1yr_i <= 14399 => final_score_49_c450,
    r_a49_curr_avm_chg_1yr_i > 14399                                      => -0.0948885738,
    r_a49_curr_avm_chg_1yr_i = NULL                                       => -0.1197035852,
                                                                             -0.0693896435);

final_score_49_c448 := map(
    (phone_subject_title in ['Associate', 'Associate By Business', 'Associate By Property', 'Associate By SSN', 'Associate By Vehicle', 'Brother', 'Child', 'Father', 'Grandmother', 'Grandparent', 'Parent', 'Son', 'Spouse', 'Subject at Household', 'Wife']) => final_score_49_c449,
    (phone_subject_title in ['Associate By Address', 'Associate By Shared Associates', 'Daughter', 'Grandchild', 'Granddaughter', 'Grandfather', 'Grandson', 'Husband', 'Mother', 'Neighbor', 'Relative', 'Sibling', 'Sister', 'Subject'])                      => -0.0128266190,
    phone_subject_title = ''                                                                                                                                                                                                                                  => -0.0229926758,
                                                                                                                                                                                                                                                                   -0.0229926758);

final_score_49 := map(
    NULL < f_rel_incomeover50_count_d AND f_rel_incomeover50_count_d <= 13.5 => final_score_49_c447,
    f_rel_incomeover50_count_d > 13.5                                        => final_score_49_c448,
    f_rel_incomeover50_count_d = NULL                                        => 0.0036994949,
                                                                                0.0002278571);

final_score_50_c454 := map(
    NULL < r_pb_order_freq_d AND r_pb_order_freq_d <= 177.5 => -0.0208140741,
    r_pb_order_freq_d > 177.5                               => 0.0071596515,
    r_pb_order_freq_d = NULL                                => 0.0026190778,
                                                               -0.0099493249);

final_score_50_c453 := map(
    NULL < f_curraddrcartheftindex_i AND f_curraddrcartheftindex_i <= 4.5 => 0.0488775142,
    f_curraddrcartheftindex_i > 4.5                                       => final_score_50_c454,
    f_curraddrcartheftindex_i = NULL                                      => -0.0072860537,
                                                                             -0.0072860537);

final_score_50_c452 := map(
    NULL < (integer)_phone_match_code_s AND (integer)_phone_match_code_s <= 0.5 => final_score_50_c453,
    (integer)_phone_match_code_s > 0.5                                 => -0.0501502832,
    (integer)_phone_match_code_s = NULL                                => -0.0101350474,
                                                                 -0.0101350474);

final_score_50_c455 := map(
    (phone_subject_title in ['Associate', 'Associate By Address', 'Brother', 'Daughter', 'Father', 'Granddaughter', 'Grandfather', 'Grandmother', 'Parent', 'Relative', 'Sister', 'Spouse', 'Subject', 'Subject at Household'])                                            => 0.0107273009,
    (phone_subject_title in ['Associate By Business', 'Associate By Property', 'Associate By Shared Associates', 'Associate By SSN', 'Associate By Vehicle', 'Child', 'Grandchild', 'Grandparent', 'Grandson', 'Husband', 'Mother', 'Neighbor', 'Sibling', 'Son', 'Wife']) => 0.1150834009,
    phone_subject_title = ''                                                                                                                                                                                                                                             => 0.0130281088,
                                                                                                                                                                                                                                                                              0.0130281088);

final_score_50 := map(
    NULL < number_of_sources AND number_of_sources <= 1.5 => final_score_50_c452,
    number_of_sources > 1.5                               => final_score_50_c455,
    number_of_sources = NULL                              => -0.0024251143,
                                                             -0.0024251143);

final_score_51_c458 := map(
    NULL < f_srchunvrfdphonecount_i AND f_srchunvrfdphonecount_i <= 0.5 => 0.0043850251,
    f_srchunvrfdphonecount_i > 0.5                                      => -0.0258281718,
    f_srchunvrfdphonecount_i = NULL                                     => -0.0022582146,
                                                                           -0.0022582146);

final_score_51_c457 := map(
    NULL < (integer)_inq_adl_ph_industry_flag AND (integer)_inq_adl_ph_industry_flag <= 0.5 => final_score_51_c458,
    (integer)_inq_adl_ph_industry_flag > 0.5                                       => 0.0561150645,
    (integer)_inq_adl_ph_industry_flag = NULL                                      => 0.0022278816,
                                                                             0.0022278816);

final_score_51_c460 := map(
    NULL < f_curraddrmurderindex_i AND f_curraddrmurderindex_i <= 143 => 0.0941251843,
    f_curraddrmurderindex_i > 143                                     => -0.0218023535,
    f_curraddrmurderindex_i = NULL                                    => 0.0647117608,
                                                                         0.0647117608);

final_score_51_c459 := map(
    NULL < f_add_input_nhood_bus_pct_i AND f_add_input_nhood_bus_pct_i <= 0.0173863360804674 => -0.0129727135,
    f_add_input_nhood_bus_pct_i > 0.0173863360804674                                         => final_score_51_c460,
    f_add_input_nhood_bus_pct_i = NULL                                                       => 0.0451885426,
                                                                                                0.0451885426);

final_score_51 := map(
    (phone_subject_title in ['Associate', 'Associate By Address', 'Associate By Property', 'Associate By Shared Associates', 'Associate By Vehicle', 'Brother', 'Grandmother', 'Grandparent', 'Grandson', 'Husband', 'Neighbor', 'Parent', 'Relative', 'Sister', 'Spouse', 'Subject', 'Subject at Household', 'Wife']) => final_score_51_c457,
    (phone_subject_title in ['Associate By Business', 'Associate By SSN', 'Child', 'Daughter', 'Father', 'Grandchild', 'Granddaughter', 'Grandfather', 'Mother', 'Sibling', 'Son'])                                                                                                                                    => final_score_51_c459,
    phone_subject_title = ''                                                                                                                                                                                                                                                                                         => 0.0041646505,
                                                                                                                                                                                                                                                                                                                          0.0041646505);

final_score_52_c465 := map(
    NULL < r_c13_avg_lres_d AND r_c13_avg_lres_d <= 73.5 => -0.0395841139,
    r_c13_avg_lres_d > 73.5                              => 0.0308865230,
    r_c13_avg_lres_d = NULL                              => 0.0110061389,
                                                            0.0110061389);

final_score_52_c464 := map(
    NULL < mth_internal_ver_first_seen AND mth_internal_ver_first_seen <= 25.5 => 0.0964612996,
    mth_internal_ver_first_seen > 25.5                                         => -0.0062341832,
    mth_internal_ver_first_seen = NULL                                         => final_score_52_c465,
                                                                                  0.0176961528);

final_score_52_c463 := map(
    NULL < (integer)_phone_match_code_n AND (integer)_phone_match_code_n <= 0.5 => final_score_52_c464,
    (integer)_phone_match_code_n > 0.5                                 => 0.1637721681,
    (integer)_phone_match_code_n = NULL                                => 0.0246640986,
                                                                 0.0246640986);

final_score_52_c462 := map(
    (phone_subject_title in ['Associate', 'Associate By Business', 'Associate By Property', 'Associate By Shared Associates', 'Associate By Vehicle', 'Brother', 'Father', 'Grandchild', 'Grandmother', 'Grandparent', 'Husband', 'Mother', 'Neighbor', 'Parent', 'Relative', 'Spouse', 'Subject', 'Subject at Household']) => 0.0010435122,
    (phone_subject_title in ['Associate By Address', 'Associate By SSN', 'Child', 'Daughter', 'Granddaughter', 'Grandfather', 'Grandson', 'Sibling', 'Sister', 'Son', 'Wife'])                                                                                                                                              => final_score_52_c463,
    phone_subject_title = ''                                                                                                                                                                                                                                                                                              => 0.0054097452,
                                                                                                                                                                                                                                                                                                                               0.0054097452);

final_score_52 := map(
    NULL < f_prevaddrageoldest_d AND f_prevaddrageoldest_d <= 25.5 => -0.0306204095,
    f_prevaddrageoldest_d > 25.5                                   => final_score_52_c462,
    f_prevaddrageoldest_d = NULL                                   => 0.0011212460,
                                                                      0.0011212460);

final_score_53_c469 := map(
    NULL < eda_avg_days_interrupt AND eda_avg_days_interrupt <= 481.5 => 0.0194958204,
    eda_avg_days_interrupt > 481.5                                    => -0.0993982738,
    eda_avg_days_interrupt = NULL                                     => 0.0133061753,
                                                                         0.0133061753);

final_score_53_c468 := map(
    NULL < mth_source_cr_fseen AND mth_source_cr_fseen <= 1.5 => -0.0211462795,
    mth_source_cr_fseen > 1.5                                 => 0.0950884387,
    mth_source_cr_fseen = NULL                                => final_score_53_c469,
                                                                 0.0167370141);

final_score_53_c467 := map(
    NULL < r_a49_curr_avm_chg_1yr_pct_i AND r_a49_curr_avm_chg_1yr_pct_i <= 105.25 => final_score_53_c468,
    r_a49_curr_avm_chg_1yr_pct_i > 105.25                                          => -0.0108023979,
    r_a49_curr_avm_chg_1yr_pct_i = NULL                                            => -0.0041449278,
                                                                                      0.0001786552);

final_score_53_c470 := map(
    (phone_subject_title in ['Associate', 'Associate By Address', 'Associate By Shared Associates', 'Child', 'Daughter', 'Father', 'Granddaughter', 'Grandfather', 'Grandmother', 'Grandparent', 'Husband', 'Mother', 'Neighbor', 'Sibling', 'Sister', 'Son', 'Spouse', 'Subject', 'Subject at Household', 'Wife']) => -0.0521327189,
    (phone_subject_title in ['Associate By Business', 'Associate By Property', 'Associate By SSN', 'Associate By Vehicle', 'Brother', 'Grandchild', 'Grandson', 'Parent', 'Relative'])                                                                                                                              => 0.1054615830,
    phone_subject_title = ''                                                                                                                                                                                                                                                                                      => -0.0423839691,
                                                                                                                                                                                                                                                                                                                       -0.0423839691);

final_score_53 := map(
    NULL < f_srchfraudsrchcount_i AND f_srchfraudsrchcount_i <= 15.5 => final_score_53_c467,
    f_srchfraudsrchcount_i > 15.5                                    => final_score_53_c470,
    f_srchfraudsrchcount_i = NULL                                    => -0.0034951390,
                                                                        -0.0034951390);

final_score_54_c473 := map(
    NULL < r_a49_curr_avm_chg_1yr_pct_i AND r_a49_curr_avm_chg_1yr_pct_i <= 110.95 => -0.0712539238,
    r_a49_curr_avm_chg_1yr_pct_i > 110.95                                          => 0.0900751905,
    r_a49_curr_avm_chg_1yr_pct_i = NULL                                            => -0.0475026764,
                                                                                      -0.0437577964);

final_score_54_c474 := map(
    NULL < f_rel_under25miles_cnt_d AND f_rel_under25miles_cnt_d <= 0.5 => -0.0733695552,
    f_rel_under25miles_cnt_d > 0.5                                      => 0.0006846430,
    f_rel_under25miles_cnt_d = NULL                                     => -0.0012849907,
                                                                           -0.0012849907);

final_score_54_c472 := map(
    NULL < _phone_timezone_match AND _phone_timezone_match <= 0.5 => final_score_54_c473,
    _phone_timezone_match > 0.5                                   => final_score_54_c474,
    _phone_timezone_match = NULL                                  => -0.0057764819,
                                                                     -0.0057764819);

final_score_54_c475 := map(
    NULL < _mod_binnr_exp_lgt AND _mod_binnr_exp_lgt <= -3.67002900230671 => -0.0425864809,
    _mod_binnr_exp_lgt > -3.67002900230671                                => 0.0218785997,
    _mod_binnr_exp_lgt = NULL                                             => 0.0105593456,
                                                                             0.0105593456);

final_score_54 := map(
    NULL < _phone_zip_match AND _phone_zip_match <= 0.5 => final_score_54_c472,
    _phone_zip_match > 0.5                              => final_score_54_c475,
    _phone_zip_match = NULL                             => 0.0003193504,
                                                           0.0003193504);

final_score_55_c478 := map(
    (phone_subject_title in ['Associate', 'Associate By Business', 'Associate By Property', 'Associate By Shared Associates', 'Associate By SSN', 'Associate By Vehicle', 'Grandfather', 'Grandmother', 'Husband', 'Neighbor', 'Parent', 'Sibling', 'Son', 'Subject', 'Subject at Household']) => 0.0029992375,
    (phone_subject_title in ['Associate By Address', 'Brother', 'Child', 'Daughter', 'Father', 'Grandchild', 'Granddaughter', 'Grandparent', 'Grandson', 'Mother', 'Relative', 'Sister', 'Spouse', 'Wife'])                                                                                    => 0.0477382086,
    phone_subject_title = ''                                                                                                                                                                                                                                                                 => 0.0147780124,
                                                                                                                                                                                                                                                                                                  0.0147780124);

final_score_55_c479 := map(
    NULL < mth_source_ppla_lseen AND mth_source_ppla_lseen <= 22.5 => 0.0200060435,
    mth_source_ppla_lseen > 22.5                                   => -0.1557959336,
    mth_source_ppla_lseen = NULL                                   => -0.0179275137,
                                                                      -0.0177166328);

final_score_55_c480 := map(
    NULL < (integer)inq_adl_firstseen_n AND (integer)inq_adl_firstseen_n <= 0.5 => -0.0205963434,
    (integer)inq_adl_firstseen_n > 0.5                                 => 0.0171152461,
    (integer)inq_adl_firstseen_n = NULL                                => 0.0077105048,
                                                                 -0.0006665568);

final_score_55_c477 := map(
    NULL < r_a49_curr_avm_chg_1yr_pct_i AND r_a49_curr_avm_chg_1yr_pct_i <= 105.05 => final_score_55_c478,
    r_a49_curr_avm_chg_1yr_pct_i > 105.05                                          => final_score_55_c479,
    r_a49_curr_avm_chg_1yr_pct_i = NULL                                            => final_score_55_c480,
                                                                                      0.0006915654);

final_score_55 := map(
    NULL < mth_eda_deletion_date AND mth_eda_deletion_date <= 9.5 => 0.0945438094,
    mth_eda_deletion_date > 9.5                                   => 0.0027275386,
    mth_eda_deletion_date = NULL                                  => final_score_55_c477,
                                                                     0.0016971380);

final_score_56_c482 := map(
    NULL < _mod_disc_exp_lgt AND _mod_disc_exp_lgt <= -0.634475347784111 => -0.0509727892,
    _mod_disc_exp_lgt > -0.634475347784111                               => 0.0541727339,
    _mod_disc_exp_lgt = NULL                                             => 0.0259661831,
                                                                            0.0259661831);

final_score_56_c484 := map(
    NULL < pk_cell_indicator AND pk_cell_indicator <= 1.5 => 0.0874405707,
    pk_cell_indicator > 1.5                               => -0.0307113483,
    pk_cell_indicator = NULL                              => 0.0229473732,
                                                             0.0229473732);

final_score_56_c483 := map(
    NULL < mth_pp_first_build_date AND mth_pp_first_build_date <= 14.5 => -0.0664569405,
    mth_pp_first_build_date > 14.5                                     => final_score_56_c484,
    mth_pp_first_build_date = NULL                                     => -0.0138192143,
                                                                          -0.0217956394);

final_score_56_c485 := map(
    NULL < mth_source_ppca_lseen AND mth_source_ppca_lseen <= 23.5 => 0.0233081359,
    mth_source_ppca_lseen > 23.5                                   => -0.0265189852,
    mth_source_ppca_lseen = NULL                                   => -0.0009333928,
                                                                      0.0010162453);

final_score_56 := map(
    NULL < mth_source_exp_lseen AND mth_source_exp_lseen <= 10.5 => final_score_56_c482,
    mth_source_exp_lseen > 10.5                                  => final_score_56_c483,
    mth_source_exp_lseen = NULL                                  => final_score_56_c485,
                                                                    0.0010644365);

final_score_57_c487 := map(
    NULL < f_inputaddractivephonelist_d AND f_inputaddractivephonelist_d <= 0.5 => 0.0008430552,
    f_inputaddractivephonelist_d > 0.5                                          => 0.0344302049,
    f_inputaddractivephonelist_d = NULL                                         => 0.0073944900,
                                                                                   0.0073944900);

final_score_57_c488 := map(
    NULL < r_pb_order_freq_d AND r_pb_order_freq_d <= 61.5 => -0.0514060961,
    r_pb_order_freq_d > 61.5                               => 0.0267642309,
    r_pb_order_freq_d = NULL                               => -0.0584782512,
                                                              -0.0298931416);

final_score_57_c490 := map(
    (phone_subject_title in ['Associate', 'Associate By Address', 'Associate By Property', 'Associate By Shared Associates', 'Associate By SSN', 'Father', 'Granddaughter', 'Grandmother', 'Grandson', 'Husband', 'Mother', 'Neighbor', 'Parent', 'Relative', 'Son', 'Subject', 'Subject at Household', 'Wife']) => -0.0280255979,
    (phone_subject_title in ['Associate By Business', 'Associate By Vehicle', 'Brother', 'Child', 'Daughter', 'Grandchild', 'Grandfather', 'Grandparent', 'Sibling', 'Sister', 'Spouse'])                                                                                                                        => 0.0572632274,
    phone_subject_title = ''                                                                                                                                                                                                                                                                                   => -0.0185709588,
                                                                                                                                                                                                                                                                                                                    -0.0185709588);

final_score_57_c489 := map(
    NULL < f_rel_homeover100_count_d AND f_rel_homeover100_count_d <= 7.5 => 0.0138173063,
    f_rel_homeover100_count_d > 7.5                                       => final_score_57_c490,
    f_rel_homeover100_count_d = NULL                                      => 0.0022832440,
                                                                             0.0022832440);

final_score_57 := map(
    NULL < mth_pp_app_npa_effective_dt AND mth_pp_app_npa_effective_dt <= 196.5 => final_score_57_c487,
    mth_pp_app_npa_effective_dt > 196.5                                         => final_score_57_c488,
    mth_pp_app_npa_effective_dt = NULL                                          => final_score_57_c489,
                                                                                   0.0021033662);

final_score_58_c493 := map(
    NULL < r_c10_m_hdr_fs_d AND r_c10_m_hdr_fs_d <= 427.5 => -0.0927397440,
    r_c10_m_hdr_fs_d > 427.5                              => 0.0852453266,
    r_c10_m_hdr_fs_d = NULL                               => -0.0743984070,
                                                             -0.0743984070);

final_score_58_c492 := map(
    NULL < f_fp_prevaddrcrimeindex_i AND f_fp_prevaddrcrimeindex_i <= 82 => 0.0092598614,
    f_fp_prevaddrcrimeindex_i > 82                                       => final_score_58_c493,
    f_fp_prevaddrcrimeindex_i = NULL                                     => -0.0358380813,
                                                                            -0.0358380813);

final_score_58_c495 := map(
    (phone_subject_title in ['Associate', 'Associate By Property', 'Associate By Shared Associates', 'Associate By SSN', 'Brother', 'Child', 'Grandchild', 'Neighbor', 'Parent', 'Son', 'Spouse', 'Subject', 'Subject at Household'])                                => 0.0031963738,
    (phone_subject_title in ['Associate By Address', 'Associate By Business', 'Associate By Vehicle', 'Daughter', 'Father', 'Granddaughter', 'Grandfather', 'Grandmother', 'Grandparent', 'Grandson', 'Husband', 'Mother', 'Relative', 'Sibling', 'Sister', 'Wife']) => 0.0918797747,
    phone_subject_title = ''                                                                                                                                                                                                                                       => 0.0312234938,
                                                                                                                                                                                                                                                                        0.0312234938);

final_score_58_c494 := map(
    NULL < f_add_curr_mobility_index_n AND f_add_curr_mobility_index_n <= 0.167550173049263 => final_score_58_c495,
    f_add_curr_mobility_index_n > 0.167550173049263                                         => -0.0065759680,
    f_add_curr_mobility_index_n = NULL                                                      => -0.0040653073,
                                                                                               -0.0027855711);

final_score_58 := map(
    NULL < mth_source_ppdid_lseen AND mth_source_ppdid_lseen <= 37.5 => 0.0055303483,
    mth_source_ppdid_lseen > 37.5                                    => final_score_58_c492,
    mth_source_ppdid_lseen = NULL                                    => final_score_58_c494,
                                                                        -0.0029077535);

final_score_59_c497 := map(
    NULL < f_assocsuspicousidcount_i AND f_assocsuspicousidcount_i <= 7.5 => 0.0274195915,
    f_assocsuspicousidcount_i > 7.5                                       => -0.1486292363,
    f_assocsuspicousidcount_i = NULL                                      => 0.0215965101,
                                                                             0.0215965101);

final_score_59_c500 := map(
    NULL < f_bus_lname_verd_d AND f_bus_lname_verd_d <= 0.5 => 0.0294088353,
    f_bus_lname_verd_d > 0.5                                => -0.1221974346,
    f_bus_lname_verd_d = NULL                               => 0.0149763330,
                                                               0.0149763330);

final_score_59_c499 := map(
    NULL < mth_source_ppla_fseen AND mth_source_ppla_fseen <= 57.5 => final_score_59_c500,
    mth_source_ppla_fseen > 57.5                                   => -0.0677047536,
    mth_source_ppla_fseen = NULL                                   => -0.0109155722,
                                                                      -0.0105529678);

final_score_59_c498 := map(
    NULL < number_of_sources AND number_of_sources <= 1.5 => final_score_59_c499,
    number_of_sources > 1.5                               => 0.0333368362,
    number_of_sources = NULL                              => -0.0040878232,
                                                             -0.0040878232);

final_score_59 := map(
    NULL < mth_source_ppdid_lseen AND mth_source_ppdid_lseen <= 15.5 => final_score_59_c497,
    mth_source_ppdid_lseen > 15.5                                    => -0.0177676079,
    mth_source_ppdid_lseen = NULL                                    => final_score_59_c498,
                                                                        -0.0008366605);

final_score_60_c503 := map(
    NULL < f_srchunvrfdphonecount_i AND f_srchunvrfdphonecount_i <= 0.5 => 0.0027034459,
    f_srchunvrfdphonecount_i > 0.5                                      => -0.1391145464,
    f_srchunvrfdphonecount_i = NULL                                     => -0.0264651997,
                                                                           -0.0264651997);

final_score_60_c502 := map(
    NULL < (integer)inq_lastseen_n AND (integer)inq_lastseen_n <= 12.5 => 0.0604411389,
    (integer)inq_lastseen_n > 12.5                            => final_score_60_c503,
    (integer)inq_lastseen_n = NULL                            => 0.0228199653,
                                                        0.0229672194);

final_score_60_c505 := map(
    NULL < number_of_sources AND number_of_sources <= 1.5 => -0.1060371922,
    number_of_sources > 1.5                               => -0.0018219925,
    number_of_sources = NULL                              => -0.0209024317,
                                                             -0.0209024317);

final_score_60_c504 := map(
    NULL < mth_source_inf_fseen AND mth_source_inf_fseen <= 228.5 => final_score_60_c505,
    mth_source_inf_fseen > 228.5                                  => 0.0685653338,
    mth_source_inf_fseen = NULL                                   => -0.0005191379,
                                                                     0.0015527532);

final_score_60 := map(
    NULL < mth_source_ppca_lseen AND mth_source_ppca_lseen <= 17.5 => final_score_60_c502,
    mth_source_ppca_lseen > 17.5                                   => -0.0312475666,
    mth_source_ppca_lseen = NULL                                   => final_score_60_c504,
                                                                      0.0021669511);

final_score_61_c507 := map(
    NULL < r_a50_pb_average_dollars_d AND r_a50_pb_average_dollars_d <= 77.5 => -0.0535735855,
    r_a50_pb_average_dollars_d > 77.5                                        => 0.1127947599,
    r_a50_pb_average_dollars_d = NULL                                        => 0.0534124860,
                                                                                0.0534124860);

final_score_61_c510 := map(
    NULL < mth_source_exp_lseen AND mth_source_exp_lseen <= 16.5 => 0.0212699284,
    mth_source_exp_lseen > 16.5                                  => -0.0333707662,
    mth_source_exp_lseen = NULL                                  => -0.0108500172,
                                                                    -0.0080578279);

final_score_61_c509 := map(
    NULL < mth_source_utildid_fseen AND mth_source_utildid_fseen <= 15.5 => 0.1276594804,
    mth_source_utildid_fseen > 15.5                                      => -0.0566722617,
    mth_source_utildid_fseen = NULL                                      => final_score_61_c510,
                                                                            -0.0075786412);

final_score_61_c508 := map(
    NULL < mth_internal_ver_last_seen AND mth_internal_ver_last_seen <= 0.5 => 0.0063259635,
    mth_internal_ver_last_seen > 0.5                                        => 0.0210337498,
    mth_internal_ver_last_seen = NULL                                       => final_score_61_c509,
                                                                               0.0005531815);

final_score_61 := map(
    NULL < mth_source_ppth_fseen AND mth_source_ppth_fseen <= 20.5 => final_score_61_c507,
    mth_source_ppth_fseen > 20.5                                   => -0.0462588369,
    mth_source_ppth_fseen = NULL                                   => final_score_61_c508,
                                                                      -0.0010196255);

final_score_62_c514 := map(
    NULL < _mod_disc_exp_lgt AND _mod_disc_exp_lgt <= -0.616910049903216 => -0.0574982234,
    _mod_disc_exp_lgt > -0.616910049903216                               => 0.0276095196,
    _mod_disc_exp_lgt = NULL                                             => 0.0049399138,
                                                                            0.0049399138);

final_score_62_c515 := map(
    NULL < mth_pp_datevendorfirstseen AND mth_pp_datevendorfirstseen <= 45.5 => -0.1115061588,
    mth_pp_datevendorfirstseen > 45.5                                        => 0.0558856661,
    mth_pp_datevendorfirstseen = NULL                                        => -0.0524357670,
                                                                                -0.0481011786);

final_score_62_c513 := map(
    NULL < mth_source_exp_lseen AND mth_source_exp_lseen <= 36.5 => final_score_62_c514,
    mth_source_exp_lseen > 36.5                                  => final_score_62_c515,
    mth_source_exp_lseen = NULL                                  => 0.0026323467,
                                                                    0.0014347298);

final_score_62_c512 := map(
    NULL < f_liens_unrel_cj_total_amt_i AND f_liens_unrel_cj_total_amt_i <= 5096 => final_score_62_c513,
    f_liens_unrel_cj_total_amt_i > 5096                                          => -0.0293614432,
    f_liens_unrel_cj_total_amt_i = NULL                                          => -0.0020168648,
                                                                                    -0.0020168648);

final_score_62 := map(
    NULL < f_curraddrcrimeindex_i AND f_curraddrcrimeindex_i <= 197.5 => final_score_62_c512,
    f_curraddrcrimeindex_i > 197.5                                    => 0.0871109713,
    f_curraddrcrimeindex_i = NULL                                     => -0.0009709392,
                                                                         -0.0009709392);

final_score_63_c520 := map(
    NULL < f_prevaddrdwelltype_apt_n AND f_prevaddrdwelltype_apt_n <= 0.5 => -0.0196166570,
    f_prevaddrdwelltype_apt_n > 0.5                                       => 0.1297227480,
    f_prevaddrdwelltype_apt_n = NULL                                      => 0.0308913202,
                                                                             0.0308913202);

final_score_63_c519 := map(
    NULL < mth_source_ppca_fseen AND mth_source_ppca_fseen <= 35.5 => final_score_63_c520,
    mth_source_ppca_fseen > 35.5                                   => -0.0840964366,
    mth_source_ppca_fseen = NULL                                   => -0.0325308065,
                                                                      -0.0271502307);

final_score_63_c518 := map(
    NULL < mth_source_ppdid_lseen AND mth_source_ppdid_lseen <= 42.5 => 0.0003957121,
    mth_source_ppdid_lseen > 42.5                                    => -0.0844919725,
    mth_source_ppdid_lseen = NULL                                    => final_score_63_c519,
                                                                        -0.0184648400);

final_score_63_c517 := map(
    (pp_origphonetype in ['O', 'V', 'W']) => final_score_63_c518,
    (pp_origphonetype in ['', 'L'])       => 0.0125355796,
    pp_origphonetype = ''               => -0.0042977315,
                                             -0.0042977315);

final_score_63 := map(
    NULL < mth_pp_first_build_date AND mth_pp_first_build_date <= 15.5 => final_score_63_c517,
    mth_pp_first_build_date > 15.5                                     => 0.0216214382,
    mth_pp_first_build_date = NULL                                     => 0.0022692980,
                                                                          0.0029814395);

final_score_64_c523 := map(
    (phone_subject_title in ['Associate By Vehicle', 'Father', 'Grandchild', 'Grandfather', 'Grandmother', 'Husband', 'Mother', 'Parent', 'Sibling', 'Sister', 'Son', 'Spouse', 'Wife'])                                                                                                                          => -0.1150477397,
    (phone_subject_title in ['Associate', 'Associate By Address', 'Associate By Business', 'Associate By Property', 'Associate By Shared Associates', 'Associate By SSN', 'Brother', 'Child', 'Daughter', 'Granddaughter', 'Grandparent', 'Grandson', 'Neighbor', 'Relative', 'Subject', 'Subject at Household']) => -0.0106370339,
    phone_subject_title = ''                                                                                                                                                                                                                                                                                    => -0.0129856013,
                                                                                                                                                                                                                                                                                                                     -0.0129856013);

final_score_64_c525 := map(
    NULL < r_c13_curr_addr_lres_d AND r_c13_curr_addr_lres_d <= 14.5 => -0.0614122312,
    r_c13_curr_addr_lres_d > 14.5                                    => 0.0574353013,
    r_c13_curr_addr_lres_d = NULL                                    => 0.0438349601,
                                                                        0.0438349601);

final_score_64_c524 := map(
    NULL < mth_pp_first_build_date AND mth_pp_first_build_date <= 12.5 => -0.0100785704,
    mth_pp_first_build_date > 12.5                                     => final_score_64_c525,
    mth_pp_first_build_date = NULL                                     => 0.0051145619,
                                                                          0.0075312721);

final_score_64_c522 := map(
    NULL < mth_pp_eda_hist_did_dt AND mth_pp_eda_hist_did_dt <= 29.5 => 0.0094656051,
    mth_pp_eda_hist_did_dt > 29.5                                    => final_score_64_c523,
    mth_pp_eda_hist_did_dt = NULL                                    => final_score_64_c524,
                                                                        0.0022320855);

final_score_64 := map(
    NULL < f_mos_inq_banko_om_lseen_d AND f_mos_inq_banko_om_lseen_d <= 19.5 => -0.0380051241,
    f_mos_inq_banko_om_lseen_d > 19.5                                        => final_score_64_c522,
    f_mos_inq_banko_om_lseen_d = NULL                                        => -0.0003349097,
                                                                                -0.0003349097);

final_score_65_c529 := map(
    NULL < f_rel_under500miles_cnt_d AND f_rel_under500miles_cnt_d <= 36.5 => -0.0485039978,
    f_rel_under500miles_cnt_d > 36.5                                       => 0.2720545735,
    f_rel_under500miles_cnt_d = NULL                                       => -0.0352041379,
                                                                              -0.0352041379);

final_score_65_c530 := map(
    (phone_subject_title in ['Associate', 'Associate By Address', 'Associate By Property', 'Associate By Vehicle', 'Brother', 'Father', 'Grandparent', 'Grandson', 'Husband', 'Mother', 'Neighbor', 'Parent', 'Relative', 'Son', 'Spouse', 'Subject', 'Subject at Household', 'Wife']) => 0.0055505397,
    (phone_subject_title in ['Associate By Business', 'Associate By Shared Associates', 'Associate By SSN', 'Child', 'Daughter', 'Grandchild', 'Granddaughter', 'Grandfather', 'Grandmother', 'Sibling', 'Sister'])                                                                    => 0.0620411202,
    phone_subject_title = ''                                                                                                                                                                                                                                                         => 0.0070243073,
                                                                                                                                                                                                                                                                                          0.0070243073);

final_score_65_c528 := map(
    NULL < mth_source_ppth_fseen AND mth_source_ppth_fseen <= 22.5 => 0.0542037481,
    mth_source_ppth_fseen > 22.5                                   => final_score_65_c529,
    mth_source_ppth_fseen = NULL                                   => final_score_65_c530,
                                                                      0.0056567082);

final_score_65_c527 := map(
    NULL < f_rel_under25miles_cnt_d AND f_rel_under25miles_cnt_d <= 0.5 => -0.0572050134,
    f_rel_under25miles_cnt_d > 0.5                                      => final_score_65_c528,
    f_rel_under25miles_cnt_d = NULL                                     => 0.0221170403,
                                                                           0.0039648201);

final_score_65 := map(
    NULL < eda_days_in_service AND eda_days_in_service <= 2659 => final_score_65_c527,
    eda_days_in_service > 2659                                 => -0.0751778219,
    eda_days_in_service = NULL                                 => 0.0015664619,
                                                                  0.0015664619);

final_score_66_c534 := map(
    NULL < mth_pp_eda_hist_did_dt AND mth_pp_eda_hist_did_dt <= 146.5 => -0.0476278497,
    mth_pp_eda_hist_did_dt > 146.5                                    => 0.0266556598,
    mth_pp_eda_hist_did_dt = NULL                                     => -0.0109831411,
                                                                         -0.0173508105);

final_score_66_c535 := map(
    NULL < mth_pp_eda_hist_did_dt AND mth_pp_eda_hist_did_dt <= 14.5 => 0.1161660454,
    mth_pp_eda_hist_did_dt > 14.5                                    => -0.0624102677,
    mth_pp_eda_hist_did_dt = NULL                                    => 0.0682358008,
                                                                        0.0430082427);

final_score_66_c533 := map(
    NULL < _mod_disc_exp_lgt AND _mod_disc_exp_lgt <= 2.31666035156915 => final_score_66_c534,
    _mod_disc_exp_lgt > 2.31666035156915                               => final_score_66_c535,
    _mod_disc_exp_lgt = NULL                                           => -0.0116043895,
                                                                          -0.0116043895);

final_score_66_c532 := map(
    NULL < f_mos_inq_banko_om_lseen_d AND f_mos_inq_banko_om_lseen_d <= 41.5 => 0.0257717974,
    f_mos_inq_banko_om_lseen_d > 41.5                                        => final_score_66_c533,
    f_mos_inq_banko_om_lseen_d = NULL                                        => -0.0044568825,
                                                                                -0.0044568825);

final_score_66 := map(
    NULL < mth_internal_ver_first_seen AND mth_internal_ver_first_seen <= 34.5 => 0.0127796949,
    mth_internal_ver_first_seen > 34.5                                         => -0.0220245026,
    mth_internal_ver_first_seen = NULL                                         => final_score_66_c532,
                                                                                  0.0021472054);

final_score_67_c537 := map(
    NULL < f_addrchangecrimediff_i AND f_addrchangecrimediff_i <= 4.5 => -0.0204983290,
    f_addrchangecrimediff_i > 4.5                                     => 0.1295656108,
    f_addrchangecrimediff_i = NULL                                    => 0.0216729282,
                                                                         0.0409779824);

final_score_67_c540 := map(
    NULL < (integer)_phone_match_code_n AND (integer)_phone_match_code_n <= 0.5 => 0.0200826938,
    (integer)_phone_match_code_n > 0.5                                 => 0.1490440978,
    (integer)_phone_match_code_n = NULL                                => 0.0257225715,
                                                                 0.0257225715);

final_score_67_c539 := map(
    (phone_subject_title in ['Associate', 'Associate By Property', 'Associate By Vehicle', 'Brother', 'Child', 'Grandparent', 'Grandson', 'Husband', 'Neighbor', 'Relative', 'Sister', 'Spouse', 'Subject', 'Subject at Household'])                                  => 0.0004485755,
    (phone_subject_title in ['Associate By Address', 'Associate By Business', 'Associate By Shared Associates', 'Associate By SSN', 'Daughter', 'Father', 'Grandchild', 'Granddaughter', 'Grandfather', 'Grandmother', 'Mother', 'Parent', 'Sibling', 'Son', 'Wife']) => final_score_67_c540,
    phone_subject_title = ''                                                                                                                                                                                                                                        => 0.0060505799,
                                                                                                                                                                                                                                                                         0.0060505799);

final_score_67_c538 := map(
    NULL < f_liens_unrel_cj_total_amt_i AND f_liens_unrel_cj_total_amt_i <= 1383.5 => final_score_67_c539,
    f_liens_unrel_cj_total_amt_i > 1383.5                                          => -0.0159164870,
    f_liens_unrel_cj_total_amt_i = NULL                                            => 0.0012902104,
                                                                                      0.0012902104);

final_score_67 := map(
    NULL < mth_source_ppth_lseen AND mth_source_ppth_lseen <= 17.5 => final_score_67_c537,
    mth_source_ppth_lseen > 17.5                                   => -0.0447000097,
    mth_source_ppth_lseen = NULL                                   => final_score_67_c538,
                                                                      -0.0000418756);

final_score_68_c544 := map(
    NULL < _phone_zip_match AND _phone_zip_match <= 0.5 => -0.0405451953,
    _phone_zip_match > 0.5                              => 0.1027051517,
    _phone_zip_match = NULL                             => 0.0375731651,
                                                           0.0375731651);

final_score_68_c543 := map(
    NULL < f_rel_ageover50_count_d AND f_rel_ageover50_count_d <= 0.5 => final_score_68_c544,
    f_rel_ageover50_count_d > 0.5                                     => -0.0920052906,
    f_rel_ageover50_count_d = NULL                                    => 0.0043973400,
                                                                         0.0043973400);

final_score_68_c542 := map(
    NULL < mth_source_rm_fseen AND mth_source_rm_fseen <= 0.5 => -0.0885678236,
    mth_source_rm_fseen > 0.5                                 => final_score_68_c543,
    mth_source_rm_fseen = NULL                                => 0.0080738099,
                                                                 0.0068936816);

final_score_68_c545 := map(
    NULL < r_l80_inp_avm_autoval_d AND r_l80_inp_avm_autoval_d <= 38674.5 => 0.0750367366,
    r_l80_inp_avm_autoval_d > 38674.5                                     => -0.0156979665,
    r_l80_inp_avm_autoval_d = NULL                                        => -0.0360161443,
                                                                             -0.0214249492);

final_score_68 := map(
    NULL < r_d31_attr_bankruptcy_recency_d AND r_d31_attr_bankruptcy_recency_d <= 79.5 => final_score_68_c542,
    r_d31_attr_bankruptcy_recency_d > 79.5                                             => final_score_68_c545,
    r_d31_attr_bankruptcy_recency_d = NULL                                             => 0.0019663849,
                                                                                          0.0019663849);

final_score_69_c547 := map(
    (phone_subject_title in ['Associate', 'Associate By Address', 'Associate By SSN', 'Associate By Vehicle', 'Brother', 'Child', 'Daughter', 'Father', 'Granddaughter', 'Grandparent', 'Grandson', 'Husband', 'Mother', 'Neighbor', 'Parent', 'Relative', 'Spouse', 'Wife']) => -0.0538804630,
    (phone_subject_title in ['Associate By Business', 'Associate By Property', 'Associate By Shared Associates', 'Grandchild', 'Grandfather', 'Grandmother', 'Sibling', 'Sister', 'Son', 'Subject', 'Subject at Household'])                                                  => 0.0861091922,
    phone_subject_title = ''                                                                                                                                                                                                                                                => -0.0391882355,
                                                                                                                                                                                                                                                                                 -0.0391882355);

final_score_69_c550 := map(
    NULL < f_addrchangevaluediff_d AND f_addrchangevaluediff_d <= 45 => 0.0387665903,
    f_addrchangevaluediff_d > 45                                     => 0.1745235884,
    f_addrchangevaluediff_d = NULL                                   => 0.0590646679,
                                                                        0.0872148213);

final_score_69_c549 := map(
    NULL < f_rel_ageover40_count_d AND f_rel_ageover40_count_d <= 2.5 => final_score_69_c550,
    f_rel_ageover40_count_d > 2.5                                     => -0.0022489100,
    f_rel_ageover40_count_d = NULL                                    => 0.0336235794,
                                                                         0.0336235794);

final_score_69_c548 := map(
    NULL < mth_source_cr_lseen AND mth_source_cr_lseen <= 1.5 => final_score_69_c549,
    mth_source_cr_lseen > 1.5                                 => -0.0433288155,
    mth_source_cr_lseen = NULL                                => -0.0019858699,
                                                                 -0.0002125049);

final_score_69 := map(
    NULL < pk_phone_match_level AND pk_phone_match_level <= 0.5 => final_score_69_c547,
    pk_phone_match_level > 0.5                                  => final_score_69_c548,
    pk_phone_match_level = NULL                                 => -0.0024333545,
                                                                   -0.0024333545);

final_score_70_c554 := map(
    (phone_subject_title in ['Associate By Property', 'Associate By Vehicle', 'Child', 'Daughter', 'Father', 'Granddaughter', 'Grandfather', 'Husband', 'Sister', 'Son', 'Spouse'])                                                                                                                                    => -0.1448527875,
    (phone_subject_title in ['Associate', 'Associate By Address', 'Associate By Business', 'Associate By Shared Associates', 'Associate By SSN', 'Brother', 'Grandchild', 'Grandmother', 'Grandparent', 'Grandson', 'Mother', 'Neighbor', 'Parent', 'Relative', 'Sibling', 'Subject', 'Subject at Household', 'Wife']) => 0.0238812789,
    phone_subject_title = ''                                                                                                                                                                                                                                                                                         => 0.0150396922,
                                                                                                                                                                                                                                                                                                                          0.0150396922);

final_score_70_c553 := map(
    (phone_subject_title in ['Associate', 'Associate By Address', 'Associate By Business', 'Associate By Property', 'Associate By Vehicle', 'Brother', 'Child', 'Daughter', 'Father', 'Granddaughter', 'Grandfather', 'Grandparent', 'Husband', 'Mother', 'Neighbor', 'Parent', 'Sister', 'Son', 'Spouse', 'Subject', 'Subject at Household']) => final_score_70_c554,
    (phone_subject_title in ['Associate By Shared Associates', 'Associate By SSN', 'Grandchild', 'Grandmother', 'Grandson', 'Relative', 'Sibling', 'Wife'])                                                                                                                                                                                    => 0.1463453979,
    phone_subject_title = ''                                                                                                                                                                                                                                                                                                                 => 0.0294243794,
                                                                                                                                                                                                                                                                                                                                                  0.0294243794);

final_score_70_c555 := map(
    NULL < f_rel_under25miles_cnt_d AND f_rel_under25miles_cnt_d <= 30.5 => 0.0004709413,
    f_rel_under25miles_cnt_d > 30.5                                      => -0.0625777316,
    f_rel_under25miles_cnt_d = NULL                                      => -0.0292915357,
                                                                            -0.0010094062);

final_score_70_c552 := map(
    NULL < mth_phone_fb_rp_date AND mth_phone_fb_rp_date <= 69.5 => final_score_70_c553,
    mth_phone_fb_rp_date > 69.5                                  => -0.0841389467,
    mth_phone_fb_rp_date = NULL                                  => final_score_70_c555,
                                                                    0.0003657186);

final_score_70 := map(
    NULL < r_f01_inp_addr_address_score_d AND r_f01_inp_addr_address_score_d <= 5 => -0.0413750857,
    r_f01_inp_addr_address_score_d > 5                                            => final_score_70_c552,
    r_f01_inp_addr_address_score_d = NULL                                         => -0.0002768022,
                                                                                     -0.0002768022);

final_score_71_c557 := map(
    (phone_subject_title in ['Associate', 'Associate By Property', 'Associate By Shared Associates', 'Associate By SSN', 'Brother', 'Child', 'Grandchild', 'Grandfather', 'Grandmother', 'Grandparent', 'Neighbor', 'Parent', 'Sister', 'Son', 'Spouse', 'Subject', 'Subject at Household', 'Wife']) => 0.0141315652,
    (phone_subject_title in ['Associate By Address', 'Associate By Business', 'Associate By Vehicle', 'Daughter', 'Father', 'Granddaughter', 'Grandson', 'Husband', 'Mother', 'Relative', 'Sibling'])                                                                                                => 0.0866655407,
    phone_subject_title = ''                                                                                                                                                                                                                                                                       => 0.0319126936,
                                                                                                                                                                                                                                                                                                        0.0319126936);

final_score_71_c560 := map(
    NULL < f_prevaddrmedianincome_d AND f_prevaddrmedianincome_d <= 31043 => 0.0345185880,
    f_prevaddrmedianincome_d > 31043                                      => -0.0074830545,
    f_prevaddrmedianincome_d = NULL                                       => -0.0002347687,
                                                                             -0.0002347687);

final_score_71_c559 := map(
    NULL < f_srchaddrsrchcount_i AND f_srchaddrsrchcount_i <= 33.5 => final_score_71_c560,
    f_srchaddrsrchcount_i > 33.5                                   => -0.1014518460,
    f_srchaddrsrchcount_i = NULL                                   => -0.0026253776,
                                                                      -0.0026253776);

final_score_71_c558 := map(
    NULL < mth_pp_eda_hist_did_dt AND mth_pp_eda_hist_did_dt <= 32.5 => 0.0143936152,
    mth_pp_eda_hist_did_dt > 32.5                                    => -0.0157754276,
    mth_pp_eda_hist_did_dt = NULL                                    => final_score_71_c559,
                                                                        -0.0026222238);

final_score_71 := map(
    NULL < f_add_curr_mobility_index_n AND f_add_curr_mobility_index_n <= 0.163372112812204 => final_score_71_c557,
    f_add_curr_mobility_index_n > 0.163372112812204                                         => final_score_71_c558,
    f_add_curr_mobility_index_n = NULL                                                      => 0.0072446274,
                                                                                               0.0002472111);

final_score_72_c565 := map(
    NULL < f_addrchangecrimediff_i AND f_addrchangecrimediff_i <= -28.5 => 0.0452204270,
    f_addrchangecrimediff_i > -28.5                                     => -0.0089456428,
    f_addrchangecrimediff_i = NULL                                      => 0.0282889889,
                                                                           0.0174925173);

final_score_72_c564 := map(
    NULL < f_rel_criminal_count_i AND f_rel_criminal_count_i <= 6.5 => -0.0033608298,
    f_rel_criminal_count_i > 6.5                                    => final_score_72_c565,
    f_rel_criminal_count_i = NULL                                   => 0.0015077860,
                                                                       0.0015077860);

final_score_72_c563 := map(
    NULL < f_util_adl_count_n AND f_util_adl_count_n <= 16.5 => final_score_72_c564,
    f_util_adl_count_n > 16.5                                => -0.0509856254,
    f_util_adl_count_n = NULL                                => -0.0004089388,
                                                                -0.0004089388);

final_score_72_c562 := map(
    NULL < mth_source_md_fseen AND mth_source_md_fseen <= 11 => -0.0228866529,
    mth_source_md_fseen > 11                                 => -0.1173323072,
    mth_source_md_fseen = NULL                               => final_score_72_c563,
                                                                -0.0014896599);

final_score_72 := map(
    NULL < f_prevaddrmedianvalue_d AND f_prevaddrmedianvalue_d <= 845011 => final_score_72_c562,
    f_prevaddrmedianvalue_d > 845011                                     => 0.1282676583,
    f_prevaddrmedianvalue_d = NULL                                       => -0.0006500732,
                                                                            -0.0006500732);

final_score_73_c570 := map(
    NULL < mth_pp_datefirstseen AND mth_pp_datefirstseen <= 65.5 => 0.0197321514,
    mth_pp_datefirstseen > 65.5                                  => 0.1609218517,
    mth_pp_datefirstseen = NULL                                  => 0.0521657232,
                                                                    0.0521657232);

final_score_73_c569 := map(
    NULL < r_c21_m_bureau_adl_fs_d AND r_c21_m_bureau_adl_fs_d <= 339.5 => final_score_73_c570,
    r_c21_m_bureau_adl_fs_d > 339.5                                     => -0.0660403494,
    r_c21_m_bureau_adl_fs_d = NULL                                      => 0.0227387603,
                                                                           0.0227387603);

final_score_73_c568 := map(
    NULL < mth_pp_datevendorlastseen AND mth_pp_datevendorlastseen <= 24.5 => final_score_73_c569,
    mth_pp_datevendorlastseen > 24.5                                       => 0.2008594463,
    mth_pp_datevendorlastseen = NULL                                       => 0.0463212708,
                                                                              0.0463212708);

final_score_73_c567 := map(
    NULL < mth_source_ppth_lseen AND mth_source_ppth_lseen <= 51.5 => final_score_73_c568,
    mth_source_ppth_lseen > 51.5                                   => -0.0596800430,
    mth_source_ppth_lseen = NULL                                   => 0.0041170788,
                                                                      0.0040751370);

final_score_73 := map(
    NULL < f_srchfraudsrchcount_i AND f_srchfraudsrchcount_i <= 38.5 => final_score_73_c567,
    f_srchfraudsrchcount_i > 38.5                                    => -0.0706858447,
    f_srchfraudsrchcount_i = NULL                                    => 0.0027653782,
                                                                        0.0027653782);

final_score_74_c574 := map(
    NULL < (integer)inq_lastseen_n AND (integer)inq_lastseen_n <= 10.5 => 0.0926132642,
    (integer)inq_lastseen_n > 10.5                            => -0.0133218571,
    (integer)inq_lastseen_n = NULL                            => -0.0105056612,
                                                        -0.0064432805);

final_score_74_c573 := map(
    NULL < f_add_input_nhood_bus_pct_i AND f_add_input_nhood_bus_pct_i <= 0.00702781905063734 => -0.0781605621,
    f_add_input_nhood_bus_pct_i > 0.00702781905063734                                         => final_score_74_c574,
    f_add_input_nhood_bus_pct_i = NULL                                                        => -0.0763325197,
                                                                                                 -0.0153314380);

final_score_74_c572 := map(
    NULL < _mod_disc_exp_lgt AND _mod_disc_exp_lgt <= 1.38717489514511 => 0.0131657204,
    _mod_disc_exp_lgt > 1.38717489514511                               => final_score_74_c573,
    _mod_disc_exp_lgt = NULL                                           => 0.0040660074,
                                                                          0.0040660074);

final_score_74_c575 := map(
    NULL < f_rel_homeover50_count_d AND f_rel_homeover50_count_d <= 45.5 => -0.0041447285,
    f_rel_homeover50_count_d > 45.5                                      => 0.0934361084,
    f_rel_homeover50_count_d = NULL                                      => -0.0024663689,
                                                                            -0.0024663689);

final_score_74 := map(
    NULL < mth_pp_app_npa_effective_dt AND mth_pp_app_npa_effective_dt <= 196.5 => final_score_74_c572,
    mth_pp_app_npa_effective_dt > 196.5                                         => -0.0351553866,
    mth_pp_app_npa_effective_dt = NULL                                          => final_score_74_c575,
                                                                                   -0.0018833945);

final_score_75_c578 := map(
    NULL < mth_pp_app_npa_last_change_dt AND mth_pp_app_npa_last_change_dt <= 119.5 => -0.0408746063,
    mth_pp_app_npa_last_change_dt > 119.5                                           => 0.0215008032,
    mth_pp_app_npa_last_change_dt = NULL                                            => -0.0334639515,
                                                                                       -0.0186254146);

final_score_75_c577 := map(
    NULL < r_d32_mos_since_crim_ls_d AND r_d32_mos_since_crim_ls_d <= 74.5 => final_score_75_c578,
    r_d32_mos_since_crim_ls_d > 74.5                                       => 0.0075873667,
    r_d32_mos_since_crim_ls_d = NULL                                       => 0.0042328105,
                                                                              0.0042328105);

final_score_75_c580 := map(
    NULL < f_rel_incomeover75_count_d AND f_rel_incomeover75_count_d <= 7.5 => -0.0509372987,
    f_rel_incomeover75_count_d > 7.5                                        => 0.0825187025,
    f_rel_incomeover75_count_d = NULL                                       => 0.0037644588,
                                                                               0.0037644588);

final_score_75_c579 := map(
    (pp_origphonetype in ['L', 'O', 'V', 'W']) => -0.1125245932,
    (pp_origphonetype in [''])                 => final_score_75_c580,
    pp_origphonetype = ''                    => -0.0439832913,
                                                  -0.0439832913);

final_score_75 := map(
    NULL < f_assocsuspicousidcount_i AND f_assocsuspicousidcount_i <= 8.5 => final_score_75_c577,
    f_assocsuspicousidcount_i > 8.5                                       => final_score_75_c579,
    f_assocsuspicousidcount_i = NULL                                      => 0.0026770381,
                                                                             0.0026770381);

final_score_76_c583 := map(
    NULL < mth_internal_ver_first_seen AND mth_internal_ver_first_seen <= 9.5 => 0.0171483424,
    mth_internal_ver_first_seen > 9.5                                         => -0.0118534558,
    mth_internal_ver_first_seen = NULL                                        => -0.0190175338,
                                                                                 -0.0055271196);

final_score_76_c584 := map(
    NULL < r_c13_curr_addr_lres_d AND r_c13_curr_addr_lres_d <= 27.5 => -0.0358173940,
    r_c13_curr_addr_lres_d > 27.5                                    => 0.0371107796,
    r_c13_curr_addr_lres_d = NULL                                    => 0.0201100262,
                                                                        0.0201100262);

final_score_76_c585 := map(
    NULL < mth_eda_dt_last_seen AND mth_eda_dt_last_seen <= 17.5 => -0.0077107369,
    mth_eda_dt_last_seen > 17.5                                  => 0.1044202982,
    mth_eda_dt_last_seen = NULL                                  => 0.0366570969,
                                                                    -0.0002114943);

final_score_76_c582 := map(
    NULL < mth_pp_first_build_date AND mth_pp_first_build_date <= 19.5 => final_score_76_c583,
    mth_pp_first_build_date > 19.5                                     => final_score_76_c584,
    mth_pp_first_build_date = NULL                                     => final_score_76_c585,
                                                                          0.0002562320);

final_score_76 := map(
    NULL < f_rel_incomeover100_count_d AND f_rel_incomeover100_count_d <= 11.5 => final_score_76_c582,
    f_rel_incomeover100_count_d > 11.5                                         => 0.0982037662,
    f_rel_incomeover100_count_d = NULL                                         => -0.0327130513,
                                                                                  0.0009259797);

final_score_77_c590 := map(
    NULL < f_add_input_nhood_mfd_pct_i AND f_add_input_nhood_mfd_pct_i <= 0.00504452926208651 => -0.1673084615,
    f_add_input_nhood_mfd_pct_i > 0.00504452926208651                                         => 0.0385314020,
    f_add_input_nhood_mfd_pct_i = NULL                                                        => 0.0220395414,
                                                                                                 0.0282888905);

final_score_77_c589 := map(
    NULL < mth_pp_app_npa_last_change_dt AND mth_pp_app_npa_last_change_dt <= 60.5 => final_score_77_c590,
    mth_pp_app_npa_last_change_dt > 60.5                                           => -0.0028688388,
    mth_pp_app_npa_last_change_dt = NULL                                           => 0.0013905966,
                                                                                      0.0019232191);

final_score_77_c588 := map(
    NULL < pp_app_ind_ph_cnt AND pp_app_ind_ph_cnt <= 11.5 => final_score_77_c589,
    pp_app_ind_ph_cnt > 11.5                               => -0.0681813423,
    pp_app_ind_ph_cnt = NULL                               => 0.0000823951,
                                                              0.0000823951);

final_score_77_c587 := map(
    NULL < _pp_rule_iq_wrong_party AND _pp_rule_iq_wrong_party <= 0.5 => final_score_77_c588,
    _pp_rule_iq_wrong_party > 0.5                                     => -0.0447701334,
    _pp_rule_iq_wrong_party = NULL                                    => -0.0020328810,
                                                                         -0.0020328810);

final_score_77 := map(
    NULL < (integer)_inq_adl_ph_industry_flag AND (integer)_inq_adl_ph_industry_flag <= 0.5 => final_score_77_c587,
    (integer)_inq_adl_ph_industry_flag > 0.5                                       => 0.0537587827,
    (integer)_inq_adl_ph_industry_flag = NULL                                      => 0.0021226470,
                                                                             0.0021226470);

final_score_78_c592 := map(
    (segment in ['1 - Other', '2 - Cell Phone'])    => -0.0807952256,
    (segment in ['0 - Disconnected', '3 - ExpHit']) => 0.0151184635,
    segment = ''                                  => -0.0381055711,
                                                       -0.0381055711);

final_score_78_c594 := map(
    NULL < r_c10_m_hdr_fs_d AND r_c10_m_hdr_fs_d <= 328.5 => -0.0844125384,
    r_c10_m_hdr_fs_d > 328.5                              => 0.0171390707,
    r_c10_m_hdr_fs_d = NULL                               => -0.0274056759,
                                                             -0.0274056759);

final_score_78_c595 := map(
    NULL < f_mos_liens_unrel_ot_fseen_d AND f_mos_liens_unrel_ot_fseen_d <= 84.5 => 0.0436614827,
    f_mos_liens_unrel_ot_fseen_d > 84.5                                          => 0.0012147397,
    f_mos_liens_unrel_ot_fseen_d = NULL                                          => 0.0033098232,
                                                                                    0.0033098232);

final_score_78_c593 := map(
    NULL < mth_source_inf_fseen AND mth_source_inf_fseen <= 309.5 => final_score_78_c594,
    mth_source_inf_fseen > 309.5                                  => 0.0721180777,
    mth_source_inf_fseen = NULL                                   => final_score_78_c595,
                                                                     0.0031863785);

final_score_78 := map(
    (pp_source in ['CELL', 'IBEHAVIOR', 'INTRADO', 'OTHER', 'THRIVE'])             => final_score_78_c592,
    (pp_source in ['', 'GONG', 'HEADER', 'INFUTOR', 'INQUIRY', 'PCNSR', 'TARGUS']) => final_score_78_c593,
    pp_source = ''                                                               => 0.0013079598,
                                                                                      0.0013079598);

final_score_79_c599 := map(
    (pp_did_type in ['AMBIG', 'CORE', 'INACTIVE']) => 0.0032769974,
    (pp_did_type in ['', 'C_MERGE', 'NO_SSN'])     => 0.0278135786,
    pp_did_type = ''                             => 0.0124946968,
                                                      0.0124946968);

final_score_79_c598 := map(
    NULL < f_liens_rel_cj_total_amt_i AND f_liens_rel_cj_total_amt_i <= 5777 => final_score_79_c599,
    f_liens_rel_cj_total_amt_i > 5777                                        => -0.1367391483,
    f_liens_rel_cj_total_amt_i = NULL                                        => 0.0112175390,
                                                                                0.0112175390);

final_score_79_c597 := map(
    (phone_subject_title in ['Associate', 'Associate By Property', 'Associate By Shared Associates', 'Associate By Vehicle', 'Daughter', 'Father', 'Grandmother', 'Grandparent', 'Neighbor', 'Parent', 'Sibling'])                                                                      => -0.0342538819,
    (phone_subject_title in ['Associate By Address', 'Associate By Business', 'Associate By SSN', 'Brother', 'Child', 'Grandchild', 'Granddaughter', 'Grandfather', 'Grandson', 'Husband', 'Mother', 'Relative', 'Sister', 'Son', 'Spouse', 'Subject', 'Subject at Household', 'Wife']) => final_score_79_c598,
    phone_subject_title = ''                                                                                                                                                                                                                                                          => 0.0055844508,
                                                                                                                                                                                                                                                                                           0.0055844508);

final_score_79_c600 := map(
    (phone_subject_title in ['Associate', 'Associate By Address', 'Associate By Vehicle', 'Brother', 'Child', 'Father', 'Grandchild', 'Granddaughter', 'Grandparent', 'Grandson', 'Husband', 'Neighbor', 'Relative', 'Sibling', 'Sister', 'Son', 'Spouse', 'Subject', 'Subject at Household']) => -0.0177797679,
    (phone_subject_title in ['Associate By Business', 'Associate By Property', 'Associate By Shared Associates', 'Associate By SSN', 'Daughter', 'Grandfather', 'Grandmother', 'Mother', 'Parent', 'Wife'])                                                                                    => 0.0750029119,
    phone_subject_title = ''                                                                                                                                                                                                                                                                 => -0.0142318139,
                                                                                                                                                                                                                                                                                                  -0.0142318139);

final_score_79 := map(
    NULL < f_util_adl_count_n AND f_util_adl_count_n <= 5.5 => final_score_79_c597,
    f_util_adl_count_n > 5.5                                => final_score_79_c600,
    f_util_adl_count_n = NULL                               => -0.0003947139,
                                                               -0.0003947139);

final_score_80_c603 := map(
    NULL < mth_source_paw_lseen AND mth_source_paw_lseen <= 6.5 => -0.0225796803,
    mth_source_paw_lseen > 6.5                                  => 0.0675234467,
    mth_source_paw_lseen = NULL                                 => -0.0073374731,
                                                                   -0.0061541110);

final_score_80_c602 := map(
    NULL < mth_source_inf_fseen AND mth_source_inf_fseen <= 230.5 => -0.0227306907,
    mth_source_inf_fseen > 230.5                                  => 0.0622794859,
    mth_source_inf_fseen = NULL                                   => final_score_80_c603,
                                                                     -0.0041777258);

final_score_80_c605 := map(
    NULL < mth_source_ppca_fseen AND mth_source_ppca_fseen <= 17.5 => 0.0886498484,
    mth_source_ppca_fseen > 17.5                                   => -0.0874140397,
    mth_source_ppca_fseen = NULL                                   => 0.0150048688,
                                                                      0.0145717473);

final_score_80_c604 := map(
    (phone_subject_title in ['Associate', 'Associate By Address', 'Associate By Shared Associates', 'Associate By SSN', 'Grandmother', 'Mother', 'Neighbor', 'Parent', 'Sibling', 'Son', 'Spouse', 'Subject', 'Subject at Household'])                              => final_score_80_c605,
    (phone_subject_title in ['Associate By Business', 'Associate By Property', 'Associate By Vehicle', 'Brother', 'Child', 'Daughter', 'Father', 'Grandchild', 'Granddaughter', 'Grandfather', 'Grandparent', 'Grandson', 'Husband', 'Relative', 'Sister', 'Wife']) => 0.1086454182,
    phone_subject_title = ''                                                                                                                                                                                                                                      => 0.0236417905,
                                                                                                                                                                                                                                                                       0.0236417905);

final_score_80 := map(
    NULL < f_liens_unrel_o_total_amt_i AND f_liens_unrel_o_total_amt_i <= 265.5 => final_score_80_c602,
    f_liens_unrel_o_total_amt_i > 265.5                                         => final_score_80_c604,
    f_liens_unrel_o_total_amt_i = NULL                                          => -0.0017013117,
                                                                                   -0.0017013117);

final_score_81_c607 := map(
    NULL < f_crim_rel_under500miles_cnt_i AND f_crim_rel_under500miles_cnt_i <= 10.5 => -0.0000412929,
    f_crim_rel_under500miles_cnt_i > 10.5                                            => 0.1475963411,
    f_crim_rel_under500miles_cnt_i = NULL                                            => 0.0179177188,
                                                                                        0.0179177188);

final_score_81_c610 := map(
    NULL < (integer)inq_lastseen_n AND (integer)inq_lastseen_n <= 13.5 => -0.0181144605,
    (integer)inq_lastseen_n > 13.5                            => -0.0654045375,
    (integer)inq_lastseen_n = NULL                            => -0.0026318003,
                                                        -0.0229904306);

final_score_81_c609 := map(
    NULL < _mod_disc_exp_lgt AND _mod_disc_exp_lgt <= 2.13663501599734 => final_score_81_c610,
    _mod_disc_exp_lgt > 2.13663501599734                               => 0.0619716914,
    _mod_disc_exp_lgt = NULL                                           => -0.0133282352,
                                                                          -0.0133282352);

final_score_81_c608 := map(
    NULL < mth_pp_datefirstseen AND mth_pp_datefirstseen <= 13.5 => final_score_81_c609,
    mth_pp_datefirstseen > 13.5                                  => 0.0092926220,
    mth_pp_datefirstseen = NULL                                  => -0.0039087346,
                                                                    0.0004852346);

final_score_81 := map(
    NULL < mth_source_rm_fseen AND mth_source_rm_fseen <= 12.5 => final_score_81_c607,
    mth_source_rm_fseen > 12.5                                 => -0.0888662966,
    mth_source_rm_fseen = NULL                                 => final_score_81_c608,
                                                                  0.0003015294);

final_score_82_c614 := map(
    NULL < f_corrssnnamecount_d AND f_corrssnnamecount_d <= 4.5 => -0.0492617821,
    f_corrssnnamecount_d > 4.5                                  => 0.0212398538,
    f_corrssnnamecount_d = NULL                                 => 0.0044711357,
                                                                   0.0044711357);

final_score_82_c613 := map(
    NULL < f_add_curr_nhood_mfd_pct_i AND f_add_curr_nhood_mfd_pct_i <= 0.554106587187221 => -0.0119804779,
    f_add_curr_nhood_mfd_pct_i > 0.554106587187221                                        => 0.0124952388,
    f_add_curr_nhood_mfd_pct_i = NULL                                                     => final_score_82_c614,
                                                                                             -0.0056701787);

final_score_82_c615 := map(
    NULL < f_rel_under500miles_cnt_d AND f_rel_under500miles_cnt_d <= 6.5 => -0.0859801372,
    f_rel_under500miles_cnt_d > 6.5                                       => 0.0467693168,
    f_rel_under500miles_cnt_d = NULL                                      => 0.0333041371,
                                                                             0.0333041371);

final_score_82_c612 := map(
    (phone_subject_title in ['Associate', 'Associate By Address', 'Associate By Property', 'Associate By Shared Associates', 'Associate By Vehicle', 'Daughter', 'Grandchild', 'Granddaughter', 'Grandmother', 'Grandparent', 'Neighbor', 'Parent', 'Relative', 'Sibling', 'Sister', 'Spouse', 'Subject', 'Subject at Household', 'Wife']) => final_score_82_c613,
    (phone_subject_title in ['Associate By Business', 'Associate By SSN', 'Brother', 'Child', 'Father', 'Grandfather', 'Grandson', 'Husband', 'Mother', 'Son'])                                                                                                                                                                            => final_score_82_c615,
    phone_subject_title = ''                                                                                                                                                                                                                                                                                                             => -0.0038393805,
                                                                                                                                                                                                                                                                                                                                              -0.0038393805);

final_score_82 := map(
    NULL < mth_source_sx_fseen AND mth_source_sx_fseen <= 22.5 => 0.0613965193,
    mth_source_sx_fseen > 22.5                                 => 0.0284090083,
    mth_source_sx_fseen = NULL                                 => final_score_82_c612,
                                                                  -0.0006701564);

final_score_83_c618 := map(
    NULL < mth_source_rm_lseen AND mth_source_rm_lseen <= 0.5 => 0.0334590237,
    mth_source_rm_lseen > 0.5                                 => -0.1098591184,
    mth_source_rm_lseen = NULL                                => -0.0021431026,
                                                                 -0.0011863438);

final_score_83_c619 := map(
    (phone_subject_title in ['Associate', 'Daughter', 'Father', 'Grandfather', 'Mother', 'Neighbor', 'Sibling', 'Sister', 'Son', 'Spouse', 'Subject', 'Subject at Household', 'Wife'])                                                                                                                              => 0.0249277779,
    (phone_subject_title in ['Associate By Address', 'Associate By Business', 'Associate By Property', 'Associate By Shared Associates', 'Associate By SSN', 'Associate By Vehicle', 'Brother', 'Child', 'Grandchild', 'Granddaughter', 'Grandmother', 'Grandparent', 'Grandson', 'Husband', 'Parent', 'Relative']) => 0.1054610585,
    phone_subject_title = ''                                                                                                                                                                                                                                                                                      => 0.0290302149,
                                                                                                                                                                                                                                                                                                                       0.0290302149);

final_score_83_c617 := map(
    (exp_source in ['', 'P']) => final_score_83_c618,
    (exp_source in ['S'])     => final_score_83_c619,
    exp_source = ''         => 0.0067358774,
                                 0.0067358774);

final_score_83_c620 := map(
    NULL < f_prevaddrlenofres_d AND f_prevaddrlenofres_d <= 286.5 => -0.0137362977,
    f_prevaddrlenofres_d > 286.5                                  => -0.1262888040,
    f_prevaddrlenofres_d = NULL                                   => -0.0178481797,
                                                                     -0.0178481797);

final_score_83 := map(
    NULL < f_inq_count_i AND f_inq_count_i <= 17.5 => final_score_83_c617,
    f_inq_count_i > 17.5                           => final_score_83_c620,
    f_inq_count_i = NULL                           => 0.0013428094,
                                                      0.0013428094);

final_score_84_c625 := map(
    NULL < _mod_disc_exp_lgt AND _mod_disc_exp_lgt <= 0.556330567776872 => -0.0049683986,
    _mod_disc_exp_lgt > 0.556330567776872                               => 0.0343941960,
    _mod_disc_exp_lgt = NULL                                            => 0.0183190322,
                                                                           0.0183190322);

final_score_84_c624 := map(
    NULL < f_corrrisktype_i AND f_corrrisktype_i <= 6.5 => final_score_84_c625,
    f_corrrisktype_i > 6.5                              => -0.0119110433,
    f_corrrisktype_i = NULL                             => 0.0068405408,
                                                           0.0068405408);

final_score_84_c623 := map(
    NULL < mth_internal_ver_first_seen AND mth_internal_ver_first_seen <= 9.5 => 0.0537350646,
    mth_internal_ver_first_seen > 9.5                                         => 0.0066032463,
    mth_internal_ver_first_seen = NULL                                        => final_score_84_c624,
                                                                                 0.0108030988);

final_score_84_c622 := map(
    NULL < mth_source_ppdid_lseen AND mth_source_ppdid_lseen <= 118.5 => 0.0028997307,
    mth_source_ppdid_lseen > 118.5                                    => -0.1200576956,
    mth_source_ppdid_lseen = NULL                                     => final_score_84_c623,
                                                                         0.0074537631);

final_score_84 := map(
    (phone_subject_title in ['Associate', 'Associate By Property', 'Associate By Vehicle', 'Daughter', 'Grandchild', 'Grandmother', 'Grandparent', 'Grandson', 'Mother', 'Neighbor', 'Parent', 'Sister', 'Son', 'Spouse'])                                                      => -0.0236121082,
    (phone_subject_title in ['Associate By Address', 'Associate By Business', 'Associate By Shared Associates', 'Associate By SSN', 'Brother', 'Child', 'Father', 'Granddaughter', 'Grandfather', 'Husband', 'Relative', 'Sibling', 'Subject', 'Subject at Household', 'Wife']) => final_score_84_c622,
    phone_subject_title = ''                                                                                                                                                                                                                                                  => 0.0028829908,
                                                                                                                                                                                                                                                                                   0.0028829908);

final_score_85_c629 := map(
    NULL < f_sourcerisktype_i AND f_sourcerisktype_i <= 5.5 => 0.1007045314,
    f_sourcerisktype_i > 5.5                                => -0.0679336060,
    f_sourcerisktype_i = NULL                               => 0.0669094829,
                                                               0.0669094829);

final_score_85_c628 := map(
    NULL < f_curraddrmedianincome_d AND f_curraddrmedianincome_d <= 49280 => final_score_85_c629,
    f_curraddrmedianincome_d > 49280                                      => -0.0334377194,
    f_curraddrmedianincome_d = NULL                                       => 0.0196775347,
                                                                             0.0196775347);

final_score_85_c627 := map(
    NULL < mth_source_rm_fseen AND mth_source_rm_fseen <= 19 => final_score_85_c628,
    mth_source_rm_fseen > 19                                 => -0.0961015423,
    mth_source_rm_fseen = NULL                               => 0.0000462644,
                                                                -0.0000673820);

final_score_85_c630 := map(
    (phone_subject_title in ['Associate', 'Associate By Address', 'Associate By Business', 'Associate By Shared Associates', 'Associate By SSN', 'Child', 'Father', 'Neighbor', 'Sister', 'Son', 'Subject', 'Wife'])                                                                  => 0.0225631779,
    (phone_subject_title in ['Associate By Property', 'Associate By Vehicle', 'Brother', 'Daughter', 'Grandchild', 'Granddaughter', 'Grandfather', 'Grandmother', 'Grandparent', 'Grandson', 'Husband', 'Mother', 'Parent', 'Relative', 'Sibling', 'Spouse', 'Subject at Household']) => 0.1396981644,
    phone_subject_title = ''                                                                                                                                                                                                                                                        => 0.0430902791,
                                                                                                                                                                                                                                                                                         0.0430902791);

final_score_85 := map(
    NULL < r_d33_eviction_count_i AND r_d33_eviction_count_i <= 4.5 => final_score_85_c627,
    r_d33_eviction_count_i > 4.5                                    => final_score_85_c630,
    r_d33_eviction_count_i = NULL                                   => 0.0014597157,
                                                                       0.0014597157);

final_score_86_c634 := map(
    NULL < (integer)inq_adl_lastseen_n AND (integer)inq_adl_lastseen_n <= 35.5 => 0.0085578610,
    (integer)inq_adl_lastseen_n > 35.5                                => -0.0484889149,
    (integer)inq_adl_lastseen_n = NULL                                => 0.0160735002,
                                                                0.0082567337);

final_score_86_c633 := map(
    NULL < pp_avg_source_conf AND pp_avg_source_conf <= 5.5 => -0.0560893454,
    pp_avg_source_conf > 5.5                                => final_score_86_c634,
    pp_avg_source_conf = NULL                               => 0.0035262241,
                                                               0.0035262241);

final_score_86_c635 := map(
    NULL < f_rel_under500miles_cnt_d AND f_rel_under500miles_cnt_d <= 41.5 => -0.0034021042,
    f_rel_under500miles_cnt_d > 41.5                                       => 0.0771613642,
    f_rel_under500miles_cnt_d = NULL                                       => -0.0016382908,
                                                                              -0.0016382908);

final_score_86_c632 := map(
    NULL < mth_pp_app_npa_last_change_dt AND mth_pp_app_npa_last_change_dt <= 189.5 => final_score_86_c633,
    mth_pp_app_npa_last_change_dt > 189.5                                           => 0.0622394196,
    mth_pp_app_npa_last_change_dt = NULL                                            => final_score_86_c635,
                                                                                       0.0032765678);

final_score_86 := map(
    (pp_src in ['E1', 'EB', 'EM', 'EN', 'EQ', 'FA', 'FF', 'KW', 'LP', 'MD', 'NW', 'SV', 'TN', 'VO', 'VW', 'YE', 'ZK', 'ZT']) => -0.0366895536,
    (pp_src in ['', 'CY', 'E2', 'LA', 'PL', 'SL', 'UT', 'UW'])                                                               => final_score_86_c632,
    pp_src = ''                                                                                                            => 0.0002599354,
                                                                                                                                0.0002599354);

final_score_87_c638 := map(
    (pp_src in ['', 'CY', 'E1', 'E2', 'EB', 'EM', 'EN', 'EQ', 'FA', 'FF', 'KW', 'LA', 'LP', 'MD', 'NW', 'SV', 'TN', 'UT', 'UW', 'VO', 'VW', 'YE', 'ZK', 'ZT']) => 0.0001358284,
    (pp_src in ['PL', 'SL'])                                                                                                                                   => 0.1485352675,
    pp_src = ''                                                                                                                                              => 0.0009453327,
                                                                                                                                                                  0.0009453327);

final_score_87_c640 := map(
    NULL < mth_source_ppdid_lseen AND mth_source_ppdid_lseen <= 57.5 => -0.0633127829,
    mth_source_ppdid_lseen > 57.5                                    => 0.0134326461,
    mth_source_ppdid_lseen = NULL                                    => -0.0122729189,
                                                                        -0.0221752354);

final_score_87_c639 := map(
    NULL < (integer)source_paw AND (integer)source_paw <= 0.5 => final_score_87_c640,
    (integer)source_paw > 0.5                        => 0.1163107325,
    (integer)source_paw = NULL                       => -0.0187890413,
                                               -0.0187890413);

final_score_87_c637 := map(
    NULL < f_srchunvrfdphonecount_i AND f_srchunvrfdphonecount_i <= 0.5 => final_score_87_c638,
    f_srchunvrfdphonecount_i > 0.5                                      => final_score_87_c639,
    f_srchunvrfdphonecount_i = NULL                                     => -0.0033502871,
                                                                           -0.0033502871);

final_score_87 := map(
    NULL < (integer)_inq_adl_ph_industry_flag AND (integer)_inq_adl_ph_industry_flag <= 0.5 => final_score_87_c637,
    (integer)_inq_adl_ph_industry_flag > 0.5                                       => 0.0457859330,
    (integer)_inq_adl_ph_industry_flag = NULL                                      => 0.0003013709,
                                                                             0.0003013709);

final_score_88_c645 := map(
    NULL < f_corraddrnamecount_d AND f_corraddrnamecount_d <= 6.5 => 0.0329589367,
    f_corraddrnamecount_d > 6.5                                   => 0.0988151627,
    f_corraddrnamecount_d = NULL                                  => 0.0628484774,
                                                                     0.0628484774);

final_score_88_c644 := map(
    NULL < f_add_input_nhood_sfd_pct_d AND f_add_input_nhood_sfd_pct_d <= 0.939406388004519 => final_score_88_c645,
    f_add_input_nhood_sfd_pct_d > 0.939406388004519                                         => -0.0180666798,
    f_add_input_nhood_sfd_pct_d = NULL                                                      => 0.0455621256,
                                                                                               0.0455621256);

final_score_88_c643 := map(
    NULL < r_c13_curr_addr_lres_d AND r_c13_curr_addr_lres_d <= 292 => final_score_88_c644,
    r_c13_curr_addr_lres_d > 292                                    => -0.0931853153,
    r_c13_curr_addr_lres_d = NULL                                   => 0.0364254532,
                                                                       0.0364254532);

final_score_88_c642 := map(
    (phone_subject_title in ['Associate', 'Associate By Business', 'Associate By Property', 'Associate By SSN', 'Associate By Vehicle', 'Brother', 'Daughter', 'Grandfather', 'Grandmother', 'Grandparent', 'Neighbor', 'Parent', 'Relative', 'Son', 'Spouse', 'Subject', 'Subject at Household', 'Wife']) => -0.0041412106,
    (phone_subject_title in ['Associate By Address', 'Associate By Shared Associates', 'Child', 'Father', 'Grandchild', 'Granddaughter', 'Grandson', 'Husband', 'Mother', 'Sibling', 'Sister'])                                                                                                            => final_score_88_c643,
    phone_subject_title = ''                                                                                                                                                                                                                                                                             => 0.0035508744,
                                                                                                                                                                                                                                                                                                              0.0035508744);

final_score_88 := map(
    NULL < r_a49_curr_avm_chg_1yr_pct_i AND r_a49_curr_avm_chg_1yr_pct_i <= 215.2 => final_score_88_c642,
    r_a49_curr_avm_chg_1yr_pct_i > 215.2                                          => -0.1239852973,
    r_a49_curr_avm_chg_1yr_pct_i = NULL                                           => -0.0022477011,
                                                                                     -0.0005680436);

final_score_89_c648 := map(
    (phone_subject_title in ['Associate By Address', 'Associate By Property', 'Associate By Shared Associates', 'Associate By Vehicle', 'Brother', 'Child', 'Daughter', 'Father', 'Granddaughter', 'Grandfather', 'Grandparent', 'Grandson', 'Mother', 'Neighbor', 'Parent', 'Relative', 'Son', 'Spouse', 'Subject']) => -0.0431936097,
    (phone_subject_title in ['Associate', 'Associate By Business', 'Associate By SSN', 'Grandchild', 'Grandmother', 'Husband', 'Sibling', 'Sister', 'Subject at Household', 'Wife'])                                                                                                                                  => 0.0505820732,
    phone_subject_title = ''                                                                                                                                                                                                                                                                                        => -0.0325612801,
                                                                                                                                                                                                                                                                                                                         -0.0325612801);

final_score_89_c650 := map(
    NULL < _mod_binnr_exp_lgt AND _mod_binnr_exp_lgt <= -1.71804069724922 => 0.0484849347,
    _mod_binnr_exp_lgt > -1.71804069724922                                => -0.0900539032,
    _mod_binnr_exp_lgt = NULL                                             => -0.0126747250,
                                                                             -0.0126747250);

final_score_89_c649 := map(
    NULL < mth_source_exp_lseen AND mth_source_exp_lseen <= 37.5 => 0.0213530427,
    mth_source_exp_lseen > 37.5                                  => final_score_89_c650,
    mth_source_exp_lseen = NULL                                  => -0.0003529359,
                                                                    0.0019460640);

final_score_89_c647 := map(
    NULL < _phone_timezone_match AND _phone_timezone_match <= 0.5 => final_score_89_c648,
    _phone_timezone_match > 0.5                                   => final_score_89_c649,
    _phone_timezone_match = NULL                                  => -0.0006418762,
                                                                     -0.0006418762);

final_score_89 := map(
    NULL < r_paw_dead_business_ct_i AND r_paw_dead_business_ct_i <= 3.5 => final_score_89_c647,
    r_paw_dead_business_ct_i > 3.5                                      => 0.1034533139,
    r_paw_dead_business_ct_i = NULL                                     => 0.0001369346,
                                                                           0.0001369346);

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
    final_score_89;

phat := exp(final_score) / (1 + exp(final_score));

cp33 := round(1000 * phat);

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
   self.phone_pos_eqp                    := phone_pos_eqp;
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
   self.source_cr_lseen                  := source_cr_lseen;
   self.source_cr_fseen                  := source_cr_fseen;
   self.source_edaca_fseen               := source_edaca_fseen;
   self.source_edahistory_lseen          := source_edahistory_lseen;
   self.source_exp_lseen                 := source_exp_lseen;
   self.source_exp_fseen                 := source_exp_fseen;
   self.source_inf_fseen                 := source_inf_fseen;
   self.source_md_lseen                  := source_md_lseen;
   self.source_md_fseen                  := source_md_fseen;
   self.source_ne_fseen                  := source_ne_fseen;
   self.source_paw_lseen                 := source_paw_lseen;
   self.source_ppca_lseen                := source_ppca_lseen;
   self.source_ppca_fseen                := source_ppca_fseen;
   self.source_ppdid_lseen               := source_ppdid_lseen;
   self.source_ppdid_fseen               := source_ppdid_fseen;
   self.source_ppfla_lseen               := source_ppfla_lseen;
   self.source_ppla_lseen                := source_ppla_lseen;
   self.source_ppla_fseen                := source_ppla_fseen;
   self.source_ppth_lseen                := source_ppth_lseen;
   self.source_ppth_fseen                := source_ppth_fseen;
   self.source_rm_lseen                  := source_rm_lseen;
   self.source_rm_fseen                  := source_rm_fseen;
   self.source_sx_fseen                  := source_sx_fseen;
   self.source_utildid_fseen             := source_utildid_fseen;
   self.number_of_sources                := number_of_sources;
   self.source_cr_lseen2                 := source_cr_lseen2;
   self.mth_source_cr_lseen              := mth_source_cr_lseen;
   self.source_cr_fseen2                 := source_cr_fseen2;
   self.mth_source_cr_fseen              := mth_source_cr_fseen;
   self.source_edaca_fseen2              := source_edaca_fseen2;
   self.mth_source_edaca_fseen           := mth_source_edaca_fseen;
   self.source_edahistory_lseen2         := source_edahistory_lseen2;
   self.mth_source_edahistory_lseen      := mth_source_edahistory_lseen;
   self.source_exp_lseen2                := source_exp_lseen2;
   self.mth_source_exp_lseen             := mth_source_exp_lseen;
   self.source_exp_fseen2                := source_exp_fseen2;
   self.mth_source_exp_fseen             := mth_source_exp_fseen;
   self.source_inf_fseen2                := source_inf_fseen2;
   self.mth_source_inf_fseen             := mth_source_inf_fseen;
   self.source_md_lseen2                 := source_md_lseen2;
   self.mth_source_md_lseen              := mth_source_md_lseen;
   self.source_md_fseen2                 := source_md_fseen2;
   self.mth_source_md_fseen              := mth_source_md_fseen;
   self.source_paw_lseen2                := source_paw_lseen2;
   self.mth_source_paw_lseen             := mth_source_paw_lseen;
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
   self.source_ppla_lseen2               := source_ppla_lseen2;
   self.mth_source_ppla_lseen            := mth_source_ppla_lseen;
   self.source_ppla_fseen2               := source_ppla_fseen2;
   self.mth_source_ppla_fseen            := mth_source_ppla_fseen;
   self.source_ppth_lseen2               := source_ppth_lseen2;
   self.mth_source_ppth_lseen            := mth_source_ppth_lseen;
   self.source_ppth_fseen2               := source_ppth_fseen2;
   self.mth_source_ppth_fseen            := mth_source_ppth_fseen;
   self.source_rm_lseen2                 := source_rm_lseen2;
   self.mth_source_rm_lseen              := mth_source_rm_lseen;
   self.source_rm_fseen2                 := source_rm_fseen2;
   self.mth_source_rm_fseen              := mth_source_rm_fseen;
   self.source_sx_fseen2                 := source_sx_fseen2;
   self.mth_source_sx_fseen              := mth_source_sx_fseen;
   self.source_ne_fseen2                 := source_ne_fseen2;
   self.mth_source_ne_fseen              := mth_source_ne_fseen;
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
   self.pp_datevendorlastseen2           := pp_datevendorlastseen2;
   self.mth_pp_datevendorlastseen        := mth_pp_datevendorlastseen;
   self.pp_orig_lastseen2                := pp_orig_lastseen2;
   self.mth_pp_orig_lastseen             := mth_pp_orig_lastseen;
   self.pp_app_npa_effective_dt2         := pp_app_npa_effective_dt2;
   self.mth_pp_app_npa_effective_dt      := mth_pp_app_npa_effective_dt;
   self.pp_app_npa_last_change_dt2       := pp_app_npa_last_change_dt2;
   self.mth_pp_app_npa_last_change_dt    := mth_pp_app_npa_last_change_dt;
   self.pp_eda_hist_did_dt2              := pp_eda_hist_did_dt2;
   self.mth_pp_eda_hist_did_dt           := mth_pp_eda_hist_did_dt;
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
   self._pp_rule_port_neustar            := _pp_rule_port_neustar;
   self._pp_rule_high_vend_conf          := _pp_rule_high_vend_conf;
   self._pp_rule_cellphone_latest        := _pp_rule_cellphone_latest;
   self._pp_rule_med_vend_conf_cell      := _pp_rule_med_vend_conf_cell;
   self._pp_rule_gong_disc               := _pp_rule_gong_disc;
   self._pp_rule_consort_disc            := _pp_rule_consort_disc;
   self._pp_rule_iq_wrong_party          := _pp_rule_iq_wrong_party;
   self._pp_rule_f1_ver_above            := _pp_rule_f1_ver_above;
   self._pp_src_all_uw                   := _pp_src_all_uw;
   self._pp_srule_port_neustar           := _pp_srule_port_neustar;
   self._pp_app_ported_match_10          := _pp_app_ported_match_10;
   self.inq_lastseen_n                   := inq_lastseen_n;
   self.inq_adl_firstseen_n              := inq_adl_firstseen_n;
   self.inq_adl_lastseen_n               := inq_adl_lastseen_n;
   self.internal_ver_match_type          := internal_ver_match_type;
   self._internal_ver_match_hhid         := _internal_ver_match_hhid;
   self._inq_adl_ph_industry_flag        := _inq_adl_ph_industry_flag;
   self._phone_disconnected              := _phone_disconnected;
   self._phone_zip_match                 := _phone_zip_match;
   self._phone_timezone_match            := _phone_timezone_match;
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
   self.pk_cell_flag                     := pk_cell_flag;
   self.pk_exp_hit                       := pk_exp_hit;
   self.segment                          := segment;
   self.add_input_pop                    := add_input_pop;
   self.add_curr_pop                     := add_curr_pop;
   self.add_input_address_score          := add_input_address_score;
   self.add_curr_naprop                  := add_curr_naprop;
   self.add_input_avm_auto_val           := add_input_avm_auto_val;
   self.add_curr_avm_auto_val            := add_curr_avm_auto_val;
   self.add_curr_lres                    := add_curr_lres;
   self.add_curr_avm_auto_val_2          := add_curr_avm_auto_val_2;
   self.add_input_naprop                 := add_input_naprop;
   self.add_prev_naprop                  := add_prev_naprop;
   self.add_input_nhood_bus_ct           := add_input_nhood_bus_ct;
   self.add_input_nhood_sfd_ct           := add_input_nhood_sfd_ct;
   self.add_input_nhood_mfd_ct           := add_input_nhood_mfd_ct;
   self.add_curr_occupants_1yr           := add_curr_occupants_1yr;
   self.add_curr_turnover_1yr_in         := add_curr_turnover_1yr_in;
   self.add_curr_turnover_1yr_out        := add_curr_turnover_1yr_out;
   self.add_curr_nhood_bus_ct            := add_curr_nhood_bus_ct;
   self.add_curr_nhood_sfd_ct            := add_curr_nhood_sfd_ct;
   self.add_curr_nhood_mfd_ct            := add_curr_nhood_mfd_ct;
   self.r_f01_inp_addr_address_score_d   := r_f01_inp_addr_address_score_d;
   self._criminal_last_date              := _criminal_last_date;
   self.r_d32_mos_since_crim_ls_d        := r_d32_mos_since_crim_ls_d;
   self.r_d31_attr_bankruptcy_recency_d  := r_d31_attr_bankruptcy_recency_d;
   self.r_d33_eviction_count_i           := r_d33_eviction_count_i;
   self.bureau_adl_eq_fseen_pos          := bureau_adl_eq_fseen_pos;
   self.bureau_adl_fseen_eq              := bureau_adl_fseen_eq;
   self._bureau_adl_fseen_eq             := _bureau_adl_fseen_eq;
   self._src_bureau_adl_fseen            := _src_bureau_adl_fseen;
   self.r_c21_m_bureau_adl_fs_d          := r_c21_m_bureau_adl_fs_d;
   self._header_first_seen               := _header_first_seen;
   self.r_c10_m_hdr_fs_d                 := r_c10_m_hdr_fs_d;
   self.r_a44_curr_add_naprop_d          := r_a44_curr_add_naprop_d;
   self.r_l80_inp_avm_autoval_d          := r_l80_inp_avm_autoval_d;
   self.r_a46_curr_avm_autoval_d         := r_a46_curr_avm_autoval_d;
   self.r_a49_curr_avm_chg_1yr_i         := r_a49_curr_avm_chg_1yr_i;
   self.r_a49_curr_avm_chg_1yr_pct_i     := r_a49_curr_avm_chg_1yr_pct_i;
   self.r_c13_curr_addr_lres_d           := r_c13_curr_addr_lres_d;
   self.r_c13_max_lres_d                 := r_c13_max_lres_d;
   self.r_c14_addrs_5yr_i                := r_c14_addrs_5yr_i;
   self.r_c14_addrs_10yr_i               := r_c14_addrs_10yr_i;
   self.r_c14_addrs_15yr_i               := r_c14_addrs_15yr_i;
   self.r_a41_prop_owner_d               := r_a41_prop_owner_d;
   self.r_a41_prop_owner_inp_only_d      := r_a41_prop_owner_inp_only_d;
   self.r_prop_owner_history_d           := r_prop_owner_history_d;
   self.r_a50_pb_average_dollars_d       := r_a50_pb_average_dollars_d;
   self.r_pb_order_freq_d                := r_pb_order_freq_d;
   self.r_i60_inq_comm_recency_d         := r_i60_inq_comm_recency_d;
   self.f_bus_lname_verd_d               := f_bus_lname_verd_d;
   self.f_util_adl_count_n               := f_util_adl_count_n;
   self.add_input_nhood_prop_sum         := add_input_nhood_prop_sum;
   self.f_add_input_nhood_bus_pct_i      := f_add_input_nhood_bus_pct_i;
   self.f_add_input_nhood_mfd_pct_i      := f_add_input_nhood_mfd_pct_i;
   self.f_add_input_nhood_sfd_pct_d      := f_add_input_nhood_sfd_pct_d;
   self.f_add_curr_mobility_index_n      := f_add_curr_mobility_index_n;
   self.add_curr_nhood_prop_sum          := add_curr_nhood_prop_sum;
   self.f_add_curr_nhood_mfd_pct_i       := f_add_curr_nhood_mfd_pct_i;
   self.f_inq_count_i                    := f_inq_count_i;
   self.f_inq_collection_count_i         := f_inq_collection_count_i;
   self.f_inq_communications_count_i     := f_inq_communications_count_i;
   self.f_inq_highriskcredit_count24_i   := f_inq_highriskcredit_count24_i;
   self.f_inq_other_count_i              := f_inq_other_count_i;
   self._inq_banko_cm_last_seen          := _inq_banko_cm_last_seen;
   self.f_mos_inq_banko_cm_lseen_d       := f_mos_inq_banko_cm_lseen_d;
   self._inq_banko_om_last_seen          := _inq_banko_om_last_seen;
   self.f_mos_inq_banko_om_lseen_d       := f_mos_inq_banko_om_lseen_d;
   self._liens_unrel_cj_last_seen        := _liens_unrel_cj_last_seen;
   self.f_mos_liens_unrel_cj_lseen_d     := f_mos_liens_unrel_cj_lseen_d;
   self.f_liens_unrel_cj_total_amt_i     := f_liens_unrel_cj_total_amt_i;
   self.f_liens_rel_cj_total_amt_i       := f_liens_rel_cj_total_amt_i;
   self.f_liens_unrel_o_total_amt_i      := f_liens_unrel_o_total_amt_i;
   self._liens_unrel_ot_first_seen       := _liens_unrel_ot_first_seen;
   self.f_mos_liens_unrel_ot_fseen_d     := f_mos_liens_unrel_ot_fseen_d;
   self.f_wealth_index_d                 := f_wealth_index_d;
   self.f_rel_incomeover25_count_d       := f_rel_incomeover25_count_d;
   self.f_rel_incomeover50_count_d       := f_rel_incomeover50_count_d;
   self.f_rel_incomeover75_count_d       := f_rel_incomeover75_count_d;
   self.f_rel_incomeover100_count_d      := f_rel_incomeover100_count_d;
   self.f_rel_homeover50_count_d         := f_rel_homeover50_count_d;
   self.f_rel_homeover100_count_d        := f_rel_homeover100_count_d;
   self.f_rel_ageover40_count_d          := f_rel_ageover40_count_d;
   self.f_rel_ageover50_count_d          := f_rel_ageover50_count_d;
   self.f_crim_rel_under500miles_cnt_i   := f_crim_rel_under500miles_cnt_i;
   self.f_rel_under25miles_cnt_d         := f_rel_under25miles_cnt_d;
   self.f_rel_under500miles_cnt_d        := f_rel_under500miles_cnt_d;
   self.f_rel_criminal_count_i           := f_rel_criminal_count_i;
   self.f_idrisktype_i                   := f_idrisktype_i;
   self.f_sourcerisktype_i               := f_sourcerisktype_i;
   self.f_varrisktype_i                  := f_varrisktype_i;
   self.f_srchvelocityrisktype_i         := f_srchvelocityrisktype_i;
   self.f_srchunvrfdphonecount_i         := f_srchunvrfdphonecount_i;
   self.f_srchfraudsrchcount_i           := f_srchfraudsrchcount_i;
   self.f_assocsuspicousidcount_i        := f_assocsuspicousidcount_i;
   self.f_corrrisktype_i                 := f_corrrisktype_i;
   self.f_corrssnnamecount_d             := f_corrssnnamecount_d;
   self.f_corraddrnamecount_d            := f_corraddrnamecount_d;
   self.f_srchaddrsrchcount_i            := f_srchaddrsrchcount_i;
   self.f_inputaddractivephonelist_d     := f_inputaddractivephonelist_d;
   self.f_addrchangevaluediff_d          := f_addrchangevaluediff_d;
   self.f_addrchangecrimediff_i          := f_addrchangecrimediff_i;
   self.f_curraddrmedianincome_d         := f_curraddrmedianincome_d;
   self.f_curraddrmurderindex_i          := f_curraddrmurderindex_i;
   self.f_curraddrcartheftindex_i        := f_curraddrcartheftindex_i;
   self.f_curraddrcrimeindex_i           := f_curraddrcrimeindex_i;
   self.f_prevaddrageoldest_d            := f_prevaddrageoldest_d;
   self.f_prevaddrlenofres_d             := f_prevaddrlenofres_d;
   self.f_prevaddrdwelltype_apt_n        := f_prevaddrdwelltype_apt_n;
   self.f_prevaddrmedianincome_d         := f_prevaddrmedianincome_d;
   self.f_prevaddrmedianvalue_d          := f_prevaddrmedianvalue_d;
   self.f_fp_prevaddrcrimeindex_i        := f_fp_prevaddrcrimeindex_i;
   self.r_paw_dead_business_ct_i         := r_paw_dead_business_ct_i;
   self.r_paw_active_phone_ct_d          := r_paw_active_phone_ct_d;
   self.r_c13_avg_lres_d                 := r_c13_avg_lres_d;
   self._mod_disc_exp_v01_w              := _mod_disc_exp_v01_w;
   self._mod_disc_exp_v02_w              := _mod_disc_exp_v02_w;
   self._mod_disc_exp_v03_w              := _mod_disc_exp_v03_w;
   self._mod_disc_exp_v04_w              := _mod_disc_exp_v04_w;
   self._mod_disc_exp_v05_w              := _mod_disc_exp_v05_w;
   self._mod_disc_exp_v06_w              := _mod_disc_exp_v06_w;
   self._mod_disc_exp_v07_w              := _mod_disc_exp_v07_w;
   self._mod_disc_exp_v08_w              := _mod_disc_exp_v08_w;
   self._mod_disc_exp_v09_w              := _mod_disc_exp_v09_w;
   self._mod_disc_exp_v10_w              := _mod_disc_exp_v10_w;
   self._mod_disc_exp_v11_w              := _mod_disc_exp_v11_w;
   self._mod_disc_exp_v12_w              := _mod_disc_exp_v12_w;
   self._mod_disc_exp_v13_w              := _mod_disc_exp_v13_w;
   self._mod_disc_exp_v14_w              := _mod_disc_exp_v14_w;
   self._mod_disc_exp_v15_w              := _mod_disc_exp_v15_w;
   self._mod_disc_exp_v16_w              := _mod_disc_exp_v16_w;
   self._mod_disc_exp_v17_w              := _mod_disc_exp_v17_w;
   self._mod_disc_exp_v18_w              := _mod_disc_exp_v18_w;
   self._mod_disc_exp_v19_w              := _mod_disc_exp_v19_w;
   self._mod_disc_exp_v20_w              := _mod_disc_exp_v20_w;
   self._mod_disc_exp_v21_w              := _mod_disc_exp_v21_w;
   self._mod_disc_exp_v22_w              := _mod_disc_exp_v22_w;
   self._mod_disc_exp_v23_w              := _mod_disc_exp_v23_w;
   self._mod_disc_exp_v24_w              := _mod_disc_exp_v24_w;
   self._mod_disc_exp_v25_w              := _mod_disc_exp_v25_w;
   self._mod_disc_exp_v26_w              := _mod_disc_exp_v26_w;
   self._mod_disc_exp_v27_w              := _mod_disc_exp_v27_w;
   self._mod_disc_exp_v28_w              := _mod_disc_exp_v28_w;
   self._mod_disc_exp_v29_w              := _mod_disc_exp_v29_w;
   self._mod_disc_exp_v30_w              := _mod_disc_exp_v30_w;
   self._mod_disc_exp_v31_w              := _mod_disc_exp_v31_w;
   self._mod_disc_exp_v32_w              := _mod_disc_exp_v32_w;
   self._mod_disc_exp_v33_w              := _mod_disc_exp_v33_w;
   self._mod_disc_exp_v34_w              := _mod_disc_exp_v34_w;
   self._mod_disc_exp_v35_w              := _mod_disc_exp_v35_w;
   self._mod_disc_exp_v36_w              := _mod_disc_exp_v36_w;
   self._mod_disc_exp_v37_w              := _mod_disc_exp_v37_w;
   self._mod_disc_exp_v38_w              := _mod_disc_exp_v38_w;
   self._mod_disc_exp_lgt                := _mod_disc_exp_lgt;
   self._mod_binnr_exp_v01_w             := _mod_binnr_exp_v01_w;
   self._mod_binnr_exp_v02_w             := _mod_binnr_exp_v02_w;
   self._mod_binnr_exp_v03_w             := _mod_binnr_exp_v03_w;
   self._mod_binnr_exp_v04_w             := _mod_binnr_exp_v04_w;
   self._mod_binnr_exp_v05_w             := _mod_binnr_exp_v05_w;
   self._mod_binnr_exp_v06_w             := _mod_binnr_exp_v06_w;
   self._mod_binnr_exp_v07_w             := _mod_binnr_exp_v07_w;
   self._mod_binnr_exp_v08_w             := _mod_binnr_exp_v08_w;
   self._mod_binnr_exp_v09_w             := _mod_binnr_exp_v09_w;
   self._mod_binnr_exp_v10_w             := _mod_binnr_exp_v10_w;
   self._mod_binnr_exp_v11_w             := _mod_binnr_exp_v11_w;
   self._mod_binnr_exp_v12_w             := _mod_binnr_exp_v12_w;
   self._mod_binnr_exp_v13_w             := _mod_binnr_exp_v13_w;
   self._mod_binnr_exp_v14_w             := _mod_binnr_exp_v14_w;
   self._mod_binnr_exp_v15_w             := _mod_binnr_exp_v15_w;
   self._mod_binnr_exp_v16_w             := _mod_binnr_exp_v16_w;
   self._mod_binnr_exp_v17_w             := _mod_binnr_exp_v17_w;
   self._mod_binnr_exp_v18_w             := _mod_binnr_exp_v18_w;
   self._mod_binnr_exp_v19_w             := _mod_binnr_exp_v19_w;
   self._mod_binnr_exp_v20_w             := _mod_binnr_exp_v20_w;
   self._mod_binnr_exp_v21_w             := _mod_binnr_exp_v21_w;
   self._mod_binnr_exp_v22_w             := _mod_binnr_exp_v22_w;
   self._mod_binnr_exp_v23_w             := _mod_binnr_exp_v23_w;
   self._mod_binnr_exp_v24_w             := _mod_binnr_exp_v24_w;
   self._mod_binnr_exp_v25_w             := _mod_binnr_exp_v25_w;
   self._mod_binnr_exp_v26_w             := _mod_binnr_exp_v26_w;
   self._mod_binnr_exp_v27_w             := _mod_binnr_exp_v27_w;
   self._mod_binnr_exp_v28_w             := _mod_binnr_exp_v28_w;
   self._mod_binnr_exp_v29_w             := _mod_binnr_exp_v29_w;
   self._mod_binnr_exp_v30_w             := _mod_binnr_exp_v30_w;
   self._mod_binnr_exp_v31_w             := _mod_binnr_exp_v31_w;
   self._mod_binnr_exp_v32_w             := _mod_binnr_exp_v32_w;
   self._mod_binnr_exp_v33_w             := _mod_binnr_exp_v33_w;
   self._mod_binnr_exp_v34_w             := _mod_binnr_exp_v34_w;
   self._mod_binnr_exp_lgt               := _mod_binnr_exp_lgt;
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
   self.final_score                      := final_score;
   self.phat                             := phat;
   self.cp33                             := cp33;

			self.clam.phone_shell.Phone_Model_Score := (string) cp33;
			self.clam                             := le;

		#else
			self.phone_shell.Phone_Model_Score		:= (string) cp33;
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
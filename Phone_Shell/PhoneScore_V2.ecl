import risk_indicators, riskwise, riskwisefcra, ut, Models;

export PhoneScore_V2(dataset(Phone_Shell.Layout_Phone_Shell.Phone_Shell_Layout) clam, Unsigned2 Score_Threshold	= 245) := FUNCTION

  PHONE_DEBUG := FALSE;

  #if(PHONE_DEBUG)
    layout_debug := record
			integer sysdate                          		;	     
			boolean source_cr                          ;
			boolean source_edaca                       ;
			string source_edaca_lseen                 ;
			boolean source_edadid                      ;
			boolean source_edafa                       ;
			boolean source_edafla                      ;
			string source_edahistory_lseen            ;
			boolean source_edahistory                  ;
			boolean source_edala                       ;
			boolean source_edalfa                      ;
			boolean source_exp                         ;
			string source_exp_fseen                   ;
			boolean source_md                          ;
			boolean source_paw                         ;
			string source_paw_lseen                   ;
			boolean source_pf                          ;
			boolean source_ppca                        ;
			string source_ppca_lseen                  ;
			string source_ppca_fseen                  ;
			boolean source_ppdid                       ;
			string source_ppdid_lseen                 ;
			boolean source_ppfa                        ;
			boolean source_ppfla                       ;
			boolean source_ppla                        ;
			boolean source_pplfa                       ;
			string source_ppth_fseen                  ;
			boolean source_rel                         ;
			boolean source_sp                          ;
			boolean source_sx                          ;
			string source_utildid_fseen               ;
			boolean source_utildid                     ;
			boolean source_eda_any_clean               ;
			boolean source_pp_any_clean                ;
			boolean source_edaca_lseen2                ;
			real yr_source_edaca_lseen                 ;
			integer source_edahistory_lseen2           ;
			real yr_source_edahistory_lseen            ;
			integer source_exp_fseen2                  ;
			real yr_source_exp_fseen                   ;
			integer source_paw_lseen2                  ;
			real yr_source_paw_lseen                   ;
			integer source_ppca_lseen2                 ;
			real yr_source_ppca_lseen                  ;
			integer source_ppca_fseen2                 ;
			real yr_source_ppca_fseen                  ;
			integer source_ppdid_lseen2                ;
			real yr_source_ppdid_lseen                 ;
			integer source_ppth_fseen2                 ;
			real yr_source_ppth_fseen                  ;
			integer source_utildid_fseen2              ;
			real yr_source_utildid_fseen               ;
			integer eda_dt_first_seen2                 ;
			real yr_eda_dt_first_seen                  ;
			integer eda_dt_last_seen2                  ;
			real yr_eda_dt_last_seen                   ;
			integer eda_deletion_date2                 ;
			real yr_eda_deletion_date                  ;
			integer exp_last_update2                   ;
			real yr_exp_last_update                    ;
			integer phone_fb_last_rpc_date2            ;
			real yr_phone_fb_last_rpc_date             ;
			integer phone_fb_rp_date2                  ;
			real yr_phone_fb_rp_date                   ;
			integer pp_datelastseen2                   ;
			real yr_pp_datelastseen                    ;
			integer pp_origphoneregdate2               ;
			real yr_pp_origphoneregdate                ;
			integer pp_eda_hist_ph_dt2                 ;
			real yr_pp_eda_hist_ph_dt                  ;
			integer pp_app_fb_ph_dt2                   ;
			real yr_pp_app_fb_ph_dt                    ;
			integer pp_first_build_date2               ;
			real yr_pp_first_build_date                ;
			integer mth_source_edaca_lseen             ;
			integer mth_source_edahistory_lseen        ;
			integer mth_source_exp_fseen               ;
			integer mth_source_paw_lseen               ;
			integer mth_source_ppca_lseen              ;
			integer mth_source_ppca_fseen              ;
			integer mth_source_ppdid_lseen             ;
			integer mth_source_ppth_fseen              ;
			integer mth_source_utildid_fseen           ;
			integer mth_eda_dt_first_seen              ;
			integer mth_eda_dt_last_seen               ;
			integer mth_eda_deletion_date              ;
			integer mth_exp_last_update                ;
			integer mth_phone_fb_last_rpc_date         ;
			integer mth_phone_fb_rp_date               ;
			integer mth_pp_datelastseen                ;
			integer mth_pp_origphoneregdate            ;
			integer mth_pp_eda_hist_ph_dt              ;
			integer mth_pp_first_build_date            ;
			integer _phone_match_code_a                ;
			integer _phone_match_code_c                ;
			integer _phone_match_code_l                ;
			integer _phone_match_code_n                ;
			integer _phone_match_code_s                ;
			integer _phone_match_code_t                ;
			integer _phone_match_code_z                ;
			boolean _pp_rule_disconnected_eda          ;
			boolean _pp_rule_non_pub                   ;
			boolean _pp_rule_port_neustar              ;
			boolean _pp_rule_high_vend_conf            ;
			boolean _pp_rule_low_vend_conf             ;
			boolean _pp_rule_cellphone_latest          ;
			boolean _pp_rule_source_latest             ;
			boolean _pp_rule_med_vend_conf_cell        ;
			boolean _pp_rule_consort_rpc               ;
			boolean _pp_rule_iq_rpc                    ;
			boolean _pp_rule_ins_ver_above             ;
			boolean _pp_rule_f1_ver_above              ;
			boolean _pp_rule_f1_ver_below              ;
			boolean _pp_did_flag                       ;
			boolean _pp_src_all_ir                     ;
			boolean _pp_src_all_01                     ;
			boolean _pp_src_all_02                     ;
			boolean _pp_src_all_05                     ;
			boolean _pp_src_all_wp                     ;
			boolean _pp_src_all_pn                     ;
			boolean _pp_src_all_go                     ;
			boolean _pp_src_all_eq                     ;
			boolean _pp_src_all_ut                     ;
			boolean _pp_src_all_uw                     ;
			boolean _pp_src_all_cy                     ;
			boolean _pp_src_all_eb                     ;
			boolean _pp_src_all_en                     ;
			boolean _pp_src_all_iq                     ;
			boolean _pp_src_all_ib                     ;
			boolean _pp_bdid_flag                      ;
			boolean _pp_app_nonpub_gong_la             ;
			boolean _pp_eda_hist_match_did             ;
			boolean _pp_eda_hist_match_lap             ;
			boolean _pp_app_ported_match_10            ;
			boolean _eda_did_flag                      ;
			real inq_firstseen_n                       ;
			real inq_lastseen_n                        ;
			real inq_adl_firstseen_n                   ;
			real inq_adl_lastseen_n                    ;
			boolean _internal_ver_match_lexid          ;
			boolean _inq_adl_ph_industry_auto          ;
			boolean _inq_adl_ph_industry_cards         ;
			boolean _inq_adl_ph_industry_coll          ;
			boolean _inq_adl_ph_industry_comm          ;
			boolean _inq_adl_ph_industry_firm          ;
			boolean _inq_adl_ph_industry_invest        ;
			boolean _inq_adl_ph_industry_util          ;
			integer _mth_source_edaca_lseen            ;
			integer _mth_source_edahistory_lseen       ;
			integer _mth_source_exp_fseen              ;
			integer _mth_source_paw_lseen              ;
			integer _mth_source_ppca_lseen             ;
			integer _mth_source_ppca_fseen             ;
			integer _mth_source_ppdid_lseen            ;
			integer _mth_source_ppth_fseen             ;
			integer _mth_source_utildid_fseen          ;
			integer _mth_eda_dt_first_seen             ;
			integer _mth_eda_dt_last_seen              ;
			integer _mth_eda_deletion_date             ;
			integer _mth_exp_last_update               ;
			integer _mth_phone_fb_last_rpc_date        ;
			integer _mth_phone_fb_rp_date              ;
			integer _mth_pp_datelastseen               ;
			integer _mth_pp_origphoneregdate           ;
			integer _mth_pp_eda_hist_ph_dt             ;
			integer _mth_pp_first_build_date           ;
			boolean _pp_confidence                     ;
			integer _pp_agegroup                       ;
			integer _pp_max_orig_conf_score            ;
			integer _pp_min_orig_conf_score            ;
			integer _pp_curr_orig_conf_score           ;
			integer _pp_app_fb_ph                      ;
			boolean _pp_app_seen_once_ind              ;
			integer _pp_app_ind_ph_cnt                 ;
			boolean _pp_app_latest_ph_owner_fl         ;
			boolean _pp_app_best_addr_match_fl         ;
			boolean _pp_app_best_nm_match_fl           ;
			integer _eda_days_in_service               ;
			integer _eda_min_days_connected_ind        ;
			integer _eda_max_days_connected_ind        ;
			integer _eda_days_ind_first_seen           ;
			integer _eda_days_ind_first_seen_w_ph      ;
			integer _eda_days_ph_first_seen            ;
			boolean _eda_address_match_best            ;
			integer _eda_months_addr_last_seen         ;
			integer _eda_num_phs_connected_addr        ;
			integer _eda_num_phs_discon_addr           ;
			integer _eda_num_phs_discon_hhid           ;
			boolean _eda_is_discon_15_days             ;
			boolean _eda_is_discon_180_days            ;
			integer _eda_num_interrupts_cur            ;
			integer _eda_avg_days_interrupt            ;
			boolean _eda_has_cur_discon_60_days        ;
			boolean _eda_has_cur_discon_180_days       ;
			integer _exp_type                          ;
			integer _exp_source                        ;
			boolean _phone_disconnected                ;
			integer _phone_fb_result                   ;
			integer _phone_fb_rp_result                ;
			integer _inq_firstseen_n                   ;
			integer _inq_lastseen_n                    ;
			integer _inq_adl_firstseen_n               ;
			integer _inq_adl_lastseen_n                ;
			integer _phone_match_code_lns              ;
			integer _phone_match_code_tcza             ;
			integer pk_phone_match_level               ;
			integer _pp_app_coctype_landline           ;
			integer _pp_app_coctype_cell               ;
			integer _phone_switch_type_cell            ;
			integer _pp_app_nxx_type_cell              ;
			integer _pp_app_ph_type_cell               ;
			integer _pp_app_company_type_cell          ;
			integer _exp_type_cell                     ;
			integer pk_cell_indicator                  ;
			boolean pk_cell_flag                       ; 
			boolean _pp_glb_dppa_util                  ; 
			boolean _pp_origlistingtype_res            ; 
			boolean pk_eda_hit                         ; 
			boolean pk_exp_hit                         ; 
			boolean pk_pp_hit                          ; 
			string segment                             ;
			integer _mth_source_exp_fseen3             ; 
			integer _mth_source_paw_lseen1             ; 
			integer _mth_source_utildid_fseen1         ; 
			integer _mth_source_utildid_fseen2         ; 
			integer _mth_exp_last_update3              ; 
			integer _mth_phone_fb_last_rpc_date0       ; 
			integer _mth_phone_fb_last_rpc_date3       ; 
			integer _mth_phone_fb_rp_date3             ; 
			integer _exp_type3                         ; 
			integer _exp_source3                       ; 
			integer _phone_fb_result0                  ; 
			integer _phone_fb_result1                  ; 
			integer _phone_fb_result3                  ; 
			integer _phone_fb_rp_result0               ; 
			integer _phone_fb_rp_result1               ; 
			integer _phone_fb_rp_result3               ; 
			integer _inq_firstseen_n0                  ; 
			integer _inq_firstseen_n2                  ; 
			integer _inq_lastseen_n0                   ; 
			integer _inq_lastseen_n1                   ; 
			integer _inq_lastseen_n3                   ; 
			integer _inq_adl_firstseen_n1              ; 
			integer _inq_adl_lastseen_n1               ; 
			integer _inq_adl_lastseen_n2               ; 
			integer _inq_adl_lastseen_n3               ; 
			integer pk_phone_match_level1              ; 
			integer _mth_source_edaca_lseen0           ; 
			integer _mth_source_edaca_lseen1           ; 
			integer _mth_source_edahistory_lseen1      ; 
			integer _mth_eda_dt_first_seen1            ; 
			integer _mth_eda_dt_last_seen0             ; 
			integer _mth_eda_dt_last_seen3             ; 
			integer _mth_eda_deletion_date0            ; 
			integer _mth_eda_deletion_date3            ; 
			integer _eda_days_in_service0              ; 
			integer _eda_max_days_connected_ind3       ; 
			integer _eda_days_ind_first_seen1          ; 
			integer _eda_days_ind_first_seen3          ; 
			integer _eda_days_ind_first_seen_w_ph3     ; 
			integer _eda_days_ph_first_seen1           ; 
			integer _eda_months_addr_last_seen3        ; 
			integer _eda_num_phs_connected_addr1       ; 
			integer _eda_num_phs_discon_addr0          ; 
			integer _eda_num_phs_discon_hhid1          ; 
			integer _eda_num_phs_discon_hhid3          ; 
			integer _eda_avg_days_interrupt1           ; 
			integer _mth_source_ppca_lseen1            ; 
			integer _mth_source_ppca_lseen2            ; 
			integer _mth_source_ppca_fseen0            ; 
			integer _mth_source_ppca_fseen3            ; 
			integer _mth_source_ppdid_lseen0           ; 
			integer _mth_source_ppdid_lseen1           ; 
			integer _mth_source_ppdid_lseen2           ; 
			integer _mth_source_ppdid_lseen3           ; 
			integer _mth_source_ppth_fseen0            ; 
			integer _mth_source_ppth_fseen1            ; 
			integer _mth_source_ppth_fseen2            ; 
			integer _mth_pp_datelastseen0              ; 
			integer _mth_pp_eda_hist_ph_dt3            ; 
			integer _mth_pp_first_build_date3          ; 
			integer _mth_pp_first_build_date1          ; 
			integer _pp_agegroup2                      ; 
			integer _pp_max_orig_conf_score3           ; 
			integer _pp_app_fb_ph3                     ; 
			integer _pp_app_ind_ph_cnt3                ; 
			integer _pp_app_ind_ph_cnt1                ; 
			integer _mth_phone_fb_last_rpc_date0_m     ; 
			integer _phone_fb_result0_m                ; 
			integer _phone_fb_rp_result0_m             ; 
			integer _inq_firstseen_n0_m                ; 
			integer _inq_lastseen_n0_m                 ; 
			integer _mth_source_paw_lseen1_m           ; 
			integer _mth_source_utildid_fseen1_m       ; 
			integer _phone_fb_result1_m                ; 
			integer _phone_fb_rp_result1_m             ; 
			integer _inq_lastseen_n1_m                 ; 
			integer _inq_adl_firstseen_n1_m            ; 
			integer _inq_adl_lastseen_n1_m             ; 
			integer pk_phone_match_level1_m            ; 
			integer _mth_source_utildid_fseen2_m       ; 
			integer _inq_firstseen_n2_m                ; 
			integer _inq_adl_lastseen_n2_m             ; 
			integer _mth_source_exp_fseen3_m           ; 
			integer _mth_exp_last_update3_m            ; 
			integer _mth_phone_fb_last_rpc_date3_m     ; 
			integer _mth_phone_fb_rp_date3_m           ; 
			integer _exp_type3_m                       ; 
			integer _exp_source3_m                     ; 
			integer _phone_fb_result3_m                ; 
			integer _phone_fb_rp_result3_m             ; 
			integer _inq_lastseen_n3_m                 ; 
			integer _inq_adl_lastseen_n3_m             ; 
			integer _mth_source_edaca_lseen0_c         ; 
			integer _mth_source_edaca_fseen0_c         ; 
			integer _mth_eda_dt_last_seen0_c           ; 
			integer _mth_eda_deletion_date0_c          ; 
			integer _eda_days_in_service0_c            ; 
			integer _eda_num_phs_discon_addr0_c        ; 
			integer _mth_source_edaca_lseen1_c         ; 
			integer _mth_source_edahistory_lseen1_c    ; 
			integer _mth_eda_dt_first_seen1_c          ; 
			integer _eda_days_ind_first_seen1_c        ; 
			integer _eda_days_ph_first_seen1_c         ; 
			integer _eda_num_phs_connected_addr1_c     ; 
			integer _eda_num_phs_discon_hhid1_c        ; 
			integer _eda_avg_days_interrupt1_c         ; 
			integer _mth_eda_dt_last_seen3_c           ; 
			integer _mth_eda_deletion_date3_c          ; 
			integer _eda_max_days_connected_ind3_c     ; 
			integer _eda_days_ind_first_seen3_c        ; 
			integer _eda_days_ind_first_seen_w_ph3_c   ; 
			integer _eda_months_addr_last_seen3_c      ; 
			integer _eda_num_phs_discon_hhid3_c        ; 
			integer _mth_source_edaca_lseen0_h         ; 
			integer _mth_source_edaca_fseen0_h         ; 
			integer _mth_eda_dt_last_seen0_h           ; 
			integer _mth_eda_deletion_date0_h          ; 
			integer _eda_days_in_service0_h            ; 
			integer _eda_num_phs_discon_addr0_h        ; 
			integer _mth_source_edaca_lseen1_h         ; 
			integer _mth_source_edahistory_lseen1_h    ; 
			integer _mth_eda_dt_first_seen1_h          ; 
			integer _eda_days_ind_first_seen1_h        ; 
			integer _eda_days_ph_first_seen1_h         ; 
			integer _eda_num_phs_connected_addr1_h     ; 
			integer _eda_num_phs_discon_hhid1_h        ; 
			integer _eda_avg_days_interrupt1_h         ; 
			integer _mth_eda_dt_last_seen3_h           ; 
			integer _mth_eda_deletion_date3_h          ; 
			integer _eda_max_days_connected_ind3_h     ; 
			integer _eda_days_ind_first_seen3_h        ; 
			integer _eda_days_ind_first_seen_w_ph3_h   ; 
			integer _eda_months_addr_last_seen3_h      ; 
			integer _eda_num_phs_discon_hhid3_h        ; 
			integer _mth_source_edaca_lseen0_n         ; 
			integer _mth_source_edaca_fseen0_n         ; 
			integer _mth_eda_dt_last_seen0_n           ; 
			integer _mth_eda_deletion_date0_n          ; 
			integer _eda_days_in_service0_n            ; 
			integer _eda_num_phs_discon_addr0_n        ; 
			integer _mth_source_edaca_lseen1_n         ; 
			integer _mth_source_edahistory_lseen1_n    ; 
			integer _mth_eda_dt_first_seen1_n          ; 
			integer _eda_days_ind_first_seen1_n        ; 
			integer _eda_days_ph_first_seen1_n         ; 
			integer _eda_num_phs_connected_addr1_n     ; 
			integer _eda_num_phs_discon_hhid1_n        ; 
			integer _eda_avg_days_interrupt1_n         ; 
			integer _mth_eda_dt_last_seen3_n           ; 
			integer _mth_eda_deletion_date3_n          ; 
			integer _eda_max_days_connected_ind3_n     ; 
			integer _eda_days_ind_first_seen3_n        ; 
			integer _eda_days_ind_first_seen_w_ph3_n   ; 
			integer _eda_months_addr_last_seen3_n      ; 
			integer _eda_num_phs_discon_hhid3_n        ; 
			integer _mth_source_ppca_fseen0_c          ; 
			integer _mth_source_ppdid_lseen0_c         ; 
			integer _mth_source_ppth_fseen0_c          ; 
			integer _mth_pp_datelastseen0_c            ; 
			integer _mth_source_ppca_lseen1_c          ; 
			integer _mth_source_ppdid_lseen1_c         ; 
			integer _mth_source_ppth_fseen1_c          ; 
			integer _mth_pp_first_build_date1_c        ; 
			integer _pp_app_ind_ph_cnt1_c              ; 
			integer _mth_source_ppca_lseen2_c          ; 
			integer _mth_source_ppdid_lseen2_c         ; 
			integer _mth_source_ppth_fseen2_c          ; 
			integer _pp_agegroup2_c                    ; 
			integer _mth_source_ppca_fseen3_c          ; 
			integer _mth_source_ppdid_lseen3_c         ; 
			integer _mth_pp_eda_hist_ph_dt3_c          ; 
			integer _mth_pp_first_build_date3_c        ; 
			integer _pp_max_orig_conf_score3_c         ; 
			integer _pp_app_fb_ph3_c                   ; 
			integer _pp_app_ind_ph_cnt3_c              ; 
			integer _mth_source_ppca_fseen0_h          ; 
			integer _mth_source_ppdid_lseen0_h         ; 
			integer _mth_source_ppth_fseen0_h          ; 
			integer _mth_pp_datelastseen0_h            ; 
			integer _mth_source_ppca_lseen1_h          ; 
			integer _mth_source_ppdid_lseen1_h         ; 
			integer _mth_source_ppth_fseen1_h          ; 
			integer _mth_pp_first_build_date1_h        ; 
			integer _pp_app_ind_ph_cnt1_h              ; 
			integer _mth_source_ppca_lseen2_h          ; 
			integer _mth_source_ppdid_lseen2_h         ; 
			integer _mth_source_ppth_fseen2_h          ; 
			integer _pp_agegroup2_h                    ; 
			integer _mth_source_ppca_fseen3_h          ; 
			integer _mth_source_ppdid_lseen3_h         ; 
			integer _mth_pp_eda_hist_ph_dt3_h          ; 
			integer _mth_pp_first_build_date3_h        ; 
			integer _pp_max_orig_conf_score3_h         ; 
			integer _pp_app_fb_ph3_h                   ; 
			integer _pp_app_ind_ph_cnt3_h              ; 
			integer _mth_source_ppca_fseen0_n          ; 
			integer _mth_source_ppdid_lseen0_n         ; 
			integer _mth_source_ppth_fseen0_n          ; 
			integer _mth_pp_datelastseen0_n            ; 
			integer _mth_source_ppca_lseen1_n          ; 
			integer _mth_source_ppdid_lseen1_n         ; 
			integer _mth_source_ppth_fseen1_n          ; 
			integer _mth_pp_first_build_date1_n        ; 
			integer _pp_app_ind_ph_cnt1_n              ; 
			integer _mth_source_ppca_fseen3_n          ; 
			integer _mth_source_ppdid_lseen3_n         ; 
			integer _mth_pp_eda_hist_ph_dt3_n          ; 
			integer _mth_pp_first_build_date3_n        ; 
			integer _pp_max_orig_conf_score3_n         ; 
			integer _pp_app_fb_ph3_n                   ; 
			integer _pp_app_ind_ph_cnt3_n              ; 
			integer _mth_source_ppca_lseen2_n          ; 
			integer _mth_source_ppdid_lseen2_n         ; 
			integer _mth_source_ppth_fseen2_n          ; 
			integer _pp_agegroup2_n                    ; 
			integer _mth_eda_deletion_date3_m          ; 
			integer _eda_days_ind_first_seen_w_ph3_m   ; 
			integer _eda_num_phs_discon_addr0_m        ; 
			integer _mth_source_edaca_fseen0_m         ; 
			integer _mth_source_edaca_lseen0_m         ; 
			integer _mth_eda_deletion_date0_m          ; 
			integer _eda_months_addr_last_seen3_m      ; 
			integer _mth_source_edahistory_lseen1_m    ; 
			integer _mth_source_edaca_lseen1_m         ; 
			integer _eda_days_in_service0_m            ; 
			integer _mth_eda_dt_first_seen1_m          ; 
			integer _eda_num_phs_discon_hhid3_m        ; 
			integer _eda_num_phs_discon_hhid1_m        ; 
			integer _eda_avg_days_interrupt1_m         ; 
			integer _mth_eda_dt_last_seen3_m           ; 
			integer _eda_days_ph_first_seen1_m         ; 
			integer _eda_days_ind_first_seen3_m        ; 
			integer _eda_max_days_connected_ind3_m     ; 
			integer _eda_days_ind_first_seen1_m        ; 
			integer _eda_num_phs_connected_addr1_m     ; 
			integer _mth_eda_dt_last_seen0_m           ; 
			integer _mth_source_ppca_fseen0_m          ; 
			integer _mth_source_ppdid_lseen0_m         ; 
			integer _mth_source_ppca_lseen1_m          ; 
			integer _pp_agegroup2_m                    ; 
			integer _mth_source_ppdid_lseen3_m         ; 
			integer _mth_source_ppdid_lseen2_m         ; 
			integer _mth_source_ppth_fseen2_m          ; 
			integer _mth_pp_first_build_date1_m        ; 
			integer _pp_app_ind_ph_cnt3_m              ; 
			integer _mth_source_ppca_lseen2_m          ; 
			integer _mth_pp_first_build_date3_m        ; 
			integer _mth_pp_eda_hist_ph_dt3_m          ; 
			integer _mth_pp_datelastseen0_m            ; 
			integer _pp_max_orig_conf_score3_m         ; 
			integer _mth_source_ppdid_lseen1_m         ; 
			integer _pp_app_fb_ph3_m                   ; 
			integer _mth_source_ppca_fseen3_m          ; 
			integer _mth_source_ppth_fseen1_m          ; 
			integer _pp_app_ind_ph_cnt1_m              ; 
			integer _mth_source_ppth_fseen0_m          ; 
			integer mod_pp_rule_s0                     ; 
			integer mod_pp_rule_s1                     ; 
			integer mod_pp_rule_s2                     ; 
			integer mod_pp_rule_s3                     ; 
			integer mod_pp_src_s0                      ; 
			integer mod_pp_src_s1                      ; 
			integer mod_pp_src_s2                      ; 
			integer mod_pp_src_s3                      ; 
			integer mod_inq_industry_s0                ; 
			integer mod_inq_industry_s1                ; 
			integer mod_eda_current_s0                 ; 
			integer mod_eda_current_s1                 ; 
			integer mod_eda_current_s3                 ; 
			integer mod_eda_historical_s0              ; 
			integer mod_eda_historical_s1              ; 
			integer mod_eda_historical_s3              ; 
			integer mod_eda3_s0                        ; 
			integer mod_eda3_s1                        ; 
			integer mod_eda3_s3                        ; 
			integer mod_exp_s3                         ; 
			integer mod_inq_s0                         ; 
			integer mod_inq_s1                         ; 
			integer mod_inq_s2                         ; 
			integer mod_inq_s3                         ; 
			integer mod_pfb_s0                         ; 
			integer mod_pfb_s1                         ; 
			integer mod_pfb_s3                         ; 
			integer mod_pp_current_s0                  ; 
			integer mod_pp_current_s1                  ; 
			integer mod_pp_current_s2                  ; 
			integer mod_pp_current_s3                  ; 
			integer mod_pp_historical_s0               ; 
			integer mod_pp_historical_s1               ; 
			integer mod_pp_historical_s2               ; 
			integer mod_pp_historical_s3               ; 
			integer mod_pp3_s0                         ; 
			integer mod_pp3_s1                         ; 
			integer mod_pp3_s2                         ; 
			integer mod_pp3_s3                         ; 
			integer src_mod_neg2_s0                    ; 
			integer src_mod_neg2_s2                    ; 
			integer src_mod_pos_clean_s1               ; 
			integer src_mod_pos_clean_s2               ; 
			integer points                             ; 
			real odds                               ; 
			integer base                               ; 
			integer mod14_s0_scr                       ; 
			integer mod14_s0                           ; 
			integer mod14_s1_scr                       ; 
			integer mod14_s1                           ; 
			integer mod14_s2_scr                       ; 
			integer mod14_s2                           ; 
			integer phat                               ; 
			integer mod14_s3_scr                       ; 
			integer mod14_s3                           ; 
			integer mod14_scr                          ; 
			integer phonescore_v2                      ; 
			
			// Save all of the Phone Shell fields for return
			Phone_Shell.Layout_Phone_Shell.Phone_Shell_Layout clam;
    END;
    layout_debug doModel( clam le ) := TRANSFORM
  #else
		Phone_Shell.Layout_Phone_Shell.Phone_Shell_Layout doModel( clam le ) := TRANSFORM
  #end

//Start: ECL SAS mapping variables 
	in_processing_date               := le.Phone_Shell.Input_Echo.in_Processing_Date;
	source_list                      := le.Phone_Shell.Sources.Source_List;
	source_list_last_seen            := le.Phone_Shell.Sources.Source_List_Last_Seen;
	source_list_first_seen           := le.Phone_Shell.Sources.Source_List_First_Seen;
	phone_switch_type                := le.Phone_Shell.Raw_Phone_Characteristics.Phone_Switch_Type;
	phone_disconnected               := (integer)le.Phone_Shell.Raw_Phone_Characteristics.Phone_Disconnected;
	phone_match_code                 := le.Phone_Shell.Raw_Phone_Characteristics.Phone_Match_Code;
	phone_subject_title              := le.Phone_Shell.Raw_Phone_Characteristics.Phone_Subject_Title;
	pp_type                          := le.Phone_Shell.PhonesPlus_Characteristics.PhonesPlus_Type;
	pp_source                        := le.Phone_Shell.PhonesPlus_Characteristics.PhonesPlus_Source;
	pp_carrier                       := le.Phone_Shell.PhonesPlus_Characteristics.PhonesPlus_Carrier;
	pp_city                          := le.Phone_Shell.PhonesPlus_Characteristics.PhonesPlus_City;
	pp_state                         := le.Phone_Shell.PhonesPlus_Characteristics.PhonesPlus_State;
	pp_rp_type                       := le.Phone_Shell.PhonesPlus_Characteristics.PhonesPlus_RP_Type;
	pp_rp_source                     := le.Phone_Shell.PhonesPlus_Characteristics.PhonesPlus_RP_Source;
	pp_rp_carrier                    := le.Phone_Shell.PhonesPlus_Characteristics.PhonesPlus_RP_Carrier;
	pp_rp_city                       := le.Phone_Shell.PhonesPlus_Characteristics.PhonesPlus_RP_City;
	pp_rp_state                      := le.Phone_Shell.PhonesPlus_Characteristics.PhonesPlus_RP_State;
	pp_confidence                    := le.Phone_Shell.PhonesPlus_Characteristics.PhonesPlus_Confidence;
	pp_rules                         := le.Phone_Shell.PhonesPlus_Characteristics.PhonesPlus_Rules;
	pp_did                           := le.Phone_Shell.PhonesPlus_Characteristics.PhonesPlus_DID;
	pp_did_score                     := le.Phone_Shell.PhonesPlus_Characteristics.PhonesPlus_DID_Score;
	pp_listing_name                  := le.Phone_Shell.PhonesPlus_Characteristics.PhonesPlus_Listing_Name;
	pp_datefirstseen                 := le.Phone_Shell.PhonesPlus_Characteristics.PhonesPlus_DateFirstSeen;
	pp_datelastseen                  := le.Phone_Shell.PhonesPlus_Characteristics.PhonesPlus_DateLastSeen;
	pp_datevendorfirstseen           := le.Phone_Shell.PhonesPlus_Characteristics.PhonesPlus_DateVendorFirstSeen;
	pp_datevendorlastseen            := le.Phone_Shell.PhonesPlus_Characteristics.PhonesPlus_DateVendorLastSeen;
	pp_date_nonglb_lastseen          := le.Phone_Shell.PhonesPlus_Characteristics.PhonesPlus_Date_NonGLB_LastSeen;
	pp_glb_dppa_fl                   := le.Phone_Shell.PhonesPlus_Characteristics.PhonesPlus_GLB_DPPA_Flag;
	pp_glb_dppa_all                  := le.Phone_Shell.PhonesPlus_Characteristics.PhonesPlus_GLB_DPPA_All;
	pp_src                           := le.Phone_Shell.PhonesPlus_Characteristics.PhonesPlus_Src;
	pp_src_all                       := le.Phone_Shell.PhonesPlus_Characteristics.PhonesPlus_Src_All;
	pp_src_cnt                       := le.Phone_Shell.PhonesPlus_Characteristics.PhonesPlus_Src_Cnt;
	pp_src_rule                      := le.Phone_Shell.PhonesPlus_Characteristics.PhonesPlus_Src_Rule;
	pp_avg_source_conf               := le.Phone_Shell.PhonesPlus_Characteristics.PhonesPlus_Avg_Source_Conf;
	pp_max_source_conf               := le.Phone_Shell.PhonesPlus_Characteristics.PhonesPlus_Max_Source_Conf;
	pp_min_source_conf               := le.Phone_Shell.PhonesPlus_Characteristics.PhonesPlus_Min_Source_Conf;
	pp_total_source_conf             := le.Phone_Shell.PhonesPlus_Characteristics.PhonesPlus_Total_Source_Conf;
	pp_orig_lastseen                 := le.Phone_Shell.PhonesPlus_Characteristics.PhonesPlus_Orig_LastSeen;
	pp_did_type                      := le.Phone_Shell.PhonesPlus_Characteristics.PhonesPlus_DID_Type;
	pp_origname                      := le.Phone_Shell.PhonesPlus_Characteristics.PhonesPlus_OrigName;
	pp_address1                      := le.Phone_Shell.PhonesPlus_Characteristics.PhonesPlus_Address1;
	pp_address2                      := le.Phone_Shell.PhonesPlus_Characteristics.PhonesPlus_Address2;
	pp_address3                      := le.Phone_Shell.PhonesPlus_Characteristics.PhonesPlus_Address3;
	pp_origcity                      := le.Phone_Shell.PhonesPlus_Characteristics.PhonesPlus_OrigCity;
	pp_origstate                     := le.Phone_Shell.PhonesPlus_Characteristics.PhonesPlus_OrigState;
	pp_origzip                       := le.Phone_Shell.PhonesPlus_Characteristics.PhonesPlus_OrigZip;
	pp_origphone                     := le.Phone_Shell.PhonesPlus_Characteristics.PhonesPlus_OrigPhone;
	pp_dob                           := le.Phone_Shell.PhonesPlus_Characteristics.PhonesPlus_Dob;
	pp_agegroup                      := le.Phone_Shell.PhonesPlus_Characteristics.PhonesPlus_AgeGroup;
	pp_gender                        := le.Phone_Shell.PhonesPlus_Characteristics.PhonesPlus_Gender;
	pp_email                         := le.Phone_Shell.PhonesPlus_Characteristics.PhonesPlus_Email;
	pp_origlistingtype               := le.Phone_Shell.PhonesPlus_Characteristics.PhonesPlus_OrigListingType;
	pp_listingtype                   := le.Phone_Shell.PhonesPlus_Characteristics.PhonesPlus_ListingType;
	pp_origpublishcode               := le.Phone_Shell.PhonesPlus_Characteristics.PhonesPlus_OrigPublishCode;
	pp_origphonetype                 := le.Phone_Shell.PhonesPlus_Characteristics.PhonesPlus_OrigPhoneUsage;
	pp_origphoneusage                := le.Phone_Shell.PhonesPlus_Characteristics.PhonesPlus_OrigPhoneUsage;
	pp_company                       := le.Phone_Shell.PhonesPlus_Characteristics.PhonesPlus_Company;
	pp_origphoneregdate              := le.Phone_Shell.PhonesPlus_Characteristics.PhonesPlus_OrigPhoneRegDate;
	pp_origcarriercode               := le.Phone_Shell.PhonesPlus_Characteristics.PhonesPlus_OrigCarrierCode;
	pp_origcarriername               := le.Phone_Shell.PhonesPlus_Characteristics.PhonesPlus_OrigCarrierName;
	pp_origrectype                   := le.Phone_Shell.PhonesPlus_Characteristics.PhonesPlus_OrigRecType;
	pp_bdid                          := le.Phone_Shell.PhonesPlus_Characteristics.PhonesPlus_BDID;
	pp_bdid_score                    := le.Phone_Shell.PhonesPlus_Characteristics.PhonesPlus_BDID_Score;
	pp_app_npa_effective_dt          := le.Phone_Shell.PhonesPlus_Characteristics.PhonesPlus_Append_NPA_Effective_DT;
	pp_app_npa_last_change_dt        := le.Phone_Shell.PhonesPlus_Characteristics.PhonesPlus_Append_NPA_Last_Change_DT;
	pp_app_dialable_ind              := le.Phone_Shell.PhonesPlus_Characteristics.PhonesPlus_Append_Dialable_Ind;
	pp_app_place_name                := le.Phone_Shell.PhonesPlus_Characteristics.PhonesPlus_Append_Place_Name;
	pp_app_portability_indicator     := le.Phone_Shell.PhonesPlus_Characteristics.PhonesPlus_Append_Portability_Indicator;
	pp_app_prior_area_code           := le.Phone_Shell.PhonesPlus_Characteristics.PhonesPlus_Append_Prior_Area_Code;
	pp_app_nonpublished_match        := le.Phone_Shell.PhonesPlus_Characteristics.PhonesPlus_Append_NonPublished_Match;
	pp_app_ocn                       := le.Phone_Shell.PhonesPlus_Characteristics.PhonesPlus_Append_OCN;
	pp_app_time_zone                 := le.Phone_Shell.PhonesPlus_Characteristics.PhonesPlus_Append_Time_Zone;
	pp_app_nxx_type                  := le.Phone_Shell.PhonesPlus_Characteristics.PhonesPlus_Append_NXX_Type;
	pp_app_coctype                   := le.Phone_Shell.PhonesPlus_Characteristics.PhonesPlus_Append_COCType;
	pp_app_scc                       := le.Phone_Shell.PhonesPlus_Characteristics.PhonesPlus_Append_SCC;
	pp_app_ph_type                   := le.Phone_Shell.PhonesPlus_Characteristics.PhonesPlus_Append_Phone_Type;
	pp_app_company_type              := le.Phone_Shell.PhonesPlus_Characteristics.PhonesPlus_Append_Company_Type;
	pp_app_ph_use                    := le.Phone_Shell.PhonesPlus_Characteristics.PhonesPlus_Append_Phone_Use;
	pp_agreg_listing_type            := le.Phone_Shell.PhonesPlus_Characteristics.PhonesPlus_Agreg_Listing_Type;
	pp_max_orig_conf_score           := le.Phone_Shell.PhonesPlus_Characteristics.PhonesPlus_Max_Orig_Conf_Score;
	pp_min_orig_conf_score           := le.Phone_Shell.PhonesPlus_Characteristics.PhonesPlus_Min_Orig_Conf_Score;
	pp_curr_orig_conf_score          := le.Phone_Shell.PhonesPlus_Characteristics.PhonesPlus_Curr_Orig_Conf_Score;
	pp_eda_match                     := le.Phone_Shell.PhonesPlus_Characteristics.PhonesPlus_EDA_Match;
	pp_eda_ph_dt                     := le.Phone_Shell.PhonesPlus_Characteristics.PhonesPlus_EDA_Phone_Dt;
	pp_eda_did_dt                    := le.Phone_Shell.PhonesPlus_Characteristics.PhonesPlus_EDA_DID_Dt;
	pp_eda_nm_addr_dt                := le.Phone_Shell.PhonesPlus_Characteristics.PhonesPlus_EDA_NM_Addr_Dt;
	pp_eda_hist_match                := le.Phone_Shell.PhonesPlus_Characteristics.PhonesPlus_EDA_Hist_Match;
	pp_eda_hist_ph_dt                := le.Phone_Shell.PhonesPlus_Characteristics.PhonesPlus_EDA_Hist_Phone_Dt;
	pp_eda_hist_did_dt               := le.Phone_Shell.PhonesPlus_Characteristics.PhonesPlus_EDA_Hist_DID_Dt;
	pp_eda_hist_nm_addr_dt           := le.Phone_Shell.PhonesPlus_Characteristics.PhonesPlus_EDA_Hist_Nm_Addr_Dt;
	pp_app_fb_ph                     := le.Phone_Shell.PhonesPlus_Characteristics.PhonesPlus_Append_Feedback_Phone;
	pp_app_fb_ph_dt                  := le.Phone_Shell.PhonesPlus_Characteristics.PhonesPlus_Append_Feedback_Phone_Dt;;
	pp_app_fb_ph7_did_dt             := le.Phone_Shell.PhonesPlus_Characteristics.PhonesPlus_Append_Feedback_Phone7_DID_Dt;
	pp_app_fb_ph7_nm_addr_dt         := le.Phone_Shell.PhonesPlus_Characteristics.PhonesPlus_Append_Feedback_Phone7_NM_Addr_Dt;
	pp_app_ported_match              := le.Phone_Shell.PhonesPlus_Characteristics.PhonesPlus_Append_Ported_Match;
	pp_app_seen_once_ind             := (integer)le.Phone_Shell.PhonesPlus_Characteristics.PhonesPlus_Append_Seen_Once_Ind;
	pp_app_ind_ph_cnt                := le.Phone_Shell.PhonesPlus_Characteristics.PhonesPlus_Append_Indiv_Phone_Cnt;
	pp_app_ind_has_actv_eda_ph_fl    := (integer)le.Phone_Shell.PhonesPlus_Characteristics.PhonesPlus_Append_Indiv_Has_Active_EDA_Phone_Flag;
	pp_app_latest_ph_owner_fl        := (integer)le.Phone_Shell.PhonesPlus_Characteristics.PhonesPlus_Append_Latest_Phone_Owner_Flag;
	pp_hhid                          := le.Phone_Shell.PhonesPlus_Characteristics.PhonesPlus_HHID;
	pp_hhid_score                    := le.Phone_Shell.PhonesPlus_Characteristics.PhonesPlus_HHID_Score;
	pp_app_best_addr_match_fl        := (integer)le.Phone_Shell.PhonesPlus_Characteristics.PhonesPlus_Append_Best_Addr_Match_Flag;
	pp_app_best_nm_match_fl          := (integer)le.Phone_Shell.PhonesPlus_Characteristics.PhonesPlus_Append_Best_NM_Match_Flag;
	pp_rawaid                        := le.Phone_Shell.PhonesPlus_Characteristics.PhonesPlus_RawAID;
	pp_cleanaid                      := le.Phone_Shell.PhonesPlus_Characteristics.PhonesPlus_CleanAID;
	pp_current_rec                   := (integer)le.Phone_Shell.PhonesPlus_Characteristics.PhonesPlus_Current_Rec;
	pp_first_build_date              := le.Phone_Shell.PhonesPlus_Characteristics.PhonesPlus_First_Build_Date;
	pp_last_build_date               := le.Phone_Shell.PhonesPlus_Characteristics.PhonesPlus_Last_Build_Date;
	phone_fb_result                  := le.Phone_Shell.Phone_Feedback.Phone_Feedback_Result;
	phone_fb_last_rpc_date           := le.Phone_Shell.Phone_Feedback.Phone_Feedback_Last_RPC_Date;
	phone_fb_rp_date                 := le.Phone_Shell.Phone_Feedback.Phone_Feedback_RP_Date;
	phone_fb_rp_result               := le.Phone_Shell.Phone_Feedback.Phone_Feedback_RP_Result;
	inq_firstseen                    := le.Phone_Shell.Inquiries.Inq_FirstSeen;
	inq_lastseen                     := le.Phone_Shell.Inquiries.Inq_LastSeen;
	inq_adl_firstseen                := le.Phone_Shell.Inquiries.Inq_ADL_FirstSeen;
	inq_adl_lastseen                 := le.Phone_Shell.Inquiries.Inq_ADL_LastSeen;
	inq_adl_ph_industry_list_12      := le.Phone_Shell.Inquiries.Inq_ADL_Phone_Industry_List_12;
	internal_ver_match_types         := le.Phone_Shell.Internal_Corroboration.Internal_Verification_Match_Types;
	exp_verified                     := (integer)le.Phone_Shell.Experian_File_One_Verification.Experian_Verified;
	exp_type                         := le.Phone_Shell.Experian_File_One_Verification.Experian_Type;
	exp_source                       := le.Phone_Shell.Experian_File_One_Verification.Experian_Source;
	exp_last_update                  := le.Phone_Shell.Experian_File_One_Verification.Experian_Last_Update;
	exp_ph_score_v1                  := le.Phone_Shell.Experian_File_One_Verification.Experian_Phone_Score_V1;
	eda_omit_locality                := le.Phone_Shell.EDA_Characteristics.EDA_Omit_Locality;
	eda_did                          := le.Phone_Shell.EDA_Characteristics.EDA_DID;
	eda_hhid                         := le.Phone_Shell.EDA_Characteristics.EDA_HHID;
	eda_bdid                         := le.Phone_Shell.EDA_Characteristics.EDA_BDID;
	eda_listing_name                 := le.Phone_Shell.EDA_Characteristics.EDA_Listing_Name;
	eda_did_count                    := le.Phone_Shell.EDA_Characteristics.EDA_DID_Count;
	eda_dt_first_seen                := le.Phone_Shell.EDA_Characteristics.EDA_Dt_First_Seen;
	eda_dt_last_seen                 := le.Phone_Shell.EDA_Characteristics.EDA_Dt_Last_Seen;
	eda_current_record_fl            := (integer)le.Phone_Shell.EDA_Characteristics.EDA_Current_Record_Flag;
	eda_deletion_date                := le.Phone_Shell.EDA_Characteristics.EDA_Deletion_Date;
	eda_disc_cnt6                    := le.Phone_Shell.EDA_Characteristics.EDA_Disc_Cnt6;  
	eda_disc_cnt12                   := le.Phone_Shell.EDA_Characteristics.EDA_Disc_Cnt12; 
	eda_disc_cnt18                   := le.Phone_Shell.EDA_Characteristics.EDA_Disc_Cnt18; 
	eda_pfrd_address_ind             := le.Phone_Shell.EDA_Characteristics.EDA_Pfrd_Address_Ind;        
	eda_days_in_service              := le.Phone_Shell.EDA_Characteristics.EDA_Days_In_Service;        
	eda_num_ph_owners_hist           := le.Phone_Shell.EDA_Characteristics.EDA_Num_Phone_Owners_Hist;   
	eda_num_ph_owners_cur            := le.Phone_Shell.EDA_Characteristics.EDA_Num_Phone_Owners_Cur;    
	eda_num_phs_ind                  := le.Phone_Shell.EDA_Characteristics.EDA_Num_Phones_Indiv;        
	eda_num_phs_connected_ind        := le.Phone_Shell.EDA_Characteristics.EDA_Num_Phones_Connected_Indiv;  
	eda_num_phs_discon_ind           := le.Phone_Shell.EDA_Characteristics.EDA_Num_Phones_Discon_Indiv;     
	eda_avg_days_connected_ind       := le.Phone_Shell.EDA_Characteristics.EDA_Avg_Days_Connected_Indiv;    
	eda_min_days_connected_ind       := le.Phone_Shell.EDA_Characteristics.EDA_Min_Days_Connected_Indiv;    
	eda_max_days_connected_ind       := le.Phone_Shell.EDA_Characteristics.EDA_Max_Days_Connected_Indiv;    
	eda_days_ind_first_seen          := le.Phone_Shell.EDA_Characteristics.EDA_Days_Indiv_First_Seen;                  
	eda_days_ind_first_seen_w_ph     := le.Phone_Shell.EDA_Characteristics.EDA_Days_Indiv_First_Seen_With_Phone;       
	eda_days_ph_first_seen           := le.Phone_Shell.EDA_Characteristics.EDA_Days_Phone_First_Seen;                  
	eda_address_match_best           := (integer) le.Phone_Shell.EDA_Characteristics.EDA_Address_Match_Best;                     
	eda_months_addr_last_seen        := le.Phone_Shell.EDA_Characteristics.EDA_Months_Addr_Last_Seen;                  
	eda_num_phs_connected_addr       := le.Phone_Shell.EDA_Characteristics.EDA_Num_Phones_Connected_Addr;              
	eda_num_phs_discon_addr          := le.Phone_Shell.EDA_Characteristics.EDA_Num_Phones_Discon_Addr;
	eda_num_phs_connected_hhid       := le.Phone_Shell.EDA_Characteristics.EDA_Num_Phones_Connected_HHID;
	eda_num_phs_discon_hhid          := le.Phone_Shell.EDA_Characteristics.EDA_Num_Phones_Discon_HHID;
	eda_is_discon_15_days            := (integer)le.Phone_Shell.EDA_Characteristics.EDA_Is_Discon_15_Days;  
	eda_is_discon_30_days            := (integer)le.Phone_Shell.EDA_Characteristics.EDA_Is_Discon_30_Days;  
	eda_is_discon_60_days            := (integer)le.Phone_Shell.EDA_Characteristics.EDA_Is_Discon_60_Days;  
	eda_is_discon_90_days            := (integer)le.Phone_Shell.EDA_Characteristics.EDA_Is_Discon_90_Days;  
	eda_is_discon_180_days           := (integer)le.Phone_Shell.EDA_Characteristics.EDA_Is_Discon_180_Days; 
	eda_is_discon_360_days           := (integer)le.Phone_Shell.EDA_Characteristics.EDA_Is_Discon_360_Days; 
	eda_is_current_in_hist           := (integer)le.Phone_Shell.EDA_Characteristics.EDA_Is_Current_In_Hist; 
	eda_num_interrupts_cur           := le.Phone_Shell.EDA_Characteristics.EDA_Num_Interrupts_Cur; 
	eda_avg_days_interrupt           := le.Phone_Shell.EDA_Characteristics.EDA_Avg_Days_Interrupt; 
	eda_min_days_interrupt           := le.Phone_Shell.EDA_Characteristics.EDA_Min_Days_Interrupt; 
	eda_max_days_interrupt           := le.Phone_Shell.EDA_Characteristics.EDA_Max_Days_Interrupt; 
	eda_has_cur_discon_15_days       := (integer)le.Phone_Shell.EDA_Characteristics.EDA_Has_Cur_Discon_15_Days;  
	eda_has_cur_discon_30_days       := (integer)le.Phone_Shell.EDA_Characteristics.EDA_Has_Cur_Discon_30_Days;  
	eda_has_cur_discon_60_days       := (integer)le.Phone_Shell.EDA_Characteristics.EDA_Has_Cur_Discon_60_Days;  
	eda_has_cur_discon_90_days       := (integer)le.Phone_Shell.EDA_Characteristics.EDA_Has_Cur_Discon_90_Days;  
	eda_has_cur_discon_180_days      := (integer) le.Phone_Shell.EDA_Characteristics.EDA_Has_Cur_Discon_180_Days;
	eda_has_cur_discon_360_days      := (integer) le.Phone_Shell.EDA_Characteristics.EDA_Has_Cur_Discon_360_Days;

//End: ECL SAS mapping variables 
NULL := -999999999;

INTEGER contains_i( string haystack, string needle ) := (INTEGER)(StringLib.StringFind(haystack, needle, 1) > 0);

archive_date_1 := trim(trim(in_processing_date, LEFT), LEFT, RIGHT);

sysdate := map(
    trim(archive_date_1, LEFT, RIGHT) = '999999'  => Models.common.sas_date('20131217'),//(string)ut.getdate
    length(trim(archive_date_1, LEFT, RIGHT)) = 6 => (ut.DaysSince1900((trim(archive_date_1, LEFT))[1..4], (trim(archive_date_1, LEFT))[5..6], (string)1) - ut.DaysSince1900('1960', '1', '1')),
    length(trim(archive_date_1, LEFT, RIGHT)) = 8 => (ut.DaysSince1900((trim(archive_date_1, LEFT))[1..4], (trim(archive_date_1, LEFT))[5..6], (trim(archive_date_1, LEFT))[7..8]) - ut.DaysSince1900('1960', '1', '1')),
    NULL);

source_cr := if(Models.Common.findw_cpp(source_list, 'CR' , ', ', 'E') > 0, 1, 0);

source_edaca := if(Models.Common.findw_cpp(source_list, 'EDACA' , ', ', 'E') > 0, 1, 0);

source_edaca_lseen := if(Models.Common.findw_cpp(source_list, 'EDACA' , ', ', 'E') > 0, 
				Models.Common.getw(source_list_last_seen, 
				Models.Common.findw_cpp(source_list, 'EDACA' , ', ', 'E')), '');

source_edadid := if(Models.Common.findw_cpp(source_list, 'EDADID' , ', ', 'E') > 0, 1, 0);

source_edafa := if(Models.Common.findw_cpp(source_list, 'EDAFA' , ', ', 'E') > 0, 1, 0);

source_edafla := if(Models.Common.findw_cpp(source_list, 'EDAFLA' , ', ', 'E') > 0, 1, 0);

source_edahistory_lseen := if(Models.Common.findw_cpp(source_list, 'EDAHistory' , ', ', 'E') > 0, Models.Common.getw(source_list_last_seen, Models.Common.findw_cpp(source_list, 'EDAHistory' , ', ', 'E')), '');

source_edahistory := if(Models.Common.findw_cpp(source_list, 'EDAHistory' , ', ', 'E') > 0, 1, 0);

source_edala := if(Models.Common.findw_cpp(source_list, 'EDALA' , ', ', 'E') > 0, 1, 0);

source_edalfa := if(Models.Common.findw_cpp(source_list, 'EDALFA' , ', ', 'E') > 0, 1, 0);

source_exp := if(Models.Common.findw_cpp(source_list, 'EXP' , ', ', 'E') > 0, 1, 0);

source_exp_fseen := if(Models.Common.findw_cpp(source_list, 'EXP' , ', ', 'E') > 0, Models.Common.getw(source_list_first_seen, Models.Common.findw_cpp(source_list, 'EXP' , ', ', 'E')), '');

source_md := if(Models.Common.findw_cpp(source_list, 'MD' , ', ', 'E') > 0, 1, 0);

source_paw := if(Models.Common.findw_cpp(source_list, 'PAW' , ', ', 'E') > 0, 1, 0);

source_paw_lseen := if(Models.Common.findw_cpp(source_list, 'PAW' , ', ', 'E') > 0, Models.Common.getw(source_list_last_seen, Models.Common.findw_cpp(source_list, 'PAW' , ', ', 'E')), '');

source_pf := if(Models.Common.findw_cpp(source_list, 'PF' , ', ', 'E') > 0, 1, 0);

source_ppca := if(Models.Common.findw_cpp(source_list, 'PPCA' , ', ', 'E') > 0, 1, 0);

source_ppca_lseen := if(Models.Common.findw_cpp(source_list, 'PPCA' , ', ', 'E') > 0, Models.Common.getw(source_list_last_seen, Models.Common.findw_cpp(source_list, 'PPCA' , ', ', 'E')), '');

source_ppca_fseen := if(Models.Common.findw_cpp(source_list, 'PPCA' , ', ', 'E') > 0, Models.Common.getw(source_list_first_seen, Models.Common.findw_cpp(source_list, 'PPCA' , ', ', 'E')), '');

source_ppdid := if(Models.Common.findw_cpp(source_list, 'PPDID' , ', ', 'E') > 0, 1, 0);

source_ppdid_lseen := if(Models.Common.findw_cpp(source_list, 'PPDID' , ', ', 'E') > 0, Models.Common.getw(source_list_last_seen, Models.Common.findw_cpp(source_list, 'PPDID' , ', ', 'E')), '');

source_ppfa := if(Models.Common.findw_cpp(source_list, 'PPFA' , ', ', 'E') > 0, 1, 0);

source_ppfla := if(Models.Common.findw_cpp(source_list, 'PPFLA' , ', ', 'E') > 0, 1, 0);

source_ppla := if(Models.Common.findw_cpp(source_list, 'PPLA' , ', ', 'E') > 0, 1, 0);

source_pplfa := if(Models.Common.findw_cpp(source_list, 'PPLFA' , ', ', 'E') > 0, 1, 0);

source_ppth_fseen := if(Models.Common.findw_cpp(source_list, 'PPTH' , ', ', 'E') > 0, Models.Common.getw(source_list_first_seen, Models.Common.findw_cpp(source_list, 'PPTH' , ', ', 'E')), '');

source_rel := if(Models.Common.findw_cpp(source_list, 'REL' , ', ', 'E') > 0, 1, 0);

source_sp := if(Models.Common.findw_cpp(source_list, 'SP' , ', ', 'E') > 0, 1, 0);

source_sx := if(Models.Common.findw_cpp(source_list, 'SX' , ', ', 'E') > 0, 1, 0);

source_utildid_fseen := if(Models.Common.findw_cpp(source_list, 'UtilDID' , ', ', 'E') > 0, Models.Common.getw(source_list_first_seen, Models.Common.findw_cpp(source_list, 'UtilDID' , ', ', 'E')), '');

source_utildid := if(Models.Common.findw_cpp(source_list, 'UtilDID' , ', ', 'E') > 0, 1, 0);

source_eda_any_clean := max(source_edaca, source_edadid, source_edafa, source_edafla, source_edala, source_edalfa);

source_pp_any_clean := max(source_ppca, source_ppdid, source_ppfa, source_ppfla, source_ppla, source_pplfa);

source_edaca_lseen2 := if((string)source_edaca_lseen = '', 0, Models.common.sas_date((string)(source_edaca_lseen)));

yr_source_edaca_lseen := if(source_edaca_lseen2 = 0, 0, if(min(sysdate, source_edaca_lseen2) = NULL, NULL, roundup((sysdate - source_edaca_lseen2) / 365.25)));

mth_source_edaca_lseen_1 := if(source_edaca_lseen2 = 0, -999,if(min(sysdate, source_edaca_lseen2) = NULL, NULL, roundup((sysdate - source_edaca_lseen2) / 30.5)));

source_edahistory_lseen2 := Models.common.sas_date((string)(source_edahistory_lseen));

yr_source_edahistory_lseen := if(min(sysdate, source_edahistory_lseen2) = NULL, NULL, roundup((sysdate - source_edahistory_lseen2) / 365.25));

mth_source_edahistory_lseen_1 := if(min(sysdate, source_edahistory_lseen2) = NULL, NULL, roundup((sysdate - source_edahistory_lseen2) / 30.5));

source_exp_fseen2 := Models.common.sas_date((string)(source_exp_fseen));

yr_source_exp_fseen := if(min(sysdate, source_exp_fseen2) = NULL, NULL, roundup((sysdate - source_exp_fseen2) / 365.25));

mth_source_exp_fseen_1 := if(min(sysdate, source_exp_fseen2) = NULL, NULL, roundup((sysdate - source_exp_fseen2) / 30.5));

source_paw_lseen2 := Models.common.sas_date((string)(source_paw_lseen));

yr_source_paw_lseen := if(min(sysdate, source_paw_lseen2) = NULL, NULL, roundup((sysdate - source_paw_lseen2) / 365.25));

mth_source_paw_lseen_1 := if(min(sysdate, source_paw_lseen2) = NULL, NULL, roundup((sysdate - source_paw_lseen2) / 30.5));

source_ppca_lseen2 := Models.common.sas_date((string)(source_ppca_lseen));

yr_source_ppca_lseen := if(min(sysdate, source_ppca_lseen2) = NULL, NULL, roundup((sysdate - source_ppca_lseen2) / 365.25));

mth_source_ppca_lseen_1 := if(min(sysdate, source_ppca_lseen2) = NULL, NULL, roundup((sysdate - source_ppca_lseen2) / 30.5));

source_ppca_fseen2 := Models.common.sas_date((string)(source_ppca_fseen));

yr_source_ppca_fseen := if(min(sysdate, source_ppca_fseen2) = NULL, NULL, roundup((sysdate - source_ppca_fseen2) / 365.25));

mth_source_ppca_fseen_1 := if(min(sysdate, source_ppca_fseen2) = NULL, NULL, roundup((sysdate - source_ppca_fseen2) / 30.5));

source_ppdid_lseen2 := Models.common.sas_date((string)(source_ppdid_lseen));

yr_source_ppdid_lseen := if(min(sysdate, source_ppdid_lseen2) = NULL, NULL, roundup((sysdate - source_ppdid_lseen2) / 365.25));

mth_source_ppdid_lseen_1 := if(min(sysdate, source_ppdid_lseen2) = NULL, NULL, roundup((sysdate - source_ppdid_lseen2) / 30.5));

source_ppth_fseen2 := Models.common.sas_date((string)(source_ppth_fseen));

yr_source_ppth_fseen := if(min(sysdate, source_ppth_fseen2) = NULL, NULL, roundup((sysdate - source_ppth_fseen2) / 365.25));

mth_source_ppth_fseen_1 := if(min(sysdate, source_ppth_fseen2) = NULL, NULL, roundup((sysdate - source_ppth_fseen2) / 30.5));

source_utildid_fseen2 := Models.common.sas_date((string)(source_utildid_fseen));

yr_source_utildid_fseen := if(min(sysdate, source_utildid_fseen2) = NULL, NULL, roundup((sysdate - source_utildid_fseen2) / 365.25));

mth_source_utildid_fseen_1 := if(min(sysdate, source_utildid_fseen2) = NULL, NULL, roundup((sysdate - source_utildid_fseen2) / 30.5));

eda_dt_first_seen2 := Models.common.sas_date((string)(eda_dt_first_seen));

yr_eda_dt_first_seen := if(min(sysdate, eda_dt_first_seen2) = NULL, NULL,
											roundup((sysdate - eda_dt_first_seen2) / 365.25));

mth_eda_dt_first_seen_1 := if(min(sysdate, eda_dt_first_seen2) = NULL, NULL, roundup((sysdate - eda_dt_first_seen2) / 30.5));

eda_dt_last_seen2 := Models.common.sas_date((string)(eda_dt_last_seen));

yr_eda_dt_last_seen := if(min(sysdate, eda_dt_last_seen2) = NULL, NULL, roundup((sysdate - eda_dt_last_seen2) / 365.25));

mth_eda_dt_last_seen_1 := if(min(sysdate, eda_dt_last_seen2) = NULL, NULL, roundup((sysdate - eda_dt_last_seen2) / 30.5));

eda_deletion_date2 := Models.common.sas_date((string)(eda_deletion_date));

yr_eda_deletion_date := if(min(sysdate, eda_deletion_date2) = NULL, NULL, roundup((sysdate - eda_deletion_date2) / 365.25));

mth_eda_deletion_date_1 := if(min(sysdate, eda_deletion_date2) = NULL, NULL, roundup((sysdate - eda_deletion_date2) / 30.5));

exp_last_update2 := Models.common.sas_date((string)(exp_last_update));

yr_exp_last_update := if(min(sysdate, exp_last_update2) = NULL, NULL, roundup((sysdate - exp_last_update2) / 365.25));

mth_exp_last_update_1 := if(min(sysdate, exp_last_update2) = NULL, NULL, roundup((sysdate - exp_last_update2) / 30.5));

phone_fb_last_rpc_date2 := Models.common.sas_date((string)(phone_fb_last_rpc_date));

yr_phone_fb_last_rpc_date := if(min(sysdate, phone_fb_last_rpc_date2) = NULL, NULL, roundup((sysdate - phone_fb_last_rpc_date2) / 365.25));

mth_phone_fb_last_rpc_date_1 := if(min(sysdate, phone_fb_last_rpc_date2) = NULL, NULL, roundup((sysdate - phone_fb_last_rpc_date2) / 30.5));

phone_fb_rp_date2 := Models.common.sas_date((string)(phone_fb_rp_date));

yr_phone_fb_rp_date := if(min(sysdate, phone_fb_rp_date2) = NULL, NULL, roundup((sysdate - phone_fb_rp_date2) / 365.25));

mth_phone_fb_rp_date_1 := if(min(sysdate, phone_fb_rp_date2) = NULL, NULL, roundup((sysdate - phone_fb_rp_date2) / 30.5));

pp_datelastseen2 := Models.common.sas_date((string)(pp_datelastseen));

yr_pp_datelastseen := if(min(sysdate, pp_datelastseen2) = NULL, NULL, roundup((sysdate - pp_datelastseen2) / 365.25));

mth_pp_datelastseen_1 := if(min(sysdate, pp_datelastseen2) = NULL, NULL, roundup((sysdate - pp_datelastseen2) / 30.5));

pp_origphoneregdate2 := Models.common.sas_date((string)(pp_origphoneregdate));

yr_pp_origphoneregdate := if(min(sysdate, pp_origphoneregdate2) = NULL, NULL, roundup((sysdate - pp_origphoneregdate2) / 365.25));

mth_pp_origphoneregdate_1 := if(min(sysdate, pp_origphoneregdate2) = NULL, NULL, roundup((sysdate - pp_origphoneregdate2) / 30.5));

pp_eda_hist_ph_dt2 := Models.common.sas_date((string)(PP_EDA_Hist_ph_dt));

yr_pp_eda_hist_ph_dt := if(min(sysdate, pp_eda_hist_ph_dt2) = NULL, NULL, roundup((sysdate - pp_eda_hist_ph_dt2) / 365.25));

mth_pp_eda_hist_ph_dt_1 := if(min(sysdate, pp_eda_hist_ph_dt2) = NULL, NULL, roundup((sysdate - pp_eda_hist_ph_dt2) / 30.5));

pp_app_fb_ph_dt2 := Models.common.sas_date((string)(pp_app_fb_ph_dt));

yr_pp_app_fb_ph_dt := if(min(sysdate, pp_app_fb_ph_dt2) = NULL, NULL, roundup((sysdate - pp_app_fb_ph_dt2) / 365.25));

mth_pp_app_fb_ph_dt_1 := if(min(sysdate, pp_app_fb_ph_dt2) = NULL, NULL, roundup((sysdate - pp_app_fb_ph_dt2) / 30.5));

pp_first_build_date2 := Models.common.sas_date((string)(pp_first_build_date));

yr_pp_first_build_date := if(min(sysdate, pp_first_build_date2) = NULL, NULL, roundup((sysdate - pp_first_build_date2) / 365.25));

mth_pp_first_build_date_1 := if(min(sysdate, pp_first_build_date2) = NULL, NULL, roundup((sysdate - pp_first_build_date2) / 30.5));

mth_source_edaca_lseen := if(mth_source_edaca_lseen_1 = NULL, -999, mth_source_edaca_lseen_1);

mth_source_edahistory_lseen := if(mth_source_edahistory_lseen_1 = NULL, -999, mth_source_edahistory_lseen_1);

mth_source_exp_fseen := if(mth_source_exp_fseen_1 = NULL, -999, mth_source_exp_fseen_1);

mth_source_paw_lseen := if(mth_source_paw_lseen_1 = NULL, -999, mth_source_paw_lseen_1);

mth_source_ppca_lseen := if(mth_source_ppca_lseen_1 = NULL, -999, mth_source_ppca_lseen_1);

mth_source_ppca_fseen := if(mth_source_ppca_fseen_1 = NULL, -999, mth_source_ppca_fseen_1);

mth_source_ppdid_lseen := if(mth_source_ppdid_lseen_1 = NULL, -999, mth_source_ppdid_lseen_1);

mth_source_ppth_fseen := if(mth_source_ppth_fseen_1 = NULL, -999, mth_source_ppth_fseen_1);

mth_source_utildid_fseen := if(mth_source_utildid_fseen_1 = NULL, -999, mth_source_utildid_fseen_1);

mth_eda_dt_first_seen := if(mth_eda_dt_first_seen_1 = NULL, -999, mth_eda_dt_first_seen_1);

mth_eda_dt_last_seen := if(mth_eda_dt_last_seen_1 = NULL, -999, mth_eda_dt_last_seen_1);

mth_eda_deletion_date := if(mth_eda_deletion_date_1 = NULL, -999, mth_eda_deletion_date_1);

mth_exp_last_update := if(mth_exp_last_update_1 = NULL, -999, mth_exp_last_update_1);

mth_phone_fb_last_rpc_date := if(mth_phone_fb_last_rpc_date_1 = NULL, -999, mth_phone_fb_last_rpc_date_1);

mth_phone_fb_rp_date := if(mth_phone_fb_rp_date_1 = NULL, -999, mth_phone_fb_rp_date_1);

mth_pp_datelastseen := if(mth_pp_datelastseen_1 = NULL, -999, mth_pp_datelastseen_1);

mth_pp_origphoneregdate := if(mth_pp_origphoneregdate_1 = NULL, -999, mth_pp_origphoneregdate_1);

mth_pp_eda_hist_ph_dt := if(mth_pp_eda_hist_ph_dt_1 = NULL, -999, mth_pp_eda_hist_ph_dt_1);

mth_pp_first_build_date := if(mth_pp_first_build_date_1 = NULL, -999, mth_pp_first_build_date_1);

_phone_match_code_a := contains_i(phone_match_code, 'A') ;

_phone_match_code_c := contains_i(phone_match_code, 'C');

_phone_match_code_l := contains_i(phone_match_code, 'L') ;

_phone_match_code_n := contains_i(phone_match_code, 'N') ;

_phone_match_code_s := contains_i(phone_match_code, 'S') ;

_phone_match_code_t :=  contains_i(phone_match_code, 'T') ;

_phone_match_code_z :=  contains_i(phone_match_code, 'Z') ;

_pp_rule_disconnected_eda_1 := 0;

_pp_rule_non_pub_1 := 0;

_pp_rule_port_neustar_1 := 0;

_pp_rule_high_vend_conf_1 := 0;

_pp_rule_low_vend_conf_1 := 0;

_pp_rule_cellphone_latest_1 := 0;

_pp_rule_source_latest_1 := 0;

_pp_rule_med_vend_conf_cell_1 := 0;

_pp_rule_consort_rpc_1 := 0;

_pp_rule_iq_rpc_1 := 0;

_pp_rule_ins_ver_above_1 := 0;

_pp_rule_f1_ver_above_1 := 0;

_pp_rule_f1_ver_below_1 := 0;

_pp_rule_disconnected_eda := if((PP_Rules)[3..3] = '1', 1, _pp_rule_disconnected_eda_1);

_pp_rule_non_pub := if((PP_Rules)[4..4] = '1', 1, _pp_rule_non_pub_1);

_pp_rule_port_neustar := if((PP_Rules)[5..5] = '1', 1, _pp_rule_port_neustar_1);

_pp_rule_high_vend_conf := if((PP_Rules)[7..7] = '1', 1, _pp_rule_high_vend_conf_1);

_pp_rule_low_vend_conf := if((PP_Rules)[8..8] = '1', 1, _pp_rule_low_vend_conf_1);

_pp_rule_cellphone_latest := if((PP_Rules)[9..9] = '1', 1, _pp_rule_cellphone_latest_1);

_pp_rule_source_latest := if((PP_Rules)[14..14] = '1', 1, _pp_rule_source_latest_1);

_pp_rule_med_vend_conf_cell := if((PP_Rules)[15..15] = '1', 1, _pp_rule_med_vend_conf_cell_1);

_pp_rule_consort_rpc := if((PP_Rules)[23..23] = '1', 1, _pp_rule_consort_rpc_1);

_pp_rule_iq_rpc := if((PP_Rules)[25..25] = '1', 1, _pp_rule_iq_rpc_1);

_pp_rule_ins_ver_above := if((PP_Rules)[26..26] = '1', 1, _pp_rule_ins_ver_above_1);

_pp_rule_f1_ver_above := if((PP_Rules)[28..28] = '1', 1, _pp_rule_f1_ver_above_1);

_pp_rule_f1_ver_below := if((PP_Rules)[29..29] = '1'
, 1, _pp_rule_f1_ver_below_1);

_pp_did_flag := if(pp_did > 0, 1, 0);

_pp_src_all_ir_1 := 0;

_pp_src_all_01_1 := 0;

_pp_src_all_02_1 := 0;

_pp_src_all_05_1 := 0;

_pp_src_all_wp_1 := 0;

_pp_src_all_pn_1 := 0;

_pp_src_all_go_1 := 0;

_pp_src_all_eq_1 := 0;

_pp_src_all_ut_1 := 0;

_pp_src_all_uw_1 := 0;

_pp_src_all_cy_1 := 0;

_pp_src_all_eb_1 := 0;

_pp_src_all_en_1 := 0;

_pp_src_all_iq_1 := 0;

_pp_src_all_ib_1 := 0;

_pp_src_all_ir := if((PP_Src_All)[1..1] = '1', 1, _pp_src_all_ir_1);

_pp_src_all_01 := if((PP_Src_All)[2..2] = '1', 1, _pp_src_all_01_1);

_pp_src_all_02 := if((PP_Src_All)[3..3] = '1', 1, _pp_src_all_02_1);

_pp_src_all_05 := if((PP_Src_All)[4..4] = '1', 1, _pp_src_all_05_1);

_pp_src_all_wp := if((PP_Src_All)[6..6] = '1', 1, _pp_src_all_wp_1);

_pp_src_all_pn := if((PP_Src_All)[7..7] = '1', 1, _pp_src_all_pn_1);

_pp_src_all_go := if((PP_Src_All)[8..8] = '1', 1, _pp_src_all_go_1);

_pp_src_all_eq := if((PP_Src_All)[10..10] = '1', 1, _pp_src_all_eq_1);

_pp_src_all_ut := if((PP_Src_All)[11..11] = '1', 1, _pp_src_all_ut_1);

_pp_src_all_uw := if((PP_Src_All)[14..14] = '1', 1, _pp_src_all_uw_1);

_pp_src_all_cy := if((PP_Src_All)[17..17] = '1', 1, _pp_src_all_cy_1);

_pp_src_all_eb := if((PP_Src_All)[23..23] = '1', 1, _pp_src_all_eb_1);

_pp_src_all_en := if((PP_Src_All)[36..36] = '1', 1, _pp_src_all_en_1);

_pp_src_all_iq := if((PP_Src_All)[42..42] = '1', 1, _pp_src_all_iq_1);

_pp_src_all_ib := if((PP_Src_All)[44..44] = '1', 1, _pp_src_all_ib_1);

_pp_bdid_flag := if(pp_bdid > 0, 1, 0);

_pp_app_nonpub_gong_la_1 := 0;

_pp_app_nonpub_gong_la := if((PP_app_NonPublished_Match)[1..1] = '1', 1, _pp_app_nonpub_gong_la_1);

_pp_eda_hist_match_did_1 := 0;

_pp_eda_hist_match_lap_1 := 0;

_pp_eda_hist_match_did := if((PP_EDA_Hist_Match)[3..3] = '1', 1, _pp_eda_hist_match_did_1);

_pp_eda_hist_match_lap := if((PP_EDA_Hist_Match)[4..4] = '1', 1, _pp_eda_hist_match_lap_1);

_pp_app_ported_match_10_1 := 0;

_pp_app_ported_match_10 := if((PP_app_Ported_Match)[1..1] = '1', 1, _pp_app_ported_match_10_1);

_eda_did_flag := if(eda_did > 0, 1, 0);

inq_firstseen_n := if(trim(trim(inq_firstseen, LEFT), LEFT, RIGHT) = '', -999, (real)inq_firstseen);

inq_lastseen_n := if(trim(trim(inq_lastseen, LEFT), LEFT, RIGHT) = '', -999, (real)inq_lastseen);

inq_adl_firstseen_n := if(trim(trim(inq_adl_firstseen, LEFT), LEFT, RIGHT) = '', -999, (real)inq_adl_firstseen);

inq_adl_lastseen_n := if(trim(trim(inq_adl_lastseen, LEFT), LEFT, RIGHT) = '', -999, (real)inq_adl_lastseen);

_internal_ver_match_lexid := if(trim(internal_ver_match_types, left, right) = '', 0, if(Models.Common.findw_cpp(internal_ver_match_types, '1' , ', ', 'E') > 0, 1 , 0));

tmp_inq_adl_ph_industry_list_12 := stringlib.StringFindReplace(inq_adl_ph_industry_list_12, '/', ' ');

_inq_adl_ph_industry_auto := if(Models.Common.findw_cpp(tmp_inq_adl_ph_industry_list_12, 'AUTO' , ', ', 'E') > 0, 1, 0);

_inq_adl_ph_industry_cards := if(Models.Common.findw_cpp(tmp_inq_adl_ph_industry_list_12, 'CARDS' , ', ', 'E') > 0, 1, 0);

_inq_adl_ph_industry_coll := if(Models.Common.findw_cpp(tmp_inq_adl_ph_industry_list_12, 'COLLECTIONS' , ', ', 'E') > 0, 1, 0);

_inq_adl_ph_industry_comm := if(Models.Common.findw_cpp(tmp_inq_adl_ph_industry_list_12, 'COMMUNICATIONS' , ', ', 'E') > 0, 1, 0);

_inq_adl_ph_industry_firm := if(Models.Common.findw_cpp(tmp_inq_adl_ph_industry_list_12, 'FIRM' , ', ', 'E') > 0, 1, 0);

_inq_adl_ph_industry_invest := if(Models.Common.findw_cpp(tmp_inq_adl_ph_industry_list_12, 'INVESTMENTS' , ', ', 'E') > 0, 1, 0);

_inq_adl_ph_industry_util := if(Models.Common.findw_cpp(tmp_inq_adl_ph_industry_list_12, 'UTILITIES' , ', ', 'E') > 0, 1, 0);

_mth_source_edaca_lseen := map(
    mth_source_edaca_lseen < 1  => 0,
    mth_source_edaca_lseen < 13 => 1,
    mth_source_edaca_lseen < 52 => 2,
    mth_source_edaca_lseen < 68 => 3,
                                   4);

_mth_source_edahistory_lseen := map(
    mth_source_edahistory_lseen < 1  => 0,
    mth_source_edahistory_lseen < 7  => 1,
    mth_source_edahistory_lseen < 51 => 2,
                                        3);

_mth_source_exp_fseen := map(
    mth_source_exp_fseen < 1  => 0,
    mth_source_exp_fseen < 8  => 1,
    mth_source_exp_fseen < 27 => 2,
                                 3);

_mth_source_paw_lseen := map(
    mth_source_paw_lseen < 0   => 0,
    mth_source_paw_lseen < 117 => 1,
                                  2);

_mth_source_ppca_lseen := map(
    mth_source_ppca_lseen < 0  => 0,
    mth_source_ppca_lseen < 7  => 1,
    mth_source_ppca_lseen < 14 => 2,
    mth_source_ppca_lseen < 26 => 3,
                                  4);

_mth_source_ppca_fseen := map(
    mth_source_ppca_fseen < 0  => 0,
    mth_source_ppca_fseen < 13 => 1,
    mth_source_ppca_fseen < 18 => 2,
    mth_source_ppca_fseen < 44 => 3,
                                  4);

_mth_source_ppdid_lseen := map(
    mth_source_ppdid_lseen < 0  => 0,
    mth_source_ppdid_lseen < 7  => 1,
    mth_source_ppdid_lseen < 10 => 2,
    mth_source_ppdid_lseen < 15 => 3,
    mth_source_ppdid_lseen < 18 => 4,
    mth_source_ppdid_lseen < 32 => 5,
    mth_source_ppdid_lseen < 52 => 6,
                                   7);

_mth_source_ppth_fseen := map(
    mth_source_ppth_fseen < 0   => 0,
    mth_source_ppth_fseen < 13  => 1,
    mth_source_ppth_fseen < 28  => 2,
    mth_source_ppth_fseen < 56  => 3,
    mth_source_ppth_fseen < 83  => 4,
    mth_source_ppth_fseen < 110 => 5,
    mth_source_ppth_fseen < 137 => 6,
                                   7);

_mth_source_utildid_fseen := map(
    mth_source_utildid_fseen < 1  => 0,
    mth_source_utildid_fseen < 15 => 1,
    mth_source_utildid_fseen < 26 => 2,
    mth_source_utildid_fseen < 45 => 3,
                                     4);

_mth_eda_dt_first_seen := map(
    mth_eda_dt_first_seen < 1  => 0,
    mth_eda_dt_first_seen < 17 => 1,
    mth_eda_dt_first_seen < 29 => 2,
    mth_eda_dt_first_seen < 48 => 3,
    mth_eda_dt_first_seen < 65 => 4,
                                  5);

_mth_eda_dt_last_seen := map(
    mth_eda_dt_last_seen < 1 => 0,
    mth_eda_dt_last_seen < 8 => 1,
                                2);

_mth_eda_deletion_date := map(
    mth_eda_deletion_date < 1  => 0,
    mth_eda_deletion_date < 19 => 1,
                                  2);

_mth_exp_last_update := map(
    mth_exp_last_update < 1  => 0,
    mth_exp_last_update < 30 => 1,
                                2);

_mth_phone_fb_last_rpc_date := map(
    mth_phone_fb_last_rpc_date < 1  => 0,
    mth_phone_fb_last_rpc_date < 13 => 1,
                                       2);

_mth_phone_fb_rp_date := map(
    mth_phone_fb_rp_date < 1  => 0,
    mth_phone_fb_rp_date < 20 => 1,
                                 2);

_mth_pp_datelastseen := map(
    mth_pp_datelastseen < 1  => 0,
    mth_pp_datelastseen < 15 => 1,
    mth_pp_datelastseen < 22 => 2,
    mth_pp_datelastseen < 34 => 3,
    mth_pp_datelastseen < 50 => 4,
    mth_pp_datelastseen < 70 => 5,
                                6);

_mth_pp_origphoneregdate := if(mth_pp_origphoneregdate < 1, 0, 1);

_mth_pp_eda_hist_ph_dt := map(
    mth_pp_eda_hist_ph_dt < 1  => 0,
    mth_pp_eda_hist_ph_dt < 38 => 1,
                                  2);

_mth_pp_first_build_date := map(
    mth_pp_first_build_date < 1  => 0,
    mth_pp_first_build_date < 6  => 1,
    mth_pp_first_build_date < 13 => 2,
    mth_pp_first_build_date < 19 => 3,
                                    4);

_pp_confidence := if(pp_confidence < 11, 0, 1);

_pp_agegroup := map(
    pp_agegroup < '31' => 0,
    pp_agegroup < '41' => 1,
                        2);

_pp_max_orig_conf_score := map(
    pp_max_orig_conf_score < 3 => 0,
    pp_max_orig_conf_score < 4 => 1,
    pp_max_orig_conf_score < 5 => 2,
                                  3);

_pp_min_orig_conf_score := if(pp_min_orig_conf_score < 3, 0, 1);

_pp_curr_orig_conf_score := if(pp_curr_orig_conf_score < 3, 0, 1);

_pp_app_fb_ph := map(
    pp_app_fb_ph < 2 => 0,
    pp_app_fb_ph < 4 => 1,
                        2);

_pp_app_seen_once_ind := if(pp_app_seen_once_ind < 1, 0, 1);

_pp_app_ind_ph_cnt := map(
    pp_app_ind_ph_cnt < 1  => 0,
    pp_app_ind_ph_cnt < 7  => 1,
    pp_app_ind_ph_cnt < 10 => 2,
                              3);

_pp_app_latest_ph_owner_fl := if(pp_app_latest_ph_owner_fl < 1, 0, 1);

_pp_app_best_addr_match_fl := if(pp_app_best_addr_match_fl < 1, 0, 1);

_pp_app_best_nm_match_fl := if(pp_app_best_nm_match_fl < 1, 0, 1);

_eda_days_in_service := map(
    eda_days_in_service < 1    => 0,
    eda_days_in_service < 191  => 1,
    eda_days_in_service < 1110 => 2,
    eda_days_in_service < 1761 => 3,
                                  4);

_eda_min_days_connected_ind := if(eda_min_days_connected_ind < 1, 0, 1);

_eda_max_days_connected_ind := map(
    eda_max_days_connected_ind < 1   => 0,
    eda_max_days_connected_ind < 437 => 1,
    eda_max_days_connected_ind < 788 => 2,
                                        3);

_eda_days_ind_first_seen := map(
    eda_days_ind_first_seen < 1    => 0,
    eda_days_ind_first_seen < 857  => 1,
    eda_days_ind_first_seen < 1634 => 2,
                                      3);

_eda_days_ind_first_seen_w_ph := map(
    eda_days_ind_first_seen_w_ph < 1    => 0,
    eda_days_ind_first_seen_w_ph < 490  => 1,
    eda_days_ind_first_seen_w_ph < 1634 => 2,
                                           3);

_eda_days_ph_first_seen := map(
    eda_days_ph_first_seen < 1    => 0,
    eda_days_ph_first_seen < 1580 => 1,
                                     2);

_eda_address_match_best := if(eda_address_match_best < 1, 0, 1);

_eda_months_addr_last_seen := map(
    eda_months_addr_last_seen < 1  => 0,
    eda_months_addr_last_seen < 4  => 1,
    eda_months_addr_last_seen < 38 => 2,
    eda_months_addr_last_seen < 70 => 3,
                                      4);

_eda_num_phs_connected_addr := map(
    eda_num_phs_connected_addr < 1 => 0,
    eda_num_phs_connected_addr < 2 => 1,
                                      2);

_eda_num_phs_discon_addr := map(
    eda_num_phs_discon_addr < 1 => 0,
    eda_num_phs_discon_addr < 2 => 1,
    eda_num_phs_discon_addr < 3 => 2,
    eda_num_phs_discon_addr < 5 => 3,
                                   4);

_eda_num_phs_discon_hhid := map(
    eda_num_phs_discon_hhid < 1 => 0,
    eda_num_phs_discon_hhid < 2 => 1,
    eda_num_phs_discon_hhid < 3 => 2,
    eda_num_phs_discon_hhid < 4 => 3,
    eda_num_phs_discon_hhid < 6 => 4,
                                   5);

_eda_is_discon_15_days := if(eda_is_discon_15_days < 1, 0, 1);

_eda_is_discon_180_days := if(eda_is_discon_180_days < 1, 0, 1);

_eda_num_interrupts_cur := if(eda_num_interrupts_cur < 1, 0, 1);

_eda_avg_days_interrupt := map(
    eda_avg_days_interrupt < 1  => 0,
    eda_avg_days_interrupt < 55 => 1,
                                   2);

_eda_has_cur_discon_60_days := if(eda_has_cur_discon_60_days < 1, 0, 1);

_eda_has_cur_discon_180_days := if(eda_has_cur_discon_180_days < 1, 0, 1);

_exp_type := map(
    trim(trim(exp_type, LEFT), LEFT, RIGHT) = trim(trim(' ', LEFT), LEFT, RIGHT) => 0,
    trim(trim(exp_type, LEFT), LEFT, RIGHT) = trim(trim('C', LEFT), LEFT, RIGHT) => 1,
    trim(trim(exp_type, LEFT), LEFT, RIGHT) = trim(trim('N', LEFT), LEFT, RIGHT) => 2,
                                                                                    -9999);

_exp_source := map(
    trim(trim(exp_source, LEFT), LEFT, RIGHT) = trim(trim(' ', LEFT), LEFT, RIGHT) => 0,
    trim(trim(exp_source, LEFT), LEFT, RIGHT) = trim(trim('P', LEFT), LEFT, RIGHT) => 1,
    trim(trim(exp_source, LEFT), LEFT, RIGHT) = trim(trim('S', LEFT), LEFT, RIGHT) => 2,
                                                                                      -9999);

_phone_disconnected := if(phone_disconnected < 1, 0, 1);

_phone_fb_result := map(
    phone_fb_result < 3 => 0,
    phone_fb_result < 9 => 1,
                           2);

_phone_fb_rp_result := map(
    phone_fb_rp_result < 3 => 0,
    phone_fb_rp_result < 9 => 1,
                              2);

_inq_firstseen_n := map(
    inq_firstseen_n < 0  => 0,
    inq_firstseen_n < 11 => 1,
    inq_firstseen_n < 18 => 2,
    inq_firstseen_n < 26 => 3,
    inq_firstseen_n < 44 => 4,
                            5);

_inq_lastseen_n := map(
    inq_lastseen_n < 0  => 0,
    inq_lastseen_n < 7  => 1,
    inq_lastseen_n < 10 => 2,
    inq_lastseen_n < 22 => 3,
    inq_lastseen_n < 43 => 4,
    inq_lastseen_n < 69 => 5,
    inq_lastseen_n < 77 => 6,
                           7);

_inq_adl_firstseen_n := map(
    inq_adl_firstseen_n < 0  => 0,
    inq_adl_firstseen_n < 1  => 1,
    inq_adl_firstseen_n < 26 => 2,
    inq_adl_firstseen_n < 37 => 3,
                                4);

_inq_adl_lastseen_n := map(
    inq_adl_lastseen_n < 0  => 0,
    inq_adl_lastseen_n < 1  => 1,
    inq_adl_lastseen_n < 10 => 2,
    inq_adl_lastseen_n < 16 => 3,
    inq_adl_lastseen_n < 27 => 4,
    inq_adl_lastseen_n < 43 => 5,
                               6);

_phone_match_code_lns := if(max((integer)_phone_match_code_l, 
		(integer)_phone_match_code_n, 
		(integer)_phone_match_code_s) = 0, NULL,
		max((integer)_phone_match_code_l, (integer)_phone_match_code_n, (integer)_phone_match_code_s)) ;

_phone_match_code_tcza := map(
    _phone_match_code_t = 1 and
		_phone_match_code_c = 1 and
		_phone_match_code_z = 1 and 
		_phone_match_code_a = 1 => 4,
    _phone_match_code_t = 1 and
		_phone_match_code_c = 1 => 3,
    _phone_match_code_t = 1 => 2,
    _phone_match_code_c = 1 or 
		_phone_match_code_z = 1 or
		_phone_match_code_a = 1 => 1,
		0);

pk_phone_match_level := map(
    _phone_match_code_lns = 1 and _phone_match_code_tcza = 4 => 4,
    _phone_match_code_lns = 1 and _phone_match_code_tcza > 0 => 3,
    _phone_match_code_lns = 1                                => 2,
    _phone_match_code_tcza > 0                               => 1,
                                                                0);

_pp_app_coctype_landline := if((trim(trim(pp_app_coctype, LEFT), LEFT, RIGHT) in ['EOC']), 1, 0);

_pp_app_coctype_cell := map(
    (trim(trim(pp_app_coctype, LEFT), LEFT, RIGHT) in ['PMC', 'RCC', 'SP1', 'SP2']) and (trim(trim(PP_app_SCC, LEFT), LEFT, RIGHT) in ['C', 'R', 'S']) => 1,
    (trim(trim(pp_app_coctype, LEFT), LEFT, RIGHT) in ['EOC']) and (trim(trim(PP_app_SCC, LEFT), LEFT, RIGHT) in ['C', 'R'])                           => 1,
                                                                                                                                                          0);

_phone_switch_type_cell := if(trim(trim(Phone_Switch_Type, LEFT), LEFT, RIGHT) = 'C', 1, 0);

_pp_app_nxx_type_cell := if(((real)pp_app_nxx_type in [4, 55, 65]), 1, 0);

_pp_app_ph_type_cell := if((trim(trim(PP_app_ph_Type, LEFT), LEFT, RIGHT) in ['CELL', 'LNDLN PRTD TO CELL']), 1, 0);

_pp_app_company_type_cell := if((PP_app_Company_Type in [5, 8]), 1, 0);

_exp_type_cell := if(trim(trim(Exp_Type, LEFT), LEFT, RIGHT) = 'C', 1, 0);

pk_cell_indicator := map(
    _exp_type_cell > 0 and if(max(_phone_switch_type_cell, _pp_rule_cellphone_latest, _pp_rule_med_vend_conf_cell, _pp_app_coctype_cell, _pp_app_nxx_type_cell, _pp_app_ph_type_cell, _pp_app_company_type_cell) = NULL, NULL, sum(if(_phone_switch_type_cell = NULL, 0, _phone_switch_type_cell), if(_pp_rule_cellphone_latest = NULL, 0, _pp_rule_cellphone_latest), if(_pp_rule_med_vend_conf_cell = NULL, 0, _pp_rule_med_vend_conf_cell), if(_pp_app_coctype_cell = NULL, 0, _pp_app_coctype_cell), if(_pp_app_nxx_type_cell = NULL, 0, _pp_app_nxx_type_cell), if(_pp_app_ph_type_cell = NULL, 0, _pp_app_ph_type_cell), if(_pp_app_company_type_cell = NULL, 0, _pp_app_company_type_cell))) > 0 => 4,
    if(max(_phone_switch_type_cell, _pp_rule_cellphone_latest, _pp_rule_med_vend_conf_cell, _pp_app_coctype_cell, _pp_app_nxx_type_cell, _pp_app_ph_type_cell, _pp_app_company_type_cell) = NULL, NULL, sum(if(_phone_switch_type_cell = NULL, 0, _phone_switch_type_cell), if(_pp_rule_cellphone_latest = NULL, 0, _pp_rule_cellphone_latest), if(_pp_rule_med_vend_conf_cell = NULL, 0, _pp_rule_med_vend_conf_cell), if(_pp_app_coctype_cell = NULL, 0, _pp_app_coctype_cell), if(_pp_app_nxx_type_cell = NULL, 0, _pp_app_nxx_type_cell), if(_pp_app_ph_type_cell = NULL, 0, _pp_app_ph_type_cell), if(_pp_app_company_type_cell = NULL, 0, _pp_app_company_type_cell))) = 7                        => 3,
    _phone_switch_type_cell = 1 and _pp_rule_cellphone_latest = 1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       => 2,
    _phone_switch_type_cell = 1 and _pp_rule_med_vend_conf_cell = 1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                     => 1,
    _pp_app_coctype_landline = 1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        => -1,
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           0);

pk_cell_flag := if(pk_cell_indicator > 0, 1, 0);

_pp_glb_dppa_util := if(trim(trim(pp_glb_dppa_fl, LEFT), LEFT, RIGHT) = trim(trim('U', LEFT), LEFT, RIGHT), 1, 0);

_pp_origlistingtype_res := if(trim(trim(pp_origlistingtype, LEFT), LEFT, RIGHT) = trim(trim('R', LEFT), LEFT, RIGHT), 1, 0);

pk_eda_hit := if(trim(trim(eda_omit_locality, LEFT), LEFT, RIGHT) = '' and eda_did = 0 and eda_hhid = 0 and eda_bdid = 0 and trim(trim(eda_listing_name, LEFT), LEFT, RIGHT) = '' and eda_did_count = 0 and trim(trim(eda_dt_first_seen, LEFT), LEFT, RIGHT) = '' and trim(trim(eda_dt_last_seen, LEFT), LEFT, RIGHT) = '' and eda_current_record_fl = 0 and trim(trim(eda_deletion_date, LEFT), LEFT, RIGHT) = '' and eda_disc_cnt6 = 0 and eda_disc_cnt12 = 0 and eda_disc_cnt18 = 0 and trim(trim(eda_pfrd_address_ind, LEFT), LEFT, RIGHT) = 'XX' and eda_days_in_service = 0 and eda_num_ph_owners_hist = 0 and eda_num_ph_owners_cur = 0 and eda_num_phs_ind = 0 and eda_num_phs_connected_ind = 0 and eda_num_phs_discon_ind = 0 and eda_avg_days_connected_ind = 0 and eda_min_days_connected_ind = 0 and eda_max_days_connected_ind = 0 and eda_days_ind_first_seen = 0 and eda_days_ind_first_seen_w_ph = 0 and eda_days_ph_first_seen = 0 and eda_address_match_best = 0 and eda_months_addr_last_seen = 0 and eda_num_phs_connected_addr = 0 and eda_num_phs_discon_addr = 0 and eda_num_phs_connected_hhid = 0 and eda_num_phs_discon_hhid = 0 and eda_is_discon_15_days = 0 and eda_is_discon_30_days = 0 and eda_is_discon_60_days = 0 and eda_is_discon_90_days = 0 and eda_is_discon_180_days = 0 and eda_is_discon_360_days = 0 and eda_is_current_in_hist = 0 and eda_num_interrupts_cur = 0 and eda_avg_days_interrupt = 0 and eda_min_days_interrupt = 0 and eda_max_days_interrupt = 0 and eda_has_cur_discon_15_days = 0 and eda_has_cur_discon_30_days = 0 and eda_has_cur_discon_60_days = 0 and eda_has_cur_discon_90_days = 0 and eda_has_cur_discon_180_days = 0 and eda_has_cur_discon_360_days = 0, 0, 1);

pk_exp_hit := if(exp_verified = 0 and 
	trim(trim(exp_type, LEFT), LEFT, RIGHT) = '' and 
	trim(trim(exp_source, LEFT), LEFT, RIGHT) = '' and 
	trim(trim(exp_last_update, LEFT), LEFT, RIGHT) = '' and 
	(integer) exp_ph_score_v1 <= 0, 0, 1);

pk_pp_hit := if(trim(trim(pp_type, LEFT), LEFT, RIGHT) = '' and
							trim(trim(pp_source, LEFT), LEFT, RIGHT) = '' and
							trim(trim(pp_carrier, LEFT), LEFT, RIGHT) = '' and 
							trim(trim(pp_city, LEFT), LEFT, RIGHT) = '' and 
							trim(trim(pp_state, LEFT), LEFT, RIGHT) = '' and 
							trim(trim(pp_rp_type, LEFT), LEFT, RIGHT) = '' and 
							trim(trim(pp_rp_source, LEFT), LEFT, RIGHT) = '' and 
							trim(trim(pp_rp_carrier, LEFT), LEFT, RIGHT) = '' and
							trim(trim(pp_rp_city, LEFT), LEFT, RIGHT) = '' and
							trim(trim(pp_rp_state, LEFT), LEFT, RIGHT) = '' and
							pp_confidence = 0 and trim(trim(pp_rules, LEFT), LEFT, RIGHT) = '0000000000000000000000000000000000000000000000000000000000000000' and
							pp_did = 0 and
							pp_did_score = 0 and
							trim(trim(pp_listing_name, LEFT), LEFT, RIGHT) = '' and
							trim(trim(pp_datefirstseen, LEFT), LEFT, RIGHT) = '' and
							trim(trim(pp_datelastseen, LEFT), LEFT, RIGHT) = '' and
							trim(trim(pp_datevendorfirstseen, LEFT), LEFT, RIGHT) = '' and
							trim(trim(pp_datevendorlastseen, LEFT), LEFT, RIGHT) = '' and
							trim(trim(pp_date_nonglb_lastseen, LEFT), LEFT, RIGHT) = '' and
							trim(trim(pp_glb_dppa_fl, LEFT), LEFT, RIGHT) = '' and
							trim(trim(pp_glb_dppa_all, LEFT), LEFT, RIGHT) = '' and
							trim(trim(pp_src, LEFT), LEFT, RIGHT) = '' and
							trim(trim(pp_src_all, LEFT), LEFT, RIGHT) = '0000000000000000000000000000000000000000000000000000000000000000' and
							pp_src_cnt = 0 and
							trim(trim(pp_src_rule, LEFT), LEFT, RIGHT) = '0000000000000000000000000000000000000000000000000000000000000000' and
							pp_avg_source_conf = 0 and
							pp_max_source_conf = 0 and 
							pp_min_source_conf = 0 and
							pp_total_source_conf = 0 and
							trim(trim(pp_orig_lastseen, LEFT), LEFT, RIGHT) = '' and
							trim(trim(pp_did_type, LEFT), LEFT, RIGHT) = '' and
							trim(trim(pp_origname, LEFT), LEFT, RIGHT) = '' and
							trim(trim(pp_address1, LEFT), LEFT, RIGHT) = '' and
							trim(trim(pp_address2, LEFT), LEFT, RIGHT) = '' and
							trim(trim(pp_address3, LEFT), LEFT, RIGHT) = '' and
							trim(trim(pp_origcity, LEFT), LEFT, RIGHT) = '' and
							trim(trim(pp_origstate, LEFT), LEFT, RIGHT) = '' and
							trim(trim(pp_origzip, LEFT), LEFT, RIGHT) = '' and
							trim(trim(pp_origphone, LEFT), LEFT, RIGHT) = '' and
							trim(trim(pp_dob, LEFT), LEFT, RIGHT) = '' and
							trim(trim(pp_agegroup, LEFT), LEFT, RIGHT) = '' and
							trim(trim(pp_gender, LEFT), LEFT, RIGHT) = '' and
							trim(trim(pp_email, LEFT), LEFT, RIGHT) = '' and
							trim(trim(pp_origlistingtype, LEFT), LEFT, RIGHT) = '' and
							trim(trim(pp_listingtype, LEFT), LEFT, RIGHT) = '' and
							trim(trim(pp_origpublishcode, LEFT), LEFT, RIGHT) = '' and
							trim(trim(pp_origphonetype, LEFT), LEFT, RIGHT) = '' and
							trim(trim(pp_origphoneusage, LEFT), LEFT, RIGHT) = '' and
							trim(trim(pp_company, LEFT), LEFT, RIGHT) = '' and
							trim(trim(pp_origphoneregdate, LEFT), LEFT, RIGHT) = '' and
							trim(trim(pp_origcarriercode, LEFT), LEFT, RIGHT) = '' and
							trim(trim(pp_origcarriername, LEFT), LEFT, RIGHT) = '' and
							pp_origrectype = 0 and 
							pp_bdid = 0 and 
							pp_bdid_score = 0 and
							trim(trim(pp_app_npa_effective_dt, LEFT), LEFT, RIGHT) = '' and
							trim(trim(pp_app_npa_last_change_dt, LEFT), LEFT, RIGHT) = '' and
							pp_app_dialable_ind = 0 and 
							trim(trim(pp_app_place_name, LEFT), LEFT, RIGHT) = '' and
							pp_app_portability_indicator = 0 and 
							trim(trim(pp_app_prior_area_code, LEFT), LEFT, RIGHT) = '' and
							trim(trim(pp_app_nonpublished_match, LEFT), LEFT, RIGHT) = '0000000000000000000000000000000000000000000000000000000000000000' and
							trim(trim(pp_app_ocn, LEFT), LEFT, RIGHT) = '' and
							trim(trim(pp_app_time_zone, LEFT), LEFT, RIGHT) = '' and
							trim(trim(pp_app_nxx_type, LEFT), LEFT, RIGHT) = '' and
							trim(trim(pp_app_coctype, LEFT), LEFT, RIGHT) = '' and
							trim(trim(pp_app_scc, LEFT), LEFT, RIGHT) = '' and
							trim(trim(pp_app_ph_type, LEFT), LEFT, RIGHT) = '' and
							trim(trim(pp_app_ph_use, LEFT), LEFT, RIGHT) = '' and
							trim(trim(pp_agreg_listing_type, LEFT), LEFT, RIGHT) = '' and
							trim(trim(pp_eda_match, LEFT), LEFT, RIGHT) = '0000000000000000000000000000000000000000000000000000000000000000' and
							pp_eda_ph_dt = '0' and
							trim(trim(pp_eda_did_dt, LEFT), LEFT, RIGHT) = '' and
							trim(trim(pp_eda_nm_addr_dt, LEFT), LEFT, RIGHT) = '' and
							trim(trim(pp_eda_hist_match, LEFT), LEFT, RIGHT) = '0000000000000000000000000000000000000000000000000000000000000000' and
							trim(trim(pp_eda_hist_ph_dt, LEFT), LEFT, RIGHT) = '' and 
							trim(trim(pp_eda_hist_did_dt, LEFT), LEFT, RIGHT) = '' and
							trim(trim(pp_eda_hist_nm_addr_dt, LEFT), LEFT, RIGHT) = '' and
							trim(trim(pp_app_fb_ph_dt, LEFT), LEFT, RIGHT) = '' and
							trim(trim(pp_app_fb_ph7_did_dt, LEFT), LEFT, RIGHT) = '' and
							trim(trim(pp_app_fb_ph7_nm_addr_dt, LEFT), LEFT, RIGHT) = '' and
							trim(trim(pp_app_ported_match, LEFT), LEFT, RIGHT) = '0000000000000000000000000000000000000000000000000000000000000000' and
							pp_app_seen_once_ind = 0 and pp_app_ind_ph_cnt = 0 and
							pp_app_ind_has_actv_eda_ph_fl = 0 and
							pp_app_latest_ph_owner_fl = 0 and
							pp_hhid = 0 and 
							pp_hhid_score = 0 and
							pp_app_best_addr_match_fl = 0 and 
							pp_app_best_nm_match_fl = 0 and
							pp_rawaid = 0 and 
							pp_cleanaid = 0 and
							pp_current_rec = 0 and 
							trim(trim(pp_first_build_date, LEFT), LEFT, RIGHT) = '' and 
							trim(trim(pp_last_build_date, LEFT), LEFT, RIGHT) = '', 0, 1);

segment := map(
    pk_exp_hit = 1          => '3 - ExpHit      ',
    pk_cell_flag = 1        => '2 - Cell Phone  ',
    _phone_disconnected = 1 => '0 - Disconnected',
                               '1 - Other       ');

_mth_source_exp_fseen3 := min(if(max(_mth_source_exp_fseen, 0) = NULL, -NULL, max(_mth_source_exp_fseen, 0)), 3);

_mth_source_paw_lseen1 := min(if(max(_mth_source_paw_lseen, 0) = NULL, -NULL, max(_mth_source_paw_lseen, 0)), 2);

_mth_source_utildid_fseen1 := min(if(max(_mth_source_utildid_fseen, 0) = NULL, -NULL, max(_mth_source_utildid_fseen, 0)), 4);

_mth_source_utildid_fseen2 := min(if(max(_mth_source_utildid_fseen, 0) = NULL, -NULL, max(_mth_source_utildid_fseen, 0)), 4);

_mth_exp_last_update3 := min(if(max(_mth_exp_last_update, 0) = NULL, -NULL, max(_mth_exp_last_update, 0)), 2);

_mth_phone_fb_last_rpc_date0 := min(if(max(_mth_phone_fb_last_rpc_date, 0) = NULL, -NULL, max(_mth_phone_fb_last_rpc_date, 0)), 2);

_mth_phone_fb_last_rpc_date3 := min(if(max(_mth_phone_fb_last_rpc_date, 0) = NULL, -NULL, max(_mth_phone_fb_last_rpc_date, 0)), 2);

_mth_phone_fb_rp_date3 := min(if(max(_mth_phone_fb_rp_date, 0) = NULL, -NULL, max(_mth_phone_fb_rp_date, 0)), 2);

_exp_type3 := min(if(max(_exp_type, 0) = NULL, -NULL, max(_exp_type, 0)), 2);

_exp_source3 := min(if(max(_exp_source, 0) = NULL, -NULL, max(_exp_source, 0)), 2);

_phone_fb_result0 := min(if(max(_phone_fb_result, 0) = NULL, -NULL, max(_phone_fb_result, 0)), 2);

_phone_fb_result1 := min(if(max(_phone_fb_result, 0) = NULL, -NULL, max(_phone_fb_result, 0)), 2);

_phone_fb_result3 := min(if(max(_phone_fb_result, 0) = NULL, -NULL, max(_phone_fb_result, 0)), 2);

_phone_fb_rp_result0 := min(if(max(_phone_fb_rp_result, 0) = NULL, -NULL, max(_phone_fb_rp_result, 0)), 2);

_phone_fb_rp_result1 := min(if(max(_phone_fb_rp_result, 0) = NULL, -NULL, max(_phone_fb_rp_result, 0)), 2);

_phone_fb_rp_result3 := min(if(max(_phone_fb_rp_result, 0) = NULL, -NULL, max(_phone_fb_rp_result, 0)), 2);

_inq_firstseen_n0 := min(if(max(_inq_firstseen_n, 0) = NULL, -NULL, max(_inq_firstseen_n, 0)), 5);

_inq_firstseen_n2 := min(if(max(_inq_firstseen_n, 0) = NULL, -NULL, max(_inq_firstseen_n, 0)), 5);

_inq_lastseen_n0 := min(if(max(_inq_lastseen_n, 0) = NULL, -NULL, max(_inq_lastseen_n, 0)), 7);

_inq_lastseen_n1 := min(if(max(_inq_lastseen_n, 0) = NULL, -NULL, max(_inq_lastseen_n, 0)), 7);

_inq_lastseen_n3 := min(if(max(_inq_lastseen_n, 0) = NULL, -NULL, max(_inq_lastseen_n, 0)), 7);

_inq_adl_firstseen_n1 := min(if(max(_inq_adl_firstseen_n, 0) = NULL, -NULL, max(_inq_adl_firstseen_n, 0)), 4);

_inq_adl_lastseen_n1 := min(if(max(_inq_adl_lastseen_n, 0) = NULL, -NULL, max(_inq_adl_lastseen_n, 0)), 6);

_inq_adl_lastseen_n2 := min(if(max(_inq_adl_lastseen_n, 0) = NULL, -NULL, max(_inq_adl_lastseen_n, 0)), 6);

_inq_adl_lastseen_n3 := min(if(max(_inq_adl_lastseen_n, 0) = NULL, -NULL, max(_inq_adl_lastseen_n, 0)), 6);

pk_phone_match_level1 := min(if(max(pk_phone_match_level, 0) = NULL, -NULL, max(pk_phone_match_level, 0)), 2);

_mth_source_edaca_lseen0 := min(if(max(_mth_source_edaca_lseen, 1) = NULL, -NULL, max(_mth_source_edaca_lseen, 1)), 2);

_mth_source_edaca_lseen1 := min(if(max(_mth_source_edaca_lseen, 0) = NULL, -NULL, max(_mth_source_edaca_lseen, 0)), 2);

_mth_source_edahistory_lseen1 := if(pk_eda_hit = 1 and source_eda_any_clean = 1, 0, min(if(max(_mth_source_edahistory_lseen, 0) = NULL, -NULL, max(_mth_source_edahistory_lseen, 0)), 3));

_mth_eda_dt_first_seen1 := if(pk_eda_hit = 1 and source_eda_any_clean = 1, min(if(max(_mth_eda_dt_first_seen, 0) = NULL, -NULL, max(_mth_eda_dt_first_seen, 0)), 0), min(if(max(_mth_eda_dt_first_seen, 0) = NULL, -NULL, max(_mth_eda_dt_first_seen, 0)), 5));

_mth_eda_dt_last_seen0 := min(if(max(_mth_eda_dt_last_seen, 1) = NULL, -NULL, max(_mth_eda_dt_last_seen, 1)), 2);

_mth_eda_dt_last_seen3 := min(if(max(_mth_eda_dt_last_seen, 1) = NULL, -NULL, max(_mth_eda_dt_last_seen, 1)), 2);

_mth_eda_deletion_date0 := min(if(max(_mth_eda_deletion_date, 1) = NULL, -NULL, max(_mth_eda_deletion_date, 1)), 2);

_mth_eda_deletion_date3 := min(if(max(_mth_eda_deletion_date, 0) = NULL, -NULL, max(_mth_eda_deletion_date, 0)), 2);

_eda_days_in_service0 := min(if(max(_eda_days_in_service, 1) = NULL, -NULL, max(_eda_days_in_service, 1)), 3);

_eda_max_days_connected_ind3 := if(pk_eda_hit = 1 and source_eda_any_clean = 1, min(if(max(_eda_max_days_connected_ind, 0) = NULL, -NULL, max(_eda_max_days_connected_ind, 0)), 3), min(if(max(_eda_max_days_connected_ind, 0) = NULL, -NULL, max(_eda_max_days_connected_ind, 0)), 2));

_eda_days_ind_first_seen1 := if(pk_eda_hit = 1 and source_eda_any_clean = 1, min(if(max(_eda_days_ind_first_seen, 0) = NULL, -NULL, max(_eda_days_ind_first_seen, 0)), 3), min(if(max(_eda_days_ind_first_seen, 0) = NULL, -NULL, max(_eda_days_ind_first_seen, 0)), 3));

_eda_days_ind_first_seen3 := if(pk_eda_hit = 1 and source_eda_any_clean = 1, min(if(max(_eda_days_ind_first_seen, 0) = NULL, -NULL, max(_eda_days_ind_first_seen, 0)), 2), min(if(max(_eda_days_ind_first_seen, 0) = NULL, -NULL, max(_eda_days_ind_first_seen, 0)), 2));

_eda_days_ind_first_seen_w_ph3 := map(
    _eda_days_ind_first_seen_w_ph = 0  => 0,
    _eda_days_ind_first_seen_w_ph <= 2 => 1,
                                          2);

_eda_days_ph_first_seen1 := min(if(max(_eda_days_ph_first_seen, 1) = NULL, -NULL, max(_eda_days_ph_first_seen, 1)), 2);

_eda_months_addr_last_seen3 := min(if(max(_eda_months_addr_last_seen, 0) = NULL, -NULL, max(_eda_months_addr_last_seen, 0)), 3);

_eda_num_phs_connected_addr1 := min(if(max(_eda_num_phs_connected_addr, 1) = NULL, -NULL, max(_eda_num_phs_connected_addr, 1)), 2);

_eda_num_phs_discon_addr0 := if(pk_eda_hit = 1 and source_eda_any_clean = 1, min(if(max(_eda_num_phs_discon_addr, 0) = NULL, -NULL, max(_eda_num_phs_discon_addr, 0)), 0), min(if(max(_eda_num_phs_discon_addr, 0) = NULL, -NULL, max(_eda_num_phs_discon_addr, 0)), 4));

_eda_num_phs_discon_hhid1 := min(if(max(_eda_num_phs_discon_hhid, 0) = NULL, -NULL, max(_eda_num_phs_discon_hhid, 0)), 3);

_eda_num_phs_discon_hhid3 := min(if(max(_eda_num_phs_discon_hhid, 0) = NULL, -NULL, max(_eda_num_phs_discon_hhid, 0)), 3);

_eda_avg_days_interrupt1 := min(if(max(_eda_avg_days_interrupt, 1) = NULL, -NULL, max(_eda_avg_days_interrupt, 1)), 2);

_mth_source_ppca_lseen1 := min(if(max(_mth_source_ppca_lseen, 0) = NULL, -NULL, max(_mth_source_ppca_lseen, 0)), 4);

_mth_source_ppca_lseen2 := min(if(max(_mth_source_ppca_lseen, 0) = NULL, -NULL, max(_mth_source_ppca_lseen, 0)), 4);

_mth_source_ppca_fseen0 := min(if(max(_mth_source_ppca_fseen, 0) = NULL, -NULL, max(_mth_source_ppca_fseen, 0)), 2);

_mth_source_ppca_fseen3 := min(if(max(_mth_source_ppca_fseen, 0) = NULL, -NULL, max(_mth_source_ppca_fseen, 0)), 4);

_mth_source_ppdid_lseen0 := min(if(max(_mth_source_ppdid_lseen, 0) = NULL, -NULL, max(_mth_source_ppdid_lseen, 0)), 7);

_mth_source_ppdid_lseen1 := min(if(max(_mth_source_ppdid_lseen, 0) = NULL, -NULL, max(_mth_source_ppdid_lseen, 0)), 7);

_mth_source_ppdid_lseen2 := min(if(max(_mth_source_ppdid_lseen, 0) = NULL, -NULL, max(_mth_source_ppdid_lseen, 0)), 7);

_mth_source_ppdid_lseen3 := min(if(max(_mth_source_ppdid_lseen, 0) = NULL, -NULL, max(_mth_source_ppdid_lseen, 0)), 7);

_mth_source_ppth_fseen0 := if(pk_pp_hit = 1 and source_pp_any_clean = 1, min(if(max(_mth_source_ppth_fseen, 0) = NULL, -NULL, max(_mth_source_ppth_fseen, 0)), 0), min(if(max(_mth_source_ppth_fseen, 0) = NULL, -NULL, max(_mth_source_ppth_fseen, 0)), 1));

_mth_source_ppth_fseen1 := if(pk_pp_hit = 1 and source_pp_any_clean = 1, min(if(max(_mth_source_ppth_fseen, 0) = NULL, -NULL, max(_mth_source_ppth_fseen, 0)), 0), min(if(max(_mth_source_ppth_fseen, 0) = NULL, -NULL, max(_mth_source_ppth_fseen, 0)), 5));

_mth_source_ppth_fseen2 := if(pk_pp_hit = 1 and source_pp_any_clean = 1, min(if(max(_mth_source_ppth_fseen, 0) = NULL, -NULL, max(_mth_source_ppth_fseen, 0)), 0), min(if(max(_mth_source_ppth_fseen, 0) = NULL, -NULL, max(_mth_source_ppth_fseen, 0)), 3));

_mth_pp_datelastseen0 := min(if(max(_mth_pp_datelastseen, 2) = NULL, -NULL, max(_mth_pp_datelastseen, 2)), 3);

_mth_pp_eda_hist_ph_dt3 := min(if(max(_mth_pp_eda_hist_ph_dt, 0) = NULL, -NULL, max(_mth_pp_eda_hist_ph_dt, 0)), 1);

_mth_pp_first_build_date3 := if(pk_pp_hit = 1 and source_pp_any_clean = 1, min(if(max(_mth_pp_first_build_date, 1) = NULL, -NULL, max(_mth_pp_first_build_date, 1)), 3), min(if(max(_mth_pp_first_build_date, 0) = NULL, -NULL, max(_mth_pp_first_build_date, 0)), 2));

_mth_pp_first_build_date1 := if(pk_pp_hit = 1 and source_pp_any_clean = 1, min(if(max(_mth_pp_first_build_date, 2) = NULL, -NULL, max(_mth_pp_first_build_date, 2)), 4), min(if(max(_mth_pp_first_build_date, 0) = NULL, -NULL, max(_mth_pp_first_build_date, 0)), 2));

_pp_agegroup2 := if(pk_pp_hit = 1 and source_pp_any_clean = 1, min(if(max(_pp_agegroup, 0) = NULL, -NULL, max(_pp_agegroup, 0)), 2), min(if(max(_pp_agegroup, 0) = NULL, -NULL, max(_pp_agegroup, 0)), 1));

_pp_max_orig_conf_score3 := min(if(max(_pp_max_orig_conf_score, 1) = NULL, -NULL, max(_pp_max_orig_conf_score, 1)), 2);

_pp_app_fb_ph3 := min(if(max(_pp_app_fb_ph, 0) = NULL, -NULL, max(_pp_app_fb_ph, 0)), 2);

_pp_app_ind_ph_cnt3 := min(if(max(_pp_app_ind_ph_cnt, 0) = NULL, -NULL, max(_pp_app_ind_ph_cnt, 0)), 3);

_pp_app_ind_ph_cnt1 := if(pk_pp_hit = 1 and source_pp_any_clean = 1, min(if(max(_pp_app_ind_ph_cnt, 1) = NULL, -NULL, max(_pp_app_ind_ph_cnt, 1)), 3), min(if(max(_pp_app_ind_ph_cnt, 0) = NULL, -NULL, max(_pp_app_ind_ph_cnt, 0)), 3));

_mth_phone_fb_last_rpc_date0_m := map(
    _mth_phone_fb_last_rpc_date0 = 0 => 0.002514964,
    _mth_phone_fb_last_rpc_date0 = 1 => 0.0222222222,
    _mth_phone_fb_last_rpc_date0 = 2 => 0,
                                        0.0024984079);

_phone_fb_result0_m := map(
    _phone_fb_result0 = 0 => 0.0185185185,
    _phone_fb_result0 = 1 => 0,
    _phone_fb_result0 = 2 => 0.0025124366,
                             0.0024984079);

_phone_fb_rp_result0_m := map(
    _phone_fb_rp_result0 = 0 => 0.0090497738,
    _phone_fb_rp_result0 = 1 => 0.0006485084,
    _phone_fb_rp_result0 = 2 => 0.0025737265,
                                0.0024984079);

_inq_firstseen_n0_m := map(
    _inq_firstseen_n0 = 0 => 0.0014238561,
    _inq_firstseen_n0 = 1 => 0.0152284264,
    _inq_firstseen_n0 = 2 => 0.0238095238,
    _inq_firstseen_n0 = 3 => 0.011627907,
    _inq_firstseen_n0 = 4 => 0.0072815534,
    _inq_firstseen_n0 = 5 => 0.0026890756,
                             0.0024984079);

_inq_lastseen_n0_m := map(
    _inq_lastseen_n0 = 0 => 0.0014238561,
    _inq_lastseen_n0 = 1 => 0.0114942529,
    _inq_lastseen_n0 = 2 => 0.0298507463,
    _inq_lastseen_n0 = 3 => 0.0137844612,
    _inq_lastseen_n0 = 4 => 0.0036166365,
    _inq_lastseen_n0 = 5 => 0.0018303844,
    _inq_lastseen_n0 = 6 => 0,
    _inq_lastseen_n0 = 7 => 0,
                            0.0024984079);

_mth_source_paw_lseen1_m := map(
    _mth_source_paw_lseen1 = 0 => 0.035524431,
    _mth_source_paw_lseen1 = 1 => 0.0497925311,
    _mth_source_paw_lseen1 = 2 => 0.0420168067,
                                  0.0357633683);

_mth_source_utildid_fseen1_m := map(
    _mth_source_utildid_fseen1 = 0 => 0.0350987462,
    _mth_source_utildid_fseen1 = 1 => 0.1438356164,
    _mth_source_utildid_fseen1 = 2 => 0.0673758865,
    _mth_source_utildid_fseen1 = 3 => 0.037037037,
    _mth_source_utildid_fseen1 = 4 => 0.0297823597,
                                      0.0357633683);

_phone_fb_result1_m := map(
    _phone_fb_result1 = 0 => 0.0258064516,
    _phone_fb_result1 = 1 => 0.0067340067,
    _phone_fb_result1 = 2 => 0.0360854138,
                             0.0357633683);

_phone_fb_rp_result1_m := map(
    _phone_fb_rp_result1 = 0 => 0.0470383275,
    _phone_fb_rp_result1 = 1 => 0.0244432374,
    _phone_fb_rp_result1 = 2 => 0.0360354153,
                                0.0357633683);

_inq_lastseen_n1_m := map(
    _inq_lastseen_n1 = 0 => 0.0317242203,
    _inq_lastseen_n1 = 1 => 0.0607843137,
    _inq_lastseen_n1 = 2 => 0.0498773508,
    _inq_lastseen_n1 = 3 => 0.0400098184,
    _inq_lastseen_n1 = 4 => 0.0383149873,
    _inq_lastseen_n1 = 5 => 0.0282880235,
    _inq_lastseen_n1 = 6 => 0.0163934426,
    _inq_lastseen_n1 = 7 => 0.0157894737,
                            0.0357633683);

_inq_adl_firstseen_n1_m := map(
    _inq_adl_firstseen_n1 = 0 => 0.0317242203,
    _inq_adl_firstseen_n1 = 1 => 0.0369270871,
    _inq_adl_firstseen_n1 = 2 => 0.122244489,
    _inq_adl_firstseen_n1 = 3 => 0.0755287009,
    _inq_adl_firstseen_n1 = 4 => 0.0282574568,
                                 0.0357633683);

_inq_adl_lastseen_n1_m := map(
    _inq_adl_lastseen_n1 = 0 => 0.0317242203,
    _inq_adl_lastseen_n1 = 1 => 0.0369270871,
    _inq_adl_lastseen_n1 = 2 => 0.2289156627,
    _inq_adl_lastseen_n1 = 3 => 0.0742857143,
    _inq_adl_lastseen_n1 = 4 => 0.0865051903,
    _inq_adl_lastseen_n1 = 5 => 0.054245283,
    _inq_adl_lastseen_n1 = 6 => 0.0121065375,
                                0.0357633683);

pk_phone_match_level1_m := map(
    pk_phone_match_level1 = 0 => 0.0174810447,
    pk_phone_match_level1 = 1 => 0.0243482392,
    pk_phone_match_level1 = 2 => 0.0625179787,
                                 0.0357633683);

_mth_source_utildid_fseen2_m := map(
    _mth_source_utildid_fseen2 = 0 => 0.0523672117,
    _mth_source_utildid_fseen2 = 1 => 0.3048128342,
    _mth_source_utildid_fseen2 = 2 => 0.1506276151,
    _mth_source_utildid_fseen2 = 3 => 0.0928143713,
    _mth_source_utildid_fseen2 = 4 => 0.0431266846,
                                      0.0600686499);

_inq_firstseen_n2_m := map(
    _inq_firstseen_n2 = 0 => 0.0571524626,
    _inq_firstseen_n2 = 1 => 0.1196078431,
    _inq_firstseen_n2 = 2 => 0.0751748252,
    _inq_firstseen_n2 = 3 => 0.0594059406,
    _inq_firstseen_n2 = 4 => 0.0583395662,
    _inq_firstseen_n2 = 5 => 0.0467091295,
                             0.0600686499);

_inq_adl_lastseen_n2_m := map(
    _inq_adl_lastseen_n2 = 0 => 0.0571524626,
    _inq_adl_lastseen_n2 = 1 => 0.0452662722,
    _inq_adl_lastseen_n2 = 2 => 0.274611399,
    _inq_adl_lastseen_n2 = 3 => 0.164893617,
    _inq_adl_lastseen_n2 = 4 => 0.0807692308,
    _inq_adl_lastseen_n2 = 5 => 0.0685920578,
    _inq_adl_lastseen_n2 = 6 => 0.0539419087,
                                0.0600686499);

_mth_source_exp_fseen3_m := map(
    _mth_source_exp_fseen3 = 0 => 0.097838067,
    _mth_source_exp_fseen3 = 1 => 0.1011235955,
    _mth_source_exp_fseen3 = 2 => 0.0660377358,
    _mth_source_exp_fseen3 = 3 => 0.0215053763,
                                  0.0969957792);

_mth_exp_last_update3_m := map(
    _mth_exp_last_update3 = 1 => 0.1315533306,
    _mth_exp_last_update3 = 2 => 0.0461978741,
                                 0.0969957792);

_mth_phone_fb_last_rpc_date3_m := map(
    _mth_phone_fb_last_rpc_date3 = 0 => 0.0980579988,
    _mth_phone_fb_last_rpc_date3 = 1 => 0.1574074074,
    _mth_phone_fb_last_rpc_date3 = 2 => 0.0589430894,
                                        0.0969957792);

_mth_phone_fb_rp_date3_m := map(
    _mth_phone_fb_rp_date3 = 0 => 0.0984964437,
    _mth_phone_fb_rp_date3 = 1 => 0.1276595745,
    _mth_phone_fb_rp_date3 = 2 => 0.0556414219,
                                  0.0969957792);

_exp_type3_m := map(
    _exp_type3 = 1 => 0.1642008246,
    _exp_type3 = 2 => 0.0621859296,
                      0.0969957792);

_exp_source3_m := map(
    _exp_source3 = 1 => 0.1041517538,
    _exp_source3 = 2 => 0.0948433631,
                        0.0969957792);

_phone_fb_result3_m := map(
    _phone_fb_result3 = 0 => 0.193236715,
    _phone_fb_result3 = 1 => 0.0141242938,
    _phone_fb_result3 = 2 => 0.0978128797,
                             0.0969957792);

_phone_fb_rp_result3_m := map(
    _phone_fb_rp_result3 = 0 => 0.1617161716,
    _phone_fb_rp_result3 = 1 => 0.0436893204,
    _phone_fb_rp_result3 = 2 => 0.0981902885,
                                0.0969957792);

_inq_lastseen_n3_m := map(
    _inq_lastseen_n3 = 0 => 0.069966443,
    _inq_lastseen_n3 = 1 => 0.210965435,
    _inq_lastseen_n3 = 2 => 0.1407249467,
    _inq_lastseen_n3 = 3 => 0.1424186618,
    _inq_lastseen_n3 = 4 => 0.0984400215,
    _inq_lastseen_n3 = 5 => 0.0789715335,
    _inq_lastseen_n3 = 6 => 0.0518518519,
    _inq_lastseen_n3 = 7 => 0.0388349515,
                            0.0969957792);

_inq_adl_lastseen_n3_m := map(
    _inq_adl_lastseen_n3 = 0 => 0.069966443,
    _inq_adl_lastseen_n3 = 1 => 0.0850914205,
    _inq_adl_lastseen_n3 = 2 => 0.2588424437,
    _inq_adl_lastseen_n3 = 3 => 0.22172949,
    _inq_adl_lastseen_n3 = 4 => 0.1483050847,
    _inq_adl_lastseen_n3 = 5 => 0.1185495119,
    _inq_adl_lastseen_n3 = 6 => 0.0793854033,
                                0.0969957792);

_mth_source_edaca_lseen0_c := map(
    _mth_source_edaca_lseen0 = 1 => 0.0297029703,
    _mth_source_edaca_lseen0 = 2 => 0.0005925341,
                                    0.00116189);

_mth_source_edaca_fseen0_c := 0.00116189;

_mth_eda_dt_last_seen0_c := map(
    _mth_eda_dt_last_seen0 = 1 => 0.0176211454,
    _mth_eda_dt_last_seen0 = 2 => 0.0004051043,
                                  0.00116189);

_mth_eda_deletion_date0_c := map(
    _mth_eda_deletion_date0 = 1 => 0.008,
    _mth_eda_deletion_date0 = 2 => 0.0002203128,
                                   0.00116189);

_eda_days_in_service0_c := map(
    _eda_days_in_service0 = 1 => 0.0003944773,
    _eda_days_in_service0 = 2 => 0.0013895322,
    _eda_days_in_service0 = 3 => 0.0042553191,
                                 0.00116189);

_eda_num_phs_discon_addr0_c := 0.00116189;

_mth_source_edaca_lseen1_c := map(
    _mth_source_edaca_lseen1 = 0 => 0.1690140845,
    _mth_source_edaca_lseen1 = 1 => 0.1099099099,
    _mth_source_edaca_lseen1 = 2 => 0.0070810386,
                                    0.0519862678);

_mth_source_edahistory_lseen1_c := 0.0519862678;

_mth_eda_dt_first_seen1_c := 0.0519862678;

_eda_days_ind_first_seen1_c := map(
    _eda_days_ind_first_seen1 = 0 => 0.0452586207,
    _eda_days_ind_first_seen1 = 1 => 0.2045454545,
    _eda_days_ind_first_seen1 = 2 => 0.1388888889,
    _eda_days_ind_first_seen1 = 3 => 0.0776699029,
                                     0.0519862678);

_eda_days_ph_first_seen1_c := map(
    _eda_days_ph_first_seen1 = 1 => 0.1098901099,
    _eda_days_ph_first_seen1 = 2 => 0.0492813142,
                                    0.0519862678);

_eda_num_phs_connected_addr1_c := map(
    _eda_num_phs_connected_addr1 = 1 => 0.052578362,
    _eda_num_phs_connected_addr1 = 2 => 0.0327868852,
                                        0.0519862678);

_eda_num_phs_discon_hhid1_c := map(
    _eda_num_phs_discon_hhid1 = 0 => 0.067114094,
    _eda_num_phs_discon_hhid1 = 1 => 0.1147540984,
    _eda_num_phs_discon_hhid1 = 2 => 0.0302457467,
    _eda_num_phs_discon_hhid1 = 3 => 0.0274914089,
                                     0.0519862678);

_eda_avg_days_interrupt1_c := map(
    _eda_avg_days_interrupt1 = 1 => 0.0907801418,
    _eda_avg_days_interrupt1 = 2 => 0.0314842579,
                                    0.0519862678);

_mth_eda_dt_last_seen3_c := map(
    _mth_eda_dt_last_seen3 = 1 => 0.1636245111,
    _mth_eda_dt_last_seen3 = 2 => 0.0222222222,
                                  0.1455372371);

_mth_eda_deletion_date3_c := map(
    _mth_eda_deletion_date3 = 0 => 0.167003367,
    _mth_eda_deletion_date3 = 1 => 0.0303030303,
    _mth_eda_deletion_date3 = 2 => 0.0285714286,
                                   0.1455372371);

_eda_max_days_connected_ind3_c := map(
    _eda_max_days_connected_ind3 = 0 => 0.1332633788,
    _eda_max_days_connected_ind3 = 1 => 0.1126760563,
    _eda_max_days_connected_ind3 = 2 => 0.1358024691,
    _eda_max_days_connected_ind3 = 3 => 0.192575406,
                                        0.1455372371);

_eda_days_ind_first_seen3_c := map(
    _eda_days_ind_first_seen3 = 0 => 0.1102362205,
    _eda_days_ind_first_seen3 = 1 => 0.1940298507,
    _eda_days_ind_first_seen3 = 2 => 0.1565420561,
                                     0.1455372371);

_eda_days_ind_first_seen_w_ph3_c := map(
    _eda_days_ind_first_seen_w_ph3 = 0 => 0.1102362205,
    _eda_days_ind_first_seen_w_ph3 = 1 => 0.1629327902,
    _eda_days_ind_first_seen_w_ph3 = 2 => 0.1674565561,
                                          0.1455372371);

_eda_months_addr_last_seen3_c := map(
    _eda_months_addr_last_seen3 = 0 => 0.0997506234,
    _eda_months_addr_last_seen3 = 1 => 0.1851428571,
    _eda_months_addr_last_seen3 = 2 => 0.2156862745,
    _eda_months_addr_last_seen3 = 3 => 0.0967741935,
                                       0.1455372371);

_eda_num_phs_discon_hhid3_c := map(
    _eda_num_phs_discon_hhid3 = 0 => 0.1631205674,
    _eda_num_phs_discon_hhid3 = 1 => 0.146374829,
    _eda_num_phs_discon_hhid3 = 2 => 0.1515837104,
    _eda_num_phs_discon_hhid3 = 3 => 0.1325842697,
                                     0.1455372371);

_mth_source_edaca_lseen0_h := 0.0029515939;

_mth_source_edaca_fseen0_h := 0.0029515939;

_mth_eda_dt_last_seen0_h := map(
    _mth_eda_dt_last_seen0 = 1 => 0.0096618357,
    _mth_eda_dt_last_seen0 = 2 => 0.0026666667,
                                  0.0029515939);

_mth_eda_deletion_date0_h := map(
    _mth_eda_deletion_date0 = 1 => 0.0067885117,
    _mth_eda_deletion_date0 = 2 => 0.0024004201,
                                   0.0029515939);

_eda_days_in_service0_h := map(
    _eda_days_in_service0 = 1 => 0.0013142331,
    _eda_days_in_service0 = 2 => 0.0034182722,
    _eda_days_in_service0 = 3 => 0.0108243131,
                                 0.0029515939);

_eda_num_phs_discon_addr0_h := map(
    _eda_num_phs_discon_addr0 = 1 => 0.0050167224,
    _eda_num_phs_discon_addr0 = 2 => 0.0029980921,
    _eda_num_phs_discon_addr0 = 3 => 0.0018274112,
    _eda_num_phs_discon_addr0 = 4 => 0.00162206,
                                     0.0029515939);

_mth_source_edaca_lseen1_h := 0.0364945505;

_mth_source_edahistory_lseen1_h := map(
    _mth_source_edahistory_lseen1 = 0 => 0.0364139912,
    _mth_source_edahistory_lseen1 = 1 => 0.1017699115,
    _mth_source_edahistory_lseen1 = 2 => 0.03125,
    _mth_source_edahistory_lseen1 = 3 => 0.0070588235,
                                         0.0364945505);

_mth_eda_dt_first_seen1_h := map(
    _mth_eda_dt_first_seen1 = 1 => 0.0448116955,
    _mth_eda_dt_first_seen1 = 2 => 0.0356121653,
    _mth_eda_dt_first_seen1 = 3 => 0.0317045878,
    _mth_eda_dt_first_seen1 = 4 => 0.0346715328,
    _mth_eda_dt_first_seen1 = 5 => 0.0303951368,
                                   0.0364945505);

_eda_days_ind_first_seen1_h := map(
    _eda_days_ind_first_seen1 = 0 => 0.037677895,
    _eda_days_ind_first_seen1 = 1 => 0.0277777778,
    _eda_days_ind_first_seen1 = 2 => 0.0061349693,
    _eda_days_ind_first_seen1 = 3 => 0.0036764706,
                                     0.0364945505);

_eda_days_ph_first_seen1_h := map(
    _eda_days_ph_first_seen1 = 1 => 0.0346445327,
    _eda_days_ph_first_seen1 = 2 => 0.0367873872,
                                    0.0364945505);

_eda_num_phs_connected_addr1_h := map(
    _eda_num_phs_connected_addr1 = 1 => 0.0371054657,
    _eda_num_phs_connected_addr1 = 2 => 0.0214646465,
                                        0.0364945505);

_eda_num_phs_discon_hhid1_h := map(
    _eda_num_phs_discon_hhid1 = 0 => 0.0379867047,
    _eda_num_phs_discon_hhid1 = 1 => 0.0387567636,
    _eda_num_phs_discon_hhid1 = 2 => 0.0415335463,
    _eda_num_phs_discon_hhid1 = 3 => 0.027607362,
                                     0.0364945505);

_eda_avg_days_interrupt1_h := map(
    _eda_avg_days_interrupt1 = 1 => 0.0362,
    _eda_avg_days_interrupt1 = 2 => 0.0367811618,
                                    0.0364945505);

_mth_eda_dt_last_seen3_h := map(
    _mth_eda_dt_last_seen3 = 1 => 0.0672461116,
    _mth_eda_dt_last_seen3 = 2 => 0.0142510612,
                                  0.0353756382);

_mth_eda_deletion_date3_h := map(
    _mth_eda_deletion_date3 = 0 => 0.0722311396,
    _mth_eda_deletion_date3 = 1 => 0.0215285253,
    _mth_eda_deletion_date3 = 2 => 0.0145197319,
                                   0.0353756382);

_eda_max_days_connected_ind3_h := map(
    _eda_max_days_connected_ind3 = 0 => 0.0466904697,
    _eda_max_days_connected_ind3 = 1 => 0.0097560976,
    _eda_max_days_connected_ind3 = 2 => 0.0156402737,
                                        0.0353756382);

_eda_days_ind_first_seen3_h := map(
    _eda_days_ind_first_seen3 = 0 => 0.0465436519,
    _eda_days_ind_first_seen3 = 1 => 0.023364486,
    _eda_days_ind_first_seen3 = 2 => 0.0122025625,
                                     0.0353756382);

_eda_days_ind_first_seen_w_ph3_h := map(
    _eda_days_ind_first_seen_w_ph3 = 0 => 0.0465436519,
    _eda_days_ind_first_seen_w_ph3 = 1 => 0.0276008493,
    _eda_days_ind_first_seen_w_ph3 = 2 => 0.008683068,
                                          0.0353756382);

_eda_months_addr_last_seen3_h := map(
    _eda_months_addr_last_seen3 = 0 => 0.0330598456,
    _eda_months_addr_last_seen3 = 1 => 0.1265306122,
    _eda_months_addr_last_seen3 = 2 => 0.030995106,
    _eda_months_addr_last_seen3 = 3 => 0.0145228216,
                                       0.0353756382);

_eda_num_phs_discon_hhid3_h := map(
    _eda_num_phs_discon_hhid3 = 0 => 0.0511363636,
    _eda_num_phs_discon_hhid3 = 1 => 0.0479166667,
    _eda_num_phs_discon_hhid3 = 2 => 0.034643571,
    _eda_num_phs_discon_hhid3 = 3 => 0.0187025132,
                                     0.0353756382);

_mth_source_edaca_lseen0_n := 0;

_mth_source_edaca_fseen0_n := 0;

_mth_eda_dt_last_seen0_n := 0;

_mth_eda_deletion_date0_n := 0;

_eda_days_in_service0_n := 0;

_eda_num_phs_discon_addr0_n := 0;

_mth_source_edaca_lseen1_n := 0.0308247423;

_mth_source_edahistory_lseen1_n := 0.0308247423;

_mth_eda_dt_first_seen1_n := 0.0308247423;

_eda_days_ind_first_seen1_n := 0.0308247423;

_eda_days_ph_first_seen1_n := 0.0308247423;

_eda_num_phs_connected_addr1_n := 0.0308247423;

_eda_num_phs_discon_hhid1_n := 0.0308247423;

_eda_avg_days_interrupt1_n := 0.0308247423;

_mth_eda_dt_last_seen3_n := 0.1491735537;

_mth_eda_deletion_date3_n := 0.1491735537;

_eda_max_days_connected_ind3_n := 0.1491735537;

_eda_days_ind_first_seen3_n := 0.1491735537;

_eda_days_ind_first_seen_w_ph3_n := 0.1491735537;

_eda_months_addr_last_seen3_n := 0.1491735537;

_eda_num_phs_discon_hhid3_n := 0.1491735537;

_mth_source_ppca_fseen0_c := map(
    _mth_source_ppca_fseen0 = 0 => 0.0113812726,
    _mth_source_ppca_fseen0 = 1 => 0.0352941176,
    _mth_source_ppca_fseen0 = 2 => 0.005334914,
                                   0.0091767881);

_mth_source_ppdid_lseen0_c := map(
    _mth_source_ppdid_lseen0 = 0 => 0.0071343639,
    _mth_source_ppdid_lseen0 = 1 => 0.0078125,
    _mth_source_ppdid_lseen0 = 2 => 0.0142857143,
    _mth_source_ppdid_lseen0 = 3 => 0.0173410405,
    _mth_source_ppdid_lseen0 = 4 => 0.0184331797,
    _mth_source_ppdid_lseen0 = 5 => 0.0176056338,
    _mth_source_ppdid_lseen0 = 6 => 0.0138504155,
    _mth_source_ppdid_lseen0 = 7 => 0.0037974684,
                                    0.0091767881);

_mth_source_ppth_fseen0_c := 0.0091767881;

_mth_pp_datelastseen0_c := map(
    _mth_pp_datelastseen0 = 2 => 0.0134529148,
    _mth_pp_datelastseen0 = 3 => 0.0052056221,
                                 0.0091767881);

_mth_source_ppca_lseen1_c := map(
    _mth_source_ppca_lseen1 = 0 => 0.0508905852,
    _mth_source_ppca_lseen1 = 1 => 0.0836236934,
    _mth_source_ppca_lseen1 = 2 => 0.0492505353,
    _mth_source_ppca_lseen1 = 3 => 0.0108303249,
    _mth_source_ppca_lseen1 = 4 => 0.0081602374,
                                   0.0370535053);

_mth_source_ppdid_lseen1_c := map(
    _mth_source_ppdid_lseen1 = 0 => 0.0183743382,
    _mth_source_ppdid_lseen1 = 1 => 0.1083333333,
    _mth_source_ppdid_lseen1 = 2 => 0.1341991342,
    _mth_source_ppdid_lseen1 = 3 => 0.0867579909,
    _mth_source_ppdid_lseen1 = 4 => 0.0441860465,
    _mth_source_ppdid_lseen1 = 5 => 0.05,
    _mth_source_ppdid_lseen1 = 6 => 0.0354767184,
    _mth_source_ppdid_lseen1 = 7 => 0.0201005025,
                                    0.0370535053);

_mth_source_ppth_fseen1_c := 0.0370535053;

_mth_pp_first_build_date1_c := map(
    _mth_pp_first_build_date1 = 2 => 0.049112426,
    _mth_pp_first_build_date1 = 3 => 0.0288649706,
    _mth_pp_first_build_date1 = 4 => 0.0188964475,
                                     0.0370535053);

_pp_app_ind_ph_cnt1_c := map(
    _pp_app_ind_ph_cnt1 = 1 => 0.0420368364,
    _pp_app_ind_ph_cnt1 = 2 => 0.0274509804,
    _pp_app_ind_ph_cnt1 = 3 => 0.024504084,
                               0.0370535053);

_mth_source_ppca_lseen2_c := map(
    _mth_source_ppca_lseen2 = 0 => 0.0921052632,
    _mth_source_ppca_lseen2 = 1 => 0.0772200772,
    _mth_source_ppca_lseen2 = 2 => 0.0732265446,
    _mth_source_ppca_lseen2 = 3 => 0.042994811,
    _mth_source_ppca_lseen2 = 4 => 0.0201511335,
                                   0.0684678444);

_mth_source_ppdid_lseen2_c := map(
    _mth_source_ppdid_lseen2 = 0 => 0.0402899169,
    _mth_source_ppdid_lseen2 = 1 => 0.1991341991,
    _mth_source_ppdid_lseen2 = 2 => 0.1896551724,
    _mth_source_ppdid_lseen2 = 3 => 0.1350531108,
    _mth_source_ppdid_lseen2 = 4 => 0.0877192982,
    _mth_source_ppdid_lseen2 = 5 => 0.0835073069,
    _mth_source_ppdid_lseen2 = 6 => 0.0731182796,
    _mth_source_ppdid_lseen2 = 7 => 0.029375765,
                                    0.0684678444);

_mth_source_ppth_fseen2_c := 0.0684678444;

_pp_agegroup2_c := map(
    _pp_agegroup2 = 0 => 0.0707821991,
    _pp_agegroup2 = 1 => 0.0486891386,
    _pp_agegroup2 = 2 => 0.0275229358,
                         0.0684678444);

_mth_source_ppca_fseen3_c := map(
    _mth_source_ppca_fseen3 = 0 => 0.1190629701,
    _mth_source_ppca_fseen3 = 1 => 0.2085714286,
    _mth_source_ppca_fseen3 = 2 => 0.2112676056,
    _mth_source_ppca_fseen3 = 3 => 0.1531531532,
    _mth_source_ppca_fseen3 = 4 => 0.1007556675,
                                   0.1277981958);

_mth_source_ppdid_lseen3_c := map(
    _mth_source_ppdid_lseen3 = 0 => 0.1117021277,
    _mth_source_ppdid_lseen3 = 1 => 0.2181208054,
    _mth_source_ppdid_lseen3 = 2 => 0.167816092,
    _mth_source_ppdid_lseen3 = 3 => 0.1453790239,
    _mth_source_ppdid_lseen3 = 4 => 0.1343638526,
    _mth_source_ppdid_lseen3 = 5 => 0.1006289308,
    _mth_source_ppdid_lseen3 = 6 => 0.0811287478,
    _mth_source_ppdid_lseen3 = 7 => 0.0593311758,
                                    0.1277981958);

_mth_pp_eda_hist_ph_dt3_c := map(
    _mth_pp_eda_hist_ph_dt3 = 0 => 0.1671841414,
    _mth_pp_eda_hist_ph_dt3 = 1 => 0.036131184,
                                   0.1277981958);

_mth_pp_first_build_date3_c := map(
    _mth_pp_first_build_date3 = 1 => 0.1452122855,
    _mth_pp_first_build_date3 = 2 => 0.0788690476,
    _mth_pp_first_build_date3 = 3 => 0.0778781038,
                                     0.1277981958);

_pp_max_orig_conf_score3_c := map(
    _pp_max_orig_conf_score3 = 1 => 0.1521499449,
    _pp_max_orig_conf_score3 = 2 => 0.1234494979,
                                    0.1277981958);

_pp_app_fb_ph3_c := map(
    _pp_app_fb_ph3 = 0 => 0.2142857143,
    _pp_app_fb_ph3 = 1 => 0.1764705882,
    _pp_app_fb_ph3 = 2 => 0.124322434,
                          0.1277981958);

_pp_app_ind_ph_cnt3_c := map(
    _pp_app_ind_ph_cnt3 = 1 => 0.1331043366,
    _pp_app_ind_ph_cnt3 = 2 => 0.1203178207,
    _pp_app_ind_ph_cnt3 = 3 => 0.0872483221,
                               0.1277981958);

_mth_source_ppca_fseen0_h := 0.0010354489;

_mth_source_ppdid_lseen0_h := 0.0010354489;

_mth_source_ppth_fseen0_h := map(
    _mth_source_ppth_fseen0 = 0 => 0.0008172605,
    _mth_source_ppth_fseen0 = 1 => 0.0011650485,
                                   0.0010354489);

_mth_pp_datelastseen0_h := map(
    _mth_pp_datelastseen0 = 2 => 0.0024207746,
    _mth_pp_datelastseen0 = 3 => 0.0005053057,
                                 0.0010354489);

_mth_source_ppca_lseen1_h := 0.0225070334;

_mth_source_ppdid_lseen1_h := 0.0225070334;

_mth_source_ppth_fseen1_h := map(
    _mth_source_ppth_fseen1 = 0 => 0.0311457175,
    _mth_source_ppth_fseen1 = 1 => 0.0555555556,
    _mth_source_ppth_fseen1 = 2 => 0.0438871473,
    _mth_source_ppth_fseen1 = 3 => 0.0344827586,
    _mth_source_ppth_fseen1 = 4 => 0.0202702703,
    _mth_source_ppth_fseen1 = 5 => 0.0051369863,
                                   0.0225070334);

_mth_pp_first_build_date1_h := map(
    _mth_pp_first_build_date1 = 0 => 0.0360750361,
    _mth_pp_first_build_date1 = 1 => 0.0329861111,
    _mth_pp_first_build_date1 = 2 => 0.014507772,
                                     0.0225070334);

_pp_app_ind_ph_cnt1_h := map(
    _pp_app_ind_ph_cnt1 = 0 => 0.0360750361,
    _pp_app_ind_ph_cnt1 = 1 => 0.0206013363,
    _pp_app_ind_ph_cnt1 = 2 => 0.0175438596,
    _pp_app_ind_ph_cnt1 = 3 => 0.0078740157,
                               0.0225070334);

_mth_source_ppca_lseen2_h := 0.0202517789;

_mth_source_ppdid_lseen2_h := 0.0202517789;

_mth_source_ppth_fseen2_h := map(
    _mth_source_ppth_fseen2 = 0 => 0.0238095238,
    _mth_source_ppth_fseen2 = 1 => 0.0666666667,
    _mth_source_ppth_fseen2 = 2 => 0.0265306122,
    _mth_source_ppth_fseen2 = 3 => 0.0122180451,
                                   0.0202517789);

_pp_agegroup2_h := map(
    _pp_agegroup2 = 0 => 0.0209656925,
    _pp_agegroup2 = 1 => 0.0158102767,
                         0.0202517789);

_mth_source_ppca_fseen3_h := 0.0275884453;

_mth_source_ppdid_lseen3_h := 0.0275884453;

_mth_pp_eda_hist_ph_dt3_h := map(
    _mth_pp_eda_hist_ph_dt3 = 0 => 0.0791075051,
    _mth_pp_eda_hist_ph_dt3 = 1 => 0.0033412888,
                                   0.0275884453);

_mth_pp_first_build_date3_h := map(
    _mth_pp_first_build_date3 = 0 => 0.120593692,
    _mth_pp_first_build_date3 = 1 => 0.0166112957,
    _mth_pp_first_build_date3 = 2 => 0.0051546392,
                                     0.0275884453);

_pp_max_orig_conf_score3_h := map(
    _pp_max_orig_conf_score3 = 1 => 0.034965035,
    _pp_max_orig_conf_score3 = 2 => 0.0272294078,
                                    0.0275884453);

_pp_app_fb_ph3_h := map(
    _pp_app_fb_ph3 = 0 => 0.0377358491,
    _pp_app_fb_ph3 = 1 => 0.0303030303,
    _pp_app_fb_ph3 = 2 => 0.0273789649,
                          0.0275884453);

_pp_app_ind_ph_cnt3_h := map(
    _pp_app_ind_ph_cnt3 = 0 => 0.120593692,
    _pp_app_ind_ph_cnt3 = 1 => 0.0090433127,
    _pp_app_ind_ph_cnt3 = 2 => 0.0032258065,
    _pp_app_ind_ph_cnt3 = 3 => 0,
                               0.0275884453);

_mth_source_ppca_fseen0_n := 0;

_mth_source_ppdid_lseen0_n := 0;

_mth_source_ppth_fseen0_n := 0;

_mth_pp_datelastseen0_n := 0;

_mth_source_ppca_lseen1_n := 0.0372904395;

_mth_source_ppdid_lseen1_n := 0.0372904395;

_mth_source_ppth_fseen1_n := 0.0372904395;

_mth_pp_first_build_date1_n := 0.0372904395;

_pp_app_ind_ph_cnt1_n := 0.0372904395;

_mth_source_ppca_fseen3_n := 0.1067639257;

_mth_source_ppdid_lseen3_n := 0.1067639257;

_mth_pp_eda_hist_ph_dt3_n := 0.1067639257;

_mth_pp_first_build_date3_n := 0.1067639257;

_pp_max_orig_conf_score3_n := 0.1067639257;

_pp_app_fb_ph3_n := 0.1067639257;

_pp_app_ind_ph_cnt3_n := 0.1067639257;

_mth_source_ppca_lseen2_n := 0;

_mth_source_ppdid_lseen2_n := 0;

_mth_source_ppth_fseen2_n := 0;

_pp_agegroup2_n := 0;

_mth_eda_deletion_date3_m := map(
    pk_eda_hit = 1 and source_eda_any_clean = 1 => _mth_eda_deletion_date3_c,
    pk_eda_hit = 1 and source_eda_any_clean = 0 => _mth_eda_deletion_date3_h,
                                                   _mth_eda_deletion_date3_n);

_eda_days_ind_first_seen_w_ph3_m := map(
    pk_eda_hit = 1 and source_eda_any_clean = 1 => _eda_days_ind_first_seen_w_ph3_c,
    pk_eda_hit = 1 and source_eda_any_clean = 0 => _eda_days_ind_first_seen_w_ph3_h,
                                                   _eda_days_ind_first_seen_w_ph3_n);

_eda_num_phs_discon_addr0_m := map(
    pk_eda_hit = 1 and source_eda_any_clean = 1 => _eda_num_phs_discon_addr0_c,
    pk_eda_hit = 1 and source_eda_any_clean = 0 => _eda_num_phs_discon_addr0_h,
                                                   _eda_num_phs_discon_addr0_n);

_mth_source_edaca_fseen0_m := map(
    pk_eda_hit = 1 and source_eda_any_clean = 1 => _mth_source_edaca_fseen0_c,
    pk_eda_hit = 1 and source_eda_any_clean = 0 => _mth_source_edaca_fseen0_h,
                                                   _mth_source_edaca_fseen0_n);

_mth_source_edaca_lseen0_m := map(
    pk_eda_hit = 1 and source_eda_any_clean = 1 => _mth_source_edaca_lseen0_c,
    pk_eda_hit = 1 and source_eda_any_clean = 0 => _mth_source_edaca_lseen0_h,
                                                   _mth_source_edaca_lseen0_n);

_mth_eda_deletion_date0_m := map(
    pk_eda_hit = 1 and source_eda_any_clean = 1 => _mth_eda_deletion_date0_c,
    pk_eda_hit = 1 and source_eda_any_clean = 0 => _mth_eda_deletion_date0_h,
                                                   _mth_eda_deletion_date0_n);

_eda_months_addr_last_seen3_m := map(
    pk_eda_hit = 1 and source_eda_any_clean = 1 => _eda_months_addr_last_seen3_c,
    pk_eda_hit = 1 and source_eda_any_clean = 0 => _eda_months_addr_last_seen3_h,
                                                   _eda_months_addr_last_seen3_n);

_mth_source_edahistory_lseen1_m := map(
    pk_eda_hit = 1 and source_eda_any_clean = 1 => _mth_source_edahistory_lseen1_c,
    pk_eda_hit = 1 and source_eda_any_clean = 0 => _mth_source_edahistory_lseen1_h,
                                                   _mth_source_edahistory_lseen1_n);

_eda_days_in_service0_m := map(
    pk_eda_hit = 1 and source_eda_any_clean = 1 => _eda_days_in_service0_c,
    pk_eda_hit = 1 and source_eda_any_clean = 0 => _eda_days_in_service0_h,
                                                   _eda_days_in_service0_n);

_mth_source_edaca_lseen1_m := map(
    pk_eda_hit = 1 and source_eda_any_clean = 1 => _mth_source_edaca_lseen1_c,
    pk_eda_hit = 1 and source_eda_any_clean = 0 => _mth_source_edaca_lseen1_h,
                                                   _mth_source_edaca_lseen1_n);

_eda_num_phs_discon_hhid3_m := map(
    pk_eda_hit = 1 and source_eda_any_clean = 1 => _eda_num_phs_discon_hhid3_c,
    pk_eda_hit = 1 and source_eda_any_clean = 0 => _eda_num_phs_discon_hhid3_h,
                                                   _eda_num_phs_discon_hhid3_n);

_mth_eda_dt_first_seen1_m := map(
    pk_eda_hit = 1 and source_eda_any_clean = 1 => _mth_eda_dt_first_seen1_c,
    pk_eda_hit = 1 and source_eda_any_clean = 0 => _mth_eda_dt_first_seen1_h,
                                                   _mth_eda_dt_first_seen1_n);

_eda_num_phs_discon_hhid1_m := map(
    pk_eda_hit = 1 and source_eda_any_clean = 1 => _eda_num_phs_discon_hhid1_c,
    pk_eda_hit = 1 and source_eda_any_clean = 0 => _eda_num_phs_discon_hhid1_h,
                                                   _eda_num_phs_discon_hhid1_n);

_eda_avg_days_interrupt1_m := map(
    pk_eda_hit = 1 and source_eda_any_clean = 1 => _eda_avg_days_interrupt1_c,
    pk_eda_hit = 1 and source_eda_any_clean = 0 => _eda_avg_days_interrupt1_h,
                                                   _eda_avg_days_interrupt1_n);

_eda_days_ph_first_seen1_m := map(
    pk_eda_hit = 1 and source_eda_any_clean = 1 => _eda_days_ph_first_seen1_c,
    pk_eda_hit = 1 and source_eda_any_clean = 0 => _eda_days_ph_first_seen1_h,
                                                   _eda_days_ph_first_seen1_n);

_mth_eda_dt_last_seen3_m := map(
    pk_eda_hit = 1 and source_eda_any_clean = 1 => _mth_eda_dt_last_seen3_c,
    pk_eda_hit = 1 and source_eda_any_clean = 0 => _mth_eda_dt_last_seen3_h,
                                                   _mth_eda_dt_last_seen3_n);

_eda_days_ind_first_seen3_m := map(
    pk_eda_hit = 1 and source_eda_any_clean = 1 => _eda_days_ind_first_seen3_c,
    pk_eda_hit = 1 and source_eda_any_clean = 0 => _eda_days_ind_first_seen3_h,
                                                   _eda_days_ind_first_seen3_n);

_eda_max_days_connected_ind3_m := map(
    pk_eda_hit = 1 and source_eda_any_clean = 1 => _eda_max_days_connected_ind3_c,
    pk_eda_hit = 1 and source_eda_any_clean = 0 => _eda_max_days_connected_ind3_h,
                                                   _eda_max_days_connected_ind3_n);

_eda_days_ind_first_seen1_m := map(
    pk_eda_hit = 1 and source_eda_any_clean = 1 => _eda_days_ind_first_seen1_c,
    pk_eda_hit = 1 and source_eda_any_clean = 0 => _eda_days_ind_first_seen1_h,
                                                   _eda_days_ind_first_seen1_n);

_eda_num_phs_connected_addr1_m := map(
    pk_eda_hit = 1 and source_eda_any_clean = 1 => _eda_num_phs_connected_addr1_c,
    pk_eda_hit = 1 and source_eda_any_clean = 0 => _eda_num_phs_connected_addr1_h,
                                                   _eda_num_phs_connected_addr1_n);

_mth_eda_dt_last_seen0_m := map(
    pk_eda_hit = 1 and source_eda_any_clean = 1 => _mth_eda_dt_last_seen0_c,
    pk_eda_hit = 1 and source_eda_any_clean = 0 => _mth_eda_dt_last_seen0_h,
                                                   _mth_eda_dt_last_seen0_n);

_mth_source_ppca_fseen0_m := map(
    pk_pp_hit = 1 and source_pp_any_clean = 1 => _mth_source_ppca_fseen0_c,
    pk_pp_hit = 1 and source_pp_any_clean = 0 => _mth_source_ppca_fseen0_h,
                                                 _mth_source_ppca_fseen0_n);

_mth_source_ppdid_lseen0_m := map(
    pk_pp_hit = 1 and source_pp_any_clean = 1 => _mth_source_ppdid_lseen0_c,
    pk_pp_hit = 1 and source_pp_any_clean = 0 => _mth_source_ppdid_lseen0_h,
                                                 _mth_source_ppdid_lseen0_n);

_mth_source_ppca_lseen1_m := map(
    pk_pp_hit = 1 and source_pp_any_clean = 1 => _mth_source_ppca_lseen1_c,
    pk_pp_hit = 1 and source_pp_any_clean = 0 => _mth_source_ppca_lseen1_h,
                                                 _mth_source_ppca_lseen1_n);

_pp_agegroup2_m := map(
    pk_pp_hit = 1 and source_pp_any_clean = 1 => _pp_agegroup2_c,
    pk_pp_hit = 1 and source_pp_any_clean = 0 => _pp_agegroup2_h,
                                                 _pp_agegroup2_n);

_mth_source_ppdid_lseen3_m := map(
    pk_pp_hit = 1 and source_pp_any_clean = 1 => _mth_source_ppdid_lseen3_c,
    pk_pp_hit = 1 and source_pp_any_clean = 0 => _mth_source_ppdid_lseen3_h,
                                                 _mth_source_ppdid_lseen3_n);

_mth_source_ppdid_lseen2_m := map(
    pk_pp_hit = 1 and source_pp_any_clean = 1 => _mth_source_ppdid_lseen2_c,
    pk_pp_hit = 1 and source_pp_any_clean = 0 => _mth_source_ppdid_lseen2_h,
                                                 _mth_source_ppdid_lseen2_n);

_mth_source_ppth_fseen2_m := map(
    pk_pp_hit = 1 and source_pp_any_clean = 1 => _mth_source_ppth_fseen2_c,
    pk_pp_hit = 1 and source_pp_any_clean = 0 => _mth_source_ppth_fseen2_h,
                                                 _mth_source_ppth_fseen2_n);

_mth_pp_first_build_date1_m := map(
    pk_pp_hit = 1 and source_pp_any_clean = 1 => _mth_pp_first_build_date1_c,
    pk_pp_hit = 1 and source_pp_any_clean = 0 => _mth_pp_first_build_date1_h,
                                                 _mth_pp_first_build_date1_n);

_pp_app_ind_ph_cnt3_m := map(
    pk_pp_hit = 1 and source_pp_any_clean = 1 => _pp_app_ind_ph_cnt3_c,
    pk_pp_hit = 1 and source_pp_any_clean = 0 => _pp_app_ind_ph_cnt3_h,
                                                 _pp_app_ind_ph_cnt3_n);

_mth_source_ppca_lseen2_m := map(
    pk_pp_hit = 1 and source_pp_any_clean = 1 => _mth_source_ppca_lseen2_c,
    pk_pp_hit = 1 and source_pp_any_clean = 0 => _mth_source_ppca_lseen2_h,
                                                 _mth_source_ppca_lseen2_n);

_mth_pp_first_build_date3_m := map(
    pk_pp_hit = 1 and source_pp_any_clean = 1 => _mth_pp_first_build_date3_c,
    pk_pp_hit = 1 and source_pp_any_clean = 0 => _mth_pp_first_build_date3_h,
                                                 _mth_pp_first_build_date3_n);

_mth_pp_datelastseen0_m := map(
    pk_pp_hit = 1 and source_pp_any_clean = 1 => _mth_pp_datelastseen0_c,
    pk_pp_hit = 1 and source_pp_any_clean = 0 => _mth_pp_datelastseen0_h,
                                                 _mth_pp_datelastseen0_n);

_mth_pp_eda_hist_ph_dt3_m := map(
    pk_pp_hit = 1 and source_pp_any_clean = 1 => _mth_pp_eda_hist_ph_dt3_c,
    pk_pp_hit = 1 and source_pp_any_clean = 0 => _mth_pp_eda_hist_ph_dt3_h,
                                                 _mth_pp_eda_hist_ph_dt3_n);

_pp_max_orig_conf_score3_m := map(
    pk_pp_hit = 1 and source_pp_any_clean = 1 => _pp_max_orig_conf_score3_c,
    pk_pp_hit = 1 and source_pp_any_clean = 0 => _pp_max_orig_conf_score3_h,
                                                 _pp_max_orig_conf_score3_n);

_pp_app_fb_ph3_m := map(
    pk_pp_hit = 1 and source_pp_any_clean = 1 => _pp_app_fb_ph3_c,
    pk_pp_hit = 1 and source_pp_any_clean = 0 => _pp_app_fb_ph3_h,
                                                 _pp_app_fb_ph3_n);

_mth_source_ppdid_lseen1_m := map(
    pk_pp_hit = 1 and source_pp_any_clean = 1 => _mth_source_ppdid_lseen1_c,
    pk_pp_hit = 1 and source_pp_any_clean = 0 => _mth_source_ppdid_lseen1_h,
                                                 _mth_source_ppdid_lseen1_n);

_mth_source_ppca_fseen3_m := map(
    pk_pp_hit = 1 and source_pp_any_clean = 1 => _mth_source_ppca_fseen3_c,
    pk_pp_hit = 1 and source_pp_any_clean = 0 => _mth_source_ppca_fseen3_h,
                                                 _mth_source_ppca_fseen3_n);

_mth_source_ppth_fseen1_m := map(
    pk_pp_hit = 1 and source_pp_any_clean = 1 => _mth_source_ppth_fseen1_c,
    pk_pp_hit = 1 and source_pp_any_clean = 0 => _mth_source_ppth_fseen1_h,
                                                 _mth_source_ppth_fseen1_n);

_pp_app_ind_ph_cnt1_m := map(
    pk_pp_hit = 1 and source_pp_any_clean = 1 => _pp_app_ind_ph_cnt1_c,
    pk_pp_hit = 1 and source_pp_any_clean = 0 => _pp_app_ind_ph_cnt1_h,
                                                 _pp_app_ind_ph_cnt1_n);

_mth_source_ppth_fseen0_m := map(
    pk_pp_hit = 1 and source_pp_any_clean = 1 => _mth_source_ppth_fseen0_c,
    pk_pp_hit = 1 and source_pp_any_clean = 0 => _mth_source_ppth_fseen0_h,
                                                 _mth_source_ppth_fseen0_n);

mod_pp_rule_s0_2 := -6.713238214 +
    _pp_rule_non_pub * 1.4880735598 +
    _pp_rule_port_neustar * 2.9154733263 +
    _pp_rule_high_vend_conf * 1.1025447633 +
    _pp_rule_consort_rpc * 3.3487114206 +
    _pp_rule_iq_rpc * 1.9813284419 +
    _pp_rule_f1_ver_below * 1.5092870966;

mod_pp_rule_s0_1 := exp(mod_pp_rule_s0_2) / (1 + exp(mod_pp_rule_s0_2));

mod_pp_rule_s0 := round(100 * mod_pp_rule_s0_1/.001)*.001;

mod_pp_rule_s1_2 := -3.31589291 +
    _pp_rule_iq_rpc * 0.9407517158 +
    _pp_rule_f1_ver_above * -0.636347802;

mod_pp_rule_s1_1 := exp(mod_pp_rule_s1_2) / (1 + exp(mod_pp_rule_s1_2));

mod_pp_rule_s1 := round(100 * mod_pp_rule_s1_1/.001)*.001;

mod_pp_rule_s2_2 := -3.39247567 +
    _pp_rule_high_vend_conf * 1.4544625156 +
    _pp_rule_cellphone_latest * 0.5431172628 +
    _pp_rule_source_latest * 0.2920377501 +
    _pp_rule_med_vend_conf_cell * -0.90071942 +
    _pp_rule_iq_rpc * 0.3491961917 +
    _pp_rule_ins_ver_above * 0.585346301 +
    _pp_rule_f1_ver_above * -0.847150716;

mod_pp_rule_s2_1 := exp(mod_pp_rule_s2_2) / (1 + exp(mod_pp_rule_s2_2));

mod_pp_rule_s2 := round(100 * mod_pp_rule_s2_1/.001)*.001;

mod_pp_rule_s3_2 := -2.424996118 +
    _pp_rule_disconnected_eda * -1.834549207 +
    _pp_rule_port_neustar * 1.1639444057 +
    _pp_rule_high_vend_conf * 0.4858258518 +
    _pp_rule_low_vend_conf * -0.444309207 +
    _pp_rule_cellphone_latest * 0.3494991085 +
    _pp_rule_iq_rpc * 0.468385111 +
    _pp_rule_f1_ver_above * 0.5002185508;

mod_pp_rule_s3_1 := exp(mod_pp_rule_s3_2) / (1 + exp(mod_pp_rule_s3_2));

mod_pp_rule_s3 := round(100 * mod_pp_rule_s3_1/.001)*.001;

mod_pp_src_s0_2 := -6.336938779 +
    _pp_src_all_wp * 1.5205092864 +
    _pp_src_all_cy * 1.495398093 +
    _pp_src_all_eb * 4.1834255776 +
    _pp_src_all_iq * 0.9351740916;

mod_pp_src_s0_1 := exp(mod_pp_src_s0_2) / (1 + exp(mod_pp_src_s0_2));

mod_pp_src_s0 := round(100 * mod_pp_src_s0_1/.001)*.001;

mod_pp_src_s1_2 := -3.253476826 +
    _pp_src_all_ir * -0.748794067 +
    _pp_src_all_02 * -2.455526883 +
    _pp_src_all_pn * -2.294969821 +
    _pp_src_all_eq * -1.681473114 +
    _pp_src_all_ib * 0.4810014899;

mod_pp_src_s1_1 := exp(mod_pp_src_s1_2) / (1 + exp(mod_pp_src_s1_2));

mod_pp_src_s1 := round(100 * mod_pp_src_s1_1/.001)*.001;

mod_pp_src_s2_2 := -3.055165725 +
    _pp_src_all_ut * 0.3393959224 +
    _pp_src_all_uw * 0.8365406412 +
    _pp_src_all_iq * 0.5207491133;

mod_pp_src_s2_1 := exp(mod_pp_src_s2_2) / (1 + exp(mod_pp_src_s2_2));

mod_pp_src_s2 := round(100 * mod_pp_src_s2_1/.001)*.001;

mod_pp_src_s3_2 := -2.23931889 +
    _pp_src_all_01 * 1.0338600585 +
    _pp_src_all_05 * 14.31846759 +
    _pp_src_all_pn * -1.619556141 +
    _pp_src_all_go * -1.243915014 +
    _pp_src_all_eq * -0.772246442 +
    _pp_src_all_ut * 0.2992601252 +
    _pp_src_all_uw * 0.6905713113 +
    _pp_src_all_en * -1.058636793 +
    _pp_src_all_iq * 0.3464693845;

mod_pp_src_s3_1 := exp(mod_pp_src_s3_2) / (1 + exp(mod_pp_src_s3_2));

mod_pp_src_s3 := round(100 * mod_pp_src_s3_1/.001)*.001;

mod_inq_industry_s0_2 := -6.009107982 + _inq_adl_ph_industry_comm * 4.2174095552;

mod_inq_industry_s0_1 := exp(mod_inq_industry_s0_2) / (1 + exp(mod_inq_industry_s0_2));

mod_inq_industry_s0 := round(100 * mod_inq_industry_s0_1/.001)*.001;

mod_inq_industry_s1_2 := -3.322713653 +
    _inq_adl_ph_industry_auto * 2.6285566694 +
    _inq_adl_ph_industry_cards * 1.503563164 +
    _inq_adl_ph_industry_coll * 4.709008014 +
    _inq_adl_ph_industry_comm * 2.1743621445 +
    _inq_adl_ph_industry_firm * 15.753480946 +
    _inq_adl_ph_industry_invest * 15.753480946 +
    _inq_adl_ph_industry_util * 15.753480946;

mod_inq_industry_s1_1 := exp(mod_inq_industry_s1_2) / (1 + exp(mod_inq_industry_s1_2));

mod_inq_industry_s1 := round(100 * mod_inq_industry_s1_1/.001)*.001;

mod_eda_current_s0_2 := -7.062431408 +
    _eda_is_discon_15_days * 3.9922007317 +
    _eda_num_interrupts_cur * -2.708182118 +
    _mth_source_edaca_lseen0_m * 88.453129438 +
    _mth_eda_deletion_date0_m * 445.11062295;

mod_eda_current_s0_1 := exp(mod_eda_current_s0_2) / (1 + exp(mod_eda_current_s0_2));

mod_eda_current_s0 := round(100 * mod_eda_current_s0_1/.001)*.001;

mod_eda_current_s1_2 := -6.621939012 +
    source_edala * -0.888559515 +
    _eda_min_days_connected_ind * -0.757570508 +
    _eda_address_match_best * 0.4461496942 +
    _eda_has_cur_discon_60_days * 0.8294547217 +
    _mth_source_edaca_lseen1_m * 22.090648672 +
    _eda_num_phs_discon_hhid1_m * 8.1933902287 +
    _eda_avg_days_interrupt1_m * 11.643954445;

mod_eda_current_s1_1 := exp(mod_eda_current_s1_2) / (1 + exp(mod_eda_current_s1_2));

mod_eda_current_s1 := round(100 * mod_eda_current_s1_1/.001)*.001;

mod_eda_current_s3_2 := -4.414282942 +
    source_edahistory * -0.78805261 +
    _eda_did_flag * -1.360943508 +
    _eda_address_match_best * 0.4704310305 +
    _eda_has_cur_discon_180_days * 0.3532934905 +
    _mth_eda_deletion_date3_m * 11.829905553 +
    _eda_max_days_connected_ind3_m * 5.9502779898 +
    _eda_days_ind_first_seen3_m * 5.6020795234;

mod_eda_current_s3_1 := exp(mod_eda_current_s3_2) / (1 + exp(mod_eda_current_s3_2));

mod_eda_current_s3 := round(100 * mod_eda_current_s3_1/.001)*.001;

mod_eda_historical_s0_2 := -7.850111239 +
    _mth_eda_dt_last_seen0_m * 149.96652097 +
    _eda_days_in_service0_m * 164.23826402 +
    _eda_num_phs_discon_addr0_m * 280.5331374;

mod_eda_historical_s0_1 := exp(mod_eda_historical_s0_2) / (1 + exp(mod_eda_historical_s0_2));

mod_eda_historical_s0 := round(100 * mod_eda_historical_s0_1/.001)*.001;

mod_eda_historical_s1_2 := -13.60521749 +
    _eda_address_match_best * 0.5914932959 +
    _eda_is_discon_180_days * -12.96917789 +
    _mth_source_edahistory_lseen1_m * 15.744128896 +
    _mth_eda_dt_first_seen1_m * 40.591300102 +
    _eda_days_ind_first_seen1_m * 26.295890092 +
    _eda_days_ph_first_seen1_m * 122.71147198 +
    _eda_num_phs_connected_addr1_m * 46.277762047 +
    _eda_num_phs_discon_hhid1_m * 29.757742605;

mod_eda_historical_s1_1 := exp(mod_eda_historical_s1_2) / (1 + exp(mod_eda_historical_s1_2));

mod_eda_historical_s1 := round(100 * mod_eda_historical_s1_1/.001)*.001;

mod_eda_historical_s3_2 := -6.537820448 +
    _mth_eda_dt_last_seen3_m * 16.101382239 +
    _mth_eda_deletion_date3_m * 7.7318618511 +
    _eda_days_ind_first_seen_w_ph3_m * 25.357331121 +
    _eda_months_addr_last_seen3_m * 9.2084609849 +
    _eda_num_phs_discon_hhid3_m * 20.895859131;

mod_eda_historical_s3_1 := exp(mod_eda_historical_s3_2) / (1 + exp(mod_eda_historical_s3_2));

mod_eda_historical_s3 := round(100 * mod_eda_historical_s3_1/.001)*.001;

mod_eda3_s0 := map(
    pk_eda_hit = 1 and source_eda_any_clean = 1 => mod_eda_current_s0,
    pk_eda_hit = 1 and source_eda_any_clean = 0 => mod_eda_historical_s0,
                                                   0);

mod_eda3_s1 := map(
    pk_eda_hit = 1 and source_eda_any_clean = 1 => mod_eda_current_s1,
    pk_eda_hit = 1 and source_eda_any_clean = 0 => mod_eda_historical_s1,
                                                   3.1);

mod_eda3_s3 := map(
    pk_eda_hit = 1 and source_eda_any_clean = 1 => mod_eda_current_s3,
    pk_eda_hit = 1 and source_eda_any_clean = 0 => mod_eda_historical_s3,
                                                   14.9);

mod_exp_s3_2 := -11.80406734 +
    source_exp * -0.656746751 +
    _mth_source_exp_fseen3_m * 21.266016268 +
    _mth_exp_last_update3_m * 10.338441193 +
    _exp_type3_m * 12.623730922 +
    _exp_source3_m * 52.078240792;

mod_exp_s3_1 := exp(mod_exp_s3_2) / (1 + exp(mod_exp_s3_2));

mod_exp_s3 := round(100 * mod_exp_s3_1/.001)*.001;

mod_inq_s0_2 := -6.709022049 +
    mod_inq_industry_s0 * 0.2107879436 +
    _inq_firstseen_n0_m * 69.904893395 +
    _inq_lastseen_n0_m * 84.92581431;

mod_inq_s0_1 := exp(mod_inq_s0_2) / (1 + exp(mod_inq_s0_2));

mod_inq_s0 := round(100 * mod_inq_s0_1/.001)*.001;

mod_inq_s1_2 := -4.41404238 +
    mod_inq_industry_s1 * 0.0490964129 +
    _inq_lastseen_n1_m * 15.975057743 +
    _inq_adl_firstseen_n1_m * 5.9834283151 +
    _inq_adl_lastseen_n1_m * 3.3583926877;

mod_inq_s1_1 := exp(mod_inq_s1_2) / (1 + exp(mod_inq_s1_2));

mod_inq_s1 := round(100 * mod_inq_s1_1/.001)*.001;

mod_inq_s2_2 := -3.724222826 +
    _inq_firstseen_n2_m * 6.8954522387 +
    _inq_adl_lastseen_n2_m * 8.3130371788;

mod_inq_s2_1 := exp(mod_inq_s2_2) / (1 + exp(mod_inq_s2_2));

mod_inq_s2 := round(100 * mod_inq_s2_1/.001)*.001;

mod_inq_s3_2 := -3.288543243 +
    _inq_lastseen_n3_m * 3.7407828437 +
    _inq_adl_lastseen_n3_m * 6.2727161729;

mod_inq_s3_1 := exp(mod_inq_s3_2) / (1 + exp(mod_inq_s3_2));

mod_inq_s3 := round(100 * mod_inq_s3_1/.001)*.001;

mod_pfb_s0_2 := -7.240134364 +
    _mth_phone_fb_last_rpc_date0_m * 114.74462436 +
    _phone_fb_result0_m * 129.48740498 +
    _phone_fb_rp_result0_m * 234.04943635;

mod_pfb_s0_1 := exp(mod_pfb_s0_2) / (1 + exp(mod_pfb_s0_2));

mod_pfb_s0 := round(100 * mod_pfb_s0_1/.001)*.001;

mod_pfb_s1_2 := -6.308873527 +
    _phone_fb_result1_m * 54.191984086 +
    _phone_fb_rp_result1_m * 29.747480186;

mod_pfb_s1_1 := exp(mod_pfb_s1_2) / (1 + exp(mod_pfb_s1_2));

mod_pfb_s1 := round(100 * mod_pfb_s1_1/.001)*.001;

mod_pfb_s3_2 := -7.504566277 +
    source_pf * -0.622207442 +
    _mth_phone_fb_last_rpc_date3_m * 11.894017072 +
    _mth_phone_fb_rp_date3_m * 13.521316032 +
    _phone_fb_result3_m * 16.359670199 +
    _phone_fb_rp_result3_m * 12.219577181;

mod_pfb_s3_1 := exp(mod_pfb_s3_2) / (1 + exp(mod_pfb_s3_2));

mod_pfb_s3 := round(100 * mod_pfb_s3_1/.001)*.001;

mod_pp_current_s0_2 := -5.324548178 +
    mod_pp_rule_s0 * 0.1265796756 +
    mod_pp_src_s0 * 0.3258827169 +
    _pp_app_nonpub_gong_la * 1.5193020907 +
    _pp_app_ported_match_10 * 1.8101120213 +
    _pp_curr_orig_conf_score * -1.871659795 +
    _mth_source_ppca_fseen0_m * 60.603211055 +
    _mth_source_ppdid_lseen0_m * 104.96823932;

mod_pp_current_s0_1 := exp(mod_pp_current_s0_2) / (1 + exp(mod_pp_current_s0_2));

mod_pp_current_s0 := round(100 * mod_pp_current_s0_1/.001)*.001;

mod_pp_current_s1_2 := -8.12848663 +
    mod_pp_rule_s1 * 0.1655505262 +
    mod_pp_src_s1 * 0.1882888663 +
    _pp_app_ph_type_cell * 0.6402071378 +
    source_ppca * -0.418216084 +
    _pp_eda_hist_match_lap * 2.9990279671 +
    _pp_min_orig_conf_score * -0.421433932 +
    _mth_source_ppca_lseen1_m * 20.804847139 +
    _mth_source_ppdid_lseen1_m * 11.481073142 +
    _mth_pp_first_build_date1_m * 12.563373346 +
    _pp_app_ind_ph_cnt1_m * 38.836644429;

mod_pp_current_s1_1 := exp(mod_pp_current_s1_2) / (1 + exp(mod_pp_current_s1_2));

mod_pp_current_s1 := round(100 * mod_pp_current_s1_1/.001)*.001;

mod_pp_current_s2_2 := -5.736048585 +
    mod_pp_rule_s2 * 0.0832355308 +
    mod_pp_src_s2 * 0.0803606959 +
    _pp_rule_med_vend_conf_cell * 0.3107152044 +
    _pp_eda_hist_match_did * -0.221221068 +
    _pp_app_seen_once_ind * 0.5909705377 +
    _pp_app_latest_ph_owner_fl * -1.061075956 +
    _pp_app_best_addr_match_fl * 0.6316654916 +
    _pp_app_best_nm_match_fl * -0.33136965 +
    _mth_source_ppca_lseen2_m * 12.061692609 +
    _mth_source_ppdid_lseen2_m * 8.621736555 +
    _pp_agegroup2_m * 17.618653469;

mod_pp_current_s2_1 := exp(mod_pp_current_s2_2) / (1 + exp(mod_pp_current_s2_2));

mod_pp_current_s2 := round(100 * mod_pp_current_s2_1/.001)*.001;

mod_pp_current_s3_2 := -6.037194051 +
    mod_pp_rule_s3 * 0.0349369592 +
    mod_pp_src_s3 * 0.0400354036 +
    _pp_app_ph_type_cell * 1.1147757728 +
    source_ppfla * 0.2699092317 +
    _pp_app_nonpub_gong_la * 0.8904217622 +
    _pp_curr_orig_conf_score * -0.451486664 +
    _mth_source_ppca_fseen3_m * 3.7388584409 +
    _mth_source_ppdid_lseen3_m * 5.6178731043 +
    _pp_max_orig_conf_score3_m * -11.98733649 +
    _pp_app_fb_ph3_m * 6.3399486147 +
    _pp_app_ind_ph_cnt3_m * 15.62188867;

mod_pp_current_s3_1 := exp(mod_pp_current_s3_2) / (1 + exp(mod_pp_current_s3_2));

mod_pp_current_s3 := round(100 * mod_pp_current_s3_1/.001)*.001;

mod_pp_historical_s0_2 := -7.792940182 +
    _pp_glb_dppa_util * 2.9062958729 +
    _pp_origlistingtype_res * -1.314204558 +
    _pp_app_ph_type_cell * 1.4470850514 +
    _pp_app_nonpub_gong_la * 1.5282447999 +
    _pp_confidence * 1.1805752424 +
    _mth_pp_datelastseen0_m * 602.45746667;

mod_pp_historical_s0_1 := exp(mod_pp_historical_s0_2) / (1 + exp(mod_pp_historical_s0_2));

mod_pp_historical_s0 := round(100 * mod_pp_historical_s0_1/.001)*.001;

mod_pp_historical_s1_2 := -5.889279831 +
    mod_pp_src_s1 * 0.4174396486 +
    _pp_eda_hist_match_did * -0.564189996 +
    _mth_source_ppth_fseen1_m * 33.97135246;

mod_pp_historical_s1_1 := exp(mod_pp_historical_s1_2) / (1 + exp(mod_pp_historical_s1_2));

mod_pp_historical_s1 := round(100 * mod_pp_historical_s1_1/.001)*.001;

mod_pp_historical_s2_2 := -3.190786581 +
    _pp_did_flag * -1.616439525 +
    _pp_bdid_flag * 1.628272864 +
    _mth_pp_origphoneregdate * 3.1655834773 +
    _mth_source_ppth_fseen2_m * 33.70388075;

mod_pp_historical_s2_1 := exp(mod_pp_historical_s2_2) / (1 + exp(mod_pp_historical_s2_2));

mod_pp_historical_s2 := round(100 * mod_pp_historical_s2_1/.001)*.001;

mod_pp_historical_s3_2 := -6.028640825 +
    _pp_app_coctype_cell * 0.4698316886 +
    _pp_app_nonpub_gong_la * 2.094123531 +
    _pp_confidence * 1.3588518364 +
    _pp_curr_orig_conf_score * -0.865735648 +
    _mth_pp_eda_hist_ph_dt3_m * 19.750346424 +
    _mth_pp_first_build_date3_m * 27.757553281;

mod_pp_historical_s3_1 := exp(mod_pp_historical_s3_2) / (1 + exp(mod_pp_historical_s3_2));

mod_pp_historical_s3 := round(100 * mod_pp_historical_s3_1/.001)*.001;

mod_pp3_s0 := map(
    pk_pp_hit = 1 and source_pp_any_clean = 1 => mod_pp_current_s0,
    pk_pp_hit = 1 and source_pp_any_clean = 0 => mod_pp_historical_s0,
                                                 0);

mod_pp3_s1 := map(
    pk_pp_hit = 1 and source_pp_any_clean = 1 => mod_pp_current_s1,
    pk_pp_hit = 1 and source_pp_any_clean = 0 => mod_pp_historical_s1,
                                                 3.7);

mod_pp3_s2 := map(
    pk_pp_hit = 1 and source_pp_any_clean = 1 => mod_pp_current_s2,
    pk_pp_hit = 1 and source_pp_any_clean = 0 => mod_pp_historical_s2,
                                                 0);

mod_pp3_s3 := map(
    pk_pp_hit = 1 and source_pp_any_clean = 1 => mod_pp_current_s3,
    pk_pp_hit = 1 and source_pp_any_clean = 0 => mod_pp_historical_s3,
                                                 10.7);

src_mod_neg2_s0_2 := -9.196848869 +
    _mth_source_edaca_lseen0_m * 101.7982855 +
    _mth_source_edaca_fseen0_m * 657.63616466 +
    _mth_source_ppth_fseen0_m * 257.86300708;

src_mod_neg2_s0_1 := exp(src_mod_neg2_s0_2) / (1 + exp(src_mod_neg2_s0_2));

src_mod_neg2_s0 := round(100 * src_mod_neg2_s0_1/.001)*.001;

src_mod_neg2_s2_2 := -4.576982506 + _mth_source_ppth_fseen2_m * 28.745139665;

src_mod_neg2_s2_1 := exp(src_mod_neg2_s2_2) / (1 + exp(src_mod_neg2_s2_2));

src_mod_neg2_s2 := round(100 * src_mod_neg2_s2_1/.001)*.001;

src_mod_pos_clean_s1_2 := -6.286875908 +
    source_cr * 0.378405852 +
    source_md * 1.2509644216 +
    source_rel * 2.4309772232 +
    source_sp * 0.4934242304 +
    source_sx * 1.3014766041 +
    source_utildid * 0.438075339 +
    _mth_source_paw_lseen1_m * 55.925614637 +
    _mth_source_utildid_fseen1_m * 14.290541883;

src_mod_pos_clean_s1_1 := exp(src_mod_pos_clean_s1_2) / (1 + exp(src_mod_pos_clean_s1_2));

src_mod_pos_clean_s1 := round(100 * src_mod_pos_clean_s1_1/.001)*.001;

src_mod_pos_clean_s2_2 := -3.334928474 +
    source_paw * 0.884562816 +
    _mth_source_utildid_fseen2_m * 8.5953938332;

src_mod_pos_clean_s2_1 := exp(src_mod_pos_clean_s2_2) / (1 + exp(src_mod_pos_clean_s2_2));

src_mod_pos_clean_s2 := round(100 * src_mod_pos_clean_s2_1/.001)*.001;

points := 40;

odds := 1 / 20;

base := 300;

mod14_s0_2 := -6.832479211 +
    src_mod_neg2_s0 * 0.6946589412 +
    mod_inq_s0 * 0.4464438492 +
    mod_pfb_s0 * 0.3311776785 +
    mod_eda3_s0 * 0.2158625979 +
    mod_pp3_s0 * 0.1820862693;

mod14_s0_1 := exp(mod14_s0_2) / (1 + exp(mod14_s0_2));

phat_3 := mod14_s0_1;

mod14_s0_scr := round(points * (ln(phat_3 / (1 - phat_3)) - ln(odds)) / ln(2) + base);

mod14_s0 := round(100 * mod14_s0_1/.1)*.1;

mod14_s1_2 := -6.84369775 +
    pk_eda_hit * 0.3190545585 +
    pk_phone_match_level1_m * 17.143844258 +
    src_mod_pos_clean_s1 * 0.0911562404 +
    mod_inq_s1 * 0.0542035683 +
    mod_pfb_s1 * 0.3508941509 +
    mod_eda3_s1 * 0.0784910982 +
    mod_pp3_s1 * 0.0979187026;

mod14_s1_1 := exp(mod14_s1_2) / (1 + exp(mod14_s1_2));

phat_2 := mod14_s1_1;

mod14_s1_scr := round(points * (ln(phat_2 / (1 - phat_2)) - ln(odds)) / ln(2) + base);

mod14_s1 := round(100 * mod14_s1_1/.1)*.1;

mod14_s2_2 := -5.415408759 +
    (integer)_internal_ver_match_lexid * 0.5448497205 +
    src_mod_pos_clean_s2 * 0.0337641497 +
    src_mod_neg2_s2 * 0.2014731755 +
    mod_inq_s2 * 0.0332459976 +
    mod_pp3_s2 * 0.0675512805;

mod14_s2_1 := exp(mod14_s2_2) / (1 + exp(mod14_s2_2));

phat_1 := mod14_s2_1;

mod14_s2_scr := round(points * (ln(phat_1 / (1 - phat_1)) - ln(odds)) / ln(2) + base);

mod14_s2 := round(100 * mod14_s2_1/.1)*.1;

mod14_s3_2 := -4.816841422 +
    pk_pp_hit * -0.442445117 +
    mod_exp_s3 * 0.0403216193 +
    mod_inq_s3 * 0.032345113 +
    mod_pfb_s3 * 0.0513395715 +
    mod_eda3_s3 * 0.0820245747 +
    mod_pp3_s3 * 0.0460878089;

mod14_s3_1 := exp(mod14_s3_2) / (1 + exp(mod14_s3_2));

phat := mod14_s3_1;

mod14_s3_scr := round(points * (ln(phat / (1 - phat)) - ln(odds)) / ln(2) + base);

mod14_s3 := round(100 * mod14_s3_1/.1)*.1;

mod14_scr_1 := map(
    segment = '0 - Disconnected' => mod14_s0_scr,
    segment = '1 - Other       ' => mod14_s1_scr,
    segment = '2 - Cell Phone  ' => mod14_s2_scr,
                                    mod14_s3_scr);

mod14_scr := min(if(Max(mod14_scr_1, 0) = NULL, -NULL, Max(mod14_scr_1, 0)), 999);

phonescore_v2_1 := mod14_scr;
phonescore_v2 := if(trim(StringLib.StringToUpperCase(phone_subject_title)) = 'NEIGHBOR', phonescore_v2_1 - 143, phonescore_v2_1);   /* Phone Subject Title Tweak – New */

//Intermediate variables
	#if(PHONE_DEBUG)
			self.clam                             := le;
			self.sysdate                          := sysdate;                                    
			self.source_cr                        := source_cr;                                  
			self.source_edaca                     := source_edaca;                               
			self.source_edaca_lseen               := source_edaca_lseen;                         
			self.source_edadid                    := source_edadid;                              
			self.source_edafa                     := source_edafa;                               
			self.source_edafla                    := source_edafla;                              
			self.source_edahistory_lseen          := source_edahistory_lseen;                    
			self.source_edahistory                := source_edahistory;                          
			self.source_edala                     := source_edala;                               
			self.source_edalfa                    := source_edalfa;                              
			self.source_exp                       := source_exp;                                 
			self.source_exp_fseen                 := source_exp_fseen;                           
			self.source_md                        := source_md;                                  
			self.source_paw                       := source_paw;                                 
			self.source_paw_lseen                 := source_paw_lseen;                           
			self.source_pf                        := source_pf;                                  
			self.source_ppca                      := source_ppca;                                
			self.source_ppca_lseen                := source_ppca_lseen;                          
			self.source_ppca_fseen                := source_ppca_fseen;                          
			self.source_ppdid                     := source_ppdid;                               
			self.source_ppdid_lseen               := source_ppdid_lseen;                         
			self.source_ppfa                      := source_ppfa;                                
			self.source_ppfla                     := source_ppfla;                               
			self.source_ppla                      := source_ppla;                                
			self.source_pplfa                     := source_pplfa;                               
			self.source_ppth_fseen                := source_ppth_fseen;                          
			self.source_rel                       := source_rel;                                 
			self.source_sp                        := source_sp;                                  
			self.source_sx                        := source_sx;                                  
			self.source_utildid_fseen             := source_utildid_fseen;                       
			self.source_utildid                   := source_utildid;                             
			self.source_eda_any_clean             := source_eda_any_clean;                       
			self.source_pp_any_clean              := source_pp_any_clean;                        
			self.source_edaca_lseen2              := source_edaca_lseen2;                        
			self.yr_source_edaca_lseen            := yr_source_edaca_lseen;                      
			self.source_edahistory_lseen2         := source_edahistory_lseen2;                   
			self.yr_source_edahistory_lseen       := yr_source_edahistory_lseen;                 
			self.source_exp_fseen2                := source_exp_fseen2;                          
			self.yr_source_exp_fseen              := yr_source_exp_fseen;                        
			self.source_paw_lseen2                := source_paw_lseen2;                          
			self.yr_source_paw_lseen              := yr_source_paw_lseen;                        
			self.source_ppca_lseen2               := source_ppca_lseen2;                         
			self.yr_source_ppca_lseen             := yr_source_ppca_lseen;                       
			self.source_ppca_fseen2               := source_ppca_fseen2;                         
			self.yr_source_ppca_fseen             := yr_source_ppca_fseen;                       
			self.source_ppdid_lseen2              := source_ppdid_lseen2;                        
			self.yr_source_ppdid_lseen            := yr_source_ppdid_lseen;                      
			self.source_ppth_fseen2               := source_ppth_fseen2;                         
			self.yr_source_ppth_fseen             := yr_source_ppth_fseen;                       
			self.source_utildid_fseen2            := source_utildid_fseen2;                      
			self.yr_source_utildid_fseen          := yr_source_utildid_fseen;                    
			self.eda_dt_first_seen2               := eda_dt_first_seen2;                         
			self.yr_eda_dt_first_seen             := yr_eda_dt_first_seen;                       
			self.eda_dt_last_seen2                := eda_dt_last_seen2;                          
			self.yr_eda_dt_last_seen              := yr_eda_dt_last_seen;                        
			self.eda_deletion_date2               := eda_deletion_date2;                         
			self.yr_eda_deletion_date             := yr_eda_deletion_date;                       
			self.exp_last_update2                 := exp_last_update2;                           
			self.yr_exp_last_update               := yr_exp_last_update;                         
			self.phone_fb_last_rpc_date2          := phone_fb_last_rpc_date2;                    
			self.yr_phone_fb_last_rpc_date        := yr_phone_fb_last_rpc_date;                  
			self.phone_fb_rp_date2                := phone_fb_rp_date2;                          
			self.yr_phone_fb_rp_date              := yr_phone_fb_rp_date;                        
			self.pp_datelastseen2                 := pp_datelastseen2;                           
			self.yr_pp_datelastseen               := yr_pp_datelastseen;                         
			self.pp_origphoneregdate2             := pp_origphoneregdate2;                       
			self.yr_pp_origphoneregdate           := yr_pp_origphoneregdate;                     
			self.pp_eda_hist_ph_dt2               := pp_eda_hist_ph_dt2;                         
			self.yr_pp_eda_hist_ph_dt             := yr_pp_eda_hist_ph_dt;                       
			self.pp_app_fb_ph_dt2                 := pp_app_fb_ph_dt2;                           
			self.yr_pp_app_fb_ph_dt               := yr_pp_app_fb_ph_dt;                         
			self.pp_first_build_date2             := pp_first_build_date2;                       
			self.yr_pp_first_build_date           := yr_pp_first_build_date;                     
			self.mth_source_edaca_lseen           := mth_source_edaca_lseen;                     
			self.mth_source_edahistory_lseen      := mth_source_edahistory_lseen;                
			self.mth_source_exp_fseen             := mth_source_exp_fseen;                       
			self.mth_source_paw_lseen             := mth_source_paw_lseen;                       
			self.mth_source_ppca_lseen            := mth_source_ppca_lseen;                      
			self.mth_source_ppca_fseen            := mth_source_ppca_fseen;                      
			self.mth_source_ppdid_lseen           := mth_source_ppdid_lseen;                     
			self.mth_source_ppth_fseen            := mth_source_ppth_fseen;                      
			self.mth_source_utildid_fseen         := mth_source_utildid_fseen;                   
			self.mth_eda_dt_first_seen            := mth_eda_dt_first_seen;                      
			self.mth_eda_dt_last_seen             := mth_eda_dt_last_seen;                       
			self.mth_eda_deletion_date            := mth_eda_deletion_date;                      
			self.mth_exp_last_update              := mth_exp_last_update;                        
			self.mth_phone_fb_last_rpc_date       := mth_phone_fb_last_rpc_date;                 
			self.mth_phone_fb_rp_date             := mth_phone_fb_rp_date;                       
			self.mth_pp_datelastseen              := mth_pp_datelastseen;                        
			self.mth_pp_origphoneregdate          := mth_pp_origphoneregdate;                    
			self.mth_pp_eda_hist_ph_dt            := mth_pp_eda_hist_ph_dt;                      
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
			self._pp_rule_low_vend_conf           := _pp_rule_low_vend_conf;                     
			self._pp_rule_cellphone_latest        := _pp_rule_cellphone_latest;                  
			self._pp_rule_source_latest           := _pp_rule_source_latest;                     
			self._pp_rule_med_vend_conf_cell      := _pp_rule_med_vend_conf_cell;                
			self._pp_rule_consort_rpc             := _pp_rule_consort_rpc;                       
			self._pp_rule_iq_rpc                  := _pp_rule_iq_rpc;                            
			self._pp_rule_ins_ver_above           := _pp_rule_ins_ver_above;                     
			self._pp_rule_f1_ver_above            := _pp_rule_f1_ver_above;                      
			self._pp_rule_f1_ver_below            := _pp_rule_f1_ver_below;                      
			self._pp_did_flag                     := _pp_did_flag;                               
			self._pp_src_all_ir                   := _pp_src_all_ir;                             
			self._pp_src_all_01                   := _pp_src_all_01;                             
			self._pp_src_all_02                   := _pp_src_all_02;                             
			self._pp_src_all_05                   := _pp_src_all_05;                             
			self._pp_src_all_wp                   := _pp_src_all_wp;                             
			self._pp_src_all_pn                   := _pp_src_all_pn;                             
			self._pp_src_all_go                   := _pp_src_all_go;                             
			self._pp_src_all_eq                   := _pp_src_all_eq;                             
			self._pp_src_all_ut                   := _pp_src_all_ut;                             
			self._pp_src_all_uw                   := _pp_src_all_uw;                             
			self._pp_src_all_cy                   := _pp_src_all_cy;                             
			self._pp_src_all_eb                   := _pp_src_all_eb;                             
			self._pp_src_all_en                   := _pp_src_all_en;                             
			self._pp_src_all_iq                   := _pp_src_all_iq;                             
			self._pp_src_all_ib                   := _pp_src_all_ib;                             
			self._pp_bdid_flag                    := _pp_bdid_flag;                              
			self._pp_app_nonpub_gong_la           := _pp_app_nonpub_gong_la;                     
			self._pp_eda_hist_match_did           := _pp_eda_hist_match_did;                     
			self._pp_eda_hist_match_lap           := _pp_eda_hist_match_lap;                     
			self._pp_app_ported_match_10          := _pp_app_ported_match_10;                    
			self._eda_did_flag                    := _eda_did_flag;                              
			self.inq_firstseen_n                  := inq_firstseen_n;                            
			self.inq_lastseen_n                   := inq_lastseen_n;                             
			self.inq_adl_firstseen_n              := inq_adl_firstseen_n;                        
			self.inq_adl_lastseen_n               := inq_adl_lastseen_n;                         
			self._internal_ver_match_lexid        := _internal_ver_match_lexid;                  
			self._inq_adl_ph_industry_auto        := _inq_adl_ph_industry_auto;                  
			self._inq_adl_ph_industry_cards       := _inq_adl_ph_industry_cards;                 
			self._inq_adl_ph_industry_coll        := _inq_adl_ph_industry_coll;                  
			self._inq_adl_ph_industry_comm        := _inq_adl_ph_industry_comm;                  
			self._inq_adl_ph_industry_firm        := _inq_adl_ph_industry_firm;                  
			self._inq_adl_ph_industry_invest      := _inq_adl_ph_industry_invest;                
			self._inq_adl_ph_industry_util        := _inq_adl_ph_industry_util;                  
			self._mth_source_edaca_lseen          := _mth_source_edaca_lseen;                    
			self._mth_source_edahistory_lseen     := _mth_source_edahistory_lseen;               
			self._mth_source_exp_fseen            := _mth_source_exp_fseen;                      
			self._mth_source_paw_lseen            := _mth_source_paw_lseen;                      
			self._mth_source_ppca_lseen           := _mth_source_ppca_lseen;                     
			self._mth_source_ppca_fseen           := _mth_source_ppca_fseen;                     
			self._mth_source_ppdid_lseen          := _mth_source_ppdid_lseen;                    
			self._mth_source_ppth_fseen           := _mth_source_ppth_fseen;                     
			self._mth_source_utildid_fseen        := _mth_source_utildid_fseen;                  
			self._mth_eda_dt_first_seen           := _mth_eda_dt_first_seen;                     
			self._mth_eda_dt_last_seen            := _mth_eda_dt_last_seen;                      
			self._mth_eda_deletion_date           := _mth_eda_deletion_date;                     
			self._mth_exp_last_update             := _mth_exp_last_update;                       
			self._mth_phone_fb_last_rpc_date      := _mth_phone_fb_last_rpc_date;                
			self._mth_phone_fb_rp_date            := _mth_phone_fb_rp_date;                      
			self._mth_pp_datelastseen             := _mth_pp_datelastseen;                       
			self._mth_pp_origphoneregdate         := _mth_pp_origphoneregdate;                   
			self._mth_pp_eda_hist_ph_dt           := _mth_pp_eda_hist_ph_dt;                     
			self._mth_pp_first_build_date         := _mth_pp_first_build_date;                   
			self._pp_confidence                   := _pp_confidence;                             
			self._pp_agegroup                     := _pp_agegroup;                               
			self._pp_max_orig_conf_score          := _pp_max_orig_conf_score;                    
			self._pp_min_orig_conf_score          := _pp_min_orig_conf_score;                    
			self._pp_curr_orig_conf_score         := _pp_curr_orig_conf_score;                   
			self._pp_app_fb_ph                    := _pp_app_fb_ph;                              
			self._pp_app_seen_once_ind            := _pp_app_seen_once_ind;                      
			self._pp_app_ind_ph_cnt               := _pp_app_ind_ph_cnt;                         
			self._pp_app_latest_ph_owner_fl       := _pp_app_latest_ph_owner_fl;                 
			self._pp_app_best_addr_match_fl       := _pp_app_best_addr_match_fl;                 
			self._pp_app_best_nm_match_fl         := _pp_app_best_nm_match_fl;                   
			self._eda_days_in_service             := _eda_days_in_service;                       
			self._eda_min_days_connected_ind      := _eda_min_days_connected_ind;                
			self._eda_max_days_connected_ind      := _eda_max_days_connected_ind;                
			self._eda_days_ind_first_seen         := _eda_days_ind_first_seen;                   
			self._eda_days_ind_first_seen_w_ph    := _eda_days_ind_first_seen_w_ph;              
			self._eda_days_ph_first_seen          := _eda_days_ph_first_seen;                    
			self._eda_address_match_best          := _eda_address_match_best;                    
			self._eda_months_addr_last_seen       := _eda_months_addr_last_seen;                 
			self._eda_num_phs_connected_addr      := _eda_num_phs_connected_addr;                
			self._eda_num_phs_discon_addr         := _eda_num_phs_discon_addr;                   
			self._eda_num_phs_discon_hhid         := _eda_num_phs_discon_hhid;                   
			self._eda_is_discon_15_days           := _eda_is_discon_15_days;                     
			self._eda_is_discon_180_days          := _eda_is_discon_180_days;                    
			self._eda_num_interrupts_cur          := _eda_num_interrupts_cur;                    
			self._eda_avg_days_interrupt          := _eda_avg_days_interrupt;                    
			self._eda_has_cur_discon_60_days      := _eda_has_cur_discon_60_days;                
			self._eda_has_cur_discon_180_days     := _eda_has_cur_discon_180_days;               
			self._exp_type                        := _exp_type;                                  
			self._exp_source                      := _exp_source;                                
			self._phone_disconnected              := _phone_disconnected;                        
			self._phone_fb_result                 := _phone_fb_result;                           
			self._phone_fb_rp_result              := _phone_fb_rp_result;                        
			self._inq_firstseen_n                 := _inq_firstseen_n;                           
			self._inq_lastseen_n                  := _inq_lastseen_n;                            
			self._inq_adl_firstseen_n             := _inq_adl_firstseen_n;                       
			self._inq_adl_lastseen_n              := _inq_adl_lastseen_n;                        
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
			self._pp_glb_dppa_util                := _pp_glb_dppa_util;                          
			self._pp_origlistingtype_res          := _pp_origlistingtype_res;                    
			self.pk_eda_hit                       := pk_eda_hit;                                 
			self.pk_exp_hit                       := pk_exp_hit;                                 
			self.pk_pp_hit                        := pk_pp_hit;                                  
			self.segment                          := segment;                                    
			self._mth_source_exp_fseen3           := _mth_source_exp_fseen3;                     
			self._mth_source_paw_lseen1           := _mth_source_paw_lseen1;                     
			self._mth_source_utildid_fseen1       := _mth_source_utildid_fseen1;                 
			self._mth_source_utildid_fseen2       := _mth_source_utildid_fseen2;                 
			self._mth_exp_last_update3            := _mth_exp_last_update3;                      
			self._mth_phone_fb_last_rpc_date0     := _mth_phone_fb_last_rpc_date0;               
			self._mth_phone_fb_last_rpc_date3     := _mth_phone_fb_last_rpc_date3;               
			self._mth_phone_fb_rp_date3           := _mth_phone_fb_rp_date3;                     
			self._exp_type3                       := _exp_type3;                                 
			self._exp_source3                     := _exp_source3;                               
			self._phone_fb_result0                := _phone_fb_result0;                          
			self._phone_fb_result1                := _phone_fb_result1;                          
			self._phone_fb_result3                := _phone_fb_result3;                          
			self._phone_fb_rp_result0             := _phone_fb_rp_result0;                       
			self._phone_fb_rp_result1             := _phone_fb_rp_result1;                       
			self._phone_fb_rp_result3             := _phone_fb_rp_result3;                       
			self._inq_firstseen_n0                := _inq_firstseen_n0;                          
			self._inq_firstseen_n2                := _inq_firstseen_n2;                          
			self._inq_lastseen_n0                 := _inq_lastseen_n0;                           
			self._inq_lastseen_n1                 := _inq_lastseen_n1;                           
			self._inq_lastseen_n3                 := _inq_lastseen_n3;                           
			self._inq_adl_firstseen_n1            := _inq_adl_firstseen_n1;                      
			self._inq_adl_lastseen_n1             := _inq_adl_lastseen_n1;                       
			self._inq_adl_lastseen_n2             := _inq_adl_lastseen_n2;                       
			self._inq_adl_lastseen_n3             := _inq_adl_lastseen_n3;                       
			self.pk_phone_match_level1            := pk_phone_match_level1;                      
			self._mth_source_edaca_lseen0         := _mth_source_edaca_lseen0;                   
			self._mth_source_edaca_lseen1         := _mth_source_edaca_lseen1;                   
			self._mth_source_edahistory_lseen1    := _mth_source_edahistory_lseen1;              
			self._mth_eda_dt_first_seen1          := _mth_eda_dt_first_seen1;                    
			self._mth_eda_dt_last_seen0           := _mth_eda_dt_last_seen0;                     
			self._mth_eda_dt_last_seen3           := _mth_eda_dt_last_seen3;                     
			self._mth_eda_deletion_date0          := _mth_eda_deletion_date0;                    
			self._mth_eda_deletion_date3          := _mth_eda_deletion_date3;                    
			self._eda_days_in_service0            := _eda_days_in_service0;                      
			self._eda_max_days_connected_ind3     := _eda_max_days_connected_ind3;               
			self._eda_days_ind_first_seen1        := _eda_days_ind_first_seen1;                  
			self._eda_days_ind_first_seen3        := _eda_days_ind_first_seen3;                  
			self._eda_days_ind_first_seen_w_ph3   := _eda_days_ind_first_seen_w_ph3;             
			self._eda_days_ph_first_seen1         := _eda_days_ph_first_seen1;                   
			self._eda_months_addr_last_seen3      := _eda_months_addr_last_seen3;                
			self._eda_num_phs_connected_addr1     := _eda_num_phs_connected_addr1;               
			self._eda_num_phs_discon_addr0        := _eda_num_phs_discon_addr0;                  
			self._eda_num_phs_discon_hhid1        := _eda_num_phs_discon_hhid1;                  
			self._eda_num_phs_discon_hhid3        := _eda_num_phs_discon_hhid3;                  
			self._eda_avg_days_interrupt1         := _eda_avg_days_interrupt1;                   
			self._mth_source_ppca_lseen1          := _mth_source_ppca_lseen1;                    
			self._mth_source_ppca_lseen2          := _mth_source_ppca_lseen2;                    
			self._mth_source_ppca_fseen0          := _mth_source_ppca_fseen0;                    
			self._mth_source_ppca_fseen3          := _mth_source_ppca_fseen3;                    
			self._mth_source_ppdid_lseen0         := _mth_source_ppdid_lseen0;                   
			self._mth_source_ppdid_lseen1         := _mth_source_ppdid_lseen1;                   
			self._mth_source_ppdid_lseen2         := _mth_source_ppdid_lseen2;                   
			self._mth_source_ppdid_lseen3         := _mth_source_ppdid_lseen3;                   
			self._mth_source_ppth_fseen0          := _mth_source_ppth_fseen0;                    
			self._mth_source_ppth_fseen1          := _mth_source_ppth_fseen1;                    
			self._mth_source_ppth_fseen2          := _mth_source_ppth_fseen2;                    
			self._mth_pp_datelastseen0            := _mth_pp_datelastseen0;                      
			self._mth_pp_eda_hist_ph_dt3          := _mth_pp_eda_hist_ph_dt3;                    
			self._mth_pp_first_build_date3        := _mth_pp_first_build_date3;                  
			self._mth_pp_first_build_date1        := _mth_pp_first_build_date1;                  
			self._pp_agegroup2                    := _pp_agegroup2;                              
			self._pp_max_orig_conf_score3         := _pp_max_orig_conf_score3;                   
			self._pp_app_fb_ph3                   := _pp_app_fb_ph3;                             
			self._pp_app_ind_ph_cnt3              := _pp_app_ind_ph_cnt3;                        
			self._pp_app_ind_ph_cnt1              := _pp_app_ind_ph_cnt1;                        
			self._mth_phone_fb_last_rpc_date0_m   := _mth_phone_fb_last_rpc_date0_m;             
			self._phone_fb_result0_m              := _phone_fb_result0_m;                        
			self._phone_fb_rp_result0_m           := _phone_fb_rp_result0_m;                     
			self._inq_firstseen_n0_m              := _inq_firstseen_n0_m;                        
			self._inq_lastseen_n0_m               := _inq_lastseen_n0_m;                         
			self._mth_source_paw_lseen1_m         := _mth_source_paw_lseen1_m;                   
			self._mth_source_utildid_fseen1_m     := _mth_source_utildid_fseen1_m;               
			self._phone_fb_result1_m              := _phone_fb_result1_m;                        
			self._phone_fb_rp_result1_m           := _phone_fb_rp_result1_m;                     
			self._inq_lastseen_n1_m               := _inq_lastseen_n1_m;                         
			self._inq_adl_firstseen_n1_m          := _inq_adl_firstseen_n1_m;                    
			self._inq_adl_lastseen_n1_m           := _inq_adl_lastseen_n1_m;                     
			self.pk_phone_match_level1_m          := pk_phone_match_level1_m;                    
			self._mth_source_utildid_fseen2_m     := _mth_source_utildid_fseen2_m;               
			self._inq_firstseen_n2_m              := _inq_firstseen_n2_m;                        
			self._inq_adl_lastseen_n2_m           := _inq_adl_lastseen_n2_m;                     
			self._mth_source_exp_fseen3_m         := _mth_source_exp_fseen3_m;                   
			self._mth_exp_last_update3_m          := _mth_exp_last_update3_m;                    
			self._mth_phone_fb_last_rpc_date3_m   := _mth_phone_fb_last_rpc_date3_m;             
			self._mth_phone_fb_rp_date3_m         := _mth_phone_fb_rp_date3_m;                   
			self._exp_type3_m                     := _exp_type3_m;                               
			self._exp_source3_m                   := _exp_source3_m;                             
			self._phone_fb_result3_m              := _phone_fb_result3_m;                        
			self._phone_fb_rp_result3_m           := _phone_fb_rp_result3_m;                     
			self._inq_lastseen_n3_m               := _inq_lastseen_n3_m;                         
			self._inq_adl_lastseen_n3_m           := _inq_adl_lastseen_n3_m;                     
			self._mth_source_edaca_lseen0_c       := _mth_source_edaca_lseen0_c;                 
			self._mth_source_edaca_fseen0_c       := _mth_source_edaca_fseen0_c;                 
			self._mth_eda_dt_last_seen0_c         := _mth_eda_dt_last_seen0_c;                   
			self._mth_eda_deletion_date0_c        := _mth_eda_deletion_date0_c;                  
			self._eda_days_in_service0_c          := _eda_days_in_service0_c;                    
			self._eda_num_phs_discon_addr0_c      := _eda_num_phs_discon_addr0_c;                
			self._mth_source_edaca_lseen1_c       := _mth_source_edaca_lseen1_c;                 
			self._mth_source_edahistory_lseen1_c  := _mth_source_edahistory_lseen1_c;            
			self._mth_eda_dt_first_seen1_c        := _mth_eda_dt_first_seen1_c;                  
			self._eda_days_ind_first_seen1_c      := _eda_days_ind_first_seen1_c;                
			self._eda_days_ph_first_seen1_c       := _eda_days_ph_first_seen1_c;                 
			self._eda_num_phs_connected_addr1_c   := _eda_num_phs_connected_addr1_c;             
			self._eda_num_phs_discon_hhid1_c      := _eda_num_phs_discon_hhid1_c;                
			self._eda_avg_days_interrupt1_c       := _eda_avg_days_interrupt1_c;                 
			self._mth_eda_dt_last_seen3_c         := _mth_eda_dt_last_seen3_c;                   
			self._mth_eda_deletion_date3_c        := _mth_eda_deletion_date3_c;                  
			self._eda_max_days_connected_ind3_c   := _eda_max_days_connected_ind3_c;             
			self._eda_days_ind_first_seen3_c      := _eda_days_ind_first_seen3_c;                
			self._eda_days_ind_first_seen_w_ph3_c := _eda_days_ind_first_seen_w_ph3_c;           
			self._eda_months_addr_last_seen3_c    := _eda_months_addr_last_seen3_c;              
			self._eda_num_phs_discon_hhid3_c      := _eda_num_phs_discon_hhid3_c;                
			self._mth_source_edaca_lseen0_h       := _mth_source_edaca_lseen0_h;                 
			self._mth_source_edaca_fseen0_h       := _mth_source_edaca_fseen0_h;                 
			self._mth_eda_dt_last_seen0_h         := _mth_eda_dt_last_seen0_h;                   
			self._mth_eda_deletion_date0_h        := _mth_eda_deletion_date0_h;                  
			self._eda_days_in_service0_h          := _eda_days_in_service0_h;                    
			self._eda_num_phs_discon_addr0_h      := _eda_num_phs_discon_addr0_h;                
			self._mth_source_edaca_lseen1_h       := _mth_source_edaca_lseen1_h;                 
			self._mth_source_edahistory_lseen1_h  := _mth_source_edahistory_lseen1_h;            
			self._mth_eda_dt_first_seen1_h        := _mth_eda_dt_first_seen1_h;                  
			self._eda_days_ind_first_seen1_h      := _eda_days_ind_first_seen1_h;                
			self._eda_days_ph_first_seen1_h       := _eda_days_ph_first_seen1_h;                 
			self._eda_num_phs_connected_addr1_h   := _eda_num_phs_connected_addr1_h;             
			self._eda_num_phs_discon_hhid1_h      := _eda_num_phs_discon_hhid1_h;                
			self._eda_avg_days_interrupt1_h       := _eda_avg_days_interrupt1_h;                 
			self._mth_eda_dt_last_seen3_h         := _mth_eda_dt_last_seen3_h;                   
			self._mth_eda_deletion_date3_h        := _mth_eda_deletion_date3_h;                  
			self._eda_max_days_connected_ind3_h   := _eda_max_days_connected_ind3_h;             
			self._eda_days_ind_first_seen3_h      := _eda_days_ind_first_seen3_h;                
			self._eda_days_ind_first_seen_w_ph3_h := _eda_days_ind_first_seen_w_ph3_h;           
			self._eda_months_addr_last_seen3_h    := _eda_months_addr_last_seen3_h;              
			self._eda_num_phs_discon_hhid3_h      := _eda_num_phs_discon_hhid3_h;                
			self._mth_source_edaca_lseen0_n       := _mth_source_edaca_lseen0_n;                 
			self._mth_source_edaca_fseen0_n       := _mth_source_edaca_fseen0_n;                 
			self._mth_eda_dt_last_seen0_n         := _mth_eda_dt_last_seen0_n;                   
			self._mth_eda_deletion_date0_n        := _mth_eda_deletion_date0_n;                  
			self._eda_days_in_service0_n          := _eda_days_in_service0_n;                    
			self._eda_num_phs_discon_addr0_n      := _eda_num_phs_discon_addr0_n;                
			self._mth_source_edaca_lseen1_n       := _mth_source_edaca_lseen1_n;                 
			self._mth_source_edahistory_lseen1_n  := _mth_source_edahistory_lseen1_n;            
			self._mth_eda_dt_first_seen1_n        := _mth_eda_dt_first_seen1_n;                  
			self._eda_days_ind_first_seen1_n      := _eda_days_ind_first_seen1_n;                
			self._eda_days_ph_first_seen1_n       := _eda_days_ph_first_seen1_n;                 
			self._eda_num_phs_connected_addr1_n   := _eda_num_phs_connected_addr1_n;             
			self._eda_num_phs_discon_hhid1_n      := _eda_num_phs_discon_hhid1_n;                
			self._eda_avg_days_interrupt1_n       := _eda_avg_days_interrupt1_n;                 
			self._mth_eda_dt_last_seen3_n         := _mth_eda_dt_last_seen3_n;                   
			self._mth_eda_deletion_date3_n        := _mth_eda_deletion_date3_n;                  
			self._eda_max_days_connected_ind3_n   := _eda_max_days_connected_ind3_n;             
			self._eda_days_ind_first_seen3_n      := _eda_days_ind_first_seen3_n;                
			self._eda_days_ind_first_seen_w_ph3_n := _eda_days_ind_first_seen_w_ph3_n;           
			self._eda_months_addr_last_seen3_n    := _eda_months_addr_last_seen3_n;              
			self._eda_num_phs_discon_hhid3_n      := _eda_num_phs_discon_hhid3_n;                
			self._mth_source_ppca_fseen0_c        := _mth_source_ppca_fseen0_c;                  
			self._mth_source_ppdid_lseen0_c       := _mth_source_ppdid_lseen0_c;                 
			self._mth_source_ppth_fseen0_c        := _mth_source_ppth_fseen0_c;                  
			self._mth_pp_datelastseen0_c          := _mth_pp_datelastseen0_c;                    
			self._mth_source_ppca_lseen1_c        := _mth_source_ppca_lseen1_c;                  
			self._mth_source_ppdid_lseen1_c       := _mth_source_ppdid_lseen1_c;                 
			self._mth_source_ppth_fseen1_c        := _mth_source_ppth_fseen1_c;                  
			self._mth_pp_first_build_date1_c      := _mth_pp_first_build_date1_c;                
			self._pp_app_ind_ph_cnt1_c            := _pp_app_ind_ph_cnt1_c;                      
			self._mth_source_ppca_lseen2_c        := _mth_source_ppca_lseen2_c;                  
			self._mth_source_ppdid_lseen2_c       := _mth_source_ppdid_lseen2_c;                 
			self._mth_source_ppth_fseen2_c        := _mth_source_ppth_fseen2_c;                  
			self._pp_agegroup2_c                  := _pp_agegroup2_c;                            
			self._mth_source_ppca_fseen3_c        := _mth_source_ppca_fseen3_c;                  
			self._mth_source_ppdid_lseen3_c       := _mth_source_ppdid_lseen3_c;                 
			self._mth_pp_eda_hist_ph_dt3_c        := _mth_pp_eda_hist_ph_dt3_c;                  
			self._mth_pp_first_build_date3_c      := _mth_pp_first_build_date3_c;                
			self._pp_max_orig_conf_score3_c       := _pp_max_orig_conf_score3_c;                 
			self._pp_app_fb_ph3_c                 := _pp_app_fb_ph3_c;                           
			self._pp_app_ind_ph_cnt3_c            := _pp_app_ind_ph_cnt3_c;                      
			self._mth_source_ppca_fseen0_h        := _mth_source_ppca_fseen0_h;                  
			self._mth_source_ppdid_lseen0_h       := _mth_source_ppdid_lseen0_h;                 
			self._mth_source_ppth_fseen0_h        := _mth_source_ppth_fseen0_h;                  
			self._mth_pp_datelastseen0_h          := _mth_pp_datelastseen0_h;                    
			self._mth_source_ppca_lseen1_h        := _mth_source_ppca_lseen1_h;                  
			self._mth_source_ppdid_lseen1_h       := _mth_source_ppdid_lseen1_h;                 
			self._mth_source_ppth_fseen1_h        := _mth_source_ppth_fseen1_h;                  
			self._mth_pp_first_build_date1_h      := _mth_pp_first_build_date1_h;                
			self._pp_app_ind_ph_cnt1_h            := _pp_app_ind_ph_cnt1_h;                      
			self._mth_source_ppca_lseen2_h        := _mth_source_ppca_lseen2_h;                  
			self._mth_source_ppdid_lseen2_h       := _mth_source_ppdid_lseen2_h;                 
			self._mth_source_ppth_fseen2_h        := _mth_source_ppth_fseen2_h;                  
			self._pp_agegroup2_h                  := _pp_agegroup2_h;                            
			self._mth_source_ppca_fseen3_h        := _mth_source_ppca_fseen3_h;                  
			self._mth_source_ppdid_lseen3_h       := _mth_source_ppdid_lseen3_h;                 
			self._mth_pp_eda_hist_ph_dt3_h        := _mth_pp_eda_hist_ph_dt3_h;                  
			self._mth_pp_first_build_date3_h      := _mth_pp_first_build_date3_h;                
			self._pp_max_orig_conf_score3_h       := _pp_max_orig_conf_score3_h;                 
			self._pp_app_fb_ph3_h                 := _pp_app_fb_ph3_h;                           
			self._pp_app_ind_ph_cnt3_h            := _pp_app_ind_ph_cnt3_h;                      
			self._mth_source_ppca_fseen0_n        := _mth_source_ppca_fseen0_n;                  
			self._mth_source_ppdid_lseen0_n       := _mth_source_ppdid_lseen0_n;                 
			self._mth_source_ppth_fseen0_n        := _mth_source_ppth_fseen0_n;                  
			self._mth_pp_datelastseen0_n          := _mth_pp_datelastseen0_n;                    
			self._mth_source_ppca_lseen1_n        := _mth_source_ppca_lseen1_n;                  
			self._mth_source_ppdid_lseen1_n       := _mth_source_ppdid_lseen1_n;                 
			self._mth_source_ppth_fseen1_n        := _mth_source_ppth_fseen1_n;                  
			self._mth_pp_first_build_date1_n      := _mth_pp_first_build_date1_n;                
			self._pp_app_ind_ph_cnt1_n            := _pp_app_ind_ph_cnt1_n;                      
			self._mth_source_ppca_fseen3_n        := _mth_source_ppca_fseen3_n;                  
			self._mth_source_ppdid_lseen3_n       := _mth_source_ppdid_lseen3_n;                 
			self._mth_pp_eda_hist_ph_dt3_n        := _mth_pp_eda_hist_ph_dt3_n;                  
			self._mth_pp_first_build_date3_n      := _mth_pp_first_build_date3_n;                
			self._pp_max_orig_conf_score3_n       := _pp_max_orig_conf_score3_n;                 
			self._pp_app_fb_ph3_n                 := _pp_app_fb_ph3_n;                           
			self._pp_app_ind_ph_cnt3_n            := _pp_app_ind_ph_cnt3_n;                      
			self._mth_source_ppca_lseen2_n        := _mth_source_ppca_lseen2_n;                  
			self._mth_source_ppdid_lseen2_n       := _mth_source_ppdid_lseen2_n;                 
			self._mth_source_ppth_fseen2_n        := _mth_source_ppth_fseen2_n;                  
			self._pp_agegroup2_n                  := _pp_agegroup2_n;                            
			self._mth_eda_deletion_date3_m        := _mth_eda_deletion_date3_m;                  
			self._eda_days_ind_first_seen_w_ph3_m := _eda_days_ind_first_seen_w_ph3_m;           
			self._eda_num_phs_discon_addr0_m      := _eda_num_phs_discon_addr0_m;                
			self._mth_source_edaca_fseen0_m       := _mth_source_edaca_fseen0_m;                 
			self._mth_source_edaca_lseen0_m       := _mth_source_edaca_lseen0_m;                 
			self._mth_eda_deletion_date0_m        := _mth_eda_deletion_date0_m;                  
			self._eda_months_addr_last_seen3_m    := _eda_months_addr_last_seen3_m;              
			self._mth_source_edahistory_lseen1_m  := _mth_source_edahistory_lseen1_m;            
			self._mth_source_edaca_lseen1_m       := _mth_source_edaca_lseen1_m;                 
			self._eda_days_in_service0_m          := _eda_days_in_service0_m;                    
			self._mth_eda_dt_first_seen1_m        := _mth_eda_dt_first_seen1_m;                  
			self._eda_num_phs_discon_hhid3_m      := _eda_num_phs_discon_hhid3_m;                
			self._eda_num_phs_discon_hhid1_m      := _eda_num_phs_discon_hhid1_m;                
			self._eda_avg_days_interrupt1_m       := _eda_avg_days_interrupt1_m;                 
			self._mth_eda_dt_last_seen3_m         := _mth_eda_dt_last_seen3_m;                   
			self._eda_days_ph_first_seen1_m       := _eda_days_ph_first_seen1_m;                 
			self._eda_days_ind_first_seen3_m      := _eda_days_ind_first_seen3_m;                
			self._eda_max_days_connected_ind3_m   := _eda_max_days_connected_ind3_m;             
			self._eda_days_ind_first_seen1_m      := _eda_days_ind_first_seen1_m;                
			self._eda_num_phs_connected_addr1_m   := _eda_num_phs_connected_addr1_m;             
			self._mth_eda_dt_last_seen0_m         := _mth_eda_dt_last_seen0_m;                   
			self._mth_source_ppca_fseen0_m        := _mth_source_ppca_fseen0_m;                  
			self._mth_source_ppdid_lseen0_m       := _mth_source_ppdid_lseen0_m;                 
			self._mth_source_ppca_lseen1_m        := _mth_source_ppca_lseen1_m;                  
			self._pp_agegroup2_m                  := _pp_agegroup2_m;                            
			self._mth_source_ppdid_lseen3_m       := _mth_source_ppdid_lseen3_m;                 
			self._mth_source_ppdid_lseen2_m       := _mth_source_ppdid_lseen2_m;                 
			self._mth_source_ppth_fseen2_m        := _mth_source_ppth_fseen2_m;                  
			self._mth_pp_first_build_date1_m      := _mth_pp_first_build_date1_m;                
			self._pp_app_ind_ph_cnt3_m            := _pp_app_ind_ph_cnt3_m;                      
			self._mth_source_ppca_lseen2_m        := _mth_source_ppca_lseen2_m;                  
			self._mth_pp_first_build_date3_m      := _mth_pp_first_build_date3_m;                
			self._mth_pp_eda_hist_ph_dt3_m        := _mth_pp_eda_hist_ph_dt3_m;                  
			self._mth_pp_datelastseen0_m          := _mth_pp_datelastseen0_m;                    
			self._pp_max_orig_conf_score3_m       := _pp_max_orig_conf_score3_m;                 
			self._mth_source_ppdid_lseen1_m       := _mth_source_ppdid_lseen1_m;                 
			self._pp_app_fb_ph3_m                 := _pp_app_fb_ph3_m;                           
			self._mth_source_ppca_fseen3_m        := _mth_source_ppca_fseen3_m;                  
			self._mth_source_ppth_fseen1_m        := _mth_source_ppth_fseen1_m;                  
			self._pp_app_ind_ph_cnt1_m            := _pp_app_ind_ph_cnt1_m;                      
			self._mth_source_ppth_fseen0_m        := _mth_source_ppth_fseen0_m;                  
			self.mod_pp_rule_s0                   := mod_pp_rule_s0;                             
			self.mod_pp_rule_s1                   := mod_pp_rule_s1;                             
			self.mod_pp_rule_s2                   := mod_pp_rule_s2;                             
			self.mod_pp_rule_s3                   := mod_pp_rule_s3;                             
			self.mod_pp_src_s0                    := mod_pp_src_s0;                              
			self.mod_pp_src_s1                    := mod_pp_src_s1;                              
			self.mod_pp_src_s2                    := mod_pp_src_s2;                              
			self.mod_pp_src_s3                    := mod_pp_src_s3;                              
			self.mod_inq_industry_s0              := mod_inq_industry_s0;                        
			self.mod_inq_industry_s1              := mod_inq_industry_s1;                        
			self.mod_eda_current_s0               := mod_eda_current_s0;                         
			self.mod_eda_current_s1               := mod_eda_current_s1;                         
			self.mod_eda_current_s3               := mod_eda_current_s3;                         
			self.mod_eda_historical_s0            := mod_eda_historical_s0;                      
			self.mod_eda_historical_s1            := mod_eda_historical_s1;                      
			self.mod_eda_historical_s3            := mod_eda_historical_s3;                      
			self.mod_eda3_s0                      := mod_eda3_s0;                                
			self.mod_eda3_s1                      := mod_eda3_s1;                                
			self.mod_eda3_s3                      := mod_eda3_s3;                                
			self.mod_exp_s3                       := mod_exp_s3;                                 
			self.mod_inq_s0                       := mod_inq_s0;                                 
			self.mod_inq_s1                       := mod_inq_s1;                                 
			self.mod_inq_s2                       := mod_inq_s2;                                 
			self.mod_inq_s3                       := mod_inq_s3;                                 
			self.mod_pfb_s0                       := mod_pfb_s0;                                 
			self.mod_pfb_s1                       := mod_pfb_s1;                                 
			self.mod_pfb_s3                       := mod_pfb_s3;                                 
			self.mod_pp_current_s0                := mod_pp_current_s0;                          
			self.mod_pp_current_s1                := mod_pp_current_s1;                          
			self.mod_pp_current_s2                := mod_pp_current_s2;                          
			self.mod_pp_current_s3                := mod_pp_current_s3;                          
			self.mod_pp_historical_s0             := mod_pp_historical_s0;                       
			self.mod_pp_historical_s1             := mod_pp_historical_s1;                       
			self.mod_pp_historical_s2             := mod_pp_historical_s2;                       
			self.mod_pp_historical_s3             := mod_pp_historical_s3;                       
			self.mod_pp3_s0                       := mod_pp3_s0;                                 
			self.mod_pp3_s1                       := mod_pp3_s1;                                 
			self.mod_pp3_s2                       := mod_pp3_s2;                                 
			self.mod_pp3_s3                       := mod_pp3_s3;                                 
			self.src_mod_neg2_s0                  := src_mod_neg2_s0;                            
			self.src_mod_neg2_s2                  := src_mod_neg2_s2;                            
			self.src_mod_pos_clean_s1             := src_mod_pos_clean_s1;                       
			self.src_mod_pos_clean_s2             := src_mod_pos_clean_s2;                       
			self.points                           := points;                                     
			self.odds                             := odds;                                       
			self.base                             := base;                                       
			self.mod14_s0_scr                     := mod14_s0_scr;                               
			self.mod14_s0                         := mod14_s0;                                   
			self.mod14_s1_scr                     := mod14_s1_scr;                               
			self.mod14_s1                         := mod14_s1;                                   
			self.mod14_s2_scr                     := mod14_s2_scr;                               
			self.mod14_s2                         := mod14_s2;                                   
			self.phat                             := phat;                                       
			self.mod14_s3_scr                     := mod14_s3_scr;                               
			self.mod14_s3                         := mod14_s3;                                   
			self.mod14_scr                        := mod14_scr;                                  
			self.phonescore_v2                    := phonescore_v2;                              
		#else
			self.phone_shell.Phone_Model_Score		:= (string) phonescore_v2;
		#end
			self := le;
	END;

		model := project( clam, doModel(left) )((Integer)phone_shell.Phone_Model_Score >= Score_Threshold); //New Tweak: Only return phones at or above the score threshold, defaulted to 245

		return model;

END;

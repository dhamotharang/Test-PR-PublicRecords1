IMPORT ut, RiskWise, RiskWiseFCRA, Risk_Indicators, std, riskview;

export RVP1702_1_0( grouped dataset(risk_indicators.Layout_Boca_Shell) clam) := FUNCTION

	MODEL_DEBUG := False;
 
// boolean isFCRA := false;
boolean isFCRA := true;

	#if(MODEL_DEBUG)
		Layout_Debug := RECORD
		
      integer seq; 
		  boolean truedid ;
      
      	/* Model Intermediate Variables */
			              integer ver_src_ak_pos                     ;// ver_src_ak_pos;
                    boolean ver_src_ak                       ;// ver_src_ak;
                    string _ver_src_fdate_ak                ;// _ver_src_fdate_ak;
                    integer ver_src_fdate_ak                 ;// ver_src_fdate_ak;
                    real ver_src_am_pos                   ;// ver_src_am_pos;
                    boolean ver_src_am                       ;// ver_src_am;
                    string _ver_src_fdate_am                ;// _ver_src_fdate_am;
                    integer ver_src_fdate_am                 ;// ver_src_fdate_am;
                    integer ver_src_ar_pos                   ;// ver_src_ar_pos;
                    boolean ver_src_ar                       ;// ver_src_ar;
                    string _ver_src_fdate_ar                ;// _ver_src_fdate_ar;
                    integer ver_src_fdate_ar                 ;// ver_src_fdate_ar;
                    integer ver_src_ba_pos                   ;// ver_src_ba_pos;
                    boolean ver_src_ba                       ;// ver_src_ba;
                    string _ver_src_fdate_ba                ;// _ver_src_fdate_ba;
                    integer ver_src_fdate_ba                 ;// ver_src_fdate_ba;
                    integer ver_src_cg_pos                   ;// ver_src_cg_pos;
                    boolean ver_src_cg                       ;// ver_src_cg;
                    string _ver_src_fdate_cg                ;// _ver_src_fdate_cg;
                    integer ver_src_fdate_cg                 ;// ver_src_fdate_cg;
                    integer ver_src_co_pos                   ;// ver_src_co_pos;
                    string _ver_src_fdate_co                ;// _ver_src_fdate_co;
                    integer ver_src_fdate_co                 ;// ver_src_fdate_co;
                    integer ver_src_cy_pos                   ;// ver_src_cy_pos;
                    boolean ver_src_cy                       ;// ver_src_cy;
                    string _ver_src_fdate_cy                ;// _ver_src_fdate_cy;
                    integer ver_src_fdate_cy                 ;// ver_src_fdate_cy;
                    integer ver_src_da_pos                   ;// ver_src_da_pos;
                    boolean ver_src_da                       ;// ver_src_da;
                    string _ver_src_fdate_da                ;// _ver_src_fdate_da;
                    integer ver_src_fdate_da                 ;// ver_src_fdate_da;
                    integer ver_src_d_pos                    ;// ver_src_d_pos;
                    boolean ver_src_d                        ;// ver_src_d;
                    string _ver_src_fdate_d                 ;// _ver_src_fdate_d;
                    integer ver_src_fdate_d                  ;// ver_src_fdate_d;
                    integer ver_src_dl_pos                   ;// ver_src_dl_pos;
                    boolean ver_src_dl                       ;// ver_src_dl;
                    string _ver_src_fdate_dl                ;// _ver_src_fdate_dl;
                    integer ver_src_fdate_dl                 ;// ver_src_fdate_dl;
                    integer ver_src_ds_pos                   ;// ver_src_ds_pos;
                    boolean ver_src_ds                       ;// ver_src_ds;
                    string _ver_src_fdate_ds                ;// _ver_src_fdate_ds;
                    integer ver_src_fdate_ds                 ;// ver_src_fdate_ds;
                    integer ver_src_de_pos                   ;// ver_src_de_pos;
                    boolean ver_src_de                       ;// ver_src_de;
                    string _ver_src_fdate_de                ;// _ver_src_fdate_de;
                    integer ver_src_fdate_de                 ;// ver_src_fdate_de;
                    integer ver_src_eb_pos                   ;// ver_src_eb_pos;
                    boolean ver_src_eb                       ;// ver_src_eb;
                    string _ver_src_fdate_eb                ;// _ver_src_fdate_eb;
                    integer ver_src_fdate_eb                 ;// ver_src_fdate_eb;
                    integer ver_src_em_pos                   ;// ver_src_em_pos;
                    boolean ver_src_em                       ;// ver_src_em;
                    string _ver_src_fdate_em                ;// _ver_src_fdate_em;
                    integer ver_src_fdate_em                 ;// ver_src_fdate_em;
                    integer ver_src_e1_pos                   ;// ver_src_e1_pos;
                    boolean ver_src_e1                       ;// ver_src_e1;
                    string _ver_src_fdate_e1                ;// _ver_src_fdate_e1;
                    integer ver_src_fdate_e1                 ;// ver_src_fdate_e1;
                    integer ver_src_e2_pos                   ;// ver_src_e2_pos;
                    boolean ver_src_e2                       ;// ver_src_e2;
                    string _ver_src_fdate_e2                ;// _ver_src_fdate_e2;
                    integer ver_src_fdate_e2                 ;// ver_src_fdate_e2;
                    integer ver_src_e3_pos                   ;// ver_src_e3_pos;
                    boolean ver_src_e3                       ;// ver_src_e3;
                    string _ver_src_fdate_e3                ;// _ver_src_fdate_e3;
                    integer ver_src_fdate_e3                 ;// ver_src_fdate_e3;
                    integer ver_src_e4_pos                   ;// ver_src_e4_pos;
                    boolean ver_src_e4                       ;// ver_src_e4;
                    string _ver_src_fdate_e4                ;// _ver_src_fdate_e4;
                    integer ver_src_fdate_e4                 ;// ver_src_fdate_e4;
                    integer ver_src_en_pos                   ;// ver_src_en_pos;
                    string _ver_src_fdate_en                ;// _ver_src_fdate_en;
                    integer ver_src_fdate_en                 ;// ver_src_fdate_en;
                    integer ver_src_eq_pos                   ;// ver_src_eq_pos;
                    string _ver_src_fdate_eq                ;// _ver_src_fdate_eq;
                    integer ver_src_fdate_eq                 ;// ver_src_fdate_eq;
                    integer ver_src_fe_pos                   ;// ver_src_fe_pos;
                    boolean ver_src_fe                       ;// ver_src_fe;
                    string _ver_src_fdate_fe                ;// _ver_src_fdate_fe;
                    integer ver_src_fdate_fe                 ;// ver_src_fdate_fe;
                    integer ver_src_ff_pos                   ;// ver_src_ff_pos;
                    boolean ver_src_ff                       ;// ver_src_ff;
                    string _ver_src_fdate_ff                ;// _ver_src_fdate_ff;
                    integer ver_src_fdate_ff                 ;// ver_src_fdate_ff;
                    integer ver_src_fr_pos                   ;// ver_src_fr_pos;
                    boolean ver_src_fr                       ;// ver_src_fr;
                    string _ver_src_fdate_fr                ;// _ver_src_fdate_fr;
                    integer ver_src_fdate_fr                 ;// ver_src_fdate_fr;
                    integer ver_src_l2_pos                   ;// ver_src_l2_pos;
                    boolean ver_src_l2                       ;// ver_src_l2;
                    string _ver_src_fdate_l2                ;// _ver_src_fdate_l2;
                    integer ver_src_fdate_l2                 ;// ver_src_fdate_l2;
                    integer ver_src_li_pos                   ;// ver_src_li_pos;
                    boolean ver_src_li                       ;// ver_src_li;
                    string _ver_src_fdate_li                ;// _ver_src_fdate_li;
                    integer ver_src_fdate_li                 ;// ver_src_fdate_li;
                    integer ver_src_mw_pos                   ;// ver_src_mw_pos;
                    boolean ver_src_mw                       ;// ver_src_mw;
                    string _ver_src_fdate_mw                ;// _ver_src_fdate_mw;
                    integer ver_src_fdate_mw                 ;// ver_src_fdate_mw;
                    integer ver_src_nt_pos                   ;// ver_src_nt_pos;
                    boolean ver_src_nt                       ;// ver_src_nt;
                    string _ver_src_fdate_nt                ;// _ver_src_fdate_nt;
                    integer ver_src_fdate_nt                 ;// ver_src_fdate_nt;
                    integer ver_src_p_pos                    ;// ver_src_p_pos;
                    boolean ver_src_p                        ;// ver_src_p;
                    string _ver_src_fdate_p                 ;// _ver_src_fdate_p;
                    integer ver_src_fdate_p                  ;// ver_src_fdate_p;
                    integer ver_src_pl_pos                   ;// ver_src_pl_pos;
                    boolean ver_src_pl                       ;// ver_src_pl;
                    string _ver_src_fdate_pl                ;// _ver_src_fdate_pl;
                    integer ver_src_fdate_pl                 ;// ver_src_fdate_pl;
                    integer ver_src_tn_pos                   ;// ver_src_tn_pos;
                    string _ver_src_fdate_tn                ;// _ver_src_fdate_tn;
                    integer ver_src_fdate_tn                 ;// ver_src_fdate_tn;
                    integer ver_src_ts_pos                   ;// ver_src_ts_pos;
                    string _ver_src_fdate_ts                ;// _ver_src_fdate_ts;
                    integer ver_src_fdate_ts                 ;// ver_src_fdate_ts;
                    integer ver_src_tu_pos                   ;// ver_src_tu_pos;
                    string _ver_src_fdate_tu                ;// _ver_src_fdate_tu;
                    integer ver_src_fdate_tu                 ;// ver_src_fdate_tu;
                    integer ver_src_sl_pos                   ;// ver_src_sl_pos;
                    boolean ver_src_sl                       ;// ver_src_sl;
                    string _ver_src_fdate_sl                ;// _ver_src_fdate_sl;
                    integer ver_src_fdate_sl                 ;// ver_src_fdate_sl;
                    integer ver_src_v_pos                    ;// ver_src_v_pos;
                    boolean ver_src_v                        ;// ver_src_v;
                    string _ver_src_fdate_v                 ;// _ver_src_fdate_v;
                    integer ver_src_fdate_v                  ;// ver_src_fdate_v;
                    integer ver_src_vo_pos                   ;// ver_src_vo_pos;
                    boolean ver_src_vo                       ;// ver_src_vo;
                    string _ver_src_fdate_vo                ;// _ver_src_fdate_vo;
                    integer ver_src_fdate_vo                 ;// ver_src_fdate_vo;
                    integer ver_src_w_pos                    ;// ver_src_w_pos;
                    boolean ver_src_w                        ;// ver_src_w;
                    string _ver_src_fdate_w                 ;// _ver_src_fdate_w;
                    integer ver_src_fdate_w                  ;// ver_src_fdate_w;
                    integer ver_src_wp_pos                   ;// ver_src_wp_pos;
                    boolean ver_src_wp                       ;// ver_src_wp;
                    string _ver_src_fdate_wp                ;// _ver_src_fdate_wp;
                    integer ver_src_fdate_wp                 ;// ver_src_fdate_wp;
                    integer ver_lname_src_en_pos             ;// ver_lname_src_en_pos;
                    boolean ver_lname_src_en                 ;// ver_lname_src_en;
                    integer ver_lname_src_eq_pos             ;// ver_lname_src_eq_pos;
                    boolean ver_lname_src_eq                 ;// ver_lname_src_eq;
                    integer ver_lname_src_tn_pos             ;// ver_lname_src_tn_pos;
                    boolean ver_lname_src_tn                 ;// ver_lname_src_tn;
                    integer ver_lname_src_ts_pos             ;// ver_lname_src_ts_pos;
                    boolean ver_lname_src_ts                 ;// ver_lname_src_ts;
                    integer ver_lname_src_tu_pos             ;// ver_lname_src_tu_pos;
                    boolean ver_lname_src_tu                 ;// ver_lname_src_tu;
                    
                    
                    integer sysdate                          ;// sysdate;
                    string iv_add_apt                       ;// iv_add_apt;
                    integer rv_l70_inp_addr_dirty            ;// rv_l70_inp_addr_dirty;
                    string add_ec3                          ;// add_ec3;
                    string add_ec4                          ;// add_ec4;
                    integer rv_l70_add_standardized          ;// rv_l70_add_standardized;
                    string iv_l77_dwelltype                 ;// iv_l77_dwelltype;
                    integer rv_f03_input_add_not_most_rec    ;// rv_f03_input_add_not_most_rec;
                    integer rv_d30_derog_count               ;// rv_d30_derog_count;
                    integer rv_d32_criminal_behavior_lvl     ;// rv_d32_criminal_behavior_lvl;
                    string rv_d32_criminal_x_felony         ;// rv_d32_criminal_x_felony;
                    integer _criminal_last_date              ;// _criminal_last_date;
                    integer rv_d32_mos_since_crim_ls         ;// rv_d32_mos_since_crim_ls;
                    integer _felony_last_date                ;// _felony_last_date;
                    integer rv_d32_mos_since_fel_ls          ;// rv_d32_mos_since_fel_ls;
                    integer rv_d31_bk_index_lvl              ;// rv_d31_bk_index_lvl;
                    integer rv_d31_bk_chapter                ;// rv_d31_bk_chapter;
                    integer rv_d31_attr_bankruptcy_recency   ;// rv_d31_attr_bankruptcy_recency;
                    integer rv_d31_bk_disposed_recent_count  ;// rv_d31_bk_disposed_recent_count;
                    integer rv_d31_bk_disposed_hist_count    ;// rv_d31_bk_disposed_hist_count;
                    integer rv_d31_bk_dism_hist_count        ;// rv_d31_bk_dism_hist_count;
                    integer rv_d34_unrel_lien60_count        ;// rv_d34_unrel_lien60_count;
                    string iv_d34_liens_unrel_x_rel         ;// iv_d34_liens_unrel_x_rel;
                    integer rv_c20_m_bureau_adl_fs           ;// rv_c20_m_bureau_adl_fs;
                    integer _header_first_seen               ;// _header_first_seen;
                    integer rv_c10_m_hdr_fs                  ;// rv_c10_m_hdr_fs;
                    integer rv_c12_num_nonderogs             ;// rv_c12_num_nonderogs;
                    real rv_c12_source_profile            ;// rv_c12_source_profile;
                    integer rv_c15_ssns_per_adl              ;// rv_c15_ssns_per_adl;
                    integer rv_s66_adlperssn_count           ;// rv_s66_adlperssn_count;
                    integer yr_in_dob                        ;// yr_in_dob;
                    integer yr_in_dob_int                    ;// yr_in_dob_int;
                    integer rv_comb_age                      ;// rv_comb_age;
                    integer rv_f03_address_match             ;// rv_f03_address_match;
                    integer rv_a44_curr_add_naprop           ;// rv_a44_curr_add_naprop;
                    integer rv_l80_inp_avm_autoval           ;// rv_l80_inp_avm_autoval;
                    integer rv_a46_curr_avm_autoval          ;// rv_a46_curr_avm_autoval;
                    integer rv_a49_curr_avm_chg_1yr          ;// rv_a49_curr_avm_chg_1yr;
                    real rv_a49_curr_avm_chg_1yr_pct      ;// rv_a49_curr_avm_chg_1yr_pct;
                    integer rv_c13_curr_addr_lres            ;// rv_c13_curr_addr_lres;
                    integer rv_c13_max_lres                  ;// rv_c13_max_lres;
                    integer rv_c14_addrs_5yr                 ;// rv_c14_addrs_5yr;
                    integer rv_c14_addrs_10yr                ;// rv_c14_addrs_10yr;
                    integer rv_c14_addrs_15yr                ;// rv_c14_addrs_15yr;
                    integer rv_c22_inp_addr_occ_index        ;// rv_c22_inp_addr_occ_index;
                    integer rv_c22_inp_addr_owned_not_occ    ;// rv_c22_inp_addr_owned_not_occ;
                    integer rv_f04_curr_add_occ_index        ;// rv_f04_curr_add_occ_index;
                    integer rv_a41_prop_owner                ;// rv_a41_prop_owner;
                    integer rv_a41_a42_prop_owner_history    ;// rv_a41_a42_prop_owner_history;
                    integer rv_ever_asset_owner              ;// rv_ever_asset_owner;
                    integer rv_e55_college_ind               ;// rv_e55_college_ind;
                    integer rv_e57_prof_license_br_flag      ;// rv_e57_prof_license_br_flag;
                    integer rv_i60_inq_count12               ;// rv_i60_inq_count12;
                    integer rv_i60_credit_seeking            ;// rv_i60_credit_seeking;
                    integer rv_i60_inq_recency               ;// rv_i60_inq_recency;
                    integer rv_i60_inq_auto_recency          ;// rv_i60_inq_auto_recency;
                    integer rv_i60_inq_banking_count12       ;// rv_i60_inq_banking_count12;
                    integer rv_i60_inq_banking_recency       ;// rv_i60_inq_banking_recency;
                    integer rv_i60_inq_hiriskcred_count12    ;// rv_i60_inq_hiriskcred_count12;
                    integer rv_i60_inq_comm_count12          ;// rv_i60_inq_comm_count12;
                    integer rv_i60_inq_other_count12         ;// rv_i60_inq_other_count12;
                    integer rv_i62_inq_ssns_per_adl          ;// rv_i62_inq_ssns_per_adl;
                    integer rv_i62_inq_addrs_per_adl         ;// rv_i62_inq_addrs_per_adl;
                    integer rv_i62_inq_num_names_per_adl     ;// rv_i62_inq_num_names_per_adl;
                    integer rv_i62_inq_phones_per_adl        ;// rv_i62_inq_phones_per_adl;
                    integer rv_i62_inq_dobs_per_adl          ;// rv_i62_inq_dobs_per_adl;
                    integer rv_i62_inq_addrsperadl_recency   ;// rv_i62_inq_addrsperadl_recency;
                    integer rv_i62_inq_fnamesperadl_recency  ;// rv_i62_inq_fnamesperadl_recency;
                    integer rv_l79_adls_per_addr_curr        ;// rv_l79_adls_per_addr_curr;
                    integer rv_l79_adls_per_apt_addr         ;// rv_l79_adls_per_apt_addr;
                    integer rv_l79_adls_per_sfd_addr         ;// rv_l79_adls_per_sfd_addr;
                    integer rv_l79_adls_per_apt_addr_c6      ;// rv_l79_adls_per_apt_addr_c6;
                    integer rv_c18_invalid_addrs_per_adl     ;// rv_c18_invalid_addrs_per_adl;
                    integer rv_l78_no_phone_at_addr_vel      ;// rv_l78_no_phone_at_addr_vel;
                    integer rv_c13_attr_addrs_recency        ;// rv_c13_attr_addrs_recency;
                    string iv_rv5_unscorable                ;// iv_rv5_unscorable;
                    integer iv_f00_nas_summary               ;// iv_f00_nas_summary;
                    integer rv_f01_inp_addr_address_score    ;// rv_f01_inp_addr_address_score;
                    integer iv_fname_non_phn_src_ct          ;// iv_fname_non_phn_src_ct;
                    integer iv_lname_non_phn_src_ct          ;// iv_lname_non_phn_src_ct;
                    integer iv_full_name_non_phn_src_ct      ;// iv_full_name_non_phn_src_ct;
                    integer iv_full_name_ver_sources         ;// iv_full_name_ver_sources;
                    integer iv_addr_non_phn_src_ct           ;// iv_addr_non_phn_src_ct;
                    boolean iv_nas_fname_verd                ;// iv_nas_fname_verd;
                    integer iv_c13_avg_lres                  ;// iv_c13_avg_lres;
                    integer rv_c13_inp_addr_lres             ;// rv_c13_inp_addr_lres;
                    integer rv_c12_inp_addr_source_count     ;// rv_c12_inp_addr_source_count;
                    string mortgage_type                    ;// mortgage_type;
                    boolean mortgage_present                 ;// mortgage_present;
                    string iv_inp_addr_mortgage_type        ;// iv_inp_addr_mortgage_type;
                    string iv_curr_add_financing_type       ;// iv_curr_add_financing_type;
                    integer rv_a49_curr_add_avm_chg_2yr      ;// rv_a49_curr_add_avm_chg_2yr;
                    real rv_a49_curr_add_avm_pct_chg_2yr  ;// rv_a49_curr_add_avm_pct_chg_2yr;
                    integer rv_a49_curr_add_avm_chg_3yr      ;// rv_a49_curr_add_avm_chg_3yr;
                    real rv_a49_curr_add_avm_pct_chg_3yr  ;// rv_a49_curr_add_avm_pct_chg_3yr;
                    integer iv_prv_addr_lres                 ;// iv_prv_addr_lres;
                    integer iv_prv_addr_avm_auto_val         ;// iv_prv_addr_avm_auto_val;
                    integer iv_input_best_name_match         ;// iv_input_best_name_match;
                    integer iv_best_ssn_prior_dob            ;// iv_best_ssn_prior_dob;
                    integer iv_prop1_purch_sale_diff         ;// iv_prop1_purch_sale_diff;
                    integer iv_prop2_purch_sale_diff         ;// iv_prop2_purch_sale_diff;
                    integer iv_a46_l77_addrs_move_traj_index ;// iv_a46_l77_addrs_move_traj_index;
                    integer iv_unverified_addr_count         ;// iv_unverified_addr_count;
                    integer iv_c14_addrs_per_adl             ;// iv_c14_addrs_per_adl;
                    integer br_first_seen_char               ;// br_first_seen_char;
                    integer _br_first_seen                   ;// _br_first_seen;
                    integer rv_mos_since_br_first_seen       ;// rv_mos_since_br_first_seen;
                    string rv_e58_br_dead_bus_x_active_phn  ;// rv_e58_br_dead_bus_x_active_phn;
                    integer iv_d34_released_liens_ct         ;// iv_d34_released_liens_ct;
                    integer iv_d34_liens_rel_cj_ct           ;// iv_d34_liens_rel_cj_ct;
                    string iv_college_major                 ;// iv_college_major;
                    string iv_college_code_x_type           ;// iv_college_code_x_type;
                    string iv_college_file_type             ;// iv_college_file_type;
                    string iv_prof_license_category_pl      ;// iv_prof_license_category_pl;
                    integer iv_estimated_income              ;// iv_estimated_income;
                    integer iv_wealth_index                  ;// iv_wealth_index;
                    integer num_lname_sources                ;// num_lname_sources;
                    integer iv_lname_bureau_only             ;// iv_lname_bureau_only;
                    integer _in_dob                          ;// _in_dob;
                    integer earliest_bureau_date             ;// earliest_bureau_date;
                    integer earliest_bureau_yrs              ;// earliest_bureau_yrs;
                    integer calc_dob                         ;// calc_dob;
                    integer iv_bureau_emergence_age          ;// iv_bureau_emergence_age;
                    integer earliest_header_date             ;// earliest_header_date;
                    integer earliest_header_yrs              ;// earliest_header_yrs;
                    integer iv_header_emergence_age          ;// iv_header_emergence_age;
                    integer earliest_behavioral_date         ;// earliest_behavioral_date;
                    integer earliest_inperson_date           ;// earliest_inperson_date;
                    integer earliest_source_date             ;// earliest_source_date;
                    integer iv_emergence_source_type         ;// iv_emergence_source_type;
                    integer src_inperson                     ;// src_inperson;
                    integer iv_num_inperson_sources          ;// iv_num_inperson_sources;
                    integer iv_num_non_bureau_sources        ;// iv_num_non_bureau_sources;
                    integer iv_src_voter_adl_count           ;// iv_src_voter_adl_count;
                    integer vo_pos                           ;// vo_pos;
                    string vote_adl_lseen_vo                ;// vote_adl_lseen_vo;
                    integer _vote_adl_lseen_vo               ;// _vote_adl_lseen_vo;
                    integer iv_mos_src_voter_adl_lseen       ;// iv_mos_src_voter_adl_lseen;
                    integer num_dob_match_level              ;// num_dob_match_level;
                    integer nas_summary_ver                  ;// nas_summary_ver;
                    integer nap_summary_ver                  ;// nap_summary_ver;
                    integer infutor_nap_ver                  ;// infutor_nap_ver;
                    integer dob_ver                          ;// dob_ver;
                    integer sufficiently_verified            ;// sufficiently_verified;
                    string add_ec1                          ;// add_ec1;
                    integer addr_validation_problem          ;// addr_validation_problem;
                    integer phn_validation_problem           ;// phn_validation_problem;
                    integer validation_problem               ;// validation_problem;
                    integer tot_liens                        ;// tot_liens;
                    integer tot_liens_w_type                 ;// tot_liens_w_type;
                    integer has_derog                        ;// has_derog;
                    string rv_6seg_riskview_5_0             ;// rv_6seg_riskview_5_0;
                    string rv_4seg_riskview_5_0             ;// rv_4seg_riskview_5_0;
                    real final_score_tree_0               ;// final_score_tree_0;
                    real final_score_tree_1               ;// final_score_tree_1;
                    real final_score_tree_2               ;// final_score_tree_2;
                    real final_score_tree_3               ;// final_score_tree_3;
                    real final_score_tree_4               ;// final_score_tree_4;
                    real final_score_tree_5               ;// final_score_tree_5;
                    real final_score_tree_6               ;// final_score_tree_6;
                    real final_score_tree_7               ;// final_score_tree_7;
                    real final_score_tree_8               ;// final_score_tree_8;
                    real final_score_tree_9               ;// final_score_tree_9;
                    real final_score_tree_10              ;// final_score_tree_10;
                    real final_score_tree_11              ;// final_score_tree_11;
                    real final_score_tree_12              ;// final_score_tree_12;
                    real final_score_tree_13              ;// final_score_tree_13;
                    real final_score_tree_14              ;// final_score_tree_14;
                    real final_score_tree_15              ;// final_score_tree_15;
                    real final_score_tree_16              ;// final_score_tree_16;
                    real final_score_tree_17              ;// final_score_tree_17;
                    real final_score_tree_18              ;// final_score_tree_18;
                    real final_score_tree_19              ;// final_score_tree_19;
                    real final_score_tree_20              ;// final_score_tree_20;
                    real final_score_tree_21              ;// final_score_tree_21;
                    real final_score_tree_22              ;// final_score_tree_22;
                    real final_score_tree_23              ;// final_score_tree_23;
                    real final_score_tree_24              ;// final_score_tree_24;
                    real final_score_tree_25              ;// final_score_tree_25;
                    real final_score_tree_26              ;// final_score_tree_26;
                    real final_score_tree_27              ;// final_score_tree_27;
                    real final_score_tree_28              ;// final_score_tree_28;
                    real final_score_tree_29              ;// final_score_tree_29;
                    real final_score_tree_30              ;// final_score_tree_30;
                    real final_score_tree_31              ;// final_score_tree_31;
                    real final_score_tree_32              ;// final_score_tree_32;
                    real final_score_tree_33              ;// final_score_tree_33;
                    real final_score_tree_34              ;// final_score_tree_34;
                    real final_score_tree_35              ;// final_score_tree_35;
                    real final_score_tree_36              ;// final_score_tree_36;
                    real final_score_tree_37              ;// final_score_tree_37;
                    real final_score_tree_38              ;// final_score_tree_38;
                    real final_score_tree_39              ;// final_score_tree_39;
                    real final_score_tree_40              ;// final_score_tree_40;
                    real final_score_tree_41              ;// final_score_tree_41;
                    real final_score_tree_42              ;// final_score_tree_42;
                    real final_score_tree_43              ;// final_score_tree_43;
                    real final_score_tree_44              ;// final_score_tree_44;
                    real final_score_tree_45              ;// final_score_tree_45;
                    real final_score_tree_46              ;// final_score_tree_46;
                    real final_score_tree_47              ;// final_score_tree_47;
                    real final_score_tree_48              ;// final_score_tree_48;
                    real final_score_tree_49              ;// final_score_tree_49;
                    real final_score_tree_50              ;// final_score_tree_50;
                    real final_score_tree_51              ;// final_score_tree_51;
                    real final_score_tree_52              ;// final_score_tree_52;
                    real final_score_tree_53              ;// final_score_tree_53;
                    real final_score_tree_54              ;// final_score_tree_54;
                    real final_score_tree_55              ;// final_score_tree_55;
                    real final_score_tree_56              ;// final_score_tree_56;
                    real final_score_tree_57              ;// final_score_tree_57;
                    real final_score_tree_58              ;// final_score_tree_58;
                    real final_score_tree_59              ;// final_score_tree_59;
                    real final_score_tree_60              ;// final_score_tree_60;
                    real final_score_tree_61              ;// final_score_tree_61;
                    real final_score_tree_62              ;// final_score_tree_62;
                    real final_score_tree_63              ;// final_score_tree_63;
                    real final_score_tree_64              ;// final_score_tree_64;
                    real final_score_tree_65              ;// final_score_tree_65;
                    real final_score_tree_66              ;// final_score_tree_66;
                    real final_score_tree_67              ;// final_score_tree_67;
                    real final_score_tree_68              ;// final_score_tree_68;
                    real final_score_tree_69              ;// final_score_tree_69;
                    real final_score_tree_70              ;// final_score_tree_70;
                    real final_score_tree_71              ;// final_score_tree_71;
                    real final_score_tree_72              ;// final_score_tree_72;
                    real final_score_tree_73              ;// final_score_tree_73;
                    real final_score_tree_74              ;// final_score_tree_74;
                    real final_score_tree_75              ;// final_score_tree_75;
                    real final_score_tree_76              ;// final_score_tree_76;
                    real final_score_tree_77              ;// final_score_tree_77;
                    real final_score_tree_78              ;// final_score_tree_78;
                    real final_score_tree_79              ;// final_score_tree_79;
                    real final_score_tree_80              ;// final_score_tree_80;
                    real final_score_tree_81              ;// final_score_tree_81;
                    real final_score_tree_82              ;// final_score_tree_82;
                    real final_score_tree_83              ;// final_score_tree_83;
                    real final_score_tree_84              ;// final_score_tree_84;
                    real final_score_tree_85              ;// final_score_tree_85;
                    real final_score_tree_86              ;// final_score_tree_86;
                    real final_score_tree_87              ;// final_score_tree_87;
                    real final_score_tree_88              ;// final_score_tree_88;
                    real final_score_tree_89              ;// final_score_tree_89;
                    real final_score_tree_90              ;// final_score_tree_90;
                    real final_score_tree_91              ;// final_score_tree_91;
                    real final_score_tree_92              ;// final_score_tree_92;
                    real final_score_tree_93              ;// final_score_tree_93;
                    real final_score_tree_94              ;// final_score_tree_94;
                    real final_score_tree_95              ;// final_score_tree_95;
                    real final_score_tree_96              ;// final_score_tree_96;
                    real final_score_tree_97              ;// final_score_tree_97;
                    real final_score_tree_98              ;// final_score_tree_98;
                    real final_score_tree_99              ;// final_score_tree_99;
                    real final_score_tree_100             ;// final_score_tree_100;
                    real final_score_tree_101             ;// final_score_tree_101;
                    real final_score_tree_102             ;// final_score_tree_102;
                    real final_score_tree_103             ;// final_score_tree_103;
                    real final_score_tree_104             ;// final_score_tree_104;
                    real final_score_tree_105             ;// final_score_tree_105;
                    real final_score_tree_106             ;// final_score_tree_106;
                    real final_score_tree_107             ;// final_score_tree_107;
                    real final_score_tree_108             ;// final_score_tree_108;
                    real final_score_tree_109             ;// final_score_tree_109;
                    real final_score_tree_110             ;// final_score_tree_110;
                    real final_score_tree_111             ;// final_score_tree_111;
                    real final_score_tree_112             ;// final_score_tree_112;
                    real final_score_tree_113             ;// final_score_tree_113;
                    real final_score_tree_114             ;// final_score_tree_114;
                    real final_score_tree_115             ;// final_score_tree_115;
                    real final_score_tree_116             ;// final_score_tree_116;
                    real final_score_tree_117             ;// final_score_tree_117;
                    real final_score_tree_118             ;// final_score_tree_118;
                    real final_score_tree_119             ;// final_score_tree_119;
                    real final_score_tree_120             ;// final_score_tree_120;
                    real final_score_tree_121             ;// final_score_tree_121;
                    real final_score_tree_122             ;// final_score_tree_122;
                    real final_score_tree_123             ;// final_score_tree_123;
                    real final_score_tree_124             ;// final_score_tree_124;
                    real final_score_tree_125             ;// final_score_tree_125;
                    real final_score_tree_126             ;// final_score_tree_126;
                    real final_score_tree_127             ;// final_score_tree_127;
                    real final_score_tree_128             ;// final_score_tree_128;
                    real final_score_tree_129             ;// final_score_tree_129;
                    real final_score_tree_130             ;// final_score_tree_130;
                    real final_score_tree_131             ;// final_score_tree_131;
                    real final_score_tree_132             ;// final_score_tree_132;
                    real final_score_tree_133             ;// final_score_tree_133;
                    real final_score_tree_134             ;// final_score_tree_134;
                    real final_score_tree_135             ;// final_score_tree_135;
                    real final_score_tree_136             ;// final_score_tree_136;
                    real final_score_tree_137             ;// final_score_tree_137;
                    real final_score_tree_138             ;// final_score_tree_138;
                    real final_score_tree_139             ;// final_score_tree_139;
                    real final_score_gbm_logit            ;// final_score_gbm_logit;
                    integer deceased                         ;// deceased;
                    integer base                             ;// base;
                    integer pts                              ;// pts;
                    real lgt                              ;// lgt;
                    integer rvp1702_1_0                      ;// rvp1702_1_0;

			
			Risk_Indicators.Layout_Boca_Shell clam;
		END;
		
		Layout_Debug doModel(clam le) := TRANSFORM
	#else
		Layout_ModelOut doModel(clam le) := TRANSFORM
	#end



	/* ***********************************************************
	 *             Model Input Variable Assignments              *
	 ************************************************************* */
	 
	NULL := -999999999;
	sNULL := (STRING)null;
	 
	 
	//sysdate                          := ;
	inq_addrsperadl_count01          := le.acc_logs.inq_addrsperadl_count01;
	inq_addrsperadl_count03          := le.acc_logs.inq_addrsperadl_count03;
	inq_addrsperadl_count06          := le.acc_logs.inq_addrsperadl_count06;
	inq_fnamesperadl_count01         := le.acc_logs.inq_fnamesperadl_count01;
	inq_fnamesperadl_count03         := le.acc_logs.inq_fnamesperadl_count03;
	inq_fnamesperadl_count06         := le.acc_logs.inq_fnamesperadl_count06;
	input_fname_isbestmatch          := le.best_flags.input_fname_isbestmatch;
	input_lname_isbestmatch          := le.best_flags.input_lname_isbestmatch;
	best_ssn_ssndobflag              := le.best_flags.best_ssn_ssndobflag;
	in_addrpop_found                 := le.adl_Shell_Flags.in_addrpop_found;
	adl_dob                          := le.adl_shell_flags.adl_dob;
	adl_hphn                         := le.adl_shell_flags.adl_hphn;
	truedid                          := le.truedid;
	out_unit_desig                   := le.shell_input.unit_desig;
	out_sec_range                    := le.shell_input.sec_range;
	out_z5                           := le.shell_input.z5;
	out_addr_type                    := le.shell_input.addr_type;
	out_addr_status                  := le.shell_input.addr_status;
	in_dob                           := le.shell_input.dob;
	nas_summary                      := le.iid.nas_summary;
	nap_summary                      := le.iid.nap_summary;
	rc_ssndod                        := le.ssn_verification.validation.deceasedDate;
	rc_input_addr_not_most_recent    := (integer)le.iid.inputaddrnotmostrecent;
	rc_hriskphoneflag                := le.iid.hriskphoneflag;
	rc_hphonetypeflag                := le.iid.hphonetypeflag;
	rc_phonevalflag                  := le.iid.phonevalflag;
	rc_hphonevalflag                 := le.iid.hphonevalflag;
	rc_hriskaddrflag                 := le.iid.hriskaddrflag;
	rc_decsflag                      := le.iid.decsflag;
	rc_addrvalflag                   := le.iid.addrvalflag;
	rc_dwelltype                     := le.iid.dwelltype;
	rc_fnamecount                    := le.iid.firstcount;
	// rc_lnamecount                    := if(isFCRA, 0, le.iid.lastcount);
	rc_lnamecount                    := le.iid.lastcount;
	rc_addrcount                     := le.iid.addrcount;
	rc_addrcommflag                  := le.iid.addrcommflag;
	rc_hrisksic                      := le.iid.hrisksic;
	rc_hrisksicphone                 := le.iid.hrisksicphone;
	rc_phonetype                     := le.iid.phonetype;
	rc_ziptypeflag                   := le.iid.ziptypeflag;
	hdr_source_profile               := le.source_profile;
	ver_sources                      := le.header_summary.ver_sources;
	ver_sources_first_seen           := le.header_summary.ver_sources_first_seen_date;
	ver_sources_last_seen            := le.header_summary.ver_sources_last_seen_date;
	ver_sources_count                := le.header_summary.ver_sources_recordcount;
	ver_lname_sources                := le.header_summary.ver_lname_sources;
	voter_avail                      := le.available_sources.voter;
	fnamepop                         := le.input_validation.firstname;
	lnamepop                         := le.input_validation.lastname;
	addrpop                          := le.input_validation.address;
	ssnlength                        := le.input_validation.ssn_length;
	dobpop                           := le.input_validation.dateofbirth;
	hphnpop                          := le.input_validation.homephone;
	source_count                     := le.name_verification.source_count;
	fname_eda_sourced_type           := le.name_verification.fname_eda_sourced_type;
	lname_eda_sourced_type           := le.name_verification.lname_eda_sourced_type;
	add_input_address_score          := le.address_verification.input_address_information.address_score;
	add_input_isbestmatch            := le.address_verification.input_address_information.isbestmatch;
	add_input_lres                   := le.lres;
	add_input_dirty_address          := le.address_verification.inputaddr_dirty;
	add_input_owned_not_occ          := le.address_verification.inputaddr_owned_not_occupied;
	add_input_occ_index              := le.address_verification.inputaddr_occupancy_index;
	add_input_advo_vacancy           := le.advo_input_addr.Address_Vacancy_Indicator;
	add_input_advo_res_or_bus        := le.advo_input_addr.Residential_or_Business_Ind;
	add_input_avm_auto_val           := le.avm.input_address_information.avm_automated_valuation;
	add_input_source_count           := le.address_verification.input_address_information.source_count;
	add_input_naprop                 := le.address_verification.input_address_information.naprop;
	add_input_mortgage_date          := le.address_verification.input_address_information.mortgage_date;
	add_input_mortgage_type          := le.address_verification.input_address_information.mortgage_type;
	add_input_pop                    := le.addrPop;
	property_owned_total             := le.address_verification.owned.property_total;
	prop1_sale_price                 := le.address_verification.recent_property_sales.sale_price1;
	prop1_prev_purchase_price        := le.address_verification.recent_property_sales.prev_purch_price1;
	prop2_sale_price                 := le.address_verification.recent_property_sales.sale_price2;
	prop2_prev_purchase_price        := le.address_verification.recent_property_sales.prev_purch_price2;
	add_curr_isbestmatch             := le.address_verification.address_history_1.isbestmatch;
	add_curr_lres                    := le.lres2;
	add_curr_occ_index               := le.address_verification.currAddr_occupancy_index;
	add_curr_avm_auto_val            := le.avm.address_history_1.avm_automated_valuation;
	add_curr_avm_auto_val_2          := le.avm.address_history_1.avm_automated_valuation2;
	add_curr_avm_auto_val_3          := le.avm.address_history_1.avm_automated_valuation3;
	add_curr_avm_auto_val_4          := le.avm.address_history_1.avm_automated_valuation4;
	add_curr_naprop                  := le.address_verification.address_history_1.naprop;
	add_curr_financing_type          := le.address_verification.address_history_1.type_financing;
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
	addrs_move_trajectory_index      := le.economic_trajectory_index;
	unverified_addr_count            := le.address_verification.unverified_addr_count;
	telcordia_type                   := le.phone_verification.telcordia_type;
	header_first_seen                := le.ssn_verification.header_first_seen;
	ssns_per_adl                     := le.velocity_counters.ssns_per_adl;
	addrs_per_adl                    := le.velocity_counters.addrs_per_adl;
	adls_per_ssn                     := le.SSN_Verification.adlPerSSN_count;
	adls_per_addr_curr               := le.velocity_counters.adls_per_addr_current;
	ssns_per_addr_curr               := le.velocity_counters.ssns_per_addr_current;
	phones_per_addr_curr             := le.velocity_counters.phones_per_addr_current;
	adls_per_addr_c6                 := le.velocity_counters.adls_per_addr_created_6months;
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
	inq_communications_count03       := le.acc_logs.communications.count03;
	inq_communications_count12       := le.acc_logs.communications.count12;
	inq_highriskcredit_count12       := le.acc_logs.highriskcredit.count12;
	inq_mortgage_count03             := le.acc_logs.mortgage.count03;
	inq_other_count12                := le.acc_logs.other.count12;
	inq_retail_count03               := le.acc_logs.retail.count03;
	inq_ssnsperadl                   := le.acc_logs.inquiryssnsperadl;
	inq_addrsperadl                  := le.acc_logs.inquiryaddrsperadl;
  inq_lnamesperadl                 := if(isFCRA, 0, le.acc_logs.inquirylnamesperadl);
	//inq_lnamesperadl                 := le.acc_logs.inquirylnamesperadl;
	inq_fnamesperadl                 := le.acc_logs.inquiryfnamesperadl;
	inq_phonesperadl                 := le.acc_logs.inquiryphonesperadl;
	inq_dobsperadl                   := le.acc_logs.inquirydobsperadl;
	br_first_seen                    := le.employment.first_seen_date;
	br_dead_business_count           := le.employment.dead_business_ct;
	br_active_phone_count            := le.employment.business_active_phone_ct;
	br_source_count                  := le.employment.source_ct;
	infutor_nap                      := le.infutor_phone.infutor_nap;
	stl_inq_count24                  := le.impulse.count24;
	attr_addrs_last30                := le.other_address_info.addrs_last30;
	attr_addrs_last90                := le.other_address_info.addrs_last90;
	attr_addrs_last12                := le.other_address_info.addrs_last12;
	attr_addrs_last24                := le.other_address_info.addrs_last24;
	attr_addrs_last36                := le.other_address_info.addrs_last36;
	attr_num_aircraft                := le.aircraft.aircraft_count;
	attr_total_number_derogs         := le.total_number_derogs;
	attr_num_unrel_liens60           := le.bjl.liens_unreleased_count60;
	attr_bankruptcy_count30          := le.bjl.bk_count30;
	attr_bankruptcy_count90          := le.bjl.bk_count90;
	attr_bankruptcy_count180         := le.bjl.bk_count180;
	attr_bankruptcy_count12          := le.bjl.bk_count12;
	attr_bankruptcy_count24          := le.bjl.bk_count24;
	attr_bankruptcy_count36          := le.bjl.bk_count36;
	attr_bankruptcy_count60          := le.bjl.bk_count60;
	attr_eviction_count              := le.bjl.eviction_count;
	attr_num_nonderogs               := le.source_verification.num_nonderogs;
	bankrupt                         := le.bjl.bankrupt;
	disposition                      := le.bjl.disposition;
	filing_count                     := le.bjl.filing_count;
	bk_dismissed_recent_count        := le.bjl.bk_dismissed_recent_count;
	bk_dismissed_historical_count    := le.bjl.bk_dismissed_historical_count;
	bk_chapter                       := le.bjl.bk_chapter;
	bk_disposed_recent_count         := le.bjl.bk_disposed_recent_count;
	bk_disposed_historical_count     := le.bjl.bk_disposed_historical_count;
	//liens_recent_unreleased_count    := le.liens_recent_unreleased_count;
	liens_recent_unreleased_count    := le.bjl.liens_recent_unreleased_count;
	liens_historical_unreleased_ct   := le.bjl.liens_historical_unreleased_count;
	liens_recent_released_count      := le.bjl.liens_recent_released_count;
	liens_historical_released_count  := le.bjl.liens_historical_released_count;
	liens_unrel_cj_ct                := le.liens.liens_unreleased_civil_judgment.count;
	liens_rel_cj_ct                  := le.liens.liens_released_civil_judgment.count;
	liens_unrel_ft_ct                := le.liens.liens_unreleased_federal_tax.count;
	liens_rel_ft_ct                  := le.liens.liens_released_federal_tax.count;
	liens_unrel_fc_ct                := le.liens.liens_unreleased_foreclosure.count;
	liens_rel_fc_ct                  := le.liens.liens_released_foreclosure.count;
	liens_unrel_lt_ct                := le.liens.liens_unreleased_landlord_tenant.count;
	liens_rel_lt_ct                  := le.liens.liens_released_landlord_tenant.count;
	liens_unrel_o_ct                 := le.liens.liens_unreleased_other_lj.count;
	liens_rel_o_ct                   := le.liens.liens_released_other_lj.count;
	liens_unrel_ot_ct                := le.liens.liens_unreleased_other_tax.count;
	liens_rel_ot_ct                  := le.liens.liens_released_other_tax.count;
	liens_unrel_sc_ct                := le.liens.liens_unreleased_small_claims.count;
	liens_rel_sc_ct                  := le.liens.liens_released_small_claims.count;
	liens_unrel_st_ct                := le.liens.liens_unreleased_suits.count;
	liens_rel_st_ct                  := le.liens.liens_released_suits.count;
	criminal_count                   := le.bjl.criminal_count;
	criminal_last_date               := le.bjl.last_criminal_date;
	felony_count                     := le.bjl.felony_count;
	felony_last_date                 := le.bjl.last_felony_date;
	watercraft_count                 := le.watercraft.watercraft_count;
	college_date_first_seen          := (unsigned)le.student.date_first_seen;
	college_code                     := le.student.college_code;
	college_type                     := le.student.college_type;
	college_file_type                := le.student.file_type2;
	college_major                    := le.student.college_major;
	college_attendance               := le.attended_college;
	prof_license_flag                := le.professional_license.professional_license_flag;
	prof_license_category            := le.professional_license.plcategory;
	prof_license_source              := le.professional_license.proflic_source;
	wealth_index                     := le.wealth_indicator;
	input_dob_match_level            := le.dobmatchlevel;
	inferred_age                     := le.inferred_age;
	estimated_income                 := le.estimated_income;

	/* ***********************************************************
	 *                    Generated ECL                          *
	 ************************************************************* */
	
	INTEGER contains_i( string haystack, string needle ) := (INTEGER)(StringLib.StringFind(haystack, needle, 1) > 0);
	
	sysdate :=  __common__(common.sas_date(if(le.historydate=999999, (STRING)Std.Date.Today(), (string6)le.historydate+'01')));
	// sysdate :=  __common__(20209;
	
	//NULL :=  __common__(-999999999;


ver_src_ak_pos :=  __common__(Models.Common.findw_cpp(ver_sources, 'AK' , '  ,', 'ie'));

ver_src_ak :=  __common__(ver_src_ak_pos > 0);

_ver_src_fdate_ak :=  __common__(if(ver_src_ak_pos > 0, Models.Common.getw(ver_sources_first_seen, ver_src_ak_pos), '0'));

ver_src_fdate_ak :=  __common__(common.sas_date((string)(_ver_src_fdate_ak)));

ver_src_am_pos :=  __common__(Models.Common.findw_cpp(ver_sources, 'AM' , '  ,', 'ie'));

ver_src_am :=  __common__(ver_src_am_pos > 0);

_ver_src_fdate_am :=  __common__(if(ver_src_am_pos > 0, Models.Common.getw(ver_sources_first_seen, ver_src_am_pos), '0'));

ver_src_fdate_am :=  __common__(common.sas_date((string)(_ver_src_fdate_am)));

ver_src_ar_pos :=  __common__(Models.Common.findw_cpp(ver_sources, 'AR' , '  ,', 'ie'));

ver_src_ar :=  __common__(ver_src_ar_pos > 0);

_ver_src_fdate_ar :=  __common__(if(ver_src_ar_pos > 0, Models.Common.getw(ver_sources_first_seen, ver_src_ar_pos), '0'));

ver_src_fdate_ar :=  __common__(common.sas_date((string)(_ver_src_fdate_ar)));

ver_src_ba_pos :=  __common__(Models.Common.findw_cpp(ver_sources, 'BA' , '  ,', 'ie'));

ver_src_ba :=  __common__(ver_src_ba_pos > 0);

_ver_src_fdate_ba :=  __common__(if(ver_src_ba_pos > 0, Models.Common.getw(ver_sources_first_seen, ver_src_ba_pos), '0'));

ver_src_fdate_ba :=  __common__(common.sas_date((string)(_ver_src_fdate_ba)));

ver_src_cg_pos :=  __common__(Models.Common.findw_cpp(ver_sources, 'CG' , '  ,', 'ie'));

ver_src_cg :=  __common__(ver_src_cg_pos > 0);

_ver_src_fdate_cg :=  __common__(if(ver_src_cg_pos > 0, Models.Common.getw(ver_sources_first_seen, ver_src_cg_pos), '0'));

ver_src_fdate_cg :=  __common__(common.sas_date((string)(_ver_src_fdate_cg)));

ver_src_co_pos :=  __common__(Models.Common.findw_cpp(ver_sources, 'CO' , '  ,', 'ie'));

_ver_src_fdate_co :=  __common__(if(ver_src_co_pos > 0, Models.Common.getw(ver_sources_first_seen, ver_src_co_pos), '0'));

ver_src_fdate_co :=  __common__(common.sas_date((string)(_ver_src_fdate_co)));

ver_src_cy_pos :=  __common__(Models.Common.findw_cpp(ver_sources, 'CY' , '  ,', 'ie'));

ver_src_cy :=  __common__(ver_src_cy_pos > 0);

_ver_src_fdate_cy :=  __common__(if(ver_src_cy_pos > 0, Models.Common.getw(ver_sources_first_seen, ver_src_cy_pos), '0'));

ver_src_fdate_cy :=  __common__(common.sas_date((string)(_ver_src_fdate_cy)));

ver_src_da_pos :=  __common__(Models.Common.findw_cpp(ver_sources, 'DA' , '  ,', 'ie'));

ver_src_da :=  __common__(ver_src_da_pos > 0);

_ver_src_fdate_da :=  __common__(if(ver_src_da_pos > 0, Models.Common.getw(ver_sources_first_seen, ver_src_da_pos), '0'));

ver_src_fdate_da :=  __common__(common.sas_date((string)(_ver_src_fdate_da)));

ver_src_d_pos :=  __common__(Models.Common.findw_cpp(ver_sources, 'D' , '  ,', 'ie'));

ver_src_d :=  __common__(ver_src_d_pos > 0);

_ver_src_fdate_d :=  __common__(if(ver_src_d_pos > 0, Models.Common.getw(ver_sources_first_seen, ver_src_d_pos), '0'));

ver_src_fdate_d :=  __common__(common.sas_date((string)(_ver_src_fdate_d)));

ver_src_dl_pos :=  __common__(Models.Common.findw_cpp(ver_sources, 'DL' , '  ,', 'ie'));

ver_src_dl :=  __common__(ver_src_dl_pos > 0);

_ver_src_fdate_dl :=  __common__(if(ver_src_dl_pos > 0, Models.Common.getw(ver_sources_first_seen, ver_src_dl_pos), '0'));

ver_src_fdate_dl :=  __common__(common.sas_date((string)(_ver_src_fdate_dl)));

ver_src_ds_pos :=  __common__(Models.Common.findw_cpp(ver_sources, 'DS' , '  ,', 'ie'));

ver_src_ds :=  __common__(ver_src_ds_pos > 0);

_ver_src_fdate_ds :=  __common__(if(ver_src_ds_pos > 0, Models.Common.getw(ver_sources_first_seen, ver_src_ds_pos), '0'));

ver_src_fdate_ds :=  __common__(common.sas_date((string)(_ver_src_fdate_ds)));

ver_src_de_pos :=  __common__(Models.Common.findw_cpp(ver_sources, 'DE' , '  ,', 'ie'));

ver_src_de :=  __common__(ver_src_de_pos > 0);

_ver_src_fdate_de :=  __common__(if(ver_src_de_pos > 0, Models.Common.getw(ver_sources_first_seen, ver_src_de_pos), '0'));

ver_src_fdate_de :=  __common__(common.sas_date((string)(_ver_src_fdate_de)));

ver_src_eb_pos :=  __common__(Models.Common.findw_cpp(ver_sources, 'EB' , '  ,', 'ie'));

ver_src_eb :=  __common__(ver_src_eb_pos > 0);

_ver_src_fdate_eb :=  __common__(if(ver_src_eb_pos > 0, Models.Common.getw(ver_sources_first_seen, ver_src_eb_pos), '0'));

ver_src_fdate_eb :=  __common__(common.sas_date((string)(_ver_src_fdate_eb)));

ver_src_em_pos :=  __common__(Models.Common.findw_cpp(ver_sources, 'EM' , '  ,', 'ie'));

ver_src_em :=  __common__(ver_src_em_pos > 0);

_ver_src_fdate_em :=  __common__(if(ver_src_em_pos > 0, Models.Common.getw(ver_sources_first_seen, ver_src_em_pos), '0'));

ver_src_fdate_em :=  __common__(common.sas_date((string)(_ver_src_fdate_em)));

ver_src_e1_pos :=  __common__(Models.Common.findw_cpp(ver_sources, 'E1' , '  ,', 'ie'));

ver_src_e1 :=  __common__(ver_src_e1_pos > 0);

_ver_src_fdate_e1 :=  __common__(if(ver_src_e1_pos > 0, Models.Common.getw(ver_sources_first_seen, ver_src_e1_pos), '0'));

ver_src_fdate_e1 :=  __common__(common.sas_date((string)(_ver_src_fdate_e1)));

ver_src_e2_pos :=  __common__(Models.Common.findw_cpp(ver_sources, 'E2' , '  ,', 'ie'));

ver_src_e2 :=  __common__(ver_src_e2_pos > 0);

_ver_src_fdate_e2 :=  __common__(if(ver_src_e2_pos > 0, Models.Common.getw(ver_sources_first_seen, ver_src_e2_pos), '0'));

ver_src_fdate_e2 :=  __common__(common.sas_date((string)(_ver_src_fdate_e2)));

ver_src_e3_pos :=  __common__(Models.Common.findw_cpp(ver_sources, 'E3' , '  ,', 'ie'));

ver_src_e3 :=  __common__(ver_src_e3_pos > 0);

_ver_src_fdate_e3 :=  __common__(if(ver_src_e3_pos > 0, Models.Common.getw(ver_sources_first_seen, ver_src_e3_pos), '0'));

ver_src_fdate_e3 :=  __common__(common.sas_date((string)(_ver_src_fdate_e3)));

ver_src_e4_pos :=  __common__(Models.Common.findw_cpp(ver_sources, 'E4' , '  ,', 'ie'));

ver_src_e4 :=  __common__(ver_src_e4_pos > 0);

_ver_src_fdate_e4 :=  __common__(if(ver_src_e4_pos > 0, Models.Common.getw(ver_sources_first_seen, ver_src_e4_pos), '0'));

ver_src_fdate_e4 :=  __common__(common.sas_date((string)(_ver_src_fdate_e4)));

ver_src_en_pos :=  __common__(Models.Common.findw_cpp(ver_sources, 'EN' , '  ,', 'ie'));

_ver_src_fdate_en :=  __common__(if(ver_src_en_pos > 0, Models.Common.getw(ver_sources_first_seen, ver_src_en_pos), '0'));

ver_src_fdate_en :=  __common__(common.sas_date((string)(_ver_src_fdate_en)));

ver_src_eq_pos :=  __common__(Models.Common.findw_cpp(ver_sources, 'EQ' , '  ,', 'ie'));

_ver_src_fdate_eq :=  __common__(if(ver_src_eq_pos > 0, Models.Common.getw(ver_sources_first_seen, ver_src_eq_pos), '0'));

ver_src_fdate_eq :=  __common__(common.sas_date((string)(_ver_src_fdate_eq)));

ver_src_fe_pos :=  __common__(Models.Common.findw_cpp(ver_sources, 'FE' , '  ,', 'ie'));

ver_src_fe :=  __common__(ver_src_fe_pos > 0);

_ver_src_fdate_fe :=  __common__(if(ver_src_fe_pos > 0, Models.Common.getw(ver_sources_first_seen, ver_src_fe_pos), '0'));

ver_src_fdate_fe :=  __common__(common.sas_date((string)(_ver_src_fdate_fe)));

ver_src_ff_pos :=  __common__(Models.Common.findw_cpp(ver_sources, 'FF' , '  ,', 'ie'));

ver_src_ff :=  __common__(ver_src_ff_pos > 0);

_ver_src_fdate_ff :=  __common__(if(ver_src_ff_pos > 0, Models.Common.getw(ver_sources_first_seen, ver_src_ff_pos), '0'));

ver_src_fdate_ff :=  __common__(common.sas_date((string)(_ver_src_fdate_ff)));

ver_src_fr_pos :=  __common__(Models.Common.findw_cpp(ver_sources, 'FR' , '  ,', 'ie'));

ver_src_fr :=  __common__(ver_src_fr_pos > 0);

_ver_src_fdate_fr :=  __common__(if(ver_src_fr_pos > 0, Models.Common.getw(ver_sources_first_seen, ver_src_fr_pos), '0'));

ver_src_fdate_fr :=  __common__(common.sas_date((string)(_ver_src_fdate_fr)));

ver_src_l2_pos :=  __common__(Models.Common.findw_cpp(ver_sources, 'L2' , '  ,', 'ie'));

ver_src_l2 :=  __common__(ver_src_l2_pos > 0);

_ver_src_fdate_l2 :=  __common__(if(ver_src_l2_pos > 0, Models.Common.getw(ver_sources_first_seen, ver_src_l2_pos), '0'));

ver_src_fdate_l2 :=  __common__(common.sas_date((string)(_ver_src_fdate_l2)));

ver_src_li_pos :=  __common__(Models.Common.findw_cpp(ver_sources, 'LI' , '  ,', 'ie'));

ver_src_li :=  __common__(ver_src_li_pos > 0);

_ver_src_fdate_li :=  __common__(if(ver_src_li_pos > 0, Models.Common.getw(ver_sources_first_seen, ver_src_li_pos), '0'));

ver_src_fdate_li :=  __common__(common.sas_date((string)(_ver_src_fdate_li)));

ver_src_mw_pos :=  __common__(Models.Common.findw_cpp(ver_sources, 'MW' , '  ,', 'ie'));

ver_src_mw :=  __common__(ver_src_mw_pos > 0);

_ver_src_fdate_mw :=  __common__(if(ver_src_mw_pos > 0, Models.Common.getw(ver_sources_first_seen, ver_src_mw_pos), '0'));

ver_src_fdate_mw :=  __common__(common.sas_date((string)(_ver_src_fdate_mw)));

ver_src_nt_pos :=  __common__(Models.Common.findw_cpp(ver_sources, 'NT' , '  ,', 'ie'));

ver_src_nt :=  __common__(ver_src_nt_pos > 0);

_ver_src_fdate_nt :=  __common__(if(ver_src_nt_pos > 0, Models.Common.getw(ver_sources_first_seen, ver_src_nt_pos), '0'));

ver_src_fdate_nt :=  __common__(common.sas_date((string)(_ver_src_fdate_nt)));

ver_src_p_pos :=  __common__(Models.Common.findw_cpp(ver_sources, 'P' , '  ,', 'ie'));

ver_src_p :=  __common__(ver_src_p_pos > 0);

_ver_src_fdate_p :=  __common__(if(ver_src_p_pos > 0, Models.Common.getw(ver_sources_first_seen, ver_src_p_pos), '0'));

ver_src_fdate_p :=  __common__(common.sas_date((string)(_ver_src_fdate_p)));

ver_src_pl_pos :=  __common__(Models.Common.findw_cpp(ver_sources, 'PL' , '  ,', 'ie'));

ver_src_pl :=  __common__(ver_src_pl_pos > 0);

_ver_src_fdate_pl :=  __common__(if(ver_src_pl_pos > 0, Models.Common.getw(ver_sources_first_seen, ver_src_pl_pos), '0'));

ver_src_fdate_pl :=  __common__(common.sas_date((string)(_ver_src_fdate_pl)));

ver_src_tn_pos :=  __common__(Models.Common.findw_cpp(ver_sources, 'TN' , '  ,', 'ie'));

_ver_src_fdate_tn :=  __common__(if(ver_src_tn_pos > 0, Models.Common.getw(ver_sources_first_seen, ver_src_tn_pos), '0'));

ver_src_fdate_tn :=  __common__(common.sas_date((string)(_ver_src_fdate_tn)));

ver_src_ts_pos :=  __common__(Models.Common.findw_cpp(ver_sources, 'TS' , '  ,', 'ie'));

_ver_src_fdate_ts :=  __common__(if(ver_src_ts_pos > 0, Models.Common.getw(ver_sources_first_seen, ver_src_ts_pos), '0'));

ver_src_fdate_ts :=  __common__(common.sas_date((string)(_ver_src_fdate_ts)));

ver_src_tu_pos :=  __common__(Models.Common.findw_cpp(ver_sources, 'TU' , '  ,', 'ie'));

_ver_src_fdate_tu :=  __common__(if(ver_src_tu_pos > 0, Models.Common.getw(ver_sources_first_seen, ver_src_tu_pos), '0'));

ver_src_fdate_tu :=  __common__(common.sas_date((string)(_ver_src_fdate_tu)));

ver_src_sl_pos :=  __common__(Models.Common.findw_cpp(ver_sources, 'SL' , '  ,', 'ie'));

ver_src_sl :=  __common__(ver_src_sl_pos > 0);

_ver_src_fdate_sl :=  __common__(if(ver_src_sl_pos > 0, Models.Common.getw(ver_sources_first_seen, ver_src_sl_pos), '0'));

ver_src_fdate_sl :=  __common__(common.sas_date((string)(_ver_src_fdate_sl)));

ver_src_v_pos :=  __common__(Models.Common.findw_cpp(ver_sources, 'V' , '  ,', 'ie'));

ver_src_v :=  __common__(ver_src_v_pos > 0);

_ver_src_fdate_v :=  __common__(if(ver_src_v_pos > 0, Models.Common.getw(ver_sources_first_seen, ver_src_v_pos), '0'));

ver_src_fdate_v :=  __common__(common.sas_date((string)(_ver_src_fdate_v)));

ver_src_vo_pos :=  __common__(Models.Common.findw_cpp(ver_sources, 'VO' , '  ,', 'ie'));

ver_src_vo :=  __common__(ver_src_vo_pos > 0);

_ver_src_fdate_vo :=  __common__(if(ver_src_vo_pos > 0, Models.Common.getw(ver_sources_first_seen, ver_src_vo_pos), '0'));

ver_src_fdate_vo :=  __common__(common.sas_date((string)(_ver_src_fdate_vo)));

ver_src_w_pos :=  __common__(Models.Common.findw_cpp(ver_sources, 'W' , '  ,', 'ie'));

ver_src_w :=  __common__(ver_src_w_pos > 0);

_ver_src_fdate_w :=  __common__(if(ver_src_w_pos > 0, Models.Common.getw(ver_sources_first_seen, ver_src_w_pos), '0'));

ver_src_fdate_w :=  __common__(common.sas_date((string)(_ver_src_fdate_w)));

ver_src_wp_pos :=  __common__(Models.Common.findw_cpp(ver_sources, 'WP' , '  ,', 'ie'));

ver_src_wp :=  __common__(ver_src_wp_pos > 0);

_ver_src_fdate_wp :=  __common__(if(ver_src_wp_pos > 0, Models.Common.getw(ver_sources_first_seen, ver_src_wp_pos), '0'));

ver_src_fdate_wp :=  __common__(common.sas_date((string)(_ver_src_fdate_wp)));

ver_lname_src_en_pos :=  __common__(Models.Common.findw_cpp(ver_lname_sources, 'EN' , '  ,', 'ie'));

ver_lname_src_en :=  __common__(ver_lname_src_en_pos > 0);

ver_lname_src_eq_pos :=  __common__(Models.Common.findw_cpp(ver_lname_sources, 'EQ' , '  ,', 'ie'));

ver_lname_src_eq :=  __common__(ver_lname_src_eq_pos > 0);

ver_lname_src_tn_pos :=  __common__(Models.Common.findw_cpp(ver_lname_sources, 'TN' , '  ,', 'ie'));

ver_lname_src_tn :=  __common__(ver_lname_src_tn_pos > 0);

ver_lname_src_ts_pos :=  __common__(Models.Common.findw_cpp(ver_lname_sources, 'TS' , '  ,', 'ie'));

ver_lname_src_ts :=  __common__(ver_lname_src_ts_pos > 0);

ver_lname_src_tu_pos :=  __common__(Models.Common.findw_cpp(ver_lname_sources, 'TU' , '  ,', 'ie'));

ver_lname_src_tu :=  __common__(ver_lname_src_tu_pos > 0);

//sysdate :=  __common__(common.sas_date(if(le.historydate=999999, (string)ut.getdate, (string6)le.historydate+'01')));

//iv_add_apt :=  __common__(if(StringLib.StringToUpperCase(trim(rc_dwelltype, LEFT, RIGHT)) = 'A' or StringLib.StringToUpperCase(trim(out_addr_type, LEFT, RIGHT)) = 'H' or not(out_unit_desig = NULL) or not(out_sec_range = NULL), 1, 0));
iv_add_apt :=  __common__(if(StringLib.StringToUpperCase(trim(rc_dwelltype, LEFT, RIGHT)) = 'A' or StringLib.StringToUpperCase(trim(out_addr_type, LEFT, RIGHT)) = 'H' or not(out_unit_desig = '') or not(out_sec_range = ''), '1', '0'));

rv_l70_inp_addr_dirty :=  __common__(if(not(add_input_pop and truedid), NULL, (integer)add_input_dirty_address));

add_ec1_1 :=  __common__((StringLib.StringToUpperCase(trim(out_addr_status, LEFT)))[1..1]);

add_ec3 :=  __common__((StringLib.StringToUpperCase(trim(out_addr_status, LEFT)))[3..3]);

add_ec4 :=  __common__((StringLib.StringToUpperCase(trim(out_addr_status, LEFT)))[4..4]);

rv_l70_add_standardized :=  __common__(map(
    not(addrpop)                                           => NULL,
    trim(trim(add_ec1_1, LEFT), LEFT, RIGHT) = 'E'         => 2,
    add_ec1_1 = 'S' and (add_ec3 != '0' or add_ec4 != '0') => 1,
                                                              0));

iv_l77_dwelltype :=  __common__(map(
//    not(add_input_pop)  => '',
    not(add_input_pop)  => '    ',
    rc_dwelltype = '' => 'SFD',
    rc_dwelltype = 'A'  => 'MFD',
    rc_dwelltype = 'E'  => 'POB',
    rc_dwelltype = 'R'  => 'RR',
    rc_dwelltype = ''   => 'GEN',
                           ''));

rv_f03_input_add_not_most_rec :=  __common__(if(not(truedid and add_input_pop), NULL, rc_input_addr_not_most_recent));

rv_d30_derog_count :=  __common__(if(not(truedid), NULL, min(if(attr_total_number_derogs = NULL, -NULL, attr_total_number_derogs), 999)));

_felony_last_date_1 :=  __common__(common.sas_date((string)(felony_last_date)));

_criminal_last_date_1 :=  __common__(common.sas_date((string)(criminal_last_date)));

rv_d32_criminal_behavior_lvl :=  __common__(map(
    not(truedid)                                                 => NULL,
    felony_count > 0 and sysdate - _felony_last_date_1 < 365     => 6,
    criminal_count > 0 and sysdate - _criminal_last_date_1 < 365 => 5,
    felony_count > 0                                             => 4,
                                                                    min(if(criminal_count = NULL, -NULL, criminal_count), 3)));

//rv_d32_criminal_x_felony :=  __common__(if(not(truedid), '', (string)min(if(criminal_count = NULL, -NULL, criminal_count), 3) || '-' || (string)min(if(felony_count = NULL, -NULL, felony_count), 3)));
rv_d32_criminal_x_felony :=  __common__(if(not(truedid), '', (string)min(if(criminal_count = NULL, -NULL, criminal_count), 3) + '-' + (string)min(if(felony_count = NULL, -NULL, felony_count), 3)));

_criminal_last_date :=  __common__(common.sas_date((string)(criminal_last_date)));

rv_d32_mos_since_crim_ls :=  __common__(map(
    not(truedid)               => NULL,
    _criminal_last_date = NULL => -1,
                                  min(if(if ((sysdate - _criminal_last_date) / (365.25 / 12) >= 0, truncate((sysdate - _criminal_last_date) / (365.25 / 12)), roundup((sysdate - _criminal_last_date) / (365.25 / 12))) = NULL, -NULL, if ((sysdate - _criminal_last_date) / (365.25 / 12) >= 0, truncate((sysdate - _criminal_last_date) / (365.25 / 12)), roundup((sysdate - _criminal_last_date) / (365.25 / 12)))), 240)));

_felony_last_date :=  __common__(common.sas_date((string)(felony_last_date)));

rv_d32_mos_since_fel_ls :=  __common__(map(
    not(truedid)             => NULL,
    _felony_last_date = NULL => -1,
                                min(if(if ((sysdate - _felony_last_date) / (365.25 / 12) >= 0, truncate((sysdate - _felony_last_date) / (365.25 / 12)), roundup((sysdate - _felony_last_date) / (365.25 / 12))) = NULL, -NULL, if ((sysdate - _felony_last_date) / (365.25 / 12) >= 0, truncate((sysdate - _felony_last_date) / (365.25 / 12)), roundup((sysdate - _felony_last_date) / (365.25 / 12)))), 240)));

rv_d31_bk_index_lvl :=  __common__(map(
    not(truedid)                                                               => NULL,
    filing_count > 2 and bk_chapter = '7' and (boolean)attr_bankruptcy_count12 => 8,
    filing_count > 2 and (boolean)attr_bankruptcy_count12                      => 7,
    bk_chapter = '7' and (boolean)attr_bankruptcy_count12                      => 6,
 //   attr_bankruptcy_count12                                                    => 5,
    attr_bankruptcy_count12   > 0                                                 => 5,
    bk_chapter = '7'                                                           => 4,
    contains_i(StringLib.StringToUpperCase(disposition), 'DISCHARG') = 1       => 0,
    filing_count = 0                                                           => -1,
                                                                                  min(if(filing_count = NULL, -NULL, filing_count), 3)));

rv_d31_bk_chapter :=  __common__(map(
    not(truedid)      => NULL,
    bk_chapter = '' => 0,
                         (integer)trim(bk_chapter, LEFT)));

rv_d31_attr_bankruptcy_recency :=  __common__(map(
    not(truedid)             => NULL,
    attr_bankruptcy_count30 >0   => 1,
    attr_bankruptcy_count90 >0  => 3,
    attr_bankruptcy_count180 >0  => 6,
    attr_bankruptcy_count12 >0  => 12,
    attr_bankruptcy_count24 >0  => 24,
    attr_bankruptcy_count36 >0  => 36,
    attr_bankruptcy_count60 >0  => 60,
    bankrupt                  => 99,
    filing_count > 0         => 99,
                                0));

rv_d31_bk_disposed_recent_count :=  __common__(if(not(truedid), NULL, min(if(bk_disposed_recent_count = NULL, -NULL, bk_disposed_recent_count), 999)));

rv_d31_bk_disposed_hist_count :=  __common__(if(not(truedid), NULL, min(if(bk_disposed_historical_count = NULL, -NULL, bk_disposed_historical_count), 999)));

rv_d31_bk_dism_hist_count :=  __common__(if(not(truedid), NULL, min(if(bk_dismissed_historical_count = NULL, -NULL, bk_dismissed_historical_count), 999)));

rv_d34_unrel_lien60_count :=  __common__(if(not(truedid), NULL, min(if(attr_num_unrel_liens60 = NULL, -NULL, attr_num_unrel_liens60), 999)));

iv_d34_liens_unrel_x_rel :=  __common__(if(not(truedid), '', 
                              (string)min(if(if(max(liens_recent_unreleased_count, liens_historical_unreleased_ct) = NULL, NULL, 
                              sum(if(liens_recent_unreleased_count = NULL, 0, liens_recent_unreleased_count), 
                              if(liens_historical_unreleased_ct = NULL, 0, liens_historical_unreleased_ct))) = NULL, -NULL, 
                              if(max(liens_recent_unreleased_count, liens_historical_unreleased_ct) = NULL, NULL, 
                              sum(if(liens_recent_unreleased_count = NULL, 0, liens_recent_unreleased_count), 
                              if(liens_historical_unreleased_ct = NULL, 0, liens_historical_unreleased_ct)))), 3) + '-' + 
                              (string)min(if(if(max(liens_recent_released_count, liens_historical_released_count) = NULL, NULL, 
                              sum(if(liens_recent_released_count = NULL, 0, liens_recent_released_count), 
                              if(liens_historical_released_count = NULL, 0, liens_historical_released_count))) = NULL, -NULL, 
                              if(max(liens_recent_released_count, liens_historical_released_count) = NULL, NULL, 
                              sum(if(liens_recent_released_count = NULL, 0, liens_recent_released_count), 
                              if(liens_historical_released_count = NULL, 0, liens_historical_released_count)))), 2)));

rv_c20_m_bureau_adl_fs :=  __common__(map(
    not(truedid)            => NULL,
    ver_src_fdate_eq = NULL => -1,
                               min(if(if ((sysdate - ver_src_fdate_eq) / (365.25 / 12) >= 0, truncate((sysdate - ver_src_fdate_eq) / (365.25 / 12)), roundup((sysdate - ver_src_fdate_eq) / (365.25 / 12))) = NULL, -NULL, if ((sysdate - ver_src_fdate_eq) / (365.25 / 12) >= 0, truncate((sysdate - ver_src_fdate_eq) / (365.25 / 12)), roundup((sysdate - ver_src_fdate_eq) / (365.25 / 12)))), 999)));

_header_first_seen :=  __common__(common.sas_date((string)(header_first_seen)));

rv_c10_m_hdr_fs :=  __common__(map(
    not(truedid)              => NULL,
    _header_first_seen = NULL => -1,
                                 min(if(if ((sysdate - _header_first_seen) / (365.25 / 12) >= 0, truncate((sysdate - _header_first_seen) / (365.25 / 12)), roundup((sysdate - _header_first_seen) / (365.25 / 12))) = NULL, -NULL, if ((sysdate - _header_first_seen) / (365.25 / 12) >= 0, truncate((sysdate - _header_first_seen) / (365.25 / 12)), roundup((sysdate - _header_first_seen) / (365.25 / 12)))), 999)));

rv_c12_num_nonderogs :=  __common__(if(not(truedid), NULL, min(if(attr_num_nonderogs = NULL, -NULL, attr_num_nonderogs), 4)));

rv_c12_source_profile :=  __common__(if(not(truedid), NULL, hdr_source_profile));

rv_c15_ssns_per_adl :=  __common__(map(
    not(truedid)     => NULL,
    ssns_per_adl = 0 => 1,
                        min(if(ssns_per_adl = NULL, -NULL, ssns_per_adl), 999)));

rv_s66_adlperssn_count :=  __common__(map(
    not((integer)ssnlength > 0) => NULL,
    (integer)adls_per_ssn = 0   => 1,
                          min(if(adls_per_ssn = NULL, -NULL, adls_per_ssn), 999)));

_in_dob_1 :=  __common__(common.sas_date((string)(in_dob)));

yr_in_dob :=  __common__(if(_in_dob_1 = NULL, -1, (sysdate - _in_dob_1) / 365.25));

yr_in_dob_int :=  __common__(if (yr_in_dob >= 0, roundup(yr_in_dob), truncate(yr_in_dob)));

rv_comb_age :=  __common__(map(
    yr_in_dob_int > 0            => yr_in_dob_int,
    inferred_age > 0 and truedid => inferred_age,
                                    NULL));

rv_f03_address_match :=  __common__(map(
    not(truedid)                                => NULL,
    add_input_isbestmatch                       => 4,
    not(add_input_pop) and add_curr_isbestmatch => 3,
    add_input_pop and add_curr_isbestmatch      => 2,
    add_curr_pop                                => 1,
    add_input_pop                               => 0,
                                                   NULL));

rv_a44_curr_add_naprop :=  __common__(if(not(truedid and add_curr_pop), NULL, add_curr_naprop));

rv_l80_inp_avm_autoval :=  __common__(if(not(add_input_pop), NULL, add_input_avm_auto_val));

rv_a46_curr_avm_autoval :=  __common__(if(not(truedid), NULL, add_curr_avm_auto_val));

rv_a49_curr_avm_chg_1yr :=  __common__(map(
    not(truedid)                                              => NULL,
    add_curr_lres < 12                                        => NULL,
    add_curr_avm_auto_val > 0 and add_curr_avm_auto_val_2 > 0 => add_curr_avm_auto_val - add_curr_avm_auto_val_2,
                                                                 NULL));

rv_a49_curr_avm_chg_1yr_pct :=  __common__(map(
    not(truedid)                                              => NULL,
    add_curr_lres < 12                                        => NULL,
    add_curr_avm_auto_val > 0 and add_curr_avm_auto_val_2 > 0 => round(100 * add_curr_avm_auto_val / add_curr_avm_auto_val_2/0.1)*0.1,
                                                                 NULL));

rv_c13_curr_addr_lres :=  __common__(if(not(truedid and add_curr_pop), NULL, min(if(add_curr_lres = NULL, -NULL, add_curr_lres), 999)));

rv_c13_max_lres :=  __common__(if(not(truedid), NULL, min(if(max_lres = NULL, -NULL, max_lres), 999)));

rv_c14_addrs_5yr :=  __common__(map(
    not(truedid)     => NULL,
 //   add_curr_pop = 0 => -1,
   not add_curr_pop => -1,
                        min(if(addrs_5yr = NULL, -NULL, addrs_5yr), 999)));

rv_c14_addrs_10yr :=  __common__(map(
    not(truedid)     => NULL,
    (integer)add_curr_pop = 0 => -1,
                        min(if(addrs_10yr = NULL, -NULL, addrs_10yr), 999)));

rv_c14_addrs_15yr :=  __common__(if(not(truedid), NULL, min(if(addrs_15yr = NULL, -NULL, addrs_15yr), 999)));

rv_c22_inp_addr_occ_index :=  __common__(if(not(add_input_pop and truedid), NULL, add_input_occ_index));

rv_c22_inp_addr_owned_not_occ :=  __common__(if(not(add_input_pop and truedid), NULL, (integer)add_input_owned_not_occ));

rv_f04_curr_add_occ_index :=  __common__(if(not(truedid and add_curr_pop), NULL, add_curr_occ_index));

rv_a41_prop_owner :=  __common__(map(
    not(truedid)                                                                                   => NULL,
    add_input_naprop = 4 or add_curr_naprop = 4 or add_prev_naprop = 4 or property_owned_total > 0 => 1,
                                                                                                      0));

rv_a41_a42_prop_owner_history :=  __common__(map(
    not(truedid)                                                                     => NULL,
    add_input_naprop = 4 or add_curr_naprop = 4 or property_owned_total > 0          => 2,
    add_prev_naprop = 4 or Models.Common.findw_cpp(ver_sources, 'P' , ', ', 'E') > 0 => 1,
                                                                                        0));

rv_ever_asset_owner :=  __common__(map(
    not(truedid)                                                                                                                                                                                                 => NULL,
    add_input_naprop = 4 or add_curr_naprop = 4 or 
    add_prev_naprop = 4 or 
    property_owned_total > 0 or 
    Models.Common.findw_cpp(ver_sources, 'P' , ', ', 'E') > 0 or 
    watercraft_count > 0 or 
    attr_num_aircraft > 0 => 1,
                                                                                                                                                                                                                    0));

rv_e55_college_ind :=  __common__(map(
    not(truedid)                                                 => NULL,
    (college_file_type in ['H', 'C', 'A']) or college_attendance => 1,
                                                                    0));

rv_e57_prof_license_br_flag :=  __common__(if(not(truedid), 
                                  NULL, 
                                  (integer)(if(max((integer)prof_license_flag, br_source_count) = NULL,  
                                            NULL, 
                                             sum((integer)prof_license_flag, 
                                              if(br_source_count = NULL, 0, br_source_count)
                                              )) > 0)));

rv_i60_inq_count12 :=  __common__(if(not(truedid), NULL, min(if(inq_count12 = NULL, -NULL, inq_count12), 999)));

rv_i60_credit_seeking :=  __common__(if(not(truedid), NULL, if(max(min(2, if(inq_auto_count03 = NULL, -NULL, inq_auto_count03)), min(2, if(inq_banking_count03 = NULL, -NULL, inq_banking_count03)), min(2, if(inq_mortgage_count03 = NULL, -NULL, inq_mortgage_count03)), min(2, if(inq_retail_count03 = NULL, -NULL, inq_retail_count03)), min(2, if(inq_communications_count03 = NULL, -NULL, inq_communications_count03))) = NULL, NULL, sum(if(min(2, if(inq_auto_count03 = NULL, -NULL, inq_auto_count03)) = NULL, 0, min(2, if(inq_auto_count03 = NULL, -NULL, inq_auto_count03))), if(min(2, if(inq_banking_count03 = NULL, -NULL, inq_banking_count03)) = NULL, 0, min(2, if(inq_banking_count03 = NULL, -NULL, inq_banking_count03))), if(min(2, if(inq_mortgage_count03 = NULL, -NULL, inq_mortgage_count03)) = NULL, 0, min(2, if(inq_mortgage_count03 = NULL, -NULL, inq_mortgage_count03))), if(min(2, if(inq_retail_count03 = NULL, -NULL, inq_retail_count03)) = NULL, 0, min(2, if(inq_retail_count03 = NULL, -NULL, inq_retail_count03))), if(min(2, if(inq_communications_count03 = NULL, -NULL, inq_communications_count03)) = NULL, 0, min(2, if(inq_communications_count03 = NULL, -NULL, inq_communications_count03)))))));

rv_i60_inq_recency :=  __common__(map(
    not(truedid) => NULL,
    inq_count01 >0 => 1,
    inq_count03 >0 => 3,
    inq_count06 >0 => 6,
    inq_count12 >0 => 12,
    inq_count24 >0 => 24,
    inq_count   >0 => 99,
                    0));

rv_i60_inq_auto_recency :=  __common__(map(
    not(truedid)     => NULL,
    inq_auto_count01 >0 => 1,
    inq_auto_count03 >0 => 3,
    inq_auto_count06 >0 => 6,
    inq_auto_count12 >0 => 12,
    inq_auto_count24 >0 => 24,
    inq_auto_count   >0 => 99,
                        0));

rv_i60_inq_banking_count12 :=  __common__(if(not(truedid), NULL, min(if(inq_banking_count12 = NULL, -NULL, inq_banking_count12), 999)));

rv_i60_inq_banking_recency :=  __common__(map(
    not(truedid)        => NULL,
    inq_banking_count01 >0 => 1,
    inq_banking_count03 >0 => 3,
    inq_banking_count06 >0 => 6,
    inq_banking_count12 >0 => 12,
    inq_banking_count24 >0 => 24,
    inq_banking_count   >0 => 99,
                           0));

rv_i60_inq_hiriskcred_count12 :=  __common__(if(not(truedid), NULL, min(if(inq_highRiskCredit_count12 = NULL, -NULL, inq_highRiskCredit_count12), 999)));

rv_i60_inq_comm_count12 :=  __common__(if(not(truedid), NULL, min(if(inq_communications_count12 = NULL, -NULL, inq_communications_count12), 999)));

rv_i60_inq_other_count12 :=  __common__(if(not(truedid), NULL, min(if(inq_other_count12 = NULL, -NULL, inq_other_count12), 999)));

rv_i62_inq_ssns_per_adl :=  __common__(if(not(truedid), NULL, min(if(inq_ssnsperadl = NULL, -NULL, inq_ssnsperadl), 999)));

rv_i62_inq_addrs_per_adl :=  __common__(if(not(truedid), NULL, min(if(inq_addrsperadl = NULL, -NULL, inq_addrsperadl), 999)));

rv_i62_inq_num_names_per_adl :=  __common__(if(not(truedid), NULL, max(inq_fnamesperadl, inq_lnamesperadl)));

rv_i62_inq_phones_per_adl :=  __common__(if(not(truedid), NULL, min(if(inq_phonesperadl = NULL, -NULL, inq_phonesperadl), 999)));

rv_i62_inq_dobs_per_adl :=  __common__(if(not(truedid), NULL, min(if(inq_dobsperadl = NULL, -NULL, inq_dobsperadl), 999)));

rv_i62_inq_addrsperadl_recency :=  __common__(map(
    not(truedid)            => NULL,
    inq_addrsperadl_count01 >0 => 1,
    inq_addrsperadl_count03 >0 => 3,
    inq_addrsperadl_count06 >0 => 6,
    Inq_AddrsPerADL         >0 => 12,
                               0));

rv_i62_inq_fnamesperadl_recency :=  __common__(map(
    not(truedid)             => NULL,
    inq_fnamesperadl_count01 >0 => 1,
    inq_fnamesperadl_count03 >0 => 3,
    inq_fnamesperadl_count06 >0 => 6,
    Inq_FnamesPerADL         >0 => 12,
                                0));

rv_l79_adls_per_addr_curr :=  __common__(if(not(addrpop), NULL, min(if(adls_per_addr_curr = NULL, -NULL, adls_per_addr_curr), 999)));

rv_l79_adls_per_apt_addr :=  __common__(map(
    not(addrpop)   => NULL,
    iv_add_apt = '0' => -1,
                      min(if(adls_per_addr_curr = NULL, -NULL, adls_per_addr_curr), 999)));

rv_l79_adls_per_sfd_addr :=  __common__(map(
    not(addrpop)   => NULL,
    iv_add_apt = '1' => -1,
                      min(if(adls_per_addr_curr = NULL, -NULL, adls_per_addr_curr), 999)));

rv_l79_adls_per_apt_addr_c6 :=  __common__(map(
    not(addrpop)   => NULL,
    iv_add_apt = '0' => -1,
                      min(if(adls_per_addr_c6 = NULL, -NULL, adls_per_addr_c6), 999)));

rv_c18_invalid_addrs_per_adl :=  __common__(if(not(truedid), NULL, min(if(invalid_addrs_per_adl = NULL, -NULL, invalid_addrs_per_adl), 999)));

rv_l78_no_phone_at_addr_vel :=  __common__(map(
    not(addrpop)             => NULL,
    phones_per_addr_curr = 0 => 1,
                                0));

rv_c13_attr_addrs_recency :=  __common__(map(
    not(truedid)      => NULL,
    attr_addrs_last30 >0 => 1,
    attr_addrs_last90 >0 => 3,
    attr_addrs_last12 >0 => 12,
    attr_addrs_last24 >0 => 24,
    attr_addrs_last36 >0 => 36,
    addrs_5yr         >0 => 60,
    addrs_10yr        >0 => 120,
    addrs_15yr        >0 => 180,
    addrs_per_adl > 0 => 999,
                         0));

iv_rv5_unscorable :=  __common__(if(riskview.constants.noscore(nas_summary,nap_summary, add_input_naprop, le.truedid),'1', '0'));
                        

//iv_f00_nas_summary :=  __common__(if(not(truedid and ssnlength > '0'), NULL, nas_summary));

iv_f00_nas_summary :=  __common__(__common__( if(not(truedid and ssnlength > '0'), NULL,(Integer)trim((string)nas_summary,LEFT))));

rv_f01_inp_addr_address_score :=  __common__(if(not(add_input_pop and truedid), NULL, min(if(add_input_address_score = NULL, -NULL, add_input_address_score), 999)));

iv_fname_non_phn_src_ct :=  __common__(if(not(truedid and fnamepop), NULL, min(if(rc_fnamecount = NULL, -NULL, rc_fnamecount), 999)));

iv_lname_non_phn_src_ct :=  __common__(if(not(truedid and lnamepop), NULL, min(if(rc_lnamecount = NULL, -NULL, rc_lnamecount), 999)));

iv_full_name_non_phn_src_ct :=  __common__(if(not(truedid and fnamepop and lnamepop), NULL, min(if(source_count = NULL, -NULL, source_count), 999)));

iv_full_name_ver_sources :=  __common__(map(
    not((hphnpop or addrpop) and lnamepop and fnamepop)                                            => NULL,
    source_count > 0 and not(fname_eda_sourced_type = '') and not(lname_eda_sourced_type = '') => 3,
    source_count > 0                                                                               => 2,
    not(fname_eda_sourced_type = '') and not(lname_eda_sourced_type = '')                      => 1,
                                                                                                      0));

iv_addr_non_phn_src_ct :=  __common__(if(not(truedid and add_input_pop), NULL, min(if(rc_addrcount = NULL, -NULL, rc_addrcount), 999)));

iv_nas_fname_verd :=  __common__((nas_summary in [2, 3, 4, 8, 9, 10, 12]));

iv_c13_avg_lres :=  __common__(if(not(truedid), NULL, min(if(avg_lres = NULL, -NULL, avg_lres), 999)));

rv_c13_inp_addr_lres :=  __common__(if(not(add_input_pop and truedid), NULL, min(if(add_input_lres = NULL, -NULL, add_input_lres), 999)));

rv_c12_inp_addr_source_count :=  __common__(if(not(add_input_pop and truedid), NULL, min(if(add_input_source_count = NULL, -NULL, add_input_source_count), 999)));

mortgage_type :=  __common__(add_input_mortgage_type);

mortgage_present :=  __common__(not((add_input_mortgage_date in [0, NULL])));

iv_inp_addr_mortgage_type :=  __common__(map(
    not(truedid and add_input_pop)                        => '',
    (mortgage_type in ['CNV', 'N'])                       => 'CONVENTIONAL',
    (mortgage_type in ['FHA', 'G', 'VA'])                 => 'GOVERNMENT',
    (mortgage_type in ['1', 'D'])                         => 'PIGGYBACK',
    (mortgage_type in ['2', 'E', 'R', 'C'])               => 'EQUITY LOAN',
    (mortgage_type in ['I', 'K', 'O', 'LHM', 'T', 'SBA']) => 'COMMERCIAL',
    (mortgage_type in ['H', 'J'])                         => 'HIGH-RISK',
    (mortgage_type in ['PMM', 'PP', 'S', 'L'])            => 'NON-TRADITIONAL',
    (mortgage_type in ['U'])                              => 'UNKNOWN',
    not(mortgage_type = '')                             => 'OTHER',
    mortgage_present                                      => 'UNKNOWN',
                                                             'NO MORTGAGE'));

iv_curr_add_financing_type :=  __common__(map(
    not(truedid and add_curr_pop)  => '',
    add_curr_financing_type = '' => 'NONE ',
                                      add_curr_financing_type));

rv_a49_curr_add_avm_chg_2yr :=  __common__(map(
    not(add_curr_pop)                                         => NULL,
    add_curr_lres < 12 * 2                                    => NULL,
    add_curr_avm_auto_val > 0 and add_curr_avm_auto_val_3 > 0 => add_curr_avm_auto_val - add_curr_avm_auto_val_3,
                                                                 NULL));

rv_a49_curr_add_avm_pct_chg_2yr :=  __common__(map(
    not(add_curr_pop)                                         => NULL,
    add_curr_lres < 12 * 2                                    => NULL,
    add_curr_avm_auto_val > 0 and add_curr_avm_auto_val_3 > 0 => round(add_curr_avm_auto_val / add_curr_avm_auto_val_3/.01)*.01,
                                                                 NULL));

rv_a49_curr_add_avm_chg_3yr :=  __common__(map(
    not(add_curr_pop)                                         => NULL,
    add_curr_lres < 12 * 3                                    => NULL,
    add_curr_avm_auto_val > 0 and add_curr_avm_auto_val_4 > 0 => add_curr_avm_auto_val - add_curr_avm_auto_val_4,
                                                                 NULL));

rv_a49_curr_add_avm_pct_chg_3yr :=  __common__(map(
    not(add_curr_pop)                                         => NULL,
    add_curr_lres < 12 * 3                                    => NULL,
    add_curr_avm_auto_val > 0 and add_curr_avm_auto_val_4 > 0 => round(add_curr_avm_auto_val / add_curr_avm_auto_val_4/.01)*.01,
                                                                 NULL));

iv_prv_addr_lres :=  __common__(if(not(truedid and add_prev_pop), NULL, min(if(add_prev_lres = NULL, -NULL, add_prev_lres), 999)));

iv_prv_addr_avm_auto_val :=  __common__(if(not(add_prev_pop) and add_prev_naprop = 4, NULL, add_prev_avm_auto_val));

iv_input_best_name_match :=  __common__(map(
    not(truedid) or input_fname_isbestmatch = '-3' or input_lname_isbestmatch = '-3' => NULL,
    input_fname_isbestmatch = '1' and input_lname_isbestmatch = '1'                  => 3,
    input_lname_isbestmatch = '1'                                                  => 2,
    input_fname_isbestmatch = '1'                                                  => 1,
    input_fname_isbestmatch = '0' and input_lname_isbestmatch = '0'                 => 0,
    input_fname_isbestmatch = '-2' or input_lname_isbestmatch = '-2'                 => -1,
                                                                                    NULL));

iv_best_ssn_prior_dob :=  __common__(map(
    best_ssn_ssndobflag = '2' or best_ssn_ssndobflag = '3' or not(truedid) => NULL,
    best_ssn_ssndobflag = '1'                                              => 1,
    best_ssn_ssndobflag = '0'                                              => 0,
                                                                              NULL));

iv_prop1_purch_sale_diff :=  __common__(map(
    not(truedid)                                           => NULL,
    prop1_prev_purchase_price > 0 and prop1_sale_price > 0 => prop1_sale_price - prop1_prev_purchase_price,
                                                              NULL));

iv_prop2_purch_sale_diff :=  __common__(map(
    not(truedid)                                           => NULL,
    prop2_prev_purchase_price > 0 and prop2_sale_price > 0 => prop2_sale_price - prop2_prev_purchase_price,
                                                              NULL));

iv_a46_l77_addrs_move_traj_index :=  __common__(if(not(truedid), NULL, addrs_move_trajectory_index));

iv_unverified_addr_count :=  __common__(if(not(truedid), NULL, min(if(unverified_addr_count = NULL, -NULL, unverified_addr_count), 999)));

iv_c14_addrs_per_adl :=  __common__(if(not(truedid), NULL, min(if(addrs_per_adl = NULL, -NULL, addrs_per_adl), 999)));

br_first_seen_char :=  __common__(br_first_seen);

_br_first_seen :=  __common__(common.sas_date((string)(br_first_seen_char)));

rv_mos_since_br_first_seen :=  __common__(map(
    not(truedid)          => NULL,
    _br_first_seen = NULL => -1,
                             min(if(if ((sysdate - _br_first_seen) / (365.25 / 12) >= 0, truncate((sysdate - _br_first_seen) / (365.25 / 12)), roundup((sysdate - _br_first_seen) / (365.25 / 12))) = NULL, -NULL, if ((sysdate - _br_first_seen) / (365.25 / 12) >= 0, truncate((sysdate - _br_first_seen) / (365.25 / 12)), roundup((sysdate - _br_first_seen) / (365.25 / 12)))), 999)));

rv_e58_br_dead_bus_x_active_phn :=  __common__(if(not(truedid), '', (string)min(if(br_dead_business_count = NULL, -NULL, br_dead_business_count), 3) + '-' + (string)min(if(br_active_phone_count = NULL, -NULL, br_active_phone_count), 3)));

iv_d34_released_liens_ct :=  __common__(if(not(truedid), NULL, min(if(if(max(liens_recent_released_count, liens_historical_released_count) = NULL, NULL, sum(if(liens_recent_released_count = NULL, 0, liens_recent_released_count), if(liens_historical_released_count = NULL, 0, liens_historical_released_count))) = NULL, -NULL, if(max(liens_recent_released_count, liens_historical_released_count) = NULL, NULL, sum(if(liens_recent_released_count = NULL, 0, liens_recent_released_count), if(liens_historical_released_count = NULL, 0, liens_historical_released_count)))), 999)));

iv_d34_liens_rel_cj_ct :=  __common__(if(not(truedid), NULL, min(if(liens_rel_CJ_ct = NULL, -NULL, liens_rel_CJ_ct), 999)));

iv_college_major :=  __common__(map(
    not(truedid)                                                                                                                                                                                         => '',
    (college_major in ['A', 'E', 'L', 'Q', 'T', 'V', '040', '041', '044'])                                                                                                                               => 'MEDICAL',
    (college_major in ['D', 'H', 'M', 'N', '046', '006', '022', '026']) or (college_major in ['029', '031', '036'])                                                                                      => 'SCIENCE',
    (college_major in ['C', 'F', 'I', 'J', 'K', 'O', 'W', 'Y']) or (college_major in ['007', '013', '015', '027', '032', '033']) or (college_major in ['035', '037', '038', '039', '042', '043', '003']) => 'LIBERAL ARTS',
    (college_major in ['B', 'G', 'P', 'R', 'S', 'Z', '009', '045'])                                                                                                                                      => 'BUSINESS',
    college_major = 'U'                                                                                                                                                                                  => 'UNCLASSIFIED',
    not(((string)college_date_first_seen in ['0', ' ']))                                                                                                                                                         => 'NO COLLEGE FOUND',
                                                                                                                                                                                                            'NO AMS FOUND'));

iv_college_code_x_type :=  __common__(map(
    not(truedid)                               => '',
    college_code = '' or college_type = '' => '-1',
                                                  college_code + '-' + college_type));

iv_college_file_type :=  __common__(map(
    not(truedid)             => '',
    college_file_type = 'M'  => '',
    college_file_type = '' => '-1',
                                college_file_type));

iv_prof_license_category_pl :=  __common__(map(
    not(truedid) or prof_license_source != 'PL' => '',
    prof_license_category = ''                => '-1',
                                                   trim(prof_license_category, LEFT)));

iv_estimated_income :=  __common__(if(not(TrueDID), NULL, estimated_income));

iv_wealth_index :=  __common__(if(not(truedid), NULL, (integer)wealth_index));

//num_lname_sources :=  __common__(length(StringLib.StringFilterOut(ver_lname_sources, ',')));
//num_lname_sources :=  __common__(length(models.Common.countw(ver_lname_sources, ',')));STD.Str.CountWords( source, separator ) 
num_lname_sources_temp :=  __common__(models.Common.countw(trim(ver_lname_sources,left,right) ));
num_lname_sources :=  __common__(if (num_lname_sources_temp =0, 1, num_lname_sources_temp)) ;

iv_lname_bureau_only :=  __common__(if(not(lnamepop), -1, (integer)(num_lname_sources = if(max((integer)ver_lname_src_eq +
    (integer)ver_lname_src_en +
    (integer)ver_lname_src_tn +
    (integer)ver_lname_src_ts +
    (integer)ver_lname_src_tu) = NULL, NULL, sum(if((integer)ver_lname_src_eq +
    (integer)ver_lname_src_en +
    (integer)ver_lname_src_tn +
    (integer)ver_lname_src_ts +
    (integer)ver_lname_src_tu = NULL, 0, (integer)ver_lname_src_eq +
    (integer)ver_lname_src_en +
    (integer)ver_lname_src_tn +
    (integer)ver_lname_src_ts +
    (integer)ver_lname_src_tu))))));

_in_dob :=  __common__(common.sas_date((string)(in_dob)));

earliest_bureau_date :=  __common__(if(ver_src_fdate_tn = NULL and ver_src_fdate_ts = NULL and ver_src_fdate_tu = NULL and ver_src_fdate_en = NULL and ver_src_fdate_eq = NULL, NULL, if(max(ver_src_fdate_tn, ver_src_fdate_ts, ver_src_fdate_tu, ver_src_fdate_en, ver_src_fdate_eq) = NULL, NULL, min(if(ver_src_fdate_tn = NULL, -NULL, ver_src_fdate_tn), if(ver_src_fdate_ts = NULL, -NULL, ver_src_fdate_ts), if(ver_src_fdate_tu = NULL, -NULL, ver_src_fdate_tu), if(ver_src_fdate_en = NULL, -NULL, ver_src_fdate_en), if(ver_src_fdate_eq = NULL, -NULL, ver_src_fdate_eq)))));

earliest_bureau_yrs :=  __common__(if(earliest_bureau_date = NULL or sysdate = NULL, NULL, if ((sysdate - earliest_bureau_date) / 365.25 >= 0, roundup((sysdate - earliest_bureau_date) / 365.25), truncate((sysdate - earliest_bureau_date) / 365.25))));

calc_dob :=  __common__(if(_in_dob = NULL, NULL, if ((sysdate - _in_dob) / 365.25 >= 0, roundup((sysdate - _in_dob) / 365.25), truncate((sysdate - _in_dob) / 365.25))));

iv_bureau_emergence_age :=  __common__(map(
    not(truedid) or earliest_bureau_yrs = NULL => NULL,
    not(calc_dob = NULL)                       => calc_dob - earliest_bureau_yrs,
    inferred_age = 0                           => NULL,
                                                  inferred_age - earliest_bureau_yrs));

earliest_header_date :=  __common__(if(max(ver_src_fdate_d, ver_src_fdate_ff, ver_src_fdate_nt, ver_src_fdate_e2, ver_src_fdate_e4, ver_src_fdate_w, ver_src_fdate_mw, ver_src_fdate_vo, ver_src_fdate_em, ver_src_fdate_wp, ver_src_fdate_e1, ver_src_fdate_dl, ver_src_fdate_cg, ver_src_fdate_da, ver_src_fdate_p, ver_src_fdate_sl, ver_src_fdate_tn, ver_src_fdate_co, ver_src_fdate_en, ver_src_fdate_li, ver_src_fdate_am, ver_src_fdate_cy, ver_src_fdate_eb, ver_src_fdate_e3, ver_src_fdate_l2, ver_src_fdate_ba, ver_src_fdate_eq, ver_src_fdate_fe, ver_src_fdate_fr, ver_src_fdate_de, ver_src_fdate_tu, ver_src_fdate_pl, ver_src_fdate_v, ver_src_fdate_ar, ver_src_fdate_ak, ver_src_fdate_ts, ver_src_fdate_ds) = NULL, NULL, min(if(ver_src_fdate_d = NULL, -NULL, ver_src_fdate_d), if(ver_src_fdate_ff = NULL, -NULL, ver_src_fdate_ff), if(ver_src_fdate_nt = NULL, -NULL, ver_src_fdate_nt), if(ver_src_fdate_e2 = NULL, -NULL, ver_src_fdate_e2), if(ver_src_fdate_e4 = NULL, -NULL, ver_src_fdate_e4), if(ver_src_fdate_w = NULL, -NULL, ver_src_fdate_w), if(ver_src_fdate_mw = NULL, -NULL, ver_src_fdate_mw), if(ver_src_fdate_vo = NULL, -NULL, ver_src_fdate_vo), if(ver_src_fdate_em = NULL, -NULL, ver_src_fdate_em), if(ver_src_fdate_wp = NULL, -NULL, ver_src_fdate_wp), if(ver_src_fdate_e1 = NULL, -NULL, ver_src_fdate_e1), if(ver_src_fdate_dl = NULL, -NULL, ver_src_fdate_dl), if(ver_src_fdate_cg = NULL, -NULL, ver_src_fdate_cg), if(ver_src_fdate_da = NULL, -NULL, ver_src_fdate_da), if(ver_src_fdate_p = NULL, -NULL, ver_src_fdate_p), if(ver_src_fdate_sl = NULL, -NULL, ver_src_fdate_sl), if(ver_src_fdate_tn = NULL, -NULL, ver_src_fdate_tn), if(ver_src_fdate_co = NULL, -NULL, ver_src_fdate_co), if(ver_src_fdate_en = NULL, -NULL, ver_src_fdate_en), if(ver_src_fdate_li = NULL, -NULL, ver_src_fdate_li), if(ver_src_fdate_am = NULL, -NULL, ver_src_fdate_am), if(ver_src_fdate_cy = NULL, -NULL, ver_src_fdate_cy), if(ver_src_fdate_eb = NULL, -NULL, ver_src_fdate_eb), if(ver_src_fdate_e3 = NULL, -NULL, ver_src_fdate_e3), if(ver_src_fdate_l2 = NULL, -NULL, ver_src_fdate_l2), if(ver_src_fdate_ba = NULL, -NULL, ver_src_fdate_ba), if(ver_src_fdate_eq = NULL, -NULL, ver_src_fdate_eq), if(ver_src_fdate_fe = NULL, -NULL, ver_src_fdate_fe), if(ver_src_fdate_fr = NULL, -NULL, ver_src_fdate_fr), if(ver_src_fdate_de = NULL, -NULL, ver_src_fdate_de), if(ver_src_fdate_tu = NULL, -NULL, ver_src_fdate_tu), if(ver_src_fdate_pl = NULL, -NULL, ver_src_fdate_pl), if(ver_src_fdate_v = NULL, -NULL, ver_src_fdate_v), if(ver_src_fdate_ar = NULL, -NULL, ver_src_fdate_ar), if(ver_src_fdate_ak = NULL, -NULL, ver_src_fdate_ak), if(ver_src_fdate_ts = NULL, -NULL, ver_src_fdate_ts), if(ver_src_fdate_ds = NULL, -NULL, ver_src_fdate_ds))));

earliest_header_yrs :=  __common__(if(min(sysdate, earliest_header_date) = NULL, NULL, if ((sysdate - earliest_header_date) / 365.25 >= 0, roundup((sysdate - earliest_header_date) / 365.25), truncate((sysdate - earliest_header_date) / 365.25))));

iv_header_emergence_age :=  __common__(map(
    not(truedid) or earliest_header_yrs = NULL => NULL, // mention to AJ 
    not(_in_dob = NULL) => calc_dob - earliest_header_yrs,
    inferred_age = 0    => NULL,
                           inferred_age - earliest_header_yrs));
                           
 // iv_header_emergence_age := map(
    // not(truedid)        => NULL,
    // not(_in_dob = NULL) => max((real)0, min(62, if(calc_dob - earliest_header_yrs = NULL, -NULL, calc_dob - earliest_header_yrs))),
    // inferred_age = 0    => NULL,
                           // max(0, min(62, if(inferred_age - earliest_header_yrs = NULL, -NULL, inferred_age - earliest_header_yrs))));                          
                           

earliest_behavioral_date :=  __common__(if(max(ver_src_fdate_cy, ver_src_fdate_pl, ver_src_fdate_sl, ver_src_fdate_wp) = NULL, NULL, min(if(ver_src_fdate_cy = NULL, -NULL, ver_src_fdate_cy), if(ver_src_fdate_pl = NULL, -NULL, ver_src_fdate_pl), if(ver_src_fdate_sl = NULL, -NULL, ver_src_fdate_sl), if(ver_src_fdate_wp = NULL, -NULL, ver_src_fdate_wp))));

earliest_inperson_date :=  __common__(if(max(ver_src_fdate_ak, ver_src_fdate_am, ver_src_fdate_ar, ver_src_fdate_ba, ver_src_fdate_cg, ver_src_fdate_da, ver_src_fdate_d, ver_src_fdate_dl, ver_src_fdate_ds, ver_src_fdate_de, ver_src_fdate_eb, ver_src_fdate_em, ver_src_fdate_e1, ver_src_fdate_e2, ver_src_fdate_e3, ver_src_fdate_e4, ver_src_fdate_fe, ver_src_fdate_ff, ver_src_fdate_fr, ver_src_fdate_l2, ver_src_fdate_li, ver_src_fdate_mw, ver_src_fdate_nt, ver_src_fdate_p, ver_src_fdate_v, ver_src_fdate_vo, ver_src_fdate_w) = NULL, NULL, min(if(ver_src_fdate_ak = NULL, -NULL, ver_src_fdate_ak), if(ver_src_fdate_am = NULL, -NULL, ver_src_fdate_am), if(ver_src_fdate_ar = NULL, -NULL, ver_src_fdate_ar), if(ver_src_fdate_ba = NULL, -NULL, ver_src_fdate_ba), if(ver_src_fdate_cg = NULL, -NULL, ver_src_fdate_cg), if(ver_src_fdate_da = NULL, -NULL, ver_src_fdate_da), if(ver_src_fdate_d = NULL, -NULL, ver_src_fdate_d), if(ver_src_fdate_dl = NULL, -NULL, ver_src_fdate_dl), if(ver_src_fdate_ds = NULL, -NULL, ver_src_fdate_ds), if(ver_src_fdate_de = NULL, -NULL, ver_src_fdate_de), if(ver_src_fdate_eb = NULL, -NULL, ver_src_fdate_eb), if(ver_src_fdate_em = NULL, -NULL, ver_src_fdate_em), if(ver_src_fdate_e1 = NULL, -NULL, ver_src_fdate_e1), if(ver_src_fdate_e2 = NULL, -NULL, ver_src_fdate_e2), if(ver_src_fdate_e3 = NULL, -NULL, ver_src_fdate_e3), if(ver_src_fdate_e4 = NULL, -NULL, ver_src_fdate_e4), if(ver_src_fdate_fe = NULL, -NULL, ver_src_fdate_fe), if(ver_src_fdate_ff = NULL, -NULL, ver_src_fdate_ff), if(ver_src_fdate_fr = NULL, -NULL, ver_src_fdate_fr), if(ver_src_fdate_l2 = NULL, -NULL, ver_src_fdate_l2), if(ver_src_fdate_li = NULL, -NULL, ver_src_fdate_li), if(ver_src_fdate_mw = NULL, -NULL, ver_src_fdate_mw), if(ver_src_fdate_nt = NULL, -NULL, ver_src_fdate_nt), if(ver_src_fdate_p = NULL, -NULL, ver_src_fdate_p), if(ver_src_fdate_v = NULL, -NULL, ver_src_fdate_v), if(ver_src_fdate_vo = NULL, -NULL, ver_src_fdate_vo), if(ver_src_fdate_w = NULL, -NULL, ver_src_fdate_w))));

earliest_source_date :=  __common__(if(max(earliest_bureau_date, earliest_inperson_date, earliest_behavioral_date) = NULL, NULL, min(if(earliest_bureau_date = NULL, -NULL, earliest_bureau_date), if(earliest_inperson_date = NULL, -NULL, earliest_inperson_date), if(earliest_behavioral_date = NULL, -NULL, earliest_behavioral_date))));

iv_emergence_source_type :=  __common__(map(
    not(truedid)                                  => NULL,
    earliest_source_date = NULL                   => NULL,
    earliest_source_date = earliest_bureau_date   => 1,
    earliest_source_date = earliest_inperson_date => 2,
                                                     3));

src_inperson :=  __common__((integer)ver_src_ak +
    (integer)ver_src_am +
    (integer)ver_src_ar +
    (integer)ver_src_ba +
    (integer)ver_src_cg +
    (integer)ver_src_da +
    (integer)ver_src_d +
    (integer)ver_src_dl +
    (integer)ver_src_ds +
    (integer)ver_src_de +
    (integer)ver_src_eb +
    (integer)ver_src_em +
    (integer)ver_src_e1 +
    (integer)ver_src_e2 +
    (integer)ver_src_e3 +
    (integer)ver_src_e4 +
    (integer)ver_src_fe +
    (integer)ver_src_ff +
    (integer)ver_src_fr +
    (integer)ver_src_l2 +
    (integer)ver_src_li +
    (integer)ver_src_mw +
    (integer)ver_src_nt +
    (integer)ver_src_p +
    (integer)ver_src_v +
    (integer)ver_src_vo +
    (integer)ver_src_w);

iv_num_inperson_sources :=  __common__(if(not(truedid), NULL, src_inperson));

iv_num_non_bureau_sources :=  __common__(if(not(truedid), NULL, (integer)ver_src_cy +
    (integer)ver_src_pl +
    (integer)ver_src_sl +
    (integer)ver_src_wp +
    (integer)ver_src_ak +
    (integer)ver_src_am +
    (integer)ver_src_ar +
    (integer)ver_src_ba +
    (integer)ver_src_cg +
    (integer)ver_src_da +
    (integer)ver_src_d +
    (integer)ver_src_dl +
    (integer)ver_src_ds +
    (integer)ver_src_de +
    (integer)ver_src_eb +
    (integer)ver_src_em +
    (integer)ver_src_e1 +
    (integer)ver_src_e2 +
    (integer)ver_src_e3 +
    (integer)ver_src_e4 +
    (integer)ver_src_fe +
    (integer)ver_src_ff +
    (integer)ver_src_fr +
    (integer)ver_src_l2 +
    (integer)ver_src_li +
    (integer)ver_src_mw +
    (integer)ver_src_nt +
    (integer)ver_src_p +
    (integer)ver_src_v +
    (integer)ver_src_vo +
    (integer)ver_src_w));

vo_pos_1 :=  __common__(Models.Common.findw_cpp(ver_sources, 'VO' , ', ', 'E'));

iv_src_voter_adl_count :=  __common__(map(
    not(truedid)     => NULL,
    not(voter_avail) => -1,
    vo_pos_1 <= 0    => 0,
                        (integer)Models.Common.getw(ver_sources_count, vo_pos_1, ',')));

vo_pos :=  __common__(Models.Common.findw_cpp(ver_sources, 'VO' , ', ', 'E'));

vote_adl_lseen_vo :=  __common__(if(vo_pos > 0, Models.Common.getw(ver_sources_last_seen, vo_pos, ','), ''));

_vote_adl_lseen_vo :=  __common__(common.sas_date((string)(vote_adl_lseen_vo)));

iv_mos_src_voter_adl_lseen :=  __common__(map(
    not(truedid)              => NULL,
    not(voter_avail)          => -1,
    _vote_adl_lseen_vo = NULL => -1,
                                 if ((sysdate - _vote_adl_lseen_vo) / (365.25 / 12) >= 0, truncate((sysdate - _vote_adl_lseen_vo) / (365.25 / 12)), roundup((sysdate - _vote_adl_lseen_vo) / (365.25 / 12)))));

num_dob_match_level :=  __common__((integer)input_dob_match_level);

nas_summary_ver :=  __common__(if(ssnlength > '0' and (nas_summary in [8, 9, 10, 11, 12]) or (nas_summary in [2, 4, 7]) and add_input_isbestmatch, 1, 0));

nap_summary_ver :=  __common__(if(hphnpop and (nap_summary in [9, 10, 11, 12]), 1, 0));

infutor_nap_ver :=  __common__(if(hphnpop and (infutor_nap in [9, 10, 11, 12]), 1, 0));

dob_ver :=  __common__(if(dobpop and num_dob_match_level >= 5, 1, 0));

sufficiently_verified :=  __common__(map(
    (boolean)(integer)nas_summary_ver and ((boolean)(integer)nap_summary_ver or (boolean)(integer)infutor_nap_ver)          => 1,
    (boolean)(integer)nas_summary_ver and ((boolean)(integer)dob_ver or not(dobpop))                                        => 1,
    ((boolean)(integer)dob_ver or not(dobpop)) and ((boolean)(integer)nap_summary_ver or (boolean)(integer)infutor_nap_ver) => 1,
                                                                                                                               0));

add_ec1 :=  __common__((StringLib.StringToUpperCase(trim(out_addr_status, LEFT)))[1..1]);

addr_validation_problem :=  __common__(if(add_ec1 = 'E' and not(rc_addrvalflag = 'N') or rc_hriskaddrflag = '4' or rc_addrcommflag = '2' or (add_input_advo_res_or_bus in ['B', 'D']) or not(out_z5 = '') and (rc_hriskaddrflag = '2' or rc_ziptypeflag = '2') or add_input_advo_vacancy = 'Y', 1, 0));

phn_validation_problem :=  __common__(if(rc_hphonetypeflag = 'A' or rc_hriskphoneflag = '2' or rc_hphonetypeflag = '2' or (telcordia_type in ['02', '56', '61']) or rc_phonevalflag = '0' or rc_hphonevalflag = '0' or rc_phonetype = '5' or rc_hriskphoneflag = '6' or rc_hphonetypeflag = '5' or rc_hphonevalflag = '3' or rc_addrcommflag = '1', 1, 0));

validation_problem :=  __common__(if(adls_per_ssn >= 5 or ssns_per_adl >= 4 or invalid_ssns_per_adl >= 1 or adls_per_addr_curr >= 8 or ssns_per_addr_curr >= 7 or rc_hrisksic = '2225' or rc_hrisksicphone = '225' or (boolean)(integer)addr_validation_problem or (boolean)(integer)phn_validation_problem, 1, 0));

tot_liens :=  __common__(if(max(liens_historical_unreleased_ct, liens_recent_unreleased_count, liens_recent_released_count, liens_historical_released_count) = NULL, NULL, sum(if(liens_historical_unreleased_ct = NULL, 0, liens_historical_unreleased_ct), if(liens_recent_unreleased_count = NULL, 0, liens_recent_unreleased_count), if(liens_recent_released_count = NULL, 0, liens_recent_released_count), if(liens_historical_released_count = NULL, 0, liens_historical_released_count))));

tot_liens_w_type :=  __common__(if(max(liens_unrel_LT_ct, liens_rel_LT_ct, liens_unrel_SC_ct, liens_rel_SC_ct, liens_unrel_CJ_ct, liens_rel_CJ_ct, liens_unrel_FT_ct, liens_rel_FT_ct, liens_unrel_OT_ct, liens_rel_OT_ct, liens_unrel_ST_ct, liens_rel_ST_ct, liens_unrel_FC_ct, liens_rel_FC_ct, liens_unrel_O_ct, liens_rel_O_ct) = NULL, NULL, sum(if(liens_unrel_LT_ct = NULL, 0, liens_unrel_LT_ct), if(liens_rel_LT_ct = NULL, 0, liens_rel_LT_ct), if(liens_unrel_SC_ct = NULL, 0, liens_unrel_SC_ct), if(liens_rel_SC_ct = NULL, 0, liens_rel_SC_ct), if(liens_unrel_CJ_ct = NULL, 0, liens_unrel_CJ_ct), if(liens_rel_CJ_ct = NULL, 0, liens_rel_CJ_ct), if(liens_unrel_FT_ct = NULL, 0, liens_unrel_FT_ct), if(liens_rel_FT_ct = NULL, 0, liens_rel_FT_ct), if(liens_unrel_OT_ct = NULL, 0, liens_unrel_OT_ct), if(liens_rel_OT_ct = NULL, 0, liens_rel_OT_ct), if(liens_unrel_ST_ct = NULL, 0, liens_unrel_ST_ct), if(liens_rel_ST_ct = NULL, 0, liens_rel_ST_ct), if(liens_unrel_FC_ct = NULL, 0, liens_unrel_FC_ct), if(liens_rel_FC_ct = NULL, 0, liens_rel_FC_ct), if(liens_unrel_O_ct = NULL, 0, liens_unrel_O_ct), if(liens_rel_O_ct = NULL, 0, liens_rel_O_ct))));

has_derog :=  __common__(if(felony_count > 0 or criminal_count > 0 or stl_inq_count24 > 0 or attr_eviction_count > 0 or liens_unrel_CJ_ct > 0 or liens_rel_CJ_ct > 0 or liens_unrel_SC_ct > 0 or liens_rel_SC_ct > 0 or liens_unrel_FC_ct > 0 or liens_rel_FC_ct > 0 or liens_unrel_O_ct > 0 or liens_rel_O_ct > 0 or tot_liens - tot_liens_w_type > 0 or bk_dismissed_recent_count > 0 or bk_dismissed_historical_count > 0, 1, 0));

rv_6seg_riskview_5_0 :=  __common__(map(
    (integer)truedid = 0                                                                                                     => '0 TRUEDID = 0              ',
    not((boolean)sufficiently_verified)                                                                             => '1 VER/VAL PROBLEMS         ',
    (boolean)sufficiently_verified and (boolean)(integer)validation_problem                                         => '1 VER/VAL PROBLEMS         ',
    (boolean)sufficiently_verified and not(add_input_isbestmatch) and (boolean)(integer)has_derog                   => '2 ADDR NOT CURRENT - DEROG ',
    (boolean)sufficiently_verified and not(add_input_isbestmatch)                                                   => '3 ADDR NOT CURRENT - OTHER ',
    (boolean)sufficiently_verified and add_input_isbestmatch and (boolean)(integer)has_derog                        => '4 SUFFICIENTLY VERD - DEROG',
    (boolean)sufficiently_verified and add_input_isbestmatch and (add_input_naprop = 4 or property_owned_total > 0) => '5 SUFFICIENTLY VERD - OWNER',
                                                                                                                       '6 SUFFICIENTLY VERD - OTHER'));

rv_4seg_riskview_5_0 :=  __common__(map(
    (integer)truedid = 0                                                             => '0 TRUEDID = 0     ',
    not((boolean)sufficiently_verified)                                     => '1 VER/VAL PROBLEMS',
    (boolean)sufficiently_verified and (boolean)(integer)validation_problem => '1 VER/VAL PROBLEMS',
   (boolean)(integer)has_derog                                                               => '2 DEROG           ',
    add_input_naprop = 4 or property_owned_total > 0                        => '3 OWNER           ',
                                                                               '4 OTHER           '));

final_score_tree_0 := -1.6365579649;

final_score_tree_1_c277 := map(
    NULL < rv_f03_input_add_not_most_rec AND rv_f03_input_add_not_most_rec < 0.5 => -0.0205167975,
    rv_f03_input_add_not_most_rec >= 0.5                                         => -0.0666265801,
                                                                                    -0.0288557753);

final_score_tree_1_c280 := map(
    NULL < rv_c14_addrs_15yr AND rv_c14_addrs_15yr < 4.5 => 0.0315571022,
    rv_c14_addrs_15yr >= 4.5                             => 0.0870656952,
                                                            0.0496431656);

final_score_tree_1_c279 := map(
    NULL < rv_f03_input_add_not_most_rec AND rv_f03_input_add_not_most_rec < 0.5 => final_score_tree_1_c280,
    rv_f03_input_add_not_most_rec >= 0.5                                         => -0.0140595979,
                                                                                    0.0382503697);

final_score_tree_1_c278 := map(
    NULL < rv_c13_curr_addr_lres AND rv_c13_curr_addr_lres < 66.5 => final_score_tree_1_c279,
    rv_c13_curr_addr_lres >= 66.5                                 => -0.0054276194,
                                                                     0.0117953492);

final_score_tree_1 := map(
    NULL < rv_comb_age AND rv_comb_age < 43.5 => final_score_tree_1_c277,
    rv_comb_age >= 43.5                       => final_score_tree_1_c278,
                                                 -0.0103395937);

final_score_tree_2_c283 := map(
    NULL < rv_c13_curr_addr_lres AND rv_c13_curr_addr_lres < 95.5 => 0.0188795379,
    rv_c13_curr_addr_lres >= 95.5                                 => -0.0115301593,
                                                                     0.0016997919);

final_score_tree_2_c282 := map(
    NULL < iv_bureau_emergence_age AND iv_bureau_emergence_age < 20.5 => -0.0272821515,
    iv_bureau_emergence_age >= 20.5                                   => final_score_tree_2_c283,
                                                                         -0.0291758369);

final_score_tree_2_c285 := map(
    (rv_6seg_riskview_5_0 in ['2 ADDR NOT CURRENT - DEROG', '3 ADDR NOT CURRENT - OTHER', '5 SUFFICIENTLY VERD - OWNER'])           => -0.0019218512,
    (rv_6seg_riskview_5_0 in ['0 TRUEDID = 0', '1 VER/VAL PROBLEMS', '4 SUFFICIENTLY VERD - DEROG', '6 SUFFICIENTLY VERD - OTHER']) => 0.0485281807,
                                                                                                                                       0.0189108933);

final_score_tree_2_c284 := map(
    NULL < rv_c12_inp_addr_source_count AND rv_c12_inp_addr_source_count < 0.5 => 0.0875649265,
    rv_c12_inp_addr_source_count >= 0.5                                        => final_score_tree_2_c285,
                                                                                  0.0294902891);

final_score_tree_2 := map(
    NULL < iv_unverified_addr_count AND iv_unverified_addr_count < 4.5 => final_score_tree_2_c282,
    iv_unverified_addr_count >= 4.5                                    => final_score_tree_2_c284,
                                                                          -0.0064354059);

final_score_tree_3_c290 := map(
    (rv_6seg_riskview_5_0 in ['2 ADDR NOT CURRENT - DEROG', '3 ADDR NOT CURRENT - OTHER', '5 SUFFICIENTLY VERD - OWNER'])           => 0.0026915257,
    (rv_6seg_riskview_5_0 in ['0 TRUEDID = 0', '1 VER/VAL PROBLEMS', '4 SUFFICIENTLY VERD - DEROG', '6 SUFFICIENTLY VERD - OTHER']) => 0.0557209157,
                                                                                                                                       0.0373092649);

final_score_tree_3_c289 := map(
    NULL < in_addrpop_found AND in_addrpop_found < 0.5 => 0.1009067967,
    in_addrpop_found >= 0.5                            => final_score_tree_3_c290,
                                                          0.0507507284);

final_score_tree_3_c288 := map(
    NULL < rv_f03_input_add_not_most_rec AND rv_f03_input_add_not_most_rec < 0.5 => final_score_tree_3_c289,
    rv_f03_input_add_not_most_rec >= 0.5                                         => -0.0286132193,
                                                                                    0.0351909542);

final_score_tree_3_c287 := map(
    NULL < rv_c14_addrs_10yr AND rv_c14_addrs_10yr < 2.5 => -0.0010153982,
    rv_c14_addrs_10yr >= 2.5                             => final_score_tree_3_c288,
                                                            0.0078506753);

final_score_tree_3 := map(
    NULL < rv_c20_m_bureau_adl_fs AND rv_c20_m_bureau_adl_fs < 239.5 => -0.0279158004,
    rv_c20_m_bureau_adl_fs >= 239.5                                  => final_score_tree_3_c287,
                                                                        -0.0046042591);

final_score_tree_4_c292 := map(
    NULL < rv_f03_input_add_not_most_rec AND rv_f03_input_add_not_most_rec < 0.5 => -0.0115567872,
    rv_f03_input_add_not_most_rec >= 0.5                                         => -0.0589891239,
                                                                                    -0.0201313943);

final_score_tree_4_c295 := map(
    NULL < rv_f03_address_match AND rv_f03_address_match < 3 => -0.0206102537,
    rv_f03_address_match >= 3                                => 0.0410896045,
                                                                0.0255049706);

final_score_tree_4_c294 := map(
    NULL < rv_c12_inp_addr_source_count AND rv_c12_inp_addr_source_count < 0.5 => 0.0865068095,
    rv_c12_inp_addr_source_count >= 0.5                                        => final_score_tree_4_c295,
                                                                                  0.0347263982);

final_score_tree_4_c293 := map(
    NULL < rv_c14_addrs_15yr AND rv_c14_addrs_15yr < 2.5 => -0.0016904544,
    rv_c14_addrs_15yr >= 2.5                             => final_score_tree_4_c294,
                                                            0.0106072618);

final_score_tree_4 := map(
    NULL < rv_comb_age AND rv_comb_age < 46.5 => final_score_tree_4_c292,
    rv_comb_age >= 46.5                       => final_score_tree_4_c293,
                                                 -0.0115881135);

final_score_tree_5_c299 := map(
    NULL < rv_f03_address_match AND rv_f03_address_match < 3 => -0.0123192590,
    rv_f03_address_match >= 3                                => 0.0297008653,
                                                                0.0189334093);

final_score_tree_5_c298 := map(
    NULL < rv_c12_inp_addr_source_count AND rv_c12_inp_addr_source_count < 0.5 => 0.0725361374,
    rv_c12_inp_addr_source_count >= 0.5                                        => final_score_tree_5_c299,
                                                                                  0.0262844048);

final_score_tree_5_c300 := map(
    NULL < rv_i62_inq_ssns_per_adl AND rv_i62_inq_ssns_per_adl < 2.5 => -0.0057520854,
    rv_i62_inq_ssns_per_adl >= 2.5                                   => 0.0658550812,
                                                                        -0.0035723335);

final_score_tree_5_c297 := map(
    NULL < rv_c13_curr_addr_lres AND rv_c13_curr_addr_lres < 62.5 => final_score_tree_5_c298,
    rv_c13_curr_addr_lres >= 62.5                                 => final_score_tree_5_c300,
                                                                     0.0074950249);

final_score_tree_5 := map(
    NULL < rv_comb_age AND rv_comb_age < 45.5 => -0.0211486492,
    rv_comb_age >= 45.5                       => final_score_tree_5_c297,
                                                 -0.0064679905);

final_score_tree_6_c303 := map(
    NULL < rv_c13_curr_addr_lres AND rv_c13_curr_addr_lres < 29.5 => 0.0175330175,
    rv_c13_curr_addr_lres >= 29.5                                 => -0.0085680346,
                                                                     -0.0025597076);

final_score_tree_6_c302 := map(
    NULL < rv_c20_m_bureau_adl_fs AND rv_c20_m_bureau_adl_fs < 174.5 => -0.0353889297,
    rv_c20_m_bureau_adl_fs >= 174.5                                  => final_score_tree_6_c303,
                                                                        -0.0079195221);

final_score_tree_6_c305 := map(
    NULL < rv_c13_attr_addrs_recency AND rv_c13_attr_addrs_recency < 48 => 0.1078876985,
    rv_c13_attr_addrs_recency >= 48                                     => 0.0191491587,
                                                                           0.0641003864);

final_score_tree_6_c304 := map(
    NULL < rv_c12_inp_addr_source_count AND rv_c12_inp_addr_source_count < 0.5 => final_score_tree_6_c305,
    rv_c12_inp_addr_source_count >= 0.5                                        => 0.0158496219,
                                                                                  0.0232751415);

final_score_tree_6 := map(
    NULL < iv_unverified_addr_count AND iv_unverified_addr_count < 4.5 => final_score_tree_6_c302,
    iv_unverified_addr_count >= 4.5                                    => final_score_tree_6_c304,
                                                                          0.0176747707);

final_score_tree_7_c307 := map(
    NULL < iv_c14_addrs_per_adl AND iv_c14_addrs_per_adl < 8.5 => 0.0149613723,
    iv_c14_addrs_per_adl >= 8.5                                => 0.0670219158,
                                                                  0.0278042326);

final_score_tree_7_c309 := map(
    NULL < rv_c22_inp_addr_occ_index AND rv_c22_inp_addr_occ_index < 3.5 => -0.0452390622,
    rv_c22_inp_addr_occ_index >= 3.5                                     => 0.0174669964,
                                                                            -0.0300362361);

final_score_tree_7_c310 := map(
    NULL < iv_unverified_addr_count AND iv_unverified_addr_count < 1.5 => -0.0113689801,
    iv_unverified_addr_count >= 1.5                                    => 0.0133328226,
                                                                          0.0017070902);

final_score_tree_7_c308 := map(
    NULL < rv_f03_address_match AND rv_f03_address_match < 3 => final_score_tree_7_c309,
    rv_f03_address_match >= 3                                => final_score_tree_7_c310,
                                                                -0.0054295123);

final_score_tree_7 := map(
    NULL < rv_c12_inp_addr_source_count AND rv_c12_inp_addr_source_count < 0.5 => final_score_tree_7_c307,
    rv_c12_inp_addr_source_count >= 0.5                                        => final_score_tree_7_c308,
                                                                                  0.0058700854);

final_score_tree_8_c315 := map(
    NULL < rv_c12_inp_addr_source_count AND rv_c12_inp_addr_source_count < 0.5 => 0.0496900210,
    rv_c12_inp_addr_source_count >= 0.5                                        => 0.0121539071,
                                                                                  0.0177659081);

final_score_tree_8_c314 := map(
    NULL < rv_a44_curr_add_naprop AND rv_a44_curr_add_naprop < 1.5 => final_score_tree_8_c315,
    rv_a44_curr_add_naprop >= 1.5                                  => -0.0028948260,
                                                                      0.0065202682);

final_score_tree_8_c313 := map(
    NULL < iv_bureau_emergence_age AND iv_bureau_emergence_age < 53.5 => final_score_tree_8_c314,
    iv_bureau_emergence_age >= 53.5                                   => -0.0310243237,
                                                                         -0.0195853040);

final_score_tree_8_c312 := map(
    NULL < rv_i62_inq_num_names_per_adl AND rv_i62_inq_num_names_per_adl < 0.5 => final_score_tree_8_c313,
    rv_i62_inq_num_names_per_adl >= 0.5                                        => 0.0439720493,
                                                                                  0.0076818492);

final_score_tree_8 := map(
    NULL < rv_comb_age AND rv_comb_age < 46.5 => -0.0156530985,
    rv_comb_age >= 46.5                       => final_score_tree_8_c312,
                                                 -0.0091409207);

final_score_tree_9_c317 := map(
    NULL < iv_bureau_emergence_age AND iv_bureau_emergence_age < 23.5 => -0.0195661281,
    iv_bureau_emergence_age >= 23.5                                   => 0.0039634411,
                                                                         -0.0237186537);

final_score_tree_9_c319 := map(
    NULL < rv_i60_inq_count12 AND rv_i60_inq_count12 < 4.5 => 0.0475522746,
    rv_i60_inq_count12 >= 4.5                              => 0.1587751645,
                                                              0.0636663770);

final_score_tree_9_c320 := map(
    NULL < rv_f03_address_match AND rv_f03_address_match < 3 => -0.0247908581,
    rv_f03_address_match >= 3                                => 0.0264015051,
                                                                0.0122109112);

final_score_tree_9_c318 := map(
    NULL < in_addrpop_found AND in_addrpop_found < 0.5 => final_score_tree_9_c319,
    in_addrpop_found >= 0.5                            => final_score_tree_9_c320,
                                                          0.0205721856);

final_score_tree_9 := map(
    NULL < rv_i62_inq_num_names_per_adl AND rv_i62_inq_num_names_per_adl < 0.5 => final_score_tree_9_c317,
    rv_i62_inq_num_names_per_adl >= 0.5                                        => final_score_tree_9_c318,
                                                                                  0.0100504737);

final_score_tree_10_c324 := map(
    NULL < rv_a44_curr_add_naprop AND rv_a44_curr_add_naprop < 1.5 => 0.0104759653,
    rv_a44_curr_add_naprop >= 1.5                                  => -0.0077391457,
                                                                      0.0007170263);

final_score_tree_10_c323 := map(
    NULL < rv_c20_m_bureau_adl_fs AND rv_c20_m_bureau_adl_fs < 155.5 => -0.0289231874,
    rv_c20_m_bureau_adl_fs >= 155.5                                  => final_score_tree_10_c324,
                                                                        -0.0029311789);

final_score_tree_10_c322 := map(
    NULL < iv_c14_addrs_per_adl AND iv_c14_addrs_per_adl < 8.5 => final_score_tree_10_c323,
    iv_c14_addrs_per_adl >= 8.5                                => 0.0292135230,
                                                                  0.0019504101);

final_score_tree_10_c325 := map(
    NULL < rv_c22_inp_addr_occ_index AND rv_c22_inp_addr_occ_index < 3.5 => -0.0418454674,
    rv_c22_inp_addr_occ_index >= 3.5                                     => 0.0132477387,
                                                                            -0.0282167706);

final_score_tree_10 := map(
    NULL < rv_f03_input_add_not_most_rec AND rv_f03_input_add_not_most_rec < 0.5 => final_score_tree_10_c322,
    rv_f03_input_add_not_most_rec >= 0.5                                         => final_score_tree_10_c325,
                                                                                    -0.0033258733);

final_score_tree_11_c327 := map(
    NULL < rv_i60_inq_count12 AND rv_i60_inq_count12 < 3.5 => 0.0169252151,
    rv_i60_inq_count12 >= 3.5                              => 0.1096103592,
                                                              0.0217919038);

final_score_tree_11_c329 := map(
    NULL < rv_c22_inp_addr_occ_index AND rv_c22_inp_addr_occ_index < 3.5 => -0.0407199003,
    rv_c22_inp_addr_occ_index >= 3.5                                     => 0.0090913478,
                                                                            -0.0286221728);

final_score_tree_11_c330 := map(
    NULL < rv_d30_derog_count AND rv_d30_derog_count < 0.5 => -0.0035221234,
    rv_d30_derog_count >= 0.5                              => 0.0201798547,
                                                              0.0013177403);

final_score_tree_11_c328 := map(
    NULL < rv_f03_address_match AND rv_f03_address_match < 3 => final_score_tree_11_c329,
    rv_f03_address_match >= 3                                => final_score_tree_11_c330,
                                                                -0.0054232452);

final_score_tree_11 := map(
    NULL < rv_c12_inp_addr_source_count AND rv_c12_inp_addr_source_count < 0.5 => final_score_tree_11_c327,
    rv_c12_inp_addr_source_count >= 0.5                                        => final_score_tree_11_c328,
                                                                                  -0.0038818671);

final_score_tree_12_c333 := map(
    NULL < rv_i62_inq_ssns_per_adl AND rv_i62_inq_ssns_per_adl < 3.5 => -0.0014847838,
    rv_i62_inq_ssns_per_adl >= 3.5                                   => 0.0393746435,
                                                                        0.0006736750);

final_score_tree_12_c332 := map(
    NULL < rv_f03_input_add_not_most_rec AND rv_f03_input_add_not_most_rec < 0.5 => final_score_tree_12_c333,
    rv_f03_input_add_not_most_rec >= 0.5                                         => -0.0237376810,
                                                                                    -0.0032229472);

final_score_tree_12_c335 := map(
    (rv_6seg_riskview_5_0 in ['2 ADDR NOT CURRENT - DEROG', '3 ADDR NOT CURRENT - OTHER', '5 SUFFICIENTLY VERD - OWNER'])           => -0.0021078222,
    (rv_6seg_riskview_5_0 in ['0 TRUEDID = 0', '1 VER/VAL PROBLEMS', '4 SUFFICIENTLY VERD - DEROG', '6 SUFFICIENTLY VERD - OTHER']) => 0.0371587090,
                                                                                                                                       0.0148886207);

final_score_tree_12_c334 := map(
    NULL < rv_c22_inp_addr_occ_index AND rv_c22_inp_addr_occ_index < 3.5 => final_score_tree_12_c335,
    rv_c22_inp_addr_occ_index >= 3.5                                     => 0.0565043521,
                                                                            0.0220684866);

final_score_tree_12 := map(
    NULL < iv_unverified_addr_count AND iv_unverified_addr_count < 5.5 => final_score_tree_12_c332,
    iv_unverified_addr_count >= 5.5                                    => final_score_tree_12_c334,
                                                                          -0.0088187683);

final_score_tree_13_c337 := map(
    NULL < rv_i62_inq_ssns_per_adl AND rv_i62_inq_ssns_per_adl < 1.5 => -0.0208103632,
    rv_i62_inq_ssns_per_adl >= 1.5                                   => 0.0110106993,
                                                                        -0.0139701409);

final_score_tree_13_c339 := map(
    NULL < rv_c14_addrs_15yr AND rv_c14_addrs_15yr < 4.5 => 0.0184189344,
    rv_c14_addrs_15yr >= 4.5                             => 0.0495537776,
                                                            0.0288980259);

final_score_tree_13_c340 := map(
    NULL < rv_c14_addrs_10yr AND rv_c14_addrs_10yr < 1.5 => -0.0041798408,
    rv_c14_addrs_10yr >= 1.5                             => 0.0156072526,
                                                            0.0009184083);

final_score_tree_13_c338 := map(
    NULL < rv_c13_curr_addr_lres AND rv_c13_curr_addr_lres < 27.5 => final_score_tree_13_c339,
    rv_c13_curr_addr_lres >= 27.5                                 => final_score_tree_13_c340,
                                                                     0.0067513651);

final_score_tree_13 := map(
    NULL < rv_comb_age AND rv_comb_age < 46.5 => final_score_tree_13_c337,
    rv_comb_age >= 46.5                       => final_score_tree_13_c338,
                                                 0.0013087269);

final_score_tree_14_c344 := map(
    NULL < rv_c12_inp_addr_source_count AND rv_c12_inp_addr_source_count < 0.5 => 0.0365887330,
    rv_c12_inp_addr_source_count >= 0.5                                        => 0.0085195451,
                                                                                  0.0121390453);

final_score_tree_14_c343 := map(
    NULL < rv_c13_curr_addr_lres AND rv_c13_curr_addr_lres < 61.5 => final_score_tree_14_c344,
    rv_c13_curr_addr_lres >= 61.5                                 => -0.0042137859,
                                                                     0.0014635957);

final_score_tree_14_c345 := map(
    NULL < rv_c12_inp_addr_source_count AND rv_c12_inp_addr_source_count < 0.5 => 0.0571692826,
    rv_c12_inp_addr_source_count >= 0.5                                        => 0.0240217136,
                                                                                  0.0292059306);

final_score_tree_14_c342 := map(
    NULL < rv_i62_inq_num_names_per_adl AND rv_i62_inq_num_names_per_adl < 0.5 => final_score_tree_14_c343,
    rv_i62_inq_num_names_per_adl >= 0.5                                        => final_score_tree_14_c345,
                                                                                  0.0051973881);

final_score_tree_14 := map(
    NULL < rv_comb_age AND rv_comb_age < 43.5 => -0.0159946255,
    rv_comb_age >= 43.5                       => final_score_tree_14_c342,
                                                 0.0042950722);

final_score_tree_15_c349 := map(
    NULL < iv_wealth_index AND iv_wealth_index < 3.5 => 0.0141068877,
    iv_wealth_index >= 3.5                           => -0.0222357715,
                                                        0.0066748055);

final_score_tree_15_c348 := map(
    NULL < iv_bureau_emergence_age AND iv_bureau_emergence_age < 29.5 => final_score_tree_15_c349,
    iv_bureau_emergence_age >= 29.5                                   => 0.0376553680,
                                                                         -0.0015810919);

final_score_tree_15_c347 := map(
    NULL < iv_c14_addrs_per_adl AND iv_c14_addrs_per_adl < 6.5 => -0.0037627435,
    iv_c14_addrs_per_adl >= 6.5                                => final_score_tree_15_c348,
                                                                  0.0011216013);

final_score_tree_15_c350 := map(
    NULL < rv_c22_inp_addr_occ_index AND rv_c22_inp_addr_occ_index < 3.5 => -0.0376951952,
    rv_c22_inp_addr_occ_index >= 3.5                                     => 0.0137514124,
                                                                            -0.0249475984);

final_score_tree_15 := map(
    NULL < rv_f03_input_add_not_most_rec AND rv_f03_input_add_not_most_rec < 0.5 => final_score_tree_15_c347,
    rv_f03_input_add_not_most_rec >= 0.5                                         => final_score_tree_15_c350,
                                                                                    0.0056355147);

final_score_tree_16_c354 := map(
    NULL < rv_comb_age AND rv_comb_age < 84.5 => 0.0057945446,
    rv_comb_age >= 84.5                       => -0.0313643381,
                                                 0.0030958661);

final_score_tree_16_c353 := map(
    NULL < iv_bureau_emergence_age AND iv_bureau_emergence_age < 22.5 => -0.0165448891,
    iv_bureau_emergence_age >= 22.5                                   => final_score_tree_16_c354,
                                                                         0.0063085956);

final_score_tree_16_c355 := map(
    NULL < rv_c12_inp_addr_source_count AND rv_c12_inp_addr_source_count < 0.5 => 0.0505088070,
    rv_c12_inp_addr_source_count >= 0.5                                        => 0.0176876980,
                                                                                  0.0230933887);

final_score_tree_16_c352 := map(
    NULL < rv_i62_inq_num_names_per_adl AND rv_i62_inq_num_names_per_adl < 0.5 => final_score_tree_16_c353,
    rv_i62_inq_num_names_per_adl >= 0.5                                        => final_score_tree_16_c355,
                                                                                  0.0020363419);

final_score_tree_16 := map(
    NULL < rv_c20_m_bureau_adl_fs AND rv_c20_m_bureau_adl_fs < 170.5 => -0.0269412585,
    rv_c20_m_bureau_adl_fs >= 170.5                                  => final_score_tree_16_c352,
                                                                        0.0019292924);

final_score_tree_17_c358 := map(
    (rv_6seg_riskview_5_0 in ['2 ADDR NOT CURRENT - DEROG', '3 ADDR NOT CURRENT - OTHER', '5 SUFFICIENTLY VERD - OWNER'])           => -0.0318240960,
    (rv_6seg_riskview_5_0 in ['0 TRUEDID = 0', '1 VER/VAL PROBLEMS', '4 SUFFICIENTLY VERD - DEROG', '6 SUFFICIENTLY VERD - OTHER']) => -0.0032611984,
                                                                                                                                       -0.0159457978);

final_score_tree_17_c357 := map(
    NULL < rv_c22_inp_addr_occ_index AND rv_c22_inp_addr_occ_index < 3.5 => final_score_tree_17_c358,
    rv_c22_inp_addr_occ_index >= 3.5                                     => 0.0161787069,
                                                                            -0.0109494570);

final_score_tree_17_c360 := map(
    NULL < rv_comb_age AND rv_comb_age < 73.5 => 0.0182184476,
    rv_comb_age >= 73.5                       => -0.0074063962,
                                                 0.0130203583);

final_score_tree_17_c359 := map(
    NULL < rv_c13_curr_addr_lres AND rv_c13_curr_addr_lres < 141.5 => final_score_tree_17_c360,
    rv_c13_curr_addr_lres >= 141.5                                 => -0.0048088859,
                                                                      0.0052820465);

final_score_tree_17 := map(
    NULL < rv_comb_age AND rv_comb_age < 49.5 => final_score_tree_17_c357,
    rv_comb_age >= 49.5                       => final_score_tree_17_c359,
                                                 -0.0034765021);

final_score_tree_18_c364 := map(
    NULL < rv_f03_input_add_not_most_rec AND rv_f03_input_add_not_most_rec < 0.5 => 0.0206144816,
    rv_f03_input_add_not_most_rec >= 0.5                                         => -0.0054993390,
                                                                                    0.0155143347);

final_score_tree_18_c363 := map(
    NULL < rv_l80_inp_avm_autoval AND rv_l80_inp_avm_autoval < 79041.5 => final_score_tree_18_c364,
    rv_l80_inp_avm_autoval >= 79041.5                                  => -0.0038478002,
                                                                          0.0109899041);

final_score_tree_18_c365 := map(
    NULL < rv_comb_age AND rv_comb_age < 51.5 => -0.0333079635,
    rv_comb_age >= 51.5                       => 0.0001066719,
                                                 -0.0086729677);

final_score_tree_18_c362 := map(
    NULL < iv_wealth_index AND iv_wealth_index < 3.5 => final_score_tree_18_c363,
    iv_wealth_index >= 3.5                           => final_score_tree_18_c365,
                                                        0.0054802666);

final_score_tree_18 := map(
    NULL < iv_unverified_addr_count AND iv_unverified_addr_count < 1.5 => -0.0106121072,
    iv_unverified_addr_count >= 1.5                                    => final_score_tree_18_c362,
                                                                          0.0030732317);

final_score_tree_19_c369 := map(
    NULL < rv_c20_m_bureau_adl_fs AND rv_c20_m_bureau_adl_fs < 172.5 => -0.0140664363,
    rv_c20_m_bureau_adl_fs >= 172.5                                  => 0.0134271781,
                                                                        0.0080198588);

final_score_tree_19_c368 := map(
    NULL < rv_c13_curr_addr_lres AND rv_c13_curr_addr_lres < 49.5 => final_score_tree_19_c369,
    rv_c13_curr_addr_lres >= 49.5                                 => -0.0046416422,
                                                                     -0.0000841175);

final_score_tree_19_c367 := map(
    (iv_college_file_type in ['A', 'C', 'H']) => -0.0263613617,
    (iv_college_file_type in ['-1'])          => final_score_tree_19_c368,
                                                 -0.0195326766);

final_score_tree_19_c370 := map(
    NULL < rv_c13_inp_addr_lres AND rv_c13_inp_addr_lres < 25.5 => 0.0308416264,
    rv_c13_inp_addr_lres >= 25.5                                => 0.0057943307,
                                                                   0.0167543781);

final_score_tree_19 := map(
    NULL < iv_unverified_addr_count AND iv_unverified_addr_count < 5.5 => final_score_tree_19_c367,
    iv_unverified_addr_count >= 5.5                                    => final_score_tree_19_c370,
                                                                          -0.0080224207);

final_score_tree_20_c373 := map(
    NULL < rv_i60_inq_banking_count12 AND rv_i60_inq_banking_count12 < 0.5 => -0.0125974267,
    rv_i60_inq_banking_count12 >= 0.5                                      => 0.0481741416,
                                                                              -0.0107955147);

final_score_tree_20_c375 := map(
    NULL < rv_c13_inp_addr_lres AND rv_c13_inp_addr_lres < 24.5 => 0.0184412946,
    rv_c13_inp_addr_lres >= 24.5                                => 0.0020122720,
                                                                   0.0064180768);

final_score_tree_20_c374 := map(
    NULL < rv_comb_age AND rv_comb_age < 81.5 => final_score_tree_20_c375,
    rv_comb_age >= 81.5                       => -0.0192024732,
                                                 0.0033471028);

final_score_tree_20_c372 := map(
    NULL < iv_bureau_emergence_age AND iv_bureau_emergence_age < 23.5 => final_score_tree_20_c373,
    iv_bureau_emergence_age >= 23.5                                   => final_score_tree_20_c374,
                                                                         0.0099054890);

final_score_tree_20 := map(
    NULL < rv_s66_adlperssn_count AND rv_s66_adlperssn_count < 2.5 => final_score_tree_20_c372,
    rv_s66_adlperssn_count >= 2.5                                  => 0.0154814597,
                                                                      -0.0158509703);

final_score_tree_21_c379 := map(
    NULL < (integer)iv_nas_fname_verd AND (integer)iv_nas_fname_verd < 0.5 => -0.0624393477,
    (integer)iv_nas_fname_verd >= 0.5                             => -0.0004802318,
                                                            -0.0010533687);

final_score_tree_21_c378 := map(
    NULL < rv_i62_inq_ssns_per_adl AND rv_i62_inq_ssns_per_adl < 4.5 => final_score_tree_21_c379,
    rv_i62_inq_ssns_per_adl >= 4.5                                   => 0.0277225461,
                                                                        0.0001407213);

final_score_tree_21_c380 := map(
    NULL < iv_prv_addr_lres AND iv_prv_addr_lres < 62.5 => -0.0367544934,
    iv_prv_addr_lres >= 62.5                            => -0.0053968935,
                                                           -0.0219677682);

final_score_tree_21_c377 := map(
    NULL < rv_f03_input_add_not_most_rec AND rv_f03_input_add_not_most_rec < 0.5 => final_score_tree_21_c378,
    rv_f03_input_add_not_most_rec >= 0.5                                         => final_score_tree_21_c380,
                                                                                    -0.0034174527);

final_score_tree_21 := map(
    NULL < iv_unverified_addr_count AND iv_unverified_addr_count < 7.5 => final_score_tree_21_c377,
    iv_unverified_addr_count >= 7.5                                    => 0.0201865371,
                                                                          0.0103587718);

final_score_tree_22_c383 := map(
    NULL < rv_comb_age AND rv_comb_age < 83.5 => 0.0023689171,
    rv_comb_age >= 83.5                       => -0.0268011018,
                                                 0.0115023986);

final_score_tree_22_c382 := map(
    (iv_college_file_type in ['A', 'C', 'H']) => -0.0259859065,
    (iv_college_file_type in ['-1'])          => final_score_tree_22_c383,
                                                 -0.0185745178);

final_score_tree_22_c385 := map(
    NULL < rv_f03_input_add_not_most_rec AND rv_f03_input_add_not_most_rec < 0.5 => 0.0381348738,
    rv_f03_input_add_not_most_rec >= 0.5                                         => -0.0035414563,
                                                                                    0.0294806111);

final_score_tree_22_c384 := map(
    NULL < rv_c13_curr_addr_lres AND rv_c13_curr_addr_lres < 23.5 => final_score_tree_22_c385,
    rv_c13_curr_addr_lres >= 23.5                                 => 0.0052774838,
                                                                     0.0124140874);

final_score_tree_22 := map(
    NULL < iv_unverified_addr_count AND iv_unverified_addr_count < 4.5 => final_score_tree_22_c382,
    iv_unverified_addr_count >= 4.5                                    => final_score_tree_22_c384,
                                                                          -0.0049241849);

final_score_tree_23_c390 := map(
    NULL < rv_c20_m_bureau_adl_fs AND rv_c20_m_bureau_adl_fs < 154.5 => -0.0062806444,
    rv_c20_m_bureau_adl_fs >= 154.5                                  => 0.0240300627,
                                                                        0.0182584711);

final_score_tree_23_c389 := map(
    NULL < rv_f03_input_add_not_most_rec AND rv_f03_input_add_not_most_rec < 0.5 => final_score_tree_23_c390,
    rv_f03_input_add_not_most_rec >= 0.5                                         => -0.0103292570,
                                                                                    0.0128031651);

final_score_tree_23_c388 := map(
    NULL < iv_estimated_income AND iv_estimated_income < 46500 => final_score_tree_23_c389,
    iv_estimated_income >= 46500                               => -0.0217490948,
                                                                  0.0091309861);

final_score_tree_23_c387 := map(
    NULL < rv_c13_curr_addr_lres AND rv_c13_curr_addr_lres < 27.5 => final_score_tree_23_c388,
    rv_c13_curr_addr_lres >= 27.5                                 => -0.0024182880,
                                                                     0.0005662361);

final_score_tree_23 := map(
    (iv_college_file_type in ['A', 'C', 'H']) => -0.0238795053,
    (iv_college_file_type in ['-1'])          => final_score_tree_23_c387,
                                                 -0.0119204150);

final_score_tree_24_c395 := map(
    NULL < rv_c14_addrs_15yr AND rv_c14_addrs_15yr < 2.5 => 0.0035498470,
    rv_c14_addrs_15yr >= 2.5                             => 0.0225366919,
                                                            0.0092770265);

final_score_tree_24_c394 := map(
    NULL < iv_header_emergence_age AND iv_header_emergence_age < 27.5 => -0.0030522963,
    iv_header_emergence_age >= 27.5                                   => final_score_tree_24_c395,
                                                                         0.0024460979);

final_score_tree_24_c393 := map(
    NULL < iv_bureau_emergence_age AND iv_bureau_emergence_age < 53.5 => final_score_tree_24_c394,
    iv_bureau_emergence_age >= 53.5                                   => -0.0246108840,
                                                                         -0.0035864082);

final_score_tree_24_c392 := map(
    NULL < rv_e55_college_ind AND rv_e55_college_ind < 0.5 => final_score_tree_24_c393,
    rv_e55_college_ind >= 0.5                              => -0.0199874524,
                                                              -0.0015590491);

final_score_tree_24 := map(
    NULL < rv_d31_bk_disposed_recent_count AND rv_d31_bk_disposed_recent_count < 0.5 => final_score_tree_24_c392,
    rv_d31_bk_disposed_recent_count >= 0.5                                           => 0.0507233986,
                                                                                        0.0025177751);

final_score_tree_25_c398 := map(
    NULL < rv_c13_curr_addr_lres AND rv_c13_curr_addr_lres < 37.5 => 0.0109026129,
    rv_c13_curr_addr_lres >= 37.5                                 => -0.0009404947,
                                                                     0.0034109841);

final_score_tree_25_c400 := map(
    NULL < iv_num_non_bureau_sources AND iv_num_non_bureau_sources < 2.5 => 0.0178971693,
    iv_num_non_bureau_sources >= 2.5                                     => 0.1535023872,
                                                                            0.0921809100);

final_score_tree_25_c399 := map(
    NULL < in_addrpop_found AND in_addrpop_found < 0.5 => final_score_tree_25_c400,
    in_addrpop_found >= 0.5                            => 0.0242846416,
                                                          0.0349782056);

final_score_tree_25_c397 := map(
    NULL < rv_i62_inq_ssns_per_adl AND rv_i62_inq_ssns_per_adl < 5.5 => final_score_tree_25_c398,
    rv_i62_inq_ssns_per_adl >= 5.5                                   => final_score_tree_25_c399,
                                                                        -0.0052231963);

final_score_tree_25 := map(
    NULL < rv_l80_inp_avm_autoval AND rv_l80_inp_avm_autoval < 42775 => final_score_tree_25_c397,
    rv_l80_inp_avm_autoval >= 42775                                  => -0.0083010546,
                                                                        -0.0006562229);

final_score_tree_26_c404 := map(
    NULL < rv_comb_age AND rv_comb_age < 55.5 => -0.0027888473,
    rv_comb_age >= 55.5                       => 0.0132246263,
                                                 0.0043744323);

final_score_tree_26_c403 := map(
    NULL < rv_comb_age AND rv_comb_age < 80.5 => final_score_tree_26_c404,
    rv_comb_age >= 80.5                       => -0.0220500918,
                                                 0.0038995199);

final_score_tree_26_c402 := map(
    NULL < rv_i60_inq_banking_count12 AND rv_i60_inq_banking_count12 < 0.5 => final_score_tree_26_c403,
    rv_i60_inq_banking_count12 >= 0.5                                      => 0.0525585536,
                                                                              0.0058737489);

final_score_tree_26_c405 := map(
    NULL < rv_comb_age AND rv_comb_age < 56.5 => -0.0177767722,
    rv_comb_age >= 56.5                       => 0.0019594828,
                                                 -0.0096294668);

final_score_tree_26 := map(
    NULL < rv_l80_inp_avm_autoval AND rv_l80_inp_avm_autoval < 50926 => final_score_tree_26_c402,
    rv_l80_inp_avm_autoval >= 50926                                  => final_score_tree_26_c405,
                                                                        -0.0010211658);

final_score_tree_27_c408 := map(
    NULL < rv_c13_curr_addr_lres AND rv_c13_curr_addr_lres < 141.5 => 0.0049416277,
    rv_c13_curr_addr_lres >= 141.5                                 => -0.0093001509,
                                                                      0.0005530081);

final_score_tree_27_c410 := map(
    (rv_e58_br_dead_bus_x_active_phn in ['0-1', '0-2', '1-2', '1-3', '2-0', '2-1', '3-0', '3-2']) => -0.0626461659,
    (rv_e58_br_dead_bus_x_active_phn in ['0-0', '0-3', '1-0', '1-1', '2-2', '2-3', '3-1', '3-3']) => 0.0372786094,
                                                                                                     0.0339820235);

final_score_tree_27_c409 := map(
    NULL < rv_c20_m_bureau_adl_fs AND rv_c20_m_bureau_adl_fs < 319.5 => 0.0061201032,
    rv_c20_m_bureau_adl_fs >= 319.5                                  => final_score_tree_27_c410,
                                                                        0.0167471127);

final_score_tree_27_c407 := map(
    NULL < rv_d30_derog_count AND rv_d30_derog_count < 0.5 => final_score_tree_27_c408,
    rv_d30_derog_count >= 0.5                              => final_score_tree_27_c409,
                                                              0.0047659492);

final_score_tree_27 := map(
    NULL < rv_a46_curr_avm_autoval AND rv_a46_curr_avm_autoval < 48334.5 => final_score_tree_27_c407,
    rv_a46_curr_avm_autoval >= 48334.5                                   => -0.0079127550,
                                                                            -0.0026982104);

final_score_tree_28_c414 := map(
    NULL < rv_c12_inp_addr_source_count AND rv_c12_inp_addr_source_count < 1.5 => 0.0306580580,
    rv_c12_inp_addr_source_count >= 1.5                                        => 0.0000902039,
                                                                                  0.0227014446);

final_score_tree_28_c413 := map(
    NULL < rv_c13_curr_addr_lres AND rv_c13_curr_addr_lres < 27.5 => final_score_tree_28_c414,
    rv_c13_curr_addr_lres >= 27.5                                 => 0.0044464824,
                                                                     0.0105404375);

final_score_tree_28_c415 := map(
    NULL < rv_i62_inq_ssns_per_adl AND rv_i62_inq_ssns_per_adl < 2.5 => -0.0056629941,
    rv_i62_inq_ssns_per_adl >= 2.5                                   => 0.0199493927,
                                                                        -0.0043209546);

final_score_tree_28_c412 := map(
    NULL < rv_ever_asset_owner AND rv_ever_asset_owner < 0.5 => final_score_tree_28_c413,
    rv_ever_asset_owner >= 0.5                               => final_score_tree_28_c415,
                                                                0.0006804731);

final_score_tree_28 := map(
    NULL < rv_c20_m_bureau_adl_fs AND rv_c20_m_bureau_adl_fs < 172.5 => -0.0202026017,
    rv_c20_m_bureau_adl_fs >= 172.5                                  => final_score_tree_28_c412,
                                                                        -0.0020471154);

final_score_tree_29_c419 := map(
    NULL < iv_c13_avg_lres AND iv_c13_avg_lres < 116.5 => 0.0187698802,
    iv_c13_avg_lres >= 116.5                           => -0.0149066826,
                                                          0.0136924137);

final_score_tree_29_c420 := map(
    NULL < iv_full_name_ver_sources AND iv_full_name_ver_sources < 1.5 => -0.0639392781,
    iv_full_name_ver_sources >= 1.5                                    => -0.0010567007,
                                                                          -0.0018425044);

final_score_tree_29_c418 := map(
    NULL < rv_ever_asset_owner AND rv_ever_asset_owner < 0.5 => final_score_tree_29_c419,
    rv_ever_asset_owner >= 0.5                               => final_score_tree_29_c420,
                                                                0.0031130568);

final_score_tree_29_c417 := map(
    NULL < rv_c10_m_hdr_fs AND rv_c10_m_hdr_fs < 231.5 => -0.0113034103,
    rv_c10_m_hdr_fs >= 231.5                           => final_score_tree_29_c418,
                                                          -0.0060803662);

final_score_tree_29 := map(
    NULL < rv_l80_inp_avm_autoval AND rv_l80_inp_avm_autoval < 312232 => final_score_tree_29_c417,
    rv_l80_inp_avm_autoval >= 312232                                  => -0.0154815385,
                                                                         -0.0015416047);

final_score_tree_30_c424 := map(
    NULL < rv_d31_bk_disposed_recent_count AND rv_d31_bk_disposed_recent_count < 0.5 => -0.0074713464,
    rv_d31_bk_disposed_recent_count >= 0.5                                           => 0.1677517829,
                                                                                        -0.0044815252);

final_score_tree_30_c423 := map(
    NULL < rv_c13_attr_addrs_recency AND rv_c13_attr_addrs_recency < 18 => 0.0519957288,
    rv_c13_attr_addrs_recency >= 18                                     => final_score_tree_30_c424,
                                                                           0.0083497749);

final_score_tree_30_c422 := map(
    NULL < rv_c12_inp_addr_source_count AND rv_c12_inp_addr_source_count < 0.5 => final_score_tree_30_c423,
    rv_c12_inp_addr_source_count >= 0.5                                        => -0.0149179056,
                                                                                  -0.0110764963);

final_score_tree_30_c425 := map(
    NULL < rv_i60_inq_hiriskcred_count12 AND rv_i60_inq_hiriskcred_count12 < 0.5 => 0.0032225574,
    rv_i60_inq_hiriskcred_count12 >= 0.5                                         => 0.0335386411,
                                                                                    0.0042246954);

final_score_tree_30 := map(
    NULL < rv_comb_age AND rv_comb_age < 50.5 => final_score_tree_30_c422,
    rv_comb_age >= 50.5                       => final_score_tree_30_c425,
                                                 -0.0026174208);

final_score_tree_31_c428 := map(
    NULL < iv_c14_addrs_per_adl AND iv_c14_addrs_per_adl < 12.5 => 0.0036275279,
    iv_c14_addrs_per_adl >= 12.5                                => 0.0299273070,
                                                                   0.0044733201);

final_score_tree_31_c430 := map(
    NULL < rv_c22_inp_addr_occ_index AND rv_c22_inp_addr_occ_index < 2 => 0.0031407192,
    rv_c22_inp_addr_occ_index >= 2                                     => -0.0368473299,
                                                                          -0.0231959981);

final_score_tree_31_c429 := map(
    NULL < rv_c22_inp_addr_occ_index AND rv_c22_inp_addr_occ_index < 3.5 => final_score_tree_31_c430,
    rv_c22_inp_addr_occ_index >= 3.5                                     => 0.0160733103,
                                                                            -0.0131611584);

final_score_tree_31_c427 := map(
    NULL < rv_f03_input_add_not_most_rec AND rv_f03_input_add_not_most_rec < 0.5 => final_score_tree_31_c428,
    rv_f03_input_add_not_most_rec >= 0.5                                         => final_score_tree_31_c429,
                                                                                    0.0016638064);

final_score_tree_31 := map(
    NULL < iv_input_best_name_match AND iv_input_best_name_match < 2.5 => -0.0166791921,
    iv_input_best_name_match >= 2.5                                    => final_score_tree_31_c427,
                                                                          0.0068831095);

final_score_tree_32_c434 := map(
    NULL < rv_f03_address_match AND rv_f03_address_match < 3 => -0.0432309244,
    rv_f03_address_match >= 3                                => -0.0049803917,
                                                                -0.0248921076);

final_score_tree_32_c433 := map(
    NULL < rv_c12_inp_addr_source_count AND rv_c12_inp_addr_source_count < 0.5 => 0.0146297776,
    rv_c12_inp_addr_source_count >= 0.5                                        => final_score_tree_32_c434,
                                                                                  -0.0195722706);

final_score_tree_32_c435 := map(
    NULL < rv_c14_addrs_5yr AND rv_c14_addrs_5yr < 2.5 => 0.0040144253,
    rv_c14_addrs_5yr >= 2.5                            => 0.0417394567,
                                                          0.0082928225);

final_score_tree_32_c432 := map(
    NULL < rv_c22_inp_addr_occ_index AND rv_c22_inp_addr_occ_index < 3.5 => final_score_tree_32_c433,
    rv_c22_inp_addr_occ_index >= 3.5                                     => final_score_tree_32_c435,
                                                                            -0.0087997260);

final_score_tree_32 := map(
    NULL < rv_c22_inp_addr_occ_index AND rv_c22_inp_addr_occ_index < 2 => 0.0048678955,
    rv_c22_inp_addr_occ_index >= 2                                     => final_score_tree_32_c432,
                                                                          0.0083097087);

final_score_tree_33_c438 := map(
    NULL < rv_c13_inp_addr_lres AND rv_c13_inp_addr_lres < 18.5 => 0.0202673861,
    rv_c13_inp_addr_lres >= 18.5                                => 0.0026060118,
                                                                   0.0053263886);

final_score_tree_33_c440 := map(
    NULL < iv_c14_addrs_per_adl AND iv_c14_addrs_per_adl < 4.5 => -0.0076843477,
    iv_c14_addrs_per_adl >= 4.5                                => 0.0175342261,
                                                                  0.0053946866);

final_score_tree_33_c439 := map(
    NULL < rv_c22_inp_addr_occ_index AND rv_c22_inp_addr_occ_index < 3.5 => -0.0149281309,
    rv_c22_inp_addr_occ_index >= 3.5                                     => final_score_tree_33_c440,
                                                                            -0.0068931767);

final_score_tree_33_c437 := map(
    NULL < rv_c22_inp_addr_occ_index AND rv_c22_inp_addr_occ_index < 2 => final_score_tree_33_c438,
    rv_c22_inp_addr_occ_index >= 2                                     => final_score_tree_33_c439,
                                                                          0.0007399718);

final_score_tree_33 := map(
    NULL < rv_e55_college_ind AND rv_e55_college_ind < 0.5 => final_score_tree_33_c437,
    rv_e55_college_ind >= 0.5                              => -0.0177538558,
                                                              -0.0018719692);

final_score_tree_34_c445 := map(
    NULL < rv_l79_adls_per_sfd_addr AND rv_l79_adls_per_sfd_addr < 1.5 => 0.0142311102,
    rv_l79_adls_per_sfd_addr >= 1.5                                    => -0.0172874378,
                                                                          0.0031590207);

final_score_tree_34_c444 := map(
    NULL < rv_c22_inp_addr_occ_index AND rv_c22_inp_addr_occ_index < 3.5 => -0.0179731857,
    rv_c22_inp_addr_occ_index >= 3.5                                     => final_score_tree_34_c445,
                                                                            -0.0098122189);

final_score_tree_34_c443 := map(
    NULL < rv_c22_inp_addr_occ_index AND rv_c22_inp_addr_occ_index < 2 => 0.0013736647,
    rv_c22_inp_addr_occ_index >= 2                                     => final_score_tree_34_c444,
                                                                          -0.0026994286);

final_score_tree_34_c442 := map(
    NULL < iv_lname_non_phn_src_ct AND iv_lname_non_phn_src_ct < 6.5 => final_score_tree_34_c443,
    iv_lname_non_phn_src_ct >= 6.5                                   => -0.0545530564,
                                                                        -0.0031519719);

final_score_tree_34 := map(
    NULL < rv_i62_inq_num_names_per_adl AND rv_i62_inq_num_names_per_adl < 0.5 => final_score_tree_34_c442,
    rv_i62_inq_num_names_per_adl >= 0.5                                        => 0.0114355837,
                                                                                  -0.0086673488);

final_score_tree_35_c449 := map(
    NULL < rv_c13_attr_addrs_recency AND rv_c13_attr_addrs_recency < 18 => 0.0509701686,
    rv_c13_attr_addrs_recency >= 18                                     => 0.0000169596,
                                                                           0.0120054121);

final_score_tree_35_c450 := map(
    NULL < rv_l79_adls_per_addr_curr AND rv_l79_adls_per_addr_curr < 0.5 => -0.0191054559,
    rv_l79_adls_per_addr_curr >= 0.5                                     => 0.0047214084,
                                                                            0.0013991118);

final_score_tree_35_c448 := map(
    NULL < rv_c12_inp_addr_source_count AND rv_c12_inp_addr_source_count < 0.5 => final_score_tree_35_c449,
    rv_c12_inp_addr_source_count >= 0.5                                        => final_score_tree_35_c450,
                                                                                  0.0029028472);

final_score_tree_35_c447 := map(
    NULL < rv_a49_curr_avm_chg_1yr AND rv_a49_curr_avm_chg_1yr < 52014.5 => -0.0009655599,
    rv_a49_curr_avm_chg_1yr >= 52014.5                                   => -0.0235507471,
                                                                            final_score_tree_35_c448);

final_score_tree_35 := map(
    NULL < iv_input_best_name_match AND iv_input_best_name_match < 2.5 => -0.0148032286,
    iv_input_best_name_match >= 2.5                                    => final_score_tree_35_c447,
                                                                          -0.0059310832);

final_score_tree_36_c455 := map(
    NULL < iv_fname_non_phn_src_ct AND iv_fname_non_phn_src_ct < 1.5 => -0.0307850442,
    iv_fname_non_phn_src_ct >= 1.5                                   => 0.0082475417,
                                                                        0.0067974985);

final_score_tree_36_c454 := map(
    NULL < iv_header_emergence_age AND iv_header_emergence_age < 49.5 => final_score_tree_36_c455,
    iv_header_emergence_age >= 49.5                                   => -0.0137733968,
                                                                         0.0034860556);

final_score_tree_36_c453 := map(
    NULL < iv_lname_non_phn_src_ct AND iv_lname_non_phn_src_ct < 6.5 => final_score_tree_36_c454,
    iv_lname_non_phn_src_ct >= 6.5                                   => -0.0565611372,
                                                                        0.0029771113);

final_score_tree_36_c452 := map(
    NULL < iv_bureau_emergence_age AND iv_bureau_emergence_age < 25.5 => -0.0080105827,
    iv_bureau_emergence_age >= 25.5                                   => final_score_tree_36_c453,
                                                                         0.0082079395);

final_score_tree_36 := map(
    NULL < rv_i60_inq_banking_count12 AND rv_i60_inq_banking_count12 < 0.5 => final_score_tree_36_c452,
    rv_i60_inq_banking_count12 >= 0.5                                      => 0.0345622033,
                                                                              -0.0073177950);

final_score_tree_37_c459 := map(
    NULL < rv_c12_inp_addr_source_count AND rv_c12_inp_addr_source_count < 2.5 => 0.0022619893,
    rv_c12_inp_addr_source_count >= 2.5                                        => -0.0214184939,
                                                                                  -0.0036368276);

final_score_tree_37_c458 := map(
    NULL < iv_estimated_income AND iv_estimated_income < 36500 => final_score_tree_37_c459,
    iv_estimated_income >= 36500                               => -0.0279329139,
                                                                  -0.0090892571);

final_score_tree_37_c460 := map(
    NULL < rv_c14_addrs_15yr AND rv_c14_addrs_15yr < 7.5 => 0.0020941236,
    rv_c14_addrs_15yr >= 7.5                             => 0.0367726590,
                                                            0.0029339700);

final_score_tree_37_c457 := map(
    NULL < iv_bureau_emergence_age AND iv_bureau_emergence_age < 25.5 => final_score_tree_37_c458,
    iv_bureau_emergence_age >= 25.5                                   => final_score_tree_37_c460,
                                                                         0.0094765686);

final_score_tree_37 := map(
    NULL < rv_i60_inq_hiriskcred_count12 AND rv_i60_inq_hiriskcred_count12 < 0.5 => final_score_tree_37_c457,
    rv_i60_inq_hiriskcred_count12 >= 0.5                                         => 0.0176644671,
                                                                                    0.0000759811);

final_score_tree_38_c465 := map(
    NULL < iv_c14_addrs_per_adl AND iv_c14_addrs_per_adl < 2.5 => -0.0143367182,
    iv_c14_addrs_per_adl >= 2.5                                => 0.0362924870,
                                                                  0.0204950401);

final_score_tree_38_c464 := map(
    NULL < iv_estimated_income AND iv_estimated_income < 27500 => final_score_tree_38_c465,
    iv_estimated_income >= 27500                               => -0.0048920633,
                                                                  0.0048270755);

final_score_tree_38_c463 := map(
    NULL < rv_c22_inp_addr_occ_index AND rv_c22_inp_addr_occ_index < 3.5 => -0.0160071020,
    rv_c22_inp_addr_occ_index >= 3.5                                     => final_score_tree_38_c464,
                                                                            -0.0078398815);

final_score_tree_38_c462 := map(
    NULL < rv_c22_inp_addr_occ_index AND rv_c22_inp_addr_occ_index < 2 => 0.0024125328,
    rv_c22_inp_addr_occ_index >= 2                                     => final_score_tree_38_c463,
                                                                          -0.0013916054);

final_score_tree_38 := map(
    NULL < rv_i60_inq_banking_count12 AND rv_i60_inq_banking_count12 < 0.5 => final_score_tree_38_c462,
    rv_i60_inq_banking_count12 >= 0.5                                      => 0.0367988563,
                                                                              0.0006279556);

final_score_tree_39_c469 := map(
    NULL < rv_c20_m_bureau_adl_fs AND rv_c20_m_bureau_adl_fs < 392.5 => -0.0022963849,
    rv_c20_m_bureau_adl_fs >= 392.5                                  => 0.0104766957,
                                                                        -0.0008058780);

final_score_tree_39_c470 := map(
    NULL < rv_c13_curr_addr_lres AND rv_c13_curr_addr_lres < 118.5 => 0.0611922049,
    rv_c13_curr_addr_lres >= 118.5                                 => -0.0758849456,
                                                                      0.0412600682);

final_score_tree_39_c468 := map(
    NULL < iv_unverified_addr_count AND iv_unverified_addr_count < 14.5 => final_score_tree_39_c469,
    iv_unverified_addr_count >= 14.5                                    => final_score_tree_39_c470,
                                                                           -0.0005539091);

final_score_tree_39_c467 := map(
    NULL < iv_input_best_name_match AND iv_input_best_name_match < 1.5 => -0.0187559060,
    iv_input_best_name_match >= 1.5                                    => final_score_tree_39_c468,
                                                                          -0.0176508180);

final_score_tree_39 := map(
    NULL < rv_d31_bk_dism_hist_count AND rv_d31_bk_dism_hist_count < 0.5 => final_score_tree_39_c467,
    rv_d31_bk_dism_hist_count >= 0.5                                     => 0.0421630766,
                                                                            -0.0007240740);

final_score_tree_40_c473 := map(
    NULL < rv_comb_age AND rv_comb_age < 85.5 => 0.0016753371,
    rv_comb_age >= 85.5                       => -0.0296877124,
                                                 -0.0111792336);

final_score_tree_40_c474 := map(
    NULL < rv_comb_age AND rv_comb_age < 53.5 => 0.0057778221,
    rv_comb_age >= 53.5                       => 0.0487525693,
                                                 0.0172111892);

final_score_tree_40_c472 := map(
    NULL < iv_c14_addrs_per_adl AND iv_c14_addrs_per_adl < 11.5 => final_score_tree_40_c473,
    iv_c14_addrs_per_adl >= 11.5                                => final_score_tree_40_c474,
                                                                   0.0040645360);

final_score_tree_40_c475 := map(
    NULL < rv_c20_m_bureau_adl_fs AND rv_c20_m_bureau_adl_fs < 392.5 => -0.0080655175,
    rv_c20_m_bureau_adl_fs >= 392.5                                  => 0.0122537563,
                                                                        -0.0183884385);

final_score_tree_40 := map(
    NULL < rv_l80_inp_avm_autoval AND rv_l80_inp_avm_autoval < 64366.5 => final_score_tree_40_c472,
    rv_l80_inp_avm_autoval >= 64366.5                                  => final_score_tree_40_c475,
                                                                          -0.0010087395);

final_score_tree_41_c478 := map(
    NULL < rv_c14_addrs_5yr AND rv_c14_addrs_5yr < 2.5 => 0.0057132092,
    rv_c14_addrs_5yr >= 2.5                            => 0.0401685807,
                                                          0.0106225422);

final_score_tree_41_c480 := map(
    NULL < rv_f01_inp_addr_address_score AND rv_f01_inp_addr_address_score < 95 => -0.0265592917,
    rv_f01_inp_addr_address_score >= 95                                         => 0.0011451923,
                                                                                   -0.0009362145);

final_score_tree_41_c479 := map(
    NULL < rv_l79_adls_per_addr_curr AND rv_l79_adls_per_addr_curr < 0.5 => -0.0264880563,
    rv_l79_adls_per_addr_curr >= 0.5                                     => final_score_tree_41_c480,
                                                                            -0.0038053395);

final_score_tree_41_c477 := map(
    NULL < rv_c12_inp_addr_source_count AND rv_c12_inp_addr_source_count < 0.5 => final_score_tree_41_c478,
    rv_c12_inp_addr_source_count >= 0.5                                        => final_score_tree_41_c479,
                                                                                  -0.0019156409);

final_score_tree_41 := map(
    NULL < rv_c18_invalid_addrs_per_adl AND rv_c18_invalid_addrs_per_adl < 2.5 => final_score_tree_41_c477,
    rv_c18_invalid_addrs_per_adl >= 2.5                                        => 0.0121595796,
                                                                                  -0.0007110345);

final_score_tree_42_c483 := map(
    NULL < iv_estimated_income AND iv_estimated_income < 58500 => 0.0050586306,
    iv_estimated_income >= 58500                               => -0.0127224095,
                                                                  0.0030150197);

final_score_tree_42_c484 := map(
    NULL < rv_f04_curr_add_occ_index AND rv_f04_curr_add_occ_index < 2 => -0.0226612425,
    rv_f04_curr_add_occ_index >= 2                                     => 0.0040397784,
                                                                          -0.0113617812);

final_score_tree_42_c482 := map(
    NULL < rv_f03_input_add_not_most_rec AND rv_f03_input_add_not_most_rec < 0.5 => final_score_tree_42_c483,
    rv_f03_input_add_not_most_rec >= 0.5                                         => final_score_tree_42_c484,
                                                                                    0.0005786438);

final_score_tree_42_c485 := map(
    NULL < rv_a46_curr_avm_autoval AND rv_a46_curr_avm_autoval < 163783 => -0.0229243289,
    rv_a46_curr_avm_autoval >= 163783                                   => 0.0059544385,
                                                                           -0.0141314214);

final_score_tree_42 := map(
    NULL < iv_c13_avg_lres AND iv_c13_avg_lres < 185.5 => final_score_tree_42_c482,
    iv_c13_avg_lres >= 185.5                           => final_score_tree_42_c485,
                                                          0.0167573983);

final_score_tree_43_c487 := map(
    NULL < rv_i60_inq_count12 AND rv_i60_inq_count12 < 14.5 => -0.0054624949,
    rv_i60_inq_count12 >= 14.5                              => 0.0875997213,
                                                               -0.0049057665);

final_score_tree_43_c490 := map(
    NULL < rv_i60_inq_other_count12 AND rv_i60_inq_other_count12 < 0.5 => 0.0065181626,
    rv_i60_inq_other_count12 >= 0.5                                    => 0.0430450135,
                                                                          0.0072224231);

final_score_tree_43_c489 := map(
    NULL < iv_fname_non_phn_src_ct AND iv_fname_non_phn_src_ct < 1.5 => -0.0242973467,
    iv_fname_non_phn_src_ct >= 1.5                                   => final_score_tree_43_c490,
                                                                        0.0308545173);

final_score_tree_43_c488 := map(
    NULL < iv_bureau_emergence_age AND iv_bureau_emergence_age < 60.5 => final_score_tree_43_c489,
    iv_bureau_emergence_age >= 60.5                                   => -0.0295923034,
                                                                         0.0046118589);

final_score_tree_43 := map(
    NULL < iv_bureau_emergence_age AND iv_bureau_emergence_age < 23.5 => final_score_tree_43_c487,
    iv_bureau_emergence_age >= 23.5                                   => final_score_tree_43_c488,
                                                                         0.0049546999);

final_score_tree_44_c493 := map(
    NULL < rv_i60_inq_count12 AND rv_i60_inq_count12 < 12.5 => -0.0112012532,
    rv_i60_inq_count12 >= 12.5                              => 0.0811706976,
                                                               -0.0104506947);

final_score_tree_44_c494 := map(
    NULL < rv_d31_bk_disposed_recent_count AND rv_d31_bk_disposed_recent_count < 0.5 => 0.0004059454,
    rv_d31_bk_disposed_recent_count >= 0.5                                           => 0.0515437512,
                                                                                        0.0008428912);

final_score_tree_44_c492 := map(
    NULL < iv_bureau_emergence_age AND iv_bureau_emergence_age < 20.5 => final_score_tree_44_c493,
    iv_bureau_emergence_age >= 20.5                                   => final_score_tree_44_c494,
                                                                         -0.0003441656);

final_score_tree_44_c495 := map(
    NULL < rv_d32_mos_since_fel_ls AND rv_d32_mos_since_fel_ls < 53.5 => 0.0112613108,
    rv_d32_mos_since_fel_ls >= 53.5                                   => 0.1454761437,
                                                                         0.0131391473);

final_score_tree_44 := map(
    (rv_6seg_riskview_5_0 in ['0 TRUEDID = 0', '1 VER/VAL PROBLEMS', '2 ADDR NOT CURRENT - DEROG', '3 ADDR NOT CURRENT - OTHER', '5 SUFFICIENTLY VERD - OWNER', '6 SUFFICIENTLY VERD - OTHER']) => final_score_tree_44_c492,
    (rv_6seg_riskview_5_0 in ['4 SUFFICIENTLY VERD - DEROG'])                                                                                                                                   => final_score_tree_44_c495,
                                                                                                                                                                                                   -0.0010456714);

final_score_tree_45_c498 := map(
    NULL < iv_c13_avg_lres AND iv_c13_avg_lres < 56.5 => 0.0027539044,
    iv_c13_avg_lres >= 56.5                           => 0.1432479955,
                                                         0.0594705164);

final_score_tree_45_c497 := map(
    NULL < rv_d32_mos_since_crim_ls AND rv_d32_mos_since_crim_ls < 66.5 => 0.0000292316,
    rv_d32_mos_since_crim_ls >= 66.5                                    => final_score_tree_45_c498,
                                                                           0.0083031448);

final_score_tree_45_c500 := map(
    NULL < rv_a49_curr_avm_chg_1yr_pct AND rv_a49_curr_avm_chg_1yr_pct < 101.7 => 0.1178194627,
    rv_a49_curr_avm_chg_1yr_pct >= 101.7                                       => -0.0098613434,
                                                                                  0.0555969663);

final_score_tree_45_c499 := map(
    NULL < rv_c10_m_hdr_fs AND rv_c10_m_hdr_fs < 390.5 => -0.0450799983,
    rv_c10_m_hdr_fs >= 390.5                           => final_score_tree_45_c500,
                                                          -0.0204015604);

final_score_tree_45 := map(
    NULL < rv_l80_inp_avm_autoval AND rv_l80_inp_avm_autoval < 566570 => final_score_tree_45_c497,
    rv_l80_inp_avm_autoval >= 566570                                  => final_score_tree_45_c499,
                                                                         0.0000496588);

final_score_tree_46_c504 := map(
    NULL < iv_c14_addrs_per_adl AND iv_c14_addrs_per_adl < 1.5 => 0.0610474869,
    iv_c14_addrs_per_adl >= 1.5                                => -0.0280632038,
                                                                  -0.0249100563);

final_score_tree_46_c505 := map(
    NULL < iv_prv_addr_lres AND iv_prv_addr_lres < 397.5 => 0.0086498032,
    iv_prv_addr_lres >= 397.5                            => 0.1499199462,
                                                            0.0115160132);

final_score_tree_46_c503 := map(
    NULL < rv_c22_inp_addr_occ_index AND rv_c22_inp_addr_occ_index < 3.5 => final_score_tree_46_c504,
    rv_c22_inp_addr_occ_index >= 3.5                                     => final_score_tree_46_c505,
                                                                            -0.0155814679);

final_score_tree_46_c502 := map(
    NULL < rv_f03_input_add_not_most_rec AND rv_f03_input_add_not_most_rec < 0.5 => 0.0013613003,
    rv_f03_input_add_not_most_rec >= 0.5                                         => final_score_tree_46_c503,
                                                                                    -0.0013617687);

final_score_tree_46 := map(
    NULL < rv_d31_bk_disposed_recent_count AND rv_d31_bk_disposed_recent_count < 0.5 => final_score_tree_46_c502,
    rv_d31_bk_disposed_recent_count >= 0.5                                           => 0.0346680600,
                                                                                        -0.0004782954);

final_score_tree_47_c510 := map(
    NULL < iv_full_name_ver_sources AND iv_full_name_ver_sources < 0.5 => -0.0565046267,
    iv_full_name_ver_sources >= 0.5                                    => 0.0007854696,
                                                                          -0.0201337516);

final_score_tree_47_c509 := map(
    '' < iv_prof_license_category_pl AND iv_prof_license_category_pl < '1.5' => 0.0003757651,
    iv_prof_license_category_pl >= '1.5'                                       => -0.0215254301,
                                                                                final_score_tree_47_c510);

final_score_tree_47_c508 := map(
    NULL < rv_i60_credit_seeking AND rv_i60_credit_seeking < 0.5 => final_score_tree_47_c509,
    rv_i60_credit_seeking >= 0.5                                 => 0.0218829274,
                                                                    -0.0002875360);

final_score_tree_47_c507 := map(
    NULL < rv_c20_m_bureau_adl_fs AND rv_c20_m_bureau_adl_fs < 144.5 => -0.0279982212,
    rv_c20_m_bureau_adl_fs >= 144.5                                  => final_score_tree_47_c508,
                                                                        -0.0021263429);

final_score_tree_47 := map(
    NULL < rv_c12_num_nonderogs AND rv_c12_num_nonderogs < 1.5 => 0.0130080404,
    rv_c12_num_nonderogs >= 1.5                                => final_score_tree_47_c507,
                                                                  0.0051014887);

final_score_tree_48_c512 := map(
    NULL < iv_prv_addr_avm_auto_val AND iv_prv_addr_avm_auto_val < 61907 => 0.0008309955,
    iv_prv_addr_avm_auto_val >= 61907                                    => -0.0189244362,
                                                                            -0.0051693079);

final_score_tree_48_c515 := map(
    NULL < rv_c13_max_lres AND rv_c13_max_lres < 250.5 => 0.0081332958,
    rv_c13_max_lres >= 250.5                           => -0.0036221109,
                                                          0.0036390967);

final_score_tree_48_c514 := map(
    NULL < rv_i60_inq_other_count12 AND rv_i60_inq_other_count12 < 1.5 => final_score_tree_48_c515,
    rv_i60_inq_other_count12 >= 1.5                                    => 0.0942061023,
                                                                          0.0039127751);

final_score_tree_48_c513 := map(
    NULL < iv_lname_non_phn_src_ct AND iv_lname_non_phn_src_ct < 6.5 => final_score_tree_48_c514,
    iv_lname_non_phn_src_ct >= 6.5                                   => -0.0417587448,
                                                                        0.0035182786);

final_score_tree_48 := map(
    NULL < iv_bureau_emergence_age AND iv_bureau_emergence_age < 23.5 => final_score_tree_48_c512,
    iv_bureau_emergence_age >= 23.5                                   => final_score_tree_48_c513,
                                                                         -0.0003545649);

final_score_tree_49_c517 := map(
    NULL < in_addrpop_found AND in_addrpop_found < 0.5 => 0.0133399830,
    in_addrpop_found >= 0.5                            => -0.0244811423,
                                                          -0.0134974031);

final_score_tree_49_c520 := map(
    NULL < iv_bureau_emergence_age AND iv_bureau_emergence_age < 19.5 => -0.0102341925,
    iv_bureau_emergence_age >= 19.5                                   => 0.0069533292,
                                                                         -0.0192062078);

final_score_tree_49_c519 := map(
    NULL < rv_i60_inq_hiriskcred_count12 AND rv_i60_inq_hiriskcred_count12 < 0.5 => final_score_tree_49_c520,
    rv_i60_inq_hiriskcred_count12 >= 0.5                                         => 0.0253632264,
                                                                                    0.0043517105);

final_score_tree_49_c518 := map(
    NULL < iv_f00_nas_summary AND iv_f00_nas_summary < 11.5 => -0.0116871620,
    iv_f00_nas_summary >= 11.5                              => final_score_tree_49_c519,
                                                               0.0004804714);

final_score_tree_49 := map(
    NULL < rv_l79_adls_per_addr_curr AND rv_l79_adls_per_addr_curr < 0.5 => final_score_tree_49_c517,
    rv_l79_adls_per_addr_curr >= 0.5                                     => final_score_tree_49_c518,
                                                                            -0.0005080475);

final_score_tree_50_c524 := map(
    NULL < rv_c13_curr_addr_lres AND rv_c13_curr_addr_lres < 27.5 => 0.0191787218,
    rv_c13_curr_addr_lres >= 27.5                                 => 0.0055115991,
                                                                     0.0101526493);

final_score_tree_50_c523 := map(
    NULL < rv_a41_prop_owner AND rv_a41_prop_owner < 0.5 => final_score_tree_50_c524,
    rv_a41_prop_owner >= 0.5                             => -0.0022250806,
                                                            0.0043255107);

final_score_tree_50_c522 := map(
    NULL < rv_c20_m_bureau_adl_fs AND rv_c20_m_bureau_adl_fs < 160.5 => -0.0169192733,
    rv_c20_m_bureau_adl_fs >= 160.5                                  => final_score_tree_50_c523,
                                                                        0.0175931031);

final_score_tree_50_c525 := map(
    NULL < rv_d31_attr_bankruptcy_recency AND rv_d31_attr_bankruptcy_recency < 18 => -0.0052334896,
    rv_d31_attr_bankruptcy_recency >= 18                                          => 0.0204133906,
                                                                                     0.0045923548);

final_score_tree_50 := map(
    NULL < rv_l80_inp_avm_autoval AND rv_l80_inp_avm_autoval < 26041.5 => final_score_tree_50_c522,
    rv_l80_inp_avm_autoval >= 26041.5                                  => final_score_tree_50_c525,
                                                                          -0.0003124388);

final_score_tree_51_c530 := map(
    NULL < rv_c13_curr_addr_lres AND rv_c13_curr_addr_lres < 226.5 => 0.0034566270,
    rv_c13_curr_addr_lres >= 226.5                                 => -0.0084716061,
                                                                      0.0014928635);

final_score_tree_51_c529 := map(
    NULL < rv_d31_bk_disposed_recent_count AND rv_d31_bk_disposed_recent_count < 0.5 => final_score_tree_51_c530,
    rv_d31_bk_disposed_recent_count >= 0.5                                           => 0.0458501839,
                                                                                        0.0022073688);

final_score_tree_51_c528 := map(
    NULL < rv_l80_inp_avm_autoval AND rv_l80_inp_avm_autoval < 77643 => final_score_tree_51_c529,
    rv_l80_inp_avm_autoval >= 77643                                  => -0.0051908329,
                                                                        -0.0003520781);

final_score_tree_51_c527 := map(
    NULL < rv_c20_m_bureau_adl_fs AND rv_c20_m_bureau_adl_fs < 142.5 => -0.0252686148,
    rv_c20_m_bureau_adl_fs >= 142.5                                  => final_score_tree_51_c528,
                                                                        0.0012538870);

final_score_tree_51 := map(
    NULL < rv_s66_adlperssn_count AND rv_s66_adlperssn_count < 3.5 => final_score_tree_51_c527,
    rv_s66_adlperssn_count >= 3.5                                  => 0.0179063759,
                                                                      0.0000718398);

final_score_tree_52_c534 := map(
    NULL < rv_a46_curr_avm_autoval AND rv_a46_curr_avm_autoval < 88961 => 0.0544229879,
    rv_a46_curr_avm_autoval >= 88961                                   => -0.0217592780,
                                                                          0.0301644073);

final_score_tree_52_c533 := map(
    NULL < rv_d31_bk_disposed_recent_count AND rv_d31_bk_disposed_recent_count < 0.5 => -0.0012932093,
    rv_d31_bk_disposed_recent_count >= 0.5                                           => final_score_tree_52_c534,
                                                                                        -0.0009498982);

final_score_tree_52_c532 := map(
    NULL < rv_d31_bk_chapter AND rv_d31_bk_chapter < 12 => final_score_tree_52_c533,
    rv_d31_bk_chapter >= 12                             => 0.0247628187,
                                                           -0.0003901014);

final_score_tree_52_c535 := map(
    NULL < rv_c20_m_bureau_adl_fs AND rv_c20_m_bureau_adl_fs < 254.5 => 0.0009240290,
    rv_c20_m_bureau_adl_fs >= 254.5                                  => 0.0355216519,
                                                                        0.0203219159);

final_score_tree_52 := map(
    NULL < rv_i60_inq_other_count12 AND rv_i60_inq_other_count12 < 0.5 => final_score_tree_52_c532,
    rv_i60_inq_other_count12 >= 0.5                                    => final_score_tree_52_c535,
                                                                          -0.0084349500);

final_score_tree_53_c539 := map(
    NULL < rv_f03_address_match AND rv_f03_address_match < 3 => -0.0369557487,
    rv_f03_address_match >= 3                                => -0.0020462002,
                                                                -0.0202345143);

final_score_tree_53_c538 := map(
    NULL < rv_c12_inp_addr_source_count AND rv_c12_inp_addr_source_count < 0.5 => 0.0137150289,
    rv_c12_inp_addr_source_count >= 0.5                                        => final_score_tree_53_c539,
                                                                                  -0.0156058841);

final_score_tree_53_c537 := map(
    NULL < rv_c22_inp_addr_occ_index AND rv_c22_inp_addr_occ_index < 2 => 0.0021200033,
    rv_c22_inp_addr_occ_index >= 2                                     => final_score_tree_53_c538,
                                                                          -0.0025984964);

final_score_tree_53_c540 := map(
    NULL < iv_bureau_emergence_age AND iv_bureau_emergence_age < 50.5 => 0.0141876111,
    iv_bureau_emergence_age >= 50.5                                   => -0.0363753368,
                                                                         0.0063421608);

final_score_tree_53 := map(
    NULL < rv_c22_inp_addr_occ_index AND rv_c22_inp_addr_occ_index < 3.5 => final_score_tree_53_c537,
    rv_c22_inp_addr_occ_index >= 3.5                                     => final_score_tree_53_c540,
                                                                            0.0026027925);

final_score_tree_54_c544 := map(
    NULL < rv_f01_inp_addr_address_score AND rv_f01_inp_addr_address_score < 95 => -0.0257131914,
    rv_f01_inp_addr_address_score >= 95                                         => 0.0020038823,
                                                                                   -0.0005582338);

final_score_tree_54_c543 := map(
    NULL < rv_c12_inp_addr_source_count AND rv_c12_inp_addr_source_count < 0.5 => 0.0062443295,
    rv_c12_inp_addr_source_count >= 0.5                                        => final_score_tree_54_c544,
                                                                                  0.0003470576);

final_score_tree_54_c545 := map(
    (iv_d34_liens_unrel_x_rel in ['0-1', '1-0', '2-1', '3-0', '3-1', '3-2']) => -0.0451251957,
    (iv_d34_liens_unrel_x_rel in ['0-0', '0-2', '1-1', '1-2', '2-0', '2-2']) => 0.0607848330,
                                                                                0.0381632735);

final_score_tree_54_c542 := map(
    NULL < iv_unverified_addr_count AND iv_unverified_addr_count < 14.5 => final_score_tree_54_c543,
    iv_unverified_addr_count >= 14.5                                    => final_score_tree_54_c545,
                                                                           0.0005892432);

final_score_tree_54 := map(
    NULL < rv_e55_college_ind AND rv_e55_college_ind < 0.5 => final_score_tree_54_c542,
    rv_e55_college_ind >= 0.5                              => -0.0142945257,
                                                              -0.0012293557);

final_score_tree_55_c549 := map(
    NULL < rv_comb_age AND rv_comb_age < 48.5 => 0.0161441406,
    rv_comb_age >= 48.5                       => 0.0861121875,
                                                 0.0434754089);

final_score_tree_55_c548 := map(
    NULL < rv_i60_inq_hiriskcred_count12 AND rv_i60_inq_hiriskcred_count12 < 0.5 => 0.0056999141,
    rv_i60_inq_hiriskcred_count12 >= 0.5                                         => final_score_tree_55_c549,
                                                                                    0.0068444237);

final_score_tree_55_c547 := map(
    NULL < iv_full_name_ver_sources AND iv_full_name_ver_sources < 2.5 => -0.0043931504,
    iv_full_name_ver_sources >= 2.5                                    => final_score_tree_55_c548,
                                                                          -0.0090828943);

final_score_tree_55_c550 := map(
    NULL < rv_a41_a42_prop_owner_history AND rv_a41_a42_prop_owner_history < 0.5 => 0.0107027451,
    rv_a41_a42_prop_owner_history >= 0.5                                         => -0.0057578851,
                                                                                    -0.0088224227);

final_score_tree_55 := map(
    (iv_l77_dwelltype in ['RR', 'SFD'])  => final_score_tree_55_c547,
    (iv_l77_dwelltype in ['MFD', 'POB']) => final_score_tree_55_c550,
                                            -0.0000349177);

final_score_tree_56_c554 := map(
    NULL < rv_f04_curr_add_occ_index AND rv_f04_curr_add_occ_index < 2 => 0.0391749727,
    rv_f04_curr_add_occ_index >= 2                                     => -0.0080811622,
                                                                          0.0183860747);

final_score_tree_56_c553 := map(
    NULL < rv_c12_inp_addr_source_count AND rv_c12_inp_addr_source_count < 0.5 => final_score_tree_56_c554,
    rv_c12_inp_addr_source_count >= 0.5                                        => -0.0132042704,
                                                                                  -0.0061712285);

final_score_tree_56_c555 := map(
    NULL < rv_a49_curr_avm_chg_1yr_pct AND rv_a49_curr_avm_chg_1yr_pct < 110.75 => 0.0436543520,
    rv_a49_curr_avm_chg_1yr_pct >= 110.75                                       => -0.0154909270,
                                                                                   0.0137359578);

final_score_tree_56_c552 := map(
    NULL < rv_l79_adls_per_addr_curr AND rv_l79_adls_per_addr_curr < 1.5 => final_score_tree_56_c553,
    rv_l79_adls_per_addr_curr >= 1.5                                     => final_score_tree_56_c555,
                                                                            0.0057015818);

final_score_tree_56 := map(
    NULL < rv_c13_curr_addr_lres AND rv_c13_curr_addr_lres < 27.5 => final_score_tree_56_c552,
    rv_c13_curr_addr_lres >= 27.5                                 => -0.0025887525,
                                                                     0.0037504051);

final_score_tree_57_c560 := map(
    NULL < rv_c12_source_profile AND rv_c12_source_profile < 57.15 => -0.0058906459,
    rv_c12_source_profile >= 57.15                                 => 0.0195250525,
                                                                      0.0132502631);

final_score_tree_57_c559 := map(
    NULL < rv_a44_curr_add_naprop AND rv_a44_curr_add_naprop < 0.5 => final_score_tree_57_c560,
    rv_a44_curr_add_naprop >= 0.5                                  => 0.0020327216,
                                                                      0.0062300473);

final_score_tree_57_c558 := map(
    NULL < rv_d31_bk_index_lvl AND rv_d31_bk_index_lvl < 5.5 => final_score_tree_57_c559,
    rv_d31_bk_index_lvl >= 5.5                               => 0.0837238384,
                                                                0.0065926137);

final_score_tree_57_c557 := map(
    NULL < rv_comb_age AND rv_comb_age < 78.5 => final_score_tree_57_c558,
    rv_comb_age >= 78.5                       => -0.0245544455,
                                                 0.0093085939);

final_score_tree_57 := map(
    NULL < rv_c12_inp_addr_source_count AND rv_c12_inp_addr_source_count < 1.5 => final_score_tree_57_c557,
    rv_c12_inp_addr_source_count >= 1.5                                        => -0.0035187914,
                                                                                  0.0078042888);

final_score_tree_58_c563 := map(
    NULL < iv_unverified_addr_count AND iv_unverified_addr_count < 2.5 => -0.0000196706,
    iv_unverified_addr_count >= 2.5                                    => 0.0103742652,
                                                                          0.0039735006);

final_score_tree_58_c562 := map(
    NULL < rv_l79_adls_per_addr_curr AND rv_l79_adls_per_addr_curr < 0.5 => -0.0084206828,
    rv_l79_adls_per_addr_curr >= 0.5                                     => final_score_tree_58_c563,
                                                                            0.0017703386);

final_score_tree_58_c565 := map(
    (iv_inp_addr_mortgage_type in ['NO MORTGAGE'])                                          => -0.0031961704,
    (iv_inp_addr_mortgage_type in ['CONVENTIONAL', 'EQUITY LOAN', 'GOVERNMENT', 'UNKNOWN']) => 0.0195619540,
                                                                                               0.0044421989);

final_score_tree_58_c564 := map(
    NULL < iv_bureau_emergence_age AND iv_bureau_emergence_age < 30.5 => -0.0099645636,
    iv_bureau_emergence_age >= 30.5                                   => final_score_tree_58_c565,
                                                                         0.0098104578);

final_score_tree_58 := map(
    NULL < rv_l80_inp_avm_autoval AND rv_l80_inp_avm_autoval < 76898 => final_score_tree_58_c562,
    rv_l80_inp_avm_autoval >= 76898                                  => final_score_tree_58_c564,
                                                                        -0.0000113574);

final_score_tree_59_c568 := map(
    (rv_d32_criminal_x_felony in ['0-0', '1-0', '2-2', '3-0', '3-2', '3-3']) => -0.0116306293,
    (rv_d32_criminal_x_felony in ['1-1', '2-0', '2-1', '3-1'])               => 0.1592312106,
                                                                                -0.0108562659);

final_score_tree_59_c567 := map(
    NULL < rv_e57_prof_license_br_flag AND rv_e57_prof_license_br_flag < 0.5 => 0.0002920961,
    rv_e57_prof_license_br_flag >= 0.5                                       => final_score_tree_59_c568,
                                                                                -0.0046199283);

final_score_tree_59_c570 := map(
    NULL < rv_c13_inp_addr_lres AND rv_c13_inp_addr_lres < 260.5 => 0.0716461110,
    rv_c13_inp_addr_lres >= 260.5                                => -0.0681042311,
                                                                    0.0534307886);

final_score_tree_59_c569 := map(
    NULL < rv_c13_max_lres AND rv_c13_max_lres < 40.5 => final_score_tree_59_c570,
    rv_c13_max_lres >= 40.5                           => 0.0032555587,
                                                         0.0092796756);

final_score_tree_59 := map(
    (iv_l77_dwelltype in ['MFD', 'SFD']) => final_score_tree_59_c567,
    (iv_l77_dwelltype in ['POB', 'RR'])  => final_score_tree_59_c569,
                                            -0.0011238777);

final_score_tree_60_c573 := map(
    NULL < rv_d31_attr_bankruptcy_recency AND rv_d31_attr_bankruptcy_recency < 4.5 => -0.0052526194,
    rv_d31_attr_bankruptcy_recency >= 4.5                                          => 0.0121073243,
                                                                                      0.0450174022);

final_score_tree_60_c575 := map(
    NULL < iv_c13_avg_lres AND iv_c13_avg_lres < 249 => 0.0138946439,
    iv_c13_avg_lres >= 249                           => -0.0633267529,
                                                        0.0106718203);

final_score_tree_60_c574 := map(
    (rv_6seg_riskview_5_0 in ['2 ADDR NOT CURRENT - DEROG', '3 ADDR NOT CURRENT - OTHER', '5 SUFFICIENTLY VERD - OWNER'])           => 0.0011180369,
    (rv_6seg_riskview_5_0 in ['0 TRUEDID = 0', '1 VER/VAL PROBLEMS', '4 SUFFICIENTLY VERD - DEROG', '6 SUFFICIENTLY VERD - OTHER']) => final_score_tree_60_c575,
                                                                                                                                       0.0052213225);

final_score_tree_60_c572 := map(
    NULL < rv_s66_adlperssn_count AND rv_s66_adlperssn_count < 1.5 => final_score_tree_60_c573,
    rv_s66_adlperssn_count >= 1.5                                  => final_score_tree_60_c574,
                                                                      -0.0001299960);

final_score_tree_60 := map(
    NULL < rv_l80_inp_avm_autoval AND rv_l80_inp_avm_autoval < 739903 => final_score_tree_60_c572,
    rv_l80_inp_avm_autoval >= 739903                                  => -0.0179907736,
                                                                         -0.0001305318);

final_score_tree_61_c578 := map(
    NULL < rv_f01_inp_addr_address_score AND rv_f01_inp_addr_address_score < 95 => -0.0070640995,
    rv_f01_inp_addr_address_score >= 95                                         => 0.0040090699,
                                                                                   0.0021358856);

final_score_tree_61_c577 := map(
    NULL < rv_comb_age AND rv_comb_age < 51.5 => -0.0079205770,
    rv_comb_age >= 51.5                       => final_score_tree_61_c578,
                                                 -0.0046906245);

final_score_tree_61_c580 := map(
    (iv_d34_liens_unrel_x_rel in ['0-0', '0-1', '1-0', '2-0'])                             => 0.0135452669,
    (iv_d34_liens_unrel_x_rel in ['0-2', '1-1', '1-2', '2-1', '2-2', '3-0', '3-1', '3-2']) => 0.1618061526,
                                                                                              0.0162891164);

final_score_tree_61_c579 := map(
    NULL < iv_emergence_source_type AND iv_emergence_source_type < 1.5 => final_score_tree_61_c580,
    iv_emergence_source_type >= 1.5                                    => 0.1636507765,
                                                                          0.0187436289);

final_score_tree_61 := map(
    NULL < iv_lname_bureau_only AND iv_lname_bureau_only < 0.5 => final_score_tree_61_c577,
    iv_lname_bureau_only >= 0.5                                => final_score_tree_61_c579,
                                                                  -0.0010935152);

final_score_tree_62_c584 := map(
    NULL < iv_c13_avg_lres AND iv_c13_avg_lres < 14.5 => -0.0431316322,
    iv_c13_avg_lres >= 14.5                           => 0.0152957741,
                                                         0.0059420288);

final_score_tree_62_c585 := map(
    NULL < rv_a44_curr_add_naprop AND rv_a44_curr_add_naprop < 3.5 => -0.0390119871,
    rv_a44_curr_add_naprop >= 3.5                                  => 0.2458939175,
                                                                      0.0265778614);

final_score_tree_62_c583 := map(
    NULL < iv_header_emergence_age AND iv_header_emergence_age < 16.5 => final_score_tree_62_c584,
    iv_header_emergence_age >= 16.5                                   => -0.0178721028,
                                                                         final_score_tree_62_c585);

final_score_tree_62_c582 := map(
    NULL < rv_comb_age AND rv_comb_age < 37.5 => final_score_tree_62_c583,
    rv_comb_age >= 37.5                       => 0.0029414117,
                                                 -0.0068630824);

final_score_tree_62 := map(
    NULL < iv_prop1_purch_sale_diff AND iv_prop1_purch_sale_diff < -214999.5 => 0.0679901546,
    iv_prop1_purch_sale_diff >= -214999.5                                    => -0.0124714995,
                                                                                final_score_tree_62_c582);

final_score_tree_63_c588 := map(
    NULL < rv_l79_adls_per_addr_curr AND rv_l79_adls_per_addr_curr < 1.5 => 0.0014318234,
    rv_l79_adls_per_addr_curr >= 1.5                                     => -0.0198567681,
                                                                            -0.0072689295);

final_score_tree_63_c590 := map(
    NULL < rv_c13_curr_addr_lres AND rv_c13_curr_addr_lres < 107.5 => -0.0276357985,
    rv_c13_curr_addr_lres >= 107.5                                 => 0.0029035213,
                                                                      -0.0175106888);

final_score_tree_63_c589 := map(
    NULL < rv_l79_adls_per_addr_curr AND rv_l79_adls_per_addr_curr < 0.5 => final_score_tree_63_c590,
    rv_l79_adls_per_addr_curr >= 0.5                                     => 0.0023745872,
                                                                            0.0003744551);

final_score_tree_63_c587 := map(
    NULL < rv_f01_inp_addr_address_score AND rv_f01_inp_addr_address_score < 85 => final_score_tree_63_c588,
    rv_f01_inp_addr_address_score >= 85                                         => final_score_tree_63_c589,
                                                                                   -0.0011254334);

final_score_tree_63 := map(
    NULL < rv_d32_mos_since_fel_ls AND rv_d32_mos_since_fel_ls < 53.5 => final_score_tree_63_c587,
    rv_d32_mos_since_fel_ls >= 53.5                                   => 0.0755987901,
                                                                         0.0080311047);

final_score_tree_64_c593 := map(
    NULL < rv_a49_curr_add_avm_pct_chg_3yr AND rv_a49_curr_add_avm_pct_chg_3yr < 1.885 => -0.0182540123,
    rv_a49_curr_add_avm_pct_chg_3yr >= 1.885                                           => 0.0406684020,
                                                                                          -0.0069394560);

final_score_tree_64_c592 := map(
    NULL < adl_dob AND adl_dob < 0.5 => 0.0187412588,
    adl_dob >= 0.5                   => final_score_tree_64_c593,
                                        -0.0055725589);

final_score_tree_64_c595 := map(
    (rv_e58_br_dead_bus_x_active_phn in ['0-2', '1-1', '1-2', '2-0', '3-3'])                                           => -0.0362745421,
    (rv_e58_br_dead_bus_x_active_phn in ['0-0', '0-1', '0-3', '1-0', '1-3', '2-1', '2-2', '2-3', '3-0', '3-1', '3-2']) => 0.0043877567,
                                                                                                                          0.0037560470);

final_score_tree_64_c594 := map(
    (rv_d32_criminal_x_felony in ['0-0', '1-0', '1-1', '2-0', '3-2', '3-3']) => final_score_tree_64_c595,
    (rv_d32_criminal_x_felony in ['2-1', '2-2', '3-0', '3-1'])               => 0.1056173250,
                                                                                0.0039211457);

final_score_tree_64 := map(
    NULL < iv_bureau_emergence_age AND iv_bureau_emergence_age < 21.5 => final_score_tree_64_c592,
    iv_bureau_emergence_age >= 21.5                                   => final_score_tree_64_c594,
                                                                         0.0002550463);

final_score_tree_65_c599 := map(
    (iv_inp_addr_mortgage_type in ['NO MORTGAGE'])                                          => 0.0020256920,
    (iv_inp_addr_mortgage_type in ['CONVENTIONAL', 'EQUITY LOAN', 'GOVERNMENT', 'UNKNOWN']) => 0.0524032530,
                                                                                               0.0027651220);

final_score_tree_65_c598 := map(
    NULL < rv_a46_curr_avm_autoval AND rv_a46_curr_avm_autoval < 320085.5 => final_score_tree_65_c599,
    rv_a46_curr_avm_autoval >= 320085.5                                   => -0.0381383791,
                                                                             0.0015282918);

final_score_tree_65_c597 := map(
    NULL < rv_a44_curr_add_naprop AND rv_a44_curr_add_naprop < 1.5 => final_score_tree_65_c598,
    rv_a44_curr_add_naprop >= 1.5                                  => -0.0053210843,
                                                                      -0.0013732637);

final_score_tree_65_c600 := map(
    NULL < rv_c20_m_bureau_adl_fs AND rv_c20_m_bureau_adl_fs < 394.5 => 0.0409885797,
    rv_c20_m_bureau_adl_fs >= 394.5                                  => 0.0015762443,
                                                                        0.0109421819);

final_score_tree_65 := map(
    NULL < rv_c20_m_bureau_adl_fs AND rv_c20_m_bureau_adl_fs < 392.5 => final_score_tree_65_c597,
    rv_c20_m_bureau_adl_fs >= 392.5                                  => final_score_tree_65_c600,
                                                                        -0.0074683896);

final_score_tree_66_c603 := map(
    NULL < iv_c13_avg_lres AND iv_c13_avg_lres < 195.5 => 0.0099799984,
    iv_c13_avg_lres >= 195.5                           => -0.0428585826,
                                                          0.0078332146);

final_score_tree_66_c605 := map(
    NULL < rv_i62_inq_ssns_per_adl AND rv_i62_inq_ssns_per_adl < 9.5 => -0.0045483369,
    rv_i62_inq_ssns_per_adl >= 9.5                                   => 0.0297499109,
                                                                        -0.0040891103);

final_score_tree_66_c604 := map(
    NULL < iv_mos_src_voter_adl_lseen AND iv_mos_src_voter_adl_lseen < 39.5 => final_score_tree_66_c605,
    iv_mos_src_voter_adl_lseen >= 39.5                                      => 0.0121723521,
                                                                               -0.0026258641);

final_score_tree_66_c602 := map(
    NULL < rv_c12_num_nonderogs AND rv_c12_num_nonderogs < 1.5 => final_score_tree_66_c603,
    rv_c12_num_nonderogs >= 1.5                                => final_score_tree_66_c604,
                                                                  -0.0014167491);

final_score_tree_66 := map(
    NULL < rv_l80_inp_avm_autoval AND rv_l80_inp_avm_autoval < 1272880.5 => final_score_tree_66_c602,
    rv_l80_inp_avm_autoval >= 1272880.5                                  => 0.0398706827,
                                                                            -0.0007442622);

final_score_tree_67_c609 := map(
    NULL < iv_header_emergence_age AND iv_header_emergence_age < 35.5 => 0.0178210757,
    iv_header_emergence_age >= 35.5                                   => 0.0836755906,
                                                                         0.0211003617);

final_score_tree_67_c608 := map(
    NULL < iv_c14_addrs_per_adl AND iv_c14_addrs_per_adl < 11.5 => 0.0015923669,
    iv_c14_addrs_per_adl >= 11.5                                => final_score_tree_67_c609,
                                                                   0.0034081399);

final_score_tree_67_c610 := map(
    NULL < rv_f01_inp_addr_address_score AND rv_f01_inp_addr_address_score < 95 => -0.0354533610,
    rv_f01_inp_addr_address_score >= 95                                         => -0.0001750205,
                                                                                   -0.0022941328);

final_score_tree_67_c607 := map(
    NULL < rv_c12_inp_addr_source_count AND rv_c12_inp_addr_source_count < 1.5 => final_score_tree_67_c608,
    rv_c12_inp_addr_source_count >= 1.5                                        => final_score_tree_67_c610,
                                                                                  -0.0001613295);

final_score_tree_67 := map(
    NULL < iv_fname_non_phn_src_ct AND iv_fname_non_phn_src_ct < 0.5 => -0.0600818008,
    iv_fname_non_phn_src_ct >= 0.5                                   => final_score_tree_67_c607,
                                                                        -0.0028820466);

final_score_tree_68_c614 := map(
    NULL < rv_c12_source_profile AND rv_c12_source_profile < 75.05 => 0.0012973653,
    rv_c12_source_profile >= 75.05                                 => 0.0188247888,
                                                                      0.0102098350);

final_score_tree_68_c615 := map(
    NULL < rv_c13_inp_addr_lres AND rv_c13_inp_addr_lres < 39.5 => 0.1666495506,
    rv_c13_inp_addr_lres >= 39.5                                => -0.0323813426,
                                                                   0.0923446838);

final_score_tree_68_c613 := map(
    NULL < rv_l70_add_standardized AND rv_l70_add_standardized < 0.5 => final_score_tree_68_c614,
    rv_l70_add_standardized >= 0.5                                   => final_score_tree_68_c615,
                                                                        0.0084844504);

final_score_tree_68_c612 := map(
    NULL < rv_l80_inp_avm_autoval AND rv_l80_inp_avm_autoval < 341109.5 => final_score_tree_68_c613,
    rv_l80_inp_avm_autoval >= 341109.5                                  => -0.0815411342,
                                                                           0.0071800112);

final_score_tree_68 := map(
    NULL < rv_l79_adls_per_sfd_addr AND rv_l79_adls_per_sfd_addr < -0.5 => final_score_tree_68_c612,
    rv_l79_adls_per_sfd_addr >= -0.5                                    => -0.0023014559,
                                                                           -0.0004768446);

final_score_tree_69_c620 := map(
    NULL < iv_estimated_income AND iv_estimated_income < 60500 => 0.0025792858,
    iv_estimated_income >= 60500                               => -0.0113072833,
                                                                  0.0011073488);

final_score_tree_69_c619 := map(
    NULL < rv_comb_age AND rv_comb_age < 86.5 => final_score_tree_69_c620,
    rv_comb_age >= 86.5                       => -0.0257747653,
                                                 -0.0009383077);

final_score_tree_69_c618 := map(
    NULL < rv_c13_curr_addr_lres AND rv_c13_curr_addr_lres < 570.5 => final_score_tree_69_c619,
    rv_c13_curr_addr_lres >= 570.5                                 => 0.0459228787,
                                                                      0.0005371945);

final_score_tree_69_c617 := map(
    NULL < iv_input_best_name_match AND iv_input_best_name_match < 1.5 => -0.0148961631,
    iv_input_best_name_match >= 1.5                                    => final_score_tree_69_c618,
                                                                          -0.0030014491);

final_score_tree_69 := map(
    NULL < rv_l80_inp_avm_autoval AND rv_l80_inp_avm_autoval < 1340636.5 => final_score_tree_69_c617,
    rv_l80_inp_avm_autoval >= 1340636.5                                  => 0.0599389757,
                                                                            -0.0005290210);

final_score_tree_70_c623 := map(
    (iv_college_major in ['LIBERAL ARTS', 'UNCLASSIFIED'])                                       => -0.0238090745,
    (iv_college_major in ['BUSINESS', 'MEDICAL', 'NO AMS FOUND', 'NO COLLEGE FOUND', 'SCIENCE']) => -0.0007161956,
                                                                                                    -0.0017288649);

final_score_tree_70_c624 := map(
    NULL < rv_a49_curr_add_avm_chg_2yr AND rv_a49_curr_add_avm_chg_2yr < 39236.5 => 0.0605600665,
    rv_a49_curr_add_avm_chg_2yr >= 39236.5                                       => -0.0985704695,
                                                                                    0.0258577311);

final_score_tree_70_c622 := map(
    NULL < rv_d31_bk_disposed_recent_count AND rv_d31_bk_disposed_recent_count < 0.5 => final_score_tree_70_c623,
    rv_d31_bk_disposed_recent_count >= 0.5                                           => final_score_tree_70_c624,
                                                                                        -0.0066521107);

final_score_tree_70_c625 := map(
    NULL < iv_prv_addr_lres AND iv_prv_addr_lres < 394 => 0.0074369030,
    iv_prv_addr_lres >= 394                            => 0.1117810040,
                                                          0.0536698504);

final_score_tree_70 := map(
    (iv_l77_dwelltype in ['MFD', 'SFD']) => final_score_tree_70_c622,
    (iv_l77_dwelltype in ['POB', 'RR'])  => final_score_tree_70_c625,
                                            -0.0007424222);

final_score_tree_71_c628 := map(
    NULL < rv_comb_age AND rv_comb_age < 55.5 => -0.0062015381,
    rv_comb_age >= 55.5                       => 0.0019393408,
                                                 -0.0073691369);

final_score_tree_71_c629 := map(
    NULL < rv_d30_derog_count AND rv_d30_derog_count < 2.5 => 0.0167226059,
    rv_d30_derog_count >= 2.5                              => 0.1144105060,
                                                              0.0198029923);

final_score_tree_71_c627 := map(
    NULL < iv_lname_bureau_only AND iv_lname_bureau_only < 0.5 => final_score_tree_71_c628,
    iv_lname_bureau_only >= 0.5                                => final_score_tree_71_c629,
                                                                  -0.0011668531);

final_score_tree_71_c630 := map(
    NULL < rv_c18_invalid_addrs_per_adl AND rv_c18_invalid_addrs_per_adl < 1.5 => 0.0150652946,
    rv_c18_invalid_addrs_per_adl >= 1.5                                        => 0.0686342194,
                                                                                  0.0278517737);

final_score_tree_71 := map(
    NULL < rv_l79_adls_per_sfd_addr AND rv_l79_adls_per_sfd_addr < 5.5 => final_score_tree_71_c627,
    rv_l79_adls_per_sfd_addr >= 5.5                                    => final_score_tree_71_c630,
                                                                          -0.0004194845);

final_score_tree_72_c633 := map(
    NULL < iv_estimated_income AND iv_estimated_income < 59500 => 0.0000721364,
    iv_estimated_income >= 59500                               => -0.0177016372,
                                                                  -0.0012770871);

final_score_tree_72_c635 := map(
    NULL < rv_c13_max_lres AND rv_c13_max_lres < 300.5 => 0.0002870165,
    rv_c13_max_lres >= 300.5                           => 0.0295849753,
                                                          0.0059720448);

final_score_tree_72_c634 := map(
    NULL < rv_c13_max_lres AND rv_c13_max_lres < 38.5 => 0.0841378768,
    rv_c13_max_lres >= 38.5                           => final_score_tree_72_c635,
                                                         0.0080856623);

final_score_tree_72_c632 := map(
    (iv_inp_addr_mortgage_type in ['CONVENTIONAL', 'GOVERNMENT', 'NO MORTGAGE']) => final_score_tree_72_c633,
    (iv_inp_addr_mortgage_type in ['EQUITY LOAN', 'UNKNOWN'])                    => final_score_tree_72_c634,
                                                                                    0.0000814974);

final_score_tree_72 := map(
    NULL < rv_d31_bk_dism_hist_count AND rv_d31_bk_dism_hist_count < 0.5 => final_score_tree_72_c632,
    rv_d31_bk_dism_hist_count >= 0.5                                     => 0.0279345224,
                                                                            0.0064696559);

final_score_tree_73_c639 := map(
    NULL < rv_d31_bk_disposed_hist_count AND rv_d31_bk_disposed_hist_count < 1.5 => 0.0032861106,
    rv_d31_bk_disposed_hist_count >= 1.5                                         => 0.0693198657,
                                                                                    0.0034759664);

final_score_tree_73_c638 := map(
    NULL < iv_lname_non_phn_src_ct AND iv_lname_non_phn_src_ct < 4.5 => final_score_tree_73_c639,
    iv_lname_non_phn_src_ct >= 4.5                                   => -0.0041567996,
                                                                        0.0022383432);

final_score_tree_73_c640 := map(
    NULL < iv_estimated_income AND iv_estimated_income < 34500 => -0.0295446874,
    iv_estimated_income >= 34500                               => 0.0193663281,
                                                                  -0.0140063270);

final_score_tree_73_c637 := map(
    NULL < rv_comb_age AND rv_comb_age < 81.5 => final_score_tree_73_c638,
    rv_comb_age >= 81.5                       => final_score_tree_73_c640,
                                                 0.0015024510);

final_score_tree_73 := map(
    NULL < iv_prop2_purch_sale_diff AND iv_prop2_purch_sale_diff < 171748.5 => -0.0368259783,
    iv_prop2_purch_sale_diff >= 171748.5                                    => 0.0256601280,
                                                                               final_score_tree_73_c637);

final_score_tree_74_c642 := map(
    (rv_6seg_riskview_5_0 in ['0 TRUEDID = 0', '2 ADDR NOT CURRENT - DEROG', '3 ADDR NOT CURRENT - OTHER', '5 SUFFICIENTLY VERD - OWNER', '6 SUFFICIENTLY VERD - OTHER']) => -0.0015157081,
    (rv_6seg_riskview_5_0 in ['1 VER/VAL PROBLEMS', '4 SUFFICIENTLY VERD - DEROG'])                                                                                       => 0.0087071587,
                                                                                                                                                                             0.0000040858);

final_score_tree_74_c645 := map(
    (rv_e58_br_dead_bus_x_active_phn in ['0-0', '0-1', '0-2', '1-2', '1-3', '2-1'])                             => -0.0182729318,
    (rv_e58_br_dead_bus_x_active_phn in ['0-3', '1-0', '1-1', '2-0', '2-2', '2-3', '3-0', '3-1', '3-2', '3-3']) => 0.1075827499,
                                                                                                                   -0.0124525283);

final_score_tree_74_c644 := map(
    NULL < rv_a44_curr_add_naprop AND rv_a44_curr_add_naprop < 1.5 => 0.0085064612,
    rv_a44_curr_add_naprop >= 1.5                                  => final_score_tree_74_c645,
                                                                      -0.0001871202);

final_score_tree_74_c643 := map(
    NULL < rv_i62_inq_fnamesperadl_recency AND rv_i62_inq_fnamesperadl_recency < 2 => final_score_tree_74_c644,
    rv_i62_inq_fnamesperadl_recency >= 2                                           => 0.0583585263,
                                                                                      0.0042886629);

final_score_tree_74 := map(
    (iv_l77_dwelltype in ['MFD', 'SFD']) => final_score_tree_74_c642,
    (iv_l77_dwelltype in ['POB', 'RR'])  => final_score_tree_74_c643,
                                            0.0002358627);

final_score_tree_75_c649 := map(
    NULL < rv_c13_curr_addr_lres AND rv_c13_curr_addr_lres < 436.5 => -0.0309267483,
    rv_c13_curr_addr_lres >= 436.5                                 => 0.1718866955,
                                                                      -0.0253379805);

final_score_tree_75_c648 := map(
    NULL < iv_estimated_income AND iv_estimated_income < 70500 => -0.0007101264,
    iv_estimated_income >= 70500                               => final_score_tree_75_c649,
                                                                  -0.0018370779);

final_score_tree_75_c647 := map(
    (iv_inp_addr_mortgage_type in ['CONVENTIONAL', 'GOVERNMENT', 'NO MORTGAGE']) => final_score_tree_75_c648,
    (iv_inp_addr_mortgage_type in ['EQUITY LOAN', 'UNKNOWN'])                    => 0.0065358937,
                                                                                    -0.0006276275);

final_score_tree_75_c650 := map(
    NULL < iv_a46_l77_addrs_move_traj_index AND iv_a46_l77_addrs_move_traj_index < 1.5 => -0.0208671784,
    iv_a46_l77_addrs_move_traj_index >= 1.5                                            => 0.0377762558,
                                                                                          0.0254689799);

final_score_tree_75 := map(
    NULL < rv_i60_inq_banking_count12 AND rv_i60_inq_banking_count12 < 0.5 => final_score_tree_75_c647,
    rv_i60_inq_banking_count12 >= 0.5                                      => final_score_tree_75_c650,
                                                                              -0.0021267772);

final_score_tree_76_c653 := map(
    NULL < rv_c13_attr_addrs_recency AND rv_c13_attr_addrs_recency < 7.5 => 0.0143189874,
    rv_c13_attr_addrs_recency >= 7.5                                     => -0.0013365808,
                                                                            -0.0003966967);

final_score_tree_76_c655 := map(
    NULL < iv_c13_avg_lres AND iv_c13_avg_lres < 69.5 => 0.0484099207,
    iv_c13_avg_lres >= 69.5                           => 0.2037327951,
                                                         0.0837736108);

final_score_tree_76_c654 := map(
    NULL < rv_c20_m_bureau_adl_fs AND rv_c20_m_bureau_adl_fs < 360.5 => final_score_tree_76_c655,
    rv_c20_m_bureau_adl_fs >= 360.5                                  => -0.0537292077,
                                                                        0.0582730881);

final_score_tree_76_c652 := map(
    NULL < rv_d32_mos_since_crim_ls AND rv_d32_mos_since_crim_ls < 70.5 => final_score_tree_76_c653,
    rv_d32_mos_since_crim_ls >= 70.5                                    => final_score_tree_76_c654,
                                                                           0.0020238020);

final_score_tree_76 := map(
    NULL < rv_l80_inp_avm_autoval AND rv_l80_inp_avm_autoval < 710250 => final_score_tree_76_c652,
    rv_l80_inp_avm_autoval >= 710250                                  => -0.0255922542,
                                                                         -0.0004246199);

final_score_tree_77_c658 := map(
    NULL < iv_input_best_name_match AND iv_input_best_name_match < 1.5 => -0.0140612690,
    iv_input_best_name_match >= 1.5                                    => 0.0015817903,
                                                                          -0.0269372466);

final_score_tree_77_c660 := map(
    NULL < iv_bureau_emergence_age AND iv_bureau_emergence_age < 16.5 => 0.1133325768,
    iv_bureau_emergence_age >= 16.5                                   => 0.0268049940,
                                                                         0.0351159917);

final_score_tree_77_c659 := map(
    NULL < rv_comb_age AND rv_comb_age < 27.5 => -0.0470073928,
    rv_comb_age >= 27.5                       => final_score_tree_77_c660,
                                                 0.0239752225);

final_score_tree_77_c657 := map(
    NULL < rv_i60_inq_count12 AND rv_i60_inq_count12 < 6.5 => final_score_tree_77_c658,
    rv_i60_inq_count12 >= 6.5                              => final_score_tree_77_c659,
                                                              0.0035284499);

final_score_tree_77 := map(
    NULL < rv_l80_inp_avm_autoval AND rv_l80_inp_avm_autoval < 516968 => final_score_tree_77_c657,
    rv_l80_inp_avm_autoval >= 516968                                  => 0.0165694529,
                                                                         0.0012659067);

final_score_tree_78_c665 := map(
    NULL < rv_c20_m_bureau_adl_fs AND rv_c20_m_bureau_adl_fs < 349 => 0.2270671947,
    rv_c20_m_bureau_adl_fs >= 349                                  => 0.0147966443,
                                                                      0.1248628556);

final_score_tree_78_c664 := map(
    NULL < rv_a49_curr_add_avm_chg_2yr AND rv_a49_curr_add_avm_chg_2yr < 9199 => -0.0264549302,
    rv_a49_curr_add_avm_chg_2yr >= 9199                                       => final_score_tree_78_c665,
                                                                                 0.0449759465);

final_score_tree_78_c663 := map(
    NULL < iv_lname_bureau_only AND iv_lname_bureau_only < 0.5 => 0.0044618362,
    iv_lname_bureau_only >= 0.5                                => final_score_tree_78_c664,
                                                                  0.0059802982);

final_score_tree_78_c662 := map(
    NULL < iv_header_emergence_age AND iv_header_emergence_age < 71.5 => final_score_tree_78_c663,
    iv_header_emergence_age >= 71.5                                   => -0.0714546899,
                                                                         0.1015530550);

final_score_tree_78 := map(
    NULL < iv_full_name_ver_sources AND iv_full_name_ver_sources < 2.5 => -0.0025214048,
    iv_full_name_ver_sources >= 2.5                                    => final_score_tree_78_c662,
                                                                          -0.0225274887);

final_score_tree_79_c669 := map(
    NULL < iv_prop1_purch_sale_diff AND iv_prop1_purch_sale_diff < 22450 => -0.0526131063,
    iv_prop1_purch_sale_diff >= 22450                                    => 0.0196704179,
                                                                            0.0071503364);

final_score_tree_79_c670 := map(
    NULL < rv_c13_max_lres AND rv_c13_max_lres < 69.5 => -0.0489646027,
    rv_c13_max_lres >= 69.5                           => 0.0934456790,
                                                         0.0589915786);

final_score_tree_79_c668 := map(
    NULL < rv_i60_inq_hiriskcred_count12 AND rv_i60_inq_hiriskcred_count12 < 0.5 => final_score_tree_79_c669,
    rv_i60_inq_hiriskcred_count12 >= 0.5                                         => final_score_tree_79_c670,
                                                                                    0.0076804191);

final_score_tree_79_c667 := map(
    NULL < rv_c20_m_bureau_adl_fs AND rv_c20_m_bureau_adl_fs < 392.5 => -0.0020501802,
    rv_c20_m_bureau_adl_fs >= 392.5                                  => final_score_tree_79_c668,
                                                                        0.0059906379);

final_score_tree_79 := map(
    NULL < rv_l80_inp_avm_autoval AND rv_l80_inp_avm_autoval < 937214.5 => final_score_tree_79_c667,
    rv_l80_inp_avm_autoval >= 937214.5                                  => -0.0301363400,
                                                                           -0.0009895899);

final_score_tree_80_c672 := map(
    NULL < iv_header_emergence_age AND iv_header_emergence_age < 25.5 => -0.0261100387,
    iv_header_emergence_age >= 25.5                                   => 0.0101968839,
                                                                         -0.0236606890);

final_score_tree_80_c675 := map(
    NULL < rv_d30_derog_count AND rv_d30_derog_count < 0.5 => -0.0012093161,
    rv_d30_derog_count >= 0.5                              => 0.0135310975,
                                                              0.0009987430);

final_score_tree_80_c674 := map(
    NULL < rv_d30_derog_count AND rv_d30_derog_count < 2.5 => final_score_tree_80_c675,
    rv_d30_derog_count >= 2.5                              => -0.0250393328,
                                                              0.0000095039);

final_score_tree_80_c673 := map(
    NULL < rv_c13_curr_addr_lres AND rv_c13_curr_addr_lres < 42.5 => 0.0053951079,
    rv_c13_curr_addr_lres >= 42.5                                 => final_score_tree_80_c674,
                                                                     0.0019514210);

final_score_tree_80 := map(
    NULL < iv_input_best_name_match AND iv_input_best_name_match < 1.5 => final_score_tree_80_c672,
    iv_input_best_name_match >= 1.5                                    => final_score_tree_80_c673,
                                                                          0.0011205797);

final_score_tree_81_c678 := map(
    (iv_college_code_x_type in ['1-P', '1-S', '2-P', '2-R', '4-P', '4-R', '4-S']) => -0.0249669764,
    (iv_college_code_x_type in ['-1', '1-R', '2-S', '2-U'])                       => -0.0006200345,
                                                                                     -0.0015634299);

final_score_tree_81_c677 := map(
    NULL < rv_i60_inq_other_count12 AND rv_i60_inq_other_count12 < 3.5 => final_score_tree_81_c678,
    rv_i60_inq_other_count12 >= 3.5                                    => 0.1186263764,
                                                                          -0.0039242640);

final_score_tree_81_c680 := map(
    NULL < rv_c13_curr_addr_lres AND rv_c13_curr_addr_lres < 390 => 0.0033919883,
    rv_c13_curr_addr_lres >= 390                                 => -0.0540193232,
                                                                    0.0019898333);

final_score_tree_81_c679 := map(
    NULL < iv_lname_non_phn_src_ct AND iv_lname_non_phn_src_ct < 1.5 => 0.0702800287,
    iv_lname_non_phn_src_ct >= 1.5                                   => final_score_tree_81_c680,
                                                                        0.0058279152);

final_score_tree_81 := map(
    (iv_l77_dwelltype in ['MFD', 'SFD']) => final_score_tree_81_c677,
    (iv_l77_dwelltype in ['POB', 'RR'])  => final_score_tree_81_c679,
                                            -0.0011088195);

final_score_tree_82_c685 := map(
    NULL < rv_comb_age AND rv_comb_age < 37.5 => 0.0251259945,
    rv_comb_age >= 37.5                       => -0.0506252987,
                                                 -0.0265966627);

final_score_tree_82_c684 := map(
    NULL < iv_prv_addr_lres AND iv_prv_addr_lres < 62.5 => 0.0519517394,
    iv_prv_addr_lres >= 62.5                            => final_score_tree_82_c685,
                                                           0.0290267065);

final_score_tree_82_c683 := map(
    NULL < rv_a49_curr_avm_chg_1yr_pct AND rv_a49_curr_avm_chg_1yr_pct < 98.6 => 0.1117482104,
    rv_a49_curr_avm_chg_1yr_pct >= 98.6                                       => -0.0146788690,
                                                                                 final_score_tree_82_c684);

final_score_tree_82_c682 := map(
    NULL < rv_i60_inq_banking_recency AND rv_i60_inq_banking_recency < 2 => 0.0001062971,
    rv_i60_inq_banking_recency >= 2                                      => final_score_tree_82_c683,
                                                                            -0.0025226444);

final_score_tree_82 := map(
    NULL < rv_l80_inp_avm_autoval AND rv_l80_inp_avm_autoval < 1244000 => final_score_tree_82_c682,
    rv_l80_inp_avm_autoval >= 1244000                                  => 0.0525415654,
                                                                          0.0005330093);

final_score_tree_83_c690 := map(
    (rv_6seg_riskview_5_0 in ['2 ADDR NOT CURRENT - DEROG', '3 ADDR NOT CURRENT - OTHER', '5 SUFFICIENTLY VERD - OWNER'])           => 0.0202069232,
    (rv_6seg_riskview_5_0 in ['0 TRUEDID = 0', '1 VER/VAL PROBLEMS', '4 SUFFICIENTLY VERD - DEROG', '6 SUFFICIENTLY VERD - OTHER']) => 0.1073788192,
                                                                                                                                       0.0624896368);

final_score_tree_83_c689 := map(
    NULL < iv_prv_addr_lres AND iv_prv_addr_lres < 20.5 => final_score_tree_83_c690,
    iv_prv_addr_lres >= 20.5                            => 0.0177564263,
                                                           0.0314400608);

final_score_tree_83_c688 := map(
    NULL < rv_c12_source_profile AND rv_c12_source_profile < 55.65 => -0.0205196393,
    rv_c12_source_profile >= 55.65                                 => final_score_tree_83_c689,
                                                                      0.0184007444);

final_score_tree_83_c687 := map(
    NULL < rv_i62_inq_ssns_per_adl AND rv_i62_inq_ssns_per_adl < 8.5 => -0.0009417206,
    rv_i62_inq_ssns_per_adl >= 8.5                                   => final_score_tree_83_c688,
                                                                        -0.0001903161);

final_score_tree_83 := map(
    NULL < rv_l80_inp_avm_autoval AND rv_l80_inp_avm_autoval < 739903 => final_score_tree_83_c687,
    rv_l80_inp_avm_autoval >= 739903                                  => -0.0237190957,
                                                                         -0.0008150492);

final_score_tree_84_c693 := map(
    NULL < rv_comb_age AND rv_comb_age < 79.5 => -0.0013450954,
    rv_comb_age >= 79.5                       => -0.0211286906,
                                                 -0.0034088870);

final_score_tree_84_c695 := map(
    NULL < rv_l79_adls_per_apt_addr AND rv_l79_adls_per_apt_addr < 0.5 => 0.0131402543,
    rv_l79_adls_per_apt_addr >= 0.5                                    => 0.0565766959,
                                                                          0.0216528494);

final_score_tree_84_c694 := map(
    NULL < rv_c12_inp_addr_source_count AND rv_c12_inp_addr_source_count < 1.5 => final_score_tree_84_c695,
    rv_c12_inp_addr_source_count >= 1.5                                        => 0.0030553795,
                                                                                  0.0058265819);

final_score_tree_84_c692 := map(
    NULL < iv_full_name_ver_sources AND iv_full_name_ver_sources < 2.5 => final_score_tree_84_c693,
    iv_full_name_ver_sources >= 2.5                                    => final_score_tree_84_c694,
                                                                          -0.0049397252);

final_score_tree_84 := map(
    NULL < rv_l80_inp_avm_autoval AND rv_l80_inp_avm_autoval < 740168.5 => final_score_tree_84_c692,
    rv_l80_inp_avm_autoval >= 740168.5                                  => -0.0163021172,
                                                                           -0.0005055438);

final_score_tree_85_c699 := map(
    NULL < iv_f00_nas_summary AND iv_f00_nas_summary < 11.5 => -0.0124126366,
    iv_f00_nas_summary >= 11.5                              => 0.0007098036,
                                                               -0.0204532338);

final_score_tree_85_c698 := map(
    NULL < rv_c13_curr_addr_lres AND rv_c13_curr_addr_lres < 30.5 => 0.0011003866,
    rv_c13_curr_addr_lres >= 30.5                                 => final_score_tree_85_c699,
                                                                     -0.0010451272);

final_score_tree_85_c700 := map(
    NULL < rv_s66_adlperssn_count AND rv_s66_adlperssn_count < 3.5 => 0.0066329153,
    rv_s66_adlperssn_count >= 3.5                                  => 0.0754434911,
                                                                      -0.0240914835);

final_score_tree_85_c697 := map(
    NULL < iv_d34_released_liens_ct AND iv_d34_released_liens_ct < 3.5 => final_score_tree_85_c698,
    iv_d34_released_liens_ct >= 3.5                                    => 0.0934425970,
                                                                          final_score_tree_85_c700);

final_score_tree_85 := map(
    NULL < rv_l80_inp_avm_autoval AND rv_l80_inp_avm_autoval < 1707642.5 => final_score_tree_85_c697,
    rv_l80_inp_avm_autoval >= 1707642.5                                  => -0.0677354585,
                                                                            -0.0010130714);

final_score_tree_86_c705 := map(
    NULL < iv_estimated_income AND iv_estimated_income < 41500 => -0.0137409307,
    iv_estimated_income >= 41500                               => 0.0192442488,
                                                                  -0.0057845975);

final_score_tree_86_c704 := map(
    NULL < rv_c13_attr_addrs_recency AND rv_c13_attr_addrs_recency < 589.5 => 0.0083245134,
    rv_c13_attr_addrs_recency >= 589.5                                     => final_score_tree_86_c705,
                                                                              0.0050244347);

final_score_tree_86_c703 := map(
    NULL < rv_d32_mos_since_fel_ls AND rv_d32_mos_since_fel_ls < 20.5 => final_score_tree_86_c704,
    rv_d32_mos_since_fel_ls >= 20.5                                   => 0.1255915383,
                                                                         0.0053893836);

final_score_tree_86_c702 := map(
    (iv_college_major in ['LIBERAL ARTS', 'NO COLLEGE FOUND', 'UNCLASSIFIED']) => -0.0179853850,
    (iv_college_major in ['BUSINESS', 'MEDICAL', 'NO AMS FOUND', 'SCIENCE'])   => final_score_tree_86_c703,
                                                                                  0.0032229614);

final_score_tree_86 := map(
    NULL < iv_prv_addr_lres AND iv_prv_addr_lres < 77.5 => -0.0043748068,
    iv_prv_addr_lres >= 77.5                            => final_score_tree_86_c702,
                                                           -0.0055570064);

final_score_tree_87_c710 := map(
    NULL < iv_full_name_non_phn_src_ct AND iv_full_name_non_phn_src_ct < 4.5 => 0.0056667185,
    iv_full_name_non_phn_src_ct >= 4.5                                       => -0.0350125457,
                                                                                -0.0015411774);

final_score_tree_87_c709 := map(
    NULL < rv_a49_curr_avm_chg_1yr_pct AND rv_a49_curr_avm_chg_1yr_pct < 78.85 => 0.0458254117,
    rv_a49_curr_avm_chg_1yr_pct >= 78.85                                       => final_score_tree_87_c710,
                                                                                  -0.0003122272);

final_score_tree_87_c708 := map(
    NULL < rv_a49_curr_add_avm_chg_3yr AND rv_a49_curr_add_avm_chg_3yr < -53944 => -0.0459909958,
    rv_a49_curr_add_avm_chg_3yr >= -53944                                       => -0.0008072959,
                                                                                   final_score_tree_87_c709);

final_score_tree_87_c707 := map(
    NULL < rv_c18_invalid_addrs_per_adl AND rv_c18_invalid_addrs_per_adl < 11.5 => final_score_tree_87_c708,
    rv_c18_invalid_addrs_per_adl >= 11.5                                        => 0.0897059620,
                                                                                   -0.0043673539);

final_score_tree_87 := map(
    NULL < rv_l80_inp_avm_autoval AND rv_l80_inp_avm_autoval < 739683.5 => final_score_tree_87_c707,
    rv_l80_inp_avm_autoval >= 739683.5                                  => -0.0214862394,
                                                                           -0.0007146176);

final_score_tree_88_c714 := map(
    NULL < iv_prop1_purch_sale_diff AND iv_prop1_purch_sale_diff < 112510 => -0.0067899209,
    iv_prop1_purch_sale_diff >= 112510                                    => -0.0745795684,
                                                                             0.0110095707);

final_score_tree_88_c713 := map(
    NULL < rv_s66_adlperssn_count AND rv_s66_adlperssn_count < 2.5 => -0.0014724550,
    rv_s66_adlperssn_count >= 2.5                                  => final_score_tree_88_c714,
                                                                      0.0020397094);

final_score_tree_88_c712 := map(
    NULL < rv_l79_adls_per_apt_addr_c6 AND rv_l79_adls_per_apt_addr_c6 < 1.5 => final_score_tree_88_c713,
    rv_l79_adls_per_apt_addr_c6 >= 1.5                                       => -0.0299653530,
                                                                                -0.0004152387);

final_score_tree_88_c715 := map(
    NULL < rv_d34_unrel_lien60_count AND rv_d34_unrel_lien60_count < 1.5 => 0.0072402290,
    rv_d34_unrel_lien60_count >= 1.5                                     => 0.0987673652,
                                                                            0.0092931310);

final_score_tree_88 := map(
    (iv_l77_dwelltype in ['MFD', 'SFD']) => final_score_tree_88_c712,
    (iv_l77_dwelltype in ['POB', 'RR'])  => final_score_tree_88_c715,
                                            0.0001198179);

final_score_tree_89_c718 := map(
    NULL < rv_f03_input_add_not_most_rec AND rv_f03_input_add_not_most_rec < 0.5 => 0.0062237019,
    rv_f03_input_add_not_most_rec >= 0.5                                         => -0.0189686934,
                                                                                    0.0014043673);

final_score_tree_89_c719 := map(
    NULL < iv_lname_non_phn_src_ct AND iv_lname_non_phn_src_ct < 5.5 => -0.0009154948,
    iv_lname_non_phn_src_ct >= 5.5                                   => -0.0168323579,
                                                                        -0.0016499147);

final_score_tree_89_c717 := map(
    NULL < rv_c13_curr_addr_lres AND rv_c13_curr_addr_lres < 18.5 => final_score_tree_89_c718,
    rv_c13_curr_addr_lres >= 18.5                                 => final_score_tree_89_c719,
                                                                     -0.0009495007);

final_score_tree_89_c720 := map(
    NULL < iv_c14_addrs_per_adl AND iv_c14_addrs_per_adl < 9.5 => 0.0127143553,
    iv_c14_addrs_per_adl >= 9.5                                => 0.1346732746,
                                                                  0.0590278690);

final_score_tree_89 := map(
    NULL < rv_i60_inq_count12 AND rv_i60_inq_count12 < 16.5 => final_score_tree_89_c717,
    rv_i60_inq_count12 >= 16.5                              => final_score_tree_89_c720,
                                                               -0.0060412698);

final_score_tree_90_c725 := map(
    NULL < rv_i60_inq_count12 AND rv_i60_inq_count12 < 3.5 => 0.0030513118,
    rv_i60_inq_count12 >= 3.5                              => 0.0215946807,
                                                              0.0039163214);

final_score_tree_90_c724 := map(
    (rv_e58_br_dead_bus_x_active_phn in ['0-2', '0-3', '1-0', '1-2', '2-0', '2-1', '2-2', '2-3', '3-0', '3-3']) => -0.0261653921,
    (rv_e58_br_dead_bus_x_active_phn in ['0-0', '0-1', '1-1', '1-3', '3-1', '3-2'])                             => final_score_tree_90_c725,
                                                                                                                   0.0029602893);

final_score_tree_90_c723 := map(
    NULL < rv_a49_curr_avm_chg_1yr_pct AND rv_a49_curr_avm_chg_1yr_pct < 31.95 => 0.0771814434,
    rv_a49_curr_avm_chg_1yr_pct >= 31.95                                       => 0.0009720820,
                                                                                  final_score_tree_90_c724);

final_score_tree_90_c722 := map(
    NULL < rv_c20_m_bureau_adl_fs AND rv_c20_m_bureau_adl_fs < 144.5 => -0.0140454785,
    rv_c20_m_bureau_adl_fs >= 144.5                                  => final_score_tree_90_c723,
                                                                        0.0050798274);

final_score_tree_90 := map(
    NULL < rv_l80_inp_avm_autoval AND rv_l80_inp_avm_autoval < 1909181 => final_score_tree_90_c722,
    rv_l80_inp_avm_autoval >= 1909181                                  => 0.0781647152,
                                                                          0.0008756203);

final_score_tree_91_c727 := map(
    NULL < iv_c13_avg_lres AND iv_c13_avg_lres < 64.5 => -0.0049436876,
    iv_c13_avg_lres >= 64.5                           => 0.0016296685,
                                                         -0.0011253840);

final_score_tree_91_c730 := map(
    NULL < rv_c14_addrs_15yr AND rv_c14_addrs_15yr < 3.5 => 0.2128865255,
    rv_c14_addrs_15yr >= 3.5                             => 0.0636640159,
                                                            0.1395616716);

final_score_tree_91_c729 := map(
    NULL < rv_i60_inq_recency AND rv_i60_inq_recency < 2 => final_score_tree_91_c730,
    rv_i60_inq_recency >= 2                              => 0.0273499402,
                                                            0.0574808681);

final_score_tree_91_c728 := map(
    NULL < iv_c13_avg_lres AND iv_c13_avg_lres < 33.5 => -0.0183211093,
    iv_c13_avg_lres >= 33.5                           => final_score_tree_91_c729,
                                                         0.0290003564);

final_score_tree_91 := map(
    NULL < rv_i62_inq_phones_per_adl AND rv_i62_inq_phones_per_adl < 1.5 => final_score_tree_91_c727,
    rv_i62_inq_phones_per_adl >= 1.5                                     => final_score_tree_91_c728,
                                                                            0.0013511737);

final_score_tree_92_c735 := map(
    NULL < rv_d34_unrel_lien60_count AND rv_d34_unrel_lien60_count < 2.5 => -0.0058467685,
    rv_d34_unrel_lien60_count >= 2.5                                     => 0.1011096068,
                                                                            -0.0049944266);

final_score_tree_92_c734 := map(
    NULL < rv_l79_adls_per_addr_curr AND rv_l79_adls_per_addr_curr < 1.5 => final_score_tree_92_c735,
    rv_l79_adls_per_addr_curr >= 1.5                                     => 0.0093337000,
                                                                            0.0030011831);

final_score_tree_92_c733 := map(
    NULL < rv_c13_curr_addr_lres AND rv_c13_curr_addr_lres < 27.5 => final_score_tree_92_c734,
    rv_c13_curr_addr_lres >= 27.5                                 => -0.0019154238,
                                                                     -0.0005481023);

final_score_tree_92_c732 := map(
    (iv_d34_liens_unrel_x_rel in ['0-1', '0-2', '1-1', '1-2', '2-2', '3-0']) => -0.0184196928,
    (iv_d34_liens_unrel_x_rel in ['0-0', '1-0', '2-0', '2-1', '3-1', '3-2']) => final_score_tree_92_c733,
                                                                                -0.0260094173);

final_score_tree_92 := map(
    '' < iv_rv5_unscorable AND iv_rv5_unscorable < '0.5' => final_score_tree_92_c732,
    iv_rv5_unscorable >= '0.5'                             => 0.0472806555,
                                                            -0.0010914805);

final_score_tree_93_c739 := map(
    NULL < rv_l79_adls_per_addr_curr AND rv_l79_adls_per_addr_curr < 0.5 => -0.0194698882,
    rv_l79_adls_per_addr_curr >= 0.5                                     => 0.0037633406,
                                                                            0.0015769388);

final_score_tree_93_c738 := map(
    NULL < rv_f01_inp_addr_address_score AND rv_f01_inp_addr_address_score < 95 => -0.0036451743,
    rv_f01_inp_addr_address_score >= 95                                         => final_score_tree_93_c739,
                                                                                   0.0004905386);

final_score_tree_93_c740 := map(
    NULL < rv_a49_curr_add_avm_chg_2yr AND rv_a49_curr_add_avm_chg_2yr < 6135.5 => 0.0907577240,
    rv_a49_curr_add_avm_chg_2yr >= 6135.5                                       => -0.0354522142,
                                                                                   0.0313516462);

final_score_tree_93_c737 := map(
    NULL < rv_i60_inq_banking_recency AND rv_i60_inq_banking_recency < 4.5 => final_score_tree_93_c738,
    rv_i60_inq_banking_recency >= 4.5                                      => final_score_tree_93_c740,
                                                                              0.0007573403);

final_score_tree_93 := map(
    NULL < iv_fname_non_phn_src_ct AND iv_fname_non_phn_src_ct < 0.5 => -0.0499454514,
    iv_fname_non_phn_src_ct >= 0.5                                   => final_score_tree_93_c737,
                                                                        0.0098179903);

final_score_tree_94_c745 := map(
    NULL < rv_c18_invalid_addrs_per_adl AND rv_c18_invalid_addrs_per_adl < 11.5 => 0.0032648129,
    rv_c18_invalid_addrs_per_adl >= 11.5                                        => 0.1149929495,
                                                                                   0.0033858130);

final_score_tree_94_c744 := map(
    NULL < rv_c13_inp_addr_lres AND rv_c13_inp_addr_lres < 11.5 => -0.0035168766,
    rv_c13_inp_addr_lres >= 11.5                                => final_score_tree_94_c745,
                                                                   0.0013741340);

final_score_tree_94_c743 := map(
    NULL < iv_d34_liens_rel_cj_ct AND iv_d34_liens_rel_cj_ct < 0.5 => final_score_tree_94_c744,
    iv_d34_liens_rel_cj_ct >= 0.5                                  => -0.0290932584,
                                                                      0.0008249742);

final_score_tree_94_c742 := map(
    NULL < iv_prop2_purch_sale_diff AND iv_prop2_purch_sale_diff < 4672.5 => 0.0893076765,
    iv_prop2_purch_sale_diff >= 4672.5                                    => -0.0378360878,
                                                                             final_score_tree_94_c743);

final_score_tree_94 := map(
    NULL < iv_prop1_purch_sale_diff AND iv_prop1_purch_sale_diff < -609600 => 0.0723279381,
    iv_prop1_purch_sale_diff >= -609600                                    => -0.0114887252,
                                                                              final_score_tree_94_c742);

final_score_tree_95_c750 := map(
    NULL < rv_c13_attr_addrs_recency AND rv_c13_attr_addrs_recency < 7.5 => 0.0965777723,
    rv_c13_attr_addrs_recency >= 7.5                                     => 0.0114704074,
                                                                            0.0134348071);

final_score_tree_95_c749 := map(
    (iv_d34_liens_unrel_x_rel in ['0-2', '1-0', '2-1', '2-2', '3-1', '3-2']) => -0.0408682102,
    (iv_d34_liens_unrel_x_rel in ['0-0', '0-1', '1-1', '1-2', '2-0', '3-0']) => final_score_tree_95_c750,
                                                                                0.0111376530);

final_score_tree_95_c748 := map(
    (iv_inp_addr_mortgage_type in ['CONVENTIONAL', 'GOVERNMENT', 'NO MORTGAGE']) => 0.0007376696,
    (iv_inp_addr_mortgage_type in ['EQUITY LOAN', 'UNKNOWN'])                    => final_score_tree_95_c749,
                                                                                    0.0020907697);

final_score_tree_95_c747 := map(
    NULL < iv_prop2_purch_sale_diff AND iv_prop2_purch_sale_diff < 172050 => -0.0027382833,
    iv_prop2_purch_sale_diff >= 172050                                    => 0.1023210831,
                                                                             final_score_tree_95_c748);

final_score_tree_95 := map(
    NULL < iv_estimated_income AND iv_estimated_income < 87500 => final_score_tree_95_c747,
    iv_estimated_income >= 87500                               => -0.0170884545,
                                                                  -0.0037929097);

final_score_tree_96_c754 := map(
    NULL < rv_c13_curr_addr_lres AND rv_c13_curr_addr_lres < 0.5 => -0.0429209935,
    rv_c13_curr_addr_lres >= 0.5                                 => 0.0195598215,
                                                                    0.0170687787);

final_score_tree_96_c753 := map(
    NULL < rv_l79_adls_per_addr_curr AND rv_l79_adls_per_addr_curr < 1.5 => final_score_tree_96_c754,
    rv_l79_adls_per_addr_curr >= 1.5                                     => -0.0067043869,
                                                                            0.0076947749);

final_score_tree_96_c755 := map(
    NULL < rv_l79_adls_per_addr_curr AND rv_l79_adls_per_addr_curr < 0.5 => -0.0183811907,
    rv_l79_adls_per_addr_curr >= 0.5                                     => 0.0008694116,
                                                                            -0.0013626975);

final_score_tree_96_c752 := map(
    NULL < rv_c12_inp_addr_source_count AND rv_c12_inp_addr_source_count < 0.5 => final_score_tree_96_c753,
    rv_c12_inp_addr_source_count >= 0.5                                        => final_score_tree_96_c755,
                                                                                  -0.0001295345);

final_score_tree_96 := map(
    NULL < iv_c13_avg_lres AND iv_c13_avg_lres < 229.5 => final_score_tree_96_c752,
    iv_c13_avg_lres >= 229.5                           => -0.0156816624,
                                                          0.0115063000);

final_score_tree_97_c758 := map(
    NULL < rv_a44_curr_add_naprop AND rv_a44_curr_add_naprop < 1.5 => 0.0014082204,
    rv_a44_curr_add_naprop >= 1.5                                  => -0.0040739192,
                                                                      -0.0007626086);

final_score_tree_97_c760 := map(
    NULL < rv_c12_inp_addr_source_count AND rv_c12_inp_addr_source_count < 1.5 => 0.1255106930,
    rv_c12_inp_addr_source_count >= 1.5                                        => 0.0245980597,
                                                                                  0.0744874514);

final_score_tree_97_c759 := map(
    NULL < rv_i60_inq_hiriskcred_count12 AND rv_i60_inq_hiriskcred_count12 < 0.5 => 0.0147917048,
    rv_i60_inq_hiriskcred_count12 >= 0.5                                         => final_score_tree_97_c760,
                                                                                    0.0281575449);

final_score_tree_97_c757 := map(
    NULL < rv_d31_bk_dism_hist_count AND rv_d31_bk_dism_hist_count < 0.5 => final_score_tree_97_c758,
    rv_d31_bk_dism_hist_count >= 0.5                                     => final_score_tree_97_c759,
                                                                            -0.0031795054);

final_score_tree_97 := map(
    NULL < rv_l80_inp_avm_autoval AND rv_l80_inp_avm_autoval < 207259.5 => final_score_tree_97_c757,
    rv_l80_inp_avm_autoval >= 207259.5                                  => 0.0062877646,
                                                                           0.0005656885);

final_score_tree_98_c763 := map(
    (iv_l77_dwelltype in ['POB'])              => -0.0193840459,
    (iv_l77_dwelltype in ['MFD', 'RR', 'SFD']) => 0.0195232343,
                                                  0.0150224877);

final_score_tree_98_c764 := map(
    NULL < rv_comb_age AND rv_comb_age < 69.5 => -0.0068469792,
    rv_comb_age >= 69.5                       => -0.0409658404,
                                                 -0.0129266699);

final_score_tree_98_c762 := map(
    NULL < rv_l79_adls_per_sfd_addr AND rv_l79_adls_per_sfd_addr < 1.5 => final_score_tree_98_c763,
    rv_l79_adls_per_sfd_addr >= 1.5                                    => final_score_tree_98_c764,
                                                                          0.0058920098);

final_score_tree_98_c765 := map(
    NULL < rv_f01_inp_addr_address_score AND rv_f01_inp_addr_address_score < 95 => -0.0223855267,
    rv_f01_inp_addr_address_score >= 95                                         => -0.0005371417,
                                                                                   -0.0025662559);

final_score_tree_98 := map(
    NULL < rv_c12_inp_addr_source_count AND rv_c12_inp_addr_source_count < 0.5 => final_score_tree_98_c762,
    rv_c12_inp_addr_source_count >= 0.5                                        => final_score_tree_98_c765,
                                                                                  0.0022021827);

final_score_tree_99_c769 := map(
    NULL < iv_num_inperson_sources AND iv_num_inperson_sources < 0.5 => 0.0412125840,
    iv_num_inperson_sources >= 0.5                                   => 0.0099407500,
                                                                        0.0136401569);

final_score_tree_99_c768 := map(
    NULL < rv_c10_m_hdr_fs AND rv_c10_m_hdr_fs < 145.5 => -0.0210185031,
    rv_c10_m_hdr_fs >= 145.5                           => final_score_tree_99_c769,
                                                          0.0091638164);

final_score_tree_99_c770 := map(
    NULL < adl_hphn AND adl_hphn < 0.5 => -0.0378108819,
    adl_hphn >= 0.5                    => 0.0208806632,
                                          -0.0005115822);

final_score_tree_99_c767 := map(
    NULL < rv_i62_inq_fnamesperadl_recency AND rv_i62_inq_fnamesperadl_recency < 0.5 => -0.0004080165,
    rv_i62_inq_fnamesperadl_recency >= 0.5                                           => final_score_tree_99_c768,
                                                                                        final_score_tree_99_c770);

final_score_tree_99 := map(
    NULL < rv_l80_inp_avm_autoval AND rv_l80_inp_avm_autoval < 1505000 => final_score_tree_99_c767,
    rv_l80_inp_avm_autoval >= 1505000                                  => -0.0376226677,
                                                                          0.0005689198);

final_score_tree_100_c774 := map(
    NULL < iv_lname_non_phn_src_ct AND iv_lname_non_phn_src_ct < 2.5 => 0.0074726356,
    iv_lname_non_phn_src_ct >= 2.5                                   => -0.0011511091,
                                                                        0.0012106020);

final_score_tree_100_c773 := map(
    NULL < iv_input_best_name_match AND iv_input_best_name_match < 1.5 => -0.0143495378,
    iv_input_best_name_match >= 1.5                                    => final_score_tree_100_c774,
                                                                          -0.0149297372);

final_score_tree_100_c772 := map(
    (rv_e58_br_dead_bus_x_active_phn in ['0-1', '0-2', '1-0', '1-1', '2-0', '2-3', '3-0', '3-1', '3-3']) => -0.0164114017,
    (rv_e58_br_dead_bus_x_active_phn in ['0-0', '0-3', '1-2', '1-3', '2-1', '2-2', '3-2'])               => final_score_tree_100_c773,
                                                                                                            -0.0003734026);

final_score_tree_100_c775 := map(
    NULL < rv_c13_inp_addr_lres AND rv_c13_inp_addr_lres < 184.5 => -0.0066246160,
    rv_c13_inp_addr_lres >= 184.5                                => 0.0427418630,
                                                                    0.0149081256);

final_score_tree_100 := map(
    NULL < rv_l80_inp_avm_autoval AND rv_l80_inp_avm_autoval < 514005 => final_score_tree_100_c772,
    rv_l80_inp_avm_autoval >= 514005                                  => final_score_tree_100_c775,
                                                                         -0.0004258235);

final_score_tree_101_c778 := map(
    NULL < rv_c13_inp_addr_lres AND rv_c13_inp_addr_lres < 97.5 => -0.0048168384,
    rv_c13_inp_addr_lres >= 97.5                                => 0.0015523479,
                                                                   -0.0022406926);

final_score_tree_101_c780 := map(
    NULL < iv_header_emergence_age AND iv_header_emergence_age < 17.5 => 0.0163297456,
    iv_header_emergence_age >= 17.5                                   => -0.0036235057,
                                                                         -0.0170753161);

final_score_tree_101_c779 := map(
    NULL < rv_c12_source_profile AND rv_c12_source_profile < 75.35 => final_score_tree_101_c780,
    rv_c12_source_profile >= 75.35                                 => 0.0156792459,
                                                                      0.0048446428);

final_score_tree_101_c777 := map(
    NULL < rv_s66_adlperssn_count AND rv_s66_adlperssn_count < 1.5 => final_score_tree_101_c778,
    rv_s66_adlperssn_count >= 1.5                                  => final_score_tree_101_c779,
                                                                      0.0060471622);

final_score_tree_101 := map(
    NULL < rv_i62_inq_num_names_per_adl AND rv_i62_inq_num_names_per_adl < 4.5 => final_score_tree_101_c777,
    rv_i62_inq_num_names_per_adl >= 4.5                                        => -0.0737716463,
                                                                                  0.0118355394);

final_score_tree_102_c783 := map(
    NULL < rv_l80_inp_avm_autoval AND rv_l80_inp_avm_autoval < 304960.5 => 0.0003018028,
    rv_l80_inp_avm_autoval >= 304960.5                                  => 0.0853967789,
                                                                           0.0004975963);

final_score_tree_102_c785 := map(
    NULL < rv_comb_age AND rv_comb_age < 55.5 => 0.1543792077,
    rv_comb_age >= 55.5                       => 0.0164348086,
                                                 0.0940856293);

final_score_tree_102_c784 := map(
    NULL < rv_c20_m_bureau_adl_fs AND rv_c20_m_bureau_adl_fs < 310.5 => 0.0016124127,
    rv_c20_m_bureau_adl_fs >= 310.5                                  => final_score_tree_102_c785,
                                                                        0.0463670784);

final_score_tree_102_c782 := map(
    (iv_d34_liens_unrel_x_rel in ['0-0', '0-1', '0-2', '1-0', '1-1', '2-0', '2-1', '2-2', '3-0', '3-2']) => final_score_tree_102_c783,
    (iv_d34_liens_unrel_x_rel in ['1-2', '3-1'])                                                         => final_score_tree_102_c784,
                                                                                                            0.0006080596);

final_score_tree_102 := map(
    NULL < rv_l80_inp_avm_autoval AND rv_l80_inp_avm_autoval < 309736 => final_score_tree_102_c782,
    rv_l80_inp_avm_autoval >= 309736                                  => -0.0085259091,
                                                                         -0.0000295498);

final_score_tree_103_c788 := map(
    NULL < rv_c14_addrs_5yr AND rv_c14_addrs_5yr < 0.5 => -0.0197011519,
    rv_c14_addrs_5yr >= 0.5                            => 0.0447724518,
                                                          -0.0015871351);

final_score_tree_103_c787 := map(
    NULL < iv_prv_addr_lres AND iv_prv_addr_lres < 72.5 => -0.0022002297,
    iv_prv_addr_lres >= 72.5                            => 0.0074368193,
                                                           final_score_tree_103_c788);

final_score_tree_103_c790 := map(
    NULL < rv_comb_age AND rv_comb_age < 44.5 => 0.0118342054,
    rv_comb_age >= 44.5                       => 0.1033595963,
                                                 0.0497518673);

final_score_tree_103_c789 := map(
    NULL < rv_d32_mos_since_crim_ls AND rv_d32_mos_since_crim_ls < 30.5 => -0.0025070805,
    rv_d32_mos_since_crim_ls >= 30.5                                    => final_score_tree_103_c790,
                                                                           -0.0175347988);

final_score_tree_103 := map(
    NULL < rv_l80_inp_avm_autoval AND rv_l80_inp_avm_autoval < 65988.5 => final_score_tree_103_c787,
    rv_l80_inp_avm_autoval >= 65988.5                                  => final_score_tree_103_c789,
                                                                          0.0001492450);

final_score_tree_104_c792 := map(
    NULL < iv_num_inperson_sources AND iv_num_inperson_sources < 4.5 => -0.0064335451,
    iv_num_inperson_sources >= 4.5                                   => 0.0468520470,
                                                                        -0.0054360591);

final_score_tree_104_c793 := map(
    NULL < rv_a49_curr_add_avm_chg_2yr AND rv_a49_curr_add_avm_chg_2yr < 74040 => 0.0441586261,
    rv_a49_curr_add_avm_chg_2yr >= 74040                                       => -0.0014973354,
                                                                                  0.0125807341);

final_score_tree_104_c795 := map(
    NULL < rv_a49_curr_avm_chg_1yr_pct AND rv_a49_curr_avm_chg_1yr_pct < 45.2 => 0.1168309955,
    rv_a49_curr_avm_chg_1yr_pct >= 45.2                                       => -0.0080405423,
                                                                                 -0.0052268529);

final_score_tree_104_c794 := map(
    NULL < rv_a49_curr_add_avm_pct_chg_2yr AND rv_a49_curr_add_avm_pct_chg_2yr < 2.785 => final_score_tree_104_c795,
    rv_a49_curr_add_avm_pct_chg_2yr >= 2.785                                           => 0.1304399958,
                                                                                          -0.0007697703);

final_score_tree_104 := map(
    NULL < rv_a49_curr_add_avm_chg_3yr AND rv_a49_curr_add_avm_chg_3yr < 94324 => final_score_tree_104_c792,
    rv_a49_curr_add_avm_chg_3yr >= 94324                                       => final_score_tree_104_c793,
                                                                                  final_score_tree_104_c794);

final_score_tree_105_c798 := map(
    (iv_d34_liens_unrel_x_rel in ['0-0', '0-1', '0-2', '2-0', '2-1', '2-2', '3-1', '3-2']) => -0.0111368221,
    (iv_d34_liens_unrel_x_rel in ['1-0', '1-1', '1-2', '3-0'])                             => 0.0280809645,
                                                                                              -0.0091550334);

final_score_tree_105_c797 := map(
    NULL < rv_c13_max_lres AND rv_c13_max_lres < 248.5 => 0.0024473941,
    rv_c13_max_lres >= 248.5                           => final_score_tree_105_c798,
                                                          0.0017738117);

final_score_tree_105_c800 := map(
    NULL < iv_full_name_non_phn_src_ct AND iv_full_name_non_phn_src_ct < 4.5 => 0.0090769794,
    iv_full_name_non_phn_src_ct >= 4.5                                       => -0.0151058360,
                                                                                0.0053116874);

final_score_tree_105_c799 := map(
    NULL < rv_d31_attr_bankruptcy_recency AND rv_d31_attr_bankruptcy_recency < 79.5 => final_score_tree_105_c800,
    rv_d31_attr_bankruptcy_recency >= 79.5                                          => 0.0480809906,
                                                                                       -0.0122678295);

final_score_tree_105 := map(
    NULL < rv_l80_inp_avm_autoval AND rv_l80_inp_avm_autoval < 158089 => final_score_tree_105_c797,
    rv_l80_inp_avm_autoval >= 158089                                  => final_score_tree_105_c799,
                                                                         0.0010689066);

final_score_tree_106_c805 := map(
    NULL < rv_comb_age AND rv_comb_age < 57.5 => 0.0094862732,
    rv_comb_age >= 57.5                       => 0.0993519032,
                                                 0.0351621675);

final_score_tree_106_c804 := map(
    NULL < rv_c14_addrs_5yr AND rv_c14_addrs_5yr < 2.5 => final_score_tree_106_c805,
    rv_c14_addrs_5yr >= 2.5                            => 0.1355426794,
                                                          0.0504772705);

final_score_tree_106_c803 := map(
    (rv_6seg_riskview_5_0 in ['2 ADDR NOT CURRENT - DEROG', '3 ADDR NOT CURRENT - OTHER', '5 SUFFICIENTLY VERD - OWNER', '6 SUFFICIENTLY VERD - OTHER']) => 0.0132245236,
    (rv_6seg_riskview_5_0 in ['0 TRUEDID = 0', '1 VER/VAL PROBLEMS', '4 SUFFICIENTLY VERD - DEROG'])                                                     => final_score_tree_106_c804,
                                                                                                                                                            0.0179576476);

final_score_tree_106_c802 := map(
    NULL < rv_i62_inq_addrsperadl_recency AND rv_i62_inq_addrsperadl_recency < 9 => final_score_tree_106_c803,
    rv_i62_inq_addrsperadl_recency >= 9                                          => -0.0310633922,
                                                                                    0.0129498228);

final_score_tree_106 := map(
    NULL < iv_mos_src_voter_adl_lseen AND iv_mos_src_voter_adl_lseen < 41.5 => -0.0016021208,
    iv_mos_src_voter_adl_lseen >= 41.5                                      => final_score_tree_106_c802,
                                                                               -0.0006292544);

final_score_tree_107_c807 := map(
    NULL < rv_c13_attr_addrs_recency AND rv_c13_attr_addrs_recency < 7.5 => 0.0162634740,
    rv_c13_attr_addrs_recency >= 7.5                                     => -0.0015543870,
                                                                            -0.0030952938);

final_score_tree_107_c810 := map(
    NULL < rv_c13_inp_addr_lres AND rv_c13_inp_addr_lres < 2.5 => -0.0154447402,
    rv_c13_inp_addr_lres >= 2.5                                => 0.0238380112,
                                                                  0.0102624493);

final_score_tree_107_c809 := map(
    NULL < rv_comb_age AND rv_comb_age < 71.5 => final_score_tree_107_c810,
    rv_comb_age >= 71.5                       => -0.0261953609,
                                                 0.0029307397);

final_score_tree_107_c808 := map(
    NULL < iv_prv_addr_lres AND iv_prv_addr_lres < 373.5 => final_score_tree_107_c809,
    iv_prv_addr_lres >= 373.5                            => 0.0911092834,
                                                            0.0444334965);

final_score_tree_107 := map(
    (iv_l77_dwelltype in ['MFD', 'SFD']) => final_score_tree_107_c807,
    (iv_l77_dwelltype in ['POB', 'RR'])  => final_score_tree_107_c808,
                                            -0.0001847684);

final_score_tree_108_c814 := map(
    NULL < rv_comb_age AND rv_comb_age < 18.5 => 0.1109193789,
    rv_comb_age >= 18.5                       => -0.0151144610,
                                                 -0.0425049305);

final_score_tree_108_c813 := map(
    NULL < rv_c15_ssns_per_adl AND rv_c15_ssns_per_adl < 1.5 => final_score_tree_108_c814,
    rv_c15_ssns_per_adl >= 1.5                               => 0.0636775440,
                                                                -0.0110538414);

final_score_tree_108_c815 := map(
    (rv_d32_criminal_x_felony in ['1-0', '3-0', '3-3'])                             => -0.0523342732,
    (rv_d32_criminal_x_felony in ['0-0', '1-1', '2-0', '2-1', '2-2', '3-1', '3-2']) => -0.0059235343,
                                                                                       -0.0071798958);

final_score_tree_108_c812 := map(
    NULL < rv_a49_curr_avm_chg_1yr_pct AND rv_a49_curr_avm_chg_1yr_pct < 215.8 => final_score_tree_108_c813,
    rv_a49_curr_avm_chg_1yr_pct >= 215.8                                       => 0.0934325860,
                                                                                  final_score_tree_108_c815);

final_score_tree_108 := map(
    NULL < rv_c13_max_lres AND rv_c13_max_lres < 97.5 => final_score_tree_108_c812,
    rv_c13_max_lres >= 97.5                           => 0.0008569276,
                                                         -0.0021752255);

final_score_tree_109_c817 := map(
    NULL < rv_a44_curr_add_naprop AND rv_a44_curr_add_naprop < 0.5 => 0.0024488159,
    rv_a44_curr_add_naprop >= 0.5                                  => -0.0026478218,
                                                                      -0.0011729113);

final_score_tree_109_c819 := map(
    NULL < rv_l79_adls_per_addr_curr AND rv_l79_adls_per_addr_curr < 4.5 => -0.0130872508,
    rv_l79_adls_per_addr_curr >= 4.5                                     => 0.1124830148,
                                                                            0.0013588859);

final_score_tree_109_c820 := map(
    (iv_d34_liens_unrel_x_rel in ['0-1', '1-0', '2-0', '3-0'])                             => -0.0246773480,
    (iv_d34_liens_unrel_x_rel in ['0-0', '0-2', '1-1', '1-2', '2-1', '2-2', '3-1', '3-2']) => 0.0709078810,
                                                                                              0.0502577170);

final_score_tree_109_c818 := map(
    NULL < rv_c14_addrs_5yr AND rv_c14_addrs_5yr < 1.5 => final_score_tree_109_c819,
    rv_c14_addrs_5yr >= 1.5                            => final_score_tree_109_c820,
                                                          0.0267646561);

final_score_tree_109 := map(
    NULL < rv_i60_inq_banking_count12 AND rv_i60_inq_banking_count12 < 0.5 => final_score_tree_109_c817,
    rv_i60_inq_banking_count12 >= 0.5                                      => final_score_tree_109_c818,
                                                                              0.0032201043);

final_score_tree_110_c825 := map(
    (rv_6seg_riskview_5_0 in ['1 VER/VAL PROBLEMS', '3 ADDR NOT CURRENT - OTHER'])                                                                                         => 0.0002498856,
    (rv_6seg_riskview_5_0 in ['0 TRUEDID = 0', '2 ADDR NOT CURRENT - DEROG', '4 SUFFICIENTLY VERD - DEROG', '5 SUFFICIENTLY VERD - OWNER', '6 SUFFICIENTLY VERD - OTHER']) => 0.0439845101,
                                                                                                                                                                              0.0309549662);

final_score_tree_110_c824 := map(
    NULL < iv_bureau_emergence_age AND iv_bureau_emergence_age < 27.5 => 0.0091693825,
    iv_bureau_emergence_age >= 27.5                                   => final_score_tree_110_c825,
                                                                         0.0172001654);

final_score_tree_110_c823 := map(
    NULL < rv_comb_age AND rv_comb_age < 78.5 => final_score_tree_110_c824,
    rv_comb_age >= 78.5                       => -0.0427708606,
                                                 0.0128535639);

final_score_tree_110_c822 := map(
    NULL < iv_mos_src_voter_adl_lseen AND iv_mos_src_voter_adl_lseen < 57.5 => -0.0011800411,
    iv_mos_src_voter_adl_lseen >= 57.5                                      => final_score_tree_110_c823,
                                                                               0.0019907915);

final_score_tree_110 := map(
    NULL < rv_l80_inp_avm_autoval AND rv_l80_inp_avm_autoval < 342874 => final_score_tree_110_c822,
    rv_l80_inp_avm_autoval >= 342874                                  => -0.0093434938,
                                                                         -0.0007142062);

final_score_tree_111_c829 := map(
    NULL < iv_prv_addr_lres AND iv_prv_addr_lres < 3.5 => -0.0103192798,
    iv_prv_addr_lres >= 3.5                            => 0.0108744478,
                                                          -0.0487642287);

final_score_tree_111_c828 := map(
    NULL < rv_c22_inp_addr_occ_index AND rv_c22_inp_addr_occ_index < 3.5 => -0.0001999082,
    rv_c22_inp_addr_occ_index >= 3.5                                     => final_score_tree_111_c829,
                                                                            0.0008299659);

final_score_tree_111_c827 := map(
    NULL < rv_c13_curr_addr_lres AND rv_c13_curr_addr_lres < 571.5 => final_score_tree_111_c828,
    rv_c13_curr_addr_lres >= 571.5                                 => 0.0338004129,
                                                                      0.0009635532);

final_score_tree_111_c830 := map(
    NULL < iv_prv_addr_avm_auto_val AND iv_prv_addr_avm_auto_val < 167074.5 => 0.0153146985,
    iv_prv_addr_avm_auto_val >= 167074.5                                    => 0.1073680615,
                                                                               0.0337032163);

final_score_tree_111 := map(
    NULL < rv_c20_m_bureau_adl_fs AND rv_c20_m_bureau_adl_fs < 454.5 => final_score_tree_111_c827,
    rv_c20_m_bureau_adl_fs >= 454.5                                  => final_score_tree_111_c830,
                                                                        0.0086532551);

final_score_tree_112_c833 := map(
    NULL < rv_i62_inq_dobs_per_adl AND rv_i62_inq_dobs_per_adl < 0.5 => -0.0111048320,
    rv_i62_inq_dobs_per_adl >= 0.5                                   => -0.0460636924,
                                                                        -0.0174890477);

final_score_tree_112_c832 := map(
    NULL < rv_c13_inp_addr_lres AND rv_c13_inp_addr_lres < 0.5 => 0.0041357138,
    rv_c13_inp_addr_lres >= 0.5                                => final_score_tree_112_c833,
                                                                  0.0241605624);

final_score_tree_112_c835 := map(
    NULL < iv_full_name_non_phn_src_ct AND iv_full_name_non_phn_src_ct < 1.5 => 0.0212781573,
    iv_full_name_non_phn_src_ct >= 1.5                                       => 0.0027247509,
                                                                                0.0036895471);

final_score_tree_112_c834 := map(
    NULL < iv_input_best_name_match AND iv_input_best_name_match < 2.5 => -0.0090196725,
    iv_input_best_name_match >= 2.5                                    => final_score_tree_112_c835,
                                                                          0.0024716403);

final_score_tree_112 := map(
    NULL < rv_l79_adls_per_addr_curr AND rv_l79_adls_per_addr_curr < 0.5 => final_score_tree_112_c832,
    rv_l79_adls_per_addr_curr >= 0.5                                     => final_score_tree_112_c834,
                                                                            0.0006171330);

final_score_tree_113_c837 := map(
    NULL < rv_c12_num_nonderogs AND rv_c12_num_nonderogs < 3.5 => -0.0044372122,
    rv_c12_num_nonderogs >= 3.5                                => 0.1429583685,
                                                                  0.0306569737);

final_score_tree_113_c839 := map(
    NULL < rv_c13_curr_addr_lres AND rv_c13_curr_addr_lres < 463.5 => 0.0008421303,
    rv_c13_curr_addr_lres >= 463.5                                 => -0.0372967244,
                                                                      -0.0036715044);

final_score_tree_113_c840 := map(
    NULL < iv_addr_non_phn_src_ct AND iv_addr_non_phn_src_ct < 1.5 => -0.0197700501,
    iv_addr_non_phn_src_ct >= 1.5                                  => 0.0073451206,
                                                                      -0.0197627341);

final_score_tree_113_c838 := map(
    NULL < rv_l80_inp_avm_autoval AND rv_l80_inp_avm_autoval < 299520.5 => final_score_tree_113_c839,
    rv_l80_inp_avm_autoval >= 299520.5                                  => final_score_tree_113_c840,
                                                                           -0.0002550959);

final_score_tree_113 := map(
    NULL < iv_prop2_purch_sale_diff AND iv_prop2_purch_sale_diff < 145050 => -0.0391185311,
    iv_prop2_purch_sale_diff >= 145050                                    => final_score_tree_113_c837,
                                                                             final_score_tree_113_c838);

final_score_tree_114_c843 := map(
    NULL < iv_best_ssn_prior_dob AND iv_best_ssn_prior_dob < 0.5 => -0.0016558147,
    iv_best_ssn_prior_dob >= 0.5                                 => 0.0789975309,
                                                                    0.0080601415);

final_score_tree_114_c844 := map(
    NULL < rv_l79_adls_per_addr_curr AND rv_l79_adls_per_addr_curr < 1.5 => -0.0061896741,
    rv_l79_adls_per_addr_curr >= 1.5                                     => 0.0710859861,
                                                                            0.0330815630);

final_score_tree_114_c842 := map(
    NULL < iv_unverified_addr_count AND iv_unverified_addr_count < 15.5 => final_score_tree_114_c843,
    iv_unverified_addr_count >= 15.5                                    => final_score_tree_114_c844,
                                                                           -0.0052142725);

final_score_tree_114_c845 := map(
    NULL < rv_mos_since_br_first_seen AND rv_mos_since_br_first_seen < 72.5 => 0.0397109661,
    rv_mos_since_br_first_seen >= 72.5                                      => -0.0927267345,
                                                                               0.0246701063);

final_score_tree_114 := map(
    NULL < rv_l80_inp_avm_autoval AND rv_l80_inp_avm_autoval < 771328 => final_score_tree_114_c842,
    rv_l80_inp_avm_autoval >= 771328                                  => final_score_tree_114_c845,
                                                                         -0.0002226981);

final_score_tree_115_c848 := map(
    NULL < rv_c13_curr_addr_lres AND rv_c13_curr_addr_lres < 702.5 => 0.0003813048,
    rv_c13_curr_addr_lres >= 702.5                                 => -0.0831320942,
                                                                      0.0003160119);

final_score_tree_115_c847 := map(
    (rv_e58_br_dead_bus_x_active_phn in ['0-1', '1-2', '2-0', '2-3', '3-0', '3-1', '3-3'])               => -0.0218027233,
    (rv_e58_br_dead_bus_x_active_phn in ['0-0', '0-2', '0-3', '1-0', '1-1', '1-3', '2-1', '2-2', '3-2']) => final_score_tree_115_c848,
                                                                                                            -0.0121854496);

final_score_tree_115_c850 := map(
    NULL < rv_a49_curr_add_avm_chg_3yr AND rv_a49_curr_add_avm_chg_3yr < 58289 => 0.1458613800,
    rv_a49_curr_add_avm_chg_3yr >= 58289                                       => 0.0265353944,
                                                                                  0.0115777620);

final_score_tree_115_c849 := map(
    NULL < iv_c13_avg_lres AND iv_c13_avg_lres < 162.5 => 0.0009331950,
    iv_c13_avg_lres >= 162.5                           => final_score_tree_115_c850,
                                                          0.0122904303);

final_score_tree_115 := map(
    NULL < rv_l80_inp_avm_autoval AND rv_l80_inp_avm_autoval < 479126.5 => final_score_tree_115_c847,
    rv_l80_inp_avm_autoval >= 479126.5                                  => final_score_tree_115_c849,
                                                                           -0.0000213665);

final_score_tree_116_c854 := map(
    NULL < iv_src_voter_adl_count AND iv_src_voter_adl_count < -0.5 => 0.0058837820,
    iv_src_voter_adl_count >= -0.5                                  => 0.0770952910,
                                                                       0.0361667604);

final_score_tree_116_c855 := map(
    NULL < iv_c13_avg_lres AND iv_c13_avg_lres < 45 => 0.0589421410,
    iv_c13_avg_lres >= 45                           => -0.0729402383,
                                                       -0.0245833659);

final_score_tree_116_c853 := map(
    NULL < iv_full_name_non_phn_src_ct AND iv_full_name_non_phn_src_ct < 5.5 => final_score_tree_116_c854,
    iv_full_name_non_phn_src_ct >= 5.5                                       => final_score_tree_116_c855,
                                                                                0.0235833050);

final_score_tree_116_c852 := map(
    NULL < rv_d31_bk_dism_hist_count AND rv_d31_bk_dism_hist_count < 0.5 => -0.0016070886,
    rv_d31_bk_dism_hist_count >= 0.5                                     => final_score_tree_116_c853,
                                                                            0.0015684044);

final_score_tree_116 := map(
    NULL < rv_l80_inp_avm_autoval AND rv_l80_inp_avm_autoval < 1272880.5 => final_score_tree_116_c852,
    rv_l80_inp_avm_autoval >= 1272880.5                                  => 0.0504600482,
                                                                            -0.0011296527);

final_score_tree_117_c860 := map(
    NULL < iv_unverified_addr_count AND iv_unverified_addr_count < 5.5 => 0.0112867639,
    iv_unverified_addr_count >= 5.5                                    => 0.0592199696,
                                                                          0.0219524209);

final_score_tree_117_c859 := map(
    NULL < rv_i60_inq_recency AND rv_i60_inq_recency < 2 => 0.0003296356,
    rv_i60_inq_recency >= 2                              => final_score_tree_117_c860,
                                                            0.0016671633);

final_score_tree_117_c858 := map(
    (iv_d34_liens_unrel_x_rel in ['0-1', '0-2', '2-2', '3-2'])                             => -0.0809229661,
    (iv_d34_liens_unrel_x_rel in ['0-0', '1-0', '1-1', '1-2', '2-0', '2-1', '3-0', '3-1']) => final_score_tree_117_c859,
                                                                                              0.0011703475);

final_score_tree_117_c857 := map(
    NULL < rv_a49_curr_avm_chg_1yr_pct AND rv_a49_curr_avm_chg_1yr_pct < 124.15 => 0.0109582512,
    rv_a49_curr_avm_chg_1yr_pct >= 124.15                                       => -0.0134858106,
                                                                                   final_score_tree_117_c858);

final_score_tree_117 := map(
    NULL < iv_bureau_emergence_age AND iv_bureau_emergence_age < 28.5 => -0.0035524788,
    iv_bureau_emergence_age >= 28.5                                   => final_score_tree_117_c857,
                                                                         -0.0003905390);

final_score_tree_118_c864 := map(
    NULL < rv_c14_addrs_15yr AND rv_c14_addrs_15yr < 2.5 => 0.0091886696,
    rv_c14_addrs_15yr >= 2.5                             => 0.0408927602,
                                                            0.0229233518);

final_score_tree_118_c863 := map(
    NULL < rv_comb_age AND rv_comb_age < 53.5 => -0.0077114454,
    rv_comb_age >= 53.5                       => final_score_tree_118_c864,
                                                 0.0123283937);

final_score_tree_118_c862 := map(
    NULL < rv_c18_invalid_addrs_per_adl AND rv_c18_invalid_addrs_per_adl < 4.5 => -0.0008987934,
    rv_c18_invalid_addrs_per_adl >= 4.5                                        => final_score_tree_118_c863,
                                                                                  -0.0016854636);

final_score_tree_118_c865 := map(
    (rv_6seg_riskview_5_0 in ['0 TRUEDID = 0', '2 ADDR NOT CURRENT - DEROG', '4 SUFFICIENTLY VERD - DEROG', '6 SUFFICIENTLY VERD - OTHER']) => -0.0407036649,
    (rv_6seg_riskview_5_0 in ['1 VER/VAL PROBLEMS', '3 ADDR NOT CURRENT - OTHER', '5 SUFFICIENTLY VERD - OWNER'])                           => 0.0233387480,
                                                                                                                                               0.0115216118);

final_score_tree_118 := map(
    NULL < rv_l80_inp_avm_autoval AND rv_l80_inp_avm_autoval < 525044.5 => final_score_tree_118_c862,
    rv_l80_inp_avm_autoval >= 525044.5                                  => final_score_tree_118_c865,
                                                                           -0.0000593506);

final_score_tree_119_c868 := map(
    NULL < iv_estimated_income AND iv_estimated_income < 26500 => 0.0355963159,
    iv_estimated_income >= 26500                               => 0.0065067321,
                                                                  0.0157935240);

final_score_tree_119_c870 := map(
    NULL < rv_f03_input_add_not_most_rec AND rv_f03_input_add_not_most_rec < 0.5 => -0.0608440069,
    rv_f03_input_add_not_most_rec >= 0.5                                         => -0.0073483186,
                                                                                    -0.0151314168);

final_score_tree_119_c869 := map(
    NULL < rv_f03_address_match AND rv_f03_address_match < 3 => final_score_tree_119_c870,
    rv_f03_address_match >= 3                                => 0.0064311713,
                                                                0.0007577818);

final_score_tree_119_c867 := map(
    NULL < rv_c12_inp_addr_source_count AND rv_c12_inp_addr_source_count < 0.5 => final_score_tree_119_c868,
    rv_c12_inp_addr_source_count >= 0.5                                        => final_score_tree_119_c869,
                                                                                  0.0032576308);

final_score_tree_119 := map(
    NULL < iv_c14_addrs_per_adl AND iv_c14_addrs_per_adl < 4.5 => -0.0029223996,
    iv_c14_addrs_per_adl >= 4.5                                => final_score_tree_119_c867,
                                                                  -0.0008850152);

final_score_tree_120_c874 := map(
    NULL < iv_full_name_non_phn_src_ct AND iv_full_name_non_phn_src_ct < 2.5 => 0.0010214981,
    iv_full_name_non_phn_src_ct >= 2.5                                       => -0.0159437743,
                                                                                -0.0093176246);

final_score_tree_120_c873 := map(
    NULL < rv_c22_inp_addr_occ_index AND rv_c22_inp_addr_occ_index < 3.5 => final_score_tree_120_c874,
    rv_c22_inp_addr_occ_index >= 3.5                                     => 0.0043012987,
                                                                            -0.0067083164);

final_score_tree_120_c872 := map(
    (iv_curr_add_financing_type in ['CNV', 'NONE', 'OTH']) => final_score_tree_120_c873,
    (iv_curr_add_financing_type in ['ADJ'])                => 0.0896174748,
                                                              -0.0064850227);

final_score_tree_120_c875 := map(
    NULL < iv_estimated_income AND iv_estimated_income < 22500 => -0.0178362688,
    iv_estimated_income >= 22500                               => 0.0027712620,
                                                                  0.0015471780);

final_score_tree_120 := map(
    NULL < iv_c13_avg_lres AND iv_c13_avg_lres < 54.5 => final_score_tree_120_c872,
    iv_c13_avg_lres >= 54.5                           => final_score_tree_120_c875,
                                                         0.0034067685);

final_score_tree_121_c877 := map(
    NULL < rv_l79_adls_per_apt_addr_c6 AND rv_l79_adls_per_apt_addr_c6 < 1.5 => 0.0000831200,
    rv_l79_adls_per_apt_addr_c6 >= 1.5                                       => -0.0265676352,
                                                                                -0.0003437879);

final_score_tree_121_c880 := map(
    NULL < rv_d30_derog_count AND rv_d30_derog_count < 2.5 => -0.0202589439,
    rv_d30_derog_count >= 2.5                              => 0.0677074113,
                                                              -0.0134107754);

final_score_tree_121_c879 := map(
    NULL < rv_c13_curr_addr_lres AND rv_c13_curr_addr_lres < 18.5 => final_score_tree_121_c880,
    rv_c13_curr_addr_lres >= 18.5                                 => 0.0164309530,
                                                                     0.0082021708);

final_score_tree_121_c878 := map(
    NULL < rv_c12_source_profile AND rv_c12_source_profile < 89.45 => final_score_tree_121_c879,
    rv_c12_source_profile >= 89.45                                 => -0.1209744047,
                                                                      0.0065732102);

final_score_tree_121 := map(
    (iv_l77_dwelltype in ['MFD', 'SFD']) => final_score_tree_121_c877,
    (iv_l77_dwelltype in ['POB', 'RR'])  => final_score_tree_121_c878,
                                            0.0000366522);

final_score_tree_122_c883 := map(
    NULL < rv_c22_inp_addr_owned_not_occ AND rv_c22_inp_addr_owned_not_occ < 0.5 => 0.0192533437,
    rv_c22_inp_addr_owned_not_occ >= 0.5                                         => 0.1294072698,
                                                                                    0.0238030189);

final_score_tree_122_c882 := map(
    NULL < rv_c13_inp_addr_lres AND rv_c13_inp_addr_lres < 3.5 => final_score_tree_122_c883,
    rv_c13_inp_addr_lres >= 3.5                                => -0.0110452715,
                                                                  0.0130276139);

final_score_tree_122_c885 := map(
    NULL < iv_prv_addr_lres AND iv_prv_addr_lres < 8.5 => 0.0939020286,
    iv_prv_addr_lres >= 8.5                            => -0.0343108136,
                                                          -0.0187698631);

final_score_tree_122_c884 := map(
    NULL < iv_lname_non_phn_src_ct AND iv_lname_non_phn_src_ct < 6.5 => -0.0001905514,
    iv_lname_non_phn_src_ct >= 6.5                                   => final_score_tree_122_c885,
                                                                        -0.0003739044);

final_score_tree_122 := map(
    NULL < rv_c13_attr_addrs_recency AND rv_c13_attr_addrs_recency < 7.5 => final_score_tree_122_c882,
    rv_c13_attr_addrs_recency >= 7.5                                     => final_score_tree_122_c884,
                                                                            0.0066365544);

final_score_tree_123_c888 := map(
    NULL < rv_c14_addrs_15yr AND rv_c14_addrs_15yr < 1.5 => -0.0041242880,
    rv_c14_addrs_15yr >= 1.5                             => 0.0111936684,
                                                            0.0045139864);

final_score_tree_123_c887 := map(
    NULL < rv_c12_source_profile AND rv_c12_source_profile < 71.35 => -0.0039280364,
    rv_c12_source_profile >= 71.35                                 => final_score_tree_123_c888,
                                                                      -0.0182119753);

final_score_tree_123_c890 := map(
    NULL < iv_lname_non_phn_src_ct AND iv_lname_non_phn_src_ct < 1.5 => 0.0031620041,
    iv_lname_non_phn_src_ct >= 1.5                                   => -0.0048113403,
                                                                        -0.0042710871);

final_score_tree_123_c889 := map(
    NULL < rv_d32_mos_since_crim_ls AND rv_d32_mos_since_crim_ls < 37.5 => final_score_tree_123_c890,
    rv_d32_mos_since_crim_ls >= 37.5                                    => 0.0549366948,
                                                                           -0.0096059298);

final_score_tree_123 := map(
    NULL < rv_l80_inp_avm_autoval AND rv_l80_inp_avm_autoval < 44733 => final_score_tree_123_c887,
    rv_l80_inp_avm_autoval >= 44733                                  => final_score_tree_123_c889,
                                                                        -0.0013460437);

final_score_tree_124_c893 := map(
    NULL < iv_lname_non_phn_src_ct AND iv_lname_non_phn_src_ct < 5.5 => -0.0060695600,
    iv_lname_non_phn_src_ct >= 5.5                                   => 0.0071933316,
                                                                        -0.0054360600);

final_score_tree_124_c894 := map(
    NULL < rv_a49_curr_add_avm_pct_chg_2yr AND rv_a49_curr_add_avm_pct_chg_2yr < 1.495 => 0.0153722904,
    rv_a49_curr_add_avm_pct_chg_2yr >= 1.495                                           => 0.1205583004,
                                                                                          0.0271419300);

final_score_tree_124_c892 := map(
    NULL < iv_mos_src_voter_adl_lseen AND iv_mos_src_voter_adl_lseen < 62 => final_score_tree_124_c893,
    iv_mos_src_voter_adl_lseen >= 62                                      => final_score_tree_124_c894,
                                                                             -0.0037114858);

final_score_tree_124_c895 := map(
    NULL < rv_c10_m_hdr_fs AND rv_c10_m_hdr_fs < 252 => 0.1935931573,
    rv_c10_m_hdr_fs >= 252                           => 0.0077005338,
                                                        0.0569323702);

final_score_tree_124 := map(
    NULL < rv_a49_curr_add_avm_pct_chg_2yr AND rv_a49_curr_add_avm_pct_chg_2yr < 3.325 => final_score_tree_124_c892,
    rv_a49_curr_add_avm_pct_chg_2yr >= 3.325                                           => final_score_tree_124_c895,
                                                                                          0.0023282484);

final_score_tree_125_c899 := map(
    NULL < iv_prv_addr_lres AND iv_prv_addr_lres < 213.5 => 0.0103942968,
    iv_prv_addr_lres >= 213.5                            => -0.0195310664,
                                                            -0.0659738959);

final_score_tree_125_c898 := map(
    NULL < rv_c22_inp_addr_occ_index AND rv_c22_inp_addr_occ_index < 3.5 => -0.0120385987,
    rv_c22_inp_addr_occ_index >= 3.5                                     => final_score_tree_125_c899,
                                                                            -0.0071115239);

final_score_tree_125_c897 := map(
    NULL < rv_c22_inp_addr_occ_index AND rv_c22_inp_addr_occ_index < 2 => 0.0030385112,
    rv_c22_inp_addr_occ_index >= 2                                     => final_score_tree_125_c898,
                                                                          -0.0054555040);

final_score_tree_125_c900 := map(
    NULL < rv_l79_adls_per_addr_curr AND rv_l79_adls_per_addr_curr < 0.5 => -0.0164437409,
    rv_l79_adls_per_addr_curr >= 0.5                                     => 0.0196255181,
                                                                            0.0060271408);

final_score_tree_125 := map(
    (iv_l77_dwelltype in ['MFD', 'SFD']) => final_score_tree_125_c897,
    (iv_l77_dwelltype in ['POB', 'RR'])  => final_score_tree_125_c900,
                                            -0.0001037072);

final_score_tree_126_c903 := map(
    NULL < rv_c12_source_profile AND rv_c12_source_profile < 84.55 => -0.0185205415,
    rv_c12_source_profile >= 84.55                                 => 0.0491788595,
                                                                      -0.0133465044);

final_score_tree_126_c902 := map(
    NULL < iv_prop1_purch_sale_diff AND iv_prop1_purch_sale_diff < -73822.5 => 0.0431365561,
    iv_prop1_purch_sale_diff >= -73822.5                                    => final_score_tree_126_c903,
                                                                               -0.0004242355);

final_score_tree_126_c905 := map(
    NULL < iv_unverified_addr_count AND iv_unverified_addr_count < 8.5 => -0.0100418421,
    iv_unverified_addr_count >= 8.5                                    => 0.0920248688,
                                                                          0.0133516501);

final_score_tree_126_c904 := map(
    NULL < rv_a49_curr_avm_chg_1yr AND rv_a49_curr_avm_chg_1yr < 50102 => 0.0181313620,
    rv_a49_curr_avm_chg_1yr >= 50102                                   => -0.0122615131,
                                                                          final_score_tree_126_c905);

final_score_tree_126 := map(
    NULL < rv_l80_inp_avm_autoval AND rv_l80_inp_avm_autoval < 269114 => final_score_tree_126_c902,
    rv_l80_inp_avm_autoval >= 269114                                  => final_score_tree_126_c904,
                                                                         -0.0001140593);

final_score_tree_127_c907 := map(
    NULL < rv_a46_curr_avm_autoval AND rv_a46_curr_avm_autoval < 111476.5 => 0.1648104416,
    rv_a46_curr_avm_autoval >= 111476.5                                   => -0.0063022065,
                                                                             0.0751800069);

final_score_tree_127_c909 := map(
    NULL < rv_l70_inp_addr_dirty AND rv_l70_inp_addr_dirty < 0.5 => -0.0012338960,
    rv_l70_inp_addr_dirty >= 0.5                                 => -0.0676865268,
                                                                    -0.0013226981);

final_score_tree_127_c910 := map(
    NULL < rv_c13_max_lres AND rv_c13_max_lres < 48.5 => -0.0367987767,
    rv_c13_max_lres >= 48.5                           => 0.0666575312,
                                                         0.0431447339);

final_score_tree_127_c908 := map(
    NULL < iv_unverified_addr_count AND iv_unverified_addr_count < 15.5 => final_score_tree_127_c909,
    iv_unverified_addr_count >= 15.5                                    => final_score_tree_127_c910,
                                                                           -0.0082776959);

final_score_tree_127 := map(
    NULL < iv_prop1_purch_sale_diff AND iv_prop1_purch_sale_diff < -208600 => final_score_tree_127_c907,
    iv_prop1_purch_sale_diff >= -208600                                    => -0.0061266778,
                                                                              final_score_tree_127_c908);

final_score_tree_128_c915 := map(
    NULL < rv_l79_adls_per_sfd_addr AND rv_l79_adls_per_sfd_addr < -0.5 => 0.1682399939,
    rv_l79_adls_per_sfd_addr >= -0.5                                    => -0.0169828318,
                                                                           0.0723979504);

final_score_tree_128_c914 := map(
    NULL < rv_l70_add_standardized AND rv_l70_add_standardized < 0.5 => -0.0020568920,
    rv_l70_add_standardized >= 0.5                                   => final_score_tree_128_c915,
                                                                        -0.0016415098);

final_score_tree_128_c913 := map(
    NULL < rv_c13_curr_addr_lres AND rv_c13_curr_addr_lres < 130.5 => final_score_tree_128_c914,
    rv_c13_curr_addr_lres >= 130.5                                 => 0.0052301591,
                                                                      0.0004746415);

final_score_tree_128_c912 := map(
    NULL < iv_lname_non_phn_src_ct AND iv_lname_non_phn_src_ct < 5.5 => final_score_tree_128_c913,
    iv_lname_non_phn_src_ct >= 5.5                                   => -0.0242148469,
                                                                        -0.0095060572);

final_score_tree_128 := map(
    NULL < rv_l80_inp_avm_autoval AND rv_l80_inp_avm_autoval < 71864.5 => final_score_tree_128_c912,
    rv_l80_inp_avm_autoval >= 71864.5                                  => 0.0026116616,
                                                                          0.0004705615);

final_score_tree_129_c919 := map(
    NULL < rv_comb_age AND rv_comb_age < 59.5 => 0.0217597316,
    rv_comb_age >= 59.5                       => 0.1040149137,
                                                 0.0304717660);

final_score_tree_129_c918 := map(
    NULL < iv_c14_addrs_per_adl AND iv_c14_addrs_per_adl < 11.5 => -0.0010665499,
    iv_c14_addrs_per_adl >= 11.5                                => final_score_tree_129_c919,
                                                                   0.0003724080);

final_score_tree_129_c920 := map(
    NULL < rv_c10_m_hdr_fs AND rv_c10_m_hdr_fs < 362.5 => -0.0076650316,
    rv_c10_m_hdr_fs >= 362.5                           => 0.0039280528,
                                                          -0.0034393320);

final_score_tree_129_c917 := map(
    NULL < iv_lname_non_phn_src_ct AND iv_lname_non_phn_src_ct < 2.5 => final_score_tree_129_c918,
    iv_lname_non_phn_src_ct >= 2.5                                   => final_score_tree_129_c920,
                                                                        -0.0024894671);

final_score_tree_129 := map(
    NULL < iv_best_ssn_prior_dob AND iv_best_ssn_prior_dob < 0.5 => final_score_tree_129_c917,
    iv_best_ssn_prior_dob >= 0.5                                 => 0.0822587446,
                                                                    0.0079202699);

final_score_tree_130_c924 := map(
    NULL < rv_a49_curr_avm_chg_1yr_pct AND rv_a49_curr_avm_chg_1yr_pct < 113.95 => 0.0242871101,
    rv_a49_curr_avm_chg_1yr_pct >= 113.95                                       => -0.0148428182,
                                                                                   0.0048443321);

final_score_tree_130_c923 := map(
    NULL < iv_c14_addrs_per_adl AND iv_c14_addrs_per_adl < 8.5 => -0.0016880978,
    iv_c14_addrs_per_adl >= 8.5                                => final_score_tree_130_c924,
                                                                  -0.0003155440);

final_score_tree_130_c925 := map(
    NULL < rv_l79_adls_per_sfd_addr AND rv_l79_adls_per_sfd_addr < 4.5 => -0.0125082050,
    rv_l79_adls_per_sfd_addr >= 4.5                                    => 0.0970255488,
                                                                          -0.0049411063);

final_score_tree_130_c922 := map(
    NULL < rv_d32_criminal_behavior_lvl AND rv_d32_criminal_behavior_lvl < 5.5 => final_score_tree_130_c923,
    rv_d32_criminal_behavior_lvl >= 5.5                                        => -0.0988006228,
                                                                                  final_score_tree_130_c925);

final_score_tree_130 := map(
    NULL < rv_l80_inp_avm_autoval AND rv_l80_inp_avm_autoval < 861247.5 => final_score_tree_130_c922,
    rv_l80_inp_avm_autoval >= 861247.5                                  => -0.0252321405,
                                                                           -0.0006684215);

final_score_tree_131_c929 := map(
    NULL < rv_f01_inp_addr_address_score AND rv_f01_inp_addr_address_score < 16 => 0.1080488848,
    rv_f01_inp_addr_address_score >= 16                                         => 0.0016403001,
                                                                                   0.0019146167);

final_score_tree_131_c928 := map(
    NULL < rv_i62_inq_addrs_per_adl AND rv_i62_inq_addrs_per_adl < 1.5 => final_score_tree_131_c929,
    rv_i62_inq_addrs_per_adl >= 1.5                                    => 0.0478156982,
                                                                          0.0023589029);

final_score_tree_131_c930 := map(
    NULL < rv_a44_curr_add_naprop AND rv_a44_curr_add_naprop < 0.5 => 0.0038765610,
    rv_a44_curr_add_naprop >= 0.5                                  => -0.0094179136,
                                                                      -0.0047924236);

final_score_tree_131_c927 := map(
    NULL < rv_c22_inp_addr_occ_index AND rv_c22_inp_addr_occ_index < 2 => final_score_tree_131_c928,
    rv_c22_inp_addr_occ_index >= 2                                     => final_score_tree_131_c930,
                                                                          -0.0002972100);

final_score_tree_131 := map(
    NULL < rv_i60_inq_comm_count12 AND rv_i60_inq_comm_count12 < 2.5 => final_score_tree_131_c927,
    rv_i60_inq_comm_count12 >= 2.5                                   => 0.1517068952,
                                                                        -0.0071770506);

final_score_tree_132_c934 := map(
    NULL < rv_c13_curr_addr_lres AND rv_c13_curr_addr_lres < 112 => 0.1224631142,
    rv_c13_curr_addr_lres >= 112                                 => -0.0327754382,
                                                                    0.0505631531);

final_score_tree_132_c935 := map(
    NULL < rv_l78_no_phone_at_addr_vel AND rv_l78_no_phone_at_addr_vel < 0.5 => -0.0064590321,
    rv_l78_no_phone_at_addr_vel >= 0.5                                       => 0.0098726003,
                                                                                0.0013616568);

final_score_tree_132_c933 := map(
    NULL < rv_a46_curr_avm_autoval AND rv_a46_curr_avm_autoval < 10495.5 => final_score_tree_132_c934,
    rv_a46_curr_avm_autoval >= 10495.5                                   => final_score_tree_132_c935,
                                                                            0.0021042914);

final_score_tree_132_c932 := map(
    NULL < rv_l80_inp_avm_autoval AND rv_l80_inp_avm_autoval < 182557.5 => final_score_tree_132_c933,
    rv_l80_inp_avm_autoval >= 182557.5                                  => 0.0113049271,
                                                                           0.0053149547);

final_score_tree_132 := map(
    NULL < rv_a49_curr_add_avm_pct_chg_2yr AND rv_a49_curr_add_avm_pct_chg_2yr < 1.345 => final_score_tree_132_c932,
    rv_a49_curr_add_avm_pct_chg_2yr >= 1.345                                           => -0.0124427840,
                                                                                          -0.0004068895);

final_score_tree_133_c939 := map(
    NULL < rv_mos_since_br_first_seen AND rv_mos_since_br_first_seen < 157 => -0.0175235142,
    rv_mos_since_br_first_seen >= 157                                      => 0.1307178110,
                                                                              -0.0155253478);

final_score_tree_133_c938 := map(
    NULL < iv_c13_avg_lres AND iv_c13_avg_lres < 255.5 => 0.0004674811,
    iv_c13_avg_lres >= 255.5                           => final_score_tree_133_c939,
                                                          0.0052992504);

final_score_tree_133_c940 := map(
    NULL < iv_unverified_addr_count AND iv_unverified_addr_count < 6.5 => -0.0197682864,
    iv_unverified_addr_count >= 6.5                                    => -0.0942948831,
                                                                          -0.0275374683);

final_score_tree_133_c937 := map(
    NULL < iv_prv_addr_avm_auto_val AND iv_prv_addr_avm_auto_val < 629056 => final_score_tree_133_c938,
    iv_prv_addr_avm_auto_val >= 629056                                    => final_score_tree_133_c940,
                                                                             -0.0007226000);

final_score_tree_133 := map(
    NULL < rv_l80_inp_avm_autoval AND rv_l80_inp_avm_autoval < 1037425.5 => final_score_tree_133_c937,
    rv_l80_inp_avm_autoval >= 1037425.5                                  => 0.0304521421,
                                                                            -0.0006108303);

final_score_tree_134_c943 := map(
    NULL < iv_prv_addr_lres AND iv_prv_addr_lres < 387.5 => 0.0025950134,
    iv_prv_addr_lres >= 387.5                            => 0.0541322284,
                                                            0.0061584293);

final_score_tree_134_c942 := map(
    NULL < rv_a49_curr_avm_chg_1yr AND rv_a49_curr_avm_chg_1yr < -22436.5 => -0.0212032742,
    rv_a49_curr_avm_chg_1yr >= -22436.5                                   => final_score_tree_134_c943,
                                                                             0.0000033463);

final_score_tree_134_c945 := map(
    NULL < rv_c14_addrs_15yr AND rv_c14_addrs_15yr < 2.5 => 0.1637891533,
    rv_c14_addrs_15yr >= 2.5                             => 0.0116092893,
                                                            0.0617962657);

final_score_tree_134_c944 := map(
    NULL < rv_a49_curr_avm_chg_1yr_pct AND rv_a49_curr_avm_chg_1yr_pct < 81.85 => final_score_tree_134_c945,
    rv_a49_curr_avm_chg_1yr_pct >= 81.85                                       => -0.0208081704,
                                                                                  -0.0102722566);

final_score_tree_134 := map(
    NULL < rv_i60_inq_auto_recency AND rv_i60_inq_auto_recency < 4.5 => final_score_tree_134_c942,
    rv_i60_inq_auto_recency >= 4.5                                   => final_score_tree_134_c944,
                                                                        0.0129442242);

final_score_tree_135_c950 := map(
    NULL < rv_comb_age AND rv_comb_age < 49.5 => 0.0110148733,
    rv_comb_age >= 49.5                       => 0.0334323449,
                                                 0.0211645160);

final_score_tree_135_c949 := map(
    NULL < iv_wealth_index AND iv_wealth_index < 2.5 => final_score_tree_135_c950,
    iv_wealth_index >= 2.5                           => -0.0013628080,
                                                        0.0131113383);

final_score_tree_135_c948 := map(
    NULL < iv_c14_addrs_per_adl AND iv_c14_addrs_per_adl < 6.5 => 0.0002608541,
    iv_c14_addrs_per_adl >= 6.5                                => final_score_tree_135_c949,
                                                                  0.0025864896);

final_score_tree_135_c947 := map(
    NULL < rv_c13_max_lres AND rv_c13_max_lres < 114.5 => -0.0054196850,
    rv_c13_max_lres >= 114.5                           => final_score_tree_135_c948,
                                                          0.0059251257);

final_score_tree_135 := map(
    NULL < rv_l80_inp_avm_autoval AND rv_l80_inp_avm_autoval < 334931 => final_score_tree_135_c947,
    rv_l80_inp_avm_autoval >= 334931                                  => 0.0077161536,
                                                                         0.0004833093);

final_score_tree_136_c954 := map(
    NULL < rv_comb_age AND rv_comb_age < 90.5 => 0.0006052184,
    rv_comb_age >= 90.5                       => -0.0420634376,
                                                 -0.0105818059);

final_score_tree_136_c953 := map(
    (rv_e58_br_dead_bus_x_active_phn in ['0-1', '1-0', '1-3', '2-2', '3-0', '3-3'])                             => -0.0180965296,
    (rv_e58_br_dead_bus_x_active_phn in ['0-0', '0-2', '0-3', '1-1', '1-2', '2-0', '2-1', '2-3', '3-1', '3-2']) => final_score_tree_136_c954,
                                                                                                                   -0.0006972402);

final_score_tree_136_c955 := map(
    NULL < iv_estimated_income AND iv_estimated_income < 25500 => -0.0712150894,
    iv_estimated_income >= 25500                               => -0.0096541146,
                                                                  -0.0284036501);

final_score_tree_136_c952 := map(
    NULL < rv_i62_inq_num_names_per_adl AND rv_i62_inq_num_names_per_adl < 2.5 => final_score_tree_136_c953,
    rv_i62_inq_num_names_per_adl >= 2.5                                        => final_score_tree_136_c955,
                                                                                  -0.0010815259);

final_score_tree_136 := map(
    NULL < iv_fname_non_phn_src_ct AND iv_fname_non_phn_src_ct < 0.5 => -0.0597995236,
    iv_fname_non_phn_src_ct >= 0.5                                   => final_score_tree_136_c952,
                                                                        0.0069112208);

final_score_tree_137_c957 := map(
    NULL < rv_i62_inq_num_names_per_adl AND rv_i62_inq_num_names_per_adl < 2.5 => 0.0001301623,
    rv_i62_inq_num_names_per_adl >= 2.5                                        => -0.0267414293,
                                                                                  -0.0082786672);

final_score_tree_137_c960 := map(
    NULL < rv_l79_adls_per_addr_curr AND rv_l79_adls_per_addr_curr < 4.5 => -0.0251107444,
    rv_l79_adls_per_addr_curr >= 4.5                                     => 0.0688986712,
                                                                            -0.0181315464);

final_score_tree_137_c959 := map(
    NULL < iv_lname_non_phn_src_ct AND iv_lname_non_phn_src_ct < 4.5 => 0.0079643252,
    iv_lname_non_phn_src_ct >= 4.5                                   => final_score_tree_137_c960,
                                                                        0.0035746484);

final_score_tree_137_c958 := map(
    NULL < rv_c18_invalid_addrs_per_adl AND rv_c18_invalid_addrs_per_adl < 9.5 => final_score_tree_137_c959,
    rv_c18_invalid_addrs_per_adl >= 9.5                                        => 0.1147224167,
                                                                                  -0.0094877793);

final_score_tree_137 := map(
    NULL < rv_l80_inp_avm_autoval AND rv_l80_inp_avm_autoval < 158000.5 => final_score_tree_137_c957,
    rv_l80_inp_avm_autoval >= 158000.5                                  => final_score_tree_137_c958,
                                                                           0.0004558153);

final_score_tree_138_c964 := map(
    (rv_4seg_riskview_5_0 in ['2 DEROG', '3 OWNER'])                             => -0.0415555401,
    (rv_4seg_riskview_5_0 in ['0 TRUEDID = 0', '1 VER/VAL PROBLEMS', '4 OTHER']) => 0.0335474172,
                                                                                    -0.0017335069);

final_score_tree_138_c965 := map(
    NULL < iv_c13_avg_lres AND iv_c13_avg_lres < 42.5 => -0.1260666382,
    iv_c13_avg_lres >= 42.5                           => -0.0401189505,
                                                         -0.0628698090);

final_score_tree_138_c963 := map(
    NULL < rv_c20_m_bureau_adl_fs AND rv_c20_m_bureau_adl_fs < 342.5 => final_score_tree_138_c964,
    rv_c20_m_bureau_adl_fs >= 342.5                                  => final_score_tree_138_c965,
                                                                        -0.0214051246);

final_score_tree_138_c962 := map(
    NULL < rv_c22_inp_addr_occ_index AND rv_c22_inp_addr_occ_index < 6.5 => 0.0003988990,
    rv_c22_inp_addr_occ_index >= 6.5                                     => final_score_tree_138_c963,
                                                                            0.0002047997);

final_score_tree_138 := map(
    NULL < rv_c14_addrs_5yr AND rv_c14_addrs_5yr < 5.5 => final_score_tree_138_c962,
    rv_c14_addrs_5yr >= 5.5                            => -0.0445517672,
                                                          -0.0003340779);

final_score_tree_139_c969 := map(
    NULL < rv_l80_inp_avm_autoval AND rv_l80_inp_avm_autoval < 110589.5 => 0.1042613357,
    rv_l80_inp_avm_autoval >= 110589.5                                  => -0.0184389913,
                                                                           0.0538178680);

final_score_tree_139_c968 := map(
    NULL < rv_l79_adls_per_sfd_addr AND rv_l79_adls_per_sfd_addr < 3.5 => -0.0219552695,
    rv_l79_adls_per_sfd_addr >= 3.5                                    => final_score_tree_139_c969,
                                                                          -0.0099171718);

final_score_tree_139_c967 := map(
    NULL < iv_d34_released_liens_ct AND iv_d34_released_liens_ct < 3.5 => 0.0009451027,
    iv_d34_released_liens_ct >= 3.5                                    => 0.0721945613,
                                                                          final_score_tree_139_c968);

final_score_tree_139_c970 := map(
    NULL < rv_mos_since_br_first_seen AND rv_mos_since_br_first_seen < 134.5 => 0.0209420474,
    rv_mos_since_br_first_seen >= 134.5                                      => -0.0891345548,
                                                                                0.0153565836);

final_score_tree_139 := map(
    NULL < rv_l80_inp_avm_autoval AND rv_l80_inp_avm_autoval < 598162.5 => final_score_tree_139_c967,
    rv_l80_inp_avm_autoval >= 598162.5                                  => final_score_tree_139_c970,
                                                                           0.0011289566);

final_score_gbm_logit := final_score_tree_0 +
    final_score_tree_1 +
    final_score_tree_2 +
    final_score_tree_3 +
    final_score_tree_4 +
    final_score_tree_5 +
    final_score_tree_6 +
    final_score_tree_7 +
    final_score_tree_8 +
    final_score_tree_9 +
    final_score_tree_10 +
    final_score_tree_11 +
    final_score_tree_12 +
    final_score_tree_13 +
    final_score_tree_14 +
    final_score_tree_15 +
    final_score_tree_16 +
    final_score_tree_17 +
    final_score_tree_18 +
    final_score_tree_19 +
    final_score_tree_20 +
    final_score_tree_21 +
    final_score_tree_22 +
    final_score_tree_23 +
    final_score_tree_24 +
    final_score_tree_25 +
    final_score_tree_26 +
    final_score_tree_27 +
    final_score_tree_28 +
    final_score_tree_29 +
    final_score_tree_30 +
    final_score_tree_31 +
    final_score_tree_32 +
    final_score_tree_33 +
    final_score_tree_34 +
    final_score_tree_35 +
    final_score_tree_36 +
    final_score_tree_37 +
    final_score_tree_38 +
    final_score_tree_39 +
    final_score_tree_40 +
    final_score_tree_41 +
    final_score_tree_42 +
    final_score_tree_43 +
    final_score_tree_44 +
    final_score_tree_45 +
    final_score_tree_46 +
    final_score_tree_47 +
    final_score_tree_48 +
    final_score_tree_49 +
    final_score_tree_50 +
    final_score_tree_51 +
    final_score_tree_52 +
    final_score_tree_53 +
    final_score_tree_54 +
    final_score_tree_55 +
    final_score_tree_56 +
    final_score_tree_57 +
    final_score_tree_58 +
    final_score_tree_59 +
    final_score_tree_60 +
    final_score_tree_61 +
    final_score_tree_62 +
    final_score_tree_63 +
    final_score_tree_64 +
    final_score_tree_65 +
    final_score_tree_66 +
    final_score_tree_67 +
    final_score_tree_68 +
    final_score_tree_69 +
    final_score_tree_70 +
    final_score_tree_71 +
    final_score_tree_72 +
    final_score_tree_73 +
    final_score_tree_74 +
    final_score_tree_75 +
    final_score_tree_76 +
    final_score_tree_77 +
    final_score_tree_78 +
    final_score_tree_79 +
    final_score_tree_80 +
    final_score_tree_81 +
    final_score_tree_82 +
    final_score_tree_83 +
    final_score_tree_84 +
    final_score_tree_85 +
    final_score_tree_86 +
    final_score_tree_87 +
    final_score_tree_88 +
    final_score_tree_89 +
    final_score_tree_90 +
    final_score_tree_91 +
    final_score_tree_92 +
    final_score_tree_93 +
    final_score_tree_94 +
    final_score_tree_95 +
    final_score_tree_96 +
    final_score_tree_97 +
    final_score_tree_98 +
    final_score_tree_99 +
    final_score_tree_100 +
    final_score_tree_101 +
    final_score_tree_102 +
    final_score_tree_103 +
    final_score_tree_104 +
    final_score_tree_105 +
    final_score_tree_106 +
    final_score_tree_107 +
    final_score_tree_108 +
    final_score_tree_109 +
    final_score_tree_110 +
    final_score_tree_111 +
    final_score_tree_112 +
    final_score_tree_113 +
    final_score_tree_114 +
    final_score_tree_115 +
    final_score_tree_116 +
    final_score_tree_117 +
    final_score_tree_118 +
    final_score_tree_119 +
    final_score_tree_120 +
    final_score_tree_121 +
    final_score_tree_122 +
    final_score_tree_123 +
    final_score_tree_124 +
    final_score_tree_125 +
    final_score_tree_126 +
    final_score_tree_127 +
    final_score_tree_128 +
    final_score_tree_129 +
    final_score_tree_130 +
    final_score_tree_131 +
    final_score_tree_132 +
    final_score_tree_133 +
    final_score_tree_134 +
    final_score_tree_135 +
    final_score_tree_136 +
    final_score_tree_137 +
    final_score_tree_138 +
    final_score_tree_139;

deceased := map(
    rc_decsflag = '1'                                                        => 1,
    rc_ssndod != 0                                                         => 1,
    contains_i(ver_sources, 'DE') > 0 or contains_i(ver_sources, 'DS') > 0 => 2,
                                                                              0);

base := 700;

pts := -50;

lgt := ln(0.1615192 / (1 - 0.1615192));

rvp1702_1_0 := map(
    deceased > 0          => 200,
    iv_rv5_unscorable = '1' => 222,
                             round(max((real)501, min(900, if(base + pts * (final_score_gbm_logit - lgt) / ln(2) = NULL, -NULL, base + pts * (final_score_gbm_logit - lgt) / ln(2))))));




	
	#if(MODEL_DEBUG)
		/* Model Input Variables */
		SELF.seq := le.seq;
		SELF.truedid := truedid;
		                    self.ver_src_ak_pos                   := ver_src_ak_pos;
                    self.ver_src_ak                       := ver_src_ak;
                    self._ver_src_fdate_ak                := _ver_src_fdate_ak;
                    self.ver_src_fdate_ak                 := ver_src_fdate_ak;
                    self.ver_src_am_pos                   := ver_src_am_pos;
                    self.ver_src_am                       := ver_src_am;
                    self._ver_src_fdate_am                := _ver_src_fdate_am;
                    self.ver_src_fdate_am                 := ver_src_fdate_am;
                    self.ver_src_ar_pos                   := ver_src_ar_pos;
                    self.ver_src_ar                       := ver_src_ar;
                    self._ver_src_fdate_ar                := _ver_src_fdate_ar;
                    self.ver_src_fdate_ar                 := ver_src_fdate_ar;
                    self.ver_src_ba_pos                   := ver_src_ba_pos;
                    self.ver_src_ba                       := ver_src_ba;
                    self._ver_src_fdate_ba                := _ver_src_fdate_ba;
                    self.ver_src_fdate_ba                 := ver_src_fdate_ba;
                    self.ver_src_cg_pos                   := ver_src_cg_pos;
                    self.ver_src_cg                       := ver_src_cg;
                    self._ver_src_fdate_cg                := _ver_src_fdate_cg;
                    self.ver_src_fdate_cg                 := ver_src_fdate_cg;
                    self.ver_src_co_pos                   := ver_src_co_pos;
                    self._ver_src_fdate_co                := _ver_src_fdate_co;
                    self.ver_src_fdate_co                 := ver_src_fdate_co;
                    self.ver_src_cy_pos                   := ver_src_cy_pos;
                    self.ver_src_cy                       := ver_src_cy;
                    self._ver_src_fdate_cy                := _ver_src_fdate_cy;
                    self.ver_src_fdate_cy                 := ver_src_fdate_cy;
                    self.ver_src_da_pos                   := ver_src_da_pos;
                    self.ver_src_da                       := ver_src_da;
                    self._ver_src_fdate_da                := _ver_src_fdate_da;
                    self.ver_src_fdate_da                 := ver_src_fdate_da;
                    self.ver_src_d_pos                    := ver_src_d_pos;
                    self.ver_src_d                        := ver_src_d;
                    self._ver_src_fdate_d                 := _ver_src_fdate_d;
                    self.ver_src_fdate_d                  := ver_src_fdate_d;
                    self.ver_src_dl_pos                   := ver_src_dl_pos;
                    self.ver_src_dl                       := ver_src_dl;
                    self._ver_src_fdate_dl                := _ver_src_fdate_dl;
                    self.ver_src_fdate_dl                 := ver_src_fdate_dl;
                    self.ver_src_ds_pos                   := ver_src_ds_pos;
                    self.ver_src_ds                       := ver_src_ds;
                    self._ver_src_fdate_ds                := _ver_src_fdate_ds;
                    self.ver_src_fdate_ds                 := ver_src_fdate_ds;
                    self.ver_src_de_pos                   := ver_src_de_pos;
                    self.ver_src_de                       := ver_src_de;
                    self._ver_src_fdate_de                := _ver_src_fdate_de;
                    self.ver_src_fdate_de                 := ver_src_fdate_de;
                    self.ver_src_eb_pos                   := ver_src_eb_pos;
                    self.ver_src_eb                       := ver_src_eb;
                    self._ver_src_fdate_eb                := _ver_src_fdate_eb;
                    self.ver_src_fdate_eb                 := ver_src_fdate_eb;
                    self.ver_src_em_pos                   := ver_src_em_pos;
                    self.ver_src_em                       := ver_src_em;
                    self._ver_src_fdate_em                := _ver_src_fdate_em;
                    self.ver_src_fdate_em                 := ver_src_fdate_em;
                    self.ver_src_e1_pos                   := ver_src_e1_pos;
                    self.ver_src_e1                       := ver_src_e1;
                    self._ver_src_fdate_e1                := _ver_src_fdate_e1;
                    self.ver_src_fdate_e1                 := ver_src_fdate_e1;
                    self.ver_src_e2_pos                   := ver_src_e2_pos;
                    self.ver_src_e2                       := ver_src_e2;
                    self._ver_src_fdate_e2                := _ver_src_fdate_e2;
                    self.ver_src_fdate_e2                 := ver_src_fdate_e2;
                    self.ver_src_e3_pos                   := ver_src_e3_pos;
                    self.ver_src_e3                       := ver_src_e3;
                    self._ver_src_fdate_e3                := _ver_src_fdate_e3;
                    self.ver_src_fdate_e3                 := ver_src_fdate_e3;
                    self.ver_src_e4_pos                   := ver_src_e4_pos;
                    self.ver_src_e4                       := ver_src_e4;
                    self._ver_src_fdate_e4                := _ver_src_fdate_e4;
                    self.ver_src_fdate_e4                 := ver_src_fdate_e4;
                    self.ver_src_en_pos                   := ver_src_en_pos;
                    self._ver_src_fdate_en                := _ver_src_fdate_en;
                    self.ver_src_fdate_en                 := ver_src_fdate_en;
                    self.ver_src_eq_pos                   := ver_src_eq_pos;
                    self._ver_src_fdate_eq                := _ver_src_fdate_eq;
                    self.ver_src_fdate_eq                 := ver_src_fdate_eq;
                    self.ver_src_fe_pos                   := ver_src_fe_pos;
                    self.ver_src_fe                       := ver_src_fe;
                    self._ver_src_fdate_fe                := _ver_src_fdate_fe;
                    self.ver_src_fdate_fe                 := ver_src_fdate_fe;
                    self.ver_src_ff_pos                   := ver_src_ff_pos;
                    self.ver_src_ff                       := ver_src_ff;
                    self._ver_src_fdate_ff                := _ver_src_fdate_ff;
                    self.ver_src_fdate_ff                 := ver_src_fdate_ff;
                    self.ver_src_fr_pos                   := ver_src_fr_pos;
                    self.ver_src_fr                       := ver_src_fr;
                    self._ver_src_fdate_fr                := _ver_src_fdate_fr;
                    self.ver_src_fdate_fr                 := ver_src_fdate_fr;
                    self.ver_src_l2_pos                   := ver_src_l2_pos;
                    self.ver_src_l2                       := ver_src_l2;
                    self._ver_src_fdate_l2                := _ver_src_fdate_l2;
                    self.ver_src_fdate_l2                 := ver_src_fdate_l2;
                    self.ver_src_li_pos                   := ver_src_li_pos;
                    self.ver_src_li                       := ver_src_li;
                    self._ver_src_fdate_li                := _ver_src_fdate_li;
                    self.ver_src_fdate_li                 := ver_src_fdate_li;
                    self.ver_src_mw_pos                   := ver_src_mw_pos;
                    self.ver_src_mw                       := ver_src_mw;
                    self._ver_src_fdate_mw                := _ver_src_fdate_mw;
                    self.ver_src_fdate_mw                 := ver_src_fdate_mw;
                    self.ver_src_nt_pos                   := ver_src_nt_pos;
                    self.ver_src_nt                       := ver_src_nt;
                    self._ver_src_fdate_nt                := _ver_src_fdate_nt;
                    self.ver_src_fdate_nt                 := ver_src_fdate_nt;
                    self.ver_src_p_pos                    := ver_src_p_pos;
                    self.ver_src_p                        := ver_src_p;
                    self._ver_src_fdate_p                 := _ver_src_fdate_p;
                    self.ver_src_fdate_p                  := ver_src_fdate_p;
                    self.ver_src_pl_pos                   := ver_src_pl_pos;
                    self.ver_src_pl                       := ver_src_pl;
                    self._ver_src_fdate_pl                := _ver_src_fdate_pl;
                    self.ver_src_fdate_pl                 := ver_src_fdate_pl;
                    self.ver_src_tn_pos                   := ver_src_tn_pos;
                    self._ver_src_fdate_tn                := _ver_src_fdate_tn;
                    self.ver_src_fdate_tn                 := ver_src_fdate_tn;
                    self.ver_src_ts_pos                   := ver_src_ts_pos;
                    self._ver_src_fdate_ts                := _ver_src_fdate_ts;
                    self.ver_src_fdate_ts                 := ver_src_fdate_ts;
                    self.ver_src_tu_pos                   := ver_src_tu_pos;
                    self._ver_src_fdate_tu                := _ver_src_fdate_tu;
                    self.ver_src_fdate_tu                 := ver_src_fdate_tu;
                    self.ver_src_sl_pos                   := ver_src_sl_pos;
                    self.ver_src_sl                       := ver_src_sl;
                    self._ver_src_fdate_sl                := _ver_src_fdate_sl;
                    self.ver_src_fdate_sl                 := ver_src_fdate_sl;
                    self.ver_src_v_pos                    := ver_src_v_pos;
                    self.ver_src_v                        := ver_src_v;
                    self._ver_src_fdate_v                 := _ver_src_fdate_v;
                    self.ver_src_fdate_v                  := ver_src_fdate_v;
                    self.ver_src_vo_pos                   := ver_src_vo_pos;
                    self.ver_src_vo                       := ver_src_vo;
                    self._ver_src_fdate_vo                := _ver_src_fdate_vo;
                    self.ver_src_fdate_vo                 := ver_src_fdate_vo;
                    self.ver_src_w_pos                    := ver_src_w_pos;
                    self.ver_src_w                        := ver_src_w;
                    self._ver_src_fdate_w                 := _ver_src_fdate_w;
                    self.ver_src_fdate_w                  := ver_src_fdate_w;
                    self.ver_src_wp_pos                   := ver_src_wp_pos;
                    self.ver_src_wp                       := ver_src_wp;
                    self._ver_src_fdate_wp                := _ver_src_fdate_wp;
                    self.ver_src_fdate_wp                 := ver_src_fdate_wp;
                    self.ver_lname_src_en_pos             := ver_lname_src_en_pos;
                    self.ver_lname_src_en                 := ver_lname_src_en;
                    self.ver_lname_src_eq_pos             := ver_lname_src_eq_pos;
                    self.ver_lname_src_eq                 := ver_lname_src_eq;
                    self.ver_lname_src_tn_pos             := ver_lname_src_tn_pos;
                    self.ver_lname_src_tn                 := ver_lname_src_tn;
                    self.ver_lname_src_ts_pos             := ver_lname_src_ts_pos;
                    self.ver_lname_src_ts                 := ver_lname_src_ts;
                    self.ver_lname_src_tu_pos             := ver_lname_src_tu_pos;
                    self.ver_lname_src_tu                 := ver_lname_src_tu;
                    self.sysdate                          := sysdate;
                    self.iv_add_apt                       := iv_add_apt;
                    self.rv_l70_inp_addr_dirty            := rv_l70_inp_addr_dirty;
                    self.add_ec3                          := add_ec3;
                    self.add_ec4                          := add_ec4;
                    self.rv_l70_add_standardized          := rv_l70_add_standardized;
                    self.iv_l77_dwelltype                 := iv_l77_dwelltype;
                    self.rv_f03_input_add_not_most_rec    := rv_f03_input_add_not_most_rec;
                    self.rv_d30_derog_count               := rv_d30_derog_count;
                    self.rv_d32_criminal_behavior_lvl     := rv_d32_criminal_behavior_lvl;
                    self.rv_d32_criminal_x_felony         := rv_d32_criminal_x_felony;
                    self._criminal_last_date              := _criminal_last_date;
                    self.rv_d32_mos_since_crim_ls         := rv_d32_mos_since_crim_ls;
                    self._felony_last_date                := _felony_last_date;
                    self.rv_d32_mos_since_fel_ls          := rv_d32_mos_since_fel_ls;
                    self.rv_d31_bk_index_lvl              := rv_d31_bk_index_lvl;
                    self.rv_d31_bk_chapter                := rv_d31_bk_chapter;
                    self.rv_d31_attr_bankruptcy_recency   := rv_d31_attr_bankruptcy_recency;
                    self.rv_d31_bk_disposed_recent_count  := rv_d31_bk_disposed_recent_count;
                    self.rv_d31_bk_disposed_hist_count    := rv_d31_bk_disposed_hist_count;
                    self.rv_d31_bk_dism_hist_count        := rv_d31_bk_dism_hist_count;
                    self.rv_d34_unrel_lien60_count        := rv_d34_unrel_lien60_count;
                    self.iv_d34_liens_unrel_x_rel         := iv_d34_liens_unrel_x_rel;
                    self.rv_c20_m_bureau_adl_fs           := rv_c20_m_bureau_adl_fs;
                    self._header_first_seen               := _header_first_seen;
                    self.rv_c10_m_hdr_fs                  := rv_c10_m_hdr_fs;
                    self.rv_c12_num_nonderogs             := rv_c12_num_nonderogs;
                    self.rv_c12_source_profile            := rv_c12_source_profile;
                    self.rv_c15_ssns_per_adl              := rv_c15_ssns_per_adl;
                    self.rv_s66_adlperssn_count           := rv_s66_adlperssn_count;
                    self.yr_in_dob                        := yr_in_dob;
                    self.yr_in_dob_int                    := yr_in_dob_int;
                    self.rv_comb_age                      := rv_comb_age;
                    self.rv_f03_address_match             := rv_f03_address_match;
                    self.rv_a44_curr_add_naprop           := rv_a44_curr_add_naprop;
                    self.rv_l80_inp_avm_autoval           := rv_l80_inp_avm_autoval;
                    self.rv_a46_curr_avm_autoval          := rv_a46_curr_avm_autoval;
                    self.rv_a49_curr_avm_chg_1yr          := rv_a49_curr_avm_chg_1yr;
                    self.rv_a49_curr_avm_chg_1yr_pct      := rv_a49_curr_avm_chg_1yr_pct;
                    self.rv_c13_curr_addr_lres            := rv_c13_curr_addr_lres;
                    self.rv_c13_max_lres                  := rv_c13_max_lres;
                    self.rv_c14_addrs_5yr                 := rv_c14_addrs_5yr;
                    self.rv_c14_addrs_10yr                := rv_c14_addrs_10yr;
                    self.rv_c14_addrs_15yr                := rv_c14_addrs_15yr;
                    self.rv_c22_inp_addr_occ_index        := rv_c22_inp_addr_occ_index;
                    self.rv_c22_inp_addr_owned_not_occ    := rv_c22_inp_addr_owned_not_occ;
                    self.rv_f04_curr_add_occ_index        := rv_f04_curr_add_occ_index;
                    self.rv_a41_prop_owner                := rv_a41_prop_owner;
                    self.rv_a41_a42_prop_owner_history    := rv_a41_a42_prop_owner_history;
                    self.rv_ever_asset_owner              := rv_ever_asset_owner;
                    self.rv_e55_college_ind               := rv_e55_college_ind;
                    self.rv_e57_prof_license_br_flag      := rv_e57_prof_license_br_flag;
                    self.rv_i60_inq_count12               := rv_i60_inq_count12;
                    self.rv_i60_credit_seeking            := rv_i60_credit_seeking;
                    self.rv_i60_inq_recency               := rv_i60_inq_recency;
                    self.rv_i60_inq_auto_recency          := rv_i60_inq_auto_recency;
                    self.rv_i60_inq_banking_count12       := rv_i60_inq_banking_count12;
                    self.rv_i60_inq_banking_recency       := rv_i60_inq_banking_recency;
                    self.rv_i60_inq_hiriskcred_count12    := rv_i60_inq_hiriskcred_count12;
                    self.rv_i60_inq_comm_count12          := rv_i60_inq_comm_count12;
                    self.rv_i60_inq_other_count12         := rv_i60_inq_other_count12;
                    self.rv_i62_inq_ssns_per_adl          := rv_i62_inq_ssns_per_adl;
                    self.rv_i62_inq_addrs_per_adl         := rv_i62_inq_addrs_per_adl;
                    self.rv_i62_inq_num_names_per_adl     := rv_i62_inq_num_names_per_adl;
                    self.rv_i62_inq_phones_per_adl        := rv_i62_inq_phones_per_adl;
                    self.rv_i62_inq_dobs_per_adl          := rv_i62_inq_dobs_per_adl;
                    self.rv_i62_inq_addrsperadl_recency   := rv_i62_inq_addrsperadl_recency;
                    self.rv_i62_inq_fnamesperadl_recency  := rv_i62_inq_fnamesperadl_recency;
                    self.rv_l79_adls_per_addr_curr        := rv_l79_adls_per_addr_curr;
                    self.rv_l79_adls_per_apt_addr         := rv_l79_adls_per_apt_addr;
                    self.rv_l79_adls_per_sfd_addr         := rv_l79_adls_per_sfd_addr;
                    self.rv_l79_adls_per_apt_addr_c6      := rv_l79_adls_per_apt_addr_c6;
                    self.rv_c18_invalid_addrs_per_adl     := rv_c18_invalid_addrs_per_adl;
                    self.rv_l78_no_phone_at_addr_vel      := rv_l78_no_phone_at_addr_vel;
                    self.rv_c13_attr_addrs_recency        := rv_c13_attr_addrs_recency;
                    self.iv_rv5_unscorable                := iv_rv5_unscorable;
                    self.iv_f00_nas_summary               := iv_f00_nas_summary;
                    self.rv_f01_inp_addr_address_score    := rv_f01_inp_addr_address_score;
                    self.iv_fname_non_phn_src_ct          := iv_fname_non_phn_src_ct;
                    self.iv_lname_non_phn_src_ct          := iv_lname_non_phn_src_ct;
                    self.iv_full_name_non_phn_src_ct      := iv_full_name_non_phn_src_ct;
                    self.iv_full_name_ver_sources         := iv_full_name_ver_sources;
                    self.iv_addr_non_phn_src_ct           := iv_addr_non_phn_src_ct;
                    self.iv_nas_fname_verd                := iv_nas_fname_verd;
                    self.iv_c13_avg_lres                  := iv_c13_avg_lres;
                    self.rv_c13_inp_addr_lres             := rv_c13_inp_addr_lres;
                    self.rv_c12_inp_addr_source_count     := rv_c12_inp_addr_source_count;
                    self.mortgage_type                    := mortgage_type;
                    self.mortgage_present                 := mortgage_present;
                    self.iv_inp_addr_mortgage_type        := iv_inp_addr_mortgage_type;
                    self.iv_curr_add_financing_type       := iv_curr_add_financing_type;
                    self.rv_a49_curr_add_avm_chg_2yr      := rv_a49_curr_add_avm_chg_2yr;
                    self.rv_a49_curr_add_avm_pct_chg_2yr  := rv_a49_curr_add_avm_pct_chg_2yr;
                    self.rv_a49_curr_add_avm_chg_3yr      := rv_a49_curr_add_avm_chg_3yr;
                    self.rv_a49_curr_add_avm_pct_chg_3yr  := rv_a49_curr_add_avm_pct_chg_3yr;
                    self.iv_prv_addr_lres                 := iv_prv_addr_lres;
                    self.iv_prv_addr_avm_auto_val         := iv_prv_addr_avm_auto_val;
                    self.iv_input_best_name_match         := iv_input_best_name_match;
                    self.iv_best_ssn_prior_dob            := iv_best_ssn_prior_dob;
                    self.iv_prop1_purch_sale_diff         := iv_prop1_purch_sale_diff;
                    self.iv_prop2_purch_sale_diff         := iv_prop2_purch_sale_diff;
                    self.iv_a46_l77_addrs_move_traj_index := iv_a46_l77_addrs_move_traj_index;
                    self.iv_unverified_addr_count         := iv_unverified_addr_count;
                    self.iv_c14_addrs_per_adl             := iv_c14_addrs_per_adl;
                    self.br_first_seen_char               := br_first_seen_char;
                    self._br_first_seen                   := _br_first_seen;
                    self.rv_mos_since_br_first_seen       := rv_mos_since_br_first_seen;
                    self.rv_e58_br_dead_bus_x_active_phn  := rv_e58_br_dead_bus_x_active_phn;
                    self.iv_d34_released_liens_ct         := iv_d34_released_liens_ct;
                    self.iv_d34_liens_rel_cj_ct           := iv_d34_liens_rel_cj_ct;
                    self.iv_college_major                 := iv_college_major;
                    self.iv_college_code_x_type           := iv_college_code_x_type;
                    self.iv_college_file_type             := iv_college_file_type;
                    self.iv_prof_license_category_pl      := iv_prof_license_category_pl;
                    self.iv_estimated_income              := iv_estimated_income;
                    self.iv_wealth_index                  := iv_wealth_index;
                    self.num_lname_sources                := num_lname_sources;
                    self.iv_lname_bureau_only             := iv_lname_bureau_only;
                    self._in_dob                          := _in_dob;
                    self.earliest_bureau_date             := earliest_bureau_date;
                    self.earliest_bureau_yrs              := earliest_bureau_yrs;
                    self.calc_dob                         := calc_dob;
                    self.iv_bureau_emergence_age          := iv_bureau_emergence_age;
                    self.earliest_header_date             := earliest_header_date;
                    self.earliest_header_yrs              := earliest_header_yrs;
                    self.iv_header_emergence_age          := iv_header_emergence_age;
                    self.earliest_behavioral_date         := earliest_behavioral_date;
                    self.earliest_inperson_date           := earliest_inperson_date;
                    self.earliest_source_date             := earliest_source_date;
                    self.iv_emergence_source_type         := iv_emergence_source_type;
                    self.src_inperson                     := src_inperson;
                    self.iv_num_inperson_sources          := iv_num_inperson_sources;
                    self.iv_num_non_bureau_sources        := iv_num_non_bureau_sources;
                    self.iv_src_voter_adl_count           := iv_src_voter_adl_count;
                    self.vo_pos                           := vo_pos;
                    self.vote_adl_lseen_vo                := vote_adl_lseen_vo;
                    self._vote_adl_lseen_vo               := _vote_adl_lseen_vo;
                    self.iv_mos_src_voter_adl_lseen       := iv_mos_src_voter_adl_lseen;
                    self.num_dob_match_level              := num_dob_match_level;
                    self.nas_summary_ver                  := nas_summary_ver;
                    self.nap_summary_ver                  := nap_summary_ver;
                    self.infutor_nap_ver                  := infutor_nap_ver;
                    self.dob_ver                          := dob_ver;
                    self.sufficiently_verified            := sufficiently_verified;
                    self.add_ec1                          := add_ec1;
                    self.addr_validation_problem          := addr_validation_problem;
                    self.phn_validation_problem           := phn_validation_problem;
                    self.validation_problem               := validation_problem;
                    self.tot_liens                        := tot_liens;
                    self.tot_liens_w_type                 := tot_liens_w_type;
                    self.has_derog                        := has_derog;
                    self.rv_6seg_riskview_5_0             := rv_6seg_riskview_5_0;
                    self.rv_4seg_riskview_5_0             := rv_4seg_riskview_5_0;
                    self.final_score_tree_0               := final_score_tree_0;
                    self.final_score_tree_1               := final_score_tree_1;
                    self.final_score_tree_2               := final_score_tree_2;
                    self.final_score_tree_3               := final_score_tree_3;
                    self.final_score_tree_4               := final_score_tree_4;
                    self.final_score_tree_5               := final_score_tree_5;
                    self.final_score_tree_6               := final_score_tree_6;
                    self.final_score_tree_7               := final_score_tree_7;
                    self.final_score_tree_8               := final_score_tree_8;
                    self.final_score_tree_9               := final_score_tree_9;
                    self.final_score_tree_10              := final_score_tree_10;
                    self.final_score_tree_11              := final_score_tree_11;
                    self.final_score_tree_12              := final_score_tree_12;
                    self.final_score_tree_13              := final_score_tree_13;
                    self.final_score_tree_14              := final_score_tree_14;
                    self.final_score_tree_15              := final_score_tree_15;
                    self.final_score_tree_16              := final_score_tree_16;
                    self.final_score_tree_17              := final_score_tree_17;
                    self.final_score_tree_18              := final_score_tree_18;
                    self.final_score_tree_19              := final_score_tree_19;
                    self.final_score_tree_20              := final_score_tree_20;
                    self.final_score_tree_21              := final_score_tree_21;
                    self.final_score_tree_22              := final_score_tree_22;
                    self.final_score_tree_23              := final_score_tree_23;
                    self.final_score_tree_24              := final_score_tree_24;
                    self.final_score_tree_25              := final_score_tree_25;
                    self.final_score_tree_26              := final_score_tree_26;
                    self.final_score_tree_27              := final_score_tree_27;
                    self.final_score_tree_28              := final_score_tree_28;
                    self.final_score_tree_29              := final_score_tree_29;
                    self.final_score_tree_30              := final_score_tree_30;
                    self.final_score_tree_31              := final_score_tree_31;
                    self.final_score_tree_32              := final_score_tree_32;
                    self.final_score_tree_33              := final_score_tree_33;
                    self.final_score_tree_34              := final_score_tree_34;
                    self.final_score_tree_35              := final_score_tree_35;
                    self.final_score_tree_36              := final_score_tree_36;
                    self.final_score_tree_37              := final_score_tree_37;
                    self.final_score_tree_38              := final_score_tree_38;
                    self.final_score_tree_39              := final_score_tree_39;
                    self.final_score_tree_40              := final_score_tree_40;
                    self.final_score_tree_41              := final_score_tree_41;
                    self.final_score_tree_42              := final_score_tree_42;
                    self.final_score_tree_43              := final_score_tree_43;
                    self.final_score_tree_44              := final_score_tree_44;
                    self.final_score_tree_45              := final_score_tree_45;
                    self.final_score_tree_46              := final_score_tree_46;
                    self.final_score_tree_47              := final_score_tree_47;
                    self.final_score_tree_48              := final_score_tree_48;
                    self.final_score_tree_49              := final_score_tree_49;
                    self.final_score_tree_50              := final_score_tree_50;
                    self.final_score_tree_51              := final_score_tree_51;
                    self.final_score_tree_52              := final_score_tree_52;
                    self.final_score_tree_53              := final_score_tree_53;
                    self.final_score_tree_54              := final_score_tree_54;
                    self.final_score_tree_55              := final_score_tree_55;
                    self.final_score_tree_56              := final_score_tree_56;
                    self.final_score_tree_57              := final_score_tree_57;
                    self.final_score_tree_58              := final_score_tree_58;
                    self.final_score_tree_59              := final_score_tree_59;
                    self.final_score_tree_60              := final_score_tree_60;
                    self.final_score_tree_61              := final_score_tree_61;
                    self.final_score_tree_62              := final_score_tree_62;
                    self.final_score_tree_63              := final_score_tree_63;
                    self.final_score_tree_64              := final_score_tree_64;
                    self.final_score_tree_65              := final_score_tree_65;
                    self.final_score_tree_66              := final_score_tree_66;
                    self.final_score_tree_67              := final_score_tree_67;
                    self.final_score_tree_68              := final_score_tree_68;
                    self.final_score_tree_69              := final_score_tree_69;
                    self.final_score_tree_70              := final_score_tree_70;
                    self.final_score_tree_71              := final_score_tree_71;
                    self.final_score_tree_72              := final_score_tree_72;
                    self.final_score_tree_73              := final_score_tree_73;
                    self.final_score_tree_74              := final_score_tree_74;
                    self.final_score_tree_75              := final_score_tree_75;
                    self.final_score_tree_76              := final_score_tree_76;
                    self.final_score_tree_77              := final_score_tree_77;
                    self.final_score_tree_78              := final_score_tree_78;
                    self.final_score_tree_79              := final_score_tree_79;
                    self.final_score_tree_80              := final_score_tree_80;
                    self.final_score_tree_81              := final_score_tree_81;
                    self.final_score_tree_82              := final_score_tree_82;
                    self.final_score_tree_83              := final_score_tree_83;
                    self.final_score_tree_84              := final_score_tree_84;
                    self.final_score_tree_85              := final_score_tree_85;
                    self.final_score_tree_86              := final_score_tree_86;
                    self.final_score_tree_87              := final_score_tree_87;
                    self.final_score_tree_88              := final_score_tree_88;
                    self.final_score_tree_89              := final_score_tree_89;
                    self.final_score_tree_90              := final_score_tree_90;
                    self.final_score_tree_91              := final_score_tree_91;
                    self.final_score_tree_92              := final_score_tree_92;
                    self.final_score_tree_93              := final_score_tree_93;
                    self.final_score_tree_94              := final_score_tree_94;
                    self.final_score_tree_95              := final_score_tree_95;
                    self.final_score_tree_96              := final_score_tree_96;
                    self.final_score_tree_97              := final_score_tree_97;
                    self.final_score_tree_98              := final_score_tree_98;
                    self.final_score_tree_99              := final_score_tree_99;
                    self.final_score_tree_100             := final_score_tree_100;
                    self.final_score_tree_101             := final_score_tree_101;
                    self.final_score_tree_102             := final_score_tree_102;
                    self.final_score_tree_103             := final_score_tree_103;
                    self.final_score_tree_104             := final_score_tree_104;
                    self.final_score_tree_105             := final_score_tree_105;
                    self.final_score_tree_106             := final_score_tree_106;
                    self.final_score_tree_107             := final_score_tree_107;
                    self.final_score_tree_108             := final_score_tree_108;
                    self.final_score_tree_109             := final_score_tree_109;
                    self.final_score_tree_110             := final_score_tree_110;
                    self.final_score_tree_111             := final_score_tree_111;
                    self.final_score_tree_112             := final_score_tree_112;
                    self.final_score_tree_113             := final_score_tree_113;
                    self.final_score_tree_114             := final_score_tree_114;
                    self.final_score_tree_115             := final_score_tree_115;
                    self.final_score_tree_116             := final_score_tree_116;
                    self.final_score_tree_117             := final_score_tree_117;
                    self.final_score_tree_118             := final_score_tree_118;
                    self.final_score_tree_119             := final_score_tree_119;
                    self.final_score_tree_120             := final_score_tree_120;
                    self.final_score_tree_121             := final_score_tree_121;
                    self.final_score_tree_122             := final_score_tree_122;
                    self.final_score_tree_123             := final_score_tree_123;
                    self.final_score_tree_124             := final_score_tree_124;
                    self.final_score_tree_125             := final_score_tree_125;
                    self.final_score_tree_126             := final_score_tree_126;
                    self.final_score_tree_127             := final_score_tree_127;
                    self.final_score_tree_128             := final_score_tree_128;
                    self.final_score_tree_129             := final_score_tree_129;
                    self.final_score_tree_130             := final_score_tree_130;
                    self.final_score_tree_131             := final_score_tree_131;
                    self.final_score_tree_132             := final_score_tree_132;
                    self.final_score_tree_133             := final_score_tree_133;
                    self.final_score_tree_134             := final_score_tree_134;
                    self.final_score_tree_135             := final_score_tree_135;
                    self.final_score_tree_136             := final_score_tree_136;
                    self.final_score_tree_137             := final_score_tree_137;
                    self.final_score_tree_138             := final_score_tree_138;
                    self.final_score_tree_139             := final_score_tree_139;
                    self.final_score_gbm_logit            := final_score_gbm_logit;
                    self.deceased                         := deceased;
                    self.base                             := base;
                    self.pts                              := pts;
                    self.lgt                              := lgt;
                    self.rvp1702_1_0                      := rvp1702_1_0;

		SELF.clam := le;
	#else
		HRILayout := RECORD
			STRING4 HRI := '';
		END;
		/* This model does not return any reason codes */
		blanks := DATASET([{''}, {''}, {''}, {''}, {''}], HRILayout);
		SELF.ri := PROJECT(blanks, TRANSFORM(Risk_Indicators.Layout_Desc,
																							SELF.hri := LEFT.hri,
																							SELF.desc := Risk_Indicators.getHRIDesc(LEFT.hri)));
		/* Override the score to '222' if optout flag is set */
		PrescreenOptOut := risk_indicators.iid_constants.CheckFlag( risk_indicators.iid_constants.IIDFlag.IsPreScreen, le.iid.iid_flags );
		self.score := if( risk_indicators.rcset.isCode95(PreScreenOptOut), '222', (string3)RVP1702_1_0);
		SELF.seq := le.seq;
	#end
	END;

	model := PROJECT(clam, doModel(LEFT));

	RETURN(model);
END;

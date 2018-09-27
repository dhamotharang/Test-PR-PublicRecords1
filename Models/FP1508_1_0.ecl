
import Std, risk_indicators, riskwise, riskwisefcra, ut,  Models;

blank_ip := dataset( [{0}], riskwise.Layout_IP2O )[1];

export FP1508_1_0(dataset(risk_indicators.Layout_Boca_Shell) clam,
                  integer1 num_reasons)
									 := FUNCTION
									
		FP_DEBUG := False;
		
		isFCRA := False;

	#if(FP_DEBUG)
	Layout_Debug := RECORD
	
	/* Model Intermediate Variables */
	//   String NULL;
                    Integer seq                             ; //:=seq;
                    Integer sysdate                         ; // :=  sysdate;
                    integer ver_src_ak_pos                   ; // :=  ver_src_ak_pos;
                    string _ver_src_fdate_ak                ; // :=  _ver_src_fdate_ak;
                    integer ver_src_fdate_ak                 ; // :=  ver_src_fdate_ak;
                    integer ver_src_am_pos                   ; // :=  ver_src_am_pos;
                    boolean ver_src_am                       ; // :=  ver_src_am;
                    string _ver_src_fdate_am                ; // :=  _ver_src_fdate_am;
                    integer ver_src_fdate_am                 ; // :=  ver_src_fdate_am;
                    integer ver_src_ar_pos                   ; // :=  ver_src_ar_pos;
                    boolean ver_src_ar                       ; // :=  ver_src_ar;
                    string _ver_src_fdate_ar                ; // :=  _ver_src_fdate_ar;
                    integer ver_src_fdate_ar                 ; // :=  ver_src_fdate_ar;
                    integer ver_src_ba_pos                   ; // :=  ver_src_ba_pos;
                    boolean ver_src_ba                       ; // :=  ver_src_ba;
                    string _ver_src_fdate_ba                ; // :=  _ver_src_fdate_ba;
                    integer ver_src_fdate_ba                 ; // :=  ver_src_fdate_ba;
                    integer ver_src_cg_pos                   ; // :=  ver_src_cg_pos;
                    boolean ver_src_cg                       ; // :=  ver_src_cg;
                    string _ver_src_fdate_cg                ; // :=  _ver_src_fdate_cg;
                    integer ver_src_fdate_cg                 ; // :=  ver_src_fdate_cg;
                    integer ver_src_co_pos                   ; // :=  ver_src_co_pos;
                    string _ver_src_fdate_co                ; // :=  _ver_src_fdate_co;
                    integer ver_src_fdate_co                 ; // :=  ver_src_fdate_co;
                    integer ver_src_cy_pos                   ; // :=  ver_src_cy_pos;
                    string _ver_src_fdate_cy                ; // :=  _ver_src_fdate_cy;
                    Integer ver_src_fdate_cy                 ; // :=  ver_src_fdate_cy;
                    Integer ver_src_da_pos                   ; // :=  ver_src_da_pos;
                    boolean ver_src_da                       ; // :=  ver_src_da;
                    string _ver_src_fdate_da                ; // :=  _ver_src_fdate_da;
                    integer ver_src_fdate_da                 ; // :=  ver_src_fdate_da;
                    integer ver_src_d_pos                    ; // :=  ver_src_d_pos;
                    boolean ver_src_d                        ; // :=  ver_src_d;
                    string _ver_src_fdate_d                 ; // :=  _ver_src_fdate_d;
                    integer ver_src_fdate_d                  ; // :=  ver_src_fdate_d;
                    integer ver_src_dl_pos                   ; // :=  ver_src_dl_pos;
                    boolean ver_src_dl                       ; // :=  ver_src_dl;
                    string _ver_src_fdate_dl                ; // :=  _ver_src_fdate_dl;
                    integer ver_src_fdate_dl                 ; // :=  ver_src_fdate_dl;
                    integer ver_src_ds_pos                   ; // :=  ver_src_ds_pos;
                    string _ver_src_fdate_ds                ; // :=  _ver_src_fdate_ds;
                    integer ver_src_fdate_ds                 ; // :=  ver_src_fdate_ds;
                    integer ver_src_de_pos                   ; // :=  ver_src_de_pos;
                    string _ver_src_fdate_de                ; // :=  _ver_src_fdate_de;
                    integer ver_src_fdate_de                 ; // :=  ver_src_fdate_de;
                    integer ver_src_eb_pos                   ; // :=  ver_src_eb_pos;
                    boolean ver_src_eb                       ; // :=  ver_src_eb;
                    string _ver_src_fdate_eb                ; // :=  _ver_src_fdate_eb;
                    integer ver_src_fdate_eb                 ; // :=  ver_src_fdate_eb;
                    integer ver_src_em_pos                   ; // :=  ver_src_em_pos;
                    string _ver_src_fdate_em                ; // :=  _ver_src_fdate_em;
                    integer ver_src_fdate_em                 ; // :=  ver_src_fdate_em;
                    integer ver_src_e1_pos                   ; // :=  ver_src_e1_pos;
                    boolean ver_src_e1                       ; // :=  ver_src_e1;
                    string _ver_src_fdate_e1                ; // :=  _ver_src_fdate_e1;
                    integer ver_src_fdate_e1                 ; // :=  ver_src_fdate_e1;
                    integer ver_src_e2_pos                   ; // :=  ver_src_e2_pos;
                    boolean ver_src_e2                       ; // :=  ver_src_e2;
                    string _ver_src_fdate_e2                ; // :=  _ver_src_fdate_e2;
                    integer ver_src_fdate_e2                 ; // :=  ver_src_fdate_e2;
                    integer ver_src_e3_pos                   ; // :=  ver_src_e3_pos;
                    Boolean ver_src_e3                       ; // :=  ver_src_e3;
                    string _ver_src_fdate_e3                ; // :=  _ver_src_fdate_e3;
                    integer ver_src_fdate_e3                 ; // :=  ver_src_fdate_e3;
                    integer ver_src_e4_pos                   ; // :=  ver_src_e4_pos;
                    string _ver_src_fdate_e4                ; // :=  _ver_src_fdate_e4;
                    integer ver_src_fdate_e4                 ; // :=  ver_src_fdate_e4;
                    integer ver_src_en_pos                   ; // :=  ver_src_en_pos;
                    Boolean ver_src_en                       ; // :=  ver_src_en;
                    string _ver_src_fdate_en                ; // :=  _ver_src_fdate_en;
                    integer ver_src_fdate_en                 ; // :=  ver_src_fdate_en;
                    integer ver_src_eq_pos                   ; // :=  ver_src_eq_pos;
                    boolean ver_src_eq                       ; // :=  ver_src_eq;
                    string _ver_src_fdate_eq                ; // :=  _ver_src_fdate_eq;
                    integer ver_src_fdate_eq                 ; // :=  ver_src_fdate_eq;
                    integer ver_src_fe_pos                   ; // :=  ver_src_fe_pos;
                    boolean ver_src_fe                       ; // :=  ver_src_fe;
                    string _ver_src_fdate_fe                ; // :=  _ver_src_fdate_fe;
                    integer ver_src_fdate_fe                 ; // :=  ver_src_fdate_fe;
                    integer ver_src_ff_pos                   ; // :=  ver_src_ff_pos;
                    boolean ver_src_ff                       ; // :=  ver_src_ff;
                    string _ver_src_fdate_ff                ; // :=  _ver_src_fdate_ff;
                    integer ver_src_fdate_ff                 ; // :=  ver_src_fdate_ff;
                    integer ver_src_fr_pos                   ; // :=  ver_src_fr_pos;
                    string _ver_src_fdate_fr                ; // :=  _ver_src_fdate_fr;
                    integer ver_src_fdate_fr                 ; // :=  ver_src_fdate_fr;
                    integer ver_src_l2_pos                   ; // :=  ver_src_l2_pos;
                    string _ver_src_fdate_l2                ; // :=  _ver_src_fdate_l2;
                    integer ver_src_fdate_l2                 ; // :=  ver_src_fdate_l2;
                    integer ver_src_li_pos                   ; // :=  ver_src_li_pos;
                    string _ver_src_fdate_li                ; // :=  _ver_src_fdate_li;
                    integer ver_src_fdate_li                 ; // :=  ver_src_fdate_li;
                    integer ver_src_mw_pos                   ; // :=  ver_src_mw_pos;
                    string _ver_src_fdate_mw                ; // :=  _ver_src_fdate_mw;
                    integer ver_src_fdate_mw                 ; // :=  ver_src_fdate_mw;
                    integer ver_src_nt_pos                   ; // :=  ver_src_nt_pos;
                    string _ver_src_fdate_nt                ; // :=  _ver_src_fdate_nt;
                    integer ver_src_fdate_nt                 ; // :=  ver_src_fdate_nt;
                    integer ver_src_p_pos                    ; // :=  ver_src_p_pos;
                    boolean ver_src_p                        ; // :=  ver_src_p;
                    string _ver_src_fdate_p                 ; // :=  _ver_src_fdate_p;
                    integer ver_src_fdate_p                  ; // :=  ver_src_fdate_p;
                    integer ver_src_pl_pos                   ; // :=  ver_src_pl_pos;
                    boolean ver_src_pl                       ; // :=  ver_src_pl;
                    string _ver_src_fdate_pl                ; // :=  _ver_src_fdate_pl;
                    integer ver_src_fdate_pl                 ; // :=  ver_src_fdate_pl;
                    integer ver_src_tn_pos                   ; // :=  ver_src_tn_pos;
                    boolean ver_src_tn                       ; // :=  ver_src_tn;
                    string _ver_src_fdate_tn                ; // :=  _ver_src_fdate_tn;
                    integer ver_src_fdate_tn                 ; // :=  ver_src_fdate_tn;
                    integer ver_src_ts_pos                   ; // :=  ver_src_ts_pos;
                    string _ver_src_fdate_ts                ; // :=  _ver_src_fdate_ts;
                    integer ver_src_fdate_ts                 ; // :=  ver_src_fdate_ts;
                    integer ver_src_tu_pos                   ; // :=  ver_src_tu_pos;
                    string _ver_src_fdate_tu                ; // :=  _ver_src_fdate_tu;
                    integer ver_src_fdate_tu                 ; // :=  ver_src_fdate_tu;
                    integer ver_src_sl_pos                   ; // :=  ver_src_sl_pos;
                    boolean ver_src_sl                       ; // :=  ver_src_sl;
                    string _ver_src_fdate_sl                ; // :=  _ver_src_fdate_sl;
                    integer ver_src_fdate_sl                 ; // :=  ver_src_fdate_sl;
                    integer ver_src_v_pos                    ; // :=  ver_src_v_pos;
                    boolean ver_src_v                        ; // :=  ver_src_v;
                    string _ver_src_fdate_v                 ; // :=  _ver_src_fdate_v;
                    integer ver_src_fdate_v                  ; // :=  ver_src_fdate_v;
                    integer ver_src_vo_pos                   ; // :=  ver_src_vo_pos;
                    boolean ver_src_vo                       ; // :=  ver_src_vo;
                    string _ver_src_fdate_vo                ; // :=  _ver_src_fdate_vo;
                    integer ver_src_fdate_vo                 ; // :=  ver_src_fdate_vo;
                    integer ver_src_w_pos                    ; // :=  ver_src_w_pos;
                    boolean ver_src_w                        ; // :=  ver_src_w;
                    string _ver_src_fdate_w                 ; // :=  _ver_src_fdate_w;
                    integer ver_src_fdate_w                  ; // :=  ver_src_fdate_w;
                    integer ver_src_wp_pos                   ; // :=  ver_src_wp_pos;
                    string _ver_src_fdate_wp                ; // :=  _ver_src_fdate_wp;
                    integer ver_src_fdate_wp                 ; // :=  ver_src_fdate_wp;
                    boolean ver_fname_src_en_pos             ; // :=  ver_fname_src_en_pos;
                    boolean ver_fname_src_en                 ; // :=  ver_fname_src_en;
                    integer ver_fname_src_eq_pos             ; // :=  ver_fname_src_eq_pos;
                    boolean ver_fname_src_eq                 ; // :=  ver_fname_src_eq;
                    integer ver_fname_src_tn_pos             ; // :=  ver_fname_src_tn_pos;
                    boolean ver_fname_src_tn                 ; // :=  ver_fname_src_tn;
                    integer ver_lname_src_en_pos             ; // :=  ver_lname_src_en_pos;
                    boolean ver_lname_src_en                 ; // :=  ver_lname_src_en;
                    integer ver_lname_src_eq_pos             ; // :=  ver_lname_src_eq_pos;
                    boolean ver_lname_src_eq                 ; // :=  ver_lname_src_eq;
                    integer ver_lname_src_tn_pos             ; // :=  ver_lname_src_tn_pos;
                    boolean ver_lname_src_tn                 ; // :=  ver_lname_src_tn;
                    integer ver_addr_src_en_pos              ; // :=  ver_addr_src_en_pos;
                    boolean ver_addr_src_en                  ; // :=  ver_addr_src_en;
                    integer ver_addr_src_eq_pos              ; // :=  ver_addr_src_eq_pos;
                    boolean ver_addr_src_eq                  ; // :=  ver_addr_src_eq;
                    integer ver_addr_src_tn_pos              ; // :=  ver_addr_src_tn_pos;
                    boolean ver_addr_src_tn                  ; // :=  ver_addr_src_tn;
                    integer ver_ssn_src_en_pos               ; // :=  ver_ssn_src_en_pos;
                    boolean ver_ssn_src_en                   ; // :=  ver_ssn_src_en;
                    integer ver_ssn_src_eq_pos               ; // :=  ver_ssn_src_eq_pos;
                    boolean ver_ssn_src_eq                   ; // :=  ver_ssn_src_eq;
                    integer ver_ssn_src_tn_pos               ; // :=  ver_ssn_src_tn_pos;
                    boolean ver_ssn_src_tn                   ; // :=  ver_ssn_src_tn;
                    integer ver_dob_src_en_pos               ; // :=  ver_dob_src_en_pos;
                    boolean ver_dob_src_en                   ; // :=  ver_dob_src_en;
                    integer ver_dob_src_eq_pos               ; // :=  ver_dob_src_eq_pos;
                    boolean ver_dob_src_eq                   ; // :=  ver_dob_src_eq;
                    integer ver_dob_src_tn_pos               ; // :=  ver_dob_src_tn_pos;
                    boolean ver_dob_src_tn                   ; // :=  ver_dob_src_tn;
                    integer util_type_2_pos                  ; // :=  util_type_2_pos;
                    boolean util_type_2                      ; // :=  util_type_2;
                    integer util_type_1_pos                  ; // :=  util_type_1_pos;
                    boolean util_type_1                      ; // :=  util_type_1;
                    integer util_type_z_pos                  ; // :=  util_type_z_pos;
                    boolean util_type_z                      ; // :=  util_type_z;
                  //  integer util_inp_2_pos                   ; // :=  util_inp_2_pos;
                    boolean util_inp_2                       ; // :=  util_inp_2;
                  //  integer util_inp_1_pos                   ; // :=  util_inp_1_pos;
                    boolean util_inp_1                       ; // :=  util_inp_1;
                  //  integer util_inp_z_pos                   ; // :=  util_inp_z_pos;
                    boolean util_inp_z                       ; // :=  util_inp_z;
                    string iv_add_apt                       ; // :=  iv_add_apt;
                    integer nf_email_name_addr_ver           ; // :=  nf_email_name_addr_ver;
                    integer _rc_ssnhighissue                 ; // :=  _rc_ssnhighissue;
                    integer nf_m_snc_ssn_high_issue          ; // :=  nf_m_snc_ssn_high_issue;
                    integer iv_nap_inf_phone_ver_lvl         ; // :=  iv_nap_inf_phone_ver_lvl;
                    integer nf_inquiry_verification_index    ; // :=  nf_inquiry_verification_index;
                    integer nf_phone_ver_insurance           ; // :=  nf_phone_ver_insurance;
                    decimal4_1 rv_c12_source_profile            ; // :=  rv_c12_source_profile;
                    integer nf_adls_per_bestssn              ; // :=  nf_adls_per_bestssn;
                    integer iv_dob_src_ct                    ; // :=  iv_dob_src_ct;
                    integer iv_f00_nas_summary               ; // :=  iv_f00_nas_summary;
                    integer earliest_bureau_date             ; // :=  earliest_bureau_date;
                    integer earliest_bureau_yrs              ; // :=  earliest_bureau_yrs;
                    integer iv_bureau_emergence_age          ; // :=  iv_bureau_emergence_age;
                    integer nf_inq_phone_ver_count           ; // :=  nf_inq_phone_ver_count;
                    string nf_util_add_input_summary        ; // :=  nf_util_add_input_summary;
                    integer nf_dl_addrs_per_adl              ; // :=  nf_dl_addrs_per_adl;
                    integer rv_i62_inq_phonesperadl_recency  ; // :=  rv_i62_inq_phonesperadl_recency;
                    integer rv_f00_dob_score                 ; // :=  rv_f00_dob_score;
                    integer nf_add_dist_input_to_curr        ; // :=  nf_add_dist_input_to_curr;
                    integer nf_inq_per_phone                 ; // :=  nf_inq_per_phone;
                    boolean iv_inf_phn_verd                  ; // :=  iv_inf_phn_verd;
                    integer nf_age_at_ssn_issuance           ; // :=  nf_age_at_ssn_issuance;
                    integer nf_inq_perphone_recency          ; // :=  nf_inq_perphone_recency;
                    integer rv_c20_m_bureau_adl_fs           ; // :=  rv_c20_m_bureau_adl_fs;
                    string nf_historic_x_current_ct         ; // :=  nf_historic_x_current_ct;
                    string rv_e58_br_dead_bus_x_active_phn  ; // :=  rv_e58_br_dead_bus_x_active_phn;
                    integer nf_addrs_per_ssn                 ; // :=  nf_addrs_per_ssn;
                    integer iv_addr_non_phn_src_ct           ; // :=  iv_addr_non_phn_src_ct;
                    integer rv_i60_inq_other_recency         ; // :=  rv_i60_inq_other_recency;
                    integer rv_p88_phn_dst_to_inp_add        ; // :=  rv_p88_phn_dst_to_inp_add;
                    integer rv_c12_inp_addr_source_count     ; // :=  rv_c12_inp_addr_source_count;
                    integer rv_email_count                   ; // :=  rv_email_count;
                    integer nf_unvrfd_search_risk_index      ; // :=  nf_unvrfd_search_risk_index;
                    integer rv_c13_attr_addrs_recency        ; // :=  rv_c13_attr_addrs_recency;
                    integer iv_phn_cell                      ; // :=  iv_phn_cell;
                    Integer iv_f00_email_verification        ; // :=  iv_f00_email_verification;
                    integer _rc_ssnlowissue                  ; // :=  _rc_ssnlowissue;
                    integer _in_dob                          ; // :=  _in_dob;
                    integer ssn_years                        ; // :=  ssn_years;
                    integer calc_dob                         ; // :=  calc_dob;
                    integer _age_at_ssn_issuance             ; // :=  _age_at_ssn_issuance;
                    integer nf_age_at_ssn_issuance_19_61     ; // :=  nf_age_at_ssn_issuance_19_61;
                    integer earliest_cred_date_all           ; // :=  earliest_cred_date_all;
                    integer nf_m_src_credentialed_fs         ; // :=  nf_m_src_credentialed_fs;
                    integer rv_c18_invalid_addrs_per_adl     ; // :=  rv_c18_invalid_addrs_per_adl;
                    integer nf_inq_per_ssn                   ; // :=  nf_inq_per_ssn;
                    integer nf_inq_perssn_count_week         ; // :=  nf_inq_perssn_count_week;
                    integer num_bureau_fname                 ; // :=  num_bureau_fname;
                    integer num_bureau_lname                 ; // :=  num_bureau_lname;
                    integer num_bureau_addr                  ; // :=  num_bureau_addr;
                    integer num_bureau_ssn                   ; // :=  num_bureau_ssn;
                    integer num_bureau_dob                   ; // :=  num_bureau_dob;
                    Integer iv_bureau_verification_index     ; // :=  iv_bureau_verification_index;
                    integer rv_i61_inq_collection_recency    ; // :=  rv_i61_inq_collection_recency;
                    integer iv_prv_addr_lres                 ; // :=  iv_prv_addr_lres;
                    integer earliest_header_date             ; // :=  earliest_header_date;
                    integer earliest_header_yrs              ; // :=  earliest_header_yrs;
                    Integer iv_header_emergence_age          ; // :=  iv_header_emergence_age;
                    Integer nf_fp_validationrisktype         ; // :=  nf_fp_validationrisktype;
                    integer iv_src_voter_adl_count           ; // :=  iv_src_voter_adl_count;
                    integer vo_pos                           ; // :=  vo_pos;
                    string vote_adl_lseen_vo                ; // :=  vote_adl_lseen_vo;
                    integer _vote_adl_lseen_vo               ; // :=  _vote_adl_lseen_vo;
                    integer iv_mos_src_voter_adl_lseen       ; // :=  iv_mos_src_voter_adl_lseen;
                    string iv_college_major                 ; // :=  iv_college_major;
                    integer rv_c12_source_profile_index      ; // :=  rv_c12_source_profile_index;
                    string nf_util_adl_summary              ; // :=  nf_util_adl_summary;
                    integer iv_c13_avg_lres                  ; // :=  iv_c13_avg_lres;
                    Boolean iv_nap_nothing_found             ; // :=  iv_nap_nothing_found;
                    integer d_pos                            ; // :=  d_pos;
                    integer lic_adl_count_d                  ; // :=  lic_adl_count_d;
                    integer dl_pos                           ; // :=  dl_pos;
                    integer lic_adl_count_dl                 ; // :=  lic_adl_count_dl;
                    integer src_drivers_license_adl_count    ; // :=  src_drivers_license_adl_count;
                    integer iv_src_drivers_lic_adl_count     ; // :=  iv_src_drivers_lic_adl_count;
                    integer nf_fp_idveraddressnotcurrent     ; // :=  nf_fp_idveraddressnotcurrent;
                    integer nf_inq_dobsperssn_recency        ; // :=  nf_inq_dobsperssn_recency;
                    integer rv_i60_inq_auto_recency          ; // :=  rv_i60_inq_auto_recency;
                    integer nf_inq_bestssn_ver_count         ; // :=  nf_inq_bestssn_ver_count;
                    integer nf_phones_per_sfd_addr_curr      ; // :=  nf_phones_per_sfd_addr_curr;
                    integer rv_i62_inq_fnamesperadl_recency  ; // :=  rv_i62_inq_fnamesperadl_recency;
                    integer nf_addrs_per_bestssn             ; // :=  nf_addrs_per_bestssn;
                    integer nf_invbest_inq_peraddr_diff      ; // :=  nf_invbest_inq_peraddr_diff;
                    integer nf_adl_per_email                 ; // :=  nf_adl_per_email;
                    integer num_dob_match_level              ; // :=  num_dob_match_level;
                    integer nas_summary_ver                  ; // :=  nas_summary_ver;
                    integer nap_summary_ver                  ; // :=  nap_summary_ver;
                    integer infutor_nap_ver                  ; // :=  infutor_nap_ver;
                    integer dob_ver                          ; // :=  dob_ver;
                    integer sufficiently_verified            ; // :=  sufficiently_verified;
                    string add_ec1                          ; // :=  add_ec1;
                    integer addr_validation_problem          ; // :=  addr_validation_problem;
                    integer phn_validation_problem           ; // :=  phn_validation_problem;
                    integer validation_problem               ; // :=  validation_problem;
                    integer tot_liens                        ; // :=  tot_liens;
                    integer tot_liens_w_type                 ; // :=  tot_liens_w_type;
                    integer has_derog                        ; // :=  has_derog;
                    string rv_6seg_riskview_5_0             ; // :=  rv_6seg_riskview_5_0;
                    integer nf_inq_addrsperssn_recency       ; // :=  nf_inq_addrsperssn_recency;
                    integer rv_i62_inq_addrsperadl_recency   ; // :=  rv_i62_inq_addrsperadl_recency;
                    integer nf_acc_damage_amt_total          ; // :=  nf_acc_damage_amt_total;
                    integer nf_invbest_inq_adlsperphone_diff ; // :=  nf_invbest_inq_adlsperphone_diff;
                    integer nf_acc_damage_amt_last           ; // :=  nf_acc_damage_amt_last;
                    integer nf_inq_fname_ver_count           ; // :=  nf_inq_fname_ver_count;
                    integer nf_inq_lname_ver_count           ; // :=  nf_inq_lname_ver_count;
                    integer nf_adls_per_curraddr_curr        ; // :=  nf_adls_per_curraddr_curr;
                    integer rv_a41_a42_prop_owner_history    ; // :=  rv_a41_a42_prop_owner_history;
                    integer nf_phone_ver_experian            ; // :=  nf_phone_ver_experian;
                    Real   final_score_tree_0               ; // :=  final_score_tree_0;
                    Real   final_score_tree_1               ; // :=  final_score_tree_1;
                    Real   final_score_tree_2               ; // :=  final_score_tree_2;
                    Real   final_score_tree_3               ; // :=  final_score_tree_3;
                    Real   final_score_tree_4               ; // :=  final_score_tree_4;
                    Real   final_score_tree_5               ; // :=  final_score_tree_5;
                    Real   final_score_tree_6               ; // :=  final_score_tree_6;
                    Real   final_score_tree_7               ; // :=  final_score_tree_7;
                    Real   final_score_tree_8               ; // :=  final_score_tree_8;
                    Real   final_score_tree_9               ; // :=  final_score_tree_9;
                    Real   final_score_tree_10              ; // :=  final_score_tree_10;
                    Real   final_score_tree_11              ; // :=  final_score_tree_11;
                    Real   final_score_tree_12              ; // :=  final_score_tree_12;
                    Real   final_score_tree_13              ; // :=  final_score_tree_13;
                    Real   final_score_tree_14              ; // :=  final_score_tree_14;
                    Real   final_score_tree_15              ; // :=  final_score_tree_15;
                    Real   final_score_tree_16              ; // :=  final_score_tree_16;
                    Real   final_score_tree_17              ; // :=  final_score_tree_17;
                    Real   final_score_tree_18              ; // :=  final_score_tree_18;
                    Real   final_score_tree_19              ; // :=  final_score_tree_19;
                    Real   final_score_tree_20              ; // :=  final_score_tree_20;
                    Real   final_score_tree_21              ; // :=  final_score_tree_21;
                    Real   final_score_tree_22              ; // :=  final_score_tree_22;
                    Real   final_score_tree_23              ; // :=  final_score_tree_23;
                    Real   final_score_tree_24              ; // :=  final_score_tree_24;
                    Real   final_score_tree_25              ; // :=  final_score_tree_25;
                    Real   final_score_tree_26              ; // :=  final_score_tree_26;
                    Real   final_score_tree_27              ; // :=  final_score_tree_27;
                    Real   final_score_tree_28              ; // :=  final_score_tree_28;
                    Real   final_score_tree_29              ; // :=  final_score_tree_29;
                    Real   final_score_tree_30              ; // :=  final_score_tree_30;
                    Real   final_score_tree_31              ; // :=  final_score_tree_31;
                    Real   final_score_tree_32              ; // :=  final_score_tree_32;
                    Real   final_score_tree_33              ; // :=  final_score_tree_33;
                    Real   final_score_tree_34              ; // :=  final_score_tree_34;
                    Real   final_score_tree_35              ; // :=  final_score_tree_35;
                    Real   final_score_tree_36              ; // :=  final_score_tree_36;
                    Real   final_score_tree_37              ; // :=  final_score_tree_37;
                    Real   final_score_tree_38              ; // :=  final_score_tree_38;
                    Real   final_score_tree_39              ; // :=  final_score_tree_39;
                    Real   final_score_tree_40              ; // :=  final_score_tree_40;
                    Real   final_score_tree_41              ; // :=  final_score_tree_41;
                    Real   final_score_tree_42              ; // :=  final_score_tree_42;
                    Real   final_score_tree_43              ; // :=  final_score_tree_43;
                    Real   final_score_tree_44              ; // :=  final_score_tree_44;
                    Real   final_score_tree_45              ; // :=  final_score_tree_45;
                    Real   final_score_tree_46              ; // :=  final_score_tree_46;
                    Real   final_score_tree_47              ; // :=  final_score_tree_47;
                    Real   final_score_tree_48              ; // :=  final_score_tree_48;
                    Real   final_score_tree_49              ; // :=  final_score_tree_49;
                    Real   final_score_tree_50              ; // :=  final_score_tree_50;
                    Real   final_score_tree_51              ; // :=  final_score_tree_51;
                    Real   final_score_tree_52              ; // :=  final_score_tree_52;
                    Real   final_score_tree_53              ; // :=  final_score_tree_53;
                    Real   final_score_tree_54              ; // :=  final_score_tree_54;
                    Real   final_score_tree_55              ; // :=  final_score_tree_55;
                    Real   final_score_gbm_logit            ; // :=  final_score_gbm_logit;
                    Real   pbr                              ; // :=  pbr;
                    Real   sbr                              ; // :=  sbr;
                    Integer base                             ; // :=  base;
                    Integer pts                              ; // :=  pts;
                    Real   lgt                              ; // :=  lgt;
                    Real   offset                           ; // :=  offset;
                    Integer fp1508_1_0                       ; // :=  fp1508_1_0;
                    boolean _ver_src_ds                      ; // :=  _ver_src_ds;
                    boolean _ver_src_de                      ; // :=  _ver_src_de;
                    boolean _derog                           ; // :=  _derog;
                    boolean _deceased                        ; // :=  _deceased;
                    boolean _ssnpriortodob                   ; // :=  _ssnpriortodob;
                    boolean _inputmiskeys                    ; // :=  _inputmiskeys;
                    boolean _multiplessns                    ; // :=  _multiplessns;
                    Integer _hh_strikes                      ; // :=  _hh_strikes;
                    Integer stolenid                         ; // :=  stolenid;
                    Integer manipulatedid                    ; // :=  manipulatedid;
                    Integer manipulatedidpt2                 ; // :=  manipulatedidpt2;
                    Integer _sum_bureau                      ; // :=  _sum_bureau;
                    Integer _sum_credentialed                ; // :=  _sum_credentialed;
                    boolean syntheticid                      ; // :=  syntheticid;
                    Integer suspiciousactivity               ; // :=  suspiciousactivity;
                    Integer vulnerablevictim                 ; // :=  vulnerablevictim;
                    Integer friendlyfraud                    ; // :=  friendlyfraud;
                    Integer stolenc_fp1508_1_0               ; // :=  stolenc_fp1508_1_0;
                    Integer manip2c_fp1508_1_0               ; // :=  manip2c_fp1508_1_0;
                    Integer synthc_fp1508_1_0                ; // :=  synthc_fp1508_1_0;
                    Integer suspactc_fp1508_1_0              ; // :=  suspactc_fp1508_1_0;
                    Integer vulnvicc_fp1508_1_0              ; // :=  vulnvicc_fp1508_1_0;
                    Integer friendlyc_fp1508_1_0             ; // :=  friendlyc_fp1508_1_0;
                    Integer fp1508_1_0_stolidindex           ; // :=  fp1508_1_0_stolidindex;
                    Integer fp1508_1_0_synthidindex          ; // :=  fp1508_1_0_synthidindex;
                    Integer fp1508_1_0_manipidindex          ; // :=  fp1508_1_0_manipidindex;
                    Integer fp1508_1_0_vulnvicindex          ; // :=  fp1508_1_0_vulnvicindex;
                    Integer fp1508_1_0_friendfrdindex        ; // :=  fp1508_1_0_friendfrdindex;
                    Integer fp1508_1_0_suspactindex          ; // :=  fp1508_1_0_suspactindex;
                    // Integer	 custstolidindex;
                    // Integer	 custmanipidindex;
                    // Integer	 custsynthidindex;
                    // Integer	 custsuspactindex;
                    // Integer	 custvulnvicindex;
                    // Integer	 custfriendfrdindex;

			models.layouts.layout_fp1109;
			Risk_Indicators.Layout_Boca_Shell clam;
			END;
			
    layout_debug doModel( clam le) := TRANSFORM
  #else
    models.layouts.layout_fp1109 doModel( clam le ) := TRANSFORM
		
  #end	

	/* ***********************************************************
	 *             Model Input Variable Assignments              *
	 ************************************************************* */
	best_ssn_valid                   := le.best_flags.best_ssn_valid;
	adls_per_bestssn                 := le.best_flags.adls_per_bestssn;
	inq_phonesperadl_count01         := le.acc_logs.inq_phonesperadl_count01;//new shell 5.2 additions risk_indicators.layouts.layout_inquiries_53
	inq_phonesperadl_count03         := le.acc_logs.inq_phonesperadl_count03;//new shell 5.2 additions risk_indicators.layouts.layout_inquiries_53
	inq_phonesperadl_count06         := le.acc_logs.inq_phonesperadl_count06;//new shell 5.2 additions risk_indicators.layouts.layout_inquiries_53
	inq_perphone_count01             := le.acc_logs.inq_perphone_count01;
	inq_perphone_count03             := le.acc_logs.inq_perphone_count03;
	inq_perphone_count06             := le.acc_logs.inq_perphone_count06;
	inq_perssn_count_week            := le.acc_logs.inq_perssn_count_week;
	inq_dobsperssn_count01           := le.acc_logs.inq_dobsperssn_count01;
	inq_dobsperssn_count03           := le.acc_logs.inq_dobsperssn_count03;
	inq_dobsperssn_count06           := le.acc_logs.inq_dobsperssn_count06;
	inq_bestssn_ver_count            := le.best_flags.inq_bestssn_ver_count;
	inq_fnamesperadl_count01         := le.acc_logs.inq_fnamesperadl_count01;
	inq_fnamesperadl_count03         := le.acc_logs.inq_fnamesperadl_count03;
	inq_fnamesperadl_count06         := le.acc_logs.inq_fnamesperadl_count06;
	addrs_per_bestssn                := le.best_flags.addrs_per_bestssn;
	inq_percurraddr                  := le.best_flags.inq_percurraddr;
	inq_addrsperssn_count01          := le.acc_logs.inq_addrsperssn_count01;
	inq_addrsperssn_count03          := le.acc_logs.inq_addrsperssn_count03;
	inq_addrsperssn_count06          := le.acc_logs.inq_addrsperssn_count06;
	inq_addrsperadl_count01          := le.acc_logs.inq_addrsperadl_count01;
	inq_addrsperadl_count03          := le.acc_logs.inq_addrsperadl_count03;
	inq_addrsperadl_count06          := le.acc_logs.inq_addrsperadl_count06;
	input_phone_isbestmatch          := le.best_flags.input_phone_isbestmatch;
	inq_adlsperbestphone             := le.best_flags.inq_adlsperbestphone;
	adls_per_curraddr_curr           := le.best_flags.adls_per_curraddr_curr;
 //----- 
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
	rc_hriskphoneflag                := le.iid.hriskphoneflag;
	rc_hphonetypeflag                := le.iid.hphonetypeflag;
	rc_phonevalflag                  := le.iid.phonevalflag;
	rc_hphonevalflag                 := le.iid.hphonevalflag;
	rc_hriskaddrflag                 := le.iid.hriskaddrflag;
	rc_decsflag                      := le.iid.decsflag;
	rc_ssndobflag                    := le.iid.socsdobflag;
	rc_pwssndobflag                  := le.iid.pwsocsdobflag;
	rc_ssnlowissue                   := (unsigned)le.iid.socllowissue;
	rc_ssnhighissue                  := (unsigned)le.iid.soclhighissue;
	rc_addrvalflag                   := le.iid.addrvalflag;
	rc_dwelltype                     := le.iid.dwelltype;
	rc_addrcount                     := le.iid.addrcount;
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
	hdr_source_profile_index         := le.source_profile_index;
	ver_sources                      := le.header_summary.ver_sources;
	ver_sources_first_seen           := le.header_summary.ver_sources_first_seen_date;
	ver_sources_last_seen            := le.header_summary.ver_sources_last_seen_date;
	ver_sources_count                := le.header_summary.ver_sources_recordcount;
	ver_fname_sources                := le.header_summary.ver_fname_sources;
	ver_lname_sources                := le.header_summary.ver_lname_sources;
	ver_addr_sources                 := le.header_summary.ver_addr_sources;
	ver_ssn_sources                  := le.header_summary.ver_ssn_sources;
	ver_dob_sources                  := le.header_summary.ver_dob_sources;
	dl_avail                         := le.available_sources.dl;
	voter_avail                      := le.available_sources.voter;
	fnamepop                         := le.input_validation.firstname;
	lnamepop                         := le.input_validation.lastname;
	addrpop                          := le.input_validation.address;
	ssnlength                        := le.input_validation.ssn_length;
	dobpop                           := le.input_validation.dateofbirth;
	emailpop                         := le.input_validation.email;
	hphnpop                          := le.input_validation.homephone;
	util_adl_type_list               := le.utility.utili_adl_type;
	util_add_input_type_list         := le.utility.utili_addr1_type;
	add_input_house_number_match     := le.address_verification.input_address_information.house_number_match;
	add_input_isbestmatch            := le.address_verification.input_address_information.isbestmatch;
	add_input_advo_vacancy           := le.advo_input_addr.Address_Vacancy_Indicator;
	add_input_advo_res_or_bus        := le.advo_input_addr.Residential_or_Business_Ind;
	add_input_source_count           := le.address_verification.input_address_information.source_count;
	add_input_naprop                 := le.address_verification.input_address_information.naprop;
	add_input_pop                    := le.addrPop;
	property_owned_total             := le.address_verification.owned.property_total;
	add_dist_input_to_curr           := le.address_verification.distance_in_2_h1;
	add_curr_naprop                  := le.address_verification.address_history_1.naprop;
	add_curr_pop                     := le.addrPop2;
	add_prev_lres                    := le.lres3;
	add_prev_naprop                  := le.address_verification.address_history_2.naprop;
	add_prev_pop                     := le.addrPop3;
	avg_lres                         := le.other_address_info.avg_lres;
	addrs_5yr                        := le.other_address_info.addrs_last_5years;
	addrs_10yr                       := le.other_address_info.addrs_last_10years;
	addrs_15yr                       := le.other_address_info.addrs_last_15years;
	addrs_prison_history             := le.other_address_info.isprison;
	telcordia_type                   := le.phone_verification.telcordia_type;
	phone_ver_insurance              := le.insurance_phones_summary.Insurance_Phone_Verification;
	phone_ver_experian               := le.Experian_Phone_Verification;
	ssns_per_adl                     := le.velocity_counters.ssns_per_adl;
	addrs_per_adl                    := le.velocity_counters.addrs_per_adl;
	adls_per_ssn                     := le.SSN_Verification.adlPerSSN_count;
	addrs_per_ssn                    := if(isFCRA, 0, le.velocity_counters.addrs_per_ssn );
	adls_per_addr_curr               := le.velocity_counters.adls_per_addr_current;
	ssns_per_addr_curr               := le.velocity_counters.ssns_per_addr_current;
	phones_per_addr_curr             := le.velocity_counters.phones_per_addr_current;
	ssns_per_adl_c6                  := le.velocity_counters.ssns_per_adl_created_6months;
	//lnames_per_adl_c6                := if(isFCRA, 0, le.velocity_counters.lnames_per_adl)_created_6months;
	lnames_per_adl_c6                := if(isFCRA, 0, le.velocity_counters.lnames_per_adl180);
	dl_addrs_per_adl                 := le.velocity_counters.dl_addrs_per_adl;
	invalid_ssns_per_adl             := le.velocity_counters.invalid_ssns_per_adl;
	invalid_addrs_per_adl            := le.velocity_counters.invalid_addrs_per_adl;
	inq_addr_ver_count               := le.acc_logs.inquiry_addr_ver_ct;
	inq_fname_ver_count              := le.acc_logs.inquiry_fname_ver_ct;
	inq_lname_ver_count              := le.acc_logs.inquiry_lname_ver_ct;
	inq_ssn_ver_count                := le.acc_logs.inquiry_ssn_ver_ct;
	inq_dob_ver_count                := le.acc_logs.inquiry_dob_ver_ct;
	inq_phone_ver_count              := le.acc_logs.inquiry_phone_ver_ct;
	inq_count03                      := le.acc_logs.inquiries.count03;
	inq_auto_count                   := le.acc_logs.auto.counttotal;
	inq_auto_count01                 := le.acc_logs.auto.count01;
	inq_auto_count03                 := le.acc_logs.auto.count03;
	inq_auto_count06                 := le.acc_logs.auto.count06;
	inq_auto_count12                 := le.acc_logs.auto.count12;
	inq_auto_count24                 := le.acc_logs.auto.count24;
	inq_collection_count             := le.acc_logs.collection.counttotal;
	inq_collection_count01           := le.acc_logs.collection.count01;
	inq_collection_count03           := le.acc_logs.collection.count03;
	inq_collection_count06           := le.acc_logs.collection.count06;
	inq_collection_count12           := le.acc_logs.collection.count12;
	inq_collection_count24           := le.acc_logs.collection.count24;
	inq_highriskcredit_count12       := le.acc_logs.highriskcredit.count12;
	inq_other_count                  := le.acc_logs.other.counttotal;
	inq_other_count01                := le.acc_logs.other.count01;
	inq_other_count03                := le.acc_logs.other.count03;
	inq_other_count06                := le.acc_logs.other.count06;
	inq_other_count12                := le.acc_logs.other.count12;
	inq_other_count24                := le.acc_logs.other.count24;
	inq_addrsperadl                  := le.acc_logs.inquiryaddrsperadl;
	inq_fnamesperadl                 := le.acc_logs.inquiryfnamesperadl;
	inq_phonesperadl                 := le.acc_logs.inquiryphonesperadl;
	inq_perssn                       := if(isFCRA, 0, le.acc_logs.inquiryPerSSN );
	inq_addrsperssn                  := if(isFCRA, 0, le.acc_logs.inquiryAddrsPerSSN );
	inq_dobsperssn                   := if(isFCRA, 0, le.acc_logs.inquiryDOBsPerSSN );
	inq_peraddr                      := if(isFCRA, 0, le.acc_logs.inquiryPerAddr );
	inq_perphone                     := if(isFCRA, 0, le.acc_logs.inquiryPerPhone );
	inq_adlsperphone                 := if(isFCRA, 0, le.acc_logs.inquiryADLsPerPhone );
	br_dead_business_count           := le.employment.dead_business_ct;
	br_active_phone_count            := le.employment.business_active_phone_ct;
	infutor_nap                      := le.infutor_phone.infutor_nap;
	stl_inq_count                    := le.impulse.count;
	stl_inq_count24                  := le.impulse.count24;
	email_count                      := le.email_summary.email_ct;
	email_verification               := le.email_summary.identity_email_verification_level;
	email_name_addr_verification     := le.email_summary.reverse_email.verification_level;
	adl_per_email                    := le.email_summary.reverse_email.adls_per_email;
	attr_addrs_last30                := le.other_address_info.addrs_last30;
	attr_addrs_last90                := le.other_address_info.addrs_last90;
	attr_addrs_last12                := le.other_address_info.addrs_last12;
	attr_addrs_last24                := le.other_address_info.addrs_last24;
	attr_addrs_last36                := le.other_address_info.addrs_last36;
	attr_num_unrel_liens60           := le.bjl.liens_unreleased_count60;
	attr_eviction_count              := le.bjl.eviction_count;
	fp_idveraddressnotcurrent        := le.fdattributesv2.idveraddressnotcurrent;
	fp_srchunvrfdssncount            := le.fdattributesv2.searchunverifiedssncountyear;
	fp_srchunvrfdaddrcount           := le.fdattributesv2.searchunverifiedaddrcountyear;
	fp_srchunvrfddobcount            := le.fdattributesv2.searchunverifieddobcountyear;
	fp_srchunvrfdphonecount          := le.fdattributesv2.searchunverifiedphonecountyear;
	fp_validationrisktype            := le.fdattributesv2.validationrisklevel;
	bk_dismissed_recent_count        := le.bjl.bk_dismissed_recent_count;
	bk_dismissed_historical_count    := le.bjl.bk_dismissed_historical_count;
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
	felony_count                     := le.bjl.felony_count;
	hh_members_ct                    := le.hhid_summary.hh_members_ct;
	hh_payday_loan_users             := le.hhid_summary.hh_payday_loan_users;
	hh_members_w_derog               := le.hhid_summary.hh_members_w_derog;
	hh_criminals                     := le.hhid_summary.hh_criminals;
	rel_felony_count                 := le.relatives.relative_felony_count;
	current_count                    := le.vehicles.current_count;
	historical_count                 := le.vehicles.historical_count;
	acc_damage_amt_total             := le.accident_data.acc.dmgamtaccidents;
	acc_damage_amt_last              := le.accident_data.acc.dmgamtlastaccident;
	college_date_first_seen          := (unsigned)le.student.date_first_seen;
	college_major                    := le.student.college_major;
	input_dob_match_level            := le.dobmatchlevel;
	inferred_age                     := le.inferred_age;


	/* ***********************************************************
	 *   Generated ECL         *
	 ************************************************************* */

NULL := -999999999;
INTEGER contains_i( string haystack, string needle ) :=(INTEGER)(StringLib.StringFind(haystack, needle, 1) > 0);

sysdate := common.sas_date(if(le.historydate=999999, (string)risk_indicators.iid_constants.TodayDate, (string6)le.historydate+'01'));

ver_src_ak_pos := Models.Common.findw_cpp(ver_sources, 'AK' , '  ,', 'ie');

_ver_src_fdate_ak := if(ver_src_ak_pos > 0, Models.Common.getw(ver_sources_first_seen, ver_src_ak_pos), '0');

ver_src_fdate_ak := common.sas_date((string)(_ver_src_fdate_ak));

ver_src_am_pos := Models.Common.findw_cpp(ver_sources, 'AM' , '  ,', 'ie');

ver_src_am := ver_src_am_pos > 0;

_ver_src_fdate_am := if(ver_src_am_pos > 0, Models.Common.getw(ver_sources_first_seen, ver_src_am_pos), '0');

ver_src_fdate_am := common.sas_date((string)(_ver_src_fdate_am));

ver_src_ar_pos := Models.Common.findw_cpp(ver_sources, 'AR' , '  ,', 'ie');

ver_src_ar := ver_src_ar_pos > 0;

_ver_src_fdate_ar := if(ver_src_ar_pos > 0, Models.Common.getw(ver_sources_first_seen, ver_src_ar_pos), '0');

ver_src_fdate_ar := common.sas_date((string)(_ver_src_fdate_ar));

ver_src_ba_pos := Models.Common.findw_cpp(ver_sources, 'BA' , '  ,', 'ie');

ver_src_ba := ver_src_ba_pos > 0;

_ver_src_fdate_ba := if(ver_src_ba_pos > 0, Models.Common.getw(ver_sources_first_seen, ver_src_ba_pos), '0');

ver_src_fdate_ba := common.sas_date((string)(_ver_src_fdate_ba));

ver_src_cg_pos := Models.Common.findw_cpp(ver_sources, 'CG' , '  ,', 'ie');

ver_src_cg := ver_src_cg_pos > 0;

_ver_src_fdate_cg := if(ver_src_cg_pos > 0, Models.Common.getw(ver_sources_first_seen, ver_src_cg_pos), '0');

ver_src_fdate_cg := common.sas_date((string)(_ver_src_fdate_cg));

ver_src_co_pos := Models.Common.findw_cpp(ver_sources, 'CO' , '  ,', 'ie');

_ver_src_fdate_co := if(ver_src_co_pos > 0, Models.Common.getw(ver_sources_first_seen, ver_src_co_pos), '0');

ver_src_fdate_co := common.sas_date((string)(_ver_src_fdate_co));

ver_src_cy_pos := Models.Common.findw_cpp(ver_sources, 'CY' , '  ,', 'ie');

_ver_src_fdate_cy := if(ver_src_cy_pos > 0, Models.Common.getw(ver_sources_first_seen, ver_src_cy_pos), '0');

ver_src_fdate_cy := common.sas_date((string)(_ver_src_fdate_cy));

ver_src_da_pos := Models.Common.findw_cpp(ver_sources, 'DA' , '  ,', 'ie');

ver_src_da := ver_src_da_pos > 0;

_ver_src_fdate_da := if(ver_src_da_pos > 0, Models.Common.getw(ver_sources_first_seen, ver_src_da_pos), '0');

ver_src_fdate_da := common.sas_date((string)(_ver_src_fdate_da));

ver_src_d_pos := Models.Common.findw_cpp(ver_sources, 'D' , '  ,', 'ie');

ver_src_d := ver_src_d_pos > 0;

_ver_src_fdate_d := if(ver_src_d_pos > 0, Models.Common.getw(ver_sources_first_seen, ver_src_d_pos), '0');

ver_src_fdate_d := common.sas_date((string)(_ver_src_fdate_d));

ver_src_dl_pos := Models.Common.findw_cpp(ver_sources, 'DL' , '  ,', 'ie');

ver_src_dl := ver_src_dl_pos > 0;

_ver_src_fdate_dl := if(ver_src_dl_pos > 0, Models.Common.getw(ver_sources_first_seen, ver_src_dl_pos), '0');

ver_src_fdate_dl := common.sas_date((string)(_ver_src_fdate_dl));

ver_src_ds_pos := Models.Common.findw_cpp(ver_sources, 'DS' , '  ,', 'ie');

_ver_src_fdate_ds := if(ver_src_ds_pos > 0, Models.Common.getw(ver_sources_first_seen, ver_src_ds_pos), '0');

ver_src_fdate_ds := common.sas_date((string)(_ver_src_fdate_ds));

ver_src_de_pos := Models.Common.findw_cpp(ver_sources, 'DE' , '  ,', 'ie');

_ver_src_fdate_de := if(ver_src_de_pos > 0, Models.Common.getw(ver_sources_first_seen, ver_src_de_pos), '0');

ver_src_fdate_de := common.sas_date((string)(_ver_src_fdate_de));

ver_src_eb_pos := Models.Common.findw_cpp(ver_sources, 'EB' , '  ,', 'ie');

ver_src_eb := ver_src_eb_pos > 0;

_ver_src_fdate_eb := if(ver_src_eb_pos > 0, Models.Common.getw(ver_sources_first_seen, ver_src_eb_pos), '0');

ver_src_fdate_eb := common.sas_date((string)(_ver_src_fdate_eb));

ver_src_em_pos := Models.Common.findw_cpp(ver_sources, 'EM' , '  ,', 'ie');

_ver_src_fdate_em := if(ver_src_em_pos > 0, Models.Common.getw(ver_sources_first_seen, ver_src_em_pos), '0');

ver_src_fdate_em := common.sas_date((string)(_ver_src_fdate_em));

ver_src_e1_pos := Models.Common.findw_cpp(ver_sources, 'E1' , '  ,', 'ie');

ver_src_e1 := ver_src_e1_pos > 0;

_ver_src_fdate_e1 := if(ver_src_e1_pos > 0, Models.Common.getw(ver_sources_first_seen, ver_src_e1_pos), '0');

ver_src_fdate_e1 := common.sas_date((string)(_ver_src_fdate_e1));

ver_src_e2_pos := Models.Common.findw_cpp(ver_sources, 'E2' , '  ,', 'ie');

ver_src_e2 := ver_src_e2_pos > 0;

_ver_src_fdate_e2 := if(ver_src_e2_pos > 0, Models.Common.getw(ver_sources_first_seen, ver_src_e2_pos), '0');

ver_src_fdate_e2 := common.sas_date((string)(_ver_src_fdate_e2));

ver_src_e3_pos := Models.Common.findw_cpp(ver_sources, 'E3' , '  ,', 'ie');

ver_src_e3 := ver_src_e3_pos > 0;

_ver_src_fdate_e3 := if(ver_src_e3_pos > 0, Models.Common.getw(ver_sources_first_seen, ver_src_e3_pos), '0');

ver_src_fdate_e3 := common.sas_date((string)(_ver_src_fdate_e3));

ver_src_e4_pos := Models.Common.findw_cpp(ver_sources, 'E4' , '  ,', 'ie');

_ver_src_fdate_e4 := if(ver_src_e4_pos > 0, Models.Common.getw(ver_sources_first_seen, ver_src_e4_pos), '0');

ver_src_fdate_e4 := common.sas_date((string)(_ver_src_fdate_e4));

ver_src_en_pos := Models.Common.findw_cpp(ver_sources, 'EN' , '  ,', 'ie');

ver_src_en := ver_src_en_pos > 0;

_ver_src_fdate_en := if(ver_src_en_pos > 0, Models.Common.getw(ver_sources_first_seen, ver_src_en_pos), '0');

ver_src_fdate_en := common.sas_date((string)(_ver_src_fdate_en));

ver_src_eq_pos := Models.Common.findw_cpp(ver_sources, 'EQ' , '  ,', 'ie');

ver_src_eq := ver_src_eq_pos > 0;

_ver_src_fdate_eq := if(ver_src_eq_pos > 0, Models.Common.getw(ver_sources_first_seen, ver_src_eq_pos), '0');

ver_src_fdate_eq := common.sas_date((string)(_ver_src_fdate_eq));

ver_src_fe_pos := Models.Common.findw_cpp(ver_sources, 'FE' , '  ,', 'ie');

ver_src_fe := ver_src_fe_pos > 0;

_ver_src_fdate_fe := if(ver_src_fe_pos > 0, Models.Common.getw(ver_sources_first_seen, ver_src_fe_pos), '0');

ver_src_fdate_fe := common.sas_date((string)(_ver_src_fdate_fe));

ver_src_ff_pos := Models.Common.findw_cpp(ver_sources, 'FF' , '  ,', 'ie');

ver_src_ff := ver_src_ff_pos > 0;

_ver_src_fdate_ff := if(ver_src_ff_pos > 0, Models.Common.getw(ver_sources_first_seen, ver_src_ff_pos), '0');

ver_src_fdate_ff := common.sas_date((string)(_ver_src_fdate_ff));

ver_src_fr_pos := Models.Common.findw_cpp(ver_sources, 'FR' , '  ,', 'ie');

_ver_src_fdate_fr := if(ver_src_fr_pos > 0, Models.Common.getw(ver_sources_first_seen, ver_src_fr_pos), '0');

ver_src_fdate_fr := common.sas_date((string)(_ver_src_fdate_fr));

ver_src_l2_pos := Models.Common.findw_cpp(ver_sources, 'L2' , '  ,', 'ie');

_ver_src_fdate_l2 := if(ver_src_l2_pos > 0, Models.Common.getw(ver_sources_first_seen, ver_src_l2_pos), '0');

ver_src_fdate_l2 := common.sas_date((string)(_ver_src_fdate_l2));

ver_src_li_pos := Models.Common.findw_cpp(ver_sources, 'LI' , '  ,', 'ie');

_ver_src_fdate_li := if(ver_src_li_pos > 0, Models.Common.getw(ver_sources_first_seen, ver_src_li_pos), '0');

ver_src_fdate_li := common.sas_date((string)(_ver_src_fdate_li));

ver_src_mw_pos := Models.Common.findw_cpp(ver_sources, 'MW' , '  ,', 'ie');

_ver_src_fdate_mw := if(ver_src_mw_pos > 0, Models.Common.getw(ver_sources_first_seen, ver_src_mw_pos), '0');

ver_src_fdate_mw := common.sas_date((string)(_ver_src_fdate_mw));

ver_src_nt_pos := Models.Common.findw_cpp(ver_sources, 'NT' , '  ,', 'ie');

_ver_src_fdate_nt := if(ver_src_nt_pos > 0, Models.Common.getw(ver_sources_first_seen, ver_src_nt_pos), '0');

ver_src_fdate_nt := common.sas_date((string)(_ver_src_fdate_nt));

ver_src_p_pos := Models.Common.findw_cpp(ver_sources, 'P' , '  ,', 'ie');

ver_src_p := ver_src_p_pos > 0;

_ver_src_fdate_p := if(ver_src_p_pos > 0, Models.Common.getw(ver_sources_first_seen, ver_src_p_pos), '0');

ver_src_fdate_p := common.sas_date((string)(_ver_src_fdate_p));

ver_src_pl_pos := Models.Common.findw_cpp(ver_sources, 'PL' , '  ,', 'ie');

ver_src_pl := ver_src_pl_pos > 0;

_ver_src_fdate_pl := if(ver_src_pl_pos > 0, Models.Common.getw(ver_sources_first_seen, ver_src_pl_pos), '0');

ver_src_fdate_pl := common.sas_date((string)(_ver_src_fdate_pl));

ver_src_tn_pos := Models.Common.findw_cpp(ver_sources, 'TN' , '  ,', 'ie');

ver_src_tn := ver_src_tn_pos > 0;

_ver_src_fdate_tn := if(ver_src_tn_pos > 0, Models.Common.getw(ver_sources_first_seen, ver_src_tn_pos), '0');

ver_src_fdate_tn := common.sas_date((string)(_ver_src_fdate_tn));

ver_src_ts_pos := Models.Common.findw_cpp(ver_sources, 'TS' , '  ,', 'ie');

_ver_src_fdate_ts := if(ver_src_ts_pos > 0, Models.Common.getw(ver_sources_first_seen, ver_src_ts_pos), '0');

ver_src_fdate_ts := common.sas_date((string)(_ver_src_fdate_ts));

ver_src_tu_pos := Models.Common.findw_cpp(ver_sources, 'TU' , '  ,', 'ie');

_ver_src_fdate_tu := if(ver_src_tu_pos > 0, Models.Common.getw(ver_sources_first_seen, ver_src_tu_pos), '0');

ver_src_fdate_tu := common.sas_date((string)(_ver_src_fdate_tu));

ver_src_sl_pos := Models.Common.findw_cpp(ver_sources, 'SL' , '  ,', 'ie');

ver_src_sl := ver_src_sl_pos > 0;

_ver_src_fdate_sl := if(ver_src_sl_pos > 0, Models.Common.getw(ver_sources_first_seen, ver_src_sl_pos), '0');

ver_src_fdate_sl := common.sas_date((string)(_ver_src_fdate_sl));

ver_src_v_pos := Models.Common.findw_cpp(ver_sources, 'V' , '  ,', 'ie');

ver_src_v := ver_src_v_pos > 0;

_ver_src_fdate_v := if(ver_src_v_pos > 0, Models.Common.getw(ver_sources_first_seen, ver_src_v_pos), '0');

ver_src_fdate_v := common.sas_date((string)(_ver_src_fdate_v));

ver_src_vo_pos := Models.Common.findw_cpp(ver_sources, 'VO' , '  ,', 'ie');

ver_src_vo := ver_src_vo_pos > 0;

_ver_src_fdate_vo := if(ver_src_vo_pos > 0, Models.Common.getw(ver_sources_first_seen, ver_src_vo_pos), '0');

ver_src_fdate_vo := common.sas_date((string)(_ver_src_fdate_vo));

ver_src_w_pos := Models.Common.findw_cpp(ver_sources, 'W' , '  ,', 'ie');

ver_src_w := ver_src_w_pos > 0;

_ver_src_fdate_w := if(ver_src_w_pos > 0, Models.Common.getw(ver_sources_first_seen, ver_src_w_pos), '0');

ver_src_fdate_w := common.sas_date((string)(_ver_src_fdate_w));

ver_src_wp_pos := Models.Common.findw_cpp(ver_sources, 'WP' , '  ,', 'ie');

_ver_src_fdate_wp := if(ver_src_wp_pos > 0, Models.Common.getw(ver_sources_first_seen, ver_src_wp_pos), '0');

ver_src_fdate_wp := common.sas_date((string)(_ver_src_fdate_wp));

ver_fname_src_en_pos := Models.Common.findw_cpp(ver_fname_sources, 'EN' , '  ,', 'ie');

ver_fname_src_en := ver_fname_src_en_pos > 0;

ver_fname_src_eq_pos := Models.Common.findw_cpp(ver_fname_sources, 'EQ' , '  ,', 'ie');

ver_fname_src_eq := ver_fname_src_eq_pos > 0;

ver_fname_src_tn_pos := Models.Common.findw_cpp(ver_fname_sources, 'TN' , '  ,', 'ie');

ver_fname_src_tn := ver_fname_src_tn_pos > 0;

ver_lname_src_en_pos := Models.Common.findw_cpp(ver_lname_sources, 'EN' , '  ,', 'ie');

ver_lname_src_en := ver_lname_src_en_pos > 0;

ver_lname_src_eq_pos := Models.Common.findw_cpp(ver_lname_sources, 'EQ' , '  ,', 'ie');

ver_lname_src_eq := ver_lname_src_eq_pos > 0;

ver_lname_src_tn_pos := Models.Common.findw_cpp(ver_lname_sources, 'TN' , '  ,', 'ie');

ver_lname_src_tn := ver_lname_src_tn_pos > 0;

ver_addr_src_en_pos := Models.Common.findw_cpp(ver_addr_sources, 'EN' , '  ,', 'ie');

ver_addr_src_en := ver_addr_src_en_pos > 0;

ver_addr_src_eq_pos := Models.Common.findw_cpp(ver_addr_sources, 'EQ' , '  ,', 'ie');

ver_addr_src_eq := ver_addr_src_eq_pos > 0;

ver_addr_src_tn_pos := Models.Common.findw_cpp(ver_addr_sources, 'TN' , '  ,', 'ie');

ver_addr_src_tn := ver_addr_src_tn_pos > 0;

ver_ssn_src_en_pos := Models.Common.findw_cpp(ver_ssn_sources, 'EN' , '  ,', 'ie');

ver_ssn_src_en := ver_ssn_src_en_pos > 0;

ver_ssn_src_eq_pos := Models.Common.findw_cpp(ver_ssn_sources, 'EQ' , '  ,', 'ie');

ver_ssn_src_eq := ver_ssn_src_eq_pos > 0;

ver_ssn_src_tn_pos := Models.Common.findw_cpp(ver_ssn_sources, 'TN' , '  ,', 'ie');

ver_ssn_src_tn := ver_ssn_src_tn_pos > 0;

ver_dob_src_en_pos := Models.Common.findw_cpp(ver_dob_sources, 'EN' , '  ,', 'ie');

ver_dob_src_en := ver_dob_src_en_pos > 0;

ver_dob_src_eq_pos := Models.Common.findw_cpp(ver_dob_sources, 'EQ' , '  ,', 'ie');

ver_dob_src_eq := ver_dob_src_eq_pos > 0;

ver_dob_src_tn_pos := Models.Common.findw_cpp(ver_dob_sources, 'TN' , '  ,', 'ie');

ver_dob_src_tn := ver_dob_src_tn_pos > 0;

util_type_2_pos := Models.Common.findw_cpp(util_adl_type_list, '2' , '  ,', 'ie');

util_type_2 := util_type_2_pos > 0;

util_type_1_pos := Models.Common.findw_cpp(util_adl_type_list, '1' , '  ,', 'ie');

util_type_1 := util_type_1_pos > 0;

util_type_z_pos := Models.Common.findw_cpp(util_adl_type_list, 'Z' , '  ,', 'ie');

util_type_z := util_type_z_pos > 0;

util_inp_2_pos := Models.Common.findw_cpp(util_add_input_type_list, '2' , '  ,', 'ie');

util_inp_2 := util_inp_2_pos > 0;

util_inp_1_pos := Models.Common.findw_cpp(util_add_input_type_list, '1' , ' ,', 'ie');

//util_inp_1 := util_inp_1_pos > NULL;
util_inp_1 := util_inp_1_pos > 0;

util_inp_z_pos := Models.Common.findw_cpp(util_add_input_type_list, 'Z' , ' ,', 'ie');

util_inp_z := util_inp_z_pos > 0;




iv_add_apt := if(StringLib.StringToUpperCase(trim(rc_dwelltype, LEFT, RIGHT)) = 'A' or StringLib.StringToUpperCase(trim(out_addr_type, LEFT, RIGHT)) = 'H' or not(out_unit_desig = '') or not(out_sec_range = ''), '1', '0');

nf_email_name_addr_ver := if(not(emailpop), NULL, (integer)email_name_addr_verification);

_rc_ssnhighissue := common.sas_date((string)(rc_ssnhighissue));

nf_m_snc_ssn_high_issue := map(
    not(ssnlength > '0')      => NULL,
    _rc_ssnhighissue = NULL => -1,
                               min(if(if ((sysdate - _rc_ssnhighissue) / (365.25 / 12) >= 0, truncate((sysdate - _rc_ssnhighissue) / (365.25 / 12)), roundup((sysdate - _rc_ssnhighissue) / (365.25 / 12))) = NULL, -NULL, if ((sysdate - _rc_ssnhighissue) / (365.25 / 12) >= 0, truncate((sysdate - _rc_ssnhighissue) / (365.25 / 12)), roundup((sysdate - _rc_ssnhighissue) / (365.25 / 12)))), 999));

iv_nap_inf_phone_ver_lvl := map(
    (nap_summary in [4, 6, 7, 9, 10, 11, 12]) and (infutor_nap in [4, 6, 7, 9, 10, 11, 12]) => 3,
    (nap_summary in [4, 6, 7, 9, 10, 11, 12])                                               => 2,
    (infutor_nap in [4, 6, 7, 9, 10, 11, 12])                                               => 1,
                                                                                               0);

nf_inquiry_verification_index := if(not(truedid), NULL, 
                                if(max( (integer)(max((integer)(inq_fname_ver_count < 255), 
                               (integer)(inq_lname_ver_count < 255)) > 0), 
                                2*(integer)(0 < inq_phone_ver_count AND inq_phone_ver_count < 255),
                                4*(integer)(0 < inq_addr_ver_count AND inq_addr_ver_count < 255), 
                                8*(integer)(0 < inq_dob_ver_count AND inq_dob_ver_count < 255), 
                                16*(integer)(0 < inq_ssn_ver_count AND inq_ssn_ver_count < 255)) = NULL, NULL,
                                sum(if((integer)(max((integer)(inq_fname_ver_count < 255), 
                                    (integer)(inq_lname_ver_count < 255)) > 0) = NULL, 0,   
                                    (integer)(max((integer)(inq_fname_ver_count < 255), 
                                    (integer)(inq_lname_ver_count < 255)) > 0)), 
                                    if(2*(integer)(0 < inq_phone_ver_count AND inq_phone_ver_count < 255) = NULL, 0,
                                       2*(integer)(0 < inq_phone_ver_count AND inq_phone_ver_count < 255)), 
                                    if(4*(integer)(0 < inq_addr_ver_count AND inq_addr_ver_count < 255) = NULL, 0, 
                                       4*(integer)(0 < inq_addr_ver_count AND inq_addr_ver_count < 255)), 
                                    if(8*(integer)(0 < inq_dob_ver_count AND inq_dob_ver_count < 255) = NULL, 0,
                                       8*(integer)(0 < inq_dob_ver_count AND inq_dob_ver_count < 255)), 
                                    if(16*(integer)(0 < inq_ssn_ver_count AND inq_ssn_ver_count < 255) = NULL, 0, 
                                       16*(integer)(0 < inq_ssn_ver_count AND inq_ssn_ver_count < 255)))));

nf_phone_ver_insurance := if(not(truedid), NULL, (integer)phone_ver_insurance);

rv_c12_source_profile := if(not(truedid), NULL, hdr_source_profile);

nf_adls_per_bestssn := if(best_ssn_valid = '7' or not(truedid) or adls_per_bestssn = 0, NULL, min(if(adls_per_bestssn = NULL, -NULL, adls_per_bestssn), 999));

iv_dob_src_ct := if(not(truedid and dobpop), NULL, min(if(combo_dobcount = NULL, -NULL, combo_dobcount), 999));

iv_f00_nas_summary := if(not(truedid and ssnlength >'0'), NULL, nas_summary);

_in_dob_2 := common.sas_date((string)(in_dob));

earliest_bureau_date := if(ver_src_fdate_tn = NULL and ver_src_fdate_en = NULL and ver_src_fdate_eq = NULL, NULL, if(max(ver_src_fdate_tn, ver_src_fdate_en, ver_src_fdate_eq) = NULL, NULL, min(if(ver_src_fdate_tn = NULL, -NULL, ver_src_fdate_tn), if(ver_src_fdate_en = NULL, -NULL, ver_src_fdate_en), if(ver_src_fdate_eq = NULL, -NULL, ver_src_fdate_eq))));

earliest_bureau_yrs := if(earliest_bureau_date = NULL or sysdate = NULL, NULL, if ((sysdate - earliest_bureau_date) / 365.25 >= 0, roundup((sysdate - earliest_bureau_date) / 365.25), truncate((sysdate - earliest_bureau_date) / 365.25)));

calc_dob_2 := if(_in_dob_2 = NULL, NULL, if ((sysdate - _in_dob_2) / 365.25 >= 0, roundup((sysdate - _in_dob_2) / 365.25), truncate((sysdate - _in_dob_2) / 365.25)));

iv_bureau_emergence_age := map(
    not(truedid) or earliest_bureau_yrs = NULL => NULL,
    not(calc_dob_2 = NULL)                     => calc_dob_2 - earliest_bureau_yrs,
    inferred_age = 0                           => NULL,
                                                  inferred_age - earliest_bureau_yrs);

nf_inq_phone_ver_count := if(not(truedid) or inq_phone_ver_count = 255, NULL, inq_phone_ver_count);

nf_util_add_input_summary := map(
    not(addrpop)                              => '',
    util_inp_1 and util_inp_2 and util_inp_z  => 'ICM',
    util_inp_1 and util_inp_2                 => 'IC',
    util_inp_1 and util_inp_z               => 'IM',
    util_inp_2 and util_inp_z                 => 'CM',
    util_inp_1                             => 'I',
    util_inp_2                               => 'C',
    util_inp_z                                => 'M',
                                                  '');


nf_dl_addrs_per_adl := if(not(truedid), NULL, min(if(dl_addrs_per_adl = NULL, -NULL, dl_addrs_per_adl), 999));

rv_i62_inq_phonesperadl_recency := map(
    not(truedid)             => NULL,
    inq_phonesperadl_count01 > 0 => 1,
    inq_phonesperadl_count03 > 0 => 3,
    inq_phonesperadl_count06 > 0 => 6,
    Inq_PhonesPerADL > 0         => 12,
                                0);

rv_f00_dob_score := if(not(truedid and dobpop), NULL, min(if(combo_dobscore = NULL, -NULL, combo_dobscore), 999));

nf_add_dist_input_to_curr := map(
    not(add_curr_pop and add_input_pop) => NULL,
    add_input_isbestmatch               => -1,
                                           min(9999, if(add_dist_input_to_curr = NULL, -NULL, add_dist_input_to_curr)));

nf_inq_per_phone := if(not(hphnpop), NULL, min(if(inq_perphone = NULL, -NULL, inq_perphone), 999));

iv_inf_phn_verd := (infutor_nap in [4, 6, 7, 9, 10, 11, 12]);

_rc_ssnlowissue_1 := common.sas_date((string)(rc_ssnlowissue));

_in_dob_1 := common.sas_date((string)(in_dob));

ssn_years_1 := if(_rc_ssnlowissue_1 = NULL or sysdate = NULL, NULL, if ((sysdate - _rc_ssnlowissue_1) / 365.25 >= 0, roundup((sysdate - _rc_ssnlowissue_1) / 365.25), truncate((sysdate - _rc_ssnlowissue_1) / 365.25)));

calc_dob_1 := if(_in_dob_1 = NULL or sysdate = NULL, NULL, if ((sysdate - _in_dob_1) / 365.25 >= 0, roundup((sysdate - _in_dob_1) / 365.25), truncate((sysdate - _in_dob_1) / 365.25)));

nf_age_at_ssn_issuance := map(
    not(truedid and (ssnlength in ['4', '9'])) or sysdate = NULL or ssn_years_1 = NULL => NULL,
    (string)rc_ssnlowissue = '20110625'                                                        => NULL,
    not(calc_dob_1 = NULL)                                                             => calc_dob_1 - ssn_years_1,
    inferred_age = 0                                                                   => NULL,
                                                                                          inferred_age - ssn_years_1);

nf_inq_perphone_recency := map(
    not(truedid)         => NULL,
    inq_perphone_count01 > 0 => 1,
    inq_perphone_count03 > 0 => 3,
    inq_perphone_count06 > 0 => 6,
    Inq_PerPhone        > 0  => 12,
                            0);

rv_c20_m_bureau_adl_fs := map(
    not(truedid)            => NULL,
    ver_src_fdate_eq = NULL => -1,
                               min(if(if ((sysdate - ver_src_fdate_eq) / (365.25 / 12) >= 0, truncate((sysdate - ver_src_fdate_eq) / (365.25 / 12)), roundup((sysdate - ver_src_fdate_eq) / (365.25 / 12))) = NULL, -NULL, if ((sysdate - ver_src_fdate_eq) / (365.25 / 12) >= 0, truncate((sysdate - ver_src_fdate_eq) / (365.25 / 12)), roundup((sysdate - ver_src_fdate_eq) / (365.25 / 12)))), 999));

//nf_historic_x_current_ct := if(not(truedid), '', (string)min(if(historical_count = NULL, -NULL, historical_count), 3) || '-' || (string)min(if(current_count = NULL, -NULL, current_count), 3));
nf_historic_x_current_ct := if(not(truedid), '', trim((String)min(if(historical_count = NULL, -NULL, historical_count), 3), LEFT, RIGHT) 
                                      + trim('-', LEFT, RIGHT) + trim((String)min(if(current_count = NULL, -NULL, current_count), 3), LEFT, RIGHT));
//rv_e58_br_dead_bus_x_active_phn := if(not(truedid), '', (string)min(if(br_dead_business_count = NULL, -NULL, br_dead_business_count), 3) || '-' || (string)min(if(br_active_phone_count = NULL, -NULL, br_active_phone_count), 3));
rv_e58_br_dead_bus_x_active_phn := if(not(truedid), '', trim((String)min(if(br_dead_business_count = NULL, -NULL, br_dead_business_count), 3), LEFT, RIGHT) 
                                       + trim('-', LEFT, RIGHT) + trim((String)min(if(br_active_phone_count = NULL, -NULL, br_active_phone_count), 3), LEFT, RIGHT));
nf_addrs_per_ssn := if(not(ssnlength > '0'), NULL, min(if(addrs_per_ssn = NULL, -NULL, addrs_per_ssn), 999));

iv_addr_non_phn_src_ct := if(not(truedid and add_input_pop), NULL, min(if(rc_addrcount = NULL, -NULL, rc_addrcount), 999));

rv_i60_inq_other_recency := map(
    not(truedid)      => NULL,
    inq_other_count01 >0  => 1,
    inq_other_count03 >0 => 3,
    inq_other_count06 >0 => 6,
    inq_other_count12 >0 => 12,
    inq_other_count24 >0 => 24,
    inq_other_count   >0 => 99,
                         0);

rv_p88_phn_dst_to_inp_add := if(rc_disthphoneaddr = 9999, NULL, rc_disthphoneaddr);

rv_c12_inp_addr_source_count := if(not(add_input_pop and truedid), NULL, min(if(add_input_source_count = NULL, -NULL, add_input_source_count), 999));

rv_email_count := if(not(truedid), NULL, min(if(email_count = NULL, -NULL, email_count), 999));

nf_unvrfd_search_risk_index := if(not(truedid), NULL, if(max((integer)(fp_srchunvrfdphonecount > '0') +
    2 * (integer)(fp_srchunvrfddobcount > '0') +
    4 * (integer)(fp_srchunvrfdaddrcount > '0') +
    8 * (integer)(fp_srchunvrfdssncount > '0')) = NULL, NULL, sum(if((integer)(fp_srchunvrfdphonecount > '0') +
    2 * (integer)(fp_srchunvrfddobcount > '0') +
    4 * (integer)(fp_srchunvrfdaddrcount > '0') +
    8 * (integer)(fp_srchunvrfdssncount > '0') = NULL, NULL, (integer)(fp_srchunvrfdphonecount > '0') +
    2 * (integer)(fp_srchunvrfddobcount > '0') +
    4 * (integer)(fp_srchunvrfdaddrcount > '0') +
    8 * (integer)(fp_srchunvrfdssncount > '0')))));

rv_c13_attr_addrs_recency := map(
    not(truedid)      => NULL,
    attr_addrs_last30 > 0  => 1,
    attr_addrs_last90 > 0 => 3,
    attr_addrs_last12 > 0 => 12,
    attr_addrs_last24 > 0 => 24,
    attr_addrs_last36 > 0 => 36,
    addrs_5yr         > 0 => 60,
    addrs_10yr        > 0 => 120,
    addrs_15yr        > 0 => 180,
    addrs_per_adl > 0 => 999,
                         0);

iv_phn_cell := map(
    not(hphnpop)                                                                                                                                                                                                                                            => NULL,
    rc_hriskphoneflag = '1' or trim(trim(rc_hphonetypeflag, LEFT), LEFT, RIGHT) = '1' or trim(trim(telcordia_type, LEFT), LEFT, RIGHT) = '04' or trim(trim(telcordia_type, LEFT), LEFT, RIGHT) = '55' or trim(trim(telcordia_type, LEFT), LEFT, RIGHT) = '60' => 1,
                                                                                                                                                                                                                                                               0);

iv_f00_email_verification := if(not(truedid), NULL, (Integer)email_verification);

_rc_ssnlowissue := common.sas_date((string)(rc_ssnlowissue));

_in_dob := common.sas_date((string)(in_dob));

ssn_years := if(_rc_ssnlowissue = NULL or sysdate = NULL, NULL, if ((sysdate - _rc_ssnlowissue) / 365.25 >= 0, roundup((sysdate - _rc_ssnlowissue) / 365.25), truncate((sysdate - _rc_ssnlowissue) / 365.25)));

calc_dob := if(_in_dob = NULL or sysdate = NULL, NULL, if ((sysdate - _in_dob) / 365.25 >= 0, roundup((sysdate - _in_dob) / 365.25), truncate((sysdate - _in_dob) / 365.25)));

_age_at_ssn_issuance := map(
    not(truedid and (ssnlength in ['4', '9'])) or sysdate = NULL or ssn_years = NULL => NULL,
    (string)rc_ssnlowissue = '20110625'                                                      => NULL,
    not(calc_dob = NULL)                                                             => calc_dob - ssn_years,
    inferred_age = 0                                                                 => NULL,
                                                                                        inferred_age - ssn_years);

nf_age_at_ssn_issuance_19_61 := if(_age_at_ssn_issuance = NULL, NULL, (integer)(18 < _age_at_ssn_issuance AND _age_at_ssn_issuance < 62));

earliest_cred_date_all := if(ver_src_fdate_ar = NULL and ver_src_fdate_am = NULL and ver_src_fdate_ba = NULL and ver_src_fdate_cg = NULL and ver_src_fdate_da = NULL and ver_src_fdate_d = NULL and ver_src_fdate_dl = NULL and ver_src_fdate_eb = NULL and ver_src_fdate_e1 = NULL and ver_src_fdate_e2 = NULL and ver_src_fdate_e3 = NULL and ver_src_fdate_fe = NULL and ver_src_fdate_ff = NULL and ver_src_fdate_p = NULL and ver_src_fdate_pl = NULL and ver_src_fdate_sl = NULL and ver_src_fdate_v = NULL and ver_src_fdate_vo = NULL and ver_src_fdate_w = NULL, NULL, if(max(ver_src_fdate_ar, ver_src_fdate_am, ver_src_fdate_ba, ver_src_fdate_cg, ver_src_fdate_da, ver_src_fdate_d, ver_src_fdate_dl, ver_src_fdate_eb, ver_src_fdate_e1, ver_src_fdate_e2, ver_src_fdate_e3, ver_src_fdate_fe, ver_src_fdate_ff, ver_src_fdate_p, ver_src_fdate_pl, ver_src_fdate_sl, ver_src_fdate_v, ver_src_fdate_vo, ver_src_fdate_w) = NULL, NULL, min(if(ver_src_fdate_ar = NULL, -NULL, ver_src_fdate_ar), if(ver_src_fdate_am = NULL, -NULL, ver_src_fdate_am), if(ver_src_fdate_ba = NULL, -NULL, ver_src_fdate_ba), if(ver_src_fdate_cg = NULL, -NULL, ver_src_fdate_cg), if(ver_src_fdate_da = NULL, -NULL, ver_src_fdate_da), if(ver_src_fdate_d = NULL, -NULL, ver_src_fdate_d), if(ver_src_fdate_dl = NULL, -NULL, ver_src_fdate_dl), if(ver_src_fdate_eb = NULL, -NULL, ver_src_fdate_eb), if(ver_src_fdate_e1 = NULL, -NULL, ver_src_fdate_e1), if(ver_src_fdate_e2 = NULL, -NULL, ver_src_fdate_e2), if(ver_src_fdate_e3 = NULL, -NULL, ver_src_fdate_e3), if(ver_src_fdate_fe = NULL, -NULL, ver_src_fdate_fe), if(ver_src_fdate_ff = NULL, -NULL, ver_src_fdate_ff), if(ver_src_fdate_p = NULL, -NULL, ver_src_fdate_p), if(ver_src_fdate_pl = NULL, -NULL, ver_src_fdate_pl), if(ver_src_fdate_sl = NULL, -NULL, ver_src_fdate_sl), if(ver_src_fdate_v = NULL, -NULL, ver_src_fdate_v), if(ver_src_fdate_vo = NULL, -NULL, ver_src_fdate_vo), if(ver_src_fdate_w = NULL, -NULL, ver_src_fdate_w))));

nf_m_src_credentialed_fs := map(
    not(truedid)                  => NULL,
    earliest_cred_date_all = NULL => -1,
                                     min(if(if ((sysdate - earliest_cred_date_all) / (365.25 / 12) >= 0, truncate((sysdate - earliest_cred_date_all) / (365.25 / 12)), roundup((sysdate - earliest_cred_date_all) / (365.25 / 12))) = NULL, -NULL, if ((sysdate - earliest_cred_date_all) / (365.25 / 12) >= 0, truncate((sysdate - earliest_cred_date_all) / (365.25 / 12)), roundup((sysdate - earliest_cred_date_all) / (365.25 / 12)))), 999));

rv_c18_invalid_addrs_per_adl := if(not(truedid), NULL, min(if(invalid_addrs_per_adl = NULL, -NULL, invalid_addrs_per_adl), 999));

nf_inq_per_ssn := if(not(ssnlength > '0'), NULL, min(if(inq_perssn = NULL, -NULL, inq_perssn), 999));

nf_inq_perssn_count_week := if(not(truedid), NULL, min(if(inq_perssn_count_week = NULL, -NULL, inq_perssn_count_week), 999));

num_bureau_fname := (integer)ver_fname_src_eq +
    (integer)ver_fname_src_en +
    (integer)ver_fname_src_tn;

num_bureau_lname := (integer)ver_lname_src_eq +
    (integer)ver_lname_src_en +
    (integer)ver_lname_src_tn;

num_bureau_addr := (integer)ver_addr_src_eq +
    (integer)ver_addr_src_en +
    (integer)ver_addr_src_tn;

num_bureau_ssn := (integer)ver_ssn_src_eq +
    (integer)ver_ssn_src_en +
    (integer)ver_ssn_src_tn;

num_bureau_dob := (integer)ver_dob_src_eq +
    (integer)ver_dob_src_en +
    (integer)ver_dob_src_tn;

iv_bureau_verification_index := if(not(truedid), NULL, if(max((integer)(max(num_bureau_fname, num_bureau_lname) > 0), 2 * (integer)(num_bureau_addr > 0), 4*(integer)(num_bureau_dob > 0), 8*(integer)(num_bureau_ssn > 0)) = NULL, NULL, sum(if( (integer)(max(num_bureau_fname, num_bureau_lname) > 0) = NULL, 0,  (integer)(max(num_bureau_fname, num_bureau_lname) > 0)), if(2*(integer)(num_bureau_addr > 0) = NULL, 0, 2*(integer)(num_bureau_addr > 0)), if(4*(integer)(num_bureau_dob > 0) = NULL, 0, 4*(integer)(num_bureau_dob > 0)), if(8*(integer)(num_bureau_ssn > 0) = NULL, 0, 8*(integer)(num_bureau_ssn > 0)))));

rv_i61_inq_collection_recency := map(
    not(truedid)           => NULL,
    inq_collection_count01 > 0  => 1,
    inq_collection_count03 > 0  => 3,
    inq_collection_count06 > 0  => 6,
    inq_collection_count12 > 0  => 12,
    inq_collection_count24 > 0  => 24,
    inq_collection_count   > 0  => 99,
                              0);

iv_prv_addr_lres := if(not(truedid and add_prev_pop), NULL, min(if(add_prev_lres = NULL, -NULL, add_prev_lres), 999));

earliest_header_date := if(max(ver_src_fdate_ak, ver_src_fdate_ds, ver_src_fdate_cg, ver_src_fdate_co, ver_src_fdate_dl, ver_src_fdate_l2, ver_src_fdate_ar, ver_src_fdate_sl, ver_src_fdate_w, ver_src_fdate_e2, ver_src_fdate_e3, ver_src_fdate_mw, ver_src_fdate_en, ver_src_fdate_li, ver_src_fdate_d, ver_src_fdate_cy, ver_src_fdate_em, ver_src_fdate_eb, ver_src_fdate_v, ver_src_fdate_tu, ver_src_fdate_wp, ver_src_fdate_ts, ver_src_fdate_am, ver_src_fdate_nt, ver_src_fdate_p, ver_src_fdate_ff, ver_src_fdate_fr, ver_src_fdate_de, ver_src_fdate_eq, ver_src_fdate_da, ver_src_fdate_tn, ver_src_fdate_pl, ver_src_fdate_e1, ver_src_fdate_vo, ver_src_fdate_e4, ver_src_fdate_fe, ver_src_fdate_ba) = NULL, NULL, min(if(ver_src_fdate_ak = NULL, -NULL, ver_src_fdate_ak), if(ver_src_fdate_ds = NULL, -NULL, ver_src_fdate_ds), if(ver_src_fdate_cg = NULL, -NULL, ver_src_fdate_cg), if(ver_src_fdate_co = NULL, -NULL, ver_src_fdate_co), if(ver_src_fdate_dl = NULL, -NULL, ver_src_fdate_dl), if(ver_src_fdate_l2 = NULL, -NULL, ver_src_fdate_l2), if(ver_src_fdate_ar = NULL, -NULL, ver_src_fdate_ar), if(ver_src_fdate_sl = NULL, -NULL, ver_src_fdate_sl), if(ver_src_fdate_w = NULL, -NULL, ver_src_fdate_w), if(ver_src_fdate_e2 = NULL, -NULL, ver_src_fdate_e2), if(ver_src_fdate_e3 = NULL, -NULL, ver_src_fdate_e3), if(ver_src_fdate_mw = NULL, -NULL, ver_src_fdate_mw), if(ver_src_fdate_en = NULL, -NULL, ver_src_fdate_en), if(ver_src_fdate_li = NULL, -NULL, ver_src_fdate_li), if(ver_src_fdate_d = NULL, -NULL, ver_src_fdate_d), if(ver_src_fdate_cy = NULL, -NULL, ver_src_fdate_cy), if(ver_src_fdate_em = NULL, -NULL, ver_src_fdate_em), if(ver_src_fdate_eb = NULL, -NULL, ver_src_fdate_eb), if(ver_src_fdate_v = NULL, -NULL, ver_src_fdate_v), if(ver_src_fdate_tu = NULL, -NULL, ver_src_fdate_tu), if(ver_src_fdate_wp = NULL, -NULL, ver_src_fdate_wp), if(ver_src_fdate_ts = NULL, -NULL, ver_src_fdate_ts), if(ver_src_fdate_am = NULL, -NULL, ver_src_fdate_am), if(ver_src_fdate_nt = NULL, -NULL, ver_src_fdate_nt), if(ver_src_fdate_p = NULL, -NULL, ver_src_fdate_p), if(ver_src_fdate_ff = NULL, -NULL, ver_src_fdate_ff), if(ver_src_fdate_fr = NULL, -NULL, ver_src_fdate_fr), if(ver_src_fdate_de = NULL, -NULL, ver_src_fdate_de), if(ver_src_fdate_eq = NULL, -NULL, ver_src_fdate_eq), if(ver_src_fdate_da = NULL, -NULL, ver_src_fdate_da), if(ver_src_fdate_tn = NULL, -NULL, ver_src_fdate_tn), if(ver_src_fdate_pl = NULL, -NULL, ver_src_fdate_pl), if(ver_src_fdate_e1 = NULL, -NULL, ver_src_fdate_e1), if(ver_src_fdate_vo = NULL, -NULL, ver_src_fdate_vo), if(ver_src_fdate_e4 = NULL, -NULL, ver_src_fdate_e4), if(ver_src_fdate_fe = NULL, -NULL, ver_src_fdate_fe), if(ver_src_fdate_ba = NULL, -NULL, ver_src_fdate_ba)));




earliest_header_yrs := if(min(sysdate, earliest_header_date) = NULL, NULL, if ((sysdate - earliest_header_date) / 365.25 >= 0, 
                          roundup((sysdate - earliest_header_date) / 365.25), 
                                   truncate((sysdate - earliest_header_date) / 365.25)));

iv_header_emergence_age := map(
//  not(truedid)       => NULL,
  not(truedid) or earliest_header_yrs = NULL       => NULL,
  not(_in_dob = NULL) => (calc_dob - earliest_header_yrs),
  inferred_age = 0    => NULL,
                           (inferred_age - earliest_header_yrs));




nf_fp_validationrisktype := if(not(truedid), NULL, (integer)fp_validationrisktype);

vo_pos_1 := Models.Common.findw_cpp(ver_sources, 'VO' , ' ,', 'E');

iv_src_voter_adl_count := map(
    not(truedid)     => NULL,
    not(voter_avail) => -1,
    vo_pos_1 <= 0    => 0,
                        (integer)Models.Common.getw(ver_sources_count, vo_pos_1, ', '));

vo_pos := Models.Common.findw_cpp(ver_sources, 'VO' , ' ,', 'E');

vote_adl_lseen_vo := if(vo_pos > 0, Models.Common.getw(ver_sources_last_seen, vo_pos, ', '), '');

_vote_adl_lseen_vo := common.sas_date((string)(vote_adl_lseen_vo));

iv_mos_src_voter_adl_lseen := map(
    not(truedid)              => NULL,
    not(voter_avail)          => -1,
    _vote_adl_lseen_vo = NULL => -1,
                                 if ((sysdate - _vote_adl_lseen_vo) / (365.25 / 12) >= 0, truncate((sysdate - _vote_adl_lseen_vo) / (365.25 / 12)), roundup((sysdate - _vote_adl_lseen_vo) / (365.25 / 12))));

iv_college_major := map(
    not(truedid)                                                                                                                                                                                         => '',
    (college_major in ['A', 'E', 'L', 'Q', 'T', 'V', '040', '041', '044'])                                                                                                                               => 'MEDICAL',
    (college_major in ['D', 'H', 'M', 'N', '046', '006', '022', '026']) or (college_major in ['029', '031', '036'])                                                                                      => 'SCIENCE',
    (college_major in ['C', 'F', 'I', 'J', 'K', 'O', 'W', 'Y']) or (college_major in ['007', '013', '015', '027', '032', '033']) or (college_major in ['035', '037', '038', '039', '042', '043', '003']) => 'LIBERAL ARTS',
    (college_major in ['B', 'G', 'P', 'R', 'S', 'Z', '009', '045'])                                                                                                                                      => 'BUSINESS',
    college_major = 'U'                                                                                                                                                                                  => 'UNCLASSIFIED',
    not(((string)college_date_first_seen in ['0', ' ']))  => 'NO COLLEGE FOUND',
                                            'NO AMS FOUND');

rv_c12_source_profile_index := if(not(truedid), NULL, hdr_source_profile_index);

nf_util_adl_summary := map(
    not(truedid)                                => '',
    util_type_1 and util_type_2 and util_type_z => 'ICM',
    util_type_1 and util_type_2                 => 'IC',
    util_type_1 and util_type_z                 => 'IM',
    util_type_2 and util_type_z                 => 'CM',
    util_type_1                                 => 'I',
    util_type_2                                 => 'C',
    util_type_z                                 => 'M', 
                                                      '');

iv_c13_avg_lres := if(not(truedid), NULL, min(if(avg_lres = NULL, -NULL, avg_lres), 999));

iv_nap_nothing_found := (nap_summary in [0]);

//d_pos := Models.Common.findw_cpp(ver_sources, 'D' , ',', 'E');
d_pos := ver_src_d_pos;

lic_adl_count_d := if(d_pos = 0, 0, (integer)Models.Common.getw(ver_sources_count, d_pos, ','));

dl_pos := Models.Common.findw_cpp(ver_sources, 'DL' , ', ', 'E');

lic_adl_count_dl := if(dl_pos = 0, 0, (integer)Models.Common.getw(ver_sources_count, dl_pos, ','));

src_drivers_license_adl_count := max(if(max(lic_adl_count_d, lic_adl_count_dl) = NULL, NULL, sum(if(lic_adl_count_d = NULL, 0, lic_adl_count_d), if(lic_adl_count_dl = NULL, 0, lic_adl_count_dl))), (real)0);

iv_src_drivers_lic_adl_count := map(
    not(truedid)                         => NULL,
    not(dl_avail)                        => -1,
    src_drivers_license_adl_count = NULL => -1,
                                            src_drivers_license_adl_count);

nf_fp_idveraddressnotcurrent := if(not(truedid), NULL, (integer)fp_idveraddressnotcurrent);

nf_inq_dobsperssn_recency := map(
    not(truedid)           => NULL,
    inq_dobsperssn_count01 > 0 => 1,
    inq_dobsperssn_count03 > 0 => 3,
    inq_dobsperssn_count06 > 0 => 6,
    Inq_DOBsPerSSN > 0         => 12,
                              0);

rv_i60_inq_auto_recency := map(
    not(truedid)     => NULL,
    inq_auto_count01 > 0 => 1,
    inq_auto_count03 > 0 => 3,
    inq_auto_count06  > 0=> 6,
    inq_auto_count12 > 0 => 12,
    inq_auto_count24 > 0 => 24,
    inq_auto_count  > 0  => 99,
                        0);

nf_inq_bestssn_ver_count := if(not(truedid) or inq_bestssn_ver_count = 255, NULL, min(if(inq_bestssn_ver_count = NULL, -NULL, inq_bestssn_ver_count), 999));

nf_phones_per_sfd_addr_curr := map(
    not(addrpop) => NULL,
    iv_add_apt = '1'   => -1,
                    min(if(phones_per_addr_curr = NULL, -NULL, phones_per_addr_curr), 999));

rv_i62_inq_fnamesperadl_recency := map(
    not(truedid)             => NULL,
    inq_fnamesperadl_count01 > 0 => 1,
    inq_fnamesperadl_count03 > 0 => 3,
    inq_fnamesperadl_count06 > 0 => 6,
    Inq_FnamesPerADL  > 0        => 12,
                                0);

nf_addrs_per_bestssn := if(best_ssn_valid = '7' or not(truedid), NULL, min(if(addrs_per_bestssn = NULL, -NULL, addrs_per_bestssn), 999));

nf_invbest_inq_peraddr_diff := map(
    not(truedid) or (integer)addrpop  = 0 => NULL,
    (integer)add_input_isbestmatch   = 1   => -9999,
                                   inq_peraddr - inq_percurraddr);

nf_adl_per_email := if(not(emailpop), NULL, min(if(adl_per_email = NULL, -NULL, adl_per_email), 999));

num_dob_match_level := (integer)input_dob_match_level;

nas_summary_ver := if(ssnlength > '0' and (nas_summary in [8, 9, 10, 11, 12]) or (nas_summary in [2, 4, 7]) and add_input_isbestmatch, 1, 0);

nap_summary_ver := if(hphnpop and (nap_summary in [9, 10, 11, 12]), 1, 0);

infutor_nap_ver := if(hphnpop and (infutor_nap in [9, 10, 11, 12]), 1, 0);

dob_ver := if(dobpop and num_dob_match_level >= 5, 1, 0);

sufficiently_verified := map(
    (boolean)(integer)nas_summary_ver and ((boolean)(integer)nap_summary_ver or (boolean)(integer)infutor_nap_ver)          => 1,
    (boolean)(integer)nas_summary_ver and ((boolean)(integer)dob_ver or not(dobpop))                                        => 1,
    ((boolean)(integer)dob_ver or not(dobpop)) and ((boolean)(integer)nap_summary_ver or (boolean)(integer)infutor_nap_ver) => 1,
                                                                                                                               0);

add_ec1 := (StringLib.StringToUpperCase(trim(out_addr_status, LEFT)))[1..1];

addr_validation_problem := if(add_ec1 = 'E' and not(rc_addrvalflag = 'N') or rc_hriskaddrflag = '4' or rc_addrcommflag = '2' or (add_input_advo_res_or_bus in ['B', 'D']) or not(out_z5 = '') and (rc_hriskaddrflag = '2' or rc_ziptypeflag = '2') or add_input_advo_vacancy = 'Y', 1, 0);

phn_validation_problem := if(rc_hphonetypeflag = 'A' or rc_hriskphoneflag = '2' or rc_hphonetypeflag = '2' or (telcordia_type in ['02', '56', '61']) or rc_phonevalflag = '0' or rc_hphonevalflag = '0' or rc_phonetype = '5' or rc_hriskphoneflag = '6' or rc_hphonetypeflag = '5' or rc_hphonevalflag = '3' or rc_addrcommflag = '1', 1, 0);

validation_problem := if(adls_per_ssn >= 5 or ssns_per_adl >= 4 or invalid_ssns_per_adl >= 1 or adls_per_addr_curr >= 8 or ssns_per_addr_curr >= 7 or rc_hrisksic = '222' or rc_hrisksicphone = '2225' or (boolean)(integer)addr_validation_problem or (boolean)(integer)phn_validation_problem, 1, 0);

tot_liens := liens_historical_unreleased_ct +
    liens_recent_unreleased_count +
    liens_recent_released_count +
    liens_historical_released_count;

tot_liens_w_type := if(max(liens_unrel_LT_ct, liens_rel_LT_ct, liens_unrel_SC_ct, liens_rel_SC_ct, liens_unrel_CJ_ct, liens_rel_CJ_ct, liens_unrel_FT_ct, liens_rel_FT_ct, liens_unrel_OT_ct, liens_rel_OT_ct, liens_unrel_ST_ct, liens_rel_ST_ct, liens_unrel_FC_ct, liens_rel_FC_ct, liens_unrel_O_ct, liens_rel_O_ct) = NULL, NULL, sum(if(liens_unrel_LT_ct = NULL, 0, liens_unrel_LT_ct), if(liens_rel_LT_ct = NULL, 0, liens_rel_LT_ct), if(liens_unrel_SC_ct = NULL, 0, liens_unrel_SC_ct), if(liens_rel_SC_ct = NULL, 0, liens_rel_SC_ct), if(liens_unrel_CJ_ct = NULL, 0, liens_unrel_CJ_ct), if(liens_rel_CJ_ct = NULL, 0, liens_rel_CJ_ct), if(liens_unrel_FT_ct = NULL, 0, liens_unrel_FT_ct), if(liens_rel_FT_ct = NULL, 0, liens_rel_FT_ct), if(liens_unrel_OT_ct = NULL, 0, liens_unrel_OT_ct), if(liens_rel_OT_ct = NULL, 0, liens_rel_OT_ct), if(liens_unrel_ST_ct = NULL, 0, liens_unrel_ST_ct), if(liens_rel_ST_ct = NULL, 0, liens_rel_ST_ct), if(liens_unrel_FC_ct = NULL, 0, liens_unrel_FC_ct), if(liens_rel_FC_ct = NULL, 0, liens_rel_FC_ct), if(liens_unrel_O_ct = NULL, 0, liens_unrel_O_ct), if(liens_rel_O_ct = NULL, 0, liens_rel_O_ct)));

has_derog := if(felony_count > 0 or criminal_count > 0 or stl_inq_count24 > 0 or attr_eviction_count > 0 or liens_unrel_CJ_ct > 0 or liens_rel_CJ_ct > 0 or liens_unrel_SC_ct > 0 or liens_rel_SC_ct > 0 or liens_unrel_FC_ct > 0 or liens_rel_FC_ct > 0 or liens_unrel_O_ct > 0 or liens_rel_O_ct > 0 or tot_liens - tot_liens_w_type > 0 or bk_dismissed_recent_count > 0 or bk_dismissed_historical_count > 0, 1, 0);

rv_6seg_riskview_5_0 := map(
    (integer)truedid = 0                                                                                                     => '0 TRUEDID = 0              ',
    not((boolean)sufficiently_verified)                                                                             => '1 VER/VAL PROBLEMS         ',
    (boolean)sufficiently_verified and (boolean)(integer)validation_problem                                         => '1 VER/VAL PROBLEMS         ',
    (boolean)sufficiently_verified and not(add_input_isbestmatch) and (boolean)(integer)has_derog                   => '2 ADDR NOT CURRENT - DEROG ',
    (boolean)sufficiently_verified and not(add_input_isbestmatch)                                                   => '3 ADDR NOT CURRENT - OTHER ',
    (boolean)sufficiently_verified and add_input_isbestmatch and (boolean)(integer)has_derog                        => '4 SUFFICIENTLY VERD - DEROG',
    (boolean)sufficiently_verified and add_input_isbestmatch and (add_input_naprop = 4 or property_owned_total > 0) => '5 SUFFICIENTLY VERD - OWNER',
                                                                                                                       '6 SUFFICIENTLY VERD - OTHER');

nf_inq_addrsperssn_recency := map(
    not(truedid)            => NULL,
    inq_addrsperssn_count01 > 0 => 1,
    inq_addrsperssn_count03 > 0 => 3,
    inq_addrsperssn_count06  > 0=> 6,
    Inq_AddrsPerSSN   > 0       => 12,
                               0);

rv_i62_inq_addrsperadl_recency := map(
    not(truedid)            => NULL,
    inq_addrsperadl_count01 > 0 => 1,
    inq_addrsperadl_count03 > 0 => 3,
    inq_addrsperadl_count06 > 0 => 6,
    Inq_AddrsPerADL  > 0        => 12,
                               0);

nf_acc_damage_amt_total := if(not(truedid), NULL, acc_damage_amt_total);

nf_invbest_inq_adlsperphone_diff := map(
    not(truedid) or (integer)hphnpop = 0 => NULL,
    input_phone_isbestmatch = '1' => -9999,
                                   inq_adlsperphone - inq_adlsperbestphone);

nf_acc_damage_amt_last := if(not(truedid), NULL, acc_damage_amt_last);

nf_inq_fname_ver_count := if(not(truedid) or inq_fname_ver_count = 255, NULL, inq_fname_ver_count);

nf_inq_lname_ver_count := if(not(truedid) or inq_lname_ver_count = 255, NULL, inq_lname_ver_count);

nf_adls_per_curraddr_curr := if(not(add_curr_pop) or not(truedid), NULL, min(if(adls_per_curraddr_curr = NULL, -NULL, adls_per_curraddr_curr), 999));

rv_a41_a42_prop_owner_history := map(
    not(truedid)                                                                     => NULL,
    add_input_naprop = 4 or add_curr_naprop = 4 or property_owned_total > 0          => 2,
    add_prev_naprop = 4 or Models.Common.findw_cpp(ver_sources, 'P' , ', ', 'E') > 0 => 1,
                                                                                        0);

nf_phone_ver_experian := if(not(truedid), NULL, (integer)trim(phone_ver_experian, LEFT));

final_score_tree_0 := -2.1941561490;

final_score_tree_1_c272 := map(
    NULL < nf_dl_addrs_per_adl AND nf_dl_addrs_per_adl < 0.5 => 0.2511988651,
    nf_dl_addrs_per_adl >= 0.5                               => 0.7620987938,
                                                                0.5038261779);

final_score_tree_1_c271 := map(
    NULL < nf_phone_ver_experian AND nf_phone_ver_experian < 0.5 => final_score_tree_1_c272,
    nf_phone_ver_experian >= 0.5                                 => -0.1165537779,
                                                                    0.2615228955);

final_score_tree_1 := map(
    NULL < iv_nap_inf_phone_ver_lvl AND iv_nap_inf_phone_ver_lvl < 0.5 => final_score_tree_1_c271,
    iv_nap_inf_phone_ver_lvl >= 0.5                                    => -0.0676236029,
                                                                          0.0049536855);

final_score_tree_2_c275 := map(
    (nf_email_name_addr_ver in [3, 5, 6, 7, 8]) => -0.0968261310,
    (nf_email_name_addr_ver in [0, 1, 2, 4])      => 0.3565392629,
                                                             -0.0626948981);

final_score_tree_2_c274 := map(
    NULL < nf_phone_ver_insurance AND nf_phone_ver_insurance < 3.5 => final_score_tree_2_c275,
    nf_phone_ver_insurance >= 3.5                                  => -0.0717242530,
                                                                      0.1175998752);

final_score_tree_2 := map(
    NULL < nf_phone_ver_experian AND nf_phone_ver_experian < 0.5 => final_score_tree_2_c274,
    nf_phone_ver_experian >= 0.5                                 => -0.0875364922,
                                                                    -0.0143600775);

final_score_tree_3_c278 := map(
    (nf_email_name_addr_ver in [1, 3, 4, 5, 7, 8]) => -0.1089335360,
    (nf_email_name_addr_ver in [0, 2, 6])                => 0.2127070817,
                                                                  -0.0494034874);

final_score_tree_3_c277 := map(
    NULL < (integer)iv_inf_phn_verd AND (integer)iv_inf_phn_verd < 0.5 => final_score_tree_3_c278,
    (integer)iv_inf_phn_verd >= 0.5                           => -0.0693651478,
                                                        0.0500965523);

final_score_tree_3 := map(
    NULL < nf_phone_ver_experian AND nf_phone_ver_experian < 0.5 => final_score_tree_3_c277,
    nf_phone_ver_experian >= 0.5                                 => -0.0884432228,
                                                                    -0.0382372681);

final_score_tree_4_c281 := map(
    NULL < rv_c12_source_profile AND rv_c12_source_profile < 78.85 => 0.0961397648,
    rv_c12_source_profile >= 78.85                                 => 0.3564429654,
                                                                      0.1503894264);

final_score_tree_4_c280 := map(
    NULL < nf_phone_ver_insurance AND nf_phone_ver_insurance < 3.5 => final_score_tree_4_c281,
    nf_phone_ver_insurance >= 3.5                                  => -0.0627055645,
                                                                      0.0573386785);

final_score_tree_4 := map(
    NULL < nf_phone_ver_experian AND nf_phone_ver_experian < 0.5 => final_score_tree_4_c280,
    nf_phone_ver_experian >= 0.5                                 => -0.0725386295,
                                                                    -0.0259516823);

final_score_tree_5_c284 := map(
    NULL < nf_inq_per_phone AND nf_inq_per_phone < 1.5 => 0.0187379491,
    nf_inq_per_phone >= 1.5                            => 0.3084953125,
                                                          0.0470069601);

final_score_tree_5_c283 := map(
    NULL < nf_m_snc_ssn_high_issue AND nf_m_snc_ssn_high_issue < 574.5 => final_score_tree_5_c284,
    nf_m_snc_ssn_high_issue >= 574.5                                   => 0.2723443669,
                                                                          0.0831164984);

final_score_tree_5 := map(
    NULL < iv_nap_inf_phone_ver_lvl AND iv_nap_inf_phone_ver_lvl < 0.5 => final_score_tree_5_c283,
    iv_nap_inf_phone_ver_lvl >= 0.5                                    => -0.0480330034,
                                                                          -0.0165513199);

final_score_tree_6_c287 := map(
    NULL < nf_phone_ver_experian AND nf_phone_ver_experian < 0.5 => 0.3162425331,
    nf_phone_ver_experian >= 0.5                                 => 0.0947252547,
                                                                    0.2241660740);

final_score_tree_6_c286 := map(
    (nf_inquiry_verification_index in [17, 19, 21, 23, 3, 31, 5, 7])       => -0.0437989176,
    (nf_inquiry_verification_index in [0, 1, 11, 13, 15, 25, 27, 29, 9]) => final_score_tree_6_c287,
                                                                                              0.1054701717);

final_score_tree_6 := map(
    NULL < iv_bureau_emergence_age AND iv_bureau_emergence_age < 40.5 => -0.0336730861,
    iv_bureau_emergence_age >= 40.5                                   => final_score_tree_6_c286,
                                                                         -0.0183555054);

final_score_tree_7_c290 := map(
    NULL < iv_nap_inf_phone_ver_lvl AND iv_nap_inf_phone_ver_lvl < 0.5 => 0.2024494324,
    iv_nap_inf_phone_ver_lvl >= 0.5                                    => 0.0263980534,
                                                                          0.1158735778);

final_score_tree_7_c289 := map(
    (nf_email_name_addr_ver in [4, 5, 6, 7, 8]) => -0.0667458220,
    (nf_email_name_addr_ver in [0, 1, 2, 3])      => final_score_tree_7_c290,
                                                             -0.1470422983);

final_score_tree_7 := map(
    NULL < nf_inq_phone_ver_count AND nf_inq_phone_ver_count < 0.5 => final_score_tree_7_c289,
    nf_inq_phone_ver_count >= 0.5                                  => -0.0484224459,
                                                                      -0.0440250984);

final_score_tree_8_c293 := map(
    NULL < nf_phone_ver_experian AND nf_phone_ver_experian < 0.5 => 0.1631749053,
    nf_phone_ver_experian >= 0.5                                 => 0.0136020644,
                                                                    0.0794931837);

final_score_tree_8_c292 := map(
    (nf_email_name_addr_ver in [1, 3, 4, 5, 6, 7, 8]) => -0.0985663209,
    (nf_email_name_addr_ver in [0, 2])                          => final_score_tree_8_c293,
                                                                       -0.0314894406);

final_score_tree_8 := map(
    NULL < iv_bureau_emergence_age AND iv_bureau_emergence_age < 21.5 => -0.0744032613,
    iv_bureau_emergence_age >= 21.5                                   => final_score_tree_8_c292,
                                                                         -0.0222388442);

final_score_tree_9_c295 := map(
    NULL < iv_bureau_emergence_age AND iv_bureau_emergence_age < 28.5 => -0.0701185517,
    iv_bureau_emergence_age >= 28.5                                   => 0.0284230490,
                                                                         -0.0382506469);

final_score_tree_9_c296 := map(
    NULL < nf_phone_ver_experian AND nf_phone_ver_experian < 0.5 => 0.1992109573,
    nf_phone_ver_experian >= 0.5                                 => 0.0486308784,
                                                                    0.1024464393);

final_score_tree_9 := map(
    NULL < rv_c12_inp_addr_source_count AND rv_c12_inp_addr_source_count < 10.5 => final_score_tree_9_c295,
    rv_c12_inp_addr_source_count >= 10.5                                        => final_score_tree_9_c296,
                                                                                   -0.0231202507);

final_score_tree_10_c298 := map(
    NULL < nf_m_snc_ssn_high_issue AND nf_m_snc_ssn_high_issue < 514.5 => -0.0652508537,
    nf_m_snc_ssn_high_issue >= 514.5                                   => 0.0399508545,
                                                                          -0.0424426470);

final_score_tree_10_c299 := map(
    (rv_i62_inq_phonesperadl_recency in [0, 12])     => 0.0716663916,
    (rv_i62_inq_phonesperadl_recency in [1, 3, 6]) => 0.4148138822,
                                                            0.1168614269);

final_score_tree_10 := map(
    NULL < iv_addr_non_phn_src_ct AND iv_addr_non_phn_src_ct < 9.5 => final_score_tree_10_c298,
    iv_addr_non_phn_src_ct >= 9.5                                  => final_score_tree_10_c299,
                                                                      -0.0183323959);

final_score_tree_11_c302 := map(
    NULL < iv_f00_nas_summary AND iv_f00_nas_summary < 10 => 0.2503538102,
    iv_f00_nas_summary >= 10                              => -0.0188083700,
                                                             -0.0128060652);

final_score_tree_11_c301 := map(
    NULL < nf_inq_perssn_count_week AND nf_inq_perssn_count_week < 0.5 => final_score_tree_11_c302,
    nf_inq_perssn_count_week >= 0.5                                    => 0.2572237821,
                                                                          -0.0034632603);

final_score_tree_11 := map(
    NULL < nf_adls_per_bestssn AND nf_adls_per_bestssn < 1.5 => final_score_tree_11_c301,
    nf_adls_per_bestssn >= 1.5                               => -0.0623504270,
                                                                -0.0105454586);

final_score_tree_12_c305 := map(
    NULL < rv_c12_source_profile AND rv_c12_source_profile < 76.9 => 0.0354019977,
    rv_c12_source_profile >= 76.9                                 => 0.3368422720,
                                                                     0.1769875811);

final_score_tree_12_c304 := map(
    NULL < nf_m_snc_ssn_high_issue AND nf_m_snc_ssn_high_issue < 608.5 => 0.0134751491,
    nf_m_snc_ssn_high_issue >= 608.5                                   => final_score_tree_12_c305,
                                                                          0.0259512421);

final_score_tree_12 := map(
    (nf_email_name_addr_ver in [3, 4, 5, 6, 7, 8]) => -0.1011856788,
    (nf_email_name_addr_ver in [0, 1, 2])                => final_score_tree_12_c304,
                                                                  -0.0869169330);

final_score_tree_13_c308 := map(
    (rv_i60_inq_other_recency in [0, 1, 12, 24, 6, 99]) => 0.0016999209,
    (rv_i60_inq_other_recency in [3])                             => 0.2609634962,
                                                                       0.0132586517);

final_score_tree_13_c307 := map(
    NULL < iv_f00_email_verification AND iv_f00_email_verification < 4.5 => final_score_tree_13_c308,
    iv_f00_email_verification >= 4.5                                     => -0.1454843304,
                                                                            -0.0196720733);

final_score_tree_13 := map(
    NULL < nf_add_dist_input_to_curr AND nf_add_dist_input_to_curr < 229 => final_score_tree_13_c307,
    nf_add_dist_input_to_curr >= 229                                     => 0.3019456373,
                                                                            -0.0106458746);

final_score_tree_14_c310 := map(
    (rv_i62_inq_phonesperadl_recency in [0, 12, 6]) => -0.0289591613,
    (rv_i62_inq_phonesperadl_recency in [1, 3])       => 0.1209237382,
                                                             -0.0201733236);

final_score_tree_14_c311 := map(
    NULL < nf_inq_phone_ver_count AND nf_inq_phone_ver_count < 1.5 => 0.2632884203,
    nf_inq_phone_ver_count >= 1.5                                  => -0.1159843470,
                                                                      0.0753010487);

final_score_tree_14 := map(
    (nf_inq_perphone_recency in [0, 12, 3, 6]) => final_score_tree_14_c310,
    (nf_inq_perphone_recency in [1])                 => final_score_tree_14_c311,
                                                          -0.0155530271);

final_score_tree_15_c314 := map(
    (nf_inquiry_verification_index in [13, 17, 23, 31])                                                 => -0.0555456912,
    (nf_inquiry_verification_index in [0, 1, 11, 15, 19, 21, 25, 27, 29, 3, 5, 7, 9]) => 0.1229837458,
                                                                                                                   0.0512458898);

final_score_tree_15_c313 := map(
    NULL < nf_age_at_ssn_issuance AND nf_age_at_ssn_issuance < 17.5 => final_score_tree_15_c314,
    nf_age_at_ssn_issuance >= 17.5                                  => 0.2685323646,
                                                                       0.0743048627);

final_score_tree_15 := map(
    NULL < rv_c12_source_profile AND rv_c12_source_profile < 78.75 => -0.0254588281,
    rv_c12_source_profile >= 78.75                                 => final_score_tree_15_c313,
                                                                      -0.0073835617);

final_score_tree_16_c317 := map(
    NULL < rv_c12_source_profile_index AND rv_c12_source_profile_index < 8.5 => -0.0117262934,
    rv_c12_source_profile_index >= 8.5                                       => 0.2075538709,
                                                                                0.0234865797);

final_score_tree_16_c316 := map(
    NULL < rv_p88_phn_dst_to_inp_add AND rv_p88_phn_dst_to_inp_add < 34.5 => final_score_tree_16_c317,
    rv_p88_phn_dst_to_inp_add >= 34.5                                     => 0.2633798128,
                                                                             0.0290664720);

final_score_tree_16 := map(
    NULL < nf_phone_ver_insurance AND nf_phone_ver_insurance < 3.5 => final_score_tree_16_c316,
    nf_phone_ver_insurance >= 3.5                                  => -0.0565627956,
                                                                      -0.0195770447);

final_score_tree_17_c320 := map(
    (nf_util_add_input_summary in ['CM', 'IC'])                 => -0.0460260419,
    (nf_util_add_input_summary in ['C', 'I', 'ICM', 'IM', 'M']) => 0.0514732364,
                                                                   0.1443582257);

final_score_tree_17_c319 := map(
    NULL < nf_phone_ver_experian AND nf_phone_ver_experian < 0.5 => final_score_tree_17_c320,
    nf_phone_ver_experian >= 0.5                                 => -0.0661920211,
                                                                    -0.0301979358);

final_score_tree_17 := map(
    NULL < nf_m_snc_ssn_high_issue AND nf_m_snc_ssn_high_issue < 141 => 0.0968477373,
    nf_m_snc_ssn_high_issue >= 141                                   => final_score_tree_17_c319,
                                                                        -0.0225095630);

final_score_tree_18_c323 := map(
    NULL < nf_fp_idveraddressnotcurrent AND nf_fp_idveraddressnotcurrent < 1.5 => 0.3121220961,
    nf_fp_idveraddressnotcurrent >= 1.5                                        => 0.0602447452,
                                                                                  0.1121583977);

final_score_tree_18_c322 := map(
    NULL < nf_age_at_ssn_issuance AND nf_age_at_ssn_issuance < 23.5 => -0.0153924483,
    nf_age_at_ssn_issuance >= 23.5                                  => final_score_tree_18_c323,
                                                                       -0.0025737595);

final_score_tree_18 := map(
    (nf_unvrfd_search_risk_index in [0, 1, 10, 14, 15, 2, 3, 8, 9]) => final_score_tree_18_c322,
    (nf_unvrfd_search_risk_index in [11, 12, 13, 4, 5, 6, 7])           => 0.2168426634,
                                                                                         0.0026948284);

final_score_tree_19_c326 := map(
    (nf_inquiry_verification_index in [0, 23, 27, 31])                                                   => -0.0086125209,
    (nf_inquiry_verification_index in [1, 11, 13, 15, 17, 19, 21, 25, 29, 3, 5, 7, 9]) => 0.1972602166,
                                                                                                                    0.1340536743);

final_score_tree_19_c325 := map(
    NULL < iv_nap_inf_phone_ver_lvl AND iv_nap_inf_phone_ver_lvl < 0.5 => final_score_tree_19_c326,
    iv_nap_inf_phone_ver_lvl >= 0.5                                    => 0.0207519570,
                                                                          0.0459301164);

final_score_tree_19 := map(
    NULL < iv_mos_src_voter_adl_lseen AND iv_mos_src_voter_adl_lseen < -0.5 => -0.0394895733,
    iv_mos_src_voter_adl_lseen >= -0.5                                      => final_score_tree_19_c325,
                                                                               -0.0071259833);

final_score_tree_20_c329 := map(
    NULL < iv_src_drivers_lic_adl_count AND iv_src_drivers_lic_adl_count < 0.5 => -0.0016457484,
    iv_src_drivers_lic_adl_count >= 0.5                                        => 0.2092765176,
                                                                                  0.1087434749);

final_score_tree_20_c328 := map(
    (nf_email_name_addr_ver in [4, 5, 6, 7, 8]) => -0.0615670189,
    (nf_email_name_addr_ver in [0, 1, 2, 3])      => final_score_tree_20_c329,
                                                             -0.0680904129);

final_score_tree_20 := map(
    NULL < nf_m_snc_ssn_high_issue AND nf_m_snc_ssn_high_issue < 585.5 => -0.0223556991,
    nf_m_snc_ssn_high_issue >= 585.5                                   => final_score_tree_20_c328,
                                                                          -0.0148005087);

final_score_tree_21_c332 := map(
    NULL < rv_email_count AND rv_email_count < 1.5 => 0.0710469750,
    rv_email_count >= 1.5                          => 0.3471421481,
                                                      0.1823756739);

final_score_tree_21_c331 := map(
    NULL < nf_phone_ver_experian AND nf_phone_ver_experian < 0.5 => final_score_tree_21_c332,
    nf_phone_ver_experian >= 0.5                                 => 0.0179155244,
                                                                    0.0858923862);

final_score_tree_21 := map(
    (nf_inquiry_verification_index in [13, 17, 19, 21, 23, 25, 27, 29, 3, 31, 5, 9]) => -0.0272194826,
    (nf_inquiry_verification_index in [0, 1, 11, 15, 7])                                           => final_score_tree_21_c331,
                                                                                                                -0.0146839966);

final_score_tree_22_c335 := map(

    NULL < nf_acc_damage_amt_total AND nf_acc_damage_amt_total < 137.5 => -0.0342032229,
    nf_acc_damage_amt_total >= 137.5                                   => 0.1335736439,
                                                                          -0.0287972940);

final_score_tree_22_c334 := map(
    (iv_bureau_verification_index in [11, 15, 5, 7])                   => final_score_tree_22_c335,
    (iv_bureau_verification_index in [0, 1, 10, 12, 13, 14, 3, 8, 9]) => 0.1960714513,
                                                                         -0.0245656654);

final_score_tree_22 := map(
    (nf_inquiry_verification_index in [0, 1, 13, 15, 17, 21, 23, 25, 27, 29, 3, 31, 5, 7]) => final_score_tree_22_c334,
    (nf_inquiry_verification_index in [11, 19, 9])                                       => 0.2819341643,
                                                                                               -0.0187933273);

final_score_tree_23_c338 := map(
    (nf_inquiry_verification_index in [1, 11, 13, 15, 19, 21, 27, 3, 31, 5, 7]) => -0.0665331296,
    (nf_inquiry_verification_index in [0, 17, 23, 25, 29, 9])                             => 0.0201203357,
                                                                                                         -0.0296828147);

final_score_tree_23_c337 := map(
    NULL < iv_f00_nas_summary AND iv_f00_nas_summary < 10.5 => 0.1307950923,
    iv_f00_nas_summary >= 10.5                              => final_score_tree_23_c338,
                                                               -0.0263445829);

final_score_tree_23 := map(
    NULL < rv_c20_m_bureau_adl_fs AND rv_c20_m_bureau_adl_fs < 383 => final_score_tree_23_c337,
    rv_c20_m_bureau_adl_fs >= 383                                  => 0.2505287712,
                                                                      -0.0200031910);

final_score_tree_24_c341 := map(
    NULL < iv_bureau_emergence_age AND iv_bureau_emergence_age < 26.5 => 0.0067746906,
    iv_bureau_emergence_age >= 26.5                                   => 0.1365211354,
                                                                         0.0553968431);

final_score_tree_24_c340 := map(
    (nf_email_name_addr_ver in [1, 3, 4, 5, 6, 7, 8]) => -0.0807917715,
    (nf_email_name_addr_ver in [0, 2])                          => final_score_tree_24_c341,
                                                                       -0.0585737925);

final_score_tree_24 := map(
    NULL < iv_src_voter_adl_count AND iv_src_voter_adl_count < -0.5 => -0.0598806670,
    iv_src_voter_adl_count >= -0.5                                  => final_score_tree_24_c340,
                                                                       -0.0204272637);

final_score_tree_25_c344 := map(
    (iv_college_major in ['BUSINESS', 'MEDICAL', 'NO AMS FOUND', 'NO COLLEGE FOUND', 'UNCLASSIFIED']) => -0.0525510781,
    (iv_college_major in ['LIBERAL ARTS', 'SCIENCE'])                                                 => 0.3171950942,
                                                                                                         -0.0372682363);

final_score_tree_25_c343 := map(
    NULL < iv_header_emergence_age AND iv_header_emergence_age < 24.5 => final_score_tree_25_c344,
    iv_header_emergence_age >= 24.5                                   => 0.0639384011,
                                                                         -0.0018656544);

final_score_tree_25 := map(
    (nf_email_name_addr_ver in [0, 3, 4, 5, 6, 7, 8]) => final_score_tree_25_c343,
    (nf_email_name_addr_ver in [1, 2])                          => 0.3136721238,
                                                                       -0.0821612918);

final_score_tree_26_c346 := map(
    (rv_e58_br_dead_bus_x_active_phn in ['0-0', '0-1', '0-2', '1-0', '1-1', '1-2', '1-3', '2-0', '2-3', '3-1', '3-3']) => -0.0221374958,
    (rv_e58_br_dead_bus_x_active_phn in ['0-3', '2-1', '2-2', '3-0', '3-2'])                                           => 0.1803046236,
                                                                                                                          -0.0158426538);

final_score_tree_26_c347 := map(
    NULL < rv_c12_inp_addr_source_count AND rv_c12_inp_addr_source_count < 9.5 => 0.0338601754,
    rv_c12_inp_addr_source_count >= 9.5                                        => 0.2777327791,
                                                                                  0.0907088567);

final_score_tree_26 := map(
    (rv_i62_inq_fnamesperadl_recency in [0, 12, 6]) => final_score_tree_26_c346,
    (rv_i62_inq_fnamesperadl_recency in [1, 3])       => final_score_tree_26_c347,
                                                             -0.0041959599);

final_score_tree_27_c350 := map(
    (rv_c13_attr_addrs_recency in [12, 24, 3, 60])               => 0.0397321594,
    (rv_c13_attr_addrs_recency in [0, 1, 120, 180, 36, 999]) => 0.2882618787,
                                                                            0.2037617741);

final_score_tree_27_c349 := map(
    (nf_inq_dobsperssn_recency in [1, 12, 3]) => -0.0090227397,
    (nf_inq_dobsperssn_recency in [0, 6])       => final_score_tree_27_c350,
                                                       0.0995407878);

final_score_tree_27 := map(
    (nf_inq_perphone_recency in [0, 12, 6]) => -0.0078052782,
    (nf_inq_perphone_recency in [1, 3])       => final_score_tree_27_c349,
                                                     0.0038532898);

final_score_tree_28_c353 := map(
    NULL < iv_prv_addr_lres AND iv_prv_addr_lres < 124.5 => 0.0024299778,
    iv_prv_addr_lres >= 124.5                            => 0.2842772887,
                                                            0.1151689022);

final_score_tree_28_c352 := map(
    (nf_util_adl_summary in ['CM', 'IC', 'M'])       => -0.0754493255,
    (nf_util_adl_summary in ['C', 'I', 'ICM', 'IM']) => final_score_tree_28_c353,
                                                        0.0944976510);

final_score_tree_28 := map(
    (nf_inquiry_verification_index in [11, 15, 17, 21, 23, 27, 29, 3, 31, 5, 7]) => -0.0359902881,
    (nf_inquiry_verification_index in [0, 1, 13, 19, 25, 9])                               => final_score_tree_28_c352,
                                                                                                          -0.0176481822);

final_score_tree_29_c356 := map(
    NULL < nf_phone_ver_insurance AND nf_phone_ver_insurance < 3.5 => 0.1791805326,
    nf_phone_ver_insurance >= 3.5                                  => 0.0555027619,
                                                                      0.1224342614);

final_score_tree_29_c355 := map(
    NULL < nf_adl_per_email AND nf_adl_per_email < 0.5 => final_score_tree_29_c356,
    nf_adl_per_email >= 0.5                            => -0.0041684504,
                                                          0.0932182510);

final_score_tree_29 := map(
    NULL < rv_c12_source_profile AND rv_c12_source_profile < (decimal4_1)81.4 => -0.0105410880,
    rv_c12_source_profile >= (decimal4_1)81.4                                 => final_score_tree_29_c355,
                                                                     -0.0001996257);

final_score_tree_30_c359 := map(
    (rv_i60_inq_other_recency in [0, 24, 6, 99]) => -0.0436385758,
    (rv_i60_inq_other_recency in [1, 12, 3])       => 0.0633055079,
                                                            -0.0301823105);

final_score_tree_30_c358 := map(
    NULL < nf_acc_damage_amt_last AND nf_acc_damage_amt_last < 50 => final_score_tree_30_c359,
    nf_acc_damage_amt_last >= 50                                  => 0.1415085398,
                                                                     -0.0255753376);

final_score_tree_30 := map(
    (nf_unvrfd_search_risk_index in [0, 1, 10, 3, 5, 8, 9])               => final_score_tree_30_c358,
    (nf_unvrfd_search_risk_index in [11, 12, 13, 14, 15, 2, 4, 6, 7]) => 0.2158026233,
                                                                                           -0.0200489589);

final_score_tree_31_c362 := map(
    NULL < rv_c12_source_profile AND rv_c12_source_profile < 68.45 => -0.0296516234,
    rv_c12_source_profile >= 68.45                                 => 0.2150109451,
                                                                      0.1019316067);

final_score_tree_31_c361 := map(
    (nf_inq_perphone_recency in [0, 12, 3, 6]) => -0.0161860564,
    (nf_inq_perphone_recency in [1])                 => final_score_tree_31_c362,
                                                          -0.0102900824);

final_score_tree_31 := map(
    NULL < iv_dob_src_ct AND iv_dob_src_ct < 3.5 => 0.0691742622,
    iv_dob_src_ct >= 3.5                         => final_score_tree_31_c361,
                                                    -0.0007825316);

final_score_tree_32_c365 := map(
    (nf_email_name_addr_ver in [3, 5, 6, 7, 8]) => -0.1419620338,
    (nf_email_name_addr_ver in [0, 1, 2, 4])      => 0.0305628425,
                                                             -0.0354417891);

final_score_tree_32_c364 := map(
    NULL < nf_adls_per_bestssn AND nf_adls_per_bestssn < 1.5 => final_score_tree_32_c365,
    nf_adls_per_bestssn >= 1.5                               => -0.0607791139,
                                                                -0.0185753789);

final_score_tree_32 := map(
    NULL < rv_f00_dob_score AND rv_f00_dob_score < 98 => 0.0790004614,
    rv_f00_dob_score >= 98                            => final_score_tree_32_c364,
                                                         -0.0150028906);

final_score_tree_33_c368 := map(
    NULL < nf_add_dist_input_to_curr AND nf_add_dist_input_to_curr < 0.5 => -0.0260853800,
    nf_add_dist_input_to_curr >= 0.5                                     => 0.2000334014,
                                                                            -0.0033965907);

final_score_tree_33_c367 := map(
    NULL < rv_c12_source_profile AND rv_c12_source_profile < (decimal4_1)81.4 => final_score_tree_33_c368,
    rv_c12_source_profile >= (decimal4_1)81.4                                 => 0.2253872299,
                                                                     0.0155200123);

final_score_tree_33 := map(
    NULL < nf_addrs_per_ssn AND nf_addrs_per_ssn < 5.5 => final_score_tree_33_c367,
    nf_addrs_per_ssn >= 5.5                            => -0.0319687366,
                                                          -0.0207186344);

final_score_tree_34_c371 := map(
    NULL < nf_adls_per_bestssn AND nf_adls_per_bestssn < 1.5 => 0.0218155406,
    nf_adls_per_bestssn >= 1.5                               => 0.0529215190,
                                                                0.0255288841);

final_score_tree_34_c370 := map(
    NULL < rv_c18_invalid_addrs_per_adl AND rv_c18_invalid_addrs_per_adl < 1.5 => final_score_tree_34_c371,
    rv_c18_invalid_addrs_per_adl >= 1.5                                        => -0.0410798850,
                                                                                  -0.0118363975);

final_score_tree_34 := map(
    NULL < nf_inq_per_ssn AND nf_inq_per_ssn < 9.5 => final_score_tree_34_c370,
    nf_inq_per_ssn >= 9.5                          => 0.1777802103,
                                                      -0.0075698489);

final_score_tree_35_c374 := map(
    NULL < iv_c13_avg_lres AND iv_c13_avg_lres < 287.5 => -0.0053326611,
    iv_c13_avg_lres >= 287.5                           => 0.1411212820,
                                                          0.0021466542);

final_score_tree_35_c373 := map(
    (iv_bureau_verification_index in [11, 15])                              => final_score_tree_35_c374,
    (iv_bureau_verification_index in [0, 1, 10, 12, 13, 14, 3, 5, 7, 8, 9]) => 0.2163867341,
                                                                                0.0071693330);

final_score_tree_35 := map(
    NULL < nf_adls_per_bestssn AND nf_adls_per_bestssn < 1.5 => final_score_tree_35_c373,
    nf_adls_per_bestssn >= 1.5                               => -0.0330655643,
                                                                 0.0019979829);

final_score_tree_36_c377 := map(
    NULL < nf_addrs_per_bestssn AND nf_addrs_per_bestssn < 14.5 => -0.0154626339,
    nf_addrs_per_bestssn >= 14.5                                => 0.0190887403,
                                                                   -0.0089749976);

final_score_tree_36_c376 := map(
    NULL < nf_inq_per_phone AND nf_inq_per_phone < 4.5 => final_score_tree_36_c377,
    nf_inq_per_phone >= 4.5                            => 0.1704288193,
                                                          -0.0051462576);

final_score_tree_36 := map(
    NULL < rv_c20_m_bureau_adl_fs AND rv_c20_m_bureau_adl_fs < 51.5 => -0.1764285784,
    rv_c20_m_bureau_adl_fs >= 51.5                                  => final_score_tree_36_c376,
                                                                       -0.0097002928);

final_score_tree_37_c380 := map(
    NULL < nf_adls_per_bestssn AND nf_adls_per_bestssn < 1.5 => -0.0227024051,
    nf_adls_per_bestssn >= 1.5                               => -0.0330672561,
                                                                -0.0240256648);

final_score_tree_37_c379 := map(
    NULL < nf_m_snc_ssn_high_issue AND nf_m_snc_ssn_high_issue < 687 => final_score_tree_37_c380,
    nf_m_snc_ssn_high_issue >= 687                                   => -0.1212144763,
                                                                        -0.0275611426);

final_score_tree_37 := map(
    (rv_e58_br_dead_bus_x_active_phn in ['0-0', '0-1', '0-2', '1-0', '1-1', '1-2', '1-3', '2-0', '2-1', '2-2', '3-2', '3-3']) => final_score_tree_37_c379,
    (rv_e58_br_dead_bus_x_active_phn in ['0-3', '2-3', '3-0', '3-1'])                                                         => 0.2111601165,
                                                                                                                                 -0.0215666649);

final_score_tree_38_c383 := map(
    NULL < rv_email_count AND rv_email_count < 1.5 => 0.0519317962,
    rv_email_count >= 1.5                          => 0.3097030006,
                                                      0.1565132563);

final_score_tree_38_c382 := map(
    (nf_inquiry_verification_index in [17, 19, 23, 25, 27, 29, 3, 31, 5, 7]) => 0.0099067946,
    (nf_inquiry_verification_index in [0, 1, 11, 13, 15, 21, 9])                   => final_score_tree_38_c383,
                                                                                                    0.0366041211);

final_score_tree_38 := map(
    NULL < nf_phone_ver_experian AND nf_phone_ver_experian < 0.5 => final_score_tree_38_c382,
    nf_phone_ver_experian >= 0.5                                 => -0.0354757923,
                                                                    -0.0098870236);

final_score_tree_39_c386 := map(
    NULL < iv_src_voter_adl_count AND iv_src_voter_adl_count < -0.5 => -0.0668764069,
    iv_src_voter_adl_count >= -0.5                                  => 0.0341465817,
                                                                       -0.0109191421);

final_score_tree_39_c385 := map(
    (rv_i62_inq_phonesperadl_recency in [0, 12, 3, 6]) => final_score_tree_39_c386,
    (rv_i62_inq_phonesperadl_recency in [1])                 => 0.1713155029,
                                                                  -0.0049961718);

final_score_tree_39 := map(
    NULL < iv_f00_nas_summary AND iv_f00_nas_summary < 10 => 0.0632942378,
    iv_f00_nas_summary >= 10                              => final_score_tree_39_c385,
                                                             -0.0034819720);

final_score_tree_40_c389 := map(
    (rv_i62_inq_phonesperadl_recency in [0, 1, 12, 6]) => 0.0495599562,
    (rv_i62_inq_phonesperadl_recency in [3])                 => 0.2520868179,
                                                                  0.0591087512);

final_score_tree_40_c388 := map(
    NULL < iv_phn_cell AND iv_phn_cell < 0.5 => final_score_tree_40_c389,
    iv_phn_cell >= 0.5                       => -0.0328554001,
                                                0.0166232684);

final_score_tree_40 := map(
    NULL < nf_addrs_per_ssn AND nf_addrs_per_ssn < 17.5 => final_score_tree_40_c388,
    nf_addrs_per_ssn >= 17.5                            => -0.0791894935,
                                                           0.0076783869);

final_score_tree_41_c392 := map(
    NULL < nf_inq_bestssn_ver_count AND nf_inq_bestssn_ver_count < 2.5 => 0.0662293185,
    nf_inq_bestssn_ver_count >= 2.5                                    => 0.1727644961,
                                                                          0.1275445286);

final_score_tree_41_c391 := map(
    (rv_6seg_riskview_5_0 in ['3 ADDR NOT CURRENT - OTHER', '5 SUFFICIENTLY VERD - OWNER'])                                                                       => -0.0982196987,
    (rv_6seg_riskview_5_0 in ['0 TRUEDID = 0', '1 VER/VAL PROBLEMS', '2 ADDR NOT CURRENT - DEROG', '4 SUFFICIENTLY VERD - DEROG', '6 SUFFICIENTLY VERD - OTHER']) => final_score_tree_41_c392,
                                                                                                                                                                     0.0202139943);

final_score_tree_41 := map(
    NULL < iv_dob_src_ct AND iv_dob_src_ct < 3.5 => final_score_tree_41_c391,
    iv_dob_src_ct >= 3.5                         => -0.0009576906,
                                                    0.0014295049);

final_score_tree_42_c395 := map(
    NULL < iv_c13_avg_lres AND iv_c13_avg_lres < 32.5 => -0.1881959433,
    iv_c13_avg_lres >= 32.5                           => -0.0060084971,
                                                         -0.0131039169);

final_score_tree_42_c394 := map(
    NULL < nf_inq_per_phone AND nf_inq_per_phone < 5.5 => final_score_tree_42_c395,
    nf_inq_per_phone >= 5.5                            => 0.1179064865,
                                                          -0.0102821544);

final_score_tree_42 := map(
    NULL < nf_phones_per_sfd_addr_curr AND nf_phones_per_sfd_addr_curr < 9.5 => final_score_tree_42_c394,
    nf_phones_per_sfd_addr_curr >= 9.5                                       => 0.1698998549,
                                                                                -0.0035053974);

final_score_tree_43_c397 := map(
    NULL < nf_adls_per_bestssn AND nf_adls_per_bestssn < 1.5 => -0.0167531497,
    nf_adls_per_bestssn >= 1.5                               => -0.0804087581,
                                                                -0.0243272204);

final_score_tree_43_c398 := map(
    (nf_util_add_input_summary in ['CM', 'I', 'IC', 'ICM', 'IM']) => 0.0092744760,
    (nf_util_add_input_summary in ['C', 'M'])                     => 0.1096395859,
                                                                     0.3301643399);

final_score_tree_43 := map(
    NULL < nf_age_at_ssn_issuance_19_61 AND nf_age_at_ssn_issuance_19_61 < 0.5 => final_score_tree_43_c397,
    nf_age_at_ssn_issuance_19_61 >= 0.5                                        => final_score_tree_43_c398,
                                                                                  -0.0075424120);

final_score_tree_44_c401 := map(
    NULL < iv_phn_cell AND iv_phn_cell < 0.5 => 0.0427850297,
    iv_phn_cell >= 0.5                       => -0.0454860943,
                                                0.0029261695);

final_score_tree_44_c400 := map(
    (rv_i60_inq_other_recency in [0, 12, 24, 6, 99]) => final_score_tree_44_c401,
    (rv_i60_inq_other_recency in [1, 3])                   => 0.1676004390,
                                                                  0.0182379875);

final_score_tree_44 := map(
    NULL < iv_dob_src_ct AND iv_dob_src_ct < 10.5 => -0.0048827111,
    iv_dob_src_ct >= 10.5                         => final_score_tree_44_c400,
                                                     0.0048433392);

final_score_tree_45_c404 := map(
    NULL < nf_invbest_inq_peraddr_diff AND nf_invbest_inq_peraddr_diff < -0.5 => 0.0170911273,
    nf_invbest_inq_peraddr_diff >= -0.5                                       => 0.2305997055,
                                                                                 0.0523494246);

final_score_tree_45_c403 := map(
    NULL < nf_age_at_ssn_issuance AND nf_age_at_ssn_issuance < 18.5 => -0.0262315502,
    nf_age_at_ssn_issuance >= 18.5                                  => final_score_tree_45_c404,
                                                                       -0.0163408733);

final_score_tree_45 := map(
    NULL < rv_f00_dob_score AND rv_f00_dob_score < 92 => 0.0980444600,
    rv_f00_dob_score >= 92                            => final_score_tree_45_c403,
                                                         -0.0130461702);

final_score_tree_46_c407 := map(
    NULL < nf_adls_per_curraddr_curr AND nf_adls_per_curraddr_curr < 3.5 => 0.0191745628,
    nf_adls_per_curraddr_curr >= 3.5                                     => -0.0785035316,
                                                                            -0.0012408357);

final_score_tree_46_c406 := map(
    NULL < nf_m_snc_ssn_high_issue AND nf_m_snc_ssn_high_issue < 64.5 => 0.1756144173,
    nf_m_snc_ssn_high_issue >= 64.5                                   => final_score_tree_46_c407,
                                                                         0.0023602894);

final_score_tree_46 := map(
    NULL < nf_fp_validationrisktype AND nf_fp_validationrisktype < 1.5 => final_score_tree_46_c406,
    nf_fp_validationrisktype >= 1.5                                    => 0.1614626007,
                                                                          0.0055916879);

final_score_tree_47_c410 := map(
    NULL < nf_invbest_inq_adlsperphone_diff AND nf_invbest_inq_adlsperphone_diff < 0.5 => 0.0324431805,
    nf_invbest_inq_adlsperphone_diff >= 0.5                                            => 0.1785934059,
                                                                                          0.0436567527);

final_score_tree_47_c409 := map(
    NULL < nf_m_src_credentialed_fs AND nf_m_src_credentialed_fs < 222.5 => -0.0384702986,
    nf_m_src_credentialed_fs >= 222.5                                    => final_score_tree_47_c410,
                                                                            -0.0106324279);

final_score_tree_47 := map(
    NULL < nf_inq_per_ssn AND nf_inq_per_ssn < 2.5 => final_score_tree_47_c409,
    nf_inq_per_ssn >= 2.5                          => -0.0762913809,
                                                      -0.0203444309);

final_score_tree_48_c413 := map(
    (rv_i62_inq_addrsperadl_recency in [0, 12, 3, 6]) => -0.0062986342,
    (rv_i62_inq_addrsperadl_recency in [1])                 => 0.1995971697,
                                                                 0.0016100654);

final_score_tree_48_c412 := map(
    NULL < (Integer)iv_nap_nothing_found AND (integer)iv_nap_nothing_found < 0.5 => final_score_tree_48_c413,
    (integer)iv_nap_nothing_found >= 0.5                                => 0.1984403820,
                                                                  0.0078494034);

final_score_tree_48 := map(
    NULL < nf_adls_per_bestssn AND nf_adls_per_bestssn < 1.5 => final_score_tree_48_c412,
    nf_adls_per_bestssn >= 1.5                               => -0.0241071691,
                                                                0.0039482114);

final_score_tree_49_c416 := map(
    NULL < nf_add_dist_input_to_curr AND nf_add_dist_input_to_curr < 189.5 => -0.0079162994,
    nf_add_dist_input_to_curr >= 189.5                                     => 0.1813151738,
                                                                              -0.0017596496);

final_score_tree_49_c415 := map(
    NULL < nf_m_snc_ssn_high_issue AND nf_m_snc_ssn_high_issue < 634.5 => final_score_tree_49_c416,
    nf_m_snc_ssn_high_issue >= 634.5                                   => 0.0843954649,
                                                                          0.0038457106);

final_score_tree_49 := map(
    NULL < nf_adls_per_bestssn AND nf_adls_per_bestssn < 1.5 => final_score_tree_49_c415,
    nf_adls_per_bestssn >= 1.5                               => -0.0364298081,
                                                                -0.0010673949);

final_score_tree_50_c419 := map(
    NULL < nf_inq_lname_ver_count AND nf_inq_lname_ver_count < 6.5 => 0.3336118883,
    nf_inq_lname_ver_count >= 6.5                                  => 0.0286274249,
                                                                      0.1839435868);

final_score_tree_50_c418 := map(
    (rv_i61_inq_collection_recency in [0, 1, 12, 6, 99]) => 0.0047689022,
    (rv_i61_inq_collection_recency in [24, 3])                 => final_score_tree_50_c419,
                                                                      0.0120546198);

final_score_tree_50 := map(
    NULL < nf_m_snc_ssn_high_issue AND nf_m_snc_ssn_high_issue < 50.5 => -0.1550716647,
    nf_m_snc_ssn_high_issue >= 50.5                                   => final_score_tree_50_c418,
                                                                         0.0089722464);

final_score_tree_51_c422 := map(
    (nf_historic_x_current_ct in ['0-0', '1-0', '2-2', '3-0'])               => -0.0724053339,
    (nf_historic_x_current_ct in ['1-1', '2-0', '2-1', '3-1', '3-2', '3-3']) => 0.3058980138,
                                                                                0.0715757910);

final_score_tree_51_c421 := map(
    NULL < nf_m_snc_ssn_high_issue AND nf_m_snc_ssn_high_issue < 136 => final_score_tree_51_c422,
    nf_m_snc_ssn_high_issue >= 136                                   => -0.0331136203,
                                                                        -0.0271819581);

final_score_tree_51 := map(
    NULL < nf_adls_per_bestssn AND nf_adls_per_bestssn < 1.5 => final_score_tree_51_c421,
    nf_adls_per_bestssn >= 1.5                               => -0.0279844843,
                                                                -0.0272814939);

final_score_tree_52_c425 := map(
    NULL < rv_p88_phn_dst_to_inp_add AND rv_p88_phn_dst_to_inp_add < 18.5 => 0.0380652690,
    rv_p88_phn_dst_to_inp_add >= 18.5                                     => 0.1972671725,
                                                                             0.0265146894);

final_score_tree_52_c424 := map(
    NULL < nf_adls_per_bestssn AND nf_adls_per_bestssn < 1.5 => final_score_tree_52_c425,
    nf_adls_per_bestssn >= 1.5                               => 0.0451263287,
                                                                0.0451093410);

final_score_tree_52 := map(
    (nf_inquiry_verification_index in [0, 11, 23, 25, 27, 3, 31])                 => -0.0318695205,
    (nf_inquiry_verification_index in [1, 13, 15, 17, 19, 21, 29, 5, 7, 9]) => final_score_tree_52_c424,
                                                                                                   -0.0051300931);

final_score_tree_53_c428 := map(
    (nf_inq_addrsperssn_recency in [0, 12, 6]) => -0.0089367805,
    (nf_inq_addrsperssn_recency in [1, 3])       => 0.1491478024,
                                                        0.0016573695);

final_score_tree_53_c427 := map(
    NULL < nf_m_snc_ssn_high_issue AND nf_m_snc_ssn_high_issue < 122.5 => 0.1316941753,
    nf_m_snc_ssn_high_issue >= 122.5                                   => final_score_tree_53_c428,
                                                                          0.0081268623);

final_score_tree_53 := map(
    (rv_i60_inq_auto_recency in [1, 12, 24, 3, 6, 99]) => -0.1014429089,
    (rv_i60_inq_auto_recency in [0])                             => final_score_tree_53_c427,
                                                                      -0.0200447523);

final_score_tree_54_c431 := map(
    NULL < nf_adls_per_bestssn AND nf_adls_per_bestssn < 1.5 => -0.0092169761,
    nf_adls_per_bestssn >= 1.5                               => -0.0151239272,
                                                                -0.0099662625);

final_score_tree_54_c430 := map(
    NULL < nf_inq_per_phone AND nf_inq_per_phone < 4.5 => final_score_tree_54_c431,
    nf_inq_per_phone >= 4.5                            => 0.1613117431,
                                                          -0.0063303382);

final_score_tree_54 := map(
    NULL < iv_f00_nas_summary AND iv_f00_nas_summary < 10.5 => -0.0731309085,
    iv_f00_nas_summary >= 10.5                              => final_score_tree_54_c430,
                                                               -0.0078104099);

final_score_tree_55_c434 := map(
    (rv_c13_attr_addrs_recency in [120, 24, 60, 999])         => 0.0173650113,
    (rv_c13_attr_addrs_recency in [0, 1, 12, 180, 3, 36]) => 0.2803982778,
                                                                         0.1099137532);

final_score_tree_55_c433 := map(
    NULL < nf_inq_fname_ver_count AND nf_inq_fname_ver_count < 2.5 => final_score_tree_55_c434,
    nf_inq_fname_ver_count >= 2.5                                  => -0.0066890395,
                                                                      -0.0754230705);

final_score_tree_55 := map(
    NULL < iv_dob_src_ct AND iv_dob_src_ct < 11.5 => -0.0161741077,
    iv_dob_src_ct >= 11.5                         => final_score_tree_55_c433,
                                                     -0.0080881942);

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
    final_score_tree_55;

pbr := 0.05;

sbr := 0.1;

base := 700;

pts := -50;

lgt := ln(sbr / (1 - sbr));

offset := ln(((1 - pbr) * sbr) / (pbr * (1 - sbr)));

fp1508_1_0 := min(if(max(round(base + pts * (final_score_gbm_logit - offset - lgt) / ln(2)), 300) = NULL,
                                -NULL, max(round(base + pts * (final_score_gbm_logit - offset - lgt) / ln(2)), 300)), 999);
                                
//fp1508_1_0 := __common__( round(max((real)300, min(999, if(base + pts * (final_score_gbm_logit - offset - lgt) / ln(2) = NULL, -NULL, base + pts * (final_score_gbm_logit - offset - lgt) / ln(2))))));                                
                                

_ver_src_ds := Models.Common.findw_cpp(ver_sources, 'DS' , ', ', '') > 0;

_ver_src_de := Models.Common.findw_cpp(ver_sources, 'DE' , ', ', '') > 0;

_derog := felony_count > 0 OR (integer)addrs_prison_history > 0 OR attr_num_unrel_liens60 > 0 OR attr_eviction_count > 0 OR stl_inq_count > 0 OR inq_highriskcredit_count12 > 0 OR inq_collection_count12 >= 2;

_deceased := rc_decsflag = '1' OR rc_ssndod != 0 OR _ver_src_ds OR _ver_src_de;

_ssnpriortodob := rc_ssndobflag = '1' OR rc_pwssndobflag = '1';

_inputmiskeys := rc_ssnmiskeyflag or rc_addrmiskeyflag or (integer)add_input_house_number_match = 0;

_multiplessns := ssns_per_adl >= 2 OR ssns_per_adl_c6 >= 1 OR invalid_ssns_per_adl >= 1;

_hh_strikes := if((integer)max((integer)hh_members_w_derog > 0, (integer)hh_criminals > 0, (integer)hh_payday_loan_users > 0) = NULL, NULL, 
                (integer)sum((integer)hh_members_w_derog > 0, (integer)hh_criminals > 0, (integer)hh_payday_loan_users > 0));

stolenid := if(addrpop and (nas_summary in [4, 7, 9]) or fnamepop and lnamepop and addrpop and 1 <= nas_summary AND nas_summary <= 9 and inq_count03 > 0 and 
          ssnlength = '9' or _deceased or _ssnpriortodob, 1, 0);

manipulatedid := if(_inputmiskeys and (_multiplessns or lnames_per_adl_c6 > 1), 1, 0);

manipulatedidpt2 := if(1 <= nas_summary AND nas_summary <= 9 and inq_count03 > 0 and ssnlength = '9', 1, 0);

_sum_bureau := if(max((integer)ver_src_eq, (integer)ver_src_en, (integer)ver_src_tn) = NULL, NULL, sum((integer)ver_src_eq, (integer)ver_src_en, (integer)ver_src_tn));

_sum_credentialed := if(max((integer)ver_src_ar, (integer)ver_src_am, (integer)ver_src_ba, (integer)ver_src_cg, (integer)ver_src_da, (integer)ver_src_d, (integer)ver_src_dl, (integer)ver_src_eb, (integer)ver_src_e1, (integer)ver_src_e2, (integer)ver_src_e3, (integer)ver_src_fe, (integer)ver_src_ff, (integer)ver_src_p, (integer)ver_src_pl, (integer)ver_src_sl, (integer)ver_src_v, (integer)ver_src_vo, (integer)ver_src_w) = NULL, NULL, sum((integer)ver_src_ar, (integer)ver_src_am, (integer)ver_src_ba, (integer)ver_src_cg, (integer)ver_src_da, (integer)ver_src_d, (integer)ver_src_dl, (integer)ver_src_eb, (integer)ver_src_e1, (integer)ver_src_e2, (integer)ver_src_e3, (integer)ver_src_fe, (integer)ver_src_ff, (integer)ver_src_p, (integer)ver_src_pl, (integer)ver_src_sl, (integer)ver_src_v, (integer)ver_src_vo, (integer)ver_src_w));

syntheticid := _sum_credentialed = 0 and _sum_bureau > 0 and rv_a41_a42_prop_owner_history = 0 OR (Integer)truedid = 0;

suspiciousactivity := if(_derog, 1, 0);

vulnerablevictim := if(0 < inferred_age AND inferred_age <= 17 or inferred_age >= 70, 1, 0);

friendlyfraud := if(hh_members_ct > 1 and (hh_payday_loan_users > 0 or _hh_strikes >= 2 or rel_felony_count >= 2), 1, 0);

stolenc_fp1508_1_0 := if((boolean)(integer)stolenid, fp1508_1_0, 299);

manip2c_fp1508_1_0 := if((boolean)(integer)manipulatedid or (boolean)(integer)manipulatedidpt2, fp1508_1_0, 299);

synthc_fp1508_1_0 := if(syntheticid, fp1508_1_0, 299);

suspactc_fp1508_1_0 := if((boolean)(integer)suspiciousactivity, fp1508_1_0, 299);

vulnvicc_fp1508_1_0 := if((boolean)(integer)vulnerablevictim, fp1508_1_0, 299);

friendlyc_fp1508_1_0 := if((boolean)(integer)friendlyfraud, fp1508_1_0, 299);

fp1508_1_0_stolidindex := map(
    stolenc_fp1508_1_0 = 299                                => 1,
    300 <= stolenc_fp1508_1_0 AND stolenc_fp1508_1_0 <= 406 => 9,
    407 <= stolenc_fp1508_1_0 AND stolenc_fp1508_1_0 <= 461 => 8,
    462 <= stolenc_fp1508_1_0 AND stolenc_fp1508_1_0 <= 527 => 7,
    528 <= stolenc_fp1508_1_0 AND stolenc_fp1508_1_0 <= 541 => 6,
    542 <= stolenc_fp1508_1_0 AND stolenc_fp1508_1_0 <= 626 => 5,
    627 <= stolenc_fp1508_1_0 AND stolenc_fp1508_1_0 <= 679 => 4,
    680 <= stolenc_fp1508_1_0 AND stolenc_fp1508_1_0 <= 725 => 3,
                                                               2);

fp1508_1_0_synthidindex := map(
    synthc_fp1508_1_0 = 299                               => 1,
    300 <= synthc_fp1508_1_0 AND synthc_fp1508_1_0 <= 652 => 9,
    653 <= synthc_fp1508_1_0 AND synthc_fp1508_1_0 <= 681 => 8,
    682 <= synthc_fp1508_1_0 AND synthc_fp1508_1_0 <= 754 => 7,
    755 <= synthc_fp1508_1_0 AND synthc_fp1508_1_0 <= 772 => 6,
    773 <= synthc_fp1508_1_0 AND synthc_fp1508_1_0 <= 787 => 5,
    788 <= synthc_fp1508_1_0 AND synthc_fp1508_1_0 <= 818 => 4,
    819 <= synthc_fp1508_1_0 AND synthc_fp1508_1_0 <= 859 => 3,
                                                             2);

fp1508_1_0_manipidindex := map(
    manip2c_fp1508_1_0 = 299                                => 1,
    300 <= manip2c_fp1508_1_0 AND manip2c_fp1508_1_0 <= 475 => 9,
    476 <= manip2c_fp1508_1_0 AND manip2c_fp1508_1_0 <= 522 => 8,
    523 <= manip2c_fp1508_1_0 AND manip2c_fp1508_1_0 <= 612 => 7,
    613 <= manip2c_fp1508_1_0 AND manip2c_fp1508_1_0 <= 697 => 6,
    698 <= manip2c_fp1508_1_0 AND manip2c_fp1508_1_0 <= 722 => 5,
    723 <= manip2c_fp1508_1_0 AND manip2c_fp1508_1_0 <= 756 => 4,
    757 <= manip2c_fp1508_1_0 AND manip2c_fp1508_1_0 <= 871 => 3,
                                                               2);

fp1508_1_0_vulnvicindex := map(
    vulnvicc_fp1508_1_0 = 299                                 => 1,
    300 <= vulnvicc_fp1508_1_0 AND vulnvicc_fp1508_1_0 <= 354 => 9,
    355 <= vulnvicc_fp1508_1_0 AND vulnvicc_fp1508_1_0 <= 486 => 8,
    487 <= vulnvicc_fp1508_1_0 AND vulnvicc_fp1508_1_0 <= 530 => 7,
    531 <= vulnvicc_fp1508_1_0 AND vulnvicc_fp1508_1_0 <= 570 => 6,
    571 <= vulnvicc_fp1508_1_0 AND vulnvicc_fp1508_1_0 <= 612 => 5,
    613 <= vulnvicc_fp1508_1_0 AND vulnvicc_fp1508_1_0 <= 671 => 4,
    672 <= vulnvicc_fp1508_1_0 AND vulnvicc_fp1508_1_0 <= 740 => 3,
                                                                 2);

fp1508_1_0_friendfrdindex := map(
    friendlyc_fp1508_1_0 = 299                                  => 1,
    300 <= friendlyc_fp1508_1_0 AND friendlyc_fp1508_1_0 <= 431 => 9,
    432 <= friendlyc_fp1508_1_0 AND friendlyc_fp1508_1_0 <= 525 => 8,
    526 <= friendlyc_fp1508_1_0 AND friendlyc_fp1508_1_0 <= 601 => 7,
    602 <= friendlyc_fp1508_1_0 AND friendlyc_fp1508_1_0 <= 637 => 6,
    638 <= friendlyc_fp1508_1_0 AND friendlyc_fp1508_1_0 <= 676 => 5,
    677 <= friendlyc_fp1508_1_0 AND friendlyc_fp1508_1_0 <= 723 => 4,
    724 <= friendlyc_fp1508_1_0 AND friendlyc_fp1508_1_0 <= 804 => 3,
                                                                   2);

fp1508_1_0_suspactindex := map(
    suspactc_fp1508_1_0 = 299                                   => 1,
    300 <= suspactc_fp1508_1_0 AND suspactc_fp1508_1_0 <= 425 => 9,
    426 <= suspactc_fp1508_1_0 AND suspactc_fp1508_1_0 <= 544 => 8,
    545 <= suspactc_fp1508_1_0 AND suspactc_fp1508_1_0 <= 601 => 7,
    602 <= suspactc_fp1508_1_0 AND suspactc_fp1508_1_0 <= 631 => 6,
    632 <= suspactc_fp1508_1_0 AND suspactc_fp1508_1_0 <= 661 => 5,
    662 <= suspactc_fp1508_1_0 AND suspactc_fp1508_1_0 <= 692 => 4,
    693 <= suspactc_fp1508_1_0 AND suspactc_fp1508_1_0 <= 753 => 3,
                                                                 2);




	 
//*************************************************************************************//
//     End Generated ECL Code
//*************************************************************************************//

	#if(FP_DEBUG)
		/* Model Input Variables */
                      self.sysdate                          := sysdate;
                    self.ver_src_ak_pos                   := ver_src_ak_pos;
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
                    self._ver_src_fdate_ds                := _ver_src_fdate_ds;
                    self.ver_src_fdate_ds                 := ver_src_fdate_ds;
                    self.ver_src_de_pos                   := ver_src_de_pos;
                    self._ver_src_fdate_de                := _ver_src_fdate_de;
                    self.ver_src_fdate_de                 := ver_src_fdate_de;
                    self.ver_src_eb_pos                   := ver_src_eb_pos;
                    self.ver_src_eb                       := ver_src_eb;
                    self._ver_src_fdate_eb                := _ver_src_fdate_eb;
                    self.ver_src_fdate_eb                 := ver_src_fdate_eb;
                    self.ver_src_em_pos                   := ver_src_em_pos;
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
                    self._ver_src_fdate_e4                := _ver_src_fdate_e4;
                    self.ver_src_fdate_e4                 := ver_src_fdate_e4;
                    self.ver_src_en_pos                   := ver_src_en_pos;
                    self.ver_src_en                       := ver_src_en;
                    self._ver_src_fdate_en                := _ver_src_fdate_en;
                    self.ver_src_fdate_en                 := ver_src_fdate_en;
                    self.ver_src_eq_pos                   := ver_src_eq_pos;
                    self.ver_src_eq                       := ver_src_eq;
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
                    self._ver_src_fdate_fr                := _ver_src_fdate_fr;
                    self.ver_src_fdate_fr                 := ver_src_fdate_fr;
                    self.ver_src_l2_pos                   := ver_src_l2_pos;
                    self._ver_src_fdate_l2                := _ver_src_fdate_l2;
                    self.ver_src_fdate_l2                 := ver_src_fdate_l2;
                    self.ver_src_li_pos                   := ver_src_li_pos;
                    self._ver_src_fdate_li                := _ver_src_fdate_li;
                    self.ver_src_fdate_li                 := ver_src_fdate_li;
                    self.ver_src_mw_pos                   := ver_src_mw_pos;
                    self._ver_src_fdate_mw                := _ver_src_fdate_mw;
                    self.ver_src_fdate_mw                 := ver_src_fdate_mw;
                    self.ver_src_nt_pos                   := ver_src_nt_pos;
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
                    self.ver_src_tn                       := ver_src_tn;
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
                    self._ver_src_fdate_wp                := _ver_src_fdate_wp;
                    self.ver_src_fdate_wp                 := ver_src_fdate_wp;
                    self.ver_fname_src_en_pos             := ver_fname_src_en_pos;
                    self.ver_fname_src_en                 := ver_fname_src_en;
                    self.ver_fname_src_eq_pos             := ver_fname_src_eq_pos;
                    self.ver_fname_src_eq                 := ver_fname_src_eq;
                    self.ver_fname_src_tn_pos             := ver_fname_src_tn_pos;
                    self.ver_fname_src_tn                 := ver_fname_src_tn;
                    self.ver_lname_src_en_pos             := ver_lname_src_en_pos;
                    self.ver_lname_src_en                 := ver_lname_src_en;
                    self.ver_lname_src_eq_pos             := ver_lname_src_eq_pos;
                    self.ver_lname_src_eq                 := ver_lname_src_eq;
                    self.ver_lname_src_tn_pos             := ver_lname_src_tn_pos;
                    self.ver_lname_src_tn                 := ver_lname_src_tn;
                    self.ver_addr_src_en_pos              := ver_addr_src_en_pos;
                    self.ver_addr_src_en                  := ver_addr_src_en;
                    self.ver_addr_src_eq_pos              := ver_addr_src_eq_pos;
                    self.ver_addr_src_eq                  := ver_addr_src_eq;
                    self.ver_addr_src_tn_pos              := ver_addr_src_tn_pos;
                    self.ver_addr_src_tn                  := ver_addr_src_tn;
                    self.ver_ssn_src_en_pos               := ver_ssn_src_en_pos;
                    self.ver_ssn_src_en                   := ver_ssn_src_en;
                    self.ver_ssn_src_eq_pos               := ver_ssn_src_eq_pos;
                    self.ver_ssn_src_eq                   := ver_ssn_src_eq;
                    self.ver_ssn_src_tn_pos               := ver_ssn_src_tn_pos;
                    self.ver_ssn_src_tn                   := ver_ssn_src_tn;
                    self.ver_dob_src_en_pos               := ver_dob_src_en_pos;
                    self.ver_dob_src_en                   := ver_dob_src_en;
                    self.ver_dob_src_eq_pos               := ver_dob_src_eq_pos;
                    self.ver_dob_src_eq                   := ver_dob_src_eq;
                    self.ver_dob_src_tn_pos               := ver_dob_src_tn_pos;
                    self.ver_dob_src_tn                   := ver_dob_src_tn;
                    self.util_type_2_pos                  := util_type_2_pos;
                    self.util_type_2                      := util_type_2;
                    self.util_type_1_pos                  := util_type_1_pos;
                    self.util_type_1                      := util_type_1;
                    self.util_type_z_pos                  := util_type_z_pos;
                    self.util_type_z                      := util_type_z;
                   // self.util_inp_2_pos                   := util_inp_2_pos;
                    self.util_inp_2                       := util_inp_2;
                   // self.util_inp_1_pos                   := util_inp_1_pos;
                    self.util_inp_1                       := util_inp_1;
                    //self.util_inp_z_pos                   := util_inp_z_pos;
                    self.util_inp_z                       := util_inp_z;
                    self.iv_add_apt                       := iv_add_apt;
                    self.nf_email_name_addr_ver           := nf_email_name_addr_ver;
                    self._rc_ssnhighissue                 := _rc_ssnhighissue;
                    self.nf_m_snc_ssn_high_issue          := nf_m_snc_ssn_high_issue;
                    self.iv_nap_inf_phone_ver_lvl         := iv_nap_inf_phone_ver_lvl;
                    self.nf_inquiry_verification_index    := nf_inquiry_verification_index;
                    self.nf_phone_ver_insurance           := nf_phone_ver_insurance;
                    self.rv_c12_source_profile            := rv_c12_source_profile;
                    self.nf_adls_per_bestssn              := nf_adls_per_bestssn;
                    self.iv_dob_src_ct                    := iv_dob_src_ct;
                    self.iv_f00_nas_summary               := iv_f00_nas_summary;
                    self.earliest_bureau_date             := earliest_bureau_date;
                    self.earliest_bureau_yrs              := earliest_bureau_yrs;
                    self.iv_bureau_emergence_age          := iv_bureau_emergence_age;
                    self.nf_inq_phone_ver_count           := nf_inq_phone_ver_count;
                    self.nf_util_add_input_summary        := nf_util_add_input_summary;
                    self.nf_dl_addrs_per_adl              := nf_dl_addrs_per_adl;
                    self.rv_i62_inq_phonesperadl_recency  := rv_i62_inq_phonesperadl_recency;
                    self.rv_f00_dob_score                 := rv_f00_dob_score;
                    self.nf_add_dist_input_to_curr        := nf_add_dist_input_to_curr;
                    self.nf_inq_per_phone                 := nf_inq_per_phone;
                    self.iv_inf_phn_verd                  := iv_inf_phn_verd;
                    self.nf_age_at_ssn_issuance           := nf_age_at_ssn_issuance;
                    self.nf_inq_perphone_recency          := nf_inq_perphone_recency;
                    self.rv_c20_m_bureau_adl_fs           := rv_c20_m_bureau_adl_fs;
                    self.nf_historic_x_current_ct         := nf_historic_x_current_ct;
                    self.rv_e58_br_dead_bus_x_active_phn  := rv_e58_br_dead_bus_x_active_phn;
                    self.nf_addrs_per_ssn                 := nf_addrs_per_ssn;
                    self.iv_addr_non_phn_src_ct           := iv_addr_non_phn_src_ct;
                    self.rv_i60_inq_other_recency         := rv_i60_inq_other_recency;
                    self.rv_p88_phn_dst_to_inp_add        := rv_p88_phn_dst_to_inp_add;
                    self.rv_c12_inp_addr_source_count     := rv_c12_inp_addr_source_count;
                    self.rv_email_count                   := rv_email_count;
                    self.nf_unvrfd_search_risk_index      := nf_unvrfd_search_risk_index;
                    self.rv_c13_attr_addrs_recency        := rv_c13_attr_addrs_recency;
                    self.iv_phn_cell                      := iv_phn_cell;
                    self.iv_f00_email_verification        := iv_f00_email_verification;
                    self._rc_ssnlowissue                  := _rc_ssnlowissue;
                    self._in_dob                          := _in_dob;
                    self.ssn_years                        := ssn_years;
                    self.calc_dob                         := calc_dob;
                    self._age_at_ssn_issuance             := _age_at_ssn_issuance;
                    self.nf_age_at_ssn_issuance_19_61     := nf_age_at_ssn_issuance_19_61;
                    self.earliest_cred_date_all           := earliest_cred_date_all;
                    self.nf_m_src_credentialed_fs         := nf_m_src_credentialed_fs;
                    self.rv_c18_invalid_addrs_per_adl     := rv_c18_invalid_addrs_per_adl;
                    self.nf_inq_per_ssn                   := nf_inq_per_ssn;
                    self.nf_inq_perssn_count_week         := nf_inq_perssn_count_week;
                    self.num_bureau_fname                 := num_bureau_fname;
                    self.num_bureau_lname                 := num_bureau_lname;
                    self.num_bureau_addr                  := num_bureau_addr;
                    self.num_bureau_ssn                   := num_bureau_ssn;
                    self.num_bureau_dob                   := num_bureau_dob;
                    self.iv_bureau_verification_index     := iv_bureau_verification_index;
                    self.rv_i61_inq_collection_recency    := rv_i61_inq_collection_recency;
                    self.iv_prv_addr_lres                 := iv_prv_addr_lres;
                    self.earliest_header_date             := earliest_header_date;
                    self.earliest_header_yrs              := earliest_header_yrs;
                    self.iv_header_emergence_age          := iv_header_emergence_age;
                    self.nf_fp_validationrisktype         := nf_fp_validationrisktype;
                    self.iv_src_voter_adl_count           := iv_src_voter_adl_count;
                    self.vo_pos                           := vo_pos;
                    self.vote_adl_lseen_vo                := vote_adl_lseen_vo;
                    self._vote_adl_lseen_vo               := _vote_adl_lseen_vo;
                    self.iv_mos_src_voter_adl_lseen       := iv_mos_src_voter_adl_lseen;
                    self.iv_college_major                 := iv_college_major;
                    self.rv_c12_source_profile_index      := rv_c12_source_profile_index;
                    self.nf_util_adl_summary              := nf_util_adl_summary;
                    self.iv_c13_avg_lres                  := iv_c13_avg_lres;
                    self.iv_nap_nothing_found             := iv_nap_nothing_found;
                    self.d_pos                            := d_pos;
                    self.lic_adl_count_d                  := lic_adl_count_d;
                    self.dl_pos                           := dl_pos;
                    self.lic_adl_count_dl                 := lic_adl_count_dl;
                    self.src_drivers_license_adl_count    := src_drivers_license_adl_count;
                    self.iv_src_drivers_lic_adl_count     := iv_src_drivers_lic_adl_count;
                    self.nf_fp_idveraddressnotcurrent     := nf_fp_idveraddressnotcurrent;
                    self.nf_inq_dobsperssn_recency        := nf_inq_dobsperssn_recency;
                    self.rv_i60_inq_auto_recency          := rv_i60_inq_auto_recency;
                    self.nf_inq_bestssn_ver_count         := nf_inq_bestssn_ver_count;
                    self.nf_phones_per_sfd_addr_curr      := nf_phones_per_sfd_addr_curr;
                    self.rv_i62_inq_fnamesperadl_recency  := rv_i62_inq_fnamesperadl_recency;
                    self.nf_addrs_per_bestssn             := nf_addrs_per_bestssn;
                    self.nf_invbest_inq_peraddr_diff      := nf_invbest_inq_peraddr_diff;
                    self.nf_adl_per_email                 := nf_adl_per_email;
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
                    self.nf_inq_addrsperssn_recency       := nf_inq_addrsperssn_recency;
                    self.rv_i62_inq_addrsperadl_recency   := rv_i62_inq_addrsperadl_recency;
                    self.nf_acc_damage_amt_total          := nf_acc_damage_amt_total;
                    self.nf_invbest_inq_adlsperphone_diff := nf_invbest_inq_adlsperphone_diff;
                    self.nf_acc_damage_amt_last           := nf_acc_damage_amt_last;
                    self.nf_inq_fname_ver_count           := nf_inq_fname_ver_count;
                    self.nf_inq_lname_ver_count           := nf_inq_lname_ver_count;
                    self.nf_adls_per_curraddr_curr        := nf_adls_per_curraddr_curr;
                    self.rv_a41_a42_prop_owner_history    := rv_a41_a42_prop_owner_history;
                    self.nf_phone_ver_experian            := nf_phone_ver_experian;
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
                    self.final_score_gbm_logit            := final_score_gbm_logit;
                    self.pbr                              := pbr;
                    self.sbr                              := sbr;
                    self.base                             := base;
                    self.pts                              := pts;
                    self.lgt                              := lgt;
                    self.offset                           := offset;
                    self.fp1508_1_0                       := fp1508_1_0;
                    self._ver_src_ds                      := _ver_src_ds;
                    self._ver_src_de                      := _ver_src_de;
                    self._derog                           := _derog;
                    self._deceased                        := _deceased;
                    self._ssnpriortodob                   := _ssnpriortodob;
                    self._inputmiskeys                    := _inputmiskeys;
                    self._multiplessns                    := _multiplessns;
                    self._hh_strikes                      := _hh_strikes;
                    self.stolenid                         := stolenid;
                    self.manipulatedid                    := manipulatedid;
                    self.manipulatedidpt2                 := manipulatedidpt2;
                    self._sum_bureau                      := _sum_bureau;
                    self._sum_credentialed                := _sum_credentialed;
                    self.syntheticid                      := syntheticid;
                    self.suspiciousactivity               := suspiciousactivity;
                    self.vulnerablevictim                 := vulnerablevictim;
                    self.friendlyfraud                    := friendlyfraud;
                    self.stolenc_fp1508_1_0               := stolenc_fp1508_1_0;
                    self.manip2c_fp1508_1_0               := manip2c_fp1508_1_0;
                    self.synthc_fp1508_1_0                := synthc_fp1508_1_0;
                    self.suspactc_fp1508_1_0              := suspactc_fp1508_1_0;
                    self.vulnvicc_fp1508_1_0              := vulnvicc_fp1508_1_0;
                    self.friendlyc_fp1508_1_0             := friendlyc_fp1508_1_0;
                    self.fp1508_1_0_stolidindex           := fp1508_1_0_stolidindex;
                    self.fp1508_1_0_synthidindex          := fp1508_1_0_synthidindex;
                    self.fp1508_1_0_manipidindex          := fp1508_1_0_manipidindex;
                    self.fp1508_1_0_vulnvicindex          := fp1508_1_0_vulnvicindex;
                    self.fp1508_1_0_friendfrdindex        := fp1508_1_0_friendfrdindex;
                    self.fp1508_1_0_suspactindex          := fp1508_1_0_suspactindex;
                    // self.custstolidindex                  := custstolidindex;
                    // self.custmanipidindex                 := custmanipidindex;
                    // self.custsynthidindex                 := custsynthidindex;
                    // self.custsuspactindex                 := custsuspactindex;
                    // self.custvulnvicindex                 := custvulnvicindex;
                    // self.custfriendfrdindex               := custfriendfrdindex;

                    SELF.clam := le;
#end

	 self.seq := le.seq;
	self.StolenIdentityIndex := (string) fp1508_1_0_stolidindex;
	self.SyntheticIdentityIndex:= (string) fp1508_1_0_synthidindex;
	self.ManipulatedIdentityIndex:= (string) fp1508_1_0_manipidindex;
	self.VulnerableVictimIndex := (string) fp1508_1_0_vulnvicindex;
	self.FriendlyFraudIndex                := (string) fp1508_1_0_friendfrdindex;
	self.SuspiciousActivityIndex := (string) fp1508_1_0_suspactindex;
	ritmp :=  Models.fraudpoint3_reasons(le, blank_ip, num_reasons );
	reasons := Models.Common.checkFraudPointRC34(FP1508_1_0, ritmp, num_reasons);
	self.ri := reasons;
	self.score := (String)FP1508_1_0;
	self := [];
END;

 model :=  project(clam, doModel(left) );

		return model;
END;
import Std, risk_indicators, riskwise, riskwisefcra, ut, Models;

blank_ip := dataset( [{0}], riskwise.Layout_IP2O )[1];

export FP1806_1_0(dataset(risk_indicators.Layout_Boca_Shell) clam,
                  integer1 num_reasons)
									 := FUNCTION
									
		// FP_DEBUG := True;
		FP_DEBUG := False;
		
		isFCRA := False;

	#if(FP_DEBUG)
	Layout_Debug := RECORD
  /* Model Input Variables */
	  STRING10 model_name;
		unsigned4 seq;
		INTEGER sysdate                         ;
		INTEGER ver_src_ak_pos                  ;                                                      
		BOOLEAN ver_src_ak                      ;                                                      
		INTEGER ver_src_am_pos                  ;                                                      
		BOOLEAN ver_src_am                      ;                                                      
		STRING _ver_src_fdate_am               ;                                                      
		INTEGER ver_src_fdate_am                ;                                                      
		INTEGER ver_src_ar_pos                  ;                                                      
		BOOLEAN ver_src_ar                      ;                                                      
		STRING _ver_src_fdate_ar               ;                                                      
		INTEGER ver_src_fdate_ar                ;                                                      
		INTEGER ver_src_ba_pos                  ;                                                      
		BOOLEAN ver_src_ba                      ;                                                      
		STRING _ver_src_fdate_ba               ;                                                      
		INTEGER ver_src_fdate_ba                ;                                                      
		INTEGER ver_src_cg_pos                  ;                                                      
		BOOLEAN ver_src_cg                      ;                                                      
    STRING _ver_src_fdate_cg               ;                                                      
    INTEGER ver_src_fdate_cg                ;                                                      
    INTEGER ver_src_cy_pos                  ;                                                      
    BOOLEAN ver_src_cy                      ;                                                      
    INTEGER ver_src_da_pos                  ;                                                      
    BOOLEAN ver_src_da                      ;                                                      
    STRING _ver_src_fdate_da               ;                                                      
    INTEGER ver_src_fdate_da                ;                                                      
    INTEGER ver_src_d_pos                   ;                                                      
    BOOLEAN ver_src_d                       ;                                                      
    STRING _ver_src_fdate_d                ;                                                      
    INTEGER ver_src_fdate_d                 ;                                                      
    BOOLEAN ver_src_dl_pos                  ;                                                      
    BOOLEAN ver_src_dl                      ;                                                      
    STRING _ver_src_fdate_dl               ;                                                      
    INTEGER ver_src_fdate_dl                ;                                                      
    INTEGER ver_src_eb_pos                  ;                                                      
    BOOLEAN ver_src_eb                      ;                                                      
STRING _ver_src_fdate_eb               ;                                                      
INTEGER ver_src_fdate_eb                ;                                                      
INTEGER ver_src_em_pos                  ;                                                      
BOOLEAN ver_src_em                      ;                                                      
INTEGER ver_src_e1_pos                  ;                                                      
BOOLEAN ver_src_e1                      ;                                                      
STRING _ver_src_fdate_e1               ;                                                      
INTEGER ver_src_fdate_e1                ;                                                      
INTEGER ver_src_e2_pos                  ;                                                      
BOOLEAN ver_src_e2                      ;                                                      
STRING _ver_src_fdate_e2               ;                                                      
INTEGER ver_src_fdate_e2                ;                                                      
INTEGER ver_src_e3_pos                  ;                                                      
BOOLEAN ver_src_e3                      ;                                                      
STRING _ver_src_fdate_e3               ;                                                      
INTEGER ver_src_fdate_e3                ;                                                      
INTEGER ver_src_e4_pos                  ;                                                      
BOOLEAN ver_src_e4                      ;                                                      
INTEGER ver_src_en_pos                  ;                                                      
BOOLEAN ver_src_en                      ;                                                      
STRING _ver_src_fdate_en               ;                                                      
INTEGER ver_src_fdate_en                ;                                                      
INTEGER ver_src_eq_pos                  ;                                                      
BOOLEAN ver_src_eq                      ;                                                      
STRING _ver_src_fdate_eq               ;                                                      
INTEGER ver_src_fdate_eq                ;                                                      
INTEGER ver_src_fe_pos                  ;                                                      
BOOLEAN ver_src_fe                      ;                                                      
STRING _ver_src_fdate_fe               ;                                                      
INTEGER ver_src_fdate_fe                ;                                                      
INTEGER ver_src_ff_pos                  ;                                                      
BOOLEAN ver_src_ff                      ;                                                      
STRING _ver_src_fdate_ff               ;                                                      
INTEGER ver_src_fdate_ff                ;                                                      
INTEGER ver_src_fr_pos                  ;                                                      
BOOLEAN ver_src_fr                      ;                                                      
INTEGER ver_src_l2_pos                  ;                                                      
BOOLEAN ver_src_l2                      ;                                                      
INTEGER ver_src_li_pos                  ;                                                      
BOOLEAN ver_src_li                      ;                                                      
INTEGER ver_src_mw_pos                  ;                                                      
BOOLEAN ver_src_mw                      ;                                                      
INTEGER ver_src_nt_pos                  ;                                                      
BOOLEAN ver_src_nt                      ;                                                      
INTEGER ver_src_p_pos                   ;                                                      
BOOLEAN ver_src_p                       ;                                                      
STRING _ver_src_fdate_p                ;                                                      
INTEGER ver_src_fdate_p                 ;                                                      
BOOLEAN ver_src_pl_pos                  ;                                                      
BOOLEAN ver_src_pl                      ;                                                      
STRING _ver_src_fdate_pl               ;                                                      
INTEGER ver_src_fdate_pl                ;                                                      
INTEGER ver_src_tn_pos                  ;                                                      
BOOLEAN ver_src_tn                      ;                                                      
STRING _ver_src_fdate_tn               ;                                                      
INTEGER ver_src_fdate_tn                ;                                                      
INTEGER ver_src_sl_pos                  ;                                                      
BOOLEAN ver_src_sl                      ;                                                      
STRING _ver_src_fdate_sl               ;                                                      
INTEGER ver_src_fdate_sl                ;                                                      
INTEGER ver_src_v_pos                   ;                                                      
BOOLEAN ver_src_v                       ;                                                      
STRING _ver_src_fdate_v                ;                                                      
INTEGER ver_src_fdate_v                 ;                                                      
BOOLEAN ver_src_vo_pos                  ;                                                      
BOOLEAN ver_src_vo                      ;                                                      
STRING _ver_src_fdate_vo               ;                                                      
INTEGER ver_src_fdate_vo                ;                                                      
INTEGER ver_src_w_pos                   ;                                                      
BOOLEAN ver_src_w                       ;                                                      
STRING _ver_src_fdate_w                ;                                                      
INTEGER ver_src_fdate_w                 ;                                                      
BOOLEAN ver_src_wp_pos                  ;                                                      
BOOLEAN ver_src_wp                      ;                                                      
INTEGER ver_fname_src_en_pos            ;                                                      
BOOLEAN ver_fname_src_en                ;                                                      
INTEGER ver_fname_src_eq_pos            ;                                                      
BOOLEAN ver_fname_src_eq                ;                                                      
INTEGER ver_fname_src_tn_pos            ;                                                      
BOOLEAN ver_fname_src_tn                ;                                                      
INTEGER ver_lname_src_en_pos            ;                                                      
BOOLEAN ver_lname_src_en                ;                                                      
INTEGER ver_lname_src_eq_pos            ;                                                      
BOOLEAN ver_lname_src_eq                ;                                                      
INTEGER ver_lname_src_tn_pos            ;                                                      
BOOLEAN ver_lname_src_tn                ;                                                      
INTEGER ver_addr_src_en_pos             ;                                                      
BOOLEAN ver_addr_src_en                 ;                                                      
INTEGER ver_addr_src_eq_pos             ;                                                      
BOOLEAN ver_addr_src_eq                 ;                                                      
INTEGER ver_addr_src_tn_pos             ;                                                      
BOOLEAN ver_addr_src_tn                 ;                                                      
INTEGER ver_ssn_src_en_pos              ;                                                      
BOOLEAN ver_ssn_src_en                  ;                                                      
INTEGER ver_ssn_src_eq_pos              ;                                                      
BOOLEAN ver_ssn_src_eq                  ;                                                      
INTEGER ver_ssn_src_tn_pos              ;                                                      
BOOLEAN ver_ssn_src_tn                  ;                                                      
INTEGER ver_dob_src_ak_pos              ;                                                      
BOOLEAN ver_dob_src_ak                  ;                                                      
INTEGER ver_dob_src_am_pos              ;                                                      
BOOLEAN ver_dob_src_am                  ;                                                      
INTEGER ver_dob_src_ar_pos              ;                                                      
BOOLEAN ver_dob_src_ar                  ;                                                      
INTEGER ver_dob_src_ba_pos              ;                                                      
BOOLEAN ver_dob_src_ba                  ;                                                      
INTEGER ver_dob_src_cg_pos              ;                                                      
BOOLEAN ver_dob_src_cg                  ;                                                      
INTEGER ver_dob_src_cy_pos              ;                                                      
BOOLEAN ver_dob_src_cy                  ;                                                      
INTEGER ver_dob_src_da_pos              ;                                                      
BOOLEAN ver_dob_src_da                  ;                                                      
INTEGER ver_dob_src_d_pos               ;                                                      
BOOLEAN ver_dob_src_d                   ;                                                      
BOOLEAN ver_dob_src_dl_pos              ;                                                      
BOOLEAN ver_dob_src_dl                  ;                                                      
INTEGER ver_dob_src_eb_pos              ;                                                      
BOOLEAN ver_dob_src_eb                  ;                                                      
INTEGER ver_dob_src_em_pos              ;                                                      
BOOLEAN ver_dob_src_em                  ;                                                      
INTEGER ver_dob_src_e1_pos              ;                                                      
BOOLEAN ver_dob_src_e1                  ;                                                      
INTEGER ver_dob_src_e2_pos              ;                                                      
BOOLEAN ver_dob_src_e2                  ;                                                      
INTEGER ver_dob_src_e3_pos              ;                                                      
BOOLEAN ver_dob_src_e3                  ;                                                      
INTEGER ver_dob_src_e4_pos              ;                                                      
BOOLEAN ver_dob_src_e4                  ;                                                      
INTEGER ver_dob_src_en_pos              ;                                                      
BOOLEAN ver_dob_src_en                  ;                                                      
INTEGER ver_dob_src_eq_pos              ;                                                      
BOOLEAN ver_dob_src_eq                  ;                                                      
INTEGER ver_dob_src_fe_pos              ;                                                      
BOOLEAN ver_dob_src_fe                  ;                                                      
INTEGER ver_dob_src_ff_pos              ;                                                      
BOOLEAN ver_dob_src_ff                  ;                                                      
INTEGER ver_dob_src_fr_pos              ;                                                      
BOOLEAN ver_dob_src_fr                  ;                                                      
INTEGER ver_dob_src_l2_pos              ;                                                      
BOOLEAN ver_dob_src_l2                  ;                                                      
INTEGER ver_dob_src_li_pos              ;                                                      
BOOLEAN ver_dob_src_li                  ;                                                      
INTEGER ver_dob_src_mw_pos              ;                                                      
BOOLEAN ver_dob_src_mw                  ;                                                      
INTEGER ver_dob_src_nt_pos              ;                                                      
BOOLEAN ver_dob_src_nt                  ;                                                      
INTEGER ver_dob_src_p_pos               ;                                                      
BOOLEAN ver_dob_src_p                   ;                                                      
BOOLEAN ver_dob_src_pl_pos              ;                                                      
BOOLEAN ver_dob_src_pl                  ;                                                      
INTEGER ver_dob_src_tn_pos              ;                                                      
BOOLEAN ver_dob_src_tn                  ;                                                      
INTEGER ver_dob_src_sl_pos              ;                                                      
BOOLEAN ver_dob_src_sl                  ;                                                      
INTEGER ver_dob_src_v_pos               ;                                                      
BOOLEAN ver_dob_src_v                   ;                                                      
BOOLEAN ver_dob_src_vo_pos              ;                                                      
BOOLEAN ver_dob_src_vo                  ;                                                      
INTEGER ver_dob_src_w_pos               ;                                                      
BOOLEAN ver_dob_src_w                   ;                                                      
BOOLEAN ver_dob_src_wp_pos              ;                                                      
BOOLEAN ver_dob_src_wp                  ;                                                      
STRING iv_add_apt                      ;                                                      
INTEGER iv_dob_src_ct                   ;                                                      
INTEGER nf_phone_ver_experian           ;                                                      
INTEGER nf_invbest_inq_perphone_diff    ;                                                      
INTEGER iv_nap_inf_phone_ver_lvl        ;                                                      
INTEGER rv_f00_input_dob_match_level    ;                                                      
INTEGER corrssnname_src_ak_pos          ;                                                      
BOOLEAN corrssnname_src_ak              ;                                                      
INTEGER corrssnname_src_am_pos          ;                                                      
BOOLEAN corrssnname_src_am              ;                                                      
INTEGER corrssnname_src_ar_pos          ;                                                      
BOOLEAN corrssnname_src_ar              ;                                                      
INTEGER corrssnname_src_ba_pos          ;                                                      
BOOLEAN corrssnname_src_ba              ;                                                      
INTEGER corrssnname_src_cg_pos          ;                                                      
BOOLEAN corrssnname_src_cg              ;                                                      
INTEGER corrssnname_src_co_pos          ;                                                      
BOOLEAN corrssnname_src_co              ;                                                      
INTEGER corrssnname_src_cy_pos          ;                                                      
BOOLEAN corrssnname_src_cy              ;                                                      
INTEGER corrssnname_src_da_pos          ;                                                      
BOOLEAN corrssnname_src_da              ;                                                      
INTEGER corrssnname_src_d_pos           ;                                                      
BOOLEAN corrssnname_src_d               ;                                                      
BOOLEAN corrssnname_src_dl_pos          ;                                                      
BOOLEAN corrssnname_src_dl              ;                                                      
BOOLEAN corrssnname_src_ds_pos          ;                                                      
BOOLEAN corrssnname_src_ds              ;                                                      
BOOLEAN corrssnname_src_de_pos          ;                                                      
BOOLEAN corrssnname_src_de              ;                                                      
INTEGER corrssnname_src_eb_pos          ;                                                      
BOOLEAN corrssnname_src_eb              ;                                                      
INTEGER corrssnname_src_em_pos          ;                                                      
BOOLEAN corrssnname_src_em              ;                                                      
INTEGER corrssnname_src_e1_pos          ;                                                      
BOOLEAN corrssnname_src_e1              ;                                                      
INTEGER corrssnname_src_e2_pos          ;                                                      
BOOLEAN corrssnname_src_e2              ;                                                      
INTEGER corrssnname_src_e3_pos          ;                                                      
BOOLEAN corrssnname_src_e3              ;                                                      
INTEGER corrssnname_src_e4_pos          ;                                                      
BOOLEAN corrssnname_src_e4              ;                                                      
INTEGER corrssnname_src_en_pos          ;                                                      
BOOLEAN corrssnname_src_en              ;                                                      
INTEGER corrssnname_src_eq_pos          ;                                                      
BOOLEAN corrssnname_src_eq              ;                                                      
INTEGER corrssnname_src_fe_pos          ;                                                      
BOOLEAN corrssnname_src_fe              ;                                                      
INTEGER corrssnname_src_ff_pos          ;                                                      
BOOLEAN corrssnname_src_ff              ;                                                      
INTEGER corrssnname_src_fr_pos          ;                                                      
BOOLEAN corrssnname_src_fr              ;                                                      
INTEGER corrssnname_src_l2_pos          ;                                                      
BOOLEAN corrssnname_src_l2              ;                                                      
INTEGER corrssnname_src_li_pos          ;                                                      
BOOLEAN corrssnname_src_li              ;                                                      
INTEGER corrssnname_src_mw_pos          ;                                                      
BOOLEAN corrssnname_src_mw              ;                                                      
INTEGER corrssnname_src_nt_pos          ;                                                      
BOOLEAN corrssnname_src_nt              ;                                                      
INTEGER corrssnname_src_p_pos           ;                                                      
BOOLEAN corrssnname_src_p               ;                                                      
BOOLEAN corrssnname_src_pl_pos          ;                                                      
BOOLEAN corrssnname_src_pl              ;                                                      
INTEGER corrssnname_src_tn_pos          ;                                                      
BOOLEAN corrssnname_src_tn              ;                                                      
INTEGER corrssnname_src_ts_pos          ;                                                      
BOOLEAN corrssnname_src_ts              ;                                                      
INTEGER corrssnname_src_tu_pos          ;                                                      
BOOLEAN corrssnname_src_tu              ;                                                      
INTEGER corrssnname_src_sl_pos          ;                                                      
BOOLEAN corrssnname_src_sl              ;                                                      
INTEGER corrssnname_src_v_pos           ;                                                      
BOOLEAN corrssnname_src_v               ;                                                      
BOOLEAN corrssnname_src_vo_pos          ;                                                      
BOOLEAN corrssnname_src_vo              ;                                                      
INTEGER corrssnname_src_w_pos           ;                                                      
BOOLEAN corrssnname_src_w               ;                                                      
BOOLEAN corrssnname_src_wp_pos          ;                                                      
BOOLEAN corrssnname_src_wp              ;                                                      
INTEGER corrssnname_ct                  ;                                                      
INTEGER nf_corrssnname                  ;                                                      
INTEGER corrssnaddr_src_ak_pos          ;                                                      
BOOLEAN corrssnaddr_src_ak              ;                                                      
INTEGER corrssnaddr_src_am_pos          ;                                                      
BOOLEAN corrssnaddr_src_am              ;                                                      
INTEGER corrssnaddr_src_ar_pos          ;                                                      
BOOLEAN corrssnaddr_src_ar              ;                                                      
INTEGER corrssnaddr_src_ba_pos          ;                                                      
BOOLEAN corrssnaddr_src_ba              ;                                                      
INTEGER corrssnaddr_src_cg_pos          ;                                                      
BOOLEAN corrssnaddr_src_cg              ;                                                      
INTEGER corrssnaddr_src_co_pos          ;                                                      
BOOLEAN corrssnaddr_src_co              ;                                                      
INTEGER corrssnaddr_src_cy_pos          ;                                                      
BOOLEAN corrssnaddr_src_cy              ;                                                      
INTEGER corrssnaddr_src_da_pos          ;                                                      
BOOLEAN corrssnaddr_src_da              ;                                                      
INTEGER corrssnaddr_src_d_pos           ;                                                      
BOOLEAN corrssnaddr_src_d               ;                                                      
BOOLEAN corrssnaddr_src_dl_pos          ;                                                      
BOOLEAN corrssnaddr_src_dl              ;                                                      
BOOLEAN corrssnaddr_src_ds_pos          ;                                                      
BOOLEAN corrssnaddr_src_ds              ;                                                      
BOOLEAN corrssnaddr_src_de_pos          ;                                                      
BOOLEAN corrssnaddr_src_de              ;                                                      
INTEGER corrssnaddr_src_eb_pos          ;                                                      
BOOLEAN corrssnaddr_src_eb              ;                                                      
INTEGER corrssnaddr_src_em_pos          ;                                                      
BOOLEAN corrssnaddr_src_em              ;                                                      
INTEGER corrssnaddr_src_e1_pos          ;                                                      
BOOLEAN corrssnaddr_src_e1              ;                                                      
INTEGER corrssnaddr_src_e2_pos          ;                                                      
BOOLEAN corrssnaddr_src_e2              ;                                                      
INTEGER corrssnaddr_src_e3_pos          ;                                                      
BOOLEAN corrssnaddr_src_e3              ;                                                      
INTEGER corrssnaddr_src_e4_pos          ;                                                      
BOOLEAN corrssnaddr_src_e4              ;                                                      
INTEGER corrssnaddr_src_en_pos          ;                                                      
BOOLEAN corrssnaddr_src_en              ;                                                      
INTEGER corrssnaddr_src_eq_pos          ;                                                      
BOOLEAN corrssnaddr_src_eq              ;                                                      
INTEGER corrssnaddr_src_fe_pos          ;                                                      
BOOLEAN corrssnaddr_src_fe              ;                                                      
INTEGER corrssnaddr_src_ff_pos          ;                                                      
BOOLEAN corrssnaddr_src_ff              ;                                                      
INTEGER corrssnaddr_src_fr_pos          ;                                                      
BOOLEAN corrssnaddr_src_fr              ;                                                      
INTEGER corrssnaddr_src_l2_pos          ;                                                      
BOOLEAN corrssnaddr_src_l2              ;                                                      
INTEGER corrssnaddr_src_li_pos          ;                                                      
BOOLEAN corrssnaddr_src_li              ;                                                      
INTEGER corrssnaddr_src_mw_pos          ;                                                      
BOOLEAN corrssnaddr_src_mw              ;                                                      
INTEGER corrssnaddr_src_nt_pos          ;                                                      
BOOLEAN corrssnaddr_src_nt              ;                                                      
INTEGER corrssnaddr_src_p_pos           ;                                                      
BOOLEAN corrssnaddr_src_p               ;                                                      
BOOLEAN corrssnaddr_src_pl_pos          ;                                                      
BOOLEAN corrssnaddr_src_pl              ;                                                      
INTEGER corrssnaddr_src_tn_pos          ;                                                      
BOOLEAN corrssnaddr_src_tn              ;                                                      
INTEGER corrssnaddr_src_ts_pos          ;                                                      
BOOLEAN corrssnaddr_src_ts              ;                                                      
INTEGER corrssnaddr_src_tu_pos          ;                                                      
BOOLEAN corrssnaddr_src_tu              ;                                                      
INTEGER corrssnaddr_src_sl_pos          ;                                                      
BOOLEAN corrssnaddr_src_sl              ;                                                      
INTEGER corrssnaddr_src_v_pos           ;                                                      
BOOLEAN corrssnaddr_src_v               ;                                                      
BOOLEAN corrssnaddr_src_vo_pos          ;                                                      
BOOLEAN corrssnaddr_src_vo              ;                                                      
INTEGER corrssnaddr_src_w_pos           ;                                                      
BOOLEAN corrssnaddr_src_w               ;                                                      
BOOLEAN corrssnaddr_src_wp_pos          ;                                                      
BOOLEAN corrssnaddr_src_wp              ;                                                      
INTEGER corrssnaddr_ct                  ;                                                      
INTEGER nf_corrssnaddr                  ;                                                      
INTEGER corraddrname_src_ak_pos         ;                                                      
BOOLEAN corraddrname_src_ak             ;                                                      
INTEGER corraddrname_src_am_pos         ;                                                      
BOOLEAN corraddrname_src_am             ;                                                      
INTEGER corraddrname_src_ar_pos         ;                                                      
BOOLEAN corraddrname_src_ar             ;                                                      
INTEGER corraddrname_src_ba_pos         ;                                                      
BOOLEAN corraddrname_src_ba             ;                                                      
INTEGER corraddrname_src_cg_pos         ;                                                      
BOOLEAN corraddrname_src_cg             ;                                                      
INTEGER corraddrname_src_co_pos         ;                                                      
BOOLEAN corraddrname_src_co             ;                                                      
INTEGER corraddrname_src_cy_pos         ;                                                      
BOOLEAN corraddrname_src_cy             ;                                                      
INTEGER corraddrname_src_da_pos         ;                                                      
BOOLEAN corraddrname_src_da             ;                                                      
INTEGER corraddrname_src_d_pos          ;                                                      
BOOLEAN corraddrname_src_d              ;                                                      
BOOLEAN corraddrname_src_dl_pos         ;                                                      
BOOLEAN corraddrname_src_dl             ;                                                      
BOOLEAN corraddrname_src_ds_pos         ;                                                      
BOOLEAN corraddrname_src_ds             ;                                                      
BOOLEAN corraddrname_src_de_pos         ;                                                      
BOOLEAN corraddrname_src_de             ;                                                      
INTEGER corraddrname_src_eb_pos         ;                                                      
BOOLEAN corraddrname_src_eb             ;                                                      
INTEGER corraddrname_src_em_pos         ;                                                      
BOOLEAN corraddrname_src_em             ;                                                      
INTEGER corraddrname_src_e1_pos         ;                                                      
BOOLEAN corraddrname_src_e1             ;                                                      
INTEGER corraddrname_src_e2_pos         ;                                                      
BOOLEAN corraddrname_src_e2             ;                                                      
INTEGER corraddrname_src_e3_pos         ;                                                      
BOOLEAN corraddrname_src_e3             ;                                                      
INTEGER corraddrname_src_e4_pos         ;                                                      
BOOLEAN corraddrname_src_e4             ;                                                      
INTEGER corraddrname_src_en_pos         ;                                                      
BOOLEAN corraddrname_src_en             ;                                                      
INTEGER corraddrname_src_eq_pos         ;                                                      
BOOLEAN corraddrname_src_eq             ;                                                      
INTEGER corraddrname_src_fe_pos         ;                                                      
BOOLEAN corraddrname_src_fe             ;                                                      
INTEGER corraddrname_src_ff_pos         ;                                                      
BOOLEAN corraddrname_src_ff             ;                                                      
INTEGER corraddrname_src_fr_pos         ;                                                      
BOOLEAN corraddrname_src_fr             ;                                                      
INTEGER corraddrname_src_l2_pos         ;                                                      
BOOLEAN corraddrname_src_l2             ;                                                      
INTEGER corraddrname_src_li_pos         ;                                                      
BOOLEAN corraddrname_src_li             ;                                                      
INTEGER corraddrname_src_mw_pos         ;                                                      
BOOLEAN corraddrname_src_mw             ;                                                      
INTEGER corraddrname_src_nt_pos         ;                                                      
BOOLEAN corraddrname_src_nt             ;                                                      
INTEGER corraddrname_src_p_pos          ;                                                      
BOOLEAN corraddrname_src_p              ;                                                      
BOOLEAN corraddrname_src_pl_pos         ;                                                      
BOOLEAN corraddrname_src_pl             ;                                                      
INTEGER corraddrname_src_tn_pos         ;                                                      
BOOLEAN corraddrname_src_tn             ;                                                      
INTEGER corraddrname_src_ts_pos         ;                                                      
BOOLEAN corraddrname_src_ts             ;                                                      
INTEGER corraddrname_src_tu_pos         ;                                                      
BOOLEAN corraddrname_src_tu             ;                                                      
INTEGER corraddrname_src_sl_pos         ;                                                      
BOOLEAN corraddrname_src_sl             ;                                                      
INTEGER corraddrname_src_v_pos          ;                                                      
BOOLEAN corraddrname_src_v              ;                                                      
BOOLEAN corraddrname_src_vo_pos         ;                                                      
BOOLEAN corraddrname_src_vo             ;                                                      
INTEGER corraddrname_src_w_pos          ;                                                      
BOOLEAN corraddrname_src_w              ;                                                      
BOOLEAN corraddrname_src_wp_pos         ;                                                      
BOOLEAN corraddrname_src_wp             ;                                                      
INTEGER corraddrname_ct                 ;                                                      
INTEGER nf_corraddrname                 ;                                                      
INTEGER corraddrphone_src_ak_pos        ;                                                      
BOOLEAN corraddrphone_src_ak            ;                                                      
INTEGER corraddrphone_src_am_pos        ;                                                      
BOOLEAN corraddrphone_src_am            ;                                                      
INTEGER corraddrphone_src_ar_pos        ;                                                      
BOOLEAN corraddrphone_src_ar            ;                                                      
INTEGER corraddrphone_src_ba_pos        ;                                                      
BOOLEAN corraddrphone_src_ba            ;                                                      
INTEGER corraddrphone_src_cg_pos        ;                                                      
BOOLEAN corraddrphone_src_cg            ;                                                      
INTEGER corraddrphone_src_co_pos        ;                                                      
BOOLEAN corraddrphone_src_co            ;                                                      
INTEGER corraddrphone_src_cy_pos        ;                                                      
BOOLEAN corraddrphone_src_cy            ;                                                      
INTEGER corraddrphone_src_da_pos        ;                                                      
BOOLEAN corraddrphone_src_da            ;                                                      
INTEGER corraddrphone_src_d_pos         ;                                                      
BOOLEAN corraddrphone_src_d             ;                                                      
BOOLEAN corraddrphone_src_dl_pos        ;                                                      
BOOLEAN corraddrphone_src_dl            ;                                                      
BOOLEAN corraddrphone_src_ds_pos        ;                                                      
BOOLEAN corraddrphone_src_ds            ;                                                      
BOOLEAN corraddrphone_src_de_pos        ;                                                      
BOOLEAN corraddrphone_src_de            ;                                                      
INTEGER corraddrphone_src_eb_pos        ;                                                      
BOOLEAN corraddrphone_src_eb            ;                                                      
INTEGER corraddrphone_src_em_pos        ;                                                      
BOOLEAN corraddrphone_src_em            ;                                                      
INTEGER corraddrphone_src_e1_pos        ;                                                      
BOOLEAN corraddrphone_src_e1            ;                                                      
INTEGER corraddrphone_src_e2_pos        ;                                                      
BOOLEAN corraddrphone_src_e2            ;                                                      
INTEGER corraddrphone_src_e3_pos        ;                                                      
BOOLEAN corraddrphone_src_e3            ;                                                      
INTEGER corraddrphone_src_e4_pos        ;                                                      
BOOLEAN corraddrphone_src_e4            ;                                                      
INTEGER corraddrphone_src_en_pos        ;                                                      
BOOLEAN corraddrphone_src_en            ;                                                      
INTEGER corraddrphone_src_eq_pos        ;                                                      
BOOLEAN corraddrphone_src_eq            ;                                                      
INTEGER corraddrphone_src_fe_pos        ;                                                      
BOOLEAN corraddrphone_src_fe            ;                                                      
INTEGER corraddrphone_src_ff_pos        ;                                                      
BOOLEAN corraddrphone_src_ff            ;                                                      
INTEGER corraddrphone_src_fr_pos        ;                                                      
BOOLEAN corraddrphone_src_fr            ;                                                      
INTEGER corraddrphone_src_l2_pos        ;                                                      
BOOLEAN corraddrphone_src_l2            ;                                                      
INTEGER corraddrphone_src_li_pos        ;                                                      
BOOLEAN corraddrphone_src_li            ;                                                      
INTEGER corraddrphone_src_mw_pos        ;                                                      
BOOLEAN corraddrphone_src_mw            ;                                                      
INTEGER corraddrphone_src_nt_pos        ;                                                      
BOOLEAN corraddrphone_src_nt            ;                                                      
INTEGER corraddrphone_src_p_pos         ;                                                      
BOOLEAN corraddrphone_src_p             ;                                                      
BOOLEAN corraddrphone_src_pl_pos        ;                                                      
BOOLEAN corraddrphone_src_pl            ;                                                      
INTEGER corraddrphone_src_tn_pos        ;                                                      
BOOLEAN corraddrphone_src_tn            ;                                                      
INTEGER corraddrphone_src_ts_pos        ;                                                      
BOOLEAN corraddrphone_src_ts            ;                                                      
INTEGER corraddrphone_src_tu_pos        ;                                                      
BOOLEAN corraddrphone_src_tu            ;                                                      
INTEGER corraddrphone_src_sl_pos        ;                                                      
BOOLEAN corraddrphone_src_sl            ;                                                      
INTEGER corraddrphone_src_v_pos         ;                                                      
BOOLEAN corraddrphone_src_v             ;                                                      
BOOLEAN corraddrphone_src_vo_pos        ;                                                      
BOOLEAN corraddrphone_src_vo            ;                                                      
INTEGER corraddrphone_src_w_pos         ;                                                      
BOOLEAN corraddrphone_src_w             ;                                                      
BOOLEAN corraddrphone_src_wp_pos        ;                                                      
BOOLEAN corraddrphone_src_wp            ;                                                      
INTEGER corraddrphone_ct                ;                                                      
INTEGER nf_corraddrphone                ;                                                      
INTEGER corrphonelastname_src_ak_pos    ;                                                      
BOOLEAN corrphonelastname_src_ak        ;                                                      
INTEGER corrphonelastname_src_am_pos    ;                                                      
BOOLEAN corrphonelastname_src_am        ;                                                      
INTEGER corrphonelastname_src_ar_pos    ;                                                      
BOOLEAN corrphonelastname_src_ar        ;                                                      
INTEGER corrphonelastname_src_ba_pos    ;                                                      
BOOLEAN corrphonelastname_src_ba        ;                                                      
INTEGER corrphonelastname_src_cg_pos    ;                                                      
BOOLEAN corrphonelastname_src_cg        ;                                                      
INTEGER corrphonelastname_src_co_pos    ;                                                      
BOOLEAN corrphonelastname_src_co        ;                                                      
INTEGER corrphonelastname_src_cy_pos    ;                                                      
BOOLEAN corrphonelastname_src_cy        ;                                                      
INTEGER corrphonelastname_src_da_pos    ;                                                      
BOOLEAN corrphonelastname_src_da        ;                                                      
INTEGER corrphonelastname_src_d_pos     ;                                                      
BOOLEAN corrphonelastname_src_d         ;                                                      
BOOLEAN corrphonelastname_src_dl_pos    ;                                                      
BOOLEAN corrphonelastname_src_dl        ;                                                      
BOOLEAN corrphonelastname_src_ds_pos    ;                                                      
BOOLEAN corrphonelastname_src_ds        ;                                                      
BOOLEAN corrphonelastname_src_de_pos    ;                                                      
BOOLEAN corrphonelastname_src_de        ;                                                      
INTEGER corrphonelastname_src_eb_pos    ;                                                      
BOOLEAN corrphonelastname_src_eb        ;                                                      
INTEGER corrphonelastname_src_em_pos    ;                                                      
BOOLEAN corrphonelastname_src_em        ;                                                      
INTEGER corrphonelastname_src_e1_pos    ;                                                      
BOOLEAN corrphonelastname_src_e1        ;                                                      
INTEGER corrphonelastname_src_e2_pos    ;                                                      
BOOLEAN corrphonelastname_src_e2        ;                                                      
INTEGER corrphonelastname_src_e3_pos    ;                                                      
BOOLEAN corrphonelastname_src_e3        ;                                                      
INTEGER corrphonelastname_src_e4_pos    ;                                                      
BOOLEAN corrphonelastname_src_e4        ;                                                      
INTEGER corrphonelastname_src_en_pos    ;                                                      
BOOLEAN corrphonelastname_src_en        ;                                                      
INTEGER corrphonelastname_src_eq_pos    ;                                                      
BOOLEAN corrphonelastname_src_eq        ;                                                      
INTEGER corrphonelastname_src_fe_pos    ;                                                      
BOOLEAN corrphonelastname_src_fe        ;                                                      
INTEGER corrphonelastname_src_ff_pos    ;                                                      
BOOLEAN corrphonelastname_src_ff        ;                                                      
INTEGER corrphonelastname_src_fr_pos    ;                                                      
BOOLEAN corrphonelastname_src_fr        ;                                                      
INTEGER corrphonelastname_src_l2_pos    ;                                                      
BOOLEAN corrphonelastname_src_l2        ;                                                      
INTEGER corrphonelastname_src_li_pos    ;                                                      
BOOLEAN corrphonelastname_src_li        ;                                                      
INTEGER corrphonelastname_src_mw_pos    ;                                                      
BOOLEAN corrphonelastname_src_mw        ;                                                      
INTEGER corrphonelastname_src_nt_pos    ;                                                      
BOOLEAN corrphonelastname_src_nt        ;                                                      
INTEGER corrphonelastname_src_p_pos     ;                                                      
BOOLEAN corrphonelastname_src_p         ;                                                      
BOOLEAN corrphonelastname_src_pl_pos    ;                                                      
BOOLEAN corrphonelastname_src_pl        ;                                                      
INTEGER corrphonelastname_src_tn_pos    ;                                                      
BOOLEAN corrphonelastname_src_tn        ;                                                      
INTEGER corrphonelastname_src_ts_pos    ;                                                      
BOOLEAN corrphonelastname_src_ts        ;                                                      
INTEGER corrphonelastname_src_tu_pos    ;                                                      
BOOLEAN corrphonelastname_src_tu        ;                                                      
INTEGER corrphonelastname_src_sl_pos    ;                                                      
BOOLEAN corrphonelastname_src_sl        ;                                                      
INTEGER corrphonelastname_src_v_pos     ;                                                      
BOOLEAN corrphonelastname_src_v         ;                                                      
BOOLEAN corrphonelastname_src_vo_pos    ;                                                      
BOOLEAN corrphonelastname_src_vo        ;                                                      
INTEGER corrphonelastname_src_w_pos     ;                                                      
BOOLEAN corrphonelastname_src_w         ;                                                      
BOOLEAN corrphonelastname_src_wp_pos    ;                                                      
BOOLEAN corrphonelastname_src_wp        ;                                                      
INTEGER corrphonelastname_ct            ;                                                      
INTEGER nf_corrphonelastname            ;                                                      
INTEGER nf_corroboration_risk_index     ;                                                      
INTEGER nf_inq_perphone_recency         ;                                                      
INTEGER rv_f00_ssn_score                ;                                                      
INTEGER nf_phone_ver_insurance          ;                                                      
INTEGER nf_fp_validationrisktype        ;                                                      
STRING nf_inquiry_verification_index   ;                                                       
INTEGER nf_fp_srchcomponentrisktype     ;                                                      
INTEGER nf_add_dist_input_to_curr       ;                                                      
INTEGER nf_fp_idrisktype                ;                                                      
INTEGER nf_inq_ssn_lexid_diff01         ;                                                      
INTEGER iv_input_best_match_index       ;                                                      
INTEGER earliest_header_date            ;                                                      
INTEGER earliest_header_yrs             ;                                                      
INTEGER iv_header_emergence_age         ;                                                      
INTEGER nf_unvrfd_search_risk_index     ;                                                       
INTEGER nf_inq_perphone_count12         ;                                                      
INTEGER nf_inq_phone_ver_count          ;                                                      
STRING iv_f00_email_verification       ;                                                      
INTEGER nf_inq_corrnamephone            ;                                                      
INTEGER nf_inq_ssn_ver_count            ;                                                      
INTEGER _rc_ssnlowissue                 ;                                                      
INTEGER ssn_years                       ;                                                      
INTEGER nf_age_at_ssn_issuance          ;                                                      
INTEGER iv_input_best_phone_match       ;                                                      
INTEGER rv_l70_inp_addr_dirty           ;                                                      
INTEGER nf_inq_perssn_count_week        ;                                                      
INTEGER rv_i62_inq_dobsperadl_recency   ;                                                      
INTEGER rv_l79_adls_per_addr_curr       ;                                                      
INTEGER rv_c13_curr_addr_lres           ;                                                      
INTEGER nf_bus_seleids_peradl           ;                                                      
INTEGER nf_inq_adlsperphone_count12     ;                                                       
INTEGER rv_p88_phn_dst_to_inp_add       ;                                                      
INTEGER iv_phn_cell                     ;                                                      
INTEGER nf_email_name_addr_ver          ;                                                      
INTEGER nf_bus_gold_seleids_peradl      ;                                                       
INTEGER _sum_dob_bureau                 ;                                                      
INTEGER _sum_dob_credentialed           ;                                                      
INTEGER _sum_dob_other                  ;                                                      
INTEGER _num_dob_sources                ;                                                      
INTEGER iv_dob_bureau_only              ;                                                      
INTEGER nf_inq_perssn_count_day         ;                                                      
INTEGER nf_fp_srchfraudsrchcountmo      ;                                                      
INTEGER iv_c13_avg_lres                 ;                                                      
INTEGER br_first_seen_char              ;                                                      
INTEGER _br_first_seen                  ;                                                      
INTEGER rv_mos_since_br_first_seen      ;                                                       
INTEGER rv_c22_inp_addr_occ_index       ;                                                      
INTEGER rv_c13_attr_addrs_recency       ;                                                      
INTEGER rv_f00_dob_score                ;                                                      
STRING add_ec3                         ;                                                      
STRING add_ec4                         ;                                                      
INTEGER rv_l70_add_standardized         ;                                                      
INTEGER nf_fp_prevaddrageoldest         ;                                                      
INTEGER nf_mos_bus_header_fs            ;                                                      
INTEGER nf_fp_varrisktype               ;                                                      
INTEGER nf_bus_sos_filings_peradl       ;                                                      
INTEGER _rc_ssnhighissue                ;                                                      
INTEGER nf_m_snc_ssn_high_issue         ;                                                      
INTEGER rv_f00_inq_corrphonessn_adl     ;                                                     
INTEGER _sum_other                      ;                                                      
INTEGER num_sources                     ;                                                      
INTEGER iv_bureau_only_emergence_age    ;                                                       
INTEGER nf_fp_idverrisktype             ;                                                      
INTEGER nf_adls_per_bestssn             ;                                                      
INTEGER _in_dob                         ;                                                      
INTEGER earliest_bureau_date            ;                                                      
INTEGER earliest_bureau_yrs             ;                                                      
INTEGER calc_dob                        ;                                                      
INTEGER iv_bureau_emergence_age         ;                                                      
INTEGER iv_addr_non_phn_src_ct          ;                                                      
INTEGER rv_f04_curr_add_occ_index       ;                                                      
INTEGER nf_fp_srchfraudsrchcountyr      ;                                                       
INTEGER nf_inq_highriskcredit_count24   ;                                                       
INTEGER rv_l79_adls_per_sfd_addr        ;                                                      
INTEGER nf_inq_corrdobphone             ;                                                      
INTEGER nf_fp_divaddrsuspidcountnew     ;                                                      
INTEGER nf_inquiry_adl_vel_risk_index   ;                                                       
INTEGER rv_i62_inq_phones_per_adl       ;                                                      
STRING iv_prof_license_category        ;                                                      
INTEGER nf_invbest_inq_adlsperphone_diff;                                                       
INTEGER nf_invbest_inq_lastperaddr_diff ;                                                       
INTEGER nf_invbest_inq_ssnsperaddr_diff ;                                                       
INTEGER nf_inq_per_phone                ;                                                      
INTEGER nf_inq_curraddr_ver_count       ;                                                      
INTEGER rv_f00_inq_corrdobssn_adl       ;                                                      
INTEGER num_dob_match_level             ;                                                      
INTEGER nas_summary_ver                 ;                                                      
INTEGER nap_summary_ver                 ;                                                      
INTEGER infutor_nap_ver                 ;                                                      
INTEGER dob_ver                         ;                                                      
INTEGER sufficiently_verified           ;                                                      
STRING add_ec1                         ;                                                      
INTEGER addr_validation_problem         ;                                                      
INTEGER phn_validation_problem          ;                                                      
INTEGER validation_problem              ;                                                      
INTEGER tot_liens                       ;                                                      
INTEGER tot_liens_w_type                ;                                                      
INTEGER has_derog                       ;                                                      
STRING rv_6seg_riskview_5_0            ;                                                      
INTEGER rv_c13_inp_addr_lres            ;                                                      
BOOLEAN iv_inf_nothing_found            ;                                                      
INTEGER nf_bus_inact_seleids_peradl     ;                                                       
INTEGER nf_mos_bus_header_ls            ;                                                      
INTEGER nf_phones_per_addr_curr         ;                                                      
BOOLEAN _nap_ver                        ;                                                      
BOOLEAN _inf_ver                        ;                                                      
INTEGER iv_phn_addr_verified            ;                                                      
INTEGER nf_inq_fname_ver_count          ;                                                      
INTEGER nf_adls_per_bestphone_c6        ;                                                      
INTEGER num_bureau_fname                ;                                                      
INTEGER num_bureau_lname                ;                                                      
INTEGER num_bureau_addr                 ;                                                      
INTEGER num_bureau_ssn                  ;                                                      
INTEGER num_bureau_dob                  ;                                                      
INTEGER iv_bureau_verification_index    ;                                                       
INTEGER nf_inq_corrnamephonessn         ;                                                      
INTEGER nf_dist_inp_curr_hi_velocity    ;                                                      
INTEGER rv_i60_inq_other_recency        ;                                                      
INTEGER rv_f00_inq_corrdobphone_adl     ;                                                       
INTEGER rv_a41_a42_prop_owner_history   ;                                                       
REAL all_tree_0                      ;                                                      
REAL all_tree_1                      ;                                                      
REAL all_tree_2                      ;                                                      
REAL all_tree_3                      ;                                                      
REAL all_tree_4                      ;                                                      
REAL all_tree_5                      ;                                                      
REAL all_tree_6                      ;                                                      
REAL all_tree_7                      ;                                                      
REAL all_tree_8                      ;                                                      
REAL all_tree_9                      ;                                                      
REAL all_tree_10                     ;                                                      
REAL all_tree_11                     ;                                                      
REAL all_tree_12                     ;                                                      
REAL all_tree_13                     ;                                                      
REAL all_tree_14                     ;                                                      
REAL all_tree_15                     ;                                                      
REAL all_tree_16                     ;                                                      
REAL all_tree_17                     ;                                                      
REAL all_tree_18                     ;                                                      
REAL all_tree_19                     ;                                                      
REAL all_tree_20                     ;                                                      
REAL all_tree_21                     ;                                                      
REAL all_tree_22                     ;                                                      
REAL all_tree_23                     ;                                                      
REAL all_tree_24                     ;                                                      
REAL all_tree_25                     ;                                                      
REAL all_tree_26                     ;                                                      
REAL all_tree_27                     ;                                                      
REAL all_tree_28                     ;                                                      
REAL all_tree_29                     ;                                                      
REAL all_tree_30                     ;                                                      
REAL all_tree_31                     ;                                                      
REAL all_tree_32                     ;                                                      
REAL all_tree_33                     ;                                                      
REAL all_tree_34                     ;                                                      
REAL all_tree_35                     ;                                                      
REAL all_tree_36                     ;                                                      
REAL all_tree_37                     ;                                                      
REAL all_tree_38                     ;                                                      
REAL all_tree_39                     ;                                                      
REAL all_tree_40                     ;                                                      
REAL all_tree_41                     ;                                                      
REAL all_tree_42                     ;                                                      
REAL all_tree_43                     ;                                                      
REAL all_tree_44                     ;                                                      
REAL all_tree_45                     ;                                                      
REAL all_tree_46                     ;                                                      
REAL all_tree_47                     ;                                                      
REAL all_tree_48                     ;                                                      
REAL all_tree_49                     ;                                                      
REAL all_tree_50                     ;                                                      
REAL all_tree_51                     ;                                                      
REAL all_tree_52                     ;                                                      
REAL all_tree_53                     ;                                                      
REAL all_tree_54                     ;                                                      
REAL all_tree_55                     ;                                                      
REAL all_tree_56                     ;                                                      
REAL all_tree_57                     ;                                                      
REAL all_tree_58                     ;                                                      
REAL all_tree_59                     ;                                                      
REAL all_tree_60                     ;                                                      
REAL all_tree_61                     ;                                                      
REAL all_tree_62                     ;                                                      
REAL all_tree_63                     ;                                                      
REAL all_tree_64                     ;                                                      
REAL all_tree_65                     ;                                                      
REAL all_tree_66                     ;                                                      
REAL all_tree_67                     ;                                                      
REAL all_tree_68                     ;                                                      
REAL all_tree_69                     ;                                                      
REAL all_tree_70                     ;                                                      
REAL all_tree_71                     ;                                                      
REAL all_tree_72                     ;                                                      
REAL all_tree_73                     ;                                                      
REAL all_tree_74                     ;                                                      
REAL all_tree_75                     ;                                                      
REAL all_tree_76                     ;                                                      
REAL all_tree_77                     ;                                                      
REAL all_tree_78                     ;                                                      
REAL all_tree_79                     ;                                                      
REAL all_tree_80                     ;                                                      
REAL all_tree_81                     ;                                                      
REAL all_tree_82                     ;                                                      
REAL all_tree_83                     ;                                                      
REAL all_tree_84                     ;                                                      
REAL all_tree_85                     ;                                                      
REAL all_tree_86                     ;                                                      
REAL all_tree_87                     ;                                                      
REAL all_tree_88                     ;                                                      
REAL all_tree_89                     ;                                                      
REAL all_tree_90                     ;                                                      
REAL all_tree_91                     ;                                                      
REAL all_tree_92                     ;                                                      
REAL all_gbm_logit                   ;                                                      
REAL pbr                             ;                                                      
REAL sbr                             ;                                                      
INTEGER base                            ;                                                      
INTEGER pts                             ;                                                      
REAL lgt                             ;                                                      
REAL offset                          ;                                                      
INTEGER fp1806_1_0                      ;                                                      
BOOLEAN _ver_src_ds                     ;                                                      
BOOLEAN _ver_src_de                     ;                                                      
BOOLEAN _derog                          ;                                                      
BOOLEAN _deceased                       ;                                                      
BOOLEAN _ssnpriortodob                  ;                                                      
BOOLEAN _inputmiskeys                   ;                                                      
BOOLEAN _multiplessns                   ;                                                      
INTEGER _hh_strikes                     ;                                                      
INTEGER stolenid                        ;                                                      
INTEGER manipulatedid                   ;                                                      
INTEGER manipulatedidpt2                ;                                                      
INTEGER _sum_bureau                     ;                                                      
INTEGER _sum_credentialed               ;                                                      
BOOLEAN syntheticid                     ;                                                      
INTEGER suspiciousactivity              ;                                                      
INTEGER vulnerablevictim                ;                                                      
INTEGER friendlyfraud                   ;                                                      
INTEGER stolenc_fp1806_1_0              ;                                                      
INTEGER manip2c_fp1806_1_0              ;                                                      
INTEGER synthc_fp1806_1_0               ;                                                      
INTEGER suspactc_fp1806_1_0             ;                                                      
INTEGER vulnvicc_fp1806_1_0             ;                                                      
INTEGER friendlyc_fp1806_1_0            ;                                                      
INTEGER fp1806_1_0_stolidindex          ;                                                      
INTEGER fp1806_1_0_synthidindex         ;                                                      
INTEGER fp1806_1_0_manipidindex         ;                                                      
INTEGER fp1806_1_0_vulnvicindex         ;                                                      
INTEGER fp1806_1_0_friendfrdindex       ;                                                      
INTEGER fp1806_1_0_suspactindex         ;             
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
   
  
    input_phone_isbestmatch          := le.best_flags.input_phone_isbestmatch;
    inq_perbestphone                 := le.best_flags.inq_perbestphone;
	  corrssnname_sources              := le.header_summary.corrssnname_sources;
	  corrssnaddr_sources              := le.header_summary.corrssnaddr_sources;
	  corraddrname_sources             := le.header_summary.corraddrname_sources;
	  corraddrphone_sources            := le.header_summary.corraddrphone_sources;
	  corrphonelastname_sources        := le.header_summary.corrphonelastname_sources;
    inq_perphone_count01             := le.acc_logs.inq_perphone_count01;
	  inq_perphone_count03             := le.acc_logs.inq_perphone_count03;
	  inq_perphone_count06             := le.acc_logs.inq_perphone_count06;
	  inq_perssn_count01               := le.acc_logs.inq_perssn_count01;
	
    input_fname_isbestmatch          := le.best_flags.input_fname_isbestmatch;
	  input_lname_isbestmatch          := le.best_flags.input_lname_isbestmatch;
	  input_ssn_isbestmatch            := le.best_flags.input_ssn_isbestmatch;
	  inq_corrnamephone                := le.acc_logs.inq_corrnamephone;
	  inq_perssn_count_week            := le.acc_logs.inq_perssn_count_week;
	  inq_dobsperadl_count01           := le.acc_logs.inq_dobsperadl_count01;
	  inq_dobsperadl_count03           := le.acc_logs.inq_dobsperadl_count03;
	  inq_dobsperadl_count06           := le.acc_logs.inq_dobsperadl_count06;
	  bus_seleids_peradl               := le.bip_header.bus_seleids_peradl;
	  bus_gold_seleids_peradl          := le.bip_header.bus_gold_seleids_peradl;
	  inq_perssn_count_day             := le.acc_logs.inq_perssn_count_day;
	  bus_header_first_seen            := le.bip_header.bus_header_first_seen;
	  bus_sos_filings_peradl           := le.bip_header.bus_sos_filings_peradl;
	  inq_corrphonessn_adl             := le.acc_logs.inq_corrphonessn_adl;                      
	  best_ssn_valid                   := le.best_flags.best_ssn_valid;
	  adls_per_bestssn                 := le.best_flags.adls_per_bestssn;
	  inq_corrdobphone                 := le.acc_logs.inq_corrdobphone;
	  inq_adlsperbestphone             := le.best_flags.inq_adlsperbestphone;
	  inq_lnamespercurraddr            := le.best_flags.inq_lnamespercurraddr;
	  inq_ssnspercurraddr              := le.best_flags.inq_ssnspercurraddr;
	  inq_curraddr_ver_count           := le.best_flags.inq_curraddr_ver_count;
	  inq_corrdobssn_adl               := le.acc_logs.inq_corrdobssn_adl;
	  bus_inactive_seleids_peradl      := le.bip_header.bus_inactive_seleids_peradl;
	  bus_header_last_seen             := le.bip_header.bus_header_last_seen;
	  best_phone_phoneval              := le.best_flags.best_phone_phoneval;
	  adls_per_bestphone_c6            := le.best_flags.adls_per_bestphone_c6;
	  inq_corrnamephonessn             := le.acc_logs.inq_corrnamephonessn;
	  inq_corrdobphone_adl             := le.acc_logs.inq_corrdobphone_adl;
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
	combo_ssnscore                   := le.iid.combo_ssnscore;
	combo_dobscore                   := le.iid.combo_dobscore;
	combo_dobcount                   := le.iid.combo_dobcount;
	ver_sources                      := le.header_summary.ver_sources;
	ver_sources_first_seen           := le.header_summary.ver_sources_first_seen_date;
	ver_fname_sources                := le.header_summary.ver_fname_sources;
	ver_lname_sources                := le.header_summary.ver_lname_sources;
	ver_addr_sources                 := le.header_summary.ver_addr_sources;
	ver_ssn_sources                  := le.header_summary.ver_ssn_sources;
	ver_dob_sources                  := le.header_summary.ver_dob_sources;
	fnamepop                         := le.input_validation.firstname;
	lnamepop                         := le.input_validation.lastname;
	addrpop                          := le.input_validation.address;
	ssnlength                        := le.input_validation.ssn_length;
	dobpop                           := le.input_validation.dateofbirth;
	emailpop                         := le.input_validation.email;
	hphnpop                          := le.input_validation.homephone;
	add_input_house_number_match     := le.address_verification.input_address_information.house_number_match;
	add_input_isbestmatch            := le.address_verification.input_address_information.isbestmatch;
	add_input_lres                   := le.lres;
	add_input_dirty_address          := le.address_verification.inputaddr_dirty;
	add_input_occ_index              := le.address_verification.inputaddr_occupancy_index;
	add_input_advo_vacancy           := le.advo_input_addr.Address_Vacancy_Indicator;
	add_input_advo_res_or_bus        := le.advo_input_addr.Residential_or_Business_Ind;
	add_input_naprop                 := le.address_verification.input_address_information.naprop;
	add_input_pop                    := le.addrPop;
	property_owned_total             := le.address_verification.owned.property_total;
	add_dist_input_to_curr           := le.address_verification.distance_in_2_h1;
	add_curr_lres                    := le.lres2;
	add_curr_occ_index               := le.address_verification.currAddr_occupancy_index;
	add_curr_naprop                  := le.address_verification.address_history_1.naprop;
	add_curr_pop                     := le.addrPop2;
	add_prev_naprop                  := le.address_verification.address_history_2.naprop;
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
	adls_per_addr_curr               := le.velocity_counters.adls_per_addr_current;
	ssns_per_addr_curr               := le.velocity_counters.ssns_per_addr_current;
	phones_per_addr_curr             := le.velocity_counters.phones_per_addr_current;
	ssns_per_adl_c6                  := le.velocity_counters.ssns_per_adl_created_6months;
	//lnames_per_adl_c6                := if(isFCRA, 0, le.velocity_counters.lnames_per_adl);
  lnames_per_adl_c6                :=   if(isFCRA, 0, le.velocity_counters.lnames_per_adl180);
  //_created_6months;
	invalid_ssns_per_adl             := le.velocity_counters.invalid_ssns_per_adl;
	inq_addr_ver_count               := le.acc_logs.inquiry_addr_ver_ct;
	inq_fname_ver_count              := le.acc_logs.inquiry_fname_ver_ct;
	inq_lname_ver_count              := le.acc_logs.inquiry_lname_ver_ct;
	inq_ssn_ver_count                := le.acc_logs.inquiry_ssn_ver_ct;
	inq_dob_ver_count                := le.acc_logs.inquiry_dob_ver_ct;
	inq_phone_ver_count              := le.acc_logs.inquiry_phone_ver_ct;
	inq_count01                      := le.acc_logs.inquiries.count01;
	inq_count03                      := le.acc_logs.inquiries.count03;
	inq_collection_count12           := le.acc_logs.collection.count12;
	inq_highriskcredit_count12       := le.acc_logs.highriskcredit.count12;
	inq_highriskcredit_count24       := le.acc_logs.highriskcredit.count24;
	inq_other_count                  := le.acc_logs.other.counttotal;
	inq_other_count01                := le.acc_logs.other.count01;
	inq_other_count03                := le.acc_logs.other.count03;
	inq_other_count06                := le.acc_logs.other.count06;
	inq_other_count12                := le.acc_logs.other.count12;
	inq_other_count24                := le.acc_logs.other.count24;
	inq_ssnsperadl                   := le.acc_logs.inquiryssnsperadl;
	inq_addrsperadl                  := le.acc_logs.inquiryaddrsperadl;
	inq_lnamesperadl                 := if(isFCRA, 0, le.acc_logs.inquirylnamesperadl);
	inq_phonesperadl                 := le.acc_logs.inquiryphonesperadl;
	inq_dobsperadl                   := le.acc_logs.inquirydobsperadl;
	inq_peraddr                      := if(isFCRA, 0, le.acc_logs.inquiryPerAddr );
	inq_lnamesperaddr                := if(isFCRA, 0, le.acc_logs.inquiryLNamesPerAddr );
	inq_ssnsperaddr                  := if(isFCRA, 0, le.acc_logs.inquirySSNsPerAddr );
	inq_perphone                     := if(isFCRA, 0, le.acc_logs.inquiryPerPhone );
	inq_adlsperphone                 := if(isFCRA, 0, le.acc_logs.inquiryADLsPerPhone );
	br_first_seen                    := le.employment.first_seen_date;
	infutor_nap                      := le.infutor_phone.infutor_nap;
	stl_inq_count                    := le.impulse.count;
	stl_inq_count24                  := le.impulse.count24;
	email_verification               := le.email_summary.identity_email_verification_level;
	email_name_addr_verification     := le.email_summary.reverse_email.verification_level;
	attr_addrs_last30                := le.other_address_info.addrs_last30;
	attr_addrs_last90                := le.other_address_info.addrs_last90;
	attr_addrs_last12                := le.other_address_info.addrs_last12;
	attr_addrs_last24                := le.other_address_info.addrs_last24;
	attr_addrs_last36                := le.other_address_info.addrs_last36;
	attr_num_unrel_liens60           := le.bjl.liens_unreleased_count60;
	attr_eviction_count              := le.bjl.eviction_count;
	fp_idrisktype                    := le.fdattributesv2.identityrisklevel;
	fp_idverrisktype                 := le.fdattributesv2.idverrisklevel;
	fp_varrisktype                   := le.fdattributesv2.variationrisklevel;
	fp_srchunvrfdssncount            := le.fdattributesv2.searchunverifiedssncountyear;
	fp_srchunvrfdaddrcount           := le.fdattributesv2.searchunverifiedaddrcountyear;
	fp_srchunvrfddobcount            := le.fdattributesv2.searchunverifieddobcountyear;
	fp_srchunvrfdphonecount          := le.fdattributesv2.searchunverifiedphonecountyear;
	fp_srchfraudsrchcountyr          := le.fdattributesv2.searchfraudsearchcountyear;
	fp_srchfraudsrchcountmo          := le.fdattributesv2.searchfraudsearchcountmonth;
	fp_validationrisktype            := le.fdattributesv2.validationrisklevel;
	fp_divaddrsuspidcountnew         := le.fdattributesv2.divaddrsuspidentitycountnew;
	fp_srchcomponentrisktype         := le.fdattributesv2.searchcomponentrisklevel;
	fp_prevaddrageoldest             := le.fdattributesv2.prevaddrageoldest;
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
	prof_license_category            := le.professional_license.plcategory;
	input_dob_match_level            := le.dobmatchlevel;
	inferred_age                     := le.inferred_age;
	STRING8 archive_date             := le.historydatetimestamp;




//***Begining of the SAS code that was converted to ECL ****//
NULL := -999999999;

INTEGER contains_i(     STRING haystack,     STRING needle ) := (INTEGER)(    STRINGLib.    STRINGFind(haystack, needle, 1) > 0);


//========================================================================================  
//===   for round 1 validation set the sysdate to the same value seen in the validation file
//===     sysdate := common.sas_date('20160501');	 
//===   for round 2 validation set the sysdate to the archive date
 sysdate := common.sas_date(if(le.historydate=999999, (    STRING)ut.getdate, (    STRING6)le.historydate+'01'));
//========================================================================================


ver_src_ak_pos    := Models.Common.findw_cpp(ver_sources, 'AK' , '  ,', 'ie');
ver_src_ak        := ver_src_ak_pos > 0;
_ver_src_fdate_ak := if(ver_src_ak_pos > 0, Models.Common.getw(ver_sources_first_seen, ver_src_ak_pos), '0');
ver_src_fdate_ak  := common.sas_date((string)(_ver_src_fdate_ak));

ver_src_am_pos    := Models.Common.findw_cpp(ver_sources, 'AM' , '  ,', 'ie');
ver_src_am        := ver_src_am_pos > 0;
_ver_src_fdate_am := if(ver_src_am_pos > 0, Models.Common.getw(ver_sources_first_seen, ver_src_am_pos), '0');
ver_src_fdate_am  := common.sas_date((string)(_ver_src_fdate_am));

ver_src_ar_pos    := Models.Common.findw_cpp(ver_sources, 'AR' , '  ,', 'ie');
ver_src_ar        := ver_src_ar_pos > 0;
_ver_src_fdate_ar := if(ver_src_ar_pos > 0, Models.Common.getw(ver_sources_first_seen, ver_src_ar_pos), '0');
ver_src_fdate_ar  := common.sas_date((string)(_ver_src_fdate_ar));

ver_src_ba_pos    := Models.Common.findw_cpp(ver_sources, 'BA' , '  ,', 'ie');
ver_src_ba        := ver_src_ba_pos > 0;
_ver_src_fdate_ba := if(ver_src_ba_pos > 0, Models.Common.getw(ver_sources_first_seen, ver_src_ba_pos), '0');
ver_src_fdate_ba  := common.sas_date((string)(_ver_src_fdate_ba));

ver_src_cg_pos := Models.Common.findw_cpp(ver_sources, 'CG' , '  ,', 'ie');

ver_src_cg := ver_src_cg_pos > 0;

_ver_src_fdate_cg := if(ver_src_cg_pos > 0, Models.Common.getw(ver_sources_first_seen, ver_src_cg_pos), '0');

ver_src_fdate_cg := common.sas_date((string)(_ver_src_fdate_cg));

ver_src_co_pos := Models.Common.findw_cpp(ver_sources, 'CO' , '  ,', 'ie');

_ver_src_fdate_co := if(ver_src_co_pos > 0, Models.Common.getw(ver_sources_first_seen, ver_src_co_pos), '0');

ver_src_fdate_co := common.sas_date((string)(_ver_src_fdate_co));

ver_src_cy_pos := Models.Common.findw_cpp(ver_sources, 'CY' , '  ,', 'ie');

ver_src_cy := ver_src_cy_pos > 0;

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

ver_src_em := ver_src_em_pos > 0;

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

ver_src_e4 := ver_src_e4_pos > 0;

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

ver_src_fr := ver_src_fr_pos > 0;

_ver_src_fdate_fr := if(ver_src_fr_pos > 0, Models.Common.getw(ver_sources_first_seen, ver_src_fr_pos), '0');

ver_src_fdate_fr := common.sas_date((string)(_ver_src_fdate_fr));

ver_src_l2_pos := Models.Common.findw_cpp(ver_sources, 'L2' , '  ,', 'ie');

ver_src_l2 := ver_src_l2_pos > 0;

_ver_src_fdate_l2 := if(ver_src_l2_pos > 0, Models.Common.getw(ver_sources_first_seen, ver_src_l2_pos), '0');

ver_src_fdate_l2 := common.sas_date((string)(_ver_src_fdate_l2));

ver_src_li_pos := Models.Common.findw_cpp(ver_sources, 'LI' , '  ,', 'ie');

ver_src_li := ver_src_li_pos > 0;

_ver_src_fdate_li := if(ver_src_li_pos > 0, Models.Common.getw(ver_sources_first_seen, ver_src_li_pos), '0');

ver_src_fdate_li := common.sas_date((string)(_ver_src_fdate_li));

ver_src_mw_pos := Models.Common.findw_cpp(ver_sources, 'MW' , '  ,', 'ie');

ver_src_mw := ver_src_mw_pos > 0;

_ver_src_fdate_mw := if(ver_src_mw_pos > 0, Models.Common.getw(ver_sources_first_seen, ver_src_mw_pos), '0');

ver_src_fdate_mw := common.sas_date((string)(_ver_src_fdate_mw));

ver_src_nt_pos := Models.Common.findw_cpp(ver_sources, 'NT' , '  ,', 'ie');

ver_src_nt := ver_src_nt_pos > 0;

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

ver_src_wp := ver_src_wp_pos > 0;

_ver_src_fdate_wp := if(ver_src_wp_pos > 0, Models.Common.getw(ver_sources_first_seen, ver_src_wp_pos), '0');

ver_src_fdate_wp := common.sas_date((string)(_ver_src_fdate_wp));



//***

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

ver_dob_src_ak_pos := Models.Common.findw_cpp(ver_dob_sources, 'AK' , '  ,', 'ie');

ver_dob_src_ak := ver_dob_src_ak_pos > 0;

ver_dob_src_am_pos := Models.Common.findw_cpp(ver_dob_sources, 'AM' , '  ,', 'ie');

ver_dob_src_am := ver_dob_src_am_pos > 0;

ver_dob_src_ar_pos := Models.Common.findw_cpp(ver_dob_sources, 'AR' , '  ,', 'ie');

ver_dob_src_ar := ver_dob_src_ar_pos > 0;

ver_dob_src_ba_pos := Models.Common.findw_cpp(ver_dob_sources, 'BA' , '  ,', 'ie');

ver_dob_src_ba := ver_dob_src_ba_pos > 0;

ver_dob_src_cg_pos := Models.Common.findw_cpp(ver_dob_sources, 'CG' , '  ,', 'ie');

ver_dob_src_cg := ver_dob_src_cg_pos > 0;

ver_dob_src_cy_pos := Models.Common.findw_cpp(ver_dob_sources, 'CY' , '  ,', 'ie');

ver_dob_src_cy := ver_dob_src_cy_pos > 0;

ver_dob_src_da_pos := Models.Common.findw_cpp(ver_dob_sources, 'DA' , '  ,', 'ie');

ver_dob_src_da := ver_dob_src_da_pos > 0;

ver_dob_src_d_pos := Models.Common.findw_cpp(ver_dob_sources, 'D' , '  ,', 'ie');

ver_dob_src_d := ver_dob_src_d_pos > 0;

ver_dob_src_dl_pos := Models.Common.findw_cpp(ver_dob_sources, 'DL' , '  ,', 'ie');

ver_dob_src_dl := ver_dob_src_dl_pos > 0;

ver_dob_src_eb_pos := Models.Common.findw_cpp(ver_dob_sources, 'EB' , '  ,', 'ie');

ver_dob_src_eb := ver_dob_src_eb_pos > 0;

ver_dob_src_em_pos := Models.Common.findw_cpp(ver_dob_sources, 'EM' , '  ,', 'ie');

ver_dob_src_em := ver_dob_src_em_pos > 0;

ver_dob_src_e1_pos := Models.Common.findw_cpp(ver_dob_sources, 'E1' , '  ,', 'ie');

ver_dob_src_e1 := ver_dob_src_e1_pos > 0;

ver_dob_src_e2_pos := Models.Common.findw_cpp(ver_dob_sources, 'E2' , '  ,', 'ie');

ver_dob_src_e2 := ver_dob_src_e2_pos > 0;

ver_dob_src_e3_pos := Models.Common.findw_cpp(ver_dob_sources, 'E3' , '  ,', 'ie');

ver_dob_src_e3 := ver_dob_src_e3_pos > 0;

ver_dob_src_e4_pos := Models.Common.findw_cpp(ver_dob_sources, 'E4' , '  ,', 'ie');

ver_dob_src_e4 := ver_dob_src_e4_pos > 0;

ver_dob_src_en_pos := Models.Common.findw_cpp(ver_dob_sources, 'EN' , '  ,', 'ie');

ver_dob_src_en := ver_dob_src_en_pos > 0;

ver_dob_src_eq_pos := Models.Common.findw_cpp(ver_dob_sources, 'EQ' , '  ,', 'ie');

ver_dob_src_eq := ver_dob_src_eq_pos > 0;

ver_dob_src_fe_pos := Models.Common.findw_cpp(ver_dob_sources, 'FE' , '  ,', 'ie');

ver_dob_src_fe := ver_dob_src_fe_pos > 0;

ver_dob_src_ff_pos := Models.Common.findw_cpp(ver_dob_sources, 'FF' , '  ,', 'ie');

ver_dob_src_ff := ver_dob_src_ff_pos > 0;

ver_dob_src_fr_pos := Models.Common.findw_cpp(ver_dob_sources, 'FR' , '  ,', 'ie');

ver_dob_src_fr := ver_dob_src_fr_pos > 0;

ver_dob_src_l2_pos := Models.Common.findw_cpp(ver_dob_sources, 'L2' , '  ,', 'ie');

ver_dob_src_l2 := ver_dob_src_l2_pos > 0;

ver_dob_src_li_pos := Models.Common.findw_cpp(ver_dob_sources, 'LI' , '  ,', 'ie');

ver_dob_src_li := ver_dob_src_li_pos > 0;

ver_dob_src_mw_pos := Models.Common.findw_cpp(ver_dob_sources, 'MW' , '  ,', 'ie');

ver_dob_src_mw := ver_dob_src_mw_pos > 0;

ver_dob_src_nt_pos := Models.Common.findw_cpp(ver_dob_sources, 'NT' , '  ,', 'ie');

ver_dob_src_nt := ver_dob_src_nt_pos > 0;

ver_dob_src_p_pos := Models.Common.findw_cpp(ver_dob_sources, 'P' , '  ,', 'ie');

ver_dob_src_p := ver_dob_src_p_pos > 0;

ver_dob_src_pl_pos := Models.Common.findw_cpp(ver_dob_sources, 'PL' , '  ,', 'ie');

ver_dob_src_pl := ver_dob_src_pl_pos > 0;

ver_dob_src_tn_pos := Models.Common.findw_cpp(ver_dob_sources, 'TN' , '  ,', 'ie');

ver_dob_src_tn := ver_dob_src_tn_pos > 0;

ver_dob_src_sl_pos := Models.Common.findw_cpp(ver_dob_sources, 'SL' , '  ,', 'ie');

ver_dob_src_sl := ver_dob_src_sl_pos > 0;

ver_dob_src_v_pos := Models.Common.findw_cpp(ver_dob_sources, 'V' , '  ,', 'ie');

ver_dob_src_v := ver_dob_src_v_pos > 0;

ver_dob_src_vo_pos := Models.Common.findw_cpp(ver_dob_sources, 'VO' , '  ,', 'ie');

ver_dob_src_vo := ver_dob_src_vo_pos > 0;

ver_dob_src_w_pos := Models.Common.findw_cpp(ver_dob_sources, 'W' , '  ,', 'ie');

ver_dob_src_w := ver_dob_src_w_pos > 0;

ver_dob_src_wp_pos := Models.Common.findw_cpp(ver_dob_sources, 'WP' , '  ,', 'ie');

ver_dob_src_wp := ver_dob_src_wp_pos > 0;

  iv_add_apt := __common__( if(STRINGLib.STRINGToUpperCase(trim(rc_dwelltype, LEFT, RIGHT)) = 'A' or STRINGLib.STRINGToUpperCase(trim(out_addr_type, LEFT, RIGHT)) = 'H' or not(out_unit_desig = '') or not(out_sec_range = ''), '1', '0'));

iv_dob_src_ct := if(not(truedid and dobpop), NULL, min(if(combo_dobcount = NULL, -NULL, combo_dobcount), 999));

nf_phone_ver_experian := if(not(truedid), NULL, (integer)phone_ver_experian);
 
nf_invbest_inq_perphone_diff := map(
    not(truedid) or (integer)hphnpop = 0   => NULL,
    (integer)input_phone_isbestmatch = 1   => -9999,
                                   inq_perphone - inq_perbestphone);

iv_nap_inf_phone_ver_lvl := map(
    (nap_summary in [4, 6, 7, 9, 10, 11, 12]) and (infutor_nap in [4, 6, 7, 9, 10, 11, 12]) => 3,
    (nap_summary in [4, 6, 7, 9, 10, 11, 12])                                               => 2,
    (infutor_nap in [4, 6, 7, 9, 10, 11, 12])                                               => 1,
                                                                                               0);

rv_f00_input_dob_match_level := if(not(truedid and dobpop), NULL, (integer)input_dob_match_level);

corrssnname_src_ak_pos := Models.Common.findw_cpp(corrssnname_sources, 'AK' , '  ,', 'ie');

corrssnname_src_ak := corrssnname_src_ak_pos > 0;

corrssnname_src_am_pos := Models.Common.findw_cpp(corrssnname_sources, 'AM' , '  ,', 'ie');

corrssnname_src_am := corrssnname_src_am_pos > 0;

corrssnname_src_ar_pos := Models.Common.findw_cpp(corrssnname_sources, 'AR' , '  ,', 'ie');

corrssnname_src_ar := corrssnname_src_ar_pos > 0;

corrssnname_src_ba_pos := Models.Common.findw_cpp(corrssnname_sources, 'BA' , '  ,', 'ie');

corrssnname_src_ba := corrssnname_src_ba_pos > 0;

corrssnname_src_cg_pos := Models.Common.findw_cpp(corrssnname_sources, 'CG' , '  ,', 'ie');

corrssnname_src_cg := corrssnname_src_cg_pos > 0;

corrssnname_src_co_pos := Models.Common.findw_cpp(corrssnname_sources, 'CO' , '  ,', 'ie');

corrssnname_src_co := corrssnname_src_co_pos > 0;

corrssnname_src_cy_pos := Models.Common.findw_cpp(corrssnname_sources, 'CY' , '  ,', 'ie');

corrssnname_src_cy := corrssnname_src_cy_pos > 0;

corrssnname_src_da_pos := Models.Common.findw_cpp(corrssnname_sources, 'DA' , '  ,', 'ie');

corrssnname_src_da := corrssnname_src_da_pos > 0;

corrssnname_src_d_pos := Models.Common.findw_cpp(corrssnname_sources, 'D' , '  ,', 'ie');

corrssnname_src_d := corrssnname_src_d_pos > 0;

corrssnname_src_dl_pos := Models.Common.findw_cpp(corrssnname_sources, 'DL' , '  ,', 'ie');

corrssnname_src_dl := corrssnname_src_dl_pos > 0;

corrssnname_src_ds_pos := Models.Common.findw_cpp(corrssnname_sources, 'DS' , '  ,', 'ie');

corrssnname_src_ds := corrssnname_src_ds_pos > 0;

corrssnname_src_de_pos := Models.Common.findw_cpp(corrssnname_sources, 'DE' , '  ,', 'ie');

corrssnname_src_de := corrssnname_src_de_pos > 0;

corrssnname_src_eb_pos := Models.Common.findw_cpp(corrssnname_sources, 'EB' , '  ,', 'ie');

corrssnname_src_eb := corrssnname_src_eb_pos > 0;

corrssnname_src_em_pos := Models.Common.findw_cpp(corrssnname_sources, 'EM' , '  ,', 'ie');

corrssnname_src_em := corrssnname_src_em_pos > 0;

corrssnname_src_e1_pos := Models.Common.findw_cpp(corrssnname_sources, 'E1' , '  ,', 'ie');

corrssnname_src_e1 := corrssnname_src_e1_pos > 0;

corrssnname_src_e2_pos := Models.Common.findw_cpp(corrssnname_sources, 'E2' , '  ,', 'ie');

corrssnname_src_e2 := corrssnname_src_e2_pos > 0;

corrssnname_src_e3_pos := Models.Common.findw_cpp(corrssnname_sources, 'E3' , '  ,', 'ie');

corrssnname_src_e3 := corrssnname_src_e3_pos > 0;

corrssnname_src_e4_pos := Models.Common.findw_cpp(corrssnname_sources, 'E4' , '  ,', 'ie');

corrssnname_src_e4 := corrssnname_src_e4_pos > 0;

corrssnname_src_en_pos := Models.Common.findw_cpp(corrssnname_sources, 'EN' , '  ,', 'ie');

corrssnname_src_en := corrssnname_src_en_pos > 0;

corrssnname_src_eq_pos := Models.Common.findw_cpp(corrssnname_sources, 'EQ' , '  ,', 'ie');

corrssnname_src_eq := corrssnname_src_eq_pos > 0;

corrssnname_src_fe_pos := Models.Common.findw_cpp(corrssnname_sources, 'FE' , '  ,', 'ie');

corrssnname_src_fe := corrssnname_src_fe_pos > 0;

corrssnname_src_ff_pos := Models.Common.findw_cpp(corrssnname_sources, 'FF' , '  ,', 'ie');

corrssnname_src_ff := corrssnname_src_ff_pos > 0;

corrssnname_src_fr_pos := Models.Common.findw_cpp(corrssnname_sources, 'FR' , '  ,', 'ie');

corrssnname_src_fr := corrssnname_src_fr_pos > 0;

corrssnname_src_l2_pos := Models.Common.findw_cpp(corrssnname_sources, 'L2' , '  ,', 'ie');

corrssnname_src_l2 := corrssnname_src_l2_pos > 0;

corrssnname_src_li_pos := Models.Common.findw_cpp(corrssnname_sources, 'LI' , '  ,', 'ie');

corrssnname_src_li := corrssnname_src_li_pos > 0;

corrssnname_src_mw_pos := Models.Common.findw_cpp(corrssnname_sources, 'MW' , '  ,', 'ie');

corrssnname_src_mw := corrssnname_src_mw_pos > 0;

corrssnname_src_nt_pos := Models.Common.findw_cpp(corrssnname_sources, 'NT' , '  ,', 'ie');

corrssnname_src_nt := corrssnname_src_nt_pos > 0;

corrssnname_src_p_pos := Models.Common.findw_cpp(corrssnname_sources, 'P' , '  ,', 'ie');

corrssnname_src_p := corrssnname_src_p_pos > 0;

corrssnname_src_pl_pos := Models.Common.findw_cpp(corrssnname_sources, 'PL' , '  ,', 'ie');

corrssnname_src_pl := corrssnname_src_pl_pos > 0;

corrssnname_src_tn_pos := Models.Common.findw_cpp(corrssnname_sources, 'TN' , '  ,', 'ie');

corrssnname_src_tn := corrssnname_src_tn_pos > 0;

corrssnname_src_ts_pos := Models.Common.findw_cpp(corrssnname_sources, 'TS' , '  ,', 'ie');

corrssnname_src_ts := corrssnname_src_ts_pos > 0;

corrssnname_src_tu_pos := Models.Common.findw_cpp(corrssnname_sources, 'TU' , '  ,', 'ie');

corrssnname_src_tu := corrssnname_src_tu_pos > 0;

corrssnname_src_sl_pos := Models.Common.findw_cpp(corrssnname_sources, 'SL' , '  ,', 'ie');

corrssnname_src_sl := corrssnname_src_sl_pos > 0;

corrssnname_src_v_pos := Models.Common.findw_cpp(corrssnname_sources, 'V' , '  ,', 'ie');

corrssnname_src_v := corrssnname_src_v_pos > 0;

corrssnname_src_vo_pos := Models.Common.findw_cpp(corrssnname_sources, 'VO' , '  ,', 'ie');

corrssnname_src_vo := corrssnname_src_vo_pos > 0;

corrssnname_src_w_pos := Models.Common.findw_cpp(corrssnname_sources, 'W' , '  ,', 'ie');

corrssnname_src_w := corrssnname_src_w_pos > 0;

corrssnname_src_wp_pos := Models.Common.findw_cpp(corrssnname_sources, 'WP' , '  ,', 'ie');

corrssnname_src_wp := corrssnname_src_wp_pos > 0;

corrssnname_ct := if(max((integer)corrssnname_src_ak, (integer)corrssnname_src_am, (integer)corrssnname_src_ar, (integer)corrssnname_src_ba, (integer)corrssnname_src_cg, (integer)corrssnname_src_co, (integer)corrssnname_src_cy, (integer)corrssnname_src_d, (integer)corrssnname_src_da, (integer)corrssnname_src_de, (integer)corrssnname_src_dl, (integer)corrssnname_src_ds, (integer)corrssnname_src_e1, (integer)corrssnname_src_e2, (integer)corrssnname_src_e3, (integer)corrssnname_src_e4, (integer)corrssnname_src_eb, (integer)corrssnname_src_em, (integer)corrssnname_src_en, (integer)corrssnname_src_eq, (integer)corrssnname_src_fe, (integer)corrssnname_src_ff, (integer)corrssnname_src_fr, (integer)corrssnname_src_l2, (integer)corrssnname_src_li, (integer)corrssnname_src_mw, (integer)corrssnname_src_nt, (integer)corrssnname_src_p, (integer)corrssnname_src_pl, (integer)corrssnname_src_sl, (integer)corrssnname_src_tn, (integer)corrssnname_src_ts, (integer)corrssnname_src_tu, (integer)corrssnname_src_v, (integer)corrssnname_src_vo, (integer)corrssnname_src_w, (integer)corrssnname_src_wp) = NULL, NULL, sum((integer)corrssnname_src_ak, (integer)corrssnname_src_am, (integer)corrssnname_src_ar, (integer)corrssnname_src_ba, (integer)corrssnname_src_cg, (integer)corrssnname_src_co, (integer)corrssnname_src_cy, (integer)corrssnname_src_d, (integer)corrssnname_src_da, (integer)corrssnname_src_de, (integer)corrssnname_src_dl, (integer)corrssnname_src_ds, (integer)corrssnname_src_e1, (integer)corrssnname_src_e2, (integer)corrssnname_src_e3, (integer)corrssnname_src_e4, (integer)corrssnname_src_eb, (integer)corrssnname_src_em, (integer)corrssnname_src_en, (integer)corrssnname_src_eq, (integer)corrssnname_src_fe, (integer)corrssnname_src_ff, (integer)corrssnname_src_fr, (integer)corrssnname_src_l2, (integer)corrssnname_src_li, (integer)corrssnname_src_mw, (integer)corrssnname_src_nt, (integer)corrssnname_src_p, (integer)corrssnname_src_pl, (integer)corrssnname_src_sl, (integer)corrssnname_src_tn, (integer)corrssnname_src_ts, (integer)corrssnname_src_tu, (integer)corrssnname_src_v, (integer)corrssnname_src_vo, (integer)corrssnname_src_w, (integer)corrssnname_src_wp));

nf_corrssnname := map(
    not(truedid)                           => NULL,
    (integer)lnamepop = 0 or (integer)ssnlength < 9 => NULL, 
                                              min(if(corrssnname_ct = NULL, -NULL, corrssnname_ct), 999));

corrssnaddr_src_ak_pos := Models.Common.findw_cpp(corrssnaddr_sources, 'AK' , '  ,', 'ie');

corrssnaddr_src_ak := corrssnaddr_src_ak_pos > 0;

corrssnaddr_src_am_pos := Models.Common.findw_cpp(corrssnaddr_sources, 'AM' , '  ,', 'ie');

corrssnaddr_src_am := corrssnaddr_src_am_pos > 0;

corrssnaddr_src_ar_pos := Models.Common.findw_cpp(corrssnaddr_sources, 'AR' , '  ,', 'ie');

corrssnaddr_src_ar := corrssnaddr_src_ar_pos > 0;

corrssnaddr_src_ba_pos := Models.Common.findw_cpp(corrssnaddr_sources, 'BA' , '  ,', 'ie');

corrssnaddr_src_ba := corrssnaddr_src_ba_pos > 0;

corrssnaddr_src_cg_pos := Models.Common.findw_cpp(corrssnaddr_sources, 'CG' , '  ,', 'ie');

corrssnaddr_src_cg := corrssnaddr_src_cg_pos > 0;

corrssnaddr_src_co_pos := Models.Common.findw_cpp(corrssnaddr_sources, 'CO' , '  ,', 'ie');

corrssnaddr_src_co := corrssnaddr_src_co_pos > 0;

corrssnaddr_src_cy_pos := Models.Common.findw_cpp(corrssnaddr_sources, 'CY' , '  ,', 'ie');

corrssnaddr_src_cy := corrssnaddr_src_cy_pos > 0;

corrssnaddr_src_da_pos := Models.Common.findw_cpp(corrssnaddr_sources, 'DA' , '  ,', 'ie');

corrssnaddr_src_da := corrssnaddr_src_da_pos > 0;

corrssnaddr_src_d_pos := Models.Common.findw_cpp(corrssnaddr_sources, 'D' , '  ,', 'ie');

corrssnaddr_src_d := corrssnaddr_src_d_pos > 0;

corrssnaddr_src_dl_pos := Models.Common.findw_cpp(corrssnaddr_sources, 'DL' , '  ,', 'ie');

corrssnaddr_src_dl := corrssnaddr_src_dl_pos > 0;

corrssnaddr_src_ds_pos := Models.Common.findw_cpp(corrssnaddr_sources, 'DS' , '  ,', 'ie');

corrssnaddr_src_ds := corrssnaddr_src_ds_pos > 0;

corrssnaddr_src_de_pos := Models.Common.findw_cpp(corrssnaddr_sources, 'DE' , '  ,', 'ie');

corrssnaddr_src_de := corrssnaddr_src_de_pos > 0;

corrssnaddr_src_eb_pos := Models.Common.findw_cpp(corrssnaddr_sources, 'EB' , '  ,', 'ie');

corrssnaddr_src_eb := corrssnaddr_src_eb_pos > 0;

corrssnaddr_src_em_pos := Models.Common.findw_cpp(corrssnaddr_sources, 'EM' , '  ,', 'ie');

corrssnaddr_src_em := corrssnaddr_src_em_pos > 0;

corrssnaddr_src_e1_pos := Models.Common.findw_cpp(corrssnaddr_sources, 'E1' , '  ,', 'ie');

corrssnaddr_src_e1 := corrssnaddr_src_e1_pos > 0;

corrssnaddr_src_e2_pos := Models.Common.findw_cpp(corrssnaddr_sources, 'E2' , '  ,', 'ie');

corrssnaddr_src_e2 := corrssnaddr_src_e2_pos > 0;

corrssnaddr_src_e3_pos := Models.Common.findw_cpp(corrssnaddr_sources, 'E3' , '  ,', 'ie');

corrssnaddr_src_e3 := corrssnaddr_src_e3_pos > 0;

corrssnaddr_src_e4_pos := Models.Common.findw_cpp(corrssnaddr_sources, 'E4' , '  ,', 'ie');

corrssnaddr_src_e4 := corrssnaddr_src_e4_pos > 0;

corrssnaddr_src_en_pos := Models.Common.findw_cpp(corrssnaddr_sources, 'EN' , '  ,', 'ie');

corrssnaddr_src_en := corrssnaddr_src_en_pos > 0;

corrssnaddr_src_eq_pos := Models.Common.findw_cpp(corrssnaddr_sources, 'EQ' , '  ,', 'ie');

corrssnaddr_src_eq := corrssnaddr_src_eq_pos > 0;

corrssnaddr_src_fe_pos := Models.Common.findw_cpp(corrssnaddr_sources, 'FE' , '  ,', 'ie');

corrssnaddr_src_fe := corrssnaddr_src_fe_pos > 0;

corrssnaddr_src_ff_pos := Models.Common.findw_cpp(corrssnaddr_sources, 'FF' , '  ,', 'ie');

corrssnaddr_src_ff := corrssnaddr_src_ff_pos > 0;

corrssnaddr_src_fr_pos := Models.Common.findw_cpp(corrssnaddr_sources, 'FR' , '  ,', 'ie');

corrssnaddr_src_fr := corrssnaddr_src_fr_pos > 0;

corrssnaddr_src_l2_pos := Models.Common.findw_cpp(corrssnaddr_sources, 'L2' , '  ,', 'ie');

corrssnaddr_src_l2 := corrssnaddr_src_l2_pos > 0;

corrssnaddr_src_li_pos := Models.Common.findw_cpp(corrssnaddr_sources, 'LI' , '  ,', 'ie');

corrssnaddr_src_li := corrssnaddr_src_li_pos > 0;

corrssnaddr_src_mw_pos := Models.Common.findw_cpp(corrssnaddr_sources, 'MW' , '  ,', 'ie');

corrssnaddr_src_mw := corrssnaddr_src_mw_pos > 0;

corrssnaddr_src_nt_pos := Models.Common.findw_cpp(corrssnaddr_sources, 'NT' , '  ,', 'ie');

corrssnaddr_src_nt := corrssnaddr_src_nt_pos > 0;

corrssnaddr_src_p_pos := Models.Common.findw_cpp(corrssnaddr_sources, 'P' , '  ,', 'ie');

corrssnaddr_src_p := corrssnaddr_src_p_pos > 0;

corrssnaddr_src_pl_pos := Models.Common.findw_cpp(corrssnaddr_sources, 'PL' , '  ,', 'ie');

corrssnaddr_src_pl := corrssnaddr_src_pl_pos > 0;

corrssnaddr_src_tn_pos := Models.Common.findw_cpp(corrssnaddr_sources, 'TN' , '  ,', 'ie');

corrssnaddr_src_tn := corrssnaddr_src_tn_pos > 0;

corrssnaddr_src_ts_pos := Models.Common.findw_cpp(corrssnaddr_sources, 'TS' , '  ,', 'ie');

corrssnaddr_src_ts := corrssnaddr_src_ts_pos > 0;

corrssnaddr_src_tu_pos := Models.Common.findw_cpp(corrssnaddr_sources, 'TU' , '  ,', 'ie');

corrssnaddr_src_tu := corrssnaddr_src_tu_pos > 0;

corrssnaddr_src_sl_pos := Models.Common.findw_cpp(corrssnaddr_sources, 'SL' , '  ,', 'ie');

corrssnaddr_src_sl := corrssnaddr_src_sl_pos > 0;

corrssnaddr_src_v_pos := Models.Common.findw_cpp(corrssnaddr_sources, 'V' , '  ,', 'ie');

corrssnaddr_src_v := corrssnaddr_src_v_pos > 0;

corrssnaddr_src_vo_pos := Models.Common.findw_cpp(corrssnaddr_sources, 'VO' , '  ,', 'ie');

corrssnaddr_src_vo := corrssnaddr_src_vo_pos > 0;

corrssnaddr_src_w_pos := Models.Common.findw_cpp(corrssnaddr_sources, 'W' , '  ,', 'ie');

corrssnaddr_src_w := corrssnaddr_src_w_pos > 0;

corrssnaddr_src_wp_pos := Models.Common.findw_cpp(corrssnaddr_sources, 'WP' , '  ,', 'ie');

corrssnaddr_src_wp := corrssnaddr_src_wp_pos > 0;

corrssnaddr_ct := if(max((integer)corrssnaddr_src_ak, (integer)corrssnaddr_src_am, (integer)corrssnaddr_src_ar, (integer)corrssnaddr_src_ba, (integer)corrssnaddr_src_cg, (integer)corrssnaddr_src_co, (integer)corrssnaddr_src_cy, (integer)corrssnaddr_src_d, (integer)corrssnaddr_src_da, (integer)corrssnaddr_src_de, (integer)corrssnaddr_src_dl, (integer)corrssnaddr_src_ds, (integer)corrssnaddr_src_e1, (integer)corrssnaddr_src_e2, (integer)corrssnaddr_src_e3, (integer)corrssnaddr_src_e4, (integer)corrssnaddr_src_eb, (integer)corrssnaddr_src_em, (integer)corrssnaddr_src_en, (integer)corrssnaddr_src_eq, (integer)corrssnaddr_src_fe, (integer)corrssnaddr_src_ff, (integer)corrssnaddr_src_fr, (integer)corrssnaddr_src_l2, (integer)corrssnaddr_src_li, (integer)corrssnaddr_src_mw, (integer)corrssnaddr_src_nt, (integer)corrssnaddr_src_p, (integer)corrssnaddr_src_pl, (integer)corrssnaddr_src_sl, (integer)corrssnaddr_src_tn, (integer)corrssnaddr_src_ts, (integer)corrssnaddr_src_tu, (integer)corrssnaddr_src_v, (integer)corrssnaddr_src_vo, (integer)corrssnaddr_src_w, (integer)corrssnaddr_src_wp) = NULL, NULL, sum((integer)corrssnaddr_src_ak, (integer)corrssnaddr_src_am, (integer)corrssnaddr_src_ar, (integer)corrssnaddr_src_ba, (integer)corrssnaddr_src_cg, (integer)corrssnaddr_src_co, (integer)corrssnaddr_src_cy, (integer)corrssnaddr_src_d, (integer)corrssnaddr_src_da, (integer)corrssnaddr_src_de, (integer)corrssnaddr_src_dl, (integer)corrssnaddr_src_ds, (integer)corrssnaddr_src_e1, (integer)corrssnaddr_src_e2, (integer)corrssnaddr_src_e3, (integer)corrssnaddr_src_e4, (integer)corrssnaddr_src_eb, (integer)corrssnaddr_src_em, (integer)corrssnaddr_src_en, (integer)corrssnaddr_src_eq, (integer)corrssnaddr_src_fe, (integer)corrssnaddr_src_ff, (integer)corrssnaddr_src_fr, (integer)corrssnaddr_src_l2, (integer)corrssnaddr_src_li, (integer)corrssnaddr_src_mw, (integer)corrssnaddr_src_nt, (integer)corrssnaddr_src_p, (integer)corrssnaddr_src_pl, (integer)corrssnaddr_src_sl, (integer)corrssnaddr_src_tn, (integer)corrssnaddr_src_ts, (integer)corrssnaddr_src_tu, (integer)corrssnaddr_src_v, (integer)corrssnaddr_src_vo, (integer)corrssnaddr_src_w, (integer)corrssnaddr_src_wp));

nf_corrssnaddr := map(
     not(truedid)                                  => NULL,
    (integer)ssnlength < 9 or (integer)addrpop = 0 => NULL,
                                                      min(if(corrssnaddr_ct = NULL, -NULL, corrssnaddr_ct), 999));

corraddrname_src_ak_pos := Models.Common.findw_cpp(corraddrname_sources, 'AK' , '  ,', 'ie');

corraddrname_src_ak := corraddrname_src_ak_pos > 0;

corraddrname_src_am_pos := Models.Common.findw_cpp(corraddrname_sources, 'AM' , '  ,', 'ie');

corraddrname_src_am := corraddrname_src_am_pos > 0;

corraddrname_src_ar_pos := Models.Common.findw_cpp(corraddrname_sources, 'AR' , '  ,', 'ie');

corraddrname_src_ar := corraddrname_src_ar_pos > 0;

corraddrname_src_ba_pos := Models.Common.findw_cpp(corraddrname_sources, 'BA' , '  ,', 'ie');

corraddrname_src_ba := corraddrname_src_ba_pos > 0;

corraddrname_src_cg_pos := Models.Common.findw_cpp(corraddrname_sources, 'CG' , '  ,', 'ie');

corraddrname_src_cg := corraddrname_src_cg_pos > 0;

corraddrname_src_co_pos := Models.Common.findw_cpp(corraddrname_sources, 'CO' , '  ,', 'ie');

corraddrname_src_co := corraddrname_src_co_pos > 0;

corraddrname_src_cy_pos := Models.Common.findw_cpp(corraddrname_sources, 'CY' , '  ,', 'ie');

corraddrname_src_cy := corraddrname_src_cy_pos > 0;

corraddrname_src_da_pos := Models.Common.findw_cpp(corraddrname_sources, 'DA' , '  ,', 'ie');

corraddrname_src_da := corraddrname_src_da_pos > 0;

corraddrname_src_d_pos := Models.Common.findw_cpp(corraddrname_sources, 'D' , '  ,', 'ie');

corraddrname_src_d := corraddrname_src_d_pos > 0;

corraddrname_src_dl_pos := Models.Common.findw_cpp(corraddrname_sources, 'DL' , '  ,', 'ie');

corraddrname_src_dl := corraddrname_src_dl_pos > 0;

corraddrname_src_ds_pos := Models.Common.findw_cpp(corraddrname_sources, 'DS' , '  ,', 'ie');

corraddrname_src_ds := corraddrname_src_ds_pos > 0;

corraddrname_src_de_pos := Models.Common.findw_cpp(corraddrname_sources, 'DE' , '  ,', 'ie');

corraddrname_src_de := corraddrname_src_de_pos > 0;

corraddrname_src_eb_pos := Models.Common.findw_cpp(corraddrname_sources, 'EB' , '  ,', 'ie');

corraddrname_src_eb := corraddrname_src_eb_pos > 0;

corraddrname_src_em_pos := Models.Common.findw_cpp(corraddrname_sources, 'EM' , '  ,', 'ie');

corraddrname_src_em := corraddrname_src_em_pos > 0;

corraddrname_src_e1_pos := Models.Common.findw_cpp(corraddrname_sources, 'E1' , '  ,', 'ie');

corraddrname_src_e1 := corraddrname_src_e1_pos > 0;

corraddrname_src_e2_pos := Models.Common.findw_cpp(corraddrname_sources, 'E2' , '  ,', 'ie');

corraddrname_src_e2 := corraddrname_src_e2_pos > 0;

corraddrname_src_e3_pos := Models.Common.findw_cpp(corraddrname_sources, 'E3' , '  ,', 'ie');

corraddrname_src_e3 := corraddrname_src_e3_pos > 0;

corraddrname_src_e4_pos := Models.Common.findw_cpp(corraddrname_sources, 'E4' , '  ,', 'ie');

corraddrname_src_e4 := corraddrname_src_e4_pos > 0;

corraddrname_src_en_pos := Models.Common.findw_cpp(corraddrname_sources, 'EN' , '  ,', 'ie');

corraddrname_src_en := corraddrname_src_en_pos > 0;

corraddrname_src_eq_pos := Models.Common.findw_cpp(corraddrname_sources, 'EQ' , '  ,', 'ie');

corraddrname_src_eq := corraddrname_src_eq_pos > 0;

corraddrname_src_fe_pos := Models.Common.findw_cpp(corraddrname_sources, 'FE' , '  ,', 'ie');

corraddrname_src_fe := corraddrname_src_fe_pos > 0;

corraddrname_src_ff_pos := Models.Common.findw_cpp(corraddrname_sources, 'FF' , '  ,', 'ie');

corraddrname_src_ff := corraddrname_src_ff_pos > 0;

corraddrname_src_fr_pos := Models.Common.findw_cpp(corraddrname_sources, 'FR' , '  ,', 'ie');

corraddrname_src_fr := corraddrname_src_fr_pos > 0;

corraddrname_src_l2_pos := Models.Common.findw_cpp(corraddrname_sources, 'L2' , '  ,', 'ie');

corraddrname_src_l2 := corraddrname_src_l2_pos > 0;

corraddrname_src_li_pos := Models.Common.findw_cpp(corraddrname_sources, 'LI' , '  ,', 'ie');

corraddrname_src_li := corraddrname_src_li_pos > 0;

corraddrname_src_mw_pos := Models.Common.findw_cpp(corraddrname_sources, 'MW' , '  ,', 'ie');

corraddrname_src_mw := corraddrname_src_mw_pos > 0;

corraddrname_src_nt_pos := Models.Common.findw_cpp(corraddrname_sources, 'NT' , '  ,', 'ie');

corraddrname_src_nt := corraddrname_src_nt_pos > 0;

corraddrname_src_p_pos := Models.Common.findw_cpp(corraddrname_sources, 'P' , '  ,', 'ie');

corraddrname_src_p := corraddrname_src_p_pos > 0;

corraddrname_src_pl_pos := Models.Common.findw_cpp(corraddrname_sources, 'PL' , '  ,', 'ie');

corraddrname_src_pl := corraddrname_src_pl_pos > 0;

corraddrname_src_tn_pos := Models.Common.findw_cpp(corraddrname_sources, 'TN' , '  ,', 'ie');

corraddrname_src_tn := corraddrname_src_tn_pos > 0;

corraddrname_src_ts_pos := Models.Common.findw_cpp(corraddrname_sources, 'TS' , '  ,', 'ie');

corraddrname_src_ts := corraddrname_src_ts_pos > 0;

corraddrname_src_tu_pos := Models.Common.findw_cpp(corraddrname_sources, 'TU' , '  ,', 'ie');

corraddrname_src_tu := corraddrname_src_tu_pos > 0;

corraddrname_src_sl_pos := Models.Common.findw_cpp(corraddrname_sources, 'SL' , '  ,', 'ie');

corraddrname_src_sl := corraddrname_src_sl_pos > 0;

corraddrname_src_v_pos := Models.Common.findw_cpp(corraddrname_sources, 'V' , '  ,', 'ie');

corraddrname_src_v := corraddrname_src_v_pos > 0;

corraddrname_src_vo_pos := Models.Common.findw_cpp(corraddrname_sources, 'VO' , '  ,', 'ie');

corraddrname_src_vo := corraddrname_src_vo_pos > 0;

corraddrname_src_w_pos := Models.Common.findw_cpp(corraddrname_sources, 'W' , '  ,', 'ie');

corraddrname_src_w := corraddrname_src_w_pos > 0;

corraddrname_src_wp_pos := Models.Common.findw_cpp(corraddrname_sources, 'WP' , '  ,', 'ie');

corraddrname_src_wp := corraddrname_src_wp_pos > 0;

corraddrname_ct := if(max((integer)corraddrname_src_ak, (integer)corraddrname_src_am, (integer)corraddrname_src_ar, (integer)corraddrname_src_ba, (integer)corraddrname_src_cg, (integer)corraddrname_src_co, (integer)corraddrname_src_cy, (integer)corraddrname_src_d, (integer)corraddrname_src_da, (integer)corraddrname_src_de, (integer)corraddrname_src_dl, (integer)corraddrname_src_ds, (integer)corraddrname_src_e1, (integer)corraddrname_src_e2, (integer)corraddrname_src_e3, (integer)corraddrname_src_e4, (integer)corraddrname_src_eb, (integer)corraddrname_src_em, (integer)corraddrname_src_en, (integer)corraddrname_src_eq, (integer)corraddrname_src_fe, (integer)corraddrname_src_ff, (integer)corraddrname_src_fr, (integer)corraddrname_src_l2, (integer)corraddrname_src_li, (integer)corraddrname_src_mw, (integer)corraddrname_src_nt, (integer)corraddrname_src_p, (integer)corraddrname_src_pl, (integer)corraddrname_src_sl, (integer)corraddrname_src_tn, (integer)corraddrname_src_ts, (integer)corraddrname_src_tu, (integer)corraddrname_src_v, (integer)corraddrname_src_vo, (integer)corraddrname_src_w, (integer)corraddrname_src_wp) = NULL, NULL, sum((integer)corraddrname_src_ak, (integer)corraddrname_src_am, (integer)corraddrname_src_ar, (integer)corraddrname_src_ba, (integer)corraddrname_src_cg, (integer)corraddrname_src_co, (integer)corraddrname_src_cy, (integer)corraddrname_src_d, (integer)corraddrname_src_da, (integer)corraddrname_src_de, (integer)corraddrname_src_dl, (integer)corraddrname_src_ds, (integer)corraddrname_src_e1, (integer)corraddrname_src_e2, (integer)corraddrname_src_e3, (integer)corraddrname_src_e4, (integer)corraddrname_src_eb, (integer)corraddrname_src_em, (integer)corraddrname_src_en, (integer)corraddrname_src_eq, (integer)corraddrname_src_fe, (integer)corraddrname_src_ff, (integer)corraddrname_src_fr, (integer)corraddrname_src_l2, (integer)corraddrname_src_li, (integer)corraddrname_src_mw, (integer)corraddrname_src_nt, (integer)corraddrname_src_p, (integer)corraddrname_src_pl, (integer)corraddrname_src_sl, (integer)corraddrname_src_tn, (integer)corraddrname_src_ts, (integer)corraddrname_src_tu, (integer)corraddrname_src_v, (integer)corraddrname_src_vo, (integer)corraddrname_src_w, (integer)corraddrname_src_wp));

nf_corraddrname := map(
    not(truedid)                                  => NULL,
    (integer)lnamepop = 0 or (integer)addrpop = 0 => NULL,
                                   min(if(corraddrname_ct = NULL, -NULL, corraddrname_ct), 999));

corraddrphone_src_ak_pos := Models.Common.findw_cpp(corraddrphone_sources, 'AK' , '  ,', 'ie');

corraddrphone_src_ak := corraddrphone_src_ak_pos > 0;

corraddrphone_src_am_pos := Models.Common.findw_cpp(corraddrphone_sources, 'AM' , '  ,', 'ie');

corraddrphone_src_am := corraddrphone_src_am_pos > 0;

corraddrphone_src_ar_pos := Models.Common.findw_cpp(corraddrphone_sources, 'AR' , '  ,', 'ie');

corraddrphone_src_ar := corraddrphone_src_ar_pos > 0;

corraddrphone_src_ba_pos := Models.Common.findw_cpp(corraddrphone_sources, 'BA' , '  ,', 'ie');

corraddrphone_src_ba := corraddrphone_src_ba_pos > 0;

corraddrphone_src_cg_pos := Models.Common.findw_cpp(corraddrphone_sources, 'CG' , '  ,', 'ie');

corraddrphone_src_cg := corraddrphone_src_cg_pos > 0;

corraddrphone_src_co_pos := Models.Common.findw_cpp(corraddrphone_sources, 'CO' , '  ,', 'ie');

corraddrphone_src_co := corraddrphone_src_co_pos > 0;

corraddrphone_src_cy_pos := Models.Common.findw_cpp(corraddrphone_sources, 'CY' , '  ,', 'ie');

corraddrphone_src_cy := corraddrphone_src_cy_pos > 0;

corraddrphone_src_da_pos := Models.Common.findw_cpp(corraddrphone_sources, 'DA' , '  ,', 'ie');

corraddrphone_src_da := corraddrphone_src_da_pos > 0;

corraddrphone_src_d_pos := Models.Common.findw_cpp(corraddrphone_sources, 'D' , '  ,', 'ie');

corraddrphone_src_d := corraddrphone_src_d_pos > 0;

corraddrphone_src_dl_pos := Models.Common.findw_cpp(corraddrphone_sources, 'DL' , '  ,', 'ie');

corraddrphone_src_dl := corraddrphone_src_dl_pos > 0;

corraddrphone_src_ds_pos := Models.Common.findw_cpp(corraddrphone_sources, 'DS' , '  ,', 'ie');

corraddrphone_src_ds := corraddrphone_src_ds_pos > 0;

corraddrphone_src_de_pos := Models.Common.findw_cpp(corraddrphone_sources, 'DE' , '  ,', 'ie');

corraddrphone_src_de := corraddrphone_src_de_pos > 0;

corraddrphone_src_eb_pos := Models.Common.findw_cpp(corraddrphone_sources, 'EB' , '  ,', 'ie');

corraddrphone_src_eb := corraddrphone_src_eb_pos > 0;

corraddrphone_src_em_pos := Models.Common.findw_cpp(corraddrphone_sources, 'EM' , '  ,', 'ie');

corraddrphone_src_em := corraddrphone_src_em_pos > 0;

corraddrphone_src_e1_pos := Models.Common.findw_cpp(corraddrphone_sources, 'E1' , '  ,', 'ie');

corraddrphone_src_e1 := corraddrphone_src_e1_pos > 0;

corraddrphone_src_e2_pos := Models.Common.findw_cpp(corraddrphone_sources, 'E2' , '  ,', 'ie');

corraddrphone_src_e2 := corraddrphone_src_e2_pos > 0;

corraddrphone_src_e3_pos := Models.Common.findw_cpp(corraddrphone_sources, 'E3' , '  ,', 'ie');

corraddrphone_src_e3 := corraddrphone_src_e3_pos > 0;

corraddrphone_src_e4_pos := Models.Common.findw_cpp(corraddrphone_sources, 'E4' , '  ,', 'ie');

corraddrphone_src_e4 := corraddrphone_src_e4_pos > 0;

corraddrphone_src_en_pos := Models.Common.findw_cpp(corraddrphone_sources, 'EN' , '  ,', 'ie');

corraddrphone_src_en := corraddrphone_src_en_pos > 0;

corraddrphone_src_eq_pos := Models.Common.findw_cpp(corraddrphone_sources, 'EQ' , '  ,', 'ie');

corraddrphone_src_eq := corraddrphone_src_eq_pos > 0;

corraddrphone_src_fe_pos := Models.Common.findw_cpp(corraddrphone_sources, 'FE' , '  ,', 'ie');

corraddrphone_src_fe := corraddrphone_src_fe_pos > 0;

corraddrphone_src_ff_pos := Models.Common.findw_cpp(corraddrphone_sources, 'FF' , '  ,', 'ie');

corraddrphone_src_ff := corraddrphone_src_ff_pos > 0;

corraddrphone_src_fr_pos := Models.Common.findw_cpp(corraddrphone_sources, 'FR' , '  ,', 'ie');

corraddrphone_src_fr := corraddrphone_src_fr_pos > 0;

corraddrphone_src_l2_pos := Models.Common.findw_cpp(corraddrphone_sources, 'L2' , '  ,', 'ie');

corraddrphone_src_l2 := corraddrphone_src_l2_pos > 0;

corraddrphone_src_li_pos := Models.Common.findw_cpp(corraddrphone_sources, 'LI' , '  ,', 'ie');

corraddrphone_src_li := corraddrphone_src_li_pos > 0;

corraddrphone_src_mw_pos := Models.Common.findw_cpp(corraddrphone_sources, 'MW' , '  ,', 'ie');

corraddrphone_src_mw := corraddrphone_src_mw_pos > 0;

corraddrphone_src_nt_pos := Models.Common.findw_cpp(corraddrphone_sources, 'NT' , '  ,', 'ie');

corraddrphone_src_nt := corraddrphone_src_nt_pos > 0;

corraddrphone_src_p_pos := Models.Common.findw_cpp(corraddrphone_sources, 'P' , '  ,', 'ie');

corraddrphone_src_p := corraddrphone_src_p_pos > 0;

corraddrphone_src_pl_pos := Models.Common.findw_cpp(corraddrphone_sources, 'PL' , '  ,', 'ie');

corraddrphone_src_pl := corraddrphone_src_pl_pos > 0;

corraddrphone_src_tn_pos := Models.Common.findw_cpp(corraddrphone_sources, 'TN' , '  ,', 'ie');

corraddrphone_src_tn := corraddrphone_src_tn_pos > 0;

corraddrphone_src_ts_pos := Models.Common.findw_cpp(corraddrphone_sources, 'TS' , '  ,', 'ie');

corraddrphone_src_ts := corraddrphone_src_ts_pos > 0;

corraddrphone_src_tu_pos := Models.Common.findw_cpp(corraddrphone_sources, 'TU' , '  ,', 'ie');

corraddrphone_src_tu := corraddrphone_src_tu_pos > 0;

corraddrphone_src_sl_pos := Models.Common.findw_cpp(corraddrphone_sources, 'SL' , '  ,', 'ie');

corraddrphone_src_sl := corraddrphone_src_sl_pos > 0;

corraddrphone_src_v_pos := Models.Common.findw_cpp(corraddrphone_sources, 'V' , '  ,', 'ie');

corraddrphone_src_v := corraddrphone_src_v_pos > 0;

corraddrphone_src_vo_pos := Models.Common.findw_cpp(corraddrphone_sources, 'VO' , '  ,', 'ie');

corraddrphone_src_vo := corraddrphone_src_vo_pos > 0;

corraddrphone_src_w_pos := Models.Common.findw_cpp(corraddrphone_sources, 'W' , '  ,', 'ie');

corraddrphone_src_w := corraddrphone_src_w_pos > 0;

corraddrphone_src_wp_pos := Models.Common.findw_cpp(corraddrphone_sources, 'WP' , '  ,', 'ie');

corraddrphone_src_wp := corraddrphone_src_wp_pos > 0;

corraddrphone_ct := if(max((integer)corraddrphone_src_ak, (integer)corraddrphone_src_am, (integer)corraddrphone_src_ar, (integer)corraddrphone_src_ba, (integer)corraddrphone_src_cg, (integer)corraddrphone_src_co, (integer)corraddrphone_src_cy, (integer)corraddrphone_src_d, (integer)corraddrphone_src_da, (integer)corraddrphone_src_de, (integer)corraddrphone_src_dl, (integer)corraddrphone_src_ds, (integer)corraddrphone_src_e1, (integer)corraddrphone_src_e2, (integer)corraddrphone_src_e3, (integer)corraddrphone_src_e4, (integer)corraddrphone_src_eb, (integer)corraddrphone_src_em, (integer)corraddrphone_src_en, (integer)corraddrphone_src_eq, (integer)corraddrphone_src_fe, (integer)corraddrphone_src_ff, (integer)corraddrphone_src_fr, (integer)corraddrphone_src_l2, (integer)corraddrphone_src_li, (integer)corraddrphone_src_mw, (integer)corraddrphone_src_nt, (integer)corraddrphone_src_p, (integer)corraddrphone_src_pl, (integer)corraddrphone_src_sl, (integer)corraddrphone_src_tn, (integer)corraddrphone_src_ts, (integer)corraddrphone_src_tu, (integer)corraddrphone_src_v, (integer)corraddrphone_src_vo, (integer)corraddrphone_src_w, (integer)corraddrphone_src_wp) = NULL, NULL, sum((integer)corraddrphone_src_ak, (integer)corraddrphone_src_am, (integer)corraddrphone_src_ar, (integer)corraddrphone_src_ba, (integer)corraddrphone_src_cg, (integer)corraddrphone_src_co, (integer)corraddrphone_src_cy, (integer)corraddrphone_src_d, (integer)corraddrphone_src_da, (integer)corraddrphone_src_de, (integer)corraddrphone_src_dl, (integer)corraddrphone_src_ds, (integer)corraddrphone_src_e1, (integer)corraddrphone_src_e2, (integer)corraddrphone_src_e3, (integer)corraddrphone_src_e4, (integer)corraddrphone_src_eb, (integer)corraddrphone_src_em, (integer)corraddrphone_src_en, (integer)corraddrphone_src_eq, (integer)corraddrphone_src_fe, (integer)corraddrphone_src_ff, (integer)corraddrphone_src_fr, (integer)corraddrphone_src_l2, (integer)corraddrphone_src_li, (integer)corraddrphone_src_mw, (integer)corraddrphone_src_nt, (integer)corraddrphone_src_p, (integer)corraddrphone_src_pl, (integer)corraddrphone_src_sl, (integer)corraddrphone_src_tn, (integer)corraddrphone_src_ts, (integer)corraddrphone_src_tu, (integer)corraddrphone_src_v, (integer)corraddrphone_src_vo, (integer)corraddrphone_src_w, (integer)corraddrphone_src_wp));

nf_corraddrphone := map(
    not(truedid)                                 => NULL,
    (integer)hphnpop = 0 or (integer)addrpop = 0 => NULL,
                                                    min(if(corraddrphone_ct = NULL, -NULL, corraddrphone_ct), 999));

corrphonelastname_src_ak_pos := Models.Common.findw_cpp(corrphonelastname_sources, 'AK' , '  ,', 'ie');

corrphonelastname_src_ak := corrphonelastname_src_ak_pos > 0;

corrphonelastname_src_am_pos := Models.Common.findw_cpp(corrphonelastname_sources, 'AM' , '  ,', 'ie');

corrphonelastname_src_am := corrphonelastname_src_am_pos > 0;

corrphonelastname_src_ar_pos := Models.Common.findw_cpp(corrphonelastname_sources, 'AR' , '  ,', 'ie');

corrphonelastname_src_ar := corrphonelastname_src_ar_pos > 0;

corrphonelastname_src_ba_pos := Models.Common.findw_cpp(corrphonelastname_sources, 'BA' , '  ,', 'ie');

corrphonelastname_src_ba := corrphonelastname_src_ba_pos > 0;

corrphonelastname_src_cg_pos := Models.Common.findw_cpp(corrphonelastname_sources, 'CG' , '  ,', 'ie');

corrphonelastname_src_cg := corrphonelastname_src_cg_pos > 0;

corrphonelastname_src_co_pos := Models.Common.findw_cpp(corrphonelastname_sources, 'CO' , '  ,', 'ie');

corrphonelastname_src_co := corrphonelastname_src_co_pos > 0;

corrphonelastname_src_cy_pos := Models.Common.findw_cpp(corrphonelastname_sources, 'CY' , '  ,', 'ie');

corrphonelastname_src_cy := corrphonelastname_src_cy_pos > 0;

corrphonelastname_src_da_pos := Models.Common.findw_cpp(corrphonelastname_sources, 'DA' , '  ,', 'ie');

corrphonelastname_src_da := corrphonelastname_src_da_pos > 0;

corrphonelastname_src_d_pos := Models.Common.findw_cpp(corrphonelastname_sources, 'D' , '  ,', 'ie');

corrphonelastname_src_d := corrphonelastname_src_d_pos > 0;

corrphonelastname_src_dl_pos := Models.Common.findw_cpp(corrphonelastname_sources, 'DL' , '  ,', 'ie');

corrphonelastname_src_dl := corrphonelastname_src_dl_pos > 0;

corrphonelastname_src_ds_pos := Models.Common.findw_cpp(corrphonelastname_sources, 'DS' , '  ,', 'ie');

corrphonelastname_src_ds := corrphonelastname_src_ds_pos > 0;

corrphonelastname_src_de_pos := Models.Common.findw_cpp(corrphonelastname_sources, 'DE' , '  ,', 'ie');

corrphonelastname_src_de := corrphonelastname_src_de_pos > 0;

corrphonelastname_src_eb_pos := Models.Common.findw_cpp(corrphonelastname_sources, 'EB' , '  ,', 'ie');

corrphonelastname_src_eb := corrphonelastname_src_eb_pos > 0;

corrphonelastname_src_em_pos := Models.Common.findw_cpp(corrphonelastname_sources, 'EM' , '  ,', 'ie');

corrphonelastname_src_em := corrphonelastname_src_em_pos > 0;

corrphonelastname_src_e1_pos := Models.Common.findw_cpp(corrphonelastname_sources, 'E1' , '  ,', 'ie');

corrphonelastname_src_e1 := corrphonelastname_src_e1_pos > 0;

corrphonelastname_src_e2_pos := Models.Common.findw_cpp(corrphonelastname_sources, 'E2' , '  ,', 'ie');

corrphonelastname_src_e2 := corrphonelastname_src_e2_pos > 0;

corrphonelastname_src_e3_pos := Models.Common.findw_cpp(corrphonelastname_sources, 'E3' , '  ,', 'ie');

corrphonelastname_src_e3 := corrphonelastname_src_e3_pos > 0;

corrphonelastname_src_e4_pos := Models.Common.findw_cpp(corrphonelastname_sources, 'E4' , '  ,', 'ie');

corrphonelastname_src_e4 := corrphonelastname_src_e4_pos > 0;

corrphonelastname_src_en_pos := Models.Common.findw_cpp(corrphonelastname_sources, 'EN' , '  ,', 'ie');

corrphonelastname_src_en := corrphonelastname_src_en_pos > 0;

corrphonelastname_src_eq_pos := Models.Common.findw_cpp(corrphonelastname_sources, 'EQ' , '  ,', 'ie');

corrphonelastname_src_eq := corrphonelastname_src_eq_pos > 0;

corrphonelastname_src_fe_pos := Models.Common.findw_cpp(corrphonelastname_sources, 'FE' , '  ,', 'ie');

corrphonelastname_src_fe := corrphonelastname_src_fe_pos > 0;

corrphonelastname_src_ff_pos := Models.Common.findw_cpp(corrphonelastname_sources, 'FF' , '  ,', 'ie');

corrphonelastname_src_ff := corrphonelastname_src_ff_pos > 0;

corrphonelastname_src_fr_pos := Models.Common.findw_cpp(corrphonelastname_sources, 'FR' , '  ,', 'ie');

corrphonelastname_src_fr := corrphonelastname_src_fr_pos > 0;

corrphonelastname_src_l2_pos := Models.Common.findw_cpp(corrphonelastname_sources, 'L2' , '  ,', 'ie');

corrphonelastname_src_l2 := corrphonelastname_src_l2_pos > 0;

corrphonelastname_src_li_pos := Models.Common.findw_cpp(corrphonelastname_sources, 'LI' , '  ,', 'ie');

corrphonelastname_src_li := corrphonelastname_src_li_pos > 0;

corrphonelastname_src_mw_pos := Models.Common.findw_cpp(corrphonelastname_sources, 'MW' , '  ,', 'ie');

corrphonelastname_src_mw := corrphonelastname_src_mw_pos > 0;

corrphonelastname_src_nt_pos := Models.Common.findw_cpp(corrphonelastname_sources, 'NT' , '  ,', 'ie');

corrphonelastname_src_nt := corrphonelastname_src_nt_pos > 0;

corrphonelastname_src_p_pos := Models.Common.findw_cpp(corrphonelastname_sources, 'P' , '  ,', 'ie');

corrphonelastname_src_p := corrphonelastname_src_p_pos > 0;

corrphonelastname_src_pl_pos := Models.Common.findw_cpp(corrphonelastname_sources, 'PL' , '  ,', 'ie');

corrphonelastname_src_pl := corrphonelastname_src_pl_pos > 0;

corrphonelastname_src_tn_pos := Models.Common.findw_cpp(corrphonelastname_sources, 'TN' , '  ,', 'ie');

corrphonelastname_src_tn := corrphonelastname_src_tn_pos > 0;

corrphonelastname_src_ts_pos := Models.Common.findw_cpp(corrphonelastname_sources, 'TS' , '  ,', 'ie');

corrphonelastname_src_ts := corrphonelastname_src_ts_pos > 0;

corrphonelastname_src_tu_pos := Models.Common.findw_cpp(corrphonelastname_sources, 'TU' , '  ,', 'ie');

corrphonelastname_src_tu := corrphonelastname_src_tu_pos > 0;

corrphonelastname_src_sl_pos := Models.Common.findw_cpp(corrphonelastname_sources, 'SL' , '  ,', 'ie');

corrphonelastname_src_sl := corrphonelastname_src_sl_pos > 0;

corrphonelastname_src_v_pos := Models.Common.findw_cpp(corrphonelastname_sources, 'V' , '  ,', 'ie');

corrphonelastname_src_v := corrphonelastname_src_v_pos > 0;

corrphonelastname_src_vo_pos := Models.Common.findw_cpp(corrphonelastname_sources, 'VO' , '  ,', 'ie');

corrphonelastname_src_vo := corrphonelastname_src_vo_pos > 0;

corrphonelastname_src_w_pos := Models.Common.findw_cpp(corrphonelastname_sources, 'W' , '  ,', 'ie');

corrphonelastname_src_w := corrphonelastname_src_w_pos > 0;

corrphonelastname_src_wp_pos := Models.Common.findw_cpp(corrphonelastname_sources, 'WP' , '  ,', 'ie');

corrphonelastname_src_wp := corrphonelastname_src_wp_pos > 0;

corrphonelastname_ct := if(max((integer)corrphonelastname_src_ak, (integer)corrphonelastname_src_am, (integer)corrphonelastname_src_ar, (integer)corrphonelastname_src_ba, (integer)corrphonelastname_src_cg, (integer)corrphonelastname_src_co, (integer)corrphonelastname_src_cy, (integer)corrphonelastname_src_d, (integer)corrphonelastname_src_da, (integer)corrphonelastname_src_de, (integer)corrphonelastname_src_dl, (integer)corrphonelastname_src_ds, (integer)corrphonelastname_src_e1, (integer)corrphonelastname_src_e2, (integer)corrphonelastname_src_e3, (integer)corrphonelastname_src_e4, (integer)corrphonelastname_src_eb, (integer)corrphonelastname_src_em, (integer)corrphonelastname_src_en, (integer)corrphonelastname_src_eq, (integer)corrphonelastname_src_fe, (integer)corrphonelastname_src_ff, (integer)corrphonelastname_src_fr, (integer)corrphonelastname_src_l2, (integer)corrphonelastname_src_li, (integer)corrphonelastname_src_mw, (integer)corrphonelastname_src_nt, (integer)corrphonelastname_src_p, (integer)corrphonelastname_src_pl, (integer)corrphonelastname_src_sl, (integer)corrphonelastname_src_tn, (integer)corrphonelastname_src_ts, (integer)corrphonelastname_src_tu, (integer)corrphonelastname_src_v, (integer)corrphonelastname_src_vo, (integer)corrphonelastname_src_w, (integer)corrphonelastname_src_wp) = NULL, NULL, sum((integer)corrphonelastname_src_ak, (integer)corrphonelastname_src_am, (integer)corrphonelastname_src_ar, (integer)corrphonelastname_src_ba, (integer)corrphonelastname_src_cg, (integer)corrphonelastname_src_co, (integer)corrphonelastname_src_cy, (integer)corrphonelastname_src_d, (integer)corrphonelastname_src_da, (integer)corrphonelastname_src_de, (integer)corrphonelastname_src_dl, (integer)corrphonelastname_src_ds, (integer)corrphonelastname_src_e1, (integer)corrphonelastname_src_e2, (integer)corrphonelastname_src_e3, (integer)corrphonelastname_src_e4, (integer)corrphonelastname_src_eb, (integer)corrphonelastname_src_em, (integer)corrphonelastname_src_en, (integer)corrphonelastname_src_eq, (integer)corrphonelastname_src_fe, (integer)corrphonelastname_src_ff, (integer)corrphonelastname_src_fr, (integer)corrphonelastname_src_l2, (integer)corrphonelastname_src_li, (integer)corrphonelastname_src_mw, (integer)corrphonelastname_src_nt, (integer)corrphonelastname_src_p, (integer)corrphonelastname_src_pl, (integer)corrphonelastname_src_sl, (integer)corrphonelastname_src_tn, (integer)corrphonelastname_src_ts, (integer)corrphonelastname_src_tu, (integer)corrphonelastname_src_v, (integer)corrphonelastname_src_vo, (integer)corrphonelastname_src_w, (integer)corrphonelastname_src_wp));

nf_corrphonelastname := map(
    not(truedid)                                  => NULL,
    (integer)hphnpop = 0 or (integer)lnamepop = 0 => NULL,
                                                     min(if(corrphonelastname_ct = NULL, -NULL, corrphonelastname_ct), 999));

nf_corroboration_risk_index := if(not(truedid), NULL, 
                                 if(max((integer)(nf_corrssnname > 0), 
                                        2* (integer)(nf_corrphonelastname > 0), 
                                        4* (integer)(nf_corraddrphone > 0), 
                                        8* (integer)(nf_corraddrname > 0), 
                                       16* (integer)(nf_corrssnaddr > 0)) = NULL, NULL, 
                                       sum(if((integer)(nf_corrssnname > 0) = NULL, 0,
                                       (integer)(nf_corrssnname > 0)), 
                                         if(2* (integer)(nf_corrphonelastname > 0) = NULL, 0, 2* (integer)(nf_corrphonelastname > 0)), 
                                         if(4* (integer)(nf_corraddrphone > 0) = NULL, 0,     4* (integer)(nf_corraddrphone > 0)), 
                                         if(8* (integer)(nf_corraddrname > 0)  = NULL, 0,     8* (integer)(nf_corraddrname > 0)), 
                                         if(16* (integer)(nf_corrssnaddr > 0)   = NULL, 0,    16* (integer)(nf_corrssnaddr > 0)))));



nf_inq_perphone_recency := map(
    not(truedid)             => NULL,
    inq_perphone_count01 > 0 => 1, 
    inq_perphone_count03 > 0 => 3,
    inq_perphone_count06 > 0 => 6,
    Inq_PerPhone > 0         => 12,
                            0);

rv_f00_ssn_score := map(
    not(truedid and (integer)ssnlength > 0) => NULL,
    combo_ssnscore = 255           => NULL,
                                      min(if(combo_ssnscore = NULL, -NULL, combo_ssnscore), 999));

nf_phone_ver_insurance := if(not(truedid), NULL, (integer)phone_ver_insurance);

nf_fp_validationrisktype := if(not(truedid), NULL, (integer)fp_validationrisktype);

//***in SAS the ** is the equivalent of the 'power' so in this example we converted:
//    2 ** 0 * (max(inq_fname_ver_count < 255, inq_lname_ver_count < 255) > 0),
//    2 ** 1 * (0 < inq_phone_ver_count < 255),
//    2 ** 2 * (0 < inq_addr_ver_count < 255),
//    2 ** 3 * (0 < inq_dob_ver_count < 255),
//    2 ** 4 * (0 < inq_ssn_ver_count < 255))
nf_inquiry_verification_index :=  __common__( (STRING)if(not(truedid), NULL, 
                                 if(max((integer)(max((integer)(inq_fname_ver_count < 255), (integer)(inq_lname_ver_count < 255)) > 0), 
                                                      2* (integer)(0 < inq_phone_ver_count AND inq_phone_ver_count < 255), 
                                                      4* (integer)(0 < inq_addr_ver_count AND inq_addr_ver_count < 255), 
                                                      8* (integer)(0 < inq_dob_ver_count AND inq_dob_ver_count < 255), 
                                                     16* (integer)(0 < inq_ssn_ver_count AND inq_ssn_ver_count < 255)) = NULL, NULL,
                                 sum(if( (integer)(max((integer)(inq_fname_ver_count < 255), (integer)inq_lname_ver_count < 255) > 0) = NULL, 0, 
                                    (integer)(max((integer)(inq_fname_ver_count < 255), (integer)(integer)inq_lname_ver_count < 255) > 0)), 
                                    if(2* (integer)(0 < inq_phone_ver_count AND inq_phone_ver_count < 255) = NULL, 0, 2*(integer)(0 < inq_phone_ver_count AND inq_phone_ver_count < 255)), 
                                    if(4* (integer)(0 < inq_addr_ver_count AND inq_addr_ver_count < 255) = NULL, 0,   4*(integer)(0 < inq_addr_ver_count AND inq_addr_ver_count < 255)), 
                                    if(8* (integer)(0 < inq_dob_ver_count AND inq_dob_ver_count < 255) = NULL, 0,     8* (integer)(0 < inq_dob_ver_count AND inq_dob_ver_count < 255)), 
                                    if(16* (integer)(0 < inq_ssn_ver_count AND inq_ssn_ver_count < 255) = NULL, 0,    16* (integer)(0 < inq_ssn_ver_count AND inq_ssn_ver_count < 255))))));


nf_fp_srchcomponentrisktype := if(not(truedid), NULL, (integer)fp_srchcomponentrisktype);

nf_add_dist_input_to_curr := map(
    not(add_curr_pop and add_input_pop) => NULL,
    add_input_isbestmatch               => -1,
                                           min(9999, if(add_dist_input_to_curr = NULL, -NULL, add_dist_input_to_curr)));

nf_fp_idrisktype := if(not(truedid), NULL, (integer)fp_idrisktype);

nf_inq_ssn_lexid_diff01 := if(not(truedid and (ssnlength in ['4', '9'])), NULL, inq_perssn_count01 - inq_count01);

iv_input_best_match_index := if(not(truedid), NULL, 
         if(max((integer)(input_fname_isbestmatch = '1' or input_lname_isbestmatch = '1'), 
            2*(integer)(input_phone_isbestmatch = '1'), 
            4*(integer)(add_input_isbestmatch), 
            8*(integer)(input_ssn_isbestmatch = '1')) = NULL, NULL, 
           sum(if((integer)(input_fname_isbestmatch = '1' or input_lname_isbestmatch = '1') = NULL, 0, 
                  (integer)(input_fname_isbestmatch = '1' or input_lname_isbestmatch = '1')), 
                  if(2* (integer)(input_phone_isbestmatch = '1') = NULL, 0,
                     2* (integer)(input_phone_isbestmatch = '1')), 
                     if(4* (integer)(add_input_isbestmatch) = NULL, 0,
                        4* (integer)(add_input_isbestmatch)), 
                        if(8* (integer)(input_ssn_isbestmatch = '1') = NULL, 0, 
                           8* (integer)(input_ssn_isbestmatch = '1')))));

_in_dob_3 := common.sas_date((    STRING)(in_dob));

earliest_header_date := if(max(ver_src_fdate_ak, 
                               ver_src_fdate_fr, 
                               ver_src_fdate_cy, 
                               ver_src_fdate_tn, 
                               ver_src_fdate_ts, 
                               ver_src_fdate_nt, 
                               ver_src_fdate_mw, 
                               ver_src_fdate_ds, 
                               ver_src_fdate_p, 
                               ver_src_fdate_li, 
                               ver_src_fdate_pl, 
                               ver_src_fdate_tu, 
                               ver_src_fdate_dl, 
                               ver_src_fdate_ba, 
                               ver_src_fdate_ar, 
                               ver_src_fdate_sl, 
                               ver_src_fdate_d, 
                               ver_src_fdate_eb, 
                               ver_src_fdate_e4, 
                               ver_src_fdate_l2, 
                               ver_src_fdate_em, 
                               ver_src_fdate_eq, 
                               ver_src_fdate_w, 
                               ver_src_fdate_e1, 
                               ver_src_fdate_wp, 
                               ver_src_fdate_e3, 
                               ver_src_fdate_de, 
                               ver_src_fdate_cg, 
                               ver_src_fdate_ff, 
                               ver_src_fdate_am, 
                               ver_src_fdate_fe, 
                               ver_src_fdate_co, 
                               ver_src_fdate_e2, 
                               ver_src_fdate_en, 
                               ver_src_fdate_v, 
                               ver_src_fdate_da, 
                               ver_src_fdate_vo) = NULL, NULL, 
                        min(if(ver_src_fdate_ak = NULL, -NULL, ver_src_fdate_ak), 
                            if(ver_src_fdate_fr = NULL, -NULL, ver_src_fdate_fr), 
                            if(ver_src_fdate_cy = NULL, -NULL, ver_src_fdate_cy), 
                            if(ver_src_fdate_tn = NULL, -NULL, ver_src_fdate_tn), 
                            if(ver_src_fdate_ts = NULL, -NULL, ver_src_fdate_ts), 
                            if(ver_src_fdate_nt = NULL, -NULL, ver_src_fdate_nt), 
                            if(ver_src_fdate_mw = NULL, -NULL, ver_src_fdate_mw), 
                            if(ver_src_fdate_ds = NULL, -NULL, ver_src_fdate_ds), 
                            if(ver_src_fdate_p  = NULL, -NULL, ver_src_fdate_p), 
                            if(ver_src_fdate_li = NULL, -NULL, ver_src_fdate_li), 
                            if(ver_src_fdate_pl = NULL, -NULL, ver_src_fdate_pl), 
                            if(ver_src_fdate_tu = NULL, -NULL, ver_src_fdate_tu), 
                            if(ver_src_fdate_dl = NULL, -NULL, ver_src_fdate_dl), 
                            if(ver_src_fdate_ba = NULL, -NULL, ver_src_fdate_ba), 
                            if(ver_src_fdate_ar = NULL, -NULL, ver_src_fdate_ar), 
                            if(ver_src_fdate_sl = NULL, -NULL, ver_src_fdate_sl), 
                            if(ver_src_fdate_d  = NULL, -NULL, ver_src_fdate_d), 
                            if(ver_src_fdate_eb = NULL, -NULL, ver_src_fdate_eb), 
                            if(ver_src_fdate_e4 = NULL, -NULL, ver_src_fdate_e4), 
                            if(ver_src_fdate_l2 = NULL, -NULL, ver_src_fdate_l2), 
                            if(ver_src_fdate_em = NULL, -NULL, ver_src_fdate_em), 
                            if(ver_src_fdate_eq = NULL, -NULL, ver_src_fdate_eq), 
                            if(ver_src_fdate_w  = NULL, -NULL, ver_src_fdate_w), 
                            if(ver_src_fdate_e1 = NULL, -NULL, ver_src_fdate_e1), 
                            if(ver_src_fdate_wp = NULL, -NULL, ver_src_fdate_wp), 
                            if(ver_src_fdate_e3 = NULL, -NULL, ver_src_fdate_e3), 
                            if(ver_src_fdate_de = NULL, -NULL, ver_src_fdate_de), 
                            if(ver_src_fdate_cg = NULL, -NULL, ver_src_fdate_cg), 
                            if(ver_src_fdate_ff = NULL, -NULL, ver_src_fdate_ff), 
                            if(ver_src_fdate_am = NULL, -NULL, ver_src_fdate_am), 
                            if(ver_src_fdate_fe = NULL, -NULL, ver_src_fdate_fe), 
                            if(ver_src_fdate_co = NULL, -NULL, ver_src_fdate_co), 
                            if(ver_src_fdate_e2 = NULL, -NULL, ver_src_fdate_e2), 
                            if(ver_src_fdate_en = NULL, -NULL, ver_src_fdate_en), 
                            if(ver_src_fdate_v  = NULL, -NULL, ver_src_fdate_v), 
                            if(ver_src_fdate_da = NULL, -NULL, ver_src_fdate_da),
                            if(ver_src_fdate_vo = NULL, -NULL, ver_src_fdate_vo)));

earliest_header_yrs := if(min(sysdate, earliest_header_date) = NULL, NULL, if ((sysdate - earliest_header_date) / 365.25 >= 0, roundup((sysdate - earliest_header_date) / 365.25), truncate((sysdate - earliest_header_date) / 365.25)));

calc_dob_3 := if(_in_dob_3 = NULL, NULL, if ((sysdate - _in_dob_3) / 365.25 >= 0, roundup((sysdate - _in_dob_3) / 365.25), truncate((sysdate - _in_dob_3) / 365.25)));

iv_header_emergence_age := map(
    not(truedid)               => NULL,
    earliest_header_yrs = NULL => NULL,   //***added
    not(_in_dob_3 = NULL)      => calc_dob_3 - earliest_header_yrs,
    inferred_age = 0           => NULL,
                                  inferred_age - earliest_header_yrs);

nf_unvrfd_search_risk_index := if(not(truedid), NULL, if(max((integer)(fp_srchunvrfdphonecount > '0') + 
    2* (integer)(fp_srchunvrfddobcount > '0') +
    4* (integer)(fp_srchunvrfdaddrcount > '0') +
    8* (integer)(fp_srchunvrfdssncount > '0')) = NULL, NULL, sum(if((integer)(fp_srchunvrfdphonecount > '0') +
    2* (integer)(fp_srchunvrfddobcount > '0') +
    4* (integer)(fp_srchunvrfdaddrcount > '0') +
    8* (integer)(fp_srchunvrfdssncount > '0') = NULL, 0, (integer)(fp_srchunvrfdphonecount > '0') +
    2* (integer)(fp_srchunvrfddobcount > '0') +
    4* (integer)(fp_srchunvrfdaddrcount > '0') +
    8* (integer)(fp_srchunvrfdssncount > '0')))));

nf_inq_perphone_count12 := if(not(truedid), NULL, min(if(Inq_PerPhone = NULL, -NULL, Inq_PerPhone), 999));

nf_inq_phone_ver_count := if(not(truedid) or inq_phone_ver_count = 255, NULL, inq_phone_ver_count);

iv_f00_email_verification := if(not(truedid), '', trim(email_verification, LEFT));

nf_inq_corrnamephone := map(
    not(truedid)                        => NULL,
    (inq_corrnamephone in [-3, -2, -1]) => NULL,
                                           inq_corrnamephone);

nf_inq_ssn_ver_count := if(not(truedid) or inq_ssn_ver_count = 255, NULL, inq_ssn_ver_count);

_rc_ssnlowissue := common.sas_date((    STRING)(rc_ssnlowissue));

_in_dob_2 := common.sas_date((    STRING)(in_dob));

ssn_years := if(_rc_ssnlowissue = NULL or sysdate = NULL, NULL, if ((sysdate - _rc_ssnlowissue) / 365.25 >= 0, roundup((sysdate - _rc_ssnlowissue) / 365.25), truncate((sysdate - _rc_ssnlowissue) / 365.25)));

calc_dob_2 := if(_in_dob_2 = NULL or sysdate = NULL, NULL, if ((sysdate - _in_dob_2) / 365.25 >= 0, roundup((sysdate - _in_dob_2) / 365.25), truncate((sysdate - _in_dob_2) / 365.25)));

nf_age_at_ssn_issuance := map(
    not(truedid and (ssnlength in ['4', '9'])) or sysdate = NULL or ssn_years = NULL => NULL,
    rc_ssnlowissue = 20110625                                                        => NULL,
    not(calc_dob_2 = NULL)                                                           => calc_dob_2 - ssn_years,
    inferred_age = 0                                                                 => NULL,
                                                                                        inferred_age - ssn_years);

iv_input_best_phone_match := map(
    not(truedid) or (integer)input_phone_isbestmatch = -3 => NULL,
    (integer)input_phone_isbestmatch = 1                  => 1,
    (integer)input_phone_isbestmatch = 0                  => 0,
    (integer)input_phone_isbestmatch = -2                 => -1,
                                                    NULL);

rv_l70_inp_addr_dirty := if(not(add_input_pop and truedid), NULL, (integer)add_input_dirty_address);

nf_inq_perssn_count_week := if(not(truedid), NULL, min(if(inq_perssn_count_week = NULL, -NULL, inq_perssn_count_week), 999));

rv_i62_inq_dobsperadl_recency := map(
    not(truedid)           => NULL,
    (boolean)inq_dobsperadl_count01 => 1,
    (boolean)inq_dobsperadl_count03 => 3,
    (boolean)inq_dobsperadl_count06 => 6,
    (boolean)Inq_DOBsPerADL         => 12,
                              0);

rv_l79_adls_per_addr_curr := if(not(addrpop), NULL, min(if(adls_per_addr_curr = NULL, -NULL, adls_per_addr_curr), 999));

rv_c13_curr_addr_lres := if(not(truedid and add_curr_pop), NULL, min(if(add_curr_lres = NULL, -NULL, add_curr_lres), 999));

nf_bus_seleids_peradl := if(not(truedid), NULL, bus_seleids_peradl);

nf_inq_adlsperphone_count12 := if(not(truedid), NULL, min(if(Inq_ADLsPerPhone = NULL, -NULL, Inq_ADLsPerPhone), 999));

rv_p88_phn_dst_to_inp_add := if(rc_disthphoneaddr = 9999, NULL, rc_disthphoneaddr);

iv_phn_cell := map(
    not(hphnpop)                                                                                                                                                                                                                                            => NULL,
    rc_hriskphoneflag = '1' or trim(trim(rc_hphonetypeflag, LEFT), LEFT, RIGHT) = '1' or trim(trim(telcordia_type, LEFT), LEFT, RIGHT) = '04' or trim(trim(telcordia_type, LEFT), LEFT, RIGHT) = '55' or trim(trim(telcordia_type, LEFT), LEFT, RIGHT) = '60' => 1,
                                                                                                                                                                                                                                                               0);

nf_email_name_addr_ver := if(not(emailpop), NULL, (integer)email_name_addr_verification);

nf_bus_gold_seleids_peradl := if(not(truedid), NULL, bus_gold_seleids_peradl);

_sum_dob_bureau := if(max((integer)ver_dob_src_eq, (integer)ver_dob_src_en, (integer)ver_dob_src_tn) = NULL, NULL, sum((integer)ver_dob_src_eq, (integer)ver_dob_src_en, (integer)ver_dob_src_tn));

_sum_dob_credentialed := if(max((integer)ver_dob_src_ar, (integer)ver_dob_src_am, (integer)ver_dob_src_ba, (integer)ver_dob_src_cg, (integer)ver_dob_src_da, (integer)ver_dob_src_d, (integer)ver_dob_src_dl, (integer)ver_dob_src_eb, (integer)ver_dob_src_e1, (integer)ver_dob_src_e2, (integer)ver_dob_src_e3, (integer)ver_dob_src_fe, (integer)ver_dob_src_ff, (integer)ver_dob_src_p, (integer)ver_dob_src_pl, (integer)ver_dob_src_sl, (integer)ver_dob_src_v, (integer)ver_dob_src_vo, (integer)ver_dob_src_w) = NULL, NULL, sum((integer)ver_dob_src_ar, (integer)ver_dob_src_am, (integer)ver_dob_src_ba, (integer)ver_dob_src_cg, (integer)ver_dob_src_da, (integer)ver_dob_src_d, (integer)ver_dob_src_dl, (integer)ver_dob_src_eb, (integer)ver_dob_src_e1, (integer)ver_dob_src_e2, (integer)ver_dob_src_e3, (integer)ver_dob_src_fe, (integer)ver_dob_src_ff, (integer)ver_dob_src_p, (integer)ver_dob_src_pl, (integer)ver_dob_src_sl, (integer)ver_dob_src_v, (integer)ver_dob_src_vo, (integer)ver_dob_src_w));

_sum_dob_other := if(max((integer)ver_dob_src_ak, (integer)ver_dob_src_cy, (integer)ver_dob_src_e4, (integer)ver_dob_src_em, (integer)ver_dob_src_fr, (integer)ver_dob_src_li, (integer)ver_dob_src_l2, (integer)ver_dob_src_mw, (integer)ver_dob_src_nt, (integer)ver_dob_src_wp) = NULL, NULL, sum((integer)ver_dob_src_ak, (integer)ver_dob_src_cy, (integer)ver_dob_src_e4, (integer)ver_dob_src_em, (integer)ver_dob_src_fr, (integer)ver_dob_src_li, (integer)ver_dob_src_l2, (integer)ver_dob_src_mw, (integer)ver_dob_src_nt, (integer)ver_dob_src_wp));

_num_dob_sources := if(max(_sum_dob_bureau, _sum_dob_credentialed, _sum_dob_other) = NULL, NULL, sum(if(_sum_dob_bureau = NULL, 0, _sum_dob_bureau), if(_sum_dob_credentialed = NULL, 0, _sum_dob_credentialed), if(_sum_dob_other = NULL, 0, _sum_dob_other)));

iv_dob_bureau_only := map(
    not(dobpop)                        => NULL,
    _num_dob_sources > _sum_dob_bureau => -1,
                                          _sum_dob_bureau);

nf_inq_perssn_count_day := if(not(truedid), NULL, min(if(inq_perssn_count_day = NULL, -NULL, inq_perssn_count_day), 999));

nf_fp_srchfraudsrchcountmo := if(not(truedid), NULL, min(if((integer)fp_srchfraudsrchcountmo = NULL, -NULL, (integer)fp_srchfraudsrchcountmo), 999));

iv_c13_avg_lres := if(not(truedid), NULL, min(if(avg_lres = NULL, -NULL, avg_lres), 999));

br_first_seen_char := br_first_seen;

_br_first_seen := common.sas_date((    STRING)(br_first_seen_char));

rv_mos_since_br_first_seen := map(
    not(truedid)          => NULL,
    _br_first_seen = NULL => -1,
                             min(if(if ((sysdate - _br_first_seen) / (365.25 / 12) >= 0, truncate((sysdate - _br_first_seen) / (365.25 / 12)), roundup((sysdate - _br_first_seen) / (365.25 / 12))) = NULL, -NULL, if ((sysdate - _br_first_seen) / (365.25 / 12) >= 0, truncate((sysdate - _br_first_seen) / (365.25 / 12)), roundup((sysdate - _br_first_seen) / (365.25 / 12)))), 999));

rv_c22_inp_addr_occ_index := if(not(add_input_pop and truedid), NULL, add_input_occ_index);

rv_c13_attr_addrs_recency := map(
    not(truedid)      => NULL,
    (boolean)attr_addrs_last30 => 1,
    (boolean)attr_addrs_last90 => 3,
    (boolean)attr_addrs_last12 => 12,
    (boolean)attr_addrs_last24 => 24,
    (boolean)attr_addrs_last36 => 36,
    (boolean)addrs_5yr         => 60,
    (boolean)addrs_10yr        => 120,
    (boolean)addrs_15yr        => 180,
    addrs_per_adl > 0          => 999,
                                  0);

rv_f00_dob_score := map(
    not(truedid and dobpop) => NULL,
    combo_dobscore = 255    => NULL,
                               min(if(combo_dobscore = NULL, -NULL, combo_dobscore), 999));

add_ec1_1 := __common__((STRINGLib.STRINGToUpperCase(trim(out_addr_status, LEFT)))[1..1]);

add_ec3   := __common__((STRINGLib.STRINGToUpperCase(trim(out_addr_status, LEFT)))[3..3]);

add_ec4   := __common__((STRINGLib.STRINGToUpperCase(trim(out_addr_status, LEFT)))[4..4]);

rv_l70_add_standardized := map(
    not(addrpop)                                           => NULL,
    trim(trim(add_ec1_1, LEFT), LEFT, RIGHT) = 'E'         => 2,
    add_ec1_1 = 'S' and (add_ec3 != '0' or add_ec4 != '0') => 1,
                                                              0);

nf_fp_prevaddrageoldest := if(not(truedid), NULL, min(if((integer)fp_prevaddrageoldest = NULL, -NULL, (integer)fp_prevaddrageoldest), 999));

dt_archive_2 := common.sas_date((    STRING)(archive_date));

dt_input_2 := common.sas_date((    STRING)(bus_header_first_seen));

nf_mos_bus_header_fs := map(
    not(truedid)                               => NULL ,
    (bus_header_first_seen in [0, -1, -2, -3]) => bus_header_first_seen,
                                                  if ((dt_archive_2 - dt_input_2) / 30.5 >= 0, roundup((dt_archive_2 - dt_input_2) / 30.5), truncate((dt_archive_2 - dt_input_2) / 30.5)));

nf_fp_varrisktype := if(not(truedid), NULL, (integer)fp_varrisktype);

nf_bus_sos_filings_peradl := if(not(truedid), NULL, bus_SOS_filings_peradl);

_rc_ssnhighissue := common.sas_date((    STRING)(rc_ssnhighissue));

nf_m_snc_ssn_high_issue := map(
    not((integer)ssnlength > 0)      => NULL,
    _rc_ssnhighissue = NULL => -1,
                               min(if(if ((sysdate - _rc_ssnhighissue) / (365.25 / 12) >= 0, truncate((sysdate - _rc_ssnhighissue) / (365.25 / 12)), roundup((sysdate - _rc_ssnhighissue) / (365.25 / 12))) = NULL, -NULL, if ((sysdate - _rc_ssnhighissue) / (365.25 / 12) >= 0, truncate((sysdate - _rc_ssnhighissue) / (365.25 / 12)), roundup((sysdate - _rc_ssnhighissue) / (365.25 / 12)))), 999));

rv_f00_inq_corrphonessn_adl := map(
    not(truedid)                           => NULL,
    (inq_corrphonessn_adl in [-3, -2, -1]) => NULL,
                                              inq_corrphonessn_adl);

_sum_bureau_1 := if(max((integer)ver_src_eq, (integer)ver_src_en, (integer)ver_src_tn) = NULL, NULL, sum((integer)ver_src_eq, (integer)ver_src_en, (integer)ver_src_tn));

_sum_credentialed_1 := if(max((integer)ver_src_ar, (integer)ver_src_am, (integer)ver_src_ba, (integer)ver_src_cg, (integer)ver_src_da, (integer)ver_src_d, (integer)ver_src_dl, (integer)ver_src_eb, (integer)ver_src_e1, (integer)ver_src_e2, (integer)ver_src_e3, (integer)ver_src_fe, (integer)ver_src_ff, (integer)ver_src_p, (integer)ver_src_pl, (integer)ver_src_sl, (integer)ver_src_v, (integer)ver_src_vo, (integer)ver_src_w) = NULL, NULL, sum((integer)ver_src_ar, (integer)ver_src_am, (integer)ver_src_ba, (integer)ver_src_cg, (integer)ver_src_da, (integer)ver_src_d, (integer)ver_src_dl, (integer)ver_src_eb, (integer)ver_src_e1, (integer)ver_src_e2, (integer)ver_src_e3, (integer)ver_src_fe, (integer)ver_src_ff, (integer)ver_src_p, (integer)ver_src_pl, (integer)ver_src_sl, (integer)ver_src_v, (integer)ver_src_vo, (integer)ver_src_w));

_sum_other := if(max((integer)ver_src_ak, (integer)ver_src_cy, (integer)ver_src_e4, (integer)ver_src_em, (integer)ver_src_fr, (integer)ver_src_li, (integer)ver_src_l2, (integer)ver_src_mw, (integer)ver_src_nt, (integer)ver_src_wp) = NULL, NULL, sum((integer)ver_src_ak, (integer)ver_src_cy, (integer)ver_src_e4, (integer)ver_src_em, (integer)ver_src_fr, (integer)ver_src_li, (integer)ver_src_l2, (integer)ver_src_mw, (integer)ver_src_nt, (integer)ver_src_wp));

num_sources := if(max(_sum_bureau_1, _sum_credentialed_1, _sum_other) = NULL, NULL, sum(if(_sum_bureau_1 = NULL, 0, _sum_bureau_1), if(_sum_credentialed_1 = NULL, 0, _sum_credentialed_1), if(_sum_other = NULL, 0, _sum_other)));

_in_dob_1 := common.sas_date((    STRING)(in_dob));

earliest_bureau_date_1 := if(ver_src_fdate_tn = NULL and ver_src_fdate_en = NULL and ver_src_fdate_eq = NULL, NULL, if(max(ver_src_fdate_tn, ver_src_fdate_en, ver_src_fdate_eq) = NULL, NULL, min(if(ver_src_fdate_tn = NULL, -NULL, ver_src_fdate_tn), if(ver_src_fdate_en = NULL, -NULL, ver_src_fdate_en), if(ver_src_fdate_eq = NULL, -NULL, ver_src_fdate_eq))));

earliest_bureau_yrs_1 := if(earliest_bureau_date_1 = NULL or sysdate = NULL, NULL, if ((sysdate - earliest_bureau_date_1) / 365.25 >= 0, roundup((sysdate - earliest_bureau_date_1) / 365.25), truncate((sysdate - earliest_bureau_date_1) / 365.25)));

calc_dob_1 := if(_in_dob_1 = NULL, NULL, if ((sysdate - _in_dob_1) / 365.25 >= 0, roundup((sysdate - _in_dob_1) / 365.25), truncate((sysdate - _in_dob_1) / 365.25)));

iv_bureau_only_emergence_age := map(
    not(truedid) or earliest_bureau_yrs_1 = NULL => NULL,
    num_sources > _sum_bureau_1                  => -9999,
    not(calc_dob_1 = NULL)                       => calc_dob_1 - earliest_bureau_yrs_1,
    inferred_age = 0                             => NULL,
                                                    inferred_age - earliest_bureau_yrs_1);

nf_fp_idverrisktype := if(not(truedid), NULL, (integer)fp_idverrisktype);

nf_adls_per_bestssn := if(best_ssn_valid = '7' or not(truedid) or adls_per_bestssn = 0, NULL, min(if(adls_per_bestssn = NULL, -NULL, adls_per_bestssn), 999));

_in_dob := common.sas_date((    STRING)(in_dob));

earliest_bureau_date := if(ver_src_fdate_tn = NULL and ver_src_fdate_en = NULL and ver_src_fdate_eq = NULL, NULL, if(max(ver_src_fdate_tn, ver_src_fdate_en, ver_src_fdate_eq) = NULL, NULL, min(if(ver_src_fdate_tn = NULL, -NULL, ver_src_fdate_tn), if(ver_src_fdate_en = NULL, -NULL, ver_src_fdate_en), if(ver_src_fdate_eq = NULL, -NULL, ver_src_fdate_eq))));

earliest_bureau_yrs := if(earliest_bureau_date = NULL or sysdate = NULL, NULL, if ((sysdate - earliest_bureau_date) / 365.25 >= 0, roundup((sysdate - earliest_bureau_date) / 365.25), truncate((sysdate - earliest_bureau_date) / 365.25)));

calc_dob := if(_in_dob = NULL, NULL, if ((sysdate - _in_dob) / 365.25 >= 0, roundup((sysdate - _in_dob) / 365.25), truncate((sysdate - _in_dob) / 365.25)));

iv_bureau_emergence_age := map(
    not(truedid) or earliest_bureau_yrs = NULL => NULL,
    not(calc_dob = NULL)                       => calc_dob - earliest_bureau_yrs,
    inferred_age = 0                           => NULL,
                                                  inferred_age - earliest_bureau_yrs);

iv_addr_non_phn_src_ct := if(not(truedid and add_input_pop), NULL, min(if(rc_addrcount = NULL, -NULL, rc_addrcount), 999));

rv_f04_curr_add_occ_index := if(not(truedid and add_curr_pop), NULL, add_curr_occ_index);

nf_fp_srchfraudsrchcountyr := if(not(truedid), NULL, min(if((integer)fp_srchfraudsrchcountyr = NULL, -NULL, (integer)fp_srchfraudsrchcountyr), 999));

nf_inq_highriskcredit_count24 := if(not(truedid), NULL, min(if(inq_highriskcredit_count24 = NULL, -NULL, inq_highriskcredit_count24), 999));

rv_l79_adls_per_sfd_addr := map(
    not(addrpop)     => NULL,
    iv_add_apt = '1' => -1,
                      min(if(adls_per_addr_curr = NULL, -NULL, adls_per_addr_curr), 999));

nf_inq_corrdobphone := map(
    not(truedid)                       => NULL,
    (inq_corrdobphone in [-3, -2, -1]) => NULL,
                                          inq_corrdobphone);

nf_fp_divaddrsuspidcountnew := if(not(truedid), NULL, min(if((integer)fp_divaddrsuspidcountnew = NULL, -NULL, (integer)fp_divaddrsuspidcountnew), 999));

nf_inquiry_adl_vel_risk_index := if(not(truedid), NULL, 
                                 if(max((integer)(inq_lnamesperadl > 2), 
                                    2* (integer)(inq_phonesperadl > 2), 
                                    4* (integer)(inq_addrsperadl > 2), 
                                    8* (integer)(inq_dobsperadl > 2), 
                                    16* (integer)(inq_ssnsperadl > 2)) = NULL, NULL, 
                                    sum(if((integer)(inq_lnamesperadl > 2) = NULL, 0, 
                                          (integer)(inq_lnamesperadl > 2)), 
                                             if(2*(integer)(inq_phonesperadl > 2) = NULL, 0, 
                                                2*(integer)(inq_phonesperadl > 2)), 
                                                   if(4* (integer)(inq_addrsperadl > 2) = NULL, 0, 
                                                      4* (integer)(inq_addrsperadl > 2)), 
                                                         if(8* (integer)(inq_dobsperadl > 2) = NULL, 0, 
                                                            8* (integer)(inq_dobsperadl > 2)), 
                                                                if(16* (integer)(inq_ssnsperadl > 2) = NULL, 0, 
                                                                   16* (integer)(inq_ssnsperadl > 2)))));

rv_i62_inq_phones_per_adl := if(not(truedid), NULL, min(if(inq_phonesperadl = NULL, -NULL, inq_phonesperadl), 999));

iv_prof_license_category := map(
    not(truedid)                 => '',
    prof_license_category = '' => '-1',
                                    trim(prof_license_category, LEFT));

nf_invbest_inq_adlsperphone_diff := map(
    not(truedid) or (integer)hphnpop = 0 => NULL,
    input_phone_isbestmatch = '1'        => -9999,
                                            inq_adlsperphone - inq_adlsperbestphone);

nf_invbest_inq_lastperaddr_diff := map(
    not(truedid) or (integer)addrpop = 0 => NULL,
    add_input_isbestmatch                => -9999,
                                           inq_lnamesperaddr - inq_lnamespercurraddr);

nf_invbest_inq_ssnsperaddr_diff := map(
    not(truedid) or (integer)addrpop = 0 => NULL,
    add_input_isbestmatch       => -9999,
                                   inq_ssnsperaddr - inq_ssnspercurraddr);

nf_inq_per_phone := if(not(hphnpop), NULL, min(if(inq_perphone = NULL, -NULL, inq_perphone), 999));

nf_inq_curraddr_ver_count := if(not(truedid) or inq_curraddr_ver_count = 255, NULL, min(if(inq_curraddr_ver_count = NULL, -NULL, inq_curraddr_ver_count), 999));

rv_f00_inq_corrdobssn_adl := map(
    not(truedid)                         => NULL,
    (inq_corrdobssn_adl in [-3, -2, -1]) => NULL,
                                            inq_corrdobssn_adl);

num_dob_match_level := (integer)input_dob_match_level;

nas_summary_ver := if((integer)ssnlength > 0 and (nas_summary in [8, 9, 10, 11, 12]) or (nas_summary in [2, 4, 7]) and add_input_isbestmatch, 1, 0);

nap_summary_ver := if(hphnpop and (nap_summary in [9, 10, 11, 12]), 1, 0);

infutor_nap_ver := if(hphnpop and (infutor_nap in [9, 10, 11, 12]), 1, 0);

dob_ver := if(dobpop and num_dob_match_level >= 5, 1, 0);

sufficiently_verified := map(
    (boolean)(integer)nas_summary_ver and ((boolean)(integer)nap_summary_ver or (boolean)(integer)infutor_nap_ver)          => 1,
    (boolean)(integer)nas_summary_ver and ((boolean)(integer)dob_ver or not(dobpop))                                        => 1,
    ((boolean)(integer)dob_ver or not(dobpop)) and ((boolean)(integer)nap_summary_ver or (boolean)(integer)infutor_nap_ver) => 1,
                                                                                                                               0);

add_ec1 := __common__((STRINGLib.STRINGToUpperCase(trim(out_addr_status, LEFT)))[1..1]);

addr_validation_problem := if(add_ec1 = 'E' and not(rc_addrvalflag = 'N') or rc_hriskaddrflag = '4' or rc_addrcommflag = '2' or (add_input_advo_res_or_bus in ['B', 'D']) or not(out_z5 = '') and (rc_hriskaddrflag = '2' or rc_ziptypeflag = '2') or add_input_advo_vacancy = 'Y', 1, 0);

phn_validation_problem := if(rc_hphonetypeflag = 'A' or rc_hriskphoneflag = '2' or rc_hphonetypeflag = '2' or (telcordia_type in ['02', '56', '61']) or rc_phonevalflag = '0' or rc_hphonevalflag = '0' or rc_phonetype = '5' or rc_hriskphoneflag = '6' or rc_hphonetypeflag = '5' or rc_hphonevalflag = '3' or rc_addrcommflag = '1', 1, 0);

validation_problem := if(adls_per_ssn >= 5 or ssns_per_adl >= 4 or invalid_ssns_per_adl >= 1 or adls_per_addr_curr >= 8 or ssns_per_addr_curr >= 7 or rc_hrisksic = '2225' or rc_hrisksicphone = '2225' or (boolean)(integer)addr_validation_problem or (boolean)(integer)phn_validation_problem, 1, 0);

tot_liens := if(max(liens_historical_unreleased_ct, liens_recent_unreleased_count, liens_recent_released_count, liens_historical_released_count) = NULL, NULL, sum(if(liens_historical_unreleased_ct = NULL, 0, liens_historical_unreleased_ct), if(liens_recent_unreleased_count = NULL, 0, liens_recent_unreleased_count), if(liens_recent_released_count = NULL, 0, liens_recent_released_count), if(liens_historical_released_count = NULL, 0, liens_historical_released_count)));

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

rv_c13_inp_addr_lres := if(not(add_input_pop and truedid), NULL, min(if(add_input_lres = NULL, -NULL, add_input_lres), 999));

iv_inf_nothing_found := (infutor_nap in [0]);

nf_bus_inact_seleids_peradl := if(not(truedid), NULL, bus_inactive_seleids_peradl);

dt_archive_1 := common.sas_date((    STRING)(archive_date));

dt_input_1 := common.sas_date((    STRING)(bus_header_last_seen));

nf_mos_bus_header_ls := map(
    not(truedid)                              => NULL,
    (bus_header_last_seen in [0, -1, -2, -3]) => bus_header_last_seen,
                                                 if ((dt_archive_1 - dt_input_1) / 30.5 >= 0, roundup((dt_archive_1 - dt_input_1) / 30.5), truncate((dt_archive_1 - dt_input_1) / 30.5)));

nf_phones_per_addr_curr := if(not(addrpop), NULL, min(if(phones_per_addr_curr = NULL, -NULL, phones_per_addr_curr), 999));

_nap_ver := (nap_summary in [6, 10, 11, 12]);

_inf_ver := (infutor_nap in [6, 10, 11, 12]);

iv_phn_addr_verified := map(
    not(_nap_ver) and not(_inf_ver) => 0,
    not(_nap_ver) and _inf_ver      => 1,
    _nap_ver and not(_inf_ver)      => 2,
                                       3);

nf_inq_fname_ver_count := if(not(truedid) or inq_fname_ver_count = 255, NULL, inq_fname_ver_count);

nf_adls_per_bestphone_c6 := if(best_phone_phoneval = '6' or not(truedid), NULL, min(if(adls_per_bestphone_c6 = NULL, -NULL, adls_per_bestphone_c6), 999));

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

iv_bureau_verification_index := if(not(truedid), NULL, if(max((integer)(max(num_bureau_fname, num_bureau_lname) > 0), 
                                                          2* (integer)(num_bureau_addr > 0), 
                                                          4* (integer)(num_bureau_dob > 0), 
                                                          8* (integer)(num_bureau_ssn > 0)) = NULL, NULL, 
                                                              sum(if((integer)(max(num_bureau_fname, num_bureau_lname) > 0) = NULL, 0, 
                                                                     (integer)(max(num_bureau_fname, num_bureau_lname) > 0)), 
                                                                         if(2* (integer)(num_bureau_addr > 0) = NULL, 0, 
                                                                            2* (integer)(num_bureau_addr > 0)), 
                                                                               if(4* (integer)(num_bureau_dob > 0) = NULL, 0, 
                                                                                  4* (integer)(num_bureau_dob > 0)), 
                                                                                     if(8* (integer)(num_bureau_ssn > 0) = NULL, 0, 
                                                                                        8* (integer)(num_bureau_ssn > 0)))));

nf_inq_corrnamephonessn := map(
    not(truedid)                           => NULL,
    (inq_corrnamephonessn in [-3, -2, -1]) => NULL,
                                              inq_corrnamephonessn);

nf_dist_inp_curr_hi_velocity := map(
    not(add_curr_pop and add_input_pop)       => NULL,
    inq_peraddr <= 5 or add_input_isbestmatch => -1,
                                                 min(9999, if(add_dist_input_to_curr = NULL, -NULL, add_dist_input_to_curr)));

rv_i60_inq_other_recency := map(
    not(truedid)      => NULL,
    (boolean)inq_other_count01 => 1,
    (boolean)inq_other_count03 => 3,
    (boolean)inq_other_count06 => 6,
    (boolean)inq_other_count12 => 12,
    (boolean)inq_other_count24 => 24,
    (boolean)inq_other_count   => 99,
                                  0);

rv_f00_inq_corrdobphone_adl := map(
    not(truedid)                           => NULL,
    (inq_corrdobphone_adl in [-3, -2, -1]) => NULL,
                                              inq_corrdobphone_adl);

rv_a41_a42_prop_owner_history := map(
    not(truedid)                                                                     => NULL,
    add_input_naprop = 4 or add_curr_naprop = 4 or property_owned_total > 0          => 2,
    add_prev_naprop = 4 or Models.Common.findw_cpp(ver_sources, 'P' , ', ', 'E') > 0 => 1,
                                                                                        0);

all_tree_0 := -2.2559425659;

all_tree_1_c314 := map(
    (nf_corroboration_risk_index in [3, 5, 20, 25, 27, 28, 29, 31])                                       => 0.0470868147,
    (nf_corroboration_risk_index in [0, 1, 8, 9, 10, 11, 12, 13, 14, 16, 17, 18, 19, 21, 22, 23, 24, 30]) => 0.5096636575,
    nf_corroboration_risk_index = NULL                                                                    => 0.0753383194,                                                                                                                                       
                                                                                                             0.0753383194);

all_tree_1_c313 := map(
    (nf_inq_perphone_recency in [0, 3, 6, 12]) => all_tree_1_c314,
    (nf_inq_perphone_recency in [1])           => 0.5951069160,
    nf_inq_perphone_recency = NULL             => 0.1118818363,
                                                  0.1118818363);

all_tree_1 := map(
    NULL < nf_phone_ver_experian AND nf_phone_ver_experian < 0.5 => all_tree_1_c313,
    nf_phone_ver_experian >= 0.5                                 => -0.0433810887,
    nf_phone_ver_experian = NULL                                 => -0.0028406276,
                                                                    -0.0028406276);

all_tree_2_c317 := map(
    NULL < nf_corrssnaddr AND nf_corrssnaddr < 1.5 => 0.3779016660,
    nf_corrssnaddr >= 1.5                          => 0.0556948936,
    nf_corrssnaddr = NULL                          => 0.0800243610,
                                                      0.0800243610);

all_tree_2_c316 := map(
    (nf_inq_perphone_recency in [0, 3, 6, 12]) => all_tree_2_c317,
    (nf_inq_perphone_recency in [1])           => 0.4003132678,
    nf_inq_perphone_recency = NULL             => 0.1041897939,
                                                  0.1041897939);

all_tree_2 := map(
    NULL < iv_nap_inf_phone_ver_lvl AND iv_nap_inf_phone_ver_lvl < 0.5 => all_tree_2_c316,
    iv_nap_inf_phone_ver_lvl >= 0.5                                    => -0.0351537384,
    iv_nap_inf_phone_ver_lvl = NULL                                    => -0.0050108037,
                                                                          -0.0050108037);

all_tree_3_c320 := map(
    NULL < iv_input_best_match_index AND iv_input_best_match_index < 12.5 => 0.2159985993,
    iv_input_best_match_index >= 12.5                                     => 0.0144232565,
    iv_input_best_match_index = NULL                                      => 0.0424805204,
                                                                             0.0424805204);

all_tree_3_c319 := map(
    NULL < nf_invbest_inq_perphone_diff AND nf_invbest_inq_perphone_diff < 1.5 => all_tree_3_c320,
    nf_invbest_inq_perphone_diff >= 1.5                                        => 0.2788141406,
    nf_invbest_inq_perphone_diff = NULL                                        => 0.0703474334,
                                                                                  0.0703474334);

all_tree_3 := map(
    NULL < nf_phone_ver_experian AND nf_phone_ver_experian < 0.5 => all_tree_3_c319,
    nf_phone_ver_experian >= 0.5                                 => -0.0373277776,
    nf_phone_ver_experian = NULL                                 => -0.0088901412,
                                                                    -0.0088901412);

all_tree_4_c323 := map(
    NULL < iv_nap_inf_phone_ver_lvl AND iv_nap_inf_phone_ver_lvl < 0.5 => 0.0687432586,
    iv_nap_inf_phone_ver_lvl >= 0.5                                    => -0.0380301990,
    iv_nap_inf_phone_ver_lvl = NULL                                    => -0.0159215773,
                                                                          -0.0159215773);

all_tree_4_c322 := map(
    NULL < nf_invbest_inq_perphone_diff AND nf_invbest_inq_perphone_diff < 7.5 => all_tree_4_c323,
    nf_invbest_inq_perphone_diff >= 7.5                                        => 0.3090700891,
    nf_invbest_inq_perphone_diff = NULL                                        => -0.0122546961,
                                                                                  0.5015055637);

all_tree_4 := map(
    NULL < rv_f00_ssn_score AND rv_f00_ssn_score < 95 => 0.5015055637,
    rv_f00_ssn_score >= 95                            => all_tree_4_c322,
    rv_f00_ssn_score = NULL                           => -0.0085131252,
                                                         -0.0085131252);

all_tree_5_c325 := map(
    NULL < nf_invbest_inq_perphone_diff AND nf_invbest_inq_perphone_diff < 9.5 => -0.0177135213,
    nf_invbest_inq_perphone_diff >= 9.5                                        => 0.2793383131,
    nf_invbest_inq_perphone_diff = NULL                                        => -0.0158968994,
                                                                                  -0.0158968994);

all_tree_5_c326 := map(
    NULL < rv_f00_ssn_score AND rv_f00_ssn_score < 95 => 0.3996707472,
    rv_f00_ssn_score >= 95                            => 0.1384904486,
    rv_f00_ssn_score = NULL                           => 0.1631872476,
                                                         -0.0158968994);

all_tree_5 := map(
    ((string)nf_corroboration_risk_index in ['3', '5', '10', '18', '19', '22', '25', '27', '29', '31'])                                   => all_tree_5_c325,
    ((string)nf_corroboration_risk_index in ['0', '1', '8', '9', '11', '12', '13', '14', '16', '17', '20', '21', '23', '24', '28', '30']) => all_tree_5_c326,
    nf_corroboration_risk_index = NULL                                                                                                    => -0.0071437566,
                                                                                                                                         -0.0071437566);

all_tree_6_c329 := map(
    NULL < nf_phone_ver_experian AND nf_phone_ver_experian < 0.5 => 0.0968129565,
    nf_phone_ver_experian >= 0.5                                 => -0.0112755931,
    nf_phone_ver_experian = NULL                                 => 0.0401917480,
                                                                    0.0401917480);

all_tree_6_c328 := map(
    NULL < nf_add_dist_input_to_curr AND nf_add_dist_input_to_curr < 0.5 => all_tree_6_c329,
    nf_add_dist_input_to_curr >= 0.5                                     => 0.2242852960,
    nf_add_dist_input_to_curr = NULL                                     => 0.0575253207,
                                                                            0.0575253207);

all_tree_6 := map(
    NULL < nf_phone_ver_insurance AND nf_phone_ver_insurance < 3.5 => all_tree_6_c328,
    nf_phone_ver_insurance >= 3.5                                  => -0.0357907757,
    nf_phone_ver_insurance = NULL                                  => -0.0084971096,
                                                                      -0.0084971096);

all_tree_7_c331 := map(
    NULL < rv_f00_ssn_score AND rv_f00_ssn_score < 95 => 0.2937596923,
    rv_f00_ssn_score >= 95                            => 0.0991263045,
    rv_f00_ssn_score = NULL                           => 0.1111480706,
                                                         0.1111480706);

all_tree_7_c332 := map(
    NULL < iv_nap_inf_phone_ver_lvl AND iv_nap_inf_phone_ver_lvl < 0.5 => 0.0430416182,
    iv_nap_inf_phone_ver_lvl >= 0.5                                    => -0.0389804745,
    iv_nap_inf_phone_ver_lvl = NULL                                    => -0.0223002725,
                                                                          0.1111480706);

all_tree_7 := map(
    NULL < nf_corrssnaddr AND nf_corrssnaddr < 2.5 => all_tree_7_c331,
    nf_corrssnaddr >= 2.5                          => all_tree_7_c332,
    nf_corrssnaddr = NULL                          => -0.0108828246,
                                                      -0.0108828246);

all_tree_8_c335 := map(
    NULL < nf_phone_ver_experian AND nf_phone_ver_experian < 0.5 => 0.0430865882,
    nf_phone_ver_experian >= 0.5                                 => -0.0364088846,
    nf_phone_ver_experian = NULL                                 => -0.0161558253,
                                                                    0.2167448910);

all_tree_8_c334 := map(
    NULL < rv_f00_ssn_score AND rv_f00_ssn_score < 95 => 0.2167448910,
    rv_f00_ssn_score >= 95                            => all_tree_8_c335,
    rv_f00_ssn_score = NULL                           => -0.0145985473,
                                                         -0.0145985473);

all_tree_8 := map(
    NULL < nf_invbest_inq_perphone_diff AND nf_invbest_inq_perphone_diff < 7.5 => all_tree_8_c334,
    nf_invbest_inq_perphone_diff >= 7.5                                        => 0.2036875307,
    nf_invbest_inq_perphone_diff = NULL                                        => 0.1933042763,
                                                                                  -0.0111520480);

all_tree_9_c337 := map(
    NULL < rv_f00_ssn_score AND rv_f00_ssn_score < 95 => 0.2233060942,
    rv_f00_ssn_score >= 95                            => 0.0768928173,
    rv_f00_ssn_score = NULL                           => 0.0867419032,
                                                         0.0867419032);

all_tree_9_c338 := map(
    NULL < nf_inq_perssn_count_week AND nf_inq_perssn_count_week < 1.5 => -0.0199632827,
    nf_inq_perssn_count_week >= 1.5                                    => 0.2129006112,
    nf_inq_perssn_count_week = NULL                                    => -0.0177243139,
                                                                          0.0867419032);

all_tree_9 := map(
    NULL < nf_corrssnaddr AND nf_corrssnaddr < 2.5 => all_tree_9_c337,
    nf_corrssnaddr >= 2.5                          => all_tree_9_c338,
    nf_corrssnaddr = NULL                          => -0.0086359309,
                                                      -0.0086359309);

all_tree_10_c341 := map(
    NULL < iv_nap_inf_phone_ver_lvl AND iv_nap_inf_phone_ver_lvl < 0.5 => 0.0841003564,
    iv_nap_inf_phone_ver_lvl >= 0.5                                    => -0.0153346755,
    iv_nap_inf_phone_ver_lvl = NULL                                    => 0.0250963187,
                                                                          0.0250963187);

all_tree_10_c340 := map(
    ((string)nf_inq_perphone_recency in ['0', '3', '6', '12']) => all_tree_10_c341,
    ((string)nf_inq_perphone_recency in ['1'])                 => 0.1558646680,
    nf_inq_perphone_recency = NULL                             => 0.0345421438,
                                                                  0.0345421438);

all_tree_10 := map(
    NULL < nf_phone_ver_experian AND nf_phone_ver_experian < 0.5 => all_tree_10_c340,
    nf_phone_ver_experian >= 0.5                                 => -0.0279010646,
    nf_phone_ver_experian = NULL                                 => -0.0114652018,
                                                                    -0.0114652018);

all_tree_11_c343 := map(
    NULL < rv_l79_adls_per_addr_curr AND rv_l79_adls_per_addr_curr < 1.5 => 0.0236344646,
    rv_l79_adls_per_addr_curr >= 1.5                                     => 0.1845559830,
    rv_l79_adls_per_addr_curr = NULL                                     => 0.0869478489,
                                                                            0.0869478489);

all_tree_11_c344 := map(
    NULL < nf_inq_corrnamephone AND nf_inq_corrnamephone < 0.5 => 0.1074626043,
    nf_inq_corrnamephone >= 0.5                                => -0.0203181802,
    nf_inq_corrnamephone = NULL                                => -0.0178636193,
                                                                  0.0869478489);

all_tree_11 := map(
    NULL < nf_corrssnaddr AND nf_corrssnaddr < 1.5 => all_tree_11_c343,
    nf_corrssnaddr >= 1.5                          => all_tree_11_c344,
    nf_corrssnaddr = NULL                          => -0.0076027634,
                                                      -0.0076027634);

all_tree_12_c347 := map(
    NULL < nf_phone_ver_insurance AND nf_phone_ver_insurance < 3.5 => 0.0340791017,
    nf_phone_ver_insurance >= 3.5                                  => -0.0359413186,
    nf_phone_ver_insurance = NULL                                  => -0.0157926881,
                                                                      -0.0157926881);

all_tree_12_c346 := map(
    NULL < nf_fp_idrisktype AND nf_fp_idrisktype < 5.5 => all_tree_12_c347,
    nf_fp_idrisktype >= 5.5                            => 0.2941848880,
    nf_fp_idrisktype = NULL                            => -0.0141455645,
                                                          -0.0141455645);

all_tree_12 := map(
    NULL < nf_fp_srchcomponentrisktype AND nf_fp_srchcomponentrisktype < 2.5 => all_tree_12_c346,
    nf_fp_srchcomponentrisktype >= 2.5                                       => 0.1651384505,
    nf_fp_srchcomponentrisktype = NULL                                       => -0.0099472601,
                                                                                -0.0099472601);

all_tree_13_c350 := map(
    NULL < nf_inq_phone_ver_count AND nf_inq_phone_ver_count < 0.5 => 0.0446768072,
    nf_inq_phone_ver_count >= 0.5                                  => -0.0320411383,
    nf_inq_phone_ver_count = NULL                                  => -0.0014244544,
                                                                      0.1494150066);

all_tree_13_c349 := map(
    NULL < rv_f00_ssn_score AND rv_f00_ssn_score < 95 => 0.1494150066,
    rv_f00_ssn_score >= 95                            => all_tree_13_c350,
    rv_f00_ssn_score = NULL                           => -0.0100381618,
                                                         -0.0100381618);

all_tree_13 := map(
    NULL < nf_inq_perphone_count12 AND nf_inq_perphone_count12 < 7.5 => all_tree_13_c349,
    nf_inq_perphone_count12 >= 7.5                                   => 0.1372162410,
    nf_inq_perphone_count12 = NULL                                   => -0.0083685379,
                                                                        -0.0083685379);

all_tree_14_c353 := map(
    NULL < nf_add_dist_input_to_curr AND nf_add_dist_input_to_curr < 0.5 => 0.0214298744,
    nf_add_dist_input_to_curr >= 0.5                                     => 0.1307273897,
    nf_add_dist_input_to_curr = NULL                                     => 0.0325947739,
                                                                            0.0325947739);

all_tree_14_c352 := map(
    NULL < nf_phone_ver_experian AND nf_phone_ver_experian < 0.5 => all_tree_14_c353,
    nf_phone_ver_experian >= 0.5                                 => -0.0264504110,
    nf_phone_ver_experian = NULL                                 => -0.0111393338,
                                                                    -0.0111393338);

all_tree_14 := map(
    NULL < nf_fp_validationrisktype AND nf_fp_validationrisktype < 2.5 => all_tree_14_c352,
    nf_fp_validationrisktype >= 2.5                                    => 0.2602798812,
    nf_fp_validationrisktype = NULL                                    => -0.0098256141,
                                                                          -0.0098256141);

all_tree_15_c356 := map(
    ((string)nf_corroboration_risk_index in ['1', '3', '5', '9', '11', '16', '18', '19', '22', '24', '25', '27', '29', '31']) => -0.0176412564,
    ((string)nf_corroboration_risk_index in ['0', '8', '10', '12', '13', '14', '17', '20', '21', '23', '28', '30'])           => 0.1754977759,
      nf_corroboration_risk_index = NULL                                                                                => -0.0166331954,
                                                                                                                         -0.0166331954);

all_tree_15_c355 := map(
    NULL < nf_inq_ssn_lexid_diff01 AND nf_inq_ssn_lexid_diff01 < 0.5 => all_tree_15_c356,
    nf_inq_ssn_lexid_diff01 >= 0.5                                   => 0.0949985841,
    nf_inq_ssn_lexid_diff01 = NULL                                   => -0.0105579965,
                                                                        -0.0105579965);

all_tree_15 := map(
    NULL < nf_fp_validationrisktype AND nf_fp_validationrisktype < 1.5 => all_tree_15_c355,
    nf_fp_validationrisktype >= 1.5                                    => 0.1418562744,
    nf_fp_validationrisktype = NULL                                    => -0.0076466380,
                                                                          -0.0076466380);

all_tree_16_c358 := map(
    NULL < nf_phone_ver_insurance AND nf_phone_ver_insurance < 3.5 => 0.0274044609,
    nf_phone_ver_insurance >= 3.5                                  => -0.0291612302,
    nf_phone_ver_insurance = NULL                                  => -0.0128884462,
                                                                      -0.0128884462);

all_tree_16_c359 := map(
    NULL < iv_nap_inf_phone_ver_lvl AND iv_nap_inf_phone_ver_lvl < 0.5 => 0.1467654476,
    iv_nap_inf_phone_ver_lvl >= 0.5                                    => 0.0558099228,
    iv_nap_inf_phone_ver_lvl = NULL                                    => 0.0846731427,
                                                                          -0.0128884462);

all_tree_16 := map(
    NULL < nf_fp_srchcomponentrisktype AND nf_fp_srchcomponentrisktype < 1.5 => all_tree_16_c358,
    nf_fp_srchcomponentrisktype >= 1.5                                       => all_tree_16_c359,
    nf_fp_srchcomponentrisktype = NULL                                       => -0.0081026789,
                                                                                -0.0081026789);

all_tree_17_c361 := map(
    (nf_inquiry_verification_index in ['19', '23', '27', '31'])                                                 => 0.0154782212,
    (nf_inquiry_verification_index in ['0', '1', '3', '5', '7', '9', '11', '13', '15', '17', '21', '25', '29']) => 0.0961257046,
     nf_inquiry_verification_index = ''                                                                       => 0.0471816497,
                                                                                                                   0.0471816497);

all_tree_17_c362 := map(
    NULL < nf_age_at_ssn_issuance AND nf_age_at_ssn_issuance < 18.5 => -0.0252620691,
    nf_age_at_ssn_issuance >= 18.5                                  => 0.0433482826,
    nf_age_at_ssn_issuance = NULL                                   => 0.0673954439,
                                                                       0.0471816497);

all_tree_17 := map(
    NULL < iv_input_best_match_index AND iv_input_best_match_index < 10 => all_tree_17_c361,
    iv_input_best_match_index >= 10                                     => all_tree_17_c362,
    iv_input_best_match_index = NULL                                    => -0.0071963989,
                                                                           -0.0071963989);

all_tree_18_c365 := map(
    NULL < nf_phone_ver_experian AND nf_phone_ver_experian < 0.5 => 0.1303720810,
    nf_phone_ver_experian >= 0.5                                 => 0.0141613506,
    nf_phone_ver_experian = NULL                                 => 0.0652539993,
                                                                    0.0652539993);

all_tree_18_c364 := map(
    NULL < nf_inq_corrnamephone AND nf_inq_corrnamephone < 0.5 => all_tree_18_c365,
    nf_inq_corrnamephone >= 0.5                                => -0.0082271290,
    nf_inq_corrnamephone = NULL                                => -0.0089154274,
                                                                  -0.0053912974);

all_tree_18 := map(
    NULL < nf_fp_idrisktype AND nf_fp_idrisktype < 5.5 => all_tree_18_c364,
    nf_fp_idrisktype >= 5.5                            => 0.1850873259,
    nf_fp_idrisktype = NULL                            => -0.0043281454,
                                                          -0.0043281454);

all_tree_19_c367 := map(
    NULL < nf_age_at_ssn_issuance AND nf_age_at_ssn_issuance < 18.5 => -0.0196945585,
    nf_age_at_ssn_issuance >= 18.5                                  => 0.0424554224,
    nf_age_at_ssn_issuance = NULL                                   => 0.0690923296,
                                                                       -0.0096977509);

all_tree_19_c368 := map(
    NULL < nf_phone_ver_experian AND nf_phone_ver_experian < 0.5 => 0.1256533267,
    nf_phone_ver_experian >= 0.5                                 => 0.0434903703,
    nf_phone_ver_experian = NULL                                 => 0.0694155750,
                                                                    -0.0096977509);

all_tree_19 := map(
    NULL < nf_inq_ssn_lexid_diff01 AND nf_inq_ssn_lexid_diff01 < 0.5 => all_tree_19_c367,
    nf_inq_ssn_lexid_diff01 >= 0.5                                   => all_tree_19_c368,
    nf_inq_ssn_lexid_diff01 = NULL                                   => -0.0054344063,
                                                                        -0.0054344063);

all_tree_20_c371 := map(
    NULL < iv_nap_inf_phone_ver_lvl AND iv_nap_inf_phone_ver_lvl < 0.5 => 0.0594708885,
    iv_nap_inf_phone_ver_lvl >= 0.5                                    => -0.0103244680,
    iv_nap_inf_phone_ver_lvl = NULL                                    => 0.0131106972,
                                                                          0.0131106972);

all_tree_20_c370 := map(
    NULL < nf_invbest_inq_perphone_diff AND nf_invbest_inq_perphone_diff < 1.5 => all_tree_20_c371,
    nf_invbest_inq_perphone_diff >= 1.5                                        => 0.1235602119,
    nf_invbest_inq_perphone_diff = NULL                                        => 0.0207480005,
                                                                                  -0.0219934136);

all_tree_20 := map(
    (nf_inquiry_verification_index in ['7', '19', '21', '23', '27', '31'])                           => -0.0219934136,
    (nf_inquiry_verification_index in ['0', '1', '3', '5', '9', '11', '13', '15', '17', '25', '29']) => all_tree_20_c370,
    nf_inquiry_verification_index = ''                                                             => -0.0084191192,
                                                                                                        -0.0084191192);

all_tree_21_c374 := map(
    NULL < rv_l70_inp_addr_dirty AND rv_l70_inp_addr_dirty < 0.5 => 0.0798175027,
    rv_l70_inp_addr_dirty >= 0.5                                 => -0.0644916696,
    rv_l70_inp_addr_dirty = NULL                                 => 0.0486295348,
                                                                    0.0486295348);

all_tree_21_c373 := map(
    NULL < nf_corrssnaddr AND nf_corrssnaddr < 2.5 => all_tree_21_c374,
    nf_corrssnaddr >= 2.5                          => -0.0104693272,
    nf_corrssnaddr = NULL                          => -0.0054126708,
                                                      -0.0054126708);

all_tree_21 := map(
    NULL < nf_inq_adlsperphone_count12 AND nf_inq_adlsperphone_count12 < 2.5 => all_tree_21_c373,
    nf_inq_adlsperphone_count12 >= 2.5                                       => 0.1635237834,
    nf_inq_adlsperphone_count12 = NULL                                       => -0.0046760828,
                                                                                -0.0046760828);

all_tree_22_c377 := map(
    NULL < iv_header_emergence_age AND iv_header_emergence_age < 21.5 => -0.0313430923,
    iv_header_emergence_age >= 21.5                                   => 0.0150462554,
    iv_header_emergence_age = NULL                                    => -0.0093128414,
                                                                         -0.0093128414);

all_tree_22_c376 := map(
    ((string)nf_corroboration_risk_index in ['1', '3', '5', '10', '16', '18', '19', '22', '25', '27', '29', '31'])             => all_tree_22_c377,
    ((string)nf_corroboration_risk_index in ['0', '8', '9', '11', '12', '13', '14', '17', '20', '21', '23', '24', '28', '30']) => 0.1054377318,
    nf_corroboration_risk_index = NULL                                                                                         => -0.0077395071,
                                                                                                                                  -0.0077395071);

all_tree_22 := map(
    NULL < nf_inq_perphone_count12 AND nf_inq_perphone_count12 < 4.5 => all_tree_22_c376,
    nf_inq_perphone_count12 >= 4.5                                   => 0.0947191610,
    nf_inq_perphone_count12 = NULL                                   => -0.0049961955,
                                                                        -0.0049961955);

all_tree_23_c379 := map(
    NULL < rv_f00_inq_corrphonessn_adl AND rv_f00_inq_corrphonessn_adl < 0.5 => 0.0647522042,
    rv_f00_inq_corrphonessn_adl >= 0.5                                       => -0.0053475375,
    rv_f00_inq_corrphonessn_adl = NULL                                       => -0.0205719595,
                                                                                -0.0109944387);

all_tree_23_c380 := map(
    NULL < nf_invbest_inq_perphone_diff AND nf_invbest_inq_perphone_diff < 0.5 => 0.0320249763,
    nf_invbest_inq_perphone_diff >= 0.5                                        => 0.1378809630,
    nf_invbest_inq_perphone_diff = NULL                                        => 0.0498163395,
                                                                                  -0.0109944387);

all_tree_23 := map(
    (nf_inquiry_verification_index in ['1', '7', '19', '21', '23', '27', '29', '31'])     => all_tree_23_c379,
    (nf_inquiry_verification_index in ['0', '3', '5', '9', '11', '13', '15', '17', '25']) => all_tree_23_c380,
    nf_inquiry_verification_index = ''                                                    => -0.0055927487,
                                                                                             -0.0055927487);

all_tree_24_c383 := map(
    ((string)nf_corroboration_risk_index in ['0', '1', '3', '5', '9', '17', '18', '19', '22', '24', '25', '27', '28', '29', '31']) => -0.0106883585,
    ((string)nf_corroboration_risk_index in ['8', '10', '11', '12', '13', '14', '16', '20', '21', '23', '30'])                     => 0.1324278921,
             nf_corroboration_risk_index = NULL                                                                                     => -0.0092833738,
                                                                                                                              -0.0092833738);

all_tree_24_c382 := map(
    NULL < nf_inq_ssn_lexid_diff01 AND nf_inq_ssn_lexid_diff01 < 0.5 => all_tree_24_c383,
    nf_inq_ssn_lexid_diff01 >= 0.5                                   => 0.0706049369,
    nf_inq_ssn_lexid_diff01 = NULL                                   => -0.0050015172,
                                                                        -0.0050015172);

all_tree_24 := map(
    NULL < nf_fp_idrisktype AND nf_fp_idrisktype < 5.5 => all_tree_24_c382,
    nf_fp_idrisktype >= 5.5                            => 0.1638712874,
    nf_fp_idrisktype = NULL                            => -0.0041767056,
                                                          -0.0041767056);

all_tree_25_c386 := map(
    NULL < nf_inq_phone_ver_count AND nf_inq_phone_ver_count < 0.5 => 0.0727411513,
    nf_inq_phone_ver_count >= 0.5                                  => 0.0000493969,
    nf_inq_phone_ver_count = NULL                                  => 0.0495936948,
                                                                      -0.0406585824);

all_tree_25_c385 := map(
    (iv_f00_email_verification in ['4', '5'])               => -0.0406585824,
    (iv_f00_email_verification in ['', '0', '1', '2', '3']) => all_tree_25_c386,
     iv_f00_email_verification = ''                         => 0.0209057471,
                                                               0.0209057471);

all_tree_25 := map(
    NULL < nf_phone_ver_insurance AND nf_phone_ver_insurance < 3.5 => all_tree_25_c385,
    nf_phone_ver_insurance >= 3.5                                  => -0.0176128112,
    nf_phone_ver_insurance = NULL                                  => -0.0064009074,
                                                                      -0.0064009074);

all_tree_26_c389 := map(
    (iv_f00_email_verification in ['2', '4', '5'])     => -0.0316235535,
    (iv_f00_email_verification in ['', '0', '1', '3']) => 0.0161825697,
    iv_f00_email_verification = ''                     => -0.0078674838,
                                                          -0.0078674838);

all_tree_26_c388 := map(
    NULL < iv_bureau_only_emergence_age AND iv_bureau_only_emergence_age < 22.5 => all_tree_26_c389,
    iv_bureau_only_emergence_age >= 22.5                                        => 0.1063961470,
    iv_bureau_only_emergence_age = NULL                                         => -0.0056373272,
                                                                                   -0.0056373272);

all_tree_26 := map(
    NULL < nf_fp_srchcomponentrisktype AND nf_fp_srchcomponentrisktype < 2.5 => all_tree_26_c388,
    nf_fp_srchcomponentrisktype >= 2.5                                       => 0.0892228803,
    nf_fp_srchcomponentrisktype = NULL                                       => -0.0033953949,
                                                                                -0.0033953949);

all_tree_27_c392 := map(
    NULL < rv_c13_curr_addr_lres AND rv_c13_curr_addr_lres < 271.5 => 0.0530697447,
    rv_c13_curr_addr_lres >= 271.5                                 => 0.1863749537,
    rv_c13_curr_addr_lres = NULL                                   => 0.0622507106,
                                                                      0.0622507106);

all_tree_27_c391 := map(
    NULL < rv_l70_inp_addr_dirty AND rv_l70_inp_addr_dirty < 0.5 => all_tree_27_c392,
    rv_l70_inp_addr_dirty >= 0.5                                 => -0.0660586076,
    rv_l70_inp_addr_dirty = NULL                                 => 0.0442134583,
                                                                    0.0442134583);

all_tree_27 := map(
    NULL < iv_input_best_match_index AND iv_input_best_match_index < 10 => all_tree_27_c391,
    iv_input_best_match_index >= 10                                     => -0.0098249153,
    iv_input_best_match_index = NULL                                    => -0.0036936700,
                                                                           -0.0036936700);

all_tree_28_c395 := map(
    NULL < rv_l70_inp_addr_dirty AND rv_l70_inp_addr_dirty < 0.5 => 0.0598194218,
    rv_l70_inp_addr_dirty >= 0.5                                 => -0.0608289340,
    rv_l70_inp_addr_dirty = NULL                                 => 0.0433167787,
                                                                    0.0433167787);

all_tree_28_c394 := map(
    NULL < iv_addr_non_phn_src_ct AND iv_addr_non_phn_src_ct < 3.5 => all_tree_28_c395,
    iv_addr_non_phn_src_ct >= 3.5                                  => -0.0112503586,
    iv_addr_non_phn_src_ct = NULL                                  => -0.0052422377,
                                                                      -0.0052422377);

all_tree_28 := map(
    NULL < nf_inq_perssn_count_week AND nf_inq_perssn_count_week < 1.5 => all_tree_28_c394,
    nf_inq_perssn_count_week >= 1.5                                    => 0.1162786458,
    nf_inq_perssn_count_week = NULL                                    => -0.0038857058,
                                                                          -0.0038857058);

all_tree_29_c397 := map(
    NULL < nf_inq_corrdobphone AND nf_inq_corrdobphone < 0.5 => 0.0686973914,
    nf_inq_corrdobphone >= 0.5                               => -0.0102545705,
    nf_inq_corrdobphone = NULL                               => -0.0099011571,
                                                                -0.0067951084);

all_tree_29_c398 := map(
    NULL < nf_fp_srchfraudsrchcountmo AND nf_fp_srchfraudsrchcountmo < 0.5 => 0.0611022225,
    nf_fp_srchfraudsrchcountmo >= 0.5                                      => 0.1810429842,
    nf_fp_srchfraudsrchcountmo = NULL                                      => 0.0848299485,
                                                                              -0.0067951084);

all_tree_29 := map(
    ((string)nf_unvrfd_search_risk_index in ['0', '1', '8', '9', '11', '13', '14'])           => all_tree_29_c397,
    ((string)nf_unvrfd_search_risk_index in ['2', '3', '4', '5', '6', '7', '10', '12', '15']) => all_tree_29_c398,
             nf_unvrfd_search_risk_index = NULL                                                => -0.0034828298,
                                                                                         -0.0034828298);

all_tree_30_c401 := map(
    NULL < nf_bus_sos_filings_peradl AND nf_bus_sos_filings_peradl < -0.5 => 0.0057365455,
    nf_bus_sos_filings_peradl >= -0.5                                     => 0.0916921863,
    nf_bus_sos_filings_peradl = NULL                                      => 0.0189462073,
                                                                             0.1978382943);

all_tree_30_c400 := map(
    NULL < rv_f00_dob_score AND rv_f00_dob_score < 92 => 0.1978382943,
    rv_f00_dob_score >= 92                            => all_tree_30_c401,
    rv_f00_dob_score = NULL                           => 0.0271201939,
                                                         0.0223870745);

all_tree_30 := map(
    NULL < nf_phone_ver_insurance AND nf_phone_ver_insurance < 3.5 => all_tree_30_c400,
    nf_phone_ver_insurance >= 3.5                                  => -0.0186794358,
    nf_phone_ver_insurance = NULL                                  => -0.0066452936,
                                                                      -0.0066452936);

all_tree_31_c404 := map(
    NULL < iv_nap_inf_phone_ver_lvl AND iv_nap_inf_phone_ver_lvl < 0.5 => 0.0545242271,
    iv_nap_inf_phone_ver_lvl >= 0.5                                    => -0.0051873643,
    iv_nap_inf_phone_ver_lvl = NULL                                    => 0.0195698946,
                                                                          0.0195698946);

all_tree_31_c403 := map(
    NULL < nf_inq_phone_ver_count AND nf_inq_phone_ver_count < 0.5 => all_tree_31_c404,
    nf_inq_phone_ver_count >= 0.5                                  => -0.0187277376,
    nf_inq_phone_ver_count = NULL                                  => 0.0007462754,
                                                                      -0.0076184330);

all_tree_31 := map(
    NULL < nf_fp_validationrisktype AND nf_fp_validationrisktype < 2.5 => all_tree_31_c403,
    nf_fp_validationrisktype >= 2.5                                    => 0.1442988364,
    nf_fp_validationrisktype = NULL                                    => -0.0068896859,
                                                                          -0.0068896859);

all_tree_32_c407 := map(
    NULL < nf_corrssnaddr AND nf_corrssnaddr < 2.5 => 0.1598307967,
    nf_corrssnaddr >= 2.5                          => 0.0134373459,
    nf_corrssnaddr = NULL                          => 0.0451821623,
                                                      -0.0153772754);

all_tree_32_c406 := map(
    NULL < nf_age_at_ssn_issuance AND nf_age_at_ssn_issuance < 18.5 => -0.0153772754,
    nf_age_at_ssn_issuance >= 18.5                                  => 0.0313411333,
    nf_age_at_ssn_issuance = NULL                                   => all_tree_32_c407,
                                                                       -0.0079236455);

all_tree_32 := map(
    NULL < nf_inq_ssn_lexid_diff01 AND nf_inq_ssn_lexid_diff01 < 0.5 => all_tree_32_c406,
    nf_inq_ssn_lexid_diff01 >= 0.5                                   => 0.0631070199,
    nf_inq_ssn_lexid_diff01 = NULL                                   => -0.0040573566,
                                                                        -0.0040573566);

all_tree_33_c409 := map(
    NULL < nf_inq_ssn_ver_count AND nf_inq_ssn_ver_count < 1.5 => 0.0557852698,
    nf_inq_ssn_ver_count >= 1.5                                => -0.0129158122,
    nf_inq_ssn_ver_count = NULL                                => 0.0559508933,
                                                                  -0.0075168938);

all_tree_33_c410 := map(
    NULL < nf_fp_srchfraudsrchcountmo AND nf_fp_srchfraudsrchcountmo < 0.5 => 0.0434973367,
    nf_fp_srchfraudsrchcountmo >= 0.5                                      => 0.1454393378,
    nf_fp_srchfraudsrchcountmo = NULL                                      => 0.0658078756,
                                                                              -0.0075168938);

all_tree_33 := map(
    ((string)nf_unvrfd_search_risk_index in ['0', '1', '2', '8', '9', '12', '14'])             => all_tree_33_c409,
    ((string)nf_unvrfd_search_risk_index in ['3', '4', '5', '6', '7', '10', '11', '13', '15']) => all_tree_33_c410,
             nf_unvrfd_search_risk_index = NULL                                                 => -0.0046681814,
                                                                                          -0.0046681814);

all_tree_34_c413 := map(
    NULL < rv_f00_inq_corrdobssn_adl AND rv_f00_inq_corrdobssn_adl < 2.5 => 0.0176071407,
    rv_f00_inq_corrdobssn_adl >= 2.5                                     => 0.1079763690,
    rv_f00_inq_corrdobssn_adl = NULL                                     => -0.0165116819,
                                                                            0.0590258216);

all_tree_34_c412 := map(
    NULL < nf_inq_corrnamephone AND nf_inq_corrnamephone < 0.5 => 0.0590258216,
    nf_inq_corrnamephone >= 0.5                                => -0.0079593419,
    nf_inq_corrnamephone = NULL                                => all_tree_34_c413,
                                                                  -0.0078263811);

all_tree_34 := map(
    NULL < nf_fp_validationrisktype AND nf_fp_validationrisktype < 1.5 => all_tree_34_c412,
    nf_fp_validationrisktype >= 1.5                                    => 0.0797270282,
    nf_fp_validationrisktype = NULL                                    => -0.0061616789,
                                                                          -0.0061616789);

all_tree_35_c416 := map(
    ((string)nf_email_name_addr_ver in ['2', '4', '5', '6', '7', '8']) => -0.0324254389,
    ((string)nf_email_name_addr_ver in ['0', '1', '3'])                => 0.0670110362,
    nf_email_name_addr_ver = NULL                              => 0.0450303417,
                                                                  0.0450303417);

all_tree_35_c415 := map(
    NULL < iv_nap_inf_phone_ver_lvl AND iv_nap_inf_phone_ver_lvl < 0.5 => all_tree_35_c416,
    iv_nap_inf_phone_ver_lvl >= 0.5                                    => 0.0042896216,
    iv_nap_inf_phone_ver_lvl = NULL                                    => 0.0134594393,
                                                                          -0.0218161772);

all_tree_35 := map(
    NULL < iv_header_emergence_age AND iv_header_emergence_age < 21.5 => -0.0218161772,
    iv_header_emergence_age >= 21.5                                   => all_tree_35_c415,
    iv_header_emergence_age = NULL                                    => -0.0049329893,
                                                                         -0.0049329893);

all_tree_36_c418 := map(
    ((string)nf_corroboration_risk_index in ['0', '1', '3', '5', '9', '10', '16', '18', '19', '22', '24', '25', '27', '29', '31']) => -0.0050733351,
    ((string)nf_corroboration_risk_index in ['8', '11', '12', '13', '14', '17', '20', '21', '23', '28', '30'])                     => 0.1273929791,
             nf_corroboration_risk_index = NULL                                                                                     => -0.0044364778,
                                                                                                                                   -0.0044364778);

all_tree_36_c419 := map(
    NULL < rv_p88_phn_dst_to_inp_add AND rv_p88_phn_dst_to_inp_add < 11.5 => 0.0164092642,
    rv_p88_phn_dst_to_inp_add >= 11.5                                     => 0.0616955413,
    rv_p88_phn_dst_to_inp_add = NULL                                      => 0.0990118992,
                                                                             -0.0044364778);

all_tree_36 := map(
    NULL < nf_fp_srchcomponentrisktype AND nf_fp_srchcomponentrisktype < 1.5 => all_tree_36_c418,
    nf_fp_srchcomponentrisktype >= 1.5                                       => all_tree_36_c419,
    nf_fp_srchcomponentrisktype = NULL                                       => -0.0019245102,
                                                                                -0.0019245102);

all_tree_37_c422 := map(
    (rv_6seg_riskview_5_0 in ['4 SUFFICIENTLY VERD - DEROG', '5 SUFFICIENTLY VERD - OWNER', '6 SUFFICIENTLY VERD - OTHER'])       => 0.0156969788,
    (rv_6seg_riskview_5_0 in ['0 TRUEDID = 0', '1 VER/VAL PROBLEMS', '2 ADDR NOT CURRENT - DEROG', '3 ADDR NOT CURRENT - OTHER']) => 0.1010665260,
    rv_6seg_riskview_5_0 = ''                                                                                                     => 0.0427328885,
                                                                                                                                     -0.0071776576);

all_tree_37_c421 := map(
    ((string)nf_inq_perphone_recency in ['0', '3', '6', '12']) => -0.0071776576,
    ((string)nf_inq_perphone_recency in ['1'])                 => all_tree_37_c422,
             nf_inq_perphone_recency = NULL                    => -0.0043728831,
                                                                0.1470063926);

all_tree_37 := map(
    NULL < rv_f00_input_dob_match_level AND rv_f00_input_dob_match_level < 5.5 => 0.1470063926,
    rv_f00_input_dob_match_level >= 5.5                                        => all_tree_37_c421,
    rv_f00_input_dob_match_level = NULL                                        => -0.0036004725,
                                                                                  -0.0036004725);

all_tree_38_c424 := map(
    ((string)rv_c22_inp_addr_occ_index in ['1', '4', '5', '6']) => -0.0108285932,
    ((string)rv_c22_inp_addr_occ_index in ['0', '3', '7', '8']) => 0.0459865264,
             rv_c22_inp_addr_occ_index = NULL                    => -0.0048022708,
                                                           -0.0048022708);

all_tree_38_c425 := map(
    NULL < iv_c13_avg_lres AND iv_c13_avg_lres < 123.5 => 0.0161653314,
    iv_c13_avg_lres >= 123.5                           => 0.1165304992,
    iv_c13_avg_lres = NULL                             => 0.0502251624,
                                                          -0.0048022708);

all_tree_38 := map(
    NULL < nf_inq_ssn_lexid_diff01 AND nf_inq_ssn_lexid_diff01 < 0.5 => all_tree_38_c424,
    nf_inq_ssn_lexid_diff01 >= 0.5                                   => all_tree_38_c425,
    nf_inq_ssn_lexid_diff01 = NULL                                   => -0.0018817132,
                                                                        -0.0018817132);

all_tree_39_c428 := map(
    ((string)rv_f04_curr_add_occ_index in ['3'])      => 0.0053706289,
    ((string)rv_f04_curr_add_occ_index in ['0', '1']) => 0.0838335791,
             rv_f04_curr_add_occ_index = NULL         => 0.0341910920,
                                                      -0.0057320363);

all_tree_39_c427 := map(
    NULL < nf_add_dist_input_to_curr AND nf_add_dist_input_to_curr < 0.5 => -0.0057320363,
    nf_add_dist_input_to_curr >= 0.5                                     => all_tree_39_c428,
    nf_add_dist_input_to_curr = NULL                                     => -0.0025688193,
                                                                            0.1242338285);

all_tree_39 := map(
    NULL < rv_f00_input_dob_match_level AND rv_f00_input_dob_match_level < 5.5 => 0.1242338285,
    rv_f00_input_dob_match_level >= 5.5                                        => all_tree_39_c427,
    rv_f00_input_dob_match_level = NULL                                        => -0.0019383730,
                                                                                  -0.0019383730);

all_tree_40_c431 := map(
    NULL < nf_inq_ssn_ver_count AND nf_inq_ssn_ver_count < 1.5 => 0.1211470965,
    nf_inq_ssn_ver_count >= 1.5                                => 0.0270254972,
    nf_inq_ssn_ver_count = NULL                                => 0.0821724716,
                                                                  -0.0016659666);

all_tree_40_c430 := map(
    NULL < nf_fp_idverrisktype AND nf_fp_idverrisktype < 1.5 => -0.0016659666,
    nf_fp_idverrisktype >= 1.5                               => all_tree_40_c431,
    nf_fp_idverrisktype = NULL                               => 0.0118742773,
                                                                -0.0208542426);

all_tree_40 := map(
    NULL < iv_header_emergence_age AND iv_header_emergence_age < 21.5 => -0.0208542426,
    iv_header_emergence_age >= 21.5                                   => all_tree_40_c430,
    iv_header_emergence_age = NULL                                    => -0.0051402134,
                                                                         -0.0051402134);

all_tree_41_c434 := map(
    NULL < iv_nap_inf_phone_ver_lvl AND iv_nap_inf_phone_ver_lvl < 0.5 => 0.0459171145,
    iv_nap_inf_phone_ver_lvl >= 0.5                                    => 0.0021447425,
    iv_nap_inf_phone_ver_lvl = NULL                                    => 0.0126460163,
                                                                          -0.0199172866);

all_tree_41_c433 := map(
    (iv_f00_email_verification in ['1', '2', '4', '5']) => -0.0199172866,
    (iv_f00_email_verification in ['', '0', '3'])       => all_tree_41_c434,
    iv_f00_email_verification = ''                    => -0.0058921023,
                                                           -0.0058921023);

all_tree_41 := map(
    NULL < nf_fp_validationrisktype AND nf_fp_validationrisktype < 3.5 => all_tree_41_c433,
    nf_fp_validationrisktype >= 3.5                                    => 0.1140877163,
    nf_fp_validationrisktype = NULL                                    => -0.0053636490,
                                                                          -0.0053636490);

all_tree_42_c436 := map(
    NULL < nf_inq_ssn_ver_count AND nf_inq_ssn_ver_count < 1.5 => 0.0402726048,
    nf_inq_ssn_ver_count >= 1.5                                => -0.0108157760,
    nf_inq_ssn_ver_count = NULL                                => 0.0555476819,
                                                                  -0.0064819352);

all_tree_42_c437 := map(
    (nf_inquiry_verification_index in ['9', '15', '21', '23', '27', '31'])                           => 0.0288723366,
    (nf_inquiry_verification_index in ['0', '1', '3', '5', '7', '11', '13', '17', '19', '25', '29']) => 0.1141310747,
    nf_inquiry_verification_index = ''                                                               => 0.0449680245,
                                                                                                        -0.0064819352);

all_tree_42 := map(
    ((string)nf_unvrfd_search_risk_index in ['0', '1', '2', '8', '11', '12', '13', '14']) => all_tree_42_c436,
    ((string)nf_unvrfd_search_risk_index in ['3', '4', '5', '6', '7', '9', '10', '15'])   => all_tree_42_c437,
             nf_unvrfd_search_risk_index = NULL                                            => -0.0033209954,
                                                                                     -0.0033209954);

all_tree_43_c440 := map(
    NULL < nf_mos_bus_header_ls AND nf_mos_bus_header_ls < 0.5 => -0.0160673710,
    nf_mos_bus_header_ls >= 0.5                                => 0.0220550251,
    nf_mos_bus_header_ls = NULL                                => -0.0062859439,
                                                                  -0.0062859439);

all_tree_43_c439 := map(
    NULL < nf_invbest_inq_adlsperphone_diff AND nf_invbest_inq_adlsperphone_diff < 1.5 => all_tree_43_c440,
    nf_invbest_inq_adlsperphone_diff >= 1.5                                            => 0.0795428555,
    nf_invbest_inq_adlsperphone_diff = NULL                                            => -0.0041555634,
                                                                                          -0.0041555634);

all_tree_43 := map(
    ((string)nf_corroboration_risk_index in ['0', '1', '3', '5', '9', '10', '18', '22', '25', '27', '29', '31'])                 => all_tree_43_c439,
    ((string)nf_corroboration_risk_index in ['8', '11', '12', '13', '14', '16', '17', '19', '20', '21', '23', '24', '28', '30']) => 0.0933932560,
             nf_corroboration_risk_index = NULL                                                                                   => -0.0027091983,
                                                                                                                            -0.0027091983);

all_tree_44_c442 := map(
    ((string)nf_corroboration_risk_index in ['1', '3', '10', '11', '14', '16', '17', '18', '19', '22', '24', '25', '27', '29', '31']) => -0.0063132838,
    ((string)nf_corroboration_risk_index in ['0', '5', '8', '9', '12', '13', '20', '21', '23', '28', '30'])                           => 0.1043853136,
             nf_corroboration_risk_index = NULL                                                                                       => -0.0055121894,
                                                                                                                                 -0.0055121894);

all_tree_44_c443 := map(
    NULL < iv_header_emergence_age AND iv_header_emergence_age < 25.5 => 0.0125218986,
    iv_header_emergence_age >= 25.5                                   => 0.0693403908,
    iv_header_emergence_age = NULL                                    => 0.0343774306,
                                                                         -0.0055121894);

all_tree_44 := map(
    (nf_inquiry_verification_index in ['1', '7', '9', '19', '21', '23', '27', '29', '31']) => all_tree_44_c442,
    (nf_inquiry_verification_index in ['0', '3', '5', '11', '13', '15', '17', '25'])       => all_tree_44_c443,
      nf_inquiry_verification_index = ''                                                   => -0.0021552972,
                                                                                              -0.0021552972);

all_tree_45_c446 := map(
    NULL < nf_bus_gold_seleids_peradl AND nf_bus_gold_seleids_peradl < 2.5 => 0.0109863327,
    nf_bus_gold_seleids_peradl >= 2.5                                      => 0.1238849951,
    nf_bus_gold_seleids_peradl = NULL                                      => 0.0144278250,
                                                                              -0.0174157591);

all_tree_45_c445 := map(
    NULL < iv_header_emergence_age AND iv_header_emergence_age < 23.5 => -0.0174157591,
    iv_header_emergence_age >= 23.5                                   => all_tree_45_c446,
    iv_header_emergence_age = NULL                                    => -0.0049189345,
                                                                         -0.0049189345);

all_tree_45 := map(
    NULL < nf_inq_perssn_count_day AND nf_inq_perssn_count_day < 0.5 => all_tree_45_c445,
    nf_inq_perssn_count_day >= 0.5                                   => 0.0955056168,
    nf_inq_perssn_count_day = NULL                                   => -0.0040650215,
                                                                        -0.0040650215);

all_tree_46_c449 := map(
    NULL < iv_phn_addr_verified AND iv_phn_addr_verified < 1.5 => 0.0900054707,
    iv_phn_addr_verified >= 1.5                                => 0.0129578677,
    iv_phn_addr_verified = NULL                                => 0.0397650353,
                                                                  -0.0070407313);

all_tree_46_c448 := map(
    ((string)nf_unvrfd_search_risk_index in ['0', '1', '2', '3', '6', '8', '14'])               => -0.0070407313,
    ((string)nf_unvrfd_search_risk_index in ['4', '5', '7', '9', '10', '11', '12', '13', '15']) => all_tree_46_c449,
             nf_unvrfd_search_risk_index = NULL                                                  => -0.0044048508,
                                                                                               0.0681577410);

all_tree_46 := map(
    NULL < rv_f00_input_dob_match_level AND rv_f00_input_dob_match_level < 7.5 => 0.0681577410,
    rv_f00_input_dob_match_level >= 7.5                                        => all_tree_46_c448,
    rv_f00_input_dob_match_level = NULL                                        => -0.0024083829,
                                                                                  -0.0024083829);

all_tree_47_c452 := map(
    NULL < nf_bus_inact_seleids_peradl AND nf_bus_inact_seleids_peradl < 0.5 => 0.0551848793,
    nf_bus_inact_seleids_peradl >= 0.5                                       => 0.1803731754,
    nf_bus_inact_seleids_peradl = NULL                                       => 0.0745969885,
                                                                                0.0091668542);

all_tree_47_c451 := map(
    (nf_inquiry_verification_index in ['23', '31'])                                                                         => 0.0091668542,
    (nf_inquiry_verification_index in ['0', '1', '3', '5', '7', '9', '11', '13', '15', '17', '19', '21', '25', '27', '29']) => all_tree_47_c452,
      nf_inquiry_verification_index = ''                                                                                   => 0.0256024047,
                                                                                                                               -0.0065143214);

all_tree_47 := map(
    ((string)rv_i62_inq_dobsperadl_recency in ['0', '12'])     => -0.0065143214,
    ((string)rv_i62_inq_dobsperadl_recency in ['1', '3', '6']) => all_tree_47_c451,
    rv_i62_inq_dobsperadl_recency = NULL               => -0.0012280671,
                                                          -0.0012280671);
//***Tree 48 code 
all_tree_48_c455 := map(
    NULL < nf_inq_phone_ver_count AND nf_inq_phone_ver_count < 0.5 => 0.0446682441,
    nf_inq_phone_ver_count >= 0.5                                  => 0.0004845610,
    nf_inq_phone_ver_count = NULL                                  => 0.0195702185,
                                                                      -0.0188355548);

all_tree_48_c454 := map(
    (iv_f00_email_verification in ['1', '2', '4', '5']) => -0.0188355548,
    (iv_f00_email_verification in ['', '0', '3'])       => all_tree_48_c455,
    iv_f00_email_verification = ''                    => -0.0047105082,
                                                           0.1190298908);

all_tree_48 := map(
    NULL < rv_f00_input_dob_match_level AND rv_f00_input_dob_match_level < 5.5 => 0.1190298908,
    rv_f00_input_dob_match_level >= 5.5                                        => all_tree_48_c454,
    rv_f00_input_dob_match_level = NULL                                        => -0.0040683596,
                                                                                  -0.0040683596);


//***Tree 49 Code
all_tree_49_c458 := map(
    NULL < rv_f00_input_dob_match_level AND rv_f00_input_dob_match_level < 7.5 => 0.0878429559,
    rv_f00_input_dob_match_level >= 7.5                                        => 0.0135262715,
    rv_f00_input_dob_match_level = NULL                                        => 0.0162437099,
                                                                                  0.0162437099);

all_tree_49_c457 := map(
    NULL < nf_inq_ssn_ver_count AND nf_inq_ssn_ver_count < 3.5 => all_tree_49_c458,
    nf_inq_ssn_ver_count >= 3.5                                => -0.0163087998,
    nf_inq_ssn_ver_count = NULL                                => 0.0494867733,
                                                                  -0.0067172328);

all_tree_49 := map(
    NULL < nf_bus_seleids_peradl AND nf_bus_seleids_peradl < 1.5 => all_tree_49_c457,
    nf_bus_seleids_peradl >= 1.5                                 => 0.0418862215,
    nf_bus_seleids_peradl = NULL                                 => -0.0009292402,
                                                                    -0.0009292402);

all_tree_50_c461 := map(
    NULL < nf_invbest_inq_lastperaddr_diff AND nf_invbest_inq_lastperaddr_diff < 1.5 => -0.0057673764,
    nf_invbest_inq_lastperaddr_diff >= 1.5                                           => 0.0759276723,
    nf_invbest_inq_lastperaddr_diff = NULL                                           => -0.0047945104,
                                                                                        0.0970320521);

all_tree_50_c460 := map(
    NULL < rv_f00_dob_score AND rv_f00_dob_score < 92 => 0.0970320521,
    rv_f00_dob_score >= 92                            => all_tree_50_c461,
    rv_f00_dob_score = NULL                           => -0.0119706047,
                                                         -0.0036470161);

all_tree_50 := map(
    NULL < nf_fp_validationrisktype AND nf_fp_validationrisktype < 2.5 => all_tree_50_c460,
    nf_fp_validationrisktype >= 2.5                                    => 0.1053670519,
    nf_fp_validationrisktype = NULL                                    => -0.0031382933,
                                                                          -0.0031382933);

all_tree_51_c463 := map(
    NULL < nf_inq_ssn_ver_count AND nf_inq_ssn_ver_count < 3.5 => 0.0217147080,
    nf_inq_ssn_ver_count >= 3.5                                => -0.0143392722,
    nf_inq_ssn_ver_count = NULL                                => 0.0286845748,
                                                                  -0.0047125228);

all_tree_51_c464 := map(
    NULL < nf_m_snc_ssn_high_issue AND nf_m_snc_ssn_high_issue < 539.5 => 0.0143164215,
    nf_m_snc_ssn_high_issue >= 539.5                                   => 0.1140384737,
    nf_m_snc_ssn_high_issue = NULL                                     => 0.0383928713,
                                                                          -0.0047125228);

all_tree_51 := map(
    NULL < nf_inq_ssn_lexid_diff01 AND nf_inq_ssn_lexid_diff01 < 0.5 => all_tree_51_c463,
    nf_inq_ssn_lexid_diff01 >= 0.5                                   => all_tree_51_c464,
    nf_inq_ssn_lexid_diff01 = NULL                                   => -0.0024082055,
                                                                        -0.0024082055);

all_tree_52_c466 := map(
    NULL < iv_dob_bureau_only AND iv_dob_bureau_only < 0.5 => -0.0103685190,
    iv_dob_bureau_only >= 0.5                              => 0.0130881039,
    iv_dob_bureau_only = NULL                              => -0.0069727017,
                                                              -0.0069727017);

all_tree_52_c467 := map(
    (nf_inquiry_verification_index in ['7', '15', '17', '19', '21', '27', '29', '31'])   => 0.0239270694,
    (nf_inquiry_verification_index in ['0', '1', '3', '5', '9', '11', '13', '23', '25']) => 0.1110240851,
          nf_inquiry_verification_index = ''                                                 => 0.0287565406,
                                                                                            -0.0069727017);

all_tree_52 := map(
    NULL < nf_inq_perphone_count12 AND nf_inq_perphone_count12 < 1.5 => all_tree_52_c466,
    nf_inq_perphone_count12 >= 1.5                                   => all_tree_52_c467,
    nf_inq_perphone_count12 = NULL                                   => -0.0020831089,
                                                                        -0.0020831089);

all_tree_53_c470 := map(
    NULL < nf_inq_fname_ver_count AND nf_inq_fname_ver_count < 3.5 => 0.0229098026,
    nf_inq_fname_ver_count >= 3.5                                  => -0.0100153570,
    nf_inq_fname_ver_count = NULL                                  => 0.0488243339,
                                                                      0.0853156550);

all_tree_53_c469 := map(
    NULL < rv_f00_ssn_score AND rv_f00_ssn_score < 95 => 0.0853156550,
    rv_f00_ssn_score >= 95                            => all_tree_53_c470,
    rv_f00_ssn_score = NULL                           => -0.0044894181,
                                                         -0.0044894181);

all_tree_53 := map(
    NULL < nf_fp_idrisktype AND nf_fp_idrisktype < 5.5 => all_tree_53_c469,
    nf_fp_idrisktype >= 5.5                            => 0.0858643979,
    nf_fp_idrisktype = NULL                            => -0.0040126897,
                                                          -0.0040126897);

all_tree_54_c472 := map(
    NULL < iv_dob_src_ct AND iv_dob_src_ct < 1.5 => 0.0208598746,
    iv_dob_src_ct >= 1.5                         => -0.0130294347,
    iv_dob_src_ct = NULL                         => -0.0098166691,
                                                    -0.0098166691);

all_tree_54_c473 := map(
    (iv_f00_email_verification in ['1', '2', '5'])     => -0.0000581355,
    (iv_f00_email_verification in ['', '0', '3', '4']) => 0.0518909244,
    iv_f00_email_verification = ''                   => 0.0227202904,
                                                          -0.0098166691);

all_tree_54 := map(
    NULL < nf_mos_bus_header_fs AND nf_mos_bus_header_fs < 42.5 => all_tree_54_c472,
    nf_mos_bus_header_fs >= 42.5                                => all_tree_54_c473,
    nf_mos_bus_header_fs = NULL                                 => -0.0023674067,
                                                                   -0.0023674067);

all_tree_55_c476 := map(
    ((string)nf_unvrfd_search_risk_index in ['0', '1', '2', '4', '7', '8', '11', '12', '14']) => -0.0079108448,
    ((string)nf_unvrfd_search_risk_index in ['3', '5', '6', '9', '10', '13', '15'])           => 0.0741538768,
    nf_unvrfd_search_risk_index = NULL                                                => -0.0062671955,
                                                                                         0.0425632890);

all_tree_55_c475 := map(
    NULL < nf_inq_corrnamephone AND nf_inq_corrnamephone < 0.5 => 0.0425632890,
    nf_inq_corrnamephone >= 0.5                                => -0.0056520624,
    nf_inq_corrnamephone = NULL                                => all_tree_55_c476,
                                                                  -0.0038811510);

all_tree_55 := map(
    ((string)nf_corroboration_risk_index in ['0', '1', '3', '5', '9', '10', '14', '16', '17', '18', '19', '22', '25', '27', '28', '29', '31']) => all_tree_55_c475,
    ((string)nf_corroboration_risk_index in ['8', '11', '12', '13', '20', '21', '23', '24', '30'])                                             => 0.1050501632,
    nf_corroboration_risk_index = NULL                                                                                                 => -0.0031449681,
                                                                                                                                          -0.0031449681);

all_tree_56_c479 := map(
    ((string)nf_email_name_addr_ver in ['1', '2', '5', '6', '7', '8']) => -0.0438377675,
    ((string)nf_email_name_addr_ver in ['0', '3', '4'])                => 0.0380431247,
    nf_email_name_addr_ver = NULL                                      => 0.0166652716,
                                                                          0.0166652716);

all_tree_56_c478 := map(
    NULL < nf_inq_phone_ver_count AND nf_inq_phone_ver_count < 0.5 => all_tree_56_c479,
    nf_inq_phone_ver_count >= 0.5                                  => -0.0111156568,
    nf_inq_phone_ver_count = NULL                                  => -0.0065205385,
                                                                      -0.0045047064);

all_tree_56 := map(
    NULL < nf_fp_idrisktype AND nf_fp_idrisktype < 5.5 => all_tree_56_c478,
    nf_fp_idrisktype >= 5.5                            => 0.0918324941,
    nf_fp_idrisktype = NULL                            => -0.0039964304,
                                                          -0.0039964304);

all_tree_57_c481 := map(
    NULL < iv_header_emergence_age AND iv_header_emergence_age < 26.5 => -0.0129355789,
    iv_header_emergence_age >= 26.5                                   => 0.0168270071,
    iv_header_emergence_age = NULL                                    => -0.0040103859,
                                                                         -0.0040103859);

all_tree_57_c482 := map(
    NULL < iv_c13_avg_lres AND iv_c13_avg_lres < 128.5 => 0.0225661069,
    iv_c13_avg_lres >= 128.5                           => 0.1767114673,
    iv_c13_avg_lres = NULL                             => 0.0674867109,
                                                          -0.0040103859);

all_tree_57 := map(
    NULL < rv_i62_inq_phones_per_adl AND rv_i62_inq_phones_per_adl < 1.5 => all_tree_57_c481,
    rv_i62_inq_phones_per_adl >= 1.5                                     => all_tree_57_c482,
    rv_i62_inq_phones_per_adl = NULL                                     => -0.0024483745,
                                                                            -0.0024483745);

all_tree_58_c485 := map(
    NULL < (integer)iv_inf_nothing_found AND (integer)iv_inf_nothing_found < 0.5 => 0.0095927522,
    (real)iv_inf_nothing_found >= 0.5                                => 0.0956742805,
    (real)iv_inf_nothing_found = NULL                                => 0.0380080140,
                                                                  -0.0047194401);

all_tree_58_c484 := map(
    NULL < nf_fp_srchfraudsrchcountmo AND nf_fp_srchfraudsrchcountmo < 0.5 => -0.0047194401,
    nf_fp_srchfraudsrchcountmo >= 0.5                                      => all_tree_58_c485,
    nf_fp_srchfraudsrchcountmo = NULL                                      => -0.0027657298,
                                                                              -0.0027657298);

all_tree_58 := map(
    ((string)nf_corroboration_risk_index in ['0', '1', '3', '5', '10', '11', '17', '18', '19', '22', '25', '27', '29', '31']) => all_tree_58_c484,
    ((string)nf_corroboration_risk_index in ['8', '9', '12', '13', '14', '16', '20', '21', '23', '24', '28', '30'])           => 0.0666797485,
    nf_corroboration_risk_index = NULL                                                                                => -0.0015332565,
                                                                                                                         -0.0015332565);

all_tree_59_c488 := map(
    ((string)rv_f04_curr_add_occ_index in ['3'])      => 0.0121287647,
    ((string)rv_f04_curr_add_occ_index in ['0', '1']) => 0.0767203852,
    rv_f04_curr_add_occ_index = NULL          => 0.0256052880,
                                                 -0.0084758413);

all_tree_59_c487 := map(
    ((string)rv_c22_inp_addr_occ_index in ['1', '4', '5', '6']) => -0.0084758413,
    ((string)rv_c22_inp_addr_occ_index in ['0', '3', '7', '8']) => all_tree_59_c488,
    rv_c22_inp_addr_occ_index = NULL                    => -0.0048315225,
                                                           -0.0048315225);

all_tree_59 := map(
    NULL < nf_inq_highriskcredit_count24 AND nf_inq_highriskcredit_count24 < 1.5 => all_tree_59_c487,
    nf_inq_highriskcredit_count24 >= 1.5                                         => 0.1128101051,
    nf_inq_highriskcredit_count24 = NULL                                         => -0.0039286783,
                                                                                    -0.0039286783);

all_tree_60_c491 := map(
    NULL < iv_phn_cell AND iv_phn_cell < 0.5 => 0.0581648838,
    iv_phn_cell >= 0.5                       => -0.0157210132,
    iv_phn_cell = NULL                       => 0.0035786168,
                                                -0.0071983144);

all_tree_60_c490 := map(
    NULL < rv_p88_phn_dst_to_inp_add AND rv_p88_phn_dst_to_inp_add < 639.5 => -0.0071983144,
    rv_p88_phn_dst_to_inp_add >= 639.5                                     => 0.1070085729,
    rv_p88_phn_dst_to_inp_add = NULL                                       => all_tree_60_c491,
                                                                              0.0737823716);

all_tree_60 := map(
    NULL < rv_f00_input_dob_match_level AND rv_f00_input_dob_match_level < 5.5 => 0.0737823716,
    rv_f00_input_dob_match_level >= 5.5                                        => all_tree_60_c490,
    rv_f00_input_dob_match_level = NULL                                        => -0.0025955735,
                                                                                  -0.0025955735);

all_tree_61_c494 := map(
    NULL < nf_inq_phone_ver_count AND nf_inq_phone_ver_count < 0.5 => 0.0256702687,
    nf_inq_phone_ver_count >= 0.5                                  => -0.0045491917,
    nf_inq_phone_ver_count = NULL                                  => 0.0092570120,
                                                                      -0.0285429329);

all_tree_61_c493 := map(
    ((string)nf_email_name_addr_ver in ['2', '4', '5', '6', '7', '8']) => -0.0285429329,
    ((string)nf_email_name_addr_ver in ['0', '1', '3'])                => all_tree_61_c494,
    nf_email_name_addr_ver = NULL                              => -0.0053128670,
                                                                  -0.0053128670);

all_tree_61 := map(
    NULL < rv_mos_since_br_first_seen AND rv_mos_since_br_first_seen < 342.5 => all_tree_61_c493,
    rv_mos_since_br_first_seen >= 342.5                                      => 0.0977102452,
    rv_mos_since_br_first_seen = NULL                                        => -0.0039608459,
                                                                                -0.0039608459);

all_tree_62_c497 := map(
    ((string)nf_corroboration_risk_index in ['0', '1', '3', '5', '9', '10', '16', '18', '19', '22', '24', '25', '27', '28', '29', '31']) => -0.0034040709,
    ((string)nf_corroboration_risk_index in ['8', '11', '12', '13', '14', '17', '20', '21', '23', '30'])                                 => 0.1242651203,
    nf_corroboration_risk_index = NULL                                                                                           => -0.0027771659,
                                                                                                                                    -0.0027771659);

all_tree_62_c496 := map(
    NULL < rv_l70_inp_addr_dirty AND rv_l70_inp_addr_dirty < 0.5 => all_tree_62_c497,
    rv_l70_inp_addr_dirty >= 0.5                                 => -0.0787886899,
    rv_l70_inp_addr_dirty = NULL                                 => -0.0044204610,
                                                                    -0.0044204610);

all_tree_62 := map(
    ((string)rv_i62_inq_dobsperadl_recency in ['0', '6', '12']) => all_tree_62_c496,
    ((string)rv_i62_inq_dobsperadl_recency in ['1', '3'])       => 0.0323576710,
    rv_i62_inq_dobsperadl_recency = NULL                => -0.0010717456,
                                                           -0.0010717456);

all_tree_63_c500 := map(
    NULL < iv_header_emergence_age AND iv_header_emergence_age < 31.5 => -0.0006026662,
    iv_header_emergence_age >= 31.5                                   => 0.0500336461,
    iv_header_emergence_age = NULL                                    => 0.0117018986,
                                                                         0.0117018986);

all_tree_63_c499 := map(
    NULL < iv_dob_src_ct AND iv_dob_src_ct < 3.5 => all_tree_63_c500,
    iv_dob_src_ct >= 3.5                         => -0.0064024096,
    iv_dob_src_ct = NULL                         => -0.0036204390,
                                                    -0.0036204390);

all_tree_63 := map(
    NULL < nf_inq_adlsperphone_count12 AND nf_inq_adlsperphone_count12 < 1.5 => all_tree_63_c499,
    nf_inq_adlsperphone_count12 >= 1.5                                       => 0.0653960418,
    nf_inq_adlsperphone_count12 = NULL                                       => -0.0017665973,
                                                                                -0.0017665973);

all_tree_64_c503 := map(
    NULL < iv_input_best_phone_match AND iv_input_best_phone_match < 0.5 => 0.0010608331,
    iv_input_best_phone_match >= 0.5                                     => -0.0445537621,
    iv_input_best_phone_match = NULL                                     => -0.0041288273,
                                                                            -0.0041288273);

all_tree_64_c502 := map(
    (iv_prof_license_category in ['-1', '0', '1', '2', '3', '4']) => all_tree_64_c503,
    (iv_prof_license_category in ['', '5'])                       => 0.1302568588,
    iv_prof_license_category = ''                                 => -0.0031922390,
                                                                     0.0679524103);

all_tree_64 := map(
    NULL < rv_f00_input_dob_match_level AND rv_f00_input_dob_match_level < 5.5 => 0.0679524103,
    rv_f00_input_dob_match_level >= 5.5                                        => all_tree_64_c502,
    rv_f00_input_dob_match_level = NULL                                        => -0.0028354143,
                                                                                  -0.0028354143);

all_tree_65_c506 := map(
    NULL < nf_adls_per_bestphone_c6 AND nf_adls_per_bestphone_c6 < 0.5 => 0.0535016790,
    nf_adls_per_bestphone_c6 >= 0.5                                    => 0.0101524014,
    nf_adls_per_bestphone_c6 = NULL                                    => 0.0079017886,
                                                                          -0.0137475067);

all_tree_65_c505 := map(
    NULL < iv_header_emergence_age AND iv_header_emergence_age < 20.5 => -0.0137475067,
    iv_header_emergence_age >= 20.5                                   => all_tree_65_c506,
    iv_header_emergence_age = NULL                                    => 0.0014803152,
                                                                         0.0014803152);

all_tree_65 := map(
    NULL < iv_input_best_phone_match AND iv_input_best_phone_match < 0.5 => all_tree_65_c505,
    iv_input_best_phone_match >= 0.5                                     => -0.0365656343,
    iv_input_best_phone_match = NULL                                     => -0.0028636182,
                                                                            -0.0028636182);

all_tree_66_c509 := map(
    NULL < rv_c13_inp_addr_lres AND rv_c13_inp_addr_lres < 6.5 => 0.0897278327,
    rv_c13_inp_addr_lres >= 6.5                                => 0.0156253846,
    rv_c13_inp_addr_lres = NULL                                => 0.0204882790,
                                                                  0.0204882790);

all_tree_66_c508 := map(
    NULL < nf_inq_ssn_ver_count AND nf_inq_ssn_ver_count < 2.5 => all_tree_66_c509,
    nf_inq_ssn_ver_count >= 2.5                                => -0.0064377552,
    nf_inq_ssn_ver_count = NULL                                => 0.0354088023,
                                                                  -0.0019673750);

all_tree_66 := map(
    ((string)nf_corroboration_risk_index in ['1', '3', '5', '14', '17', '18', '19', '22', '25', '27', '29', '31'])             => all_tree_66_c508,
    ((string)nf_corroboration_risk_index in ['0', '8', '9', '10', '11', '12', '13', '16', '20', '21', '23', '24', '28', '30']) => 0.0573912630,
    nf_corroboration_risk_index = NULL                                                                                 => -0.0008413935,
                                                                                                                          -0.0008413935);

all_tree_67_c512 := map(
    NULL < iv_phn_cell AND iv_phn_cell < 0.5 => 0.0612113452,
    iv_phn_cell >= 0.5                       => -0.0164097079,
    iv_phn_cell = NULL                       => 0.0043636647,
                                                -0.0155122341);

all_tree_67_c511 := map(
    NULL < rv_p88_phn_dst_to_inp_add AND rv_p88_phn_dst_to_inp_add < 797.5 => -0.0155122341,
    rv_p88_phn_dst_to_inp_add >= 797.5                                     => 0.1122035293,
    rv_p88_phn_dst_to_inp_add = NULL                                       => all_tree_67_c512,
                                                                              0.0089933764);

all_tree_67 := map(
    NULL < iv_dob_src_ct AND iv_dob_src_ct < 8.5 => 0.0089933764,
    iv_dob_src_ct >= 8.5                         => all_tree_67_c511,
    iv_dob_src_ct = NULL                         => -0.0034934345,
                                                    -0.0034934345);

all_tree_68_c514 := map(
    NULL < nf_inq_per_phone AND nf_inq_per_phone < 3.5 => -0.0048144280,
    nf_inq_per_phone >= 3.5                            => 0.0403808711,
    nf_inq_per_phone = NULL                            => -0.0029295133,
                                                          -0.0029295133);

all_tree_68_c515 := map(
    (iv_f00_email_verification in ['2', '5'])               => -0.0029080038,
    (iv_f00_email_verification in ['', '0', '1', '3', '4']) => 0.1319667346,
    iv_f00_email_verification = ''                        => 0.0649819652,
                                                               -0.0029295133);

all_tree_68 := map(
    NULL < nf_bus_gold_seleids_peradl AND nf_bus_gold_seleids_peradl < 2.5 => all_tree_68_c514,
    nf_bus_gold_seleids_peradl >= 2.5                                      => all_tree_68_c515,
    nf_bus_gold_seleids_peradl = NULL                                      => -0.0011646558,
                                                                              -0.0011646558);

all_tree_69_c518 := map(
    NULL < iv_bureau_emergence_age AND iv_bureau_emergence_age < 49.5 => -0.0136979607,
    iv_bureau_emergence_age >= 49.5                                   => 0.0692012451,
    iv_bureau_emergence_age = NULL                                    => -0.0118924367,
                                                                         -0.0118924367);

all_tree_69_c517 := map(
    NULL < iv_dob_bureau_only AND iv_dob_bureau_only < 0.5 => all_tree_69_c518,
    iv_dob_bureau_only >= 0.5                              => 0.0132570673,
    iv_dob_bureau_only = NULL                              => -0.0080468175,
                                                              -0.0080468175);

all_tree_69 := map(
    NULL < nf_bus_seleids_peradl AND nf_bus_seleids_peradl < 1.5 => all_tree_69_c517,
    nf_bus_seleids_peradl >= 1.5                                 => 0.0295603479,
    nf_bus_seleids_peradl = NULL                                 => -0.0036027667,
                                                                    -0.0036027667);

all_tree_70_c521 := map(
    NULL < nf_invbest_inq_ssnsperaddr_diff AND nf_invbest_inq_ssnsperaddr_diff < -0.5 => 0.0114879751,
    nf_invbest_inq_ssnsperaddr_diff >= -0.5                                           => 0.0550518583,
    nf_invbest_inq_ssnsperaddr_diff = NULL                                            => 0.0150894757,
                                                                                         0.0150894757);

all_tree_70_c520 := map(
    NULL < nf_inq_ssn_ver_count AND nf_inq_ssn_ver_count < 4.5 => all_tree_70_c521,
    nf_inq_ssn_ver_count >= 4.5                                => -0.0132721100,
    nf_inq_ssn_ver_count = NULL                                => 0.0072369013,
                                                                  -0.0029187507);

all_tree_70 := map(
    ((string)nf_inquiry_adl_vel_risk_index in ['0', '1', '3', '4', '5', '12', '14', '31'])  => all_tree_70_c520,
    ((string)nf_inquiry_adl_vel_risk_index in ['2', '6', '7', '8', '16', '18', '20', '22']) => 0.1214325697,
    nf_inquiry_adl_vel_risk_index = NULL                                            => -0.0023764659,
                                                                                       -0.0023764659);

all_tree_71_c523 := map(
    NULL < nf_adls_per_bestssn AND nf_adls_per_bestssn < 1.5 => 0.0005579775,
    nf_adls_per_bestssn >= 1.5                               => 0.0582089790,
    nf_adls_per_bestssn = NULL                               => 0.0103003687,
                                                                0.0103003687);

all_tree_71_c524 := map(
    NULL < nf_mos_bus_header_fs AND nf_mos_bus_header_fs < 55.5 => -0.0142826049,
    nf_mos_bus_header_fs >= 55.5                                => 0.0201119134,
    nf_mos_bus_header_fs = NULL                                 => -0.0057601496,
                                                                   0.0103003687);

all_tree_71 := map(
    NULL < iv_dob_src_ct AND iv_dob_src_ct < 4.5 => all_tree_71_c523,
    iv_dob_src_ct >= 4.5                         => all_tree_71_c524,
    iv_dob_src_ct = NULL                         => -0.0029823033,
                                                    -0.0029823033);

all_tree_72_c526 := map(
    ((string)iv_bureau_verification_index in ['0', '3', '9', '11', '13'])       => -0.0145137460,
    ((string)iv_bureau_verification_index in ['1', '5', '7', '10', '14', '15']) => 0.0949760247,
    iv_bureau_verification_index = NULL                                 => 0.0248891577,
                                                                           0.0248891577);

all_tree_72_c527 := map(
    ((string)rv_c22_inp_addr_occ_index in ['0', '1', '4', '5', '6']) => -0.0055637054,
    ((string)rv_c22_inp_addr_occ_index in ['3', '7', '8'])           => 0.0289635172,
    rv_c22_inp_addr_occ_index = NULL                         => -0.0018259586,
                                                                0.0248891577);

all_tree_72 := map(
    NULL < rv_f00_input_dob_match_level AND rv_f00_input_dob_match_level < 7.5 => all_tree_72_c526,
    rv_f00_input_dob_match_level >= 7.5                                        => all_tree_72_c527,
    rv_f00_input_dob_match_level = NULL                                        => -0.0010651330,
                                                                                  -0.0010651330);

all_tree_73_c530 := map(
    NULL < nf_inq_phone_ver_count AND nf_inq_phone_ver_count < 0.5 => 0.0302966203,
    nf_inq_phone_ver_count >= 0.5                                  => -0.0068498802,
    nf_inq_phone_ver_count = NULL                                  => 0.0035046300,
                                                                      0.0034122825);

all_tree_73_c529 := map(
    NULL < iv_dob_bureau_only AND iv_dob_bureau_only < 0.5 => all_tree_73_c530,
    iv_dob_bureau_only >= 0.5                              => 0.0264891439,
    iv_dob_bureau_only = NULL                              => 0.0076616225,
                                                              -0.0141404845);

all_tree_73 := map(
    NULL < iv_header_emergence_age AND iv_header_emergence_age < 21.5 => -0.0141404845,
    iv_header_emergence_age >= 21.5                                   => all_tree_73_c529,
    iv_header_emergence_age = NULL                                    => -0.0037095458,
                                                                         -0.0037095458);

all_tree_74_c533 := map(
    NULL < rv_l70_inp_addr_dirty AND rv_l70_inp_addr_dirty < 0.5 => -0.0047787721,
    rv_l70_inp_addr_dirty >= 0.5                                 => -0.0648286734,
    rv_l70_inp_addr_dirty = NULL                                 => -0.0061227433,
                                                                    -0.0061227433);

all_tree_74_c532 := map(
    NULL < rv_l79_adls_per_sfd_addr AND rv_l79_adls_per_sfd_addr < 6.5 => all_tree_74_c533,
    rv_l79_adls_per_sfd_addr >= 6.5                                    => 0.0471033351,
    rv_l79_adls_per_sfd_addr = NULL                                    => -0.0030375914,
                                                                          -0.0030375914);

all_tree_74 := map(
    ((string)nf_unvrfd_search_risk_index in ['0', '1', '2', '8', '9', '11', '12', '13', '14']) => all_tree_74_c532,
    ((string)nf_unvrfd_search_risk_index in ['3', '4', '5', '6', '7', '10', '15'])             => 0.0468470226,
    nf_unvrfd_search_risk_index = NULL                                                 => -0.0013974659,
                                                                                          -0.0013974659);

all_tree_75_c536 := map(
    NULL < nf_fp_validationrisktype AND nf_fp_validationrisktype < 1.5 => -0.0009054076,
    nf_fp_validationrisktype >= 1.5                                    => 0.0755343633,
    nf_fp_validationrisktype = NULL                                    => 0.0000059668,
                                                                          0.0000059668);

all_tree_75_c535 := map(
    NULL < rv_l70_add_standardized AND rv_l70_add_standardized < 1.5 => all_tree_75_c536,
    rv_l70_add_standardized >= 1.5                                   => -0.0668849619,
    rv_l70_add_standardized = NULL                                   => -0.0013729489,
                                                                        0.0288711074);

all_tree_75 := map(
    NULL < rv_f00_input_dob_match_level AND rv_f00_input_dob_match_level < 7.5 => 0.0288711074,
    rv_f00_input_dob_match_level >= 7.5                                        => all_tree_75_c535,
    rv_f00_input_dob_match_level = NULL                                        => -0.0005314073,
                                                                                  -0.0005314073);

all_tree_76_c538 := map(
    NULL < iv_dob_bureau_only AND iv_dob_bureau_only < 1.5 => -0.0049567541,
    iv_dob_bureau_only >= 1.5                              => 0.0153785696,
    iv_dob_bureau_only = NULL                              => -0.0036913871,
                                                              -0.0036913871);

all_tree_76_c539 := map(
    NULL < nf_phones_per_addr_curr AND nf_phones_per_addr_curr < 13.5 => 0.1007006704,
    nf_phones_per_addr_curr >= 13.5                                   => -0.0164147152,
    nf_phones_per_addr_curr = NULL                                    => 0.0434090899,
                                                                         -0.0036913871);

all_tree_76 := map(
    NULL < nf_fp_divaddrsuspidcountnew AND nf_fp_divaddrsuspidcountnew < 1.5 => all_tree_76_c538,
    nf_fp_divaddrsuspidcountnew >= 1.5                                       => all_tree_76_c539,
    nf_fp_divaddrsuspidcountnew = NULL                                       => -0.0014119343,
                                                                                -0.0014119343);

all_tree_77_c542 := map(
    NULL < iv_dob_src_ct AND iv_dob_src_ct < 11.5 => 0.0144790677,
    iv_dob_src_ct >= 11.5                         => -0.0010360262,
    iv_dob_src_ct = NULL                          => 0.0101162363,
                                                     -0.0147583964);

all_tree_77_c541 := map(
    NULL < iv_header_emergence_age AND iv_header_emergence_age < 23.5 => -0.0147583964,
    iv_header_emergence_age >= 23.5                                   => all_tree_77_c542,
    iv_header_emergence_age = NULL                                    => -0.0048897124,
                                                                         -0.0048897124);

all_tree_77 := map(
    NULL < nf_fp_srchfraudsrchcountyr AND nf_fp_srchfraudsrchcountyr < 2.5 => all_tree_77_c541,
    nf_fp_srchfraudsrchcountyr >= 2.5                                      => 0.0407442271,
    nf_fp_srchfraudsrchcountyr = NULL                                      => -0.0024322094,
                                                                              -0.0024322094);

all_tree_78_c544 := map(
    NULL < iv_bureau_emergence_age AND iv_bureau_emergence_age < 56.5 => -0.0054645889,
    iv_bureau_emergence_age >= 56.5                                   => 0.0924280740,
    iv_bureau_emergence_age = NULL                                    => -0.0048349389,
                                                                         -0.0048349389);

all_tree_78_c545 := map(
    NULL < nf_m_snc_ssn_high_issue AND nf_m_snc_ssn_high_issue < 625.5 => 0.0148560951,
    nf_m_snc_ssn_high_issue >= 625.5                                   => 0.0988509344,
    nf_m_snc_ssn_high_issue = NULL                                     => 0.0216039084,
                                                                          -0.0048349389);

all_tree_78 := map(
    ((string)rv_i62_inq_dobsperadl_recency in ['0', '12'])     => all_tree_78_c544,
    ((string)rv_i62_inq_dobsperadl_recency in ['1', '3', '6']) => all_tree_78_c545,
    rv_i62_inq_dobsperadl_recency = NULL               => -0.0004436439,
                                                          -0.0004436439);

all_tree_79_c547 := map(
    NULL < nf_dist_inp_curr_hi_velocity AND nf_dist_inp_curr_hi_velocity < 5.5 => -0.0043800535,
    nf_dist_inp_curr_hi_velocity >= 5.5                                        => 0.0879917302,
    nf_dist_inp_curr_hi_velocity = NULL                                        => -0.0038342951,
                                                                                  -0.0038342951);

all_tree_79_c548 := map(
    NULL < rv_c13_curr_addr_lres AND rv_c13_curr_addr_lres < 230 => 0.0200621319,
    rv_c13_curr_addr_lres >= 230                                 => 0.1409295004,
    rv_c13_curr_addr_lres = NULL                                 => 0.0313216396,
                                                                    -0.0038342951);

all_tree_79 := map(
    NULL < nf_fp_varrisktype AND nf_fp_varrisktype < 2.5 => all_tree_79_c547,
    nf_fp_varrisktype >= 2.5                             => all_tree_79_c548,
    nf_fp_varrisktype = NULL                             => -0.0014152454,
                                                            -0.0014152454);

all_tree_80_c551 := map(
    ((string)rv_i60_inq_other_recency in ['1', '3', '6'])         => -0.0564553772,
    ((string)rv_i60_inq_other_recency in ['0', '12', '24', '99']) => 0.0602603925,
    rv_i60_inq_other_recency = NULL                       => 0.0436919078,
                                                             -0.0038593556);

all_tree_80_c550 := map(
    NULL < rv_l79_adls_per_sfd_addr AND rv_l79_adls_per_sfd_addr < 6.5 => -0.0038593556,
    rv_l79_adls_per_sfd_addr >= 6.5                                    => all_tree_80_c551,
    rv_l79_adls_per_sfd_addr = NULL                                    => -0.0011498332,
                                                                          0.0162377143);

all_tree_80 := map(
    NULL < rv_f00_input_dob_match_level AND rv_f00_input_dob_match_level < 7.5 => 0.0162377143,
    rv_f00_input_dob_match_level >= 7.5                                        => all_tree_80_c550,
    rv_f00_input_dob_match_level = NULL                                        => -0.0006532411,
                                                                                  -0.0006532411);

all_tree_81_c554 := map(
    NULL < nf_inq_corrnamephonessn AND nf_inq_corrnamephonessn < 0.5 => 0.1155837657,
    nf_inq_corrnamephonessn >= 0.5                                   => -0.0498170640,
    nf_inq_corrnamephonessn = NULL                                   => 0.0107904396,
                                                                        -0.0024749068);

all_tree_81_c553 := map(
    NULL < iv_dob_bureau_only AND iv_dob_bureau_only < 1.5 => -0.0024749068,
    iv_dob_bureau_only >= 1.5                              => all_tree_81_c554,
    iv_dob_bureau_only = NULL                              => -0.0016651074,
                                                              -0.0016651074);

all_tree_81 := map(
    NULL < nf_fp_validationrisktype AND nf_fp_validationrisktype < 2.5 => all_tree_81_c553,
    nf_fp_validationrisktype >= 2.5                                    => 0.0714481616,
    nf_fp_validationrisktype = NULL                                    => -0.0013017087,
                                                                          -0.0013017087);

all_tree_82_c557 := map(
    NULL < nf_inq_ssn_ver_count AND nf_inq_ssn_ver_count < 2.5 => 0.0825248413,
    nf_inq_ssn_ver_count >= 2.5                                => 0.0095080278,
    nf_inq_ssn_ver_count = NULL                                => 0.0152909086,
                                                                  0.0152909086);

all_tree_82_c556 := map(
    NULL < rv_c13_curr_addr_lres AND rv_c13_curr_addr_lres < 353 => all_tree_82_c557,
    rv_c13_curr_addr_lres >= 353                                 => 0.1320490390,
    rv_c13_curr_addr_lres = NULL                                 => 0.0197480654,
                                                                    -0.0056516004);

all_tree_82 := map(
    NULL < nf_fp_varrisktype AND nf_fp_varrisktype < 1.5 => -0.0056516004,
    nf_fp_varrisktype >= 1.5                             => all_tree_82_c556,
    nf_fp_varrisktype = NULL                             => -0.0016477722,
                                                            -0.0016477722);

all_tree_83_c559 := map(
    NULL < rv_l79_adls_per_addr_curr AND rv_l79_adls_per_addr_curr < 3.5 => -0.0092547851,
    rv_l79_adls_per_addr_curr >= 3.5                                     => 0.0217993456,
    rv_l79_adls_per_addr_curr = NULL                                     => 0.0045676628,
                                                                            0.0045676628);

all_tree_83_c560 := map(
    NULL < nf_fp_idverrisktype AND nf_fp_idverrisktype < 1.5 => -0.0205411685,
    nf_fp_idverrisktype >= 1.5                               => 0.0124322630,
    nf_fp_idverrisktype = NULL                               => -0.0096980318,
                                                                0.0045676628);

all_tree_83 := map(
    NULL < iv_dob_src_ct AND iv_dob_src_ct < 8.5 => all_tree_83_c559,
    iv_dob_src_ct >= 8.5                         => all_tree_83_c560,
    iv_dob_src_ct = NULL                         => -0.0049958897,
                                                    -0.0049958897);

all_tree_84_c563 := map(
    NULL < nf_phone_ver_insurance AND nf_phone_ver_insurance < 3.5 => 0.0464454335,
    nf_phone_ver_insurance >= 3.5                                  => 0.0119933497,
    nf_phone_ver_insurance = NULL                                  => 0.0214171714,
                                                                      -0.0034039948);

all_tree_84_c562 := map(
    NULL < nf_bus_sos_filings_peradl AND nf_bus_sos_filings_peradl < -0.5 => -0.0034039948,
    nf_bus_sos_filings_peradl >= -0.5                                     => all_tree_84_c563,
    nf_bus_sos_filings_peradl = NULL                                      => 0.0007337936,
                                                                             0.0231566960);

all_tree_84 := map(
    NULL < rv_f00_input_dob_match_level AND rv_f00_input_dob_match_level < 7.5 => 0.0231566960,
    rv_f00_input_dob_match_level >= 7.5                                        => all_tree_84_c562,
    rv_f00_input_dob_match_level = NULL                                        => 0.0013450251,
                                                                                  0.0013450251);

all_tree_85_c566 := map(
    NULL < rv_l70_add_standardized AND rv_l70_add_standardized < 1.5 => -0.0000617846,
    rv_l70_add_standardized >= 1.5                                   => -0.0589192476,
    rv_l70_add_standardized = NULL                                   => -0.0013709428,
                                                                        -0.0013709428);

all_tree_85_c565 := map(
    (iv_prof_license_category in ['-1', '0', '1', '2', '3', '4']) => all_tree_85_c566,
    (iv_prof_license_category in ['', '5'])                       => 0.1085089072,
    iv_prof_license_category = ''                               => -0.0006095949,
                                                                     0.0323310983);

all_tree_85 := map(
    NULL < rv_f00_input_dob_match_level AND rv_f00_input_dob_match_level < 5.5 => 0.0323310983,
    rv_f00_input_dob_match_level >= 5.5                                        => all_tree_85_c565,
    rv_f00_input_dob_match_level = NULL                                        => -0.0004285784,
                                                                                  -0.0004285784);

all_tree_86_c569 := map(
    NULL < nf_inq_curraddr_ver_count AND nf_inq_curraddr_ver_count < 1.5 => 0.0078926809,
    nf_inq_curraddr_ver_count >= 1.5                                     => 0.0806380492,
    nf_inq_curraddr_ver_count = NULL                                     => 0.0302804881,
                                                                            -0.0075905320);

all_tree_86_c568 := map(
    NULL < nf_add_dist_input_to_curr AND nf_add_dist_input_to_curr < 0.5 => -0.0075905320,
    nf_add_dist_input_to_curr >= 0.5                                     => all_tree_86_c569,
    nf_add_dist_input_to_curr = NULL                                     => -0.0048241294,
                                                                            0.0089896646);

all_tree_86 := map(
    NULL < iv_dob_src_ct AND iv_dob_src_ct < 7.5 => 0.0089896646,
    iv_dob_src_ct >= 7.5                         => all_tree_86_c568,
    iv_dob_src_ct = NULL                         => -0.0011932953,
                                                    -0.0011932953);

all_tree_87_c572 := map(
    (iv_f00_email_verification in ['2', '4', '5'])     => -0.0066390096,
    (iv_f00_email_verification in ['', '0', '1', '3']) => 0.0675628242,
    iv_f00_email_verification = ''                   => 0.0339943327,
                                                          0.0339943327);

all_tree_87_c571 := map(
    NULL < iv_nap_inf_phone_ver_lvl AND iv_nap_inf_phone_ver_lvl < 0.5 => all_tree_87_c572,
    iv_nap_inf_phone_ver_lvl >= 0.5                                    => 0.0002106785,
    iv_nap_inf_phone_ver_lvl = NULL                                    => 0.0069423788,
                                                                          -0.0105648198);

all_tree_87 := map(
    NULL < nf_fp_prevaddrageoldest AND nf_fp_prevaddrageoldest < 159.5 => -0.0105648198,
    nf_fp_prevaddrageoldest >= 159.5                                   => all_tree_87_c571,
    nf_fp_prevaddrageoldest = NULL                                     => -0.0037635060,
                                                                          -0.0037635060);

all_tree_88_c575 := map(
    NULL < nf_fp_srchfraudsrchcountyr AND nf_fp_srchfraudsrchcountyr < 2.5 => -0.0063576497,
    nf_fp_srchfraudsrchcountyr >= 2.5                                      => 0.0384031485,
    nf_fp_srchfraudsrchcountyr = NULL                                      => -0.0033938221,
                                                                              0.0280353465);

all_tree_88_c574 := map(
    NULL < nf_inq_ssn_ver_count AND nf_inq_ssn_ver_count < 2.5 => 0.0280353465,
    nf_inq_ssn_ver_count >= 2.5                                => all_tree_88_c575,
    nf_inq_ssn_ver_count = NULL                                => -0.0088033893,
                                                                  0.0005235534);

all_tree_88 := map(
    NULL < iv_input_best_phone_match AND iv_input_best_phone_match < 0.5 => all_tree_88_c574,
    iv_input_best_phone_match >= 0.5                                     => -0.0330518344,
    iv_input_best_phone_match = NULL                                     => -0.0033292879,
                                                                            -0.0033292879);

all_tree_89_c578 := map(
    NULL < rv_c13_curr_addr_lres AND rv_c13_curr_addr_lres < 193.5 => 0.0001884000,
    rv_c13_curr_addr_lres >= 193.5                                 => 0.0856965416,
    rv_c13_curr_addr_lres = NULL                                   => 0.0275238957,
                                                                      0.0275238957);

all_tree_89_c577 := map(
    NULL < rv_f00_inq_corrdobphone_adl AND rv_f00_inq_corrdobphone_adl < 0.5 => all_tree_89_c578,
    rv_f00_inq_corrdobphone_adl >= 0.5                                       => -0.0085960754,
    rv_f00_inq_corrdobphone_adl = NULL                                       => -0.0019610829,
                                                                                -0.0012141308);

all_tree_89 := map(
    ((string)nf_corroboration_risk_index in ['0', '1', '3', '5', '10', '11', '17', '18', '19', '22', '24', '25', '27', '29', '31']) => all_tree_89_c577,
    ((string)nf_corroboration_risk_index in ['8', '9', '12', '13', '14', '16', '20', '21', '23', '28', '30'])                       => 0.0560293879,
    nf_corroboration_risk_index = NULL                                                                                      => -0.0003330004,
                                                                                                                               -0.0003330004);

all_tree_90_c581 := map(
    NULL < rv_l70_add_standardized AND rv_l70_add_standardized < 0.5 => 0.0447105418,
    rv_l70_add_standardized >= 0.5                                   => -0.0494931153,
    rv_l70_add_standardized = NULL                                   => 0.0239732853,
                                                                        0.0239732853);

all_tree_90_c580 := map(
    NULL < nf_corraddrname AND nf_corraddrname < 2.5 => all_tree_90_c581,
    nf_corraddrname >= 2.5                           => -0.0015926501,
    nf_corraddrname = NULL                           => 0.0006374251,
                                                        -0.0166292424);

all_tree_90 := map(
    NULL < iv_dob_src_ct AND iv_dob_src_ct < 0.5 => -0.0166292424,
    iv_dob_src_ct >= 0.5                         => all_tree_90_c580,
    iv_dob_src_ct = NULL                         => 0.0003753639,
                                                    0.0003753639);

all_tree_91_c584 := map(
    ((string)rv_c13_attr_addrs_recency in ['12', '24', '60', '120'])           => -0.0050118327,
    ((string)rv_c13_attr_addrs_recency in ['0', '1', '3', '36', '180', '999']) => 0.1061635859,
    rv_c13_attr_addrs_recency = NULL                                   => 0.0454152140,
                                                                          -0.0066728879);

all_tree_91_c583 := map(
    NULL < nf_inq_per_phone AND nf_inq_per_phone < 4.5 => -0.0066728879,
    nf_inq_per_phone >= 4.5                            => all_tree_91_c584,
    nf_inq_per_phone = NULL                            => -0.0053896614,
                                                          0.0028002248);

all_tree_91 := map(
    NULL < iv_dob_src_ct AND iv_dob_src_ct < 8.5 => 0.0028002248,
    iv_dob_src_ct >= 8.5                         => all_tree_91_c583,
    iv_dob_src_ct = NULL                         => -0.0026846990,
                                                    -0.0026846990);

all_tree_92_c587 := map(
    NULL < nf_corrssnaddr AND nf_corrssnaddr < 2.5 => 0.0282686397,
    nf_corrssnaddr >= 2.5                          => -0.0027886018,
    nf_corrssnaddr = NULL                          => -0.0006448074,
                                                      -0.0006448074);

all_tree_92_c586 := map(
    NULL < rv_l70_add_standardized AND rv_l70_add_standardized < 1.5 => all_tree_92_c587,
    rv_l70_add_standardized >= 1.5                                   => -0.0634078294,
    rv_l70_add_standardized = NULL                                   => -0.0019470852,
                                                                        0.0077691607);

all_tree_92 := map(
    NULL < rv_f00_input_dob_match_level AND rv_f00_input_dob_match_level < 7.5 => 0.0077691607,
    rv_f00_input_dob_match_level >= 7.5                                        => all_tree_92_c586,
    rv_f00_input_dob_match_level = NULL                                        => -0.0016754947,
                                                                                  -0.0016754947);
                                                                                  
                                                                                  

all_gbm_logit := all_tree_0 +
    all_tree_1 +
    all_tree_2 +
    all_tree_3 +
    all_tree_4 +
    all_tree_5 +
    all_tree_6 +
    all_tree_7 +
    all_tree_8 +
    all_tree_9 +
    all_tree_10 +
    all_tree_11 +
    all_tree_12 +
    all_tree_13 +
    all_tree_14 +
    all_tree_15 +
    all_tree_16 +
    all_tree_17 +
    all_tree_18 +
    all_tree_19 +
    all_tree_20 +
    all_tree_21 +
    all_tree_22 +
    all_tree_23 +
    all_tree_24 +
    all_tree_25 +
    all_tree_26 +
    all_tree_27 +
    all_tree_28 +
    all_tree_29 +
    all_tree_30 +
    all_tree_31 +
    all_tree_32 +
    all_tree_33 +
    all_tree_34 +
    all_tree_35 +
    all_tree_36 +
    all_tree_37 +
    all_tree_38 +
    all_tree_39 +
    all_tree_40 +
    all_tree_41 +
    all_tree_42 +
    all_tree_43 +
    all_tree_44 +
    all_tree_45 +
    all_tree_46 +
    all_tree_47 +
    all_tree_48 +
    all_tree_49 +
    all_tree_50 +
    all_tree_51 +
    all_tree_52 +
    all_tree_53 +
    all_tree_54 +
    all_tree_55 +
    all_tree_56 +
    all_tree_57 +
    all_tree_58 +
    all_tree_59 +
    all_tree_60 +
    all_tree_61 +
    all_tree_62 +
    all_tree_63 +
    all_tree_64 +
    all_tree_65 +
    all_tree_66 +
    all_tree_67 +
    all_tree_68 +
    all_tree_69 +
    all_tree_70 +
    all_tree_71 +
    all_tree_72 +
    all_tree_73 +
    all_tree_74 +
    all_tree_75 +
    all_tree_76 +
    all_tree_77 +
    all_tree_78 +
    all_tree_79 +
    all_tree_80 +
    all_tree_81 +
    all_tree_82 +
    all_tree_83 +
    all_tree_84 +
    all_tree_85 +
    all_tree_86 +
    all_tree_87 +
    all_tree_88 +
    all_tree_89 +
    all_tree_90 +
    all_tree_91 +
    all_tree_92;




pbr := 0.05;

sbr := 0.1;

base := 750;

pts := -50;

lgt := ln(sbr / (1 - sbr));

offset := ln(((1 - pbr) * sbr) / (pbr * (1 - sbr)));

fp1806_1_0 := min(if(max(round(base + pts * (all_gbm_logit - offset - lgt) / ln(2)), 300) = NULL, -NULL, max(round(base + pts * (all_gbm_logit - offset - lgt) / ln(2)), 300)), 999);

_ver_src_ds := Models.Common.findw_cpp(ver_sources, 'DS' , ',', '') > 0;

_ver_src_de := Models.Common.findw_cpp(ver_sources, 'DE' , ',', '') > 0;

_derog := felony_count > 0 OR (integer)addrs_prison_history > 0 OR attr_num_unrel_liens60 > 0 OR attr_eviction_count > 0 OR stl_inq_count > 0 OR inq_highriskcredit_count12 > 0 OR inq_collection_count12 >= 2;

_deceased := rc_decsflag = '1' OR rc_ssndod != 0 OR _ver_src_ds OR _ver_src_de;

_ssnpriortodob := rc_ssndobflag = '1' OR rc_pwssndobflag = '1';

  _inputmiskeys :=             rc_ssnmiskeyflag or rc_addrmiskeyflag or (integer)add_input_house_number_match = 0;
//_inputmiskeys := __common__( rc_ssnmiskeyflag or rc_addrmiskeyflag or (integer)add_input_house_number_match = 0 );

_multiplessns   :=             ssns_per_adl >= 2 OR ssns_per_adl_c6 >= 1 OR invalid_ssns_per_adl >= 1;
//_multiplessns := __common__( ssns_per_adl >= 2 OR ssns_per_adl_c6 >= 1 OR invalid_ssns_per_adl >= 1 );

_hh_strikes := if((integer)max((integer)hh_members_w_derog > 0, 
                      (integer)hh_criminals > 0, 
                      (integer)hh_payday_loan_users > 0) = NULL, NULL, 
                      (integer)sum((integer)hh_members_w_derog > 0, (integer)hh_criminals > 0, (integer)hh_payday_loan_users > 0));

stolenid := if(addrpop and (nas_summary in [4, 7, 9]) or fnamepop and lnamepop and addrpop and 1 <= nas_summary AND nas_summary <= 9 and inq_count03 > 0 and (integer)ssnlength = 9 or _deceased or _ssnpriortodob, 1, 0);

manipulatedid                := if(_inputmiskeys and (_multiplessns or lnames_per_adl_c6 > 1), 1, 0);
//manipulatedid := __common__( if(_inputmiskeys and (_multiplessns or lnames_per_adl_c6 > 1), 1, 0) );

manipulatedidpt2 := if(1 <= nas_summary AND nas_summary <= 9 and inq_count03 > 0 and (integer)ssnlength = 9, 1, 0);

_sum_bureau := if(max((integer)ver_src_eq, (integer)ver_src_en, (integer)ver_src_tn) = NULL, NULL, sum((integer)ver_src_eq, (integer)ver_src_en, (integer)ver_src_tn));

_sum_credentialed := if(max((integer)ver_src_ar, (integer)ver_src_am, (integer)ver_src_ba, (integer)ver_src_cg, (integer)ver_src_da, (integer)ver_src_d, (integer)ver_src_dl, (integer)ver_src_eb, (integer)ver_src_e1, (integer)ver_src_e2, (integer)ver_src_e3, (integer)ver_src_fe, (integer)ver_src_ff, (integer)ver_src_p, (integer)ver_src_pl, (integer)ver_src_sl, (integer)ver_src_v, (integer)ver_src_vo, (integer)ver_src_w) = NULL, NULL, sum((integer)ver_src_ar, (integer)ver_src_am, (integer)ver_src_ba, (integer)ver_src_cg, (integer)ver_src_da, (integer)ver_src_d, (integer)ver_src_dl, (integer)ver_src_eb, (integer)ver_src_e1, (integer)ver_src_e2, (integer)ver_src_e3, (integer)ver_src_fe, (integer)ver_src_ff, (integer)ver_src_p, (integer)ver_src_pl, (integer)ver_src_sl, (integer)ver_src_v, (integer)ver_src_vo, (integer)ver_src_w));

syntheticid := _sum_credentialed = 0 and _sum_bureau > 0 and rv_a41_a42_prop_owner_history = 0 OR (integer)truedid = 0;

suspiciousactivity := if(_derog, 1, 0);

vulnerablevictim := if(0 < inferred_age AND inferred_age <= 17 or inferred_age >= 70, 1, 0);

friendlyfraud := if(hh_members_ct > 1 and (hh_payday_loan_users > 0 or _hh_strikes >= 2 or rel_felony_count >= 2), 1, 0);

stolenc_fp1806_1_0 := if((boolean)stolenid, fp1806_1_0, 299);

manip2c_fp1806_1_0 := if((boolean)(integer)manipulatedid or (boolean)(integer)manipulatedidpt2, fp1806_1_0, 299);

synthc_fp1806_1_0 := if(syntheticid, fp1806_1_0, 299);

suspactc_fp1806_1_0 := if((boolean)suspiciousactivity, fp1806_1_0, 299);

vulnvicc_fp1806_1_0 := if((boolean)vulnerablevictim, fp1806_1_0, 299);

friendlyc_fp1806_1_0 := if((boolean)friendlyfraud, fp1806_1_0, 299);

fp1806_1_0_stolidindex := map(
    stolenc_fp1806_1_0 = 299                                => 1,
    300 <= stolenc_fp1806_1_0 AND stolenc_fp1806_1_0 <= 469 => 9,
    470 <= stolenc_fp1806_1_0 AND stolenc_fp1806_1_0 <= 516 => 8,
    517 <= stolenc_fp1806_1_0 AND stolenc_fp1806_1_0 <= 556 => 7,
    557 <= stolenc_fp1806_1_0 AND stolenc_fp1806_1_0 <= 581 => 6,
    582 <= stolenc_fp1806_1_0 AND stolenc_fp1806_1_0 <= 625 => 5,
    626 <= stolenc_fp1806_1_0 AND stolenc_fp1806_1_0 <= 658 => 4,
    659 <= stolenc_fp1806_1_0 AND stolenc_fp1806_1_0 <= 773 => 3,
                                                               2);

fp1806_1_0_synthidindex := map(
    synthc_fp1806_1_0 = 299                               => 1,
    300 <= synthc_fp1806_1_0 AND synthc_fp1806_1_0 <= 512 => 9,
    513 <= synthc_fp1806_1_0 AND synthc_fp1806_1_0 <= 562 => 8,
    563 <= synthc_fp1806_1_0 AND synthc_fp1806_1_0 <= 602 => 7,
    603 <= synthc_fp1806_1_0 AND synthc_fp1806_1_0 <= 667 => 6,
    668 <= synthc_fp1806_1_0 AND synthc_fp1806_1_0 <= 689 => 5,
    690 <= synthc_fp1806_1_0 AND synthc_fp1806_1_0 <= 765 => 4,
    766 <= synthc_fp1806_1_0 AND synthc_fp1806_1_0 <= 849 => 3,
                                                             2);

fp1806_1_0_manipidindex := map(
    manip2c_fp1806_1_0 = 299                                => 1,
    300 <= manip2c_fp1806_1_0 AND manip2c_fp1806_1_0 <= 512 => 9,
    513 <= manip2c_fp1806_1_0 AND manip2c_fp1806_1_0 <= 532 => 8,
    533 <= manip2c_fp1806_1_0 AND manip2c_fp1806_1_0 <= 579 => 7,
    580 <= manip2c_fp1806_1_0 AND manip2c_fp1806_1_0 <= 624 => 6,
    625 <= manip2c_fp1806_1_0 AND manip2c_fp1806_1_0 <= 714 => 5,
    715 <= manip2c_fp1806_1_0 AND manip2c_fp1806_1_0 <= 795 => 4,
    796 <= manip2c_fp1806_1_0 AND manip2c_fp1806_1_0 <= 815 => 3,
                                                               2);

fp1806_1_0_vulnvicindex := map(
    vulnvicc_fp1806_1_0 = 299                                 => 1,
    300 <= vulnvicc_fp1806_1_0 AND vulnvicc_fp1806_1_0 <= 486 => 9,
    487 <= vulnvicc_fp1806_1_0 AND vulnvicc_fp1806_1_0 <= 572 => 8,
    573 <= vulnvicc_fp1806_1_0 AND vulnvicc_fp1806_1_0 <= 653 => 7,
    654 <= vulnvicc_fp1806_1_0 AND vulnvicc_fp1806_1_0 <= 687 => 6,
    688 <= vulnvicc_fp1806_1_0 AND vulnvicc_fp1806_1_0 <= 739 => 5,
    740 <= vulnvicc_fp1806_1_0 AND vulnvicc_fp1806_1_0 <= 783 => 4,
    784 <= vulnvicc_fp1806_1_0 AND vulnvicc_fp1806_1_0 <= 800 => 3,
                                                                 2);

fp1806_1_0_friendfrdindex := map(
    friendlyc_fp1806_1_0 = 299                                  => 1,
    300 <= friendlyc_fp1806_1_0 AND friendlyc_fp1806_1_0 <= 580 => 9,
    581 <= friendlyc_fp1806_1_0 AND friendlyc_fp1806_1_0 <= 641 => 8,
    642 <= friendlyc_fp1806_1_0 AND friendlyc_fp1806_1_0 <= 696 => 7,
    697 <= friendlyc_fp1806_1_0 AND friendlyc_fp1806_1_0 <= 719 => 6,
    720 <= friendlyc_fp1806_1_0 AND friendlyc_fp1806_1_0 <= 753 => 5,
    754 <= friendlyc_fp1806_1_0 AND friendlyc_fp1806_1_0 <= 779 => 4,
    780 <= friendlyc_fp1806_1_0 AND friendlyc_fp1806_1_0 <= 834 => 3,
                                                                   2);

fp1806_1_0_suspactindex := map(
    suspactc_fp1806_1_0 = 299                                 => 1,
    300 <= suspactc_fp1806_1_0 AND suspactc_fp1806_1_0 <= 528 => 9,
    529 <= suspactc_fp1806_1_0 AND suspactc_fp1806_1_0 <= 659 => 8,
    660 <= suspactc_fp1806_1_0 AND suspactc_fp1806_1_0 <= 694 => 7,
    695 <= suspactc_fp1806_1_0 AND suspactc_fp1806_1_0 <= 738 => 6,
    739 <= suspactc_fp1806_1_0 AND suspactc_fp1806_1_0 <= 768 => 5,
    769 <= suspactc_fp1806_1_0 AND suspactc_fp1806_1_0 <= 857 => 4,
    858 <= suspactc_fp1806_1_0 AND suspactc_fp1806_1_0 <= 875 => 3,
                                                                 2);
                                                                 
                                                                 
   
   //*************************************************************************************//
//     End Generated ECL Code
//*************************************************************************************//

	#if(FP_DEBUG)
		/* Model Input Variables */
                    self.sysdate                          := sysdate;
                    self.ver_src_ak_pos                   := ver_src_ak_pos;
                    self.ver_src_ak                       := ver_src_ak;
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
                    self.ver_src_cy_pos                   := ver_src_cy_pos;
                    self.ver_src_cy                       := ver_src_cy;
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
                    self.ver_src_eb_pos                   := ver_src_eb_pos;
                    self.ver_src_eb                       := ver_src_eb;
                    self._ver_src_fdate_eb                := _ver_src_fdate_eb;
                    self.ver_src_fdate_eb                 := ver_src_fdate_eb;
                    self.ver_src_em_pos                   := ver_src_em_pos;
                    self.ver_src_em                       := ver_src_em;
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
                    self.ver_src_fr                       := ver_src_fr;
                    self.ver_src_l2_pos                   := ver_src_l2_pos;
                    self.ver_src_l2                       := ver_src_l2;
                    self.ver_src_li_pos                   := ver_src_li_pos;
                    self.ver_src_li                       := ver_src_li;
                    self.ver_src_mw_pos                   := ver_src_mw_pos;
                    self.ver_src_mw                       := ver_src_mw;
                    self.ver_src_nt_pos                   := ver_src_nt_pos;
                    self.ver_src_nt                       := ver_src_nt;
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
                    self.ver_dob_src_ak_pos               := ver_dob_src_ak_pos;
                    self.ver_dob_src_ak                   := ver_dob_src_ak;
                    self.ver_dob_src_am_pos               := ver_dob_src_am_pos;
                    self.ver_dob_src_am                   := ver_dob_src_am;
                    self.ver_dob_src_ar_pos               := ver_dob_src_ar_pos;
                    self.ver_dob_src_ar                   := ver_dob_src_ar;
                    self.ver_dob_src_ba_pos               := ver_dob_src_ba_pos;
                    self.ver_dob_src_ba                   := ver_dob_src_ba;
                    self.ver_dob_src_cg_pos               := ver_dob_src_cg_pos;
                    self.ver_dob_src_cg                   := ver_dob_src_cg;
                    self.ver_dob_src_cy_pos               := ver_dob_src_cy_pos;
                    self.ver_dob_src_cy                   := ver_dob_src_cy;
                    self.ver_dob_src_da_pos               := ver_dob_src_da_pos;
                    self.ver_dob_src_da                   := ver_dob_src_da;
                    self.ver_dob_src_d_pos                := ver_dob_src_d_pos;
                    self.ver_dob_src_d                    := ver_dob_src_d;
                    self.ver_dob_src_dl_pos               := ver_dob_src_dl_pos;
                    self.ver_dob_src_dl                   := ver_dob_src_dl;
                    self.ver_dob_src_eb_pos               := ver_dob_src_eb_pos;
                    self.ver_dob_src_eb                   := ver_dob_src_eb;
                    self.ver_dob_src_em_pos               := ver_dob_src_em_pos;
                    self.ver_dob_src_em                   := ver_dob_src_em;
                    self.ver_dob_src_e1_pos               := ver_dob_src_e1_pos;
                    self.ver_dob_src_e1                   := ver_dob_src_e1;
                    self.ver_dob_src_e2_pos               := ver_dob_src_e2_pos;
                    self.ver_dob_src_e2                   := ver_dob_src_e2;
                    self.ver_dob_src_e3_pos               := ver_dob_src_e3_pos;
                    self.ver_dob_src_e3                   := ver_dob_src_e3;
                    self.ver_dob_src_e4_pos               := ver_dob_src_e4_pos;
                    self.ver_dob_src_e4                   := ver_dob_src_e4;
                    self.ver_dob_src_en_pos               := ver_dob_src_en_pos;
                    self.ver_dob_src_en                   := ver_dob_src_en;
                    self.ver_dob_src_eq_pos               := ver_dob_src_eq_pos;
                    self.ver_dob_src_eq                   := ver_dob_src_eq;
                    self.ver_dob_src_fe_pos               := ver_dob_src_fe_pos;
                    self.ver_dob_src_fe                   := ver_dob_src_fe;
                    self.ver_dob_src_ff_pos               := ver_dob_src_ff_pos;
                    self.ver_dob_src_ff                   := ver_dob_src_ff;
                    self.ver_dob_src_fr_pos               := ver_dob_src_fr_pos;
                    self.ver_dob_src_fr                   := ver_dob_src_fr;
                    self.ver_dob_src_l2_pos               := ver_dob_src_l2_pos;
                    self.ver_dob_src_l2                   := ver_dob_src_l2;
                    self.ver_dob_src_li_pos               := ver_dob_src_li_pos;
                    self.ver_dob_src_li                   := ver_dob_src_li;
                    self.ver_dob_src_mw_pos               := ver_dob_src_mw_pos;
                    self.ver_dob_src_mw                   := ver_dob_src_mw;
                    self.ver_dob_src_nt_pos               := ver_dob_src_nt_pos;
                    self.ver_dob_src_nt                   := ver_dob_src_nt;
                    self.ver_dob_src_p_pos                := ver_dob_src_p_pos;
                    self.ver_dob_src_p                    := ver_dob_src_p;
                    self.ver_dob_src_pl_pos               := ver_dob_src_pl_pos;
                    self.ver_dob_src_pl                   := ver_dob_src_pl;
                    self.ver_dob_src_tn_pos               := ver_dob_src_tn_pos;
                    self.ver_dob_src_tn                   := ver_dob_src_tn;
                    self.ver_dob_src_sl_pos               := ver_dob_src_sl_pos;
                    self.ver_dob_src_sl                   := ver_dob_src_sl;
                    self.ver_dob_src_v_pos                := ver_dob_src_v_pos;
                    self.ver_dob_src_v                    := ver_dob_src_v;
                    self.ver_dob_src_vo_pos               := ver_dob_src_vo_pos;
                    self.ver_dob_src_vo                   := ver_dob_src_vo;
                    self.ver_dob_src_w_pos                := ver_dob_src_w_pos;
                    self.ver_dob_src_w                    := ver_dob_src_w;
                    self.ver_dob_src_wp_pos               := ver_dob_src_wp_pos;
                    self.ver_dob_src_wp                   := ver_dob_src_wp;
                    self.iv_add_apt                       := iv_add_apt;
                    self.iv_dob_src_ct                    := iv_dob_src_ct;
                    self.nf_phone_ver_experian            := nf_phone_ver_experian;
                    self.nf_invbest_inq_perphone_diff     := nf_invbest_inq_perphone_diff;
                    self.iv_nap_inf_phone_ver_lvl         := iv_nap_inf_phone_ver_lvl;
                    self.rv_f00_input_dob_match_level     := rv_f00_input_dob_match_level;
                    self.corrssnname_src_ak_pos           := corrssnname_src_ak_pos;
                    self.corrssnname_src_ak               := corrssnname_src_ak;
                    self.corrssnname_src_am_pos           := corrssnname_src_am_pos;
                    self.corrssnname_src_am               := corrssnname_src_am;
                    self.corrssnname_src_ar_pos           := corrssnname_src_ar_pos;
                    self.corrssnname_src_ar               := corrssnname_src_ar;
                    self.corrssnname_src_ba_pos           := corrssnname_src_ba_pos;
                    self.corrssnname_src_ba               := corrssnname_src_ba;
                    self.corrssnname_src_cg_pos           := corrssnname_src_cg_pos;
                    self.corrssnname_src_cg               := corrssnname_src_cg;
                    self.corrssnname_src_co_pos           := corrssnname_src_co_pos;
                    self.corrssnname_src_co               := corrssnname_src_co;
                    self.corrssnname_src_cy_pos           := corrssnname_src_cy_pos;
                    self.corrssnname_src_cy               := corrssnname_src_cy;
                    self.corrssnname_src_da_pos           := corrssnname_src_da_pos;
                    self.corrssnname_src_da               := corrssnname_src_da;
                    self.corrssnname_src_d_pos            := corrssnname_src_d_pos;
                    self.corrssnname_src_d                := corrssnname_src_d;
                    self.corrssnname_src_dl_pos           := corrssnname_src_dl_pos;
                    self.corrssnname_src_dl               := corrssnname_src_dl;
                    self.corrssnname_src_ds_pos           := corrssnname_src_ds_pos;
                    self.corrssnname_src_ds               := corrssnname_src_ds;
                    self.corrssnname_src_de_pos           := corrssnname_src_de_pos;
                    self.corrssnname_src_de               := corrssnname_src_de;
                    self.corrssnname_src_eb_pos           := corrssnname_src_eb_pos;
                    self.corrssnname_src_eb               := corrssnname_src_eb;
                    self.corrssnname_src_em_pos           := corrssnname_src_em_pos;
                    self.corrssnname_src_em               := corrssnname_src_em;
                    self.corrssnname_src_e1_pos           := corrssnname_src_e1_pos;
                    self.corrssnname_src_e1               := corrssnname_src_e1;
                    self.corrssnname_src_e2_pos           := corrssnname_src_e2_pos;
                    self.corrssnname_src_e2               := corrssnname_src_e2;
                    self.corrssnname_src_e3_pos           := corrssnname_src_e3_pos;
                    self.corrssnname_src_e3               := corrssnname_src_e3;
                    self.corrssnname_src_e4_pos           := corrssnname_src_e4_pos;
                    self.corrssnname_src_e4               := corrssnname_src_e4;
                    self.corrssnname_src_en_pos           := corrssnname_src_en_pos;
                    self.corrssnname_src_en               := corrssnname_src_en;
                    self.corrssnname_src_eq_pos           := corrssnname_src_eq_pos;
                    self.corrssnname_src_eq               := corrssnname_src_eq;
                    self.corrssnname_src_fe_pos           := corrssnname_src_fe_pos;
                    self.corrssnname_src_fe               := corrssnname_src_fe;
                    self.corrssnname_src_ff_pos           := corrssnname_src_ff_pos;
                    self.corrssnname_src_ff               := corrssnname_src_ff;
                    self.corrssnname_src_fr_pos           := corrssnname_src_fr_pos;
                    self.corrssnname_src_fr               := corrssnname_src_fr;
                    self.corrssnname_src_l2_pos           := corrssnname_src_l2_pos;
                    self.corrssnname_src_l2               := corrssnname_src_l2;
                    self.corrssnname_src_li_pos           := corrssnname_src_li_pos;
                    self.corrssnname_src_li               := corrssnname_src_li;
                    self.corrssnname_src_mw_pos           := corrssnname_src_mw_pos;
                    self.corrssnname_src_mw               := corrssnname_src_mw;
                    self.corrssnname_src_nt_pos           := corrssnname_src_nt_pos;
                    self.corrssnname_src_nt               := corrssnname_src_nt;
                    self.corrssnname_src_p_pos            := corrssnname_src_p_pos;
                    self.corrssnname_src_p                := corrssnname_src_p;
                    self.corrssnname_src_pl_pos           := corrssnname_src_pl_pos;
                    self.corrssnname_src_pl               := corrssnname_src_pl;
                    self.corrssnname_src_tn_pos           := corrssnname_src_tn_pos;
                    self.corrssnname_src_tn               := corrssnname_src_tn;
                    self.corrssnname_src_ts_pos           := corrssnname_src_ts_pos;
                    self.corrssnname_src_ts               := corrssnname_src_ts;
                    self.corrssnname_src_tu_pos           := corrssnname_src_tu_pos;
                    self.corrssnname_src_tu               := corrssnname_src_tu;
                    self.corrssnname_src_sl_pos           := corrssnname_src_sl_pos;
                    self.corrssnname_src_sl               := corrssnname_src_sl;
                    self.corrssnname_src_v_pos            := corrssnname_src_v_pos;
                    self.corrssnname_src_v                := corrssnname_src_v;
                    self.corrssnname_src_vo_pos           := corrssnname_src_vo_pos;
                    self.corrssnname_src_vo               := corrssnname_src_vo;
                    self.corrssnname_src_w_pos            := corrssnname_src_w_pos;
                    self.corrssnname_src_w                := corrssnname_src_w;
                    self.corrssnname_src_wp_pos           := corrssnname_src_wp_pos;
                    self.corrssnname_src_wp               := corrssnname_src_wp;
                    self.corrssnname_ct                   := corrssnname_ct;
                    self.nf_corrssnname                   := nf_corrssnname;
                    self.corrssnaddr_src_ak_pos           := corrssnaddr_src_ak_pos;
                    self.corrssnaddr_src_ak               := corrssnaddr_src_ak;
                    self.corrssnaddr_src_am_pos           := corrssnaddr_src_am_pos;
                    self.corrssnaddr_src_am               := corrssnaddr_src_am;
                    self.corrssnaddr_src_ar_pos           := corrssnaddr_src_ar_pos;
                    self.corrssnaddr_src_ar               := corrssnaddr_src_ar;
                    self.corrssnaddr_src_ba_pos           := corrssnaddr_src_ba_pos;
                    self.corrssnaddr_src_ba               := corrssnaddr_src_ba;
                    self.corrssnaddr_src_cg_pos           := corrssnaddr_src_cg_pos;
                    self.corrssnaddr_src_cg               := corrssnaddr_src_cg;
                    self.corrssnaddr_src_co_pos           := corrssnaddr_src_co_pos;
                    self.corrssnaddr_src_co               := corrssnaddr_src_co;
                    self.corrssnaddr_src_cy_pos           := corrssnaddr_src_cy_pos;
                    self.corrssnaddr_src_cy               := corrssnaddr_src_cy;
                    self.corrssnaddr_src_da_pos           := corrssnaddr_src_da_pos;
                    self.corrssnaddr_src_da               := corrssnaddr_src_da;
                    self.corrssnaddr_src_d_pos            := corrssnaddr_src_d_pos;
                    self.corrssnaddr_src_d                := corrssnaddr_src_d;
                    self.corrssnaddr_src_dl_pos           := corrssnaddr_src_dl_pos;
                    self.corrssnaddr_src_dl               := corrssnaddr_src_dl;
                    self.corrssnaddr_src_ds_pos           := corrssnaddr_src_ds_pos;
                    self.corrssnaddr_src_ds               := corrssnaddr_src_ds;
                    self.corrssnaddr_src_de_pos           := corrssnaddr_src_de_pos;
                    self.corrssnaddr_src_de               := corrssnaddr_src_de;
                    self.corrssnaddr_src_eb_pos           := corrssnaddr_src_eb_pos;
                    self.corrssnaddr_src_eb               := corrssnaddr_src_eb;
                    self.corrssnaddr_src_em_pos           := corrssnaddr_src_em_pos;
                    self.corrssnaddr_src_em               := corrssnaddr_src_em;
                    self.corrssnaddr_src_e1_pos           := corrssnaddr_src_e1_pos;
                    self.corrssnaddr_src_e1               := corrssnaddr_src_e1;
                    self.corrssnaddr_src_e2_pos           := corrssnaddr_src_e2_pos;
                    self.corrssnaddr_src_e2               := corrssnaddr_src_e2;
                    self.corrssnaddr_src_e3_pos           := corrssnaddr_src_e3_pos;
                    self.corrssnaddr_src_e3               := corrssnaddr_src_e3;
                    self.corrssnaddr_src_e4_pos           := corrssnaddr_src_e4_pos;
                    self.corrssnaddr_src_e4               := corrssnaddr_src_e4;
                    self.corrssnaddr_src_en_pos           := corrssnaddr_src_en_pos;
                    self.corrssnaddr_src_en               := corrssnaddr_src_en;
                    self.corrssnaddr_src_eq_pos           := corrssnaddr_src_eq_pos;
                    self.corrssnaddr_src_eq               := corrssnaddr_src_eq;
                    self.corrssnaddr_src_fe_pos           := corrssnaddr_src_fe_pos;
                    self.corrssnaddr_src_fe               := corrssnaddr_src_fe;
                    self.corrssnaddr_src_ff_pos           := corrssnaddr_src_ff_pos;
                    self.corrssnaddr_src_ff               := corrssnaddr_src_ff;
                    self.corrssnaddr_src_fr_pos           := corrssnaddr_src_fr_pos;
                    self.corrssnaddr_src_fr               := corrssnaddr_src_fr;
                    self.corrssnaddr_src_l2_pos           := corrssnaddr_src_l2_pos;
                    self.corrssnaddr_src_l2               := corrssnaddr_src_l2;
                    self.corrssnaddr_src_li_pos           := corrssnaddr_src_li_pos;
                    self.corrssnaddr_src_li               := corrssnaddr_src_li;
                    self.corrssnaddr_src_mw_pos           := corrssnaddr_src_mw_pos;
                    self.corrssnaddr_src_mw               := corrssnaddr_src_mw;
                    self.corrssnaddr_src_nt_pos           := corrssnaddr_src_nt_pos;
                    self.corrssnaddr_src_nt               := corrssnaddr_src_nt;
                    self.corrssnaddr_src_p_pos            := corrssnaddr_src_p_pos;
                    self.corrssnaddr_src_p                := corrssnaddr_src_p;
                    self.corrssnaddr_src_pl_pos           := corrssnaddr_src_pl_pos;
                    self.corrssnaddr_src_pl               := corrssnaddr_src_pl;
                    self.corrssnaddr_src_tn_pos           := corrssnaddr_src_tn_pos;
                    self.corrssnaddr_src_tn               := corrssnaddr_src_tn;
                    self.corrssnaddr_src_ts_pos           := corrssnaddr_src_ts_pos;
                    self.corrssnaddr_src_ts               := corrssnaddr_src_ts;
                    self.corrssnaddr_src_tu_pos           := corrssnaddr_src_tu_pos;
                    self.corrssnaddr_src_tu               := corrssnaddr_src_tu;
                    self.corrssnaddr_src_sl_pos           := corrssnaddr_src_sl_pos;
                    self.corrssnaddr_src_sl               := corrssnaddr_src_sl;
                    self.corrssnaddr_src_v_pos            := corrssnaddr_src_v_pos;
                    self.corrssnaddr_src_v                := corrssnaddr_src_v;
                    self.corrssnaddr_src_vo_pos           := corrssnaddr_src_vo_pos;
                    self.corrssnaddr_src_vo               := corrssnaddr_src_vo;
                    self.corrssnaddr_src_w_pos            := corrssnaddr_src_w_pos;
                    self.corrssnaddr_src_w                := corrssnaddr_src_w;
                    self.corrssnaddr_src_wp_pos           := corrssnaddr_src_wp_pos;
                    self.corrssnaddr_src_wp               := corrssnaddr_src_wp;
                    self.corrssnaddr_ct                   := corrssnaddr_ct;
                    self.nf_corrssnaddr                   := nf_corrssnaddr;
                    self.corraddrname_src_ak_pos          := corraddrname_src_ak_pos;
                    self.corraddrname_src_ak              := corraddrname_src_ak;
                    self.corraddrname_src_am_pos          := corraddrname_src_am_pos;
                    self.corraddrname_src_am              := corraddrname_src_am;
                    self.corraddrname_src_ar_pos          := corraddrname_src_ar_pos;
                    self.corraddrname_src_ar              := corraddrname_src_ar;
                    self.corraddrname_src_ba_pos          := corraddrname_src_ba_pos;
                    self.corraddrname_src_ba              := corraddrname_src_ba;
                    self.corraddrname_src_cg_pos          := corraddrname_src_cg_pos;
                    self.corraddrname_src_cg              := corraddrname_src_cg;
                    self.corraddrname_src_co_pos          := corraddrname_src_co_pos;
                    self.corraddrname_src_co              := corraddrname_src_co;
                    self.corraddrname_src_cy_pos          := corraddrname_src_cy_pos;
                    self.corraddrname_src_cy              := corraddrname_src_cy;
                    self.corraddrname_src_da_pos          := corraddrname_src_da_pos;
                    self.corraddrname_src_da              := corraddrname_src_da;
                    self.corraddrname_src_d_pos           := corraddrname_src_d_pos;
                    self.corraddrname_src_d               := corraddrname_src_d;
                    self.corraddrname_src_dl_pos          := corraddrname_src_dl_pos;
                    self.corraddrname_src_dl              := corraddrname_src_dl;
                    self.corraddrname_src_ds_pos          := corraddrname_src_ds_pos;
                    self.corraddrname_src_ds              := corraddrname_src_ds;
                    self.corraddrname_src_de_pos          := corraddrname_src_de_pos;
                    self.corraddrname_src_de              := corraddrname_src_de;
                    self.corraddrname_src_eb_pos          := corraddrname_src_eb_pos;
                    self.corraddrname_src_eb              := corraddrname_src_eb;
                    self.corraddrname_src_em_pos          := corraddrname_src_em_pos;
                    self.corraddrname_src_em              := corraddrname_src_em;
                    self.corraddrname_src_e1_pos          := corraddrname_src_e1_pos;
                    self.corraddrname_src_e1              := corraddrname_src_e1;
                    self.corraddrname_src_e2_pos          := corraddrname_src_e2_pos;
                    self.corraddrname_src_e2              := corraddrname_src_e2;
                    self.corraddrname_src_e3_pos          := corraddrname_src_e3_pos;
                    self.corraddrname_src_e3              := corraddrname_src_e3;
                    self.corraddrname_src_e4_pos          := corraddrname_src_e4_pos;
                    self.corraddrname_src_e4              := corraddrname_src_e4;
                    self.corraddrname_src_en_pos          := corraddrname_src_en_pos;
                    self.corraddrname_src_en              := corraddrname_src_en;
                    self.corraddrname_src_eq_pos          := corraddrname_src_eq_pos;
                    self.corraddrname_src_eq              := corraddrname_src_eq;
                    self.corraddrname_src_fe_pos          := corraddrname_src_fe_pos;
                    self.corraddrname_src_fe              := corraddrname_src_fe;
                    self.corraddrname_src_ff_pos          := corraddrname_src_ff_pos;
                    self.corraddrname_src_ff              := corraddrname_src_ff;
                    self.corraddrname_src_fr_pos          := corraddrname_src_fr_pos;
                    self.corraddrname_src_fr              := corraddrname_src_fr;
                    self.corraddrname_src_l2_pos          := corraddrname_src_l2_pos;
                    self.corraddrname_src_l2              := corraddrname_src_l2;
                    self.corraddrname_src_li_pos          := corraddrname_src_li_pos;
                    self.corraddrname_src_li              := corraddrname_src_li;
                    self.corraddrname_src_mw_pos          := corraddrname_src_mw_pos;
                    self.corraddrname_src_mw              := corraddrname_src_mw;
                    self.corraddrname_src_nt_pos          := corraddrname_src_nt_pos;
                    self.corraddrname_src_nt              := corraddrname_src_nt;
                    self.corraddrname_src_p_pos           := corraddrname_src_p_pos;
                    self.corraddrname_src_p               := corraddrname_src_p;
                    self.corraddrname_src_pl_pos          := corraddrname_src_pl_pos;
                    self.corraddrname_src_pl              := corraddrname_src_pl;
                    self.corraddrname_src_tn_pos          := corraddrname_src_tn_pos;
                    self.corraddrname_src_tn              := corraddrname_src_tn;
                    self.corraddrname_src_ts_pos          := corraddrname_src_ts_pos;
                    self.corraddrname_src_ts              := corraddrname_src_ts;
                    self.corraddrname_src_tu_pos          := corraddrname_src_tu_pos;
                    self.corraddrname_src_tu              := corraddrname_src_tu;
                    self.corraddrname_src_sl_pos          := corraddrname_src_sl_pos;
                    self.corraddrname_src_sl              := corraddrname_src_sl;
                    self.corraddrname_src_v_pos           := corraddrname_src_v_pos;
                    self.corraddrname_src_v               := corraddrname_src_v;
                    self.corraddrname_src_vo_pos          := corraddrname_src_vo_pos;
                    self.corraddrname_src_vo              := corraddrname_src_vo;
                    self.corraddrname_src_w_pos           := corraddrname_src_w_pos;
                    self.corraddrname_src_w               := corraddrname_src_w;
                    self.corraddrname_src_wp_pos          := corraddrname_src_wp_pos;
                    self.corraddrname_src_wp              := corraddrname_src_wp;
                    self.corraddrname_ct                  := corraddrname_ct;
                    self.nf_corraddrname                  := nf_corraddrname;
                    self.corraddrphone_src_ak_pos         := corraddrphone_src_ak_pos;
                    self.corraddrphone_src_ak             := corraddrphone_src_ak;
                    self.corraddrphone_src_am_pos         := corraddrphone_src_am_pos;
                    self.corraddrphone_src_am             := corraddrphone_src_am;
                    self.corraddrphone_src_ar_pos         := corraddrphone_src_ar_pos;
                    self.corraddrphone_src_ar             := corraddrphone_src_ar;
                    self.corraddrphone_src_ba_pos         := corraddrphone_src_ba_pos;
                    self.corraddrphone_src_ba             := corraddrphone_src_ba;
                    self.corraddrphone_src_cg_pos         := corraddrphone_src_cg_pos;
                    self.corraddrphone_src_cg             := corraddrphone_src_cg;
                    self.corraddrphone_src_co_pos         := corraddrphone_src_co_pos;
                    self.corraddrphone_src_co             := corraddrphone_src_co;
                    self.corraddrphone_src_cy_pos         := corraddrphone_src_cy_pos;
                    self.corraddrphone_src_cy             := corraddrphone_src_cy;
                    self.corraddrphone_src_da_pos         := corraddrphone_src_da_pos;
                    self.corraddrphone_src_da             := corraddrphone_src_da;
                    self.corraddrphone_src_d_pos          := corraddrphone_src_d_pos;
                    self.corraddrphone_src_d              := corraddrphone_src_d;
                    self.corraddrphone_src_dl_pos         := corraddrphone_src_dl_pos;
                    self.corraddrphone_src_dl             := corraddrphone_src_dl;
                    self.corraddrphone_src_ds_pos         := corraddrphone_src_ds_pos;
                    self.corraddrphone_src_ds             := corraddrphone_src_ds;
                    self.corraddrphone_src_de_pos         := corraddrphone_src_de_pos;
                    self.corraddrphone_src_de             := corraddrphone_src_de;
                    self.corraddrphone_src_eb_pos         := corraddrphone_src_eb_pos;
                    self.corraddrphone_src_eb             := corraddrphone_src_eb;
                    self.corraddrphone_src_em_pos         := corraddrphone_src_em_pos;
                    self.corraddrphone_src_em             := corraddrphone_src_em;
                    self.corraddrphone_src_e1_pos         := corraddrphone_src_e1_pos;
                    self.corraddrphone_src_e1             := corraddrphone_src_e1;
                    self.corraddrphone_src_e2_pos         := corraddrphone_src_e2_pos;
                    self.corraddrphone_src_e2             := corraddrphone_src_e2;
                    self.corraddrphone_src_e3_pos         := corraddrphone_src_e3_pos;
                    self.corraddrphone_src_e3             := corraddrphone_src_e3;
                    self.corraddrphone_src_e4_pos         := corraddrphone_src_e4_pos;
                    self.corraddrphone_src_e4             := corraddrphone_src_e4;
                    self.corraddrphone_src_en_pos         := corraddrphone_src_en_pos;
                    self.corraddrphone_src_en             := corraddrphone_src_en;
                    self.corraddrphone_src_eq_pos         := corraddrphone_src_eq_pos;
                    self.corraddrphone_src_eq             := corraddrphone_src_eq;
                    self.corraddrphone_src_fe_pos         := corraddrphone_src_fe_pos;
                    self.corraddrphone_src_fe             := corraddrphone_src_fe;
                    self.corraddrphone_src_ff_pos         := corraddrphone_src_ff_pos;
                    self.corraddrphone_src_ff             := corraddrphone_src_ff;
                    self.corraddrphone_src_fr_pos         := corraddrphone_src_fr_pos;
                    self.corraddrphone_src_fr             := corraddrphone_src_fr;
                    self.corraddrphone_src_l2_pos         := corraddrphone_src_l2_pos;
                    self.corraddrphone_src_l2             := corraddrphone_src_l2;
                    self.corraddrphone_src_li_pos         := corraddrphone_src_li_pos;
                    self.corraddrphone_src_li             := corraddrphone_src_li;
                    self.corraddrphone_src_mw_pos         := corraddrphone_src_mw_pos;
                    self.corraddrphone_src_mw             := corraddrphone_src_mw;
                    self.corraddrphone_src_nt_pos         := corraddrphone_src_nt_pos;
                    self.corraddrphone_src_nt             := corraddrphone_src_nt;
                    self.corraddrphone_src_p_pos          := corraddrphone_src_p_pos;
                    self.corraddrphone_src_p              := corraddrphone_src_p;
                    self.corraddrphone_src_pl_pos         := corraddrphone_src_pl_pos;
                    self.corraddrphone_src_pl             := corraddrphone_src_pl;
                    self.corraddrphone_src_tn_pos         := corraddrphone_src_tn_pos;
                    self.corraddrphone_src_tn             := corraddrphone_src_tn;
                    self.corraddrphone_src_ts_pos         := corraddrphone_src_ts_pos;
                    self.corraddrphone_src_ts             := corraddrphone_src_ts;
                    self.corraddrphone_src_tu_pos         := corraddrphone_src_tu_pos;
                    self.corraddrphone_src_tu             := corraddrphone_src_tu;
                    self.corraddrphone_src_sl_pos         := corraddrphone_src_sl_pos;
                    self.corraddrphone_src_sl             := corraddrphone_src_sl;
                    self.corraddrphone_src_v_pos          := corraddrphone_src_v_pos;
                    self.corraddrphone_src_v              := corraddrphone_src_v;
                    self.corraddrphone_src_vo_pos         := corraddrphone_src_vo_pos;
                    self.corraddrphone_src_vo             := corraddrphone_src_vo;
                    self.corraddrphone_src_w_pos          := corraddrphone_src_w_pos;
                    self.corraddrphone_src_w              := corraddrphone_src_w;
                    self.corraddrphone_src_wp_pos         := corraddrphone_src_wp_pos;
                    self.corraddrphone_src_wp             := corraddrphone_src_wp;
                    self.corraddrphone_ct                 := corraddrphone_ct;
                    self.nf_corraddrphone                 := nf_corraddrphone;
                    self.corrphonelastname_src_ak_pos     := corrphonelastname_src_ak_pos;
                    self.corrphonelastname_src_ak         := corrphonelastname_src_ak;
                    self.corrphonelastname_src_am_pos     := corrphonelastname_src_am_pos;
                    self.corrphonelastname_src_am         := corrphonelastname_src_am;
                    self.corrphonelastname_src_ar_pos     := corrphonelastname_src_ar_pos;
                    self.corrphonelastname_src_ar         := corrphonelastname_src_ar;
                    self.corrphonelastname_src_ba_pos     := corrphonelastname_src_ba_pos;
                    self.corrphonelastname_src_ba         := corrphonelastname_src_ba;
                    self.corrphonelastname_src_cg_pos     := corrphonelastname_src_cg_pos;
                    self.corrphonelastname_src_cg         := corrphonelastname_src_cg;
                    self.corrphonelastname_src_co_pos     := corrphonelastname_src_co_pos;
                    self.corrphonelastname_src_co         := corrphonelastname_src_co;
                    self.corrphonelastname_src_cy_pos     := corrphonelastname_src_cy_pos;
                    self.corrphonelastname_src_cy         := corrphonelastname_src_cy;
                    self.corrphonelastname_src_da_pos     := corrphonelastname_src_da_pos;
                    self.corrphonelastname_src_da         := corrphonelastname_src_da;
                    self.corrphonelastname_src_d_pos      := corrphonelastname_src_d_pos;
                    self.corrphonelastname_src_d          := corrphonelastname_src_d;
                    self.corrphonelastname_src_dl_pos     := corrphonelastname_src_dl_pos;
                    self.corrphonelastname_src_dl         := corrphonelastname_src_dl;
                    self.corrphonelastname_src_ds_pos     := corrphonelastname_src_ds_pos;
                    self.corrphonelastname_src_ds         := corrphonelastname_src_ds;
                    self.corrphonelastname_src_de_pos     := corrphonelastname_src_de_pos;
                    self.corrphonelastname_src_de         := corrphonelastname_src_de;
                    self.corrphonelastname_src_eb_pos     := corrphonelastname_src_eb_pos;
                    self.corrphonelastname_src_eb         := corrphonelastname_src_eb;
                    self.corrphonelastname_src_em_pos     := corrphonelastname_src_em_pos;
                    self.corrphonelastname_src_em         := corrphonelastname_src_em;
                    self.corrphonelastname_src_e1_pos     := corrphonelastname_src_e1_pos;
                    self.corrphonelastname_src_e1         := corrphonelastname_src_e1;
                    self.corrphonelastname_src_e2_pos     := corrphonelastname_src_e2_pos;
                    self.corrphonelastname_src_e2         := corrphonelastname_src_e2;
                    self.corrphonelastname_src_e3_pos     := corrphonelastname_src_e3_pos;
                    self.corrphonelastname_src_e3         := corrphonelastname_src_e3;
                    self.corrphonelastname_src_e4_pos     := corrphonelastname_src_e4_pos;
                    self.corrphonelastname_src_e4         := corrphonelastname_src_e4;
                    self.corrphonelastname_src_en_pos     := corrphonelastname_src_en_pos;
                    self.corrphonelastname_src_en         := corrphonelastname_src_en;
                    self.corrphonelastname_src_eq_pos     := corrphonelastname_src_eq_pos;
                    self.corrphonelastname_src_eq         := corrphonelastname_src_eq;
                    self.corrphonelastname_src_fe_pos     := corrphonelastname_src_fe_pos;
                    self.corrphonelastname_src_fe         := corrphonelastname_src_fe;
                    self.corrphonelastname_src_ff_pos     := corrphonelastname_src_ff_pos;
                    self.corrphonelastname_src_ff         := corrphonelastname_src_ff;
                    self.corrphonelastname_src_fr_pos     := corrphonelastname_src_fr_pos;
                    self.corrphonelastname_src_fr         := corrphonelastname_src_fr;
                    self.corrphonelastname_src_l2_pos     := corrphonelastname_src_l2_pos;
                    self.corrphonelastname_src_l2         := corrphonelastname_src_l2;
                    self.corrphonelastname_src_li_pos     := corrphonelastname_src_li_pos;
                    self.corrphonelastname_src_li         := corrphonelastname_src_li;
                    self.corrphonelastname_src_mw_pos     := corrphonelastname_src_mw_pos;
                    self.corrphonelastname_src_mw         := corrphonelastname_src_mw;
                    self.corrphonelastname_src_nt_pos     := corrphonelastname_src_nt_pos;
                    self.corrphonelastname_src_nt         := corrphonelastname_src_nt;
                    self.corrphonelastname_src_p_pos      := corrphonelastname_src_p_pos;
                    self.corrphonelastname_src_p          := corrphonelastname_src_p;
                    self.corrphonelastname_src_pl_pos     := corrphonelastname_src_pl_pos;
                    self.corrphonelastname_src_pl         := corrphonelastname_src_pl;
                    self.corrphonelastname_src_tn_pos     := corrphonelastname_src_tn_pos;
                    self.corrphonelastname_src_tn         := corrphonelastname_src_tn;
                    self.corrphonelastname_src_ts_pos     := corrphonelastname_src_ts_pos;
                    self.corrphonelastname_src_ts         := corrphonelastname_src_ts;
                    self.corrphonelastname_src_tu_pos     := corrphonelastname_src_tu_pos;
                    self.corrphonelastname_src_tu         := corrphonelastname_src_tu;
                    self.corrphonelastname_src_sl_pos     := corrphonelastname_src_sl_pos;
                    self.corrphonelastname_src_sl         := corrphonelastname_src_sl;
                    self.corrphonelastname_src_v_pos      := corrphonelastname_src_v_pos;
                    self.corrphonelastname_src_v          := corrphonelastname_src_v;
                    self.corrphonelastname_src_vo_pos     := corrphonelastname_src_vo_pos;
                    self.corrphonelastname_src_vo         := corrphonelastname_src_vo;
                    self.corrphonelastname_src_w_pos      := corrphonelastname_src_w_pos;
                    self.corrphonelastname_src_w          := corrphonelastname_src_w;
                    self.corrphonelastname_src_wp_pos     := corrphonelastname_src_wp_pos;
                    self.corrphonelastname_src_wp         := corrphonelastname_src_wp;
                    self.corrphonelastname_ct             := corrphonelastname_ct;
                    self.nf_corrphonelastname             := nf_corrphonelastname;
                    self.nf_corroboration_risk_index      := nf_corroboration_risk_index;
                    self.nf_inq_perphone_recency          := nf_inq_perphone_recency;
                    self.rv_f00_ssn_score                 := rv_f00_ssn_score;
                    self.nf_phone_ver_insurance           := nf_phone_ver_insurance;
                    self.nf_fp_validationrisktype         := nf_fp_validationrisktype;
                    self.nf_inquiry_verification_index    := nf_inquiry_verification_index;
                    self.nf_fp_srchcomponentrisktype      := nf_fp_srchcomponentrisktype;
                    self.nf_add_dist_input_to_curr        := nf_add_dist_input_to_curr;
                    self.nf_fp_idrisktype                 := nf_fp_idrisktype;
                    self.nf_inq_ssn_lexid_diff01          := nf_inq_ssn_lexid_diff01;
                    self.iv_input_best_match_index        := iv_input_best_match_index;
                    self.earliest_header_date             := earliest_header_date;
                    self.earliest_header_yrs              := earliest_header_yrs;
                    self.iv_header_emergence_age          := iv_header_emergence_age;
                    self.nf_unvrfd_search_risk_index      := nf_unvrfd_search_risk_index;
                    self.nf_inq_perphone_count12          := nf_inq_perphone_count12;
                    self.nf_inq_phone_ver_count           := nf_inq_phone_ver_count;
                    self.iv_f00_email_verification        := iv_f00_email_verification;
                    self.nf_inq_corrnamephone             := nf_inq_corrnamephone;
                    self.nf_inq_ssn_ver_count             := nf_inq_ssn_ver_count;
                    self._rc_ssnlowissue                  := _rc_ssnlowissue;
                    self.ssn_years                        := ssn_years;
                    self.nf_age_at_ssn_issuance           := nf_age_at_ssn_issuance;
                    self.iv_input_best_phone_match        := iv_input_best_phone_match;
                    self.rv_l70_inp_addr_dirty            := rv_l70_inp_addr_dirty;
                    self.nf_inq_perssn_count_week         := nf_inq_perssn_count_week;
                    self.rv_i62_inq_dobsperadl_recency    := rv_i62_inq_dobsperadl_recency;
                    self.rv_l79_adls_per_addr_curr        := rv_l79_adls_per_addr_curr;
                    self.rv_c13_curr_addr_lres            := rv_c13_curr_addr_lres;
                    self.nf_bus_seleids_peradl            := nf_bus_seleids_peradl;
                    self.nf_inq_adlsperphone_count12      := nf_inq_adlsperphone_count12;
                    self.rv_p88_phn_dst_to_inp_add        := rv_p88_phn_dst_to_inp_add;
                    self.iv_phn_cell                      := iv_phn_cell;
                    self.nf_email_name_addr_ver           := nf_email_name_addr_ver;
                    self.nf_bus_gold_seleids_peradl       := nf_bus_gold_seleids_peradl;
                    self._sum_dob_bureau                  := _sum_dob_bureau;
                    self._sum_dob_credentialed            := _sum_dob_credentialed;
                    self._sum_dob_other                   := _sum_dob_other;
                    self._num_dob_sources                 := _num_dob_sources;
                    self.iv_dob_bureau_only               := iv_dob_bureau_only;
                    self.nf_inq_perssn_count_day          := nf_inq_perssn_count_day;
                    self.nf_fp_srchfraudsrchcountmo       := nf_fp_srchfraudsrchcountmo;
                    self.iv_c13_avg_lres                  := iv_c13_avg_lres;
                    self.br_first_seen_char               := br_first_seen_char;
                    self._br_first_seen                   := _br_first_seen;
                    self.rv_mos_since_br_first_seen       := rv_mos_since_br_first_seen;
                    self.rv_c22_inp_addr_occ_index        := rv_c22_inp_addr_occ_index;
                    self.rv_c13_attr_addrs_recency        := rv_c13_attr_addrs_recency;
                    self.rv_f00_dob_score                 := rv_f00_dob_score;
                    self.add_ec3                          := add_ec3;
                    self.add_ec4                          := add_ec4;
                    self.rv_l70_add_standardized          := rv_l70_add_standardized;
                    self.nf_fp_prevaddrageoldest          := nf_fp_prevaddrageoldest;
                    self.nf_mos_bus_header_fs             := nf_mos_bus_header_fs;
                    self.nf_fp_varrisktype                := nf_fp_varrisktype;
                    self.nf_bus_sos_filings_peradl        := nf_bus_sos_filings_peradl;
                    self._rc_ssnhighissue                 := _rc_ssnhighissue;
                    self.nf_m_snc_ssn_high_issue          := nf_m_snc_ssn_high_issue;
                    self.rv_f00_inq_corrphonessn_adl      := rv_f00_inq_corrphonessn_adl;
                    self._sum_other                       := _sum_other;
                    self.num_sources                      := num_sources;
                    self.iv_bureau_only_emergence_age     := iv_bureau_only_emergence_age;
                    self.nf_fp_idverrisktype              := nf_fp_idverrisktype;
                    self.nf_adls_per_bestssn              := nf_adls_per_bestssn;
                    self._in_dob                          := _in_dob;
                    self.earliest_bureau_date             := earliest_bureau_date;
                    self.earliest_bureau_yrs              := earliest_bureau_yrs;
                    self.calc_dob                         := calc_dob;
                    self.iv_bureau_emergence_age          := iv_bureau_emergence_age;
                    self.iv_addr_non_phn_src_ct           := iv_addr_non_phn_src_ct;
                    self.rv_f04_curr_add_occ_index        := rv_f04_curr_add_occ_index;
                    self.nf_fp_srchfraudsrchcountyr       := nf_fp_srchfraudsrchcountyr;
                    self.nf_inq_highriskcredit_count24    := nf_inq_highriskcredit_count24;
                    self.rv_l79_adls_per_sfd_addr         := rv_l79_adls_per_sfd_addr;
                    self.nf_inq_corrdobphone              := nf_inq_corrdobphone;
                    self.nf_fp_divaddrsuspidcountnew      := nf_fp_divaddrsuspidcountnew;
                    self.nf_inquiry_adl_vel_risk_index    := nf_inquiry_adl_vel_risk_index;
                    self.rv_i62_inq_phones_per_adl        := rv_i62_inq_phones_per_adl;
                    self.iv_prof_license_category         := iv_prof_license_category;
                    self.nf_invbest_inq_adlsperphone_diff := nf_invbest_inq_adlsperphone_diff;
                    self.nf_invbest_inq_lastperaddr_diff  := nf_invbest_inq_lastperaddr_diff;
                    self.nf_invbest_inq_ssnsperaddr_diff  := nf_invbest_inq_ssnsperaddr_diff;
                    self.nf_inq_per_phone                 := nf_inq_per_phone;
                    self.nf_inq_curraddr_ver_count        := nf_inq_curraddr_ver_count;
                    self.rv_f00_inq_corrdobssn_adl        := rv_f00_inq_corrdobssn_adl;
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
                    self.rv_c13_inp_addr_lres             := rv_c13_inp_addr_lres;
                    self.iv_inf_nothing_found             := iv_inf_nothing_found;
                    self.nf_bus_inact_seleids_peradl      := nf_bus_inact_seleids_peradl;
                    self.nf_mos_bus_header_ls             := nf_mos_bus_header_ls;
                    self.nf_phones_per_addr_curr          := nf_phones_per_addr_curr;
                    self._nap_ver                         := _nap_ver;
                    self._inf_ver                         := _inf_ver;
                    self.iv_phn_addr_verified             := iv_phn_addr_verified;
                    self.nf_inq_fname_ver_count           := nf_inq_fname_ver_count;
                    self.nf_adls_per_bestphone_c6         := nf_adls_per_bestphone_c6;
                    self.num_bureau_fname                 := num_bureau_fname;
                    self.num_bureau_lname                 := num_bureau_lname;
                    self.num_bureau_addr                  := num_bureau_addr;
                    self.num_bureau_ssn                   := num_bureau_ssn;
                    self.num_bureau_dob                   := num_bureau_dob;
                    self.iv_bureau_verification_index     := iv_bureau_verification_index;
                    self.nf_inq_corrnamephonessn          := nf_inq_corrnamephonessn;
                    self.nf_dist_inp_curr_hi_velocity     := nf_dist_inp_curr_hi_velocity;
                    self.rv_i60_inq_other_recency         := rv_i60_inq_other_recency;
                    self.rv_f00_inq_corrdobphone_adl      := rv_f00_inq_corrdobphone_adl;
                    self.rv_a41_a42_prop_owner_history    := rv_a41_a42_prop_owner_history;
                    self.all_tree_0                       := all_tree_0;
                    self.all_tree_1                       := all_tree_1;
                    self.all_tree_2                       := all_tree_2;
                    self.all_tree_3                       := all_tree_3;
                    self.all_tree_4                       := all_tree_4;
                    self.all_tree_5                       := all_tree_5;
                    self.all_tree_6                       := all_tree_6;
                    self.all_tree_7                       := all_tree_7;
                    self.all_tree_8                       := all_tree_8;
                    self.all_tree_9                       := all_tree_9;
                    self.all_tree_10                      := all_tree_10;
                    self.all_tree_11                      := all_tree_11;
                    self.all_tree_12                      := all_tree_12;
                    self.all_tree_13                      := all_tree_13;
                    self.all_tree_14                      := all_tree_14;
                    self.all_tree_15                      := all_tree_15;
                    self.all_tree_16                      := all_tree_16;
                    self.all_tree_17                      := all_tree_17;
                    self.all_tree_18                      := all_tree_18;
                    self.all_tree_19                      := all_tree_19;
                    self.all_tree_20                      := all_tree_20;
                    self.all_tree_21                      := all_tree_21;
                    self.all_tree_22                      := all_tree_22;
                    self.all_tree_23                      := all_tree_23;
                    self.all_tree_24                      := all_tree_24;
                    self.all_tree_25                      := all_tree_25;
                    self.all_tree_26                      := all_tree_26;
                    self.all_tree_27                      := all_tree_27;
                    self.all_tree_28                      := all_tree_28;
                    self.all_tree_29                      := all_tree_29;
                    self.all_tree_30                      := all_tree_30;
                    self.all_tree_31                      := all_tree_31;
                    self.all_tree_32                      := all_tree_32;
                    self.all_tree_33                      := all_tree_33;
                    self.all_tree_34                      := all_tree_34;
                    self.all_tree_35                      := all_tree_35;
                    self.all_tree_36                      := all_tree_36;
                    self.all_tree_37                      := all_tree_37;
                    self.all_tree_38                      := all_tree_38;
                    self.all_tree_39                      := all_tree_39;
                    self.all_tree_40                      := all_tree_40;
                    self.all_tree_41                      := all_tree_41;
                    self.all_tree_42                      := all_tree_42;
                    self.all_tree_43                      := all_tree_43;
                    self.all_tree_44                      := all_tree_44;
                    self.all_tree_45                      := all_tree_45;
                    self.all_tree_46                      := all_tree_46;
                    self.all_tree_47                      := all_tree_47;
                    self.all_tree_48                      := all_tree_48;
                    self.all_tree_49                      := all_tree_49;
                    self.all_tree_50                      := all_tree_50;
                    self.all_tree_51                      := all_tree_51;
                    self.all_tree_52                      := all_tree_52;
                    self.all_tree_53                      := all_tree_53;
                    self.all_tree_54                      := all_tree_54;
                    self.all_tree_55                      := all_tree_55;
                    self.all_tree_56                      := all_tree_56;
                    self.all_tree_57                      := all_tree_57;
                    self.all_tree_58                      := all_tree_58;
                    self.all_tree_59                      := all_tree_59;
                    self.all_tree_60                      := all_tree_60;
                    self.all_tree_61                      := all_tree_61;
                    self.all_tree_62                      := all_tree_62;
                    self.all_tree_63                      := all_tree_63;
                    self.all_tree_64                      := all_tree_64;
                    self.all_tree_65                      := all_tree_65;
                    self.all_tree_66                      := all_tree_66;
                    self.all_tree_67                      := all_tree_67;
                    self.all_tree_68                      := all_tree_68;
                    self.all_tree_69                      := all_tree_69;
                    self.all_tree_70                      := all_tree_70;
                    self.all_tree_71                      := all_tree_71;
                    self.all_tree_72                      := all_tree_72;
                    self.all_tree_73                      := all_tree_73;
                    self.all_tree_74                      := all_tree_74;
                    self.all_tree_75                      := all_tree_75;
                    self.all_tree_76                      := all_tree_76;
                    self.all_tree_77                      := all_tree_77;
                    self.all_tree_78                      := all_tree_78;
                    self.all_tree_79                      := all_tree_79;
                    self.all_tree_80                      := all_tree_80;
                    self.all_tree_81                      := all_tree_81;
                    self.all_tree_82                      := all_tree_82;
                    self.all_tree_83                      := all_tree_83;
                    self.all_tree_84                      := all_tree_84;
                    self.all_tree_85                      := all_tree_85;
                    self.all_tree_86                      := all_tree_86;
                    self.all_tree_87                      := all_tree_87;
                    self.all_tree_88                      := all_tree_88;
                    self.all_tree_89                      := all_tree_89;
                    self.all_tree_90                      := all_tree_90;
                    self.all_tree_91                      := all_tree_91;
                    self.all_tree_92                      := all_tree_92;
                    self.all_gbm_logit                    := all_gbm_logit;
                    self.pbr                              := pbr;
                    self.sbr                              := sbr;
                    self.base                             := base;
                    self.pts                              := pts;
                    self.lgt                              := lgt;
                    self.offset                           := offset;
                    self.fp1806_1_0                       := fp1806_1_0;
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
                    self.stolenc_fp1806_1_0               := stolenc_fp1806_1_0;
                    self.manip2c_fp1806_1_0               := manip2c_fp1806_1_0;
                    self.synthc_fp1806_1_0                := synthc_fp1806_1_0;
                    self.suspactc_fp1806_1_0              := suspactc_fp1806_1_0;
                    self.vulnvicc_fp1806_1_0              := vulnvicc_fp1806_1_0;
                    self.friendlyc_fp1806_1_0             := friendlyc_fp1806_1_0;
                    self.fp1806_1_0_stolidindex           := fp1806_1_0_stolidindex;
                    self.fp1806_1_0_synthidindex          := fp1806_1_0_synthidindex;
                    self.fp1806_1_0_manipidindex          := fp1806_1_0_manipidindex;
                    self.fp1806_1_0_vulnvicindex          := fp1806_1_0_vulnvicindex;
                    self.fp1806_1_0_friendfrdindex        := fp1806_1_0_friendfrdindex;
                    self.fp1806_1_0_suspactindex          := fp1806_1_0_suspactindex;

	                  SELF.clam                             := le;                     //***Attach the entire Boca Shell when DEBUG MODE is TRUE
#end

	           self.seq                                     := le.seq;
	           self.StolenIdentityIndex                     := (STRING) fp1806_1_0_stolidindex;
	           self.SyntheticIdentityIndex                  := (STRING) fp1806_1_0_synthidindex;
	           self.ManipulatedIdentityIndex                := (STRING) fp1806_1_0_manipidindex;
	           self.VulnerableVictimIndex                   := (STRING) fp1806_1_0_vulnvicindex;
	           self.FriendlyFraudIndex                      := (STRING) fp1806_1_0_friendfrdindex;
	           self.SuspiciousActivityIndex                 := (STRING) fp1806_1_0_suspactindex;
             ritmp                                        :=  Models.fraudpoint3_reasons(le, blank_ip, num_reasons);
	           reasons                                      := Models.Common.checkFraudPointRC34(FP1806_1_0, ritmp, num_reasons);
	           self.ri                                      := reasons;
	           self.score                                   := (STRING)FP1806_1_0;
	           self                                         := [];
	
      END;

   model :=   project(clam, doModel(left) );
	
	return model;
END;




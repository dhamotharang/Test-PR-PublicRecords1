import Std, risk_indicators, riskwise, riskwisefcra, ut, easi, Models;

blank_ip := dataset( [{0}], riskwise.Layout_IP2O )[1];

export FP1802_1_0(dataset(risk_indicators.Layout_Boca_Shell) clam,
                  integer1 num_reasons)
									 := FUNCTION
									
		// FP_DEBUG := True;
		FP_DEBUG := False;
		
		isFCRA := False;

	#if(FP_DEBUG)
	Layout_Debug := RECORD
	
	/* Model Intermediate Variables */
	//STRING NULL;
                    Integer seq;
                    integer sysdate                          ; // := sysdate;
                    integer ver_src_cnt                      ; // := ver_src_cnt;
                    Boolean ver_src_pop                      ; // := ver_src_pop;
                    string ver_src_fsrc                     ; // := ver_src_fsrc;
                    string ver_src_fsrc_fdate               ; // := ver_src_fsrc_fdate;
                    integer ver_src_fsrc_fdate2              ; // := ver_src_fsrc_fdate2;
                    Real yr_ver_src_fsrc_fdate            ; // := yr_ver_src_fsrc_fdate;
                    Real mth_ver_src_fsrc_fdate           ; // := mth_ver_src_fsrc_fdate;
                    integer ver_src_ak_pos                   ; // := ver_src_ak_pos;
                    string _ver_src_fdate_ak                ; // := _ver_src_fdate_ak;
                    integer ver_src_fdate_ak                 ; // := ver_src_fdate_ak;
                    string _ver_src_ldate_ak                ; // := _ver_src_ldate_ak;
                    integer ver_src_ldate_ak                 ; // := ver_src_ldate_ak;
                    real ver_src_cnt_ak                   ; // := ver_src_cnt_ak;
                    integer ver_src_am_pos                   ; // := ver_src_am_pos;
                    string _ver_src_fdate_am                ; // := _ver_src_fdate_am;
                    integer ver_src_fdate_am                 ; // := ver_src_fdate_am;
                    string _ver_src_ldate_am                ; // := _ver_src_ldate_am;
                    integer ver_src_ldate_am                 ; // := ver_src_ldate_am;
                    real   ver_src_cnt_am                   ; // := ver_src_cnt_am;
                    integer ver_src_ar_pos                   ; // := ver_src_ar_pos;
                    string _ver_src_fdate_ar                ; // := _ver_src_fdate_ar;
                    integer ver_src_fdate_ar                 ; // := ver_src_fdate_ar;
                    string _ver_src_ldate_ar                ; // := _ver_src_ldate_ar;
                    integer ver_src_ldate_ar                 ; // := ver_src_ldate_ar;
                    real ver_src_cnt_ar                   ; // := ver_src_cnt_ar;
                    integer ver_src_ba_pos                   ; // := ver_src_ba_pos;
                    string _ver_src_fdate_ba                ; // := _ver_src_fdate_ba;
                    integer ver_src_fdate_ba                 ; // := ver_src_fdate_ba;
                    string _ver_src_ldate_ba                ; // := _ver_src_ldate_ba;
                    integer ver_src_ldate_ba                 ; // := ver_src_ldate_ba;
                    real ver_src_cnt_ba                   ; // := ver_src_cnt_ba;
                    integer ver_src_cg_pos                   ; // := ver_src_cg_pos;
                    string _ver_src_fdate_cg                ; // := _ver_src_fdate_cg;
                    integer ver_src_fdate_cg                 ; // := ver_src_fdate_cg;
                    string _ver_src_ldate_cg                ; // := _ver_src_ldate_cg;
                    integer ver_src_ldate_cg                 ; // := ver_src_ldate_cg;
                    real ver_src_cnt_cg                   ; // := ver_src_cnt_cg;
                    integer ver_src_co_pos                   ; // := ver_src_co_pos;
                    string _ver_src_fdate_co                ; // := _ver_src_fdate_co;
                    integer ver_src_fdate_co                 ; // := ver_src_fdate_co;
                    string _ver_src_ldate_co                ; // := _ver_src_ldate_co;
                    integer ver_src_ldate_co                 ; // := ver_src_ldate_co;
                    real  ver_src_cnt_co                   ; // := ver_src_cnt_co;
                    integer ver_src_cy_pos                   ; // := ver_src_cy_pos;
                    string _ver_src_fdate_cy                ; // := _ver_src_fdate_cy;
                    integer ver_src_fdate_cy                 ; // := ver_src_fdate_cy;
                    string _ver_src_ldate_cy                ; // := _ver_src_ldate_cy;
                    integer ver_src_ldate_cy                 ; // := ver_src_ldate_cy;
                    real ver_src_cnt_cy                   ; // := ver_src_cnt_cy;
                    integer ver_src_da_pos                   ; // := ver_src_da_pos;
                    string _ver_src_fdate_da                ; // := _ver_src_fdate_da;
                    integer ver_src_fdate_da                 ; // := ver_src_fdate_da;
                    string _ver_src_ldate_da                ; // := _ver_src_ldate_da;
                    integer ver_src_ldate_da                 ; // := ver_src_ldate_da;
                    real ver_src_cnt_da                   ; // := ver_src_cnt_da;
                    integer ver_src_d_pos                    ; // := ver_src_d_pos;
                    string _ver_src_fdate_d                 ; // := _ver_src_fdate_d;
                    integer ver_src_fdate_d                  ; // := ver_src_fdate_d;
                    string _ver_src_ldate_d                 ; // := _ver_src_ldate_d;
                    integer ver_src_ldate_d                  ; // := ver_src_ldate_d;
                    real ver_src_cnt_d                    ; // := ver_src_cnt_d;
                    integer ver_src_dl_pos                   ; // := ver_src_dl_pos;
                    string _ver_src_fdate_dl                ; // := _ver_src_fdate_dl;
                    integer ver_src_fdate_dl                 ; // := ver_src_fdate_dl;
                    string _ver_src_ldate_dl                ; // := _ver_src_ldate_dl;
                    integer ver_src_ldate_dl                 ; // := ver_src_ldate_dl;
                    real ver_src_cnt_dl                   ; // := ver_src_cnt_dl;
                    integer ver_src_ds_pos                   ; // := ver_src_ds_pos;
                    string _ver_src_fdate_ds                ; // := _ver_src_fdate_ds;
                    integer ver_src_fdate_ds                 ; // := ver_src_fdate_ds;
                    string _ver_src_ldate_ds                ; // := _ver_src_ldate_ds;
                    integer ver_src_ldate_ds                 ; // := ver_src_ldate_ds;
                    real ver_src_cnt_ds                   ; // := ver_src_cnt_ds;
                    integer ver_src_de_pos                   ; // := ver_src_de_pos;
                    string _ver_src_fdate_de                ; // := _ver_src_fdate_de;
                    integer ver_src_fdate_de                 ; // := ver_src_fdate_de;
                    string _ver_src_ldate_de                ; // := _ver_src_ldate_de;
                    integer ver_src_ldate_de                 ; // := ver_src_ldate_de;
                    real ver_src_cnt_de                   ; // := ver_src_cnt_de;
                    integer ver_src_eb_pos                   ; // := ver_src_eb_pos;
                    string _ver_src_fdate_eb                ; // := _ver_src_fdate_eb;
                    integer ver_src_fdate_eb                 ; // := ver_src_fdate_eb;
                    string _ver_src_ldate_eb                ; // := _ver_src_ldate_eb;
                    integer ver_src_ldate_eb                 ; // := ver_src_ldate_eb;
                    real ver_src_cnt_eb                   ; // := ver_src_cnt_eb;
                    integer ver_src_em_pos                   ; // := ver_src_em_pos;
                    string _ver_src_fdate_em                ; // := _ver_src_fdate_em;
                    integer ver_src_fdate_em                 ; // := ver_src_fdate_em;
                    string _ver_src_ldate_em                ; // := _ver_src_ldate_em;
                    integer ver_src_ldate_em                 ; // := ver_src_ldate_em;
                    real ver_src_cnt_em                   ; // := ver_src_cnt_em;
                    integer ver_src_e1_pos                   ; // := ver_src_e1_pos;
                    string _ver_src_fdate_e1                ; // := _ver_src_fdate_e1;
                    integer ver_src_fdate_e1                 ; // := ver_src_fdate_e1;
                    string _ver_src_ldate_e1                ; // := _ver_src_ldate_e1;
                    integer ver_src_ldate_e1                 ; // := ver_src_ldate_e1;
                    real ver_src_cnt_e1                   ; // := ver_src_cnt_e1;
                    integer ver_src_e2_pos                   ; // := ver_src_e2_pos;
                    string _ver_src_fdate_e2                ; // := _ver_src_fdate_e2;
                    integer ver_src_fdate_e2                 ; // := ver_src_fdate_e2;
                    string _ver_src_ldate_e2                ; // := _ver_src_ldate_e2;
                    integer ver_src_ldate_e2                 ; // := ver_src_ldate_e2;
                    real ver_src_cnt_e2                   ; // := ver_src_cnt_e2;
                    integer ver_src_e3_pos                   ; // := ver_src_e3_pos;
                    string _ver_src_fdate_e3                ; // := _ver_src_fdate_e3;
                    integer ver_src_fdate_e3                 ; // := ver_src_fdate_e3;
                    string _ver_src_ldate_e3                ; // := _ver_src_ldate_e3;
                    integer ver_src_ldate_e3                 ; // := ver_src_ldate_e3;
                    real ver_src_cnt_e3                   ; // := ver_src_cnt_e3;
                    integer ver_src_e4_pos                   ; // := ver_src_e4_pos;
                    string _ver_src_fdate_e4                ; // := _ver_src_fdate_e4;
                    integer ver_src_fdate_e4                 ; // := ver_src_fdate_e4;
                    string _ver_src_ldate_e4                ; // := _ver_src_ldate_e4;
                    integer ver_src_ldate_e4                 ; // := ver_src_ldate_e4;
                    real ver_src_cnt_e4                   ; // := ver_src_cnt_e4;
                    integer ver_src_en_pos                   ; // := ver_src_en_pos;
                    string _ver_src_fdate_en                ; // := _ver_src_fdate_en;
                    integer ver_src_fdate_en                 ; // := ver_src_fdate_en;
                    string _ver_src_ldate_en                ; // := _ver_src_ldate_en;
                    integer ver_src_ldate_en                 ; // := ver_src_ldate_en;
                    real ver_src_cnt_en                   ; // := ver_src_cnt_en;
                    integer ver_src_eq_pos                   ; // := ver_src_eq_pos;
                    string _ver_src_fdate_eq                ; // := _ver_src_fdate_eq;
                    integer ver_src_fdate_eq                 ; // := ver_src_fdate_eq;
                    string _ver_src_ldate_eq                ; // := _ver_src_ldate_eq;
                    integer ver_src_ldate_eq                 ; // := ver_src_ldate_eq;
                    real ver_src_cnt_eq                   ; // := ver_src_cnt_eq;
                    integer ver_src_fe_pos                   ; // := ver_src_fe_pos;
                    string _ver_src_fdate_fe                ; // := _ver_src_fdate_fe;
                    integer ver_src_fdate_fe                 ; // := ver_src_fdate_fe;
                    string _ver_src_ldate_fe                ; // := _ver_src_ldate_fe;
                    integer ver_src_ldate_fe                 ; // := ver_src_ldate_fe;
                    real ver_src_cnt_fe                   ; // := ver_src_cnt_fe;
                    integer ver_src_ff_pos                   ; // := ver_src_ff_pos;
                    string _ver_src_fdate_ff                ; // := _ver_src_fdate_ff;
                    integer ver_src_fdate_ff                 ; // := ver_src_fdate_ff;
                    string _ver_src_ldate_ff                ; // := _ver_src_ldate_ff;
                    integer ver_src_ldate_ff                 ; // := ver_src_ldate_ff;
                    real ver_src_cnt_ff                   ; // := ver_src_cnt_ff;
                    integer ver_src_fr_pos                   ; // := ver_src_fr_pos;
                    string _ver_src_fdate_fr                ; // := _ver_src_fdate_fr;
                    integer ver_src_fdate_fr                 ; // := ver_src_fdate_fr;
                    string _ver_src_ldate_fr                ; // := _ver_src_ldate_fr;
                    integer ver_src_ldate_fr                 ; // := ver_src_ldate_fr;
                    real ver_src_cnt_fr                   ; // := ver_src_cnt_fr;
                    integer ver_src_l2_pos                   ; // := ver_src_l2_pos;
                    string _ver_src_fdate_l2                ; // := _ver_src_fdate_l2;
                    integer ver_src_fdate_l2                 ; // := ver_src_fdate_l2;
                    string _ver_src_ldate_l2                ; // := _ver_src_ldate_l2;
                    integer ver_src_ldate_l2                 ; // := ver_src_ldate_l2;
                    real ver_src_cnt_l2                   ; // := ver_src_cnt_l2;
                    integer ver_src_li_pos                   ; // := ver_src_li_pos;
                    string _ver_src_fdate_li                ; // := _ver_src_fdate_li;
                    integer ver_src_fdate_li                 ; // := ver_src_fdate_li;
                    string _ver_src_ldate_li                ; // := _ver_src_ldate_li;
                    integer ver_src_ldate_li                 ; // := ver_src_ldate_li;
                    real ver_src_cnt_li                   ; // := ver_src_cnt_li;
                    integer ver_src_mw_pos                   ; // := ver_src_mw_pos;
                    string _ver_src_fdate_mw                ; // := _ver_src_fdate_mw;
                    integer ver_src_fdate_mw                 ; // := ver_src_fdate_mw;
                    string _ver_src_ldate_mw                ; // := _ver_src_ldate_mw;
                    integer ver_src_ldate_mw                 ; // := ver_src_ldate_mw;
                    real ver_src_cnt_mw                   ; // := ver_src_cnt_mw;
                    integer ver_src_nt_pos                   ; // := ver_src_nt_pos;
                    string _ver_src_fdate_nt                ; // := _ver_src_fdate_nt;
                    integer ver_src_fdate_nt                 ; // := ver_src_fdate_nt;
                    string _ver_src_ldate_nt                ; // := _ver_src_ldate_nt;
                    integer ver_src_ldate_nt                 ; // := ver_src_ldate_nt;
                    real ver_src_cnt_nt                   ; // := ver_src_cnt_nt;
                    integer ver_src_p_pos                    ; // := ver_src_p_pos;
                    string _ver_src_fdate_p                 ; // := _ver_src_fdate_p;
                    integer ver_src_fdate_p                  ; // := ver_src_fdate_p;
                    string _ver_src_ldate_p                 ; // := _ver_src_ldate_p;
                    integer ver_src_ldate_p                  ; // := ver_src_ldate_p;
                    real ver_src_cnt_p                    ; // := ver_src_cnt_p;
                    integer ver_src_pl_pos                   ; // := ver_src_pl_pos;
                    string _ver_src_fdate_pl                ; // := _ver_src_fdate_pl;
                    integer ver_src_fdate_pl                 ; // := ver_src_fdate_pl;
                    string _ver_src_ldate_pl                ; // := _ver_src_ldate_pl;
                    integer ver_src_ldate_pl                 ; // := ver_src_ldate_pl;
                    real ver_src_cnt_pl                   ; // := ver_src_cnt_pl;
                    integer ver_src_tn_pos                   ; // := ver_src_tn_pos;
                    string _ver_src_fdate_tn                ; // := _ver_src_fdate_tn;
                    integer ver_src_fdate_tn                 ; // := ver_src_fdate_tn;
                    string _ver_src_ldate_tn                ; // := _ver_src_ldate_tn;
                    integer ver_src_ldate_tn                 ; // := ver_src_ldate_tn;
                    real ver_src_cnt_tn                   ; // := ver_src_cnt_tn;
                    integer ver_src_ts_pos                   ; // := ver_src_ts_pos;
                    string _ver_src_fdate_ts                ; // := _ver_src_fdate_ts;
                    integer ver_src_fdate_ts                 ; // := ver_src_fdate_ts;
                    string _ver_src_ldate_ts                ; // := _ver_src_ldate_ts;
                    integer ver_src_ldate_ts                 ; // := ver_src_ldate_ts;
                    real ver_src_cnt_ts                   ; // := ver_src_cnt_ts;
                    integer ver_src_tu_pos                   ; // := ver_src_tu_pos;
                    string _ver_src_fdate_tu                ; // := _ver_src_fdate_tu;
                    integer ver_src_fdate_tu                 ; // := ver_src_fdate_tu;
                    string _ver_src_ldate_tu                ; // := _ver_src_ldate_tu;
                    integer ver_src_ldate_tu                 ; // := ver_src_ldate_tu;
                    real ver_src_cnt_tu                   ; // := ver_src_cnt_tu;
                    integer ver_src_sl_pos                   ; // := ver_src_sl_pos;
                    string _ver_src_fdate_sl                ; // := _ver_src_fdate_sl;
                    integer ver_src_fdate_sl                 ; // := ver_src_fdate_sl;
                    string _ver_src_ldate_sl                ; // := _ver_src_ldate_sl;
                    integer ver_src_ldate_sl                 ; // := ver_src_ldate_sl;
                    real ver_src_cnt_sl                   ; // := ver_src_cnt_sl;
                    integer ver_src_v_pos                    ; // := ver_src_v_pos;
                    string _ver_src_fdate_v                 ; // := _ver_src_fdate_v;
                    integer ver_src_fdate_v                  ; // := ver_src_fdate_v;
                    string _ver_src_ldate_v                 ; // := _ver_src_ldate_v;
                    integer ver_src_ldate_v                  ; // := ver_src_ldate_v;
                    real ver_src_cnt_v                    ; // := ver_src_cnt_v;
                    integer ver_src_vo_pos                   ; // := ver_src_vo_pos;
                    string _ver_src_fdate_vo                ; // := _ver_src_fdate_vo;
                    integer ver_src_fdate_vo                 ; // := ver_src_fdate_vo;
                    string _ver_src_ldate_vo                ; // := _ver_src_ldate_vo;
                    integer ver_src_ldate_vo                 ; // := ver_src_ldate_vo;
                    real ver_src_cnt_vo                   ; // := ver_src_cnt_vo;
                    integer ver_src_w_pos                    ; // := ver_src_w_pos;
                    string _ver_src_fdate_w                 ; // := _ver_src_fdate_w;
                    integer ver_src_fdate_w                  ; // := ver_src_fdate_w;
                    string _ver_src_ldate_w                 ; // := _ver_src_ldate_w;
                    integer ver_src_ldate_w                  ; // := ver_src_ldate_w;
                    real ver_src_cnt_w                    ; // := ver_src_cnt_w;
                    integer ver_src_wp_pos                   ; // := ver_src_wp_pos;
                    string _ver_src_fdate_wp                ; // := _ver_src_fdate_wp;
                    integer ver_src_fdate_wp                 ; // := ver_src_fdate_wp;
                    string _ver_src_ldate_wp                ; // := _ver_src_ldate_wp;
                    integer ver_src_ldate_wp                 ; // := ver_src_ldate_wp;
                    real ver_src_cnt_wp                   ; // := ver_src_cnt_wp;
                    real ver_src_rcnt                     ; // := ver_src_rcnt;
                    integer ver_fname_src_cnt                ; // := ver_fname_src_cnt;
                    boolean ver_fname_src_pop                ; // := ver_fname_src_pop;
                    integer ver_fname_src_rcnt               ; // := ver_fname_src_rcnt;
                    string ver_fname_src_fsrc               ; // := ver_fname_src_fsrc;
                    integer ver_fname_src_ak_pos             ; // := ver_fname_src_ak_pos;
                    boolean ver_fname_src_ak                 ; // := ver_fname_src_ak;
                    integer ver_fname_src_am_pos             ; // := ver_fname_src_am_pos;
                    boolean ver_fname_src_am                 ; // := ver_fname_src_am;
                    integer ver_fname_src_ar_pos             ; // := ver_fname_src_ar_pos;
                    boolean ver_fname_src_ar                 ; // := ver_fname_src_ar;
                    integer ver_fname_src_ba_pos             ; // := ver_fname_src_ba_pos;
                    boolean ver_fname_src_ba                 ; // := ver_fname_src_ba;
                    integer ver_fname_src_cg_pos             ; // := ver_fname_src_cg_pos;
                    boolean ver_fname_src_cg                 ; // := ver_fname_src_cg;
                    integer ver_fname_src_co_pos             ; // := ver_fname_src_co_pos;
                    boolean ver_fname_src_co                 ; // := ver_fname_src_co;
                    integer ver_fname_src_cy_pos             ; // := ver_fname_src_cy_pos;
                    boolean ver_fname_src_cy                 ; // := ver_fname_src_cy;
                    integer ver_fname_src_da_pos             ; // := ver_fname_src_da_pos;
                    boolean ver_fname_src_da                 ; // := ver_fname_src_da;
                    integer ver_fname_src_d_pos              ; // := ver_fname_src_d_pos;
                    boolean ver_fname_src_d                  ; // := ver_fname_src_d;
                    integer ver_fname_src_dl_pos             ; // := ver_fname_src_dl_pos;
                    boolean ver_fname_src_dl                 ; // := ver_fname_src_dl;
                    integer ver_fname_src_ds_pos             ; // := ver_fname_src_ds_pos;
                    boolean ver_fname_src_ds                 ; // := ver_fname_src_ds;
                    integer ver_fname_src_de_pos             ; // := ver_fname_src_de_pos;
                    boolean ver_fname_src_de                 ; // := ver_fname_src_de;
                    integer ver_fname_src_eb_pos             ; // := ver_fname_src_eb_pos;
                    boolean ver_fname_src_eb                 ; // := ver_fname_src_eb;
                    integer ver_fname_src_em_pos             ; // := ver_fname_src_em_pos;
                    boolean ver_fname_src_em                 ; // := ver_fname_src_em;
                    integer ver_fname_src_e1_pos             ; // := ver_fname_src_e1_pos;
                    boolean ver_fname_src_e1                 ; // := ver_fname_src_e1;
                    integer ver_fname_src_e2_pos             ; // := ver_fname_src_e2_pos;
                    boolean ver_fname_src_e2                 ; // := ver_fname_src_e2;
                    integer ver_fname_src_e3_pos             ; // := ver_fname_src_e3_pos;
                    boolean ver_fname_src_e3                 ; // := ver_fname_src_e3;
                    integer ver_fname_src_e4_pos             ; // := ver_fname_src_e4_pos;
                    boolean ver_fname_src_e4                 ; // := ver_fname_src_e4;
                    integer ver_fname_src_en_pos             ; // := ver_fname_src_en_pos;
                    boolean ver_fname_src_en                 ; // := ver_fname_src_en;
                    integer ver_fname_src_eq_pos             ; // := ver_fname_src_eq_pos;
                    boolean ver_fname_src_eq                 ; // := ver_fname_src_eq;
                    integer ver_fname_src_fe_pos             ; // := ver_fname_src_fe_pos;
                    boolean ver_fname_src_fe                 ; // := ver_fname_src_fe;
                    integer ver_fname_src_ff_pos             ; // := ver_fname_src_ff_pos;
                    boolean ver_fname_src_ff                 ; // := ver_fname_src_ff;
                    integer ver_fname_src_fr_pos             ; // := ver_fname_src_fr_pos;
                    boolean ver_fname_src_fr                 ; // := ver_fname_src_fr;
                    integer ver_fname_src_l2_pos             ; // := ver_fname_src_l2_pos;
                    boolean ver_fname_src_l2                 ; // := ver_fname_src_l2;
                    integer ver_fname_src_li_pos             ; // := ver_fname_src_li_pos;
                    boolean ver_fname_src_li                 ; // := ver_fname_src_li;
                    integer ver_fname_src_mw_pos             ; // := ver_fname_src_mw_pos;
                    boolean ver_fname_src_mw                 ; // := ver_fname_src_mw;
                    integer ver_fname_src_nt_pos             ; // := ver_fname_src_nt_pos;
                    boolean ver_fname_src_nt                 ; // := ver_fname_src_nt;
                    integer ver_fname_src_p_pos              ; // := ver_fname_src_p_pos;
                    boolean ver_fname_src_p                  ; // := ver_fname_src_p;
                    integer ver_fname_src_pl_pos             ; // := ver_fname_src_pl_pos;
                    boolean ver_fname_src_pl                 ; // := ver_fname_src_pl;
                    integer ver_fname_src_tn_pos             ; // := ver_fname_src_tn_pos;
                    boolean ver_fname_src_tn                 ; // := ver_fname_src_tn;
                    integer ver_fname_src_ts_pos             ; // := ver_fname_src_ts_pos;
                    boolean ver_fname_src_ts                 ; // := ver_fname_src_ts;
                    integer ver_fname_src_tu_pos             ; // := ver_fname_src_tu_pos;
                    boolean ver_fname_src_tu                 ; // := ver_fname_src_tu;
                    integer ver_fname_src_sl_pos             ; // := ver_fname_src_sl_pos;
                    boolean ver_fname_src_sl                 ; // := ver_fname_src_sl;
                    integer ver_fname_src_v_pos              ; // := ver_fname_src_v_pos;
                    boolean ver_fname_src_v                  ; // := ver_fname_src_v;
                    integer ver_fname_src_vo_pos             ; // := ver_fname_src_vo_pos;
                    boolean ver_fname_src_vo                 ; // := ver_fname_src_vo;
                    integer ver_fname_src_w_pos              ; // := ver_fname_src_w_pos;
                    boolean ver_fname_src_w                  ; // := ver_fname_src_w;
                    integer ver_fname_src_wp_pos             ; // := ver_fname_src_wp_pos;
                    boolean ver_fname_src_wp                 ; // := ver_fname_src_wp;
                    integer ver_lname_src_cnt                ; // := ver_lname_src_cnt;
                    boolean ver_lname_src_pop                ; // := ver_lname_src_pop;
                    integer ver_lname_src_rcnt               ; // := ver_lname_src_rcnt;
                    string ver_lname_src_fsrc               ; // := ver_lname_src_fsrc;
                    integer ver_lname_src_ak_pos             ; // := ver_lname_src_ak_pos;
                    boolean ver_lname_src_ak                 ; // := ver_lname_src_ak;
                    integer ver_lname_src_am_pos             ; // := ver_lname_src_am_pos;
                    boolean ver_lname_src_am                 ; // := ver_lname_src_am;
                    integer ver_lname_src_ar_pos             ; // := ver_lname_src_ar_pos;
                    boolean ver_lname_src_ar                 ; // := ver_lname_src_ar;
                    integer ver_lname_src_ba_pos             ; // := ver_lname_src_ba_pos;
                    boolean ver_lname_src_ba                 ; // := ver_lname_src_ba;
                    integer ver_lname_src_cg_pos             ; // := ver_lname_src_cg_pos;
                    boolean ver_lname_src_cg                 ; // := ver_lname_src_cg;
                    integer ver_lname_src_co_pos             ; // := ver_lname_src_co_pos;
                    boolean ver_lname_src_co                 ; // := ver_lname_src_co;
                    integer ver_lname_src_cy_pos             ; // := ver_lname_src_cy_pos;
                    boolean ver_lname_src_cy                 ; // := ver_lname_src_cy;
                    integer ver_lname_src_da_pos             ; // := ver_lname_src_da_pos;
                    boolean ver_lname_src_da                 ; // := ver_lname_src_da;
                    integer ver_lname_src_d_pos              ; // := ver_lname_src_d_pos;
                    boolean ver_lname_src_d                  ; // := ver_lname_src_d;
                    integer ver_lname_src_dl_pos             ; // := ver_lname_src_dl_pos;
                    boolean ver_lname_src_dl                 ; // := ver_lname_src_dl;
                    integer ver_lname_src_ds_pos             ; // := ver_lname_src_ds_pos;
                    boolean ver_lname_src_ds                 ; // := ver_lname_src_ds;
                    integer ver_lname_src_de_pos             ; // := ver_lname_src_de_pos;
                    boolean ver_lname_src_de                 ; // := ver_lname_src_de;
                    integer ver_lname_src_eb_pos             ; // := ver_lname_src_eb_pos;
                    boolean ver_lname_src_eb                 ; // := ver_lname_src_eb;
                    integer ver_lname_src_em_pos             ; // := ver_lname_src_em_pos;
                    boolean ver_lname_src_em                 ; // := ver_lname_src_em;
                    integer ver_lname_src_e1_pos             ; // := ver_lname_src_e1_pos;
                    boolean ver_lname_src_e1                 ; // := ver_lname_src_e1;
                    integer ver_lname_src_e2_pos             ; // := ver_lname_src_e2_pos;
                    boolean ver_lname_src_e2                 ; // := ver_lname_src_e2;
                    integer ver_lname_src_e3_pos             ; // := ver_lname_src_e3_pos;
                    boolean ver_lname_src_e3                 ; // := ver_lname_src_e3;
                    integer ver_lname_src_e4_pos             ; // := ver_lname_src_e4_pos;
                    boolean ver_lname_src_e4                 ; // := ver_lname_src_e4;
                    integer ver_lname_src_en_pos             ; // := ver_lname_src_en_pos;
                    boolean ver_lname_src_en                 ; // := ver_lname_src_en;
                    integer ver_lname_src_eq_pos             ; // := ver_lname_src_eq_pos;
                    boolean ver_lname_src_eq                 ; // := ver_lname_src_eq;
                    integer ver_lname_src_fe_pos             ; // := ver_lname_src_fe_pos;
                    boolean ver_lname_src_fe                 ; // := ver_lname_src_fe;
                    integer ver_lname_src_ff_pos             ; // := ver_lname_src_ff_pos;
                    boolean ver_lname_src_ff                 ; // := ver_lname_src_ff;
                    integer ver_lname_src_fr_pos             ; // := ver_lname_src_fr_pos;
                    boolean ver_lname_src_fr                 ; // := ver_lname_src_fr;
                    integer ver_lname_src_l2_pos             ; // := ver_lname_src_l2_pos;
                    boolean ver_lname_src_l2                 ; // := ver_lname_src_l2;
                    integer ver_lname_src_li_pos             ; // := ver_lname_src_li_pos;
                    boolean ver_lname_src_li                 ; // := ver_lname_src_li;
                    integer ver_lname_src_mw_pos             ; // := ver_lname_src_mw_pos;
                    boolean ver_lname_src_mw                 ; // := ver_lname_src_mw;
                    integer ver_lname_src_nt_pos             ; // := ver_lname_src_nt_pos;
                    boolean ver_lname_src_nt                 ; // := ver_lname_src_nt;
                    integer ver_lname_src_p_pos              ; // := ver_lname_src_p_pos;
                    boolean ver_lname_src_p                  ; // := ver_lname_src_p;
                    integer ver_lname_src_pl_pos             ; // := ver_lname_src_pl_pos;
                    boolean ver_lname_src_pl                 ; // := ver_lname_src_pl;
                    integer ver_lname_src_tn_pos             ; // := ver_lname_src_tn_pos;
                    boolean ver_lname_src_tn                 ; // := ver_lname_src_tn;
                    integer ver_lname_src_ts_pos             ; // := ver_lname_src_ts_pos;
                    boolean ver_lname_src_ts                 ; // := ver_lname_src_ts;
                    integer ver_lname_src_tu_pos             ; // := ver_lname_src_tu_pos;
                    boolean ver_lname_src_tu                 ; // := ver_lname_src_tu;
                    integer ver_lname_src_sl_pos             ; // := ver_lname_src_sl_pos;
                    boolean ver_lname_src_sl                 ; // := ver_lname_src_sl;
                    integer ver_lname_src_v_pos              ; // := ver_lname_src_v_pos;
                    boolean ver_lname_src_v                  ; // := ver_lname_src_v;
                    integer ver_lname_src_vo_pos             ; // := ver_lname_src_vo_pos;
                    boolean ver_lname_src_vo                 ; // := ver_lname_src_vo;
                    integer ver_lname_src_w_pos              ; // := ver_lname_src_w_pos;
                    boolean ver_lname_src_w                  ; // := ver_lname_src_w;
                    integer ver_lname_src_wp_pos             ; // := ver_lname_src_wp_pos;
                    boolean ver_lname_src_wp                 ; // := ver_lname_src_wp;
                    integer ver_addr_src_cnt                 ; // := ver_addr_src_cnt;
                    boolean ver_addr_src_pop                 ; // := ver_addr_src_pop;
                    integer ver_addr_src_rcnt                ; // := ver_addr_src_rcnt;
                    string ver_addr_src_fsrc                ; // := ver_addr_src_fsrc;
                    integer ver_addr_src_ak_pos              ; // := ver_addr_src_ak_pos;
                    boolean ver_addr_src_ak                  ; // := ver_addr_src_ak;
                    integer ver_addr_src_am_pos              ; // := ver_addr_src_am_pos;
                    boolean ver_addr_src_am                  ; // := ver_addr_src_am;
                    integer ver_addr_src_ar_pos              ; // := ver_addr_src_ar_pos;
                    boolean ver_addr_src_ar                  ; // := ver_addr_src_ar;
                    integer ver_addr_src_ba_pos              ; // := ver_addr_src_ba_pos;
                    boolean ver_addr_src_ba                  ; // := ver_addr_src_ba;
                    integer ver_addr_src_cg_pos              ; // := ver_addr_src_cg_pos;
                    boolean ver_addr_src_cg                  ; // := ver_addr_src_cg;
                    integer ver_addr_src_co_pos              ; // := ver_addr_src_co_pos;
                    boolean ver_addr_src_co                  ; // := ver_addr_src_co;
                    integer ver_addr_src_cy_pos              ; // := ver_addr_src_cy_pos;
                    boolean ver_addr_src_cy                  ; // := ver_addr_src_cy;
                    integer ver_addr_src_da_pos              ; // := ver_addr_src_da_pos;
                    boolean ver_addr_src_da                  ; // := ver_addr_src_da;
                    integer ver_addr_src_d_pos               ; // := ver_addr_src_d_pos;
                    boolean ver_addr_src_d                   ; // := ver_addr_src_d;
                    integer ver_addr_src_dl_pos              ; // := ver_addr_src_dl_pos;
                    boolean ver_addr_src_dl                  ; // := ver_addr_src_dl;
                    integer ver_addr_src_ds_pos              ; // := ver_addr_src_ds_pos;
                    boolean ver_addr_src_ds                  ; // := ver_addr_src_ds;
                    integer ver_addr_src_de_pos              ; // := ver_addr_src_de_pos;
                    boolean ver_addr_src_de                  ; // := ver_addr_src_de;
                    integer ver_addr_src_eb_pos              ; // := ver_addr_src_eb_pos;
                    boolean ver_addr_src_eb                  ; // := ver_addr_src_eb;
                    integer ver_addr_src_em_pos              ; // := ver_addr_src_em_pos;
                    boolean ver_addr_src_em                  ; // := ver_addr_src_em;
                    integer ver_addr_src_e1_pos              ; // := ver_addr_src_e1_pos;
                    boolean ver_addr_src_e1                  ; // := ver_addr_src_e1;
                    integer ver_addr_src_e2_pos              ; // := ver_addr_src_e2_pos;
                    boolean ver_addr_src_e2                  ; // := ver_addr_src_e2;
                    integer ver_addr_src_e3_pos              ; // := ver_addr_src_e3_pos;
                    boolean ver_addr_src_e3                  ; // := ver_addr_src_e3;
                    integer ver_addr_src_e4_pos              ; // := ver_addr_src_e4_pos;
                    boolean ver_addr_src_e4                  ; // := ver_addr_src_e4;
                    integer ver_addr_src_en_pos              ; // := ver_addr_src_en_pos;
                    boolean ver_addr_src_en                  ; // := ver_addr_src_en;
                    integer ver_addr_src_eq_pos              ; // := ver_addr_src_eq_pos;
                    boolean ver_addr_src_eq                  ; // := ver_addr_src_eq;
                    integer ver_addr_src_fe_pos              ; // := ver_addr_src_fe_pos;
                    boolean ver_addr_src_fe                  ; // := ver_addr_src_fe;
                    integer ver_addr_src_ff_pos              ; // := ver_addr_src_ff_pos;
                    boolean ver_addr_src_ff                  ; // := ver_addr_src_ff;
                    integer ver_addr_src_fr_pos              ; // := ver_addr_src_fr_pos;
                    boolean ver_addr_src_fr                  ; // := ver_addr_src_fr;
                    integer ver_addr_src_l2_pos              ; // := ver_addr_src_l2_pos;
                    boolean ver_addr_src_l2                  ; // := ver_addr_src_l2;
                    integer ver_addr_src_li_pos              ; // := ver_addr_src_li_pos;
                    boolean ver_addr_src_li                  ; // := ver_addr_src_li;
                    integer ver_addr_src_mw_pos              ; // := ver_addr_src_mw_pos;
                    boolean ver_addr_src_mw                  ; // := ver_addr_src_mw;
                    integer ver_addr_src_nt_pos              ; // := ver_addr_src_nt_pos;
                    boolean ver_addr_src_nt                  ; // := ver_addr_src_nt;
                    integer ver_addr_src_p_pos               ; // := ver_addr_src_p_pos;
                    boolean ver_addr_src_p                   ; // := ver_addr_src_p;
                    integer ver_addr_src_pl_pos              ; // := ver_addr_src_pl_pos;
                    boolean ver_addr_src_pl                  ; // := ver_addr_src_pl;
                    integer ver_addr_src_tn_pos              ; // := ver_addr_src_tn_pos;
                    boolean ver_addr_src_tn                  ; // := ver_addr_src_tn;
                    integer ver_addr_src_ts_pos              ; // := ver_addr_src_ts_pos;
                    boolean ver_addr_src_ts                  ; // := ver_addr_src_ts;
                    integer ver_addr_src_tu_pos              ; // := ver_addr_src_tu_pos;
                    boolean ver_addr_src_tu                  ; // := ver_addr_src_tu;
                    integer ver_addr_src_sl_pos              ; // := ver_addr_src_sl_pos;
                    boolean ver_addr_src_sl                  ; // := ver_addr_src_sl;
                    integer ver_addr_src_v_pos               ; // := ver_addr_src_v_pos;
                    boolean ver_addr_src_v                   ; // := ver_addr_src_v;
                    integer ver_addr_src_vo_pos              ; // := ver_addr_src_vo_pos;
                    boolean ver_addr_src_vo                  ; // := ver_addr_src_vo;
                    integer ver_addr_src_w_pos               ; // := ver_addr_src_w_pos;
                    boolean ver_addr_src_w                   ; // := ver_addr_src_w;
                    integer ver_addr_src_wp_pos              ; // := ver_addr_src_wp_pos;
                    boolean ver_addr_src_wp                  ; // := ver_addr_src_wp;
                    integer ver_ssn_src_cnt                  ; // := ver_ssn_src_cnt;
                    boolean ver_ssn_src_pop                  ; // := ver_ssn_src_pop;
                    integer ver_ssn_src_rcnt                 ; // := ver_ssn_src_rcnt;
                    string ver_ssn_src_fsrc                 ; // := ver_ssn_src_fsrc;
                    integer ver_ssn_src_ak_pos               ; // := ver_ssn_src_ak_pos;
                    boolean ver_ssn_src_ak                   ; // := ver_ssn_src_ak;
                    integer ver_ssn_src_am_pos               ; // := ver_ssn_src_am_pos;
                    boolean ver_ssn_src_am                   ; // := ver_ssn_src_am;
                    integer ver_ssn_src_ar_pos               ; // := ver_ssn_src_ar_pos;
                    boolean ver_ssn_src_ar                   ; // := ver_ssn_src_ar;
                    integer ver_ssn_src_ba_pos               ; // := ver_ssn_src_ba_pos;
                    boolean ver_ssn_src_ba                   ; // := ver_ssn_src_ba;
                    integer ver_ssn_src_cg_pos               ; // := ver_ssn_src_cg_pos;
                    boolean ver_ssn_src_cg                   ; // := ver_ssn_src_cg;
                    integer ver_ssn_src_co_pos               ; // := ver_ssn_src_co_pos;
                    boolean ver_ssn_src_co                   ; // := ver_ssn_src_co;
                    integer ver_ssn_src_cy_pos               ; // := ver_ssn_src_cy_pos;
                    boolean ver_ssn_src_cy                   ; // := ver_ssn_src_cy;
                    integer ver_ssn_src_da_pos               ; // := ver_ssn_src_da_pos;
                    boolean ver_ssn_src_da                   ; // := ver_ssn_src_da;
                    integer ver_ssn_src_d_pos                ; // := ver_ssn_src_d_pos;
                    boolean ver_ssn_src_d                    ; // := ver_ssn_src_d;
                    integer ver_ssn_src_dl_pos               ; // := ver_ssn_src_dl_pos;
                    boolean ver_ssn_src_dl                   ; // := ver_ssn_src_dl;
                    integer ver_ssn_src_ds_pos               ; // := ver_ssn_src_ds_pos;
                    boolean ver_ssn_src_ds                   ; // := ver_ssn_src_ds;
                    integer ver_ssn_src_de_pos               ; // := ver_ssn_src_de_pos;
                    boolean ver_ssn_src_de                   ; // := ver_ssn_src_de;
                    integer ver_ssn_src_eb_pos               ; // := ver_ssn_src_eb_pos;
                    boolean ver_ssn_src_eb                   ; // := ver_ssn_src_eb;
                    integer ver_ssn_src_em_pos               ; // := ver_ssn_src_em_pos;
                    boolean ver_ssn_src_em                   ; // := ver_ssn_src_em;
                    integer ver_ssn_src_e1_pos               ; // := ver_ssn_src_e1_pos;
                    boolean ver_ssn_src_e1                   ; // := ver_ssn_src_e1;
                    integer ver_ssn_src_e2_pos               ; // := ver_ssn_src_e2_pos;
                    boolean ver_ssn_src_e2                   ; // := ver_ssn_src_e2;
                    integer ver_ssn_src_e3_pos               ; // := ver_ssn_src_e3_pos;
                    boolean ver_ssn_src_e3                   ; // := ver_ssn_src_e3;
                    integer ver_ssn_src_e4_pos               ; // := ver_ssn_src_e4_pos;
                    boolean ver_ssn_src_e4                   ; // := ver_ssn_src_e4;
                    integer ver_ssn_src_en_pos               ; // := ver_ssn_src_en_pos;
                    boolean ver_ssn_src_en                   ; // := ver_ssn_src_en;
                    integer ver_ssn_src_eq_pos               ; // := ver_ssn_src_eq_pos;
                    boolean ver_ssn_src_eq                   ; // := ver_ssn_src_eq;
                    integer ver_ssn_src_fe_pos               ; // := ver_ssn_src_fe_pos;
                    boolean ver_ssn_src_fe                   ; // := ver_ssn_src_fe;
                    integer ver_ssn_src_ff_pos               ; // := ver_ssn_src_ff_pos;
                    boolean ver_ssn_src_ff                   ; // := ver_ssn_src_ff;
                    integer ver_ssn_src_fr_pos               ; // := ver_ssn_src_fr_pos;
                    boolean ver_ssn_src_fr                   ; // := ver_ssn_src_fr;
                    integer ver_ssn_src_l2_pos               ; // := ver_ssn_src_l2_pos;
                    boolean ver_ssn_src_l2                   ; // := ver_ssn_src_l2;
                    integer ver_ssn_src_li_pos               ; // := ver_ssn_src_li_pos;
                    boolean ver_ssn_src_li                   ; // := ver_ssn_src_li;
                    integer ver_ssn_src_mw_pos               ; // := ver_ssn_src_mw_pos;
                    boolean ver_ssn_src_mw                   ; // := ver_ssn_src_mw;
                    integer ver_ssn_src_nt_pos               ; // := ver_ssn_src_nt_pos;
                    boolean ver_ssn_src_nt                   ; // := ver_ssn_src_nt;
                    integer ver_ssn_src_p_pos                ; // := ver_ssn_src_p_pos;
                    boolean ver_ssn_src_p                    ; // := ver_ssn_src_p;
                    integer ver_ssn_src_pl_pos               ; // := ver_ssn_src_pl_pos;
                    boolean ver_ssn_src_pl                   ; // := ver_ssn_src_pl;
                    integer ver_ssn_src_tn_pos               ; // := ver_ssn_src_tn_pos;
                    boolean ver_ssn_src_tn                   ; // := ver_ssn_src_tn;
                    integer ver_ssn_src_ts_pos               ; // := ver_ssn_src_ts_pos;
                    boolean ver_ssn_src_ts                   ; // := ver_ssn_src_ts;
                    integer ver_ssn_src_tu_pos               ; // := ver_ssn_src_tu_pos;
                    boolean ver_ssn_src_tu                   ; // := ver_ssn_src_tu;
                    integer ver_ssn_src_sl_pos               ; // := ver_ssn_src_sl_pos;
                    boolean ver_ssn_src_sl                   ; // := ver_ssn_src_sl;
                    integer ver_ssn_src_v_pos                ; // := ver_ssn_src_v_pos;
                    boolean ver_ssn_src_v                    ; // := ver_ssn_src_v;
                    integer ver_ssn_src_vo_pos               ; // := ver_ssn_src_vo_pos;
                    boolean ver_ssn_src_vo                   ; // := ver_ssn_src_vo;
                    integer ver_ssn_src_w_pos                ; // := ver_ssn_src_w_pos;
                    boolean ver_ssn_src_w                    ; // := ver_ssn_src_w;
                    integer ver_ssn_src_wp_pos               ; // := ver_ssn_src_wp_pos;
                    boolean ver_ssn_src_wp                   ; // := ver_ssn_src_wp;
                    integer ver_dob_src_cnt                  ; // := ver_dob_src_cnt;
                    boolean ver_dob_src_pop                  ; // := ver_dob_src_pop;
                    integer ver_dob_src_rcnt                 ; // := ver_dob_src_rcnt;
                    string ver_dob_src_fsrc                 ; // := ver_dob_src_fsrc;
                    integer ver_dob_src_ak_pos               ; // := ver_dob_src_ak_pos;
                    boolean ver_dob_src_ak                   ; // := ver_dob_src_ak;
                    integer ver_dob_src_am_pos               ; // := ver_dob_src_am_pos;
                    boolean ver_dob_src_am                   ; // := ver_dob_src_am;
                    integer ver_dob_src_ar_pos               ; // := ver_dob_src_ar_pos;
                    boolean ver_dob_src_ar                   ; // := ver_dob_src_ar;
                    integer ver_dob_src_ba_pos               ; // := ver_dob_src_ba_pos;
                    boolean ver_dob_src_ba                   ; // := ver_dob_src_ba;
                    integer ver_dob_src_cg_pos               ; // := ver_dob_src_cg_pos;
                    boolean ver_dob_src_cg                   ; // := ver_dob_src_cg;
                    integer ver_dob_src_co_pos               ; // := ver_dob_src_co_pos;
                    boolean ver_dob_src_co                   ; // := ver_dob_src_co;
                    integer ver_dob_src_cy_pos               ; // := ver_dob_src_cy_pos;
                    boolean ver_dob_src_cy                   ; // := ver_dob_src_cy;
                    integer ver_dob_src_da_pos               ; // := ver_dob_src_da_pos;
                    boolean ver_dob_src_da                   ; // := ver_dob_src_da;
                    integer ver_dob_src_d_pos                ; // := ver_dob_src_d_pos;
                    boolean ver_dob_src_d                    ; // := ver_dob_src_d;
                    integer ver_dob_src_dl_pos               ; // := ver_dob_src_dl_pos;
                    boolean ver_dob_src_dl                   ; // := ver_dob_src_dl;
                    integer ver_dob_src_ds_pos               ; // := ver_dob_src_ds_pos;
                    boolean ver_dob_src_ds                   ; // := ver_dob_src_ds;
                    integer ver_dob_src_de_pos               ; // := ver_dob_src_de_pos;
                    boolean ver_dob_src_de                   ; // := ver_dob_src_de;
                    integer ver_dob_src_eb_pos               ; // := ver_dob_src_eb_pos;
                    boolean ver_dob_src_eb                   ; // := ver_dob_src_eb;
                    integer ver_dob_src_em_pos               ; // := ver_dob_src_em_pos;
                    boolean ver_dob_src_em                   ; // := ver_dob_src_em;
                    integer ver_dob_src_e1_pos               ; // := ver_dob_src_e1_pos;
                    boolean ver_dob_src_e1                   ; // := ver_dob_src_e1;
                    integer ver_dob_src_e2_pos               ; // := ver_dob_src_e2_pos;
                    boolean ver_dob_src_e2                   ; // := ver_dob_src_e2;
                    integer ver_dob_src_e3_pos               ; // := ver_dob_src_e3_pos;
                    boolean ver_dob_src_e3                   ; // := ver_dob_src_e3;
                    integer ver_dob_src_e4_pos               ; // := ver_dob_src_e4_pos;
                    boolean ver_dob_src_e4                   ; // := ver_dob_src_e4;
                    integer ver_dob_src_en_pos               ; // := ver_dob_src_en_pos;
                    boolean ver_dob_src_en                   ; // := ver_dob_src_en;
                    integer ver_dob_src_eq_pos               ; // := ver_dob_src_eq_pos;
                    boolean ver_dob_src_eq                   ; // := ver_dob_src_eq;
                    integer ver_dob_src_fe_pos               ; // := ver_dob_src_fe_pos;
                    boolean ver_dob_src_fe                   ; // := ver_dob_src_fe;
                    integer ver_dob_src_ff_pos               ; // := ver_dob_src_ff_pos;
                    boolean ver_dob_src_ff                   ; // := ver_dob_src_ff;
                    integer ver_dob_src_fr_pos               ; // := ver_dob_src_fr_pos;
                    boolean ver_dob_src_fr                   ; // := ver_dob_src_fr;
                    integer ver_dob_src_l2_pos               ; // := ver_dob_src_l2_pos;
                    boolean ver_dob_src_l2                   ; // := ver_dob_src_l2;
                    integer ver_dob_src_li_pos               ; // := ver_dob_src_li_pos;
                    boolean ver_dob_src_li                   ; // := ver_dob_src_li;
                    integer ver_dob_src_mw_pos               ; // := ver_dob_src_mw_pos;
                    boolean ver_dob_src_mw                   ; // := ver_dob_src_mw;
                    integer ver_dob_src_nt_pos               ; // := ver_dob_src_nt_pos;
                    boolean ver_dob_src_nt                   ; // := ver_dob_src_nt;
                    integer ver_dob_src_p_pos                ; // := ver_dob_src_p_pos;
                    boolean ver_dob_src_p                    ; // := ver_dob_src_p;
                    integer ver_dob_src_pl_pos               ; // := ver_dob_src_pl_pos;
                    boolean ver_dob_src_pl                   ; // := ver_dob_src_pl;
                    integer ver_dob_src_tn_pos               ; // := ver_dob_src_tn_pos;
                    boolean ver_dob_src_tn                   ; // := ver_dob_src_tn;
                    integer ver_dob_src_ts_pos               ; // := ver_dob_src_ts_pos;
                    boolean ver_dob_src_ts                   ; // := ver_dob_src_ts;
                    integer ver_dob_src_tu_pos               ; // := ver_dob_src_tu_pos;
                    boolean ver_dob_src_tu                   ; // := ver_dob_src_tu;
                    integer ver_dob_src_sl_pos               ; // := ver_dob_src_sl_pos;
                    boolean ver_dob_src_sl                   ; // := ver_dob_src_sl;
                    integer ver_dob_src_v_pos                ; // := ver_dob_src_v_pos;
                    boolean ver_dob_src_v                    ; // := ver_dob_src_v;
                    integer ver_dob_src_vo_pos               ; // := ver_dob_src_vo_pos;
                    boolean ver_dob_src_vo                   ; // := ver_dob_src_vo;
                    integer ver_dob_src_w_pos                ; // := ver_dob_src_w_pos;
                    boolean ver_dob_src_w                    ; // := ver_dob_src_w;
                    integer ver_dob_src_wp_pos               ; // := ver_dob_src_wp_pos;
                    boolean ver_dob_src_wp                   ; // := ver_dob_src_wp;
                    integer email_src_cnt                    ; // := email_src_cnt;
                    boolean email_src_pop                    ; // := email_src_pop;
                    integer email_src_rcnt                   ; // := email_src_rcnt;
                    string email_src_fsrc                   ; // := email_src_fsrc;
                    integer email_src_aw_pos                 ; // := email_src_aw_pos;
                    boolean email_src_aw                     ; // := email_src_aw;
                    integer email_src_et_pos                 ; // := email_src_et_pos;
                    boolean email_src_et                     ; // := email_src_et;
                    integer email_src_wa_pos                 ; // := email_src_wa_pos;
                    boolean email_src_wa                     ; // := email_src_wa;
                    integer email_src_om_pos                 ; // := email_src_om_pos;
                    boolean email_src_om                     ; // := email_src_om;
                    integer email_src_m1_pos                 ; // := email_src_m1_pos;
                    boolean email_src_m1                     ; // := email_src_m1;
                    integer email_src_sc_pos                 ; // := email_src_sc_pos;
                    boolean email_src_sc                     ; // := email_src_sc;
                    integer email_src_dg_pos                 ; // := email_src_dg_pos;
                    boolean email_src_dg                     ; // := email_src_dg;
                    integer util_type_cnt                    ; // := util_type_cnt;
                    boolean util_type_pop                    ; // := util_type_pop;
                    integer util_type_rcnt                   ; // := util_type_rcnt;
                    string util_type_fsrc                   ; // := util_type_fsrc;
                    integer util_type_2_pos                  ; // := util_type_2_pos;
                    boolean util_type_2                      ; // := util_type_2;
                    integer util_type_1_pos                  ; // := util_type_1_pos;
                    boolean util_type_1                      ; // := util_type_1;
                    integer util_type_z_pos                  ; // := util_type_z_pos;
                    boolean util_type_z                      ; // := util_type_z;
                    integer util_inp_cnt                     ; // := util_inp_cnt;
                    boolean util_inp_pop                     ; // := util_inp_pop;
                    integer util_inp_rcnt                    ; // := util_inp_rcnt;
                    string util_inp_fsrc                    ; // := util_inp_fsrc;
                    integer util_inp_2_pos                   ; // := util_inp_2_pos;
                    boolean util_inp_2                       ; // := util_inp_2;
                    integer util_inp_1_pos                   ; // := util_inp_1_pos;
                    boolean util_inp_1                       ; // := util_inp_1;
                    integer util_inp_z_pos                   ; // := util_inp_z_pos;
                    boolean util_inp_z                       ; // := util_inp_z;
                    integer util_curr_cnt                    ; // := util_curr_cnt;
                    boolean util_curr_pop                    ; // := util_curr_pop;
                    integer util_curr_rcnt                   ; // := util_curr_rcnt;
                    string util_curr_fsrc                   ; // := util_curr_fsrc;
                    integer util_curr_2_pos                  ; // := util_curr_2_pos;
                    boolean util_curr_2                      ; // := util_curr_2;
                    integer util_curr_1_pos                  ; // := util_curr_1_pos;
                    boolean util_curr_1                      ; // := util_curr_1;
                    integer util_curr_z_pos                  ; // := util_curr_z_pos;
                    boolean util_curr_z                      ; // := util_curr_z;
                    integer nf_inq_communications_count      ; // := nf_inq_communications_count;
                    integer _in_dob                          ; // := _in_dob;
                    real yr_in_dob                        ; // := yr_in_dob;
                    integer yr_in_dob_int                    ; // := yr_in_dob_int;
                    integer rv_comb_age                      ; // := rv_comb_age;
                    integer nf_inq_communications_count24    ; // := nf_inq_communications_count24;
                    integer iv_estimated_income              ; // := iv_estimated_income;
                    integer nf_fp_varrisktype                ; // := nf_fp_varrisktype;
                    integer nf_inq_prepaidcards_count        ; // := nf_inq_prepaidcards_count;
                    integer rv_d32_criminal_count            ; // := rv_d32_criminal_count;
                    integer rv_d32_felony_count              ; // := rv_d32_felony_count;
                    integer rv_d31_bk_disposed_hist_count    ; // := rv_d31_bk_disposed_hist_count;
                    integer nf_inq_perssn_count01            ; // := nf_inq_perssn_count01;
                    integer rv_d34_liens_unreleased_ct84     ; // := rv_d34_liens_unreleased_ct84;
                    integer vo_pos                           ; // := vo_pos;
                    integer iv_src_voter_adl_count           ; // := iv_src_voter_adl_count;
                    integer rv_i61_inq_collection_count12    ; // := rv_i61_inq_collection_count12;
                    integer nf_inq_ssnsperadl_count03        ; // := nf_inq_ssnsperadl_count03;
                    integer nf_average_rel_age               ; // := nf_average_rel_age;
                    integer nf_fp_curraddrcartheftindex      ; // := nf_fp_curraddrcartheftindex;
                    integer rv_d33_eviction_count            ; // := rv_d33_eviction_count;
                    integer nf_inq_other_count24             ; // := nf_inq_other_count24;
                    integer corrssnaddr_src_cnt              ; // := corrssnaddr_src_cnt;
                    boolean corrssnaddr_src_pop              ; // := corrssnaddr_src_pop;
                    integer corrssnaddr_src_rcnt             ; // := corrssnaddr_src_rcnt;
                    string corrssnaddr_src_fsrc             ; // := corrssnaddr_src_fsrc;
                    integer corrssnaddr_src_ak_pos           ; // := corrssnaddr_src_ak_pos;
                    boolean corrssnaddr_src_ak               ; // := corrssnaddr_src_ak;
                    integer corrssnaddr_src_am_pos           ; // := corrssnaddr_src_am_pos;
                    boolean corrssnaddr_src_am               ; // := corrssnaddr_src_am;
                    integer corrssnaddr_src_ar_pos           ; // := corrssnaddr_src_ar_pos;
                    boolean corrssnaddr_src_ar               ; // := corrssnaddr_src_ar;
                    integer corrssnaddr_src_ba_pos           ; // := corrssnaddr_src_ba_pos;
                    boolean corrssnaddr_src_ba               ; // := corrssnaddr_src_ba;
                    integer corrssnaddr_src_cg_pos           ; // := corrssnaddr_src_cg_pos;
                    boolean corrssnaddr_src_cg               ; // := corrssnaddr_src_cg;
                    integer corrssnaddr_src_co_pos           ; // := corrssnaddr_src_co_pos;
                    boolean corrssnaddr_src_co               ; // := corrssnaddr_src_co;
                    integer corrssnaddr_src_cy_pos           ; // := corrssnaddr_src_cy_pos;
                    boolean corrssnaddr_src_cy               ; // := corrssnaddr_src_cy;
                    integer corrssnaddr_src_da_pos           ; // := corrssnaddr_src_da_pos;
                    boolean corrssnaddr_src_da               ; // := corrssnaddr_src_da;
                    integer corrssnaddr_src_d_pos            ; // := corrssnaddr_src_d_pos;
                    boolean corrssnaddr_src_d                ; // := corrssnaddr_src_d;
                    integer corrssnaddr_src_dl_pos           ; // := corrssnaddr_src_dl_pos;
                    boolean corrssnaddr_src_dl               ; // := corrssnaddr_src_dl;
                    integer corrssnaddr_src_ds_pos           ; // := corrssnaddr_src_ds_pos;
                    boolean corrssnaddr_src_ds               ; // := corrssnaddr_src_ds;
                    integer corrssnaddr_src_de_pos           ; // := corrssnaddr_src_de_pos;
                    boolean corrssnaddr_src_de               ; // := corrssnaddr_src_de;
                    integer corrssnaddr_src_eb_pos           ; // := corrssnaddr_src_eb_pos;
                    boolean corrssnaddr_src_eb               ; // := corrssnaddr_src_eb;
                    integer corrssnaddr_src_em_pos           ; // := corrssnaddr_src_em_pos;
                    boolean corrssnaddr_src_em               ; // := corrssnaddr_src_em;
                    integer corrssnaddr_src_e1_pos           ; // := corrssnaddr_src_e1_pos;
                    boolean corrssnaddr_src_e1               ; // := corrssnaddr_src_e1;
                    integer corrssnaddr_src_e2_pos           ; // := corrssnaddr_src_e2_pos;
                    boolean corrssnaddr_src_e2               ; // := corrssnaddr_src_e2;
                    integer corrssnaddr_src_e3_pos           ; // := corrssnaddr_src_e3_pos;
                    boolean corrssnaddr_src_e3               ; // := corrssnaddr_src_e3;
                    integer corrssnaddr_src_e4_pos           ; // := corrssnaddr_src_e4_pos;
                    boolean corrssnaddr_src_e4               ; // := corrssnaddr_src_e4;
                    integer corrssnaddr_src_en_pos           ; // := corrssnaddr_src_en_pos;
                    boolean corrssnaddr_src_en               ; // := corrssnaddr_src_en;
                    integer corrssnaddr_src_eq_pos           ; // := corrssnaddr_src_eq_pos;
                    boolean corrssnaddr_src_eq               ; // := corrssnaddr_src_eq;
                    integer corrssnaddr_src_fe_pos           ; // := corrssnaddr_src_fe_pos;
                    boolean corrssnaddr_src_fe               ; // := corrssnaddr_src_fe;
                    integer corrssnaddr_src_ff_pos           ; // := corrssnaddr_src_ff_pos;
                    boolean corrssnaddr_src_ff               ; // := corrssnaddr_src_ff;
                    integer corrssnaddr_src_fr_pos           ; // := corrssnaddr_src_fr_pos;
                    boolean corrssnaddr_src_fr               ; // := corrssnaddr_src_fr;
                    integer corrssnaddr_src_l2_pos           ; // := corrssnaddr_src_l2_pos;
                    boolean corrssnaddr_src_l2               ; // := corrssnaddr_src_l2;
                    integer corrssnaddr_src_li_pos           ; // := corrssnaddr_src_li_pos;
                    boolean corrssnaddr_src_li               ; // := corrssnaddr_src_li;
                    integer corrssnaddr_src_mw_pos           ; // := corrssnaddr_src_mw_pos;
                    boolean corrssnaddr_src_mw               ; // := corrssnaddr_src_mw;
                    integer corrssnaddr_src_nt_pos           ; // := corrssnaddr_src_nt_pos;
                    boolean corrssnaddr_src_nt               ; // := corrssnaddr_src_nt;
                    integer corrssnaddr_src_p_pos            ; // := corrssnaddr_src_p_pos;
                    boolean corrssnaddr_src_p                ; // := corrssnaddr_src_p;
                    integer corrssnaddr_src_pl_pos           ; // := corrssnaddr_src_pl_pos;
                    boolean corrssnaddr_src_pl               ; // := corrssnaddr_src_pl;
                    integer corrssnaddr_src_tn_pos           ; // := corrssnaddr_src_tn_pos;
                    boolean corrssnaddr_src_tn               ; // := corrssnaddr_src_tn;
                    integer corrssnaddr_src_ts_pos           ; // := corrssnaddr_src_ts_pos;
                    boolean corrssnaddr_src_ts               ; // := corrssnaddr_src_ts;
                    integer corrssnaddr_src_tu_pos           ; // := corrssnaddr_src_tu_pos;
                    boolean corrssnaddr_src_tu               ; // := corrssnaddr_src_tu;
                    integer corrssnaddr_src_sl_pos           ; // := corrssnaddr_src_sl_pos;
                    boolean corrssnaddr_src_sl               ; // := corrssnaddr_src_sl;
                    integer corrssnaddr_src_v_pos            ; // := corrssnaddr_src_v_pos;
                    boolean corrssnaddr_src_v                ; // := corrssnaddr_src_v;
                    integer corrssnaddr_src_vo_pos           ; // := corrssnaddr_src_vo_pos;
                    boolean corrssnaddr_src_vo               ; // := corrssnaddr_src_vo;
                    integer corrssnaddr_src_w_pos            ; // := corrssnaddr_src_w_pos;
                    boolean corrssnaddr_src_w                ; // := corrssnaddr_src_w;
                    integer corrssnaddr_src_wp_pos           ; // := corrssnaddr_src_wp_pos;
                    boolean corrssnaddr_src_wp               ; // := corrssnaddr_src_wp;
                    integer corrssnaddr_ct                   ; // := corrssnaddr_ct;
                    integer nf_corrssnaddr                   ; // := nf_corrssnaddr;
                    integer nf_hh_collections_ct             ; // := nf_hh_collections_ct;
                    integer rv_l79_adls_per_addr_c6          ; // := rv_l79_adls_per_addr_c6;
                    real nf_pct_rel_with_felony           ; // := nf_pct_rel_with_felony;
                    real dfsn_v01_w                       ; // := dfsn_v01_w;
                    real dfsn_v02_w                       ; // := dfsn_v02_w;
                    real dfsn_v03_w                       ; // := dfsn_v03_w;
                    real dfsn_v04_w                       ; // := dfsn_v04_w;
                    real dfsn_v05_w                       ; // := dfsn_v05_w;
                    real dfsn_v06_w                       ; // := dfsn_v06_w;
                    real dfsn_v07_w                       ; // := dfsn_v07_w;
                    real dfsn_v08_w                       ; // := dfsn_v08_w;
                    real dfsn_v09_w                       ; // := dfsn_v09_w;
                    real dfsn_v10_w                       ; // := dfsn_v10_w;
                    real dfsn_v11_w                       ; // := dfsn_v11_w;
                    real dfsn_v12_w                       ; // := dfsn_v12_w;
                    real dfsn_v13_w                       ; // := dfsn_v13_w;
                    real dfsn_v14_w                       ; // := dfsn_v14_w;
                    real dfsn_v15_w                       ; // := dfsn_v15_w;
                    real dfsn_v16_w                       ; // := dfsn_v16_w;
                    real dfsn_v17_w                       ; // := dfsn_v17_w;
                    real dfsn_v18_w                       ; // := dfsn_v18_w;
                    real dfsn_v19_w                       ; // := dfsn_v19_w;
                    real dfsn_v20_w                       ; // := dfsn_v20_w;
                    real dfsn_v21_w                       ; // := dfsn_v21_w;
                    real dfsn_v22_w                       ; // := dfsn_v22_w;
                    real dfsn_lgt                         ; // := dfsn_lgt;
                    integer fp1802_1_0                       ; // := fp1802_1_0;
                    boolean _ver_src_ds                      ; // := _ver_src_ds;
                    boolean _ver_src_de                      ; // := _ver_src_de;
                    boolean _ver_src_eq                      ; // := _ver_src_eq;
                    boolean _ver_src_en                      ; // := _ver_src_en;
                    boolean _ver_src_tn                      ; // := _ver_src_tn;
                    boolean _ver_src_tu                      ; // := _ver_src_tu;
                    integer _credit_source_cnt               ; // := _credit_source_cnt;
                    integer _ver_src_cnt                     ; // := _ver_src_cnt;
                    boolean _bureauonly                      ; // := _bureauonly;
                    boolean _derog                           ; // := _derog;
                    boolean _deceased                        ; // := _deceased;
                    boolean _ssnpriortodob                   ; // := _ssnpriortodob;
                    boolean _inputmiskeys                    ; // := _inputmiskeys;
                    boolean _multiplessns                    ; // := _multiplessns;
                    real _hh_strikes                      ; // := _hh_strikes;
                    integer stolenid                         ; // := stolenid;
                    integer manipulatedid                    ; // := manipulatedid;
                    integer manipulatedidpt2                 ; // := manipulatedidpt2;
                    integer suspiciousactivity               ; // := suspiciousactivity;
                    integer vulnerablevictim                 ; // := vulnerablevictim;
                    integer friendlyfraud                    ; // := friendlyfraud;
                    boolean ver_src_ak                       ; // := ver_src_ak;
                    boolean ver_src_am                       ; // := ver_src_am;
                    boolean ver_src_ar                       ; // := ver_src_ar;
                    boolean ver_src_ba                       ; // := ver_src_ba;
                    boolean ver_src_cg                       ; // := ver_src_cg;
                    boolean ver_src_co                       ; // := ver_src_co;
                    boolean ver_src_cy                       ; // := ver_src_cy;
                    boolean ver_src_da                       ; // := ver_src_da;
                    boolean ver_src_d                        ; // := ver_src_d;
                    boolean ver_src_dl                       ; // := ver_src_dl;
                    boolean ver_src_ds                       ; // := ver_src_ds;
                    boolean ver_src_de                       ; // := ver_src_de;
                    boolean ver_src_eb                       ; // := ver_src_eb;
                    boolean ver_src_em                       ; // := ver_src_em;
                    boolean ver_src_e1                       ; // := ver_src_e1;
                    boolean ver_src_e2                       ; // := ver_src_e2;
                    boolean ver_src_e3                       ; // := ver_src_e3;
                    boolean ver_src_e4                       ; // := ver_src_e4;
                    boolean ver_src_en                       ; // := ver_src_en;
                    boolean ver_src_eq                       ; // := ver_src_eq;
                    boolean ver_src_fe                       ; // := ver_src_fe;
                    boolean ver_src_ff                       ; // := ver_src_ff;
                    boolean ver_src_fr                       ; // := ver_src_fr;
                    boolean ver_src_l2                       ; // := ver_src_l2;
                    boolean ver_src_li                       ; // := ver_src_li;
                    boolean ver_src_mw                       ; // := ver_src_mw;
                    boolean ver_src_nt                       ; // := ver_src_nt;
                    boolean ver_src_p                        ; // := ver_src_p;
                    boolean ver_src_pl                       ; // := ver_src_pl;
                    boolean ver_src_tn                       ; // := ver_src_tn;
                    boolean ver_src_ts                       ; // := ver_src_ts;
                    boolean ver_src_tu                       ; // := ver_src_tu;
                    boolean ver_src_sl                       ; // := ver_src_sl;
                    boolean ver_src_v                        ; // := ver_src_v;
                    boolean ver_src_vo                       ; // := ver_src_vo;
                    boolean ver_src_w                        ; // := ver_src_w;
                    boolean ver_src_wp                       ; // := ver_src_wp;
                    integer src_bureau                       ; // := src_bureau;
                    integer src_behavioral                   ; // := src_behavioral;
                    integer src_inperson                     ; // := src_inperson;
                    integer syntheticid2                     ; // := syntheticid2;
                    integer stolenc_fp1802_1_0               ; // := stolenc_fp1802_1_0;
                    integer manip2c_fp1802_1_0               ; // := manip2c_fp1802_1_0;
                    integer synth2c_fp1802_1_0               ; // := synth2c_fp1802_1_0;
                    integer suspactc_fp1802_1_0              ; // := suspactc_fp1802_1_0;
                    integer vulnvicc_fp1802_1_0              ; // := vulnvicc_fp1802_1_0;
                    integer friendlyc_fp1802_1_0             ; // := friendlyc_fp1802_1_0;
                    integer custstolidindex                  ; // := custstolidindex;
                    integer custmanipidindex                 ; // := custmanipidindex;
                    integer custsynthidindex                 ; // := custsynthidindex;
                    integer custsuspactindex                 ; // := custsuspactindex;
                    integer custvulnvicindex                 ; // := custvulnvicindex;
                    integer custfriendfrdindex               ; // := custfriendfrdindex;


	
	
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
	inq_perssn_count01               := le.acc_logs.inq_perssn_count01;
	liens_unreleased_count84         := le.bjl.liens_unreleased_count84;
	inq_ssnsperadl_count03           := le.acc_logs.inq_ssnsperadl_count03;
	corrssnaddr_sources              := le.header_summary.corrssnaddr_sources;
	truedid                          := le.truedid;
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
	ver_sources_last_seen            := le.header_summary.ver_sources_last_seen_date;
	ver_sources_count                := le.header_summary.ver_sources_recordcount;
	ver_fname_sources                := le.header_summary.ver_fname_sources;
	ver_lname_sources                := le.header_summary.ver_lname_sources;
	ver_addr_sources                 := le.header_summary.ver_addr_sources;
	ver_ssn_sources                  := le.header_summary.ver_ssn_sources;
	ver_dob_sources                  := le.header_summary.ver_dob_sources;
	voter_avail                      := le.available_sources.voter;
	fnamepop                         := le.input_validation.firstname;
	lnamepop                         := le.input_validation.lastname;
	addrpop                          := le.input_validation.address;
	ssnlength                        := le.input_validation.ssn_length;
	util_adl_type_list               := le.utility.utili_adl_type;
	util_add_input_type_list         := le.utility.utili_addr1_type;
	util_add_curr_type_list          := le.utility.utili_addr2_type;
	add_input_house_number_match     := le.address_verification.input_address_information.house_number_match;
	addrs_prison_history             := le.other_address_info.isprison;
	ssns_per_adl                     := le.velocity_counters.ssns_per_adl;
	ssns_per_adl_c6                  := le.velocity_counters.ssns_per_adl_created_6months;
	//lnames_per_adl_c6                := if(isFCRA, 0, le.velocity_counters.lnames_per_adl)_created_6months;
	lnames_per_adl_c6                :=if(isFCRA, 0, le.velocity_counters.lnames_per_adl180);
  adls_per_addr_c6                 := le.velocity_counters.adls_per_addr_created_6months;
	invalid_ssns_per_adl             := le.velocity_counters.invalid_ssns_per_adl;
	inq_count03                      := le.acc_logs.inquiries.count03;
	inq_collection_count12           := le.acc_logs.collection.count12;
	inq_communications_count         := le.acc_logs.communications.counttotal;
	inq_communications_count24       := le.acc_logs.communications.count24;
	inq_highriskcredit_count12       := le.acc_logs.highriskcredit.count12;
	inq_other_count24                := le.acc_logs.other.count24;
	inq_prepaidcards_count           := le.acc_logs.prepaidcards.counttotal;
	stl_inq_count                    := le.impulse.count;
	email_source_list                := le.email_summary.email_source_list;
	attr_num_unrel_liens60           := le.bjl.liens_unreleased_count60;
	attr_eviction_count              := le.bjl.eviction_count;
	fp_varrisktype                   := le.fdattributesv2.variationrisklevel;
	fp_curraddrcartheftindex         := le.fdattributesv2.curraddrcartheftindex;
	bk_disposed_historical_count     := le.bjl.bk_disposed_historical_count;
	criminal_count                   := le.bjl.criminal_count;
	felony_count                     := le.bjl.felony_count;
	hh_members_ct                    := le.hhid_summary.hh_members_ct;
	hh_collections_ct                := le.hhid_summary.hh_collections_ct;
	hh_payday_loan_users             := le.hhid_summary.hh_payday_loan_users;
	hh_members_w_derog               := le.hhid_summary.hh_members_w_derog;
	hh_criminals                     := le.hhid_summary.hh_criminals;
	rel_count                        := le.relatives.relative_count;
	rel_felony_count                 := le.relatives.relative_felony_count;
	rel_ageunder20_count             := le.relatives.relative_ageunder20_count;
	rel_ageunder30_count             := le.relatives.relative_ageunder30_count;
	rel_ageunder40_count             := le.relatives.relative_ageunder40_count;
	rel_ageunder50_count             := le.relatives.relative_ageunder50_count;
	rel_ageunder60_count             := le.relatives.relative_ageunder60_count;
	rel_ageunder70_count             := le.relatives.relative_ageunder70_count;
	rel_ageover70_count              := le.relatives.relative_ageover70_count;
	inferred_age                     := le.inferred_age;
	estimated_income                 := le.estimated_income;

	/* ***********************************************************
	 *   Generated ECL         *
	 ************************************************************* */



NULL := -999999999;

sysdate := common.sas_date(if(le.historydate=999999, (string8)std.Date.Today(), (string6)le.historydate+'01'));

ver_src_cnt := __common__( Models.Common.countw((string)(ver_sources), ' !$%&()*+,-./ );<^|') );

ver_src_pop := __common__( ver_src_cnt > 0 );

ver_src_rcnt_37 := __common__( 0 );

ver_src_fsrc := __common__( Models.Common.getw(ver_sources, 1) );

ver_src_fsrc_fdate := __common__( Models.Common.getw(ver_sources_first_seen, 1) );

//ver_src_fsrc_fdate2 := __common__( common.sas_date((string)(ver_src_fsrc_fdate)) );
ver_src_fsrc_fdate2 := __common__( Models.common.sas_date((string)(ver_src_fsrc_fdate)) );

yr_ver_src_fsrc_fdate := __common__( if(min(sysdate, ver_src_fsrc_fdate2) = NULL, NULL, (sysdate - ver_src_fsrc_fdate2) / 365.25) );

mth_ver_src_fsrc_fdate := __common__( if(min(sysdate, ver_src_fsrc_fdate2) = NULL, NULL, (sysdate - ver_src_fsrc_fdate2) / 30.5) );

// yr_ver_src_fsrc_fdate :=  __common__( if(min(sysdate, ver_src_fsrc_fdate2) = NULL, NULL, roundup((sysdate - ver_src_fsrc_fdate2) / 365.25)));

// mth_ver_src_fsrc_fdate :=  __common__( if(min(sysdate, ver_src_fsrc_fdate2) = NULL, NULL, roundup((sysdate - ver_src_fsrc_fdate2) / 30.5)));



ver_src_ak_pos := __common__( Models.Common.findw_cpp(ver_sources, 'AK' , '  ,', 'ie') );

ver_src_ak_1 := __common__( ver_src_ak_pos > 0 );

_ver_src_fdate_ak := __common__( if(ver_src_ak_pos > 0, Models.Common.getw(ver_sources_first_seen, ver_src_ak_pos), '0') );

ver_src_fdate_ak := __common__( common.sas_date((string)(_ver_src_fdate_ak)) );

_ver_src_ldate_ak := __common__( if(ver_src_ak_pos > 0, Models.Common.getw(ver_sources_last_seen, ver_src_ak_pos), '0') );

ver_src_ldate_ak := __common__( common.sas_date((string)(_ver_src_ldate_ak)) );

ver_src_cnt_ak := __common__( if(ver_src_ak_pos > 0, (real)Models.Common.getw(ver_sources_count, ver_src_ak_pos), 0) );

ver_src_rcnt_36 := __common__( ver_src_rcnt_37 + ver_src_cnt_ak );

ver_src_am_pos := __common__( Models.Common.findw_cpp(ver_sources, 'AM' , '  ,', 'ie') );

ver_src_am_1 := __common__( ver_src_am_pos > 0 );

_ver_src_fdate_am := __common__( if(ver_src_am_pos > 0, Models.Common.getw(ver_sources_first_seen, ver_src_am_pos), '0') );

ver_src_fdate_am := __common__( common.sas_date((string)(_ver_src_fdate_am)) );

_ver_src_ldate_am := __common__( if(ver_src_am_pos > 0, Models.Common.getw(ver_sources_last_seen, ver_src_am_pos), '0') );

ver_src_ldate_am := __common__( common.sas_date((string)(_ver_src_ldate_am)) );

ver_src_cnt_am := __common__( if(ver_src_am_pos > 0, (real)Models.Common.getw(ver_sources_count, ver_src_am_pos), 0) );

ver_src_rcnt_35 := __common__( ver_src_rcnt_36 + ver_src_cnt_am );

ver_src_ar_pos := __common__( Models.Common.findw_cpp(ver_sources, 'AR' , '  ,', 'ie') );

ver_src_ar_1 := __common__( ver_src_ar_pos > 0 );

_ver_src_fdate_ar := __common__( if(ver_src_ar_pos > 0, Models.Common.getw(ver_sources_first_seen, ver_src_ar_pos), '0') );

ver_src_fdate_ar := __common__( common.sas_date((string)(_ver_src_fdate_ar)) );

_ver_src_ldate_ar := __common__( if(ver_src_ar_pos > 0, Models.Common.getw(ver_sources_last_seen, ver_src_ar_pos), '0') );

ver_src_ldate_ar := __common__( common.sas_date((string)(_ver_src_ldate_ar)) );

ver_src_cnt_ar := __common__( if(ver_src_ar_pos > 0, (real)Models.Common.getw(ver_sources_count, ver_src_ar_pos), 0) );

ver_src_rcnt_34 := __common__( ver_src_rcnt_35 + ver_src_cnt_ar );

ver_src_ba_pos := __common__( Models.Common.findw_cpp(ver_sources, 'BA' , '  ,', 'ie') );

ver_src_ba_1 := __common__( ver_src_ba_pos > 0 );

_ver_src_fdate_ba := __common__( if(ver_src_ba_pos > 0, Models.Common.getw(ver_sources_first_seen, ver_src_ba_pos), '0') );

ver_src_fdate_ba := __common__( common.sas_date((string)(_ver_src_fdate_ba)) );

_ver_src_ldate_ba := __common__( if(ver_src_ba_pos > 0, Models.Common.getw(ver_sources_last_seen, ver_src_ba_pos), '0') );

ver_src_ldate_ba := __common__( common.sas_date((string)(_ver_src_ldate_ba)) );

ver_src_cnt_ba := __common__( if(ver_src_ba_pos > 0, (real)Models.Common.getw(ver_sources_count, ver_src_ba_pos), 0) );

ver_src_rcnt_33 := __common__( ver_src_rcnt_34 + ver_src_cnt_ba );

ver_src_cg_pos := __common__( Models.Common.findw_cpp(ver_sources, 'CG' , '  ,', 'ie') );

ver_src_cg_1 := __common__( ver_src_cg_pos > 0 );

_ver_src_fdate_cg := __common__( if(ver_src_cg_pos > 0, Models.Common.getw(ver_sources_first_seen, ver_src_cg_pos), '0') );

ver_src_fdate_cg := __common__( common.sas_date((string)(_ver_src_fdate_cg)) );

_ver_src_ldate_cg := __common__( if(ver_src_cg_pos > 0, Models.Common.getw(ver_sources_last_seen, ver_src_cg_pos), '0') );

ver_src_ldate_cg := __common__( common.sas_date((string)(_ver_src_ldate_cg)) );

ver_src_cnt_cg := __common__( if(ver_src_cg_pos > 0, (real)Models.Common.getw(ver_sources_count, ver_src_cg_pos), 0) );

ver_src_rcnt_32 := __common__( ver_src_rcnt_33 + ver_src_cnt_cg );

ver_src_co_pos := __common__( Models.Common.findw_cpp(ver_sources, 'CO' , '  ,', 'ie') );

ver_src_co_1 := __common__( ver_src_co_pos > 0 );

_ver_src_fdate_co := __common__( if(ver_src_co_pos > 0, Models.Common.getw(ver_sources_first_seen, ver_src_co_pos), '0') );

ver_src_fdate_co := __common__( common.sas_date((string)(_ver_src_fdate_co)) );

_ver_src_ldate_co := __common__( if(ver_src_co_pos > 0, Models.Common.getw(ver_sources_last_seen, ver_src_co_pos), '0') );

ver_src_ldate_co := __common__( common.sas_date((string)(_ver_src_ldate_co)) );

ver_src_cnt_co := __common__( if(ver_src_co_pos > 0, (real)Models.Common.getw(ver_sources_count, ver_src_co_pos), 0) );

ver_src_rcnt_31 := __common__( ver_src_rcnt_32 + ver_src_cnt_co );

ver_src_cy_pos := __common__( Models.Common.findw_cpp(ver_sources, 'CY' , '  ,', 'ie') );

ver_src_cy_1 := __common__( ver_src_cy_pos > 0 );

_ver_src_fdate_cy := __common__( if(ver_src_cy_pos > 0, Models.Common.getw(ver_sources_first_seen, ver_src_cy_pos), '0') );

ver_src_fdate_cy := __common__( common.sas_date((string)(_ver_src_fdate_cy)) );

_ver_src_ldate_cy := __common__( if(ver_src_cy_pos > 0, Models.Common.getw(ver_sources_last_seen, ver_src_cy_pos), '0') );

ver_src_ldate_cy := __common__( common.sas_date((string)(_ver_src_ldate_cy)) );

ver_src_cnt_cy := __common__( if(ver_src_cy_pos > 0, (real)Models.Common.getw(ver_sources_count, ver_src_cy_pos), 0) );

ver_src_rcnt_30 := __common__( ver_src_rcnt_31 + ver_src_cnt_cy );

ver_src_da_pos := __common__( Models.Common.findw_cpp(ver_sources, 'DA' , '  ,', 'ie') );

ver_src_da_1 := __common__( ver_src_da_pos > 0 );

_ver_src_fdate_da := __common__( if(ver_src_da_pos > 0, Models.Common.getw(ver_sources_first_seen, ver_src_da_pos), '0') );

ver_src_fdate_da := __common__( common.sas_date((string)(_ver_src_fdate_da)) );

_ver_src_ldate_da := __common__( if(ver_src_da_pos > 0, Models.Common.getw(ver_sources_last_seen, ver_src_da_pos), '0') );

ver_src_ldate_da := __common__( common.sas_date((string)(_ver_src_ldate_da)) );

ver_src_cnt_da := __common__( if(ver_src_da_pos > 0, (real)Models.Common.getw(ver_sources_count, ver_src_da_pos), 0) );

ver_src_rcnt_29 := __common__( ver_src_rcnt_30 + ver_src_cnt_da );

ver_src_d_pos := __common__( Models.Common.findw_cpp(ver_sources, 'D' , '  ,', 'ie') );

ver_src_d_1 := __common__( ver_src_d_pos > 0 );

_ver_src_fdate_d := __common__( if(ver_src_d_pos > 0, Models.Common.getw(ver_sources_first_seen, ver_src_d_pos), '0') );

ver_src_fdate_d := __common__( common.sas_date((string)(_ver_src_fdate_d)) );

_ver_src_ldate_d := __common__( if(ver_src_d_pos > 0, Models.Common.getw(ver_sources_last_seen, ver_src_d_pos), '0') );

ver_src_ldate_d := __common__( common.sas_date((string)(_ver_src_ldate_d)) );

ver_src_cnt_d := __common__( if(ver_src_d_pos > 0, (real)Models.Common.getw(ver_sources_count, ver_src_d_pos), 0) );

ver_src_rcnt_28 := __common__( ver_src_rcnt_29 + ver_src_cnt_d );

ver_src_dl_pos := __common__( Models.Common.findw_cpp(ver_sources, 'DL' , '  ,', 'ie') );

ver_src_dl_1 := __common__( ver_src_dl_pos > 0 );

_ver_src_fdate_dl := __common__( if(ver_src_dl_pos > 0, Models.Common.getw(ver_sources_first_seen, ver_src_dl_pos), '0') );

ver_src_fdate_dl := __common__( common.sas_date((string)(_ver_src_fdate_dl)) );

_ver_src_ldate_dl := __common__( if(ver_src_dl_pos > 0, Models.Common.getw(ver_sources_last_seen, ver_src_dl_pos), '0') );

ver_src_ldate_dl := __common__( common.sas_date((string)(_ver_src_ldate_dl)) );

ver_src_cnt_dl := __common__( if(ver_src_dl_pos > 0, (real)Models.Common.getw(ver_sources_count, ver_src_dl_pos), 0) );

ver_src_rcnt_27 := __common__( ver_src_rcnt_28 + ver_src_cnt_dl );

ver_src_ds_pos := __common__( Models.Common.findw_cpp(ver_sources, 'DS' , '  ,', 'ie') );

ver_src_ds_1 := __common__( ver_src_ds_pos > 0 );

_ver_src_fdate_ds := __common__( if(ver_src_ds_pos > 0, Models.Common.getw(ver_sources_first_seen, ver_src_ds_pos), '0') );

ver_src_fdate_ds := __common__( common.sas_date((string)(_ver_src_fdate_ds)) );

_ver_src_ldate_ds := __common__( if(ver_src_ds_pos > 0, Models.Common.getw(ver_sources_last_seen, ver_src_ds_pos), '0') );

ver_src_ldate_ds := __common__( common.sas_date((string)(_ver_src_ldate_ds)) );

ver_src_cnt_ds := __common__( if(ver_src_ds_pos > 0, (real)Models.Common.getw(ver_sources_count, ver_src_ds_pos), 0) );

ver_src_rcnt_26 := __common__( ver_src_rcnt_27 + ver_src_cnt_ds );

ver_src_de_pos := __common__( Models.Common.findw_cpp(ver_sources, 'DE' , '  ,', 'ie') );

ver_src_de_1 := __common__( ver_src_de_pos > 0 );

_ver_src_fdate_de := __common__( if(ver_src_de_pos > 0, Models.Common.getw(ver_sources_first_seen, ver_src_de_pos), '0') );

ver_src_fdate_de := __common__( common.sas_date((string)(_ver_src_fdate_de)) );

_ver_src_ldate_de := __common__( if(ver_src_de_pos > 0, Models.Common.getw(ver_sources_last_seen, ver_src_de_pos), '0') );

ver_src_ldate_de := __common__( common.sas_date((string)(_ver_src_ldate_de)) );

ver_src_cnt_de := __common__( if(ver_src_de_pos > 0, (real)Models.Common.getw(ver_sources_count, ver_src_de_pos), 0) );

ver_src_rcnt_25 := __common__( ver_src_rcnt_26 + ver_src_cnt_de );

ver_src_eb_pos := __common__( Models.Common.findw_cpp(ver_sources, 'EB' , '  ,', 'ie') );

ver_src_eb_1 := __common__( ver_src_eb_pos > 0 );

_ver_src_fdate_eb := __common__( if(ver_src_eb_pos > 0, Models.Common.getw(ver_sources_first_seen, ver_src_eb_pos), '0') );

ver_src_fdate_eb := __common__( common.sas_date((string)(_ver_src_fdate_eb)) );

_ver_src_ldate_eb := __common__( if(ver_src_eb_pos > 0, Models.Common.getw(ver_sources_last_seen, ver_src_eb_pos), '0') );

ver_src_ldate_eb := __common__( common.sas_date((string)(_ver_src_ldate_eb)) );

ver_src_cnt_eb := __common__( if(ver_src_eb_pos > 0, (real)Models.Common.getw(ver_sources_count, ver_src_eb_pos), 0) );

ver_src_rcnt_24 := __common__( ver_src_rcnt_25 + ver_src_cnt_eb );

ver_src_em_pos := __common__( Models.Common.findw_cpp(ver_sources, 'EM' , '  ,', 'ie') );

ver_src_em_1 := __common__( ver_src_em_pos > 0 );

_ver_src_fdate_em := __common__( if(ver_src_em_pos > 0, Models.Common.getw(ver_sources_first_seen, ver_src_em_pos), '0') );

ver_src_fdate_em := __common__( common.sas_date((string)(_ver_src_fdate_em)) );

_ver_src_ldate_em := __common__( if(ver_src_em_pos > 0, Models.Common.getw(ver_sources_last_seen, ver_src_em_pos), '0') );

ver_src_ldate_em := __common__( common.sas_date((string)(_ver_src_ldate_em)) );

ver_src_cnt_em := __common__( if(ver_src_em_pos > 0, (real)Models.Common.getw(ver_sources_count, ver_src_em_pos), 0) );

ver_src_rcnt_23 := __common__( ver_src_rcnt_24 + ver_src_cnt_em );

ver_src_e1_pos := __common__( Models.Common.findw_cpp(ver_sources, 'E1' , '  ,', 'ie') );

ver_src_e1_1 := __common__( ver_src_e1_pos > 0 );

_ver_src_fdate_e1 := __common__( if(ver_src_e1_pos > 0, Models.Common.getw(ver_sources_first_seen, ver_src_e1_pos), '0') );

ver_src_fdate_e1 := __common__( common.sas_date((string)(_ver_src_fdate_e1)) );

_ver_src_ldate_e1 := __common__( if(ver_src_e1_pos > 0, Models.Common.getw(ver_sources_last_seen, ver_src_e1_pos), '0') );

ver_src_ldate_e1 := __common__( common.sas_date((string)(_ver_src_ldate_e1)) );

ver_src_cnt_e1 := __common__( if(ver_src_e1_pos > 0, (real)Models.Common.getw(ver_sources_count, ver_src_e1_pos), 0) );

ver_src_rcnt_22 := __common__( ver_src_rcnt_23 + ver_src_cnt_e1 );

ver_src_e2_pos := __common__( Models.Common.findw_cpp(ver_sources, 'E2' , '  ,', 'ie') );

ver_src_e2_1 := __common__( ver_src_e2_pos > 0 );

_ver_src_fdate_e2 := __common__( if(ver_src_e2_pos > 0, Models.Common.getw(ver_sources_first_seen, ver_src_e2_pos), '0') );

ver_src_fdate_e2 := __common__( common.sas_date((string)(_ver_src_fdate_e2)) );

_ver_src_ldate_e2 := __common__( if(ver_src_e2_pos > 0, Models.Common.getw(ver_sources_last_seen, ver_src_e2_pos), '0') );

ver_src_ldate_e2 := __common__( common.sas_date((string)(_ver_src_ldate_e2)) );

ver_src_cnt_e2 := __common__( if(ver_src_e2_pos > 0, (real)Models.Common.getw(ver_sources_count, ver_src_e2_pos), 0) );

ver_src_rcnt_21 := __common__( ver_src_rcnt_22 + ver_src_cnt_e2 );

ver_src_e3_pos := __common__( Models.Common.findw_cpp(ver_sources, 'E3' , '  ,', 'ie') );

ver_src_e3_1 := __common__( ver_src_e3_pos > 0 );

_ver_src_fdate_e3 := __common__( if(ver_src_e3_pos > 0, Models.Common.getw(ver_sources_first_seen, ver_src_e3_pos), '0') );

ver_src_fdate_e3 := __common__( common.sas_date((string)(_ver_src_fdate_e3)) );

_ver_src_ldate_e3 := __common__( if(ver_src_e3_pos > 0, Models.Common.getw(ver_sources_last_seen, ver_src_e3_pos), '0') );

ver_src_ldate_e3 := __common__( common.sas_date((string)(_ver_src_ldate_e3)) );

ver_src_cnt_e3 := __common__( if(ver_src_e3_pos > 0, (real)Models.Common.getw(ver_sources_count, ver_src_e3_pos), 0) );

ver_src_rcnt_20 := __common__( ver_src_rcnt_21 + ver_src_cnt_e3 );

ver_src_e4_pos := __common__( Models.Common.findw_cpp(ver_sources, 'E4' , '  ,', 'ie') );

ver_src_e4_1 := __common__( ver_src_e4_pos > 0 );

_ver_src_fdate_e4 := __common__( if(ver_src_e4_pos > 0, Models.Common.getw(ver_sources_first_seen, ver_src_e4_pos), '0') );

ver_src_fdate_e4 := __common__( common.sas_date((string)(_ver_src_fdate_e4)) );

_ver_src_ldate_e4 := __common__( if(ver_src_e4_pos > 0, Models.Common.getw(ver_sources_last_seen, ver_src_e4_pos), '0') );

ver_src_ldate_e4 := __common__( common.sas_date((string)(_ver_src_ldate_e4)) );

ver_src_cnt_e4 := __common__( if(ver_src_e4_pos > 0, (real)Models.Common.getw(ver_sources_count, ver_src_e4_pos), 0) );

ver_src_rcnt_19 := __common__( ver_src_rcnt_20 + ver_src_cnt_e4 );

ver_src_en_pos := __common__( Models.Common.findw_cpp(ver_sources, 'EN' , '  ,', 'ie') );

ver_src_en_1 := __common__( ver_src_en_pos > 0 );

_ver_src_fdate_en := __common__( if(ver_src_en_pos > 0, Models.Common.getw(ver_sources_first_seen, ver_src_en_pos), '0') );

ver_src_fdate_en := __common__( common.sas_date((string)(_ver_src_fdate_en)) );

_ver_src_ldate_en := __common__( if(ver_src_en_pos > 0, Models.Common.getw(ver_sources_last_seen, ver_src_en_pos), '0') );

ver_src_ldate_en := __common__( common.sas_date((string)(_ver_src_ldate_en)) );

ver_src_cnt_en := __common__( if(ver_src_en_pos > 0, (real)Models.Common.getw(ver_sources_count, ver_src_en_pos), 0) );

ver_src_rcnt_18 := __common__( ver_src_rcnt_19 + ver_src_cnt_en );

ver_src_eq_pos := __common__( Models.Common.findw_cpp(ver_sources, 'EQ' , '  ,', 'ie') );

ver_src_eq_1 := __common__( ver_src_eq_pos > 0 );

_ver_src_fdate_eq := __common__( if(ver_src_eq_pos > 0, Models.Common.getw(ver_sources_first_seen, ver_src_eq_pos), '0') );

ver_src_fdate_eq := __common__( common.sas_date((string)(_ver_src_fdate_eq)) );

_ver_src_ldate_eq := __common__( if(ver_src_eq_pos > 0, Models.Common.getw(ver_sources_last_seen, ver_src_eq_pos), '0') );

ver_src_ldate_eq := __common__( common.sas_date((string)(_ver_src_ldate_eq)) );

ver_src_cnt_eq := __common__( if(ver_src_eq_pos > 0, (real)Models.Common.getw(ver_sources_count, ver_src_eq_pos), 0) );

ver_src_rcnt_17 := __common__( ver_src_rcnt_18 + ver_src_cnt_eq );

ver_src_fe_pos := __common__( Models.Common.findw_cpp(ver_sources, 'FE' , '  ,', 'ie') );

ver_src_fe_1 := __common__( ver_src_fe_pos > 0 );

_ver_src_fdate_fe := __common__( if(ver_src_fe_pos > 0, Models.Common.getw(ver_sources_first_seen, ver_src_fe_pos), '0') );

ver_src_fdate_fe := __common__( common.sas_date((string)(_ver_src_fdate_fe)) );

_ver_src_ldate_fe := __common__( if(ver_src_fe_pos > 0, Models.Common.getw(ver_sources_last_seen, ver_src_fe_pos), '0') );

ver_src_ldate_fe := __common__( common.sas_date((string)(_ver_src_ldate_fe)) );

ver_src_cnt_fe := __common__( if(ver_src_fe_pos > 0, (real)Models.Common.getw(ver_sources_count, ver_src_fe_pos), 0) );

ver_src_rcnt_16 := __common__( ver_src_rcnt_17 + ver_src_cnt_fe );

ver_src_ff_pos := __common__( Models.Common.findw_cpp(ver_sources, 'FF' , '  ,', 'ie') );

ver_src_ff_1 := __common__( ver_src_ff_pos > 0 );

_ver_src_fdate_ff := __common__( if(ver_src_ff_pos > 0, Models.Common.getw(ver_sources_first_seen, ver_src_ff_pos), '0') );

ver_src_fdate_ff := __common__( common.sas_date((string)(_ver_src_fdate_ff)) );

_ver_src_ldate_ff := __common__( if(ver_src_ff_pos > 0, Models.Common.getw(ver_sources_last_seen, ver_src_ff_pos), '0') );

ver_src_ldate_ff := __common__( common.sas_date((string)(_ver_src_ldate_ff)) );

ver_src_cnt_ff := __common__( if(ver_src_ff_pos > 0, (real)Models.Common.getw(ver_sources_count, ver_src_ff_pos), 0) );

ver_src_rcnt_15 := __common__( ver_src_rcnt_16 + ver_src_cnt_ff );

ver_src_fr_pos := __common__( Models.Common.findw_cpp(ver_sources, 'FR' , '  ,', 'ie') );

ver_src_fr_1 := __common__( ver_src_fr_pos > 0 );

_ver_src_fdate_fr := __common__( if(ver_src_fr_pos > 0, Models.Common.getw(ver_sources_first_seen, ver_src_fr_pos), '0') );

ver_src_fdate_fr := __common__( common.sas_date((string)(_ver_src_fdate_fr)) );

_ver_src_ldate_fr := __common__( if(ver_src_fr_pos > 0, Models.Common.getw(ver_sources_last_seen, ver_src_fr_pos), '0') );

ver_src_ldate_fr := __common__( common.sas_date((string)(_ver_src_ldate_fr)) );

ver_src_cnt_fr := __common__( if(ver_src_fr_pos > 0, (real)Models.Common.getw(ver_sources_count, ver_src_fr_pos), 0) );

ver_src_rcnt_14 := __common__( ver_src_rcnt_15 + ver_src_cnt_fr );

ver_src_l2_pos := __common__( Models.Common.findw_cpp(ver_sources, 'L2' , '  ,', 'ie') );

ver_src_l2_1 := __common__( ver_src_l2_pos > 0 );

_ver_src_fdate_l2 := __common__( if(ver_src_l2_pos > 0, Models.Common.getw(ver_sources_first_seen, ver_src_l2_pos), '0') );

ver_src_fdate_l2 := __common__( common.sas_date((string)(_ver_src_fdate_l2)) );

_ver_src_ldate_l2 := __common__( if(ver_src_l2_pos > 0, Models.Common.getw(ver_sources_last_seen, ver_src_l2_pos), '0') );

ver_src_ldate_l2 := __common__( common.sas_date((string)(_ver_src_ldate_l2)) );

ver_src_cnt_l2 := __common__( if(ver_src_l2_pos > 0, (real)Models.Common.getw(ver_sources_count, ver_src_l2_pos), 0) );

ver_src_rcnt_13 := __common__( ver_src_rcnt_14 + ver_src_cnt_l2 );

ver_src_li_pos := __common__( Models.Common.findw_cpp(ver_sources, 'LI' , '  ,', 'ie') );

ver_src_li_1 := __common__( ver_src_li_pos > 0 );

_ver_src_fdate_li := __common__( if(ver_src_li_pos > 0, Models.Common.getw(ver_sources_first_seen, ver_src_li_pos), '0') );

ver_src_fdate_li := __common__( common.sas_date((string)(_ver_src_fdate_li)) );

_ver_src_ldate_li := __common__( if(ver_src_li_pos > 0, Models.Common.getw(ver_sources_last_seen, ver_src_li_pos), '0') );

ver_src_ldate_li := __common__( common.sas_date((string)(_ver_src_ldate_li)) );

ver_src_cnt_li := __common__( if(ver_src_li_pos > 0, (real)Models.Common.getw(ver_sources_count, ver_src_li_pos), 0) );

ver_src_rcnt_12 := __common__( ver_src_rcnt_13 + ver_src_cnt_li );

ver_src_mw_pos := __common__( Models.Common.findw_cpp(ver_sources, 'MW' , '  ,', 'ie') );

ver_src_mw_1 := __common__( ver_src_mw_pos > 0 );

_ver_src_fdate_mw := __common__( if(ver_src_mw_pos > 0, Models.Common.getw(ver_sources_first_seen, ver_src_mw_pos), '0') );

ver_src_fdate_mw := __common__( common.sas_date((string)(_ver_src_fdate_mw)) );

_ver_src_ldate_mw := __common__( if(ver_src_mw_pos > 0, Models.Common.getw(ver_sources_last_seen, ver_src_mw_pos), '0') );

ver_src_ldate_mw := __common__( common.sas_date((string)(_ver_src_ldate_mw)) );

ver_src_cnt_mw := __common__( if(ver_src_mw_pos > 0, (real)Models.Common.getw(ver_sources_count, ver_src_mw_pos), 0) );

ver_src_rcnt_11 := __common__( ver_src_rcnt_12 + ver_src_cnt_mw );

ver_src_nt_pos := __common__( Models.Common.findw_cpp(ver_sources, 'NT' , '  ,', 'ie') );

ver_src_nt_1 := __common__( ver_src_nt_pos > 0 );

_ver_src_fdate_nt := __common__( if(ver_src_nt_pos > 0, Models.Common.getw(ver_sources_first_seen, ver_src_nt_pos), '0') );

ver_src_fdate_nt := __common__( common.sas_date((string)(_ver_src_fdate_nt)) );

_ver_src_ldate_nt := __common__( if(ver_src_nt_pos > 0, Models.Common.getw(ver_sources_last_seen, ver_src_nt_pos), '0') );

ver_src_ldate_nt := __common__( common.sas_date((string)(_ver_src_ldate_nt)) );

ver_src_cnt_nt := __common__( if(ver_src_nt_pos > 0, (real)Models.Common.getw(ver_sources_count, ver_src_nt_pos), 0) );

ver_src_rcnt_10 := __common__( ver_src_rcnt_11 + ver_src_cnt_nt );

ver_src_p_pos := __common__( Models.Common.findw_cpp(ver_sources, 'P' , '  ,', 'ie') );

ver_src_p_1 := __common__( ver_src_p_pos > 0 );

_ver_src_fdate_p := __common__( if(ver_src_p_pos > 0, Models.Common.getw(ver_sources_first_seen, ver_src_p_pos), '0') );

ver_src_fdate_p := __common__( common.sas_date((string)(_ver_src_fdate_p)) );

_ver_src_ldate_p := __common__( if(ver_src_p_pos > 0, Models.Common.getw(ver_sources_last_seen, ver_src_p_pos), '0') );

ver_src_ldate_p := __common__( common.sas_date((string)(_ver_src_ldate_p)) );

ver_src_cnt_p := __common__( if(ver_src_p_pos > 0, (real)Models.Common.getw(ver_sources_count, ver_src_p_pos), 0) );

ver_src_rcnt_9 := __common__( ver_src_rcnt_10 + ver_src_cnt_p );

ver_src_pl_pos := __common__( Models.Common.findw_cpp(ver_sources, 'PL' , '  ,', 'ie') );

ver_src_pl_1 := __common__( ver_src_pl_pos > 0 );

_ver_src_fdate_pl := __common__( if(ver_src_pl_pos > 0, Models.Common.getw(ver_sources_first_seen, ver_src_pl_pos), '0') );

ver_src_fdate_pl := __common__( common.sas_date((string)(_ver_src_fdate_pl)) );

_ver_src_ldate_pl := __common__( if(ver_src_pl_pos > 0, Models.Common.getw(ver_sources_last_seen, ver_src_pl_pos), '0') );

ver_src_ldate_pl := __common__( common.sas_date((string)(_ver_src_ldate_pl)) );

ver_src_cnt_pl := __common__( if(ver_src_pl_pos > 0, (real)Models.Common.getw(ver_sources_count, ver_src_pl_pos), 0) );

ver_src_rcnt_8 := __common__( ver_src_rcnt_9 + ver_src_cnt_pl );

ver_src_tn_pos := __common__( Models.Common.findw_cpp(ver_sources, 'TN' , '  ,', 'ie') );

ver_src_tn_1 := __common__( ver_src_tn_pos > 0 );

_ver_src_fdate_tn := __common__( if(ver_src_tn_pos > 0, Models.Common.getw(ver_sources_first_seen, ver_src_tn_pos), '0') );

ver_src_fdate_tn := __common__( common.sas_date((string)(_ver_src_fdate_tn)) );

_ver_src_ldate_tn := __common__( if(ver_src_tn_pos > 0, Models.Common.getw(ver_sources_last_seen, ver_src_tn_pos), '0') );

ver_src_ldate_tn := __common__( common.sas_date((string)(_ver_src_ldate_tn)) );

ver_src_cnt_tn := __common__( if(ver_src_tn_pos > 0, (real)Models.Common.getw(ver_sources_count, ver_src_tn_pos), 0) );

ver_src_rcnt_7 := __common__( ver_src_rcnt_8 + ver_src_cnt_tn );

ver_src_ts_pos := __common__( Models.Common.findw_cpp(ver_sources, 'TS' , '  ,', 'ie') );

ver_src_ts_1 := __common__( ver_src_ts_pos > 0 );

_ver_src_fdate_ts := __common__( if(ver_src_ts_pos > 0, Models.Common.getw(ver_sources_first_seen, ver_src_ts_pos), '0') );

ver_src_fdate_ts := __common__( common.sas_date((string)(_ver_src_fdate_ts)) );

_ver_src_ldate_ts := __common__( if(ver_src_ts_pos > 0, Models.Common.getw(ver_sources_last_seen, ver_src_ts_pos), '0') );

ver_src_ldate_ts := __common__( common.sas_date((string)(_ver_src_ldate_ts)) );
// ver_src_ldate_ts := __common__(if(ver_src_ts_pos > 0, Models.Common.getw(ver_sources_last_seen, ver_src_ts_pos), '0') );

ver_src_cnt_ts := __common__( if(ver_src_ts_pos > 0, (real)Models.Common.getw(ver_sources_count, ver_src_ts_pos), 0) );

ver_src_rcnt_6 := __common__( ver_src_rcnt_7 + ver_src_cnt_ts );

ver_src_tu_pos := __common__( Models.Common.findw_cpp(ver_sources, 'TU' , '  ,', 'ie') );

ver_src_tu_1 := __common__( ver_src_tu_pos > 0 );

_ver_src_fdate_tu := __common__( if(ver_src_tu_pos > 0, Models.Common.getw(ver_sources_first_seen, ver_src_tu_pos), '0') );

ver_src_fdate_tu := __common__( common.sas_date((string)(_ver_src_fdate_tu)) );

_ver_src_ldate_tu := __common__( if(ver_src_tu_pos > 0, Models.Common.getw(ver_sources_last_seen, ver_src_tu_pos), '0') );

ver_src_ldate_tu := __common__( common.sas_date((string)(_ver_src_ldate_tu)) );

ver_src_cnt_tu := __common__( if(ver_src_tu_pos > 0, (real)Models.Common.getw(ver_sources_count, ver_src_tu_pos), 0) );

ver_src_rcnt_5 := __common__( ver_src_rcnt_6 + ver_src_cnt_tu );

ver_src_sl_pos := __common__( Models.Common.findw_cpp(ver_sources, 'SL' , '  ,', 'ie') );

ver_src_sl_1 := __common__( ver_src_sl_pos > 0 );

_ver_src_fdate_sl := __common__( if(ver_src_sl_pos > 0, Models.Common.getw(ver_sources_first_seen, ver_src_sl_pos), '0') );

ver_src_fdate_sl := __common__( common.sas_date((string)(_ver_src_fdate_sl)) );

_ver_src_ldate_sl := __common__( if(ver_src_sl_pos > 0, Models.Common.getw(ver_sources_last_seen, ver_src_sl_pos), '0') );

ver_src_ldate_sl := __common__( common.sas_date((string)(_ver_src_ldate_sl)) );

ver_src_cnt_sl := __common__( if(ver_src_sl_pos > 0, (real)Models.Common.getw(ver_sources_count, ver_src_sl_pos), 0) );

ver_src_rcnt_4 := __common__( ver_src_rcnt_5 + ver_src_cnt_sl );

ver_src_v_pos := __common__( Models.Common.findw_cpp(ver_sources, 'V' , '  ,', 'ie') );

ver_src_v_1 := __common__( ver_src_v_pos > 0 );

_ver_src_fdate_v := __common__( if(ver_src_v_pos > 0, Models.Common.getw(ver_sources_first_seen, ver_src_v_pos), '0') );

ver_src_fdate_v := __common__( common.sas_date((string)(_ver_src_fdate_v)) );

_ver_src_ldate_v := __common__( if(ver_src_v_pos > 0, Models.Common.getw(ver_sources_last_seen, ver_src_v_pos), '0') );

ver_src_ldate_v := __common__( common.sas_date((string)(_ver_src_ldate_v)) );

ver_src_cnt_v := __common__( if(ver_src_v_pos > 0, (real)Models.Common.getw(ver_sources_count, ver_src_v_pos), 0) );

ver_src_rcnt_3 := __common__( ver_src_rcnt_4 + ver_src_cnt_v );

ver_src_vo_pos := __common__( Models.Common.findw_cpp(ver_sources, 'VO' , '  ,', 'ie') );

ver_src_vo_1 := __common__( ver_src_vo_pos > 0 );

_ver_src_fdate_vo := __common__( if(ver_src_vo_pos > 0, Models.Common.getw(ver_sources_first_seen, ver_src_vo_pos), '0') );

ver_src_fdate_vo := __common__( common.sas_date((string)(_ver_src_fdate_vo)) );

_ver_src_ldate_vo := __common__( if(ver_src_vo_pos > 0, Models.Common.getw(ver_sources_last_seen, ver_src_vo_pos), '0') );

ver_src_ldate_vo := __common__( common.sas_date((string)(_ver_src_ldate_vo)) );

ver_src_cnt_vo := __common__( if(ver_src_vo_pos > 0, (real)Models.Common.getw(ver_sources_count, ver_src_vo_pos), 0) );

ver_src_rcnt_2 := __common__( ver_src_rcnt_3 + ver_src_cnt_vo );

ver_src_w_pos := __common__( Models.Common.findw_cpp(ver_sources, 'W' , '  ,', 'ie') );

ver_src_w_1 := __common__( ver_src_w_pos > 0 );

_ver_src_fdate_w := __common__( if(ver_src_w_pos > 0, Models.Common.getw(ver_sources_first_seen, ver_src_w_pos), '0') );

ver_src_fdate_w := __common__( common.sas_date((string)(_ver_src_fdate_w)) );

_ver_src_ldate_w := __common__( if(ver_src_w_pos > 0, Models.Common.getw(ver_sources_last_seen, ver_src_w_pos), '0') );

ver_src_ldate_w := __common__( common.sas_date((string)(_ver_src_ldate_w)) );

ver_src_cnt_w := __common__( if(ver_src_w_pos > 0, (real)Models.Common.getw(ver_sources_count, ver_src_w_pos), 0) );

ver_src_rcnt_1 := __common__( ver_src_rcnt_2 + ver_src_cnt_w );

ver_src_wp_pos := __common__( Models.Common.findw_cpp(ver_sources, 'WP' , '  ,', 'ie') );

ver_src_wp_1 := __common__( ver_src_wp_pos > 0 );

_ver_src_fdate_wp := __common__( if(ver_src_wp_pos > 0, Models.Common.getw(ver_sources_first_seen, ver_src_wp_pos), '0') );

ver_src_fdate_wp := __common__( common.sas_date((string)(_ver_src_fdate_wp)) );

_ver_src_ldate_wp := __common__( if(ver_src_wp_pos > 0, Models.Common.getw(ver_sources_last_seen, ver_src_wp_pos), '0') );

ver_src_ldate_wp := __common__( common.sas_date((string)(_ver_src_ldate_wp)) );

ver_src_cnt_wp := __common__( if(ver_src_wp_pos > 0, (real)Models.Common.getw(ver_sources_count, ver_src_wp_pos), 0) );

ver_src_rcnt := __common__( ver_src_rcnt_1 + ver_src_cnt_wp );

ver_fname_src_cnt := __common__( Models.Common.countw((string)(ver_fname_sources), ' !$%&()*+,-./ );<^|') );

ver_fname_src_pop := __common__( ver_fname_src_cnt > 0 );

ver_fname_src_rcnt := __common__( 0 );

ver_fname_src_fsrc := __common__( Models.Common.getw(ver_fname_sources, 1) );

ver_fname_src_ak_pos := __common__( Models.Common.findw_cpp(ver_fname_sources, 'AK' , '  ,', 'ie') );

ver_fname_src_ak := __common__( ver_fname_src_ak_pos > 0 );

ver_fname_src_am_pos := __common__( Models.Common.findw_cpp(ver_fname_sources, 'AM' , '  ,', 'ie') );

ver_fname_src_am := __common__( ver_fname_src_am_pos > 0 );

ver_fname_src_ar_pos := __common__( Models.Common.findw_cpp(ver_fname_sources, 'AR' , '  ,', 'ie') );

ver_fname_src_ar := __common__( ver_fname_src_ar_pos > 0 );

ver_fname_src_ba_pos := __common__( Models.Common.findw_cpp(ver_fname_sources, 'BA' , '  ,', 'ie') );

ver_fname_src_ba := __common__( ver_fname_src_ba_pos > 0 );

ver_fname_src_cg_pos := __common__( Models.Common.findw_cpp(ver_fname_sources, 'CG' , '  ,', 'ie') );

ver_fname_src_cg := __common__( ver_fname_src_cg_pos > 0 );

ver_fname_src_co_pos := __common__( Models.Common.findw_cpp(ver_fname_sources, 'CO' , '  ,', 'ie') );

ver_fname_src_co := __common__( ver_fname_src_co_pos > 0 );

ver_fname_src_cy_pos := __common__( Models.Common.findw_cpp(ver_fname_sources, 'CY' , '  ,', 'ie') );

ver_fname_src_cy := __common__( ver_fname_src_cy_pos > 0 );

ver_fname_src_da_pos := __common__( Models.Common.findw_cpp(ver_fname_sources, 'DA' , '  ,', 'ie') );

ver_fname_src_da := __common__( ver_fname_src_da_pos > 0 );

ver_fname_src_d_pos := __common__( Models.Common.findw_cpp(ver_fname_sources, 'D' , '  ,', 'ie') );

ver_fname_src_d := __common__( ver_fname_src_d_pos > 0 );

ver_fname_src_dl_pos := __common__( Models.Common.findw_cpp(ver_fname_sources, 'DL' , '  ,', 'ie') );

ver_fname_src_dl := __common__( ver_fname_src_dl_pos > 0 );

ver_fname_src_ds_pos := __common__( Models.Common.findw_cpp(ver_fname_sources, 'DS' , '  ,', 'ie') );

ver_fname_src_ds := __common__( ver_fname_src_ds_pos > 0 );

ver_fname_src_de_pos := __common__( Models.Common.findw_cpp(ver_fname_sources, 'DE' , '  ,', 'ie') );

ver_fname_src_de := __common__( ver_fname_src_de_pos > 0 );

ver_fname_src_eb_pos := __common__( Models.Common.findw_cpp(ver_fname_sources, 'EB' , '  ,', 'ie') );

ver_fname_src_eb := __common__( ver_fname_src_eb_pos > 0 );

ver_fname_src_em_pos := __common__( Models.Common.findw_cpp(ver_fname_sources, 'EM' , '  ,', 'ie') );

ver_fname_src_em := __common__( ver_fname_src_em_pos > 0 );

ver_fname_src_e1_pos := __common__( Models.Common.findw_cpp(ver_fname_sources, 'E1' , '  ,', 'ie') );

ver_fname_src_e1 := __common__( ver_fname_src_e1_pos > 0 );

ver_fname_src_e2_pos := __common__( Models.Common.findw_cpp(ver_fname_sources, 'E2' , '  ,', 'ie') );

ver_fname_src_e2 := __common__( ver_fname_src_e2_pos > 0 );

ver_fname_src_e3_pos := __common__( Models.Common.findw_cpp(ver_fname_sources, 'E3' , '  ,', 'ie') );

ver_fname_src_e3 := __common__( ver_fname_src_e3_pos > 0 );

ver_fname_src_e4_pos := __common__( Models.Common.findw_cpp(ver_fname_sources, 'E4' , '  ,', 'ie') );

ver_fname_src_e4 := __common__( ver_fname_src_e4_pos > 0 );

ver_fname_src_en_pos := __common__( Models.Common.findw_cpp(ver_fname_sources, 'EN' , '  ,', 'ie') );

ver_fname_src_en := __common__( ver_fname_src_en_pos > 0 );

ver_fname_src_eq_pos := __common__( Models.Common.findw_cpp(ver_fname_sources, 'EQ' , '  ,', 'ie') );

ver_fname_src_eq := __common__( ver_fname_src_eq_pos > 0 );

ver_fname_src_fe_pos := __common__( Models.Common.findw_cpp(ver_fname_sources, 'FE' , '  ,', 'ie') );

ver_fname_src_fe := __common__( ver_fname_src_fe_pos > 0 );

ver_fname_src_ff_pos := __common__( Models.Common.findw_cpp(ver_fname_sources, 'FF' , '  ,', 'ie') );

ver_fname_src_ff := __common__( ver_fname_src_ff_pos > 0 );

ver_fname_src_fr_pos := __common__( Models.Common.findw_cpp(ver_fname_sources, 'FR' , '  ,', 'ie') );

ver_fname_src_fr := __common__( ver_fname_src_fr_pos > 0 );

ver_fname_src_l2_pos := __common__( Models.Common.findw_cpp(ver_fname_sources, 'L2' , '  ,', 'ie') );

ver_fname_src_l2 := __common__( ver_fname_src_l2_pos > 0 );

ver_fname_src_li_pos := __common__( Models.Common.findw_cpp(ver_fname_sources, 'LI' , '  ,', 'ie') );

ver_fname_src_li := __common__( ver_fname_src_li_pos > 0 );

ver_fname_src_mw_pos := __common__( Models.Common.findw_cpp(ver_fname_sources, 'MW' , '  ,', 'ie') );

ver_fname_src_mw := __common__( ver_fname_src_mw_pos > 0 );

ver_fname_src_nt_pos := __common__( Models.Common.findw_cpp(ver_fname_sources, 'NT' , '  ,', 'ie') );

ver_fname_src_nt := __common__( ver_fname_src_nt_pos > 0 );

ver_fname_src_p_pos := __common__( Models.Common.findw_cpp(ver_fname_sources, 'P' , '  ,', 'ie') );

ver_fname_src_p := __common__( ver_fname_src_p_pos > 0 );

ver_fname_src_pl_pos := __common__( Models.Common.findw_cpp(ver_fname_sources, 'PL' , '  ,', 'ie') );

ver_fname_src_pl := __common__( ver_fname_src_pl_pos > 0 );

ver_fname_src_tn_pos := __common__( Models.Common.findw_cpp(ver_fname_sources, 'TN' , '  ,', 'ie') );

ver_fname_src_tn := __common__( ver_fname_src_tn_pos > 0 );

ver_fname_src_ts_pos := __common__( Models.Common.findw_cpp(ver_fname_sources, 'TS' , '  ,', 'ie') );

ver_fname_src_ts := __common__( ver_fname_src_ts_pos > 0 );

ver_fname_src_tu_pos := __common__( Models.Common.findw_cpp(ver_fname_sources, 'TU' , '  ,', 'ie') );

ver_fname_src_tu := __common__( ver_fname_src_tu_pos > 0 );

ver_fname_src_sl_pos := __common__( Models.Common.findw_cpp(ver_fname_sources, 'SL' , '  ,', 'ie') );

ver_fname_src_sl := __common__( ver_fname_src_sl_pos > 0 );

ver_fname_src_v_pos := __common__( Models.Common.findw_cpp(ver_fname_sources, 'V' , '  ,', 'ie') );

ver_fname_src_v := __common__( ver_fname_src_v_pos > 0 );

ver_fname_src_vo_pos := __common__( Models.Common.findw_cpp(ver_fname_sources, 'VO' , '  ,', 'ie') );

ver_fname_src_vo := __common__( ver_fname_src_vo_pos > 0 );

ver_fname_src_w_pos := __common__( Models.Common.findw_cpp(ver_fname_sources, 'W' , '  ,', 'ie') );

ver_fname_src_w := __common__( ver_fname_src_w_pos > 0 );

ver_fname_src_wp_pos := __common__( Models.Common.findw_cpp(ver_fname_sources, 'WP' , '  ,', 'ie') );

ver_fname_src_wp := __common__( ver_fname_src_wp_pos > 0 );

ver_lname_src_cnt := __common__( Models.Common.countw((string)(ver_lname_sources), ' !$%&()*+,-./ );<^|') );

ver_lname_src_pop := __common__( ver_lname_src_cnt > 0 );

ver_lname_src_rcnt := __common__( 0 );

ver_lname_src_fsrc := __common__( Models.Common.getw(ver_lname_sources, 1) );

ver_lname_src_ak_pos := __common__( Models.Common.findw_cpp(ver_lname_sources, 'AK' , '  ,', 'ie') );

ver_lname_src_ak := __common__( ver_lname_src_ak_pos > 0 );

ver_lname_src_am_pos := __common__( Models.Common.findw_cpp(ver_lname_sources, 'AM' , '  ,', 'ie') );

ver_lname_src_am := __common__( ver_lname_src_am_pos > 0 );

ver_lname_src_ar_pos := __common__( Models.Common.findw_cpp(ver_lname_sources, 'AR' , '  ,', 'ie') );

ver_lname_src_ar := __common__( ver_lname_src_ar_pos > 0 );

ver_lname_src_ba_pos := __common__( Models.Common.findw_cpp(ver_lname_sources, 'BA' , '  ,', 'ie') );

ver_lname_src_ba := __common__( ver_lname_src_ba_pos > 0 );

ver_lname_src_cg_pos := __common__( Models.Common.findw_cpp(ver_lname_sources, 'CG' , '  ,', 'ie') );

ver_lname_src_cg := __common__( ver_lname_src_cg_pos > 0 );

ver_lname_src_co_pos := __common__( Models.Common.findw_cpp(ver_lname_sources, 'CO' , '  ,', 'ie') );

ver_lname_src_co := __common__( ver_lname_src_co_pos > 0 );

ver_lname_src_cy_pos := __common__( Models.Common.findw_cpp(ver_lname_sources, 'CY' , '  ,', 'ie') );

ver_lname_src_cy := __common__( ver_lname_src_cy_pos > 0 );

ver_lname_src_da_pos := __common__( Models.Common.findw_cpp(ver_lname_sources, 'DA' , '  ,', 'ie') );

ver_lname_src_da := __common__( ver_lname_src_da_pos > 0 );

ver_lname_src_d_pos := __common__( Models.Common.findw_cpp(ver_lname_sources, 'D' , '  ,', 'ie') );

ver_lname_src_d := __common__( ver_lname_src_d_pos > 0 );

ver_lname_src_dl_pos := __common__( Models.Common.findw_cpp(ver_lname_sources, 'DL' , '  ,', 'ie') );

ver_lname_src_dl := __common__( ver_lname_src_dl_pos > 0 );

ver_lname_src_ds_pos := __common__( Models.Common.findw_cpp(ver_lname_sources, 'DS' , '  ,', 'ie') );

ver_lname_src_ds := __common__( ver_lname_src_ds_pos > 0 );

ver_lname_src_de_pos := __common__( Models.Common.findw_cpp(ver_lname_sources, 'DE' , '  ,', 'ie') );

ver_lname_src_de := __common__( ver_lname_src_de_pos > 0 );

ver_lname_src_eb_pos := __common__( Models.Common.findw_cpp(ver_lname_sources, 'EB' , '  ,', 'ie') );

ver_lname_src_eb := __common__( ver_lname_src_eb_pos > 0 );

ver_lname_src_em_pos := __common__( Models.Common.findw_cpp(ver_lname_sources, 'EM' , '  ,', 'ie') );

ver_lname_src_em := __common__( ver_lname_src_em_pos > 0 );

ver_lname_src_e1_pos := __common__( Models.Common.findw_cpp(ver_lname_sources, 'E1' , '  ,', 'ie') );

ver_lname_src_e1 := __common__( ver_lname_src_e1_pos > 0 );

ver_lname_src_e2_pos := __common__( Models.Common.findw_cpp(ver_lname_sources, 'E2' , '  ,', 'ie') );

ver_lname_src_e2 := __common__( ver_lname_src_e2_pos > 0 );

ver_lname_src_e3_pos := __common__( Models.Common.findw_cpp(ver_lname_sources, 'E3' , '  ,', 'ie') );

ver_lname_src_e3 := __common__( ver_lname_src_e3_pos > 0 );

ver_lname_src_e4_pos := __common__( Models.Common.findw_cpp(ver_lname_sources, 'E4' , '  ,', 'ie') );

ver_lname_src_e4 := __common__( ver_lname_src_e4_pos > 0 );

ver_lname_src_en_pos := __common__( Models.Common.findw_cpp(ver_lname_sources, 'EN' , '  ,', 'ie') );

ver_lname_src_en := __common__( ver_lname_src_en_pos > 0 );

ver_lname_src_eq_pos := __common__( Models.Common.findw_cpp(ver_lname_sources, 'EQ' , '  ,', 'ie') );

ver_lname_src_eq := __common__( ver_lname_src_eq_pos > 0 );

ver_lname_src_fe_pos := __common__( Models.Common.findw_cpp(ver_lname_sources, 'FE' , '  ,', 'ie') );

ver_lname_src_fe := __common__( ver_lname_src_fe_pos > 0 );

ver_lname_src_ff_pos := __common__( Models.Common.findw_cpp(ver_lname_sources, 'FF' , '  ,', 'ie') );

ver_lname_src_ff := __common__( ver_lname_src_ff_pos > 0 );

ver_lname_src_fr_pos := __common__( Models.Common.findw_cpp(ver_lname_sources, 'FR' , '  ,', 'ie') );

ver_lname_src_fr := __common__( ver_lname_src_fr_pos > 0 );

ver_lname_src_l2_pos := __common__( Models.Common.findw_cpp(ver_lname_sources, 'L2' , '  ,', 'ie') );

ver_lname_src_l2 := __common__( ver_lname_src_l2_pos > 0 );

ver_lname_src_li_pos := __common__( Models.Common.findw_cpp(ver_lname_sources, 'LI' , '  ,', 'ie') );

ver_lname_src_li := __common__( ver_lname_src_li_pos > 0 );

ver_lname_src_mw_pos := __common__( Models.Common.findw_cpp(ver_lname_sources, 'MW' , '  ,', 'ie') );

ver_lname_src_mw := __common__( ver_lname_src_mw_pos > 0 );

ver_lname_src_nt_pos := __common__( Models.Common.findw_cpp(ver_lname_sources, 'NT' , '  ,', 'ie') );

ver_lname_src_nt := __common__( ver_lname_src_nt_pos > 0 );

ver_lname_src_p_pos := __common__( Models.Common.findw_cpp(ver_lname_sources, 'P' , '  ,', 'ie') );

ver_lname_src_p := __common__( ver_lname_src_p_pos > 0 );

ver_lname_src_pl_pos := __common__( Models.Common.findw_cpp(ver_lname_sources, 'PL' , '  ,', 'ie') );

ver_lname_src_pl := __common__( ver_lname_src_pl_pos > 0 );

ver_lname_src_tn_pos := __common__( Models.Common.findw_cpp(ver_lname_sources, 'TN' , '  ,', 'ie') );

ver_lname_src_tn := __common__( ver_lname_src_tn_pos > 0 );

ver_lname_src_ts_pos := __common__( Models.Common.findw_cpp(ver_lname_sources, 'TS' , '  ,', 'ie') );

ver_lname_src_ts := __common__( ver_lname_src_ts_pos > 0 );

ver_lname_src_tu_pos := __common__( Models.Common.findw_cpp(ver_lname_sources, 'TU' , '  ,', 'ie') );

ver_lname_src_tu := __common__( ver_lname_src_tu_pos > 0 );

ver_lname_src_sl_pos := __common__( Models.Common.findw_cpp(ver_lname_sources, 'SL' , '  ,', 'ie') );

ver_lname_src_sl := __common__( ver_lname_src_sl_pos > 0 );

ver_lname_src_v_pos := __common__( Models.Common.findw_cpp(ver_lname_sources, 'V' , '  ,', 'ie') );

ver_lname_src_v := __common__( ver_lname_src_v_pos > 0 );

ver_lname_src_vo_pos := __common__( Models.Common.findw_cpp(ver_lname_sources, 'VO' , '  ,', 'ie') );

ver_lname_src_vo := __common__( ver_lname_src_vo_pos > 0 );

ver_lname_src_w_pos := __common__( Models.Common.findw_cpp(ver_lname_sources, 'W' , '  ,', 'ie') );

ver_lname_src_w := __common__( ver_lname_src_w_pos > 0 );

ver_lname_src_wp_pos := __common__( Models.Common.findw_cpp(ver_lname_sources, 'WP' , '  ,', 'ie') );

ver_lname_src_wp := __common__( ver_lname_src_wp_pos > 0 );

ver_addr_src_cnt := __common__( Models.Common.countw((string)(ver_addr_sources), ' !$%&()*+,-./ );<^|') );

ver_addr_src_pop := __common__( ver_addr_src_cnt > 0 );

ver_addr_src_rcnt := __common__( 0 );

ver_addr_src_fsrc := __common__( Models.Common.getw(ver_addr_sources, 1) );

ver_addr_src_ak_pos := __common__( Models.Common.findw_cpp(ver_addr_sources, 'AK' , '  ,', 'ie') );

ver_addr_src_ak := __common__( ver_addr_src_ak_pos > 0 );

ver_addr_src_am_pos := __common__( Models.Common.findw_cpp(ver_addr_sources, 'AM' , '  ,', 'ie') );

ver_addr_src_am := __common__( ver_addr_src_am_pos > 0 );

ver_addr_src_ar_pos := __common__( Models.Common.findw_cpp(ver_addr_sources, 'AR' , '  ,', 'ie') );

ver_addr_src_ar := __common__( ver_addr_src_ar_pos > 0 );

ver_addr_src_ba_pos := __common__( Models.Common.findw_cpp(ver_addr_sources, 'BA' , '  ,', 'ie') );

ver_addr_src_ba := __common__( ver_addr_src_ba_pos > 0 );

ver_addr_src_cg_pos := __common__( Models.Common.findw_cpp(ver_addr_sources, 'CG' , '  ,', 'ie') );

ver_addr_src_cg := __common__( ver_addr_src_cg_pos > 0 );

ver_addr_src_co_pos := __common__( Models.Common.findw_cpp(ver_addr_sources, 'CO' , '  ,', 'ie') );

ver_addr_src_co := __common__( ver_addr_src_co_pos > 0 );

ver_addr_src_cy_pos := __common__( Models.Common.findw_cpp(ver_addr_sources, 'CY' , '  ,', 'ie') );

ver_addr_src_cy := __common__( ver_addr_src_cy_pos > 0 );

ver_addr_src_da_pos := __common__( Models.Common.findw_cpp(ver_addr_sources, 'DA' , '  ,', 'ie') );

ver_addr_src_da := __common__( ver_addr_src_da_pos > 0 );

ver_addr_src_d_pos := __common__( Models.Common.findw_cpp(ver_addr_sources, 'D' , '  ,', 'ie') );

ver_addr_src_d := __common__( ver_addr_src_d_pos > 0 );

ver_addr_src_dl_pos := __common__( Models.Common.findw_cpp(ver_addr_sources, 'DL' , '  ,', 'ie') );

ver_addr_src_dl := __common__( ver_addr_src_dl_pos > 0 );

ver_addr_src_ds_pos := __common__( Models.Common.findw_cpp(ver_addr_sources, 'DS' , '  ,', 'ie') );

ver_addr_src_ds := __common__( ver_addr_src_ds_pos > 0 );

ver_addr_src_de_pos := __common__( Models.Common.findw_cpp(ver_addr_sources, 'DE' , '  ,', 'ie') );

ver_addr_src_de := __common__( ver_addr_src_de_pos > 0 );

ver_addr_src_eb_pos := __common__( Models.Common.findw_cpp(ver_addr_sources, 'EB' , '  ,', 'ie') );

ver_addr_src_eb := __common__( ver_addr_src_eb_pos > 0 );

ver_addr_src_em_pos := __common__( Models.Common.findw_cpp(ver_addr_sources, 'EM' , '  ,', 'ie') );

ver_addr_src_em := __common__( ver_addr_src_em_pos > 0 );

ver_addr_src_e1_pos := __common__( Models.Common.findw_cpp(ver_addr_sources, 'E1' , '  ,', 'ie') );

ver_addr_src_e1 := __common__( ver_addr_src_e1_pos > 0 );

ver_addr_src_e2_pos := __common__( Models.Common.findw_cpp(ver_addr_sources, 'E2' , '  ,', 'ie') );

ver_addr_src_e2 := __common__( ver_addr_src_e2_pos > 0 );

ver_addr_src_e3_pos := __common__( Models.Common.findw_cpp(ver_addr_sources, 'E3' , '  ,', 'ie') );

ver_addr_src_e3 := __common__( ver_addr_src_e3_pos > 0 );

ver_addr_src_e4_pos := __common__( Models.Common.findw_cpp(ver_addr_sources, 'E4' , '  ,', 'ie') );

ver_addr_src_e4 := __common__( ver_addr_src_e4_pos > 0 );

ver_addr_src_en_pos := __common__( Models.Common.findw_cpp(ver_addr_sources, 'EN' , '  ,', 'ie') );

ver_addr_src_en := __common__( ver_addr_src_en_pos > 0 );

ver_addr_src_eq_pos := __common__( Models.Common.findw_cpp(ver_addr_sources, 'EQ' , '  ,', 'ie') );

ver_addr_src_eq := __common__( ver_addr_src_eq_pos > 0 );

ver_addr_src_fe_pos := __common__( Models.Common.findw_cpp(ver_addr_sources, 'FE' , '  ,', 'ie') );

ver_addr_src_fe := __common__( ver_addr_src_fe_pos > 0 );

ver_addr_src_ff_pos := __common__( Models.Common.findw_cpp(ver_addr_sources, 'FF' , '  ,', 'ie') );

ver_addr_src_ff := __common__( ver_addr_src_ff_pos > 0 );

ver_addr_src_fr_pos := __common__( Models.Common.findw_cpp(ver_addr_sources, 'FR' , '  ,', 'ie') );

ver_addr_src_fr := __common__( ver_addr_src_fr_pos > 0 );

ver_addr_src_l2_pos := __common__( Models.Common.findw_cpp(ver_addr_sources, 'L2' , '  ,', 'ie') );

ver_addr_src_l2 := __common__( ver_addr_src_l2_pos > 0 );

ver_addr_src_li_pos := __common__( Models.Common.findw_cpp(ver_addr_sources, 'LI' , '  ,', 'ie') );

ver_addr_src_li := __common__( ver_addr_src_li_pos > 0 );

ver_addr_src_mw_pos := __common__( Models.Common.findw_cpp(ver_addr_sources, 'MW' , '  ,', 'ie') );

ver_addr_src_mw := __common__( ver_addr_src_mw_pos > 0 );

ver_addr_src_nt_pos := __common__( Models.Common.findw_cpp(ver_addr_sources, 'NT' , '  ,', 'ie') );

ver_addr_src_nt := __common__( ver_addr_src_nt_pos > 0 );

ver_addr_src_p_pos := __common__( Models.Common.findw_cpp(ver_addr_sources, 'P' , '  ,', 'ie') );

ver_addr_src_p := __common__( ver_addr_src_p_pos > 0 );

ver_addr_src_pl_pos := __common__( Models.Common.findw_cpp(ver_addr_sources, 'PL' , '  ,', 'ie') );

ver_addr_src_pl := __common__( ver_addr_src_pl_pos > 0 );

ver_addr_src_tn_pos := __common__( Models.Common.findw_cpp(ver_addr_sources, 'TN' , '  ,', 'ie') );

ver_addr_src_tn := __common__( ver_addr_src_tn_pos > 0 );

ver_addr_src_ts_pos := __common__( Models.Common.findw_cpp(ver_addr_sources, 'TS' , '  ,', 'ie') );

ver_addr_src_ts := __common__( ver_addr_src_ts_pos > 0 );

ver_addr_src_tu_pos := __common__( Models.Common.findw_cpp(ver_addr_sources, 'TU' , '  ,', 'ie') );

ver_addr_src_tu := __common__( ver_addr_src_tu_pos > 0 );

ver_addr_src_sl_pos := __common__( Models.Common.findw_cpp(ver_addr_sources, 'SL' , '  ,', 'ie') );

ver_addr_src_sl := __common__( ver_addr_src_sl_pos > 0 );

ver_addr_src_v_pos := __common__( Models.Common.findw_cpp(ver_addr_sources, 'V' , '  ,', 'ie') );

ver_addr_src_v := __common__( ver_addr_src_v_pos > 0 );

ver_addr_src_vo_pos := __common__( Models.Common.findw_cpp(ver_addr_sources, 'VO' , '  ,', 'ie') );

ver_addr_src_vo := __common__( ver_addr_src_vo_pos > 0 );

ver_addr_src_w_pos := __common__( Models.Common.findw_cpp(ver_addr_sources, 'W' , '  ,', 'ie') );

ver_addr_src_w := __common__( ver_addr_src_w_pos > 0 );

ver_addr_src_wp_pos := __common__( Models.Common.findw_cpp(ver_addr_sources, 'WP' , '  ,', 'ie') );

ver_addr_src_wp := __common__( ver_addr_src_wp_pos > 0 );

ver_ssn_src_cnt := __common__( Models.Common.countw((string)(ver_ssn_sources), ' !$%&()*+,-./ );<^|') );

ver_ssn_src_pop := __common__( ver_ssn_src_cnt > 0 );

ver_ssn_src_rcnt := __common__( 0 );

ver_ssn_src_fsrc := __common__( Models.Common.getw(ver_ssn_sources, 1) );

ver_ssn_src_ak_pos := __common__( Models.Common.findw_cpp(ver_ssn_sources, 'AK' , '  ,', 'ie') );

ver_ssn_src_ak := __common__( ver_ssn_src_ak_pos > 0 );

ver_ssn_src_am_pos := __common__( Models.Common.findw_cpp(ver_ssn_sources, 'AM' , '  ,', 'ie') );

ver_ssn_src_am := __common__( ver_ssn_src_am_pos > 0 );

ver_ssn_src_ar_pos := __common__( Models.Common.findw_cpp(ver_ssn_sources, 'AR' , '  ,', 'ie') );

ver_ssn_src_ar := __common__( ver_ssn_src_ar_pos > 0 );

ver_ssn_src_ba_pos := __common__( Models.Common.findw_cpp(ver_ssn_sources, 'BA' , '  ,', 'ie') );

ver_ssn_src_ba := __common__( ver_ssn_src_ba_pos > 0 );

ver_ssn_src_cg_pos := __common__( Models.Common.findw_cpp(ver_ssn_sources, 'CG' , '  ,', 'ie') );

ver_ssn_src_cg := __common__( ver_ssn_src_cg_pos > 0 );

ver_ssn_src_co_pos := __common__( Models.Common.findw_cpp(ver_ssn_sources, 'CO' , '  ,', 'ie') );

ver_ssn_src_co := __common__( ver_ssn_src_co_pos > 0 );

ver_ssn_src_cy_pos := __common__( Models.Common.findw_cpp(ver_ssn_sources, 'CY' , '  ,', 'ie') );

ver_ssn_src_cy := __common__( ver_ssn_src_cy_pos > 0 );

ver_ssn_src_da_pos := __common__( Models.Common.findw_cpp(ver_ssn_sources, 'DA' , '  ,', 'ie') );

ver_ssn_src_da := __common__( ver_ssn_src_da_pos > 0 );

ver_ssn_src_d_pos := __common__( Models.Common.findw_cpp(ver_ssn_sources, 'D' , '  ,', 'ie') );

ver_ssn_src_d := __common__( ver_ssn_src_d_pos > 0 );

ver_ssn_src_dl_pos := __common__( Models.Common.findw_cpp(ver_ssn_sources, 'DL' , '  ,', 'ie') );

ver_ssn_src_dl := __common__( ver_ssn_src_dl_pos > 0 );

ver_ssn_src_ds_pos := __common__( Models.Common.findw_cpp(ver_ssn_sources, 'DS' , '  ,', 'ie') );

ver_ssn_src_ds := __common__( ver_ssn_src_ds_pos > 0 );

ver_ssn_src_de_pos := __common__( Models.Common.findw_cpp(ver_ssn_sources, 'DE' , '  ,', 'ie') );

ver_ssn_src_de := __common__( ver_ssn_src_de_pos > 0 );

ver_ssn_src_eb_pos := __common__( Models.Common.findw_cpp(ver_ssn_sources, 'EB' , '  ,', 'ie') );

ver_ssn_src_eb := __common__( ver_ssn_src_eb_pos > 0 );

ver_ssn_src_em_pos := __common__( Models.Common.findw_cpp(ver_ssn_sources, 'EM' , '  ,', 'ie') );

ver_ssn_src_em := __common__( ver_ssn_src_em_pos > 0 );

ver_ssn_src_e1_pos := __common__( Models.Common.findw_cpp(ver_ssn_sources, 'E1' , '  ,', 'ie') );

ver_ssn_src_e1 := __common__( ver_ssn_src_e1_pos > 0 );

ver_ssn_src_e2_pos := __common__( Models.Common.findw_cpp(ver_ssn_sources, 'E2' , '  ,', 'ie') );

ver_ssn_src_e2 := __common__( ver_ssn_src_e2_pos > 0 );

ver_ssn_src_e3_pos := __common__( Models.Common.findw_cpp(ver_ssn_sources, 'E3' , '  ,', 'ie') );

ver_ssn_src_e3 := __common__( ver_ssn_src_e3_pos > 0 );

ver_ssn_src_e4_pos := __common__( Models.Common.findw_cpp(ver_ssn_sources, 'E4' , '  ,', 'ie') );

ver_ssn_src_e4 := __common__( ver_ssn_src_e4_pos > 0 );

ver_ssn_src_en_pos := __common__( Models.Common.findw_cpp(ver_ssn_sources, 'EN' , '  ,', 'ie') );

ver_ssn_src_en := __common__( ver_ssn_src_en_pos > 0 );

ver_ssn_src_eq_pos := __common__( Models.Common.findw_cpp(ver_ssn_sources, 'EQ' , '  ,', 'ie') );

ver_ssn_src_eq := __common__( ver_ssn_src_eq_pos > 0 );

ver_ssn_src_fe_pos := __common__( Models.Common.findw_cpp(ver_ssn_sources, 'FE' , '  ,', 'ie') );

ver_ssn_src_fe := __common__( ver_ssn_src_fe_pos > 0 );

ver_ssn_src_ff_pos := __common__( Models.Common.findw_cpp(ver_ssn_sources, 'FF' , '  ,', 'ie') );

ver_ssn_src_ff := __common__( ver_ssn_src_ff_pos > 0 );

ver_ssn_src_fr_pos := __common__( Models.Common.findw_cpp(ver_ssn_sources, 'FR' , '  ,', 'ie') );

ver_ssn_src_fr := __common__( ver_ssn_src_fr_pos > 0 );

ver_ssn_src_l2_pos := __common__( Models.Common.findw_cpp(ver_ssn_sources, 'L2' , '  ,', 'ie') );

ver_ssn_src_l2 := __common__( ver_ssn_src_l2_pos > 0 );

ver_ssn_src_li_pos := __common__( Models.Common.findw_cpp(ver_ssn_sources, 'LI' , '  ,', 'ie') );

ver_ssn_src_li := __common__( ver_ssn_src_li_pos > 0 );

ver_ssn_src_mw_pos := __common__( Models.Common.findw_cpp(ver_ssn_sources, 'MW' , '  ,', 'ie') );

ver_ssn_src_mw := __common__( ver_ssn_src_mw_pos > 0 );

ver_ssn_src_nt_pos := __common__( Models.Common.findw_cpp(ver_ssn_sources, 'NT' , '  ,', 'ie') );

ver_ssn_src_nt := __common__( ver_ssn_src_nt_pos > 0 );

ver_ssn_src_p_pos := __common__( Models.Common.findw_cpp(ver_ssn_sources, 'P' , '  ,', 'ie') );

ver_ssn_src_p := __common__( ver_ssn_src_p_pos > 0 );

ver_ssn_src_pl_pos := __common__( Models.Common.findw_cpp(ver_ssn_sources, 'PL' , '  ,', 'ie') );

ver_ssn_src_pl := __common__( ver_ssn_src_pl_pos > 0 );

ver_ssn_src_tn_pos := __common__( Models.Common.findw_cpp(ver_ssn_sources, 'TN' , '  ,', 'ie') );

ver_ssn_src_tn := __common__( ver_ssn_src_tn_pos > 0 );

ver_ssn_src_ts_pos := __common__( Models.Common.findw_cpp(ver_ssn_sources, 'TS' , '  ,', 'ie') );

ver_ssn_src_ts := __common__( ver_ssn_src_ts_pos > 0 );

ver_ssn_src_tu_pos := __common__( Models.Common.findw_cpp(ver_ssn_sources, 'TU' , '  ,', 'ie') );

ver_ssn_src_tu := __common__( ver_ssn_src_tu_pos > 0 );

ver_ssn_src_sl_pos := __common__( Models.Common.findw_cpp(ver_ssn_sources, 'SL' , '  ,', 'ie') );

ver_ssn_src_sl := __common__( ver_ssn_src_sl_pos > 0 );

ver_ssn_src_v_pos := __common__( Models.Common.findw_cpp(ver_ssn_sources, 'V' , '  ,', 'ie') );

ver_ssn_src_v := __common__( ver_ssn_src_v_pos > 0 );

ver_ssn_src_vo_pos := __common__( Models.Common.findw_cpp(ver_ssn_sources, 'VO' , '  ,', 'ie') );

ver_ssn_src_vo := __common__( ver_ssn_src_vo_pos > 0 );

ver_ssn_src_w_pos := __common__( Models.Common.findw_cpp(ver_ssn_sources, 'W' , '  ,', 'ie') );

ver_ssn_src_w := __common__( ver_ssn_src_w_pos > 0 );

ver_ssn_src_wp_pos := __common__( Models.Common.findw_cpp(ver_ssn_sources, 'WP' , '  ,', 'ie') );

ver_ssn_src_wp := __common__( ver_ssn_src_wp_pos > 0 );

ver_dob_src_cnt := __common__( Models.Common.countw((string)(ver_dob_sources), ' !$%&()*+,-./ );<^|') );

ver_dob_src_pop := __common__( ver_dob_src_cnt > 0 );

ver_dob_src_rcnt := __common__( 0 );

ver_dob_src_fsrc := __common__( Models.Common.getw(ver_dob_sources, 1) );

ver_dob_src_ak_pos := __common__( Models.Common.findw_cpp(ver_dob_sources, 'AK' , '  ,', 'ie') );

ver_dob_src_ak := __common__( ver_dob_src_ak_pos > 0 );

ver_dob_src_am_pos := __common__( Models.Common.findw_cpp(ver_dob_sources, 'AM' , '  ,', 'ie') );

ver_dob_src_am := __common__( ver_dob_src_am_pos > 0 );

ver_dob_src_ar_pos := __common__( Models.Common.findw_cpp(ver_dob_sources, 'AR' , '  ,', 'ie') );

ver_dob_src_ar := __common__( ver_dob_src_ar_pos > 0 );

ver_dob_src_ba_pos := __common__( Models.Common.findw_cpp(ver_dob_sources, 'BA' , '  ,', 'ie') );

ver_dob_src_ba := __common__( ver_dob_src_ba_pos > 0 );

ver_dob_src_cg_pos := __common__( Models.Common.findw_cpp(ver_dob_sources, 'CG' , '  ,', 'ie') );

ver_dob_src_cg := __common__( ver_dob_src_cg_pos > 0 );

ver_dob_src_co_pos := __common__( Models.Common.findw_cpp(ver_dob_sources, 'CO' , '  ,', 'ie') );

ver_dob_src_co := __common__( ver_dob_src_co_pos > 0 );

ver_dob_src_cy_pos := __common__( Models.Common.findw_cpp(ver_dob_sources, 'CY' , '  ,', 'ie') );

ver_dob_src_cy := __common__( ver_dob_src_cy_pos > 0 );

ver_dob_src_da_pos := __common__( Models.Common.findw_cpp(ver_dob_sources, 'DA' , '  ,', 'ie') );

ver_dob_src_da := __common__( ver_dob_src_da_pos > 0 );

ver_dob_src_d_pos := __common__( Models.Common.findw_cpp(ver_dob_sources, 'D' , '  ,', 'ie') );

ver_dob_src_d := __common__( ver_dob_src_d_pos > 0 );

ver_dob_src_dl_pos := __common__( Models.Common.findw_cpp(ver_dob_sources, 'DL' , '  ,', 'ie') );

ver_dob_src_dl := __common__( ver_dob_src_dl_pos > 0 );

ver_dob_src_ds_pos := __common__( Models.Common.findw_cpp(ver_dob_sources, 'DS' , '  ,', 'ie') );

ver_dob_src_ds := __common__( ver_dob_src_ds_pos > 0 );

ver_dob_src_de_pos := __common__( Models.Common.findw_cpp(ver_dob_sources, 'DE' , '  ,', 'ie') );

ver_dob_src_de := __common__( ver_dob_src_de_pos > 0 );

ver_dob_src_eb_pos := __common__( Models.Common.findw_cpp(ver_dob_sources, 'EB' , '  ,', 'ie') );

ver_dob_src_eb := __common__( ver_dob_src_eb_pos > 0 );

ver_dob_src_em_pos := __common__( Models.Common.findw_cpp(ver_dob_sources, 'EM' , '  ,', 'ie') );

ver_dob_src_em := __common__( ver_dob_src_em_pos > 0 );

ver_dob_src_e1_pos := __common__( Models.Common.findw_cpp(ver_dob_sources, 'E1' , '  ,', 'ie') );

ver_dob_src_e1 := __common__( ver_dob_src_e1_pos > 0 );

ver_dob_src_e2_pos := __common__( Models.Common.findw_cpp(ver_dob_sources, 'E2' , '  ,', 'ie') );

ver_dob_src_e2 := __common__( ver_dob_src_e2_pos > 0 );

ver_dob_src_e3_pos := __common__( Models.Common.findw_cpp(ver_dob_sources, 'E3' , '  ,', 'ie') );

ver_dob_src_e3 := __common__( ver_dob_src_e3_pos > 0 );

ver_dob_src_e4_pos := __common__( Models.Common.findw_cpp(ver_dob_sources, 'E4' , '  ,', 'ie') );

ver_dob_src_e4 := __common__( ver_dob_src_e4_pos > 0 );

ver_dob_src_en_pos := __common__( Models.Common.findw_cpp(ver_dob_sources, 'EN' , '  ,', 'ie') );

ver_dob_src_en := __common__( ver_dob_src_en_pos > 0 );

ver_dob_src_eq_pos := __common__( Models.Common.findw_cpp(ver_dob_sources, 'EQ' , '  ,', 'ie') );

ver_dob_src_eq := __common__( ver_dob_src_eq_pos > 0 );

ver_dob_src_fe_pos := __common__( Models.Common.findw_cpp(ver_dob_sources, 'FE' , '  ,', 'ie') );

ver_dob_src_fe := __common__( ver_dob_src_fe_pos > 0 );

ver_dob_src_ff_pos := __common__( Models.Common.findw_cpp(ver_dob_sources, 'FF' , '  ,', 'ie') );

ver_dob_src_ff := __common__( ver_dob_src_ff_pos > 0 );

ver_dob_src_fr_pos := __common__( Models.Common.findw_cpp(ver_dob_sources, 'FR' , '  ,', 'ie') );

ver_dob_src_fr := __common__( ver_dob_src_fr_pos > 0 );

ver_dob_src_l2_pos := __common__( Models.Common.findw_cpp(ver_dob_sources, 'L2' , '  ,', 'ie') );

ver_dob_src_l2 := __common__( ver_dob_src_l2_pos > 0 );

ver_dob_src_li_pos := __common__( Models.Common.findw_cpp(ver_dob_sources, 'LI' , '  ,', 'ie') );

ver_dob_src_li := __common__( ver_dob_src_li_pos > 0 );

ver_dob_src_mw_pos := __common__( Models.Common.findw_cpp(ver_dob_sources, 'MW' , '  ,', 'ie') );

ver_dob_src_mw := __common__( ver_dob_src_mw_pos > 0 );

ver_dob_src_nt_pos := __common__( Models.Common.findw_cpp(ver_dob_sources, 'NT' , '  ,', 'ie') );

ver_dob_src_nt := __common__( ver_dob_src_nt_pos > 0 );

ver_dob_src_p_pos := __common__( Models.Common.findw_cpp(ver_dob_sources, 'P' , '  ,', 'ie') );

ver_dob_src_p := __common__( ver_dob_src_p_pos > 0 );

ver_dob_src_pl_pos := __common__( Models.Common.findw_cpp(ver_dob_sources, 'PL' , '  ,', 'ie') );

ver_dob_src_pl := __common__( ver_dob_src_pl_pos > 0 );

ver_dob_src_tn_pos := __common__( Models.Common.findw_cpp(ver_dob_sources, 'TN' , '  ,', 'ie') );

ver_dob_src_tn := __common__( ver_dob_src_tn_pos > 0 );

ver_dob_src_ts_pos := __common__( Models.Common.findw_cpp(ver_dob_sources, 'TS' , '  ,', 'ie') );

ver_dob_src_ts := __common__( ver_dob_src_ts_pos > 0 );

ver_dob_src_tu_pos := __common__( Models.Common.findw_cpp(ver_dob_sources, 'TU' , '  ,', 'ie') );

ver_dob_src_tu := __common__( ver_dob_src_tu_pos > 0 );

ver_dob_src_sl_pos := __common__( Models.Common.findw_cpp(ver_dob_sources, 'SL' , '  ,', 'ie') );

ver_dob_src_sl := __common__( ver_dob_src_sl_pos > 0 );

ver_dob_src_v_pos := __common__( Models.Common.findw_cpp(ver_dob_sources, 'V' , '  ,', 'ie') );

ver_dob_src_v := __common__( ver_dob_src_v_pos > 0 );

ver_dob_src_vo_pos := __common__( Models.Common.findw_cpp(ver_dob_sources, 'VO' , '  ,', 'ie') );

ver_dob_src_vo := __common__( ver_dob_src_vo_pos > 0 );

ver_dob_src_w_pos := __common__( Models.Common.findw_cpp(ver_dob_sources, 'W' , '  ,', 'ie') );

ver_dob_src_w := __common__( ver_dob_src_w_pos > 0 );

ver_dob_src_wp_pos := __common__( Models.Common.findw_cpp(ver_dob_sources, 'WP' , '  ,', 'ie') );

ver_dob_src_wp := __common__( ver_dob_src_wp_pos > 0 );

email_src_cnt := __common__( Models.Common.countw((string)(email_source_list), ' !$%&()*+,-./ );<^|') );

email_src_pop := __common__( email_src_cnt > 0 );

email_src_rcnt := __common__( 0 );

email_src_fsrc := __common__( Models.Common.getw(email_source_list, 1) );

email_src_aw_pos := __common__( Models.Common.findw_cpp(email_source_list, 'AW' , '  ,', 'ie') );

email_src_aw := __common__( email_src_aw_pos > 0 );

email_src_et_pos := __common__( Models.Common.findw_cpp(email_source_list, 'ET' , '  ,', 'ie') );

email_src_et := __common__( email_src_et_pos > 0 );

email_src_wa_pos := __common__( Models.Common.findw_cpp(email_source_list, 'W@' , '  ,', 'ie') );

email_src_wa := __common__( email_src_wa_pos > 0 );

email_src_om_pos := __common__( Models.Common.findw_cpp(email_source_list, 'OM' , '  ,', 'ie') );

email_src_om := __common__( email_src_om_pos > 0 );

email_src_m1_pos := __common__( Models.Common.findw_cpp(email_source_list, 'M1' , '  ,', 'ie') );

email_src_m1 := __common__( email_src_m1_pos > 0 );

email_src_sc_pos := __common__( Models.Common.findw_cpp(email_source_list, 'SC' , '  ,', 'ie') );

email_src_sc := __common__( email_src_sc_pos > 0 );

email_src_dg_pos := __common__( Models.Common.findw_cpp(email_source_list, 'DG' , '  ,', 'ie') );

email_src_dg := __common__( email_src_dg_pos > 0 );

util_type_cnt := __common__( Models.Common.countw((string)(util_adl_type_list), ' !$%&()*+,-./ );<^|') );

util_type_pop := __common__( util_type_cnt > 0 );

util_type_rcnt := __common__( 0 );

util_type_fsrc := __common__( Models.Common.getw(util_adl_type_list, 1) );

util_type_2_pos := __common__( Models.Common.findw_cpp(util_adl_type_list, '2' , '  ,', 'ie') );

util_type_2 := __common__( util_type_2_pos > 0 );

util_type_1_pos := __common__( Models.Common.findw_cpp(util_adl_type_list, '1' , '  ,', 'ie') );

util_type_1 := __common__( util_type_1_pos > 0 );

util_type_z_pos := __common__( Models.Common.findw_cpp(util_adl_type_list, 'Z' , '  ,', 'ie') );

util_type_z := __common__( util_type_z_pos > 0 );

util_inp_cnt := __common__( Models.Common.countw((string)(util_add_input_type_list), ' !$%&()*+,-./ );<^|') );

util_inp_pop := __common__( util_inp_cnt > 0 );

util_inp_rcnt := __common__( 0 );

util_inp_fsrc := __common__( Models.Common.getw(util_add_input_type_list, 1) );

util_inp_2_pos := __common__( Models.Common.findw_cpp(util_add_input_type_list, '2' , '  ,', 'ie') );

util_inp_2 := __common__( util_inp_2_pos > 0 );

util_inp_1_pos := __common__( Models.Common.findw_cpp(util_add_input_type_list, '1' , '  ,', 'ie') );

util_inp_1 := __common__( util_inp_1_pos > 0 );

util_inp_z_pos := __common__( Models.Common.findw_cpp(util_add_input_type_list, 'Z' , '  ,', 'ie') );

util_inp_z := __common__( util_inp_z_pos > 0 );

util_curr_cnt := __common__( Models.Common.countw((string)(util_add_curr_type_list), ' !$%&()*+,-./ );<^|') );

util_curr_pop := __common__( util_curr_cnt > 0 );

util_curr_rcnt := __common__( 0 );

util_curr_fsrc := __common__( Models.Common.getw(util_add_curr_type_list, 1) );

util_curr_2_pos := __common__( Models.Common.findw_cpp(util_add_curr_type_list, '2' , '  ,', 'ie') );

util_curr_2 := __common__( util_curr_2_pos > 0 );

util_curr_1_pos := __common__( Models.Common.findw_cpp(util_add_curr_type_list, '1' , '  ,', 'ie') );

util_curr_1 := __common__( util_curr_1_pos > 0 );

util_curr_z_pos := __common__( Models.Common.findw_cpp(util_add_curr_type_list, 'Z' , '  ,', 'ie') );

util_curr_z := __common__( util_curr_z_pos > 0 );

nf_inq_communications_count := __common__( if(not(truedid), NULL, min(if(inq_Communications_count = NULL, -NULL, inq_Communications_count), 999)) );

_in_dob := __common__( common.sas_date((string)(in_dob)) );

yr_in_dob := __common__( if(_in_dob = NULL, -1, (sysdate - _in_dob) / 365.25) );

yr_in_dob_int := __common__( if (yr_in_dob >= 0, roundup(yr_in_dob), truncate(yr_in_dob)) );

rv_comb_age := __common__( map(
    yr_in_dob_int > 0            => yr_in_dob_int,
    inferred_age > 0 and truedid => inferred_age,
                                    NULL) );

nf_inq_communications_count24 := __common__( if(not(truedid), NULL, min(if(inq_Communications_count24 = NULL, -NULL, inq_Communications_count24), 999)) );

iv_estimated_income := __common__( if(not(TrueDID), NULL, estimated_income) );

//nf_fp_varrisktype := __common__( if(not(truedid), NULL, fp_varrisktype) );
nf_fp_varrisktype := __common__( __common__( map(
    not(truedid)          => NULL,
    fp_varrisktype = '' => NULL,
            (Integer)trim(fp_varrisktype, LEFT))) );



nf_inq_prepaidcards_count := __common__( if(not(truedid), NULL, min(if(inq_PrepaidCards_count = NULL, -NULL, inq_PrepaidCards_count), 999)) );

rv_d32_criminal_count := __common__( if(not(truedid), NULL, min(if(criminal_count = NULL, -NULL, criminal_count), 999)) );

rv_d32_felony_count := __common__( if(not(truedid), NULL, min(if(felony_count = NULL, -NULL, felony_count), 999)) );

rv_d31_bk_disposed_hist_count := __common__( if(not(truedid), NULL, min(if(bk_disposed_historical_count = NULL, -NULL, bk_disposed_historical_count), 999)) );

nf_inq_perssn_count01 := __common__( if(not(ssnlength > '0'), NULL, min(if(inq_perssn_count01 = NULL, -NULL, inq_perssn_count01), 999)) );

rv_d34_liens_unreleased_ct84 := __common__( if(not(truedid), NULL, liens_unreleased_count84) );

vo_pos := __common__( Models.Common.findw_cpp(ver_sources, 'VO' , ', ', 'E') );

iv_src_voter_adl_count := __common__( map(
    not(truedid)     => NULL,
    not(voter_avail) => -1,
    vo_pos <= 0      => 0,
                        (integer)Models.Common.getw(ver_sources_count, vo_pos, ',')) );

rv_i61_inq_collection_count12 := __common__( if(not(truedid), NULL, min(if(inq_collection_count12 = NULL, -NULL, inq_collection_count12), 999)) );

nf_inq_ssnsperadl_count03 := __common__( if(not(truedid), NULL, min(if(inq_ssnsperadl_count03 = NULL, -NULL, inq_ssnsperadl_count03), 999)) );

nf_average_rel_age := __common__( map(
    not(truedid)                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               => NULL,
    rel_count = 0                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              => -1,
    if(max(rel_ageunder20_count, rel_ageunder30_count, rel_ageunder40_count, rel_ageunder50_count, rel_ageunder60_count, rel_ageunder70_count, rel_ageover70_count) = NULL, NULL, sum(if(rel_ageunder20_count = NULL, 0, rel_ageunder20_count), if(rel_ageunder30_count = NULL, 0, rel_ageunder30_count), if(rel_ageunder40_count = NULL, 0, rel_ageunder40_count), if(rel_ageunder50_count = NULL, 0, rel_ageunder50_count), if(rel_ageunder60_count = NULL, 0, rel_ageunder60_count), if(rel_ageunder70_count = NULL, 0, rel_ageunder70_count), if(rel_ageover70_count = NULL, 0, rel_ageover70_count))) = 0 => 0,
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  if (if(max(rel_ageunder20_count * 20, rel_ageunder30_count * 30, rel_ageunder40_count * 40, rel_ageunder50_count * 50, rel_ageunder60_count * 60, rel_ageunder70_count * 70, rel_ageover70_count * 80) = NULL, NULL, sum(if(rel_ageunder20_count * 20 = NULL, 0, rel_ageunder20_count * 20), if(rel_ageunder30_count * 30 = NULL, 0, rel_ageunder30_count * 30), if(rel_ageunder40_count * 40 = NULL, 0, rel_ageunder40_count * 40), if(rel_ageunder50_count * 50 = NULL, 0, rel_ageunder50_count * 50), if(rel_ageunder60_count * 60 = NULL, 0, rel_ageunder60_count * 60), if(rel_ageunder70_count * 70 = NULL, 0, rel_ageunder70_count * 70), if(rel_ageover70_count * 80 = NULL, 0, rel_ageover70_count * 80))) / if(max(rel_ageunder20_count, rel_ageunder30_count, rel_ageunder40_count, rel_ageunder50_count, rel_ageunder60_count, rel_ageunder70_count, rel_ageover70_count) = NULL, NULL, sum(if(rel_ageunder20_count = NULL, 0, rel_ageunder20_count), if(rel_ageunder30_count = NULL, 0, rel_ageunder30_count), if(rel_ageunder40_count = NULL, 0, rel_ageunder40_count), if(rel_ageunder50_count = NULL, 0, rel_ageunder50_count), if(rel_ageunder60_count = NULL, 0, rel_ageunder60_count), if(rel_ageunder70_count = NULL, 0, rel_ageunder70_count), if(rel_ageover70_count = NULL, 0, rel_ageover70_count))) >= 0, truncate(if(max(rel_ageunder20_count * 20, rel_ageunder30_count * 30, rel_ageunder40_count * 40, rel_ageunder50_count * 50, rel_ageunder60_count * 60, rel_ageunder70_count * 70, rel_ageover70_count * 80) = NULL, NULL, sum(if(rel_ageunder20_count * 20 = NULL, 0, rel_ageunder20_count * 20), if(rel_ageunder30_count * 30 = NULL, 0, rel_ageunder30_count * 30), if(rel_ageunder40_count * 40 = NULL, 0, rel_ageunder40_count * 40), if(rel_ageunder50_count * 50 = NULL, 0, rel_ageunder50_count * 50), if(rel_ageunder60_count * 60 = NULL, 0, rel_ageunder60_count * 60), if(rel_ageunder70_count * 70 = NULL, 0, rel_ageunder70_count * 70), if(rel_ageover70_count * 80 = NULL, 0, rel_ageover70_count * 80))) / if(max(rel_ageunder20_count, rel_ageunder30_count, rel_ageunder40_count, rel_ageunder50_count, rel_ageunder60_count, rel_ageunder70_count, rel_ageover70_count) = NULL, NULL, sum(if(rel_ageunder20_count = NULL, 0, rel_ageunder20_count), if(rel_ageunder30_count = NULL, 0, rel_ageunder30_count), if(rel_ageunder40_count = NULL, 0, rel_ageunder40_count), if(rel_ageunder50_count = NULL, 0, rel_ageunder50_count), if(rel_ageunder60_count = NULL, 0, rel_ageunder60_count), if(rel_ageunder70_count = NULL, 0, rel_ageunder70_count), if(rel_ageover70_count = NULL, 0, rel_ageover70_count)))), roundup(if(max(rel_ageunder20_count * 20, rel_ageunder30_count * 30, rel_ageunder40_count * 40, rel_ageunder50_count * 50, rel_ageunder60_count * 60, rel_ageunder70_count * 70, rel_ageover70_count * 80) = NULL, NULL, sum(if(rel_ageunder20_count * 20 = NULL, 0, rel_ageunder20_count * 20), if(rel_ageunder30_count * 30 = NULL, 0, rel_ageunder30_count * 30), if(rel_ageunder40_count * 40 = NULL, 0, rel_ageunder40_count * 40), if(rel_ageunder50_count * 50 = NULL, 0, rel_ageunder50_count * 50), if(rel_ageunder60_count * 60 = NULL, 0, rel_ageunder60_count * 60), if(rel_ageunder70_count * 70 = NULL, 0, rel_ageunder70_count * 70), if(rel_ageover70_count * 80 = NULL, 0, rel_ageover70_count * 80))) / if(max(rel_ageunder20_count, rel_ageunder30_count, rel_ageunder40_count, rel_ageunder50_count, rel_ageunder60_count, rel_ageunder70_count, rel_ageover70_count) = NULL, NULL, sum(if(rel_ageunder20_count = NULL, 0, rel_ageunder20_count), if(rel_ageunder30_count = NULL, 0, rel_ageunder30_count), if(rel_ageunder40_count = NULL, 0, rel_ageunder40_count), if(rel_ageunder50_count = NULL, 0, rel_ageunder50_count), if(rel_ageunder60_count = NULL, 0, rel_ageunder60_count), if(rel_ageunder70_count = NULL, 0, rel_ageunder70_count), if(rel_ageover70_count = NULL, 0, rel_ageover70_count)))))) );

nf_fp_curraddrcartheftindex := __common__( if(not(truedid), NULL, (integer)fp_curraddrcartheftindex) );

rv_d33_eviction_count := __common__( if(not(truedid), NULL, min(if(attr_eviction_count = NULL, -NULL, attr_eviction_count), 999)) );

nf_inq_other_count24 := __common__( if(not(truedid), NULL, min(if(inq_Other_count24 = NULL, -NULL, inq_Other_count24), 999)) );

corrssnaddr_src_cnt := __common__( Models.Common.countw((string)(corrssnaddr_sources), ' !$%&()*+,-./ );<^|') );

corrssnaddr_src_pop := __common__( corrssnaddr_src_cnt > 0 );

corrssnaddr_src_rcnt := __common__( 0 );

corrssnaddr_src_fsrc := __common__( Models.Common.getw(corrssnaddr_sources, 1) );

corrssnaddr_src_ak_pos := __common__( Models.Common.findw_cpp(corrssnaddr_sources, 'AK' , '  ,', 'ie') );

corrssnaddr_src_ak := __common__( corrssnaddr_src_ak_pos > 0 );

corrssnaddr_src_am_pos := __common__( Models.Common.findw_cpp(corrssnaddr_sources, 'AM' , '  ,', 'ie') );

corrssnaddr_src_am := __common__( corrssnaddr_src_am_pos > 0 );

corrssnaddr_src_ar_pos := __common__( Models.Common.findw_cpp(corrssnaddr_sources, 'AR' , '  ,', 'ie') );

corrssnaddr_src_ar := __common__( corrssnaddr_src_ar_pos > 0 );

corrssnaddr_src_ba_pos := __common__( Models.Common.findw_cpp(corrssnaddr_sources, 'BA' , '  ,', 'ie') );

corrssnaddr_src_ba := __common__( corrssnaddr_src_ba_pos > 0 );

corrssnaddr_src_cg_pos := __common__( Models.Common.findw_cpp(corrssnaddr_sources, 'CG' , '  ,', 'ie') );

corrssnaddr_src_cg := __common__( corrssnaddr_src_cg_pos > 0 );

corrssnaddr_src_co_pos := __common__( Models.Common.findw_cpp(corrssnaddr_sources, 'CO' , '  ,', 'ie') );

corrssnaddr_src_co := __common__( corrssnaddr_src_co_pos > 0 );

corrssnaddr_src_cy_pos := __common__( Models.Common.findw_cpp(corrssnaddr_sources, 'CY' , '  ,', 'ie') );

corrssnaddr_src_cy := __common__( corrssnaddr_src_cy_pos > 0 );

corrssnaddr_src_da_pos := __common__( Models.Common.findw_cpp(corrssnaddr_sources, 'DA' , '  ,', 'ie') );

corrssnaddr_src_da := __common__( corrssnaddr_src_da_pos > 0 );

corrssnaddr_src_d_pos := __common__( Models.Common.findw_cpp(corrssnaddr_sources, 'D' , '  ,', 'ie') );

corrssnaddr_src_d := __common__( corrssnaddr_src_d_pos > 0 );

corrssnaddr_src_dl_pos := __common__( Models.Common.findw_cpp(corrssnaddr_sources, 'DL' , '  ,', 'ie') );

corrssnaddr_src_dl := __common__( corrssnaddr_src_dl_pos > 0 );

corrssnaddr_src_ds_pos := __common__( Models.Common.findw_cpp(corrssnaddr_sources, 'DS' , '  ,', 'ie') );

corrssnaddr_src_ds := __common__( corrssnaddr_src_ds_pos > 0 );

corrssnaddr_src_de_pos := __common__( Models.Common.findw_cpp(corrssnaddr_sources, 'DE' , '  ,', 'ie') );

corrssnaddr_src_de := __common__( corrssnaddr_src_de_pos > 0 );

corrssnaddr_src_eb_pos := __common__( Models.Common.findw_cpp(corrssnaddr_sources, 'EB' , '  ,', 'ie') );

corrssnaddr_src_eb := __common__( corrssnaddr_src_eb_pos > 0 );

corrssnaddr_src_em_pos := __common__( Models.Common.findw_cpp(corrssnaddr_sources, 'EM' , '  ,', 'ie') );

corrssnaddr_src_em := __common__( corrssnaddr_src_em_pos > 0 );

corrssnaddr_src_e1_pos := __common__( Models.Common.findw_cpp(corrssnaddr_sources, 'E1' , '  ,', 'ie') );

corrssnaddr_src_e1 := __common__( corrssnaddr_src_e1_pos > 0 );

corrssnaddr_src_e2_pos := __common__( Models.Common.findw_cpp(corrssnaddr_sources, 'E2' , '  ,', 'ie') );

corrssnaddr_src_e2 := __common__( corrssnaddr_src_e2_pos > 0 );

corrssnaddr_src_e3_pos := __common__( Models.Common.findw_cpp(corrssnaddr_sources, 'E3' , '  ,', 'ie') );

corrssnaddr_src_e3 := __common__( corrssnaddr_src_e3_pos > 0 );

corrssnaddr_src_e4_pos := __common__( Models.Common.findw_cpp(corrssnaddr_sources, 'E4' , '  ,', 'ie') );

corrssnaddr_src_e4 := __common__( corrssnaddr_src_e4_pos > 0 );

corrssnaddr_src_en_pos := __common__( Models.Common.findw_cpp(corrssnaddr_sources, 'EN' , '  ,', 'ie') );

corrssnaddr_src_en := __common__( corrssnaddr_src_en_pos > 0 );

corrssnaddr_src_eq_pos := __common__( Models.Common.findw_cpp(corrssnaddr_sources, 'EQ' , '  ,', 'ie') );

corrssnaddr_src_eq := __common__( corrssnaddr_src_eq_pos > 0 );

corrssnaddr_src_fe_pos := __common__( Models.Common.findw_cpp(corrssnaddr_sources, 'FE' , '  ,', 'ie') );

corrssnaddr_src_fe := __common__( corrssnaddr_src_fe_pos > 0 );

corrssnaddr_src_ff_pos := __common__( Models.Common.findw_cpp(corrssnaddr_sources, 'FF' , '  ,', 'ie') );

corrssnaddr_src_ff := __common__( corrssnaddr_src_ff_pos > 0 );

corrssnaddr_src_fr_pos := __common__( Models.Common.findw_cpp(corrssnaddr_sources, 'FR' , '  ,', 'ie') );

corrssnaddr_src_fr := __common__( corrssnaddr_src_fr_pos > 0 );

corrssnaddr_src_l2_pos := __common__( Models.Common.findw_cpp(corrssnaddr_sources, 'L2' , '  ,', 'ie') );

corrssnaddr_src_l2 := __common__( corrssnaddr_src_l2_pos > 0 );

corrssnaddr_src_li_pos := __common__( Models.Common.findw_cpp(corrssnaddr_sources, 'LI' , '  ,', 'ie') );

corrssnaddr_src_li := __common__( corrssnaddr_src_li_pos > 0 );

corrssnaddr_src_mw_pos := __common__( Models.Common.findw_cpp(corrssnaddr_sources, 'MW' , '  ,', 'ie') );

corrssnaddr_src_mw := __common__( corrssnaddr_src_mw_pos > 0 );

corrssnaddr_src_nt_pos := __common__( Models.Common.findw_cpp(corrssnaddr_sources, 'NT' , '  ,', 'ie') );

corrssnaddr_src_nt := __common__( corrssnaddr_src_nt_pos > 0 );

corrssnaddr_src_p_pos := __common__( Models.Common.findw_cpp(corrssnaddr_sources, 'P' , '  ,', 'ie') );

corrssnaddr_src_p := __common__( corrssnaddr_src_p_pos > 0 );

corrssnaddr_src_pl_pos := __common__( Models.Common.findw_cpp(corrssnaddr_sources, 'PL' , '  ,', 'ie') );

corrssnaddr_src_pl := __common__( corrssnaddr_src_pl_pos > 0 );

corrssnaddr_src_tn_pos := __common__( Models.Common.findw_cpp(corrssnaddr_sources, 'TN' , '  ,', 'ie') );

corrssnaddr_src_tn := __common__( corrssnaddr_src_tn_pos > 0 );

corrssnaddr_src_ts_pos := __common__( Models.Common.findw_cpp(corrssnaddr_sources, 'TS' , '  ,', 'ie') );

corrssnaddr_src_ts := __common__( corrssnaddr_src_ts_pos > 0 );

corrssnaddr_src_tu_pos := __common__( Models.Common.findw_cpp(corrssnaddr_sources, 'TU' , '  ,', 'ie') );

corrssnaddr_src_tu := __common__( corrssnaddr_src_tu_pos > 0 );

corrssnaddr_src_sl_pos := __common__( Models.Common.findw_cpp(corrssnaddr_sources, 'SL' , '  ,', 'ie') );

corrssnaddr_src_sl := __common__( corrssnaddr_src_sl_pos > 0 );

corrssnaddr_src_v_pos := __common__( Models.Common.findw_cpp(corrssnaddr_sources, 'V' , '  ,', 'ie') );

corrssnaddr_src_v := __common__( corrssnaddr_src_v_pos > 0 );

corrssnaddr_src_vo_pos := __common__( Models.Common.findw_cpp(corrssnaddr_sources, 'VO' , '  ,', 'ie') );

corrssnaddr_src_vo := __common__( corrssnaddr_src_vo_pos > 0 );

corrssnaddr_src_w_pos := __common__( Models.Common.findw_cpp(corrssnaddr_sources, 'W' , '  ,', 'ie') );

corrssnaddr_src_w := __common__( corrssnaddr_src_w_pos > 0 );

corrssnaddr_src_wp_pos := __common__( Models.Common.findw_cpp(corrssnaddr_sources, 'WP' , '  ,', 'ie') );

corrssnaddr_src_wp := __common__( corrssnaddr_src_wp_pos > 0 );

corrssnaddr_ct := __common__( if(max((integer)corrssnaddr_src_ak, (integer)corrssnaddr_src_am, (integer)corrssnaddr_src_ar, (integer)corrssnaddr_src_ba, (integer)corrssnaddr_src_cg, (integer)corrssnaddr_src_co, (integer)corrssnaddr_src_cy, (integer)corrssnaddr_src_d, (integer)corrssnaddr_src_da, (integer)corrssnaddr_src_de, (integer)corrssnaddr_src_dl, (integer)corrssnaddr_src_ds, (integer)corrssnaddr_src_e1, (integer)corrssnaddr_src_e2, (integer)corrssnaddr_src_e3, (integer)corrssnaddr_src_e4, (integer)corrssnaddr_src_eb, (integer)corrssnaddr_src_em, (integer)corrssnaddr_src_en, (integer)corrssnaddr_src_eq, (integer)corrssnaddr_src_fe, (integer)corrssnaddr_src_ff, (integer)corrssnaddr_src_fr, (integer)corrssnaddr_src_l2, (integer)corrssnaddr_src_li, (integer)corrssnaddr_src_mw, (integer)corrssnaddr_src_nt, (integer)corrssnaddr_src_p, (integer)corrssnaddr_src_pl, (integer)corrssnaddr_src_sl, (integer)corrssnaddr_src_tn, (integer)corrssnaddr_src_ts, (integer)corrssnaddr_src_tu, (integer)corrssnaddr_src_v, (integer)corrssnaddr_src_vo, (integer)corrssnaddr_src_w, (integer)corrssnaddr_src_wp) = NULL, NULL, sum((integer)corrssnaddr_src_ak, (integer)corrssnaddr_src_am, (integer)corrssnaddr_src_ar, (integer)corrssnaddr_src_ba, (integer)corrssnaddr_src_cg, (integer)corrssnaddr_src_co, (integer)corrssnaddr_src_cy, (integer)corrssnaddr_src_d, (integer)corrssnaddr_src_da, (integer)corrssnaddr_src_de, (integer)corrssnaddr_src_dl, (integer)corrssnaddr_src_ds, (integer)corrssnaddr_src_e1, (integer)corrssnaddr_src_e2, (integer)corrssnaddr_src_e3, (integer)corrssnaddr_src_e4, (integer)corrssnaddr_src_eb, (integer)corrssnaddr_src_em, (integer)corrssnaddr_src_en, (integer)corrssnaddr_src_eq, (integer)corrssnaddr_src_fe, (integer)corrssnaddr_src_ff, (integer)corrssnaddr_src_fr, (integer)corrssnaddr_src_l2, (integer)corrssnaddr_src_li, (integer)corrssnaddr_src_mw, (integer)corrssnaddr_src_nt, (integer)corrssnaddr_src_p, (integer)corrssnaddr_src_pl, (integer)corrssnaddr_src_sl, (integer)corrssnaddr_src_tn, (integer)corrssnaddr_src_ts, (integer)corrssnaddr_src_tu, (integer)corrssnaddr_src_v, (integer)corrssnaddr_src_vo, (integer)corrssnaddr_src_w, (integer)corrssnaddr_src_wp)) );

nf_corrssnaddr := __common__( map(
    not(truedid)                 => NULL,
    ssnlength < '9' or not(addrpop)  => NULL,
                                    min(if(corrssnaddr_ct = NULL, -NULL, corrssnaddr_ct), 999)) );

nf_hh_collections_ct := __common__( if(not(truedid), NULL, min(if(hh_collections_ct = NULL, -NULL, hh_collections_ct), 999)) );

rv_l79_adls_per_addr_c6 := __common__( if(not(addrpop), NULL, min(if(adls_per_addr_c6 = NULL, -NULL, adls_per_addr_c6), 999)) );

nf_pct_rel_with_felony := __common__( map(
    not(truedid)  => NULL,
    rel_count = 0 => -1,
                     rel_felony_count / rel_count) );

dfsn_v01_w := __common__( map(
    nf_inq_communications_count = NULL  => 0,
    nf_inq_communications_count = -1    => 0,
    nf_inq_communications_count <= 0.5  => -0.120939247056328,
    nf_inq_communications_count <= 2.5  => 0.013824580872598,
    nf_inq_communications_count <= 4.5  => 0.113833954558074,
    nf_inq_communications_count <= 10.5 => 0.188914350342811,
    nf_inq_communications_count <= 13.5 => 0.283277404590311,
                                           0.519161187417717) );

dfsn_v02_w := __common__( map(
    rv_comb_age = NULL  => 0,
    rv_comb_age = -1    => 0,
    rv_comb_age <= 20.5 => 0.341927070560616,
    rv_comb_age <= 23.5 => 0.222669913967819,
    rv_comb_age <= 34.5 => 0.0644072630256285,
    rv_comb_age <= 55.5 => -0.0269389558899882,
    rv_comb_age <= 59.5 => -0.0347193968762689,
    rv_comb_age <= 61.5 => -0.097854674970287,
                           -0.280118297683729) );

dfsn_v03_w := __common__( map(
    nf_inq_communications_count24 = NULL => 0,
    nf_inq_communications_count24 = -1   => 0,
    nf_inq_communications_count24 <= 0.5 => -0.114862041723163,
                                            0.111349778736156) );

dfsn_v04_w := __common__( map(
    iv_estimated_income = NULL   => 0,
    iv_estimated_income = -1     => 0,
    iv_estimated_income <= 21500 => 0.286192549579454,
    iv_estimated_income <= 28500 => 0.139885178519898,
    iv_estimated_income <= 31500 => 0.095561721728072,
    iv_estimated_income <= 33500 => 0.0229769897129747,
    iv_estimated_income <= 39500 => -0.0179865077075365,
    iv_estimated_income <= 72500 => -0.0267838600094837,
                                    -0.116581470686456) );

dfsn_v05_w := __common__( map(
    nf_fp_varrisktype = NULL => 0,
    nf_fp_varrisktype = -1   => 0,
    nf_fp_varrisktype <= 3.5 => -0.0937153377590727,
    nf_fp_varrisktype <= 4.5 => -0.00139244412106899,
    nf_fp_varrisktype <= 5.5 => 0.0885803490161911,
                                0.138668155516833) );

dfsn_v06_w := __common__( map(
    nf_inq_prepaidcards_count = NULL => 0,
    nf_inq_prepaidcards_count = -1   => 0,
    nf_inq_prepaidcards_count <= 0.5 => -0.0968473078005727,
    nf_inq_prepaidcards_count <= 3.5 => 0.0825242565140036,
                                        0.14246060089523) );

dfsn_v07_w := __common__( map(
    rv_d32_criminal_count = NULL  => 0,
    rv_d32_criminal_count = -1    => 0,
    rv_d32_criminal_count <= 0.5  => -0.0855872146366595,
    rv_d32_criminal_count <= 2.5  => 0.0248485177869444,
    rv_d32_criminal_count <= 4.5  => 0.0445309991032342,
    rv_d32_criminal_count <= 5.5  => 0.115779522001004,
    rv_d32_criminal_count <= 14.5 => 0.148888940770266,
    rv_d32_criminal_count <= 17.5 => 0.186494268203561,
                                     0.366859798727611) );

dfsn_v08_w := __common__( map(
    rv_d32_felony_count = NULL => 0,
    rv_d32_felony_count = -1   => 0,
    rv_d32_felony_count <= 0.5 => -0.0923961925120505,
                                  0.0841231393326313) );

dfsn_v09_w := __common__( map(
    rv_d31_bk_disposed_hist_count = NULL => 0,
    rv_d31_bk_disposed_hist_count = -1   => 0,
    rv_d31_bk_disposed_hist_count <= 0.5 => 0.0772491397140181,
    rv_d31_bk_disposed_hist_count <= 1.5 => -0.0268647804549698,
                                            -0.182006405505902) );

dfsn_v10_w := __common__( map(
    nf_inq_perssn_count01 = NULL => 0,
    nf_inq_perssn_count01 = -1   => 0,
    nf_inq_perssn_count01 <= 0.5 => -0.0652410874326677,
    nf_inq_perssn_count01 <= 2.5 => 0.00220008071952398,
    nf_inq_perssn_count01 <= 3.5 => 0.0441835205242245,
    nf_inq_perssn_count01 <= 4.5 => 0.165716044386624,
    nf_inq_perssn_count01 <= 6.5 => 0.213673724126843,
                                    0.386768226113681) );

dfsn_v11_w := __common__( map(
    rv_d34_liens_unreleased_ct84 = NULL => 0,
    rv_d34_liens_unreleased_ct84 = -1   => 0,
    rv_d34_liens_unreleased_ct84 <= 0.5 => -0.0716702562307034,
    rv_d34_liens_unreleased_ct84 <= 4.5 => 0.0437776052569756,
                                           0.442184651610025) );

dfsn_v12_w := __common__( map(
    iv_src_voter_adl_count = NULL => 0,
    iv_src_voter_adl_count = -1   => 0,
    iv_src_voter_adl_count <= 0.5 => 0.133230281966619,
    iv_src_voter_adl_count <= 1.5 => 0.0861281105945558,
    iv_src_voter_adl_count <= 3.5 => 0.00627987977223763,
    iv_src_voter_adl_count <= 8.5 => -0.065641982201854,
                                     -0.269068472891486) );

dfsn_v13_w := __common__( map(
    rv_i61_inq_collection_count12 = NULL => 0,
    rv_i61_inq_collection_count12 = -1   => 0,
    rv_i61_inq_collection_count12 <= 0.5 => -0.0763669985752585,
    rv_i61_inq_collection_count12 <= 2.5 => 0.0524350395498471,
    rv_i61_inq_collection_count12 <= 4.5 => 0.111752376919518,
    rv_i61_inq_collection_count12 <= 8.5 => 0.215743923041256,
                                            0.381816929430099) );

dfsn_v14_w := __common__( map(
    nf_inq_ssnsperadl_count03 = NULL => 0,
    nf_inq_ssnsperadl_count03 = -1   => 0,
    nf_inq_ssnsperadl_count03 <= 0.5 => -0.0683989552015356,
    nf_inq_ssnsperadl_count03 <= 1.5 => 0.0356611245026666,
    nf_inq_ssnsperadl_count03 <= 2.5 => 0.159838636832672,
                                        0.568113521513891) );

dfsn_v15_w := __common__( map(
    nf_average_rel_age = NULL  => 0,
    nf_average_rel_age = -1    => 0.0911689114708802,
    nf_average_rel_age <= 37.5 => 0.0754105800619479,
    nf_average_rel_age <= 39.5 => 0.0437081400162166,
    nf_average_rel_age <= 41.5 => -0.0250745596902572,
    nf_average_rel_age <= 43.5 => -0.0600281036423066,
    nf_average_rel_age <= 44.5 => -0.0871856923429135,
                                  -0.116277269368372) );

dfsn_v16_w := __common__( map(
    nf_fp_curraddrcartheftindex = NULL   => 0,
    nf_fp_curraddrcartheftindex = -1     => 0.0306164338245784,
    nf_fp_curraddrcartheftindex <= 9.5   => -0.115679060337422,
    nf_fp_curraddrcartheftindex <= 12    => -0.0948541484114654,
    nf_fp_curraddrcartheftindex <= 67.5  => -0.048918846794415,
    nf_fp_curraddrcartheftindex <= 161.5 => -0.020570602073911,
    nf_fp_curraddrcartheftindex <= 188.5 => 0.055669034392553,
                                            0.188111271895551) );

dfsn_v17_w := __common__( map(
    rv_d33_eviction_count = NULL => 0,
    rv_d33_eviction_count = -1   => 0,
    rv_d33_eviction_count <= 0.5 => -0.0599413595759541,
    rv_d33_eviction_count <= 1.5 => 0.0110528314425574,
    rv_d33_eviction_count <= 6.5 => 0.0406708645441265,
                                    0.370442734656422) );

dfsn_v18_w := __common__( map(
    nf_inq_other_count24 = NULL => 0,
    nf_inq_other_count24 = -1   => 0,
    nf_inq_other_count24 <= 0.5 => -0.0781333588734658,
    nf_inq_other_count24 <= 2.5 => 0.00175580912686242,
    nf_inq_other_count24 <= 3.5 => 0.0641122659436843,
                                   0.11393565202217) );

dfsn_v19_w := __common__( map(
    nf_corrssnaddr = NULL => 0,
    nf_corrssnaddr = -1   => 0,
    nf_corrssnaddr <= 2.5 => 0.117747607183861,
    nf_corrssnaddr <= 3.5 => -0.0171597448983555,
    nf_corrssnaddr <= 4.5 => -0.0505905233874435,
                             -0.0628045947884248) );

dfsn_v20_w := __common__( map(
    nf_hh_collections_ct = NULL => 0,
    nf_hh_collections_ct = -1   => 0,
    nf_hh_collections_ct <= 0.5 => -0.101730986944587,
    nf_hh_collections_ct <= 2.5 => -0.0417547355364754,
    nf_hh_collections_ct <= 3.5 => 0.0534636600048081,
                                   0.0930667335671603) );

dfsn_v21_w := __common__( map(
    rv_l79_adls_per_addr_c6 = NULL  => 0,
    rv_l79_adls_per_addr_c6 = -1    => 0,
    rv_l79_adls_per_addr_c6 <= 0.5  => -0.0794644082327317,
    rv_l79_adls_per_addr_c6 <= 1.5  => 0.0137737460859711,
    rv_l79_adls_per_addr_c6 <= 3.5  => 0.0444637882565319,
    rv_l79_adls_per_addr_c6 <= 5.5  => 0.0733956756215566,
    rv_l79_adls_per_addr_c6 <= 10.5 => 0.114888636026319,
                                       0.189778010220284) );

dfsn_v22_w := __common__( map(
    nf_pct_rel_with_felony = NULL => 0,
    nf_pct_rel_with_felony = -1   => 0.0919500345633139,
    nf_pct_rel_with_felony <= 0   => -0.0629429728027544,
    nf_pct_rel_with_felony <= 0.3 => 0.0490233479604448,
                                     0.158739056061851) );

dfsn_lgt := __common__( 0.0278536121129033 +
    dfsn_v01_w +
    dfsn_v02_w +
    dfsn_v03_w +
    dfsn_v04_w +
    dfsn_v05_w +
    dfsn_v06_w +
    dfsn_v07_w +
    dfsn_v08_w +
    dfsn_v09_w +
    dfsn_v10_w +
    dfsn_v11_w +
    dfsn_v12_w +
    dfsn_v13_w +
    dfsn_v14_w +
    dfsn_v15_w +
    dfsn_v16_w +
    dfsn_v17_w +
    dfsn_v18_w +
    dfsn_v19_w +
    dfsn_v20_w +
    dfsn_v21_w +
    dfsn_v22_w );

fp1802_1_0 := __common__( round(max((real)300, min(999, if(600 - 100 * (dfsn_lgt - ln((36619 - 14158) / 14158)) / ln(2) = NULL, -NULL, 600 - 100 * (dfsn_lgt - ln((36619 - 14158) / 14158)) / ln(2))))) );

_ver_src_ds := __common__( Models.Common.findw_cpp(ver_sources, 'DS' , ',', '') > 0 );

_ver_src_de := __common__( Models.Common.findw_cpp(ver_sources, 'DE' , ',', '') > 0 );

_ver_src_eq := __common__( Models.Common.findw_cpp(ver_sources, 'EQ' , ',', '') > 0 );

_ver_src_en := __common__( Models.Common.findw_cpp(ver_sources, 'EN' , ',', '') > 0 );

_ver_src_tn := __common__( Models.Common.findw_cpp(ver_sources, 'TN' , ',', '') > 0 );

_ver_src_tu := __common__( Models.Common.findw_cpp(ver_sources, 'TU' , ',', '') > 0 );

_credit_source_cnt := __common__( if(max((integer)_ver_src_eq, (integer)_ver_src_en, (integer)_ver_src_tn, (integer)_ver_src_tu) = NULL, NULL, sum((integer)_ver_src_eq, (integer)_ver_src_en, (integer)_ver_src_tn, (integer)_ver_src_tu)) );

_ver_src_cnt := __common__( Models.Common.countw((string)(ver_sources), ' !$%&()*+,-./ );<^|') );

_bureauonly := __common__( _credit_source_cnt > 0 AND _credit_source_cnt = _ver_src_cnt AND (StringLib.StringToUpperCase(nap_type) = 'U' or (nap_summary in [0, 1, 2, 3, 4, 6])) );

_derog := __common__( felony_count > 0 OR (integer)addrs_prison_history > 0 OR attr_num_unrel_liens60 > 0 OR attr_eviction_count > 0 OR stl_inq_count > 0 OR inq_highriskcredit_count12 > 0 OR inq_collection_count12 >= 2 );

_deceased := __common__( rc_decsflag = '1' OR rc_ssndod != 0 OR _ver_src_ds OR _ver_src_de );

_ssnpriortodob := __common__( rc_ssndobflag = '1' OR rc_pwssndobflag = '1' );

_inputmiskeys := __common__( rc_ssnmiskeyflag or rc_addrmiskeyflag or (integer)add_input_house_number_match = 0 );

_multiplessns := __common__( ssns_per_adl >= 2 OR ssns_per_adl_c6 >= 1 OR invalid_ssns_per_adl >= 1 );

_hh_strikes := __common__( if((real)max((integer)hh_members_w_derog > 0, (integer)hh_criminals > 0, (integer)hh_payday_loan_users > 0) = NULL, NULL, (Real)sum((integer)hh_members_w_derog > 0, (integer)hh_criminals > 0, (integer)hh_payday_loan_users > 0)) );

stolenid := __common__( if(addrpop and (nas_summary in [4, 7, 9]) or fnamepop and lnamepop and addrpop and 1 <= nas_summary AND nas_summary <= 9 and inq_count03 > 0 and ssnlength = '9' or _deceased or _ssnpriortodob, 1, 0) );

manipulatedid := __common__( if(_inputmiskeys and (_multiplessns or lnames_per_adl_c6 > 1), 1, 0) );

manipulatedidpt2 := __common__( if(1 <= nas_summary AND nas_summary <= 9 and inq_count03 > 0 and ssnlength = '9', 1, 0) );

suspiciousactivity := __common__( if(_derog, 1, 0) );

vulnerablevictim := __common__( if(0 < inferred_age AND inferred_age <= 17 or inferred_age >= 70, 1, 0) );

friendlyfraud := __common__( if(hh_members_ct > 1 and (hh_payday_loan_users > 0 or _hh_strikes >= 2 or rel_felony_count >= 2), 1, 0) );

ver_src_ak := __common__( Models.Common.findw_cpp(ver_sources, 'AK' , ',', '') > 0 );

ver_src_am := __common__( Models.Common.findw_cpp(ver_sources, 'AM' , ',', '') > 0 );

ver_src_ar := __common__( Models.Common.findw_cpp(ver_sources, 'AR' , ',', '') > 0 );

ver_src_ba := __common__( Models.Common.findw_cpp(ver_sources, 'BA' , ',', '') > 0 );

ver_src_cg := __common__( Models.Common.findw_cpp(ver_sources, 'CG' , ',', '') > 0 );

ver_src_co := __common__( Models.Common.findw_cpp(ver_sources, 'CO' , ',', '') > 0 );

ver_src_cy := __common__( Models.Common.findw_cpp(ver_sources, 'CY' , ',', '') > 0 );

ver_src_da := __common__( Models.Common.findw_cpp(ver_sources, 'DA' , ',', '') > 0 );

ver_src_d := __common__( Models.Common.findw_cpp(ver_sources, 'D ' , ',', '') > 0 );

ver_src_dl := __common__( Models.Common.findw_cpp(ver_sources, 'DL' , ',', '') > 0 );

ver_src_ds := __common__( Models.Common.findw_cpp(ver_sources, 'DS' , ',', '') > 0 );

ver_src_de := __common__( Models.Common.findw_cpp(ver_sources, 'DE' , ',', '') > 0 );

ver_src_eb := __common__( Models.Common.findw_cpp(ver_sources, 'EB' , ',', '') > 0 );

ver_src_em := __common__( Models.Common.findw_cpp(ver_sources, 'EM' , ',', '') > 0 );

ver_src_e1 := __common__( Models.Common.findw_cpp(ver_sources, 'E1' , ',', '') > 0 );

ver_src_e2 := __common__( Models.Common.findw_cpp(ver_sources, 'E2' , ',', '') > 0 );

ver_src_e3 := __common__( Models.Common.findw_cpp(ver_sources, 'E3' , ',', '') > 0 );

ver_src_e4 := __common__( Models.Common.findw_cpp(ver_sources, 'E4' , ',', '') > 0 );

ver_src_en := __common__( Models.Common.findw_cpp(ver_sources, 'EN' , ',', '') > 0 );

ver_src_eq := __common__( Models.Common.findw_cpp(ver_sources, 'EQ' , ',', '') > 0 );

ver_src_fe := __common__( Models.Common.findw_cpp(ver_sources, 'FE' , ',', '') > 0 );

ver_src_ff := __common__( Models.Common.findw_cpp(ver_sources, 'FF' , ',', '') > 0 );

ver_src_fr := __common__( Models.Common.findw_cpp(ver_sources, 'FR' , ',', '') > 0 );

ver_src_l2 := __common__( Models.Common.findw_cpp(ver_sources, 'L2' , ',', '') > 0 );

ver_src_li := __common__( Models.Common.findw_cpp(ver_sources, 'LI' , ',', '') > 0 );

ver_src_mw := __common__( Models.Common.findw_cpp(ver_sources, 'MW' , ',', '') > 0 );

ver_src_nt := __common__( Models.Common.findw_cpp(ver_sources, 'NT' , ',', '') > 0 );

ver_src_p := __common__( Models.Common.findw_cpp(ver_sources, 'P ' , ',', '') > 0 );

ver_src_pl := __common__( Models.Common.findw_cpp(ver_sources, 'PL' , ',', '') > 0 );

ver_src_tn := __common__( Models.Common.findw_cpp(ver_sources, 'TN' , ',', '') > 0 );

ver_src_ts := __common__( Models.Common.findw_cpp(ver_sources, 'TS' , ',', '') > 0 );

ver_src_tu := __common__( Models.Common.findw_cpp(ver_sources, 'TU' , ',', '') > 0 );

ver_src_sl := __common__( Models.Common.findw_cpp(ver_sources, 'SL' , ',', '') > 0 );

ver_src_v := __common__( Models.Common.findw_cpp(ver_sources, 'V ' , ',', '') > 0 );

ver_src_vo := __common__( Models.Common.findw_cpp(ver_sources, 'VO' , ',', '') > 0 );

ver_src_w := __common__( Models.Common.findw_cpp(ver_sources, 'W ' , ',', '') > 0 );

ver_src_wp := __common__( Models.Common.findw_cpp(ver_sources, 'WP' , ',', '') > 0 );

src_bureau := __common__( (integer)ver_src_en +
    (integer)ver_src_eq +
    (integer)ver_src_tn +
    (integer)ver_src_ts );

src_behavioral := __common__( (integer)ver_src_cy +
    (integer)ver_src_pl +
    (integer)ver_src_sl +
    (integer)ver_src_wp );

src_inperson := __common__( (integer)ver_src_ak +
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
    (integer)ver_src_w );

syntheticid2 := __common__( map(
    not(truedid) or ver_sources = ' '                                      => 1,
    truedid and src_behavioral = 0 and src_inperson = 0 and src_bureau > 0 => 1,
    truedid and src_inperson = 0 and src_bureau = 0                        => 1,
                                                                              0) );

stolenc_fp1802_1_0 := __common__( if((Boolean)(Integer)stolenid, fp1802_1_0, 299) );

manip2c_fp1802_1_0 := __common__( if((boolean)(integer)manipulatedid or (boolean)(integer)manipulatedidpt2, fp1802_1_0, 299) );

synth2c_fp1802_1_0 := __common__( if((Boolean)(Integer)syntheticid2, fp1802_1_0, 299) );

suspactc_fp1802_1_0 := __common__( if((Boolean)(Integer)suspiciousactivity, fp1802_1_0, 299) );

vulnvicc_fp1802_1_0 := __common__( if((Boolean)(Integer)vulnerablevictim, fp1802_1_0, 299) );

friendlyc_fp1802_1_0 := __common__( if((Boolean)(Integer)friendlyfraud, fp1802_1_0, 299) );

custstolidindex := __common__( map(
    stolenc_fp1802_1_0 = 299                                => 1,
    300 <= stolenc_fp1802_1_0 AND stolenc_fp1802_1_0 < 605  => 9,
    605 <= stolenc_fp1802_1_0 AND stolenc_fp1802_1_0 < 650  => 8,
    650 <= stolenc_fp1802_1_0 AND stolenc_fp1802_1_0 < 675  => 7,
    675 <= stolenc_fp1802_1_0 AND stolenc_fp1802_1_0 < 705  => 6,
    700 <= stolenc_fp1802_1_0 AND stolenc_fp1802_1_0 < 725  => 5,
    725 <= stolenc_fp1802_1_0 AND stolenc_fp1802_1_0 < 755  => 4,
    755 <= stolenc_fp1802_1_0 AND stolenc_fp1802_1_0 < 790  => 3,
    790 <= stolenc_fp1802_1_0 AND stolenc_fp1802_1_0 <= 999 => 2,
                                                               99) );

custmanipidindex := __common__( map(
    manip2c_fp1802_1_0 = 299                                => 1,
    300 <= manip2c_fp1802_1_0 AND manip2c_fp1802_1_0 < 550  => 9,
    545 <= manip2c_fp1802_1_0 AND manip2c_fp1802_1_0 < 580  => 8,
    580 <= manip2c_fp1802_1_0 AND manip2c_fp1802_1_0 < 605  => 7,
    605 <= manip2c_fp1802_1_0 AND manip2c_fp1802_1_0 < 655  => 6,
    625 <= manip2c_fp1802_1_0 AND manip2c_fp1802_1_0 < 700  => 5,
    655 <= manip2c_fp1802_1_0 AND manip2c_fp1802_1_0 < 725  => 4,
    710 <= manip2c_fp1802_1_0 AND manip2c_fp1802_1_0 < 780  => 3,
    725 <= manip2c_fp1802_1_0 AND manip2c_fp1802_1_0 <= 999 => 2,
                                                               99) );

custsynthidindex := __common__( map(
    synth2c_fp1802_1_0 = 299                                => 1,
    300 <= synth2c_fp1802_1_0 AND synth2c_fp1802_1_0 < 660  => 9,
    660 <= synth2c_fp1802_1_0 AND synth2c_fp1802_1_0 < 685  => 8,
    685 <= synth2c_fp1802_1_0 AND synth2c_fp1802_1_0 < 710  => 7,
    710 <= synth2c_fp1802_1_0 AND synth2c_fp1802_1_0 < 735  => 6,
    735 <= synth2c_fp1802_1_0 AND synth2c_fp1802_1_0 < 750  => 5,
    750 <= synth2c_fp1802_1_0 AND synth2c_fp1802_1_0 < 775  => 4,
    775 <= synth2c_fp1802_1_0 AND synth2c_fp1802_1_0 < 800  => 3,
    800 <= synth2c_fp1802_1_0 AND synth2c_fp1802_1_0 <= 999 => 2,
                                                               99) );

custsuspactindex := __common__( map(
    suspactc_fp1802_1_0 = 299                                 => 1,
    300 <= suspactc_fp1802_1_0 AND suspactc_fp1802_1_0 < 615  => 9,
    615 <= suspactc_fp1802_1_0 AND suspactc_fp1802_1_0 < 660  => 8,
    660 <= suspactc_fp1802_1_0 AND suspactc_fp1802_1_0 < 690  => 7,
    690 <= suspactc_fp1802_1_0 AND suspactc_fp1802_1_0 < 715  => 6,
    715 <= suspactc_fp1802_1_0 AND suspactc_fp1802_1_0 < 740  => 5,
    740 <= suspactc_fp1802_1_0 AND suspactc_fp1802_1_0 < 765  => 4,
    765 <= suspactc_fp1802_1_0 AND suspactc_fp1802_1_0 < 795  => 3,
    795 <= suspactc_fp1802_1_0 AND suspactc_fp1802_1_0 <= 999 => 2,
                                                                 99) );

custvulnvicindex := __common__( map(
    vulnvicc_fp1802_1_0 = 299                                 => 1,
    300 <= vulnvicc_fp1802_1_0 AND vulnvicc_fp1802_1_0 < 720  => 9,
    720 <= vulnvicc_fp1802_1_0 AND vulnvicc_fp1802_1_0 < 740  => 8,
    740 <= vulnvicc_fp1802_1_0 AND vulnvicc_fp1802_1_0 < 760  => 7,
    760 <= vulnvicc_fp1802_1_0 AND vulnvicc_fp1802_1_0 < 770  => 6,
    770 <= vulnvicc_fp1802_1_0 AND vulnvicc_fp1802_1_0 < 820  => 5,
    820 <= vulnvicc_fp1802_1_0 AND vulnvicc_fp1802_1_0 < 840  => 4,
    840 <= vulnvicc_fp1802_1_0 AND vulnvicc_fp1802_1_0 < 865  => 3,
    865 <= vulnvicc_fp1802_1_0 AND vulnvicc_fp1802_1_0 <= 999 => 2,
                                                                 99) );

custfriendfrdindex := __common__( map(
    friendlyc_fp1802_1_0 = 299                                  => 1,
    300 <= friendlyc_fp1802_1_0 AND friendlyc_fp1802_1_0 < 615  => 9,
    615 <= friendlyc_fp1802_1_0 AND friendlyc_fp1802_1_0 < 660  => 8,
    660 <= friendlyc_fp1802_1_0 AND friendlyc_fp1802_1_0 < 690  => 7,
    690 <= friendlyc_fp1802_1_0 AND friendlyc_fp1802_1_0 < 715  => 6,
    715 <= friendlyc_fp1802_1_0 AND friendlyc_fp1802_1_0 < 740  => 5,
    740 <= friendlyc_fp1802_1_0 AND friendlyc_fp1802_1_0 < 765  => 4,
    765 <= friendlyc_fp1802_1_0 AND friendlyc_fp1802_1_0 < 795  => 3,
    795 <= friendlyc_fp1802_1_0 AND friendlyc_fp1802_1_0 <= 999 => 2,
                                                                   99) );




																																	 
//*************************************************************************************//
//     End Generated ECL Code
//*************************************************************************************//

	#if(FP_DEBUG)
		/* Model Input Variables */
								//		self.seq 															:= le.seq
                    self.sysdate                          := sysdate;
                    self.ver_src_cnt                      := ver_src_cnt;
                    self.ver_src_pop                      := ver_src_pop;
                    self.ver_src_fsrc                     := ver_src_fsrc;
                    self.ver_src_fsrc_fdate               := ver_src_fsrc_fdate;
                    self.ver_src_fsrc_fdate2              := ver_src_fsrc_fdate2;
                    self.yr_ver_src_fsrc_fdate            := yr_ver_src_fsrc_fdate;
                    self.mth_ver_src_fsrc_fdate           := mth_ver_src_fsrc_fdate;
                    self.ver_src_ak_pos                   := ver_src_ak_pos;
                    self._ver_src_fdate_ak                := _ver_src_fdate_ak;
                    self.ver_src_fdate_ak                 := ver_src_fdate_ak;
                    self._ver_src_ldate_ak                := _ver_src_ldate_ak;
                    self.ver_src_ldate_ak                 := ver_src_ldate_ak;
                    self.ver_src_cnt_ak                   := ver_src_cnt_ak;
                    self.ver_src_am_pos                   := ver_src_am_pos;
                    self._ver_src_fdate_am                := _ver_src_fdate_am;
                    self.ver_src_fdate_am                 := ver_src_fdate_am;
                    self._ver_src_ldate_am                := _ver_src_ldate_am;
                    self.ver_src_ldate_am                 := ver_src_ldate_am;
                    self.ver_src_cnt_am                   := ver_src_cnt_am;
                    self.ver_src_ar_pos                   := ver_src_ar_pos;
                    self._ver_src_fdate_ar                := _ver_src_fdate_ar;
                    self.ver_src_fdate_ar                 := ver_src_fdate_ar;
                    self._ver_src_ldate_ar                := _ver_src_ldate_ar;
                    self.ver_src_ldate_ar                 := ver_src_ldate_ar;
                    self.ver_src_cnt_ar                   := ver_src_cnt_ar;
                    self.ver_src_ba_pos                   := ver_src_ba_pos;
                    self._ver_src_fdate_ba                := _ver_src_fdate_ba;
                    self.ver_src_fdate_ba                 := ver_src_fdate_ba;
                    self._ver_src_ldate_ba                := _ver_src_ldate_ba;
                    self.ver_src_ldate_ba                 := ver_src_ldate_ba;
                    self.ver_src_cnt_ba                   := ver_src_cnt_ba;
                    self.ver_src_cg_pos                   := ver_src_cg_pos;
                    self._ver_src_fdate_cg                := _ver_src_fdate_cg;
                    self.ver_src_fdate_cg                 := ver_src_fdate_cg;
                    self._ver_src_ldate_cg                := _ver_src_ldate_cg;
                    self.ver_src_ldate_cg                 := ver_src_ldate_cg;
                    self.ver_src_cnt_cg                   := ver_src_cnt_cg;
                    self.ver_src_co_pos                   := ver_src_co_pos;
                    self._ver_src_fdate_co                := _ver_src_fdate_co;
                    self.ver_src_fdate_co                 := ver_src_fdate_co;
                    self._ver_src_ldate_co                := _ver_src_ldate_co;
                    self.ver_src_ldate_co                 := ver_src_ldate_co;
                    self.ver_src_cnt_co                   := ver_src_cnt_co;
                    self.ver_src_cy_pos                   := ver_src_cy_pos;
                    self._ver_src_fdate_cy                := _ver_src_fdate_cy;
                    self.ver_src_fdate_cy                 := ver_src_fdate_cy;
                    self._ver_src_ldate_cy                := _ver_src_ldate_cy;
                    self.ver_src_ldate_cy                 := ver_src_ldate_cy;
                    self.ver_src_cnt_cy                   := ver_src_cnt_cy;
                    self.ver_src_da_pos                   := ver_src_da_pos;
                    self._ver_src_fdate_da                := _ver_src_fdate_da;
                    self.ver_src_fdate_da                 := ver_src_fdate_da;
                    self._ver_src_ldate_da                := _ver_src_ldate_da;
                    self.ver_src_ldate_da                 := ver_src_ldate_da;
                    self.ver_src_cnt_da                   := ver_src_cnt_da;
                    self.ver_src_d_pos                    := ver_src_d_pos;
                    self._ver_src_fdate_d                 := _ver_src_fdate_d;
                    self.ver_src_fdate_d                  := ver_src_fdate_d;
                    self._ver_src_ldate_d                 := _ver_src_ldate_d;
                    self.ver_src_ldate_d                  := ver_src_ldate_d;
                    self.ver_src_cnt_d                    := ver_src_cnt_d;
                    self.ver_src_dl_pos                   := ver_src_dl_pos;
                    self._ver_src_fdate_dl                := _ver_src_fdate_dl;
                    self.ver_src_fdate_dl                 := ver_src_fdate_dl;
                    self._ver_src_ldate_dl                := _ver_src_ldate_dl;
                    self.ver_src_ldate_dl                 := ver_src_ldate_dl;
                    self.ver_src_cnt_dl                   := ver_src_cnt_dl;
                    self.ver_src_ds_pos                   := ver_src_ds_pos;
                    self._ver_src_fdate_ds                := _ver_src_fdate_ds;
                    self.ver_src_fdate_ds                 := ver_src_fdate_ds;
                    self._ver_src_ldate_ds                := _ver_src_ldate_ds;
                    self.ver_src_ldate_ds                 := ver_src_ldate_ds;
                    self.ver_src_cnt_ds                   := ver_src_cnt_ds;
                    self.ver_src_de_pos                   := ver_src_de_pos;
                    self._ver_src_fdate_de                := _ver_src_fdate_de;
                    self.ver_src_fdate_de                 := ver_src_fdate_de;
                    self._ver_src_ldate_de                := _ver_src_ldate_de;
                    self.ver_src_ldate_de                 := ver_src_ldate_de;
                    self.ver_src_cnt_de                   := ver_src_cnt_de;
                    self.ver_src_eb_pos                   := ver_src_eb_pos;
                    self._ver_src_fdate_eb                := _ver_src_fdate_eb;
                    self.ver_src_fdate_eb                 := ver_src_fdate_eb;
                    self._ver_src_ldate_eb                := _ver_src_ldate_eb;
                    self.ver_src_ldate_eb                 := ver_src_ldate_eb;
                    self.ver_src_cnt_eb                   := ver_src_cnt_eb;
                    self.ver_src_em_pos                   := ver_src_em_pos;
                    self._ver_src_fdate_em                := _ver_src_fdate_em;
                    self.ver_src_fdate_em                 := ver_src_fdate_em;
                    self._ver_src_ldate_em                := _ver_src_ldate_em;
                    self.ver_src_ldate_em                 := ver_src_ldate_em;
                    self.ver_src_cnt_em                   := ver_src_cnt_em;
                    self.ver_src_e1_pos                   := ver_src_e1_pos;
                    self._ver_src_fdate_e1                := _ver_src_fdate_e1;
                    self.ver_src_fdate_e1                 := ver_src_fdate_e1;
                    self._ver_src_ldate_e1                := _ver_src_ldate_e1;
                    self.ver_src_ldate_e1                 := ver_src_ldate_e1;
                    self.ver_src_cnt_e1                   := ver_src_cnt_e1;
                    self.ver_src_e2_pos                   := ver_src_e2_pos;
                    self._ver_src_fdate_e2                := _ver_src_fdate_e2;
                    self.ver_src_fdate_e2                 := ver_src_fdate_e2;
                    self._ver_src_ldate_e2                := _ver_src_ldate_e2;
                    self.ver_src_ldate_e2                 := ver_src_ldate_e2;
                    self.ver_src_cnt_e2                   := ver_src_cnt_e2;
                    self.ver_src_e3_pos                   := ver_src_e3_pos;
                    self._ver_src_fdate_e3                := _ver_src_fdate_e3;
                    self.ver_src_fdate_e3                 := ver_src_fdate_e3;
                    self._ver_src_ldate_e3                := _ver_src_ldate_e3;
                    self.ver_src_ldate_e3                 := ver_src_ldate_e3;
                    self.ver_src_cnt_e3                   := ver_src_cnt_e3;
                    self.ver_src_e4_pos                   := ver_src_e4_pos;
                    self._ver_src_fdate_e4                := _ver_src_fdate_e4;
                    self.ver_src_fdate_e4                 := ver_src_fdate_e4;
                    self._ver_src_ldate_e4                := _ver_src_ldate_e4;
                    self.ver_src_ldate_e4                 := ver_src_ldate_e4;
                    self.ver_src_cnt_e4                   := ver_src_cnt_e4;
                    self.ver_src_en_pos                   := ver_src_en_pos;
                    self._ver_src_fdate_en                := _ver_src_fdate_en;
                    self.ver_src_fdate_en                 := ver_src_fdate_en;
                    self._ver_src_ldate_en                := _ver_src_ldate_en;
                    self.ver_src_ldate_en                 := ver_src_ldate_en;
                    self.ver_src_cnt_en                   := ver_src_cnt_en;
                    self.ver_src_eq_pos                   := ver_src_eq_pos;
                    self._ver_src_fdate_eq                := _ver_src_fdate_eq;
                    self.ver_src_fdate_eq                 := ver_src_fdate_eq;
                    self._ver_src_ldate_eq                := _ver_src_ldate_eq;
                    self.ver_src_ldate_eq                 := ver_src_ldate_eq;
                    self.ver_src_cnt_eq                   := ver_src_cnt_eq;
                    self.ver_src_fe_pos                   := ver_src_fe_pos;
                    self._ver_src_fdate_fe                := _ver_src_fdate_fe;
                    self.ver_src_fdate_fe                 := ver_src_fdate_fe;
                    self._ver_src_ldate_fe                := _ver_src_ldate_fe;
                    self.ver_src_ldate_fe                 := ver_src_ldate_fe;
                    self.ver_src_cnt_fe                   := ver_src_cnt_fe;
                    self.ver_src_ff_pos                   := ver_src_ff_pos;
                    self._ver_src_fdate_ff                := _ver_src_fdate_ff;
                    self.ver_src_fdate_ff                 := ver_src_fdate_ff;
                    self._ver_src_ldate_ff                := _ver_src_ldate_ff;
                    self.ver_src_ldate_ff                 := ver_src_ldate_ff;
                    self.ver_src_cnt_ff                   := ver_src_cnt_ff;
                    self.ver_src_fr_pos                   := ver_src_fr_pos;
                    self._ver_src_fdate_fr                := _ver_src_fdate_fr;
                    self.ver_src_fdate_fr                 := ver_src_fdate_fr;
                    self._ver_src_ldate_fr                := _ver_src_ldate_fr;
                    self.ver_src_ldate_fr                 := ver_src_ldate_fr;
                    self.ver_src_cnt_fr                   := ver_src_cnt_fr;
                    self.ver_src_l2_pos                   := ver_src_l2_pos;
                    self._ver_src_fdate_l2                := _ver_src_fdate_l2;
                    self.ver_src_fdate_l2                 := ver_src_fdate_l2;
                    self._ver_src_ldate_l2                := _ver_src_ldate_l2;
                    self.ver_src_ldate_l2                 := ver_src_ldate_l2;
                    self.ver_src_cnt_l2                   := ver_src_cnt_l2;
                    self.ver_src_li_pos                   := ver_src_li_pos;
                    self._ver_src_fdate_li                := _ver_src_fdate_li;
                    self.ver_src_fdate_li                 := ver_src_fdate_li;
                    self._ver_src_ldate_li                := _ver_src_ldate_li;
                    self.ver_src_ldate_li                 := ver_src_ldate_li;
                    self.ver_src_cnt_li                   := ver_src_cnt_li;
                    self.ver_src_mw_pos                   := ver_src_mw_pos;
                    self._ver_src_fdate_mw                := _ver_src_fdate_mw;
                    self.ver_src_fdate_mw                 := ver_src_fdate_mw;
                    self._ver_src_ldate_mw                := _ver_src_ldate_mw;
                    self.ver_src_ldate_mw                 := ver_src_ldate_mw;
                    self.ver_src_cnt_mw                   := ver_src_cnt_mw;
                    self.ver_src_nt_pos                   := ver_src_nt_pos;
                    self._ver_src_fdate_nt                := _ver_src_fdate_nt;
                    self.ver_src_fdate_nt                 := ver_src_fdate_nt;
                    self._ver_src_ldate_nt                := _ver_src_ldate_nt;
                    self.ver_src_ldate_nt                 := ver_src_ldate_nt;
                    self.ver_src_cnt_nt                   := ver_src_cnt_nt;
                    self.ver_src_p_pos                    := ver_src_p_pos;
                    self._ver_src_fdate_p                 := _ver_src_fdate_p;
                    self.ver_src_fdate_p                  := ver_src_fdate_p;
                    self._ver_src_ldate_p                 := _ver_src_ldate_p;
                    self.ver_src_ldate_p                  := ver_src_ldate_p;
                    self.ver_src_cnt_p                    := ver_src_cnt_p;
                    self.ver_src_pl_pos                   := ver_src_pl_pos;
                    self._ver_src_fdate_pl                := _ver_src_fdate_pl;
                    self.ver_src_fdate_pl                 := ver_src_fdate_pl;
                    self._ver_src_ldate_pl                := _ver_src_ldate_pl;
                    self.ver_src_ldate_pl                 := ver_src_ldate_pl;
                    self.ver_src_cnt_pl                   := ver_src_cnt_pl;
                    self.ver_src_tn_pos                   := ver_src_tn_pos;
                    self._ver_src_fdate_tn                := _ver_src_fdate_tn;
                    self.ver_src_fdate_tn                 := ver_src_fdate_tn;
                    self._ver_src_ldate_tn                := _ver_src_ldate_tn;
                    self.ver_src_ldate_tn                 := ver_src_ldate_tn;
                    self.ver_src_cnt_tn                   := ver_src_cnt_tn;
                    self.ver_src_ts_pos                   := ver_src_ts_pos;
                    self._ver_src_fdate_ts                := _ver_src_fdate_ts;
                    self.ver_src_fdate_ts                 := ver_src_fdate_ts;
                    self._ver_src_ldate_ts                := _ver_src_ldate_ts;
                    self.ver_src_ldate_ts                 := ver_src_ldate_ts;
                    self.ver_src_cnt_ts                   := ver_src_cnt_ts;
                    self.ver_src_tu_pos                   := ver_src_tu_pos;
                    self._ver_src_fdate_tu                := _ver_src_fdate_tu;
                    self.ver_src_fdate_tu                 := ver_src_fdate_tu;
                    self._ver_src_ldate_tu                := _ver_src_ldate_tu;
                    self.ver_src_ldate_tu                 := ver_src_ldate_tu;
                    self.ver_src_cnt_tu                   := ver_src_cnt_tu;
                    self.ver_src_sl_pos                   := ver_src_sl_pos;
                    self._ver_src_fdate_sl                := _ver_src_fdate_sl;
                    self.ver_src_fdate_sl                 := ver_src_fdate_sl;
                    self._ver_src_ldate_sl                := _ver_src_ldate_sl;
                    self.ver_src_ldate_sl                 := ver_src_ldate_sl;
                    self.ver_src_cnt_sl                   := ver_src_cnt_sl;
                    self.ver_src_v_pos                    := ver_src_v_pos;
                    self._ver_src_fdate_v                 := _ver_src_fdate_v;
                    self.ver_src_fdate_v                  := ver_src_fdate_v;
                    self._ver_src_ldate_v                 := _ver_src_ldate_v;
                    self.ver_src_ldate_v                  := ver_src_ldate_v;
                    self.ver_src_cnt_v                    := ver_src_cnt_v;
                    self.ver_src_vo_pos                   := ver_src_vo_pos;
                    self._ver_src_fdate_vo                := _ver_src_fdate_vo;
                    self.ver_src_fdate_vo                 := ver_src_fdate_vo;
                    self._ver_src_ldate_vo                := _ver_src_ldate_vo;
                    self.ver_src_ldate_vo                 := ver_src_ldate_vo;
                    self.ver_src_cnt_vo                   := ver_src_cnt_vo;
                    self.ver_src_w_pos                    := ver_src_w_pos;
                    self._ver_src_fdate_w                 := _ver_src_fdate_w;
                    self.ver_src_fdate_w                  := ver_src_fdate_w;
                    self._ver_src_ldate_w                 := _ver_src_ldate_w;
                    self.ver_src_ldate_w                  := ver_src_ldate_w;
                    self.ver_src_cnt_w                    := ver_src_cnt_w;
                    self.ver_src_wp_pos                   := ver_src_wp_pos;
                    self._ver_src_fdate_wp                := _ver_src_fdate_wp;
                    self.ver_src_fdate_wp                 := ver_src_fdate_wp;
                    self._ver_src_ldate_wp                := _ver_src_ldate_wp;
                    self.ver_src_ldate_wp                 := ver_src_ldate_wp;
                    self.ver_src_cnt_wp                   := ver_src_cnt_wp;
                    self.ver_src_rcnt                     := ver_src_rcnt;
                    self.ver_fname_src_cnt                := ver_fname_src_cnt;
                    self.ver_fname_src_pop                := ver_fname_src_pop;
                    self.ver_fname_src_rcnt               := ver_fname_src_rcnt;
                    self.ver_fname_src_fsrc               := ver_fname_src_fsrc;
                    self.ver_fname_src_ak_pos             := ver_fname_src_ak_pos;
                    self.ver_fname_src_ak                 := ver_fname_src_ak;
                    self.ver_fname_src_am_pos             := ver_fname_src_am_pos;
                    self.ver_fname_src_am                 := ver_fname_src_am;
                    self.ver_fname_src_ar_pos             := ver_fname_src_ar_pos;
                    self.ver_fname_src_ar                 := ver_fname_src_ar;
                    self.ver_fname_src_ba_pos             := ver_fname_src_ba_pos;
                    self.ver_fname_src_ba                 := ver_fname_src_ba;
                    self.ver_fname_src_cg_pos             := ver_fname_src_cg_pos;
                    self.ver_fname_src_cg                 := ver_fname_src_cg;
                    self.ver_fname_src_co_pos             := ver_fname_src_co_pos;
                    self.ver_fname_src_co                 := ver_fname_src_co;
                    self.ver_fname_src_cy_pos             := ver_fname_src_cy_pos;
                    self.ver_fname_src_cy                 := ver_fname_src_cy;
                    self.ver_fname_src_da_pos             := ver_fname_src_da_pos;
                    self.ver_fname_src_da                 := ver_fname_src_da;
                    self.ver_fname_src_d_pos              := ver_fname_src_d_pos;
                    self.ver_fname_src_d                  := ver_fname_src_d;
                    self.ver_fname_src_dl_pos             := ver_fname_src_dl_pos;
                    self.ver_fname_src_dl                 := ver_fname_src_dl;
                    self.ver_fname_src_ds_pos             := ver_fname_src_ds_pos;
                    self.ver_fname_src_ds                 := ver_fname_src_ds;
                    self.ver_fname_src_de_pos             := ver_fname_src_de_pos;
                    self.ver_fname_src_de                 := ver_fname_src_de;
                    self.ver_fname_src_eb_pos             := ver_fname_src_eb_pos;
                    self.ver_fname_src_eb                 := ver_fname_src_eb;
                    self.ver_fname_src_em_pos             := ver_fname_src_em_pos;
                    self.ver_fname_src_em                 := ver_fname_src_em;
                    self.ver_fname_src_e1_pos             := ver_fname_src_e1_pos;
                    self.ver_fname_src_e1                 := ver_fname_src_e1;
                    self.ver_fname_src_e2_pos             := ver_fname_src_e2_pos;
                    self.ver_fname_src_e2                 := ver_fname_src_e2;
                    self.ver_fname_src_e3_pos             := ver_fname_src_e3_pos;
                    self.ver_fname_src_e3                 := ver_fname_src_e3;
                    self.ver_fname_src_e4_pos             := ver_fname_src_e4_pos;
                    self.ver_fname_src_e4                 := ver_fname_src_e4;
                    self.ver_fname_src_en_pos             := ver_fname_src_en_pos;
                    self.ver_fname_src_en                 := ver_fname_src_en;
                    self.ver_fname_src_eq_pos             := ver_fname_src_eq_pos;
                    self.ver_fname_src_eq                 := ver_fname_src_eq;
                    self.ver_fname_src_fe_pos             := ver_fname_src_fe_pos;
                    self.ver_fname_src_fe                 := ver_fname_src_fe;
                    self.ver_fname_src_ff_pos             := ver_fname_src_ff_pos;
                    self.ver_fname_src_ff                 := ver_fname_src_ff;
                    self.ver_fname_src_fr_pos             := ver_fname_src_fr_pos;
                    self.ver_fname_src_fr                 := ver_fname_src_fr;
                    self.ver_fname_src_l2_pos             := ver_fname_src_l2_pos;
                    self.ver_fname_src_l2                 := ver_fname_src_l2;
                    self.ver_fname_src_li_pos             := ver_fname_src_li_pos;
                    self.ver_fname_src_li                 := ver_fname_src_li;
                    self.ver_fname_src_mw_pos             := ver_fname_src_mw_pos;
                    self.ver_fname_src_mw                 := ver_fname_src_mw;
                    self.ver_fname_src_nt_pos             := ver_fname_src_nt_pos;
                    self.ver_fname_src_nt                 := ver_fname_src_nt;
                    self.ver_fname_src_p_pos              := ver_fname_src_p_pos;
                    self.ver_fname_src_p                  := ver_fname_src_p;
                    self.ver_fname_src_pl_pos             := ver_fname_src_pl_pos;
                    self.ver_fname_src_pl                 := ver_fname_src_pl;
                    self.ver_fname_src_tn_pos             := ver_fname_src_tn_pos;
                    self.ver_fname_src_tn                 := ver_fname_src_tn;
                    self.ver_fname_src_ts_pos             := ver_fname_src_ts_pos;
                    self.ver_fname_src_ts                 := ver_fname_src_ts;
                    self.ver_fname_src_tu_pos             := ver_fname_src_tu_pos;
                    self.ver_fname_src_tu                 := ver_fname_src_tu;
                    self.ver_fname_src_sl_pos             := ver_fname_src_sl_pos;
                    self.ver_fname_src_sl                 := ver_fname_src_sl;
                    self.ver_fname_src_v_pos              := ver_fname_src_v_pos;
                    self.ver_fname_src_v                  := ver_fname_src_v;
                    self.ver_fname_src_vo_pos             := ver_fname_src_vo_pos;
                    self.ver_fname_src_vo                 := ver_fname_src_vo;
                    self.ver_fname_src_w_pos              := ver_fname_src_w_pos;
                    self.ver_fname_src_w                  := ver_fname_src_w;
                    self.ver_fname_src_wp_pos             := ver_fname_src_wp_pos;
                    self.ver_fname_src_wp                 := ver_fname_src_wp;
                    self.ver_lname_src_cnt                := ver_lname_src_cnt;
                    self.ver_lname_src_pop                := ver_lname_src_pop;
                    self.ver_lname_src_rcnt               := ver_lname_src_rcnt;
                    self.ver_lname_src_fsrc               := ver_lname_src_fsrc;
                    self.ver_lname_src_ak_pos             := ver_lname_src_ak_pos;
                    self.ver_lname_src_ak                 := ver_lname_src_ak;
                    self.ver_lname_src_am_pos             := ver_lname_src_am_pos;
                    self.ver_lname_src_am                 := ver_lname_src_am;
                    self.ver_lname_src_ar_pos             := ver_lname_src_ar_pos;
                    self.ver_lname_src_ar                 := ver_lname_src_ar;
                    self.ver_lname_src_ba_pos             := ver_lname_src_ba_pos;
                    self.ver_lname_src_ba                 := ver_lname_src_ba;
                    self.ver_lname_src_cg_pos             := ver_lname_src_cg_pos;
                    self.ver_lname_src_cg                 := ver_lname_src_cg;
                    self.ver_lname_src_co_pos             := ver_lname_src_co_pos;
                    self.ver_lname_src_co                 := ver_lname_src_co;
                    self.ver_lname_src_cy_pos             := ver_lname_src_cy_pos;
                    self.ver_lname_src_cy                 := ver_lname_src_cy;
                    self.ver_lname_src_da_pos             := ver_lname_src_da_pos;
                    self.ver_lname_src_da                 := ver_lname_src_da;
                    self.ver_lname_src_d_pos              := ver_lname_src_d_pos;
                    self.ver_lname_src_d                  := ver_lname_src_d;
                    self.ver_lname_src_dl_pos             := ver_lname_src_dl_pos;
                    self.ver_lname_src_dl                 := ver_lname_src_dl;
                    self.ver_lname_src_ds_pos             := ver_lname_src_ds_pos;
                    self.ver_lname_src_ds                 := ver_lname_src_ds;
                    self.ver_lname_src_de_pos             := ver_lname_src_de_pos;
                    self.ver_lname_src_de                 := ver_lname_src_de;
                    self.ver_lname_src_eb_pos             := ver_lname_src_eb_pos;
                    self.ver_lname_src_eb                 := ver_lname_src_eb;
                    self.ver_lname_src_em_pos             := ver_lname_src_em_pos;
                    self.ver_lname_src_em                 := ver_lname_src_em;
                    self.ver_lname_src_e1_pos             := ver_lname_src_e1_pos;
                    self.ver_lname_src_e1                 := ver_lname_src_e1;
                    self.ver_lname_src_e2_pos             := ver_lname_src_e2_pos;
                    self.ver_lname_src_e2                 := ver_lname_src_e2;
                    self.ver_lname_src_e3_pos             := ver_lname_src_e3_pos;
                    self.ver_lname_src_e3                 := ver_lname_src_e3;
                    self.ver_lname_src_e4_pos             := ver_lname_src_e4_pos;
                    self.ver_lname_src_e4                 := ver_lname_src_e4;
                    self.ver_lname_src_en_pos             := ver_lname_src_en_pos;
                    self.ver_lname_src_en                 := ver_lname_src_en;
                    self.ver_lname_src_eq_pos             := ver_lname_src_eq_pos;
                    self.ver_lname_src_eq                 := ver_lname_src_eq;
                    self.ver_lname_src_fe_pos             := ver_lname_src_fe_pos;
                    self.ver_lname_src_fe                 := ver_lname_src_fe;
                    self.ver_lname_src_ff_pos             := ver_lname_src_ff_pos;
                    self.ver_lname_src_ff                 := ver_lname_src_ff;
                    self.ver_lname_src_fr_pos             := ver_lname_src_fr_pos;
                    self.ver_lname_src_fr                 := ver_lname_src_fr;
                    self.ver_lname_src_l2_pos             := ver_lname_src_l2_pos;
                    self.ver_lname_src_l2                 := ver_lname_src_l2;
                    self.ver_lname_src_li_pos             := ver_lname_src_li_pos;
                    self.ver_lname_src_li                 := ver_lname_src_li;
                    self.ver_lname_src_mw_pos             := ver_lname_src_mw_pos;
                    self.ver_lname_src_mw                 := ver_lname_src_mw;
                    self.ver_lname_src_nt_pos             := ver_lname_src_nt_pos;
                    self.ver_lname_src_nt                 := ver_lname_src_nt;
                    self.ver_lname_src_p_pos              := ver_lname_src_p_pos;
                    self.ver_lname_src_p                  := ver_lname_src_p;
                    self.ver_lname_src_pl_pos             := ver_lname_src_pl_pos;
                    self.ver_lname_src_pl                 := ver_lname_src_pl;
                    self.ver_lname_src_tn_pos             := ver_lname_src_tn_pos;
                    self.ver_lname_src_tn                 := ver_lname_src_tn;
                    self.ver_lname_src_ts_pos             := ver_lname_src_ts_pos;
                    self.ver_lname_src_ts                 := ver_lname_src_ts;
                    self.ver_lname_src_tu_pos             := ver_lname_src_tu_pos;
                    self.ver_lname_src_tu                 := ver_lname_src_tu;
                    self.ver_lname_src_sl_pos             := ver_lname_src_sl_pos;
                    self.ver_lname_src_sl                 := ver_lname_src_sl;
                    self.ver_lname_src_v_pos              := ver_lname_src_v_pos;
                    self.ver_lname_src_v                  := ver_lname_src_v;
                    self.ver_lname_src_vo_pos             := ver_lname_src_vo_pos;
                    self.ver_lname_src_vo                 := ver_lname_src_vo;
                    self.ver_lname_src_w_pos              := ver_lname_src_w_pos;
                    self.ver_lname_src_w                  := ver_lname_src_w;
                    self.ver_lname_src_wp_pos             := ver_lname_src_wp_pos;
                    self.ver_lname_src_wp                 := ver_lname_src_wp;
                    self.ver_addr_src_cnt                 := ver_addr_src_cnt;
                    self.ver_addr_src_pop                 := ver_addr_src_pop;
                    self.ver_addr_src_rcnt                := ver_addr_src_rcnt;
                    self.ver_addr_src_fsrc                := ver_addr_src_fsrc;
                    self.ver_addr_src_ak_pos              := ver_addr_src_ak_pos;
                    self.ver_addr_src_ak                  := ver_addr_src_ak;
                    self.ver_addr_src_am_pos              := ver_addr_src_am_pos;
                    self.ver_addr_src_am                  := ver_addr_src_am;
                    self.ver_addr_src_ar_pos              := ver_addr_src_ar_pos;
                    self.ver_addr_src_ar                  := ver_addr_src_ar;
                    self.ver_addr_src_ba_pos              := ver_addr_src_ba_pos;
                    self.ver_addr_src_ba                  := ver_addr_src_ba;
                    self.ver_addr_src_cg_pos              := ver_addr_src_cg_pos;
                    self.ver_addr_src_cg                  := ver_addr_src_cg;
                    self.ver_addr_src_co_pos              := ver_addr_src_co_pos;
                    self.ver_addr_src_co                  := ver_addr_src_co;
                    self.ver_addr_src_cy_pos              := ver_addr_src_cy_pos;
                    self.ver_addr_src_cy                  := ver_addr_src_cy;
                    self.ver_addr_src_da_pos              := ver_addr_src_da_pos;
                    self.ver_addr_src_da                  := ver_addr_src_da;
                    self.ver_addr_src_d_pos               := ver_addr_src_d_pos;
                    self.ver_addr_src_d                   := ver_addr_src_d;
                    self.ver_addr_src_dl_pos              := ver_addr_src_dl_pos;
                    self.ver_addr_src_dl                  := ver_addr_src_dl;
                    self.ver_addr_src_ds_pos              := ver_addr_src_ds_pos;
                    self.ver_addr_src_ds                  := ver_addr_src_ds;
                    self.ver_addr_src_de_pos              := ver_addr_src_de_pos;
                    self.ver_addr_src_de                  := ver_addr_src_de;
                    self.ver_addr_src_eb_pos              := ver_addr_src_eb_pos;
                    self.ver_addr_src_eb                  := ver_addr_src_eb;
                    self.ver_addr_src_em_pos              := ver_addr_src_em_pos;
                    self.ver_addr_src_em                  := ver_addr_src_em;
                    self.ver_addr_src_e1_pos              := ver_addr_src_e1_pos;
                    self.ver_addr_src_e1                  := ver_addr_src_e1;
                    self.ver_addr_src_e2_pos              := ver_addr_src_e2_pos;
                    self.ver_addr_src_e2                  := ver_addr_src_e2;
                    self.ver_addr_src_e3_pos              := ver_addr_src_e3_pos;
                    self.ver_addr_src_e3                  := ver_addr_src_e3;
                    self.ver_addr_src_e4_pos              := ver_addr_src_e4_pos;
                    self.ver_addr_src_e4                  := ver_addr_src_e4;
                    self.ver_addr_src_en_pos              := ver_addr_src_en_pos;
                    self.ver_addr_src_en                  := ver_addr_src_en;
                    self.ver_addr_src_eq_pos              := ver_addr_src_eq_pos;
                    self.ver_addr_src_eq                  := ver_addr_src_eq;
                    self.ver_addr_src_fe_pos              := ver_addr_src_fe_pos;
                    self.ver_addr_src_fe                  := ver_addr_src_fe;
                    self.ver_addr_src_ff_pos              := ver_addr_src_ff_pos;
                    self.ver_addr_src_ff                  := ver_addr_src_ff;
                    self.ver_addr_src_fr_pos              := ver_addr_src_fr_pos;
                    self.ver_addr_src_fr                  := ver_addr_src_fr;
                    self.ver_addr_src_l2_pos              := ver_addr_src_l2_pos;
                    self.ver_addr_src_l2                  := ver_addr_src_l2;
                    self.ver_addr_src_li_pos              := ver_addr_src_li_pos;
                    self.ver_addr_src_li                  := ver_addr_src_li;
                    self.ver_addr_src_mw_pos              := ver_addr_src_mw_pos;
                    self.ver_addr_src_mw                  := ver_addr_src_mw;
                    self.ver_addr_src_nt_pos              := ver_addr_src_nt_pos;
                    self.ver_addr_src_nt                  := ver_addr_src_nt;
                    self.ver_addr_src_p_pos               := ver_addr_src_p_pos;
                    self.ver_addr_src_p                   := ver_addr_src_p;
                    self.ver_addr_src_pl_pos              := ver_addr_src_pl_pos;
                    self.ver_addr_src_pl                  := ver_addr_src_pl;
                    self.ver_addr_src_tn_pos              := ver_addr_src_tn_pos;
                    self.ver_addr_src_tn                  := ver_addr_src_tn;
                    self.ver_addr_src_ts_pos              := ver_addr_src_ts_pos;
                    self.ver_addr_src_ts                  := ver_addr_src_ts;
                    self.ver_addr_src_tu_pos              := ver_addr_src_tu_pos;
                    self.ver_addr_src_tu                  := ver_addr_src_tu;
                    self.ver_addr_src_sl_pos              := ver_addr_src_sl_pos;
                    self.ver_addr_src_sl                  := ver_addr_src_sl;
                    self.ver_addr_src_v_pos               := ver_addr_src_v_pos;
                    self.ver_addr_src_v                   := ver_addr_src_v;
                    self.ver_addr_src_vo_pos              := ver_addr_src_vo_pos;
                    self.ver_addr_src_vo                  := ver_addr_src_vo;
                    self.ver_addr_src_w_pos               := ver_addr_src_w_pos;
                    self.ver_addr_src_w                   := ver_addr_src_w;
                    self.ver_addr_src_wp_pos              := ver_addr_src_wp_pos;
                    self.ver_addr_src_wp                  := ver_addr_src_wp;
                    self.ver_ssn_src_cnt                  := ver_ssn_src_cnt;
                    self.ver_ssn_src_pop                  := ver_ssn_src_pop;
                    self.ver_ssn_src_rcnt                 := ver_ssn_src_rcnt;
                    self.ver_ssn_src_fsrc                 := ver_ssn_src_fsrc;
                    self.ver_ssn_src_ak_pos               := ver_ssn_src_ak_pos;
                    self.ver_ssn_src_ak                   := ver_ssn_src_ak;
                    self.ver_ssn_src_am_pos               := ver_ssn_src_am_pos;
                    self.ver_ssn_src_am                   := ver_ssn_src_am;
                    self.ver_ssn_src_ar_pos               := ver_ssn_src_ar_pos;
                    self.ver_ssn_src_ar                   := ver_ssn_src_ar;
                    self.ver_ssn_src_ba_pos               := ver_ssn_src_ba_pos;
                    self.ver_ssn_src_ba                   := ver_ssn_src_ba;
                    self.ver_ssn_src_cg_pos               := ver_ssn_src_cg_pos;
                    self.ver_ssn_src_cg                   := ver_ssn_src_cg;
                    self.ver_ssn_src_co_pos               := ver_ssn_src_co_pos;
                    self.ver_ssn_src_co                   := ver_ssn_src_co;
                    self.ver_ssn_src_cy_pos               := ver_ssn_src_cy_pos;
                    self.ver_ssn_src_cy                   := ver_ssn_src_cy;
                    self.ver_ssn_src_da_pos               := ver_ssn_src_da_pos;
                    self.ver_ssn_src_da                   := ver_ssn_src_da;
                    self.ver_ssn_src_d_pos                := ver_ssn_src_d_pos;
                    self.ver_ssn_src_d                    := ver_ssn_src_d;
                    self.ver_ssn_src_dl_pos               := ver_ssn_src_dl_pos;
                    self.ver_ssn_src_dl                   := ver_ssn_src_dl;
                    self.ver_ssn_src_ds_pos               := ver_ssn_src_ds_pos;
                    self.ver_ssn_src_ds                   := ver_ssn_src_ds;
                    self.ver_ssn_src_de_pos               := ver_ssn_src_de_pos;
                    self.ver_ssn_src_de                   := ver_ssn_src_de;
                    self.ver_ssn_src_eb_pos               := ver_ssn_src_eb_pos;
                    self.ver_ssn_src_eb                   := ver_ssn_src_eb;
                    self.ver_ssn_src_em_pos               := ver_ssn_src_em_pos;
                    self.ver_ssn_src_em                   := ver_ssn_src_em;
                    self.ver_ssn_src_e1_pos               := ver_ssn_src_e1_pos;
                    self.ver_ssn_src_e1                   := ver_ssn_src_e1;
                    self.ver_ssn_src_e2_pos               := ver_ssn_src_e2_pos;
                    self.ver_ssn_src_e2                   := ver_ssn_src_e2;
                    self.ver_ssn_src_e3_pos               := ver_ssn_src_e3_pos;
                    self.ver_ssn_src_e3                   := ver_ssn_src_e3;
                    self.ver_ssn_src_e4_pos               := ver_ssn_src_e4_pos;
                    self.ver_ssn_src_e4                   := ver_ssn_src_e4;
                    self.ver_ssn_src_en_pos               := ver_ssn_src_en_pos;
                    self.ver_ssn_src_en                   := ver_ssn_src_en;
                    self.ver_ssn_src_eq_pos               := ver_ssn_src_eq_pos;
                    self.ver_ssn_src_eq                   := ver_ssn_src_eq;
                    self.ver_ssn_src_fe_pos               := ver_ssn_src_fe_pos;
                    self.ver_ssn_src_fe                   := ver_ssn_src_fe;
                    self.ver_ssn_src_ff_pos               := ver_ssn_src_ff_pos;
                    self.ver_ssn_src_ff                   := ver_ssn_src_ff;
                    self.ver_ssn_src_fr_pos               := ver_ssn_src_fr_pos;
                    self.ver_ssn_src_fr                   := ver_ssn_src_fr;
                    self.ver_ssn_src_l2_pos               := ver_ssn_src_l2_pos;
                    self.ver_ssn_src_l2                   := ver_ssn_src_l2;
                    self.ver_ssn_src_li_pos               := ver_ssn_src_li_pos;
                    self.ver_ssn_src_li                   := ver_ssn_src_li;
                    self.ver_ssn_src_mw_pos               := ver_ssn_src_mw_pos;
                    self.ver_ssn_src_mw                   := ver_ssn_src_mw;
                    self.ver_ssn_src_nt_pos               := ver_ssn_src_nt_pos;
                    self.ver_ssn_src_nt                   := ver_ssn_src_nt;
                    self.ver_ssn_src_p_pos                := ver_ssn_src_p_pos;
                    self.ver_ssn_src_p                    := ver_ssn_src_p;
                    self.ver_ssn_src_pl_pos               := ver_ssn_src_pl_pos;
                    self.ver_ssn_src_pl                   := ver_ssn_src_pl;
                    self.ver_ssn_src_tn_pos               := ver_ssn_src_tn_pos;
                    self.ver_ssn_src_tn                   := ver_ssn_src_tn;
                    self.ver_ssn_src_ts_pos               := ver_ssn_src_ts_pos;
                    self.ver_ssn_src_ts                   := ver_ssn_src_ts;
                    self.ver_ssn_src_tu_pos               := ver_ssn_src_tu_pos;
                    self.ver_ssn_src_tu                   := ver_ssn_src_tu;
                    self.ver_ssn_src_sl_pos               := ver_ssn_src_sl_pos;
                    self.ver_ssn_src_sl                   := ver_ssn_src_sl;
                    self.ver_ssn_src_v_pos                := ver_ssn_src_v_pos;
                    self.ver_ssn_src_v                    := ver_ssn_src_v;
                    self.ver_ssn_src_vo_pos               := ver_ssn_src_vo_pos;
                    self.ver_ssn_src_vo                   := ver_ssn_src_vo;
                    self.ver_ssn_src_w_pos                := ver_ssn_src_w_pos;
                    self.ver_ssn_src_w                    := ver_ssn_src_w;
                    self.ver_ssn_src_wp_pos               := ver_ssn_src_wp_pos;
                    self.ver_ssn_src_wp                   := ver_ssn_src_wp;
                    self.ver_dob_src_cnt                  := ver_dob_src_cnt;
                    self.ver_dob_src_pop                  := ver_dob_src_pop;
                    self.ver_dob_src_rcnt                 := ver_dob_src_rcnt;
                    self.ver_dob_src_fsrc                 := ver_dob_src_fsrc;
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
                    self.ver_dob_src_co_pos               := ver_dob_src_co_pos;
                    self.ver_dob_src_co                   := ver_dob_src_co;
                    self.ver_dob_src_cy_pos               := ver_dob_src_cy_pos;
                    self.ver_dob_src_cy                   := ver_dob_src_cy;
                    self.ver_dob_src_da_pos               := ver_dob_src_da_pos;
                    self.ver_dob_src_da                   := ver_dob_src_da;
                    self.ver_dob_src_d_pos                := ver_dob_src_d_pos;
                    self.ver_dob_src_d                    := ver_dob_src_d;
                    self.ver_dob_src_dl_pos               := ver_dob_src_dl_pos;
                    self.ver_dob_src_dl                   := ver_dob_src_dl;
                    self.ver_dob_src_ds_pos               := ver_dob_src_ds_pos;
                    self.ver_dob_src_ds                   := ver_dob_src_ds;
                    self.ver_dob_src_de_pos               := ver_dob_src_de_pos;
                    self.ver_dob_src_de                   := ver_dob_src_de;
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
                    self.ver_dob_src_ts_pos               := ver_dob_src_ts_pos;
                    self.ver_dob_src_ts                   := ver_dob_src_ts;
                    self.ver_dob_src_tu_pos               := ver_dob_src_tu_pos;
                    self.ver_dob_src_tu                   := ver_dob_src_tu;
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
                    self.email_src_cnt                    := email_src_cnt;
                    self.email_src_pop                    := email_src_pop;
                    self.email_src_rcnt                   := email_src_rcnt;
                    self.email_src_fsrc                   := email_src_fsrc;
                    self.email_src_aw_pos                 := email_src_aw_pos;
                    self.email_src_aw                     := email_src_aw;
                    self.email_src_et_pos                 := email_src_et_pos;
                    self.email_src_et                     := email_src_et;
                    self.email_src_wa_pos                 := email_src_wa_pos;
                    self.email_src_wa                     := email_src_wa;
                    self.email_src_om_pos                 := email_src_om_pos;
                    self.email_src_om                     := email_src_om;
                    self.email_src_m1_pos                 := email_src_m1_pos;
                    self.email_src_m1                     := email_src_m1;
                    self.email_src_sc_pos                 := email_src_sc_pos;
                    self.email_src_sc                     := email_src_sc;
                    self.email_src_dg_pos                 := email_src_dg_pos;
                    self.email_src_dg                     := email_src_dg;
                    self.util_type_cnt                    := util_type_cnt;
                    self.util_type_pop                    := util_type_pop;
                    self.util_type_rcnt                   := util_type_rcnt;
                    self.util_type_fsrc                   := util_type_fsrc;
                    self.util_type_2_pos                  := util_type_2_pos;
                    self.util_type_2                      := util_type_2;
                    self.util_type_1_pos                  := util_type_1_pos;
                    self.util_type_1                      := util_type_1;
                    self.util_type_z_pos                  := util_type_z_pos;
                    self.util_type_z                      := util_type_z;
                    self.util_inp_cnt                     := util_inp_cnt;
                    self.util_inp_pop                     := util_inp_pop;
                    self.util_inp_rcnt                    := util_inp_rcnt;
                    self.util_inp_fsrc                    := util_inp_fsrc;
                    self.util_inp_2_pos                   := util_inp_2_pos;
                    self.util_inp_2                       := util_inp_2;
                    self.util_inp_1_pos                   := util_inp_1_pos;
                    self.util_inp_1                       := util_inp_1;
                    self.util_inp_z_pos                   := util_inp_z_pos;
                    self.util_inp_z                       := util_inp_z;
                    self.util_curr_cnt                    := util_curr_cnt;
                    self.util_curr_pop                    := util_curr_pop;
                    self.util_curr_rcnt                   := util_curr_rcnt;
                    self.util_curr_fsrc                   := util_curr_fsrc;
                    self.util_curr_2_pos                  := util_curr_2_pos;
                    self.util_curr_2                      := util_curr_2;
                    self.util_curr_1_pos                  := util_curr_1_pos;
                    self.util_curr_1                      := util_curr_1;
                    self.util_curr_z_pos                  := util_curr_z_pos;
                    self.util_curr_z                      := util_curr_z;
                    self.nf_inq_communications_count      := nf_inq_communications_count;
                    self._in_dob                          := _in_dob;
                    self.yr_in_dob                        := yr_in_dob;
                    self.yr_in_dob_int                    := yr_in_dob_int;
                    self.rv_comb_age                      := rv_comb_age;
                    self.nf_inq_communications_count24    := nf_inq_communications_count24;
                    self.iv_estimated_income              := iv_estimated_income;
                    self.nf_fp_varrisktype                := nf_fp_varrisktype;
                    self.nf_inq_prepaidcards_count        := nf_inq_prepaidcards_count;
                    self.rv_d32_criminal_count            := rv_d32_criminal_count;
                    self.rv_d32_felony_count              := rv_d32_felony_count;
                    self.rv_d31_bk_disposed_hist_count    := rv_d31_bk_disposed_hist_count;
                    self.nf_inq_perssn_count01            := nf_inq_perssn_count01;
                    self.rv_d34_liens_unreleased_ct84     := rv_d34_liens_unreleased_ct84;
                    self.vo_pos                           := vo_pos;
                    self.iv_src_voter_adl_count           := iv_src_voter_adl_count;
                    self.rv_i61_inq_collection_count12    := rv_i61_inq_collection_count12;
                    self.nf_inq_ssnsperadl_count03        := nf_inq_ssnsperadl_count03;
                    self.nf_average_rel_age               := nf_average_rel_age;
                    self.nf_fp_curraddrcartheftindex      := nf_fp_curraddrcartheftindex;
                    self.rv_d33_eviction_count            := rv_d33_eviction_count;
                    self.nf_inq_other_count24             := nf_inq_other_count24;
                    self.corrssnaddr_src_cnt              := corrssnaddr_src_cnt;
                    self.corrssnaddr_src_pop              := corrssnaddr_src_pop;
                    self.corrssnaddr_src_rcnt             := corrssnaddr_src_rcnt;
                    self.corrssnaddr_src_fsrc             := corrssnaddr_src_fsrc;
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
                    self.nf_hh_collections_ct             := nf_hh_collections_ct;
                    self.rv_l79_adls_per_addr_c6          := rv_l79_adls_per_addr_c6;
                    self.nf_pct_rel_with_felony           := nf_pct_rel_with_felony;
                    self.dfsn_v01_w                       := dfsn_v01_w;
                    self.dfsn_v02_w                       := dfsn_v02_w;
                    self.dfsn_v03_w                       := dfsn_v03_w;
                    self.dfsn_v04_w                       := dfsn_v04_w;
                    self.dfsn_v05_w                       := dfsn_v05_w;
                    self.dfsn_v06_w                       := dfsn_v06_w;
                    self.dfsn_v07_w                       := dfsn_v07_w;
                    self.dfsn_v08_w                       := dfsn_v08_w;
                    self.dfsn_v09_w                       := dfsn_v09_w;
                    self.dfsn_v10_w                       := dfsn_v10_w;
                    self.dfsn_v11_w                       := dfsn_v11_w;
                    self.dfsn_v12_w                       := dfsn_v12_w;
                    self.dfsn_v13_w                       := dfsn_v13_w;
                    self.dfsn_v14_w                       := dfsn_v14_w;
                    self.dfsn_v15_w                       := dfsn_v15_w;
                    self.dfsn_v16_w                       := dfsn_v16_w;
                    self.dfsn_v17_w                       := dfsn_v17_w;
                    self.dfsn_v18_w                       := dfsn_v18_w;
                    self.dfsn_v19_w                       := dfsn_v19_w;
                    self.dfsn_v20_w                       := dfsn_v20_w;
                    self.dfsn_v21_w                       := dfsn_v21_w;
                    self.dfsn_v22_w                       := dfsn_v22_w;
                    self.dfsn_lgt                         := dfsn_lgt;
                    self.fp1802_1_0                       := fp1802_1_0;
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
                    self.stolenid                         := stolenid;
                    self.manipulatedid                    := manipulatedid;
                    self.manipulatedidpt2                 := manipulatedidpt2;
                    self.suspiciousactivity               := suspiciousactivity;
                    self.vulnerablevictim                 := vulnerablevictim;
                    self.friendlyfraud                    := friendlyfraud;
                    self.ver_src_ak                       := ver_src_ak;
                    self.ver_src_am                       := ver_src_am;
                    self.ver_src_ar                       := ver_src_ar;
                    self.ver_src_ba                       := ver_src_ba;
                    self.ver_src_cg                       := ver_src_cg;
                    self.ver_src_co                       := ver_src_co;
                    self.ver_src_cy                       := ver_src_cy;
                    self.ver_src_da                       := ver_src_da;
                    self.ver_src_d                        := ver_src_d;
                    self.ver_src_dl                       := ver_src_dl;
                    self.ver_src_ds                       := ver_src_ds;
                    self.ver_src_de                       := ver_src_de;
                    self.ver_src_eb                       := ver_src_eb;
                    self.ver_src_em                       := ver_src_em;
                    self.ver_src_e1                       := ver_src_e1;
                    self.ver_src_e2                       := ver_src_e2;
                    self.ver_src_e3                       := ver_src_e3;
                    self.ver_src_e4                       := ver_src_e4;
                    self.ver_src_en                       := ver_src_en;
                    self.ver_src_eq                       := ver_src_eq;
                    self.ver_src_fe                       := ver_src_fe;
                    self.ver_src_ff                       := ver_src_ff;
                    self.ver_src_fr                       := ver_src_fr;
                    self.ver_src_l2                       := ver_src_l2;
                    self.ver_src_li                       := ver_src_li;
                    self.ver_src_mw                       := ver_src_mw;
                    self.ver_src_nt                       := ver_src_nt;
                    self.ver_src_p                        := ver_src_p;
                    self.ver_src_pl                       := ver_src_pl;
                    self.ver_src_tn                       := ver_src_tn;
                    self.ver_src_ts                       := ver_src_ts;
                    self.ver_src_tu                       := ver_src_tu;
                    self.ver_src_sl                       := ver_src_sl;
                    self.ver_src_v                        := ver_src_v;
                    self.ver_src_vo                       := ver_src_vo;
                    self.ver_src_w                        := ver_src_w;
                    self.ver_src_wp                       := ver_src_wp;
                    self.src_bureau                       := src_bureau;
                    self.src_behavioral                   := src_behavioral;
                    self.src_inperson                     := src_inperson;
                    self.syntheticid2                     := syntheticid2;
                    self.stolenc_fp1802_1_0               := stolenc_fp1802_1_0;
                    self.manip2c_fp1802_1_0               := manip2c_fp1802_1_0;
                    self.synth2c_fp1802_1_0               := synth2c_fp1802_1_0;
                    self.suspactc_fp1802_1_0              := suspactc_fp1802_1_0;
                    self.vulnvicc_fp1802_1_0              := vulnvicc_fp1802_1_0;
                    self.friendlyc_fp1802_1_0             := friendlyc_fp1802_1_0;
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
   ritmp :=  Models.fraudpoint3_reasons(le, blank_ip, num_reasons);
	 reasons := Models.Common.checkFraudPointRC34(FP1802_1_0, ritmp, num_reasons);
	self.ri := reasons;
	self.score := (string)FP1802_1_0;
	self := [];
	
END;

model :=   project(clam, doModel(left) );
	
	return model;
END;



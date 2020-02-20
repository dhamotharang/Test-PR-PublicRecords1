IMPORT  Risk_Indicators, std, riskview;

export RVP1702_1_0( grouped dataset(risk_indicators.Layout_Boca_Shell) clam) := FUNCTION

	MODEL_DEBUG := False;
	// MODEL_DEBUG := true;
 
// boolean isFCRA := false;
boolean isFCRA := true;

	#if(MODEL_DEBUG)
		Layout_Debug := RECORD
		
      integer seq; 
		  boolean truedid ;
      
      	/* Model Intermediate Variables */
        
                  			
                    Integer ver_src_cnt                     ;// := ver_src_cnt;				
                    boolean ver_src_pop                     ;// := ver_src_pop;				
                    string ver_src_fsrc                    ;// := ver_src_fsrc;				
                    string ver_src_fsrc_fdate              ;// := ver_src_fsrc_fdate;				
                    integer ver_src_fsrc_fdate2             ;// := ver_src_fsrc_fdate2;				
                    Real yr_ver_src_fsrc_fdate           ;// := yr_ver_src_fsrc_fdate;				
                    Real mth_ver_src_fsrc_fdate          ;// := mth_ver_src_fsrc_fdate;				
                    integer ver_src_ak_pos                     ;// ver_src_ak_pos;	
                    boolean ver_src_ak                       ;// ver_src_ak;				
                    string _ver_src_fdate_ak                ;// _ver_src_fdate_ak;				
                    integer ver_src_fdate_ak                 ;// ver_src_fdate_ak;				
                    string _ver_src_ldate_ak               ;// := _ver_src_ldate_ak;				
                    integer   ver_src_ldate_ak              ;//   := ver_src_ldate_ak;				
                    real   ver_src_cnt_ak                 ;//  := ver_src_cnt_ak;				
                    real ver_src_am_pos                   ;// ver_src_am_pos;				
                    boolean ver_src_am                       ;// ver_src_am;				
                    string _ver_src_fdate_am                ;// _ver_src_fdate_am;				
                    integer ver_src_fdate_am                 ;// ver_src_fdate_am;				
                    string   _ver_src_ldate_am               ;// := _ver_src_ldate_am;				
                    integer   ver_src_ldate_am                ;// := ver_src_ldate_am;				
                    real   ver_src_cnt_am                  ;// := ver_src_cnt_am;				
                    integer ver_src_ar_pos                   ;// ver_src_ar_pos;				
                    boolean ver_src_ar                       ;// ver_src_ar;				
                    string _ver_src_fdate_ar                ;// _ver_src_fdate_ar;				
                    integer ver_src_fdate_ar                 ;// ver_src_fdate_ar;				
                    string   _ver_src_ldate_ar              ;//  := _ver_src_ldate_ar;				
                    integer   ver_src_ldate_ar               ;//  := ver_src_ldate_ar;				
                    real   ver_src_cnt_ar                  ;// := ver_src_cnt_ar;				
                    integer ver_src_ba_pos                   ;// ver_src_ba_pos;				
                    boolean ver_src_ba                       ;// ver_src_ba;				
                    string _ver_src_fdate_ba                ;// _ver_src_fdate_ba;				
                    integer ver_src_fdate_ba                 ;// ver_src_fdate_ba;				
                    string   _ver_src_ldate_ba               ;// := _ver_src_ldate_ba;				
                    integer   ver_src_ldate_ba                ;// := ver_src_ldate_ba;				
                    real   ver_src_cnt_ba                  ;// := ver_src_cnt_ba;				
                    integer ver_src_cg_pos                   ;// ver_src_cg_pos;				
                    boolean ver_src_cg                       ;// ver_src_cg;				
                    string _ver_src_fdate_cg                ;// _ver_src_fdate_cg;				
                    integer ver_src_fdate_cg                 ;// ver_src_fdate_cg;				
                    string   _ver_src_ldate_cg               ;// := _ver_src_ldate_cg;				
                    integer   ver_src_ldate_cg                ;// := ver_src_ldate_cg;				
                    real   ver_src_cnt_cg                  ;// := ver_src_cnt_cg;				
                    integer ver_src_co_pos                   ;// ver_src_co_pos;				
                    boolean   ver_src_co                      ;// := ver_src_co;				
                    string _ver_src_fdate_co                ;// _ver_src_fdate_co;				
                    integer ver_src_fdate_co                 ;// ver_src_fdate_co;				
                    string   _ver_src_ldate_co               ;// := _ver_src_ldate_co;				
                    integer   ver_src_ldate_co                ;// := ver_src_ldate_co;				
                    real   ver_src_cnt_co                  ;// := ver_src_cnt_co;				
                    integer ver_src_cy_pos                   ;// ver_src_cy_pos;				
                    boolean ver_src_cy                       ;// ver_src_cy;				
                    string _ver_src_fdate_cy                ;// _ver_src_fdate_cy;				
                    integer ver_src_fdate_cy                 ;// ver_src_fdate_cy;				
                    string   _ver_src_ldate_cy               ;// := _ver_src_ldate_cy;				
                    integer   ver_src_ldate_cy                ;// := ver_src_ldate_cy;				
                    real   ver_src_cnt_cy                   ;//:= ver_src_cnt_cy;				
                    integer ver_src_da_pos                   ;// ver_src_da_pos;				
                    boolean ver_src_da                       ;// ver_src_da;				
                    string _ver_src_fdate_da                ;// _ver_src_fdate_da;				
                    integer ver_src_fdate_da                 ;// ver_src_fdate_da;				
                    string   _ver_src_ldate_da                ;//:= _ver_src_ldate_da;				
                    integer   ver_src_ldate_da                 ;//:= ver_src_ldate_da;				
                    real   ver_src_cnt_da                  ;// := ver_src_cnt_da;				
                    integer ver_src_d_pos                    ;// ver_src_d_pos;				
                    boolean ver_src_d                        ;// ver_src_d;				
                    string _ver_src_fdate_d                 ;// _ver_src_fdate_d;				
                    integer ver_src_fdate_d                  ;//;// ver_src_fdate_d;				
                    string   _ver_src_ldate_d                ;// := _ver_src_ldate_d;				
                    integer   ver_src_ldate_d                 ;// := ver_src_ldate_d;				
                    real   ver_src_cnt_d                   ;// := ver_src_cnt_d;				
                    integer ver_src_dl_pos                   ;// ver_src_dl_pos;				
                    boolean ver_src_dl                       ;// ver_src_dl;				
                    string _ver_src_fdate_dl                ;// _ver_src_fdate_dl;				
                    integer ver_src_fdate_dl                 ;// ver_src_fdate_dl;				
                    string   _ver_src_ldate_dl              ;//  := _ver_src_ldate_dl;				
                    integer   ver_src_ldate_dl                ;// := ver_src_ldate_dl;				
                    real   ver_src_cnt_dl                  ;// := ver_src_cnt_dl;				
                    integer ver_src_ds_pos                   ;// ver_src_ds_pos;				
                    boolean ver_src_ds                       ;// ver_src_ds;				
                    string _ver_src_fdate_ds                ;// _ver_src_fdate_ds;				
                    integer ver_src_fdate_ds                 ;// ver_src_fdate_ds;				
                    string   _ver_src_ldate_ds               ;// := _ver_src_ldate_ds;				
                    integer   ver_src_ldate_ds                ;// := ver_src_ldate_ds;				
                    real   ver_src_cnt_ds                  ;// := ver_src_cnt_ds;				
                    integer ver_src_de_pos                   ;// ver_src_de_pos;				
                    boolean ver_src_de                       ;// ver_src_de;				
                    string _ver_src_fdate_de                ;// _ver_src_fdate_de;				
                    integer ver_src_fdate_de                 ;// ver_src_fdate_de;				
                    string   _ver_src_ldate_de              ;//  := _ver_src_ldate_de;				
                    integer   ver_src_ldate_de                ;// := ver_src_ldate_de;				
                    real   ver_src_cnt_de                  ;// := ver_src_cnt_de;				
                    integer ver_src_eb_pos                   ;// ver_src_eb_pos;				
                    boolean ver_src_eb                       ;// ver_src_eb;				
                    string _ver_src_fdate_eb                ;// _ver_src_fdate_eb;				
                    integer ver_src_fdate_eb                 ;// ver_src_fdate_eb;				
                    string   _ver_src_ldate_eb              ;//  := _ver_src_ldate_eb;				
                    integer   ver_src_ldate_eb               ;//  := ver_src_ldate_eb;				
                    real   ver_src_cnt_eb                  ;// := ver_src_cnt_eb;				
                    integer ver_src_em_pos                   ;// ver_src_em_pos;				
                    boolean ver_src_em                       ;// ver_src_em;				
                    string _ver_src_fdate_em                ;// _ver_src_fdate_em;				
                    integer ver_src_fdate_em                 ;// ver_src_fdate_em;				
                    string   _ver_src_ldate_em               ;// _ver_src_ldate_em;				
                    integer   ver_src_ldate_em                ;// ver_src_ldate_em;				
                    real   ver_src_cnt_em                  ;// ver_src_cnt_em;				
                    integer ver_src_e1_pos                   ;// ver_src_e1_pos;				
                    boolean ver_src_e1                       ;// ver_src_e1;				
                    string _ver_src_fdate_e1                ;// _ver_src_fdate_e1;				
                    integer ver_src_fdate_e1                 ;// ver_src_fdate_e1;				
                    string   _ver_src_ldate_e1               ;// _ver_src_ldate_e1;				
                    integer   ver_src_ldate_e1                ;// ver_src_ldate_e1;				
                    real   ver_src_cnt_e1                  ;// ver_src_cnt_e1;				
                    integer ver_src_e2_pos                   ;// ver_src_e2_pos;				
                    boolean ver_src_e2                       ;// ver_src_e2;				
                    string _ver_src_fdate_e2                ;// _ver_src_fdate_e2;				
                    integer ver_src_fdate_e2                 ;// ver_src_fdate_e2;				
                    string   _ver_src_ldate_e2               ;// _ver_src_ldate_e2;				
                    integer   ver_src_ldate_e2                 ;//ver_src_ldate_e2;				
                    real   ver_src_cnt_e2                   ;//ver_src_cnt_e2;				
                    integer ver_src_e3_pos                   ;// ver_src_e3_pos;				
                    boolean ver_src_e3                       ;// ver_src_e3;				
                    string _ver_src_fdate_e3                ;// _ver_src_fdate_e3;				
                    integer ver_src_fdate_e3                 ;// ver_src_fdate_e3;				
                    string   _ver_src_ldate_e3               ;//_ver_src_ldate_e3;				
                    integer   ver_src_ldate_e3                ;// ver_src_ldate_e3;				
                    real   ver_src_cnt_e3                  ;// ver_src_cnt_e3;				
                    integer ver_src_e4_pos                   ;// ver_src_e4_pos;				
                    boolean ver_src_e4                       ;// ver_src_e4;				
                    string _ver_src_fdate_e4                ;// _ver_src_fdate_e4;				
                    integer ver_src_fdate_e4                 ;// ver_src_fdate_e4;				
                    string   _ver_src_ldate_e4               ;// _ver_src_ldate_e4;				
                    integer   ver_src_ldate_e4                ;// ver_src_ldate_e4;				
                    real   ver_src_cnt_e4                  ;// ver_src_cnt_e4;				
                    integer ver_src_en_pos                   ;// ver_src_en_pos;				
                    boolean   ver_src_en                      ;// ver_src_en;				
                    string _ver_src_fdate_en                ;// _ver_src_fdate_en;				
                    integer ver_src_fdate_en                 ;// ver_src_fdate_en;				
                    string   _ver_src_ldate_en               ;// _ver_src_ldate_en;				
                    integer   ver_src_ldate_en               ;//= ver_src_ldate_en;				
                    real   ver_src_cnt_en                  ;// ver_src_cnt_en;				
                    integer ver_src_eq_pos                   ;// ver_src_eq_pos;				
                    boolean   ver_src_eq                      ;// ver_src_eq;				
                    string _ver_src_fdate_eq                ;// _ver_src_fdate_eq;				
                    integer ver_src_fdate_eq                 ;// ver_src_fdate_eq;				
                    string   _ver_src_ldate_eq              ;//= _ver_src_ldate_eq;				
                    integer   ver_src_ldate_eq                ;// ver_src_ldate_eq;				
                    real   ver_src_cnt_eq                 ;//= ver_src_cnt_eq;				
                    integer ver_src_fe_pos                   ;// ver_src_fe_pos;				
                    boolean ver_src_fe                       ;// ver_src_fe;				
                    string _ver_src_fdate_fe                ;// _ver_src_fdate_fe;				
                    integer ver_src_fdate_fe                 ;// ver_src_fdate_fe;				
                    string   _ver_src_ldate_fe              ;//= _ver_src_ldate_fe;				
                    integer   ver_src_ldate_fe               ;//= ver_src_ldate_fe;				
                    real   ver_src_cnt_fe                 ;//= ver_src_cnt_fe;				
                    integer ver_src_ff_pos                   ;// ver_src_ff_pos;				
                    boolean ver_src_ff                       ;// ver_src_ff;				
                    string _ver_src_fdate_ff                ;// _ver_src_fdate_ff;				
                    integer ver_src_fdate_ff                 ;// ver_src_fdate_ff;				
                    string   _ver_src_ldate_ff              ;//= _ver_src_ldate_ff;				
                    integer   ver_src_ldate_ff               ;//= ver_src_ldate_ff;				
                    real   ver_src_cnt_ff                  ;// ver_src_cnt_ff;				
                    integer ver_src_fr_pos                   ;// ver_src_fr_pos;				
                    boolean ver_src_fr                       ;// ver_src_fr;				
                    string _ver_src_fdate_fr                ;// _ver_src_fdate_fr;				
                    integer ver_src_fdate_fr                 ;// ver_src_fdate_fr;				
                    string   _ver_src_ldate_fr              ;//= _ver_src_ldate_fr;				
                    integer   ver_src_ldate_fr                ;// ver_src_ldate_fr;				
                    real   ver_src_cnt_fr                  ;// ver_src_cnt_fr;				
                    integer ver_src_l2_pos                   ;// ver_src_l2_pos;				
                    boolean ver_src_l2                       ;// ver_src_l2;				
                    string _ver_src_fdate_l2                ;// _ver_src_fdate_l2;				
                    integer ver_src_fdate_l2                 ;// ver_src_fdate_l2;				
                    string   _ver_src_ldate_l2               ;// _ver_src_ldate_l2;				
                    integer   ver_src_ldate_l2                ;// ver_src_ldate_l2;				
                    real   ver_src_cnt_l2                  ;// ver_src_cnt_l2;				
                    integer ver_src_li_pos                   ;// ver_src_li_pos;				
                    boolean ver_src_li                       ;// ver_src_li;				
                    string _ver_src_fdate_li                ;// _ver_src_fdate_li;				
                    integer ver_src_fdate_li                 ;// ver_src_fdate_li;				
                    string   _ver_src_ldate_li               ;// _ver_src_ldate_li;				
                    integer   ver_src_ldate_li                ;// ver_src_ldate_li;				
                    real   ver_src_cnt_li                  ;// ver_src_cnt_li;				
                    integer ver_src_mw_pos                   ;// ver_src_mw_pos;				
                    boolean ver_src_mw                       ;// ver_src_mw;				
                    string _ver_src_fdate_mw                ;// _ver_src_fdate_mw;				
                    integer ver_src_fdate_mw                 ;// ver_src_fdate_mw;				
                    string   _ver_src_ldate_mw              ;//= _ver_src_ldate_mw;				
                    integer   ver_src_ldate_mw                ;// ver_src_ldate_mw;				
                    real   ver_src_cnt_mw                  ;// ver_src_cnt_mw;				
                    integer ver_src_nt_pos                   ;// ver_src_nt_pos;				
                    boolean ver_src_nt                       ;// ver_src_nt;				
                    string _ver_src_fdate_nt                ;// _ver_src_fdate_nt;				
                    integer ver_src_fdate_nt                 ;// ver_src_fdate_nt;				
                    string   _ver_src_ldate_nt               ;// _ver_src_ldate_nt;				
                    integer   ver_src_ldate_nt                ;// ver_src_ldate_nt;				
                    real   ver_src_cnt_nt                  ;// ver_src_cnt_nt;				
                    integer ver_src_p_pos                    ;// ver_src_p_pos;				
                    boolean ver_src_p                        ;// ver_src_p;				
                    string _ver_src_fdate_p                 ;// _ver_src_fdate_p;				
                    integer ver_src_fdate_p                  ;// ver_src_fdate_p;				
                    string   _ver_src_ldate_p                ;// _ver_src_ldate_p;				
                    integer   ver_src_ldate_p                 ;// ver_src_ldate_p;				
                    real   ver_src_cnt_p                   ;// ver_src_cnt_p;				
                    integer ver_src_pl_pos                   ;// ver_src_pl_pos;				
                    boolean ver_src_pl                       ;// ver_src_pl;				
                    string _ver_src_fdate_pl                ;// _ver_src_fdate_pl;				
                    integer ver_src_fdate_pl                 ;// ver_src_fdate_pl;				
                    string   _ver_src_ldate_pl               ;// _ver_src_ldate_pl;				
                    integer   ver_src_ldate_pl                ;// ver_src_ldate_pl;				
                    real   ver_src_cnt_pl                   ;//ver_src_cnt_pl;				
                    integer ver_src_tn_pos                   ;// ver_src_tn_pos;				
                    boolean   ver_src_tn                      ;// ver_src_tn;				
                    string _ver_src_fdate_tn                ;// _ver_src_fdate_tn;				
                    integer ver_src_fdate_tn                 ;// ver_src_fdate_tn;				
                    string   _ver_src_ldate_tn               ;// _ver_src_ldate_tn;				
                    integer   ver_src_ldate_tn                ;// ver_src_ldate_tn;				
                    real   ver_src_cnt_tn                  ;// ver_src_cnt_tn;				
                    integer ver_src_ts_pos                   ;// ver_src_ts_pos;				
                    boolean   ver_src_ts                      ;// ver_src_ts;				
                    string _ver_src_fdate_ts                ;// _ver_src_fdate_ts;				
                    integer ver_src_fdate_ts                 ;// ver_src_fdate_ts;				
                    string   _ver_src_ldate_ts                ;//:= _ver_src_ldate_ts;				
                    integer   ver_src_ldate_ts                 ;//:= ver_src_ldate_ts;				
                    real   ver_src_cnt_ts                   ;//:= ver_src_cnt_ts;				
                    integer ver_src_tu_pos                   ;// ver_src_tu_pos;				
                    boolean   ver_src_tu                       ;//:= ver_src_tu;				
                    string _ver_src_fdate_tu                ;// _ver_src_fdate_tu;				
                    integer ver_src_fdate_tu                 ;// ver_src_fdate_tu;				
                    string   _ver_src_ldate_tu                ;//:= _ver_src_ldate_tu;				
                    integer   ver_src_ldate_tu                 ;//:= ver_src_ldate_tu;				
                    real   ver_src_cnt_tu                   ;//:= ver_src_cnt_tu;				
                    integer ver_src_sl_pos                   ;// ver_src_sl_pos;				
                    boolean ver_src_sl                       ;// ver_src_sl;				
                    string _ver_src_fdate_sl                ;// _ver_src_fdate_sl;				
                    integer ver_src_fdate_sl                 ;// ver_src_fdate_sl;				
                    string   _ver_src_ldate_sl                ;//:= _ver_src_ldate_sl;				
                    integer   ver_src_ldate_sl                 ;//:= ver_src_ldate_sl;				
                    real   ver_src_cnt_sl                   ;//:= ver_src_cnt_sl;				
                    integer ver_src_v_pos                    ;// ver_src_v_pos;				
                    boolean ver_src_v                        ;// ver_src_v;				
                    string _ver_src_fdate_v                 ;// _ver_src_fdate_v;				
                    integer ver_src_fdate_v                  ;// ver_src_fdate_v;				
                    string   _ver_src_ldate_v                 ;//:= _ver_src_ldate_v;				
                    integer   ver_src_ldate_v                  ;//:= ver_src_ldate_v;				
                    real   ver_src_cnt_v                    ;//:= ver_src_cnt_v;				
                    integer ver_src_vo_pos                   ;// ver_src_vo_pos;				
                    boolean ver_src_vo                       ;// ver_src_vo;				
                    string _ver_src_fdate_vo                ;// _ver_src_fdate_vo;				
                    integer ver_src_fdate_vo                 ;// ver_src_fdate_vo;				
                    string   _ver_src_ldate_vo                ;//:= _ver_src_ldate_vo;				
                    integer   ver_src_ldate_vo                 ;//:= ver_src_ldate_vo;				
                    real   ver_src_cnt_vo                   ;//:= ver_src_cnt_vo;				
                    integer ver_src_w_pos                    ;// ver_src_w_pos;				
                    boolean ver_src_w                        ;// ver_src_w;				
                    string _ver_src_fdate_w                 ;// _ver_src_fdate_w;				
                    integer ver_src_fdate_w                  ;// ver_src_fdate_w;				
                    string   _ver_src_ldate_w                 ;//:= _ver_src_ldate_w;				
                    integer   ver_src_ldate_w                  ;//:= ver_src_ldate_w;				
                    real   ver_src_cnt_w                    ;//:= ver_src_cnt_w;				
                    integer ver_src_wp_pos                   ;// ver_src_wp_pos;				
                    boolean ver_src_wp                       ;// ver_src_wp;				
                    string _ver_src_fdate_wp                ;// _ver_src_fdate_wp;				
                    integer ver_src_fdate_wp                 ;// ver_src_fdate_wp;				
                    string   _ver_src_ldate_wp                ;//:= _ver_src_ldate_wp;				
                    integer   ver_src_ldate_wp                 ;//:= ver_src_ldate_wp;				
                    real   ver_src_cnt_wp                   ;//:= ver_src_cnt_wp;				
                    real   ver_src_rcnt                     ;//:= ver_src_rcnt;				
                    integer   ver_fname_src_cnt                ;//:= ver_fname_src_cnt;				
                    boolean   ver_fname_src_pop                ;//:= ver_fname_src_pop;				
                    integer   ver_fname_src_rcnt               ;//:= ver_fname_src_rcnt;				
                    string   ver_fname_src_fsrc               ;//:= ver_fname_src_fsrc;				
                    integer   ver_fname_src_ak_pos             ;//:= ver_fname_src_ak_pos;				
                    boolean   ver_fname_src_ak                 ;//:= ver_fname_src_ak;				
                    integer   ver_fname_src_am_pos             ;//:= ver_fname_src_am_pos;				
                    boolean   ver_fname_src_am                 ;//:= ver_fname_src_am;				
                    integer   ver_fname_src_ar_pos             ;//:= ver_fname_src_ar_pos;				
                    boolean   ver_fname_src_ar                 ;//:= ver_fname_src_ar;				
                    integer   ver_fname_src_ba_pos             ;//:= ver_fname_src_ba_pos;				
                    boolean   ver_fname_src_ba                 ;//:= ver_fname_src_ba;				
                    integer   ver_fname_src_cg_pos             ;//:= ver_fname_src_cg_pos;				
                    boolean   ver_fname_src_cg                 ;//:= ver_fname_src_cg;				
                    integer   ver_fname_src_co_pos             ;//:= ver_fname_src_co_pos;				
                    boolean   ver_fname_src_co                 ;//:= ver_fname_src_co;				
                    integer   ver_fname_src_cy_pos             ;//:= ver_fname_src_cy_pos;				
                    boolean   ver_fname_src_cy                 ;//:= ver_fname_src_cy;				
                    integer   ver_fname_src_da_pos             ;//:= ver_fname_src_da_pos;				
                    boolean   ver_fname_src_da                 ;//:= ver_fname_src_da;				
                    integer   ver_fname_src_d_pos              ;//:= ver_fname_src_d_pos;				
                    boolean   ver_fname_src_d                  ;//:= ver_fname_src_d;				
                    integer   ver_fname_src_dl_pos             ;//:= ver_fname_src_dl_pos;				
                    boolean   ver_fname_src_dl                 ;//:= ver_fname_src_dl;				
                    integer   ver_fname_src_ds_pos             ;//:= ver_fname_src_ds_pos;				
                    boolean   ver_fname_src_ds                 ;//:= ver_fname_src_ds;				
                    integer   ver_fname_src_de_pos             ;//:= ver_fname_src_de_pos;				
                    boolean   ver_fname_src_de                 ;//:= ver_fname_src_de;				
                    integer   ver_fname_src_eb_pos             ;//:= ver_fname_src_eb_pos;				
                    boolean   ver_fname_src_eb                 ;//:= ver_fname_src_eb;				
                    integer   ver_fname_src_em_pos             ;//:= ver_fname_src_em_pos;				
                    boolean   ver_fname_src_em                 ;//:= ver_fname_src_em;				
                    integer   ver_fname_src_e1_pos             ;//:= ver_fname_src_e1_pos;				
                    boolean   ver_fname_src_e1                 ;//:= ver_fname_src_e1;				
                    integer   ver_fname_src_e2_pos             ;//:= ver_fname_src_e2_pos;				
                    boolean   ver_fname_src_e2                 ;//:= ver_fname_src_e2;				
                    integer   ver_fname_src_e3_pos             ;//:= ver_fname_src_e3_pos;				
                    boolean   ver_fname_src_e3                 ;//:= ver_fname_src_e3;				
                    integer   ver_fname_src_e4_pos             ;//:= ver_fname_src_e4_pos;				
                    boolean   ver_fname_src_e4                 ;//:= ver_fname_src_e4;				
                    integer   ver_fname_src_en_pos             ;//:= ver_fname_src_en_pos;				
                    boolean   ver_fname_src_en                 ;//:= ver_fname_src_en;				
                    integer   ver_fname_src_eq_pos             ;//:= ver_fname_src_eq_pos;				
                    boolean   ver_fname_src_eq                 ;//:= ver_fname_src_eq;				
                    integer   ver_fname_src_fe_pos             ;//:= ver_fname_src_fe_pos;				
                    boolean   ver_fname_src_fe                 ;//:= ver_fname_src_fe;				
                    integer   ver_fname_src_ff_pos             ;//:= ver_fname_src_ff_pos;				
                    boolean   ver_fname_src_ff                 ;//:= ver_fname_src_ff;				
                    integer   ver_fname_src_fr_pos             ;//:= ver_fname_src_fr_pos;				
                    boolean   ver_fname_src_fr                 ;//:= ver_fname_src_fr;				
                    integer   ver_fname_src_l2_pos             ;//:= ver_fname_src_l2_pos;				
                    boolean   ver_fname_src_l2                 ;//:= ver_fname_src_l2;				
                    integer   ver_fname_src_li_pos             ;//:= ver_fname_src_li_pos;				
                    boolean   ver_fname_src_li                 ;//:= ver_fname_src_li;				
                    integer   ver_fname_src_mw_pos             ;//:= ver_fname_src_mw_pos;				
                    boolean   ver_fname_src_mw                 ;//:= ver_fname_src_mw;				
                    integer   ver_fname_src_nt_pos             ;//:= ver_fname_src_nt_pos;				
                    boolean   ver_fname_src_nt                 ;//:= ver_fname_src_nt;				
                    integer   ver_fname_src_p_pos              ;//:= ver_fname_src_p_pos;				
                    boolean   ver_fname_src_p                  ;//:= ver_fname_src_p;				
                    integer   ver_fname_src_pl_pos             ;//:= ver_fname_src_pl_pos;				
                    boolean   ver_fname_src_pl                 ;//:= ver_fname_src_pl;				
                    integer   ver_fname_src_tn_pos             ;//:= ver_fname_src_tn_pos;				
                    boolean   ver_fname_src_tn                 ;//:= ver_fname_src_tn;				
                    integer   ver_fname_src_ts_pos             ;//:= ver_fname_src_ts_pos;				
                    boolean   ver_fname_src_ts                 ;//:= ver_fname_src_ts;				
                    integer   ver_fname_src_tu_pos             ;//:= ver_fname_src_tu_pos;				
                    boolean   ver_fname_src_tu                 ;//:= ver_fname_src_tu;				
                    integer   ver_fname_src_sl_pos             ;//:= ver_fname_src_sl_pos;				
                    boolean   ver_fname_src_sl                 ;//:= ver_fname_src_sl;				
                    integer   ver_fname_src_v_pos              ;//:= ver_fname_src_v_pos;				
                    boolean   ver_fname_src_v                  ;//:= ver_fname_src_v;				
                    integer   ver_fname_src_vo_pos             ;//:= ver_fname_src_vo_pos;				
                    boolean   ver_fname_src_vo                 ;//:= ver_fname_src_vo;				
                    integer   ver_fname_src_w_pos              ;//:= ver_fname_src_w_pos;				
                    boolean   ver_fname_src_w                  ;//:= ver_fname_src_w;				
                    integer   ver_fname_src_wp_pos             ;//:= ver_fname_src_wp_pos;				
                    boolean   ver_fname_src_wp                 ;//:= ver_fname_src_wp;				
                    integer   ver_lname_src_cnt                ;//:= ver_lname_src_cnt;				
                    Boolean   ver_lname_src_pop                ;//:= ver_lname_src_pop;				
                    integer   ver_lname_src_rcnt               ;//:= ver_lname_src_rcnt;				
                    string   ver_lname_src_fsrc               ;//:= ver_lname_src_fsrc;				
                    integer   ver_lname_src_ak_pos             ;//:= ver_lname_src_ak_pos;				
                    boolean   ver_lname_src_ak                 ;//:= ver_lname_src_ak;				
                    integer   ver_lname_src_am_pos             ;//:= ver_lname_src_am_pos;				
                    boolean   ver_lname_src_am                 ;//:= ver_lname_src_am;				
                    integer   ver_lname_src_ar_pos             ;//:= ver_lname_src_ar_pos;				
                    boolean   ver_lname_src_ar                 ;//:= ver_lname_src_ar;				
                    integer   ver_lname_src_ba_pos             ;//:= ver_lname_src_ba_pos;				
                    boolean   ver_lname_src_ba                 ;//:= ver_lname_src_ba;				
                    integer   ver_lname_src_cg_pos             ;//:= ver_lname_src_cg_pos;				
                    boolean   ver_lname_src_cg                 ;//:= ver_lname_src_cg;				
                    integer   ver_lname_src_co_pos             ;//:= ver_lname_src_co_pos;				
                    boolean   ver_lname_src_co                 ;//:= ver_lname_src_co;				
                    integer   ver_lname_src_cy_pos             ;//:= ver_lname_src_cy_pos;				
                    boolean   ver_lname_src_cy                 ;//:= ver_lname_src_cy;				
                    integer   ver_lname_src_da_pos             ;//:= ver_lname_src_da_pos;				
                    boolean   ver_lname_src_da                 ;//:= ver_lname_src_da;				
                    integer   ver_lname_src_d_pos              ;//:= ver_lname_src_d_pos;				
                    boolean   ver_lname_src_d                  ;//:= ver_lname_src_d;				
                    integer   ver_lname_src_dl_pos             ;//:= ver_lname_src_dl_pos;				
                    boolean   ver_lname_src_dl                 ;//:= ver_lname_src_dl;				
                    integer   ver_lname_src_ds_pos             ;//:= ver_lname_src_ds_pos;				
                    boolean   ver_lname_src_ds                 ;//:= ver_lname_src_ds;				
                    integer   ver_lname_src_de_pos             ;//:= ver_lname_src_de_pos;				
                    boolean   ver_lname_src_de                 ;//:= ver_lname_src_de;				
                    integer   ver_lname_src_eb_pos             ;//:= ver_lname_src_eb_pos;				
                    boolean   ver_lname_src_eb                 ;//:= ver_lname_src_eb;				
                    integer   ver_lname_src_em_pos             ;//:= ver_lname_src_em_pos;				
                    boolean   ver_lname_src_em                 ;//:= ver_lname_src_em;				
                    integer   ver_lname_src_e1_pos             ;//:= ver_lname_src_e1_pos;				
                    boolean   ver_lname_src_e1                 ;//:= ver_lname_src_e1;				
                    integer   ver_lname_src_e2_pos             ;//:= ver_lname_src_e2_pos;				
                    boolean   ver_lname_src_e2                 ;//:= ver_lname_src_e2;				
                    integer   ver_lname_src_e3_pos             ;//:= ver_lname_src_e3_pos;				
                    boolean   ver_lname_src_e3                 ;//:= ver_lname_src_e3;				
                    integer   ver_lname_src_e4_pos             ;//:= ver_lname_src_e4_pos;				
                    boolean   ver_lname_src_e4                 ;//:= ver_lname_src_e4;				
                    integer ver_lname_src_en_pos             ;// ver_lname_src_en_pos;				
                    boolean ver_lname_src_en                 ;// ver_lname_src_en;				
                    integer ver_lname_src_eq_pos             ;// ver_lname_src_eq_pos;				
                    boolean ver_lname_src_eq                 ;// ver_lname_src_eq;				
                    integer   ver_lname_src_fe_pos             ;//:= ver_lname_src_fe_pos;				
                    boolean   ver_lname_src_fe                 ;//:= ver_lname_src_fe;				
                    integer   ver_lname_src_ff_pos             ;//:= ver_lname_src_ff_pos;				
                    boolean   ver_lname_src_ff                 ;//:= ver_lname_src_ff;				
                    integer   ver_lname_src_fr_pos             ;//:= ver_lname_src_fr_pos;				
                    boolean   ver_lname_src_fr                 ;//:= ver_lname_src_fr;				
                    integer   ver_lname_src_l2_pos             ;//:= ver_lname_src_l2_pos;				
                    boolean   ver_lname_src_l2                 ;//:= ver_lname_src_l2;				
                    integer   ver_lname_src_li_pos             ;//:= ver_lname_src_li_pos;				
                    boolean   ver_lname_src_li                 ;//:= ver_lname_src_li;				
                    integer   ver_lname_src_mw_pos             ;//:= ver_lname_src_mw_pos;				
                    boolean   ver_lname_src_mw                 ;//:= ver_lname_src_mw;				
                    integer   ver_lname_src_nt_pos             ;//:= ver_lname_src_nt_pos;				
                    boolean   ver_lname_src_nt                 ;//:= ver_lname_src_nt;				
                    integer   ver_lname_src_p_pos              ;//:= ver_lname_src_p_pos;				
                    boolean   ver_lname_src_p                  ;//:= ver_lname_src_p;				
                    boolean   ver_lname_src_pl_pos             ;//:= ver_lname_src_pl_pos;				
                    boolean   ver_lname_src_pl                 ;//:= ver_lname_src_pl;				
                    integer ver_lname_src_tn_pos             ;// ver_lname_src_tn_pos;				
                    boolean ver_lname_src_tn                 ;// ver_lname_src_tn;				
                    integer ver_lname_src_ts_pos             ;// ver_lname_src_ts_pos;				
                    boolean ver_lname_src_ts                 ;// ver_lname_src_ts;				
                    integer ver_lname_src_tu_pos             ;// ver_lname_src_tu_pos;				
                    boolean ver_lname_src_tu                 ;// ver_lname_src_tu;				
                    integer   ver_lname_src_sl_pos             ;//:= ver_lname_src_sl_pos;				
                    boolean   ver_lname_src_sl                 ;//:= ver_lname_src_sl;				
                    integer   ver_lname_src_v_pos              ;//:= ver_lname_src_v_pos;				
                    boolean   ver_lname_src_v                  ;//:= ver_lname_src_v;				
                    integer   ver_lname_src_vo_pos             ;//:= ver_lname_src_vo_pos;				
                    boolean   ver_lname_src_vo                 ;//:= ver_lname_src_vo;				
                    integer   ver_lname_src_w_pos              ;//:= ver_lname_src_w_pos;				
                    boolean   ver_lname_src_w                  ;//:= ver_lname_src_w;				
                    integer   ver_lname_src_wp_pos             ;//:= ver_lname_src_wp_pos;				
                    boolean   ver_lname_src_wp                 ;//:= ver_lname_src_wp;				
                    integer   ver_addr_src_cnt                 ;//:= ver_addr_src_cnt;				
                    boolean   ver_addr_src_pop                 ;//:= ver_addr_src_pop;				
                    integer   ver_addr_src_rcnt                ;//:= ver_addr_src_rcnt;				
                    string   ver_addr_src_fsrc                ;//:= ver_addr_src_fsrc;				
                    integer   ver_addr_src_ak_pos              ;//:= ver_addr_src_ak_pos;				
                    boolean   ver_addr_src_ak                  ;//:= ver_addr_src_ak;				
                    integer   ver_addr_src_am_pos              ;//:= ver_addr_src_am_pos;				
                    boolean   ver_addr_src_am                  ;//:= ver_addr_src_am;				
                    integer   ver_addr_src_ar_pos              ;//:= ver_addr_src_ar_pos;				
                    boolean   ver_addr_src_ar                  ;//:= ver_addr_src_ar;				
                    integer   ver_addr_src_ba_pos              ;//:= ver_addr_src_ba_pos;				
                    boolean   ver_addr_src_ba                  ;//:= ver_addr_src_ba;				
                    integer   ver_addr_src_cg_pos              ;//:= ver_addr_src_cg_pos;				
                    boolean   ver_addr_src_cg                  ;//:= ver_addr_src_cg;				
                    integer   ver_addr_src_co_pos              ;//:= ver_addr_src_co_pos;				
                    boolean   ver_addr_src_co                  ;//:= ver_addr_src_co;				
                    integer   ver_addr_src_cy_pos              ;//:= ver_addr_src_cy_pos;				
                    boolean   ver_addr_src_cy                  ;//:= ver_addr_src_cy;				
                    integer   ver_addr_src_da_pos              ;//:= ver_addr_src_da_pos;				
                    boolean   ver_addr_src_da                  ;//:= ver_addr_src_da;				
                    integer   ver_addr_src_d_pos               ;//:= ver_addr_src_d_pos;				
                    boolean   ver_addr_src_d                   ;//:= ver_addr_src_d;				
                    integer   ver_addr_src_dl_pos              ;//:= ver_addr_src_dl_pos;				
                    boolean   ver_addr_src_dl                  ;//:= ver_addr_src_dl;				
                    integer   ver_addr_src_ds_pos              ;//:= ver_addr_src_ds_pos;				
                    boolean   ver_addr_src_ds                  ;//:= ver_addr_src_ds;				
                    integer   ver_addr_src_de_pos              ;//:= ver_addr_src_de_pos;				
                    boolean   ver_addr_src_de                  ;//:= ver_addr_src_de;				
                    integer   ver_addr_src_eb_pos              ;//:= ver_addr_src_eb_pos;				
                    boolean   ver_addr_src_eb                  ;//:= ver_addr_src_eb;				
                    integer   ver_addr_src_em_pos              ;//:= ver_addr_src_em_pos;				
                    boolean   ver_addr_src_em                  ;//:= ver_addr_src_em;				
                    integer   ver_addr_src_e1_pos              ;//:= ver_addr_src_e1_pos;				
                    boolean   ver_addr_src_e1                  ;//:= ver_addr_src_e1;				
                    integer   ver_addr_src_e2_pos              ;//:= ver_addr_src_e2_pos;				
                    boolean   ver_addr_src_e2                  ;//:= ver_addr_src_e2;				
                    integer   ver_addr_src_e3_pos              ;//:= ver_addr_src_e3_pos;				
                    boolean   ver_addr_src_e3                  ;//:= ver_addr_src_e3;				
                    integer   ver_addr_src_e4_pos              ;//:= ver_addr_src_e4_pos;				
                    boolean   ver_addr_src_e4                  ;//:= ver_addr_src_e4;				
                    integer   ver_addr_src_en_pos              ;//:= ver_addr_src_en_pos;				
                    boolean   ver_addr_src_en                  ;//:= ver_addr_src_en;				
                    integer   ver_addr_src_eq_pos              ;//:= ver_addr_src_eq_pos;				
                    boolean   ver_addr_src_eq                  ;//:= ver_addr_src_eq;				
                    integer   ver_addr_src_fe_pos              ;//:= ver_addr_src_fe_pos;				
                    boolean   ver_addr_src_fe                  ;//:= ver_addr_src_fe;				
                    integer   ver_addr_src_ff_pos              ;//:= ver_addr_src_ff_pos;				
                    boolean   ver_addr_src_ff                  ;//:= ver_addr_src_ff;				
                    integer   ver_addr_src_fr_pos              ;//:= ver_addr_src_fr_pos;				
                    boolean   ver_addr_src_fr                  ;//:= ver_addr_src_fr;				
                    integer   ver_addr_src_l2_pos              ;//:= ver_addr_src_l2_pos;				
                    boolean   ver_addr_src_l2                  ;//:= ver_addr_src_l2;				
                    integer   ver_addr_src_li_pos              ;//:= ver_addr_src_li_pos;				
                    boolean   ver_addr_src_li                  ;//:= ver_addr_src_li;				
                    integer   ver_addr_src_mw_pos              ;//:= ver_addr_src_mw_pos;				
                    boolean   ver_addr_src_mw                  ;//:= ver_addr_src_mw;				
                    integer   ver_addr_src_nt_pos              ;//:= ver_addr_src_nt_pos;				
                    boolean   ver_addr_src_nt                  ;//:= ver_addr_src_nt;				
                    integer   ver_addr_src_p_pos               ;//:= ver_addr_src_p_pos;				
                    boolean   ver_addr_src_p                   ;//:= ver_addr_src_p;				
                    integer   ver_addr_src_pl_pos              ;//:= ver_addr_src_pl_pos;				
                    boolean   ver_addr_src_pl                  ;//:= ver_addr_src_pl;				
                    integer   ver_addr_src_tn_pos              ;//:= ver_addr_src_tn_pos;				
                    boolean   ver_addr_src_tn                  ;//:= ver_addr_src_tn;				
                    integer   ver_addr_src_ts_pos              ;//:= ver_addr_src_ts_pos;				
                    boolean   ver_addr_src_ts                  ;//:= ver_addr_src_ts;				
                    integer   ver_addr_src_tu_pos              ;//:= ver_addr_src_tu_pos;				
                    boolean   ver_addr_src_tu                  ;//:= ver_addr_src_tu;				
                    integer   ver_addr_src_sl_pos              ;//:= ver_addr_src_sl_pos;				
                    boolean   ver_addr_src_sl                  ;//:= ver_addr_src_sl;				
                    integer   ver_addr_src_v_pos               ;//:= ver_addr_src_v_pos;				
                    boolean   ver_addr_src_v                   ;//:= ver_addr_src_v;				
                    integer   ver_addr_src_vo_pos              ;//:= ver_addr_src_vo_pos;				
                    boolean   ver_addr_src_vo                  ;//:= ver_addr_src_vo;				
                    integer   ver_addr_src_w_pos               ;//:= ver_addr_src_w_pos;				
                    boolean   ver_addr_src_w                   ;//:= ver_addr_src_w;				
                    integer   ver_addr_src_wp_pos              ;//:= ver_addr_src_wp_pos;				
                    boolean   ver_addr_src_wp                  ;//:= ver_addr_src_wp;				
                    integer   ver_ssn_src_cnt                  ;//:= ver_ssn_src_cnt;				
                    boolean   ver_ssn_src_pop                  ;//:= ver_ssn_src_pop;				
                    integer   ver_ssn_src_rcnt                 ;//:= ver_ssn_src_rcnt;				
                    string   ver_ssn_src_fsrc                 ;//:= ver_ssn_src_fsrc;				
                    integer   ver_ssn_src_ak_pos               ;//:= ver_ssn_src_ak_pos;				
                    boolean   ver_ssn_src_ak                   ;//:= ver_ssn_src_ak;				
                    integer   ver_ssn_src_am_pos               ;//:= ver_ssn_src_am_pos;				
                    boolean   ver_ssn_src_am                   ;//:= ver_ssn_src_am;				
                    integer   ver_ssn_src_ar_pos               ;//:= ver_ssn_src_ar_pos;				
                    boolean   ver_ssn_src_ar                   ;//:= ver_ssn_src_ar;				
                    integer   ver_ssn_src_ba_pos               ;//:= ver_ssn_src_ba_pos;				
                    boolean   ver_ssn_src_ba                   ;//:= ver_ssn_src_ba;				
                    integer   ver_ssn_src_cg_pos               ;//:= ver_ssn_src_cg_pos;				
                    boolean   ver_ssn_src_cg                   ;//:= ver_ssn_src_cg;				
                    integer   ver_ssn_src_co_pos               ;//:= ver_ssn_src_co_pos;				
                    boolean   ver_ssn_src_co                   ;//:= ver_ssn_src_co;				
                    integer   ver_ssn_src_cy_pos               ;//:= ver_ssn_src_cy_pos;				
                    boolean   ver_ssn_src_cy                   ;//:= ver_ssn_src_cy;				
                    integer   ver_ssn_src_da_pos               ;//:= ver_ssn_src_da_pos;				
                    boolean   ver_ssn_src_da                   ;//:= ver_ssn_src_da;				
                    integer   ver_ssn_src_d_pos                ;//:= ver_ssn_src_d_pos;				
                    boolean   ver_ssn_src_d                    ;//:= ver_ssn_src_d;				
                    integer   ver_ssn_src_dl_pos               ;//:= ver_ssn_src_dl_pos;				
                    boolean   ver_ssn_src_dl                   ;//:= ver_ssn_src_dl;				
                    integer   ver_ssn_src_ds_pos               ;//:= ver_ssn_src_ds_pos;				
                    boolean   ver_ssn_src_ds                   ;//:= ver_ssn_src_ds;				
                    integer   ver_ssn_src_de_pos               ;//:= ver_ssn_src_de_pos;				
                    boolean   ver_ssn_src_de                   ;//:= ver_ssn_src_de;				
                    integer   ver_ssn_src_eb_pos               ;//:= ver_ssn_src_eb_pos;				
                    boolean   ver_ssn_src_eb                   ;//:= ver_ssn_src_eb;				
                    integer   ver_ssn_src_em_pos               ;//:= ver_ssn_src_em_pos;				
                    boolean   ver_ssn_src_em                   ;//:= ver_ssn_src_em;				
                    integer   ver_ssn_src_e1_pos               ;//:= ver_ssn_src_e1_pos;				
                    boolean   ver_ssn_src_e1                   ;//:= ver_ssn_src_e1;				
                    integer   ver_ssn_src_e2_pos               ;//:= ver_ssn_src_e2_pos;				
                    boolean   ver_ssn_src_e2                   ;//:= ver_ssn_src_e2;				
                    integer   ver_ssn_src_e3_pos               ;//:= ver_ssn_src_e3_pos;				
                    boolean   ver_ssn_src_e3                   ;//:= ver_ssn_src_e3;				
                    integer   ver_ssn_src_e4_pos               ;//:= ver_ssn_src_e4_pos;				
                    boolean   ver_ssn_src_e4                   ;//:= ver_ssn_src_e4;				
                    integer   ver_ssn_src_en_pos               ;//:= ver_ssn_src_en_pos;				
                    boolean   ver_ssn_src_en                   ;//:= ver_ssn_src_en;				
                    integer   ver_ssn_src_eq_pos               ;//:= ver_ssn_src_eq_pos;				
                    boolean   ver_ssn_src_eq                   ;//:= ver_ssn_src_eq;				
                    integer   ver_ssn_src_fe_pos               ;//:= ver_ssn_src_fe_pos;				
                    boolean   ver_ssn_src_fe                   ;//:= ver_ssn_src_fe;				
                    integer   ver_ssn_src_ff_pos               ;//:= ver_ssn_src_ff_pos;				
                    boolean   ver_ssn_src_ff                   ;//:= ver_ssn_src_ff;				
                    integer   ver_ssn_src_fr_pos               ;//:= ver_ssn_src_fr_pos;				
                    boolean   ver_ssn_src_fr                   ;//:= ver_ssn_src_fr;				
                    integer   ver_ssn_src_l2_pos               ;//:= ver_ssn_src_l2_pos;				
                    boolean   ver_ssn_src_l2                   ;//:= ver_ssn_src_l2;				
                    integer   ver_ssn_src_li_pos               ;//:= ver_ssn_src_li_pos;				
                    boolean   ver_ssn_src_li                   ;//:= ver_ssn_src_li;				
                    integer   ver_ssn_src_mw_pos               ;//:= ver_ssn_src_mw_pos;				
                    boolean   ver_ssn_src_mw                   ;//:= ver_ssn_src_mw;				
                    integer   ver_ssn_src_nt_pos               ;//:= ver_ssn_src_nt_pos;				
                    boolean   ver_ssn_src_nt                   ;//:= ver_ssn_src_nt;				
                    integer   ver_ssn_src_p_pos                ;//:= ver_ssn_src_p_pos;				
                    boolean   ver_ssn_src_p                    ;//:= ver_ssn_src_p;				
                    integer   ver_ssn_src_pl_pos               ;//:= ver_ssn_src_pl_pos;				
                    boolean   ver_ssn_src_pl                   ;//:= ver_ssn_src_pl;				
                    integer   ver_ssn_src_tn_pos               ;//:= ver_ssn_src_tn_pos;				
                    boolean   ver_ssn_src_tn                   ;//:= ver_ssn_src_tn;				
                    integer   ver_ssn_src_ts_pos               ;//:= ver_ssn_src_ts_pos;				
                    boolean   ver_ssn_src_ts                   ;//:= ver_ssn_src_ts;				
                    integer   ver_ssn_src_tu_pos               ;//:= ver_ssn_src_tu_pos;				
                    boolean   ver_ssn_src_tu                   ;//:= ver_ssn_src_tu;				
                    integer   ver_ssn_src_sl_pos               ;//:= ver_ssn_src_sl_pos;				
                    boolean   ver_ssn_src_sl                   ;//:= ver_ssn_src_sl;				
                    integer   ver_ssn_src_v_pos                ;//:= ver_ssn_src_v_pos;				
                    boolean   ver_ssn_src_v                    ;//:= ver_ssn_src_v;				
                    integer   ver_ssn_src_vo_pos               ;//:= ver_ssn_src_vo_pos;				
                    boolean   ver_ssn_src_vo                   ;//:= ver_ssn_src_vo;				
                    integer   ver_ssn_src_w_pos                ;//:= ver_ssn_src_w_pos;				
                    boolean   ver_ssn_src_w                    ;//:= ver_ssn_src_w;				
                    integer   ver_ssn_src_wp_pos               ;//:= ver_ssn_src_wp_pos;				
                    boolean   ver_ssn_src_wp                   ;//:= ver_ssn_src_wp;				
                    integer   ver_dob_src_cnt                  ;//:= ver_dob_src_cnt;				
                    boolean   ver_dob_src_pop                  ;//:= ver_dob_src_pop;				
                    integer   ver_dob_src_rcnt                 ;//:= ver_dob_src_rcnt;				
                    string   ver_dob_src_fsrc                 ;//:= ver_dob_src_fsrc;				
                    integer   ver_dob_src_ak_pos               ;//:= ver_dob_src_ak_pos;				
                    boolean   ver_dob_src_ak                   ;//:= ver_dob_src_ak;				
                    integer   ver_dob_src_am_pos               ;//:= ver_dob_src_am_pos;				
                    boolean   ver_dob_src_am                   ;//:= ver_dob_src_am;				
                    integer   ver_dob_src_ar_pos               ;//:= ver_dob_src_ar_pos;				
                    boolean   ver_dob_src_ar                   ;//:= ver_dob_src_ar;				
                    integer   ver_dob_src_ba_pos               ;//:= ver_dob_src_ba_pos;				
                    boolean   ver_dob_src_ba                   ;//:= ver_dob_src_ba;				
                    integer   ver_dob_src_cg_pos               ;//:= ver_dob_src_cg_pos;				
                    boolean   ver_dob_src_cg                   ;//:= ver_dob_src_cg;				
                    integer   ver_dob_src_co_pos               ;//:= ver_dob_src_co_pos;				
                    boolean   ver_dob_src_co                   ;//:= ver_dob_src_co;				
                    integer   ver_dob_src_cy_pos               ;//:= ver_dob_src_cy_pos;				
                    boolean   ver_dob_src_cy                   ;//:= ver_dob_src_cy;				
                    integer   ver_dob_src_da_pos               ;//:= ver_dob_src_da_pos;				
                    boolean   ver_dob_src_da                   ;//:= ver_dob_src_da;				
                    integer   ver_dob_src_d_pos                ;//:= ver_dob_src_d_pos;				
                    boolean   ver_dob_src_d                    ;//:= ver_dob_src_d;				
                    integer   ver_dob_src_dl_pos               ;//:= ver_dob_src_dl_pos;				
                    boolean   ver_dob_src_dl                   ;//:= ver_dob_src_dl;				
                    integer   ver_dob_src_ds_pos               ;//:= ver_dob_src_ds_pos;				
                    boolean   ver_dob_src_ds                   ;//:= ver_dob_src_ds;				
                    integer   ver_dob_src_de_pos               ;//:= ver_dob_src_de_pos;				
                    boolean   ver_dob_src_de                   ;//:= ver_dob_src_de;				
                    integer   ver_dob_src_eb_pos               ;//:= ver_dob_src_eb_pos;				
                    boolean   ver_dob_src_eb                   ;//:= ver_dob_src_eb;				
                    integer   ver_dob_src_em_pos               ;//:= ver_dob_src_em_pos;				
                    boolean   ver_dob_src_em                   ;//:= ver_dob_src_em;				
                    integer   ver_dob_src_e1_pos               ;//:= ver_dob_src_e1_pos;				
                    boolean   ver_dob_src_e1                   ;//:= ver_dob_src_e1;				
                    integer   ver_dob_src_e2_pos               ;//:= ver_dob_src_e2_pos;				
                    boolean   ver_dob_src_e2                   ;//:= ver_dob_src_e2;				
                    integer   ver_dob_src_e3_pos               ;//:= ver_dob_src_e3_pos;				
                    boolean   ver_dob_src_e3                   ;//:= ver_dob_src_e3;				
                    integer   ver_dob_src_e4_pos               ;//:= ver_dob_src_e4_pos;				
                    boolean   ver_dob_src_e4                   ;//:= ver_dob_src_e4;				
                    integer   ver_dob_src_en_pos               ;//:= ver_dob_src_en_pos;				
                    boolean   ver_dob_src_en                   ;//:= ver_dob_src_en;				
                    integer   ver_dob_src_eq_pos               ;//:= ver_dob_src_eq_pos;				
                    boolean   ver_dob_src_eq                   ;//:= ver_dob_src_eq;				
                    integer   ver_dob_src_fe_pos               ;//:= ver_dob_src_fe_pos;				
                    boolean   ver_dob_src_fe                   ;//:= ver_dob_src_fe;				
                    integer   ver_dob_src_ff_pos               ;//:= ver_dob_src_ff_pos;				
                    boolean   ver_dob_src_ff                   ;//:= ver_dob_src_ff;				
                    integer   ver_dob_src_fr_pos               ;//:= ver_dob_src_fr_pos;				
                    boolean   ver_dob_src_fr                   ;//:= ver_dob_src_fr;				
                    integer   ver_dob_src_l2_pos               ;//:= ver_dob_src_l2_pos;				
                    boolean   ver_dob_src_l2                   ;//:= ver_dob_src_l2;				
                    integer   ver_dob_src_li_pos               ;//:= ver_dob_src_li_pos;				
                    boolean   ver_dob_src_li                   ;//:= ver_dob_src_li;				
                    integer   ver_dob_src_mw_pos               ;//:= ver_dob_src_mw_pos;				
                    boolean   ver_dob_src_mw                   ;//:= ver_dob_src_mw;				
                    integer   ver_dob_src_nt_pos               ;//:= ver_dob_src_nt_pos;				
                    boolean   ver_dob_src_nt                   ;//:= ver_dob_src_nt;				
                    integer   ver_dob_src_p_pos                ;//:= ver_dob_src_p_pos;				
                    boolean   ver_dob_src_p                    ;//:= ver_dob_src_p;				
                    integer   ver_dob_src_pl_pos               ;//:= ver_dob_src_pl_pos;				
                    boolean   ver_dob_src_pl                   ;//:= ver_dob_src_pl;				
                    integer   ver_dob_src_tn_pos               ;//:= ver_dob_src_tn_pos;				
                    boolean   ver_dob_src_tn                   ;//:= ver_dob_src_tn;				
                    integer   ver_dob_src_ts_pos               ;//:= ver_dob_src_ts_pos;				
                    boolean   ver_dob_src_ts                   ;//:= ver_dob_src_ts;				
                    integer   ver_dob_src_tu_pos               ;//:= ver_dob_src_tu_pos;				
                    boolean   ver_dob_src_tu                   ;//:= ver_dob_src_tu;				
                    integer   ver_dob_src_sl_pos               ;//:= ver_dob_src_sl_pos;				
                    boolean   ver_dob_src_sl                   ;//:= ver_dob_src_sl;				
                    integer   ver_dob_src_v_pos                ;//:= ver_dob_src_v_pos;				
                    boolean   ver_dob_src_v                    ;//:= ver_dob_src_v;				
                    integer   ver_dob_src_vo_pos               ;//:= ver_dob_src_vo_pos;				
                    boolean   ver_dob_src_vo                   ;//:= ver_dob_src_vo;				
                    integer   ver_dob_src_w_pos                ;//:= ver_dob_src_w_pos;				
                    boolean   ver_dob_src_w                    ;//:= ver_dob_src_w;				
                    integer   ver_dob_src_wp_pos               ;//:= ver_dob_src_wp_pos;				
                    boolean   ver_dob_src_wp                   ;//:= ver_dob_src_wp;				
                    integer   email_src_cnt                    ;//:= email_src_cnt;				
                    boolean   email_src_pop                    ;//:= email_src_pop;				
                    integer   email_src_rcnt                   ;//:= email_src_rcnt;				
                    string   email_src_fsrc                   ;//:= email_src_fsrc;				
                    integer   email_src_aw_pos                 ;//:= email_src_aw_pos;				
                    boolean   email_src_aw                     ;//:= email_src_aw;				
                    integer   email_src_et_pos                 ;//:= email_src_et_pos;				
                    boolean   email_src_et                     ;//:= email_src_et;				
                    integer   email_src_wa_pos                 ;//:= email_src_wa_pos;				
                    boolean   email_src_wa                     ;//:= email_src_wa;				
                    integer   email_src_om_pos                 ;//:= email_src_om_pos;				
                    boolean   email_src_om                     ;//:= email_src_om;				
                    integer   email_src_m1_pos                 ;//:= email_src_m1_pos;				
                    boolean   email_src_m1                     ;//:= email_src_m1;				
                    integer   email_src_sc_pos                 ;//:= email_src_sc_pos;				
                    boolean   email_src_sc                     ;//:= email_src_sc;				
                    integer   email_src_dg_pos                 ;//:= email_src_dg_pos;				
                    boolean   email_src_dg                     ;//:= email_src_dg;				
                    integer   util_type_cnt                    ;//:= util_type_cnt;				
                    boolean   util_type_pop                    ;//:= util_type_pop;				
                    boolean   util_type_rcnt                   ;//:= util_type_rcnt;				
                    string   util_type_fsrc                   ;//:= util_type_fsrc;				
                    integer   util_type_2_pos                  ;//:= util_type_2_pos;				
                    boolean   util_type_2                      ;//:= util_type_2;				
                    integer   util_type_1_pos                  ;//:= util_type_1_pos;				
                    boolean   util_type_1                      ;//:= util_type_1;				
                    integer   util_type_z_pos                  ;//:= util_type_z_pos;				
                    boolean   util_type_z                      ;//:= util_type_z;				
                    integer   util_inp_cnt                     ;//:= util_inp_cnt;				
                    boolean   util_inp_pop                     ;//:= util_inp_pop;				
                    integer   util_inp_rcnt                    ;//:= util_inp_rcnt;				
                    string   util_inp_fsrc                    ;//:= util_inp_fsrc;				
                    integer   util_inp_2_pos                   ;//:= util_inp_2_pos;				
                    boolean   util_inp_2                       ;//:= util_inp_2;				
                    integer   util_inp_1_pos                   ;//:= util_inp_1_pos;				
                    boolean   util_inp_1                       ;//:= util_inp_1;				
                    integer   util_inp_z_pos                   ;//:= util_inp_z_pos;				
                    boolean   util_inp_z                       ;//:= util_inp_z;				
                    integer   util_curr_cnt                    ;//:= util_curr_cnt;				
                    boolean   util_curr_pop                    ;//:= util_curr_pop;				
                    integer   util_curr_rcnt                   ;//:= util_curr_rcnt;				
                    string   util_curr_fsrc                   ;//:= util_curr_fsrc;				
                    integer   util_curr_2_pos                  ;//:= util_curr_2_pos;				
                    boolean   util_curr_2                      ;//:= util_curr_2;				
                    integer   util_curr_1_pos                  ;//:= util_curr_1_pos;				
                    boolean   util_curr_1                      ;//:= util_curr_1;				
                    integer   util_curr_z_pos                  ;//:= util_curr_z_pos;				
                    boolean   util_curr_z                      ;//:= util_curr_z;				
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
                    DECIMAL21_1 rv_c12_source_profile            ;// rv_c12_source_profile;				
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
	ver_fname_sources                := le.header_summary.ver_fname_sources;
  ver_lname_sources                := le.header_summary.ver_lname_sources;
  ver_addr_sources                 := le.header_summary.ver_addr_sources;
  ver_ssn_sources                  := le.header_summary.ver_ssn_sources;
  ver_dob_sources                  := le.header_summary.ver_dob_sources;
	input_fname_isbestmatch          := le.best_flags.input_fname_isbestmatch;
	input_lname_isbestmatch          := le.best_flags.input_lname_isbestmatch;
	best_ssn_ssndobflag              := le.best_flags.best_ssn_ssndobflag;
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
  util_adl_type_list               := le.utility.utili_adl_type;
  util_add_input_type_list         := le.utility.utili_addr1_type;
  util_add_curr_type_list          := le.utility.utili_addr2_type;
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
	inq_fnamesperadl                 := le.acc_logs.inquiryfnamesperadl;
	inq_addrsperadl_count01          := le.acc_logs.inq_addrsperadl_count01;
	inq_addrsperadl_count03          := le.acc_logs.inq_addrsperadl_count03;
	inq_addrsperadl_count06          := le.acc_logs.inq_addrsperadl_count06;
	inq_fnamesperadl_count01         := le.acc_logs.inq_fnamesperadl_count01;
	inq_fnamesperadl_count03         := le.acc_logs.inq_fnamesperadl_count03;
	inq_fnamesperadl_count06         := le.acc_logs.inq_fnamesperadl_count06;
  inq_phonesperadl                 := le.acc_logs.inquiryphonesperadl;
	inq_dobsperadl                   := le.acc_logs.inquirydobsperadl;
	br_first_seen                    := le.employment.first_seen_date;
	br_dead_business_count           := le.employment.dead_business_ct;
	br_active_phone_count            := le.employment.business_active_phone_ct;
	br_source_count                  := le.employment.source_ct;
	infutor_nap                      := le.infutor_phone.infutor_nap;
	stl_inq_count24                  := le.impulse.count24;
	email_source_list                := le.email_summary.email_source_list;
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


sysdate := __common__(common.sas_date(if(le.historydate=999999, (string8)STD.Date.today(), (string6)le.historydate+'01')));

ver_src_cnt := Models.Common.countw((string)(ver_sources), ' !$%&()*+,-./;<^|');

ver_src_pop := ver_src_cnt > 0;

ver_src_rcnt_37 := 0;

ver_src_fsrc := Models.Common.getw(ver_sources, 1);

ver_src_fsrc_fdate := Models.Common.getw(ver_sources_first_seen, 1);

ver_src_fsrc_fdate2 := common.sas_date((string)(ver_src_fsrc_fdate));

yr_ver_src_fsrc_fdate := if(min(sysdate, ver_src_fsrc_fdate2) = NULL, NULL, (sysdate - ver_src_fsrc_fdate2) / 365.25);

mth_ver_src_fsrc_fdate := if(min(sysdate, ver_src_fsrc_fdate2) = NULL, NULL, (sysdate - ver_src_fsrc_fdate2) / 30.5);


ver_src_ak_pos :=  __common__(Models.Common.findw_cpp(ver_sources, 'AK' , '  ,', 'ie'));

ver_src_ak :=  __common__(ver_src_ak_pos > 0);

_ver_src_fdate_ak :=  __common__(if(ver_src_ak_pos > 0, Models.Common.getw(ver_sources_first_seen, ver_src_ak_pos), '0'));

ver_src_fdate_ak :=  __common__(common.sas_date((string)(_ver_src_fdate_ak)));


_ver_src_ldate_ak := if(ver_src_ak_pos > 0, Models.Common.getw(ver_sources_last_seen, ver_src_ak_pos), '0');

ver_src_ldate_ak := common.sas_date((string)(_ver_src_ldate_ak));

ver_src_cnt_ak := if(ver_src_ak_pos > 0, (real)Models.Common.getw(ver_sources_count, ver_src_ak_pos), 0);

ver_src_rcnt_36 := ver_src_rcnt_37 + ver_src_cnt_ak;


ver_src_am_pos :=  __common__(Models.Common.findw_cpp(ver_sources, 'AM' , '  ,', 'ie'));

ver_src_am :=  __common__(ver_src_am_pos > 0);

_ver_src_fdate_am :=  __common__(if(ver_src_am_pos > 0, Models.Common.getw(ver_sources_first_seen, ver_src_am_pos), '0'));

ver_src_fdate_am :=  __common__(common.sas_date((string)(_ver_src_fdate_am)));



_ver_src_ldate_am := if(ver_src_am_pos > 0, Models.Common.getw(ver_sources_last_seen, ver_src_am_pos), '0');

ver_src_ldate_am := common.sas_date((string)(_ver_src_ldate_am));

ver_src_cnt_am := if(ver_src_am_pos > 0, (real)Models.Common.getw(ver_sources_count, ver_src_am_pos), 0);

ver_src_rcnt_35 := ver_src_rcnt_36 + ver_src_cnt_am;



ver_src_ar_pos :=  __common__(Models.Common.findw_cpp(ver_sources, 'AR' , '  ,', 'ie'));

ver_src_ar :=  __common__(ver_src_ar_pos > 0);

_ver_src_fdate_ar :=  __common__(if(ver_src_ar_pos > 0, Models.Common.getw(ver_sources_first_seen, ver_src_ar_pos), '0'));

ver_src_fdate_ar :=  __common__(common.sas_date((string)(_ver_src_fdate_ar)));


_ver_src_ldate_ar := if(ver_src_ar_pos > 0, Models.Common.getw(ver_sources_last_seen, ver_src_ar_pos), '0');

ver_src_ldate_ar := common.sas_date((string)(_ver_src_ldate_ar));

ver_src_cnt_ar := if(ver_src_ar_pos > 0, (real)Models.Common.getw(ver_sources_count, ver_src_ar_pos), 0);

ver_src_rcnt_34 := ver_src_rcnt_35 + ver_src_cnt_ar;



ver_src_ba_pos :=  __common__(Models.Common.findw_cpp(ver_sources, 'BA' , '  ,', 'ie'));

ver_src_ba :=  __common__(ver_src_ba_pos > 0);

_ver_src_fdate_ba :=  __common__(if(ver_src_ba_pos > 0, Models.Common.getw(ver_sources_first_seen, ver_src_ba_pos), '0'));

ver_src_fdate_ba :=  __common__(common.sas_date((string)(_ver_src_fdate_ba)));



_ver_src_ldate_ba := if(ver_src_ba_pos > 0, Models.Common.getw(ver_sources_last_seen, ver_src_ba_pos), '0');

ver_src_ldate_ba := common.sas_date((string)(_ver_src_ldate_ba));

ver_src_cnt_ba := if(ver_src_ba_pos > 0, (real)Models.Common.getw(ver_sources_count, ver_src_ba_pos), 0);

ver_src_rcnt_33 := ver_src_rcnt_34 + ver_src_cnt_ba;


ver_src_cg_pos :=  __common__(Models.Common.findw_cpp(ver_sources, 'CG' , '  ,', 'ie'));

ver_src_cg :=  __common__(ver_src_cg_pos > 0);

_ver_src_fdate_cg :=  __common__(if(ver_src_cg_pos > 0, Models.Common.getw(ver_sources_first_seen, ver_src_cg_pos), '0'));

ver_src_fdate_cg :=  __common__(common.sas_date((string)(_ver_src_fdate_cg)));


_ver_src_ldate_cg := if(ver_src_cg_pos > 0, Models.Common.getw(ver_sources_last_seen, ver_src_cg_pos), '0');

ver_src_ldate_cg := common.sas_date((string)(_ver_src_ldate_cg));

ver_src_cnt_cg := if(ver_src_cg_pos > 0, (real)Models.Common.getw(ver_sources_count, ver_src_cg_pos), 0);

ver_src_rcnt_32 := ver_src_rcnt_33 + ver_src_cnt_cg;


ver_src_co_pos :=  __common__(Models.Common.findw_cpp(ver_sources, 'CO' , '  ,', 'ie'));

ver_src_co := ver_src_co_pos > 0;

_ver_src_fdate_co :=  __common__(if(ver_src_co_pos > 0, Models.Common.getw(ver_sources_first_seen, ver_src_co_pos), '0'));

ver_src_fdate_co :=  __common__(common.sas_date((string)(_ver_src_fdate_co)));



_ver_src_ldate_co := if(ver_src_co_pos > 0, Models.Common.getw(ver_sources_last_seen, ver_src_co_pos), '0');

ver_src_ldate_co := common.sas_date((string)(_ver_src_ldate_co));

ver_src_cnt_co := if(ver_src_co_pos > 0, (real)Models.Common.getw(ver_sources_count, ver_src_co_pos), 0);

ver_src_rcnt_31 := ver_src_rcnt_32 + ver_src_cnt_co;



ver_src_cy_pos :=  __common__(Models.Common.findw_cpp(ver_sources, 'CY' , '  ,', 'ie'));

ver_src_cy :=  __common__(ver_src_cy_pos > 0);

_ver_src_fdate_cy :=  __common__(if(ver_src_cy_pos > 0, Models.Common.getw(ver_sources_first_seen, ver_src_cy_pos), '0'));

ver_src_fdate_cy :=  __common__(common.sas_date((string)(_ver_src_fdate_cy)));



_ver_src_ldate_cy := if(ver_src_cy_pos > 0, Models.Common.getw(ver_sources_last_seen, ver_src_cy_pos), '0');

ver_src_ldate_cy := common.sas_date((string)(_ver_src_ldate_cy));

ver_src_cnt_cy := if(ver_src_cy_pos > 0, (real)Models.Common.getw(ver_sources_count, ver_src_cy_pos), 0);

ver_src_rcnt_30 := ver_src_rcnt_31 + ver_src_cnt_cy;


ver_src_da_pos :=  __common__(Models.Common.findw_cpp(ver_sources, 'DA' , '  ,', 'ie'));

ver_src_da :=  __common__(ver_src_da_pos > 0);

_ver_src_fdate_da :=  __common__(if(ver_src_da_pos > 0, Models.Common.getw(ver_sources_first_seen, ver_src_da_pos), '0'));

ver_src_fdate_da :=  __common__(common.sas_date((string)(_ver_src_fdate_da)));


_ver_src_ldate_da := if(ver_src_da_pos > 0, Models.Common.getw(ver_sources_last_seen, ver_src_da_pos), '0');

ver_src_ldate_da := common.sas_date((string)(_ver_src_ldate_da));

ver_src_cnt_da := if(ver_src_da_pos > 0, (real)Models.Common.getw(ver_sources_count, ver_src_da_pos), 0);

ver_src_rcnt_29 := ver_src_rcnt_30 + ver_src_cnt_da;


ver_src_d_pos :=  __common__(Models.Common.findw_cpp(ver_sources, 'D' , '  ,', 'ie'));

ver_src_d :=  __common__(ver_src_d_pos > 0);

_ver_src_fdate_d :=  __common__(if(ver_src_d_pos > 0, Models.Common.getw(ver_sources_first_seen, ver_src_d_pos), '0'));

ver_src_fdate_d :=  __common__(common.sas_date((string)(_ver_src_fdate_d)));



_ver_src_ldate_d := if(ver_src_d_pos > 0, Models.Common.getw(ver_sources_last_seen, ver_src_d_pos), '0');

ver_src_ldate_d := common.sas_date((string)(_ver_src_ldate_d));

ver_src_cnt_d := if(ver_src_d_pos > 0, (real)Models.Common.getw(ver_sources_count, ver_src_d_pos), 0);

ver_src_rcnt_28 := ver_src_rcnt_29 + ver_src_cnt_d;


ver_src_dl_pos :=  __common__(Models.Common.findw_cpp(ver_sources, 'DL' , '  ,', 'ie'));

ver_src_dl :=  __common__(ver_src_dl_pos > 0);

_ver_src_fdate_dl :=  __common__(if(ver_src_dl_pos > 0, Models.Common.getw(ver_sources_first_seen, ver_src_dl_pos), '0'));

ver_src_fdate_dl :=  __common__(common.sas_date((string)(_ver_src_fdate_dl)));

_ver_src_ldate_dl := if(ver_src_dl_pos > 0, Models.Common.getw(ver_sources_last_seen, ver_src_dl_pos), '0');

ver_src_ldate_dl := common.sas_date((string)(_ver_src_ldate_dl));

ver_src_cnt_dl := if(ver_src_dl_pos > 0, (real)Models.Common.getw(ver_sources_count, ver_src_dl_pos), 0);

ver_src_rcnt_27 := ver_src_rcnt_28 + ver_src_cnt_dl;



ver_src_ds_pos :=  __common__(Models.Common.findw_cpp(ver_sources, 'DS' , '  ,', 'ie'));

ver_src_ds :=  __common__(ver_src_ds_pos > 0);

_ver_src_fdate_ds :=  __common__(if(ver_src_ds_pos > 0, Models.Common.getw(ver_sources_first_seen, ver_src_ds_pos), '0'));

ver_src_fdate_ds :=  __common__(common.sas_date((string)(_ver_src_fdate_ds)));

_ver_src_ldate_ds := if(ver_src_ds_pos > 0, Models.Common.getw(ver_sources_last_seen, ver_src_ds_pos), '0');

ver_src_ldate_ds := common.sas_date((string)(_ver_src_ldate_ds));

ver_src_cnt_ds := if(ver_src_ds_pos > 0, (real)Models.Common.getw(ver_sources_count, ver_src_ds_pos), 0);

ver_src_rcnt_26 := ver_src_rcnt_27 + ver_src_cnt_ds;




ver_src_de_pos :=  __common__(Models.Common.findw_cpp(ver_sources, 'DE' , '  ,', 'ie'));

ver_src_de :=  __common__(ver_src_de_pos > 0);

_ver_src_fdate_de :=  __common__(if(ver_src_de_pos > 0, Models.Common.getw(ver_sources_first_seen, ver_src_de_pos), '0'));

ver_src_fdate_de :=  __common__(common.sas_date((string)(_ver_src_fdate_de)));



_ver_src_ldate_de := if(ver_src_de_pos > 0, Models.Common.getw(ver_sources_last_seen, ver_src_de_pos), '0');

ver_src_ldate_de := common.sas_date((string)(_ver_src_ldate_de));

ver_src_cnt_de := if(ver_src_de_pos > 0, (real)Models.Common.getw(ver_sources_count, ver_src_de_pos), 0);

ver_src_rcnt_25 := ver_src_rcnt_26 + ver_src_cnt_de;


ver_src_eb_pos :=  __common__(Models.Common.findw_cpp(ver_sources, 'EB' , '  ,', 'ie'));

ver_src_eb :=  __common__(ver_src_eb_pos > 0);

_ver_src_fdate_eb :=  __common__(if(ver_src_eb_pos > 0, Models.Common.getw(ver_sources_first_seen, ver_src_eb_pos), '0'));

ver_src_fdate_eb :=  __common__(common.sas_date((string)(_ver_src_fdate_eb)));


_ver_src_ldate_eb := if(ver_src_eb_pos > 0, Models.Common.getw(ver_sources_last_seen, ver_src_eb_pos), '0');

ver_src_ldate_eb := common.sas_date((string)(_ver_src_ldate_eb));

ver_src_cnt_eb := if(ver_src_eb_pos > 0, (real)Models.Common.getw(ver_sources_count, ver_src_eb_pos), 0);

ver_src_rcnt_24 := ver_src_rcnt_25 + ver_src_cnt_eb;


ver_src_em_pos :=  __common__(Models.Common.findw_cpp(ver_sources, 'EM' , '  ,', 'ie'));

ver_src_em :=  __common__(ver_src_em_pos > 0);

_ver_src_fdate_em :=  __common__(if(ver_src_em_pos > 0, Models.Common.getw(ver_sources_first_seen, ver_src_em_pos), '0'));

ver_src_fdate_em :=  __common__(common.sas_date((string)(_ver_src_fdate_em)));




_ver_src_ldate_em := if(ver_src_em_pos > 0, Models.Common.getw(ver_sources_last_seen, ver_src_em_pos), '0');

ver_src_ldate_em := common.sas_date((string)(_ver_src_ldate_em));

ver_src_cnt_em := if(ver_src_em_pos > 0, (real)Models.Common.getw(ver_sources_count, ver_src_em_pos), 0);

ver_src_rcnt_23 := ver_src_rcnt_24 + ver_src_cnt_em;



ver_src_e1_pos :=  __common__(Models.Common.findw_cpp(ver_sources, 'E1' , '  ,', 'ie'));
ver_src_e1 :=  __common__(ver_src_e1_pos > 0);

_ver_src_fdate_e1 :=  __common__(if(ver_src_e1_pos > 0, Models.Common.getw(ver_sources_first_seen, ver_src_e1_pos), '0'));

ver_src_fdate_e1 :=  __common__(common.sas_date((string)(_ver_src_fdate_e1)));


_ver_src_ldate_e1 := if(ver_src_e1_pos > 0, Models.Common.getw(ver_sources_last_seen, ver_src_e1_pos), '0');

ver_src_ldate_e1 := common.sas_date((string)(_ver_src_ldate_e1));

ver_src_cnt_e1 := if(ver_src_e1_pos > 0, (real)Models.Common.getw(ver_sources_count, ver_src_e1_pos), 0);

ver_src_rcnt_22 := ver_src_rcnt_23 + ver_src_cnt_e1;


ver_src_e2_pos :=  __common__(Models.Common.findw_cpp(ver_sources, 'E2' , '  ,', 'ie'));

ver_src_e2 :=  __common__(ver_src_e2_pos > 0);

_ver_src_fdate_e2 :=  __common__(if(ver_src_e2_pos > 0, Models.Common.getw(ver_sources_first_seen, ver_src_e2_pos), '0'));

ver_src_fdate_e2 :=  __common__(common.sas_date((string)(_ver_src_fdate_e2)));


_ver_src_ldate_e2 := if(ver_src_e2_pos > 0, Models.Common.getw(ver_sources_last_seen, ver_src_e2_pos), '0');

ver_src_ldate_e2 := common.sas_date((string)(_ver_src_ldate_e2));

ver_src_cnt_e2 := if(ver_src_e2_pos > 0, (real)Models.Common.getw(ver_sources_count, ver_src_e2_pos), 0);

ver_src_rcnt_21 := ver_src_rcnt_22 + ver_src_cnt_e2;


ver_src_e3_pos :=  __common__(Models.Common.findw_cpp(ver_sources, 'E3' , '  ,', 'ie'));

ver_src_e3 :=  __common__(ver_src_e3_pos > 0);

_ver_src_fdate_e3 :=  __common__(if(ver_src_e3_pos > 0, Models.Common.getw(ver_sources_first_seen, ver_src_e3_pos), '0'));

ver_src_fdate_e3 :=  __common__(common.sas_date((string)(_ver_src_fdate_e3)));




_ver_src_ldate_e3 := if(ver_src_e3_pos > 0, Models.Common.getw(ver_sources_last_seen, ver_src_e3_pos), '0');

ver_src_ldate_e3 := common.sas_date((string)(_ver_src_ldate_e3));

ver_src_cnt_e3 := if(ver_src_e3_pos > 0, (real)Models.Common.getw(ver_sources_count, ver_src_e3_pos), 0);

ver_src_rcnt_20 := ver_src_rcnt_21 + ver_src_cnt_e3;


ver_src_e4_pos :=  __common__(Models.Common.findw_cpp(ver_sources, 'E4' , '  ,', 'ie'));

ver_src_e4 :=  __common__(ver_src_e4_pos > 0);

_ver_src_fdate_e4 :=  __common__(if(ver_src_e4_pos > 0, Models.Common.getw(ver_sources_first_seen, ver_src_e4_pos), '0'));

ver_src_fdate_e4 :=  __common__(common.sas_date((string)(_ver_src_fdate_e4)));


_ver_src_ldate_e4 := if(ver_src_e4_pos > 0, Models.Common.getw(ver_sources_last_seen, ver_src_e4_pos), '0');

ver_src_ldate_e4 := common.sas_date((string)(_ver_src_ldate_e4));

ver_src_cnt_e4 := if(ver_src_e4_pos > 0, (real)Models.Common.getw(ver_sources_count, ver_src_e4_pos), 0);

ver_src_rcnt_19 := ver_src_rcnt_20 + ver_src_cnt_e4;


ver_src_en_pos :=  __common__(Models.Common.findw_cpp(ver_sources, 'EN' , '  ,', 'ie'));


ver_src_en := ver_src_en_pos > 0;

_ver_src_fdate_en :=  __common__(if(ver_src_en_pos > 0, Models.Common.getw(ver_sources_first_seen, ver_src_en_pos), '0'));

ver_src_fdate_en :=  __common__(common.sas_date((string)(_ver_src_fdate_en)));


_ver_src_ldate_en := if(ver_src_en_pos > 0, Models.Common.getw(ver_sources_last_seen, ver_src_en_pos), '0');

ver_src_ldate_en := common.sas_date((string)(_ver_src_ldate_en));

ver_src_cnt_en := if(ver_src_en_pos > 0, (real)Models.Common.getw(ver_sources_count, ver_src_en_pos), 0);

ver_src_rcnt_18 := ver_src_rcnt_19 + ver_src_cnt_en;


ver_src_eq_pos :=  __common__(Models.Common.findw_cpp(ver_sources, 'EQ' , '  ,', 'ie'));


ver_src_eq := ver_src_eq_pos > 0;


_ver_src_fdate_eq :=  __common__(if(ver_src_eq_pos > 0, Models.Common.getw(ver_sources_first_seen, ver_src_eq_pos), '0'));

ver_src_fdate_eq :=  __common__(common.sas_date((string)(_ver_src_fdate_eq)));


_ver_src_ldate_eq := if(ver_src_eq_pos > 0, Models.Common.getw(ver_sources_last_seen, ver_src_eq_pos), '0');

ver_src_ldate_eq := common.sas_date((string)(_ver_src_ldate_eq));

ver_src_cnt_eq := if(ver_src_eq_pos > 0, (real)Models.Common.getw(ver_sources_count, ver_src_eq_pos), 0);

ver_src_rcnt_17 := ver_src_rcnt_18 + ver_src_cnt_eq;


ver_src_fe_pos :=  __common__(Models.Common.findw_cpp(ver_sources, 'FE' , '  ,', 'ie'));

ver_src_fe :=  __common__(ver_src_fe_pos > 0);

_ver_src_fdate_fe :=  __common__(if(ver_src_fe_pos > 0, Models.Common.getw(ver_sources_first_seen, ver_src_fe_pos), '0'));

ver_src_fdate_fe :=  __common__(common.sas_date((string)(_ver_src_fdate_fe)));




_ver_src_ldate_fe := if(ver_src_fe_pos > 0, Models.Common.getw(ver_sources_last_seen, ver_src_fe_pos), '0');

ver_src_ldate_fe := common.sas_date((string)(_ver_src_ldate_fe));

ver_src_cnt_fe := if(ver_src_fe_pos > 0, (real)Models.Common.getw(ver_sources_count, ver_src_fe_pos), 0);

ver_src_rcnt_16 := ver_src_rcnt_17 + ver_src_cnt_fe;


ver_src_ff_pos :=  __common__(Models.Common.findw_cpp(ver_sources, 'FF' , '  ,', 'ie'));

ver_src_ff :=  __common__(ver_src_ff_pos > 0);

_ver_src_fdate_ff :=  __common__(if(ver_src_ff_pos > 0, Models.Common.getw(ver_sources_first_seen, ver_src_ff_pos), '0'));

ver_src_fdate_ff :=  __common__(common.sas_date((string)(_ver_src_fdate_ff)));


_ver_src_ldate_ff := if(ver_src_ff_pos > 0, Models.Common.getw(ver_sources_last_seen, ver_src_ff_pos), '0');

ver_src_ldate_ff := common.sas_date((string)(_ver_src_ldate_ff));

ver_src_cnt_ff := if(ver_src_ff_pos > 0, (real)Models.Common.getw(ver_sources_count, ver_src_ff_pos), 0);

ver_src_rcnt_15 := ver_src_rcnt_16 + ver_src_cnt_ff;


ver_src_fr_pos :=  __common__(Models.Common.findw_cpp(ver_sources, 'FR' , '  ,', 'ie'));

ver_src_fr :=  __common__(ver_src_fr_pos > 0);

_ver_src_fdate_fr :=  __common__(if(ver_src_fr_pos > 0, Models.Common.getw(ver_sources_first_seen, ver_src_fr_pos), '0'));

ver_src_fdate_fr :=  __common__(common.sas_date((string)(_ver_src_fdate_fr)));


_ver_src_ldate_fr := if(ver_src_fr_pos > 0, Models.Common.getw(ver_sources_last_seen, ver_src_fr_pos), '0');

ver_src_ldate_fr := common.sas_date((string)(_ver_src_ldate_fr));

ver_src_cnt_fr := if(ver_src_fr_pos > 0, (real)Models.Common.getw(ver_sources_count, ver_src_fr_pos), 0);

ver_src_rcnt_14 := ver_src_rcnt_15 + ver_src_cnt_fr;


ver_src_l2_pos :=  __common__(Models.Common.findw_cpp(ver_sources, 'L2' , '  ,', 'ie'));

ver_src_l2 :=  __common__(ver_src_l2_pos > 0);

_ver_src_fdate_l2 :=  __common__(if(ver_src_l2_pos > 0, Models.Common.getw(ver_sources_first_seen, ver_src_l2_pos), '0'));

ver_src_fdate_l2 :=  __common__(common.sas_date((string)(_ver_src_fdate_l2)));


_ver_src_ldate_l2 := if(ver_src_l2_pos > 0, Models.Common.getw(ver_sources_last_seen, ver_src_l2_pos), '0');

ver_src_ldate_l2 := common.sas_date((string)(_ver_src_ldate_l2));

ver_src_cnt_l2 := if(ver_src_l2_pos > 0, (real)Models.Common.getw(ver_sources_count, ver_src_l2_pos), 0);

ver_src_rcnt_13 := ver_src_rcnt_14 + ver_src_cnt_l2;


ver_src_li_pos :=  __common__(Models.Common.findw_cpp(ver_sources, 'LI' , '  ,', 'ie'));

ver_src_li :=  __common__(ver_src_li_pos > 0);

_ver_src_fdate_li :=  __common__(if(ver_src_li_pos > 0, Models.Common.getw(ver_sources_first_seen, ver_src_li_pos), '0'));

ver_src_fdate_li :=  __common__(common.sas_date((string)(_ver_src_fdate_li)));


_ver_src_ldate_li := if(ver_src_li_pos > 0, Models.Common.getw(ver_sources_last_seen, ver_src_li_pos), '0');

ver_src_ldate_li := common.sas_date((string)(_ver_src_ldate_li));

ver_src_cnt_li := if(ver_src_li_pos > 0, (real)Models.Common.getw(ver_sources_count, ver_src_li_pos), 0);

ver_src_rcnt_12 := ver_src_rcnt_13 + ver_src_cnt_li;



ver_src_mw_pos :=  __common__(Models.Common.findw_cpp(ver_sources, 'MW' , '  ,', 'ie'));

ver_src_mw :=  __common__(ver_src_mw_pos > 0);

_ver_src_fdate_mw :=  __common__(if(ver_src_mw_pos > 0, Models.Common.getw(ver_sources_first_seen, ver_src_mw_pos), '0'));

ver_src_fdate_mw :=  __common__(common.sas_date((string)(_ver_src_fdate_mw)));


_ver_src_ldate_mw := if(ver_src_mw_pos > 0, Models.Common.getw(ver_sources_last_seen, ver_src_mw_pos), '0');

ver_src_ldate_mw := common.sas_date((string)(_ver_src_ldate_mw));

ver_src_cnt_mw := if(ver_src_mw_pos > 0, (real)Models.Common.getw(ver_sources_count, ver_src_mw_pos), 0);

ver_src_rcnt_11 := ver_src_rcnt_12 + ver_src_cnt_mw;


ver_src_nt_pos :=  __common__(Models.Common.findw_cpp(ver_sources, 'NT' , '  ,', 'ie'));

ver_src_nt :=  __common__(ver_src_nt_pos > 0);

_ver_src_fdate_nt :=  __common__(if(ver_src_nt_pos > 0, Models.Common.getw(ver_sources_first_seen, ver_src_nt_pos), '0'));

ver_src_fdate_nt :=  __common__(common.sas_date((string)(_ver_src_fdate_nt)));



_ver_src_ldate_nt := if(ver_src_nt_pos > 0, Models.Common.getw(ver_sources_last_seen, ver_src_nt_pos), '0');

ver_src_ldate_nt := common.sas_date((string)(_ver_src_ldate_nt));

ver_src_cnt_nt := if(ver_src_nt_pos > 0, (real)Models.Common.getw(ver_sources_count, ver_src_nt_pos), 0);

ver_src_rcnt_10 := ver_src_rcnt_11 + ver_src_cnt_nt;


ver_src_p_pos :=  __common__(Models.Common.findw_cpp(ver_sources, 'P' , '  ,', 'ie'));

ver_src_p :=  __common__(ver_src_p_pos > 0);

_ver_src_fdate_p :=  __common__(if(ver_src_p_pos > 0, Models.Common.getw(ver_sources_first_seen, ver_src_p_pos), '0'));

ver_src_fdate_p :=  __common__(common.sas_date((string)(_ver_src_fdate_p)));


_ver_src_ldate_p := if(ver_src_p_pos > 0, Models.Common.getw(ver_sources_last_seen, ver_src_p_pos), '0');

ver_src_ldate_p := common.sas_date((string)(_ver_src_ldate_p));

ver_src_cnt_p := if(ver_src_p_pos > 0, (real)Models.Common.getw(ver_sources_count, ver_src_p_pos), 0);

ver_src_rcnt_9 := ver_src_rcnt_10 + ver_src_cnt_p;


ver_src_pl_pos :=  __common__(Models.Common.findw_cpp(ver_sources, 'PL' , '  ,', 'ie'));

ver_src_pl :=  __common__(ver_src_pl_pos > 0);

_ver_src_fdate_pl :=  __common__(if(ver_src_pl_pos > 0, Models.Common.getw(ver_sources_first_seen, ver_src_pl_pos), '0'));

ver_src_fdate_pl :=  __common__(common.sas_date((string)(_ver_src_fdate_pl)));



_ver_src_ldate_pl := if(ver_src_pl_pos > 0, Models.Common.getw(ver_sources_last_seen, ver_src_pl_pos), '0');

ver_src_ldate_pl := common.sas_date((string)(_ver_src_ldate_pl));

ver_src_cnt_pl := if(ver_src_pl_pos > 0, (real)Models.Common.getw(ver_sources_count, ver_src_pl_pos), 0);

ver_src_rcnt_8 := ver_src_rcnt_9 + ver_src_cnt_pl;


ver_src_tn_pos :=  __common__(Models.Common.findw_cpp(ver_sources, 'TN' , '  ,', 'ie'));


ver_src_tn := ver_src_tn_pos > 0;


_ver_src_fdate_tn :=  __common__(if(ver_src_tn_pos > 0, Models.Common.getw(ver_sources_first_seen, ver_src_tn_pos), '0'));

ver_src_fdate_tn :=  __common__(common.sas_date((string)(_ver_src_fdate_tn)));


_ver_src_ldate_tn := if(ver_src_tn_pos > 0, Models.Common.getw(ver_sources_last_seen, ver_src_tn_pos), '0');

ver_src_ldate_tn := common.sas_date((string)(_ver_src_ldate_tn));

ver_src_cnt_tn := if(ver_src_tn_pos > 0, (real)Models.Common.getw(ver_sources_count, ver_src_tn_pos), 0);

ver_src_rcnt_7 := ver_src_rcnt_8 + ver_src_cnt_tn;


ver_src_ts_pos :=  __common__(Models.Common.findw_cpp(ver_sources, 'TS' , '  ,', 'ie'));


ver_src_ts := ver_src_ts_pos > 0;


_ver_src_fdate_ts :=  __common__(if(ver_src_ts_pos > 0, Models.Common.getw(ver_sources_first_seen, ver_src_ts_pos), '0'));

ver_src_fdate_ts :=  __common__(common.sas_date((string)(_ver_src_fdate_ts)));



_ver_src_ldate_ts := if(ver_src_ts_pos > 0, Models.Common.getw(ver_sources_last_seen, ver_src_ts_pos), '0');

ver_src_ldate_ts := common.sas_date((string)(_ver_src_ldate_ts));

ver_src_cnt_ts := if(ver_src_ts_pos > 0, (real)Models.Common.getw(ver_sources_count, ver_src_ts_pos), 0);

ver_src_rcnt_6 := ver_src_rcnt_7 + ver_src_cnt_ts;


ver_src_tu_pos :=  __common__(Models.Common.findw_cpp(ver_sources, 'TU' , '  ,', 'ie'));


ver_src_tu := ver_src_tu_pos > 0;


_ver_src_fdate_tu :=  __common__(if(ver_src_tu_pos > 0, Models.Common.getw(ver_sources_first_seen, ver_src_tu_pos), '0'));

ver_src_fdate_tu :=  __common__(common.sas_date((string)(_ver_src_fdate_tu)));


_ver_src_ldate_tu := if(ver_src_tu_pos > 0, Models.Common.getw(ver_sources_last_seen, ver_src_tu_pos), '0');

ver_src_ldate_tu := common.sas_date((string)(_ver_src_ldate_tu));

ver_src_cnt_tu := if(ver_src_tu_pos > 0, (real)Models.Common.getw(ver_sources_count, ver_src_tu_pos), 0);

ver_src_rcnt_5 := ver_src_rcnt_6 + ver_src_cnt_tu;


ver_src_sl_pos :=  __common__(Models.Common.findw_cpp(ver_sources, 'SL' , '  ,', 'ie'));

ver_src_sl :=  __common__(ver_src_sl_pos > 0);

_ver_src_fdate_sl :=  __common__(if(ver_src_sl_pos > 0, Models.Common.getw(ver_sources_first_seen, ver_src_sl_pos), '0'));

ver_src_fdate_sl :=  __common__(common.sas_date((string)(_ver_src_fdate_sl)));


_ver_src_ldate_sl := if(ver_src_sl_pos > 0, Models.Common.getw(ver_sources_last_seen, ver_src_sl_pos), '0');

ver_src_ldate_sl := common.sas_date((string)(_ver_src_ldate_sl));

ver_src_cnt_sl := if(ver_src_sl_pos > 0, (real)Models.Common.getw(ver_sources_count, ver_src_sl_pos), 0);

ver_src_rcnt_4 := ver_src_rcnt_5 + ver_src_cnt_sl;


ver_src_v_pos :=  __common__(Models.Common.findw_cpp(ver_sources, 'V' , '  ,', 'ie'));

ver_src_v :=  __common__(ver_src_v_pos > 0);

_ver_src_fdate_v :=  __common__(if(ver_src_v_pos > 0, Models.Common.getw(ver_sources_first_seen, ver_src_v_pos), '0'));

ver_src_fdate_v :=  __common__(common.sas_date((string)(_ver_src_fdate_v)));


_ver_src_ldate_v := if(ver_src_v_pos > 0, Models.Common.getw(ver_sources_last_seen, ver_src_v_pos), '0');

ver_src_ldate_v := common.sas_date((string)(_ver_src_ldate_v));

ver_src_cnt_v := if(ver_src_v_pos > 0, (real)Models.Common.getw(ver_sources_count, ver_src_v_pos), 0);

ver_src_rcnt_3 := ver_src_rcnt_4 + ver_src_cnt_v;


ver_src_vo_pos :=  __common__(Models.Common.findw_cpp(ver_sources, 'VO' , '  ,', 'ie'));

ver_src_vo :=  __common__(ver_src_vo_pos > 0);

_ver_src_fdate_vo :=  __common__(if(ver_src_vo_pos > 0, Models.Common.getw(ver_sources_first_seen, ver_src_vo_pos), '0'));

ver_src_fdate_vo :=  __common__(common.sas_date((string)(_ver_src_fdate_vo)));


_ver_src_ldate_vo := if(ver_src_vo_pos > 0, Models.Common.getw(ver_sources_last_seen, ver_src_vo_pos), '0');

ver_src_ldate_vo := common.sas_date((string)(_ver_src_ldate_vo));

ver_src_cnt_vo := if(ver_src_vo_pos > 0, (real)Models.Common.getw(ver_sources_count, ver_src_vo_pos), 0);

ver_src_rcnt_2 := ver_src_rcnt_3 + ver_src_cnt_vo;


ver_src_w_pos :=  __common__(Models.Common.findw_cpp(ver_sources, 'W' , '  ,', 'ie'));

ver_src_w :=  __common__(ver_src_w_pos > 0);

_ver_src_fdate_w :=  __common__(if(ver_src_w_pos > 0, Models.Common.getw(ver_sources_first_seen, ver_src_w_pos), '0'));

ver_src_fdate_w :=  __common__(common.sas_date((string)(_ver_src_fdate_w)));


_ver_src_ldate_w := if(ver_src_w_pos > 0, Models.Common.getw(ver_sources_last_seen, ver_src_w_pos), '0');

ver_src_ldate_w := common.sas_date((string)(_ver_src_ldate_w));

ver_src_cnt_w := if(ver_src_w_pos > 0, (real)Models.Common.getw(ver_sources_count, ver_src_w_pos), 0);

ver_src_rcnt_1 := ver_src_rcnt_2 + ver_src_cnt_w;


ver_src_wp_pos :=  __common__(Models.Common.findw_cpp(ver_sources, 'WP' , '  ,', 'ie'));

ver_src_wp :=  __common__(ver_src_wp_pos > 0);

_ver_src_fdate_wp :=  __common__(if(ver_src_wp_pos > 0, Models.Common.getw(ver_sources_first_seen, ver_src_wp_pos), '0'));

ver_src_fdate_wp :=  __common__(common.sas_date((string)(_ver_src_fdate_wp)));


_ver_src_ldate_wp := if(ver_src_wp_pos > 0, Models.Common.getw(ver_sources_last_seen, ver_src_wp_pos), '0');

ver_src_ldate_wp := common.sas_date((string)(_ver_src_ldate_wp));

ver_src_cnt_wp := if(ver_src_wp_pos > 0, (real)Models.Common.getw(ver_sources_count, ver_src_wp_pos), 0);

ver_src_rcnt := ver_src_rcnt_1 + ver_src_cnt_wp;

ver_fname_src_cnt := Models.Common.countw((string)(ver_fname_sources), ' !$%&()*+,-./;<^|');

ver_fname_src_pop := ver_fname_src_cnt > 0;

ver_fname_src_rcnt := 0;

ver_fname_src_fsrc := Models.Common.getw(ver_fname_sources, 1);

ver_fname_src_ak_pos := Models.Common.findw_cpp(ver_fname_sources, 'AK' , '  ,', 'ie');

ver_fname_src_ak := ver_fname_src_ak_pos > 0;

ver_fname_src_am_pos := Models.Common.findw_cpp(ver_fname_sources, 'AM' , '  ,', 'ie');

ver_fname_src_am := ver_fname_src_am_pos > 0;

ver_fname_src_ar_pos := Models.Common.findw_cpp(ver_fname_sources, 'AR' , '  ,', 'ie');

ver_fname_src_ar := ver_fname_src_ar_pos > 0;

ver_fname_src_ba_pos := Models.Common.findw_cpp(ver_fname_sources, 'BA' , '  ,', 'ie');

ver_fname_src_ba := ver_fname_src_ba_pos > 0;

ver_fname_src_cg_pos := Models.Common.findw_cpp(ver_fname_sources, 'CG' , '  ,', 'ie');

ver_fname_src_cg := ver_fname_src_cg_pos > 0;

ver_fname_src_co_pos := Models.Common.findw_cpp(ver_fname_sources, 'CO' , '  ,', 'ie');

ver_fname_src_co := ver_fname_src_co_pos > 0;

ver_fname_src_cy_pos := Models.Common.findw_cpp(ver_fname_sources, 'CY' , '  ,', 'ie');

ver_fname_src_cy := ver_fname_src_cy_pos > 0;

ver_fname_src_da_pos := Models.Common.findw_cpp(ver_fname_sources, 'DA' , '  ,', 'ie');

ver_fname_src_da := ver_fname_src_da_pos > 0;

ver_fname_src_d_pos := Models.Common.findw_cpp(ver_fname_sources, 'D' , '  ,', 'ie');

ver_fname_src_d := ver_fname_src_d_pos > 0;

ver_fname_src_dl_pos := Models.Common.findw_cpp(ver_fname_sources, 'DL' , '  ,', 'ie');

ver_fname_src_dl := ver_fname_src_dl_pos > 0;

ver_fname_src_ds_pos := Models.Common.findw_cpp(ver_fname_sources, 'DS' , '  ,', 'ie');

ver_fname_src_ds := ver_fname_src_ds_pos > 0;

ver_fname_src_de_pos := Models.Common.findw_cpp(ver_fname_sources, 'DE' , '  ,', 'ie');

ver_fname_src_de := ver_fname_src_de_pos > 0;

ver_fname_src_eb_pos := Models.Common.findw_cpp(ver_fname_sources, 'EB' , '  ,', 'ie');

ver_fname_src_eb := ver_fname_src_eb_pos > 0;

ver_fname_src_em_pos := Models.Common.findw_cpp(ver_fname_sources, 'EM' , '  ,', 'ie');

ver_fname_src_em := ver_fname_src_em_pos > 0;

ver_fname_src_e1_pos := Models.Common.findw_cpp(ver_fname_sources, 'E1' , '  ,', 'ie');

ver_fname_src_e1 := ver_fname_src_e1_pos > 0;

ver_fname_src_e2_pos := Models.Common.findw_cpp(ver_fname_sources, 'E2' , '  ,', 'ie');

ver_fname_src_e2 := ver_fname_src_e2_pos > 0;

ver_fname_src_e3_pos := Models.Common.findw_cpp(ver_fname_sources, 'E3' , '  ,', 'ie');

ver_fname_src_e3 := ver_fname_src_e3_pos > 0;

ver_fname_src_e4_pos := Models.Common.findw_cpp(ver_fname_sources, 'E4' , '  ,', 'ie');

ver_fname_src_e4 := ver_fname_src_e4_pos > 0;

ver_fname_src_en_pos := Models.Common.findw_cpp(ver_fname_sources, 'EN' , '  ,', 'ie');

ver_fname_src_en := ver_fname_src_en_pos > 0;

ver_fname_src_eq_pos := Models.Common.findw_cpp(ver_fname_sources, 'EQ' , '  ,', 'ie');

ver_fname_src_eq := ver_fname_src_eq_pos > 0;

ver_fname_src_fe_pos := Models.Common.findw_cpp(ver_fname_sources, 'FE' , '  ,', 'ie');

ver_fname_src_fe := ver_fname_src_fe_pos > 0;

ver_fname_src_ff_pos := Models.Common.findw_cpp(ver_fname_sources, 'FF' , '  ,', 'ie');

ver_fname_src_ff := ver_fname_src_ff_pos > 0;

ver_fname_src_fr_pos := Models.Common.findw_cpp(ver_fname_sources, 'FR' , '  ,', 'ie');

ver_fname_src_fr := ver_fname_src_fr_pos > 0;

ver_fname_src_l2_pos := Models.Common.findw_cpp(ver_fname_sources, 'L2' , '  ,', 'ie');

ver_fname_src_l2 := ver_fname_src_l2_pos > 0;

ver_fname_src_li_pos := Models.Common.findw_cpp(ver_fname_sources, 'LI' , '  ,', 'ie');

ver_fname_src_li := ver_fname_src_li_pos > 0;

ver_fname_src_mw_pos := Models.Common.findw_cpp(ver_fname_sources, 'MW' , '  ,', 'ie');

ver_fname_src_mw := ver_fname_src_mw_pos > 0;

ver_fname_src_nt_pos := Models.Common.findw_cpp(ver_fname_sources, 'NT' , '  ,', 'ie');

ver_fname_src_nt := ver_fname_src_nt_pos > 0;

ver_fname_src_p_pos := Models.Common.findw_cpp(ver_fname_sources, 'P' , '  ,', 'ie');

ver_fname_src_p := ver_fname_src_p_pos > 0;

ver_fname_src_pl_pos := Models.Common.findw_cpp(ver_fname_sources, 'PL' , '  ,', 'ie');

ver_fname_src_pl := ver_fname_src_pl_pos > 0;

ver_fname_src_tn_pos := Models.Common.findw_cpp(ver_fname_sources, 'TN' , '  ,', 'ie');

ver_fname_src_tn := ver_fname_src_tn_pos > 0;

ver_fname_src_ts_pos := Models.Common.findw_cpp(ver_fname_sources, 'TS' , '  ,', 'ie');

ver_fname_src_ts := ver_fname_src_ts_pos > 0;

ver_fname_src_tu_pos := Models.Common.findw_cpp(ver_fname_sources, 'TU' , '  ,', 'ie');

ver_fname_src_tu := ver_fname_src_tu_pos > 0;

ver_fname_src_sl_pos := Models.Common.findw_cpp(ver_fname_sources, 'SL' , '  ,', 'ie');

ver_fname_src_sl := ver_fname_src_sl_pos > 0;

ver_fname_src_v_pos := Models.Common.findw_cpp(ver_fname_sources, 'V' , '  ,', 'ie');

ver_fname_src_v := ver_fname_src_v_pos > 0;

ver_fname_src_vo_pos := Models.Common.findw_cpp(ver_fname_sources, 'VO' , '  ,', 'ie');

ver_fname_src_vo := ver_fname_src_vo_pos > 0;

ver_fname_src_w_pos := Models.Common.findw_cpp(ver_fname_sources, 'W' , '  ,', 'ie');

ver_fname_src_w := ver_fname_src_w_pos > 0;

ver_fname_src_wp_pos := Models.Common.findw_cpp(ver_fname_sources, 'WP' , '  ,', 'ie');

ver_fname_src_wp := ver_fname_src_wp_pos > 0;

ver_lname_src_cnt := Models.Common.countw((string)(ver_lname_sources), ' !$%&()*+,-./;<^|');

ver_lname_src_pop := ver_lname_src_cnt > 0;

ver_lname_src_rcnt := 0;

ver_lname_src_fsrc := Models.Common.getw(ver_lname_sources, 1);

ver_lname_src_ak_pos := Models.Common.findw_cpp(ver_lname_sources, 'AK' , '  ,', 'ie');

ver_lname_src_ak := ver_lname_src_ak_pos > 0;

ver_lname_src_am_pos := Models.Common.findw_cpp(ver_lname_sources, 'AM' , '  ,', 'ie');

ver_lname_src_am := ver_lname_src_am_pos > 0;

ver_lname_src_ar_pos := Models.Common.findw_cpp(ver_lname_sources, 'AR' , '  ,', 'ie');

ver_lname_src_ar := ver_lname_src_ar_pos > 0;

ver_lname_src_ba_pos := Models.Common.findw_cpp(ver_lname_sources, 'BA' , '  ,', 'ie');

ver_lname_src_ba := ver_lname_src_ba_pos > 0;

ver_lname_src_cg_pos := Models.Common.findw_cpp(ver_lname_sources, 'CG' , '  ,', 'ie');

ver_lname_src_cg := ver_lname_src_cg_pos > 0;

ver_lname_src_co_pos := Models.Common.findw_cpp(ver_lname_sources, 'CO' , '  ,', 'ie');

ver_lname_src_co := ver_lname_src_co_pos > 0;

ver_lname_src_cy_pos := Models.Common.findw_cpp(ver_lname_sources, 'CY' , '  ,', 'ie');

ver_lname_src_cy := ver_lname_src_cy_pos > 0;

ver_lname_src_da_pos := Models.Common.findw_cpp(ver_lname_sources, 'DA' , '  ,', 'ie');

ver_lname_src_da := ver_lname_src_da_pos > 0;

ver_lname_src_d_pos := Models.Common.findw_cpp(ver_lname_sources, 'D' , '  ,', 'ie');

ver_lname_src_d := ver_lname_src_d_pos > 0;

ver_lname_src_dl_pos := Models.Common.findw_cpp(ver_lname_sources, 'DL' , '  ,', 'ie');

ver_lname_src_dl := ver_lname_src_dl_pos > 0;

ver_lname_src_ds_pos := Models.Common.findw_cpp(ver_lname_sources, 'DS' , '  ,', 'ie');

ver_lname_src_ds := ver_lname_src_ds_pos > 0;

ver_lname_src_de_pos := Models.Common.findw_cpp(ver_lname_sources, 'DE' , '  ,', 'ie');

ver_lname_src_de := ver_lname_src_de_pos > 0;

ver_lname_src_eb_pos := Models.Common.findw_cpp(ver_lname_sources, 'EB' , '  ,', 'ie');

ver_lname_src_eb := ver_lname_src_eb_pos > 0;

ver_lname_src_em_pos := Models.Common.findw_cpp(ver_lname_sources, 'EM' , '  ,', 'ie');

ver_lname_src_em := ver_lname_src_em_pos > 0;

ver_lname_src_e1_pos := Models.Common.findw_cpp(ver_lname_sources, 'E1' , '  ,', 'ie');

ver_lname_src_e1 := ver_lname_src_e1_pos > 0;

ver_lname_src_e2_pos := Models.Common.findw_cpp(ver_lname_sources, 'E2' , '  ,', 'ie');

ver_lname_src_e2 := ver_lname_src_e2_pos > 0;

ver_lname_src_e3_pos := Models.Common.findw_cpp(ver_lname_sources, 'E3' , '  ,', 'ie');

ver_lname_src_e3 := ver_lname_src_e3_pos > 0;

ver_lname_src_e4_pos := Models.Common.findw_cpp(ver_lname_sources, 'E4' , '  ,', 'ie');

ver_lname_src_e4 := ver_lname_src_e4_pos > 0;


ver_lname_src_en_pos :=  __common__(Models.Common.findw_cpp(ver_lname_sources, 'EN' , '  ,', 'ie'));

ver_lname_src_en :=  __common__(ver_lname_src_en_pos > 0);

ver_lname_src_eq_pos :=  __common__(Models.Common.findw_cpp(ver_lname_sources, 'EQ' , '  ,', 'ie'));

ver_lname_src_eq :=  __common__(ver_lname_src_eq_pos > 0);



ver_lname_src_fe_pos := Models.Common.findw_cpp(ver_lname_sources, 'FE' , '  ,', 'ie');

ver_lname_src_fe := ver_lname_src_fe_pos > 0;

ver_lname_src_ff_pos := Models.Common.findw_cpp(ver_lname_sources, 'FF' , '  ,', 'ie');

ver_lname_src_ff := ver_lname_src_ff_pos > 0;

ver_lname_src_fr_pos := Models.Common.findw_cpp(ver_lname_sources, 'FR' , '  ,', 'ie');

ver_lname_src_fr := ver_lname_src_fr_pos > 0;

ver_lname_src_l2_pos := Models.Common.findw_cpp(ver_lname_sources, 'L2' , '  ,', 'ie');

ver_lname_src_l2 := ver_lname_src_l2_pos > 0;

ver_lname_src_li_pos := Models.Common.findw_cpp(ver_lname_sources, 'LI' , '  ,', 'ie');

ver_lname_src_li := ver_lname_src_li_pos > 0;

ver_lname_src_mw_pos := Models.Common.findw_cpp(ver_lname_sources, 'MW' , '  ,', 'ie');

ver_lname_src_mw := ver_lname_src_mw_pos > 0;

ver_lname_src_nt_pos := Models.Common.findw_cpp(ver_lname_sources, 'NT' , '  ,', 'ie');

ver_lname_src_nt := ver_lname_src_nt_pos > 0;

ver_lname_src_p_pos := Models.Common.findw_cpp(ver_lname_sources, 'P' , '  ,', 'ie');

ver_lname_src_p := ver_lname_src_p_pos > 0;

ver_lname_src_pl_pos := Models.Common.findw_cpp(ver_lname_sources, 'PL' , '  ,', 'ie');

ver_lname_src_pl := ver_lname_src_pl_pos > 0;


ver_lname_src_tn_pos :=  __common__(Models.Common.findw_cpp(ver_lname_sources, 'TN' , '  ,', 'ie'));

ver_lname_src_tn :=  __common__(ver_lname_src_tn_pos > 0);

ver_lname_src_ts_pos :=  __common__(Models.Common.findw_cpp(ver_lname_sources, 'TS' , '  ,', 'ie'));

ver_lname_src_ts :=  __common__(ver_lname_src_ts_pos > 0);

ver_lname_src_tu_pos :=  __common__(Models.Common.findw_cpp(ver_lname_sources, 'TU' , '  ,', 'ie'));

ver_lname_src_tu :=  __common__(ver_lname_src_tu_pos > 0);





ver_lname_src_sl_pos := Models.Common.findw_cpp(ver_lname_sources, 'SL' , '  ,', 'ie');

ver_lname_src_sl := ver_lname_src_sl_pos > 0;

ver_lname_src_v_pos := Models.Common.findw_cpp(ver_lname_sources, 'V' , '  ,', 'ie');

ver_lname_src_v := ver_lname_src_v_pos > 0;

ver_lname_src_vo_pos := Models.Common.findw_cpp(ver_lname_sources, 'VO' , '  ,', 'ie');

ver_lname_src_vo := ver_lname_src_vo_pos > 0;

ver_lname_src_w_pos := Models.Common.findw_cpp(ver_lname_sources, 'W' , '  ,', 'ie');

ver_lname_src_w := ver_lname_src_w_pos > 0;

ver_lname_src_wp_pos := Models.Common.findw_cpp(ver_lname_sources, 'WP' , '  ,', 'ie');

ver_lname_src_wp := ver_lname_src_wp_pos > 0;

ver_addr_src_cnt := Models.Common.countw((string)(ver_addr_sources), ' !$%&()*+,-./;<^|');

ver_addr_src_pop := ver_addr_src_cnt > 0;

ver_addr_src_rcnt := 0;

ver_addr_src_fsrc := Models.Common.getw(ver_addr_sources, 1);

ver_addr_src_ak_pos := Models.Common.findw_cpp(ver_addr_sources, 'AK' , '  ,', 'ie');

ver_addr_src_ak := ver_addr_src_ak_pos > 0;

ver_addr_src_am_pos := Models.Common.findw_cpp(ver_addr_sources, 'AM' , '  ,', 'ie');

ver_addr_src_am := ver_addr_src_am_pos > 0;

ver_addr_src_ar_pos := Models.Common.findw_cpp(ver_addr_sources, 'AR' , '  ,', 'ie');

ver_addr_src_ar := ver_addr_src_ar_pos > 0;

ver_addr_src_ba_pos := Models.Common.findw_cpp(ver_addr_sources, 'BA' , '  ,', 'ie');

ver_addr_src_ba := ver_addr_src_ba_pos > 0;

ver_addr_src_cg_pos := Models.Common.findw_cpp(ver_addr_sources, 'CG' , '  ,', 'ie');

ver_addr_src_cg := ver_addr_src_cg_pos > 0;

ver_addr_src_co_pos := Models.Common.findw_cpp(ver_addr_sources, 'CO' , '  ,', 'ie');

ver_addr_src_co := ver_addr_src_co_pos > 0;

ver_addr_src_cy_pos := Models.Common.findw_cpp(ver_addr_sources, 'CY' , '  ,', 'ie');

ver_addr_src_cy := ver_addr_src_cy_pos > 0;

ver_addr_src_da_pos := Models.Common.findw_cpp(ver_addr_sources, 'DA' , '  ,', 'ie');

ver_addr_src_da := ver_addr_src_da_pos > 0;

ver_addr_src_d_pos := Models.Common.findw_cpp(ver_addr_sources, 'D' , '  ,', 'ie');

ver_addr_src_d := ver_addr_src_d_pos > 0;

ver_addr_src_dl_pos := Models.Common.findw_cpp(ver_addr_sources, 'DL' , '  ,', 'ie');

ver_addr_src_dl := ver_addr_src_dl_pos > 0;

ver_addr_src_ds_pos := Models.Common.findw_cpp(ver_addr_sources, 'DS' , '  ,', 'ie');

ver_addr_src_ds := ver_addr_src_ds_pos > 0;

ver_addr_src_de_pos := Models.Common.findw_cpp(ver_addr_sources, 'DE' , '  ,', 'ie');

ver_addr_src_de := ver_addr_src_de_pos > 0;

ver_addr_src_eb_pos := Models.Common.findw_cpp(ver_addr_sources, 'EB' , '  ,', 'ie');

ver_addr_src_eb := ver_addr_src_eb_pos > 0;

ver_addr_src_em_pos := Models.Common.findw_cpp(ver_addr_sources, 'EM' , '  ,', 'ie');

ver_addr_src_em := ver_addr_src_em_pos > 0;

ver_addr_src_e1_pos := Models.Common.findw_cpp(ver_addr_sources, 'E1' , '  ,', 'ie');

ver_addr_src_e1 := ver_addr_src_e1_pos > 0;

ver_addr_src_e2_pos := Models.Common.findw_cpp(ver_addr_sources, 'E2' , '  ,', 'ie');

ver_addr_src_e2 := ver_addr_src_e2_pos > 0;

ver_addr_src_e3_pos := Models.Common.findw_cpp(ver_addr_sources, 'E3' , '  ,', 'ie');

ver_addr_src_e3 := ver_addr_src_e3_pos > 0;

ver_addr_src_e4_pos := Models.Common.findw_cpp(ver_addr_sources, 'E4' , '  ,', 'ie');

ver_addr_src_e4 := ver_addr_src_e4_pos > 0;

ver_addr_src_en_pos := Models.Common.findw_cpp(ver_addr_sources, 'EN' , '  ,', 'ie');

ver_addr_src_en := ver_addr_src_en_pos > 0;

ver_addr_src_eq_pos := Models.Common.findw_cpp(ver_addr_sources, 'EQ' , '  ,', 'ie');

ver_addr_src_eq := ver_addr_src_eq_pos > 0;

ver_addr_src_fe_pos := Models.Common.findw_cpp(ver_addr_sources, 'FE' , '  ,', 'ie');

ver_addr_src_fe := ver_addr_src_fe_pos > 0;

ver_addr_src_ff_pos := Models.Common.findw_cpp(ver_addr_sources, 'FF' , '  ,', 'ie');

ver_addr_src_ff := ver_addr_src_ff_pos > 0;

ver_addr_src_fr_pos := Models.Common.findw_cpp(ver_addr_sources, 'FR' , '  ,', 'ie');

ver_addr_src_fr := ver_addr_src_fr_pos > 0;

ver_addr_src_l2_pos := Models.Common.findw_cpp(ver_addr_sources, 'L2' , '  ,', 'ie');

ver_addr_src_l2 := ver_addr_src_l2_pos > 0;

ver_addr_src_li_pos := Models.Common.findw_cpp(ver_addr_sources, 'LI' , '  ,', 'ie');

ver_addr_src_li := ver_addr_src_li_pos > 0;

ver_addr_src_mw_pos := Models.Common.findw_cpp(ver_addr_sources, 'MW' , '  ,', 'ie');

ver_addr_src_mw := ver_addr_src_mw_pos > 0;

ver_addr_src_nt_pos := Models.Common.findw_cpp(ver_addr_sources, 'NT' , '  ,', 'ie');

ver_addr_src_nt := ver_addr_src_nt_pos > 0;

ver_addr_src_p_pos := Models.Common.findw_cpp(ver_addr_sources, 'P' , '  ,', 'ie');

ver_addr_src_p := ver_addr_src_p_pos > 0;

ver_addr_src_pl_pos := Models.Common.findw_cpp(ver_addr_sources, 'PL' , '  ,', 'ie');

ver_addr_src_pl := ver_addr_src_pl_pos > 0;

ver_addr_src_tn_pos := Models.Common.findw_cpp(ver_addr_sources, 'TN' , '  ,', 'ie');

ver_addr_src_tn := ver_addr_src_tn_pos > 0;

ver_addr_src_ts_pos := Models.Common.findw_cpp(ver_addr_sources, 'TS' , '  ,', 'ie');

ver_addr_src_ts := ver_addr_src_ts_pos > 0;

ver_addr_src_tu_pos := Models.Common.findw_cpp(ver_addr_sources, 'TU' , '  ,', 'ie');

ver_addr_src_tu := ver_addr_src_tu_pos > 0;

ver_addr_src_sl_pos := Models.Common.findw_cpp(ver_addr_sources, 'SL' , '  ,', 'ie');

ver_addr_src_sl := ver_addr_src_sl_pos > 0;

ver_addr_src_v_pos := Models.Common.findw_cpp(ver_addr_sources, 'V' , '  ,', 'ie');

ver_addr_src_v := ver_addr_src_v_pos > 0;

ver_addr_src_vo_pos := Models.Common.findw_cpp(ver_addr_sources, 'VO' , '  ,', 'ie');

ver_addr_src_vo := ver_addr_src_vo_pos > 0;

ver_addr_src_w_pos := Models.Common.findw_cpp(ver_addr_sources, 'W' , '  ,', 'ie');

ver_addr_src_w := ver_addr_src_w_pos > 0;

ver_addr_src_wp_pos := Models.Common.findw_cpp(ver_addr_sources, 'WP' , '  ,', 'ie');

ver_addr_src_wp := ver_addr_src_wp_pos > 0;

ver_ssn_src_cnt := Models.Common.countw((string)(ver_ssn_sources), ' !$%&()*+,-./;<^|');

ver_ssn_src_pop := ver_ssn_src_cnt > 0;

ver_ssn_src_rcnt := 0;

ver_ssn_src_fsrc := Models.Common.getw(ver_ssn_sources, 1);

ver_ssn_src_ak_pos := Models.Common.findw_cpp(ver_ssn_sources, 'AK' , '  ,', 'ie');

ver_ssn_src_ak := ver_ssn_src_ak_pos > 0;

ver_ssn_src_am_pos := Models.Common.findw_cpp(ver_ssn_sources, 'AM' , '  ,', 'ie');

ver_ssn_src_am := ver_ssn_src_am_pos > 0;

ver_ssn_src_ar_pos := Models.Common.findw_cpp(ver_ssn_sources, 'AR' , '  ,', 'ie');

ver_ssn_src_ar := ver_ssn_src_ar_pos > 0;

ver_ssn_src_ba_pos := Models.Common.findw_cpp(ver_ssn_sources, 'BA' , '  ,', 'ie');

ver_ssn_src_ba := ver_ssn_src_ba_pos > 0;

ver_ssn_src_cg_pos := Models.Common.findw_cpp(ver_ssn_sources, 'CG' , '  ,', 'ie');

ver_ssn_src_cg := ver_ssn_src_cg_pos > 0;

ver_ssn_src_co_pos := Models.Common.findw_cpp(ver_ssn_sources, 'CO' , '  ,', 'ie');

ver_ssn_src_co := ver_ssn_src_co_pos > 0;

ver_ssn_src_cy_pos := Models.Common.findw_cpp(ver_ssn_sources, 'CY' , '  ,', 'ie');

ver_ssn_src_cy := ver_ssn_src_cy_pos > 0;

ver_ssn_src_da_pos := Models.Common.findw_cpp(ver_ssn_sources, 'DA' , '  ,', 'ie');

ver_ssn_src_da := ver_ssn_src_da_pos > 0;

ver_ssn_src_d_pos := Models.Common.findw_cpp(ver_ssn_sources, 'D' , '  ,', 'ie');

ver_ssn_src_d := ver_ssn_src_d_pos > 0;

ver_ssn_src_dl_pos := Models.Common.findw_cpp(ver_ssn_sources, 'DL' , '  ,', 'ie');

ver_ssn_src_dl := ver_ssn_src_dl_pos > 0;

ver_ssn_src_ds_pos := Models.Common.findw_cpp(ver_ssn_sources, 'DS' , '  ,', 'ie');

ver_ssn_src_ds := ver_ssn_src_ds_pos > 0;

ver_ssn_src_de_pos := Models.Common.findw_cpp(ver_ssn_sources, 'DE' , '  ,', 'ie');

ver_ssn_src_de := ver_ssn_src_de_pos > 0;

ver_ssn_src_eb_pos := Models.Common.findw_cpp(ver_ssn_sources, 'EB' , '  ,', 'ie');

ver_ssn_src_eb := ver_ssn_src_eb_pos > 0;

ver_ssn_src_em_pos := Models.Common.findw_cpp(ver_ssn_sources, 'EM' , '  ,', 'ie');

ver_ssn_src_em := ver_ssn_src_em_pos > 0;

ver_ssn_src_e1_pos := Models.Common.findw_cpp(ver_ssn_sources, 'E1' , '  ,', 'ie');

ver_ssn_src_e1 := ver_ssn_src_e1_pos > 0;

ver_ssn_src_e2_pos := Models.Common.findw_cpp(ver_ssn_sources, 'E2' , '  ,', 'ie');

ver_ssn_src_e2 := ver_ssn_src_e2_pos > 0;

ver_ssn_src_e3_pos := Models.Common.findw_cpp(ver_ssn_sources, 'E3' , '  ,', 'ie');

ver_ssn_src_e3 := ver_ssn_src_e3_pos > 0;

ver_ssn_src_e4_pos := Models.Common.findw_cpp(ver_ssn_sources, 'E4' , '  ,', 'ie');

ver_ssn_src_e4 := ver_ssn_src_e4_pos > 0;

ver_ssn_src_en_pos := Models.Common.findw_cpp(ver_ssn_sources, 'EN' , '  ,', 'ie');

ver_ssn_src_en := ver_ssn_src_en_pos > 0;

ver_ssn_src_eq_pos := Models.Common.findw_cpp(ver_ssn_sources, 'EQ' , '  ,', 'ie');

ver_ssn_src_eq := ver_ssn_src_eq_pos > 0;

ver_ssn_src_fe_pos := Models.Common.findw_cpp(ver_ssn_sources, 'FE' , '  ,', 'ie');

ver_ssn_src_fe := ver_ssn_src_fe_pos > 0;

ver_ssn_src_ff_pos := Models.Common.findw_cpp(ver_ssn_sources, 'FF' , '  ,', 'ie');

ver_ssn_src_ff := ver_ssn_src_ff_pos > 0;

ver_ssn_src_fr_pos := Models.Common.findw_cpp(ver_ssn_sources, 'FR' , '  ,', 'ie');

ver_ssn_src_fr := ver_ssn_src_fr_pos > 0;

ver_ssn_src_l2_pos := Models.Common.findw_cpp(ver_ssn_sources, 'L2' , '  ,', 'ie');

ver_ssn_src_l2 := ver_ssn_src_l2_pos > 0;

ver_ssn_src_li_pos := Models.Common.findw_cpp(ver_ssn_sources, 'LI' , '  ,', 'ie');

ver_ssn_src_li := ver_ssn_src_li_pos > 0;

ver_ssn_src_mw_pos := Models.Common.findw_cpp(ver_ssn_sources, 'MW' , '  ,', 'ie');

ver_ssn_src_mw := ver_ssn_src_mw_pos > 0;

ver_ssn_src_nt_pos := Models.Common.findw_cpp(ver_ssn_sources, 'NT' , '  ,', 'ie');

ver_ssn_src_nt := ver_ssn_src_nt_pos > 0;

ver_ssn_src_p_pos := Models.Common.findw_cpp(ver_ssn_sources, 'P' , '  ,', 'ie');

ver_ssn_src_p := ver_ssn_src_p_pos > 0;

ver_ssn_src_pl_pos := Models.Common.findw_cpp(ver_ssn_sources, 'PL' , '  ,', 'ie');

ver_ssn_src_pl := ver_ssn_src_pl_pos > 0;

ver_ssn_src_tn_pos := Models.Common.findw_cpp(ver_ssn_sources, 'TN' , '  ,', 'ie');

ver_ssn_src_tn := ver_ssn_src_tn_pos > 0;

ver_ssn_src_ts_pos := Models.Common.findw_cpp(ver_ssn_sources, 'TS' , '  ,', 'ie');

ver_ssn_src_ts := ver_ssn_src_ts_pos > 0;

ver_ssn_src_tu_pos := Models.Common.findw_cpp(ver_ssn_sources, 'TU' , '  ,', 'ie');

ver_ssn_src_tu := ver_ssn_src_tu_pos > 0;

ver_ssn_src_sl_pos := Models.Common.findw_cpp(ver_ssn_sources, 'SL' , '  ,', 'ie');

ver_ssn_src_sl := ver_ssn_src_sl_pos > 0;

ver_ssn_src_v_pos := Models.Common.findw_cpp(ver_ssn_sources, 'V' , '  ,', 'ie');

ver_ssn_src_v := ver_ssn_src_v_pos > 0;

ver_ssn_src_vo_pos := Models.Common.findw_cpp(ver_ssn_sources, 'VO' , '  ,', 'ie');

ver_ssn_src_vo := ver_ssn_src_vo_pos > 0;

ver_ssn_src_w_pos := Models.Common.findw_cpp(ver_ssn_sources, 'W' , '  ,', 'ie');

ver_ssn_src_w := ver_ssn_src_w_pos > 0;

ver_ssn_src_wp_pos := Models.Common.findw_cpp(ver_ssn_sources, 'WP' , '  ,', 'ie');

ver_ssn_src_wp := ver_ssn_src_wp_pos > 0;

ver_dob_src_cnt := Models.Common.countw((string)(ver_dob_sources), ' !$%&()*+,-./;<^|');

ver_dob_src_pop := ver_dob_src_cnt > 0;

ver_dob_src_rcnt := 0;

ver_dob_src_fsrc := Models.Common.getw(ver_dob_sources, 1);

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

ver_dob_src_co_pos := Models.Common.findw_cpp(ver_dob_sources, 'CO' , '  ,', 'ie');

ver_dob_src_co := ver_dob_src_co_pos > 0;

ver_dob_src_cy_pos := Models.Common.findw_cpp(ver_dob_sources, 'CY' , '  ,', 'ie');

ver_dob_src_cy := ver_dob_src_cy_pos > 0;

ver_dob_src_da_pos := Models.Common.findw_cpp(ver_dob_sources, 'DA' , '  ,', 'ie');

ver_dob_src_da := ver_dob_src_da_pos > 0;

ver_dob_src_d_pos := Models.Common.findw_cpp(ver_dob_sources, 'D' , '  ,', 'ie');

ver_dob_src_d := ver_dob_src_d_pos > 0;

ver_dob_src_dl_pos := Models.Common.findw_cpp(ver_dob_sources, 'DL' , '  ,', 'ie');

ver_dob_src_dl := ver_dob_src_dl_pos > 0;

ver_dob_src_ds_pos := Models.Common.findw_cpp(ver_dob_sources, 'DS' , '  ,', 'ie');

ver_dob_src_ds := ver_dob_src_ds_pos > 0;

ver_dob_src_de_pos := Models.Common.findw_cpp(ver_dob_sources, 'DE' , '  ,', 'ie');

ver_dob_src_de := ver_dob_src_de_pos > 0;

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

ver_dob_src_ts_pos := Models.Common.findw_cpp(ver_dob_sources, 'TS' , '  ,', 'ie');

ver_dob_src_ts := ver_dob_src_ts_pos > 0;

ver_dob_src_tu_pos := Models.Common.findw_cpp(ver_dob_sources, 'TU' , '  ,', 'ie');

ver_dob_src_tu := ver_dob_src_tu_pos > 0;

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

email_src_cnt := Models.Common.countw((string)(email_source_list), ' !$%&()*+,-./;<^|');

email_src_pop := email_src_cnt > 0;

email_src_rcnt := 0;

email_src_fsrc := Models.Common.getw(email_source_list, 1);

email_src_aw_pos := Models.Common.findw_cpp(email_source_list, 'AW' , '  ,', 'ie');

email_src_aw := email_src_aw_pos > 0;

email_src_et_pos := Models.Common.findw_cpp(email_source_list, 'ET' , '  ,', 'ie');

email_src_et := email_src_et_pos > 0;

email_src_wa_pos := Models.Common.findw_cpp(email_source_list, 'W@' , '  ,', 'ie');

email_src_wa := email_src_wa_pos > 0;

email_src_om_pos := Models.Common.findw_cpp(email_source_list, 'OM' , '  ,', 'ie');

email_src_om := email_src_om_pos > 0;

email_src_m1_pos := Models.Common.findw_cpp(email_source_list, 'M1' , '  ,', 'ie');

email_src_m1 := email_src_m1_pos > 0;

email_src_sc_pos := Models.Common.findw_cpp(email_source_list, 'SC' , '  ,', 'ie');

email_src_sc := email_src_sc_pos > 0;

email_src_dg_pos := Models.Common.findw_cpp(email_source_list, 'DG' , '  ,', 'ie');

email_src_dg := email_src_dg_pos > 0;

util_type_cnt := Models.Common.countw((string)(util_adl_type_list), ' !$%&()*+,-./;<^|');

util_type_pop := util_type_cnt > 0;

util_type_rcnt := 0;

util_type_fsrc := Models.Common.getw(util_adl_type_list, 1);

util_type_2_pos := Models.Common.findw_cpp(util_adl_type_list, '2' , '  ,', 'ie');

util_type_2 := util_type_2_pos > 0;

util_type_1_pos := Models.Common.findw_cpp(util_adl_type_list, '1' , '  ,', 'ie');

util_type_1 := util_type_1_pos > 0;

util_type_z_pos := Models.Common.findw_cpp(util_adl_type_list, 'Z' , '  ,', 'ie');

util_type_z := util_type_z_pos > 0;

util_inp_cnt := Models.Common.countw((string)(util_add_input_type_list), ' !$%&()*+,-./;<^|');

util_inp_pop := util_inp_cnt > 0;

util_inp_rcnt := 0;

util_inp_fsrc := Models.Common.getw(util_add_input_type_list, 1);

util_inp_2_pos := Models.Common.findw_cpp(util_add_input_type_list, '2' , '  ,', 'ie');

util_inp_2 := util_inp_2_pos > 0;

util_inp_1_pos := Models.Common.findw_cpp(util_add_input_type_list, '1' , '  ,', 'ie');

util_inp_1 := util_inp_1_pos > 0;

util_inp_z_pos := Models.Common.findw_cpp(util_add_input_type_list, 'Z' , '  ,', 'ie');

util_inp_z := util_inp_z_pos > 0;

util_curr_cnt := Models.Common.countw((string)(util_add_curr_type_list), ' !$%&()*+,-./;<^|');

util_curr_pop := util_curr_cnt > 0;

util_curr_rcnt := 0;

util_curr_fsrc := Models.Common.getw(util_add_curr_type_list, 1);

util_curr_2_pos := Models.Common.findw_cpp(util_add_curr_type_list, '2' , '  ,', 'ie');

util_curr_2 := util_curr_2_pos > 0;

util_curr_1_pos := Models.Common.findw_cpp(util_add_curr_type_list, '1' , '  ,', 'ie');

util_curr_1 := util_curr_1_pos > 0;

util_curr_z_pos := Models.Common.findw_cpp(util_add_curr_type_list, 'Z' , '  ,', 'ie');

util_curr_z := util_curr_z_pos > 0;






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





rv_d32_criminal_behavior_lvl := map(
    not(truedid)                                                                                       => NULL,
    felony_count > 0 and not(_felony_last_date_1 = NULL) and sysdate - _felony_last_date_1 < 365       => 6,
    criminal_count > 0 and not(_criminal_last_date_1 = NULL) and sysdate - _criminal_last_date_1 < 365 => 5,
    felony_count > 0                                                                                   => 4,
                                                                                                          min(if(criminal_count = NULL, -NULL, criminal_count), 3));






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
                        

/////iv_rv5_unscorable := if(NAS_Summary <= 4 and NAP_Summary <= 4 and Infutor_NAP <= 4 and Add_Input_NAProp <= 3 and TrueDID = 0 or TrueDID = 0, 1, 0);




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


earliest_header_date := if(max(ver_src_fdate_e4, ver_src_fdate_tn, ver_src_fdate_da, ver_src_fdate_l2, ver_src_fdate_ar, ver_src_fdate_p, ver_src_fdate_e1, ver_src_fdate_en, ver_src_fdate_e3, ver_src_fdate_pl, ver_src_fdate_wp, ver_src_fdate_cg,ver_src_fdate_co, ver_src_fdate_li, ver_src_fdate_ak, ver_src_fdate_ba, ver_src_fdate_fr, ver_src_fdate_v, ver_src_fdate_vo, ver_src_fdate_mw, ver_src_fdate_em, ver_src_fdate_w, ver_src_fdate_de, ver_src_fdate_cy, ver_src_fdate_ts, ver_src_fdate_eb, ver_src_fdate_dl, ver_src_fdate_eq, ver_src_fdate_sl, ver_src_fdate_fe, ver_src_fdate_am, ver_src_fdate_nt, ver_src_fdate_d, ver_src_fdate_ff, ver_src_fdate_ds, ver_src_fdate_e2, ver_src_fdate_tu) = NULL, NULL, min(if(ver_src_fdate_e4 = NULL, -NULL, ver_src_fdate_e4), if(ver_src_fdate_tn = NULL, -NULL, ver_src_fdate_tn), if(ver_src_fdate_da = NULL, -NULL, ver_src_fdate_da), if(ver_src_fdate_l2 = NULL, -NULL, ver_src_fdate_l2), if(ver_src_fdate_ar = NULL, -NULL, ver_src_fdate_ar), if(ver_src_fdate_p = NULL, -NULL, ver_src_fdate_p), if(ver_src_fdate_e1 = NULL, -NULL, ver_src_fdate_e1), if(ver_src_fdate_en = NULL, -NULL, ver_src_fdate_en), if(ver_src_fdate_e3 = NULL, -NULL, ver_src_fdate_e3), if(ver_src_fdate_pl = NULL, -NULL, ver_src_fdate_pl), if(ver_src_fdate_wp = NULL, -NULL, ver_src_fdate_wp), if(ver_src_fdate_cg = NULL, -NULL, ver_src_fdate_cg),if(ver_src_fdate_co = NULL, -NULL, ver_src_fdate_co), if(ver_src_fdate_li = NULL, -NULL, ver_src_fdate_li), if(ver_src_fdate_ak = NULL, -NULL, ver_src_fdate_ak), if(ver_src_fdate_ba = NULL, -NULL, ver_src_fdate_ba), if(ver_src_fdate_fr = NULL, -NULL, ver_src_fdate_fr), if(ver_src_fdate_v = NULL, -NULL, ver_src_fdate_v), if(ver_src_fdate_vo = NULL, -NULL, ver_src_fdate_vo), if(ver_src_fdate_mw = NULL, -NULL, ver_src_fdate_mw), if(ver_src_fdate_em = NULL, -NULL, ver_src_fdate_em), if(ver_src_fdate_w = NULL, -NULL, ver_src_fdate_w), if(ver_src_fdate_de = NULL, -NULL, ver_src_fdate_de), if(ver_src_fdate_cy = NULL, -NULL, ver_src_fdate_cy), if(ver_src_fdate_ts = NULL, -NULL, ver_src_fdate_ts), if(ver_src_fdate_eb = NULL, -NULL, ver_src_fdate_eb), if(ver_src_fdate_dl = NULL, -NULL, ver_src_fdate_dl), if(ver_src_fdate_eq = NULL, -NULL, ver_src_fdate_eq), if(ver_src_fdate_sl = NULL, -NULL, ver_src_fdate_sl), if(ver_src_fdate_fe = NULL, -NULL, ver_src_fdate_fe), if(ver_src_fdate_am = NULL, -NULL, ver_src_fdate_am), if(ver_src_fdate_nt = NULL, -NULL, ver_src_fdate_nt), if(ver_src_fdate_d = NULL, -NULL, ver_src_fdate_d), if(ver_src_fdate_ff = NULL, -NULL, ver_src_fdate_ff), if(ver_src_fdate_ds = NULL, -NULL, ver_src_fdate_ds), if(ver_src_fdate_e2 = NULL, -NULL, ver_src_fdate_e2), if(ver_src_fdate_tu = NULL, -NULL, ver_src_fdate_tu)));







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




final_score_tree_0 := -1.63655796489897;



                                                                                    

 final_score_tree_1_c277 := map(
     NULL < rv_f03_input_add_not_most_rec AND rv_f03_input_add_not_most_rec < 0.5 => -0.0205167975195414,
     rv_f03_input_add_not_most_rec >= 0.5                                         => -0.0666265801138172,
     rv_f03_input_add_not_most_rec = NULL                                         => -0.0288557752845272,
                                                                                     -0.0288557752845272);  


                                                            
 
 final_score_tree_1_c280 := map(
    NULL < rv_c14_addrs_15yr AND rv_c14_addrs_15yr < 4.5 => 0.0315571021602964,
    rv_c14_addrs_15yr >= 4.5                             => 0.0870656952109709,
    rv_c14_addrs_15yr = NULL                             => 0.0496431656106626,
                                                            0.0496431656106626);
 
                                                            


                                                                                    
                                                                                    

final_score_tree_1_c279 := map(
    NULL < rv_f03_input_add_not_most_rec AND rv_f03_input_add_not_most_rec < 0.5 => final_score_tree_1_c280,
    rv_f03_input_add_not_most_rec >= 0.5                                         => -0.0140595978742293,
    rv_f03_input_add_not_most_rec = NULL                                         => 0.0382503697271225,
                                                                                    0.0382503697271225);
                                                                       


                                                                     

 final_score_tree_1_c278 := map(
    NULL < rv_c13_curr_addr_lres AND rv_c13_curr_addr_lres < 66.5 => final_score_tree_1_c279,
    rv_c13_curr_addr_lres >= 66.5                                 => -0.00542761942737506,
    rv_c13_curr_addr_lres = NULL                                  => 0.0117953491958416,
                                                                     0.0117953491958416);

                                                                     



final_score_tree_1 := map(
    NULL < rv_comb_age AND rv_comb_age < 43.5 => final_score_tree_1_c277,
    rv_comb_age >= 43.5                       => final_score_tree_1_c278,
    rv_comb_age = NULL                        => -0.0103395937033092,
                                                 0.000481780389424753);





final_score_tree_2_c283 := map(
    NULL < rv_c13_curr_addr_lres AND rv_c13_curr_addr_lres < 95.5 => 0.0188795379129492,
    rv_c13_curr_addr_lres >= 95.5                                 => -0.0115301592992866,
    rv_c13_curr_addr_lres = NULL                                  => 0.00169979193463061,
                                                                     0.00169979193463061);

final_score_tree_2_c282 := map(
    NULL < iv_bureau_emergence_age AND iv_bureau_emergence_age < 20.5 => -0.0272821515172256,
    iv_bureau_emergence_age >= 20.5                                   => final_score_tree_2_c283,
    iv_bureau_emergence_age = NULL                                    => -0.0291758368706412,
                                                                         -0.0087255762229314);

final_score_tree_2_c285 := map(
    (rv_6seg_riskview_5_0 in ['2 ADDR NOT CURRENT - DEROG', '3 ADDR NOT CURRENT - OTHER', '5 SUFFICIENTLY VERD - OWNER'])           => -0.0019218512497093,
    (rv_6seg_riskview_5_0 in ['0 TRUEDID = 0', '1 VER/VAL PROBLEMS', '4 SUFFICIENTLY VERD - DEROG', '6 SUFFICIENTLY VERD - OTHER']) => 0.0485281807417167,
    rv_6seg_riskview_5_0 = ''                                                                                                     => 0.0189108932636207,
                                                                                                                                       0.0189108932636207);

final_score_tree_2_c284 := map(
    NULL < rv_c12_inp_addr_source_count AND rv_c12_inp_addr_source_count < 0.5 => 0.0875649264718879,
    rv_c12_inp_addr_source_count >= 0.5                                        => final_score_tree_2_c285,
    rv_c12_inp_addr_source_count = NULL                                        => 0.0294902890753669,
                                                                                  0.0294902890753669);

final_score_tree_2 := map(
    NULL < iv_unverified_addr_count AND iv_unverified_addr_count < 4.5 => final_score_tree_2_c282,
    iv_unverified_addr_count >= 4.5                                    => final_score_tree_2_c284,
    iv_unverified_addr_count = NULL                                    => -0.00643540591340127,
                                                                          -0.00112808597726861);

final_score_tree_3_c290 := map(
    (rv_6seg_riskview_5_0 in ['2 ADDR NOT CURRENT - DEROG', '3 ADDR NOT CURRENT - OTHER', '5 SUFFICIENTLY VERD - OWNER'])           => 0.00269152574506015,
    (rv_6seg_riskview_5_0 in ['0 TRUEDID = 0', '1 VER/VAL PROBLEMS', '4 SUFFICIENTLY VERD - DEROG', '6 SUFFICIENTLY VERD - OTHER']) => 0.0557209156961196,
    rv_6seg_riskview_5_0 = ''                                                                                                     => 0.0373092649355348,
                                                                                                                                       0.0373092649355348);

final_score_tree_3_c289 := map(
    NULL < in_addrpop_found AND in_addrpop_found < 0.5 => 0.100906796654616,
    in_addrpop_found >= 0.5                            => final_score_tree_3_c290,
    in_addrpop_found = NULL                            => 0.0507507284277877,
                                                          0.0507507284277877);

final_score_tree_3_c288 := map(
    NULL < rv_f03_input_add_not_most_rec AND rv_f03_input_add_not_most_rec < 0.5 => final_score_tree_3_c289,
    rv_f03_input_add_not_most_rec >= 0.5                                         => -0.0286132193129279,
    rv_f03_input_add_not_most_rec = NULL                                         => 0.0351909542204243,
                                                                                    0.0351909542204243);

final_score_tree_3_c287 := map(
    NULL < rv_c14_addrs_10yr AND rv_c14_addrs_10yr < 2.5 => -0.00101539816607562,
    rv_c14_addrs_10yr >= 2.5                             => final_score_tree_3_c288,
    rv_c14_addrs_10yr = NULL                             => 0.00785067532247097,
                                                            0.00785067532247097);

final_score_tree_3 := map(
    NULL < rv_c20_m_bureau_adl_fs AND rv_c20_m_bureau_adl_fs < 239.5 => -0.0279158003669647,
    rv_c20_m_bureau_adl_fs >= 239.5                                  => final_score_tree_3_c287,
    rv_c20_m_bureau_adl_fs = NULL                                    => -0.00460425907744629,
                                                                        -0.00130100238095788);

final_score_tree_4_c292 := map(
    NULL < rv_f03_input_add_not_most_rec AND rv_f03_input_add_not_most_rec < 0.5 => -0.0115567872414504,
    rv_f03_input_add_not_most_rec >= 0.5                                         => -0.0589891238790983,
    rv_f03_input_add_not_most_rec = NULL                                         => -0.0201313942757902,
                                                                                    -0.0201313942757902);

final_score_tree_4_c295 := map(
    NULL < rv_f03_address_match AND rv_f03_address_match < 3 => -0.0206102537372272,
    rv_f03_address_match >= 3                                => 0.0410896045307022,
    rv_f03_address_match = NULL                              => 0.0255049705535644,
                                                                0.0255049705535644);

final_score_tree_4_c294 := map(
    NULL < rv_c12_inp_addr_source_count AND rv_c12_inp_addr_source_count < 0.5 => 0.0865068094973323,
    rv_c12_inp_addr_source_count >= 0.5                                        => final_score_tree_4_c295,
    rv_c12_inp_addr_source_count = NULL                                        => 0.0347263982213836,
                                                                                  0.0347263982213836);

final_score_tree_4_c293 := map(
    NULL < rv_c14_addrs_15yr AND rv_c14_addrs_15yr < 2.5 => -0.00169045435253437,
    rv_c14_addrs_15yr >= 2.5                             => final_score_tree_4_c294,
    rv_c14_addrs_15yr = NULL                             => 0.0106072617988192,
                                                            0.0106072617988192);

final_score_tree_4 := map(
    NULL < rv_comb_age AND rv_comb_age < 46.5 => final_score_tree_4_c292,
    rv_comb_age >= 46.5                       => final_score_tree_4_c293,
    rv_comb_age = NULL                        => -0.011588113503852,
                                                 0.000292434548599513);

final_score_tree_5_c299 := map(
    NULL < rv_f03_address_match AND rv_f03_address_match < 3 => -0.0123192590055298,
    rv_f03_address_match >= 3                                => 0.0297008653449909,
    rv_f03_address_match = NULL                              => 0.0189334093155846,
                                                                0.0189334093155846);

final_score_tree_5_c298 := map(
    NULL < rv_c12_inp_addr_source_count AND rv_c12_inp_addr_source_count < 0.5 => 0.0725361374469838,
    rv_c12_inp_addr_source_count >= 0.5                                        => final_score_tree_5_c299,
    rv_c12_inp_addr_source_count = NULL                                        => 0.0262844048044062,
                                                                                  0.0262844048044062);

final_score_tree_5_c300 := map(
    NULL < rv_i62_inq_ssns_per_adl AND rv_i62_inq_ssns_per_adl < 2.5 => -0.00575208537410846,
    rv_i62_inq_ssns_per_adl >= 2.5                                   => 0.0658550812453503,
    rv_i62_inq_ssns_per_adl = NULL                                   => -0.00357233354048504,
                                                                        -0.00357233354048504);

final_score_tree_5_c297 := map(
    NULL < rv_c13_curr_addr_lres AND rv_c13_curr_addr_lres < 62.5 => final_score_tree_5_c298,
    rv_c13_curr_addr_lres >= 62.5                                 => final_score_tree_5_c300,
    rv_c13_curr_addr_lres = NULL                                  => 0.00749502494970687,
                                                                     0.00749502494970687);

final_score_tree_5 := map(
    NULL < rv_comb_age AND rv_comb_age < 45.5 => -0.0211486492437838,
    rv_comb_age >= 45.5                       => final_score_tree_5_c297,
    rv_comb_age = NULL                        => -0.0064679904785021,
                                                 -0.00146841843347542);

final_score_tree_6_c303 := map(
    NULL < rv_c13_curr_addr_lres AND rv_c13_curr_addr_lres < 29.5 => 0.0175330175233078,
    rv_c13_curr_addr_lres >= 29.5                                 => -0.00856803456209178,
    rv_c13_curr_addr_lres = NULL                                  => -0.00255970760838794,
                                                                     -0.00255970760838794);

final_score_tree_6_c302 := map(
    NULL < rv_c20_m_bureau_adl_fs AND rv_c20_m_bureau_adl_fs < 174.5 => -0.0353889296692686,
    rv_c20_m_bureau_adl_fs >= 174.5                                  => final_score_tree_6_c303,
    rv_c20_m_bureau_adl_fs = NULL                                    => -0.00791952213508146,
                                                                        -0.00791952213508146);

final_score_tree_6_c305 := map(
    NULL < rv_c13_attr_addrs_recency AND rv_c13_attr_addrs_recency < 48 => 0.107887698459572,
    rv_c13_attr_addrs_recency >= 48                                     => 0.0191491586566862,
    rv_c13_attr_addrs_recency = NULL                                    => 0.0641003864175329,
                                                                           0.0641003864175329);

final_score_tree_6_c304 := map(
    NULL < rv_c12_inp_addr_source_count AND rv_c12_inp_addr_source_count < 0.5 => final_score_tree_6_c305,
    rv_c12_inp_addr_source_count >= 0.5                                        => 0.0158496218725137,
    rv_c12_inp_addr_source_count = NULL                                        => 0.0232751414944972,
                                                                                  0.0232751414944972);

final_score_tree_6 := map(
    NULL < iv_unverified_addr_count AND iv_unverified_addr_count < 4.5 => final_score_tree_6_c302,
    iv_unverified_addr_count >= 4.5                                    => final_score_tree_6_c304,
    iv_unverified_addr_count = NULL                                    => 0.0176747706838803,
                                                                          -0.00136420695379371);

final_score_tree_7_c307 := map(
    NULL < iv_c14_addrs_per_adl AND iv_c14_addrs_per_adl < 8.5 => 0.0149613722755787,
    iv_c14_addrs_per_adl >= 8.5                                => 0.0670219157531089,
    iv_c14_addrs_per_adl = NULL                                => 0.0278042326488251,
                                                                  0.0278042326488251);

final_score_tree_7_c309 := map(
    NULL < rv_c22_inp_addr_occ_index AND rv_c22_inp_addr_occ_index < 3.5 => -0.0452390622405959,
    rv_c22_inp_addr_occ_index >= 3.5                                     => 0.0174669964315542,
    rv_c22_inp_addr_occ_index = NULL                                     => -0.0300362361006375,
                                                                            -0.0300362361006375);

final_score_tree_7_c310 := map(
    NULL < iv_unverified_addr_count AND iv_unverified_addr_count < 1.5 => -0.0113689801350602,
    iv_unverified_addr_count >= 1.5                                    => 0.0133328225841864,
    iv_unverified_addr_count = NULL                                    => 0.00170709016574923,
                                                                          0.00170709016574923);

final_score_tree_7_c308 := map(
    NULL < rv_f03_address_match AND rv_f03_address_match < 3 => final_score_tree_7_c309,
    rv_f03_address_match >= 3                                => final_score_tree_7_c310,
    rv_f03_address_match = NULL                              => -0.00542951227861372,
                                                                -0.00542951227861372);

final_score_tree_7 := map(
    NULL < rv_c12_inp_addr_source_count AND rv_c12_inp_addr_source_count < 0.5 => final_score_tree_7_c307,
    rv_c12_inp_addr_source_count >= 0.5                                        => final_score_tree_7_c308,
    rv_c12_inp_addr_source_count = NULL                                        => 0.00587008535619763,
                                                                                  -0.000971937583961487);

final_score_tree_8_c315 := map(
    NULL < rv_c12_inp_addr_source_count AND rv_c12_inp_addr_source_count < 0.5 => 0.0496900209970994,
    rv_c12_inp_addr_source_count >= 0.5                                        => 0.0121539071279197,
    rv_c12_inp_addr_source_count = NULL                                        => 0.017765908127347,
                                                                                  0.017765908127347);

final_score_tree_8_c314 := map(
    NULL < rv_a44_curr_add_naprop AND rv_a44_curr_add_naprop < 1.5 => final_score_tree_8_c315,
    rv_a44_curr_add_naprop >= 1.5                                  => -0.00289482595689953,
    rv_a44_curr_add_naprop = NULL                                  => 0.00652026821493431,
                                                                      0.00652026821493431);

final_score_tree_8_c313 := map(
    NULL < iv_bureau_emergence_age AND iv_bureau_emergence_age < 53.5 or rv_comb_age >= 62 => final_score_tree_8_c314,
    iv_bureau_emergence_age >= 53.5 and rv_comb_age < 62                                   => -0.0310243236551873,
    iv_bureau_emergence_age = NULL                                                         => -0.0195853039875234,
                                                                                              0.00267200404274278);

final_score_tree_8_c312 := map(
    NULL < rv_i62_inq_num_names_per_adl AND rv_i62_inq_num_names_per_adl < 0.5 => final_score_tree_8_c313,
    rv_i62_inq_num_names_per_adl >= 0.5                                        => 0.0439720493408099,
    rv_i62_inq_num_names_per_adl = NULL                                        => 0.00768184918770823,
                                                                                  0.00768184918770823);

final_score_tree_8 := map(
    NULL < rv_comb_age AND rv_comb_age < 46.5 => -0.0156530984560319,
    rv_comb_age >= 46.5                       => final_score_tree_8_c312,
    rv_comb_age = NULL                        => -0.00914092070176611,
                                                 -9.23693303490368e-05);

final_score_tree_9_c317 := map(
    NULL < iv_bureau_emergence_age AND iv_bureau_emergence_age < 23.5 => -0.0195661280797274,
    iv_bureau_emergence_age >= 23.5                                   => 0.00396344113876583,
    iv_bureau_emergence_age = NULL                                    => -0.0237186536625474,
                                                                         -0.00507278024531466);

final_score_tree_9_c319 := map(
    NULL < rv_i60_inq_count12 AND rv_i60_inq_count12 < 4.5 => 0.0475522745544827,
    rv_i60_inq_count12 >= 4.5                              => 0.158775164511114,
    rv_i60_inq_count12 = NULL                              => 0.0636663769842141,
                                                              0.0636663769842141);

final_score_tree_9_c320 := map(
    NULL < rv_f03_address_match AND rv_f03_address_match < 3 => -0.0247908581125354,
    rv_f03_address_match >= 3                                => 0.0264015051024604,
    rv_f03_address_match = NULL                              => 0.0122109112024802,
                                                                0.0122109112024802);

final_score_tree_9_c318 := map(
    NULL < in_addrpop_found AND in_addrpop_found < 0.5 => final_score_tree_9_c319,
    in_addrpop_found >= 0.5                            => final_score_tree_9_c320,
    in_addrpop_found = NULL                            => 0.0205721855530508,
                                                          0.0205721855530508);

final_score_tree_9 := map(
    NULL < rv_i62_inq_num_names_per_adl AND rv_i62_inq_num_names_per_adl < 0.5 => final_score_tree_9_c317,
    rv_i62_inq_num_names_per_adl >= 0.5                                        => final_score_tree_9_c318,
    rv_i62_inq_num_names_per_adl = NULL                                        => 0.0100504737390961,
                                                                                  -9.55355032001299e-05);

final_score_tree_10_c324 := map(
    NULL < rv_a44_curr_add_naprop AND rv_a44_curr_add_naprop < 1.5 => 0.0104759653110058,
    rv_a44_curr_add_naprop >= 1.5                                  => -0.00773914570272073,
    rv_a44_curr_add_naprop = NULL                                  => 0.000717026288667531,
                                                                      0.000717026288667531);

final_score_tree_10_c323 := map(
    NULL < rv_c20_m_bureau_adl_fs AND rv_c20_m_bureau_adl_fs < 155.5 => -0.0289231873809868,
    rv_c20_m_bureau_adl_fs >= 155.5                                  => final_score_tree_10_c324,
    rv_c20_m_bureau_adl_fs = NULL                                    => -0.00293117886902517,
                                                                        -0.00293117886902517);

final_score_tree_10_c322 := map(
    NULL < iv_c14_addrs_per_adl AND iv_c14_addrs_per_adl < 8.5 => final_score_tree_10_c323,
    iv_c14_addrs_per_adl >= 8.5                                => 0.0292135230291297,
    iv_c14_addrs_per_adl = NULL                                => 0.0019504100918889,
                                                                  0.0019504100918889);

final_score_tree_10_c325 := map(
    NULL < rv_c22_inp_addr_occ_index AND rv_c22_inp_addr_occ_index < 3.5 => -0.0418454673712787,
    rv_c22_inp_addr_occ_index >= 3.5                                     => 0.0132477386906624,
    rv_c22_inp_addr_occ_index = NULL                                     => -0.0282167705832011,
                                                                            -0.0282167705832011);

final_score_tree_10 := map(
    NULL < rv_f03_input_add_not_most_rec AND rv_f03_input_add_not_most_rec < 0.5 => final_score_tree_10_c322,
    rv_f03_input_add_not_most_rec >= 0.5                                         => final_score_tree_10_c325,
    rv_f03_input_add_not_most_rec = NULL                                         => -0.00332587329614131,
                                                                                    -0.00290909125643069);

final_score_tree_11_c327 := map(
    NULL < rv_i60_inq_count12 AND rv_i60_inq_count12 < 3.5 => 0.0169252150808485,
    rv_i60_inq_count12 >= 3.5                              => 0.109610359186718,
    rv_i60_inq_count12 = NULL                              => 0.0217919037511492,
                                                              0.0217919037511492);

final_score_tree_11_c329 := map(
    NULL < rv_c22_inp_addr_occ_index AND rv_c22_inp_addr_occ_index < 3.5 => -0.0407199003339781,
    rv_c22_inp_addr_occ_index >= 3.5                                     => 0.00909134775783401,
    rv_c22_inp_addr_occ_index = NULL                                     => -0.0286221727713317,
                                                                            -0.0286221727713317);

final_score_tree_11_c330 := map(
    NULL < rv_d30_derog_count AND rv_d30_derog_count < 0.5 => -0.00352212338236308,
    rv_d30_derog_count >= 0.5                              => 0.0201798546656674,
    rv_d30_derog_count = NULL                              => 0.00131774031251202,
                                                              0.00131774031251202);

final_score_tree_11_c328 := map(
    NULL < rv_f03_address_match AND rv_f03_address_match < 3 => final_score_tree_11_c329,
    rv_f03_address_match >= 3                                => final_score_tree_11_c330,
    rv_f03_address_match = NULL                              => -0.00542324517404861,
                                                                -0.00542324517404861);

final_score_tree_11 := map(
    NULL < rv_c12_inp_addr_source_count AND rv_c12_inp_addr_source_count < 0.5 => final_score_tree_11_c327,
    rv_c12_inp_addr_source_count >= 0.5                                        => final_score_tree_11_c328,
    rv_c12_inp_addr_source_count = NULL                                        => -0.00388186711675299,
                                                                                  -0.00190335180775118);

final_score_tree_12_c333 := map(
    NULL < rv_i62_inq_ssns_per_adl AND rv_i62_inq_ssns_per_adl < 3.5 => -0.00148478380798919,
    rv_i62_inq_ssns_per_adl >= 3.5                                   => 0.0393746434771505,
    rv_i62_inq_ssns_per_adl = NULL                                   => 0.000673675003890575,
                                                                        0.000673675003890575);

final_score_tree_12_c332 := map(
    NULL < rv_f03_input_add_not_most_rec AND rv_f03_input_add_not_most_rec < 0.5 => final_score_tree_12_c333,
    rv_f03_input_add_not_most_rec >= 0.5                                         => -0.0237376809717556,
    rv_f03_input_add_not_most_rec = NULL                                         => -0.00322294722818692,
                                                                                    -0.00322294722818692);

final_score_tree_12_c335 := map(
    (rv_6seg_riskview_5_0 in ['2 ADDR NOT CURRENT - DEROG', '3 ADDR NOT CURRENT - OTHER', '5 SUFFICIENTLY VERD - OWNER'])           => -0.00210782218926258,
    (rv_6seg_riskview_5_0 in ['0 TRUEDID = 0', '1 VER/VAL PROBLEMS', '4 SUFFICIENTLY VERD - DEROG', '6 SUFFICIENTLY VERD - OTHER']) => 0.0371587090445601,
    rv_6seg_riskview_5_0 = ''                                                                                                     => 0.0148886207150699,
                                                                                                                                       0.0148886207150699);

final_score_tree_12_c334 := map(
    NULL < rv_c22_inp_addr_occ_index AND rv_c22_inp_addr_occ_index < 3.5 => final_score_tree_12_c335,
    rv_c22_inp_addr_occ_index >= 3.5                                     => 0.0565043521238766,
    rv_c22_inp_addr_occ_index = NULL                                     => 0.0220684865575064,
                                                                            0.0220684865575064);

final_score_tree_12 := map(
    NULL < iv_unverified_addr_count AND iv_unverified_addr_count < 5.5 => final_score_tree_12_c332,
    iv_unverified_addr_count >= 5.5                                    => final_score_tree_12_c334,
    iv_unverified_addr_count = NULL                                    => -0.00881876825000786,
                                                                          0.000267374403887073);

final_score_tree_13_c337 := map(
    NULL < rv_i62_inq_ssns_per_adl AND rv_i62_inq_ssns_per_adl < 1.5 => -0.0208103631754148,
    rv_i62_inq_ssns_per_adl >= 1.5                                   => 0.0110106993422178,
    rv_i62_inq_ssns_per_adl = NULL                                   => -0.0139701408586114,
                                                                        -0.0139701408586114);

final_score_tree_13_c339 := map(
    NULL < rv_c14_addrs_15yr AND rv_c14_addrs_15yr < 4.5 => 0.0184189343957561,
    rv_c14_addrs_15yr >= 4.5                             => 0.0495537775930992,
    rv_c14_addrs_15yr = NULL                             => 0.0288980259225206,
                                                            0.0288980259225206);

final_score_tree_13_c340 := map(
    NULL < rv_c14_addrs_10yr AND rv_c14_addrs_10yr < 1.5 => -0.00417984079574778,
    rv_c14_addrs_10yr >= 1.5                             => 0.0156072526442767,
    rv_c14_addrs_10yr = NULL                             => 0.000918408335614448,
                                                            0.000918408335614448);

final_score_tree_13_c338 := map(
    NULL < rv_c13_curr_addr_lres AND rv_c13_curr_addr_lres < 27.5 => final_score_tree_13_c339,
    rv_c13_curr_addr_lres >= 27.5                                 => final_score_tree_13_c340,
    rv_c13_curr_addr_lres = NULL                                  => 0.00675136508438472,
                                                                     0.00675136508438472);

final_score_tree_13 := map(
    NULL < rv_comb_age AND rv_comb_age < 46.5 => final_score_tree_13_c337,
    rv_comb_age >= 46.5                       => final_score_tree_13_c338,
    rv_comb_age = NULL                        => 0.00130872693494399,
                                                 5.81948712614292e-05);

final_score_tree_14_c344 := map(
    NULL < rv_c12_inp_addr_source_count AND rv_c12_inp_addr_source_count < 0.5 => 0.0365887330227238,
    rv_c12_inp_addr_source_count >= 0.5                                        => 0.00851954508541107,
    rv_c12_inp_addr_source_count = NULL                                        => 0.0121390452865805,
                                                                                  0.0121390452865805);

final_score_tree_14_c343 := map(
    NULL < rv_c13_curr_addr_lres AND rv_c13_curr_addr_lres < 61.5 => final_score_tree_14_c344,
    rv_c13_curr_addr_lres >= 61.5                                 => -0.00421378589218692,
    rv_c13_curr_addr_lres = NULL                                  => 0.00146359569740415,
                                                                     0.00146359569740415);

final_score_tree_14_c345 := map(
    NULL < rv_c12_inp_addr_source_count AND rv_c12_inp_addr_source_count < 0.5 => 0.0571692825794743,
    rv_c12_inp_addr_source_count >= 0.5                                        => 0.0240217136463888,
    rv_c12_inp_addr_source_count = NULL                                        => 0.0292059305885301,
                                                                                  0.0292059305885301);

final_score_tree_14_c342 := map(
    NULL < rv_i62_inq_num_names_per_adl AND rv_i62_inq_num_names_per_adl < 0.5 => final_score_tree_14_c343,
    rv_i62_inq_num_names_per_adl >= 0.5                                        => final_score_tree_14_c345,
    rv_i62_inq_num_names_per_adl = NULL                                        => 0.00519738809795691,
                                                                                  0.00519738809795691);

final_score_tree_14 := map(
    NULL < rv_comb_age AND rv_comb_age < 43.5 => -0.0159946254809891,
    rv_comb_age >= 43.5                       => final_score_tree_14_c342,
    rv_comb_age = NULL                        => 0.00429507216232059,
                                                 -0.000411814520977721);

final_score_tree_15_c349 := map(
    NULL < iv_wealth_index AND iv_wealth_index < 3.5 => 0.0141068876905692,
    iv_wealth_index >= 3.5                           => -0.0222357714663598,
    iv_wealth_index = NULL                           => 0.0066748055485736,
                                                        0.0066748055485736);

final_score_tree_15_c348 := map(
    NULL < iv_bureau_emergence_age AND iv_bureau_emergence_age < 29.5 => final_score_tree_15_c349,
    iv_bureau_emergence_age >= 29.5                                   => 0.0376553680117316,
    iv_bureau_emergence_age = NULL                                    => -0.00158109192314246,
                                                                         0.0135060311634265);

final_score_tree_15_c347 := map(
    NULL < iv_c14_addrs_per_adl AND iv_c14_addrs_per_adl < 6.5 => -0.00376274345962916,
    iv_c14_addrs_per_adl >= 6.5                                => final_score_tree_15_c348,
    iv_c14_addrs_per_adl = NULL                                => 0.00112160134457033,
                                                                  0.00112160134457033);

final_score_tree_15_c350 := map(
    NULL < rv_c22_inp_addr_occ_index AND rv_c22_inp_addr_occ_index < 3.5 => -0.0376951952227944,
    rv_c22_inp_addr_occ_index >= 3.5                                     => 0.0137514123558762,
    rv_c22_inp_addr_occ_index = NULL                                     => -0.0249475984417859,
                                                                            -0.0249475984417859);

final_score_tree_15 := map(
    NULL < rv_f03_input_add_not_most_rec AND rv_f03_input_add_not_most_rec < 0.5 => final_score_tree_15_c347,
    rv_f03_input_add_not_most_rec >= 0.5                                         => final_score_tree_15_c350,
    rv_f03_input_add_not_most_rec = NULL                                         => 0.00563551470456464,
                                                                                    -0.00296667030384665);

final_score_tree_16_c354 := map(
    NULL < rv_comb_age => 0.00579454456365124,
    rv_comb_age = NULL => 0.00309586605455753,
                          0.00309586605455753);

final_score_tree_16_c353 := map(
    NULL < iv_bureau_emergence_age AND iv_bureau_emergence_age < 22.5 => -0.0165448890866536,
    iv_bureau_emergence_age >= 22.5                                   => final_score_tree_16_c354,
    iv_bureau_emergence_age = NULL                                    => 0.00630859562653814,
                                                                         -0.00249856370153983);

final_score_tree_16_c355 := map(
    NULL < rv_c12_inp_addr_source_count AND rv_c12_inp_addr_source_count < 0.5 => 0.0505088070141958,
    rv_c12_inp_addr_source_count >= 0.5                                        => 0.0176876979594822,
    rv_c12_inp_addr_source_count = NULL                                        => 0.0230933886777007,
                                                                                  0.0230933886777007);

final_score_tree_16_c352 := map(
    NULL < rv_i62_inq_num_names_per_adl AND rv_i62_inq_num_names_per_adl < 0.5 => final_score_tree_16_c353,
    rv_i62_inq_num_names_per_adl >= 0.5                                        => final_score_tree_16_c355,
    rv_i62_inq_num_names_per_adl = NULL                                        => 0.0020363418513961,
                                                                                  0.0020363418513961);

final_score_tree_16 := map(
    NULL < rv_c20_m_bureau_adl_fs AND rv_c20_m_bureau_adl_fs < 170.5 => -0.0269412585304216,
    rv_c20_m_bureau_adl_fs >= 170.5                                  => final_score_tree_16_c352,
    rv_c20_m_bureau_adl_fs = NULL                                    => 0.00192929240940765,
                                                                        -0.00153289855942134);

final_score_tree_17_c358 := map(
    (rv_6seg_riskview_5_0 in ['2 ADDR NOT CURRENT - DEROG', '3 ADDR NOT CURRENT - OTHER', '5 SUFFICIENTLY VERD - OWNER'])           => -0.0318240959512145,
    (rv_6seg_riskview_5_0 in ['0 TRUEDID = 0', '1 VER/VAL PROBLEMS', '4 SUFFICIENTLY VERD - DEROG', '6 SUFFICIENTLY VERD - OTHER']) => -0.00326119841581413,
    rv_6seg_riskview_5_0 = ''                                                                                                     => -0.0159457977705096,
                                                                                                                                       -0.0159457977705096);

final_score_tree_17_c357 := map(
    NULL < rv_c22_inp_addr_occ_index AND rv_c22_inp_addr_occ_index < 3.5 => final_score_tree_17_c358,
    rv_c22_inp_addr_occ_index >= 3.5                                     => 0.0161787068597457,
    rv_c22_inp_addr_occ_index = NULL                                     => -0.0109494569752462,
                                                                            -0.0109494569752462);

final_score_tree_17_c360 := map(
    NULL < rv_comb_age AND rv_comb_age < 73.5 => 0.0182184475557389,
    rv_comb_age >= 73.5                       => -0.0074063962140964,
    rv_comb_age = NULL                        => 0.0130203583325418,
                                                 0.0130203583325418);

final_score_tree_17_c359 := map(
    NULL < rv_c13_curr_addr_lres AND rv_c13_curr_addr_lres < 141.5 => final_score_tree_17_c360,
    rv_c13_curr_addr_lres >= 141.5                                 => -0.00480888594853777,
    rv_c13_curr_addr_lres = NULL                                   => 0.00528204646227218,
                                                                      0.00528204646227218);

final_score_tree_17 := map(
    NULL < rv_comb_age AND rv_comb_age < 49.5 => final_score_tree_17_c357,
    rv_comb_age >= 49.5                       => final_score_tree_17_c359,
    rv_comb_age = NULL                        => -0.00347650207335996,
                                                 -0.000875572576825546);

final_score_tree_18_c364 := map(
    NULL < rv_f03_input_add_not_most_rec AND rv_f03_input_add_not_most_rec < 0.5 => 0.0206144815959487,
    rv_f03_input_add_not_most_rec >= 0.5                                         => -0.0054993390018121,
    rv_f03_input_add_not_most_rec = NULL                                         => 0.0155143346721368,
                                                                                    0.0155143346721368);

final_score_tree_18_c363 := map(
    NULL < rv_l80_inp_avm_autoval AND rv_l80_inp_avm_autoval < 79041.5 => final_score_tree_18_c364,
    rv_l80_inp_avm_autoval >= 79041.5                                  => -0.00384780017544775,
    rv_l80_inp_avm_autoval = NULL                                      => 0.0109899040737789,
                                                                          0.0109899040737789);

final_score_tree_18_c365 := map(
    NULL < rv_comb_age AND rv_comb_age < 51.5 => -0.0333079635145153,
    rv_comb_age >= 51.5                       => 0.000106671921319949,
    rv_comb_age = NULL                        => -0.00867296771072686,
                                                 -0.00867296771072686);

final_score_tree_18_c362 := map(
    NULL < iv_wealth_index AND iv_wealth_index < 3.5 => final_score_tree_18_c363,
    iv_wealth_index >= 3.5                           => final_score_tree_18_c365,
    iv_wealth_index = NULL                           => 0.00548026656452049,
                                                        0.00548026656452049);

final_score_tree_18 := map(
    NULL < iv_unverified_addr_count AND iv_unverified_addr_count < 1.5 => -0.0106121071620473,
    iv_unverified_addr_count >= 1.5                                    => final_score_tree_18_c362,
    iv_unverified_addr_count = NULL                                    => 0.00307323169863259,
                                                                          -0.00177731998177122);

final_score_tree_19_c369 := map(
    NULL < rv_c20_m_bureau_adl_fs AND rv_c20_m_bureau_adl_fs < 172.5 => -0.0140664363064701,
    rv_c20_m_bureau_adl_fs >= 172.5                                  => 0.0134271780504942,
    rv_c20_m_bureau_adl_fs = NULL                                    => 0.0080198587518976,
                                                                        0.0080198587518976);

final_score_tree_19_c368 := map(
    NULL < rv_c13_curr_addr_lres AND rv_c13_curr_addr_lres < 49.5 => final_score_tree_19_c369,
    rv_c13_curr_addr_lres >= 49.5                                 => -0.00464164217646046,
    rv_c13_curr_addr_lres = NULL                                  => -8.4117528958556e-05,
                                                                     -8.4117528958556e-05);

final_score_tree_19_c367 := map(
    (iv_college_file_type in ['A', 'C', 'H']) => -0.0263613616562662,
    (iv_college_file_type in ['-1'])          => final_score_tree_19_c368,
    iv_college_file_type = ''               => -0.01953267659539,
                                                 -0.00326266899623846);

final_score_tree_19_c370 := map(
    NULL < rv_c13_inp_addr_lres AND rv_c13_inp_addr_lres < 25.5 => 0.0308416263582937,
    rv_c13_inp_addr_lres >= 25.5                                => 0.00579433072849212,
    rv_c13_inp_addr_lres = NULL                                 => 0.0167543781050252,
                                                                   0.0167543781050252);

final_score_tree_19 := map(
    NULL < iv_unverified_addr_count AND iv_unverified_addr_count < 5.5 => final_score_tree_19_c367,
    iv_unverified_addr_count >= 5.5                                    => final_score_tree_19_c370,
    iv_unverified_addr_count = NULL                                    => -0.00802242070218567,
                                                                          -0.000554359761214429);

final_score_tree_20_c373 := map(
    NULL < rv_i60_inq_banking_count12 AND rv_i60_inq_banking_count12 < 0.5 => -0.0125974266742689,
    rv_i60_inq_banking_count12 >= 0.5                                      => 0.0481741416266655,
    rv_i60_inq_banking_count12 = NULL                                      => -0.0107955146915226,
                                                                              -0.0107955146915226);

final_score_tree_20_c375 := map(
    NULL < rv_c13_inp_addr_lres AND rv_c13_inp_addr_lres < 24.5 => 0.0184412945514518,
    rv_c13_inp_addr_lres >= 24.5                                => 0.00201227197015591,
    rv_c13_inp_addr_lres = NULL                                 => 0.00641807675036809,
                                                                   0.00641807675036809);

final_score_tree_20_c374 := map(
    NULL < rv_comb_age => final_score_tree_20_c375,
    rv_comb_age = NULL => 0.0033471028339255,
                          0.0033471028339255);

final_score_tree_20_c372 := map(
    NULL < iv_bureau_emergence_age AND iv_bureau_emergence_age < 23.5 => final_score_tree_20_c373,
    iv_bureau_emergence_age >= 23.5                                   => final_score_tree_20_c374,
    iv_bureau_emergence_age = NULL                                    => 0.00990548895051687,
                                                                         -0.00236456885935566);

final_score_tree_20 := map(
    NULL < rv_s66_adlperssn_count AND rv_s66_adlperssn_count < 2.5 => final_score_tree_20_c372,
    rv_s66_adlperssn_count >= 2.5                                  => 0.0154814597283701,
    rv_s66_adlperssn_count = NULL                                  => -0.0158509702885746,
                                                                      -0.000551315852285101);

final_score_tree_21_c379 := map(
    NULL < (integer)iv_nas_fname_verd AND (integer)iv_nas_fname_verd < 0.5 => -0.0624393477327756,
    (integer)iv_nas_fname_verd >= 0.5                             => -0.000480231781135941,
    (integer)iv_nas_fname_verd = NULL                             => -0.00105336868623874,
                                                            -0.00105336868623874);

final_score_tree_21_c378 := map(
    NULL < rv_i62_inq_ssns_per_adl AND rv_i62_inq_ssns_per_adl < 4.5 => final_score_tree_21_c379,
    rv_i62_inq_ssns_per_adl >= 4.5                                   => 0.0277225461438987,
    rv_i62_inq_ssns_per_adl = NULL                                   => 0.000140721253586045,
                                                                        0.000140721253586045);

final_score_tree_21_c380 := map(
    NULL < iv_prv_addr_lres AND iv_prv_addr_lres < 62.5 => -0.0367544934011629,
    iv_prv_addr_lres >= 62.5                            => -0.00539689348040207,
    iv_prv_addr_lres = NULL                             => -0.0219677681531081,
                                                           -0.0219677681531081);

final_score_tree_21_c377 := map(
    NULL < rv_f03_input_add_not_most_rec AND rv_f03_input_add_not_most_rec < 0.5 => final_score_tree_21_c378,
    rv_f03_input_add_not_most_rec >= 0.5                                         => final_score_tree_21_c380,
    rv_f03_input_add_not_most_rec = NULL                                         => -0.0034174527188149,
                                                                                    -0.0034174527188149);

final_score_tree_21 := map(
    NULL < iv_unverified_addr_count AND iv_unverified_addr_count < 7.5 => final_score_tree_21_c377,
    iv_unverified_addr_count >= 7.5                                    => 0.0201865371188166,
    iv_unverified_addr_count = NULL                                    => 0.0103587717749849,
                                                                          -0.00149227719253642);

final_score_tree_22_c383 := map(
    NULL < rv_comb_age => 0.00236891713038905,
    rv_comb_age = NULL => 0.0115023985592499,
                          0.000574201991088021);

final_score_tree_22_c382 := map(
    (iv_college_file_type in ['A', 'C', 'H']) => -0.025985906510294,
    (iv_college_file_type in ['-1'])          => final_score_tree_22_c383,
    iv_college_file_type = ''               => -0.0185745178065514,
                                                 -0.00263197212178916);

final_score_tree_22_c385 := map(
    NULL < rv_f03_input_add_not_most_rec AND rv_f03_input_add_not_most_rec < 0.5 => 0.0381348738419259,
    rv_f03_input_add_not_most_rec >= 0.5                                         => -0.00354145634244393,
    rv_f03_input_add_not_most_rec = NULL                                         => 0.0294806110892538,
                                                                                    0.0294806110892538);

final_score_tree_22_c384 := map(
    NULL < rv_c13_curr_addr_lres AND rv_c13_curr_addr_lres < 23.5 => final_score_tree_22_c385,
    rv_c13_curr_addr_lres >= 23.5                                 => 0.00527748378316004,
    rv_c13_curr_addr_lres = NULL                                  => 0.0124140873797501,
                                                                     0.0124140873797501);

final_score_tree_22 := map(
    NULL < iv_unverified_addr_count AND iv_unverified_addr_count < 4.5 => final_score_tree_22_c382,
    iv_unverified_addr_count >= 4.5                                    => final_score_tree_22_c384,
    iv_unverified_addr_count = NULL                                    => -0.0049241849034017,
                                                                          0.000301673157634219);

final_score_tree_23_c390 := map(
    NULL < rv_c20_m_bureau_adl_fs AND rv_c20_m_bureau_adl_fs < 154.5 => -0.00628064440401663,
    rv_c20_m_bureau_adl_fs >= 154.5                                  => 0.0240300626944683,
    rv_c20_m_bureau_adl_fs = NULL                                    => 0.0182584711278734,
                                                                        0.0182584711278734);

final_score_tree_23_c389 := map(
    NULL < rv_f03_input_add_not_most_rec AND rv_f03_input_add_not_most_rec < 0.5 => final_score_tree_23_c390,
    rv_f03_input_add_not_most_rec >= 0.5                                         => -0.0103292569634575,
    rv_f03_input_add_not_most_rec = NULL                                         => 0.012803165136113,
                                                                                    0.012803165136113);

final_score_tree_23_c388 := map(
    NULL < iv_estimated_income AND iv_estimated_income < 46500 => final_score_tree_23_c389,
    iv_estimated_income >= 46500                               => -0.0217490947753833,
    iv_estimated_income = NULL                                 => 0.0091309861155655,
                                                                  0.0091309861155655);

final_score_tree_23_c387 := map(
    NULL < rv_c13_curr_addr_lres AND rv_c13_curr_addr_lres < 27.5 => final_score_tree_23_c388,
    rv_c13_curr_addr_lres >= 27.5                                 => -0.00241828804447592,
    rv_c13_curr_addr_lres = NULL                                  => 0.000566236060360134,
                                                                     0.000566236060360134);

final_score_tree_23 := map(
    (iv_college_file_type in ['A', 'C', 'H']) => -0.0238795052855198,
    (iv_college_file_type in ['-1'])          => final_score_tree_23_c387,
    iv_college_file_type = ''               => -0.0119204150052577,
                                                 -0.00198259606920104);

final_score_tree_24_c395 := map(
    NULL < rv_c14_addrs_15yr AND rv_c14_addrs_15yr < 2.5 => 0.0035498470235306,
    rv_c14_addrs_15yr >= 2.5                             => 0.0225366918996689,
    rv_c14_addrs_15yr = NULL                             => 0.00927702646157887,
                                                            0.00927702646157887);

final_score_tree_24_c394 := map(
    NULL < iv_header_emergence_age AND iv_header_emergence_age < 27.5 => -0.00305229634199861,
    iv_header_emergence_age >= 27.5                                   => final_score_tree_24_c395,
    iv_header_emergence_age = NULL                                    => 0.00244609788988802,
                                                                         0.00244609788988802);

final_score_tree_24_c393 := map(
    NULL < iv_bureau_emergence_age AND iv_bureau_emergence_age < 53.5 or rv_comb_age >= 62 => final_score_tree_24_c394,
    iv_bureau_emergence_age >= 53.5 and rv_comb_age < 62                                   => -0.02461088403334,
    iv_bureau_emergence_age = NULL                                                         => -0.00358640823089795,
                                                                                              0.000527925074621772);

final_score_tree_24_c392 := map(
    NULL < rv_e55_college_ind AND rv_e55_college_ind < 0.5 => final_score_tree_24_c393,
    rv_e55_college_ind >= 0.5                              => -0.0199874524175949,
    rv_e55_college_ind = NULL                              => -0.00155904911880279,
                                                              -0.00155904911880279);

final_score_tree_24 := map(
    NULL < rv_d31_bk_disposed_recent_count AND rv_d31_bk_disposed_recent_count < 0.5 => final_score_tree_24_c392,
    rv_d31_bk_disposed_recent_count >= 0.5                                           => 0.0507233986011082,
    rv_d31_bk_disposed_recent_count = NULL                                           => 0.00251777511708436,
                                                                                        -0.000760705537019059);

final_score_tree_25_c398 := map(
    NULL < rv_c13_curr_addr_lres AND rv_c13_curr_addr_lres < 37.5 => 0.0109026128624517,
    rv_c13_curr_addr_lres >= 37.5                                 => -0.000940494671307222,
    rv_c13_curr_addr_lres = NULL                                  => 0.00341098407337681,
                                                                     0.00341098407337681);

final_score_tree_25_c400 := map(
    NULL < iv_num_non_bureau_sources AND iv_num_non_bureau_sources < 2.5 => 0.0178971692533007,
    iv_num_non_bureau_sources >= 2.5                                     => 0.153502387182799,
    iv_num_non_bureau_sources = NULL                                     => 0.0921809099573273,
                                                                            0.0921809099573273);

final_score_tree_25_c399 := map(
    NULL < in_addrpop_found AND in_addrpop_found < 0.5 => final_score_tree_25_c400,
    in_addrpop_found >= 0.5                            => 0.0242846416193474,
    in_addrpop_found = NULL                            => 0.0349782055961457,
                                                          0.0349782055961457);

final_score_tree_25_c397 := map(
    NULL < rv_i62_inq_ssns_per_adl AND rv_i62_inq_ssns_per_adl < 5.5 => final_score_tree_25_c398,
    rv_i62_inq_ssns_per_adl >= 5.5                                   => final_score_tree_25_c399,
    rv_i62_inq_ssns_per_adl = NULL                                   => -0.00522319625182018,
                                                                        0.00456035443782475);

final_score_tree_25 := map(
    NULL < rv_l80_inp_avm_autoval AND rv_l80_inp_avm_autoval < 42775 => final_score_tree_25_c397,
    rv_l80_inp_avm_autoval >= 42775                                  => -0.0083010545602458,
    rv_l80_inp_avm_autoval = NULL                                    => -0.000656222875173642,
                                                                        -0.000656222875173642);

final_score_tree_26_c404 := map(
    NULL < rv_comb_age AND rv_comb_age < 55.5 => -0.0027888473334715,
    rv_comb_age >= 55.5                       => 0.0132246262859742,
    rv_comb_age = NULL                        => 0.00437443232694303,
                                                 0.00437443232694303);

final_score_tree_26_c403 := map(
    NULL < rv_comb_age => final_score_tree_26_c404,
    rv_comb_age = NULL => 0.00389951988706755,
                          0.0024594176888995);

final_score_tree_26_c402 := map(
    NULL < rv_i60_inq_banking_count12 AND rv_i60_inq_banking_count12 < 0.5 => final_score_tree_26_c403,
    rv_i60_inq_banking_count12 >= 0.5                                      => 0.0525585535524577,
    rv_i60_inq_banking_count12 = NULL                                      => 0.0058737488754943,
                                                                              0.00340605804295271);

final_score_tree_26_c405 := map(
    NULL < rv_comb_age AND rv_comb_age < 56.5 => -0.0177767721701316,
    rv_comb_age >= 56.5                       => 0.00195948277403535,
    rv_comb_age = NULL                        => -0.00962946682339175,
                                                 -0.00789271384632435);

final_score_tree_26 := map(
    NULL < rv_l80_inp_avm_autoval AND rv_l80_inp_avm_autoval < 50926 => final_score_tree_26_c402,
    rv_l80_inp_avm_autoval >= 50926                                  => final_score_tree_26_c405,
    rv_l80_inp_avm_autoval = NULL                                    => -0.00102116579448501,
                                                                        -0.00102116579448501);

final_score_tree_27_c408 := map(
    NULL < rv_c13_curr_addr_lres AND rv_c13_curr_addr_lres < 141.5 => 0.00494162771071557,
    rv_c13_curr_addr_lres >= 141.5                                 => -0.00930015086606946,
    rv_c13_curr_addr_lres = NULL                                   => 0.000553008069757956,
                                                                      0.000553008069757956);

final_score_tree_27_c410 := map(
    (rv_e58_br_dead_bus_x_active_phn in ['0-1', '0-2', '1-2', '1-3', '2-0', '2-1', '3-0', '3-2']) => -0.062646165941294,
    (rv_e58_br_dead_bus_x_active_phn in ['0-0', '0-3', '1-0', '1-1', '2-2', '2-3', '3-1', '3-3']) => 0.0372786094116422,
    rv_e58_br_dead_bus_x_active_phn = ''                                                        => 0.0339820234688487,
                                                                                                     0.0339820234688487);

final_score_tree_27_c409 := map(
    NULL < rv_c20_m_bureau_adl_fs AND rv_c20_m_bureau_adl_fs < 319.5 => 0.00612010322909382,
    rv_c20_m_bureau_adl_fs >= 319.5                                  => final_score_tree_27_c410,
    rv_c20_m_bureau_adl_fs = NULL                                    => 0.0167471126539953,
                                                                        0.0167471126539953);

final_score_tree_27_c407 := map(
    NULL < rv_d30_derog_count AND rv_d30_derog_count < 0.5 => final_score_tree_27_c408,
    rv_d30_derog_count >= 0.5                              => final_score_tree_27_c409,
    rv_d30_derog_count = NULL                              => 0.00476594916889761,
                                                              0.00476594916889761);

final_score_tree_27 := map(
    NULL < rv_a46_curr_avm_autoval AND rv_a46_curr_avm_autoval < 48334.5 => final_score_tree_27_c407,
    rv_a46_curr_avm_autoval >= 48334.5                                   => -0.00791275499696782,
    rv_a46_curr_avm_autoval = NULL                                       => -0.00269821044592557,
                                                                            -0.000490213196482932);

final_score_tree_28_c414 := map(
    NULL < rv_c12_inp_addr_source_count AND rv_c12_inp_addr_source_count < 1.5 => 0.0306580579963591,
    rv_c12_inp_addr_source_count >= 1.5                                        => 9.02039169324667e-05,
    rv_c12_inp_addr_source_count = NULL                                        => 0.0227014446036945,
                                                                                  0.0227014446036945);

final_score_tree_28_c413 := map(
    NULL < rv_c13_curr_addr_lres AND rv_c13_curr_addr_lres < 27.5 => final_score_tree_28_c414,
    rv_c13_curr_addr_lres >= 27.5                                 => 0.00444648241293147,
    rv_c13_curr_addr_lres = NULL                                  => 0.010540437464205,
                                                                     0.010540437464205);

final_score_tree_28_c415 := map(
    NULL < rv_i62_inq_ssns_per_adl AND rv_i62_inq_ssns_per_adl < 2.5 => -0.00566299405736436,
    rv_i62_inq_ssns_per_adl >= 2.5                                   => 0.0199493926928767,
    rv_i62_inq_ssns_per_adl = NULL                                   => -0.00432095464649234,
                                                                        -0.00432095464649234);

final_score_tree_28_c412 := map(
    NULL < rv_ever_asset_owner AND rv_ever_asset_owner < 0.5 => final_score_tree_28_c413,
    rv_ever_asset_owner >= 0.5                               => final_score_tree_28_c415,
    rv_ever_asset_owner = NULL                               => 0.000680473104649594,
                                                                0.000680473104649594);

final_score_tree_28 := map(
    NULL < rv_c20_m_bureau_adl_fs AND rv_c20_m_bureau_adl_fs < 172.5 => -0.0202026016597325,
    rv_c20_m_bureau_adl_fs >= 172.5                                  => final_score_tree_28_c412,
    rv_c20_m_bureau_adl_fs = NULL                                    => -0.00204711537625006,
                                                                        -0.00199007287952843);

final_score_tree_29_c419 := map(
    NULL < iv_c13_avg_lres AND iv_c13_avg_lres < 116.5 => 0.0187698802421583,
    iv_c13_avg_lres >= 116.5                           => -0.0149066826261897,
    iv_c13_avg_lres = NULL                             => 0.0136924137081872,
                                                          0.0136924137081872);

final_score_tree_29_c420 := map(
    NULL < iv_full_name_ver_sources AND iv_full_name_ver_sources < 1.5 => -0.0639392780549341,
    iv_full_name_ver_sources >= 1.5                                    => -0.00105670065698835,
    iv_full_name_ver_sources = NULL                                    => -0.00184250444312949,
                                                                          -0.00184250444312949);

final_score_tree_29_c418 := map(
    NULL < rv_ever_asset_owner AND rv_ever_asset_owner < 0.5 => final_score_tree_29_c419,
    rv_ever_asset_owner >= 0.5                               => final_score_tree_29_c420,
    rv_ever_asset_owner = NULL                               => 0.00311305675258874,
                                                                0.00311305675258874);

final_score_tree_29_c417 := map(
    NULL < rv_c10_m_hdr_fs AND rv_c10_m_hdr_fs < 231.5 => -0.0113034102718617,
    rv_c10_m_hdr_fs >= 231.5                           => final_score_tree_29_c418,
    rv_c10_m_hdr_fs = NULL                             => -0.00608036622979053,
                                                          -0.000339818177052344);

final_score_tree_29 := map(
    NULL < rv_l80_inp_avm_autoval AND rv_l80_inp_avm_autoval < 312232 => final_score_tree_29_c417,
    rv_l80_inp_avm_autoval >= 312232                                  => -0.0154815385253505,
    rv_l80_inp_avm_autoval = NULL                                     => -0.00154160474242367,
                                                                         -0.00154160474242367);

final_score_tree_30_c424 := map(
    NULL < rv_d31_bk_disposed_recent_count AND rv_d31_bk_disposed_recent_count < 0.5 => -0.0074713463944781,
    rv_d31_bk_disposed_recent_count >= 0.5                                           => 0.167751782899974,
    rv_d31_bk_disposed_recent_count = NULL                                           => -0.00448152516735598,
                                                                                        -0.00448152516735598);

final_score_tree_30_c423 := map(
    NULL < rv_c13_attr_addrs_recency AND rv_c13_attr_addrs_recency < 18 => 0.0519957288112911,
    rv_c13_attr_addrs_recency >= 18                                     => final_score_tree_30_c424,
    rv_c13_attr_addrs_recency = NULL                                    => 0.00834977486108287,
                                                                           0.00834977486108287);

final_score_tree_30_c422 := map(
    NULL < rv_c12_inp_addr_source_count AND rv_c12_inp_addr_source_count < 0.5 => final_score_tree_30_c423,
    rv_c12_inp_addr_source_count >= 0.5                                        => -0.01491790560885,
    rv_c12_inp_addr_source_count = NULL                                        => -0.0110764962635998,
                                                                                  -0.0110764962635998);

final_score_tree_30_c425 := map(
    NULL < rv_i60_inq_hiriskcred_count12 AND rv_i60_inq_hiriskcred_count12 < 0.5 => 0.00322255743871866,
    rv_i60_inq_hiriskcred_count12 >= 0.5                                         => 0.0335386411379094,
    rv_i60_inq_hiriskcred_count12 = NULL                                         => 0.00422469536391946,
                                                                                    0.00422469536391946);

final_score_tree_30 := map(
    NULL < rv_comb_age AND rv_comb_age < 50.5 => final_score_tree_30_c422,
    rv_comb_age >= 50.5                       => final_score_tree_30_c425,
    rv_comb_age = NULL                        => -0.00261742081146239,
                                                 -0.00183593829206749);

final_score_tree_31_c428 := map(
    NULL < iv_c14_addrs_per_adl AND iv_c14_addrs_per_adl < 12.5 => 0.00362752794698158,
    iv_c14_addrs_per_adl >= 12.5                                => 0.0299273070135764,
    iv_c14_addrs_per_adl = NULL                                 => 0.00447332012634034,
                                                                   0.00447332012634034);

final_score_tree_31_c430 := map(
    NULL < rv_c22_inp_addr_occ_index AND rv_c22_inp_addr_occ_index < 2 => 0.00314071916115232,
    rv_c22_inp_addr_occ_index >= 2                                     => -0.0368473299195607,
    rv_c22_inp_addr_occ_index = NULL                                   => -0.0231959980700393,
                                                                          -0.0231959980700393);

final_score_tree_31_c429 := map(
    NULL < rv_c22_inp_addr_occ_index AND rv_c22_inp_addr_occ_index < 3.5 => final_score_tree_31_c430,
    rv_c22_inp_addr_occ_index >= 3.5                                     => 0.0160733102590326,
    rv_c22_inp_addr_occ_index = NULL                                     => -0.0131611584254915,
                                                                            -0.0131611584254915);

final_score_tree_31_c427 := map(
    NULL < rv_f03_input_add_not_most_rec AND rv_f03_input_add_not_most_rec < 0.5 => final_score_tree_31_c428,
    rv_f03_input_add_not_most_rec >= 0.5                                         => final_score_tree_31_c429,
    rv_f03_input_add_not_most_rec = NULL                                         => 0.00166380644807856,
                                                                                    0.00166380644807856);

final_score_tree_31 := map(
    NULL < iv_input_best_name_match AND iv_input_best_name_match < 2.5 => -0.0166791921137536,
    iv_input_best_name_match >= 2.5                                    => final_score_tree_31_c427,
    iv_input_best_name_match = NULL                                    => 0.00688310949781366,
                                                                          -0.000369810963719702);

final_score_tree_32_c434 := map(
    NULL < rv_f03_address_match AND rv_f03_address_match < 3 => -0.0432309244478671,
    rv_f03_address_match >= 3                                => -0.00498039173953851,
    rv_f03_address_match = NULL                              => -0.0248921075762286,
                                                                -0.0248921075762286);

final_score_tree_32_c433 := map(
    NULL < rv_c12_inp_addr_source_count AND rv_c12_inp_addr_source_count < 0.5 => 0.0146297776278517,
    rv_c12_inp_addr_source_count >= 0.5                                        => final_score_tree_32_c434,
    rv_c12_inp_addr_source_count = NULL                                        => -0.0195722706122524,
                                                                                  -0.0195722706122524);

final_score_tree_32_c435 := map(
    NULL < rv_c14_addrs_5yr AND rv_c14_addrs_5yr < 2.5 => 0.00401442530982577,
    rv_c14_addrs_5yr >= 2.5                            => 0.0417394566693913,
    rv_c14_addrs_5yr = NULL                            => 0.00829282246585114,
                                                          0.00829282246585114);

final_score_tree_32_c432 := map(
    NULL < rv_c22_inp_addr_occ_index AND rv_c22_inp_addr_occ_index < 3.5 => final_score_tree_32_c433,
    rv_c22_inp_addr_occ_index >= 3.5                                     => final_score_tree_32_c435,
    rv_c22_inp_addr_occ_index = NULL                                     => -0.00879972603174765,
                                                                            -0.00879972603174765);

final_score_tree_32 := map(
    NULL < rv_c22_inp_addr_occ_index AND rv_c22_inp_addr_occ_index < 2 => 0.00486789552435485,
    rv_c22_inp_addr_occ_index >= 2                                     => final_score_tree_32_c432,
    rv_c22_inp_addr_occ_index = NULL                                   => 0.00830970873506198,
                                                                          -0.000100969642329732);

final_score_tree_33_c438 := map(
    NULL < rv_c13_inp_addr_lres AND rv_c13_inp_addr_lres < 18.5 => 0.0202673860645722,
    rv_c13_inp_addr_lres >= 18.5                                => 0.00260601182764597,
    rv_c13_inp_addr_lres = NULL                                 => 0.0053263885683608,
                                                                   0.0053263885683608);

final_score_tree_33_c440 := map(
    NULL < iv_c14_addrs_per_adl AND iv_c14_addrs_per_adl < 4.5 => -0.007684347680107,
    iv_c14_addrs_per_adl >= 4.5                                => 0.0175342261144245,
    iv_c14_addrs_per_adl = NULL                                => 0.00539468661517326,
                                                                  0.00539468661517326);

final_score_tree_33_c439 := map(
    NULL < rv_c22_inp_addr_occ_index AND rv_c22_inp_addr_occ_index < 3.5 => -0.0149281309358183,
    rv_c22_inp_addr_occ_index >= 3.5                                     => final_score_tree_33_c440,
    rv_c22_inp_addr_occ_index = NULL                                     => -0.00689317667362238,
                                                                            -0.00689317667362238);

final_score_tree_33_c437 := map(
    NULL < rv_c22_inp_addr_occ_index AND rv_c22_inp_addr_occ_index < 2 => final_score_tree_33_c438,
    rv_c22_inp_addr_occ_index >= 2                                     => final_score_tree_33_c439,
    rv_c22_inp_addr_occ_index = NULL                                   => 0.000739971835974727,
                                                                          0.000739971835974727);

final_score_tree_33 := map(
    NULL < rv_e55_college_ind AND rv_e55_college_ind < 0.5 => final_score_tree_33_c437,
    rv_e55_college_ind >= 0.5                              => -0.0177538557789003,
    rv_e55_college_ind = NULL                              => -0.00187196923631889,
                                                              -0.00114746883866402);

final_score_tree_34_c445 := map(
    NULL < rv_l79_adls_per_sfd_addr AND rv_l79_adls_per_sfd_addr < 1.5 => 0.0142311102075235,
    rv_l79_adls_per_sfd_addr >= 1.5                                    => -0.017287437825553,
    rv_l79_adls_per_sfd_addr = NULL                                    => 0.00315902073454583,
                                                                          0.00315902073454583);

final_score_tree_34_c444 := map(
    NULL < rv_c22_inp_addr_occ_index AND rv_c22_inp_addr_occ_index < 3.5 => -0.0179731856826676,
    rv_c22_inp_addr_occ_index >= 3.5                                     => final_score_tree_34_c445,
    rv_c22_inp_addr_occ_index = NULL                                     => -0.00981221887655313,
                                                                            -0.00981221887655313);

final_score_tree_34_c443 := map(
    NULL < rv_c22_inp_addr_occ_index AND rv_c22_inp_addr_occ_index < 2 => 0.00137366466706793,
    rv_c22_inp_addr_occ_index >= 2                                     => final_score_tree_34_c444,
    rv_c22_inp_addr_occ_index = NULL                                   => -0.00269942857459309,
                                                                          -0.00269942857459309);

final_score_tree_34_c442 := map(
    NULL < iv_lname_non_phn_src_ct AND iv_lname_non_phn_src_ct < 6.5 => final_score_tree_34_c443,
    iv_lname_non_phn_src_ct >= 6.5                                   => -0.0545530564118361,
    iv_lname_non_phn_src_ct = NULL                                   => -0.00315197191814242,
                                                                        -0.00315197191814242);

final_score_tree_34 := map(
    NULL < rv_i62_inq_num_names_per_adl AND rv_i62_inq_num_names_per_adl < 0.5 => final_score_tree_34_c442,
    rv_i62_inq_num_names_per_adl >= 0.5                                        => 0.0114355836616336,
    rv_i62_inq_num_names_per_adl = NULL                                        => -0.00866734884770899,
                                                                                  -0.00054635722911357);

final_score_tree_35_c449 := map(
    NULL < rv_c13_attr_addrs_recency AND rv_c13_attr_addrs_recency < 18 => 0.0509701685619259,
    rv_c13_attr_addrs_recency >= 18                                     => 1.69596480406451e-05,
    rv_c13_attr_addrs_recency = NULL                                    => 0.0120054120683751,
                                                                           0.0120054120683751);

final_score_tree_35_c450 := map(
    NULL < rv_l79_adls_per_addr_curr AND rv_l79_adls_per_addr_curr < 0.5 => -0.019105455893213,
    rv_l79_adls_per_addr_curr >= 0.5                                     => 0.00472140844719693,
    rv_l79_adls_per_addr_curr = NULL                                     => 0.0013991118183924,
                                                                            0.0013991118183924);

final_score_tree_35_c448 := map(
    NULL < rv_c12_inp_addr_source_count AND rv_c12_inp_addr_source_count < 0.5 => final_score_tree_35_c449,
    rv_c12_inp_addr_source_count >= 0.5                                        => final_score_tree_35_c450,
    rv_c12_inp_addr_source_count = NULL                                        => 0.00290284721934666,
                                                                                  0.00290284721934666);

final_score_tree_35_c447 := map(
    NULL < rv_a49_curr_avm_chg_1yr AND rv_a49_curr_avm_chg_1yr < 52014.5 => -0.000965559893054197,
    rv_a49_curr_avm_chg_1yr >= 52014.5                                   => -0.0235507471104352,
    rv_a49_curr_avm_chg_1yr = NULL                                       => final_score_tree_35_c448,
                                                                            0.000619139798558875);

final_score_tree_35 := map(
    NULL < iv_input_best_name_match AND iv_input_best_name_match < 2.5 => -0.0148032286002582,
    iv_input_best_name_match >= 2.5                                    => final_score_tree_35_c447,
    iv_input_best_name_match = NULL                                    => -0.00593108324980143,
                                                                          -0.00126530593044303);

final_score_tree_36_c455 := map(
    NULL < iv_fname_non_phn_src_ct AND iv_fname_non_phn_src_ct < 1.5 => -0.030785044194783,
    iv_fname_non_phn_src_ct >= 1.5                                   => 0.00824754174035786,
    iv_fname_non_phn_src_ct = NULL                                   => 0.00679749850893979,
                                                                        0.00679749850893979);

final_score_tree_36_c454 := map(
    NULL < iv_header_emergence_age AND iv_header_emergence_age < 49.5 or rv_comb_age >= 62 => final_score_tree_36_c455,
    iv_header_emergence_age >= 49.5 and rv_comb_age < 62                                   => -0.0137733967806535,
    iv_header_emergence_age = NULL                                                         => 0.00348605556077824,
                                                                                              0.00348605556077824);

final_score_tree_36_c453 := map(
    NULL < iv_lname_non_phn_src_ct AND iv_lname_non_phn_src_ct < 6.5 => final_score_tree_36_c454,
    iv_lname_non_phn_src_ct >= 6.5                                   => -0.0565611371816159,
    iv_lname_non_phn_src_ct = NULL                                   => 0.00297711125495495,
                                                                        0.00297711125495495);

final_score_tree_36_c452 := map(
    NULL < iv_bureau_emergence_age AND iv_bureau_emergence_age < 25.5 => -0.00801058271888141,
    iv_bureau_emergence_age >= 25.5                                   => final_score_tree_36_c453,
    iv_bureau_emergence_age = NULL                                    => 0.00820793950830221,
                                                                         -0.0018643628305586);

final_score_tree_36 := map(
    NULL < rv_i60_inq_banking_count12 AND rv_i60_inq_banking_count12 < 0.5 => final_score_tree_36_c452,
    rv_i60_inq_banking_count12 >= 0.5                                      => 0.0345622032787332,
    rv_i60_inq_banking_count12 = NULL                                      => -0.00731779498635365,
                                                                              -0.00135566697553517);

final_score_tree_37_c459 := map(
    NULL < rv_c12_inp_addr_source_count AND rv_c12_inp_addr_source_count < 2.5 => 0.00226198926581496,
    rv_c12_inp_addr_source_count >= 2.5                                        => -0.0214184939004633,
    rv_c12_inp_addr_source_count = NULL                                        => -0.00363682761247028,
                                                                                  -0.00363682761247028);

final_score_tree_37_c458 := map(
    NULL < iv_estimated_income AND iv_estimated_income < 36500 => final_score_tree_37_c459,
    iv_estimated_income >= 36500                               => -0.0279329138815817,
    iv_estimated_income = NULL                                 => -0.00908925714422973,
                                                                  -0.00908925714422973);

final_score_tree_37_c460 := map(
    NULL < rv_c14_addrs_15yr AND rv_c14_addrs_15yr < 7.5 => 0.00209412357865104,
    rv_c14_addrs_15yr >= 7.5                             => 0.0367726590070807,
    rv_c14_addrs_15yr = NULL                             => 0.00293396997277452,
                                                            0.00293396997277452);

final_score_tree_37_c457 := map(
    NULL < iv_bureau_emergence_age AND iv_bureau_emergence_age < 25.5 => final_score_tree_37_c458,
    iv_bureau_emergence_age >= 25.5                                   => final_score_tree_37_c460,
    iv_bureau_emergence_age = NULL                                    => 0.00947656861414947,
                                                                         -0.00211640818332947);

final_score_tree_37 := map(
    NULL < rv_i60_inq_hiriskcred_count12 AND rv_i60_inq_hiriskcred_count12 < 0.5 => final_score_tree_37_c457,
    rv_i60_inq_hiriskcred_count12 >= 0.5                                         => 0.0176644670708497,
    rv_i60_inq_hiriskcred_count12 = NULL                                         => 7.59811458432527e-05,
                                                                                    -0.000688759196900806);

final_score_tree_38_c465 := map(
    NULL < iv_c14_addrs_per_adl AND iv_c14_addrs_per_adl < 2.5 => -0.0143367182025343,
    iv_c14_addrs_per_adl >= 2.5                                => 0.0362924869639127,
    iv_c14_addrs_per_adl = NULL                                => 0.0204950401149831,
                                                                  0.0204950401149831);

final_score_tree_38_c464 := map(
    NULL < iv_estimated_income AND iv_estimated_income < 27500 => final_score_tree_38_c465,
    iv_estimated_income >= 27500                               => -0.00489206329311205,
    iv_estimated_income = NULL                                 => 0.00482707546653511,
                                                                  0.00482707546653511);

final_score_tree_38_c463 := map(
    NULL < rv_c22_inp_addr_occ_index AND rv_c22_inp_addr_occ_index < 3.5 => -0.0160071020421477,
    rv_c22_inp_addr_occ_index >= 3.5                                     => final_score_tree_38_c464,
    rv_c22_inp_addr_occ_index = NULL                                     => -0.0078398814629603,
                                                                            -0.0078398814629603);

final_score_tree_38_c462 := map(
    NULL < rv_c22_inp_addr_occ_index AND rv_c22_inp_addr_occ_index < 2 => 0.00241253282759346,
    rv_c22_inp_addr_occ_index >= 2                                     => final_score_tree_38_c463,
    rv_c22_inp_addr_occ_index = NULL                                   => -0.00139160540540211,
                                                                          -0.00139160540540211);

final_score_tree_38 := map(
    NULL < rv_i60_inq_banking_count12 AND rv_i60_inq_banking_count12 < 0.5 => final_score_tree_38_c462,
    rv_i60_inq_banking_count12 >= 0.5                                      => 0.0367988563447095,
    rv_i60_inq_banking_count12 = NULL                                      => 0.000627955630006702,
                                                                              -0.000761102793253152);

final_score_tree_39_c469 := map(
    NULL < rv_c20_m_bureau_adl_fs AND rv_c20_m_bureau_adl_fs < 392.5 => -0.00229638490462997,
    rv_c20_m_bureau_adl_fs >= 392.5                                  => 0.0104766957016079,
    rv_c20_m_bureau_adl_fs = NULL                                    => -0.000805878004274073,
                                                                        -0.000805878004274073);

final_score_tree_39_c470 := map(
    NULL < rv_c13_curr_addr_lres AND rv_c13_curr_addr_lres < 118.5 => 0.0611922049009339,
    rv_c13_curr_addr_lres >= 118.5                                 => -0.0758849455521867,
    rv_c13_curr_addr_lres = NULL                                   => 0.0412600682279036,
                                                                      0.0412600682279036);

final_score_tree_39_c468 := map(
    NULL < iv_unverified_addr_count AND iv_unverified_addr_count < 14.5 => final_score_tree_39_c469,
    iv_unverified_addr_count >= 14.5                                    => final_score_tree_39_c470,
    iv_unverified_addr_count = NULL                                     => -0.000553909131298496,
                                                                           -0.000553909131298496);

final_score_tree_39_c467 := map(
    NULL < iv_input_best_name_match AND iv_input_best_name_match < 1.5 => -0.0187559059845273,
    iv_input_best_name_match >= 1.5                                    => final_score_tree_39_c468,
    iv_input_best_name_match = NULL                                    => -0.0176508180269417,
                                                                          -0.00191407683153589);

final_score_tree_39 := map(
    NULL < rv_d31_bk_dism_hist_count AND rv_d31_bk_dism_hist_count < 0.5 => final_score_tree_39_c467,
    rv_d31_bk_dism_hist_count >= 0.5                                     => 0.0421630766026335,
    rv_d31_bk_dism_hist_count = NULL                                     => -0.000724074044009466,
                                                                            -0.0013636392490284);

final_score_tree_40_c473 := map(
    NULL < rv_comb_age => 0.00167533712640169,
    rv_comb_age = NULL => -0.0111792336397998,
                          0.000411172871259727);

final_score_tree_40_c474 := map(
    NULL < rv_comb_age AND rv_comb_age < 53.5 => 0.00577782205570105,
    rv_comb_age >= 53.5                       => 0.0487525692939645,
    rv_comb_age = NULL                        => 0.0172111891882776,
                                                 0.0172111891882776);

final_score_tree_40_c472 := map(
    NULL < iv_c14_addrs_per_adl AND iv_c14_addrs_per_adl < 11.5 => final_score_tree_40_c473,
    iv_c14_addrs_per_adl >= 11.5                                => final_score_tree_40_c474,
    iv_c14_addrs_per_adl = NULL                                 => 0.00406453595612022,
                                                                   0.00149094684856991);

final_score_tree_40_c475 := map(
    NULL < rv_c20_m_bureau_adl_fs AND rv_c20_m_bureau_adl_fs < 392.5 => -0.00806551749664812,
    rv_c20_m_bureau_adl_fs >= 392.5                                  => 0.0122537563374752,
    rv_c20_m_bureau_adl_fs = NULL                                    => -0.0183884384806254,
                                                                        -0.00530473111344685);

final_score_tree_40 := map(
    NULL < rv_l80_inp_avm_autoval AND rv_l80_inp_avm_autoval < 64366.5 => final_score_tree_40_c472,
    rv_l80_inp_avm_autoval >= 64366.5                                  => final_score_tree_40_c475,
    rv_l80_inp_avm_autoval = NULL                                      => -0.00100873947221588,
                                                                          -0.00100873947221588);

final_score_tree_41_c478 := map(
    NULL < rv_c14_addrs_5yr AND rv_c14_addrs_5yr < 2.5 => 0.00571320915540463,
    rv_c14_addrs_5yr >= 2.5                            => 0.0401685806908213,
    rv_c14_addrs_5yr = NULL                            => 0.0106225422076759,
                                                          0.0106225422076759);

final_score_tree_41_c480 := map(
    NULL < rv_f01_inp_addr_address_score AND rv_f01_inp_addr_address_score < 95 => -0.0265592917104314,
    rv_f01_inp_addr_address_score >= 95                                         => 0.00114519228125668,
    rv_f01_inp_addr_address_score = NULL                                        => -0.000936214485295393,
                                                                                   -0.000936214485295393);

final_score_tree_41_c479 := map(
    NULL < rv_l79_adls_per_addr_curr AND rv_l79_adls_per_addr_curr < 0.5 => -0.0264880562542087,
    rv_l79_adls_per_addr_curr >= 0.5                                     => final_score_tree_41_c480,
    rv_l79_adls_per_addr_curr = NULL                                     => -0.00380533950021472,
                                                                            -0.00380533950021472);

final_score_tree_41_c477 := map(
    NULL < rv_c12_inp_addr_source_count AND rv_c12_inp_addr_source_count < 0.5 => final_score_tree_41_c478,
    rv_c12_inp_addr_source_count >= 0.5                                        => final_score_tree_41_c479,
    rv_c12_inp_addr_source_count = NULL                                        => -0.00191564090344821,
                                                                                  -0.00191564090344821);

final_score_tree_41 := map(
    NULL < rv_c18_invalid_addrs_per_adl AND rv_c18_invalid_addrs_per_adl < 2.5 => final_score_tree_41_c477,
    rv_c18_invalid_addrs_per_adl >= 2.5                                        => 0.0121595795961771,
    rv_c18_invalid_addrs_per_adl = NULL                                        => -0.000711034481191915,
                                                                                  9.4258418716054e-05);

final_score_tree_42_c483 := map(
    NULL < iv_estimated_income AND iv_estimated_income < 58500 => 0.00505863064582472,
    iv_estimated_income >= 58500                               => -0.0127224094588596,
    iv_estimated_income = NULL                                 => 0.00301501973010297,
                                                                  0.00301501973010297);

final_score_tree_42_c484 := map(
    NULL < rv_f04_curr_add_occ_index AND rv_f04_curr_add_occ_index < 2 => -0.0226612425303123,
    rv_f04_curr_add_occ_index >= 2                                     => 0.00403977841755136,
    rv_f04_curr_add_occ_index = NULL                                   => -0.0113617811734321,
                                                                          -0.0113617811734321);

final_score_tree_42_c482 := map(
    NULL < rv_f03_input_add_not_most_rec AND rv_f03_input_add_not_most_rec < 0.5 => final_score_tree_42_c483,
    rv_f03_input_add_not_most_rec >= 0.5                                         => final_score_tree_42_c484,
    rv_f03_input_add_not_most_rec = NULL                                         => 0.000578643753851556,
                                                                                    0.000578643753851556);

final_score_tree_42_c485 := map(
    NULL < rv_a46_curr_avm_autoval AND rv_a46_curr_avm_autoval < 163783 => -0.0229243288566711,
    rv_a46_curr_avm_autoval >= 163783                                   => 0.00595443846001705,
    rv_a46_curr_avm_autoval = NULL                                      => -0.0141314213754768,
                                                                           -0.0141314213754768);

final_score_tree_42 := map(
    NULL < iv_c13_avg_lres AND iv_c13_avg_lres < 185.5 => final_score_tree_42_c482,
    iv_c13_avg_lres >= 185.5                           => final_score_tree_42_c485,
    iv_c13_avg_lres = NULL                             => 0.0167573983474761,
                                                          -0.000878173741519472);

final_score_tree_43_c487 := map(
    NULL < rv_i60_inq_count12 AND rv_i60_inq_count12 < 14.5 => -0.00546249490659222,
    rv_i60_inq_count12 >= 14.5                              => 0.0875997213482899,
    rv_i60_inq_count12 = NULL                               => -0.00490576648848007,
                                                               -0.00490576648848007);

final_score_tree_43_c490 := map(
    NULL < rv_i60_inq_other_count12 AND rv_i60_inq_other_count12 < 0.5 => 0.00651816264502454,
    rv_i60_inq_other_count12 >= 0.5                                    => 0.0430450135272312,
    rv_i60_inq_other_count12 = NULL                                    => 0.00722242305574758,
                                                                          0.00722242305574758);

final_score_tree_43_c489 := map(
    NULL < iv_fname_non_phn_src_ct AND iv_fname_non_phn_src_ct < 1.5 => -0.0242973466759408,
    iv_fname_non_phn_src_ct >= 1.5                                   => final_score_tree_43_c490,
    iv_fname_non_phn_src_ct = NULL                                   => 0.0308545172562127,
                                                                        0.0060562929570723);

final_score_tree_43_c488 := map(
    NULL < iv_bureau_emergence_age AND iv_bureau_emergence_age < 60.5 or rv_comb_age >= 62 => final_score_tree_43_c489,
    iv_bureau_emergence_age >= 60.5 and rv_comb_age < 62                                   => -0.0295923033596857,
    iv_bureau_emergence_age = NULL                                                         => 0.00461185892925474,
                                                                                              0.00461185892925474);

final_score_tree_43 := map(
    NULL < iv_bureau_emergence_age AND iv_bureau_emergence_age < 23.5 => final_score_tree_43_c487,
    iv_bureau_emergence_age >= 23.5                                   => final_score_tree_43_c488,
    iv_bureau_emergence_age = NULL                                    => 0.00495469985043996,
                                                                         0.000780777086459184);

final_score_tree_44_c493 := map(
    NULL < rv_i60_inq_count12 AND rv_i60_inq_count12 < 12.5 => -0.0112012531620851,
    rv_i60_inq_count12 >= 12.5                              => 0.0811706975956658,
    rv_i60_inq_count12 = NULL                               => -0.0104506947448356,
                                                               -0.0104506947448356);

final_score_tree_44_c494 := map(
    NULL < rv_d31_bk_disposed_recent_count AND rv_d31_bk_disposed_recent_count < 0.5 => 0.000405945354909195,
    rv_d31_bk_disposed_recent_count >= 0.5                                           => 0.0515437512400447,
    rv_d31_bk_disposed_recent_count = NULL                                           => 0.000842891153462919,
                                                                                        0.000842891153462919);

final_score_tree_44_c492 := map(
    NULL < iv_bureau_emergence_age AND iv_bureau_emergence_age < 20.5 => final_score_tree_44_c493,
    iv_bureau_emergence_age >= 20.5                                   => final_score_tree_44_c494,
    iv_bureau_emergence_age = NULL                                    => -0.000344165638875132,
                                                                         -0.00247090739268316);

final_score_tree_44_c495 := map(
    NULL < rv_d32_mos_since_fel_ls AND rv_d32_mos_since_fel_ls < 53.5 => 0.0112613107632339,
    rv_d32_mos_since_fel_ls >= 53.5                                   => 0.145476143736195,
    rv_d32_mos_since_fel_ls = NULL                                    => 0.0131391473009931,
                                                                         0.0131391473009931);

final_score_tree_44 := map(
    (rv_6seg_riskview_5_0 in ['0 TRUEDID = 0', '1 VER/VAL PROBLEMS', '2 ADDR NOT CURRENT - DEROG', '3 ADDR NOT CURRENT - OTHER', '5 SUFFICIENTLY VERD - OWNER', '6 SUFFICIENTLY VERD - OTHER']) => final_score_tree_44_c492,
    (rv_6seg_riskview_5_0 in ['4 SUFFICIENTLY VERD - DEROG'])                                                                                                                                   => final_score_tree_44_c495,
    rv_6seg_riskview_5_0 = ''                                                                                                                                                                 => -0.00104567136140839,
                                                                                                                                                                                                   -0.00104567136140839);

final_score_tree_45_c498 := map(
    NULL < iv_c13_avg_lres AND iv_c13_avg_lres < 56.5 => 0.00275390442789537,
    iv_c13_avg_lres >= 56.5                           => 0.143247995519609,
    iv_c13_avg_lres = NULL                            => 0.0594705163989567,
                                                         0.0594705163989567);

final_score_tree_45_c497 := map(
    NULL < rv_d32_mos_since_crim_ls AND rv_d32_mos_since_crim_ls < 66.5 => 2.92316255105414e-05,
    rv_d32_mos_since_crim_ls >= 66.5                                    => final_score_tree_45_c498,
    rv_d32_mos_since_crim_ls = NULL                                     => 0.00830314479691969,
                                                                           0.000478749464974063);

final_score_tree_45_c500 := map(
    NULL < rv_a49_curr_avm_chg_1yr_pct AND rv_a49_curr_avm_chg_1yr_pct < 101.7 => 0.117819462709148,
    rv_a49_curr_avm_chg_1yr_pct >= 101.7                                       => -0.0098613433584987,
    rv_a49_curr_avm_chg_1yr_pct = NULL                                         => 0.055596966276226,
                                                                                  0.0238967082877459);

final_score_tree_45_c499 := map(
    NULL < rv_c10_m_hdr_fs AND rv_c10_m_hdr_fs < 390.5 => -0.0450799982651873,
    rv_c10_m_hdr_fs >= 390.5                           => final_score_tree_45_c500,
    rv_c10_m_hdr_fs = NULL                             => -0.0204015604169137,
                                                          -0.0204015604169137);

final_score_tree_45 := map(
    NULL < rv_l80_inp_avm_autoval AND rv_l80_inp_avm_autoval < 566570 => final_score_tree_45_c497,
    rv_l80_inp_avm_autoval >= 566570                                  => final_score_tree_45_c499,
    rv_l80_inp_avm_autoval = NULL                                     => 4.96587813934128e-05,
                                                                         4.96587813934128e-05);

final_score_tree_46_c504 := map(
    NULL < iv_c14_addrs_per_adl AND iv_c14_addrs_per_adl < 1.5 => 0.0610474868937551,
    iv_c14_addrs_per_adl >= 1.5                                => -0.0280632038228581,
    iv_c14_addrs_per_adl = NULL                                => -0.0249100563051933,
                                                                  -0.0249100563051933);

final_score_tree_46_c505 := map(
    NULL < iv_prv_addr_lres AND iv_prv_addr_lres < 397.5 => 0.00864980324732816,
    iv_prv_addr_lres >= 397.5                            => 0.149919946156637,
    iv_prv_addr_lres = NULL                              => 0.0115160131619256,
                                                            0.0115160131619256);

final_score_tree_46_c503 := map(
    NULL < rv_c22_inp_addr_occ_index AND rv_c22_inp_addr_occ_index < 3.5 => final_score_tree_46_c504,
    rv_c22_inp_addr_occ_index >= 3.5                                     => final_score_tree_46_c505,
    rv_c22_inp_addr_occ_index = NULL                                     => -0.0155814678660834,
                                                                            -0.0155814678660834);

final_score_tree_46_c502 := map(
    NULL < rv_f03_input_add_not_most_rec AND rv_f03_input_add_not_most_rec < 0.5 => 0.00136130032267757,
    rv_f03_input_add_not_most_rec >= 0.5                                         => final_score_tree_46_c503,
    rv_f03_input_add_not_most_rec = NULL                                         => -0.00136176870959885,
                                                                                    -0.00136176870959885);

final_score_tree_46 := map(
    NULL < rv_d31_bk_disposed_recent_count AND rv_d31_bk_disposed_recent_count < 0.5 => final_score_tree_46_c502,
    rv_d31_bk_disposed_recent_count >= 0.5                                           => 0.0346680600052645,
    rv_d31_bk_disposed_recent_count = NULL                                           => -0.000478295426736683,
                                                                                        -0.000868204903753882);

final_score_tree_47_c510 := map(
    NULL < iv_full_name_ver_sources AND iv_full_name_ver_sources < 0.5 => -0.0565046266981958,
    iv_full_name_ver_sources >= 0.5                                    => 0.000785469617451934,
    iv_full_name_ver_sources = NULL                                    => -0.0201337515573709,
                                                                          9.09675284236069e-05);

final_score_tree_47_c509 := map(
    '' < iv_prof_license_category_pl AND iv_prof_license_category_pl < '1.5' => 0.000375765123628907,
    iv_prof_license_category_pl >= '1.5'                                       => -0.0215254301032241,
    iv_prof_license_category_pl = ''                                       => final_score_tree_47_c510,
                                                                                -0.00132651525018667);

final_score_tree_47_c508 := map(
    NULL < rv_i60_credit_seeking AND rv_i60_credit_seeking < 0.5 => final_score_tree_47_c509,
    rv_i60_credit_seeking >= 0.5                                 => 0.0218829274378175,
    rv_i60_credit_seeking = NULL                                 => -0.000287535984828902,
                                                                    -0.000287535984828902);

final_score_tree_47_c507 := map(
    NULL < rv_c20_m_bureau_adl_fs AND rv_c20_m_bureau_adl_fs < 144.5 => -0.0279982212450002,
    rv_c20_m_bureau_adl_fs >= 144.5                                  => final_score_tree_47_c508,
    rv_c20_m_bureau_adl_fs = NULL                                    => -0.00212634291009741,
                                                                        -0.00212634291009741);

final_score_tree_47 := map(
    NULL < rv_c12_num_nonderogs AND rv_c12_num_nonderogs < 1.5 => 0.0130080403565225,
    rv_c12_num_nonderogs >= 1.5                                => final_score_tree_47_c507,
    rv_c12_num_nonderogs = NULL                                => 0.00510148872905304,
                                                                  0.00051853110272079);

final_score_tree_48_c512 := map(
    NULL < iv_prv_addr_avm_auto_val AND iv_prv_addr_avm_auto_val < 61907 => 0.000830995454912328,
    iv_prv_addr_avm_auto_val >= 61907                                    => -0.0189244361863271,
    iv_prv_addr_avm_auto_val = NULL                                      => -0.00516930788577099,
                                                                            -0.00516930788577099);

final_score_tree_48_c515 := map(
    NULL < rv_c13_max_lres AND rv_c13_max_lres < 250.5 => 0.00813329580988765,
    rv_c13_max_lres >= 250.5                           => -0.00362211093974936,
    rv_c13_max_lres = NULL                             => 0.00363909671002895,
                                                          0.00363909671002895);

final_score_tree_48_c514 := map(
    NULL < rv_i60_inq_other_count12 AND rv_i60_inq_other_count12 < 1.5 => final_score_tree_48_c515,
    rv_i60_inq_other_count12 >= 1.5                                    => 0.0942061022849723,
    rv_i60_inq_other_count12 = NULL                                    => 0.00391277505278016,
                                                                          0.00391277505278016);

final_score_tree_48_c513 := map(
    NULL < iv_lname_non_phn_src_ct AND iv_lname_non_phn_src_ct < 6.5 => final_score_tree_48_c514,
    iv_lname_non_phn_src_ct >= 6.5                                   => -0.0417587448185991,
    iv_lname_non_phn_src_ct = NULL                                   => 0.00351827856339011,
                                                                        0.00351827856339011);

final_score_tree_48 := map(
    NULL < iv_bureau_emergence_age AND iv_bureau_emergence_age < 23.5 => final_score_tree_48_c512,
    iv_bureau_emergence_age >= 23.5                                   => final_score_tree_48_c513,
    iv_bureau_emergence_age = NULL                                    => -0.000354564863334778,
                                                                         -0.000175885773336316);

final_score_tree_49_c517 := map(
    NULL < in_addrpop_found AND in_addrpop_found < 0.5 => 0.0133399829860003,
    in_addrpop_found >= 0.5                            => -0.0244811423117482,
    in_addrpop_found = NULL                            => -0.013497403088029,
                                                          -0.013497403088029);

final_score_tree_49_c520 := map(
    NULL < iv_bureau_emergence_age AND iv_bureau_emergence_age < 19.5 => -0.0102341925396358,
    iv_bureau_emergence_age >= 19.5                                   => 0.00695332917913361,
    iv_bureau_emergence_age = NULL                                    => -0.0192062077893325,
                                                                         0.00275970174706515);

final_score_tree_49_c519 := map(
    NULL < rv_i60_inq_hiriskcred_count12 AND rv_i60_inq_hiriskcred_count12 < 0.5 => final_score_tree_49_c520,
    rv_i60_inq_hiriskcred_count12 >= 0.5                                         => 0.0253632263896562,
    rv_i60_inq_hiriskcred_count12 = NULL                                         => 0.00435171048968612,
                                                                                    0.00435171048968612);

final_score_tree_49_c518 := map(
    NULL < iv_f00_nas_summary AND iv_f00_nas_summary < 11.5 => -0.0116871620247545,
    iv_f00_nas_summary >= 11.5                              => final_score_tree_49_c519,
    iv_f00_nas_summary = NULL                               => 0.000480471424492412,
                                                               0.00164900851337469);

final_score_tree_49 := map(
    NULL < rv_l79_adls_per_addr_curr AND rv_l79_adls_per_addr_curr < 0.5 => final_score_tree_49_c517,
    rv_l79_adls_per_addr_curr >= 0.5                                     => final_score_tree_49_c518,
    rv_l79_adls_per_addr_curr = NULL                                     => -0.0005080475494169,
                                                                            -0.0005080475494169);

final_score_tree_50_c524 := map(
    NULL < rv_c13_curr_addr_lres AND rv_c13_curr_addr_lres < 27.5 => 0.0191787217534411,
    rv_c13_curr_addr_lres >= 27.5                                 => 0.00551159909929077,
    rv_c13_curr_addr_lres = NULL                                  => 0.0101526493226957,
                                                                     0.0101526493226957);

final_score_tree_50_c523 := map(
    NULL < rv_a41_prop_owner AND rv_a41_prop_owner < 0.5 => final_score_tree_50_c524,
    rv_a41_prop_owner >= 0.5                             => -0.00222508056672519,
    rv_a41_prop_owner = NULL                             => 0.00432551068206037,
                                                            0.00432551068206037);

final_score_tree_50_c522 := map(
    NULL < rv_c20_m_bureau_adl_fs AND rv_c20_m_bureau_adl_fs < 160.5 => -0.0169192733304465,
    rv_c20_m_bureau_adl_fs >= 160.5                                  => final_score_tree_50_c523,
    rv_c20_m_bureau_adl_fs = NULL                                    => 0.0175931030783061,
                                                                        0.00199435079657315);

final_score_tree_50_c525 := map(
    NULL < rv_d31_attr_bankruptcy_recency AND rv_d31_attr_bankruptcy_recency < 18 => -0.00523348960529858,
    rv_d31_attr_bankruptcy_recency >= 18                                          => 0.0204133906077783,
    rv_d31_attr_bankruptcy_recency = NULL                                         => 0.00459235476717193,
                                                                                     -0.00330304232751);

final_score_tree_50 := map(
    NULL < rv_l80_inp_avm_autoval AND rv_l80_inp_avm_autoval < 26041.5 => final_score_tree_50_c522,
    rv_l80_inp_avm_autoval >= 26041.5                                  => final_score_tree_50_c525,
    rv_l80_inp_avm_autoval = NULL                                      => -0.000312438796863885,
                                                                          -0.000312438796863885);

final_score_tree_51_c530 := map(
    NULL < rv_c13_curr_addr_lres AND rv_c13_curr_addr_lres < 226.5 => 0.00345662700764127,
    rv_c13_curr_addr_lres >= 226.5                                 => -0.00847160607887029,
    rv_c13_curr_addr_lres = NULL                                   => 0.0014928635383427,
                                                                      0.0014928635383427);

final_score_tree_51_c529 := map(
    NULL < rv_d31_bk_disposed_recent_count AND rv_d31_bk_disposed_recent_count < 0.5 => final_score_tree_51_c530,
    rv_d31_bk_disposed_recent_count >= 0.5                                           => 0.0458501838653664,
    rv_d31_bk_disposed_recent_count = NULL                                           => 0.00220736883382474,
                                                                                        0.00220736883382474);

final_score_tree_51_c528 := map(
    NULL < rv_l80_inp_avm_autoval AND rv_l80_inp_avm_autoval < 77643 => final_score_tree_51_c529,
    rv_l80_inp_avm_autoval >= 77643                                  => -0.00519083289343072,
    rv_l80_inp_avm_autoval = NULL                                    => -0.000352078096534702,
                                                                        -0.000352078096534702);

final_score_tree_51_c527 := map(
    NULL < rv_c20_m_bureau_adl_fs AND rv_c20_m_bureau_adl_fs < 142.5 => -0.0252686148008023,
    rv_c20_m_bureau_adl_fs >= 142.5                                  => final_score_tree_51_c528,
    rv_c20_m_bureau_adl_fs = NULL                                    => 0.00125388704067932,
                                                                        -0.00206735762376226);

final_score_tree_51 := map(
    NULL < rv_s66_adlperssn_count AND rv_s66_adlperssn_count < 3.5 => final_score_tree_51_c527,
    rv_s66_adlperssn_count >= 3.5                                  => 0.0179063759124481,
    rv_s66_adlperssn_count = NULL                                  => 7.18397859792269e-05,
                                                                      -0.00121892297867381);

final_score_tree_52_c534 := map(
    NULL < rv_a46_curr_avm_autoval AND rv_a46_curr_avm_autoval < 88961 => 0.0544229878961135,
    rv_a46_curr_avm_autoval >= 88961                                   => -0.0217592780193333,
    rv_a46_curr_avm_autoval = NULL                                     => 0.0301644072861812,
                                                                          0.0301644072861812);

final_score_tree_52_c533 := map(
    NULL < rv_d31_bk_disposed_recent_count AND rv_d31_bk_disposed_recent_count < 0.5 => -0.0012932092539629,
    rv_d31_bk_disposed_recent_count >= 0.5                                           => final_score_tree_52_c534,
    rv_d31_bk_disposed_recent_count = NULL                                           => -0.000949898235424437,
                                                                                        -0.000949898235424437);

final_score_tree_52_c532 := map(
    NULL < rv_d31_bk_chapter AND rv_d31_bk_chapter < 12 => final_score_tree_52_c533,
    rv_d31_bk_chapter >= 12                             => 0.0247628186898,
    rv_d31_bk_chapter = NULL                            => -0.000390101351781589,
                                                           -0.000390101351781589);

final_score_tree_52_c535 := map(
    NULL < rv_c20_m_bureau_adl_fs AND rv_c20_m_bureau_adl_fs < 254.5 => 0.000924029034679727,
    rv_c20_m_bureau_adl_fs >= 254.5                                  => 0.0355216519242974,
    rv_c20_m_bureau_adl_fs = NULL                                    => 0.0203219159220697,
                                                                        0.0203219159220697);

final_score_tree_52 := map(
    NULL < rv_i60_inq_other_count12 AND rv_i60_inq_other_count12 < 0.5 => final_score_tree_52_c532,
    rv_i60_inq_other_count12 >= 0.5                                    => final_score_tree_52_c535,
    rv_i60_inq_other_count12 = NULL                                    => -0.00843495004402361,
                                                                          0.000216297831974353);

final_score_tree_53_c539 := map(
    NULL < rv_f03_address_match AND rv_f03_address_match < 3 => -0.0369557486750147,
    rv_f03_address_match >= 3                                => -0.00204620017849985,
    rv_f03_address_match = NULL                              => -0.0202345143244121,
                                                                -0.0202345143244121);

final_score_tree_53_c538 := map(
    NULL < rv_c12_inp_addr_source_count AND rv_c12_inp_addr_source_count < 0.5 => 0.0137150289212922,
    rv_c12_inp_addr_source_count >= 0.5                                        => final_score_tree_53_c539,
    rv_c12_inp_addr_source_count = NULL                                        => -0.0156058840962316,
                                                                                  -0.0156058840962316);

final_score_tree_53_c537 := map(
    NULL < rv_c22_inp_addr_occ_index AND rv_c22_inp_addr_occ_index < 2 => 0.00212000328542324,
    rv_c22_inp_addr_occ_index >= 2                                     => final_score_tree_53_c538,
    rv_c22_inp_addr_occ_index = NULL                                   => -0.00259849637512091,
                                                                          -0.00259849637512091);

final_score_tree_53_c540 := map(
    NULL < iv_bureau_emergence_age AND iv_bureau_emergence_age < 50.5 or rv_comb_age >= 62 => 0.0141876111230518,
    iv_bureau_emergence_age >= 50.5 and rv_comb_age < 62                                   => -0.03637533675398,
    iv_bureau_emergence_age = NULL                                                         => 0.00634216080033693,
                                                                                              0.0100729259016186);

final_score_tree_53 := map(
    NULL < rv_c22_inp_addr_occ_index AND rv_c22_inp_addr_occ_index < 3.5 => final_score_tree_53_c537,
    rv_c22_inp_addr_occ_index >= 3.5                                     => final_score_tree_53_c540,
    rv_c22_inp_addr_occ_index = NULL                                     => 0.00260279245075147,
                                                                            -0.000695193084220813);

final_score_tree_54_c544 := map(
    NULL < rv_f01_inp_addr_address_score AND rv_f01_inp_addr_address_score < 95 => -0.0257131913683215,
    rv_f01_inp_addr_address_score >= 95                                         => 0.00200388231738836,
    rv_f01_inp_addr_address_score = NULL                                        => -0.000558233752241776,
                                                                                   -0.000558233752241776);

final_score_tree_54_c543 := map(
    NULL < rv_c12_inp_addr_source_count AND rv_c12_inp_addr_source_count < 0.5 => 0.00624432950913381,
    rv_c12_inp_addr_source_count >= 0.5                                        => final_score_tree_54_c544,
    rv_c12_inp_addr_source_count = NULL                                        => 0.00034705761613642,
                                                                                  0.00034705761613642);

final_score_tree_54_c545 := map(
    (iv_d34_liens_unrel_x_rel in ['0-1', '1-0', '2-1', '3-0', '3-1', '3-2']) => -0.0451251957254865,
    (iv_d34_liens_unrel_x_rel in ['0-0', '0-2', '1-1', '1-2', '2-0', '2-2']) => 0.0607848329994334,
    iv_d34_liens_unrel_x_rel = ''                                          => 0.0381632734659554,
                                                                                0.0381632734659554);

final_score_tree_54_c542 := map(
    NULL < iv_unverified_addr_count AND iv_unverified_addr_count < 14.5 => final_score_tree_54_c543,
    iv_unverified_addr_count >= 14.5                                    => final_score_tree_54_c545,
    iv_unverified_addr_count = NULL                                     => 0.000589243168118722,
                                                                           0.000589243168118722);

final_score_tree_54 := map(
    NULL < rv_e55_college_ind AND rv_e55_college_ind < 0.5 => final_score_tree_54_c542,
    rv_e55_college_ind >= 0.5                              => -0.0142945257221976,
    rv_e55_college_ind = NULL                              => -0.00122935572815065,
                                                              -0.000940663584823097);

final_score_tree_55_c549 := map(
    NULL < rv_comb_age AND rv_comb_age < 48.5 => 0.0161441405874269,
    rv_comb_age >= 48.5                       => 0.0861121874787489,
    rv_comb_age = NULL                        => 0.0434754089043496,
                                                 0.0434754089043496);

final_score_tree_55_c548 := map(
    NULL < rv_i60_inq_hiriskcred_count12 AND rv_i60_inq_hiriskcred_count12 < 0.5 => 0.00569991411416283,
    rv_i60_inq_hiriskcred_count12 >= 0.5                                         => final_score_tree_55_c549,
    rv_i60_inq_hiriskcred_count12 = NULL                                         => 0.00684442365275145,
                                                                                    0.00684442365275145);

final_score_tree_55_c547 := map(
    NULL < iv_full_name_ver_sources AND iv_full_name_ver_sources < 2.5 => -0.00439315040977011,
    iv_full_name_ver_sources >= 2.5                                    => final_score_tree_55_c548,
    iv_full_name_ver_sources = NULL                                    => -0.00908289429417603,
                                                                          -0.000980644305166287);

final_score_tree_55_c550 := map(
    NULL < rv_a41_a42_prop_owner_history AND rv_a41_a42_prop_owner_history < 0.5 => 0.0107027450725781,
    rv_a41_a42_prop_owner_history >= 0.5                                         => -0.00575788513349065,
    rv_a41_a42_prop_owner_history = NULL                                         => -0.00882242270103798,
                                                                                    0.00306169704973164);

final_score_tree_55 := map(
    (iv_l77_dwelltype in ['RR', 'SFD'])  => final_score_tree_55_c547,
    (iv_l77_dwelltype in ['MFD', 'POB']) => final_score_tree_55_c550,
    iv_l77_dwelltype = ''              => -3.49176771198755e-05,
                                            -3.49176771198755e-05);

final_score_tree_56_c554 := map(
    NULL < rv_f04_curr_add_occ_index AND rv_f04_curr_add_occ_index < 2 => 0.0391749726712821,
    rv_f04_curr_add_occ_index >= 2                                     => -0.00808116219412048,
    rv_f04_curr_add_occ_index = NULL                                   => 0.0183860747289858,
                                                                          0.0183860747289858);

final_score_tree_56_c553 := map(
    NULL < rv_c12_inp_addr_source_count AND rv_c12_inp_addr_source_count < 0.5 => final_score_tree_56_c554,
    rv_c12_inp_addr_source_count >= 0.5                                        => -0.0132042704031827,
    rv_c12_inp_addr_source_count = NULL                                        => -0.00617122848826407,
                                                                                  -0.00617122848826407);

final_score_tree_56_c555 := map(
    NULL < rv_a49_curr_avm_chg_1yr_pct AND rv_a49_curr_avm_chg_1yr_pct < 110.75 => 0.0436543519692194,
    rv_a49_curr_avm_chg_1yr_pct >= 110.75                                       => -0.0154909270406308,
    rv_a49_curr_avm_chg_1yr_pct = NULL                                          => 0.013735957787137,
                                                                                   0.0150777240651312);

final_score_tree_56_c552 := map(
    NULL < rv_l79_adls_per_addr_curr AND rv_l79_adls_per_addr_curr < 1.5 => final_score_tree_56_c553,
    rv_l79_adls_per_addr_curr >= 1.5                                     => final_score_tree_56_c555,
    rv_l79_adls_per_addr_curr = NULL                                     => 0.00570158179013877,
                                                                            0.00570158179013877);

final_score_tree_56 := map(
    NULL < rv_c13_curr_addr_lres AND rv_c13_curr_addr_lres < 27.5 => final_score_tree_56_c552,
    rv_c13_curr_addr_lres >= 27.5                                 => -0.00258875251407774,
    rv_c13_curr_addr_lres = NULL                                  => 0.00375040513142562,
                                                                     -0.000181354131312744);

final_score_tree_57_c560 := map(
    NULL < rv_c12_source_profile AND rv_c12_source_profile < 57.15 => -0.00589064590099378,
    rv_c12_source_profile >= 57.15                                 => 0.0195250525094868,
    rv_c12_source_profile = NULL                                   => 0.0132502630859801,
                                                                      0.0132502630859801);

final_score_tree_57_c559 := map(
    NULL < rv_a44_curr_add_naprop AND rv_a44_curr_add_naprop < 0.5 => final_score_tree_57_c560,
    rv_a44_curr_add_naprop >= 0.5                                  => 0.0020327216329028,
    rv_a44_curr_add_naprop = NULL                                  => 0.00623004733414704,
                                                                      0.00623004733414704);

final_score_tree_57_c558 := map(
    NULL < rv_d31_bk_index_lvl AND rv_d31_bk_index_lvl < 5.5 => final_score_tree_57_c559,
    rv_d31_bk_index_lvl >= 5.5                               => 0.0837238384098519,
    rv_d31_bk_index_lvl = NULL                               => 0.00659261370460712,
                                                                0.00659261370460712);

final_score_tree_57_c557 := map(
    NULL < rv_comb_age => final_score_tree_57_c558,
    rv_comb_age = NULL => 0.00930859389482108,
                          0.00445766732766894);

final_score_tree_57 := map(
    NULL < rv_c12_inp_addr_source_count AND rv_c12_inp_addr_source_count < 1.5 => final_score_tree_57_c557,
    rv_c12_inp_addr_source_count >= 1.5                                        => -0.00351879141895254,
    rv_c12_inp_addr_source_count = NULL                                        => 0.00780428878398511,
                                                                                  -0.000406589940052417);

final_score_tree_58_c563 := map(
    NULL < iv_unverified_addr_count AND iv_unverified_addr_count < 2.5 => -1.96706244448057e-05,
    iv_unverified_addr_count >= 2.5                                    => 0.0103742652286125,
    iv_unverified_addr_count = NULL                                    => 0.00397350055481382,
                                                                          0.00397832360300823);

final_score_tree_58_c562 := map(
    NULL < rv_l79_adls_per_addr_curr AND rv_l79_adls_per_addr_curr < 0.5 => -0.00842068283545746,
    rv_l79_adls_per_addr_curr >= 0.5                                     => final_score_tree_58_c563,
    rv_l79_adls_per_addr_curr = NULL                                     => 0.00177033855731846,
                                                                            0.00177033855731846);

final_score_tree_58_c565 := map(
    (iv_inp_addr_mortgage_type in ['NO MORTGAGE'])                                          => -0.00319617038119517,
    (iv_inp_addr_mortgage_type in ['CONVENTIONAL', 'EQUITY LOAN', 'GOVERNMENT', 'UNKNOWN']) => 0.0195619540174361,
    iv_inp_addr_mortgage_type = ''                                                        => 0.00444219892327251,
                                                                                               0.00444219892327251);

final_score_tree_58_c564 := map(
    NULL < iv_bureau_emergence_age AND iv_bureau_emergence_age < 30.5 => -0.00996456358658346,
    iv_bureau_emergence_age >= 30.5                                   => final_score_tree_58_c565,
    iv_bureau_emergence_age = NULL                                    => 0.00981045780901073,
                                                                         -0.00335947149442306);

final_score_tree_58 := map(
    NULL < rv_l80_inp_avm_autoval AND rv_l80_inp_avm_autoval < 76898 => final_score_tree_58_c562,
    rv_l80_inp_avm_autoval >= 76898                                  => final_score_tree_58_c564,
    rv_l80_inp_avm_autoval = NULL                                    => -1.13573552635541e-05,
                                                                        -1.13573552635541e-05);

final_score_tree_59_c568 := map(
    (rv_d32_criminal_x_felony in ['0-0', '1-0', '2-2', '3-0', '3-2', '3-3']) => -0.0116306292777948,
    (rv_d32_criminal_x_felony in ['1-1', '2-0', '2-1', '3-1'])               => 0.15923121058067,
    rv_d32_criminal_x_felony = ''                                          => -0.0108562659246805,
                                                                                -0.0108562659246805);

final_score_tree_59_c567 := map(
    NULL < rv_e57_prof_license_br_flag AND rv_e57_prof_license_br_flag < 0.5 => 0.000292096133010073,
    rv_e57_prof_license_br_flag >= 0.5                                       => final_score_tree_59_c568,
    rv_e57_prof_license_br_flag = NULL                                       => -0.00461992828582047,
                                                                                -0.00171884997352938);

final_score_tree_59_c570 := map(
    NULL < rv_c13_inp_addr_lres AND rv_c13_inp_addr_lres < 260.5 => 0.0716461109986559,
    rv_c13_inp_addr_lres >= 260.5                                => -0.0681042311035521,
    rv_c13_inp_addr_lres = NULL                                  => 0.0534307886306331,
                                                                    0.0534307886306331);

final_score_tree_59_c569 := map(
    NULL < rv_c13_max_lres AND rv_c13_max_lres < 40.5 => final_score_tree_59_c570,
    rv_c13_max_lres >= 40.5                           => 0.00325555868221259,
    rv_c13_max_lres = NULL                            => 0.00927967556673306,
                                                         0.00927967556673306);

final_score_tree_59 := map(
    (iv_l77_dwelltype in ['MFD', 'SFD']) => final_score_tree_59_c567,
    (iv_l77_dwelltype in ['POB', 'RR'])  => final_score_tree_59_c569,
    iv_l77_dwelltype = ''              => -0.00112387774146551,
                                            -0.00112387774146551);

final_score_tree_60_c573 := map(
    NULL < rv_d31_attr_bankruptcy_recency AND rv_d31_attr_bankruptcy_recency < 4.5 => -0.00525261939118318,
    rv_d31_attr_bankruptcy_recency >= 4.5                                          => 0.012107324261203,
    rv_d31_attr_bankruptcy_recency = NULL                                          => 0.04501740222855,
                                                                                      -0.0038654424917262);

final_score_tree_60_c575 := map(
    NULL < iv_c13_avg_lres AND iv_c13_avg_lres < 249 => 0.0138946439250798,
    iv_c13_avg_lres >= 249                           => -0.0633267529129278,
    iv_c13_avg_lres = NULL                           => 0.0106718203294769,
                                                        0.0120154478006708);

final_score_tree_60_c574 := map(
    (rv_6seg_riskview_5_0 in ['2 ADDR NOT CURRENT - DEROG', '3 ADDR NOT CURRENT - OTHER', '5 SUFFICIENTLY VERD - OWNER'])           => 0.00111803693368938,
    (rv_6seg_riskview_5_0 in ['0 TRUEDID = 0', '1 VER/VAL PROBLEMS', '4 SUFFICIENTLY VERD - DEROG', '6 SUFFICIENTLY VERD - OTHER']) => final_score_tree_60_c575,
    rv_6seg_riskview_5_0 = ''                                                                                                     => 0.00522132245365989,
                                                                                                                                       0.00522132245365989);

final_score_tree_60_c572 := map(
    NULL < rv_s66_adlperssn_count AND rv_s66_adlperssn_count < 1.5 => final_score_tree_60_c573,
    rv_s66_adlperssn_count >= 1.5                                  => final_score_tree_60_c574,
    rv_s66_adlperssn_count = NULL                                  => -0.00012999598890309,
                                                                      6.06579334022822e-05);

final_score_tree_60 := map(
    NULL < rv_l80_inp_avm_autoval AND rv_l80_inp_avm_autoval < 739903 => final_score_tree_60_c572,
    rv_l80_inp_avm_autoval >= 739903                                  => -0.0179907735888743,
    rv_l80_inp_avm_autoval = NULL                                     => -0.000130531759621624,
                                                                         -0.000130531759621624);

final_score_tree_61_c578 := map(
    NULL < rv_f01_inp_addr_address_score AND rv_f01_inp_addr_address_score < 95 => -0.00706409948846161,
    rv_f01_inp_addr_address_score >= 95                                         => 0.00400906994659998,
    rv_f01_inp_addr_address_score = NULL                                        => 0.00213588561437343,
                                                                                   0.00213588561437343);

final_score_tree_61_c577 := map(
    NULL < rv_comb_age AND rv_comb_age < 51.5 => -0.0079205770237331,
    rv_comb_age >= 51.5                       => final_score_tree_61_c578,
    rv_comb_age = NULL                        => -0.00469062453056695,
                                                 -0.00201956226594185);

final_score_tree_61_c580 := map(
    (iv_d34_liens_unrel_x_rel in ['0-0', '0-1', '1-0', '2-0'])                             => 0.013545266877971,
    (iv_d34_liens_unrel_x_rel in ['0-2', '1-1', '1-2', '2-1', '2-2', '3-0', '3-1', '3-2']) => 0.161806152564966,
    iv_d34_liens_unrel_x_rel = ''                                                        => 0.0162891163935082,
                                                                                              0.0162891163935082);

final_score_tree_61_c579 := map(
    NULL < iv_emergence_source_type AND iv_emergence_source_type < 1.5 => final_score_tree_61_c580,
    iv_emergence_source_type >= 1.5                                    => 0.163650776494938,
    iv_emergence_source_type = NULL                                    => 0.0187436289306696,
                                                                          0.0187436289306696);

final_score_tree_61 := map(
    NULL < iv_lname_bureau_only AND iv_lname_bureau_only < 0.5 => final_score_tree_61_c577,
    iv_lname_bureau_only >= 0.5                                => final_score_tree_61_c579,
    iv_lname_bureau_only = NULL                                => -0.00109351515438726,
                                                                  -0.00109351515438726);

final_score_tree_62_c584 := map(
    NULL < iv_c13_avg_lres AND iv_c13_avg_lres < 14.5 => -0.0431316321985287,
    iv_c13_avg_lres >= 14.5                           => 0.0152957740720973,
    iv_c13_avg_lres = NULL                            => 0.00594202875629525,
                                                         0.00594202875629525);

final_score_tree_62_c585 := map(
    NULL < rv_a44_curr_add_naprop AND rv_a44_curr_add_naprop < 3.5 => -0.0390119871138042,
    rv_a44_curr_add_naprop >= 3.5                                  => 0.245893917456943,
    rv_a44_curr_add_naprop = NULL                                  => 0.0265778614204686,
                                                                      0.0265778614204686);

final_score_tree_62_c583 := map(
    NULL < iv_header_emergence_age AND iv_header_emergence_age < 16.5 or rv_comb_age >= 62 => final_score_tree_62_c584,
    iv_header_emergence_age >= 16.5 and rv_comb_age < 62                                   => -0.0178721027631466,
    iv_header_emergence_age = NULL                                                         => final_score_tree_62_c585,
                                                                                              -0.00858311144016838);

final_score_tree_62_c582 := map(
    NULL < rv_comb_age AND rv_comb_age < 37.5 => final_score_tree_62_c583,
    rv_comb_age >= 37.5                       => 0.00294141174878935,
    rv_comb_age = NULL                        => -0.00686308236727473,
                                                 0.000583886213294805);

final_score_tree_62 := map(
    NULL < iv_prop1_purch_sale_diff AND iv_prop1_purch_sale_diff < -214999.5 => 0.0679901546452455,
    iv_prop1_purch_sale_diff >= -214999.5                                    => -0.0124714995235842,
    iv_prop1_purch_sale_diff = NULL                                          => final_score_tree_62_c582,
                                                                                -3.19050404032766e-05);

final_score_tree_63_c588 := map(
    NULL < rv_l79_adls_per_addr_curr AND rv_l79_adls_per_addr_curr < 1.5 => 0.00143182342270389,
    rv_l79_adls_per_addr_curr >= 1.5                                     => -0.0198567680522817,
    rv_l79_adls_per_addr_curr = NULL                                     => -0.00726892948266305,
                                                                            -0.00726892948266305);

final_score_tree_63_c590 := map(
    NULL < rv_c13_curr_addr_lres AND rv_c13_curr_addr_lres < 107.5 => -0.0276357984647907,
    rv_c13_curr_addr_lres >= 107.5                                 => 0.00290352129557549,
    rv_c13_curr_addr_lres = NULL                                   => -0.017510688812731,
                                                                      -0.017510688812731);

final_score_tree_63_c589 := map(
    NULL < rv_l79_adls_per_addr_curr AND rv_l79_adls_per_addr_curr < 0.5 => final_score_tree_63_c590,
    rv_l79_adls_per_addr_curr >= 0.5                                     => 0.00237458723435439,
    rv_l79_adls_per_addr_curr = NULL                                     => 0.000374455122240975,
                                                                            0.000374455122240975);

final_score_tree_63_c587 := map(
    NULL < rv_f01_inp_addr_address_score AND rv_f01_inp_addr_address_score < 85 => final_score_tree_63_c588,
    rv_f01_inp_addr_address_score >= 85                                         => final_score_tree_63_c589,
    rv_f01_inp_addr_address_score = NULL                                        => -0.00112543335770484,
                                                                                   -0.00112543335770484);

final_score_tree_63 := map(
    NULL < rv_d32_mos_since_fel_ls AND rv_d32_mos_since_fel_ls < 53.5 => final_score_tree_63_c587,
    rv_d32_mos_since_fel_ls >= 53.5                                   => 0.0755987900505595,
    rv_d32_mos_since_fel_ls = NULL                                    => 0.00803110470233047,
                                                                         -0.000787041542910555);

final_score_tree_64_c593 := map(
    NULL < rv_a49_curr_add_avm_pct_chg_3yr AND rv_a49_curr_add_avm_pct_chg_3yr < 1.885 => -0.0182540122729402,
    rv_a49_curr_add_avm_pct_chg_3yr >= 1.885                                           => 0.0406684020305433,
    rv_a49_curr_add_avm_pct_chg_3yr = NULL                                             => -0.0069394560411941,
                                                                                          -0.00859298954942888);

final_score_tree_64_c592 := map(
    NULL < adl_dob AND adl_dob < 0.5 => 0.0187412587785564,
    adl_dob >= 0.5                   => final_score_tree_64_c593,
    adl_dob = NULL                   => -0.00557255889554298,
                                        -0.00557255889554298);

final_score_tree_64_c595 := map(
    (rv_e58_br_dead_bus_x_active_phn in ['0-2', '1-1', '1-2', '2-0', '3-3'])                                           => -0.0362745420564767,
    (rv_e58_br_dead_bus_x_active_phn in ['0-0', '0-1', '0-3', '1-0', '1-3', '2-1', '2-2', '2-3', '3-0', '3-1', '3-2']) => 0.00438775668645002,
    rv_e58_br_dead_bus_x_active_phn = ''                                                                             => 0.00375604701714051,
                                                                                                                          0.00375604701714051);

final_score_tree_64_c594 := map(
    (rv_d32_criminal_x_felony in ['0-0', '1-0', '1-1', '2-0', '3-2', '3-3']) => final_score_tree_64_c595,
    (rv_d32_criminal_x_felony in ['2-1', '2-2', '3-0', '3-1'])               => 0.105617325049675,
    rv_d32_criminal_x_felony = ''                                          => 0.00392114566236906,
                                                                                0.00392114566236906);

final_score_tree_64 := map(
    NULL < iv_bureau_emergence_age AND iv_bureau_emergence_age < 21.5 => final_score_tree_64_c592,
    iv_bureau_emergence_age >= 21.5                                   => final_score_tree_64_c594,
    iv_bureau_emergence_age = NULL                                    => 0.000255046311189524,
                                                                         0.000469454770017402);

final_score_tree_65_c599 := map(
    (iv_inp_addr_mortgage_type in ['NO MORTGAGE'])                                          => 0.0020256920232934,
    (iv_inp_addr_mortgage_type in ['CONVENTIONAL', 'EQUITY LOAN', 'GOVERNMENT', 'UNKNOWN']) => 0.0524032529592964,
    iv_inp_addr_mortgage_type = ''                                                        => 0.00276512197517153,
                                                                                               0.00276512197517153);

final_score_tree_65_c598 := map(
    NULL < rv_a46_curr_avm_autoval AND rv_a46_curr_avm_autoval < 320085.5 => final_score_tree_65_c599,
    rv_a46_curr_avm_autoval >= 320085.5                                   => -0.0381383790800267,
    rv_a46_curr_avm_autoval = NULL                                        => 0.00152829182274992,
                                                                             0.00152829182274992);

final_score_tree_65_c597 := map(
    NULL < rv_a44_curr_add_naprop AND rv_a44_curr_add_naprop < 1.5 => final_score_tree_65_c598,
    rv_a44_curr_add_naprop >= 1.5                                  => -0.00532108426507162,
    rv_a44_curr_add_naprop = NULL                                  => -0.00137326371256749,
                                                                      -0.00137326371256749);

final_score_tree_65_c600 := map(
    NULL < rv_c20_m_bureau_adl_fs AND rv_c20_m_bureau_adl_fs < 394.5 => 0.0409885796918829,
    rv_c20_m_bureau_adl_fs >= 394.5                                  => 0.00157624428845223,
    rv_c20_m_bureau_adl_fs = NULL                                    => 0.0109421818818389,
                                                                        0.0109421818818389);

final_score_tree_65 := map(
    NULL < rv_c20_m_bureau_adl_fs AND rv_c20_m_bureau_adl_fs < 392.5 => final_score_tree_65_c597,
    rv_c20_m_bureau_adl_fs >= 392.5                                  => final_score_tree_65_c600,
    rv_c20_m_bureau_adl_fs = NULL                                    => -0.00746838964440302,
                                                                        -0.000104930747881864);

final_score_tree_66_c603 := map(
    NULL < iv_c13_avg_lres AND iv_c13_avg_lres < 195.5 => 0.00997999838247825,
    iv_c13_avg_lres >= 195.5                           => -0.0428585825653863,
    iv_c13_avg_lres = NULL                             => 0.00783321462181796,
                                                          0.00783321462181796);

final_score_tree_66_c605 := map(
    NULL < rv_i62_inq_ssns_per_adl AND rv_i62_inq_ssns_per_adl < 9.5 => -0.0045483369063887,
    rv_i62_inq_ssns_per_adl >= 9.5                                   => 0.0297499108871492,
    rv_i62_inq_ssns_per_adl = NULL                                   => -0.00408911031142292,
                                                                        -0.00408911031142292);

final_score_tree_66_c604 := map(
    NULL < iv_mos_src_voter_adl_lseen AND iv_mos_src_voter_adl_lseen < 39.5 => final_score_tree_66_c605,
    iv_mos_src_voter_adl_lseen >= 39.5                                      => 0.012172352110387,
    iv_mos_src_voter_adl_lseen = NULL                                       => -0.00262586409782278,
                                                                               -0.00262586409782278);

final_score_tree_66_c602 := map(
    NULL < rv_c12_num_nonderogs AND rv_c12_num_nonderogs < 1.5 => final_score_tree_66_c603,
    rv_c12_num_nonderogs >= 1.5                                => final_score_tree_66_c604,
    rv_c12_num_nonderogs = NULL                                => -0.00141674910907981,
                                                                  -0.000848299824473317);

final_score_tree_66 := map(
    NULL < rv_l80_inp_avm_autoval AND rv_l80_inp_avm_autoval < 1272880.5 => final_score_tree_66_c602,
    rv_l80_inp_avm_autoval >= 1272880.5                                  => 0.0398706826842121,
    rv_l80_inp_avm_autoval = NULL                                        => -0.000744262203293951,
                                                                            -0.000744262203293951);

final_score_tree_67_c609 := map(
    NULL < iv_header_emergence_age AND iv_header_emergence_age < 35.5 => 0.0178210756530038,
    iv_header_emergence_age >= 35.5                                   => 0.083675590646006,
    iv_header_emergence_age = NULL                                    => 0.0211003617057165,
                                                                         0.0211003617057165);

final_score_tree_67_c608 := map(
    NULL < iv_c14_addrs_per_adl AND iv_c14_addrs_per_adl < 11.5 => 0.00159236694999431,
    iv_c14_addrs_per_adl >= 11.5                                => final_score_tree_67_c609,
    iv_c14_addrs_per_adl = NULL                                 => 0.00340813988201663,
                                                                   0.00340813988201663);

final_score_tree_67_c610 := map(
    NULL < rv_f01_inp_addr_address_score AND rv_f01_inp_addr_address_score < 95 => -0.0354533610007562,
    rv_f01_inp_addr_address_score >= 95                                         => -0.000175020525642911,
    rv_f01_inp_addr_address_score = NULL                                        => -0.00229413282288187,
                                                                                   -0.00229413282288187);

final_score_tree_67_c607 := map(
    NULL < rv_c12_inp_addr_source_count AND rv_c12_inp_addr_source_count < 1.5 => final_score_tree_67_c608,
    rv_c12_inp_addr_source_count >= 1.5                                        => final_score_tree_67_c610,
    rv_c12_inp_addr_source_count = NULL                                        => -0.000161329507664748,
                                                                                  -0.000161329507664748);

final_score_tree_67 := map(
    NULL < iv_fname_non_phn_src_ct AND iv_fname_non_phn_src_ct < 0.5 => -0.0600818007505456,
    iv_fname_non_phn_src_ct >= 0.5                                   => final_score_tree_67_c607,
    iv_fname_non_phn_src_ct = NULL                                   => -0.00288204659604388,
                                                                        -0.000646698749047396);

final_score_tree_68_c614 := map(
    NULL < rv_c12_source_profile AND rv_c12_source_profile < 75.05 => 0.00129736528191054,
    rv_c12_source_profile >= 75.05                                 => 0.0188247888466935,
    rv_c12_source_profile = NULL                                   => 0.0102098350382975,
                                                                      0.00754475390741051);

final_score_tree_68_c615 := map(
    NULL < rv_c13_inp_addr_lres AND rv_c13_inp_addr_lres < 39.5 => 0.166649550560065,
    rv_c13_inp_addr_lres >= 39.5                                => -0.0323813425630491,
    rv_c13_inp_addr_lres = NULL                                 => 0.0923446837941023,
                                                                   0.0923446837941023);

final_score_tree_68_c613 := map(
    NULL < rv_l70_add_standardized AND rv_l70_add_standardized < 0.5 => final_score_tree_68_c614,
    rv_l70_add_standardized >= 0.5                                   => final_score_tree_68_c615,
    rv_l70_add_standardized = NULL                                   => 0.00848445038547699,
                                                                        0.00848445038547699);

final_score_tree_68_c612 := map(
    NULL < rv_l80_inp_avm_autoval AND rv_l80_inp_avm_autoval < 341109.5 => final_score_tree_68_c613,
    rv_l80_inp_avm_autoval >= 341109.5                                  => -0.0815411342248682,
    rv_l80_inp_avm_autoval = NULL                                       => 0.00718001115093737,
                                                                           0.00718001115093737);

final_score_tree_68 := map(
    NULL < rv_l79_adls_per_sfd_addr AND rv_l79_adls_per_sfd_addr < -0.5 => final_score_tree_68_c612,
    rv_l79_adls_per_sfd_addr >= -0.5                                    => -0.00230145590309955,
    rv_l79_adls_per_sfd_addr = NULL                                     => -0.000476844581610346,
                                                                           -0.000476844581610346);

final_score_tree_69_c620 := map(
    NULL < iv_estimated_income AND iv_estimated_income < 60500 => 0.00257928581028385,
    iv_estimated_income >= 60500                               => -0.0113072833433646,
    iv_estimated_income = NULL                                 => 0.00110734882491208,
                                                                  0.00110734882491208);

final_score_tree_69_c619 := map(
    NULL < rv_comb_age => final_score_tree_69_c620,
    rv_comb_age = NULL => -0.000938307677339203,
                          0.000336647345695665);

final_score_tree_69_c618 := map(
    NULL < rv_c13_curr_addr_lres AND rv_c13_curr_addr_lres < 570.5 => final_score_tree_69_c619,
    rv_c13_curr_addr_lres >= 570.5                                 => 0.0459228786778465,
    rv_c13_curr_addr_lres = NULL                                   => 0.000537194510611019,
                                                                      0.000537194510611019);

final_score_tree_69_c617 := map(
    NULL < iv_input_best_name_match AND iv_input_best_name_match < 1.5 => -0.014896163100488,
    iv_input_best_name_match >= 1.5                                    => final_score_tree_69_c618,
    iv_input_best_name_match = NULL                                    => -0.00300144909922726,
                                                                          -0.000643863696662501);

final_score_tree_69 := map(
    NULL < rv_l80_inp_avm_autoval AND rv_l80_inp_avm_autoval < 1340636.5 => final_score_tree_69_c617,
    rv_l80_inp_avm_autoval >= 1340636.5                                  => 0.0599389756960788,
    rv_l80_inp_avm_autoval = NULL                                        => -0.000529021022502165,
                                                                            -0.000529021022502165);

final_score_tree_70_c623 := map(
    (iv_college_major in ['LIBERAL ARTS', 'UNCLASSIFIED'])                                       => -0.0238090744944838,
    (iv_college_major in ['BUSINESS', 'MEDICAL', 'NO AMS FOUND', 'NO COLLEGE FOUND', 'SCIENCE']) => -0.000716195637414612,
    iv_college_major = ''                                                                      => -0.0017288649379909,
                                                                                                    -0.0017288649379909);

final_score_tree_70_c624 := map(
    NULL < rv_a49_curr_add_avm_chg_2yr AND rv_a49_curr_add_avm_chg_2yr < 39236.5 => 0.0605600665193247,
    rv_a49_curr_add_avm_chg_2yr >= 39236.5                                       => -0.0985704695262061,
    rv_a49_curr_add_avm_chg_2yr = NULL                                           => 0.0258577311341875,
                                                                                    0.0260722707776561);

final_score_tree_70_c622 := map(
    NULL < rv_d31_bk_disposed_recent_count AND rv_d31_bk_disposed_recent_count < 0.5 => final_score_tree_70_c623,
    rv_d31_bk_disposed_recent_count >= 0.5                                           => final_score_tree_70_c624,
    rv_d31_bk_disposed_recent_count = NULL                                           => -0.00665211071508659,
                                                                                        -0.00140831012112729);

final_score_tree_70_c625 := map(
    NULL < iv_prv_addr_lres AND iv_prv_addr_lres < 394 => 0.00743690302420776,
    iv_prv_addr_lres >= 394                            => 0.111781004031052,
    iv_prv_addr_lres = NULL                            => 0.0536698504070142,
                                                          0.0105579478413892);

final_score_tree_70 := map(
    (iv_l77_dwelltype in ['MFD', 'SFD']) => final_score_tree_70_c622,
    (iv_l77_dwelltype in ['POB', 'RR'])  => final_score_tree_70_c625,
    iv_l77_dwelltype = ''              => -0.000742422170824336,
                                            -0.000742422170824336);

final_score_tree_71_c628 := map(
    NULL < rv_comb_age AND rv_comb_age < 55.5 => -0.00620153806261366,
    rv_comb_age >= 55.5                       => 0.00193934081348551,
    rv_comb_age = NULL                        => -0.00736913693606639,
                                                 -0.00215894415881105);

final_score_tree_71_c629 := map(
    NULL < rv_d30_derog_count AND rv_d30_derog_count < 2.5 => 0.01672260585351,
    rv_d30_derog_count >= 2.5                              => 0.114410506002468,
    rv_d30_derog_count = NULL                              => 0.0198029923396307,
                                                              0.0198029923396307);

final_score_tree_71_c627 := map(
    NULL < iv_lname_bureau_only AND iv_lname_bureau_only < 0.5 => final_score_tree_71_c628,
    iv_lname_bureau_only >= 0.5                                => final_score_tree_71_c629,
    iv_lname_bureau_only = NULL                                => -0.00116685307162271,
                                                                  -0.00116685307162271);

final_score_tree_71_c630 := map(
    NULL < rv_c18_invalid_addrs_per_adl AND rv_c18_invalid_addrs_per_adl < 1.5 => 0.0150652945988749,
    rv_c18_invalid_addrs_per_adl >= 1.5                                        => 0.0686342194440578,
    rv_c18_invalid_addrs_per_adl = NULL                                        => 0.0278517736627387,
                                                                                  0.0278517736627387);

final_score_tree_71 := map(
    NULL < rv_l79_adls_per_sfd_addr AND rv_l79_adls_per_sfd_addr < 5.5 => final_score_tree_71_c627,
    rv_l79_adls_per_sfd_addr >= 5.5                                    => final_score_tree_71_c630,
    rv_l79_adls_per_sfd_addr = NULL                                    => -0.000419484522311872,
                                                                          -0.000419484522311872);

final_score_tree_72_c633 := map(
    NULL < iv_estimated_income AND iv_estimated_income < 59500 => 7.21363512149163e-05,
    iv_estimated_income >= 59500                               => -0.017701637247904,
    iv_estimated_income = NULL                                 => -0.00127708705617061,
                                                                  -0.00127708705617061);

final_score_tree_72_c635 := map(
    NULL < rv_c13_max_lres AND rv_c13_max_lres < 300.5 => 0.000287016491872668,
    rv_c13_max_lres >= 300.5                           => 0.0295849752782535,
    rv_c13_max_lres = NULL                             => 0.0059720447838216,
                                                          0.0059720447838216);

final_score_tree_72_c634 := map(
    NULL < rv_c13_max_lres AND rv_c13_max_lres < 38.5 => 0.0841378767726081,
    rv_c13_max_lres >= 38.5                           => final_score_tree_72_c635,
    rv_c13_max_lres = NULL                            => 0.00808566226197379,
                                                         0.00808566226197379);

final_score_tree_72_c632 := map(
    (iv_inp_addr_mortgage_type in ['CONVENTIONAL', 'GOVERNMENT', 'NO MORTGAGE']) => final_score_tree_72_c633,
    (iv_inp_addr_mortgage_type in ['EQUITY LOAN', 'UNKNOWN'])                    => final_score_tree_72_c634,
    iv_inp_addr_mortgage_type = ''                                             => 8.14973979004469e-05,
                                                                                    8.14973979004469e-05);

final_score_tree_72 := map(
    NULL < rv_d31_bk_dism_hist_count AND rv_d31_bk_dism_hist_count < 0.5 => final_score_tree_72_c632,
    rv_d31_bk_dism_hist_count >= 0.5                                     => 0.0279345224095273,
    rv_d31_bk_dism_hist_count = NULL                                     => 0.00646965588710513,
                                                                            0.000505137184413747);

final_score_tree_73_c639 := map(
    NULL < rv_d31_bk_disposed_hist_count AND rv_d31_bk_disposed_hist_count < 1.5 => 0.00328611059533562,
    rv_d31_bk_disposed_hist_count >= 1.5                                         => 0.0693198657216119,
    rv_d31_bk_disposed_hist_count = NULL                                         => 0.00347596635305939,
                                                                                    0.00347596635305939);

final_score_tree_73_c638 := map(
    NULL < iv_lname_non_phn_src_ct AND iv_lname_non_phn_src_ct < 4.5 => final_score_tree_73_c639,
    iv_lname_non_phn_src_ct >= 4.5                                   => -0.00415679956558012,
    iv_lname_non_phn_src_ct = NULL                                   => 0.00223834319148151,
                                                                        0.00223834319148151);

final_score_tree_73_c637_1 := map(
    NULL < rv_comb_age                                         => final_score_tree_73_c638,
    NULL < iv_estimated_income AND iv_estimated_income < 34500 => -0.029544687420166,
    iv_estimated_income >= 34500                               => 0.019366328087568,
    iv_estimated_income = NULL                                 => -0.0140063269874532,
                                                                  -0.0140063269874532);

final_score_tree_73_c640 := if(rv_comb_age = NULL, 0.00150245098119242, 0.00120429561266904);

final_score_tree_73 := map(
    NULL < iv_prop2_purch_sale_diff AND iv_prop2_purch_sale_diff < 171748.5 => -0.0368259783453622,
    iv_prop2_purch_sale_diff >= 171748.5                                    => 0.0256601279736211,
    iv_prop2_purch_sale_diff = NULL                                         => final_score_tree_73_c640,
                                                                               0.000885998024239246);

final_score_tree_74_c642 := map(
    (rv_6seg_riskview_5_0 in ['0 TRUEDID = 0', '2 ADDR NOT CURRENT - DEROG', '3 ADDR NOT CURRENT - OTHER', '5 SUFFICIENTLY VERD - OWNER', '6 SUFFICIENTLY VERD - OTHER']) => -0.00151570811566732,
    (rv_6seg_riskview_5_0 in ['1 VER/VAL PROBLEMS', '4 SUFFICIENTLY VERD - DEROG'])                                                                                       => 0.00870715871748739,
    rv_6seg_riskview_5_0 = ''                                                                                                                                           => 4.08577868206924e-06,
                                                                                                                                                                             4.08577868206924e-06);

final_score_tree_74_c645 := map(
    (rv_e58_br_dead_bus_x_active_phn in ['0-0', '0-1', '0-2', '1-2', '1-3', '2-1'])                             => -0.0182729318412273,
    (rv_e58_br_dead_bus_x_active_phn in ['0-3', '1-0', '1-1', '2-0', '2-2', '2-3', '3-0', '3-1', '3-2', '3-3']) => 0.107582749908651,
    rv_e58_br_dead_bus_x_active_phn = ''                                                                      => -0.0124525283286659,
                                                                                                                   -0.0124525283286659);

final_score_tree_74_c644 := map(
    NULL < rv_a44_curr_add_naprop AND rv_a44_curr_add_naprop < 1.5 => 0.00850646117780357,
    rv_a44_curr_add_naprop >= 1.5                                  => final_score_tree_74_c645,
    rv_a44_curr_add_naprop = NULL                                  => -0.000187120235499848,
                                                                      -0.000187120235499848);

final_score_tree_74_c643 := map(
    NULL < rv_i62_inq_fnamesperadl_recency AND rv_i62_inq_fnamesperadl_recency < 2 => final_score_tree_74_c644,
    rv_i62_inq_fnamesperadl_recency >= 2                                           => 0.0583585263079438,
    rv_i62_inq_fnamesperadl_recency = NULL                                         => 0.00428866290199277,
                                                                                      0.00428866290199277);

final_score_tree_74 := map(
    (iv_l77_dwelltype in ['MFD', 'SFD']) => final_score_tree_74_c642,
    (iv_l77_dwelltype in ['POB', 'RR'])  => final_score_tree_74_c643,
    iv_l77_dwelltype = ''              => 0.000235862702340977,
                                            0.000235862702340977);

final_score_tree_75_c649 := map(
    NULL < rv_c13_curr_addr_lres AND rv_c13_curr_addr_lres < 436.5 => -0.0309267483433176,
    rv_c13_curr_addr_lres >= 436.5                                 => 0.171886695462607,
    rv_c13_curr_addr_lres = NULL                                   => -0.0253379804936982,
                                                                      -0.0253379804936982);

final_score_tree_75_c648 := map(
    NULL < iv_estimated_income AND iv_estimated_income < 70500 => -0.000710126389865583,
    iv_estimated_income >= 70500                               => final_score_tree_75_c649,
    iv_estimated_income = NULL                                 => -0.00183707790331081,
                                                                  -0.00183707790331081);

final_score_tree_75_c647 := map(
    (iv_inp_addr_mortgage_type in ['CONVENTIONAL', 'GOVERNMENT', 'NO MORTGAGE']) => final_score_tree_75_c648,
    (iv_inp_addr_mortgage_type in ['EQUITY LOAN', 'UNKNOWN'])                    => 0.00653589372430064,
    iv_inp_addr_mortgage_type = ''                                             => -0.000627627538750079,
                                                                                    -0.000627627538750079);

final_score_tree_75_c650 := map(
    NULL < iv_a46_l77_addrs_move_traj_index AND iv_a46_l77_addrs_move_traj_index < 1.5 => -0.0208671783868425,
    iv_a46_l77_addrs_move_traj_index >= 1.5                                            => 0.0377762557799356,
    iv_a46_l77_addrs_move_traj_index = NULL                                            => 0.025468979880386,
                                                                                          0.025468979880386);

final_score_tree_75 := map(
    NULL < rv_i60_inq_banking_count12 AND rv_i60_inq_banking_count12 < 0.5 => final_score_tree_75_c647,
    rv_i60_inq_banking_count12 >= 0.5                                      => final_score_tree_75_c650,
    rv_i60_inq_banking_count12 = NULL                                      => -0.00212677718879623,
                                                                              -0.000222672677933982);

final_score_tree_76_c653 := map(
    NULL < rv_c13_attr_addrs_recency AND rv_c13_attr_addrs_recency < 7.5 => 0.0143189874269229,
    rv_c13_attr_addrs_recency >= 7.5                                     => -0.00133658080426542,
    rv_c13_attr_addrs_recency = NULL                                     => -0.000396696707430422,
                                                                            -0.000396696707430422);

final_score_tree_76_c655 := map(
    NULL < iv_c13_avg_lres AND iv_c13_avg_lres < 69.5 => 0.0484099207082593,
    iv_c13_avg_lres >= 69.5                           => 0.203732795052926,
    iv_c13_avg_lres = NULL                            => 0.0837736108492325,
                                                         0.0837736108492325);

final_score_tree_76_c654 := map(
    NULL < rv_c20_m_bureau_adl_fs AND rv_c20_m_bureau_adl_fs < 360.5 => final_score_tree_76_c655,
    rv_c20_m_bureau_adl_fs >= 360.5                                  => -0.0537292077317003,
    rv_c20_m_bureau_adl_fs = NULL                                    => 0.0582730881305868,
                                                                        0.0582730881305868);

final_score_tree_76_c652 := map(
    NULL < rv_d32_mos_since_crim_ls AND rv_d32_mos_since_crim_ls < 70.5 => final_score_tree_76_c653,
    rv_d32_mos_since_crim_ls >= 70.5                                    => final_score_tree_76_c654,
    rv_d32_mos_since_crim_ls = NULL                                     => 0.00202380195991232,
                                                                           -0.000135421164002136);

final_score_tree_76 := map(
    NULL < rv_l80_inp_avm_autoval AND rv_l80_inp_avm_autoval < 710250 => final_score_tree_76_c652,
    rv_l80_inp_avm_autoval >= 710250                                  => -0.0255922542067316,
    rv_l80_inp_avm_autoval = NULL                                     => -0.000424619907443999,
                                                                         -0.000424619907443999);

final_score_tree_77_c658 := map(
    NULL < iv_input_best_name_match AND iv_input_best_name_match < 1.5 => -0.0140612690121273,
    iv_input_best_name_match >= 1.5                                    => 0.00158179026811814,
    iv_input_best_name_match = NULL                                    => -0.0269372466334046,
                                                                          0.000366573244731963);

final_score_tree_77_c660 := map(
    NULL < iv_bureau_emergence_age AND iv_bureau_emergence_age < 16.5 or rv_comb_age >= 62 => 0.113332576820583,
    iv_bureau_emergence_age >= 16.5 and rv_comb_age < 62                                   => 0.0268049940342755,
    iv_bureau_emergence_age = NULL                                                         => 0.0351159916627629,
                                                                                              0.0351159916627629);

final_score_tree_77_c659 := map(
    NULL < rv_comb_age AND rv_comb_age < 27.5 => -0.047007392753274,
    rv_comb_age >= 27.5                       => final_score_tree_77_c660,
    rv_comb_age = NULL                        => 0.0239752224590369,
                                                 0.0239752224590369);

final_score_tree_77_c657 := map(
    NULL < rv_i60_inq_count12 AND rv_i60_inq_count12 < 6.5 => final_score_tree_77_c658,
    rv_i60_inq_count12 >= 6.5                              => final_score_tree_77_c659,
    rv_i60_inq_count12 = NULL                              => 0.00352844985045724,
                                                              0.000853569257044228);

final_score_tree_77 := map(
    NULL < rv_l80_inp_avm_autoval AND rv_l80_inp_avm_autoval < 516968 => final_score_tree_77_c657,
    rv_l80_inp_avm_autoval >= 516968                                  => 0.0165694529126819,
    rv_l80_inp_avm_autoval = NULL                                     => 0.00126590665343242,
                                                                         0.00126590665343242);

final_score_tree_78_c665 := map(
    NULL < rv_c20_m_bureau_adl_fs AND rv_c20_m_bureau_adl_fs < 349 => 0.227067194653314,
    rv_c20_m_bureau_adl_fs >= 349                                  => 0.0147966442561213,
    rv_c20_m_bureau_adl_fs = NULL                                  => 0.124862855573184,
                                                                      0.124862855573184);

final_score_tree_78_c664 := map(
    NULL < rv_a49_curr_add_avm_chg_2yr AND rv_a49_curr_add_avm_chg_2yr < 9199 => -0.0264549302486708,
    rv_a49_curr_add_avm_chg_2yr >= 9199                                       => final_score_tree_78_c665,
    rv_a49_curr_add_avm_chg_2yr = NULL                                        => 0.0449759464715315,
                                                                                 0.0478398925725412);

final_score_tree_78_c663 := map(
    NULL < iv_lname_bureau_only AND iv_lname_bureau_only < 0.5 => 0.00446183616828466,
    iv_lname_bureau_only >= 0.5                                => final_score_tree_78_c664,
    iv_lname_bureau_only = NULL                                => 0.00598029821244032,
                                                                  0.00598029821244032);

final_score_tree_78_c662 := map(
    NULL < iv_header_emergence_age AND iv_header_emergence_age < 71.5 or rv_comb_age >= 62 => final_score_tree_78_c663,
    iv_header_emergence_age >= 71.5 and rv_comb_age < 62                                   => -0.0714546898661693,
    iv_header_emergence_age = NULL                                                         => 0.101553055008807,
                                                                                              0.00627562391093623);

final_score_tree_78 := map(
    NULL < iv_full_name_ver_sources AND iv_full_name_ver_sources < 2.5 => -0.00252140479586758,
    iv_full_name_ver_sources >= 2.5                                    => final_score_tree_78_c662,
    iv_full_name_ver_sources = NULL                                    => -0.0225274886566772,
                                                                          -0.000120275159031296);

final_score_tree_79_c669 := map(
    NULL < iv_prop1_purch_sale_diff AND iv_prop1_purch_sale_diff < 22450 => -0.0526131063415662,
    iv_prop1_purch_sale_diff >= 22450                                    => 0.0196704179011894,
    iv_prop1_purch_sale_diff = NULL                                      => 0.00715033635457041,
                                                                            0.00605979155592413);

final_score_tree_79_c670 := map(
    NULL < rv_c13_max_lres AND rv_c13_max_lres < 69.5 => -0.0489646027284687,
    rv_c13_max_lres >= 69.5                           => 0.0934456790287145,
    rv_c13_max_lres = NULL                            => 0.0589915786035895,
                                                         0.0589915786035895);

final_score_tree_79_c668 := map(
    NULL < rv_i60_inq_hiriskcred_count12 AND rv_i60_inq_hiriskcred_count12 < 0.5 => final_score_tree_79_c669,
    rv_i60_inq_hiriskcred_count12 >= 0.5                                         => final_score_tree_79_c670,
    rv_i60_inq_hiriskcred_count12 = NULL                                         => 0.00768041910997611,
                                                                                    0.00768041910997611);

final_score_tree_79_c667 := map(
    NULL < rv_c20_m_bureau_adl_fs AND rv_c20_m_bureau_adl_fs < 392.5 => -0.00205018023211295,
    rv_c20_m_bureau_adl_fs >= 392.5                                  => final_score_tree_79_c668,
    rv_c20_m_bureau_adl_fs = NULL                                    => 0.00599063793053634,
                                                                        -0.000831789636117388);

final_score_tree_79 := map(
    NULL < rv_l80_inp_avm_autoval AND rv_l80_inp_avm_autoval < 937214.5 => final_score_tree_79_c667,
    rv_l80_inp_avm_autoval >= 937214.5                                  => -0.0301363400202407,
    rv_l80_inp_avm_autoval = NULL                                       => -0.000989589871711936,
                                                                           -0.000989589871711936);

final_score_tree_80_c672 := map(
    NULL < iv_header_emergence_age AND iv_header_emergence_age < 25.5 => -0.0261100386963134,
    iv_header_emergence_age >= 25.5                                   => 0.0101968839166993,
    iv_header_emergence_age = NULL                                    => -0.0236606890160255,
                                                                         -0.0145452378817342);

final_score_tree_80_c675 := map(
    NULL < rv_d30_derog_count AND rv_d30_derog_count < 0.5 => -0.00120931611451831,
    rv_d30_derog_count >= 0.5                              => 0.0135310975177385,
    rv_d30_derog_count = NULL                              => 0.00099874299886992,
                                                              0.00099874299886992);

final_score_tree_80_c674 := map(
    NULL < rv_d30_derog_count AND rv_d30_derog_count < 2.5 => final_score_tree_80_c675,
    rv_d30_derog_count >= 2.5                              => -0.0250393327788258,
    rv_d30_derog_count = NULL                              => 9.50392715231091e-06,
                                                              9.50392715231091e-06);

final_score_tree_80_c673 := map(
    NULL < rv_c13_curr_addr_lres AND rv_c13_curr_addr_lres < 42.5 => 0.00539510786493712,
    rv_c13_curr_addr_lres >= 42.5                                 => final_score_tree_80_c674,
    rv_c13_curr_addr_lres = NULL                                  => 0.0019514209963199,
                                                                     0.0019514209963199);

final_score_tree_80 := map(
    NULL < iv_input_best_name_match AND iv_input_best_name_match < 1.5 => final_score_tree_80_c672,
    iv_input_best_name_match >= 1.5                                    => final_score_tree_80_c673,
    iv_input_best_name_match = NULL                                    => 0.00112057974770811,
                                                                          0.00071987415149919);

final_score_tree_81_c678 := map(
    (iv_college_code_x_type in ['1-P', '1-S', '2-P', '2-R', '4-P', '4-R', '4-S']) => -0.0249669763834326,
    (iv_college_code_x_type in ['-1', '1-R', '2-S', '2-U'])                       => -0.000620034485465432,
    iv_college_code_x_type = ''                                                 => -0.00156342991102064,
                                                                                     -0.00156342991102064);

final_score_tree_81_c677 := map(
    NULL < rv_i60_inq_other_count12 AND rv_i60_inq_other_count12 < 3.5 => final_score_tree_81_c678,
    rv_i60_inq_other_count12 >= 3.5                                    => 0.11862637643426,
    rv_i60_inq_other_count12 = NULL                                    => -0.00392426399136371,
                                                                          -0.00151020979102095);

final_score_tree_81_c680 := map(
    NULL < rv_c13_curr_addr_lres AND rv_c13_curr_addr_lres < 390 => 0.00339198827597709,
    rv_c13_curr_addr_lres >= 390                                 => -0.0540193232159258,
    rv_c13_curr_addr_lres = NULL                                 => 0.00198983332542337,
                                                                    0.00198983332542337);

final_score_tree_81_c679 := map(
    NULL < iv_lname_non_phn_src_ct AND iv_lname_non_phn_src_ct < 1.5 => 0.070280028711524,
    iv_lname_non_phn_src_ct >= 1.5                                   => final_score_tree_81_c680,
    iv_lname_non_phn_src_ct = NULL                                   => 0.00582791519269282,
                                                                        0.00582791519269282);

final_score_tree_81 := map(
    (iv_l77_dwelltype in ['MFD', 'SFD']) => final_score_tree_81_c677,
    (iv_l77_dwelltype in ['POB', 'RR'])  => final_score_tree_81_c679,
    iv_l77_dwelltype = ''              => -0.00110881945495199,
                                            -0.00110881945495199);

final_score_tree_82_c685 := map(
    NULL < rv_comb_age AND rv_comb_age < 37.5 or rv_comb_age >= 62 => 0.0251259945455333,
    rv_comb_age >= 37.5 and rv_comb_age < 62                       => -0.0506252987096942,
    rv_comb_age = NULL                                             => -0.026596662677122,
                                                                      -0.026596662677122);

final_score_tree_82_c684 := map(
    NULL < iv_prv_addr_lres AND iv_prv_addr_lres < 62.5 => 0.0519517393798255,
    iv_prv_addr_lres >= 62.5                            => final_score_tree_82_c685,
    iv_prv_addr_lres = NULL                             => 0.029026706521423,
                                                           0.029026706521423);

final_score_tree_82_c683 := map(
    NULL < rv_a49_curr_avm_chg_1yr_pct AND rv_a49_curr_avm_chg_1yr_pct < 98.6 => 0.111748210368018,
    rv_a49_curr_avm_chg_1yr_pct >= 98.6                                       => -0.0146788690150892,
    rv_a49_curr_avm_chg_1yr_pct = NULL                                        => final_score_tree_82_c684,
                                                                                 0.0269753187495569);

final_score_tree_82_c682 := map(
    NULL < rv_i60_inq_banking_recency AND rv_i60_inq_banking_recency < 2 => 0.000106297075904685,
    rv_i60_inq_banking_recency >= 2                                      => final_score_tree_82_c683,
    rv_i60_inq_banking_recency = NULL                                    => -0.00252264437225959,
                                                                            0.000400504356260745);

final_score_tree_82 := map(
    NULL < rv_l80_inp_avm_autoval AND rv_l80_inp_avm_autoval < 1244000 => final_score_tree_82_c682,
    rv_l80_inp_avm_autoval >= 1244000                                  => 0.0525415654234513,
    rv_l80_inp_avm_autoval = NULL                                      => 0.000533009319273881,
                                                                          0.000533009319273881);

final_score_tree_83_c690 := map(
    (rv_6seg_riskview_5_0 in ['2 ADDR NOT CURRENT - DEROG', '3 ADDR NOT CURRENT - OTHER', '5 SUFFICIENTLY VERD - OWNER'])           => 0.0202069231731291,
    (rv_6seg_riskview_5_0 in ['0 TRUEDID = 0', '1 VER/VAL PROBLEMS', '4 SUFFICIENTLY VERD - DEROG', '6 SUFFICIENTLY VERD - OTHER']) => 0.107378819152587,
    rv_6seg_riskview_5_0 = ''                                                                                                    => 0.0624896368375837,
                                                                                                                                       0.0624896368375837);

final_score_tree_83_c689 := map(
    NULL < iv_prv_addr_lres AND iv_prv_addr_lres < 20.5 => final_score_tree_83_c690,
    iv_prv_addr_lres >= 20.5                            => 0.0177564263303188,
    iv_prv_addr_lres = NULL                             => 0.0314400608452444,
                                                           0.0314400608452444);

final_score_tree_83_c688 := map(
    NULL < rv_c12_source_profile AND rv_c12_source_profile < 55.65 => -0.020519639339761,
    rv_c12_source_profile >= 55.65                                 => final_score_tree_83_c689,
    rv_c12_source_profile = NULL                                   => 0.0184007444490073,
                                                                      0.0184007444490073);

final_score_tree_83_c687 := map(
    NULL < rv_i62_inq_ssns_per_adl AND rv_i62_inq_ssns_per_adl < 8.5 => -0.000941720567580003,
    rv_i62_inq_ssns_per_adl >= 8.5                                   => final_score_tree_83_c688,
    rv_i62_inq_ssns_per_adl = NULL                                   => -0.000190316095296819,
                                                                        -0.000576938925976561);

final_score_tree_83 := map(
    NULL < rv_l80_inp_avm_autoval AND rv_l80_inp_avm_autoval < 739903 => final_score_tree_83_c687,
    rv_l80_inp_avm_autoval >= 739903                                  => -0.0237190957352658,
    rv_l80_inp_avm_autoval = NULL                                     => -0.000815049199208025,
                                                                         -0.000815049199208025);

final_score_tree_84_c693 := map(
    NULL < rv_comb_age => -0.001345095435085,
    rv_comb_age = NULL => -0.00340888703236223,
                          -0.00265505687893154);

final_score_tree_84_c695 := map(
    NULL < rv_l79_adls_per_apt_addr AND rv_l79_adls_per_apt_addr < 0.5 => 0.0131402543373381,
    rv_l79_adls_per_apt_addr >= 0.5                                    => 0.056576695896869,
    rv_l79_adls_per_apt_addr = NULL                                    => 0.0216528493941651,
                                                                          0.0216528493941651);

final_score_tree_84_c694 := map(
    NULL < rv_c12_inp_addr_source_count AND rv_c12_inp_addr_source_count < 1.5 => final_score_tree_84_c695,
    rv_c12_inp_addr_source_count >= 1.5                                        => 0.00305537947284731,
    rv_c12_inp_addr_source_count = NULL                                        => 0.00582658194868004,
                                                                                  0.00582658194868004);

final_score_tree_84_c692 := map(
    NULL < iv_full_name_ver_sources AND iv_full_name_ver_sources < 2.5 => final_score_tree_84_c693,
    iv_full_name_ver_sources >= 2.5                                    => final_score_tree_84_c694,
    iv_full_name_ver_sources = NULL                                    => -0.00493972517829624,
                                                                          -0.000339324110383536);

final_score_tree_84 := map(
    NULL < rv_l80_inp_avm_autoval AND rv_l80_inp_avm_autoval < 740168.5 => final_score_tree_84_c692,
    rv_l80_inp_avm_autoval >= 740168.5                                  => -0.0163021171991183,
    rv_l80_inp_avm_autoval = NULL                                       => -0.000505543814772098,
                                                                           -0.000505543814772098);

final_score_tree_85_c699 := map(
    NULL < iv_f00_nas_summary AND iv_f00_nas_summary < 11.5 => -0.0124126365984341,
    iv_f00_nas_summary >= 11.5                              => 0.000709803572683084,
    iv_f00_nas_summary = NULL                               => -0.0204532337924975,
                                                               -0.00195669669811698);

final_score_tree_85_c698 := map(
    NULL < rv_c13_curr_addr_lres AND rv_c13_curr_addr_lres < 30.5 => 0.00110038664722826,
    rv_c13_curr_addr_lres >= 30.5                                 => final_score_tree_85_c699,
    rv_c13_curr_addr_lres = NULL                                  => -0.00104512722636772,
                                                                     -0.00104512722636772);

final_score_tree_85_c700 := map(
    NULL < rv_s66_adlperssn_count AND rv_s66_adlperssn_count < 3.5 => 0.00663291534773878,
    rv_s66_adlperssn_count >= 3.5                                  => 0.0754434911457823,
    rv_s66_adlperssn_count = NULL                                  => -0.0240914834793047,
                                                                      -0.00288038512294925);

final_score_tree_85_c697 := map(
    NULL < iv_d34_released_liens_ct AND iv_d34_released_liens_ct < 3.5 => final_score_tree_85_c698,
    iv_d34_released_liens_ct >= 3.5                                    => 0.0934425970223859,
    iv_d34_released_liens_ct = NULL                                    => final_score_tree_85_c700,
                                                                          -0.000950687428598153);

final_score_tree_85 := map(
    NULL < rv_l80_inp_avm_autoval AND rv_l80_inp_avm_autoval < 1707642.5 => final_score_tree_85_c697,
    rv_l80_inp_avm_autoval >= 1707642.5                                  => -0.0677354584763125,
    rv_l80_inp_avm_autoval = NULL                                        => -0.0010130713789154,
                                                                            -0.0010130713789154);

final_score_tree_86_c705 := map(
    NULL < iv_estimated_income AND iv_estimated_income < 41500 => -0.0137409306527053,
    iv_estimated_income >= 41500                               => 0.019244248772449,
    iv_estimated_income = NULL                                 => -0.00578459752813639,
                                                                  -0.00578459752813639);

final_score_tree_86_c704 := map(
    NULL < rv_c13_attr_addrs_recency AND rv_c13_attr_addrs_recency < 589.5 => 0.00832451341649487,
    rv_c13_attr_addrs_recency >= 589.5                                     => final_score_tree_86_c705,
    rv_c13_attr_addrs_recency = NULL                                       => 0.00502443466134399,
                                                                              0.00502443466134399);

final_score_tree_86_c703 := map(
    NULL < rv_d32_mos_since_fel_ls AND rv_d32_mos_since_fel_ls < 20.5 => final_score_tree_86_c704,
    rv_d32_mos_since_fel_ls >= 20.5                                   => 0.125591538319507,
    rv_d32_mos_since_fel_ls = NULL                                    => 0.00538938355551598,
                                                                         0.00538938355551598);

final_score_tree_86_c702 := map(
    (iv_college_major in ['LIBERAL ARTS', 'NO COLLEGE FOUND', 'UNCLASSIFIED']) => -0.017985385045552,
    (iv_college_major in ['BUSINESS', 'MEDICAL', 'NO AMS FOUND', 'SCIENCE'])   => final_score_tree_86_c703,
    iv_college_major = ''                                                    => 0.00322296140740379,
                                                                                  0.00322296140740379);

final_score_tree_86 := map(
    NULL < iv_prv_addr_lres AND iv_prv_addr_lres < 77.5 => -0.00437480678471655,
    iv_prv_addr_lres >= 77.5                            => final_score_tree_86_c702,
    iv_prv_addr_lres = NULL                             => -0.00555700637643191,
                                                           -0.00146500159854357);

final_score_tree_87_c710 := map(
    NULL < iv_full_name_non_phn_src_ct AND iv_full_name_non_phn_src_ct < 4.5 => 0.00566671849639534,
    iv_full_name_non_phn_src_ct >= 4.5                                       => -0.0350125457040269,
    iv_full_name_non_phn_src_ct = NULL                                       => -0.00154117741332509,
                                                                                -0.00154117741332509);

final_score_tree_87_c709 := map(
    NULL < rv_a49_curr_avm_chg_1yr_pct AND rv_a49_curr_avm_chg_1yr_pct < 78.85 => 0.0458254117338283,
    rv_a49_curr_avm_chg_1yr_pct >= 78.85                                       => final_score_tree_87_c710,
    rv_a49_curr_avm_chg_1yr_pct = NULL                                         => -0.000312227179883892,
                                                                                  5.38851553347698e-05);

final_score_tree_87_c708 := map(
    NULL < rv_a49_curr_add_avm_chg_3yr AND rv_a49_curr_add_avm_chg_3yr < -53944 => -0.0459909958315953,
    rv_a49_curr_add_avm_chg_3yr >= -53944                                       => -0.000807295930737358,
    rv_a49_curr_add_avm_chg_3yr = NULL                                          => final_score_tree_87_c709,
                                                                                   -0.000554666075802329);

final_score_tree_87_c707 := map(
    NULL < rv_c18_invalid_addrs_per_adl AND rv_c18_invalid_addrs_per_adl < 11.5 => final_score_tree_87_c708,
    rv_c18_invalid_addrs_per_adl >= 11.5                                        => 0.0897059619573989,
    rv_c18_invalid_addrs_per_adl = NULL                                         => -0.00436735393172219,
                                                                                   -0.000494308563114424);

final_score_tree_87 := map(
    NULL < rv_l80_inp_avm_autoval AND rv_l80_inp_avm_autoval < 739683.5 => final_score_tree_87_c707,
    rv_l80_inp_avm_autoval >= 739683.5                                  => -0.0214862393854741,
    rv_l80_inp_avm_autoval = NULL                                       => -0.000714617575138035,
                                                                           -0.000714617575138035);

final_score_tree_88_c714 := map(
    NULL < iv_prop1_purch_sale_diff AND iv_prop1_purch_sale_diff < 112510 => -0.0067899209289552,
    iv_prop1_purch_sale_diff >= 112510                                    => -0.0745795684442852,
    iv_prop1_purch_sale_diff = NULL                                       => 0.0110095707471465,
                                                                             0.00903922571106886);

final_score_tree_88_c713 := map(
    NULL < rv_s66_adlperssn_count AND rv_s66_adlperssn_count < 2.5 => -0.00147245496883674,
    rv_s66_adlperssn_count >= 2.5                                  => final_score_tree_88_c714,
    rv_s66_adlperssn_count = NULL                                  => 0.00203970944397434,
                                                                      6.36786391554716e-05);

final_score_tree_88_c712 := map(
    NULL < rv_l79_adls_per_apt_addr_c6 AND rv_l79_adls_per_apt_addr_c6 < 1.5 => final_score_tree_88_c713,
    rv_l79_adls_per_apt_addr_c6 >= 1.5                                       => -0.02996535297424,
    rv_l79_adls_per_apt_addr_c6 = NULL                                       => -0.000415238662541069,
                                                                                -0.000415238662541069);

final_score_tree_88_c715 := map(
    NULL < rv_d34_unrel_lien60_count AND rv_d34_unrel_lien60_count < 1.5 => 0.00724022900805161,
    rv_d34_unrel_lien60_count >= 1.5                                     => 0.098767365187501,
    rv_d34_unrel_lien60_count = NULL                                     => 0.00929313100401204,
                                                                            0.00929313100401204);

final_score_tree_88 := map(
    (iv_l77_dwelltype in ['MFD', 'SFD']) => final_score_tree_88_c712,
    (iv_l77_dwelltype in ['POB', 'RR'])  => final_score_tree_88_c715,
    iv_l77_dwelltype = ''              => 0.00011981792164228,
                                            0.00011981792164228);

final_score_tree_89_c718 := map(
    NULL < rv_f03_input_add_not_most_rec AND rv_f03_input_add_not_most_rec < 0.5 => 0.00622370192202218,
    rv_f03_input_add_not_most_rec >= 0.5                                         => -0.0189686934269296,
    rv_f03_input_add_not_most_rec = NULL                                         => 0.00140436733931537,
                                                                                    0.00140436733931537);

final_score_tree_89_c719 := map(
    NULL < iv_lname_non_phn_src_ct AND iv_lname_non_phn_src_ct < 5.5 => -0.000915494752588203,
    iv_lname_non_phn_src_ct >= 5.5                                   => -0.0168323578609854,
    iv_lname_non_phn_src_ct = NULL                                   => -0.00164991474136236,
                                                                        -0.00164991474136236);

final_score_tree_89_c717 := map(
    NULL < rv_c13_curr_addr_lres AND rv_c13_curr_addr_lres < 18.5 => final_score_tree_89_c718,
    rv_c13_curr_addr_lres >= 18.5                                 => final_score_tree_89_c719,
    rv_c13_curr_addr_lres = NULL                                  => -0.000949500685624681,
                                                                     -0.000949500685624681);

final_score_tree_89_c720 := map(
    NULL < iv_c14_addrs_per_adl AND iv_c14_addrs_per_adl < 9.5 => 0.0127143553409018,
    iv_c14_addrs_per_adl >= 9.5                                => 0.134673274596723,
    iv_c14_addrs_per_adl = NULL                                => 0.0590278689823527,
                                                                  0.0590278689823527);

final_score_tree_89 := map(
    NULL < rv_i60_inq_count12 AND rv_i60_inq_count12 < 16.5 => final_score_tree_89_c717,
    rv_i60_inq_count12 >= 16.5                              => final_score_tree_89_c720,
    rv_i60_inq_count12 = NULL                               => -0.00604126983795027,
                                                               -0.000899904433542851);

final_score_tree_90_c725 := map(
    NULL < rv_i60_inq_count12 AND rv_i60_inq_count12 < 3.5 => 0.00305131182237027,
    rv_i60_inq_count12 >= 3.5                              => 0.0215946807185506,
    rv_i60_inq_count12 = NULL                              => 0.00391632140925945,
                                                              0.00391632140925945);

final_score_tree_90_c724 := map(
    (rv_e58_br_dead_bus_x_active_phn in ['0-2', '0-3', '1-0', '1-2', '2-0', '2-1', '2-2', '2-3', '3-0', '3-3']) => -0.0261653921226429,
    (rv_e58_br_dead_bus_x_active_phn in ['0-0', '0-1', '1-1', '1-3', '3-1', '3-2'])                             => final_score_tree_90_c725,
    rv_e58_br_dead_bus_x_active_phn = ''                                                                      => 0.00296028934306744,
                                                                                                                   0.00296028934306744);

final_score_tree_90_c723 := map(
    NULL < rv_a49_curr_avm_chg_1yr_pct AND rv_a49_curr_avm_chg_1yr_pct < 31.95 => 0.0771814433654071,
    rv_a49_curr_avm_chg_1yr_pct >= 31.95                                       => 0.000972082022760172,
    rv_a49_curr_avm_chg_1yr_pct = NULL                                         => final_score_tree_90_c724,
                                                                                  0.00236201805083388);

final_score_tree_90_c722 := map(
    NULL < rv_c20_m_bureau_adl_fs AND rv_c20_m_bureau_adl_fs < 144.5 => -0.0140454784774957,
    rv_c20_m_bureau_adl_fs >= 144.5                                  => final_score_tree_90_c723,
    rv_c20_m_bureau_adl_fs = NULL                                    => 0.0050798273650952,
                                                                        0.000818245588923779);

final_score_tree_90 := map(
    NULL < rv_l80_inp_avm_autoval AND rv_l80_inp_avm_autoval < 1909181 => final_score_tree_90_c722,
    rv_l80_inp_avm_autoval >= 1909181                                  => 0.0781647151565983,
    rv_l80_inp_avm_autoval = NULL                                      => 0.000875620334540417,
                                                                          0.000875620334540417);

final_score_tree_91_c727 := map(
    NULL < iv_c13_avg_lres AND iv_c13_avg_lres < 64.5 => -0.00494368763827772,
    iv_c13_avg_lres >= 64.5                           => 0.00162966846228445,
    iv_c13_avg_lres = NULL                            => -0.00112538402479695,
                                                         -0.00112538402479695);

final_score_tree_91_c730 := map(
    NULL < rv_c14_addrs_15yr AND rv_c14_addrs_15yr < 3.5 => 0.212886525459543,
    rv_c14_addrs_15yr >= 3.5                             => 0.0636640159124886,
    rv_c14_addrs_15yr = NULL                             => 0.139561671630387,
                                                            0.139561671630387);

final_score_tree_91_c729 := map(
    NULL < rv_i60_inq_recency AND rv_i60_inq_recency < 2 => final_score_tree_91_c730,
    rv_i60_inq_recency >= 2                              => 0.0273499402351749,
    rv_i60_inq_recency = NULL                            => 0.0574808681098151,
                                                            0.0574808681098151);

final_score_tree_91_c728 := map(
    NULL < iv_c13_avg_lres AND iv_c13_avg_lres < 33.5 => -0.0183211093027575,
    iv_c13_avg_lres >= 33.5                           => final_score_tree_91_c729,
    iv_c13_avg_lres = NULL                            => 0.0290003563652069,
                                                         0.0290003563652069);

final_score_tree_91 := map(
    NULL < rv_i62_inq_phones_per_adl AND rv_i62_inq_phones_per_adl < 1.5 => final_score_tree_91_c727,
    rv_i62_inq_phones_per_adl >= 1.5                                     => final_score_tree_91_c728,
    rv_i62_inq_phones_per_adl = NULL                                     => 0.00135117372350365,
                                                                            -0.000798040484281786);

final_score_tree_92_c735 := map(
    NULL < rv_d34_unrel_lien60_count AND rv_d34_unrel_lien60_count < 2.5 => -0.00584676847712444,
    rv_d34_unrel_lien60_count >= 2.5                                     => 0.101109606812662,
    rv_d34_unrel_lien60_count = NULL                                     => -0.00499442656692808,
                                                                            -0.00499442656692808);

final_score_tree_92_c734 := map(
    NULL < rv_l79_adls_per_addr_curr AND rv_l79_adls_per_addr_curr < 1.5 => final_score_tree_92_c735,
    rv_l79_adls_per_addr_curr >= 1.5                                     => 0.00933370004216904,
    rv_l79_adls_per_addr_curr = NULL                                     => 0.00300118311279494,
                                                                            0.00300118311279494);

final_score_tree_92_c733 := map(
    NULL < rv_c13_curr_addr_lres AND rv_c13_curr_addr_lres < 27.5 => final_score_tree_92_c734,
    rv_c13_curr_addr_lres >= 27.5                                 => -0.00191542380828666,
    rv_c13_curr_addr_lres = NULL                                  => -0.000548102279343897,
                                                                     -0.000548102279343897);

final_score_tree_92_c732 := map(
    (iv_d34_liens_unrel_x_rel in ['0-1', '0-2', '1-1', '1-2', '2-2', '3-0']) => -0.0184196927700563,
    (iv_d34_liens_unrel_x_rel in ['0-0', '1-0', '2-0', '2-1', '3-1', '3-2']) => final_score_tree_92_c733,
    iv_d34_liens_unrel_x_rel = ''                                          => -0.0260094173182684,
                                                                                -0.0013593942895181);

final_score_tree_92 := map(
    '' < iv_rv5_unscorable AND iv_rv5_unscorable < '0.5' => final_score_tree_92_c732,
    iv_rv5_unscorable >= '0.5'                             => 0.0472806555407585,
    iv_rv5_unscorable = ''                             => -0.00109148049618906,
                                                            -0.00109148049618906);

final_score_tree_93_c739 := map(
    NULL < rv_l79_adls_per_addr_curr AND rv_l79_adls_per_addr_curr < 0.5 => -0.0194698882403158,
    rv_l79_adls_per_addr_curr >= 0.5                                     => 0.00376334057006844,
    rv_l79_adls_per_addr_curr = NULL                                     => 0.00157693880634626,
                                                                            0.00157693880634626);

final_score_tree_93_c738 := map(
    NULL < rv_f01_inp_addr_address_score AND rv_f01_inp_addr_address_score < 95 => -0.00364517428764704,
    rv_f01_inp_addr_address_score >= 95                                         => final_score_tree_93_c739,
    rv_f01_inp_addr_address_score = NULL                                        => 0.00049053859785483,
                                                                                   0.00049053859785483);

final_score_tree_93_c740 := map(
    NULL < rv_a49_curr_add_avm_chg_2yr AND rv_a49_curr_add_avm_chg_2yr < 6135.5 => 0.0907577239504888,
    rv_a49_curr_add_avm_chg_2yr >= 6135.5                                       => -0.0354522142198443,
    rv_a49_curr_add_avm_chg_2yr = NULL                                          => 0.0313516462486804,
                                                                                   0.0286119960702325);

final_score_tree_93_c737 := map(
    NULL < rv_i60_inq_banking_recency AND rv_i60_inq_banking_recency < 4.5 => final_score_tree_93_c738,
    rv_i60_inq_banking_recency >= 4.5                                      => final_score_tree_93_c740,
    rv_i60_inq_banking_recency = NULL                                      => 0.0007573403367997,
                                                                              0.0007573403367997);

final_score_tree_93 := map(
    NULL < iv_fname_non_phn_src_ct AND iv_fname_non_phn_src_ct < 0.5 => -0.049945451393175,
    iv_fname_non_phn_src_ct >= 0.5                                   => final_score_tree_93_c737,
    iv_fname_non_phn_src_ct = NULL                                   => 0.00981799032138678,
                                                                        0.000529114860692199);

final_score_tree_94_c745 := map(
    NULL < rv_c18_invalid_addrs_per_adl AND rv_c18_invalid_addrs_per_adl < 11.5 => 0.00326481289575049,
    rv_c18_invalid_addrs_per_adl >= 11.5                                        => 0.114992949465212,
    rv_c18_invalid_addrs_per_adl = NULL                                         => 0.00338581295871326,
                                                                                   0.00338581295871326);

final_score_tree_94_c744 := map(
    NULL < rv_c13_inp_addr_lres AND rv_c13_inp_addr_lres < 11.5 => -0.00351687660814109,
    rv_c13_inp_addr_lres >= 11.5                                => final_score_tree_94_c745,
    rv_c13_inp_addr_lres = NULL                                 => 0.00137413401586855,
                                                                   0.00137413401586855);

final_score_tree_94_c743 := map(
    NULL < iv_d34_liens_rel_cj_ct AND iv_d34_liens_rel_cj_ct < 0.5 => final_score_tree_94_c744,
    iv_d34_liens_rel_cj_ct >= 0.5                                  => -0.0290932583831818,
    iv_d34_liens_rel_cj_ct = NULL                                  => 0.000824974207689311,
                                                                      0.00100153906088615);

final_score_tree_94_c742 := map(
    NULL < iv_prop2_purch_sale_diff AND iv_prop2_purch_sale_diff < 4672.5 => 0.0893076765192643,
    iv_prop2_purch_sale_diff >= 4672.5                                    => -0.0378360878063082,
    iv_prop2_purch_sale_diff = NULL                                       => final_score_tree_94_c743,
                                                                             0.000926039847444593);

final_score_tree_94 := map(
    NULL < iv_prop1_purch_sale_diff AND iv_prop1_purch_sale_diff < -609600 => 0.0723279380616278,
    iv_prop1_purch_sale_diff >= -609600                                    => -0.01148872523748,
    iv_prop1_purch_sale_diff = NULL                                        => final_score_tree_94_c742,
                                                                              0.000300428813933912);

final_score_tree_95_c750 := map(
    NULL < rv_c13_attr_addrs_recency AND rv_c13_attr_addrs_recency < 7.5 => 0.0965777723346571,
    rv_c13_attr_addrs_recency >= 7.5                                     => 0.0114704074422308,
    rv_c13_attr_addrs_recency = NULL                                     => 0.0134348070771233,
                                                                            0.0134348070771233);

final_score_tree_95_c749 := map(
    (iv_d34_liens_unrel_x_rel in ['0-2', '1-0', '2-1', '2-2', '3-1', '3-2']) => -0.0408682102480452,
    (iv_d34_liens_unrel_x_rel in ['0-0', '0-1', '1-1', '1-2', '2-0', '3-0']) => final_score_tree_95_c750,
    iv_d34_liens_unrel_x_rel = ''                                          => 0.0111376529555357,
                                                                                0.0111376529555357);

final_score_tree_95_c748 := map(
    (iv_inp_addr_mortgage_type in ['CONVENTIONAL', 'GOVERNMENT', 'NO MORTGAGE']) => 0.000737669572237215,
    (iv_inp_addr_mortgage_type in ['EQUITY LOAN', 'UNKNOWN'])                    => final_score_tree_95_c749,
    iv_inp_addr_mortgage_type = ''                                             => 0.0020907696906634,
                                                                                    0.0020907696906634);

final_score_tree_95_c747 := map(
    NULL < iv_prop2_purch_sale_diff AND iv_prop2_purch_sale_diff < 172050 => -0.00273828332648496,
    iv_prop2_purch_sale_diff >= 172050                                    => 0.10232108309486,
    iv_prop2_purch_sale_diff = NULL                                       => final_score_tree_95_c748,
                                                                             0.0021731680147297);

final_score_tree_95 := map(
    NULL < iv_estimated_income AND iv_estimated_income < 87500 => final_score_tree_95_c747,
    iv_estimated_income >= 87500                               => -0.017088454497338,
    iv_estimated_income = NULL                                 => -0.00379290972597726,
                                                                  0.00142618578114359);

final_score_tree_96_c754 := map(
    NULL < rv_c13_curr_addr_lres AND rv_c13_curr_addr_lres < 0.5 => -0.0429209934616105,
    rv_c13_curr_addr_lres >= 0.5                                 => 0.0195598215307969,
    rv_c13_curr_addr_lres = NULL                                 => 0.0170687786610833,
                                                                    0.0170687786610833);

final_score_tree_96_c753 := map(
    NULL < rv_l79_adls_per_addr_curr AND rv_l79_adls_per_addr_curr < 1.5 => final_score_tree_96_c754,
    rv_l79_adls_per_addr_curr >= 1.5                                     => -0.00670438687989307,
    rv_l79_adls_per_addr_curr = NULL                                     => 0.00769477491485641,
                                                                            0.00769477491485641);

final_score_tree_96_c755 := map(
    NULL < rv_l79_adls_per_addr_curr AND rv_l79_adls_per_addr_curr < 0.5 => -0.0183811906944472,
    rv_l79_adls_per_addr_curr >= 0.5                                     => 0.00086941158716219,
    rv_l79_adls_per_addr_curr = NULL                                     => -0.00136269745358887,
                                                                            -0.00136269745358887);

final_score_tree_96_c752 := map(
    NULL < rv_c12_inp_addr_source_count AND rv_c12_inp_addr_source_count < 0.5 => final_score_tree_96_c753,
    rv_c12_inp_addr_source_count >= 0.5                                        => final_score_tree_96_c755,
    rv_c12_inp_addr_source_count = NULL                                        => -0.000129534508888593,
                                                                                  -0.000129534508888593);

final_score_tree_96 := map(
    NULL < iv_c13_avg_lres AND iv_c13_avg_lres < 229.5 => final_score_tree_96_c752,
    iv_c13_avg_lres >= 229.5                           => -0.0156816623874526,
    iv_c13_avg_lres = NULL                             => 0.0115063000132894,
                                                          -0.00103967270040885);

final_score_tree_97_c758 := map(
    NULL < rv_a44_curr_add_naprop AND rv_a44_curr_add_naprop < 1.5 => 0.00140822036785283,
    rv_a44_curr_add_naprop >= 1.5                                  => -0.00407391923032095,
    rv_a44_curr_add_naprop = NULL                                  => -0.000762608611334364,
                                                                      -0.000762608611334364);

final_score_tree_97_c760 := map(
    NULL < rv_c12_inp_addr_source_count AND rv_c12_inp_addr_source_count < 1.5 => 0.125510692996906,
    rv_c12_inp_addr_source_count >= 1.5                                        => 0.0245980596741573,
    rv_c12_inp_addr_source_count = NULL                                        => 0.0744874514292243,
                                                                                  0.0744874514292243);

final_score_tree_97_c759 := map(
    NULL < rv_i60_inq_hiriskcred_count12 AND rv_i60_inq_hiriskcred_count12 < 0.5 => 0.0147917047786127,
    rv_i60_inq_hiriskcred_count12 >= 0.5                                         => final_score_tree_97_c760,
    rv_i60_inq_hiriskcred_count12 = NULL                                         => 0.0281575449091899,
                                                                                    0.0281575449091899);

final_score_tree_97_c757 := map(
    NULL < rv_d31_bk_dism_hist_count AND rv_d31_bk_dism_hist_count < 0.5 => final_score_tree_97_c758,
    rv_d31_bk_dism_hist_count >= 0.5                                     => final_score_tree_97_c759,
    rv_d31_bk_dism_hist_count = NULL                                     => -0.00317950537093476,
                                                                            -0.000429856445230328);

final_score_tree_97 := map(
    NULL < rv_l80_inp_avm_autoval AND rv_l80_inp_avm_autoval < 207259.5 => final_score_tree_97_c757,
    rv_l80_inp_avm_autoval >= 207259.5                                  => 0.00628776456235312,
    rv_l80_inp_avm_autoval = NULL                                       => 0.000565688454484074,
                                                                           0.000565688454484074);

final_score_tree_98_c763 := map(
    (iv_l77_dwelltype in ['POB'])              => -0.0193840459451611,
    (iv_l77_dwelltype in ['MFD', 'RR', 'SFD']) => 0.0195232343015307,
    iv_l77_dwelltype = ''                    => 0.0150224877337968,
                                                  0.0150224877337968);

final_score_tree_98_c764 := map(
    NULL < rv_comb_age => -0.00684697921659069,
    rv_comb_age = NULL => -0.0129266698976907,
                          -0.0129266698976907);

final_score_tree_98_c762 := map(
    NULL < rv_l79_adls_per_sfd_addr AND rv_l79_adls_per_sfd_addr < 1.5 => final_score_tree_98_c763,
    rv_l79_adls_per_sfd_addr >= 1.5                                    => final_score_tree_98_c764,
    rv_l79_adls_per_sfd_addr = NULL                                    => 0.00589200978208781,
                                                                          0.00589200978208781);

final_score_tree_98_c765 := map(
    NULL < rv_f01_inp_addr_address_score AND rv_f01_inp_addr_address_score < 95 => -0.0223855267076401,
    rv_f01_inp_addr_address_score >= 95                                         => -0.000537141700653171,
    rv_f01_inp_addr_address_score = NULL                                        => -0.00256625585649606,
                                                                                   -0.00256625585649606);

final_score_tree_98 := map(
    NULL < rv_c12_inp_addr_source_count AND rv_c12_inp_addr_source_count < 0.5 => final_score_tree_98_c762,
    rv_c12_inp_addr_source_count >= 0.5                                        => final_score_tree_98_c765,
    rv_c12_inp_addr_source_count = NULL                                        => 0.00220218266773296,
                                                                                  -0.00140741249687927);

final_score_tree_99_c769 := map(
    NULL < iv_num_inperson_sources AND iv_num_inperson_sources < 0.5 => 0.0412125840010454,
    iv_num_inperson_sources >= 0.5                                   => 0.00994075000858583,
    iv_num_inperson_sources = NULL                                   => 0.0136401569435912,
                                                                        0.0136401569435912);

final_score_tree_99_c768 := map(
    NULL < rv_c10_m_hdr_fs AND rv_c10_m_hdr_fs < 145.5 => -0.0210185030713076,
    rv_c10_m_hdr_fs >= 145.5                           => final_score_tree_99_c769,
    rv_c10_m_hdr_fs = NULL                             => 0.00916381643418157,
                                                          0.00916381643418157);

final_score_tree_99_c770 := map(
    NULL < adl_hphn AND adl_hphn < 0.5 => -0.0378108818748815,
    adl_hphn >= 0.5                    => 0.020880663221306,
    adl_hphn = NULL                    => -0.000511582187584782,
                                          -0.000511582187584782);

final_score_tree_99_c767 := map(
    NULL < rv_i62_inq_fnamesperadl_recency AND rv_i62_inq_fnamesperadl_recency < 0.5 => -0.000408016513240584,
    rv_i62_inq_fnamesperadl_recency >= 0.5                                           => final_score_tree_99_c768,
    rv_i62_inq_fnamesperadl_recency = NULL                                           => final_score_tree_99_c770,
                                                                                        0.00062829533658714);

final_score_tree_99 := map(
    NULL < rv_l80_inp_avm_autoval AND rv_l80_inp_avm_autoval < 1505000 => final_score_tree_99_c767,
    rv_l80_inp_avm_autoval >= 1505000                                  => -0.0376226677440869,
    rv_l80_inp_avm_autoval = NULL                                      => 0.000568919828968473,
                                                                          0.000568919828968473);

final_score_tree_100_c774 := map(
    NULL < iv_lname_non_phn_src_ct AND iv_lname_non_phn_src_ct < 2.5 => 0.00747263564237667,
    iv_lname_non_phn_src_ct >= 2.5                                   => -0.00115110908429842,
    iv_lname_non_phn_src_ct = NULL                                   => 0.00121060204818309,
                                                                        0.00121060204818309);

final_score_tree_100_c773 := map(
    NULL < iv_input_best_name_match AND iv_input_best_name_match < 1.5 => -0.0143495378349605,
    iv_input_best_name_match >= 1.5                                    => final_score_tree_100_c774,
    iv_input_best_name_match = NULL                                    => -0.0149297372064554,
                                                                          9.60431122793412e-06);

final_score_tree_100_c772 := map(
    (rv_e58_br_dead_bus_x_active_phn in ['0-1', '0-2', '1-0', '1-1', '2-0', '2-3', '3-0', '3-1', '3-3']) => -0.0164114016794773,
    (rv_e58_br_dead_bus_x_active_phn in ['0-0', '0-3', '1-2', '1-3', '2-1', '2-2', '3-2'])               => final_score_tree_100_c773,
    rv_e58_br_dead_bus_x_active_phn = ''                                                               => -0.000373402569579805,
                                                                                                            -0.000845220243751804);

final_score_tree_100_c775 := map(
    NULL < rv_c13_inp_addr_lres AND rv_c13_inp_addr_lres < 184.5 => -0.00662461600902149,
    rv_c13_inp_addr_lres >= 184.5                                => 0.0427418629660397,
    rv_c13_inp_addr_lres = NULL                                  => 0.0149081256114298,
                                                                    0.0149081256114298);

final_score_tree_100 := map(
    NULL < rv_l80_inp_avm_autoval AND rv_l80_inp_avm_autoval < 514005 => final_score_tree_100_c772,
    rv_l80_inp_avm_autoval >= 514005                                  => final_score_tree_100_c775,
    rv_l80_inp_avm_autoval = NULL                                     => -0.0004258235232718,
                                                                         -0.0004258235232718);

final_score_tree_101_c778 := map(
    NULL < rv_c13_inp_addr_lres AND rv_c13_inp_addr_lres < 97.5 => -0.00481683836955589,
    rv_c13_inp_addr_lres >= 97.5                                => 0.00155234787624782,
    rv_c13_inp_addr_lres = NULL                                 => -0.00224069263759129,
                                                                   -0.00224069263759129);

final_score_tree_101_c780 := map(
    NULL < iv_header_emergence_age AND iv_header_emergence_age < 17.5 or rv_comb_age >= 62 => 0.0163297455570262,
    iv_header_emergence_age >= 17.5 and rv_comb_age < 62                                   => -0.0036235057015647,
    iv_header_emergence_age = NULL                                                         => -0.0170753160795139,
                                                                                              2.76941296198883e-05);

final_score_tree_101_c779 := map(
    NULL < rv_c12_source_profile AND rv_c12_source_profile < 75.35 => final_score_tree_101_c780,
    rv_c12_source_profile >= 75.35                                 => 0.0156792458602886,
    rv_c12_source_profile = NULL                                   => 0.00484464281207298,
                                                                      0.00484464281207298);

final_score_tree_101_c777 := map(
    NULL < rv_s66_adlperssn_count AND rv_s66_adlperssn_count < 1.5 => final_score_tree_101_c778,
    rv_s66_adlperssn_count >= 1.5                                  => final_score_tree_101_c779,
    rv_s66_adlperssn_count = NULL                                  => 0.00604716221339266,
                                                                      0.000979553947280961);

final_score_tree_101 := map(
    NULL < rv_i62_inq_num_names_per_adl AND rv_i62_inq_num_names_per_adl < 4.5 => final_score_tree_101_c777,
    rv_i62_inq_num_names_per_adl >= 4.5                                        => -0.0737716462608849,
    rv_i62_inq_num_names_per_adl = NULL                                        => 0.0118355393985634,
                                                                                  0.00102378194841911);

final_score_tree_102_c783 := map(
    NULL < rv_l80_inp_avm_autoval AND rv_l80_inp_avm_autoval < 304960.5 => 0.000301802774907329,
    rv_l80_inp_avm_autoval >= 304960.5                                  => 0.0853967788528547,
    rv_l80_inp_avm_autoval = NULL                                       => 0.000497596295680335,
                                                                           0.000497596295680335);

final_score_tree_102_c785 := map(
    NULL < rv_comb_age AND rv_comb_age < 55.5 or rv_comb_age >= 62 => 0.154379207740989,
    rv_comb_age >= 55.5 and rv_comb_age < 62                       => 0.0164348085818585,
    rv_comb_age = NULL                                             => 0.0940856293005746,
                                                                      0.0940856293005746);

final_score_tree_102_c784 := map(
    NULL < rv_c20_m_bureau_adl_fs AND rv_c20_m_bureau_adl_fs < 310.5 => 0.00161241265264353,
    rv_c20_m_bureau_adl_fs >= 310.5                                  => final_score_tree_102_c785,
    rv_c20_m_bureau_adl_fs = NULL                                    => 0.046367078402123,
                                                                        0.046367078402123);

final_score_tree_102_c782 := map(
    (iv_d34_liens_unrel_x_rel in ['0-0', '0-1', '0-2', '1-0', '1-1', '2-0', '2-1', '2-2', '3-0', '3-2']) => final_score_tree_102_c783,
    (iv_d34_liens_unrel_x_rel in ['1-2', '3-1'])                                                         => final_score_tree_102_c784,
    iv_d34_liens_unrel_x_rel = ''                                                                      => 0.000608059576749865,
                                                                                                            0.000713032914964315);

final_score_tree_102 := map(
    NULL < rv_l80_inp_avm_autoval AND rv_l80_inp_avm_autoval < 309736 => final_score_tree_102_c782,
    rv_l80_inp_avm_autoval >= 309736                                  => -0.00852590907350942,
    rv_l80_inp_avm_autoval = NULL                                     => -2.95497760428807e-05,
                                                                         -2.95497760428807e-05);

final_score_tree_103_c788 := map(
    NULL < rv_c14_addrs_5yr AND rv_c14_addrs_5yr < 0.5 => -0.0197011518859459,
    rv_c14_addrs_5yr >= 0.5                            => 0.0447724518009506,
    rv_c14_addrs_5yr = NULL                            => -0.00158713505954769,
                                                          -0.00362555192930953);

final_score_tree_103_c787 := map(
    NULL < iv_prv_addr_lres AND iv_prv_addr_lres < 72.5 => -0.00220022970220653,
    iv_prv_addr_lres >= 72.5                            => 0.00743681925058355,
    iv_prv_addr_lres = NULL                             => final_score_tree_103_c788,
                                                           0.00150421040968787);

final_score_tree_103_c790 := map(
    NULL < rv_comb_age AND rv_comb_age < 44.5 => 0.0118342054165571,
    rv_comb_age >= 44.5                       => 0.103359596277503,
    rv_comb_age = NULL                        => 0.0497518673446631,
                                                 0.0497518673446631);

final_score_tree_103_c789 := map(
    NULL < rv_d32_mos_since_crim_ls AND rv_d32_mos_since_crim_ls < 30.5 => -0.0025070805446618,
    rv_d32_mos_since_crim_ls >= 30.5                                    => final_score_tree_103_c790,
    rv_d32_mos_since_crim_ls = NULL                                     => -0.0175347988259936,
                                                                           -0.00221623352839915);

final_score_tree_103 := map(
    NULL < rv_l80_inp_avm_autoval AND rv_l80_inp_avm_autoval < 65988.5 => final_score_tree_103_c787,
    rv_l80_inp_avm_autoval >= 65988.5                                  => final_score_tree_103_c789,
    rv_l80_inp_avm_autoval = NULL                                      => 0.000149244955073093,
                                                                          0.000149244955073093);

final_score_tree_104_c792 := map(
    NULL < iv_num_inperson_sources AND iv_num_inperson_sources < 4.5 => -0.00643354509067413,
    iv_num_inperson_sources >= 4.5                                   => 0.0468520469819849,
    iv_num_inperson_sources = NULL                                   => -0.00543605908745236,
                                                                        -0.00543605908745236);

final_score_tree_104_c793 := map(
    NULL < rv_a49_curr_add_avm_chg_2yr AND rv_a49_curr_add_avm_chg_2yr < 74040 => 0.0441586261372257,
    rv_a49_curr_add_avm_chg_2yr >= 74040                                       => -0.00149733544056989,
    rv_a49_curr_add_avm_chg_2yr = NULL                                         => 0.0125807340823478,
                                                                                  0.0125807340823478);

final_score_tree_104_c795 := map(
    NULL < rv_a49_curr_avm_chg_1yr_pct AND rv_a49_curr_avm_chg_1yr_pct < 45.2 => 0.116830995500911,
    rv_a49_curr_avm_chg_1yr_pct >= 45.2                                       => -0.00804054230424353,
    rv_a49_curr_avm_chg_1yr_pct = NULL                                        => -0.0052268528539246,
                                                                                 -0.0052268528539246);

final_score_tree_104_c794 := map(
    NULL < rv_a49_curr_add_avm_pct_chg_2yr AND rv_a49_curr_add_avm_pct_chg_2yr < 2.785 => final_score_tree_104_c795,
    rv_a49_curr_add_avm_pct_chg_2yr >= 2.785                                           => 0.130439995780677,
    rv_a49_curr_add_avm_pct_chg_2yr = NULL                                             => -0.000769770335410027,
                                                                                          -0.000835676845098852);

final_score_tree_104 := map(
    NULL < rv_a49_curr_add_avm_chg_3yr AND rv_a49_curr_add_avm_chg_3yr < 94324 => final_score_tree_104_c792,
    rv_a49_curr_add_avm_chg_3yr >= 94324                                       => final_score_tree_104_c793,
    rv_a49_curr_add_avm_chg_3yr = NULL                                         => final_score_tree_104_c794,
                                                                                  -0.00154153396321231);

final_score_tree_105_c798 := map(
    (iv_d34_liens_unrel_x_rel in ['0-0', '0-1', '0-2', '2-0', '2-1', '2-2', '3-1', '3-2']) => -0.0111368221397182,
    (iv_d34_liens_unrel_x_rel in ['1-0', '1-1', '1-2', '3-0'])                             => 0.028080964464599,
    iv_d34_liens_unrel_x_rel = ''                                                        => -0.00915503341513547,
                                                                                              -0.00915503341513547);

final_score_tree_105_c797 := map(
    NULL < rv_c13_max_lres AND rv_c13_max_lres < 248.5 => 0.00244739412637135,
    rv_c13_max_lres >= 248.5                           => final_score_tree_105_c798,
    rv_c13_max_lres = NULL                             => 0.00177381165904178,
                                                          -0.000259366872643704);

final_score_tree_105_c800 := map(
    NULL < iv_full_name_non_phn_src_ct AND iv_full_name_non_phn_src_ct < 4.5 => 0.00907697939759971,
    iv_full_name_non_phn_src_ct >= 4.5                                       => -0.0151058359937659,
    iv_full_name_non_phn_src_ct = NULL                                       => 0.00531168739980833,
                                                                                0.00531168739980833);

final_score_tree_105_c799 := map(
    NULL < rv_d31_attr_bankruptcy_recency AND rv_d31_attr_bankruptcy_recency < 79.5 => final_score_tree_105_c800,
    rv_d31_attr_bankruptcy_recency >= 79.5                                          => 0.0480809905632872,
    rv_d31_attr_bankruptcy_recency = NULL                                           => -0.01226782954998,
                                                                                       0.00615357426813096);

final_score_tree_105 := map(
    NULL < rv_l80_inp_avm_autoval AND rv_l80_inp_avm_autoval < 158089 => final_score_tree_105_c797,
    rv_l80_inp_avm_autoval >= 158089                                  => final_score_tree_105_c799,
    rv_l80_inp_avm_autoval = NULL                                     => 0.0010689066347893,
                                                                         0.0010689066347893);

final_score_tree_106_c805 := map(
    NULL < rv_comb_age AND rv_comb_age < 57.5 => 0.00948627321587428,
    rv_comb_age >= 57.5                       => 0.0993519031645719,
    rv_comb_age = NULL                        => 0.0351621674869307,
                                                 0.0351621674869307);

final_score_tree_106_c804 := map(
    NULL < rv_c14_addrs_5yr AND rv_c14_addrs_5yr < 2.5 => final_score_tree_106_c805,
    rv_c14_addrs_5yr >= 2.5                            => 0.135542679396061,
    rv_c14_addrs_5yr = NULL                            => 0.0504772704647749,
                                                          0.0504772704647749);

final_score_tree_106_c803 := map(
    (rv_6seg_riskview_5_0 in ['2 ADDR NOT CURRENT - DEROG', '3 ADDR NOT CURRENT - OTHER', '5 SUFFICIENTLY VERD - OWNER', '6 SUFFICIENTLY VERD - OTHER']) => 0.0132245235840916,
    (rv_6seg_riskview_5_0 in ['0 TRUEDID = 0', '1 VER/VAL PROBLEMS', '4 SUFFICIENTLY VERD - DEROG'])                                                     => final_score_tree_106_c804,
    rv_6seg_riskview_5_0 = ''                                                                                                                          => 0.0179576475556576,
                                                                                                                                                            0.0179576475556576);

final_score_tree_106_c802 := map(
    NULL < rv_i62_inq_addrsperadl_recency AND rv_i62_inq_addrsperadl_recency < 9 => final_score_tree_106_c803,
    rv_i62_inq_addrsperadl_recency >= 9                                          => -0.0310633921563178,
    rv_i62_inq_addrsperadl_recency = NULL                                        => 0.0129498228404728,
                                                                                    0.0129498228404728);

final_score_tree_106 := map(
    NULL < iv_mos_src_voter_adl_lseen AND iv_mos_src_voter_adl_lseen < 41.5 => -0.00160212081534692,
    iv_mos_src_voter_adl_lseen >= 41.5                                      => final_score_tree_106_c802,
    iv_mos_src_voter_adl_lseen = NULL                                       => -0.000629254416271262,
                                                                               -0.00053026069531167);

final_score_tree_107_c807 := map(
    NULL < rv_c13_attr_addrs_recency AND rv_c13_attr_addrs_recency < 7.5 => 0.0162634740096109,
    rv_c13_attr_addrs_recency >= 7.5                                     => -0.00155438695841798,
    rv_c13_attr_addrs_recency = NULL                                     => -0.00309529382045707,
                                                                            -0.000577211481952898);

final_score_tree_107_c810 := map(
    NULL < rv_c13_inp_addr_lres AND rv_c13_inp_addr_lres < 2.5 => -0.0154447402429613,
    rv_c13_inp_addr_lres >= 2.5                                => 0.0238380112049003,
    rv_c13_inp_addr_lres = NULL                                => 0.0102624492506508,
                                                                  0.0102624492506508);

final_score_tree_107_c809 := map(
    NULL < rv_comb_age => final_score_tree_107_c810,
    rv_comb_age = NULL => 0.00293073965809276,
                          0.00293073965809276);

final_score_tree_107_c808 := map(
    NULL < iv_prv_addr_lres AND iv_prv_addr_lres < 373.5 => final_score_tree_107_c809,
    iv_prv_addr_lres >= 373.5                            => 0.091109283381482,
    iv_prv_addr_lres = NULL                              => 0.0444334965216292,
                                                            0.0064420238672909);

final_score_tree_107 := map(
    (iv_l77_dwelltype in ['MFD', 'SFD']) => final_score_tree_107_c807,
    (iv_l77_dwelltype in ['POB', 'RR'])  => final_score_tree_107_c808,
    iv_l77_dwelltype = ''              => -0.000184768382449872,
                                            -0.000184768382449872);

final_score_tree_108_c814 := map(
    NULL < rv_comb_age AND rv_comb_age < 18.5 or rv_comb_age >= 62 => 0.110919378920487,
    rv_comb_age >= 18.5 and rv_comb_age < 62                       => -0.0151144609766843,
    rv_comb_age = NULL                                             => -0.0425049305378552,
                                                                      -0.0130396628698936);

final_score_tree_108_c813 := map(
    NULL < rv_c15_ssns_per_adl AND rv_c15_ssns_per_adl < 1.5 => final_score_tree_108_c814,
    rv_c15_ssns_per_adl >= 1.5                               => 0.0636775439975984,
    rv_c15_ssns_per_adl = NULL                               => -0.0110538413646953,
                                                                -0.0110538413646953);

final_score_tree_108_c815 := map(
    (rv_d32_criminal_x_felony in ['1-0', '3-0', '3-3'])                             => -0.0523342732445018,
    (rv_d32_criminal_x_felony in ['0-0', '1-1', '2-0', '2-1', '2-2', '3-1', '3-2']) => -0.0059235343481323,
    rv_d32_criminal_x_felony = ''                                                 => -0.00717989581383408,
                                                                                       -0.00717989581383408);

final_score_tree_108_c812 := map(
    NULL < rv_a49_curr_avm_chg_1yr_pct AND rv_a49_curr_avm_chg_1yr_pct < 215.8 => final_score_tree_108_c813,
    rv_a49_curr_avm_chg_1yr_pct >= 215.8                                       => 0.093432585966086,
    rv_a49_curr_avm_chg_1yr_pct = NULL                                         => final_score_tree_108_c815,
                                                                                  -0.00751454898091234);

final_score_tree_108 := map(
    NULL < rv_c13_max_lres AND rv_c13_max_lres < 97.5 => final_score_tree_108_c812,
    rv_c13_max_lres >= 97.5                           => 0.000856927632762661,
    rv_c13_max_lres = NULL                            => -0.00217522548511842,
                                                         -0.00143907018654073);

final_score_tree_109_c817 := map(
    NULL < rv_a44_curr_add_naprop AND rv_a44_curr_add_naprop < 0.5 => 0.00244881585888989,
    rv_a44_curr_add_naprop >= 0.5                                  => -0.00264782178357557,
    rv_a44_curr_add_naprop = NULL                                  => -0.00117291126623993,
                                                                      -0.00117291126623993);

final_score_tree_109_c819 := map(
    NULL < rv_l79_adls_per_addr_curr AND rv_l79_adls_per_addr_curr < 4.5 => -0.0130872508139644,
    rv_l79_adls_per_addr_curr >= 4.5                                     => 0.112483014804486,
    rv_l79_adls_per_addr_curr = NULL                                     => 0.00135888593860069,
                                                                            0.00135888593860069);

final_score_tree_109_c820 := map(
    (iv_d34_liens_unrel_x_rel in ['0-1', '1-0', '2-0', '3-0'])                             => -0.0246773480018323,
    (iv_d34_liens_unrel_x_rel in ['0-0', '0-2', '1-1', '1-2', '2-1', '2-2', '3-1', '3-2']) => 0.0709078809955237,
    iv_d34_liens_unrel_x_rel = ''                                                        => 0.0502577169568151,
                                                                                              0.0502577169568151);

final_score_tree_109_c818 := map(
    NULL < rv_c14_addrs_5yr AND rv_c14_addrs_5yr < 1.5 => final_score_tree_109_c819,
    rv_c14_addrs_5yr >= 1.5                            => final_score_tree_109_c820,
    rv_c14_addrs_5yr = NULL                            => 0.0267646561359893,
                                                          0.0267646561359893);

final_score_tree_109 := map(
    NULL < rv_i60_inq_banking_count12 AND rv_i60_inq_banking_count12 < 0.5 => final_score_tree_109_c817,
    rv_i60_inq_banking_count12 >= 0.5                                      => final_score_tree_109_c818,
    rv_i60_inq_banking_count12 = NULL                                      => 0.00322010430119138,
                                                                              -0.000652895003000929);

final_score_tree_110_c825 := map(
    (rv_6seg_riskview_5_0 in ['1 VER/VAL PROBLEMS', '3 ADDR NOT CURRENT - OTHER'])                                                                                         => 0.000249885553845423,
    (rv_6seg_riskview_5_0 in ['0 TRUEDID = 0', '2 ADDR NOT CURRENT - DEROG', '4 SUFFICIENTLY VERD - DEROG', '5 SUFFICIENTLY VERD - OWNER', '6 SUFFICIENTLY VERD - OTHER']) => 0.0439845101381817,
    rv_6seg_riskview_5_0 = ''                                                                                                                                            => 0.0309549661967356,
                                                                                                                                                                              0.0309549661967356);

final_score_tree_110_c824 := map(
    NULL < iv_bureau_emergence_age AND iv_bureau_emergence_age < 27.5 => 0.00916938251752525,
    iv_bureau_emergence_age >= 27.5                                   => final_score_tree_110_c825,
    iv_bureau_emergence_age = NULL                                    => 0.0172001653876783,
                                                                         0.0172001653876783);

final_score_tree_110_c823 := map(
    NULL < rv_comb_age => final_score_tree_110_c824,
    rv_comb_age = NULL => 0.0128535639458558,
                          0.0128535639458558);

final_score_tree_110_c822 := map(
    NULL < iv_mos_src_voter_adl_lseen AND iv_mos_src_voter_adl_lseen < 57.5 => -0.00118004112501584,
    iv_mos_src_voter_adl_lseen >= 57.5                                      => final_score_tree_110_c823,
    iv_mos_src_voter_adl_lseen = NULL                                       => 0.00199079145016711,
                                                                               -0.000106004131628582);

final_score_tree_110 := map(
    NULL < rv_l80_inp_avm_autoval AND rv_l80_inp_avm_autoval < 342874 => final_score_tree_110_c822,
    rv_l80_inp_avm_autoval >= 342874                                  => -0.00934349381576946,
    rv_l80_inp_avm_autoval = NULL                                     => -0.000714206228639273,
                                                                         -0.000714206228639273);

final_score_tree_111_c829 := map(
    NULL < iv_prv_addr_lres AND iv_prv_addr_lres < 3.5 => -0.0103192797625406,
    iv_prv_addr_lres >= 3.5                            => 0.0108744478498285,
    iv_prv_addr_lres = NULL                            => -0.0487642287108473,
                                                          0.0067964720064154);

final_score_tree_111_c828 := map(
    NULL < rv_c22_inp_addr_occ_index AND rv_c22_inp_addr_occ_index < 3.5 => -0.000199908234753684,
    rv_c22_inp_addr_occ_index >= 3.5                                     => final_score_tree_111_c829,
    rv_c22_inp_addr_occ_index = NULL                                     => 0.000829965918944057,
                                                                            0.000829965918944057);

final_score_tree_111_c827 := map(
    NULL < rv_c13_curr_addr_lres AND rv_c13_curr_addr_lres < 571.5 => final_score_tree_111_c828,
    rv_c13_curr_addr_lres >= 571.5                                 => 0.0338004128996969,
    rv_c13_curr_addr_lres = NULL                                   => 0.000963553155066202,
                                                                      0.000963553155066202);

final_score_tree_111_c830 := map(
    NULL < iv_prv_addr_avm_auto_val AND iv_prv_addr_avm_auto_val < 167074.5 => 0.0153146985019565,
    iv_prv_addr_avm_auto_val >= 167074.5                                    => 0.107368061456527,
    iv_prv_addr_avm_auto_val = NULL                                         => 0.0337032162522076,
                                                                               0.0337032162522076);

final_score_tree_111 := map(
    NULL < rv_c20_m_bureau_adl_fs AND rv_c20_m_bureau_adl_fs < 454.5 => final_score_tree_111_c827,
    rv_c20_m_bureau_adl_fs >= 454.5                                  => final_score_tree_111_c830,
    rv_c20_m_bureau_adl_fs = NULL                                    => 0.00865325508395602,
                                                                        0.00145693372591806);

final_score_tree_112_c833 := map(
    NULL < rv_i62_inq_dobs_per_adl AND rv_i62_inq_dobs_per_adl < 0.5 => -0.011104831987576,
    rv_i62_inq_dobs_per_adl >= 0.5                                   => -0.0460636923637153,
    rv_i62_inq_dobs_per_adl = NULL                                   => -0.0174890476603561,
                                                                        -0.0174890476603561);

final_score_tree_112_c832 := map(
    NULL < rv_c13_inp_addr_lres AND rv_c13_inp_addr_lres < 0.5 => 0.0041357137924124,
    rv_c13_inp_addr_lres >= 0.5                                => final_score_tree_112_c833,
    rv_c13_inp_addr_lres = NULL                                => 0.0241605623529455,
                                                                  -0.00923535363644429);

final_score_tree_112_c835 := map(
    NULL < iv_full_name_non_phn_src_ct AND iv_full_name_non_phn_src_ct < 1.5 => 0.0212781572662819,
    iv_full_name_non_phn_src_ct >= 1.5                                       => 0.00272475088436383,
    iv_full_name_non_phn_src_ct = NULL                                       => 0.0036895471075976,
                                                                                0.0036895471075976);

final_score_tree_112_c834 := map(
    NULL < iv_input_best_name_match AND iv_input_best_name_match < 2.5 => -0.00901967247629059,
    iv_input_best_name_match >= 2.5                                    => final_score_tree_112_c835,
    iv_input_best_name_match = NULL                                    => 0.00247164029806055,
                                                                          0.00222738278813296);

final_score_tree_112 := map(
    NULL < rv_l79_adls_per_addr_curr AND rv_l79_adls_per_addr_curr < 0.5 => final_score_tree_112_c832,
    rv_l79_adls_per_addr_curr >= 0.5                                     => final_score_tree_112_c834,
    rv_l79_adls_per_addr_curr = NULL                                     => 0.000617132995350456,
                                                                            0.000617132995350456);

final_score_tree_113_c837 := map(
    NULL < rv_c12_num_nonderogs AND rv_c12_num_nonderogs < 3.5 => -0.00443721221644843,
    rv_c12_num_nonderogs >= 3.5                                => 0.142958368479067,
    rv_c12_num_nonderogs = NULL                                => 0.0306569736634361,
                                                                  0.0306569736634361);

final_score_tree_113_c839 := map(
    NULL < rv_c13_curr_addr_lres AND rv_c13_curr_addr_lres < 463.5 => 0.00084213034966888,
    rv_c13_curr_addr_lres >= 463.5                                 => -0.0372967243577376,
    rv_c13_curr_addr_lres = NULL                                   => -0.00367150440918309,
                                                                      0.000244244046561205);

final_score_tree_113_c840 := map(
    NULL < iv_addr_non_phn_src_ct AND iv_addr_non_phn_src_ct < 1.5 => -0.0197700501393808,
    iv_addr_non_phn_src_ct >= 1.5                                  => 0.00734512058777136,
    iv_addr_non_phn_src_ct = NULL                                  => -0.019762734146339,
                                                                      -0.00574433794282662);

final_score_tree_113_c838 := map(
    NULL < rv_l80_inp_avm_autoval AND rv_l80_inp_avm_autoval < 299520.5 => final_score_tree_113_c839,
    rv_l80_inp_avm_autoval >= 299520.5                                  => final_score_tree_113_c840,
    rv_l80_inp_avm_autoval = NULL                                       => -0.00025509587989188,
                                                                           -0.00025509587989188);

final_score_tree_113 := map(
    NULL < iv_prop2_purch_sale_diff AND iv_prop2_purch_sale_diff < 145050 => -0.0391185310796884,
    iv_prop2_purch_sale_diff >= 145050                                    => final_score_tree_113_c837,
    iv_prop2_purch_sale_diff = NULL                                       => final_score_tree_113_c838,
                                                                             -0.000500794682179731);

final_score_tree_114_c843 := map(
    NULL < iv_best_ssn_prior_dob AND iv_best_ssn_prior_dob < 0.5 => -0.00165581468975335,
    iv_best_ssn_prior_dob >= 0.5                                 => 0.0789975309335813,
    iv_best_ssn_prior_dob = NULL                                 => 0.0080601414782122,
                                                                    -0.000531603245406651);

final_score_tree_114_c844 := map(
    NULL < rv_l79_adls_per_addr_curr AND rv_l79_adls_per_addr_curr < 1.5 => -0.00618967414501806,
    rv_l79_adls_per_addr_curr >= 1.5                                     => 0.0710859860988904,
    rv_l79_adls_per_addr_curr = NULL                                     => 0.0330815630281157,
                                                                            0.0330815630281157);

final_score_tree_114_c842 := map(
    NULL < iv_unverified_addr_count AND iv_unverified_addr_count < 15.5 => final_score_tree_114_c843,
    iv_unverified_addr_count >= 15.5                                    => final_score_tree_114_c844,
    iv_unverified_addr_count = NULL                                     => -0.0052142724673989,
                                                                           -0.000461248717990057);

final_score_tree_114_c845 := map(
    NULL < rv_mos_since_br_first_seen AND rv_mos_since_br_first_seen < 72.5 => 0.0397109660844848,
    rv_mos_since_br_first_seen >= 72.5                                      => -0.092726734492313,
    rv_mos_since_br_first_seen = NULL                                       => 0.024670106284465,
                                                                               0.024670106284465);

final_score_tree_114 := map(
    NULL < rv_l80_inp_avm_autoval AND rv_l80_inp_avm_autoval < 771328 => final_score_tree_114_c842,
    rv_l80_inp_avm_autoval >= 771328                                  => final_score_tree_114_c845,
    rv_l80_inp_avm_autoval = NULL                                     => -0.000222698141638058,
                                                                         -0.000222698141638058);

final_score_tree_115_c848 := map(
    NULL < rv_c13_curr_addr_lres AND rv_c13_curr_addr_lres < 702.5 => 0.000381304843723522,
    rv_c13_curr_addr_lres >= 702.5                                 => -0.0831320941882606,
    rv_c13_curr_addr_lres = NULL                                   => 0.000316011877966107,
                                                                      0.000316011877966107);

final_score_tree_115_c847 := map(
    (rv_e58_br_dead_bus_x_active_phn in ['0-1', '1-2', '2-0', '2-3', '3-0', '3-1', '3-3'])               => -0.0218027232837043,
    (rv_e58_br_dead_bus_x_active_phn in ['0-0', '0-2', '0-3', '1-0', '1-1', '1-3', '2-1', '2-2', '3-2']) => final_score_tree_115_c848,
    rv_e58_br_dead_bus_x_active_phn = ''                                                               => -0.0121854496312791,
                                                                                                            -0.000406835046897668);

final_score_tree_115_c850 := map(
    NULL < rv_a49_curr_add_avm_chg_3yr AND rv_a49_curr_add_avm_chg_3yr < 58289 => 0.145861380037726,
    rv_a49_curr_add_avm_chg_3yr >= 58289                                       => 0.026535394389476,
    rv_a49_curr_add_avm_chg_3yr = NULL                                         => 0.0115777619923637,
                                                                                  0.0412234526298281);

final_score_tree_115_c849 := map(
    NULL < iv_c13_avg_lres AND iv_c13_avg_lres < 162.5 => 0.000933195047376884,
    iv_c13_avg_lres >= 162.5                           => final_score_tree_115_c850,
    iv_c13_avg_lres = NULL                             => 0.012290430317846,
                                                          0.012290430317846);

final_score_tree_115 := map(
    NULL < rv_l80_inp_avm_autoval AND rv_l80_inp_avm_autoval < 479126.5 => final_score_tree_115_c847,
    rv_l80_inp_avm_autoval >= 479126.5                                  => final_score_tree_115_c849,
    rv_l80_inp_avm_autoval = NULL                                       => -2.13664636307257e-05,
                                                                           -2.13664636307257e-05);

final_score_tree_116_c854 := map(
    NULL < iv_src_voter_adl_count AND iv_src_voter_adl_count < -0.5 => 0.00588378197961077,
    iv_src_voter_adl_count >= -0.5                                  => 0.077095290979933,
    iv_src_voter_adl_count = NULL                                   => 0.0361667604079045,
                                                                       0.0361667604079045);

final_score_tree_116_c855 := map(
    NULL < iv_c13_avg_lres AND iv_c13_avg_lres < 45 => 0.0589421409969573,
    iv_c13_avg_lres >= 45                           => -0.0729402382940691,
    iv_c13_avg_lres = NULL                          => -0.0245833658873594,
                                                       -0.0245833658873594);

final_score_tree_116_c853 := map(
    NULL < iv_full_name_non_phn_src_ct AND iv_full_name_non_phn_src_ct < 5.5 => final_score_tree_116_c854,
    iv_full_name_non_phn_src_ct >= 5.5                                       => final_score_tree_116_c855,
    iv_full_name_non_phn_src_ct = NULL                                       => 0.023583305018782,
                                                                                0.023583305018782);

final_score_tree_116_c852 := map(
    NULL < rv_d31_bk_dism_hist_count AND rv_d31_bk_dism_hist_count < 0.5 => -0.00160708856577575,
    rv_d31_bk_dism_hist_count >= 0.5                                     => final_score_tree_116_c853,
    rv_d31_bk_dism_hist_count = NULL                                     => 0.00156840438553602,
                                                                            -0.00125397209611264);

final_score_tree_116 := map(
    NULL < rv_l80_inp_avm_autoval AND rv_l80_inp_avm_autoval < 1272880.5 => final_score_tree_116_c852,
    rv_l80_inp_avm_autoval >= 1272880.5                                  => 0.0504600482126901,
    rv_l80_inp_avm_autoval = NULL                                        => -0.00112965271655826,
                                                                            -0.00112965271655826);

final_score_tree_117_c860 := map(
    NULL < iv_unverified_addr_count AND iv_unverified_addr_count < 5.5 => 0.0112867638954572,
    iv_unverified_addr_count >= 5.5                                    => 0.0592199696215662,
    iv_unverified_addr_count = NULL                                    => 0.0219524209271542,
                                                                          0.0219524209271542);

final_score_tree_117_c859 := map(
    NULL < rv_i60_inq_recency AND rv_i60_inq_recency < 2 => 0.000329635561437849,
    rv_i60_inq_recency >= 2                              => final_score_tree_117_c860,
    rv_i60_inq_recency = NULL                            => 0.00166716325517191,
                                                            0.00166716325517191);

final_score_tree_117_c858 := map(
    (iv_d34_liens_unrel_x_rel in ['0-1', '0-2', '2-2', '3-2'])                             => -0.0809229661330876,
    (iv_d34_liens_unrel_x_rel in ['0-0', '1-0', '1-1', '1-2', '2-0', '2-1', '3-0', '3-1']) => final_score_tree_117_c859,
    iv_d34_liens_unrel_x_rel = ''                                                        => 0.00117034746486723,
                                                                                              0.00117034746486723);

final_score_tree_117_c857 := map(
    NULL < rv_a49_curr_avm_chg_1yr_pct AND rv_a49_curr_avm_chg_1yr_pct < 124.15 => 0.010958251194814,
    rv_a49_curr_avm_chg_1yr_pct >= 124.15                                       => -0.0134858105938421,
    rv_a49_curr_avm_chg_1yr_pct = NULL                                          => final_score_tree_117_c858,
                                                                                   0.00354451268070283);

final_score_tree_117 := map(
    NULL < iv_bureau_emergence_age AND iv_bureau_emergence_age < 28.5 => -0.00355247884141444,
    iv_bureau_emergence_age >= 28.5                                   => final_score_tree_117_c857,
    iv_bureau_emergence_age = NULL                                    => -0.000390538984651124,
                                                                         -0.000360131599575667);

final_score_tree_118_c864 := map(
    NULL < rv_c14_addrs_15yr AND rv_c14_addrs_15yr < 2.5 => 0.00918866961044362,
    rv_c14_addrs_15yr >= 2.5                             => 0.0408927602378091,
    rv_c14_addrs_15yr = NULL                             => 0.0229233518375349,
                                                            0.0229233518375349);

final_score_tree_118_c863 := map(
    NULL < rv_comb_age AND rv_comb_age < 53.5 => -0.00771144539504092,
    rv_comb_age >= 53.5                       => final_score_tree_118_c864,
    rv_comb_age = NULL                        => 0.0123283937248733,
                                                 0.0123283937248733);

final_score_tree_118_c862 := map(
    NULL < rv_c18_invalid_addrs_per_adl AND rv_c18_invalid_addrs_per_adl < 4.5 => -0.000898793432921202,
    rv_c18_invalid_addrs_per_adl >= 4.5                                        => final_score_tree_118_c863,
    rv_c18_invalid_addrs_per_adl = NULL                                        => -0.00168546364787693,
                                                                                  -0.00035011403415157);

final_score_tree_118_c865 := map(
    (rv_6seg_riskview_5_0 in ['0 TRUEDID = 0', '2 ADDR NOT CURRENT - DEROG', '4 SUFFICIENTLY VERD - DEROG', '6 SUFFICIENTLY VERD - OTHER']) => -0.0407036649061859,
    (rv_6seg_riskview_5_0 in ['1 VER/VAL PROBLEMS', '3 ADDR NOT CURRENT - OTHER', '5 SUFFICIENTLY VERD - OWNER'])                           => 0.0233387479974429,
    rv_6seg_riskview_5_0 = ''                                                                                                             => 0.0115216117970537,
                                                                                                                                               0.0115216117970537);

final_score_tree_118 := map(
    NULL < rv_l80_inp_avm_autoval AND rv_l80_inp_avm_autoval < 525044.5 => final_score_tree_118_c862,
    rv_l80_inp_avm_autoval >= 525044.5                                  => final_score_tree_118_c865,
    rv_l80_inp_avm_autoval = NULL                                       => -5.93506011780526e-05,
                                                                           -5.93506011780526e-05);

final_score_tree_119_c868 := map(
    NULL < iv_estimated_income AND iv_estimated_income < 26500 => 0.0355963158924825,
    iv_estimated_income >= 26500                               => 0.00650673210195918,
    iv_estimated_income = NULL                                 => 0.015793524029565,
                                                                  0.015793524029565);

final_score_tree_119_c870 := map(
    NULL < rv_f03_input_add_not_most_rec AND rv_f03_input_add_not_most_rec < 0.5 => -0.0608440069331443,
    rv_f03_input_add_not_most_rec >= 0.5                                         => -0.00734831862866048,
    rv_f03_input_add_not_most_rec = NULL                                         => -0.0151314168094305,
                                                                                    -0.0151314168094305);

final_score_tree_119_c869 := map(
    NULL < rv_f03_address_match AND rv_f03_address_match < 3 => final_score_tree_119_c870,
    rv_f03_address_match >= 3                                => 0.00643117126722982,
    rv_f03_address_match = NULL                              => 0.000757781799080165,
                                                                0.000757781799080165);

final_score_tree_119_c867 := map(
    NULL < rv_c12_inp_addr_source_count AND rv_c12_inp_addr_source_count < 0.5 => final_score_tree_119_c868,
    rv_c12_inp_addr_source_count >= 0.5                                        => final_score_tree_119_c869,
    rv_c12_inp_addr_source_count = NULL                                        => 0.00325763077830051,
                                                                                  0.00325763077830051);

final_score_tree_119 := map(
    NULL < iv_c14_addrs_per_adl AND iv_c14_addrs_per_adl < 4.5 => -0.00292239958516445,
    iv_c14_addrs_per_adl >= 4.5                                => final_score_tree_119_c867,
    iv_c14_addrs_per_adl = NULL                                => -0.000885015232565108,
                                                                  6.97835333945958e-05);

final_score_tree_120_c874 := map(
    NULL < iv_full_name_non_phn_src_ct AND iv_full_name_non_phn_src_ct < 2.5 => 0.00102149808729181,
    iv_full_name_non_phn_src_ct >= 2.5                                       => -0.0159437743196052,
    iv_full_name_non_phn_src_ct = NULL                                       => -0.00931762461818338,
                                                                                -0.00931762461818338);

final_score_tree_120_c873 := map(
    NULL < rv_c22_inp_addr_occ_index AND rv_c22_inp_addr_occ_index < 3.5 => final_score_tree_120_c874,
    rv_c22_inp_addr_occ_index >= 3.5                                     => 0.00430129873540176,
    rv_c22_inp_addr_occ_index = NULL                                     => -0.0067083164056421,
                                                                            -0.0067083164056421);

final_score_tree_120_c872 := map(
    (iv_curr_add_financing_type in ['CNV', 'NONE', 'OTH']) => final_score_tree_120_c873,
    (iv_curr_add_financing_type in ['ADJ'])                => 0.089617474795262,
    iv_curr_add_financing_type = ''                      => -0.00648502265240075,
                                                              -0.00648502265240075);

final_score_tree_120_c875 := map(
    NULL < iv_estimated_income AND iv_estimated_income < 22500 => -0.0178362688074831,
    iv_estimated_income >= 22500                               => 0.00277126196708155,
    iv_estimated_income = NULL                                 => 0.0015471779675298,
                                                                  0.0015471779675298);

final_score_tree_120 := map(
    NULL < iv_c13_avg_lres AND iv_c13_avg_lres < 54.5 => final_score_tree_120_c872,
    iv_c13_avg_lres >= 54.5                           => final_score_tree_120_c875,
    iv_c13_avg_lres = NULL                            => 0.00340676851621177,
                                                         -0.00113678640918228);

final_score_tree_121_c877 := map(
    NULL < rv_l79_adls_per_apt_addr_c6 AND rv_l79_adls_per_apt_addr_c6 < 1.5 => 8.31200362762065e-05,
    rv_l79_adls_per_apt_addr_c6 >= 1.5                                       => -0.0265676352278587,
    rv_l79_adls_per_apt_addr_c6 = NULL                                       => -0.000343787911991496,
                                                                                -0.000343787911991496);

final_score_tree_121_c880 := map(
    NULL < rv_d30_derog_count AND rv_d30_derog_count < 2.5 => -0.0202589439449671,
    rv_d30_derog_count >= 2.5                              => 0.0677074113097959,
    rv_d30_derog_count = NULL                              => -0.0134107754172561,
                                                              -0.0134107754172561);

final_score_tree_121_c879 := map(
    NULL < rv_c13_curr_addr_lres AND rv_c13_curr_addr_lres < 18.5 => final_score_tree_121_c880,
    rv_c13_curr_addr_lres >= 18.5                                 => 0.0164309530090084,
    rv_c13_curr_addr_lres = NULL                                  => 0.0082021707519321,
                                                                     0.0082021707519321);

final_score_tree_121_c878 := map(
    NULL < rv_c12_source_profile AND rv_c12_source_profile < 89.45 => final_score_tree_121_c879,
    rv_c12_source_profile >= 89.45                                 => -0.120974404728471,
    rv_c12_source_profile = NULL                                   => 0.00657321015318805,
                                                                      0.00657321015318805);

final_score_tree_121 := map(
    (iv_l77_dwelltype in ['MFD', 'SFD']) => final_score_tree_121_c877,
    (iv_l77_dwelltype in ['POB', 'RR'])  => final_score_tree_121_c878,
    iv_l77_dwelltype = ''              => 3.66522074191948e-05,
                                            3.66522074191948e-05);

final_score_tree_122_c883 := map(
    NULL < rv_c22_inp_addr_owned_not_occ AND rv_c22_inp_addr_owned_not_occ < 0.5 => 0.0192533436682421,
    rv_c22_inp_addr_owned_not_occ >= 0.5                                         => 0.129407269773681,
    rv_c22_inp_addr_owned_not_occ = NULL                                         => 0.0238030189237723,
                                                                                    0.0238030189237723);

final_score_tree_122_c882 := map(
    NULL < rv_c13_inp_addr_lres AND rv_c13_inp_addr_lres < 3.5 => final_score_tree_122_c883,
    rv_c13_inp_addr_lres >= 3.5                                => -0.0110452715035995,
    rv_c13_inp_addr_lres = NULL                                => 0.0130276138809315,
                                                                  0.0130276138809315);

final_score_tree_122_c885 := map(
    NULL < iv_prv_addr_lres AND iv_prv_addr_lres < 8.5 => 0.0939020285654772,
    iv_prv_addr_lres >= 8.5                            => -0.0343108136418593,
    iv_prv_addr_lres = NULL                            => -0.018769863071273,
                                                          -0.018769863071273);

final_score_tree_122_c884 := map(
    NULL < iv_lname_non_phn_src_ct AND iv_lname_non_phn_src_ct < 6.5 => -0.000190551428867584,
    iv_lname_non_phn_src_ct >= 6.5                                   => final_score_tree_122_c885,
    iv_lname_non_phn_src_ct = NULL                                   => -0.000373904433871659,
                                                                        -0.000373904433871659);

final_score_tree_122 := map(
    NULL < rv_c13_attr_addrs_recency AND rv_c13_attr_addrs_recency < 7.5 => final_score_tree_122_c882,
    rv_c13_attr_addrs_recency >= 7.5                                     => final_score_tree_122_c884,
    rv_c13_attr_addrs_recency = NULL                                     => 0.0066365543539555,
                                                                            0.000525692563195925);

final_score_tree_123_c888 := map(
    NULL < rv_c14_addrs_15yr AND rv_c14_addrs_15yr < 1.5 => -0.00412428799728604,
    rv_c14_addrs_15yr >= 1.5                             => 0.0111936683708694,
    rv_c14_addrs_15yr = NULL                             => 0.00451398637322226,
                                                            0.00451398637322226);

final_score_tree_123_c887 := map(
    NULL < rv_c12_source_profile AND rv_c12_source_profile < 71.35 => -0.00392803639728069,
    rv_c12_source_profile >= 71.35                                 => final_score_tree_123_c888,
    rv_c12_source_profile = NULL                                   => -0.0182119753332515,
                                                                      0.000297369787257325);

final_score_tree_123_c890 := map(
    NULL < iv_lname_non_phn_src_ct AND iv_lname_non_phn_src_ct < 1.5 => 0.00316200413473232,
    iv_lname_non_phn_src_ct >= 1.5                                   => -0.00481134033426752,
    iv_lname_non_phn_src_ct = NULL                                   => -0.00427108709518804,
                                                                        -0.00427108709518804);

final_score_tree_123_c889 := map(
    NULL < rv_d32_mos_since_crim_ls AND rv_d32_mos_since_crim_ls < 37.5 => final_score_tree_123_c890,
    rv_d32_mos_since_crim_ls >= 37.5                                    => 0.054936694754203,
    rv_d32_mos_since_crim_ls = NULL                                     => -0.00960592977125842,
                                                                           -0.00377546913799122);

final_score_tree_123 := map(
    NULL < rv_l80_inp_avm_autoval AND rv_l80_inp_avm_autoval < 44733 => final_score_tree_123_c887,
    rv_l80_inp_avm_autoval >= 44733                                  => final_score_tree_123_c889,
    rv_l80_inp_avm_autoval = NULL                                    => -0.00134604368569143,
                                                                        -0.00134604368569143);

final_score_tree_124_c893 := map(
    NULL < iv_lname_non_phn_src_ct AND iv_lname_non_phn_src_ct < 5.5 => -0.00606956003341605,
    iv_lname_non_phn_src_ct >= 5.5                                   => 0.00719333163767524,
    iv_lname_non_phn_src_ct = NULL                                   => -0.00543606000258621,
                                                                        -0.00543606000258621);

final_score_tree_124_c894 := map(
    NULL < rv_a49_curr_add_avm_pct_chg_2yr AND rv_a49_curr_add_avm_pct_chg_2yr < 1.495 => 0.0153722904043195,
    rv_a49_curr_add_avm_pct_chg_2yr >= 1.495                                           => 0.120558300420636,
    rv_a49_curr_add_avm_pct_chg_2yr = NULL                                             => 0.0271419300227336,
                                                                                          0.0271419300227336);

final_score_tree_124_c892 := map(
    NULL < iv_mos_src_voter_adl_lseen AND iv_mos_src_voter_adl_lseen < 62 => final_score_tree_124_c893,
    iv_mos_src_voter_adl_lseen >= 62                                      => final_score_tree_124_c894,
    iv_mos_src_voter_adl_lseen = NULL                                     => -0.00371148576464575,
                                                                             -0.00371148576464575);

final_score_tree_124_c895 := map(
    NULL < rv_c10_m_hdr_fs AND rv_c10_m_hdr_fs < 252 => 0.193593157331638,
    rv_c10_m_hdr_fs >= 252                           => 0.00770053379205078,
    rv_c10_m_hdr_fs = NULL                           => 0.0569323701632658,
                                                        0.0569323701632658);

final_score_tree_124 := map(
    NULL < rv_a49_curr_add_avm_pct_chg_2yr AND rv_a49_curr_add_avm_pct_chg_2yr < 3.325 => final_score_tree_124_c892,
    rv_a49_curr_add_avm_pct_chg_2yr >= 3.325                                           => final_score_tree_124_c895,
    rv_a49_curr_add_avm_pct_chg_2yr = NULL                                             => 0.00232824838912889,
                                                                                          0.000488995660562073);

final_score_tree_125_c899 := map(
    NULL < iv_prv_addr_lres AND iv_prv_addr_lres < 213.5 => 0.0103942967893021,
    iv_prv_addr_lres >= 213.5                            => -0.019531066354106,
    iv_prv_addr_lres = NULL                              => -0.0659738959009827,
                                                            0.00531098635832836);

final_score_tree_125_c898 := map(
    NULL < rv_c22_inp_addr_occ_index AND rv_c22_inp_addr_occ_index < 3.5 => -0.0120385987429011,
    rv_c22_inp_addr_occ_index >= 3.5                                     => final_score_tree_125_c899,
    rv_c22_inp_addr_occ_index = NULL                                     => -0.00711152393363643,
                                                                            -0.00711152393363643);

final_score_tree_125_c897 := map(
    NULL < rv_c22_inp_addr_occ_index AND rv_c22_inp_addr_occ_index < 2 => 0.00303851120377245,
    rv_c22_inp_addr_occ_index >= 2                                     => final_score_tree_125_c898,
    rv_c22_inp_addr_occ_index = NULL                                   => -0.00545550401017894,
                                                                          -0.000452919786901791);

final_score_tree_125_c900 := map(
    NULL < rv_l79_adls_per_addr_curr AND rv_l79_adls_per_addr_curr < 0.5 => -0.0164437409436153,
    rv_l79_adls_per_addr_curr >= 0.5                                     => 0.0196255181269332,
    rv_l79_adls_per_addr_curr = NULL                                     => 0.00602714082248728,
                                                                            0.00602714082248728);

final_score_tree_125 := map(
    (iv_l77_dwelltype in ['MFD', 'SFD']) => final_score_tree_125_c897,
    (iv_l77_dwelltype in ['POB', 'RR'])  => final_score_tree_125_c900,
    iv_l77_dwelltype = ''              => -0.000103707223428065,
                                            -0.000103707223428065);

final_score_tree_126_c903 := map(
    NULL < rv_c12_source_profile AND rv_c12_source_profile < 84.55 => -0.0185205414785499,
    rv_c12_source_profile >= 84.55                                 => 0.0491788594933916,
    rv_c12_source_profile = NULL                                   => -0.0133465043798111,
                                                                      -0.0133465043798111);

final_score_tree_126_c902 := map(
    NULL < iv_prop1_purch_sale_diff AND iv_prop1_purch_sale_diff < -73822.5 => 0.0431365560806185,
    iv_prop1_purch_sale_diff >= -73822.5                                    => final_score_tree_126_c903,
    iv_prop1_purch_sale_diff = NULL                                         => -0.00042423549397515,
                                                                               -0.000838765004276354);

final_score_tree_126_c905 := map(
    NULL < iv_unverified_addr_count AND iv_unverified_addr_count < 8.5 => -0.0100418420891727,
    iv_unverified_addr_count >= 8.5                                    => 0.0920248688436887,
    iv_unverified_addr_count = NULL                                    => 0.0133516500502924,
                                                                          -0.00351791181272946);

final_score_tree_126_c904 := map(
    NULL < rv_a49_curr_avm_chg_1yr AND rv_a49_curr_avm_chg_1yr < 50102 => 0.0181313619942494,
    rv_a49_curr_avm_chg_1yr >= 50102                                   => -0.0122615131168316,
    rv_a49_curr_avm_chg_1yr = NULL                                     => final_score_tree_126_c905,
                                                                          0.00629057638874793);

final_score_tree_126 := map(
    NULL < rv_l80_inp_avm_autoval AND rv_l80_inp_avm_autoval < 269114 => final_score_tree_126_c902,
    rv_l80_inp_avm_autoval >= 269114                                  => final_score_tree_126_c904,
    rv_l80_inp_avm_autoval = NULL                                     => -0.000114059293839534,
                                                                         -0.000114059293839534);

final_score_tree_127_c907 := map(
    NULL < rv_a46_curr_avm_autoval AND rv_a46_curr_avm_autoval < 111476.5 => 0.164810441575727,
    rv_a46_curr_avm_autoval >= 111476.5                                   => -0.00630220653685626,
    rv_a46_curr_avm_autoval = NULL                                        => 0.0751800068500883,
                                                                             0.0751800068500883);

final_score_tree_127_c909 := map(
    NULL < rv_l70_inp_addr_dirty AND rv_l70_inp_addr_dirty < 0.5 => -0.00123389598649087,
    rv_l70_inp_addr_dirty >= 0.5                                 => -0.0676865268261474,
    rv_l70_inp_addr_dirty = NULL                                 => -0.00132269814800135,
                                                                    -0.00132269814800135);

final_score_tree_127_c910 := map(
    NULL < rv_c13_max_lres AND rv_c13_max_lres < 48.5 => -0.0367987767475404,
    rv_c13_max_lres >= 48.5                           => 0.066657531193555,
    rv_c13_max_lres = NULL                            => 0.0431447339342151,
                                                         0.0431447339342151);

final_score_tree_127_c908 := map(
    NULL < iv_unverified_addr_count AND iv_unverified_addr_count < 15.5 => final_score_tree_127_c909,
    iv_unverified_addr_count >= 15.5                                    => final_score_tree_127_c910,
    iv_unverified_addr_count = NULL                                     => -0.00827769592554178,
                                                                           -0.00124785902395403);

final_score_tree_127 := map(
    NULL < iv_prop1_purch_sale_diff AND iv_prop1_purch_sale_diff < -208600 => final_score_tree_127_c907,
    iv_prop1_purch_sale_diff >= -208600                                    => -0.00612667782731406,
    iv_prop1_purch_sale_diff = NULL                                        => final_score_tree_127_c908,
                                                                              -0.0014034776645979);

final_score_tree_128_c915 := map(
    NULL < rv_l79_adls_per_sfd_addr AND rv_l79_adls_per_sfd_addr < -0.5 => 0.168239993881681,
    rv_l79_adls_per_sfd_addr >= -0.5                                    => -0.0169828317978218,
    rv_l79_adls_per_sfd_addr = NULL                                     => 0.0723979503614731,
                                                                           0.0723979503614731);

final_score_tree_128_c914 := map(
    NULL < rv_l70_add_standardized AND rv_l70_add_standardized < 0.5 => -0.00205689200766243,
    rv_l70_add_standardized >= 0.5                                   => final_score_tree_128_c915,
    rv_l70_add_standardized = NULL                                   => -0.00164150981864227,
                                                                        -0.00164150981864227);

final_score_tree_128_c913 := map(
    NULL < rv_c13_curr_addr_lres AND rv_c13_curr_addr_lres < 130.5 => final_score_tree_128_c914,
    rv_c13_curr_addr_lres >= 130.5                                 => 0.0052301591088913,
    rv_c13_curr_addr_lres = NULL                                   => 0.000474641520710641,
                                                                      0.000474641520710641);

final_score_tree_128_c912 := map(
    NULL < iv_lname_non_phn_src_ct AND iv_lname_non_phn_src_ct < 5.5 => final_score_tree_128_c913,
    iv_lname_non_phn_src_ct >= 5.5                                   => -0.0242148469227365,
    iv_lname_non_phn_src_ct = NULL                                   => -0.00950605716915028,
                                                                        -0.000693237745361408);

final_score_tree_128 := map(
    NULL < rv_l80_inp_avm_autoval AND rv_l80_inp_avm_autoval < 71864.5 => final_score_tree_128_c912,
    rv_l80_inp_avm_autoval >= 71864.5                                  => 0.00261166160820282,
    rv_l80_inp_avm_autoval = NULL                                      => 0.000470561517363966,
                                                                          0.000470561517363966);

final_score_tree_129_c919 := map(
    NULL < rv_comb_age AND rv_comb_age < 59.5 => 0.0217597315715381,
    rv_comb_age >= 59.5                       => 0.104014913694255,
    rv_comb_age = NULL                        => 0.0304717659916883,
                                                 0.0304717659916883);

final_score_tree_129_c918 := map(
    NULL < iv_c14_addrs_per_adl AND iv_c14_addrs_per_adl < 11.5 => -0.00106654992118901,
    iv_c14_addrs_per_adl >= 11.5                                => final_score_tree_129_c919,
    iv_c14_addrs_per_adl = NULL                                 => 0.000372408009566714,
                                                                   0.000372408009566714);

final_score_tree_129_c920 := map(
    NULL < rv_c10_m_hdr_fs AND rv_c10_m_hdr_fs < 362.5 => -0.00766503160378341,
    rv_c10_m_hdr_fs >= 362.5                           => 0.00392805282668235,
    rv_c10_m_hdr_fs = NULL                             => -0.00343933204436164,
                                                          -0.00343933204436164);

final_score_tree_129_c917 := map(
    NULL < iv_lname_non_phn_src_ct AND iv_lname_non_phn_src_ct < 2.5 => final_score_tree_129_c918,
    iv_lname_non_phn_src_ct >= 2.5                                   => final_score_tree_129_c920,
    iv_lname_non_phn_src_ct = NULL                                   => -0.00248946707267958,
                                                                        -0.00248946707267958);

final_score_tree_129 := map(
    NULL < iv_best_ssn_prior_dob AND iv_best_ssn_prior_dob < 0.5 => final_score_tree_129_c917,
    iv_best_ssn_prior_dob >= 0.5                                 => 0.0822587446023567,
    iv_best_ssn_prior_dob = NULL                                 => 0.00792026991703139,
                                                                    -0.00116687076178753);

final_score_tree_130_c924 := map(
    NULL < rv_a49_curr_avm_chg_1yr_pct AND rv_a49_curr_avm_chg_1yr_pct < 113.95 => 0.0242871100740165,
    rv_a49_curr_avm_chg_1yr_pct >= 113.95                                       => -0.0148428182176695,
    rv_a49_curr_avm_chg_1yr_pct = NULL                                          => 0.00484433208901463,
                                                                                   0.00670692315984046);

final_score_tree_130_c923 := map(
    NULL < iv_c14_addrs_per_adl AND iv_c14_addrs_per_adl < 8.5 => -0.00168809778366102,
    iv_c14_addrs_per_adl >= 8.5                                => final_score_tree_130_c924,
    iv_c14_addrs_per_adl = NULL                                => -0.00031554398802438,
                                                                  -0.00031554398802438);

final_score_tree_130_c925 := map(
    NULL < rv_l79_adls_per_sfd_addr AND rv_l79_adls_per_sfd_addr < 4.5 => -0.012508205041881,
    rv_l79_adls_per_sfd_addr >= 4.5                                    => 0.0970255488092034,
    rv_l79_adls_per_sfd_addr = NULL                                    => -0.00494110633023445,
                                                                          -0.00494110633023445);

final_score_tree_130_c922 := map(
    NULL < rv_d32_criminal_behavior_lvl AND rv_d32_criminal_behavior_lvl < 5.5 => final_score_tree_130_c923,
    rv_d32_criminal_behavior_lvl >= 5.5                                        => -0.0988006227748865,
    rv_d32_criminal_behavior_lvl = NULL                                        => final_score_tree_130_c925,
                                                                                  -0.000504015761268506);

final_score_tree_130 := map(
    NULL < rv_l80_inp_avm_autoval AND rv_l80_inp_avm_autoval < 861247.5 => final_score_tree_130_c922,
    rv_l80_inp_avm_autoval >= 861247.5                                  => -0.0252321405237283,
    rv_l80_inp_avm_autoval = NULL                                       => -0.000668421546936114,
                                                                           -0.000668421546936114);

final_score_tree_131_c929 := map(
    NULL < rv_f01_inp_addr_address_score AND rv_f01_inp_addr_address_score < 16 => 0.108048884788826,
    rv_f01_inp_addr_address_score >= 16                                         => 0.00164030014842891,
    rv_f01_inp_addr_address_score = NULL                                        => 0.00191461670413842,
                                                                                   0.00191461670413842);

final_score_tree_131_c928 := map(
    NULL < rv_i62_inq_addrs_per_adl AND rv_i62_inq_addrs_per_adl < 1.5 => final_score_tree_131_c929,
    rv_i62_inq_addrs_per_adl >= 1.5                                    => 0.0478156981997831,
    rv_i62_inq_addrs_per_adl = NULL                                    => 0.00235890289643726,
                                                                          0.00235890289643726);

final_score_tree_131_c930 := map(
    NULL < rv_a44_curr_add_naprop AND rv_a44_curr_add_naprop < 0.5 => 0.00387656103059463,
    rv_a44_curr_add_naprop >= 0.5                                  => -0.00941791362062703,
    rv_a44_curr_add_naprop = NULL                                  => -0.0047924235862192,
                                                                      -0.0047924235862192);

final_score_tree_131_c927 := map(
    NULL < rv_c22_inp_addr_occ_index AND rv_c22_inp_addr_occ_index < 2 => final_score_tree_131_c928,
    rv_c22_inp_addr_occ_index >= 2                                     => final_score_tree_131_c930,
    rv_c22_inp_addr_occ_index = NULL                                   => -0.000297209991498778,
                                                                          -0.000297209991498778);

final_score_tree_131 := map(
    NULL < rv_i60_inq_comm_count12 AND rv_i60_inq_comm_count12 < 2.5 => final_score_tree_131_c927,
    rv_i60_inq_comm_count12 >= 2.5                                   => 0.151706895221538,
    rv_i60_inq_comm_count12 = NULL                                   => -0.00717705058352143,
                                                                        -0.000288894969725606);

final_score_tree_132_c934 := map(
    NULL < rv_c13_curr_addr_lres AND rv_c13_curr_addr_lres < 112 => 0.122463114177773,
    rv_c13_curr_addr_lres >= 112                                 => -0.0327754382386082,
    rv_c13_curr_addr_lres = NULL                                 => 0.0505631530586071,
                                                                    0.0505631530586071);

final_score_tree_132_c935 := map(
    NULL < rv_l78_no_phone_at_addr_vel AND rv_l78_no_phone_at_addr_vel < 0.5 => -0.00645903210696496,
    rv_l78_no_phone_at_addr_vel >= 0.5                                       => 0.00987260030243009,
    rv_l78_no_phone_at_addr_vel = NULL                                       => 0.00136165684404153,
                                                                                0.00136165684404153);

final_score_tree_132_c933 := map(
    NULL < rv_a46_curr_avm_autoval AND rv_a46_curr_avm_autoval < 10495.5 => final_score_tree_132_c934,
    rv_a46_curr_avm_autoval >= 10495.5                                   => final_score_tree_132_c935,
    rv_a46_curr_avm_autoval = NULL                                       => 0.00210429143895473,
                                                                            0.00210429143895473);

final_score_tree_132_c932 := map(
    NULL < rv_l80_inp_avm_autoval AND rv_l80_inp_avm_autoval < 182557.5 => final_score_tree_132_c933,
    rv_l80_inp_avm_autoval >= 182557.5                                  => 0.0113049270743704,
    rv_l80_inp_avm_autoval = NULL                                       => 0.00531495468586318,
                                                                           0.00531495468586318);

final_score_tree_132 := map(
    NULL < rv_a49_curr_add_avm_pct_chg_2yr AND rv_a49_curr_add_avm_pct_chg_2yr < 1.345 => final_score_tree_132_c932,
    rv_a49_curr_add_avm_pct_chg_2yr >= 1.345                                           => -0.0124427839801341,
    rv_a49_curr_add_avm_pct_chg_2yr = NULL                                             => -0.000406889523574085,
                                                                                          0.000281354112252025);

final_score_tree_133_c939 := map(
    NULL < rv_mos_since_br_first_seen AND rv_mos_since_br_first_seen < 157 => -0.0175235141594206,
    rv_mos_since_br_first_seen >= 157                                      => 0.130717810998406,
    rv_mos_since_br_first_seen = NULL                                      => -0.0155253477725018,
                                                                              -0.0155253477725018);

final_score_tree_133_c938 := map(
    NULL < iv_c13_avg_lres AND iv_c13_avg_lres < 255.5 => 0.000467481136287721,
    iv_c13_avg_lres >= 255.5                           => final_score_tree_133_c939,
    iv_c13_avg_lres = NULL                             => 0.00529925039004896,
                                                          -0.000333690649785721);

final_score_tree_133_c940 := map(
    NULL < iv_unverified_addr_count AND iv_unverified_addr_count < 6.5 => -0.0197682864487758,
    iv_unverified_addr_count >= 6.5                                    => -0.0942948831202417,
    iv_unverified_addr_count = NULL                                    => -0.027537468341168,
                                                                          -0.027537468341168);

final_score_tree_133_c937 := map(
    NULL < iv_prv_addr_avm_auto_val AND iv_prv_addr_avm_auto_val < 629056 => final_score_tree_133_c938,
    iv_prv_addr_avm_auto_val >= 629056                                    => final_score_tree_133_c940,
    iv_prv_addr_avm_auto_val = NULL                                       => -0.000722599999027672,
                                                                             -0.000722599999027672);

final_score_tree_133 := map(
    NULL < rv_l80_inp_avm_autoval AND rv_l80_inp_avm_autoval < 1037425.5 => final_score_tree_133_c937,
    rv_l80_inp_avm_autoval >= 1037425.5                                  => 0.0304521421075748,
    rv_l80_inp_avm_autoval = NULL                                        => -0.000610830339286701,
                                                                            -0.000610830339286701);

final_score_tree_134_c943 := map(
    NULL < iv_prv_addr_lres AND iv_prv_addr_lres < 387.5 => 0.00259501336914625,
    iv_prv_addr_lres >= 387.5                            => 0.0541322284075831,
    iv_prv_addr_lres = NULL                              => 0.00615842925800334,
                                                            0.00381238299574771);

final_score_tree_134_c942 := map(
    NULL < rv_a49_curr_avm_chg_1yr AND rv_a49_curr_avm_chg_1yr < -22436.5 => -0.0212032741603843,
    rv_a49_curr_avm_chg_1yr >= -22436.5                                   => final_score_tree_134_c943,
    rv_a49_curr_avm_chg_1yr = NULL                                        => 3.34633473261466e-06,
                                                                             0.00063599252870107);

final_score_tree_134_c945 := map(
    NULL < rv_c14_addrs_15yr AND rv_c14_addrs_15yr < 2.5 => 0.163789153288115,
    rv_c14_addrs_15yr >= 2.5                             => 0.011609289324474,
    rv_c14_addrs_15yr = NULL                             => 0.0617962657380152,
                                                            0.0617962657380152);

final_score_tree_134_c944 := map(
    NULL < rv_a49_curr_avm_chg_1yr_pct AND rv_a49_curr_avm_chg_1yr_pct < 81.85 => final_score_tree_134_c945,
    rv_a49_curr_avm_chg_1yr_pct >= 81.85                                       => -0.0208081703580461,
    rv_a49_curr_avm_chg_1yr_pct = NULL                                         => -0.0102722565771636,
                                                                                  -0.0106978184813064);

final_score_tree_134 := map(
    NULL < rv_i60_inq_auto_recency AND rv_i60_inq_auto_recency < 4.5 => final_score_tree_134_c942,
    rv_i60_inq_auto_recency >= 4.5                                   => final_score_tree_134_c944,
    rv_i60_inq_auto_recency = NULL                                   => 0.0129442242245002,
                                                                        5.8471704990053e-05);

final_score_tree_135_c950 := map(
    NULL < rv_comb_age AND rv_comb_age < 49.5 => 0.0110148732722653,
    rv_comb_age >= 49.5                       => 0.033432344940977,
    rv_comb_age = NULL                        => 0.0211645159569182,
                                                 0.0211645159569182);

final_score_tree_135_c949 := map(
    NULL < iv_wealth_index AND iv_wealth_index < 2.5 => final_score_tree_135_c950,
    iv_wealth_index >= 2.5                           => -0.00136280796842106,
    iv_wealth_index = NULL                           => 0.0131113382885478,
                                                        0.0131113382885478);

final_score_tree_135_c948 := map(
    NULL < iv_c14_addrs_per_adl AND iv_c14_addrs_per_adl < 6.5 => 0.000260854061713058,
    iv_c14_addrs_per_adl >= 6.5                                => final_score_tree_135_c949,
    iv_c14_addrs_per_adl = NULL                                => 0.00258648957342683,
                                                                  0.00258648957342683);

final_score_tree_135_c947 := map(
    NULL < rv_c13_max_lres AND rv_c13_max_lres < 114.5 => -0.00541968504332769,
    rv_c13_max_lres >= 114.5                           => final_score_tree_135_c948,
    rv_c13_max_lres = NULL                             => 0.00592512572467757,
                                                          -5.99739070229245e-05);

final_score_tree_135 := map(
    NULL < rv_l80_inp_avm_autoval AND rv_l80_inp_avm_autoval < 334931 => final_score_tree_135_c947,
    rv_l80_inp_avm_autoval >= 334931                                  => 0.00771615363268137,
    rv_l80_inp_avm_autoval = NULL                                     => 0.000483309259411627,
                                                                         0.000483309259411627);

final_score_tree_136_c954 := map(
    NULL < rv_comb_age => 0.000605218416241127,
    rv_comb_age = NULL => -0.0105818059394593,
                          3.49362932644453e-05);

final_score_tree_136_c953 := map(
    (rv_e58_br_dead_bus_x_active_phn in ['0-1', '1-0', '1-3', '2-2', '3-0', '3-3'])                             => -0.0180965295741716,
    (rv_e58_br_dead_bus_x_active_phn in ['0-0', '0-2', '0-3', '1-1', '1-2', '2-0', '2-1', '2-3', '3-1', '3-2']) => final_score_tree_136_c954,
    rv_e58_br_dead_bus_x_active_phn = ''                                                                      => -0.000697240218517442,
                                                                                                                   -0.000697240218517442);

final_score_tree_136_c955 := map(
    NULL < iv_estimated_income AND iv_estimated_income < 25500 => -0.0712150894233723,
    iv_estimated_income >= 25500                               => -0.00965411456584519,
    iv_estimated_income = NULL                                 => -0.0284036500554473,
                                                                  -0.0284036500554473);

final_score_tree_136_c952 := map(
    NULL < rv_i62_inq_num_names_per_adl AND rv_i62_inq_num_names_per_adl < 2.5 => final_score_tree_136_c953,
    rv_i62_inq_num_names_per_adl >= 2.5                                        => final_score_tree_136_c955,
    rv_i62_inq_num_names_per_adl = NULL                                        => -0.00108152586405831,
                                                                                  -0.00108152586405831);

final_score_tree_136 := map(
    NULL < iv_fname_non_phn_src_ct AND iv_fname_non_phn_src_ct < 0.5 => -0.0597995235576595,
    iv_fname_non_phn_src_ct >= 0.5                                   => final_score_tree_136_c952,
    iv_fname_non_phn_src_ct = NULL                                   => 0.00691122081994221,
                                                                        -0.00139320273494442);

final_score_tree_137_c957 := map(
    NULL < rv_i62_inq_num_names_per_adl AND rv_i62_inq_num_names_per_adl < 2.5 => 0.00013016225331603,
    rv_i62_inq_num_names_per_adl >= 2.5                                        => -0.0267414292615491,
    rv_i62_inq_num_names_per_adl = NULL                                        => -0.00827866722453009,
                                                                                  -0.000407972526279355);

final_score_tree_137_c960 := map(
    NULL < rv_l79_adls_per_addr_curr AND rv_l79_adls_per_addr_curr < 4.5 => -0.0251107443877815,
    rv_l79_adls_per_addr_curr >= 4.5                                     => 0.068898671190326,
    rv_l79_adls_per_addr_curr = NULL                                     => -0.0181315463955731,
                                                                            -0.0181315463955731);

final_score_tree_137_c959 := map(
    NULL < iv_lname_non_phn_src_ct AND iv_lname_non_phn_src_ct < 4.5 => 0.00796432517772263,
    iv_lname_non_phn_src_ct >= 4.5                                   => final_score_tree_137_c960,
    iv_lname_non_phn_src_ct = NULL                                   => 0.00357464840495246,
                                                                        0.00357464840495246);

final_score_tree_137_c958 := map(
    NULL < rv_c18_invalid_addrs_per_adl AND rv_c18_invalid_addrs_per_adl < 9.5 => final_score_tree_137_c959,
    rv_c18_invalid_addrs_per_adl >= 9.5                                        => 0.114722416692366,
    rv_c18_invalid_addrs_per_adl = NULL                                        => -0.00948777930154556,
                                                                                  0.00379054261677297);

final_score_tree_137 := map(
    NULL < rv_l80_inp_avm_autoval AND rv_l80_inp_avm_autoval < 158000.5 => final_score_tree_137_c957,
    rv_l80_inp_avm_autoval >= 158000.5                                  => final_score_tree_137_c958,
    rv_l80_inp_avm_autoval = NULL                                       => 0.000455815284997136,
                                                                           0.000455815284997136);

final_score_tree_138_c964 := map(
    (rv_4seg_riskview_5_0 in ['2 DEROG', '3 OWNER'])                             => -0.0415555400932442,
    (rv_4seg_riskview_5_0 in ['0 TRUEDID = 0', '1 VER/VAL PROBLEMS', '4 OTHER']) => 0.0335474172027324,
    rv_4seg_riskview_5_0 = ''                                                  => -0.00173350692235426,
                                                                                    -0.00173350692235426);

final_score_tree_138_c965 := map(
    NULL < iv_c13_avg_lres AND iv_c13_avg_lres < 42.5 => -0.126066638151958,
    iv_c13_avg_lres >= 42.5                           => -0.0401189505287817,
    iv_c13_avg_lres = NULL                            => -0.0628698090172694,
                                                         -0.0628698090172694);

final_score_tree_138_c963 := map(
    NULL < rv_c20_m_bureau_adl_fs AND rv_c20_m_bureau_adl_fs < 342.5 => final_score_tree_138_c964,
    rv_c20_m_bureau_adl_fs >= 342.5                                  => final_score_tree_138_c965,
    rv_c20_m_bureau_adl_fs = NULL                                    => -0.0214051246311282,
                                                                        -0.0214051246311282);

final_score_tree_138_c962 := map(
    NULL < rv_c22_inp_addr_occ_index AND rv_c22_inp_addr_occ_index < 6.5 => 0.000398899019941728,
    rv_c22_inp_addr_occ_index >= 6.5                                     => final_score_tree_138_c963,
    rv_c22_inp_addr_occ_index = NULL                                     => 0.000204799736106031,
                                                                            0.000204799736106031);

final_score_tree_138 := map(
    NULL < rv_c14_addrs_5yr AND rv_c14_addrs_5yr < 5.5 => final_score_tree_138_c962,
    rv_c14_addrs_5yr >= 5.5                            => -0.0445517671833834,
    rv_c14_addrs_5yr = NULL                            => -0.000334077859790817,
                                                          -4.25619975917637e-05);

final_score_tree_139_c969 := map(
    NULL < rv_l80_inp_avm_autoval AND rv_l80_inp_avm_autoval < 110589.5 => 0.104261335734174,
    rv_l80_inp_avm_autoval >= 110589.5                                  => -0.0184389912776597,
    rv_l80_inp_avm_autoval = NULL                                       => 0.0538178679626421,
                                                                           0.0538178679626421);

final_score_tree_139_c968 := map(
    NULL < rv_l79_adls_per_sfd_addr AND rv_l79_adls_per_sfd_addr < 3.5 => -0.021955269529545,
    rv_l79_adls_per_sfd_addr >= 3.5                                    => final_score_tree_139_c969,
    rv_l79_adls_per_sfd_addr = NULL                                    => -0.00991717178144817,
                                                                          -0.00991717178144817);

final_score_tree_139_c967 := map(
    NULL < iv_d34_released_liens_ct AND iv_d34_released_liens_ct < 3.5 => 0.000945102660504605,
    iv_d34_released_liens_ct >= 3.5                                    => 0.0721945613342121,
    iv_d34_released_liens_ct = NULL                                    => final_score_tree_139_c968,
                                                                          0.000867627164327415);

final_score_tree_139_c970 := map(
    NULL < rv_mos_since_br_first_seen AND rv_mos_since_br_first_seen < 134.5 => 0.0209420474031407,
    rv_mos_since_br_first_seen >= 134.5                                      => -0.0891345548211483,
    rv_mos_since_br_first_seen = NULL                                        => 0.0153565835900425,
                                                                                0.0153565835900425);

final_score_tree_139 := map(
    NULL < rv_l80_inp_avm_autoval AND rv_l80_inp_avm_autoval < 598162.5 => final_score_tree_139_c967,
    rv_l80_inp_avm_autoval >= 598162.5                                  => final_score_tree_139_c970,
    rv_l80_inp_avm_autoval = NULL                                       => 0.00112895661179041,
                                                                           0.00112895661179041);

//---- 

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
      self.sysdate                          := sysdate;
                    self.ver_src_cnt                      := ver_src_cnt;
                    self.ver_src_pop                      := ver_src_pop;
                    self.ver_src_fsrc                     := ver_src_fsrc;
                    self.ver_src_fsrc_fdate               := ver_src_fsrc_fdate;
                    self.ver_src_fsrc_fdate2              := ver_src_fsrc_fdate2;
                    self.yr_ver_src_fsrc_fdate            := yr_ver_src_fsrc_fdate;
                    self.mth_ver_src_fsrc_fdate           := mth_ver_src_fsrc_fdate;
		                self.ver_src_ak_pos                   := ver_src_ak_pos;
                    self.ver_src_ak                       := ver_src_ak;
                    self._ver_src_fdate_ak                := _ver_src_fdate_ak;
                    self.ver_src_fdate_ak                 := ver_src_fdate_ak;
                    self._ver_src_ldate_ak                := _ver_src_ldate_ak;
                    self.ver_src_ldate_ak                 := ver_src_ldate_ak;
                    self.ver_src_cnt_ak                   := ver_src_cnt_ak;
                    self.ver_src_am_pos                   := ver_src_am_pos;
                    self.ver_src_am                       := ver_src_am;
                    self._ver_src_fdate_am                := _ver_src_fdate_am;
                    self.ver_src_fdate_am                 := ver_src_fdate_am;
                    self._ver_src_ldate_am                := _ver_src_ldate_am;
                    self.ver_src_ldate_am                 := ver_src_ldate_am;
                    self.ver_src_cnt_am                   := ver_src_cnt_am;
                    self.ver_src_ar_pos                   := ver_src_ar_pos;
                    self.ver_src_ar                       := ver_src_ar;
                    self._ver_src_fdate_ar                := _ver_src_fdate_ar;
                    self.ver_src_fdate_ar                 := ver_src_fdate_ar;
                    self._ver_src_ldate_ar                := _ver_src_ldate_ar;
                    self.ver_src_ldate_ar                 := ver_src_ldate_ar;
                    self.ver_src_cnt_ar                   := ver_src_cnt_ar;
                    self.ver_src_ba_pos                   := ver_src_ba_pos;
                    self.ver_src_ba                       := ver_src_ba;
                    self._ver_src_fdate_ba                := _ver_src_fdate_ba;
                    self.ver_src_fdate_ba                 := ver_src_fdate_ba;
                    self._ver_src_ldate_ba                := _ver_src_ldate_ba;
                    self.ver_src_ldate_ba                 := ver_src_ldate_ba;
                    self.ver_src_cnt_ba                   := ver_src_cnt_ba;
                    self.ver_src_cg_pos                   := ver_src_cg_pos;
                    self.ver_src_cg                       := ver_src_cg;
                    self._ver_src_fdate_cg                := _ver_src_fdate_cg;
                    self.ver_src_fdate_cg                 := ver_src_fdate_cg;
                    self._ver_src_ldate_cg                := _ver_src_ldate_cg;
                    self.ver_src_ldate_cg                 := ver_src_ldate_cg;
                    self.ver_src_cnt_cg                   := ver_src_cnt_cg;
                    self.ver_src_co_pos                   := ver_src_co_pos;
                    self.ver_src_co                       := ver_src_co;
                    self._ver_src_fdate_co                := _ver_src_fdate_co;
                    self.ver_src_fdate_co                 := ver_src_fdate_co;
                    self._ver_src_ldate_co                := _ver_src_ldate_co;
                    self.ver_src_ldate_co                 := ver_src_ldate_co;
                    self.ver_src_cnt_co                   := ver_src_cnt_co;
                    self.ver_src_cy_pos                   := ver_src_cy_pos;
                    self.ver_src_cy                       := ver_src_cy;
                    self._ver_src_fdate_cy                := _ver_src_fdate_cy;
                    self.ver_src_fdate_cy                 := ver_src_fdate_cy;
                    self._ver_src_ldate_cy                := _ver_src_ldate_cy;
                    self.ver_src_ldate_cy                 := ver_src_ldate_cy;
                    self.ver_src_cnt_cy                   := ver_src_cnt_cy;
                    self.ver_src_da_pos                   := ver_src_da_pos;
                    self.ver_src_da                       := ver_src_da;
                    self._ver_src_fdate_da                := _ver_src_fdate_da;
                    self.ver_src_fdate_da                 := ver_src_fdate_da;
                    self._ver_src_ldate_da                := _ver_src_ldate_da;
                    self.ver_src_ldate_da                 := ver_src_ldate_da;
                    self.ver_src_cnt_da                   := ver_src_cnt_da;
                    self.ver_src_d_pos                    := ver_src_d_pos;
                    self.ver_src_d                        := ver_src_d;
                    self._ver_src_fdate_d                 := _ver_src_fdate_d;
                    self.ver_src_fdate_d                  := ver_src_fdate_d;
                    self._ver_src_ldate_d                 := _ver_src_ldate_d;
                    self.ver_src_ldate_d                  := ver_src_ldate_d;
                    self.ver_src_cnt_d                    := ver_src_cnt_d;
                    self.ver_src_dl_pos                   := ver_src_dl_pos;
                    self.ver_src_dl                       := ver_src_dl;
                    self._ver_src_fdate_dl                := _ver_src_fdate_dl;
                    self.ver_src_fdate_dl                 := ver_src_fdate_dl;
                    self._ver_src_ldate_dl                := _ver_src_ldate_dl;
                    self.ver_src_ldate_dl                 := ver_src_ldate_dl;
                    self.ver_src_cnt_dl                   := ver_src_cnt_dl;
                    self.ver_src_ds_pos                   := ver_src_ds_pos;
                    self.ver_src_ds                       := ver_src_ds;
                    self._ver_src_fdate_ds                := _ver_src_fdate_ds;
                    self.ver_src_fdate_ds                 := ver_src_fdate_ds;
                    self._ver_src_ldate_ds                := _ver_src_ldate_ds;
                    self.ver_src_ldate_ds                 := ver_src_ldate_ds;
                    self.ver_src_cnt_ds                   := ver_src_cnt_ds;
                    self.ver_src_de_pos                   := ver_src_de_pos;
                    self.ver_src_de                       := ver_src_de;
                    self._ver_src_fdate_de                := _ver_src_fdate_de;
                    self.ver_src_fdate_de                 := ver_src_fdate_de;
                    self._ver_src_ldate_de                := _ver_src_ldate_de;
                    self.ver_src_ldate_de                 := ver_src_ldate_de;
                    self.ver_src_cnt_de                   := ver_src_cnt_de;
                    self.ver_src_eb_pos                   := ver_src_eb_pos;
                    self.ver_src_eb                       := ver_src_eb;
                    self._ver_src_fdate_eb                := _ver_src_fdate_eb;
                    self.ver_src_fdate_eb                 := ver_src_fdate_eb;
                    self._ver_src_ldate_eb                := _ver_src_ldate_eb;
                    self.ver_src_ldate_eb                 := ver_src_ldate_eb;
                    self.ver_src_cnt_eb                   := ver_src_cnt_eb;
                    self.ver_src_em_pos                   := ver_src_em_pos;
                    self.ver_src_em                       := ver_src_em;
                    self._ver_src_fdate_em                := _ver_src_fdate_em;
                    self.ver_src_fdate_em                 := ver_src_fdate_em;
                    self._ver_src_ldate_em                := _ver_src_ldate_em;
                    self.ver_src_ldate_em                 := ver_src_ldate_em;
                    self.ver_src_cnt_em                   := ver_src_cnt_em;
                    self.ver_src_e1_pos                   := ver_src_e1_pos;
                    self.ver_src_e1                       := ver_src_e1;
                    self._ver_src_fdate_e1                := _ver_src_fdate_e1;
                    self.ver_src_fdate_e1                 := ver_src_fdate_e1;
                    self._ver_src_ldate_e1                := _ver_src_ldate_e1;
                    self.ver_src_ldate_e1                 := ver_src_ldate_e1;
                    self.ver_src_cnt_e1                   := ver_src_cnt_e1;
                    self.ver_src_e2_pos                   := ver_src_e2_pos;
                    self.ver_src_e2                       := ver_src_e2;
                    self._ver_src_fdate_e2                := _ver_src_fdate_e2;
                    self.ver_src_fdate_e2                 := ver_src_fdate_e2;
                    self._ver_src_ldate_e2                := _ver_src_ldate_e2;
                    self.ver_src_ldate_e2                 := ver_src_ldate_e2;
                    self.ver_src_cnt_e2                   := ver_src_cnt_e2;
                    self.ver_src_e3_pos                   := ver_src_e3_pos;
                    self.ver_src_e3                       := ver_src_e3;
                    self._ver_src_fdate_e3                := _ver_src_fdate_e3;
                    self.ver_src_fdate_e3                 := ver_src_fdate_e3;
                    self._ver_src_ldate_e3                := _ver_src_ldate_e3;
                    self.ver_src_ldate_e3                 := ver_src_ldate_e3;
                    self.ver_src_cnt_e3                   := ver_src_cnt_e3;
                    self.ver_src_e4_pos                   := ver_src_e4_pos;
                    self.ver_src_e4                       := ver_src_e4;
                    self._ver_src_fdate_e4                := _ver_src_fdate_e4;
                    self.ver_src_fdate_e4                 := ver_src_fdate_e4;
                    self._ver_src_ldate_e4                := _ver_src_ldate_e4;
                    self.ver_src_ldate_e4                 := ver_src_ldate_e4;
                    self.ver_src_cnt_e4                   := ver_src_cnt_e4;
                    self.ver_src_en_pos                   := ver_src_en_pos;
                    self.ver_src_en                       := ver_src_en;
                    self._ver_src_fdate_en                := _ver_src_fdate_en;
                    self.ver_src_fdate_en                 := ver_src_fdate_en;
                    self._ver_src_ldate_en                := _ver_src_ldate_en;
                    self.ver_src_ldate_en                 := ver_src_ldate_en;
                    self.ver_src_cnt_en                   := ver_src_cnt_en;
                    self.ver_src_eq_pos                   := ver_src_eq_pos;
                    self.ver_src_eq                       := ver_src_eq;
                    self._ver_src_fdate_eq                := _ver_src_fdate_eq;
                    self.ver_src_fdate_eq                 := ver_src_fdate_eq;
                    self._ver_src_ldate_eq                := _ver_src_ldate_eq;
                    self.ver_src_ldate_eq                 := ver_src_ldate_eq;
                    self.ver_src_cnt_eq                   := ver_src_cnt_eq;
                    self.ver_src_fe_pos                   := ver_src_fe_pos;
                    self.ver_src_fe                       := ver_src_fe;
                    self._ver_src_fdate_fe                := _ver_src_fdate_fe;
                    self.ver_src_fdate_fe                 := ver_src_fdate_fe;
                    self._ver_src_ldate_fe                := _ver_src_ldate_fe;
                    self.ver_src_ldate_fe                 := ver_src_ldate_fe;
                    self.ver_src_cnt_fe                   := ver_src_cnt_fe;
                    self.ver_src_ff_pos                   := ver_src_ff_pos;
                    self.ver_src_ff                       := ver_src_ff;
                    self._ver_src_fdate_ff                := _ver_src_fdate_ff;
                    self.ver_src_fdate_ff                 := ver_src_fdate_ff;
                    self._ver_src_ldate_ff                := _ver_src_ldate_ff;
                    self.ver_src_ldate_ff                 := ver_src_ldate_ff;
                    self.ver_src_cnt_ff                   := ver_src_cnt_ff;
                    self.ver_src_fr_pos                   := ver_src_fr_pos;
                    self.ver_src_fr                       := ver_src_fr;
                    self._ver_src_fdate_fr                := _ver_src_fdate_fr;
                    self.ver_src_fdate_fr                 := ver_src_fdate_fr;
                    self._ver_src_ldate_fr                := _ver_src_ldate_fr;
                    self.ver_src_ldate_fr                 := ver_src_ldate_fr;
                    self.ver_src_cnt_fr                   := ver_src_cnt_fr;
                    self.ver_src_l2_pos                   := ver_src_l2_pos;
                    self.ver_src_l2                       := ver_src_l2;
                    self._ver_src_fdate_l2                := _ver_src_fdate_l2;
                    self.ver_src_fdate_l2                 := ver_src_fdate_l2;
                    self._ver_src_ldate_l2                := _ver_src_ldate_l2;
                    self.ver_src_ldate_l2                 := ver_src_ldate_l2;
                    self.ver_src_cnt_l2                   := ver_src_cnt_l2;
                    self.ver_src_li_pos                   := ver_src_li_pos;
                    self.ver_src_li                       := ver_src_li;
                    self._ver_src_fdate_li                := _ver_src_fdate_li;
                    self.ver_src_fdate_li                 := ver_src_fdate_li;
                    self._ver_src_ldate_li                := _ver_src_ldate_li;
                    self.ver_src_ldate_li                 := ver_src_ldate_li;
                    self.ver_src_cnt_li                   := ver_src_cnt_li;           
                    self.ver_src_mw_pos                   := ver_src_mw_pos;
                    self.ver_src_mw                       := ver_src_mw;
                    self._ver_src_fdate_mw                := _ver_src_fdate_mw;
                    self.ver_src_fdate_mw                 := ver_src_fdate_mw;
                    self._ver_src_ldate_mw                := _ver_src_ldate_mw;
                    self.ver_src_ldate_mw                 := ver_src_ldate_mw;
                    self.ver_src_cnt_mw                   := ver_src_cnt_mw;
                    self.ver_src_nt_pos                   := ver_src_nt_pos;
                    self.ver_src_nt                       := ver_src_nt;
                    self._ver_src_fdate_nt                := _ver_src_fdate_nt;
                    self.ver_src_fdate_nt                 := ver_src_fdate_nt;
                    self._ver_src_ldate_nt                := _ver_src_ldate_nt;
                    self.ver_src_ldate_nt                 := ver_src_ldate_nt;
                    self.ver_src_cnt_nt                   := ver_src_cnt_nt;
                    self.ver_src_p_pos                    := ver_src_p_pos;
                    self.ver_src_p                        := ver_src_p;
                    self._ver_src_fdate_p                 := _ver_src_fdate_p;
                    self.ver_src_fdate_p                  := ver_src_fdate_p;
                    self._ver_src_ldate_p                 := _ver_src_ldate_p;
                    self.ver_src_ldate_p                  := ver_src_ldate_p;
                    self.ver_src_cnt_p                    := ver_src_cnt_p;
                    self.ver_src_pl_pos                   := ver_src_pl_pos;
                    self.ver_src_pl                       := ver_src_pl;
                    self._ver_src_fdate_pl                := _ver_src_fdate_pl;
                    self.ver_src_fdate_pl                 := ver_src_fdate_pl;
                    self._ver_src_ldate_pl                := _ver_src_ldate_pl;
                    self.ver_src_ldate_pl                 := ver_src_ldate_pl;
                    self.ver_src_cnt_pl                   := ver_src_cnt_pl;
                    self.ver_src_tn_pos                   := ver_src_tn_pos;
                    self.ver_src_tn                       := ver_src_tn;
                    self._ver_src_fdate_tn                := _ver_src_fdate_tn;
                    self.ver_src_fdate_tn                 := ver_src_fdate_tn;
                    self._ver_src_ldate_tn                := _ver_src_ldate_tn;
                    self.ver_src_ldate_tn                 := ver_src_ldate_tn;
                    self.ver_src_cnt_tn                   := ver_src_cnt_tn;
                    self.ver_src_ts_pos                   := ver_src_ts_pos;
                    self.ver_src_ts                       := ver_src_ts;
                    self._ver_src_fdate_ts                := _ver_src_fdate_ts;
                    self.ver_src_fdate_ts                 := ver_src_fdate_ts;
                    self._ver_src_ldate_ts                := _ver_src_ldate_ts;
                    self.ver_src_ldate_ts                 := ver_src_ldate_ts;
                    self.ver_src_cnt_ts                   := ver_src_cnt_ts;
                    self.ver_src_tu_pos                   := ver_src_tu_pos;
                    self.ver_src_tu                       := ver_src_tu;
                    self._ver_src_fdate_tu                := _ver_src_fdate_tu;
                    self.ver_src_fdate_tu                 := ver_src_fdate_tu;
                    self._ver_src_ldate_tu                := _ver_src_ldate_tu;
                    self.ver_src_ldate_tu                 := ver_src_ldate_tu;
                    self.ver_src_cnt_tu                   := ver_src_cnt_tu;
                    self.ver_src_sl_pos                   := ver_src_sl_pos;
                    self.ver_src_sl                       := ver_src_sl;
                    self._ver_src_fdate_sl                := _ver_src_fdate_sl;
                    self.ver_src_fdate_sl                 := ver_src_fdate_sl;
                    self._ver_src_ldate_sl                := _ver_src_ldate_sl;
                    self.ver_src_ldate_sl                 := ver_src_ldate_sl;
                    self.ver_src_cnt_sl                   := ver_src_cnt_sl;
                    self.ver_src_v_pos                    := ver_src_v_pos;
                    self.ver_src_v                        := ver_src_v;
                    self._ver_src_fdate_v                 := _ver_src_fdate_v;
                    self.ver_src_fdate_v                  := ver_src_fdate_v;
                    self._ver_src_ldate_v                 := _ver_src_ldate_v;
                    self.ver_src_ldate_v                  := ver_src_ldate_v;
                    self.ver_src_cnt_v                    := ver_src_cnt_v;
                    self.ver_src_vo_pos                   := ver_src_vo_pos;
                    self.ver_src_vo                       := ver_src_vo;
                    self._ver_src_fdate_vo                := _ver_src_fdate_vo;
                    self.ver_src_fdate_vo                 := ver_src_fdate_vo;
                    self._ver_src_ldate_vo                := _ver_src_ldate_vo;
                    self.ver_src_ldate_vo                 := ver_src_ldate_vo;
                    self.ver_src_cnt_vo                   := ver_src_cnt_vo;
                    self.ver_src_w_pos                    := ver_src_w_pos;
                    self.ver_src_w                        := ver_src_w;
                    self._ver_src_fdate_w                 := _ver_src_fdate_w;
                    self.ver_src_fdate_w                  := ver_src_fdate_w;
                    self._ver_src_ldate_w                 := _ver_src_ldate_w;
                    self.ver_src_ldate_w                  := ver_src_ldate_w;
                    self.ver_src_cnt_w                    := ver_src_cnt_w;
                    self.ver_src_wp_pos                   := ver_src_wp_pos;
                    self.ver_src_wp                       := ver_src_wp;
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

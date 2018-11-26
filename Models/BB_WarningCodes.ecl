IMPORT Models, Risk_Indicators,RiskWise, STD, Business_Risk_BIP, easi;

EXPORT BB_Warningcodes ( GROUPED DATASET(risk_indicators.Layout_Boca_Shell) clam,
                           GROUPED DATASET(Business_Risk_BIP.Layouts.Shell) busShell,	
                          INTEGER num_reasons = 4
                          ) := FUNCTION
  

HRILayout := RECORD
     STRING5 HRI := '';
     END;

HRI_DS_Layout := Record
DATASET(HRILAYOUT) HRIs;
END;


businessplus_layout := record 
risk_indicators.Layout_Boca_Shell clam;
Business_Risk_BIP.Layouts.Shell busShell;

end;

busshellplusclam := join ( busShell ,clam,
left.seq = right.seq,
transform (businessplus_layout, self.busShell := left, self.clam :=right),atmost (1));



 	MODEL_DEBUG := FALSE;
	// MODEL_DEBUG := TRUE;

	isFCRA := False;


	#if(MODEL_DEBUG)
		Layout_Debug := RECORD 
  
                    integer  ver_src_cnt                      ;          //  :=ver_src_cnt;
                    boolean  ver_src_pop                      ;          //  :=ver_src_pop;
                    string  ver_src_fsrc                     ;          //  :=ver_src_fsrc;
                    string  ver_src_fsrc_fdate               ;          //  :=ver_src_fsrc_fdate;
                    integer  ver_src_fsrc_fdate2              ;          //  :=ver_src_fsrc_fdate2;
                    real  yr_ver_src_fsrc_fdate            ;          //  :=yr_ver_src_fsrc_fdate;
                    real  mth_ver_src_fsrc_fdate           ;          //  :=mth_ver_src_fsrc_fdate;
                    integer  ver_src_ak_pos                   ;          //  :=ver_src_ak_pos;
                    boolean  ver_src_ak                       ;          //  :=ver_src_ak;
                    string  _ver_src_fdate_ak                ;          //  :=_ver_src_fdate_ak;
                    integer  ver_src_fdate_ak                 ;          //  :=ver_src_fdate_ak;
                    string  _ver_src_ldate_ak                ;          //  :=_ver_src_ldate_ak;
                    integer  ver_src_ldate_ak                 ;          //  :=ver_src_ldate_ak;
                    integer  ver_src_cnt_ak                   ;          //  :=ver_src_cnt_ak;
                    integer  ver_src_am_pos                   ;          //  :=ver_src_am_pos;
                    boolean  ver_src_am                       ;          //  :=ver_src_am;
                    string  _ver_src_fdate_am                ;          //  :=_ver_src_fdate_am;
                    integer  ver_src_fdate_am                 ;          //  :=ver_src_fdate_am;
                    string  _ver_src_ldate_am                ;          //  :=_ver_src_ldate_am;
                    integer  ver_src_ldate_am                 ;          //  :=ver_src_ldate_am;
                    integer  ver_src_cnt_am                   ;          //  :=ver_src_cnt_am;
                    integer  ver_src_ar_pos                   ;          //  :=ver_src_ar_pos;
                    boolean  ver_src_ar                       ;          //  :=ver_src_ar;
                    string  _ver_src_fdate_ar                ;          //  :=_ver_src_fdate_ar;
                    integer  ver_src_fdate_ar                 ;          //  :=ver_src_fdate_ar;
                    string  _ver_src_ldate_ar                ;          //  :=_ver_src_ldate_ar;
                    integer  ver_src_ldate_ar                 ;          //  :=ver_src_ldate_ar;
                    integer  ver_src_cnt_ar                   ;          //  :=ver_src_cnt_ar;
                    integer  ver_src_ba_pos                   ;          //  :=ver_src_ba_pos;
                    boolean  ver_src_ba                       ;          //  :=ver_src_ba;
                    string  _ver_src_fdate_ba                ;          //  :=_ver_src_fdate_ba;
                    integer  ver_src_fdate_ba                 ;          //  :=ver_src_fdate_ba;
                    string  _ver_src_ldate_ba                ;          //  :=_ver_src_ldate_ba;
                    integer  ver_src_ldate_ba                 ;          //  :=ver_src_ldate_ba;
                    integer  ver_src_cnt_ba                   ;          //  :=ver_src_cnt_ba;
                    integer  ver_src_cg_pos                   ;          //  :=ver_src_cg_pos;
                    boolean  ver_src_cg                       ;          //  :=ver_src_cg;
                    string  _ver_src_fdate_cg                ;          //  :=_ver_src_fdate_cg;
                    integer  ver_src_fdate_cg                 ;          //  :=ver_src_fdate_cg;
                    string  _ver_src_ldate_cg                ;          //  :=_ver_src_ldate_cg;
                    integer  ver_src_ldate_cg                 ;          //  :=ver_src_ldate_cg;
                    integer  ver_src_cnt_cg                   ;          //  :=ver_src_cnt_cg;
                    integer  ver_src_co_pos                   ;          //  :=ver_src_co_pos;
                    boolean  ver_src_co                       ;          //  :=ver_src_co;
                    string  _ver_src_fdate_co                ;          //  :=_ver_src_fdate_co;
                    integer  ver_src_fdate_co                 ;          //  :=ver_src_fdate_co;
                    string  _ver_src_ldate_co                ;          //  :=_ver_src_ldate_co;
                    integer  ver_src_ldate_co                 ;          //  :=ver_src_ldate_co;
                    integer  ver_src_cnt_co                   ;          //  :=ver_src_cnt_co;
                    integer  ver_src_cy_pos                   ;          //  :=ver_src_cy_pos;
                    boolean  ver_src_cy                       ;          //  :=ver_src_cy;
                    string  _ver_src_fdate_cy                ;          //  :=_ver_src_fdate_cy;
                    integer  ver_src_fdate_cy                 ;          //  :=ver_src_fdate_cy;
                    string  _ver_src_ldate_cy                ;          //  :=_ver_src_ldate_cy;
                    integer  ver_src_ldate_cy                 ;          //  :=ver_src_ldate_cy;
                    integer  ver_src_cnt_cy                   ;          //  :=ver_src_cnt_cy;
                    integer  ver_src_da_pos                   ;          //  :=ver_src_da_pos;
                    boolean  ver_src_da                       ;          //  :=ver_src_da;
                    string  _ver_src_fdate_da                ;          //  :=_ver_src_fdate_da;
                    integer  ver_src_fdate_da                 ;          //  :=ver_src_fdate_da;
                    string  _ver_src_ldate_da                ;          //  :=_ver_src_ldate_da;
                    integer  ver_src_ldate_da                 ;          //  :=ver_src_ldate_da;
                    integer  ver_src_cnt_da                   ;          //  :=ver_src_cnt_da;
                    integer  ver_src_d_pos                    ;          //  :=ver_src_d_pos;
                    boolean  ver_src_d                        ;          //  :=ver_src_d;
                    string  _ver_src_fdate_d                 ;          //  :=_ver_src_fdate_d;
                    integer  ver_src_fdate_d                  ;          //  :=ver_src_fdate_d;
                    string  _ver_src_ldate_d                 ;          //  :=_ver_src_ldate_d;
                    integer  ver_src_ldate_d                  ;          //  :=ver_src_ldate_d;
                    integer  ver_src_cnt_d                    ;          //  :=ver_src_cnt_d;
                    integer  ver_src_dl_pos                   ;          //  :=ver_src_dl_pos;
                    boolean  ver_src_dl                       ;          //  :=ver_src_dl;
                    string  _ver_src_fdate_dl                ;          //  :=_ver_src_fdate_dl;
                    integer  ver_src_fdate_dl                 ;          //  :=ver_src_fdate_dl;
                    string  _ver_src_ldate_dl                ;          //  :=_ver_src_ldate_dl;
                    integer  ver_src_ldate_dl                 ;          //  :=ver_src_ldate_dl;
                    integer  ver_src_cnt_dl                   ;          //  :=ver_src_cnt_dl;
                    integer  ver_src_ds_pos                   ;          //  :=ver_src_ds_pos;
                    boolean  ver_src_ds                       ;          //  :=ver_src_ds;
                    string  _ver_src_fdate_ds                ;          //  :=_ver_src_fdate_ds;
                    integer  ver_src_fdate_ds                 ;          //  :=ver_src_fdate_ds;
                    string  _ver_src_ldate_ds                ;          //  :=_ver_src_ldate_ds;
                    integer  ver_src_ldate_ds                 ;          //  :=ver_src_ldate_ds;
                    integer  ver_src_cnt_ds                   ;          //  :=ver_src_cnt_ds;
                    integer  ver_src_de_pos                   ;          //  :=ver_src_de_pos;
                    boolean  ver_src_de                       ;          //  :=ver_src_de;
                    string  _ver_src_fdate_de                ;          //  :=_ver_src_fdate_de;
                    integer  ver_src_fdate_de                 ;          //  :=ver_src_fdate_de;
                    string  _ver_src_ldate_de                ;          //  :=_ver_src_ldate_de;
                    integer  ver_src_ldate_de                 ;          //  :=ver_src_ldate_de;
                    integer  ver_src_cnt_de                   ;          //  :=ver_src_cnt_de;
                    integer  ver_src_eb_pos                   ;          //  :=ver_src_eb_pos;
                    boolean  ver_src_eb                       ;          //  :=ver_src_eb;
                    string  _ver_src_fdate_eb                ;          //  :=_ver_src_fdate_eb;
                    integer  ver_src_fdate_eb                 ;          //  :=ver_src_fdate_eb;
                    string  _ver_src_ldate_eb                ;          //  :=_ver_src_ldate_eb;
                    integer  ver_src_ldate_eb                 ;          //  :=ver_src_ldate_eb;
                    integer  ver_src_cnt_eb                   ;          //  :=ver_src_cnt_eb;
                    integer  ver_src_em_pos                   ;          //  :=ver_src_em_pos;
                    boolean  ver_src_em                       ;          //  :=ver_src_em;
                    string  _ver_src_fdate_em                ;          //  :=_ver_src_fdate_em;
                    integer  ver_src_fdate_em                 ;          //  :=ver_src_fdate_em;
                    string  _ver_src_ldate_em                ;          //  :=_ver_src_ldate_em;
                    integer  ver_src_ldate_em                 ;          //  :=ver_src_ldate_em;
                    integer  ver_src_cnt_em                   ;          //  :=ver_src_cnt_em;
                    integer  ver_src_e1_pos                   ;          //  :=ver_src_e1_pos;
                    boolean  ver_src_e1                       ;          //  :=ver_src_e1;
                    string  _ver_src_fdate_e1                ;          //  :=_ver_src_fdate_e1;
                    integer  ver_src_fdate_e1                 ;          //  :=ver_src_fdate_e1;
                    string  _ver_src_ldate_e1                ;          //  :=_ver_src_ldate_e1;
                    integer  ver_src_ldate_e1                 ;          //  :=ver_src_ldate_e1;
                    integer  ver_src_cnt_e1                   ;          //  :=ver_src_cnt_e1;
                    integer  ver_src_e2_pos                   ;          //  :=ver_src_e2_pos;
                    boolean  ver_src_e2                       ;          //  :=ver_src_e2;
                    string  _ver_src_fdate_e2                ;          //  :=_ver_src_fdate_e2;
                    integer  ver_src_fdate_e2                 ;          //  :=ver_src_fdate_e2;
                    string  _ver_src_ldate_e2                ;          //  :=_ver_src_ldate_e2;
                    integer  ver_src_ldate_e2                 ;          //  :=ver_src_ldate_e2;
                    integer  ver_src_cnt_e2                   ;          //  :=ver_src_cnt_e2;
                    integer  ver_src_e3_pos                   ;          //  :=ver_src_e3_pos;
                    boolean  ver_src_e3                       ;          //  :=ver_src_e3;
                    string  _ver_src_fdate_e3                ;          //  :=_ver_src_fdate_e3;
                    integer  ver_src_fdate_e3                 ;          //  :=ver_src_fdate_e3;
                    string  _ver_src_ldate_e3                ;          //  :=_ver_src_ldate_e3;
                    integer  ver_src_ldate_e3                 ;          //  :=ver_src_ldate_e3;
                    integer  ver_src_cnt_e3                   ;          //  :=ver_src_cnt_e3;
                    integer  ver_src_e4_pos                   ;          //  :=ver_src_e4_pos;
                    boolean  ver_src_e4                       ;          //  :=ver_src_e4;
                    string  _ver_src_fdate_e4                ;          //  :=_ver_src_fdate_e4;
                    integer  ver_src_fdate_e4                 ;          //  :=ver_src_fdate_e4;
                    string  _ver_src_ldate_e4                ;          //  :=_ver_src_ldate_e4;
                    integer  ver_src_ldate_e4                 ;          //  :=ver_src_ldate_e4;
                    integer  ver_src_cnt_e4                   ;          //  :=ver_src_cnt_e4;
                    integer  ver_src_en_pos                   ;          //  :=ver_src_en_pos;
                    boolean  ver_src_en                       ;          //  :=ver_src_en;
                    string  _ver_src_fdate_en                ;          //  :=_ver_src_fdate_en;
                    integer  ver_src_fdate_en                 ;          //  :=ver_src_fdate_en;
                    string  _ver_src_ldate_en                ;          //  :=_ver_src_ldate_en;
                    integer  ver_src_ldate_en                 ;          //  :=ver_src_ldate_en;
                    integer  ver_src_cnt_en                   ;          //  :=ver_src_cnt_en;
                    integer  ver_src_eq_pos                   ;          //  :=ver_src_eq_pos;
                    boolean  ver_src_eq                       ;          //  :=ver_src_eq;
                    string  _ver_src_fdate_eq                ;          //  :=_ver_src_fdate_eq;
                    integer  ver_src_fdate_eq                 ;          //  :=ver_src_fdate_eq;
                    string  _ver_src_ldate_eq                ;          //  :=_ver_src_ldate_eq;
                    integer  ver_src_ldate_eq                 ;          //  :=ver_src_ldate_eq;
                    integer  ver_src_cnt_eq                   ;          //  :=ver_src_cnt_eq;
                    integer  ver_src_fe_pos                   ;          //  :=ver_src_fe_pos;
                    boolean  ver_src_fe                       ;          //  :=ver_src_fe;
                    string  _ver_src_fdate_fe                ;          //  :=_ver_src_fdate_fe;
                    integer  ver_src_fdate_fe                 ;          //  :=ver_src_fdate_fe;
                    string  _ver_src_ldate_fe                ;          //  :=_ver_src_ldate_fe;
                    integer  ver_src_ldate_fe                 ;          //  :=ver_src_ldate_fe;
                    integer  ver_src_cnt_fe                   ;          //  :=ver_src_cnt_fe;
                    integer  ver_src_ff_pos                   ;          //  :=ver_src_ff_pos;
                    boolean  ver_src_ff                       ;          //  :=ver_src_ff;
                    string  _ver_src_fdate_ff                ;          //  :=_ver_src_fdate_ff;
                    integer  ver_src_fdate_ff                 ;          //  :=ver_src_fdate_ff;
                    string  _ver_src_ldate_ff                ;          //  :=_ver_src_ldate_ff;
                    integer  ver_src_ldate_ff                 ;          //  :=ver_src_ldate_ff;
                    integer  ver_src_cnt_ff                   ;          //  :=ver_src_cnt_ff;
                    integer  ver_src_fr_pos                   ;          //  :=ver_src_fr_pos;
                    boolean  ver_src_fr                       ;          //  :=ver_src_fr;
                    string  _ver_src_fdate_fr                ;          //  :=_ver_src_fdate_fr;
                    integer  ver_src_fdate_fr                 ;          //  :=ver_src_fdate_fr;
                    string  _ver_src_ldate_fr                ;          //  :=_ver_src_ldate_fr;
                    integer  ver_src_ldate_fr                 ;          //  :=ver_src_ldate_fr;
                    integer  ver_src_cnt_fr                   ;          //  :=ver_src_cnt_fr;
                    integer  ver_src_l2_pos                   ;          //  :=ver_src_l2_pos;
                    boolean  ver_src_l2                       ;          //  :=ver_src_l2;
                    string  _ver_src_fdate_l2                ;          //  :=_ver_src_fdate_l2;
                    integer  ver_src_fdate_l2                 ;          //  :=ver_src_fdate_l2;
                    string  _ver_src_ldate_l2                ;          //  :=_ver_src_ldate_l2;
                    integer  ver_src_ldate_l2                 ;          //  :=ver_src_ldate_l2;
                    integer  ver_src_cnt_l2                   ;          //  :=ver_src_cnt_l2;
                    integer  ver_src_li_pos                   ;          //  :=ver_src_li_pos;
                    boolean  ver_src_li                       ;          //  :=ver_src_li;
                    string  _ver_src_fdate_li                ;          //  :=_ver_src_fdate_li;
                    integer  ver_src_fdate_li                 ;          //  :=ver_src_fdate_li;
                    string  _ver_src_ldate_li                ;          //  :=_ver_src_ldate_li;
                    integer  ver_src_ldate_li                 ;          //  :=ver_src_ldate_li;
                    integer  ver_src_cnt_li                   ;          //  :=ver_src_cnt_li;
                    integer  ver_src_mw_pos                   ;          //  :=ver_src_mw_pos;
                    boolean  ver_src_mw                       ;          //  :=ver_src_mw;
                    string  _ver_src_fdate_mw                ;          //  :=_ver_src_fdate_mw;
                    integer  ver_src_fdate_mw                 ;          //  :=ver_src_fdate_mw;
                    string  _ver_src_ldate_mw                ;          //  :=_ver_src_ldate_mw;
                    integer  ver_src_ldate_mw                 ;          //  :=ver_src_ldate_mw;
                    integer  ver_src_cnt_mw                   ;          //  :=ver_src_cnt_mw;
                    integer  ver_src_nt_pos                   ;          //  :=ver_src_nt_pos;
                    boolean  ver_src_nt                       ;          //  :=ver_src_nt;
                    string  _ver_src_fdate_nt                ;          //  :=_ver_src_fdate_nt;
                    integer  ver_src_fdate_nt                 ;          //  :=ver_src_fdate_nt;
                    string  _ver_src_ldate_nt                ;          //  :=_ver_src_ldate_nt;
                    integer  ver_src_ldate_nt                 ;          //  :=ver_src_ldate_nt;
                    integer  ver_src_cnt_nt                   ;          //  :=ver_src_cnt_nt;
                    integer  ver_src_p_pos                    ;          //  :=ver_src_p_pos;
                    boolean  ver_src_p                        ;          //  :=ver_src_p;
                    string  _ver_src_fdate_p                 ;          //  :=_ver_src_fdate_p;
                    integer  ver_src_fdate_p                  ;          //  :=ver_src_fdate_p;
                    string  _ver_src_ldate_p                 ;          //  :=_ver_src_ldate_p;
                    integer  ver_src_ldate_p                  ;          //  :=ver_src_ldate_p;
                    integer  ver_src_cnt_p                    ;          //  :=ver_src_cnt_p;
                    integer  ver_src_pl_pos                   ;          //  :=ver_src_pl_pos;
                    boolean  ver_src_pl                       ;          //  :=ver_src_pl;
                    string  _ver_src_fdate_pl                ;          //  :=_ver_src_fdate_pl;
                    integer  ver_src_fdate_pl                 ;          //  :=ver_src_fdate_pl;
                    string  _ver_src_ldate_pl                ;          //  :=_ver_src_ldate_pl;
                    integer  ver_src_ldate_pl                 ;          //  :=ver_src_ldate_pl;
                    integer  ver_src_cnt_pl                   ;          //  :=ver_src_cnt_pl;
                    integer  ver_src_tn_pos                   ;          //  :=ver_src_tn_pos;
                    boolean  ver_src_tn                       ;          //  :=ver_src_tn;
                    string  _ver_src_fdate_tn                ;          //  :=_ver_src_fdate_tn;
                    integer  ver_src_fdate_tn                 ;          //  :=ver_src_fdate_tn;
                    string  _ver_src_ldate_tn                ;          //  :=_ver_src_ldate_tn;
                    integer  ver_src_ldate_tn                 ;          //  :=ver_src_ldate_tn;
                    integer  ver_src_cnt_tn                   ;          //  :=ver_src_cnt_tn;
                    integer  ver_src_ts_pos                   ;          //  :=ver_src_ts_pos;
                    boolean  ver_src_ts                       ;          //  :=ver_src_ts;
                    string  _ver_src_fdate_ts                ;          //  :=_ver_src_fdate_ts;
                    integer  ver_src_fdate_ts                 ;          //  :=ver_src_fdate_ts;
                    string  _ver_src_ldate_ts                ;          //  :=_ver_src_ldate_ts;
                    integer  ver_src_ldate_ts                 ;          //  :=ver_src_ldate_ts;
                    integer  ver_src_cnt_ts                   ;          //  :=ver_src_cnt_ts;
                    integer  ver_src_tu_pos                   ;          //  :=ver_src_tu_pos;
                    boolean  ver_src_tu                       ;          //  :=ver_src_tu;
                    string  _ver_src_fdate_tu                ;          //  :=_ver_src_fdate_tu;
                    integer  ver_src_fdate_tu                 ;          //  :=ver_src_fdate_tu;
                    string  _ver_src_ldate_tu                ;          //  :=_ver_src_ldate_tu;
                    integer  ver_src_ldate_tu                 ;          //  :=ver_src_ldate_tu;
                    integer  ver_src_cnt_tu                   ;          //  :=ver_src_cnt_tu;
                    integer  ver_src_sl_pos                   ;          //  :=ver_src_sl_pos;
                    boolean  ver_src_sl                       ;          //  :=ver_src_sl;
                    string  _ver_src_fdate_sl                ;          //  :=_ver_src_fdate_sl;
                    integer  ver_src_fdate_sl                 ;          //  :=ver_src_fdate_sl;
                    string  _ver_src_ldate_sl                ;          //  :=_ver_src_ldate_sl;
                    integer  ver_src_ldate_sl                 ;          //  :=ver_src_ldate_sl;
                    integer  ver_src_cnt_sl                   ;          //  :=ver_src_cnt_sl;
                    integer  ver_src_v_pos                    ;          //  :=ver_src_v_pos;
                    boolean  ver_src_v                        ;          //  :=ver_src_v;
                    string  _ver_src_fdate_v                 ;          //  :=_ver_src_fdate_v;
                    integer  ver_src_fdate_v                  ;          //  :=ver_src_fdate_v;
                    string  _ver_src_ldate_v                 ;          //  :=_ver_src_ldate_v;
                    integer  ver_src_ldate_v                  ;          //  :=ver_src_ldate_v;
                    integer  ver_src_cnt_v                    ;          //  :=ver_src_cnt_v;
                    integer  ver_src_vo_pos                   ;          //  :=ver_src_vo_pos;
                    boolean  ver_src_vo                       ;          //  :=ver_src_vo;
                    string  _ver_src_fdate_vo                ;          //  :=_ver_src_fdate_vo;
                    integer  ver_src_fdate_vo                 ;          //  :=ver_src_fdate_vo;
                    string  _ver_src_ldate_vo                ;          //  :=_ver_src_ldate_vo;
                    integer  ver_src_ldate_vo                 ;          //  :=ver_src_ldate_vo;
                    integer  ver_src_cnt_vo                   ;          //  :=ver_src_cnt_vo;
                    integer  ver_src_w_pos                    ;          //  :=ver_src_w_pos;
                    boolean  ver_src_w                        ;          //  :=ver_src_w;
                    string  _ver_src_fdate_w                 ;          //  :=_ver_src_fdate_w;
                    integer  ver_src_fdate_w                  ;          //  :=ver_src_fdate_w;
                    string  _ver_src_ldate_w                 ;          //  :=_ver_src_ldate_w;
                    integer  ver_src_ldate_w                  ;          //  :=ver_src_ldate_w;
                    integer  ver_src_cnt_w                    ;          //  :=ver_src_cnt_w;
                    integer  ver_src_wp_pos                   ;          //  :=ver_src_wp_pos;
                    boolean  ver_src_wp                       ;          //  :=ver_src_wp;
                    string  _ver_src_fdate_wp                ;          //  :=_ver_src_fdate_wp;
                    integer  ver_src_fdate_wp                 ;          //  :=ver_src_fdate_wp;
                    string  _ver_src_ldate_wp                ;          //  :=_ver_src_ldate_wp;
                    integer  ver_src_ldate_wp                 ;          //  :=ver_src_ldate_wp;
                    integer  ver_src_cnt_wp                   ;          //  :=ver_src_cnt_wp;
                    integer  ver_src_rcnt                     ;          //  :=ver_src_rcnt;
                    integer  sysdate                          ;          //  :=sysdate;
                    Boolean  wc10p                            ;          //  :=wc10p;
                    Boolean  wc11b                            ;          //  :=wc11b;
                    Boolean  wc12b                            ;          //  :=wc12b;
                    Boolean  wc13b                            ;          //  :=wc13b;
                    Boolean  wc14b                            ;          //  :=wc14b;
                    Boolean  wc15p                            ;          //  :=wc15p;
                    Boolean  wc16p                            ;          //  :=wc16p;
                    Boolean  wc17p                            ;          //  :=wc17p;
                    Boolean  wc18p                            ;          //  :=wc18p;
                    Boolean  wc19p                            ;          //  :=wc19p;
                    Boolean  wc20p                            ;          //  :=wc20p;
                    Boolean  wc21p                            ;          //  :=wc21p;
                    Boolean  wc22p                            ;          //  :=wc22p;
                    Boolean  wc23b                            ;          //  :=wc23b;
                    Boolean  wc24b                            ;          //  :=wc24b;
                    integer  _sum_bureau                      ;          //  :=_sum_bureau;
                    integer  _sum_credentialed                ;          //  :=_sum_credentialed;
                    integer  _sum_other                       ;          //  :=_sum_other;
                    integer  num_sources                      ;          //  :=num_sources;
                    Boolean  wc25p                            ;          //  :=wc25p;
                    Boolean  wc26p                            ;          //  :=wc26p;
                    integer  _earliest_bureau_date            ;          //  :=_earliest_bureau_date;
                    integer  earliest_bureau_date             ;          //  :=earliest_bureau_date;
                    Boolean  wc27p                            ;          //  :=wc27p;
                    integer  _earliest_header_date            ;          //  :=_earliest_header_date;
                    integer  earliest_header_date             ;          //  :=earliest_header_date;
                    Boolean  wc28p                            ;          //  :=wc28p;
                    Boolean  wc29p                            ;          //  :=wc29p;
                    Boolean  wc30b                            ;          //  :=wc30b;
                    Boolean  wc31p                            ;          //  :=wc31p;
                    Boolean  wc32p                            ;          //  :=wc32p;
                    Boolean  wc33p                            ;          //  :=wc33p;
                    Boolean  wc34b                            ;          //  :=wc34b;
                    Boolean  wc35p                            ;          //  :=wc35p;
                    Boolean  wc36p                            ;          //  :=wc36p;
                    Boolean  wc37p                            ;          //  :=wc37p;
                    Boolean  wc38p                            ;          //  :=wc38p;
                    Boolean  wc39p                            ;          //  :=wc39p;
                    Boolean  wc40p                            ;          //  :=wc40p;
                    Boolean  wc41p                            ;          //  :=wc41p;
                    Boolean  wc42p                            ;          //  :=wc42p;
                    Boolean  wc43b                            ;          //  :=wc43b;
                    Boolean  wc44p                            ;          //  :=wc44p;
                    Boolean  wc45b                            ;          //  :=wc45b;
                    Boolean  wc46b                            ;          //  :=wc46b;
                    Boolean  wc47p                            ;          //  :=wc47p;
                    Boolean  wc48p                            ;          //  :=wc48p;
                    Boolean  wc49b                            ;          //  :=wc49b;
                    Boolean  wc50p                            ;          //  :=wc50p;
                    Boolean  wc51b                            ;          //  :=wc51b;
                    Boolean  wc52b                            ;          //  :=wc52b;
                    Boolean  wc53b                            ;          //  :=wc53b;
                    Boolean  wc54b                            ;          //  :=wc54b;
                    Boolean  wc55p                            ;          //  :=wc55p;
                    Boolean  wc56b                            ;          //  :=wc56b;
                    Boolean  wc57p                            ;          //  :=wc57p;
                    Boolean  wc58b                            ;          //  :=wc58b;
                    Boolean  wc59b                            ;          //  :=wc59b;
                    Boolean  wc60b                            ;          //  :=wc60b;
                    Boolean  wc61b                            ;          //  :=wc61b;
                    Boolean  wc62b                            ;          //  :=wc62b;
                    Boolean  wc63b                            ;          //  :=wc63b;
                    Boolean  wc64p                            ;          //  :=wc64p;
                    Boolean  wc65b                            ;          //  :=wc65b;
                    Boolean  wc66p                            ;          //  :=wc66p;
                    Boolean  wc67p                            ;          //  :=wc67p;
                    Boolean  wc68p                            ;          //  :=wc68p;
                    Boolean  wc69b                            ;          //  :=wc69b;
                    Boolean  wc70b                            ;          //  :=wc70b;
                    Boolean  wc71b                            ;          //  :=wc71b;
                    Boolean  wc72b                            ;          //  :=wc72b;
                    Boolean  wc73p                            ;          //  :=wc73p;
                    Boolean  wc74p                            ;          //  :=wc74p;
                    Boolean  wc75b                            ;          //  :=wc75b;
                    Boolean  wc76b                            ;          //  :=wc76b;
                    Boolean  wc77b                            ;          //  :=wc77b;
                    Boolean  wc78b                            ;          //  :=wc78b;
                    Boolean  wc79p                            ;          //  :=wc79p;
                    Boolean  wc80p                            ;          //  :=wc80p;
                    Boolean  wc81p                            ;          //  :=wc81p;
                    Boolean  wc82p                            ;          //  :=wc82p;
                    Boolean  wc83p                            ;          //  :=wc83p;
                    string  bbfm_wc1                         ;          //  :=bbfm_wc1;
                    string  bbfm_wc2                         ;          //  :=bbfm_wc2;
                    string  bbfm_wc3                         ;          //  :=bbfm_wc3;
                    string  bbfm_wc4                         ;          //  :=bbfm_wc4;
                    HRI_DS_Layout                             ;
  
  
  
Risk_Indicators.Layout_Boca_Shell clam;
Business_Risk_BIP.Layouts.OutputLayout busShell;

END;
   Layout_Debug doModel(businessplus_layout le)  := TRANSFORM 
#else   
     
    
     HRI_DS_Layout doModel(businessplus_layout le) := TRANSFORM
  
  #end  
  
  
  /* ***********************************************************
	 *             Model Input Variable Assignments              *
	 ************************************************************* */  
  MaxSASLength := 1000;
  



  
   ver_src_id_count                 := le.busShell.Verification.SourceCountID;
	 bankruptcy_chapter               := le.busShell.Bankruptcy.BankruptcyChapter;
	 sos_standing                     := le.busShell.SOS.SOSStanding;
	 pop_bus_phone                    := le.busShell.Input.InputCheckBusPhone;
	 in_bus_phone10                   := le.busShell.Input_Echo.phone10;
	 inq_consumer_phone               := le.busShell.Inquiry.inquiryconsumerphone;
	 pop_bus_addr                     := le.busShell.Input.InputCheckBusAddr;
	 in_bus_streetaddress1            := le.busShell.Input_Echo.streetaddress1;
	 inq_consumer_addr                := le.busShell.Inquiry.inquiryconsumeraddress;
	 ver_src_id_mth_since_fs          := le.busShell.Business_Activity.SourceBusinessRecordTimeOldestID;
	 pop_bus_state                    := le.busShell.Input.InputCheckBusState;
	 sos_inc_filing_count             := le.busShell.SOS.SOSIncorporationCount;
	 sos_state_input_match            := le.busShell.SOS.SOSIncorporationStateInput;
	 pop_bus_fein                     := le.busShell.Input.InputCheckBusFEIN;
	 fein_input_valid                 := le.busShell.Verification.InputFEINValidNoID;
	 pop_rep1_first                   := le.busShell.Input.InputCheckAuthRepFirstName;
	 pop_rep1_last                    := le.busShell.Input.InputCheckAuthRepLastName;
	 e2b_rep1_name_on_file            := le.busShell.Business_To_Executive_Link.BusExecLinkAuthRepNameOnFile;
	 assoc_count                      := le.busShell.Associates.AssociateCount;
	 liens_unreleased_count84         := le.clam.bjl.liens_unreleased_count84;
	 attr_eviction_count84            := le.clam.BJL.eviction_count84;
	 filing_count120                  := le.clam.bjl.filing_count120;
	 inq_total_count03                := le.busShell.Inquiry.Inquiry24Month;
	 addr_input_type_advo             := le.busShell.Input_Characteristics.InputAddrTypeNoID;
   tin_match_cons_name              := le.busShell.Verification.FEINPersonNameMatch;
	 cons_record_match_addr           := le.busShell.Business_To_Person_Link.BusFEINPersonAddrOverlap;
	 ver_phn_src_count                := le.busShell.Verification.PhoneMatchSourceCount;
	 ver_phn_src_id_count             := le.busShell.Verification.PhoneMatchSourceCountID;
	 addr_input_vacancy               := le.busShell.Verification.InputAddrVacancyNoID;
	 ver_addr_src_count               := le.busShell.Verification.AddrVerificationSourceCount;
	 pop_bus_name                     := le.busShell.Input.InputCheckBusName;
	 fein_input_contradictory_in      := le.busShell.Verification.FEINAddrNameMismatch;
	 ver_fein_src_count               := le.busShell.Verification.FEINMatchSourceCount;
	 ver_name_src_count               := le.busShell.Verification.NameMatchSourceCount;
	 ver_altnm_src_count              := le.busShell.Verification.AltNameMatchSourceCount;
	 phn_input_contradictory          := le.busShell.Verification.PhoneNameMismatch;
	 pop_bus_city                     := le.busShell.Input.InputCheckBusCity;
	 pop_bus_zip                      := le.busShell.Input.InputCheckBusZip;
	 addr_input_zipcode_mismatch      := le.busShell.Verification.AddrZipMismatch;
	 pop_bus_altname                  := le.busShell.Input.InputCheckBusAltName;
	 phn_input_valid                  := le.busShell.Input.InputCheckBusAltName;
	 addr_input_valid                 := le.busShell.Verification.InputAddrValidNoID;
	 addr_input_pobox                 := le.busShell.Verification.AddrPOBox;
	 addr_input_zipcode_type          := le.busShell.Verification.AddrZipType;
	 phn_input_residential            := le.busShell.Verification.PhoneResidential;
	 phn_input_distance_addr          := le.busShell.Verification.PhoneDistance;
	 truedid                          := le.clam.truedid;
	 in_streetaddress                 := le.clam.shell_input.in_streetaddress;
	 out_addr_type                    := le.clam.shell_input.addr_type;
	 in_phone10                       := le.clam.shell_input.phone10;
	 nas_summary                      := le.clam.iid.nas_summary;
	 nap_summary                      := le.clam.iid.nap_summary;
	 rc_phonevalflag                  := le.clam.iid.phonevalflag;
	 rc_decsflag                      := le.clam.iid.decsflag;
	 rc_ssnvalflag                    := le.clam.iid.socsvalflag;
	 rc_addrvalflag                   := le.clam.iid.addrvalflag;
	 ver_sources                      := le.clam.header_summary.ver_sources;
	 ver_sources_first_seen           := le.clam.header_summary.ver_sources_first_seen_date;
	 ver_sources_last_seen            := le.clam.header_summary.ver_sources_last_seen_date;
	 ver_sources_count                := le.clam.header_summary.ver_sources_recordcount;
	 fnamepop                         := le.clam.input_validation.firstname;
	 lnamepop                         := le.clam.input_validation.lastname;
	 addrpop                          := le.clam.input_validation.address;
	 ssnlength                        := le.clam.input_validation.ssn_length;
	 dobpop                           := le.clam.input_validation.dateofbirth;
	 hphnpop                          := le.clam.input_validation.homephone;
	 add_input_advo_vacancy           := le.clam.advo_input_addr.Address_Vacancy_Indicator;
	 avg_lres                         := le.clam.other_address_info.avg_lres;
	 ssns_per_adl                     := le.clam.velocity_counters.ssns_per_adl;
	 addrs_per_adl_c6                 := le.clam.velocity_counters.addrs_per_adl_created_6months;
	 inq_peradl                       := le.clam.acc_logs.inquiryperadl;
	 inq_perssn                       := if(isFCRA, 0, le.clam.acc_logs.inquiryPerSSN );
	 inq_adlsperssn                   := if(isFCRA, 0, le.clam.acc_logs.inquiryADLsPerSSN );
	 inq_lnamesperssn                 := if(isFCRA, 0, le.clam.acc_logs.inquiryLNamesPerSSN );
	 inq_addrsperssn                  := if(isFCRA, 0, le.clam.acc_logs.inquiryAddrsPerSSN );
	 inq_dobsperssn                   := if(isFCRA, 0, le.clam.acc_logs.inquiryDOBsPerSSN );
	 inq_peraddr                      := if(isFCRA, 0, le.clam.acc_logs.inquiryPerAddr );
	 inq_adlsperaddr                  := if(isFCRA, 0, le.clam.acc_logs.inquiryADLsPerAddr );
	 inq_lnamesperaddr                := if(isFCRA, 0, le.clam.acc_logs.inquiryLNamesPerAddr );
	 inq_ssnsperaddr                  := if(isFCRA, 0, le.clam.acc_logs.inquirySSNsPerAddr );
	 inq_perphone                     := if(isFCRA, 0, le.clam.acc_logs.inquiryPerPhone );
	 inq_adlsperphone                 := if(isFCRA, 0, le.clam.acc_logs.inquiryADLsPerPhone );
	 fp_varrisktype                   := le.clam.fdattributesv2.variationrisklevel;
	 fp_srchunvrfdssncount            := le.clam.fdattributesv2.searchunverifiedssncountyear;
	 fp_srchunvrfdaddrcount           := le.clam.fdattributesv2.searchunverifiedaddrcountyear;
	 fp_srchunvrfddobcount            := le.clam.fdattributesv2.searchunverifieddobcountyear;
	 fp_srchunvrfdphonecount          := le.clam.fdattributesv2.searchunverifiedphonecountyear;
	 fp_divrisktype                   := le.clam.fdattributesv2.divrisklevel;
	 fp_srchcomponentrisktype         := le.clam.fdattributesv2.searchcomponentrisklevel;
	 felony_count                     := le.clam.bjl.felony_count;
	inferred_age                     := le.clam.inferred_age;
  input_bus_fein                    := le.busshell.input_echo.fein;
  input_rep_ssn                   := le.busshell.input_echo.rep_ssn;



//***Begining of the SAS code that was converted to ECL ****//

NULL := -999999999;



INTEGER contains_i( string haystack, string needle ) := __common__(  (INTEGER)(StringLib.StringFind(haystack, needle, 1) > 0) )  ;


sysdate := __common__(  common.sas_date(if(le.clam.historydate=999999, (string)std.date.today(), (string6)le.clam.historydate+'01')))  ;





ver_src_cnt := Models.Common.countw((string)(ver_sources), ' !$%&()*+,-./;<^|');

ver_src_pop := ver_src_cnt > 0;

ver_src_rcnt_37 := 0;

ver_src_fsrc := Models.Common.getw(ver_sources, 1);

ver_src_fsrc_fdate := Models.Common.getw(ver_sources_first_seen, 1);

ver_src_fsrc_fdate2 := common.sas_date((string)(ver_src_fsrc_fdate));

yr_ver_src_fsrc_fdate := if(min(sysdate, ver_src_fsrc_fdate2) = NULL, NULL, (sysdate - ver_src_fsrc_fdate2) / 365.25);

mth_ver_src_fsrc_fdate := if(min(sysdate, ver_src_fsrc_fdate2) = NULL, NULL, (sysdate - ver_src_fsrc_fdate2) / 30.5);

ver_src_ak_pos := Models.Common.findw_cpp(ver_sources, 'AK' , '  ,', 'ie');

ver_src_ak := ver_src_ak_pos > 0;

_ver_src_fdate_ak := if(ver_src_ak_pos > 0, Models.Common.getw(ver_sources_first_seen, ver_src_ak_pos), '0');

ver_src_fdate_ak := common.sas_date((string)(_ver_src_fdate_ak));

_ver_src_ldate_ak := if(ver_src_ak_pos > 0, Models.Common.getw(ver_sources_last_seen, ver_src_ak_pos), '0');

ver_src_ldate_ak := common.sas_date((string)(_ver_src_ldate_ak));

ver_src_cnt_ak := if(ver_src_ak_pos > 0, (real)Models.Common.getw(ver_sources_count, ver_src_ak_pos), 0);

ver_src_rcnt_36 := ver_src_rcnt_37 + ver_src_cnt_ak;

ver_src_am_pos := Models.Common.findw_cpp(ver_sources, 'AM' , '  ,', 'ie');

ver_src_am := ver_src_am_pos > 0;

_ver_src_fdate_am := if(ver_src_am_pos > 0, Models.Common.getw(ver_sources_first_seen, ver_src_am_pos), '0');

ver_src_fdate_am := common.sas_date((string)(_ver_src_fdate_am));

_ver_src_ldate_am := if(ver_src_am_pos > 0, Models.Common.getw(ver_sources_last_seen, ver_src_am_pos), '0');

ver_src_ldate_am := common.sas_date((string)(_ver_src_ldate_am));

ver_src_cnt_am := if(ver_src_am_pos > 0, (real)Models.Common.getw(ver_sources_count, ver_src_am_pos), 0);

ver_src_rcnt_35 := ver_src_rcnt_36 + ver_src_cnt_am;

ver_src_ar_pos := Models.Common.findw_cpp(ver_sources, 'AR' , '  ,', 'ie');

ver_src_ar := ver_src_ar_pos > 0;

_ver_src_fdate_ar := if(ver_src_ar_pos > 0, Models.Common.getw(ver_sources_first_seen, ver_src_ar_pos), '0');

ver_src_fdate_ar := common.sas_date((string)(_ver_src_fdate_ar));

_ver_src_ldate_ar := if(ver_src_ar_pos > 0, Models.Common.getw(ver_sources_last_seen, ver_src_ar_pos), '0');

ver_src_ldate_ar := common.sas_date((string)(_ver_src_ldate_ar));

ver_src_cnt_ar := if(ver_src_ar_pos > 0, (real)Models.Common.getw(ver_sources_count, ver_src_ar_pos), 0);

ver_src_rcnt_34 := ver_src_rcnt_35 + ver_src_cnt_ar;

ver_src_ba_pos := Models.Common.findw_cpp(ver_sources, 'BA' , '  ,', 'ie');

ver_src_ba := ver_src_ba_pos > 0;

_ver_src_fdate_ba := if(ver_src_ba_pos > 0, Models.Common.getw(ver_sources_first_seen, ver_src_ba_pos), '0');

ver_src_fdate_ba := common.sas_date((string)(_ver_src_fdate_ba));

_ver_src_ldate_ba := if(ver_src_ba_pos > 0, Models.Common.getw(ver_sources_last_seen, ver_src_ba_pos), '0');

ver_src_ldate_ba := common.sas_date((string)(_ver_src_ldate_ba));

ver_src_cnt_ba := if(ver_src_ba_pos > 0, (real)Models.Common.getw(ver_sources_count, ver_src_ba_pos), 0);

ver_src_rcnt_33 := ver_src_rcnt_34 + ver_src_cnt_ba;

ver_src_cg_pos := Models.Common.findw_cpp(ver_sources, 'CG' , '  ,', 'ie');

ver_src_cg := ver_src_cg_pos > 0;

_ver_src_fdate_cg := if(ver_src_cg_pos > 0, Models.Common.getw(ver_sources_first_seen, ver_src_cg_pos), '0');

ver_src_fdate_cg := common.sas_date((string)(_ver_src_fdate_cg));

_ver_src_ldate_cg := if(ver_src_cg_pos > 0, Models.Common.getw(ver_sources_last_seen, ver_src_cg_pos), '0');

ver_src_ldate_cg := common.sas_date((string)(_ver_src_ldate_cg));

ver_src_cnt_cg := if(ver_src_cg_pos > 0, (real)Models.Common.getw(ver_sources_count, ver_src_cg_pos), 0);

ver_src_rcnt_32 := ver_src_rcnt_33 + ver_src_cnt_cg;

ver_src_co_pos := Models.Common.findw_cpp(ver_sources, 'CO' , '  ,', 'ie');

ver_src_co := ver_src_co_pos > 0;

_ver_src_fdate_co := if(ver_src_co_pos > 0, Models.Common.getw(ver_sources_first_seen, ver_src_co_pos), '0');

ver_src_fdate_co := common.sas_date((string)(_ver_src_fdate_co));

_ver_src_ldate_co := if(ver_src_co_pos > 0, Models.Common.getw(ver_sources_last_seen, ver_src_co_pos), '0');

ver_src_ldate_co := common.sas_date((string)(_ver_src_ldate_co));

ver_src_cnt_co := if(ver_src_co_pos > 0, (real)Models.Common.getw(ver_sources_count, ver_src_co_pos), 0);

ver_src_rcnt_31 := ver_src_rcnt_32 + ver_src_cnt_co;

ver_src_cy_pos := Models.Common.findw_cpp(ver_sources, 'CY' , '  ,', 'ie');

ver_src_cy := ver_src_cy_pos > 0;

_ver_src_fdate_cy := if(ver_src_cy_pos > 0, Models.Common.getw(ver_sources_first_seen, ver_src_cy_pos), '0');

ver_src_fdate_cy := common.sas_date((string)(_ver_src_fdate_cy));

_ver_src_ldate_cy := if(ver_src_cy_pos > 0, Models.Common.getw(ver_sources_last_seen, ver_src_cy_pos), '0');

ver_src_ldate_cy := common.sas_date((string)(_ver_src_ldate_cy));

ver_src_cnt_cy := if(ver_src_cy_pos > 0, (real)Models.Common.getw(ver_sources_count, ver_src_cy_pos), 0);

ver_src_rcnt_30 := ver_src_rcnt_31 + ver_src_cnt_cy;

ver_src_da_pos := Models.Common.findw_cpp(ver_sources, 'DA' , '  ,', 'ie');

ver_src_da := ver_src_da_pos > 0;

_ver_src_fdate_da := if(ver_src_da_pos > 0, Models.Common.getw(ver_sources_first_seen, ver_src_da_pos), '0');

ver_src_fdate_da := common.sas_date((string)(_ver_src_fdate_da));

_ver_src_ldate_da := if(ver_src_da_pos > 0, Models.Common.getw(ver_sources_last_seen, ver_src_da_pos), '0');

ver_src_ldate_da := common.sas_date((string)(_ver_src_ldate_da));

ver_src_cnt_da := if(ver_src_da_pos > 0, (real)Models.Common.getw(ver_sources_count, ver_src_da_pos), 0);

ver_src_rcnt_29 := ver_src_rcnt_30 + ver_src_cnt_da;

ver_src_d_pos := Models.Common.findw_cpp(ver_sources, 'D' , '  ,', 'ie');

ver_src_d := ver_src_d_pos > 0;

_ver_src_fdate_d := if(ver_src_d_pos > 0, Models.Common.getw(ver_sources_first_seen, ver_src_d_pos), '0');

ver_src_fdate_d := common.sas_date((string)(_ver_src_fdate_d));

_ver_src_ldate_d := if(ver_src_d_pos > 0, Models.Common.getw(ver_sources_last_seen, ver_src_d_pos), '0');

ver_src_ldate_d := common.sas_date((string)(_ver_src_ldate_d));

ver_src_cnt_d := if(ver_src_d_pos > 0, (real)Models.Common.getw(ver_sources_count, ver_src_d_pos), 0);

ver_src_rcnt_28 := ver_src_rcnt_29 + ver_src_cnt_d;

ver_src_dl_pos := Models.Common.findw_cpp(ver_sources, 'DL' , '  ,', 'ie');

ver_src_dl := ver_src_dl_pos > 0;

_ver_src_fdate_dl := if(ver_src_dl_pos > 0, Models.Common.getw(ver_sources_first_seen, ver_src_dl_pos), '0');

ver_src_fdate_dl := common.sas_date((string)(_ver_src_fdate_dl));

_ver_src_ldate_dl := if(ver_src_dl_pos > 0, Models.Common.getw(ver_sources_last_seen, ver_src_dl_pos), '0');

ver_src_ldate_dl := common.sas_date((string)(_ver_src_ldate_dl));

ver_src_cnt_dl := if(ver_src_dl_pos > 0, (real)Models.Common.getw(ver_sources_count, ver_src_dl_pos), 0);

ver_src_rcnt_27 := ver_src_rcnt_28 + ver_src_cnt_dl;

ver_src_ds_pos := Models.Common.findw_cpp(ver_sources, 'DS' , '  ,', 'ie');

ver_src_ds := ver_src_ds_pos > 0;

_ver_src_fdate_ds := if(ver_src_ds_pos > 0, Models.Common.getw(ver_sources_first_seen, ver_src_ds_pos), '0');

ver_src_fdate_ds := common.sas_date((string)(_ver_src_fdate_ds));

_ver_src_ldate_ds := if(ver_src_ds_pos > 0, Models.Common.getw(ver_sources_last_seen, ver_src_ds_pos), '0');

ver_src_ldate_ds := common.sas_date((string)(_ver_src_ldate_ds));

ver_src_cnt_ds := if(ver_src_ds_pos > 0, (real)Models.Common.getw(ver_sources_count, ver_src_ds_pos), 0);

ver_src_rcnt_26 := ver_src_rcnt_27 + ver_src_cnt_ds;

ver_src_de_pos := Models.Common.findw_cpp(ver_sources, 'DE' , '  ,', 'ie');

ver_src_de := ver_src_de_pos > 0;

_ver_src_fdate_de := if(ver_src_de_pos > 0, Models.Common.getw(ver_sources_first_seen, ver_src_de_pos), '0');

ver_src_fdate_de := common.sas_date((string)(_ver_src_fdate_de));

_ver_src_ldate_de := if(ver_src_de_pos > 0, Models.Common.getw(ver_sources_last_seen, ver_src_de_pos), '0');

ver_src_ldate_de := common.sas_date((string)(_ver_src_ldate_de));

ver_src_cnt_de := if(ver_src_de_pos > 0, (real)Models.Common.getw(ver_sources_count, ver_src_de_pos), 0);

ver_src_rcnt_25 := ver_src_rcnt_26 + ver_src_cnt_de;

ver_src_eb_pos := Models.Common.findw_cpp(ver_sources, 'EB' , '  ,', 'ie');

ver_src_eb := ver_src_eb_pos > 0;

_ver_src_fdate_eb := if(ver_src_eb_pos > 0, Models.Common.getw(ver_sources_first_seen, ver_src_eb_pos), '0');

ver_src_fdate_eb := common.sas_date((string)(_ver_src_fdate_eb));

_ver_src_ldate_eb := if(ver_src_eb_pos > 0, Models.Common.getw(ver_sources_last_seen, ver_src_eb_pos), '0');

ver_src_ldate_eb := common.sas_date((string)(_ver_src_ldate_eb));

ver_src_cnt_eb := if(ver_src_eb_pos > 0, (real)Models.Common.getw(ver_sources_count, ver_src_eb_pos), 0);

ver_src_rcnt_24 := ver_src_rcnt_25 + ver_src_cnt_eb;

ver_src_em_pos := Models.Common.findw_cpp(ver_sources, 'EM' , '  ,', 'ie');

ver_src_em := ver_src_em_pos > 0;

_ver_src_fdate_em := if(ver_src_em_pos > 0, Models.Common.getw(ver_sources_first_seen, ver_src_em_pos), '0');

ver_src_fdate_em := common.sas_date((string)(_ver_src_fdate_em));

_ver_src_ldate_em := if(ver_src_em_pos > 0, Models.Common.getw(ver_sources_last_seen, ver_src_em_pos), '0');

ver_src_ldate_em := common.sas_date((string)(_ver_src_ldate_em));

ver_src_cnt_em := if(ver_src_em_pos > 0, (real)Models.Common.getw(ver_sources_count, ver_src_em_pos), 0);

ver_src_rcnt_23 := ver_src_rcnt_24 + ver_src_cnt_em;

ver_src_e1_pos := Models.Common.findw_cpp(ver_sources, 'E1' , '  ,', 'ie');

ver_src_e1 := ver_src_e1_pos > 0;

_ver_src_fdate_e1 := if(ver_src_e1_pos > 0, Models.Common.getw(ver_sources_first_seen, ver_src_e1_pos), '0');

ver_src_fdate_e1 := common.sas_date((string)(_ver_src_fdate_e1));

_ver_src_ldate_e1 := if(ver_src_e1_pos > 0, Models.Common.getw(ver_sources_last_seen, ver_src_e1_pos), '0');

ver_src_ldate_e1 := common.sas_date((string)(_ver_src_ldate_e1));

ver_src_cnt_e1 := if(ver_src_e1_pos > 0, (real)Models.Common.getw(ver_sources_count, ver_src_e1_pos), 0);

ver_src_rcnt_22 := ver_src_rcnt_23 + ver_src_cnt_e1;

ver_src_e2_pos := Models.Common.findw_cpp(ver_sources, 'E2' , '  ,', 'ie');

ver_src_e2 := ver_src_e2_pos > 0;

_ver_src_fdate_e2 := if(ver_src_e2_pos > 0, Models.Common.getw(ver_sources_first_seen, ver_src_e2_pos), '0');

ver_src_fdate_e2 := common.sas_date((string)(_ver_src_fdate_e2));

_ver_src_ldate_e2 := if(ver_src_e2_pos > 0, Models.Common.getw(ver_sources_last_seen, ver_src_e2_pos), '0');

ver_src_ldate_e2 := common.sas_date((string)(_ver_src_ldate_e2));

ver_src_cnt_e2 := if(ver_src_e2_pos > 0, (real)Models.Common.getw(ver_sources_count, ver_src_e2_pos), 0);

ver_src_rcnt_21 := ver_src_rcnt_22 + ver_src_cnt_e2;

ver_src_e3_pos := Models.Common.findw_cpp(ver_sources, 'E3' , '  ,', 'ie');

ver_src_e3 := ver_src_e3_pos > 0;

_ver_src_fdate_e3 := if(ver_src_e3_pos > 0, Models.Common.getw(ver_sources_first_seen, ver_src_e3_pos), '0');

ver_src_fdate_e3 := common.sas_date((string)(_ver_src_fdate_e3));

_ver_src_ldate_e3 := if(ver_src_e3_pos > 0, Models.Common.getw(ver_sources_last_seen, ver_src_e3_pos), '0');

ver_src_ldate_e3 := common.sas_date((string)(_ver_src_ldate_e3));

ver_src_cnt_e3 := if(ver_src_e3_pos > 0, (real)Models.Common.getw(ver_sources_count, ver_src_e3_pos), 0);

ver_src_rcnt_20 := ver_src_rcnt_21 + ver_src_cnt_e3;

ver_src_e4_pos := Models.Common.findw_cpp(ver_sources, 'E4' , '  ,', 'ie');

ver_src_e4 := ver_src_e4_pos > 0;

_ver_src_fdate_e4 := if(ver_src_e4_pos > 0, Models.Common.getw(ver_sources_first_seen, ver_src_e4_pos), '0');

ver_src_fdate_e4 := common.sas_date((string)(_ver_src_fdate_e4));

_ver_src_ldate_e4 := if(ver_src_e4_pos > 0, Models.Common.getw(ver_sources_last_seen, ver_src_e4_pos), '0');

ver_src_ldate_e4 := common.sas_date((string)(_ver_src_ldate_e4));

ver_src_cnt_e4 := if(ver_src_e4_pos > 0, (real)Models.Common.getw(ver_sources_count, ver_src_e4_pos), 0);

ver_src_rcnt_19 := ver_src_rcnt_20 + ver_src_cnt_e4;

ver_src_en_pos := Models.Common.findw_cpp(ver_sources, 'EN' , '  ,', 'ie');

ver_src_en := ver_src_en_pos > 0;

_ver_src_fdate_en := if(ver_src_en_pos > 0, Models.Common.getw(ver_sources_first_seen, ver_src_en_pos), '0');

ver_src_fdate_en := common.sas_date((string)(_ver_src_fdate_en));

_ver_src_ldate_en := if(ver_src_en_pos > 0, Models.Common.getw(ver_sources_last_seen, ver_src_en_pos), '0');

ver_src_ldate_en := common.sas_date((string)(_ver_src_ldate_en));

ver_src_cnt_en := if(ver_src_en_pos > 0, (real)Models.Common.getw(ver_sources_count, ver_src_en_pos), 0);

ver_src_rcnt_18 := ver_src_rcnt_19 + ver_src_cnt_en;

ver_src_eq_pos := Models.Common.findw_cpp(ver_sources, 'EQ' , '  ,', 'ie');

ver_src_eq := ver_src_eq_pos > 0;

_ver_src_fdate_eq := if(ver_src_eq_pos > 0, Models.Common.getw(ver_sources_first_seen, ver_src_eq_pos), '0');

ver_src_fdate_eq := common.sas_date((string)(_ver_src_fdate_eq));

_ver_src_ldate_eq := if(ver_src_eq_pos > 0, Models.Common.getw(ver_sources_last_seen, ver_src_eq_pos), '0');

ver_src_ldate_eq := common.sas_date((string)(_ver_src_ldate_eq));

ver_src_cnt_eq := if(ver_src_eq_pos > 0, (real)Models.Common.getw(ver_sources_count, ver_src_eq_pos), 0);

ver_src_rcnt_17 := ver_src_rcnt_18 + ver_src_cnt_eq;

ver_src_fe_pos := Models.Common.findw_cpp(ver_sources, 'FE' , '  ,', 'ie');

ver_src_fe := ver_src_fe_pos > 0;

_ver_src_fdate_fe := if(ver_src_fe_pos > 0, Models.Common.getw(ver_sources_first_seen, ver_src_fe_pos), '0');

ver_src_fdate_fe := common.sas_date((string)(_ver_src_fdate_fe));

_ver_src_ldate_fe := if(ver_src_fe_pos > 0, Models.Common.getw(ver_sources_last_seen, ver_src_fe_pos), '0');

ver_src_ldate_fe := common.sas_date((string)(_ver_src_ldate_fe));

ver_src_cnt_fe := if(ver_src_fe_pos > 0, (real)Models.Common.getw(ver_sources_count, ver_src_fe_pos), 0);

ver_src_rcnt_16 := ver_src_rcnt_17 + ver_src_cnt_fe;

ver_src_ff_pos := Models.Common.findw_cpp(ver_sources, 'FF' , '  ,', 'ie');

ver_src_ff := ver_src_ff_pos > 0;

_ver_src_fdate_ff := if(ver_src_ff_pos > 0, Models.Common.getw(ver_sources_first_seen, ver_src_ff_pos), '0');

ver_src_fdate_ff := common.sas_date((string)(_ver_src_fdate_ff));

_ver_src_ldate_ff := if(ver_src_ff_pos > 0, Models.Common.getw(ver_sources_last_seen, ver_src_ff_pos), '0');

ver_src_ldate_ff := common.sas_date((string)(_ver_src_ldate_ff));

ver_src_cnt_ff := if(ver_src_ff_pos > 0, (real)Models.Common.getw(ver_sources_count, ver_src_ff_pos), 0);

ver_src_rcnt_15 := ver_src_rcnt_16 + ver_src_cnt_ff;

ver_src_fr_pos := Models.Common.findw_cpp(ver_sources, 'FR' , '  ,', 'ie');

ver_src_fr := ver_src_fr_pos > 0;

_ver_src_fdate_fr := if(ver_src_fr_pos > 0, Models.Common.getw(ver_sources_first_seen, ver_src_fr_pos), '0');

ver_src_fdate_fr := common.sas_date((string)(_ver_src_fdate_fr));

_ver_src_ldate_fr := if(ver_src_fr_pos > 0, Models.Common.getw(ver_sources_last_seen, ver_src_fr_pos), '0');

ver_src_ldate_fr := common.sas_date((string)(_ver_src_ldate_fr));

ver_src_cnt_fr := if(ver_src_fr_pos > 0, (real)Models.Common.getw(ver_sources_count, ver_src_fr_pos), 0);

ver_src_rcnt_14 := ver_src_rcnt_15 + ver_src_cnt_fr;

ver_src_l2_pos := Models.Common.findw_cpp(ver_sources, 'L2' , '  ,', 'ie');

ver_src_l2 := ver_src_l2_pos > 0;

_ver_src_fdate_l2 := if(ver_src_l2_pos > 0, Models.Common.getw(ver_sources_first_seen, ver_src_l2_pos), '0');

ver_src_fdate_l2 := common.sas_date((string)(_ver_src_fdate_l2));

_ver_src_ldate_l2 := if(ver_src_l2_pos > 0, Models.Common.getw(ver_sources_last_seen, ver_src_l2_pos), '0');

ver_src_ldate_l2 := common.sas_date((string)(_ver_src_ldate_l2));

ver_src_cnt_l2 := if(ver_src_l2_pos > 0, (real)Models.Common.getw(ver_sources_count, ver_src_l2_pos), 0);

ver_src_rcnt_13 := ver_src_rcnt_14 + ver_src_cnt_l2;

ver_src_li_pos := Models.Common.findw_cpp(ver_sources, 'LI' , '  ,', 'ie');

ver_src_li := ver_src_li_pos > 0;

_ver_src_fdate_li := if(ver_src_li_pos > 0, Models.Common.getw(ver_sources_first_seen, ver_src_li_pos), '0');

ver_src_fdate_li := common.sas_date((string)(_ver_src_fdate_li));

_ver_src_ldate_li := if(ver_src_li_pos > 0, Models.Common.getw(ver_sources_last_seen, ver_src_li_pos), '0');

ver_src_ldate_li := common.sas_date((string)(_ver_src_ldate_li));

ver_src_cnt_li := if(ver_src_li_pos > 0, (real)Models.Common.getw(ver_sources_count, ver_src_li_pos), 0);

ver_src_rcnt_12 := ver_src_rcnt_13 + ver_src_cnt_li;

ver_src_mw_pos := Models.Common.findw_cpp(ver_sources, 'MW' , '  ,', 'ie');

ver_src_mw := ver_src_mw_pos > 0;

_ver_src_fdate_mw := if(ver_src_mw_pos > 0, Models.Common.getw(ver_sources_first_seen, ver_src_mw_pos), '0');

ver_src_fdate_mw := common.sas_date((string)(_ver_src_fdate_mw));

_ver_src_ldate_mw := if(ver_src_mw_pos > 0, Models.Common.getw(ver_sources_last_seen, ver_src_mw_pos), '0');

ver_src_ldate_mw := common.sas_date((string)(_ver_src_ldate_mw));

ver_src_cnt_mw := if(ver_src_mw_pos > 0, (real)Models.Common.getw(ver_sources_count, ver_src_mw_pos), 0);

ver_src_rcnt_11 := ver_src_rcnt_12 + ver_src_cnt_mw;

ver_src_nt_pos := Models.Common.findw_cpp(ver_sources, 'NT' , '  ,', 'ie');

ver_src_nt := ver_src_nt_pos > 0;

_ver_src_fdate_nt := if(ver_src_nt_pos > 0, Models.Common.getw(ver_sources_first_seen, ver_src_nt_pos), '0');

ver_src_fdate_nt := common.sas_date((string)(_ver_src_fdate_nt));

_ver_src_ldate_nt := if(ver_src_nt_pos > 0, Models.Common.getw(ver_sources_last_seen, ver_src_nt_pos), '0');

ver_src_ldate_nt := common.sas_date((string)(_ver_src_ldate_nt));

ver_src_cnt_nt := if(ver_src_nt_pos > 0, (real)Models.Common.getw(ver_sources_count, ver_src_nt_pos), 0);

ver_src_rcnt_10 := ver_src_rcnt_11 + ver_src_cnt_nt;

ver_src_p_pos := Models.Common.findw_cpp(ver_sources, 'P' , '  ,', 'ie');

ver_src_p := ver_src_p_pos > 0;

_ver_src_fdate_p := if(ver_src_p_pos > 0, Models.Common.getw(ver_sources_first_seen, ver_src_p_pos), '0');

ver_src_fdate_p := common.sas_date((string)(_ver_src_fdate_p));

_ver_src_ldate_p := if(ver_src_p_pos > 0, Models.Common.getw(ver_sources_last_seen, ver_src_p_pos), '0');

ver_src_ldate_p := common.sas_date((string)(_ver_src_ldate_p));

ver_src_cnt_p := if(ver_src_p_pos > 0, (real)Models.Common.getw(ver_sources_count, ver_src_p_pos), 0);

ver_src_rcnt_9 := ver_src_rcnt_10 + ver_src_cnt_p;

ver_src_pl_pos := Models.Common.findw_cpp(ver_sources, 'PL' , '  ,', 'ie');

ver_src_pl := ver_src_pl_pos > 0;

_ver_src_fdate_pl := if(ver_src_pl_pos > 0, Models.Common.getw(ver_sources_first_seen, ver_src_pl_pos), '0');

ver_src_fdate_pl := common.sas_date((string)(_ver_src_fdate_pl));

_ver_src_ldate_pl := if(ver_src_pl_pos > 0, Models.Common.getw(ver_sources_last_seen, ver_src_pl_pos), '0');

ver_src_ldate_pl := common.sas_date((string)(_ver_src_ldate_pl));

ver_src_cnt_pl := if(ver_src_pl_pos > 0, (real)Models.Common.getw(ver_sources_count, ver_src_pl_pos), 0);

ver_src_rcnt_8 := ver_src_rcnt_9 + ver_src_cnt_pl;

ver_src_tn_pos := Models.Common.findw_cpp(ver_sources, 'TN' , '  ,', 'ie');

ver_src_tn := ver_src_tn_pos > 0;

_ver_src_fdate_tn := if(ver_src_tn_pos > 0, Models.Common.getw(ver_sources_first_seen, ver_src_tn_pos), '0');

ver_src_fdate_tn := common.sas_date((string)(_ver_src_fdate_tn));

_ver_src_ldate_tn := if(ver_src_tn_pos > 0, Models.Common.getw(ver_sources_last_seen, ver_src_tn_pos), '0');

ver_src_ldate_tn := common.sas_date((string)(_ver_src_ldate_tn));

ver_src_cnt_tn := if(ver_src_tn_pos > 0, (real)Models.Common.getw(ver_sources_count, ver_src_tn_pos), 0);

ver_src_rcnt_7 := ver_src_rcnt_8 + ver_src_cnt_tn;

ver_src_ts_pos := Models.Common.findw_cpp(ver_sources, 'TS' , '  ,', 'ie');

ver_src_ts := ver_src_ts_pos > 0;

_ver_src_fdate_ts := if(ver_src_ts_pos > 0, Models.Common.getw(ver_sources_first_seen, ver_src_ts_pos), '0');

ver_src_fdate_ts := common.sas_date((string)(_ver_src_fdate_ts));

_ver_src_ldate_ts := if(ver_src_ts_pos > 0, Models.Common.getw(ver_sources_last_seen, ver_src_ts_pos), '0');

ver_src_ldate_ts := common.sas_date((string)(_ver_src_ldate_ts));

ver_src_cnt_ts := if(ver_src_ts_pos > 0, (real)Models.Common.getw(ver_sources_count, ver_src_ts_pos), 0);

ver_src_rcnt_6 := ver_src_rcnt_7 + ver_src_cnt_ts;

ver_src_tu_pos := Models.Common.findw_cpp(ver_sources, 'TU' , '  ,', 'ie');

ver_src_tu := ver_src_tu_pos > 0;

_ver_src_fdate_tu := if(ver_src_tu_pos > 0, Models.Common.getw(ver_sources_first_seen, ver_src_tu_pos), '0');

ver_src_fdate_tu := common.sas_date((string)(_ver_src_fdate_tu));

_ver_src_ldate_tu := if(ver_src_tu_pos > 0, Models.Common.getw(ver_sources_last_seen, ver_src_tu_pos), '0');

ver_src_ldate_tu := common.sas_date((string)(_ver_src_ldate_tu));

ver_src_cnt_tu := if(ver_src_tu_pos > 0, (real)Models.Common.getw(ver_sources_count, ver_src_tu_pos), 0);

ver_src_rcnt_5 := ver_src_rcnt_6 + ver_src_cnt_tu;

ver_src_sl_pos := Models.Common.findw_cpp(ver_sources, 'SL' , '  ,', 'ie');

ver_src_sl := ver_src_sl_pos > 0;

_ver_src_fdate_sl := if(ver_src_sl_pos > 0, Models.Common.getw(ver_sources_first_seen, ver_src_sl_pos), '0');

ver_src_fdate_sl := common.sas_date((string)(_ver_src_fdate_sl));

_ver_src_ldate_sl := if(ver_src_sl_pos > 0, Models.Common.getw(ver_sources_last_seen, ver_src_sl_pos), '0');

ver_src_ldate_sl := common.sas_date((string)(_ver_src_ldate_sl));

ver_src_cnt_sl := if(ver_src_sl_pos > 0, (real)Models.Common.getw(ver_sources_count, ver_src_sl_pos), 0);

ver_src_rcnt_4 := ver_src_rcnt_5 + ver_src_cnt_sl;

ver_src_v_pos := Models.Common.findw_cpp(ver_sources, 'V' , '  ,', 'ie');

ver_src_v := ver_src_v_pos > 0;

_ver_src_fdate_v := if(ver_src_v_pos > 0, Models.Common.getw(ver_sources_first_seen, ver_src_v_pos), '0');

ver_src_fdate_v := common.sas_date((string)(_ver_src_fdate_v));

_ver_src_ldate_v := if(ver_src_v_pos > 0, Models.Common.getw(ver_sources_last_seen, ver_src_v_pos), '0');

ver_src_ldate_v := common.sas_date((string)(_ver_src_ldate_v));

ver_src_cnt_v := if(ver_src_v_pos > 0, (real)Models.Common.getw(ver_sources_count, ver_src_v_pos), 0);

ver_src_rcnt_3 := ver_src_rcnt_4 + ver_src_cnt_v;

ver_src_vo_pos := Models.Common.findw_cpp(ver_sources, 'VO' , '  ,', 'ie');

ver_src_vo := ver_src_vo_pos > 0;

_ver_src_fdate_vo := if(ver_src_vo_pos > 0, Models.Common.getw(ver_sources_first_seen, ver_src_vo_pos), '0');

ver_src_fdate_vo := common.sas_date((string)(_ver_src_fdate_vo));

_ver_src_ldate_vo := if(ver_src_vo_pos > 0, Models.Common.getw(ver_sources_last_seen, ver_src_vo_pos), '0');

ver_src_ldate_vo := common.sas_date((string)(_ver_src_ldate_vo));

ver_src_cnt_vo := if(ver_src_vo_pos > 0, (real)Models.Common.getw(ver_sources_count, ver_src_vo_pos), 0);

ver_src_rcnt_2 := ver_src_rcnt_3 + ver_src_cnt_vo;

ver_src_w_pos := Models.Common.findw_cpp(ver_sources, 'W' , '  ,', 'ie');

ver_src_w := ver_src_w_pos > 0;

_ver_src_fdate_w := if(ver_src_w_pos > 0, Models.Common.getw(ver_sources_first_seen, ver_src_w_pos), '0');

ver_src_fdate_w := common.sas_date((string)(_ver_src_fdate_w));

_ver_src_ldate_w := if(ver_src_w_pos > 0, Models.Common.getw(ver_sources_last_seen, ver_src_w_pos), '0');

ver_src_ldate_w := common.sas_date((string)(_ver_src_ldate_w));

ver_src_cnt_w := if(ver_src_w_pos > 0, (real)Models.Common.getw(ver_sources_count, ver_src_w_pos), 0);

ver_src_rcnt_1 := ver_src_rcnt_2 + ver_src_cnt_w;

ver_src_wp_pos := Models.Common.findw_cpp(ver_sources, 'WP' , '  ,', 'ie');

ver_src_wp := ver_src_wp_pos > 0;

_ver_src_fdate_wp := if(ver_src_wp_pos > 0, Models.Common.getw(ver_sources_first_seen, ver_src_wp_pos), '0');

ver_src_fdate_wp := common.sas_date((string)(_ver_src_fdate_wp));

_ver_src_ldate_wp := if(ver_src_wp_pos > 0, Models.Common.getw(ver_sources_last_seen, ver_src_wp_pos), '0');

ver_src_ldate_wp := common.sas_date((string)(_ver_src_ldate_wp));

ver_src_cnt_wp := if(ver_src_wp_pos > 0, (real)Models.Common.getw(ver_sources_count, ver_src_wp_pos), 0);

ver_src_rcnt := ver_src_rcnt_1 + ver_src_cnt_wp;


wc10p := rc_decsflag = '1';

wc11b := ver_src_id_count < '1';

wc12b := bankruptcy_chapter = '13';

wc13b := sos_standing = '1';

wc14b := sos_standing = '2';

wc15p := fp_srchunvrfdssncount > '2' or fp_srchunvrfdaddrcount > '2' or fp_srchunvrfddobcount > '2' or fp_srchunvrfdphonecount > '2';

wc16p := fp_srchcomponentrisktype >= '5';

wc17p := inq_dobsperssn > 2;

wc18p := inq_addrsperssn > 2;

wc19p := inq_lnamesperssn > 2;

wc20p := inq_adlsperssn > 2;

wc21p := inq_perssn >= 10;

wc22p := fp_varrisktype >= '5';

wc23b := pop_bus_phone = '1' and hphnpop  and in_bus_phone10 != in_phone10 and inq_consumer_phone >= '6';

wc24b := pop_bus_addr = '1' and addrpop  and in_bus_streetaddress1 != in_streetaddress and inq_consumer_addr >= '6';

_sum_bureau := if(max((integer)ver_src_eq, (integer)ver_src_en, (integer)ver_src_tn) = NULL, NULL, sum((integer)ver_src_eq, (integer)ver_src_en, (integer)ver_src_tn));

_sum_credentialed := if(max((integer)ver_src_ar, (integer)ver_src_am, (integer)ver_src_ba, (integer)ver_src_cg, (integer)ver_src_da, (integer)ver_src_d, (integer)ver_src_dl, (integer)ver_src_eb, (integer)ver_src_e1, (integer)ver_src_e2, (integer)ver_src_e3, (integer)ver_src_fe, (integer)ver_src_ff, (integer)ver_src_p, (integer)ver_src_pl, (integer)ver_src_sl, (integer)ver_src_v, (integer)ver_src_vo, (integer)ver_src_w) = NULL, NULL, sum((integer)ver_src_ar, (integer)ver_src_am, (integer)ver_src_ba, (integer)ver_src_cg, (integer)ver_src_da, (integer)ver_src_d, (integer)ver_src_dl, (integer)ver_src_eb, (integer)ver_src_e1, (integer)ver_src_e2, (integer)ver_src_e3, (integer)ver_src_fe, (integer)ver_src_ff, (integer)ver_src_p, (integer)ver_src_pl, (integer)ver_src_sl, (integer)ver_src_v, (integer)ver_src_vo, (integer)ver_src_w));

_sum_other := if(max((integer)ver_src_ak, (integer)ver_src_cy, (integer)ver_src_e4, (integer)ver_src_em, (integer)ver_src_fr, (integer)ver_src_li, (integer)ver_src_l2, (integer)ver_src_mw, (integer)ver_src_nt, (integer)ver_src_wp) = NULL, NULL, sum((integer)ver_src_ak, (integer)ver_src_cy, (integer)ver_src_e4, (integer)ver_src_em, (integer)ver_src_fr, (integer)ver_src_li, (integer)ver_src_l2, (integer)ver_src_mw, (integer)ver_src_nt, (integer)ver_src_wp));

num_sources := if(max(_sum_bureau, _sum_credentialed, _sum_other) = NULL, NULL, sum(if(_sum_bureau = NULL, 0, _sum_bureau), if(_sum_credentialed = NULL, 0, _sum_credentialed), if(_sum_other = NULL, 0, _sum_other)));

wc25p := truedid  and _sum_bureau > 0 and _sum_credentialed = 0 and _sum_other = 0;

wc26p := truedid  and num_sources <= 5;

_earliest_bureau_date := if(ver_src_fdate_tn = NULL and ver_src_fdate_en = NULL and ver_src_fdate_eq = NULL, NULL, if(max(ver_src_fdate_tn, ver_src_fdate_en, ver_src_fdate_eq) = NULL, NULL, min(if(ver_src_fdate_tn = NULL, -NULL, ver_src_fdate_tn), if(ver_src_fdate_en = NULL, -NULL, ver_src_fdate_en), if(ver_src_fdate_eq = NULL, -NULL, ver_src_fdate_eq))));

earliest_bureau_date := if(min(sysdate, _earliest_bureau_date) = NULL, NULL, if ((sysdate - _earliest_bureau_date) / 30.5 >= 0, roundup((sysdate - _earliest_bureau_date) / 30.5), truncate((sysdate - _earliest_bureau_date) / 30.5)));

wc27p := 0 <= earliest_bureau_date AND earliest_bureau_date <= 60;

_earliest_header_date := if(max(ver_src_fdate_nt, ver_src_fdate_ba, ver_src_fdate_fr, ver_src_fdate_p, ver_src_fdate_v, ver_src_fdate_vo, ver_src_fdate_d, ver_src_fdate_tu, ver_src_fdate_ar, ver_src_fdate_am, ver_src_fdate_cg, ver_src_fdate_w, ver_src_fdate_co, ver_src_fdate_cy, ver_src_fdate_ff, ver_src_fdate_em, ver_src_fdate_wp, ver_src_fdate_l2, ver_src_fdate_ts, ver_src_fdate_ds, ver_src_fdate_pl, ver_src_fdate_en, ver_src_fdate_fe, ver_src_fdate_e4, ver_src_fdate_tn, ver_src_fdate_ak, ver_src_fdate_mw, ver_src_fdate_e2, ver_src_fdate_eq, ver_src_fdate_eb, ver_src_fdate_e3, ver_src_fdate_de, ver_src_fdate_da, ver_src_fdate_sl, ver_src_fdate_e1, ver_src_fdate_li, ver_src_fdate_dl) = NULL, NULL, min(if(ver_src_fdate_nt = NULL, -NULL, ver_src_fdate_nt), if(ver_src_fdate_ba = NULL, -NULL, ver_src_fdate_ba), if(ver_src_fdate_fr = NULL, -NULL, ver_src_fdate_fr), if(ver_src_fdate_p = NULL, -NULL, ver_src_fdate_p), if(ver_src_fdate_v = NULL, -NULL, ver_src_fdate_v), if(ver_src_fdate_vo = NULL, -NULL, ver_src_fdate_vo), if(ver_src_fdate_d = NULL, -NULL, ver_src_fdate_d), if(ver_src_fdate_tu = NULL, -NULL, ver_src_fdate_tu), if(ver_src_fdate_ar = NULL, -NULL, ver_src_fdate_ar), if(ver_src_fdate_am = NULL, -NULL, ver_src_fdate_am), if(ver_src_fdate_cg = NULL, -NULL, ver_src_fdate_cg), if(ver_src_fdate_w = NULL, -NULL, ver_src_fdate_w), if(ver_src_fdate_co = NULL, -NULL, ver_src_fdate_co), if(ver_src_fdate_cy = NULL, -NULL, ver_src_fdate_cy), if(ver_src_fdate_ff = NULL, -NULL, ver_src_fdate_ff), if(ver_src_fdate_em = NULL, -NULL, ver_src_fdate_em), if(ver_src_fdate_wp = NULL, -NULL, ver_src_fdate_wp), if(ver_src_fdate_l2 = NULL, -NULL, ver_src_fdate_l2), if(ver_src_fdate_ts = NULL, -NULL, ver_src_fdate_ts), if(ver_src_fdate_ds = NULL, -NULL, ver_src_fdate_ds), if(ver_src_fdate_pl = NULL, -NULL, ver_src_fdate_pl), if(ver_src_fdate_en = NULL, -NULL, ver_src_fdate_en), if(ver_src_fdate_fe = NULL, -NULL, ver_src_fdate_fe), if(ver_src_fdate_e4 = NULL, -NULL, ver_src_fdate_e4), if(ver_src_fdate_tn = NULL, -NULL, ver_src_fdate_tn), if(ver_src_fdate_ak = NULL, -NULL, ver_src_fdate_ak), if(ver_src_fdate_mw = NULL, -NULL, ver_src_fdate_mw), if(ver_src_fdate_e2 = NULL, -NULL, ver_src_fdate_e2), if(ver_src_fdate_eq = NULL, -NULL, ver_src_fdate_eq), if(ver_src_fdate_eb = NULL, -NULL, ver_src_fdate_eb), if(ver_src_fdate_e3 = NULL, -NULL, ver_src_fdate_e3), if(ver_src_fdate_de = NULL, -NULL, ver_src_fdate_de), if(ver_src_fdate_da = NULL, -NULL, ver_src_fdate_da), if(ver_src_fdate_sl = NULL, -NULL, ver_src_fdate_sl), if(ver_src_fdate_e1 = NULL, -NULL, ver_src_fdate_e1), if(ver_src_fdate_li = NULL, -NULL, ver_src_fdate_li), if(ver_src_fdate_dl = NULL, -NULL, ver_src_fdate_dl)));

earliest_header_date := if(min(sysdate, _earliest_header_date) = NULL, NULL, if ((sysdate - _earliest_header_date) / 30.5 >= 0, roundup((sysdate - _earliest_header_date) / 30.5), truncate((sysdate - _earliest_header_date) / 30.5)));

wc28p := 0 <= earliest_header_date AND earliest_header_date <= 60;

wc29p := addrs_per_adl_c6 >= 2 or ( avg_lres >= 0 and avg_lres <= 12);

wc30b := ver_src_id_mth_since_fs >= '0' and ver_src_id_mth_since_fs <= '12';

wc31p := inq_adlsperphone > 2;

wc32p := inq_perphone > 5;

wc33p := fp_divrisktype >= '5';

wc34b := pop_bus_state ='1'  and sos_inc_filing_count > '0' and sos_state_input_match = '0';

wc35p := inq_ssnsperaddr > 2;

wc36p := inq_lnamesperaddr > 2;

wc37p := inq_adlsperaddr > 2;

wc38p := inq_peraddr > 5;

wc39p := (nas_summary in [0, 1, 2, 3, 5, 8]);

wc40p := (nas_summary in [0, 1, 2, 3, 4, 5, 7, 8, 9]);

wc41p := not((nas_summary in [9, 12]));

wc42p := ssns_per_adl >= 3;

wc43b := pop_bus_fein = '1' and fein_input_valid = '0';

wc44p := (input_bus_fein = input_rep_ssn and pop_bus_fein = '1' and  ssnlength = '9' and fein_input_valid = '0') OR (input_bus_fein <> input_rep_ssn and ssnlength = '9' and rc_ssnvalflag = '1');

wc45b := pop_rep1_first = '1' and pop_rep1_last = '1' and e2b_rep1_name_on_file = '0';

wc46b := ver_src_id_count >'0' and assoc_count = '0';

wc47p := felony_count > 0;

wc48p := if(max(liens_unreleased_count84, attr_eviction_count84, filing_count120, felony_count) = NULL, NULL, sum(if(liens_unreleased_count84 = NULL, 0, liens_unreleased_count84), if(attr_eviction_count84 = NULL, 0, attr_eviction_count84), if(filing_count120 = NULL, 0, filing_count120), if(felony_count = NULL, 0, felony_count))) > 2;

wc49b := inq_total_count03 > '2';

wc50p := inq_peradl > 5;

wc51b := pop_bus_addr = '1' and addr_input_type_advo = 'A';

wc52b := tin_match_cons_name = '1' or cons_record_match_addr = '2';

wc53b := pop_bus_phone = '1' and ver_phn_src_count <= '0' and ver_phn_src_id_count <= '0' and ver_src_id_count > '0';

wc54b := pop_bus_addr = '1' and addr_input_vacancy = 'Y';

wc55p := (pop_bus_addr = '1' and addrpop  and in_bus_streetaddress1 = in_streetaddress and addr_input_vacancy = 'Y' )or( addrpop  and in_bus_streetaddress1 != in_streetaddress and add_input_advo_vacancy = 'Y');

wc56b := pop_bus_addr = '1' and ver_addr_src_count <= '0' and ver_src_id_count > '0';

wc57p := (inferred_age > 0 and inferred_age <= 17) or inferred_age > 70;

wc58b := pop_bus_name = '1' and pop_bus_addr = '1' and pop_bus_fein = '1' and fein_input_contradictory_in = '4' and (ver_fein_src_count < '1' or (ver_name_src_count < '1' and ver_altnm_src_count < '1' and ver_addr_src_count < '1'));

wc59b := pop_bus_name = '1' and pop_bus_addr = '1' and pop_bus_phone = '1' and phn_input_contradictory = '4' and ((ver_phn_src_count < '1' and ver_phn_src_id_count < '1') or ( ver_name_src_count < '1' and ver_altnm_src_count < '1' and ver_addr_src_count < '1'));

wc60b := pop_bus_city = '1' and pop_bus_state = '1' and pop_bus_zip = '1' and addr_input_zipcode_mismatch ='1';

wc61b := pop_bus_name = '1' and ver_name_src_count <= '0' and pop_bus_altname = '1' and ver_altnm_src_count > '0' and ver_src_id_count > '0';

wc62b := pop_bus_name = '1' and ver_name_src_count <= '0' and ver_src_id_count > '0';

wc63b := pop_bus_phone = '1' and phn_input_valid = '0';

wc64p := (pop_bus_phone = '1' and hphnpop  and in_bus_phone10 = in_phone10 and phn_input_valid = '0' )OR (hphnpop  and in_bus_phone10 != in_phone10 and rc_phonevalflag = '0');

wc65b := pop_bus_addr = '1' and addr_input_valid = '0';

wc66p := (pop_bus_addr = '1' and addrpop  and in_bus_streetaddress1 = in_streetaddress and addr_input_valid = '0' )OR (addrpop and in_bus_streetaddress1 != in_streetaddress and rc_addrvalflag = 'N');

wc67p := out_addr_type = 'H';

wc68p := out_addr_type = 'P';

wc69b := (pop_bus_addr = '1' and addr_input_pobox = '1') or (pop_bus_zip = '1' and addr_input_zipcode_type = '1');

wc70b := pop_bus_phone = '1' and phn_input_residential = '1';

wc71b := pop_bus_phone = '1' and phn_input_distance_addr > '10';

wc72b := pop_bus_fein = '1' and ver_fein_src_count <='0' and ver_src_id_count > '0';

wc73p := (nap_summary in [0, 1, 2, 3, 5, 8]);

wc74p := nap_summary != 12;

wc75b := pop_bus_name = '0' and pop_bus_altname = '0';

wc76b := pop_bus_addr = '0' or (pop_bus_addr = '1' and pop_bus_city = '0' and pop_bus_state = '0' and pop_bus_zip = '0') or pop_bus_addr = '1' and ((pop_bus_city = '0' or pop_bus_state = '0') and pop_bus_zip = '0');

wc77b := pop_bus_phone = '0';

wc78b := pop_bus_fein = '0';

wc79p :=  not fnamepop  or not lnamepop ;

wc80p :=  not addrpop ;

wc81p := not((ssnlength in ['4', '9']));

wc82p := not hphnpop ;

wc83p :=  not dobpop ;

/* Engineering will need to construct the following final Warning Code variables by
hand based on the spreadsheet sent by Lea:

bbfm_wc1
bbfm_wc2
bbfm_wc3
bbfm_wc4
*/
ds_WCCodes := 
		DATASET(	
			[
				{'10P'}, {'11B'}, {'12B'}, {'13B'}, {'14B'}, {'15P'}, {'16P'}, {'17P'}, {'18P'}, {'19P'}, 
				{'20P'}, {'21P'}, {'22P'}, {'23B'}, {'24B'}, {'25P'}, {'26P'}, {'27P'}, {'28P'}, {'29P'}, 
				{'30B'}, {'31P'}, {'32P'}, {'33P'}, {'34B'}, {'35P'}, {'36P'}, {'37P'}, {'38P'}, {'39P'}, 
				{'40P'}, {'41P'}, {'42P'}, {'43B'}, {'44P'}, {'45B'}, {'46B'}, {'47P'}, {'48P'}, {'49B'}, 
				{'50P'}, {'51B'}, {'52B'}, {'53B'}, {'54B'}, {'55P'}, {'56B'}, {'57P'}, {'58B'}, {'59B'}, 
        {'60B'}, {'61B'}, {'62B'}, {'63B'}, {'64P'}, {'65B'}, {'66P'}, {'67P'}, {'68P'}, {'69B'},
        {'70B'}, {'71B'}, {'72B'}, {'73P'}, {'74P'}, {'75B'}, {'76B'}, {'77B'}, {'78B'}, {'79P'}, 
        {'80P'}, {'81P'}, {'82P'}, {'83P'}
			], { STRING2 wccode }
		);

	getWCPriority(STRING4 wc) := 
		CASE(TRIM(wc),	
			'10P' =>  1, '11B' =>  2, '12B' =>  3, '13B' =>  4, '14B' =>  5, '15P' =>  6, '16P' =>  7, '17P' =>  8, '18P' =>  9, '19P' => 10, 
			'20P' => 11, '21P' => 12, '22P' => 13, '23B' => 14, '24B' => 15, '25P' => 16, '26P' => 17, '27P' => 18, '28P' => 19, '29P' => 20, 
			'30B' => 21, '31P' => 22, '32P' => 23, '33P' => 24, '34B' => 25, '35P' => 26, '36P' => 27, '37P' => 28, '38P' => 29, '39P' => 30, 
			'40P' => 31, '41P' => 32, '42P' => 33, '43B' => 34, '44P' => 35, '45B' => 36, '46B' => 37, '47P' => 38, '48P' => 39, '49B' => 40, 
			'50P' => 41, '51B' => 42, '52B' => 43, '53B' => 44, '54B' => 45, '55P' => 46, '56B' => 47, '57P' => 48, '58B' => 49, '59B' => 50, 
      '60B' => 51, '61B' => 52, '62B' => 53, '63B' => 54, '64P' => 55, '65B' => 56, '66P' => 57, '67P' => 58, '68P' => 59, '69B' => 60, 
      '70B' => 61, '71B' => 62, '72B' => 63, '73P' => 64, '74P' => 65, '75B' => 66, '76B' => 67, '77B' => 68, '78B' => 69, '79B' => 70, 
      '80P' => 71, '81P' => 72, '82P' => 73, '83P' => 74,  /* default => */ 99);

	getWaterfallGroup(STRING4 wc) := 
		CASE(TRIM(wc),	
			'10P' => 'N', '11B' => 'N', '12B' => 'A', '13B' => 'A', '14B' => 'A', '15P' => 'N', '16P' => 'N', '17P' =>  'B', '18P' => 'B','19P' => 'B', 
			'20P' => 'B', '21P' => 'B', '22P' => 'N', '23B' => 'C', '24B' => 'C', '25P' => 'D', '26P' => 'D', '27P' => 'E', '28P' => 'E', '29P' => 'N', 
			'30B' => 'N', '31P' => 'F', '32P' => 'F', '33P' => 'N', '34B' => 'N', '35P' => 'G', '36P' => 'G', '37P' => 'G', '38P' => 'G', '39P' => 'H', 
			'40P' => 'H', '41P' => 'H', '42P' => 'N', '43B' => 'N', '44P' => 'N', '45B' => 'I', '46B' => 'I', '47P' => 'J', '48P' => 'J', '49B' => 'N', 
			'50P' => 'N', '51B' => 'K', '52B' => 'K', '53B' => 'N', '54B' => 'N', '55P' => 'N', '56B' => 'N', '57P' => 'N', '58B' => 'N', '59B' => 'N', 
      '60B' => 'N', '61B' => 'L', '62B' => 'L', '63B' => 'N', '64P' => 'N', '65B' => 'N', '66P' => 'N', '67P' => 'N', '68P' => 'N', '69B' => 'N', 
      '70B' => 'N', '71B' => 'N', '72B' => 'N', '73P' => 'M', '74P' => 'M', '75B' => 'N', '76B' => 'N', '77B' => 'N', '78B' => 'N', '79B' => 'N', 
      '80P' => 'N', '81P' => 'N', '82P' => 'N', '83P' => 'N', /* default => */ 'A');

   
   BOOLEAN getWhetherRiskIndicator(STRING4 wc) := 
				
				CASE( TRIM(wc), 
					'10P' => wc10p ,
					'11B' => wc11b ,
					'12B' => wc12b ,
					'13B' => wc13b ,
					'14B' => wc14b ,
					'15P' => wc15p ,
					'16P' => wc16p ,
					'17P' => wc17p ,
					'18P' => wc18p ,
					'19P' => wc19p ,
					'20P' => wc20p ,
					'21P' => wc21P ,
					'22P' => wc22P ,
					'23B' => wc23B ,
					'24B' => wc24B ,
					'25P' => wc25P ,
					'26P' => wc26P ,
					'27P' => wc27P ,
					'28P' => wc28P ,
					'29P' => wc29P ,
					'30B' => wc30B ,
					'31P' => wc31P ,
					'32P' => wc32P ,
					'33P' => wc33P ,
					'34B' => wc34B ,
					'35P' => wc35P ,
					'36P' => wc36P ,
					'37P' => wc37P ,
					'38P' => wc38P ,
					'39P' => wc39P ,
					'40P' => wc40P ,
					'41P' => wc41P ,
					'42P' => wc42P ,
					'43B' => wc43B ,
					'44P' => wc44P ,
					'45B' => wc45B ,
					'46B' => wc46B ,
					'47P' => wc47P ,
					'48P' => wc48P ,
					'49B' => wc49B ,
					'50P' => wc50P,
					'51B' => wc51B ,
					'52B' => wc52B ,
					'53B' => wc53B ,
					'54B' => wc54B ,
          '55P' => wc55P,
					'56B' => wc56B ,
					'57P' => wc57P ,
					'58B' => wc58B ,
					'59B' => wc59B ,
					'60B' => wc60B ,
					'61B' => wc61B ,
					'62B' => wc62B ,
					'63B' => wc63B ,
					'64B' => wc64P ,
					'65B' => wc65B ,
					'66P' => wc66P ,
					'67P' => wc67P ,
					'68P' => wc68P ,
					'69B' => wc69B ,
					'70B' => wc70B ,
					'71B' => wc71B ,
					'72B' => wc72B ,
					'73P' => wc73P ,
					'74P' => wc74P ,
					'75B' => wc75B ,
					'76B' => wc76B ,
					'77B' => wc77B ,
					'78B' => wc78B ,
					'79P' => wc79P ,
					'80P' => wc80P ,
					'81P' => wc81P ,
					'82P' => wc82P ,
					'83P' => wc83P ,
					        FALSE
				);
    
   	layout_RiskIndicators_temp := RECORD
				STRING10 risk_indicator_code;
				BOOLEAN is_risk_indicator;
				STRING1 waterfall_group;
				UNSIGNED1 risk_indicator_priority;
				
			END;
			
			ds_RiskIndicators := 
				PROJECT(
					ds_WCCodes,
					TRANSFORM( layout_RiskIndicators_temp,
						SELF.risk_indicator_code     := LEFT.wccode;
						SELF.is_risk_indicator       := getWhetherRiskIndicator(LEFT.wccode);
						SELF.waterfall_group         := getWaterfallGroup(LEFT.wccode);
						SELF.risk_indicator_priority := getWCPriority(LEFT.wccode);
												
					)
				);
			
			ds_TrueRiskIndicators := ds_RiskIndicators(is_risk_indicator = TRUE);
			
			ds_TrueRiskIndicatorsGroupA := ds_TrueRiskIndicators(waterfall_group = 'A');
			ds_TrueRiskIndicatorsGroupB := ds_TrueRiskIndicators(waterfall_group = 'B');
			ds_TrueRiskIndicatorsGroupC := ds_TrueRiskIndicators(waterfall_group = 'C');
			ds_TrueRiskIndicatorsGroupD := ds_TrueRiskIndicators(waterfall_group = 'D');
			ds_TrueRiskIndicatorsGroupE := ds_TrueRiskIndicators(waterfall_group = 'E');
			ds_TrueRiskIndicatorsGroupN := ds_TrueRiskIndicators(waterfall_group = 'N');
			ds_TrueRiskIndicatorsGroupM := ds_TrueRiskIndicators(waterfall_group = 'M');
			ds_TrueRiskIndicatorsGroupF := ds_TrueRiskIndicators(waterfall_group = 'F');
			ds_TrueRiskIndicatorsGroupG := ds_TrueRiskIndicators(waterfall_group = 'G');
			ds_TrueRiskIndicatorsGroupH := ds_TrueRiskIndicators(waterfall_group = 'H');
			ds_TrueRiskIndicatorsGroupI := ds_TrueRiskIndicators(waterfall_group = 'I');
			ds_TrueRiskIndicatorsGroupJ := ds_TrueRiskIndicators(waterfall_group = 'J');
			ds_TrueRiskIndicatorsGroupK := ds_TrueRiskIndicators(waterfall_group = 'K');
			ds_TrueRiskIndicatorsGroupL := ds_TrueRiskIndicators(waterfall_group = 'L');
			
			
			ds_TopRiskIndicatorsGroupA := CHOOSEN(SORT(ds_TrueRiskIndicatorsGroupA,risk_indicator_priority),1);
			ds_TopRiskIndicatorsGroupB := CHOOSEN(SORT(ds_TrueRiskIndicatorsGroupB,risk_indicator_priority),1);
			ds_TopRiskIndicatorsGroupC := CHOOSEN(SORT(ds_TrueRiskIndicatorsGroupC,risk_indicator_priority),1);
			ds_TopRiskIndicatorsGroupD := CHOOSEN(SORT(ds_TrueRiskIndicatorsGroupD,risk_indicator_priority),1);
			ds_TopRiskIndicatorsGroupE := CHOOSEN(SORT(ds_TrueRiskIndicatorsGroupE,risk_indicator_priority),1);
			ds_TopRiskIndicatorsGroupN := CHOOSEN(SORT(ds_TrueRiskIndicatorsGroupN,risk_indicator_priority),41);
			ds_TopRiskIndicatorsGroupM := CHOOSEN(SORT(ds_TrueRiskIndicatorsGroupM,risk_indicator_priority),1);
			ds_TopRiskIndicatorsGroupF := CHOOSEN(SORT(ds_TrueRiskIndicatorsGroupF,risk_indicator_priority),1);
			ds_TopRiskIndicatorsGroupG := CHOOSEN(SORT(ds_TrueRiskIndicatorsGroupG,risk_indicator_priority),1);
			ds_TopRiskIndicatorsGroupH := CHOOSEN(SORT(ds_TrueRiskIndicatorsGroupH,risk_indicator_priority),1);
			ds_TopRiskIndicatorsGroupI := CHOOSEN(SORT(ds_TrueRiskIndicatorsGroupI,risk_indicator_priority),1);
			ds_TopRiskIndicatorsGroupJ := CHOOSEN(SORT(ds_TrueRiskIndicatorsGroupJ,risk_indicator_priority),1);
			ds_TopRiskIndicatorsGroupK := CHOOSEN(SORT(ds_TrueRiskIndicatorsGroupK,risk_indicator_priority),1);
			ds_TopRiskIndicatorsGroupL := CHOOSEN(SORT(ds_TrueRiskIndicatorsGroupL,risk_indicator_priority),1);

			ds_TopRiskIndicatorsEmpty := 
				DATASET(
					[
						{'00',FALSE,'E',99},{'00',FALSE,'E',99},{'00',FALSE,'E',99},{'00',FALSE,'E',99},
						{'00',FALSE,'E',99},{'00',FALSE,'E',99},{'00',FALSE,'E',99},{'00',FALSE,'E',99}
					], 
					layout_RiskIndicators_temp
				);
	
			ds_TopRiskIndicators := 
				choosen (SORT( 
           (ds_TopRiskIndicatorsGroupA + ds_TopRiskIndicatorsGroupB + ds_TopRiskIndicatorsGroupC + ds_TopRiskIndicatorsGroupD + 
            ds_TopRiskIndicatorsGroupE + ds_TopRiskIndicatorsGroupN + ds_TopRiskIndicatorsGroupM + ds_TopRiskIndicatorsGroupF +
					  ds_TopRiskIndicatorsGroupG + ds_TopRiskIndicatorsGroupH + ds_TopRiskIndicatorsGroupI + ds_TopRiskIndicatorsGroupJ +  
					  ds_TopRiskIndicatorsGroupK + ds_TopRiskIndicatorsGroupL + ds_TopRiskIndicatorsEmpty),
            risk_indicator_priority),
				num_reasons
        );
 
    
  

TopWarningCodes := PROJECT(ds_TopRiskIndicators, TRANSFORM(HRILayout,
																							SELF.hri := LEFT.risk_indicator_code
																							
              ));
              
              
                   
                    bbfm_wc1 := TopWarningCodes[1].hri;
                    bbfm_wc2 := TopWarningCodes[2].hri;
                    bbfm_wc3 := TopWarningCodes[3].hri;
                    bbfm_wc4 := TopWarningCodes[4].hri;
                    






//*************************************************************************************//
//     End Generated ECL Code
//*************************************************************************************//
 #if(MODEL_DEBUG) 
              
           
                 
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
                    self.sysdate                          := sysdate;
                    self.wc10p                            := wc10p;
                    self.wc11b                            := wc11b;
                    self.wc12b                            := wc12b;
                    self.wc13b                            := wc13b;
                    self.wc14b                            := wc14b;
                    self.wc15p                            := wc15p;
                    self.wc16p                            := wc16p;
                    self.wc17p                            := wc17p;
                    self.wc18p                            := wc18p;
                    self.wc19p                            := wc19p;
                    self.wc20p                            := wc20p;
                    self.wc21p                            := wc21p;
                    self.wc22p                            := wc22p;
                    self.wc23b                            := wc23b;
                    self.wc24b                            := wc24b;
                    self._sum_bureau                      := _sum_bureau;
                    self._sum_credentialed                := _sum_credentialed;
                    self._sum_other                       := _sum_other;
                    self.num_sources                      := num_sources;
                    self.wc25p                            := wc25p;
                    self.wc26p                            := wc26p;
                    self._earliest_bureau_date            := _earliest_bureau_date;
                    self.earliest_bureau_date             := earliest_bureau_date;
                    self.wc27p                            := wc27p;
                    self._earliest_header_date            := _earliest_header_date;
                    self.earliest_header_date             := earliest_header_date;
                    self.wc28p                            := wc28p;
                    self.wc29p                            := wc29p;
                    self.wc30b                            := wc30b;
                    self.wc31p                            := wc31p;
                    self.wc32p                            := wc32p;
                    self.wc33p                            := wc33p;
                    self.wc34b                            := wc34b;
                    self.wc35p                            := wc35p;
                    self.wc36p                            := wc36p;
                    self.wc37p                            := wc37p;
                    self.wc38p                            := wc38p;
                    self.wc39p                            := wc39p;
                    self.wc40p                            := wc40p;
                    self.wc41p                            := wc41p;
                    self.wc42p                            := wc42p;
                    self.wc43b                            := wc43b;
                    self.wc44p                            := wc44p;
                    self.wc45b                            := wc45b;
                    self.wc46b                            := wc46b;
                    self.wc47p                            := wc47p;
                    self.wc48p                            := wc48p;
                    self.wc49b                            := wc49b;
                    self.wc50p                            := wc50p;
                    self.wc51b                            := wc51b;
                    self.wc52b                            := wc52b;
                    self.wc53b                            := wc53b;
                    self.wc54b                            := wc54b;
                    self.wc55p                            := wc55p;
                    self.wc56b                            := wc56b;
                    self.wc57p                            := wc57p;
                    self.wc58b                            := wc58b;
                    self.wc59b                            := wc59b;
                    self.wc60b                            := wc60b;
                    self.wc61b                            := wc61b;
                    self.wc62b                            := wc62b;
                    self.wc63b                            := wc63b;
                    self.wc64p                            := wc64p;
                    self.wc65b                            := wc65b;
                    self.wc66p                            := wc66p;
                    self.wc67p                            := wc67p;
                    self.wc68p                            := wc68p;
                    self.wc69b                            := wc69b;
                    self.wc70b                            := wc70b;
                    self.wc71b                            := wc71b;
                    self.wc72b                            := wc72b;
                    self.wc73p                            := wc73p;
                    self.wc74p                            := wc74p;
                    self.wc75b                            := wc75b;
                    self.wc76b                            := wc76b;
                    self.wc77b                            := wc77b;
                    self.wc78b                            := wc78b;
                    self.wc79p                            := wc79p;
                    self.wc80p                            := wc80p;
                    self.wc81p                            := wc81p;
                    self.wc82p                            := wc82p;
                    self.wc83p                            := wc83p;
                    self.clam                              :=le.clam;
                    self.Busshell                        := le.Busshell ;
                    self.bbfm_wc1                         := bbfm_wc1;
                    self.bbfm_wc2                         := bbfm_wc2;
                    self.bbfm_wc3                         := bbfm_wc3;
                    self.bbfm_wc4                         := bbfm_wc4;
                  //  SELF.clam                             := ri;
									//	SELF.busShell                         := le;
                    self.HRIs                             := TopWarningCodes;
         

#else
self.HRIs := TopWarningCodes;
        
#end 
END;
model := project(busshellplusclam, doModel(left));

return model;
END;
                
                
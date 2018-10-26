import risk_indicators, ut, riskwisefcra, riskwise, std, riskview;

export RVB1104_1_0(  grouped dataset(risk_indicators.Layout_Boca_Shell) clamPre, BOOLEAN isCalifornia = FALSE, BOOLEAN isFCRA = TRUE) := FUNCTION

	msa_bocashell := RECORD
		risk_indicators.Layout_Boca_Shell;
		string50 msa;
	end;

	clam := join(clamPre, Models.Key_MSA_Zip_Lookup(isFCRA), KEYED(left.shell_input.z5 = right.zip), 
							  TRANSFORM(msa_bocashell, self.msa:= right.msa, self:=left),
								left outer, keep(1));	
	
	
	RVB_DEBUG := false;

	#if(RVB_DEBUG)
		debug_layout := record
                real                   sysdate                          ;
                real                   sysyear                          ;
                real                   in_dob2                          ;
                real                   yr_in_dob                        ;
                real                   mth_in_dob                       ;
                real                   add1_date_first_seen2            ;
                real                   yr_add1_date_first_seen          ;
                real                   mth_add1_date_first_seen         ;
                real                   gong_did_first_seen2             ;
                real                   yr_gong_did_first_seen           ;
                real                   mth_gong_did_first_seen          ;
                real                   header_first_seen2               ;
                real                   yr_header_first_seen             ;
                real                   mth_header_first_seen            ;
                real                   ver_src_cnt                      ;
                boolean                ver_src_pop                      ;
                string                 ver_src_fsrc                     ;
                string                 ver_src_fsrc_fdate               ;
                real                   ver_src_fsrc_fdate2              ;
                real                   yr_ver_src_fsrc_fdate            ;
                real                   mth_ver_src_fsrc_fdate           ;
                real                   ver_src_ak_pos                   ;
                boolean                ver_src_ak                       ;
                string                 ver_src_fdate_ak                 ;
                real                   ver_src_fdate_ak2                ;
                real                   yr_ver_src_fdate_ak              ;
                real                   mth_ver_src_fdate_ak             ;
                string                 ver_src_ldate_ak                 ;
                real                   ver_src_ldate_ak2                ;
                real                   yr_ver_src_ldate_ak              ;
                real                   mth_ver_src_ldate_ak             ;
                real                   ver_src_cnt_ak                   ;
                real                   ver_src_am_pos                   ;
                boolean                ver_src_am                       ;
                string                 ver_src_fdate_am                 ;
                real                   ver_src_fdate_am2                ;
                real                   yr_ver_src_fdate_am              ;
                real                   mth_ver_src_fdate_am             ;
                string                 ver_src_ldate_am                 ;
                real                   ver_src_ldate_am2                ;
                real                   yr_ver_src_ldate_am              ;
                real                   mth_ver_src_ldate_am             ;
                real                   ver_src_cnt_am                   ;
                real                   ver_src_ar_pos                   ;
                boolean                ver_src_ar                       ;
                string                 ver_src_fdate_ar                 ;
                real                   ver_src_fdate_ar2                ;
                real                   yr_ver_src_fdate_ar              ;
                real                   mth_ver_src_fdate_ar             ;
                string                 ver_src_ldate_ar                 ;
                real                   ver_src_ldate_ar2                ;
                real                   yr_ver_src_ldate_ar              ;
                real                   mth_ver_src_ldate_ar             ;
                real                   ver_src_cnt_ar                   ;
                real                   ver_src_ba_pos                   ;
                boolean                ver_src_ba                       ;
                string                 ver_src_fdate_ba                 ;
                real                   ver_src_fdate_ba2                ;
                real                   yr_ver_src_fdate_ba              ;
                real                   mth_ver_src_fdate_ba             ;
                string                 ver_src_ldate_ba                 ;
                real                   ver_src_ldate_ba2                ;
                real                   yr_ver_src_ldate_ba              ;
                real                   mth_ver_src_ldate_ba             ;
                real                   ver_src_cnt_ba                   ;
                real                   ver_src_cg_pos                   ;
                boolean                ver_src_cg                       ;
                string                 ver_src_fdate_cg                 ;
                real                   ver_src_fdate_cg2                ;
                real                   yr_ver_src_fdate_cg              ;
                real                   mth_ver_src_fdate_cg             ;
                string                 ver_src_ldate_cg                 ;
                real                   ver_src_ldate_cg2                ;
                real                   yr_ver_src_ldate_cg              ;
                real                   mth_ver_src_ldate_cg             ;
                real                   ver_src_cnt_cg                   ;
                real                   ver_src_co_pos                   ;
                boolean                ver_src_co                       ;
                string                 ver_src_fdate_co                 ;
                real                   ver_src_fdate_co2                ;
                real                   yr_ver_src_fdate_co              ;
                real                   mth_ver_src_fdate_co             ;
                string                 ver_src_ldate_co                 ;
                real                   ver_src_ldate_co2                ;
                real                   yr_ver_src_ldate_co              ;
                real                   mth_ver_src_ldate_co             ;
                real                   ver_src_cnt_co                   ;
                real                   ver_src_cy_pos                   ;
                boolean                ver_src_cy                       ;
                string                 ver_src_fdate_cy                 ;
                real                   ver_src_fdate_cy2                ;
                real                   yr_ver_src_fdate_cy              ;
                real                   mth_ver_src_fdate_cy             ;
                string                 ver_src_ldate_cy                 ;
                real                   ver_src_ldate_cy2                ;
                real                   yr_ver_src_ldate_cy              ;
                real                   mth_ver_src_ldate_cy             ;
                real                   ver_src_cnt_cy                   ;
                real                   ver_src_da_pos                   ;
                boolean                ver_src_da                       ;
                string                 ver_src_fdate_da                 ;
                real                   ver_src_fdate_da2                ;
                real                   yr_ver_src_fdate_da              ;
                real                   mth_ver_src_fdate_da             ;
                string                 ver_src_ldate_da                 ;
                real                   ver_src_ldate_da2                ;
                real                   yr_ver_src_ldate_da              ;
                real                   mth_ver_src_ldate_da             ;
                real                   ver_src_cnt_da                   ;
                real                   ver_src_d_pos                    ;
                boolean                ver_src_d                        ;
                string                 ver_src_fdate_d                  ;
                real                   ver_src_fdate_d2                 ;
                real                   yr_ver_src_fdate_d               ;
                real                   mth_ver_src_fdate_d              ;
                string                 ver_src_ldate_d                  ;
                real                   ver_src_ldate_d2                 ;
                real                   yr_ver_src_ldate_d               ;
                real                   mth_ver_src_ldate_d              ;
                real                   ver_src_cnt_d                    ;
                real                   ver_src_dl_pos                   ;
                boolean                ver_src_dl                       ;
                string                 ver_src_fdate_dl                 ;
                real                   ver_src_fdate_dl2                ;
                real                   yr_ver_src_fdate_dl              ;
                real                   mth_ver_src_fdate_dl             ;
                string                 ver_src_ldate_dl                 ;
                real                   ver_src_ldate_dl2                ;
                real                   yr_ver_src_ldate_dl              ;
                real                   mth_ver_src_ldate_dl             ;
                real                   ver_src_cnt_dl                   ;
                real                   ver_src_ds_pos                   ;
                boolean                ver_src_ds                       ;
                string                 ver_src_fdate_ds                 ;
                real                   ver_src_fdate_ds2                ;
                real                   yr_ver_src_fdate_ds              ;
                real                   mth_ver_src_fdate_ds             ;
                string                 ver_src_ldate_ds                 ;
                real                   ver_src_ldate_ds2                ;
                real                   yr_ver_src_ldate_ds              ;
                real                   mth_ver_src_ldate_ds             ;
                real                   ver_src_cnt_ds                   ;
                real                   ver_src_de_pos                   ;
                boolean                ver_src_de                       ;
                string                 ver_src_fdate_de                 ;
                real                   ver_src_fdate_de2                ;
                real                   yr_ver_src_fdate_de              ;
                real                   mth_ver_src_fdate_de             ;
                string                 ver_src_ldate_de                 ;
                real                   ver_src_ldate_de2                ;
                real                   yr_ver_src_ldate_de              ;
                real                   mth_ver_src_ldate_de             ;
                real                   ver_src_cnt_de                   ;
                real                   ver_src_eb_pos                   ;
                boolean                ver_src_eb                       ;
                string                 ver_src_fdate_eb                 ;
                real                   ver_src_fdate_eb2                ;
                real                   yr_ver_src_fdate_eb              ;
                real                   mth_ver_src_fdate_eb             ;
                string                 ver_src_ldate_eb                 ;
                real                   ver_src_ldate_eb2                ;
                real                   yr_ver_src_ldate_eb              ;
                real                   mth_ver_src_ldate_eb             ;
                real                   ver_src_cnt_eb                   ;
                real                   ver_src_em_pos                   ;
                boolean                ver_src_em                       ;
                string                 ver_src_fdate_em                 ;
                real                   ver_src_fdate_em2                ;
                real                   yr_ver_src_fdate_em              ;
                real                   mth_ver_src_fdate_em             ;
                string                 ver_src_ldate_em                 ;
                real                   ver_src_ldate_em2                ;
                real                   yr_ver_src_ldate_em              ;
                real                   mth_ver_src_ldate_em             ;
                real                   ver_src_cnt_em                   ;
                real                   ver_src_e1_pos                   ;
                boolean                ver_src_e1                       ;
                string                 ver_src_fdate_e1                 ;
                real                   ver_src_fdate_e12                ;
                real                   yr_ver_src_fdate_e1              ;
                real                   mth_ver_src_fdate_e1             ;
                string                 ver_src_ldate_e1                 ;
                real                   ver_src_ldate_e12                ;
                real                   yr_ver_src_ldate_e1              ;
                real                   mth_ver_src_ldate_e1             ;
                real                   ver_src_cnt_e1                   ;
                real                   ver_src_e2_pos                   ;
                boolean                ver_src_e2                       ;
                string                 ver_src_fdate_e2                 ;
                real                   ver_src_fdate_e22                ;
                real                   yr_ver_src_fdate_e2              ;
                real                   mth_ver_src_fdate_e2             ;
                string                 ver_src_ldate_e2                 ;
                real                   ver_src_ldate_e22                ;
                real                   yr_ver_src_ldate_e2              ;
                real                   mth_ver_src_ldate_e2             ;
                real                   ver_src_cnt_e2                   ;
                real                   ver_src_e3_pos                   ;
                boolean                ver_src_e3                       ;
                string                 ver_src_fdate_e3                 ;
                real                   ver_src_fdate_e32                ;
                real                   yr_ver_src_fdate_e3              ;
                real                   mth_ver_src_fdate_e3             ;
                string                 ver_src_ldate_e3                 ;
                real                   ver_src_ldate_e32                ;
                real                   yr_ver_src_ldate_e3              ;
                real                   mth_ver_src_ldate_e3             ;
                real                   ver_src_cnt_e3                   ;
                real                   ver_src_e4_pos                   ;
                boolean                ver_src_e4                       ;
                string                 ver_src_fdate_e4                 ;
                real                   ver_src_fdate_e42                ;
                real                   yr_ver_src_fdate_e4              ;
                real                   mth_ver_src_fdate_e4             ;
                string                 ver_src_ldate_e4                 ;
                real                   ver_src_ldate_e42                ;
                real                   yr_ver_src_ldate_e4              ;
                real                   mth_ver_src_ldate_e4             ;
                real                   ver_src_cnt_e4                   ;
                real                   ver_src_en_pos                   ;
                boolean                ver_src_en                       ;
                string                 ver_src_fdate_en                 ;
                real                   ver_src_fdate_en2                ;
                real                   yr_ver_src_fdate_en              ;
                real                   mth_ver_src_fdate_en             ;
                string                 ver_src_ldate_en                 ;
                real                   ver_src_ldate_en2                ;
                real                   yr_ver_src_ldate_en              ;
                real                   mth_ver_src_ldate_en             ;
                real                   ver_src_cnt_en                   ;
                real                   ver_src_eq_pos                   ;
                boolean                ver_src_eq                       ;
                string                 ver_src_fdate_eq                 ;
                real                   ver_src_fdate_eq2                ;
                real                   yr_ver_src_fdate_eq              ;
                real                   mth_ver_src_fdate_eq             ;
                string                 ver_src_ldate_eq                 ;
                real                   ver_src_ldate_eq2                ;
                real                   yr_ver_src_ldate_eq              ;
                real                   mth_ver_src_ldate_eq             ;
                real                   ver_src_cnt_eq                   ;
                real                   ver_src_fe_pos                   ;
                boolean                ver_src_fe                       ;
                string                 ver_src_fdate_fe                 ;
                real                   ver_src_fdate_fe2                ;
                real                   yr_ver_src_fdate_fe              ;
                real                   mth_ver_src_fdate_fe             ;
                string                 ver_src_ldate_fe                 ;
                real                   ver_src_ldate_fe2                ;
                real                   yr_ver_src_ldate_fe              ;
                real                   mth_ver_src_ldate_fe             ;
                real                   ver_src_cnt_fe                   ;
                real                   ver_src_ff_pos                   ;
                boolean                ver_src_ff                       ;
                string                 ver_src_fdate_ff                 ;
                real                   ver_src_fdate_ff2                ;
                real                   yr_ver_src_fdate_ff              ;
                real                   mth_ver_src_fdate_ff             ;
                string                 ver_src_ldate_ff                 ;
                real                   ver_src_ldate_ff2                ;
                real                   yr_ver_src_ldate_ff              ;
                real                   mth_ver_src_ldate_ff             ;
                real                   ver_src_cnt_ff                   ;
                real                   ver_src_fr_pos                   ;
                boolean                ver_src_fr                       ;
                string                 ver_src_fdate_fr                 ;
                real                   ver_src_fdate_fr2                ;
                real                   yr_ver_src_fdate_fr              ;
                real                   mth_ver_src_fdate_fr             ;
                string                 ver_src_ldate_fr                 ;
                real                   ver_src_ldate_fr2                ;
                real                   yr_ver_src_ldate_fr              ;
                real                   mth_ver_src_ldate_fr             ;
                real                   ver_src_cnt_fr                   ;
                real                   ver_src_l2_pos                   ;
                boolean                ver_src_l2                       ;
                string                 ver_src_fdate_l2                 ;
                real                   ver_src_fdate_l22                ;
                real                   yr_ver_src_fdate_l2              ;
                real                   mth_ver_src_fdate_l2             ;
                string                 ver_src_ldate_l2                 ;
                real                   ver_src_ldate_l22                ;
                real                   yr_ver_src_ldate_l2              ;
                real                   mth_ver_src_ldate_l2             ;
                real                   ver_src_cnt_l2                   ;
                real                   ver_src_li_pos                   ;
                boolean                ver_src_li                       ;
                string                 ver_src_fdate_li                 ;
                real                   ver_src_fdate_li2                ;
                real                   yr_ver_src_fdate_li              ;
                real                   mth_ver_src_fdate_li             ;
                string                 ver_src_ldate_li                 ;
                real                   ver_src_ldate_li2                ;
                real                   yr_ver_src_ldate_li              ;
                real                   mth_ver_src_ldate_li             ;
                real                   ver_src_cnt_li                   ;
                real                   ver_src_mw_pos                   ;
                boolean                ver_src_mw                       ;
                string                 ver_src_fdate_mw                 ;
                real                   ver_src_fdate_mw2                ;
                real                   yr_ver_src_fdate_mw              ;
                real                   mth_ver_src_fdate_mw             ;
                string                 ver_src_ldate_mw                 ;
                real                   ver_src_ldate_mw2                ;
                real                   yr_ver_src_ldate_mw              ;
                real                   mth_ver_src_ldate_mw             ;
                real                   ver_src_cnt_mw                   ;
                real                   ver_src_nt_pos                   ;
                boolean                ver_src_nt                       ;
                string                 ver_src_fdate_nt                 ;
                real                   ver_src_fdate_nt2                ;
                real                   yr_ver_src_fdate_nt              ;
                real                   mth_ver_src_fdate_nt             ;
                string                 ver_src_ldate_nt                 ;
                real                   ver_src_ldate_nt2                ;
                real                   yr_ver_src_ldate_nt              ;
                real                   mth_ver_src_ldate_nt             ;
                real                   ver_src_cnt_nt                   ;
                real                   ver_src_p_pos                    ;
                boolean                ver_src_p                        ;
                string                 ver_src_fdate_p                  ;
                real                   ver_src_fdate_p2                 ;
                real                   yr_ver_src_fdate_p               ;
                real                   mth_ver_src_fdate_p              ;
                string                 ver_src_ldate_p                  ;
                real                   ver_src_ldate_p2                 ;
                real                   yr_ver_src_ldate_p               ;
                real                   mth_ver_src_ldate_p              ;
                real                   ver_src_cnt_p                    ;
                real                   ver_src_pl_pos                   ;
                boolean                ver_src_pl                       ;
                string                 ver_src_fdate_pl                 ;
                real                   ver_src_fdate_pl2                ;
                real                   yr_ver_src_fdate_pl              ;
                real                   mth_ver_src_fdate_pl             ;
                string                 ver_src_ldate_pl                 ;
                real                   ver_src_ldate_pl2                ;
                real                   yr_ver_src_ldate_pl              ;
                real                   mth_ver_src_ldate_pl             ;
                real                   ver_src_cnt_pl                   ;
                real                   ver_src_ts_pos                   ;
                boolean                ver_src_ts                       ;
                string                 ver_src_fdate_ts                 ;
                real                   ver_src_fdate_ts2                ;
                real                   yr_ver_src_fdate_ts              ;
                real                   mth_ver_src_fdate_ts             ;
                string                 ver_src_ldate_ts                 ;
                real                   ver_src_ldate_ts2                ;
                real                   yr_ver_src_ldate_ts              ;
                real                   mth_ver_src_ldate_ts             ;
                real                   ver_src_cnt_ts                   ;
                real                   ver_src_tu_pos                   ;
                boolean                ver_src_tu                       ;
                string                 ver_src_fdate_tu                 ;
                real                   ver_src_fdate_tu2                ;
                real                   yr_ver_src_fdate_tu              ;
                real                   mth_ver_src_fdate_tu             ;
                string                 ver_src_ldate_tu                 ;
                real                   ver_src_ldate_tu2                ;
                real                   yr_ver_src_ldate_tu              ;
                real                   mth_ver_src_ldate_tu             ;
                real                   ver_src_cnt_tu                   ;
                real                   ver_src_sl_pos                   ;
                boolean                ver_src_sl                       ;
                string                 ver_src_fdate_sl                 ;
                real                   ver_src_fdate_sl2                ;
                real                   yr_ver_src_fdate_sl              ;
                real                   mth_ver_src_fdate_sl             ;
                string                 ver_src_ldate_sl                 ;
                real                   ver_src_ldate_sl2                ;
                real                   yr_ver_src_ldate_sl              ;
                real                   mth_ver_src_ldate_sl             ;
                real                   ver_src_cnt_sl                   ;
                real                   ver_src_v_pos                    ;
                boolean                ver_src_v                        ;
                string                 ver_src_fdate_v                  ;
                real                   ver_src_fdate_v2                 ;
                real                   yr_ver_src_fdate_v               ;
                real                   mth_ver_src_fdate_v              ;
                string                 ver_src_ldate_v                  ;
                real                   ver_src_ldate_v2                 ;
                real                   yr_ver_src_ldate_v               ;
                real                   mth_ver_src_ldate_v              ;
                real                   ver_src_cnt_v                    ;
                real                   ver_src_vo_pos                   ;
                boolean                ver_src_vo                       ;
                string                 ver_src_fdate_vo                 ;
                real                   ver_src_fdate_vo2                ;
                real                   yr_ver_src_fdate_vo              ;
                real                   mth_ver_src_fdate_vo             ;
                string                 ver_src_ldate_vo                 ;
                real                   ver_src_ldate_vo2                ;
                real                   yr_ver_src_ldate_vo              ;
                real                   mth_ver_src_ldate_vo             ;
                real                   ver_src_cnt_vo                   ;
                real                   ver_src_w_pos                    ;
                boolean                ver_src_w                        ;
                string                 ver_src_fdate_w                  ;
                real                   ver_src_fdate_w2                 ;
                real                   yr_ver_src_fdate_w               ;
                real                   mth_ver_src_fdate_w              ;
                string                 ver_src_ldate_w                  ;
                real                   ver_src_ldate_w2                 ;
                real                   yr_ver_src_ldate_w               ;
                real                   mth_ver_src_ldate_w              ;
                real                   ver_src_cnt_w                    ;
                real                   ver_src_wp_pos                   ;
                boolean                ver_src_wp                       ;
                string                 ver_src_fdate_wp                 ;
                real                   ver_src_fdate_wp2                ;
                real                   yr_ver_src_fdate_wp              ;
                real                   mth_ver_src_fdate_wp             ;
                string                 ver_src_ldate_wp                 ;
                real                   ver_src_ldate_wp2                ;
                real                   yr_ver_src_ldate_wp              ;
                real                   mth_ver_src_ldate_wp             ;
                real                   ver_src_cnt_wp                   ;
                // real                   ver_src_rcnt                     ;
                real                   ver_dob_src_cnt                  ;
                boolean                ver_dob_src_pop                  ;
                string                 ver_dob_src_fsrc                 ;
                string                 ver_dob_src_fsrc_fdate           ;
                real                   ver_dob_src_fsrc_fdate2          ;
                real                   yr_ver_dob_src_fsrc_fdate        ;
                real                   mth_ver_dob_src_fsrc_fdate       ;
                real                   ver_dob_src_ak_pos               ;
                boolean                ver_dob_src_ak                   ;
                string                 ver_dob_src_fdate_ak             ;
                real                   ver_dob_src_fdate_ak2            ;
                real                   yr_ver_dob_src_fdate_ak          ;
                real                   mth_ver_dob_src_fdate_ak         ;
                real                   ver_dob_src_cnt_ak               ;
                real                   ver_dob_src_am_pos               ;
                boolean                ver_dob_src_am                   ;
                string                 ver_dob_src_fdate_am             ;
                real                   ver_dob_src_fdate_am2            ;
                real                   yr_ver_dob_src_fdate_am          ;
                real                   mth_ver_dob_src_fdate_am         ;
                real                   ver_dob_src_cnt_am               ;
                real                   ver_dob_src_ar_pos               ;
                boolean                ver_dob_src_ar                   ;
                string                 ver_dob_src_fdate_ar             ;
                real                   ver_dob_src_fdate_ar2            ;
                real                   yr_ver_dob_src_fdate_ar          ;
                real                   mth_ver_dob_src_fdate_ar         ;
                real                   ver_dob_src_cnt_ar               ;
                real                   ver_dob_src_ba_pos               ;
                boolean                ver_dob_src_ba                   ;
                string                 ver_dob_src_fdate_ba             ;
                real                   ver_dob_src_fdate_ba2            ;
                real                   yr_ver_dob_src_fdate_ba          ;
                real                   mth_ver_dob_src_fdate_ba         ;
                real                   ver_dob_src_cnt_ba               ;
                real                   ver_dob_src_cg_pos               ;
                boolean                ver_dob_src_cg                   ;
                string                 ver_dob_src_fdate_cg             ;
                real                   ver_dob_src_fdate_cg2            ;
                real                   yr_ver_dob_src_fdate_cg          ;
                real                   mth_ver_dob_src_fdate_cg         ;
                real                   ver_dob_src_cnt_cg               ;
                real                   ver_dob_src_co_pos               ;
                boolean                ver_dob_src_co                   ;
                string                 ver_dob_src_fdate_co             ;
                real                   ver_dob_src_fdate_co2            ;
                real                   yr_ver_dob_src_fdate_co          ;
                real                   mth_ver_dob_src_fdate_co         ;
                real                   ver_dob_src_cnt_co               ;
                real                   ver_dob_src_cy_pos               ;
                boolean                ver_dob_src_cy                   ;
                string                 ver_dob_src_fdate_cy             ;
                real                   ver_dob_src_fdate_cy2            ;
                real                   yr_ver_dob_src_fdate_cy          ;
                real                   mth_ver_dob_src_fdate_cy         ;
                real                   ver_dob_src_cnt_cy               ;
                real                   ver_dob_src_da_pos               ;
                boolean                ver_dob_src_da                   ;
                string                 ver_dob_src_fdate_da             ;
                real                   ver_dob_src_fdate_da2            ;
                real                   yr_ver_dob_src_fdate_da          ;
                real                   mth_ver_dob_src_fdate_da         ;
                real                   ver_dob_src_cnt_da               ;
                real                   ver_dob_src_d_pos                ;
                boolean                ver_dob_src_d                    ;
                string                 ver_dob_src_fdate_d              ;
                real                   ver_dob_src_fdate_d2             ;
                real                   yr_ver_dob_src_fdate_d           ;
                real                   mth_ver_dob_src_fdate_d          ;
                real                   ver_dob_src_cnt_d                ;
                real                   ver_dob_src_dl_pos               ;
                boolean                ver_dob_src_dl                   ;
                string                 ver_dob_src_fdate_dl             ;
                real                   ver_dob_src_fdate_dl2            ;
                real                   yr_ver_dob_src_fdate_dl          ;
                real                   mth_ver_dob_src_fdate_dl         ;
                real                   ver_dob_src_cnt_dl               ;
                real                   ver_dob_src_ds_pos               ;
                boolean                ver_dob_src_ds                   ;
                string                 ver_dob_src_fdate_ds             ;
                real                   ver_dob_src_fdate_ds2            ;
                real                   yr_ver_dob_src_fdate_ds          ;
                real                   mth_ver_dob_src_fdate_ds         ;
                real                   ver_dob_src_cnt_ds               ;
                real                   ver_dob_src_de_pos               ;
                boolean                ver_dob_src_de                   ;
                string                 ver_dob_src_fdate_de             ;
                real                   ver_dob_src_fdate_de2            ;
                real                   yr_ver_dob_src_fdate_de          ;
                real                   mth_ver_dob_src_fdate_de         ;
                real                   ver_dob_src_cnt_de               ;
                real                   ver_dob_src_eb_pos               ;
                boolean                ver_dob_src_eb                   ;
                string                 ver_dob_src_fdate_eb             ;
                real                   ver_dob_src_fdate_eb2            ;
                real                   yr_ver_dob_src_fdate_eb          ;
                real                   mth_ver_dob_src_fdate_eb         ;
                real                   ver_dob_src_cnt_eb               ;
                real                   ver_dob_src_em_pos               ;
                boolean                ver_dob_src_em                   ;
                string                 ver_dob_src_fdate_em             ;
                real                   ver_dob_src_fdate_em2            ;
                real                   yr_ver_dob_src_fdate_em          ;
                real                   mth_ver_dob_src_fdate_em         ;
                real                   ver_dob_src_cnt_em               ;
                real                   ver_dob_src_e1_pos               ;
                boolean                ver_dob_src_e1                   ;
                string                 ver_dob_src_fdate_e1             ;
                real                   ver_dob_src_fdate_e12            ;
                real                   yr_ver_dob_src_fdate_e1          ;
                real                   mth_ver_dob_src_fdate_e1         ;
                real                   ver_dob_src_cnt_e1               ;
                real                   ver_dob_src_e2_pos               ;
                boolean                ver_dob_src_e2                   ;
                string                 ver_dob_src_fdate_e2             ;
                real                   ver_dob_src_fdate_e22            ;
                real                   yr_ver_dob_src_fdate_e2          ;
                real                   mth_ver_dob_src_fdate_e2         ;
                real                   ver_dob_src_cnt_e2               ;
                real                   ver_dob_src_e3_pos               ;
                boolean                ver_dob_src_e3                   ;
                string                 ver_dob_src_fdate_e3             ;
                real                   ver_dob_src_fdate_e32            ;
                real                   yr_ver_dob_src_fdate_e3          ;
                real                   mth_ver_dob_src_fdate_e3         ;
                real                   ver_dob_src_cnt_e3               ;
                real                   ver_dob_src_e4_pos               ;
                boolean                ver_dob_src_e4                   ;
                string                 ver_dob_src_fdate_e4             ;
                real                   ver_dob_src_fdate_e42            ;
                real                   yr_ver_dob_src_fdate_e4          ;
                real                   mth_ver_dob_src_fdate_e4         ;
                real                   ver_dob_src_cnt_e4               ;
                real                   ver_dob_src_en_pos               ;
                boolean                ver_dob_src_en                   ;
                string                 ver_dob_src_fdate_en             ;
                real                   ver_dob_src_fdate_en2            ;
                real                   yr_ver_dob_src_fdate_en          ;
                real                   mth_ver_dob_src_fdate_en         ;
                real                   ver_dob_src_cnt_en               ;
                real                   ver_dob_src_eq_pos               ;
                boolean                ver_dob_src_eq                   ;
                string                 ver_dob_src_fdate_eq             ;
                real                   ver_dob_src_fdate_eq2            ;
                real                   yr_ver_dob_src_fdate_eq          ;
                real                   mth_ver_dob_src_fdate_eq         ;
                real                   ver_dob_src_cnt_eq               ;
                real                   ver_dob_src_fe_pos               ;
                boolean                ver_dob_src_fe                   ;
                string                 ver_dob_src_fdate_fe             ;
                real                   ver_dob_src_fdate_fe2            ;
                real                   yr_ver_dob_src_fdate_fe          ;
                real                   mth_ver_dob_src_fdate_fe         ;
                real                   ver_dob_src_cnt_fe               ;
                real                   ver_dob_src_ff_pos               ;
                boolean                ver_dob_src_ff                   ;
                string                 ver_dob_src_fdate_ff             ;
                real                   ver_dob_src_fdate_ff2            ;
                real                   yr_ver_dob_src_fdate_ff          ;
                real                   mth_ver_dob_src_fdate_ff         ;
                real                   ver_dob_src_cnt_ff               ;
                real                   ver_dob_src_fr_pos               ;
                boolean                ver_dob_src_fr                   ;
                string                 ver_dob_src_fdate_fr             ;
                real                   ver_dob_src_fdate_fr2            ;
                real                   yr_ver_dob_src_fdate_fr          ;
                real                   mth_ver_dob_src_fdate_fr         ;
                real                   ver_dob_src_cnt_fr               ;
                real                   ver_dob_src_l2_pos               ;
                boolean                ver_dob_src_l2                   ;
                string                 ver_dob_src_fdate_l2             ;
                real                   ver_dob_src_fdate_l22            ;
                real                   yr_ver_dob_src_fdate_l2          ;
                real                   mth_ver_dob_src_fdate_l2         ;
                real                   ver_dob_src_cnt_l2               ;
                real                   ver_dob_src_li_pos               ;
                boolean                ver_dob_src_li                   ;
                string                 ver_dob_src_fdate_li             ;
                real                   ver_dob_src_fdate_li2            ;
                real                   yr_ver_dob_src_fdate_li          ;
                real                   mth_ver_dob_src_fdate_li         ;
                real                   ver_dob_src_cnt_li               ;
                real                   ver_dob_src_mw_pos               ;
                boolean                ver_dob_src_mw                   ;
                string                 ver_dob_src_fdate_mw             ;
                real                   ver_dob_src_fdate_mw2            ;
                real                   yr_ver_dob_src_fdate_mw          ;
                real                   mth_ver_dob_src_fdate_mw         ;
                real                   ver_dob_src_cnt_mw               ;
                real                   ver_dob_src_nt_pos               ;
                boolean                ver_dob_src_nt                   ;
                string                 ver_dob_src_fdate_nt             ;
                real                   ver_dob_src_fdate_nt2            ;
                real                   yr_ver_dob_src_fdate_nt          ;
                real                   mth_ver_dob_src_fdate_nt         ;
                real                   ver_dob_src_cnt_nt               ;
                real                   ver_dob_src_p_pos                ;
                boolean                ver_dob_src_p                    ;
                string                 ver_dob_src_fdate_p              ;
                real                   ver_dob_src_fdate_p2             ;
                real                   yr_ver_dob_src_fdate_p           ;
                real                   mth_ver_dob_src_fdate_p          ;
                real                   ver_dob_src_cnt_p                ;
                real                   ver_dob_src_pl_pos               ;
                boolean                ver_dob_src_pl                   ;
                string                 ver_dob_src_fdate_pl             ;
                real                   ver_dob_src_fdate_pl2            ;
                real                   yr_ver_dob_src_fdate_pl          ;
                real                   mth_ver_dob_src_fdate_pl         ;
                real                   ver_dob_src_cnt_pl               ;
                real                   ver_dob_src_ts_pos               ;
                boolean                ver_dob_src_ts                   ;
                string                 ver_dob_src_fdate_ts             ;
                real                   ver_dob_src_fdate_ts2            ;
                real                   yr_ver_dob_src_fdate_ts          ;
                real                   mth_ver_dob_src_fdate_ts         ;
                real                   ver_dob_src_cnt_ts               ;
                real                   ver_dob_src_tu_pos               ;
                boolean                ver_dob_src_tu                   ;
                string                 ver_dob_src_fdate_tu             ;
                real                   ver_dob_src_fdate_tu2            ;
                real                   yr_ver_dob_src_fdate_tu          ;
                real                   mth_ver_dob_src_fdate_tu         ;
                real                   ver_dob_src_cnt_tu               ;
                real                   ver_dob_src_sl_pos               ;
                boolean                ver_dob_src_sl                   ;
                string                 ver_dob_src_fdate_sl             ;
                real                   ver_dob_src_fdate_sl2            ;
                real                   yr_ver_dob_src_fdate_sl          ;
                real                   mth_ver_dob_src_fdate_sl         ;
                real                   ver_dob_src_cnt_sl               ;
                real                   ver_dob_src_v_pos                ;
                boolean                ver_dob_src_v                    ;
                string                 ver_dob_src_fdate_v              ;
                real                   ver_dob_src_fdate_v2             ;
                real                   yr_ver_dob_src_fdate_v           ;
                real                   mth_ver_dob_src_fdate_v          ;
                real                   ver_dob_src_cnt_v                ;
                real                   ver_dob_src_vo_pos               ;
                boolean                ver_dob_src_vo                   ;
                string                 ver_dob_src_fdate_vo             ;
                real                   ver_dob_src_fdate_vo2            ;
                real                   yr_ver_dob_src_fdate_vo          ;
                real                   mth_ver_dob_src_fdate_vo         ;
                real                   ver_dob_src_cnt_vo               ;
                real                   ver_dob_src_w_pos                ;
                boolean                ver_dob_src_w                    ;
                string                 ver_dob_src_fdate_w              ;
                real                   ver_dob_src_fdate_w2             ;
                real                   yr_ver_dob_src_fdate_w           ;
                real                   mth_ver_dob_src_fdate_w          ;
                real                   ver_dob_src_cnt_w                ;
                real                   ver_dob_src_wp_pos               ;
                boolean                ver_dob_src_wp                   ;
                string                 ver_dob_src_fdate_wp             ;
                real                   ver_dob_src_fdate_wp2            ;
                real                   yr_ver_dob_src_fdate_wp          ;
                real                   mth_ver_dob_src_fdate_wp         ;
                real                   ver_dob_src_cnt_wp               ;
                // real                   ver_dob_src_rcnt                 ;
                real                   email_src_cnt                    ;
                boolean                email_src_pop                    ;
                string                 email_src_fsrc                   ;
                string                 email_src_fsrc_fdate             ;
                real                   email_src_fsrc_fdate2            ;
                real                   yr_email_src_fsrc_fdate          ;
                real                   mth_email_src_fsrc_fdate         ;
                real                   email_src_aw_pos                 ;
                boolean                email_src_aw                     ;
                string                 email_src_fdate_aw               ;
                real                   email_src_fdate_aw2              ;
                real                   yr_email_src_fdate_aw            ;
                real                   mth_email_src_fdate_aw           ;
                real                   email_src_cnt_aw                 ;
                real                   email_src_et_pos                 ;
                boolean                email_src_et                     ;
                string                 email_src_fdate_et               ;
                real                   email_src_fdate_et2              ;
                real                   yr_email_src_fdate_et            ;
                real                   mth_email_src_fdate_et           ;
                real                   email_src_cnt_et                 ;
                real                   email_src_im_pos                 ;
                string                 email_src_fdate_im               ;
                real                   email_src_fdate_im2              ;
                real                   yr_email_src_fdate_im            ;
                real                   mth_email_src_fdate_im           ;
                real                   email_src_cnt_im                 ;
                real                   email_src_wa_pos                 ;
                boolean                email_src_wa                     ;
                string                 email_src_fdate_wa               ;
                real                   email_src_fdate_wa2              ;
                real                   yr_email_src_fdate_wa            ;
                real                   mth_email_src_fdate_wa           ;
                real                   email_src_cnt_wa                 ;
                real                   email_src_om_pos                 ;
                boolean                email_src_om                     ;
                string                 email_src_fdate_om               ;
                real                   email_src_fdate_om2              ;
                real                   yr_email_src_fdate_om            ;
                real                   mth_email_src_fdate_om           ;
                real                   email_src_cnt_om                 ;
                real                   email_src_m1_pos                 ;
                boolean                email_src_m1                     ;
                string                 email_src_fdate_m1               ;
                real                   email_src_fdate_m12              ;
                real                   yr_email_src_fdate_m1            ;
                real                   mth_email_src_fdate_m1           ;
                real                   email_src_cnt_m1                 ;
                // real                   email_src_rcnt                   ;
                string                 add_ec1                          ;
                string                 add_ec3                          ;
                string                 add_ec4                          ;
                Boolean                add_apt                          ;
                Boolean                phn_disconnected                 ;
                Boolean                phn_inval                        ;
                Boolean                phn_highrisk2                    ;
                Boolean                phn_notpots                      ;
                Boolean                phn_cell                         ;
                Boolean                phn_zipmismatch                  ;
                Boolean                phn_business                     ;
                Boolean                ssn_issued18                     ;
                Boolean                ssn_deceased                     ;
                Boolean                ssn_adl_prob                     ;
                real                   email_src_im                     ;
                Boolean                impulse_flag                     ;
                Boolean                bk_flag                          ;
                Boolean                lien_rec_unrel_flag              ;
                Boolean                lien_hist_unrel_flag             ;
                Boolean                lien_flag                        ;
                real                   pk_property_owner                ;
                real                   pk_impulse_count                 ;
                real                   pk_yr_in_dob                     ;
                real                   pk_age_estimate                  ;
                real                   bs_attr_derog_flag               ;
                real                   bs_attr_eviction_flag            ;
                real                   bs_attr_derog_flag2              ;
                real                   pk_222_flag                      ;
                string                 pk_segment_40                    ;
                real                   pk_age_estimate_s0               ;
                real                   pk_age_estimate_s1               ;
                real                   pk_age_estimate_s2               ;
                real                   pk_age_estimate_s3               ;
                real                   pk_estimated_income_s0           ;
                real                   pk_estimated_income_s1           ;
                real                   pk_estimated_income_s2           ;
                real                   pk_estimated_income_s3           ;
                real                   pk_add1_avm_auto_val_s0          ;
                real                   pk_add1_avm_auto_val_s1          ;
                real                   pk_add1_avm_auto_val_s2          ;
                real                   pk_add1_avm_auto_val_s3          ;
                real                   pk_verx_s0                       ;
                real                   pk_verx_s1                       ;
                real                   pk_verx_s3                       ;
                real                   inq_first_log_date2              ;
                real                   yr_inq_first_log_date            ;
                real                   mth_inq_first_log_date           ;
                real                   pk_mth_inq_first_log_date        ;
                real                   pk_inq_recent_lvl                ;
                real                   pk_inq_recent_lvl_s0             ;
                real                   pk_inq_recent_lvl_s1             ;
                real                   pk_inq_recent_lvl_s3             ;
                real                   pk_mth_inq_frst_log_dt2_s2       ;
                real                   pk_impulse_flag                  ;
                real                   pk_inq_peradl                    ;
                real                   pk_inq_peradl_s0                 ;
                real                   pk_inq_peraddr                   ;
                real                   pk_inq_adlsperphone              ;
                real                   pk_inq_adlsperphone_s0           ;
                real                   pk_inq_adlsperphone_s3           ;
                real                   pk_mth_header_first_seen         ;
                real                   pk_mth_hdr_frst_sn_s2            ;
                real                   pk_dob_ver                       ;
                real                   pk_attr_total_number_derogs      ;
                real                   pk_crim_fel_flag                 ;
                real                   pk_eviction_lvl                  ;
                real                   pk_unrel_lien_lvl                ;
                real                   pk_adlperssn_count_s1            ;
                real                   pk_adlperssn_count_s3            ;
                real                   pk_ssns_per_adl_s1               ;
                real                   pk_ssns_per_adl_s2               ;
                real                   pk_ssns_per_adl_s3               ;
                real                   pk_addrs_per_ssn_c6_s0           ;
                real                   pk_addrs_per_ssn_c6_s1           ;
                real                   pk_addrs_per_ssn_c6_s2           ;
                real                   pk_addrs_per_ssn_c6_s3           ;
                real                   pk_ssns_per_adl_c6               ;
                real                   pk_phones_per_adl_c6_s3          ;
                real                   pk_adls_per_addr_c6_s2           ;
                real                   pk_ssns_per_addr_c6_s0           ;
                real                   pk_ssns_per_addr_c6_s1           ;
                real                   pk_ssns_per_addr_c6_s3           ;
                real                   pk_phones_per_addr_c6            ;
                real                   pk_adls_per_phone_c6             ;
                real                   pk_attr_addrs_last12_s1          ;
                real                   pk_attr_addrs_last24_s0          ;
                real                   pk_attr_addrs_last36_s2          ;
                real                   pk_attr_addrs_last36_s3          ;
                real                   pk_recent_addr_s0                ;
                real                   pk_recent_addr_s2                ;
                real                   pk_phones_per_adl_s0             ;
                real                   pk_ssns_per_addr                 ;
                real                   pk_phones_per_addr_s0            ;
                real                   pk_phones_per_addr_s2            ;
                real                   pk_phones_per_addr_s3            ;
                real                   pk_adls_per_phone                ;
                real                   pk_prof_lic_cat_s2               ;
                real                   pk_prof_lic_cat_s3               ;
                real                   pk_2nd_mortgage                  ;
                real                   pk_baloon_mortgage               ;
                real                   pk_adj_finance                   ;
                real                   pk_addrs_prison_history          ;
                real                   pk_ver_src_p                     ;
                real                   pk_prop_owned_purch_flag         ;
                real                   pk_add1_naprop4                  ;
                real                   pk_addrs_5yr_s0                  ;
                real                   pk_addrs_5yr_s2                  ;
                real                   pk_addrs_5yr_s3                  ;
                real                   pk_email_count_s1                ;
                real                   pk_email_domain_free_count_s2    ;
                real                   pk_email_domain_free_count_s3    ;
                real                   pk_add_apt1                      ;
                real                   pk_add_standarization_err        ;
                real                   pk_addr_changed                  ;
                real                   pk_unit_changed                  ;
                real                   pk_zip_po                        ;
                real                   pk_zip_corp_mil                  ;
                real                   pk_zip_hirisk_comm               ;
                real                   pk_add_inval                     ;
                real                   pk_add_apt2                      ;
                real                   pk_add_hirisk_comm               ;
                real                   pk_add1_advo_address_vacancy     ;
                real                   pk_add1_advo_throw_back          ;
                real                   pk_add1_advo_seasonal_delivery   ;
                real                   pk_add1_advo_college             ;
                real                   pk_add1_advo_drop                ;
                real                   pk_add1_advo_res_or_business     ;
                real                   pk_add1_advo_mixed_address_usage ;
                real                   pk_addprob_s1                    ;
                real                   pk_addprob_s2                    ;
                real                   pk_addprob_s3                    ;
                real                   pk_phn_nongeo                    ;
                real                   pk_phn_phn_not_issued            ;
                real                   pk_phnprob_s2                    ;
                real                   pk_grad_student                  ;
                real                   pk_ams_senior                    ;
                real                   pk_4yr_college                   ;
                real                   pk_college_tier_s0               ;
                real                   pk_college_tier_s1               ;
                real                   pk_college_tier_s2               ;
                real                   pk_contrary_infutor_ver          ;
                real                   pk_num_nonderogs90_s0            ;
                real                   pk_mth_gong_did_fst_sn           ;
                real                   pk_mth_gong_did_fst_sn2_s0       ;
                real                   pk_mth_gong_did_fst_sn2_s1       ;
                real                   pk_mth_gong_did_fst_sn2_s2       ;
                real                   pk_mth_gong_did_fst_sn2_s3       ;
                real                   pk_mth_add1_date_fst_sn          ;
                real                   pk_mth_add1_date_fst_sn2_s3      ;
                real                   pk_mth_ver_src_fdate_en          ;
                real                   pk_mth_ver_src_fdate_eq          ;
                real                   pk_mth_ver_src_fdate_bureau      ;
                Boolean                pk_too_young_at_bureau           ;
                real                   pk_addr_hist_advo_college        ;
                real                   pk_add1_house_number_match       ;
                real                   pk_nap_summary_ver_s1            ;
                real                   pk_pos_dob_src_minor             ;
                Boolean                pk_pos_dob_src_minor_flag        ;
                Boolean                ver_dob_src_bureau               ;
                real                   ver_dob_src_emerge               ;
                real                   pk_pos_dob_src_major             ;
                real                   pk_pos_dob_src_cnt_s2            ;
                real                   pk_mth_ver_src_ldate_en          ;
                real                   pk_mth_ver_src_ldate_eq          ;
                real                   pk_mth_ver_src_ldate_bureau      ;
                real                   pk_time_on_cb                    ;
                real                   pk_time_on_cb2_s1                ;
                real                   pk_time_since_cb3                ;
                real                   pk_age_estimate_s0_0m            ;
                real                   pk_estimated_income_s0_0m        ;
                real                   pk_add1_avm_auto_val_s0_0m       ;
                real                   pk_age_estimate_s1_1m            ;
                real                   pk_estimated_income_s1_1m        ;
                real                   pk_add1_avm_auto_val_s1_1m       ;
                real                   pk_age_estimate_s2_2m            ;
                real                   pk_estimated_income_s2_2m        ;
                real                   pk_add1_avm_auto_val_s2_2m       ;
                real                   pk_age_estimate_s3_3m            ;
                real                   pk_estimated_income_s3_3m        ;
                real                   pk_add1_avm_auto_val_s3_3m       ;
                real                   pk_verx_s0_0m                    ;
                real                   pk_verx_s1_1m                    ;
                real                   pk_verx_s3_3m                    ;
                real                   pk_inq_recent_lvl_s0_0m          ;
                real                   pk_inq_peradl_s0_0m              ;
                real                   pk_inq_adlsperphone_s0_0m        ;
                real                   pk_inq_recent_lvl_s1_1m          ;
                real                   pk_inq_peraddr_1m                ;
                real                   pk_mth_inq_frst_log_dt2_s2_2m    ;
                real                   pk_inq_recent_lvl_s3_3m          ;
                real                   pk_inq_peraddr_3m                ;
                real                   pk_inq_adlsperphone_s3_3m        ;
                real                   pk_mth_hdr_frst_sn_s2_2m         ;
                real                   pk_dob_ver_1m                    ;
                real                   pk_dob_ver_3m                    ;
                real                   pk_attr_total_number_derogs_0m   ;
                real                   pk_crim_fel_flag_0m              ;
                real                   pk_eviction_lvl_0m               ;
                real                   pk_unrel_lien_lvl_0m             ;
                real                   bankrupt_0m                      ;
                real                   pk_addrs_per_ssn_c6_s0_0m        ;
                real                   pk_ssns_per_adl_c6_0m            ;
                real                   pk_ssns_per_addr_c6_s0_0m        ;
                real                   pk_attr_addrs_last24_s0_0m       ;
                real                   pk_recent_addr_s0_0m             ;
                real                   pk_phones_per_adl_s0_0m          ;
                real                   pk_ssns_per_addr_0m              ;
                real                   pk_phones_per_addr_s0_0m         ;
                real                   pk_adlperssn_count_s1_1m         ;
                real                   pk_ssns_per_adl_s1_1m            ;
                real                   pk_addrs_per_ssn_c6_s1_1m        ;
                real                   pk_ssns_per_adl_c6_1m            ;
                real                   pk_ssns_per_addr_c6_s1_1m        ;
                real                   pk_phones_per_addr_c6_1m         ;
                real                   pk_attr_addrs_last12_s1_1m       ;
                real                   pk_ssns_per_adl_s2_2m            ;
                real                   pk_addrs_per_ssn_c6_s2_2m        ;
                real                   pk_adls_per_addr_c6_s2_2m        ;
                real                   pk_adls_per_phone_c6_2m          ;
                real                   pk_attr_addrs_last36_s2_2m       ;
                real                   pk_recent_addr_s2_2m             ;
                real                   pk_ssns_per_addr_2m              ;
                real                   pk_phones_per_addr_s2_2m         ;
                real                   pk_adls_per_phone_2m             ;
                real                   pk_adlperssn_count_s3_3m         ;
                real                   pk_ssns_per_adl_s3_3m            ;
                real                   pk_addrs_per_ssn_c6_s3_3m        ;
                real                   pk_phones_per_adl_c6_s3_3m       ;
                real                   pk_ssns_per_addr_c6_s3_3m        ;
                real                   pk_phones_per_addr_c6_3m         ;
                real                   pk_attr_addrs_last36_s3_3m       ;
                real                   pk_phones_per_addr_s3_3m         ;
                real                   pk_adls_per_phone_3m             ;
                real                   pk_prof_lic_cat_s2_2m            ;
                real                   pk_prof_lic_cat_s3_3m            ;
                real                   pk_ver_src_p_0m                  ;
                real                   pk_prop_owned_purch_flag_0m      ;
                real                   pk_add1_naprop4_0m               ;
                real                   pk_ver_src_p_1m                  ;
                real                   pk_add1_naprop4_1m               ;
                real                   pk_ver_src_p_3m                  ;
                real                   pk_addrs_5yr_s0_0m               ;
                real                   pk_addrs_5yr_s2_2m               ;
                real                   pk_addrs_5yr_s3_3m               ;
                real                   pk_email_count_s1_1m             ;
                real                   pk_email_domain_free_count_s2_2m ;
                real                   pk_email_domain_free_count_s3_3m ;
                real                   ssn_adl_prob_0m                  ;
                real                   ssn_issued18_0m                  ;
                real                   pk_addprob_s1_1m                 ;
                real                   ssn_issued18_1m                  ;
                real                   pk_addprob_s2_2m                 ;
                real                   pk_phnprob_s2_2m                 ;
                real                   pk_addprob_s3_3m                 ;
                real                   ssn_issued18_3m                  ;
                real                   pk_college_tier_s0_0m            ;
                real                   pk_grad_student_1m               ;
                real                   pk_ams_senior_1m                 ;
                real                   pk_college_tier_s1_1m            ;
                real                   pk_grad_student_2m               ;
                real                   pk_college_tier_s2_2m            ;
                real                   pk_4yr_college_3m                ;
                real                   pk_contrary_infutor_ver_1m       ;
                real                   pk_contrary_infutor_ver_2m       ;
                real                   pk_contrary_infutor_ver_3m       ;
                real                   pk_num_nonderogs90_s0_0m         ;
                real                   pk_mth_gong_did_fst_sn2_s0_0m    ;
                real                   pk_mth_gong_did_fst_sn2_s1_1m    ;
                real                   pk_too_young_at_bureau_1m        ;
                real                   pk_addr_hist_advo_college_1m     ;
                real                   pk_nap_summary_ver_s1_1m         ;
                real                   pk_mth_gong_did_fst_sn2_s2_2m    ;
                real                   pk_addr_hist_advo_college_2m     ;
                real                   pk_add1_house_number_match_2m    ;
                real                   pk_mth_gong_did_fst_sn2_s3_3m    ;
                real                   pk_mth_add1_date_fst_sn2_s3_3m   ;
                real                   pk_addr_hist_advo_college_3m     ;
                real                   pk_add1_house_number_match_3m    ;
                real                   pk_time_on_cb2_s1_1m             ;
                real                   pk_time_since_cb3_1m             ;
                real                   pk_pos_dob_src_cnt_s2_2m         ;
                real                   derog_mod_0m                     ;
                real                   prop_owner_mod_0m                ;
                real                   prop_owner_mod_1m                ;
                real                   prop_owner_mod_3m                ;
                real                   financing_mod_0m                 ;
                real                   financing_mod_2m                 ;
                real                   financing_mod_3m                 ;
                real                   email_mod_1m                     ;
                real                   email_mod_2m                     ;
                real                   email_mod_3m                     ;
                real                   fp_mod2_1m                       ;
                real                   ams_mod_0m                       ;
                real                   ams_mod_1m                       ;
                real                   ams_mod_2m                       ;
                real                   ams_mod_3m                       ;
                real                   inquiry_mod_0m                   ;
                real                   inquiry_mod_1m                   ;
                real                   inquiry_mod_2m                   ;
                real                   inquiry_mod_3m                   ;
                real                   velo_mod_0m                      ;
                real                   velo_mod_1m                      ;
                real                   velo_mod_2m                      ;
                real                   velo_mod_3m                      ;
                real                   mod8_0m                          ;
                real                   mod8_1m                          ;
                real                   mod8_2m                          ;
                real                   mod8_3m                          ;
                real                   mod8_nodob_0m                    ;
                real                   mod8_nodob_1m                    ;
                real                   mod8_nodob_2m                    ;
                real                   mod8_nodob_3m                    ;
                real                   mod8_nodob                       ;
                real                   mod8                             ;
                real                   mod8_phat                        ;
                real                   mod8_scr                         ;
                real                   mod8_nodob_phat                  ;
                real                   mod8_nodob_scr                   ;
                real                   rvb1104a                         ;
                real                   rvb1104b                         ;
                Boolean                ov_ssndead                       ;
                Boolean                ov_ssnprior                      ;
                Boolean                ov_criminal_flag                 ;
                Boolean                ov_corrections                   ;
                Boolean                ov_impulse                       ;
                real                   rvb1104c                         ;
                Boolean                scored_222s                      ;
                real                   rvb1104d                         ;
                real                   rvb1104e                         ;
                real                   rvb1104                          ;
                real                   pk_em_domain_free_count_s2_2m    ;
                real                   pk_em_domain_free_count_s3_3m    ;
                real                   add1_assessed_amount             ;
                real                   glrc25                           ;
                real                   glrc28                           ;
                real                   glrc36                           ;
                real                   glrc97                           ;
                real                   glrc98                           ;
                boolean                glrc99                           ;
                real                   glrc9a                           ;
                real                   glrc9c                           ;
                real                   glrc9d                           ;
                real                   glrc9e                           ;
                real                   glrc9g                           ;
                real                   glrc9h                           ;
                real                   glrc9j                           ;
                real                   glrc9m                           ;
                real                   glrc9n                           ;
                real                   glrc9q                           ;
                real                   glrc9r                           ;
                real                   glrc9s                           ;
                real                   glrc9t                           ;
                real                   glrc9u                           ;
                real                   glrc9w                           ;
                real                   glrcev                           ;
                real                   glrcmi                           ;
                real                   glrcms                           ;
                real                   aptflag                          ;
                real                   add1_econval                     ;
                real                   add1_aptval                      ;
                string                 add1_econcode                    ;
                real                   glrcpv                           ;
                real                   glrcx11                          ;
                real                   header_last_seen2                ;
                real                   yr_header_last_seen              ;
                real                   mth_header_last_seen             ;
                real                   pk_mth_header_last_seen          ;
                real                   glrc9f                           ;
                real                   _36                              ;
                real                   _ev                              ;
                real                   _9s                              ;
                real                   _25                              ;
                real                   _28                              ;
                real                   _9g                              ;
                real                   _9h                              ;
                real                   _99                              ;
                real                   _ms                              ;
                real                   _9d                              ;
                real                   _9t                              ;
                real                   _9m                              ;
                real                   _9q                              ;
                real                   _9j                              ;
                real                   _x11                             ;
                real                   _mi                              ;
                real                   _97                              ;
                real                   _9r                              ;
                real                   _9f                              ;
                real                   _9a                              ;
                real                   _9u                              ;
                real                   _9w                              ;
                real                   _pv                              ;
                real                   _98                              ;
                real                   _9n                              ;
                real                   _9c                              ;
                real                   _9e                              ;
                String                 rc1                              ;
                String                 rc2                              ;
                String                 rc3                              ;
                String                 rc4                              ;
								String                 rc5                              ;
								
                // String                 rv40_rc4                         ;
                // String                 rv40_rc5                         ;
                // String                 rv40_rc1                         ;
                // String                 rv40_rc2                         ;
                // String                 rv40_rc3                         ;
                                    
		
		
			risk_indicators.Layout_Boca_Shell clam;
			

			Models.Layout_ModelOut;
		end;
		debug_layout doModel( clam le ) := TRANSFORM
	#else
		Models.Layout_ModelOut doModel( clam le ) := TRANSFORM
	#end

		truedid                          := le.truedid;
	out_unit_desig                   := le.shell_input.unit_desig;
	out_sec_range                    := le.shell_input.sec_range;
	out_addr_type                    := le.shell_input.addr_type;
	out_addr_status                  := le.shell_input.addr_status;
	in_dob                           := le.shell_input.dob;
	nas_summary                      := le.iid.nas_summary;
	nap_summary                      := le.iid.nap_summary;
	nap_status                       := le.iid.nap_status;
	rc_input_addr_not_most_recent    := le.iid.inputaddrnotmostrecent;
	rc_hriskphoneflag                := le.iid.hriskphoneflag;
	rc_hphonetypeflag                := le.iid.hphonetypeflag;
	rc_phonevalflag                  := le.iid.phonevalflag;
	rc_hphonevalflag                 := le.iid.hphonevalflag;
	rc_phonezipflag                  := le.iid.phonezipflag;
	rc_pwphonezipflag                := le.iid.pwphonezipflag;
	rc_hriskaddrflag                 := le.iid.hriskaddrflag;
	rc_decsflag                      := le.iid.decsflag;
	rc_ssndobflag                    := le.iid.socsdobflag;
	rc_pwssndobflag                  := le.iid.pwsocsdobflag;
	rc_pwssnvalflag                  := le.iid.pwsocsvalflag;
	rc_addrvalflag                   := le.iid.addrvalflag;
	rc_dwelltype                     := le.iid.dwelltype;
	rc_bansflag                      := le.iid.bansflag;
	rc_addrcommflag                  := le.iid.addrcommflag;
	rc_hrisksic                      := le.iid.hrisksic;
	rc_phonetype                     := le.iid.phonetype;
	combo_dobscore                   := le.iid.combo_dobscore;
	combo_addrcount                  := le.iid.combo_addrcount;
	combo_dobcount                   := le.iid.combo_dobcount;
	ver_sources                      := le.header_summary.ver_sources;
	ver_sources_first_seen           := le.header_summary.ver_sources_first_seen_date;
	ver_sources_last_seen            := le.header_summary.ver_sources_last_seen_date;
	ver_sources_count                := le.header_summary.ver_sources_recordcount;
	ver_dob_sources                  := le.header_summary.ver_dob_sources;
	ver_dob_sources_first_seen       := le.header_summary.ver_dob_sources_first_seen_date;
	ver_dob_sources_count            := le.header_summary.ver_dob_sources_recordcount;
	addrpop                          := le.input_validation.address;
	ssnlength                        := le.input_validation.ssn_length;
	dobpop                           := le.input_validation.dateofbirth;
	hphnpop                          := le.input_validation.homephone;
	add1_house_number_match          := le.address_verification.input_address_information.house_number_match;
	add1_isbestmatch                 := le.address_verification.input_address_information.isbestmatch;
	add1_lres                        := le.lres;
	add1_advo_address_vacancy        := le.advo_input_addr.address_vacancy_indicator;
	add1_advo_throw_back             := le.advo_input_addr.throw_back_indicator;
	add1_advo_seasonal_delivery      := le.advo_input_addr.seasonal_delivery_indicator;
	add1_advo_college                := le.advo_input_addr.college_indicator;
	add1_advo_drop                   := le.advo_input_addr.drop_indicator;
	add1_advo_res_or_business        := le.advo_input_addr.residential_or_business_ind;
	add1_advo_mixed_address_usage    := le.advo_input_addr.mixed_address_usage;
	add1_avm_automated_valuation     := le.avm.input_address_information.avm_automated_valuation;
	add1_avm_med_fips                := le.avm.input_address_information.avm_median_fips_level;
	add1_avm_med_geo11               := le.avm.input_address_information.avm_median_geo11_level;
	add1_avm_med_geo12               := le.avm.input_address_information.avm_median_geo12_level;
	add1_applicant_owned             := le.address_verification.input_address_information.applicant_owned;
	add1_family_owned                := le.address_verification.input_address_information.family_owned;
	add1_naprop                      := le.address_verification.input_address_information.naprop;
	add1_mortgage_type               := le.address_verification.input_address_information.mortgage_type;
	add1_financing_type              := le.address_verification.input_address_information.type_financing;
	add1_market_total_value          := le.address_verification.input_address_information.assessed_amount;
	add1_date_first_seen             := le.address_verification.input_address_information.date_first_seen;
	property_owned_total             := le.address_verification.owned.property_total;
	property_owned_purchase_count    := le.address_verification.owned.property_owned_purchase_count;
	property_sold_total              := le.address_verification.sold.property_total;
	property_ambig_total             := le.address_verification.ambiguous.property_total;
	add2_applicant_owned             := le.address_verification.address_history_1.applicant_owned;
	add2_family_owned                := le.address_verification.address_history_1.family_owned;
	add2_naprop                      := le.address_verification.address_history_1.naprop;
	add3_applicant_owned             := le.address_verification.address_history_2.applicant_owned;
	add3_family_owned                := le.address_verification.address_history_2.family_owned;
	add3_naprop                      := le.address_verification.address_history_2.naprop;
	addrs_5yr                        := le.other_address_info.addrs_last_5years;
	addrs_10yr                       := le.other_address_info.addrs_last_10years;
	addrs_prison_history             := le.other_address_info.isprison;
	addr_hist_advo_college           := le.address_history_summary.address_history_advo_college_hit;
	telcordia_type                   := le.phone_verification.telcordia_type;
	gong_did_first_seen              := le.phone_verification.gong_did.gong_adl_dt_first_seen_full;
	header_first_seen                := le.ssn_verification.header_first_seen;
	header_last_seen                 := le.ssn_verification.header_last_seen;
	ssns_per_adl                     := le.velocity_counters.ssns_per_adl;
	phones_per_adl                   := le.velocity_counters.phones_per_adl;
	adlperssn_count                  := le.ssn_verification.adlperssn_count;
	ssns_per_addr                    := le.velocity_counters.ssns_per_addr;
	phones_per_addr                  := le.velocity_counters.phones_per_addr;
	adls_per_phone                   := le.velocity_counters.adls_per_phone;
	ssns_per_adl_c6                  := le.velocity_counters.ssns_per_adl_created_6months;
	phones_per_adl_c6                := le.velocity_counters.phones_per_adl_created_6months;
	addrs_per_ssn_c6                 := le.velocity_counters.addrs_per_ssn_created_6months;
	adls_per_addr_c6                 := le.velocity_counters.adls_per_addr_created_6months;
	ssns_per_addr_c6                 := le.velocity_counters.ssns_per_addr_created_6months;
	phones_per_addr_c6               := le.velocity_counters.phones_per_addr_created_6months;
	adls_per_phone_c6                := le.velocity_counters.adls_per_phone_created_6months;
	inq_first_log_date               := le.acc_logs.first_log_date;
	inq_count03                      := le.acc_logs.inquiries.count03;
	inq_count06                      := le.acc_logs.inquiries.count06;
	inq_count12                      := le.acc_logs.inquiries.count12;
	inq_peradl                       := le.acc_logs.inquiryperadl;
	inq_peraddr                      := le.acc_logs.inquiryperaddr;
	inq_adlsperphone                 := le.acc_logs.inquiryadlsperphone;
	infutor_nap                      := le.infutor_phone.infutor_nap;
	email_source_list                := le.email_summary.email_source_list;
	email_source_count               := le.email_summary.email_source_ct;
	email_source_first_seen          := le.email_summary.email_source_first_seen;
	attr_addrs_last90                := le.other_address_info.addrs_last90;
	attr_addrs_last12                := le.other_address_info.addrs_last12;
	attr_addrs_last24                := le.other_address_info.addrs_last24;
	attr_addrs_last36                := le.other_address_info.addrs_last36;
	attr_total_number_derogs         := le.total_number_derogs;
	attr_num_unrel_liens180          := le.bjl.liens_unreleased_count180;
	attr_num_unrel_liens12           := le.bjl.liens_unreleased_count12;
	attr_num_unrel_liens24           := le.bjl.liens_unreleased_count24;
	attr_num_unrel_liens60           := le.bjl.liens_unreleased_count60;
	attr_eviction_count              := le.bjl.eviction_count;
	attr_eviction_count180           := le.bjl.eviction_count180;
	attr_eviction_count12            := le.bjl.eviction_count12;
	attr_eviction_count24            := le.bjl.eviction_count24;
	attr_num_nonderogs90             := le.source_verification.num_nonderogs90;
	bankrupt                         := le.bjl.bankrupt;
	filing_count                     := le.bjl.filing_count;
	bk_recent_count                  := le.bjl.bk_recent_count;
	liens_recent_unreleased_count    := le.bjl.liens_recent_unreleased_count;
	liens_historical_unreleased_ct   := le.bjl.liens_historical_unreleased_count;
	criminal_count                   := le.bjl.criminal_count;
	felony_count                     := le.bjl.felony_count;
	ams_class                        := le.student.class;
	ams_college_code                 := le.student.college_code;
	ams_college_tier                 := le.student.college_tier;
	prof_license_category            := le.professional_license.plcategory;
	wealth_index                     := le.wealth_indicator;
	input_dob_match_level            := le.dobmatchlevel;
	inferred_age                     := le.inferred_age;
	estimated_income                 := le.estimated_income;

NULL := -999999999;


INTEGER year(integer sas_date) :=
	if(sas_date = NULL, NULL, (integer)((ut.DateFrom_DaysSince1900(sas_date + ut.DaysSince1900('1960', '1', '1')))[1..4]));

sysdate := common.sas_date(if(le.historydate=999999, (STRING)Std.Date.Today(), (string6)le.historydate+'01'));

sysyear := year(common.sas_date(if(le.historydate=999999, (string)ut.getdate, (string6)le.historydate+'01')));

in_dob2 := common.sas_date((string)(in_dob));

yr_in_dob := if(min(sysdate, in_dob2) = NULL, NULL, (sysdate - in_dob2) / 365.25);

mth_in_dob := if(min(sysdate, in_dob2) = NULL, NULL, (sysdate - in_dob2) / 30.5);

add1_date_first_seen2 := common.sas_date((string)(add1_date_first_seen));

yr_add1_date_first_seen := if(min(sysdate, add1_date_first_seen2) = NULL, NULL, (sysdate - add1_date_first_seen2) / 365.25);

mth_add1_date_first_seen := if(min(sysdate, add1_date_first_seen2) = NULL, NULL, (sysdate - add1_date_first_seen2) / 30.5);

gong_did_first_seen2 := common.sas_date((string)(gong_did_first_seen));

yr_gong_did_first_seen := if(min(sysdate, gong_did_first_seen2) = NULL, NULL, (sysdate - gong_did_first_seen2) / 365.25);

mth_gong_did_first_seen := if(min(sysdate, gong_did_first_seen2) = NULL, NULL, (sysdate - gong_did_first_seen2) / 30.5);

header_first_seen2 := common.sas_date((string)(header_first_seen));

yr_header_first_seen := if(min(sysdate, header_first_seen2) = NULL, NULL, (sysdate - header_first_seen2) / 365.25);

mth_header_first_seen := if(min(sysdate, header_first_seen2) = NULL, NULL, (sysdate - header_first_seen2) / 30.5);

ver_src_cnt := Models.Common.countw((string)(ver_sources), ' !$%&()*+,-./;<^|');

ver_src_pop := ver_src_cnt > 0;

ver_src_fsrc := Models.Common.getw(ver_sources, 1);

ver_src_fsrc_fdate := Models.Common.getw(ver_sources_first_seen, 1);

ver_src_fsrc_fdate2 := common.sas_date((string)(ver_src_fsrc_fdate));

yr_ver_src_fsrc_fdate := if(min(sysdate, ver_src_fsrc_fdate2) = NULL, NULL, (sysdate - ver_src_fsrc_fdate2) / 365.25);

mth_ver_src_fsrc_fdate := if(min(sysdate, ver_src_fsrc_fdate2) = NULL, NULL, (sysdate - ver_src_fsrc_fdate2) / 30.5);

ver_src_ak_pos := Models.Common.findw_cpp(ver_sources, 'AK' , ' ,', 'ie');

ver_src_ak := ver_src_ak_pos > 0;

ver_src_fdate_ak := if(ver_src_ak_pos > 0, Models.Common.getw(ver_sources_first_seen, ver_src_ak_pos), '0');

ver_src_fdate_ak2 := common.sas_date((string)(ver_src_fdate_ak));

yr_ver_src_fdate_ak := if(min(sysdate, ver_src_fdate_ak2) = NULL, NULL, (sysdate - ver_src_fdate_ak2) / 365.25);

mth_ver_src_fdate_ak := if(min(sysdate, ver_src_fdate_ak2) = NULL, NULL, (sysdate - ver_src_fdate_ak2) / 30.5);

ver_src_ldate_ak := if(ver_src_ak_pos > 0, Models.Common.getw(ver_sources_last_seen, ver_src_ak_pos), '0');

ver_src_ldate_ak2 := common.sas_date((string)(ver_src_ldate_ak));

yr_ver_src_ldate_ak := if(min(sysdate, ver_src_ldate_ak2) = NULL, NULL, (sysdate - ver_src_ldate_ak2) / 365.25);

mth_ver_src_ldate_ak := if(min(sysdate, ver_src_ldate_ak2) = NULL, NULL, (sysdate - ver_src_ldate_ak2) / 30.5);

ver_src_cnt_ak := if(ver_src_ak_pos > 0, (real)Models.Common.getw(ver_sources_count, ver_src_ak_pos), 0);

// ver_src_rcnt_35 := ver_src_rcnt + ver_src_cnt_ak;

ver_src_am_pos := Models.Common.findw_cpp(ver_sources, 'AM' , ' ,', 'ie');

ver_src_am := ver_src_am_pos > 0;

ver_src_fdate_am := if(ver_src_am_pos > 0, Models.Common.getw(ver_sources_first_seen, ver_src_am_pos), '0');

ver_src_fdate_am2 := common.sas_date((string)(ver_src_fdate_am));

yr_ver_src_fdate_am := if(min(sysdate, ver_src_fdate_am2) = NULL, NULL, (sysdate - ver_src_fdate_am2) / 365.25);

mth_ver_src_fdate_am := if(min(sysdate, ver_src_fdate_am2) = NULL, NULL, (sysdate - ver_src_fdate_am2) / 30.5);

ver_src_ldate_am := if(ver_src_am_pos > 0, Models.Common.getw(ver_sources_last_seen, ver_src_am_pos), '0');

ver_src_ldate_am2 := common.sas_date((string)(ver_src_ldate_am));

yr_ver_src_ldate_am := if(min(sysdate, ver_src_ldate_am2) = NULL, NULL, (sysdate - ver_src_ldate_am2) / 365.25);

mth_ver_src_ldate_am := if(min(sysdate, ver_src_ldate_am2) = NULL, NULL, (sysdate - ver_src_ldate_am2) / 30.5);

ver_src_cnt_am := if(ver_src_am_pos > 0, (real)Models.Common.getw(ver_sources_count, ver_src_am_pos), 0);

// ver_src_rcnt_34 := ver_src_rcnt_35 + ver_src_cnt_am;

ver_src_ar_pos := Models.Common.findw_cpp(ver_sources, 'AR' , ' ,', 'ie');

ver_src_ar := ver_src_ar_pos > 0;

ver_src_fdate_ar := if(ver_src_ar_pos > 0, Models.Common.getw(ver_sources_first_seen, ver_src_ar_pos), '0');

ver_src_fdate_ar2 := common.sas_date((string)(ver_src_fdate_ar));

yr_ver_src_fdate_ar := if(min(sysdate, ver_src_fdate_ar2) = NULL, NULL, (sysdate - ver_src_fdate_ar2) / 365.25);

mth_ver_src_fdate_ar := if(min(sysdate, ver_src_fdate_ar2) = NULL, NULL, (sysdate - ver_src_fdate_ar2) / 30.5);

ver_src_ldate_ar := if(ver_src_ar_pos > 0, Models.Common.getw(ver_sources_last_seen, ver_src_ar_pos), '0');

ver_src_ldate_ar2 := common.sas_date((string)(ver_src_ldate_ar));

yr_ver_src_ldate_ar := if(min(sysdate, ver_src_ldate_ar2) = NULL, NULL, (sysdate - ver_src_ldate_ar2) / 365.25);

mth_ver_src_ldate_ar := if(min(sysdate, ver_src_ldate_ar2) = NULL, NULL, (sysdate - ver_src_ldate_ar2) / 30.5);

ver_src_cnt_ar := if(ver_src_ar_pos > 0, (real)Models.Common.getw(ver_sources_count, ver_src_ar_pos), 0);

// ver_src_rcnt_33 := ver_src_rcnt_34 + ver_src_cnt_ar;

ver_src_ba_pos := Models.Common.findw_cpp(ver_sources, 'BA' , ' ,', 'ie');

ver_src_ba := ver_src_ba_pos > 0;

ver_src_fdate_ba := if(ver_src_ba_pos > 0, Models.Common.getw(ver_sources_first_seen, ver_src_ba_pos), '0');

ver_src_fdate_ba2 := common.sas_date((string)(ver_src_fdate_ba));

yr_ver_src_fdate_ba := if(min(sysdate, ver_src_fdate_ba2) = NULL, NULL, (sysdate - ver_src_fdate_ba2) / 365.25);

mth_ver_src_fdate_ba := if(min(sysdate, ver_src_fdate_ba2) = NULL, NULL, (sysdate - ver_src_fdate_ba2) / 30.5);

ver_src_ldate_ba := if(ver_src_ba_pos > 0, Models.Common.getw(ver_sources_last_seen, ver_src_ba_pos), '0');

ver_src_ldate_ba2 := common.sas_date((string)(ver_src_ldate_ba));

yr_ver_src_ldate_ba := if(min(sysdate, ver_src_ldate_ba2) = NULL, NULL, (sysdate - ver_src_ldate_ba2) / 365.25);

mth_ver_src_ldate_ba := if(min(sysdate, ver_src_ldate_ba2) = NULL, NULL, (sysdate - ver_src_ldate_ba2) / 30.5);

ver_src_cnt_ba := if(ver_src_ba_pos > 0, (real)Models.Common.getw(ver_sources_count, ver_src_ba_pos), 0);

// ver_src_rcnt_32 := ver_src_rcnt_33 + ver_src_cnt_ba;

ver_src_cg_pos := Models.Common.findw_cpp(ver_sources, 'CG' , ' ,', 'ie');

ver_src_cg := ver_src_cg_pos > 0;

ver_src_fdate_cg := if(ver_src_cg_pos > 0, Models.Common.getw(ver_sources_first_seen, ver_src_cg_pos), '0');

ver_src_fdate_cg2 := common.sas_date((string)(ver_src_fdate_cg));

yr_ver_src_fdate_cg := if(min(sysdate, ver_src_fdate_cg2) = NULL, NULL, (sysdate - ver_src_fdate_cg2) / 365.25);

mth_ver_src_fdate_cg := if(min(sysdate, ver_src_fdate_cg2) = NULL, NULL, (sysdate - ver_src_fdate_cg2) / 30.5);

ver_src_ldate_cg := if(ver_src_cg_pos > 0, Models.Common.getw(ver_sources_last_seen, ver_src_cg_pos), '0');

ver_src_ldate_cg2 := common.sas_date((string)(ver_src_ldate_cg));

yr_ver_src_ldate_cg := if(min(sysdate, ver_src_ldate_cg2) = NULL, NULL, (sysdate - ver_src_ldate_cg2) / 365.25);

mth_ver_src_ldate_cg := if(min(sysdate, ver_src_ldate_cg2) = NULL, NULL, (sysdate - ver_src_ldate_cg2) / 30.5);

ver_src_cnt_cg := if(ver_src_cg_pos > 0, (real)Models.Common.getw(ver_sources_count, ver_src_cg_pos), 0);

// ver_src_rcnt_31 := ver_src_rcnt_32 + ver_src_cnt_cg;

ver_src_co_pos := Models.Common.findw_cpp(ver_sources, 'CO' , ' ,', 'ie');

ver_src_co := ver_src_co_pos > 0;

ver_src_fdate_co := if(ver_src_co_pos > 0, Models.Common.getw(ver_sources_first_seen, ver_src_co_pos), '0');

ver_src_fdate_co2 := common.sas_date((string)(ver_src_fdate_co));

yr_ver_src_fdate_co := if(min(sysdate, ver_src_fdate_co2) = NULL, NULL, (sysdate - ver_src_fdate_co2) / 365.25);

mth_ver_src_fdate_co := if(min(sysdate, ver_src_fdate_co2) = NULL, NULL, (sysdate - ver_src_fdate_co2) / 30.5);

ver_src_ldate_co := if(ver_src_co_pos > 0, Models.Common.getw(ver_sources_last_seen, ver_src_co_pos), '0');

ver_src_ldate_co2 := common.sas_date((string)(ver_src_ldate_co));

yr_ver_src_ldate_co := if(min(sysdate, ver_src_ldate_co2) = NULL, NULL, (sysdate - ver_src_ldate_co2) / 365.25);

mth_ver_src_ldate_co := if(min(sysdate, ver_src_ldate_co2) = NULL, NULL, (sysdate - ver_src_ldate_co2) / 30.5);

ver_src_cnt_co := if(ver_src_co_pos > 0, (real)Models.Common.getw(ver_sources_count, ver_src_co_pos), 0);

// ver_src_rcnt_30 := ver_src_rcnt_31 + ver_src_cnt_co;

ver_src_cy_pos := Models.Common.findw_cpp(ver_sources, 'CY' , ' ,', 'ie');

ver_src_cy := ver_src_cy_pos > 0;

ver_src_fdate_cy := if(ver_src_cy_pos > 0, Models.Common.getw(ver_sources_first_seen, ver_src_cy_pos), '0');

ver_src_fdate_cy2 := common.sas_date((string)(ver_src_fdate_cy));

yr_ver_src_fdate_cy := if(min(sysdate, ver_src_fdate_cy2) = NULL, NULL, (sysdate - ver_src_fdate_cy2) / 365.25);

mth_ver_src_fdate_cy := if(min(sysdate, ver_src_fdate_cy2) = NULL, NULL, (sysdate - ver_src_fdate_cy2) / 30.5);

ver_src_ldate_cy := if(ver_src_cy_pos > 0, Models.Common.getw(ver_sources_last_seen, ver_src_cy_pos), '0');

ver_src_ldate_cy2 := common.sas_date((string)(ver_src_ldate_cy));

yr_ver_src_ldate_cy := if(min(sysdate, ver_src_ldate_cy2) = NULL, NULL, (sysdate - ver_src_ldate_cy2) / 365.25);

mth_ver_src_ldate_cy := if(min(sysdate, ver_src_ldate_cy2) = NULL, NULL, (sysdate - ver_src_ldate_cy2) / 30.5);

ver_src_cnt_cy := if(ver_src_cy_pos > 0, (real)Models.Common.getw(ver_sources_count, ver_src_cy_pos), 0);

// ver_src_rcnt_29 := ver_src_rcnt_30 + ver_src_cnt_cy;

ver_src_da_pos := Models.Common.findw_cpp(ver_sources, 'DA' , ' ,', 'ie');

ver_src_da := ver_src_da_pos > 0;

ver_src_fdate_da := if(ver_src_da_pos > 0, Models.Common.getw(ver_sources_first_seen, ver_src_da_pos), '0');

ver_src_fdate_da2 := common.sas_date((string)(ver_src_fdate_da));

yr_ver_src_fdate_da := if(min(sysdate, ver_src_fdate_da2) = NULL, NULL, (sysdate - ver_src_fdate_da2) / 365.25);

mth_ver_src_fdate_da := if(min(sysdate, ver_src_fdate_da2) = NULL, NULL, (sysdate - ver_src_fdate_da2) / 30.5);

ver_src_ldate_da := if(ver_src_da_pos > 0, Models.Common.getw(ver_sources_last_seen, ver_src_da_pos), '0');

ver_src_ldate_da2 := common.sas_date((string)(ver_src_ldate_da));

yr_ver_src_ldate_da := if(min(sysdate, ver_src_ldate_da2) = NULL, NULL, (sysdate - ver_src_ldate_da2) / 365.25);

mth_ver_src_ldate_da := if(min(sysdate, ver_src_ldate_da2) = NULL, NULL, (sysdate - ver_src_ldate_da2) / 30.5);

ver_src_cnt_da := if(ver_src_da_pos > 0, (real)Models.Common.getw(ver_sources_count, ver_src_da_pos), 0);

// ver_src_rcnt_28 := ver_src_rcnt_29 + ver_src_cnt_da;

ver_src_d_pos := Models.Common.findw_cpp(ver_sources, 'D' , ' ,', 'ie');

ver_src_d := ver_src_d_pos > 0;

ver_src_fdate_d := if(ver_src_d_pos > 0, Models.Common.getw(ver_sources_first_seen, ver_src_d_pos), '0');

ver_src_fdate_d2 := common.sas_date((string)(ver_src_fdate_d));

yr_ver_src_fdate_d := if(min(sysdate, ver_src_fdate_d2) = NULL, NULL, (sysdate - ver_src_fdate_d2) / 365.25);

mth_ver_src_fdate_d := if(min(sysdate, ver_src_fdate_d2) = NULL, NULL, (sysdate - ver_src_fdate_d2) / 30.5);

ver_src_ldate_d := if(ver_src_d_pos > 0, Models.Common.getw(ver_sources_last_seen, ver_src_d_pos), '0');

ver_src_ldate_d2 := common.sas_date((string)(ver_src_ldate_d));

yr_ver_src_ldate_d := if(min(sysdate, ver_src_ldate_d2) = NULL, NULL, (sysdate - ver_src_ldate_d2) / 365.25);

mth_ver_src_ldate_d := if(min(sysdate, ver_src_ldate_d2) = NULL, NULL, (sysdate - ver_src_ldate_d2) / 30.5);

ver_src_cnt_d := if(ver_src_d_pos > 0, (real)Models.Common.getw(ver_sources_count, ver_src_d_pos), 0);

// ver_src_rcnt_27 := ver_src_rcnt_28 + ver_src_cnt_d;

ver_src_dl_pos := Models.Common.findw_cpp(ver_sources, 'DL' , ' ,', 'ie');

ver_src_dl := ver_src_dl_pos > 0;

ver_src_fdate_dl := if(ver_src_dl_pos > 0, Models.Common.getw(ver_sources_first_seen, ver_src_dl_pos), '0');

ver_src_fdate_dl2 := common.sas_date((string)(ver_src_fdate_dl));

yr_ver_src_fdate_dl := if(min(sysdate, ver_src_fdate_dl2) = NULL, NULL, (sysdate - ver_src_fdate_dl2) / 365.25);

mth_ver_src_fdate_dl := if(min(sysdate, ver_src_fdate_dl2) = NULL, NULL, (sysdate - ver_src_fdate_dl2) / 30.5);

ver_src_ldate_dl := if(ver_src_dl_pos > 0, Models.Common.getw(ver_sources_last_seen, ver_src_dl_pos), '0');

ver_src_ldate_dl2 := common.sas_date((string)(ver_src_ldate_dl));

yr_ver_src_ldate_dl := if(min(sysdate, ver_src_ldate_dl2) = NULL, NULL, (sysdate - ver_src_ldate_dl2) / 365.25);

mth_ver_src_ldate_dl := if(min(sysdate, ver_src_ldate_dl2) = NULL, NULL, (sysdate - ver_src_ldate_dl2) / 30.5);

ver_src_cnt_dl := if(ver_src_dl_pos > 0, (real)Models.Common.getw(ver_sources_count, ver_src_dl_pos), 0);

// ver_src_rcnt_26 := ver_src_rcnt_27 + ver_src_cnt_dl;

ver_src_ds_pos := Models.Common.findw_cpp(ver_sources, 'DS' , ' ,', 'ie');

ver_src_ds := ver_src_ds_pos > 0;

ver_src_fdate_ds := if(ver_src_ds_pos > 0, Models.Common.getw(ver_sources_first_seen, ver_src_ds_pos), '0');

ver_src_fdate_ds2 := common.sas_date((string)(ver_src_fdate_ds));

yr_ver_src_fdate_ds := if(min(sysdate, ver_src_fdate_ds2) = NULL, NULL, (sysdate - ver_src_fdate_ds2) / 365.25);

mth_ver_src_fdate_ds := if(min(sysdate, ver_src_fdate_ds2) = NULL, NULL, (sysdate - ver_src_fdate_ds2) / 30.5);

ver_src_ldate_ds := if(ver_src_ds_pos > 0, Models.Common.getw(ver_sources_last_seen, ver_src_ds_pos), '0');

ver_src_ldate_ds2 := common.sas_date((string)(ver_src_ldate_ds));

yr_ver_src_ldate_ds := if(min(sysdate, ver_src_ldate_ds2) = NULL, NULL, (sysdate - ver_src_ldate_ds2) / 365.25);

mth_ver_src_ldate_ds := if(min(sysdate, ver_src_ldate_ds2) = NULL, NULL, (sysdate - ver_src_ldate_ds2) / 30.5);

ver_src_cnt_ds := if(ver_src_ds_pos > 0, (real)Models.Common.getw(ver_sources_count, ver_src_ds_pos), 0);

// ver_src_rcnt_25 := ver_src_rcnt_26 + ver_src_cnt_ds;

ver_src_de_pos := Models.Common.findw_cpp(ver_sources, 'DE' , ' ,', 'ie');

ver_src_de := ver_src_de_pos > 0;

ver_src_fdate_de := if(ver_src_de_pos > 0, Models.Common.getw(ver_sources_first_seen, ver_src_de_pos), '0');

ver_src_fdate_de2 := common.sas_date((string)(ver_src_fdate_de));

yr_ver_src_fdate_de := if(min(sysdate, ver_src_fdate_de2) = NULL, NULL, (sysdate - ver_src_fdate_de2) / 365.25);

mth_ver_src_fdate_de := if(min(sysdate, ver_src_fdate_de2) = NULL, NULL, (sysdate - ver_src_fdate_de2) / 30.5);

ver_src_ldate_de := if(ver_src_de_pos > 0, Models.Common.getw(ver_sources_last_seen, ver_src_de_pos), '0');

ver_src_ldate_de2 := common.sas_date((string)(ver_src_ldate_de));

yr_ver_src_ldate_de := if(min(sysdate, ver_src_ldate_de2) = NULL, NULL, (sysdate - ver_src_ldate_de2) / 365.25);

mth_ver_src_ldate_de := if(min(sysdate, ver_src_ldate_de2) = NULL, NULL, (sysdate - ver_src_ldate_de2) / 30.5);

ver_src_cnt_de := if(ver_src_de_pos > 0, (real)Models.Common.getw(ver_sources_count, ver_src_de_pos), 0);

// ver_src_rcnt_24 := ver_src_rcnt_25 + ver_src_cnt_de;

ver_src_eb_pos := Models.Common.findw_cpp(ver_sources, 'EB' , ' ,', 'ie');

ver_src_eb := ver_src_eb_pos > 0;

ver_src_fdate_eb := if(ver_src_eb_pos > 0, Models.Common.getw(ver_sources_first_seen, ver_src_eb_pos), '0');

ver_src_fdate_eb2 := common.sas_date((string)(ver_src_fdate_eb));

yr_ver_src_fdate_eb := if(min(sysdate, ver_src_fdate_eb2) = NULL, NULL, (sysdate - ver_src_fdate_eb2) / 365.25);

mth_ver_src_fdate_eb := if(min(sysdate, ver_src_fdate_eb2) = NULL, NULL, (sysdate - ver_src_fdate_eb2) / 30.5);

ver_src_ldate_eb := if(ver_src_eb_pos > 0, Models.Common.getw(ver_sources_last_seen, ver_src_eb_pos), '0');

ver_src_ldate_eb2 := common.sas_date((string)(ver_src_ldate_eb));

yr_ver_src_ldate_eb := if(min(sysdate, ver_src_ldate_eb2) = NULL, NULL, (sysdate - ver_src_ldate_eb2) / 365.25);

mth_ver_src_ldate_eb := if(min(sysdate, ver_src_ldate_eb2) = NULL, NULL, (sysdate - ver_src_ldate_eb2) / 30.5);

ver_src_cnt_eb := if(ver_src_eb_pos > 0, (real)Models.Common.getw(ver_sources_count, ver_src_eb_pos), 0);

// ver_src_rcnt_23 := ver_src_rcnt_24 + ver_src_cnt_eb;

ver_src_em_pos := Models.Common.findw_cpp(ver_sources, 'EM' , ' ,', 'ie');

ver_src_em := ver_src_em_pos > 0;

ver_src_fdate_em := if(ver_src_em_pos > 0, Models.Common.getw(ver_sources_first_seen, ver_src_em_pos), '0');

ver_src_fdate_em2 := common.sas_date((string)(ver_src_fdate_em));

yr_ver_src_fdate_em := if(min(sysdate, ver_src_fdate_em2) = NULL, NULL, (sysdate - ver_src_fdate_em2) / 365.25);

mth_ver_src_fdate_em := if(min(sysdate, ver_src_fdate_em2) = NULL, NULL, (sysdate - ver_src_fdate_em2) / 30.5);

ver_src_ldate_em := if(ver_src_em_pos > 0, Models.Common.getw(ver_sources_last_seen, ver_src_em_pos), '0');

ver_src_ldate_em2 := common.sas_date((string)(ver_src_ldate_em));

yr_ver_src_ldate_em := if(min(sysdate, ver_src_ldate_em2) = NULL, NULL, (sysdate - ver_src_ldate_em2) / 365.25);

mth_ver_src_ldate_em := if(min(sysdate, ver_src_ldate_em2) = NULL, NULL, (sysdate - ver_src_ldate_em2) / 30.5);

ver_src_cnt_em := if(ver_src_em_pos > 0, (real)Models.Common.getw(ver_sources_count, ver_src_em_pos), 0);

// ver_src_rcnt_22 := ver_src_rcnt_23 + ver_src_cnt_em;

ver_src_e1_pos := Models.Common.findw_cpp(ver_sources, 'E1' , ' ,', 'ie');

ver_src_e1 := ver_src_e1_pos > 0;

ver_src_fdate_e1 := if(ver_src_e1_pos > 0, Models.Common.getw(ver_sources_first_seen, ver_src_e1_pos), '0');

ver_src_fdate_e12 := common.sas_date((string)(ver_src_fdate_e1));

yr_ver_src_fdate_e1 := if(min(sysdate, ver_src_fdate_e12) = NULL, NULL, (sysdate - ver_src_fdate_e12) / 365.25);

mth_ver_src_fdate_e1 := if(min(sysdate, ver_src_fdate_e12) = NULL, NULL, (sysdate - ver_src_fdate_e12) / 30.5);

ver_src_ldate_e1 := if(ver_src_e1_pos > 0, Models.Common.getw(ver_sources_last_seen, ver_src_e1_pos), '0');

ver_src_ldate_e12 := common.sas_date((string)(ver_src_ldate_e1));

yr_ver_src_ldate_e1 := if(min(sysdate, ver_src_ldate_e12) = NULL, NULL, (sysdate - ver_src_ldate_e12) / 365.25);

mth_ver_src_ldate_e1 := if(min(sysdate, ver_src_ldate_e12) = NULL, NULL, (sysdate - ver_src_ldate_e12) / 30.5);

ver_src_cnt_e1 := if(ver_src_e1_pos > 0, (real)Models.Common.getw(ver_sources_count, ver_src_e1_pos), 0);

// ver_src_rcnt_21 := ver_src_rcnt_22 + ver_src_cnt_e1;

ver_src_e2_pos := Models.Common.findw_cpp(ver_sources, 'E2' , ' ,', 'ie');

ver_src_e2 := ver_src_e2_pos > 0;

ver_src_fdate_e2 := if(ver_src_e2_pos > 0, Models.Common.getw(ver_sources_first_seen, ver_src_e2_pos), '0');

ver_src_fdate_e22 := common.sas_date((string)(ver_src_fdate_e2));

yr_ver_src_fdate_e2 := if(min(sysdate, ver_src_fdate_e22) = NULL, NULL, (sysdate - ver_src_fdate_e22) / 365.25);

mth_ver_src_fdate_e2 := if(min(sysdate, ver_src_fdate_e22) = NULL, NULL, (sysdate - ver_src_fdate_e22) / 30.5);

ver_src_ldate_e2 := if(ver_src_e2_pos > 0, Models.Common.getw(ver_sources_last_seen, ver_src_e2_pos), '0');

ver_src_ldate_e22 := common.sas_date((string)(ver_src_ldate_e2));

yr_ver_src_ldate_e2 := if(min(sysdate, ver_src_ldate_e22) = NULL, NULL, (sysdate - ver_src_ldate_e22) / 365.25);

mth_ver_src_ldate_e2 := if(min(sysdate, ver_src_ldate_e22) = NULL, NULL, (sysdate - ver_src_ldate_e22) / 30.5);

ver_src_cnt_e2 := if(ver_src_e2_pos > 0, (real)Models.Common.getw(ver_sources_count, ver_src_e2_pos), 0);

// ver_src_rcnt_20 := ver_src_rcnt_21 + ver_src_cnt_e2;

ver_src_e3_pos := Models.Common.findw_cpp(ver_sources, 'E3' , ' ,', 'ie');

ver_src_e3 := ver_src_e3_pos > 0;

ver_src_fdate_e3 := if(ver_src_e3_pos > 0, Models.Common.getw(ver_sources_first_seen, ver_src_e3_pos), '0');

ver_src_fdate_e32 := common.sas_date((string)(ver_src_fdate_e3));

yr_ver_src_fdate_e3 := if(min(sysdate, ver_src_fdate_e32) = NULL, NULL, (sysdate - ver_src_fdate_e32) / 365.25);

mth_ver_src_fdate_e3 := if(min(sysdate, ver_src_fdate_e32) = NULL, NULL, (sysdate - ver_src_fdate_e32) / 30.5);

ver_src_ldate_e3 := if(ver_src_e3_pos > 0, Models.Common.getw(ver_sources_last_seen, ver_src_e3_pos), '0');

ver_src_ldate_e32 := common.sas_date((string)(ver_src_ldate_e3));

yr_ver_src_ldate_e3 := if(min(sysdate, ver_src_ldate_e32) = NULL, NULL, (sysdate - ver_src_ldate_e32) / 365.25);

mth_ver_src_ldate_e3 := if(min(sysdate, ver_src_ldate_e32) = NULL, NULL, (sysdate - ver_src_ldate_e32) / 30.5);

ver_src_cnt_e3 := if(ver_src_e3_pos > 0, (real)Models.Common.getw(ver_sources_count, ver_src_e3_pos), 0);

// ver_src_rcnt_19 := ver_src_rcnt_20 + ver_src_cnt_e3;

ver_src_e4_pos := Models.Common.findw_cpp(ver_sources, 'E4' , ' ,', 'ie');

ver_src_e4 := ver_src_e4_pos > 0;

ver_src_fdate_e4 := if(ver_src_e4_pos > 0, Models.Common.getw(ver_sources_first_seen, ver_src_e4_pos), '0');

ver_src_fdate_e42 := common.sas_date((string)(ver_src_fdate_e4));

yr_ver_src_fdate_e4 := if(min(sysdate, ver_src_fdate_e42) = NULL, NULL, (sysdate - ver_src_fdate_e42) / 365.25);

mth_ver_src_fdate_e4 := if(min(sysdate, ver_src_fdate_e42) = NULL, NULL, (sysdate - ver_src_fdate_e42) / 30.5);

ver_src_ldate_e4 := if(ver_src_e4_pos > 0, Models.Common.getw(ver_sources_last_seen, ver_src_e4_pos), '0');

ver_src_ldate_e42 := common.sas_date((string)(ver_src_ldate_e4));

yr_ver_src_ldate_e4 := if(min(sysdate, ver_src_ldate_e42) = NULL, NULL, (sysdate - ver_src_ldate_e42) / 365.25);

mth_ver_src_ldate_e4 := if(min(sysdate, ver_src_ldate_e42) = NULL, NULL, (sysdate - ver_src_ldate_e42) / 30.5);

ver_src_cnt_e4 := if(ver_src_e4_pos > 0, (real)Models.Common.getw(ver_sources_count, ver_src_e4_pos), 0);

// ver_src_rcnt_18 := ver_src_rcnt_19 + ver_src_cnt_e4;

ver_src_en_pos := Models.Common.findw_cpp(ver_sources, 'EN' , ' ,', 'ie');

ver_src_en := ver_src_en_pos > 0;

ver_src_fdate_en := if(ver_src_en_pos > 0, Models.Common.getw(ver_sources_first_seen, ver_src_en_pos), '0');

ver_src_fdate_en2 := common.sas_date((string)(ver_src_fdate_en));

yr_ver_src_fdate_en := if(min(sysdate, ver_src_fdate_en2) = NULL, NULL, (sysdate - ver_src_fdate_en2) / 365.25);

mth_ver_src_fdate_en := if(min(sysdate, ver_src_fdate_en2) = NULL, NULL, (sysdate - ver_src_fdate_en2) / 30.5);

ver_src_ldate_en := if(ver_src_en_pos > 0, Models.Common.getw(ver_sources_last_seen, ver_src_en_pos), '0');

ver_src_ldate_en2 := common.sas_date((string)(ver_src_ldate_en));

yr_ver_src_ldate_en := if(min(sysdate, ver_src_ldate_en2) = NULL, NULL, (sysdate - ver_src_ldate_en2) / 365.25);

mth_ver_src_ldate_en := if(min(sysdate, ver_src_ldate_en2) = NULL, NULL, (sysdate - ver_src_ldate_en2) / 30.5);

ver_src_cnt_en := if(ver_src_en_pos > 0, (real)Models.Common.getw(ver_sources_count, ver_src_en_pos), 0);

// ver_src_rcnt_17 := ver_src_rcnt_18 + ver_src_cnt_en;

ver_src_eq_pos := Models.Common.findw_cpp(ver_sources, 'EQ' , ' ,', 'ie');

ver_src_eq := ver_src_eq_pos > 0;

ver_src_fdate_eq := if(ver_src_eq_pos > 0, Models.Common.getw(ver_sources_first_seen, ver_src_eq_pos), '0');

ver_src_fdate_eq2 := common.sas_date((string)(ver_src_fdate_eq));

yr_ver_src_fdate_eq := if(min(sysdate, ver_src_fdate_eq2) = NULL, NULL, (sysdate - ver_src_fdate_eq2) / 365.25);

mth_ver_src_fdate_eq := if(min(sysdate, ver_src_fdate_eq2) = NULL, NULL, (sysdate - ver_src_fdate_eq2) / 30.5);

ver_src_ldate_eq := if(ver_src_eq_pos > 0, Models.Common.getw(ver_sources_last_seen, ver_src_eq_pos), '0');

ver_src_ldate_eq2 := common.sas_date((string)(ver_src_ldate_eq));

yr_ver_src_ldate_eq := if(min(sysdate, ver_src_ldate_eq2) = NULL, NULL, (sysdate - ver_src_ldate_eq2) / 365.25);

mth_ver_src_ldate_eq := if(min(sysdate, ver_src_ldate_eq2) = NULL, NULL, (sysdate - ver_src_ldate_eq2) / 30.5);

ver_src_cnt_eq := if(ver_src_eq_pos > 0, (real)Models.Common.getw(ver_sources_count, ver_src_eq_pos), 0);

// ver_src_rcnt_16 := ver_src_rcnt_17 + ver_src_cnt_eq;

ver_src_fe_pos := Models.Common.findw_cpp(ver_sources, 'FE' , ' ,', 'ie');

ver_src_fe := ver_src_fe_pos > 0;

ver_src_fdate_fe := if(ver_src_fe_pos > 0, Models.Common.getw(ver_sources_first_seen, ver_src_fe_pos), '0');

ver_src_fdate_fe2 := common.sas_date((string)(ver_src_fdate_fe));

yr_ver_src_fdate_fe := if(min(sysdate, ver_src_fdate_fe2) = NULL, NULL, (sysdate - ver_src_fdate_fe2) / 365.25);

mth_ver_src_fdate_fe := if(min(sysdate, ver_src_fdate_fe2) = NULL, NULL, (sysdate - ver_src_fdate_fe2) / 30.5);

ver_src_ldate_fe := if(ver_src_fe_pos > 0, Models.Common.getw(ver_sources_last_seen, ver_src_fe_pos), '0');

ver_src_ldate_fe2 := common.sas_date((string)(ver_src_ldate_fe));

yr_ver_src_ldate_fe := if(min(sysdate, ver_src_ldate_fe2) = NULL, NULL, (sysdate - ver_src_ldate_fe2) / 365.25);

mth_ver_src_ldate_fe := if(min(sysdate, ver_src_ldate_fe2) = NULL, NULL, (sysdate - ver_src_ldate_fe2) / 30.5);

ver_src_cnt_fe := if(ver_src_fe_pos > 0, (real)Models.Common.getw(ver_sources_count, ver_src_fe_pos), 0);

// ver_src_rcnt_15 := ver_src_rcnt_16 + ver_src_cnt_fe;

ver_src_ff_pos := Models.Common.findw_cpp(ver_sources, 'FF' , ' ,', 'ie');

ver_src_ff := ver_src_ff_pos > 0;

ver_src_fdate_ff := if(ver_src_ff_pos > 0, Models.Common.getw(ver_sources_first_seen, ver_src_ff_pos), '0');

ver_src_fdate_ff2 := common.sas_date((string)(ver_src_fdate_ff));

yr_ver_src_fdate_ff := if(min(sysdate, ver_src_fdate_ff2) = NULL, NULL, (sysdate - ver_src_fdate_ff2) / 365.25);

mth_ver_src_fdate_ff := if(min(sysdate, ver_src_fdate_ff2) = NULL, NULL, (sysdate - ver_src_fdate_ff2) / 30.5);

ver_src_ldate_ff := if(ver_src_ff_pos > 0, Models.Common.getw(ver_sources_last_seen, ver_src_ff_pos), '0');

ver_src_ldate_ff2 := common.sas_date((string)(ver_src_ldate_ff));

yr_ver_src_ldate_ff := if(min(sysdate, ver_src_ldate_ff2) = NULL, NULL, (sysdate - ver_src_ldate_ff2) / 365.25);

mth_ver_src_ldate_ff := if(min(sysdate, ver_src_ldate_ff2) = NULL, NULL, (sysdate - ver_src_ldate_ff2) / 30.5);

ver_src_cnt_ff := if(ver_src_ff_pos > 0, (real)Models.Common.getw(ver_sources_count, ver_src_ff_pos), 0);

// ver_src_rcnt_14 := ver_src_rcnt_15 + ver_src_cnt_ff;

ver_src_fr_pos := Models.Common.findw_cpp(ver_sources, 'FR' , ' ,', 'ie');

ver_src_fr := ver_src_fr_pos > 0;

ver_src_fdate_fr := if(ver_src_fr_pos > 0, Models.Common.getw(ver_sources_first_seen, ver_src_fr_pos), '0');

ver_src_fdate_fr2 := common.sas_date((string)(ver_src_fdate_fr));

yr_ver_src_fdate_fr := if(min(sysdate, ver_src_fdate_fr2) = NULL, NULL, (sysdate - ver_src_fdate_fr2) / 365.25);

mth_ver_src_fdate_fr := if(min(sysdate, ver_src_fdate_fr2) = NULL, NULL, (sysdate - ver_src_fdate_fr2) / 30.5);

ver_src_ldate_fr := if(ver_src_fr_pos > 0, Models.Common.getw(ver_sources_last_seen, ver_src_fr_pos), '0');

ver_src_ldate_fr2 := common.sas_date((string)(ver_src_ldate_fr));

yr_ver_src_ldate_fr := if(min(sysdate, ver_src_ldate_fr2) = NULL, NULL, (sysdate - ver_src_ldate_fr2) / 365.25);

mth_ver_src_ldate_fr := if(min(sysdate, ver_src_ldate_fr2) = NULL, NULL, (sysdate - ver_src_ldate_fr2) / 30.5);

ver_src_cnt_fr := if(ver_src_fr_pos > 0, (real)Models.Common.getw(ver_sources_count, ver_src_fr_pos), 0);

// ver_src_rcnt_13 := ver_src_rcnt_14 + ver_src_cnt_fr;

ver_src_l2_pos := Models.Common.findw_cpp(ver_sources, 'L2' , ' ,', 'ie');

ver_src_l2 := ver_src_l2_pos > 0;

ver_src_fdate_l2 := if(ver_src_l2_pos > 0, Models.Common.getw(ver_sources_first_seen, ver_src_l2_pos), '0');

ver_src_fdate_l22 := common.sas_date((string)(ver_src_fdate_l2));

yr_ver_src_fdate_l2 := if(min(sysdate, ver_src_fdate_l22) = NULL, NULL, (sysdate - ver_src_fdate_l22) / 365.25);

mth_ver_src_fdate_l2 := if(min(sysdate, ver_src_fdate_l22) = NULL, NULL, (sysdate - ver_src_fdate_l22) / 30.5);

ver_src_ldate_l2 := if(ver_src_l2_pos > 0, Models.Common.getw(ver_sources_last_seen, ver_src_l2_pos), '0');

ver_src_ldate_l22 := common.sas_date((string)(ver_src_ldate_l2));

yr_ver_src_ldate_l2 := if(min(sysdate, ver_src_ldate_l22) = NULL, NULL, (sysdate - ver_src_ldate_l22) / 365.25);

mth_ver_src_ldate_l2 := if(min(sysdate, ver_src_ldate_l22) = NULL, NULL, (sysdate - ver_src_ldate_l22) / 30.5);

ver_src_cnt_l2 := if(ver_src_l2_pos > 0, (real)Models.Common.getw(ver_sources_count, ver_src_l2_pos), 0);

// ver_src_rcnt_12 := ver_src_rcnt_13 + ver_src_cnt_l2;

ver_src_li_pos := Models.Common.findw_cpp(ver_sources, 'LI' , ' ,', 'ie');

ver_src_li := ver_src_li_pos > 0;

ver_src_fdate_li := if(ver_src_li_pos > 0, Models.Common.getw(ver_sources_first_seen, ver_src_li_pos), '0');

ver_src_fdate_li2 := common.sas_date((string)(ver_src_fdate_li));

yr_ver_src_fdate_li := if(min(sysdate, ver_src_fdate_li2) = NULL, NULL, (sysdate - ver_src_fdate_li2) / 365.25);

mth_ver_src_fdate_li := if(min(sysdate, ver_src_fdate_li2) = NULL, NULL, (sysdate - ver_src_fdate_li2) / 30.5);

ver_src_ldate_li := if(ver_src_li_pos > 0, Models.Common.getw(ver_sources_last_seen, ver_src_li_pos), '0');

ver_src_ldate_li2 := common.sas_date((string)(ver_src_ldate_li));

yr_ver_src_ldate_li := if(min(sysdate, ver_src_ldate_li2) = NULL, NULL, (sysdate - ver_src_ldate_li2) / 365.25);

mth_ver_src_ldate_li := if(min(sysdate, ver_src_ldate_li2) = NULL, NULL, (sysdate - ver_src_ldate_li2) / 30.5);

ver_src_cnt_li := if(ver_src_li_pos > 0, (real)Models.Common.getw(ver_sources_count, ver_src_li_pos), 0);

// ver_src_rcnt_11 := ver_src_rcnt_12 + ver_src_cnt_li;

ver_src_mw_pos := Models.Common.findw_cpp(ver_sources, 'MW' , ' ,', 'ie');

ver_src_mw := ver_src_mw_pos > 0;

ver_src_fdate_mw := if(ver_src_mw_pos > 0, Models.Common.getw(ver_sources_first_seen, ver_src_mw_pos), '0');

ver_src_fdate_mw2 := common.sas_date((string)(ver_src_fdate_mw));

yr_ver_src_fdate_mw := if(min(sysdate, ver_src_fdate_mw2) = NULL, NULL, (sysdate - ver_src_fdate_mw2) / 365.25);

mth_ver_src_fdate_mw := if(min(sysdate, ver_src_fdate_mw2) = NULL, NULL, (sysdate - ver_src_fdate_mw2) / 30.5);

ver_src_ldate_mw := if(ver_src_mw_pos > 0, Models.Common.getw(ver_sources_last_seen, ver_src_mw_pos), '0');

ver_src_ldate_mw2 := common.sas_date((string)(ver_src_ldate_mw));

yr_ver_src_ldate_mw := if(min(sysdate, ver_src_ldate_mw2) = NULL, NULL, (sysdate - ver_src_ldate_mw2) / 365.25);

mth_ver_src_ldate_mw := if(min(sysdate, ver_src_ldate_mw2) = NULL, NULL, (sysdate - ver_src_ldate_mw2) / 30.5);

ver_src_cnt_mw := if(ver_src_mw_pos > 0, (real)Models.Common.getw(ver_sources_count, ver_src_mw_pos), 0);

// ver_src_rcnt_10 := ver_src_rcnt_11 + ver_src_cnt_mw;

ver_src_nt_pos := Models.Common.findw_cpp(ver_sources, 'NT' , ' ,', 'ie');

ver_src_nt := ver_src_nt_pos > 0;

ver_src_fdate_nt := if(ver_src_nt_pos > 0, Models.Common.getw(ver_sources_first_seen, ver_src_nt_pos), '0');

ver_src_fdate_nt2 := common.sas_date((string)(ver_src_fdate_nt));

yr_ver_src_fdate_nt := if(min(sysdate, ver_src_fdate_nt2) = NULL, NULL, (sysdate - ver_src_fdate_nt2) / 365.25);

mth_ver_src_fdate_nt := if(min(sysdate, ver_src_fdate_nt2) = NULL, NULL, (sysdate - ver_src_fdate_nt2) / 30.5);

ver_src_ldate_nt := if(ver_src_nt_pos > 0, Models.Common.getw(ver_sources_last_seen, ver_src_nt_pos), '0');

ver_src_ldate_nt2 := common.sas_date((string)(ver_src_ldate_nt));

yr_ver_src_ldate_nt := if(min(sysdate, ver_src_ldate_nt2) = NULL, NULL, (sysdate - ver_src_ldate_nt2) / 365.25);

mth_ver_src_ldate_nt := if(min(sysdate, ver_src_ldate_nt2) = NULL, NULL, (sysdate - ver_src_ldate_nt2) / 30.5);

ver_src_cnt_nt := if(ver_src_nt_pos > 0, (real)Models.Common.getw(ver_sources_count, ver_src_nt_pos), 0);

// ver_src_rcnt_9 := ver_src_rcnt_10 + ver_src_cnt_nt;

ver_src_p_pos := Models.Common.findw_cpp(ver_sources, 'P' , ' ,', 'ie');

ver_src_p := ver_src_p_pos > 0;

ver_src_fdate_p := if(ver_src_p_pos > 0, Models.Common.getw(ver_sources_first_seen, ver_src_p_pos), '0');

ver_src_fdate_p2 := common.sas_date((string)(ver_src_fdate_p));

yr_ver_src_fdate_p := if(min(sysdate, ver_src_fdate_p2) = NULL, NULL, (sysdate - ver_src_fdate_p2) / 365.25);

mth_ver_src_fdate_p := if(min(sysdate, ver_src_fdate_p2) = NULL, NULL, (sysdate - ver_src_fdate_p2) / 30.5);

ver_src_ldate_p := if(ver_src_p_pos > 0, Models.Common.getw(ver_sources_last_seen, ver_src_p_pos), '0');

ver_src_ldate_p2 := common.sas_date((string)(ver_src_ldate_p));

yr_ver_src_ldate_p := if(min(sysdate, ver_src_ldate_p2) = NULL, NULL, (sysdate - ver_src_ldate_p2) / 365.25);

mth_ver_src_ldate_p := if(min(sysdate, ver_src_ldate_p2) = NULL, NULL, (sysdate - ver_src_ldate_p2) / 30.5);

ver_src_cnt_p := if(ver_src_p_pos > 0, (real)Models.Common.getw(ver_sources_count, ver_src_p_pos), 0);

// ver_src_rcnt_8 := ver_src_rcnt_9 + ver_src_cnt_p;

ver_src_pl_pos := Models.Common.findw_cpp(ver_sources, 'PL' , ' ,', 'ie');

ver_src_pl := ver_src_pl_pos > 0;

ver_src_fdate_pl := if(ver_src_pl_pos > 0, Models.Common.getw(ver_sources_first_seen, ver_src_pl_pos), '0');

ver_src_fdate_pl2 := common.sas_date((string)(ver_src_fdate_pl));

yr_ver_src_fdate_pl := if(min(sysdate, ver_src_fdate_pl2) = NULL, NULL, (sysdate - ver_src_fdate_pl2) / 365.25);

mth_ver_src_fdate_pl := if(min(sysdate, ver_src_fdate_pl2) = NULL, NULL, (sysdate - ver_src_fdate_pl2) / 30.5);

ver_src_ldate_pl := if(ver_src_pl_pos > 0, Models.Common.getw(ver_sources_last_seen, ver_src_pl_pos), '0');

ver_src_ldate_pl2 := common.sas_date((string)(ver_src_ldate_pl));

yr_ver_src_ldate_pl := if(min(sysdate, ver_src_ldate_pl2) = NULL, NULL, (sysdate - ver_src_ldate_pl2) / 365.25);

mth_ver_src_ldate_pl := if(min(sysdate, ver_src_ldate_pl2) = NULL, NULL, (sysdate - ver_src_ldate_pl2) / 30.5);

ver_src_cnt_pl := if(ver_src_pl_pos > 0, (real)Models.Common.getw(ver_sources_count, ver_src_pl_pos), 0);

// ver_src_rcnt_7 := ver_src_rcnt_8 + ver_src_cnt_pl;

ver_src_ts_pos := Models.Common.findw_cpp(ver_sources, 'TS' , ' ,', 'ie');

ver_src_ts := ver_src_ts_pos > 0;

ver_src_fdate_ts := if(ver_src_ts_pos > 0, Models.Common.getw(ver_sources_first_seen, ver_src_ts_pos), '0');

ver_src_fdate_ts2 := common.sas_date((string)(ver_src_fdate_ts));

yr_ver_src_fdate_ts := if(min(sysdate, ver_src_fdate_ts2) = NULL, NULL, (sysdate - ver_src_fdate_ts2) / 365.25);

mth_ver_src_fdate_ts := if(min(sysdate, ver_src_fdate_ts2) = NULL, NULL, (sysdate - ver_src_fdate_ts2) / 30.5);

ver_src_ldate_ts := if(ver_src_ts_pos > 0, Models.Common.getw(ver_sources_last_seen, ver_src_ts_pos), '0');

ver_src_ldate_ts2 := common.sas_date((string)(ver_src_ldate_ts));

yr_ver_src_ldate_ts := if(min(sysdate, ver_src_ldate_ts2) = NULL, NULL, (sysdate - ver_src_ldate_ts2) / 365.25);

mth_ver_src_ldate_ts := if(min(sysdate, ver_src_ldate_ts2) = NULL, NULL, (sysdate - ver_src_ldate_ts2) / 30.5);

ver_src_cnt_ts := if(ver_src_ts_pos > 0, (real)Models.Common.getw(ver_sources_count, ver_src_ts_pos), 0);

// ver_src_rcnt_6 := ver_src_rcnt_7 + ver_src_cnt_ts;

ver_src_tu_pos := Models.Common.findw_cpp(ver_sources, 'TU' , ' ,', 'ie');

ver_src_tu := ver_src_tu_pos > 0;

ver_src_fdate_tu := if(ver_src_tu_pos > 0, Models.Common.getw(ver_sources_first_seen, ver_src_tu_pos), '0');

ver_src_fdate_tu2 := common.sas_date((string)(ver_src_fdate_tu));

yr_ver_src_fdate_tu := if(min(sysdate, ver_src_fdate_tu2) = NULL, NULL, (sysdate - ver_src_fdate_tu2) / 365.25);

mth_ver_src_fdate_tu := if(min(sysdate, ver_src_fdate_tu2) = NULL, NULL, (sysdate - ver_src_fdate_tu2) / 30.5);

ver_src_ldate_tu := if(ver_src_tu_pos > 0, Models.Common.getw(ver_sources_last_seen, ver_src_tu_pos), '0');

ver_src_ldate_tu2 := common.sas_date((string)(ver_src_ldate_tu));

yr_ver_src_ldate_tu := if(min(sysdate, ver_src_ldate_tu2) = NULL, NULL, (sysdate - ver_src_ldate_tu2) / 365.25);

mth_ver_src_ldate_tu := if(min(sysdate, ver_src_ldate_tu2) = NULL, NULL, (sysdate - ver_src_ldate_tu2) / 30.5);

ver_src_cnt_tu := if(ver_src_tu_pos > 0, (real)Models.Common.getw(ver_sources_count, ver_src_tu_pos), 0);

// ver_src_rcnt_5 := ver_src_rcnt_6 + ver_src_cnt_tu;

ver_src_sl_pos := Models.Common.findw_cpp(ver_sources, 'SL' , ' ,', 'ie');

ver_src_sl := ver_src_sl_pos > 0;

ver_src_fdate_sl := if(ver_src_sl_pos > 0, Models.Common.getw(ver_sources_first_seen, ver_src_sl_pos), '0');

ver_src_fdate_sl2 := common.sas_date((string)(ver_src_fdate_sl));

yr_ver_src_fdate_sl := if(min(sysdate, ver_src_fdate_sl2) = NULL, NULL, (sysdate - ver_src_fdate_sl2) / 365.25);

mth_ver_src_fdate_sl := if(min(sysdate, ver_src_fdate_sl2) = NULL, NULL, (sysdate - ver_src_fdate_sl2) / 30.5);

ver_src_ldate_sl := if(ver_src_sl_pos > 0, Models.Common.getw(ver_sources_last_seen, ver_src_sl_pos), '0');

ver_src_ldate_sl2 := common.sas_date((string)(ver_src_ldate_sl));

yr_ver_src_ldate_sl := if(min(sysdate, ver_src_ldate_sl2) = NULL, NULL, (sysdate - ver_src_ldate_sl2) / 365.25);

mth_ver_src_ldate_sl := if(min(sysdate, ver_src_ldate_sl2) = NULL, NULL, (sysdate - ver_src_ldate_sl2) / 30.5);

ver_src_cnt_sl := if(ver_src_sl_pos > 0, (real)Models.Common.getw(ver_sources_count, ver_src_sl_pos), 0);

// ver_src_rcnt_4 := ver_src_rcnt_5 + ver_src_cnt_sl;

ver_src_v_pos := Models.Common.findw_cpp(ver_sources, 'V' , ' ,', 'ie');

ver_src_v := ver_src_v_pos > 0;

ver_src_fdate_v := if(ver_src_v_pos > 0, Models.Common.getw(ver_sources_first_seen, ver_src_v_pos), '0');

ver_src_fdate_v2 := common.sas_date((string)(ver_src_fdate_v));

yr_ver_src_fdate_v := if(min(sysdate, ver_src_fdate_v2) = NULL, NULL, (sysdate - ver_src_fdate_v2) / 365.25);

mth_ver_src_fdate_v := if(min(sysdate, ver_src_fdate_v2) = NULL, NULL, (sysdate - ver_src_fdate_v2) / 30.5);

ver_src_ldate_v := if(ver_src_v_pos > 0, Models.Common.getw(ver_sources_last_seen, ver_src_v_pos), '0');

ver_src_ldate_v2 := common.sas_date((string)(ver_src_ldate_v));

yr_ver_src_ldate_v := if(min(sysdate, ver_src_ldate_v2) = NULL, NULL, (sysdate - ver_src_ldate_v2) / 365.25);

mth_ver_src_ldate_v := if(min(sysdate, ver_src_ldate_v2) = NULL, NULL, (sysdate - ver_src_ldate_v2) / 30.5);

ver_src_cnt_v := if(ver_src_v_pos > 0, (real)Models.Common.getw(ver_sources_count, ver_src_v_pos), 0);

// ver_src_rcnt_3 := ver_src_rcnt_4 + ver_src_cnt_v;

ver_src_vo_pos := Models.Common.findw_cpp(ver_sources, 'VO' , ' ,', 'ie');

ver_src_vo := ver_src_vo_pos > 0;

ver_src_fdate_vo := if(ver_src_vo_pos > 0, Models.Common.getw(ver_sources_first_seen, ver_src_vo_pos), '0');

ver_src_fdate_vo2 := common.sas_date((string)(ver_src_fdate_vo));

yr_ver_src_fdate_vo := if(min(sysdate, ver_src_fdate_vo2) = NULL, NULL, (sysdate - ver_src_fdate_vo2) / 365.25);

mth_ver_src_fdate_vo := if(min(sysdate, ver_src_fdate_vo2) = NULL, NULL, (sysdate - ver_src_fdate_vo2) / 30.5);

ver_src_ldate_vo := if(ver_src_vo_pos > 0, Models.Common.getw(ver_sources_last_seen, ver_src_vo_pos), '0');

ver_src_ldate_vo2 := common.sas_date((string)(ver_src_ldate_vo));

yr_ver_src_ldate_vo := if(min(sysdate, ver_src_ldate_vo2) = NULL, NULL, (sysdate - ver_src_ldate_vo2) / 365.25);

mth_ver_src_ldate_vo := if(min(sysdate, ver_src_ldate_vo2) = NULL, NULL, (sysdate - ver_src_ldate_vo2) / 30.5);

ver_src_cnt_vo := if(ver_src_vo_pos > 0, (real)Models.Common.getw(ver_sources_count, ver_src_vo_pos), 0);

// ver_src_rcnt_2 := ver_src_rcnt_3 + ver_src_cnt_vo;

ver_src_w_pos := Models.Common.findw_cpp(ver_sources, 'W' , ' ,', 'ie');

ver_src_w := ver_src_w_pos > 0;

ver_src_fdate_w := if(ver_src_w_pos > 0, Models.Common.getw(ver_sources_first_seen, ver_src_w_pos), '0');

ver_src_fdate_w2 := common.sas_date((string)(ver_src_fdate_w));

yr_ver_src_fdate_w := if(min(sysdate, ver_src_fdate_w2) = NULL, NULL, (sysdate - ver_src_fdate_w2) / 365.25);

mth_ver_src_fdate_w := if(min(sysdate, ver_src_fdate_w2) = NULL, NULL, (sysdate - ver_src_fdate_w2) / 30.5);

ver_src_ldate_w := if(ver_src_w_pos > 0, Models.Common.getw(ver_sources_last_seen, ver_src_w_pos), '0');

ver_src_ldate_w2 := common.sas_date((string)(ver_src_ldate_w));

yr_ver_src_ldate_w := if(min(sysdate, ver_src_ldate_w2) = NULL, NULL, (sysdate - ver_src_ldate_w2) / 365.25);

mth_ver_src_ldate_w := if(min(sysdate, ver_src_ldate_w2) = NULL, NULL, (sysdate - ver_src_ldate_w2) / 30.5);

ver_src_cnt_w := if(ver_src_w_pos > 0, (real)Models.Common.getw(ver_sources_count, ver_src_w_pos), 0);

// ver_src_rcnt_1 := ver_src_rcnt_2 + ver_src_cnt_w;

ver_src_wp_pos := Models.Common.findw_cpp(ver_sources, 'WP' , ' ,', 'ie');

ver_src_wp := ver_src_wp_pos > 0;

ver_src_fdate_wp := if(ver_src_wp_pos > 0, Models.Common.getw(ver_sources_first_seen, ver_src_wp_pos), '0');

ver_src_fdate_wp2 := common.sas_date((string)(ver_src_fdate_wp));

yr_ver_src_fdate_wp := if(min(sysdate, ver_src_fdate_wp2) = NULL, NULL, (sysdate - ver_src_fdate_wp2) / 365.25);

mth_ver_src_fdate_wp := if(min(sysdate, ver_src_fdate_wp2) = NULL, NULL, (sysdate - ver_src_fdate_wp2) / 30.5);

ver_src_ldate_wp := if(ver_src_wp_pos > 0, Models.Common.getw(ver_sources_last_seen, ver_src_wp_pos), '0');

ver_src_ldate_wp2 := common.sas_date((string)(ver_src_ldate_wp));

yr_ver_src_ldate_wp := if(min(sysdate, ver_src_ldate_wp2) = NULL, NULL, (sysdate - ver_src_ldate_wp2) / 365.25);

mth_ver_src_ldate_wp := if(min(sysdate, ver_src_ldate_wp2) = NULL, NULL, (sysdate - ver_src_ldate_wp2) / 30.5);

ver_src_cnt_wp := if(ver_src_wp_pos > 0, (real)Models.Common.getw(ver_sources_count, ver_src_wp_pos), 0);

// ver_src_rcnt := ver_src_rcnt_1 + ver_src_cnt_wp;

ver_dob_src_cnt := Models.Common.countw((string)(ver_dob_sources), ' !$%&()*+,-./;<^|');

ver_dob_src_pop := ver_dob_src_cnt > 0;

ver_dob_src_fsrc := Models.Common.getw(ver_dob_sources, 1);

ver_dob_src_fsrc_fdate := Models.Common.getw(ver_dob_sources_first_seen, 1);

ver_dob_src_fsrc_fdate2 := common.sas_date((string)(ver_dob_src_fsrc_fdate));

yr_ver_dob_src_fsrc_fdate := if(min(sysdate, ver_dob_src_fsrc_fdate2) = NULL, NULL, (sysdate - ver_dob_src_fsrc_fdate2) / 365.25);

mth_ver_dob_src_fsrc_fdate := if(min(sysdate, ver_dob_src_fsrc_fdate2) = NULL, NULL, (sysdate - ver_dob_src_fsrc_fdate2) / 30.5);

ver_dob_src_ak_pos := Models.Common.findw_cpp(ver_dob_sources, 'AK' , ' ,', 'ie');

ver_dob_src_ak := ver_dob_src_ak_pos > 0;

ver_dob_src_fdate_ak := if(ver_dob_src_ak_pos > 0, Models.Common.getw(ver_dob_sources_first_seen, ver_dob_src_ak_pos), '0');

ver_dob_src_fdate_ak2 := common.sas_date((string)(ver_dob_src_fdate_ak));

yr_ver_dob_src_fdate_ak := if(min(sysdate, ver_dob_src_fdate_ak2) = NULL, NULL, (sysdate - ver_dob_src_fdate_ak2) / 365.25);

mth_ver_dob_src_fdate_ak := if(min(sysdate, ver_dob_src_fdate_ak2) = NULL, NULL, (sysdate - ver_dob_src_fdate_ak2) / 30.5);

ver_dob_src_cnt_ak := if(ver_dob_src_ak_pos > 0, (real)Models.Common.getw(ver_dob_sources_count, ver_dob_src_ak_pos), 0);

// ver_dob_src_rcnt_35 := ver_dob_src_rcnt + ver_dob_src_cnt_ak;

ver_dob_src_am_pos := Models.Common.findw_cpp(ver_dob_sources, 'AM' , ' ,', 'ie');

ver_dob_src_am := ver_dob_src_am_pos > 0;

ver_dob_src_fdate_am := if(ver_dob_src_am_pos > 0, Models.Common.getw(ver_dob_sources_first_seen, ver_dob_src_am_pos), '0');

ver_dob_src_fdate_am2 := common.sas_date((string)(ver_dob_src_fdate_am));

yr_ver_dob_src_fdate_am := if(min(sysdate, ver_dob_src_fdate_am2) = NULL, NULL, (sysdate - ver_dob_src_fdate_am2) / 365.25);

mth_ver_dob_src_fdate_am := if(min(sysdate, ver_dob_src_fdate_am2) = NULL, NULL, (sysdate - ver_dob_src_fdate_am2) / 30.5);

ver_dob_src_cnt_am := if(ver_dob_src_am_pos > 0, (real)Models.Common.getw(ver_dob_sources_count, ver_dob_src_am_pos), 0);

// ver_dob_src_rcnt_34 := ver_dob_src_rcnt_35 + ver_dob_src_cnt_am;

ver_dob_src_ar_pos := Models.Common.findw_cpp(ver_dob_sources, 'AR' , ' ,', 'ie');

ver_dob_src_ar := ver_dob_src_ar_pos > 0;

ver_dob_src_fdate_ar := if(ver_dob_src_ar_pos > 0, Models.Common.getw(ver_dob_sources_first_seen, ver_dob_src_ar_pos), '0');

ver_dob_src_fdate_ar2 := common.sas_date((string)(ver_dob_src_fdate_ar));

yr_ver_dob_src_fdate_ar := if(min(sysdate, ver_dob_src_fdate_ar2) = NULL, NULL, (sysdate - ver_dob_src_fdate_ar2) / 365.25);

mth_ver_dob_src_fdate_ar := if(min(sysdate, ver_dob_src_fdate_ar2) = NULL, NULL, (sysdate - ver_dob_src_fdate_ar2) / 30.5);

ver_dob_src_cnt_ar := if(ver_dob_src_ar_pos > 0, (real)Models.Common.getw(ver_dob_sources_count, ver_dob_src_ar_pos), 0);

// ver_dob_src_rcnt_33 := ver_dob_src_rcnt_34 + ver_dob_src_cnt_ar;

ver_dob_src_ba_pos := Models.Common.findw_cpp(ver_dob_sources, 'BA' , ' ,', 'ie');

ver_dob_src_ba := ver_dob_src_ba_pos > 0;

ver_dob_src_fdate_ba := if(ver_dob_src_ba_pos > 0, Models.Common.getw(ver_dob_sources_first_seen, ver_dob_src_ba_pos), '0');

ver_dob_src_fdate_ba2 := common.sas_date((string)(ver_dob_src_fdate_ba));

yr_ver_dob_src_fdate_ba := if(min(sysdate, ver_dob_src_fdate_ba2) = NULL, NULL, (sysdate - ver_dob_src_fdate_ba2) / 365.25);

mth_ver_dob_src_fdate_ba := if(min(sysdate, ver_dob_src_fdate_ba2) = NULL, NULL, (sysdate - ver_dob_src_fdate_ba2) / 30.5);

ver_dob_src_cnt_ba := if(ver_dob_src_ba_pos > 0, (real)Models.Common.getw(ver_dob_sources_count, ver_dob_src_ba_pos), 0);

// ver_dob_src_rcnt_32 := ver_dob_src_rcnt_33 + ver_dob_src_cnt_ba;

ver_dob_src_cg_pos := Models.Common.findw_cpp(ver_dob_sources, 'CG' , ' ,', 'ie');

ver_dob_src_cg := ver_dob_src_cg_pos > 0;

ver_dob_src_fdate_cg := if(ver_dob_src_cg_pos > 0, Models.Common.getw(ver_dob_sources_first_seen, ver_dob_src_cg_pos), '0');

ver_dob_src_fdate_cg2 := common.sas_date((string)(ver_dob_src_fdate_cg));

yr_ver_dob_src_fdate_cg := if(min(sysdate, ver_dob_src_fdate_cg2) = NULL, NULL, (sysdate - ver_dob_src_fdate_cg2) / 365.25);

mth_ver_dob_src_fdate_cg := if(min(sysdate, ver_dob_src_fdate_cg2) = NULL, NULL, (sysdate - ver_dob_src_fdate_cg2) / 30.5);

ver_dob_src_cnt_cg := if(ver_dob_src_cg_pos > 0, (real)Models.Common.getw(ver_dob_sources_count, ver_dob_src_cg_pos), 0);

// ver_dob_src_rcnt_31 := ver_dob_src_rcnt_32 + ver_dob_src_cnt_cg;

ver_dob_src_co_pos := Models.Common.findw_cpp(ver_dob_sources, 'CO' , ' ,', 'ie');

ver_dob_src_co := ver_dob_src_co_pos > 0;

ver_dob_src_fdate_co := if(ver_dob_src_co_pos > 0, Models.Common.getw(ver_dob_sources_first_seen, ver_dob_src_co_pos), '0');

ver_dob_src_fdate_co2 := common.sas_date((string)(ver_dob_src_fdate_co));

yr_ver_dob_src_fdate_co := if(min(sysdate, ver_dob_src_fdate_co2) = NULL, NULL, (sysdate - ver_dob_src_fdate_co2) / 365.25);

mth_ver_dob_src_fdate_co := if(min(sysdate, ver_dob_src_fdate_co2) = NULL, NULL, (sysdate - ver_dob_src_fdate_co2) / 30.5);

ver_dob_src_cnt_co := if(ver_dob_src_co_pos > 0, (real)Models.Common.getw(ver_dob_sources_count, ver_dob_src_co_pos), 0);

// ver_dob_src_rcnt_30 := ver_dob_src_rcnt_31 + ver_dob_src_cnt_co;

ver_dob_src_cy_pos := Models.Common.findw_cpp(ver_dob_sources, 'CY' , ' ,', 'ie');

ver_dob_src_cy := ver_dob_src_cy_pos > 0;

ver_dob_src_fdate_cy := if(ver_dob_src_cy_pos > 0, Models.Common.getw(ver_dob_sources_first_seen, ver_dob_src_cy_pos), '0');

ver_dob_src_fdate_cy2 := common.sas_date((string)(ver_dob_src_fdate_cy));

yr_ver_dob_src_fdate_cy := if(min(sysdate, ver_dob_src_fdate_cy2) = NULL, NULL, (sysdate - ver_dob_src_fdate_cy2) / 365.25);

mth_ver_dob_src_fdate_cy := if(min(sysdate, ver_dob_src_fdate_cy2) = NULL, NULL, (sysdate - ver_dob_src_fdate_cy2) / 30.5);

ver_dob_src_cnt_cy := if(ver_dob_src_cy_pos > 0, (real)Models.Common.getw(ver_dob_sources_count, ver_dob_src_cy_pos), 0);

// ver_dob_src_rcnt_29 := ver_dob_src_rcnt_30 + ver_dob_src_cnt_cy;

ver_dob_src_da_pos := Models.Common.findw_cpp(ver_dob_sources, 'DA' , ' ,', 'ie');

ver_dob_src_da := ver_dob_src_da_pos > 0;

ver_dob_src_fdate_da := if(ver_dob_src_da_pos > 0, Models.Common.getw(ver_dob_sources_first_seen, ver_dob_src_da_pos), '0');

ver_dob_src_fdate_da2 := common.sas_date((string)(ver_dob_src_fdate_da));

yr_ver_dob_src_fdate_da := if(min(sysdate, ver_dob_src_fdate_da2) = NULL, NULL, (sysdate - ver_dob_src_fdate_da2) / 365.25);

mth_ver_dob_src_fdate_da := if(min(sysdate, ver_dob_src_fdate_da2) = NULL, NULL, (sysdate - ver_dob_src_fdate_da2) / 30.5);

ver_dob_src_cnt_da := if(ver_dob_src_da_pos > 0, (real)Models.Common.getw(ver_dob_sources_count, ver_dob_src_da_pos), 0);

// ver_dob_src_rcnt_28 := ver_dob_src_rcnt_29 + ver_dob_src_cnt_da;

ver_dob_src_d_pos := Models.Common.findw_cpp(ver_dob_sources, 'D' , ' ,', 'ie');

ver_dob_src_d := ver_dob_src_d_pos > 0;

ver_dob_src_fdate_d := if(ver_dob_src_d_pos > 0, Models.Common.getw(ver_dob_sources_first_seen, ver_dob_src_d_pos), '0');

ver_dob_src_fdate_d2 := common.sas_date((string)(ver_dob_src_fdate_d));

yr_ver_dob_src_fdate_d := if(min(sysdate, ver_dob_src_fdate_d2) = NULL, NULL, (sysdate - ver_dob_src_fdate_d2) / 365.25);

mth_ver_dob_src_fdate_d := if(min(sysdate, ver_dob_src_fdate_d2) = NULL, NULL, (sysdate - ver_dob_src_fdate_d2) / 30.5);

ver_dob_src_cnt_d := if(ver_dob_src_d_pos > 0, (real)Models.Common.getw(ver_dob_sources_count, ver_dob_src_d_pos), 0);

// ver_dob_src_rcnt_27 := ver_dob_src_rcnt_28 + ver_dob_src_cnt_d;

ver_dob_src_dl_pos := Models.Common.findw_cpp(ver_dob_sources, 'DL' , ' ,', 'ie');

ver_dob_src_dl := ver_dob_src_dl_pos > 0;

ver_dob_src_fdate_dl := if(ver_dob_src_dl_pos > 0, Models.Common.getw(ver_dob_sources_first_seen, ver_dob_src_dl_pos), '0');

ver_dob_src_fdate_dl2 := common.sas_date((string)(ver_dob_src_fdate_dl));

yr_ver_dob_src_fdate_dl := if(min(sysdate, ver_dob_src_fdate_dl2) = NULL, NULL, (sysdate - ver_dob_src_fdate_dl2) / 365.25);

mth_ver_dob_src_fdate_dl := if(min(sysdate, ver_dob_src_fdate_dl2) = NULL, NULL, (sysdate - ver_dob_src_fdate_dl2) / 30.5);

ver_dob_src_cnt_dl := if(ver_dob_src_dl_pos > 0, (real)Models.Common.getw(ver_dob_sources_count, ver_dob_src_dl_pos), 0);

// ver_dob_src_rcnt_26 := ver_dob_src_rcnt_27 + ver_dob_src_cnt_dl;

ver_dob_src_ds_pos := Models.Common.findw_cpp(ver_dob_sources, 'DS' , ' ,', 'ie');

ver_dob_src_ds := ver_dob_src_ds_pos > 0;

ver_dob_src_fdate_ds := if(ver_dob_src_ds_pos > 0, Models.Common.getw(ver_dob_sources_first_seen, ver_dob_src_ds_pos), '0');

ver_dob_src_fdate_ds2 := common.sas_date((string)(ver_dob_src_fdate_ds));

yr_ver_dob_src_fdate_ds := if(min(sysdate, ver_dob_src_fdate_ds2) = NULL, NULL, (sysdate - ver_dob_src_fdate_ds2) / 365.25);

mth_ver_dob_src_fdate_ds := if(min(sysdate, ver_dob_src_fdate_ds2) = NULL, NULL, (sysdate - ver_dob_src_fdate_ds2) / 30.5);

ver_dob_src_cnt_ds := if(ver_dob_src_ds_pos > 0, (real)Models.Common.getw(ver_dob_sources_count, ver_dob_src_ds_pos), 0);

// ver_dob_src_rcnt_25 := ver_dob_src_rcnt_26 + ver_dob_src_cnt_ds;

ver_dob_src_de_pos := Models.Common.findw_cpp(ver_dob_sources, 'DE' , ' ,', 'ie');

ver_dob_src_de := ver_dob_src_de_pos > 0;

ver_dob_src_fdate_de := if(ver_dob_src_de_pos > 0, Models.Common.getw(ver_dob_sources_first_seen, ver_dob_src_de_pos), '0');

ver_dob_src_fdate_de2 := common.sas_date((string)(ver_dob_src_fdate_de));

yr_ver_dob_src_fdate_de := if(min(sysdate, ver_dob_src_fdate_de2) = NULL, NULL, (sysdate - ver_dob_src_fdate_de2) / 365.25);

mth_ver_dob_src_fdate_de := if(min(sysdate, ver_dob_src_fdate_de2) = NULL, NULL, (sysdate - ver_dob_src_fdate_de2) / 30.5);

ver_dob_src_cnt_de := if(ver_dob_src_de_pos > 0, (real)Models.Common.getw(ver_dob_sources_count, ver_dob_src_de_pos), 0);

// ver_dob_src_rcnt_24 := ver_dob_src_rcnt_25 + ver_dob_src_cnt_de;

ver_dob_src_eb_pos := Models.Common.findw_cpp(ver_dob_sources, 'EB' , ' ,', 'ie');

ver_dob_src_eb := ver_dob_src_eb_pos > 0;

ver_dob_src_fdate_eb := if(ver_dob_src_eb_pos > 0, Models.Common.getw(ver_dob_sources_first_seen, ver_dob_src_eb_pos), '0');

ver_dob_src_fdate_eb2 := common.sas_date((string)(ver_dob_src_fdate_eb));

yr_ver_dob_src_fdate_eb := if(min(sysdate, ver_dob_src_fdate_eb2) = NULL, NULL, (sysdate - ver_dob_src_fdate_eb2) / 365.25);

mth_ver_dob_src_fdate_eb := if(min(sysdate, ver_dob_src_fdate_eb2) = NULL, NULL, (sysdate - ver_dob_src_fdate_eb2) / 30.5);

ver_dob_src_cnt_eb := if(ver_dob_src_eb_pos > 0, (real)Models.Common.getw(ver_dob_sources_count, ver_dob_src_eb_pos), 0);

// ver_dob_src_rcnt_23 := ver_dob_src_rcnt_24 + ver_dob_src_cnt_eb;

ver_dob_src_em_pos := Models.Common.findw_cpp(ver_dob_sources, 'EM' , ' ,', 'ie');

ver_dob_src_em := ver_dob_src_em_pos > 0;

ver_dob_src_fdate_em := if(ver_dob_src_em_pos > 0, Models.Common.getw(ver_dob_sources_first_seen, ver_dob_src_em_pos), '0');

ver_dob_src_fdate_em2 := common.sas_date((string)(ver_dob_src_fdate_em));

yr_ver_dob_src_fdate_em := if(min(sysdate, ver_dob_src_fdate_em2) = NULL, NULL, (sysdate - ver_dob_src_fdate_em2) / 365.25);

mth_ver_dob_src_fdate_em := if(min(sysdate, ver_dob_src_fdate_em2) = NULL, NULL, (sysdate - ver_dob_src_fdate_em2) / 30.5);

ver_dob_src_cnt_em := if(ver_dob_src_em_pos > 0, (real)Models.Common.getw(ver_dob_sources_count, ver_dob_src_em_pos), 0);

// ver_dob_src_rcnt_22 := ver_dob_src_rcnt_23 + ver_dob_src_cnt_em;

ver_dob_src_e1_pos := Models.Common.findw_cpp(ver_dob_sources, 'E1' , ' ,', 'ie');

ver_dob_src_e1 := ver_dob_src_e1_pos > 0;

ver_dob_src_fdate_e1 := if(ver_dob_src_e1_pos > 0, Models.Common.getw(ver_dob_sources_first_seen, ver_dob_src_e1_pos), '0');

ver_dob_src_fdate_e12 := common.sas_date((string)(ver_dob_src_fdate_e1));

yr_ver_dob_src_fdate_e1 := if(min(sysdate, ver_dob_src_fdate_e12) = NULL, NULL, (sysdate - ver_dob_src_fdate_e12) / 365.25);

mth_ver_dob_src_fdate_e1 := if(min(sysdate, ver_dob_src_fdate_e12) = NULL, NULL, (sysdate - ver_dob_src_fdate_e12) / 30.5);

ver_dob_src_cnt_e1 := if(ver_dob_src_e1_pos > 0, (real)Models.Common.getw(ver_dob_sources_count, ver_dob_src_e1_pos), 0);

// ver_dob_src_rcnt_21 := ver_dob_src_rcnt_22 + ver_dob_src_cnt_e1;

ver_dob_src_e2_pos := Models.Common.findw_cpp(ver_dob_sources, 'E2' , ' ,', 'ie');

ver_dob_src_e2 := ver_dob_src_e2_pos > 0;

ver_dob_src_fdate_e2 := if(ver_dob_src_e2_pos > 0, Models.Common.getw(ver_dob_sources_first_seen, ver_dob_src_e2_pos), '0');

ver_dob_src_fdate_e22 := common.sas_date((string)(ver_dob_src_fdate_e2));

yr_ver_dob_src_fdate_e2 := if(min(sysdate, ver_dob_src_fdate_e22) = NULL, NULL, (sysdate - ver_dob_src_fdate_e22) / 365.25);

mth_ver_dob_src_fdate_e2 := if(min(sysdate, ver_dob_src_fdate_e22) = NULL, NULL, (sysdate - ver_dob_src_fdate_e22) / 30.5);

ver_dob_src_cnt_e2 := if(ver_dob_src_e2_pos > 0, (real)Models.Common.getw(ver_dob_sources_count, ver_dob_src_e2_pos), 0);

// ver_dob_src_rcnt_20 := ver_dob_src_rcnt_21 + ver_dob_src_cnt_e2;

ver_dob_src_e3_pos := Models.Common.findw_cpp(ver_dob_sources, 'E3' , ' ,', 'ie');

ver_dob_src_e3 := ver_dob_src_e3_pos > 0;

ver_dob_src_fdate_e3 := if(ver_dob_src_e3_pos > 0, Models.Common.getw(ver_dob_sources_first_seen, ver_dob_src_e3_pos), '0');

ver_dob_src_fdate_e32 := common.sas_date((string)(ver_dob_src_fdate_e3));

yr_ver_dob_src_fdate_e3 := if(min(sysdate, ver_dob_src_fdate_e32) = NULL, NULL, (sysdate - ver_dob_src_fdate_e32) / 365.25);

mth_ver_dob_src_fdate_e3 := if(min(sysdate, ver_dob_src_fdate_e32) = NULL, NULL, (sysdate - ver_dob_src_fdate_e32) / 30.5);

ver_dob_src_cnt_e3 := if(ver_dob_src_e3_pos > 0, (real)Models.Common.getw(ver_dob_sources_count, ver_dob_src_e3_pos), 0);

// ver_dob_src_rcnt_19 := ver_dob_src_rcnt_20 + ver_dob_src_cnt_e3;

ver_dob_src_e4_pos := Models.Common.findw_cpp(ver_dob_sources, 'E4' , ' ,', 'ie');

ver_dob_src_e4 := ver_dob_src_e4_pos > 0;

ver_dob_src_fdate_e4 := if(ver_dob_src_e4_pos > 0, Models.Common.getw(ver_dob_sources_first_seen, ver_dob_src_e4_pos), '0');

ver_dob_src_fdate_e42 := common.sas_date((string)(ver_dob_src_fdate_e4));

yr_ver_dob_src_fdate_e4 := if(min(sysdate, ver_dob_src_fdate_e42) = NULL, NULL, (sysdate - ver_dob_src_fdate_e42) / 365.25);

mth_ver_dob_src_fdate_e4 := if(min(sysdate, ver_dob_src_fdate_e42) = NULL, NULL, (sysdate - ver_dob_src_fdate_e42) / 30.5);

ver_dob_src_cnt_e4 := if(ver_dob_src_e4_pos > 0, (real)Models.Common.getw(ver_dob_sources_count, ver_dob_src_e4_pos), 0);

// ver_dob_src_rcnt_18 := ver_dob_src_rcnt_19 + ver_dob_src_cnt_e4;

ver_dob_src_en_pos := Models.Common.findw_cpp(ver_dob_sources, 'EN' , ' ,', 'ie');

ver_dob_src_en := ver_dob_src_en_pos > 0;

ver_dob_src_fdate_en := if(ver_dob_src_en_pos > 0, Models.Common.getw(ver_dob_sources_first_seen, ver_dob_src_en_pos), '0');

ver_dob_src_fdate_en2 := common.sas_date((string)(ver_dob_src_fdate_en));

yr_ver_dob_src_fdate_en := if(min(sysdate, ver_dob_src_fdate_en2) = NULL, NULL, (sysdate - ver_dob_src_fdate_en2) / 365.25);

mth_ver_dob_src_fdate_en := if(min(sysdate, ver_dob_src_fdate_en2) = NULL, NULL, (sysdate - ver_dob_src_fdate_en2) / 30.5);

ver_dob_src_cnt_en := if(ver_dob_src_en_pos > 0, (real)Models.Common.getw(ver_dob_sources_count, ver_dob_src_en_pos), 0);

// ver_dob_src_rcnt_17 := ver_dob_src_rcnt_18 + ver_dob_src_cnt_en;

ver_dob_src_eq_pos := Models.Common.findw_cpp(ver_dob_sources, 'EQ' , ' ,', 'ie');

ver_dob_src_eq := ver_dob_src_eq_pos > 0;

ver_dob_src_fdate_eq := if(ver_dob_src_eq_pos > 0, Models.Common.getw(ver_dob_sources_first_seen, ver_dob_src_eq_pos), '0');

ver_dob_src_fdate_eq2 := common.sas_date((string)(ver_dob_src_fdate_eq));

yr_ver_dob_src_fdate_eq := if(min(sysdate, ver_dob_src_fdate_eq2) = NULL, NULL, (sysdate - ver_dob_src_fdate_eq2) / 365.25);

mth_ver_dob_src_fdate_eq := if(min(sysdate, ver_dob_src_fdate_eq2) = NULL, NULL, (sysdate - ver_dob_src_fdate_eq2) / 30.5);

ver_dob_src_cnt_eq := if(ver_dob_src_eq_pos > 0, (real)Models.Common.getw(ver_dob_sources_count, ver_dob_src_eq_pos), 0);

// ver_dob_src_rcnt_16 := ver_dob_src_rcnt_17 + ver_dob_src_cnt_eq;

ver_dob_src_fe_pos := Models.Common.findw_cpp(ver_dob_sources, 'FE' , ' ,', 'ie');

ver_dob_src_fe := ver_dob_src_fe_pos > 0;

ver_dob_src_fdate_fe := if(ver_dob_src_fe_pos > 0, Models.Common.getw(ver_dob_sources_first_seen, ver_dob_src_fe_pos), '0');

ver_dob_src_fdate_fe2 := common.sas_date((string)(ver_dob_src_fdate_fe));

yr_ver_dob_src_fdate_fe := if(min(sysdate, ver_dob_src_fdate_fe2) = NULL, NULL, (sysdate - ver_dob_src_fdate_fe2) / 365.25);

mth_ver_dob_src_fdate_fe := if(min(sysdate, ver_dob_src_fdate_fe2) = NULL, NULL, (sysdate - ver_dob_src_fdate_fe2) / 30.5);

ver_dob_src_cnt_fe := if(ver_dob_src_fe_pos > 0, (real)Models.Common.getw(ver_dob_sources_count, ver_dob_src_fe_pos), 0);

// ver_dob_src_rcnt_15 := ver_dob_src_rcnt_16 + ver_dob_src_cnt_fe;

ver_dob_src_ff_pos := Models.Common.findw_cpp(ver_dob_sources, 'FF' , ' ,', 'ie');

ver_dob_src_ff := ver_dob_src_ff_pos > 0;

ver_dob_src_fdate_ff := if(ver_dob_src_ff_pos > 0, Models.Common.getw(ver_dob_sources_first_seen, ver_dob_src_ff_pos), '0');

ver_dob_src_fdate_ff2 := common.sas_date((string)(ver_dob_src_fdate_ff));

yr_ver_dob_src_fdate_ff := if(min(sysdate, ver_dob_src_fdate_ff2) = NULL, NULL, (sysdate - ver_dob_src_fdate_ff2) / 365.25);

mth_ver_dob_src_fdate_ff := if(min(sysdate, ver_dob_src_fdate_ff2) = NULL, NULL, (sysdate - ver_dob_src_fdate_ff2) / 30.5);

ver_dob_src_cnt_ff := if(ver_dob_src_ff_pos > 0, (real)Models.Common.getw(ver_dob_sources_count, ver_dob_src_ff_pos), 0);

// ver_dob_src_rcnt_14 := ver_dob_src_rcnt_15 + ver_dob_src_cnt_ff;

ver_dob_src_fr_pos := Models.Common.findw_cpp(ver_dob_sources, 'FR' , ' ,', 'ie');

ver_dob_src_fr := ver_dob_src_fr_pos > 0;

ver_dob_src_fdate_fr := if(ver_dob_src_fr_pos > 0, Models.Common.getw(ver_dob_sources_first_seen, ver_dob_src_fr_pos), '0');

ver_dob_src_fdate_fr2 := common.sas_date((string)(ver_dob_src_fdate_fr));

yr_ver_dob_src_fdate_fr := if(min(sysdate, ver_dob_src_fdate_fr2) = NULL, NULL, (sysdate - ver_dob_src_fdate_fr2) / 365.25);

mth_ver_dob_src_fdate_fr := if(min(sysdate, ver_dob_src_fdate_fr2) = NULL, NULL, (sysdate - ver_dob_src_fdate_fr2) / 30.5);

ver_dob_src_cnt_fr := if(ver_dob_src_fr_pos > 0, (real)Models.Common.getw(ver_dob_sources_count, ver_dob_src_fr_pos), 0);

// ver_dob_src_rcnt_13 := ver_dob_src_rcnt_14 + ver_dob_src_cnt_fr;

ver_dob_src_l2_pos := Models.Common.findw_cpp(ver_dob_sources, 'L2' , ' ,', 'ie');

ver_dob_src_l2 := ver_dob_src_l2_pos > 0;

ver_dob_src_fdate_l2 := if(ver_dob_src_l2_pos > 0, Models.Common.getw(ver_dob_sources_first_seen, ver_dob_src_l2_pos), '0');

ver_dob_src_fdate_l22 := common.sas_date((string)(ver_dob_src_fdate_l2));

yr_ver_dob_src_fdate_l2 := if(min(sysdate, ver_dob_src_fdate_l22) = NULL, NULL, (sysdate - ver_dob_src_fdate_l22) / 365.25);

mth_ver_dob_src_fdate_l2 := if(min(sysdate, ver_dob_src_fdate_l22) = NULL, NULL, (sysdate - ver_dob_src_fdate_l22) / 30.5);

ver_dob_src_cnt_l2 := if(ver_dob_src_l2_pos > 0, (real)Models.Common.getw(ver_dob_sources_count, ver_dob_src_l2_pos), 0);

// ver_dob_src_rcnt_12 := ver_dob_src_rcnt_13 + ver_dob_src_cnt_l2;

ver_dob_src_li_pos := Models.Common.findw_cpp(ver_dob_sources, 'LI' , ' ,', 'ie');

ver_dob_src_li := ver_dob_src_li_pos > 0;

ver_dob_src_fdate_li := if(ver_dob_src_li_pos > 0, Models.Common.getw(ver_dob_sources_first_seen, ver_dob_src_li_pos), '0');

ver_dob_src_fdate_li2 := common.sas_date((string)(ver_dob_src_fdate_li));

yr_ver_dob_src_fdate_li := if(min(sysdate, ver_dob_src_fdate_li2) = NULL, NULL, (sysdate - ver_dob_src_fdate_li2) / 365.25);

mth_ver_dob_src_fdate_li := if(min(sysdate, ver_dob_src_fdate_li2) = NULL, NULL, (sysdate - ver_dob_src_fdate_li2) / 30.5);

ver_dob_src_cnt_li := if(ver_dob_src_li_pos > 0, (real)Models.Common.getw(ver_dob_sources_count, ver_dob_src_li_pos), 0);

// ver_dob_src_rcnt_11 := ver_dob_src_rcnt_12 + ver_dob_src_cnt_li;

ver_dob_src_mw_pos := Models.Common.findw_cpp(ver_dob_sources, 'MW' , ' ,', 'ie');

ver_dob_src_mw := ver_dob_src_mw_pos > 0;

ver_dob_src_fdate_mw := if(ver_dob_src_mw_pos > 0, Models.Common.getw(ver_dob_sources_first_seen, ver_dob_src_mw_pos), '0');

ver_dob_src_fdate_mw2 := common.sas_date((string)(ver_dob_src_fdate_mw));

yr_ver_dob_src_fdate_mw := if(min(sysdate, ver_dob_src_fdate_mw2) = NULL, NULL, (sysdate - ver_dob_src_fdate_mw2) / 365.25);

mth_ver_dob_src_fdate_mw := if(min(sysdate, ver_dob_src_fdate_mw2) = NULL, NULL, (sysdate - ver_dob_src_fdate_mw2) / 30.5);

ver_dob_src_cnt_mw := if(ver_dob_src_mw_pos > 0, (real)Models.Common.getw(ver_dob_sources_count, ver_dob_src_mw_pos), 0);

// ver_dob_src_rcnt_10 := ver_dob_src_rcnt_11 + ver_dob_src_cnt_mw;

ver_dob_src_nt_pos := Models.Common.findw_cpp(ver_dob_sources, 'NT' , ' ,', 'ie');

ver_dob_src_nt := ver_dob_src_nt_pos > 0;

ver_dob_src_fdate_nt := if(ver_dob_src_nt_pos > 0, Models.Common.getw(ver_dob_sources_first_seen, ver_dob_src_nt_pos), '0');

ver_dob_src_fdate_nt2 := common.sas_date((string)(ver_dob_src_fdate_nt));

yr_ver_dob_src_fdate_nt := if(min(sysdate, ver_dob_src_fdate_nt2) = NULL, NULL, (sysdate - ver_dob_src_fdate_nt2) / 365.25);

mth_ver_dob_src_fdate_nt := if(min(sysdate, ver_dob_src_fdate_nt2) = NULL, NULL, (sysdate - ver_dob_src_fdate_nt2) / 30.5);

ver_dob_src_cnt_nt := if(ver_dob_src_nt_pos > 0, (real)Models.Common.getw(ver_dob_sources_count, ver_dob_src_nt_pos), 0);

// ver_dob_src_rcnt_9 := ver_dob_src_rcnt_10 + ver_dob_src_cnt_nt;

ver_dob_src_p_pos := Models.Common.findw_cpp(ver_dob_sources, 'P' , ' ,', 'ie');

ver_dob_src_p := ver_dob_src_p_pos > 0;

ver_dob_src_fdate_p := if(ver_dob_src_p_pos > 0, Models.Common.getw(ver_dob_sources_first_seen, ver_dob_src_p_pos), '0');

ver_dob_src_fdate_p2 := common.sas_date((string)(ver_dob_src_fdate_p));

yr_ver_dob_src_fdate_p := if(min(sysdate, ver_dob_src_fdate_p2) = NULL, NULL, (sysdate - ver_dob_src_fdate_p2) / 365.25);

mth_ver_dob_src_fdate_p := if(min(sysdate, ver_dob_src_fdate_p2) = NULL, NULL, (sysdate - ver_dob_src_fdate_p2) / 30.5);

ver_dob_src_cnt_p := if(ver_dob_src_p_pos > 0, (real)Models.Common.getw(ver_dob_sources_count, ver_dob_src_p_pos), 0);

// ver_dob_src_rcnt_8 := ver_dob_src_rcnt_9 + ver_dob_src_cnt_p;

ver_dob_src_pl_pos := Models.Common.findw_cpp(ver_dob_sources, 'PL' , ' ,', 'ie');

ver_dob_src_pl := ver_dob_src_pl_pos > 0;

ver_dob_src_fdate_pl := if(ver_dob_src_pl_pos > 0, Models.Common.getw(ver_dob_sources_first_seen, ver_dob_src_pl_pos), '0');

ver_dob_src_fdate_pl2 := common.sas_date((string)(ver_dob_src_fdate_pl));

yr_ver_dob_src_fdate_pl := if(min(sysdate, ver_dob_src_fdate_pl2) = NULL, NULL, (sysdate - ver_dob_src_fdate_pl2) / 365.25);

mth_ver_dob_src_fdate_pl := if(min(sysdate, ver_dob_src_fdate_pl2) = NULL, NULL, (sysdate - ver_dob_src_fdate_pl2) / 30.5);

ver_dob_src_cnt_pl := if(ver_dob_src_pl_pos > 0, (real)Models.Common.getw(ver_dob_sources_count, ver_dob_src_pl_pos), 0);

// ver_dob_src_rcnt_7 := ver_dob_src_rcnt_8 + ver_dob_src_cnt_pl;

ver_dob_src_ts_pos := Models.Common.findw_cpp(ver_dob_sources, 'TS' , ' ,', 'ie');

ver_dob_src_ts := ver_dob_src_ts_pos > 0;

ver_dob_src_fdate_ts := if(ver_dob_src_ts_pos > 0, Models.Common.getw(ver_dob_sources_first_seen, ver_dob_src_ts_pos), '0');

ver_dob_src_fdate_ts2 := common.sas_date((string)(ver_dob_src_fdate_ts));

yr_ver_dob_src_fdate_ts := if(min(sysdate, ver_dob_src_fdate_ts2) = NULL, NULL, (sysdate - ver_dob_src_fdate_ts2) / 365.25);

mth_ver_dob_src_fdate_ts := if(min(sysdate, ver_dob_src_fdate_ts2) = NULL, NULL, (sysdate - ver_dob_src_fdate_ts2) / 30.5);

ver_dob_src_cnt_ts := if(ver_dob_src_ts_pos > 0, (real)Models.Common.getw(ver_dob_sources_count, ver_dob_src_ts_pos), 0);

// ver_dob_src_rcnt_6 := ver_dob_src_rcnt_7 + ver_dob_src_cnt_ts;

ver_dob_src_tu_pos := Models.Common.findw_cpp(ver_dob_sources, 'TU' , ' ,', 'ie');

ver_dob_src_tu := ver_dob_src_tu_pos > 0;

ver_dob_src_fdate_tu := if(ver_dob_src_tu_pos > 0, Models.Common.getw(ver_dob_sources_first_seen, ver_dob_src_tu_pos), '0');

ver_dob_src_fdate_tu2 := common.sas_date((string)(ver_dob_src_fdate_tu));

yr_ver_dob_src_fdate_tu := if(min(sysdate, ver_dob_src_fdate_tu2) = NULL, NULL, (sysdate - ver_dob_src_fdate_tu2) / 365.25);

mth_ver_dob_src_fdate_tu := if(min(sysdate, ver_dob_src_fdate_tu2) = NULL, NULL, (sysdate - ver_dob_src_fdate_tu2) / 30.5);

ver_dob_src_cnt_tu := if(ver_dob_src_tu_pos > 0, (real)Models.Common.getw(ver_dob_sources_count, ver_dob_src_tu_pos), 0);

// ver_dob_src_rcnt_5 := ver_dob_src_rcnt_6 + ver_dob_src_cnt_tu;

ver_dob_src_sl_pos := Models.Common.findw_cpp(ver_dob_sources, 'SL' , ' ,', 'ie');

ver_dob_src_sl := ver_dob_src_sl_pos > 0;

ver_dob_src_fdate_sl := if(ver_dob_src_sl_pos > 0, Models.Common.getw(ver_dob_sources_first_seen, ver_dob_src_sl_pos), '0');

ver_dob_src_fdate_sl2 := common.sas_date((string)(ver_dob_src_fdate_sl));

yr_ver_dob_src_fdate_sl := if(min(sysdate, ver_dob_src_fdate_sl2) = NULL, NULL, (sysdate - ver_dob_src_fdate_sl2) / 365.25);

mth_ver_dob_src_fdate_sl := if(min(sysdate, ver_dob_src_fdate_sl2) = NULL, NULL, (sysdate - ver_dob_src_fdate_sl2) / 30.5);

ver_dob_src_cnt_sl := if(ver_dob_src_sl_pos > 0, (real)Models.Common.getw(ver_dob_sources_count, ver_dob_src_sl_pos), 0);

// ver_dob_src_rcnt_4 := ver_dob_src_rcnt_5 + ver_dob_src_cnt_sl;

ver_dob_src_v_pos := Models.Common.findw_cpp(ver_dob_sources, 'V' , ' ,', 'ie');

ver_dob_src_v := ver_dob_src_v_pos > 0;

ver_dob_src_fdate_v := if(ver_dob_src_v_pos > 0, Models.Common.getw(ver_dob_sources_first_seen, ver_dob_src_v_pos), '0');

ver_dob_src_fdate_v2 := common.sas_date((string)(ver_dob_src_fdate_v));

yr_ver_dob_src_fdate_v := if(min(sysdate, ver_dob_src_fdate_v2) = NULL, NULL, (sysdate - ver_dob_src_fdate_v2) / 365.25);

mth_ver_dob_src_fdate_v := if(min(sysdate, ver_dob_src_fdate_v2) = NULL, NULL, (sysdate - ver_dob_src_fdate_v2) / 30.5);

ver_dob_src_cnt_v := if(ver_dob_src_v_pos > 0, (real)Models.Common.getw(ver_dob_sources_count, ver_dob_src_v_pos), 0);

// ver_dob_src_rcnt_3 := ver_dob_src_rcnt_4 + ver_dob_src_cnt_v;

ver_dob_src_vo_pos := Models.Common.findw_cpp(ver_dob_sources, 'VO' , ' ,', 'ie');

ver_dob_src_vo := ver_dob_src_vo_pos > 0;

ver_dob_src_fdate_vo := if(ver_dob_src_vo_pos > 0, Models.Common.getw(ver_dob_sources_first_seen, ver_dob_src_vo_pos), '0');

ver_dob_src_fdate_vo2 := common.sas_date((string)(ver_dob_src_fdate_vo));

yr_ver_dob_src_fdate_vo := if(min(sysdate, ver_dob_src_fdate_vo2) = NULL, NULL, (sysdate - ver_dob_src_fdate_vo2) / 365.25);

mth_ver_dob_src_fdate_vo := if(min(sysdate, ver_dob_src_fdate_vo2) = NULL, NULL, (sysdate - ver_dob_src_fdate_vo2) / 30.5);

ver_dob_src_cnt_vo := if(ver_dob_src_vo_pos > 0, (real)Models.Common.getw(ver_dob_sources_count, ver_dob_src_vo_pos), 0);

// ver_dob_src_rcnt_2 := ver_dob_src_rcnt_3 + ver_dob_src_cnt_vo;

ver_dob_src_w_pos := Models.Common.findw_cpp(ver_dob_sources, 'W' , ' ,', 'ie');

ver_dob_src_w := ver_dob_src_w_pos > 0;

ver_dob_src_fdate_w := if(ver_dob_src_w_pos > 0, Models.Common.getw(ver_dob_sources_first_seen, ver_dob_src_w_pos), '0');

ver_dob_src_fdate_w2 := common.sas_date((string)(ver_dob_src_fdate_w));

yr_ver_dob_src_fdate_w := if(min(sysdate, ver_dob_src_fdate_w2) = NULL, NULL, (sysdate - ver_dob_src_fdate_w2) / 365.25);

mth_ver_dob_src_fdate_w := if(min(sysdate, ver_dob_src_fdate_w2) = NULL, NULL, (sysdate - ver_dob_src_fdate_w2) / 30.5);

ver_dob_src_cnt_w := if(ver_dob_src_w_pos > 0, (real)Models.Common.getw(ver_dob_sources_count, ver_dob_src_w_pos), 0);

// ver_dob_src_rcnt_1 := ver_dob_src_rcnt_2 + ver_dob_src_cnt_w;

ver_dob_src_wp_pos := Models.Common.findw_cpp(ver_dob_sources, 'WP' , ' ,', 'ie');

ver_dob_src_wp := ver_dob_src_wp_pos > 0;

ver_dob_src_fdate_wp := if(ver_dob_src_wp_pos > 0, Models.Common.getw(ver_dob_sources_first_seen, ver_dob_src_wp_pos), '0');

ver_dob_src_fdate_wp2 := common.sas_date((string)(ver_dob_src_fdate_wp));

yr_ver_dob_src_fdate_wp := if(min(sysdate, ver_dob_src_fdate_wp2) = NULL, NULL, (sysdate - ver_dob_src_fdate_wp2) / 365.25);

mth_ver_dob_src_fdate_wp := if(min(sysdate, ver_dob_src_fdate_wp2) = NULL, NULL, (sysdate - ver_dob_src_fdate_wp2) / 30.5);

ver_dob_src_cnt_wp := if(ver_dob_src_wp_pos > 0, (real)Models.Common.getw(ver_dob_sources_count, ver_dob_src_wp_pos), 0);

// ver_dob_src_rcnt := ver_dob_src_rcnt_1 + ver_dob_src_cnt_wp;

email_src_cnt := Models.Common.countw((string)(email_source_list), ' !$%&()*+,-./;<^|');

email_src_pop := email_src_cnt > 0;

email_src_fsrc := Models.Common.getw(email_source_list, 1);

email_src_fsrc_fdate := Models.Common.getw(email_source_first_seen, 1);

email_src_fsrc_fdate2 := common.sas_date((string)(email_src_fsrc_fdate));

yr_email_src_fsrc_fdate := if(min(sysdate, email_src_fsrc_fdate2) = NULL, NULL, (sysdate - email_src_fsrc_fdate2) / 365.25);

mth_email_src_fsrc_fdate := if(min(sysdate, email_src_fsrc_fdate2) = NULL, NULL, (sysdate - email_src_fsrc_fdate2) / 30.5);

email_src_aw_pos := Models.Common.findw_cpp(email_source_list, 'AW' , ' ,', 'ie');

email_src_aw := email_src_aw_pos > 0;

email_src_fdate_aw := if(email_src_aw_pos > 0, Models.Common.getw(email_source_first_seen, email_src_aw_pos), '0');

email_src_fdate_aw2 := common.sas_date((string)(email_src_fdate_aw));

yr_email_src_fdate_aw := if(min(sysdate, email_src_fdate_aw2) = NULL, NULL, (sysdate - email_src_fdate_aw2) / 365.25);

mth_email_src_fdate_aw := if(min(sysdate, email_src_fdate_aw2) = NULL, NULL, (sysdate - email_src_fdate_aw2) / 30.5);

email_src_cnt_aw := if(email_src_aw_pos > 0, (real)Models.Common.getw(email_source_count, email_src_aw_pos), 0);

// email_src_rcnt_5 := email_src_rcnt + email_src_cnt_aw;

email_src_et_pos := Models.Common.findw_cpp(email_source_list, 'ET' , ' ,', 'ie');

email_src_et := email_src_et_pos > 0;

email_src_fdate_et := if(email_src_et_pos > 0, Models.Common.getw(email_source_first_seen, email_src_et_pos), '0');

email_src_fdate_et2 := common.sas_date((string)(email_src_fdate_et));

yr_email_src_fdate_et := if(min(sysdate, email_src_fdate_et2) = NULL, NULL, (sysdate - email_src_fdate_et2) / 365.25);

mth_email_src_fdate_et := if(min(sysdate, email_src_fdate_et2) = NULL, NULL, (sysdate - email_src_fdate_et2) / 30.5);

email_src_cnt_et := if(email_src_et_pos > 0, (real)Models.Common.getw(email_source_count, email_src_et_pos), 0);

// email_src_rcnt_4 := email_src_rcnt_5 + email_src_cnt_et;

email_src_im_pos := Models.Common.findw_cpp(email_source_list, 'IM' , ' ,', 'ie');

email_src_im_1 := email_src_im_pos > 0;

email_src_fdate_im := if(email_src_im_pos > 0, Models.Common.getw(email_source_first_seen, email_src_im_pos), '0');

email_src_fdate_im2 := common.sas_date((string)(email_src_fdate_im));

yr_email_src_fdate_im := if(min(sysdate, email_src_fdate_im2) = NULL, NULL, (sysdate - email_src_fdate_im2) / 365.25);

mth_email_src_fdate_im := if(min(sysdate, email_src_fdate_im2) = NULL, NULL, (sysdate - email_src_fdate_im2) / 30.5);

email_src_cnt_im := if(email_src_im_pos > 0, (real)Models.Common.getw(email_source_count, email_src_im_pos), 0);

// email_src_rcnt_3 := email_src_rcnt_4 + email_src_cnt_im;

email_src_wa_pos := Models.Common.findw_cpp(email_source_list, 'W@' , ' ,', 'ie');

email_src_wa := email_src_wa_pos > 0;

email_src_fdate_wa := if(email_src_wa_pos > 0, Models.Common.getw(email_source_first_seen, email_src_wa_pos), '0');

email_src_fdate_wa2 := common.sas_date((string)(email_src_fdate_wa));

yr_email_src_fdate_wa := if(min(sysdate, email_src_fdate_wa2) = NULL, NULL, (sysdate - email_src_fdate_wa2) / 365.25);

mth_email_src_fdate_wa := if(min(sysdate, email_src_fdate_wa2) = NULL, NULL, (sysdate - email_src_fdate_wa2) / 30.5);

email_src_cnt_wa := if(email_src_wa_pos > 0, (real)Models.Common.getw(email_source_count, email_src_wa_pos), 0);

// email_src_rcnt_2 := email_src_rcnt_3 + email_src_cnt_wa;

email_src_om_pos := Models.Common.findw_cpp(email_source_list, 'OM' , ' ,', 'ie');

email_src_om := email_src_om_pos > 0;

email_src_fdate_om := if(email_src_om_pos > 0, Models.Common.getw(email_source_first_seen, email_src_om_pos), '0');

email_src_fdate_om2 := common.sas_date((string)(email_src_fdate_om));

yr_email_src_fdate_om := if(min(sysdate, email_src_fdate_om2) = NULL, NULL, (sysdate - email_src_fdate_om2) / 365.25);

mth_email_src_fdate_om := if(min(sysdate, email_src_fdate_om2) = NULL, NULL, (sysdate - email_src_fdate_om2) / 30.5);

email_src_cnt_om := if(email_src_om_pos > 0, (real)Models.Common.getw(email_source_count, email_src_om_pos), 0);

// email_src_rcnt_1 := email_src_rcnt_2 + email_src_cnt_om;

email_src_m1_pos := Models.Common.findw_cpp(email_source_list, 'M1' , ' ,', 'ie');

email_src_m1 := email_src_m1_pos > 0;

email_src_fdate_m1 := if(email_src_m1_pos > 0, Models.Common.getw(email_source_first_seen, email_src_m1_pos), '0');

email_src_fdate_m12 := common.sas_date((string)(email_src_fdate_m1));

yr_email_src_fdate_m1 := if(min(sysdate, email_src_fdate_m12) = NULL, NULL, (sysdate - email_src_fdate_m12) / 365.25);

mth_email_src_fdate_m1 := if(min(sysdate, email_src_fdate_m12) = NULL, NULL, (sysdate - email_src_fdate_m12) / 30.5);

email_src_cnt_m1 := if(email_src_m1_pos > 0, (real)Models.Common.getw(email_source_count, email_src_m1_pos), 0);

// email_src_rcnt := email_src_rcnt_1 + email_src_cnt_m1;

add_ec1 := (StringLib.StringToUpperCase(trim(out_addr_status, LEFT)))[1..1];

add_ec3 := (StringLib.StringToUpperCase(trim(out_addr_status, LEFT)))[3..3];

add_ec4 := (StringLib.StringToUpperCase(trim(out_addr_status, LEFT)))[4..4];

add_apt := StringLib.StringToUpperCase(trim(rc_dwelltype, LEFT, RIGHT)) = 'A' or StringLib.StringToUpperCase(trim(out_addr_type, LEFT, RIGHT)) = 'H' or out_unit_desig != ' ' or out_sec_range != ' ';

phn_disconnected := (integer)rc_hriskphoneflag = 5;

phn_inval := (integer)rc_phonevalflag = 0 or (integer)rc_hphonevalflag = 0 or (rc_phonetype in ['5']);

phn_highrisk2 := not((rc_hriskphoneflag in ['0', '7']));

phn_notpots := not((telcordia_type in ['00', '50', '51', '52', '54']));

phn_cell := (rc_hriskphoneflag in ['1', '3']) or (rc_hphonetypeflag in ['1', '3']);

phn_zipmismatch := (integer)rc_phonezipflag = 1 or (integer)rc_pwphonezipflag = 1;

phn_business := (integer)rc_hphonevalflag = 1;

ssn_issued18 := (integer)rc_pwssnvalflag = 5;

ssn_deceased := (integer)rc_decsflag = 1 or (integer)ver_src_ds = 1;

ssn_adl_prob := ssns_per_adl = 0 or ssns_per_adl >= 3 or ssns_per_adl_c6 >= 2;

impulse_count_1 := 0;

email_src_im := 0;

impulse_flag := impulse_count_1 > 0;

bk_flag := (rc_bansflag in ['1', '2']) or (integer)ver_src_ba = 1 or (integer)bankrupt = 1 or filing_count > 0 or bk_recent_count > 0;

lien_rec_unrel_flag := liens_recent_unreleased_count > 0;

lien_hist_unrel_flag := liens_historical_unreleased_ct > 0;

lien_flag := (integer)ver_src_l2 = 1 or (integer)ver_src_li = 1 or lien_rec_unrel_flag or lien_hist_unrel_flag;

pk_property_owner := if(Add1_NaProp = 4 or Property_Owned_Total > 0, 1, 0);

pk_impulse_count := min(2, if(impulse_count_1 = NULL, -NULL, impulse_count_1));

pk_yr_in_dob := truncate(yr_in_dob);

pk_age_estimate := if(pk_yr_in_dob > 0, pk_yr_in_dob, inferred_age);

bs_attr_derog_flag := if(attr_total_number_derogs > 0, 1, 0);

bs_attr_eviction_flag := if(attr_eviction_count > 0, 1, 0);

bs_attr_derog_flag2 := if(bs_attr_derog_flag > 0 or (integer)lien_flag > 0 or bs_attr_eviction_flag > 0 or pk_impulse_count > 0 or (integer)bk_flag > 0 or (integer)ssn_deceased > 0, 1, 0);

scored_222s_1 := if(max(property_owned_total, property_sold_total) = NULL, NULL, sum(if(property_owned_total = NULL, 0, property_owned_total), if(property_sold_total = NULL, 0, property_sold_total))) > 0 OR (90 <= combo_dobscore AND combo_dobscore <= 100 or (integer)input_dob_match_level >= 7 or (integer)lien_flag > 0 or criminal_count > 0 or (integer)bk_flag > 0 or ssn_deceased or truedid);

pk_222_flag := if(riskview.constants.noscore(le.iid.nas_summary,le.iid.nap_summary, le.address_verification.input_address_information.naprop, le.truedid), 1, 0);

pk_segment_40 := map(
    (integer)ssn_deceased > 0        => 'X 200  ',
    pk_222_flag = 1         => 'X 222  ',
    bs_attr_derog_flag2 = 1 => '0 Derog',
    pk_age_estimate <= 24   => '1 Young',
    pk_property_owner = 1   => '2 Owner',
                               '3 Other');

pk_age_estimate_s0 := map(
    pk_age_estimate <= 20 => 0,
    pk_age_estimate <= 22 => 1,
    pk_age_estimate <= 27 => 2,
    pk_age_estimate <= 30 => 3,
    pk_age_estimate <= 33 => 4,
    pk_age_estimate <= 47 => 5,
    pk_age_estimate <= 61 => 6,
                             7);

pk_age_estimate_s1 := map(
    pk_age_estimate <= 18 => 0,
    pk_age_estimate <= 19 => 1,
    pk_age_estimate <= 20 => 2,
    pk_age_estimate <= 21 => 3,
    pk_age_estimate <= 23 => 4,
                             5);

pk_age_estimate_s2 := map(
    pk_age_estimate <= 27 => 0,
    pk_age_estimate <= 30 => 1,
    pk_age_estimate <= 34 => 2,
    pk_age_estimate <= 38 => 3,
    pk_age_estimate <= 47 => 4,
    pk_age_estimate <= 56 => 5,
                             6);

pk_age_estimate_s3 := map(
    pk_age_estimate <= 32 => 0,
    pk_age_estimate <= 40 => 1,
    pk_age_estimate <= 47 => 2,
    pk_age_estimate <= 54 => 3,
                             4);

pk_estimated_income_s0 := map(
    estimated_income <= 20000  => 0,
    estimated_income <= 23000  => 1,
    estimated_income <= 25000  => 2,
    estimated_income <= 27000  => 3,
    estimated_income <= 30000  => 4,
    estimated_income <= 35000  => 5,
    estimated_income <= 95000  => 6,
    estimated_income <= 125000 => 7,
                                  8);

pk_estimated_income_s1 := map(
    estimated_income <= 20000 => 0,
    estimated_income <= 21000 => 1,
    estimated_income <= 24000 => 2,
    estimated_income <= 25000 => 3,
    estimated_income <= 28000 => 4,
    estimated_income <= 30000 => 5,
    estimated_income <= 35000 => 6,
    estimated_income <= 40000 => 7,
    estimated_income <= 55000 => 8,
    estimated_income <= 70000 => 9,
    estimated_income <= 95000 => 10,
                                 11);

pk_estimated_income_s2 := map(
    estimated_income <= 35000  => 0,
    estimated_income <= 45000  => 1,
    estimated_income <= 80000  => 2,
    estimated_income <= 155000 => 3,
                                  4);

pk_estimated_income_s3 := map(
    estimated_income <= 21000  => 0,
    estimated_income <= 24000  => 1,
    estimated_income <= 27000  => 2,
    estimated_income <= 29000  => 3,
    estimated_income <= 100000 => 4,
                                  5);

pk_add1_avm_auto_val_s0 := map(
    add1_avm_automated_valuation <= 0      => -1,
    add1_avm_automated_valuation <= 50000  => 0,
    add1_avm_automated_valuation <= 80000  => 1,
    add1_avm_automated_valuation <= 200000 => 2,
    add1_avm_automated_valuation <= 420000 => 3,
                                              4);

pk_add1_avm_auto_val_s1 := map(
    add1_avm_automated_valuation <= 0      => -1,
    add1_avm_automated_valuation <= 70000  => 0,
    add1_avm_automated_valuation <= 100000 => 1,
    add1_avm_automated_valuation <= 180000 => 2,
    add1_avm_automated_valuation <= 220000 => 3,
    add1_avm_automated_valuation <= 320000 => 4,
    add1_avm_automated_valuation <= 560000 => 5,
                                              6);

pk_add1_avm_auto_val_s2 := map(
    add1_avm_automated_valuation <= 0      => -1,
    add1_avm_automated_valuation <= 90000  => 0,
    add1_avm_automated_valuation <= 140000 => 1,
    add1_avm_automated_valuation <= 240000 => 2,
    add1_avm_automated_valuation <= 480000 => 3,
                                              4);

pk_add1_avm_auto_val_s3 := map(
    add1_avm_automated_valuation <= 0      => -1,
    add1_avm_automated_valuation <= 80000  => 0,
    add1_avm_automated_valuation <= 340000 => 1,
    add1_avm_automated_valuation <= 500000 => 2,
                                              3);

pk_verx_s0 := map(
    (nas_summary in [10, 11, 12]) and (nap_summary in [9, 10, 11, 12]) => 4,
    (nas_summary in [10, 11, 12]) and nap_summary = 0                  => 2,
    (nas_summary in [10, 11, 12]) and nap_summary = 1                  => 1,
    (nas_summary in [10, 11, 12])                                      => 3,
    nap_summary = 12                                                   => 1,
    (nap_summary in [9, 10, 11])                                       => 1,
                                                                          0);

pk_verx_s1 := map(
    (nas_summary in [10, 11, 12]) and (nap_summary in [9, 10, 11, 12]) => 2,
    (nas_summary in [10, 11, 12]) and nap_summary = 0                  => 1,
    (nas_summary in [10, 11, 12]) and nap_summary = 1                  => 0,
    (nas_summary in [10, 11, 12])                                      => 1,
    nap_summary = 12                                                   => 0,
    (nap_summary in [9, 10, 11])                                       => 0,
                                                                          0);

pk_verx_s3 := map(
    (nas_summary in [10, 11, 12]) and (nap_summary in [9, 10, 11, 12]) => 4,
    (nas_summary in [10, 11, 12]) and nap_summary = 0                  => 2,
    (nas_summary in [10, 11, 12]) and nap_summary = 1                  => 1,
    (nas_summary in [10, 11, 12])                                      => 3,
    nap_summary = 12                                                   => 1,
    (nap_summary in [9, 10, 11])                                       => 1,
                                                                          0);

inq_first_log_date2 := common.sas_date((string)(inq_first_log_date));

yr_inq_first_log_date := if(min(sysdate, inq_first_log_date2) = NULL, NULL, (sysdate - inq_first_log_date2) / 365.25);

mth_inq_first_log_date := if(min(sysdate, inq_first_log_date2) = NULL, NULL, (sysdate - inq_first_log_date2) / 30.5);

pk_mth_inq_first_log_date := if (mth_inq_first_log_date >= 0, roundup(mth_inq_first_log_date), truncate(mth_inq_first_log_date));

pk_inq_recent_lvl := map(
    inq_count03 >= 2 => 4,
    inq_count06 >= 2 => 3,
    inq_count12 >= 2 => 2,
    inq_count03 >= 1 => 2,
    inq_count06 >= 1 => 1,
    inq_count12 >= 1 => 1,
                        0);

pk_inq_recent_lvl_s0 := pk_inq_recent_lvl;

pk_inq_recent_lvl_s1 := pk_inq_recent_lvl;

pk_inq_recent_lvl_s3 := pk_inq_recent_lvl;

pk_mth_inq_frst_log_dt2_s2 := map(
    pk_mth_inq_first_log_date = NULL => 0,
    pk_mth_inq_first_log_date <= 3   => 2,
    pk_mth_inq_first_log_date <= 12  => 1,
                                        0);

pk_impulse_flag := if((integer)impulse_flag > 0 or email_src_im > 0, 1, 0);

pk_inq_peradl := map(
    inq_count12 = 0 => -1,
    inq_peradl <= 0 => 0,
    inq_peradl <= 1 => 1,
                       2);

pk_inq_peradl_s0 := pk_inq_peradl;

pk_inq_peraddr := map(
    inq_count12 = 0  => -1,
    inq_peraddr <= 0 => 0,
    inq_peraddr <= 1 => 1,
    inq_peraddr <= 2 => 2,
                        3);

pk_inq_adlsperphone := map(
    inq_count12 = 0       => -1,
    inq_adlsperphone <= 0 => 0,
    inq_adlsperphone <= 1 => 1,
                             2);

pk_inq_adlsperphone_s0 := pk_inq_adlsperphone;

pk_inq_adlsperphone_s3 := pk_inq_adlsperphone;

pk_mth_header_first_seen := if (mth_header_first_seen >= 0, roundup(mth_header_first_seen), truncate(mth_header_first_seen));

pk_mth_hdr_frst_sn_s2 := map(
    pk_mth_header_first_seen <= 72  => 0,
    pk_mth_header_first_seen <= 96  => 1,
    pk_mth_header_first_seen <= 144 => 2,
    pk_mth_header_first_seen <= 168 => 3,
    pk_mth_header_first_seen <= 192 => 4,
    pk_mth_header_first_seen <= 240 => 5,
                                       6);

pk_dob_ver := if(combo_dobscore = 100, 1, 0);

pk_attr_total_number_derogs := map(
    attr_total_number_derogs <= 0 => 0,
    attr_total_number_derogs <= 1 => 1,
    attr_total_number_derogs <= 2 => 2,
                                     3);

pk_crim_fel_flag := map(
    criminal_count >= 2 or felony_count >= 1 => 2,
    criminal_count >= 1                      => 1,
                                                0);

pk_eviction_lvl := map(
    attr_eviction_count180 > 0 => 4,
    attr_eviction_count12 > 0  => 3,
    attr_eviction_count24 > 0  => 2,
    attr_eviction_count > 0    => 1,
                                  0);

pk_unrel_lien_lvl := map(
    attr_num_unrel_liens180 >= 1 or attr_num_unrel_liens12 >= 2 => 3,
    attr_num_unrel_liens12 >= 1 or attr_num_unrel_liens24 >= 2  => 2,
    attr_num_unrel_liens60 >= 1                                 => 1,
                                                                   0);

pk_adlperssn_count_s1 := map(
    adlperssn_count <= 0 => -1,
    adlperssn_count <= 1 => 0,
    adlperssn_count <= 2 => 1,
                            2);

pk_adlperssn_count_s3 := map(
    adlperssn_count <= 0 => -1,
    adlperssn_count <= 1 => 0,
    adlperssn_count <= 2 => 1,
                            2);

pk_ssns_per_adl_s1 := map(
    ssns_per_adl <= 0 => -1,
    ssns_per_adl <= 1 => 0,
                         1);

pk_ssns_per_adl_s2 := map(
    ssns_per_adl <= 0 => -1,
    ssns_per_adl <= 1 => 0,
                         1);

pk_ssns_per_adl_s3 := map(
    ssns_per_adl <= 0 => -1,
    ssns_per_adl <= 1 => 0,
    ssns_per_adl <= 2 => 1,
                         2);

pk_addrs_per_ssn_c6_s0 := map(
    addrs_per_ssn_c6 <= 0 => 0,
    addrs_per_ssn_c6 <= 1 => 1,
                             2);

pk_addrs_per_ssn_c6_s1 := map(
    addrs_per_ssn_c6 <= 0 => 0,
    addrs_per_ssn_c6 <= 1 => 1,
                             2);

pk_addrs_per_ssn_c6_s2 := if(addrs_per_ssn_c6 <= 0, 0, 2);

pk_addrs_per_ssn_c6_s3 := map(
    addrs_per_ssn_c6 <= 0 => 0,
    addrs_per_ssn_c6 <= 1 => 1,
                             2);

pk_ssns_per_adl_c6 := map(
    ssns_per_adl_c6 <= 0 => 0,
    ssns_per_adl_c6 <= 1 => 1,
                            2);

pk_phones_per_adl_c6_s3 := map(
    phones_per_adl_c6 <= 0 => 0,
    phones_per_adl_c6 <= 1 => 1,
                              2);

pk_adls_per_addr_c6_s2 := map(
    adls_per_addr_c6 <= 0 => 0,
    adls_per_addr_c6 <= 1 => 1,
    adls_per_addr_c6 <= 2 => 2,
    adls_per_addr_c6 <= 3 => 3,
    adls_per_addr_c6 <= 4 => 4,
                             5);

pk_ssns_per_addr_c6_s0 := map(
    ssns_per_addr_c6 <= 0 => 0,
    ssns_per_addr_c6 <= 1 => 1,
    ssns_per_addr_c6 <= 2 => 2,
    ssns_per_addr_c6 <= 3 => 3,
    ssns_per_addr_c6 <= 4 => 4,
                             5);

pk_ssns_per_addr_c6_s1 := map(
    ssns_per_addr_c6 <= 0 => 0,
    ssns_per_addr_c6 <= 1 => 1,
    ssns_per_addr_c6 <= 2 => 2,
    ssns_per_addr_c6 <= 3 => 3,
                             4);

pk_ssns_per_addr_c6_s3 := map(
    ssns_per_addr_c6 <= 0 => 0,
    ssns_per_addr_c6 <= 1 => 1,
    ssns_per_addr_c6 <= 2 => 2,
    ssns_per_addr_c6 <= 3 => 3,
    ssns_per_addr_c6 <= 4 => 4,
                             5);

pk_phones_per_addr_c6 := if(phones_per_addr_c6 <= 0, 0, 1);

pk_adls_per_phone_c6 := if(adls_per_phone_c6 <= 0, 0, 1);

pk_attr_addrs_last12_s1 := if(attr_addrs_last12 <= 0, 0, 1);

pk_attr_addrs_last24_s0 := map(
    attr_addrs_last24 <= 0 => 0,
    attr_addrs_last24 <= 1 => 1,
    attr_addrs_last24 <= 2 => 2,
    attr_addrs_last24 <= 3 => 3,
                              4);

pk_attr_addrs_last36_s2 := map(
    attr_addrs_last36 <= 0 => 0,
    attr_addrs_last36 <= 1 => 1,
    attr_addrs_last36 <= 2 => 2,
    attr_addrs_last36 <= 3 => 3,
    attr_addrs_last36 <= 4 => 4,
    attr_addrs_last36 <= 5 => 5,
                              6);

pk_attr_addrs_last36_s3 := if(attr_addrs_last36 <= 0, 0, 1);

pk_recent_addr_s0 := map(
    attr_addrs_last90 > 0 => 4,
    attr_addrs_last12 > 0 => 3,
    attr_addrs_last24 > 0 => 2,
    attr_addrs_last36 > 0 => 1,
                             0);

pk_recent_addr_s2 := map(
    attr_addrs_last90 > 0 => 4,
    attr_addrs_last12 > 0 => 3,
    attr_addrs_last24 > 0 => 2,
    attr_addrs_last36 > 0 => 1,
                             0);

pk_phones_per_adl_s0 := if(phones_per_adl <= 0, 0, 1);

pk_ssns_per_addr := if(ssns_per_addr <= 19, 0, 1);

pk_phones_per_addr_s0 := map(
    phones_per_addr <= 0 => -1,
    phones_per_addr <= 1 => 0,
    phones_per_addr <= 2 => 1,
                            2);

pk_phones_per_addr_s2 := map(
    phones_per_addr <= 0 => -1,
    phones_per_addr <= 1 => 0,
    phones_per_addr <= 2 => 1,
                            2);

pk_phones_per_addr_s3 := map(
    phones_per_addr <= 0 => -1,
    phones_per_addr <= 1 => 0,
    phones_per_addr <= 2 => 1,
                            2);

pk_adls_per_phone := if(adls_per_phone <= 0, 0, 1);

pk_prof_lic_cat_s2 := map(
    prof_license_category >= '5' => 5,
    prof_license_category >= '4' => 4,
    prof_license_category >= '3' => 3,
    prof_license_category >= '2' => 2,
    prof_license_category >= '0' => 1,
                                  0);

pk_prof_lic_cat_s3 := map(
    prof_license_category >= '5' => 4,
    prof_license_category >= '4' => 3,
    prof_license_category >= '3' => 2,
    prof_license_category >= '0' => 1,
                                  0);

pk_2nd_mortgage := if(trim(trim(add1_mortgage_type, LEFT), LEFT, RIGHT) = '2', 1, 0);

pk_baloon_mortgage := if(trim(trim(add1_mortgage_type, LEFT), LEFT, RIGHT) = 'H', 1, 0);

pk_adj_finance := if(trim(trim(add1_financing_type, LEFT), LEFT, RIGHT) = 'ADJ', 1, 0);

pk_addrs_prison_history := if((integer)addrs_prison_history > 0, 1, 0);

pk_ver_src_p := if(ver_src_P, 1, 0);

pk_prop_owned_purch_flag := if(property_owned_purchase_count > 0, 1, 0);

pk_add1_naprop4 := if(add1_naprop = 4, 1, 0);

pk_addrs_5yr_s0 := map(
    addrs_5yr <= 0 => 0,
    addrs_5yr <= 1 => 1,
    addrs_5yr <= 4 => 2,
    addrs_5yr <= 6 => 3,
                      4);

pk_addrs_5yr_s2 := map(
    addrs_5yr <= 0 => 0,
    addrs_5yr <= 1 => 1,
    addrs_5yr <= 4 => 2,
    addrs_5yr <= 6 => 3,
                      4);

pk_addrs_5yr_s3 := if(addrs_5yr <= 0, 0, 1);

email_count_1 := 0;

email_domain_free_count_1 := 0;

pk_email_count_s1 := map(
    email_count_1 <= 1 => 0,
    email_count_1 <= 2 => 1,
    email_count_1 <= 3 => 2,
    email_count_1 <= 4 => 3,
                          4);

pk_email_domain_free_count_s2 := map(
    email_domain_free_count_1 <= 0 => 0,
    email_domain_free_count_1 <= 1 => 1,
    email_domain_free_count_1 <= 2 => 2,
                                      3);

pk_email_domain_free_count_s3 := map(
    email_domain_free_count_1 <= 0 => 0,
    email_domain_free_count_1 <= 1 => 1,
    email_domain_free_count_1 <= 2 => 2,
                                      3);

pk_add_apt1 := if(trim(trim(out_addr_type, LEFT), LEFT, RIGHT) = 'H', 1, 0);

pk_add_standarization_err := if(trim(trim(add_ec1, LEFT), LEFT, RIGHT) = 'E', 1, 0);

pk_addr_changed := if(add_ec1 = 'S' and add_ec3 != '0', 1, 0);

pk_unit_changed := if(add_ec1 = 'S' and add_ec4 != '0', 1, 0);

pk_zip_po := if((integer)rc_hriskaddrflag = 1, 1, 0);

pk_zip_corp_mil := if((rc_hriskaddrflag in ['2', '3']), 1, 0);

pk_zip_hirisk_comm := if((integer)rc_hriskaddrflag = 4, 1, 0);

pk_add_inval := if(trim(trim(rc_addrvalflag, LEFT), LEFT, RIGHT) = 'N', 1, 0);

pk_add_apt2 := if(trim(trim(rc_dwelltype, LEFT), LEFT, RIGHT) = 'A', 1, 0);

pk_add_hirisk_comm := if((integer)rc_addrcommflag = 2, 1, 0);

pk_add1_advo_address_vacancy := if(trim(trim(add1_advo_address_vacancy, LEFT), LEFT, RIGHT) = 'Y', 1, 0);

pk_add1_advo_throw_back := if(trim(trim(add1_advo_throw_back, LEFT), LEFT, RIGHT) = 'Y', 1, 0);

pk_add1_advo_seasonal_delivery := if(trim(trim(add1_advo_seasonal_delivery, LEFT), LEFT, RIGHT) = 'E', 1, 0);

pk_add1_advo_college := if(trim(trim(add1_advo_college, LEFT), LEFT, RIGHT) = 'Y', 1, 0);

pk_add1_advo_drop := if(trim(trim(add1_advo_drop, LEFT), LEFT, RIGHT) = 'Y', 1, 0);

pk_add1_advo_res_or_business := if(trim(trim(add1_advo_res_or_business, LEFT), LEFT, RIGHT) = 'B', 1, 0);

pk_add1_advo_mixed_address_usage := if((trim(trim(add1_advo_mixed_address_usage, LEFT), LEFT, RIGHT) in ['A', '']), 0, 1);

pk_addprob_s1 := map(
    pk_add1_advo_address_vacancy = 1 or pk_add_hirisk_comm = 1 or pk_zip_corp_mil = 1                                                                                       => 2,
    pk_add1_advo_throw_back = 1 or pk_add_apt1 = 1 or pk_add_apt2 = 1 or pk_add1_advo_seasonal_delivery = 1 or pk_add1_advo_college = 1 or pk_add1_advo_res_or_business = 1 => 1,
    pk_add_standarization_err = 1 or pk_zip_po = 1 or pk_add_inval = 1 or pk_add1_advo_drop = 1                                                                             => 1,
    pk_add1_advo_mixed_address_usage = 1 or pk_zip_hirisk_comm = 1 or pk_unit_changed = 1 or pk_addr_changed = 1                                                            => 1,
                                                                                                                                                                               0);

pk_addprob_s2 := map(
    pk_add1_advo_address_vacancy = 1 or pk_add_hirisk_comm = 1 or pk_zip_corp_mil = 1                                                                                       => 4,
    pk_add1_advo_throw_back = 1 or pk_add_apt1 = 1 or pk_add_apt2 = 1 or pk_add1_advo_seasonal_delivery = 1 or pk_add1_advo_college = 1 or pk_add1_advo_res_or_business = 1 => 3,
    pk_add_standarization_err = 1 or pk_zip_po = 1 or pk_add_inval = 1 or pk_add1_advo_drop = 1                                                                             => 2,
    pk_add1_advo_mixed_address_usage = 1 or pk_zip_hirisk_comm = 1 or pk_unit_changed = 1 or pk_addr_changed = 1                                                            => 1,
                                                                                                                                                                               0);

pk_addprob_s3 := map(
    pk_add1_advo_address_vacancy = 1 or pk_add_hirisk_comm = 1 or pk_zip_corp_mil = 1                                                                                       => 4,
    pk_add1_advo_throw_back = 1 or pk_add_apt1 = 1 or pk_add_apt2 = 1 or pk_add1_advo_seasonal_delivery = 1 or pk_add1_advo_college = 1 or pk_add1_advo_res_or_business = 1 => 3,
    pk_add_standarization_err = 1 or pk_zip_po = 1 or pk_add_inval = 1 or pk_add1_advo_drop = 1                                                                             => 2,
    pk_add1_advo_mixed_address_usage = 1 or pk_zip_hirisk_comm = 1 or pk_unit_changed = 1 or pk_addr_changed = 1                                                            => 1,
                                                                                                                                                                               0);

pk_phn_nongeo := if(trim(trim(rc_hphonetypeflag, LEFT), LEFT, RIGHT) = '7', 1, 0);

pk_phn_phn_not_issued := if((integer)rc_pwphonezipflag = 4, 1, 0);

pk_phnprob_s2 := map(
    (integer)phn_cell = 1                                                                                                                                                                                              => 2,
    trim(trim(nap_status, LEFT), LEFT, RIGHT) = 'D' or pk_phn_nongeo = 1 or pk_phn_phn_not_issued = 1 or (integer)phn_disconnected = 1 or (integer)phn_inval = 1 or (integer)phn_highrisk2 = 1 or (integer)phn_zipmismatch = 1 or (integer)phn_notpots = 1 => 1,
                                                                                                                                                                                                                 0);

pk_grad_student := if(trim(trim(ams_class, LEFT), LEFT, RIGHT) = 'GR', 1, 0);

pk_ams_senior := if(trim(trim(ams_class, LEFT), LEFT, RIGHT) = 'SR', 1, 0);

pk_4yr_college := if((integer)ams_college_code = 4, 1, 0);

pk_college_tier_s0 := map(
    (ams_college_tier in ['0', '1', '2']) => 3,
    (ams_college_tier in ['3'])           => 2,
    (ams_college_tier in ['4'])           => 1,
                                                      0);

pk_college_tier_s1 := map(
    (ams_college_tier in ['0', '1', '2']) => 3,
    (ams_college_tier in ['3'])           => 2,
    (ams_college_tier in ['4'])           => 1,
                                                      0);

pk_college_tier_s2 := map(
    (ams_college_tier in ['0', '1', '2']) => 2,
    (ams_college_tier in ['3', '4'])      => 1,
                                                      0);

pk_contrary_infutor_ver := if((infutor_nap in [1, 6]), 1, 0);

pk_num_nonderogs90_s0 := map(
    attr_num_nonderogs90 <= 1 => 0,
    attr_num_nonderogs90 <= 2 => 1,
    attr_num_nonderogs90 <= 3 => 2,
    attr_num_nonderogs90 <= 4 => 3,
                                 4);

pk_mth_gong_did_fst_sn := if (mth_gong_did_first_seen >= 0, roundup(mth_gong_did_first_seen), truncate(mth_gong_did_first_seen));

pk_mth_gong_did_fst_sn2_s0 := map(
    pk_mth_gong_did_fst_sn = NULL => -1,
    pk_mth_gong_did_fst_sn >= 72  => 3,
    pk_mth_gong_did_fst_sn >= 24  => 2,
    pk_mth_gong_did_fst_sn >= 6   => 1,
                                     0);

pk_mth_gong_did_fst_sn2_s1 := map(
    pk_mth_gong_did_fst_sn = NULL => -1,
    pk_mth_gong_did_fst_sn >= 24  => 2,
    pk_mth_gong_did_fst_sn >= 6   => 1,
                                     0);

pk_mth_gong_did_fst_sn2_s2 := map(
    pk_mth_gong_did_fst_sn = NULL => -1,
    pk_mth_gong_did_fst_sn >= 72  => 3,
    pk_mth_gong_did_fst_sn >= 24  => 2,
    pk_mth_gong_did_fst_sn >= 6   => 1,
                                     0);

pk_mth_gong_did_fst_sn2_s3 := map(
    pk_mth_gong_did_fst_sn = NULL => -1,
    pk_mth_gong_did_fst_sn >= 72  => 3,
    pk_mth_gong_did_fst_sn >= 24  => 2,
    pk_mth_gong_did_fst_sn >= 6   => 1,
                                     0);

pk_mth_add1_date_fst_sn := if (mth_add1_date_first_seen >= 0, roundup(mth_add1_date_first_seen), truncate(mth_add1_date_first_seen));

pk_mth_add1_date_fst_sn2_s3 := map(
    pk_mth_add1_date_fst_sn = NULL => -1,
    pk_mth_add1_date_fst_sn >= 120 => 5,
    pk_mth_add1_date_fst_sn >= 60  => 4,
    pk_mth_add1_date_fst_sn >= 36  => 3,
    pk_mth_add1_date_fst_sn >= 12  => 2,
    pk_mth_add1_date_fst_sn >= 6   => 1,
                                      0);

pk_mth_ver_src_fdate_en := if (mth_ver_src_fdate_en >= 0, roundup(mth_ver_src_fdate_en), truncate(mth_ver_src_fdate_en));

pk_mth_ver_src_fdate_eq := if (mth_ver_src_fdate_eq >= 0, roundup(mth_ver_src_fdate_eq), truncate(mth_ver_src_fdate_eq));

pk_mth_ver_src_fdate_bureau := max(pk_mth_ver_src_fdate_eq, pk_mth_ver_src_fdate_en);

pk_too_young_at_bureau := truncate(pk_mth_ver_src_fdate_bureau / 12) > pk_age_estimate - 17;

pk_addr_hist_advo_college := if((integer)addr_hist_advo_college > 0, 1, 0);

pk_add1_house_number_match := if((integer)add1_house_number_match <= 0, 0, 1);

pk_nap_summary_ver_s1 := map(
    nap_summary >= 10 => 1,
    nap_summary = 1   => -1,
                         0);

pk_pos_dob_src_minor := if(max((integer)ver_dob_src_ak, (integer)ver_dob_src_am, (integer)ver_dob_src_ar, (integer)ver_dob_src_cg, (integer)ver_dob_src_w, (integer)ver_dob_src_eb) = NULL, NULL, sum((integer)ver_dob_src_ak, (integer)ver_dob_src_am, (integer)ver_dob_src_ar, (integer)ver_dob_src_cg, (integer)ver_dob_src_w, (integer)ver_dob_src_eb));

pk_pos_dob_src_minor_flag := pk_pos_dob_src_minor > 0;

ver_dob_src_bureau := ver_dob_src_en or ver_dob_src_eq;

ver_dob_src_emerge := max((integer)ver_dob_src_em, (integer)(integer)ver_dob_src_e1, (integer)(integer)ver_dob_src_e2, (integer)(integer)ver_dob_src_e3, (integer)(integer)ver_dob_src_e4);

pk_pos_dob_src_major := if(max(ver_dob_src_emerge, (integer)ver_dob_src_bureau, (integer)ver_dob_src_pl, (integer)ver_dob_src_vo, (integer)ver_dob_src_wp, (integer)pk_pos_dob_src_minor_flag) = NULL, NULL, sum(if(ver_dob_src_emerge = NULL, 0, ver_dob_src_emerge), (integer)ver_dob_src_bureau, (integer)ver_dob_src_pl, (integer)ver_dob_src_vo, (integer)ver_dob_src_wp, (integer)pk_pos_dob_src_minor_flag));

pk_pos_dob_src_cnt_s2 := min(1, if(pk_pos_dob_src_major = NULL, -NULL, pk_pos_dob_src_major));

pk_mth_ver_src_ldate_en := if (mth_ver_src_ldate_en >= 0, roundup(mth_ver_src_ldate_en), truncate(mth_ver_src_ldate_en));

pk_mth_ver_src_ldate_eq := if (mth_ver_src_ldate_eq >= 0, roundup(mth_ver_src_ldate_eq), truncate(mth_ver_src_ldate_eq));

pk_mth_ver_src_ldate_bureau := max(pk_mth_ver_src_ldate_eq, pk_mth_ver_src_ldate_en);

// pk_time_on_cb := pk_mth_ver_src_fdate_bureau - pk_mth_ver_src_ldate_bureau;

pk_time_on_cb := if( null in [pk_mth_ver_src_fdate_bureau, pk_mth_ver_src_ldate_bureau], NULL, pk_mth_ver_src_fdate_bureau - pk_mth_ver_src_ldate_bureau );

pk_time_on_cb2_s1 := map(
    pk_time_on_cb = NULL => -1,
    pk_time_on_cb <= 6   => 0,
    pk_time_on_cb <= 12  => 1,
    pk_time_on_cb <= 24  => 2,
    pk_time_on_cb <= 36  => 3,
    pk_time_on_cb <= 48  => 4,
                            5);

pk_time_since_cb3 := map(
    pk_mth_ver_src_ldate_bureau = NULL => 0,
    pk_mth_ver_src_ldate_bureau <= 3   => 0,
                                          1);

pk_age_estimate_s0_0m := map(
    pk_age_estimate_s0 = 0 => 0.4766146993,
    pk_age_estimate_s0 = 1 => 0.1618705036,
    pk_age_estimate_s0 = 2 => 0.1191391238,
    pk_age_estimate_s0 = 3 => 0.0988654781,
    pk_age_estimate_s0 = 4 => 0.0784431138,
    pk_age_estimate_s0 = 5 => 0.0535984276,
    pk_age_estimate_s0 = 6 => 0.0340684956,
    pk_age_estimate_s0 = 7 => 0.0310559006,
                              0.0565434927);

pk_estimated_income_s0_0m := map(
    pk_estimated_income_s0 = 0 => 0.178041543,
    pk_estimated_income_s0 = 1 => 0.1354883081,
    pk_estimated_income_s0 = 2 => 0.1189839572,
    pk_estimated_income_s0 = 3 => 0.0829896907,
    pk_estimated_income_s0 = 4 => 0.0653846154,
    pk_estimated_income_s0 = 5 => 0.0570987654,
    pk_estimated_income_s0 = 6 => 0.0389371862,
    pk_estimated_income_s0 = 7 => 0.0295995357,
    pk_estimated_income_s0 = 8 => 0.0161127895,
                                  0.0565434927);

pk_add1_avm_auto_val_s0_0m := map(
    pk_add1_avm_auto_val_s0 = -1 => 0.0677706449,
    pk_add1_avm_auto_val_s0 = 0  => 0.1101511879,
    pk_add1_avm_auto_val_s0 = 1  => 0.0801944107,
    pk_add1_avm_auto_val_s0 = 2  => 0.0598949212,
    pk_add1_avm_auto_val_s0 = 3  => 0.0422996333,
    pk_add1_avm_auto_val_s0 = 4  => 0.0341050021,
                                    0.0565434927);

pk_age_estimate_s1_1m := map(
    pk_age_estimate_s1 = 0 => 0.1957849725,
    pk_age_estimate_s1 = 1 => 0.1385419692,
    pk_age_estimate_s1 = 2 => 0.096544158,
    pk_age_estimate_s1 = 3 => 0.0736484722,
    pk_age_estimate_s1 = 4 => 0.0511323838,
    pk_age_estimate_s1 = 5 => 0.0430183357,
                              0.0878498445);

pk_estimated_income_s1_1m := map(
    pk_estimated_income_s1 = 0  => 0.1446933529,
    pk_estimated_income_s1 = 1  => 0.1263157895,
    pk_estimated_income_s1 = 2  => 0.1128469031,
    pk_estimated_income_s1 = 3  => 0.0954263128,
    pk_estimated_income_s1 = 4  => 0.0834858188,
    pk_estimated_income_s1 = 5  => 0.0768477729,
    pk_estimated_income_s1 = 6  => 0.06528,
    pk_estimated_income_s1 = 7  => 0.0562098501,
    pk_estimated_income_s1 = 8  => 0.0491905355,
    pk_estimated_income_s1 = 9  => 0.0419625565,
    pk_estimated_income_s1 = 10 => 0.0350194553,
    pk_estimated_income_s1 = 11 => 0.0440251572,
                                   0.0878498445);

pk_add1_avm_auto_val_s1_1m := map(
    pk_add1_avm_auto_val_s1 = -1 => 0.0956815016,
    pk_add1_avm_auto_val_s1 = 0  => 0.1577608142,
    pk_add1_avm_auto_val_s1 = 1  => 0.1178861789,
    pk_add1_avm_auto_val_s1 = 2  => 0.0978403141,
    pk_add1_avm_auto_val_s1 = 3  => 0.0941807044,
    pk_add1_avm_auto_val_s1 = 4  => 0.0756269592,
    pk_add1_avm_auto_val_s1 = 5  => 0.0498422713,
    pk_add1_avm_auto_val_s1 = 6  => 0.0362080316,
                                    0.0878498445);

pk_age_estimate_s2_2m := map(
    pk_age_estimate_s2 = 0 => 0.0325741525,
    pk_age_estimate_s2 = 1 => 0.0285341595,
    pk_age_estimate_s2 = 2 => 0.0233476696,
    pk_age_estimate_s2 = 3 => 0.0193825813,
    pk_age_estimate_s2 = 4 => 0.014131362,
    pk_age_estimate_s2 = 5 => 0.0109003215,
    pk_age_estimate_s2 = 6 => 0.0074285867,
                              0.0140849078);

pk_estimated_income_s2_2m := map(
    pk_estimated_income_s2 = 0 => 0.0178944229,
    pk_estimated_income_s2 = 1 => 0.0145617705,
    pk_estimated_income_s2 = 2 => 0.0128281981,
    pk_estimated_income_s2 = 3 => 0.0102739726,
    pk_estimated_income_s2 = 4 => 0.0064741036,
                                  0.0140849078);

pk_add1_avm_auto_val_s2_2m := map(
    pk_add1_avm_auto_val_s2 = -1 => 0.0152018172,
    pk_add1_avm_auto_val_s2 = 0  => 0.0249612403,
    pk_add1_avm_auto_val_s2 = 1  => 0.0179867987,
    pk_add1_avm_auto_val_s2 = 2  => 0.0148375451,
    pk_add1_avm_auto_val_s2 = 3  => 0.0121145374,
    pk_add1_avm_auto_val_s2 = 4  => 0.0093194418,
                                    0.0140849078);

pk_age_estimate_s3_3m := map(
    pk_age_estimate_s3 = 0 => 0.0342703295,
    pk_age_estimate_s3 = 1 => 0.030909973,
    pk_age_estimate_s3 = 2 => 0.0269187301,
    pk_age_estimate_s3 = 3 => 0.0210030988,
    pk_age_estimate_s3 = 4 => 0.0164362118,
                              0.0270104534);

pk_estimated_income_s3_3m := map(
    pk_estimated_income_s3 = 0 => 0.0428675666,
    pk_estimated_income_s3 = 1 => 0.0368736568,
    pk_estimated_income_s3 = 2 => 0.0308914387,
    pk_estimated_income_s3 = 3 => 0.0258293549,
    pk_estimated_income_s3 = 4 => 0.0213391108,
    pk_estimated_income_s3 = 5 => 0.0122282609,
                                  0.0270104534);

pk_add1_avm_auto_val_s3_3m := map(
    pk_add1_avm_auto_val_s3 = -1 => 0.0268399371,
    pk_add1_avm_auto_val_s3 = 0  => 0.0529925187,
    pk_add1_avm_auto_val_s3 = 1  => 0.0281143212,
    pk_add1_avm_auto_val_s3 = 2  => 0.0237699073,
    pk_add1_avm_auto_val_s3 = 3  => 0.019124424,
                                    0.0270104534);

pk_verx_s0_0m := map(
    pk_verx_s0 = 0 => 0.1468058968,
    pk_verx_s0 = 1 => 0.0764248705,
    pk_verx_s0 = 2 => 0.0649536046,
    pk_verx_s0 = 3 => 0.0593320236,
    pk_verx_s0 = 4 => 0.0392888648,
                      0.0565434927);

pk_verx_s1_1m := map(
    pk_verx_s1 = 0 => 0.1295222866,
    pk_verx_s1 = 1 => 0.0839347934,
    pk_verx_s1 = 2 => 0.063331649,
                      0.0878498445);

pk_verx_s3_3m := map(
    pk_verx_s3 = 0 => 0.0553252838,
    pk_verx_s3 = 1 => 0.0426173052,
    pk_verx_s3 = 2 => 0.0316094932,
    pk_verx_s3 = 3 => 0.0291564173,
    pk_verx_s3 = 4 => 0.0163067733,
                      0.0270104534);

pk_inq_recent_lvl_s0_0m := map(
    pk_inq_recent_lvl_s0 = 0 => 0.0510322723,
    pk_inq_recent_lvl_s0 = 1 => 0.1043478261,
    pk_inq_recent_lvl_s0 = 2 => 0.2363315697,
    pk_inq_recent_lvl_s0 = 3 => 0.4545454545,
    pk_inq_recent_lvl_s0 = 4 => 0.4769230769,
                                0.0565434927);

pk_inq_peradl_s0_0m := map(
    pk_inq_peradl_s0 = -1 => 0.0510322723,
    pk_inq_peradl_s0 = 0  => 0.0650406504,
    pk_inq_peradl_s0 = 1  => 0.1652816251,
    pk_inq_peradl_s0 = 2  => 0.4362416107,
                             0.0565434927);

pk_inq_adlsperphone_s0_0m := map(
    pk_inq_adlsperphone_s0 = -1 => 0.0510322723,
    pk_inq_adlsperphone_s0 = 0  => 0.1265164645,
    pk_inq_adlsperphone_s0 = 1  => 0.2233285917,
    pk_inq_adlsperphone_s0 = 2  => 0.2933333333,
                                   0.0565434927);

pk_inq_recent_lvl_s1_1m := map(
    pk_inq_recent_lvl_s1 = 0 => 0.076869551,
    pk_inq_recent_lvl_s1 = 1 => 0.1034928849,
    pk_inq_recent_lvl_s1 = 2 => 0.1987951807,
    pk_inq_recent_lvl_s1 = 3 => 0.3333333333,
    pk_inq_recent_lvl_s1 = 4 => 0.3990147783,
                                0.0878498445);

pk_inq_peraddr_1m := map(
    pk_inq_peraddr = -1 => 0.076869551,
    pk_inq_peraddr = 0  => 0.1504424779,
    pk_inq_peraddr = 1  => 0.171286425,
    pk_inq_peraddr = 2  => 0.1875,
    pk_inq_peraddr = 3  => 0.4007782101,
                           0.0878498445);

pk_mth_inq_frst_log_dt2_s2_2m := map(
    pk_mth_inq_frst_log_dt2_s2 = 0 => 0.0137038529,
    pk_mth_inq_frst_log_dt2_s2 = 1 => 0.036809816,
    pk_mth_inq_frst_log_dt2_s2 = 2 => 0.066552901,
                                      0.0140849078);

pk_inq_recent_lvl_s3_3m := map(
    pk_inq_recent_lvl_s3 = 0 => 0.0246590642,
    pk_inq_recent_lvl_s3 = 1 => 0.0700778643,
    pk_inq_recent_lvl_s3 = 2 => 0.1205673759,
    pk_inq_recent_lvl_s3 = 3 => 0.125,
    pk_inq_recent_lvl_s3 = 4 => 0.2173913043,
                                0.0270104534);

pk_inq_peraddr_3m := map(
    pk_inq_peraddr = -1 => 0.0246590642,
    pk_inq_peraddr = 0  => 0.0732356858,
    pk_inq_peraddr = 1  => 0.1082872928,
    pk_inq_peraddr = 2  => 0.134529148,
    pk_inq_peraddr = 3  => 0.1701030928,
                           0.0270104534);

pk_inq_adlsperphone_s3_3m := map(
    pk_inq_adlsperphone_s3 = -1 => 0.0246590642,
    pk_inq_adlsperphone_s3 = 0  => 0.085106383,
    pk_inq_adlsperphone_s3 = 1  => 0.1070539419,
    pk_inq_adlsperphone_s3 = 2  => 0.1982758621,
                                   0.0270104534);

pk_mth_hdr_frst_sn_s2_2m := map(
    pk_mth_hdr_frst_sn_s2 = 0 => 0.0384740789,
    pk_mth_hdr_frst_sn_s2 = 1 => 0.0280804694,
    pk_mth_hdr_frst_sn_s2 = 2 => 0.0210875946,
    pk_mth_hdr_frst_sn_s2 = 3 => 0.0191352792,
    pk_mth_hdr_frst_sn_s2 = 4 => 0.016842578,
    pk_mth_hdr_frst_sn_s2 = 5 => 0.0143216167,
    pk_mth_hdr_frst_sn_s2 = 6 => 0.0099346299,
                                 0.0140849078);

pk_dob_ver_1m := map(
    pk_dob_ver = 0 => 0.1102297817,
    pk_dob_ver = 1 => 0.0693363999,
                      0.0878498445);

pk_dob_ver_3m := map(
    pk_dob_ver = 0 => 0.0406756291,
    pk_dob_ver = 1 => 0.0234464902,
                      0.0270104534);

pk_attr_total_number_derogs_0m := map(
    pk_attr_total_number_derogs = 0 => 0.0501858736,
    pk_attr_total_number_derogs = 1 => 0.0593814969,
    pk_attr_total_number_derogs = 2 => 0.0768251273,
    pk_attr_total_number_derogs = 3 => 0.098381071,
                                       0.0565434927);

pk_crim_fel_flag_0m := map(
    pk_crim_fel_flag = 0 => 0.0547007453,
    pk_crim_fel_flag = 1 => 0.065652522,
    pk_crim_fel_flag = 2 => 0.125748503,
                            0.0565434927);

pk_eviction_lvl_0m := map(
    pk_eviction_lvl = 0 => 0.0536455151,
    pk_eviction_lvl = 1 => 0.084989719,
    pk_eviction_lvl = 2 => 0.0968858131,
    pk_eviction_lvl = 3 => 0.1377245509,
    pk_eviction_lvl = 4 => 0.1941176471,
                           0.0565434927);

pk_unrel_lien_lvl_0m := map(
    pk_unrel_lien_lvl = 0 => 0.0524842018,
    pk_unrel_lien_lvl = 1 => 0.0654168329,
    pk_unrel_lien_lvl = 2 => 0.0782997763,
    pk_unrel_lien_lvl = 3 => 0.1079478055,
                             0.0565434927);

bankrupt_0m := map(
    (integer)bankrupt = 0 => 0.055950981,
    (integer)bankrupt = 1 => 0.0787037037,
                    0.0565434927);

pk_addrs_per_ssn_c6_s0_0m := map(
    pk_addrs_per_ssn_c6_s0 = 0 => 0.052182623,
    pk_addrs_per_ssn_c6_s0 = 1 => 0.1150658216,
    pk_addrs_per_ssn_c6_s0 = 2 => 0.1404494382,
                                  0.0565434927);

pk_ssns_per_adl_c6_0m := map(
    pk_ssns_per_adl_c6 = 0 => 0.0496577474,
    pk_ssns_per_adl_c6 = 1 => 0.072160255,
    pk_ssns_per_adl_c6 = 2 => 0.1567944251,
                              0.0565434927);

pk_ssns_per_addr_c6_s0_0m := map(
    pk_ssns_per_addr_c6_s0 = 0 => 0.0479833951,
    pk_ssns_per_addr_c6_s0 = 1 => 0.071100496,
    pk_ssns_per_addr_c6_s0 = 2 => 0.084078712,
    pk_ssns_per_addr_c6_s0 = 3 => 0.1081504702,
    pk_ssns_per_addr_c6_s0 = 4 => 0.15,
    pk_ssns_per_addr_c6_s0 = 5 => 0.2555555556,
                                  0.0565434927);

pk_attr_addrs_last24_s0_0m := map(
    pk_attr_addrs_last24_s0 = 0 => 0.0447368421,
    pk_attr_addrs_last24_s0 = 1 => 0.0694824509,
    pk_attr_addrs_last24_s0 = 2 => 0.0789641944,
    pk_attr_addrs_last24_s0 = 3 => 0.0808678501,
    pk_attr_addrs_last24_s0 = 4 => 0.1262729124,
                                   0.0565434927);

pk_recent_addr_s0_0m := map(
    pk_recent_addr_s0 = 0 => 0.0432328495,
    pk_recent_addr_s0 = 1 => 0.0507715281,
    pk_recent_addr_s0 = 2 => 0.0635507113,
    pk_recent_addr_s0 = 3 => 0.0735914143,
    pk_recent_addr_s0 = 4 => 0.102617366,
                             0.0565434927);

pk_phones_per_adl_s0_0m := map(
    pk_phones_per_adl_s0 = 0 => 0.0667526604,
    pk_phones_per_adl_s0 = 1 => 0.0435080977,
                                0.0565434927);

pk_ssns_per_addr_0m := map(
    pk_ssns_per_addr = 0 => 0.0544585462,
    pk_ssns_per_addr = 1 => 0.0787900106,
                            0.0565434927);

pk_phones_per_addr_s0_0m := map(
    pk_phones_per_addr_s0 = -1 => 0.0581807725,
    pk_phones_per_addr_s0 = 0  => 0.048984306,
    pk_phones_per_addr_s0 = 1  => 0.0594892629,
    pk_phones_per_addr_s0 = 2  => 0.0748908297,
                                  0.0565434927);

pk_adlperssn_count_s1_1m := map(
    pk_adlperssn_count_s1 = -1 => 0.095890411,
    pk_adlperssn_count_s1 = 0  => 0.0847328244,
    pk_adlperssn_count_s1 = 1  => 0.0986083499,
    pk_adlperssn_count_s1 = 2  => 0.0990516333,
                                  0.0878498445);

pk_ssns_per_adl_s1_1m := map(
    pk_ssns_per_adl_s1 = -1 => 0.1458670989,
    pk_ssns_per_adl_s1 = 0  => 0.086062889,
    pk_ssns_per_adl_s1 = 1  => 0.0918315576,
                               0.0878498445);

pk_addrs_per_ssn_c6_s1_1m := map(
    pk_addrs_per_ssn_c6_s1 = 0 => 0.0826655052,
    pk_addrs_per_ssn_c6_s1 = 1 => 0.1157246183,
    pk_addrs_per_ssn_c6_s1 = 2 => 0.1347962382,
                                  0.0878498445);

pk_ssns_per_adl_c6_1m := map(
    pk_ssns_per_adl_c6 = 0 => 0.0746622422,
    pk_ssns_per_adl_c6 = 1 => 0.1090270812,
    pk_ssns_per_adl_c6 = 2 => 0.156626506,
                              0.0878498445);

pk_ssns_per_addr_c6_s1_1m := map(
    pk_ssns_per_addr_c6_s1 = 0 => 0.0677562778,
    pk_ssns_per_addr_c6_s1 = 1 => 0.1048498845,
    pk_ssns_per_addr_c6_s1 = 2 => 0.1261818182,
    pk_ssns_per_addr_c6_s1 = 3 => 0.1414048059,
    pk_ssns_per_addr_c6_s1 = 4 => 0.1536312849,
                                  0.0878498445);

pk_phones_per_addr_c6_1m := map(
    pk_phones_per_addr_c6 = 0 => 0.0840170509,
    pk_phones_per_addr_c6 = 1 => 0.103946102,
                                 0.0878498445);

pk_attr_addrs_last12_s1_1m := map(
    pk_attr_addrs_last12_s1 = 0 => 0.0725928619,
    pk_attr_addrs_last12_s1 = 1 => 0.1118089257,
                                   0.0878498445);

pk_ssns_per_adl_s2_2m := map(
    pk_ssns_per_adl_s2 = -1 => 0.0263157895,
    pk_ssns_per_adl_s2 = 0  => 0.0131222201,
    pk_ssns_per_adl_s2 = 1  => 0.0178780774,
                               0.0140849078);

pk_addrs_per_ssn_c6_s2_2m := map(
    pk_addrs_per_ssn_c6_s2 = 0 => 0.0133419076,
    pk_addrs_per_ssn_c6_s2 = 2 => 0.0330937973,
                                  0.0140849078);

pk_adls_per_addr_c6_s2_2m := map(
    pk_adls_per_addr_c6_s2 = 0 => 0.0119689787,
    pk_adls_per_addr_c6_s2 = 1 => 0.01948116,
    pk_adls_per_addr_c6_s2 = 2 => 0.0234105155,
    pk_adls_per_addr_c6_s2 = 3 => 0.0305389222,
    pk_adls_per_addr_c6_s2 = 4 => 0.0407331976,
    pk_adls_per_addr_c6_s2 = 5 => 0.0637254902,
                                  0.0140849078);

pk_adls_per_phone_c6_2m := map(
    pk_adls_per_phone_c6 = 0 => 0.0171206452,
    pk_adls_per_phone_c6 = 1 => 0.0111842197,
                                0.0140849078);

pk_attr_addrs_last36_s2_2m := map(
    pk_attr_addrs_last36_s2 = 0 => 0.0100559976,
    pk_attr_addrs_last36_s2 = 1 => 0.016427289,
    pk_attr_addrs_last36_s2 = 2 => 0.0224276297,
    pk_attr_addrs_last36_s2 = 3 => 0.0263207019,
    pk_attr_addrs_last36_s2 = 4 => 0.0328125,
    pk_attr_addrs_last36_s2 = 5 => 0.0468018721,
    pk_attr_addrs_last36_s2 = 6 => 0.067833698,
                                   0.0140849078);

pk_recent_addr_s2_2m := map(
    pk_recent_addr_s2 = 0 => 0.0100559976,
    pk_recent_addr_s2 = 1 => 0.0160810006,
    pk_recent_addr_s2 = 2 => 0.0189860213,
    pk_recent_addr_s2 = 3 => 0.0233958134,
    pk_recent_addr_s2 = 4 => 0.0259854015,
                             0.0140849078);

pk_ssns_per_addr_2m := map(
    pk_ssns_per_addr = 0 => 0.0134892288,
    pk_ssns_per_addr = 1 => 0.026433761,
                            0.0140849078);

pk_phones_per_addr_s2_2m := map(
    pk_phones_per_addr_s2 = -1 => 0.0160041569,
    pk_phones_per_addr_s2 = 0  => 0.011890263,
    pk_phones_per_addr_s2 = 1  => 0.0176896083,
    pk_phones_per_addr_s2 = 2  => 0.020051899,
                                  0.0140849078);

pk_adls_per_phone_2m := map(
    pk_adls_per_phone = 0 => 0.0200597182,
    pk_adls_per_phone = 1 => 0.0107968018,
                             0.0140849078);

pk_adlperssn_count_s3_3m := map(
    pk_adlperssn_count_s3 = -1 => 0.037593985,
    pk_adlperssn_count_s3 = 0  => 0.0255366098,
    pk_adlperssn_count_s3 = 1  => 0.0288886086,
    pk_adlperssn_count_s3 = 2  => 0.0368585883,
                                  0.0270104534);

pk_ssns_per_adl_s3_3m := map(
    pk_ssns_per_adl_s3 = -1 => 0.0287474333,
    pk_ssns_per_adl_s3 = 0  => 0.0260587993,
    pk_ssns_per_adl_s3 = 1  => 0.0303092997,
    pk_ssns_per_adl_s3 = 2  => 0.0412757974,
                               0.0270104534);

pk_addrs_per_ssn_c6_s3_3m := map(
    pk_addrs_per_ssn_c6_s3 = 0 => 0.0257084742,
    pk_addrs_per_ssn_c6_s3 = 1 => 0.042505087,
    pk_addrs_per_ssn_c6_s3 = 2 => 0.0803858521,
                                  0.0270104534);

pk_phones_per_adl_c6_s3_3m := map(
    pk_phones_per_adl_c6_s3 = 0 => 0.0290419517,
    pk_phones_per_adl_c6_s3 = 1 => 0.0217818539,
    pk_phones_per_adl_c6_s3 = 2 => 0.0212940213,
                                   0.0270104534);

pk_ssns_per_addr_c6_s3_3m := map(
    pk_ssns_per_addr_c6_s3 = 0 => 0.0223274821,
    pk_ssns_per_addr_c6_s3 = 1 => 0.0380358221,
    pk_ssns_per_addr_c6_s3 = 2 => 0.042204797,
    pk_ssns_per_addr_c6_s3 = 3 => 0.0559815951,
    pk_ssns_per_addr_c6_s3 = 4 => 0.0660592255,
    pk_ssns_per_addr_c6_s3 = 5 => 0.1078066914,
                                  0.0270104534);

pk_phones_per_addr_c6_3m := map(
    pk_phones_per_addr_c6 = 0 => 0.024502514,
    pk_phones_per_addr_c6 = 1 => 0.0373982547,
                                 0.0270104534);

pk_attr_addrs_last36_s3_3m := map(
    pk_attr_addrs_last36_s3 = 0 => 0.0196131273,
    pk_attr_addrs_last36_s3 = 1 => 0.0337372362,
                                   0.0270104534);

pk_phones_per_addr_s3_3m := map(
    pk_phones_per_addr_s3 = -1 => 0.0298539519,
    pk_phones_per_addr_s3 = 0  => 0.021727776,
    pk_phones_per_addr_s3 = 1  => 0.0307648483,
    pk_phones_per_addr_s3 = 2  => 0.031605001,
                                  0.0270104534);

pk_adls_per_phone_3m := map(
    pk_adls_per_phone = 0 => 0.0338609198,
    pk_adls_per_phone = 1 => 0.0207262387,
                             0.0270104534);

pk_prof_lic_cat_s2_2m := map(
    pk_prof_lic_cat_s2 = 0 => 0.0145092731,
    pk_prof_lic_cat_s2 = 1 => 0.0141001855,
    pk_prof_lic_cat_s2 = 2 => 0.0138248848,
    pk_prof_lic_cat_s2 = 3 => 0.0127388535,
    pk_prof_lic_cat_s2 = 4 => 0.0090716078,
    pk_prof_lic_cat_s2 = 5 => 0.0058823529,
                              0.0140849078);

pk_prof_lic_cat_s3_3m := map(
    pk_prof_lic_cat_s3 = 0 => 0.027853116,
    pk_prof_lic_cat_s3 = 1 => 0.0211459754,
    pk_prof_lic_cat_s3 = 2 => 0.0139771283,
    pk_prof_lic_cat_s3 = 3 => 0.0116883117,
    pk_prof_lic_cat_s3 = 4 => 0.0085959885,
                              0.0270104534);

pk_ver_src_p_0m := map(
    pk_ver_src_p = 0 => 0.0936111111,
    pk_ver_src_p = 1 => 0.0386540352,
                        0.0565434927);

pk_prop_owned_purch_flag_0m := map(
    pk_prop_owned_purch_flag = 0 => 0.063502861,
    pk_prop_owned_purch_flag = 1 => 0.0352998656,
                                    0.0565434927);

pk_add1_naprop4_0m := map(
    pk_add1_naprop4 = 0 => 0.0775136662,
    pk_add1_naprop4 = 1 => 0.0363378114,
                           0.0565434927);

pk_ver_src_p_1m := map(
    pk_ver_src_p = 0 => 0.0907238734,
    pk_ver_src_p = 1 => 0.0515151515,
                        0.0878498445);

pk_add1_naprop4_1m := map(
    pk_add1_naprop4 = 0 => 0.090376569,
    pk_add1_naprop4 = 1 => 0.0547730829,
                           0.0878498445);

pk_ver_src_p_3m := map(
    pk_ver_src_p = 0 => 0.0307300509,
    pk_ver_src_p = 1 => 0.0154871136,
                        0.0270104534);

pk_addrs_5yr_s0_0m := map(
    pk_addrs_5yr_s0 = 0 => 0.0414021049,
    pk_addrs_5yr_s0 = 1 => 0.0616986301,
    pk_addrs_5yr_s0 = 2 => 0.0632641719,
    pk_addrs_5yr_s0 = 3 => 0.0826446281,
    pk_addrs_5yr_s0 = 4 => 0.1025641026,
                           0.0565434927);

pk_addrs_5yr_s2_2m := map(
    pk_addrs_5yr_s2 = 0 => 0.0092898878,
    pk_addrs_5yr_s2 = 1 => 0.013676897,
    pk_addrs_5yr_s2 = 2 => 0.020280278,
    pk_addrs_5yr_s2 = 3 => 0.0372037204,
    pk_addrs_5yr_s2 = 4 => 0.0486976217,
                           0.0140849078);

pk_addrs_5yr_s3_3m := map(
    pk_addrs_5yr_s3 = 0 => 0.017539566,
    pk_addrs_5yr_s3 = 1 => 0.0321017432,
                           0.0270104534);

pk_email_count_s1_1m := map(
    pk_email_count_s1 = 0 => 0.0876497315,
    pk_email_count_s1 = 1 => 0.0827464789,
    pk_email_count_s1 = 2 => 0.0943683409,
    pk_email_count_s1 = 3 => 0.1,
    pk_email_count_s1 = 4 => 0.1204188482,
                             0.0878498445);

pk_email_domain_free_count_s2_2m := map(
    pk_email_domain_free_count_s2 = 0 => 0.0137043715,
    pk_email_domain_free_count_s2 = 1 => 0.0157808029,
    pk_email_domain_free_count_s2 = 2 => 0.0227617602,
    pk_email_domain_free_count_s2 = 3 => 0.0327868852,
                                         0.0140849078);

pk_email_domain_free_count_s3_3m := map(
    pk_email_domain_free_count_s3 = 0 => 0.0264255452,
    pk_email_domain_free_count_s3 = 1 => 0.0292780749,
    pk_email_domain_free_count_s3 = 2 => 0.0327983252,
    pk_email_domain_free_count_s3 = 3 => 0.0457038391,
                                         0.0270104534);

ssn_adl_prob_0m := map(
    (integer)ssn_adl_prob = 0 => 0.0549828179,
    (integer)ssn_adl_prob = 1 => 0.077186964,
                        0.0565434927);

ssn_issued18_0m := map(
    (integer)ssn_issued18 = 0 => 0.0625974239,
    (integer)ssn_issued18 = 1 => 0.0397727273,
                        0.0565434927);

pk_addprob_s1_1m := map(
    pk_addprob_s1 = 0 => 0.0832303718,
    pk_addprob_s1 = 1 => 0.0879845402,
    pk_addprob_s1 = 2 => 0.1631067961,
                         0.0878498445);

ssn_issued18_1m := map(
    (integer)ssn_issued18 = 0 => 0.0892899176,
    (integer)ssn_issued18 = 1 => 0.0637319317,
                        0.0878498445);

pk_addprob_s2_2m := map(
    pk_addprob_s2 = 0 => 0.0122826558,
    pk_addprob_s2 = 1 => 0.0140507795,
    pk_addprob_s2 = 2 => 0.018211534,
    pk_addprob_s2 = 3 => 0.0204901567,
    pk_addprob_s2 = 4 => 0.0613333333,
                         0.0140849078);

pk_phnprob_s2_2m := map(
    pk_phnprob_s2 = 0 => 0.0110535714,
    pk_phnprob_s2 = 1 => 0.0224054111,
    pk_phnprob_s2 = 2 => 0.0277283666,
                         0.0140849078);

pk_addprob_s3_3m := map(
    pk_addprob_s3 = 0 => 0.0212908634,
    pk_addprob_s3 = 1 => 0.0284013395,
    pk_addprob_s3 = 2 => 0.0288056725,
    pk_addprob_s3 = 3 => 0.0310133429,
    pk_addprob_s3 = 4 => 0.0575461455,
                         0.0270104534);

ssn_issued18_3m := map(
    (integer)ssn_issued18 = 0 => 0.0277851051,
    (integer)ssn_issued18 = 1 => 0.0255796013,
                        0.0270104534);

pk_college_tier_s0_0m := map(
    pk_college_tier_s0 = 0 => 0.0573688175,
    pk_college_tier_s0 = 1 => 0.0411184211,
    pk_college_tier_s0 = 2 => 0.0355555556,
    pk_college_tier_s0 = 3 => 0.02734375,
                              0.0565434927);

pk_grad_student_1m := map(
    pk_grad_student = 0 => 0.088476752,
    pk_grad_student = 1 => 0.0093457944,
                           0.0878498445);

pk_ams_senior_1m := map(
    pk_ams_senior = 0 => 0.0902708509,
    pk_ams_senior = 1 => 0.021141649,
                         0.0878498445);

pk_college_tier_s1_1m := map(
    pk_college_tier_s1 = 0 => 0.1004968383,
    pk_college_tier_s1 = 1 => 0.042988741,
    pk_college_tier_s1 = 2 => 0.0250426864,
    pk_college_tier_s1 = 3 => 0.0172265289,
                              0.0878498445);

pk_grad_student_2m := map(
    pk_grad_student = 0 => 0.0141783801,
    pk_grad_student = 1 => 0.0053655265,
                           0.0140849078);

pk_college_tier_s2_2m := map(
    pk_college_tier_s2 = 0 => 0.0142526819,
    pk_college_tier_s2 = 1 => 0.0133744856,
    pk_college_tier_s2 = 2 => 0.0048205678,
                              0.0140849078);

pk_4yr_college_3m := map(
    pk_4yr_college = 0 => 0.0279825816,
    pk_4yr_college = 1 => 0.0175115207,
                          0.0270104534);

pk_contrary_infutor_ver_1m := map(
    pk_contrary_infutor_ver = 0 => 0.0845196488,
    pk_contrary_infutor_ver = 1 => 0.1098591549,
                                   0.0878498445);

pk_contrary_infutor_ver_2m := map(
    pk_contrary_infutor_ver = 0 => 0.0133991912,
    pk_contrary_infutor_ver = 1 => 0.0243819073,
                                   0.0140849078);

pk_contrary_infutor_ver_3m := map(
    pk_contrary_infutor_ver = 0 => 0.0247989169,
    pk_contrary_infutor_ver = 1 => 0.0459378408,
                                   0.0270104534);

pk_num_nonderogs90_s0_0m := map(
    pk_num_nonderogs90_s0 = 0 => 0.089698315,
    pk_num_nonderogs90_s0 = 1 => 0.0492027702,
    pk_num_nonderogs90_s0 = 2 => 0.035473395,
    pk_num_nonderogs90_s0 = 3 => 0.0344393112,
    pk_num_nonderogs90_s0 = 4 => 0.0216450216,
                                 0.0565434927);

pk_mth_gong_did_fst_sn2_s0_0m := map(
    pk_mth_gong_did_fst_sn2_s0 = -1 => 0.0742198225,
    pk_mth_gong_did_fst_sn2_s0 = 0  => 0.0970588235,
    pk_mth_gong_did_fst_sn2_s0 = 1  => 0.0775805391,
    pk_mth_gong_did_fst_sn2_s0 = 2  => 0.0472106878,
    pk_mth_gong_did_fst_sn2_s0 = 3  => 0.0419888316,
                                       0.0565434927);

pk_mth_gong_did_fst_sn2_s1_1m := map(
    pk_mth_gong_did_fst_sn2_s1 = -1 => 0.0873078961,
    pk_mth_gong_did_fst_sn2_s1 = 0  => 0.1787072243,
    pk_mth_gong_did_fst_sn2_s1 = 1  => 0.1064638783,
    pk_mth_gong_did_fst_sn2_s1 = 2  => 0.0681003584,
                                       0.0878498445);

pk_too_young_at_bureau_1m := map(
    (integer)pk_too_young_at_bureau = 0 => 0.0853538663,
    (integer)pk_too_young_at_bureau = 1 => 0.1113251156,
                                  0.0878498445);

pk_addr_hist_advo_college_1m := map(
    pk_addr_hist_advo_college = 0 => 0.0889132406,
    pk_addr_hist_advo_college = 1 => 0.0364963504,
                                     0.0878498445);

pk_nap_summary_ver_s1_1m := map(
    pk_nap_summary_ver_s1 = -1 => 0.1218637993,
    pk_nap_summary_ver_s1 = 0  => 0.0933044932,
    pk_nap_summary_ver_s1 = 1  => 0.0690032859,
                                  0.0878498445);

pk_mth_gong_did_fst_sn2_s2_2m := map(
    pk_mth_gong_did_fst_sn2_s2 = -1 => 0.0143733489,
    pk_mth_gong_did_fst_sn2_s2 = 0  => 0.0286436394,
    pk_mth_gong_did_fst_sn2_s2 = 1  => 0.0189183632,
    pk_mth_gong_did_fst_sn2_s2 = 2  => 0.0144554671,
    pk_mth_gong_did_fst_sn2_s2 = 3  => 0.0124786908,
                                       0.0140849078);

pk_addr_hist_advo_college_2m := map(
    pk_addr_hist_advo_college = 0 => 0.0141909843,
    pk_addr_hist_advo_college = 1 => 0.0053412463,
                                     0.0140849078);

pk_add1_house_number_match_2m := map(
    pk_add1_house_number_match = 0 => 0.036712217,
    pk_add1_house_number_match = 1 => 0.0132671939,
                                      0.0140849078);

pk_mth_gong_did_fst_sn2_s3_3m := map(
    pk_mth_gong_did_fst_sn2_s3 = -1 => 0.0290605992,
    pk_mth_gong_did_fst_sn2_s3 = 0  => 0.0570469799,
    pk_mth_gong_did_fst_sn2_s3 = 1  => 0.0366843034,
    pk_mth_gong_did_fst_sn2_s3 = 2  => 0.0246165008,
    pk_mth_gong_did_fst_sn2_s3 = 3  => 0.022530113,
                                       0.0270104534);

pk_mth_add1_date_fst_sn2_s3_3m := map(
    pk_mth_add1_date_fst_sn2_s3 = -1 => 0.0511262596,
    pk_mth_add1_date_fst_sn2_s3 = 0  => 0.04,
    pk_mth_add1_date_fst_sn2_s3 = 1  => 0.0369582043,
    pk_mth_add1_date_fst_sn2_s3 = 2  => 0.0286988019,
    pk_mth_add1_date_fst_sn2_s3 = 3  => 0.0270079019,
    pk_mth_add1_date_fst_sn2_s3 = 4  => 0.01966971,
    pk_mth_add1_date_fst_sn2_s3 = 5  => 0.0139283121,
                                        0.0270104534);

pk_addr_hist_advo_college_3m := map(
    pk_addr_hist_advo_college = 0 => 0.0273249405,
    pk_addr_hist_advo_college = 1 => 0.0085251492,
                                     0.0270104534);

pk_add1_house_number_match_3m := map(
    pk_add1_house_number_match = 0 => 0.0524914979,
    pk_add1_house_number_match = 1 => 0.0242905395,
                                      0.0270104534);

pk_time_on_cb2_s1_1m := map(
    pk_time_on_cb2_s1 = -1 => 0.1422070535,
    pk_time_on_cb2_s1 = 0  => 0.1865008881,
    pk_time_on_cb2_s1 = 1  => 0.1563136456,
    pk_time_on_cb2_s1 = 2  => 0.1082239486,
    pk_time_on_cb2_s1 = 3  => 0.0775052192,
    pk_time_on_cb2_s1 = 4  => 0.0692247861,
    pk_time_on_cb2_s1 = 5  => 0.052691758,
                              0.0878498445);

pk_time_since_cb3_1m := map(
    pk_time_since_cb3 = 0 => 0.0870101244,
    pk_time_since_cb3 = 1 => 0.1795918367,
                             0.0878498445);

pk_pos_dob_src_cnt_s2_2m := map(
    pk_pos_dob_src_cnt_s2 = 0 => 0.019551348,
    pk_pos_dob_src_cnt_s2 = 1 => 0.0132078587,
                                 0.0140849078);

derog_mod_0m := -6.13576804 +
    pk_attr_total_number_derogs_0m * 9.3331496377 +
    pk_crim_fel_flag_0m * 13.143708695 +
    pk_eviction_lvl_0m * 7.3700576551 +
    pk_unrel_lien_lvl_0m * 8.9466402638 +
    bankrupt_0m * 16.011084801 +
    pk_impulse_flag * 2.4931427584;

prop_owner_mod_0m := -4.41586031 +
    pk_ver_src_p_0m * 12.516565479 +
    pk_prop_owned_purch_flag_0m * 5.7187605132 +
    pk_add1_naprop4_0m * 8.2491242885;

prop_owner_mod_1m := -4.119421276 +
    pk_ver_src_p_1m * 11.50422511 +
    pk_add1_naprop4_1m * 8.6236762719;

prop_owner_mod_3m := -4.864143029 + pk_ver_src_p_3m * 45.975872588;

financing_mod_0m := -2.819415198 + pk_baloon_mortgage * 1.209994132;

financing_mod_2m := -4.318840575 +
    pk_2nd_mortgage * 0.7259505049 +
    pk_baloon_mortgage * 1.1630288186 +
    pk_adj_finance * 0.351346294;

financing_mod_3m := -3.602956981 +
    pk_2nd_mortgage * 0.6638882749 +
    pk_adj_finance * 0.2750406154;

email_mod_1m := -3.329001164 + pk_email_count_s1_1m * 11.248723668;

email_mod_2m := -4.971433824 + pk_email_domain_free_count_s2_2m * 51.001538056;

email_mod_3m := -4.425063336 + pk_email_domain_free_count_s3_3m * 31.051485866;

fp_mod2_1m := -3.180987059 + pk_addprob_s1_1m * 9.5155297565;

ams_mod_0m := -4.142233253 + pk_college_tier_s0_0m * 23.41466177;

ams_mod_1m := -6.371983272 +
    pk_grad_student_1m * 17.937172019 +
    pk_ams_senior_1m * 9.8207615317 +
    pk_college_tier_s1_1m * 17.030952044;

ams_mod_2m := -6.788452119 +
    pk_grad_student_2m * 85.041327392 +
    pk_college_tier_s2_2m * 94.762607215;

ams_mod_3m := -4.829016474 + pk_4yr_college_3m * 45.786518183;

inquiry_mod_0m := -3.435795816 +
    pk_inq_recent_lvl_s0_0m * 3.990328493 +
    pk_inq_peradl_s0_0m * 2.0027290764 +
    pk_inq_adlsperphone_s0_0m * 4.0228807529;

inquiry_mod_1m := -3.137458578 +
    pk_inq_recent_lvl_s1_1m * 4.7485458561 +
    pk_inq_peraddr_1m * 3.7210059561;

inquiry_mod_2m := -4.720980683 + pk_mth_inq_frst_log_dt2_s2_2m * 32.623012423;

inquiry_mod_3m := -4.13003928 +
    pk_inq_recent_lvl_s3_3m * 7.3435047646 +
    pk_inq_peraddr_3m * 5.9686575266 +
    pk_inq_adlsperphone_s3_3m * 5.026470537;

velo_mod_0m := -7.0238857 +
    pk_addrs_per_ssn_c6_s0_0m * 10.870842239 +
    pk_ssns_per_adl_c6_0m * 5.5370768191 +
    pk_ssns_per_addr_c6_s0_0m * 8.222562725 +
    pk_attr_addrs_last24_s0_0m * 5.4544984232 +
    pk_recent_addr_s0_0m * 5.8444054 +
    pk_phones_per_adl_s0_0m * 18.807703437 +
    pk_ssns_per_addr_0m * 6.3078515686 +
    pk_phones_per_addr_s0_0m * 11.589909799;

velo_mod_1m := -7.903920386 +
    pk_adlperssn_count_s1_1m * 11.80976186 +
    pk_ssns_per_adl_s1_1m * 11.065233911 +
    pk_addrs_per_ssn_c6_s1_1m * 10.091573956 +
    pk_ssns_per_adl_c6_1m * 3.0964475191 +
    pk_ssns_per_addr_c6_s1_1m * 9.5011342145 +
    pk_phones_per_addr_c6_1m * 9.112129103 +
    pk_attr_addrs_last12_s1_1m * 7.8795300804;

velo_mod_2m := -7.814850961 +
    pk_ssns_per_adl_s2_2m * 50.665296275 +
    pk_addrs_per_ssn_c6_s2_2m * 37.436601044 +
    pk_adls_per_addr_c6_s2_2m * 25.607924542 +
    pk_adls_per_phone_c6_2m * -30.29448194 +
    pk_attr_addrs_last36_s2_2m * 24.47530058 +
    pk_recent_addr_s2_2m * 21.510962018 +
    pk_ssns_per_addr_2m * 30.311887525 +
    pk_phones_per_addr_s2_2m * 20.370965388 +
    pk_adls_per_phone_2m * 63.388740934;

velo_mod_3m := -9.259472734 +
    pk_adlperssn_count_s3_3m * 33.710646116 +
    pk_ssns_per_adl_s3_3m * 29.594364353 +
    pk_addrs_per_ssn_c6_s3_3m * 18.805570748 +
    pk_phones_per_adl_c6_s3_3m * 21.241190975 +
    pk_ssns_per_addr_c6_s3_3m * 20.663453736 +
    pk_phones_per_addr_c6_3m * 23.940623893 +
    pk_attr_addrs_last36_s3_3m * 22.92767413 +
    pk_phones_per_addr_s3_3m * 13.213015025 +
    pk_adls_per_phone_3m * 22.097757033;

mod8_0m_1 := 6.26699123 +
    pk_age_estimate_s0_0m * 2.7739642504 +
    pk_estimated_income_s0_0m * 3.073745963 +
    pk_add1_avm_auto_val_s0_0m * 7.5049613997 +
    pk_verx_s0_0m * 4.8570873285 +
    derog_mod_0m * 0.5845651145 +
    financing_mod_0m * 1.1296665153 +
    pk_addrs_prison_history * 1.2808637342 +
    prop_owner_mod_0m * 0.151313427 +
    pk_addrs_5yr_s0_0m * 5.3712818446 +
    ssn_adl_prob_0m * 12.548101437 +
    ssn_issued18_0m * 12.004608552 +
    ams_mod_0m * 1.5491765648 +
    pk_num_nonderogs90_s0_0m * 2.9674684832 +
    pk_mth_gong_did_fst_sn2_s0_0m * 3.4814816546 +
    inquiry_mod_0m * 0.5473949502 +
    velo_mod_0m * 0.4028429785;

mod8_0m := 100 * exp(mod8_0m_1) / (1 + exp(mod8_0m_1));

mod8_1m_1 := -1.545301323 +
    pk_age_estimate_s1_1m * 5.377234959 +
    pk_estimated_income_s1_1m * 3.308268356 +
    pk_add1_avm_auto_val_s1_1m * 8.9453912632 +
    pk_verx_s1_1m * 4.5323070165 +
    pk_dob_ver_1m * 4.2869915006 +
    prop_owner_mod_1m * 0.417331337 +
    email_mod_1m * 1.0726725676 +
    fp_mod2_1m * 0.701579615 +
    ssn_issued18_1m * 22.981894417 +
    ams_mod_1m * 0.7800733285 +
    pk_contrary_infutor_ver_1m * 4.9731568391 +
    pk_mth_gong_did_fst_sn2_s1_1m * 8.7990093348 +
    pk_too_young_at_bureau_1m * 16.067713959 +
    pk_addr_hist_advo_college_1m * 10.326425575 +
    pk_nap_summary_ver_s1_1m * 8.4079610757 +
    pk_time_on_cb2_s1_1m * 2.2934957839 +
    inquiry_mod_1m * 0.6217063664 +
    velo_mod_1m * 0.5856058321;

mod8_1m := 100 * exp(mod8_1m_1) / (1 + exp(mod8_1m_1));

mod8_2m_1 := 7.0534390485 +
    pk_age_estimate_s2_2m * 34.274445838 +
    pk_estimated_income_s2_2m * 44.068470793 +
    pk_add1_avm_auto_val_s2_2m * 42.309811252 +
    pk_prof_lic_cat_s2_2m * 59.513874135 +
    financing_mod_2m * 0.918390981 +
    pk_addrs_5yr_s2_2m * 8.9339801963 +
    (integer)rc_input_addr_not_most_recent * 0.150249678 +
    email_mod_2m * 0.4605769252 +
    pk_addprob_s2_2m * 21.183754226 +
    pk_phnprob_s2_2m * 13.300651322 +
    ams_mod_2m * 1.4579276978 +
    pk_contrary_infutor_ver_2m * 18.495187271 +
    pk_mth_gong_did_fst_sn2_s2_2m * 22.698241364 +
    pk_addr_hist_advo_college_2m * 145.60658663 +
    pk_add1_house_number_match_2m * 28.212130098 +
    pk_pos_dob_src_cnt_s2_2m * 24.446265739 +
    inquiry_mod_2m * 0.7533049138 +
    velo_mod_2m * 0.6457800763;

mod8_2m := 100 * exp(mod8_2m_1) / (1 + exp(mod8_2m_1));

mod8_3m_1 := 1.9538188366 +
    pk_estimated_income_s3_3m * 9.9328006071 +
    pk_add1_avm_auto_val_s3_3m * 25.02124434 +
    pk_verx_s3_3m * 8.3122146315 +
    pk_dob_ver_3m * 10.879814814 +
    pk_prof_lic_cat_s3_3m * 34.436469725 +
    financing_mod_3m * 0.8304117363 +
    prop_owner_mod_3m * 0.6083182047 +
    pk_addrs_5yr_s3_3m * 10.250404543 +
    email_mod_3m * 0.7556213516 +
    pk_addprob_s3_3m * 10.028036081 +
    ssn_issued18_3m * 195.68639135 +
    ams_mod_3m * 1.1374960366 +
    pk_contrary_infutor_ver_3m * 17.317516468 +
    pk_mth_gong_did_fst_sn2_s3_3m * 11.303700779 +
    pk_mth_add1_date_fst_sn2_s3_3m * 2.710798666 +
    pk_addr_hist_advo_college_3m * 69.810935363 +
    pk_add1_house_number_match_3m * 10.471164629 +
    inquiry_mod_3m * 0.717546622 +
    velo_mod_3m * 0.6636221375;

mod8_3m := 100 * exp(mod8_3m_1) / (1 + exp(mod8_3m_1));

mod8_nodob_0m_1 := 6.7179860738 +
    pk_age_estimate_s0_0m * 2.9990337154 +
    pk_estimated_income_s0_0m * 2.9053537317 +
    pk_add1_avm_auto_val_s0_0m * 7.9015940165 +
    pk_verx_s0_0m * 4.8772596717 +
    derog_mod_0m * 0.5825820701 +
    financing_mod_0m * 1.1276870584 +
    pk_addrs_prison_history * 1.32874535 +
    prop_owner_mod_0m * 0.1608301108 +
    pk_addrs_5yr_s0_0m * 5.5050099401 +
    ssn_adl_prob_0m * 12.283213577 +
    ams_mod_0m * 1.4693423108 +
    pk_num_nonderogs90_s0_0m * 2.8365945639 +
    pk_mth_gong_did_fst_sn2_s0_0m * 3.521698492 +
    inquiry_mod_0m * 0.5488230536 +
    velo_mod_0m * 0.3973008626;

mod8_nodob_0m := 100 * exp(mod8_nodob_0m_1) / (1 + exp(mod8_nodob_0m_1));

mod8_nodob_1m_1 := -0.532648123 +
    pk_age_estimate_s1_1m * 7.5438290771 +
    pk_estimated_income_s1_1m * 3.0795096918 +
    pk_add1_avm_auto_val_s1_1m * 8.9942707659 +
    pk_verx_s1_1m * 4.3447325497 +
    pk_adlperssn_count_s1_1m * 7.7832928559 +
    prop_owner_mod_1m * 0.4240204337 +
    email_mod_1m * 1.0724514608 +
    pk_addprob_s1_1m * 6.6590588025 +
    ams_mod_1m * 0.7860016723 +
    pk_mth_gong_did_fst_sn2_s1_1m * 8.6557765439 +
    pk_addr_hist_advo_college_1m * 10.593898059 +
    pk_nap_summary_ver_s1_1m * 9.0980023527 +
    pk_time_since_cb3_1m * 3.8447802442 +
    inquiry_mod_1m * 0.6312569184 +
    velo_mod_1m * 0.579112048;

mod8_nodob_1m := 100 * exp(mod8_nodob_1m_1) / (1 + exp(mod8_nodob_1m_1));

mod8_nodob_2m_1 := 7.3468796986 +
    pk_age_estimate_s2_2m * 30.311783204 +
    pk_estimated_income_s2_2m * 43.827944495 +
    pk_add1_avm_auto_val_s2_2m * 41.98475476 +
    pk_mth_hdr_frst_sn_s2_2m * 8.7948373806 +
    pk_prof_lic_cat_s2_2m * 59.411647621 +
    financing_mod_2m * 0.9179262519 +
    pk_addrs_5yr_s2_2m * 8.4166631522 +
    (integer)rc_input_addr_not_most_recent * 0.1530566986 +
    email_mod_2m * 0.4537693766 +
    pk_addprob_s2_2m * 21.194302356 +
    pk_phnprob_s2_2m * 13.341843655 +
    ams_mod_2m * 1.4641307936 +
    pk_contrary_infutor_ver_2m * 18.388436107 +
    pk_mth_gong_did_fst_sn2_s2_2m * 22.992018739 +
    pk_addr_hist_advo_college_2m * 145.56396798 +
    pk_add1_house_number_match_2m * 27.934356076 +
    inquiry_mod_2m * 0.7562229974 +
    velo_mod_2m * 0.6438452239;

mod8_nodob_2m := 100 * exp(mod8_nodob_2m_1) / (1 + exp(mod8_nodob_2m_1));

mod8_nodob_3m_1 := 5.9615178992 +
    pk_age_estimate_s3_3m * 15.887767473 +
    pk_estimated_income_s3_3m * 7.015814043 +
    pk_add1_avm_auto_val_s3_3m * 26.986478198 +
    pk_verx_s3_3m * 9.2776087205 +
    pk_ssns_per_adl_s3_3m * 17.347371803 +
    pk_prof_lic_cat_s3_3m * 33.798090663 +
    financing_mod_3m * 0.7844396783 +
    prop_owner_mod_3m * 0.5880225978 +
    pk_addrs_5yr_s3_3m * 8.586665481 +
    email_mod_3m * 0.7036102492 +
    pk_addprob_s3_3m * 8.3556593541 +
    ams_mod_3m * 1.083068021 +
    pk_contrary_infutor_ver_3m * 16.419477069 +
    pk_mth_gong_did_fst_sn2_s3_3m * 10.797828779 +
    pk_addr_hist_advo_college_3m * 71.444809677 +
    pk_add1_house_number_match_3m * 12.439705792 +
    inquiry_mod_3m * 0.7079660055 +
    velo_mod_3m * 0.6229300386;

mod8_nodob_3m := 100 * exp(mod8_nodob_3m_1) / (1 + exp(mod8_nodob_3m_1));

mod8_nodob := map(
    pk_segment_40 = '0 Derog' => mod8_nodob_0m,
    pk_segment_40 = '1 Young' => mod8_nodob_1m,
    pk_segment_40 = '2 Owner' => mod8_nodob_2m,
    pk_segment_40 = '3 Other' => mod8_nodob_3m,
                                 NULL);

mod8 := map(
    pk_segment_40 = '0 Derog' => mod8_0m,
    pk_segment_40 = '1 Young' => mod8_1m,
    pk_segment_40 = '2 Owner' => mod8_2m,
		pk_segment_40 = '3 Other' => mod8_3m,
                                 NULL);

mod8_phat :=if(mod8 = NULL, NULL, mod8 / 100);

mod8_scr := if(mod8 = NULL, NULL, round(-40 * (ln(mod8_phat / (1 - mod8_phat)) - ln(1 / 20)) / ln(2) + 700));

mod8_nodob_phat := if(mod8_nodob = NULL, NULL, mod8_nodob / 100);

mod8_nodob_scr := if(mod8_nodob = NULL, NULL, round(-40 * (ln(mod8_nodob_phat / (1 - mod8_nodob_phat)) - ln(1 / 20)) / ln(2) + 700));

rvb1104a := if((integer)dobpop = 1, mod8_scr, mod8_nodob_scr);

rvb1104b := min(900, if(max((real)501, rvb1104a) = NULL, -NULL, max((real)501, rvb1104a)));

ov_ssndead := (integer)ssnlength > 0 and (integer)rc_decsflag = 1;

ov_ssnprior := (integer)rc_ssndobflag = 1 or (integer)rc_pwssndobflag = 1;

ov_criminal_flag := criminal_count > 0;

ov_corrections := (integer)rc_hrisksic = 2225;

ov_impulse := impulse_count_1 > 0;

rvb1104c := if(rvb1104b > 680 and (ov_ssndead or ov_ssnprior or ov_criminal_flag or ov_corrections or ov_impulse), 680, rvb1104b);

scored_222s := if(max(property_owned_total, property_sold_total) = NULL, NULL, sum(if(property_owned_total = NULL, 0, property_owned_total), if(property_sold_total = NULL, 0, property_sold_total))) > 0 OR (90 <= combo_dobscore AND combo_dobscore <= 100 or (integer)input_dob_match_level >= 7 or (integer)lien_flag > 0 or criminal_count > 0 or (integer)bk_flag > 0 or ssn_deceased or truedid);

rvb1104d := if(riskview.constants.noscore(le.iid.nas_summary,le.iid.nap_summary, le.address_verification.input_address_information.naprop, le.truedid), 222, rvb1104c);

rvb1104e := if((integer)ssn_deceased > 0, 200, rvb1104d);

rvb1104 := rvb1104e;

pk_em_domain_free_count_s2_2m := pk_email_domain_free_count_s2_2m;

pk_em_domain_free_count_s3_3m := pk_email_domain_free_count_s3_3m;

add1_assessed_amount := add1_market_total_value;

glrc25 := if((integer)addrpop = 1 and combo_addrcount = 0, 1, 0);

glrc28 := if((integer)dobpop > 0 and combo_dobcount = 0, 1, 0);

glrc36 := 1;

glrc97 := if(criminal_count > 0, 1, 0);

glrc98 := if(liens_recent_unreleased_count > 0 or liens_historical_unreleased_ct > 0, 1, 0);

glrc99 := (integer)addrpop > 0 and (integer)add1_isbestmatch = 0;

glrc9a := if((add1_naprop < 2 or add2_naprop < 2 or add3_naprop < 2) and (integer)add1_applicant_owned = 0 and (integer)add1_family_owned = 0 and (integer)add2_applicant_owned = 0 and (integer)add2_family_owned = 0 and (integer)add3_applicant_owned = 0 and (integer)add3_family_owned = 0 and property_owned_total = 0 and property_sold_total = 0 and property_ambig_total = 0, 1, 0);

glrc9c := if(add1_lres < 84, 1, 0);

glrc9d := if(addrs_10yr > 1, 1, 0);

glrc9e := 1;

glrc9g := 0;

glrc9h := if(impulse_count_1 > 0, 1, 0);

glrc9j := if(pk_mth_header_first_seen < 360, 1, 0);

glrc9m := if((integer)wealth_index < 6, 1, 0);

glrc9n := if((integer)addrs_prison_history > 0, 1, 0);

glrc9q := if(Inq_count12 > 0, 1, 0);

glrc9r := 1;

glrc9s := if(trim(trim(add1_financing_type, LEFT), LEFT, RIGHT) = 'ADJ', 1, 0);

glrc9t := if((integer)hphnpop * (integer)((integer)phn_cell = 1 or trim(trim(nap_status, LEFT), LEFT, RIGHT) != 'C' or pk_phn_nongeo = 1 or pk_phn_phn_not_issued = 1 or (integer)phn_disconnected = 1 or (integer)phn_inval = 1 or (integer)phn_highrisk2 = 1 or (integer)phn_zipmismatch = 1 or (integer)phn_notpots = 1 or (integer)phn_business = 1) = 1, 1, 0);

glrc9u := if((integer)addrpop * (integer)(pk_add1_advo_address_vacancy = 1 or pk_add_hirisk_comm = 1 or pk_zip_corp_mil = 1 or pk_add1_advo_throw_back = 1 or pk_add1_advo_seasonal_delivery = 1 or pk_add1_advo_college = 1 or pk_add1_advo_res_or_business = 1 or pk_add_standarization_err = 1 or pk_zip_po = 1 or pk_add_inval = 1 or pk_add1_advo_drop = 1 or pk_add1_advo_mixed_address_usage = 1 or pk_zip_hirisk_comm = 1) = 1, 1, 0);

glrc9w := if((integer)bankrupt > 0, 1, 0);

glrcev := if(attr_eviction_count > 0, 1, 0);

glrcmi := if((integer)ssnlength > 0 and adlperssn_count >= 3, 1, 0);

glrcms := if(ssns_per_adl >= 3, 1, 0);

aptflag_1 := 0;

aptflag := if(trim(trim(rc_dwelltype, LEFT), LEFT, RIGHT) = 'A', 1, aptflag_1);

add1_econval := map(
    aptflag = 0 and add1_avm_automated_valuation > 0 => add1_avm_automated_valuation,
    aptflag = 0 and add1_assessed_amount > 0         => add1_assessed_amount,
    aptflag = 0 and add1_avm_med_geo12 > 0           => add1_avm_med_geo12,
    aptflag = 0 and add1_avm_med_geo11 > 0           => add1_avm_med_geo11,
    aptflag = 0 and add1_avm_med_fips > 0            => add1_avm_med_fips,
                                                        NULL);

add1_aptval := map(
    aptflag = 1 and add1_avm_med_geo12 > 0 => add1_avm_med_geo12,
    aptflag = 1 and add1_avm_med_geo11 > 0 => add1_avm_med_geo11,
    aptflag = 1 and add1_avm_med_fips > 0  => add1_avm_med_fips,
                                              NULL);

add1_econcode := map(
    aptflag = 0 and add1_econval > 650000 => 'A',
    aptflag = 0 and add1_econval > 450000 => 'B',
    aptflag = 0 and add1_econval > 250000 => 'C',
    aptflag = 0 and add1_econval > 125000 => 'D',
    aptflag = 0 and add1_econval > 75000  => 'E',
    aptflag = 0 and add1_econval > 0      => 'F',
    aptflag = 1 and add1_aptval > 1000000 => 'C',
    aptflag = 1 and add1_aptval > 500000  => 'D',
    aptflag = 1 and add1_aptval > 175000  => 'E',
    aptflag = 1 and add1_aptval > 0       => 'F',
                                             'U');

glrcpv := if((integer)addrpop > 0 and add1_econcode = 'F', 1, 0);

glrcx11 := 0;

header_last_seen2 := common.sas_date((string)(header_last_seen));

yr_header_last_seen := if(min(sysdate, header_last_seen2) = NULL, NULL, (sysdate - header_last_seen2) / 365.25);

mth_header_last_seen := if(min(sysdate, header_last_seen2) = NULL, NULL, (sysdate - header_last_seen2) / 30.5);

pk_mth_header_last_seen := if (mth_header_last_seen >= 0, roundup(mth_header_last_seen), truncate(mth_header_last_seen));

glrc9f := if(pk_mth_header_last_seen > 3, 1, 0);

m_financing_mod_0m_c500 := if(pk_segment_40 = '0 Derog', 1.1296665153, NULL);

m_inquiry_mod_0m_c500 := if(pk_segment_40 = '0 Derog', 0.5473949502, NULL);

m_prop_owner_mod_0m_c500 := if(pk_segment_40 = '0 Derog', 0.151313427, NULL);

m_velo_mod_0m_c500 := if(pk_segment_40 = '0 Derog', 0.4028429785, NULL);

m_derog_mod_0m_c500 := if(pk_segment_40 = '0 Derog', 0.5845651145, NULL);

m_inquiry_mod_1m_c501 := if(pk_segment_40 = '1 Young', 0.6217063664, NULL);

m_fp_mod2_1m_c501 := if(pk_segment_40 = '1 Young', 0.701579615, NULL);

m_velo_mod_1m_c501 := if(pk_segment_40 = '1 Young', 0.5856058321, NULL);

m_email_mod_1m_c501 := if(pk_segment_40 = '1 Young', 1.0726725676, NULL);

m_prop_owner_mod_1m_c501 := if(pk_segment_40 = '1 Young', 0.417331337, NULL);

m_velo_mod_2m_c502 := if(pk_segment_40 = '2 Owner', 0.6457800763, NULL);

m_financing_mod_2m_c502 := if(pk_segment_40 = '2 Owner', 0.918390981, NULL);

m_email_mod_2m_c502 := if(pk_segment_40 = '2 Owner', 0.4605769252, NULL);

m_inquiry_mod_2m_c502 := if(pk_segment_40 = '2 Owner', 0.7533049138, NULL);

m_prop_owner_mod_3m_c503 := if(pk_segment_40 = '3 Other', 0.6083182047, NULL);

m_email_mod_3m_c503 := if(pk_segment_40 = '3 Other', 0.7556213516, NULL);

m_velo_mod_3m_c503 := if(pk_segment_40 = '3 Other', 0.6636221375, NULL);

m_inquiry_mod_3m_c503 := if(pk_segment_40 = '3 Other', 0.717546622, NULL);

m_financing_mod_3m_c503 := if(pk_segment_40 = '3 Other', 0.8304117363, NULL);

_25_0_c499_b1 := 0;

_25_1_c499_b1_1 := 0;

_25_2_c499_b1_1 := 0;

_28_0_c499_b1 := 0;

_28_1_c499_b1_1 := 0;

_28_2_c499_b1_1 := 0;

_28_3_c499_b1_1 := 0;

_36_0_c499_b1 := 0;

_36_1_c499_b1_1 := 0;

_36_2_c499_b1_1 := 0;

_36_3_c499_b1_1 := 0;

_97_0_c499_b1_1 := 0;

_97_1_c499_b1_1 := 0;

_98_0_c499_b1_1 := 0;

_98_1_c499_b1_1 := 0;

_99_0_c499_b1 := 0;

_99_1_c499_b1_1 := 0;

_9a_0_c499_b1 := 0;

_9a_1_c499_b1_1 := 0;

_9a_2_c499_b1_1 := 0;

_9a_3_c499_b1_1 := 0;

_9a_4_c499_b1_1 := 0;

_9a_5_c499_b1_1 := 0;

_9a_6_c499_b1_1 := 0;

_9a_7_c499_b1_1 := 0;

_9c_0_c499_b1 := 0;

_9c_1_c499_b1_1 := 0;

_9d_0_c499_b1 := 0;

_9d_1_c499_b1_1 := 0;

_9d_2_c499_b1_1 := 0;

_9d_3_c499_b1_1 := 0;

_9d_4_c499_b1_1 := 0;

_9d_5_c499_b1_1 := 0;

_9d_6_c499_b1_1 := 0;

_9d_7_c499_b1_1 := 0;

_9d_8_c499_b1_1 := 0;

_9d_9_c499_b1_1 := 0;

_9d_10_c499_b1_1 := 0;

_9d_11_c499_b1_1 := 0;

_9d_12_c499_b1_1 := 0;

_9d_13_c499_b1_1 := 0;

_9e_0_c499_b1 := 0;

_9e_1_c499_b1_1 := 0;

_9e_2_c499_b1_1 := 0;

_9g_0_c499_b1 := 0;

_9g_1_c499_b1_1 := 0;

_9g_2_c499_b1_1 := 0;

_9g_3_c499_b1_1 := 0;

_9g_4_c499_b1_1 := 0;

_9g_5_c499_b1_1 := 0;

_9h_0_c499_b1_1 := 0;

_9h_1_c499_b1_1 := 0;

_9m_0_c499_b1 := 0;

_9m_1_c499_b1_1 := 0;

_9m_2_c499_b1_1 := 0;

_9m_3_c499_b1_1 := 0;

_9m_4_c499_b1_1 := 0;

_9n_0_c499_b1 := 0;

_9n_1_c499_b1_1 := 0;

_9q_0_c499_b1 := 0;

_9q_1_c499_b1_1 := 0;

_9q_2_c499_b1_1 := 0;

_9q_3_c499_b1_1 := 0;

_9q_4_c499_b1_1 := 0;

_9q_5_c499_b1_1 := 0;

_9q_6_c499_b1_1 := 0;

_9q_7_c499_b1_1 := 0;

_9q_8_c499_b1_1 := 0;

_9q_9_c499_b1_1 := 0;

_9r_0_c499_b1 := 0;

_9r_1_c499_b1_1 := 0;

_9r_2_c499_b1_1 := 0;

_9r_3_c499_b1_1 := 0;

_9r_4_c499_b1_1 := 0;

_9r_5_c499_b1_1 := 0;

_9r_6_c499_b1_1 := 0;

_9r_7_c499_b1_1 := 0;

_9r_8_c499_b1_1 := 0;

_9r_9_c499_b1_1 := 0;

_9r_10_c499_b1_1 := 0;

_9r_11_c499_b1_1 := 0;

_9s_0_c499_b1 := 0;

_9s_1_c499_b1_1 := 0;

_9s_2_c499_b1_1 := 0;

_9s_3_c499_b1_1 := 0;

_9s_4_c499_b1_1 := 0;

_9s_5_c499_b1_1 := 0;

_9s_6_c499_b1_1 := 0;

_9t_0_c499_b1 := 0;

_9t_1_c499_b1_1 := 0;

_9u_0_c499_b1 := 0;

_9u_1_c499_b1_1 := 0;

_9u_2_c499_b1_1 := 0;

_9u_3_c499_b1_1 := 0;

_9w_0_c499_b1_1 := 0;

_9w_1_c499_b1_1 := 0;

_9w_2_c499_b1 := 0;

_ev_0_c499_b1_1 := 0;

_ev_1_c499_b1_1 := 0;

_mi_0_c499_b1 := 0;

_mi_1_c499_b1_1 := 0;

_mi_2_c499_b1_1 := 0;

_ms_0_c499_b1 := 0;

_ms_1_c499_b1_1 := 0;

_ms_2_c499_b1_1 := 0;

_ms_3_c499_b1_1 := 0;

_ms_4_c499_b1_1 := 0;

_ms_5_c499_b1_1 := 0;

_ms_6_c499_b1_1 := 0;

_pv_0_c499_b1 := 0;

_pv_1_c499_b1_1 := 0;

_pv_2_c499_b1_1 := 0;

_pv_3_c499_b1_1 := 0;

_pv_4_c499_b1_1 := 0;

_x11_0_c499_b1 := 0;

_x11_1_c499_b1_1 := 0;

_x11_2_c499_b1_1 := 0;

_x11_3_c499_b1_1 := 0;

_x11_4_c499_b1_1 := 0;

_x11_5_c499_b1_1 := 0;

_x11_6_c499_b1_1 := 0;

_x11_7_c499_b1_1 := 0;

_x11_8_c499_b1_1 := 0;

_x11_9_c499_b1_1 := 0;

_x11_10_c499_b1_1 := 0;

_x11_11_c499_b1_1 := 0;

_x11_12_c499_b1_1 := 0;

_x11_13_c499_b1_1 := 0;

_x11_14_c499_b1_1 := 0;

_x11_15_c499_b1_1 := 0;

_x11_16_c499_b1_1 := 0;

_9j_0_c499_b1 := 0;

_9j_1_c499_b1_1 := 0;

_9f_0_c499_b1 := 0;

_9f_1_c499_b1_1 := 0;

seg_s0_crime_c505_b1 := -2.81454014268427;

_97_0_c505 := if(bs_attr_derog_flag > 0 and criminal_count > 0, (seg_s0_crime_c505_b1 - -4.248466382), NULL);

seg_s0_lien_c506_b1 := -2.81454014268427;

_98_0_c506 := if((integer)lien_flag > 0, (seg_s0_lien_c506_b1 - -4.248466382), NULL);

seg_s0_eviction_c507_b1 := -2.81454014268427;

_ev_0_c507 := if(bs_attr_eviction_flag > 0, (seg_s0_eviction_c507_b1 - -4.248466382), NULL);

seg_s0_impulse_c508_b1 := -2.81454014268427;

_9h_0_c508 := if(pk_impulse_count > 0, (seg_s0_impulse_c508_b1 - -4.248466382), NULL);

seg_s0_bk_c509_b1 := -2.81454014268427;

_9w_0_c509 := if((integer)bk_flag > 0, (seg_s0_bk_c509_b1 - -4.248466382), NULL);

_9d_3_c504 := if(pk_segment_40 = '0 Derog', m_velo_mod_0m_c500 * 5.8444054 * (pk_recent_addr_s0_0m - 0.0507715281), _9d_3_c499_b1_1);

_9q_1_c504 := if(pk_segment_40 = '0 Derog', m_inquiry_mod_0m_c500 * 3.990328493 * (pk_inq_recent_lvl_s0_0m - 0.0510322723), _9q_1_c499_b1_1);

_ev_1_c504 := if(pk_segment_40 = '0 Derog', m_derog_mod_0m_c500 * 7.3700576551 * (pk_eviction_lvl_0m - 0.0536455151), _ev_1_c499_b1_1);

_x11_3_c504 := if(pk_segment_40 = '0 Derog', m_velo_mod_0m_c500 * 6.3078515686 * (pk_ssns_per_addr_0m - 0.0544585462), _x11_3_c499_b1_1);

_9h_1_c504 := if(pk_segment_40 = '0 Derog', m_derog_mod_0m_c500 * 2.4931427584 * (pk_impulse_flag - 0), _9h_1_c499_b1_1);

_9w_1_c504 := if(pk_segment_40 = '0 Derog', m_derog_mod_0m_c500 * 16.011084801 * (bankrupt_0m - 0.055950981), _9w_1_c499_b1_1);

_x11_2_c504 := if(pk_segment_40 = '0 Derog', m_velo_mod_0m_c500 * 18.807703437 * (pk_phones_per_adl_s0_0m - 0.0667526604), _x11_2_c499_b1_1);

_9g_1_c504 := if(pk_segment_40 = '0 Derog', 2.7739642504 * (pk_age_estimate_s0_0m - 0.0535984276), _9g_1_c499_b1_1);

_9s_1_c504 := if(pk_segment_40 = '0 Derog', m_financing_mod_0m_c500 * 1.209994132 * (pk_baloon_mortgage - 0), _9s_1_c499_b1_1);

// _36_1_c504 := if(pk_segment_40 in ['X 200  ','2 Owner'], NULL,if(pk_segment_40 = '0 Derog', 4.8570873285 * (pk_verx_s0_0m - 0.0593320236), _36_1_c499_b1_1));

_36_1_c504 := if(pk_segment_40 = '0 Derog', 4.8570873285 * (pk_verx_s0_0m - 0.0593320236), _36_1_c499_b1_1);

_ms_1_c504 := if(pk_segment_40 = '0 Derog', m_velo_mod_0m_c500 * 5.5370768191 * (pk_ssns_per_adl_c6_0m - 0.0496577474), _ms_1_c499_b1_1);

_9a_1_c504 := if(pk_segment_40 = '0 Derog', m_prop_owner_mod_0m_c500 * 12.516565479 * (pk_ver_src_p_0m - 0.0386540352), _9a_1_c499_b1_1);

_9w_0_c504 := if(pk_segment_40 = '0 Derog', _9w_0_c509, _9w_0_c499_b1_1);

_x11_4_c504 := if(pk_segment_40 = '0 Derog', m_velo_mod_0m_c500 * 11.589909799 * (pk_phones_per_addr_s0_0m - 0.0581807725), _x11_4_c499_b1_1);

_9e_1_c504 := if(pk_segment_40 = '0 Derog', 2.9674684832 * (pk_num_nonderogs90_s0_0m - 0.0492027702), _9e_1_c499_b1_1);

_98_0_c504 := if(pk_segment_40 = '0 Derog', _98_0_c506, _98_0_c499_b1_1);

_97_1_c504 := if(pk_segment_40 = '0 Derog', m_derog_mod_0m_c500 * 13.143708695 * (pk_crim_fel_flag_0m - 0.0547007453), _97_1_c499_b1_1);

_9m_1_c504 := if(pk_segment_40 = '0 Derog', 3.073745963 * (pk_estimated_income_s0_0m - 0.0389371862), _9m_1_c499_b1_1);

_ms_2_c504 := if(pk_segment_40 = '0 Derog', 12.548101437 * (ssn_adl_prob_0m - 0.0549828179), _ms_2_c499_b1_1);

_9q_3_c504 := if(pk_segment_40 = '0 Derog', m_inquiry_mod_0m_c500 * 4.0228807529 * (pk_inq_adlsperphone_s0_0m - 0.0510322723), _9q_3_c499_b1_1);

_98_1_c504 := if(pk_segment_40 = '0 Derog', m_derog_mod_0m_c500 * 8.9466402638 * (pk_unrel_lien_lvl_0m - 0.0524842018), _98_1_c499_b1_1);

_ev_0_c504 := if(pk_segment_40 = '0 Derog', _ev_0_c507, _ev_0_c499_b1_1);

_9q_2_c504 := if(pk_segment_40 = '0 Derog', m_inquiry_mod_0m_c500 * 2.0027290764 * (pk_inq_peradl_s0_0m - 0.0510322723), _9q_2_c499_b1_1);

_9h_0_c504 := if(pk_segment_40 = '0 Derog', _9h_0_c508, _9h_0_c499_b1_1);

_9d_2_c504 := if(pk_segment_40 = '0 Derog', m_velo_mod_0m_c500 * 5.4544984232 * (pk_attr_addrs_last24_s0_0m - 0.0447368421), _9d_2_c499_b1_1);

_9d_1_c504 := if(pk_segment_40 = '0 Derog', m_velo_mod_0m_c500 * 10.870842239 * (pk_addrs_per_ssn_c6_s0_0m - 0.052182623), _9d_1_c499_b1_1);

_9d_4_c504 := if(pk_segment_40 = '0 Derog', 5.3712818446 * (pk_addrs_5yr_s0_0m - 0.0616986301), _9d_4_c499_b1_1);

_9n_1_c504 := if(pk_segment_40 = '0 Derog', 1.2808637342 * (pk_addrs_prison_history - 0), _9n_1_c499_b1_1);

_9a_3_c504 := if(pk_segment_40 = '0 Derog', m_prop_owner_mod_0m_c500 * 8.2491242885 * (pk_add1_naprop4_0m - 0.0363378114), _9a_3_c499_b1_1);

_9r_1_c504 := if(pk_segment_40 = '0 Derog', 3.4814816546 * (pk_mth_gong_did_fst_sn2_s0_0m - 0.0472106878), _9r_1_c499_b1_1);

_pv_1_c504 := if(pk_segment_40 = '0 Derog', 7.5049613997 * (pk_add1_avm_auto_val_s0_0m - 0.0598949212), _pv_1_c499_b1_1);

_97_0_c504 := if(pk_segment_40 = '0 Derog', _97_0_c505, _97_0_c499_b1_1);

_x11_1_c504 := if(pk_segment_40 = '0 Derog', m_velo_mod_0m_c500 * 8.222562725 * (pk_ssns_per_addr_c6_s0_0m - 0.0479833951), _x11_1_c499_b1_1);

_9a_2_c504 := if(pk_segment_40 = '0 Derog', m_prop_owner_mod_0m_c500 * 5.7187605132 * (pk_prop_owned_purch_flag_0m - 0.063502861), _9a_2_c499_b1_1);

_9u_1_c511 := if((pk_add_apt1 = 1 or pk_add_apt2 = 1) and pk_add1_advo_address_vacancy = 0 and pk_add_hirisk_comm = 0 and pk_zip_corp_mil = 0 and pk_add1_advo_throw_back = 0 and pk_add1_advo_seasonal_delivery = 0 and pk_add1_advo_college = 0 and pk_add1_advo_res_or_business = 0 and pk_add_standarization_err = 0 and pk_zip_po = 0 and pk_add_inval = 0 and pk_add1_advo_drop = 0 and pk_add1_advo_mixed_address_usage = 0 and pk_zip_hirisk_comm = 0 and pk_unit_changed = 0 and pk_addr_changed = 0, NULL, m_fp_mod2_1m_c501 * 9.5155297565 * (pk_addprob_s1_1m - 0.0879845402));

seg_s1_c510_b1 := -2.34017557597253;

_x11_5_c510 := if(pk_segment_40 = '1 Young', m_velo_mod_1m_c501 * 9.5011342145 * (pk_ssns_per_addr_c6_s1_1m - 0.0677562778), _x11_5_c499_b1_1);

_x11_6_c510 := if(pk_segment_40 = '1 Young', m_velo_mod_1m_c501 * 9.112129103 * (pk_phones_per_addr_c6_1m - 0.0840170509), _x11_6_c499_b1_1);

_9q_4_c510 := if(pk_segment_40 = '1 Young', m_inquiry_mod_1m_c501 * 4.7485458561 * (pk_inq_recent_lvl_s1_1m - 0.076869551), _9q_4_c499_b1_1);

_9g_2_c510 := if(pk_segment_40 = '1 Young', (seg_s1_c510_b1 - -4.248466382), _9g_2_c499_b1_1);

_9g_4_c510 := if(pk_segment_40 = '1 Young', 16.067713959 * (pk_too_young_at_bureau_1m - 0.0853538663), _9g_4_c499_b1_1);

_9r_5_c510 := if(pk_segment_40 = '1 Young', 2.2934957839 * (pk_time_on_cb2_s1_1m - 0.0692247861), _9r_5_c499_b1_1);

_9e_2_c510 := if(pk_segment_40 = '1 Young', 8.4079610757 * (pk_nap_summary_ver_s1_1m - 0.0933044932), _9e_2_c499_b1_1);

_9r_4_c510 := if(pk_segment_40 = '1 Young', 8.7990093348 * (pk_mth_gong_did_fst_sn2_s1_1m - 0.0873078961), _9r_4_c499_b1_1);

_ms_4_c510 := if(pk_segment_40 = '1 Young', m_velo_mod_1m_c501 * 3.0964475191 * (pk_ssns_per_adl_c6_1m - 0.0746622422), _ms_4_c499_b1_1);

_9r_3_c510 := if(pk_segment_40 = '1 Young', 4.9731568391 * (pk_contrary_infutor_ver_1m - 0.0845196488), _9r_3_c499_b1_1);

_pv_2_c510 := if(pk_segment_40 = '1 Young', 8.9453912632 * (pk_add1_avm_auto_val_s1_1m - 0.0956815016), _pv_2_c499_b1_1);

_9a_4_c510 := if(pk_segment_40 = '1 Young', m_prop_owner_mod_1m_c501 * 11.50422511 * (pk_ver_src_p_1m - 0.0907238734), _9a_4_c499_b1_1);

_9d_6_c510 := if(pk_segment_40 = '1 Young', m_velo_mod_1m_c501 * 7.8795300804 * (pk_attr_addrs_last12_s1_1m - 0.0725928619), _9d_6_c499_b1_1);

_9g_3_c510 := if(pk_segment_40 = '1 Young', 5.377234959 * (pk_age_estimate_s1_1m - 0.0736484722), _9g_3_c499_b1_1);

_28_1_c510 := if(pk_segment_40 = '1 Young', 4.2869915006 * (pk_dob_ver_1m - 0.0693363999), _28_1_c499_b1_1);

_36_2_c510 := if(pk_segment_40 = '1 Young', 4.5323070165 * (pk_verx_s1_1m - 0.0839347934), _36_2_c499_b1_1);

// _36_2_c510 := if(pk_segment_40 in ['X 200  ','2 Owner'], NULL, if(pk_segment_40 = '1 Young', 4.5323070165 * (pk_verx_s1_1m - 0.0839347934), _36_2_c499_b1_1));

_9q_5_c510 := if(pk_segment_40 = '1 Young', m_inquiry_mod_1m_c501 * 3.7210059561 * (pk_inq_peraddr_1m - 0.076869551), _9q_5_c499_b1_1);

_9a_5_c510 := if(pk_segment_40 = '1 Young', m_prop_owner_mod_1m_c501 * 8.6236762719 * (pk_add1_naprop4_1m - 0.090376569), _9a_5_c499_b1_1);

_mi_1_c510 := if(pk_segment_40 = '1 Young', m_velo_mod_1m_c501 * 11.80976186 * (pk_adlperssn_count_s1_1m - 0.0847328244), _mi_1_c499_b1_1);

_9u_1_c510 := if(pk_segment_40 = '1 Young', _9u_1_c511, _9u_1_c499_b1_1);

_9r_2_c510 := if(pk_segment_40 = '1 Young', m_email_mod_1m_c501 * 11.248723668 * (pk_email_count_s1_1m - 0.0876497315), _9r_2_c499_b1_1);

_9d_5_c510 := if(pk_segment_40 = '1 Young', m_velo_mod_1m_c501 * 10.091573956 * (pk_addrs_per_ssn_c6_s1_1m - 0.0826655052), _9d_5_c499_b1_1);

_ms_3_c510 := if(pk_segment_40 = '1 Young', m_velo_mod_1m_c501 * 11.065233911 * (pk_ssns_per_adl_s1_1m - 0.086062889), _ms_3_c499_b1_1);

_9m_2_c510 := if(pk_segment_40 = '1 Young', 3.308268356 * (pk_estimated_income_s1_1m - 0.0834858188), _9m_2_c499_b1_1);

_9m_3_c512 := if(pk_segment_40 = '2 Owner', 44.068470793 * (pk_estimated_income_s2_2m - 0.0145617705), _9m_3_c499_b1_1);

_28_2_c512 := if(pk_segment_40 = '2 Owner', 24.446265739 * (pk_pos_dob_src_cnt_s2_2m - 0.0132078587), _28_2_c499_b1_1);

_pv_3_c512 := if(pk_segment_40 = '2 Owner', 42.309811252 * (pk_add1_avm_auto_val_s2_2m - 0.0148375451), _pv_3_c499_b1_1);

_ms_5_c512 := if(pk_segment_40 = '2 Owner', m_velo_mod_2m_c502 * 50.665296275 * (pk_ssns_per_adl_s2_2m - 0.0131222201), _ms_5_c499_b1_1);

_9d_7_c512 := if(pk_segment_40 = '2 Owner', m_velo_mod_2m_c502 * 37.436601044 * (pk_addrs_per_ssn_c6_s2_2m - 0.0133419076), _9d_7_c499_b1_1);

_9q_6_c512 := if(pk_segment_40 = '2 Owner', m_inquiry_mod_2m_c502 * 32.623012423 * (pk_mth_inq_frst_log_dt2_s2_2m - 0.0137038529), _9q_6_c499_b1_1);

_x11_8_c512 := if(pk_segment_40 = '2 Owner', m_velo_mod_2m_c502 * -30.29448194 * (pk_adls_per_phone_c6_2m - 0.0111842197), _x11_8_c499_b1_1);

_9u_2_c512 := if(pk_segment_40 = '2 Owner', 21.183754226 * (pk_addprob_s2_2m - 0.0140507795), _9u_2_c499_b1_1);

_9s_2_c512 := if(pk_segment_40 = '2 Owner', m_financing_mod_2m_c502 * 0.7259505049 * (pk_2nd_mortgage - 0), _9s_2_c499_b1_1);

_25_1_c512 := if(pk_segment_40 = '2 Owner', 28.212130098 * (pk_add1_house_number_match_2m - 0.0132671939), _25_1_c499_b1_1);

_x11_9_c512 := if(pk_segment_40 = '2 Owner', m_velo_mod_2m_c502 * 30.311887525 * (pk_ssns_per_addr_2m - 0.0134892288), _x11_9_c499_b1_1);

_9d_8_c512 := if(pk_segment_40 = '2 Owner', m_velo_mod_2m_c502 * 24.47530058 * (pk_attr_addrs_last36_s2_2m - 0.0100559976), _9d_8_c499_b1_1);

_9g_5_c512 := if(pk_segment_40 = '2 Owner', 34.274445838 * (pk_age_estimate_s2_2m - 0.014131362), _9g_5_c499_b1_1);

_9r_6_c512 := if(pk_segment_40 = '2 Owner', m_email_mod_2m_c502 * 51.001538056 * (pk_em_domain_free_count_s2_2m - 0.0137043715), _9r_6_c499_b1_1);

_x11_7_c512 := if(pk_segment_40 = '2 Owner', m_velo_mod_2m_c502 * 25.607924542 * (pk_adls_per_addr_c6_s2_2m - 0.0119689787), _x11_7_c499_b1_1);

_9d_9_c512 := if(pk_segment_40 = '2 Owner', m_velo_mod_2m_c502 * 21.510962018 * (pk_recent_addr_s2_2m - 0.0100559976), _9d_9_c499_b1_1);

_99_1_c512 := if(pk_segment_40 = '2 Owner', 0.150249678 * ((integer)rc_input_addr_not_most_recent - 0), _99_1_c499_b1_1);

_9s_4_c512 := if(pk_segment_40 = '2 Owner', m_financing_mod_2m_c502 * 0.351346294 * (pk_adj_finance - 0), _9s_4_c499_b1_1);

_x11_11_c512 := if(pk_segment_40 = '2 Owner', m_velo_mod_2m_c502 * 63.388740934 * (pk_adls_per_phone_2m - 0.0107968018), _x11_11_c499_b1_1);

_9r_7_c512 := if(pk_segment_40 = '2 Owner', 18.495187271 * (pk_contrary_infutor_ver_2m - 0.0133991912), _9r_7_c499_b1_1);

_9s_3_c512 := if(pk_segment_40 = '2 Owner', m_financing_mod_2m_c502 * 1.1630288186 * (pk_baloon_mortgage - 0), _9s_3_c499_b1_1);

_x11_10_c512 := if(pk_segment_40 = '2 Owner', m_velo_mod_2m_c502 * 20.370965388 * (pk_phones_per_addr_s2_2m - 0.011890263), _x11_10_c499_b1_1);

_9t_1_c512 := if(pk_segment_40 = '2 Owner', 13.300651322 * (pk_phnprob_s2_2m - 0.0110535714), _9t_1_c499_b1_1);

_9r_8_c512 := if(pk_segment_40 = '2 Owner', 22.698241364 * (pk_mth_gong_did_fst_sn2_s2_2m - 0.0143733489), _9r_8_c499_b1_1);

_9d_10_c512 := if(pk_segment_40 = '2 Owner', 8.9339801963 * (pk_addrs_5yr_s2_2m - 0.013676897), _9d_10_c499_b1_1);

seg_s3_c513_b1 := -3.58414938616816;

_ms_6_c513 := if(pk_segment_40 = '3 Other', m_velo_mod_3m_c503 * 29.594364353 * (pk_ssns_per_adl_s3_3m - 0.0260587993), _ms_6_c499_b1_1);

_9q_8_c513 := if(pk_segment_40 = '3 Other', m_inquiry_mod_3m_c503 * 5.9686575266 * (pk_inq_peraddr_3m - 0.0246590642), _9q_8_c499_b1_1);

_x11_14_c513 := if(pk_segment_40 = '3 Other', m_velo_mod_3m_c503 * 23.940623893 * (pk_phones_per_addr_c6_3m - 0.024502514), _x11_14_c499_b1_1);

_x11_15_c513 := if(pk_segment_40 = '3 Other', m_velo_mod_3m_c503 * 13.213015025 * (pk_phones_per_addr_s3_3m - 0.0298539519), _x11_15_c499_b1_1);

_9d_11_c513 := if(pk_segment_40 = '3 Other', m_velo_mod_3m_c503 * 18.805570748 * (pk_addrs_per_ssn_c6_s3_3m - 0.0257084742), _9d_11_c499_b1_1);

_pv_4_c513 := if(pk_segment_40 = '3 Other', 25.02124434 * (pk_add1_avm_auto_val_s3_3m - 0.0268399371), _pv_4_c499_b1_1);

_9q_9_c513 := if(pk_segment_40 = '3 Other', m_inquiry_mod_3m_c503 * 5.026470537 * (pk_inq_adlsperphone_s3_3m - 0.0246590642), _9q_9_c499_b1_1);

_9u_3_c513 := if(pk_segment_40 = '3 Other', 10.028036081 * (pk_addprob_s3_3m - 0.0284013395), _9u_3_c499_b1_1);

_9r_9_c513 := if(pk_segment_40 = '3 Other', m_email_mod_3m_c503 * 31.051485866 * (pk_em_domain_free_count_s3_3m - 0.0264255452), _9r_9_c499_b1_1);

_9a_7_c513 := if(pk_segment_40 = '3 Other', (seg_s3_c513_b1 - -4.248466382), _9a_7_c499_b1_1);

_9q_7_c513 := if(pk_segment_40 = '3 Other', m_inquiry_mod_3m_c503 * 7.3435047646 * (pk_inq_recent_lvl_s3_3m - 0.0246590642), _9q_7_c499_b1_1);

_9d_13_c513 := if(pk_segment_40 = '3 Other', 10.250404543 * (pk_addrs_5yr_s3_3m - 0.0321017432), _9d_13_c499_b1_1);

_x11_13_c513 := if(pk_segment_40 = '3 Other', m_velo_mod_3m_c503 * 20.663453736 * (pk_ssns_per_addr_c6_s3_3m - 0.0223274821), _x11_13_c499_b1_1);

_9r_11_c513 := if(pk_segment_40 = '3 Other', 11.303700779 * (pk_mth_gong_did_fst_sn2_s3_3m - 0.0246165008), _9r_11_c499_b1_1);

_9s_5_c513 := if(pk_segment_40 = '3 Other', m_financing_mod_3m_c503 * 0.6638882749 * (pk_2nd_mortgage - 0), _9s_5_c499_b1_1);

_9c_1_c513 := if(pk_segment_40 = '3 Other', 2.710798666 * (pk_mth_add1_date_fst_sn2_s3_3m - 0.0270079019), _9c_1_c499_b1_1);

_9d_12_c513 := if(pk_segment_40 = '3 Other', m_velo_mod_3m_c503 * 22.92767413 * (pk_attr_addrs_last36_s3_3m - 0.0337372362), _9d_12_c499_b1_1);

_9a_6_c513 := if(pk_segment_40 = '3 Other', m_prop_owner_mod_3m_c503 * 45.975872588 * (pk_ver_src_p_3m - 0.0307300509), _9a_6_c499_b1_1);

_9m_4_c513 := if(pk_segment_40 = '3 Other', 9.9328006071 * (pk_estimated_income_s3_3m - 0.0213391108), _9m_4_c499_b1_1);

_x11_12_c513 := if(pk_segment_40 = '3 Other', m_velo_mod_3m_c503 * 21.241190975 * (pk_phones_per_adl_c6_s3_3m - 0.0290419517), _x11_12_c499_b1_1);

_28_3_c513 := if(pk_segment_40 = '3 Other', 10.879814814 * (pk_dob_ver_3m - 0.0234464902), _28_3_c499_b1_1);

// _36_3_c513 := if(pk_segment_40 in ['X 200  ','2 Owner'], NULL, if(pk_segment_40 = '3 Other', 8.3122146315 * (pk_verx_s3_3m - 0.0291564173), _36_3_c499_b1_1));

_36_3_c513 := if(pk_segment_40 = '3 Other', 8.3122146315 * (pk_verx_s3_3m - 0.0291564173), _36_3_c499_b1_1);

_x11_16_c513 := if(pk_segment_40 = '3 Other', m_velo_mod_3m_c503 * 22.097757033 * (pk_adls_per_phone_3m - 0.0207262387), _x11_16_c499_b1_1);

_9r_10_c513 := if(pk_segment_40 = '3 Other', 17.317516468 * (pk_contrary_infutor_ver_3m - 0.0247989169), _9r_10_c499_b1_1);

_9s_6_c513 := if(pk_segment_40 = '3 Other', m_financing_mod_3m_c503 * 0.2750406154 * (pk_adj_finance - 0), _9s_6_c499_b1_1);

_mi_2_c513 := if(pk_segment_40 = '3 Other', m_velo_mod_3m_c503 * 33.710646116 * (pk_adlperssn_count_s3_3m - 0.0255366098), _mi_2_c499_b1_1);

_25_2_c513 := if(pk_segment_40 = '3 Other', 10.471164629 * (pk_add1_house_number_match_3m - 0.0242905395), _25_2_c499_b1_1);

// _36_c499_b1_1 := glrc36 * if(max(_36_0_c499_b1, _36_1_c504, _36_2_c510, _36_3_c513) = NULL, NULL, sum(if(_36_0_c499_b1 = NULL, 0, _36_0_c499_b1), if(_36_1_c504 = NULL, 0, _36_1_c504), if(_36_2_c510 = NULL, 0, _36_2_c510), if(_36_3_c513 = NULL, 0, _36_3_c513)));
_36_c499_b1_1 := glrc36 * if(max(_36_0_c499_b1, _36_1_c504, _36_2_c510, _36_3_c513) = NULL, NULL, sum(if(_36_0_c499_b1 = NULL, 0, _36_0_c499_b1), if(_36_1_c504 = NULL, 0, _36_1_c504), if(_36_2_c510 = NULL, 0, _36_2_c510), if(_36_3_c513 = NULL, 0, _36_3_c513)));

// _36_c514 := if(rvb1104 < 900 and _36_c499_b1_1 <> NULL, _36_c499_b1_1 + 0.0005, _36_c499_b1_1);

_36_c514 := if(rvb1104 < 900, _36_c499_b1_1 + 0.0005, _36_c499_b1_1);

_9e_c499_b1_1 := glrc9e * if(max(_9e_0_c499_b1, _9e_1_c504, _9e_2_c510) = NULL, NULL, sum(if(_9e_0_c499_b1 = NULL, 0, _9e_0_c499_b1), if(_9e_1_c504 = NULL, 0, _9e_1_c504), if(_9e_2_c510 = NULL, 0, _9e_2_c510)));

_9r_c499_b1_1 := glrc9r * if(max(_9r_0_c499_b1, _9r_1_c504, _9r_2_c510, _9r_3_c510, _9r_4_c510, _9r_5_c510, _9r_6_c512, _9r_7_c512, _9r_8_c512, _9r_9_c513, _9r_10_c513, _9r_11_c513) = NULL, NULL, sum(if(_9r_0_c499_b1 = NULL, 0, _9r_0_c499_b1), if(_9r_1_c504 = NULL, 0, _9r_1_c504), if(_9r_2_c510 = NULL, 0, _9r_2_c510), if(_9r_3_c510 = NULL, 0, _9r_3_c510), if(_9r_4_c510 = NULL, 0, _9r_4_c510), if(_9r_5_c510 = NULL, 0, _9r_5_c510), if(_9r_6_c512 = NULL, 0, _9r_6_c512), if(_9r_7_c512 = NULL, 0, _9r_7_c512), if(_9r_8_c512 = NULL, 0, _9r_8_c512), if(_9r_9_c513 = NULL, 0, _9r_9_c513), if(_9r_10_c513 = NULL, 0, _9r_10_c513), if(_9r_11_c513 = NULL, 0, _9r_11_c513)));

_9j_1_c499_b1 := 0.0004;

_9f_1_c499_b1 := 0.0002;

m_financing_mod_0m_c515 := if(pk_segment_40 = '0 Derog', 1.1276870584, NULL);

m_inquiry_mod_0m_c515 := if(pk_segment_40 = '0 Derog', 0.5488230536, NULL);

m_prop_owner_mod_0m_c515 := if(pk_segment_40 = '0 Derog', 0.1608301108, NULL);

m_derog_mod_0m_c515 := if(pk_segment_40 = '0 Derog', 0.5825820701, NULL);

m_velo_mod_0m_c515 := if(pk_segment_40 = '0 Derog', 0.3973008626, NULL);

m_inquiry_mod_1m_c516 := if(pk_segment_40 = '1 Young', 0.6312569184, NULL);

m_velo_mod_1m_c516 := if(pk_segment_40 = '1 Young', 0.579112048, NULL);

m_email_mod_1m_c516 := if(pk_segment_40 = '1 Young', 1.0724514608, NULL);

m_prop_owner_mod_1m_c516 := if(pk_segment_40 = '1 Young', 0.4240204337, NULL);

m_velo_mod_2m_c517 := if(pk_segment_40 = '2 Owner', 0.6438452239, NULL);

m_financing_mod_2m_c517 := if(pk_segment_40 = '2 Owner', 0.9179262519, NULL);

m_email_mod_2m_c517 := if(pk_segment_40 = '2 Owner', 0.4537693766, NULL);

m_inquiry_mod_2m_c517 := if(pk_segment_40 = '2 Owner', 0.7562229974, NULL);

m_prop_owner_mod_3m_c518 := if(pk_segment_40 = '3 Other', 0.5880225978, NULL);

m_email_mod_3m_c518 := if(pk_segment_40 = '3 Other', 0.7036102492, NULL);

m_velo_mod_3m_c518 := if(pk_segment_40 = '3 Other', 0.6229300386, NULL);

m_inquiry_mod_3m_c518 := if(pk_segment_40 = '3 Other', 0.7079660055, NULL);

m_financing_mod_3m_c518 := if(pk_segment_40 = '3 Other', 0.7844396783, NULL);

_25_0_c499_b2 := 0;

_25_1_c499_b2_1 := 0;

_25_2_c499_b2_1 := 0;

_28_0_c499_b2 := 0;

_36_0_c499_b2 := 0;

_36_1_c499_b2_1 := 0;

_36_2_c499_b2_1 := 0;

_36_3_c499_b2_1 := 0;

_97_0_c499_b2_1 := 0;

_97_1_c499_b2_1 := 0;

_98_0_c499_b2_1 := 0;

_98_1_c499_b2_1 := 0;

_99_0_c499_b2 := 0;

_99_1_c499_b2_1 := 0;

_9a_0_c499_b2 := 0;

_9a_1_c499_b2_1 := 0;

_9a_2_c499_b2_1 := 0;

_9a_3_c499_b2_1 := 0;

_9a_4_c499_b2_1 := 0;

_9a_5_c499_b2_1 := 0;

_9a_6_c499_b2_1 := 0;

_9a_7_c499_b2_1 := 0;

_9c_0_c499_b2 := 0;

_9d_0_c499_b2 := 0;

_9d_1_c499_b2_1 := 0;

_9d_2_c499_b2_1 := 0;

_9d_3_c499_b2_1 := 0;

_9d_4_c499_b2_1 := 0;

_9d_5_c499_b2_1 := 0;

_9d_6_c499_b2_1 := 0;

_9d_7_c499_b2_1 := 0;

_9d_8_c499_b2_1 := 0;

_9d_9_c499_b2_1 := 0;

_9d_10_c499_b2_1 := 0;

_9d_11_c499_b2_1 := 0;

_9d_12_c499_b2_1 := 0;

_9d_13_c499_b2_1 := 0;

_9e_0_c499_b2 := 0;

_9e_1_c499_b2_1 := 0;

_9e_2_c499_b2_1 := 0;

_9g_0_c499_b2 := 0;

_9g_1_c499_b2_1 := 0;

_9g_2_c499_b2_1 := 0;

_9g_3_c499_b2_1 := 0;

_9g_4_c499_b2_1 := 0;

_9g_5_c499_b2_1 := 0;

_9h_0_c499_b2_1 := 0;

_9h_1_c499_b2_1 := 0;

_9m_0_c499_b2 := 0;

_9m_1_c499_b2_1 := 0;

_9m_2_c499_b2_1 := 0;

_9m_3_c499_b2_1 := 0;

_9m_4_c499_b2_1 := 0;

_9n_0_c499_b2 := 0;

_9n_1_c499_b2_1 := 0;

_9q_0_c499_b2 := 0;

_9q_1_c499_b2_1 := 0;

_9q_2_c499_b2_1 := 0;

_9q_3_c499_b2_1 := 0;

_9q_4_c499_b2_1 := 0;

_9q_5_c499_b2_1 := 0;

_9q_6_c499_b2_1 := 0;

_9q_7_c499_b2_1 := 0;

_9q_8_c499_b2_1 := 0;

_9q_9_c499_b2_1 := 0;

_9r_0_c499_b2 := 0;

_9r_1_c499_b2_1 := 0;

_9r_2_c499_b2_1 := 0;

_9r_3_c499_b2_1 := 0;

_9r_4_c499_b2_1 := 0;

_9r_5_c499_b2_1 := 0;

_9r_6_c499_b2_1 := 0;

_9r_7_c499_b2_1 := 0;

_9r_8_c499_b2_1 := 0;

_9r_9_c499_b2_1 := 0;

_9r_10_c499_b2_1 := 0;

_9s_0_c499_b2 := 0;

_9s_1_c499_b2_1 := 0;

_9s_2_c499_b2_1 := 0;

_9s_3_c499_b2_1 := 0;

_9s_4_c499_b2_1 := 0;

_9s_5_c499_b2_1 := 0;

_9s_6_c499_b2_1 := 0;

_9t_0_c499_b2 := 0;

_9t_1_c499_b2_1 := 0;

_9u_0_c499_b2 := 0;

_9u_1_c499_b2_1 := 0;

_9u_2_c499_b2_1 := 0;

_9u_3_c499_b2_1 := 0;

_9w_0_c499_b2_1 := 0;

_9w_1_c499_b2_1 := 0;

_9w_2_c499_b2 := 0;

_ev_0_c499_b2_1 := 0;

_ev_1_c499_b2_1 := 0;

_mi_0_c499_b2 := 0;

_mi_1_c499_b2_1 := 0;

_mi_2_c499_b2_1 := 0;

_mi_3_c499_b2_1 := 0;

_ms_0_c499_b2 := 0;

_ms_1_c499_b2_1 := 0;

_ms_2_c499_b2_1 := 0;

_ms_3_c499_b2_1 := 0;

_ms_4_c499_b2_1 := 0;

_ms_5_c499_b2_1 := 0;

_ms_6_c499_b2_1 := 0;

_ms_7_c499_b2_1 := 0;

_pv_0_c499_b2 := 0;

_pv_1_c499_b2_1 := 0;

_pv_2_c499_b2_1 := 0;

_pv_3_c499_b2_1 := 0;

_pv_4_c499_b2_1 := 0;

_x11_0_c499_b2 := 0;

_x11_1_c499_b2_1 := 0;

_x11_2_c499_b2_1 := 0;

_x11_3_c499_b2_1 := 0;

_x11_4_c499_b2_1 := 0;

_x11_5_c499_b2_1 := 0;

_x11_6_c499_b2_1 := 0;

_x11_7_c499_b2_1 := 0;

_x11_8_c499_b2_1 := 0;

_x11_9_c499_b2_1 := 0;

_x11_10_c499_b2_1 := 0;

_x11_11_c499_b2_1 := 0;

_x11_12_c499_b2_1 := 0;

_x11_13_c499_b2_1 := 0;

_x11_14_c499_b2_1 := 0;

_x11_15_c499_b2_1 := 0;

_x11_16_c499_b2_1 := 0;

_9j_0_c499_b2 := 0;

_9j_1_c499_b2_1 := 0;

_9f_0_c499_b2 := 0;

_9f_1_c499_b2_1 := 0;

seg_s0_crime_c520_b1 := -2.81454014268427;

_97_0_c520 := if(bs_attr_derog_flag > 0 and criminal_count > 0, (seg_s0_crime_c520_b1 - -4.248466382), NULL);

seg_s0_lien_c521_b1 := -2.81454014268427;

_98_0_c521 := if((integer)lien_flag > 0, (seg_s0_lien_c521_b1 - -4.248466382), NULL);

seg_s0_eviction_c522_b1 := -2.81454014268427;

_ev_0_c522 := if(bs_attr_eviction_flag > 0, (seg_s0_eviction_c522_b1 - -4.248466382), NULL);

seg_s0_impulse_c523_b1 := -2.81454014268427;

_9h_0_c523 := if(pk_impulse_count > 0, (seg_s0_impulse_c523_b1 - -4.248466382), NULL);

seg_s0_bk_c524_b1 := -2.81454014268427;

_9w_0_c524 := if((integer)bk_flag > 0, (seg_s0_bk_c524_b1 - -4.248466382), NULL);

_9d_3_c519 := if(pk_segment_40 = '0 Derog', m_velo_mod_0m_c515 * 5.8444054 * (pk_recent_addr_s0_0m - 0.0507715281), _9d_3_c499_b2_1);

_9q_1_c519 := if(pk_segment_40 = '0 Derog', m_inquiry_mod_0m_c515 * 3.990328493 * (pk_inq_recent_lvl_s0_0m - 0.0510322723), _9q_1_c499_b2_1);

_ev_1_c519 := if(pk_segment_40 = '0 Derog', m_derog_mod_0m_c515 * 7.3700576551 * (pk_eviction_lvl_0m - 0.0536455151), _ev_1_c499_b2_1);

_x11_3_c519 := if(pk_segment_40 = '0 Derog', m_velo_mod_0m_c515 * 6.3078515686 * (pk_ssns_per_addr_0m - 0.0544585462), _x11_3_c499_b2_1);

_9h_1_c519 := if(pk_segment_40 = '0 Derog', m_derog_mod_0m_c515 * 2.4931427584 * (pk_impulse_flag - 0), _9h_1_c499_b2_1);

_9w_1_c519 := if(pk_segment_40 = '0 Derog', m_derog_mod_0m_c515 * 16.011084801 * (bankrupt_0m - 0.055950981), _9w_1_c499_b2_1);

_x11_2_c519 := if(pk_segment_40 = '0 Derog', m_velo_mod_0m_c515 * 18.807703437 * (pk_phones_per_adl_s0_0m - 0.0667526604), _x11_2_c499_b2_1);

_9g_1_c519 := if(pk_segment_40 = '0 Derog', 2.9990337154 * (pk_age_estimate_s0_0m - 0.0535984276), _9g_1_c499_b2_1);

_9s_1_c519 := if(pk_segment_40 = '0 Derog', m_financing_mod_0m_c515 * 1.209994132 * (pk_baloon_mortgage - 0), _9s_1_c499_b2_1);

// _36_1_c519 := if(pk_segment_40 in ['X 200  ','2 Owner'], NULL,if(pk_segment_40 = '0 Derog', 4.8772596717 * (pk_verx_s0_0m - 0.0593320236), _36_1_c499_b2_1));

_36_1_c519 := if(pk_segment_40 = '0 Derog', 4.8772596717 * (pk_verx_s0_0m - 0.0593320236), _36_1_c499_b2_1);

_ms_1_c519 := if(pk_segment_40 = '0 Derog', m_velo_mod_0m_c515 * 5.5370768191 * (pk_ssns_per_adl_c6_0m - 0.0496577474), _ms_1_c499_b2_1);

_9a_1_c519 := if(pk_segment_40 = '0 Derog', m_prop_owner_mod_0m_c515 * 12.516565479 * (pk_ver_src_p_0m - 0.0386540352), _9a_1_c499_b2_1);

_9w_0_c519 := if(pk_segment_40 = '0 Derog', _9w_0_c524, _9w_0_c499_b2_1);

_x11_4_c519 := if(pk_segment_40 = '0 Derog', m_velo_mod_0m_c515 * 11.589909799 * (pk_phones_per_addr_s0_0m - 0.0581807725), _x11_4_c499_b2_1);

_9e_1_c519 := if(pk_segment_40 = '0 Derog', 2.8365945639 * (pk_num_nonderogs90_s0_0m - 0.0492027702), _9e_1_c499_b2_1);

_98_0_c519 := if(pk_segment_40 = '0 Derog', _98_0_c521, _98_0_c499_b2_1);

_97_1_c519 := if(pk_segment_40 = '0 Derog', m_derog_mod_0m_c515 * 13.143708695 * (pk_crim_fel_flag_0m - 0.0547007453), _97_1_c499_b2_1);

_9m_1_c519 := if(pk_segment_40 = '0 Derog', 2.9053537317 * (pk_estimated_income_s0_0m - 0.0389371862), _9m_1_c499_b2_1);

_ms_2_c519 := if(pk_segment_40 = '0 Derog', 12.283213577 * (ssn_adl_prob_0m - 0.0549828179), _ms_2_c499_b2_1);

_9q_3_c519 := if(pk_segment_40 = '0 Derog', m_inquiry_mod_0m_c515 * 4.0228807529 * (pk_inq_adlsperphone_s0_0m - 0.0510322723), _9q_3_c499_b2_1);

_98_1_c519 := if(pk_segment_40 = '0 Derog', m_derog_mod_0m_c515 * 8.9466402638 * (pk_unrel_lien_lvl_0m - 0.0524842018), _98_1_c499_b2_1);

_ev_0_c519 := if(pk_segment_40 = '0 Derog', _ev_0_c522, _ev_0_c499_b2_1);

_9q_2_c519 := if(pk_segment_40 = '0 Derog', m_inquiry_mod_0m_c515 * 2.0027290764 * (pk_inq_peradl_s0_0m - 0.0510322723), _9q_2_c499_b2_1);

_9h_0_c519 := if(pk_segment_40 = '0 Derog', _9h_0_c523, _9h_0_c499_b2_1);

_9d_2_c519 := if(pk_segment_40 = '0 Derog', m_velo_mod_0m_c515 * 5.4544984232 * (pk_attr_addrs_last24_s0_0m - 0.0447368421), _9d_2_c499_b2_1);

_9d_1_c519 := if(pk_segment_40 = '0 Derog', m_velo_mod_0m_c515 * 10.870842239 * (pk_addrs_per_ssn_c6_s0_0m - 0.052182623), _9d_1_c499_b2_1);

_9d_4_c519 := if(pk_segment_40 = '0 Derog', 5.5050099401 * (pk_addrs_5yr_s0_0m - 0.0616986301), _9d_4_c499_b2_1);

_9n_1_c519 := if(pk_segment_40 = '0 Derog', 1.32874535 * (pk_addrs_prison_history - 0), _9n_1_c499_b2_1);

_9a_3_c519 := if(pk_segment_40 = '0 Derog', m_prop_owner_mod_0m_c515 * 8.2491242885 * (pk_add1_naprop4_0m - 0.0363378114), _9a_3_c499_b2_1);

_9r_1_c519 := if(pk_segment_40 = '0 Derog', 3.521698492 * (pk_mth_gong_did_fst_sn2_s0_0m - 0.0472106878), _9r_1_c499_b2_1);

_pv_1_c519 := if(pk_segment_40 = '0 Derog', 7.9015940165 * (pk_add1_avm_auto_val_s0_0m - 0.0598949212), _pv_1_c499_b2_1);

_97_0_c519 := if(pk_segment_40 = '0 Derog', _97_0_c520, _97_0_c499_b2_1);

_x11_1_c519 := if(pk_segment_40 = '0 Derog', m_velo_mod_0m_c515 * 8.222562725 * (pk_ssns_per_addr_c6_s0_0m - 0.0479833951), _x11_1_c499_b2_1);

_9a_2_c519 := if(pk_segment_40 = '0 Derog', m_prop_owner_mod_0m_c515 * 5.7187605132 * (pk_prop_owned_purch_flag_0m - 0.063502861), _9a_2_c499_b2_1);

seg_s1_c525_b1 := -2.34017557597253;

_x11_5_c525 := if(pk_segment_40 = '1 Young', m_velo_mod_1m_c516 * 9.5011342145 * (pk_ssns_per_addr_c6_s1_1m - 0.0677562778), _x11_5_c499_b2_1);

_x11_6_c525 := if(pk_segment_40 = '1 Young', m_velo_mod_1m_c516 * 9.112129103 * (pk_phones_per_addr_c6_1m - 0.0840170509), _x11_6_c499_b2_1);

_9q_4_c525 := if(pk_segment_40 = '1 Young', m_inquiry_mod_1m_c516 * 4.7485458561 * (pk_inq_recent_lvl_s1_1m - 0.076869551), _9q_4_c499_b2_1);

_9g_2_c525 := if(pk_segment_40 = '1 Young', (seg_s1_c525_b1 - -4.248466382), _9g_2_c499_b2_1);

_9r_4_c525 := if(pk_segment_40 = '1 Young', 3.8447802442 * (pk_time_since_cb3_1m - 0.0870101244), _9r_4_c499_b2_1);

_9e_2_c525 := if(pk_segment_40 = '1 Young', 9.0980023527 * (pk_nap_summary_ver_s1_1m - 0.0933044932), _9e_2_c499_b2_1);

_ms_4_c525 := if(pk_segment_40 = '1 Young', m_velo_mod_1m_c516 * 3.0964475191 * (pk_ssns_per_adl_c6_1m - 0.0746622422), _ms_4_c499_b2_1);

_9r_3_c525 := if(pk_segment_40 = '1 Young', 8.6557765439 * (pk_mth_gong_did_fst_sn2_s1_1m - 0.0873078961), _9r_3_c499_b2_1);

_pv_2_c525 := if(pk_segment_40 = '1 Young', 8.9942707659 * (pk_add1_avm_auto_val_s1_1m - 0.0956815016), _pv_2_c499_b2_1);

_9a_4_c525 := if(pk_segment_40 = '1 Young', m_prop_owner_mod_1m_c516 * 11.50422511 * (pk_ver_src_p_1m - 0.0907238734), _9a_4_c499_b2_1);

_9d_6_c525 := if(pk_segment_40 = '1 Young', m_velo_mod_1m_c516 * 7.8795300804 * (pk_attr_addrs_last12_s1_1m - 0.0725928619), _9d_6_c499_b2_1);

// _36_2_c525 := if(pk_segment_40 in ['X 200  ','2 Owner'], NULL,if(pk_segment_40 = '1 Young', 4.3447325497 * (pk_verx_s1_1m - 0.0839347934), _36_2_c499_b2_1));

_36_2_c525 := if(pk_segment_40 = '1 Young', 4.3447325497 * (pk_verx_s1_1m - 0.0839347934), _36_2_c499_b2_1);

_9q_5_c525 := if(pk_segment_40 = '1 Young', m_inquiry_mod_1m_c516 * 3.7210059561 * (pk_inq_peraddr_1m - 0.076869551), _9q_5_c499_b2_1);

_9g_3_c525 := if(pk_segment_40 = '1 Young', 7.5438290771 * (pk_age_estimate_s1_1m - 0.0736484722), _9g_3_c499_b2_1);

_9a_5_c525 := if(pk_segment_40 = '1 Young', m_prop_owner_mod_1m_c516 * 8.6236762719 * (pk_add1_naprop4_1m - 0.090376569), _9a_5_c499_b2_1);

_mi_1_c525 := if(pk_segment_40 = '1 Young', m_velo_mod_1m_c516 * 11.80976186 * (pk_adlperssn_count_s1_1m - 0.0847328244), _mi_1_c499_b2_1);

_9u_1_c525 := if(pk_segment_40 = '1 Young', 6.6590588025 * (pk_addprob_s1_1m - 0.0879845402), _9u_1_c499_b2_1);

_9r_2_c525 := if(pk_segment_40 = '1 Young', m_email_mod_1m_c516 * 11.248723668 * (pk_email_count_s1_1m - 0.0876497315), _9r_2_c499_b2_1);

_9d_5_c525 := if(pk_segment_40 = '1 Young', m_velo_mod_1m_c516 * 10.091573956 * (pk_addrs_per_ssn_c6_s1_1m - 0.0826655052), _9d_5_c499_b2_1);

_mi_2_c525 := if(pk_segment_40 = '1 Young', 7.7832928559 * (pk_adlperssn_count_s1_1m - 0.0847328244), _mi_2_c499_b2_1);

_ms_3_c525 := if(pk_segment_40 = '1 Young', m_velo_mod_1m_c516 * 11.065233911 * (pk_ssns_per_adl_s1_1m - 0.086062889), _ms_3_c499_b2_1);

_9m_2_c525 := if(pk_segment_40 = '1 Young', 3.0795096918 * (pk_estimated_income_s1_1m - 0.0834858188), _9m_2_c499_b2_1);

_9m_3_c526 := if(pk_segment_40 = '2 Owner', 43.827944495 * (pk_estimated_income_s2_2m - 0.0145617705), _9m_3_c499_b2_1);

_9r_5_c526 := if(pk_segment_40 = '2 Owner', m_email_mod_2m_c517 * 51.001538056 * (pk_em_domain_free_count_s2_2m - 0.0137043715), _9r_5_c499_b2_1);

_9g_4_c526 := if(pk_segment_40 = '2 Owner', 30.311783204 * (pk_age_estimate_s2_2m - 0.014131362), _9g_4_c499_b2_1);

_pv_3_c526 := if(pk_segment_40 = '2 Owner', 41.98475476 * (pk_add1_avm_auto_val_s2_2m - 0.0148375451), _pv_3_c499_b2_1);

_ms_5_c526 := if(pk_segment_40 = '2 Owner', m_velo_mod_2m_c517 * 50.665296275 * (pk_ssns_per_adl_s2_2m - 0.0131222201), _ms_5_c499_b2_1);

_9d_7_c526 := if(pk_segment_40 = '2 Owner', m_velo_mod_2m_c517 * 37.436601044 * (pk_addrs_per_ssn_c6_s2_2m - 0.0133419076), _9d_7_c499_b2_1);

_9j_1_c526 := if(pk_segment_40 = '2 Owner', 8.7948373806 * (pk_mth_hdr_frst_sn_s2_2m - 0.0099346299), _9j_1_c499_b2_1);

_9q_6_c526 := if(pk_segment_40 = '2 Owner', m_inquiry_mod_2m_c517 * 32.623012423 * (pk_mth_inq_frst_log_dt2_s2_2m - 0.0137038529), _9q_6_c499_b2_1);

_x11_8_c526 := if(pk_segment_40 = '2 Owner', m_velo_mod_2m_c517 * -30.29448194 * (pk_adls_per_phone_c6_2m - 0.0111842197), _x11_8_c499_b2_1);

_9u_2_c526 := if(pk_segment_40 = '2 Owner', 21.194302356 * (pk_addprob_s2_2m - 0.0140507795), _9u_2_c499_b2_1);

_9s_2_c526 := if(pk_segment_40 = '2 Owner', m_financing_mod_2m_c517 * 0.7259505049 * (pk_2nd_mortgage - 0), _9s_2_c499_b2_1);

_25_1_c526 := if(pk_segment_40 = '2 Owner', 27.934356076 * (pk_add1_house_number_match_2m - 0.0132671939), _25_1_c499_b2_1);

_x11_9_c526 := if(pk_segment_40 = '2 Owner', m_velo_mod_2m_c517 * 30.311887525 * (pk_ssns_per_addr_2m - 0.0134892288), _x11_9_c499_b2_1);

_9d_8_c526 := if(pk_segment_40 = '2 Owner', m_velo_mod_2m_c517 * 24.47530058 * (pk_attr_addrs_last36_s2_2m - 0.0100559976), _9d_8_c499_b2_1);

_9r_6_c526 := if(pk_segment_40 = '2 Owner', 18.388436107 * (pk_contrary_infutor_ver_2m - 0.0133991912), _9r_6_c499_b2_1);

_x11_7_c526 := if(pk_segment_40 = '2 Owner', m_velo_mod_2m_c517 * 25.607924542 * (pk_adls_per_addr_c6_s2_2m - 0.0119689787), _x11_7_c499_b2_1);

_9d_9_c526 := if(pk_segment_40 = '2 Owner', m_velo_mod_2m_c517 * 21.510962018 * (pk_recent_addr_s2_2m - 0.0100559976), _9d_9_c499_b2_1);

_99_1_c526 := if(pk_segment_40 = '2 Owner', 0.1530566986 * ((integer)rc_input_addr_not_most_recent - 0), _99_1_c499_b2_1);

_9s_4_c526 := if(pk_segment_40 = '2 Owner', m_financing_mod_2m_c517 * 0.351346294 * (pk_adj_finance - 0), _9s_4_c499_b2_1);

_x11_11_c526 := if(pk_segment_40 = '2 Owner', m_velo_mod_2m_c517 * 63.388740934 * (pk_adls_per_phone_2m - 0.0107968018), _x11_11_c499_b2_1);

_9r_7_c526 := if(pk_segment_40 = '2 Owner', 22.992018739 * (pk_mth_gong_did_fst_sn2_s2_2m - 0.0143733489), _9r_7_c499_b2_1);

_9s_3_c526 := if(pk_segment_40 = '2 Owner', m_financing_mod_2m_c517 * 1.1630288186 * (pk_baloon_mortgage - 0), _9s_3_c499_b2_1);

_x11_10_c526 := if(pk_segment_40 = '2 Owner', m_velo_mod_2m_c517 * 20.370965388 * (pk_phones_per_addr_s2_2m - 0.011890263), _x11_10_c499_b2_1);

_9t_1_c526 := if(pk_segment_40 = '2 Owner', 13.341843655 * (pk_phnprob_s2_2m - 0.0110535714), _9t_1_c499_b2_1);

_9d_10_c526 := if(pk_segment_40 = '2 Owner', 8.4166631522 * (pk_addrs_5yr_s2_2m - 0.013676897), _9d_10_c499_b2_1);

seg_s3_c527_b1 := -3.58414938616816;

_ms_6_c527 := if(pk_segment_40 = '3 Other', m_velo_mod_3m_c518 * 29.594364353 * (pk_ssns_per_adl_s3_3m - 0.0260587993), _ms_6_c499_b2_1);

_9q_8_c527 := if(pk_segment_40 = '3 Other', m_inquiry_mod_3m_c518 * 5.9686575266 * (pk_inq_peraddr_3m - 0.0246590642), _9q_8_c499_b2_1);

_x11_14_c527 := if(pk_segment_40 = '3 Other', m_velo_mod_3m_c518 * 23.940623893 * (pk_phones_per_addr_c6_3m - 0.024502514), _x11_14_c499_b2_1);

_x11_15_c527 := if(pk_segment_40 = '3 Other', m_velo_mod_3m_c518 * 13.213015025 * (pk_phones_per_addr_s3_3m - 0.0298539519), _x11_15_c499_b2_1);

_mi_3_c527 := if(pk_segment_40 = '3 Other', m_velo_mod_3m_c518 * 33.710646116 * (pk_adlperssn_count_s3_3m - 0.0255366098), _mi_3_c499_b2_1);

_9d_11_c527 := if(pk_segment_40 = '3 Other', m_velo_mod_3m_c518 * 18.805570748 * (pk_addrs_per_ssn_c6_s3_3m - 0.0257084742), _9d_11_c499_b2_1);

_pv_4_c527 := if(pk_segment_40 = '3 Other', 26.986478198 * (pk_add1_avm_auto_val_s3_3m - 0.0268399371), _pv_4_c499_b2_1);

_9q_9_c527 := if(pk_segment_40 = '3 Other', m_inquiry_mod_3m_c518 * 5.026470537 * (pk_inq_adlsperphone_s3_3m - 0.0246590642), _9q_9_c499_b2_1);

_9u_3_c527 := if(pk_segment_40 = '3 Other', 8.3556593541 * (pk_addprob_s3_3m - 0.0284013395), _9u_3_c499_b2_1);

_9a_7_c527 := if(pk_segment_40 = '3 Other', (seg_s3_c527_b1 - -4.248466382), _9a_7_c499_b2_1);

_9r_9_c527 := if(pk_segment_40 = '3 Other', 16.419477069 * (pk_contrary_infutor_ver_3m - 0.0247989169), _9r_9_c499_b2_1);

_9q_7_c527 := if(pk_segment_40 = '3 Other', m_inquiry_mod_3m_c518 * 7.3435047646 * (pk_inq_recent_lvl_s3_3m - 0.0246590642), _9q_7_c499_b2_1);

_9d_13_c527 := if(pk_segment_40 = '3 Other', 8.586665481 * (pk_addrs_5yr_s3_3m - 0.0321017432), _9d_13_c499_b2_1);

_x11_13_c527 := if(pk_segment_40 = '3 Other', m_velo_mod_3m_c518 * 20.663453736 * (pk_ssns_per_addr_c6_s3_3m - 0.0223274821), _x11_13_c499_b2_1);

_ms_7_c527 := if(pk_segment_40 = '3 Other', 17.347371803 * (pk_ssns_per_adl_s3_3m - 0.0260587993), _ms_7_c499_b2_1);

_9s_5_c527 := if(pk_segment_40 = '3 Other', m_financing_mod_3m_c518 * 0.6638882749 * (pk_2nd_mortgage - 0), _9s_5_c499_b2_1);

_9g_5_c527 := if(pk_segment_40 = '3 Other', 15.887767473 * (pk_age_estimate_s3_3m - 0.030909973), _9g_5_c499_b2_1);

_9d_12_c527 := if(pk_segment_40 = '3 Other', m_velo_mod_3m_c518 * 22.92767413 * (pk_attr_addrs_last36_s3_3m - 0.0337372362), _9d_12_c499_b2_1);

_9a_6_c527 := if(pk_segment_40 = '3 Other', m_prop_owner_mod_3m_c518 * 45.975872588 * (pk_ver_src_p_3m - 0.0307300509), _9a_6_c499_b2_1);

_9m_4_c527 := if(pk_segment_40 = '3 Other', 7.015814043 * (pk_estimated_income_s3_3m - 0.0213391108), _9m_4_c499_b2_1);

_x11_12_c527 := if(pk_segment_40 = '3 Other', m_velo_mod_3m_c518 * 21.241190975 * (pk_phones_per_adl_c6_s3_3m - 0.0290419517), _x11_12_c499_b2_1);

// _36_3_c527 := if(pk_segment_40 in ['X 200  ','2 Owner'], NULL,if(pk_segment_40 = '3 Other', 9.2776087205 * (pk_verx_s3_3m - 0.0291564173), _36_3_c499_b2_1));

_36_3_c527 := if(pk_segment_40 = '3 Other', 9.2776087205 * (pk_verx_s3_3m - 0.0291564173), _36_3_c499_b2_1);

_x11_16_c527 := if(pk_segment_40 = '3 Other', m_velo_mod_3m_c518 * 22.097757033 * (pk_adls_per_phone_3m - 0.0207262387), _x11_16_c499_b2_1);

_9r_10_c527 := if(pk_segment_40 = '3 Other', 10.797828779 * (pk_mth_gong_did_fst_sn2_s3_3m - 0.0246165008), _9r_10_c499_b2_1);

_9s_6_c527 := if(pk_segment_40 = '3 Other', m_financing_mod_3m_c518 * 0.2750406154 * (pk_adj_finance - 0), _9s_6_c499_b2_1);

_9r_8_c527 := if(pk_segment_40 = '3 Other', m_email_mod_3m_c518 * 31.051485866 * (pk_em_domain_free_count_s3_3m - 0.0264255452), _9r_8_c499_b2_1);

_25_2_c527 := if(pk_segment_40 = '3 Other', 12.439705792 * (pk_add1_house_number_match_3m - 0.0242905395), _25_2_c499_b2_1);

// _36_c499_b2_1 := if(pk_segment_40 in ['X 200  ','2 Owner'], NULL, glrc36 * if(max(_36_0_c499_b2, _36_1_c519, _36_2_c525, _36_3_c527) = NULL, NULL, sum(if(_36_0_c499_b2 = NULL, 0, _36_0_c499_b2), if(_36_1_c519 = NULL, 0, _36_1_c519), if(_36_2_c525 = NULL, 0, _36_2_c525), if(_36_3_c527 = NULL, 0, _36_3_c527))));

_36_c499_b2_1 := glrc36 * if(max(_36_0_c499_b2, _36_1_c519, _36_2_c525, _36_3_c527) = NULL, NULL, sum(if(_36_0_c499_b2 = NULL, 0, _36_0_c499_b2), if(_36_1_c519 = NULL, 0, _36_1_c519), if(_36_2_c525 = NULL, 0, _36_2_c525), if(_36_3_c527 = NULL, 0, _36_3_c527)));

// _36_c528 := if(rvb1104 < 900 and _36_c499_b2_1 <> NULL, _36_c499_b2_1 + 0.0005, _36_c499_b2_1);

_36_c528 := if(rvb1104 < 900,  _36_c499_b2_1 + 0.0005, _36_c499_b2_1);

_9e_c499_b2_1 := glrc9e * if(max(_9e_0_c499_b2, _9e_1_c519, _9e_2_c525) = NULL, NULL, sum(if(_9e_0_c499_b2 = NULL, 0, _9e_0_c499_b2), if(_9e_1_c519 = NULL, 0, _9e_1_c519), if(_9e_2_c525 = NULL, 0, _9e_2_c525)));

_9r_c499_b2_1 := glrc9r * if(max(_9r_0_c499_b2, _9r_1_c519, _9r_2_c525, _9r_3_c525, _9r_4_c525, _9r_5_c526, _9r_6_c526, _9r_7_c526, _9r_8_c527, _9r_9_c527, _9r_10_c527) = NULL, NULL, sum(if(_9r_0_c499_b2 = NULL, 0, _9r_0_c499_b2), if(_9r_1_c519 = NULL, 0, _9r_1_c519), if(_9r_2_c525 = NULL, 0, _9r_2_c525), if(_9r_3_c525 = NULL, 0, _9r_3_c525), if(_9r_4_c525 = NULL, 0, _9r_4_c525), if(_9r_5_c526 = NULL, 0, _9r_5_c526), if(_9r_6_c526 = NULL, 0, _9r_6_c526), if(_9r_7_c526 = NULL, 0, _9r_7_c526), if(_9r_8_c527 = NULL, 0, _9r_8_c527), if(_9r_9_c527 = NULL, 0, _9r_9_c527), if(_9r_10_c527 = NULL, 0, _9r_10_c527)));

_9j_c499_b2_1 := glrc9j * if(max(_9j_0_c499_b2, _9j_1_c526) = NULL, NULL, sum(if(_9j_0_c499_b2 = NULL, 0, _9j_0_c499_b2), if(_9j_1_c526 = NULL, 0, _9j_1_c526)));

_9f_1_c499_b2 := 0.0002;

_9h := if((integer)dobpop = 1, glrc9h * if(max(_9h_0_c504, _9h_1_c504) = NULL, NULL, sum(if(_9h_0_c504 = NULL, 0, _9h_0_c504), if(_9h_1_c504 = NULL, 0, _9h_1_c504))), glrc9h * if(max(_9h_0_c519, _9h_1_c519) = NULL, NULL, sum(if(_9h_0_c519 = NULL, 0, _9h_0_c519), if(_9h_1_c519 = NULL, 0, _9h_1_c519))));

_9c := if((integer)dobpop = 1, glrc9c * if(max(_9c_0_c499_b1, _9c_1_c513) = NULL, NULL, sum(if(_9c_0_c499_b1 = NULL, 0, _9c_0_c499_b1), if(_9c_1_c513 = NULL, 0, _9c_1_c513))), glrc9c * if(max(_9c_0_c499_b2) = NULL, NULL, sum(if(_9c_0_c499_b2 = NULL, 0, _9c_0_c499_b2))));

_mi := if((integer)dobpop = 1, glrcmi * if(max(_mi_0_c499_b1, _mi_1_c510, _mi_2_c513) = NULL, NULL, sum(if(_mi_0_c499_b1 = NULL, 0, _mi_0_c499_b1), if(_mi_1_c510 = NULL, 0, _mi_1_c510), if(_mi_2_c513 = NULL, 0, _mi_2_c513))), glrcmi * if(max(_mi_0_c499_b2, _mi_1_c525, _mi_2_c525, _mi_3_c527) = NULL, NULL, sum(if(_mi_0_c499_b2 = NULL, 0, _mi_0_c499_b2), if(_mi_1_c525 = NULL, 0, _mi_1_c525), if(_mi_2_c525 = NULL, 0, _mi_2_c525), if(_mi_3_c527 = NULL, 0, _mi_3_c527))));

_9u := if((integer)dobpop = 1, glrc9u * if(max(_9u_0_c499_b1, _9u_1_c510, _9u_2_c512, _9u_3_c513) = NULL, NULL, sum(if(_9u_0_c499_b1 = NULL, 0, _9u_0_c499_b1), if(_9u_1_c510 = NULL, 0, _9u_1_c510), if(_9u_2_c512 = NULL, 0, _9u_2_c512), if(_9u_3_c513 = NULL, 0, _9u_3_c513))), glrc9u * if(max(_9u_0_c499_b2, _9u_1_c525, _9u_2_c526, _9u_3_c527) = NULL, NULL, sum(if(_9u_0_c499_b2 = NULL, 0, _9u_0_c499_b2), if(_9u_1_c525 = NULL, 0, _9u_1_c525), if(_9u_2_c526 = NULL, 0, _9u_2_c526), if(_9u_3_c527 = NULL, 0, _9u_3_c527))));

_9j := if((integer)dobpop = 1, glrc9j * if(max(_9j_0_c499_b1, _9j_1_c499_b1) = NULL, NULL, sum(if(_9j_0_c499_b1 = NULL, 0, _9j_0_c499_b1), if(_9j_1_c499_b1 = NULL, 0, _9j_1_c499_b1))), 0.0004);

// _9j := if((integer)dobpop = 1, glrc9j * if(max(_9j_0_c499_b1, _9j_1_c499_b1) = NULL, NULL, sum(if(_9j_0_c499_b1 = NULL, 0, _9j_0_c499_b1), if(_9j_1_c499_b1 = NULL, 0, _9j_1_c499_b1))), glrc9j * if(max(_9j_0_c499_b2, _9j_1_c499_b2_1) = NULL, NULL, sum(if(_9j_0_c499_b2 = NULL, 0, _9j_0_c499_b2), if(_9j_1_c499_b2_1 = NULL, 0, _9j_1_c499_b2_1))));

_9t := if((integer)dobpop = 1, glrc9t * if(max(_9t_0_c499_b1, _9t_1_c512) = NULL, NULL, sum(if(_9t_0_c499_b1 = NULL, 0, _9t_0_c499_b1), if(_9t_1_c512 = NULL, 0, _9t_1_c512))), glrc9t * if(max(_9t_0_c499_b2, _9t_1_c526) = NULL, NULL, sum(if(_9t_0_c499_b2 = NULL, 0, _9t_0_c499_b2), if(_9t_1_c526 = NULL, 0, _9t_1_c526))));

_36 := if((integer)dobpop = 1, _36_c514, _36_c528);

_9e := if((integer)dobpop = 1, _9e_c499_b1_1 + 0.0001, _9e_c499_b2_1 + 0.0001);

_28 := if((integer)dobpop = 1, glrc28 * if(max(_28_0_c499_b1, _28_1_c510, _28_2_c512, _28_3_c513) = NULL, NULL, sum(if(_28_0_c499_b1 = NULL, 0, _28_0_c499_b1), if(_28_1_c510 = NULL, 0, _28_1_c510), if(_28_2_c512 = NULL, 0, _28_2_c512), if(_28_3_c513 = NULL, 0, _28_3_c513))), glrc28 * if(max(_28_0_c499_b2) = NULL, NULL, sum(if(_28_0_c499_b2 = NULL, 0, _28_0_c499_b2))));

_9w := if((integer)dobpop = 1, glrc9w * if(max(_9w_0_c504, _9w_1_c504, _9w_2_c499_b1) = NULL, NULL, sum(if(_9w_0_c504 = NULL, 0, _9w_0_c504), if(_9w_1_c504 = NULL, 0, _9w_1_c504), if(_9w_2_c499_b1 = NULL, 0, _9w_2_c499_b1))), glrc9w * if(max(_9w_0_c519, _9w_1_c519, _9w_2_c499_b2) = NULL, NULL, sum(if(_9w_0_c519 = NULL, 0, _9w_0_c519), if(_9w_1_c519 = NULL, 0, _9w_1_c519), if(_9w_2_c499_b2 = NULL, 0, _9w_2_c499_b2))));

_9m := if((integer)dobpop = 1, glrc9m * if(max(_9m_0_c499_b1, _9m_1_c504, _9m_2_c510, _9m_3_c512, _9m_4_c513) = NULL, NULL, sum(if(_9m_0_c499_b1 = NULL, 0, _9m_0_c499_b1), if(_9m_1_c504 = NULL, 0, _9m_1_c504), if(_9m_2_c510 = NULL, 0, _9m_2_c510), if(_9m_3_c512 = NULL, 0, _9m_3_c512), if(_9m_4_c513 = NULL, 0, _9m_4_c513))), glrc9m * if(max(_9m_0_c499_b2, _9m_1_c519, _9m_2_c525, _9m_3_c526, _9m_4_c527) = NULL, NULL, sum(if(_9m_0_c499_b2 = NULL, 0, _9m_0_c499_b2), if(_9m_1_c519 = NULL, 0, _9m_1_c519), if(_9m_2_c525 = NULL, 0, _9m_2_c525), if(_9m_3_c526 = NULL, 0, _9m_3_c526), if(_9m_4_c527 = NULL, 0, _9m_4_c527))));

_ev := if((integer)dobpop = 1, glrcev * if(max(_ev_0_c504, _ev_1_c504) = NULL, NULL, sum(if(_ev_0_c504 = NULL, 0, _ev_0_c504), if(_ev_1_c504 = NULL, 0, _ev_1_c504))), glrcev * if(max(_ev_0_c519, _ev_1_c519) = NULL, NULL, sum(if(_ev_0_c519 = NULL, 0, _ev_0_c519), if(_ev_1_c519 = NULL, 0, _ev_1_c519))));

_pv := if((integer)dobpop = 1, glrcpv * if(max(_pv_0_c499_b1, _pv_1_c504, _pv_2_c510, _pv_3_c512, _pv_4_c513) = NULL, NULL, sum(if(_pv_0_c499_b1 = NULL, 0, _pv_0_c499_b1), if(_pv_1_c504 = NULL, 0, _pv_1_c504), if(_pv_2_c510 = NULL, 0, _pv_2_c510), if(_pv_3_c512 = NULL, 0, _pv_3_c512), if(_pv_4_c513 = NULL, 0, _pv_4_c513))), glrcpv * if(max(_pv_0_c499_b2, _pv_1_c519, _pv_2_c525, _pv_3_c526, _pv_4_c527) = NULL, NULL, sum(if(_pv_0_c499_b2 = NULL, 0, _pv_0_c499_b2), if(_pv_1_c519 = NULL, 0, _pv_1_c519), if(_pv_2_c525 = NULL, 0, _pv_2_c525), if(_pv_3_c526 = NULL, 0, _pv_3_c526), if(_pv_4_c527 = NULL, 0, _pv_4_c527))));

_97 := if((integer)dobpop = 1, glrc97 * if(max(_97_0_c504, _97_1_c504) = NULL, NULL, sum(if(_97_0_c504 = NULL, 0, _97_0_c504), if(_97_1_c504 = NULL, 0, _97_1_c504))), glrc97 * if(max(_97_0_c519, _97_1_c519) = NULL, NULL, sum(if(_97_0_c519 = NULL, 0, _97_0_c519), if(_97_1_c519 = NULL, 0, _97_1_c519))));

_9r := if((integer)dobpop = 1, _9r_c499_b1_1 + 0.0003, _9r_c499_b2_1 + 0.0003);

_9q := if((integer)dobpop = 1, glrc9q * if(max(_9q_0_c499_b1, _9q_1_c504, _9q_2_c504, _9q_3_c504, _9q_4_c510, _9q_5_c510, _9q_6_c512, _9q_7_c513, _9q_8_c513, _9q_9_c513) = NULL, NULL, sum(if(_9q_0_c499_b1 = NULL, 0, _9q_0_c499_b1), if(_9q_1_c504 = NULL, 0, _9q_1_c504), if(_9q_2_c504 = NULL, 0, _9q_2_c504), if(_9q_3_c504 = NULL, 0, _9q_3_c504), if(_9q_4_c510 = NULL, 0, _9q_4_c510), if(_9q_5_c510 = NULL, 0, _9q_5_c510), if(_9q_6_c512 = NULL, 0, _9q_6_c512), if(_9q_7_c513 = NULL, 0, _9q_7_c513), if(_9q_8_c513 = NULL, 0, _9q_8_c513), if(_9q_9_c513 = NULL, 0, _9q_9_c513))), glrc9q * if(max(_9q_0_c499_b2, _9q_1_c519, _9q_2_c519, _9q_3_c519, _9q_4_c525, _9q_5_c525, _9q_6_c526, _9q_7_c527, _9q_8_c527, _9q_9_c527) = NULL, NULL, sum(if(_9q_0_c499_b2 = NULL, 0, _9q_0_c499_b2), if(_9q_1_c519 = NULL, 0, _9q_1_c519), if(_9q_2_c519 = NULL, 0, _9q_2_c519), if(_9q_3_c519 = NULL, 0, _9q_3_c519), if(_9q_4_c525 = NULL, 0, _9q_4_c525), if(_9q_5_c525 = NULL, 0, _9q_5_c525), if(_9q_6_c526 = NULL, 0, _9q_6_c526), if(_9q_7_c527 = NULL, 0, _9q_7_c527), if(_9q_8_c527 = NULL, 0, _9q_8_c527), if(_9q_9_c527 = NULL, 0, _9q_9_c527))));

_9g := if((integer)dobpop = 1, glrc9g * if(max(_9g_0_c499_b1, _9g_1_c504, _9g_2_c510, _9g_3_c510, _9g_4_c510, _9g_5_c512) = NULL, NULL, sum(if(_9g_0_c499_b1 = NULL, 0, _9g_0_c499_b1), if(_9g_1_c504 = NULL, 0, _9g_1_c504), if(_9g_2_c510 = NULL, 0, _9g_2_c510), if(_9g_3_c510 = NULL, 0, _9g_3_c510), if(_9g_4_c510 = NULL, 0, _9g_4_c510), if(_9g_5_c512 = NULL, 0, _9g_5_c512))), glrc9g * if(max(_9g_0_c499_b2, _9g_1_c519, _9g_2_c525, _9g_3_c525, _9g_4_c526, _9g_5_c527) = NULL, NULL, sum(if(_9g_0_c499_b2 = NULL, 0, _9g_0_c499_b2), if(_9g_1_c519 = NULL, 0, _9g_1_c519), if(_9g_2_c525 = NULL, 0, _9g_2_c525), if(_9g_3_c525 = NULL, 0, _9g_3_c525), if(_9g_4_c526 = NULL, 0, _9g_4_c526), if(_9g_5_c527 = NULL, 0, _9g_5_c527))));

_9s := if((integer)dobpop = 1, glrc9s * if(max(_9s_0_c499_b1, _9s_1_c504, _9s_2_c512, _9s_3_c512, _9s_4_c512, _9s_5_c513, _9s_6_c513) = NULL, NULL, sum(if(_9s_0_c499_b1 = NULL, 0, _9s_0_c499_b1), if(_9s_1_c504 = NULL, 0, _9s_1_c504), if(_9s_2_c512 = NULL, 0, _9s_2_c512), if(_9s_3_c512 = NULL, 0, _9s_3_c512), if(_9s_4_c512 = NULL, 0, _9s_4_c512), if(_9s_5_c513 = NULL, 0, _9s_5_c513), if(_9s_6_c513 = NULL, 0, _9s_6_c513))), glrc9s * if(max(_9s_0_c499_b2, _9s_1_c519, _9s_2_c526, _9s_3_c526, _9s_4_c526, _9s_5_c527, _9s_6_c527) = NULL, NULL, sum(if(_9s_0_c499_b2 = NULL, 0, _9s_0_c499_b2), if(_9s_1_c519 = NULL, 0, _9s_1_c519), if(_9s_2_c526 = NULL, 0, _9s_2_c526), if(_9s_3_c526 = NULL, 0, _9s_3_c526), if(_9s_4_c526 = NULL, 0, _9s_4_c526), if(_9s_5_c527 = NULL, 0, _9s_5_c527), if(_9s_6_c527 = NULL, 0, _9s_6_c527))));

_x11 := if((integer)dobpop = 1, glrcx11 * if(max(_x11_0_c499_b1, _x11_1_c504, _x11_2_c504, _x11_3_c504, _x11_4_c504, _x11_5_c510, _x11_6_c510, _x11_7_c512, _x11_8_c512, _x11_9_c512, _x11_10_c512, _x11_11_c512, _x11_12_c513, _x11_13_c513, _x11_14_c513, _x11_15_c513, _x11_16_c513) = NULL, NULL, sum(if(_x11_0_c499_b1 = NULL, 0, _x11_0_c499_b1), if(_x11_1_c504 = NULL, 0, _x11_1_c504), if(_x11_2_c504 = NULL, 0, _x11_2_c504), if(_x11_3_c504 = NULL, 0, _x11_3_c504), if(_x11_4_c504 = NULL, 0, _x11_4_c504), if(_x11_5_c510 = NULL, 0, _x11_5_c510), if(_x11_6_c510 = NULL, 0, _x11_6_c510), if(_x11_7_c512 = NULL, 0, _x11_7_c512), if(_x11_8_c512 = NULL, 0, _x11_8_c512), if(_x11_9_c512 = NULL, 0, _x11_9_c512), if(_x11_10_c512 = NULL, 0, _x11_10_c512), if(_x11_11_c512 = NULL, 0, _x11_11_c512), if(_x11_12_c513 = NULL, 0, _x11_12_c513), if(_x11_13_c513 = NULL, 0, _x11_13_c513), if(_x11_14_c513 = NULL, 0, _x11_14_c513), if(_x11_15_c513 = NULL, 0, _x11_15_c513), if(_x11_16_c513 = NULL, 0, _x11_16_c513))), glrcx11 * if(max(_x11_0_c499_b2, _x11_1_c519, _x11_2_c519, _x11_3_c519, _x11_4_c519, _x11_5_c525, _x11_6_c525, _x11_7_c526, _x11_8_c526, _x11_9_c526, _x11_10_c526, _x11_11_c526, _x11_12_c527, _x11_13_c527, _x11_14_c527, _x11_15_c527, _x11_16_c527) = NULL, NULL, sum(if(_x11_0_c499_b2 = NULL, 0, _x11_0_c499_b2), if(_x11_1_c519 = NULL, 0, _x11_1_c519), if(_x11_2_c519 = NULL, 0, _x11_2_c519), if(_x11_3_c519 = NULL, 0, _x11_3_c519), if(_x11_4_c519 = NULL, 0, _x11_4_c519), if(_x11_5_c525 = NULL, 0, _x11_5_c525), if(_x11_6_c525 = NULL, 0, _x11_6_c525), if(_x11_7_c526 = NULL, 0, _x11_7_c526), if(_x11_8_c526 = NULL, 0, _x11_8_c526), if(_x11_9_c526 = NULL, 0, _x11_9_c526), if(_x11_10_c526 = NULL, 0, _x11_10_c526), if(_x11_11_c526 = NULL, 0, _x11_11_c526), if(_x11_12_c527 = NULL, 0, _x11_12_c527), if(_x11_13_c527 = NULL, 0, _x11_13_c527), if(_x11_14_c527 = NULL, 0, _x11_14_c527), if(_x11_15_c527 = NULL, 0, _x11_15_c527), if(_x11_16_c527 = NULL, 0, _x11_16_c527))));

_98 := if((integer)dobpop = 1, glrc98 * if(max(_98_0_c504, _98_1_c504) = NULL, NULL, sum(if(_98_0_c504 = NULL, 0, _98_0_c504), if(_98_1_c504 = NULL, 0, _98_1_c504))), glrc98 * if(max(_98_0_c519, _98_1_c519) = NULL, NULL, sum(if(_98_0_c519 = NULL, 0, _98_0_c519), if(_98_1_c519 = NULL, 0, _98_1_c519))));

_9f := if((integer)dobpop = 1, glrc9f * if(max(_9f_0_c499_b1, _9f_1_c499_b1) = NULL, NULL, sum(if(_9f_0_c499_b1 = NULL, 0, _9f_0_c499_b1), if(_9f_1_c499_b1 = NULL, 0, _9f_1_c499_b1))), glrc9f * if(max(_9f_0_c499_b2, _9f_1_c499_b2) = NULL, NULL, sum(if(_9f_0_c499_b2 = NULL, 0, _9f_0_c499_b2), if(_9f_1_c499_b2 = NULL, 0, _9f_1_c499_b2))));

_ms := if((integer)dobpop = 1, glrcms * if(max(_ms_0_c499_b1, _ms_1_c504, _ms_2_c504, _ms_3_c510, _ms_4_c510, _ms_5_c512, _ms_6_c513) = NULL, NULL, sum(if(_ms_0_c499_b1 = NULL, 0, _ms_0_c499_b1), if(_ms_1_c504 = NULL, 0, _ms_1_c504), if(_ms_2_c504 = NULL, 0, _ms_2_c504), if(_ms_3_c510 = NULL, 0, _ms_3_c510), if(_ms_4_c510 = NULL, 0, _ms_4_c510), if(_ms_5_c512 = NULL, 0, _ms_5_c512), if(_ms_6_c513 = NULL, 0, _ms_6_c513))), glrcms * if(max(_ms_0_c499_b2, _ms_1_c519, _ms_2_c519, _ms_3_c525, _ms_4_c525, _ms_5_c526, _ms_6_c527, _ms_7_c527) = NULL, NULL, sum(if(_ms_0_c499_b2 = NULL, 0, _ms_0_c499_b2), if(_ms_1_c519 = NULL, 0, _ms_1_c519), if(_ms_2_c519 = NULL, 0, _ms_2_c519), if(_ms_3_c525 = NULL, 0, _ms_3_c525), if(_ms_4_c525 = NULL, 0, _ms_4_c525), if(_ms_5_c526 = NULL, 0, _ms_5_c526), if(_ms_6_c527 = NULL, 0, _ms_6_c527), if(_ms_7_c527 = NULL, 0, _ms_7_c527))));

_99 := if((integer)dobpop = 1, (integer)glrc99 * if(max(_99_0_c499_b1, _99_1_c512) = NULL, NULL, sum(if(_99_0_c499_b1 = NULL, 0, _99_0_c499_b1), if(_99_1_c512 = NULL, 0, _99_1_c512))), (integer)glrc99 * if(max(_99_0_c499_b2, _99_1_c526) = NULL, NULL, sum(if(_99_0_c499_b2 = NULL, 0, _99_0_c499_b2), if(_99_1_c526 = NULL, 0, _99_1_c526))));

_9a := if((integer)dobpop = 1, glrc9a * if(max(_9a_0_c499_b1, _9a_1_c504, _9a_2_c504, _9a_3_c504, _9a_4_c510, _9a_5_c510, _9a_6_c513, _9a_7_c513) = NULL, NULL, sum(if(_9a_0_c499_b1 = NULL, 0, _9a_0_c499_b1), if(_9a_1_c504 = NULL, 0, _9a_1_c504), if(_9a_2_c504 = NULL, 0, _9a_2_c504), if(_9a_3_c504 = NULL, 0, _9a_3_c504), if(_9a_4_c510 = NULL, 0, _9a_4_c510), if(_9a_5_c510 = NULL, 0, _9a_5_c510), if(_9a_6_c513 = NULL, 0, _9a_6_c513), if(_9a_7_c513 = NULL, 0, _9a_7_c513))), glrc9a * if(max(_9a_0_c499_b2, _9a_1_c519, _9a_2_c519, _9a_3_c519, _9a_4_c525, _9a_5_c525, _9a_6_c527, _9a_7_c527) = NULL, NULL, sum(if(_9a_0_c499_b2 = NULL, 0, _9a_0_c499_b2), if(_9a_1_c519 = NULL, 0, _9a_1_c519), if(_9a_2_c519 = NULL, 0, _9a_2_c519), if(_9a_3_c519 = NULL, 0, _9a_3_c519), if(_9a_4_c525 = NULL, 0, _9a_4_c525), if(_9a_5_c525 = NULL, 0, _9a_5_c525), if(_9a_6_c527 = NULL, 0, _9a_6_c527), if(_9a_7_c527 = NULL, 0, _9a_7_c527))));

_9n := if((integer)dobpop = 1, glrc9n * if(max(_9n_0_c499_b1, _9n_1_c504) = NULL, NULL, sum(if(_9n_0_c499_b1 = NULL, 0, _9n_0_c499_b1), if(_9n_1_c504 = NULL, 0, _9n_1_c504))), glrc9n * if(max(_9n_0_c499_b2, _9n_1_c519) = NULL, NULL, sum(if(_9n_0_c499_b2 = NULL, 0, _9n_0_c499_b2), if(_9n_1_c519 = NULL, 0, _9n_1_c519))));

_25 := if((integer)dobpop = 1, glrc25 * if(max(_25_0_c499_b1, _25_1_c512, _25_2_c513) = NULL, NULL, sum(if(_25_0_c499_b1 = NULL, 0, _25_0_c499_b1), if(_25_1_c512 = NULL, 0, _25_1_c512), if(_25_2_c513 = NULL, 0, _25_2_c513))), glrc25 * if(max(_25_0_c499_b2, _25_1_c526, _25_2_c527) = NULL, NULL, sum(if(_25_0_c499_b2 = NULL, 0, _25_0_c499_b2), if(_25_1_c526 = NULL, 0, _25_1_c526), if(_25_2_c527 = NULL, 0, _25_2_c527))));

_9d := if((integer)dobpop = 1, glrc9d * if(max(_9d_0_c499_b1, _9d_1_c504, _9d_2_c504, _9d_3_c504, _9d_4_c504, _9d_5_c510, _9d_6_c510, _9d_7_c512, _9d_8_c512, _9d_9_c512, _9d_10_c512, _9d_11_c513, _9d_12_c513, _9d_13_c513) = NULL, NULL, sum(if(_9d_0_c499_b1 = NULL, 0, _9d_0_c499_b1), if(_9d_1_c504 = NULL, 0, _9d_1_c504), if(_9d_2_c504 = NULL, 0, _9d_2_c504), if(_9d_3_c504 = NULL, 0, _9d_3_c504), if(_9d_4_c504 = NULL, 0, _9d_4_c504), if(_9d_5_c510 = NULL, 0, _9d_5_c510), if(_9d_6_c510 = NULL, 0, _9d_6_c510), if(_9d_7_c512 = NULL, 0, _9d_7_c512), if(_9d_8_c512 = NULL, 0, _9d_8_c512), if(_9d_9_c512 = NULL, 0, _9d_9_c512), if(_9d_10_c512 = NULL, 0, _9d_10_c512), if(_9d_11_c513 = NULL, 0, _9d_11_c513), if(_9d_12_c513 = NULL, 0, _9d_12_c513), if(_9d_13_c513 = NULL, 0, _9d_13_c513))), glrc9d * if(max(_9d_0_c499_b2, _9d_1_c519, _9d_2_c519, _9d_3_c519, _9d_4_c519, _9d_5_c525, _9d_6_c525, _9d_7_c526, _9d_8_c526, _9d_9_c526, _9d_10_c526, _9d_11_c527, _9d_12_c527, _9d_13_c527) = NULL, NULL, sum(if(_9d_0_c499_b2 = NULL, 0, _9d_0_c499_b2), if(_9d_1_c519 = NULL, 0, _9d_1_c519), if(_9d_2_c519 = NULL, 0, _9d_2_c519), if(_9d_3_c519 = NULL, 0, _9d_3_c519), if(_9d_4_c519 = NULL, 0, _9d_4_c519), if(_9d_5_c525 = NULL, 0, _9d_5_c525), if(_9d_6_c525 = NULL, 0, _9d_6_c525), if(_9d_7_c526 = NULL, 0, _9d_7_c526), if(_9d_8_c526 = NULL, 0, _9d_8_c526), if(_9d_9_c526 = NULL, 0, _9d_9_c526), if(_9d_10_c526 = NULL, 0, _9d_10_c526), if(_9d_11_c527 = NULL, 0, _9d_11_c527), if(_9d_12_c527 = NULL, 0, _9d_12_c527), if(_9d_13_c527 = NULL, 0, _9d_13_c527))));

ds_layout := {STRING rc, REAL value};

rc_dataset := DATASET([
    {'25' , _25 },
    {'28' , _28 },
    {'36' , _36 },
    {'97' , _97 },
    {'98' , _98 },
    {'99' , _99 },
    {'9A' , _9a },
    {'9C' , _9c },
    {'9D' , _9d },
    {'9E' , _9e },
    {'9G' , _9g },
    {'9H' , _9h },
    {'9M' , _9m },
    {'9N' , _9n },
    {'9Q' , _9q },
    {'9R' , _9r },
    {'9S' , _9s },
    {'9T' , _9t },
    {'9U' , _9u },
    {'9W' , _9w },
    {'EV' , _ev },
    {'MI' , _mi },
    {'MS' , _ms },
    {'PV' , _pv },
    // {'X11', _x11},
    {'9J' , _9j },
    {'9F' , _9f }
    ], ds_layout)(value > 0);


rcs_top4 := CHOOSEN(SORT(rc_dataset, -value), 4); // Take the top four reason codes

rcs_9p1 := map(
               trim((pk_Segment_40),left) ='3 Other' and rcs_top4[1].rc = ''       =>    ROW({'9A', NULL}, ds_layout),
							 rcs_top4[1].rc = '' and rvb1104!= 900     =>    ROW({'36', NULL}, ds_layout), 
							                                                      rcs_top4[1]);
rcs_9p2 := rcs_top4[2];
rcs_9p3 := rcs_top4[3];
rcs_9p4 := rcs_top4[4];
rcs_9p5 := IF((boolean)GLRC9Q AND NOT EXISTS(rcs_top4(rc = '9Q')) AND  // Check to see if RC 9Q is a part of the score, but not in the first 4 RC's
									
                 ( ( pk_inq_peradl_S0_0m > 0.0510322723           and pk_Segment_40 = '0 Derog' ) or
                  ( pk_inq_recent_lvl_S1_1m > 0.076869551        and pk_Segment_40 = '1 Young' ) or
                  ( pk_mth_inq_frst_log_dt2_S2_2m > 0.0137038529 and pk_Segment_40 = '2 Owner' ) or
                  ( pk_inq_recent_lvl_S3_3m > 0.0246590642       and pk_Segment_40 = '3 Other' ) ),
										DATASET([{'9Q', NULL}], ds_layout)); // If so - make it the 5th reason code.
	                                
rcs_9p := rcs_9p1 & rcs_9p2 & rcs_9p3 & rcs_9p4 & rcs_9p5;

rcs_override := MAP( rvb1104 = 200 => DATASET([{'02', NULL}], ds_layout),
                     rvb1104 = 222 => DATASET([{'9X', NULL}], ds_layout),
                     // rvb1104 = 900 => DATASET([{'  ', NULL}], ds_layout),
                     NOT EXISTS(rcs_9p(rc != '')) => DATASET([{'36', NULL}], ds_layout),
                     rcs_9p);
										 
riTemp := RiskWiseFCRA.corrReasonCodes(le.consumerflags, 4);
	
rcs_final := PROJECT(rcs_override, TRANSFORM(Risk_Indicators.Layout_Desc,
                                             SELF.hri := LEFT.rc,
                                             SELF.desc := Risk_Indicators.getHRIDesc(LEFT.rc)));

inCalif := isCalifornia AND (
           (integer)(boolean)le.iid.combo_firstcount+(integer)(boolean)le.iid.combo_lastcount
           +(integer)(boolean)le.iid.combo_addrcount+(integer)(boolean)le.iid.combo_hphonecount
           +(integer)(boolean)le.iid.combo_ssncount+(integer)(boolean)le.iid.combo_dobcount) < 3;
		
ri := MAP( riTemp[1].hri <> '00' => riTemp,
           inCalif => DATASET([{'35', Risk_Indicators.getHRIDesc('35')}, {'00',''}, {'00',''}, {'00',''}], Risk_Indicators.Layout_Desc),
           rcs_final
           );
				
zeros := DATASET([{'00',''}, {'00',''}, {'00',''}, {'00',''}], Risk_Indicators.Layout_Desc);

reasons := CHOOSEN(ri & zeros, 5); // Keep up to 4 reason codes



		#if(RVB_DEBUG)
                    self.sysdate                          := sysdate;
                    self.sysyear                          := sysyear;
                    self.in_dob2                          := in_dob2;
                    self.yr_in_dob                        := yr_in_dob;
                    self.mth_in_dob                       := mth_in_dob;
                    self.add1_date_first_seen2            := add1_date_first_seen2;
                    self.yr_add1_date_first_seen          := yr_add1_date_first_seen;
                    self.mth_add1_date_first_seen         := mth_add1_date_first_seen;
                    self.gong_did_first_seen2             := gong_did_first_seen2;
                    self.yr_gong_did_first_seen           := yr_gong_did_first_seen;
                    self.mth_gong_did_first_seen          := mth_gong_did_first_seen;
                    self.header_first_seen2               := header_first_seen2;
                    self.yr_header_first_seen             := yr_header_first_seen;
                    self.mth_header_first_seen            := mth_header_first_seen;
                    self.ver_src_cnt                      := ver_src_cnt;
                    self.ver_src_pop                      := ver_src_pop;
                    self.ver_src_fsrc                     := ver_src_fsrc;
                    self.ver_src_fsrc_fdate               := ver_src_fsrc_fdate;
                    self.ver_src_fsrc_fdate2              := ver_src_fsrc_fdate2;
                    self.yr_ver_src_fsrc_fdate            := yr_ver_src_fsrc_fdate;
                    self.mth_ver_src_fsrc_fdate           := mth_ver_src_fsrc_fdate;
                    self.ver_src_ak_pos                   := ver_src_ak_pos;
                    self.ver_src_ak                       := ver_src_ak;
                    self.ver_src_fdate_ak                 := ver_src_fdate_ak;
                    self.ver_src_fdate_ak2                := ver_src_fdate_ak2;
                    self.yr_ver_src_fdate_ak              := yr_ver_src_fdate_ak;
                    self.mth_ver_src_fdate_ak             := mth_ver_src_fdate_ak;
                    self.ver_src_ldate_ak                 := ver_src_ldate_ak;
                    self.ver_src_ldate_ak2                := ver_src_ldate_ak2;
                    self.yr_ver_src_ldate_ak              := yr_ver_src_ldate_ak;
                    self.mth_ver_src_ldate_ak             := mth_ver_src_ldate_ak;
                    self.ver_src_cnt_ak                   := ver_src_cnt_ak;
                    self.ver_src_am_pos                   := ver_src_am_pos;
                    self.ver_src_am                       := ver_src_am;
                    self.ver_src_fdate_am                 := ver_src_fdate_am;
                    self.ver_src_fdate_am2                := ver_src_fdate_am2;
                    self.yr_ver_src_fdate_am              := yr_ver_src_fdate_am;
                    self.mth_ver_src_fdate_am             := mth_ver_src_fdate_am;
                    self.ver_src_ldate_am                 := ver_src_ldate_am;
                    self.ver_src_ldate_am2                := ver_src_ldate_am2;
                    self.yr_ver_src_ldate_am              := yr_ver_src_ldate_am;
                    self.mth_ver_src_ldate_am             := mth_ver_src_ldate_am;
                    self.ver_src_cnt_am                   := ver_src_cnt_am;
                    self.ver_src_ar_pos                   := ver_src_ar_pos;
                    self.ver_src_ar                       := ver_src_ar;
                    self.ver_src_fdate_ar                 := ver_src_fdate_ar;
                    self.ver_src_fdate_ar2                := ver_src_fdate_ar2;
                    self.yr_ver_src_fdate_ar              := yr_ver_src_fdate_ar;
                    self.mth_ver_src_fdate_ar             := mth_ver_src_fdate_ar;
                    self.ver_src_ldate_ar                 := ver_src_ldate_ar;
                    self.ver_src_ldate_ar2                := ver_src_ldate_ar2;
                    self.yr_ver_src_ldate_ar              := yr_ver_src_ldate_ar;
                    self.mth_ver_src_ldate_ar             := mth_ver_src_ldate_ar;
                    self.ver_src_cnt_ar                   := ver_src_cnt_ar;
                    self.ver_src_ba_pos                   := ver_src_ba_pos;
                    self.ver_src_ba                       := ver_src_ba;
                    self.ver_src_fdate_ba                 := ver_src_fdate_ba;
                    self.ver_src_fdate_ba2                := ver_src_fdate_ba2;
                    self.yr_ver_src_fdate_ba              := yr_ver_src_fdate_ba;
                    self.mth_ver_src_fdate_ba             := mth_ver_src_fdate_ba;
                    self.ver_src_ldate_ba                 := ver_src_ldate_ba;
                    self.ver_src_ldate_ba2                := ver_src_ldate_ba2;
                    self.yr_ver_src_ldate_ba              := yr_ver_src_ldate_ba;
                    self.mth_ver_src_ldate_ba             := mth_ver_src_ldate_ba;
                    self.ver_src_cnt_ba                   := ver_src_cnt_ba;
                    self.ver_src_cg_pos                   := ver_src_cg_pos;
                    self.ver_src_cg                       := ver_src_cg;
                    self.ver_src_fdate_cg                 := ver_src_fdate_cg;
                    self.ver_src_fdate_cg2                := ver_src_fdate_cg2;
                    self.yr_ver_src_fdate_cg              := yr_ver_src_fdate_cg;
                    self.mth_ver_src_fdate_cg             := mth_ver_src_fdate_cg;
                    self.ver_src_ldate_cg                 := ver_src_ldate_cg;
                    self.ver_src_ldate_cg2                := ver_src_ldate_cg2;
                    self.yr_ver_src_ldate_cg              := yr_ver_src_ldate_cg;
                    self.mth_ver_src_ldate_cg             := mth_ver_src_ldate_cg;
                    self.ver_src_cnt_cg                   := ver_src_cnt_cg;
                    self.ver_src_co_pos                   := ver_src_co_pos;
                    self.ver_src_co                       := ver_src_co;
                    self.ver_src_fdate_co                 := ver_src_fdate_co;
                    self.ver_src_fdate_co2                := ver_src_fdate_co2;
                    self.yr_ver_src_fdate_co              := yr_ver_src_fdate_co;
                    self.mth_ver_src_fdate_co             := mth_ver_src_fdate_co;
                    self.ver_src_ldate_co                 := ver_src_ldate_co;
                    self.ver_src_ldate_co2                := ver_src_ldate_co2;
                    self.yr_ver_src_ldate_co              := yr_ver_src_ldate_co;
                    self.mth_ver_src_ldate_co             := mth_ver_src_ldate_co;
                    self.ver_src_cnt_co                   := ver_src_cnt_co;
                    self.ver_src_cy_pos                   := ver_src_cy_pos;
                    self.ver_src_cy                       := ver_src_cy;
                    self.ver_src_fdate_cy                 := ver_src_fdate_cy;
                    self.ver_src_fdate_cy2                := ver_src_fdate_cy2;
                    self.yr_ver_src_fdate_cy              := yr_ver_src_fdate_cy;
                    self.mth_ver_src_fdate_cy             := mth_ver_src_fdate_cy;
                    self.ver_src_ldate_cy                 := ver_src_ldate_cy;
                    self.ver_src_ldate_cy2                := ver_src_ldate_cy2;
                    self.yr_ver_src_ldate_cy              := yr_ver_src_ldate_cy;
                    self.mth_ver_src_ldate_cy             := mth_ver_src_ldate_cy;
                    self.ver_src_cnt_cy                   := ver_src_cnt_cy;
                    self.ver_src_da_pos                   := ver_src_da_pos;
                    self.ver_src_da                       := ver_src_da;
                    self.ver_src_fdate_da                 := ver_src_fdate_da;
                    self.ver_src_fdate_da2                := ver_src_fdate_da2;
                    self.yr_ver_src_fdate_da              := yr_ver_src_fdate_da;
                    self.mth_ver_src_fdate_da             := mth_ver_src_fdate_da;
                    self.ver_src_ldate_da                 := ver_src_ldate_da;
                    self.ver_src_ldate_da2                := ver_src_ldate_da2;
                    self.yr_ver_src_ldate_da              := yr_ver_src_ldate_da;
                    self.mth_ver_src_ldate_da             := mth_ver_src_ldate_da;
                    self.ver_src_cnt_da                   := ver_src_cnt_da;
                    self.ver_src_d_pos                    := ver_src_d_pos;
                    self.ver_src_d                        := ver_src_d;
                    self.ver_src_fdate_d                  := ver_src_fdate_d;
                    self.ver_src_fdate_d2                 := ver_src_fdate_d2;
                    self.yr_ver_src_fdate_d               := yr_ver_src_fdate_d;
                    self.mth_ver_src_fdate_d              := mth_ver_src_fdate_d;
                    self.ver_src_ldate_d                  := ver_src_ldate_d;
                    self.ver_src_ldate_d2                 := ver_src_ldate_d2;
                    self.yr_ver_src_ldate_d               := yr_ver_src_ldate_d;
                    self.mth_ver_src_ldate_d              := mth_ver_src_ldate_d;
                    self.ver_src_cnt_d                    := ver_src_cnt_d;
                    self.ver_src_dl_pos                   := ver_src_dl_pos;
                    self.ver_src_dl                       := ver_src_dl;
                    self.ver_src_fdate_dl                 := ver_src_fdate_dl;
                    self.ver_src_fdate_dl2                := ver_src_fdate_dl2;
                    self.yr_ver_src_fdate_dl              := yr_ver_src_fdate_dl;
                    self.mth_ver_src_fdate_dl             := mth_ver_src_fdate_dl;
                    self.ver_src_ldate_dl                 := ver_src_ldate_dl;
                    self.ver_src_ldate_dl2                := ver_src_ldate_dl2;
                    self.yr_ver_src_ldate_dl              := yr_ver_src_ldate_dl;
                    self.mth_ver_src_ldate_dl             := mth_ver_src_ldate_dl;
                    self.ver_src_cnt_dl                   := ver_src_cnt_dl;
                    self.ver_src_ds_pos                   := ver_src_ds_pos;
                    self.ver_src_ds                       := ver_src_ds;
                    self.ver_src_fdate_ds                 := ver_src_fdate_ds;
                    self.ver_src_fdate_ds2                := ver_src_fdate_ds2;
                    self.yr_ver_src_fdate_ds              := yr_ver_src_fdate_ds;
                    self.mth_ver_src_fdate_ds             := mth_ver_src_fdate_ds;
                    self.ver_src_ldate_ds                 := ver_src_ldate_ds;
                    self.ver_src_ldate_ds2                := ver_src_ldate_ds2;
                    self.yr_ver_src_ldate_ds              := yr_ver_src_ldate_ds;
                    self.mth_ver_src_ldate_ds             := mth_ver_src_ldate_ds;
                    self.ver_src_cnt_ds                   := ver_src_cnt_ds;
                    self.ver_src_de_pos                   := ver_src_de_pos;
                    self.ver_src_de                       := ver_src_de;
                    self.ver_src_fdate_de                 := ver_src_fdate_de;
                    self.ver_src_fdate_de2                := ver_src_fdate_de2;
                    self.yr_ver_src_fdate_de              := yr_ver_src_fdate_de;
                    self.mth_ver_src_fdate_de             := mth_ver_src_fdate_de;
                    self.ver_src_ldate_de                 := ver_src_ldate_de;
                    self.ver_src_ldate_de2                := ver_src_ldate_de2;
                    self.yr_ver_src_ldate_de              := yr_ver_src_ldate_de;
                    self.mth_ver_src_ldate_de             := mth_ver_src_ldate_de;
                    self.ver_src_cnt_de                   := ver_src_cnt_de;
                    self.ver_src_eb_pos                   := ver_src_eb_pos;
                    self.ver_src_eb                       := ver_src_eb;
                    self.ver_src_fdate_eb                 := ver_src_fdate_eb;
                    self.ver_src_fdate_eb2                := ver_src_fdate_eb2;
                    self.yr_ver_src_fdate_eb              := yr_ver_src_fdate_eb;
                    self.mth_ver_src_fdate_eb             := mth_ver_src_fdate_eb;
                    self.ver_src_ldate_eb                 := ver_src_ldate_eb;
                    self.ver_src_ldate_eb2                := ver_src_ldate_eb2;
                    self.yr_ver_src_ldate_eb              := yr_ver_src_ldate_eb;
                    self.mth_ver_src_ldate_eb             := mth_ver_src_ldate_eb;
                    self.ver_src_cnt_eb                   := ver_src_cnt_eb;
                    self.ver_src_em_pos                   := ver_src_em_pos;
                    self.ver_src_em                       := ver_src_em;
                    self.ver_src_fdate_em                 := ver_src_fdate_em;
                    self.ver_src_fdate_em2                := ver_src_fdate_em2;
                    self.yr_ver_src_fdate_em              := yr_ver_src_fdate_em;
                    self.mth_ver_src_fdate_em             := mth_ver_src_fdate_em;
                    self.ver_src_ldate_em                 := ver_src_ldate_em;
                    self.ver_src_ldate_em2                := ver_src_ldate_em2;
                    self.yr_ver_src_ldate_em              := yr_ver_src_ldate_em;
                    self.mth_ver_src_ldate_em             := mth_ver_src_ldate_em;
                    self.ver_src_cnt_em                   := ver_src_cnt_em;
                    self.ver_src_e1_pos                   := ver_src_e1_pos;
                    self.ver_src_e1                       := ver_src_e1;
                    self.ver_src_fdate_e1                 := ver_src_fdate_e1;
                    self.ver_src_fdate_e12                := ver_src_fdate_e12;
                    self.yr_ver_src_fdate_e1              := yr_ver_src_fdate_e1;
                    self.mth_ver_src_fdate_e1             := mth_ver_src_fdate_e1;
                    self.ver_src_ldate_e1                 := ver_src_ldate_e1;
                    self.ver_src_ldate_e12                := ver_src_ldate_e12;
                    self.yr_ver_src_ldate_e1              := yr_ver_src_ldate_e1;
                    self.mth_ver_src_ldate_e1             := mth_ver_src_ldate_e1;
                    self.ver_src_cnt_e1                   := ver_src_cnt_e1;
                    self.ver_src_e2_pos                   := ver_src_e2_pos;
                    self.ver_src_e2                       := ver_src_e2;
                    self.ver_src_fdate_e2                 := ver_src_fdate_e2;
                    self.ver_src_fdate_e22                := ver_src_fdate_e22;
                    self.yr_ver_src_fdate_e2              := yr_ver_src_fdate_e2;
                    self.mth_ver_src_fdate_e2             := mth_ver_src_fdate_e2;
                    self.ver_src_ldate_e2                 := ver_src_ldate_e2;
                    self.ver_src_ldate_e22                := ver_src_ldate_e22;
                    self.yr_ver_src_ldate_e2              := yr_ver_src_ldate_e2;
                    self.mth_ver_src_ldate_e2             := mth_ver_src_ldate_e2;
                    self.ver_src_cnt_e2                   := ver_src_cnt_e2;
                    self.ver_src_e3_pos                   := ver_src_e3_pos;
                    self.ver_src_e3                       := ver_src_e3;
                    self.ver_src_fdate_e3                 := ver_src_fdate_e3;
                    self.ver_src_fdate_e32                := ver_src_fdate_e32;
                    self.yr_ver_src_fdate_e3              := yr_ver_src_fdate_e3;
                    self.mth_ver_src_fdate_e3             := mth_ver_src_fdate_e3;
                    self.ver_src_ldate_e3                 := ver_src_ldate_e3;
                    self.ver_src_ldate_e32                := ver_src_ldate_e32;
                    self.yr_ver_src_ldate_e3              := yr_ver_src_ldate_e3;
                    self.mth_ver_src_ldate_e3             := mth_ver_src_ldate_e3;
                    self.ver_src_cnt_e3                   := ver_src_cnt_e3;
                    self.ver_src_e4_pos                   := ver_src_e4_pos;
                    self.ver_src_e4                       := ver_src_e4;
                    self.ver_src_fdate_e4                 := ver_src_fdate_e4;
                    self.ver_src_fdate_e42                := ver_src_fdate_e42;
                    self.yr_ver_src_fdate_e4              := yr_ver_src_fdate_e4;
                    self.mth_ver_src_fdate_e4             := mth_ver_src_fdate_e4;
                    self.ver_src_ldate_e4                 := ver_src_ldate_e4;
                    self.ver_src_ldate_e42                := ver_src_ldate_e42;
                    self.yr_ver_src_ldate_e4              := yr_ver_src_ldate_e4;
                    self.mth_ver_src_ldate_e4             := mth_ver_src_ldate_e4;
                    self.ver_src_cnt_e4                   := ver_src_cnt_e4;
                    self.ver_src_en_pos                   := ver_src_en_pos;
                    self.ver_src_en                       := ver_src_en;
                    self.ver_src_fdate_en                 := ver_src_fdate_en;
                    self.ver_src_fdate_en2                := ver_src_fdate_en2;
                    self.yr_ver_src_fdate_en              := yr_ver_src_fdate_en;
                    self.mth_ver_src_fdate_en             := mth_ver_src_fdate_en;
                    self.ver_src_ldate_en                 := ver_src_ldate_en;
                    self.ver_src_ldate_en2                := ver_src_ldate_en2;
                    self.yr_ver_src_ldate_en              := yr_ver_src_ldate_en;
                    self.mth_ver_src_ldate_en             := mth_ver_src_ldate_en;
                    self.ver_src_cnt_en                   := ver_src_cnt_en;
                    self.ver_src_eq_pos                   := ver_src_eq_pos;
                    self.ver_src_eq                       := ver_src_eq;
                    self.ver_src_fdate_eq                 := ver_src_fdate_eq;
                    self.ver_src_fdate_eq2                := ver_src_fdate_eq2;
                    self.yr_ver_src_fdate_eq              := yr_ver_src_fdate_eq;
                    self.mth_ver_src_fdate_eq             := mth_ver_src_fdate_eq;
                    self.ver_src_ldate_eq                 := ver_src_ldate_eq;
                    self.ver_src_ldate_eq2                := ver_src_ldate_eq2;
                    self.yr_ver_src_ldate_eq              := yr_ver_src_ldate_eq;
                    self.mth_ver_src_ldate_eq             := mth_ver_src_ldate_eq;
                    self.ver_src_cnt_eq                   := ver_src_cnt_eq;
                    self.ver_src_fe_pos                   := ver_src_fe_pos;
                    self.ver_src_fe                       := ver_src_fe;
                    self.ver_src_fdate_fe                 := ver_src_fdate_fe;
                    self.ver_src_fdate_fe2                := ver_src_fdate_fe2;
                    self.yr_ver_src_fdate_fe              := yr_ver_src_fdate_fe;
                    self.mth_ver_src_fdate_fe             := mth_ver_src_fdate_fe;
                    self.ver_src_ldate_fe                 := ver_src_ldate_fe;
                    self.ver_src_ldate_fe2                := ver_src_ldate_fe2;
                    self.yr_ver_src_ldate_fe              := yr_ver_src_ldate_fe;
                    self.mth_ver_src_ldate_fe             := mth_ver_src_ldate_fe;
                    self.ver_src_cnt_fe                   := ver_src_cnt_fe;
                    self.ver_src_ff_pos                   := ver_src_ff_pos;
                    self.ver_src_ff                       := ver_src_ff;
                    self.ver_src_fdate_ff                 := ver_src_fdate_ff;
                    self.ver_src_fdate_ff2                := ver_src_fdate_ff2;
                    self.yr_ver_src_fdate_ff              := yr_ver_src_fdate_ff;
                    self.mth_ver_src_fdate_ff             := mth_ver_src_fdate_ff;
                    self.ver_src_ldate_ff                 := ver_src_ldate_ff;
                    self.ver_src_ldate_ff2                := ver_src_ldate_ff2;
                    self.yr_ver_src_ldate_ff              := yr_ver_src_ldate_ff;
                    self.mth_ver_src_ldate_ff             := mth_ver_src_ldate_ff;
                    self.ver_src_cnt_ff                   := ver_src_cnt_ff;
                    self.ver_src_fr_pos                   := ver_src_fr_pos;
                    self.ver_src_fr                       := ver_src_fr;
                    self.ver_src_fdate_fr                 := ver_src_fdate_fr;
                    self.ver_src_fdate_fr2                := ver_src_fdate_fr2;
                    self.yr_ver_src_fdate_fr              := yr_ver_src_fdate_fr;
                    self.mth_ver_src_fdate_fr             := mth_ver_src_fdate_fr;
                    self.ver_src_ldate_fr                 := ver_src_ldate_fr;
                    self.ver_src_ldate_fr2                := ver_src_ldate_fr2;
                    self.yr_ver_src_ldate_fr              := yr_ver_src_ldate_fr;
                    self.mth_ver_src_ldate_fr             := mth_ver_src_ldate_fr;
                    self.ver_src_cnt_fr                   := ver_src_cnt_fr;
                    self.ver_src_l2_pos                   := ver_src_l2_pos;
                    self.ver_src_l2                       := ver_src_l2;
                    self.ver_src_fdate_l2                 := ver_src_fdate_l2;
                    self.ver_src_fdate_l22                := ver_src_fdate_l22;
                    self.yr_ver_src_fdate_l2              := yr_ver_src_fdate_l2;
                    self.mth_ver_src_fdate_l2             := mth_ver_src_fdate_l2;
                    self.ver_src_ldate_l2                 := ver_src_ldate_l2;
                    self.ver_src_ldate_l22                := ver_src_ldate_l22;
                    self.yr_ver_src_ldate_l2              := yr_ver_src_ldate_l2;
                    self.mth_ver_src_ldate_l2             := mth_ver_src_ldate_l2;
                    self.ver_src_cnt_l2                   := ver_src_cnt_l2;
                    self.ver_src_li_pos                   := ver_src_li_pos;
                    self.ver_src_li                       := ver_src_li;
                    self.ver_src_fdate_li                 := ver_src_fdate_li;
                    self.ver_src_fdate_li2                := ver_src_fdate_li2;
                    self.yr_ver_src_fdate_li              := yr_ver_src_fdate_li;
                    self.mth_ver_src_fdate_li             := mth_ver_src_fdate_li;
                    self.ver_src_ldate_li                 := ver_src_ldate_li;
                    self.ver_src_ldate_li2                := ver_src_ldate_li2;
                    self.yr_ver_src_ldate_li              := yr_ver_src_ldate_li;
                    self.mth_ver_src_ldate_li             := mth_ver_src_ldate_li;
                    self.ver_src_cnt_li                   := ver_src_cnt_li;
                    self.ver_src_mw_pos                   := ver_src_mw_pos;
                    self.ver_src_mw                       := ver_src_mw;
                    self.ver_src_fdate_mw                 := ver_src_fdate_mw;
                    self.ver_src_fdate_mw2                := ver_src_fdate_mw2;
                    self.yr_ver_src_fdate_mw              := yr_ver_src_fdate_mw;
                    self.mth_ver_src_fdate_mw             := mth_ver_src_fdate_mw;
                    self.ver_src_ldate_mw                 := ver_src_ldate_mw;
                    self.ver_src_ldate_mw2                := ver_src_ldate_mw2;
                    self.yr_ver_src_ldate_mw              := yr_ver_src_ldate_mw;
                    self.mth_ver_src_ldate_mw             := mth_ver_src_ldate_mw;
                    self.ver_src_cnt_mw                   := ver_src_cnt_mw;
                    self.ver_src_nt_pos                   := ver_src_nt_pos;
                    self.ver_src_nt                       := ver_src_nt;
                    self.ver_src_fdate_nt                 := ver_src_fdate_nt;
                    self.ver_src_fdate_nt2                := ver_src_fdate_nt2;
                    self.yr_ver_src_fdate_nt              := yr_ver_src_fdate_nt;
                    self.mth_ver_src_fdate_nt             := mth_ver_src_fdate_nt;
                    self.ver_src_ldate_nt                 := ver_src_ldate_nt;
                    self.ver_src_ldate_nt2                := ver_src_ldate_nt2;
                    self.yr_ver_src_ldate_nt              := yr_ver_src_ldate_nt;
                    self.mth_ver_src_ldate_nt             := mth_ver_src_ldate_nt;
                    self.ver_src_cnt_nt                   := ver_src_cnt_nt;
                    self.ver_src_p_pos                    := ver_src_p_pos;
                    self.ver_src_p                        := ver_src_p;
                    self.ver_src_fdate_p                  := ver_src_fdate_p;
                    self.ver_src_fdate_p2                 := ver_src_fdate_p2;
                    self.yr_ver_src_fdate_p               := yr_ver_src_fdate_p;
                    self.mth_ver_src_fdate_p              := mth_ver_src_fdate_p;
                    self.ver_src_ldate_p                  := ver_src_ldate_p;
                    self.ver_src_ldate_p2                 := ver_src_ldate_p2;
                    self.yr_ver_src_ldate_p               := yr_ver_src_ldate_p;
                    self.mth_ver_src_ldate_p              := mth_ver_src_ldate_p;
                    self.ver_src_cnt_p                    := ver_src_cnt_p;
                    self.ver_src_pl_pos                   := ver_src_pl_pos;
                    self.ver_src_pl                       := ver_src_pl;
                    self.ver_src_fdate_pl                 := ver_src_fdate_pl;
                    self.ver_src_fdate_pl2                := ver_src_fdate_pl2;
                    self.yr_ver_src_fdate_pl              := yr_ver_src_fdate_pl;
                    self.mth_ver_src_fdate_pl             := mth_ver_src_fdate_pl;
                    self.ver_src_ldate_pl                 := ver_src_ldate_pl;
                    self.ver_src_ldate_pl2                := ver_src_ldate_pl2;
                    self.yr_ver_src_ldate_pl              := yr_ver_src_ldate_pl;
                    self.mth_ver_src_ldate_pl             := mth_ver_src_ldate_pl;
                    self.ver_src_cnt_pl                   := ver_src_cnt_pl;
                    self.ver_src_ts_pos                   := ver_src_ts_pos;
                    self.ver_src_ts                       := ver_src_ts;
                    self.ver_src_fdate_ts                 := ver_src_fdate_ts;
                    self.ver_src_fdate_ts2                := ver_src_fdate_ts2;
                    self.yr_ver_src_fdate_ts              := yr_ver_src_fdate_ts;
                    self.mth_ver_src_fdate_ts             := mth_ver_src_fdate_ts;
                    self.ver_src_ldate_ts                 := ver_src_ldate_ts;
                    self.ver_src_ldate_ts2                := ver_src_ldate_ts2;
                    self.yr_ver_src_ldate_ts              := yr_ver_src_ldate_ts;
                    self.mth_ver_src_ldate_ts             := mth_ver_src_ldate_ts;
                    self.ver_src_cnt_ts                   := ver_src_cnt_ts;
                    self.ver_src_tu_pos                   := ver_src_tu_pos;
                    self.ver_src_tu                       := ver_src_tu;
                    self.ver_src_fdate_tu                 := ver_src_fdate_tu;
                    self.ver_src_fdate_tu2                := ver_src_fdate_tu2;
                    self.yr_ver_src_fdate_tu              := yr_ver_src_fdate_tu;
                    self.mth_ver_src_fdate_tu             := mth_ver_src_fdate_tu;
                    self.ver_src_ldate_tu                 := ver_src_ldate_tu;
                    self.ver_src_ldate_tu2                := ver_src_ldate_tu2;
                    self.yr_ver_src_ldate_tu              := yr_ver_src_ldate_tu;
                    self.mth_ver_src_ldate_tu             := mth_ver_src_ldate_tu;
                    self.ver_src_cnt_tu                   := ver_src_cnt_tu;
                    self.ver_src_sl_pos                   := ver_src_sl_pos;
                    self.ver_src_sl                       := ver_src_sl;
                    self.ver_src_fdate_sl                 := ver_src_fdate_sl;
                    self.ver_src_fdate_sl2                := ver_src_fdate_sl2;
                    self.yr_ver_src_fdate_sl              := yr_ver_src_fdate_sl;
                    self.mth_ver_src_fdate_sl             := mth_ver_src_fdate_sl;
                    self.ver_src_ldate_sl                 := ver_src_ldate_sl;
                    self.ver_src_ldate_sl2                := ver_src_ldate_sl2;
                    self.yr_ver_src_ldate_sl              := yr_ver_src_ldate_sl;
                    self.mth_ver_src_ldate_sl             := mth_ver_src_ldate_sl;
                    self.ver_src_cnt_sl                   := ver_src_cnt_sl;
                    self.ver_src_v_pos                    := ver_src_v_pos;
                    self.ver_src_v                        := ver_src_v;
                    self.ver_src_fdate_v                  := ver_src_fdate_v;
                    self.ver_src_fdate_v2                 := ver_src_fdate_v2;
                    self.yr_ver_src_fdate_v               := yr_ver_src_fdate_v;
                    self.mth_ver_src_fdate_v              := mth_ver_src_fdate_v;
                    self.ver_src_ldate_v                  := ver_src_ldate_v;
                    self.ver_src_ldate_v2                 := ver_src_ldate_v2;
                    self.yr_ver_src_ldate_v               := yr_ver_src_ldate_v;
                    self.mth_ver_src_ldate_v              := mth_ver_src_ldate_v;
                    self.ver_src_cnt_v                    := ver_src_cnt_v;
                    self.ver_src_vo_pos                   := ver_src_vo_pos;
                    self.ver_src_vo                       := ver_src_vo;
                    self.ver_src_fdate_vo                 := ver_src_fdate_vo;
                    self.ver_src_fdate_vo2                := ver_src_fdate_vo2;
                    self.yr_ver_src_fdate_vo              := yr_ver_src_fdate_vo;
                    self.mth_ver_src_fdate_vo             := mth_ver_src_fdate_vo;
                    self.ver_src_ldate_vo                 := ver_src_ldate_vo;
                    self.ver_src_ldate_vo2                := ver_src_ldate_vo2;
                    self.yr_ver_src_ldate_vo              := yr_ver_src_ldate_vo;
                    self.mth_ver_src_ldate_vo             := mth_ver_src_ldate_vo;
                    self.ver_src_cnt_vo                   := ver_src_cnt_vo;
                    self.ver_src_w_pos                    := ver_src_w_pos;
                    self.ver_src_w                        := ver_src_w;
                    self.ver_src_fdate_w                  := ver_src_fdate_w;
                    self.ver_src_fdate_w2                 := ver_src_fdate_w2;
                    self.yr_ver_src_fdate_w               := yr_ver_src_fdate_w;
                    self.mth_ver_src_fdate_w              := mth_ver_src_fdate_w;
                    self.ver_src_ldate_w                  := ver_src_ldate_w;
                    self.ver_src_ldate_w2                 := ver_src_ldate_w2;
                    self.yr_ver_src_ldate_w               := yr_ver_src_ldate_w;
                    self.mth_ver_src_ldate_w              := mth_ver_src_ldate_w;
                    self.ver_src_cnt_w                    := ver_src_cnt_w;
                    self.ver_src_wp_pos                   := ver_src_wp_pos;
                    self.ver_src_wp                       := ver_src_wp;
                    self.ver_src_fdate_wp                 := ver_src_fdate_wp;
                    self.ver_src_fdate_wp2                := ver_src_fdate_wp2;
                    self.yr_ver_src_fdate_wp              := yr_ver_src_fdate_wp;
                    self.mth_ver_src_fdate_wp             := mth_ver_src_fdate_wp;
                    self.ver_src_ldate_wp                 := ver_src_ldate_wp;
                    self.ver_src_ldate_wp2                := ver_src_ldate_wp2;
                    self.yr_ver_src_ldate_wp              := yr_ver_src_ldate_wp;
                    self.mth_ver_src_ldate_wp             := mth_ver_src_ldate_wp;
                    self.ver_src_cnt_wp                   := ver_src_cnt_wp;
                    // self.ver_src_rcnt                     := ver_src_rcnt;
                    self.ver_dob_src_cnt                  := ver_dob_src_cnt;
                    self.ver_dob_src_pop                  := ver_dob_src_pop;
                    self.ver_dob_src_fsrc                 := ver_dob_src_fsrc;
                    self.ver_dob_src_fsrc_fdate           := ver_dob_src_fsrc_fdate;
                    self.ver_dob_src_fsrc_fdate2          := ver_dob_src_fsrc_fdate2;
                    self.yr_ver_dob_src_fsrc_fdate        := yr_ver_dob_src_fsrc_fdate;
                    self.mth_ver_dob_src_fsrc_fdate       := mth_ver_dob_src_fsrc_fdate;
                    self.ver_dob_src_ak_pos               := ver_dob_src_ak_pos;
                    self.ver_dob_src_ak                   := ver_dob_src_ak;
                    self.ver_dob_src_fdate_ak             := ver_dob_src_fdate_ak;
                    self.ver_dob_src_fdate_ak2            := ver_dob_src_fdate_ak2;
                    self.yr_ver_dob_src_fdate_ak          := yr_ver_dob_src_fdate_ak;
                    self.mth_ver_dob_src_fdate_ak         := mth_ver_dob_src_fdate_ak;
                    self.ver_dob_src_cnt_ak               := ver_dob_src_cnt_ak;
                    self.ver_dob_src_am_pos               := ver_dob_src_am_pos;
                    self.ver_dob_src_am                   := ver_dob_src_am;
                    self.ver_dob_src_fdate_am             := ver_dob_src_fdate_am;
                    self.ver_dob_src_fdate_am2            := ver_dob_src_fdate_am2;
                    self.yr_ver_dob_src_fdate_am          := yr_ver_dob_src_fdate_am;
                    self.mth_ver_dob_src_fdate_am         := mth_ver_dob_src_fdate_am;
                    self.ver_dob_src_cnt_am               := ver_dob_src_cnt_am;
                    self.ver_dob_src_ar_pos               := ver_dob_src_ar_pos;
                    self.ver_dob_src_ar                   := ver_dob_src_ar;
                    self.ver_dob_src_fdate_ar             := ver_dob_src_fdate_ar;
                    self.ver_dob_src_fdate_ar2            := ver_dob_src_fdate_ar2;
                    self.yr_ver_dob_src_fdate_ar          := yr_ver_dob_src_fdate_ar;
                    self.mth_ver_dob_src_fdate_ar         := mth_ver_dob_src_fdate_ar;
                    self.ver_dob_src_cnt_ar               := ver_dob_src_cnt_ar;
                    self.ver_dob_src_ba_pos               := ver_dob_src_ba_pos;
                    self.ver_dob_src_ba                   := ver_dob_src_ba;
                    self.ver_dob_src_fdate_ba             := ver_dob_src_fdate_ba;
                    self.ver_dob_src_fdate_ba2            := ver_dob_src_fdate_ba2;
                    self.yr_ver_dob_src_fdate_ba          := yr_ver_dob_src_fdate_ba;
                    self.mth_ver_dob_src_fdate_ba         := mth_ver_dob_src_fdate_ba;
                    self.ver_dob_src_cnt_ba               := ver_dob_src_cnt_ba;
                    self.ver_dob_src_cg_pos               := ver_dob_src_cg_pos;
                    self.ver_dob_src_cg                   := ver_dob_src_cg;
                    self.ver_dob_src_fdate_cg             := ver_dob_src_fdate_cg;
                    self.ver_dob_src_fdate_cg2            := ver_dob_src_fdate_cg2;
                    self.yr_ver_dob_src_fdate_cg          := yr_ver_dob_src_fdate_cg;
                    self.mth_ver_dob_src_fdate_cg         := mth_ver_dob_src_fdate_cg;
                    self.ver_dob_src_cnt_cg               := ver_dob_src_cnt_cg;
                    self.ver_dob_src_co_pos               := ver_dob_src_co_pos;
                    self.ver_dob_src_co                   := ver_dob_src_co;
                    self.ver_dob_src_fdate_co             := ver_dob_src_fdate_co;
                    self.ver_dob_src_fdate_co2            := ver_dob_src_fdate_co2;
                    self.yr_ver_dob_src_fdate_co          := yr_ver_dob_src_fdate_co;
                    self.mth_ver_dob_src_fdate_co         := mth_ver_dob_src_fdate_co;
                    self.ver_dob_src_cnt_co               := ver_dob_src_cnt_co;
                    self.ver_dob_src_cy_pos               := ver_dob_src_cy_pos;
                    self.ver_dob_src_cy                   := ver_dob_src_cy;
                    self.ver_dob_src_fdate_cy             := ver_dob_src_fdate_cy;
                    self.ver_dob_src_fdate_cy2            := ver_dob_src_fdate_cy2;
                    self.yr_ver_dob_src_fdate_cy          := yr_ver_dob_src_fdate_cy;
                    self.mth_ver_dob_src_fdate_cy         := mth_ver_dob_src_fdate_cy;
                    self.ver_dob_src_cnt_cy               := ver_dob_src_cnt_cy;
                    self.ver_dob_src_da_pos               := ver_dob_src_da_pos;
                    self.ver_dob_src_da                   := ver_dob_src_da;
                    self.ver_dob_src_fdate_da             := ver_dob_src_fdate_da;
                    self.ver_dob_src_fdate_da2            := ver_dob_src_fdate_da2;
                    self.yr_ver_dob_src_fdate_da          := yr_ver_dob_src_fdate_da;
                    self.mth_ver_dob_src_fdate_da         := mth_ver_dob_src_fdate_da;
                    self.ver_dob_src_cnt_da               := ver_dob_src_cnt_da;
                    self.ver_dob_src_d_pos                := ver_dob_src_d_pos;
                    self.ver_dob_src_d                    := ver_dob_src_d;
                    self.ver_dob_src_fdate_d              := ver_dob_src_fdate_d;
                    self.ver_dob_src_fdate_d2             := ver_dob_src_fdate_d2;
                    self.yr_ver_dob_src_fdate_d           := yr_ver_dob_src_fdate_d;
                    self.mth_ver_dob_src_fdate_d          := mth_ver_dob_src_fdate_d;
                    self.ver_dob_src_cnt_d                := ver_dob_src_cnt_d;
                    self.ver_dob_src_dl_pos               := ver_dob_src_dl_pos;
                    self.ver_dob_src_dl                   := ver_dob_src_dl;
                    self.ver_dob_src_fdate_dl             := ver_dob_src_fdate_dl;
                    self.ver_dob_src_fdate_dl2            := ver_dob_src_fdate_dl2;
                    self.yr_ver_dob_src_fdate_dl          := yr_ver_dob_src_fdate_dl;
                    self.mth_ver_dob_src_fdate_dl         := mth_ver_dob_src_fdate_dl;
                    self.ver_dob_src_cnt_dl               := ver_dob_src_cnt_dl;
                    self.ver_dob_src_ds_pos               := ver_dob_src_ds_pos;
                    self.ver_dob_src_ds                   := ver_dob_src_ds;
                    self.ver_dob_src_fdate_ds             := ver_dob_src_fdate_ds;
                    self.ver_dob_src_fdate_ds2            := ver_dob_src_fdate_ds2;
                    self.yr_ver_dob_src_fdate_ds          := yr_ver_dob_src_fdate_ds;
                    self.mth_ver_dob_src_fdate_ds         := mth_ver_dob_src_fdate_ds;
                    self.ver_dob_src_cnt_ds               := ver_dob_src_cnt_ds;
                    self.ver_dob_src_de_pos               := ver_dob_src_de_pos;
                    self.ver_dob_src_de                   := ver_dob_src_de;
                    self.ver_dob_src_fdate_de             := ver_dob_src_fdate_de;
                    self.ver_dob_src_fdate_de2            := ver_dob_src_fdate_de2;
                    self.yr_ver_dob_src_fdate_de          := yr_ver_dob_src_fdate_de;
                    self.mth_ver_dob_src_fdate_de         := mth_ver_dob_src_fdate_de;
                    self.ver_dob_src_cnt_de               := ver_dob_src_cnt_de;
                    self.ver_dob_src_eb_pos               := ver_dob_src_eb_pos;
                    self.ver_dob_src_eb                   := ver_dob_src_eb;
                    self.ver_dob_src_fdate_eb             := ver_dob_src_fdate_eb;
                    self.ver_dob_src_fdate_eb2            := ver_dob_src_fdate_eb2;
                    self.yr_ver_dob_src_fdate_eb          := yr_ver_dob_src_fdate_eb;
                    self.mth_ver_dob_src_fdate_eb         := mth_ver_dob_src_fdate_eb;
                    self.ver_dob_src_cnt_eb               := ver_dob_src_cnt_eb;
                    self.ver_dob_src_em_pos               := ver_dob_src_em_pos;
                    self.ver_dob_src_em                   := ver_dob_src_em;
                    self.ver_dob_src_fdate_em             := ver_dob_src_fdate_em;
                    self.ver_dob_src_fdate_em2            := ver_dob_src_fdate_em2;
                    self.yr_ver_dob_src_fdate_em          := yr_ver_dob_src_fdate_em;
                    self.mth_ver_dob_src_fdate_em         := mth_ver_dob_src_fdate_em;
                    self.ver_dob_src_cnt_em               := ver_dob_src_cnt_em;
                    self.ver_dob_src_e1_pos               := ver_dob_src_e1_pos;
                    self.ver_dob_src_e1                   := ver_dob_src_e1;
                    self.ver_dob_src_fdate_e1             := ver_dob_src_fdate_e1;
                    self.ver_dob_src_fdate_e12            := ver_dob_src_fdate_e12;
                    self.yr_ver_dob_src_fdate_e1          := yr_ver_dob_src_fdate_e1;
                    self.mth_ver_dob_src_fdate_e1         := mth_ver_dob_src_fdate_e1;
                    self.ver_dob_src_cnt_e1               := ver_dob_src_cnt_e1;
                    self.ver_dob_src_e2_pos               := ver_dob_src_e2_pos;
                    self.ver_dob_src_e2                   := ver_dob_src_e2;
                    self.ver_dob_src_fdate_e2             := ver_dob_src_fdate_e2;
                    self.ver_dob_src_fdate_e22            := ver_dob_src_fdate_e22;
                    self.yr_ver_dob_src_fdate_e2          := yr_ver_dob_src_fdate_e2;
                    self.mth_ver_dob_src_fdate_e2         := mth_ver_dob_src_fdate_e2;
                    self.ver_dob_src_cnt_e2               := ver_dob_src_cnt_e2;
                    self.ver_dob_src_e3_pos               := ver_dob_src_e3_pos;
                    self.ver_dob_src_e3                   := ver_dob_src_e3;
                    self.ver_dob_src_fdate_e3             := ver_dob_src_fdate_e3;
                    self.ver_dob_src_fdate_e32            := ver_dob_src_fdate_e32;
                    self.yr_ver_dob_src_fdate_e3          := yr_ver_dob_src_fdate_e3;
                    self.mth_ver_dob_src_fdate_e3         := mth_ver_dob_src_fdate_e3;
                    self.ver_dob_src_cnt_e3               := ver_dob_src_cnt_e3;
                    self.ver_dob_src_e4_pos               := ver_dob_src_e4_pos;
                    self.ver_dob_src_e4                   := ver_dob_src_e4;
                    self.ver_dob_src_fdate_e4             := ver_dob_src_fdate_e4;
                    self.ver_dob_src_fdate_e42            := ver_dob_src_fdate_e42;
                    self.yr_ver_dob_src_fdate_e4          := yr_ver_dob_src_fdate_e4;
                    self.mth_ver_dob_src_fdate_e4         := mth_ver_dob_src_fdate_e4;
                    self.ver_dob_src_cnt_e4               := ver_dob_src_cnt_e4;
                    self.ver_dob_src_en_pos               := ver_dob_src_en_pos;
                    self.ver_dob_src_en                   := ver_dob_src_en;
                    self.ver_dob_src_fdate_en             := ver_dob_src_fdate_en;
                    self.ver_dob_src_fdate_en2            := ver_dob_src_fdate_en2;
                    self.yr_ver_dob_src_fdate_en          := yr_ver_dob_src_fdate_en;
                    self.mth_ver_dob_src_fdate_en         := mth_ver_dob_src_fdate_en;
                    self.ver_dob_src_cnt_en               := ver_dob_src_cnt_en;
                    self.ver_dob_src_eq_pos               := ver_dob_src_eq_pos;
                    self.ver_dob_src_eq                   := ver_dob_src_eq;
                    self.ver_dob_src_fdate_eq             := ver_dob_src_fdate_eq;
                    self.ver_dob_src_fdate_eq2            := ver_dob_src_fdate_eq2;
                    self.yr_ver_dob_src_fdate_eq          := yr_ver_dob_src_fdate_eq;
                    self.mth_ver_dob_src_fdate_eq         := mth_ver_dob_src_fdate_eq;
                    self.ver_dob_src_cnt_eq               := ver_dob_src_cnt_eq;
                    self.ver_dob_src_fe_pos               := ver_dob_src_fe_pos;
                    self.ver_dob_src_fe                   := ver_dob_src_fe;
                    self.ver_dob_src_fdate_fe             := ver_dob_src_fdate_fe;
                    self.ver_dob_src_fdate_fe2            := ver_dob_src_fdate_fe2;
                    self.yr_ver_dob_src_fdate_fe          := yr_ver_dob_src_fdate_fe;
                    self.mth_ver_dob_src_fdate_fe         := mth_ver_dob_src_fdate_fe;
                    self.ver_dob_src_cnt_fe               := ver_dob_src_cnt_fe;
                    self.ver_dob_src_ff_pos               := ver_dob_src_ff_pos;
                    self.ver_dob_src_ff                   := ver_dob_src_ff;
                    self.ver_dob_src_fdate_ff             := ver_dob_src_fdate_ff;
                    self.ver_dob_src_fdate_ff2            := ver_dob_src_fdate_ff2;
                    self.yr_ver_dob_src_fdate_ff          := yr_ver_dob_src_fdate_ff;
                    self.mth_ver_dob_src_fdate_ff         := mth_ver_dob_src_fdate_ff;
                    self.ver_dob_src_cnt_ff               := ver_dob_src_cnt_ff;
                    self.ver_dob_src_fr_pos               := ver_dob_src_fr_pos;
                    self.ver_dob_src_fr                   := ver_dob_src_fr;
                    self.ver_dob_src_fdate_fr             := ver_dob_src_fdate_fr;
                    self.ver_dob_src_fdate_fr2            := ver_dob_src_fdate_fr2;
                    self.yr_ver_dob_src_fdate_fr          := yr_ver_dob_src_fdate_fr;
                    self.mth_ver_dob_src_fdate_fr         := mth_ver_dob_src_fdate_fr;
                    self.ver_dob_src_cnt_fr               := ver_dob_src_cnt_fr;
                    self.ver_dob_src_l2_pos               := ver_dob_src_l2_pos;
                    self.ver_dob_src_l2                   := ver_dob_src_l2;
                    self.ver_dob_src_fdate_l2             := ver_dob_src_fdate_l2;
                    self.ver_dob_src_fdate_l22            := ver_dob_src_fdate_l22;
                    self.yr_ver_dob_src_fdate_l2          := yr_ver_dob_src_fdate_l2;
                    self.mth_ver_dob_src_fdate_l2         := mth_ver_dob_src_fdate_l2;
                    self.ver_dob_src_cnt_l2               := ver_dob_src_cnt_l2;
                    self.ver_dob_src_li_pos               := ver_dob_src_li_pos;
                    self.ver_dob_src_li                   := ver_dob_src_li;
                    self.ver_dob_src_fdate_li             := ver_dob_src_fdate_li;
                    self.ver_dob_src_fdate_li2            := ver_dob_src_fdate_li2;
                    self.yr_ver_dob_src_fdate_li          := yr_ver_dob_src_fdate_li;
                    self.mth_ver_dob_src_fdate_li         := mth_ver_dob_src_fdate_li;
                    self.ver_dob_src_cnt_li               := ver_dob_src_cnt_li;
                    self.ver_dob_src_mw_pos               := ver_dob_src_mw_pos;
                    self.ver_dob_src_mw                   := ver_dob_src_mw;
                    self.ver_dob_src_fdate_mw             := ver_dob_src_fdate_mw;
                    self.ver_dob_src_fdate_mw2            := ver_dob_src_fdate_mw2;
                    self.yr_ver_dob_src_fdate_mw          := yr_ver_dob_src_fdate_mw;
                    self.mth_ver_dob_src_fdate_mw         := mth_ver_dob_src_fdate_mw;
                    self.ver_dob_src_cnt_mw               := ver_dob_src_cnt_mw;
                    self.ver_dob_src_nt_pos               := ver_dob_src_nt_pos;
                    self.ver_dob_src_nt                   := ver_dob_src_nt;
                    self.ver_dob_src_fdate_nt             := ver_dob_src_fdate_nt;
                    self.ver_dob_src_fdate_nt2            := ver_dob_src_fdate_nt2;
                    self.yr_ver_dob_src_fdate_nt          := yr_ver_dob_src_fdate_nt;
                    self.mth_ver_dob_src_fdate_nt         := mth_ver_dob_src_fdate_nt;
                    self.ver_dob_src_cnt_nt               := ver_dob_src_cnt_nt;
                    self.ver_dob_src_p_pos                := ver_dob_src_p_pos;
                    self.ver_dob_src_p                    := ver_dob_src_p;
                    self.ver_dob_src_fdate_p              := ver_dob_src_fdate_p;
                    self.ver_dob_src_fdate_p2             := ver_dob_src_fdate_p2;
                    self.yr_ver_dob_src_fdate_p           := yr_ver_dob_src_fdate_p;
                    self.mth_ver_dob_src_fdate_p          := mth_ver_dob_src_fdate_p;
                    self.ver_dob_src_cnt_p                := ver_dob_src_cnt_p;
                    self.ver_dob_src_pl_pos               := ver_dob_src_pl_pos;
                    self.ver_dob_src_pl                   := ver_dob_src_pl;
                    self.ver_dob_src_fdate_pl             := ver_dob_src_fdate_pl;
                    self.ver_dob_src_fdate_pl2            := ver_dob_src_fdate_pl2;
                    self.yr_ver_dob_src_fdate_pl          := yr_ver_dob_src_fdate_pl;
                    self.mth_ver_dob_src_fdate_pl         := mth_ver_dob_src_fdate_pl;
                    self.ver_dob_src_cnt_pl               := ver_dob_src_cnt_pl;
                    self.ver_dob_src_ts_pos               := ver_dob_src_ts_pos;
                    self.ver_dob_src_ts                   := ver_dob_src_ts;
                    self.ver_dob_src_fdate_ts             := ver_dob_src_fdate_ts;
                    self.ver_dob_src_fdate_ts2            := ver_dob_src_fdate_ts2;
                    self.yr_ver_dob_src_fdate_ts          := yr_ver_dob_src_fdate_ts;
                    self.mth_ver_dob_src_fdate_ts         := mth_ver_dob_src_fdate_ts;
                    self.ver_dob_src_cnt_ts               := ver_dob_src_cnt_ts;
                    self.ver_dob_src_tu_pos               := ver_dob_src_tu_pos;
                    self.ver_dob_src_tu                   := ver_dob_src_tu;
                    self.ver_dob_src_fdate_tu             := ver_dob_src_fdate_tu;
                    self.ver_dob_src_fdate_tu2            := ver_dob_src_fdate_tu2;
                    self.yr_ver_dob_src_fdate_tu          := yr_ver_dob_src_fdate_tu;
                    self.mth_ver_dob_src_fdate_tu         := mth_ver_dob_src_fdate_tu;
                    self.ver_dob_src_cnt_tu               := ver_dob_src_cnt_tu;
                    self.ver_dob_src_sl_pos               := ver_dob_src_sl_pos;
                    self.ver_dob_src_sl                   := ver_dob_src_sl;
                    self.ver_dob_src_fdate_sl             := ver_dob_src_fdate_sl;
                    self.ver_dob_src_fdate_sl2            := ver_dob_src_fdate_sl2;
                    self.yr_ver_dob_src_fdate_sl          := yr_ver_dob_src_fdate_sl;
                    self.mth_ver_dob_src_fdate_sl         := mth_ver_dob_src_fdate_sl;
                    self.ver_dob_src_cnt_sl               := ver_dob_src_cnt_sl;
                    self.ver_dob_src_v_pos                := ver_dob_src_v_pos;
                    self.ver_dob_src_v                    := ver_dob_src_v;
                    self.ver_dob_src_fdate_v              := ver_dob_src_fdate_v;
                    self.ver_dob_src_fdate_v2             := ver_dob_src_fdate_v2;
                    self.yr_ver_dob_src_fdate_v           := yr_ver_dob_src_fdate_v;
                    self.mth_ver_dob_src_fdate_v          := mth_ver_dob_src_fdate_v;
                    self.ver_dob_src_cnt_v                := ver_dob_src_cnt_v;
                    self.ver_dob_src_vo_pos               := ver_dob_src_vo_pos;
                    self.ver_dob_src_vo                   := ver_dob_src_vo;
                    self.ver_dob_src_fdate_vo             := ver_dob_src_fdate_vo;
                    self.ver_dob_src_fdate_vo2            := ver_dob_src_fdate_vo2;
                    self.yr_ver_dob_src_fdate_vo          := yr_ver_dob_src_fdate_vo;
                    self.mth_ver_dob_src_fdate_vo         := mth_ver_dob_src_fdate_vo;
                    self.ver_dob_src_cnt_vo               := ver_dob_src_cnt_vo;
                    self.ver_dob_src_w_pos                := ver_dob_src_w_pos;
                    self.ver_dob_src_w                    := ver_dob_src_w;
                    self.ver_dob_src_fdate_w              := ver_dob_src_fdate_w;
                    self.ver_dob_src_fdate_w2             := ver_dob_src_fdate_w2;
                    self.yr_ver_dob_src_fdate_w           := yr_ver_dob_src_fdate_w;
                    self.mth_ver_dob_src_fdate_w          := mth_ver_dob_src_fdate_w;
                    self.ver_dob_src_cnt_w                := ver_dob_src_cnt_w;
                    self.ver_dob_src_wp_pos               := ver_dob_src_wp_pos;
                    self.ver_dob_src_wp                   := ver_dob_src_wp;
                    self.ver_dob_src_fdate_wp             := ver_dob_src_fdate_wp;
                    self.ver_dob_src_fdate_wp2            := ver_dob_src_fdate_wp2;
                    self.yr_ver_dob_src_fdate_wp          := yr_ver_dob_src_fdate_wp;
                    self.mth_ver_dob_src_fdate_wp         := mth_ver_dob_src_fdate_wp;
                    self.ver_dob_src_cnt_wp               := ver_dob_src_cnt_wp;
                    // self.ver_dob_src_rcnt                 := ver_dob_src_rcnt;
                    self.email_src_cnt                    := email_src_cnt;
                    self.email_src_pop                    := email_src_pop;
                    self.email_src_fsrc                   := email_src_fsrc;
                    self.email_src_fsrc_fdate             := email_src_fsrc_fdate;
                    self.email_src_fsrc_fdate2            := email_src_fsrc_fdate2;
                    self.yr_email_src_fsrc_fdate          := yr_email_src_fsrc_fdate;
                    self.mth_email_src_fsrc_fdate         := mth_email_src_fsrc_fdate;
                    self.email_src_aw_pos                 := email_src_aw_pos;
                    self.email_src_aw                     := email_src_aw;
                    self.email_src_fdate_aw               := email_src_fdate_aw;
                    self.email_src_fdate_aw2              := email_src_fdate_aw2;
                    self.yr_email_src_fdate_aw            := yr_email_src_fdate_aw;
                    self.mth_email_src_fdate_aw           := mth_email_src_fdate_aw;
                    self.email_src_cnt_aw                 := email_src_cnt_aw;
                    self.email_src_et_pos                 := email_src_et_pos;
                    self.email_src_et                     := email_src_et;
                    self.email_src_fdate_et               := email_src_fdate_et;
                    self.email_src_fdate_et2              := email_src_fdate_et2;
                    self.yr_email_src_fdate_et            := yr_email_src_fdate_et;
                    self.mth_email_src_fdate_et           := mth_email_src_fdate_et;
                    self.email_src_cnt_et                 := email_src_cnt_et;
                    self.email_src_im_pos                 := email_src_im_pos;
                    self.email_src_fdate_im               := email_src_fdate_im;
                    self.email_src_fdate_im2              := email_src_fdate_im2;
                    self.yr_email_src_fdate_im            := yr_email_src_fdate_im;
                    self.mth_email_src_fdate_im           := mth_email_src_fdate_im;
                    self.email_src_cnt_im                 := email_src_cnt_im;
                    self.email_src_wa_pos                 := email_src_wa_pos;
                    self.email_src_wa                     := email_src_wa;
                    self.email_src_fdate_wa               := email_src_fdate_wa;
                    self.email_src_fdate_wa2              := email_src_fdate_wa2;
                    self.yr_email_src_fdate_wa            := yr_email_src_fdate_wa;
                    self.mth_email_src_fdate_wa           := mth_email_src_fdate_wa;
                    self.email_src_cnt_wa                 := email_src_cnt_wa;
                    self.email_src_om_pos                 := email_src_om_pos;
                    self.email_src_om                     := email_src_om;
                    self.email_src_fdate_om               := email_src_fdate_om;
                    self.email_src_fdate_om2              := email_src_fdate_om2;
                    self.yr_email_src_fdate_om            := yr_email_src_fdate_om;
                    self.mth_email_src_fdate_om           := mth_email_src_fdate_om;
                    self.email_src_cnt_om                 := email_src_cnt_om;
                    self.email_src_m1_pos                 := email_src_m1_pos;
                    self.email_src_m1                     := email_src_m1;
                    self.email_src_fdate_m1               := email_src_fdate_m1;
                    self.email_src_fdate_m12              := email_src_fdate_m12;
                    self.yr_email_src_fdate_m1            := yr_email_src_fdate_m1;
                    self.mth_email_src_fdate_m1           := mth_email_src_fdate_m1;
                    self.email_src_cnt_m1                 := email_src_cnt_m1;
                    // self.email_src_rcnt                   := email_src_rcnt;
                    self.add_ec1                          := add_ec1;
                    self.add_ec3                          := add_ec3;
                    self.add_ec4                          := add_ec4;
                    self.add_apt                          := add_apt;
                    self.phn_disconnected                 := phn_disconnected;
                    self.phn_inval                        := phn_inval;
                    self.phn_highrisk2                    := phn_highrisk2;
                    self.phn_notpots                      := phn_notpots;
                    self.phn_cell                         := phn_cell;
                    self.phn_zipmismatch                  := phn_zipmismatch;
                    self.phn_business                     := phn_business;
                    self.ssn_issued18                     := ssn_issued18;
                    self.ssn_deceased                     := ssn_deceased;
                    self.ssn_adl_prob                     := ssn_adl_prob;
                    self.email_src_im                     := email_src_im;
                    self.impulse_flag                     := impulse_flag;
                    self.bk_flag                          := bk_flag;
                    self.lien_rec_unrel_flag              := lien_rec_unrel_flag;
                    self.lien_hist_unrel_flag             := lien_hist_unrel_flag;
                    self.lien_flag                        := lien_flag;
                    self.pk_property_owner                := pk_property_owner;
                    self.pk_impulse_count                 := pk_impulse_count;
                    self.pk_yr_in_dob                     := pk_yr_in_dob;
                    self.pk_age_estimate                  := pk_age_estimate;
                    self.bs_attr_derog_flag               := bs_attr_derog_flag;
                    self.bs_attr_eviction_flag            := bs_attr_eviction_flag;
                    self.bs_attr_derog_flag2              := bs_attr_derog_flag2;
                    self.pk_222_flag                      := pk_222_flag;
                    self.pk_segment_40                    := pk_segment_40;
                    self.pk_age_estimate_s0               := pk_age_estimate_s0;
                    self.pk_age_estimate_s1               := pk_age_estimate_s1;
                    self.pk_age_estimate_s2               := pk_age_estimate_s2;
                    self.pk_age_estimate_s3               := pk_age_estimate_s3;
                    self.pk_estimated_income_s0           := pk_estimated_income_s0;
                    self.pk_estimated_income_s1           := pk_estimated_income_s1;
                    self.pk_estimated_income_s2           := pk_estimated_income_s2;
                    self.pk_estimated_income_s3           := pk_estimated_income_s3;
                    self.pk_add1_avm_auto_val_s0          := pk_add1_avm_auto_val_s0;
                    self.pk_add1_avm_auto_val_s1          := pk_add1_avm_auto_val_s1;
                    self.pk_add1_avm_auto_val_s2          := pk_add1_avm_auto_val_s2;
                    self.pk_add1_avm_auto_val_s3          := pk_add1_avm_auto_val_s3;
                    self.pk_verx_s0                       := pk_verx_s0;
                    self.pk_verx_s1                       := pk_verx_s1;
                    self.pk_verx_s3                       := pk_verx_s3;
                    self.inq_first_log_date2              := inq_first_log_date2;
                    self.yr_inq_first_log_date            := yr_inq_first_log_date;
                    self.mth_inq_first_log_date           := mth_inq_first_log_date;
                    self.pk_mth_inq_first_log_date        := pk_mth_inq_first_log_date;
                    self.pk_inq_recent_lvl                := pk_inq_recent_lvl;
                    self.pk_inq_recent_lvl_s0             := pk_inq_recent_lvl_s0;
                    self.pk_inq_recent_lvl_s1             := pk_inq_recent_lvl_s1;
                    self.pk_inq_recent_lvl_s3             := pk_inq_recent_lvl_s3;
                    self.pk_mth_inq_frst_log_dt2_s2       := pk_mth_inq_frst_log_dt2_s2;
                    self.pk_impulse_flag                  := pk_impulse_flag;
                    self.pk_inq_peradl                    := pk_inq_peradl;
                    self.pk_inq_peradl_s0                 := pk_inq_peradl_s0;
                    self.pk_inq_peraddr                   := pk_inq_peraddr;
                    self.pk_inq_adlsperphone              := pk_inq_adlsperphone;
                    self.pk_inq_adlsperphone_s0           := pk_inq_adlsperphone_s0;
                    self.pk_inq_adlsperphone_s3           := pk_inq_adlsperphone_s3;
                    self.pk_mth_header_first_seen         := pk_mth_header_first_seen;
                    self.pk_mth_hdr_frst_sn_s2            := pk_mth_hdr_frst_sn_s2;
                    self.pk_dob_ver                       := pk_dob_ver;
                    self.pk_attr_total_number_derogs      := pk_attr_total_number_derogs;
                    self.pk_crim_fel_flag                 := pk_crim_fel_flag;
                    self.pk_eviction_lvl                  := pk_eviction_lvl;
                    self.pk_unrel_lien_lvl                := pk_unrel_lien_lvl;
                    self.pk_adlperssn_count_s1            := pk_adlperssn_count_s1;
                    self.pk_adlperssn_count_s3            := pk_adlperssn_count_s3;
                    self.pk_ssns_per_adl_s1               := pk_ssns_per_adl_s1;
                    self.pk_ssns_per_adl_s2               := pk_ssns_per_adl_s2;
                    self.pk_ssns_per_adl_s3               := pk_ssns_per_adl_s3;
                    self.pk_addrs_per_ssn_c6_s0           := pk_addrs_per_ssn_c6_s0;
                    self.pk_addrs_per_ssn_c6_s1           := pk_addrs_per_ssn_c6_s1;
                    self.pk_addrs_per_ssn_c6_s2           := pk_addrs_per_ssn_c6_s2;
                    self.pk_addrs_per_ssn_c6_s3           := pk_addrs_per_ssn_c6_s3;
                    self.pk_ssns_per_adl_c6               := pk_ssns_per_adl_c6;
                    self.pk_phones_per_adl_c6_s3          := pk_phones_per_adl_c6_s3;
                    self.pk_adls_per_addr_c6_s2           := pk_adls_per_addr_c6_s2;
                    self.pk_ssns_per_addr_c6_s0           := pk_ssns_per_addr_c6_s0;
                    self.pk_ssns_per_addr_c6_s1           := pk_ssns_per_addr_c6_s1;
                    self.pk_ssns_per_addr_c6_s3           := pk_ssns_per_addr_c6_s3;
                    self.pk_phones_per_addr_c6            := pk_phones_per_addr_c6;
                    self.pk_adls_per_phone_c6             := pk_adls_per_phone_c6;
                    self.pk_attr_addrs_last12_s1          := pk_attr_addrs_last12_s1;
                    self.pk_attr_addrs_last24_s0          := pk_attr_addrs_last24_s0;
                    self.pk_attr_addrs_last36_s2          := pk_attr_addrs_last36_s2;
                    self.pk_attr_addrs_last36_s3          := pk_attr_addrs_last36_s3;
                    self.pk_recent_addr_s0                := pk_recent_addr_s0;
                    self.pk_recent_addr_s2                := pk_recent_addr_s2;
                    self.pk_phones_per_adl_s0             := pk_phones_per_adl_s0;
                    self.pk_ssns_per_addr                 := pk_ssns_per_addr;
                    self.pk_phones_per_addr_s0            := pk_phones_per_addr_s0;
                    self.pk_phones_per_addr_s2            := pk_phones_per_addr_s2;
                    self.pk_phones_per_addr_s3            := pk_phones_per_addr_s3;
                    self.pk_adls_per_phone                := pk_adls_per_phone;
                    self.pk_prof_lic_cat_s2               := pk_prof_lic_cat_s2;
                    self.pk_prof_lic_cat_s3               := pk_prof_lic_cat_s3;
                    self.pk_2nd_mortgage                  := pk_2nd_mortgage;
                    self.pk_baloon_mortgage               := pk_baloon_mortgage;
                    self.pk_adj_finance                   := pk_adj_finance;
                    self.pk_addrs_prison_history          := pk_addrs_prison_history;
                    self.pk_ver_src_p                     := pk_ver_src_p;
                    self.pk_prop_owned_purch_flag         := pk_prop_owned_purch_flag;
                    self.pk_add1_naprop4                  := pk_add1_naprop4;
                    self.pk_addrs_5yr_s0                  := pk_addrs_5yr_s0;
                    self.pk_addrs_5yr_s2                  := pk_addrs_5yr_s2;
                    self.pk_addrs_5yr_s3                  := pk_addrs_5yr_s3;
                    self.pk_email_count_s1                := pk_email_count_s1;
                    self.pk_email_domain_free_count_s2    := pk_email_domain_free_count_s2;
                    self.pk_email_domain_free_count_s3    := pk_email_domain_free_count_s3;
                    self.pk_add_apt1                      := pk_add_apt1;
                    self.pk_add_standarization_err        := pk_add_standarization_err;
                    self.pk_addr_changed                  := pk_addr_changed;
                    self.pk_unit_changed                  := pk_unit_changed;
                    self.pk_zip_po                        := pk_zip_po;
                    self.pk_zip_corp_mil                  := pk_zip_corp_mil;
                    self.pk_zip_hirisk_comm               := pk_zip_hirisk_comm;
                    self.pk_add_inval                     := pk_add_inval;
                    self.pk_add_apt2                      := pk_add_apt2;
                    self.pk_add_hirisk_comm               := pk_add_hirisk_comm;
                    self.pk_add1_advo_address_vacancy     := pk_add1_advo_address_vacancy;
                    self.pk_add1_advo_throw_back          := pk_add1_advo_throw_back;
                    self.pk_add1_advo_seasonal_delivery   := pk_add1_advo_seasonal_delivery;
                    self.pk_add1_advo_college             := pk_add1_advo_college;
                    self.pk_add1_advo_drop                := pk_add1_advo_drop;
                    self.pk_add1_advo_res_or_business     := pk_add1_advo_res_or_business;
                    self.pk_add1_advo_mixed_address_usage := pk_add1_advo_mixed_address_usage;
                    self.pk_addprob_s1                    := pk_addprob_s1;
                    self.pk_addprob_s2                    := pk_addprob_s2;
                    self.pk_addprob_s3                    := pk_addprob_s3;
                    self.pk_phn_nongeo                    := pk_phn_nongeo;
                    self.pk_phn_phn_not_issued            := pk_phn_phn_not_issued;
                    self.pk_phnprob_s2                    := pk_phnprob_s2;
                    self.pk_grad_student                  := pk_grad_student;
                    self.pk_ams_senior                    := pk_ams_senior;
                    self.pk_4yr_college                   := pk_4yr_college;
                    self.pk_college_tier_s0               := pk_college_tier_s0;
                    self.pk_college_tier_s1               := pk_college_tier_s1;
                    self.pk_college_tier_s2               := pk_college_tier_s2;
                    self.pk_contrary_infutor_ver          := pk_contrary_infutor_ver;
                    self.pk_num_nonderogs90_s0            := pk_num_nonderogs90_s0;
                    self.pk_mth_gong_did_fst_sn           := pk_mth_gong_did_fst_sn;
                    self.pk_mth_gong_did_fst_sn2_s0       := pk_mth_gong_did_fst_sn2_s0;
                    self.pk_mth_gong_did_fst_sn2_s1       := pk_mth_gong_did_fst_sn2_s1;
                    self.pk_mth_gong_did_fst_sn2_s2       := pk_mth_gong_did_fst_sn2_s2;
                    self.pk_mth_gong_did_fst_sn2_s3       := pk_mth_gong_did_fst_sn2_s3;
                    self.pk_mth_add1_date_fst_sn          := pk_mth_add1_date_fst_sn;
                    self.pk_mth_add1_date_fst_sn2_s3      := pk_mth_add1_date_fst_sn2_s3;
                    self.pk_mth_ver_src_fdate_en          := pk_mth_ver_src_fdate_en;
                    self.pk_mth_ver_src_fdate_eq          := pk_mth_ver_src_fdate_eq;
                    self.pk_mth_ver_src_fdate_bureau      := pk_mth_ver_src_fdate_bureau;
                    self.pk_too_young_at_bureau           := pk_too_young_at_bureau;
                    self.pk_addr_hist_advo_college        := pk_addr_hist_advo_college;
                    self.pk_add1_house_number_match       := pk_add1_house_number_match;
                    self.pk_nap_summary_ver_s1            := pk_nap_summary_ver_s1;
                    self.pk_pos_dob_src_minor             := pk_pos_dob_src_minor;
                    self.pk_pos_dob_src_minor_flag        := pk_pos_dob_src_minor_flag;
                    self.ver_dob_src_bureau               := ver_dob_src_bureau;
                    self.ver_dob_src_emerge               := ver_dob_src_emerge;
                    self.pk_pos_dob_src_major             := pk_pos_dob_src_major;
                    self.pk_pos_dob_src_cnt_s2            := pk_pos_dob_src_cnt_s2;
                    self.pk_mth_ver_src_ldate_en          := pk_mth_ver_src_ldate_en;
                    self.pk_mth_ver_src_ldate_eq          := pk_mth_ver_src_ldate_eq;
                    self.pk_mth_ver_src_ldate_bureau      := pk_mth_ver_src_ldate_bureau;
                    self.pk_time_on_cb                    := pk_time_on_cb;
                    self.pk_time_on_cb2_s1                := pk_time_on_cb2_s1;
                    self.pk_time_since_cb3                := pk_time_since_cb3;
                    self.pk_age_estimate_s0_0m            := pk_age_estimate_s0_0m;
                    self.pk_estimated_income_s0_0m        := pk_estimated_income_s0_0m;
                    self.pk_add1_avm_auto_val_s0_0m       := pk_add1_avm_auto_val_s0_0m;
                    self.pk_age_estimate_s1_1m            := pk_age_estimate_s1_1m;
                    self.pk_estimated_income_s1_1m        := pk_estimated_income_s1_1m;
                    self.pk_add1_avm_auto_val_s1_1m       := pk_add1_avm_auto_val_s1_1m;
                    self.pk_age_estimate_s2_2m            := pk_age_estimate_s2_2m;
                    self.pk_estimated_income_s2_2m        := pk_estimated_income_s2_2m;
                    self.pk_add1_avm_auto_val_s2_2m       := pk_add1_avm_auto_val_s2_2m;
                    self.pk_age_estimate_s3_3m            := pk_age_estimate_s3_3m;
                    self.pk_estimated_income_s3_3m        := pk_estimated_income_s3_3m;
                    self.pk_add1_avm_auto_val_s3_3m       := pk_add1_avm_auto_val_s3_3m;
                    self.pk_verx_s0_0m                    := pk_verx_s0_0m;
                    self.pk_verx_s1_1m                    := pk_verx_s1_1m;
                    self.pk_verx_s3_3m                    := pk_verx_s3_3m;
                    self.pk_inq_recent_lvl_s0_0m          := pk_inq_recent_lvl_s0_0m;
                    self.pk_inq_peradl_s0_0m              := pk_inq_peradl_s0_0m;
                    self.pk_inq_adlsperphone_s0_0m        := pk_inq_adlsperphone_s0_0m;
                    self.pk_inq_recent_lvl_s1_1m          := pk_inq_recent_lvl_s1_1m;
                    self.pk_inq_peraddr_1m                := pk_inq_peraddr_1m;
                    self.pk_mth_inq_frst_log_dt2_s2_2m    := pk_mth_inq_frst_log_dt2_s2_2m;
                    self.pk_inq_recent_lvl_s3_3m          := pk_inq_recent_lvl_s3_3m;
                    self.pk_inq_peraddr_3m                := pk_inq_peraddr_3m;
                    self.pk_inq_adlsperphone_s3_3m        := pk_inq_adlsperphone_s3_3m;
                    self.pk_mth_hdr_frst_sn_s2_2m         := pk_mth_hdr_frst_sn_s2_2m;
                    self.pk_dob_ver_1m                    := pk_dob_ver_1m;
                    self.pk_dob_ver_3m                    := pk_dob_ver_3m;
                    self.pk_attr_total_number_derogs_0m   := pk_attr_total_number_derogs_0m;
                    self.pk_crim_fel_flag_0m              := pk_crim_fel_flag_0m;
                    self.pk_eviction_lvl_0m               := pk_eviction_lvl_0m;
                    self.pk_unrel_lien_lvl_0m             := pk_unrel_lien_lvl_0m;
                    self.bankrupt_0m                      := bankrupt_0m;
                    self.pk_addrs_per_ssn_c6_s0_0m        := pk_addrs_per_ssn_c6_s0_0m;
                    self.pk_ssns_per_adl_c6_0m            := pk_ssns_per_adl_c6_0m;
                    self.pk_ssns_per_addr_c6_s0_0m        := pk_ssns_per_addr_c6_s0_0m;
                    self.pk_attr_addrs_last24_s0_0m       := pk_attr_addrs_last24_s0_0m;
                    self.pk_recent_addr_s0_0m             := pk_recent_addr_s0_0m;
                    self.pk_phones_per_adl_s0_0m          := pk_phones_per_adl_s0_0m;
                    self.pk_ssns_per_addr_0m              := pk_ssns_per_addr_0m;
                    self.pk_phones_per_addr_s0_0m         := pk_phones_per_addr_s0_0m;
                    self.pk_adlperssn_count_s1_1m         := pk_adlperssn_count_s1_1m;
                    self.pk_ssns_per_adl_s1_1m            := pk_ssns_per_adl_s1_1m;
                    self.pk_addrs_per_ssn_c6_s1_1m        := pk_addrs_per_ssn_c6_s1_1m;
                    self.pk_ssns_per_adl_c6_1m            := pk_ssns_per_adl_c6_1m;
                    self.pk_ssns_per_addr_c6_s1_1m        := pk_ssns_per_addr_c6_s1_1m;
                    self.pk_phones_per_addr_c6_1m         := pk_phones_per_addr_c6_1m;
                    self.pk_attr_addrs_last12_s1_1m       := pk_attr_addrs_last12_s1_1m;
                    self.pk_ssns_per_adl_s2_2m            := pk_ssns_per_adl_s2_2m;
                    self.pk_addrs_per_ssn_c6_s2_2m        := pk_addrs_per_ssn_c6_s2_2m;
                    self.pk_adls_per_addr_c6_s2_2m        := pk_adls_per_addr_c6_s2_2m;
                    self.pk_adls_per_phone_c6_2m          := pk_adls_per_phone_c6_2m;
                    self.pk_attr_addrs_last36_s2_2m       := pk_attr_addrs_last36_s2_2m;
                    self.pk_recent_addr_s2_2m             := pk_recent_addr_s2_2m;
                    self.pk_ssns_per_addr_2m              := pk_ssns_per_addr_2m;
                    self.pk_phones_per_addr_s2_2m         := pk_phones_per_addr_s2_2m;
                    self.pk_adls_per_phone_2m             := pk_adls_per_phone_2m;
                    self.pk_adlperssn_count_s3_3m         := pk_adlperssn_count_s3_3m;
                    self.pk_ssns_per_adl_s3_3m            := pk_ssns_per_adl_s3_3m;
                    self.pk_addrs_per_ssn_c6_s3_3m        := pk_addrs_per_ssn_c6_s3_3m;
                    self.pk_phones_per_adl_c6_s3_3m       := pk_phones_per_adl_c6_s3_3m;
                    self.pk_ssns_per_addr_c6_s3_3m        := pk_ssns_per_addr_c6_s3_3m;
                    self.pk_phones_per_addr_c6_3m         := pk_phones_per_addr_c6_3m;
                    self.pk_attr_addrs_last36_s3_3m       := pk_attr_addrs_last36_s3_3m;
                    self.pk_phones_per_addr_s3_3m         := pk_phones_per_addr_s3_3m;
                    self.pk_adls_per_phone_3m             := pk_adls_per_phone_3m;
                    self.pk_prof_lic_cat_s2_2m            := pk_prof_lic_cat_s2_2m;
                    self.pk_prof_lic_cat_s3_3m            := pk_prof_lic_cat_s3_3m;
                    self.pk_ver_src_p_0m                  := pk_ver_src_p_0m;
                    self.pk_prop_owned_purch_flag_0m      := pk_prop_owned_purch_flag_0m;
                    self.pk_add1_naprop4_0m               := pk_add1_naprop4_0m;
                    self.pk_ver_src_p_1m                  := pk_ver_src_p_1m;
                    self.pk_add1_naprop4_1m               := pk_add1_naprop4_1m;
                    self.pk_ver_src_p_3m                  := pk_ver_src_p_3m;
                    self.pk_addrs_5yr_s0_0m               := pk_addrs_5yr_s0_0m;
                    self.pk_addrs_5yr_s2_2m               := pk_addrs_5yr_s2_2m;
                    self.pk_addrs_5yr_s3_3m               := pk_addrs_5yr_s3_3m;
                    self.pk_email_count_s1_1m             := pk_email_count_s1_1m;
                    self.pk_email_domain_free_count_s2_2m := pk_email_domain_free_count_s2_2m;
                    self.pk_email_domain_free_count_s3_3m := pk_email_domain_free_count_s3_3m;
                    self.ssn_adl_prob_0m                  := ssn_adl_prob_0m;
                    self.ssn_issued18_0m                  := ssn_issued18_0m;
                    self.pk_addprob_s1_1m                 := pk_addprob_s1_1m;
                    self.ssn_issued18_1m                  := ssn_issued18_1m;
                    self.pk_addprob_s2_2m                 := pk_addprob_s2_2m;
                    self.pk_phnprob_s2_2m                 := pk_phnprob_s2_2m;
                    self.pk_addprob_s3_3m                 := pk_addprob_s3_3m;
                    self.ssn_issued18_3m                  := ssn_issued18_3m;
                    self.pk_college_tier_s0_0m            := pk_college_tier_s0_0m;
                    self.pk_grad_student_1m               := pk_grad_student_1m;
                    self.pk_ams_senior_1m                 := pk_ams_senior_1m;
                    self.pk_college_tier_s1_1m            := pk_college_tier_s1_1m;
                    self.pk_grad_student_2m               := pk_grad_student_2m;
                    self.pk_college_tier_s2_2m            := pk_college_tier_s2_2m;
                    self.pk_4yr_college_3m                := pk_4yr_college_3m;
                    self.pk_contrary_infutor_ver_1m       := pk_contrary_infutor_ver_1m;
                    self.pk_contrary_infutor_ver_2m       := pk_contrary_infutor_ver_2m;
                    self.pk_contrary_infutor_ver_3m       := pk_contrary_infutor_ver_3m;
                    self.pk_num_nonderogs90_s0_0m         := pk_num_nonderogs90_s0_0m;
                    self.pk_mth_gong_did_fst_sn2_s0_0m    := pk_mth_gong_did_fst_sn2_s0_0m;
                    self.pk_mth_gong_did_fst_sn2_s1_1m    := pk_mth_gong_did_fst_sn2_s1_1m;
                    self.pk_too_young_at_bureau_1m        := pk_too_young_at_bureau_1m;
                    self.pk_addr_hist_advo_college_1m     := pk_addr_hist_advo_college_1m;
                    self.pk_nap_summary_ver_s1_1m         := pk_nap_summary_ver_s1_1m;
                    self.pk_mth_gong_did_fst_sn2_s2_2m    := pk_mth_gong_did_fst_sn2_s2_2m;
                    self.pk_addr_hist_advo_college_2m     := pk_addr_hist_advo_college_2m;
                    self.pk_add1_house_number_match_2m    := pk_add1_house_number_match_2m;
                    self.pk_mth_gong_did_fst_sn2_s3_3m    := pk_mth_gong_did_fst_sn2_s3_3m;
                    self.pk_mth_add1_date_fst_sn2_s3_3m   := pk_mth_add1_date_fst_sn2_s3_3m;
                    self.pk_addr_hist_advo_college_3m     := pk_addr_hist_advo_college_3m;
                    self.pk_add1_house_number_match_3m    := pk_add1_house_number_match_3m;
                    self.pk_time_on_cb2_s1_1m             := pk_time_on_cb2_s1_1m;
                    self.pk_time_since_cb3_1m             := pk_time_since_cb3_1m;
                    self.pk_pos_dob_src_cnt_s2_2m         := pk_pos_dob_src_cnt_s2_2m;
                    self.derog_mod_0m                     := derog_mod_0m;
                    self.prop_owner_mod_0m                := prop_owner_mod_0m;
                    self.prop_owner_mod_1m                := prop_owner_mod_1m;
                    self.prop_owner_mod_3m                := prop_owner_mod_3m;
                    self.financing_mod_0m                 := financing_mod_0m;
                    self.financing_mod_2m                 := financing_mod_2m;
                    self.financing_mod_3m                 := financing_mod_3m;
                    self.email_mod_1m                     := email_mod_1m;
                    self.email_mod_2m                     := email_mod_2m;
                    self.email_mod_3m                     := email_mod_3m;
                    self.fp_mod2_1m                       := fp_mod2_1m;
                    self.ams_mod_0m                       := ams_mod_0m;
                    self.ams_mod_1m                       := ams_mod_1m;
                    self.ams_mod_2m                       := ams_mod_2m;
                    self.ams_mod_3m                       := ams_mod_3m;
                    self.inquiry_mod_0m                   := inquiry_mod_0m;
                    self.inquiry_mod_1m                   := inquiry_mod_1m;
                    self.inquiry_mod_2m                   := inquiry_mod_2m;
                    self.inquiry_mod_3m                   := inquiry_mod_3m;
                    self.velo_mod_0m                      := velo_mod_0m;
                    self.velo_mod_1m                      := velo_mod_1m;
                    self.velo_mod_2m                      := velo_mod_2m;
                    self.velo_mod_3m                      := velo_mod_3m;
                    self.mod8_0m                          := mod8_0m;
                    self.mod8_1m                          := mod8_1m;
                    self.mod8_2m                          := mod8_2m;
                    self.mod8_3m                          := mod8_3m;
                    self.mod8_nodob_0m                    := mod8_nodob_0m;
                    self.mod8_nodob_1m                    := mod8_nodob_1m;
                    self.mod8_nodob_2m                    := mod8_nodob_2m;
                    self.mod8_nodob_3m                    := mod8_nodob_3m;
                    self.mod8_nodob                       := mod8_nodob;
                    self.mod8                             := mod8;
                    self.mod8_phat                        := mod8_phat;
                    self.mod8_scr                         := mod8_scr;
                    self.mod8_nodob_phat                  := mod8_nodob_phat;
                    self.mod8_nodob_scr                   := mod8_nodob_scr;
                    self.rvb1104a                         := rvb1104a;
                    self.rvb1104b                         := rvb1104b;
                    self.ov_ssndead                       := ov_ssndead;
                    self.ov_ssnprior                      := ov_ssnprior;
                    self.ov_criminal_flag                 := ov_criminal_flag;
                    self.ov_corrections                   := ov_corrections;
                    self.ov_impulse                       := ov_impulse;
                    self.rvb1104c                         := rvb1104c;
                    self.scored_222s                      := scored_222s;
                    self.rvb1104d                         := rvb1104d;
                    self.rvb1104e                         := rvb1104e;
                    self.rvb1104                          := rvb1104;
                    self.pk_em_domain_free_count_s2_2m    := pk_em_domain_free_count_s2_2m;
                    self.pk_em_domain_free_count_s3_3m    := pk_em_domain_free_count_s3_3m;
                    self.add1_assessed_amount             := add1_assessed_amount;
                    self.glrc25                           := glrc25;
                    self.glrc28                           := glrc28;
                    self.glrc36                           := glrc36;
                    self.glrc97                           := glrc97;
                    self.glrc98                           := glrc98;
                    self.glrc99                           := glrc99;
                    self.glrc9a                           := glrc9a;
                    self.glrc9c                           := glrc9c;
                    self.glrc9d                           := glrc9d;
                    self.glrc9e                           := glrc9e;
                    self.glrc9g                           := glrc9g;
                    self.glrc9h                           := glrc9h;
                    self.glrc9j                           := glrc9j;
                    self.glrc9m                           := glrc9m;
                    self.glrc9n                           := glrc9n;
                    self.glrc9q                           := glrc9q;
                    self.glrc9r                           := glrc9r;
                    self.glrc9s                           := glrc9s;
                    self.glrc9t                           := glrc9t;
                    self.glrc9u                           := glrc9u;
                    self.glrc9w                           := glrc9w;
                    self.glrcev                           := glrcev;
                    self.glrcmi                           := glrcmi;
                    self.glrcms                           := glrcms;
                    self.aptflag                          := aptflag;
                    self.add1_econval                     := add1_econval;
                    self.add1_aptval                      := add1_aptval;
                    self.add1_econcode                    := add1_econcode;
                    self.glrcpv                           := glrcpv;
                    self.glrcx11                          := glrcx11;
                    self.header_last_seen2                := header_last_seen2;
                    self.yr_header_last_seen              := yr_header_last_seen;
                    self.mth_header_last_seen             := mth_header_last_seen;
                    self.pk_mth_header_last_seen          := pk_mth_header_last_seen;
                    self.glrc9f                           := glrc9f;
                    self._36                              := _36;
                    self._ev                              := _ev;
                    self._9s                              := _9s;
                    self._25                              := _25;
                    self._28                              := _28;
                    self._9g                              := _9g;
                    self._9h                              := _9h;
                    self._99                              := _99;
                    self._ms                              := _ms;
                    self._9d                              := _9d;
                    self._9t                              := _9t;
                    self._9m                              := _9m;
                    self._9q                              := _9q;
                    self._9j                              := _9j;
                    self._x11                             := _x11;
                    self._mi                              := _mi;
                    self._97                              := _97;
                    self._9r                              := _9r;
                    self._9f                              := _9f;
                    self._9a                              := _9a;
                    self._9u                              := _9u;
                    self._9w                              := _9w;
                    self._pv                              := _pv;
                    self._98                              := _98;
                    self._9n                              := _9n;
                    self._9c                              := _9c;
                    self._9e                              := _9e;
                    self.rc1                              := rcs_override[1].rc;
		                self.rc2                              := rcs_override[2].rc;
                    self.rc3                              := rcs_override[3].rc;
		                self.rc4                              := rcs_override[4].rc;
		                self.rc5                              := rcs_override[5].rc;
                    // self.rv40_rc4                         := rv40_rc4;
                    // self.rv40_rc5                         := rv40_rc5;
                    // self.rv40_rc1                         := rv40_rc1;
                    // self.rv40_rc2                         := rv40_rc2;
                    // self.rv40_rc3                         := rv40_rc3;
	                 self.clam															:= le;

#end
		SELF.ri := PROJECT(reasons, TRANSFORM(Risk_Indicators.Layout_Desc,
																							SELF.hri := if(LEFT.hri='', '00', left.hri),
																							SELF.desc := Risk_Indicators.getHRIDesc(LEFT.hri)
																					));
		self.seq := le.seq;
		self.score := if(reasons[1].hri IN ['91','92','93','94'],(STRING3)((INTEGER)reasons[1].hri + 10),(string3)rvb1104);
END;

		model := project( clam, doModel(left) );

		return model;

END;
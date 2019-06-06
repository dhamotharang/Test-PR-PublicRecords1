import Std, risk_indicators, riskwise, riskwisefcra, ut, Models;

//blank_ip := dataset( [{0}], riskwise.Layout_IP2O )[1];

bs_with_ip := record
	risk_indicators.Layout_Boca_Shell bs;
	riskwise.Layout_IP2O ip;
end;

									
		// FP_DEBUG := True;
		FP_DEBUG := False;
		
		isFCRA := False;
    

 //export FP3710_0_0(
	// dataset(bs_with_ip) clam,
	// integer num_reasons = 6,
	// boolean criminal = false
// ) := FUNCTION
 export FP1902_1_0(
                 dataset(bs_with_ip) clam_ip,
                 integer1 num_reasons)
									 := FUNCTION
 // dataset(bs_with_ip) clam,
	 // integer num_reasons = 6,
	 // boolean criminal = false
                          // ) := FUNCTION


	#if(FP_DEBUG)
	Layout_Debug := RECORD
  /* Model Input Variables */
                    INTEGER  sysdate                          ;     //:=sysdate;
                    INTEGER  sysdate8                         ;     //:=sysdate8;
                    INTEGER  ver_src_am_pos                   ;     //:=ver_src_am_pos;
                    BOOLEAN  ver_src_am                       ;     //:=ver_src_am;
                    string  _ver_src_fdate_am                ;     //:=_ver_src_fdate_am;
                    INTEGER  ver_src_fdate_am                 ;     //:=ver_src_fdate_am;
                    INTEGER  ver_src_ar_pos                   ;     //:=ver_src_ar_pos;
                    BOOLEAN  ver_src_ar                       ;     //:=ver_src_ar;
                    string  _ver_src_fdate_ar                ;     //:=_ver_src_fdate_ar;
                    INTEGER  ver_src_fdate_ar                 ;     //:=ver_src_fdate_ar;
                    INTEGER  ver_src_ba_pos                   ;     //:=ver_src_ba_pos;
                    BOOLEAN  ver_src_ba                       ;     //:=ver_src_ba;
                    string  _ver_src_fdate_ba                ;     //:=_ver_src_fdate_ba;
                    INTEGER  ver_src_fdate_ba                 ;     //:=ver_src_fdate_ba;
                    INTEGER  ver_src_cg_pos                   ;     //:=ver_src_cg_pos;
                    BOOLEAN  ver_src_cg                       ;     //:=ver_src_cg;
                    string  _ver_src_fdate_cg                ;     //:=_ver_src_fdate_cg;
                    INTEGER  ver_src_fdate_cg                 ;     //:=ver_src_fdate_cg;
                    INTEGER  ver_src_da_pos                   ;     //:=ver_src_da_pos;
                    BOOLEAN  ver_src_da                       ;     //:=ver_src_da;
                    string  _ver_src_fdate_da                ;     //:=_ver_src_fdate_da;
                    INTEGER  ver_src_fdate_da                 ;     //:=ver_src_fdate_da;
                    INTEGER  ver_src_d_pos                    ;     //:=ver_src_d_pos;
                    BOOLEAN  ver_src_d                        ;     //:=ver_src_d;
                    string  _ver_src_fdate_d                 ;     //:=_ver_src_fdate_d;
                    INTEGER  ver_src_fdate_d                  ;     //:=ver_src_fdate_d;
                    INTEGER  ver_src_dl_pos                   ;     //:=ver_src_dl_pos;
                    BOOLEAN  ver_src_dl                       ;     //:=ver_src_dl;
                    string  _ver_src_fdate_dl                ;     //:=_ver_src_fdate_dl;
                    INTEGER  ver_src_fdate_dl                 ;     //:=ver_src_fdate_dl;
                    INTEGER  ver_src_eb_pos                   ;     //:=ver_src_eb_pos;
                    BOOLEAN  ver_src_eb                       ;     //:=ver_src_eb;
                    string  _ver_src_fdate_eb                ;     //:=_ver_src_fdate_eb;
                    INTEGER  ver_src_fdate_eb                 ;     //:=ver_src_fdate_eb;
                    INTEGER  ver_src_e1_pos                   ;     //:=ver_src_e1_pos;
                    BOOLEAN  ver_src_e1                       ;     //:=ver_src_e1;
                    string  _ver_src_fdate_e1                ;     //:=_ver_src_fdate_e1;
                    INTEGER  ver_src_fdate_e1                 ;     //:=ver_src_fdate_e1;
                    INTEGER  ver_src_e2_pos                   ;     //:=ver_src_e2_pos;
                    BOOLEAN  ver_src_e2                       ;     //:=ver_src_e2;
                    string  _ver_src_fdate_e2                ;     //:=_ver_src_fdate_e2;
                    INTEGER  ver_src_fdate_e2                 ;     //:=ver_src_fdate_e2;
                    INTEGER  ver_src_e3_pos                   ;     //:=ver_src_e3_pos;
                    BOOLEAN  ver_src_e3                       ;     //:=ver_src_e3;
                    string  _ver_src_fdate_e3                ;     //:=_ver_src_fdate_e3;
                    INTEGER  ver_src_fdate_e3                 ;     //:=ver_src_fdate_e3;
                    INTEGER  ver_src_en_pos                   ;     //:=ver_src_en_pos;
                    BOOLEAN  ver_src_en                       ;     //:=ver_src_en;
                    string  _ver_src_fdate_en                ;     //:=_ver_src_fdate_en;
                    INTEGER  ver_src_fdate_en                 ;     //:=ver_src_fdate_en;
                    INTEGER  ver_src_eq_pos                   ;     //:=ver_src_eq_pos;
                    BOOLEAN  ver_src_eq                       ;     //:=ver_src_eq;
                    string  _ver_src_fdate_eq                ;     //:=_ver_src_fdate_eq;
                    INTEGER  ver_src_fdate_eq                 ;     //:=ver_src_fdate_eq;
                    INTEGER  ver_src_fe_pos                   ;     //:=ver_src_fe_pos;
                    BOOLEAN  ver_src_fe                       ;     //:=ver_src_fe;
                    string  _ver_src_fdate_fe                ;     //:=_ver_src_fdate_fe;
                    INTEGER  ver_src_fdate_fe                 ;     //:=ver_src_fdate_fe;
                    INTEGER  ver_src_ff_pos                   ;     //:=ver_src_ff_pos;
                    BOOLEAN  ver_src_ff                       ;     //:=ver_src_ff;
                    string  _ver_src_fdate_ff                ;     //:=_ver_src_fdate_ff;
                    INTEGER  ver_src_fdate_ff                 ;     //:=ver_src_fdate_ff;
                    INTEGER  ver_src_p_pos                    ;     //:=ver_src_p_pos;
                    BOOLEAN  ver_src_p                        ;     //:=ver_src_p;
                    string  _ver_src_fdate_p                 ;     //:=_ver_src_fdate_p;
                    INTEGER  ver_src_fdate_p                  ;     //:=ver_src_fdate_p;
                    INTEGER  ver_src_pl_pos                   ;     //:=ver_src_pl_pos;
                    BOOLEAN  ver_src_pl                       ;     //:=ver_src_pl;
                    string  _ver_src_fdate_pl                ;     //:=_ver_src_fdate_pl;
                    INTEGER  ver_src_fdate_pl                 ;     //:=ver_src_fdate_pl;
                    INTEGER  ver_src_tn_pos                   ;     //:=ver_src_tn_pos;
                    BOOLEAN  ver_src_tn                       ;     //:=ver_src_tn;
                    string  _ver_src_fdate_tn                ;     //:=_ver_src_fdate_tn;
                    INTEGER  ver_src_fdate_tn                 ;     //:=ver_src_fdate_tn;
                    INTEGER  ver_src_sl_pos                   ;     //:=ver_src_sl_pos;
                    BOOLEAN  ver_src_sl                       ;     //:=ver_src_sl;
                    string  _ver_src_fdate_sl                ;     //:=_ver_src_fdate_sl;
                    INTEGER  ver_src_fdate_sl                 ;     //:=ver_src_fdate_sl;
                    INTEGER  ver_src_v_pos                    ;     //:=ver_src_v_pos;
                    BOOLEAN  ver_src_v                        ;     //:=ver_src_v;
                    string  _ver_src_fdate_v                 ;     //:=_ver_src_fdate_v;
                    INTEGER  ver_src_fdate_v                  ;     //:=ver_src_fdate_v;
                    INTEGER  ver_src_vo_pos                   ;     //:=ver_src_vo_pos;
                    BOOLEAN  ver_src_vo                       ;     //:=ver_src_vo;
                    string  _ver_src_fdate_vo                ;     //:=_ver_src_fdate_vo;
                    INTEGER  ver_src_fdate_vo                 ;     //:=ver_src_fdate_vo;
                    INTEGER  ver_src_w_pos                    ;     //:=ver_src_w_pos;
                    BOOLEAN  ver_src_w                        ;     //:=ver_src_w;
                    string  _ver_src_fdate_w                 ;     //:=_ver_src_fdate_w;
                    INTEGER  ver_src_fdate_w                  ;     //:=ver_src_fdate_w;
                    INTEGER  ver_fname_src_en_pos             ;     //:=ver_fname_src_en_pos;
                    BOOLEAN  ver_fname_src_en                 ;     //:=ver_fname_src_en;
                    INTEGER  ver_fname_src_eq_pos             ;     //:=ver_fname_src_eq_pos;
                    BOOLEAN  ver_fname_src_eq                 ;     //:=ver_fname_src_eq;
                    INTEGER  ver_fname_src_tn_pos             ;     //:=ver_fname_src_tn_pos;
                    BOOLEAN  ver_fname_src_tn                 ;     //:=ver_fname_src_tn;
                    INTEGER  ver_fname_src_ts_pos             ;     //:=ver_fname_src_ts_pos;
                    BOOLEAN  ver_fname_src_ts                 ;     //:=ver_fname_src_ts;
                    INTEGER  ver_fname_src_tu_pos             ;     //:=ver_fname_src_tu_pos;
                    BOOLEAN  ver_fname_src_tu                 ;     //:=ver_fname_src_tu;
                    INTEGER  ver_lname_src_en_pos             ;     //:=ver_lname_src_en_pos;
                    BOOLEAN  ver_lname_src_en                 ;     //:=ver_lname_src_en;
                    INTEGER  ver_lname_src_eq_pos             ;     //:=ver_lname_src_eq_pos;
                    BOOLEAN  ver_lname_src_eq                 ;     //:=ver_lname_src_eq;
                    INTEGER  ver_lname_src_tn_pos             ;     //:=ver_lname_src_tn_pos;
                    BOOLEAN  ver_lname_src_tn                 ;     //:=ver_lname_src_tn;
                    INTEGER  ver_lname_src_ts_pos             ;     //:=ver_lname_src_ts_pos;
                    BOOLEAN  ver_lname_src_ts                 ;     //:=ver_lname_src_ts;
                    INTEGER  ver_lname_src_tu_pos             ;     //:=ver_lname_src_tu_pos;
                    BOOLEAN  ver_lname_src_tu                 ;     //:=ver_lname_src_tu;
                    INTEGER  ver_addr_src_en_pos              ;     //:=ver_addr_src_en_pos;
                    BOOLEAN  ver_addr_src_en                  ;     //:=ver_addr_src_en;
                    INTEGER  ver_addr_src_eq_pos              ;     //:=ver_addr_src_eq_pos;
                    BOOLEAN  ver_addr_src_eq                  ;     //:=ver_addr_src_eq;
                    INTEGER  ver_addr_src_tn_pos              ;     //:=ver_addr_src_tn_pos;
                    BOOLEAN  ver_addr_src_tn                  ;     //:=ver_addr_src_tn;
                    INTEGER  ver_addr_src_ts_pos              ;     //:=ver_addr_src_ts_pos;
                    BOOLEAN  ver_addr_src_ts                  ;     //:=ver_addr_src_ts;
                    INTEGER  ver_addr_src_tu_pos              ;     //:=ver_addr_src_tu_pos;
                    BOOLEAN  ver_addr_src_tu                  ;     //:=ver_addr_src_tu;
                    INTEGER  ver_ssn_src_en_pos               ;     //:=ver_ssn_src_en_pos;
                    BOOLEAN  ver_ssn_src_en                   ;     //:=ver_ssn_src_en;
                    INTEGER  ver_ssn_src_eq_pos               ;     //:=ver_ssn_src_eq_pos;
                    BOOLEAN  ver_ssn_src_eq                   ;     //:=ver_ssn_src_eq;
                    INTEGER  ver_ssn_src_tn_pos               ;     //:=ver_ssn_src_tn_pos;
                    BOOLEAN  ver_ssn_src_tn                   ;     //:=ver_ssn_src_tn;
                    INTEGER  ver_ssn_src_ts_pos               ;     //:=ver_ssn_src_ts_pos;
                    BOOLEAN  ver_ssn_src_ts                   ;     //:=ver_ssn_src_ts;
                    INTEGER  ver_ssn_src_tu_pos               ;     //:=ver_ssn_src_tu_pos;
                    BOOLEAN  ver_ssn_src_tu                   ;     //:=ver_ssn_src_tu;
                    INTEGER  ver_dob_src_en_pos               ;     //:=ver_dob_src_en_pos;
                    BOOLEAN  ver_dob_src_en                   ;     //:=ver_dob_src_en;
                    INTEGER  ver_dob_src_eq_pos               ;     //:=ver_dob_src_eq_pos;
                    BOOLEAN  ver_dob_src_eq                   ;     //:=ver_dob_src_eq;
                    INTEGER  ver_dob_src_tn_pos               ;     //:=ver_dob_src_tn_pos;
                    BOOLEAN  ver_dob_src_tn                   ;     //:=ver_dob_src_tn;
                    INTEGER  ver_dob_src_ts_pos               ;     //:=ver_dob_src_ts_pos;
                    BOOLEAN  ver_dob_src_ts                   ;     //:=ver_dob_src_ts;
                    INTEGER  ver_dob_src_tu_pos               ;     //:=ver_dob_src_tu_pos;
                    BOOLEAN  ver_dob_src_tu                   ;     //:=ver_dob_src_tu;
                    INTEGER  util_type_2_pos                  ;     //:=util_type_2_pos;
                    boolean  util_type_2                      ;     //:=util_type_2;
                    INTEGER  util_type_1_pos                  ;     //:=util_type_1_pos;
                    BOOLEAN  util_type_1                      ;     //:=util_type_1;
                    INTEGER  util_type_z_pos                  ;     //:=util_type_z_pos;
                    BOOLEAN  util_type_z                      ;     //:=util_type_z;
                    INTEGER  util_inp_2_pos                   ;     //:=util_inp_2_pos;
                    BOOLEAN  util_inp_2                       ;     //:=util_inp_2;
                    INTEGER  util_inp_1_pos                   ;     //:=util_inp_1_pos;
                    BOOLEAN  util_inp_1                       ;     //:=util_inp_1;
                    INTEGER  util_inp_z_pos                   ;     //:=util_inp_z_pos;
                    BOOLEAN  util_inp_z                       ;     //:=util_inp_z;
                    INTEGER  util_curr_2_pos                  ;     //:=util_curr_2_pos;
                    BOOLEAN  util_curr_2                      ;     //:=util_curr_2;
                    INTEGER  util_curr_1_pos                  ;     //:=util_curr_1_pos;
                    BOOLEAN  util_curr_1                      ;     //:=util_curr_1;
                    INTEGER  util_curr_z_pos                  ;     //:=util_curr_z_pos;
                    BOOLEAN  util_curr_z                      ;     //:=util_curr_z;
                    INTEGER  bs_ver_src_ar_pos                ;     //:=bs_ver_src_ar_pos;
                    string  _bs_ver_src_fdate_ar             ;     //:=_bs_ver_src_fdate_ar;
                    INTEGER  bs_ver_src_fdate_ar              ;     //:=bs_ver_src_fdate_ar;
                    string  _bs_ver_src_ldate_ar             ;     //:=_bs_ver_src_ldate_ar;
                    INTEGER  bs_ver_src_ldate_ar              ;     //:=bs_ver_src_ldate_ar;
                    INTEGER  bs_ver_src_ba_pos                ;     //:=bs_ver_src_ba_pos;
                    string  _bs_ver_src_fdate_ba             ;     //:=_bs_ver_src_fdate_ba;
                    INTEGER  bs_ver_src_fdate_ba              ;     //:=bs_ver_src_fdate_ba;
                    string  _bs_ver_src_ldate_ba             ;     //:=_bs_ver_src_ldate_ba;
                    INTEGER  bs_ver_src_ldate_ba              ;     //:=bs_ver_src_ldate_ba;
                    INTEGER  bs_ver_src_bc_pos                ;     //:=bs_ver_src_bc_pos;
                    string  _bs_ver_src_fdate_bc             ;     //:=_bs_ver_src_fdate_bc;
                    INTEGER  bs_ver_src_fdate_bc              ;     //:=bs_ver_src_fdate_bc;
                    string  _bs_ver_src_ldate_bc             ;     //:=_bs_ver_src_ldate_bc;
                    INTEGER  bs_ver_src_ldate_bc              ;     //:=bs_ver_src_ldate_bc;
                    INTEGER  bs_ver_src_bm_pos                ;     //:=bs_ver_src_bm_pos;
                    string  _bs_ver_src_fdate_bm             ;     //:=_bs_ver_src_fdate_bm;
                    INTEGER  bs_ver_src_fdate_bm              ;     //:=bs_ver_src_fdate_bm;
                    string  _bs_ver_src_ldate_bm             ;     //:=_bs_ver_src_ldate_bm;
                    INTEGER  bs_ver_src_ldate_bm              ;     //:=bs_ver_src_ldate_bm;
                    INTEGER  bs_ver_src_bn_pos                ;     //:=bs_ver_src_bn_pos;
                    string  _bs_ver_src_fdate_bn             ;     //:=_bs_ver_src_fdate_bn;
                    INTEGER  bs_ver_src_fdate_bn              ;     //:=bs_ver_src_fdate_bn;
                    string  _bs_ver_src_ldate_bn             ;     //:=_bs_ver_src_ldate_bn;
                    INTEGER  bs_ver_src_ldate_bn              ;     //:=bs_ver_src_ldate_bn;
                    INTEGER  bs_ver_src_br_pos                ;     //:=bs_ver_src_br_pos;
                    string  _bs_ver_src_fdate_br             ;     //:=_bs_ver_src_fdate_br;
                    INTEGER  bs_ver_src_fdate_br              ;     //:=bs_ver_src_fdate_br;
                    string  _bs_ver_src_ldate_br             ;     //:=_bs_ver_src_ldate_br;
                    INTEGER  bs_ver_src_ldate_br              ;     //:=bs_ver_src_ldate_br;
                    INTEGER  bs_ver_src_by_pos                ;     //:=bs_ver_src_by_pos;
                    string  _bs_ver_src_fdate_by             ;     //:=_bs_ver_src_fdate_by;
                    INTEGER  bs_ver_src_fdate_by              ;     //:=bs_ver_src_fdate_by;
                    string  _bs_ver_src_ldate_by             ;     //:=_bs_ver_src_ldate_by;
                    INTEGER  bs_ver_src_ldate_by              ;     //:=bs_ver_src_ldate_by;
                    INTEGER  bs_ver_src_c_pos                 ;     //:=bs_ver_src_c_pos;
                    string  _bs_ver_src_fdate_c              ;     //:=_bs_ver_src_fdate_c;
                    INTEGER  bs_ver_src_fdate_c               ;     //:=bs_ver_src_fdate_c;
                    string  _bs_ver_src_ldate_c              ;     //:=_bs_ver_src_ldate_c;
                    INTEGER  bs_ver_src_ldate_c               ;     //:=bs_ver_src_ldate_c;
                    INTEGER  bs_ver_src_cs_pos                ;     //:=bs_ver_src_cs_pos;
                    string  _bs_ver_src_fdate_cs             ;     //:=_bs_ver_src_fdate_cs;
                    INTEGER  bs_ver_src_fdate_cs              ;     //:=bs_ver_src_fdate_cs;
                    string  _bs_ver_src_ldate_cs             ;     //:=_bs_ver_src_ldate_cs;
                    INTEGER  bs_ver_src_ldate_cs              ;     //:=bs_ver_src_ldate_cs;
                    INTEGER  bs_ver_src_cf_pos                ;     //:=bs_ver_src_cf_pos;
                    string  _bs_ver_src_fdate_cf             ;     //:=_bs_ver_src_fdate_cf;
                    INTEGER  bs_ver_src_fdate_cf              ;     //:=bs_ver_src_fdate_cf;
                    string  _bs_ver_src_ldate_cf             ;     //:=_bs_ver_src_ldate_cf;
                    INTEGER  bs_ver_src_ldate_cf              ;     //:=bs_ver_src_ldate_cf;
                    INTEGER  bs_ver_src_cu_pos                ;     //:=bs_ver_src_cu_pos;
                    string  _bs_ver_src_fdate_cu             ;     //:=_bs_ver_src_fdate_cu;
                    INTEGER  bs_ver_src_fdate_cu              ;     //:=bs_ver_src_fdate_cu;
                    string  _bs_ver_src_ldate_cu             ;     //:=_bs_ver_src_ldate_cu;
                    INTEGER  bs_ver_src_ldate_cu              ;     //:=bs_ver_src_ldate_cu;
                    INTEGER  bs_ver_src_d_pos                 ;     //:=bs_ver_src_d_pos;
                    string  _bs_ver_src_fdate_d              ;     //:=_bs_ver_src_fdate_d;
                    INTEGER  bs_ver_src_fdate_d               ;     //:=bs_ver_src_fdate_d;
                    string  _bs_ver_src_ldate_d              ;     //:=_bs_ver_src_ldate_d;
                    INTEGER  bs_ver_src_ldate_d               ;     //:=bs_ver_src_ldate_d;
                    INTEGER  bs_ver_src_da_pos                ;     //:=bs_ver_src_da_pos;
                    string  _bs_ver_src_fdate_da             ;     //:=_bs_ver_src_fdate_da;
                    INTEGER  bs_ver_src_fdate_da              ;     //:=bs_ver_src_fdate_da;
                    string  _bs_ver_src_ldate_da             ;     //:=_bs_ver_src_ldate_da;
                    INTEGER  bs_ver_src_ldate_da              ;     //:=bs_ver_src_ldate_da;
                    INTEGER  bs_ver_src_df_pos                ;     //:=bs_ver_src_df_pos;
                    string  _bs_ver_src_fdate_df             ;     //:=_bs_ver_src_fdate_df;
                    INTEGER  bs_ver_src_fdate_df              ;     //:=bs_ver_src_fdate_df;
                    string  _bs_ver_src_ldate_df             ;     //:=_bs_ver_src_ldate_df;
                    INTEGER  bs_ver_src_ldate_df              ;     //:=bs_ver_src_ldate_df;
                    INTEGER  bs_ver_src_dn_pos                ;     //:=bs_ver_src_dn_pos;
                    string  _bs_ver_src_fdate_dn             ;     //:=_bs_ver_src_fdate_dn;
                    INTEGER  bs_ver_src_fdate_dn              ;     //:=bs_ver_src_fdate_dn;
                    string  _bs_ver_src_ldate_dn             ;     //:=_bs_ver_src_ldate_dn;
                    INTEGER  bs_ver_src_ldate_dn              ;     //:=bs_ver_src_ldate_dn;
                    INTEGER  bs_ver_src_e_pos                 ;     //:=bs_ver_src_e_pos;
                    string  _bs_ver_src_fdate_e              ;     //:=_bs_ver_src_fdate_e;
                    INTEGER  bs_ver_src_fdate_e               ;     //:=bs_ver_src_fdate_e;
                    string  _bs_ver_src_ldate_e              ;     //:=_bs_ver_src_ldate_e;
                    INTEGER  bs_ver_src_ldate_e               ;     //:=bs_ver_src_ldate_e;
                    INTEGER  bs_ver_src_ef_pos                ;     //:=bs_ver_src_ef_pos;
                    string  _bs_ver_src_fdate_ef             ;     //:=_bs_ver_src_fdate_ef;
                    INTEGER  bs_ver_src_fdate_ef              ;     //:=bs_ver_src_fdate_ef;
                    string  _bs_ver_src_ldate_ef             ;     //:=_bs_ver_src_ldate_ef;
                    INTEGER  bs_ver_src_ldate_ef              ;     //:=bs_ver_src_ldate_ef;
                    INTEGER  bs_ver_src_er_pos                ;     //:=bs_ver_src_er_pos;
                    string  _bs_ver_src_fdate_er             ;     //:=_bs_ver_src_fdate_er;
                    INTEGER  bs_ver_src_fdate_er              ;     //:=bs_ver_src_fdate_er;
                    string  _bs_ver_src_ldate_er             ;     //:=_bs_ver_src_ldate_er;
                    INTEGER  bs_ver_src_ldate_er              ;     //:=bs_ver_src_ldate_er;
                    INTEGER  bs_ver_src_ey_pos                ;     //:=bs_ver_src_ey_pos;
                    string  _bs_ver_src_fdate_ey             ;     //:=_bs_ver_src_fdate_ey;
                    INTEGER  bs_ver_src_fdate_ey              ;     //:=bs_ver_src_fdate_ey;
                    string  _bs_ver_src_ldate_ey             ;     //:=_bs_ver_src_ldate_ey;
                    INTEGER  bs_ver_src_ldate_ey              ;     //:=bs_ver_src_ldate_ey;
                    INTEGER  bs_ver_src_f_pos                 ;     //:=bs_ver_src_f_pos;
                    string  _bs_ver_src_fdate_f              ;     //:=_bs_ver_src_fdate_f;
                    INTEGER  bs_ver_src_fdate_f               ;     //:=bs_ver_src_fdate_f;
                    string  _bs_ver_src_ldate_f              ;     //:=_bs_ver_src_ldate_f;
                    INTEGER  bs_ver_src_ldate_f               ;     //:=bs_ver_src_ldate_f;
                    INTEGER  bs_ver_src_fb_pos                ;     //:=bs_ver_src_fb_pos;
                    string  _bs_ver_src_fdate_fb             ;     //:=_bs_ver_src_fdate_fb;
                    INTEGER  bs_ver_src_fdate_fb              ;     //:=bs_ver_src_fdate_fb;
                    string  _bs_ver_src_ldate_fb             ;     //:=_bs_ver_src_ldate_fb;
                    INTEGER  bs_ver_src_ldate_fb              ;     //:=bs_ver_src_ldate_fb;
                    INTEGER  bs_ver_src_fi_pos                ;     //:=bs_ver_src_fi_pos;
                    string  _bs_ver_src_fdate_fi             ;     //:=_bs_ver_src_fdate_fi;
                    INTEGER  bs_ver_src_fdate_fi              ;     //:=bs_ver_src_fdate_fi;
                    string  _bs_ver_src_ldate_fi             ;     //:=_bs_ver_src_ldate_fi;
                    INTEGER  bs_ver_src_ldate_fi              ;     //:=bs_ver_src_ldate_fi;
                    INTEGER  bs_ver_src_fk_pos                ;     //:=bs_ver_src_fk_pos;
                    string  _bs_ver_src_fdate_fk             ;     //:=_bs_ver_src_fdate_fk;
                    INTEGER  bs_ver_src_fdate_fk              ;     //:=bs_ver_src_fdate_fk;
                    string  _bs_ver_src_ldate_fk             ;     //:=_bs_ver_src_ldate_fk;
                    INTEGER  bs_ver_src_ldate_fk              ;     //:=bs_ver_src_ldate_fk;
                    INTEGER  bs_ver_src_fr_pos                ;     //:=bs_ver_src_fr_pos;
                    string  _bs_ver_src_fdate_fr             ;     //:=_bs_ver_src_fdate_fr;
                    INTEGER  bs_ver_src_fdate_fr              ;     //:=bs_ver_src_fdate_fr;
                    string  _bs_ver_src_ldate_fr             ;     //:=_bs_ver_src_ldate_fr;
                    INTEGER  bs_ver_src_ldate_fr              ;     //:=bs_ver_src_ldate_fr;
                    INTEGER  bs_ver_src_ft_pos                ;     //:=bs_ver_src_ft_pos;
                    string  _bs_ver_src_fdate_ft             ;     //:=_bs_ver_src_fdate_ft;
                    INTEGER  bs_ver_src_fdate_ft              ;     //:=bs_ver_src_fdate_ft;
                    string  _bs_ver_src_ldate_ft             ;     //:=_bs_ver_src_ldate_ft;
                    INTEGER  bs_ver_src_ldate_ft              ;     //:=bs_ver_src_ldate_ft;
                    INTEGER  bs_ver_src_gb_pos                ;     //:=bs_ver_src_gb_pos;
                    string  _bs_ver_src_fdate_gb             ;     //:=_bs_ver_src_fdate_gb;
                    INTEGER  bs_ver_src_fdate_gb              ;     //:=bs_ver_src_fdate_gb;
                    string  _bs_ver_src_ldate_gb             ;     //:=_bs_ver_src_ldate_gb;
                    INTEGER  bs_ver_src_ldate_gb              ;     //:=bs_ver_src_ldate_gb;
                    INTEGER  bs_ver_src_gr_pos                ;     //:=bs_ver_src_gr_pos;
                    string  _bs_ver_src_fdate_gr             ;     //:=_bs_ver_src_fdate_gr;
                    INTEGER  bs_ver_src_fdate_gr              ;     //:=bs_ver_src_fdate_gr;
                    string  _bs_ver_src_ldate_gr             ;     //:=_bs_ver_src_ldate_gr;
                    INTEGER  bs_ver_src_ldate_gr              ;     //:=bs_ver_src_ldate_gr;
                    INTEGER  bs_ver_src_h7_pos                ;     //:=bs_ver_src_h7_pos;
                    string  _bs_ver_src_fdate_h7             ;     //:=_bs_ver_src_fdate_h7;
                    INTEGER  bs_ver_src_fdate_h7              ;     //:=bs_ver_src_fdate_h7;
                    string  _bs_ver_src_ldate_h7             ;     //:=_bs_ver_src_ldate_h7;
                    INTEGER  bs_ver_src_ldate_h7              ;     //:=bs_ver_src_ldate_h7;
                    INTEGER  bs_ver_src_i_pos                 ;     //:=bs_ver_src_i_pos;
                    string  _bs_ver_src_fdate_i              ;     //:=_bs_ver_src_fdate_i;
                    INTEGER  bs_ver_src_fdate_i               ;     //:=bs_ver_src_fdate_i;
                    string  _bs_ver_src_ldate_i              ;     //:=_bs_ver_src_ldate_i;
                    INTEGER  bs_ver_src_ldate_i               ;     //:=bs_ver_src_ldate_i;
                    INTEGER  bs_ver_src_ia_pos                ;     //:=bs_ver_src_ia_pos;
                    string  _bs_ver_src_fdate_ia             ;     //:=_bs_ver_src_fdate_ia;
                    INTEGER  bs_ver_src_fdate_ia              ;     //:=bs_ver_src_fdate_ia;
                    string  _bs_ver_src_ldate_ia             ;     //:=_bs_ver_src_ldate_ia;
                    INTEGER  bs_ver_src_ldate_ia              ;     //:=bs_ver_src_ldate_ia;
                    INTEGER  bs_ver_src_ic_pos                ;     //:=bs_ver_src_ic_pos;
                    string  _bs_ver_src_fdate_ic             ;     //:=_bs_ver_src_fdate_ic;
                    INTEGER  bs_ver_src_fdate_ic              ;     //:=bs_ver_src_fdate_ic;
                    string  _bs_ver_src_ldate_ic             ;     //:=_bs_ver_src_ldate_ic;
                    INTEGER  bs_ver_src_ldate_ic              ;     //:=bs_ver_src_ldate_ic;
                    INTEGER  bs_ver_src_in_pos                ;     //:=bs_ver_src_in_pos;
                    string  _bs_ver_src_fdate_in             ;     //:=_bs_ver_src_fdate_in;
                    INTEGER  bs_ver_src_fdate_in              ;     //:=bs_ver_src_fdate_in;
                    string  _bs_ver_src_ldate_in             ;     //:=_bs_ver_src_ldate_in;
                    INTEGER  bs_ver_src_ldate_in              ;     //:=bs_ver_src_ldate_in;
                    INTEGER  bs_ver_src_ip_pos                ;     //:=bs_ver_src_ip_pos;
                    string  _bs_ver_src_fdate_ip             ;     //:=_bs_ver_src_fdate_ip;
                    INTEGER  bs_ver_src_fdate_ip              ;     //:=bs_ver_src_fdate_ip;
                    string  _bs_ver_src_ldate_ip             ;     //:=_bs_ver_src_ldate_ip;
                    INTEGER  bs_ver_src_ldate_ip              ;     //:=bs_ver_src_ldate_ip;
                    INTEGER  bs_ver_src_is_pos                ;     //:=bs_ver_src_is_pos;
                    string  _bs_ver_src_fdate_is             ;     //:=_bs_ver_src_fdate_is;
                    INTEGER  bs_ver_src_fdate_is              ;     //:=bs_ver_src_fdate_is;
                    string  _bs_ver_src_ldate_is             ;     //:=_bs_ver_src_ldate_is;
                    INTEGER  bs_ver_src_ldate_is              ;     //:=bs_ver_src_ldate_is;
                    INTEGER  bs_ver_src_it_pos                ;     //:=bs_ver_src_it_pos;
                    string  _bs_ver_src_fdate_it             ;     //:=_bs_ver_src_fdate_it;
                    INTEGER  bs_ver_src_fdate_it              ;     //:=bs_ver_src_fdate_it;
                    string  _bs_ver_src_ldate_it             ;     //:=_bs_ver_src_ldate_it;
                    INTEGER  bs_ver_src_ldate_it              ;     //:=bs_ver_src_ldate_it;
                    INTEGER  bs_ver_src_j2_pos                ;     //:=bs_ver_src_j2_pos;
                    string  _bs_ver_src_fdate_j2             ;     //:=_bs_ver_src_fdate_j2;
                    INTEGER  bs_ver_src_fdate_j2              ;     //:=bs_ver_src_fdate_j2;
                    string  _bs_ver_src_ldate_j2             ;     //:=_bs_ver_src_ldate_j2;
                    INTEGER  bs_ver_src_ldate_j2              ;     //:=bs_ver_src_ldate_j2;
                    INTEGER  bs_ver_src_kc_pos                ;     //:=bs_ver_src_kc_pos;
                    string  _bs_ver_src_fdate_kc             ;     //:=_bs_ver_src_fdate_kc;
                    INTEGER  bs_ver_src_fdate_kc              ;     //:=bs_ver_src_fdate_kc;
                    string  _bs_ver_src_ldate_kc             ;     //:=_bs_ver_src_ldate_kc;
                    INTEGER  bs_ver_src_ldate_kc              ;     //:=bs_ver_src_ldate_kc;
                    INTEGER  bs_ver_src_l0_pos                ;     //:=bs_ver_src_l0_pos;
                    string  _bs_ver_src_fdate_l0             ;     //:=_bs_ver_src_fdate_l0;
                    INTEGER  bs_ver_src_fdate_l0              ;     //:=bs_ver_src_fdate_l0;
                    string  _bs_ver_src_ldate_l0             ;     //:=_bs_ver_src_ldate_l0;
                    INTEGER  bs_ver_src_ldate_l0              ;     //:=bs_ver_src_ldate_l0;
                    INTEGER  bs_ver_src_l2_pos                ;     //:=bs_ver_src_l2_pos;
                    string  _bs_ver_src_fdate_l2             ;     //:=_bs_ver_src_fdate_l2;
                    INTEGER  bs_ver_src_fdate_l2              ;     //:=bs_ver_src_fdate_l2;
                    string  _bs_ver_src_ldate_l2             ;     //:=_bs_ver_src_ldate_l2;
                    INTEGER  bs_ver_src_ldate_l2              ;     //:=bs_ver_src_ldate_l2;
                    INTEGER  bs_ver_src_mh_pos                ;     //:=bs_ver_src_mh_pos;
                    string  _bs_ver_src_fdate_mh             ;     //:=_bs_ver_src_fdate_mh;
                    INTEGER  bs_ver_src_fdate_mh              ;     //:=bs_ver_src_fdate_mh;
                    string  _bs_ver_src_ldate_mh             ;     //:=_bs_ver_src_ldate_mh;
                    INTEGER  bs_ver_src_ldate_mh              ;     //:=bs_ver_src_ldate_mh;
                    INTEGER  bs_ver_src_mw_pos                ;     //:=bs_ver_src_mw_pos;
                    string  _bs_ver_src_fdate_mw             ;     //:=_bs_ver_src_fdate_mw;
                    INTEGER  bs_ver_src_fdate_mw              ;     //:=bs_ver_src_fdate_mw;
                    string  _bs_ver_src_ldate_mw             ;     //:=_bs_ver_src_ldate_mw;
                    INTEGER  bs_ver_src_ldate_mw              ;     //:=bs_ver_src_ldate_mw;
                    INTEGER  bs_ver_src_np_pos                ;     //:=bs_ver_src_np_pos;
                    string  _bs_ver_src_fdate_np             ;     //:=_bs_ver_src_fdate_np;
                    INTEGER  bs_ver_src_fdate_np              ;     //:=bs_ver_src_fdate_np;
                    string  _bs_ver_src_ldate_np             ;     //:=_bs_ver_src_ldate_np;
                    INTEGER  bs_ver_src_ldate_np              ;     //:=bs_ver_src_ldate_np;
                    INTEGER  bs_ver_src_nr_pos                ;     //:=bs_ver_src_nr_pos;
                    string  _bs_ver_src_fdate_nr             ;     //:=_bs_ver_src_fdate_nr;
                    INTEGER  bs_ver_src_fdate_nr              ;     //:=bs_ver_src_fdate_nr;
                    string  _bs_ver_src_ldate_nr             ;     //:=_bs_ver_src_ldate_nr;
                    INTEGER  bs_ver_src_ldate_nr              ;     //:=bs_ver_src_ldate_nr;
                    INTEGER  bs_ver_src_os_pos                ;     //:=bs_ver_src_os_pos;
                    string  _bs_ver_src_fdate_os             ;     //:=_bs_ver_src_fdate_os;
                    INTEGER  bs_ver_src_fdate_os              ;     //:=bs_ver_src_fdate_os;
                    string  _bs_ver_src_ldate_os             ;     //:=_bs_ver_src_ldate_os;
                    INTEGER  bs_ver_src_ldate_os              ;     //:=bs_ver_src_ldate_os;
                    INTEGER  bs_ver_src_p_pos                 ;     //:=bs_ver_src_p_pos;
                    string  _bs_ver_src_fdate_p              ;     //:=_bs_ver_src_fdate_p;
                    INTEGER  bs_ver_src_fdate_p               ;     //:=bs_ver_src_fdate_p;
                    string  _bs_ver_src_ldate_p              ;     //:=_bs_ver_src_ldate_p;
                    INTEGER  bs_ver_src_ldate_p               ;     //:=bs_ver_src_ldate_p;
                    INTEGER  bs_ver_src_pl_pos                ;     //:=bs_ver_src_pl_pos;
                    string  _bs_ver_src_fdate_pl             ;     //:=_bs_ver_src_fdate_pl;
                    INTEGER  bs_ver_src_fdate_pl              ;     //:=bs_ver_src_fdate_pl;
                    string  _bs_ver_src_ldate_pl             ;     //:=_bs_ver_src_ldate_pl;
                    INTEGER  bs_ver_src_ldate_pl              ;     //:=bs_ver_src_ldate_pl;
                    INTEGER  bs_ver_src_pp_pos                ;     //:=bs_ver_src_pp_pos;
                    string  _bs_ver_src_fdate_pp             ;     //:=_bs_ver_src_fdate_pp;
                    INTEGER  bs_ver_src_fdate_pp              ;     //:=bs_ver_src_fdate_pp;
                    string  _bs_ver_src_ldate_pp             ;     //:=_bs_ver_src_ldate_pp;
                    INTEGER  bs_ver_src_ldate_pp              ;     //:=bs_ver_src_ldate_pp;
                    INTEGER  bs_ver_src_q3_pos                ;     //:=bs_ver_src_q3_pos;
                    string  _bs_ver_src_fdate_q3             ;     //:=_bs_ver_src_fdate_q3;
                    INTEGER  bs_ver_src_fdate_q3              ;     //:=bs_ver_src_fdate_q3;
                    string  _bs_ver_src_ldate_q3             ;     //:=_bs_ver_src_ldate_q3;
                    INTEGER  bs_ver_src_ldate_q3              ;     //:=bs_ver_src_ldate_q3;
                    INTEGER  bs_ver_src_rr_pos                ;     //:=bs_ver_src_rr_pos;
                    string  _bs_ver_src_fdate_rr             ;     //:=_bs_ver_src_fdate_rr;
                    INTEGER  bs_ver_src_fdate_rr              ;     //:=bs_ver_src_fdate_rr;
                    string  _bs_ver_src_ldate_rr             ;     //:=_bs_ver_src_ldate_rr;
                    INTEGER  bs_ver_src_ldate_rr              ;     //:=bs_ver_src_ldate_rr;
                    INTEGER  bs_ver_src_sa_pos                ;     //:=bs_ver_src_sa_pos;
                    string  _bs_ver_src_fdate_sa             ;     //:=_bs_ver_src_fdate_sa;
                    INTEGER  bs_ver_src_fdate_sa              ;     //:=bs_ver_src_fdate_sa;
                    string  _bs_ver_src_ldate_sa             ;     //:=_bs_ver_src_ldate_sa;
                    INTEGER  bs_ver_src_ldate_sa              ;     //:=bs_ver_src_ldate_sa;
                    INTEGER  bs_ver_src_sb_pos                ;     //:=bs_ver_src_sb_pos;
                    string  _bs_ver_src_fdate_sb             ;     //:=_bs_ver_src_fdate_sb;
                    INTEGER  bs_ver_src_fdate_sb              ;     //:=bs_ver_src_fdate_sb;
                    string  _bs_ver_src_ldate_sb             ;     //:=_bs_ver_src_ldate_sb;
                    INTEGER  bs_ver_src_ldate_sb              ;     //:=bs_ver_src_ldate_sb;
                    INTEGER  bs_ver_src_sg_pos                ;     //:=bs_ver_src_sg_pos;
                    string  _bs_ver_src_fdate_sg             ;     //:=_bs_ver_src_fdate_sg;
                    INTEGER  bs_ver_src_fdate_sg              ;     //:=bs_ver_src_fdate_sg;
                    string  _bs_ver_src_ldate_sg             ;     //:=_bs_ver_src_ldate_sg;
                    INTEGER  bs_ver_src_ldate_sg              ;     //:=bs_ver_src_ldate_sg;
                    INTEGER  bs_ver_src_sj_pos                ;     //:=bs_ver_src_sj_pos;
                    string  _bs_ver_src_fdate_sj             ;     //:=_bs_ver_src_fdate_sj;
                    INTEGER  bs_ver_src_fdate_sj              ;     //:=bs_ver_src_fdate_sj;
                    string  _bs_ver_src_ldate_sj             ;     //:=_bs_ver_src_ldate_sj;
                    INTEGER  bs_ver_src_ldate_sj              ;     //:=bs_ver_src_ldate_sj;
                    INTEGER  bs_ver_src_sk_pos                ;     //:=bs_ver_src_sk_pos;
                    string  _bs_ver_src_fdate_sk             ;     //:=_bs_ver_src_fdate_sk;
                    INTEGER  bs_ver_src_fdate_sk              ;     //:=bs_ver_src_fdate_sk;
                    string  _bs_ver_src_ldate_sk             ;     //:=_bs_ver_src_ldate_sk;
                    INTEGER  bs_ver_src_ldate_sk              ;     //:=bs_ver_src_ldate_sk;
                    INTEGER  bs_ver_src_sp_pos                ;     //:=bs_ver_src_sp_pos;
                    string  _bs_ver_src_fdate_sp             ;     //:=_bs_ver_src_fdate_sp;
                    INTEGER  bs_ver_src_fdate_sp              ;     //:=bs_ver_src_fdate_sp;
                    string  _bs_ver_src_ldate_sp             ;     //:=_bs_ver_src_ldate_sp;
                    INTEGER  bs_ver_src_ldate_sp              ;     //:=bs_ver_src_ldate_sp;
                    INTEGER  bs_ver_src_tx_pos                ;     //:=bs_ver_src_tx_pos;
                    string  _bs_ver_src_fdate_tx             ;     //:=_bs_ver_src_fdate_tx;
                    INTEGER  bs_ver_src_fdate_tx              ;     //:=bs_ver_src_fdate_tx;
                    string  _bs_ver_src_ldate_tx             ;     //:=_bs_ver_src_ldate_tx;
                    INTEGER  bs_ver_src_ldate_tx              ;     //:=bs_ver_src_ldate_tx;
                    INTEGER  bs_ver_src_u2_pos                ;     //:=bs_ver_src_u2_pos;
                    string  _bs_ver_src_fdate_u2             ;     //:=_bs_ver_src_fdate_u2;
                    INTEGER  bs_ver_src_fdate_u2              ;     //:=bs_ver_src_fdate_u2;
                    string  _bs_ver_src_ldate_u2             ;     //:=_bs_ver_src_ldate_u2;
                    INTEGER  bs_ver_src_ldate_u2              ;     //:=bs_ver_src_ldate_u2;
                    INTEGER  bs_ver_src_ut_pos                ;     //:=bs_ver_src_ut_pos;
                    string  _bs_ver_src_fdate_ut             ;     //:=_bs_ver_src_fdate_ut;
                    INTEGER  bs_ver_src_fdate_ut              ;     //:=bs_ver_src_fdate_ut;
                    string  _bs_ver_src_ldate_ut             ;     //:=_bs_ver_src_ldate_ut;
                    INTEGER  bs_ver_src_ldate_ut              ;     //:=bs_ver_src_ldate_ut;
                    INTEGER  bs_ver_src_v_pos                 ;     //:=bs_ver_src_v_pos;
                    string  _bs_ver_src_fdate_v              ;     //:=_bs_ver_src_fdate_v;
                    INTEGER  bs_ver_src_fdate_v               ;     //:=bs_ver_src_fdate_v;
                    string  _bs_ver_src_ldate_v              ;     //:=_bs_ver_src_ldate_v;
                    INTEGER  bs_ver_src_ldate_v               ;     //:=bs_ver_src_ldate_v;
                    INTEGER  bs_ver_src_v2_pos                ;     //:=bs_ver_src_v2_pos;
                    string  _bs_ver_src_fdate_v2             ;     //:=_bs_ver_src_fdate_v2;
                    INTEGER  bs_ver_src_fdate_v2              ;     //:=bs_ver_src_fdate_v2;
                    string  _bs_ver_src_ldate_v2             ;     //:=_bs_ver_src_ldate_v2;
                    INTEGER  bs_ver_src_ldate_v2              ;     //:=bs_ver_src_ldate_v2;
                    INTEGER  bs_ver_src_wa_pos                ;     //:=bs_ver_src_wa_pos;
                    string  _bs_ver_src_fdate_wa             ;     //:=_bs_ver_src_fdate_wa;
                    INTEGER  bs_ver_src_fdate_wa              ;     //:=bs_ver_src_fdate_wa;
                    string  _bs_ver_src_ldate_wa             ;     //:=_bs_ver_src_ldate_wa;
                    INTEGER  bs_ver_src_ldate_wa              ;     //:=bs_ver_src_ldate_wa;
                    INTEGER  bs_ver_src_wb_pos                ;     //:=bs_ver_src_wb_pos;
                    string  _bs_ver_src_fdate_wb             ;     //:=_bs_ver_src_fdate_wb;
                    INTEGER  bs_ver_src_fdate_wb              ;     //:=bs_ver_src_fdate_wb;
                    string  _bs_ver_src_ldate_wb             ;     //:=_bs_ver_src_ldate_wb;
                    INTEGER  bs_ver_src_ldate_wb              ;     //:=bs_ver_src_ldate_wb;
                    INTEGER  bs_ver_src_wc_pos                ;     //:=bs_ver_src_wc_pos;
                    string  _bs_ver_src_fdate_wc             ;     //:=_bs_ver_src_fdate_wc;
                    INTEGER  bs_ver_src_fdate_wc              ;     //:=bs_ver_src_fdate_wc;
                    string  _bs_ver_src_ldate_wc             ;     //:=_bs_ver_src_ldate_wc;
                    INTEGER  bs_ver_src_ldate_wc              ;     //:=bs_ver_src_ldate_wc;
                    INTEGER  bs_ver_src_wk_pos                ;     //:=bs_ver_src_wk_pos;
                    string  _bs_ver_src_fdate_wk             ;     //:=_bs_ver_src_fdate_wk;
                    INTEGER  bs_ver_src_fdate_wk              ;     //:=bs_ver_src_fdate_wk;
                    string  _bs_ver_src_ldate_wk             ;     //:=_bs_ver_src_ldate_wk;
                    INTEGER  bs_ver_src_ldate_wk              ;     //:=bs_ver_src_ldate_wk;
                    INTEGER  bs_ver_src_wx_pos                ;     //:=bs_ver_src_wx_pos;
                    string  _bs_ver_src_fdate_wx             ;     //:=_bs_ver_src_fdate_wx;
                    INTEGER  bs_ver_src_fdate_wx              ;     //:=bs_ver_src_fdate_wx;
                    string  _bs_ver_src_ldate_wx             ;     //:=_bs_ver_src_ldate_wx;
                    INTEGER  bs_ver_src_ldate_wx              ;     //:=bs_ver_src_ldate_wx;
                    INTEGER  bs_ver_src_y_pos                 ;     //:=bs_ver_src_y_pos;
                    string  _bs_ver_src_fdate_y              ;     //:=_bs_ver_src_fdate_y;
                    INTEGER  bs_ver_src_fdate_y               ;     //:=bs_ver_src_fdate_y;
                    string  _bs_ver_src_ldate_y              ;     //:=_bs_ver_src_ldate_y;
                    INTEGER  bs_ver_src_ldate_y               ;     //:=bs_ver_src_ldate_y;
                    INTEGER  bs_ver_src_zo_pos                ;     //:=bs_ver_src_zo_pos;
                    string  _bs_ver_src_fdate_zo             ;     //:=_bs_ver_src_fdate_zo;
                    INTEGER  bs_ver_src_fdate_zo              ;     //:=bs_ver_src_fdate_zo;
                    string  _bs_ver_src_ldate_zo             ;     //:=_bs_ver_src_ldate_zo;
                    INTEGER  bs_ver_src_ldate_zo              ;     //:=bs_ver_src_ldate_zo;
                    INTEGER  bs_ssn_ver_src_ar_pos            ;     //:=bs_ssn_ver_src_ar_pos;
                    string  _bs_ssn_ver_src_ldate_ar         ;     //:=_bs_ssn_ver_src_ldate_ar;
                    INTEGER  bs_ssn_ver_src_ldate_ar          ;     //:=bs_ssn_ver_src_ldate_ar;
                    INTEGER  bs_ssn_ver_src_ba_pos            ;     //:=bs_ssn_ver_src_ba_pos;
                    string  _bs_ssn_ver_src_ldate_ba         ;     //:=_bs_ssn_ver_src_ldate_ba;
                    INTEGER  bs_ssn_ver_src_ldate_ba          ;     //:=bs_ssn_ver_src_ldate_ba;
                    INTEGER  bs_ssn_ver_src_bc_pos            ;     //:=bs_ssn_ver_src_bc_pos;
                    string  _bs_ssn_ver_src_ldate_bc         ;     //:=_bs_ssn_ver_src_ldate_bc;
                    INTEGER  bs_ssn_ver_src_ldate_bc          ;     //:=bs_ssn_ver_src_ldate_bc;
                    INTEGER  bs_ssn_ver_src_bm_pos            ;     //:=bs_ssn_ver_src_bm_pos;
                    string  _bs_ssn_ver_src_ldate_bm         ;     //:=_bs_ssn_ver_src_ldate_bm;
                    INTEGER  bs_ssn_ver_src_ldate_bm          ;     //:=bs_ssn_ver_src_ldate_bm;
                    INTEGER  bs_ssn_ver_src_bn_pos            ;     //:=bs_ssn_ver_src_bn_pos;
                    string  _bs_ssn_ver_src_ldate_bn         ;     //:=_bs_ssn_ver_src_ldate_bn;
                    INTEGER  bs_ssn_ver_src_ldate_bn          ;     //:=bs_ssn_ver_src_ldate_bn;
                    INTEGER  bs_ssn_ver_src_br_pos            ;     //:=bs_ssn_ver_src_br_pos;
                    string  _bs_ssn_ver_src_ldate_br         ;     //:=_bs_ssn_ver_src_ldate_br;
                    INTEGER  bs_ssn_ver_src_ldate_br          ;     //:=bs_ssn_ver_src_ldate_br;
                    INTEGER  bs_ssn_ver_src_by_pos            ;     //:=bs_ssn_ver_src_by_pos;
                    string  _bs_ssn_ver_src_ldate_by         ;     //:=_bs_ssn_ver_src_ldate_by;
                    INTEGER  bs_ssn_ver_src_ldate_by          ;     //:=bs_ssn_ver_src_ldate_by;
                    INTEGER  bs_ssn_ver_src_c_pos             ;     //:=bs_ssn_ver_src_c_pos;
                    string  _bs_ssn_ver_src_ldate_c          ;     //:=_bs_ssn_ver_src_ldate_c;
                    INTEGER  bs_ssn_ver_src_ldate_c           ;     //:=bs_ssn_ver_src_ldate_c;
                    INTEGER  bs_ssn_ver_src_cs_pos            ;     //:=bs_ssn_ver_src_cs_pos;
                    string  _bs_ssn_ver_src_ldate_cs         ;     //:=_bs_ssn_ver_src_ldate_cs;
                    INTEGER  bs_ssn_ver_src_ldate_cs          ;     //:=bs_ssn_ver_src_ldate_cs;
                    INTEGER  bs_ssn_ver_src_cf_pos            ;     //:=bs_ssn_ver_src_cf_pos;
                    string  _bs_ssn_ver_src_ldate_cf         ;     //:=_bs_ssn_ver_src_ldate_cf;
                    INTEGER  bs_ssn_ver_src_ldate_cf          ;     //:=bs_ssn_ver_src_ldate_cf;
                    INTEGER  bs_ssn_ver_src_cu_pos            ;     //:=bs_ssn_ver_src_cu_pos;
                    string  _bs_ssn_ver_src_ldate_cu         ;     //:=_bs_ssn_ver_src_ldate_cu;
                    INTEGER  bs_ssn_ver_src_ldate_cu          ;     //:=bs_ssn_ver_src_ldate_cu;
                    INTEGER  bs_ssn_ver_src_d_pos             ;     //:=bs_ssn_ver_src_d_pos;
                    string  _bs_ssn_ver_src_ldate_d          ;     //:=_bs_ssn_ver_src_ldate_d;
                    INTEGER  bs_ssn_ver_src_ldate_d           ;     //:=bs_ssn_ver_src_ldate_d;
                    INTEGER  bs_ssn_ver_src_da_pos            ;     //:=bs_ssn_ver_src_da_pos;
                    string  _bs_ssn_ver_src_ldate_da         ;     //:=_bs_ssn_ver_src_ldate_da;
                    INTEGER  bs_ssn_ver_src_ldate_da          ;     //:=bs_ssn_ver_src_ldate_da;
                    INTEGER  bs_ssn_ver_src_df_pos            ;     //:=bs_ssn_ver_src_df_pos;
                    string  _bs_ssn_ver_src_ldate_df         ;     //:=_bs_ssn_ver_src_ldate_df;
                    INTEGER  bs_ssn_ver_src_ldate_df          ;     //:=bs_ssn_ver_src_ldate_df;
                    INTEGER  bs_ssn_ver_src_dn_pos            ;     //:=bs_ssn_ver_src_dn_pos;
                    string  _bs_ssn_ver_src_ldate_dn         ;     //:=_bs_ssn_ver_src_ldate_dn;
                    INTEGER  bs_ssn_ver_src_ldate_dn          ;     //:=bs_ssn_ver_src_ldate_dn;
                    INTEGER  bs_ssn_ver_src_e_pos             ;     //:=bs_ssn_ver_src_e_pos;
                    string  _bs_ssn_ver_src_ldate_e          ;     //:=_bs_ssn_ver_src_ldate_e;
                    INTEGER  bs_ssn_ver_src_ldate_e           ;     //:=bs_ssn_ver_src_ldate_e;
                    INTEGER  bs_ssn_ver_src_ef_pos            ;     //:=bs_ssn_ver_src_ef_pos;
                    string  _bs_ssn_ver_src_ldate_ef         ;     //:=_bs_ssn_ver_src_ldate_ef;
                    INTEGER  bs_ssn_ver_src_ldate_ef          ;     //:=bs_ssn_ver_src_ldate_ef;
                    INTEGER  bs_ssn_ver_src_er_pos            ;     //:=bs_ssn_ver_src_er_pos;
                    string  _bs_ssn_ver_src_ldate_er         ;     //:=_bs_ssn_ver_src_ldate_er;
                    INTEGER  bs_ssn_ver_src_ldate_er          ;     //:=bs_ssn_ver_src_ldate_er;
                    INTEGER  bs_ssn_ver_src_ey_pos            ;     //:=bs_ssn_ver_src_ey_pos;
                    string  _bs_ssn_ver_src_ldate_ey         ;     //:=_bs_ssn_ver_src_ldate_ey;
                    INTEGER  bs_ssn_ver_src_ldate_ey          ;     //:=bs_ssn_ver_src_ldate_ey;
                    INTEGER  bs_ssn_ver_src_f_pos             ;     //:=bs_ssn_ver_src_f_pos;
                    string  _bs_ssn_ver_src_ldate_f          ;     //:=_bs_ssn_ver_src_ldate_f;
                    INTEGER  bs_ssn_ver_src_ldate_f           ;     //:=bs_ssn_ver_src_ldate_f;
                    INTEGER  bs_ssn_ver_src_fb_pos            ;     //:=bs_ssn_ver_src_fb_pos;
                    string  _bs_ssn_ver_src_ldate_fb         ;     //:=_bs_ssn_ver_src_ldate_fb;
                    INTEGER  bs_ssn_ver_src_ldate_fb          ;     //:=bs_ssn_ver_src_ldate_fb;
                    INTEGER  bs_ssn_ver_src_fi_pos            ;     //:=bs_ssn_ver_src_fi_pos;
                    string  _bs_ssn_ver_src_ldate_fi         ;     //:=_bs_ssn_ver_src_ldate_fi;
                    INTEGER  bs_ssn_ver_src_ldate_fi          ;     //:=bs_ssn_ver_src_ldate_fi;
                    INTEGER  bs_ssn_ver_src_fk_pos            ;     //:=bs_ssn_ver_src_fk_pos;
                    string  _bs_ssn_ver_src_ldate_fk         ;     //:=_bs_ssn_ver_src_ldate_fk;
                    INTEGER  bs_ssn_ver_src_ldate_fk          ;     //:=bs_ssn_ver_src_ldate_fk;
                    INTEGER  bs_ssn_ver_src_fr_pos            ;     //:=bs_ssn_ver_src_fr_pos;
                    string  _bs_ssn_ver_src_ldate_fr         ;     //:=_bs_ssn_ver_src_ldate_fr;
                    INTEGER  bs_ssn_ver_src_ldate_fr          ;     //:=bs_ssn_ver_src_ldate_fr;
                    INTEGER  bs_ssn_ver_src_ft_pos            ;     //:=bs_ssn_ver_src_ft_pos;
                    string  _bs_ssn_ver_src_ldate_ft         ;     //:=_bs_ssn_ver_src_ldate_ft;
                    INTEGER  bs_ssn_ver_src_ldate_ft          ;     //:=bs_ssn_ver_src_ldate_ft;
                    INTEGER  bs_ssn_ver_src_gb_pos            ;     //:=bs_ssn_ver_src_gb_pos;
                    string  _bs_ssn_ver_src_ldate_gb         ;     //:=_bs_ssn_ver_src_ldate_gb;
                    INTEGER  bs_ssn_ver_src_ldate_gb          ;     //:=bs_ssn_ver_src_ldate_gb;
                    INTEGER  bs_ssn_ver_src_gr_pos            ;     //:=bs_ssn_ver_src_gr_pos;
                    string  _bs_ssn_ver_src_ldate_gr         ;     //:=_bs_ssn_ver_src_ldate_gr;
                    INTEGER  bs_ssn_ver_src_ldate_gr          ;     //:=bs_ssn_ver_src_ldate_gr;
                    INTEGER  bs_ssn_ver_src_h7_pos            ;     //:=bs_ssn_ver_src_h7_pos;
                    string  _bs_ssn_ver_src_ldate_h7         ;     //:=_bs_ssn_ver_src_ldate_h7;
                    INTEGER  bs_ssn_ver_src_ldate_h7          ;     //:=bs_ssn_ver_src_ldate_h7;
                    INTEGER  bs_ssn_ver_src_i_pos             ;     //:=bs_ssn_ver_src_i_pos;
                    string  _bs_ssn_ver_src_ldate_i          ;     //:=_bs_ssn_ver_src_ldate_i;
                    INTEGER  bs_ssn_ver_src_ldate_i           ;     //:=bs_ssn_ver_src_ldate_i;
                    INTEGER  bs_ssn_ver_src_ia_pos            ;     //:=bs_ssn_ver_src_ia_pos;
                    string  _bs_ssn_ver_src_ldate_ia         ;     //:=_bs_ssn_ver_src_ldate_ia;
                    INTEGER  bs_ssn_ver_src_ldate_ia          ;     //:=bs_ssn_ver_src_ldate_ia;
                    INTEGER  bs_ssn_ver_src_ic_pos            ;     //:=bs_ssn_ver_src_ic_pos;
                    string  _bs_ssn_ver_src_ldate_ic         ;     //:=_bs_ssn_ver_src_ldate_ic;
                    INTEGER  bs_ssn_ver_src_ldate_ic          ;     //:=bs_ssn_ver_src_ldate_ic;
                    INTEGER  bs_ssn_ver_src_in_pos            ;     //:=bs_ssn_ver_src_in_pos;
                    string  _bs_ssn_ver_src_ldate_in         ;     //:=_bs_ssn_ver_src_ldate_in;
                    INTEGER  bs_ssn_ver_src_ldate_in          ;     //:=bs_ssn_ver_src_ldate_in;
                    INTEGER  bs_ssn_ver_src_ip_pos            ;     //:=bs_ssn_ver_src_ip_pos;
                    string  _bs_ssn_ver_src_ldate_ip         ;     //:=_bs_ssn_ver_src_ldate_ip;
                    INTEGER  bs_ssn_ver_src_ldate_ip          ;     //:=bs_ssn_ver_src_ldate_ip;
                    INTEGER  bs_ssn_ver_src_is_pos            ;     //:=bs_ssn_ver_src_is_pos;
                    string  _bs_ssn_ver_src_ldate_is         ;     //:=_bs_ssn_ver_src_ldate_is;
                    INTEGER  bs_ssn_ver_src_ldate_is          ;     //:=bs_ssn_ver_src_ldate_is;
                    INTEGER  bs_ssn_ver_src_it_pos            ;     //:=bs_ssn_ver_src_it_pos;
                    string  _bs_ssn_ver_src_ldate_it         ;     //:=_bs_ssn_ver_src_ldate_it;
                    INTEGER  bs_ssn_ver_src_ldate_it          ;     //:=bs_ssn_ver_src_ldate_it;
                    INTEGER  bs_ssn_ver_src_j2_pos            ;     //:=bs_ssn_ver_src_j2_pos;
                    string  _bs_ssn_ver_src_ldate_j2         ;     //:=_bs_ssn_ver_src_ldate_j2;
                    INTEGER  bs_ssn_ver_src_ldate_j2          ;     //:=bs_ssn_ver_src_ldate_j2;
                    INTEGER  bs_ssn_ver_src_kc_pos            ;     //:=bs_ssn_ver_src_kc_pos;
                    string  _bs_ssn_ver_src_ldate_kc         ;     //:=_bs_ssn_ver_src_ldate_kc;
                    INTEGER  bs_ssn_ver_src_ldate_kc          ;     //:=bs_ssn_ver_src_ldate_kc;
                    INTEGER  bs_ssn_ver_src_l0_pos            ;     //:=bs_ssn_ver_src_l0_pos;
                    string  _bs_ssn_ver_src_ldate_l0         ;     //:=_bs_ssn_ver_src_ldate_l0;
                    INTEGER  bs_ssn_ver_src_ldate_l0          ;     //:=bs_ssn_ver_src_ldate_l0;
                    INTEGER  bs_ssn_ver_src_l2_pos            ;     //:=bs_ssn_ver_src_l2_pos;
                    string  _bs_ssn_ver_src_ldate_l2         ;     //:=_bs_ssn_ver_src_ldate_l2;
                    INTEGER  bs_ssn_ver_src_ldate_l2          ;     //:=bs_ssn_ver_src_ldate_l2;
                    INTEGER  bs_ssn_ver_src_mh_pos            ;     //:=bs_ssn_ver_src_mh_pos;
                    string  _bs_ssn_ver_src_ldate_mh         ;     //:=_bs_ssn_ver_src_ldate_mh;
                    INTEGER  bs_ssn_ver_src_ldate_mh          ;     //:=bs_ssn_ver_src_ldate_mh;
                    INTEGER  bs_ssn_ver_src_mw_pos            ;     //:=bs_ssn_ver_src_mw_pos;
                    string  _bs_ssn_ver_src_ldate_mw         ;     //:=_bs_ssn_ver_src_ldate_mw;
                    INTEGER  bs_ssn_ver_src_ldate_mw          ;     //:=bs_ssn_ver_src_ldate_mw;
                    INTEGER  bs_ssn_ver_src_np_pos            ;     //:=bs_ssn_ver_src_np_pos;
                    string  _bs_ssn_ver_src_ldate_np         ;     //:=_bs_ssn_ver_src_ldate_np;
                    INTEGER  bs_ssn_ver_src_ldate_np          ;     //:=bs_ssn_ver_src_ldate_np;
                    INTEGER  bs_ssn_ver_src_nr_pos            ;     //:=bs_ssn_ver_src_nr_pos;
                    string  _bs_ssn_ver_src_ldate_nr         ;     //:=_bs_ssn_ver_src_ldate_nr;
                    INTEGER  bs_ssn_ver_src_ldate_nr          ;     //:=bs_ssn_ver_src_ldate_nr;
                    INTEGER  bs_ssn_ver_src_os_pos            ;     //:=bs_ssn_ver_src_os_pos;
                    string  _bs_ssn_ver_src_ldate_os         ;     //:=_bs_ssn_ver_src_ldate_os;
                    INTEGER  bs_ssn_ver_src_ldate_os          ;     //:=bs_ssn_ver_src_ldate_os;
                    INTEGER  bs_ssn_ver_src_p_pos             ;     //:=bs_ssn_ver_src_p_pos;
                    string  _bs_ssn_ver_src_ldate_p          ;     //:=_bs_ssn_ver_src_ldate_p;
                    INTEGER  bs_ssn_ver_src_ldate_p           ;     //:=bs_ssn_ver_src_ldate_p;
                    INTEGER  bs_ssn_ver_src_pl_pos            ;     //:=bs_ssn_ver_src_pl_pos;
                    string  _bs_ssn_ver_src_ldate_pl         ;     //:=_bs_ssn_ver_src_ldate_pl;
                    INTEGER  bs_ssn_ver_src_ldate_pl          ;     //:=bs_ssn_ver_src_ldate_pl;
                    INTEGER  bs_ssn_ver_src_pp_pos            ;     //:=bs_ssn_ver_src_pp_pos;
                    string  _bs_ssn_ver_src_ldate_pp         ;     //:=_bs_ssn_ver_src_ldate_pp;
                    INTEGER  bs_ssn_ver_src_ldate_pp          ;     //:=bs_ssn_ver_src_ldate_pp;
                    INTEGER  bs_ssn_ver_src_q3_pos            ;     //:=bs_ssn_ver_src_q3_pos;
                    string  _bs_ssn_ver_src_ldate_q3         ;     //:=_bs_ssn_ver_src_ldate_q3;
                    INTEGER  bs_ssn_ver_src_ldate_q3          ;     //:=bs_ssn_ver_src_ldate_q3;
                    INTEGER  bs_ssn_ver_src_rr_pos            ;     //:=bs_ssn_ver_src_rr_pos;
                    string  _bs_ssn_ver_src_ldate_rr         ;     //:=_bs_ssn_ver_src_ldate_rr;
                    INTEGER  bs_ssn_ver_src_ldate_rr          ;     //:=bs_ssn_ver_src_ldate_rr;
                    INTEGER  bs_ssn_ver_src_sa_pos            ;     //:=bs_ssn_ver_src_sa_pos;
                    string  _bs_ssn_ver_src_ldate_sa         ;     //:=_bs_ssn_ver_src_ldate_sa;
                    INTEGER  bs_ssn_ver_src_ldate_sa          ;     //:=bs_ssn_ver_src_ldate_sa;
                    INTEGER  bs_ssn_ver_src_sb_pos            ;     //:=bs_ssn_ver_src_sb_pos;
                    string  _bs_ssn_ver_src_ldate_sb         ;     //:=_bs_ssn_ver_src_ldate_sb;
                    INTEGER  bs_ssn_ver_src_ldate_sb          ;     //:=bs_ssn_ver_src_ldate_sb;
                    INTEGER  bs_ssn_ver_src_sg_pos            ;     //:=bs_ssn_ver_src_sg_pos;
                    string  _bs_ssn_ver_src_ldate_sg         ;     //:=_bs_ssn_ver_src_ldate_sg;
                    INTEGER  bs_ssn_ver_src_ldate_sg          ;     //:=bs_ssn_ver_src_ldate_sg;
                    INTEGER  bs_ssn_ver_src_sj_pos            ;     //:=bs_ssn_ver_src_sj_pos;
                    string  _bs_ssn_ver_src_ldate_sj         ;     //:=_bs_ssn_ver_src_ldate_sj;
                    INTEGER  bs_ssn_ver_src_ldate_sj          ;     //:=bs_ssn_ver_src_ldate_sj;
                    INTEGER  bs_ssn_ver_src_sk_pos            ;     //:=bs_ssn_ver_src_sk_pos;
                    string  _bs_ssn_ver_src_ldate_sk         ;     //:=_bs_ssn_ver_src_ldate_sk;
                    INTEGER  bs_ssn_ver_src_ldate_sk          ;     //:=bs_ssn_ver_src_ldate_sk;
                    INTEGER  bs_ssn_ver_src_sp_pos            ;     //:=bs_ssn_ver_src_sp_pos;
                    string  _bs_ssn_ver_src_ldate_sp         ;     //:=_bs_ssn_ver_src_ldate_sp;
                    INTEGER  bs_ssn_ver_src_ldate_sp          ;     //:=bs_ssn_ver_src_ldate_sp;
                    INTEGER  bs_ssn_ver_src_tx_pos            ;     //:=bs_ssn_ver_src_tx_pos;
                    string  _bs_ssn_ver_src_ldate_tx         ;     //:=_bs_ssn_ver_src_ldate_tx;
                    INTEGER  bs_ssn_ver_src_ldate_tx          ;     //:=bs_ssn_ver_src_ldate_tx;
                    INTEGER  bs_ssn_ver_src_u2_pos            ;     //:=bs_ssn_ver_src_u2_pos;
                    string  _bs_ssn_ver_src_ldate_u2         ;     //:=_bs_ssn_ver_src_ldate_u2;
                    INTEGER  bs_ssn_ver_src_ldate_u2          ;     //:=bs_ssn_ver_src_ldate_u2;
                    INTEGER  bs_ssn_ver_src_ut_pos            ;     //:=bs_ssn_ver_src_ut_pos;
                    string  _bs_ssn_ver_src_ldate_ut         ;     //:=_bs_ssn_ver_src_ldate_ut;
                    INTEGER  bs_ssn_ver_src_ldate_ut          ;     //:=bs_ssn_ver_src_ldate_ut;
                    INTEGER  bs_ssn_ver_src_v_pos             ;     //:=bs_ssn_ver_src_v_pos;
                    string  _bs_ssn_ver_src_ldate_v          ;     //:=_bs_ssn_ver_src_ldate_v;
                    INTEGER  bs_ssn_ver_src_ldate_v           ;     //:=bs_ssn_ver_src_ldate_v;
                    INTEGER  bs_ssn_ver_src_v2_pos            ;     //:=bs_ssn_ver_src_v2_pos;
                    string  _bs_ssn_ver_src_ldate_v2         ;     //:=_bs_ssn_ver_src_ldate_v2;
                    INTEGER  bs_ssn_ver_src_ldate_v2          ;     //:=bs_ssn_ver_src_ldate_v2;
                    INTEGER  bs_ssn_ver_src_wa_pos            ;     //:=bs_ssn_ver_src_wa_pos;
                    string  _bs_ssn_ver_src_ldate_wa         ;     //:=_bs_ssn_ver_src_ldate_wa;
                    INTEGER  bs_ssn_ver_src_ldate_wa          ;     //:=bs_ssn_ver_src_ldate_wa;
                    INTEGER  bs_ssn_ver_src_wb_pos            ;     //:=bs_ssn_ver_src_wb_pos;
                    string  _bs_ssn_ver_src_ldate_wb         ;     //:=_bs_ssn_ver_src_ldate_wb;
                    INTEGER  bs_ssn_ver_src_ldate_wb          ;     //:=bs_ssn_ver_src_ldate_wb;
                    INTEGER  bs_ssn_ver_src_wc_pos            ;     //:=bs_ssn_ver_src_wc_pos;
                    string  _bs_ssn_ver_src_ldate_wc         ;     //:=_bs_ssn_ver_src_ldate_wc;
                    INTEGER  bs_ssn_ver_src_ldate_wc          ;     //:=bs_ssn_ver_src_ldate_wc;
                    INTEGER  bs_ssn_ver_src_wk_pos            ;     //:=bs_ssn_ver_src_wk_pos;
                    string  _bs_ssn_ver_src_ldate_wk         ;     //:=_bs_ssn_ver_src_ldate_wk;
                    INTEGER  bs_ssn_ver_src_ldate_wk          ;     //:=bs_ssn_ver_src_ldate_wk;
                    INTEGER  bs_ssn_ver_src_wx_pos            ;     //:=bs_ssn_ver_src_wx_pos;
                    string  _bs_ssn_ver_src_ldate_wx         ;     //:=_bs_ssn_ver_src_ldate_wx;
                    INTEGER  bs_ssn_ver_src_ldate_wx          ;     //:=bs_ssn_ver_src_ldate_wx;
                    INTEGER  bs_ssn_ver_src_y_pos             ;     //:=bs_ssn_ver_src_y_pos;
                    string  _bs_ssn_ver_src_ldate_y          ;     //:=_bs_ssn_ver_src_ldate_y;
                    INTEGER  bs_ssn_ver_src_ldate_y           ;     //:=bs_ssn_ver_src_ldate_y;
                    INTEGER  bs_ssn_ver_src_zo_pos            ;     //:=bs_ssn_ver_src_zo_pos;
                    string  _bs_ssn_ver_src_ldate_zo         ;     //:=_bs_ssn_ver_src_ldate_zo;
                    INTEGER  bs_ssn_ver_src_ldate_zo          ;     //:=bs_ssn_ver_src_ldate_zo;
                    string  iv_add_apt                       ;     //:=iv_add_apt;
                    string  add_ec1                          ;     //:=add_ec1;
                    INTEGER  nas_summary_ver                  ;     //:=nas_summary_ver;
                    BOOLEAN  nap_summary_ver                  ;     //:=nap_summary_ver;
                    BOOLEAN  infutor_nap_ver                  ;     //:=infutor_nap_ver;
                    BOOLEAN  dob_ver                          ;     //:=dob_ver;
                    INTEGER  sufficiently_verified            ;     //:=sufficiently_verified;
                    INTEGER  addr_validation_problem          ;     //:=addr_validation_problem;
                    INTEGER  phn_validation_problem           ;     //:=phn_validation_problem;
                    INTEGER  validation_problem               ;     //:=validation_problem;
                    INTEGER  tot_liens                        ;     //:=tot_liens;
                    INTEGER  tot_liens_w_type                 ;     //:=tot_liens_w_type;
                    INTEGER  has_derog                        ;     //:=has_derog;
                    INTEGER  nf_phone_ver_bureau              ;     //:=nf_phone_ver_bureau;
                    string  ip_routingmethod                 ;     //:=ip_routingmethod;
                    INTEGER  nf_inq_ssn_lexid_diff01          ;     //:=nf_inq_ssn_lexid_diff01;
                    INTEGER  rv_f00_inq_corrdobssn_adl        ;     //:=rv_f00_inq_corrdobssn_adl;
                    INTEGER  rv_i60_inq_comm_recency          ;     //:=rv_i60_inq_comm_recency;
                    INTEGER  nf_inq_perbestssn_count12        ;     //:=nf_inq_perbestssn_count12;
                    INTEGER  nf_fp_varrisktype                ;     //:=nf_fp_varrisktype;
                    INTEGER  rv_i60_inq_hiriskcred_count12    ;     //:=rv_i60_inq_hiriskcred_count12;
                    string  iv_f00_email_verification        ;     //:=iv_f00_email_verification;
                    INTEGER  nf_inq_per_phone                 ;     //:=nf_inq_per_phone;
                    INTEGER  nf_inq_phone_ver_count           ;     //:=nf_inq_phone_ver_count;
                    INTEGER  rv_c14_addrs_5yr                 ;     //:=rv_c14_addrs_5yr;
                    INTEGER  nf_inq_corraddrphone             ;     //:=nf_inq_corraddrphone;
                    INTEGER  nf_fp_srchvelocityrisktype       ;     //:=nf_fp_srchvelocityrisktype;
                    boolean  iv_inf_phn_verd                  ;     //:=iv_inf_phn_verd;
                    STRING  nf_historic_x_current_ct         ;     //:=nf_historic_x_current_ct;
                    integer  nf_inq_highriskcredit_count24    ;     //:=nf_inq_highriskcredit_count24;
                    INTEGER  nf_fp_idverrisktype              ;     //:=nf_fp_idverrisktype;
                    integer  nf_inq_adls_per_apt_addr         ;     //:=nf_inq_adls_per_apt_addr;
                    integer  nf_inq_corrnamephone             ;     //:=nf_inq_corrnamephone;
                    INTEGER  earliest_cred_date_all           ;     //:=earliest_cred_date_all;
                    integer  nf_m_src_credentialed_fs         ;     //:=nf_m_src_credentialed_fs;
                    integer  nf_inq_adlsperphone_count_week   ;     //:=nf_inq_adlsperphone_count_week;
                    integer  nf_inq_corrphonessn              ;     //:=nf_inq_corrphonessn;
                    integer  nf_inq_communications_count24    ;     //:=nf_inq_communications_count24;
                    integer  nf_inq_corrdobphone              ;     //:=nf_inq_corrdobphone;
                    integer  nf_inq_dob_ver_count             ;     //:=nf_inq_dob_ver_count;
                    string  ip_topleveldomain_lvl            ;     //:=ip_topleveldomain_lvl;
                    integer  nf_inq_highriskcredit_count_week ;     //:=nf_inq_highriskcredit_count_week;
                    INTEGER  rv_l79_adls_per_sfd_addr_c6      ;     //:=rv_l79_adls_per_sfd_addr_c6;
                    INTEGER  iv_nap_inf_phone_ver_lvl         ;     //:=iv_nap_inf_phone_ver_lvl;
                    INTEGER nf_unvrfd_search_risk_index      ;     //:=nf_unvrfd_search_risk_index;
                    INTEGER  nf_fp_srchcomponentrisktype      ;     //:=nf_fp_srchcomponentrisktype;
                    INTEGER  iv_fname_non_phn_src_ct          ;     //:=iv_fname_non_phn_src_ct;
                    INTEGER  nf_fp_srchunvrfdphonecount       ;     //:=nf_fp_srchunvrfdphonecount;
                    INTEGER  rv_i62_inq_dobsperadl_1dig       ;     //:=rv_i62_inq_dobsperadl_1dig;
                    INTEGER  nf_util_adl_count                ;     //:=nf_util_adl_count;
                    INTEGER  nf_inq_banking_count24           ;     //:=nf_inq_banking_count24;
                    INTEGER  rv_c14_addrs_10yr                ;     //:=rv_c14_addrs_10yr;
                    INTEGER  rv_d34_liens_rel_total_amt       ;     //:=rv_d34_liens_rel_total_amt;
                    REAL  rv_l79_adls_per_addr_curr        ;     //:=rv_l79_adls_per_addr_curr;
                    string  rv_6seg_riskview_5_0             ;     //:=rv_6seg_riskview_5_0;
                    INTEGER  ip_state_match                   ;     //:=ip_state_match;
                    INTEGER nf_inq_per_ssn                   ;     //:=nf_inq_per_ssn;
                    INTEGER nf_inq_ssnspercurraddr_count12   ;     //:=nf_inq_ssnspercurraddr_count12;
                    INTEGER  rv_i62_inq_phones_per_adl        ;     //:=rv_i62_inq_phones_per_adl;
                    INTEGER  rv_c14_addrs_15yr                ;     //:=rv_c14_addrs_15yr;
                    INTEGER  rv_f00_inq_corrdobaddr_adl       ;     //:=rv_f00_inq_corrdobaddr_adl;
                    INTEGER  nf_fpc_idver_addressmatchescurr  ;     //:=nf_fpc_idver_addressmatchescurr;
                    string  rv_d31_mostrec_bk                ;     //:=rv_d31_mostrec_bk;
                    INTEGER  rv_d33_eviction_recency          ;     //:=rv_d33_eviction_recency;
                    INTEGER  rv_d34_liens_rel_total_amt84     ;     //:=rv_d34_liens_rel_total_amt84;
                    INTEGER  nf_inq_perphone_count_week       ;     //:=nf_inq_perphone_count_week;
                    INTEGER  nf_invbest_inq_peraddr_diff      ;     //:=nf_invbest_inq_peraddr_diff;
                    INTEGER  rv_l79_adls_per_addr_c6          ;     //:=rv_l79_adls_per_addr_c6;
                    string  iv_d34_liens_unrel_x_rel         ;     //:=iv_d34_liens_unrel_x_rel;
                    INTEGER  rv_i61_inq_collection_count12    ;     //:=rv_i61_inq_collection_count12;
                    INTEGER  nf_inq_bestdob_ver_count         ;     //:=nf_inq_bestdob_ver_count;
                    INTEGER  nf_inq_adls_per_phone            ;     //:=nf_inq_adls_per_phone;
                    INTEGER  rv_p88_phn_dst_to_inp_add        ;     //:=rv_p88_phn_dst_to_inp_add;
                    INTEGER  nf_inq_addr_ver_count            ;     //:=nf_inq_addr_ver_count;
                    INTEGER  rv_l79_adls_per_sfd_addr         ;     //:=rv_l79_adls_per_sfd_addr;
                    INTEGER  nf_inq_perphone_count12          ;     //:=nf_inq_perphone_count12;
                    INTEGER  _liens_unrel_st_last_seen        ;     //:=_liens_unrel_st_last_seen;
                    INTEGER  nf_mos_liens_unrel_st_lseen      ;     //:=nf_mos_liens_unrel_st_lseen;
                    INTEGER  rv_c24_prv_addr_lres             ;     //:=rv_c24_prv_addr_lres;
                    INTEGER  rv_f00_inq_corrphonessn_adl      ;     //:=rv_f00_inq_corrphonessn_adl;
                    INTEGER  rv_i60_inq_prepaidcards_recency  ;     //:=rv_i60_inq_prepaidcards_recency;
                    string  nf_util_adl_summary              ;     //:=nf_util_adl_summary;
                    INTEGER  d_pos                            ;     //:=d_pos;
                    INTEGER  lic_adl_count_d                  ;     //:=lic_adl_count_d;
                    INTEGER  dl_pos                           ;     //:=dl_pos;
                    INTEGER  lic_adl_count_dl                 ;     //:=lic_adl_count_dl;
                    INTEGER  src_drivers_license_adl_count    ;     //:=src_drivers_license_adl_count;
                    REAL  iv_src_drivers_lic_adl_count     ;     //:=iv_src_drivers_lic_adl_count;
                    INTEGER  nf_inq_curraddr_ver_count        ;     //:=nf_inq_curraddr_ver_count;
                    INTEGER  _liens_last_unrel_date84         ;     //:=_liens_last_unrel_date84;
                    INTEGER  rv_d34_mos_last_unrel_lien_dt84  ;     //:=rv_d34_mos_last_unrel_lien_dt84;
                    INTEGER  nf_liens_unrel_ot_total_amt      ;     //:=nf_liens_unrel_ot_total_amt;
                    INTEGER  nf_inq_ssns_per_sfd_addr         ;     //:=nf_inq_ssns_per_sfd_addr;
                    INTEGER  nf_inq_bestlname_ver_count       ;     //:=nf_inq_bestlname_ver_count;
                    INTEGER  iv_c13_avg_lres                  ;     //:=iv_c13_avg_lres;
                    INTEGER  _header_first_seen               ;     //:=_header_first_seen;
                    INTEGER  rv_c10_m_hdr_fs                  ;     //:=rv_c10_m_hdr_fs;
                    INTEGER  nf_inq_addrsperbestssn_count12   ;     //:=nf_inq_addrsperbestssn_count12;
                    INTEGER  nf_email_name_addr_ver           ;     //:=nf_email_name_addr_ver;
                    INTEGER  nf_historical_count              ;     //:=nf_historical_count;
                    real  rv_c12_source_profile            ;     //:=rv_c12_source_profile;
                    INTEGER  rv_c23_email_domain_isp_cnt      ;     //:=rv_c23_email_domain_isp_cnt;
                    INTEGER  corrssnaddr_src_ak_pos           ;     //:=corrssnaddr_src_ak_pos;
                    BOOLEAN  corrssnaddr_src_ak               ;     //:=corrssnaddr_src_ak;
                    INTEGER  corrssnaddr_src_am_pos           ;     //:=corrssnaddr_src_am_pos;
                    BOOLEAN  corrssnaddr_src_am               ;     //:=corrssnaddr_src_am;
                    INTEGER  corrssnaddr_src_ar_pos           ;     //:=corrssnaddr_src_ar_pos;
                    BOOLEAN  corrssnaddr_src_ar               ;     //:=corrssnaddr_src_ar;
                    INTEGER  corrssnaddr_src_ba_pos           ;     //:=corrssnaddr_src_ba_pos;
                    BOOLEAN  corrssnaddr_src_ba               ;     //:=corrssnaddr_src_ba;
                    INTEGER  corrssnaddr_src_cg_pos           ;     //:=corrssnaddr_src_cg_pos;
                    BOOLEAN  corrssnaddr_src_cg               ;     //:=corrssnaddr_src_cg;
                    INTEGER  corrssnaddr_src_co_pos           ;     //:=corrssnaddr_src_co_pos;
                    BOOLEAN  corrssnaddr_src_co               ;     //:=corrssnaddr_src_co;
                    INTEGER  corrssnaddr_src_cy_pos           ;     //:=corrssnaddr_src_cy_pos;
                    BOOLEAN  corrssnaddr_src_cy               ;     //:=corrssnaddr_src_cy;
                    INTEGER  corrssnaddr_src_da_pos           ;     //:=corrssnaddr_src_da_pos;
                    BOOLEAN  corrssnaddr_src_da               ;     //:=corrssnaddr_src_da;
                    INTEGER  corrssnaddr_src_d_pos            ;     //:=corrssnaddr_src_d_pos;
                    BOOLEAN  corrssnaddr_src_d                ;     //:=corrssnaddr_src_d;
                    INTEGER  corrssnaddr_src_dl_pos           ;     //:=corrssnaddr_src_dl_pos;
                    BOOLEAN  corrssnaddr_src_dl               ;     //:=corrssnaddr_src_dl;
                    INTEGER  corrssnaddr_src_ds_pos           ;     //:=corrssnaddr_src_ds_pos;
                    BOOLEAN  corrssnaddr_src_ds               ;     //:=corrssnaddr_src_ds;
                    INTEGER  corrssnaddr_src_de_pos           ;     //:=corrssnaddr_src_de_pos;
                    BOOLEAN  corrssnaddr_src_de               ;     //:=corrssnaddr_src_de;
                    INTEGER  corrssnaddr_src_eb_pos           ;     //:=corrssnaddr_src_eb_pos;
                    BOOLEAN  corrssnaddr_src_eb               ;     //:=corrssnaddr_src_eb;
                    INTEGER  corrssnaddr_src_em_pos           ;     //:=corrssnaddr_src_em_pos;
                    BOOLEAN  corrssnaddr_src_em               ;     //:=corrssnaddr_src_em;
                    INTEGER  corrssnaddr_src_e1_pos           ;     //:=corrssnaddr_src_e1_pos;
                    BOOLEAN  corrssnaddr_src_e1               ;     //:=corrssnaddr_src_e1;
                    INTEGER  corrssnaddr_src_e2_pos           ;     //:=corrssnaddr_src_e2_pos;
                    BOOLEAN  corrssnaddr_src_e2               ;     //:=corrssnaddr_src_e2;
                    INTEGER  corrssnaddr_src_e3_pos           ;     //:=corrssnaddr_src_e3_pos;
                    BOOLEAN  corrssnaddr_src_e3               ;     //:=corrssnaddr_src_e3;
                    INTEGER  corrssnaddr_src_e4_pos           ;     //:=corrssnaddr_src_e4_pos;
                    BOOLEAN  corrssnaddr_src_e4               ;     //:=corrssnaddr_src_e4;
                    INTEGER  corrssnaddr_src_en_pos           ;     //:=corrssnaddr_src_en_pos;
                    BOOLEAN  corrssnaddr_src_en               ;     //:=corrssnaddr_src_en;
                    INTEGER  corrssnaddr_src_eq_pos           ;     //:=corrssnaddr_src_eq_pos;
                    BOOLEAN  corrssnaddr_src_eq               ;     //:=corrssnaddr_src_eq;
                    INTEGER  corrssnaddr_src_fe_pos           ;     //:=corrssnaddr_src_fe_pos;
                    BOOLEAN  corrssnaddr_src_fe               ;     //:=corrssnaddr_src_fe;
                    INTEGER  corrssnaddr_src_ff_pos           ;     //:=corrssnaddr_src_ff_pos;
                    BOOLEAN  corrssnaddr_src_ff               ;     //:=corrssnaddr_src_ff;
                    INTEGER  corrssnaddr_src_fr_pos           ;     //:=corrssnaddr_src_fr_pos;
                    BOOLEAN  corrssnaddr_src_fr               ;     //:=corrssnaddr_src_fr;
                    INTEGER  corrssnaddr_src_l2_pos           ;     //:=corrssnaddr_src_l2_pos;
                    BOOLEAN  corrssnaddr_src_l2               ;     //:=corrssnaddr_src_l2;
                    INTEGER  corrssnaddr_src_li_pos           ;     //:=corrssnaddr_src_li_pos;
                    BOOLEAN  corrssnaddr_src_li               ;     //:=corrssnaddr_src_li;
                    INTEGER  corrssnaddr_src_mw_pos           ;     //:=corrssnaddr_src_mw_pos;
                    BOOLEAN  corrssnaddr_src_mw               ;     //:=corrssnaddr_src_mw;
                    INTEGER  corrssnaddr_src_nt_pos           ;     //:=corrssnaddr_src_nt_pos;
                    BOOLEAN  corrssnaddr_src_nt               ;     //:=corrssnaddr_src_nt;
                    INTEGER  corrssnaddr_src_p_pos            ;     //:=corrssnaddr_src_p_pos;
                    BOOLEAN  corrssnaddr_src_p                ;     //:=corrssnaddr_src_p;
                    INTEGER  corrssnaddr_src_pl_pos           ;     //:=corrssnaddr_src_pl_pos;
                    BOOLEAN  corrssnaddr_src_pl               ;     //:=corrssnaddr_src_pl;
                    INTEGER  corrssnaddr_src_tn_pos           ;     //:=corrssnaddr_src_tn_pos;
                    BOOLEAN  corrssnaddr_src_tn               ;     //:=corrssnaddr_src_tn;
                    INTEGER  corrssnaddr_src_ts_pos           ;     //:=corrssnaddr_src_ts_pos;
                    BOOLEAN  corrssnaddr_src_ts               ;     //:=corrssnaddr_src_ts;
                    INTEGER  corrssnaddr_src_tu_pos           ;     //:=corrssnaddr_src_tu_pos;
                    BOOLEAN  corrssnaddr_src_tu               ;     //:=corrssnaddr_src_tu;
                    INTEGER  corrssnaddr_src_sl_pos           ;     //:=corrssnaddr_src_sl_pos;
                    BOOLEAN  corrssnaddr_src_sl               ;     //:=corrssnaddr_src_sl;
                    INTEGER  corrssnaddr_src_v_pos            ;     //:=corrssnaddr_src_v_pos;
                    BOOLEAN  corrssnaddr_src_v                ;     //:=corrssnaddr_src_v;
                    INTEGER  corrssnaddr_src_vo_pos           ;     //:=corrssnaddr_src_vo_pos;
                    BOOLEAN  corrssnaddr_src_vo               ;     //:=corrssnaddr_src_vo;
                    INTEGER  corrssnaddr_src_w_pos            ;     //:=corrssnaddr_src_w_pos;
                    BOOLEAN  corrssnaddr_src_w                ;     //:=corrssnaddr_src_w;
                    INTEGER  corrssnaddr_src_wp_pos           ;     //:=corrssnaddr_src_wp_pos;
                    BOOLEAN  corrssnaddr_src_wp               ;     //:=corrssnaddr_src_wp;
                    INTEGER  corrssnaddr_ct                   ;     //:=corrssnaddr_ct;
                    INTEGER  nf_corrssnaddr                   ;     //:=nf_corrssnaddr;
                    string  rv_d31_all_bk                    ;     //:=rv_d31_all_bk;
                    STRING  nf_util_add_curr_summary         ;     //:=nf_util_add_curr_summary;
                    string  rv_e58_br_dead_bus_x_active_phn  ;     //:=rv_e58_br_dead_bus_x_active_phn;
                    BOOLEAN  iv_inf_contradictory             ;     //:=iv_inf_contradictory;
                    INTEGER  nf_inquiry_addr_vel_risk_index   ;     //:=nf_inquiry_addr_vel_risk_index;
                    INTEGER  nf_inquiry_addr_vel_risk_indexv2 ;     //:=nf_inquiry_addr_vel_risk_indexv2;
                    INTEGER  nf_bus_ver_src_mos_reg_lseen     ;     //:=nf_bus_ver_src_mos_reg_lseen;
                    INTEGER  corrssnname_src_ak_pos           ;     //:=corrssnname_src_ak_pos;
                    BOOLEAN  corrssnname_src_ak               ;     //:=corrssnname_src_ak;
                    INTEGER  corrssnname_src_am_pos           ;     //:=corrssnname_src_am_pos;
                    BOOLEAN  corrssnname_src_am               ;     //:=corrssnname_src_am;
                    INTEGER  corrssnname_src_ar_pos           ;     //:=corrssnname_src_ar_pos;
                    BOOLEAN  corrssnname_src_ar               ;     //:=corrssnname_src_ar;
                    INTEGER  corrssnname_src_ba_pos           ;     //:=corrssnname_src_ba_pos;
                    BOOLEAN  corrssnname_src_ba               ;     //:=corrssnname_src_ba;
                    INTEGER  corrssnname_src_cg_pos           ;     //:=corrssnname_src_cg_pos;
                    BOOLEAN  corrssnname_src_cg               ;     //:=corrssnname_src_cg;
                    INTEGER  corrssnname_src_co_pos           ;     //:=corrssnname_src_co_pos;
                    BOOLEAN  corrssnname_src_co               ;     //:=corrssnname_src_co;
                    INTEGER  corrssnname_src_cy_pos           ;     //:=corrssnname_src_cy_pos;
                    BOOLEAN  corrssnname_src_cy               ;     //:=corrssnname_src_cy;
                    INTEGER  corrssnname_src_da_pos           ;     //:=corrssnname_src_da_pos;
                    BOOLEAN  corrssnname_src_da               ;     //:=corrssnname_src_da;
                    INTEGER  corrssnname_src_d_pos            ;     //:=corrssnname_src_d_pos;
                    BOOLEAN  corrssnname_src_d                ;     //:=corrssnname_src_d;
                    INTEGER  corrssnname_src_dl_pos           ;     //:=corrssnname_src_dl_pos;
                    BOOLEAN  corrssnname_src_dl               ;     //:=corrssnname_src_dl;
                    INTEGER  corrssnname_src_ds_pos           ;     //:=corrssnname_src_ds_pos;
                    BOOLEAN  corrssnname_src_ds               ;     //:=corrssnname_src_ds;
                    INTEGER  corrssnname_src_de_pos           ;     //:=corrssnname_src_de_pos;
                    BOOLEAN  corrssnname_src_de               ;     //:=corrssnname_src_de;
                    INTEGER  corrssnname_src_eb_pos           ;     //:=corrssnname_src_eb_pos;
                    BOOLEAN  corrssnname_src_eb               ;     //:=corrssnname_src_eb;
                    INTEGER  corrssnname_src_em_pos           ;     //:=corrssnname_src_em_pos;
                    BOOLEAN  corrssnname_src_em               ;     //:=corrssnname_src_em;
                    INTEGER  corrssnname_src_e1_pos           ;     //:=corrssnname_src_e1_pos;
                    BOOLEAN  corrssnname_src_e1               ;     //:=corrssnname_src_e1;
                    INTEGER  corrssnname_src_e2_pos           ;     //:=corrssnname_src_e2_pos;
                    BOOLEAN  corrssnname_src_e2               ;     //:=corrssnname_src_e2;
                    INTEGER  corrssnname_src_e3_pos           ;     //:=corrssnname_src_e3_pos;
                    BOOLEAN  corrssnname_src_e3               ;     //:=corrssnname_src_e3;
                    INTEGER  corrssnname_src_e4_pos           ;     //:=corrssnname_src_e4_pos;
                    BOOLEAN  corrssnname_src_e4               ;     //:=corrssnname_src_e4;
                    INTEGER  corrssnname_src_en_pos           ;     //:=corrssnname_src_en_pos;
                    BOOLEAN  corrssnname_src_en               ;     //:=corrssnname_src_en;
                    INTEGER  corrssnname_src_eq_pos           ;     //:=corrssnname_src_eq_pos;
                    BOOLEAN  corrssnname_src_eq               ;     //:=corrssnname_src_eq;
                    INTEGER  corrssnname_src_fe_pos           ;     //:=corrssnname_src_fe_pos;
                    BOOLEAN  corrssnname_src_fe               ;     //:=corrssnname_src_fe;
                    INTEGER  corrssnname_src_ff_pos           ;     //:=corrssnname_src_ff_pos;
                    BOOLEAN  corrssnname_src_ff               ;     //:=corrssnname_src_ff;
                    INTEGER  corrssnname_src_fr_pos           ;     //:=corrssnname_src_fr_pos;
                    BOOLEAN  corrssnname_src_fr               ;     //:=corrssnname_src_fr;
                    INTEGER  corrssnname_src_l2_pos           ;     //:=corrssnname_src_l2_pos;
                    BOOLEAN  corrssnname_src_l2               ;     //:=corrssnname_src_l2;
                    INTEGER  corrssnname_src_li_pos           ;     //:=corrssnname_src_li_pos;
                    BOOLEAN  corrssnname_src_li               ;     //:=corrssnname_src_li;
                    INTEGER  corrssnname_src_mw_pos           ;     //:=corrssnname_src_mw_pos;
                    BOOLEAN  corrssnname_src_mw               ;     //:=corrssnname_src_mw;
                    INTEGER  corrssnname_src_nt_pos           ;     //:=corrssnname_src_nt_pos;
                    BOOLEAN  corrssnname_src_nt               ;     //:=corrssnname_src_nt;
                    INTEGER  corrssnname_src_p_pos            ;     //:=corrssnname_src_p_pos;
                    BOOLEAN  corrssnname_src_p                ;     //:=corrssnname_src_p;
                    INTEGER  corrssnname_src_pl_pos           ;     //:=corrssnname_src_pl_pos;
                    BOOLEAN  corrssnname_src_pl               ;     //:=corrssnname_src_pl;
                    INTEGER  corrssnname_src_tn_pos           ;     //:=corrssnname_src_tn_pos;
                    BOOLEAN  corrssnname_src_tn               ;     //:=corrssnname_src_tn;
                    INTEGER  corrssnname_src_ts_pos           ;     //:=corrssnname_src_ts_pos;
                    BOOLEAN  corrssnname_src_ts               ;     //:=corrssnname_src_ts;
                    INTEGER  corrssnname_src_tu_pos           ;     //:=corrssnname_src_tu_pos;
                    BOOLEAN  corrssnname_src_tu               ;     //:=corrssnname_src_tu;
                    INTEGER  corrssnname_src_sl_pos           ;     //:=corrssnname_src_sl_pos;
                    BOOLEAN  corrssnname_src_sl               ;     //:=corrssnname_src_sl;
                    INTEGER  corrssnname_src_v_pos            ;     //:=corrssnname_src_v_pos;
                    BOOLEAN  corrssnname_src_v                ;     //:=corrssnname_src_v;
                    INTEGER  corrssnname_src_vo_pos           ;     //:=corrssnname_src_vo_pos;
                    BOOLEAN  corrssnname_src_vo               ;     //:=corrssnname_src_vo;
                    INTEGER  corrssnname_src_w_pos            ;     //:=corrssnname_src_w_pos;
                    BOOLEAN  corrssnname_src_w                ;     //:=corrssnname_src_w;
                    INTEGER  corrssnname_src_wp_pos           ;     //:=corrssnname_src_wp_pos;
                    BOOLEAN  corrssnname_src_wp               ;     //:=corrssnname_src_wp;
                    INTEGER  corrssnname_ct                   ;     //:=corrssnname_ct;
                    INTEGER  nf_corrssnname                   ;     //:=nf_corrssnname;
                    INTEGER  _liens_unrel_st_first_seen       ;     //:=_liens_unrel_st_first_seen;
                    INTEGER  nf_mos_liens_unrel_st_fseen      ;     //:=nf_mos_liens_unrel_st_fseen;
                    INTEGER  nf_inq_corrnameaddr              ;     //:=nf_inq_corrnameaddr;
                    INTEGER  nf_phones_per_curraddr_c6        ;     //:=nf_phones_per_curraddr_c6;
                    INTEGER  nf_bus_seleids_peradl            ;     //:=nf_bus_seleids_peradl;
                    INTEGER  nf_inq_perssn_count01            ;     //:=nf_inq_perssn_count01;
                    INTEGER  iv_addr_non_phn_src_ct           ;     //:=iv_addr_non_phn_src_ct;
                    INTEGER  rv_c13_curr_addr_lres            ;     //:=rv_c13_curr_addr_lres;
                    INTEGER  nf_addrs_per_bestssn             ;     //:=nf_addrs_per_bestssn;
                    INTEGER  nf_inq_collection_count24        ;     //:=nf_inq_collection_count24;
                    INTEGER  nf_invbest_inq_adlsperaddr_diff  ;     //:=nf_invbest_inq_adlsperaddr_diff;
                    INTEGER  rv_c18_invalid_addrs_per_adl     ;     //:=rv_c18_invalid_addrs_per_adl;
                    INTEGER  nf_bus_ver_src_mos_reg_fseen     ;     //:=nf_bus_ver_src_mos_reg_fseen;
                    INTEGER  nf_bus_ssn_ver_src_mos_lseen     ;     //:=nf_bus_ssn_ver_src_mos_lseen;
                    INTEGER  nf_acc_damage_amt_total          ;     //:=nf_acc_damage_amt_total;
                    INTEGER  nf_invbest_inq_lastperaddr_diff  ;     //:=nf_invbest_inq_lastperaddr_diff;
                    INTEGER  nf_fp_prevaddrlenofres           ;     //:=nf_fp_prevaddrlenofres;
                    INTEGER rv_i61_inq_collection_recency    ;     //:=rv_i61_inq_collection_recency;
                    BOOLEAN  no_addr_ver                      ;     //:=no_addr_ver;
                    integer  nf_dist_inp_curr_no_ver          ;     //:=nf_dist_inp_curr_no_ver;
                    integer  nf_inq_addr_recency_risk_index   ;     //:=nf_inq_addr_recency_risk_index;
                    integer  nf_phones_per_addr_curr          ;     //:=nf_phones_per_addr_curr;
                    integer  nf_inq_percurraddr_count12       ;     //:=nf_inq_percurraddr_count12;
                    STRING  nf_util_add_input_summary        ;     //:=nf_util_add_input_summary;
                    BOOLEAN  iv_inf_lname_verd                ;     //:=iv_inf_lname_verd;
                    integer  nf_inq_auto_count24              ;     //:=nf_inq_auto_count24;
                    integer  nf_inq_fname_ver_count           ;     //:=nf_inq_fname_ver_count;
                    INTEGER  rv_i60_inq_peradl_count12        ;     //:=rv_i60_inq_peradl_count12;
                    integer  nf_inq_adls_per_addr             ;     //:=nf_inq_adls_per_addr;
                    integer  nf_inq_lnames_per_apt_addr       ;     //:=nf_inq_lnames_per_apt_addr;
                    INTEGER  rv_c14_unverified_addr_count     ;     //:=rv_c14_unverified_addr_count;
                    integer  nf_inq_corrdobaddr               ;     //:=nf_inq_corrdobaddr;
                    INTEGER  rv_c13_max_lres                  ;     //:=rv_c13_max_lres;
                    INTEGER  rv_c23_email_domain_free_cnt     ;     //:=rv_c23_email_domain_free_cnt;
                    INTEGER  rv_d33_attr_eviction_ct84        ;     //:=rv_d33_attr_eviction_ct84;
                    INTEGER  iv_inq_auto_count01              ;     //:=iv_inq_auto_count01;
                    INTEGER  nf_inq_per_apt_addr              ;     //:=nf_inq_per_apt_addr;
                    integer  rv_i60_inq_retail_recency        ;     //:=rv_i60_inq_retail_recency;
                    INTEGER  nf_inq_adlsperaddr_recency       ;     //:=nf_inq_adlsperaddr_recency;
                    INTEGER  rv_f04_curr_add_occ_index        ;     //:=rv_f04_curr_add_occ_index;
                    INTEGER  rv_c20_m_bureau_adl_fs           ;     //:=rv_c20_m_bureau_adl_fs;
                    INTEGER  nf_inq_ssn_ver_count             ;     //:=nf_inq_ssn_ver_count;
                    STRING  nf_fpc_source_dl                 ;     //:=nf_fpc_source_dl;
                    INTEGER  earliest_bureau_date_all         ;     //:=earliest_bureau_date_all;
                    Integer  nf_m_bureau_adl_fs_all           ;     //:=nf_m_bureau_adl_fs_all;
                    INTEGER  corraddrname_src_ak_pos          ;     //:=corraddrname_src_ak_pos;
                    BOOLEAN  corraddrname_src_ak              ;     //:=corraddrname_src_ak;
                    INTEGER  corraddrname_src_am_pos          ;     //:=corraddrname_src_am_pos;
                    BOOLEAN  corraddrname_src_am              ;     //:=corraddrname_src_am;
                    INTEGER  corraddrname_src_ar_pos          ;     //:=corraddrname_src_ar_pos;
                    BOOLEAN  corraddrname_src_ar              ;     //:=corraddrname_src_ar;
                    INTEGER  corraddrname_src_ba_pos          ;     //:=corraddrname_src_ba_pos;
                    BOOLEAN  corraddrname_src_ba              ;     //:=corraddrname_src_ba;
                    INTEGER  corraddrname_src_cg_pos          ;     //:=corraddrname_src_cg_pos;
                    BOOLEAN  corraddrname_src_cg              ;     //:=corraddrname_src_cg;
                    INTEGER  corraddrname_src_co_pos          ;     //:=corraddrname_src_co_pos;
                    BOOLEAN  corraddrname_src_co              ;     //:=corraddrname_src_co;
                    INTEGER  corraddrname_src_cy_pos          ;     //:=corraddrname_src_cy_pos;
                    BOOLEAN  corraddrname_src_cy              ;     //:=corraddrname_src_cy;
                    INTEGER  corraddrname_src_da_pos          ;     //:=corraddrname_src_da_pos;
                    BOOLEAN  corraddrname_src_da              ;     //:=corraddrname_src_da;
                    INTEGER  corraddrname_src_d_pos           ;     //:=corraddrname_src_d_pos;
                    BOOLEAN  corraddrname_src_d               ;     //:=corraddrname_src_d;
                    INTEGER  corraddrname_src_dl_pos          ;     //:=corraddrname_src_dl_pos;
                    BOOLEAN  corraddrname_src_dl              ;     //:=corraddrname_src_dl;
                    INTEGER  corraddrname_src_ds_pos          ;     //:=corraddrname_src_ds_pos;
                    BOOLEAN  corraddrname_src_ds              ;     //:=corraddrname_src_ds;
                    INTEGER  corraddrname_src_de_pos          ;     //:=corraddrname_src_de_pos;
                    BOOLEAN  corraddrname_src_de              ;     //:=corraddrname_src_de;
                    INTEGER  corraddrname_src_eb_pos          ;     //:=corraddrname_src_eb_pos;
                    BOOLEAN  corraddrname_src_eb              ;     //:=corraddrname_src_eb;
                    INTEGER  corraddrname_src_em_pos          ;     //:=corraddrname_src_em_pos;
                    BOOLEAN  corraddrname_src_em              ;     //:=corraddrname_src_em;
                    INTEGER  corraddrname_src_e1_pos          ;     //:=corraddrname_src_e1_pos;
                    BOOLEAN  corraddrname_src_e1              ;     //:=corraddrname_src_e1;
                    INTEGER  corraddrname_src_e2_pos          ;     //:=corraddrname_src_e2_pos;
                    BOOLEAN  corraddrname_src_e2              ;     //:=corraddrname_src_e2;
                    INTEGER  corraddrname_src_e3_pos          ;     //:=corraddrname_src_e3_pos;
                    BOOLEAN  corraddrname_src_e3              ;     //:=corraddrname_src_e3;
                    INTEGER  corraddrname_src_e4_pos          ;     //:=corraddrname_src_e4_pos;
                    BOOLEAN  corraddrname_src_e4              ;     //:=corraddrname_src_e4;
                    INTEGER  corraddrname_src_en_pos          ;     //:=corraddrname_src_en_pos;
                    BOOLEAN  corraddrname_src_en              ;     //:=corraddrname_src_en;
                    INTEGER  corraddrname_src_eq_pos          ;     //:=corraddrname_src_eq_pos;
                    BOOLEAN  corraddrname_src_eq              ;     //:=corraddrname_src_eq;
                    INTEGER  corraddrname_src_fe_pos          ;     //:=corraddrname_src_fe_pos;
                    BOOLEAN  corraddrname_src_fe              ;     //:=corraddrname_src_fe;
                    INTEGER  corraddrname_src_ff_pos          ;     //:=corraddrname_src_ff_pos;
                    BOOLEAN  corraddrname_src_ff              ;     //:=corraddrname_src_ff;
                    INTEGER  corraddrname_src_fr_pos          ;     //:=corraddrname_src_fr_pos;
                    BOOLEAN  corraddrname_src_fr              ;     //:=corraddrname_src_fr;
                    INTEGER  corraddrname_src_l2_pos          ;     //:=corraddrname_src_l2_pos;
                    BOOLEAN  corraddrname_src_l2              ;     //:=corraddrname_src_l2;
                    INTEGER  corraddrname_src_li_pos          ;     //:=corraddrname_src_li_pos;
                    BOOLEAN  corraddrname_src_li              ;     //:=corraddrname_src_li;
                    INTEGER  corraddrname_src_mw_pos          ;     //:=corraddrname_src_mw_pos;
                    BOOLEAN  corraddrname_src_mw              ;     //:=corraddrname_src_mw;
                    INTEGER  corraddrname_src_nt_pos          ;     //:=corraddrname_src_nt_pos;
                    BOOLEAN  corraddrname_src_nt              ;     //:=corraddrname_src_nt;
                    INTEGER  corraddrname_src_p_pos           ;     //:=corraddrname_src_p_pos;
                    BOOLEAN  corraddrname_src_p               ;     //:=corraddrname_src_p;
                    INTEGER  corraddrname_src_pl_pos          ;     //:=corraddrname_src_pl_pos;
                    BOOLEAN  corraddrname_src_pl              ;     //:=corraddrname_src_pl;
                    INTEGER  corraddrname_src_tn_pos          ;     //:=corraddrname_src_tn_pos;
                    BOOLEAN  corraddrname_src_tn              ;     //:=corraddrname_src_tn;
                    INTEGER  corraddrname_src_ts_pos          ;     //:=corraddrname_src_ts_pos;
                    BOOLEAN  corraddrname_src_ts              ;     //:=corraddrname_src_ts;
                    INTEGER  corraddrname_src_tu_pos          ;     //:=corraddrname_src_tu_pos;
                    BOOLEAN  corraddrname_src_tu              ;     //:=corraddrname_src_tu;
                    INTEGER  corraddrname_src_sl_pos          ;     //:=corraddrname_src_sl_pos;
                    BOOLEAN  corraddrname_src_sl              ;     //:=corraddrname_src_sl;
                    INTEGER  corraddrname_src_v_pos           ;     //:=corraddrname_src_v_pos;
                    BOOLEAN  corraddrname_src_v               ;     //:=corraddrname_src_v;
                    INTEGER  corraddrname_src_vo_pos          ;     //:=corraddrname_src_vo_pos;
                    BOOLEAN  corraddrname_src_vo              ;     //:=corraddrname_src_vo;
                    INTEGER  corraddrname_src_w_pos           ;     //:=corraddrname_src_w_pos;
                    BOOLEAN  corraddrname_src_w               ;     //:=corraddrname_src_w;
                    INTEGER  corraddrname_src_wp_pos          ;     //:=corraddrname_src_wp_pos;
                    BOOLEAN  corraddrname_src_wp              ;     //:=corraddrname_src_wp;
                    INTEGER  corraddrname_ct                  ;     //:=corraddrname_ct;
                    INTEGER  nf_corraddrname                  ;     //:=nf_corraddrname;
                    INTEGER  br_first_seen_char               ;     //:=br_first_seen_char;
                    INTEGER  _br_first_seen                   ;     //:=_br_first_seen;
                    INTEGER  rv_mos_since_br_first_seen       ;     //:=rv_mos_since_br_first_seen;
                    integer  nf_liens_unrel_cj_total_amt      ;     //:=nf_liens_unrel_cj_total_amt;
                    INTEGER  rv_i62_inq_dobsperadl_recency    ;     //:=rv_i62_inq_dobsperadl_recency;
                    INTEGER  rv_d31_bk_filing_count           ;     //:=rv_d31_bk_filing_count;
                    integer  nf_ssns_per_curraddr_curr        ;     //:=nf_ssns_per_curraddr_curr;
                    INTEGER  nf_inq_count24                   ;     //:=nf_inq_count24;
                    integer  rv_f00_inq_corraddrphone_adl     ;     //:=rv_f00_inq_corraddrphone_adl;
                    integer  nf_inq_adlsperssn_recency        ;     //:=nf_inq_adlsperssn_recency;
                    integer  nf_fp_srchphonesrchcountmo       ;     //:=nf_fp_srchphonesrchcountmo;
                    INTEGER  iv_c14_addrs_per_adl             ;     //:=iv_c14_addrs_per_adl;
                    INTEGER  corraddrphone_src_ak_pos         ;     //:=corraddrphone_src_ak_pos;
                    BOOLEAN  corraddrphone_src_ak             ;     //:=corraddrphone_src_ak;
                    INTEGER  corraddrphone_src_am_pos         ;     //:=corraddrphone_src_am_pos;
                    BOOLEAN  corraddrphone_src_am             ;     //:=corraddrphone_src_am;
                    INTEGER  corraddrphone_src_ar_pos         ;     //:=corraddrphone_src_ar_pos;
                    BOOLEAN  corraddrphone_src_ar             ;     //:=corraddrphone_src_ar;
                    INTEGER  corraddrphone_src_ba_pos         ;     //:=corraddrphone_src_ba_pos;
                    BOOLEAN  corraddrphone_src_ba             ;     //:=corraddrphone_src_ba;
                    INTEGER  corraddrphone_src_cg_pos         ;     //:=corraddrphone_src_cg_pos;
                    BOOLEAN  corraddrphone_src_cg             ;     //:=corraddrphone_src_cg;
                    INTEGER  corraddrphone_src_co_pos         ;     //:=corraddrphone_src_co_pos;
                    BOOLEAN  corraddrphone_src_co             ;     //:=corraddrphone_src_co;
                    INTEGER  corraddrphone_src_cy_pos         ;     //:=corraddrphone_src_cy_pos;
                    BOOLEAN  corraddrphone_src_cy             ;     //:=corraddrphone_src_cy;
                    INTEGER  corraddrphone_src_da_pos         ;     //:=corraddrphone_src_da_pos;
                    BOOLEAN  corraddrphone_src_da             ;     //:=corraddrphone_src_da;
                    INTEGER  corraddrphone_src_d_pos          ;     //:=corraddrphone_src_d_pos;
                    BOOLEAN  corraddrphone_src_d              ;     //:=corraddrphone_src_d;
                    INTEGER  corraddrphone_src_dl_pos         ;     //:=corraddrphone_src_dl_pos;
                    BOOLEAN  corraddrphone_src_dl             ;     //:=corraddrphone_src_dl;
                    INTEGER  corraddrphone_src_ds_pos         ;     //:=corraddrphone_src_ds_pos;
                    BOOLEAN  corraddrphone_src_ds             ;     //:=corraddrphone_src_ds;
                    INTEGER  corraddrphone_src_de_pos         ;     //:=corraddrphone_src_de_pos;
                    BOOLEAN  corraddrphone_src_de             ;     //:=corraddrphone_src_de;
                    INTEGER  corraddrphone_src_eb_pos         ;     //:=corraddrphone_src_eb_pos;
                    BOOLEAN  corraddrphone_src_eb             ;     //:=corraddrphone_src_eb;
                    INTEGER  corraddrphone_src_em_pos         ;     //:=corraddrphone_src_em_pos;
                    BOOLEAN  corraddrphone_src_em             ;     //:=corraddrphone_src_em;
                    INTEGER  corraddrphone_src_e1_pos         ;     //:=corraddrphone_src_e1_pos;
                    BOOLEAN  corraddrphone_src_e1             ;     //:=corraddrphone_src_e1;
                    INTEGER  corraddrphone_src_e2_pos         ;     //:=corraddrphone_src_e2_pos;
                    BOOLEAN  corraddrphone_src_e2             ;     //:=corraddrphone_src_e2;
                    INTEGER  corraddrphone_src_e3_pos         ;     //:=corraddrphone_src_e3_pos;
                    BOOLEAN  corraddrphone_src_e3             ;     //:=corraddrphone_src_e3;
                    INTEGER  corraddrphone_src_e4_pos         ;     //:=corraddrphone_src_e4_pos;
                    BOOLEAN  corraddrphone_src_e4             ;     //:=corraddrphone_src_e4;
                    INTEGER  corraddrphone_src_en_pos         ;     //:=corraddrphone_src_en_pos;
                    BOOLEAN  corraddrphone_src_en             ;     //:=corraddrphone_src_en;
                    INTEGER  corraddrphone_src_eq_pos         ;     //:=corraddrphone_src_eq_pos;
                    BOOLEAN  corraddrphone_src_eq             ;     //:=corraddrphone_src_eq;
                    INTEGER  corraddrphone_src_fe_pos         ;     //:=corraddrphone_src_fe_pos;
                    BOOLEAN  corraddrphone_src_fe             ;     //:=corraddrphone_src_fe;
                    INTEGER  corraddrphone_src_ff_pos         ;     //:=corraddrphone_src_ff_pos;
                    BOOLEAN  corraddrphone_src_ff             ;     //:=corraddrphone_src_ff;
                    INTEGER  corraddrphone_src_fr_pos         ;     //:=corraddrphone_src_fr_pos;
                    BOOLEAN  corraddrphone_src_fr             ;     //:=corraddrphone_src_fr;
                    INTEGER  corraddrphone_src_l2_pos         ;     //:=corraddrphone_src_l2_pos;
                    BOOLEAN  corraddrphone_src_l2             ;     //:=corraddrphone_src_l2;
                    INTEGER  corraddrphone_src_li_pos         ;     //:=corraddrphone_src_li_pos;
                    BOOLEAN  corraddrphone_src_li             ;     //:=corraddrphone_src_li;
                    INTEGER  corraddrphone_src_mw_pos         ;     //:=corraddrphone_src_mw_pos;
                    BOOLEAN  corraddrphone_src_mw             ;     //:=corraddrphone_src_mw;
                    INTEGER  corraddrphone_src_nt_pos         ;     //:=corraddrphone_src_nt_pos;
                    BOOLEAN  corraddrphone_src_nt             ;     //:=corraddrphone_src_nt;
                    INTEGER  corraddrphone_src_p_pos          ;     //:=corraddrphone_src_p_pos;
                    BOOLEAN  corraddrphone_src_p              ;     //:=corraddrphone_src_p;
                    INTEGER  corraddrphone_src_pl_pos         ;     //:=corraddrphone_src_pl_pos;
                    BOOLEAN  corraddrphone_src_pl             ;     //:=corraddrphone_src_pl;
                    INTEGER  corraddrphone_src_tn_pos         ;     //:=corraddrphone_src_tn_pos;
                    BOOLEAN  corraddrphone_src_tn             ;     //:=corraddrphone_src_tn;
                    INTEGER  corraddrphone_src_ts_pos         ;     //:=corraddrphone_src_ts_pos;
                    BOOLEAN  corraddrphone_src_ts             ;     //:=corraddrphone_src_ts;
                    INTEGER  corraddrphone_src_tu_pos         ;     //:=corraddrphone_src_tu_pos;
                    BOOLEAN  corraddrphone_src_tu             ;     //:=corraddrphone_src_tu;
                    INTEGER  corraddrphone_src_sl_pos         ;     //:=corraddrphone_src_sl_pos;
                    BOOLEAN  corraddrphone_src_sl             ;     //:=corraddrphone_src_sl;
                    INTEGER  corraddrphone_src_v_pos          ;     //:=corraddrphone_src_v_pos;
                    BOOLEAN  corraddrphone_src_v              ;     //:=corraddrphone_src_v;
                    INTEGER  corraddrphone_src_vo_pos         ;     //:=corraddrphone_src_vo_pos;
                    BOOLEAN  corraddrphone_src_vo             ;     //:=corraddrphone_src_vo;
                    INTEGER  corraddrphone_src_w_pos          ;     //:=corraddrphone_src_w_pos;
                    BOOLEAN  corraddrphone_src_w              ;     //:=corraddrphone_src_w;
                    INTEGER  corraddrphone_src_wp_pos         ;     //:=corraddrphone_src_wp_pos;
                    BOOLEAN  corraddrphone_src_wp             ;     //:=corraddrphone_src_wp;
                    INTEGER  corraddrphone_ct                 ;     //:=corraddrphone_ct;
                    INTEGER  nf_corraddrphone                 ;     //:=nf_corraddrphone;
                    INTEGER  corrphonelastname_src_ak_pos     ;     //:=corrphonelastname_src_ak_pos;
                    BOOLEAN  corrphonelastname_src_ak         ;     //:=corrphonelastname_src_ak;
                    INTEGER  corrphonelastname_src_am_pos     ;     //:=corrphonelastname_src_am_pos;
                    BOOLEAN  corrphonelastname_src_am         ;     //:=corrphonelastname_src_am;
                    INTEGER  corrphonelastname_src_ar_pos     ;     //:=corrphonelastname_src_ar_pos;
                    BOOLEAN  corrphonelastname_src_ar         ;     //:=corrphonelastname_src_ar;
                    INTEGER  corrphonelastname_src_ba_pos     ;     //:=corrphonelastname_src_ba_pos;
                    BOOLEAN  corrphonelastname_src_ba         ;     //:=corrphonelastname_src_ba;
                    INTEGER  corrphonelastname_src_cg_pos     ;     //:=corrphonelastname_src_cg_pos;
                    BOOLEAN  corrphonelastname_src_cg         ;     //:=corrphonelastname_src_cg;
                    INTEGER  corrphonelastname_src_co_pos     ;     //:=corrphonelastname_src_co_pos;
                    BOOLEAN  corrphonelastname_src_co         ;     //:=corrphonelastname_src_co;
                    INTEGER  corrphonelastname_src_cy_pos     ;     //:=corrphonelastname_src_cy_pos;
                    BOOLEAN  corrphonelastname_src_cy         ;     //:=corrphonelastname_src_cy;
                    INTEGER  corrphonelastname_src_da_pos     ;     //:=corrphonelastname_src_da_pos;
                    BOOLEAN  corrphonelastname_src_da         ;     //:=corrphonelastname_src_da;
                    INTEGER  corrphonelastname_src_d_pos      ;     //:=corrphonelastname_src_d_pos;
                    BOOLEAN  corrphonelastname_src_d          ;     //:=corrphonelastname_src_d;
                    INTEGER  corrphonelastname_src_dl_pos     ;     //:=corrphonelastname_src_dl_pos;
                    BOOLEAN  corrphonelastname_src_dl         ;     //:=corrphonelastname_src_dl;
                    INTEGER  corrphonelastname_src_ds_pos     ;     //:=corrphonelastname_src_ds_pos;
                    BOOLEAN  corrphonelastname_src_ds         ;     //:=corrphonelastname_src_ds;
                    INTEGER  corrphonelastname_src_de_pos     ;     //:=corrphonelastname_src_de_pos;
                    BOOLEAN  corrphonelastname_src_de         ;     //:=corrphonelastname_src_de;
                    INTEGER  corrphonelastname_src_eb_pos     ;     //:=corrphonelastname_src_eb_pos;
                    BOOLEAN  corrphonelastname_src_eb         ;     //:=corrphonelastname_src_eb;
                    INTEGER  corrphonelastname_src_em_pos     ;     //:=corrphonelastname_src_em_pos;
                    BOOLEAN  corrphonelastname_src_em         ;     //:=corrphonelastname_src_em;
                    INTEGER  corrphonelastname_src_e1_pos     ;     //:=corrphonelastname_src_e1_pos;
                    BOOLEAN  corrphonelastname_src_e1         ;     //:=corrphonelastname_src_e1;
                    INTEGER  corrphonelastname_src_e2_pos     ;     //:=corrphonelastname_src_e2_pos;
                    BOOLEAN  corrphonelastname_src_e2         ;     //:=corrphonelastname_src_e2;
                    INTEGER  corrphonelastname_src_e3_pos     ;     //:=corrphonelastname_src_e3_pos;
                    BOOLEAN  corrphonelastname_src_e3         ;     //:=corrphonelastname_src_e3;
                    INTEGER  corrphonelastname_src_e4_pos     ;     //:=corrphonelastname_src_e4_pos;
                    BOOLEAN  corrphonelastname_src_e4         ;     //:=corrphonelastname_src_e4;
                    INTEGER  corrphonelastname_src_en_pos     ;     //:=corrphonelastname_src_en_pos;
                    BOOLEAN  corrphonelastname_src_en         ;     //:=corrphonelastname_src_en;
                    INTEGER  corrphonelastname_src_eq_pos     ;     //:=corrphonelastname_src_eq_pos;
                    BOOLEAN  corrphonelastname_src_eq         ;     //:=corrphonelastname_src_eq;
                    INTEGER  corrphonelastname_src_fe_pos     ;     //:=corrphonelastname_src_fe_pos;
                    BOOLEAN  corrphonelastname_src_fe         ;     //:=corrphonelastname_src_fe;
                    INTEGER  corrphonelastname_src_ff_pos     ;     //:=corrphonelastname_src_ff_pos;
                    BOOLEAN  corrphonelastname_src_ff         ;     //:=corrphonelastname_src_ff;
                    INTEGER  corrphonelastname_src_fr_pos     ;     //:=corrphonelastname_src_fr_pos;
                    BOOLEAN  corrphonelastname_src_fr         ;     //:=corrphonelastname_src_fr;
                    INTEGER  corrphonelastname_src_l2_pos     ;     //:=corrphonelastname_src_l2_pos;
                    BOOLEAN  corrphonelastname_src_l2         ;     //:=corrphonelastname_src_l2;
                    INTEGER  corrphonelastname_src_li_pos     ;     //:=corrphonelastname_src_li_pos;
                    BOOLEAN  corrphonelastname_src_li         ;     //:=corrphonelastname_src_li;
                    INTEGER  corrphonelastname_src_mw_pos     ;     //:=corrphonelastname_src_mw_pos;
                    BOOLEAN  corrphonelastname_src_mw         ;     //:=corrphonelastname_src_mw;
                    INTEGER  corrphonelastname_src_nt_pos     ;     //:=corrphonelastname_src_nt_pos;
                    BOOLEAN  corrphonelastname_src_nt         ;     //:=corrphonelastname_src_nt;
                    INTEGER  corrphonelastname_src_p_pos      ;     //:=corrphonelastname_src_p_pos;
                    BOOLEAN  corrphonelastname_src_p          ;     //:=corrphonelastname_src_p;
                    INTEGER  corrphonelastname_src_pl_pos     ;     //:=corrphonelastname_src_pl_pos;
                    BOOLEAN  corrphonelastname_src_pl         ;     //:=corrphonelastname_src_pl;
                    INTEGER  corrphonelastname_src_tn_pos     ;     //:=corrphonelastname_src_tn_pos;
                    BOOLEAN  corrphonelastname_src_tn         ;     //:=corrphonelastname_src_tn;
                    INTEGER  corrphonelastname_src_ts_pos     ;     //:=corrphonelastname_src_ts_pos;
                    BOOLEAN  corrphonelastname_src_ts         ;     //:=corrphonelastname_src_ts;
                    INTEGER  corrphonelastname_src_tu_pos     ;     //:=corrphonelastname_src_tu_pos;
                    BOOLEAN  corrphonelastname_src_tu         ;     //:=corrphonelastname_src_tu;
                    INTEGER  corrphonelastname_src_sl_pos     ;     //:=corrphonelastname_src_sl_pos;
                    BOOLEAN  corrphonelastname_src_sl         ;     //:=corrphonelastname_src_sl;
                    INTEGER  corrphonelastname_src_v_pos      ;     //:=corrphonelastname_src_v_pos;
                    BOOLEAN  corrphonelastname_src_v          ;     //:=corrphonelastname_src_v;
                    INTEGER  corrphonelastname_src_vo_pos     ;     //:=corrphonelastname_src_vo_pos;
                    BOOLEAN  corrphonelastname_src_vo         ;     //:=corrphonelastname_src_vo;
                    INTEGER  corrphonelastname_src_w_pos      ;     //:=corrphonelastname_src_w_pos;
                    BOOLEAN  corrphonelastname_src_w          ;     //:=corrphonelastname_src_w;
                    INTEGER  corrphonelastname_src_wp_pos     ;     //:=corrphonelastname_src_wp_pos;
                    BOOLEAN  corrphonelastname_src_wp         ;     //:=corrphonelastname_src_wp;
                    INTEGER  corrphonelastname_ct             ;     //:=corrphonelastname_ct;
                    INTEGER  nf_corrphonelastname             ;     //:=nf_corrphonelastname;
                    INTEGER  nf_corroboration_risk_index      ;     //:=nf_corroboration_risk_index;
                    INTEGER  nf_accident_count                ;     //:=nf_accident_count;
                    INTEGER  nf_inq_email_ver_count           ;     //:=nf_inq_email_ver_count;
                    INTEGER  nf_phone_ver_insurance           ;     //:=nf_phone_ver_insurance;
                    INTEGER  rv_i60_inq_auto_count12          ;     //:=rv_i60_inq_auto_count12;
                    INTEGER  nf_inq_corraddrssn               ;     //:=nf_inq_corraddrssn;
                    INTEGER  nf_liens_rel_ot_total_amt        ;     //:=nf_liens_rel_ot_total_amt;
                    INTEGER  rv_c16_inv_ssn_per_adl           ;     //:=rv_c16_inv_ssn_per_adl;
                    INTEGER  nf_inq_corrnamessn               ;     //:=nf_inq_corrnamessn;
                    INTEGER  nf_liens_unrel_sc_total_amt      ;     //:=nf_liens_unrel_sc_total_amt;
                    INTEGER  rv_i60_inq_auto_recency          ;     //:=rv_i60_inq_auto_recency;
                    INTEGER  corrnamedob_src_ak_pos           ;     //:=corrnamedob_src_ak_pos;
                    boolean  corrnamedob_src_ak               ;     //:=corrnamedob_src_ak;
                    INTEGER  corrnamedob_src_am_pos           ;     //:=corrnamedob_src_am_pos;
                    boolean  corrnamedob_src_am               ;     //:=corrnamedob_src_am;
                    INTEGER  corrnamedob_src_ar_pos           ;     //:=corrnamedob_src_ar_pos;
                    boolean  corrnamedob_src_ar               ;     //:=corrnamedob_src_ar;
                    INTEGER  corrnamedob_src_ba_pos           ;     //:=corrnamedob_src_ba_pos;
                    boolean  corrnamedob_src_ba               ;     //:=corrnamedob_src_ba;
                    INTEGER  corrnamedob_src_cg_pos           ;     //:=corrnamedob_src_cg_pos;
                    boolean  corrnamedob_src_cg               ;     //:=corrnamedob_src_cg;
                    INTEGER  corrnamedob_src_co_pos           ;     //:=corrnamedob_src_co_pos;
                    boolean  corrnamedob_src_co               ;     //:=corrnamedob_src_co;
                    INTEGER  corrnamedob_src_cy_pos           ;     //:=corrnamedob_src_cy_pos;
                    boolean  corrnamedob_src_cy               ;     //:=corrnamedob_src_cy;
                    INTEGER  corrnamedob_src_da_pos           ;     //:=corrnamedob_src_da_pos;
                    boolean  corrnamedob_src_da               ;     //:=corrnamedob_src_da;
                    INTEGER  corrnamedob_src_d_pos            ;     //:=corrnamedob_src_d_pos;
                    boolean  corrnamedob_src_d                ;     //:=corrnamedob_src_d;
                    INTEGER  corrnamedob_src_dl_pos           ;     //:=corrnamedob_src_dl_pos;
                    boolean  corrnamedob_src_dl               ;     //:=corrnamedob_src_dl;
                    INTEGER  corrnamedob_src_ds_pos           ;     //:=corrnamedob_src_ds_pos;
                    boolean  corrnamedob_src_ds               ;     //:=corrnamedob_src_ds;
                    INTEGER  corrnamedob_src_de_pos           ;     //:=corrnamedob_src_de_pos;
                    boolean  corrnamedob_src_de               ;     //:=corrnamedob_src_de;
                    INTEGER  corrnamedob_src_eb_pos           ;     //:=corrnamedob_src_eb_pos;
                    boolean  corrnamedob_src_eb               ;     //:=corrnamedob_src_eb;
                    INTEGER  corrnamedob_src_em_pos           ;     //:=corrnamedob_src_em_pos;
                    boolean  corrnamedob_src_em               ;     //:=corrnamedob_src_em;
                    INTEGER  corrnamedob_src_e1_pos           ;     //:=corrnamedob_src_e1_pos;
                    boolean  corrnamedob_src_e1               ;     //:=corrnamedob_src_e1;
                    INTEGER  corrnamedob_src_e2_pos           ;     //:=corrnamedob_src_e2_pos;
                    boolean  corrnamedob_src_e2               ;     //:=corrnamedob_src_e2;
                    INTEGER  corrnamedob_src_e3_pos           ;     //:=corrnamedob_src_e3_pos;
                    boolean  corrnamedob_src_e3               ;     //:=corrnamedob_src_e3;
                    INTEGER  corrnamedob_src_e4_pos           ;     //:=corrnamedob_src_e4_pos;
                    boolean  corrnamedob_src_e4               ;     //:=corrnamedob_src_e4;
                    INTEGER  corrnamedob_src_en_pos           ;     //:=corrnamedob_src_en_pos;
                    boolean  corrnamedob_src_en               ;     //:=corrnamedob_src_en;
                    INTEGER  corrnamedob_src_eq_pos           ;     //:=corrnamedob_src_eq_pos;
                    boolean  corrnamedob_src_eq               ;     //:=corrnamedob_src_eq;
                    INTEGER  corrnamedob_src_fe_pos           ;     //:=corrnamedob_src_fe_pos;
                    boolean  corrnamedob_src_fe               ;     //:=corrnamedob_src_fe;
                    INTEGER  corrnamedob_src_ff_pos           ;     //:=corrnamedob_src_ff_pos;
                    boolean  corrnamedob_src_ff               ;     //:=corrnamedob_src_ff;
                    INTEGER  corrnamedob_src_fr_pos           ;     //:=corrnamedob_src_fr_pos;
                    boolean  corrnamedob_src_fr               ;     //:=corrnamedob_src_fr;
                    INTEGER  corrnamedob_src_l2_pos           ;     //:=corrnamedob_src_l2_pos;
                    boolean  corrnamedob_src_l2               ;     //:=corrnamedob_src_l2;
                    INTEGER  corrnamedob_src_li_pos           ;     //:=corrnamedob_src_li_pos;
                    boolean  corrnamedob_src_li               ;     //:=corrnamedob_src_li;
                    INTEGER  corrnamedob_src_mw_pos           ;     //:=corrnamedob_src_mw_pos;
                    boolean  corrnamedob_src_mw               ;     //:=corrnamedob_src_mw;
                    INTEGER  corrnamedob_src_nt_pos           ;     //:=corrnamedob_src_nt_pos;
                    boolean  corrnamedob_src_nt               ;     //:=corrnamedob_src_nt;
                    INTEGER  corrnamedob_src_p_pos            ;     //:=corrnamedob_src_p_pos;
                    boolean  corrnamedob_src_p                ;     //:=corrnamedob_src_p;
                    INTEGER  corrnamedob_src_pl_pos           ;     //:=corrnamedob_src_pl_pos;
                    boolean  corrnamedob_src_pl               ;     //:=corrnamedob_src_pl;
                    INTEGER  corrnamedob_src_tn_pos           ;     //:=corrnamedob_src_tn_pos;
                    boolean  corrnamedob_src_tn               ;     //:=corrnamedob_src_tn;
                    INTEGER  corrnamedob_src_ts_pos           ;     //:=corrnamedob_src_ts_pos;
                    boolean  corrnamedob_src_ts               ;     //:=corrnamedob_src_ts;
                    INTEGER  corrnamedob_src_tu_pos           ;     //:=corrnamedob_src_tu_pos;
                    boolean  corrnamedob_src_tu               ;     //:=corrnamedob_src_tu;
                    INTEGER  corrnamedob_src_sl_pos           ;     //:=corrnamedob_src_sl_pos;
                    boolean  corrnamedob_src_sl               ;     //:=corrnamedob_src_sl;
                    INTEGER  corrnamedob_src_v_pos            ;     //:=corrnamedob_src_v_pos;
                    boolean  corrnamedob_src_v                ;     //:=corrnamedob_src_v;
                    INTEGER  corrnamedob_src_vo_pos           ;     //:=corrnamedob_src_vo_pos;
                    boolean  corrnamedob_src_vo               ;     //:=corrnamedob_src_vo;
                    INTEGER  corrnamedob_src_w_pos            ;     //:=corrnamedob_src_w_pos;
                    boolean  corrnamedob_src_w                ;     //:=corrnamedob_src_w;
                    INTEGER  corrnamedob_src_wp_pos           ;     //:=corrnamedob_src_wp_pos;
                    boolean  corrnamedob_src_wp               ;     //:=corrnamedob_src_wp;
                    INTEGER  corrnamedob_ct                   ;     //:=corrnamedob_ct;
                    INTEGER  nf_corrnamedob                   ;     //:=nf_corrnamedob;
                    INTEGER  nf_inq_corrnameaddrphnssn        ;     //:=nf_inq_corrnameaddrphnssn;
                    INTEGER  nf_liens_unrel_o_total_amt       ;     //:=nf_liens_unrel_o_total_amt;
                    INTEGER  nf_bus_ucc_count                 ;     //:=nf_bus_ucc_count;
                    INTEGER  nf_inq_peraddr_recency           ;     //:=nf_inq_peraddr_recency;
                    INTEGER  nf_inq_corrnamephonessn          ;     //:=nf_inq_corrnamephonessn;
                    INTEGER  rv_f00_inq_corrnameaddr_adl      ;     //:=rv_f00_inq_corrnameaddr_adl;
                    INTEGER  nf_inq_corrdobssn                ;     //:=nf_inq_corrdobssn;
                    INTEGER  rv_i60_inq_other_count12         ;     //:=rv_i60_inq_other_count12;
                    INTEGER  rv_c13_inp_addr_lres             ;     //:=rv_c13_inp_addr_lres;
                    INTEGER  _liens_unrel_ft_first_seen       ;     //:=_liens_unrel_ft_first_seen;
                    INTEGER  nf_mos_liens_unrel_ft_fseen      ;     //:=nf_mos_liens_unrel_ft_fseen;
                    INTEGER  nf_phones_per_sfd_addr_curr      ;     //:=nf_phones_per_sfd_addr_curr;
                    INTEGER  rv_c23_email_count               ;     //:=rv_c23_email_count;
                    INTEGER  nf_adls_per_curraddr_curr        ;     //:=nf_adls_per_curraddr_curr;
                    INTEGER  nf_liens_rel_o_total_amt         ;     //:=nf_liens_rel_o_total_amt;
                    string  rv_4seg_riskview_5_0             ;     //:=rv_4seg_riskview_5_0;
                    INTEGER  nf_fp_srchfraudsrchcount         ;     //:=nf_fp_srchfraudsrchcount;
                    INTEGER  nf_inq_dobsperssn_recency        ;     //:=nf_inq_dobsperssn_recency;
                    INTEGER  rv_a44_curr_add_naprop           ;     //:=rv_a44_curr_add_naprop;
                    INTEGER  nf_inq_other_count24             ;     //:=nf_inq_other_count24;
                    BOOLEAN  iv_nap_lname_verd                ;     //:=iv_nap_lname_verd;
                    INTEGER  nf_fp_srchaddrsrchcountmo        ;     //:=nf_fp_srchaddrsrchcountmo;
                    INTEGER  nf_fp_srchssnsrchcountmo         ;     //:=nf_fp_srchssnsrchcountmo;
                    INTEGER  rv_i62_inq_addrs_per_adl         ;     //:=rv_i62_inq_addrs_per_adl;
                    INTEGER  nf_bus_ver_src_mos_lseen         ;     //:=nf_bus_ver_src_mos_lseen;
                    INTEGER  rv_i60_inq_other_recency         ;     //:=rv_i60_inq_other_recency;
                    INTEGER  _liens_unrel_cj_first_seen       ;     //:=_liens_unrel_cj_first_seen;
                    INTEGER  nf_mos_liens_unrel_cj_fseen      ;     //:=nf_mos_liens_unrel_cj_fseen;
                    INTEGER  nf_inq_lnamesperaddr_recency     ;     //:=nf_inq_lnamesperaddr_recency;
                    INTEGER  _liens_unrel_o_first_seen        ;     //:=_liens_unrel_o_first_seen;
                    INTEGER  nf_mos_liens_unrel_o_fseen       ;     //:=nf_mos_liens_unrel_o_fseen;
                    INTEGER  nf_inq_dobsperssn_1dig           ;     //:=nf_inq_dobsperssn_1dig;
                    INTEGER  nf_sum_src_credentialed          ;     //:=nf_sum_src_credentialed;
                    INTEGER  rv_d34_liens_unrel_total_amt     ;     //:=rv_d34_liens_unrel_total_amt;
                    INTEGER  rv_f00_inq_corrnamessn_adl       ;     //:=rv_f00_inq_corrnamessn_adl;
                    INTEGER  nf_bus_ver_src_mos_fseen         ;     //:=nf_bus_ver_src_mos_fseen;
                    INTEGER  nf_inquiry_adl_vel_risk_index    ;     //:=nf_inquiry_adl_vel_risk_index;
                    INTEGER  vo_pos                           ;     //:=vo_pos;
                    string  vote_adl_lseen_vo                ;     //:=vote_adl_lseen_vo;
                    INTEGER  _vote_adl_lseen_vo               ;     //:=_vote_adl_lseen_vo;
                    integer  iv_mos_src_voter_adl_lseen       ;     //:=iv_mos_src_voter_adl_lseen;
                    REAL  lncu_tree_0                      ;     //:=lncu_tree_0;
                    REAL  lncu_tree_1                      ;     //:=lncu_tree_1;
                    REAL  lncu_tree_2                      ;     //:=lncu_tree_2;
                    REAL  lncu_tree_3                      ;     //:=lncu_tree_3;
                    REAL  lncu_tree_4                      ;     //:=lncu_tree_4;
                    REAL  lncu_tree_5                      ;     //:=lncu_tree_5;
                    REAL  lncu_tree_6                      ;     //:=lncu_tree_6;
                    REAL  lncu_tree_7                      ;     //:=lncu_tree_7;
                    REAL  lncu_tree_8                      ;     //:=lncu_tree_8;
                    REAL  lncu_tree_9                      ;     //:=lncu_tree_9;
                    REAL  lncu_tree_10                     ;     //:=lncu_tree_10;
                    REAL  lncu_tree_11                     ;     //:=lncu_tree_11;
                    REAL  lncu_tree_12                     ;     //:=lncu_tree_12;
                    REAL  lncu_tree_13                     ;     //:=lncu_tree_13;
                    REAL  lncu_tree_14                     ;     //:=lncu_tree_14;
                    REAL  lncu_tree_15                     ;     //:=lncu_tree_15;
                    REAL  lncu_tree_16                     ;     //:=lncu_tree_16;
                    REAL  lncu_tree_17                     ;     //:=lncu_tree_17;
                    REAL  lncu_tree_18                     ;     //:=lncu_tree_18;
                    REAL  lncu_tree_19                     ;     //:=lncu_tree_19;
                    REAL  lncu_tree_20                     ;     //:=lncu_tree_20;
                    REAL  lncu_tree_21                     ;     //:=lncu_tree_21;
                    REAL  lncu_tree_22                     ;     //:=lncu_tree_22;
                    REAL  lncu_tree_23                     ;     //:=lncu_tree_23;
                    REAL  lncu_tree_24                     ;     //:=lncu_tree_24;
                    REAL  lncu_tree_25                     ;     //:=lncu_tree_25;
                    REAL  lncu_tree_26                     ;     //:=lncu_tree_26;
                    REAL  lncu_tree_27                     ;     //:=lncu_tree_27;
                    REAL  lncu_tree_28                     ;     //:=lncu_tree_28;
                    REAL  lncu_tree_29                     ;     //:=lncu_tree_29;
                    REAL  lncu_tree_30                     ;     //:=lncu_tree_30;
                    REAL  lncu_tree_31                     ;     //:=lncu_tree_31;
                    REAL  lncu_tree_32                     ;     //:=lncu_tree_32;
                    REAL  lncu_tree_33                     ;     //:=lncu_tree_33;
                    REAL  lncu_tree_34                     ;     //:=lncu_tree_34;
                    REAL  lncu_tree_35                     ;     //:=lncu_tree_35;
                    REAL  lncu_tree_36                     ;     //:=lncu_tree_36;
                    REAL  lncu_tree_37                     ;     //:=lncu_tree_37;
                    REAL  lncu_tree_38                     ;     //:=lncu_tree_38;
                    REAL  lncu_tree_39                     ;     //:=lncu_tree_39;
                    REAL  lncu_tree_40                     ;     //:=lncu_tree_40;
                    REAL  lncu_tree_41                     ;     //:=lncu_tree_41;
                    REAL  lncu_tree_42                     ;     //:=lncu_tree_42;
                    REAL  lncu_tree_43                     ;     //:=lncu_tree_43;
                    REAL  lncu_tree_44                     ;     //:=lncu_tree_44;
                    REAL  lncu_tree_45                     ;     //:=lncu_tree_45;
                    REAL  lncu_tree_46                     ;     //:=lncu_tree_46;
                    REAL  lncu_tree_47                     ;     //:=lncu_tree_47;
                    REAL  lncu_tree_48                     ;     //:=lncu_tree_48;
                    REAL  lncu_tree_49                     ;     //:=lncu_tree_49;
                    REAL  lncu_tree_50                     ;     //:=lncu_tree_50;
                    REAL  lncu_tree_51                     ;     //:=lncu_tree_51;
                    REAL  lncu_tree_52                     ;     //:=lncu_tree_52;
                    REAL  lncu_tree_53                     ;     //:=lncu_tree_53;
                    REAL  lncu_tree_54                     ;     //:=lncu_tree_54;
                    REAL  lncu_tree_55                     ;     //:=lncu_tree_55;
                    REAL  lncu_tree_56                     ;     //:=lncu_tree_56;
                    REAL  lncu_tree_57                     ;     //:=lncu_tree_57;
                    REAL  lncu_tree_58                     ;     //:=lncu_tree_58;
                    REAL  lncu_tree_59                     ;     //:=lncu_tree_59;
                    REAL  lncu_tree_60                     ;     //:=lncu_tree_60;
                    REAL  lncu_tree_61                     ;     //:=lncu_tree_61;
                    REAL  lncu_tree_62                     ;     //:=lncu_tree_62;
                    REAL  lncu_tree_63                     ;     //:=lncu_tree_63;
                    REAL  lncu_tree_64                     ;     //:=lncu_tree_64;
                    REAL  lncu_tree_65                     ;     //:=lncu_tree_65;
                    REAL  lncu_tree_66                     ;     //:=lncu_tree_66;
                    REAL  lncu_tree_67                     ;     //:=lncu_tree_67;
                    REAL  lncu_tree_68                     ;     //:=lncu_tree_68;
                    REAL  lncu_tree_69                     ;     //:=lncu_tree_69;
                    REAL  lncu_tree_70                     ;     //:=lncu_tree_70;
                    REAL  lncu_tree_71                     ;     //:=lncu_tree_71;
                    REAL  lncu_tree_72                     ;     //:=lncu_tree_72;
                    REAL  lncu_tree_73                     ;     //:=lncu_tree_73;
                    REAL  lncu_tree_74                     ;     //:=lncu_tree_74;
                    REAL  lncu_tree_75                     ;     //:=lncu_tree_75;
                    REAL  lncu_tree_76                     ;     //:=lncu_tree_76;
                    REAL  lncu_tree_77                     ;     //:=lncu_tree_77;
                    REAL  lncu_tree_78                     ;     //:=lncu_tree_78;
                    REAL  lncu_tree_79                     ;     //:=lncu_tree_79;
                    REAL  lncu_tree_80                     ;     //:=lncu_tree_80;
                    REAL  lncu_tree_81                     ;     //:=lncu_tree_81;
                    REAL  lncu_tree_82                     ;     //:=lncu_tree_82;
                    REAL  lncu_tree_83                     ;     //:=lncu_tree_83;
                    REAL  lncu_tree_84                     ;     //:=lncu_tree_84;
                    REAL  lncu_tree_85                     ;     //:=lncu_tree_85;
                    REAL  lncu_tree_86                     ;     //:=lncu_tree_86;
                    REAL  lncu_tree_87                     ;     //:=lncu_tree_87;
                    REAL  lncu_tree_88                     ;     //:=lncu_tree_88;
                    REAL  lncu_tree_89                     ;     //:=lncu_tree_89;
                    REAL  lncu_tree_90                     ;     //:=lncu_tree_90;
                    REAL  lncu_tree_91                     ;     //:=lncu_tree_91;
                    REAL  lncu_tree_92                     ;     //:=lncu_tree_92;
                    REAL  lncu_tree_93                     ;     //:=lncu_tree_93;
                    REAL  lncu_tree_94                     ;     //:=lncu_tree_94;
                    REAL  lncu_tree_95                     ;     //:=lncu_tree_95;
                    REAL  lncu_tree_96                     ;     //:=lncu_tree_96;
                    REAL  lncu_tree_97                     ;     //:=lncu_tree_97;
                    REAL  lncu_tree_98                     ;     //:=lncu_tree_98;
                    REAL  lncu_tree_99                     ;     //:=lncu_tree_99;
                    REAL  lncu_tree_100                    ;     //:=lncu_tree_100;
                    REAL  lncu_tree_101                    ;     //:=lncu_tree_101;
                    REAL  lncu_tree_102                    ;     //:=lncu_tree_102;
                    REAL  lncu_tree_103                    ;     //:=lncu_tree_103;
                    REAL  lncu_tree_104                    ;     //:=lncu_tree_104;
                    REAL  lncu_tree_105                    ;     //:=lncu_tree_105;
                    REAL  lncu_tree_106                    ;     //:=lncu_tree_106;
                    REAL  lncu_tree_107                    ;     //:=lncu_tree_107;
                    REAL  lncu_tree_108                    ;     //:=lncu_tree_108;
                    REAL  lncu_tree_109                    ;     //:=lncu_tree_109;
                    REAL  lncu_tree_110                    ;     //:=lncu_tree_110;
                    REAL  lncu_tree_111                    ;     //:=lncu_tree_111;
                    REAL  lncu_tree_112                    ;     //:=lncu_tree_112;
                    REAL  lncu_tree_113                    ;     //:=lncu_tree_113;
                    REAL  lncu_tree_114                    ;     //:=lncu_tree_114;
                    REAL  lncu_tree_115                    ;     //:=lncu_tree_115;
                    REAL  lncu_tree_116                    ;     //:=lncu_tree_116;
                    REAL  lncu_tree_117                    ;     //:=lncu_tree_117;
                    REAL  lncu_tree_118                    ;     //:=lncu_tree_118;
                    REAL  lncu_tree_119                    ;     //:=lncu_tree_119;
                    REAL  lncu_tree_120                    ;     //:=lncu_tree_120;
                    REAL  lncu_tree_121                    ;     //:=lncu_tree_121;
                    REAL  lncu_tree_122                    ;     //:=lncu_tree_122;
                    REAL  lncu_tree_123                    ;     //:=lncu_tree_123;
                    REAL  lncu_tree_124                    ;     //:=lncu_tree_124;
                    REAL  lncu_tree_125                    ;     //:=lncu_tree_125;
                    REAL  lncu_tree_126                    ;     //:=lncu_tree_126;
                    REAL  lncu_tree_127                    ;     //:=lncu_tree_127;
                    REAL  lncu_tree_128                    ;     //:=lncu_tree_128;
                    REAL  lncu_tree_129                    ;     //:=lncu_tree_129;
                    REAL  lncu_tree_130                    ;     //:=lncu_tree_130;
                    REAL  lncu_tree_131                    ;     //:=lncu_tree_131;
                    REAL  lncu_tree_132                    ;     //:=lncu_tree_132;
                    REAL  lncu_tree_133                    ;     //:=lncu_tree_133;
                    REAL  lncu_tree_134                    ;     //:=lncu_tree_134;
                    REAL  lncu_tree_135                    ;     //:=lncu_tree_135;
                    REAL  lncu_tree_136                    ;     //:=lncu_tree_136;
                    REAL  lncu_tree_137                    ;     //:=lncu_tree_137;
                    REAL  lncu_tree_138                    ;     //:=lncu_tree_138;
                    REAL  lncu_tree_139                    ;     //:=lncu_tree_139;
                    REAL  lncu_tree_140                    ;     //:=lncu_tree_140;
                    REAL  lncu_tree_141                    ;     //:=lncu_tree_141;
                    REAL  lncu_tree_142                    ;     //:=lncu_tree_142;
                    REAL  lncu_tree_143                    ;     //:=lncu_tree_143;
                    REAL  lncu_tree_144                    ;     //:=lncu_tree_144;
                    REAL  lncu_tree_145                    ;     //:=lncu_tree_145;
                    REAL  lncu_tree_146                    ;     //:=lncu_tree_146;
                    REAL  lncu_tree_147                    ;     //:=lncu_tree_147;
                    REAL  lncu_tree_148                    ;     //:=lncu_tree_148;
                    REAL  lncu_tree_149                    ;     //:=lncu_tree_149;
                    REAL  lncu_tree_150                    ;     //:=lncu_tree_150;
                    REAL  lncu_tree_151                    ;     //:=lncu_tree_151;
                    REAL  lncu_tree_152                    ;     //:=lncu_tree_152;
                    REAL  lncu_tree_153                    ;     //:=lncu_tree_153;
                    REAL  lncu_tree_154                    ;     //:=lncu_tree_154;
                    REAL  lncu_tree_155                    ;     //:=lncu_tree_155;
                    REAL  lncu_tree_156                    ;     //:=lncu_tree_156;
                    REAL  lncu_tree_157                    ;     //:=lncu_tree_157;
                    REAL  lncu_tree_158                    ;     //:=lncu_tree_158;
                    REAL  lncu_tree_159                    ;     //:=lncu_tree_159;
                    REAL  lncu_tree_160                    ;     //:=lncu_tree_160;
                    REAL  lncu_tree_161                    ;     //:=lncu_tree_161;
                    REAL  lncu_tree_162                    ;     //:=lncu_tree_162;
                    REAL  lncu_tree_163                    ;     //:=lncu_tree_163;
                    REAL  lncu_tree_164                    ;     //:=lncu_tree_164;
                    REAL  lncu_tree_165                    ;     //:=lncu_tree_165;
                    REAL  lncu_tree_166                    ;     //:=lncu_tree_166;
                    REAL  lncu_tree_167                    ;     //:=lncu_tree_167;
                    REAL  lncu_tree_168                    ;     //:=lncu_tree_168;
                    REAL  lncu_tree_169                    ;     //:=lncu_tree_169;
                    REAL  lncu_tree_170                    ;     //:=lncu_tree_170;
                    REAL  lncu_tree_171                    ;     //:=lncu_tree_171;
                    REAL  lncu_tree_172                    ;     //:=lncu_tree_172;
                    REAL  lncu_tree_173                    ;     //:=lncu_tree_173;
                    REAL  lncu_tree_174                    ;     //:=lncu_tree_174;
                    REAL  lncu_tree_175                    ;     //:=lncu_tree_175;
                    REAL  lncu_gbm_logit                   ;     //:=lncu_gbm_logit;
                    REAL  base                             ;     //:=base;
                    decimal  odds                             ;     //:=odds;
                    INTEGER  point                            ;     //:=point;
                    INTEGER  fp1902_1_0                       ;     //:=fp1902_1_0;
                    INTEGER  _sum_bureau                      ;     //:=_sum_bureau;
                    INTEGER  _sum_credentialed                ;     //:=_sum_credentialed;
                    INTEGER  _prop_owner_history              ;     //:=_prop_owner_history;
                    INTEGER  beta_synthid_trigger             ;     //:=beta_synthid_trigger;
                    INTEGER  num_bureau_fname                 ;     //:=num_bureau_fname;
                    INTEGER  num_bureau_lname                 ;     //:=num_bureau_lname;
                    INTEGER  num_bureau_addr                  ;     //:=num_bureau_addr;
                    INTEGER  num_bureau_ssn                   ;     //:=num_bureau_ssn;
                    INTEGER  num_bureau_dob                   ;     //:=num_bureau_dob;
                    INTEGER  iv_bureau_verification_index     ;     //:=iv_bureau_verification_index;
                    INTEGER  rv_c15_ssns_per_adl_c6_v2        ;     //:=rv_c15_ssns_per_adl_c6_v2;
                    INTEGER  rv_s65_ssn_prior_dob             ;     //:=rv_s65_ssn_prior_dob;
                    INTEGER  rv_c15_ssns_per_adl              ;     //:=rv_c15_ssns_per_adl;
                    INTEGER  _rc_ssnhighissue                 ;     //:=_rc_ssnhighissue;
                    INTEGER  ca_m_snc_ssn_high_issue          ;     //:=ca_m_snc_ssn_high_issue;
                    BOOLEAN  co_tgr_fla_bureau_no_ssn         ;     //:=co_tgr_fla_bureau_no_ssn;
                    boolean  sc_tgr_ssn_fs_6mo                ;     //:=sc_tgr_ssn_fs_6mo;
                    boolean  sc_tgr_ssn_input_not_best        ;     //:=sc_tgr_ssn_input_not_best;
                    boolean  sc_tgr_ssn_prior_dob             ;     //:=sc_tgr_ssn_prior_dob;
                    boolean  co_tgr_ssns_per_adl              ;     //:=co_tgr_ssns_per_adl;
                    BOOLEAN  co_did_count                     ;     //:=co_did_count;
                    BOOLEAN  co_ssn_high_issue                ;     //:=co_ssn_high_issue;
                    INTEGER  beta_cpn_trigger                 ;     //:=beta_cpn_trigger;
                    BOOLEAN  _ver_src_ds                      ;     //:=_ver_src_ds;
                    BOOLEAN  _ver_src_de                      ;     //:=_ver_src_de;
                    BOOLEAN  _derog                           ;     //:=_derog;
                    BOOLEAN  _deceased                        ;     //:=_deceased;
                    BOOLEAN  _ssnpriortodob                   ;     //:=_ssnpriortodob;
                    INTEGER  _hh_strikes                      ;     //:=_hh_strikes;
                    INTEGER  stolenid                         ;     //:=stolenid;
                    INTEGER  suspiciousactivity               ;     //:=suspiciousactivity;
                    INTEGER  vulnerablevictim                 ;     //:=vulnerablevictim;
                    INTEGER  friendlyfraud                    ;     //:=friendlyfraud;
                    INTEGER  stolenc_fp1902_1_0               ;     //:=stolenc_fp1902_1_0;
                    INTEGER  synthc_fp1902_1_0                ;     //:=synthc_fp1902_1_0;
                    INTEGER  manip2c_fp1902_1_0               ;     //:=manip2c_fp1902_1_0;
                    INTEGER  suspactc_fp1902_1_0              ;     //:=suspactc_fp1902_1_0;
                    INTEGER  vulnvicc_fp1902_1_0              ;     //:=vulnvicc_fp1902_1_0;
                    INTEGER  friendlyc_fp1902_1_0             ;     //:=friendlyc_fp1902_1_0;
                    INTEGER  custstolidindex                  ;     //:=custstolidindex;
                    INTEGER  custmanipidindex                 ;     //:=custmanipidindex;
                    INTEGER  custsynthidindex                 ;     //:=custsynthidindex;
                    INTEGER  custsuspactindex                 ;     //:=custsuspactindex;
                    INTEGER  custfriendfrdindex               ;     //:=custfriendfrdindex;
                    INTEGER  custvulnvicindex                  ;
		models.layouts.layout_fp1109;
		//Risk_Indicators.Layout_Boca_Shell clam;
		//bs_with_ip clam;
		bs_with_ip clam_ip;
		END;
			
    // layout_debug doModel( clam le ) := TRANSFORM
    layout_debug doModel( clam_ip le ) := TRANSFORM
  #else
    // models.layouts.layout_fp1109 doModel( clam le ) := TRANSFORM
    models.layouts.layout_fp1109 doModel( clam_ip le ) := TRANSFORM
		
  #end	

/* ***********************************************************
	 *             Model Input Variable Assignments              *
	 ************************************************************* */
   
  upcase := stringlib.stringtouppercase;
  ipaddr                           := le.ip.ipaddr;
	iproutingmethod                  := le.ip.iproutingmethod;
	topleveldomain                   := le.ip.topleveldomain;
	state                            := le.ip.state;
	truedid                          := le.bs.truedid;
	out_unit_desig                   := le.bs.shell_input.unit_desig;
	out_sec_range                    := le.bs.shell_input.sec_range;
	out_st                           := le.bs.shell_input.st;
	out_z5                           := le.bs.shell_input.z5;
	out_addr_type                    := le.bs.shell_input.addr_type;
	out_addr_status                  := le.bs.shell_input.addr_status;
	nas_summary                      := le.bs.iid.nas_summary;
	nap_summary                      := le.bs.iid.nap_summary;
	did_count                        := if(isFCRA, 0, le.bs.iid.didcount);
	rc_ssndod                        := le.bs.ssn_verification.validation.deceasedDate;
	rc_hriskphoneflag                := le.bs.iid.hriskphoneflag;
	rc_hphonetypeflag                := le.bs.iid.hphonetypeflag;
	rc_phonevalflag                  := le.bs.iid.phonevalflag;
	rc_hphonevalflag                 := le.bs.iid.hphonevalflag;
	rc_hriskaddrflag                 := le.bs.iid.hriskaddrflag;
	rc_decsflag                      := le.bs.iid.decsflag;
	rc_ssndobflag                    := le.bs.iid.socsdobflag;
	rc_pwssndobflag                  := le.bs.iid.pwsocsdobflag;
	rc_ssnhighissue                  := (unsigned)le.bs.iid.soclhighissue;
	rc_addrvalflag                   := le.bs.iid.addrvalflag;
	rc_dwelltype                     := le.bs.iid.dwelltype;
	rc_fnamecount                    := le.bs.iid.firstcount;
	rc_addrcount                     := le.bs.iid.addrcount;
	rc_addrcommflag                  := le.bs.iid.addrcommflag;
	rc_hrisksic                      := le.bs.iid.hrisksic;
	rc_hrisksicphone                 := le.bs.iid.hrisksicphone;
	rc_disthphoneaddr                := le.bs.iid.disthphoneaddr;
	rc_phonetype                     := le.bs.iid.phonetype;
	rc_ziptypeflag                   := le.bs.iid.ziptypeflag;
	hdr_source_profile               := le.bs.source_profile;
	ver_sources                      := le.bs.header_summary.ver_sources;
	ver_sources_first_seen           := le.bs.header_summary.ver_sources_first_seen_date;
	ver_sources_last_seen            := le.bs.header_summary.ver_sources_last_seen_date;
	ver_sources_count                := le.bs.header_summary.ver_sources_recordcount;
	ver_fname_sources                := le.bs.header_summary.ver_fname_sources;;
	ver_lname_sources                := le.bs.header_summary.ver_lname_sources;
	ver_addr_sources                 := le.bs.header_summary.ver_addr_sources;
	ver_ssn_sources                  := le.bs.header_summary.ver_ssn_sources;
	ver_dob_sources                  := le.bs.header_summary.ver_dob_sources;
	corrssnname_sources              := le.bs.header_summary.corrssnname_sources;
	corrssnaddr_sources              := le.bs.header_summary.corrssnaddr_sources;
	corraddrname_sources             := le.bs.header_summary.corraddrname_sources;
	corraddrphone_sources            := le.bs.header_summary.corraddrphone_sources;
	corrphonelastname_sources        := le.bs.header_summary.corrphonelastname_sources;
	corrnamedob_sources              := le.bs.header_summary.corrnamedob_sources;
	input_ssn_isbestmatch            := le.bs.best_flags.input_ssn_isbestmatch;
	best_ssn_valid                   := le.bs.best_flags.best_ssn_valid;
	dl_avail                         := le.bs.available_sources.dl;
	bus_seleids_peradl               := le.bs.bip_header.bus_seleids_peradl;
	bus_ver_sources                  := le.bs.bip_header54.bus_ver_sources;
	bus_ver_sources_fseen            := le.bs.bip_header54.bus_ver_sources_first_seen       ;
	bus_ver_sources_lseen            := le.bs.bip_header54.bus_ver_sources_last_seen       ;
	bus_ssn_ver_sources              := le.bs.bip_header54.bus_ssn_ver_sources ;
	bus_ssn_ver_sources_lseen        := le.bs.bip_header54.bus_ssn_ver_sources_last_seen       ;
	bus_ucc_count                    := le.bs.BIP_Header54.bus_ucc_count;
	fnamepop                         := le.bs.input_validation.firstname;
	lnamepop                         := le.bs.input_validation.lastname;
	addrpop                          := le.bs.input_validation.address;
	ssnlength                        := le.bs.input_validation.ssn_length;
	dobpop                           := le.bs.input_validation.dateofbirth;
	emailpop                         := le.bs.input_validation.email;
	hphnpop                          := le.bs.input_validation.homephone;
	util_adl_type_list               := le.bs.utility.utili_adl_type;
	util_adl_count                   := le.bs.utility.utili_adl_count;
	util_add_input_type_list         := le.bs.utility.utili_addr1_type;
	util_add_curr_type_list          := le.bs.utility.utili_addr2_type;
	add_input_isbestmatch            := le.bs.address_verification.input_address_information.isbestmatch;
	add_input_lres                   := le.bs.lres;
	add_input_advo_vacancy           := le.bs.advo_input_addr.Address_Vacancy_Indicator;
	add_input_advo_res_or_bus        := le.bs.advo_input_addr.Residential_or_Business_Ind;
	add_input_naprop                 := le.bs.address_verification.input_address_information.naprop;
	add_input_pop                    := le.bs.addrPop;
	property_owned_total             := le.bs.address_verification.owned.property_total;
	add_dist_input_to_curr           := le.bs.address_verification.distance_in_2_h1;
	add_curr_lres                    := le.bs.lres2;
	add_curr_occ_index               := le.bs.address_verification.currAddr_occupancy_index;
	add_curr_naprop                  := le.bs.address_verification.address_history_1.naprop;
	add_curr_pop                     := le.bs.addrPop2;
	add_prev_lres                    := le.bs.lres3;
	add_prev_naprop                  := le.bs.address_verification.address_history_2.naprop;
	add_prev_pop                     := le.bs.addrPop3;
	avg_lres                         := le.bs.other_address_info.avg_lres;
	max_lres                         := le.bs.other_address_info.max_lres;
	addrs_5yr                        := le.bs.other_address_info.addrs_last_5years;
	addrs_10yr                       := le.bs.other_address_info.addrs_last_10years;
	addrs_15yr                       := le.bs.other_address_info.addrs_last_15years;
	addrs_prison_history             := le.bs.other_address_info.isprison;
	unverified_addr_count            := le.bs.address_verification.unverified_addr_count;
	telcordia_type                   := le.bs.phone_verification.telcordia_type;
	phone_ver_insurance              := le.bs.insurance_phones_summary.Insurance_Phone_Verification;
	phone_ver_bureau                 := le.bs.phone_ver_bureau;
	header_first_seen                := le.bs.ssn_verification.header_first_seen;
	ssns_per_adl                     := le.bs.velocity_counters.ssns_per_adl;
	addrs_per_adl                    := le.bs.velocity_counters.addrs_per_adl;
	adls_per_ssn                     := le.bs.SSN_Verification.adlPerSSN_count;
	addrs_per_bestssn                := le.bs.best_flags.addrs_per_bestssn;
	adls_per_addr_curr               := le.bs.velocity_counters.adls_per_addr_current;
	adls_per_curraddr_curr           := le.bs.best_flags.adls_per_curraddr_curr;
	ssns_per_addr_curr               := le.bs.velocity_counters.ssns_per_addr_current;
	ssns_per_curraddr_curr           := le.bs.best_flags.ssns_per_curraddr_curr;
	phones_per_addr_curr             := le.bs.velocity_counters.phones_per_addr_current;
	ssns_per_adl_c6                  := le.bs.velocity_counters.ssns_per_adl_created_6months;
	adls_per_addr_c6                 := le.bs.velocity_counters.adls_per_addr_created_6months;
	phones_per_curraddr_c6           := le.bs.best_flags.phones_per_curraddr_c6;
	invalid_ssns_per_adl             := le.bs.velocity_counters.invalid_ssns_per_adl;
	invalid_addrs_per_adl            := le.bs.velocity_counters.invalid_addrs_per_adl;
	inq_addr_ver_count               := le.bs.acc_logs.inquiry_addr_ver_ct;
	inq_fname_ver_count              := le.bs.acc_logs.inquiry_fname_ver_ct;
	inq_ssn_ver_count                := le.bs.acc_logs.inquiry_ssn_ver_ct;
	inq_dob_ver_count                := le.bs.acc_logs.inquiry_dob_ver_ct;
	inq_phone_ver_count              := le.bs.acc_logs.inquiry_phone_ver_ct;
	inq_email_ver_count              := le.bs.acc_logs.inquiry_email_ver_ct;
	inq_count01                      := le.bs.acc_logs.inquiries.count01;
	inq_count03                      := le.bs.acc_logs.inquiries.count03;
	inq_count24                      := le.bs.acc_logs.inquiries.count24;
	inq_auto_count                   := le.bs.acc_logs.auto.counttotal;
	inq_auto_count01                 := le.bs.acc_logs.auto.count01;
	inq_auto_count03                 := le.bs.acc_logs.auto.count03;
	inq_auto_count06                 := le.bs.acc_logs.auto.count06;
	inq_auto_count12                 := le.bs.acc_logs.auto.count12;
	inq_auto_count24                 := le.bs.acc_logs.auto.count24;
	inq_banking_count24              := le.bs.acc_logs.banking.count24;
	inq_collection_count             := le.bs.acc_logs.collection.counttotal;
	inq_collection_count01           := le.bs.acc_logs.collection.count01;
	inq_collection_count03           := le.bs.acc_logs.collection.count03;
	inq_collection_count06           := le.bs.acc_logs.collection.count06;
	inq_collection_count12           := le.bs.acc_logs.collection.count12;
	inq_collection_count24           := le.bs.acc_logs.collection.count24;
	inq_communications_count         := le.bs.acc_logs.communications.counttotal;
	inq_communications_count01       := le.bs.acc_logs.communications.count01;
	inq_communications_count03       := le.bs.acc_logs.communications.count03;
	inq_communications_count06       := le.bs.acc_logs.communications.count06;
	inq_communications_count12       := le.bs.acc_logs.communications.count12;
	inq_communications_count24       := le.bs.acc_logs.communications.count24;
	inq_highriskcredit_count_week    := if(isFCRA, 0, le.bs.acc_logs.highriskcredit.countweek);
	inq_highriskcredit_count12       := le.bs.acc_logs.highriskcredit.count12;
	inq_highriskcredit_count24       := le.bs.acc_logs.highriskcredit.count24;
	inq_other_count                  := le.bs.acc_logs.other.counttotal;
	inq_other_count01                := le.bs.acc_logs.other.count01;
	inq_other_count03                := le.bs.acc_logs.other.count03;
	inq_other_count06                := le.bs.acc_logs.other.count06;
	inq_other_count12                := le.bs.acc_logs.other.count12;
	inq_other_count24                := le.bs.acc_logs.other.count24;
	inq_prepaidcards_count           := le.bs.acc_logs.prepaidcards.counttotal;
	inq_prepaidcards_count01         := le.bs.acc_logs.prepaidcards.count01;
	inq_prepaidcards_count03         := le.bs.acc_logs.prepaidcards.count03;
	inq_prepaidcards_count06         := le.bs.acc_logs.prepaidcards.count06;
	inq_prepaidcards_count12         := le.bs.acc_logs.prepaidcards.count12;
	inq_prepaidcards_count24         := le.bs.acc_logs.prepaidcards.count24;
	inq_retail_count                 := le.bs.acc_logs.retail.counttotal;
	inq_retail_count01               := le.bs.acc_logs.retail.count01;
	inq_retail_count03               := le.bs.acc_logs.retail.count03;
	inq_retail_count06               := le.bs.acc_logs.retail.count06;
	inq_retail_count12               := le.bs.acc_logs.retail.count12;
	inq_retail_count24               := le.bs.acc_logs.retail.count24;
	inq_peradl                       := le.bs.acc_logs.inquiryperadl;
	inq_ssnsperadl                   := le.bs.acc_logs.inquiryssnsperadl;
	inq_addrsperadl                  := le.bs.acc_logs.inquiryaddrsperadl;
	inq_lnamesperadl                 := if(isFCRA, 0, le.bs.acc_logs.inquirylnamesperadl);
	inq_phonesperadl                 := le.bs.acc_logs.inquiryphonesperadl;
	inq_dobsperadl                   := le.bs.acc_logs.inquirydobsperadl;
	inq_dobsperadl_count01           := le.bs.acc_logs.inq_dobsperadl_count01;
	inq_dobsperadl_count03           := le.bs.acc_logs.inq_dobsperadl_count03;
	inq_dobsperadl_count06           := le.bs.acc_logs.inq_dobsperadl_count06;
	inq_perssn                       := if(isFCRA, 0, le.bs.acc_logs.inquiryPerSSN );
	inq_perssn_count01               := le.bs.acc_logs.inq_perssn_count01;
	inq_adlsperssn                   := if(isFCRA, 0, le.bs.acc_logs.inquiryADLsPerSSN );
	inq_adlsperssn_count01           := if(isFCRA, 0, le.bs.acc_logs.inq_adlsperssn_count01 );
	inq_adlsperssn_count03           := if(isFCRA, 0, le.bs.acc_logs.inq_adlsperssn_count03 );
	inq_adlsperssn_count06           := if(isFCRA, 0, le.bs.acc_logs.inq_adlsperssn_count06 );
	inq_dobsperssn                   := if(isFCRA, 0, le.bs.acc_logs.inquiryDOBsPerSSN );
	inq_dobsperssn_count01           := if(isFCRA, 0, le.bs.acc_logs.inq_dobsperssn_count01 );
	inq_dobsperssn_count03           := if(isFCRA, 0, le.bs.acc_logs.inq_dobsperssn_count03 );
	inq_dobsperssn_count06           := if(isFCRA, 0, le.bs.acc_logs.inq_dobsperssn_count06 );
	inq_peraddr                      := if(isFCRA, 0, le.bs.acc_logs.inquiryPerAddr );
	inq_peraddr_count01              := if(isFCRA, 0, le.bs.acc_logs.inq_peraddr_count01 );
	inq_peraddr_count03              := if(isFCRA, 0, le.bs.acc_logs.inq_peraddr_count03 );
	inq_peraddr_count06              := if(isFCRA, 0, le.bs.acc_logs.inq_peraddr_count06 );
	inq_adlsperaddr                  := if(isFCRA, 0, le.bs.acc_logs.inquiryADLsPerAddr );
	inq_adlsperaddr_count01          := le.bs.acc_logs.inq_adlsperaddr_count01;
	inq_adlsperaddr_count03          := if(isFCRA, 0, le.bs.acc_logs.inq_adlsperaddr_count03 );
	inq_adlsperaddr_count06          := if(isFCRA, 0, le.bs.acc_logs.inq_adlsperaddr_count06 );
	inq_lnamesperaddr                := if(isFCRA, 0, le.bs.acc_logs.inquiryLNamesPerAddr );
	inq_lnamesperaddr_count01        := le.bs.acc_logs.inq_lnamesperaddr_count01;
	inq_lnamesperaddr_count03        := if(isFCRA, 0, le.bs.acc_logs.inq_lnamesperaddr_count03 );
	inq_lnamesperaddr_count06        := if(isFCRA, 0, le.bs.acc_logs.inq_lnamesperaddr_count06 );
	inq_ssnsperaddr                  := if(isFCRA, 0, le.bs.acc_logs.inquirySSNsPerAddr );
	inq_ssnsperaddr_count01          := le.bs.acc_logs.inq_ssnsperaddr_count01;
	inq_perphone                     := if(isFCRA, 0, le.bs.acc_logs.inquiryPerPhone );
	inq_perphone_count_week          := le.bs.acc_logs.inq_perphone_count_week;
	inq_adlsperphone                 := if(isFCRA, 0, le.bs.acc_logs.inquiryADLsPerPhone );
	inq_adlsperphone_count_week      := if(isFCRA, 0, le.bs.acc_logs.inq_adlsperphone_count_week );
	inq_dobsperadl_1dig              := le.bs.acc_logs.inq_dobsperadl_1dig;
	inq_dobsperssn_1dig              := le.bs.acc_logs.inq_dobsperssn_1dig;
	inq_perbestssn                   := le.bs.best_flags.inq_perbestssn;
	inq_addrsperbestssn              := le.bs.best_flags.inq_addrsperbestssn;
	inq_percurraddr                  := le.bs.best_flags.inq_percurraddr;
	inq_adlspercurraddr              := le.bs.best_flags.inq_adlspercurraddr;
	inq_lnamespercurraddr            := le.bs.best_flags.inq_lnamespercurraddr;
	inq_ssnspercurraddr              := le.bs.best_flags.inq_ssnspercurraddr;
	inq_curraddr_ver_count           := le.bs.best_flags.inq_curraddr_ver_count;
	inq_bestlname_ver_count          := le.bs.best_flags.inq_bestlname_ver_count;
	inq_bestdob_ver_count            := le.bs.best_flags.inq_bestdob_ver_count;
	inq_corrnameaddr                 := le.bs.acc_logs.inq_corrnameaddr;
	inq_corrnameaddr_adl             := le.bs.acc_logs.inq_corrnameaddr_adl;
	inq_corrnamessn                  := le.bs.acc_logs.inq_corrnamessn;
	inq_corrnamessn_adl              := le.bs.acc_logs.inq_corrnamessn_adl;
	inq_corrnamephone                := le.bs.acc_logs.inq_corrnamephone;
	inq_corraddrssn                  := le.bs.acc_logs.inq_corraddrssn;
	inq_corrdobaddr                  := le.bs.acc_logs.inq_corrdobaddr;
	inq_corrdobaddr_adl              := le.bs.acc_logs.inq_corrdobaddr_adl;
	inq_corraddrphone                := le.bs.acc_logs.inq_corraddrphone;
	inq_corraddrphone_adl            := le.bs.acc_logs.inq_corraddrphone_adl;
	inq_corrdobssn                   := le.bs.acc_logs.inq_corrdobssn;
	inq_corrdobssn_adl               := le.bs.acc_logs.inq_corrdobssn_adl;
	inq_corrphonessn                 := le.bs.acc_logs.inq_corrphonessn;
	inq_corrphonessn_adl             := le.bs.acc_logs.inq_corrphonessn_adl;
	inq_corrdobphone                 := le.bs.acc_logs.inq_corrdobphone;
	inq_corrnamephonessn             := le.bs.acc_logs.inq_corrnamephonessn;
	inq_corrnameaddrphnssn           := le.bs.acc_logs.inq_corrnameaddrphnssn;
	br_first_seen                    := le.bs.employment.first_seen_date;
	br_dead_business_count           := le.bs.employment.dead_business_ct;
	br_active_phone_count            := le.bs.employment.business_active_phone_ct;
	infutor_nap                      := le.bs.infutor_phone.infutor_nap;
	stl_inq_count                    := le.bs.impulse.count;
	stl_inq_count24                  := le.bs.impulse.count24;
	email_count                      := le.bs.email_summary.email_ct;
	email_domain_free_count          := le.bs.email_summary.email_domain_free_ct;
	email_domain_isp_count           := le.bs.email_summary.email_domain_isp_ct;
	email_verification               := le.bs.email_summary.identity_email_verification_level;
	email_name_addr_verification     := le.bs.email_summary.reverse_email.verification_level;
	attr_num_unrel_liens60           := le.bs.bjl.liens_unreleased_count60;
	attr_eviction_count              := le.bs.bjl.eviction_count;
	attr_eviction_count90            := le.bs.bjl.eviction_count90;
	attr_eviction_count180           := le.bs.bjl.eviction_count180;
	attr_eviction_count12            := le.bs.bjl.eviction_count12;
	attr_eviction_count24            := le.bs.bjl.eviction_count24;
	attr_eviction_count36            := le.bs.bjl.eviction_count36;
	attr_eviction_count60            := le.bs.bjl.eviction_count60;
	attr_eviction_count84            := le.bs.BJL.eviction_count84;
	fp_idverrisktype                 := le.bs.fdattributesv2.idverrisklevel;
	fp_varrisktype                   := le.bs.fdattributesv2.variationrisklevel;
	fp_srchvelocityrisktype          := le.bs.fdattributesv2.searchvelocityrisklevel;
	fp_srchunvrfdssncount            := le.bs.fdattributesv2.searchunverifiedssncountyear;
	fp_srchunvrfdaddrcount           := le.bs.fdattributesv2.searchunverifiedaddrcountyear;
	fp_srchunvrfddobcount            := le.bs.fdattributesv2.searchunverifieddobcountyear;
	fp_srchunvrfdphonecount          := le.bs.fdattributesv2.searchunverifiedphonecountyear;;
	//fp_srchfraudsrchcount            := le.bs.fdattributesv2.searchfraudsearchcountyear;
	fp_srchfraudsrchcount            := le.bs.fdattributesv2.searchfraudsearchcount;
	fp_srchcomponentrisktype         := le.bs.fdattributesv2.searchcomponentrisklevel;
	fp_srchssnsrchcountmo            := le.bs.fdattributesv2.searchssnsearchcountmonth;
	fp_srchaddrsrchcountmo           := le.bs.fdattributesv2.searchaddrsearchcountmonth;;
	fp_srchphonesrchcountmo          := le.bs.fdattributesv2.searchphonesearchcountmonth;
	fp_prevaddrlenofres              := le.bs.fdattributesv2.prevaddrlenofres;
	fpc_idver_addressmatchescurr     := le.bs.fpattributes201.IDVerAddressMatchesCurrent;
	fpc_source_dl                    := le.bs.fpattributes201.SourceDriversLicense;
	bankrupt                         := le.bs.bjl.bankrupt;
	disposition                      := le.bs.bjl.disposition;
	filing_count                     := le.bs.bjl.filing_count;
	bk_dismissed_recent_count        := le.bs.bjl.bk_dismissed_recent_count;
	bk_dismissed_historical_count    := le.bs.bjl.bk_dismissed_historical_count;
	bk_disposed_recent_count         := le.bs.bjl.bk_disposed_recent_count;
	bk_disposed_historical_count     := le.bs.bjl.bk_disposed_historical_count;
	liens_recent_unrel_count         := le.bs.bjl.liens_recent_unreleased_count;
	liens_historical_unrel_count     := le.bs.bjl.liens_historical_unreleased_count;
	//liens_recent_rel_count           := le.bs.iid.did2_liens_recent_released_count;
	liens_recent_rel_count           := le.bs.bjl.liens_recent_released_count;
	//liens_historical_rel_count       := le.liens_historical_rel_count;
	liens_historical_rel_count  := le.bs.bjl.liens_historical_released_count;
	
	liens_last_unrel_date84          := le.bs.bjl.liens_last_unrel_date84;
	liens_unrel_total_amount         := le.bs.liens.liens_unrel_total_amount ;
	liens_rel_total_amount84         := le.bs.liens.liens_rel_total_amount84 ;
	liens_rel_total_amount           := le.bs.liens.liens_rel_total_amount ;
	liens_unrel_cj_ct                := le.bs.liens.liens_unreleased_civil_judgment.count;
	liens_unrel_cj_first_seen        := le.bs.liens.liens_unreleased_civil_judgment.earliest_filing_date;
	liens_unrel_cj_total_amount      := le.bs.liens.liens_unreleased_civil_judgment.total_amount;
	liens_rel_cj_ct                  := le.bs.liens.liens_released_civil_judgment.count;
	liens_unrel_ft_ct                := le.bs.liens.liens_unreleased_federal_tax.count;
	liens_unrel_ft_first_seen        := le.bs.liens.liens_unreleased_federal_tax.earliest_filing_date;
	liens_rel_ft_ct                  := le.bs.liens.liens_released_federal_tax.count;
	liens_unrel_fc_ct                := le.bs.liens.liens_unreleased_foreclosure.count;
	liens_rel_fc_ct                  := le.bs.liens.liens_released_foreclosure.count;
	liens_unrel_lt_ct                := le.bs.liens.liens_unreleased_landlord_tenant.count;
	liens_rel_lt_ct                  := le.bs.liens.liens_released_landlord_tenant.count;
	liens_unrel_o_ct                 := le.bs.liens.liens_unreleased_other_lj.count;
	liens_unrel_o_first_seen         := le.bs.liens.liens_unreleased_other_lj.earliest_filing_date;
	liens_unrel_o_total_amount       := le.bs.liens.liens_unreleased_other_lj.total_amount;
	liens_rel_o_ct                   := le.bs.liens.liens_released_other_lj.count;
	liens_rel_o_total_amount         := le.bs.liens.liens_released_other_lj.total_amount;
	liens_unrel_ot_ct                := le.bs.liens.liens_unreleased_other_tax.count;
	liens_unrel_ot_total_amount      := le.bs.liens.liens_unreleased_other_tax.total_amount;
	liens_rel_ot_ct                  := le.bs.liens.liens_released_other_tax.count;
	liens_rel_ot_total_amount        := le.bs.liens.liens_released_other_tax.total_amount;
	liens_unrel_sc_ct                := le.bs.liens.liens_unreleased_small_claims.count;
	liens_unrel_sc_total_amount      := le.bs.liens.liens_unreleased_small_claims.total_amount;
	liens_rel_sc_ct                  := le.bs.liens.liens_released_small_claims.count;
	liens_unrel_st_ct                := le.bs.liens.liens_unreleased_suits.count;
	liens_unrel_st_first_seen        := le.bs.liens.liens_unreleased_suits.earliest_filing_date;
	liens_unrel_st_last_seen         := le.bs.liens.liens_unreleased_suits.most_recent_filing_date;
	liens_rel_st_ct                  := le.bs.liens.liens_released_suits.count;
	criminal_count                   := le.bs.bjl.criminal_count;
	felony_count                     := le.bs.bjl.felony_count;
	hh_members_ct                    := le.bs.hhid_summary.hh_members_ct;
	hh_payday_loan_users             := le.bs.hhid_summary.hh_payday_loan_users;
	hh_members_w_derog               := le.bs.hhid_summary.hh_members_w_derog;
	hh_criminals                     := le.bs.hhid_summary.hh_criminals;
	rel_felony_count                 := le.bs.relatives.relative_felony_count;
	current_count                    := le.bs.vehicles.current_count;;
	historical_count                 := le.bs.vehicles.historical_count;
	acc_count                        := le.bs.accident_data.acc.num_accidents;
	acc_damage_amt_total             := le.bs.accident_data.acc.dmgamtaccidents;
	input_dob_match_level            := le.bs.dobmatchlevel;
	inferred_age                     := le.bs.inferred_age;
	//archive_date                     := le.bs.historydatetimestamp;
	archive_date                     := le.bs.historydate;
	



//***Begining of the SAS code that was converted to ECL ****//
NULL := -999999999;

INTEGER contains_i( string haystack, string needle ) := (INTEGER)(StringLib.StringFind(haystack, needle, 1) > 0);


//========================================================================================  
//===   for round 1 validation set the sysdate to the same value seen in the validation file
//===     sysdate := common.sas_date('20160501');	 
//===   for round 2 validation set the sysdate to the archive date
// sysdate := common.sas_date(if(le.historydate=999999, (    STRING)ut.getdate, (    STRING6)le.historydate+'01'));
//========================================================================================



//sysdate :=     __common__( (common.sas_date('20160501')));	
 sysdate :=     __common__( common.sas_date(if(le.bs.historydate=999999, (string8)Std.Date.Today(), (string6)le.bs.historydate+'01')));
sysdate8 :=     __common__( common.sas_date(if(le.bs.historydate=999999, (string8)Std.Date.Today(), (string6)le.bs.historydate+'01')));
//sysdate8 :=     __common__( (common.sas_date('20160501')));	
ver_src_am_pos :=     __common__( Models.Common.findw_cpp(ver_sources, 'AM' , '  ,', 'ie'));

ver_src_am :=     __common__( ver_src_am_pos > 0);

_ver_src_fdate_am :=     __common__( if(ver_src_am_pos > 0, Models.Common.getw(ver_sources_first_seen, ver_src_am_pos), '0'));

ver_src_fdate_am :=     __common__( common.sas_date((string)(_ver_src_fdate_am)));

ver_src_ar_pos :=     __common__( Models.Common.findw_cpp(ver_sources, 'AR' , '  ,', 'ie'));

ver_src_ar :=     __common__( ver_src_ar_pos > 0);

_ver_src_fdate_ar :=     __common__( if(ver_src_ar_pos > 0, Models.Common.getw(ver_sources_first_seen, ver_src_ar_pos), '0'));

ver_src_fdate_ar :=     __common__( common.sas_date((string)(_ver_src_fdate_ar)));

ver_src_ba_pos :=     __common__( Models.Common.findw_cpp(ver_sources, 'BA' , '  ,', 'ie'));

ver_src_ba :=     __common__( ver_src_ba_pos > 0);

_ver_src_fdate_ba :=     __common__( if(ver_src_ba_pos > 0, Models.Common.getw(ver_sources_first_seen, ver_src_ba_pos), '0'));

ver_src_fdate_ba :=     __common__( common.sas_date((string)(_ver_src_fdate_ba)));

ver_src_cg_pos :=     __common__( Models.Common.findw_cpp(ver_sources, 'CG' , '  ,', 'ie'));

ver_src_cg :=     __common__( ver_src_cg_pos > 0);

_ver_src_fdate_cg :=     __common__( if(ver_src_cg_pos > 0, Models.Common.getw(ver_sources_first_seen, ver_src_cg_pos), '0'));

ver_src_fdate_cg :=     __common__( common.sas_date((string)(_ver_src_fdate_cg)));

ver_src_da_pos :=     __common__( Models.Common.findw_cpp(ver_sources, 'DA' , '  ,', 'ie'));

ver_src_da :=     __common__( ver_src_da_pos > 0);

_ver_src_fdate_da :=     __common__( if(ver_src_da_pos > 0, Models.Common.getw(ver_sources_first_seen, ver_src_da_pos), '0'));

ver_src_fdate_da :=     __common__( common.sas_date((string)(_ver_src_fdate_da)));

ver_src_d_pos :=     __common__( Models.Common.findw_cpp(ver_sources, 'D' , '  ,', 'ie'));

ver_src_d :=     __common__( ver_src_d_pos > 0);

_ver_src_fdate_d :=     __common__( if(ver_src_d_pos > 0, Models.Common.getw(ver_sources_first_seen, ver_src_d_pos), '0'));

ver_src_fdate_d :=     __common__( common.sas_date((string)(_ver_src_fdate_d)));

ver_src_dl_pos :=     __common__( Models.Common.findw_cpp(ver_sources, 'DL' , '  ,', 'ie'));

ver_src_dl :=     __common__( ver_src_dl_pos > 0);

_ver_src_fdate_dl :=     __common__( if(ver_src_dl_pos > 0, Models.Common.getw(ver_sources_first_seen, ver_src_dl_pos), '0'));

ver_src_fdate_dl :=     __common__( common.sas_date((string)(_ver_src_fdate_dl)));

ver_src_eb_pos :=     __common__( Models.Common.findw_cpp(ver_sources, 'EB' , '  ,', 'ie'));

ver_src_eb :=     __common__( ver_src_eb_pos > 0);

_ver_src_fdate_eb :=     __common__( if(ver_src_eb_pos > 0, Models.Common.getw(ver_sources_first_seen, ver_src_eb_pos), '0'));

ver_src_fdate_eb :=     __common__( common.sas_date((string)(_ver_src_fdate_eb)));

ver_src_e1_pos :=     __common__( Models.Common.findw_cpp(ver_sources, 'E1' , '  ,', 'ie'));

ver_src_e1 :=     __common__( ver_src_e1_pos > 0);

_ver_src_fdate_e1 :=     __common__( if(ver_src_e1_pos > 0, Models.Common.getw(ver_sources_first_seen, ver_src_e1_pos), '0'));

ver_src_fdate_e1 :=     __common__( common.sas_date((string)(_ver_src_fdate_e1)));

ver_src_e2_pos :=     __common__( Models.Common.findw_cpp(ver_sources, 'E2' , '  ,', 'ie'));

ver_src_e2 :=     __common__( ver_src_e2_pos > 0);

_ver_src_fdate_e2 :=     __common__( if(ver_src_e2_pos > 0, Models.Common.getw(ver_sources_first_seen, ver_src_e2_pos), '0'));

ver_src_fdate_e2 :=     __common__( common.sas_date((string)(_ver_src_fdate_e2)));

ver_src_e3_pos :=     __common__( Models.Common.findw_cpp(ver_sources, 'E3' , '  ,', 'ie'));

ver_src_e3 :=     __common__( ver_src_e3_pos > 0);

_ver_src_fdate_e3 :=     __common__( if(ver_src_e3_pos > 0, Models.Common.getw(ver_sources_first_seen, ver_src_e3_pos), '0'));

ver_src_fdate_e3 :=     __common__( common.sas_date((string)(_ver_src_fdate_e3)));

ver_src_en_pos :=     __common__( Models.Common.findw_cpp(ver_sources, 'EN' , '  ,', 'ie'));

ver_src_en :=     __common__( ver_src_en_pos > 0);

_ver_src_fdate_en :=     __common__( if(ver_src_en_pos > 0, Models.Common.getw(ver_sources_first_seen, ver_src_en_pos), '0'));

ver_src_fdate_en :=     __common__( common.sas_date((string)(_ver_src_fdate_en)));

ver_src_eq_pos :=     __common__( Models.Common.findw_cpp(ver_sources, 'EQ' , '  ,', 'ie'));

ver_src_eq :=     __common__( ver_src_eq_pos > 0);

_ver_src_fdate_eq :=     __common__( if(ver_src_eq_pos > 0, Models.Common.getw(ver_sources_first_seen, ver_src_eq_pos), '0'));

ver_src_fdate_eq :=     __common__( common.sas_date((string)(_ver_src_fdate_eq)));

ver_src_fe_pos :=     __common__( Models.Common.findw_cpp(ver_sources, 'FE' , '  ,', 'ie'));

ver_src_fe :=     __common__( ver_src_fe_pos > 0);

_ver_src_fdate_fe :=     __common__( if(ver_src_fe_pos > 0, Models.Common.getw(ver_sources_first_seen, ver_src_fe_pos), '0'));

ver_src_fdate_fe :=     __common__( common.sas_date((string)(_ver_src_fdate_fe)));

ver_src_ff_pos :=     __common__( Models.Common.findw_cpp(ver_sources, 'FF' , '  ,', 'ie'));

ver_src_ff :=     __common__( ver_src_ff_pos > 0);

_ver_src_fdate_ff :=     __common__( if(ver_src_ff_pos > 0, Models.Common.getw(ver_sources_first_seen, ver_src_ff_pos), '0'));

ver_src_fdate_ff :=     __common__( common.sas_date((string)(_ver_src_fdate_ff)));

ver_src_p_pos :=     __common__( Models.Common.findw_cpp(ver_sources, 'P' , '  ,', 'ie'));

ver_src_p :=     __common__( ver_src_p_pos > 0);

_ver_src_fdate_p :=     __common__( if(ver_src_p_pos > 0, Models.Common.getw(ver_sources_first_seen, ver_src_p_pos), '0'));

ver_src_fdate_p :=     __common__( common.sas_date((string)(_ver_src_fdate_p)));

ver_src_pl_pos :=     __common__( Models.Common.findw_cpp(ver_sources, 'PL' , '  ,', 'ie'));

ver_src_pl :=     __common__( ver_src_pl_pos > 0);

_ver_src_fdate_pl :=     __common__( if(ver_src_pl_pos > 0, Models.Common.getw(ver_sources_first_seen, ver_src_pl_pos), '0'));

ver_src_fdate_pl :=     __common__( common.sas_date((string)(_ver_src_fdate_pl)));

ver_src_tn_pos :=     __common__( Models.Common.findw_cpp(ver_sources, 'TN' , '  ,', 'ie'));

ver_src_tn :=     __common__( ver_src_tn_pos > 0);

_ver_src_fdate_tn :=     __common__( if(ver_src_tn_pos > 0, Models.Common.getw(ver_sources_first_seen, ver_src_tn_pos), '0'));

ver_src_fdate_tn :=     __common__( common.sas_date((string)(_ver_src_fdate_tn)));

ver_src_sl_pos :=     __common__( Models.Common.findw_cpp(ver_sources, 'SL' , '  ,', 'ie'));

ver_src_sl :=     __common__( ver_src_sl_pos > 0);

_ver_src_fdate_sl :=     __common__( if(ver_src_sl_pos > 0, Models.Common.getw(ver_sources_first_seen, ver_src_sl_pos), '0'));

ver_src_fdate_sl :=     __common__( common.sas_date((string)(_ver_src_fdate_sl)));

ver_src_v_pos :=     __common__( Models.Common.findw_cpp(ver_sources, 'V' , '  ,', 'ie'));

ver_src_v :=     __common__( ver_src_v_pos > 0);

_ver_src_fdate_v :=     __common__( if(ver_src_v_pos > 0, Models.Common.getw(ver_sources_first_seen, ver_src_v_pos), '0'));

ver_src_fdate_v :=     __common__( common.sas_date((string)(_ver_src_fdate_v)));

ver_src_vo_pos :=     __common__( Models.Common.findw_cpp(ver_sources, 'VO' , '  ,', 'ie'));

ver_src_vo :=     __common__( ver_src_vo_pos > 0);

_ver_src_fdate_vo :=     __common__( if(ver_src_vo_pos > 0, Models.Common.getw(ver_sources_first_seen, ver_src_vo_pos), '0'));

ver_src_fdate_vo :=     __common__( common.sas_date((string)(_ver_src_fdate_vo)));

ver_src_w_pos :=     __common__( Models.Common.findw_cpp(ver_sources, 'W' , '  ,', 'ie'));

ver_src_w :=     __common__( ver_src_w_pos > 0);

_ver_src_fdate_w :=     __common__( if(ver_src_w_pos > 0, Models.Common.getw(ver_sources_first_seen, ver_src_w_pos), '0'));

ver_src_fdate_w :=     __common__( common.sas_date((string)(_ver_src_fdate_w)));

ver_fname_src_en_pos :=     __common__( Models.Common.findw_cpp(ver_fname_sources, 'EN' , '  ,', 'ie'));

ver_fname_src_en :=     __common__( ver_fname_src_en_pos > 0);

ver_fname_src_eq_pos :=     __common__( Models.Common.findw_cpp(ver_fname_sources, 'EQ' , '  ,', 'ie'));

ver_fname_src_eq :=     __common__( ver_fname_src_eq_pos > 0);

ver_fname_src_tn_pos :=     __common__( Models.Common.findw_cpp(ver_fname_sources, 'TN' , '  ,', 'ie'));

ver_fname_src_tn :=     __common__( ver_fname_src_tn_pos > 0);

ver_fname_src_ts_pos :=     __common__( Models.Common.findw_cpp(ver_fname_sources, 'TS' , '  ,', 'ie'));

ver_fname_src_ts :=     __common__( ver_fname_src_ts_pos > 0);

ver_fname_src_tu_pos :=     __common__( Models.Common.findw_cpp(ver_fname_sources, 'TU' , '  ,', 'ie'));

ver_fname_src_tu :=     __common__( ver_fname_src_tu_pos > 0);

ver_lname_src_en_pos :=     __common__( Models.Common.findw_cpp(ver_lname_sources, 'EN' , '  ,', 'ie'));

ver_lname_src_en :=     __common__( ver_lname_src_en_pos > 0);

ver_lname_src_eq_pos :=     __common__( Models.Common.findw_cpp(ver_lname_sources, 'EQ' , '  ,', 'ie'));

ver_lname_src_eq :=     __common__( ver_lname_src_eq_pos > 0);

ver_lname_src_tn_pos :=     __common__( Models.Common.findw_cpp(ver_lname_sources, 'TN' , '  ,', 'ie'));

ver_lname_src_tn :=     __common__( ver_lname_src_tn_pos > 0);

ver_lname_src_ts_pos :=     __common__( Models.Common.findw_cpp(ver_lname_sources, 'TS' , '  ,', 'ie'));

ver_lname_src_ts :=     __common__( ver_lname_src_ts_pos > 0);

ver_lname_src_tu_pos :=     __common__( Models.Common.findw_cpp(ver_lname_sources, 'TU' , '  ,', 'ie'));

ver_lname_src_tu :=     __common__( ver_lname_src_tu_pos > 0);

ver_addr_src_en_pos :=     __common__( Models.Common.findw_cpp(ver_addr_sources, 'EN' , '  ,', 'ie'));

ver_addr_src_en :=     __common__( ver_addr_src_en_pos > 0);

ver_addr_src_eq_pos :=     __common__( Models.Common.findw_cpp(ver_addr_sources, 'EQ' , '  ,', 'ie'));

ver_addr_src_eq :=     __common__( ver_addr_src_eq_pos > 0);

ver_addr_src_tn_pos :=     __common__( Models.Common.findw_cpp(ver_addr_sources, 'TN' , '  ,', 'ie'));

ver_addr_src_tn :=     __common__( ver_addr_src_tn_pos > 0);

ver_addr_src_ts_pos :=     __common__( Models.Common.findw_cpp(ver_addr_sources, 'TS' , '  ,', 'ie'));

ver_addr_src_ts :=     __common__( ver_addr_src_ts_pos > 0);

ver_addr_src_tu_pos :=     __common__( Models.Common.findw_cpp(ver_addr_sources, 'TU' , '  ,', 'ie'));

ver_addr_src_tu :=     __common__( ver_addr_src_tu_pos > 0);

ver_ssn_src_en_pos :=     __common__( Models.Common.findw_cpp(ver_ssn_sources, 'EN' , '  ,', 'ie'));

ver_ssn_src_en :=     __common__( ver_ssn_src_en_pos > 0);

ver_ssn_src_eq_pos :=     __common__( Models.Common.findw_cpp(ver_ssn_sources, 'EQ' , '  ,', 'ie'));

ver_ssn_src_eq :=     __common__( ver_ssn_src_eq_pos > 0);

ver_ssn_src_tn_pos :=     __common__( Models.Common.findw_cpp(ver_ssn_sources, 'TN' , '  ,', 'ie'));

ver_ssn_src_tn :=     __common__( ver_ssn_src_tn_pos > 0);

ver_ssn_src_ts_pos :=     __common__( Models.Common.findw_cpp(ver_ssn_sources, 'TS' , '  ,', 'ie'));

ver_ssn_src_ts :=     __common__( ver_ssn_src_ts_pos > 0);

ver_ssn_src_tu_pos :=     __common__( Models.Common.findw_cpp(ver_ssn_sources, 'TU' , '  ,', 'ie'));

ver_ssn_src_tu :=     __common__( ver_ssn_src_tu_pos > 0);

ver_dob_src_en_pos :=     __common__( Models.Common.findw_cpp(ver_dob_sources, 'EN' , '  ,', 'ie'));

ver_dob_src_en :=     __common__( ver_dob_src_en_pos > 0);

ver_dob_src_eq_pos :=     __common__( Models.Common.findw_cpp(ver_dob_sources, 'EQ' , '  ,', 'ie'));

ver_dob_src_eq :=     __common__( ver_dob_src_eq_pos > 0);

ver_dob_src_tn_pos :=     __common__( Models.Common.findw_cpp(ver_dob_sources, 'TN' , '  ,', 'ie'));

ver_dob_src_tn :=     __common__( ver_dob_src_tn_pos > 0);

ver_dob_src_ts_pos :=     __common__( Models.Common.findw_cpp(ver_dob_sources, 'TS' , '  ,', 'ie'));

ver_dob_src_ts :=     __common__( ver_dob_src_ts_pos > 0);

ver_dob_src_tu_pos :=     __common__( Models.Common.findw_cpp(ver_dob_sources, 'TU' , '  ,', 'ie'));

ver_dob_src_tu :=     __common__( ver_dob_src_tu_pos > 0);

util_type_2_pos :=     __common__( Models.Common.findw_cpp(util_adl_type_list, '2' , '  ,', 'ie'));

util_type_2 :=     __common__( util_type_2_pos > 0);

util_type_1_pos :=     __common__( Models.Common.findw_cpp(util_adl_type_list, '1' , '  ,', 'ie'));

util_type_1 :=     __common__( util_type_1_pos > 0);

util_type_z_pos :=     __common__( Models.Common.findw_cpp(util_adl_type_list, 'Z' , '  ,', 'ie'));

util_type_z :=     __common__( util_type_z_pos > 0);

util_inp_2_pos :=     __common__( Models.Common.findw_cpp(util_add_input_type_list, '2' , '  ,', 'ie'));

util_inp_2 :=     __common__( util_inp_2_pos > 0);

util_inp_1_pos :=     __common__( Models.Common.findw_cpp(util_add_input_type_list, '1' , '  ,', 'ie'));

util_inp_1 :=     __common__( util_inp_1_pos > 0);

util_inp_z_pos :=     __common__( Models.Common.findw_cpp(util_add_input_type_list, 'Z' , '  ,', 'ie'));

util_inp_z :=     __common__( util_inp_z_pos > 0);

util_curr_2_pos :=     __common__( Models.Common.findw_cpp(util_add_curr_type_list, '2' , '  ,', 'ie'));

util_curr_2 :=     __common__( util_curr_2_pos > 0);

util_curr_1_pos :=     __common__( Models.Common.findw_cpp(util_add_curr_type_list, '1' , '  ,', 'ie'));

util_curr_1 :=     __common__( util_curr_1_pos > 0);

util_curr_z_pos :=     __common__( Models.Common.findw_cpp(util_add_curr_type_list, 'Z' , '  ,', 'ie'));

util_curr_z :=     __common__( util_curr_z_pos > 0);

bs_ver_src_ar_pos :=     __common__( Models.Common.findw_cpp(bus_ver_sources, 'AR' , '  ,', 'ie'));

_bs_ver_src_fdate_ar :=     __common__( if(bs_ver_src_ar_pos > 0, Models.Common.getw(bus_ver_sources_fseen, bs_ver_src_ar_pos), '0'));

bs_ver_src_fdate_ar :=     __common__( common.sas_date((string)(_bs_ver_src_fdate_ar)));

_bs_ver_src_ldate_ar :=     __common__( if(bs_ver_src_ar_pos > 0, Models.Common.getw(bus_ver_sources_lseen, bs_ver_src_ar_pos), '0'));

bs_ver_src_ldate_ar :=     __common__( common.sas_date((string)(_bs_ver_src_ldate_ar)));

bs_ver_src_ba_pos :=     __common__( Models.Common.findw_cpp(bus_ver_sources, 'BA' , '  ,', 'ie'));

_bs_ver_src_fdate_ba :=     __common__( if(bs_ver_src_ba_pos > 0, Models.Common.getw(bus_ver_sources_fseen, bs_ver_src_ba_pos), '0'));

bs_ver_src_fdate_ba :=     __common__( common.sas_date((string)(_bs_ver_src_fdate_ba)));

_bs_ver_src_ldate_ba :=     __common__( if(bs_ver_src_ba_pos > 0, Models.Common.getw(bus_ver_sources_lseen, bs_ver_src_ba_pos), '0'));

bs_ver_src_ldate_ba :=     __common__( common.sas_date((string)(_bs_ver_src_ldate_ba)));

bs_ver_src_bc_pos :=     __common__( Models.Common.findw_cpp(bus_ver_sources, 'BC' , '  ,', 'ie'));

_bs_ver_src_fdate_bc :=     __common__( if(bs_ver_src_bc_pos > 0, Models.Common.getw(bus_ver_sources_fseen, bs_ver_src_bc_pos), '0'));

bs_ver_src_fdate_bc :=     __common__( common.sas_date((string)(_bs_ver_src_fdate_bc)));

_bs_ver_src_ldate_bc :=     __common__( if(bs_ver_src_bc_pos > 0, Models.Common.getw(bus_ver_sources_lseen, bs_ver_src_bc_pos), '0'));

bs_ver_src_ldate_bc :=     __common__( common.sas_date((string)(_bs_ver_src_ldate_bc)));

bs_ver_src_bm_pos :=     __common__( Models.Common.findw_cpp(bus_ver_sources, 'BM' , '  ,', 'ie'));

_bs_ver_src_fdate_bm :=     __common__( if(bs_ver_src_bm_pos > 0, Models.Common.getw(bus_ver_sources_fseen, bs_ver_src_bm_pos), '0'));

bs_ver_src_fdate_bm :=     __common__( common.sas_date((string)(_bs_ver_src_fdate_bm)));

_bs_ver_src_ldate_bm :=     __common__( if(bs_ver_src_bm_pos > 0, Models.Common.getw(bus_ver_sources_lseen, bs_ver_src_bm_pos), '0'));

bs_ver_src_ldate_bm :=     __common__( common.sas_date((string)(_bs_ver_src_ldate_bm)));

bs_ver_src_bn_pos :=     __common__( Models.Common.findw_cpp(bus_ver_sources, 'BN' , '  ,', 'ie'));

_bs_ver_src_fdate_bn :=     __common__( if(bs_ver_src_bn_pos > 0, Models.Common.getw(bus_ver_sources_fseen, bs_ver_src_bn_pos), '0'));

bs_ver_src_fdate_bn :=     __common__( common.sas_date((string)(_bs_ver_src_fdate_bn)));

_bs_ver_src_ldate_bn :=     __common__( if(bs_ver_src_bn_pos > 0, Models.Common.getw(bus_ver_sources_lseen, bs_ver_src_bn_pos), '0'));

bs_ver_src_ldate_bn :=     __common__( common.sas_date((string)(_bs_ver_src_ldate_bn)));

bs_ver_src_br_pos :=     __common__( Models.Common.findw_cpp(bus_ver_sources, 'BR' , '  ,', 'ie'));

_bs_ver_src_fdate_br :=     __common__( if(bs_ver_src_br_pos > 0, Models.Common.getw(bus_ver_sources_fseen, bs_ver_src_br_pos), '0'));

bs_ver_src_fdate_br :=     __common__( common.sas_date((string)(_bs_ver_src_fdate_br)));

_bs_ver_src_ldate_br :=     __common__( if(bs_ver_src_br_pos > 0, Models.Common.getw(bus_ver_sources_lseen, bs_ver_src_br_pos), '0'));

bs_ver_src_ldate_br :=     __common__( common.sas_date((string)(_bs_ver_src_ldate_br)));

bs_ver_src_by_pos :=     __common__( Models.Common.findw_cpp(bus_ver_sources, 'BY' , '  ,', 'ie'));

_bs_ver_src_fdate_by :=     __common__( if(bs_ver_src_by_pos > 0, Models.Common.getw(bus_ver_sources_fseen, bs_ver_src_by_pos), '0'));

bs_ver_src_fdate_by :=     __common__( common.sas_date((string)(_bs_ver_src_fdate_by)));

_bs_ver_src_ldate_by :=     __common__( if(bs_ver_src_by_pos > 0, Models.Common.getw(bus_ver_sources_lseen, bs_ver_src_by_pos), '0'));

bs_ver_src_ldate_by :=     __common__( common.sas_date((string)(_bs_ver_src_ldate_by)));

bs_ver_src_c_pos :=     __common__( Models.Common.findw_cpp(bus_ver_sources, 'C' , '  ,', 'ie'));

_bs_ver_src_fdate_c :=     __common__( if(bs_ver_src_c_pos > 0, Models.Common.getw(bus_ver_sources_fseen, bs_ver_src_c_pos), '0'));

bs_ver_src_fdate_c :=     __common__( common.sas_date((string)(_bs_ver_src_fdate_c)));

_bs_ver_src_ldate_c :=     __common__( if(bs_ver_src_c_pos > 0, Models.Common.getw(bus_ver_sources_lseen, bs_ver_src_c_pos), '0'));

bs_ver_src_ldate_c :=     __common__( common.sas_date((string)(_bs_ver_src_ldate_c)));

bs_ver_src_cs_pos :=     __common__( Models.Common.findw_cpp(bus_ver_sources, 'C#' , '  ,', 'ie'));

_bs_ver_src_fdate_cs :=     __common__( if(bs_ver_src_cs_pos > 0, Models.Common.getw(bus_ver_sources_fseen, bs_ver_src_cs_pos), '0'));

bs_ver_src_fdate_cs :=     __common__( common.sas_date((string)(_bs_ver_src_fdate_cs)));

_bs_ver_src_ldate_cs :=     __common__( if(bs_ver_src_cs_pos > 0, Models.Common.getw(bus_ver_sources_lseen, bs_ver_src_cs_pos), '0'));

bs_ver_src_ldate_cs :=     __common__( common.sas_date((string)(_bs_ver_src_ldate_cs)));

bs_ver_src_cf_pos :=     __common__( Models.Common.findw_cpp(bus_ver_sources, 'CF' , '  ,', 'ie'));

_bs_ver_src_fdate_cf :=     __common__( if(bs_ver_src_cf_pos > 0, Models.Common.getw(bus_ver_sources_fseen, bs_ver_src_cf_pos), '0'));

bs_ver_src_fdate_cf :=     __common__( common.sas_date((string)(_bs_ver_src_fdate_cf)));

_bs_ver_src_ldate_cf :=     __common__( if(bs_ver_src_cf_pos > 0, Models.Common.getw(bus_ver_sources_lseen, bs_ver_src_cf_pos), '0'));

bs_ver_src_ldate_cf :=     __common__( common.sas_date((string)(_bs_ver_src_ldate_cf)));

bs_ver_src_cu_pos :=     __common__( Models.Common.findw_cpp(bus_ver_sources, 'CU' , '  ,', 'ie'));

_bs_ver_src_fdate_cu :=     __common__( if(bs_ver_src_cu_pos > 0, Models.Common.getw(bus_ver_sources_fseen, bs_ver_src_cu_pos), '0'));

bs_ver_src_fdate_cu :=     __common__( common.sas_date((string)(_bs_ver_src_fdate_cu)));

_bs_ver_src_ldate_cu :=     __common__( if(bs_ver_src_cu_pos > 0, Models.Common.getw(bus_ver_sources_lseen, bs_ver_src_cu_pos), '0'));

bs_ver_src_ldate_cu :=     __common__( common.sas_date((string)(_bs_ver_src_ldate_cu)));

bs_ver_src_d_pos :=     __common__( Models.Common.findw_cpp(bus_ver_sources, 'D' , '  ,', 'ie'));

_bs_ver_src_fdate_d :=     __common__( if(bs_ver_src_d_pos > 0, Models.Common.getw(bus_ver_sources_fseen, bs_ver_src_d_pos), '0'));

bs_ver_src_fdate_d :=     __common__( common.sas_date((string)(_bs_ver_src_fdate_d)));

_bs_ver_src_ldate_d :=     __common__( if(bs_ver_src_d_pos > 0, Models.Common.getw(bus_ver_sources_lseen, bs_ver_src_d_pos), '0'));

bs_ver_src_ldate_d :=     __common__( common.sas_date((string)(_bs_ver_src_ldate_d)));

bs_ver_src_da_pos :=     __common__( Models.Common.findw_cpp(bus_ver_sources, 'DA' , '  ,', 'ie'));

_bs_ver_src_fdate_da :=     __common__( if(bs_ver_src_da_pos > 0, Models.Common.getw(bus_ver_sources_fseen, bs_ver_src_da_pos), '0'));

bs_ver_src_fdate_da :=     __common__( common.sas_date((string)(_bs_ver_src_fdate_da)));

_bs_ver_src_ldate_da :=     __common__( if(bs_ver_src_da_pos > 0, Models.Common.getw(bus_ver_sources_lseen, bs_ver_src_da_pos), '0'));

bs_ver_src_ldate_da :=     __common__( common.sas_date((string)(_bs_ver_src_ldate_da)));

bs_ver_src_df_pos :=     __common__( Models.Common.findw_cpp(bus_ver_sources, 'DF' , '  ,', 'ie'));

_bs_ver_src_fdate_df :=     __common__( if(bs_ver_src_df_pos > 0, Models.Common.getw(bus_ver_sources_fseen, bs_ver_src_df_pos), '0'));

bs_ver_src_fdate_df :=     __common__( common.sas_date((string)(_bs_ver_src_fdate_df)));

_bs_ver_src_ldate_df :=     __common__( if(bs_ver_src_df_pos > 0, Models.Common.getw(bus_ver_sources_lseen, bs_ver_src_df_pos), '0'));

bs_ver_src_ldate_df :=     __common__( common.sas_date((string)(_bs_ver_src_ldate_df)));

bs_ver_src_dn_pos :=     __common__( Models.Common.findw_cpp(bus_ver_sources, 'DN' , '  ,', 'ie'));

_bs_ver_src_fdate_dn :=     __common__( if(bs_ver_src_dn_pos > 0, Models.Common.getw(bus_ver_sources_fseen, bs_ver_src_dn_pos), '0'));

bs_ver_src_fdate_dn :=     __common__( common.sas_date((string)(_bs_ver_src_fdate_dn)));

_bs_ver_src_ldate_dn :=     __common__( if(bs_ver_src_dn_pos > 0, Models.Common.getw(bus_ver_sources_lseen, bs_ver_src_dn_pos), '0'));

bs_ver_src_ldate_dn :=     __common__( common.sas_date((string)(_bs_ver_src_ldate_dn)));

bs_ver_src_e_pos :=     __common__( Models.Common.findw_cpp(bus_ver_sources, 'E' , '  ,', 'ie'));

_bs_ver_src_fdate_e :=     __common__( if(bs_ver_src_e_pos > 0, Models.Common.getw(bus_ver_sources_fseen, bs_ver_src_e_pos), '0'));

bs_ver_src_fdate_e :=     __common__( common.sas_date((string)(_bs_ver_src_fdate_e)));

_bs_ver_src_ldate_e :=     __common__( if(bs_ver_src_e_pos > 0, Models.Common.getw(bus_ver_sources_lseen, bs_ver_src_e_pos), '0'));

bs_ver_src_ldate_e :=     __common__( common.sas_date((string)(_bs_ver_src_ldate_e)));

bs_ver_src_ef_pos :=     __common__( Models.Common.findw_cpp(bus_ver_sources, 'EF' , '  ,', 'ie'));

_bs_ver_src_fdate_ef :=     __common__( if(bs_ver_src_ef_pos > 0, Models.Common.getw(bus_ver_sources_fseen, bs_ver_src_ef_pos), '0'));

bs_ver_src_fdate_ef :=     __common__( common.sas_date((string)(_bs_ver_src_fdate_ef)));

_bs_ver_src_ldate_ef :=     __common__( if(bs_ver_src_ef_pos > 0, Models.Common.getw(bus_ver_sources_lseen, bs_ver_src_ef_pos), '0'));

bs_ver_src_ldate_ef :=     __common__( common.sas_date((string)(_bs_ver_src_ldate_ef)));

bs_ver_src_er_pos :=     __common__( Models.Common.findw_cpp(bus_ver_sources, 'ER' , '  ,', 'ie'));

_bs_ver_src_fdate_er :=     __common__( if(bs_ver_src_er_pos > 0, Models.Common.getw(bus_ver_sources_fseen, bs_ver_src_er_pos), '0'));

bs_ver_src_fdate_er :=     __common__( common.sas_date((string)(_bs_ver_src_fdate_er)));

_bs_ver_src_ldate_er :=     __common__( if(bs_ver_src_er_pos > 0, Models.Common.getw(bus_ver_sources_lseen, bs_ver_src_er_pos), '0'));

bs_ver_src_ldate_er :=     __common__( common.sas_date((string)(_bs_ver_src_ldate_er)));

bs_ver_src_ey_pos :=     __common__( Models.Common.findw_cpp(bus_ver_sources, 'EY' , '  ,', 'ie'));

_bs_ver_src_fdate_ey :=     __common__( if(bs_ver_src_ey_pos > 0, Models.Common.getw(bus_ver_sources_fseen, bs_ver_src_ey_pos), '0'));

bs_ver_src_fdate_ey :=     __common__( common.sas_date((string)(_bs_ver_src_fdate_ey)));

_bs_ver_src_ldate_ey :=     __common__( if(bs_ver_src_ey_pos > 0, Models.Common.getw(bus_ver_sources_lseen, bs_ver_src_ey_pos), '0'));

bs_ver_src_ldate_ey :=     __common__( common.sas_date((string)(_bs_ver_src_ldate_ey)));

bs_ver_src_f_pos :=     __common__( Models.Common.findw_cpp(bus_ver_sources, 'F' , '  ,', 'ie'));

_bs_ver_src_fdate_f :=     __common__( if(bs_ver_src_f_pos > 0, Models.Common.getw(bus_ver_sources_fseen, bs_ver_src_f_pos), '0'));

bs_ver_src_fdate_f :=     __common__( common.sas_date((string)(_bs_ver_src_fdate_f)));

_bs_ver_src_ldate_f :=     __common__( if(bs_ver_src_f_pos > 0, Models.Common.getw(bus_ver_sources_lseen, bs_ver_src_f_pos), '0'));

bs_ver_src_ldate_f :=     __common__( common.sas_date((string)(_bs_ver_src_ldate_f)));

bs_ver_src_fb_pos :=     __common__( Models.Common.findw_cpp(bus_ver_sources, 'FB' , '  ,', 'ie'));

_bs_ver_src_fdate_fb :=     __common__( if(bs_ver_src_fb_pos > 0, Models.Common.getw(bus_ver_sources_fseen, bs_ver_src_fb_pos), '0'));

bs_ver_src_fdate_fb :=     __common__( common.sas_date((string)(_bs_ver_src_fdate_fb)));

_bs_ver_src_ldate_fb :=     __common__( if(bs_ver_src_fb_pos > 0, Models.Common.getw(bus_ver_sources_lseen, bs_ver_src_fb_pos), '0'));

bs_ver_src_ldate_fb :=     __common__( common.sas_date((string)(_bs_ver_src_ldate_fb)));

bs_ver_src_fi_pos :=     __common__( Models.Common.findw_cpp(bus_ver_sources, 'FI' , '  ,', 'ie'));

_bs_ver_src_fdate_fi :=     __common__( if(bs_ver_src_fi_pos > 0, Models.Common.getw(bus_ver_sources_fseen, bs_ver_src_fi_pos), '0'));

bs_ver_src_fdate_fi :=     __common__( common.sas_date((string)(_bs_ver_src_fdate_fi)));

_bs_ver_src_ldate_fi :=     __common__( if(bs_ver_src_fi_pos > 0, Models.Common.getw(bus_ver_sources_lseen, bs_ver_src_fi_pos), '0'));

bs_ver_src_ldate_fi :=     __common__( common.sas_date((string)(_bs_ver_src_ldate_fi)));

bs_ver_src_fk_pos :=     __common__( Models.Common.findw_cpp(bus_ver_sources, 'FK' , '  ,', 'ie'));

_bs_ver_src_fdate_fk :=     __common__( if(bs_ver_src_fk_pos > 0, Models.Common.getw(bus_ver_sources_fseen, bs_ver_src_fk_pos), '0'));

bs_ver_src_fdate_fk :=     __common__( common.sas_date((string)(_bs_ver_src_fdate_fk)));

_bs_ver_src_ldate_fk :=     __common__( if(bs_ver_src_fk_pos > 0, Models.Common.getw(bus_ver_sources_lseen, bs_ver_src_fk_pos), '0'));

bs_ver_src_ldate_fk :=     __common__( common.sas_date((string)(_bs_ver_src_ldate_fk)));

bs_ver_src_fr_pos :=     __common__( Models.Common.findw_cpp(bus_ver_sources, 'FR' , '  ,', 'ie'));

_bs_ver_src_fdate_fr :=     __common__( if(bs_ver_src_fr_pos > 0, Models.Common.getw(bus_ver_sources_fseen, bs_ver_src_fr_pos), '0'));

bs_ver_src_fdate_fr :=     __common__( common.sas_date((string)(_bs_ver_src_fdate_fr)));

_bs_ver_src_ldate_fr :=     __common__( if(bs_ver_src_fr_pos > 0, Models.Common.getw(bus_ver_sources_lseen, bs_ver_src_fr_pos), '0'));

bs_ver_src_ldate_fr :=     __common__( common.sas_date((string)(_bs_ver_src_ldate_fr)));

bs_ver_src_ft_pos :=     __common__( Models.Common.findw_cpp(bus_ver_sources, 'FT' , '  ,', 'ie'));

_bs_ver_src_fdate_ft :=     __common__( if(bs_ver_src_ft_pos > 0, Models.Common.getw(bus_ver_sources_fseen, bs_ver_src_ft_pos), '0'));

bs_ver_src_fdate_ft :=     __common__( common.sas_date((string)(_bs_ver_src_fdate_ft)));

_bs_ver_src_ldate_ft :=     __common__( if(bs_ver_src_ft_pos > 0, Models.Common.getw(bus_ver_sources_lseen, bs_ver_src_ft_pos), '0'));

bs_ver_src_ldate_ft :=     __common__( common.sas_date((string)(_bs_ver_src_ldate_ft)));

bs_ver_src_gb_pos :=     __common__( Models.Common.findw_cpp(bus_ver_sources, 'GB' , '  ,', 'ie'));

_bs_ver_src_fdate_gb :=     __common__( if(bs_ver_src_gb_pos > 0, Models.Common.getw(bus_ver_sources_fseen, bs_ver_src_gb_pos), '0'));

bs_ver_src_fdate_gb :=     __common__( common.sas_date((string)(_bs_ver_src_fdate_gb)));

_bs_ver_src_ldate_gb :=     __common__( if(bs_ver_src_gb_pos > 0, Models.Common.getw(bus_ver_sources_lseen, bs_ver_src_gb_pos), '0'));

bs_ver_src_ldate_gb :=     __common__( common.sas_date((string)(_bs_ver_src_ldate_gb)));

bs_ver_src_gr_pos :=     __common__( Models.Common.findw_cpp(bus_ver_sources, 'GR' , '  ,', 'ie'));

_bs_ver_src_fdate_gr :=     __common__( if(bs_ver_src_gr_pos > 0, Models.Common.getw(bus_ver_sources_fseen, bs_ver_src_gr_pos), '0'));

bs_ver_src_fdate_gr :=     __common__( common.sas_date((string)(_bs_ver_src_fdate_gr)));

_bs_ver_src_ldate_gr :=     __common__( if(bs_ver_src_gr_pos > 0, Models.Common.getw(bus_ver_sources_lseen, bs_ver_src_gr_pos), '0'));

bs_ver_src_ldate_gr :=     __common__( common.sas_date((string)(_bs_ver_src_ldate_gr)));

bs_ver_src_h7_pos :=     __common__( Models.Common.findw_cpp(bus_ver_sources, 'H7' , '  ,', 'ie'));

_bs_ver_src_fdate_h7 :=     __common__( if(bs_ver_src_h7_pos > 0, Models.Common.getw(bus_ver_sources_fseen, bs_ver_src_h7_pos), '0'));

bs_ver_src_fdate_h7 :=     __common__( common.sas_date((string)(_bs_ver_src_fdate_h7)));

_bs_ver_src_ldate_h7 :=     __common__( if(bs_ver_src_h7_pos > 0, Models.Common.getw(bus_ver_sources_lseen, bs_ver_src_h7_pos), '0'));

bs_ver_src_ldate_h7 :=     __common__( common.sas_date((string)(_bs_ver_src_ldate_h7)));

bs_ver_src_i_pos :=     __common__( Models.Common.findw_cpp(bus_ver_sources, 'I' , '  ,', 'ie'));

_bs_ver_src_fdate_i :=     __common__( if(bs_ver_src_i_pos > 0, Models.Common.getw(bus_ver_sources_fseen, bs_ver_src_i_pos), '0'));

bs_ver_src_fdate_i :=     __common__( common.sas_date((string)(_bs_ver_src_fdate_i)));

_bs_ver_src_ldate_i :=     __common__( if(bs_ver_src_i_pos > 0, Models.Common.getw(bus_ver_sources_lseen, bs_ver_src_i_pos), '0'));

bs_ver_src_ldate_i :=     __common__( common.sas_date((string)(_bs_ver_src_ldate_i)));

bs_ver_src_ia_pos :=     __common__( Models.Common.findw_cpp(bus_ver_sources, 'IA' , '  ,', 'ie'));

_bs_ver_src_fdate_ia :=     __common__( if(bs_ver_src_ia_pos > 0, Models.Common.getw(bus_ver_sources_fseen, bs_ver_src_ia_pos), '0'));

bs_ver_src_fdate_ia :=     __common__( common.sas_date((string)(_bs_ver_src_fdate_ia)));

_bs_ver_src_ldate_ia :=     __common__( if(bs_ver_src_ia_pos > 0, Models.Common.getw(bus_ver_sources_lseen, bs_ver_src_ia_pos), '0'));

bs_ver_src_ldate_ia :=     __common__( common.sas_date((string)(_bs_ver_src_ldate_ia)));

bs_ver_src_ic_pos :=     __common__( Models.Common.findw_cpp(bus_ver_sources, 'IC' , '  ,', 'ie'));

_bs_ver_src_fdate_ic :=     __common__( if(bs_ver_src_ic_pos > 0, Models.Common.getw(bus_ver_sources_fseen, bs_ver_src_ic_pos), '0'));

bs_ver_src_fdate_ic :=     __common__( common.sas_date((string)(_bs_ver_src_fdate_ic)));

_bs_ver_src_ldate_ic :=     __common__( if(bs_ver_src_ic_pos > 0, Models.Common.getw(bus_ver_sources_lseen, bs_ver_src_ic_pos), '0'));

bs_ver_src_ldate_ic :=     __common__( common.sas_date((string)(_bs_ver_src_ldate_ic)));

bs_ver_src_in_pos :=     __common__( Models.Common.findw_cpp(bus_ver_sources, 'IN' , '  ,', 'ie'));

_bs_ver_src_fdate_in :=     __common__( if(bs_ver_src_in_pos > 0, Models.Common.getw(bus_ver_sources_fseen, bs_ver_src_in_pos), '0'));

bs_ver_src_fdate_in :=     __common__( common.sas_date((string)(_bs_ver_src_fdate_in)));

_bs_ver_src_ldate_in :=     __common__( if(bs_ver_src_in_pos > 0, Models.Common.getw(bus_ver_sources_lseen, bs_ver_src_in_pos), '0'));

bs_ver_src_ldate_in :=     __common__( common.sas_date((string)(_bs_ver_src_ldate_in)));

bs_ver_src_ip_pos :=     __common__( Models.Common.findw_cpp(bus_ver_sources, 'IP' , '  ,', 'ie'));

_bs_ver_src_fdate_ip :=     __common__( if(bs_ver_src_ip_pos > 0, Models.Common.getw(bus_ver_sources_fseen, bs_ver_src_ip_pos), '0'));

bs_ver_src_fdate_ip :=     __common__( common.sas_date((string)(_bs_ver_src_fdate_ip)));

_bs_ver_src_ldate_ip :=     __common__( if(bs_ver_src_ip_pos > 0, Models.Common.getw(bus_ver_sources_lseen, bs_ver_src_ip_pos), '0'));

bs_ver_src_ldate_ip :=     __common__( common.sas_date((string)(_bs_ver_src_ldate_ip)));

bs_ver_src_is_pos :=     __common__( Models.Common.findw_cpp(bus_ver_sources, 'IS' , '  ,', 'ie'));

_bs_ver_src_fdate_is :=     __common__( if(bs_ver_src_is_pos > 0, Models.Common.getw(bus_ver_sources_fseen, bs_ver_src_is_pos), '0'));

bs_ver_src_fdate_is :=     __common__( common.sas_date((string)(_bs_ver_src_fdate_is)));

_bs_ver_src_ldate_is :=     __common__( if(bs_ver_src_is_pos > 0, Models.Common.getw(bus_ver_sources_lseen, bs_ver_src_is_pos), '0'));

bs_ver_src_ldate_is :=     __common__( common.sas_date((string)(_bs_ver_src_ldate_is)));

bs_ver_src_it_pos :=     __common__( Models.Common.findw_cpp(bus_ver_sources, 'IT' , '  ,', 'ie'));

_bs_ver_src_fdate_it :=     __common__( if(bs_ver_src_it_pos > 0, Models.Common.getw(bus_ver_sources_fseen, bs_ver_src_it_pos), '0'));

bs_ver_src_fdate_it :=     __common__( common.sas_date((string)(_bs_ver_src_fdate_it)));

_bs_ver_src_ldate_it :=     __common__( if(bs_ver_src_it_pos > 0, Models.Common.getw(bus_ver_sources_lseen, bs_ver_src_it_pos), '0'));

bs_ver_src_ldate_it :=     __common__( common.sas_date((string)(_bs_ver_src_ldate_it)));

bs_ver_src_j2_pos :=     __common__( Models.Common.findw_cpp(bus_ver_sources, 'J2' , '  ,', 'ie'));

_bs_ver_src_fdate_j2 :=     __common__( if(bs_ver_src_j2_pos > 0, Models.Common.getw(bus_ver_sources_fseen, bs_ver_src_j2_pos), '0'));

bs_ver_src_fdate_j2 :=     __common__( common.sas_date((string)(_bs_ver_src_fdate_j2)));

_bs_ver_src_ldate_j2 :=     __common__( if(bs_ver_src_j2_pos > 0, Models.Common.getw(bus_ver_sources_lseen, bs_ver_src_j2_pos), '0'));

bs_ver_src_ldate_j2 :=     __common__( common.sas_date((string)(_bs_ver_src_ldate_j2)));

bs_ver_src_kc_pos :=     __common__( Models.Common.findw_cpp(bus_ver_sources, 'KC' , '  ,', 'ie'));

_bs_ver_src_fdate_kc :=     __common__( if(bs_ver_src_kc_pos > 0, Models.Common.getw(bus_ver_sources_fseen, bs_ver_src_kc_pos), '0'));

bs_ver_src_fdate_kc :=     __common__( common.sas_date((string)(_bs_ver_src_fdate_kc)));

_bs_ver_src_ldate_kc :=     __common__( if(bs_ver_src_kc_pos > 0, Models.Common.getw(bus_ver_sources_lseen, bs_ver_src_kc_pos), '0'));

bs_ver_src_ldate_kc :=     __common__( common.sas_date((string)(_bs_ver_src_ldate_kc)));

bs_ver_src_l0_pos :=     __common__( Models.Common.findw_cpp(bus_ver_sources, 'L0' , '  ,', 'ie'));

_bs_ver_src_fdate_l0 :=     __common__( if(bs_ver_src_l0_pos > 0, Models.Common.getw(bus_ver_sources_fseen, bs_ver_src_l0_pos), '0'));

bs_ver_src_fdate_l0 :=     __common__( common.sas_date((string)(_bs_ver_src_fdate_l0)));

_bs_ver_src_ldate_l0 :=     __common__( if(bs_ver_src_l0_pos > 0, Models.Common.getw(bus_ver_sources_lseen, bs_ver_src_l0_pos), '0'));

bs_ver_src_ldate_l0 :=     __common__( common.sas_date((string)(_bs_ver_src_ldate_l0)));

bs_ver_src_l2_pos :=     __common__( Models.Common.findw_cpp(bus_ver_sources, 'L2' , '  ,', 'ie'));

_bs_ver_src_fdate_l2 :=     __common__( if(bs_ver_src_l2_pos > 0, Models.Common.getw(bus_ver_sources_fseen, bs_ver_src_l2_pos), '0'));

bs_ver_src_fdate_l2 :=     __common__( common.sas_date((string)(_bs_ver_src_fdate_l2)));

_bs_ver_src_ldate_l2 :=     __common__( if(bs_ver_src_l2_pos > 0, Models.Common.getw(bus_ver_sources_lseen, bs_ver_src_l2_pos), '0'));

bs_ver_src_ldate_l2 :=     __common__( common.sas_date((string)(_bs_ver_src_ldate_l2)));

bs_ver_src_mh_pos :=     __common__( Models.Common.findw_cpp(bus_ver_sources, 'MH' , '  ,', 'ie'));

_bs_ver_src_fdate_mh :=     __common__( if(bs_ver_src_mh_pos > 0, Models.Common.getw(bus_ver_sources_fseen, bs_ver_src_mh_pos), '0'));

bs_ver_src_fdate_mh :=     __common__( common.sas_date((string)(_bs_ver_src_fdate_mh)));

_bs_ver_src_ldate_mh :=     __common__( if(bs_ver_src_mh_pos > 0, Models.Common.getw(bus_ver_sources_lseen, bs_ver_src_mh_pos), '0'));

bs_ver_src_ldate_mh :=     __common__( common.sas_date((string)(_bs_ver_src_ldate_mh)));

bs_ver_src_mw_pos :=     __common__( Models.Common.findw_cpp(bus_ver_sources, 'MW' , '  ,', 'ie'));

_bs_ver_src_fdate_mw :=     __common__( if(bs_ver_src_mw_pos > 0, Models.Common.getw(bus_ver_sources_fseen, bs_ver_src_mw_pos), '0'));

bs_ver_src_fdate_mw :=     __common__( common.sas_date((string)(_bs_ver_src_fdate_mw)));

_bs_ver_src_ldate_mw :=     __common__( if(bs_ver_src_mw_pos > 0, Models.Common.getw(bus_ver_sources_lseen, bs_ver_src_mw_pos), '0'));

bs_ver_src_ldate_mw :=     __common__( common.sas_date((string)(_bs_ver_src_ldate_mw)));

bs_ver_src_np_pos :=     __common__( Models.Common.findw_cpp(bus_ver_sources, 'NP' , '  ,', 'ie'));

_bs_ver_src_fdate_np :=     __common__( if(bs_ver_src_np_pos > 0, Models.Common.getw(bus_ver_sources_fseen, bs_ver_src_np_pos), '0'));

bs_ver_src_fdate_np :=     __common__( common.sas_date((string)(_bs_ver_src_fdate_np)));

_bs_ver_src_ldate_np :=     __common__( if(bs_ver_src_np_pos > 0, Models.Common.getw(bus_ver_sources_lseen, bs_ver_src_np_pos), '0'));

bs_ver_src_ldate_np :=     __common__( common.sas_date((string)(_bs_ver_src_ldate_np)));

bs_ver_src_nr_pos :=     __common__( Models.Common.findw_cpp(bus_ver_sources, 'NR' , '  ,', 'ie'));

_bs_ver_src_fdate_nr :=     __common__( if(bs_ver_src_nr_pos > 0, Models.Common.getw(bus_ver_sources_fseen, bs_ver_src_nr_pos), '0'));

bs_ver_src_fdate_nr :=     __common__( common.sas_date((string)(_bs_ver_src_fdate_nr)));

_bs_ver_src_ldate_nr :=     __common__( if(bs_ver_src_nr_pos > 0, Models.Common.getw(bus_ver_sources_lseen, bs_ver_src_nr_pos), '0'));

bs_ver_src_ldate_nr :=     __common__( common.sas_date((string)(_bs_ver_src_ldate_nr)));

bs_ver_src_os_pos :=     __common__( Models.Common.findw_cpp(bus_ver_sources, 'OS' , '  ,', 'ie'));

_bs_ver_src_fdate_os :=     __common__( if(bs_ver_src_os_pos > 0, Models.Common.getw(bus_ver_sources_fseen, bs_ver_src_os_pos), '0'));

bs_ver_src_fdate_os :=     __common__( common.sas_date((string)(_bs_ver_src_fdate_os)));

_bs_ver_src_ldate_os :=     __common__( if(bs_ver_src_os_pos > 0, Models.Common.getw(bus_ver_sources_lseen, bs_ver_src_os_pos), '0'));

bs_ver_src_ldate_os :=     __common__( common.sas_date((string)(_bs_ver_src_ldate_os)));

bs_ver_src_p_pos :=     __common__( Models.Common.findw_cpp(bus_ver_sources, 'P' , '  ,', 'ie'));

_bs_ver_src_fdate_p :=     __common__( if(bs_ver_src_p_pos > 0, Models.Common.getw(bus_ver_sources_fseen, bs_ver_src_p_pos), '0'));

bs_ver_src_fdate_p :=     __common__( common.sas_date((string)(_bs_ver_src_fdate_p)));

_bs_ver_src_ldate_p :=     __common__( if(bs_ver_src_p_pos > 0, Models.Common.getw(bus_ver_sources_lseen, bs_ver_src_p_pos), '0'));

bs_ver_src_ldate_p :=     __common__( common.sas_date((string)(_bs_ver_src_ldate_p)));

bs_ver_src_pl_pos :=     __common__( Models.Common.findw_cpp(bus_ver_sources, 'PL' , '  ,', 'ie'));

_bs_ver_src_fdate_pl :=     __common__( if(bs_ver_src_pl_pos > 0, Models.Common.getw(bus_ver_sources_fseen, bs_ver_src_pl_pos), '0'));

bs_ver_src_fdate_pl :=     __common__( common.sas_date((string)(_bs_ver_src_fdate_pl)));

_bs_ver_src_ldate_pl :=     __common__( if(bs_ver_src_pl_pos > 0, Models.Common.getw(bus_ver_sources_lseen, bs_ver_src_pl_pos), '0'));

bs_ver_src_ldate_pl :=     __common__( common.sas_date((string)(_bs_ver_src_ldate_pl)));

bs_ver_src_pp_pos :=     __common__( Models.Common.findw_cpp(bus_ver_sources, 'PP' , '  ,', 'ie'));

_bs_ver_src_fdate_pp :=     __common__( if(bs_ver_src_pp_pos > 0, Models.Common.getw(bus_ver_sources_fseen, bs_ver_src_pp_pos), '0'));

bs_ver_src_fdate_pp :=     __common__( common.sas_date((string)(_bs_ver_src_fdate_pp)));

_bs_ver_src_ldate_pp :=     __common__( if(bs_ver_src_pp_pos > 0, Models.Common.getw(bus_ver_sources_lseen, bs_ver_src_pp_pos), '0'));

bs_ver_src_ldate_pp :=     __common__( common.sas_date((string)(_bs_ver_src_ldate_pp)));

bs_ver_src_q3_pos :=     __common__( Models.Common.findw_cpp(bus_ver_sources, 'Q3' , '  ,', 'ie'));

_bs_ver_src_fdate_q3 :=     __common__( if(bs_ver_src_q3_pos > 0, Models.Common.getw(bus_ver_sources_fseen, bs_ver_src_q3_pos), '0'));

bs_ver_src_fdate_q3 :=     __common__( common.sas_date((string)(_bs_ver_src_fdate_q3)));

_bs_ver_src_ldate_q3 :=     __common__( if(bs_ver_src_q3_pos > 0, Models.Common.getw(bus_ver_sources_lseen, bs_ver_src_q3_pos), '0'));

bs_ver_src_ldate_q3 :=     __common__( common.sas_date((string)(_bs_ver_src_ldate_q3)));

bs_ver_src_rr_pos :=     __common__( Models.Common.findw_cpp(bus_ver_sources, 'RR' , '  ,', 'ie'));

_bs_ver_src_fdate_rr :=     __common__( if(bs_ver_src_rr_pos > 0, Models.Common.getw(bus_ver_sources_fseen, bs_ver_src_rr_pos), '0'));

bs_ver_src_fdate_rr :=     __common__( common.sas_date((string)(_bs_ver_src_fdate_rr)));

_bs_ver_src_ldate_rr :=     __common__( if(bs_ver_src_rr_pos > 0, Models.Common.getw(bus_ver_sources_lseen, bs_ver_src_rr_pos), '0'));

bs_ver_src_ldate_rr :=     __common__( common.sas_date((string)(_bs_ver_src_ldate_rr)));

bs_ver_src_sa_pos :=     __common__( Models.Common.findw_cpp(bus_ver_sources, 'SA' , '  ,', 'ie'));

_bs_ver_src_fdate_sa :=     __common__( if(bs_ver_src_sa_pos > 0, Models.Common.getw(bus_ver_sources_fseen, bs_ver_src_sa_pos), '0'));

bs_ver_src_fdate_sa :=     __common__( common.sas_date((string)(_bs_ver_src_fdate_sa)));

_bs_ver_src_ldate_sa :=     __common__( if(bs_ver_src_sa_pos > 0, Models.Common.getw(bus_ver_sources_lseen, bs_ver_src_sa_pos), '0'));

bs_ver_src_ldate_sa :=     __common__( common.sas_date((string)(_bs_ver_src_ldate_sa)));

bs_ver_src_sb_pos :=     __common__( Models.Common.findw_cpp(bus_ver_sources, 'SB' , '  ,', 'ie'));

_bs_ver_src_fdate_sb :=     __common__( if(bs_ver_src_sb_pos > 0, Models.Common.getw(bus_ver_sources_fseen, bs_ver_src_sb_pos), '0'));

bs_ver_src_fdate_sb :=     __common__( common.sas_date((string)(_bs_ver_src_fdate_sb)));

_bs_ver_src_ldate_sb :=     __common__( if(bs_ver_src_sb_pos > 0, Models.Common.getw(bus_ver_sources_lseen, bs_ver_src_sb_pos), '0'));

bs_ver_src_ldate_sb :=     __common__( common.sas_date((string)(_bs_ver_src_ldate_sb)));

bs_ver_src_sg_pos :=     __common__( Models.Common.findw_cpp(bus_ver_sources, 'SG' , '  ,', 'ie'));

_bs_ver_src_fdate_sg :=     __common__( if(bs_ver_src_sg_pos > 0, Models.Common.getw(bus_ver_sources_fseen, bs_ver_src_sg_pos), '0'));

bs_ver_src_fdate_sg :=     __common__( common.sas_date((string)(_bs_ver_src_fdate_sg)));

_bs_ver_src_ldate_sg :=     __common__( if(bs_ver_src_sg_pos > 0, Models.Common.getw(bus_ver_sources_lseen, bs_ver_src_sg_pos), '0'));

bs_ver_src_ldate_sg :=     __common__( common.sas_date((string)(_bs_ver_src_ldate_sg)));

bs_ver_src_sj_pos :=     __common__( Models.Common.findw_cpp(bus_ver_sources, 'SJ' , '  ,', 'ie'));

_bs_ver_src_fdate_sj :=     __common__( if(bs_ver_src_sj_pos > 0, Models.Common.getw(bus_ver_sources_fseen, bs_ver_src_sj_pos), '0'));

bs_ver_src_fdate_sj :=     __common__( common.sas_date((string)(_bs_ver_src_fdate_sj)));

_bs_ver_src_ldate_sj :=     __common__( if(bs_ver_src_sj_pos > 0, Models.Common.getw(bus_ver_sources_lseen, bs_ver_src_sj_pos), '0'));

bs_ver_src_ldate_sj :=     __common__( common.sas_date((string)(_bs_ver_src_ldate_sj)));

bs_ver_src_sk_pos :=     __common__( Models.Common.findw_cpp(bus_ver_sources, 'SK' , '  ,', 'ie'));

_bs_ver_src_fdate_sk :=     __common__( if(bs_ver_src_sk_pos > 0, Models.Common.getw(bus_ver_sources_fseen, bs_ver_src_sk_pos), '0'));

bs_ver_src_fdate_sk :=     __common__( common.sas_date((string)(_bs_ver_src_fdate_sk)));

_bs_ver_src_ldate_sk :=     __common__( if(bs_ver_src_sk_pos > 0, Models.Common.getw(bus_ver_sources_lseen, bs_ver_src_sk_pos), '0'));

bs_ver_src_ldate_sk :=     __common__( common.sas_date((string)(_bs_ver_src_ldate_sk)));

bs_ver_src_sp_pos :=     __common__( Models.Common.findw_cpp(bus_ver_sources, 'SP' , '  ,', 'ie'));

_bs_ver_src_fdate_sp :=     __common__( if(bs_ver_src_sp_pos > 0, Models.Common.getw(bus_ver_sources_fseen, bs_ver_src_sp_pos), '0'));

bs_ver_src_fdate_sp :=     __common__( common.sas_date((string)(_bs_ver_src_fdate_sp)));

_bs_ver_src_ldate_sp :=     __common__( if(bs_ver_src_sp_pos > 0, Models.Common.getw(bus_ver_sources_lseen, bs_ver_src_sp_pos), '0'));

bs_ver_src_ldate_sp :=     __common__( common.sas_date((string)(_bs_ver_src_ldate_sp)));

bs_ver_src_tx_pos :=     __common__( Models.Common.findw_cpp(bus_ver_sources, 'TX' , '  ,', 'ie'));

_bs_ver_src_fdate_tx :=     __common__( if(bs_ver_src_tx_pos > 0, Models.Common.getw(bus_ver_sources_fseen, bs_ver_src_tx_pos), '0'));

bs_ver_src_fdate_tx :=     __common__( common.sas_date((string)(_bs_ver_src_fdate_tx)));

_bs_ver_src_ldate_tx :=     __common__( if(bs_ver_src_tx_pos > 0, Models.Common.getw(bus_ver_sources_lseen, bs_ver_src_tx_pos), '0'));

bs_ver_src_ldate_tx :=     __common__( common.sas_date((string)(_bs_ver_src_ldate_tx)));

bs_ver_src_u2_pos :=     __common__( Models.Common.findw_cpp(bus_ver_sources, 'U2' , '  ,', 'ie'));

_bs_ver_src_fdate_u2 :=     __common__( if(bs_ver_src_u2_pos > 0, Models.Common.getw(bus_ver_sources_fseen, bs_ver_src_u2_pos), '0'));

bs_ver_src_fdate_u2 :=     __common__( common.sas_date((string)(_bs_ver_src_fdate_u2)));

_bs_ver_src_ldate_u2 :=     __common__( if(bs_ver_src_u2_pos > 0, Models.Common.getw(bus_ver_sources_lseen, bs_ver_src_u2_pos), '0'));

bs_ver_src_ldate_u2 :=     __common__( common.sas_date((string)(_bs_ver_src_ldate_u2)));

bs_ver_src_ut_pos :=     __common__( Models.Common.findw_cpp(bus_ver_sources, 'UT' , '  ,', 'ie'));

_bs_ver_src_fdate_ut :=     __common__( if(bs_ver_src_ut_pos > 0, Models.Common.getw(bus_ver_sources_fseen, bs_ver_src_ut_pos), '0'));

bs_ver_src_fdate_ut :=     __common__( common.sas_date((string)(_bs_ver_src_fdate_ut)));

_bs_ver_src_ldate_ut :=     __common__( if(bs_ver_src_ut_pos > 0, Models.Common.getw(bus_ver_sources_lseen, bs_ver_src_ut_pos), '0'));

bs_ver_src_ldate_ut :=     __common__( common.sas_date((string)(_bs_ver_src_ldate_ut)));

bs_ver_src_v_pos :=     __common__( Models.Common.findw_cpp(bus_ver_sources, 'V' , '  ,', 'ie'));

_bs_ver_src_fdate_v :=     __common__( if(bs_ver_src_v_pos > 0, Models.Common.getw(bus_ver_sources_fseen, bs_ver_src_v_pos), '0'));

bs_ver_src_fdate_v :=     __common__( common.sas_date((string)(_bs_ver_src_fdate_v)));

_bs_ver_src_ldate_v :=     __common__( if(bs_ver_src_v_pos > 0, Models.Common.getw(bus_ver_sources_lseen, bs_ver_src_v_pos), '0'));

bs_ver_src_ldate_v :=     __common__( common.sas_date((string)(_bs_ver_src_ldate_v)));

bs_ver_src_v2_pos :=     __common__( Models.Common.findw_cpp(bus_ver_sources, 'V2' , '  ,', 'ie'));

_bs_ver_src_fdate_v2 :=     __common__( if(bs_ver_src_v2_pos > 0, Models.Common.getw(bus_ver_sources_fseen, bs_ver_src_v2_pos), '0'));

bs_ver_src_fdate_v2 :=     __common__( common.sas_date((string)(_bs_ver_src_fdate_v2)));

_bs_ver_src_ldate_v2 :=     __common__( if(bs_ver_src_v2_pos > 0, Models.Common.getw(bus_ver_sources_lseen, bs_ver_src_v2_pos), '0'));

bs_ver_src_ldate_v2 :=     __common__( common.sas_date((string)(_bs_ver_src_ldate_v2)));

bs_ver_src_wa_pos :=     __common__( Models.Common.findw_cpp(bus_ver_sources, 'WA' , '  ,', 'ie'));

_bs_ver_src_fdate_wa :=     __common__( if(bs_ver_src_wa_pos > 0, Models.Common.getw(bus_ver_sources_fseen, bs_ver_src_wa_pos), '0'));

bs_ver_src_fdate_wa :=     __common__( common.sas_date((string)(_bs_ver_src_fdate_wa)));

_bs_ver_src_ldate_wa :=     __common__( if(bs_ver_src_wa_pos > 0, Models.Common.getw(bus_ver_sources_lseen, bs_ver_src_wa_pos), '0'));

bs_ver_src_ldate_wa :=     __common__( common.sas_date((string)(_bs_ver_src_ldate_wa)));

bs_ver_src_wb_pos :=     __common__( Models.Common.findw_cpp(bus_ver_sources, 'WB' , '  ,', 'ie'));

_bs_ver_src_fdate_wb :=     __common__( if(bs_ver_src_wb_pos > 0, Models.Common.getw(bus_ver_sources_fseen, bs_ver_src_wb_pos), '0'));

bs_ver_src_fdate_wb :=     __common__( common.sas_date((string)(_bs_ver_src_fdate_wb)));

_bs_ver_src_ldate_wb :=     __common__( if(bs_ver_src_wb_pos > 0, Models.Common.getw(bus_ver_sources_lseen, bs_ver_src_wb_pos), '0'));

bs_ver_src_ldate_wb :=     __common__( common.sas_date((string)(_bs_ver_src_ldate_wb)));

bs_ver_src_wc_pos :=     __common__( Models.Common.findw_cpp(bus_ver_sources, 'WC' , '  ,', 'ie'));

_bs_ver_src_fdate_wc :=     __common__( if(bs_ver_src_wc_pos > 0, Models.Common.getw(bus_ver_sources_fseen, bs_ver_src_wc_pos), '0'));

bs_ver_src_fdate_wc :=     __common__( common.sas_date((string)(_bs_ver_src_fdate_wc)));

_bs_ver_src_ldate_wc :=     __common__( if(bs_ver_src_wc_pos > 0, Models.Common.getw(bus_ver_sources_lseen, bs_ver_src_wc_pos), '0'));

bs_ver_src_ldate_wc :=     __common__( common.sas_date((string)(_bs_ver_src_ldate_wc)));

bs_ver_src_wk_pos :=     __common__( Models.Common.findw_cpp(bus_ver_sources, 'WK' , '  ,', 'ie'));

_bs_ver_src_fdate_wk :=     __common__( if(bs_ver_src_wk_pos > 0, Models.Common.getw(bus_ver_sources_fseen, bs_ver_src_wk_pos), '0'));

bs_ver_src_fdate_wk :=     __common__( common.sas_date((string)(_bs_ver_src_fdate_wk)));

_bs_ver_src_ldate_wk :=     __common__( if(bs_ver_src_wk_pos > 0, Models.Common.getw(bus_ver_sources_lseen, bs_ver_src_wk_pos), '0'));

bs_ver_src_ldate_wk :=     __common__( common.sas_date((string)(_bs_ver_src_ldate_wk)));

bs_ver_src_wx_pos :=     __common__( Models.Common.findw_cpp(bus_ver_sources, 'WX' , '  ,', 'ie'));

_bs_ver_src_fdate_wx :=     __common__( if(bs_ver_src_wx_pos > 0, Models.Common.getw(bus_ver_sources_fseen, bs_ver_src_wx_pos), '0'));

bs_ver_src_fdate_wx :=     __common__( common.sas_date((string)(_bs_ver_src_fdate_wx)));

_bs_ver_src_ldate_wx :=     __common__( if(bs_ver_src_wx_pos > 0, Models.Common.getw(bus_ver_sources_lseen, bs_ver_src_wx_pos), '0'));

bs_ver_src_ldate_wx :=     __common__( common.sas_date((string)(_bs_ver_src_ldate_wx)));

bs_ver_src_y_pos :=     __common__( Models.Common.findw_cpp(bus_ver_sources, 'Y' , '  ,', 'ie'));

_bs_ver_src_fdate_y :=     __common__( if(bs_ver_src_y_pos > 0, Models.Common.getw(bus_ver_sources_fseen, bs_ver_src_y_pos), '0'));

bs_ver_src_fdate_y :=     __common__( common.sas_date((string)(_bs_ver_src_fdate_y)));

_bs_ver_src_ldate_y :=     __common__( if(bs_ver_src_y_pos > 0, Models.Common.getw(bus_ver_sources_lseen, bs_ver_src_y_pos), '0'));

bs_ver_src_ldate_y :=     __common__( common.sas_date((string)(_bs_ver_src_ldate_y)));

bs_ver_src_zo_pos :=     __common__( Models.Common.findw_cpp(bus_ver_sources, 'ZO' , '  ,', 'ie'));

_bs_ver_src_fdate_zo :=     __common__( if(bs_ver_src_zo_pos > 0, Models.Common.getw(bus_ver_sources_fseen, bs_ver_src_zo_pos), '0'));

bs_ver_src_fdate_zo :=     __common__( common.sas_date((string)(_bs_ver_src_fdate_zo)));

_bs_ver_src_ldate_zo :=     __common__( if(bs_ver_src_zo_pos > 0, Models.Common.getw(bus_ver_sources_lseen, bs_ver_src_zo_pos), '0'));

bs_ver_src_ldate_zo :=     __common__( common.sas_date((string)(_bs_ver_src_ldate_zo)));

bs_ssn_ver_src_ar_pos :=     __common__( Models.Common.findw_cpp(bus_ssn_ver_sources, 'AR' , '  ,', 'ie'));

_bs_ssn_ver_src_ldate_ar :=     __common__( if(bs_ssn_ver_src_ar_pos > 0, Models.Common.getw(bus_ssn_ver_sources_lseen, bs_ssn_ver_src_ar_pos), '0'));

bs_ssn_ver_src_ldate_ar :=     __common__( common.sas_date((string)(_bs_ssn_ver_src_ldate_ar)));

bs_ssn_ver_src_ba_pos :=     __common__( Models.Common.findw_cpp(bus_ssn_ver_sources, 'BA' , '  ,', 'ie'));

_bs_ssn_ver_src_ldate_ba :=     __common__( if(bs_ssn_ver_src_ba_pos > 0, Models.Common.getw(bus_ssn_ver_sources_lseen, bs_ssn_ver_src_ba_pos), '0'));

bs_ssn_ver_src_ldate_ba :=     __common__( common.sas_date((string)(_bs_ssn_ver_src_ldate_ba)));

bs_ssn_ver_src_bc_pos :=     __common__( Models.Common.findw_cpp(bus_ssn_ver_sources, 'BC' , '  ,', 'ie'));

_bs_ssn_ver_src_ldate_bc :=     __common__( if(bs_ssn_ver_src_bc_pos > 0, Models.Common.getw(bus_ssn_ver_sources_lseen, bs_ssn_ver_src_bc_pos), '0'));

bs_ssn_ver_src_ldate_bc :=     __common__( common.sas_date((string)(_bs_ssn_ver_src_ldate_bc)));

bs_ssn_ver_src_bm_pos :=     __common__( Models.Common.findw_cpp(bus_ssn_ver_sources, 'BM' , '  ,', 'ie'));

_bs_ssn_ver_src_ldate_bm :=     __common__( if(bs_ssn_ver_src_bm_pos > 0, Models.Common.getw(bus_ssn_ver_sources_lseen, bs_ssn_ver_src_bm_pos), '0'));

bs_ssn_ver_src_ldate_bm :=     __common__( common.sas_date((string)(_bs_ssn_ver_src_ldate_bm)));

bs_ssn_ver_src_bn_pos :=     __common__( Models.Common.findw_cpp(bus_ssn_ver_sources, 'BN' , '  ,', 'ie'));

_bs_ssn_ver_src_ldate_bn :=     __common__( if(bs_ssn_ver_src_bn_pos > 0, Models.Common.getw(bus_ssn_ver_sources_lseen, bs_ssn_ver_src_bn_pos), '0'));

bs_ssn_ver_src_ldate_bn :=     __common__( common.sas_date((string)(_bs_ssn_ver_src_ldate_bn)));

bs_ssn_ver_src_br_pos :=     __common__( Models.Common.findw_cpp(bus_ssn_ver_sources, 'BR' , '  ,', 'ie'));

_bs_ssn_ver_src_ldate_br :=     __common__( if(bs_ssn_ver_src_br_pos > 0, Models.Common.getw(bus_ssn_ver_sources_lseen, bs_ssn_ver_src_br_pos), '0'));

bs_ssn_ver_src_ldate_br :=     __common__( common.sas_date((string)(_bs_ssn_ver_src_ldate_br)));

bs_ssn_ver_src_by_pos :=     __common__( Models.Common.findw_cpp(bus_ssn_ver_sources, 'BY' , '  ,', 'ie'));

_bs_ssn_ver_src_ldate_by :=     __common__( if(bs_ssn_ver_src_by_pos > 0, Models.Common.getw(bus_ssn_ver_sources_lseen, bs_ssn_ver_src_by_pos), '0'));

bs_ssn_ver_src_ldate_by :=     __common__( common.sas_date((string)(_bs_ssn_ver_src_ldate_by)));

bs_ssn_ver_src_c_pos :=     __common__( Models.Common.findw_cpp(bus_ssn_ver_sources, 'C' , '  ,', 'ie'));

_bs_ssn_ver_src_ldate_c :=     __common__( if(bs_ssn_ver_src_c_pos > 0, Models.Common.getw(bus_ssn_ver_sources_lseen, bs_ssn_ver_src_c_pos), '0'));

bs_ssn_ver_src_ldate_c :=     __common__( common.sas_date((string)(_bs_ssn_ver_src_ldate_c)));

bs_ssn_ver_src_cs_pos :=     __common__( Models.Common.findw_cpp(bus_ssn_ver_sources, 'C#' , '  ,', 'ie'));

_bs_ssn_ver_src_ldate_cs :=     __common__( if(bs_ssn_ver_src_cs_pos > 0, Models.Common.getw(bus_ssn_ver_sources_lseen, bs_ssn_ver_src_cs_pos), '0'));

bs_ssn_ver_src_ldate_cs :=     __common__( common.sas_date((string)(_bs_ssn_ver_src_ldate_cs)));

bs_ssn_ver_src_cf_pos :=     __common__( Models.Common.findw_cpp(bus_ssn_ver_sources, 'CF' , '  ,', 'ie'));

_bs_ssn_ver_src_ldate_cf :=     __common__( if(bs_ssn_ver_src_cf_pos > 0, Models.Common.getw(bus_ssn_ver_sources_lseen, bs_ssn_ver_src_cf_pos), '0'));

bs_ssn_ver_src_ldate_cf :=     __common__( common.sas_date((string)(_bs_ssn_ver_src_ldate_cf)));

bs_ssn_ver_src_cu_pos :=     __common__( Models.Common.findw_cpp(bus_ssn_ver_sources, 'CU' , '  ,', 'ie'));

_bs_ssn_ver_src_ldate_cu :=     __common__( if(bs_ssn_ver_src_cu_pos > 0, Models.Common.getw(bus_ssn_ver_sources_lseen, bs_ssn_ver_src_cu_pos), '0'));

bs_ssn_ver_src_ldate_cu :=     __common__( common.sas_date((string)(_bs_ssn_ver_src_ldate_cu)));

bs_ssn_ver_src_d_pos :=     __common__( Models.Common.findw_cpp(bus_ssn_ver_sources, 'D' , '  ,', 'ie'));

_bs_ssn_ver_src_ldate_d :=     __common__( if(bs_ssn_ver_src_d_pos > 0, Models.Common.getw(bus_ssn_ver_sources_lseen, bs_ssn_ver_src_d_pos), '0'));

bs_ssn_ver_src_ldate_d :=     __common__( common.sas_date((string)(_bs_ssn_ver_src_ldate_d)));

bs_ssn_ver_src_da_pos :=     __common__( Models.Common.findw_cpp(bus_ssn_ver_sources, 'DA' , '  ,', 'ie'));

_bs_ssn_ver_src_ldate_da :=     __common__( if(bs_ssn_ver_src_da_pos > 0, Models.Common.getw(bus_ssn_ver_sources_lseen, bs_ssn_ver_src_da_pos), '0'));

bs_ssn_ver_src_ldate_da :=     __common__( common.sas_date((string)(_bs_ssn_ver_src_ldate_da)));

bs_ssn_ver_src_df_pos :=     __common__( Models.Common.findw_cpp(bus_ssn_ver_sources, 'DF' , '  ,', 'ie'));

_bs_ssn_ver_src_ldate_df :=     __common__( if(bs_ssn_ver_src_df_pos > 0, Models.Common.getw(bus_ssn_ver_sources_lseen, bs_ssn_ver_src_df_pos), '0'));

bs_ssn_ver_src_ldate_df :=     __common__( common.sas_date((string)(_bs_ssn_ver_src_ldate_df)));

bs_ssn_ver_src_dn_pos :=     __common__( Models.Common.findw_cpp(bus_ssn_ver_sources, 'DN' , '  ,', 'ie'));

_bs_ssn_ver_src_ldate_dn :=     __common__( if(bs_ssn_ver_src_dn_pos > 0, Models.Common.getw(bus_ssn_ver_sources_lseen, bs_ssn_ver_src_dn_pos), '0'));

bs_ssn_ver_src_ldate_dn :=     __common__( common.sas_date((string)(_bs_ssn_ver_src_ldate_dn)));

bs_ssn_ver_src_e_pos :=     __common__( Models.Common.findw_cpp(bus_ssn_ver_sources, 'E' , '  ,', 'ie'));

_bs_ssn_ver_src_ldate_e :=     __common__( if(bs_ssn_ver_src_e_pos > 0, Models.Common.getw(bus_ssn_ver_sources_lseen, bs_ssn_ver_src_e_pos), '0'));

bs_ssn_ver_src_ldate_e :=     __common__( common.sas_date((string)(_bs_ssn_ver_src_ldate_e)));

bs_ssn_ver_src_ef_pos :=     __common__( Models.Common.findw_cpp(bus_ssn_ver_sources, 'EF' , '  ,', 'ie'));

_bs_ssn_ver_src_ldate_ef :=     __common__( if(bs_ssn_ver_src_ef_pos > 0, Models.Common.getw(bus_ssn_ver_sources_lseen, bs_ssn_ver_src_ef_pos), '0'));

bs_ssn_ver_src_ldate_ef :=     __common__( common.sas_date((string)(_bs_ssn_ver_src_ldate_ef)));

bs_ssn_ver_src_er_pos :=     __common__( Models.Common.findw_cpp(bus_ssn_ver_sources, 'ER' , '  ,', 'ie'));

_bs_ssn_ver_src_ldate_er :=     __common__( if(bs_ssn_ver_src_er_pos > 0, Models.Common.getw(bus_ssn_ver_sources_lseen, bs_ssn_ver_src_er_pos), '0'));

bs_ssn_ver_src_ldate_er :=     __common__( common.sas_date((string)(_bs_ssn_ver_src_ldate_er)));

bs_ssn_ver_src_ey_pos :=     __common__( Models.Common.findw_cpp(bus_ssn_ver_sources, 'EY' , '  ,', 'ie'));

_bs_ssn_ver_src_ldate_ey :=     __common__( if(bs_ssn_ver_src_ey_pos > 0, Models.Common.getw(bus_ssn_ver_sources_lseen, bs_ssn_ver_src_ey_pos), '0'));

bs_ssn_ver_src_ldate_ey :=     __common__( common.sas_date((string)(_bs_ssn_ver_src_ldate_ey)));

bs_ssn_ver_src_f_pos :=     __common__( Models.Common.findw_cpp(bus_ssn_ver_sources, 'F' , '  ,', 'ie'));

_bs_ssn_ver_src_ldate_f :=     __common__( if(bs_ssn_ver_src_f_pos > 0, Models.Common.getw(bus_ssn_ver_sources_lseen, bs_ssn_ver_src_f_pos), '0'));

bs_ssn_ver_src_ldate_f :=     __common__( common.sas_date((string)(_bs_ssn_ver_src_ldate_f)));

bs_ssn_ver_src_fb_pos :=     __common__( Models.Common.findw_cpp(bus_ssn_ver_sources, 'FB' , '  ,', 'ie'));

_bs_ssn_ver_src_ldate_fb :=     __common__( if(bs_ssn_ver_src_fb_pos > 0, Models.Common.getw(bus_ssn_ver_sources_lseen, bs_ssn_ver_src_fb_pos), '0'));

bs_ssn_ver_src_ldate_fb :=     __common__( common.sas_date((string)(_bs_ssn_ver_src_ldate_fb)));

bs_ssn_ver_src_fi_pos :=     __common__( Models.Common.findw_cpp(bus_ssn_ver_sources, 'FI' , '  ,', 'ie'));

_bs_ssn_ver_src_ldate_fi :=     __common__( if(bs_ssn_ver_src_fi_pos > 0, Models.Common.getw(bus_ssn_ver_sources_lseen, bs_ssn_ver_src_fi_pos), '0'));

bs_ssn_ver_src_ldate_fi :=     __common__( common.sas_date((string)(_bs_ssn_ver_src_ldate_fi)));

bs_ssn_ver_src_fk_pos :=     __common__( Models.Common.findw_cpp(bus_ssn_ver_sources, 'FK' , '  ,', 'ie'));

_bs_ssn_ver_src_ldate_fk :=     __common__( if(bs_ssn_ver_src_fk_pos > 0, Models.Common.getw(bus_ssn_ver_sources_lseen, bs_ssn_ver_src_fk_pos), '0'));

bs_ssn_ver_src_ldate_fk :=     __common__( common.sas_date((string)(_bs_ssn_ver_src_ldate_fk)));

bs_ssn_ver_src_fr_pos :=     __common__( Models.Common.findw_cpp(bus_ssn_ver_sources, 'FR' , '  ,', 'ie'));

_bs_ssn_ver_src_ldate_fr :=     __common__( if(bs_ssn_ver_src_fr_pos > 0, Models.Common.getw(bus_ssn_ver_sources_lseen, bs_ssn_ver_src_fr_pos), '0'));

bs_ssn_ver_src_ldate_fr :=     __common__( common.sas_date((string)(_bs_ssn_ver_src_ldate_fr)));

bs_ssn_ver_src_ft_pos :=     __common__( Models.Common.findw_cpp(bus_ssn_ver_sources, 'FT' , '  ,', 'ie'));

_bs_ssn_ver_src_ldate_ft :=     __common__( if(bs_ssn_ver_src_ft_pos > 0, Models.Common.getw(bus_ssn_ver_sources_lseen, bs_ssn_ver_src_ft_pos), '0'));

bs_ssn_ver_src_ldate_ft :=     __common__( common.sas_date((string)(_bs_ssn_ver_src_ldate_ft)));

bs_ssn_ver_src_gb_pos :=     __common__( Models.Common.findw_cpp(bus_ssn_ver_sources, 'GB' , '  ,', 'ie'));

_bs_ssn_ver_src_ldate_gb :=     __common__( if(bs_ssn_ver_src_gb_pos > 0, Models.Common.getw(bus_ssn_ver_sources_lseen, bs_ssn_ver_src_gb_pos), '0'));

bs_ssn_ver_src_ldate_gb :=     __common__( common.sas_date((string)(_bs_ssn_ver_src_ldate_gb)));

bs_ssn_ver_src_gr_pos :=     __common__( Models.Common.findw_cpp(bus_ssn_ver_sources, 'GR' , '  ,', 'ie'));

_bs_ssn_ver_src_ldate_gr :=     __common__( if(bs_ssn_ver_src_gr_pos > 0, Models.Common.getw(bus_ssn_ver_sources_lseen, bs_ssn_ver_src_gr_pos), '0'));

bs_ssn_ver_src_ldate_gr :=     __common__( common.sas_date((string)(_bs_ssn_ver_src_ldate_gr)));

bs_ssn_ver_src_h7_pos :=     __common__( Models.Common.findw_cpp(bus_ssn_ver_sources, 'H7' , '  ,', 'ie'));

_bs_ssn_ver_src_ldate_h7 :=     __common__( if(bs_ssn_ver_src_h7_pos > 0, Models.Common.getw(bus_ssn_ver_sources_lseen, bs_ssn_ver_src_h7_pos), '0'));

bs_ssn_ver_src_ldate_h7 :=     __common__( common.sas_date((string)(_bs_ssn_ver_src_ldate_h7)));

bs_ssn_ver_src_i_pos :=     __common__( Models.Common.findw_cpp(bus_ssn_ver_sources, 'I' , '  ,', 'ie'));

_bs_ssn_ver_src_ldate_i :=     __common__( if(bs_ssn_ver_src_i_pos > 0, Models.Common.getw(bus_ssn_ver_sources_lseen, bs_ssn_ver_src_i_pos), '0'));

bs_ssn_ver_src_ldate_i :=     __common__( common.sas_date((string)(_bs_ssn_ver_src_ldate_i)));

bs_ssn_ver_src_ia_pos :=     __common__( Models.Common.findw_cpp(bus_ssn_ver_sources, 'IA' , '  ,', 'ie'));

_bs_ssn_ver_src_ldate_ia :=     __common__( if(bs_ssn_ver_src_ia_pos > 0, Models.Common.getw(bus_ssn_ver_sources_lseen, bs_ssn_ver_src_ia_pos), '0'));

bs_ssn_ver_src_ldate_ia :=     __common__( common.sas_date((string)(_bs_ssn_ver_src_ldate_ia)));

bs_ssn_ver_src_ic_pos :=     __common__( Models.Common.findw_cpp(bus_ssn_ver_sources, 'IC' , '  ,', 'ie'));

_bs_ssn_ver_src_ldate_ic :=     __common__( if(bs_ssn_ver_src_ic_pos > 0, Models.Common.getw(bus_ssn_ver_sources_lseen, bs_ssn_ver_src_ic_pos), '0'));

bs_ssn_ver_src_ldate_ic :=     __common__( common.sas_date((string)(_bs_ssn_ver_src_ldate_ic)));

bs_ssn_ver_src_in_pos :=     __common__( Models.Common.findw_cpp(bus_ssn_ver_sources, 'IN' , '  ,', 'ie'));

_bs_ssn_ver_src_ldate_in :=     __common__( if(bs_ssn_ver_src_in_pos > 0, Models.Common.getw(bus_ssn_ver_sources_lseen, bs_ssn_ver_src_in_pos), '0'));

bs_ssn_ver_src_ldate_in :=     __common__( common.sas_date((string)(_bs_ssn_ver_src_ldate_in)));

bs_ssn_ver_src_ip_pos :=     __common__( Models.Common.findw_cpp(bus_ssn_ver_sources, 'IP' , '  ,', 'ie'));

_bs_ssn_ver_src_ldate_ip :=     __common__( if(bs_ssn_ver_src_ip_pos > 0, Models.Common.getw(bus_ssn_ver_sources_lseen, bs_ssn_ver_src_ip_pos), '0'));

bs_ssn_ver_src_ldate_ip :=     __common__( common.sas_date((string)(_bs_ssn_ver_src_ldate_ip)));

bs_ssn_ver_src_is_pos :=     __common__( Models.Common.findw_cpp(bus_ssn_ver_sources, 'IS' , '  ,', 'ie'));

_bs_ssn_ver_src_ldate_is :=     __common__( if(bs_ssn_ver_src_is_pos > 0, Models.Common.getw(bus_ssn_ver_sources_lseen, bs_ssn_ver_src_is_pos), '0'));

bs_ssn_ver_src_ldate_is :=     __common__( common.sas_date((string)(_bs_ssn_ver_src_ldate_is)));

bs_ssn_ver_src_it_pos :=     __common__( Models.Common.findw_cpp(bus_ssn_ver_sources, 'IT' , '  ,', 'ie'));

_bs_ssn_ver_src_ldate_it :=     __common__( if(bs_ssn_ver_src_it_pos > 0, Models.Common.getw(bus_ssn_ver_sources_lseen, bs_ssn_ver_src_it_pos), '0'));

bs_ssn_ver_src_ldate_it :=     __common__( common.sas_date((string)(_bs_ssn_ver_src_ldate_it)));

bs_ssn_ver_src_j2_pos :=     __common__( Models.Common.findw_cpp(bus_ssn_ver_sources, 'J2' , '  ,', 'ie'));

_bs_ssn_ver_src_ldate_j2 :=     __common__( if(bs_ssn_ver_src_j2_pos > 0, Models.Common.getw(bus_ssn_ver_sources_lseen, bs_ssn_ver_src_j2_pos), '0'));

bs_ssn_ver_src_ldate_j2 :=     __common__( common.sas_date((string)(_bs_ssn_ver_src_ldate_j2)));

bs_ssn_ver_src_kc_pos :=     __common__( Models.Common.findw_cpp(bus_ssn_ver_sources, 'KC' , '  ,', 'ie'));

_bs_ssn_ver_src_ldate_kc :=     __common__( if(bs_ssn_ver_src_kc_pos > 0, Models.Common.getw(bus_ssn_ver_sources_lseen, bs_ssn_ver_src_kc_pos), '0'));

bs_ssn_ver_src_ldate_kc :=     __common__( common.sas_date((string)(_bs_ssn_ver_src_ldate_kc)));

bs_ssn_ver_src_l0_pos :=     __common__( Models.Common.findw_cpp(bus_ssn_ver_sources, 'L0' , '  ,', 'ie'));

_bs_ssn_ver_src_ldate_l0 :=     __common__( if(bs_ssn_ver_src_l0_pos > 0, Models.Common.getw(bus_ssn_ver_sources_lseen, bs_ssn_ver_src_l0_pos), '0'));

bs_ssn_ver_src_ldate_l0 :=     __common__( common.sas_date((string)(_bs_ssn_ver_src_ldate_l0)));

bs_ssn_ver_src_l2_pos :=     __common__( Models.Common.findw_cpp(bus_ssn_ver_sources, 'L2' , '  ,', 'ie'));

_bs_ssn_ver_src_ldate_l2 :=     __common__( if(bs_ssn_ver_src_l2_pos > 0, Models.Common.getw(bus_ssn_ver_sources_lseen, bs_ssn_ver_src_l2_pos), '0'));

bs_ssn_ver_src_ldate_l2 :=     __common__( common.sas_date((string)(_bs_ssn_ver_src_ldate_l2)));

bs_ssn_ver_src_mh_pos :=     __common__( Models.Common.findw_cpp(bus_ssn_ver_sources, 'MH' , '  ,', 'ie'));

_bs_ssn_ver_src_ldate_mh :=     __common__( if(bs_ssn_ver_src_mh_pos > 0, Models.Common.getw(bus_ssn_ver_sources_lseen, bs_ssn_ver_src_mh_pos), '0'));

bs_ssn_ver_src_ldate_mh :=     __common__( common.sas_date((string)(_bs_ssn_ver_src_ldate_mh)));

bs_ssn_ver_src_mw_pos :=     __common__( Models.Common.findw_cpp(bus_ssn_ver_sources, 'MW' , '  ,', 'ie'));

_bs_ssn_ver_src_ldate_mw :=     __common__( if(bs_ssn_ver_src_mw_pos > 0, Models.Common.getw(bus_ssn_ver_sources_lseen, bs_ssn_ver_src_mw_pos), '0'));

bs_ssn_ver_src_ldate_mw :=     __common__( common.sas_date((string)(_bs_ssn_ver_src_ldate_mw)));

bs_ssn_ver_src_np_pos :=     __common__( Models.Common.findw_cpp(bus_ssn_ver_sources, 'NP' , '  ,', 'ie'));

_bs_ssn_ver_src_ldate_np :=     __common__( if(bs_ssn_ver_src_np_pos > 0, Models.Common.getw(bus_ssn_ver_sources_lseen, bs_ssn_ver_src_np_pos), '0'));

bs_ssn_ver_src_ldate_np :=     __common__( common.sas_date((string)(_bs_ssn_ver_src_ldate_np)));

bs_ssn_ver_src_nr_pos :=     __common__( Models.Common.findw_cpp(bus_ssn_ver_sources, 'NR' , '  ,', 'ie'));

_bs_ssn_ver_src_ldate_nr :=     __common__( if(bs_ssn_ver_src_nr_pos > 0, Models.Common.getw(bus_ssn_ver_sources_lseen, bs_ssn_ver_src_nr_pos), '0'));

bs_ssn_ver_src_ldate_nr :=     __common__( common.sas_date((string)(_bs_ssn_ver_src_ldate_nr)));

bs_ssn_ver_src_os_pos :=     __common__( Models.Common.findw_cpp(bus_ssn_ver_sources, 'OS' , '  ,', 'ie'));

_bs_ssn_ver_src_ldate_os :=     __common__( if(bs_ssn_ver_src_os_pos > 0, Models.Common.getw(bus_ssn_ver_sources_lseen, bs_ssn_ver_src_os_pos), '0'));

bs_ssn_ver_src_ldate_os :=     __common__( common.sas_date((string)(_bs_ssn_ver_src_ldate_os)));

bs_ssn_ver_src_p_pos :=     __common__( Models.Common.findw_cpp(bus_ssn_ver_sources, 'P' , '  ,', 'ie'));

_bs_ssn_ver_src_ldate_p :=     __common__( if(bs_ssn_ver_src_p_pos > 0, Models.Common.getw(bus_ssn_ver_sources_lseen, bs_ssn_ver_src_p_pos), '0'));

bs_ssn_ver_src_ldate_p :=     __common__( common.sas_date((string)(_bs_ssn_ver_src_ldate_p)));

bs_ssn_ver_src_pl_pos :=     __common__( Models.Common.findw_cpp(bus_ssn_ver_sources, 'PL' , '  ,', 'ie'));

_bs_ssn_ver_src_ldate_pl :=     __common__( if(bs_ssn_ver_src_pl_pos > 0, Models.Common.getw(bus_ssn_ver_sources_lseen, bs_ssn_ver_src_pl_pos), '0'));

bs_ssn_ver_src_ldate_pl :=     __common__( common.sas_date((string)(_bs_ssn_ver_src_ldate_pl)));

bs_ssn_ver_src_pp_pos :=     __common__( Models.Common.findw_cpp(bus_ssn_ver_sources, 'PP' , '  ,', 'ie'));

_bs_ssn_ver_src_ldate_pp :=     __common__( if(bs_ssn_ver_src_pp_pos > 0, Models.Common.getw(bus_ssn_ver_sources_lseen, bs_ssn_ver_src_pp_pos), '0'));

bs_ssn_ver_src_ldate_pp :=     __common__( common.sas_date((string)(_bs_ssn_ver_src_ldate_pp)));

bs_ssn_ver_src_q3_pos :=     __common__( Models.Common.findw_cpp(bus_ssn_ver_sources, 'Q3' , '  ,', 'ie'));

_bs_ssn_ver_src_ldate_q3 :=     __common__( if(bs_ssn_ver_src_q3_pos > 0, Models.Common.getw(bus_ssn_ver_sources_lseen, bs_ssn_ver_src_q3_pos), '0'));

bs_ssn_ver_src_ldate_q3 :=     __common__( common.sas_date((string)(_bs_ssn_ver_src_ldate_q3)));

bs_ssn_ver_src_rr_pos :=     __common__( Models.Common.findw_cpp(bus_ssn_ver_sources, 'RR' , '  ,', 'ie'));

_bs_ssn_ver_src_ldate_rr :=     __common__( if(bs_ssn_ver_src_rr_pos > 0, Models.Common.getw(bus_ssn_ver_sources_lseen, bs_ssn_ver_src_rr_pos), '0'));

bs_ssn_ver_src_ldate_rr :=     __common__( common.sas_date((string)(_bs_ssn_ver_src_ldate_rr)));

bs_ssn_ver_src_sa_pos :=     __common__( Models.Common.findw_cpp(bus_ssn_ver_sources, 'SA' , '  ,', 'ie'));

_bs_ssn_ver_src_ldate_sa :=     __common__( if(bs_ssn_ver_src_sa_pos > 0, Models.Common.getw(bus_ssn_ver_sources_lseen, bs_ssn_ver_src_sa_pos), '0'));

bs_ssn_ver_src_ldate_sa :=     __common__( common.sas_date((string)(_bs_ssn_ver_src_ldate_sa)));

bs_ssn_ver_src_sb_pos :=     __common__( Models.Common.findw_cpp(bus_ssn_ver_sources, 'SB' , '  ,', 'ie'));

_bs_ssn_ver_src_ldate_sb :=     __common__( if(bs_ssn_ver_src_sb_pos > 0, Models.Common.getw(bus_ssn_ver_sources_lseen, bs_ssn_ver_src_sb_pos), '0'));

bs_ssn_ver_src_ldate_sb :=     __common__( common.sas_date((string)(_bs_ssn_ver_src_ldate_sb)));

bs_ssn_ver_src_sg_pos :=     __common__( Models.Common.findw_cpp(bus_ssn_ver_sources, 'SG' , '  ,', 'ie'));

_bs_ssn_ver_src_ldate_sg :=     __common__( if(bs_ssn_ver_src_sg_pos > 0, Models.Common.getw(bus_ssn_ver_sources_lseen, bs_ssn_ver_src_sg_pos), '0'));

bs_ssn_ver_src_ldate_sg :=     __common__( common.sas_date((string)(_bs_ssn_ver_src_ldate_sg)));

bs_ssn_ver_src_sj_pos :=     __common__( Models.Common.findw_cpp(bus_ssn_ver_sources, 'SJ' , '  ,', 'ie'));

_bs_ssn_ver_src_ldate_sj :=     __common__( if(bs_ssn_ver_src_sj_pos > 0, Models.Common.getw(bus_ssn_ver_sources_lseen, bs_ssn_ver_src_sj_pos), '0'));

bs_ssn_ver_src_ldate_sj :=     __common__( common.sas_date((string)(_bs_ssn_ver_src_ldate_sj)));

bs_ssn_ver_src_sk_pos :=     __common__( Models.Common.findw_cpp(bus_ssn_ver_sources, 'SK' , '  ,', 'ie'));

_bs_ssn_ver_src_ldate_sk :=     __common__( if(bs_ssn_ver_src_sk_pos > 0, Models.Common.getw(bus_ssn_ver_sources_lseen, bs_ssn_ver_src_sk_pos), '0'));

bs_ssn_ver_src_ldate_sk :=     __common__( common.sas_date((string)(_bs_ssn_ver_src_ldate_sk)));

bs_ssn_ver_src_sp_pos :=     __common__( Models.Common.findw_cpp(bus_ssn_ver_sources, 'SP' , '  ,', 'ie'));

_bs_ssn_ver_src_ldate_sp :=     __common__( if(bs_ssn_ver_src_sp_pos > 0, Models.Common.getw(bus_ssn_ver_sources_lseen, bs_ssn_ver_src_sp_pos), '0'));

bs_ssn_ver_src_ldate_sp :=     __common__( common.sas_date((string)(_bs_ssn_ver_src_ldate_sp)));

bs_ssn_ver_src_tx_pos :=     __common__( Models.Common.findw_cpp(bus_ssn_ver_sources, 'TX' , '  ,', 'ie'));

_bs_ssn_ver_src_ldate_tx :=     __common__( if(bs_ssn_ver_src_tx_pos > 0, Models.Common.getw(bus_ssn_ver_sources_lseen, bs_ssn_ver_src_tx_pos), '0'));

bs_ssn_ver_src_ldate_tx :=     __common__( common.sas_date((string)(_bs_ssn_ver_src_ldate_tx)));

bs_ssn_ver_src_u2_pos :=     __common__( Models.Common.findw_cpp(bus_ssn_ver_sources, 'U2' , '  ,', 'ie'));

_bs_ssn_ver_src_ldate_u2 :=     __common__( if(bs_ssn_ver_src_u2_pos > 0, Models.Common.getw(bus_ssn_ver_sources_lseen, bs_ssn_ver_src_u2_pos), '0'));

bs_ssn_ver_src_ldate_u2 :=     __common__( common.sas_date((string)(_bs_ssn_ver_src_ldate_u2)));

bs_ssn_ver_src_ut_pos :=     __common__( Models.Common.findw_cpp(bus_ssn_ver_sources, 'UT' , '  ,', 'ie'));

_bs_ssn_ver_src_ldate_ut :=     __common__( if(bs_ssn_ver_src_ut_pos > 0, Models.Common.getw(bus_ssn_ver_sources_lseen, bs_ssn_ver_src_ut_pos), '0'));

bs_ssn_ver_src_ldate_ut :=     __common__( common.sas_date((string)(_bs_ssn_ver_src_ldate_ut)));

bs_ssn_ver_src_v_pos :=     __common__( Models.Common.findw_cpp(bus_ssn_ver_sources, 'V' , '  ,', 'ie'));

_bs_ssn_ver_src_ldate_v :=     __common__( if(bs_ssn_ver_src_v_pos > 0, Models.Common.getw(bus_ssn_ver_sources_lseen, bs_ssn_ver_src_v_pos), '0'));

bs_ssn_ver_src_ldate_v :=     __common__( common.sas_date((string)(_bs_ssn_ver_src_ldate_v)));

bs_ssn_ver_src_v2_pos :=     __common__( Models.Common.findw_cpp(bus_ssn_ver_sources, 'V2' , '  ,', 'ie'));

_bs_ssn_ver_src_ldate_v2 :=     __common__( if(bs_ssn_ver_src_v2_pos > 0, Models.Common.getw(bus_ssn_ver_sources_lseen, bs_ssn_ver_src_v2_pos), '0'));

bs_ssn_ver_src_ldate_v2 :=     __common__( common.sas_date((string)(_bs_ssn_ver_src_ldate_v2)));

bs_ssn_ver_src_wa_pos :=     __common__( Models.Common.findw_cpp(bus_ssn_ver_sources, 'WA' , '  ,', 'ie'));

_bs_ssn_ver_src_ldate_wa :=     __common__( if(bs_ssn_ver_src_wa_pos > 0, Models.Common.getw(bus_ssn_ver_sources_lseen, bs_ssn_ver_src_wa_pos), '0'));

bs_ssn_ver_src_ldate_wa :=     __common__( common.sas_date((string)(_bs_ssn_ver_src_ldate_wa)));

bs_ssn_ver_src_wb_pos :=     __common__( Models.Common.findw_cpp(bus_ssn_ver_sources, 'WB' , '  ,', 'ie'));

_bs_ssn_ver_src_ldate_wb :=     __common__( if(bs_ssn_ver_src_wb_pos > 0, Models.Common.getw(bus_ssn_ver_sources_lseen, bs_ssn_ver_src_wb_pos), '0'));

bs_ssn_ver_src_ldate_wb :=     __common__( common.sas_date((string)(_bs_ssn_ver_src_ldate_wb)));

bs_ssn_ver_src_wc_pos :=     __common__( Models.Common.findw_cpp(bus_ssn_ver_sources, 'WC' , '  ,', 'ie'));

_bs_ssn_ver_src_ldate_wc :=     __common__( if(bs_ssn_ver_src_wc_pos > 0, Models.Common.getw(bus_ssn_ver_sources_lseen, bs_ssn_ver_src_wc_pos), '0'));

bs_ssn_ver_src_ldate_wc :=     __common__( common.sas_date((string)(_bs_ssn_ver_src_ldate_wc)));

bs_ssn_ver_src_wk_pos :=     __common__( Models.Common.findw_cpp(bus_ssn_ver_sources, 'WK' , '  ,', 'ie'));

_bs_ssn_ver_src_ldate_wk :=     __common__( if(bs_ssn_ver_src_wk_pos > 0, Models.Common.getw(bus_ssn_ver_sources_lseen, bs_ssn_ver_src_wk_pos), '0'));

bs_ssn_ver_src_ldate_wk :=     __common__( common.sas_date((string)(_bs_ssn_ver_src_ldate_wk)));

bs_ssn_ver_src_wx_pos :=     __common__( Models.Common.findw_cpp(bus_ssn_ver_sources, 'WX' , '  ,', 'ie'));

_bs_ssn_ver_src_ldate_wx :=     __common__( if(bs_ssn_ver_src_wx_pos > 0, Models.Common.getw(bus_ssn_ver_sources_lseen, bs_ssn_ver_src_wx_pos), '0'));

bs_ssn_ver_src_ldate_wx :=     __common__( common.sas_date((string)(_bs_ssn_ver_src_ldate_wx)));

bs_ssn_ver_src_y_pos :=     __common__( Models.Common.findw_cpp(bus_ssn_ver_sources, 'Y' , '  ,', 'ie'));

_bs_ssn_ver_src_ldate_y :=     __common__( if(bs_ssn_ver_src_y_pos > 0, Models.Common.getw(bus_ssn_ver_sources_lseen, bs_ssn_ver_src_y_pos), '0'));

bs_ssn_ver_src_ldate_y :=     __common__( common.sas_date((string)(_bs_ssn_ver_src_ldate_y)));

bs_ssn_ver_src_zo_pos :=     __common__( Models.Common.findw_cpp(bus_ssn_ver_sources, 'ZO' , '  ,', 'ie'));

_bs_ssn_ver_src_ldate_zo :=     __common__( if(bs_ssn_ver_src_zo_pos > 0, Models.Common.getw(bus_ssn_ver_sources_lseen, bs_ssn_ver_src_zo_pos), '0'));

bs_ssn_ver_src_ldate_zo :=     __common__( common.sas_date((string)(_bs_ssn_ver_src_ldate_zo)));

//iv_add_apt :=     __common__( if(StringLib.StringToUpperCase(trim(rc_dwelltype, LEFT, RIGHT)) = 'A' or StringLib.StringToUpperCase(trim(out_addr_type, LEFT, RIGHT)) = 'H' or not(out_unit_desig = NULL) or not(out_sec_range = NULL), 1, 0));
iv_add_apt :=     __common__( if(StringLib.StringToUpperCase(trim(rc_dwelltype, LEFT, RIGHT)) = 'A' or StringLib.StringToUpperCase(trim(out_addr_type, LEFT, RIGHT)) = 'H' or not(out_unit_desig = '') or not(out_sec_range = ''), '1', '0'));

add_ec1 :=     __common__( (StringLib.StringToUpperCase(trim(out_addr_status, LEFT)))[1..1]);

num_bureau_fname_1 :=     __common__( (integer)ver_fname_src_eq +
    (integer)ver_fname_src_en +
    (integer)ver_fname_src_tn);

num_bureau_lname_1 :=     __common__( (integer)ver_lname_src_eq +
    (integer)ver_lname_src_en +
    (integer)ver_lname_src_tn);

num_bureau_addr_1 :=     __common__( (integer)ver_addr_src_eq +
    (integer)ver_addr_src_en +
    (integer)ver_addr_src_tn);

num_bureau_ssn_1 :=     __common__( (integer)ver_ssn_src_eq +
    (integer)ver_ssn_src_en +
    (integer)ver_ssn_src_tn);

num_bureau_dob_1 :=     __common__( (integer)ver_dob_src_eq +
    (integer)ver_dob_src_en +
    (integer)ver_dob_src_tn);

//nas_summary_ver :=     __common__( if((integer)ssnlength = 9 and (nas_summary in [8, 9, 10, 11, 12]) or (nas_summary in [2, 4, 7]) and (boolean)(integer)add_input_isbestmatch));
nas_summary_ver :=     __common__( if((integer)ssnlength = 9 and (nas_summary in [8, 9, 10, 11, 12]) or (nas_summary in [2, 4, 7]) and add_input_isbestmatch, 1, 0));

nap_summary_ver :=     __common__( hphnpop and (nap_summary in [9, 10, 11, 12]));

infutor_nap_ver :=     __common__( hphnpop and (infutor_nap in [9, 10, 11, 12]));

dob_ver :=     __common__( dobpop and (integer)input_dob_match_level >= 5);

// sufficiently_verified :=     __common__( map(
   // (boolean)(integer)nas_summary_ver and (boolean)(integer)(nap_summary_ver or(boolean)(integer) infutor_nap_ver)          => 1,
    // (boolean)(integer)nas_summary_ver and (boolean)(integer)(dob_ver or not(dobpop))                      => 1,
    // ((boolean)(integer)dob_ver or not(dobpop)) and ((boolean)(integer)(nap_summary_ver or (boolean)(integer)infutor_nap_ver) => 1,
                                                                         // 0));
sufficiently_verified :=     __common__( map(
    (boolean)(integer)nas_summary_ver and ((boolean)(integer)nap_summary_ver or (boolean)(integer)infutor_nap_ver)          => 1,
    (boolean)(integer)nas_summary_ver and ((boolean)(integer)dob_ver or not(dobpop))                                        => 1,
    ((boolean)(integer)dob_ver or not(dobpop)) and ((boolean)(integer)nap_summary_ver or (boolean)(integer)infutor_nap_ver) => 1,
                                                                                                                               0));





addr_validation_problem :=     __common__( if(add_ec1 = 'E' and not(rc_addrvalflag = 'N') or rc_hriskaddrflag = '4' or rc_addrcommflag = '2' or (add_input_advo_res_or_bus in ['B', 'D']) or not(out_z5 = '') and (rc_hriskaddrflag = '2' or rc_ziptypeflag = '2') or add_input_advo_vacancy = 'Y', 1, 0));

phn_validation_problem :=     __common__( if(rc_hphonetypeflag = 'A' or rc_hriskphoneflag = '2' or rc_hphonetypeflag = '2' or (telcordia_type in ['02', '56', '61']) or rc_phonevalflag = '0' or rc_hphonevalflag = '0' or rc_phonetype = '5' or rc_hriskphoneflag = '6' or rc_hphonetypeflag = '5' or rc_hphonevalflag = '3' or rc_addrcommflag = '1', 1, 0));

validation_problem :=     __common__( if(adls_per_ssn >= 5 or ssns_per_adl >= 4 or invalid_ssns_per_adl >= 1 or adls_per_addr_curr >= 8 or ssns_per_addr_curr >= 7 or rc_hrisksic = '2225' or rc_hrisksicphone = '2225' or (boolean)(integer)addr_validation_problem or (boolean)(integer)phn_validation_problem, 1, 0));

tot_liens :=     __common__( if(max(liens_historical_unrel_count, liens_recent_unrel_count, 
 liens_recent_rel_count, liens_historical_rel_count) = NULL, NULL, 
 sum(if(liens_historical_unrel_count = NULL, 0, liens_historical_unrel_count), 
 if(liens_recent_unrel_count = NULL, 0, liens_recent_unrel_count), if(liens_recent_rel_count = NULL, 0, liens_recent_rel_count), 
 if(liens_historical_rel_count = NULL, 0, liens_historical_rel_count))));

/*// tot_liens :=     __common__( if(max(liens_historical_unrel_count, liens_recent_unrel_count, 
liens_recent_rel_count, liens_historical_rel_count) = NULL, NULL, 
sum(if(liens_historical_unrel_count = NULL, 0, liens_historical_unrel_count), 
if(liens_recent_unreleased_count = NULL, 0, liens_recent_unreleased_count), 
if(liens_recent_released_count = NULL, 0, liens_recent_released_count), 
if(liens_historical_released_count = NULL, 0, liens_historical_released_count))));*/

// tot_liens := if(max(liens_historical_unreleased_ct, liens_recent_unreleased_count, 
// liens_recent_released_count, liens_historical_released_count) = NULL, NULL, 
// sum(if(liens_historical_unreleased_ct = NULL, 0, liens_historical_unreleased_ct), 
// if(liens_recent_unreleased_count = NULL, 0, liens_recent_unreleased_count), 
// if(liens_recent_released_count = NULL, 0, liens_recent_released_count), 
// if(liens_historical_released_count = NULL, 0, liens_historical_released_count)));


tot_liens_w_type :=     __common__( if(max(liens_unrel_LT_ct, liens_rel_LT_ct, liens_unrel_SC_ct, liens_rel_SC_ct, liens_unrel_CJ_ct, liens_rel_CJ_ct, liens_unrel_FT_ct, liens_rel_FT_ct, liens_unrel_OT_ct, liens_rel_OT_ct, liens_unrel_ST_ct, liens_rel_ST_ct, liens_unrel_FC_ct, liens_rel_FC_ct, liens_unrel_O_ct, liens_rel_O_ct) = NULL, NULL, sum(if(liens_unrel_LT_ct = NULL, 0, liens_unrel_LT_ct), if(liens_rel_LT_ct = NULL, 0, liens_rel_LT_ct), if(liens_unrel_SC_ct = NULL, 0, liens_unrel_SC_ct), if(liens_rel_SC_ct = NULL, 0, liens_rel_SC_ct), if(liens_unrel_CJ_ct = NULL, 0, liens_unrel_CJ_ct), if(liens_rel_CJ_ct = NULL, 0, liens_rel_CJ_ct), if(liens_unrel_FT_ct = NULL, 0, liens_unrel_FT_ct), if(liens_rel_FT_ct = NULL, 0, liens_rel_FT_ct), if(liens_unrel_OT_ct = NULL, 0, liens_unrel_OT_ct), if(liens_rel_OT_ct = NULL, 0, liens_rel_OT_ct), if(liens_unrel_ST_ct = NULL, 0, liens_unrel_ST_ct), if(liens_rel_ST_ct = NULL, 0, liens_rel_ST_ct), if(liens_unrel_FC_ct = NULL, 0, liens_unrel_FC_ct), if(liens_rel_FC_ct = NULL, 0, liens_rel_FC_ct), if(liens_unrel_O_ct = NULL, 0, liens_unrel_O_ct), if(liens_rel_O_ct = NULL, 0, liens_rel_O_ct))));

has_derog :=     __common__( if(felony_count > 0 or criminal_count > 0 or stl_inq_count24 > 0 or attr_eviction_count > 0 or liens_unrel_CJ_ct > 0 or liens_rel_CJ_ct > 0 or liens_unrel_SC_ct > 0 or liens_rel_SC_ct > 0 or liens_unrel_FC_ct > 0 or liens_rel_FC_ct > 0 or liens_unrel_O_ct > 0 or liens_rel_O_ct > 0 or tot_liens - tot_liens_w_type > 0 or bk_dismissed_recent_count > 0 or bk_dismissed_historical_count > 0, 1, 0));

nf_phone_ver_bureau :=     __common__( if(not(truedid), NULL, (integer)phone_ver_bureau));

ip_routingmethod :=     __common__( map(
    ipaddr = ''          => '  ',
    iproutingmethod = '' => '-1',
                             iproutingmethod));

nf_inq_ssn_lexid_diff01 :=     __common__( if(not(truedid) or ssnlength != '9', NULL, inq_perssn_count01 - inq_count01));

rv_f00_inq_corrdobssn_adl :=     __common__( map(
    not(truedid)                         => NULL,
    (inq_corrdobssn_adl in [-3, -2, -1]) => NULL,
                                            inq_corrdobssn_adl));

rv_i60_inq_comm_recency :=     __common__( map(
    not(truedid)               => NULL,
    inq_communications_count01>0  => 1,
    inq_communications_count03>0  => 3,
    inq_communications_count06>0  => 6,
    inq_communications_count12>0  => 12,
    inq_communications_count24>0  => 24,
    inq_communications_count >0   => 99,
                                  0));

nf_inq_perbestssn_count12 :=     __common__( if(not(truedid), NULL, min(if(inq_perbestssn = NULL, -NULL, inq_perbestssn), 999)));

nf_fp_varrisktype :=     __common__( if(not(truedid), NULL, (integer)fp_varrisktype));

rv_i60_inq_hiriskcred_count12 :=     __common__( if(not(truedid), NULL, min(if(inq_highriskcredit_count12 = NULL, -NULL, inq_highriskcredit_count12), 999)));

iv_f00_email_verification :=     __common__( if(not(truedid), '', trim((string)email_verification, LEFT)));

nf_inq_per_phone :=     __common__( if(not(hphnpop), NULL, min(if(inq_perphone = NULL, -NULL, inq_perphone), 999)));

nf_inq_phone_ver_count :=     __common__( if(not(truedid) or inq_phone_ver_count = 255, NULL, inq_phone_ver_count));

rv_c14_addrs_5yr :=     __common__( map(
    not(truedid)     => NULL,
    (Integer)add_curr_pop = 0 => -1,
                        min(if(addrs_5yr = NULL, -NULL, addrs_5yr), 999)));

nf_inq_corraddrphone :=     __common__( map(
    not(truedid)                        => NULL,
    (inq_corraddrphone in [-3, -2, -1]) => NULL,
                                           inq_corraddrphone));

//nf_fp_srchvelocityrisktype :=     __common__( if(not(truedid), NULL, fp_srchvelocityrisktype));
nf_fp_srchvelocityrisktype :=     __common__( __common__( map(
	    not(truedid)                   => NULL,
	    fp_srchvelocityrisktype = ''	 => NULL,
	                                      (INTEGER)trim(fp_srchvelocityrisktype, LEFT))));

iv_inf_phn_verd :=     __common__( (infutor_nap in [4, 6, 7, 9, 10, 11, 12]));

//nf_historic_x_current_ct :=     __common__( if(not(truedid), '', (string)min(if(historical_count = NULL, -NULL, historical_count), 3) || '-' || (string)min(if(current_count = NULL, -NULL, current_count), 3)));
nf_historic_x_current_ct :=     __common__(  __common__( if(not(truedid), '', trim((String)min(if(historical_count = NULL, -NULL, historical_count), 3), LEFT, RIGHT) 
+ trim('-', LEFT, RIGHT) + trim((String)min(if(current_count = NULL, -NULL, current_count), 3), LEFT, RIGHT))));

nf_inq_highriskcredit_count24 :=     __common__( if(not(truedid), NULL, min(if(inq_highriskcredit_count24 = NULL, -NULL, inq_highriskcredit_count24), 999)));

nf_fp_idverrisktype :=     __common__( if(not(truedid), NULL, (integer)fp_idverrisktype));

nf_inq_adls_per_apt_addr :=     __common__( map(
    not(addrpop)                      => NULL,
    not((boolean)(integer)iv_add_apt) => -1,
                                         min(if(inq_adlsperaddr = NULL, -NULL, inq_adlsperaddr), 999)));

nf_inq_corrnamephone :=     __common__( map(
    not(truedid)                        => NULL,
    (inq_corrnamephone in [-3, -2, -1]) => NULL,
                                           inq_corrnamephone));

earliest_cred_date_all :=     __common__( if(ver_src_fdate_ar = NULL and ver_src_fdate_am = NULL and ver_src_fdate_ba = NULL and ver_src_fdate_cg = NULL and ver_src_fdate_da = NULL and ver_src_fdate_d = NULL and ver_src_fdate_dl = NULL and ver_src_fdate_eb = NULL and ver_src_fdate_e1 = NULL and ver_src_fdate_e2 = NULL and ver_src_fdate_e3 = NULL and ver_src_fdate_fe = NULL and ver_src_fdate_ff = NULL and ver_src_fdate_p = NULL and ver_src_fdate_pl = NULL and ver_src_fdate_sl = NULL and ver_src_fdate_v = NULL and ver_src_fdate_vo = NULL and ver_src_fdate_w = NULL, NULL, if(max(ver_src_fdate_ar, ver_src_fdate_am, ver_src_fdate_ba, ver_src_fdate_cg, ver_src_fdate_da, ver_src_fdate_d, ver_src_fdate_dl, ver_src_fdate_eb, ver_src_fdate_e1, ver_src_fdate_e2, ver_src_fdate_e3, ver_src_fdate_fe, ver_src_fdate_ff, ver_src_fdate_p, ver_src_fdate_pl, ver_src_fdate_sl, ver_src_fdate_v, ver_src_fdate_vo, ver_src_fdate_w) = NULL, NULL, min(if(ver_src_fdate_ar = NULL, -NULL, ver_src_fdate_ar), if(ver_src_fdate_am = NULL, -NULL, ver_src_fdate_am), if(ver_src_fdate_ba = NULL, -NULL, ver_src_fdate_ba), if(ver_src_fdate_cg = NULL, -NULL, ver_src_fdate_cg), if(ver_src_fdate_da = NULL, -NULL, ver_src_fdate_da), if(ver_src_fdate_d = NULL, -NULL, ver_src_fdate_d), if(ver_src_fdate_dl = NULL, -NULL, ver_src_fdate_dl), if(ver_src_fdate_eb = NULL, -NULL, ver_src_fdate_eb), if(ver_src_fdate_e1 = NULL, -NULL, ver_src_fdate_e1), if(ver_src_fdate_e2 = NULL, -NULL, ver_src_fdate_e2), if(ver_src_fdate_e3 = NULL, -NULL, ver_src_fdate_e3), if(ver_src_fdate_fe = NULL, -NULL, ver_src_fdate_fe), if(ver_src_fdate_ff = NULL, -NULL, ver_src_fdate_ff), if(ver_src_fdate_p = NULL, -NULL, ver_src_fdate_p), if(ver_src_fdate_pl = NULL, -NULL, ver_src_fdate_pl), if(ver_src_fdate_sl = NULL, -NULL, ver_src_fdate_sl), if(ver_src_fdate_v = NULL, -NULL, ver_src_fdate_v), if(ver_src_fdate_vo = NULL, -NULL, ver_src_fdate_vo), if(ver_src_fdate_w = NULL, -NULL, ver_src_fdate_w)))));

nf_m_src_credentialed_fs :=     __common__( map(
    not(truedid)                  => NULL,
    earliest_cred_date_all = NULL => -1,
                                     min(if(if ((sysdate - earliest_cred_date_all) / (365.25 / 12) >= 0, truncate((sysdate - earliest_cred_date_all) / (365.25 / 12)), roundup((sysdate - earliest_cred_date_all) / (365.25 / 12))) = NULL, -NULL, if ((sysdate - earliest_cred_date_all) / (365.25 / 12) >= 0, truncate((sysdate - earliest_cred_date_all) / (365.25 / 12)), roundup((sysdate - earliest_cred_date_all) / (365.25 / 12)))), 999)));

nf_inq_adlsperphone_count_week :=     __common__( if(not(truedid), NULL, min(if(inq_adlsperphone_count_week = NULL, -NULL, inq_adlsperphone_count_week), 999)));

nf_inq_corrphonessn :=     __common__( map(
    not(truedid)                       => NULL,
    (inq_corrphonessn in [-3, -2, -1]) => NULL,
                                          inq_corrphonessn));

nf_inq_communications_count24 :=     __common__( if(not(truedid), NULL, min(if(inq_Communications_count24 = NULL, -NULL, inq_Communications_count24), 999)));

nf_inq_corrdobphone :=     __common__( map(
    not(truedid)                       => NULL,
    (inq_corrdobphone in [-3, -2, -1]) => NULL,
                                          inq_corrdobphone));

nf_inq_dob_ver_count :=     __common__( if(not(truedid) or inq_dob_ver_count = 255, NULL, inq_dob_ver_count));

// ip_topleveldomain_lvl :=     __common__( map(
    // ipaddr = NULL                                                         => '',
    // topleveldomain = NULL                                                 => '-1',
    // (UPCASE(topleveldomain) in ['COM', 'EDU', 'GOV', 'NET', 'ORG', 'US']) => UPCASE(topleveldomain),
    // STD.Str.FindCount(topleveldomain, '.') > 0                            => 'DOT',
    // length(trim((string)topleveldomain, ALL)) < 3                         => 'TWO',
                                                                             // 'OTH'));
ip_topleveldomain_lvl :=     __common__(  map(
    ipaddr = ''                                                         => ' ',
    topleveldomain = ''                                                 => '-1',
    (UPCASE(topleveldomain) in ['COM', 'EDU', 'GOV', 'NET', 'ORG', 'US']) 				=> UPCASE(topleveldomain),
    stringlib.stringfind(topleveldomain, '.', 1) > 0        						=> 'DOT',  
    length(trim((string)topleveldomain, ALL)) < 3                       => 'TWO',
																																					 'OTH') );
                                                                             
                                                                             
                                                                             

nf_inq_highriskcredit_count_week :=     __common__( if(not(truedid), NULL, min(if(inq_highriskcredit_count_week = NULL, -NULL, inq_highriskcredit_count_week), 999)));

rv_l79_adls_per_sfd_addr_c6 :=     __common__( map(
    not(addrpop)   => NULL,
    iv_add_apt = '1' => -1,
                      min(if(adls_per_addr_c6 = NULL, -NULL, adls_per_addr_c6), 999)));

iv_nap_inf_phone_ver_lvl :=     __common__( map(
    (nap_summary in [4, 6, 7, 9, 10, 11, 12]) and (infutor_nap in [4, 6, 7, 9, 10, 11, 12]) => 3,
    (nap_summary in [4, 6, 7, 9, 10, 11, 12])                                               => 2,
    (infutor_nap in [4, 6, 7, 9, 10, 11, 12])                                               => 1,
                                                                                               0));

// nf_unvrfd_search_risk_index :=     __common__( if(not(truedid), NULL, if(max(2 ** 0 * (integer)(fp_srchunvrfdphonecount > 0) +
    // 2 ** 1 * (integer)(fp_srchunvrfddobcount > 0) +
    // 2 ** 2 * (integer)(fp_srchunvrfdaddrcount > 0) +
    // 2 ** 3 * (integer)(fp_srchunvrfdssncount > 0)) = NULL, NULL, sum(if(2 ** 0 * (integer)(fp_srchunvrfdphonecount > 0) +
    // 2 ** 1 * (integer)(fp_srchunvrfddobcount > 0) +
    // 2 ** 2 * (integer)(fp_srchunvrfdaddrcount > 0) +
    // 2 ** 3 * (integer)(fp_srchunvrfdssncount > 0) = NULL, 0, 2 ** 0 * (integer)(fp_srchunvrfdphonecount > 0) +
    // 2 ** 1 * (integer)(fp_srchunvrfddobcount > 0) +
    // 2 ** 2 * (integer)(fp_srchunvrfdaddrcount > 0) +
    // 2 ** 3 * (integer)(fp_srchunvrfdssncount > 0))))));
  
  nf_unvrfd_search_risk_index :=     __common__( if(not(truedid), NULL, if(max((integer)(fp_srchunvrfdphonecount > '0') + 
    2* (integer)(fp_srchunvrfddobcount > '0') +
    4* (integer)(fp_srchunvrfdaddrcount > '0') +
    8* (integer)(fp_srchunvrfdssncount > '0')) = NULL, NULL, sum(if((integer)(fp_srchunvrfdphonecount > '0') +
    2* (integer)(fp_srchunvrfddobcount > '0') +
    4* (integer)(fp_srchunvrfdaddrcount > '0') +
    8* (integer)(fp_srchunvrfdssncount > '0') = NULL, 0, (integer)(fp_srchunvrfdphonecount > '0') +
    2* (integer)(fp_srchunvrfddobcount > '0') +
    4* (integer)(fp_srchunvrfdaddrcount > '0') +
    8* (integer)(fp_srchunvrfdssncount > '0'))))));
  
    

nf_fp_srchcomponentrisktype :=     __common__( if(not(truedid), NULL, (integer)fp_srchcomponentrisktype));

iv_fname_non_phn_src_ct :=     __common__( if(not(truedid and fnamepop), NULL, min(if(rc_fnamecount = NULL, -NULL, rc_fnamecount), 999)));

nf_fp_srchunvrfdphonecount :=     __common__( if(not(truedid), NULL, min(if(fp_srchunvrfdphonecount = '', -NULL, (integer)fp_srchunvrfdphonecount), 999)));

rv_i62_inq_dobsperadl_1dig :=     __common__( map(
    not(truedid)                          => NULL,
    (inq_dobsperadl_1dig in [-3, -2, -1]) => NULL,
                                             inq_dobsperadl_1dig));

nf_util_adl_count :=     __common__( if(not(truedid), NULL, util_adl_count));

nf_inq_banking_count24 :=     __common__( if(not(truedid), NULL, min(if(inq_Banking_count24 = NULL, -NULL, inq_Banking_count24), 999)));

rv_c14_addrs_10yr :=     __common__( map(
    not(truedid)     => NULL,
   (integer) add_curr_pop = 0 => -1,
                        min(if(addrs_10yr = NULL, -NULL, addrs_10yr), 999)));

rv_d34_liens_rel_total_amt :=     __common__( if(not(truedid), NULL, liens_rel_total_amount));

rv_l79_adls_per_addr_curr :=     __common__( map(
    not(addrpop)                                     => NULL,
    adls_per_addr_curr = 1 or adls_per_addr_curr = 2 => 1.5,
                                                        min(if(adls_per_addr_curr = NULL, -NULL, adls_per_addr_curr), 999)));

// rv_6seg_riskview_5_0 :=     __common__( map(
    // truedid = 0                                                                                    => '0 TRUEDID = 0',
    // not((boolean)sufficiently_verified)                                                            => '1 VER/VAL PROBLEMS',
    // validation_problem                                                                             => '1 VER/VAL PROBLEMS',
    // not((boolean)(integer)add_input_isbestmatch) and (boolean)(integer)has_derog                   => '2 ADDR NOT CURRENT - DEROG',
    // not((boolean)(integer)add_input_isbestmatch)                                                   => '3 ADDR NOT CURRENT - OTHER',
    // has_derog                                                                                      => '4 SUFFICIENTLY VERD - DEROG',
    // (boolean)(integer)add_input_isbestmatch and (add_input_naprop = 4 or property_owned_total > 0) => '5 SUFFICIENTLY VERD - OWNER',
                                                                                                      // '6 SUFFICIENTLY VERD - OTHER'));
rv_6seg_riskview_5_0 :=     __common__( __common__( map(
    (Integer)truedid = 0                                                                                                     => '0 TRUEDID = 0              ',
    not((boolean)sufficiently_verified)                                                                             => '1 VER/VAL PROBLEMS         ',
    (boolean)sufficiently_verified and (boolean)(integer)validation_problem                                         => '1 VER/VAL PROBLEMS         ',
    (boolean)sufficiently_verified and not(add_input_isbestmatch) and (boolean)(integer)has_derog                   => '2 ADDR NOT CURRENT - DEROG ',
    (boolean)sufficiently_verified and not(add_input_isbestmatch)                                                   => '3 ADDR NOT CURRENT - OTHER ',
    (boolean)sufficiently_verified and add_input_isbestmatch and (boolean)(integer)has_derog                        => '4 SUFFICIENTLY VERD - DEROG',
    (boolean)sufficiently_verified and add_input_isbestmatch and (add_input_naprop = 4 or property_owned_total > 0) => '5 SUFFICIENTLY VERD - OWNER',
                                                                                                                       '6 SUFFICIENTLY VERD - OTHER')));





//ip_state_match :=     __common__( if(out_st = NULL or state = NULL, NULL, UPCASE(out_st) = UPCASE(state)));
ip_state_match:=     __common__( __common__( if(out_st = '' or state = '', NULL, if(UPCASE(out_st) = UPCASE(state), 1, 0)) ));


nf_inq_per_ssn :=     __common__( if(not(ssnlength = '9'), NULL, min(if(inq_perssn = NULL, -NULL, inq_perssn), 999)));

nf_inq_ssnspercurraddr_count12 :=     __common__( if(not(truedid), NULL, min(if(inq_ssnspercurraddr = NULL, -NULL, inq_ssnspercurraddr), 999)));

rv_i62_inq_phones_per_adl :=     __common__( if(not(truedid), NULL, min(if(inq_phonesperadl = NULL, -NULL, inq_phonesperadl), 999)));

rv_c14_addrs_15yr :=     __common__( if(not(truedid), NULL, min(if(addrs_15yr = NULL, -NULL, addrs_15yr), 999)));

rv_f00_inq_corrdobaddr_adl :=     __common__( map(
    not(truedid)                          => NULL,
    (inq_corrdobaddr_adl in [-3, -2, -1]) => NULL,
                                             inq_corrdobaddr_adl));

nf_fpc_idver_addressmatchescurr :=     __common__( if(not(truedid), NULL, (integer)fpc_IDVer_AddressMatchesCurr));

// rv_d31_mostrec_bk :=     __common__( map(
    // not(truedid)                                    => '',
    // contains_i(UPCASE(disposition), 'DISMISS') = 1  => '1 - BK DISMISSED',
    // contains_i(UPCASE(disposition), 'DISCHARG') = 1 => '2 - BK DISCHARGED',
    // bankrupt = 1 or filing_count > 0                => '3 - BK OTHER',
                                                       // '0 - NO BK'));

rv_d31_mostrec_bk :=     __common__(  map(
    not(truedid)                                    => '',
		contains_i(UPCASE(disposition), 'CASE DISMISS') > 0  => '3 - BK OTHER',
    contains_i(UPCASE(disposition), 'DISMISS') > 0  => '1 - BK DISMISSED ',
    contains_i(UPCASE(disposition), 'DISCHARG') > 0  => '2 - BK DISCHARGED',
    bankrupt = true or filing_count > 0                => '3 - BK OTHER     ',
                                                       '0 - NO BK        ')); 


rv_d33_eviction_recency :=     __common__( map(
    not(truedid)                                                => NULL,
   (boolean) attr_eviction_count90                                       => 3,
    (boolean)attr_eviction_count180                                      => 6,
    (boolean)attr_eviction_count12                                       => 12,
    (boolean)attr_eviction_count24 and attr_eviction_count >= 2 => 24,
    (boolean)attr_eviction_count24                                       => 25,
    (boolean)attr_eviction_count36 and attr_eviction_count >= 2 => 36,
    (boolean)attr_eviction_count36                                       => 37,
    (boolean)attr_eviction_count60 and attr_eviction_count >= 2 => 60,
    (boolean)attr_eviction_count60                                       => 61,
    attr_eviction_count >= 2                                    => 98,
    attr_eviction_count >= 1                                    => 99,
                                                                   999));

rv_d34_liens_rel_total_amt84 :=     __common__( if(not(truedid), NULL, liens_rel_total_amount84));

nf_inq_perphone_count_week :=     __common__( if(not(truedid), NULL, min(if(inq_perphone_count_week = NULL, -NULL, inq_perphone_count_week), 999)));

nf_invbest_inq_peraddr_diff :=     __common__( map(
    not(truedid) or (integer)addrpop = 0 => NULL,
    (integer)add_input_isbestmatch = 1   => -9999,
                                   inq_peraddr - inq_percurraddr));

rv_l79_adls_per_addr_c6 :=     __common__( if(not(addrpop), NULL, min(if(adls_per_addr_c6 = NULL, -NULL, adls_per_addr_c6), 999)));

//iv_d34_liens_unrel_x_rel :=     __common__( if(not(truedid), '', 
// (string)min(if(if(max(liens_recent_unrel_count, liens_historical_unrel_count) = NULL, NULL, 
// sum(if(liens_recent_unrel_count = NULL, 0, liens_recent_unrel_count), 
// if(liens_historical_unrel_count = NULL, 0, liens_historical_unrel_count))) = NULL, -NULL, 
// if(max(liens_recent_unrel_count, liens_historical_unrel_count) = NULL, NULL, 
// sum(if(liens_recent_unrel_count = NULL, 0, liens_recent_unrel_count), 
// if(liens_historical_unrel_count = NULL, 0, liens_historical_unrel_count)))), 3) || '-' || 
// (string)min(if(if(max(liens_recent_rel_count, liens_historical_rel_count) = NULL, NULL, 
// sum(if(liens_recent_rel_count = NULL, 0, liens_recent_rel_count), 
// if(liens_historical_rel_count = NULL, 0, liens_historical_rel_count))) = NULL, -NULL, 
// if(max(liens_recent_rel_count, liens_historical_rel_count) = NULL, NULL, 
// sum(if(liens_recent_rel_count = NULL, 0, liens_recent_rel_count), 
// if(liens_historical_rel_count = NULL, 0, liens_historical_rel_count)))), 2)));

iv_d34_liens_unrel_x_rel :=     __common__(  if(not(truedid), '   ', 
           trim((String)min(if(if(max(liens_recent_unrel_count, liens_historical_unrel_count) = NULL, NULL, 
                        sum(if(liens_recent_unrel_count = NULL, 0, liens_recent_unrel_count), 
                        if(liens_historical_unrel_count = NULL, 0, liens_historical_unrel_count))) = NULL, -NULL, 
                        if(max(liens_recent_unrel_count, liens_historical_unrel_count) = NULL, NULL, 
                        sum(if(liens_recent_unrel_count = NULL, 0, liens_recent_unrel_count), 
                        if(liens_historical_unrel_count = NULL, 0, liens_historical_unrel_count)))), 3), LEFT, RIGHT) + 
                        trim('-', LEFT, RIGHT) + 
                        trim((String)min(if(if(max(liens_recent_rel_count, liens_historical_rel_count) = NULL, NULL, 
                        sum(if(liens_recent_rel_count = NULL, 0, liens_recent_rel_count), 
                        if(liens_historical_rel_count = NULL, 0, liens_historical_rel_count))) = NULL, -NULL, 
                        if(max(liens_recent_rel_count, liens_historical_rel_count) = NULL, NULL, 
                        sum(if(liens_recent_rel_count = NULL, 0, liens_recent_rel_count), 
                        if(liens_historical_rel_count = NULL, 0, liens_historical_rel_count)))), 2), LEFT, RIGHT)));


rv_i61_inq_collection_count12 :=     __common__( if(not(truedid), NULL, min(if(inq_collection_count12 = NULL, -NULL, inq_collection_count12), 999)));

nf_inq_bestdob_ver_count :=     __common__( if(not(truedid) or inq_bestdob_ver_count = 255, NULL, min(if(inq_bestdob_ver_count = NULL, -NULL, inq_bestdob_ver_count), 999)));

nf_inq_adls_per_phone :=     __common__( if(not(hphnpop), NULL, min(if(inq_adlsperphone = NULL, -NULL, inq_adlsperphone), 999)));

rv_p88_phn_dst_to_inp_add :=     __common__( if(rc_disthphoneaddr = 9999, NULL, rc_disthphoneaddr));

nf_inq_addr_ver_count :=     __common__( if(not(truedid) or inq_addr_ver_count = 255, NULL, inq_addr_ver_count));

rv_l79_adls_per_sfd_addr :=     __common__( map(
    not(addrpop)   => NULL,
    iv_add_apt = '1' => -1,
                      min(if(adls_per_addr_curr = NULL, -NULL, adls_per_addr_curr), 999)));

nf_inq_perphone_count12 :=     __common__( if(not(truedid), NULL, min(if(Inq_PerPhone = NULL, -NULL, Inq_PerPhone), 999)));

_liens_unrel_st_last_seen :=     __common__( common.sas_date((string)(liens_unrel_st_last_seen)));

nf_mos_liens_unrel_st_lseen :=     __common__( map(
    not(truedid)                     => NULL,
    _liens_unrel_st_last_seen = NULL => -1,
                                        min(if(if ((sysdate - _liens_unrel_st_last_seen) / (365.25 / 12) >= 0, truncate((sysdate - _liens_unrel_st_last_seen) / (365.25 / 12)), roundup((sysdate - _liens_unrel_st_last_seen) / (365.25 / 12))) = NULL, -NULL, if ((sysdate - _liens_unrel_st_last_seen) / (365.25 / 12) >= 0, truncate((sysdate - _liens_unrel_st_last_seen) / (365.25 / 12)), roundup((sysdate - _liens_unrel_st_last_seen) / (365.25 / 12)))), 999)));

// rv_c24_prv_addr_lres :=     __common__( if(not(truedid and (boolean)(integer)add_prev_pop), NULL, 
                      // min(if(add_prev_lres = NULL, -NULL, add_prev_lres), 999)));
                      
rv_c24_prv_addr_lres :=     __common__( if(not(truedid and add_prev_pop), NULL, 
                     min(if(add_prev_lres = NULL, -NULL, add_prev_lres), 999)));                      
                      
                      

rv_f00_inq_corrphonessn_adl :=     __common__( map(
    not(truedid)                           => NULL,
    (inq_corrphonessn_adl in [-3, -2, -1]) => NULL,
                                              inq_corrphonessn_adl));

rv_i60_inq_prepaidcards_recency :=     __common__( map(
    not(truedid)             => NULL,
    (Boolean)inq_PrepaidCards_count01 => 1,
    (Boolean)inq_PrepaidCards_count03 => 3,
    (Boolean)inq_PrepaidCards_count06 => 6,
    (Boolean)inq_PrepaidCards_count12 => 12,
    (Boolean)inq_PrepaidCards_count24 => 24,
    (Boolean)inq_PrepaidCards_count   => 99,
                                0));

nf_util_adl_summary :=     __common__( map(
    not(truedid)                                => '',
    util_type_1 and util_type_2 and util_type_z => 'ICM',
    util_type_1 and util_type_2                 => 'IC',
    util_type_1 and util_type_z                 => 'IM',
    util_type_2 and util_type_z                 => 'CM',
    util_type_1                                 => 'I',
    util_type_2                                 => 'C',
    util_type_z                                 => 'M',
                                                    ''));

d_pos :=     __common__( Models.Common.findw_cpp(ver_sources, 'D' , ', ', 'E'));

lic_adl_count_d :=     __common__( if(d_pos = 0, 0, (integer)Models.Common.getw(ver_sources_count, d_pos, ',')));

dl_pos :=     __common__( Models.Common.findw_cpp(ver_sources, 'DL' , ', ', 'E'));

lic_adl_count_dl :=     __common__( if(dl_pos = 0, 0, (integer)Models.Common.getw(ver_sources_count, dl_pos, ',')));

src_drivers_license_adl_count :=     __common__( max(if(max(lic_adl_count_d, lic_adl_count_dl) = NULL, NULL, sum(if(lic_adl_count_d = NULL, 0, lic_adl_count_d), if(lic_adl_count_dl = NULL, 0, lic_adl_count_dl))), (real)0));

iv_src_drivers_lic_adl_count :=     __common__( map(
    not(truedid)                         => NULL,
    not(dl_avail)                        => -1,
    src_drivers_license_adl_count = NULL => -1,
                                            src_drivers_license_adl_count));

nf_inq_curraddr_ver_count :=     __common__( if(not(truedid) or inq_curraddr_ver_count = 255, NULL, min(if(inq_curraddr_ver_count = NULL, -NULL, inq_curraddr_ver_count), 999)));

_liens_last_unrel_date84 :=     __common__( common.sas_date((string)(liens_last_unrel_date84)));

rv_d34_mos_last_unrel_lien_dt84 :=     __common__( map(
    not(truedid)                 => NULL,
    liens_last_unrel_date84 = '' => NULL,
                                    if ((sysdate - _liens_last_unrel_date84) / 30.5 >= 0, roundup((sysdate - _liens_last_unrel_date84) / 30.5), truncate((sysdate - _liens_last_unrel_date84) / 30.5))));

nf_liens_unrel_ot_total_amt :=     __common__( if(not(truedid), NULL, liens_unrel_ot_total_amount));

nf_inq_ssns_per_sfd_addr :=     __common__( map(
    not(addrpop) => NULL,
    iv_add_apt ='1'  => -1,
                    min(if(inq_ssnsperaddr = NULL, -NULL, inq_ssnsperaddr), 999)));

nf_inq_bestlname_ver_count :=     __common__( if(not(truedid) or inq_bestlname_ver_count = 255, NULL, min(if(inq_bestlname_ver_count = NULL, -NULL, inq_bestlname_ver_count), 999)));

iv_c13_avg_lres :=     __common__( if(not(truedid), NULL, min(if(avg_lres = NULL, -NULL, avg_lres), 999)));

_header_first_seen :=     __common__( common.sas_date((string)(header_first_seen)));

rv_c10_m_hdr_fs :=     __common__( map(
    not(truedid)              => NULL,
    _header_first_seen = NULL => -1,
                                 min(if(if ((sysdate - _header_first_seen) / (365.25 / 12) >= 0, truncate((sysdate - _header_first_seen) / (365.25 / 12)), roundup((sysdate - _header_first_seen) / (365.25 / 12))) = NULL, -NULL, if ((sysdate - _header_first_seen) / (365.25 / 12) >= 0, truncate((sysdate - _header_first_seen) / (365.25 / 12)), roundup((sysdate - _header_first_seen) / (365.25 / 12)))), 999)));

nf_inq_addrsperbestssn_count12 :=     __common__( if(not(truedid), NULL, min(if(inq_addrsperbestssn = NULL, -NULL, inq_addrsperbestssn), 999)));

nf_email_name_addr_ver :=     __common__( if(not(emailpop), NULL, (integer)email_name_addr_verification));

nf_historical_count :=     __common__( if(not(truedid), NULL, min(if(historical_count = NULL, -NULL, historical_count), 999)));

rv_c12_source_profile :=     __common__( if(not(truedid), NULL, hdr_source_profile));

rv_c23_email_domain_isp_cnt :=     __common__( if(not(truedid), NULL, min(if(email_domain_ISP_count = NULL, -NULL, email_domain_ISP_count), 999)));

corrssnaddr_src_ak_pos :=     __common__( Models.Common.findw_cpp(corrssnaddr_sources, 'AK' , '  ,', 'ie'));

corrssnaddr_src_ak :=     __common__( corrssnaddr_src_ak_pos > 0);

corrssnaddr_src_am_pos :=     __common__( Models.Common.findw_cpp(corrssnaddr_sources, 'AM' , '  ,', 'ie'));

corrssnaddr_src_am :=     __common__( corrssnaddr_src_am_pos > 0);

corrssnaddr_src_ar_pos :=     __common__( Models.Common.findw_cpp(corrssnaddr_sources, 'AR' , '  ,', 'ie'));

corrssnaddr_src_ar :=     __common__( corrssnaddr_src_ar_pos > 0);

corrssnaddr_src_ba_pos :=     __common__( Models.Common.findw_cpp(corrssnaddr_sources, 'BA' , '  ,', 'ie'));

corrssnaddr_src_ba :=     __common__( corrssnaddr_src_ba_pos > 0);

corrssnaddr_src_cg_pos :=     __common__( Models.Common.findw_cpp(corrssnaddr_sources, 'CG' , '  ,', 'ie'));

corrssnaddr_src_cg :=     __common__( corrssnaddr_src_cg_pos > 0);

corrssnaddr_src_co_pos :=     __common__( Models.Common.findw_cpp(corrssnaddr_sources, 'CO' , '  ,', 'ie'));

corrssnaddr_src_co :=     __common__( corrssnaddr_src_co_pos > 0);

corrssnaddr_src_cy_pos :=     __common__( Models.Common.findw_cpp(corrssnaddr_sources, 'CY' , '  ,', 'ie'));

corrssnaddr_src_cy :=     __common__( corrssnaddr_src_cy_pos > 0);

corrssnaddr_src_da_pos :=     __common__( Models.Common.findw_cpp(corrssnaddr_sources, 'DA' , '  ,', 'ie'));

corrssnaddr_src_da :=     __common__( corrssnaddr_src_da_pos > 0);

corrssnaddr_src_d_pos :=     __common__( Models.Common.findw_cpp(corrssnaddr_sources, 'D' , '  ,', 'ie'));

corrssnaddr_src_d :=     __common__( corrssnaddr_src_d_pos > 0);

corrssnaddr_src_dl_pos :=     __common__( Models.Common.findw_cpp(corrssnaddr_sources, 'DL' , '  ,', 'ie'));

corrssnaddr_src_dl :=     __common__( corrssnaddr_src_dl_pos > 0);

corrssnaddr_src_ds_pos :=     __common__( Models.Common.findw_cpp(corrssnaddr_sources, 'DS' , '  ,', 'ie'));

corrssnaddr_src_ds :=     __common__( corrssnaddr_src_ds_pos > 0);

corrssnaddr_src_de_pos :=     __common__( Models.Common.findw_cpp(corrssnaddr_sources, 'DE' , '  ,', 'ie'));

corrssnaddr_src_de :=     __common__( corrssnaddr_src_de_pos > 0);

corrssnaddr_src_eb_pos :=     __common__( Models.Common.findw_cpp(corrssnaddr_sources, 'EB' , '  ,', 'ie'));

corrssnaddr_src_eb :=     __common__( corrssnaddr_src_eb_pos > 0);

corrssnaddr_src_em_pos :=     __common__( Models.Common.findw_cpp(corrssnaddr_sources, 'EM' , '  ,', 'ie'));

corrssnaddr_src_em :=     __common__( corrssnaddr_src_em_pos > 0);

corrssnaddr_src_e1_pos :=     __common__( Models.Common.findw_cpp(corrssnaddr_sources, 'E1' , '  ,', 'ie'));

corrssnaddr_src_e1 :=     __common__( corrssnaddr_src_e1_pos > 0);

corrssnaddr_src_e2_pos :=     __common__( Models.Common.findw_cpp(corrssnaddr_sources, 'E2' , '  ,', 'ie'));

corrssnaddr_src_e2 :=     __common__( corrssnaddr_src_e2_pos > 0);

corrssnaddr_src_e3_pos :=     __common__( Models.Common.findw_cpp(corrssnaddr_sources, 'E3' , '  ,', 'ie'));

corrssnaddr_src_e3 :=     __common__( corrssnaddr_src_e3_pos > 0);

corrssnaddr_src_e4_pos :=     __common__( Models.Common.findw_cpp(corrssnaddr_sources, 'E4' , '  ,', 'ie'));

corrssnaddr_src_e4 :=     __common__( corrssnaddr_src_e4_pos > 0);

corrssnaddr_src_en_pos :=     __common__( Models.Common.findw_cpp(corrssnaddr_sources, 'EN' , '  ,', 'ie'));

corrssnaddr_src_en :=     __common__( corrssnaddr_src_en_pos > 0);

corrssnaddr_src_eq_pos :=     __common__( Models.Common.findw_cpp(corrssnaddr_sources, 'EQ' , '  ,', 'ie'));

corrssnaddr_src_eq :=     __common__( corrssnaddr_src_eq_pos > 0);

corrssnaddr_src_fe_pos :=     __common__( Models.Common.findw_cpp(corrssnaddr_sources, 'FE' , '  ,', 'ie'));

corrssnaddr_src_fe :=     __common__( corrssnaddr_src_fe_pos > 0);

corrssnaddr_src_ff_pos :=     __common__( Models.Common.findw_cpp(corrssnaddr_sources, 'FF' , '  ,', 'ie'));

corrssnaddr_src_ff :=     __common__( corrssnaddr_src_ff_pos > 0);

corrssnaddr_src_fr_pos :=     __common__( Models.Common.findw_cpp(corrssnaddr_sources, 'FR' , '  ,', 'ie'));

corrssnaddr_src_fr :=     __common__( corrssnaddr_src_fr_pos > 0);

corrssnaddr_src_l2_pos :=     __common__( Models.Common.findw_cpp(corrssnaddr_sources, 'L2' , '  ,', 'ie'));

corrssnaddr_src_l2 :=     __common__( corrssnaddr_src_l2_pos > 0);

corrssnaddr_src_li_pos :=     __common__( Models.Common.findw_cpp(corrssnaddr_sources, 'LI' , '  ,', 'ie'));

corrssnaddr_src_li :=     __common__( corrssnaddr_src_li_pos > 0);

corrssnaddr_src_mw_pos :=     __common__( Models.Common.findw_cpp(corrssnaddr_sources, 'MW' , '  ,', 'ie'));

corrssnaddr_src_mw :=     __common__( corrssnaddr_src_mw_pos > 0);

corrssnaddr_src_nt_pos :=     __common__( Models.Common.findw_cpp(corrssnaddr_sources, 'NT' , '  ,', 'ie'));

corrssnaddr_src_nt :=     __common__( corrssnaddr_src_nt_pos > 0);

corrssnaddr_src_p_pos :=     __common__( Models.Common.findw_cpp(corrssnaddr_sources, 'P' , '  ,', 'ie'));

corrssnaddr_src_p :=     __common__( corrssnaddr_src_p_pos > 0);

corrssnaddr_src_pl_pos :=     __common__( Models.Common.findw_cpp(corrssnaddr_sources, 'PL' , '  ,', 'ie'));

corrssnaddr_src_pl :=     __common__( corrssnaddr_src_pl_pos > 0);

corrssnaddr_src_tn_pos :=     __common__( Models.Common.findw_cpp(corrssnaddr_sources, 'TN' , '  ,', 'ie'));

corrssnaddr_src_tn :=     __common__( corrssnaddr_src_tn_pos > 0);

corrssnaddr_src_ts_pos :=     __common__( Models.Common.findw_cpp(corrssnaddr_sources, 'TS' , '  ,', 'ie'));

corrssnaddr_src_ts :=     __common__( corrssnaddr_src_ts_pos > 0);

corrssnaddr_src_tu_pos :=     __common__( Models.Common.findw_cpp(corrssnaddr_sources, 'TU' , '  ,', 'ie'));

corrssnaddr_src_tu :=     __common__( corrssnaddr_src_tu_pos > 0);

corrssnaddr_src_sl_pos :=     __common__( Models.Common.findw_cpp(corrssnaddr_sources, 'SL' , '  ,', 'ie'));

corrssnaddr_src_sl :=     __common__( corrssnaddr_src_sl_pos > 0);

corrssnaddr_src_v_pos :=     __common__( Models.Common.findw_cpp(corrssnaddr_sources, 'V' , '  ,', 'ie'));

corrssnaddr_src_v :=     __common__( corrssnaddr_src_v_pos > 0);

corrssnaddr_src_vo_pos :=     __common__( Models.Common.findw_cpp(corrssnaddr_sources, 'VO' , '  ,', 'ie'));

corrssnaddr_src_vo :=     __common__( corrssnaddr_src_vo_pos > 0);

corrssnaddr_src_w_pos :=     __common__( Models.Common.findw_cpp(corrssnaddr_sources, 'W' , '  ,', 'ie'));

corrssnaddr_src_w :=     __common__( corrssnaddr_src_w_pos > 0);

corrssnaddr_src_wp_pos :=     __common__( Models.Common.findw_cpp(corrssnaddr_sources, 'WP' , '  ,', 'ie'));

corrssnaddr_src_wp :=     __common__( corrssnaddr_src_wp_pos > 0);

corrssnaddr_ct :=     __common__( if(max((integer)corrssnaddr_src_ak, (integer)corrssnaddr_src_am, (integer)corrssnaddr_src_ar, (integer)corrssnaddr_src_ba, (integer)corrssnaddr_src_cg, (integer)corrssnaddr_src_co, (integer)corrssnaddr_src_cy, (integer)corrssnaddr_src_d, (integer)corrssnaddr_src_da, (integer)corrssnaddr_src_de, (integer)corrssnaddr_src_dl, (integer)corrssnaddr_src_ds, (integer)corrssnaddr_src_e1, (integer)corrssnaddr_src_e2, (integer)corrssnaddr_src_e3, (integer)corrssnaddr_src_e4, (integer)corrssnaddr_src_eb, (integer)corrssnaddr_src_em, (integer)corrssnaddr_src_en, (integer)corrssnaddr_src_eq, (integer)corrssnaddr_src_fe, (integer)corrssnaddr_src_ff, (integer)corrssnaddr_src_fr, (integer)corrssnaddr_src_l2, (integer)corrssnaddr_src_li, (integer)corrssnaddr_src_mw, (integer)corrssnaddr_src_nt, (integer)corrssnaddr_src_p, (integer)corrssnaddr_src_pl, (integer)corrssnaddr_src_sl, (integer)corrssnaddr_src_tn, (integer)corrssnaddr_src_ts, (integer)corrssnaddr_src_tu, (integer)corrssnaddr_src_v, (integer)corrssnaddr_src_vo, (integer)corrssnaddr_src_w, (integer)corrssnaddr_src_wp) = NULL, NULL, sum((integer)corrssnaddr_src_ak, (integer)corrssnaddr_src_am, (integer)corrssnaddr_src_ar, (integer)corrssnaddr_src_ba, (integer)corrssnaddr_src_cg, (integer)corrssnaddr_src_co, (integer)corrssnaddr_src_cy, (integer)corrssnaddr_src_d, (integer)corrssnaddr_src_da, (integer)corrssnaddr_src_de, (integer)corrssnaddr_src_dl, (integer)corrssnaddr_src_ds, (integer)corrssnaddr_src_e1, (integer)corrssnaddr_src_e2, (integer)corrssnaddr_src_e3, (integer)corrssnaddr_src_e4, (integer)corrssnaddr_src_eb, (integer)corrssnaddr_src_em, (integer)corrssnaddr_src_en, (integer)corrssnaddr_src_eq, (integer)corrssnaddr_src_fe, (integer)corrssnaddr_src_ff, (integer)corrssnaddr_src_fr, (integer)corrssnaddr_src_l2, (integer)corrssnaddr_src_li, (integer)corrssnaddr_src_mw, (integer)corrssnaddr_src_nt, (integer)corrssnaddr_src_p, (integer)corrssnaddr_src_pl, (integer)corrssnaddr_src_sl, (integer)corrssnaddr_src_tn, (integer)corrssnaddr_src_ts, (integer)corrssnaddr_src_tu, (integer)corrssnaddr_src_v, (integer)corrssnaddr_src_vo, (integer)corrssnaddr_src_w, (integer)corrssnaddr_src_wp)));

nf_corrssnaddr :=     __common__( map(
    not(truedid)                  => NULL,
   (integer) ssnlength != 9 or not(addrpop) => NULL,
                                     min(if(corrssnaddr_ct = NULL, -NULL, corrssnaddr_ct), 999)));

rv_d31_all_bk :=     __common__( map(
    not(truedid)                                                                                                                                                                                                                                                                                                   => '',
    contains_i(StringLib.StringToUpperCase(disposition), 'DISMISS') = 1 or if(max(bk_dismissed_recent_count, bk_dismissed_historical_count) = NULL, NULL, sum(if(bk_dismissed_recent_count = NULL, 0, bk_dismissed_recent_count), if(bk_dismissed_historical_count = NULL, 0, bk_dismissed_historical_count))) > 0 => '1 - BK DISMISSED',
    contains_i(StringLib.StringToUpperCase(disposition), 'DISCHARG') = 1 or if(max(bk_disposed_recent_count, bk_disposed_historical_count) = NULL, NULL, sum(if(bk_disposed_recent_count = NULL, 0, bk_disposed_recent_count), if(bk_disposed_historical_count = NULL, 0, bk_disposed_historical_count))) > 0      => '2 - BK DISCHARGED',
   (Integer) bankrupt = 1 or filing_count > 0                                                                                                                                                                                                                                                                      => '3 - BK OTHER',
                                                                                                                                                                                                                                                                                                                      '0 - NO BK'));

nf_util_add_curr_summary :=     __common__( map(
    not(truedid and (boolean)(integer)add_curr_pop) => '',
    util_curr_1 and util_curr_2 and util_curr_z     => 'ICM',
    util_curr_1 and util_curr_2                     => 'IC',
    util_curr_1 and util_curr_z                     => 'IM',
    util_curr_2 and util_curr_z                     => 'CM',
    util_curr_1                                     => 'I',
    util_curr_2                                     => 'C',
        util_curr_z                                 => 'M',
                                                   ''));

//rv_e58_br_dead_bus_x_active_phn :=     __common__( if(not(truedid), '', (string)min(if(br_dead_business_count = NULL, -NULL, br_dead_business_count), 3) || '-' || (string)min(if(br_active_phone_count = NULL, -NULL, br_active_phone_count), 3)));
rv_e58_br_dead_bus_x_active_phn :=     __common__(  if(not(truedid), '   ', trim((String)min(if(br_dead_business_count = NULL, -NULL, br_dead_business_count), 3), LEFT, RIGHT) + trim('-', LEFT, RIGHT) + trim((String)min(if(br_active_phone_count = NULL, -NULL, br_active_phone_count), 3), LEFT, RIGHT)));



iv_inf_contradictory :=     __common__( (infutor_nap in [1]));

//nf_inquiry_addr_vel_risk_index :=     __common__( if(not(addrpop), -1, if(max(2 ** 0 * (integer)(inq_adlsperaddr > 2), 2 ** 1 * (integer)(inq_lnamesperaddr > 2), 2 ** 2 * (integer)(inq_ssnsperaddr > 2)) = NULL, NULL, sum(if(2 ** 0 * (integer)(inq_adlsperaddr > 2) = NULL, 0, 2 ** 0 * (integer)(inq_adlsperaddr > 2)), if(2 ** 1 * (integer)(inq_lnamesperaddr > 2) = NULL, 0, 2 ** 1 * (integer)(inq_lnamesperaddr > 2)), if(2 ** 2 * (integer)(inq_ssnsperaddr > 2) = NULL, 0, 2 ** 2 * (integer)(inq_ssnsperaddr > 2))))));
nf_inquiry_addr_vel_risk_index :=     __common__( if(not(addrpop), -1, 
                                      if(max((integer)(inq_adlsperaddr > 2), 2 * (integer)(inq_lnamesperaddr > 2), 4 * (integer)(inq_ssnsperaddr > 2)) = NULL, NULL, 
																			   sum(if((integer)(inq_adlsperaddr > 2) = NULL, 0, (integer)(inq_adlsperaddr > 2)), 
																				     if(2 * (integer)(inq_lnamesperaddr > 2) = NULL, 0, 2 * (integer)(inq_lnamesperaddr > 2)), 
																						 if(4 * (integer)(inq_ssnsperaddr > 2) = NULL, 0, 4 * (integer)(inq_ssnsperaddr > 2))))));





nf_inquiry_addr_vel_risk_indexv2 :=     __common__( map(
    not(addrpop)                               => -1,
    nf_inquiry_addr_vel_risk_index = 0         => 0,
    nf_inquiry_addr_vel_risk_index = 1         => 1,
    (nf_inquiry_addr_vel_risk_index in [3, 5]) => 2,
    (nf_inquiry_addr_vel_risk_index in [2, 4]) => 3,
                                                  4));

most_recent_date_c1454_b5 :=     __common__( max(bs_ver_src_ldate_c, bs_ver_src_ldate_br));

nf_bus_ver_src_mos_reg_lseen :=     __common__( map(
    not(truedid)            => NULL,
    bus_ver_sources = ''     => -1,
    (bus_ver_sources in ['-1', '-2', '-3'])  => (integer)bus_ver_sources,
    contains_i(bus_ver_sources, 'C') = 0 and contains_i(bus_ver_sources, 'BR') = 0 => -1,
            most_recent_date_c1454_b5 = NULL  => NULL,
                                if ((sysdate8 - most_recent_date_c1454_b5) / 30.5 >= 0, 
                                roundup((sysdate8 - most_recent_date_c1454_b5) / 30.5), 
                                truncate((sysdate8 - most_recent_date_c1454_b5) / 30.5))));

corrssnname_src_ak_pos :=     __common__( Models.Common.findw_cpp(corrssnname_sources, 'AK' , '  ,', 'ie'));

corrssnname_src_ak :=     __common__( corrssnname_src_ak_pos > 0);

corrssnname_src_am_pos :=     __common__( Models.Common.findw_cpp(corrssnname_sources, 'AM' , '  ,', 'ie'));

corrssnname_src_am :=     __common__( corrssnname_src_am_pos > 0);

corrssnname_src_ar_pos :=     __common__( Models.Common.findw_cpp(corrssnname_sources, 'AR' , '  ,', 'ie'));

corrssnname_src_ar :=     __common__( corrssnname_src_ar_pos > 0);

corrssnname_src_ba_pos :=     __common__( Models.Common.findw_cpp(corrssnname_sources, 'BA' , '  ,', 'ie'));

corrssnname_src_ba :=     __common__( corrssnname_src_ba_pos > 0);

corrssnname_src_cg_pos :=     __common__( Models.Common.findw_cpp(corrssnname_sources, 'CG' , '  ,', 'ie'));

corrssnname_src_cg :=     __common__( corrssnname_src_cg_pos > 0);

corrssnname_src_co_pos :=     __common__( Models.Common.findw_cpp(corrssnname_sources, 'CO' , '  ,', 'ie'));

corrssnname_src_co :=     __common__( corrssnname_src_co_pos > 0);

corrssnname_src_cy_pos :=     __common__( Models.Common.findw_cpp(corrssnname_sources, 'CY' , '  ,', 'ie'));

corrssnname_src_cy :=     __common__( corrssnname_src_cy_pos > 0);

corrssnname_src_da_pos :=     __common__( Models.Common.findw_cpp(corrssnname_sources, 'DA' , '  ,', 'ie'));

corrssnname_src_da :=     __common__( corrssnname_src_da_pos > 0);

corrssnname_src_d_pos :=     __common__( Models.Common.findw_cpp(corrssnname_sources, 'D' , '  ,', 'ie'));

corrssnname_src_d :=     __common__( corrssnname_src_d_pos > 0);

corrssnname_src_dl_pos :=     __common__( Models.Common.findw_cpp(corrssnname_sources, 'DL' , '  ,', 'ie'));

corrssnname_src_dl :=     __common__( corrssnname_src_dl_pos > 0);

corrssnname_src_ds_pos :=     __common__( Models.Common.findw_cpp(corrssnname_sources, 'DS' , '  ,', 'ie'));

corrssnname_src_ds :=     __common__( corrssnname_src_ds_pos > 0);

corrssnname_src_de_pos :=     __common__( Models.Common.findw_cpp(corrssnname_sources, 'DE' , '  ,', 'ie'));

corrssnname_src_de :=     __common__( corrssnname_src_de_pos > 0);

corrssnname_src_eb_pos :=     __common__( Models.Common.findw_cpp(corrssnname_sources, 'EB' , '  ,', 'ie'));

corrssnname_src_eb :=     __common__( corrssnname_src_eb_pos > 0);

corrssnname_src_em_pos :=     __common__( Models.Common.findw_cpp(corrssnname_sources, 'EM' , '  ,', 'ie'));

corrssnname_src_em :=     __common__( corrssnname_src_em_pos > 0);

corrssnname_src_e1_pos :=     __common__( Models.Common.findw_cpp(corrssnname_sources, 'E1' , '  ,', 'ie'));

corrssnname_src_e1 :=     __common__( corrssnname_src_e1_pos > 0);

corrssnname_src_e2_pos :=     __common__( Models.Common.findw_cpp(corrssnname_sources, 'E2' , '  ,', 'ie'));

corrssnname_src_e2 :=     __common__( corrssnname_src_e2_pos > 0);

corrssnname_src_e3_pos :=     __common__( Models.Common.findw_cpp(corrssnname_sources, 'E3' , '  ,', 'ie'));

corrssnname_src_e3 :=     __common__( corrssnname_src_e3_pos > 0);

corrssnname_src_e4_pos :=     __common__( Models.Common.findw_cpp(corrssnname_sources, 'E4' , '  ,', 'ie'));

corrssnname_src_e4 :=     __common__( corrssnname_src_e4_pos > 0);

corrssnname_src_en_pos :=     __common__( Models.Common.findw_cpp(corrssnname_sources, 'EN' , '  ,', 'ie'));

corrssnname_src_en :=     __common__( corrssnname_src_en_pos > 0);

corrssnname_src_eq_pos :=     __common__( Models.Common.findw_cpp(corrssnname_sources, 'EQ' , '  ,', 'ie'));

corrssnname_src_eq :=     __common__( corrssnname_src_eq_pos > 0);

corrssnname_src_fe_pos :=     __common__( Models.Common.findw_cpp(corrssnname_sources, 'FE' , '  ,', 'ie'));

corrssnname_src_fe :=     __common__( corrssnname_src_fe_pos > 0);

corrssnname_src_ff_pos :=     __common__( Models.Common.findw_cpp(corrssnname_sources, 'FF' , '  ,', 'ie'));

corrssnname_src_ff :=     __common__( corrssnname_src_ff_pos > 0);

corrssnname_src_fr_pos :=     __common__( Models.Common.findw_cpp(corrssnname_sources, 'FR' , '  ,', 'ie'));

corrssnname_src_fr :=     __common__( corrssnname_src_fr_pos > 0);

corrssnname_src_l2_pos :=     __common__( Models.Common.findw_cpp(corrssnname_sources, 'L2' , '  ,', 'ie'));

corrssnname_src_l2 :=     __common__( corrssnname_src_l2_pos > 0);

corrssnname_src_li_pos :=     __common__( Models.Common.findw_cpp(corrssnname_sources, 'LI' , '  ,', 'ie'));

corrssnname_src_li :=     __common__( corrssnname_src_li_pos > 0);

corrssnname_src_mw_pos :=     __common__( Models.Common.findw_cpp(corrssnname_sources, 'MW' , '  ,', 'ie'));

corrssnname_src_mw :=     __common__( corrssnname_src_mw_pos > 0);

corrssnname_src_nt_pos :=     __common__( Models.Common.findw_cpp(corrssnname_sources, 'NT' , '  ,', 'ie'));

corrssnname_src_nt :=     __common__( corrssnname_src_nt_pos > 0);

corrssnname_src_p_pos :=     __common__( Models.Common.findw_cpp(corrssnname_sources, 'P' , '  ,', 'ie'));

corrssnname_src_p :=     __common__( corrssnname_src_p_pos > 0);

corrssnname_src_pl_pos :=     __common__( Models.Common.findw_cpp(corrssnname_sources, 'PL' , '  ,', 'ie'));

corrssnname_src_pl :=     __common__( corrssnname_src_pl_pos > 0);

corrssnname_src_tn_pos :=     __common__( Models.Common.findw_cpp(corrssnname_sources, 'TN' , '  ,', 'ie'));

corrssnname_src_tn :=     __common__( corrssnname_src_tn_pos > 0);

corrssnname_src_ts_pos :=     __common__( Models.Common.findw_cpp(corrssnname_sources, 'TS' , '  ,', 'ie'));

corrssnname_src_ts :=     __common__( corrssnname_src_ts_pos > 0);

corrssnname_src_tu_pos :=     __common__( Models.Common.findw_cpp(corrssnname_sources, 'TU' , '  ,', 'ie'));

corrssnname_src_tu :=     __common__( corrssnname_src_tu_pos > 0);

corrssnname_src_sl_pos :=     __common__( Models.Common.findw_cpp(corrssnname_sources, 'SL' , '  ,', 'ie'));

corrssnname_src_sl :=     __common__( corrssnname_src_sl_pos > 0);

corrssnname_src_v_pos :=     __common__( Models.Common.findw_cpp(corrssnname_sources, 'V' , '  ,', 'ie'));

corrssnname_src_v :=     __common__( corrssnname_src_v_pos > 0);

corrssnname_src_vo_pos :=     __common__( Models.Common.findw_cpp(corrssnname_sources, 'VO' , '  ,', 'ie'));

corrssnname_src_vo :=     __common__( corrssnname_src_vo_pos > 0);

corrssnname_src_w_pos :=     __common__( Models.Common.findw_cpp(corrssnname_sources, 'W' , '  ,', 'ie'));

corrssnname_src_w :=     __common__( corrssnname_src_w_pos > 0);

corrssnname_src_wp_pos :=     __common__( Models.Common.findw_cpp(corrssnname_sources, 'WP' , '  ,', 'ie'));

corrssnname_src_wp :=     __common__( corrssnname_src_wp_pos > 0);

corrssnname_ct :=     __common__( if(max((integer)corrssnname_src_ak, (integer)corrssnname_src_am, (integer)corrssnname_src_ar, (integer)corrssnname_src_ba, (integer)corrssnname_src_cg, (integer)corrssnname_src_co, (integer)corrssnname_src_cy, (integer)corrssnname_src_d, (integer)corrssnname_src_da, (integer)corrssnname_src_de, (integer)corrssnname_src_dl, (integer)corrssnname_src_ds, (integer)corrssnname_src_e1, (integer)corrssnname_src_e2, (integer)corrssnname_src_e3, (integer)corrssnname_src_e4, (integer)corrssnname_src_eb, (integer)corrssnname_src_em, (integer)corrssnname_src_en, (integer)corrssnname_src_eq, (integer)corrssnname_src_fe, (integer)corrssnname_src_ff, (integer)corrssnname_src_fr, (integer)corrssnname_src_l2, (integer)corrssnname_src_li, (integer)corrssnname_src_mw, (integer)corrssnname_src_nt, (integer)corrssnname_src_p, (integer)corrssnname_src_pl, (integer)corrssnname_src_sl, (integer)corrssnname_src_tn, (integer)corrssnname_src_ts, (integer)corrssnname_src_tu, (integer)corrssnname_src_v, (integer)corrssnname_src_vo, (integer)corrssnname_src_w, (integer)corrssnname_src_wp) = NULL, NULL, sum((integer)corrssnname_src_ak, (integer)corrssnname_src_am, (integer)corrssnname_src_ar, (integer)corrssnname_src_ba, (integer)corrssnname_src_cg, (integer)corrssnname_src_co, (integer)corrssnname_src_cy, (integer)corrssnname_src_d, (integer)corrssnname_src_da, (integer)corrssnname_src_de, (integer)corrssnname_src_dl, (integer)corrssnname_src_ds, (integer)corrssnname_src_e1, (integer)corrssnname_src_e2, (integer)corrssnname_src_e3, (integer)corrssnname_src_e4, (integer)corrssnname_src_eb, (integer)corrssnname_src_em, (integer)corrssnname_src_en, (integer)corrssnname_src_eq, (integer)corrssnname_src_fe, (integer)corrssnname_src_ff, (integer)corrssnname_src_fr, (integer)corrssnname_src_l2, (integer)corrssnname_src_li, (integer)corrssnname_src_mw, (integer)corrssnname_src_nt, (integer)corrssnname_src_p, (integer)corrssnname_src_pl, (integer)corrssnname_src_sl, (integer)corrssnname_src_tn, (integer)corrssnname_src_ts, (integer)corrssnname_src_tu, (integer)corrssnname_src_v, (integer)corrssnname_src_vo, (integer)corrssnname_src_w, (integer)corrssnname_src_wp)));

nf_corrssnname :=     __common__( map(
    not(truedid)                   => NULL,
    (integer)lnamepop = 0 or (integer)ssnlength != 9 => NULL,
                                      min(if(corrssnname_ct = NULL, -NULL, corrssnname_ct), 999)));

_liens_unrel_st_first_seen :=     __common__( common.sas_date((string)(liens_unrel_st_first_seen)));

nf_mos_liens_unrel_st_fseen :=     __common__( map(
    not(truedid)                      => NULL,
    _liens_unrel_st_first_seen = NULL => -1,
                                         min(if(if ((sysdate - _liens_unrel_st_first_seen) / (365.25 / 12) >= 0, truncate((sysdate - _liens_unrel_st_first_seen) / (365.25 / 12)), roundup((sysdate - _liens_unrel_st_first_seen) / (365.25 / 12))) = NULL, -NULL, if ((sysdate - _liens_unrel_st_first_seen) / (365.25 / 12) >= 0, truncate((sysdate - _liens_unrel_st_first_seen) / (365.25 / 12)), roundup((sysdate - _liens_unrel_st_first_seen) / (365.25 / 12)))), 999)));

nf_inq_corrnameaddr :=     __common__( map(
    not(truedid)                       => NULL,
    (inq_corrnameaddr in [-3, -2, -1]) => NULL,
                                          inq_corrnameaddr));

nf_phones_per_curraddr_c6 :=     __common__( if(not((boolean)(integer)add_curr_pop) or not(truedid), NULL, min(if(phones_per_curraddr_c6 = NULL, -NULL, phones_per_curraddr_c6), 999)));

nf_bus_seleids_peradl :=     __common__( if(not(truedid), NULL, bus_seleids_peradl));

nf_inq_perssn_count01 :=     __common__( if(not(ssnlength = '9'), NULL, min(if(inq_perssn_count01 = NULL, -NULL, inq_perssn_count01), 999)));

iv_addr_non_phn_src_ct :=     __common__( if(not(truedid and (boolean)(integer)add_input_pop), NULL, min(if(rc_addrcount = NULL, -NULL, rc_addrcount), 999)));

rv_c13_curr_addr_lres :=     __common__( if(not(truedid and (boolean)(integer)add_curr_pop), NULL, min(if(add_curr_lres = NULL, -NULL, add_curr_lres), 999)));

nf_addrs_per_bestssn :=     __common__( if(best_ssn_valid = '7' or not(truedid), NULL, min(if(addrs_per_bestssn = NULL, -NULL, addrs_per_bestssn), 999)));

nf_inq_collection_count24 :=     __common__( if(not(truedid), NULL, min(if(inq_Collection_count24 = NULL, -NULL, inq_Collection_count24), 999)));

nf_invbest_inq_adlsperaddr_diff :=     __common__( map(
    not(truedid) or (integer)addrpop = 0 => NULL,
    (integer)add_input_isbestmatch = 1   => -9999,
                                   inq_adlsperaddr - inq_adlspercurraddr));

rv_c18_invalid_addrs_per_adl :=     __common__( if(not(truedid), NULL, min(if(invalid_addrs_per_adl = NULL, -NULL, invalid_addrs_per_adl), 999)));

earliest_date_c1467_b5 :=     __common__( if(max(bs_ver_src_fdate_c, bs_ver_src_fdate_br) = NULL, NULL, min(if(bs_ver_src_fdate_c = NULL, -NULL, bs_ver_src_fdate_c), if(bs_ver_src_fdate_br = NULL, -NULL, bs_ver_src_fdate_br))));

nf_bus_ver_src_mos_reg_fseen :=     __common__( map(
    not(truedid)               => NULL,
    bus_ver_sources = ''        => -1,
    (bus_ver_sources in ['-1', '-2', '-3'])  => (integer)bus_ver_sources,
    contains_i(bus_ver_sources, 'C') = 0 
                and contains_i(bus_ver_sources, 'BR') = 0 => -1,
                earliest_date_c1467_b5 = NULL  => NULL,
                 if ((sysdate8 - earliest_date_c1467_b5) / 30.5 >= 0, 
                 roundup((sysdate8 - earliest_date_c1467_b5) / 30.5), 
                 truncate((sysdate8 - earliest_date_c1467_b5) / 30.5))));
                 
// nf_bus_ver_src_mos_reg_fseen :=     __common__( map(
    // not(truedid)                   => NULL,
    // bus_ver_sources = ''           => -1,
    // (bus_ver_sources in ['-1', '-2', '-3'])    => (integer)bus_ver_sources,
    // contains_i(bus_ver_sources, 'C') = 0 
              // and contains_i(bus_ver_sources, 'BR') = 0 => -1,
     // earliest_date_c2599_b5 = NULL  => NULL,
      // if ((sysdate - earliest_date_c2599_b5) / 30.5 >= 0, 
      // roundup((sysdate - earliest_date_c2599_b5) / 30.5), 
      // truncate((sysdate - earliest_date_c2599_b5) / 30.5))));
                 

most_recent_date_c1468_b4 :=     __common__( max(bs_ssn_ver_src_ldate_ar, bs_ssn_ver_src_ldate_ba, bs_ssn_ver_src_ldate_bc, bs_ssn_ver_src_ldate_bm, bs_ssn_ver_src_ldate_bn, bs_ssn_ver_src_ldate_br, bs_ssn_ver_src_ldate_by, bs_ssn_ver_src_ldate_c, bs_ssn_ver_src_ldate_cf, bs_ssn_ver_src_ldate_cs, bs_ssn_ver_src_ldate_cu, bs_ssn_ver_src_ldate_d, bs_ssn_ver_src_ldate_da, bs_ssn_ver_src_ldate_df, bs_ssn_ver_src_ldate_dn, bs_ssn_ver_src_ldate_e, bs_ssn_ver_src_ldate_ef, bs_ssn_ver_src_ldate_er, bs_ssn_ver_src_ldate_ey, bs_ssn_ver_src_ldate_f, bs_ssn_ver_src_ldate_fb, bs_ssn_ver_src_ldate_fi, bs_ssn_ver_src_ldate_fk, bs_ssn_ver_src_ldate_fr, bs_ssn_ver_src_ldate_ft, bs_ssn_ver_src_ldate_gb, bs_ssn_ver_src_ldate_gr, bs_ssn_ver_src_ldate_h7, bs_ssn_ver_src_ldate_i, bs_ssn_ver_src_ldate_ia, bs_ssn_ver_src_ldate_ic, bs_ssn_ver_src_ldate_in, bs_ssn_ver_src_ldate_ip, bs_ssn_ver_src_ldate_is, bs_ssn_ver_src_ldate_it, bs_ssn_ver_src_ldate_j2, bs_ssn_ver_src_ldate_kc, bs_ssn_ver_src_ldate_l0, bs_ssn_ver_src_ldate_l2, bs_ssn_ver_src_ldate_mh, bs_ssn_ver_src_ldate_mw, bs_ssn_ver_src_ldate_np, bs_ssn_ver_src_ldate_nr, bs_ssn_ver_src_ldate_os, bs_ssn_ver_src_ldate_p, bs_ssn_ver_src_ldate_pl, bs_ssn_ver_src_ldate_pp, bs_ssn_ver_src_ldate_q3, bs_ssn_ver_src_ldate_rr, bs_ssn_ver_src_ldate_sa, bs_ssn_ver_src_ldate_sb, bs_ssn_ver_src_ldate_sg, bs_ssn_ver_src_ldate_sj, bs_ssn_ver_src_ldate_sk, bs_ssn_ver_src_ldate_sp, bs_ssn_ver_src_ldate_tx, bs_ssn_ver_src_ldate_u2, bs_ssn_ver_src_ldate_ut, bs_ssn_ver_src_ldate_v, bs_ssn_ver_src_ldate_v2, bs_ssn_ver_src_ldate_wa, bs_ssn_ver_src_ldate_wb, bs_ssn_ver_src_ldate_wc, bs_ssn_ver_src_ldate_wk, bs_ssn_ver_src_ldate_wx, bs_ssn_ver_src_ldate_y, bs_ssn_ver_src_ldate_zo));

nf_bus_ssn_ver_src_mos_lseen_1 :=     __common__( map(
    not(truedid)                                      => NULL,
    bus_ssn_ver_sources_lseen = ''                  => -1,
    (bus_ssn_ver_sources_lseen in ['-1', '-2', '-3']) => (integer)bus_ssn_ver_sources_lseen,
                                                         if ((sysdate8 - most_recent_date_c1468_b4) / 30.5 >= 0, 
                                                         roundup((sysdate8 - most_recent_date_c1468_b4) / 30.5), 
                                                         truncate((sysdate8 - most_recent_date_c1468_b4) / 30.5))));
                                                         
nf_bus_ssn_ver_src_mos_lseen:=  __common__(If(nf_bus_ssn_ver_src_mos_lseen_1 > 1000000, NULL, nf_bus_ssn_ver_src_mos_lseen_1));                                                     
                                                         

nf_acc_damage_amt_total :=     __common__( if(not(truedid), NULL, acc_damage_amt_total));

nf_invbest_inq_lastperaddr_diff :=     __common__( map(
    not(truedid) or (integer)addrpop = 0 => NULL,
    (integer)add_input_isbestmatch = 1   => -9999,
                                   inq_lnamesperaddr - inq_lnamespercurraddr));

nf_fp_prevaddrlenofres :=     __common__( if(not(truedid), NULL, min(if(fp_prevaddrlenofres = '', -NULL, (INTEGER)fp_prevaddrlenofres), 999)));

rv_i61_inq_collection_recency :=     __common__( map(
    not(truedid)           => NULL,
    (Boolean)inq_collection_count01 => 1,
    (Boolean)inq_collection_count03 => 3,
    (Boolean)inq_collection_count06 => 6,
    (Boolean)inq_collection_count12 => 12,
    (Boolean)inq_collection_count24 => 24,
    (Boolean)inq_collection_count   => 99,
                              0));

no_addr_ver :=     __common__( (nap_summary in [0, 1, 4, 7, 9]) or (nas_summary in [0, 1, 4, 7, 9]));

nf_dist_inp_curr_no_ver :=     __common__( map(
    not((boolean)(integer)add_curr_pop and (boolean)(integer)add_input_pop) => NULL,
    not(no_addr_ver) or (boolean)(integer)add_input_isbestmatch             => -1,
                                                                               min(9999, if(add_dist_input_to_curr = NULL, -NULL, add_dist_input_to_curr))));

//nf_inq_addr_recency_risk_index :=     __common__( if(not(addrpop), -1, if(max(2 ** 0 * (integer)(inq_adlsperaddr_count01 > 1), 2 ** 1 * (integer)(inq_lnamesperaddr_count01 > 1), 2 ** 2 * (integer)(inq_ssnsperaddr_count01 > 1)) = NULL, NULL, sum(if(2 ** 0 * (integer)(inq_adlsperaddr_count01 > 1) = NULL, 0, 2 ** 0 * (integer)(inq_adlsperaddr_count01 > 1)), if(2 ** 1 * (integer)(inq_lnamesperaddr_count01 > 1) = NULL, 0, 2 ** 1 * (integer)(inq_lnamesperaddr_count01 > 1)), if(2 ** 2 * (integer)(inq_ssnsperaddr_count01 > 1) = NULL, 0, 2 ** 2 * (integer)(inq_ssnsperaddr_count01 > 1))))));
nf_inq_addr_recency_risk_index :=     __common__(   if(not(addrpop), -1, if(max((integer)(inq_adlsperaddr_count01 > 1), 
                              2*(integer)(inq_lnamesperaddr_count01 > 1), 
                              4*(integer)(inq_ssnsperaddr_count01 > 1)) = NULL, NULL, 
                              sum(if( (integer)(inq_adlsperaddr_count01 > 1) = NULL, 0,  (integer)(inq_adlsperaddr_count01 > 1)), 
                              if(2*(integer)(inq_lnamesperaddr_count01 > 1) = NULL, 0, 2*(integer)(inq_lnamesperaddr_count01 > 1)), 
                                if(4* (integer)(inq_ssnsperaddr_count01 > 1) = NULL, 0, 4*(integer)(inq_ssnsperaddr_count01 > 1))))));

nf_phones_per_addr_curr :=     __common__( if(not(addrpop), NULL, min(if(phones_per_addr_curr = NULL, -NULL, phones_per_addr_curr), 999)));

nf_inq_percurraddr_count12 :=     __common__( if(not(truedid), NULL, min(if(inq_percurraddr = NULL, -NULL, inq_percurraddr), 999)));

nf_util_add_input_summary :=     __common__( map(
    not(addrpop)                             => '',
    util_inp_1 and util_inp_2 and util_inp_z => 'ICM',
    util_inp_1 and util_inp_2                => 'IC',
    util_inp_1 and util_inp_z                => 'IM',
    util_inp_2 and util_inp_z                => 'CM',
    util_inp_1                               => 'I',
    util_inp_2                               => 'C',
        util_inp_z                               => 'M',
                                                ''));

iv_inf_lname_verd :=     __common__( (infutor_nap in [2, 5, 7, 8, 9, 11, 12]));

nf_inq_auto_count24 :=     __common__( if(not(truedid), NULL, min(if(inq_Auto_count24 = NULL, -NULL, inq_Auto_count24), 999)));

nf_inq_fname_ver_count :=     __common__( if(not(truedid) or inq_fname_ver_count = 255, NULL, inq_fname_ver_count));

rv_i60_inq_peradl_count12 :=     __common__( if(not(truedid), NULL, min(if(Inq_PerADL = NULL, -NULL, Inq_PerADL), 999)));

nf_inq_adls_per_addr :=     __common__( if(not(addrpop), NULL, min(if(inq_adlsperaddr = NULL, -NULL, inq_adlsperaddr), 999)));

nf_inq_lnames_per_apt_addr :=     __common__( map(
    not(addrpop)                      => NULL,
    not((boolean)(integer)iv_add_apt) => -1,
                                         min(if(inq_lnamesperaddr = NULL, -NULL, inq_lnamesperaddr), 999)));

rv_c14_unverified_addr_count :=     __common__( if(not(truedid), NULL, min(if(unverified_addr_count = NULL, -NULL, unverified_addr_count), 999)));

nf_inq_corrdobaddr :=     __common__( map(
    not(truedid)                      => NULL,
    (inq_corrdobaddr in [-3, -2, -1]) => NULL,
                                         inq_corrdobaddr));

rv_c13_max_lres :=     __common__( if(not(truedid), NULL, min(if(max_lres = NULL, -NULL, max_lres), 999)));

rv_c23_email_domain_free_cnt :=     __common__( if(not(truedid), NULL, min(if(email_domain_free_count = NULL, -NULL, email_domain_free_count), 999)));

rv_d33_attr_eviction_ct84 :=     __common__( if(not(truedid), NULL, attr_eviction_count84));

iv_inq_auto_count01 :=     __common__( if(not(truedid), NULL, min(if(inq_auto_count01 = NULL, -NULL, inq_auto_count01), 999)));

nf_inq_per_apt_addr :=     __common__( map(
    not(addrpop)                      => NULL,
    not((boolean)(integer)iv_add_apt) => -1,
                                         min(if(inq_peraddr = NULL, -NULL, inq_peraddr), 999)));

rv_i60_inq_retail_recency :=     __common__( map(
    not(truedid)       => NULL,
    (boolean)inq_retail_count01 => 1,
    (boolean)inq_retail_count03 => 3,
    (boolean)inq_retail_count06 => 6,
   (boolean) inq_retail_count12 => 12,
    (boolean)inq_retail_count24 => 24,
    (boolean)inq_retail_count   => 99,
                          0));

nf_inq_adlsperaddr_recency :=     __common__( map(
    not(truedid)            => NULL,
   (boolean) inq_adlsperaddr_count01 => 1,
    (boolean)inq_adlsperaddr_count03 => 3,
    (boolean)inq_adlsperaddr_count06 => 6,
   (boolean) Inq_ADLsPerAddr         => 12,
                               0));

rv_f04_curr_add_occ_index :=     __common__( if(not(truedid and (boolean)(integer)add_curr_pop), NULL, add_curr_occ_index));

rv_c20_m_bureau_adl_fs :=     __common__( map(
    not(truedid)            => NULL,
    ver_src_fdate_eq = NULL => -1,
                               min(if(if ((sysdate - ver_src_fdate_eq) / (365.25 / 12) >= 0, truncate((sysdate - ver_src_fdate_eq) / (365.25 / 12)), roundup((sysdate - ver_src_fdate_eq) / (365.25 / 12))) = NULL, -NULL, if ((sysdate - ver_src_fdate_eq) / (365.25 / 12) >= 0, truncate((sysdate - ver_src_fdate_eq) / (365.25 / 12)), roundup((sysdate - ver_src_fdate_eq) / (365.25 / 12)))), 999)));

nf_inq_ssn_ver_count :=     __common__( if(not(truedid) or inq_ssn_ver_count = 255, NULL, inq_ssn_ver_count));

nf_fpc_source_dl :=     __common__( if(not(truedid), '', fpc_Source_DL));

earliest_bureau_date_all :=     __common__( if(ver_src_fdate_tn = NULL and ver_src_fdate_en = NULL and ver_src_fdate_eq = NULL, NULL, if(max(ver_src_fdate_tn, ver_src_fdate_en, ver_src_fdate_eq) = NULL, NULL, min(if(ver_src_fdate_tn = NULL, -NULL, ver_src_fdate_tn), if(ver_src_fdate_en = NULL, -NULL, ver_src_fdate_en), if(ver_src_fdate_eq = NULL, -NULL, ver_src_fdate_eq)))));

nf_m_bureau_adl_fs_all :=     __common__( map(
    not(truedid)                    => NULL,
    earliest_bureau_date_all = NULL => -1,
                                       min(if(if ((sysdate - earliest_bureau_date_all) / (365.25 / 12) >= 0, truncate((sysdate - earliest_bureau_date_all) / (365.25 / 12)), roundup((sysdate - earliest_bureau_date_all) / (365.25 / 12))) = NULL, -NULL, if ((sysdate - earliest_bureau_date_all) / (365.25 / 12) >= 0, truncate((sysdate - earliest_bureau_date_all) / (365.25 / 12)), roundup((sysdate - earliest_bureau_date_all) / (365.25 / 12)))), 999)));

corraddrname_src_ak_pos :=     __common__( Models.Common.findw_cpp(corraddrname_sources, 'AK' , '  ,', 'ie'));

corraddrname_src_ak :=     __common__( corraddrname_src_ak_pos > 0);

corraddrname_src_am_pos :=     __common__( Models.Common.findw_cpp(corraddrname_sources, 'AM' , '  ,', 'ie'));

corraddrname_src_am :=     __common__( corraddrname_src_am_pos > 0);

corraddrname_src_ar_pos :=     __common__( Models.Common.findw_cpp(corraddrname_sources, 'AR' , '  ,', 'ie'));

corraddrname_src_ar :=     __common__( corraddrname_src_ar_pos > 0);

corraddrname_src_ba_pos :=     __common__( Models.Common.findw_cpp(corraddrname_sources, 'BA' , '  ,', 'ie'));

corraddrname_src_ba :=     __common__( corraddrname_src_ba_pos > 0);

corraddrname_src_cg_pos :=     __common__( Models.Common.findw_cpp(corraddrname_sources, 'CG' , '  ,', 'ie'));

corraddrname_src_cg :=     __common__( corraddrname_src_cg_pos > 0);

corraddrname_src_co_pos :=     __common__( Models.Common.findw_cpp(corraddrname_sources, 'CO' , '  ,', 'ie'));

corraddrname_src_co :=     __common__( corraddrname_src_co_pos > 0);

corraddrname_src_cy_pos :=     __common__( Models.Common.findw_cpp(corraddrname_sources, 'CY' , '  ,', 'ie'));

corraddrname_src_cy :=     __common__( corraddrname_src_cy_pos > 0);

corraddrname_src_da_pos :=     __common__( Models.Common.findw_cpp(corraddrname_sources, 'DA' , '  ,', 'ie'));

corraddrname_src_da :=     __common__( corraddrname_src_da_pos > 0);

corraddrname_src_d_pos :=     __common__( Models.Common.findw_cpp(corraddrname_sources, 'D' , '  ,', 'ie'));

corraddrname_src_d :=     __common__( corraddrname_src_d_pos > 0);

corraddrname_src_dl_pos :=     __common__( Models.Common.findw_cpp(corraddrname_sources, 'DL' , '  ,', 'ie'));

corraddrname_src_dl :=     __common__( corraddrname_src_dl_pos > 0);

corraddrname_src_ds_pos :=     __common__( Models.Common.findw_cpp(corraddrname_sources, 'DS' , '  ,', 'ie'));

corraddrname_src_ds :=     __common__( corraddrname_src_ds_pos > 0);

corraddrname_src_de_pos :=     __common__( Models.Common.findw_cpp(corraddrname_sources, 'DE' , '  ,', 'ie'));

corraddrname_src_de :=     __common__( corraddrname_src_de_pos > 0);

corraddrname_src_eb_pos :=     __common__( Models.Common.findw_cpp(corraddrname_sources, 'EB' , '  ,', 'ie'));

corraddrname_src_eb :=     __common__( corraddrname_src_eb_pos > 0);

corraddrname_src_em_pos :=     __common__( Models.Common.findw_cpp(corraddrname_sources, 'EM' , '  ,', 'ie'));

corraddrname_src_em :=     __common__( corraddrname_src_em_pos > 0);

corraddrname_src_e1_pos :=     __common__( Models.Common.findw_cpp(corraddrname_sources, 'E1' , '  ,', 'ie'));

corraddrname_src_e1 :=     __common__( corraddrname_src_e1_pos > 0);

corraddrname_src_e2_pos :=     __common__( Models.Common.findw_cpp(corraddrname_sources, 'E2' , '  ,', 'ie'));

corraddrname_src_e2 :=     __common__( corraddrname_src_e2_pos > 0);

corraddrname_src_e3_pos :=     __common__( Models.Common.findw_cpp(corraddrname_sources, 'E3' , '  ,', 'ie'));

corraddrname_src_e3 :=     __common__( corraddrname_src_e3_pos > 0);

corraddrname_src_e4_pos :=     __common__( Models.Common.findw_cpp(corraddrname_sources, 'E4' , '  ,', 'ie'));

corraddrname_src_e4 :=     __common__( corraddrname_src_e4_pos > 0);

corraddrname_src_en_pos :=     __common__( Models.Common.findw_cpp(corraddrname_sources, 'EN' , '  ,', 'ie'));

corraddrname_src_en :=     __common__( corraddrname_src_en_pos > 0);

corraddrname_src_eq_pos :=     __common__( Models.Common.findw_cpp(corraddrname_sources, 'EQ' , '  ,', 'ie'));

corraddrname_src_eq :=     __common__( corraddrname_src_eq_pos > 0);

corraddrname_src_fe_pos :=     __common__( Models.Common.findw_cpp(corraddrname_sources, 'FE' , '  ,', 'ie'));

corraddrname_src_fe :=     __common__( corraddrname_src_fe_pos > 0);

corraddrname_src_ff_pos :=     __common__( Models.Common.findw_cpp(corraddrname_sources, 'FF' , '  ,', 'ie'));

corraddrname_src_ff :=     __common__( corraddrname_src_ff_pos > 0);

corraddrname_src_fr_pos :=     __common__( Models.Common.findw_cpp(corraddrname_sources, 'FR' , '  ,', 'ie'));

corraddrname_src_fr :=     __common__( corraddrname_src_fr_pos > 0);

corraddrname_src_l2_pos :=     __common__( Models.Common.findw_cpp(corraddrname_sources, 'L2' , '  ,', 'ie'));

corraddrname_src_l2 :=     __common__( corraddrname_src_l2_pos > 0);

corraddrname_src_li_pos :=     __common__( Models.Common.findw_cpp(corraddrname_sources, 'LI' , '  ,', 'ie'));

corraddrname_src_li :=     __common__( corraddrname_src_li_pos > 0);

corraddrname_src_mw_pos :=     __common__( Models.Common.findw_cpp(corraddrname_sources, 'MW' , '  ,', 'ie'));

corraddrname_src_mw :=     __common__( corraddrname_src_mw_pos > 0);

corraddrname_src_nt_pos :=     __common__( Models.Common.findw_cpp(corraddrname_sources, 'NT' , '  ,', 'ie'));

corraddrname_src_nt :=     __common__( corraddrname_src_nt_pos > 0);

corraddrname_src_p_pos :=     __common__( Models.Common.findw_cpp(corraddrname_sources, 'P' , '  ,', 'ie'));

corraddrname_src_p :=     __common__( corraddrname_src_p_pos > 0);

corraddrname_src_pl_pos :=     __common__( Models.Common.findw_cpp(corraddrname_sources, 'PL' , '  ,', 'ie'));

corraddrname_src_pl :=     __common__( corraddrname_src_pl_pos > 0);

corraddrname_src_tn_pos :=     __common__( Models.Common.findw_cpp(corraddrname_sources, 'TN' , '  ,', 'ie'));

corraddrname_src_tn :=     __common__( corraddrname_src_tn_pos > 0);

corraddrname_src_ts_pos :=     __common__( Models.Common.findw_cpp(corraddrname_sources, 'TS' , '  ,', 'ie'));

corraddrname_src_ts :=     __common__( corraddrname_src_ts_pos > 0);

corraddrname_src_tu_pos :=     __common__( Models.Common.findw_cpp(corraddrname_sources, 'TU' , '  ,', 'ie'));

corraddrname_src_tu :=     __common__( corraddrname_src_tu_pos > 0);

corraddrname_src_sl_pos :=     __common__( Models.Common.findw_cpp(corraddrname_sources, 'SL' , '  ,', 'ie'));

corraddrname_src_sl :=     __common__( corraddrname_src_sl_pos > 0);

corraddrname_src_v_pos :=     __common__( Models.Common.findw_cpp(corraddrname_sources, 'V' , '  ,', 'ie'));

corraddrname_src_v :=     __common__( corraddrname_src_v_pos > 0);

corraddrname_src_vo_pos :=     __common__( Models.Common.findw_cpp(corraddrname_sources, 'VO' , '  ,', 'ie'));

corraddrname_src_vo :=     __common__( corraddrname_src_vo_pos > 0);

corraddrname_src_w_pos :=     __common__( Models.Common.findw_cpp(corraddrname_sources, 'W' , '  ,', 'ie'));

corraddrname_src_w :=     __common__( corraddrname_src_w_pos > 0);

corraddrname_src_wp_pos :=     __common__( Models.Common.findw_cpp(corraddrname_sources, 'WP' , '  ,', 'ie'));

corraddrname_src_wp :=     __common__( corraddrname_src_wp_pos > 0);

corraddrname_ct :=     __common__( if(max((integer)corraddrname_src_ak, (integer)corraddrname_src_am, (integer)corraddrname_src_ar, (integer)corraddrname_src_ba, (integer)corraddrname_src_cg, (integer)corraddrname_src_co, (integer)corraddrname_src_cy, (integer)corraddrname_src_d, (integer)corraddrname_src_da, (integer)corraddrname_src_de, (integer)corraddrname_src_dl, (integer)corraddrname_src_ds, (integer)corraddrname_src_e1, (integer)corraddrname_src_e2, (integer)corraddrname_src_e3, (integer)corraddrname_src_e4, (integer)corraddrname_src_eb, (integer)corraddrname_src_em, (integer)corraddrname_src_en, (integer)corraddrname_src_eq, (integer)corraddrname_src_fe, (integer)corraddrname_src_ff, (integer)corraddrname_src_fr, (integer)corraddrname_src_l2, (integer)corraddrname_src_li, (integer)corraddrname_src_mw, (integer)corraddrname_src_nt, (integer)corraddrname_src_p, (integer)corraddrname_src_pl, (integer)corraddrname_src_sl, (integer)corraddrname_src_tn, (integer)corraddrname_src_ts, (integer)corraddrname_src_tu, (integer)corraddrname_src_v, (integer)corraddrname_src_vo, (integer)corraddrname_src_w, (integer)corraddrname_src_wp) = NULL, NULL, sum((integer)corraddrname_src_ak, (integer)corraddrname_src_am, (integer)corraddrname_src_ar, (integer)corraddrname_src_ba, (integer)corraddrname_src_cg, (integer)corraddrname_src_co, (integer)corraddrname_src_cy, (integer)corraddrname_src_d, (integer)corraddrname_src_da, (integer)corraddrname_src_de, (integer)corraddrname_src_dl, (integer)corraddrname_src_ds, (integer)corraddrname_src_e1, (integer)corraddrname_src_e2, (integer)corraddrname_src_e3, (integer)corraddrname_src_e4, (integer)corraddrname_src_eb, (integer)corraddrname_src_em, (integer)corraddrname_src_en, (integer)corraddrname_src_eq, (integer)corraddrname_src_fe, (integer)corraddrname_src_ff, (integer)corraddrname_src_fr, (integer)corraddrname_src_l2, (integer)corraddrname_src_li, (integer)corraddrname_src_mw, (integer)corraddrname_src_nt, (integer)corraddrname_src_p, (integer)corraddrname_src_pl, (integer)corraddrname_src_sl, (integer)corraddrname_src_tn, (integer)corraddrname_src_ts, (integer)corraddrname_src_tu, (integer)corraddrname_src_v, (integer)corraddrname_src_vo, (integer)corraddrname_src_w, (integer)corraddrname_src_wp)));

nf_corraddrname :=     __common__( map(
    not(truedid)                => NULL,
    (integer)lnamepop = 0 or (integer)addrpop = 0 => NULL,
                                   min(if(corraddrname_ct = NULL, -NULL, corraddrname_ct), 999)));

br_first_seen_char :=     __common__( br_first_seen);

_br_first_seen :=     __common__( common.sas_date((string)(br_first_seen_char)));

rv_mos_since_br_first_seen :=     __common__( map(
    not(truedid)          => NULL,
    _br_first_seen = NULL => -1,
                             min(if(if ((sysdate - _br_first_seen) / (365.25 / 12) >= 0, truncate((sysdate - _br_first_seen) / (365.25 / 12)), roundup((sysdate - _br_first_seen) / (365.25 / 12))) = NULL, -NULL, if ((sysdate - _br_first_seen) / (365.25 / 12) >= 0, truncate((sysdate - _br_first_seen) / (365.25 / 12)), roundup((sysdate - _br_first_seen) / (365.25 / 12)))), 999)));

nf_liens_unrel_cj_total_amt :=     __common__( if(not(truedid), NULL, liens_unrel_CJ_total_amount));

rv_i62_inq_dobsperadl_recency :=     __common__( map(
    not(truedid)           => NULL,
    (boolean)inq_dobsperadl_count01 => 1,
    (boolean)inq_dobsperadl_count03 => 3,
    (boolean)inq_dobsperadl_count06 => 6,
    (boolean)Inq_DOBsPerADL         => 12,
                              0));

rv_d31_bk_filing_count :=     __common__( if(not(truedid), NULL, min(if(filing_count = NULL, -NULL, filing_count), 999)));

nf_ssns_per_curraddr_curr :=     __common__( if(not((boolean)(integer)add_curr_pop) or not(truedid), NULL, min(if(ssns_per_curraddr_curr = NULL, -NULL, ssns_per_curraddr_curr), 999)));

nf_inq_count24 :=     __common__( if(not(truedid), NULL, min(if(inq_count24 = NULL, -NULL, inq_count24), 999)));

rv_f00_inq_corraddrphone_adl :=     __common__( map(
    not(truedid)                            => NULL,
    (inq_corraddrphone_adl in [-3, -2, -1]) => NULL,
                                               inq_corraddrphone_adl));

nf_inq_adlsperssn_recency :=     __common__( map(
    not(truedid)           => NULL,
    (boolean)inq_adlsperssn_count01 => 1,
    (boolean)inq_adlsperssn_count03 => 3,
    (boolean)inq_adlsperssn_count06 => 6,
    (boolean)Inq_ADLsPerSSN         => 12,
                              0));

nf_fp_srchphonesrchcountmo :=     __common__( if(not(truedid), NULL, min(if(fp_srchphonesrchcountmo = '', -NULL, (integer)fp_srchphonesrchcountmo), 999)));

iv_c14_addrs_per_adl :=     __common__( if(not(truedid), NULL, min(if(addrs_per_adl = NULL, -NULL, addrs_per_adl), 999)));

corraddrphone_src_ak_pos :=     __common__( Models.Common.findw_cpp(corraddrphone_sources, 'AK' , '  ,', 'ie'));

corraddrphone_src_ak :=     __common__( corraddrphone_src_ak_pos > 0);

corraddrphone_src_am_pos :=     __common__( Models.Common.findw_cpp(corraddrphone_sources, 'AM' , '  ,', 'ie'));

corraddrphone_src_am :=     __common__( corraddrphone_src_am_pos > 0);

corraddrphone_src_ar_pos :=     __common__( Models.Common.findw_cpp(corraddrphone_sources, 'AR' , '  ,', 'ie'));

corraddrphone_src_ar :=     __common__( corraddrphone_src_ar_pos > 0);

corraddrphone_src_ba_pos :=     __common__( Models.Common.findw_cpp(corraddrphone_sources, 'BA' , '  ,', 'ie'));

corraddrphone_src_ba :=     __common__( corraddrphone_src_ba_pos > 0);

corraddrphone_src_cg_pos :=     __common__( Models.Common.findw_cpp(corraddrphone_sources, 'CG' , '  ,', 'ie'));

corraddrphone_src_cg :=     __common__( corraddrphone_src_cg_pos > 0);

corraddrphone_src_co_pos :=     __common__( Models.Common.findw_cpp(corraddrphone_sources, 'CO' , '  ,', 'ie'));

corraddrphone_src_co :=     __common__( corraddrphone_src_co_pos > 0);

corraddrphone_src_cy_pos :=     __common__( Models.Common.findw_cpp(corraddrphone_sources, 'CY' , '  ,', 'ie'));

corraddrphone_src_cy :=     __common__( corraddrphone_src_cy_pos > 0);

corraddrphone_src_da_pos :=     __common__( Models.Common.findw_cpp(corraddrphone_sources, 'DA' , '  ,', 'ie'));

corraddrphone_src_da :=     __common__( corraddrphone_src_da_pos > 0);

corraddrphone_src_d_pos :=     __common__( Models.Common.findw_cpp(corraddrphone_sources, 'D' , '  ,', 'ie'));

corraddrphone_src_d :=     __common__( corraddrphone_src_d_pos > 0);

corraddrphone_src_dl_pos :=     __common__( Models.Common.findw_cpp(corraddrphone_sources, 'DL' , '  ,', 'ie'));

corraddrphone_src_dl :=     __common__( corraddrphone_src_dl_pos > 0);

corraddrphone_src_ds_pos :=     __common__( Models.Common.findw_cpp(corraddrphone_sources, 'DS' , '  ,', 'ie'));

corraddrphone_src_ds :=     __common__( corraddrphone_src_ds_pos > 0);

corraddrphone_src_de_pos :=     __common__( Models.Common.findw_cpp(corraddrphone_sources, 'DE' , '  ,', 'ie'));

corraddrphone_src_de :=     __common__( corraddrphone_src_de_pos > 0);

corraddrphone_src_eb_pos :=     __common__( Models.Common.findw_cpp(corraddrphone_sources, 'EB' , '  ,', 'ie'));

corraddrphone_src_eb :=     __common__( corraddrphone_src_eb_pos > 0);

corraddrphone_src_em_pos :=     __common__( Models.Common.findw_cpp(corraddrphone_sources, 'EM' , '  ,', 'ie'));

corraddrphone_src_em :=     __common__( corraddrphone_src_em_pos > 0);

corraddrphone_src_e1_pos :=     __common__( Models.Common.findw_cpp(corraddrphone_sources, 'E1' , '  ,', 'ie'));

corraddrphone_src_e1 :=     __common__( corraddrphone_src_e1_pos > 0);

corraddrphone_src_e2_pos :=     __common__( Models.Common.findw_cpp(corraddrphone_sources, 'E2' , '  ,', 'ie'));

corraddrphone_src_e2 :=     __common__( corraddrphone_src_e2_pos > 0);

corraddrphone_src_e3_pos :=     __common__( Models.Common.findw_cpp(corraddrphone_sources, 'E3' , '  ,', 'ie'));

corraddrphone_src_e3 :=     __common__( corraddrphone_src_e3_pos > 0);

corraddrphone_src_e4_pos :=     __common__( Models.Common.findw_cpp(corraddrphone_sources, 'E4' , '  ,', 'ie'));

corraddrphone_src_e4 :=     __common__( corraddrphone_src_e4_pos > 0);

corraddrphone_src_en_pos :=     __common__( Models.Common.findw_cpp(corraddrphone_sources, 'EN' , '  ,', 'ie'));

corraddrphone_src_en :=     __common__( corraddrphone_src_en_pos > 0);

corraddrphone_src_eq_pos :=     __common__( Models.Common.findw_cpp(corraddrphone_sources, 'EQ' , '  ,', 'ie'));

corraddrphone_src_eq :=     __common__( corraddrphone_src_eq_pos > 0);

corraddrphone_src_fe_pos :=     __common__( Models.Common.findw_cpp(corraddrphone_sources, 'FE' , '  ,', 'ie'));

corraddrphone_src_fe :=     __common__( corraddrphone_src_fe_pos > 0);

corraddrphone_src_ff_pos :=     __common__( Models.Common.findw_cpp(corraddrphone_sources, 'FF' , '  ,', 'ie'));

corraddrphone_src_ff :=     __common__( corraddrphone_src_ff_pos > 0);

corraddrphone_src_fr_pos :=     __common__( Models.Common.findw_cpp(corraddrphone_sources, 'FR' , '  ,', 'ie'));

corraddrphone_src_fr :=     __common__( corraddrphone_src_fr_pos > 0);

corraddrphone_src_l2_pos :=     __common__( Models.Common.findw_cpp(corraddrphone_sources, 'L2' , '  ,', 'ie'));

corraddrphone_src_l2 :=     __common__( corraddrphone_src_l2_pos > 0);

corraddrphone_src_li_pos :=     __common__( Models.Common.findw_cpp(corraddrphone_sources, 'LI' , '  ,', 'ie'));

corraddrphone_src_li :=     __common__( corraddrphone_src_li_pos > 0);

corraddrphone_src_mw_pos :=     __common__( Models.Common.findw_cpp(corraddrphone_sources, 'MW' , '  ,', 'ie'));

corraddrphone_src_mw :=     __common__( corraddrphone_src_mw_pos > 0);

corraddrphone_src_nt_pos :=     __common__( Models.Common.findw_cpp(corraddrphone_sources, 'NT' , '  ,', 'ie'));

corraddrphone_src_nt :=     __common__( corraddrphone_src_nt_pos > 0);

corraddrphone_src_p_pos :=     __common__( Models.Common.findw_cpp(corraddrphone_sources, 'P' , '  ,', 'ie'));

corraddrphone_src_p :=     __common__( corraddrphone_src_p_pos > 0);

corraddrphone_src_pl_pos :=     __common__( Models.Common.findw_cpp(corraddrphone_sources, 'PL' , '  ,', 'ie'));

corraddrphone_src_pl :=     __common__( corraddrphone_src_pl_pos > 0);

corraddrphone_src_tn_pos :=     __common__( Models.Common.findw_cpp(corraddrphone_sources, 'TN' , '  ,', 'ie'));

corraddrphone_src_tn :=     __common__( corraddrphone_src_tn_pos > 0);

corraddrphone_src_ts_pos :=     __common__( Models.Common.findw_cpp(corraddrphone_sources, 'TS' , '  ,', 'ie'));

corraddrphone_src_ts :=     __common__( corraddrphone_src_ts_pos > 0);

corraddrphone_src_tu_pos :=     __common__( Models.Common.findw_cpp(corraddrphone_sources, 'TU' , '  ,', 'ie'));

corraddrphone_src_tu :=     __common__( corraddrphone_src_tu_pos > 0);

corraddrphone_src_sl_pos :=     __common__( Models.Common.findw_cpp(corraddrphone_sources, 'SL' , '  ,', 'ie'));

corraddrphone_src_sl :=     __common__( corraddrphone_src_sl_pos > 0);

corraddrphone_src_v_pos :=     __common__( Models.Common.findw_cpp(corraddrphone_sources, 'V' , '  ,', 'ie'));

corraddrphone_src_v :=     __common__( corraddrphone_src_v_pos > 0);

corraddrphone_src_vo_pos :=     __common__( Models.Common.findw_cpp(corraddrphone_sources, 'VO' , '  ,', 'ie'));

corraddrphone_src_vo :=     __common__( corraddrphone_src_vo_pos > 0);

corraddrphone_src_w_pos :=     __common__( Models.Common.findw_cpp(corraddrphone_sources, 'W' , '  ,', 'ie'));

corraddrphone_src_w :=     __common__( corraddrphone_src_w_pos > 0);

corraddrphone_src_wp_pos :=     __common__( Models.Common.findw_cpp(corraddrphone_sources, 'WP' , '  ,', 'ie'));

corraddrphone_src_wp :=     __common__( corraddrphone_src_wp_pos > 0);

corraddrphone_ct :=     __common__( if(max((integer)corraddrphone_src_ak, (integer)corraddrphone_src_am, (integer)corraddrphone_src_ar, (integer)corraddrphone_src_ba, (integer)corraddrphone_src_cg, (integer)corraddrphone_src_co, (integer)corraddrphone_src_cy, (integer)corraddrphone_src_d, (integer)corraddrphone_src_da, (integer)corraddrphone_src_de, (integer)corraddrphone_src_dl, (integer)corraddrphone_src_ds, (integer)corraddrphone_src_e1, (integer)corraddrphone_src_e2, (integer)corraddrphone_src_e3, (integer)corraddrphone_src_e4, (integer)corraddrphone_src_eb, (integer)corraddrphone_src_em, (integer)corraddrphone_src_en, (integer)corraddrphone_src_eq, (integer)corraddrphone_src_fe, (integer)corraddrphone_src_ff, (integer)corraddrphone_src_fr, (integer)corraddrphone_src_l2, (integer)corraddrphone_src_li, (integer)corraddrphone_src_mw, (integer)corraddrphone_src_nt, (integer)corraddrphone_src_p, (integer)corraddrphone_src_pl, (integer)corraddrphone_src_sl, (integer)corraddrphone_src_tn, (integer)corraddrphone_src_ts, (integer)corraddrphone_src_tu, (integer)corraddrphone_src_v, (integer)corraddrphone_src_vo, (integer)corraddrphone_src_w, (integer)corraddrphone_src_wp) = NULL, NULL, sum((integer)corraddrphone_src_ak, (integer)corraddrphone_src_am, (integer)corraddrphone_src_ar, (integer)corraddrphone_src_ba, (integer)corraddrphone_src_cg, (integer)corraddrphone_src_co, (integer)corraddrphone_src_cy, (integer)corraddrphone_src_d, (integer)corraddrphone_src_da, (integer)corraddrphone_src_de, (integer)corraddrphone_src_dl, (integer)corraddrphone_src_ds, (integer)corraddrphone_src_e1, (integer)corraddrphone_src_e2, (integer)corraddrphone_src_e3, (integer)corraddrphone_src_e4, (integer)corraddrphone_src_eb, (integer)corraddrphone_src_em, (integer)corraddrphone_src_en, (integer)corraddrphone_src_eq, (integer)corraddrphone_src_fe, (integer)corraddrphone_src_ff, (integer)corraddrphone_src_fr, (integer)corraddrphone_src_l2, (integer)corraddrphone_src_li, (integer)corraddrphone_src_mw, (integer)corraddrphone_src_nt, (integer)corraddrphone_src_p, (integer)corraddrphone_src_pl, (integer)corraddrphone_src_sl, (integer)corraddrphone_src_tn, (integer)corraddrphone_src_ts, (integer)corraddrphone_src_tu, (integer)corraddrphone_src_v, (integer)corraddrphone_src_vo, (integer)corraddrphone_src_w, (integer)corraddrphone_src_wp)));

nf_corraddrphone :=     __common__( map(
    not(truedid)               => NULL,
    (integer)hphnpop = 0 or (integer)addrpop = 0 => NULL,
                                  min(if(corraddrphone_ct = NULL, -NULL, corraddrphone_ct), 999)));

corrphonelastname_src_ak_pos :=     __common__( Models.Common.findw_cpp(corrphonelastname_sources, 'AK' , '  ,', 'ie'));

corrphonelastname_src_ak :=     __common__( corrphonelastname_src_ak_pos > 0);

corrphonelastname_src_am_pos :=     __common__( Models.Common.findw_cpp(corrphonelastname_sources, 'AM' , '  ,', 'ie'));

corrphonelastname_src_am :=     __common__( corrphonelastname_src_am_pos > 0);

corrphonelastname_src_ar_pos :=     __common__( Models.Common.findw_cpp(corrphonelastname_sources, 'AR' , '  ,', 'ie'));

corrphonelastname_src_ar :=     __common__( corrphonelastname_src_ar_pos > 0);

corrphonelastname_src_ba_pos :=     __common__( Models.Common.findw_cpp(corrphonelastname_sources, 'BA' , '  ,', 'ie'));

corrphonelastname_src_ba :=     __common__( corrphonelastname_src_ba_pos > 0);

corrphonelastname_src_cg_pos :=     __common__( Models.Common.findw_cpp(corrphonelastname_sources, 'CG' , '  ,', 'ie'));

corrphonelastname_src_cg :=     __common__( corrphonelastname_src_cg_pos > 0);

corrphonelastname_src_co_pos :=     __common__( Models.Common.findw_cpp(corrphonelastname_sources, 'CO' , '  ,', 'ie'));

corrphonelastname_src_co :=     __common__( corrphonelastname_src_co_pos > 0);

corrphonelastname_src_cy_pos :=     __common__( Models.Common.findw_cpp(corrphonelastname_sources, 'CY' , '  ,', 'ie'));

corrphonelastname_src_cy :=     __common__( corrphonelastname_src_cy_pos > 0);

corrphonelastname_src_da_pos :=     __common__( Models.Common.findw_cpp(corrphonelastname_sources, 'DA' , '  ,', 'ie'));

corrphonelastname_src_da :=     __common__( corrphonelastname_src_da_pos > 0);

corrphonelastname_src_d_pos :=     __common__( Models.Common.findw_cpp(corrphonelastname_sources, 'D' , '  ,', 'ie'));

corrphonelastname_src_d :=     __common__( corrphonelastname_src_d_pos > 0);

corrphonelastname_src_dl_pos :=     __common__( Models.Common.findw_cpp(corrphonelastname_sources, 'DL' , '  ,', 'ie'));

corrphonelastname_src_dl :=     __common__( corrphonelastname_src_dl_pos > 0);

corrphonelastname_src_ds_pos :=     __common__( Models.Common.findw_cpp(corrphonelastname_sources, 'DS' , '  ,', 'ie'));

corrphonelastname_src_ds :=     __common__( corrphonelastname_src_ds_pos > 0);

corrphonelastname_src_de_pos :=     __common__( Models.Common.findw_cpp(corrphonelastname_sources, 'DE' , '  ,', 'ie'));

corrphonelastname_src_de :=     __common__( corrphonelastname_src_de_pos > 0);

corrphonelastname_src_eb_pos :=     __common__( Models.Common.findw_cpp(corrphonelastname_sources, 'EB' , '  ,', 'ie'));

corrphonelastname_src_eb :=     __common__( corrphonelastname_src_eb_pos > 0);

corrphonelastname_src_em_pos :=     __common__( Models.Common.findw_cpp(corrphonelastname_sources, 'EM' , '  ,', 'ie'));

corrphonelastname_src_em :=     __common__( corrphonelastname_src_em_pos > 0);

corrphonelastname_src_e1_pos :=     __common__( Models.Common.findw_cpp(corrphonelastname_sources, 'E1' , '  ,', 'ie'));

corrphonelastname_src_e1 :=     __common__( corrphonelastname_src_e1_pos > 0);

corrphonelastname_src_e2_pos :=     __common__( Models.Common.findw_cpp(corrphonelastname_sources, 'E2' , '  ,', 'ie'));

corrphonelastname_src_e2 :=     __common__( corrphonelastname_src_e2_pos > 0);

corrphonelastname_src_e3_pos :=     __common__( Models.Common.findw_cpp(corrphonelastname_sources, 'E3' , '  ,', 'ie'));

corrphonelastname_src_e3 :=     __common__( corrphonelastname_src_e3_pos > 0);

corrphonelastname_src_e4_pos :=     __common__( Models.Common.findw_cpp(corrphonelastname_sources, 'E4' , '  ,', 'ie'));

corrphonelastname_src_e4 :=     __common__( corrphonelastname_src_e4_pos > 0);

corrphonelastname_src_en_pos :=     __common__( Models.Common.findw_cpp(corrphonelastname_sources, 'EN' , '  ,', 'ie'));

corrphonelastname_src_en :=     __common__( corrphonelastname_src_en_pos > 0);

corrphonelastname_src_eq_pos :=     __common__( Models.Common.findw_cpp(corrphonelastname_sources, 'EQ' , '  ,', 'ie'));

corrphonelastname_src_eq :=     __common__( corrphonelastname_src_eq_pos > 0);

corrphonelastname_src_fe_pos :=     __common__( Models.Common.findw_cpp(corrphonelastname_sources, 'FE' , '  ,', 'ie'));

corrphonelastname_src_fe :=     __common__( corrphonelastname_src_fe_pos > 0);

corrphonelastname_src_ff_pos :=     __common__( Models.Common.findw_cpp(corrphonelastname_sources, 'FF' , '  ,', 'ie'));

corrphonelastname_src_ff :=     __common__( corrphonelastname_src_ff_pos > 0);

corrphonelastname_src_fr_pos :=     __common__( Models.Common.findw_cpp(corrphonelastname_sources, 'FR' , '  ,', 'ie'));

corrphonelastname_src_fr :=     __common__( corrphonelastname_src_fr_pos > 0);

corrphonelastname_src_l2_pos :=     __common__( Models.Common.findw_cpp(corrphonelastname_sources, 'L2' , '  ,', 'ie'));

corrphonelastname_src_l2 :=     __common__( corrphonelastname_src_l2_pos > 0);

corrphonelastname_src_li_pos :=     __common__( Models.Common.findw_cpp(corrphonelastname_sources, 'LI' , '  ,', 'ie'));

corrphonelastname_src_li :=     __common__( corrphonelastname_src_li_pos > 0);

corrphonelastname_src_mw_pos :=     __common__( Models.Common.findw_cpp(corrphonelastname_sources, 'MW' , '  ,', 'ie'));

corrphonelastname_src_mw :=     __common__( corrphonelastname_src_mw_pos > 0);

corrphonelastname_src_nt_pos :=     __common__( Models.Common.findw_cpp(corrphonelastname_sources, 'NT' , '  ,', 'ie'));

corrphonelastname_src_nt :=     __common__( corrphonelastname_src_nt_pos > 0);

corrphonelastname_src_p_pos :=     __common__( Models.Common.findw_cpp(corrphonelastname_sources, 'P' , '  ,', 'ie'));

corrphonelastname_src_p :=     __common__( corrphonelastname_src_p_pos > 0);

corrphonelastname_src_pl_pos :=     __common__( Models.Common.findw_cpp(corrphonelastname_sources, 'PL' , '  ,', 'ie'));

corrphonelastname_src_pl :=     __common__( corrphonelastname_src_pl_pos > 0);

corrphonelastname_src_tn_pos :=     __common__( Models.Common.findw_cpp(corrphonelastname_sources, 'TN' , '  ,', 'ie'));

corrphonelastname_src_tn :=     __common__( corrphonelastname_src_tn_pos > 0);

corrphonelastname_src_ts_pos :=     __common__( Models.Common.findw_cpp(corrphonelastname_sources, 'TS' , '  ,', 'ie'));

corrphonelastname_src_ts :=     __common__( corrphonelastname_src_ts_pos > 0);

corrphonelastname_src_tu_pos :=     __common__( Models.Common.findw_cpp(corrphonelastname_sources, 'TU' , '  ,', 'ie'));

corrphonelastname_src_tu :=     __common__( corrphonelastname_src_tu_pos > 0);

corrphonelastname_src_sl_pos :=     __common__( Models.Common.findw_cpp(corrphonelastname_sources, 'SL' , '  ,', 'ie'));

corrphonelastname_src_sl :=     __common__( corrphonelastname_src_sl_pos > 0);

corrphonelastname_src_v_pos :=     __common__( Models.Common.findw_cpp(corrphonelastname_sources, 'V' , '  ,', 'ie'));

corrphonelastname_src_v :=     __common__( corrphonelastname_src_v_pos > 0);

corrphonelastname_src_vo_pos :=     __common__( Models.Common.findw_cpp(corrphonelastname_sources, 'VO' , '  ,', 'ie'));

corrphonelastname_src_vo :=     __common__( corrphonelastname_src_vo_pos > 0);

corrphonelastname_src_w_pos :=     __common__( Models.Common.findw_cpp(corrphonelastname_sources, 'W' , '  ,', 'ie'));

corrphonelastname_src_w :=     __common__( corrphonelastname_src_w_pos > 0);

corrphonelastname_src_wp_pos :=     __common__( Models.Common.findw_cpp(corrphonelastname_sources, 'WP' , '  ,', 'ie'));

corrphonelastname_src_wp :=     __common__( corrphonelastname_src_wp_pos > 0);

corrphonelastname_ct :=     __common__( if(max((integer)corrphonelastname_src_ak, (integer)corrphonelastname_src_am, (integer)corrphonelastname_src_ar, (integer)corrphonelastname_src_ba, (integer)corrphonelastname_src_cg, (integer)corrphonelastname_src_co, (integer)corrphonelastname_src_cy, (integer)corrphonelastname_src_d, (integer)corrphonelastname_src_da, (integer)corrphonelastname_src_de, (integer)corrphonelastname_src_dl, (integer)corrphonelastname_src_ds, (integer)corrphonelastname_src_e1, (integer)corrphonelastname_src_e2, (integer)corrphonelastname_src_e3, (integer)corrphonelastname_src_e4, (integer)corrphonelastname_src_eb, (integer)corrphonelastname_src_em, (integer)corrphonelastname_src_en, (integer)corrphonelastname_src_eq, (integer)corrphonelastname_src_fe, (integer)corrphonelastname_src_ff, (integer)corrphonelastname_src_fr, (integer)corrphonelastname_src_l2, (integer)corrphonelastname_src_li, (integer)corrphonelastname_src_mw, (integer)corrphonelastname_src_nt, (integer)corrphonelastname_src_p, (integer)corrphonelastname_src_pl, (integer)corrphonelastname_src_sl, (integer)corrphonelastname_src_tn, (integer)corrphonelastname_src_ts, (integer)corrphonelastname_src_tu, (integer)corrphonelastname_src_v, (integer)corrphonelastname_src_vo, (integer)corrphonelastname_src_w, (integer)corrphonelastname_src_wp) = NULL, NULL, sum((integer)corrphonelastname_src_ak, (integer)corrphonelastname_src_am, (integer)corrphonelastname_src_ar, (integer)corrphonelastname_src_ba, (integer)corrphonelastname_src_cg, (integer)corrphonelastname_src_co, (integer)corrphonelastname_src_cy, (integer)corrphonelastname_src_d, (integer)corrphonelastname_src_da, (integer)corrphonelastname_src_de, (integer)corrphonelastname_src_dl, (integer)corrphonelastname_src_ds, (integer)corrphonelastname_src_e1, (integer)corrphonelastname_src_e2, (integer)corrphonelastname_src_e3, (integer)corrphonelastname_src_e4, (integer)corrphonelastname_src_eb, (integer)corrphonelastname_src_em, (integer)corrphonelastname_src_en, (integer)corrphonelastname_src_eq, (integer)corrphonelastname_src_fe, (integer)corrphonelastname_src_ff, (integer)corrphonelastname_src_fr, (integer)corrphonelastname_src_l2, (integer)corrphonelastname_src_li, (integer)corrphonelastname_src_mw, (integer)corrphonelastname_src_nt, (integer)corrphonelastname_src_p, (integer)corrphonelastname_src_pl, (integer)corrphonelastname_src_sl, (integer)corrphonelastname_src_tn, (integer)corrphonelastname_src_ts, (integer)corrphonelastname_src_tu, (integer)corrphonelastname_src_v, (integer)corrphonelastname_src_vo, (integer)corrphonelastname_src_w, (integer)corrphonelastname_src_wp)));

nf_corrphonelastname :=     __common__( map(
    not(truedid)                => NULL,
   (integer) hphnpop = 0 or (integer)lnamepop = 0 => NULL,
                                   min(if(corrphonelastname_ct = NULL, -NULL, corrphonelastname_ct), 999)));

//nf_corroboration_risk_index :=     __common__( if(not(truedid), NULL, if(max(2 ** 0 * (integer)(nf_corrssnname > 0), 2 ** 1 * (integer)(nf_corrphonelastname > 0), 2 ** 2 * (integer)(nf_corraddrphone > 0), 2 ** 3 * (integer)(nf_corraddrname > 0), 2 ** 4 * (integer)(nf_corrssnaddr > 0)) = NULL, NULL, sum(if(2 ** 0 * (integer)(nf_corrssnname > 0) = NULL, 0, 2 ** 0 * (integer)(nf_corrssnname > 0)), if(2 ** 1 * (integer)(nf_corrphonelastname > 0) = NULL, 0, 2 ** 1 * (integer)(nf_corrphonelastname > 0)), if(2 ** 2 * (integer)(nf_corraddrphone > 0) = NULL, 0, 2 ** 2 * (integer)(nf_corraddrphone > 0)), if(2 ** 3 * (integer)(nf_corraddrname > 0) = NULL, 0, 2 ** 3 * (integer)(nf_corraddrname > 0)), if(2 ** 4 * (integer)(nf_corrssnaddr > 0) = NULL, 0, 2 ** 4 * (integer)(nf_corrssnaddr > 0))))));

nf_corroboration_risk_index :=     __common__( if(not(truedid), NULL, 
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
                                         if(16* (integer)(nf_corrssnaddr > 0)   = NULL, 0,    16* (integer)(nf_corrssnaddr > 0))))));





nf_accident_count :=     __common__( if(not(truedid), NULL, min(if(acc_count = NULL, -NULL, acc_count), 999)));

nf_inq_email_ver_count :=     __common__( if(not(truedid) or inq_email_ver_count = 255, NULL, min(if(inq_email_ver_count = NULL, -NULL, inq_email_ver_count), 999)));

nf_phone_ver_insurance :=     __common__( if(not(truedid), NULL, (integer)phone_ver_insurance));

iv_bureau_verification_index_1 :=     __common__( if(not(truedid), NULL, 
                                  if(max((integer)(max(num_bureau_fname_1, num_bureau_lname_1) > 0), 
                                  2 * (integer)(num_bureau_addr_1 > 0), 
                                  4* (integer)(num_bureau_dob_1 > 0),
                                  8* (integer)(num_bureau_ssn_1 > 0)) = NULL, NULL, 
                                  sum(if((integer)(max(num_bureau_fname_1, num_bureau_lname_1) > 0) = NULL, 0, 
                                   (integer)(max(num_bureau_fname_1, num_bureau_lname_1) > 0)), 
                                   if(2 * (integer)(num_bureau_addr_1 > 0) = NULL, 0, 
                                   2 * (integer)(num_bureau_addr_1 > 0)),
                                   if(4* (integer)(num_bureau_dob_1 > 0) = NULL, 0, 
                                   4* (integer)(num_bureau_dob_1 > 0)), 
                                   if(8* (integer)(num_bureau_ssn_1 > 0) = NULL, 0,
                                   8 * (integer)(num_bureau_ssn_1 > 0))))));



rv_i60_inq_auto_count12 :=     __common__( if(not(truedid), NULL, min(if(inq_auto_count12 = NULL, -NULL, inq_auto_count12), 999)));

nf_inq_corraddrssn :=     __common__( map(
    not(truedid)                      => NULL,
    (inq_corraddrssn in [-3, -2, -1]) => NULL,
                                         inq_corraddrssn));

nf_liens_rel_ot_total_amt :=     __common__( if(not(truedid), NULL, liens_rel_ot_total_amount));

rv_c16_inv_ssn_per_adl :=     __common__( if(not(truedid), NULL, min(if(invalid_ssns_per_adl = NULL, -NULL, invalid_ssns_per_adl), 999)));

nf_inq_corrnamessn :=     __common__( map(
    not(truedid)                      => NULL,
    (inq_corrnamessn in [-3, -2, -1]) => NULL,
                                         inq_corrnamessn));

nf_liens_unrel_sc_total_amt :=     __common__( if(not(truedid), NULL, liens_unrel_sc_total_amount));

rv_i60_inq_auto_recency :=     __common__( map(
    not(truedid)     => NULL,
    (boolean)inq_auto_count01 => 1,
   (boolean) inq_auto_count03 => 3,
   (boolean) inq_auto_count06 => 6,
    (boolean)inq_auto_count12 => 12,
    (boolean)inq_auto_count24 => 24,
    (boolean)inq_auto_count   => 99,
                        0));

corrnamedob_src_ak_pos :=     __common__( Models.Common.findw_cpp(corrnamedob_sources, 'AK' , '  ,', 'ie'));

corrnamedob_src_ak :=     __common__( corrnamedob_src_ak_pos > 0);

corrnamedob_src_am_pos :=     __common__( Models.Common.findw_cpp(corrnamedob_sources, 'AM' , '  ,', 'ie'));

corrnamedob_src_am :=     __common__( corrnamedob_src_am_pos > 0);

corrnamedob_src_ar_pos :=     __common__( Models.Common.findw_cpp(corrnamedob_sources, 'AR' , '  ,', 'ie'));

corrnamedob_src_ar :=     __common__( corrnamedob_src_ar_pos > 0);

corrnamedob_src_ba_pos :=     __common__( Models.Common.findw_cpp(corrnamedob_sources, 'BA' , '  ,', 'ie'));

corrnamedob_src_ba :=     __common__( corrnamedob_src_ba_pos > 0);

corrnamedob_src_cg_pos :=     __common__( Models.Common.findw_cpp(corrnamedob_sources, 'CG' , '  ,', 'ie'));

corrnamedob_src_cg :=     __common__( corrnamedob_src_cg_pos > 0);

corrnamedob_src_co_pos :=     __common__( Models.Common.findw_cpp(corrnamedob_sources, 'CO' , '  ,', 'ie'));

corrnamedob_src_co :=     __common__( corrnamedob_src_co_pos > 0);

corrnamedob_src_cy_pos :=     __common__( Models.Common.findw_cpp(corrnamedob_sources, 'CY' , '  ,', 'ie'));

corrnamedob_src_cy :=     __common__( corrnamedob_src_cy_pos > 0);

corrnamedob_src_da_pos :=     __common__( Models.Common.findw_cpp(corrnamedob_sources, 'DA' , '  ,', 'ie'));

corrnamedob_src_da :=     __common__( corrnamedob_src_da_pos > 0);

corrnamedob_src_d_pos :=     __common__( Models.Common.findw_cpp(corrnamedob_sources, 'D' , '  ,', 'ie'));

corrnamedob_src_d :=     __common__( corrnamedob_src_d_pos > 0);

corrnamedob_src_dl_pos :=     __common__( Models.Common.findw_cpp(corrnamedob_sources, 'DL' , '  ,', 'ie'));

corrnamedob_src_dl :=     __common__( corrnamedob_src_dl_pos > 0);

corrnamedob_src_ds_pos :=     __common__( Models.Common.findw_cpp(corrnamedob_sources, 'DS' , '  ,', 'ie'));

corrnamedob_src_ds :=     __common__( corrnamedob_src_ds_pos > 0);

corrnamedob_src_de_pos :=     __common__( Models.Common.findw_cpp(corrnamedob_sources, 'DE' , '  ,', 'ie'));

corrnamedob_src_de :=     __common__( corrnamedob_src_de_pos > 0);

corrnamedob_src_eb_pos :=     __common__( Models.Common.findw_cpp(corrnamedob_sources, 'EB' , '  ,', 'ie'));

corrnamedob_src_eb :=     __common__( corrnamedob_src_eb_pos > 0);

corrnamedob_src_em_pos :=     __common__( Models.Common.findw_cpp(corrnamedob_sources, 'EM' , '  ,', 'ie'));

corrnamedob_src_em :=     __common__( corrnamedob_src_em_pos > 0);

corrnamedob_src_e1_pos :=     __common__( Models.Common.findw_cpp(corrnamedob_sources, 'E1' , '  ,', 'ie'));

corrnamedob_src_e1 :=     __common__( corrnamedob_src_e1_pos > 0);

corrnamedob_src_e2_pos :=     __common__( Models.Common.findw_cpp(corrnamedob_sources, 'E2' , '  ,', 'ie'));

corrnamedob_src_e2 :=     __common__( corrnamedob_src_e2_pos > 0);

corrnamedob_src_e3_pos :=     __common__( Models.Common.findw_cpp(corrnamedob_sources, 'E3' , '  ,', 'ie'));

corrnamedob_src_e3 :=     __common__( corrnamedob_src_e3_pos > 0);

corrnamedob_src_e4_pos :=     __common__( Models.Common.findw_cpp(corrnamedob_sources, 'E4' , '  ,', 'ie'));

corrnamedob_src_e4 :=     __common__( corrnamedob_src_e4_pos > 0);

corrnamedob_src_en_pos :=     __common__( Models.Common.findw_cpp(corrnamedob_sources, 'EN' , '  ,', 'ie'));

corrnamedob_src_en :=     __common__( corrnamedob_src_en_pos > 0);

corrnamedob_src_eq_pos :=     __common__( Models.Common.findw_cpp(corrnamedob_sources, 'EQ' , '  ,', 'ie'));

corrnamedob_src_eq :=     __common__( corrnamedob_src_eq_pos > 0);

corrnamedob_src_fe_pos :=     __common__( Models.Common.findw_cpp(corrnamedob_sources, 'FE' , '  ,', 'ie'));

corrnamedob_src_fe :=     __common__( corrnamedob_src_fe_pos > 0);

corrnamedob_src_ff_pos :=     __common__( Models.Common.findw_cpp(corrnamedob_sources, 'FF' , '  ,', 'ie'));

corrnamedob_src_ff :=     __common__( corrnamedob_src_ff_pos > 0);

corrnamedob_src_fr_pos :=     __common__( Models.Common.findw_cpp(corrnamedob_sources, 'FR' , '  ,', 'ie'));

corrnamedob_src_fr :=     __common__( corrnamedob_src_fr_pos > 0);

corrnamedob_src_l2_pos :=     __common__( Models.Common.findw_cpp(corrnamedob_sources, 'L2' , '  ,', 'ie'));

corrnamedob_src_l2 :=     __common__( corrnamedob_src_l2_pos > 0);

corrnamedob_src_li_pos :=     __common__( Models.Common.findw_cpp(corrnamedob_sources, 'LI' , '  ,', 'ie'));

corrnamedob_src_li :=     __common__( corrnamedob_src_li_pos > 0);

corrnamedob_src_mw_pos :=     __common__( Models.Common.findw_cpp(corrnamedob_sources, 'MW' , '  ,', 'ie'));

corrnamedob_src_mw :=     __common__( corrnamedob_src_mw_pos > 0);

corrnamedob_src_nt_pos :=     __common__( Models.Common.findw_cpp(corrnamedob_sources, 'NT' , '  ,', 'ie'));

corrnamedob_src_nt :=     __common__( corrnamedob_src_nt_pos > 0);

corrnamedob_src_p_pos :=     __common__( Models.Common.findw_cpp(corrnamedob_sources, 'P' , '  ,', 'ie'));

corrnamedob_src_p :=     __common__( corrnamedob_src_p_pos > 0);

corrnamedob_src_pl_pos :=     __common__( Models.Common.findw_cpp(corrnamedob_sources, 'PL' , '  ,', 'ie'));

corrnamedob_src_pl :=     __common__( corrnamedob_src_pl_pos > 0);

corrnamedob_src_tn_pos :=     __common__( Models.Common.findw_cpp(corrnamedob_sources, 'TN' , '  ,', 'ie'));

corrnamedob_src_tn :=     __common__( corrnamedob_src_tn_pos > 0);

corrnamedob_src_ts_pos :=     __common__( Models.Common.findw_cpp(corrnamedob_sources, 'TS' , '  ,', 'ie'));

corrnamedob_src_ts :=     __common__( corrnamedob_src_ts_pos > 0);

corrnamedob_src_tu_pos :=     __common__( Models.Common.findw_cpp(corrnamedob_sources, 'TU' , '  ,', 'ie'));

corrnamedob_src_tu :=     __common__( corrnamedob_src_tu_pos > 0);

corrnamedob_src_sl_pos :=     __common__( Models.Common.findw_cpp(corrnamedob_sources, 'SL' , '  ,', 'ie'));

corrnamedob_src_sl :=     __common__( corrnamedob_src_sl_pos > 0);

corrnamedob_src_v_pos :=     __common__( Models.Common.findw_cpp(corrnamedob_sources, 'V' , '  ,', 'ie'));

corrnamedob_src_v :=     __common__( corrnamedob_src_v_pos > 0);

corrnamedob_src_vo_pos :=     __common__( Models.Common.findw_cpp(corrnamedob_sources, 'VO' , '  ,', 'ie'));

corrnamedob_src_vo :=     __common__( corrnamedob_src_vo_pos > 0);

corrnamedob_src_w_pos :=     __common__( Models.Common.findw_cpp(corrnamedob_sources, 'W' , '  ,', 'ie'));

corrnamedob_src_w :=     __common__( corrnamedob_src_w_pos > 0);

corrnamedob_src_wp_pos :=     __common__( Models.Common.findw_cpp(corrnamedob_sources, 'WP' , '  ,', 'ie'));

corrnamedob_src_wp :=     __common__( corrnamedob_src_wp_pos > 0);

corrnamedob_ct :=     __common__( if(max((integer)corrnamedob_src_ak, (integer)corrnamedob_src_am, (integer)corrnamedob_src_ar, (integer)corrnamedob_src_ba, (integer)corrnamedob_src_cg, (integer)corrnamedob_src_co, (integer)corrnamedob_src_cy, (integer)corrnamedob_src_d, (integer)corrnamedob_src_da, (integer)corrnamedob_src_de, (integer)corrnamedob_src_dl, (integer)corrnamedob_src_ds, (integer)corrnamedob_src_e1, (integer)corrnamedob_src_e2, (integer)corrnamedob_src_e3, (integer)corrnamedob_src_e4, (integer)corrnamedob_src_eb, (integer)corrnamedob_src_em, (integer)corrnamedob_src_en, (integer)corrnamedob_src_eq, (integer)corrnamedob_src_fe, (integer)corrnamedob_src_ff, (integer)corrnamedob_src_fr, (integer)corrnamedob_src_l2, (integer)corrnamedob_src_li, (integer)corrnamedob_src_mw, (integer)corrnamedob_src_nt, (integer)corrnamedob_src_p, (integer)corrnamedob_src_pl, (integer)corrnamedob_src_sl, (integer)corrnamedob_src_tn, (integer)corrnamedob_src_ts, (integer)corrnamedob_src_tu, (integer)corrnamedob_src_v, (integer)corrnamedob_src_vo, (integer)corrnamedob_src_w, (integer)corrnamedob_src_wp) = NULL, NULL, sum((integer)corrnamedob_src_ak, (integer)corrnamedob_src_am, (integer)corrnamedob_src_ar, (integer)corrnamedob_src_ba, (integer)corrnamedob_src_cg, (integer)corrnamedob_src_co, (integer)corrnamedob_src_cy, (integer)corrnamedob_src_d, (integer)corrnamedob_src_da, (integer)corrnamedob_src_de, (integer)corrnamedob_src_dl, (integer)corrnamedob_src_ds, (integer)corrnamedob_src_e1, (integer)corrnamedob_src_e2, (integer)corrnamedob_src_e3, (integer)corrnamedob_src_e4, (integer)corrnamedob_src_eb, (integer)corrnamedob_src_em, (integer)corrnamedob_src_en, (integer)corrnamedob_src_eq, (integer)corrnamedob_src_fe, (integer)corrnamedob_src_ff, (integer)corrnamedob_src_fr, (integer)corrnamedob_src_l2, (integer)corrnamedob_src_li, (integer)corrnamedob_src_mw, (integer)corrnamedob_src_nt, (integer)corrnamedob_src_p, (integer)corrnamedob_src_pl, (integer)corrnamedob_src_sl, (integer)corrnamedob_src_tn, (integer)corrnamedob_src_ts, (integer)corrnamedob_src_tu, (integer)corrnamedob_src_v, (integer)corrnamedob_src_vo, (integer)corrnamedob_src_w, (integer)corrnamedob_src_wp)));

nf_corrnamedob :=     __common__( map(
    not(truedid)               => NULL,
    (integer)dobpop = 0 or (integer)lnamepop = 0 => NULL,
                                  min(if(corrnamedob_ct = NULL, -NULL, corrnamedob_ct), 999)));

nf_inq_corrnameaddrphnssn :=     __common__( map(
    not(truedid)                             => NULL,
    (inq_corrnameaddrphnssn in [-3, -2, -1]) => NULL,
                                                inq_corrnameaddrphnssn));

nf_liens_unrel_o_total_amt :=     __common__( if(not(truedid), NULL, liens_unrel_o_total_amount));

nf_bus_ucc_count :=     __common__( if(not(truedid), NULL, bus_ucc_count));

nf_inq_peraddr_recency :=     __common__( map(
    not(truedid)        => NULL,
    (boolean)inq_peraddr_count01 => 1,
    (boolean)inq_peraddr_count03 => 3,
    (boolean)inq_peraddr_count06 => 6,
    (boolean)Inq_PerAddr         => 12,
                           0));

nf_inq_corrnamephonessn :=     __common__( map(
    not(truedid)                           => NULL,
    (inq_corrnamephonessn in [-3, -2, -1]) => NULL,
                                              inq_corrnamephonessn));

rv_f00_inq_corrnameaddr_adl :=     __common__( map(
    not(truedid)                           => NULL,
    (inq_corrnameaddr_adl in [-3, -2, -1]) => NULL,
                                              inq_corrnameaddr_adl));

nf_inq_corrdobssn :=     __common__( map(
    not(truedid)                     => NULL,
    (inq_corrdobssn in [-3, -2, -1]) => NULL,
                                        inq_corrdobssn));

rv_i60_inq_other_count12 :=     __common__( if(not(truedid), NULL, min(if(inq_other_count12 = NULL, -NULL, inq_other_count12), 999)));

rv_c13_inp_addr_lres :=     __common__( if(not((boolean)(integer)add_input_pop and truedid), NULL, min(if(add_input_lres = NULL, -NULL, add_input_lres), 999)));

_liens_unrel_ft_first_seen :=     __common__( common.sas_date((string)(liens_unrel_FT_first_seen)));

nf_mos_liens_unrel_ft_fseen :=     __common__( map(
    not(truedid)                      => NULL,
    _liens_unrel_ft_first_seen = NULL => -1,
                                         min(if(if ((sysdate - _liens_unrel_ft_first_seen) / (365.25 / 12) >= 0, truncate((sysdate - _liens_unrel_ft_first_seen) / (365.25 / 12)), roundup((sysdate - _liens_unrel_ft_first_seen) / (365.25 / 12))) = NULL, -NULL, if ((sysdate - _liens_unrel_ft_first_seen) / (365.25 / 12) >= 0, truncate((sysdate - _liens_unrel_ft_first_seen) / (365.25 / 12)), roundup((sysdate - _liens_unrel_ft_first_seen) / (365.25 / 12)))), 999)));

nf_phones_per_sfd_addr_curr :=     __common__( map(
    not(addrpop) => NULL,
    iv_add_apt ='1'  => -1,
                    min(if(phones_per_addr_curr = NULL, -NULL, phones_per_addr_curr), 999)));

rv_c23_email_count :=     __common__( if(not(truedid), NULL, min(if(email_count = NULL, -NULL, email_count), 999)));

nf_adls_per_curraddr_curr :=     __common__( if(not((boolean)(integer)add_curr_pop) or not(truedid), NULL, min(if(adls_per_curraddr_curr = NULL, -NULL, adls_per_curraddr_curr), 999)));

nf_liens_rel_o_total_amt :=     __common__( if(not(truedid), NULL, liens_rel_o_total_amount));

rv_4seg_riskview_5_0 :=     __common__( map(
    (integer)truedid = 0                                      => '0 TRUEDID = 0',
    not((boolean)sufficiently_verified)              => '1 VER/VAL PROBLEMS',
    (boolean)validation_problem                               => '1 VER/VAL PROBLEMS',
    (boolean)has_derog                                        => '2 DEROG',
    add_input_naprop = 4 or property_owned_total > 0 => '3 OWNER',
                                                        '4 OTHER'));

nf_fp_srchfraudsrchcount :=     __common__( if(not(truedid), NULL, min(if(fp_srchfraudsrchcount = '', -NULL, (integer)fp_srchfraudsrchcount), 999)));

nf_inq_dobsperssn_recency :=     __common__( map(
    not(truedid)           => NULL,
    (boolean)inq_dobsperssn_count01 => 1,
    (boolean)inq_dobsperssn_count03 => 3,
    (boolean)inq_dobsperssn_count06 => 6,
    (boolean)Inq_DOBsPerSSN         => 12,
                              0));

rv_a44_curr_add_naprop :=     __common__( if(not(truedid and (boolean)(integer)add_curr_pop), NULL, add_curr_naprop));

nf_inq_other_count24 :=     __common__( if(not(truedid), NULL, min(if(inq_Other_count24 = NULL, -NULL, inq_Other_count24), 999)));

iv_nap_lname_verd :=     __common__( (nap_summary in [2, 5, 7, 8, 9, 11, 12]));

nf_fp_srchaddrsrchcountmo :=     __common__( if(not(truedid), NULL, min(if(fp_srchaddrsrchcountmo = '', -NULL, (integer)fp_srchaddrsrchcountmo), 999)));

nf_fp_srchssnsrchcountmo :=     __common__( if(not(truedid), NULL, min(if(fp_srchssnsrchcountmo = '', -NULL, (integer)fp_srchssnsrchcountmo), 999)));

rv_i62_inq_addrs_per_adl :=     __common__( if(not(truedid), NULL, min(if(inq_addrsperadl = NULL, -NULL, inq_addrsperadl), 999)));

most_recent_date_c1546_b4 :=     __common__( max(bs_ver_src_ldate_ar, bs_ver_src_ldate_ba, bs_ver_src_ldate_bc, bs_ver_src_ldate_bm, bs_ver_src_ldate_bn, bs_ver_src_ldate_br, bs_ver_src_ldate_by, bs_ver_src_ldate_c, bs_ver_src_ldate_cf, bs_ver_src_ldate_cs, bs_ver_src_ldate_cu, bs_ver_src_ldate_d, bs_ver_src_ldate_da, bs_ver_src_ldate_df, bs_ver_src_ldate_dn, bs_ver_src_ldate_e, bs_ver_src_ldate_ef, bs_ver_src_ldate_er, bs_ver_src_ldate_ey, bs_ver_src_ldate_f, bs_ver_src_ldate_fb, bs_ver_src_ldate_fi, bs_ver_src_ldate_fk, bs_ver_src_ldate_fr, bs_ver_src_ldate_ft, bs_ver_src_ldate_gb, bs_ver_src_ldate_gr, bs_ver_src_ldate_h7, bs_ver_src_ldate_i, bs_ver_src_ldate_ia, bs_ver_src_ldate_ic, bs_ver_src_ldate_in, bs_ver_src_ldate_ip, bs_ver_src_ldate_is, bs_ver_src_ldate_it, bs_ver_src_ldate_j2, bs_ver_src_ldate_kc, bs_ver_src_ldate_l0, bs_ver_src_ldate_l2, bs_ver_src_ldate_mh, bs_ver_src_ldate_mw, bs_ver_src_ldate_np, bs_ver_src_ldate_nr, bs_ver_src_ldate_os, bs_ver_src_ldate_p, bs_ver_src_ldate_pl, bs_ver_src_ldate_pp, bs_ver_src_ldate_q3, bs_ver_src_ldate_rr, bs_ver_src_ldate_sa, bs_ver_src_ldate_sb, bs_ver_src_ldate_sg, bs_ver_src_ldate_sj, bs_ver_src_ldate_sk, bs_ver_src_ldate_sp, bs_ver_src_ldate_tx, bs_ver_src_ldate_u2, bs_ver_src_ldate_ut, bs_ver_src_ldate_v, bs_ver_src_ldate_v2, bs_ver_src_ldate_wa, bs_ver_src_ldate_wb, bs_ver_src_ldate_wc, bs_ver_src_ldate_wk, bs_ver_src_ldate_wx, bs_ver_src_ldate_y, bs_ver_src_ldate_zo));

nf_bus_ver_src_mos_lseen :=     __common__( map(
    not(truedid)                                  => NULL,
    bus_ver_sources_lseen = ''                  => -1,
    (bus_ver_sources_lseen in ['-1', '-2', '-3']) => (integer)bus_ver_sources_lseen,
                                                     if ((sysdate8 - most_recent_date_c1546_b4) / 30.5 >= 0, roundup((sysdate8 - most_recent_date_c1546_b4) / 30.5), truncate((sysdate8 - most_recent_date_c1546_b4) / 30.5))));

rv_i60_inq_other_recency :=     __common__( map(
    not(truedid)      => NULL,
    (boolean)inq_other_count01 => 1,
    (boolean)inq_other_count03 => 3,
    (boolean)inq_other_count06 => 6,
    (boolean)inq_other_count12 => 12,
    (boolean)inq_other_count24 => 24,
    (boolean)inq_other_count   => 99,
                         0));

_liens_unrel_cj_first_seen :=     __common__( common.sas_date((string)(liens_unrel_CJ_first_seen)));

nf_mos_liens_unrel_cj_fseen :=     __common__( map(
    not(truedid)                      => NULL,
    _liens_unrel_cj_first_seen = NULL => -1,
                                         min(if(if ((sysdate - _liens_unrel_cj_first_seen) / (365.25 / 12) >= 0, truncate((sysdate - _liens_unrel_cj_first_seen) / (365.25 / 12)), roundup((sysdate - _liens_unrel_cj_first_seen) / (365.25 / 12))) = NULL, -NULL, if ((sysdate - _liens_unrel_cj_first_seen) / (365.25 / 12) >= 0, truncate((sysdate - _liens_unrel_cj_first_seen) / (365.25 / 12)), roundup((sysdate - _liens_unrel_cj_first_seen) / (365.25 / 12)))), 999)));

nf_inq_lnamesperaddr_recency :=     __common__( map(
    not(truedid)              => NULL,
    (boolean)inq_lnamesperaddr_count01 => 1,
    (boolean)inq_lnamesperaddr_count03 => 3,
    (boolean)inq_lnamesperaddr_count06 => 6,
    (boolean)Inq_LNamesPerAddr         => 12,
                                 0));

_liens_unrel_o_first_seen :=     __common__( common.sas_date((string)(liens_unrel_o_first_seen)));

nf_mos_liens_unrel_o_fseen :=     __common__( map(
    not(truedid)                     => NULL,
    _liens_unrel_o_first_seen = NULL => -1,
                                        min(if(if ((sysdate - _liens_unrel_o_first_seen) / (365.25 / 12) >= 0, truncate((sysdate - _liens_unrel_o_first_seen) / (365.25 / 12)), roundup((sysdate - _liens_unrel_o_first_seen) / (365.25 / 12))) = NULL, -NULL, if ((sysdate - _liens_unrel_o_first_seen) / (365.25 / 12) >= 0, truncate((sysdate - _liens_unrel_o_first_seen) / (365.25 / 12)), roundup((sysdate - _liens_unrel_o_first_seen) / (365.25 / 12)))), 999)));

nf_inq_dobsperssn_1dig :=     __common__( map(
    not(truedid)                          => NULL,
    (inq_dobsperssn_1dig in [-3, -2, -1]) => NULL,
                                             inq_dobsperssn_1dig));

nf_sum_src_credentialed :=     __common__( if(not(truedid), NULL, if(max((integer)ver_src_ar, (integer)ver_src_am, (integer)ver_src_ba, (integer)ver_src_cg, (integer)ver_src_da, (integer)ver_src_d, (integer)ver_src_dl, (integer)ver_src_eb, (integer)ver_src_e1, (integer)ver_src_e2, (integer)ver_src_e3, (integer)ver_src_fe, (integer)ver_src_ff, (integer)ver_src_p, (integer)ver_src_pl, (integer)ver_src_sl, (integer)ver_src_v, (integer)ver_src_vo, (integer)ver_src_w) = NULL, NULL, sum((integer)ver_src_ar, (integer)ver_src_am, (integer)ver_src_ba, (integer)ver_src_cg, (integer)ver_src_da, (integer)ver_src_d, (integer)ver_src_dl, (integer)ver_src_eb, (integer)ver_src_e1, (integer)ver_src_e2, (integer)ver_src_e3, (integer)ver_src_fe, (integer)ver_src_ff, (integer)ver_src_p, (integer)ver_src_pl, (integer)ver_src_sl, (integer)ver_src_v, (integer)ver_src_vo, (integer)ver_src_w))));

rv_d34_liens_unrel_total_amt :=     __common__( if(not(truedid), NULL, liens_unrel_total_amount));

rv_f00_inq_corrnamessn_adl :=     __common__( map(
    not(truedid)                          => NULL,
    (inq_corrnamessn_adl in [-3, -2, -1]) => NULL,
                                             inq_corrnamessn_adl));

earliest_date_c1555_b4 :=     __common__( if(max(bs_ver_src_fdate_ba, bs_ver_src_fdate_c, bs_ver_src_fdate_fk, bs_ver_src_fdate_p, bs_ver_src_fdate_cu, bs_ver_src_fdate_f, bs_ver_src_fdate_v2, bs_ver_src_fdate_sa, bs_ver_src_fdate_is, bs_ver_src_fdate_fi, bs_ver_src_fdate_by, bs_ver_src_fdate_h7, bs_ver_src_fdate_bm, bs_ver_src_fdate_np, bs_ver_src_fdate_ut, bs_ver_src_fdate_gr, bs_ver_src_fdate_er, bs_ver_src_fdate_cf, bs_ver_src_fdate_cs, bs_ver_src_fdate_rr, bs_ver_src_fdate_d, bs_ver_src_fdate_wa, bs_ver_src_fdate_wc, bs_ver_src_fdate_pl, bs_ver_src_fdate_ia, bs_ver_src_fdate_mh, bs_ver_src_fdate_tx, bs_ver_src_fdate_wb, bs_ver_src_fdate_wk, bs_ver_src_fdate_nr, bs_ver_src_fdate_sp, bs_ver_src_fdate_bn, bs_ver_src_fdate_ft, bs_ver_src_fdate_sb, bs_ver_src_fdate_sg, bs_ver_src_fdate_br, bs_ver_src_fdate_sk, bs_ver_src_fdate_mw, bs_ver_src_fdate_fb, bs_ver_src_fdate_pp, bs_ver_src_fdate_ic, bs_ver_src_fdate_ey, bs_ver_src_fdate_ar, bs_ver_src_fdate_fr, bs_ver_src_fdate_kc, bs_ver_src_fdate_u2, bs_ver_src_fdate_it, bs_ver_src_fdate_dn, bs_ver_src_fdate_l0, bs_ver_src_fdate_sj, bs_ver_src_fdate_in, bs_ver_src_fdate_wx, bs_ver_src_fdate_gb, bs_ver_src_fdate_l2, bs_ver_src_fdate_y, bs_ver_src_fdate_ef, bs_ver_src_fdate_da, bs_ver_src_fdate_e, bs_ver_src_fdate_v, bs_ver_src_fdate_df, bs_ver_src_fdate_j2, bs_ver_src_fdate_q3, bs_ver_src_fdate_i, bs_ver_src_fdate_os, bs_ver_src_fdate_bc, bs_ver_src_fdate_ip, bs_ver_src_fdate_zo) = NULL, NULL, min(if(bs_ver_src_fdate_ba = NULL, -NULL, bs_ver_src_fdate_ba), if(bs_ver_src_fdate_c = NULL, -NULL, bs_ver_src_fdate_c), if(bs_ver_src_fdate_fk = NULL, -NULL, bs_ver_src_fdate_fk), if(bs_ver_src_fdate_p = NULL, -NULL, bs_ver_src_fdate_p), if(bs_ver_src_fdate_cu = NULL, -NULL, bs_ver_src_fdate_cu), if(bs_ver_src_fdate_f = NULL, -NULL, bs_ver_src_fdate_f), if(bs_ver_src_fdate_v2 = NULL, -NULL, bs_ver_src_fdate_v2), if(bs_ver_src_fdate_sa = NULL, -NULL, bs_ver_src_fdate_sa), if(bs_ver_src_fdate_is = NULL, -NULL, bs_ver_src_fdate_is), if(bs_ver_src_fdate_fi = NULL, -NULL, bs_ver_src_fdate_fi), if(bs_ver_src_fdate_by = NULL, -NULL, bs_ver_src_fdate_by), if(bs_ver_src_fdate_h7 = NULL, -NULL, bs_ver_src_fdate_h7), if(bs_ver_src_fdate_bm = NULL, -NULL, bs_ver_src_fdate_bm), if(bs_ver_src_fdate_np = NULL, -NULL, bs_ver_src_fdate_np), if(bs_ver_src_fdate_ut = NULL, -NULL, bs_ver_src_fdate_ut), if(bs_ver_src_fdate_gr = NULL, -NULL, bs_ver_src_fdate_gr), if(bs_ver_src_fdate_er = NULL, -NULL, bs_ver_src_fdate_er), if(bs_ver_src_fdate_cf = NULL, -NULL, bs_ver_src_fdate_cf), if(bs_ver_src_fdate_cs = NULL, -NULL, bs_ver_src_fdate_cs), if(bs_ver_src_fdate_rr = NULL, -NULL, bs_ver_src_fdate_rr), if(bs_ver_src_fdate_d = NULL, -NULL, bs_ver_src_fdate_d), if(bs_ver_src_fdate_wa = NULL, -NULL, bs_ver_src_fdate_wa), if(bs_ver_src_fdate_wc = NULL, -NULL, bs_ver_src_fdate_wc), if(bs_ver_src_fdate_pl = NULL, -NULL, bs_ver_src_fdate_pl), if(bs_ver_src_fdate_ia = NULL, -NULL, bs_ver_src_fdate_ia), if(bs_ver_src_fdate_mh = NULL, -NULL, bs_ver_src_fdate_mh), if(bs_ver_src_fdate_tx = NULL, -NULL, bs_ver_src_fdate_tx), if(bs_ver_src_fdate_wb = NULL, -NULL, bs_ver_src_fdate_wb), if(bs_ver_src_fdate_wk = NULL, -NULL, bs_ver_src_fdate_wk), if(bs_ver_src_fdate_nr = NULL, -NULL, bs_ver_src_fdate_nr), if(bs_ver_src_fdate_sp = NULL, -NULL, bs_ver_src_fdate_sp), if(bs_ver_src_fdate_bn = NULL, -NULL, bs_ver_src_fdate_bn), if(bs_ver_src_fdate_ft = NULL, -NULL, bs_ver_src_fdate_ft), if(bs_ver_src_fdate_sb = NULL, -NULL, bs_ver_src_fdate_sb), if(bs_ver_src_fdate_sg = NULL, -NULL, bs_ver_src_fdate_sg), if(bs_ver_src_fdate_br = NULL, -NULL, bs_ver_src_fdate_br), if(bs_ver_src_fdate_sk = NULL, -NULL, bs_ver_src_fdate_sk), if(bs_ver_src_fdate_mw = NULL, -NULL, bs_ver_src_fdate_mw), if(bs_ver_src_fdate_fb = NULL, -NULL, bs_ver_src_fdate_fb), if(bs_ver_src_fdate_pp = NULL, -NULL, bs_ver_src_fdate_pp), if(bs_ver_src_fdate_ic = NULL, -NULL, bs_ver_src_fdate_ic), if(bs_ver_src_fdate_ey = NULL, -NULL, bs_ver_src_fdate_ey), if(bs_ver_src_fdate_ar = NULL, -NULL, bs_ver_src_fdate_ar), if(bs_ver_src_fdate_fr = NULL, -NULL, bs_ver_src_fdate_fr), if(bs_ver_src_fdate_kc = NULL, -NULL, bs_ver_src_fdate_kc), if(bs_ver_src_fdate_u2 = NULL, -NULL, bs_ver_src_fdate_u2), if(bs_ver_src_fdate_it = NULL, -NULL, bs_ver_src_fdate_it), if(bs_ver_src_fdate_dn = NULL, -NULL, bs_ver_src_fdate_dn), if(bs_ver_src_fdate_l0 = NULL, -NULL, bs_ver_src_fdate_l0), if(bs_ver_src_fdate_sj = NULL, -NULL, bs_ver_src_fdate_sj), if(bs_ver_src_fdate_in = NULL, -NULL, bs_ver_src_fdate_in), if(bs_ver_src_fdate_wx = NULL, -NULL, bs_ver_src_fdate_wx), if(bs_ver_src_fdate_gb = NULL, -NULL, bs_ver_src_fdate_gb), if(bs_ver_src_fdate_l2 = NULL, -NULL, bs_ver_src_fdate_l2), if(bs_ver_src_fdate_y = NULL, -NULL, bs_ver_src_fdate_y), if(bs_ver_src_fdate_ef = NULL, -NULL, bs_ver_src_fdate_ef), if(bs_ver_src_fdate_da = NULL, -NULL, bs_ver_src_fdate_da), if(bs_ver_src_fdate_e = NULL, -NULL, bs_ver_src_fdate_e), if(bs_ver_src_fdate_v = NULL, -NULL, bs_ver_src_fdate_v), if(bs_ver_src_fdate_df = NULL, -NULL, bs_ver_src_fdate_df), if(bs_ver_src_fdate_j2 = NULL, -NULL, bs_ver_src_fdate_j2), if(bs_ver_src_fdate_q3 = NULL, -NULL, bs_ver_src_fdate_q3), if(bs_ver_src_fdate_i = NULL, -NULL, bs_ver_src_fdate_i), if(bs_ver_src_fdate_os = NULL, -NULL, bs_ver_src_fdate_os), if(bs_ver_src_fdate_bc = NULL, -NULL, bs_ver_src_fdate_bc), if(bs_ver_src_fdate_ip = NULL, -NULL, bs_ver_src_fdate_ip), if(bs_ver_src_fdate_zo = NULL, -NULL, bs_ver_src_fdate_zo))));

nf_bus_ver_src_mos_fseen :=     __common__( map(
    not(truedid)                                  => NULL,
    bus_ver_sources_fseen = ''                  => -1,
    (bus_ver_sources_fseen in ['-1', '-2', '-3']) => (integer)bus_ver_sources_fseen,
                                                     if ((sysdate8 - earliest_date_c1555_b4) / 30.5 >= 0, roundup((sysdate8 - earliest_date_c1555_b4) / 30.5), truncate((sysdate8 - earliest_date_c1555_b4) / 30.5))));

nf_inquiry_adl_vel_risk_index :=     __common__( if(not(truedid), NULL, 
                                  if(max((integer)(inq_lnamesperadl > 2), 
                                  2 * (integer)(inq_phonesperadl > 2), 
                                  4* (integer)(inq_addrsperadl > 2),
                                  8* (integer)(inq_dobsperadl > 2), 
                                  16 * (integer)(inq_ssnsperadl > 2)) = NULL,NULL,
                                  sum(if((integer)(inq_lnamesperadl > 2) = NULL, 0,
                                  (integer)(inq_lnamesperadl > 2)), 
                                  if(2 * (integer)(inq_phonesperadl > 2) = NULL, 0, 
                                  2  * (integer)(inq_phonesperadl > 2)), 
                                  if(4* (integer)(inq_addrsperadl > 2) = NULL, 0, 
                                  4 * (integer)(inq_addrsperadl > 2)), 
                                  if(8* (integer)(inq_dobsperadl > 2) = NULL, 0, 
                                  8 * (integer)(inq_dobsperadl > 2)), 
                                  if(16 * (integer)(inq_ssnsperadl > 2) = NULL, 0, 
                                  16 * (integer)(inq_ssnsperadl > 2))))));

vo_pos :=     __common__( Models.Common.findw_cpp(ver_sources, 'VO' , ', ', 'E'));

vote_adl_lseen_vo :=     __common__( if(vo_pos > 0, Models.Common.getw(ver_sources_last_seen, vo_pos, ','), ''));

_vote_adl_lseen_vo :=     __common__( common.sas_date((string)(vote_adl_lseen_vo)));

// iv_mos_src_voter_adl_lseen :=     __common__( map(
    // not(truedid)                  => NULL,
    // _vote_adl_lseen_vo = NULL = 0 => 
    // if ((sysdate - _vote_adl_lseen_vo) / (365.25 / 12) >= 0, 
    // truncate((sysdate - _vote_adl_lseen_vo) / (365.25 / 12)), 
    // roundup((sysdate - _vote_adl_lseen_vo) / (365.25 / 12))),
                                      // -1));
 


iv_mos_src_voter_adl_lseen :=     __common__( map(
    not(truedid)              => NULL,
    _vote_adl_lseen_vo = NULL => -1 ,
                                if ((sysdate - _vote_adl_lseen_vo) / (365.25 / 12) >= 0, 
                                truncate((sysdate - _vote_adl_lseen_vo) / (365.25 / 12)), 
                                roundup((sysdate - _vote_adl_lseen_vo) / (365.25 / 12)))));
  

lncu_tree_0 :=     __common__( -2.07508575467281);

lncu_tree_1_c1560 :=     __common__( map(
    (ip_routingmethod in ['06', '12', '13', '14', '15']) => 0.0196139010877514,
    (ip_routingmethod in ['', '02', '10', '11', '16'])   => 0.165265634085881,
    ip_routingmethod = ''                              => 0.0611694016297492,
                                                            0.0611694016297492));

lncu_tree_1_c1561 :=     __common__( map(
    NULL < nf_inq_ssn_lexid_diff01 AND nf_inq_ssn_lexid_diff01 < 0.5 => -0.0240605574992545,
    nf_inq_ssn_lexid_diff01 >= 0.5                                   => 0.0497091548550926,
    nf_inq_ssn_lexid_diff01 = NULL                                   => -0.0142024215332524,
                                                                        -0.0142024215332524));

lncu_tree_1 :=     __common__( map(
    NULL < nf_phone_ver_bureau AND nf_phone_ver_bureau < 0.5 => lncu_tree_1_c1560,
    nf_phone_ver_bureau >= 0.5                               => lncu_tree_1_c1561,
    nf_phone_ver_bureau = NULL                               => 0.000174456776777495,
                                                                0.000174456776777495));

lncu_tree_2_c1563 :=     __common__( map(
    NULL < nf_phone_ver_bureau AND nf_phone_ver_bureau < 0.5 => 0.0383934373587211,
    nf_phone_ver_bureau >= 0.5                               => -0.0189595268147594,
    nf_phone_ver_bureau = NULL                               => -0.00847231433985924,
                                                                -0.00847231433985924));

lncu_tree_2_c1564 :=     __common__( map(
    NULL < nf_inq_ssn_lexid_diff01 AND nf_inq_ssn_lexid_diff01 < 0.5 => 0.0247236934988736,
    nf_inq_ssn_lexid_diff01 >= 0.5                                   => 0.116580389930969,
    nf_inq_ssn_lexid_diff01 = NULL                                   => 0.0507177919561124,
                                                                        0.0507177919561124));

lncu_tree_2 :=     __common__( map(
    NULL < rv_f00_inq_corrdobssn_adl AND rv_f00_inq_corrdobssn_adl < 4.5 => lncu_tree_2_c1563,
    rv_f00_inq_corrdobssn_adl >= 4.5                                     => lncu_tree_2_c1564,
    rv_f00_inq_corrdobssn_adl = NULL                                     => -0.0270796811502389,
                                                                            -0.00336086004374783));

lncu_tree_3_c1567 :=     __common__( map(
    (ip_routingmethod in ['06', '12', '13', '14', '15']) => -0.00914643983897194,
    (ip_routingmethod in ['', '02', '10', '11', '16'])   => 0.123648990812797,
    ip_routingmethod = ''                              => 0.029043590046645,
                                                            0.029043590046645));

lncu_tree_3_c1566 :=     __common__( map(
    NULL < nf_phone_ver_bureau AND nf_phone_ver_bureau < 0.5 => lncu_tree_3_c1567,
    nf_phone_ver_bureau >= 0.5                               => -0.029879550139595,
    nf_phone_ver_bureau = NULL                               => -0.0186206780865986,
                                                                -0.0186206780865986));

lncu_tree_3 :=     __common__( map(
    NULL < rv_i60_inq_comm_recency AND rv_i60_inq_comm_recency < 0.5 => lncu_tree_3_c1566,
    rv_i60_inq_comm_recency >= 0.5                                   => 0.0409558364041515,
    rv_i60_inq_comm_recency = NULL                                   => -0.00155586234342155,
                                                                        -0.00155586234342155));

lncu_tree_4_c1569 :=     __common__( map(
    (ip_routingmethod in ['06', '10', '12', '13', '14', '15', '16']) => 0.0162777253508064,
    (ip_routingmethod in ['', '02', '11'])                           => 0.113879300264193,
    ip_routingmethod = ''                                          => 0.0444534242977082,
                                                                        0.0444534242977082));

lncu_tree_4_c1570 :=     __common__( map(
    NULL < rv_f00_inq_corrdobssn_adl AND rv_f00_inq_corrdobssn_adl < 6.5 => -0.0122917154290555,
    rv_f00_inq_corrdobssn_adl >= 6.5                                     => 0.0562103034300563,
    rv_f00_inq_corrdobssn_adl = NULL                                     => -0.0403776165694715,
                                                                            -0.0124576843722562));

lncu_tree_4 :=     __common__( map(
    NULL < nf_phone_ver_bureau AND nf_phone_ver_bureau < 0.5 => lncu_tree_4_c1569,
    nf_phone_ver_bureau >= 0.5                               => lncu_tree_4_c1570,
    nf_phone_ver_bureau = NULL                               => -0.00160821740854954,
                                                                -0.00160821740854954));

lncu_tree_5_c1572 :=     __common__( map(
    NULL < nf_inq_perbestssn_count12 AND nf_inq_perbestssn_count12 < 10.5 => -0.021181100513187,
    nf_inq_perbestssn_count12 >= 10.5                                     => 0.0739804217611113,
    nf_inq_perbestssn_count12 = NULL                                      => -0.0160761352812796,
                                                                             -0.0160761352812796));

lncu_tree_5_c1573 :=     __common__( map(
    NULL < nf_fp_varrisktype AND nf_fp_varrisktype < 2.5 => 0.0142625930452589,
    nf_fp_varrisktype >= 2.5                             => 0.0867959486638615,
    nf_fp_varrisktype = NULL                             => 0.034237253934541,
                                                            0.034237253934541));

lncu_tree_5 :=     __common__( map(
    NULL < rv_i60_inq_comm_recency AND rv_i60_inq_comm_recency < 0.5 => lncu_tree_5_c1572,
    rv_i60_inq_comm_recency >= 0.5                                   => lncu_tree_5_c1573,
    rv_i60_inq_comm_recency = NULL                                   => -0.00165345839126755,
                                                                        -0.00165345839126755));

lncu_tree_6_c1575 :=     __common__( map(
    NULL < nf_phone_ver_bureau AND nf_phone_ver_bureau < 0.5 => 0.0237034226031006,
    nf_phone_ver_bureau >= 0.5                               => -0.0294218794222992,
    nf_phone_ver_bureau = NULL                               => -0.0194638106946306,
                                                                -0.0194638106946306));

lncu_tree_6_c1576 :=     __common__( map(
    NULL < rv_i60_inq_hiriskcred_count12 AND rv_i60_inq_hiriskcred_count12 < 3.5 => 0.0238171650285673,
    rv_i60_inq_hiriskcred_count12 >= 3.5                                         => 0.118073818964178,
    rv_i60_inq_hiriskcred_count12 = NULL                                         => 0.034246087842468,
                                                                                    0.034246087842468));

lncu_tree_6 :=     __common__( map(
    NULL < rv_i60_inq_comm_recency AND rv_i60_inq_comm_recency < 0.5 => lncu_tree_6_c1575,
    rv_i60_inq_comm_recency >= 0.5                                   => lncu_tree_6_c1576,
    rv_i60_inq_comm_recency = NULL                                   => -0.00360302963652739,
                                                                        -0.00360302963652739));

lncu_tree_7_c1579 :=     __common__( map(
    (ip_routingmethod in ['06', '10', '13', '14', '15']) => 0.044270582452291,
    (ip_routingmethod in ['', '02', '11', '12', '16'])   => 0.167308567156509,
    ip_routingmethod = ''                              => 0.0862048768645899,
                                                            0.0862048768645899));

lncu_tree_7_c1578 :=     __common__( map(
    (iv_f00_email_verification in ['2', '4', '5'])     => 0.000778650077287999,
    (iv_f00_email_verification in ['', '0', '1', '3']) => lncu_tree_7_c1579,
    iv_f00_email_verification = ''                   => 0.0379719685480742,
                                                          0.0379719685480742));

lncu_tree_7 :=     __common__( map(
    NULL < nf_phone_ver_bureau AND nf_phone_ver_bureau < 0.5 => lncu_tree_7_c1578,
    nf_phone_ver_bureau >= 0.5                               => -0.011524585306239,
    nf_phone_ver_bureau = NULL                               => -0.00210087787030065,
                                                                -0.00210087787030065));

lncu_tree_8_c1582 :=     __common__( map(
    NULL < rv_c14_addrs_5yr AND rv_c14_addrs_5yr < 3.5 => 0.00969533015407665,
    rv_c14_addrs_5yr >= 3.5                            => 0.144109622359091,
    rv_c14_addrs_5yr = NULL                            => 0.0206462152266453,
                                                          0.0206462152266453));

lncu_tree_8_c1581 :=     __common__( map(
    NULL < nf_inq_phone_ver_count AND nf_inq_phone_ver_count < 0.5 => lncu_tree_8_c1582,
    nf_inq_phone_ver_count >= 0.5                                  => -0.0219706859381555,
    nf_inq_phone_ver_count = NULL                                  => -0.0166825612254165,
                                                                      -0.0131490001247962));

lncu_tree_8 :=     __common__( map(
    NULL < nf_inq_per_phone AND nf_inq_per_phone < 3.5 => lncu_tree_8_c1581,
    nf_inq_per_phone >= 3.5                            => 0.0379917723190508,
    nf_inq_per_phone = NULL                            => -0.00445702700098851,
                                                          -0.00445702700098851));

lncu_tree_9_c1585 :=     __common__( map(
    (iv_f00_email_verification in ['1', '2', '4', '5']) => -0.00228965280661179,
    (iv_f00_email_verification in ['', '0', '3'])       => 0.0821187900287617,
    iv_f00_email_verification = ''                    => 0.0273786612592868,
                                                           0.0273786612592868));

lncu_tree_9_c1584 :=     __common__( map(
    NULL < nf_inq_corraddrphone AND nf_inq_corraddrphone < 0.5 => 0.219775093862902,
    nf_inq_corraddrphone >= 0.5                                => 0.0929659484777328,
    nf_inq_corraddrphone = NULL                                => lncu_tree_9_c1585,
                                                                  0.0405443118166032));

lncu_tree_9 :=     __common__( map(
    NULL < nf_inq_phone_ver_count AND nf_inq_phone_ver_count < 0.5 => lncu_tree_9_c1584,
    nf_inq_phone_ver_count >= 0.5                                  => -0.010377010712146,
    nf_inq_phone_ver_count = NULL                                  => -0.0324357164068891,
                                                                      -0.00221333671342914));

lncu_tree_10_c1588 :=     __common__( map(
    (nf_historic_x_current_ct in ['1-1', '2-2', '3-0', '3-1', '3-2', '3-3']) => -0.00511998468762734,
    (nf_historic_x_current_ct in ['', '0-0', '1-0', '2-0', '2-1'])           => 0.052984177221882,
    nf_historic_x_current_ct = ''                                          => 0.0135817371502193,
                                                                                0.0135817371502193));

lncu_tree_10_c1587 :=     __common__( map(
    NULL < (integer)iv_inf_phn_verd AND (integer)iv_inf_phn_verd < 0.5 => lncu_tree_10_c1588,
    (integer)iv_inf_phn_verd >= 0.5                           => -0.0321562857156359,
    (integer)iv_inf_phn_verd = NULL                           => -0.0103242142226923,
                                                        -0.0103242142226923));

lncu_tree_10 :=     __common__( map(
    NULL < nf_fp_srchvelocityrisktype AND nf_fp_srchvelocityrisktype < 7.5 => lncu_tree_10_c1587,
    nf_fp_srchvelocityrisktype >= 7.5                                      => 0.0452919480548911,
    nf_fp_srchvelocityrisktype = NULL                                      => -0.00202690273487772,
                                                                              -0.00202690273487772));

lncu_tree_11_c1590 :=     __common__( map(
    NULL < nf_fp_varrisktype AND nf_fp_varrisktype < 1.5 => -0.0328429057974625,
    nf_fp_varrisktype >= 1.5                             => 0.0130851274852423,
    nf_fp_varrisktype = NULL                             => -0.0150924882925856,
                                                            -0.0150924882925856));

lncu_tree_11_c1591 :=     __common__( map(
    NULL < nf_inq_phone_ver_count AND nf_inq_phone_ver_count < 0.5 => 0.0860747611058407,
    nf_inq_phone_ver_count >= 0.5                                  => 0.012583802892286,
    nf_inq_phone_ver_count = NULL                                  => 0.0612700239385796,
                                                                      0.0277891497326042));

lncu_tree_11 :=     __common__( map(
    (ip_routingmethod in ['', '06', '12', '13', '14', '15']) => lncu_tree_11_c1590,
    (ip_routingmethod in ['02', '10', '11', '16'])           => lncu_tree_11_c1591,
    ip_routingmethod = ''                                  => -0.00319459663759771,
                                                                -0.00319459663759771));

lncu_tree_12_c1593 :=     __common__( map(
    (nf_historic_x_current_ct in ['2-0', '2-1', '2-2', '3-0', '3-1', '3-2', '3-3']) => -0.0297633659639006,
    (nf_historic_x_current_ct in ['', '0-0', '1-0', '1-1'])                         => 0.0137492366689755,
    nf_historic_x_current_ct = ''                                                 => -0.0155300495718665,
                                                                                       -0.0155300495718665));

lncu_tree_12_c1594 :=     __common__( map(
    NULL < nf_inq_highriskcredit_count24 AND nf_inq_highriskcredit_count24 < 3.5 => 0.013107442405961,
    nf_inq_highriskcredit_count24 >= 3.5                                         => 0.0833031410701575,
    nf_inq_highriskcredit_count24 = NULL                                         => 0.0281641842133954,
                                                                                    0.0281641842133954));

lncu_tree_12 :=     __common__( map(
    NULL < rv_i60_inq_comm_recency AND rv_i60_inq_comm_recency < 0.5 => lncu_tree_12_c1593,
    rv_i60_inq_comm_recency >= 0.5                                   => lncu_tree_12_c1594,
    rv_i60_inq_comm_recency = NULL                                   => -0.00289430538662463,
                                                                        -0.00289430538662463));

lncu_tree_13_c1597 :=     __common__( map(
    NULL < nf_inq_adls_per_apt_addr AND nf_inq_adls_per_apt_addr < 1.5 => 0.0130882240227109,
    nf_inq_adls_per_apt_addr >= 1.5                                    => 0.151245537899762,
    nf_inq_adls_per_apt_addr = NULL                                    => 0.0176037968684838,
                                                                          0.0176037968684838));

lncu_tree_13_c1596 :=     __common__( map(
    NULL < nf_fp_idverrisktype AND nf_fp_idverrisktype < 1.5 => -0.0200834388602974,
    nf_fp_idverrisktype >= 1.5                               => lncu_tree_13_c1597,
    nf_fp_idverrisktype = NULL                               => -0.00582554752170561,
                                                                -0.00582554752170561));

lncu_tree_13 :=     __common__( map(
    NULL < nf_fp_varrisktype AND nf_fp_varrisktype < 3.5 => lncu_tree_13_c1596,
    nf_fp_varrisktype >= 3.5                             => 0.0486697218377901,
    nf_fp_varrisktype = NULL                             => 0.000427383781247159,
                                                            0.000427383781247159));

lncu_tree_14_c1600 :=     __common__( map(
    NULL < nf_inq_corrnamephone AND nf_inq_corrnamephone < 0.5 => 0.198605505020529,
    nf_inq_corrnamephone >= 0.5                                => 0.0350151169543878,
    nf_inq_corrnamephone = NULL                                => 0.0562137957825927,
                                                                  0.0689554631520261));

lncu_tree_14_c1599 :=     __common__( map(
    (iv_f00_email_verification in ['2', '5'])               => -0.00277598036981525,
    (iv_f00_email_verification in ['', '0', '1', '3', '4']) => lncu_tree_14_c1600,
    iv_f00_email_verification = ''                        => 0.0301416709117897,
                                                               0.0301416709117897));

lncu_tree_14 :=     __common__( map(
    NULL < nf_phone_ver_bureau AND nf_phone_ver_bureau < 0.5 => lncu_tree_14_c1599,
    nf_phone_ver_bureau >= 0.5                               => -0.0103021459808742,
    nf_phone_ver_bureau = NULL                               => -0.00270245018010272,
                                                                -0.00270245018010272));

lncu_tree_15_c1602 :=     __common__( map(
    NULL < nf_inq_adlsperphone_count_week AND nf_inq_adlsperphone_count_week < 0.5 => 0.0153568623582237,
    nf_inq_adlsperphone_count_week >= 0.5                                          => 0.153913763908615,
    nf_inq_adlsperphone_count_week = NULL                                          => 0.0174596850914664,
                                                                                      0.0174596850914664));

lncu_tree_15_c1603 :=     __common__( map(
    NULL < nf_inq_per_phone AND nf_inq_per_phone < 7.5 => -0.0242445928318426,
    nf_inq_per_phone >= 7.5                            => 0.0707257239013516,
    nf_inq_per_phone = NULL                            => -0.01934114155555,
                                                          -0.01934114155555));

lncu_tree_15 :=     __common__( map(
    NULL < nf_m_src_credentialed_fs AND nf_m_src_credentialed_fs < 203.5 => lncu_tree_15_c1602,
    nf_m_src_credentialed_fs >= 203.5                                    => lncu_tree_15_c1603,
    nf_m_src_credentialed_fs = NULL                                      => 0.00136789505451015,
                                                                            0.00136789505451015));

lncu_tree_16_c1605 :=     __common__( map(
    (nf_historic_x_current_ct in ['1-0', '1-1', '2-1', '2-2', '3-1', '3-2', '3-3']) => -0.017525884572267,
    (nf_historic_x_current_ct in ['', '0-0', '2-0', '3-0'])                         => 0.0197403754119458,
    nf_historic_x_current_ct = ''                                                 => -0.00762225726803173,
                                                                                       -0.00762225726803173));

lncu_tree_16_c1606 :=     __common__( map(
    NULL < nf_inq_corrphonessn AND nf_inq_corrphonessn < 0.5 => 0.128097298638019,
    nf_inq_corrphonessn >= 0.5                               => 0.0351623836785854,
    nf_inq_corrphonessn = NULL                               => 0.0247599030194424,
                                                                0.0482510581168237));

lncu_tree_16 :=     __common__( map(
    NULL < nf_fp_varrisktype AND nf_fp_varrisktype < 3.5 => lncu_tree_16_c1605,
    nf_fp_varrisktype >= 3.5                             => lncu_tree_16_c1606,
    nf_fp_varrisktype = NULL                             => -0.00145363502600809,
                                                            -0.00145363502600809));

lncu_tree_17_c1608 :=     __common__( map(
    NULL < nf_inq_corrdobphone AND nf_inq_corrdobphone < 0.5 => 0.0549978686579718,
    nf_inq_corrdobphone >= 0.5                               => -0.00169279610036772,
    nf_inq_corrdobphone = NULL                               => -0.0134019570374438,
                                                                -0.00496817450858886));

lncu_tree_17_c1609 :=     __common__( map(
    NULL < nf_inq_dob_ver_count AND nf_inq_dob_ver_count < 13.5 => -0.015177545803614,
    nf_inq_dob_ver_count >= 13.5                                => 0.13968377990331,
    nf_inq_dob_ver_count = NULL                                 => 0.0918870744382099,
                                                                   0.0918870744382099));

lncu_tree_17 :=     __common__( map(
    NULL < nf_inq_communications_count24 AND nf_inq_communications_count24 < 1.5 => lncu_tree_17_c1608,
    nf_inq_communications_count24 >= 1.5                                         => lncu_tree_17_c1609,
    nf_inq_communications_count24 = NULL                                         => -0.00253213191747235,
                                                                                    -0.00253213191747235));

lncu_tree_18_c1611 :=     __common__( map(
    (ip_topleveldomain_lvl in ['-1', 'EDU', 'GOV', 'NET', 'TWO', 'US']) => -0.0291619354490005,
    (ip_topleveldomain_lvl in ['', 'COM', 'DOT', 'ORG', 'OTH'])         => 0.00381496529708544,
    ip_topleveldomain_lvl = ''                                        => -0.0154489116453673,
                                                                           -0.0154489116453673));

lncu_tree_18_c1612 :=     __common__( map(
    NULL < nf_inq_dob_ver_count AND nf_inq_dob_ver_count < 21.5 => 0.00387303281546336,
    nf_inq_dob_ver_count >= 21.5                                => 0.0551728439538229,
    nf_inq_dob_ver_count = NULL                                 => 0.0211603288725108,
                                                                   0.0211603288725108));

lncu_tree_18 :=     __common__( map(
    NULL < rv_i60_inq_comm_recency AND rv_i60_inq_comm_recency < 0.5 => lncu_tree_18_c1611,
    rv_i60_inq_comm_recency >= 0.5                                   => lncu_tree_18_c1612,
    rv_i60_inq_comm_recency = NULL                                   => -0.00481703131801767,
                                                                        -0.00481703131801767));

lncu_tree_19_c1615 :=     __common__( map(
    NULL < nf_inq_phone_ver_count AND nf_inq_phone_ver_count < 0.5 => 0.0760972060226121,
    nf_inq_phone_ver_count >= 0.5                                  => 0.0189082853907813,
    nf_inq_phone_ver_count = NULL                                  => 0.00185524557567093,
                                                                      0.0278385169488234));

lncu_tree_19_c1614 :=     __common__( map(
    NULL < rv_l79_adls_per_sfd_addr_c6 AND rv_l79_adls_per_sfd_addr_c6 < 1.5 => -0.0104136967500145,
    rv_l79_adls_per_sfd_addr_c6 >= 1.5                                       => lncu_tree_19_c1615,
    rv_l79_adls_per_sfd_addr_c6 = NULL                                       => -0.00210491456782931,
                                                                                -0.00210491456782931));

lncu_tree_19 :=     __common__( map(
    NULL < nf_inq_highriskcredit_count_week AND nf_inq_highriskcredit_count_week < 0.5 => lncu_tree_19_c1614,
    nf_inq_highriskcredit_count_week >= 0.5                                            => 0.0929132998496113,
    nf_inq_highriskcredit_count_week = NULL                                            => 0.000683230522202716,
                                                                                          0.000683230522202716));

lncu_tree_20_c1618 :=     __common__( map(
    NULL < nf_unvrfd_search_risk_index AND nf_unvrfd_search_risk_index < 8.5 => -0.00512637082517585,
    nf_unvrfd_search_risk_index >= 8.5                                       => 0.073962296726823,
    nf_unvrfd_search_risk_index = NULL                                       => 0.00565300334899865,
                                                                                0.00565300334899865));

lncu_tree_20_c1617 :=     __common__( map(
    NULL < iv_nap_inf_phone_ver_lvl AND iv_nap_inf_phone_ver_lvl < 0.5 => 0.0502807032008231,
    iv_nap_inf_phone_ver_lvl >= 0.5                                    => lncu_tree_20_c1618,
    iv_nap_inf_phone_ver_lvl = NULL                                    => 0.0176355284060949,
                                                                          0.0176355284060949));

lncu_tree_20 :=     __common__( map(
    (ip_topleveldomain_lvl in ['', '-1', 'DOT', 'EDU', 'GOV', 'NET', 'ORG', 'TWO']) => -0.0108363972290308,
    (ip_topleveldomain_lvl in ['COM', 'OTH', 'US'])                                 => lncu_tree_20_c1617,
    ip_topleveldomain_lvl = ''                                                   => 0.00113144057865972,
                                                                                       0.00113144057865972));

lncu_tree_21_c1620 :=     __common__( map(
    NULL < iv_nap_inf_phone_ver_lvl AND iv_nap_inf_phone_ver_lvl < 0.5 => 0.0193134792775837,
    iv_nap_inf_phone_ver_lvl >= 0.5                                    => -0.01760775430531,
    iv_nap_inf_phone_ver_lvl = NULL                                    => -0.00865794291383822,
                                                                          -0.00865794291383822));

lncu_tree_21_c1621 :=     __common__( map(
    NULL < nf_fp_srchcomponentrisktype AND nf_fp_srchcomponentrisktype < 7.5 => 0.0322511026313635,
    nf_fp_srchcomponentrisktype >= 7.5                                       => 0.145267685290042,
    nf_fp_srchcomponentrisktype = NULL                                       => 0.0401275780212586,
                                                                                0.0401275780212586));

lncu_tree_21 :=     __common__( map(
    NULL < nf_inq_ssn_lexid_diff01 AND nf_inq_ssn_lexid_diff01 < 0.5 => lncu_tree_21_c1620,
    nf_inq_ssn_lexid_diff01 >= 0.5                                   => lncu_tree_21_c1621,
    nf_inq_ssn_lexid_diff01 = NULL                                   => -0.00273582596704441,
                                                                        -0.00273582596704441));

lncu_tree_22_c1623 :=     __common__( map(
    NULL < nf_fp_srchunvrfdphonecount AND nf_fp_srchunvrfdphonecount < 2.5 => 0.0152784277408167,
    nf_fp_srchunvrfdphonecount >= 2.5                                      => 0.0906948681349474,
    nf_fp_srchunvrfdphonecount = NULL                                      => 0.0178435242114043,
                                                                              0.0178435242114043));

lncu_tree_22_c1624 :=     __common__( map(
    NULL < rv_i62_inq_dobsperadl_1dig AND rv_i62_inq_dobsperadl_1dig < 1 => -0.012018637980207,
    rv_i62_inq_dobsperadl_1dig >= 1                                      => 0.0770202630743937,
    rv_i62_inq_dobsperadl_1dig = NULL                                    => -0.0329934892904422,
                                                                            -0.0158011627273719));

lncu_tree_22 :=     __common__( map(
    NULL < iv_fname_non_phn_src_ct AND iv_fname_non_phn_src_ct < 9.5 => lncu_tree_22_c1623,
    iv_fname_non_phn_src_ct >= 9.5                                   => lncu_tree_22_c1624,
    iv_fname_non_phn_src_ct = NULL                                   => -0.000678546962247567,
                                                                        -0.000678546962247567));

lncu_tree_23_c1627 :=     __common__( map(
    (nf_historic_x_current_ct in ['2-1', '3-0', '3-1', '3-2', '3-3'])     => -0.029856347689616,
    (nf_historic_x_current_ct in ['', '0-0', '1-0', '1-1', '2-0', '2-2']) => 0.00229266196416457,
    nf_historic_x_current_ct = ''                                      => -0.0181130607501221,
                                                                             -0.0181130607501221));

lncu_tree_23_c1626 :=     __common__( map(
    NULL < nf_inq_banking_count24 AND nf_inq_banking_count24 < 2.5 => lncu_tree_23_c1627,
    nf_inq_banking_count24 >= 2.5                                  => 0.0273506960422622,
    nf_inq_banking_count24 = NULL                                  => -0.0117749391899275,
                                                                      -0.0117749391899275));

lncu_tree_23 :=     __common__( map(
    NULL < nf_util_adl_count AND nf_util_adl_count < 13.5 => lncu_tree_23_c1626,
    nf_util_adl_count >= 13.5                             => 0.0459110836270489,
    nf_util_adl_count = NULL                              => -0.00512953802082383,
                                                             -0.00512953802082383));

lncu_tree_24_c1629 :=     __common__( map(
    NULL < nf_inq_ssn_lexid_diff01 AND nf_inq_ssn_lexid_diff01 < 2.5 => -0.0164630062690993,
    nf_inq_ssn_lexid_diff01 >= 2.5                                   => 0.0841367881281315,
    nf_inq_ssn_lexid_diff01 = NULL                                   => -0.0144668076365204,
                                                                        -0.0144668076365204));

lncu_tree_24_c1630 :=     __common__( map(
    NULL < nf_inq_communications_count24 AND nf_inq_communications_count24 < 1.5 => 0.0144728631492169,
    nf_inq_communications_count24 >= 1.5                                         => 0.0935773810639489,
    nf_inq_communications_count24 = NULL                                         => 0.0171222324163373,
                                                                                    0.0171222324163373));

lncu_tree_24 :=     __common__( map(
    NULL < rv_c14_addrs_10yr AND rv_c14_addrs_10yr < 2.5 => lncu_tree_24_c1629,
    rv_c14_addrs_10yr >= 2.5                             => lncu_tree_24_c1630,
    rv_c14_addrs_10yr = NULL                             => -4.86549562294692e-05,
                                                            -4.86549562294692e-05));

lncu_tree_25_c1633 :=     __common__( map(
    NULL < nf_inq_phone_ver_count AND nf_inq_phone_ver_count < 0.5 => 0.0213854427959793,
    nf_inq_phone_ver_count >= 0.5                                  => -0.0168368857047949,
    nf_inq_phone_ver_count = NULL                                  => -0.00978827105029484,
                                                                      -0.00957739973038086));

lncu_tree_25_c1632 :=     __common__( map(
    NULL < nf_inq_ssn_lexid_diff01 AND nf_inq_ssn_lexid_diff01 < 0.5 => lncu_tree_25_c1633,
    nf_inq_ssn_lexid_diff01 >= 0.5                                   => 0.0314772836795026,
    nf_inq_ssn_lexid_diff01 = NULL                                   => -0.00447455772463263,
                                                                        -0.00447455772463263));

lncu_tree_25 :=     __common__( map(
    NULL < nf_inq_communications_count24 AND nf_inq_communications_count24 < 2.5 => lncu_tree_25_c1632,
    nf_inq_communications_count24 >= 2.5                                         => 0.113696752986646,
    nf_inq_communications_count24 = NULL                                         => -0.00317234399492585,
                                                                                    -0.00317234399492585));

lncu_tree_26_c1635 :=     __common__( map(
    (ip_routingmethod in ['06', '10', '13', '14', '15']) => 0.024108302288322,
    (ip_routingmethod in ['', '02', '11', '12', '16'])   => 0.158429058857783,
    ip_routingmethod = ''                              => 0.0588708924568268,
                                                            0.0588708924568268));

lncu_tree_26_c1636 :=     __common__( map(
    NULL < nf_inq_highriskcredit_count24 AND nf_inq_highriskcredit_count24 < 1.5 => -0.0215898947099148,
    nf_inq_highriskcredit_count24 >= 1.5                                         => 0.0277286470825708,
    nf_inq_highriskcredit_count24 = NULL                                         => 0.00426015780596975,
                                                                                    0.00426015780596975));

lncu_tree_26 :=     __common__( map(
    NULL < nf_inq_corrdobphone AND nf_inq_corrdobphone < 0.5 => lncu_tree_26_c1635,
    nf_inq_corrdobphone >= 0.5                               => lncu_tree_26_c1636,
    nf_inq_corrdobphone = NULL                               => -0.00761328261684942,
                                                                0.000942244763297215));

lncu_tree_27_c1639 :=     __common__( map(
    (rv_6seg_riskview_5_0 in ['1 VER/VAL PROBLEMS', '3 ADDR NOT CURRENT - OTHER', '4 SUFFICIENTLY VERD - DEROG', '5 SUFFICIENTLY VERD - OWNER', '6 SUFFICIENTLY VERD - OTHER']) => 0.0148955826807769,
    (rv_6seg_riskview_5_0 in ['0 TRUEDID = 0', '2 ADDR NOT CURRENT - DEROG'])                                                                                                   => 0.112795278265825,
    rv_6seg_riskview_5_0 = ''                                                                                                                                                 => 0.0188459724222224,
                                                                                                                                                                                   0.0188459724222224));

lncu_tree_27_c1638 :=     __common__( map(
    NULL < rv_l79_adls_per_addr_curr AND rv_l79_adls_per_addr_curr < 2.25 => -0.0148674736868926,
    rv_l79_adls_per_addr_curr >= 2.25                                     => lncu_tree_27_c1639,
    rv_l79_adls_per_addr_curr = NULL                                      => 0.00736975908356666,
                                                                             0.00736975908356666));

lncu_tree_27 :=     __common__( map(
    NULL < rv_d34_liens_rel_total_amt AND rv_d34_liens_rel_total_amt < 434 => lncu_tree_27_c1638,
    rv_d34_liens_rel_total_amt >= 434                                      => -0.028275200941907,
    rv_d34_liens_rel_total_amt = NULL                                      => -9.68637540675022e-05,
                                                                              -9.68637540675022e-05));

lncu_tree_28_c1642 :=     __common__( map(
    NULL < ip_state_match AND ip_state_match < 0.5 => 0.088555460124731,
    ip_state_match >= 0.5                          => 0.0194373090874227,
    ip_state_match = NULL                          => 0.0382322811390831,
                                                      0.0382322811390831));

lncu_tree_28_c1641 :=     __common__( map(
    (nf_historic_x_current_ct in ['', '2-0', '2-1', '3-1', '3-2', '3-3']) => -0.00138395138604941,
    (nf_historic_x_current_ct in ['0-0', '1-0', '1-1', '2-2', '3-0'])     => lncu_tree_28_c1642,
    nf_historic_x_current_ct = ''                                       => 0.0126281741521006,
                                                                             0.0126281741521006));

lncu_tree_28 :=     __common__( map(
    (ip_routingmethod in ['', '06', '10', '13', '14', '16']) => -0.0132987098226746,
    (ip_routingmethod in ['02', '11', '12', '15'])           => lncu_tree_28_c1641,
    ip_routingmethod = ''                                  => -0.00233629556992103,
                                                                -0.00233629556992103));

lncu_tree_29_c1644 :=     __common__( map(
    NULL < rv_c14_addrs_10yr AND rv_c14_addrs_10yr < 8.5 => -0.006600208488189,
    rv_c14_addrs_10yr >= 8.5                             => 0.0610022177054812,
    rv_c14_addrs_10yr = NULL                             => -0.00429159221405409,
                                                            -0.00429159221405409));

lncu_tree_29_c1645 :=     __common__( map(
    NULL < nf_inq_per_ssn AND nf_inq_per_ssn < 8.5 => 0.162861331993693,
    nf_inq_per_ssn >= 8.5                          => 0.0116569551473585,
    nf_inq_per_ssn = NULL                          => 0.063359096907718,
                                                      0.063359096907718));

lncu_tree_29 :=     __common__( map(
    NULL < nf_inq_per_phone AND nf_inq_per_phone < 8.5 => lncu_tree_29_c1644,
    nf_inq_per_phone >= 8.5                            => lncu_tree_29_c1645,
    nf_inq_per_phone = NULL                            => -0.00183435346685646,
                                                          -0.00183435346685646));

lncu_tree_30_c1648 :=     __common__( map(
    NULL < rv_c14_addrs_15yr AND rv_c14_addrs_15yr < 2.5 => -0.0264381111013586,
    rv_c14_addrs_15yr >= 2.5                             => 0.00519232950374907,
    rv_c14_addrs_15yr = NULL                             => -0.00655479905485458,
                                                            -0.00655479905485458));

lncu_tree_30_c1647 :=     __common__( map(
    NULL < rv_i62_inq_phones_per_adl AND rv_i62_inq_phones_per_adl < 2.5 => lncu_tree_30_c1648,
    rv_i62_inq_phones_per_adl >= 2.5                                     => 0.0503134520281088,
    rv_i62_inq_phones_per_adl = NULL                                     => -0.0046535374819977,
                                                                            -0.0046535374819977));

lncu_tree_30 :=     __common__( map(
    NULL < nf_inq_ssnspercurraddr_count12 AND nf_inq_ssnspercurraddr_count12 < 5.5 => lncu_tree_30_c1647,
    nf_inq_ssnspercurraddr_count12 >= 5.5                                          => 0.129408950929053,
    nf_inq_ssnspercurraddr_count12 = NULL                                          => -0.00319656275931899,
                                                                                      -0.00319656275931899));

lncu_tree_31_c1650 :=     __common__( map(
    NULL < rv_f00_inq_corrdobaddr_adl AND rv_f00_inq_corrdobaddr_adl < 2.5 => -0.0186205660296321,
    rv_f00_inq_corrdobaddr_adl >= 2.5                                      => 0.0135516816616584,
    rv_f00_inq_corrdobaddr_adl = NULL                                      => -0.0270801720048553,
                                                                              -0.0124562402717022));

lncu_tree_31_c1651 :=     __common__( map(
    NULL < nf_fpc_idver_addressmatchescurr AND nf_fpc_idver_addressmatchescurr < 0.5 => 0.0764867448346158,
    nf_fpc_idver_addressmatchescurr >= 0.5                                           => 0.0110608666852982,
    nf_fpc_idver_addressmatchescurr = NULL                                           => 0.0215127185888198,
                                                                                        0.0215127185888198));

lncu_tree_31 :=     __common__( map(
    (iv_f00_email_verification in ['', '2', '3', '4', '5']) => lncu_tree_31_c1650,
    (iv_f00_email_verification in ['0', '1'])               => lncu_tree_31_c1651,
    iv_f00_email_verification = ''                        => -0.00483614804205359,
                                                               -0.00483614804205359));

lncu_tree_32_c1654 :=     __common__( map(
    (nf_historic_x_current_ct in ['1-0', '1-1', '2-0', '2-1', '2-2', '3-0', '3-1', '3-2', '3-3']) => 0.0299390843619368,
    (nf_historic_x_current_ct in ['', '0-0'])                                                     => 0.12029929687334,
    nf_historic_x_current_ct = ''                                                              => 0.0570105650333695,
                                                                                                     0.0570105650333695));

lncu_tree_32_c1653 :=     __common__( map(
    NULL < nf_phone_ver_bureau AND nf_phone_ver_bureau < 0.5 => lncu_tree_32_c1654,
    nf_phone_ver_bureau >= 0.5                               => 0.010196388854043,
    nf_phone_ver_bureau = NULL                               => 0.019810941112602,
                                                                0.019810941112602));

lncu_tree_32 :=     __common__( map(
    (ip_routingmethod in ['', '06', '13', '14', '15'])   => -0.0120035591396623,
    (ip_routingmethod in ['02', '10', '11', '12', '16']) => lncu_tree_32_c1653,
    ip_routingmethod = ''                              => -0.00309737457478317,
                                                            -0.00309737457478317));

lncu_tree_33_c1657 :=     __common__( map(
    NULL < nf_phone_ver_bureau AND nf_phone_ver_bureau < -0.5 => -0.0723422991416602,
    nf_phone_ver_bureau >= -0.5                               => 0.0128659484861414,
    nf_phone_ver_bureau = NULL                                => 0.0105787345916472,
                                                                 0.0105787345916472));

lncu_tree_33_c1656 :=     __common__( map(
    (rv_d31_mostrec_bk in ['2 - BK DISCHARGED', '3 - BK OTHER']) => -0.0224288949961172,
    (rv_d31_mostrec_bk in ['', '0 - NO BK', '1 - BK DISMISSED']) => lncu_tree_33_c1657,
    rv_d31_mostrec_bk = ''                                     => 0.000703352702910972,
                                                                    0.000703352702910972));

lncu_tree_33 :=     __common__( map(
    NULL < nf_inq_ssn_lexid_diff01 AND nf_inq_ssn_lexid_diff01 < 3.5 => lncu_tree_33_c1656,
    nf_inq_ssn_lexid_diff01 >= 3.5                                   => 0.0999696653415531,
    nf_inq_ssn_lexid_diff01 = NULL                                   => 0.00164360814871177,
                                                                        0.00164360814871177));

lncu_tree_34_c1660 :=     __common__( map(
    NULL < ip_state_match AND ip_state_match < 0.5 => 0.0706728850727681,
    ip_state_match >= 0.5                          => 0.00658245853797656,
    ip_state_match = NULL                          => 0.0156299944118032,
                                                      0.0156299944118032));

lncu_tree_34_c1659 :=     __common__( map(
    (nf_historic_x_current_ct in ['1-0', '1-1', '2-0', '2-1', '3-0', '3-1', '3-2', '3-3']) => -0.0136549215413373,
    (nf_historic_x_current_ct in ['', '0-0', '2-2'])                                       => lncu_tree_34_c1660,
    nf_historic_x_current_ct = ''                                                        => -0.00576513996932491,
                                                                                              -0.00576513996932491));

lncu_tree_34 :=     __common__( map(
    NULL < nf_inq_per_phone AND nf_inq_per_phone < 3.5 => lncu_tree_34_c1659,
    nf_inq_per_phone >= 3.5                            => 0.0259914499735856,
    nf_inq_per_phone = NULL                            => -0.000486843991935736,
                                                          -0.000486843991935736));

lncu_tree_35_c1662 :=     __common__( map(
    NULL < rv_d34_liens_rel_total_amt84 AND rv_d34_liens_rel_total_amt84 < 463.5 => 0.037215433689816,
    rv_d34_liens_rel_total_amt84 >= 463.5                                        => -0.0659505098636378,
    rv_d34_liens_rel_total_amt84 = NULL                                          => 0.0255770092256438,
                                                                                    0.0255770092256438));

lncu_tree_35_c1663 :=     __common__( map(
    NULL < nf_inq_corrdobphone AND nf_inq_corrdobphone < 0.5 => 0.0458089722639651,
    nf_inq_corrdobphone >= 0.5                               => -0.0102173859028388,
    nf_inq_corrdobphone = NULL                               => -0.0117143836598412,
                                                                -0.00853012395642219));

lncu_tree_35 :=     __common__( map(
    NULL < rv_d33_eviction_recency AND rv_d33_eviction_recency < 549 => lncu_tree_35_c1662,
    rv_d33_eviction_recency >= 549                                   => lncu_tree_35_c1663,
    rv_d33_eviction_recency = NULL                                   => -0.00334376410982844,
                                                                        -0.00334376410982844));

lncu_tree_36_c1666 :=     __common__( map(
    (nf_historic_x_current_ct in ['2-2', '3-1', '3-2', '3-3'])                   => -0.00521373489813363,
    (nf_historic_x_current_ct in ['', '0-0', '1-0', '1-1', '2-0', '2-1', '3-0']) => 0.0343617023541202,
    nf_historic_x_current_ct = ''                                              => 0.0105338347257708,
                                                                                    0.0105338347257708));

lncu_tree_36_c1665 :=     __common__( map(
    NULL < (INTEGER)iv_inf_phn_verd AND (INTEGER)iv_inf_phn_verd < 0.5 => lncu_tree_36_c1666,
    (INTEGER)iv_inf_phn_verd >= 0.5                           => -0.0208021384935316,
    (INTEGER)iv_inf_phn_verd = null                           => -0.00583290545639204,
                                                        -0.00583290545639204));

lncu_tree_36 :=     __common__( map(
    NULL < nf_unvrfd_search_risk_index AND nf_unvrfd_search_risk_index < 6.5 => lncu_tree_36_c1665,
    nf_unvrfd_search_risk_index >= 6.5                                       => 0.0335390627055118,
    nf_unvrfd_search_risk_index = NULL                                       => -0.00017079781153307,
                                                                                -0.00017079781153307));

lncu_tree_37_c1668 :=     __common__( map(
    NULL < rv_c14_addrs_5yr AND rv_c14_addrs_5yr < 5.5 => 0.0118432425155742,
    rv_c14_addrs_5yr >= 5.5                            => 0.107083420709276,
    rv_c14_addrs_5yr = NULL                            => 0.0137720000030835,
                                                          0.0137720000030835));

lncu_tree_37_c1669 :=     __common__( map(
    NULL < nf_inq_banking_count24 AND nf_inq_banking_count24 < 5.5 => -0.0177245183515937,
    nf_inq_banking_count24 >= 5.5                                  => 0.0714101706905702,
    nf_inq_banking_count24 = NULL                                  => -0.0154829655206517,
                                                                      -0.0154829655206517));

lncu_tree_37 :=     __common__( map(
    NULL < (INTEGER)iv_inf_phn_verd AND (INTEGER)iv_inf_phn_verd < 0.5 => lncu_tree_37_c1668,
    (INTEGER)iv_inf_phn_verd >= 0.5                           => lncu_tree_37_c1669,
    (INTEGER)iv_inf_phn_verd = NULL                           => -0.00157936842447381,
                                                        -0.00157936842447381));

lncu_tree_38_c1671 :=     __common__( map(
    NULL < nf_inq_perphone_count_week AND nf_inq_perphone_count_week < 0.5 => -0.00721054759582997,
    nf_inq_perphone_count_week >= 0.5                                      => 0.050466241966039,
    nf_inq_perphone_count_week = NULL                                      => -0.00472442992415673,
                                                                              -0.00472442992415673));

lncu_tree_38_c1672 :=     __common__( map(
    NULL < nf_invbest_inq_peraddr_diff AND nf_invbest_inq_peraddr_diff < 0.5 => 0.0218760105930844,
    nf_invbest_inq_peraddr_diff >= 0.5                                       => 0.1116592887846,
    nf_invbest_inq_peraddr_diff = NULL                                       => 0.0268080880362035,
                                                                                0.0268080880362035));

lncu_tree_38 :=     __common__( map(
    NULL < rv_l79_adls_per_sfd_addr_c6 AND rv_l79_adls_per_sfd_addr_c6 < 1.5 => lncu_tree_38_c1671,
    rv_l79_adls_per_sfd_addr_c6 >= 1.5                                       => lncu_tree_38_c1672,
    rv_l79_adls_per_sfd_addr_c6 = NULL                                       => 0.00204826184067708,
                                                                                0.00204826184067708));

lncu_tree_39_c1674 :=     __common__( map(
    (iv_d34_liens_unrel_x_rel in ['0-0', '0-1', '0-2', '1-0', '1-1', '1-2', '2-0', '2-1', '2-2', '3-2']) => -0.00610583513855389,
    (iv_d34_liens_unrel_x_rel in ['', '3-0', '3-1'])                                                     => 0.0368869739321468,
    iv_d34_liens_unrel_x_rel = ''                                                                      => -0.00262938311321972,
                                                                                                            -0.00262938311321972));

lncu_tree_39_c1675 :=     __common__( map(
    NULL < rv_i61_inq_collection_count12 AND rv_i61_inq_collection_count12 < 0.5 => 0.0252168213546581,
    rv_i61_inq_collection_count12 >= 0.5                                         => 0.156706659188995,
    rv_i61_inq_collection_count12 = NULL                                         => 0.0663073956778883,
                                                                                    0.0663073956778883));

lncu_tree_39 :=     __common__( map(
    NULL < rv_l79_adls_per_addr_c6 AND rv_l79_adls_per_addr_c6 < 4.5 => lncu_tree_39_c1674,
    rv_l79_adls_per_addr_c6 >= 4.5                                   => lncu_tree_39_c1675,
    rv_l79_adls_per_addr_c6 = NULL                                   => -0.000747150245203117,
                                                                        -0.000747150245203117));

lncu_tree_40_c1678 :=     __common__( map(
    (ip_routingmethod in ['06', '11', '12', '13', '14']) => 0.00661659703825916,
    (ip_routingmethod in ['', '02', '10', '15', '16'])   => 0.109872674832994,
    ip_routingmethod = ''                              => 0.00916540920918629,
                                                            0.00916540920918629));

lncu_tree_40_c1677 :=     __common__( map(
    (ip_topleveldomain_lvl in ['', '-1', 'DOT', 'EDU', 'GOV', 'NET', 'TWO']) => -0.0168909685201537,
    (ip_topleveldomain_lvl in ['COM', 'ORG', 'OTH', 'US'])                   => lncu_tree_40_c1678,
    ip_topleveldomain_lvl = ''                                             => -0.00575721678024972,
                                                                                -0.00575721678024972));

lncu_tree_40 :=     __common__( map(
    NULL < nf_util_adl_count AND nf_util_adl_count < 20.5 => lncu_tree_40_c1677,
    nf_util_adl_count >= 20.5                             => 0.0606154275930146,
    nf_util_adl_count = NULL                              => -0.00337186132384816,
                                                             -0.00337186132384816));

lncu_tree_41_c1681 :=     __common__( map(
    NULL < nf_inq_adls_per_phone AND nf_inq_adls_per_phone < 1.5 => 0.0170448246687419,
    nf_inq_adls_per_phone >= 1.5                                 => 0.110445030519845,
    nf_inq_adls_per_phone = NULL                                 => 0.0213068078858598,
                                                                    0.0213068078858598));

lncu_tree_41_c1680 :=     __common__( map(
    NULL < nf_inq_phone_ver_count AND nf_inq_phone_ver_count < 2.5 => lncu_tree_41_c1681,
    nf_inq_phone_ver_count >= 2.5                                  => -0.00301772756839431,
    nf_inq_phone_ver_count = NULL                                  => 0.00434710714609391,
                                                                      0.00434710714609391));

lncu_tree_41 :=     __common__( map(
    NULL < nf_inq_bestdob_ver_count AND nf_inq_bestdob_ver_count < 5.5 => -0.0242308269243072,
    nf_inq_bestdob_ver_count >= 5.5                                    => lncu_tree_41_c1680,
    nf_inq_bestdob_ver_count = NULL                                    => 0.000332488218678745,
                                                                          -0.00292014762883945));

lncu_tree_42_c1684 :=     __common__( map(
    NULL < rv_p88_phn_dst_to_inp_add AND rv_p88_phn_dst_to_inp_add < 25.5 => 0.0185302128987803,
    rv_p88_phn_dst_to_inp_add >= 25.5                                     => -0.0544543616144702,
    rv_p88_phn_dst_to_inp_add = NULL                                      => 0.0538780989354221,
                                                                             0.0265047831808296));

lncu_tree_42_c1683 :=     __common__( map(
    (iv_f00_email_verification in ['', '2', '4', '5']) => -0.0143978696491404,
    (iv_f00_email_verification in ['0', '1', '3'])     => lncu_tree_42_c1684,
    iv_f00_email_verification = ''                   => 0.000233071291316577,
                                                          0.000233071291316577));

lncu_tree_42 :=     __common__( map(
    NULL < nf_inq_corrdobphone AND nf_inq_corrdobphone < 0.5 => 0.0498432888960532,
    nf_inq_corrdobphone >= 0.5                               => -0.00382327828229186,
    nf_inq_corrdobphone = NULL                               => lncu_tree_42_c1683,
                                                                0.00045828973373656));

lncu_tree_43_c1687 :=     __common__( map(
    NULL < nf_inq_addr_ver_count AND nf_inq_addr_ver_count < 5.5 => 0.00483338969178233,
    nf_inq_addr_ver_count >= 5.5                                 => 0.0781668244779912,
    nf_inq_addr_ver_count = NULL                                 => 0.0305406823290142,
                                                                    0.0305406823290142));

lncu_tree_43_c1686 :=     __common__( map(
    NULL < nf_invbest_inq_peraddr_diff AND nf_invbest_inq_peraddr_diff < -3.5 => 0.000900597428421756,
    nf_invbest_inq_peraddr_diff >= -3.5                                       => lncu_tree_43_c1687,
    nf_invbest_inq_peraddr_diff = NULL                                        => 0.0040006725647355,
                                                                                 0.0040006725647355));

lncu_tree_43 :=     __common__( map(
    (ip_routingmethod in ['', '06', '12', '13'])               => -0.0332219362080948,
    (ip_routingmethod in ['02', '10', '11', '14', '15', '16']) => lncu_tree_43_c1686,
    ip_routingmethod = ''                                    => -0.00269778014647815,
                                                                  -0.00269778014647815));

lncu_tree_44_c1689 :=     __common__( map(
    NULL < rv_d34_liens_rel_total_amt AND rv_d34_liens_rel_total_amt < 367.5 => 0.00294421617023746,
    rv_d34_liens_rel_total_amt >= 367.5                                      => -0.0370170420461817,
    rv_d34_liens_rel_total_amt = NULL                                        => -0.00560692885737446,
                                                                                -0.00560692885737446));

lncu_tree_44_c1690 :=     __common__( map(
    NULL < nf_inq_phone_ver_count AND nf_inq_phone_ver_count < 0.5 => 0.0821595775789005,
    nf_inq_phone_ver_count >= 0.5                                  => 0.0196972076729405,
    nf_inq_phone_ver_count = NULL                                  => 0.0247610186891361,
                                                                      0.0247610186891361));

lncu_tree_44 :=     __common__( map(
    NULL < rv_i62_inq_phones_per_adl AND rv_i62_inq_phones_per_adl < 1.5 => lncu_tree_44_c1689,
    rv_i62_inq_phones_per_adl >= 1.5                                     => lncu_tree_44_c1690,
    rv_i62_inq_phones_per_adl = NULL                                     => 5.65696256883962e-05,
                                                                            5.65696256883962e-05));

lncu_tree_45_c1693 :=     __common__( map(
    NULL < rv_l79_adls_per_sfd_addr AND rv_l79_adls_per_sfd_addr < 4.5 => -0.00191413524482259,
    rv_l79_adls_per_sfd_addr >= 4.5                                    => 0.0335319503640935,
    rv_l79_adls_per_sfd_addr = NULL                                    => 0.0079491805761845,
                                                                          0.0079491805761845));

lncu_tree_45_c1692 :=     __common__( map(
    (ip_routingmethod in ['', '06', '13', '14', '16'])   => -0.0137107531868981,
    (ip_routingmethod in ['02', '10', '11', '12', '15']) => lncu_tree_45_c1693,
    ip_routingmethod = ''                              => -0.00454195991472101,
                                                            -0.00454195991472101));

lncu_tree_45 :=     __common__( map(
    NULL < nf_util_adl_count AND nf_util_adl_count < 26.5 => lncu_tree_45_c1692,
    nf_util_adl_count >= 26.5                             => 0.0826770721514264,
    nf_util_adl_count = NULL                              => -0.00348574434242486,
                                                             -0.00348574434242486));

lncu_tree_46_c1696 :=     __common__( map(
    NULL < nf_mos_liens_unrel_st_lseen AND nf_mos_liens_unrel_st_lseen < 56.5 => 0.00683597494741071,
    nf_mos_liens_unrel_st_lseen >= 56.5                                       => 0.0838771694719326,
    nf_mos_liens_unrel_st_lseen = NULL                                        => 0.0128607223121349,
                                                                                 0.0128607223121349));

lncu_tree_46_c1695 :=     __common__( map(
    NULL < rv_i60_inq_comm_recency AND rv_i60_inq_comm_recency < 0.5 => -0.0104550699956995,
    rv_i60_inq_comm_recency >= 0.5                                   => lncu_tree_46_c1696,
    rv_i60_inq_comm_recency = NULL                                   => -0.00375533950949905,
                                                                        -0.00375533950949905));

lncu_tree_46 :=     __common__( map(
    NULL < nf_inq_perphone_count12 AND nf_inq_perphone_count12 < 14.5 => lncu_tree_46_c1695,
    nf_inq_perphone_count12 >= 14.5                                   => 0.0941196093105856,
    nf_inq_perphone_count12 = NULL                                    => -0.00291958074764458,
                                                                         -0.00291958074764458));

lncu_tree_47_c1699 :=     __common__( map(
    NULL < rv_c24_prv_addr_lres AND rv_c24_prv_addr_lres < 62.5 => 0.0100921849227357,
    rv_c24_prv_addr_lres >= 62.5                                => 0.0881623716658691,
    rv_c24_prv_addr_lres = NULL                                 => 0.0468565387906932,
                                                                   0.0468565387906932));

lncu_tree_47_c1698 :=     __common__( map(
    NULL < nf_inq_banking_count24 AND nf_inq_banking_count24 < 3.5 => 0.00308697329926256,
    nf_inq_banking_count24 >= 3.5                                  => lncu_tree_47_c1699,
    nf_inq_banking_count24 = NULL                                  => 0.00617221832961045,
                                                                      0.00617221832961045));

lncu_tree_47 :=     __common__( map(
    NULL < rv_d34_liens_rel_total_amt AND rv_d34_liens_rel_total_amt < 625.5 => lncu_tree_47_c1698,
    rv_d34_liens_rel_total_amt >= 625.5                                      => -0.0287460464429966,
    rv_d34_liens_rel_total_amt = NULL                                        => -0.000330065081822014,
                                                                                -0.000330065081822014));

lncu_tree_48_c1702 :=     __common__( map(
    NULL < ip_state_match AND ip_state_match < 0.5 => 0.100469444804517,
    ip_state_match >= 0.5                          => 0.0098302222612944,
    ip_state_match = NULL                          => 0.0230116384332474,
                                                      0.0230116384332474));

lncu_tree_48_c1701 :=     __common__( map(
    (nf_historic_x_current_ct in ['1-0', '1-1', '2-0', '2-1', '2-2', '3-1', '3-2', '3-3']) => -0.015064771973881,
    (nf_historic_x_current_ct in ['', '0-0', '3-0'])                                       => lncu_tree_48_c1702,
    nf_historic_x_current_ct = ''                                                        => -0.00535830694748899,
                                                                                              -0.00535830694748899));

lncu_tree_48 :=     __common__( map(
    NULL < rv_f00_inq_corrphonessn_adl AND rv_f00_inq_corrphonessn_adl < 0.5 => 0.0282408524338371,
    rv_f00_inq_corrphonessn_adl >= 0.5                                       => -0.00189905146901255,
    rv_f00_inq_corrphonessn_adl = NULL                                       => lncu_tree_48_c1701,
                                                                                0.00101251994626772));

lncu_tree_49_c1705 :=     __common__( map(
    NULL < rv_i60_inq_prepaidcards_recency AND rv_i60_inq_prepaidcards_recency < 18 => 0.0118333152490995,
    rv_i60_inq_prepaidcards_recency >= 18                                           => 0.0653043607513114,
    rv_i60_inq_prepaidcards_recency = NULL                                          => 0.0185153147433247,
                                                                                       0.0185153147433247));

lncu_tree_49_c1704 :=     __common__( map(
    NULL < rv_i60_inq_comm_recency AND rv_i60_inq_comm_recency < 9 => -0.00607914152528698,
    rv_i60_inq_comm_recency >= 9                                   => lncu_tree_49_c1705,
    rv_i60_inq_comm_recency = NULL                                 => 0.000892623523570297,
                                                                      0.000892623523570297));

lncu_tree_49 :=     __common__( map(
    NULL < nf_phone_ver_bureau AND nf_phone_ver_bureau < -0.5 => -0.0708431527136071,
    nf_phone_ver_bureau >= -0.5                               => lncu_tree_49_c1704,
    nf_phone_ver_bureau = NULL                                => -0.0010561130243195,
                                                                 -0.0010561130243195));

lncu_tree_50_c1708 :=     __common__( map(
    NULL < iv_src_drivers_lic_adl_count AND iv_src_drivers_lic_adl_count < 1.5 => 0.0126310304020929,
    iv_src_drivers_lic_adl_count >= 1.5                                        => 0.0871383626764128,
    iv_src_drivers_lic_adl_count = NULL                                        => 0.0397898241472027,
                                                                                  0.0397898241472027));

lncu_tree_50_c1707 :=     __common__( map(
    NULL < rv_l79_adls_per_addr_curr AND rv_l79_adls_per_addr_curr < 5.5 => 0.000952438938177658,
    rv_l79_adls_per_addr_curr >= 5.5                                     => lncu_tree_50_c1708,
    rv_l79_adls_per_addr_curr = NULL                                     => 0.00738112269203949,
                                                                            0.00738112269203949));

lncu_tree_50 :=     __common__( map(
    (nf_util_adl_summary in ['', 'I', 'IC', 'ICM', 'IM', 'M']) => -0.0197858865735433,
    (nf_util_adl_summary in ['C', 'CM'])                       => lncu_tree_50_c1707,
    nf_util_adl_summary = ''                                 => -0.00127556936993801,
                                                                  -0.00127556936993801));

lncu_tree_51_c1711 :=     __common__( map(
    NULL < nf_inq_curraddr_ver_count AND nf_inq_curraddr_ver_count < 18.5 => 0.109682439718718,
    nf_inq_curraddr_ver_count >= 18.5                                     => -0.000740746780886396,
    nf_inq_curraddr_ver_count = NULL                                      => 0.0549868426675123,
                                                                             0.0549868426675123));

lncu_tree_51_c1710 :=     __common__( map(
    NULL < nf_inq_per_phone AND nf_inq_per_phone < 11.5 => -0.0003907118725046,
    nf_inq_per_phone >= 11.5                            => lncu_tree_51_c1711,
    nf_inq_per_phone = NULL                             => 0.000559975759083673,
                                                           0.000559975759083673));

lncu_tree_51 :=     __common__( map(
    NULL < nf_util_adl_count AND nf_util_adl_count < 25.5 => lncu_tree_51_c1710,
    nf_util_adl_count >= 25.5                             => 0.0742712483383882,
    nf_util_adl_count = NULL                              => 0.00180757338503774,
                                                             0.00180757338503774));

lncu_tree_52_c1714 :=     __common__( map(
    NULL < nf_inq_curraddr_ver_count AND nf_inq_curraddr_ver_count < 1.5 => 0.0659231571989716,
    nf_inq_curraddr_ver_count >= 1.5                                     => -0.0229289031294229,
    nf_inq_curraddr_ver_count = NULL                                     => -0.00148185408463801,
                                                                            -0.00148185408463801));

lncu_tree_52_c1713 :=     __common__( map(
    NULL < rv_d34_mos_last_unrel_lien_dt84 AND rv_d34_mos_last_unrel_lien_dt84 < 12.5 => 0.140013409649332,
    rv_d34_mos_last_unrel_lien_dt84 >= 12.5                                           => lncu_tree_52_c1714,
    rv_d34_mos_last_unrel_lien_dt84 = NULL                                            => 0.0210506594438677,
                                                                                         0.0217323822045813));

lncu_tree_52 :=     __common__( map(
    NULL < nf_util_adl_count AND nf_util_adl_count < 9.5 => -0.00710869312713726,
    nf_util_adl_count >= 9.5                             => lncu_tree_52_c1713,
    nf_util_adl_count = NULL                             => -0.000876173238640443,
                                                            -0.000876173238640443));

lncu_tree_53_c1717 :=     __common__( map(
    NULL < nf_inq_bestlname_ver_count AND nf_inq_bestlname_ver_count < 21.5 => 0.0976314195817102,
    nf_inq_bestlname_ver_count >= 21.5                                      => -0.0196014015024165,
    nf_inq_bestlname_ver_count = NULL                                       => 0.0468781860635822,
                                                                               0.0468781860635822));

lncu_tree_53_c1716 :=     __common__( map(
    NULL < nf_inq_ssns_per_sfd_addr AND nf_inq_ssns_per_sfd_addr < 3.5 => -0.00173958549184192,
    nf_inq_ssns_per_sfd_addr >= 3.5                                    => lncu_tree_53_c1717,
    nf_inq_ssns_per_sfd_addr = NULL                                    => 0.00078492347118975,
                                                                          0.00078492347118975));

lncu_tree_53 :=     __common__( map(
    NULL < nf_liens_unrel_ot_total_amt AND nf_liens_unrel_ot_total_amt < 18757.5 => lncu_tree_53_c1716,
    nf_liens_unrel_ot_total_amt >= 18757.5                                       => 0.159064008355386,
    nf_liens_unrel_ot_total_amt = NULL                                           => 0.00240691238545991,
                                                                                    0.00240691238545991));

lncu_tree_54_c1720 :=     __common__( map(
    NULL < nf_inq_ssn_lexid_diff01 AND nf_inq_ssn_lexid_diff01 < 1.5 => -0.00887201436513479,
    nf_inq_ssn_lexid_diff01 >= 1.5                                   => 0.0301055679150293,
    nf_inq_ssn_lexid_diff01 = NULL                                   => -0.00712582855141207,
                                                                        -0.00712582855141207));

lncu_tree_54_c1719 :=     __common__( map(
    NULL < nf_inq_communications_count24 AND nf_inq_communications_count24 < 2.5 => lncu_tree_54_c1720,
    nf_inq_communications_count24 >= 2.5                                         => 0.0632645772163171,
    nf_inq_communications_count24 = NULL                                         => -0.00640345149261281,
                                                                                    -0.00640345149261281));

lncu_tree_54 :=     __common__( map(
    NULL < iv_c13_avg_lres AND iv_c13_avg_lres < 314.5 => lncu_tree_54_c1719,
    iv_c13_avg_lres >= 314.5                           => 0.110968144013934,
    iv_c13_avg_lres = NULL                             => -0.00532840311337099,
                                                          -0.00532840311337099));

lncu_tree_55_c1722 :=     __common__( map(
    NULL < nf_inq_addrsperbestssn_count12 AND nf_inq_addrsperbestssn_count12 < 3.5 => 0.0115042757664603,
    nf_inq_addrsperbestssn_count12 >= 3.5                                          => -0.0636279387385665,
    nf_inq_addrsperbestssn_count12 = NULL                                          => 0.0105159020753291,
                                                                                      0.0105159020753291));

lncu_tree_55_c1723 :=     __common__( map(
    NULL < nf_email_name_addr_ver AND nf_email_name_addr_ver < 3.5 => 0.00867557681539291,
    nf_email_name_addr_ver >= 3.5                                  => -0.0433637912125831,
    nf_email_name_addr_ver = NULL                                  => -0.01799902965675,
                                                                      -0.01799902965675));

lncu_tree_55 :=     __common__( map(
    NULL < rv_c10_m_hdr_fs AND rv_c10_m_hdr_fs < 367.5 => lncu_tree_55_c1722,
    rv_c10_m_hdr_fs >= 367.5                           => lncu_tree_55_c1723,
    rv_c10_m_hdr_fs = NULL                             => 0.00303900756028673,
                                                          0.00303900756028673));

lncu_tree_56_c1726 :=     __common__( map(
    NULL < rv_c12_source_profile AND rv_c12_source_profile < 60.9 => 0.00280276535110151,
    rv_c12_source_profile >= 60.9                                 => 0.0692924125000677,
    rv_c12_source_profile = NULL                                  => 0.0273699957651917,
                                                                     0.0273699957651917));

lncu_tree_56_c1725 :=     __common__( map(
    NULL < nf_historical_count AND nf_historical_count < 1.5 => lncu_tree_56_c1726,
    nf_historical_count >= 1.5                               => 0.00128676940986297,
    nf_historical_count = NULL                               => 0.00932816465961024,
                                                                0.00932816465961024));

lncu_tree_56 :=     __common__( map(
    (ip_routingmethod in ['', '10', '12', '13', '14'])   => -0.0111840365213832,
    (ip_routingmethod in ['02', '06', '11', '15', '16']) => lncu_tree_56_c1725,
    ip_routingmethod = ''                              => -0.00228512702671235,
                                                            -0.00228512702671235));

lncu_tree_57_c1729 :=     __common__( map(
    (iv_d34_liens_unrel_x_rel in ['0-0', '0-2', '1-0', '1-1', '2-0', '2-1', '2-2', '3-0', '3-1']) => 0.0142420514417522,
    (iv_d34_liens_unrel_x_rel in ['', '0-1', '1-2', '3-2'])                                       => 0.106685504446918,
    iv_d34_liens_unrel_x_rel = ''                                                               => 0.0174201013936184,
                                                                                                     0.0174201013936184));

lncu_tree_57_c1728 :=     __common__( map(
    NULL < rv_d34_liens_rel_total_amt AND rv_d34_liens_rel_total_amt < 139.5 => lncu_tree_57_c1729,
    rv_d34_liens_rel_total_amt >= 139.5                                      => -0.0184613511474299,
    rv_d34_liens_rel_total_amt = NULL                                        => 0.00677567815897634,
                                                                                0.00677567815897634));

lncu_tree_57 :=     __common__( map(
    (rv_6seg_riskview_5_0 in ['0 TRUEDID = 0', '5 SUFFICIENTLY VERD - OWNER', '6 SUFFICIENTLY VERD - OTHER'])                                   => -0.0210896512944033,
    (rv_6seg_riskview_5_0 in ['1 VER/VAL PROBLEMS', '2 ADDR NOT CURRENT - DEROG', '3 ADDR NOT CURRENT - OTHER', '4 SUFFICIENTLY VERD - DEROG']) => lncu_tree_57_c1728,
    rv_6seg_riskview_5_0 = ''                                                                                                                 => -0.000798019824629169,
                                                                                                                                                   -0.000798019824629169));

lncu_tree_58_c1732 :=     __common__( map(
    (ip_routingmethod in ['06', '13', '14', '15'])           => 0.015827205616036,
    (ip_routingmethod in ['', '02', '10', '11', '12', '16']) => 0.100806299673485,
    ip_routingmethod = ''                                  => 0.041434239292014,
                                                                0.041434239292014));

lncu_tree_58_c1731 :=     __common__( map(
    NULL < nf_inq_corrdobphone AND nf_inq_corrdobphone < 0.5 => lncu_tree_58_c1732,
    nf_inq_corrdobphone >= 0.5                               => -0.000120058126479169,
    nf_inq_corrdobphone = NULL                               => 0.00649064100952857,
                                                                0.00493457571666361));

lncu_tree_58 :=     __common__( map(
    NULL < rv_c23_email_domain_isp_cnt AND rv_c23_email_domain_isp_cnt < 1.5 => lncu_tree_58_c1731,
    rv_c23_email_domain_isp_cnt >= 1.5                                       => -0.0210671664865565,
    rv_c23_email_domain_isp_cnt = NULL                                       => -0.00387331257779675,
                                                                                -0.00387331257779675));

lncu_tree_59_c1735 :=     __common__( map(
    NULL < nf_corrssnaddr AND nf_corrssnaddr < 3.5 => 0.0241323584682397,
    nf_corrssnaddr >= 3.5                          => -0.0237104952446294,
    nf_corrssnaddr = NULL                          => 0.00450234211358116,
                                                      0.00450234211358116));

lncu_tree_59_c1734 :=     __common__( map(
    (iv_f00_email_verification in ['1', '2', '4', '5']) => lncu_tree_59_c1735,
    (iv_f00_email_verification in ['', '0', '3'])       => 0.0488790908362581,
    iv_f00_email_verification = ''                    => 0.0161173421726505,
                                                           0.0161173421726505));

lncu_tree_59 :=     __common__( map(
    NULL < nf_util_adl_count AND nf_util_adl_count < 7.5 => -0.00852159626297327,
    nf_util_adl_count >= 7.5                             => lncu_tree_59_c1734,
    nf_util_adl_count = NULL                             => -0.00122860819784102,
                                                            -0.00122860819784102));

lncu_tree_60_c1738 :=     __common__( map(
    (rv_e58_br_dead_bus_x_active_phn in ['0-1', '0-2', '0-3', '1-1', '2-1', '2-3'])                                 => -0.0287546678923913,
    (rv_e58_br_dead_bus_x_active_phn in ['', '0-0', '1-0', '1-2', '1-3', '2-0', '2-2', '3-0', '3-1', '3-2', '3-3']) => 0.0155613299705673,
    rv_e58_br_dead_bus_x_active_phn = ''                                                                          => 0.0104846850228367,
                                                                                                                       0.0104846850228367));

lncu_tree_60_c1737 :=     __common__( map(
    (nf_util_add_curr_summary in ['', 'I', 'ICM'])             => -0.0280982053669121,
    (nf_util_add_curr_summary in ['C', 'CM', 'IC', 'IM', 'M']) => lncu_tree_60_c1738,
    nf_util_add_curr_summary = ''                            => 0.00576845160997416,
                                                                  0.00576845160997416));

lncu_tree_60 :=     __common__( map(
    (rv_d31_all_bk in ['2 - BK DISCHARGED', '3 - BK OTHER']) => -0.0194094081409441,
    (rv_d31_all_bk in ['', '0 - NO BK', '1 - BK DISMISSED']) => lncu_tree_60_c1737,
    rv_d31_all_bk = ''                                     => -0.00103574194976825,
                                                                -0.00103574194976825));

lncu_tree_61_c1741 :=     __common__( map(
    NULL < nf_inquiry_addr_vel_risk_indexv2 AND nf_inquiry_addr_vel_risk_indexv2 < 2.5 => 0.0203538304029541,
    nf_inquiry_addr_vel_risk_indexv2 >= 2.5                                            => 0.0953729993040301,
    nf_inquiry_addr_vel_risk_indexv2 = NULL                                            => 0.0287607812918111,
                                                                                          0.0287607812918111));

lncu_tree_61_c1740 :=     __common__( map(
    (nf_historic_x_current_ct in ['', '1-1', '2-0', '3-1', '3-2'])           => -0.0238186838607948,
    (nf_historic_x_current_ct in ['0-0', '1-0', '2-1', '2-2', '3-0', '3-3']) => lncu_tree_61_c1741,
    nf_historic_x_current_ct = ''                                          => 0.0138859018513445,
                                                                                0.0138859018513445));

lncu_tree_61 :=     __common__( map(
    NULL < (INTEGER)iv_inf_contradictory AND (INTEGER)iv_inf_contradictory < 0.5 => -0.0123599640211551,
    (INTEGER)iv_inf_contradictory >= 0.5                                => lncu_tree_61_c1740,
    (INTEGER)iv_inf_contradictory = NULL                                => -0.00739458495948692,
                                                                  -0.00739458495948692));

lncu_tree_62_c1744 :=     __common__( map(
    (nf_historic_x_current_ct in ['1-0', '1-1', '2-0', '2-1', '3-2', '3-3']) => 0.00749261674373216,
    (nf_historic_x_current_ct in ['', '0-0', '2-2', '3-0', '3-1'])           => 0.0542430278668954,
    nf_historic_x_current_ct = ''                                          => 0.0264889959191222,
                                                                                0.0264889959191222));

lncu_tree_62_c1743 :=     __common__( map(
    NULL < nf_phone_ver_bureau AND nf_phone_ver_bureau < 0.5 => lncu_tree_62_c1744,
    nf_phone_ver_bureau >= 0.5                               => -0.00389735021864999,
    nf_phone_ver_bureau = NULL                               => 0.00136893941993263,
                                                                0.00136893941993263));

lncu_tree_62 :=     __common__( map(
    NULL < nf_phone_ver_bureau AND nf_phone_ver_bureau < -0.5 => -0.0701897511195101,
    nf_phone_ver_bureau >= -0.5                               => lncu_tree_62_c1743,
    nf_phone_ver_bureau = NULL                                => -0.000391702065708729,
                                                                 -0.000391702065708729));

lncu_tree_63_c1747 :=     __common__( map(
    NULL < nf_util_adl_count AND nf_util_adl_count < 9.5 => 0.0489245086286089,
    nf_util_adl_count >= 9.5                             => 0.24036226901124,
    nf_util_adl_count = NULL                             => 0.101854328682721,
                                                            0.101854328682721));

lncu_tree_63_c1746 :=     __common__( map(
    NULL < nf_corrssnname AND nf_corrssnname < 4.5 => lncu_tree_63_c1747,
    nf_corrssnname >= 4.5                          => 0.00289218488388157,
    nf_corrssnname = NULL                          => 0.0374574824020684,
                                                      0.0374574824020684));

lncu_tree_63 :=     __common__( map(
    NULL < nf_bus_ver_src_mos_reg_lseen AND nf_bus_ver_src_mos_reg_lseen < 35.5 => -0.00323801315885211,
    nf_bus_ver_src_mos_reg_lseen >= 35.5                                        => lncu_tree_63_c1746,
    nf_bus_ver_src_mos_reg_lseen = NULL                                         => 0.000263898077673204,
                                                                                   0.000263898077673204));

lncu_tree_64_c1750 :=     __common__( map(
    NULL < nf_inq_corrnameaddr AND nf_inq_corrnameaddr < 0.5 => 0.0221914559231486,
    nf_inq_corrnameaddr >= 0.5                               => -0.0136866164350844,
    nf_inq_corrnameaddr = NULL                               => -0.0020741675160079,
                                                                -0.00509325148148659));

lncu_tree_64_c1749 :=     __common__( map(
    NULL < nf_mos_liens_unrel_st_fseen AND nf_mos_liens_unrel_st_fseen < 67.5 => lncu_tree_64_c1750,
    nf_mos_liens_unrel_st_fseen >= 67.5                                       => 0.0399803278380311,
    nf_mos_liens_unrel_st_fseen = NULL                                        => -0.00165567563277278,
                                                                                 -0.00165567563277278));

lncu_tree_64 :=     __common__( map(
    NULL < nf_liens_unrel_ot_total_amt AND nf_liens_unrel_ot_total_amt < 18727 => lncu_tree_64_c1749,
    nf_liens_unrel_ot_total_amt >= 18727                                       => 0.131522338478722,
    nf_liens_unrel_ot_total_amt = NULL                                         => -0.00040444962861944,
                                                                                  -0.00040444962861944));

lncu_tree_65_c1753 :=     __common__( map(
    NULL < nf_inq_curraddr_ver_count AND nf_inq_curraddr_ver_count < 9.5 => 0.0099773368170874,
    nf_inq_curraddr_ver_count >= 9.5                                     => 0.100641808507026,
    nf_inq_curraddr_ver_count = NULL                                     => 0.0523206340349159,
                                                                            0.0523206340349159));

lncu_tree_65_c1752 :=     __common__( map(
    NULL < nf_inq_perphone_count_week AND nf_inq_perphone_count_week < 0.5 => 0.00287049228324387,
    nf_inq_perphone_count_week >= 0.5                                      => lncu_tree_65_c1753,
    nf_inq_perphone_count_week = NULL                                      => 0.00499368975875973,
                                                                              0.00499368975875973));

lncu_tree_65 :=     __common__( map(
    NULL < rv_c23_email_domain_isp_cnt AND rv_c23_email_domain_isp_cnt < 1.5 => lncu_tree_65_c1752,
    rv_c23_email_domain_isp_cnt >= 1.5                                       => -0.0170014419334626,
    rv_c23_email_domain_isp_cnt = NULL                                       => -0.00248769400863282,
                                                                                -0.00248769400863282));

lncu_tree_66_c1756 :=     __common__( map(
    NULL < nf_phones_per_curraddr_c6 AND nf_phones_per_curraddr_c6 < 2.5 => -0.00837808914703069,
    nf_phones_per_curraddr_c6 >= 2.5                                     => 0.0758080012512832,
    nf_phones_per_curraddr_c6 = NULL                                     => -0.00730334451575883,
                                                                            -0.00730334451575883));

lncu_tree_66_c1755 :=     __common__( map(
    NULL < nf_inq_ssnspercurraddr_count12 AND nf_inq_ssnspercurraddr_count12 < 5.5 => lncu_tree_66_c1756,
    nf_inq_ssnspercurraddr_count12 >= 5.5                                          => 0.0697736382758591,
    nf_inq_ssnspercurraddr_count12 = NULL                                          => -0.00648797262864454,
                                                                                      -0.00648797262864454));

lncu_tree_66 :=     __common__( map(
    NULL < nf_util_adl_count AND nf_util_adl_count < 25.5 => lncu_tree_66_c1755,
    nf_util_adl_count >= 25.5                             => 0.0581939220272425,
    nf_util_adl_count = NULL                              => -0.0054183108614315,
                                                             -0.0054183108614315));

lncu_tree_67_c1759 :=     __common__( map(
    NULL < nf_inq_phone_ver_count AND nf_inq_phone_ver_count < 0.5 => 0.103171226299452,
    nf_inq_phone_ver_count >= 0.5                                  => 0.0385739304162114,
    nf_inq_phone_ver_count = NULL                                  => 0.0494133859612449,
                                                                      0.0494133859612449));

lncu_tree_67_c1758 :=     __common__( map(
    (iv_d34_liens_unrel_x_rel in ['1-0', '1-1', '1-2', '2-0', '2-1', '2-2', '3-2']) => -0.0103236925681131,
    (iv_d34_liens_unrel_x_rel in ['', '0-0', '0-1', '0-2', '3-0', '3-1'])           => lncu_tree_67_c1759,
    iv_d34_liens_unrel_x_rel = ''                                                 => 0.027125904512705,
                                                                                       0.027125904512705));

lncu_tree_67 :=     __common__( map(
    NULL < nf_util_adl_count AND nf_util_adl_count < 13.5 => -0.00371132967798786,
    nf_util_adl_count >= 13.5                             => lncu_tree_67_c1758,
    nf_util_adl_count = NULL                              => -0.000260239906705047,
                                                             -0.000260239906705047));

lncu_tree_68_c1762 :=     __common__( map(
    NULL < nf_inq_bestdob_ver_count AND nf_inq_bestdob_ver_count < 4.5 => -0.0481757820267785,
    nf_inq_bestdob_ver_count >= 4.5                                    => 0.0431793241302712,
    nf_inq_bestdob_ver_count = NULL                                    => 0.0272375239962823,
                                                                          0.0272375239962823));

lncu_tree_68_c1761 :=     __common__( map(
    NULL < nf_invbest_inq_peraddr_diff AND nf_invbest_inq_peraddr_diff < -0.5 => -0.00387390958037212,
    nf_invbest_inq_peraddr_diff >= -0.5                                       => lncu_tree_68_c1762,
    nf_invbest_inq_peraddr_diff = NULL                                        => -0.00146798469200843,
                                                                                 -0.00146798469200843));

lncu_tree_68 :=     __common__( map(
    NULL < nf_bus_seleids_peradl AND nf_bus_seleids_peradl < 7.5 => lncu_tree_68_c1761,
    nf_bus_seleids_peradl >= 7.5                                 => 0.149215547290436,
    nf_bus_seleids_peradl = NULL                                 => -0.000216479769077307,
                                                                    -0.000216479769077307));

lncu_tree_69_c1765 :=     __common__( map(
    NULL < nf_inq_perssn_count01 AND nf_inq_perssn_count01 < 4.5 => 0.00175789295705707,
    nf_inq_perssn_count01 >= 4.5                                 => 0.080672212589466,
    nf_inq_perssn_count01 = NULL                                 => 0.003166509855609,
                                                                    0.003166509855609));

lncu_tree_69_c1764 :=     __common__( map(
    NULL < nf_inq_phone_ver_count AND nf_inq_phone_ver_count < 0.5 => 0.0306377259749797,
    nf_inq_phone_ver_count >= 0.5                                  => lncu_tree_69_c1765,
    nf_inq_phone_ver_count = NULL                                  => 0.0080571540291939,
                                                                      0.00819701215835368));

lncu_tree_69 :=     __common__( map(
    (nf_util_adl_summary in ['', 'I', 'IC', 'IM', 'M']) => -0.0186027068954095,
    (nf_util_adl_summary in ['C', 'CM', 'ICM'])         => lncu_tree_69_c1764,
    nf_util_adl_summary = ''                         => 0.000935809966700344,
                                                           0.000935809966700344));

lncu_tree_70_c1768 :=     __common__( map(
    NULL < rv_l79_adls_per_addr_curr AND rv_l79_adls_per_addr_curr < 2.25 => -0.00615325197224815,
    rv_l79_adls_per_addr_curr >= 2.25                                     => 0.0463043135952908,
    rv_l79_adls_per_addr_curr = NULL                                      => 0.0281380749357151,
                                                                             0.0281380749357151));

lncu_tree_70_c1767 :=     __common__( map(
    NULL < nf_inq_curraddr_ver_count AND nf_inq_curraddr_ver_count < 28.5 => lncu_tree_70_c1768,
    nf_inq_curraddr_ver_count >= 28.5                                     => -0.0477347824264294,
    nf_inq_curraddr_ver_count = NULL                                      => 0.0243070562758038,
                                                                             0.0243070562758038));

lncu_tree_70 :=     __common__( map(
    NULL < (INTEGER)iv_inf_contradictory AND (INTEGER)iv_inf_contradictory < 0.5 => -0.00187626457241192,
    (INTEGER)iv_inf_contradictory >= 0.5                                => lncu_tree_70_c1767,
    (INTEGER)iv_inf_contradictory = NULL                                => 0.00310774639264559,
                                                                  0.00310774639264559));

lncu_tree_71_c1770 :=     __common__( map(
    NULL < nf_util_adl_count AND nf_util_adl_count < 20.5 => 0.0107997960724049,
    nf_util_adl_count >= 20.5                             => 0.0806619994160895,
    nf_util_adl_count = NULL                              => 0.0132344124363321,
                                                             0.0132344124363321));

lncu_tree_71_c1771 :=     __common__( map(
    NULL < nf_inq_dob_ver_count AND nf_inq_dob_ver_count < 19.5 => -0.0150324524300818,
    nf_inq_dob_ver_count >= 19.5                                => 0.0143275466665651,
    nf_inq_dob_ver_count = NULL                                 => -0.063023125228902,
                                                                   -0.00827962370885759));

lncu_tree_71 :=     __common__( map(
    NULL < iv_addr_non_phn_src_ct AND iv_addr_non_phn_src_ct < 3.5 => lncu_tree_71_c1770,
    iv_addr_non_phn_src_ct >= 3.5                                  => lncu_tree_71_c1771,
    iv_addr_non_phn_src_ct = NULL                                  => -0.00104539131578706,
                                                                      -0.00104539131578706));

lncu_tree_72_c1774 :=     __common__( map(
    NULL < nf_email_name_addr_ver AND nf_email_name_addr_ver < 7.5 => 0.0139109760498418,
    nf_email_name_addr_ver >= 7.5                                  => -0.0163488048964008,
    nf_email_name_addr_ver = NULL                                  => 0.00669808842360916,
                                                                      0.00669808842360916));

lncu_tree_72_c1773 :=     __common__( map(
    (ip_routingmethod in ['', '06', '10', '12', '13', '16']) => -0.0268064884474021,
    (ip_routingmethod in ['02', '11', '14', '15'])           => lncu_tree_72_c1774,
    ip_routingmethod = ''                                  => 0.000506856813411197,
                                                                0.000506856813411197));

lncu_tree_72 :=     __common__( map(
    NULL < rv_c13_curr_addr_lres AND rv_c13_curr_addr_lres < 15.5 => -0.0277866891537735,
    rv_c13_curr_addr_lres >= 15.5                                 => lncu_tree_72_c1773,
    rv_c13_curr_addr_lres = NULL                                  => -0.00405428064186997,
                                                                     -0.00405428064186997));

lncu_tree_73_c1777 :=     __common__( map(
    NULL < nf_addrs_per_bestssn AND nf_addrs_per_bestssn < 8.5 => -0.00291812184487155,
    nf_addrs_per_bestssn >= 8.5                                => 0.0338129055430109,
    nf_addrs_per_bestssn = NULL                                => 0.0194902507194163,
                                                                  0.0194902507194163));

lncu_tree_73_c1776 :=     __common__( map(
    (nf_util_add_curr_summary in ['C', 'ICM', 'M'])           => -0.014278605769094,
    (nf_util_add_curr_summary in ['', 'CM', 'I', 'IC', 'IM']) => lncu_tree_73_c1777,
    nf_util_add_curr_summary = ''                           => 0.00966990725142226,
                                                                 0.00966990725142226));

lncu_tree_73 :=     __common__( map(
    NULL < nf_m_src_credentialed_fs AND nf_m_src_credentialed_fs < 203.5 => lncu_tree_73_c1776,
    nf_m_src_credentialed_fs >= 203.5                                    => -0.0121696025145336,
    nf_m_src_credentialed_fs = NULL                                      => 4.56015502137588e-05,
                                                                            4.56015502137588e-05));

lncu_tree_74_c1780 :=     __common__( map(
    NULL < rv_d34_liens_rel_total_amt84 AND rv_d34_liens_rel_total_amt84 < 982 => 0.0129054459577486,
    rv_d34_liens_rel_total_amt84 >= 982                                        => -0.0450643060183236,
    rv_d34_liens_rel_total_amt84 = NULL                                        => 0.00798280111151644,
                                                                                  0.00798280111151644));

lncu_tree_74_c1779 :=     __common__( map(
    NULL < nf_inq_addrsperbestssn_count12 AND nf_inq_addrsperbestssn_count12 < 3.5 => lncu_tree_74_c1780,
    nf_inq_addrsperbestssn_count12 >= 3.5                                          => -0.0828813852280479,
    nf_inq_addrsperbestssn_count12 = NULL                                          => 0.00680871331049959,
                                                                                      0.00680871331049959));

lncu_tree_74 :=     __common__( map(
    (rv_6seg_riskview_5_0 in ['0 TRUEDID = 0', '3 ADDR NOT CURRENT - OTHER', '5 SUFFICIENTLY VERD - OWNER', '6 SUFFICIENTLY VERD - OTHER']) => -0.015969629774398,
    (rv_6seg_riskview_5_0 in ['1 VER/VAL PROBLEMS', '2 ADDR NOT CURRENT - DEROG', '4 SUFFICIENTLY VERD - DEROG'])                           => lncu_tree_74_c1779,
    rv_6seg_riskview_5_0 = ''                                                                                                             => -0.000244586844240634,
                                                                                                                                               -0.000244586844240634));

lncu_tree_75_c1783 :=     __common__( map(
    NULL < nf_inq_banking_count24 AND nf_inq_banking_count24 < 2.5 => -0.0156798565279076,
    nf_inq_banking_count24 >= 2.5                                  => 0.0218132013872855,
    nf_inq_banking_count24 = NULL                                  => -0.0111994936705905,
                                                                      -0.0111994936705905));

lncu_tree_75_c1782 :=     __common__( map(
    NULL < nf_inq_collection_count24 AND nf_inq_collection_count24 < 0.5 => lncu_tree_75_c1783,
    nf_inq_collection_count24 >= 0.5                                     => 0.0123435266923707,
    nf_inq_collection_count24 = NULL                                     => -0.00206958893047767,
                                                                            -0.00206958893047767));

lncu_tree_75 :=     __common__( map(
    NULL < iv_c13_avg_lres AND iv_c13_avg_lres < 320 => lncu_tree_75_c1782,
    iv_c13_avg_lres >= 320                           => 0.125057473962511,
    iv_c13_avg_lres = NULL                           => -0.000934702093597233,
                                                        -0.000934702093597233));

lncu_tree_76_c1786 :=     __common__( map(
    NULL < nf_fp_varrisktype AND nf_fp_varrisktype < 4.5 => 0.0148463741692355,
    nf_fp_varrisktype >= 4.5                             => 0.0957537867491376,
    nf_fp_varrisktype = NULL                             => 0.0223435861457515,
                                                            0.0223435861457515));

lncu_tree_76_c1785 :=     __common__( map(
    NULL < nf_invbest_inq_adlsperaddr_diff AND nf_invbest_inq_adlsperaddr_diff < -1.5 => -0.00832319641881203,
    nf_invbest_inq_adlsperaddr_diff >= -1.5                                           => lncu_tree_76_c1786,
    nf_invbest_inq_adlsperaddr_diff = NULL                                            => -0.00518577475495441,
                                                                                         -0.00518577475495441));

lncu_tree_76 :=     __common__( map(
    NULL < nf_inq_per_phone AND nf_inq_per_phone < 13.5 => lncu_tree_76_c1785,
    nf_inq_per_phone >= 13.5                            => 0.0600505827676073,
    nf_inq_per_phone = NULL                             => -0.00446771648714167,
                                                           -0.00446771648714167));

lncu_tree_77_c1789 :=     __common__( map(
    NULL < nf_bus_ssn_ver_src_mos_lseen AND nf_bus_ssn_ver_src_mos_lseen < 101 => 0.0169566164993647,
    nf_bus_ssn_ver_src_mos_lseen >= 101                                        => 0.141824715305988,
    nf_bus_ssn_ver_src_mos_lseen = NULL                                        => 0.0624781512541844,
                                                                                  0.0624781512541844));

lncu_tree_77_c1788 :=     __common__( map(
    NULL < nf_bus_ver_src_mos_reg_fseen AND nf_bus_ver_src_mos_reg_fseen < 177.5 => 0.00330646389636445,
    nf_bus_ver_src_mos_reg_fseen >= 177.5                                        => lncu_tree_77_c1789,
    nf_bus_ver_src_mos_reg_fseen = NULL                                          => 0.00542777370930096,
                                                                                    0.00542777370930096));

lncu_tree_77 :=     __common__( map(
    NULL < rv_c18_invalid_addrs_per_adl AND rv_c18_invalid_addrs_per_adl < 5.5 => lncu_tree_77_c1788,
    rv_c18_invalid_addrs_per_adl >= 5.5                                        => -0.0270907337098073,
    rv_c18_invalid_addrs_per_adl = NULL                                        => 0.000800305026805394,
                                                                                  0.000800305026805394));

lncu_tree_78_c1792 :=     __common__( map(
    NULL < nf_invbest_inq_lastperaddr_diff AND nf_invbest_inq_lastperaddr_diff < -0.5 => -0.0177969888861172,
    nf_invbest_inq_lastperaddr_diff >= -0.5                                           => 0.0408847450820028,
    nf_invbest_inq_lastperaddr_diff = NULL                                            => -0.0130223311960912,
                                                                                         -0.0130223311960912));

lncu_tree_78_c1791 :=     __common__( map(
    NULL < rv_l79_adls_per_addr_c6 AND rv_l79_adls_per_addr_c6 < 0.5 => lncu_tree_78_c1792,
    rv_l79_adls_per_addr_c6 >= 0.5                                   => 0.0139367925737794,
    rv_l79_adls_per_addr_c6 = NULL                                   => 0.00209671066528748,
                                                                        0.00209671066528748));

lncu_tree_78 :=     __common__( map(
    NULL < nf_acc_damage_amt_total AND nf_acc_damage_amt_total < 13 => lncu_tree_78_c1791,
    nf_acc_damage_amt_total >= 13                                   => -0.0552859552206855,
    nf_acc_damage_amt_total = NULL                                  => -0.000308897562212357,
                                                                       -0.000308897562212357));

lncu_tree_79_c1794 :=     __common__( map(
    (nf_util_adl_summary in ['CM', 'I', 'IC', 'ICM', 'IM']) => -0.0802133173263336,
    (nf_util_adl_summary in ['', 'C', 'M'])                 => 0.00503182878178021,
    nf_util_adl_summary = ''                             => -0.0383131607647184,
                                                               -0.0383131607647184));

lncu_tree_79_c1795 :=     __common__( map(
    NULL < nf_unvrfd_search_risk_index AND nf_unvrfd_search_risk_index < 8.5 => -0.0028697179289436,
    nf_unvrfd_search_risk_index >= 8.5                                       => 0.0228150054927803,
    nf_unvrfd_search_risk_index = NULL                                       => 4.68164696839032e-05,
                                                                                4.68164696839032e-05));

lncu_tree_79 :=     __common__( map(
    NULL < nf_inq_ssn_lexid_diff01 AND nf_inq_ssn_lexid_diff01 < -0.5 => lncu_tree_79_c1794,
    nf_inq_ssn_lexid_diff01 >= -0.5                                   => lncu_tree_79_c1795,
    nf_inq_ssn_lexid_diff01 = NULL                                    => -0.00170981086408646,
                                                                         -0.00170981086408646));

lncu_tree_80_c1798 :=     __common__( map(
    NULL < rv_c14_addrs_10yr AND rv_c14_addrs_10yr < 6.5 => 0.00709622138993315,
    rv_c14_addrs_10yr >= 6.5                             => 0.0890637300740523,
    rv_c14_addrs_10yr = NULL                             => 0.0108886437332517,
                                                            0.0108886437332517));

lncu_tree_80_c1797 :=     __common__( map(
    NULL < nf_fp_prevaddrlenofres AND nf_fp_prevaddrlenofres < 23.5 => -0.0278008929925668,
    nf_fp_prevaddrlenofres >= 23.5                                  => lncu_tree_80_c1798,
    nf_fp_prevaddrlenofres = NULL                                   => 0.00185603431053563,
                                                                       0.00185603431053563));

lncu_tree_80 :=     __common__( map(
    NULL < nf_inq_corrnameaddr AND nf_inq_corrnameaddr < 11.5 => -0.00289476343730108,
    nf_inq_corrnameaddr >= 11.5                               => -0.0549916847137716,
    nf_inq_corrnameaddr = NULL                                => lncu_tree_80_c1797,
                                                                 -0.00205926252189585));

lncu_tree_81_c1801 :=     __common__( map(
    NULL < nf_dist_inp_curr_no_ver AND nf_dist_inp_curr_no_ver < 6.5 => 0.00468234750673157,
    nf_dist_inp_curr_no_ver >= 6.5                                   => 0.0941096005959652,
    nf_dist_inp_curr_no_ver = NULL                                   => 0.00588235270540544,
                                                                        0.00588235270540544));

lncu_tree_81_c1800 :=     __common__( map(
    NULL < rv_i61_inq_collection_recency AND rv_i61_inq_collection_recency < 0.5 => -0.0185151616784135,
    rv_i61_inq_collection_recency >= 0.5                                         => lncu_tree_81_c1801,
    rv_i61_inq_collection_recency = NULL                                         => 0.000578794606454442,
                                                                                    0.000578794606454442));

lncu_tree_81 :=     __common__( map(
    NULL < nf_inq_communications_count24 AND nf_inq_communications_count24 < 2.5 => lncu_tree_81_c1800,
    nf_inq_communications_count24 >= 2.5                                         => 0.0687496859545568,
    nf_inq_communications_count24 = NULL                                         => 0.00121387782683891,
                                                                                    0.00121387782683891));

lncu_tree_82_c1804 :=     __common__( map(
    NULL < nf_phones_per_addr_curr AND nf_phones_per_addr_curr < 4.5 => -0.00887087421973443,
    nf_phones_per_addr_curr >= 4.5                                   => 0.0137329091801024,
    nf_phones_per_addr_curr = NULL                                   => -0.00212175792845735,
                                                                        -0.00212175792845735));

lncu_tree_82_c1803 :=     __common__( map(
    NULL < nf_inq_addr_recency_risk_index AND nf_inq_addr_recency_risk_index < 0.5 => lncu_tree_82_c1804,
    nf_inq_addr_recency_risk_index >= 0.5                                          => 0.0680574782369576,
    nf_inq_addr_recency_risk_index = NULL                                          => -0.00112525351597284,
                                                                                      -0.00112525351597284));

lncu_tree_82 :=     __common__( map(
    NULL < nf_liens_unrel_ot_total_amt AND nf_liens_unrel_ot_total_amt < 17108.5 => lncu_tree_82_c1803,
    nf_liens_unrel_ot_total_amt >= 17108.5                                       => 0.0969246934027001,
    nf_liens_unrel_ot_total_amt = NULL                                           => -8.26547323762695e-05,
                                                                                    -8.26547323762695e-05));

lncu_tree_83_c1807 :=     __common__( map(
    NULL < rv_i60_inq_prepaidcards_recency AND rv_i60_inq_prepaidcards_recency < 15 => -0.0226780793657134,
    rv_i60_inq_prepaidcards_recency >= 15                                           => 0.0635224853382717,
    rv_i60_inq_prepaidcards_recency = NULL                                          => -0.0189636698311347,
                                                                                       -0.0189636698311347));

lncu_tree_83_c1806 :=     __common__( map(
    NULL < nf_inq_percurraddr_count12 AND nf_inq_percurraddr_count12 < 18.5 => lncu_tree_83_c1807,
    nf_inq_percurraddr_count12 >= 18.5                                      => 0.094877038794694,
    nf_inq_percurraddr_count12 = NULL                                       => -0.0165152218815587,
                                                                               -0.0165152218815587));

lncu_tree_83 :=     __common__( map(
    NULL < nf_m_src_credentialed_fs AND nf_m_src_credentialed_fs < 221.5 => 0.00732681958587433,
    nf_m_src_credentialed_fs >= 221.5                                    => lncu_tree_83_c1806,
    nf_m_src_credentialed_fs = NULL                                      => -0.00136320111662999,
                                                                            -0.00136320111662999));

lncu_tree_84_c1810 :=     __common__( map(
    (nf_util_add_input_summary in ['', 'ICM', 'IM'])           => -0.0208400062438358,
    (nf_util_add_input_summary in ['C', 'CM', 'I', 'IC', 'M']) => 0.00607947964420594,
    nf_util_add_input_summary = ''                           => 0.00202696226793606,
                                                                  0.00202696226793606));

lncu_tree_84_c1809 :=     __common__( map(
    NULL < nf_inq_adlsperphone_count_week AND nf_inq_adlsperphone_count_week < 0.5 => lncu_tree_84_c1810,
    nf_inq_adlsperphone_count_week >= 0.5                                          => 0.0633394571259404,
    nf_inq_adlsperphone_count_week = NULL                                          => 0.0028154983368865,
                                                                                      0.0028154983368865));

lncu_tree_84 :=     __common__( map(
    NULL < rv_d34_liens_rel_total_amt84 AND rv_d34_liens_rel_total_amt84 < 856.5 => lncu_tree_84_c1809,
    rv_d34_liens_rel_total_amt84 >= 856.5                                        => -0.0447206425352693,
    rv_d34_liens_rel_total_amt84 = NULL                                          => -0.00024730223165016,
                                                                                    -0.00024730223165016));

lncu_tree_85_c1813 :=     __common__( map(
    NULL < nf_unvrfd_search_risk_index AND nf_unvrfd_search_risk_index < 4 => -0.0391531554585242,
    nf_unvrfd_search_risk_index >= 4                                       => 0.0657357588333454,
    nf_unvrfd_search_risk_index = NULL                                     => 0.00600734930603079,
                                                                              0.00600734930603079));

lncu_tree_85_c1812 :=     __common__( map(
    NULL < nf_inq_phone_ver_count AND nf_inq_phone_ver_count < 7.5 => 0.125132389807702,
    nf_inq_phone_ver_count >= 7.5                                  => lncu_tree_85_c1813,
    nf_inq_phone_ver_count = NULL                                  => 0.0331044615231491,
                                                                      0.0331044615231491));

lncu_tree_85 :=     __common__( map(
    NULL < nf_inq_per_phone AND nf_inq_per_phone < 8.5 => -0.00315808830622147,
    nf_inq_per_phone >= 8.5                            => lncu_tree_85_c1812,
    nf_inq_per_phone = NULL                            => -0.00183013204246143,
                                                          -0.00183013204246143));

lncu_tree_86_c1816 :=     __common__( map(
    NULL < (INTEGER)iv_inf_lname_verd AND (INTEGER)iv_inf_lname_verd < 0.5 => 0.0425615114304152,
    (INTEGER)iv_inf_lname_verd >= 0.5                             => -0.0337491199487085,
    (INTEGER)iv_inf_lname_verd = NULL                             => 0.0219139344081507,
                                                            0.0219139344081507));

lncu_tree_86_c1815 :=     __common__( map(
    NULL < nf_inq_phone_ver_count AND nf_inq_phone_ver_count < 0.5 => lncu_tree_86_c1816,
    nf_inq_phone_ver_count >= 0.5                                  => -0.000974680902754963,
    nf_inq_phone_ver_count = NULL                                  => 0.0109218148462413,
                                                                      0.00340194728287454));

lncu_tree_86 :=     __common__( map(
    (nf_util_add_input_summary in ['', 'C', 'ICM', 'IM']) => -0.0169433458813393,
    (nf_util_add_input_summary in ['CM', 'I', 'IC', 'M']) => lncu_tree_86_c1815,
    nf_util_add_input_summary = ''                      => -0.00296108576382964,
                                                             -0.00296108576382964));

lncu_tree_87_c1819 :=     __common__( map(
    NULL < nf_inq_auto_count24 AND nf_inq_auto_count24 < 0.5 => 0.0971880790622351,
    nf_inq_auto_count24 >= 0.5                               => 0.00536588980495828,
    nf_inq_auto_count24 = NULL                               => 0.0316513175384278,
                                                                0.0316513175384278));

lncu_tree_87_c1818 :=     __common__( map(
    NULL < nf_inq_adls_per_phone AND nf_inq_adls_per_phone < 1.5 => -0.00321212798532188,
    nf_inq_adls_per_phone >= 1.5                                 => lncu_tree_87_c1819,
    nf_inq_adls_per_phone = NULL                                 => -0.00100446873780107,
                                                                    -0.00100446873780107));

lncu_tree_87 :=     __common__( map(
    NULL < rv_c24_prv_addr_lres AND rv_c24_prv_addr_lres < 0.5 => 0.0600472503486596,
    rv_c24_prv_addr_lres >= 0.5                                => lncu_tree_87_c1818,
    rv_c24_prv_addr_lres = NULL                                => -0.0508683876155221,
                                                                  -0.000312591159408863));

lncu_tree_88_c1822 :=     __common__( map(
    NULL < nf_inq_fname_ver_count AND nf_inq_fname_ver_count < 32.5 => 0.0248673527674817,
    nf_inq_fname_ver_count >= 32.5                                  => 0.0943120586222752,
    nf_inq_fname_ver_count = NULL                                   => 0.0436334799276643,
                                                                       0.0436334799276643));

lncu_tree_88_c1821 :=     __common__( map(
    NULL < nf_mos_liens_unrel_st_fseen AND nf_mos_liens_unrel_st_fseen < 95.5 => 0.00224491443838893,
    nf_mos_liens_unrel_st_fseen >= 95.5                                       => lncu_tree_88_c1822,
    nf_mos_liens_unrel_st_fseen = NULL                                        => 0.00486669468373334,
                                                                                 0.00486669468373334));

lncu_tree_88 :=     __common__( map(
    (rv_e58_br_dead_bus_x_active_phn in ['0-1', '0-2', '0-3', '1-0', '2-0', '2-1', '2-3', '3-0', '3-2']) => -0.031360208524015,
    (rv_e58_br_dead_bus_x_active_phn in ['', '0-0', '1-1', '1-2', '1-3', '2-2', '3-1', '3-3'])           => lncu_tree_88_c1821,
    rv_e58_br_dead_bus_x_active_phn = ''                                                               => -0.000593193070893947,
                                                                                                            -0.000593193070893947));

lncu_tree_89_c1825 :=     __common__( map(
    NULL < rv_p88_phn_dst_to_inp_add AND rv_p88_phn_dst_to_inp_add < 29.5 => 0.00190447139850204,
    rv_p88_phn_dst_to_inp_add >= 29.5                                     => -0.0384263332722104,
    rv_p88_phn_dst_to_inp_add = NULL                                      => 0.00431608741513092,
                                                                             0.000398241461981092));

lncu_tree_89_c1824 :=     __common__( map(
    (ip_topleveldomain_lvl in ['', '-1', 'COM', 'DOT', 'EDU', 'GOV', 'NET', 'TWO']) => lncu_tree_89_c1825,
    (ip_topleveldomain_lvl in ['ORG', 'OTH', 'US'])                                 => 0.095762266323286,
    ip_topleveldomain_lvl = ''                                                    => 0.00140507878717924,
                                                                                       0.00140507878717924));

lncu_tree_89 :=     __common__( map(
    NULL < nf_inq_ssn_lexid_diff01 AND nf_inq_ssn_lexid_diff01 < -1.5 => -0.0767460186844001,
    nf_inq_ssn_lexid_diff01 >= -1.5                                   => lncu_tree_89_c1824,
    nf_inq_ssn_lexid_diff01 = NULL                                    => 0.000252407733026148,
                                                                         0.000252407733026148));

lncu_tree_90_c1828 :=     __common__( map(
    NULL < rv_d34_mos_last_unrel_lien_dt84 AND rv_d34_mos_last_unrel_lien_dt84 < 68.5 => -0.00497962763990021,
    rv_d34_mos_last_unrel_lien_dt84 >= 68.5                                           => 0.0920077206824628,
    rv_d34_mos_last_unrel_lien_dt84 = NULL                                            => 0.0169691776062761,
                                                                                         0.0159629002086147));

lncu_tree_90_c1827 :=     __common__( map(
    (ip_topleveldomain_lvl in ['-1', 'EDU', 'GOV', 'NET', 'ORG'])     => -0.00598284467563559,
    (ip_topleveldomain_lvl in ['', 'COM', 'DOT', 'OTH', 'TWO', 'US']) => lncu_tree_90_c1828,
    ip_topleveldomain_lvl = ''                                      => 0.00367477204217902,
                                                                         0.00367477204217902));

lncu_tree_90 :=     __common__( map(
    (ip_routingmethod in ['', '06', '12', '13', '16'])   => -0.0281989862128543,
    (ip_routingmethod in ['02', '10', '11', '14', '15']) => lncu_tree_90_c1827,
    ip_routingmethod = ''                              => -0.00196222522911139,
                                                            -0.00196222522911139));

lncu_tree_91_c1831 :=     __common__( map(
    NULL < rv_c23_email_domain_isp_cnt AND rv_c23_email_domain_isp_cnt < 0.5 => 0.0121596622561175,
    rv_c23_email_domain_isp_cnt >= 0.5                                       => -0.00819632229353624,
    rv_c23_email_domain_isp_cnt = NULL                                       => 0.000528142473733089,
                                                                                0.000528142473733089));

lncu_tree_91_c1830 :=     __common__( map(
    NULL < rv_c10_m_hdr_fs AND rv_c10_m_hdr_fs < 31.5 => -0.0878806525215123,
    rv_c10_m_hdr_fs >= 31.5                           => lncu_tree_91_c1831,
    rv_c10_m_hdr_fs = NULL                            => -0.000246064857710773,
                                                         -0.000246064857710773));

lncu_tree_91 :=     __common__( map(
    NULL < nf_inq_bestdob_ver_count AND nf_inq_bestdob_ver_count < 65.5 => lncu_tree_91_c1830,
    nf_inq_bestdob_ver_count >= 65.5                                    => 0.0741932957202288,
    nf_inq_bestdob_ver_count = NULL                                     => 0.0157132279473925,
                                                                           0.00108956475933636));

lncu_tree_92_c1834 :=     __common__( map(
    NULL < rv_l79_adls_per_addr_c6 AND rv_l79_adls_per_addr_c6 < 1.5 => 0.0361342074862634,
    rv_l79_adls_per_addr_c6 >= 1.5                                   => 0.142893669696202,
    rv_l79_adls_per_addr_c6 = NULL                                   => 0.0681303667836039,
                                                                        0.0681303667836039));

lncu_tree_92_c1833 :=     __common__( map(
    NULL < rv_c14_addrs_15yr AND rv_c14_addrs_15yr < 4.5 => lncu_tree_92_c1834,
    rv_c14_addrs_15yr >= 4.5                             => -0.0143101672686743,
    rv_c14_addrs_15yr = NULL                             => 0.0340913309466876,
                                                            0.0340913309466876));

lncu_tree_92 :=     __common__( map(
    NULL < nf_inq_ssn_lexid_diff01 AND nf_inq_ssn_lexid_diff01 < 1.5 => -2.54540819767455e-06,
    nf_inq_ssn_lexid_diff01 >= 1.5                                   => lncu_tree_92_c1833,
    nf_inq_ssn_lexid_diff01 = NULL                                   => 0.0015163838860979,
                                                                        0.0015163838860979));

lncu_tree_93_c1837 :=     __common__( map(
    (nf_util_adl_summary in ['CM', 'IC', 'IM', 'M']) => -0.044933694787205,
    (nf_util_adl_summary in ['', 'C', 'I', 'ICM'])   => 0.0674291296532189,
    nf_util_adl_summary = ''                       => 0.00217225853589579,
                                                        0.00217225853589579));

lncu_tree_93_c1836 :=     __common__( map(
    NULL < nf_inq_adls_per_addr AND nf_inq_adls_per_addr < 1.5 => lncu_tree_93_c1837,
    nf_inq_adls_per_addr >= 1.5                                => -0.0726670437093454,
    nf_inq_adls_per_addr = NULL                                => -0.0310006227591041,
                                                                  -0.0310006227591041));

lncu_tree_93 :=     __common__( map(
    NULL < rv_i60_inq_peradl_count12 AND rv_i60_inq_peradl_count12 < 13.5 => 0.00190925121568965,
    rv_i60_inq_peradl_count12 >= 13.5                                     => lncu_tree_93_c1836,
    rv_i60_inq_peradl_count12 = NULL                                      => 0.000716383228556099,
                                                                             0.000716383228556099));

lncu_tree_94_c1840 :=     __common__( map(
    NULL < nf_inq_corrphonessn AND nf_inq_corrphonessn < 3.5 => 0.0803935813111615,
    nf_inq_corrphonessn >= 3.5                               => -0.0138344570338369,
    nf_inq_corrphonessn = NULL                               => 0.0225659632583406,
                                                                0.0225659632583406));

lncu_tree_94_c1839 :=     __common__( map(
    NULL < nf_inq_perbestssn_count12 AND nf_inq_perbestssn_count12 < 10.5 => -0.003954151458672,
    nf_inq_perbestssn_count12 >= 10.5                                     => lncu_tree_94_c1840,
    nf_inq_perbestssn_count12 = NULL                                      => -0.00232010082218888,
                                                                             -0.00232010082218888));

lncu_tree_94 :=     __common__( map(
    NULL < nf_phone_ver_bureau AND nf_phone_ver_bureau < -0.5 => -0.067952694428427,
    nf_phone_ver_bureau >= -0.5                               => lncu_tree_94_c1839,
    nf_phone_ver_bureau = NULL                                => -0.00387890039091822,
                                                                 -0.00387890039091822));

lncu_tree_95_c1843 :=     __common__( map(
    (rv_e58_br_dead_bus_x_active_phn in ['0-1', '0-2', '1-0', '1-1', '2-0', '3-0'])                                 => -0.0320126685912194,
    (rv_e58_br_dead_bus_x_active_phn in ['', '0-0', '0-3', '1-2', '1-3', '2-1', '2-2', '2-3', '3-1', '3-2', '3-3']) => 0.0773809238469217,
    rv_e58_br_dead_bus_x_active_phn = ''                                                                          => 0.0585199596334491,
                                                                                                                       0.0585199596334491));

lncu_tree_95_c1842 :=     __common__( map(
    NULL < rv_c14_unverified_addr_count AND rv_c14_unverified_addr_count < 3.5 => 0.00889791884507364,
    rv_c14_unverified_addr_count >= 3.5                                        => lncu_tree_95_c1843,
    rv_c14_unverified_addr_count = NULL                                        => 0.0299258103354462,
                                                                                  0.0299258103354462));

lncu_tree_95 :=     __common__( map(
    NULL < nf_inq_lnames_per_apt_addr AND nf_inq_lnames_per_apt_addr < 0.5 => -0.00279842976743053,
    nf_inq_lnames_per_apt_addr >= 0.5                                      => lncu_tree_95_c1842,
    nf_inq_lnames_per_apt_addr = NULL                                      => 0.00120198928330898,
                                                                              0.00120198928330898));

lncu_tree_96_c1846 :=     __common__( map(
    NULL < nf_historical_count AND nf_historical_count < 11.5 => -0.000860767323395071,
    nf_historical_count >= 11.5                               => 0.120107607443865,
    nf_historical_count = NULL                                => 0.00738125905727733,
                                                                 0.00738125905727733));

lncu_tree_96_c1845 :=     __common__( map(
    NULL < rv_f00_inq_corrdobaddr_adl AND rv_f00_inq_corrdobaddr_adl < 8.5 => 0.00895838239361736,
    rv_f00_inq_corrdobaddr_adl >= 8.5                                      => 0.0951800541024715,
    rv_f00_inq_corrdobaddr_adl = NULL                                      => lncu_tree_96_c1846,
                                                                              0.0100320132736955));

lncu_tree_96 :=     __common__( map(
    NULL < nf_inq_corrdobaddr AND nf_inq_corrdobaddr < 9.5 => -0.00192858330398771,
    nf_inq_corrdobaddr >= 9.5                              => -0.0376333533498851,
    nf_inq_corrdobaddr = NULL                              => lncu_tree_96_c1845,
                                                              0.00221251966690569));

lncu_tree_97_c1849 :=     __common__( map(
    NULL < rv_c13_max_lres AND rv_c13_max_lres < 117 => 0.00838691234760301,
    rv_c13_max_lres >= 117                           => 0.0980721579485244,
    rv_c13_max_lres = NULL                           => 0.0582505238013971,
                                                        0.0582505238013971));

lncu_tree_97_c1848 :=     __common__( map(
    NULL < rv_i61_inq_collection_recency AND rv_i61_inq_collection_recency < 9 => lncu_tree_97_c1849,
    rv_i61_inq_collection_recency >= 9                                         => -0.0257657494783105,
    rv_i61_inq_collection_recency = NULL                                       => 0.0309014765098256,
                                                                                  0.0309014765098256));

lncu_tree_97 :=     __common__( map(
    NULL < nf_fp_srchunvrfdphonecount AND nf_fp_srchunvrfdphonecount < 2.5 => -0.00373873143611671,
    nf_fp_srchunvrfdphonecount >= 2.5                                      => lncu_tree_97_c1848,
    nf_fp_srchunvrfdphonecount = NULL                                      => -0.00270630052558878,
                                                                              -0.00270630052558878));

lncu_tree_98_c1852 :=     __common__( map(
    NULL < iv_c13_avg_lres AND iv_c13_avg_lres < 25.5 => 0.0780421009081173,
    iv_c13_avg_lres >= 25.5                           => 0.00351631308995254,
    iv_c13_avg_lres = NULL                            => 0.00794803099558672,
                                                         0.00794803099558672));

lncu_tree_98_c1851 :=     __common__( map(
    NULL < nf_inq_bestdob_ver_count AND nf_inq_bestdob_ver_count < 65.5 => lncu_tree_98_c1852,
    nf_inq_bestdob_ver_count >= 65.5                                    => 0.110445048831623,
    nf_inq_bestdob_ver_count = NULL                                     => 0.011737337200471,
                                                                           0.011737337200471));

lncu_tree_98 :=     __common__( map(
    NULL < rv_c23_email_domain_free_cnt AND rv_c23_email_domain_free_cnt < 3.5 => -0.00819801747943577,
    rv_c23_email_domain_free_cnt >= 3.5                                        => lncu_tree_98_c1851,
    rv_c23_email_domain_free_cnt = NULL                                        => -0.00388160538392611,
                                                                                  -0.00388160538392611));

lncu_tree_99_c1855 :=     __common__( map(
    NULL < rv_d33_attr_eviction_ct84 AND rv_d33_attr_eviction_ct84 < 0.5 => 0.00577822118978572,
    rv_d33_attr_eviction_ct84 >= 0.5                                     => 0.0558378459209973,
    rv_d33_attr_eviction_ct84 = NULL                                     => 0.00834512025017137,
                                                                            0.00834512025017137));

lncu_tree_99_c1854 :=     __common__( map(
    NULL < rv_d34_liens_rel_total_amt AND rv_d34_liens_rel_total_amt < 453 => lncu_tree_99_c1855,
    rv_d34_liens_rel_total_amt >= 453                                      => -0.017725406769138,
    rv_d34_liens_rel_total_amt = NULL                                      => 0.00291139842316221,
                                                                              0.00291139842316221));

lncu_tree_99 :=     __common__( map(
    NULL < nf_acc_damage_amt_total AND nf_acc_damage_amt_total < 550 => lncu_tree_99_c1854,
    nf_acc_damage_amt_total >= 550                                   => -0.0548342434051795,
    nf_acc_damage_amt_total = NULL                                   => 0.000835604000295583,
                                                                        0.000835604000295583));

lncu_tree_100_c1858 :=     __common__( map(
    NULL < nf_inq_per_apt_addr AND nf_inq_per_apt_addr < 4.5 => 0.0073530375166465,
    nf_inq_per_apt_addr >= 4.5                               => 0.0597429270451171,
    nf_inq_per_apt_addr = NULL                               => 0.00899060345945384,
                                                                0.00899060345945384));

lncu_tree_100_c1857 :=     __common__( map(
    (nf_util_add_input_summary in ['', 'C', 'ICM'])             => -0.0151723399313272,
    (nf_util_add_input_summary in ['CM', 'I', 'IC', 'IM', 'M']) => lncu_tree_100_c1858,
    nf_util_add_input_summary = ''                            => 0.00147742914627118,
                                                                   0.00147742914627118));

lncu_tree_100 :=     __common__( map(
    NULL < iv_inq_auto_count01 AND iv_inq_auto_count01 < 0.5 => lncu_tree_100_c1857,
    iv_inq_auto_count01 >= 0.5                               => -0.0498001712556878,
    iv_inq_auto_count01 = NULL                               => -0.000270037596195827,
                                                                -0.000270037596195827));

lncu_tree_101_c1861 :=     __common__( map(
    NULL < rv_c14_addrs_5yr AND rv_c14_addrs_5yr < 3.5 => -0.00555526598953352,
    rv_c14_addrs_5yr >= 3.5                            => 0.107677355403274,
    rv_c14_addrs_5yr = NULL                            => 0.00425608330728643,
                                                          0.00425608330728643));

lncu_tree_101_c1860 :=     __common__( map(
    NULL < nf_inq_adlsperaddr_recency AND nf_inq_adlsperaddr_recency < 2 => lncu_tree_101_c1861,
    nf_inq_adlsperaddr_recency >= 2                                      => -0.0351376397147846,
    nf_inq_adlsperaddr_recency = NULL                                    => -0.0177989832549296,
                                                                            -0.0177989832549296));

lncu_tree_101 :=     __common__( map(
    NULL < rv_i60_inq_retail_recency AND rv_i60_inq_retail_recency < 4.5 => 0.00674033793662034,
    rv_i60_inq_retail_recency >= 4.5                                     => lncu_tree_101_c1860,
    rv_i60_inq_retail_recency = NULL                                     => 0.000648355281663927,
                                                                            0.000648355281663927));

lncu_tree_102_c1864 :=     __common__( map(
    NULL < rv_c20_m_bureau_adl_fs AND rv_c20_m_bureau_adl_fs < 284.5 => 0.0654364380814226,
    rv_c20_m_bureau_adl_fs >= 284.5                                  => -0.0275010841073601,
    rv_c20_m_bureau_adl_fs = NULL                                    => 0.00684862409361396,
                                                                        0.00684862409361396));

lncu_tree_102_c1863 :=     __common__( map(
    NULL < rv_f04_curr_add_occ_index AND rv_f04_curr_add_occ_index < 2 => lncu_tree_102_c1864,
    rv_f04_curr_add_occ_index >= 2                                     => 0.12989581638981,
    rv_f04_curr_add_occ_index = NULL                                   => 0.0272195878382446,
                                                                          0.0272195878382446));

lncu_tree_102 :=     __common__( map(
    NULL < nf_mos_liens_unrel_st_fseen AND nf_mos_liens_unrel_st_fseen < 100.5 => -0.00445439106624347,
    nf_mos_liens_unrel_st_fseen >= 100.5                                       => lncu_tree_102_c1863,
    nf_mos_liens_unrel_st_fseen = NULL                                         => -0.00261262333086101,
                                                                                  -0.00261262333086101));

lncu_tree_103_c1867 :=     __common__( map(
    NULL < nf_bus_ver_src_mos_reg_fseen AND nf_bus_ver_src_mos_reg_fseen < 72.5 => 0.121584853785951,
    nf_bus_ver_src_mos_reg_fseen >= 72.5                                        => 0.0197552046776898,
    nf_bus_ver_src_mos_reg_fseen = NULL                                         => 0.032969033917691,
                                                                                   0.032969033917691));

lncu_tree_103_c1866 :=     __common__( map(
    NULL < nf_bus_ver_src_mos_reg_lseen AND nf_bus_ver_src_mos_reg_lseen < 32.5 => -0.000806713769084829,
    nf_bus_ver_src_mos_reg_lseen >= 32.5                                        => lncu_tree_103_c1867,
    nf_bus_ver_src_mos_reg_lseen = NULL                                         => 0.00212429449541056,
                                                                                   0.00212429449541056));

lncu_tree_103 :=     __common__( map(
    NULL < nf_inq_addrsperbestssn_count12 AND nf_inq_addrsperbestssn_count12 < 3.5 => lncu_tree_103_c1866,
    nf_inq_addrsperbestssn_count12 >= 3.5                                          => -0.0700640962696061,
    nf_inq_addrsperbestssn_count12 = NULL                                          => 0.00116566944137485,
                                                                                      0.00116566944137485));

lncu_tree_104_c1869 :=     __common__( map(
    NULL < nf_inq_per_phone AND nf_inq_per_phone < 3.5 => -0.00417356558675947,
    nf_inq_per_phone >= 3.5                            => 0.0230411903205333,
    nf_inq_per_phone = NULL                            => -0.000292480140268063,
                                                          -0.000292480140268063));

lncu_tree_104_c1870 :=     __common__( map(
    NULL < nf_bus_ver_src_mos_reg_fseen AND nf_bus_ver_src_mos_reg_fseen < 0 => -0.0467485597540963,
    nf_bus_ver_src_mos_reg_fseen >= 0                                        => 0.0265096590627862,
    nf_bus_ver_src_mos_reg_fseen = NULL                                      => -0.0342599003072815,
                                                                                -0.0342599003072815));

lncu_tree_104 :=     __common__( map(
    NULL < nf_inq_ssn_ver_count AND nf_inq_ssn_ver_count < 38.5 => lncu_tree_104_c1869,
    nf_inq_ssn_ver_count >= 38.5                                => lncu_tree_104_c1870,
    nf_inq_ssn_ver_count = NULL                                 => 0.00903222921046764,
                                                                   -0.00319268379782625));

lncu_tree_105_c1873 :=     __common__( map(
    NULL < nf_bus_ver_src_mos_reg_lseen AND nf_bus_ver_src_mos_reg_lseen < 40.5 => -0.0256375938340437,
    nf_bus_ver_src_mos_reg_lseen >= 40.5                                        => 0.0443517494002049,
    nf_bus_ver_src_mos_reg_lseen = NULL                                         => -0.0189396889438844,
                                                                                   -0.0189396889438844));

lncu_tree_105_c1872 :=     __common__( map(
    (nf_historic_x_current_ct in ['1-0', '2-0', '2-1', '2-2', '3-0', '3-1', '3-2', '3-3']) => lncu_tree_105_c1873,
    (nf_historic_x_current_ct in ['', '0-0', '1-1'])                                       => 0.0143010720958018,
    nf_historic_x_current_ct = ''                                                        => -0.0111844248266287,
                                                                                              -0.0111844248266287));

lncu_tree_105 :=     __common__( map(
    NULL < rv_c23_email_domain_isp_cnt AND rv_c23_email_domain_isp_cnt < 0.5 => 0.00868785885719171,
    rv_c23_email_domain_isp_cnt >= 0.5                                       => lncu_tree_105_c1872,
    rv_c23_email_domain_isp_cnt = NULL                                       => -0.00254295964341746,
                                                                                -0.00254295964341746));

lncu_tree_106_c1876 :=     __common__( map(
    NULL < ip_state_match AND ip_state_match < 0.5 => 0.0438041216605566,
    ip_state_match >= 0.5                          => -0.0104667152459312,
    ip_state_match = NULL                          => -0.000103202779580752,
                                                      -0.000103202779580752));

lncu_tree_106_c1875 :=     __common__( map(
    NULL < nf_m_bureau_adl_fs_all AND nf_m_bureau_adl_fs_all < 201.5 => -0.0278069530115556,
    nf_m_bureau_adl_fs_all >= 201.5                                  => lncu_tree_106_c1876,
    nf_m_bureau_adl_fs_all = NULL                                    => -0.00983934503362944,
                                                                        -0.00983934503362944));

lncu_tree_106 :=     __common__( map(
     '' < nf_fpc_source_dl AND nf_fpc_source_dl < '2' => lncu_tree_106_c1875,
    nf_fpc_source_dl >= '2'                            => 0.0121195821173409,
   nf_fpc_source_dl = ''                          => 0.00304929401220867,
                                                        0.00304929401220867));

lncu_tree_107_c1878 :=     __common__( map(
    NULL < nf_corraddrname AND nf_corraddrname < 3.5 => -0.0504826101337094,
    nf_corraddrname >= 3.5                           => -0.00483216154090905,
    nf_corraddrname = NULL                           => -0.0186301480826498,
                                                        -0.0186301480826498));

lncu_tree_107_c1879 :=     __common__( map(
    NULL < rv_mos_since_br_first_seen AND rv_mos_since_br_first_seen < 33.5 => 0.00791360696849061,
    rv_mos_since_br_first_seen >= 33.5                                      => -0.0214981425456064,
    rv_mos_since_br_first_seen = NULL                                       => 0.00241195931505845,
                                                                               0.00241195931505845));

lncu_tree_107 :=     __common__( map(
    NULL < rv_i61_inq_collection_recency AND rv_i61_inq_collection_recency < 0.5 => lncu_tree_107_c1878,
    rv_i61_inq_collection_recency >= 0.5                                         => lncu_tree_107_c1879,
    rv_i61_inq_collection_recency = NULL                                         => -0.00230054494222988,
                                                                                    -0.00230054494222988));

lncu_tree_108_c1881 :=     __common__( map(
    NULL < rv_c18_invalid_addrs_per_adl AND rv_c18_invalid_addrs_per_adl < 4.5 => 0.00319575898961873,
    rv_c18_invalid_addrs_per_adl >= 4.5                                        => -0.0213579008428296,
    rv_c18_invalid_addrs_per_adl = NULL                                        => -0.00175219899304141,
                                                                                  -0.00175219899304141));

lncu_tree_108_c1882 :=     __common__( map(
    NULL < rv_i62_inq_dobsperadl_recency AND rv_i62_inq_dobsperadl_recency < 4.5 => 0.00449038035833467,
    rv_i62_inq_dobsperadl_recency >= 4.5                                         => 0.145291492941709,
    rv_i62_inq_dobsperadl_recency = NULL                                         => 0.0768109518216131,
                                                                                    0.0768109518216131));

lncu_tree_108 :=     __common__( map(
    NULL < nf_liens_unrel_cj_total_amt AND nf_liens_unrel_cj_total_amt < 20005 => lncu_tree_108_c1881,
    nf_liens_unrel_cj_total_amt >= 20005                                       => lncu_tree_108_c1882,
    nf_liens_unrel_cj_total_amt = NULL                                         => -0.000410698435821297,
                                                                                  -0.000410698435821297));

lncu_tree_109_c1885 :=     __common__( map(
    NULL < rv_c20_m_bureau_adl_fs AND rv_c20_m_bureau_adl_fs < 203.5 => 0.150856287653463,
    rv_c20_m_bureau_adl_fs >= 203.5                                  => 0.0188619608681998,
    rv_c20_m_bureau_adl_fs = NULL                                    => 0.0355872693992091,
                                                                        0.0355872693992091));

lncu_tree_109_c1884 :=     __common__( map(
    NULL < nf_mos_liens_unrel_st_lseen AND nf_mos_liens_unrel_st_lseen < 56.5 => 0.00149529049584623,
    nf_mos_liens_unrel_st_lseen >= 56.5                                       => lncu_tree_109_c1885,
    nf_mos_liens_unrel_st_lseen = NULL                                        => 0.00386964043378119,
                                                                                 0.00386964043378119));

lncu_tree_109 :=     __common__( map(
    NULL < rv_i60_inq_peradl_count12 AND rv_i60_inq_peradl_count12 < 15.5 => lncu_tree_109_c1884,
    rv_i60_inq_peradl_count12 >= 15.5                                     => -0.0408718750942531,
    rv_i60_inq_peradl_count12 = NULL                                      => 0.00280701207678193,
                                                                             0.00280701207678193));

lncu_tree_110_c1888 :=     __common__( map(
    NULL < nf_ssns_per_curraddr_curr AND nf_ssns_per_curraddr_curr < 1.5 => -0.0361916285470555,
    nf_ssns_per_curraddr_curr >= 1.5                                     => 0.0290755943937619,
    nf_ssns_per_curraddr_curr = NULL                                     => 0.0197552371783498,
                                                                            0.0197552371783498));

lncu_tree_110_c1887 :=     __common__( map(
    NULL < rv_c12_source_profile AND rv_c12_source_profile < 46.6 => lncu_tree_110_c1888,
    rv_c12_source_profile >= 46.6                                 => -0.00366679886965208,
    rv_c12_source_profile = NULL                                  => 0.00118827141667996,
                                                                     0.00118827141667996));

lncu_tree_110 :=     __common__( map(
    NULL < rv_d31_bk_filing_count AND rv_d31_bk_filing_count < 3.5 => lncu_tree_110_c1887,
    rv_d31_bk_filing_count >= 3.5                                  => 0.106245441498498,
    rv_d31_bk_filing_count = NULL                                  => 0.00238701425623808,
                                                                      0.00238701425623808));

lncu_tree_111_c1891 :=     __common__( map(
    NULL < nf_inq_adlsperssn_recency AND nf_inq_adlsperssn_recency < 9 => 0.147388244095732,
    nf_inq_adlsperssn_recency >= 9                                     => 0.0318364529815062,
    nf_inq_adlsperssn_recency = NULL                                   => 0.0728514232063509,
                                                                          0.0728514232063509));

lncu_tree_111_c1890 :=     __common__( map(
    NULL < rv_f00_inq_corraddrphone_adl AND rv_f00_inq_corraddrphone_adl < 3.5 => lncu_tree_111_c1891,
    rv_f00_inq_corraddrphone_adl >= 3.5                                        => -0.0161361509395039,
    rv_f00_inq_corraddrphone_adl = NULL                                        => 0.0378459592566358,
                                                                                  0.0378459592566358));

lncu_tree_111 :=     __common__( map(
    NULL < nf_inq_count24 AND nf_inq_count24 < 15.5 => -0.00322325097399402,
    nf_inq_count24 >= 15.5                          => lncu_tree_111_c1890,
    nf_inq_count24 = NULL                           => -0.00152106545217189,
                                                       -0.00152106545217189));

lncu_tree_112_c1893 :=     __common__( map(
    NULL < nf_fp_idverrisktype AND nf_fp_idverrisktype < 3.5 => 0.000342256548933354,
    nf_fp_idverrisktype >= 3.5                               => -0.0451973745344039,
    nf_fp_idverrisktype = NULL                               => -0.00126353868340302,
                                                                -0.00126353868340302));

lncu_tree_112_c1894 :=     __common__( map(
    NULL < iv_c14_addrs_per_adl AND iv_c14_addrs_per_adl < 6.5 => 0.107722162526335,
    iv_c14_addrs_per_adl >= 6.5                                => -0.0108170133310728,
    iv_c14_addrs_per_adl = NULL                                => 0.0434757389700301,
                                                                  0.0434757389700301));

lncu_tree_112 :=     __common__( map(
    NULL < nf_fp_srchphonesrchcountmo AND nf_fp_srchphonesrchcountmo < 2.5 => lncu_tree_112_c1893,
    nf_fp_srchphonesrchcountmo >= 2.5                                      => lncu_tree_112_c1894,
    nf_fp_srchphonesrchcountmo = NULL                                      => -0.000353610819313635,
                                                                              -0.000353610819313635));

lncu_tree_113_c1897 :=     __common__( map(
    NULL < nf_inq_ssn_lexid_diff01 AND nf_inq_ssn_lexid_diff01 < 0.5 => -0.0043517546785791,
    nf_inq_ssn_lexid_diff01 >= 0.5                                   => 0.01924649519263,
    nf_inq_ssn_lexid_diff01 = NULL                                   => -0.00139709454749983,
                                                                        -0.00139709454749983));

lncu_tree_113_c1896 :=     __common__( map(
    NULL < nf_corroboration_risk_index AND nf_corroboration_risk_index < 24.5 => -0.0478223496230713,
    nf_corroboration_risk_index >= 24.5                                       => lncu_tree_113_c1897,
    nf_corroboration_risk_index = NULL                                        => -0.00378954827600014,
                                                                                 -0.00378954827600014));

lncu_tree_113 :=     __common__( map(
    NULL < nf_inq_perphone_count12 AND nf_inq_perphone_count12 < 13.5 => lncu_tree_113_c1896,
    nf_inq_perphone_count12 >= 13.5                                   => 0.0643439693616093,
    nf_inq_perphone_count12 = NULL                                    => -0.0030913397263406,
                                                                         -0.0030913397263406));

lncu_tree_114_c1900 :=     __common__( map(
    NULL < iv_nap_inf_phone_ver_lvl AND iv_nap_inf_phone_ver_lvl < 0.5 => 0.0492047619067368,
    iv_nap_inf_phone_ver_lvl >= 0.5                                    => -0.00279209620057845,
    iv_nap_inf_phone_ver_lvl = NULL                                    => 0.0280580345426292,
                                                                          0.0280580345426292));

lncu_tree_114_c1899 :=     __common__( map(
    NULL < nf_phone_ver_bureau AND nf_phone_ver_bureau < 0.5 => lncu_tree_114_c1900,
    nf_phone_ver_bureau >= 0.5                               => -0.00288641476322499,
    nf_phone_ver_bureau = NULL                               => 0.00365523592665358,
                                                                0.00365523592665358));

lncu_tree_114 :=     __common__( map(
    NULL < nf_email_name_addr_ver AND nf_email_name_addr_ver < 4.5 => lncu_tree_114_c1899,
    nf_email_name_addr_ver >= 4.5                                  => -0.0141705065751722,
    nf_email_name_addr_ver = NULL                                  => -0.00399799745432732,
                                                                      -0.00399799745432732));

lncu_tree_115_c1903 :=     __common__( map(
    (nf_util_add_curr_summary in ['', 'C', 'CM', 'IC', 'M']) => 0.0216961297138359,
    (nf_util_add_curr_summary in ['I', 'ICM', 'IM'])         => 0.160168244193569,
    nf_util_add_curr_summary = ''                          => 0.033607709454028,
                                                                0.033607709454028));

lncu_tree_115_c1902 :=     __common__( map(
    NULL < nf_accident_count AND nf_accident_count < 1.5 => -0.00402309021839942,
    nf_accident_count >= 1.5                             => lncu_tree_115_c1903,
    nf_accident_count = NULL                             => 0.000215502074134795,
                                                            0.000215502074134795));

lncu_tree_115 :=     __common__( map(
    NULL < nf_acc_damage_amt_total AND nf_acc_damage_amt_total < 650 => lncu_tree_115_c1902,
    nf_acc_damage_amt_total >= 650                                   => -0.0574781702894125,
    nf_acc_damage_amt_total = NULL                                   => -0.00202329002379098,
                                                                        -0.00202329002379098));

lncu_tree_116_c1906 :=     __common__( map(
    (ip_routingmethod in ['02', '14', '15'])                       => 0.0229990363778112,
    (ip_routingmethod in ['', '06', '10', '11', '12', '13', '16']) => 0.141290473288547,
    ip_routingmethod = ''                                        => 0.0768783552446876,
                                                                      0.0768783552446876));

lncu_tree_116_c1905 :=     __common__( map(
    NULL < rv_c24_prv_addr_lres AND rv_c24_prv_addr_lres < 3.5 => lncu_tree_116_c1906,
    rv_c24_prv_addr_lres >= 3.5                                => -0.007186445505377,
    rv_c24_prv_addr_lres = NULL                                => 0.0182948889200899,
                                                                  -0.00375049761517473));

lncu_tree_116 :=     __common__( map(
    NULL < nf_inq_corrnameaddr AND nf_inq_corrnameaddr < 11.5 => lncu_tree_116_c1905,
    nf_inq_corrnameaddr >= 11.5                               => -0.0548848306583342,
    nf_inq_corrnameaddr = NULL                                => 0.00168985649415818,
                                                                 -0.0026546608555964));

lncu_tree_117_c1909 :=     __common__( map(
    NULL < nf_inq_bestlname_ver_count AND nf_inq_bestlname_ver_count < 5.5 => 0.0779277584266802,
    nf_inq_bestlname_ver_count >= 5.5                                      => 0.0165579557663634,
    nf_inq_bestlname_ver_count = NULL                                      => 0.025128924815872,
                                                                              0.025128924815872));

lncu_tree_117_c1908 :=     __common__( map(
    NULL < (INTEGER)iv_inf_contradictory AND (INTEGER)iv_inf_contradictory < 0.5 => -0.00252926514541522,
    (INTEGER)iv_inf_contradictory >= 0.5                                => lncu_tree_117_c1909,
    (INTEGER)iv_inf_contradictory = NULL                                => 0.00293171860958083,
                                                                  0.00293171860958083));

lncu_tree_117 :=     __common__( map(
    NULL < nf_inq_corrdobaddr AND nf_inq_corrdobaddr < 10.5 => lncu_tree_117_c1908,
    nf_inq_corrdobaddr >= 10.5                              => -0.0617418795528566,
    nf_inq_corrdobaddr = NULL                               => 0.00358169640905834,
                                                               0.00230083776322419));

lncu_tree_118_c1912 :=     __common__( map(
    NULL < nf_inq_email_ver_count AND nf_inq_email_ver_count < 0.5 => -0.013160294601513,
    nf_inq_email_ver_count >= 0.5                                  => -0.0678359414892353,
    nf_inq_email_ver_count = NULL                                  => 0.00381567343717278,
                                                                      0.000552046758560861));

lncu_tree_118_c1911 :=     __common__( map(
    NULL < rv_i61_inq_collection_count12 AND rv_i61_inq_collection_count12 < 2.5 => lncu_tree_118_c1912,
    rv_i61_inq_collection_count12 >= 2.5                                         => -0.0378858839056693,
    rv_i61_inq_collection_count12 = NULL                                         => -0.000855437118820589,
                                                                                    -0.000855437118820589));

lncu_tree_118 :=     __common__( map(
    NULL < nf_liens_unrel_cj_total_amt AND nf_liens_unrel_cj_total_amt < 23950.5 => lncu_tree_118_c1911,
    nf_liens_unrel_cj_total_amt >= 23950.5                                       => 0.0828259803376133,
    nf_liens_unrel_cj_total_amt = NULL                                           => 0.000333330106340675,
                                                                                    0.000333330106340675));

lncu_tree_119_c1915 :=     __common__( map(
    NULL < iv_bureau_verification_index_1 AND iv_bureau_verification_index_1 < 12 => 0.0662403777252738,
    iv_bureau_verification_index_1 >= 12                                          => -0.0316030017637561,
    iv_bureau_verification_index_1 = NULL                                         => -0.0202056485754979,
                                                                                     -0.0202056485754979));

lncu_tree_119_c1914 :=     __common__( map(
    NULL < nf_phone_ver_insurance AND nf_phone_ver_insurance < 2.5 => lncu_tree_119_c1915,
    nf_phone_ver_insurance >= 2.5                                  => 0.0152710124923643,
    nf_phone_ver_insurance = NULL                                  => 0.0102171722924284,
                                                                      0.0102171722924284));

lncu_tree_119 :=     __common__( map(
    NULL < nf_corrssnaddr AND nf_corrssnaddr < 3.5 => lncu_tree_119_c1914,
    nf_corrssnaddr >= 3.5                          => -0.010682864553192,
    nf_corrssnaddr = NULL                          => 0.000852385525138226,
                                                      0.000852385525138226));

lncu_tree_120_c1918 :=     __common__( map(
    (nf_util_adl_summary in ['', 'I', 'IM', 'M'])     => -0.0366934474449577,
    (nf_util_adl_summary in ['C', 'CM', 'IC', 'ICM']) => 0.119138188227838,
    nf_util_adl_summary = ''                        => 0.0685330694268789,
                                                         0.0685330694268789));

lncu_tree_120_c1917 :=     __common__( map(
    NULL < iv_addr_non_phn_src_ct AND iv_addr_non_phn_src_ct < 2.5 => lncu_tree_120_c1918,
    iv_addr_non_phn_src_ct >= 2.5                                  => -0.00293007891121089,
    iv_addr_non_phn_src_ct = NULL                                  => 0.00472316468668556,
                                                                      0.00472316468668556));

lncu_tree_120 :=     __common__( map(
    NULL < rv_f00_inq_corrdobssn_adl AND rv_f00_inq_corrdobssn_adl < 15.5 => 0.00470659488457112,
    rv_f00_inq_corrdobssn_adl >= 15.5                                     => -0.0565158160897579,
    rv_f00_inq_corrdobssn_adl = NULL                                      => lncu_tree_120_c1917,
                                                                             0.00423162088238851));

lncu_tree_121_c1921 :=     __common__( map(
    NULL < nf_inq_corraddrssn AND nf_inq_corraddrssn < 7.5 => 0.00519156931499689,
    nf_inq_corraddrssn >= 7.5                              => -0.0504477877693596,
    nf_inq_corraddrssn = NULL                              => 0.0297293785670803,
                                                              0.0107258262418464));

lncu_tree_121_c1920 :=     __common__( map(
    NULL < rv_i60_inq_auto_count12 AND rv_i60_inq_auto_count12 < 5.5 => lncu_tree_121_c1921,
    rv_i60_inq_auto_count12 >= 5.5                                   => 0.0776727301330915,
    rv_i60_inq_auto_count12 = NULL                                   => 0.0135531206216917,
                                                                        0.0135531206216917));

lncu_tree_121 :=     __common__( map(
    (nf_historic_x_current_ct in ['1-1', '2-1', '3-0', '3-1', '3-2', '3-3']) => -0.0096717479991028,
    (nf_historic_x_current_ct in ['', '0-0', '1-0', '2-0', '2-2'])           => lncu_tree_121_c1920,
    nf_historic_x_current_ct = ''                                          => -0.00261709507333246,
                                                                                -0.00261709507333246));

lncu_tree_122_c1924 :=     __common__( map(
    NULL < nf_liens_unrel_ot_total_amt AND nf_liens_unrel_ot_total_amt < 25 => 0.0127274919413399,
    nf_liens_unrel_ot_total_amt >= 25                                       => 0.0733002544128934,
    nf_liens_unrel_ot_total_amt = NULL                                      => 0.0174253192095777,
                                                                               0.0174253192095777));

lncu_tree_122_c1923 :=     __common__( map(
    NULL < nf_liens_rel_ot_total_amt AND nf_liens_rel_ot_total_amt < 320.5 => lncu_tree_122_c1924,
    nf_liens_rel_ot_total_amt >= 320.5                                     => -0.0432545780258397,
    nf_liens_rel_ot_total_amt = NULL                                       => 0.0128382615990994,
                                                                              0.0128382615990994));

lncu_tree_122 :=     __common__( map(
    NULL < nf_inq_dob_ver_count AND nf_inq_dob_ver_count < 12.5 => -0.00520734787006455,
    nf_inq_dob_ver_count >= 12.5                                => lncu_tree_122_c1923,
    nf_inq_dob_ver_count = NULL                                 => 0.0136133919179011,
                                                                   0.00271578720795204));

lncu_tree_123_c1927 :=     __common__( map(
    NULL < nf_inq_corrdobphone AND nf_inq_corrdobphone < 0.5 => 0.0298268842465556,
    nf_inq_corrdobphone >= 0.5                               => -0.00589348431549789,
    nf_inq_corrdobphone = NULL                               => -0.000224491303468384,
                                                                -0.00156344935205957));

lncu_tree_123_c1926 :=     __common__( map(
    NULL < rv_c16_inv_ssn_per_adl AND rv_c16_inv_ssn_per_adl < 0.5 => lncu_tree_123_c1927,
    rv_c16_inv_ssn_per_adl >= 0.5                                  => -0.0660475391268874,
    rv_c16_inv_ssn_per_adl = NULL                                  => -0.00275835245070998,
                                                                      -0.00275835245070998));

lncu_tree_123 :=     __common__( map(
    NULL < nf_inq_highriskcredit_count24 AND nf_inq_highriskcredit_count24 < 13.5 => lncu_tree_123_c1926,
    nf_inq_highriskcredit_count24 >= 13.5                                         => -0.0597927863294664,
    nf_inq_highriskcredit_count24 = NULL                                          => -0.00363948375587826,
                                                                                     -0.00363948375587826));

lncu_tree_124_c1930 :=     __common__( map(
    NULL < nf_inq_corrnamessn AND nf_inq_corrnamessn < 2.5 => 0.0219192496285612,
    nf_inq_corrnamessn >= 2.5                              => -0.0474110951516386,
    nf_inq_corrnamessn = NULL                              => -0.000682585531841265,
                                                              0.00105115833232183));

lncu_tree_124_c1929 :=     __common__( map(
    NULL < nf_inq_corraddrphone AND nf_inq_corraddrphone < 6.5 => 0.000164182988241977,
    nf_inq_corraddrphone >= 6.5                                => 0.0727976122139747,
    nf_inq_corraddrphone = NULL                                => lncu_tree_124_c1930,
                                                                  0.00248800223951406));

lncu_tree_124 :=     __common__( map(
    NULL < nf_inq_corrnameaddr AND nf_inq_corrnameaddr < 0.5 => 0.0109620194352568,
    nf_inq_corrnameaddr >= 0.5                               => -0.0148598438512393,
    nf_inq_corrnameaddr = NULL                               => lncu_tree_124_c1929,
                                                                -0.00519386349179833));

lncu_tree_125_c1932 :=     __common__( map(
    NULL < nf_liens_unrel_sc_total_amt AND nf_liens_unrel_sc_total_amt < 2809.5 => -0.0260430791655784,
    nf_liens_unrel_sc_total_amt >= 2809.5                                       => 0.0675691738967491,
    nf_liens_unrel_sc_total_amt = NULL                                          => -0.0209436992529722,
                                                                                   -0.0209436992529722));

lncu_tree_125_c1933 :=     __common__( map(
    NULL < nf_dist_inp_curr_no_ver AND nf_dist_inp_curr_no_ver < 0.5 => 0.00321865468787773,
    nf_dist_inp_curr_no_ver >= 0.5                                   => 0.0739934994355143,
    nf_dist_inp_curr_no_ver = NULL                                   => 0.00438973373506733,
                                                                        0.00438973373506733));

lncu_tree_125 :=     __common__( map(
    (nf_util_add_input_summary in ['', 'I', 'ICM', 'IM', 'M']) => lncu_tree_125_c1932,
    (nf_util_add_input_summary in ['C', 'CM', 'IC'])           => lncu_tree_125_c1933,
    nf_util_add_input_summary = ''                           => -0.00156633478701985,
                                                                  -0.00156633478701985));

lncu_tree_126_c1935 :=     __common__( map(
    NULL < rv_i60_inq_auto_recency AND rv_i60_inq_auto_recency < 18 => 0.00103580499389708,
    rv_i60_inq_auto_recency >= 18                                   => -0.065645968643321,
    rv_i60_inq_auto_recency = NULL                                  => -0.024886803450679,
                                                                       -0.024886803450679));

lncu_tree_126_c1936 :=     __common__( map(
    (iv_f00_email_verification in ['2', '4', '5'])     => -0.00564641783971617,
    (iv_f00_email_verification in ['', '0', '1', '3']) => 0.0153315870597471,
    iv_f00_email_verification = ''                   => 0.00143608432829379,
                                                          0.00143608432829379));

lncu_tree_126 :=     __common__( map(
    NULL < rv_c13_curr_addr_lres AND rv_c13_curr_addr_lres < 8.5 => lncu_tree_126_c1935,
    rv_c13_curr_addr_lres >= 8.5                                 => lncu_tree_126_c1936,
    rv_c13_curr_addr_lres = NULL                                 => -0.00103379315131646,
                                                                    -0.00103379315131646));

lncu_tree_127_c1938 :=     __common__( map(
    NULL < nf_inq_fname_ver_count AND nf_inq_fname_ver_count < 25.5 => 0.016835696814862,
    nf_inq_fname_ver_count >= 25.5                                  => 0.133652702941704,
    nf_inq_fname_ver_count = NULL                                   => 0.0596938841276319,
                                                                       0.0596938841276319));

lncu_tree_127_c1939 :=     __common__( map(
    NULL < nf_corrnamedob AND nf_corrnamedob < 0.5 => -0.0393844664388555,
    nf_corrnamedob >= 0.5                          => 0.00426504375876485,
    nf_corrnamedob = NULL                          => 0.00147816012682297,
                                                      0.00147816012682297));

lncu_tree_127 :=     __common__( map(
    NULL < rv_d34_mos_last_unrel_lien_dt84 AND rv_d34_mos_last_unrel_lien_dt84 < 73.5 => -0.00777609642467554,
    rv_d34_mos_last_unrel_lien_dt84 >= 73.5                                           => lncu_tree_127_c1938,
    rv_d34_mos_last_unrel_lien_dt84 = NULL                                            => lncu_tree_127_c1939,
                                                                                         0.00101072784053002));

lncu_tree_128_c1942 :=     __common__( map(
    NULL < nf_inq_corrnameaddrphnssn AND nf_inq_corrnameaddrphnssn < 3.5 => 0.102217441181023,
    nf_inq_corrnameaddrphnssn >= 3.5                                     => 0.0528639737655633,
    nf_inq_corrnameaddrphnssn = NULL                                     => 0.0817388239961847,
                                                                            0.0817388239961847));

lncu_tree_128_c1941 :=     __common__( map(
    NULL < nf_inq_auto_count24 AND nf_inq_auto_count24 < 0.5 => lncu_tree_128_c1942,
    nf_inq_auto_count24 >= 0.5                               => 0.0018552041262248,
    nf_inq_auto_count24 = NULL                               => 0.0281641807301038,
                                                                0.0281641807301038));

lncu_tree_128 :=     __common__( map(
    NULL < nf_inq_perbestssn_count12 AND nf_inq_perbestssn_count12 < 10.5 => -0.000737660070371594,
    nf_inq_perbestssn_count12 >= 10.5                                     => lncu_tree_128_c1941,
    nf_inq_perbestssn_count12 = NULL                                      => 0.00113515050454669,
                                                                             0.00113515050454669));

lncu_tree_129_c1944 :=     __common__( map(
    NULL < nf_bus_ucc_count AND nf_bus_ucc_count < 0.5 => 0.00138807458010743,
    nf_bus_ucc_count >= 0.5                            => -0.0425429902659662,
    nf_bus_ucc_count = NULL                            => -0.00113011185358986,
                                                          -0.00113011185358986));

lncu_tree_129_c1945 :=     __common__( map(
    NULL < nf_inq_peraddr_recency AND nf_inq_peraddr_recency < 2 => 0.131264728115617,
    nf_inq_peraddr_recency >= 2                                  => -0.000908575905759904,
    nf_inq_peraddr_recency = NULL                                => 0.0668726056436642,
                                                                    0.0668726056436642));

lncu_tree_129 :=     __common__( map(
    NULL < nf_liens_unrel_o_total_amt AND nf_liens_unrel_o_total_amt < 2136.5 => lncu_tree_129_c1944,
    nf_liens_unrel_o_total_amt >= 2136.5                                      => lncu_tree_129_c1945,
    nf_liens_unrel_o_total_amt = NULL                                         => 0.000105149433039347,
                                                                                 0.000105149433039347));

lncu_tree_130_c1948 :=     __common__( map(
    NULL < nf_mos_liens_unrel_st_lseen AND nf_mos_liens_unrel_st_lseen < 58.5 => 0.00143695723892792,
    nf_mos_liens_unrel_st_lseen >= 58.5                                       => 0.0413032493439693,
    nf_mos_liens_unrel_st_lseen = NULL                                        => 0.00410259127197019,
                                                                                 0.00410259127197019));

lncu_tree_130_c1947 :=     __common__( map(
    NULL < nf_phones_per_addr_curr AND nf_phones_per_addr_curr < 11.5 => lncu_tree_130_c1948,
    nf_phones_per_addr_curr >= 11.5                                   => 0.0666580191422167,
    nf_phones_per_addr_curr = NULL                                    => 0.00517251777064371,
                                                                         0.00517251777064371));

lncu_tree_130 :=     __common__( map(
    (ip_routingmethod in ['', '06', '13', '16'])               => -0.0248669232097748,
    (ip_routingmethod in ['02', '10', '11', '12', '14', '15']) => lncu_tree_130_c1947,
    ip_routingmethod = ''                                    => -7.25009732999804e-05,
                                                                  -7.25009732999804e-05));

lncu_tree_131_c1951 :=     __common__( map(
    NULL < rv_c20_m_bureau_adl_fs AND rv_c20_m_bureau_adl_fs < 276 => 0.0768922940010345,
    rv_c20_m_bureau_adl_fs >= 276                                  => -0.000510755401595851,
    rv_c20_m_bureau_adl_fs = NULL                                  => 0.046362804396013,
                                                                      0.046362804396013));

lncu_tree_131_c1950 :=     __common__( map(
    NULL < nf_inq_corrnamephonessn AND nf_inq_corrnamephonessn < 7.5 => lncu_tree_131_c1951,
    nf_inq_corrnamephonessn >= 7.5                                   => -0.0143864214256691,
    nf_inq_corrnamephonessn = NULL                                   => 0.0266029755669175,
                                                                        0.0266029755669175));

lncu_tree_131 :=     __common__( map(
    NULL < nf_inq_perbestssn_count12 AND nf_inq_perbestssn_count12 < 10.5 => 8.17327230135272e-05,
    nf_inq_perbestssn_count12 >= 10.5                                     => lncu_tree_131_c1950,
    nf_inq_perbestssn_count12 = NULL                                      => 0.00174471302860676,
                                                                             0.00174471302860676));

lncu_tree_132_c1954 :=     __common__( map(
    (ip_topleveldomain_lvl in ['-1', 'EDU', 'GOV', 'NET', 'ORG', 'TWO']) => -0.017899251777837,
    (ip_topleveldomain_lvl in ['', 'COM', 'DOT', 'OTH', 'US'])           => 0.0290521002990708,
    ip_topleveldomain_lvl = ''                                         => 0.00119438726854301,
                                                                            0.00119438726854301));

lncu_tree_132_c1953 :=     __common__( map(
    NULL < rv_f00_inq_corrdobaddr_adl AND rv_f00_inq_corrdobaddr_adl < 11.5 => 3.59148413795666e-05,
    rv_f00_inq_corrdobaddr_adl >= 11.5                                      => -0.0636473378801161,
    rv_f00_inq_corrdobaddr_adl = NULL                                       => lncu_tree_132_c1954,
                                                                               -0.000259518774570523));

lncu_tree_132 :=     __common__( map(
    NULL < nf_inq_perphone_count12 AND nf_inq_perphone_count12 < 13.5 => lncu_tree_132_c1953,
    nf_inq_perphone_count12 >= 13.5                                   => 0.0549565893946539,
    nf_inq_perphone_count12 = NULL                                    => 0.00028912754165838,
                                                                         0.00028912754165838));

lncu_tree_133_c1957 :=     __common__( map(
    NULL < nf_inq_corrdobssn AND nf_inq_corrdobssn < 7.5 => 0.0198914162232735,
    nf_inq_corrdobssn >= 7.5                             => -0.0567226061103272,
    nf_inq_corrdobssn = NULL                             => -0.0144348758121036,
                                                            0.0107487883463832));

lncu_tree_133_c1956 :=     __common__( map(
    NULL < rv_f00_inq_corrnameaddr_adl AND rv_f00_inq_corrnameaddr_adl < 8.5 => lncu_tree_133_c1957,
    rv_f00_inq_corrnameaddr_adl >= 8.5                                       => 0.0788699688183913,
    rv_f00_inq_corrnameaddr_adl = NULL                                       => 0.0128195414365607,
                                                                                0.0147814183636483));

lncu_tree_133 :=     __common__( map(
    NULL < iv_src_drivers_lic_adl_count AND iv_src_drivers_lic_adl_count < 2.5 => -0.00684486621756246,
    iv_src_drivers_lic_adl_count >= 2.5                                        => lncu_tree_133_c1956,
    iv_src_drivers_lic_adl_count = NULL                                        => -0.000677196200803992,
                                                                                  -0.000677196200803992));

lncu_tree_134_c1959 :=     __common__( map(
    NULL < rv_d34_mos_last_unrel_lien_dt84 AND rv_d34_mos_last_unrel_lien_dt84 < 68.5 => -0.0071653553395837,
    rv_d34_mos_last_unrel_lien_dt84 >= 68.5                                           => 0.0434949994214385,
    rv_d34_mos_last_unrel_lien_dt84 = NULL                                            => -0.00322672799820644,
                                                                                         -0.00209719368784361));

lncu_tree_134_c1960 :=     __common__( map(
    NULL < nf_inq_phone_ver_count AND nf_inq_phone_ver_count < 6.5 => 0.126823069176107,
    nf_inq_phone_ver_count >= 6.5                                  => -0.0194197522031973,
    nf_inq_phone_ver_count = NULL                                  => 0.0624512289963276,
                                                                      0.0624512289963276));

lncu_tree_134 :=     __common__( map(
    NULL < rv_i60_inq_other_count12 AND rv_i60_inq_other_count12 < 5.5 => lncu_tree_134_c1959,
    rv_i60_inq_other_count12 >= 5.5                                    => lncu_tree_134_c1960,
    rv_i60_inq_other_count12 = NULL                                    => -0.000894708129805802,
                                                                          -0.000894708129805802));

lncu_tree_135_c1963 :=     __common__( map(
    (rv_6seg_riskview_5_0 in ['1 VER/VAL PROBLEMS', '4 SUFFICIENTLY VERD - DEROG', '5 SUFFICIENTLY VERD - OWNER', '6 SUFFICIENTLY VERD - OTHER']) => 0.0345713519156073,
    (rv_6seg_riskview_5_0 in ['0 TRUEDID = 0', '2 ADDR NOT CURRENT - DEROG', '3 ADDR NOT CURRENT - OTHER'])                                       => 0.122275331213013,
    rv_6seg_riskview_5_0 =''                                                                                                                   => 0.0561072044832976,
                                                                                                                                                     0.0561072044832976));

lncu_tree_135_c1962 :=     __common__( map(
    NULL < rv_l79_adls_per_addr_curr AND rv_l79_adls_per_addr_curr < 2.25 => -0.00922111326776972,
    rv_l79_adls_per_addr_curr >= 2.25                                     => lncu_tree_135_c1963,
    rv_l79_adls_per_addr_curr = NULL                                      => 0.0193282759826967,
                                                                             0.0193282759826967));

lncu_tree_135 :=     __common__( map(
    NULL < iv_addr_non_phn_src_ct AND iv_addr_non_phn_src_ct < 2.5 => lncu_tree_135_c1962,
    iv_addr_non_phn_src_ct >= 2.5                                  => -0.00414304254173821,
    iv_addr_non_phn_src_ct = NULL                                  => -0.00180028286908816,
                                                                      -0.00180028286908816));

lncu_tree_136_c1966 :=     __common__( map(
    NULL < rv_d34_mos_last_unrel_lien_dt84 AND rv_d34_mos_last_unrel_lien_dt84 < 61.5 => -0.043041991321298,
    rv_d34_mos_last_unrel_lien_dt84 >= 61.5                                           => 0.0663535592738107,
    rv_d34_mos_last_unrel_lien_dt84 = NULL                                            => -0.0161322019023462,
                                                                                         -0.0159605214348071));

lncu_tree_136_c1965 :=     __common__( map(
    NULL < rv_c13_inp_addr_lres AND rv_c13_inp_addr_lres < 18.5 => lncu_tree_136_c1966,
    rv_c13_inp_addr_lres >= 18.5                                => 0.00333783646730602,
    rv_c13_inp_addr_lres = NULL                                 => -0.00070335656392137,
                                                                   -0.00070335656392137));

lncu_tree_136 :=     __common__( map(
    NULL < nf_bus_seleids_peradl AND nf_bus_seleids_peradl < 7.5 => lncu_tree_136_c1965,
    nf_bus_seleids_peradl >= 7.5                                 => 0.12238942472737,
    nf_bus_seleids_peradl = NULL                                 => 0.000280774187689516,
                                                                    0.000280774187689516));

lncu_tree_137_c1969 :=     __common__( map(
    NULL < rv_p88_phn_dst_to_inp_add AND rv_p88_phn_dst_to_inp_add < 29.5 => -0.00100865707393381,
    rv_p88_phn_dst_to_inp_add >= 29.5                                     => -0.0217542375418957,
    rv_p88_phn_dst_to_inp_add = NULL                                      => 0.010676934078713,
                                                                             0.00145713137900788));

lncu_tree_137_c1968 :=     __common__( map(
    NULL < nf_mos_liens_unrel_ft_fseen AND nf_mos_liens_unrel_ft_fseen < 206.5 => lncu_tree_137_c1969,
    nf_mos_liens_unrel_ft_fseen >= 206.5                                       => 0.115330224105521,
    nf_mos_liens_unrel_ft_fseen = NULL                                         => 0.00258912425344896,
                                                                                  0.00258912425344896));

lncu_tree_137 :=     __common__( map(
    NULL < nf_bus_ver_src_mos_reg_lseen AND nf_bus_ver_src_mos_reg_lseen < 173.5 => lncu_tree_137_c1968,
    nf_bus_ver_src_mos_reg_lseen >= 173.5                                        => -0.0729055175441711,
    nf_bus_ver_src_mos_reg_lseen = NULL                                          => 0.00140484859583311,
                                                                                    0.00140484859583311));

lncu_tree_138_c1972 :=     __common__( map(
    (nf_historic_x_current_ct in ['1-0', '2-1', '2-2', '3-2', '3-3'])     => -0.000594472424109047,
    (nf_historic_x_current_ct in ['', '0-0', '1-1', '2-0', '3-0', '3-1']) => 0.0449179744201429,
    nf_historic_x_current_ct = ''                                       => 0.0177011603498591,
                                                                             0.0177011603498591));

lncu_tree_138_c1971 :=     __common__( map(
    NULL < nf_phones_per_sfd_addr_curr AND nf_phones_per_sfd_addr_curr < 5.5 => -0.00658717483824249,
    nf_phones_per_sfd_addr_curr >= 5.5                                       => lncu_tree_138_c1972,
    nf_phones_per_sfd_addr_curr = NULL                                       => -0.00238865128941109,
                                                                                -0.00238865128941109));

lncu_tree_138 :=     __common__( map(
    NULL < nf_inq_per_apt_addr AND nf_inq_per_apt_addr < 9.5 => lncu_tree_138_c1971,
    nf_inq_per_apt_addr >= 9.5                               => -0.0829511893152789,
    nf_inq_per_apt_addr = NULL                               => -0.00309479205864186,
                                                                -0.00309479205864186));

lncu_tree_139_c1974 :=     __common__( map(
    NULL < rv_c23_email_domain_free_cnt AND rv_c23_email_domain_free_cnt < 8.5 => -0.00352620988515439,
    rv_c23_email_domain_free_cnt >= 8.5                                        => -0.0613542193746625,
    rv_c23_email_domain_free_cnt = NULL                                        => -0.00467973689634938,
                                                                                  -0.00467973689634938));

lncu_tree_139_c1975 :=     __common__( map(
    NULL < rv_c23_email_count AND rv_c23_email_count < 3.5 => 0.117363021161249,
    rv_c23_email_count >= 3.5                              => -0.0168878886533812,
    rv_c23_email_count = NULL                              => 0.0580428517082731,
                                                              0.0580428517082731));

lncu_tree_139 :=     __common__( map(
    NULL < nf_phones_per_curraddr_c6 AND nf_phones_per_curraddr_c6 < 1.5 => lncu_tree_139_c1974,
    nf_phones_per_curraddr_c6 >= 1.5                                     => lncu_tree_139_c1975,
    nf_phones_per_curraddr_c6 = NULL                                     => -0.00321439234729696,
                                                                            -0.00321439234729696));

lncu_tree_140_c1978 :=     __common__( map(
    NULL < nf_inq_phone_ver_count AND nf_inq_phone_ver_count < 17.5 => -0.0207602458615649,
    nf_inq_phone_ver_count >= 17.5                                  => 0.0352590096968184,
    nf_inq_phone_ver_count = NULL                                   => 0.0332831746490339,
                                                                       -0.0144993330791532));

lncu_tree_140_c1977 :=     __common__( map(
    (rv_6seg_riskview_5_0 in ['1 VER/VAL PROBLEMS', '5 SUFFICIENTLY VERD - OWNER', '6 SUFFICIENTLY VERD - OTHER'])                         => lncu_tree_140_c1978,
    (rv_6seg_riskview_5_0 in ['0 TRUEDID = 0', '2 ADDR NOT CURRENT - DEROG', '3 ADDR NOT CURRENT - OTHER', '4 SUFFICIENTLY VERD - DEROG']) => 0.00340143926284685,
    rv_6seg_riskview_5_0 = ''                                                                                                            => -0.00389026701051095,
                                                                                                                                              -0.00389026701051095));

lncu_tree_140 :=     __common__( map(
    NULL < rv_c13_curr_addr_lres AND rv_c13_curr_addr_lres < 413 => lncu_tree_140_c1977,
    rv_c13_curr_addr_lres >= 413                                 => 0.107111358833488,
    rv_c13_curr_addr_lres = NULL                                 => -0.00231314763710631,
                                                                    -0.00231314763710631));

lncu_tree_141_c1981 :=     __common__( map(
    NULL < rv_mos_since_br_first_seen AND rv_mos_since_br_first_seen < 144.5 => 0.0167790797811728,
    rv_mos_since_br_first_seen >= 144.5                                      => 0.14263660442902,
    rv_mos_since_br_first_seen = NULL                                        => 0.022654781211978,
                                                                                0.022654781211978));

lncu_tree_141_c1980 :=     __common__( map(
    NULL < iv_fname_non_phn_src_ct AND iv_fname_non_phn_src_ct < 8.5 => lncu_tree_141_c1981,
    iv_fname_non_phn_src_ct >= 8.5                                   => -0.00219148207723136,
    iv_fname_non_phn_src_ct = NULL                                   => 0.00502716734389439,
                                                                        0.00502716734389439));

lncu_tree_141 :=     __common__( map(
    NULL < rv_c14_unverified_addr_count AND rv_c14_unverified_addr_count < 0.5 => -0.0232305838129526,
    rv_c14_unverified_addr_count >= 0.5                                        => lncu_tree_141_c1980,
    rv_c14_unverified_addr_count = NULL                                        => 0.00102638040683866,
                                                                                  0.00102638040683866));

lncu_tree_142_c1984 :=     __common__( map(
    NULL < rv_l79_adls_per_addr_curr AND rv_l79_adls_per_addr_curr < 0.75 => -0.0463071321121081,
    rv_l79_adls_per_addr_curr >= 0.75                                     => 0.0144900897482209,
    rv_l79_adls_per_addr_curr = NULL                                      => 0.0112809042257013,
                                                                             0.0112809042257013));

lncu_tree_142_c1983 :=     __common__( map(
    NULL < nf_inq_highriskcredit_count24 AND nf_inq_highriskcredit_count24 < 0.5 => -0.0112839845385666,
    nf_inq_highriskcredit_count24 >= 0.5                                         => lncu_tree_142_c1984,
    nf_inq_highriskcredit_count24 = NULL                                         => 0.000824779713808167,
                                                                                    0.000824779713808167));

lncu_tree_142 :=     __common__( map(
    NULL < nf_phones_per_addr_curr AND nf_phones_per_addr_curr < 14.5 => lncu_tree_142_c1983,
    nf_phones_per_addr_curr >= 14.5                                   => 0.0946401074107154,
    nf_phones_per_addr_curr = NULL                                    => 0.00156703564190967,
                                                                         0.00156703564190967));

lncu_tree_143_c1986 :=     __common__( map(
    NULL < nf_inq_corrnamephone AND nf_inq_corrnamephone < 0.5 => 0.0843081218825507,
    nf_inq_corrnamephone >= 0.5                                => 0.0164895484115482,
    nf_inq_corrnamephone = NULL                                => 0.00584241621573666,
                                                                  0.0144473821577849));

lncu_tree_143_c1987 :=     __common__( map(
    NULL < nf_adls_per_curraddr_curr AND nf_adls_per_curraddr_curr < 5.5 => -0.0141621484899963,
    nf_adls_per_curraddr_curr >= 5.5                                     => 0.0213140003726575,
    nf_adls_per_curraddr_curr = NULL                                     => -0.00812526464472546,
                                                                            -0.00812526464472546));

lncu_tree_143 :=     __common__( map(
    NULL < rv_c12_source_profile AND rv_c12_source_profile < 51.65 => lncu_tree_143_c1986,
    rv_c12_source_profile >= 51.65                                 => lncu_tree_143_c1987,
    rv_c12_source_profile = NULL                                   => -0.00198326234052668,
                                                                      -0.00198326234052668));

lncu_tree_144_c1990 :=     __common__( map(
    NULL < nf_liens_rel_o_total_amt AND nf_liens_rel_o_total_amt < 130.5 => 0.00254492633690969,
    nf_liens_rel_o_total_amt >= 130.5                                    => -0.114142150437416,
    nf_liens_rel_o_total_amt = NULL                                      => 0.00153375693214141,
                                                                            0.00153375693214141));

lncu_tree_144_c1989 :=     __common__( map(
    NULL < nf_m_bureau_adl_fs_all AND nf_m_bureau_adl_fs_all < 54.5 => 0.103596789991373,
    nf_m_bureau_adl_fs_all >= 54.5                                  => lncu_tree_144_c1990,
    nf_m_bureau_adl_fs_all = NULL                                   => 0.00246691393657865,
                                                                       0.00246691393657865));

lncu_tree_144 :=     __common__( map(
    NULL < rv_c10_m_hdr_fs AND rv_c10_m_hdr_fs < 53.5 => -0.0569049096799628,
    rv_c10_m_hdr_fs >= 53.5                           => lncu_tree_144_c1989,
    rv_c10_m_hdr_fs = NULL                            => 0.00104781400844775,
                                                         0.00104781400844775));

lncu_tree_145_c1993 :=     __common__( map(
    (rv_6seg_riskview_5_0 in ['1 VER/VAL PROBLEMS', '2 ADDR NOT CURRENT - DEROG', '3 ADDR NOT CURRENT - OTHER', '5 SUFFICIENTLY VERD - OWNER', '6 SUFFICIENTLY VERD - OTHER']) => -0.00383184796396338,
    (rv_6seg_riskview_5_0 in ['0 TRUEDID = 0', '4 SUFFICIENTLY VERD - DEROG'])                                                                                                 => 0.0345849237235712,
    rv_6seg_riskview_5_0 = ''                                                                                                                                                => 0.0148514913384722,
                                                                                                                                                                                  0.0148514913384722));

lncu_tree_145_c1992 :=     __common__( map(
    NULL < rv_mos_since_br_first_seen AND rv_mos_since_br_first_seen < 45.5 => lncu_tree_145_c1993,
    rv_mos_since_br_first_seen >= 45.5                                      => -0.0323669381127433,
    rv_mos_since_br_first_seen = NULL                                       => 0.00802012133684961,
                                                                               0.00802012133684961));

lncu_tree_145 :=     __common__( map(
    NULL < nf_inq_highriskcredit_count24 AND nf_inq_highriskcredit_count24 < 1.5 => -0.0112378022669732,
    nf_inq_highriskcredit_count24 >= 1.5                                         => lncu_tree_145_c1992,
    nf_inq_highriskcredit_count24 = NULL                                         => -0.00478112939398021,
                                                                                    -0.00478112939398021));

lncu_tree_146_c1996 :=     __common__( map(
    NULL < nf_inq_per_phone AND nf_inq_per_phone < 3.5 => 0.00357814014771322,
    nf_inq_per_phone >= 3.5                            => 0.0280519773127642,
    nf_inq_per_phone = NULL                            => 0.00756534807907028,
                                                          0.00756534807907028));

lncu_tree_146_c1995 :=     __common__( map(
    NULL < rv_d34_liens_rel_total_amt84 AND rv_d34_liens_rel_total_amt84 < 407.5 => lncu_tree_146_c1996,
    rv_d34_liens_rel_total_amt84 >= 407.5                                        => -0.0341856097792408,
    rv_d34_liens_rel_total_amt84 = NULL                                          => 0.00334848144450051,
                                                                                    0.00334848144450051));

lncu_tree_146 :=     __common__( map(
    (rv_4seg_riskview_5_0 in ['3 OWNER'])                                                   => -0.0212930690531614,
    (rv_4seg_riskview_5_0 in ['0 TRUEDID = 0', '1 VER/VAL PROBLEMS', '2 DEROG', '4 OTHER']) => lncu_tree_146_c1995,
    rv_4seg_riskview_5_0 = ''                                                             => -0.00121590131910612,
                                                                                               -0.00121590131910612));

lncu_tree_147_c1999 :=     __common__( map(
    NULL < rv_mos_since_br_first_seen AND rv_mos_since_br_first_seen < 121.5 => 0.0450468933681683,
    rv_mos_since_br_first_seen >= 121.5                                      => -0.0285329550856749,
    rv_mos_since_br_first_seen = NULL                                        => 0.0110219738848149,
                                                                                0.0110219738848149));

lncu_tree_147_c1998 :=     __common__( map(
    NULL < nf_unvrfd_search_risk_index AND nf_unvrfd_search_risk_index < 7.5 => lncu_tree_147_c1999,
    nf_unvrfd_search_risk_index >= 7.5                                       => 0.109891967659412,
    nf_unvrfd_search_risk_index = NULL                                       => 0.0256986751829106,
                                                                                0.0256986751829106));

lncu_tree_147 :=     __common__( map(
    NULL < nf_bus_ver_src_mos_reg_lseen AND nf_bus_ver_src_mos_reg_lseen < 35.5 => -0.00419210761387684,
    nf_bus_ver_src_mos_reg_lseen >= 35.5                                        => lncu_tree_147_c1998,
    nf_bus_ver_src_mos_reg_lseen = NULL                                         => -0.00158110282729513,
                                                                                   -0.00158110282729513));

lncu_tree_148_c2002 :=     __common__( map(
    NULL < nf_inq_percurraddr_count12 AND nf_inq_percurraddr_count12 < 5.5 => 0.0290117907098492,
    nf_inq_percurraddr_count12 >= 5.5                                      => 0.0899008387776448,
    nf_inq_percurraddr_count12 = NULL                                      => 0.0469912926393021,
                                                                              0.0469912926393021));

lncu_tree_148_c2001 :=     __common__( map(
    NULL < nf_fp_srchfraudsrchcount AND nf_fp_srchfraudsrchcount < 16.5 => lncu_tree_148_c2002,
    nf_fp_srchfraudsrchcount >= 16.5                                    => -0.0126258997290251,
    nf_fp_srchfraudsrchcount = NULL                                     => 0.025419990644501,
                                                                           0.025419990644501));

lncu_tree_148 :=     __common__( map(
    NULL < nf_inq_ssn_lexid_diff01 AND nf_inq_ssn_lexid_diff01 < 0.5 => -0.000745874180891626,
    nf_inq_ssn_lexid_diff01 >= 0.5                                   => lncu_tree_148_c2001,
    nf_inq_ssn_lexid_diff01 = NULL                                   => 0.00262689483004871,
                                                                        0.00262689483004871));

lncu_tree_149_c2005 :=     __common__( map(
    NULL < nf_acc_damage_amt_total AND nf_acc_damage_amt_total < 100.5 => 0.0534031587486421,
    nf_acc_damage_amt_total >= 100.5                                   => -0.0520170831903199,
    nf_acc_damage_amt_total = NULL                                     => 0.0308819599304266,
                                                                          0.0308819599304266));

lncu_tree_149_c2004 :=     __common__( map(
    NULL < nf_accident_count AND nf_accident_count < 1.5 => 0.000773179633601262,
    nf_accident_count >= 1.5                             => lncu_tree_149_c2005,
    nf_accident_count = NULL                             => 0.00491365319293835,
                                                            0.00491365319293835));

lncu_tree_149 :=     __common__( map(
    NULL < nf_inq_addr_ver_count AND nf_inq_addr_ver_count < 3.5 => -0.016903963087212,
    nf_inq_addr_ver_count >= 3.5                                 => lncu_tree_149_c2004,
    nf_inq_addr_ver_count = NULL                                 => 0.0266722661842261,
                                                                    -0.00162279992043975));

lncu_tree_150_c2008 :=     __common__( map(
    NULL < rv_i60_inq_retail_recency AND rv_i60_inq_retail_recency < 61.5 => 0.015743793047071,
    rv_i60_inq_retail_recency >= 61.5                                     => -0.0188842602940018,
    rv_i60_inq_retail_recency = NULL                                      => 0.00805664194279255,
                                                                             0.00805664194279255));

lncu_tree_150_c2007 :=     __common__( map(
    NULL < nf_inq_highriskcredit_count24 AND nf_inq_highriskcredit_count24 < 0.5 => -0.0102972552669677,
    nf_inq_highriskcredit_count24 >= 0.5                                         => lncu_tree_150_c2008,
    nf_inq_highriskcredit_count24 = NULL                                         => -0.000540565514284992,
                                                                                    -0.000540565514284992));

lncu_tree_150 :=     __common__( map(
    NULL < rv_l79_adls_per_sfd_addr AND rv_l79_adls_per_sfd_addr < 10.5 => lncu_tree_150_c2007,
    rv_l79_adls_per_sfd_addr >= 10.5                                    => -0.0620638183298967,
    rv_l79_adls_per_sfd_addr = NULL                                     => -0.00136138458691028,
                                                                           -0.00136138458691028));

lncu_tree_151_c2010 :=     __common__( map(
    NULL < nf_inq_percurraddr_count12 AND nf_inq_percurraddr_count12 < 21.5 => -0.00256785712838229,
    nf_inq_percurraddr_count12 >= 21.5                                      => 0.0518666355149276,
    nf_inq_percurraddr_count12 = NULL                                       => -0.00184252996681627,
                                                                               -0.00184252996681627));

lncu_tree_151_c2011 :=     __common__( map(
    NULL < nf_inq_dobsperssn_recency AND nf_inq_dobsperssn_recency < 2 => 0.0105977939762302,
    nf_inq_dobsperssn_recency >= 2                                     => -0.0803892143536843,
    nf_inq_dobsperssn_recency = NULL                                   => -0.044720598412145,
                                                                          -0.044720598412145));

lncu_tree_151 :=     __common__( map(
    NULL < iv_inq_auto_count01 AND iv_inq_auto_count01 < 0.5 => lncu_tree_151_c2010,
    iv_inq_auto_count01 >= 0.5                               => lncu_tree_151_c2011,
    iv_inq_auto_count01 = NULL                               => -0.00326026181699557,
                                                                -0.00326026181699557));

lncu_tree_152_c2014 :=     __common__( map(
    NULL < nf_inq_other_count24 AND nf_inq_other_count24 < 2.5 => 0.0278283621688556,
    nf_inq_other_count24 >= 2.5                                => 0.123101474984156,
    nf_inq_other_count24 = NULL                                => 0.0409694811778626,
                                                                  0.0409694811778626));

lncu_tree_152_c2013 :=     __common__( map(
    (ip_routingmethod in ['', '10', '11', '12', '13', '14', '16']) => 0.00741621794859459,
    (ip_routingmethod in ['02', '06', '15'])                       => lncu_tree_152_c2014,
    ip_routingmethod = ''                                        => 0.0124619849680016,
                                                                      0.0124619849680016));

lncu_tree_152 :=     __common__( map(
    NULL < rv_a44_curr_add_naprop AND rv_a44_curr_add_naprop < 1.5 => lncu_tree_152_c2013,
    rv_a44_curr_add_naprop >= 1.5                                  => -0.00564399702520549,
    rv_a44_curr_add_naprop = NULL                                  => 0.00303017538998596,
                                                                      0.00303017538998596));

lncu_tree_153_c2017 :=     __common__( map(
    NULL < rv_c13_inp_addr_lres AND rv_c13_inp_addr_lres < 122.5 => 0.0124503486653923,
    rv_c13_inp_addr_lres >= 122.5                                => 0.12827219604612,
    rv_c13_inp_addr_lres = NULL                                  => 0.032623946930245,
                                                                    0.032623946930245));

lncu_tree_153_c2016 :=     __common__( map(
    NULL < (integer)iv_nap_lname_verd AND (integer)iv_nap_lname_verd < 0.5 => lncu_tree_153_c2017,
    (integer)iv_nap_lname_verd >= 0.5                             => -0.00516259416793541,
    (integer)iv_nap_lname_verd = NULL                             => -0.00273286748861162,
                                                            -0.00273286748861162));

lncu_tree_153 :=     __common__( map(
    NULL < rv_c12_source_profile AND rv_c12_source_profile < 5.55 => 0.0907410582712821,
    rv_c12_source_profile >= 5.55                                 => lncu_tree_153_c2016,
    rv_c12_source_profile = NULL                                  => -0.00189847321224837,
                                                                     -0.00189847321224837));

lncu_tree_154_c2020 :=     __common__( map(
    NULL < nf_fp_srchaddrsrchcountmo AND nf_fp_srchaddrsrchcountmo < 1.5 => 0.0514612172116418,
    nf_fp_srchaddrsrchcountmo >= 1.5                                     => -0.0562787700222372,
    nf_fp_srchaddrsrchcountmo = NULL                                     => 0.0414779706881355,
                                                                            0.0414779706881355));

lncu_tree_154_c2019 :=     __common__( map(
    (iv_d34_liens_unrel_x_rel in ['0-2', '1-0', '1-1', '1-2', '2-2', '3-2'])     => -0.0121394336449696,
    (iv_d34_liens_unrel_x_rel in ['', '0-0', '0-1', '2-0', '2-1', '3-0', '3-1']) => lncu_tree_154_c2020,
    iv_d34_liens_unrel_x_rel = ''                                              => 0.0189307262290786,
                                                                                    0.0189307262290786));

lncu_tree_154 :=     __common__( map(
    NULL < rv_d33_eviction_recency AND rv_d33_eviction_recency < 549 => lncu_tree_154_c2019,
    rv_d33_eviction_recency >= 549                                   => -0.00339303249183724,
    rv_d33_eviction_recency = NULL                                   => -0.00013286244882151,
                                                                        -0.00013286244882151));

lncu_tree_155_c2023 :=     __common__( map(
    NULL < rv_c24_prv_addr_lres AND rv_c24_prv_addr_lres < 4.5 => 0.0617004205079128,
    rv_c24_prv_addr_lres >= 4.5                                => 0.00647378358285045,
    rv_c24_prv_addr_lres = NULL                                => -0.030701848298877,
                                                                  0.00883888096634306));

lncu_tree_155_c2022 :=     __common__( map(
    (iv_f00_email_verification in ['1', '4', '5'])     => -0.0112408710211636,
    (iv_f00_email_verification in ['', '0', '2', '3']) => lncu_tree_155_c2023,
    iv_f00_email_verification = ''                   => -0.0024480235319173,
                                                          -0.0024480235319173));

lncu_tree_155 :=     __common__( map(
    NULL < nf_bus_seleids_peradl AND nf_bus_seleids_peradl < 7.5 => lncu_tree_155_c2022,
    nf_bus_seleids_peradl >= 7.5                                 => 0.107519686814132,
    nf_bus_seleids_peradl = NULL                                 => -0.00155168681507712,
                                                                    -0.00155168681507712));

lncu_tree_156_c2025 :=     __common__( map(
    NULL < nf_fp_srchssnsrchcountmo AND nf_fp_srchssnsrchcountmo < 3.5 => -0.000378882345819997,
    nf_fp_srchssnsrchcountmo >= 3.5                                    => -0.0567726349881522,
    nf_fp_srchssnsrchcountmo = NULL                                    => -0.00122821263715302,
                                                                          -0.00122821263715302));

lncu_tree_156_c2026 :=     __common__( map(
    NULL < rv_c23_email_domain_free_cnt AND rv_c23_email_domain_free_cnt < 1.5 => 0.114727899721519,
    rv_c23_email_domain_free_cnt >= 1.5                                        => 0.00533875917026075,
    rv_c23_email_domain_free_cnt = NULL                                        => 0.0600333294458898,
                                                                                  0.0600333294458898));

lncu_tree_156 :=     __common__( map(
    NULL < nf_inq_adlsperphone_count_week AND nf_inq_adlsperphone_count_week < 0.5 => lncu_tree_156_c2025,
    nf_inq_adlsperphone_count_week >= 0.5                                          => lncu_tree_156_c2026,
    nf_inq_adlsperphone_count_week = NULL                                          => -0.000267732079812551,
                                                                                      -0.000267732079812551));

lncu_tree_157_c2029 :=     __common__( map(
    NULL < nf_inq_ssn_lexid_diff01 AND nf_inq_ssn_lexid_diff01 < 0.5 => 0.0167428643534528,
    nf_inq_ssn_lexid_diff01 >= 0.5                                   => 0.0669250928747933,
    nf_inq_ssn_lexid_diff01 = NULL                                   => 0.0225756274564634,
                                                                        0.0225756274564634));

lncu_tree_157_c2028 :=     __common__( map(
    NULL < rv_c18_invalid_addrs_per_adl AND rv_c18_invalid_addrs_per_adl < 3.5 => lncu_tree_157_c2029,
    rv_c18_invalid_addrs_per_adl >= 3.5                                        => -0.0179285898319436,
    rv_c18_invalid_addrs_per_adl = NULL                                        => 0.00778770762822574,
                                                                                  0.00778770762822574));

lncu_tree_157 :=     __common__( map(
    (iv_d34_liens_unrel_x_rel in ['0-0', '1-1', '2-2', '3-2'])                                 => -0.00938466417577937,
    (iv_d34_liens_unrel_x_rel in ['', '0-1', '0-2', '1-0', '1-2', '2-0', '2-1', '3-0', '3-1']) => lncu_tree_157_c2028,
    iv_d34_liens_unrel_x_rel = ''                                                           => -0.00423375184517995,
                                                                                                  -0.00423375184517995));

lncu_tree_158_c2032 :=     __common__( map(
    NULL < rv_i62_inq_addrs_per_adl AND rv_i62_inq_addrs_per_adl < 1.5 => 0.0294224203841677,
    rv_i62_inq_addrs_per_adl >= 1.5                                    => -0.00308721199096899,
    rv_i62_inq_addrs_per_adl = NULL                                    => 0.0146435569749313,
                                                                          0.0146435569749313));

lncu_tree_158_c2031 :=     __common__( map(
    NULL < nf_fp_varrisktype AND nf_fp_varrisktype < 1.5 => -0.0058829307081978,
    nf_fp_varrisktype >= 1.5                             => lncu_tree_158_c2032,
    nf_fp_varrisktype = NULL                             => 0.00235182661890816,
                                                            0.00235182661890816));

lncu_tree_158 :=     __common__( map(
    NULL < nf_fp_srchaddrsrchcountmo AND nf_fp_srchaddrsrchcountmo < 3.5 => lncu_tree_158_c2031,
    nf_fp_srchaddrsrchcountmo >= 3.5                                     => -0.0465849238997069,
    nf_fp_srchaddrsrchcountmo = NULL                                     => 0.00117427537612537,
                                                                            0.00117427537612537));

lncu_tree_159_c2035 :=     __common__( map(
    NULL < nf_bus_ver_src_mos_lseen AND nf_bus_ver_src_mos_lseen < 125 => 0.0103082799485764,
    nf_bus_ver_src_mos_lseen >= 125                                    => 0.174951556289981,
    nf_bus_ver_src_mos_lseen = NULL                                    => 0.0427517984909896,
                                                                          0.0427517984909896));

lncu_tree_159_c2034 :=     __common__( map(
    (rv_e58_br_dead_bus_x_active_phn in ['0-0', '0-1', '0-2', '0-3', '1-1', '2-0', '2-1', '2-2', '2-3', '3-0', '3-1']) => -0.00322735757165866,
    (rv_e58_br_dead_bus_x_active_phn in ['', '1-0', '1-2', '1-3', '3-2', '3-3'])                                       => lncu_tree_159_c2035,
    rv_e58_br_dead_bus_x_active_phn = ''                                                                             => -0.00127255943964974,
                                                                                                                          -0.00127255943964974));

lncu_tree_159 :=     __common__( map(
    NULL < iv_c14_addrs_per_adl AND iv_c14_addrs_per_adl < 18.5 => lncu_tree_159_c2034,
    iv_c14_addrs_per_adl >= 18.5                                => 0.0699762613712158,
    iv_c14_addrs_per_adl = NULL                                 => -0.000675131439061737,
                                                                   -0.000675131439061737));

lncu_tree_160_c2038 :=     __common__( map(
    NULL < nf_inq_corraddrphone AND nf_inq_corraddrphone < 7.5 => 0.00972001485953505,
    nf_inq_corraddrphone >= 7.5                                => 0.0930307079958691,
    nf_inq_corraddrphone = NULL                                => -0.00223693837027541,
                                                                  0.00835552391006852));

lncu_tree_160_c2037 :=     __common__( map(
    NULL < rv_i60_inq_other_recency AND rv_i60_inq_other_recency < 9 => lncu_tree_160_c2038,
    rv_i60_inq_other_recency >= 9                                    => -0.0116773225331328,
    rv_i60_inq_other_recency = NULL                                  => -0.00321627186098781,
                                                                        -0.00321627186098781));

lncu_tree_160 :=     __common__( map(
    NULL < nf_inq_corrnamessn AND nf_inq_corrnamessn < 16.5 => lncu_tree_160_c2037,
    nf_inq_corrnamessn >= 16.5                              => -0.0573288866995198,
    nf_inq_corrnamessn = NULL                               => 0.00104995969492971,
                                                               -0.0025113298615327));

lncu_tree_161_c2040 :=     __common__( map(
    NULL < nf_mos_liens_unrel_cj_fseen AND nf_mos_liens_unrel_cj_fseen < 136 => -0.0229627764912293,
    nf_mos_liens_unrel_cj_fseen >= 136                                       => 0.0497241382413122,
    nf_mos_liens_unrel_cj_fseen = NULL                                       => -0.0164275493486554,
                                                                                -0.0164275493486554));

lncu_tree_161_c2041 :=     __common__( map(
    NULL < rv_mos_since_br_first_seen AND rv_mos_since_br_first_seen < 164.5 => 0.00751528609402871,
    rv_mos_since_br_first_seen >= 164.5                                      => -0.0407199143798325,
    rv_mos_since_br_first_seen = NULL                                        => 0.00337830642976612,
                                                                                0.00337830642976612));

lncu_tree_161 :=     __common__( map(
    NULL < rv_i61_inq_collection_recency AND rv_i61_inq_collection_recency < 2 => lncu_tree_161_c2040,
    rv_i61_inq_collection_recency >= 2                                         => lncu_tree_161_c2041,
    rv_i61_inq_collection_recency = NULL                                       => -0.00221308513012825,
                                                                                  -0.00221308513012825));

lncu_tree_162_c2044 :=     __common__( map(
    NULL < nf_inq_adls_per_phone AND nf_inq_adls_per_phone < 0.5 => 0.0283265106459678,
    nf_inq_adls_per_phone >= 0.5                                 => 0.105797025273202,
    nf_inq_adls_per_phone = NULL                                 => 0.0398958313558951,
                                                                    0.0398958313558951));

lncu_tree_162_c2043 :=     __common__( map(
    NULL < nf_inq_lnamesperaddr_recency AND nf_inq_lnamesperaddr_recency < 9 => lncu_tree_162_c2044,
    nf_inq_lnamesperaddr_recency >= 9                                        => -0.0222389743897178,
    nf_inq_lnamesperaddr_recency = NULL                                      => 0.0188733611192619,
                                                                                0.0188733611192619));

lncu_tree_162 :=     __common__( map(
    NULL < nf_inq_corrphonessn AND nf_inq_corrphonessn < 0.5 => lncu_tree_162_c2043,
    nf_inq_corrphonessn >= 0.5                               => -0.00491748675159933,
    nf_inq_corrphonessn = NULL                               => 0.00403006778458353,
                                                                0.00201639326923999));

lncu_tree_163_c2046 :=     __common__( map(
    (ip_routingmethod in ['', '06', '12', '13', '14'])   => -0.00901290429823407,
    (ip_routingmethod in ['02', '10', '11', '15', '16']) => 0.00861930826980652,
    ip_routingmethod = ''                             => -0.00147063198574444,
                                                            -0.00147063198574444));

lncu_tree_163_c2047 :=     __common__( map(
    NULL < rv_c13_inp_addr_lres AND rv_c13_inp_addr_lres < 80 => -0.120623805736276,
    rv_c13_inp_addr_lres >= 80                                => -0.00580724124132961,
    rv_c13_inp_addr_lres = NULL                               => -0.0648675603880106,
                                                                 -0.0648675603880106));

lncu_tree_163 :=     __common__( map(
    NULL < nf_mos_liens_unrel_o_fseen AND nf_mos_liens_unrel_o_fseen < 150.5 => lncu_tree_163_c2046,
    nf_mos_liens_unrel_o_fseen >= 150.5                                      => lncu_tree_163_c2047,
    nf_mos_liens_unrel_o_fseen = NULL                                        => -0.00283887560781027,
                                                                                -0.00283887560781027));

lncu_tree_164_c2050 :=     __common__( map(
    (iv_f00_email_verification in ['0', '1', '3', '4']) => -0.0254073408882072,
    (iv_f00_email_verification in ['', '2', '5'])       => 0.0405677905829916,
    iv_f00_email_verification = ''                    => 0.00409211366689071,
                                                           0.00409211366689071));

lncu_tree_164_c2049 :=     __common__( map(
    NULL < nf_fp_srchfraudsrchcount AND nf_fp_srchfraudsrchcount < 10.5 => lncu_tree_164_c2050,
    nf_fp_srchfraudsrchcount >= 10.5                                    => -0.050614521512247,
    nf_fp_srchfraudsrchcount = NULL                                     => -0.0136029809005054,
                                                                           -0.0136029809005054));

lncu_tree_164 :=     __common__( map(
    NULL < nf_m_src_credentialed_fs AND nf_m_src_credentialed_fs < 52.5 => lncu_tree_164_c2049,
    nf_m_src_credentialed_fs >= 52.5                                    => 0.00695744762271604,
    nf_m_src_credentialed_fs = NULL                                     => 0.00383347568017378,
                                                                           0.00383347568017378));

lncu_tree_165_c2053 :=     __common__( map(
    (nf_historic_x_current_ct in ['2-1', '3-1', '3-3'])                                 => -0.0461249587135362,
    (nf_historic_x_current_ct in ['', '0-0', '1-0', '1-1', '2-0', '2-2', '3-0', '3-2']) => 0.0309523106329541,
    nf_historic_x_current_ct = ''                                                     => -0.00547166211533135,
                                                                                           -0.00547166211533135));

lncu_tree_165_c2052 :=     __common__( map(
    NULL < rv_c24_prv_addr_lres AND rv_c24_prv_addr_lres < 60.5 => -0.0383898251091659,
    rv_c24_prv_addr_lres >= 60.5                                => lncu_tree_165_c2053,
    rv_c24_prv_addr_lres = NULL                                 => -0.0212693128473754,
                                                                   -0.0212693128473754));

lncu_tree_165 :=     __common__( map(
    NULL < nf_phone_ver_insurance AND nf_phone_ver_insurance < 2.5 => lncu_tree_165_c2052,
    nf_phone_ver_insurance >= 2.5                                  => 0.00126713380230801,
    nf_phone_ver_insurance = NULL                                  => -0.00182963745535363,
                                                                      -0.00182963745535363));

lncu_tree_166_c2056 :=     __common__( map(
    NULL < nf_inq_percurraddr_count12 AND nf_inq_percurraddr_count12 < 7.5 => 0.0169031245594361,
    nf_inq_percurraddr_count12 >= 7.5                                      => 0.0950646710004453,
    nf_inq_percurraddr_count12 = NULL                                      => 0.030706121058593,
                                                                              0.030706121058593));

lncu_tree_166_c2055 :=     __common__( map(
    NULL < nf_corrssnaddr AND nf_corrssnaddr < 2.5 => lncu_tree_166_c2056,
    nf_corrssnaddr >= 2.5                          => 0.000527819281367302,
    nf_corrssnaddr = NULL                          => 0.00299092631189541,
                                                      0.00299092631189541));

lncu_tree_166 :=     __common__( map(
    NULL < nf_inq_addr_ver_count AND nf_inq_addr_ver_count < 0.5 => -0.0237418150465355,
    nf_inq_addr_ver_count >= 0.5                                 => lncu_tree_166_c2055,
    nf_inq_addr_ver_count = NULL                                 => 0.0696933686730606,
                                                                    0.00112540239148139));

lncu_tree_167_c2058 :=     __common__( map(
    NULL < nf_sum_src_credentialed AND nf_sum_src_credentialed < 6.5 => -0.00469978255590692,
    nf_sum_src_credentialed >= 6.5                                   => 0.0845163070119666,
    nf_sum_src_credentialed = NULL                                   => -0.00220100279039249,
                                                                        -0.00220100279039249));

lncu_tree_167_c2059 :=     __common__( map(
    NULL < rv_c24_prv_addr_lres AND rv_c24_prv_addr_lres < 73.5 => -0.049720718849935,
    rv_c24_prv_addr_lres >= 73.5                                => -0.0219070636816992,
    rv_c24_prv_addr_lres = NULL                                 => -0.0382862161696603,
                                                                   -0.0382862161696603));

lncu_tree_167 :=     __common__( map(
    NULL < nf_inq_dobsperssn_1dig AND nf_inq_dobsperssn_1dig < 1 => lncu_tree_167_c2058,
    nf_inq_dobsperssn_1dig >= 1                                  => lncu_tree_167_c2059,
    nf_inq_dobsperssn_1dig = NULL                                => 0.0123829010889415,
                                                                    0.00190310770804488));

lncu_tree_168_c2062 :=     __common__( map(
    (ip_topleveldomain_lvl in ['EDU', 'GOV', 'NET', 'TWO'])                 => -0.007238080387534,
    (ip_topleveldomain_lvl in ['', '-1', 'COM', 'DOT', 'ORG', 'OTH', 'US']) => 0.029469188664051,
    ip_topleveldomain_lvl = ''                                           => 0.00958820591142417,
                                                                               0.00958820591142417));

lncu_tree_168_c2061 :=     __common__( map(
    NULL < nf_inq_corrnameaddr AND nf_inq_corrnameaddr < 10.5 => 0.000387254573110986,
    nf_inq_corrnameaddr >= 10.5                               => -0.0417276462395857,
    nf_inq_corrnameaddr = NULL                                => lncu_tree_168_c2062,
                                                                 0.00266881905090538));

lncu_tree_168 :=     __common__( map(
    NULL < nf_dist_inp_curr_no_ver AND nf_dist_inp_curr_no_ver < -0.5 => lncu_tree_168_c2061,
    nf_dist_inp_curr_no_ver >= -0.5                                   => -0.0377091366389864,
    nf_dist_inp_curr_no_ver = NULL                                    => 0.000998417748304298,
                                                                         0.000998417748304298));

lncu_tree_169_c2064 :=     __common__( map(
    NULL < rv_i60_inq_peradl_count12 AND rv_i60_inq_peradl_count12 < 10.5 => -0.0165188915641401,
    rv_i60_inq_peradl_count12 >= 10.5                                     => 0.0506746226955084,
    rv_i60_inq_peradl_count12 = NULL                                      => -0.0116739488330685,
                                                                             -0.0116739488330685));

lncu_tree_169_c2065 :=     __common__( map(
    NULL < nf_inq_corrnameaddr AND nf_inq_corrnameaddr < 7.5 => 0.0183237844349984,
    nf_inq_corrnameaddr >= 7.5                               => -0.028175599101392,
    nf_inq_corrnameaddr = NULL                               => 0.00659553658736141,
                                                                0.0115654983989936));

lncu_tree_169 :=     __common__( map(
    NULL < rv_c14_unverified_addr_count AND rv_c14_unverified_addr_count < 1.5 => lncu_tree_169_c2064,
    rv_c14_unverified_addr_count >= 1.5                                        => lncu_tree_169_c2065,
    rv_c14_unverified_addr_count = NULL                                        => 0.00451160021314996,
                                                                                  0.00451160021314996));

lncu_tree_170_c2068 :=     __common__( map(
    (nf_historic_x_current_ct in ['1-0', '1-1', '2-1', '2-2', '3-0', '3-3']) => -0.00243001460017134,
    (nf_historic_x_current_ct in ['', '0-0', '2-0', '3-1', '3-2'])           => 0.139075218497832,
    nf_historic_x_current_ct = ''                                          => 0.0683226019488303,
                                                                                0.0683226019488303));

lncu_tree_170_c2067 :=     __common__( map(
    NULL < rv_l79_adls_per_sfd_addr AND rv_l79_adls_per_sfd_addr < 6.5 => 0.00872225487483611,
    rv_l79_adls_per_sfd_addr >= 6.5                                    => lncu_tree_170_c2068,
    rv_l79_adls_per_sfd_addr = NULL                                    => 0.0140432704250383,
                                                                          0.0140432704250383));

lncu_tree_170 :=     __common__( map(
    NULL < rv_d34_liens_unrel_total_amt AND rv_d34_liens_unrel_total_amt < 5602 => -0.00712582492366421,
    rv_d34_liens_unrel_total_amt >= 5602                                        => lncu_tree_170_c2067,
    rv_d34_liens_unrel_total_amt = NULL                                         => -0.00318620368524495,
                                                                                   -0.00318620368524495));

lncu_tree_171_c2071 :=     __common__( map(
    NULL < rv_f00_inq_corrnamessn_adl AND rv_f00_inq_corrnamessn_adl < 0.5 => 0.0437929285028282,
    rv_f00_inq_corrnamessn_adl >= 0.5                                      => -0.00492157772036431,
    rv_f00_inq_corrnamessn_adl = NULL                                      => -3.17776710047346e-05,
                                                                              -0.00222149725825602));

lncu_tree_171_c2070 :=     __common__( map(
    NULL < nf_corrssnname AND nf_corrssnname < 0.5 => -0.0791167077996469,
    nf_corrssnname >= 0.5                          => lncu_tree_171_c2071,
    nf_corrssnname = NULL                          => -0.00314816307118146,
                                                      -0.00314816307118146));

lncu_tree_171 :=     __common__( map(
    NULL < rv_c12_source_profile AND rv_c12_source_profile < 4.35 => 0.0867618993991439,
    rv_c12_source_profile >= 4.35                                 => lncu_tree_171_c2070,
    rv_c12_source_profile = NULL                                  => -0.00242235025608297,
                                                                     -0.00242235025608297));

lncu_tree_172_c2074 :=     __common__( map(
    NULL < nf_bus_ver_src_mos_fseen AND nf_bus_ver_src_mos_fseen < 234.5 => -0.00264938550823924,
    nf_bus_ver_src_mos_fseen >= 234.5                                    => 0.145816309827942,
    nf_bus_ver_src_mos_fseen = NULL                                      => -0.000845384542940829,
                                                                            -0.000845384542940829));

lncu_tree_172_c2073 :=     __common__( map(
    NULL < nf_bus_ver_src_mos_fseen AND nf_bus_ver_src_mos_fseen < 267.5 => lncu_tree_172_c2074,
    nf_bus_ver_src_mos_fseen >= 267.5                                    => -0.0656876984388723,
    nf_bus_ver_src_mos_fseen = NULL                                      => -0.00243844924069802,
                                                                            -0.00243844924069802));

lncu_tree_172 :=     __common__( map(
    NULL < rv_c13_max_lres AND rv_c13_max_lres < 479.5 => lncu_tree_172_c2073,
    rv_c13_max_lres >= 479.5                           => 0.0780595464895703,
    rv_c13_max_lres = NULL                             => -0.00153875105805609,
                                                          -0.00153875105805609));

lncu_tree_173_c2077 :=     __common__( map(
    NULL < rv_d34_liens_unrel_total_amt AND rv_d34_liens_unrel_total_amt < 75842 => -0.00141763759500196,
    rv_d34_liens_unrel_total_amt >= 75842                                        => 0.0920528100532762,
    rv_d34_liens_unrel_total_amt = NULL                                          => 6.22269021337305e-05,
                                                                                    6.22269021337305e-05));

lncu_tree_173_c2076 :=     __common__( map(
    NULL < rv_c18_invalid_addrs_per_adl AND rv_c18_invalid_addrs_per_adl < 4.5 => lncu_tree_173_c2077,
    rv_c18_invalid_addrs_per_adl >= 4.5                                        => -0.0243896739919797,
    rv_c18_invalid_addrs_per_adl = NULL                                        => -0.00491052160715874,
                                                                                  -0.00491052160715874));

lncu_tree_173 :=     __common__( map(
    (ip_topleveldomain_lvl in ['-1', 'COM', 'EDU', 'GOV', 'NET', 'TWO', 'US']) => lncu_tree_173_c2076,
    (ip_topleveldomain_lvl in ['', 'DOT', 'ORG', 'OTH'])                       => 0.0828657291866431,
    ip_topleveldomain_lvl = ''                                               => -0.00412072599033583,
                                                                                  -0.00412072599033583));

lncu_tree_174_c2080 :=     __common__( map(
    NULL < nf_inq_bestlname_ver_count AND nf_inq_bestlname_ver_count < 43.5 => -0.0080212176519845,
    nf_inq_bestlname_ver_count >= 43.5                                      => -0.0624140992070954,
    nf_inq_bestlname_ver_count = NULL                                       => -0.0211485657712663,
                                                                               -0.0211485657712663));

lncu_tree_174_c2079 :=     __common__( map(
    NULL < nf_inquiry_adl_vel_risk_index AND nf_inquiry_adl_vel_risk_index < 3.5 => 0.00370516693957017,
    nf_inquiry_adl_vel_risk_index >= 3.5                                         => lncu_tree_174_c2080,
    nf_inquiry_adl_vel_risk_index = NULL                                         => 0.00181771716082867,
                                                                                    0.00181771716082867));

lncu_tree_174 :=     __common__( map(
    NULL < nf_phone_ver_bureau AND nf_phone_ver_bureau < -0.5 => -0.0680546724563134,
    nf_phone_ver_bureau >= -0.5                               => lncu_tree_174_c2079,
    nf_phone_ver_bureau = NULL                                => 1.15142620157312e-05,
                                                                 1.15142620157312e-05));

lncu_tree_175_c2083 :=     __common__( map(
    NULL < rv_f00_inq_corrnameaddr_adl AND rv_f00_inq_corrnameaddr_adl < 2.5 => -0.00112072659895243,
    rv_f00_inq_corrnameaddr_adl >= 2.5                                       => 0.0615268157846967,
    rv_f00_inq_corrnameaddr_adl = NULL                                       => 0.0292065336091966,
                                                                                0.0251246297837573));

lncu_tree_175_c2082 :=     __common__( map(
    NULL < iv_mos_src_voter_adl_lseen AND iv_mos_src_voter_adl_lseen < 23.5 => 0.000975879713425704,
    iv_mos_src_voter_adl_lseen >= 23.5                                      => lncu_tree_175_c2083,
    iv_mos_src_voter_adl_lseen = NULL                                       => 0.00434425024399941,
                                                                               0.00434425024399941));

lncu_tree_175 :=     __common__( map(
    (rv_e58_br_dead_bus_x_active_phn in ['0-2', '0-3', '1-1', '2-0', '2-3', '3-0', '3-2'])                   => -0.0386802998959932,
    (rv_e58_br_dead_bus_x_active_phn in ['', '0-0', '0-1', '1-0', '1-2', '1-3', '2-1', '2-2', '3-1', '3-3']) => lncu_tree_175_c2082,
    rv_e58_br_dead_bus_x_active_phn = ''                                                                   => 0.00120718251737879,
                                                                                                                0.00120718251737879));

lncu_gbm_logit :=     __common__( lncu_tree_0 +
    lncu_tree_1 +
    lncu_tree_2 +
    lncu_tree_3 +
    lncu_tree_4 +
    lncu_tree_5 +
    lncu_tree_6 +
    lncu_tree_7 +
    lncu_tree_8 +
    lncu_tree_9 +
    lncu_tree_10 +
    lncu_tree_11 +
    lncu_tree_12 +
    lncu_tree_13 +
    lncu_tree_14 +
    lncu_tree_15 +
    lncu_tree_16 +
    lncu_tree_17 +
    lncu_tree_18 +
    lncu_tree_19 +
    lncu_tree_20 +
    lncu_tree_21 +
    lncu_tree_22 +
    lncu_tree_23 +
    lncu_tree_24 +
    lncu_tree_25 +
    lncu_tree_26 +
    lncu_tree_27 +
    lncu_tree_28 +
    lncu_tree_29 +
    lncu_tree_30 +
    lncu_tree_31 +
    lncu_tree_32 +
    lncu_tree_33 +
    lncu_tree_34 +
    lncu_tree_35 +
    lncu_tree_36 +
    lncu_tree_37 +
    lncu_tree_38 +
    lncu_tree_39 +
    lncu_tree_40 +
    lncu_tree_41 +
    lncu_tree_42 +
    lncu_tree_43 +
    lncu_tree_44 +
    lncu_tree_45 +
    lncu_tree_46 +
    lncu_tree_47 +
    lncu_tree_48 +
    lncu_tree_49 +
    lncu_tree_50 +
    lncu_tree_51 +
    lncu_tree_52 +
    lncu_tree_53 +
    lncu_tree_54 +
    lncu_tree_55 +
    lncu_tree_56 +
    lncu_tree_57 +
    lncu_tree_58 +
    lncu_tree_59 +
    lncu_tree_60 +
    lncu_tree_61 +
    lncu_tree_62 +
    lncu_tree_63 +
    lncu_tree_64 +
    lncu_tree_65 +
    lncu_tree_66 +
    lncu_tree_67 +
    lncu_tree_68 +
    lncu_tree_69 +
    lncu_tree_70 +
    lncu_tree_71 +
    lncu_tree_72 +
    lncu_tree_73 +
    lncu_tree_74 +
    lncu_tree_75 +
    lncu_tree_76 +
    lncu_tree_77 +
    lncu_tree_78 +
    lncu_tree_79 +
    lncu_tree_80 +
    lncu_tree_81 +
    lncu_tree_82 +
    lncu_tree_83 +
    lncu_tree_84 +
    lncu_tree_85 +
    lncu_tree_86 +
    lncu_tree_87 +
    lncu_tree_88 +
    lncu_tree_89 +
    lncu_tree_90 +
    lncu_tree_91 +
    lncu_tree_92 +
    lncu_tree_93 +
    lncu_tree_94 +
    lncu_tree_95 +
    lncu_tree_96 +
    lncu_tree_97 +
    lncu_tree_98 +
    lncu_tree_99 +
    lncu_tree_100 +
    lncu_tree_101 +
    lncu_tree_102 +
    lncu_tree_103 +
    lncu_tree_104 +
    lncu_tree_105 +
    lncu_tree_106 +
    lncu_tree_107 +
    lncu_tree_108 +
    lncu_tree_109 +
    lncu_tree_110 +
    lncu_tree_111 +
    lncu_tree_112 +
    lncu_tree_113 +
    lncu_tree_114 +
    lncu_tree_115 +
    lncu_tree_116 +
    lncu_tree_117 +
    lncu_tree_118 +
    lncu_tree_119 +
    lncu_tree_120 +
    lncu_tree_121 +
    lncu_tree_122 +
    lncu_tree_123 +
    lncu_tree_124 +
    lncu_tree_125 +
    lncu_tree_126 +
    lncu_tree_127 +
    lncu_tree_128 +
    lncu_tree_129 +
    lncu_tree_130 +
    lncu_tree_131 +
    lncu_tree_132 +
    lncu_tree_133 +
    lncu_tree_134 +
    lncu_tree_135 +
    lncu_tree_136 +
    lncu_tree_137 +
    lncu_tree_138 +
    lncu_tree_139 +
    lncu_tree_140 +
    lncu_tree_141 +
    lncu_tree_142 +
    lncu_tree_143 +
    lncu_tree_144 +
    lncu_tree_145 +
    lncu_tree_146 +
    lncu_tree_147 +
    lncu_tree_148 +
    lncu_tree_149 +
    lncu_tree_150 +
    lncu_tree_151 +
    lncu_tree_152 +
    lncu_tree_153 +
    lncu_tree_154 +
    lncu_tree_155 +
    lncu_tree_156 +
    lncu_tree_157 +
    lncu_tree_158 +
    lncu_tree_159 +
    lncu_tree_160 +
    lncu_tree_161 +
    lncu_tree_162 +
    lncu_tree_163 +
    lncu_tree_164 +
    lncu_tree_165 +
    lncu_tree_166 +
    lncu_tree_167 +
    lncu_tree_168 +
    lncu_tree_169 +
    lncu_tree_170 +
    lncu_tree_171 +
    lncu_tree_172 +
    lncu_tree_173 +
    lncu_tree_174 +
    lncu_tree_175);

base :=     __common__( 400);

odds :=     __common__( (1 - 0.0534) / 0.0534);

point :=     __common__( -40);

fp1902_1_0 :=     __common__( min(if(max(round(point * (lncu_gbm_logit - ln(odds)) / ln(2) + base), 300) = NULL, -NULL, max(round(point * (lncu_gbm_logit - ln(odds)) / ln(2) + base), 300)), 999));

_sum_bureau :=     __common__( if(max((integer)ver_src_eq, (integer)ver_src_en, (integer)ver_src_tn) = NULL, NULL, sum((integer)ver_src_eq, (integer)ver_src_en, (integer)ver_src_tn)));

_sum_credentialed :=     __common__( if(max((integer)ver_src_ar, (integer)ver_src_am, (integer)ver_src_ba, (integer)ver_src_cg, (integer)ver_src_da, (integer)ver_src_d, (integer)ver_src_dl, (integer)ver_src_eb, (integer)ver_src_e1, (integer)ver_src_e2, (integer)ver_src_e3, (integer)ver_src_fe, (integer)ver_src_ff, (integer)ver_src_p, (integer)ver_src_pl, (integer)ver_src_sl, (integer)ver_src_v, (integer)ver_src_vo, (integer)ver_src_w) = NULL, NULL, sum((integer)ver_src_ar, (integer)ver_src_am, (integer)ver_src_ba, (integer)ver_src_cg, (integer)ver_src_da, (integer)ver_src_d, (integer)ver_src_dl, (integer)ver_src_eb, (integer)ver_src_e1, (integer)ver_src_e2, (integer)ver_src_e3, (integer)ver_src_fe, (integer)ver_src_ff, (integer)ver_src_p, (integer)ver_src_pl, (integer)ver_src_sl, (integer)ver_src_v, (integer)ver_src_vo, (integer)ver_src_w)));

_prop_owner_history :=     __common__( if((add_input_naprop = 4 or add_curr_naprop = 4 or property_owned_total > 0) OR (add_prev_naprop = 4 or Models.Common.findw_cpp(ver_sources, 'P' , ',', 'E') > 0), 1, 0));

beta_synthid_trigger :=     __common__( (integer)(_sum_credentialed = 0 and _sum_bureau > 0 and _prop_owner_history = 0 OR not(truedid)));

num_bureau_fname :=     __common__( (integer)ver_fname_src_eq +
    (integer)ver_fname_src_en +
    (integer)ver_fname_src_tn +
    (integer)ver_fname_src_ts +
    (integer)ver_fname_src_tu);

num_bureau_lname :=     __common__( (integer)ver_lname_src_eq +
    (integer)ver_lname_src_en +
    (integer)ver_lname_src_tn +
    (integer)ver_lname_src_ts +
    (integer)ver_lname_src_tu);

num_bureau_addr :=     __common__( (integer)ver_addr_src_eq +
    (integer)ver_addr_src_en +
    (integer)ver_addr_src_tn +
    (integer)ver_addr_src_ts +
    (integer)ver_addr_src_tu);

num_bureau_ssn :=     __common__( (integer)ver_ssn_src_eq +
    (integer)ver_ssn_src_en +
    (integer)ver_ssn_src_tn +
    (integer)ver_ssn_src_ts +
    (integer)ver_ssn_src_tu);

num_bureau_dob :=     __common__( (integer)ver_dob_src_eq +
    (integer)ver_dob_src_en +
    (integer)ver_dob_src_tn +
    (integer)ver_dob_src_ts +
    (integer)ver_dob_src_tu);

iv_bureau_verification_index :=     __common__( if(not(truedid), NULL, 
                                if(max((integer)(max(num_bureau_fname, num_bureau_lname) > 0), 
                                2  * (integer)(num_bureau_addr > 0),
                                4* (integer)(num_bureau_dob > 0), 
                                8* (integer)(num_bureau_ssn > 0)) = NULL, NULL, 
                                sum(if( (integer)(max(num_bureau_fname, num_bureau_lname) > 0) = NULL, 0, 
                                (integer)(max(num_bureau_fname, num_bureau_lname) > 0)), 
                                if(2 * (integer)(num_bureau_addr > 0) = NULL, 0, 
                                2  * (integer)(num_bureau_addr > 0)), 
                                if(4* (integer)(num_bureau_dob > 0) = NULL, 0, 
                                4 * (integer)(num_bureau_dob > 0)), 
                                if(8* (integer)(num_bureau_ssn > 0) = NULL, 0, 
                                8 * (integer)(num_bureau_ssn > 0))))));

rv_c15_ssns_per_adl_c6_v2 :=     __common__( if(not(truedid), NULL, min(if(ssns_per_adl_c6 = NULL, -NULL, ssns_per_adl_c6), 999)));

rv_s65_ssn_prior_dob :=     __common__( map(
    not(ssnlength > '0' and dobpop)            => NULL,
    rc_ssndobflag = '1' or rc_pwssndobflag = '1' => 1,
    rc_ssndobflag = '0' or rc_pwssndobflag = '0' => 0,
                                                NULL));

rv_c15_ssns_per_adl :=     __common__( map(
    not(truedid)     => NULL,
    ssns_per_adl = 0 => 1,
                        min(if(ssns_per_adl = NULL, -NULL, ssns_per_adl), 999)));

_rc_ssnhighissue :=     __common__( common.sas_date((string)(rc_ssnhighissue)));

// ca_m_snc_ssn_high_issue :=     __common__( map(
    // not((integer)ssnlength > 0)      => NULL,
    // _rc_ssnhighissue = NULL => -1,
                               // min(if(if ((sysdate - _rc_ssnhighissue) / (365.25 / 12) >= 0, truncate((sysdate - _rc_ssnhighissue) / (365.25 / 12)), roundup((sysdate - _rc_ssnhighissue) / (365.25 / 12))) = NULL, -NULL, if ((sysdate - _rc_ssnhighissue) / (365.25 / 12) >= 0, truncate((sysdate - _rc_ssnhighissue) / (365.25 / 12)), roundup((sysdate - _rc_ssnhighissue) / (365.25 / 12)))), 999)));
ca_m_snc_ssn_high_issue :=     __common__( map(
    not((integer)ssnlength > 0)      => NULL,
    _rc_ssnhighissue = NULL => -1,
                               min(if(if ((sysdate - _rc_ssnhighissue) / (365.25 / 12) >= 0, truncate((sysdate - _rc_ssnhighissue) / (365.25 / 12)), roundup((sysdate - _rc_ssnhighissue) / (365.25 / 12))) = NULL, -NULL, if ((sysdate - _rc_ssnhighissue) / (365.25 / 12) >= 0, truncate((sysdate - _rc_ssnhighissue) / (365.25 / 12)), roundup((sysdate - _rc_ssnhighissue) / (365.25 / 12)))), 999)));





co_tgr_fla_bureau_no_ssn :=     __common__( (iv_bureau_verification_index in [3, 5, 7]));

sc_tgr_ssn_fs_6mo :=     __common__( rv_c15_ssns_per_adl_c6_v2 > 0);

sc_tgr_ssn_input_not_best :=     __common__( input_ssn_isbestmatch = '0');

sc_tgr_ssn_prior_dob :=     __common__( rv_s65_ssn_prior_dob = 1);

co_tgr_ssns_per_adl :=     __common__( rv_c15_ssns_per_adl > 4);

co_did_count :=     __common__( did_count > 14);

co_ssn_high_issue :=     __common__( 0 <= ca_m_snc_ssn_high_issue AND ca_m_snc_ssn_high_issue <= 181);

// beta_cpn_trigger :=     __common__( map(
    // co_tgr_fla_bureau_no_ssn = 1  => 1,
    // sc_tgr_ssn_fs_6mo = 1         => 1,
    // sc_tgr_ssn_input_not_best = 1 => 1,
    // sc_tgr_ssn_prior_dob = 1      => 1,
    // co_tgr_ssns_per_adl = 1       => 1,
    // co_did_count = 1              => 1,
    // co_ssn_high_issue = 1         => 1,
                                     // 0));
 beta_cpn_trigger :=     __common__( map(
    co_tgr_fla_bureau_no_ssn   => 1,
    sc_tgr_ssn_fs_6mo          => 1,
    sc_tgr_ssn_input_not_best  => 1,
    sc_tgr_ssn_prior_dob       => 1,
    co_tgr_ssns_per_adl        => 1,
    co_did_count              => 1,
    co_ssn_high_issue          => 1,
                                     0));
_ver_src_ds :=     __common__( Models.Common.findw_cpp(ver_sources, 'DS' , ',', '') > 0);

_ver_src_de :=     __common__( Models.Common.findw_cpp(ver_sources, 'DE' , ',', '') > 0);

_derog :=     __common__( felony_count > 0 OR (integer)addrs_prison_history > 0 OR attr_num_unrel_liens60 > 0 OR attr_eviction_count > 0 OR stl_inq_count > 0 OR inq_highriskcredit_count12 > 0 OR inq_collection_count12 >= 2);

_deceased :=     __common__( rc_decsflag = '1' OR rc_ssndod != 0 OR _ver_src_ds OR _ver_src_de);

_ssnpriortodob :=     __common__( rc_ssndobflag = '1' OR rc_pwssndobflag = '1');

_hh_strikes :=     __common__( if((integer)max((integer)hh_members_w_derog > 0, 
                  (integer)hh_criminals > 0, 
                  (integer)hh_payday_loan_users > 0) = NULL, NULL, 
                  (integer)sum((integer)hh_members_w_derog > 0, 
                  (integer)hh_criminals > 0, 
                  (integer)hh_payday_loan_users > 0)));

stolenid :=     __common__( if(addrpop and (nas_summary in [4, 7, 9]) or fnamepop and lnamepop and addrpop and 1 <= nas_summary AND nas_summary <= 9 and inq_count03 > 0 and (integer)ssnlength = 9 or _deceased or _ssnpriortodob, 1, 0));

suspiciousactivity :=     __common__( if(_derog, 1, 0));

vulnerablevictim :=     __common__( if(0 < inferred_age AND inferred_age <= 17 or inferred_age >= 70, 1, 0));

friendlyfraud :=     __common__( if(hh_members_ct > 1 and (hh_payday_loan_users > 0 or _hh_strikes >= 2 or rel_felony_count >= 2), 1, 0));

stolenc_fp1902_1_0 :=     __common__( if((boolean)stolenid, fp1902_1_0, 299));

synthc_fp1902_1_0 :=     __common__( if((boolean)beta_synthid_trigger, fp1902_1_0, 299));

manip2c_fp1902_1_0 :=     __common__( if((boolean)beta_cpn_trigger, fp1902_1_0, 299));

suspactc_fp1902_1_0 :=     __common__( if((boolean)suspiciousactivity, fp1902_1_0, 299));

vulnvicc_fp1902_1_0 :=     __common__( if((boolean)vulnerablevictim, fp1902_1_0, 299));

friendlyc_fp1902_1_0 :=     __common__( if((boolean)friendlyfraud, fp1902_1_0, 299));

custstolidindex :=     __common__( map(
    stolenc_fp1902_1_0 = 299                                => 1,
    300 <= stolenc_fp1902_1_0 AND stolenc_fp1902_1_0 <= 585 => 9,
    585 < stolenc_fp1902_1_0 AND stolenc_fp1902_1_0 <= 615  => 8,
    615 < stolenc_fp1902_1_0 AND stolenc_fp1902_1_0 <= 635  => 7,
    635 < stolenc_fp1902_1_0 AND stolenc_fp1902_1_0 <= 660  => 6,
    660 < stolenc_fp1902_1_0 AND stolenc_fp1902_1_0 <= 675  => 5,
    675 < stolenc_fp1902_1_0 AND stolenc_fp1902_1_0 <= 700  => 4,
    700 < stolenc_fp1902_1_0 AND stolenc_fp1902_1_0 <= 725  => 3,
    725 < stolenc_fp1902_1_0 AND stolenc_fp1902_1_0 <= 999  => 2,
                                                               99));

custmanipidindex :=     __common__( map(
    manip2c_fp1902_1_0 = 299                                => 1,
    300 <= manip2c_fp1902_1_0 AND manip2c_fp1902_1_0 <= 580 => 9,
    580 < manip2c_fp1902_1_0 AND manip2c_fp1902_1_0 <= 605  => 8,
    605 < manip2c_fp1902_1_0 AND manip2c_fp1902_1_0 <= 635  => 7,
    635 < manip2c_fp1902_1_0 AND manip2c_fp1902_1_0 <= 660  => 6,
    660 < manip2c_fp1902_1_0 AND manip2c_fp1902_1_0 <= 680  => 5,
    680 < manip2c_fp1902_1_0 AND manip2c_fp1902_1_0 <= 695  => 4,
    695 < manip2c_fp1902_1_0 AND manip2c_fp1902_1_0 <= 710  => 3,
    710 < manip2c_fp1902_1_0 AND manip2c_fp1902_1_0 <= 999  => 2,
                                                               99));

custsynthidindex :=     __common__( map(
    synthc_fp1902_1_0 = 299                               => 1,
    300 <= synthc_fp1902_1_0 AND synthc_fp1902_1_0 <= 610 => 9,
    610 < synthc_fp1902_1_0 AND synthc_fp1902_1_0 <= 625  => 8,
    625 < synthc_fp1902_1_0 AND synthc_fp1902_1_0 <= 640  => 7,
    640 < synthc_fp1902_1_0 AND synthc_fp1902_1_0 <= 655  => 6,
    655 < synthc_fp1902_1_0 AND synthc_fp1902_1_0 <= 685  => 5,
    685 < synthc_fp1902_1_0 AND synthc_fp1902_1_0 <= 695  => 4,
    695 < synthc_fp1902_1_0 AND synthc_fp1902_1_0 <= 720  => 3,
    720 < synthc_fp1902_1_0 AND synthc_fp1902_1_0 <= 999  => 2,
                                                             99));

custsuspactindex :=     __common__( map(
    suspactc_fp1902_1_0 = 299                                 => 1,
    300 <= suspactc_fp1902_1_0 AND suspactc_fp1902_1_0 <= 555 => 9,
    555 < suspactc_fp1902_1_0 AND suspactc_fp1902_1_0 <= 575  => 8,
    575 < suspactc_fp1902_1_0 AND suspactc_fp1902_1_0 <= 595  => 7,
    595 < suspactc_fp1902_1_0 AND suspactc_fp1902_1_0 <= 620  => 6,
    620 < suspactc_fp1902_1_0 AND suspactc_fp1902_1_0 <= 655  => 5,
    655 < suspactc_fp1902_1_0 AND suspactc_fp1902_1_0 <= 695  => 4,
    695 < suspactc_fp1902_1_0 AND suspactc_fp1902_1_0 <= 720  => 3,
    720 < suspactc_fp1902_1_0 AND suspactc_fp1902_1_0 <= 999  => 2,
                                                                 99));

custvulnvicindex :=     __common__( map(
    vulnvicc_fp1902_1_0 = 299                                 => 1,
    300 <= vulnvicc_fp1902_1_0 AND vulnvicc_fp1902_1_0 <= 565 => 9,
    565 < vulnvicc_fp1902_1_0 AND vulnvicc_fp1902_1_0 <= 590  => 8,
    590 < vulnvicc_fp1902_1_0 AND vulnvicc_fp1902_1_0 <= 620  => 7,
    620 < vulnvicc_fp1902_1_0 AND vulnvicc_fp1902_1_0 <= 645  => 6,
    645 < vulnvicc_fp1902_1_0 AND vulnvicc_fp1902_1_0 <= 665  => 5,
    665 < vulnvicc_fp1902_1_0 AND vulnvicc_fp1902_1_0 <= 680  => 4,
    680 < vulnvicc_fp1902_1_0 AND vulnvicc_fp1902_1_0 <= 715  => 3,
    715 < vulnvicc_fp1902_1_0 AND vulnvicc_fp1902_1_0 <= 999  => 2,
                                                                 99));

custfriendfrdindex :=     __common__( map(
    friendlyc_fp1902_1_0 = 299                                  => 1,
    300 <= friendlyc_fp1902_1_0 AND friendlyc_fp1902_1_0 <= 565 => 9,
    565 < friendlyc_fp1902_1_0 AND friendlyc_fp1902_1_0 <= 590  => 8,
    590 < friendlyc_fp1902_1_0 AND friendlyc_fp1902_1_0 <= 615  => 7,
    615 < friendlyc_fp1902_1_0 AND friendlyc_fp1902_1_0 <= 635  => 6,
    635 < friendlyc_fp1902_1_0 AND friendlyc_fp1902_1_0 <= 655  => 5,
    655 < friendlyc_fp1902_1_0 AND friendlyc_fp1902_1_0 <= 680  => 4,
    680 < friendlyc_fp1902_1_0 AND friendlyc_fp1902_1_0 <= 705  => 3,
    705 < friendlyc_fp1902_1_0 AND friendlyc_fp1902_1_0 <= 999  => 2,
                                                                   99));




       
                                                                 
   
   //*************************************************************************************//
//     End Generated ECL Code
//*************************************************************************************//

	#if(FP_DEBUG)
		/* Model Input Variables */
                    self.sysdate                          := sysdate;
                    self.sysdate8                         := sysdate8;
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
                    self.ver_fname_src_en_pos             := ver_fname_src_en_pos;
                    self.ver_fname_src_en                 := ver_fname_src_en;
                    self.ver_fname_src_eq_pos             := ver_fname_src_eq_pos;
                    self.ver_fname_src_eq                 := ver_fname_src_eq;
                    self.ver_fname_src_tn_pos             := ver_fname_src_tn_pos;
                    self.ver_fname_src_tn                 := ver_fname_src_tn;
                    self.ver_fname_src_ts_pos             := ver_fname_src_ts_pos;
                    self.ver_fname_src_ts                 := ver_fname_src_ts;
                    self.ver_fname_src_tu_pos             := ver_fname_src_tu_pos;
                    self.ver_fname_src_tu                 := ver_fname_src_tu;
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
                    self.ver_addr_src_en_pos              := ver_addr_src_en_pos;
                    self.ver_addr_src_en                  := ver_addr_src_en;
                    self.ver_addr_src_eq_pos              := ver_addr_src_eq_pos;
                    self.ver_addr_src_eq                  := ver_addr_src_eq;
                    self.ver_addr_src_tn_pos              := ver_addr_src_tn_pos;
                    self.ver_addr_src_tn                  := ver_addr_src_tn;
                    self.ver_addr_src_ts_pos              := ver_addr_src_ts_pos;
                    self.ver_addr_src_ts                  := ver_addr_src_ts;
                    self.ver_addr_src_tu_pos              := ver_addr_src_tu_pos;
                    self.ver_addr_src_tu                  := ver_addr_src_tu;
                    self.ver_ssn_src_en_pos               := ver_ssn_src_en_pos;
                    self.ver_ssn_src_en                   := ver_ssn_src_en;
                    self.ver_ssn_src_eq_pos               := ver_ssn_src_eq_pos;
                    self.ver_ssn_src_eq                   := ver_ssn_src_eq;
                    self.ver_ssn_src_tn_pos               := ver_ssn_src_tn_pos;
                    self.ver_ssn_src_tn                   := ver_ssn_src_tn;
                    self.ver_ssn_src_ts_pos               := ver_ssn_src_ts_pos;
                    self.ver_ssn_src_ts                   := ver_ssn_src_ts;
                    self.ver_ssn_src_tu_pos               := ver_ssn_src_tu_pos;
                    self.ver_ssn_src_tu                   := ver_ssn_src_tu;
                    self.ver_dob_src_en_pos               := ver_dob_src_en_pos;
                    self.ver_dob_src_en                   := ver_dob_src_en;
                    self.ver_dob_src_eq_pos               := ver_dob_src_eq_pos;
                    self.ver_dob_src_eq                   := ver_dob_src_eq;
                    self.ver_dob_src_tn_pos               := ver_dob_src_tn_pos;
                    self.ver_dob_src_tn                   := ver_dob_src_tn;
                    self.ver_dob_src_ts_pos               := ver_dob_src_ts_pos;
                    self.ver_dob_src_ts                   := ver_dob_src_ts;
                    self.ver_dob_src_tu_pos               := ver_dob_src_tu_pos;
                    self.ver_dob_src_tu                   := ver_dob_src_tu;
                    self.util_type_2_pos                  := util_type_2_pos;
                    self.util_type_2                      := util_type_2;
                    self.util_type_1_pos                  := util_type_1_pos;
                    self.util_type_1                      := util_type_1;
                    self.util_type_z_pos                  := util_type_z_pos;
                    self.util_type_z                      := util_type_z;
                    self.util_inp_2_pos                   := util_inp_2_pos;
                    self.util_inp_2                       := util_inp_2;
                    self.util_inp_1_pos                   := util_inp_1_pos;
                    self.util_inp_1                       := util_inp_1;
                    self.util_inp_z_pos                   := util_inp_z_pos;
                    self.util_inp_z                       := util_inp_z;
                    self.util_curr_2_pos                  := util_curr_2_pos;
                    self.util_curr_2                      := util_curr_2;
                    self.util_curr_1_pos                  := util_curr_1_pos;
                    self.util_curr_1                      := util_curr_1;
                    self.util_curr_z_pos                  := util_curr_z_pos;
                    self.util_curr_z                      := util_curr_z;
                    self.bs_ver_src_ar_pos                := bs_ver_src_ar_pos;
                    self._bs_ver_src_fdate_ar             := _bs_ver_src_fdate_ar;
                    self.bs_ver_src_fdate_ar              := bs_ver_src_fdate_ar;
                    self._bs_ver_src_ldate_ar             := _bs_ver_src_ldate_ar;
                    self.bs_ver_src_ldate_ar              := bs_ver_src_ldate_ar;
                    self.bs_ver_src_ba_pos                := bs_ver_src_ba_pos;
                    self._bs_ver_src_fdate_ba             := _bs_ver_src_fdate_ba;
                    self.bs_ver_src_fdate_ba              := bs_ver_src_fdate_ba;
                    self._bs_ver_src_ldate_ba             := _bs_ver_src_ldate_ba;
                    self.bs_ver_src_ldate_ba              := bs_ver_src_ldate_ba;
                    self.bs_ver_src_bc_pos                := bs_ver_src_bc_pos;
                    self._bs_ver_src_fdate_bc             := _bs_ver_src_fdate_bc;
                    self.bs_ver_src_fdate_bc              := bs_ver_src_fdate_bc;
                    self._bs_ver_src_ldate_bc             := _bs_ver_src_ldate_bc;
                    self.bs_ver_src_ldate_bc              := bs_ver_src_ldate_bc;
                    self.bs_ver_src_bm_pos                := bs_ver_src_bm_pos;
                    self._bs_ver_src_fdate_bm             := _bs_ver_src_fdate_bm;
                    self.bs_ver_src_fdate_bm              := bs_ver_src_fdate_bm;
                    self._bs_ver_src_ldate_bm             := _bs_ver_src_ldate_bm;
                    self.bs_ver_src_ldate_bm              := bs_ver_src_ldate_bm;
                    self.bs_ver_src_bn_pos                := bs_ver_src_bn_pos;
                    self._bs_ver_src_fdate_bn             := _bs_ver_src_fdate_bn;
                    self.bs_ver_src_fdate_bn              := bs_ver_src_fdate_bn;
                    self._bs_ver_src_ldate_bn             := _bs_ver_src_ldate_bn;
                    self.bs_ver_src_ldate_bn              := bs_ver_src_ldate_bn;
                    self.bs_ver_src_br_pos                := bs_ver_src_br_pos;
                    self._bs_ver_src_fdate_br             := _bs_ver_src_fdate_br;
                    self.bs_ver_src_fdate_br              := bs_ver_src_fdate_br;
                    self._bs_ver_src_ldate_br             := _bs_ver_src_ldate_br;
                    self.bs_ver_src_ldate_br              := bs_ver_src_ldate_br;
                    self.bs_ver_src_by_pos                := bs_ver_src_by_pos;
                    self._bs_ver_src_fdate_by             := _bs_ver_src_fdate_by;
                    self.bs_ver_src_fdate_by              := bs_ver_src_fdate_by;
                    self._bs_ver_src_ldate_by             := _bs_ver_src_ldate_by;
                    self.bs_ver_src_ldate_by              := bs_ver_src_ldate_by;
                    self.bs_ver_src_c_pos                 := bs_ver_src_c_pos;
                    self._bs_ver_src_fdate_c              := _bs_ver_src_fdate_c;
                    self.bs_ver_src_fdate_c               := bs_ver_src_fdate_c;
                    self._bs_ver_src_ldate_c              := _bs_ver_src_ldate_c;
                    self.bs_ver_src_ldate_c               := bs_ver_src_ldate_c;
                    self.bs_ver_src_cs_pos                := bs_ver_src_cs_pos;
                    self._bs_ver_src_fdate_cs             := _bs_ver_src_fdate_cs;
                    self.bs_ver_src_fdate_cs              := bs_ver_src_fdate_cs;
                    self._bs_ver_src_ldate_cs             := _bs_ver_src_ldate_cs;
                    self.bs_ver_src_ldate_cs              := bs_ver_src_ldate_cs;
                    self.bs_ver_src_cf_pos                := bs_ver_src_cf_pos;
                    self._bs_ver_src_fdate_cf             := _bs_ver_src_fdate_cf;
                    self.bs_ver_src_fdate_cf              := bs_ver_src_fdate_cf;
                    self._bs_ver_src_ldate_cf             := _bs_ver_src_ldate_cf;
                    self.bs_ver_src_ldate_cf              := bs_ver_src_ldate_cf;
                    self.bs_ver_src_cu_pos                := bs_ver_src_cu_pos;
                    self._bs_ver_src_fdate_cu             := _bs_ver_src_fdate_cu;
                    self.bs_ver_src_fdate_cu              := bs_ver_src_fdate_cu;
                    self._bs_ver_src_ldate_cu             := _bs_ver_src_ldate_cu;
                    self.bs_ver_src_ldate_cu              := bs_ver_src_ldate_cu;
                    self.bs_ver_src_d_pos                 := bs_ver_src_d_pos;
                    self._bs_ver_src_fdate_d              := _bs_ver_src_fdate_d;
                    self.bs_ver_src_fdate_d               := bs_ver_src_fdate_d;
                    self._bs_ver_src_ldate_d              := _bs_ver_src_ldate_d;
                    self.bs_ver_src_ldate_d               := bs_ver_src_ldate_d;
                    self.bs_ver_src_da_pos                := bs_ver_src_da_pos;
                    self._bs_ver_src_fdate_da             := _bs_ver_src_fdate_da;
                    self.bs_ver_src_fdate_da              := bs_ver_src_fdate_da;
                    self._bs_ver_src_ldate_da             := _bs_ver_src_ldate_da;
                    self.bs_ver_src_ldate_da              := bs_ver_src_ldate_da;
                    self.bs_ver_src_df_pos                := bs_ver_src_df_pos;
                    self._bs_ver_src_fdate_df             := _bs_ver_src_fdate_df;
                    self.bs_ver_src_fdate_df              := bs_ver_src_fdate_df;
                    self._bs_ver_src_ldate_df             := _bs_ver_src_ldate_df;
                    self.bs_ver_src_ldate_df              := bs_ver_src_ldate_df;
                    self.bs_ver_src_dn_pos                := bs_ver_src_dn_pos;
                    self._bs_ver_src_fdate_dn             := _bs_ver_src_fdate_dn;
                    self.bs_ver_src_fdate_dn              := bs_ver_src_fdate_dn;
                    self._bs_ver_src_ldate_dn             := _bs_ver_src_ldate_dn;
                    self.bs_ver_src_ldate_dn              := bs_ver_src_ldate_dn;
                    self.bs_ver_src_e_pos                 := bs_ver_src_e_pos;
                    self._bs_ver_src_fdate_e              := _bs_ver_src_fdate_e;
                    self.bs_ver_src_fdate_e               := bs_ver_src_fdate_e;
                    self._bs_ver_src_ldate_e              := _bs_ver_src_ldate_e;
                    self.bs_ver_src_ldate_e               := bs_ver_src_ldate_e;
                    self.bs_ver_src_ef_pos                := bs_ver_src_ef_pos;
                    self._bs_ver_src_fdate_ef             := _bs_ver_src_fdate_ef;
                    self.bs_ver_src_fdate_ef              := bs_ver_src_fdate_ef;
                    self._bs_ver_src_ldate_ef             := _bs_ver_src_ldate_ef;
                    self.bs_ver_src_ldate_ef              := bs_ver_src_ldate_ef;
                    self.bs_ver_src_er_pos                := bs_ver_src_er_pos;
                    self._bs_ver_src_fdate_er             := _bs_ver_src_fdate_er;
                    self.bs_ver_src_fdate_er              := bs_ver_src_fdate_er;
                    self._bs_ver_src_ldate_er             := _bs_ver_src_ldate_er;
                    self.bs_ver_src_ldate_er              := bs_ver_src_ldate_er;
                    self.bs_ver_src_ey_pos                := bs_ver_src_ey_pos;
                    self._bs_ver_src_fdate_ey             := _bs_ver_src_fdate_ey;
                    self.bs_ver_src_fdate_ey              := bs_ver_src_fdate_ey;
                    self._bs_ver_src_ldate_ey             := _bs_ver_src_ldate_ey;
                    self.bs_ver_src_ldate_ey              := bs_ver_src_ldate_ey;
                    self.bs_ver_src_f_pos                 := bs_ver_src_f_pos;
                    self._bs_ver_src_fdate_f              := _bs_ver_src_fdate_f;
                    self.bs_ver_src_fdate_f               := bs_ver_src_fdate_f;
                    self._bs_ver_src_ldate_f              := _bs_ver_src_ldate_f;
                    self.bs_ver_src_ldate_f               := bs_ver_src_ldate_f;
                    self.bs_ver_src_fb_pos                := bs_ver_src_fb_pos;
                    self._bs_ver_src_fdate_fb             := _bs_ver_src_fdate_fb;
                    self.bs_ver_src_fdate_fb              := bs_ver_src_fdate_fb;
                    self._bs_ver_src_ldate_fb             := _bs_ver_src_ldate_fb;
                    self.bs_ver_src_ldate_fb              := bs_ver_src_ldate_fb;
                    self.bs_ver_src_fi_pos                := bs_ver_src_fi_pos;
                    self._bs_ver_src_fdate_fi             := _bs_ver_src_fdate_fi;
                    self.bs_ver_src_fdate_fi              := bs_ver_src_fdate_fi;
                    self._bs_ver_src_ldate_fi             := _bs_ver_src_ldate_fi;
                    self.bs_ver_src_ldate_fi              := bs_ver_src_ldate_fi;
                    self.bs_ver_src_fk_pos                := bs_ver_src_fk_pos;
                    self._bs_ver_src_fdate_fk             := _bs_ver_src_fdate_fk;
                    self.bs_ver_src_fdate_fk              := bs_ver_src_fdate_fk;
                    self._bs_ver_src_ldate_fk             := _bs_ver_src_ldate_fk;
                    self.bs_ver_src_ldate_fk              := bs_ver_src_ldate_fk;
                    self.bs_ver_src_fr_pos                := bs_ver_src_fr_pos;
                    self._bs_ver_src_fdate_fr             := _bs_ver_src_fdate_fr;
                    self.bs_ver_src_fdate_fr              := bs_ver_src_fdate_fr;
                    self._bs_ver_src_ldate_fr             := _bs_ver_src_ldate_fr;
                    self.bs_ver_src_ldate_fr              := bs_ver_src_ldate_fr;
                    self.bs_ver_src_ft_pos                := bs_ver_src_ft_pos;
                    self._bs_ver_src_fdate_ft             := _bs_ver_src_fdate_ft;
                    self.bs_ver_src_fdate_ft              := bs_ver_src_fdate_ft;
                    self._bs_ver_src_ldate_ft             := _bs_ver_src_ldate_ft;
                    self.bs_ver_src_ldate_ft              := bs_ver_src_ldate_ft;
                    self.bs_ver_src_gb_pos                := bs_ver_src_gb_pos;
                    self._bs_ver_src_fdate_gb             := _bs_ver_src_fdate_gb;
                    self.bs_ver_src_fdate_gb              := bs_ver_src_fdate_gb;
                    self._bs_ver_src_ldate_gb             := _bs_ver_src_ldate_gb;
                    self.bs_ver_src_ldate_gb              := bs_ver_src_ldate_gb;
                    self.bs_ver_src_gr_pos                := bs_ver_src_gr_pos;
                    self._bs_ver_src_fdate_gr             := _bs_ver_src_fdate_gr;
                    self.bs_ver_src_fdate_gr              := bs_ver_src_fdate_gr;
                    self._bs_ver_src_ldate_gr             := _bs_ver_src_ldate_gr;
                    self.bs_ver_src_ldate_gr              := bs_ver_src_ldate_gr;
                    self.bs_ver_src_h7_pos                := bs_ver_src_h7_pos;
                    self._bs_ver_src_fdate_h7             := _bs_ver_src_fdate_h7;
                    self.bs_ver_src_fdate_h7              := bs_ver_src_fdate_h7;
                    self._bs_ver_src_ldate_h7             := _bs_ver_src_ldate_h7;
                    self.bs_ver_src_ldate_h7              := bs_ver_src_ldate_h7;
                    self.bs_ver_src_i_pos                 := bs_ver_src_i_pos;
                    self._bs_ver_src_fdate_i              := _bs_ver_src_fdate_i;
                    self.bs_ver_src_fdate_i               := bs_ver_src_fdate_i;
                    self._bs_ver_src_ldate_i              := _bs_ver_src_ldate_i;
                    self.bs_ver_src_ldate_i               := bs_ver_src_ldate_i;
                    self.bs_ver_src_ia_pos                := bs_ver_src_ia_pos;
                    self._bs_ver_src_fdate_ia             := _bs_ver_src_fdate_ia;
                    self.bs_ver_src_fdate_ia              := bs_ver_src_fdate_ia;
                    self._bs_ver_src_ldate_ia             := _bs_ver_src_ldate_ia;
                    self.bs_ver_src_ldate_ia              := bs_ver_src_ldate_ia;
                    self.bs_ver_src_ic_pos                := bs_ver_src_ic_pos;
                    self._bs_ver_src_fdate_ic             := _bs_ver_src_fdate_ic;
                    self.bs_ver_src_fdate_ic              := bs_ver_src_fdate_ic;
                    self._bs_ver_src_ldate_ic             := _bs_ver_src_ldate_ic;
                    self.bs_ver_src_ldate_ic              := bs_ver_src_ldate_ic;
                    self.bs_ver_src_in_pos                := bs_ver_src_in_pos;
                    self._bs_ver_src_fdate_in             := _bs_ver_src_fdate_in;
                    self.bs_ver_src_fdate_in              := bs_ver_src_fdate_in;
                    self._bs_ver_src_ldate_in             := _bs_ver_src_ldate_in;
                    self.bs_ver_src_ldate_in              := bs_ver_src_ldate_in;
                    self.bs_ver_src_ip_pos                := bs_ver_src_ip_pos;
                    self._bs_ver_src_fdate_ip             := _bs_ver_src_fdate_ip;
                    self.bs_ver_src_fdate_ip              := bs_ver_src_fdate_ip;
                    self._bs_ver_src_ldate_ip             := _bs_ver_src_ldate_ip;
                    self.bs_ver_src_ldate_ip              := bs_ver_src_ldate_ip;
                    self.bs_ver_src_is_pos                := bs_ver_src_is_pos;
                    self._bs_ver_src_fdate_is             := _bs_ver_src_fdate_is;
                    self.bs_ver_src_fdate_is              := bs_ver_src_fdate_is;
                    self._bs_ver_src_ldate_is             := _bs_ver_src_ldate_is;
                    self.bs_ver_src_ldate_is              := bs_ver_src_ldate_is;
                    self.bs_ver_src_it_pos                := bs_ver_src_it_pos;
                    self._bs_ver_src_fdate_it             := _bs_ver_src_fdate_it;
                    self.bs_ver_src_fdate_it              := bs_ver_src_fdate_it;
                    self._bs_ver_src_ldate_it             := _bs_ver_src_ldate_it;
                    self.bs_ver_src_ldate_it              := bs_ver_src_ldate_it;
                    self.bs_ver_src_j2_pos                := bs_ver_src_j2_pos;
                    self._bs_ver_src_fdate_j2             := _bs_ver_src_fdate_j2;
                    self.bs_ver_src_fdate_j2              := bs_ver_src_fdate_j2;
                    self._bs_ver_src_ldate_j2             := _bs_ver_src_ldate_j2;
                    self.bs_ver_src_ldate_j2              := bs_ver_src_ldate_j2;
                    self.bs_ver_src_kc_pos                := bs_ver_src_kc_pos;
                    self._bs_ver_src_fdate_kc             := _bs_ver_src_fdate_kc;
                    self.bs_ver_src_fdate_kc              := bs_ver_src_fdate_kc;
                    self._bs_ver_src_ldate_kc             := _bs_ver_src_ldate_kc;
                    self.bs_ver_src_ldate_kc              := bs_ver_src_ldate_kc;
                    self.bs_ver_src_l0_pos                := bs_ver_src_l0_pos;
                    self._bs_ver_src_fdate_l0             := _bs_ver_src_fdate_l0;
                    self.bs_ver_src_fdate_l0              := bs_ver_src_fdate_l0;
                    self._bs_ver_src_ldate_l0             := _bs_ver_src_ldate_l0;
                    self.bs_ver_src_ldate_l0              := bs_ver_src_ldate_l0;
                    self.bs_ver_src_l2_pos                := bs_ver_src_l2_pos;
                    self._bs_ver_src_fdate_l2             := _bs_ver_src_fdate_l2;
                    self.bs_ver_src_fdate_l2              := bs_ver_src_fdate_l2;
                    self._bs_ver_src_ldate_l2             := _bs_ver_src_ldate_l2;
                    self.bs_ver_src_ldate_l2              := bs_ver_src_ldate_l2;
                    self.bs_ver_src_mh_pos                := bs_ver_src_mh_pos;
                    self._bs_ver_src_fdate_mh             := _bs_ver_src_fdate_mh;
                    self.bs_ver_src_fdate_mh              := bs_ver_src_fdate_mh;
                    self._bs_ver_src_ldate_mh             := _bs_ver_src_ldate_mh;
                    self.bs_ver_src_ldate_mh              := bs_ver_src_ldate_mh;
                    self.bs_ver_src_mw_pos                := bs_ver_src_mw_pos;
                    self._bs_ver_src_fdate_mw             := _bs_ver_src_fdate_mw;
                    self.bs_ver_src_fdate_mw              := bs_ver_src_fdate_mw;
                    self._bs_ver_src_ldate_mw             := _bs_ver_src_ldate_mw;
                    self.bs_ver_src_ldate_mw              := bs_ver_src_ldate_mw;
                    self.bs_ver_src_np_pos                := bs_ver_src_np_pos;
                    self._bs_ver_src_fdate_np             := _bs_ver_src_fdate_np;
                    self.bs_ver_src_fdate_np              := bs_ver_src_fdate_np;
                    self._bs_ver_src_ldate_np             := _bs_ver_src_ldate_np;
                    self.bs_ver_src_ldate_np              := bs_ver_src_ldate_np;
                    self.bs_ver_src_nr_pos                := bs_ver_src_nr_pos;
                    self._bs_ver_src_fdate_nr             := _bs_ver_src_fdate_nr;
                    self.bs_ver_src_fdate_nr              := bs_ver_src_fdate_nr;
                    self._bs_ver_src_ldate_nr             := _bs_ver_src_ldate_nr;
                    self.bs_ver_src_ldate_nr              := bs_ver_src_ldate_nr;
                    self.bs_ver_src_os_pos                := bs_ver_src_os_pos;
                    self._bs_ver_src_fdate_os             := _bs_ver_src_fdate_os;
                    self.bs_ver_src_fdate_os              := bs_ver_src_fdate_os;
                    self._bs_ver_src_ldate_os             := _bs_ver_src_ldate_os;
                    self.bs_ver_src_ldate_os              := bs_ver_src_ldate_os;
                    self.bs_ver_src_p_pos                 := bs_ver_src_p_pos;
                    self._bs_ver_src_fdate_p              := _bs_ver_src_fdate_p;
                    self.bs_ver_src_fdate_p               := bs_ver_src_fdate_p;
                    self._bs_ver_src_ldate_p              := _bs_ver_src_ldate_p;
                    self.bs_ver_src_ldate_p               := bs_ver_src_ldate_p;
                    self.bs_ver_src_pl_pos                := bs_ver_src_pl_pos;
                    self._bs_ver_src_fdate_pl             := _bs_ver_src_fdate_pl;
                    self.bs_ver_src_fdate_pl              := bs_ver_src_fdate_pl;
                    self._bs_ver_src_ldate_pl             := _bs_ver_src_ldate_pl;
                    self.bs_ver_src_ldate_pl              := bs_ver_src_ldate_pl;
                    self.bs_ver_src_pp_pos                := bs_ver_src_pp_pos;
                    self._bs_ver_src_fdate_pp             := _bs_ver_src_fdate_pp;
                    self.bs_ver_src_fdate_pp              := bs_ver_src_fdate_pp;
                    self._bs_ver_src_ldate_pp             := _bs_ver_src_ldate_pp;
                    self.bs_ver_src_ldate_pp              := bs_ver_src_ldate_pp;
                    self.bs_ver_src_q3_pos                := bs_ver_src_q3_pos;
                    self._bs_ver_src_fdate_q3             := _bs_ver_src_fdate_q3;
                    self.bs_ver_src_fdate_q3              := bs_ver_src_fdate_q3;
                    self._bs_ver_src_ldate_q3             := _bs_ver_src_ldate_q3;
                    self.bs_ver_src_ldate_q3              := bs_ver_src_ldate_q3;
                    self.bs_ver_src_rr_pos                := bs_ver_src_rr_pos;
                    self._bs_ver_src_fdate_rr             := _bs_ver_src_fdate_rr;
                    self.bs_ver_src_fdate_rr              := bs_ver_src_fdate_rr;
                    self._bs_ver_src_ldate_rr             := _bs_ver_src_ldate_rr;
                    self.bs_ver_src_ldate_rr              := bs_ver_src_ldate_rr;
                    self.bs_ver_src_sa_pos                := bs_ver_src_sa_pos;
                    self._bs_ver_src_fdate_sa             := _bs_ver_src_fdate_sa;
                    self.bs_ver_src_fdate_sa              := bs_ver_src_fdate_sa;
                    self._bs_ver_src_ldate_sa             := _bs_ver_src_ldate_sa;
                    self.bs_ver_src_ldate_sa              := bs_ver_src_ldate_sa;
                    self.bs_ver_src_sb_pos                := bs_ver_src_sb_pos;
                    self._bs_ver_src_fdate_sb             := _bs_ver_src_fdate_sb;
                    self.bs_ver_src_fdate_sb              := bs_ver_src_fdate_sb;
                    self._bs_ver_src_ldate_sb             := _bs_ver_src_ldate_sb;
                    self.bs_ver_src_ldate_sb              := bs_ver_src_ldate_sb;
                    self.bs_ver_src_sg_pos                := bs_ver_src_sg_pos;
                    self._bs_ver_src_fdate_sg             := _bs_ver_src_fdate_sg;
                    self.bs_ver_src_fdate_sg              := bs_ver_src_fdate_sg;
                    self._bs_ver_src_ldate_sg             := _bs_ver_src_ldate_sg;
                    self.bs_ver_src_ldate_sg              := bs_ver_src_ldate_sg;
                    self.bs_ver_src_sj_pos                := bs_ver_src_sj_pos;
                    self._bs_ver_src_fdate_sj             := _bs_ver_src_fdate_sj;
                    self.bs_ver_src_fdate_sj              := bs_ver_src_fdate_sj;
                    self._bs_ver_src_ldate_sj             := _bs_ver_src_ldate_sj;
                    self.bs_ver_src_ldate_sj              := bs_ver_src_ldate_sj;
                    self.bs_ver_src_sk_pos                := bs_ver_src_sk_pos;
                    self._bs_ver_src_fdate_sk             := _bs_ver_src_fdate_sk;
                    self.bs_ver_src_fdate_sk              := bs_ver_src_fdate_sk;
                    self._bs_ver_src_ldate_sk             := _bs_ver_src_ldate_sk;
                    self.bs_ver_src_ldate_sk              := bs_ver_src_ldate_sk;
                    self.bs_ver_src_sp_pos                := bs_ver_src_sp_pos;
                    self._bs_ver_src_fdate_sp             := _bs_ver_src_fdate_sp;
                    self.bs_ver_src_fdate_sp              := bs_ver_src_fdate_sp;
                    self._bs_ver_src_ldate_sp             := _bs_ver_src_ldate_sp;
                    self.bs_ver_src_ldate_sp              := bs_ver_src_ldate_sp;
                    self.bs_ver_src_tx_pos                := bs_ver_src_tx_pos;
                    self._bs_ver_src_fdate_tx             := _bs_ver_src_fdate_tx;
                    self.bs_ver_src_fdate_tx              := bs_ver_src_fdate_tx;
                    self._bs_ver_src_ldate_tx             := _bs_ver_src_ldate_tx;
                    self.bs_ver_src_ldate_tx              := bs_ver_src_ldate_tx;
                    self.bs_ver_src_u2_pos                := bs_ver_src_u2_pos;
                    self._bs_ver_src_fdate_u2             := _bs_ver_src_fdate_u2;
                    self.bs_ver_src_fdate_u2              := bs_ver_src_fdate_u2;
                    self._bs_ver_src_ldate_u2             := _bs_ver_src_ldate_u2;
                    self.bs_ver_src_ldate_u2              := bs_ver_src_ldate_u2;
                    self.bs_ver_src_ut_pos                := bs_ver_src_ut_pos;
                    self._bs_ver_src_fdate_ut             := _bs_ver_src_fdate_ut;
                    self.bs_ver_src_fdate_ut              := bs_ver_src_fdate_ut;
                    self._bs_ver_src_ldate_ut             := _bs_ver_src_ldate_ut;
                    self.bs_ver_src_ldate_ut              := bs_ver_src_ldate_ut;
                    self.bs_ver_src_v_pos                 := bs_ver_src_v_pos;
                    self._bs_ver_src_fdate_v              := _bs_ver_src_fdate_v;
                    self.bs_ver_src_fdate_v               := bs_ver_src_fdate_v;
                    self._bs_ver_src_ldate_v              := _bs_ver_src_ldate_v;
                    self.bs_ver_src_ldate_v               := bs_ver_src_ldate_v;
                    self.bs_ver_src_v2_pos                := bs_ver_src_v2_pos;
                    self._bs_ver_src_fdate_v2             := _bs_ver_src_fdate_v2;
                    self.bs_ver_src_fdate_v2              := bs_ver_src_fdate_v2;
                    self._bs_ver_src_ldate_v2             := _bs_ver_src_ldate_v2;
                    self.bs_ver_src_ldate_v2              := bs_ver_src_ldate_v2;
                    self.bs_ver_src_wa_pos                := bs_ver_src_wa_pos;
                    self._bs_ver_src_fdate_wa             := _bs_ver_src_fdate_wa;
                    self.bs_ver_src_fdate_wa              := bs_ver_src_fdate_wa;
                    self._bs_ver_src_ldate_wa             := _bs_ver_src_ldate_wa;
                    self.bs_ver_src_ldate_wa              := bs_ver_src_ldate_wa;
                    self.bs_ver_src_wb_pos                := bs_ver_src_wb_pos;
                    self._bs_ver_src_fdate_wb             := _bs_ver_src_fdate_wb;
                    self.bs_ver_src_fdate_wb              := bs_ver_src_fdate_wb;
                    self._bs_ver_src_ldate_wb             := _bs_ver_src_ldate_wb;
                    self.bs_ver_src_ldate_wb              := bs_ver_src_ldate_wb;
                    self.bs_ver_src_wc_pos                := bs_ver_src_wc_pos;
                    self._bs_ver_src_fdate_wc             := _bs_ver_src_fdate_wc;
                    self.bs_ver_src_fdate_wc              := bs_ver_src_fdate_wc;
                    self._bs_ver_src_ldate_wc             := _bs_ver_src_ldate_wc;
                    self.bs_ver_src_ldate_wc              := bs_ver_src_ldate_wc;
                    self.bs_ver_src_wk_pos                := bs_ver_src_wk_pos;
                    self._bs_ver_src_fdate_wk             := _bs_ver_src_fdate_wk;
                    self.bs_ver_src_fdate_wk              := bs_ver_src_fdate_wk;
                    self._bs_ver_src_ldate_wk             := _bs_ver_src_ldate_wk;
                    self.bs_ver_src_ldate_wk              := bs_ver_src_ldate_wk;
                    self.bs_ver_src_wx_pos                := bs_ver_src_wx_pos;
                    self._bs_ver_src_fdate_wx             := _bs_ver_src_fdate_wx;
                    self.bs_ver_src_fdate_wx              := bs_ver_src_fdate_wx;
                    self._bs_ver_src_ldate_wx             := _bs_ver_src_ldate_wx;
                    self.bs_ver_src_ldate_wx              := bs_ver_src_ldate_wx;
                    self.bs_ver_src_y_pos                 := bs_ver_src_y_pos;
                    self._bs_ver_src_fdate_y              := _bs_ver_src_fdate_y;
                    self.bs_ver_src_fdate_y               := bs_ver_src_fdate_y;
                    self._bs_ver_src_ldate_y              := _bs_ver_src_ldate_y;
                    self.bs_ver_src_ldate_y               := bs_ver_src_ldate_y;
                    self.bs_ver_src_zo_pos                := bs_ver_src_zo_pos;
                    self._bs_ver_src_fdate_zo             := _bs_ver_src_fdate_zo;
                    self.bs_ver_src_fdate_zo              := bs_ver_src_fdate_zo;
                    self._bs_ver_src_ldate_zo             := _bs_ver_src_ldate_zo;
                    self.bs_ver_src_ldate_zo              := bs_ver_src_ldate_zo;
                    self.bs_ssn_ver_src_ar_pos            := bs_ssn_ver_src_ar_pos;
                    self._bs_ssn_ver_src_ldate_ar         := _bs_ssn_ver_src_ldate_ar;
                    self.bs_ssn_ver_src_ldate_ar          := bs_ssn_ver_src_ldate_ar;
                    self.bs_ssn_ver_src_ba_pos            := bs_ssn_ver_src_ba_pos;
                    self._bs_ssn_ver_src_ldate_ba         := _bs_ssn_ver_src_ldate_ba;
                    self.bs_ssn_ver_src_ldate_ba          := bs_ssn_ver_src_ldate_ba;
                    self.bs_ssn_ver_src_bc_pos            := bs_ssn_ver_src_bc_pos;
                    self._bs_ssn_ver_src_ldate_bc         := _bs_ssn_ver_src_ldate_bc;
                    self.bs_ssn_ver_src_ldate_bc          := bs_ssn_ver_src_ldate_bc;
                    self.bs_ssn_ver_src_bm_pos            := bs_ssn_ver_src_bm_pos;
                    self._bs_ssn_ver_src_ldate_bm         := _bs_ssn_ver_src_ldate_bm;
                    self.bs_ssn_ver_src_ldate_bm          := bs_ssn_ver_src_ldate_bm;
                    self.bs_ssn_ver_src_bn_pos            := bs_ssn_ver_src_bn_pos;
                    self._bs_ssn_ver_src_ldate_bn         := _bs_ssn_ver_src_ldate_bn;
                    self.bs_ssn_ver_src_ldate_bn          := bs_ssn_ver_src_ldate_bn;
                    self.bs_ssn_ver_src_br_pos            := bs_ssn_ver_src_br_pos;
                    self._bs_ssn_ver_src_ldate_br         := _bs_ssn_ver_src_ldate_br;
                    self.bs_ssn_ver_src_ldate_br          := bs_ssn_ver_src_ldate_br;
                    self.bs_ssn_ver_src_by_pos            := bs_ssn_ver_src_by_pos;
                    self._bs_ssn_ver_src_ldate_by         := _bs_ssn_ver_src_ldate_by;
                    self.bs_ssn_ver_src_ldate_by          := bs_ssn_ver_src_ldate_by;
                    self.bs_ssn_ver_src_c_pos             := bs_ssn_ver_src_c_pos;
                    self._bs_ssn_ver_src_ldate_c          := _bs_ssn_ver_src_ldate_c;
                    self.bs_ssn_ver_src_ldate_c           := bs_ssn_ver_src_ldate_c;
                    self.bs_ssn_ver_src_cs_pos            := bs_ssn_ver_src_cs_pos;
                    self._bs_ssn_ver_src_ldate_cs         := _bs_ssn_ver_src_ldate_cs;
                    self.bs_ssn_ver_src_ldate_cs          := bs_ssn_ver_src_ldate_cs;
                    self.bs_ssn_ver_src_cf_pos            := bs_ssn_ver_src_cf_pos;
                    self._bs_ssn_ver_src_ldate_cf         := _bs_ssn_ver_src_ldate_cf;
                    self.bs_ssn_ver_src_ldate_cf          := bs_ssn_ver_src_ldate_cf;
                    self.bs_ssn_ver_src_cu_pos            := bs_ssn_ver_src_cu_pos;
                    self._bs_ssn_ver_src_ldate_cu         := _bs_ssn_ver_src_ldate_cu;
                    self.bs_ssn_ver_src_ldate_cu          := bs_ssn_ver_src_ldate_cu;
                    self.bs_ssn_ver_src_d_pos             := bs_ssn_ver_src_d_pos;
                    self._bs_ssn_ver_src_ldate_d          := _bs_ssn_ver_src_ldate_d;
                    self.bs_ssn_ver_src_ldate_d           := bs_ssn_ver_src_ldate_d;
                    self.bs_ssn_ver_src_da_pos            := bs_ssn_ver_src_da_pos;
                    self._bs_ssn_ver_src_ldate_da         := _bs_ssn_ver_src_ldate_da;
                    self.bs_ssn_ver_src_ldate_da          := bs_ssn_ver_src_ldate_da;
                    self.bs_ssn_ver_src_df_pos            := bs_ssn_ver_src_df_pos;
                    self._bs_ssn_ver_src_ldate_df         := _bs_ssn_ver_src_ldate_df;
                    self.bs_ssn_ver_src_ldate_df          := bs_ssn_ver_src_ldate_df;
                    self.bs_ssn_ver_src_dn_pos            := bs_ssn_ver_src_dn_pos;
                    self._bs_ssn_ver_src_ldate_dn         := _bs_ssn_ver_src_ldate_dn;
                    self.bs_ssn_ver_src_ldate_dn          := bs_ssn_ver_src_ldate_dn;
                    self.bs_ssn_ver_src_e_pos             := bs_ssn_ver_src_e_pos;
                    self._bs_ssn_ver_src_ldate_e          := _bs_ssn_ver_src_ldate_e;
                    self.bs_ssn_ver_src_ldate_e           := bs_ssn_ver_src_ldate_e;
                    self.bs_ssn_ver_src_ef_pos            := bs_ssn_ver_src_ef_pos;
                    self._bs_ssn_ver_src_ldate_ef         := _bs_ssn_ver_src_ldate_ef;
                    self.bs_ssn_ver_src_ldate_ef          := bs_ssn_ver_src_ldate_ef;
                    self.bs_ssn_ver_src_er_pos            := bs_ssn_ver_src_er_pos;
                    self._bs_ssn_ver_src_ldate_er         := _bs_ssn_ver_src_ldate_er;
                    self.bs_ssn_ver_src_ldate_er          := bs_ssn_ver_src_ldate_er;
                    self.bs_ssn_ver_src_ey_pos            := bs_ssn_ver_src_ey_pos;
                    self._bs_ssn_ver_src_ldate_ey         := _bs_ssn_ver_src_ldate_ey;
                    self.bs_ssn_ver_src_ldate_ey          := bs_ssn_ver_src_ldate_ey;
                    self.bs_ssn_ver_src_f_pos             := bs_ssn_ver_src_f_pos;
                    self._bs_ssn_ver_src_ldate_f          := _bs_ssn_ver_src_ldate_f;
                    self.bs_ssn_ver_src_ldate_f           := bs_ssn_ver_src_ldate_f;
                    self.bs_ssn_ver_src_fb_pos            := bs_ssn_ver_src_fb_pos;
                    self._bs_ssn_ver_src_ldate_fb         := _bs_ssn_ver_src_ldate_fb;
                    self.bs_ssn_ver_src_ldate_fb          := bs_ssn_ver_src_ldate_fb;
                    self.bs_ssn_ver_src_fi_pos            := bs_ssn_ver_src_fi_pos;
                    self._bs_ssn_ver_src_ldate_fi         := _bs_ssn_ver_src_ldate_fi;
                    self.bs_ssn_ver_src_ldate_fi          := bs_ssn_ver_src_ldate_fi;
                    self.bs_ssn_ver_src_fk_pos            := bs_ssn_ver_src_fk_pos;
                    self._bs_ssn_ver_src_ldate_fk         := _bs_ssn_ver_src_ldate_fk;
                    self.bs_ssn_ver_src_ldate_fk          := bs_ssn_ver_src_ldate_fk;
                    self.bs_ssn_ver_src_fr_pos            := bs_ssn_ver_src_fr_pos;
                    self._bs_ssn_ver_src_ldate_fr         := _bs_ssn_ver_src_ldate_fr;
                    self.bs_ssn_ver_src_ldate_fr          := bs_ssn_ver_src_ldate_fr;
                    self.bs_ssn_ver_src_ft_pos            := bs_ssn_ver_src_ft_pos;
                    self._bs_ssn_ver_src_ldate_ft         := _bs_ssn_ver_src_ldate_ft;
                    self.bs_ssn_ver_src_ldate_ft          := bs_ssn_ver_src_ldate_ft;
                    self.bs_ssn_ver_src_gb_pos            := bs_ssn_ver_src_gb_pos;
                    self._bs_ssn_ver_src_ldate_gb         := _bs_ssn_ver_src_ldate_gb;
                    self.bs_ssn_ver_src_ldate_gb          := bs_ssn_ver_src_ldate_gb;
                    self.bs_ssn_ver_src_gr_pos            := bs_ssn_ver_src_gr_pos;
                    self._bs_ssn_ver_src_ldate_gr         := _bs_ssn_ver_src_ldate_gr;
                    self.bs_ssn_ver_src_ldate_gr          := bs_ssn_ver_src_ldate_gr;
                    self.bs_ssn_ver_src_h7_pos            := bs_ssn_ver_src_h7_pos;
                    self._bs_ssn_ver_src_ldate_h7         := _bs_ssn_ver_src_ldate_h7;
                    self.bs_ssn_ver_src_ldate_h7          := bs_ssn_ver_src_ldate_h7;
                    self.bs_ssn_ver_src_i_pos             := bs_ssn_ver_src_i_pos;
                    self._bs_ssn_ver_src_ldate_i          := _bs_ssn_ver_src_ldate_i;
                    self.bs_ssn_ver_src_ldate_i           := bs_ssn_ver_src_ldate_i;
                    self.bs_ssn_ver_src_ia_pos            := bs_ssn_ver_src_ia_pos;
                    self._bs_ssn_ver_src_ldate_ia         := _bs_ssn_ver_src_ldate_ia;
                    self.bs_ssn_ver_src_ldate_ia          := bs_ssn_ver_src_ldate_ia;
                    self.bs_ssn_ver_src_ic_pos            := bs_ssn_ver_src_ic_pos;
                    self._bs_ssn_ver_src_ldate_ic         := _bs_ssn_ver_src_ldate_ic;
                    self.bs_ssn_ver_src_ldate_ic          := bs_ssn_ver_src_ldate_ic;
                    self.bs_ssn_ver_src_in_pos            := bs_ssn_ver_src_in_pos;
                    self._bs_ssn_ver_src_ldate_in         := _bs_ssn_ver_src_ldate_in;
                    self.bs_ssn_ver_src_ldate_in          := bs_ssn_ver_src_ldate_in;
                    self.bs_ssn_ver_src_ip_pos            := bs_ssn_ver_src_ip_pos;
                    self._bs_ssn_ver_src_ldate_ip         := _bs_ssn_ver_src_ldate_ip;
                    self.bs_ssn_ver_src_ldate_ip          := bs_ssn_ver_src_ldate_ip;
                    self.bs_ssn_ver_src_is_pos            := bs_ssn_ver_src_is_pos;
                    self._bs_ssn_ver_src_ldate_is         := _bs_ssn_ver_src_ldate_is;
                    self.bs_ssn_ver_src_ldate_is          := bs_ssn_ver_src_ldate_is;
                    self.bs_ssn_ver_src_it_pos            := bs_ssn_ver_src_it_pos;
                    self._bs_ssn_ver_src_ldate_it         := _bs_ssn_ver_src_ldate_it;
                    self.bs_ssn_ver_src_ldate_it          := bs_ssn_ver_src_ldate_it;
                    self.bs_ssn_ver_src_j2_pos            := bs_ssn_ver_src_j2_pos;
                    self._bs_ssn_ver_src_ldate_j2         := _bs_ssn_ver_src_ldate_j2;
                    self.bs_ssn_ver_src_ldate_j2          := bs_ssn_ver_src_ldate_j2;
                    self.bs_ssn_ver_src_kc_pos            := bs_ssn_ver_src_kc_pos;
                    self._bs_ssn_ver_src_ldate_kc         := _bs_ssn_ver_src_ldate_kc;
                    self.bs_ssn_ver_src_ldate_kc          := bs_ssn_ver_src_ldate_kc;
                    self.bs_ssn_ver_src_l0_pos            := bs_ssn_ver_src_l0_pos;
                    self._bs_ssn_ver_src_ldate_l0         := _bs_ssn_ver_src_ldate_l0;
                    self.bs_ssn_ver_src_ldate_l0          := bs_ssn_ver_src_ldate_l0;
                    self.bs_ssn_ver_src_l2_pos            := bs_ssn_ver_src_l2_pos;
                    self._bs_ssn_ver_src_ldate_l2         := _bs_ssn_ver_src_ldate_l2;
                    self.bs_ssn_ver_src_ldate_l2          := bs_ssn_ver_src_ldate_l2;
                    self.bs_ssn_ver_src_mh_pos            := bs_ssn_ver_src_mh_pos;
                    self._bs_ssn_ver_src_ldate_mh         := _bs_ssn_ver_src_ldate_mh;
                    self.bs_ssn_ver_src_ldate_mh          := bs_ssn_ver_src_ldate_mh;
                    self.bs_ssn_ver_src_mw_pos            := bs_ssn_ver_src_mw_pos;
                    self._bs_ssn_ver_src_ldate_mw         := _bs_ssn_ver_src_ldate_mw;
                    self.bs_ssn_ver_src_ldate_mw          := bs_ssn_ver_src_ldate_mw;
                    self.bs_ssn_ver_src_np_pos            := bs_ssn_ver_src_np_pos;
                    self._bs_ssn_ver_src_ldate_np         := _bs_ssn_ver_src_ldate_np;
                    self.bs_ssn_ver_src_ldate_np          := bs_ssn_ver_src_ldate_np;
                    self.bs_ssn_ver_src_nr_pos            := bs_ssn_ver_src_nr_pos;
                    self._bs_ssn_ver_src_ldate_nr         := _bs_ssn_ver_src_ldate_nr;
                    self.bs_ssn_ver_src_ldate_nr          := bs_ssn_ver_src_ldate_nr;
                    self.bs_ssn_ver_src_os_pos            := bs_ssn_ver_src_os_pos;
                    self._bs_ssn_ver_src_ldate_os         := _bs_ssn_ver_src_ldate_os;
                    self.bs_ssn_ver_src_ldate_os          := bs_ssn_ver_src_ldate_os;
                    self.bs_ssn_ver_src_p_pos             := bs_ssn_ver_src_p_pos;
                    self._bs_ssn_ver_src_ldate_p          := _bs_ssn_ver_src_ldate_p;
                    self.bs_ssn_ver_src_ldate_p           := bs_ssn_ver_src_ldate_p;
                    self.bs_ssn_ver_src_pl_pos            := bs_ssn_ver_src_pl_pos;
                    self._bs_ssn_ver_src_ldate_pl         := _bs_ssn_ver_src_ldate_pl;
                    self.bs_ssn_ver_src_ldate_pl          := bs_ssn_ver_src_ldate_pl;
                    self.bs_ssn_ver_src_pp_pos            := bs_ssn_ver_src_pp_pos;
                    self._bs_ssn_ver_src_ldate_pp         := _bs_ssn_ver_src_ldate_pp;
                    self.bs_ssn_ver_src_ldate_pp          := bs_ssn_ver_src_ldate_pp;
                    self.bs_ssn_ver_src_q3_pos            := bs_ssn_ver_src_q3_pos;
                    self._bs_ssn_ver_src_ldate_q3         := _bs_ssn_ver_src_ldate_q3;
                    self.bs_ssn_ver_src_ldate_q3          := bs_ssn_ver_src_ldate_q3;
                    self.bs_ssn_ver_src_rr_pos            := bs_ssn_ver_src_rr_pos;
                    self._bs_ssn_ver_src_ldate_rr         := _bs_ssn_ver_src_ldate_rr;
                    self.bs_ssn_ver_src_ldate_rr          := bs_ssn_ver_src_ldate_rr;
                    self.bs_ssn_ver_src_sa_pos            := bs_ssn_ver_src_sa_pos;
                    self._bs_ssn_ver_src_ldate_sa         := _bs_ssn_ver_src_ldate_sa;
                    self.bs_ssn_ver_src_ldate_sa          := bs_ssn_ver_src_ldate_sa;
                    self.bs_ssn_ver_src_sb_pos            := bs_ssn_ver_src_sb_pos;
                    self._bs_ssn_ver_src_ldate_sb         := _bs_ssn_ver_src_ldate_sb;
                    self.bs_ssn_ver_src_ldate_sb          := bs_ssn_ver_src_ldate_sb;
                    self.bs_ssn_ver_src_sg_pos            := bs_ssn_ver_src_sg_pos;
                    self._bs_ssn_ver_src_ldate_sg         := _bs_ssn_ver_src_ldate_sg;
                    self.bs_ssn_ver_src_ldate_sg          := bs_ssn_ver_src_ldate_sg;
                    self.bs_ssn_ver_src_sj_pos            := bs_ssn_ver_src_sj_pos;
                    self._bs_ssn_ver_src_ldate_sj         := _bs_ssn_ver_src_ldate_sj;
                    self.bs_ssn_ver_src_ldate_sj          := bs_ssn_ver_src_ldate_sj;
                    self.bs_ssn_ver_src_sk_pos            := bs_ssn_ver_src_sk_pos;
                    self._bs_ssn_ver_src_ldate_sk         := _bs_ssn_ver_src_ldate_sk;
                    self.bs_ssn_ver_src_ldate_sk          := bs_ssn_ver_src_ldate_sk;
                    self.bs_ssn_ver_src_sp_pos            := bs_ssn_ver_src_sp_pos;
                    self._bs_ssn_ver_src_ldate_sp         := _bs_ssn_ver_src_ldate_sp;
                    self.bs_ssn_ver_src_ldate_sp          := bs_ssn_ver_src_ldate_sp;
                    self.bs_ssn_ver_src_tx_pos            := bs_ssn_ver_src_tx_pos;
                    self._bs_ssn_ver_src_ldate_tx         := _bs_ssn_ver_src_ldate_tx;
                    self.bs_ssn_ver_src_ldate_tx          := bs_ssn_ver_src_ldate_tx;
                    self.bs_ssn_ver_src_u2_pos            := bs_ssn_ver_src_u2_pos;
                    self._bs_ssn_ver_src_ldate_u2         := _bs_ssn_ver_src_ldate_u2;
                    self.bs_ssn_ver_src_ldate_u2          := bs_ssn_ver_src_ldate_u2;
                    self.bs_ssn_ver_src_ut_pos            := bs_ssn_ver_src_ut_pos;
                    self._bs_ssn_ver_src_ldate_ut         := _bs_ssn_ver_src_ldate_ut;
                    self.bs_ssn_ver_src_ldate_ut          := bs_ssn_ver_src_ldate_ut;
                    self.bs_ssn_ver_src_v_pos             := bs_ssn_ver_src_v_pos;
                    self._bs_ssn_ver_src_ldate_v          := _bs_ssn_ver_src_ldate_v;
                    self.bs_ssn_ver_src_ldate_v           := bs_ssn_ver_src_ldate_v;
                    self.bs_ssn_ver_src_v2_pos            := bs_ssn_ver_src_v2_pos;
                    self._bs_ssn_ver_src_ldate_v2         := _bs_ssn_ver_src_ldate_v2;
                    self.bs_ssn_ver_src_ldate_v2          := bs_ssn_ver_src_ldate_v2;
                    self.bs_ssn_ver_src_wa_pos            := bs_ssn_ver_src_wa_pos;
                    self._bs_ssn_ver_src_ldate_wa         := _bs_ssn_ver_src_ldate_wa;
                    self.bs_ssn_ver_src_ldate_wa          := bs_ssn_ver_src_ldate_wa;
                    self.bs_ssn_ver_src_wb_pos            := bs_ssn_ver_src_wb_pos;
                    self._bs_ssn_ver_src_ldate_wb         := _bs_ssn_ver_src_ldate_wb;
                    self.bs_ssn_ver_src_ldate_wb          := bs_ssn_ver_src_ldate_wb;
                    self.bs_ssn_ver_src_wc_pos            := bs_ssn_ver_src_wc_pos;
                    self._bs_ssn_ver_src_ldate_wc         := _bs_ssn_ver_src_ldate_wc;
                    self.bs_ssn_ver_src_ldate_wc          := bs_ssn_ver_src_ldate_wc;
                    self.bs_ssn_ver_src_wk_pos            := bs_ssn_ver_src_wk_pos;
                    self._bs_ssn_ver_src_ldate_wk         := _bs_ssn_ver_src_ldate_wk;
                    self.bs_ssn_ver_src_ldate_wk          := bs_ssn_ver_src_ldate_wk;
                    self.bs_ssn_ver_src_wx_pos            := bs_ssn_ver_src_wx_pos;
                    self._bs_ssn_ver_src_ldate_wx         := _bs_ssn_ver_src_ldate_wx;
                    self.bs_ssn_ver_src_ldate_wx          := bs_ssn_ver_src_ldate_wx;
                    self.bs_ssn_ver_src_y_pos             := bs_ssn_ver_src_y_pos;
                    self._bs_ssn_ver_src_ldate_y          := _bs_ssn_ver_src_ldate_y;
                    self.bs_ssn_ver_src_ldate_y           := bs_ssn_ver_src_ldate_y;
                    self.bs_ssn_ver_src_zo_pos            := bs_ssn_ver_src_zo_pos;
                    self._bs_ssn_ver_src_ldate_zo         := _bs_ssn_ver_src_ldate_zo;
                    self.bs_ssn_ver_src_ldate_zo          := bs_ssn_ver_src_ldate_zo;
                    self.iv_add_apt                       := iv_add_apt;
                    self.add_ec1                          := add_ec1;
                    self.nas_summary_ver                  := nas_summary_ver;
                    self.nap_summary_ver                  := nap_summary_ver;
                    self.infutor_nap_ver                  := infutor_nap_ver;
                    self.dob_ver                          := dob_ver;
                    self.sufficiently_verified            := sufficiently_verified;
                    self.addr_validation_problem          := addr_validation_problem;
                    self.phn_validation_problem           := phn_validation_problem;
                    self.validation_problem               := validation_problem;
                    self.tot_liens                        := tot_liens;
                    self.tot_liens_w_type                 := tot_liens_w_type;
                    self.has_derog                        := has_derog;
                    self.nf_phone_ver_bureau              := nf_phone_ver_bureau;
                    self.ip_routingmethod                 := ip_routingmethod;
                    self.nf_inq_ssn_lexid_diff01          := nf_inq_ssn_lexid_diff01;
                    self.rv_f00_inq_corrdobssn_adl        := rv_f00_inq_corrdobssn_adl;
                    self.rv_i60_inq_comm_recency          := rv_i60_inq_comm_recency;
                    self.nf_inq_perbestssn_count12        := nf_inq_perbestssn_count12;
                    self.nf_fp_varrisktype                := nf_fp_varrisktype;
                    self.rv_i60_inq_hiriskcred_count12    := rv_i60_inq_hiriskcred_count12;
                    self.iv_f00_email_verification        := iv_f00_email_verification;
                    self.nf_inq_per_phone                 := nf_inq_per_phone;
                    self.nf_inq_phone_ver_count           := nf_inq_phone_ver_count;
                    self.rv_c14_addrs_5yr                 := rv_c14_addrs_5yr;
                    self.nf_inq_corraddrphone             := nf_inq_corraddrphone;
                    self.nf_fp_srchvelocityrisktype       := nf_fp_srchvelocityrisktype;
                    self.iv_inf_phn_verd                  := iv_inf_phn_verd;
                    self.nf_historic_x_current_ct         := nf_historic_x_current_ct;
                    self.nf_inq_highriskcredit_count24    := nf_inq_highriskcredit_count24;
                    self.nf_fp_idverrisktype              := nf_fp_idverrisktype;
                    self.nf_inq_adls_per_apt_addr         := nf_inq_adls_per_apt_addr;
                    self.nf_inq_corrnamephone             := nf_inq_corrnamephone;
                    self.earliest_cred_date_all           := earliest_cred_date_all;
                    self.nf_m_src_credentialed_fs         := nf_m_src_credentialed_fs;
                    self.nf_inq_adlsperphone_count_week   := nf_inq_adlsperphone_count_week;
                    self.nf_inq_corrphonessn              := nf_inq_corrphonessn;
                    self.nf_inq_communications_count24    := nf_inq_communications_count24;
                    self.nf_inq_corrdobphone              := nf_inq_corrdobphone;
                    self.nf_inq_dob_ver_count             := nf_inq_dob_ver_count;
                    self.ip_topleveldomain_lvl            := ip_topleveldomain_lvl;
                    self.nf_inq_highriskcredit_count_week := nf_inq_highriskcredit_count_week;
                    self.rv_l79_adls_per_sfd_addr_c6      := rv_l79_adls_per_sfd_addr_c6;
                    self.iv_nap_inf_phone_ver_lvl         := iv_nap_inf_phone_ver_lvl;
                    self.nf_unvrfd_search_risk_index      := nf_unvrfd_search_risk_index;
                    self.nf_fp_srchcomponentrisktype      := nf_fp_srchcomponentrisktype;
                    self.iv_fname_non_phn_src_ct          := iv_fname_non_phn_src_ct;
                    self.nf_fp_srchunvrfdphonecount       := nf_fp_srchunvrfdphonecount;
                    self.rv_i62_inq_dobsperadl_1dig       := rv_i62_inq_dobsperadl_1dig;
                    self.nf_util_adl_count                := nf_util_adl_count;
                    self.nf_inq_banking_count24           := nf_inq_banking_count24;
                    self.rv_c14_addrs_10yr                := rv_c14_addrs_10yr;
                    self.rv_d34_liens_rel_total_amt       := rv_d34_liens_rel_total_amt;
                    self.rv_l79_adls_per_addr_curr        := rv_l79_adls_per_addr_curr;
                    self.rv_6seg_riskview_5_0             := rv_6seg_riskview_5_0;
                    self.ip_state_match                   := ip_state_match;
                    self.nf_inq_per_ssn                   := nf_inq_per_ssn;
                    self.nf_inq_ssnspercurraddr_count12   := nf_inq_ssnspercurraddr_count12;
                    self.rv_i62_inq_phones_per_adl        := rv_i62_inq_phones_per_adl;
                    self.rv_c14_addrs_15yr                := rv_c14_addrs_15yr;
                    self.rv_f00_inq_corrdobaddr_adl       := rv_f00_inq_corrdobaddr_adl;
                    self.nf_fpc_idver_addressmatchescurr  := nf_fpc_idver_addressmatchescurr;
                    self.rv_d31_mostrec_bk                := rv_d31_mostrec_bk;
                    self.rv_d33_eviction_recency          := rv_d33_eviction_recency;
                    self.rv_d34_liens_rel_total_amt84     := rv_d34_liens_rel_total_amt84;
                    self.nf_inq_perphone_count_week       := nf_inq_perphone_count_week;
                    self.nf_invbest_inq_peraddr_diff      := nf_invbest_inq_peraddr_diff;
                    self.rv_l79_adls_per_addr_c6          := rv_l79_adls_per_addr_c6;
                    self.iv_d34_liens_unrel_x_rel         := iv_d34_liens_unrel_x_rel;
                    self.rv_i61_inq_collection_count12    := rv_i61_inq_collection_count12;
                    self.nf_inq_bestdob_ver_count         := nf_inq_bestdob_ver_count;
                    self.nf_inq_adls_per_phone            := nf_inq_adls_per_phone;
                    self.rv_p88_phn_dst_to_inp_add        := rv_p88_phn_dst_to_inp_add;
                    self.nf_inq_addr_ver_count            := nf_inq_addr_ver_count;
                    self.rv_l79_adls_per_sfd_addr         := rv_l79_adls_per_sfd_addr;
                    self.nf_inq_perphone_count12          := nf_inq_perphone_count12;
                    self._liens_unrel_st_last_seen        := _liens_unrel_st_last_seen;
                    self.nf_mos_liens_unrel_st_lseen      := nf_mos_liens_unrel_st_lseen;
                    self.rv_c24_prv_addr_lres             := rv_c24_prv_addr_lres;
                    self.rv_f00_inq_corrphonessn_adl      := rv_f00_inq_corrphonessn_adl;
                    self.rv_i60_inq_prepaidcards_recency  := rv_i60_inq_prepaidcards_recency;
                    self.nf_util_adl_summary              := nf_util_adl_summary;
                    self.d_pos                            := d_pos;
                    self.lic_adl_count_d                  := lic_adl_count_d;
                    self.dl_pos                           := dl_pos;
                    self.lic_adl_count_dl                 := lic_adl_count_dl;
                    self.src_drivers_license_adl_count    := src_drivers_license_adl_count;
                    self.iv_src_drivers_lic_adl_count     := iv_src_drivers_lic_adl_count;
                    self.nf_inq_curraddr_ver_count        := nf_inq_curraddr_ver_count;
                    self._liens_last_unrel_date84         := _liens_last_unrel_date84;
                    self.rv_d34_mos_last_unrel_lien_dt84  := rv_d34_mos_last_unrel_lien_dt84;
                    self.nf_liens_unrel_ot_total_amt      := nf_liens_unrel_ot_total_amt;
                    self.nf_inq_ssns_per_sfd_addr         := nf_inq_ssns_per_sfd_addr;
                    self.nf_inq_bestlname_ver_count       := nf_inq_bestlname_ver_count;
                    self.iv_c13_avg_lres                  := iv_c13_avg_lres;
                    self._header_first_seen               := _header_first_seen;
                    self.rv_c10_m_hdr_fs                  := rv_c10_m_hdr_fs;
                    self.nf_inq_addrsperbestssn_count12   := nf_inq_addrsperbestssn_count12;
                    self.nf_email_name_addr_ver           := nf_email_name_addr_ver;
                    self.nf_historical_count              := nf_historical_count;
                    self.rv_c12_source_profile            := rv_c12_source_profile;
                    self.rv_c23_email_domain_isp_cnt      := rv_c23_email_domain_isp_cnt;
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
                    self.rv_d31_all_bk                    := rv_d31_all_bk;
                    self.nf_util_add_curr_summary         := nf_util_add_curr_summary;
                    self.rv_e58_br_dead_bus_x_active_phn  := rv_e58_br_dead_bus_x_active_phn;
                    self.iv_inf_contradictory             := iv_inf_contradictory;
                    self.nf_inquiry_addr_vel_risk_index   := nf_inquiry_addr_vel_risk_index;
                    self.nf_inquiry_addr_vel_risk_indexv2 := nf_inquiry_addr_vel_risk_indexv2;
                    self.nf_bus_ver_src_mos_reg_lseen     := nf_bus_ver_src_mos_reg_lseen;
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
                    self._liens_unrel_st_first_seen       := _liens_unrel_st_first_seen;
                    self.nf_mos_liens_unrel_st_fseen      := nf_mos_liens_unrel_st_fseen;
                    self.nf_inq_corrnameaddr              := nf_inq_corrnameaddr;
                    self.nf_phones_per_curraddr_c6        := nf_phones_per_curraddr_c6;
                    self.nf_bus_seleids_peradl            := nf_bus_seleids_peradl;
                    self.nf_inq_perssn_count01            := nf_inq_perssn_count01;
                    self.iv_addr_non_phn_src_ct           := iv_addr_non_phn_src_ct;
                    self.rv_c13_curr_addr_lres            := rv_c13_curr_addr_lres;
                    self.nf_addrs_per_bestssn             := nf_addrs_per_bestssn;
                    self.nf_inq_collection_count24        := nf_inq_collection_count24;
                    self.nf_invbest_inq_adlsperaddr_diff  := nf_invbest_inq_adlsperaddr_diff;
                    self.rv_c18_invalid_addrs_per_adl     := rv_c18_invalid_addrs_per_adl;
                    self.nf_bus_ver_src_mos_reg_fseen     := nf_bus_ver_src_mos_reg_fseen;
                    self.nf_bus_ssn_ver_src_mos_lseen     := nf_bus_ssn_ver_src_mos_lseen;
                    self.nf_acc_damage_amt_total          := nf_acc_damage_amt_total;
                    self.nf_invbest_inq_lastperaddr_diff  := nf_invbest_inq_lastperaddr_diff;
                    self.nf_fp_prevaddrlenofres           := nf_fp_prevaddrlenofres;
                    self.rv_i61_inq_collection_recency    := rv_i61_inq_collection_recency;
                    self.no_addr_ver                      := no_addr_ver;
                    self.nf_dist_inp_curr_no_ver          := nf_dist_inp_curr_no_ver;
                    self.nf_inq_addr_recency_risk_index   := nf_inq_addr_recency_risk_index;
                    self.nf_phones_per_addr_curr          := nf_phones_per_addr_curr;
                    self.nf_inq_percurraddr_count12       := nf_inq_percurraddr_count12;
                    self.nf_util_add_input_summary        := nf_util_add_input_summary;
                    self.iv_inf_lname_verd                := iv_inf_lname_verd;
                    self.nf_inq_auto_count24              := nf_inq_auto_count24;
                    self.nf_inq_fname_ver_count           := nf_inq_fname_ver_count;
                    self.rv_i60_inq_peradl_count12        := rv_i60_inq_peradl_count12;
                    self.nf_inq_adls_per_addr             := nf_inq_adls_per_addr;
                    self.nf_inq_lnames_per_apt_addr       := nf_inq_lnames_per_apt_addr;
                    self.rv_c14_unverified_addr_count     := rv_c14_unverified_addr_count;
                    self.nf_inq_corrdobaddr               := nf_inq_corrdobaddr;
                    self.rv_c13_max_lres                  := rv_c13_max_lres;
                    self.rv_c23_email_domain_free_cnt     := rv_c23_email_domain_free_cnt;
                    self.rv_d33_attr_eviction_ct84        := rv_d33_attr_eviction_ct84;
                    self.iv_inq_auto_count01              := iv_inq_auto_count01;
                    self.nf_inq_per_apt_addr              := nf_inq_per_apt_addr;
                    self.rv_i60_inq_retail_recency        := rv_i60_inq_retail_recency;
                    self.nf_inq_adlsperaddr_recency       := nf_inq_adlsperaddr_recency;
                    self.rv_f04_curr_add_occ_index        := rv_f04_curr_add_occ_index;
                    self.rv_c20_m_bureau_adl_fs           := rv_c20_m_bureau_adl_fs;
                    self.nf_inq_ssn_ver_count             := nf_inq_ssn_ver_count;
                    self.nf_fpc_source_dl                 := nf_fpc_source_dl;
                    self.earliest_bureau_date_all         := earliest_bureau_date_all;
                    self.nf_m_bureau_adl_fs_all           := nf_m_bureau_adl_fs_all;
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
                    self.br_first_seen_char               := br_first_seen_char;
                    self._br_first_seen                   := _br_first_seen;
                    self.rv_mos_since_br_first_seen       := rv_mos_since_br_first_seen;
                    self.nf_liens_unrel_cj_total_amt      := nf_liens_unrel_cj_total_amt;
                    self.rv_i62_inq_dobsperadl_recency    := rv_i62_inq_dobsperadl_recency;
                    self.rv_d31_bk_filing_count           := rv_d31_bk_filing_count;
                    self.nf_ssns_per_curraddr_curr        := nf_ssns_per_curraddr_curr;
                    self.nf_inq_count24                   := nf_inq_count24;
                    self.rv_f00_inq_corraddrphone_adl     := rv_f00_inq_corraddrphone_adl;
                    self.nf_inq_adlsperssn_recency        := nf_inq_adlsperssn_recency;
                    self.nf_fp_srchphonesrchcountmo       := nf_fp_srchphonesrchcountmo;
                    self.iv_c14_addrs_per_adl             := iv_c14_addrs_per_adl;
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
                    self.nf_accident_count                := nf_accident_count;
                    self.nf_inq_email_ver_count           := nf_inq_email_ver_count;
                    self.nf_phone_ver_insurance           := nf_phone_ver_insurance;
                    self.rv_i60_inq_auto_count12          := rv_i60_inq_auto_count12;
                    self.nf_inq_corraddrssn               := nf_inq_corraddrssn;
                    self.nf_liens_rel_ot_total_amt        := nf_liens_rel_ot_total_amt;
                    self.rv_c16_inv_ssn_per_adl           := rv_c16_inv_ssn_per_adl;
                    self.nf_inq_corrnamessn               := nf_inq_corrnamessn;
                    self.nf_liens_unrel_sc_total_amt      := nf_liens_unrel_sc_total_amt;
                    self.rv_i60_inq_auto_recency          := rv_i60_inq_auto_recency;
                    self.corrnamedob_src_ak_pos           := corrnamedob_src_ak_pos;
                    self.corrnamedob_src_ak               := corrnamedob_src_ak;
                    self.corrnamedob_src_am_pos           := corrnamedob_src_am_pos;
                    self.corrnamedob_src_am               := corrnamedob_src_am;
                    self.corrnamedob_src_ar_pos           := corrnamedob_src_ar_pos;
                    self.corrnamedob_src_ar               := corrnamedob_src_ar;
                    self.corrnamedob_src_ba_pos           := corrnamedob_src_ba_pos;
                    self.corrnamedob_src_ba               := corrnamedob_src_ba;
                    self.corrnamedob_src_cg_pos           := corrnamedob_src_cg_pos;
                    self.corrnamedob_src_cg               := corrnamedob_src_cg;
                    self.corrnamedob_src_co_pos           := corrnamedob_src_co_pos;
                    self.corrnamedob_src_co               := corrnamedob_src_co;
                    self.corrnamedob_src_cy_pos           := corrnamedob_src_cy_pos;
                    self.corrnamedob_src_cy               := corrnamedob_src_cy;
                    self.corrnamedob_src_da_pos           := corrnamedob_src_da_pos;
                    self.corrnamedob_src_da               := corrnamedob_src_da;
                    self.corrnamedob_src_d_pos            := corrnamedob_src_d_pos;
                    self.corrnamedob_src_d                := corrnamedob_src_d;
                    self.corrnamedob_src_dl_pos           := corrnamedob_src_dl_pos;
                    self.corrnamedob_src_dl               := corrnamedob_src_dl;
                    self.corrnamedob_src_ds_pos           := corrnamedob_src_ds_pos;
                    self.corrnamedob_src_ds               := corrnamedob_src_ds;
                    self.corrnamedob_src_de_pos           := corrnamedob_src_de_pos;
                    self.corrnamedob_src_de               := corrnamedob_src_de;
                    self.corrnamedob_src_eb_pos           := corrnamedob_src_eb_pos;
                    self.corrnamedob_src_eb               := corrnamedob_src_eb;
                    self.corrnamedob_src_em_pos           := corrnamedob_src_em_pos;
                    self.corrnamedob_src_em               := corrnamedob_src_em;
                    self.corrnamedob_src_e1_pos           := corrnamedob_src_e1_pos;
                    self.corrnamedob_src_e1               := corrnamedob_src_e1;
                    self.corrnamedob_src_e2_pos           := corrnamedob_src_e2_pos;
                    self.corrnamedob_src_e2               := corrnamedob_src_e2;
                    self.corrnamedob_src_e3_pos           := corrnamedob_src_e3_pos;
                    self.corrnamedob_src_e3               := corrnamedob_src_e3;
                    self.corrnamedob_src_e4_pos           := corrnamedob_src_e4_pos;
                    self.corrnamedob_src_e4               := corrnamedob_src_e4;
                    self.corrnamedob_src_en_pos           := corrnamedob_src_en_pos;
                    self.corrnamedob_src_en               := corrnamedob_src_en;
                    self.corrnamedob_src_eq_pos           := corrnamedob_src_eq_pos;
                    self.corrnamedob_src_eq               := corrnamedob_src_eq;
                    self.corrnamedob_src_fe_pos           := corrnamedob_src_fe_pos;
                    self.corrnamedob_src_fe               := corrnamedob_src_fe;
                    self.corrnamedob_src_ff_pos           := corrnamedob_src_ff_pos;
                    self.corrnamedob_src_ff               := corrnamedob_src_ff;
                    self.corrnamedob_src_fr_pos           := corrnamedob_src_fr_pos;
                    self.corrnamedob_src_fr               := corrnamedob_src_fr;
                    self.corrnamedob_src_l2_pos           := corrnamedob_src_l2_pos;
                    self.corrnamedob_src_l2               := corrnamedob_src_l2;
                    self.corrnamedob_src_li_pos           := corrnamedob_src_li_pos;
                    self.corrnamedob_src_li               := corrnamedob_src_li;
                    self.corrnamedob_src_mw_pos           := corrnamedob_src_mw_pos;
                    self.corrnamedob_src_mw               := corrnamedob_src_mw;
                    self.corrnamedob_src_nt_pos           := corrnamedob_src_nt_pos;
                    self.corrnamedob_src_nt               := corrnamedob_src_nt;
                    self.corrnamedob_src_p_pos            := corrnamedob_src_p_pos;
                    self.corrnamedob_src_p                := corrnamedob_src_p;
                    self.corrnamedob_src_pl_pos           := corrnamedob_src_pl_pos;
                    self.corrnamedob_src_pl               := corrnamedob_src_pl;
                    self.corrnamedob_src_tn_pos           := corrnamedob_src_tn_pos;
                    self.corrnamedob_src_tn               := corrnamedob_src_tn;
                    self.corrnamedob_src_ts_pos           := corrnamedob_src_ts_pos;
                    self.corrnamedob_src_ts               := corrnamedob_src_ts;
                    self.corrnamedob_src_tu_pos           := corrnamedob_src_tu_pos;
                    self.corrnamedob_src_tu               := corrnamedob_src_tu;
                    self.corrnamedob_src_sl_pos           := corrnamedob_src_sl_pos;
                    self.corrnamedob_src_sl               := corrnamedob_src_sl;
                    self.corrnamedob_src_v_pos            := corrnamedob_src_v_pos;
                    self.corrnamedob_src_v                := corrnamedob_src_v;
                    self.corrnamedob_src_vo_pos           := corrnamedob_src_vo_pos;
                    self.corrnamedob_src_vo               := corrnamedob_src_vo;
                    self.corrnamedob_src_w_pos            := corrnamedob_src_w_pos;
                    self.corrnamedob_src_w                := corrnamedob_src_w;
                    self.corrnamedob_src_wp_pos           := corrnamedob_src_wp_pos;
                    self.corrnamedob_src_wp               := corrnamedob_src_wp;
                    self.corrnamedob_ct                   := corrnamedob_ct;
                    self.nf_corrnamedob                   := nf_corrnamedob;
                    self.nf_inq_corrnameaddrphnssn        := nf_inq_corrnameaddrphnssn;
                    self.nf_liens_unrel_o_total_amt       := nf_liens_unrel_o_total_amt;
                    self.nf_bus_ucc_count                 := nf_bus_ucc_count;
                    self.nf_inq_peraddr_recency           := nf_inq_peraddr_recency;
                    self.nf_inq_corrnamephonessn          := nf_inq_corrnamephonessn;
                    self.rv_f00_inq_corrnameaddr_adl      := rv_f00_inq_corrnameaddr_adl;
                    self.nf_inq_corrdobssn                := nf_inq_corrdobssn;
                    self.rv_i60_inq_other_count12         := rv_i60_inq_other_count12;
                    self.rv_c13_inp_addr_lres             := rv_c13_inp_addr_lres;
                    self._liens_unrel_ft_first_seen       := _liens_unrel_ft_first_seen;
                    self.nf_mos_liens_unrel_ft_fseen      := nf_mos_liens_unrel_ft_fseen;
                    self.nf_phones_per_sfd_addr_curr      := nf_phones_per_sfd_addr_curr;
                    self.rv_c23_email_count               := rv_c23_email_count;
                    self.nf_adls_per_curraddr_curr        := nf_adls_per_curraddr_curr;
                    self.nf_liens_rel_o_total_amt         := nf_liens_rel_o_total_amt;
                    self.rv_4seg_riskview_5_0             := rv_4seg_riskview_5_0;
                    self.nf_fp_srchfraudsrchcount         := nf_fp_srchfraudsrchcount;
                    self.nf_inq_dobsperssn_recency        := nf_inq_dobsperssn_recency;
                    self.rv_a44_curr_add_naprop           := rv_a44_curr_add_naprop;
                    self.nf_inq_other_count24             := nf_inq_other_count24;
                    self.iv_nap_lname_verd                := iv_nap_lname_verd;
                    self.nf_fp_srchaddrsrchcountmo        := nf_fp_srchaddrsrchcountmo;
                    self.nf_fp_srchssnsrchcountmo         := nf_fp_srchssnsrchcountmo;
                    self.rv_i62_inq_addrs_per_adl         := rv_i62_inq_addrs_per_adl;
                    self.nf_bus_ver_src_mos_lseen         := nf_bus_ver_src_mos_lseen;
                    self.rv_i60_inq_other_recency         := rv_i60_inq_other_recency;
                    self._liens_unrel_cj_first_seen       := _liens_unrel_cj_first_seen;
                    self.nf_mos_liens_unrel_cj_fseen      := nf_mos_liens_unrel_cj_fseen;
                    self.nf_inq_lnamesperaddr_recency     := nf_inq_lnamesperaddr_recency;
                    self._liens_unrel_o_first_seen        := _liens_unrel_o_first_seen;
                    self.nf_mos_liens_unrel_o_fseen       := nf_mos_liens_unrel_o_fseen;
                    self.nf_inq_dobsperssn_1dig           := nf_inq_dobsperssn_1dig;
                    self.nf_sum_src_credentialed          := nf_sum_src_credentialed;
                    self.rv_d34_liens_unrel_total_amt     := rv_d34_liens_unrel_total_amt;
                    self.rv_f00_inq_corrnamessn_adl       := rv_f00_inq_corrnamessn_adl;
                    self.nf_bus_ver_src_mos_fseen         := nf_bus_ver_src_mos_fseen;
                    self.nf_inquiry_adl_vel_risk_index    := nf_inquiry_adl_vel_risk_index;
                    self.vo_pos                           := vo_pos;
                    self.vote_adl_lseen_vo                := vote_adl_lseen_vo;
                    self._vote_adl_lseen_vo               := _vote_adl_lseen_vo;
                    self.iv_mos_src_voter_adl_lseen       := iv_mos_src_voter_adl_lseen;
                    self.lncu_tree_0                      := lncu_tree_0;
                    self.lncu_tree_1                      := lncu_tree_1;
                    self.lncu_tree_2                      := lncu_tree_2;
                    self.lncu_tree_3                      := lncu_tree_3;
                    self.lncu_tree_4                      := lncu_tree_4;
                    self.lncu_tree_5                      := lncu_tree_5;
                    self.lncu_tree_6                      := lncu_tree_6;
                    self.lncu_tree_7                      := lncu_tree_7;
                    self.lncu_tree_8                      := lncu_tree_8;
                    self.lncu_tree_9                      := lncu_tree_9;
                    self.lncu_tree_10                     := lncu_tree_10;
                    self.lncu_tree_11                     := lncu_tree_11;
                    self.lncu_tree_12                     := lncu_tree_12;
                    self.lncu_tree_13                     := lncu_tree_13;
                    self.lncu_tree_14                     := lncu_tree_14;
                    self.lncu_tree_15                     := lncu_tree_15;
                    self.lncu_tree_16                     := lncu_tree_16;
                    self.lncu_tree_17                     := lncu_tree_17;
                    self.lncu_tree_18                     := lncu_tree_18;
                    self.lncu_tree_19                     := lncu_tree_19;
                    self.lncu_tree_20                     := lncu_tree_20;
                    self.lncu_tree_21                     := lncu_tree_21;
                    self.lncu_tree_22                     := lncu_tree_22;
                    self.lncu_tree_23                     := lncu_tree_23;
                    self.lncu_tree_24                     := lncu_tree_24;
                    self.lncu_tree_25                     := lncu_tree_25;
                    self.lncu_tree_26                     := lncu_tree_26;
                    self.lncu_tree_27                     := lncu_tree_27;
                    self.lncu_tree_28                     := lncu_tree_28;
                    self.lncu_tree_29                     := lncu_tree_29;
                    self.lncu_tree_30                     := lncu_tree_30;
                    self.lncu_tree_31                     := lncu_tree_31;
                    self.lncu_tree_32                     := lncu_tree_32;
                    self.lncu_tree_33                     := lncu_tree_33;
                    self.lncu_tree_34                     := lncu_tree_34;
                    self.lncu_tree_35                     := lncu_tree_35;
                    self.lncu_tree_36                     := lncu_tree_36;
                    self.lncu_tree_37                     := lncu_tree_37;
                    self.lncu_tree_38                     := lncu_tree_38;
                    self.lncu_tree_39                     := lncu_tree_39;
                    self.lncu_tree_40                     := lncu_tree_40;
                    self.lncu_tree_41                     := lncu_tree_41;
                    self.lncu_tree_42                     := lncu_tree_42;
                    self.lncu_tree_43                     := lncu_tree_43;
                    self.lncu_tree_44                     := lncu_tree_44;
                    self.lncu_tree_45                     := lncu_tree_45;
                    self.lncu_tree_46                     := lncu_tree_46;
                    self.lncu_tree_47                     := lncu_tree_47;
                    self.lncu_tree_48                     := lncu_tree_48;
                    self.lncu_tree_49                     := lncu_tree_49;
                    self.lncu_tree_50                     := lncu_tree_50;
                    self.lncu_tree_51                     := lncu_tree_51;
                    self.lncu_tree_52                     := lncu_tree_52;
                    self.lncu_tree_53                     := lncu_tree_53;
                    self.lncu_tree_54                     := lncu_tree_54;
                    self.lncu_tree_55                     := lncu_tree_55;
                    self.lncu_tree_56                     := lncu_tree_56;
                    self.lncu_tree_57                     := lncu_tree_57;
                    self.lncu_tree_58                     := lncu_tree_58;
                    self.lncu_tree_59                     := lncu_tree_59;
                    self.lncu_tree_60                     := lncu_tree_60;
                    self.lncu_tree_61                     := lncu_tree_61;
                    self.lncu_tree_62                     := lncu_tree_62;
                    self.lncu_tree_63                     := lncu_tree_63;
                    self.lncu_tree_64                     := lncu_tree_64;
                    self.lncu_tree_65                     := lncu_tree_65;
                    self.lncu_tree_66                     := lncu_tree_66;
                    self.lncu_tree_67                     := lncu_tree_67;
                    self.lncu_tree_68                     := lncu_tree_68;
                    self.lncu_tree_69                     := lncu_tree_69;
                    self.lncu_tree_70                     := lncu_tree_70;
                    self.lncu_tree_71                     := lncu_tree_71;
                    self.lncu_tree_72                     := lncu_tree_72;
                    self.lncu_tree_73                     := lncu_tree_73;
                    self.lncu_tree_74                     := lncu_tree_74;
                    self.lncu_tree_75                     := lncu_tree_75;
                    self.lncu_tree_76                     := lncu_tree_76;
                    self.lncu_tree_77                     := lncu_tree_77;
                    self.lncu_tree_78                     := lncu_tree_78;
                    self.lncu_tree_79                     := lncu_tree_79;
                    self.lncu_tree_80                     := lncu_tree_80;
                    self.lncu_tree_81                     := lncu_tree_81;
                    self.lncu_tree_82                     := lncu_tree_82;
                    self.lncu_tree_83                     := lncu_tree_83;
                    self.lncu_tree_84                     := lncu_tree_84;
                    self.lncu_tree_85                     := lncu_tree_85;
                    self.lncu_tree_86                     := lncu_tree_86;
                    self.lncu_tree_87                     := lncu_tree_87;
                    self.lncu_tree_88                     := lncu_tree_88;
                    self.lncu_tree_89                     := lncu_tree_89;
                    self.lncu_tree_90                     := lncu_tree_90;
                    self.lncu_tree_91                     := lncu_tree_91;
                    self.lncu_tree_92                     := lncu_tree_92;
                    self.lncu_tree_93                     := lncu_tree_93;
                    self.lncu_tree_94                     := lncu_tree_94;
                    self.lncu_tree_95                     := lncu_tree_95;
                    self.lncu_tree_96                     := lncu_tree_96;
                    self.lncu_tree_97                     := lncu_tree_97;
                    self.lncu_tree_98                     := lncu_tree_98;
                    self.lncu_tree_99                     := lncu_tree_99;
                    self.lncu_tree_100                    := lncu_tree_100;
                    self.lncu_tree_101                    := lncu_tree_101;
                    self.lncu_tree_102                    := lncu_tree_102;
                    self.lncu_tree_103                    := lncu_tree_103;
                    self.lncu_tree_104                    := lncu_tree_104;
                    self.lncu_tree_105                    := lncu_tree_105;
                    self.lncu_tree_106                    := lncu_tree_106;
                    self.lncu_tree_107                    := lncu_tree_107;
                    self.lncu_tree_108                    := lncu_tree_108;
                    self.lncu_tree_109                    := lncu_tree_109;
                    self.lncu_tree_110                    := lncu_tree_110;
                    self.lncu_tree_111                    := lncu_tree_111;
                    self.lncu_tree_112                    := lncu_tree_112;
                    self.lncu_tree_113                    := lncu_tree_113;
                    self.lncu_tree_114                    := lncu_tree_114;
                    self.lncu_tree_115                    := lncu_tree_115;
                    self.lncu_tree_116                    := lncu_tree_116;
                    self.lncu_tree_117                    := lncu_tree_117;
                    self.lncu_tree_118                    := lncu_tree_118;
                    self.lncu_tree_119                    := lncu_tree_119;
                    self.lncu_tree_120                    := lncu_tree_120;
                    self.lncu_tree_121                    := lncu_tree_121;
                    self.lncu_tree_122                    := lncu_tree_122;
                    self.lncu_tree_123                    := lncu_tree_123;
                    self.lncu_tree_124                    := lncu_tree_124;
                    self.lncu_tree_125                    := lncu_tree_125;
                    self.lncu_tree_126                    := lncu_tree_126;
                    self.lncu_tree_127                    := lncu_tree_127;
                    self.lncu_tree_128                    := lncu_tree_128;
                    self.lncu_tree_129                    := lncu_tree_129;
                    self.lncu_tree_130                    := lncu_tree_130;
                    self.lncu_tree_131                    := lncu_tree_131;
                    self.lncu_tree_132                    := lncu_tree_132;
                    self.lncu_tree_133                    := lncu_tree_133;
                    self.lncu_tree_134                    := lncu_tree_134;
                    self.lncu_tree_135                    := lncu_tree_135;
                    self.lncu_tree_136                    := lncu_tree_136;
                    self.lncu_tree_137                    := lncu_tree_137;
                    self.lncu_tree_138                    := lncu_tree_138;
                    self.lncu_tree_139                    := lncu_tree_139;
                    self.lncu_tree_140                    := lncu_tree_140;
                    self.lncu_tree_141                    := lncu_tree_141;
                    self.lncu_tree_142                    := lncu_tree_142;
                    self.lncu_tree_143                    := lncu_tree_143;
                    self.lncu_tree_144                    := lncu_tree_144;
                    self.lncu_tree_145                    := lncu_tree_145;
                    self.lncu_tree_146                    := lncu_tree_146;
                    self.lncu_tree_147                    := lncu_tree_147;
                    self.lncu_tree_148                    := lncu_tree_148;
                    self.lncu_tree_149                    := lncu_tree_149;
                    self.lncu_tree_150                    := lncu_tree_150;
                    self.lncu_tree_151                    := lncu_tree_151;
                    self.lncu_tree_152                    := lncu_tree_152;
                    self.lncu_tree_153                    := lncu_tree_153;
                    self.lncu_tree_154                    := lncu_tree_154;
                    self.lncu_tree_155                    := lncu_tree_155;
                    self.lncu_tree_156                    := lncu_tree_156;
                    self.lncu_tree_157                    := lncu_tree_157;
                    self.lncu_tree_158                    := lncu_tree_158;
                    self.lncu_tree_159                    := lncu_tree_159;
                    self.lncu_tree_160                    := lncu_tree_160;
                    self.lncu_tree_161                    := lncu_tree_161;
                    self.lncu_tree_162                    := lncu_tree_162;
                    self.lncu_tree_163                    := lncu_tree_163;
                    self.lncu_tree_164                    := lncu_tree_164;
                    self.lncu_tree_165                    := lncu_tree_165;
                    self.lncu_tree_166                    := lncu_tree_166;
                    self.lncu_tree_167                    := lncu_tree_167;
                    self.lncu_tree_168                    := lncu_tree_168;
                    self.lncu_tree_169                    := lncu_tree_169;
                    self.lncu_tree_170                    := lncu_tree_170;
                    self.lncu_tree_171                    := lncu_tree_171;
                    self.lncu_tree_172                    := lncu_tree_172;
                    self.lncu_tree_173                    := lncu_tree_173;
                    self.lncu_tree_174                    := lncu_tree_174;
                    self.lncu_tree_175                    := lncu_tree_175;
                    self.lncu_gbm_logit                   := lncu_gbm_logit;
                    self.base                             := base;
                    self.odds                             := odds;
                    self.point                            := point;
                    self.fp1902_1_0                       := fp1902_1_0;
                    self._sum_bureau                      := _sum_bureau;
                    self._sum_credentialed                := _sum_credentialed;
                    self._prop_owner_history              := _prop_owner_history;
                    self.beta_synthid_trigger             := beta_synthid_trigger;
                    self.num_bureau_fname                 := num_bureau_fname;
                    self.num_bureau_lname                 := num_bureau_lname;
                    self.num_bureau_addr                  := num_bureau_addr;
                    self.num_bureau_ssn                   := num_bureau_ssn;
                    self.num_bureau_dob                   := num_bureau_dob;
                    self.iv_bureau_verification_index     := iv_bureau_verification_index;
                    self.rv_c15_ssns_per_adl_c6_v2        := rv_c15_ssns_per_adl_c6_v2;
                    self.rv_s65_ssn_prior_dob             := rv_s65_ssn_prior_dob;
                    self.rv_c15_ssns_per_adl              := rv_c15_ssns_per_adl;
                    self._rc_ssnhighissue                 := _rc_ssnhighissue;
                    self.ca_m_snc_ssn_high_issue          := ca_m_snc_ssn_high_issue;
                    self.co_tgr_fla_bureau_no_ssn         := co_tgr_fla_bureau_no_ssn;
                    self.sc_tgr_ssn_fs_6mo                := sc_tgr_ssn_fs_6mo;
                    self.sc_tgr_ssn_input_not_best        := sc_tgr_ssn_input_not_best;
                    self.sc_tgr_ssn_prior_dob             := sc_tgr_ssn_prior_dob;
                    self.co_tgr_ssns_per_adl              := co_tgr_ssns_per_adl;
                    self.co_did_count                     := co_did_count;
                    self.co_ssn_high_issue                := co_ssn_high_issue;
                    self.beta_cpn_trigger                 := beta_cpn_trigger;
                    self._ver_src_ds                      := _ver_src_ds;
                    self._ver_src_de                      := _ver_src_de;
                    self._derog                           := _derog;
                    self._deceased                        := _deceased;
                    self._ssnpriortodob                   := _ssnpriortodob;
                    self._hh_strikes                      := _hh_strikes;
                    self.stolenid                         := stolenid;
                    self.suspiciousactivity               := suspiciousactivity;
                    self.vulnerablevictim                 := vulnerablevictim;
                    self.friendlyfraud                    := friendlyfraud;
                    self.stolenc_fp1902_1_0               := stolenc_fp1902_1_0;
                    self.synthc_fp1902_1_0                := synthc_fp1902_1_0;
                    self.manip2c_fp1902_1_0               := manip2c_fp1902_1_0;
                    self.suspactc_fp1902_1_0              := suspactc_fp1902_1_0;
                    self.vulnvicc_fp1902_1_0              := vulnvicc_fp1902_1_0;
                    self.friendlyc_fp1902_1_0             := friendlyc_fp1902_1_0;
                    self.custstolidindex                  := custstolidindex;
                    self.custmanipidindex                 := custmanipidindex;
                    self.custsynthidindex                 := custsynthidindex;
                    self.custsuspactindex                 := custsuspactindex;
                    self.custfriendfrdindex               := custfriendfrdindex;
                    self.custvulnvicindex                 := custvulnvicindex;

	                 // SELF.clam                             := le;                     //***Attach the entire Boca Shell when DEBUG MODE is TRUE
	                //  SELF.clam                             := le.bs;                     //***Attach the entire Boca Shell when DEBUG MODE is TRUE
	                  SELF.clam_ip.bs                            := le.bs;                     //***Attach the entire Boca Shell when DEBUG MODE is TRUE
	                  SELF.clam_ip.ip                            := le.ip;                     //***Attach the entire Boca Shell when DEBUG MODE is TRUE
#end

	           self.seq                                     := le.bs.seq;
	           self.StolenIdentityIndex                     := (STRING) custstolidindex;
	           self.SyntheticIdentityIndex                  := (STRING) custsynthidindex;
	           self.ManipulatedIdentityIndex                := (STRING) custmanipidindex;
	           self.VulnerableVictimIndex                   := (STRING) custvulnvicindex;
	           self.FriendlyFraudIndex                      := (STRING) custfriendfrdindex;
	           self.SuspiciousActivityIndex                 := (STRING) custsuspactindex; 
             le_transformed := PROJECT(le.bs, TRANSFORM(risk_indicators.Layout_Boca_Shell, SELF := LEFT));
            // ritmp                                        :=  Models.fraudpoint3_reasons(le_transformed ,blank_ip, num_reasons);
             ritmp                                        :=  Models.fraudpoint3_reasons(le_transformed ,le.ip, num_reasons);
	           reasons                                      :=  Models.Common.checkFraudPointRC34(FP1902_1_0, ritmp, num_reasons);
	           self.ri                                      := reasons;
	           self.score                                   := (STRING)FP1902_1_0;
	           //self                                         := [];
	
      END;

 // model :=   project(clam, doModel(left) );
  // model :=   project(clam, doModel(left) );
    model :=   project(clam_ip, doModel(left) );
	
	 return model;
 END;
	



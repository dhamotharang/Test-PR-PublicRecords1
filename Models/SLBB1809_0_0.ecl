IMPORT Models, Risk_Indicators, std, Business_Risk_BIP;

// same model as SLBB1702_0_2 without fellony attr_felonies30 =0;      
// attr_felonies90 =0;    
// attr_felonies180 =0;     
// attr_felonies12 =0;      
// attr_felonies24 =0;      
// attr_felonies36 =0;      
// attr_felonies60 =0;
// felony_count =0;
// assoc_felony_count =0; 


EXPORT SLBB1809_0_0 (GROUPED DATASET(Business_Risk_BIP.Layouts.Shell) busShell, GROUPED DATASET(Risk_Indicators.Layout_Boca_Shell) clam ) := FUNCTION

	MODEL_DEBUG := false;
	// MODEL_DEBUG := true;

	#if(MODEL_DEBUG)
		Layout_Debug := RECORD
    INTEGER sysdate                          ;
				String _ver_src_id_fsrc_fdate           ;
				INTEGER _ver_src_id_fsrc_fdate2          ;
				INTEGER yr__ver_src_id_fsrc_fdate        ;
				INTEGER mth__ver_src_id_fsrc_fdate       ;
				INTEGER _ver_src_id_br_pos               ;
				BOOLEAN _ver_src_id__br                  ;
				string _ver_src_id_fdate_br             ;
				INTEGER _ver_src_id_fdate_br2            ;
				INTEGER yr__ver_src_id_fdate_br          ;
				INTEGER mth__ver_src_id_fdate_br         ;
				string _ver_src_id_ldate_br             ;
				INTEGER _ver_src_id_ldate_br2            ;
				INTEGER yr__ver_src_id_ldate_br          ;
				INTEGER mth__ver_src_id_ldate_br         ;
				INTEGER _ver_src_id_c_pos                ;
				BOOLEAN _ver_src_id__c                   ;
				string _ver_src_id_fdate_c              ;
				INTEGER _ver_src_id_fdate_c2             ;
				INTEGER yr__ver_src_id_fdate_c           ;
				INTEGER mth__ver_src_id_fdate_c          ;
				string _ver_src_id_ldate_c              ;
				INTEGER _ver_src_id_ldate_c2             ;
				INTEGER yr__ver_src_id_ldate_c           ;
				INTEGER mth__ver_src_id_ldate_c          ;
				INTEGER _ver_src_id_d_pos                ;
				BOOLEAN _ver_src_id__d                   ;
				String _ver_src_id_fdate_d              ;
				INTEGER _ver_src_id_fdate_d2             ;
				INTEGER yr__ver_src_id_fdate_d           ;
				INTEGER mth__ver_src_id_fdate_d          ;
				string _ver_src_id_ldate_d              ;
				INTEGER _ver_src_id_ldate_d2             ;
				Real yr__ver_src_id_ldate_d           ;
				INTEGER mth__ver_src_id_ldate_d          ;
				INTEGER _ver_src_id_df_pos               ;
				BOOLEAN _ver_src_id__df                  ;
				string _ver_src_id_fdate_df             ;
				INTEGER _ver_src_id_fdate_df2            ;
				INTEGER yr__ver_src_id_fdate_df          ;
				INTEGER mth__ver_src_id_fdate_df         ;
				string _ver_src_id_ldate_df             ;
				INTEGER _ver_src_id_ldate_df2            ;
				INTEGER yr__ver_src_id_ldate_df          ;
				INTEGER mth__ver_src_id_ldate_df         ;
				INTEGER _ver_src_id_dn_pos               ;
				BOOLEAN _ver_src_id__dn                  ;
				string _ver_src_id_fdate_dn             ;
				INTEGER _ver_src_id_fdate_dn2            ;
				INTEGER yr__ver_src_id_fdate_dn          ;
				INTEGER mth__ver_src_id_fdate_dn         ;
				string _ver_src_id_ldate_dn             ;
				INTEGER _ver_src_id_ldate_dn2            ;
				INTEGER yr__ver_src_id_ldate_dn          ;
				INTEGER mth__ver_src_id_ldate_dn         ;
				INTEGER _ver_src_id_fb_pos               ;
				BOOLEAN _ver_src_id__fb                  ;
				string _ver_src_id_fdate_fb             ;
				INTEGER _ver_src_id_fdate_fb2            ;
				INTEGER yr__ver_src_id_fdate_fb          ;
				INTEGER mth__ver_src_id_fdate_fb         ;
				string _ver_src_id_ldate_fb             ;
				INTEGER _ver_src_id_ldate_fb2            ;
				INTEGER yr__ver_src_id_ldate_fb          ;
				Real mth__ver_src_id_ldate_fb         ;
				INTEGER _ver_src_id_l0_pos               ;
				BOOLEAN _ver_src_id__l0                  ;
				string _ver_src_id_fdate_l0             ;
				INTEGER _ver_src_id_fdate_l02            ;
				INTEGER yr__ver_src_id_fdate_l0          ;
				INTEGER mth__ver_src_id_fdate_l0         ;
				string _ver_src_id_ldate_l0             ;
				INTEGER _ver_src_id_ldate_l02            ;
				INTEGER yr__ver_src_id_ldate_l0          ;
				INTEGER mth__ver_src_id_ldate_l0         ;
				INTEGER _ver_src_id_l2_pos               ;
				BOOLEAN _ver_src_id__l2                  ;
				string _ver_src_id_fdate_l2             ;
				INTEGER _ver_src_id_fdate_l22            ;
				Real yr__ver_src_id_fdate_l2          ;
				INTEGER mth__ver_src_id_fdate_l2         ;
				string _ver_src_id_ldate_l2             ;
				INTEGER _ver_src_id_ldate_l22            ;
				INTEGER yr__ver_src_id_ldate_l2          ;
				INTEGER mth__ver_src_id_ldate_l2         ;
				INTEGER _ver_src_id_u2_pos               ;
				BOOLEAN _ver_src_id__u2                  ;
				string _ver_src_id_fdate_u2             ;
				INTEGER _ver_src_id_fdate_u22            ;
				INTEGER yr__ver_src_id_fdate_u2          ;
				INTEGER mth__ver_src_id_fdate_u2         ;
				string _ver_src_id_ldate_u2             ;
				INTEGER _ver_src_id_ldate_u22            ;
				INTEGER yr__ver_src_id_ldate_u2          ;
				INTEGER mth__ver_src_id_ldate_u2         ;
				INTEGER _ver_src_id_ar_pos               ;
				BOOLEAN _ver_src_id__ar                  ;
				string _ver_src_id_fdate_ar             ;
				INTEGER _ver_src_id_fdate_ar2            ;
				INTEGER yr__ver_src_id_fdate_ar          ;
				INTEGER mth__ver_src_id_fdate_ar         ;
				string _ver_src_id_ldate_ar             ;
				Integer _ver_src_id_ldate_ar2            ;
				INTEGER yr__ver_src_id_ldate_ar          ;
				INTEGER mth__ver_src_id_ldate_ar         ;
				INTEGER _ver_src_id_ba_pos               ;
				BOOLEAN _ver_src_id__ba                  ;
				string _ver_src_id_fdate_ba             ;
				INTEGER _ver_src_id_fdate_ba2            ;
				INTEGER yr__ver_src_id_fdate_ba          ;
				INTEGER mth__ver_src_id_fdate_ba         ;
				string _ver_src_id_ldate_ba             ;
				INTEGER _ver_src_id_ldate_ba2            ;
				INTEGER yr__ver_src_id_ldate_ba          ;
				INTEGER mth__ver_src_id_ldate_ba         ;
				INTEGER _ver_src_id_bm_pos               ;
				BOOLEAN _ver_src_id__bm                  ;
				string _ver_src_id_fdate_bm             ;
				INTEGER _ver_src_id_fdate_bm2            ;
				INTEGER yr__ver_src_id_fdate_bm          ;
				INTEGER mth__ver_src_id_fdate_bm         ;
				string _ver_src_id_ldate_bm             ;
				INTEGER _ver_src_id_ldate_bm2            ;
				INTEGER yr__ver_src_id_ldate_bm          ;
				INTEGER mth__ver_src_id_ldate_bm         ;
				INTEGER _ver_src_id_bn_pos               ;
				BOOLEAN _ver_src_id__bn                  ;
				string _ver_src_id_fdate_bn             ;
				INTEGER _ver_src_id_fdate_bn2            ;
				INTEGER yr__ver_src_id_fdate_bn          ;
				INTEGER mth__ver_src_id_fdate_bn         ;
				string _ver_src_id_ldate_bn             ;
				INTEGER _ver_src_id_ldate_bn2            ;
				INTEGER yr__ver_src_id_ldate_bn          ;
				INTEGER mth__ver_src_id_ldate_bn         ;
				INTEGER _ver_src_id_cu_pos               ;
				BOOLEAN _ver_src_id__cu                  ;
				string _ver_src_id_fdate_cu             ;
				INTEGER _ver_src_id_fdate_cu2            ;
				INTEGER yr__ver_src_id_fdate_cu          ;
				INTEGER mth__ver_src_id_fdate_cu         ;
				string _ver_src_id_ldate_cu             ;
				INTEGER _ver_src_id_ldate_cu2            ;
				INTEGER yr__ver_src_id_ldate_cu          ;
				INTEGER mth__ver_src_id_ldate_cu         ;
				INTEGER _ver_src_id_da_pos               ;
				BOOLEAN _ver_src_id__da                  ;
				string _ver_src_id_fdate_da             ;
				INTEGER _ver_src_id_fdate_da2            ;
				INTEGER yr__ver_src_id_fdate_da          ;
				INTEGER mth__ver_src_id_fdate_da         ;
				string _ver_src_id_ldate_da             ;
				INTEGER _ver_src_id_ldate_da2            ;
				INTEGER yr__ver_src_id_ldate_da          ;
				INTEGER mth__ver_src_id_ldate_da         ;
				INTEGER _ver_src_id_ef_pos               ;
				BOOLEAN _ver_src_id__ef                  ;
				string _ver_src_id_fdate_ef             ;
				INTEGER _ver_src_id_fdate_ef2            ;
				INTEGER yr__ver_src_id_fdate_ef          ;
				INTEGER mth__ver_src_id_fdate_ef         ;
				string _ver_src_id_ldate_ef             ;
				INTEGER _ver_src_id_ldate_ef2            ;
				INTEGER yr__ver_src_id_ldate_ef          ;
				INTEGER mth__ver_src_id_ldate_ef         ;
				INTEGER _ver_src_id_fi_pos               ;
				BOOLEAN _ver_src_id__fi                  ;
				string _ver_src_id_fdate_fi             ;
				INTEGER _ver_src_id_fdate_fi2            ;
				INTEGER yr__ver_src_id_fdate_fi          ;
				INTEGER mth__ver_src_id_fdate_fi         ;
				string _ver_src_id_ldate_fi             ;
				INTEGER _ver_src_id_ldate_fi2            ;
				INTEGER yr__ver_src_id_ldate_fi          ;
				INTEGER mth__ver_src_id_ldate_fi         ;
				INTEGER _ver_src_id_i_pos                ;
				BOOLEAN _ver_src_id__i                   ;
				string _ver_src_id_fdate_i              ;
				INTEGER _ver_src_id_fdate_i2             ;
				INTEGER yr__ver_src_id_fdate_i           ;
				INTEGER mth__ver_src_id_fdate_i          ;
				string _ver_src_id_ldate_i              ;
				INTEGER _ver_src_id_ldate_i2             ;
				INTEGER yr__ver_src_id_ldate_i           ;
				INTEGER mth__ver_src_id_ldate_i          ;
				INTEGER _ver_src_id_ia_pos               ;
				BOOLEAN _ver_src_id__ia                  ;
				string _ver_src_id_fdate_ia             ;
				INTEGER _ver_src_id_fdate_ia2            ;
				INTEGER yr__ver_src_id_fdate_ia          ;
				INTEGER mth__ver_src_id_fdate_ia         ;
				string _ver_src_id_ldate_ia             ;
				INTEGER _ver_src_id_ldate_ia2            ;
				INTEGER yr__ver_src_id_ldate_ia          ;
				INTEGER mth__ver_src_id_ldate_ia         ;
			INTEGER _ver_src_id_in_pos               ;
			BOOLEAN _ver_src_id__in                  ;
			string _ver_src_id_fdate_in             ;
			INTEGER _ver_src_id_fdate_in2            ;
			INTEGER yr__ver_src_id_fdate_in          ;
			INTEGER mth__ver_src_id_fdate_in         ;
			string _ver_src_id_ldate_in             ;
			INTEGER _ver_src_id_ldate_in2            ;
			INTEGER yr__ver_src_id_ldate_in          ;
			INTEGER mth__ver_src_id_ldate_in         ;
			INTEGER _ver_src_id_os_pos               ;
			BOOLEAN _ver_src_id__os                  ;
			string _ver_src_id_fdate_os             ;
			INTEGER _ver_src_id_fdate_os2            ;
			INTEGER yr__ver_src_id_fdate_os          ;
			INTEGER mth__ver_src_id_fdate_os         ;
			string _ver_src_id_ldate_os             ;
			INTEGER _ver_src_id_ldate_os2            ;
			INTEGER yr__ver_src_id_ldate_os          ;
			INTEGER mth__ver_src_id_ldate_os         ;
			INTEGER _ver_src_id_p_pos                ;
			BOOLEAN _ver_src_id__p                   ;
			string _ver_src_id_fdate_p              ;
			INTEGER _ver_src_id_fdate_p2             ;
			Real yr__ver_src_id_fdate_p           ;
			INTEGER mth__ver_src_id_fdate_p          ;
			string _ver_src_id_ldate_p              ;
			INTEGER _ver_src_id_ldate_p2             ;
			INTEGER yr__ver_src_id_ldate_p           ;
			INTEGER mth__ver_src_id_ldate_p          ;
			INTEGER _ver_src_id_pl_pos               ;
			BOOLEAN _ver_src_id__pl                  ;
			string _ver_src_id_fdate_pl             ;
			INTEGER _ver_src_id_fdate_pl2            ;
			INTEGER yr__ver_src_id_fdate_pl          ;
			INTEGER mth__ver_src_id_fdate_pl         ;
			string _ver_src_id_ldate_pl             ;
			INTEGER _ver_src_id_ldate_pl2            ;
			Real yr__ver_src_id_ldate_pl          ;
			INTEGER mth__ver_src_id_ldate_pl         ;
			INTEGER _ver_src_id_q3_pos               ;
			BOOLEAN _ver_src_id__q3                  ;
			string _ver_src_id_fdate_q3             ;
			INTEGER _ver_src_id_fdate_q32            ;
			INTEGER yr__ver_src_id_fdate_q3          ;
			INTEGER mth__ver_src_id_fdate_q3         ;
			string _ver_src_id_ldate_q3             ;
			INTEGER _ver_src_id_ldate_q32            ;
			Real yr__ver_src_id_ldate_q3          ;
			INTEGER mth__ver_src_id_ldate_q3         ;
			INTEGER _ver_src_id_sk_pos               ;
			BOOLEAN _ver_src_id__sk                  ;
			string _ver_src_id_fdate_sk             ;
			INTEGER _ver_src_id_fdate_sk2            ;
			INTEGER yr__ver_src_id_fdate_sk          ;
			INTEGER mth__ver_src_id_fdate_sk         ;
			string _ver_src_id_ldate_sk             ;
			INTEGER _ver_src_id_ldate_sk2            ;
			INTEGER yr__ver_src_id_ldate_sk          ;
			INTEGER mth__ver_src_id_ldate_sk         ;
			INTEGER _ver_src_id_tx_pos               ;
			BOOLEAN _ver_src_id__tx                  ;
			string _ver_src_id_fdate_tx             ;
			INTEGER _ver_src_id_fdate_tx2            ;
			INTEGER yr__ver_src_id_fdate_tx          ;
			INTEGER mth__ver_src_id_fdate_tx         ;
			string _ver_src_id_ldate_tx             ;
			INTEGER _ver_src_id_ldate_tx2            ;
			INTEGER yr__ver_src_id_ldate_tx          ;
			INTEGER mth__ver_src_id_ldate_tx         ;
			INTEGER _ver_src_id_v2_pos               ;
			BOOLEAN _ver_src_id__v2                  ;
			INTEGER _ver_src_id_fdate_v22            ;
			INTEGER yr__ver_src_id_fdate_v2          ;
			INTEGER mth__ver_src_id_fdate_v2         ;
			INTEGER _ver_src_id_ldate_v22            ;
			INTEGER yr__ver_src_id_ldate_v2          ;
			INTEGER mth__ver_src_id_ldate_v2         ;
			INTEGER _ver_src_id_wa_pos               ;
			BOOLEAN _ver_src_id__wa                  ;
			string _ver_src_id_fdate_wa             ;
			INTEGER _ver_src_id_fdate_wa2            ;
			INTEGER yr__ver_src_id_fdate_wa          ;
			INTEGER mth__ver_src_id_fdate_wa         ;
			string _ver_src_id_ldate_wa             ;
			INTEGER _ver_src_id_ldate_wa2            ;
			INTEGER yr__ver_src_id_ldate_wa          ;
			INTEGER mth__ver_src_id_ldate_wa         ;
			INTEGER _ver_src_id_by_pos               ;
			Boolean _ver_src_id__by                  ;
			string _ver_src_id_fdate_by             ;
			INTEGER _ver_src_id_fdate_by2            ;
			INTEGER yr__ver_src_id_fdate_by          ;
			INTEGER mth__ver_src_id_fdate_by         ;
			string _ver_src_id_ldate_by             ;
			INTEGER _ver_src_id_ldate_by2            ;
			INTEGER yr__ver_src_id_ldate_by          ;
			INTEGER mth__ver_src_id_ldate_by         ;
			INTEGER _ver_src_id_cf_pos               ;
			BOOLEAN _ver_src_id__cf                  ;
			string _ver_src_id_fdate_cf             ;
			INTEGER _ver_src_id_fdate_cf2            ;
			INTEGER yr__ver_src_id_fdate_cf          ;
			INTEGER mth__ver_src_id_fdate_cf         ;
			string _ver_src_id_ldate_cf             ;
			Integer _ver_src_id_ldate_cf2            ;
			INTEGER yr__ver_src_id_ldate_cf          ;
			INTEGER mth__ver_src_id_ldate_cf         ;
			INTEGER _ver_src_id_e_pos                ;
			BOOLEAN _ver_src_id__e                   ;
			string _ver_src_id_fdate_e              ;
			INTEGER _ver_src_id_fdate_e2             ;
			INTEGER yr__ver_src_id_fdate_e           ;
			INTEGER mth__ver_src_id_fdate_e          ;
			string _ver_src_id_ldate_e              ;
			INTEGER _ver_src_id_ldate_e2             ;
			INTEGER yr__ver_src_id_ldate_e           ;
			INTEGER mth__ver_src_id_ldate_e          ;
			INTEGER _ver_src_id_ey_pos               ;
			BOOLEAN _ver_src_id__ey                  ;
			string _ver_src_id_fdate_ey             ;
			INTEGER _ver_src_id_fdate_ey2            ;
			INTEGER yr__ver_src_id_fdate_ey          ;
			INTEGER mth__ver_src_id_fdate_ey         ;
			string _ver_src_id_ldate_ey             ;
			INTEGER _ver_src_id_ldate_ey2            ;
			INTEGER yr__ver_src_id_ldate_ey          ;
			INTEGER mth__ver_src_id_ldate_ey         ;
			INTEGER _ver_src_id_f_pos                ;
			BOOLEAN _ver_src_id__f                   ;
			string _ver_src_id_fdate_f              ;
			INTEGER _ver_src_id_fdate_f2             ;
			INTEGER yr__ver_src_id_fdate_f           ;
			INTEGER mth__ver_src_id_fdate_f          ;
			string _ver_src_id_ldate_f              ;
			INTEGER _ver_src_id_ldate_f2             ;
			Real yr__ver_src_id_ldate_f           ;
			INTEGER mth__ver_src_id_ldate_f          ;
			INTEGER _ver_src_id_fk_pos               ;
			BOOLEAN _ver_src_id__fk                  ;
			string _ver_src_id_fdate_fk             ;
			INTEGER _ver_src_id_fdate_fk2            ;
			INTEGER yr__ver_src_id_fdate_fk          ;
			INTEGER mth__ver_src_id_fdate_fk         ;
			string _ver_src_id_ldate_fk             ;
			INTEGER _ver_src_id_ldate_fk2            ;
			INTEGER yr__ver_src_id_ldate_fk          ;
			INTEGER mth__ver_src_id_ldate_fk         ;
			INTEGER _ver_src_id_fr_pos               ;
			BOOLEAN _ver_src_id__fr                  ;
			string _ver_src_id_fdate_fr             ;
			INTEGER _ver_src_id_fdate_fr2            ;
			INTEGER yr__ver_src_id_fdate_fr          ;
			INTEGER mth__ver_src_id_fdate_fr         ;
			string _ver_src_id_ldate_fr             ;
			INTEGER _ver_src_id_ldate_fr2            ;
			INTEGER yr__ver_src_id_ldate_fr          ;
			INTEGER mth__ver_src_id_ldate_fr         ;
			INTEGER _ver_src_id_ft_pos               ;
			BOOLEAN _ver_src_id__ft                  ;
			string _ver_src_id_fdate_ft             ;
			INTEGER _ver_src_id_fdate_ft2            ;
			INTEGER yr__ver_src_id_fdate_ft          ;
			INTEGER mth__ver_src_id_fdate_ft         ;
			string _ver_src_id_ldate_ft             ;
			INTEGER _ver_src_id_ldate_ft2            ;
			INTEGER yr__ver_src_id_ldate_ft          ;
			INTEGER mth__ver_src_id_ldate_ft         ;
			INTEGER _ver_src_id_gr_pos               ;
			BOOLEAN _ver_src_id__gr                  ;
			string _ver_src_id_fdate_gr             ;
			INTEGER _ver_src_id_fdate_gr2            ;
			INTEGER yr__ver_src_id_fdate_gr          ;
			INTEGER mth__ver_src_id_fdate_gr         ;
			string _ver_src_id_ldate_gr             ;
			INTEGER _ver_src_id_ldate_gr2            ;
			INTEGER yr__ver_src_id_ldate_gr          ;
			INTEGER mth__ver_src_id_ldate_gr         ;
			INTEGER _ver_src_id_h7_pos               ;
			BOOLEAN _ver_src_id__h7                  ;
			string _ver_src_id_fdate_h7             ;
			INTEGER _ver_src_id_fdate_h72            ;
			INTEGER yr__ver_src_id_fdate_h7          ;
			INTEGER mth__ver_src_id_fdate_h7         ;
			string _ver_src_id_ldate_h7             ;
			INTEGER _ver_src_id_ldate_h72            ;
			INTEGER yr__ver_src_id_ldate_h7          ;
			INTEGER mth__ver_src_id_ldate_h7         ;
			INTEGER _ver_src_id_ic_pos               ;
			BOOLEAN _ver_src_id__ic                  ;
			string _ver_src_id_fdate_ic             ;
			INTEGER _ver_src_id_fdate_ic2            ;
			INTEGER yr__ver_src_id_fdate_ic          ;
			INTEGER mth__ver_src_id_fdate_ic         ;
			string _ver_src_id_ldate_ic             ;
			INTEGER _ver_src_id_ldate_ic2            ;
			INTEGER yr__ver_src_id_ldate_ic          ;
			INTEGER mth__ver_src_id_ldate_ic         ;
			INTEGER _ver_src_id_ip_pos               ;
			Boolean _ver_src_id__ip                  ;
			string _ver_src_id_fdate_ip             ;
			INTEGER _ver_src_id_fdate_ip2            ;
			INTEGER yr__ver_src_id_fdate_ip          ;
			INTEGER mth__ver_src_id_fdate_ip         ;
			string _ver_src_id_ldate_ip             ;
			INTEGER _ver_src_id_ldate_ip2            ;
			INTEGER yr__ver_src_id_ldate_ip          ;
			INTEGER mth__ver_src_id_ldate_ip         ;
			INTEGER _ver_src_id_is_pos               ;
			BOOLEAN _ver_src_id__is                  ;
			string _ver_src_id_fdate_is             ;
			INTEGER _ver_src_id_fdate_is2            ;
			INTEGER yr__ver_src_id_fdate_is          ;
			INTEGER mth__ver_src_id_fdate_is         ;
			string _ver_src_id_ldate_is             ;
			INTEGER _ver_src_id_ldate_is2            ;
			INTEGER yr__ver_src_id_ldate_is          ;
			INTEGER mth__ver_src_id_ldate_is         ;
			INTEGER _ver_src_id_it_pos               ;
			BOOLEAN _ver_src_id__it                  ;
			string _ver_src_id_fdate_it             ;
			INTEGER _ver_src_id_fdate_it2            ;
			INTEGER yr__ver_src_id_fdate_it          ;
			INTEGER mth__ver_src_id_fdate_it         ;
			string _ver_src_id_ldate_it             ;
			INTEGER _ver_src_id_ldate_it2            ;
			Real yr__ver_src_id_ldate_it          ;
			INTEGER mth__ver_src_id_ldate_it         ;
			INTEGER _ver_src_id_j2_pos               ;
			BOOLEAN _ver_src_id__j2                  ;
			string _ver_src_id_fdate_j2             ;
			INTEGER _ver_src_id_fdate_j22            ;
			INTEGER yr__ver_src_id_fdate_j2          ;
			INTEGER mth__ver_src_id_fdate_j2         ;
			string _ver_src_id_ldate_j2             ;
			INTEGER _ver_src_id_ldate_j22            ;
			INTEGER yr__ver_src_id_ldate_j2          ;
			INTEGER mth__ver_src_id_ldate_j2         ;
			INTEGER _ver_src_id_kc_pos               ;
			BOOLEAN _ver_src_id__kc                  ;
			string _ver_src_id_fdate_kc             ;
			INTEGER _ver_src_id_fdate_kc2            ;
			INTEGER yr__ver_src_id_fdate_kc          ;
			INTEGER mth__ver_src_id_fdate_kc         ;
			string _ver_src_id_ldate_kc             ;
			INTEGER _ver_src_id_ldate_kc2            ;
			INTEGER yr__ver_src_id_ldate_kc          ;
			INTEGER mth__ver_src_id_ldate_kc         ;
			INTEGER _ver_src_id_mh_pos               ;
			BOOLEAN _ver_src_id__mh                  ;
			string _ver_src_id_fdate_mh             ;
			INTEGER _ver_src_id_fdate_mh2            ;
			INTEGER yr__ver_src_id_fdate_mh          ;
			INTEGER mth__ver_src_id_fdate_mh         ;
			string _ver_src_id_ldate_mh             ;
			INTEGER _ver_src_id_ldate_mh2            ;
			INTEGER yr__ver_src_id_ldate_mh          ;
			INTEGER mth__ver_src_id_ldate_mh         ;
			INTEGER _ver_src_id_mw_pos               ;
			BOOLEAN _ver_src_id__mw                  ;
			string _ver_src_id_fdate_mw             ;
			Integer _ver_src_id_fdate_mw2            ;
			Real yr__ver_src_id_fdate_mw          ;
			INTEGER mth__ver_src_id_fdate_mw         ;
			string _ver_src_id_ldate_mw             ;
			Integer _ver_src_id_ldate_mw2            ;
			INTEGER yr__ver_src_id_ldate_mw          ;
			INTEGER mth__ver_src_id_ldate_mw         ;
			INTEGER _ver_src_id_np_pos               ;
			BOOLEAN _ver_src_id__np                  ;
			string _ver_src_id_fdate_np             ;
			INTEGER _ver_src_id_fdate_np2            ;
			INTEGER yr__ver_src_id_fdate_np          ;
			INTEGER mth__ver_src_id_fdate_np         ;
			string _ver_src_id_ldate_np             ;
			INTEGER _ver_src_id_ldate_np2            ;
			INTEGER yr__ver_src_id_ldate_np          ;
			INTEGER mth__ver_src_id_ldate_np         ;
			INTEGER _ver_src_id_nr_pos               ;
			BOOLEAN _ver_src_id__nr                  ;
			string _ver_src_id_fdate_nr             ;
			INTEGER _ver_src_id_fdate_nr2            ;
			INTEGER yr__ver_src_id_fdate_nr          ;
			INTEGER mth__ver_src_id_fdate_nr         ;
			string _ver_src_id_ldate_nr             ;
			INTEGER _ver_src_id_ldate_nr2            ;
			INTEGER yr__ver_src_id_ldate_nr          ;
			INTEGER mth__ver_src_id_ldate_nr         ;
			INTEGER _ver_src_id_sa_pos               ;
			BOOLEAN _ver_src_id__sa                  ;
			string _ver_src_id_fdate_sa             ;
			INTEGER _ver_src_id_fdate_sa2            ;
			INTEGER yr__ver_src_id_fdate_sa          ;
			INTEGER mth__ver_src_id_fdate_sa         ;
			string _ver_src_id_ldate_sa             ;
			INTEGER _ver_src_id_ldate_sa2            ;
			INTEGER yr__ver_src_id_ldate_sa          ;
			INTEGER mth__ver_src_id_ldate_sa         ;
			INTEGER _ver_src_id_sb_pos               ;
			BOOLEAN _ver_src_id__sb                  ;
			string _ver_src_id_fdate_sb             ;
			INTEGER _ver_src_id_fdate_sb2            ;
			INTEGER yr__ver_src_id_fdate_sb          ;
			INTEGER mth__ver_src_id_fdate_sb         ;
			string _ver_src_id_ldate_sb             ;
			INTEGER _ver_src_id_ldate_sb2            ;
			INTEGER yr__ver_src_id_ldate_sb          ;
			INTEGER mth__ver_src_id_ldate_sb         ;
			INTEGER _ver_src_id_sg_pos               ;
			BOOLEAN _ver_src_id__sg                  ;
			string _ver_src_id_fdate_sg             ;
			INTEGER _ver_src_id_fdate_sg2            ;
			Real yr__ver_src_id_fdate_sg          ;
			INTEGER mth__ver_src_id_fdate_sg         ;
			string _ver_src_id_ldate_sg             ;
			INTEGER _ver_src_id_ldate_sg2            ;
			INTEGER yr__ver_src_id_ldate_sg          ;
			INTEGER mth__ver_src_id_ldate_sg         ;
			INTEGER _ver_src_id_sj_pos               ;
			BOOLEAN _ver_src_id__sj                  ;
			string _ver_src_id_fdate_sj             ;
			INTEGER _ver_src_id_fdate_sj2            ;
			INTEGER yr__ver_src_id_fdate_sj          ;
			INTEGER mth__ver_src_id_fdate_sj         ;
			string _ver_src_id_ldate_sj             ;
			INTEGER _ver_src_id_ldate_sj2            ;
			INTEGER yr__ver_src_id_ldate_sj          ;
			INTEGER mth__ver_src_id_ldate_sj         ;
			INTEGER _ver_src_id_sp_pos               ;
			BOOLEAN _ver_src_id__sp                  ;
			string _ver_src_id_fdate_sp             ;
			INTEGER _ver_src_id_fdate_sp2            ;
			INTEGER yr__ver_src_id_fdate_sp          ;
			INTEGER mth__ver_src_id_fdate_sp         ;
			string _ver_src_id_ldate_sp             ;
			INTEGER _ver_src_id_ldate_sp2            ;
			INTEGER yr__ver_src_id_ldate_sp          ;
			INTEGER mth__ver_src_id_ldate_sp         ;
			INTEGER _ver_src_id_ut_pos               ;
			BOOLEAN _ver_src_id__ut                  ;
			string _ver_src_id_fdate_ut             ;
			INTEGER _ver_src_id_fdate_ut2            ;
			INTEGER yr__ver_src_id_fdate_ut          ;
			INTEGER mth__ver_src_id_fdate_ut         ;
			string _ver_src_id_ldate_ut             ;
			INTEGER _ver_src_id_ldate_ut2            ;
			INTEGER yr__ver_src_id_ldate_ut          ;
			INTEGER mth__ver_src_id_ldate_ut         ;
			INTEGER _ver_src_id_v_pos                ;
			BOOLEAN _ver_src_id__v                   ;
			string _ver_src_id_fdate_v              ;
			INTEGER _ver_src_id_fdate_v2             ;
			INTEGER yr__ver_src_id_fdate_v           ;
			INTEGER mth__ver_src_id_fdate_v          ;
			string _ver_src_id_ldate_v              ;
			INTEGER _ver_src_id_ldate_v2             ;
			INTEGER yr__ver_src_id_ldate_v           ;
			INTEGER mth__ver_src_id_ldate_v          ;
			INTEGER _ver_src_id_wb_pos               ;
			BOOLEAN _ver_src_id__wb                  ;
			string _ver_src_id_fdate_wb             ;
			INTEGER _ver_src_id_fdate_wb2            ;
			INTEGER yr__ver_src_id_fdate_wb          ;
			INTEGER mth__ver_src_id_fdate_wb         ;
			string _ver_src_id_ldate_wb             ;
			INTEGER _ver_src_id_ldate_wb2            ;
			INTEGER yr__ver_src_id_ldate_wb          ;
			INTEGER mth__ver_src_id_ldate_wb         ;
			INTEGER _ver_src_id_wc_pos               ;
			BOOLEAN _ver_src_id__wc                  ;
			string _ver_src_id_fdate_wc             ;
			INTEGER _ver_src_id_fdate_wc2            ;
			INTEGER yr__ver_src_id_fdate_wc          ;
			INTEGER mth__ver_src_id_fdate_wc         ;
			string _ver_src_id_ldate_wc             ;
			INTEGER _ver_src_id_ldate_wc2            ;
			INTEGER yr__ver_src_id_ldate_wc          ;
			INTEGER mth__ver_src_id_ldate_wc         ;
			INTEGER _ver_src_id_wk_pos               ;
			BOOLEAN _ver_src_id__wk                  ;
			string _ver_src_id_fdate_wk             ;
			INTEGER _ver_src_id_fdate_wk2            ;
			INTEGER yr__ver_src_id_fdate_wk          ;
			INTEGER mth__ver_src_id_fdate_wk         ;
			string _ver_src_id_ldate_wk             ;
			INTEGER _ver_src_id_ldate_wk2            ;
			INTEGER yr__ver_src_id_ldate_wk          ;
			INTEGER mth__ver_src_id_ldate_wk         ;
			INTEGER _ver_src_id_wx_pos               ;
			BOOLEAN _ver_src_id__wx                  ;
			string _ver_src_id_fdate_wx             ;
			INTEGER _ver_src_id_fdate_wx2            ;
			INTEGER yr__ver_src_id_fdate_wx          ;
			INTEGER mth__ver_src_id_fdate_wx         ;
			string _ver_src_id_ldate_wx             ;
			INTEGER _ver_src_id_ldate_wx2            ;
			INTEGER yr__ver_src_id_ldate_wx          ;
			INTEGER mth__ver_src_id_ldate_wx         ;
			INTEGER _ver_src_id_zo_pos               ;
			BOOLEAN _ver_src_id__zo                  ;
			string _ver_src_id_fdate_zo             ;
			INTEGER _ver_src_id_fdate_zo2            ;
			INTEGER yr__ver_src_id_fdate_zo          ;
			INTEGER mth__ver_src_id_fdate_zo         ;
			string _ver_src_id_ldate_zo             ;
			INTEGER _ver_src_id_ldate_zo2            ;
			INTEGER yr__ver_src_id_ldate_zo          ;
			INTEGER mth__ver_src_id_ldate_zo         ;
			INTEGER _ver_src_id_y_pos                ;
			BOOLEAN _ver_src_id__y                   ;
			string _ver_src_id_fdate_y              ;
			INTEGER _ver_src_id_fdate_y2             ;
			INTEGER yr__ver_src_id_fdate_y           ;
			INTEGER mth__ver_src_id_fdate_y          ;
			string _ver_src_id_ldate_y              ;
			INTEGER _ver_src_id_ldate_y2             ;
			INTEGER yr__ver_src_id_ldate_y           ;
			INTEGER mth__ver_src_id_ldate_y          ;
			INTEGER _ver_src_id_gb_pos               ;
			BOOLEAN _ver_src_id__gb                  ;
			string _ver_src_id_fdate_gb             ;
			INTEGER _ver_src_id_fdate_gb2            ;
			INTEGER yr__ver_src_id_fdate_gb          ;
			INTEGER mth__ver_src_id_fdate_gb         ;
			string _ver_src_id_ldate_gb             ;
			INTEGER _ver_src_id_ldate_gb2            ;
			INTEGER yr__ver_src_id_ldate_gb          ;
			INTEGER mth__ver_src_id_ldate_gb         ;
			INTEGER _ver_src_id_cs_pos               ;
			BOOLEAN _ver_src_id__cs                  ;
			string _ver_src_id_ldate_cs             ;
			INTEGER _ver_src_id_ldate_cs2            ;
			INTEGER yr__ver_src_id_ldate_cs          ;
			INTEGER mth__ver_src_id_ldate_cs         ;
			//
			string _ver_src_id_fdate_cs             ;
			Integer _ver_src_id_fdate_cs2            ;
			Real yr__ver_src_id_fdate_cs          ;
			INTEGER mth__ver_src_id_fdate_cs         ;
			BOOLEAN vs_ver_src_id__gb                ;
			Real vs_gb_id_mth_fseen               ;
			Real vs_gb_id_mth_lseen               ;
			BOOLEAN vs_ver_src_id__y                 ;
			Real vs_y_id_mth_fseen                ;
			Real vs_y_id_mth_lseen                ;
			INTEGER vs_ver_src_id__ut                ;
			Real vs_ut_id_mth_fseen               ;
			Real vs_ut_id_mth_lseen               ;
			Boolean vs_ver_src_id__os                ;
			Real vs_os_id_mth_fseen               ;
			Real vs_os_id_mth_lseen               ;
			INTEGER vs_ver_src_id__bm                ;
			Real vs_bm_id_mth_fseen               ;
			Real vs_bm_id_mth_lseen               ;
			INTEGER vs_ver_src_id__i                 ;
			Real vs_i_id_mth_fseen                ;
			Real vs_i_id_mth_lseen                ;
			Boolean vs_ver_src_id__in                ;
			Real vs_in_id_mth_fseen               ;
			Real vs_in_id_mth_lseen               ;
			Boolean vs_ver_src_id__l0                ;
			Real vs_l0_id_mth_fseen               ;
			Real vs_l0_id_mth_lseen               ;
			Boolean vs_ver_src_id__wa                ;
			Real vs_wa_id_mth_fseen               ;
			Real vs_wa_id_mth_lseen               ;
			Boolean vs_ver_src_id__ar                ;
			Real vs_ar_id_mth_fseen               ;
			Real vs_ar_id_mth_lseen               ;
			Boolean vs_ver_src_id__v2                ;
			Real vs_v2_id_mth_fseen               ;
			Real vs_v2_id_mth_lseen               ;
			INTEGER vs_adl_util_i                    ;
			INTEGER vs_util_adl_count                ;
			INTEGER _util_adl_first_seen             ;
			real vs_util_adl_mths_fs              ;
			INTEGER _gong_did_first_seen             ;
			INTEGER _gong_did_last_seen              ;
			REAL vs_gong_adl_mths_ls              ;
			INTEGER _header_first_seen               ;
			REAL vs_header_mths_fs                ;
			INTEGER _header_last_seen                ;
			REAL vs_br_mths_fs                    ;
			INTEGER vs_br_business_count             ;
			INTEGER vs_br_dead_business_count        ;
			INTEGER vs_br_active_phone_count         ;
			INTEGER vs_email_count                   ;
			INTEGER vs_email_domain_free_count       ;
			INTEGER vs_email_domain_edu_count        ;
			INTEGER vs_historical_count              ;
			INTEGER vs_college_tier                  ;
			INTEGER vs_prof_license_flag             ;
			INTEGER _prof_license_ix_sanct_fs        ;
			INTEGER _prof_license_ix_sanct_ls        ;
			string ver_src_cons_fsrc_fdate          ;
			INTEGER ver_src_cons_fsrc_fdate2         ;
			Real yr_ver_src_cons_fsrc_fdate       ;
			INTEGER mth_ver_src_cons_fsrc_fdate      ;
			INTEGER ver_src_cons_vo_pos              ;
			BOOLEAN ver_src_cons__vo                 ;
			string ver_src_cons_fdate_vo            ;
			INTEGER ver_src_cons_fdate_vo2           ;
			Real yr_ver_src_cons_fdate_vo         ;
			INTEGER mth_ver_src_cons_fdate_vo        ;
			string ver_src_cons_ldate_vo            ;
			INTEGER ver_src_cons_ldate_vo2           ;
			Real yr_ver_src_cons_ldate_vo         ;
			INTEGER mth_ver_src_cons_ldate_vo        ;
			INTEGER ver_src_cons_wp_pos              ;
			BOOLEAN ver_src_cons__wp                 ;
			string ver_src_cons_fdate_wp            ;
			INTEGER ver_src_cons_fdate_wp2           ;
			Real yr_ver_src_cons_fdate_wp         ;
			INTEGER mth_ver_src_cons_fdate_wp        ;
			string ver_src_cons_ldate_wp            ;
			INTEGER ver_src_cons_ldate_wp2           ;
			Real yr_ver_src_cons_ldate_wp         ;
			INTEGER mth_ver_src_cons_ldate_wp        ;
			INTEGER ver_src_cons_am_pos              ;
			Boolean ver_src_cons__am                 ;
			string ver_src_cons_fdate_am            ;
			INTEGER ver_src_cons_fdate_am2           ;
			Real yr_ver_src_cons_fdate_am         ;
			INTEGER mth_ver_src_cons_fdate_am        ;
			string ver_src_cons_ldate_am            ;
			INTEGER ver_src_cons_ldate_am2           ;
			Real yr_ver_src_cons_ldate_am         ;
			INTEGER mth_ver_src_cons_ldate_am        ;
			INTEGER ver_src_cons_e1_pos              ;
			Boolean ver_src_cons__e1                 ;
			string ver_src_cons_fdate_e1            ;
			INTEGER ver_src_cons_fdate_e12           ;
			Real yr_ver_src_cons_fdate_e1         ;
			INTEGER mth_ver_src_cons_fdate_e1        ;
			string ver_src_cons_ldate_e1            ;
			INTEGER ver_src_cons_ldate_e12           ;
			Real yr_ver_src_cons_ldate_e1         ;
			INTEGER mth_ver_src_cons_ldate_e1        ;
			INTEGER ver_src_cons_e2_pos              ;
			Boolean ver_src_cons__e2                 ;
			string ver_src_cons_fdate_e2            ;
			INTEGER ver_src_cons_fdate_e22           ;
			Real yr_ver_src_cons_fdate_e2         ;
			INTEGER mth_ver_src_cons_fdate_e2        ;
			string ver_src_cons_ldate_e2            ;
			INTEGER ver_src_cons_ldate_e22           ;
			Real yr_ver_src_cons_ldate_e2         ;
			INTEGER mth_ver_src_cons_ldate_e2        ;
			INTEGER ver_src_cons_e3_pos              ;
			Boolean ver_src_cons__e3                 ;
			string ver_src_cons_fdate_e3            ;
			INTEGER ver_src_cons_fdate_e32           ;
			Real yr_ver_src_cons_fdate_e3         ;
			INTEGER mth_ver_src_cons_fdate_e3        ;
			string ver_src_cons_ldate_e3            ;
			INTEGER ver_src_cons_ldate_e32           ;
			Real yr_ver_src_cons_ldate_e3         ;
			INTEGER mth_ver_src_cons_ldate_e3        ;
			Integer _ver_src_cons_fdate_vo           ;
			Integer _ver_src_cons_ldate_vo           ;
			Real vs_ver_src_cons_vo_mths_ls       ;
			Integer vs_ver_sources_wp_pop            ;
			Integer _ver_src_cons_fdate_wp           ;
			Integer _ver_src_cons_ldate_wp           ;
			Integer vs_ver_sources_am_pop            ;
			Integer _ver_src_cons_fdate_am           ;
			Integer _ver_src_cons_ldate_am           ;
			Integer vs_ver_sources_e1_pop            ;
			Integer _ver_src_cons_fdate_e1           ;
			Real vs_ver_src_cons_e1_mths_fs       ;
			Integer _ver_src_cons_ldate_e1           ;
			Real vs_ver_src_cons_e1_mths_ls       ;
			Integer _ver_src_cons_fdate_e2           ;
			Real vs_ver_src_cons_e2_mths_fs       ;
			Integer _ver_src_cons_ldate_e2           ;
			Real vs_ver_src_cons_e2_mths_ls       ;
			Integer _ver_src_cons_fdate_e3           ;
			Real vs_ver_src_cons_e3_mths_fs       ;
			Integer _ver_src_cons_ldate_e3           ;
			Real vs_ver_src_cons_e3_mths_ls       ;
			Real c_vs_gb_id_mth_fseen_w           ;
			REAL c_vs_gb_id_mth_lseen_w           ;
			REAL c_vs_ver_src_id__bm_w            ;
			REAL c_vs_ver_src_id__in_w            ;
			REAL c_vs_util_adl_count_w            ;
			REAL c_vs_util_adl_mths_fs_w          ;
			REAL c_vs_gong_adl_mths_ls_w          ;
			REAL c_vs_header_mths_fs_w            ;
			REAL c_vs_pb_mths_fs_w                ;
			REAL c_vs_pb_mths_ls_w                ;
			REAL c_vs_pb_number_of_sources_w      ;
			REAL c_vs_br_mths_fs_w                ;
			REAL c_vs_br_dead_business_count_w    ;
			REAL c_vs_br_active_phone_count_w     ;
			REAL c_vs_email_count_w               ;
			REAL c_vs_email_domain_free_count_w   ;
			REAL c_vs_email_domain_edu_count_w    ;
			REAL c_vs_college_tier_w              ;
			REAL c_vs_prof_license_flag_w         ;
			REAL c_vs_ver_src_cons_vo_mths_ls_w   ;
			REAL c_vs_ver_sources_am_pop_w        ;
			Real bv_bus_rep_source_profile        ;
			REAL r_vs_adl_util_i_w                ;
			REAL r_vs_util_adl_count_w            ;
			REAL r_vs_util_adl_mths_fs_w          ;
			REAL r_vs_gong_adl_mths_ls_w          ;
			REAL r_vs_header_mths_fs_w            ;
			REAL r_vs_pb_mths_fs_w                ;
			REAL r_vs_pb_mths_ls_w                ;
			REAL r_vs_pb_number_of_sources_w      ;
			REAL r_vs_br_mths_fs_w                ;
			REAL r_vs_br_business_count_w         ;
			REAL r_vs_br_dead_business_count_w    ;
			REAL r_vs_br_active_phone_count_w     ;
			REAL r_vs_email_count_w               ;
			REAL r_vs_email_domain_free_count_w   ;
			REAL r_vs_email_domain_edu_count_w    ;
			REAL r_vs_historical_count_w          ;
			REAL r_vs_college_tier_w              ;
			REAL r_vs_prof_license_flag_w         ;
			REAL r_vs_ver_src_cons_vo_mths_ls_w   ;
			REAL r_vs_ver_sources_wp_pop_w        ;
			REAL r_vs_ver_sources_am_pop_w        ;
			REAL r_vs_ver_sources_e1_pop_w        ;
			Real bv_rep_only_source_profile       ;
			REAL b_vs_gb_id_mth_fseen_w           ;
			REAL b_vs_gb_id_mth_lseen_w           ;
			REAL b_vs_ver_src_id__ut_w            ;
			REAL b_vs_ver_src_id__bm_w            ;
			REAL b_vs_ver_src_id__i_w             ;
			REAL b_vs_v2_id_mth_fseen_w           ;
			REAL b_vs_v2_id_mth_lseen_w           ;
			Real bv_bus_only_source_profile       ;
			Boolean truebiz_ln                       ;
			integer iv_rv5_unscorable                ;
			Integer rv_a46_curr_avm_autoval          ;
			Integer rv_d30_derog_count               ;
			Integer bv_assoc_judg_tot                ;
			integer rv_i61_inq_collection_recency    ;
			INTEGER _inq_banko_cm_last_seen          ;
			INTEGER nf_mos_inq_banko_cm_lseen        ;
			INTEGER bx_addr_assessed_value           ;
			INTEGER bv_sos_current_standing          ;
			String mortgage_type                    ;
			boolean mortgage_present                 ;
			string iv_curr_add_mortgage_type        ;
			BOOLEAN source_ar                        ;
			BOOLEAN source_ba                        ;
			BOOLEAN source_bm                        ;
			BOOLEAN source_br                        ;
			BOOLEAN source_c                         ;
			BOOLEAN source_cs                        ;
			BOOLEAN source_da                        ;
			BOOLEAN source_df                        ;
			BOOLEAN source_dn                        ;
			BOOLEAN source_ef                        ;
			BOOLEAN source_er                        ;
			BOOLEAN source_fb                        ;
			BOOLEAN source_ft                        ;
			BOOLEAN source_gb                        ;
			BOOLEAN source_i                         ;
			BOOLEAN source_ia                        ;
			BOOLEAN source_ic                        ;
			BOOLEAN source_in                        ;
			BOOLEAN source_l0                        ;
			BOOLEAN source_l2                        ;
			BOOLEAN source_os                        ;
			BOOLEAN source_p                         ;
			BOOLEAN source_pp                        ;
			BOOLEAN source_q3                        ;
			BOOLEAN source_tx                        ;
			BOOLEAN source_u                         ;
			BOOLEAN source_ut                        ;
			BOOLEAN source_v2                        ;
			BOOLEAN source_wa                        ;
			BOOLEAN source_wk                        ;
			INTEGER num_pos_sources                  ;
			INTEGER num_neg_sources                  ;
			REAL bv_ver_src_derog_ratio           ;
			REAL bv_mth_ver_src_p_ls              ;
			Integer rv_d34_attr_liens_recency        ;
			real bv_lien_avg_amount               ;
			INTEGER bv_lien_total_amount             ;
			integer nf_fp_varrisktype                ;
			Integer bv_ver_src_id_mth_since_fs       ;
			integer nf_fp_srchunvrfdssncount         ;
			integer _judg_filed_firstseen            ;
			Integer bv_judg_filed_mth_fs             ;
			INTEGER rv_a41_prop_owner                ;
			Integer _sos_agent_change_lastseen       ;
			Integer bv_sos_mth_agent_change          ;
			Integer bv_assoc_lien_tot                ;
			Integer bx_addr_lres                     ;
			integer rv_d32_attr_felonies_recency     ;
			INTEGER rv_ever_asset_owner              ;
			integer rv_d34_attr_unrel_liens_recency  ;
			Integer rv_a44_curr_add_naprop           ;
			Integer bv_mth_bureau_fs                 ;
			Integer rv_i60_inq_auto_count12          ;
			Integer br_first_seen_char               ;
			Integer _br_first_seen                   ;
			Integer rv_mos_since_br_first_seen       ;
			INTEGER nf_fp_srchvelocityrisktype       ;
			Integer rv_d33_eviction_count            ;
			integer bv_lien_ft_count                 ;
			integer rv_d34_unrel_liens_ct            ;
			Real bv_assoc_derog_pct               ;
			Integer nf_fp_srchunvrfdphonecount       ;
			Integer rv_i60_inq_comm_recency          ;
			Integer nf_fp_srchfraudsrchcountyr       ;
			Integer bv_ver_src_id_activity12         ;
			integer bv_lien_ot_count                 ;
			Real bv_judg_avg_amount               ;
			Integer nf_fp_srchunvrfdaddrcount        ;
			integer nf_fp_sourcerisktype             ;
			Integer nf_fp_prevaddrageoldest          ;
			INTEGER rv_i60_inq_auto_recency          ;
			INTEGER rv_i61_inq_collection_count12    ;
			INTEGER rv_i60_inq_hiriskcred_recency    ;
			INTEGER rv_c14_addrs_per_adl_c6          ;
			INTEGER rv_c12_num_nonderogs             ;
			REAL s0_v01_w                         ;
			string s0_aa_code_01                    ;
			REAL s0_aa_dist_01                    ;
			REAL s0_v02_w                         ;
			string s0_aa_code_02                    ;
			REAL s0_aa_dist_02                    ;
			REAL s0_v03_w                         ;
			string s0_aa_code_03                    ;
			REAL s0_aa_dist_03                    ;
			REAL s0_v04_w                         ;
			string s0_aa_code_04                    ;
			REAL s0_aa_dist_04                    ;
			REAL s0_v05_w                         ;
			string s0_aa_code_05                    ;
			REAL s0_aa_dist_05                    ;
			REAL s0_v06_w                         ;
			string s0_aa_code_06                    ;
			REAL s0_aa_dist_06                    ;
			REAL s0_v07_w                         ;
			string s0_aa_code_07                    ;
			REAL s0_aa_dist_07                    ;
			REAL s0_v08_w                         ;
			string s0_aa_code_08                    ;
			REAL s0_aa_dist_08                    ;
			REAL s0_v09_w                         ;
			string s0_aa_code_09                    ;
			REAL s0_aa_dist_09                    ;
			REAL s0_v10_w                         ;
			string s0_aa_code_10                    ;
			REAL s0_aa_dist_10                    ;
			REAL s0_v11_w                         ;
			string s0_aa_code_11                    ;
			REAL s0_aa_dist_11                    ;
			REAL s0_v12_w                         ;
			string s0_aa_code_12                    ;
			REAL s0_aa_dist_12                    ;
			REAL s0_v13_w                         ;
			string s0_aa_code_13                    ;
			REAL s0_aa_dist_13                    ;
			REAL s0_v14_w                         ;
			string s0_aa_code_14                    ;
			REAL s0_aa_dist_14                    ;
			REAL s0_v15_w                         ;
			string s0_aa_code_15                    ;
			REAL s0_aa_dist_15                    ;
			REAL s0_v16_w                         ;
			string s0_aa_code_16                    ;
			REAL s0_aa_dist_16                    ;
			REAL s0_v17_w                         ;
			string s0_aa_code_17                    ;
			REAL s0_aa_dist_17                    ;
			REAL s0_v18_w                         ;
			string s0_aa_code_18                    ;
			REAL s0_aa_dist_18                    ;
			REAL s0_v19_w                         ;
			string s0_aa_code_19                    ;
			REAL s0_aa_dist_19                    ;
			REAL s0_v20_w                         ;
			string s0_aa_code_20                    ;
			REAL s0_aa_dist_20                    ;
			REAL s0_v21_w                         ;
			string s0_aa_code_21                    ;
			REAL s0_aa_dist_21                    ;
			REAL s0_v22_w                         ;
			string s0_aa_code_22                    ;
			REAL s0_aa_dist_22                    ;
			REAL s0_v23_w                         ;
			string s0_aa_code_23                    ;
			REAL s0_aa_dist_23                    ;
			REAL s0_v24_w                         ;
			string s0_aa_code_24                    ;
			REAL s0_aa_dist_24                    ;
			REAL s0_v25_w                         ;
			string s0_aa_code_25                    ;
			REAL s0_aa_dist_25                    ;
			REAL s0_v26_w                         ;
			string s0_aa_code_26                    ;
			REAL s0_aa_dist_26                    ;
			REAL s0_v27_w                         ;
			string s0_aa_code_27                    ;
			REAL s0_aa_dist_27                    ;
			REAL s0_v28_w                         ;
			string s0_aa_code_28                    ;
			REAL s0_aa_dist_28                    ;
			REAL s0_v29_w                         ;
			string s0_aa_code_29                    ;
			REAL s0_aa_dist_29                    ;
			REAL s0_v30_w                         ;
			string s0_aa_code_30                    ;
			REAL s0_aa_dist_30                    ;
			REAL s0_v31_w                         ;
			string s0_aa_code_31                    ;
			REAL s0_aa_dist_31                    ;
			REAL s0_v32_w                         ;
			string s0_aa_code_32                    ;
			REAL s0_aa_dist_32                    ;
			REAL s0_v33_w                         ;
			string s0_aa_code_33                    ;
			REAL s0_aa_dist_33                    ;
			REAL s0_v34_w                         ;
			string s0_aa_code_34                    ;
			REAL s0_aa_dist_34                    ;
			REAL s0_v35_w                         ;
			string s0_aa_code_35                    ;
			REAL s0_aa_dist_35                    ;
			REAL s0_v36_w                         ;
			string s0_aa_code_36                    ;
			REAL s0_aa_dist_36                    ;
			REAL s0_v37_w                         ;
			string s0_aa_code_37                    ;
			REAL s0_aa_dist_37                    ;
			REAL s0_v38_w                         ;
			string s0_aa_code_38                    ;
			REAL s0_aa_dist_38                    ;
			REAL s0_v39_w                         ;
			string s0_aa_code_39                    ;
			REAL s0_aa_dist_39                    ;
			REAL s0_v40_w                         ;
			string s0_aa_code_40                    ;
			REAL s0_aa_dist_40                    ;
			REAL s0_v41_w                         ;
			string s0_aa_code_41                    ;
			REAL s0_aa_dist_41                    ;
			REAL s0_v42_w                         ;
			string s0_aa_code_42                    ;
			REAL s0_aa_dist_42                    ;
			REAL s0_v43_w                         ;
			string s0_aa_code_43                    ;
			REAL s0_aa_dist_43                    ;
			REAL s0_rcvalueb036                   ;
			REAL s0_rcvalueb035                   ;
			REAL s0_rcvalueb034                   ;
			REAL s0_rcvaluep535                   ;
			REAL s0_rcvalueb031                   ;
			REAL s0_rcvaluep539                   ;
			REAL s0_rcvalueb017                   ;
			REAL s0_rcvaluep515                   ;
			REAL s0_rcvaluep513                   ;
			REAL s0_rcvalueb075                   ;
			REAL s0_rcvaluep526                   ;
			REAL s0_rcvalueb079                   ;
			REAL s0_rcvalueb070                   ;
			REAL s0_rcvaluep509                   ;
			REAL s0_rcvalueb069                   ;
			REAL s0_rcvalueb026                   ;
			REAL s0_rcvaluep502                   ;
			REAL s0_rcvaluep540                   ;
			REAL s0_rcvaluep501                   ;
			REAL s0_rcvalueb063                   ;
			REAL s0_rcvaluep505                   ;
			REAL s0_rcvalueb076                   ;
			REAL s0_rcvaluep510                   ;
			REAL s0_rcvaluep567                   ;
			REAL s0_rcvaluep566                   ;
			REAL s0_rcvaluep565                   ;
			REAL s0_rcvaluep523                   ;
			REAL s0_rcvalueb052                   ;
			REAL s0_rcvalueb056                   ;
			REAL s0_rcvalueb059                   ;
			REAL s0_lgt                           ;
			REAL s1_v01_w                         ;
			string s1_aa_code_01                    ;
			REAL s1_aa_dist_01                    ;
			REAL s1_v02_w                         ;
			string s1_aa_code_02                    ;
			REAL s1_aa_dist_02                    ;
			REAL s1_v03_w                         ;
			string s1_aa_code_03                    ;
			REAL s1_aa_dist_03                    ;
			REAL s1_v04_w                         ;
			string s1_aa_code_04                    ;
			REAL s1_aa_dist_04                    ;
			REAL s1_v05_w                         ;
			string s1_aa_code_05                    ;
			REAL s1_aa_dist_05                    ;
			REAL s1_v06_w                         ;
			string s1_aa_code_06                    ;
			REAL s1_aa_dist_06                    ;
			REAL s1_v07_w                         ;
			string s1_aa_code_07                    ;
			REAL s1_aa_dist_07                    ;
			REAL s1_v08_w                         ;
			string s1_aa_code_08                    ;
			REAL s1_aa_dist_08                    ;
			REAL s1_v09_w                         ;
			string s1_aa_code_09                    ;
			REAL s1_aa_dist_09                    ;
			REAL s1_v10_w                         ;
			string s1_aa_code_10                    ;
			REAL s1_aa_dist_10                    ;
			REAL s1_v11_w                         ;
			string s1_aa_code_11                    ;
			REAL s1_aa_dist_11                    ;
			REAL s1_v12_w                         ;
			string s1_aa_code_12                    ;
			REAL s1_aa_dist_12                    ;
			REAL s1_v13_w                         ;
			string s1_aa_code_13                    ;
			REAL s1_aa_dist_13                    ;
			REAL s1_v14_w                         ;
			string s1_aa_code_14                    ;
			REAL s1_aa_dist_14                    ;
			REAL s1_v15_w                         ;
			string s1_aa_code_15                    ;
			REAL s1_aa_dist_15                    ;
			REAL s1_v16_w                         ;
			string s1_aa_code_16                    ;
			REAL s1_aa_dist_16                    ;
			REAL s1_v17_w                         ;
			string s1_aa_code_17                    ;
			REAL s1_aa_dist_17                    ;
			REAL s1_v18_w                         ;
			string s1_aa_code_18                    ;
			REAL s1_aa_dist_18                    ;
			REAL s1_v19_w                         ;
			string s1_aa_code_19                    ;
			REAL s1_aa_dist_19                    ;
			REAL s1_v20_w                         ;
			string s1_aa_code_20                    ;
			REAL s1_aa_dist_20                    ;
			REAL s1_v21_w                         ;
			string s1_aa_code_21                    ;
			REAL s1_aa_dist_21                    ;
			REAL s1_v22_w                         ;
			string s1_aa_code_22                    ;
			REAL s1_aa_dist_22                    ;
			REAL s1_v23_w                         ;
			string s1_aa_code_23                    ;
			REAL s1_aa_dist_23                    ;
			REAL s1_v24_w                         ;
			string s1_aa_code_24                    ;
			REAL s1_aa_dist_24                    ;
			REAL s1_v25_w                         ;
			string s1_aa_code_25                    ;
			REAL s1_aa_dist_25                    ;
			string s1_aa_code_26                    ;
			REAL s1_aa_dist_26                    ;
			REAL s1_rcvaluep509                   ;
			REAL s1_rcvaluep502                   ;
			REAL s1_rcvaluep535                   ;
			REAL s1_rcvaluep539                   ;
			REAL s1_rcvaluep540                   ;
			REAL s1_rcvaluep515                   ;
			REAL s1_rcvaluep505                   ;
			REAL s1_rcvaluep513                   ;
			REAL s1_rcvaluep510                   ;
			REAL s1_rcvalueb067                   ;
			REAL s1_rcvaluep517                   ;
			REAL s1_rcvaluep567                   ;
			REAL s1_rcvaluep566                   ;
			REAL s1_rcvaluep526                   ;
			REAL s1_lgt                           ;
			integer rep_only                         ;
			Real final_score                      ;
			INTEGER base                             ;
			INTEGER pts                              ;
			REAL lgt                              ;
			INTEGER SLBB1809_0_0                     ;
			string basebls0_rc1                     ;
			string basebls0_rc2                     ;
			string basebls0_rc3                     ;
			string basebls0_rc4                     ;
			string basebls0_rc5                     ;
			string basebls0_rc6                     ;
			string basebls0_rc7                     ;
			string basebls0_rc8                     ;
			string basebls0_rc9                     ;
			string basebls0_rc10                    ;
			string basebls0_rc11                    ;
			string basebls0_rc12                    ;
			string basebls0_rc13                    ;
			string basebls0_rc14                    ;
			string basebls0_rc15                    ;
			string basebls0_rc16                    ;
			string basebls0_rc17                    ;
			string basebls0_rc18                    ;
			string basebls0_rc19                    ;
			string basebls0_rc20                    ;
			string basebls0_rc21                    ;
			string basebls0_rc22                    ;
			string basebls0_rc23                    ;
			string basebls0_rc24                    ;
			string basebls0_rc25                    ;
			string basebls0_rc26                    ;
			string basebls0_rc27                    ;
			string basebls0_rc28                    ;
			string basebls0_rc29                    ;
			string basebls0_rc30                    ;
			string basebls0_rc31                    ;
			string basebls0_rc32                    ;
			string basebls0_rc33                    ;
			string basebls0_rc34                    ;
			string basebls0_rc35                    ;
			string basebls0_rc36                    ;
			string basebls0_rc37                    ;
			string basebls0_rc38                    ;
			string basebls0_rc39                    ;
			string basebls0_rc40                    ;
			string basebls0_rc41                    ;
			string basebls0_rc42                    ;
			string basebls0_rc43                    ;
			string basebls0_rc44                    ;
			string basebls0_rc45                    ;
			string basebls0_rc46                    ;
			string basebls0_rc47                    ;
			string basebls0_rc48                    ;
			string basebls0_rc49                    ;
			string basebls0_rc50                    ;
			string basebls1_rc1                     ;
			string basebls1_rc2                     ;
			string basebls1_rc3                     ;
			string basebls1_rc4                     ;
			string basebls1_rc5                     ;
			string basebls1_rc6                     ;
			string basebls1_rc7                     ;
			string basebls1_rc8                     ;
			string basebls1_rc9                     ;
			string basebls1_rc10                    ;
			string basebls1_rc11                    ;
			string basebls1_rc12                    ;
			string basebls1_rc13                    ;
			string basebls1_rc14                    ;
			string basebls1_rc15                    ;
			string basebls1_rc16                    ;
			string basebls1_rc17                    ;
			string basebls1_rc18                    ;
			string basebls1_rc19                    ;
			string basebls1_rc20                    ;
			string basebls1_rc21                    ;
			string basebls1_rc22                    ;
			string basebls1_rc23                    ;
			string basebls1_rc24                    ;
			string basebls1_rc25                    ;
			string basebls1_rc26                    ;
			string basebls1_rc27                    ;
			string basebls1_rc28                    ;
			string basebls1_rc29                    ;
			string basebls1_rc30                    ;
			string basebls1_rc31                    ;
			string basebls1_rc32                    ;
			string basebls1_rc33                    ;
			string basebls1_rc34                    ;
			string basebls1_rc35                    ;
			string basebls1_rc36                    ;
			string basebls1_rc37                    ;
			string basebls1_rc38                    ;
			string basebls1_rc39                    ;
			string basebls1_rc40                    ;
			string basebls1_rc41                    ;
			string basebls1_rc42                    ;
			string basebls1_rc43                    ;
			string basebls1_rc44                    ;
			string basebls1_rc45                    ;
			string basebls1_rc46                    ;
			string basebls1_rc47                    ;
			string basebls1_rc48                    ;
			string basebls1_rc49                    ;
			string basebls1_rc50                    ;
			string bus_mod_rc14                     ;
			string bus_mod_rc3                      ;
			string bus_mod_rc50                     ;
			string bus_mod_rc40                     ;
			string bus_mod_rc30                     ;
			string bus_mod_rc27                     ;
			string bus_mod_rc11                     ;
			string bus_mod_rc36                     ;
			string bus_mod_rc9                      ;
			string bus_mod_rc47                     ;
			string bus_mod_rc38                     ;
			string bus_mod_rc46                     ;
			string bus_mod_rc20                     ;
			string bus_mod_rc1                      ;
			string bus_mod_rc10                     ;
			string bus_mod_rc2                      ;
			string bus_mod_rc13                     ;
			string bus_mod_rc15                     ;
			string bus_mod_rc34                     ;
			string bus_mod_rc33                     ;
			string bus_mod_rc42                     ;
			string bus_mod_rc24                     ;
			string bus_mod_rc41                     ;
			string bus_mod_rc28                     ;
			string bus_mod_rc8                      ;
			string bus_mod_rc7                      ;
			string bus_mod_rc31                     ;
			string bus_mod_rc32                     ;
			string bus_mod_rc37                     ;
			string bus_mod_rc39                     ;
			string bus_mod_rc19                     ;
			string bus_mod_rc26                     ;
			string bus_mod_rc12                     ;
			string bus_mod_rc22                     ;
			string bus_mod_rc49                     ;
			string bus_mod_rc44                     ;
			string bus_mod_rc17                     ;
			string bus_mod_rc29                     ;
			string bus_mod_rc16                     ;
			string bus_mod_rc21                     ;
			string bus_mod_rc25                     ;
			string bus_mod_rc43                     ;
			string bus_mod_rc4                      ;
			string bus_mod_rc23                     ;
			string bus_mod_rc6                      ;
			string bus_mod_rc35                     ;
			string bus_mod_rc18                     ;
			string bus_mod_rc5                      ;
			string bus_mod_rc45                     ;
			string bus_mod_rc48                     ;
			string slbb_rc4                         ;
			string slbb_rc1                         ;
			string slbb_rc3                         ;
			string slbb_rc2                         ;

			Risk_Indicators.Layout_Boca_Shell clam;
		 Business_Risk_BIP.Layouts.OutputLayout busShell;
		END;
		Layout_Debug doModel(BusShell le, clam ri) := TRANSFORM
	#else
		Models.Layout_ModelOut doModel(BusShell le, clam ri) := TRANSFORM
	#end

	/* ***********************************************************
	 *             Model Input Variable Assignments              *
	 ************************************************************* */
			MaxSASLength := 1000; // Max length for the list fields to be imported into SAS (Technically SAS can handle up to 32,767 - but modeling only wants 1,000 to help with speed of imports)
		// The following function takes a comma-delimited string of any length, and a numeric
		// length to truncate the string to. Since the resulting string will often have an 
		// incomplete value at the end, the function trims it off, leaving complete values only.
		// truncate_list(STRING str, UNSIGNED len) :=
			// FUNCTION
				// delimiter := ',';		
				// rec_word  := {STRING word};
				// string_as_dataset := DATASET( [{str}], {STRING text} );
				// norm_lettrs    := NORMALIZE( string_as_dataset, len + 1, TRANSFORM( rec_word, SELF.word := LEFT.text[COUNTER] ) );		
				// words_rolled   := ROLLUP( norm_lettrs, RIGHT.word != delimiter, TRANSFORM( rec_word, SELF.word := LEFT.word + RIGHT.word ) );
				// no_partials    := CHOOSEN( words_rolled, COUNT(words_rolled)-1 );
				// str_trunc_list := ROLLUP( no_partials, TRUE, TRANSFORM( rec_word, SELF.word := LEFT.word + RIGHT.word ) )[1].word;
				// RETURN IF( LENGTH(TRIM(str)) < len, str, str_trunc_list );
			// END;
			
truedid                          := ri.truedid;
nas_summary                      := ri.iid.nas_summary;
nap_summary                      := ri.iid.nap_summary;
ver_sources                      := ri.header_summary.ver_sources;
ver_sources_first_seen           := ri.header_summary.ver_sources_first_seen_date;
ver_sources_last_seen            := ri.header_summary.ver_sources_last_seen_date;
util_adl_type_list               := ri.utility.utili_adl_type;
util_adl_count                   := ri.utility.utili_adl_count;
util_adl_first_seen              := ri.utility.utili_adl_earliest_dt_first_seen;
add_input_naprop                 := ri.address_verification.input_address_information.naprop;
property_owned_total             := ri.address_verification.owned.property_total;
add_curr_avm_auto_val            := ri.avm.address_history_1.avm_automated_valuation;
add_curr_naprop                  := ri.address_verification.address_history_1.naprop;
add_curr_mortgage_date           := ri.address_verification.address_history_1.mortgage_date;
add_curr_mortgage_type           := ri.address_verification.address_history_1.mortgage_type;
add_curr_pop                     := ri.addrPop2;
add_prev_naprop                  := ri.address_verification.address_history_2.naprop;
gong_did_first_seen              := ri.phone_verification.gong_did.gong_adl_dt_first_seen_full;
gong_did_last_seen               := ri.phone_verification.gong_did.gong_adl_dt_last_seen_full;
header_first_seen                := ri.ssn_verification.header_first_seen;
header_last_seen                 := ri.ssn_verification.header_last_seen;
addrs_per_adl_c6                 := ri.velocity_counters.addrs_per_adl_created_6months;
inq_auto_count                   := ri.acc_logs.auto.counttotal;
inq_auto_count01                 := ri.acc_logs.auto.count01;
inq_auto_count03                 := ri.acc_logs.auto.count03;
inq_auto_count06                 := ri.acc_logs.auto.count06;
inq_auto_count12                 := ri.acc_logs.auto.count12;
inq_auto_count24                 := ri.acc_logs.auto.count24;
inq_collection_count             := ri.acc_logs.collection.counttotal;
inq_collection_count01           := ri.acc_logs.collection.count01;
inq_collection_count03           := ri.acc_logs.collection.count03;
inq_collection_count06           := ri.acc_logs.collection.count06;
inq_collection_count12           := ri.acc_logs.collection.count12;
inq_collection_count24           := ri.acc_logs.collection.count24;
inq_communications_count         := ri.acc_logs.communications.counttotal;
inq_communications_count01       := ri.acc_logs.communications.count01;
inq_communications_count03       := ri.acc_logs.communications.count03;
inq_communications_count06       := ri.acc_logs.communications.count06;
inq_communications_count12       := ri.acc_logs.communications.count12;
inq_communications_count24       := ri.acc_logs.communications.count24;
inq_highriskcredit_count         := ri.acc_logs.highriskcredit.counttotal;
inq_highriskcredit_count01       := ri.acc_logs.highriskcredit.count01;
inq_highriskcredit_count03       := ri.acc_logs.highriskcredit.count03;
inq_highriskcredit_count06       := ri.acc_logs.highriskcredit.count06;
inq_highriskcredit_count12       := ri.acc_logs.highriskcredit.count12;
inq_highriskcredit_count24       := ri.acc_logs.highriskcredit.count24;
inq_banko_cm_last_seen           := ri.acc_logs.cm_last_seen_date;
br_first_seen                    := ri.employment.first_seen_date;
br_business_count                := ri.employment.business_ct;
br_dead_business_count           := ri.employment.dead_business_ct;
br_active_phone_count            := ri.employment.business_active_phone_ct;
infutor_nap                      := ri.infutor_phone.infutor_nap;
email_count                      := ri.email_summary.email_ct;
email_domain_free_count          := ri.email_summary.email_domain_free_ct;
email_domain_edu_count           := ri.email_summary.email_domain_edu_ct;
attr_num_aircraft                := ri.aircraft.aircraft_count;
//attr_felonies30                  := ri.bjl.criminal_count30;
attr_felonies30                  := 0;
//attr_felonies90                  := ri.bjl.criminal_count90;
attr_felonies90                  := 0;
//attr_felonies180                 := ri.bjl.criminal_count180;
attr_felonies180                 := 0;
//attr_felonies12                  := ri.bjl.criminal_count12;
attr_felonies12                  := 0;
//attr_felonies24                  := ri.bjl.criminal_count24;
attr_felonies24                  := 0;
//attr_felonies36                  := ri.bjl.criminal_count36;
attr_felonies36                  := 0;
//attr_felonies60                  := ri.bjl.criminal_count60;
attr_felonies60                  := 0;
attr_num_unrel_liens30           := ri.bjl.liens_unreleased_count30;
attr_num_unrel_liens90           := ri.bjl.liens_unreleased_count90;
attr_num_unrel_liens180          := ri.bjl.liens_unreleased_count180;
attr_num_unrel_liens12           := ri.bjl.liens_unreleased_count12;
attr_num_unrel_liens24           := ri.bjl.liens_unreleased_count24;
attr_num_unrel_liens36           := ri.bjl.liens_unreleased_count36;
attr_num_unrel_liens60           := ri.bjl.liens_unreleased_count60;
attr_num_rel_liens30             := ri.bjl.liens_released_count30;
attr_num_rel_liens90             := ri.bjl.liens_released_count90;
attr_num_rel_liens180            := ri.bjl.liens_released_count180;
attr_num_rel_liens12             := ri.bjl.liens_released_count12;
attr_num_rel_liens24             := ri.bjl.liens_released_count24;
attr_num_rel_liens36             := ri.bjl.liens_released_count36;
attr_num_rel_liens60             := ri.bjl.liens_released_count60;
attr_bankruptcy_count60          := ri.bjl.bk_count60;
attr_eviction_count              := ri.bjl.eviction_count;
attr_num_nonderogs               := ri.source_verification.num_nonderogs;
fp_sourcerisktype                := ri.fdattributesv2.sourcerisklevel;
fp_varrisktype                   := ri.fdattributesv2.variationrisklevel;
fp_srchvelocityrisktype          := ri.fdattributesv2.searchvelocityrisklevel;
fp_srchunvrfdssncount            := ri.fdattributesv2.searchunverifiedssncountyear;
fp_srchunvrfdaddrcount           := ri.fdattributesv2.searchunverifiedaddrcountyear;
fp_srchunvrfdphonecount          := ri.fdattributesv2.searchunverifiedphonecountyear;
fp_srchfraudsrchcountyr          := ri.fdattributesv2.searchfraudsearchcountyear;
fp_prevaddrageoldest             := ri.fdattributesv2.prevaddrageoldest;
liens_recent_unreleased_count    := ri.bjl.liens_recent_unreleased_count;
liens_historical_unreleased_ct   := ri.bjl.liens_historical_unreleased_count;
liens_historical_released_count  := ri.bjl.liens_historical_released_count;
//criminal_count                   := ri.bjl.criminal_count;
criminal_count                   := 0;
felony_count                     := 0;
// felony_count                     := ri.bjl.felony_count;
historical_count                 := ri.vehicles.historical_count;
watercraft_count                 := ri.watercraft.watercraft_count;
college_tier                     := ri.student.college_tier;
prof_license_flag                := ri.professional_license.professional_license_flag;
prof_license_ix_sanct_fs         := ri.professional_license.sanctions_date_first_seen;
prof_license_ix_sanct_ls         := ri.professional_license.sanctions_date_last_seen;

id_seleid                        := le.Verification.inputidmatchseleid;
history_datetime                 := le.Input_Echo.historydatetime;
pop_bus_addr                     := le.Input.InputCheckBusAddr;
ver_src_id_mth_since_fs          := le.Business_Activity.SourceBusinessRecordTimeOldestID;
ver_src_id_count                 := le.Verification.SourceCountID;
ver_src_bureau_mth_since_fs      := le.Tradeline.TradeTimeOldest;
ver_src_id_activity12            := le.Business_Activity.BusinessActivity12MonthID;
ver_src_id_list                  := Business_Risk_BIP.Common.truncate_list(le.Verification.sourcelistID, MaxSASLength);
ver_src_id_firstseen_list        := Business_Risk_BIP.Common.truncate_list(le.Verification.sourcedatefirstseenlistID, MaxSASLength);
ver_src_id_lastseen_list         := Business_Risk_BIP.Common.truncate_list(le.Verification.sourcedatelastseenlistID, MaxSASLength);
ver_src_list                     := Business_Risk_BIP.Common.truncate_list(le.Verification.sourcelist, MaxSASLength);
ver_addr_src_firstseen_list      := Business_Risk_BIP.Common.truncate_list(le.Verification.AddrVerificationDateFirstSeenList, MaxSASLength);
//ver_addr_src_lastseen_list       := truncate_list(le.Verification.AddrVerificationDateLastSeenList, MaxSASLength);
ver_addr_src_lastseen_list       := Business_Risk_BIP.Common.truncate_list(le.Verification.AddrVerificationDateLastSeenList, MaxSASLength);
addr_input_lres                  := le.Verification.InputAddrLengthOfResidence;
addr_input_assessed_value        := le.Input_Characteristics.InputAddrAssessedTotal;
assoc_count                      := le.Associates.AssociateCount;
//assoc_felony_count               := le.Associates.AssociateCountWithFelony;
assoc_felony_count               := 0;
assoc_bankruptcy_count12         := le.Associates.AssociateBankrupt1YearCount;
assoc_lien_total                 := le.Associates.AssociateLienCount;
assoc_lien_count                 := le.Associates.AssociateCountWithLien;
assoc_judg_total                 := le.Associates.AssociateJudgmentCount;
assoc_judg_count                 := le.Associates.AssociateCountWithJudgment;
sos_inc_filing_count             := le.SOS.SOSIncorporationCount;
sos_standing                     := le.SOS.SOSStanding;
sos_agent_change_lastseen        := le.SOS.SOSRegisterAgentChangeDateLastSeen;
lien_filed_count                 := le.Lien_And_Judgment.LienCount;
lien_total_amount                := le.Lien_And_Judgment.LienDollarTotal;
lien_filed_ft_ct                 := le.Lien_And_Judgment.LienFiledFTCount;
lien_filed_ot_ct                 := le.Lien_And_Judgment.LienFiledOTCount;
judg_filed_count                 := le.Lien_And_Judgment.JudgmentCount;
judg_total_amount                := le.Lien_And_Judgment.JudgmentDollarTotal;
judg_filed_firstseen             := le.Lien_And_Judgment.JudgFiledDateFirstSeen;

	historydatetime                 := le.Input_Echo.historydatetime;
	historydate                     := le.Input_Echo.historydate;
	


	/* ***********************************************************
	 *                    Generated ECL                          *
	 ************************************************************* */

NULL := -999999999;


INTEGER contains_i( string haystack, string needle ) := (INTEGER)(StringLib.StringFind(haystack, needle, 1) > 0);

sysdate      := __common__( common.sas_date(if(historydate=999999, (string)std.date.today(), (string6)historydate+'01')) ) ;

_ver_src_id_fsrc_fdate := __common__( Models.Common.getw(ver_src_id_firstseen_list, 1) ) ;

_ver_src_id_fsrc_fdate2 := __common__( common.sas_date((string)(_ver_src_id_fsrc_fdate)) ) ;

yr__ver_src_id_fsrc_fdate := __common__( if(min(sysdate, _ver_src_id_fsrc_fdate2) = NULL, NULL, (sysdate - _ver_src_id_fsrc_fdate2) / 365.25) ) ;

mth__ver_src_id_fsrc_fdate := __common__( if(min(sysdate, _ver_src_id_fsrc_fdate2) = NULL, NULL, (sysdate - _ver_src_id_fsrc_fdate2) / 30.5) ) ;

_ver_src_id_br_pos := __common__( Models.Common.findw_cpp(ver_src_id_list, 'BR' , '  ,', 'ie') ) ;

_ver_src_id__br := __common__( _ver_src_id_br_pos > 0 ) ;

_ver_src_id_fdate_br := __common__( if(_ver_src_id_br_pos > 0, Models.Common.getw(ver_src_id_firstseen_list, _ver_src_id_br_pos), '0') ) ;

_ver_src_id_fdate_br2 := __common__( common.sas_date((string)(_ver_src_id_fdate_br)) ) ;

yr__ver_src_id_fdate_br := __common__( if(min(sysdate, _ver_src_id_fdate_br2) = NULL, NULL, (sysdate - _ver_src_id_fdate_br2) / 365.25) ) ;

mth__ver_src_id_fdate_br := __common__( if(min(sysdate, _ver_src_id_fdate_br2) = NULL, NULL, roundup((sysdate - _ver_src_id_fdate_br2) / 30.5)) ) ;

_ver_src_id_ldate_br := __common__( if(_ver_src_id_br_pos > 0, Models.Common.getw(ver_src_id_lastseen_list, _ver_src_id_br_pos), '0') ) ;

_ver_src_id_ldate_br2 := __common__( common.sas_date((string)(_ver_src_id_ldate_br)) ) ;

yr__ver_src_id_ldate_br := __common__( if(min(sysdate, _ver_src_id_ldate_br2) = NULL, NULL, roundup((sysdate - _ver_src_id_ldate_br2) / 365.25)) ) ;

mth__ver_src_id_ldate_br := __common__( if(min(sysdate, _ver_src_id_ldate_br2) = NULL, NULL, roundup((sysdate - _ver_src_id_ldate_br2) / 30.5)) ) ;

_ver_src_id_c_pos := __common__( Models.Common.findw_cpp(ver_src_id_list, 'C' , '  ,', 'ie') ) ;

_ver_src_id__c := __common__( _ver_src_id_c_pos > 0 ) ;

_ver_src_id_fdate_c := __common__( if(_ver_src_id_c_pos > 0, Models.Common.getw(ver_src_id_firstseen_list, _ver_src_id_c_pos), '0') ) ;

_ver_src_id_fdate_c2 := __common__( common.sas_date((string)(_ver_src_id_fdate_c)) ) ;

yr__ver_src_id_fdate_c := __common__( if(min(sysdate, _ver_src_id_fdate_c2) = NULL, NULL, roundup((sysdate - _ver_src_id_fdate_c2) / 365.25)) ) ;

mth__ver_src_id_fdate_c := __common__( if(min(sysdate, _ver_src_id_fdate_c2) = NULL, NULL, roundup((sysdate - _ver_src_id_fdate_c2) / 30.5)) ) ;

_ver_src_id_ldate_c := __common__( if(_ver_src_id_c_pos > 0, Models.Common.getw(ver_src_id_lastseen_list, _ver_src_id_c_pos), '0') ) ;

_ver_src_id_ldate_c2 := __common__( common.sas_date((string)(_ver_src_id_ldate_c)) ) ;

yr__ver_src_id_ldate_c := __common__( if(min(sysdate, _ver_src_id_ldate_c2) = NULL, NULL, roundup((sysdate - _ver_src_id_ldate_c2) / 365.25)) ) ;

mth__ver_src_id_ldate_c := __common__( if(min(sysdate, _ver_src_id_ldate_c2) = NULL, NULL, roundup((sysdate - _ver_src_id_ldate_c2) / 30.5)) ) ;

_ver_src_id_d_pos := __common__( Models.Common.findw_cpp(ver_src_id_list, 'D' , '  ,', 'ie') ) ;

_ver_src_id__d := __common__( _ver_src_id_d_pos > 0 ) ;

_ver_src_id_fdate_d := __common__( if(_ver_src_id_d_pos > 0, Models.Common.getw(ver_src_id_firstseen_list, _ver_src_id_d_pos), '0') ) ;

_ver_src_id_fdate_d2 := __common__( common.sas_date((string)(_ver_src_id_fdate_d)) ) ;

yr__ver_src_id_fdate_d := __common__( if(min(sysdate, _ver_src_id_fdate_d2) = NULL, NULL, roundup((sysdate - _ver_src_id_fdate_d2) / 365.25)) ) ;

mth__ver_src_id_fdate_d := __common__( if(min(sysdate, _ver_src_id_fdate_d2) = NULL, NULL, roundup((sysdate - _ver_src_id_fdate_d2) / 30.5)) ) ;

_ver_src_id_ldate_d := __common__( if(_ver_src_id_d_pos > 0, Models.Common.getw(ver_src_id_lastseen_list, _ver_src_id_d_pos), '0') ) ;

_ver_src_id_ldate_d2 := __common__( common.sas_date((string)(_ver_src_id_ldate_d)) ) ;

yr__ver_src_id_ldate_d := __common__( if(min(sysdate, _ver_src_id_ldate_d2) = NULL, NULL, roundup((sysdate - _ver_src_id_ldate_d2) / 365.25)) ) ;

mth__ver_src_id_ldate_d := __common__( if(min(sysdate, _ver_src_id_ldate_d2) = NULL, NULL, roundup((sysdate - _ver_src_id_ldate_d2) / 30.5)) ) ;

_ver_src_id_df_pos := __common__( Models.Common.findw_cpp(ver_src_id_list, 'DF' , '  ,', 'ie') ) ;

_ver_src_id__df := __common__( _ver_src_id_df_pos > 0 ) ;

_ver_src_id_fdate_df := __common__( if(_ver_src_id_df_pos > 0, Models.Common.getw(ver_src_id_firstseen_list, _ver_src_id_df_pos), '0') ) ;

_ver_src_id_fdate_df2 := __common__( common.sas_date((string)(_ver_src_id_fdate_df)) ) ;

yr__ver_src_id_fdate_df := __common__( if(min(sysdate, _ver_src_id_fdate_df2) = NULL, NULL, roundup((sysdate - _ver_src_id_fdate_df2) / 365.25)) ) ;

mth__ver_src_id_fdate_df := __common__( if(min(sysdate, _ver_src_id_fdate_df2) = NULL, NULL, roundup((sysdate - _ver_src_id_fdate_df2) / 30.5)) ) ;

_ver_src_id_ldate_df := __common__( if(_ver_src_id_df_pos > 0, Models.Common.getw(ver_src_id_lastseen_list, _ver_src_id_df_pos), '0') ) ;

_ver_src_id_ldate_df2 := __common__( common.sas_date((string)(_ver_src_id_ldate_df)) ) ;

yr__ver_src_id_ldate_df := __common__( if(min(sysdate, _ver_src_id_ldate_df2) = NULL, NULL, roundup((sysdate - _ver_src_id_ldate_df2) / 365.25)) ) ;

mth__ver_src_id_ldate_df := __common__( if(min(sysdate, _ver_src_id_ldate_df2) = NULL, NULL,roundup( (sysdate - _ver_src_id_ldate_df2) / 30.5)) ) ;

_ver_src_id_dn_pos := __common__( Models.Common.findw_cpp(ver_src_id_list, 'DN' , '  ,', 'ie') ) ;

_ver_src_id__dn := __common__( _ver_src_id_dn_pos > 0 ) ;

_ver_src_id_fdate_dn := __common__( if(_ver_src_id_dn_pos > 0, Models.Common.getw(ver_src_id_firstseen_list, _ver_src_id_dn_pos), '0') ) ;

_ver_src_id_fdate_dn2 := __common__( common.sas_date((string)(_ver_src_id_fdate_dn)) ) ;

yr__ver_src_id_fdate_dn := __common__( if(min(sysdate, _ver_src_id_fdate_dn2) = NULL, NULL, roundup((sysdate - _ver_src_id_fdate_dn2) / 365.25)) ) ;

mth__ver_src_id_fdate_dn := __common__( if(min(sysdate, _ver_src_id_fdate_dn2) = NULL, NULL, roundup((sysdate - _ver_src_id_fdate_dn2) / 30.5)) ) ;

_ver_src_id_ldate_dn := __common__( if(_ver_src_id_dn_pos > 0, Models.Common.getw(ver_src_id_lastseen_list, _ver_src_id_dn_pos), '0') ) ;

_ver_src_id_ldate_dn2 := __common__( common.sas_date((string)(_ver_src_id_ldate_dn)) ) ;

yr__ver_src_id_ldate_dn := __common__( if(min(sysdate, _ver_src_id_ldate_dn2) = NULL, NULL, roundup((sysdate - _ver_src_id_ldate_dn2) / 365.25)) ) ;

mth__ver_src_id_ldate_dn := __common__( if(min(sysdate, _ver_src_id_ldate_dn2) = NULL, NULL, roundup((sysdate - _ver_src_id_ldate_dn2) / 30.5)) ) ;

_ver_src_id_fb_pos := __common__( Models.Common.findw_cpp(ver_src_id_list, 'FB' , '  ,', 'ie') ) ;

_ver_src_id__fb := __common__( _ver_src_id_fb_pos > 0 ) ;

_ver_src_id_fdate_fb := __common__( if(_ver_src_id_fb_pos > 0, Models.Common.getw(ver_src_id_firstseen_list, _ver_src_id_fb_pos), '0') ) ;

_ver_src_id_fdate_fb2 := __common__( common.sas_date((string)(_ver_src_id_fdate_fb)) ) ;

yr__ver_src_id_fdate_fb := __common__( if(min(sysdate, _ver_src_id_fdate_fb2) = NULL, NULL, roundup((sysdate - _ver_src_id_fdate_fb2) / 365.25)) ) ;

mth__ver_src_id_fdate_fb := __common__( if(min(sysdate, _ver_src_id_fdate_fb2) = NULL, NULL, roundup((sysdate - _ver_src_id_fdate_fb2) / 30.5)) ) ;

_ver_src_id_ldate_fb := __common__( if(_ver_src_id_fb_pos > 0, Models.Common.getw(ver_src_id_lastseen_list, _ver_src_id_fb_pos), '0') ) ;

_ver_src_id_ldate_fb2 := __common__( common.sas_date((string)(_ver_src_id_ldate_fb)) ) ;

yr__ver_src_id_ldate_fb := __common__( if(min(sysdate, _ver_src_id_ldate_fb2) = NULL, NULL, roundup((sysdate - _ver_src_id_ldate_fb2) / 365.25)) ) ;

mth__ver_src_id_ldate_fb := __common__( if(min(sysdate, _ver_src_id_ldate_fb2) = NULL, NULL, roundup((sysdate - _ver_src_id_ldate_fb2) / 30.5)) ) ;

_ver_src_id_l0_pos := __common__( Models.Common.findw_cpp(ver_src_id_list, 'L0' , '  ,', 'ie') ) ;

_ver_src_id__l0 := __common__( _ver_src_id_l0_pos > 0 ) ;

_ver_src_id_fdate_l0 := __common__( if(_ver_src_id_l0_pos > 0, Models.Common.getw(ver_src_id_firstseen_list, _ver_src_id_l0_pos), '0') ) ;

_ver_src_id_fdate_l02 := __common__( common.sas_date((string)(_ver_src_id_fdate_l0)) ) ;

yr__ver_src_id_fdate_l0 := __common__( if(min(sysdate, _ver_src_id_fdate_l02) = NULL, NULL, roundup((sysdate - _ver_src_id_fdate_l02) / 365.25)) ) ;

mth__ver_src_id_fdate_l0 := __common__( if(min(sysdate, _ver_src_id_fdate_l02) = NULL, NULL, roundup((sysdate - _ver_src_id_fdate_l02) / 30.5)) ) ;

_ver_src_id_ldate_l0 := __common__( if(_ver_src_id_l0_pos > 0, Models.Common.getw(ver_src_id_lastseen_list, _ver_src_id_l0_pos), '0') ) ;

_ver_src_id_ldate_l02 := __common__( common.sas_date((string)(_ver_src_id_ldate_l0)) ) ;

yr__ver_src_id_ldate_l0 := __common__( if(min(sysdate, _ver_src_id_ldate_l02) = NULL, NULL, roundup((sysdate - _ver_src_id_ldate_l02) / 365.25)) ) ;

mth__ver_src_id_ldate_l0 := __common__( if(min(sysdate, _ver_src_id_ldate_l02) = NULL, NULL, roundup((sysdate - _ver_src_id_ldate_l02) / 30.5)) ) ;

_ver_src_id_l2_pos := __common__( Models.Common.findw_cpp(ver_src_id_list, 'L2' , '  ,', 'ie') ) ;

_ver_src_id__l2 := __common__( _ver_src_id_l2_pos > 0 ) ;

_ver_src_id_fdate_l2 := __common__( if(_ver_src_id_l2_pos > 0, Models.Common.getw(ver_src_id_firstseen_list, _ver_src_id_l2_pos), '0') ) ;

_ver_src_id_fdate_l22 := __common__( common.sas_date((string)(_ver_src_id_fdate_l2)) ) ;

yr__ver_src_id_fdate_l2 := __common__( if(min(sysdate, _ver_src_id_fdate_l22) = NULL, NULL, roundup((sysdate - _ver_src_id_fdate_l22) / 365.25)) ) ;

mth__ver_src_id_fdate_l2 := __common__( if(min(sysdate, _ver_src_id_fdate_l22) = NULL, NULL, roundup((sysdate - _ver_src_id_fdate_l22) / 30.5)) ) ;

_ver_src_id_ldate_l2 := __common__( if(_ver_src_id_l2_pos > 0, Models.Common.getw(ver_src_id_lastseen_list, _ver_src_id_l2_pos), '0') ) ;

_ver_src_id_ldate_l22 := __common__( common.sas_date((string)(_ver_src_id_ldate_l2)) ) ;

yr__ver_src_id_ldate_l2 := __common__( if(min(sysdate, _ver_src_id_ldate_l22) = NULL, NULL, roundup((sysdate - _ver_src_id_ldate_l22) / 365.25)) ) ;

mth__ver_src_id_ldate_l2 := __common__( if(min(sysdate, _ver_src_id_ldate_l22) = NULL, NULL, roundup((sysdate - _ver_src_id_ldate_l22) / 30.5)) ) ;

_ver_src_id_u2_pos := __common__( Models.Common.findw_cpp(ver_src_id_list, 'U2' , '  ,', 'ie') ) ;

_ver_src_id__u2 := __common__( _ver_src_id_u2_pos > 0 ) ;

_ver_src_id_fdate_u2 := __common__( if(_ver_src_id_u2_pos > 0, Models.Common.getw(ver_src_id_firstseen_list, _ver_src_id_u2_pos), '0') ) ;

_ver_src_id_fdate_u22 := __common__( common.sas_date((string)(_ver_src_id_fdate_u2)) ) ;

yr__ver_src_id_fdate_u2 := __common__( if(min(sysdate, _ver_src_id_fdate_u22) = NULL, NULL, roundup((sysdate - _ver_src_id_fdate_u22) / 365.25)) ) ;

mth__ver_src_id_fdate_u2 := __common__( if(min(sysdate, _ver_src_id_fdate_u22) = NULL, NULL, roundup((sysdate - _ver_src_id_fdate_u22) / 30.5)) ) ;

_ver_src_id_ldate_u2 := __common__( if(_ver_src_id_u2_pos > 0, Models.Common.getw(ver_src_id_lastseen_list, _ver_src_id_u2_pos), '0') ) ;

_ver_src_id_ldate_u22 := __common__( common.sas_date((string)(_ver_src_id_ldate_u2)) ) ;

yr__ver_src_id_ldate_u2 := __common__( if(min(sysdate, _ver_src_id_ldate_u22) = NULL, NULL, roundup((sysdate - _ver_src_id_ldate_u22) / 365.25)) ) ;

mth__ver_src_id_ldate_u2 := __common__( if(min(sysdate, _ver_src_id_ldate_u22) = NULL, NULL, roundup((sysdate - _ver_src_id_ldate_u22) / 30.5)) ) ;

_ver_src_id_ar_pos := __common__( Models.Common.findw_cpp(ver_src_id_list, 'AR' , '  ,', 'ie') ) ;

_ver_src_id__ar := __common__( _ver_src_id_ar_pos > 0 ) ;

_ver_src_id_fdate_ar := __common__( if(_ver_src_id_ar_pos > 0, Models.Common.getw(ver_src_id_firstseen_list, _ver_src_id_ar_pos), '0') ) ;

_ver_src_id_fdate_ar2 := __common__( common.sas_date((string)(_ver_src_id_fdate_ar)) ) ;

yr__ver_src_id_fdate_ar := __common__( if(min(sysdate, _ver_src_id_fdate_ar2) = NULL, NULL, roundup((sysdate - _ver_src_id_fdate_ar2) / 365.25)) ) ;

mth__ver_src_id_fdate_ar := __common__( if(min(sysdate, _ver_src_id_fdate_ar2) = NULL, NULL, roundup((sysdate - _ver_src_id_fdate_ar2) / 30.5)) ) ;

_ver_src_id_ldate_ar := __common__( if(_ver_src_id_ar_pos > 0, Models.Common.getw(ver_src_id_lastseen_list, _ver_src_id_ar_pos), '0') ) ;

_ver_src_id_ldate_ar2 := __common__( common.sas_date((string)(_ver_src_id_ldate_ar)) ) ;

yr__ver_src_id_ldate_ar := __common__( if(min(sysdate, _ver_src_id_ldate_ar2) = NULL, NULL, roundup((sysdate - _ver_src_id_ldate_ar2) / 365.25)) ) ;

mth__ver_src_id_ldate_ar := __common__( if(min(sysdate, _ver_src_id_ldate_ar2) = NULL, NULL, roundup((sysdate - _ver_src_id_ldate_ar2) / 30.5)) ) ;

_ver_src_id_ba_pos := __common__( Models.Common.findw_cpp(ver_src_id_list, 'BA' , '  ,', 'ie') ) ;

_ver_src_id__ba := __common__( _ver_src_id_ba_pos > 0 ) ;

_ver_src_id_fdate_ba := __common__( if(_ver_src_id_ba_pos > 0, Models.Common.getw(ver_src_id_firstseen_list, _ver_src_id_ba_pos), '0') ) ;

_ver_src_id_fdate_ba2 := __common__( common.sas_date((string)(_ver_src_id_fdate_ba)) ) ;

yr__ver_src_id_fdate_ba := __common__( if(min(sysdate, _ver_src_id_fdate_ba2) = NULL, NULL, roundup((sysdate - _ver_src_id_fdate_ba2) / 365.25)) ) ;

mth__ver_src_id_fdate_ba := __common__( if(min(sysdate, _ver_src_id_fdate_ba2) = NULL, NULL, roundup((sysdate - _ver_src_id_fdate_ba2) / 30.5)) ) ;

_ver_src_id_ldate_ba := __common__( if(_ver_src_id_ba_pos > 0, Models.Common.getw(ver_src_id_lastseen_list, _ver_src_id_ba_pos), '0') ) ;

_ver_src_id_ldate_ba2 := __common__( common.sas_date((string)(_ver_src_id_ldate_ba)) ) ;

yr__ver_src_id_ldate_ba := __common__( if(min(sysdate, _ver_src_id_ldate_ba2) = NULL, NULL, roundup((sysdate - _ver_src_id_ldate_ba2) / 365.25)) ) ;

mth__ver_src_id_ldate_ba := __common__( if(min(sysdate, _ver_src_id_ldate_ba2) = NULL, NULL, roundup((sysdate - _ver_src_id_ldate_ba2) / 30.5)) ) ;

_ver_src_id_bm_pos := __common__( Models.Common.findw_cpp(ver_src_id_list, 'BM' , '  ,', 'ie') ) ;

_ver_src_id__bm := __common__( _ver_src_id_bm_pos > 0 ) ;

_ver_src_id_fdate_bm := __common__( if(_ver_src_id_bm_pos > 0, Models.Common.getw(ver_src_id_firstseen_list, _ver_src_id_bm_pos), '0') ) ;

_ver_src_id_fdate_bm2 := __common__( common.sas_date((string)(_ver_src_id_fdate_bm)) ) ;

yr__ver_src_id_fdate_bm := __common__( if(min(sysdate, _ver_src_id_fdate_bm2) = NULL, NULL, roundup((sysdate - _ver_src_id_fdate_bm2) / 365.25)) ) ;

mth__ver_src_id_fdate_bm := __common__( if(min(sysdate, _ver_src_id_fdate_bm2) = NULL, NULL, roundup((sysdate - _ver_src_id_fdate_bm2) / 30.5)) ) ;

_ver_src_id_ldate_bm := __common__( if(_ver_src_id_bm_pos > 0, Models.Common.getw(ver_src_id_lastseen_list, _ver_src_id_bm_pos), '0') ) ;

_ver_src_id_ldate_bm2 := __common__( common.sas_date((string)(_ver_src_id_ldate_bm)) ) ;

yr__ver_src_id_ldate_bm := __common__( if(min(sysdate, _ver_src_id_ldate_bm2) = NULL, NULL, roundup((sysdate - _ver_src_id_ldate_bm2) / 365.25)) ) ;

mth__ver_src_id_ldate_bm := __common__( if(min(sysdate, _ver_src_id_ldate_bm2) = NULL, NULL, roundup((sysdate - _ver_src_id_ldate_bm2) / 30.5)) ) ;

_ver_src_id_bn_pos := __common__( Models.Common.findw_cpp(ver_src_id_list, 'BN' , '  ,', 'ie') ) ;

_ver_src_id__bn := __common__( _ver_src_id_bn_pos > 0 ) ;

_ver_src_id_fdate_bn := __common__( if(_ver_src_id_bn_pos > 0, Models.Common.getw(ver_src_id_firstseen_list, _ver_src_id_bn_pos), '0') ) ;

_ver_src_id_fdate_bn2 := __common__( common.sas_date((string)(_ver_src_id_fdate_bn)) ) ;

yr__ver_src_id_fdate_bn := __common__( if(min(sysdate, _ver_src_id_fdate_bn2) = NULL, NULL, roundup((sysdate - _ver_src_id_fdate_bn2) / 365.25)) ) ;

mth__ver_src_id_fdate_bn := __common__( if(min(sysdate, _ver_src_id_fdate_bn2) = NULL, NULL, roundup((sysdate - _ver_src_id_fdate_bn2) / 30.5)) ) ;

_ver_src_id_ldate_bn := __common__( if(_ver_src_id_bn_pos > 0, Models.Common.getw(ver_src_id_lastseen_list, _ver_src_id_bn_pos), '0') ) ;

_ver_src_id_ldate_bn2 := __common__( common.sas_date((string)(_ver_src_id_ldate_bn)) ) ;

yr__ver_src_id_ldate_bn := __common__( if(min(sysdate, _ver_src_id_ldate_bn2) = NULL, NULL, roundup((sysdate - _ver_src_id_ldate_bn2) / 365.25)) ) ;

mth__ver_src_id_ldate_bn := __common__( if(min(sysdate, _ver_src_id_ldate_bn2) = NULL, NULL, roundup((sysdate - _ver_src_id_ldate_bn2) / 30.5)) ) ;

_ver_src_id_cu_pos := __common__( Models.Common.findw_cpp(ver_src_id_list, 'CU' , '  ,', 'ie') ) ;

_ver_src_id__cu := __common__( _ver_src_id_cu_pos > 0 ) ;

_ver_src_id_fdate_cu := __common__( if(_ver_src_id_cu_pos > 0, Models.Common.getw(ver_src_id_firstseen_list, _ver_src_id_cu_pos), '0') ) ;

_ver_src_id_fdate_cu2 := __common__( common.sas_date((string)(_ver_src_id_fdate_cu)) ) ;

yr__ver_src_id_fdate_cu := __common__( if(min(sysdate, _ver_src_id_fdate_cu2) = NULL, NULL, roundup((sysdate - _ver_src_id_fdate_cu2) / 365.25)) ) ;

mth__ver_src_id_fdate_cu := __common__( if(min(sysdate, _ver_src_id_fdate_cu2) = NULL, NULL, roundup((sysdate - _ver_src_id_fdate_cu2) / 30.5)) ) ;

_ver_src_id_ldate_cu := __common__( if(_ver_src_id_cu_pos > 0, Models.Common.getw(ver_src_id_lastseen_list, _ver_src_id_cu_pos), '0') ) ;

_ver_src_id_ldate_cu2 := __common__( common.sas_date((string)(_ver_src_id_ldate_cu)) ) ;

yr__ver_src_id_ldate_cu := __common__( if(min(sysdate, _ver_src_id_ldate_cu2) = NULL, NULL, roundup((sysdate - _ver_src_id_ldate_cu2) / 365.25)) ) ;

mth__ver_src_id_ldate_cu := __common__( if(min(sysdate, _ver_src_id_ldate_cu2) = NULL, NULL, roundup((sysdate - _ver_src_id_ldate_cu2) / 30.5)) ) ;

_ver_src_id_da_pos := __common__( Models.Common.findw_cpp(ver_src_id_list, 'DA' , '  ,', 'ie') ) ;

_ver_src_id__da := __common__( _ver_src_id_da_pos > 0 ) ;

_ver_src_id_fdate_da := __common__( if(_ver_src_id_da_pos > 0, Models.Common.getw(ver_src_id_firstseen_list, _ver_src_id_da_pos), '0') ) ;

_ver_src_id_fdate_da2 := __common__( common.sas_date((string)(_ver_src_id_fdate_da)) ) ;

yr__ver_src_id_fdate_da := __common__( if(min(sysdate, _ver_src_id_fdate_da2) = NULL, NULL, roundup((sysdate - _ver_src_id_fdate_da2) / 365.25)) ) ;

mth__ver_src_id_fdate_da := __common__( if(min(sysdate, _ver_src_id_fdate_da2) = NULL, NULL, roundup((sysdate - _ver_src_id_fdate_da2) / 30.5)) ) ;

_ver_src_id_ldate_da := __common__( if(_ver_src_id_da_pos > 0, Models.Common.getw(ver_src_id_lastseen_list, _ver_src_id_da_pos), '0') ) ;

_ver_src_id_ldate_da2 := __common__( common.sas_date((string)(_ver_src_id_ldate_da)) ) ;

yr__ver_src_id_ldate_da := __common__( if(min(sysdate, _ver_src_id_ldate_da2) = NULL, NULL, roundup((sysdate - _ver_src_id_ldate_da2) / 365.25)) ) ;

mth__ver_src_id_ldate_da := __common__( if(min(sysdate, _ver_src_id_ldate_da2) = NULL, NULL, roundup((sysdate - _ver_src_id_ldate_da2) / 30.5)) ) ;

_ver_src_id_ef_pos := __common__( Models.Common.findw_cpp(ver_src_id_list, 'EF' , '  ,', 'ie') ) ;

_ver_src_id__ef := __common__( _ver_src_id_ef_pos > 0 ) ;

_ver_src_id_fdate_ef := __common__( if(_ver_src_id_ef_pos > 0, Models.Common.getw(ver_src_id_firstseen_list, _ver_src_id_ef_pos), '0') ) ;

_ver_src_id_fdate_ef2 := __common__( common.sas_date((string)(_ver_src_id_fdate_ef)) ) ;

yr__ver_src_id_fdate_ef := __common__( if(min(sysdate, _ver_src_id_fdate_ef2) = NULL, NULL, roundup((sysdate - _ver_src_id_fdate_ef2) / 365.25)) ) ;

mth__ver_src_id_fdate_ef := __common__( if(min(sysdate, _ver_src_id_fdate_ef2) = NULL, NULL, roundup((sysdate - _ver_src_id_fdate_ef2) / 30.5)) ) ;

_ver_src_id_ldate_ef := __common__( if(_ver_src_id_ef_pos > 0, Models.Common.getw(ver_src_id_lastseen_list, _ver_src_id_ef_pos), '0') ) ;

_ver_src_id_ldate_ef2 := __common__( common.sas_date((string)(_ver_src_id_ldate_ef)) ) ;

yr__ver_src_id_ldate_ef := __common__( if(min(sysdate, _ver_src_id_ldate_ef2) = NULL, NULL, roundup((sysdate - _ver_src_id_ldate_ef2) / 365.25)) ) ;

mth__ver_src_id_ldate_ef := __common__( if(min(sysdate, _ver_src_id_ldate_ef2) = NULL, NULL, roundup((sysdate - _ver_src_id_ldate_ef2) / 30.5)) ) ;

_ver_src_id_fi_pos := __common__( Models.Common.findw_cpp(ver_src_id_list, 'FI' , '  ,', 'ie') ) ;

_ver_src_id__fi := __common__( _ver_src_id_fi_pos > 0 ) ;

_ver_src_id_fdate_fi := __common__( if(_ver_src_id_fi_pos > 0, Models.Common.getw(ver_src_id_firstseen_list, _ver_src_id_fi_pos), '0') ) ;

_ver_src_id_fdate_fi2 := __common__( common.sas_date((string)(_ver_src_id_fdate_fi)) ) ;

yr__ver_src_id_fdate_fi := __common__( if(min(sysdate, _ver_src_id_fdate_fi2) = NULL, NULL, roundup((sysdate - _ver_src_id_fdate_fi2) / 365.25)) ) ;

mth__ver_src_id_fdate_fi := __common__( if(min(sysdate, _ver_src_id_fdate_fi2) = NULL, NULL, roundup((sysdate - _ver_src_id_fdate_fi2) / 30.5)) ) ;

_ver_src_id_ldate_fi := __common__( if(_ver_src_id_fi_pos > 0, Models.Common.getw(ver_src_id_lastseen_list, _ver_src_id_fi_pos), '0') ) ;

_ver_src_id_ldate_fi2 := __common__( common.sas_date((string)(_ver_src_id_ldate_fi)) ) ;

yr__ver_src_id_ldate_fi := __common__( if(min(sysdate, _ver_src_id_ldate_fi2) = NULL, NULL, roundup((sysdate - _ver_src_id_ldate_fi2) / 365.25)) ) ;

mth__ver_src_id_ldate_fi := __common__( if(min(sysdate, _ver_src_id_ldate_fi2) = NULL, NULL, roundup((sysdate - _ver_src_id_ldate_fi2) / 30.5)) ) ;

_ver_src_id_i_pos := __common__( Models.Common.findw_cpp(ver_src_id_list, 'I' , '  ,', 'ie') ) ;

_ver_src_id__i := __common__( _ver_src_id_i_pos > 0 ) ;

_ver_src_id_fdate_i := __common__( if(_ver_src_id_i_pos > 0, Models.Common.getw(ver_src_id_firstseen_list, _ver_src_id_i_pos), '0') ) ;

_ver_src_id_fdate_i2 := __common__( common.sas_date((string)(_ver_src_id_fdate_i)) ) ;

yr__ver_src_id_fdate_i := __common__( if(min(sysdate, _ver_src_id_fdate_i2) = NULL, NULL, roundup((sysdate - _ver_src_id_fdate_i2) / 365.25)) ) ;

mth__ver_src_id_fdate_i := __common__( if(min(sysdate, _ver_src_id_fdate_i2) = NULL, NULL, roundup((sysdate - _ver_src_id_fdate_i2) / 30.5)) ) ;

_ver_src_id_ldate_i := __common__( if(_ver_src_id_i_pos > 0, Models.Common.getw(ver_src_id_lastseen_list, _ver_src_id_i_pos), '0') ) ;

_ver_src_id_ldate_i2 := __common__( common.sas_date((string)(_ver_src_id_ldate_i)) ) ;

yr__ver_src_id_ldate_i := __common__( if(min(sysdate, _ver_src_id_ldate_i2) = NULL, NULL, roundup((sysdate - _ver_src_id_ldate_i2) / 365.25)) ) ;

mth__ver_src_id_ldate_i := __common__( if(min(sysdate, _ver_src_id_ldate_i2) = NULL, NULL, roundup((sysdate - _ver_src_id_ldate_i2) / 30.5)) ) ;

_ver_src_id_ia_pos := __common__( Models.Common.findw_cpp(ver_src_id_list, 'IA' , '  ,', 'ie') ) ;

_ver_src_id__ia := __common__( _ver_src_id_ia_pos > 0 ) ;

_ver_src_id_fdate_ia := __common__( if(_ver_src_id_ia_pos > 0, Models.Common.getw(ver_src_id_firstseen_list, _ver_src_id_ia_pos), '0') ) ;

_ver_src_id_fdate_ia2 := __common__( common.sas_date((string)(_ver_src_id_fdate_ia)) ) ;

yr__ver_src_id_fdate_ia := __common__( if(min(sysdate, _ver_src_id_fdate_ia2) = NULL, NULL, roundup((sysdate - _ver_src_id_fdate_ia2) / 365.25)) ) ;

mth__ver_src_id_fdate_ia := __common__( if(min(sysdate, _ver_src_id_fdate_ia2) = NULL, NULL, roundup((sysdate - _ver_src_id_fdate_ia2) / 30.5)) ) ;

_ver_src_id_ldate_ia := __common__( if(_ver_src_id_ia_pos > 0, Models.Common.getw(ver_src_id_lastseen_list, _ver_src_id_ia_pos), '0') ) ;

_ver_src_id_ldate_ia2 := __common__( common.sas_date((string)(_ver_src_id_ldate_ia)) ) ;

yr__ver_src_id_ldate_ia := __common__( if(min(sysdate, _ver_src_id_ldate_ia2) = NULL, NULL, roundup((sysdate - _ver_src_id_ldate_ia2) / 365.25)) ) ;

mth__ver_src_id_ldate_ia := __common__( if(min(sysdate, _ver_src_id_ldate_ia2) = NULL, NULL, roundup((sysdate - _ver_src_id_ldate_ia2) / 30.5)) ) ;

_ver_src_id_in_pos := __common__( Models.Common.findw_cpp(ver_src_id_list, 'IN' , '  ,', 'ie') ) ;

_ver_src_id__in := __common__( _ver_src_id_in_pos > 0 ) ;

_ver_src_id_fdate_in := __common__( if(_ver_src_id_in_pos > 0, Models.Common.getw(ver_src_id_firstseen_list, _ver_src_id_in_pos), '0') ) ;

_ver_src_id_fdate_in2 := __common__( common.sas_date((string)(_ver_src_id_fdate_in)) ) ;

yr__ver_src_id_fdate_in := __common__( if(min(sysdate, _ver_src_id_fdate_in2) = NULL, NULL, roundup((sysdate - _ver_src_id_fdate_in2) / 365.25)) ) ;

mth__ver_src_id_fdate_in := __common__( if(min(sysdate, _ver_src_id_fdate_in2) = NULL, NULL, roundup((sysdate - _ver_src_id_fdate_in2) / 30.5)) ) ;

_ver_src_id_ldate_in := __common__( if(_ver_src_id_in_pos > 0, Models.Common.getw(ver_src_id_lastseen_list, _ver_src_id_in_pos), '0') ) ;

_ver_src_id_ldate_in2 := __common__( common.sas_date((string)(_ver_src_id_ldate_in)) ) ;

yr__ver_src_id_ldate_in := __common__( if(min(sysdate, _ver_src_id_ldate_in2) = NULL, NULL, roundup((sysdate - _ver_src_id_ldate_in2) / 365.25)) ) ;

mth__ver_src_id_ldate_in := __common__( if(min(sysdate, _ver_src_id_ldate_in2) = NULL, NULL, roundup((sysdate - _ver_src_id_ldate_in2) / 30.5)) ) ;

_ver_src_id_os_pos := __common__( Models.Common.findw_cpp(ver_src_id_list, 'OS' , '  ,', 'ie') ) ;

_ver_src_id__os := __common__( _ver_src_id_os_pos > 0 ) ;

_ver_src_id_fdate_os := __common__( if(_ver_src_id_os_pos > 0, Models.Common.getw(ver_src_id_firstseen_list, _ver_src_id_os_pos), '0') ) ;

_ver_src_id_fdate_os2 := __common__( common.sas_date((string)(_ver_src_id_fdate_os)) ) ;

yr__ver_src_id_fdate_os := __common__( if(min(sysdate, _ver_src_id_fdate_os2) = NULL, NULL, roundup((sysdate - _ver_src_id_fdate_os2) / 365.25)) ) ;

mth__ver_src_id_fdate_os := __common__( if(min(sysdate, _ver_src_id_fdate_os2) = NULL, NULL, roundup((sysdate - _ver_src_id_fdate_os2) / 30.5)) ) ;

_ver_src_id_ldate_os := __common__( if(_ver_src_id_os_pos > 0, Models.Common.getw(ver_src_id_lastseen_list, _ver_src_id_os_pos), '0') ) ;

_ver_src_id_ldate_os2 := __common__( common.sas_date((string)(_ver_src_id_ldate_os)) ) ;

yr__ver_src_id_ldate_os := __common__( if(min(sysdate, _ver_src_id_ldate_os2) = NULL, NULL, roundup((sysdate - _ver_src_id_ldate_os2) / 365.25)) ) ;

mth__ver_src_id_ldate_os := __common__( if(min(sysdate, _ver_src_id_ldate_os2) = NULL, NULL, roundup((sysdate - _ver_src_id_ldate_os2) / 30.5)) ) ;

_ver_src_id_p_pos := __common__( Models.Common.findw_cpp(ver_src_id_list, 'P' , '  ,', 'ie') ) ;

_ver_src_id__p := __common__( _ver_src_id_p_pos > 0 ) ;

_ver_src_id_fdate_p := __common__( if(_ver_src_id_p_pos > 0, Models.Common.getw(ver_src_id_firstseen_list, _ver_src_id_p_pos), '0') ) ;

_ver_src_id_fdate_p2 := __common__( common.sas_date((string)(_ver_src_id_fdate_p)) ) ;

yr__ver_src_id_fdate_p := __common__( if(min(sysdate, _ver_src_id_fdate_p2) = NULL, NULL, roundup((sysdate - _ver_src_id_fdate_p2) / 365.25)) ) ;

mth__ver_src_id_fdate_p := __common__( if(min(sysdate, _ver_src_id_fdate_p2) = NULL, NULL, roundup((sysdate - _ver_src_id_fdate_p2) / 30.5)) ) ;

_ver_src_id_ldate_p := __common__( if(_ver_src_id_p_pos > 0, Models.Common.getw(ver_src_id_lastseen_list, _ver_src_id_p_pos), '0') ) ;

_ver_src_id_ldate_p2 := __common__( common.sas_date((string)(_ver_src_id_ldate_p)) ) ;

yr__ver_src_id_ldate_p := __common__( if(min(sysdate, _ver_src_id_ldate_p2) = NULL, NULL, roundup((sysdate - _ver_src_id_ldate_p2) / 365.25)) ) ;

mth__ver_src_id_ldate_p := __common__( if(min(sysdate, _ver_src_id_ldate_p2) = NULL, NULL, roundup((sysdate - _ver_src_id_ldate_p2) / 30.5)) ) ;

_ver_src_id_pl_pos := __common__( Models.Common.findw_cpp(ver_src_id_list, 'PL' , '  ,', 'ie') ) ;

_ver_src_id__pl := __common__( _ver_src_id_pl_pos > 0 ) ;

_ver_src_id_fdate_pl := __common__( if(_ver_src_id_pl_pos > 0, Models.Common.getw(ver_src_id_firstseen_list, _ver_src_id_pl_pos), '0') ) ;

_ver_src_id_fdate_pl2 := __common__( common.sas_date((string)(_ver_src_id_fdate_pl)) ) ;

yr__ver_src_id_fdate_pl := __common__( if(min(sysdate, _ver_src_id_fdate_pl2) = NULL, NULL, roundup((sysdate - _ver_src_id_fdate_pl2) / 365.25)) ) ;

mth__ver_src_id_fdate_pl := __common__( if(min(sysdate, _ver_src_id_fdate_pl2) = NULL, NULL, roundup((sysdate - _ver_src_id_fdate_pl2) / 30.5)) ) ;

_ver_src_id_ldate_pl := __common__( if(_ver_src_id_pl_pos > 0, Models.Common.getw(ver_src_id_lastseen_list, _ver_src_id_pl_pos), '0') ) ;

_ver_src_id_ldate_pl2 := __common__( common.sas_date((string)(_ver_src_id_ldate_pl)) ) ;

yr__ver_src_id_ldate_pl := __common__( if(min(sysdate, _ver_src_id_ldate_pl2) = NULL, NULL, roundup((sysdate - _ver_src_id_ldate_pl2) / 365.25)) ) ;

mth__ver_src_id_ldate_pl := __common__( if(min(sysdate, _ver_src_id_ldate_pl2) = NULL, NULL, roundup((sysdate - _ver_src_id_ldate_pl2) / 30.5)) ) ;

_ver_src_id_q3_pos := __common__( Models.Common.findw_cpp(ver_src_id_list, 'Q3' , '  ,', 'ie') ) ;

_ver_src_id__q3 := __common__( _ver_src_id_q3_pos > 0 ) ;

_ver_src_id_fdate_q3 := __common__( if(_ver_src_id_q3_pos > 0, Models.Common.getw(ver_src_id_firstseen_list, _ver_src_id_q3_pos), '0') ) ;

_ver_src_id_fdate_q32 := __common__( common.sas_date((string)(_ver_src_id_fdate_q3)) ) ;

yr__ver_src_id_fdate_q3 := __common__( if(min(sysdate, _ver_src_id_fdate_q32) = NULL, NULL, roundup((sysdate - _ver_src_id_fdate_q32) / 365.25)) ) ;

mth__ver_src_id_fdate_q3 := __common__( if(min(sysdate, _ver_src_id_fdate_q32) = NULL, NULL, roundup((sysdate - _ver_src_id_fdate_q32) / 30.5)) ) ;

_ver_src_id_ldate_q3 := __common__( if(_ver_src_id_q3_pos > 0, Models.Common.getw(ver_src_id_lastseen_list, _ver_src_id_q3_pos), '0') ) ;

_ver_src_id_ldate_q32 := __common__( common.sas_date((string)(_ver_src_id_ldate_q3)) ) ;

yr__ver_src_id_ldate_q3 := __common__( if(min(sysdate, _ver_src_id_ldate_q32) = NULL, NULL, roundup((sysdate - _ver_src_id_ldate_q32) / 365.25)) ) ;

mth__ver_src_id_ldate_q3 := __common__( if(min(sysdate, _ver_src_id_ldate_q32) = NULL, NULL, roundup((sysdate - _ver_src_id_ldate_q32) / 30.5)) ) ;

_ver_src_id_sk_pos := __common__( Models.Common.findw_cpp(ver_src_id_list, 'SK' , '  ,', 'ie') ) ;

_ver_src_id__sk := __common__( _ver_src_id_sk_pos > 0 ) ;

_ver_src_id_fdate_sk := __common__( if(_ver_src_id_sk_pos > 0, Models.Common.getw(ver_src_id_firstseen_list, _ver_src_id_sk_pos), '0') ) ;

_ver_src_id_fdate_sk2 := __common__( common.sas_date((string)(_ver_src_id_fdate_sk)) ) ;

yr__ver_src_id_fdate_sk := __common__( if(min(sysdate, _ver_src_id_fdate_sk2) = NULL, NULL, roundup((sysdate - _ver_src_id_fdate_sk2) / 365.25)) ) ;

mth__ver_src_id_fdate_sk := __common__( if(min(sysdate, _ver_src_id_fdate_sk2) = NULL, NULL, roundup((sysdate - _ver_src_id_fdate_sk2) / 30.5)) ) ;

_ver_src_id_ldate_sk := __common__( if(_ver_src_id_sk_pos > 0, Models.Common.getw(ver_src_id_lastseen_list, _ver_src_id_sk_pos), '0') ) ;

_ver_src_id_ldate_sk2 := __common__( common.sas_date((string)(_ver_src_id_ldate_sk)) ) ;

yr__ver_src_id_ldate_sk := __common__( if(min(sysdate, _ver_src_id_ldate_sk2) = NULL, NULL, roundup((sysdate - _ver_src_id_ldate_sk2) / 365.25)) ) ;

mth__ver_src_id_ldate_sk := __common__( if(min(sysdate, _ver_src_id_ldate_sk2) = NULL, NULL, roundup((sysdate - _ver_src_id_ldate_sk2) / 30.5)) ) ;

_ver_src_id_tx_pos := __common__( Models.Common.findw_cpp(ver_src_id_list, 'TX' , '  ,', 'ie') ) ;

_ver_src_id__tx := __common__( _ver_src_id_tx_pos > 0 ) ;

_ver_src_id_fdate_tx := __common__( if(_ver_src_id_tx_pos > 0, Models.Common.getw(ver_src_id_firstseen_list, _ver_src_id_tx_pos), '0') ) ;

_ver_src_id_fdate_tx2 := __common__( common.sas_date((string)(_ver_src_id_fdate_tx)) ) ;

yr__ver_src_id_fdate_tx := __common__( if(min(sysdate, _ver_src_id_fdate_tx2) = NULL, NULL, roundup((sysdate - _ver_src_id_fdate_tx2) / 365.25)) ) ;

mth__ver_src_id_fdate_tx := __common__( if(min(sysdate, _ver_src_id_fdate_tx2) = NULL, NULL, roundup((sysdate - _ver_src_id_fdate_tx2) / 30.5)) ) ;

_ver_src_id_ldate_tx := __common__( if(_ver_src_id_tx_pos > 0, Models.Common.getw(ver_src_id_lastseen_list, _ver_src_id_tx_pos), '0') ) ;

_ver_src_id_ldate_tx2 := __common__( common.sas_date((string)(_ver_src_id_ldate_tx)) ) ;

yr__ver_src_id_ldate_tx := __common__( if(min(sysdate, _ver_src_id_ldate_tx2) = NULL, NULL, roundup((sysdate - _ver_src_id_ldate_tx2) / 365.25)) ) ;

mth__ver_src_id_ldate_tx := __common__( if(min(sysdate, _ver_src_id_ldate_tx2) = NULL, NULL, roundup((sysdate - _ver_src_id_ldate_tx2) / 30.5)) ) ;

_ver_src_id_v2_pos := __common__( Models.Common.findw_cpp(ver_src_id_list, 'V2' , '  ,', 'ie') ) ;

_ver_src_id__v2 := __common__( _ver_src_id_v2_pos > 0 ) ;

_ver_src_id_fdate_v2_1 := __common__( if(_ver_src_id_v2_pos > 0, Models.Common.getw(ver_src_id_firstseen_list, _ver_src_id_v2_pos), '0') ) ;

_ver_src_id_fdate_v22 := __common__( common.sas_date((string)(_ver_src_id_fdate_v2_1)) ) ;

yr__ver_src_id_fdate_v2 := __common__( if(min(sysdate, _ver_src_id_fdate_v22) = NULL, NULL, (sysdate - _ver_src_id_fdate_v22) / 365.25) ) ;

mth__ver_src_id_fdate_v2 := __common__( if(min(sysdate, _ver_src_id_fdate_v22) = NULL, NULL, roundup((sysdate - _ver_src_id_fdate_v22) / 30.5)) ) ;

_ver_src_id_ldate_v2_1 := __common__( if(_ver_src_id_v2_pos > 0, Models.Common.getw(ver_src_id_lastseen_list, _ver_src_id_v2_pos), '0') ) ;

_ver_src_id_ldate_v22 := __common__( common.sas_date((string)(_ver_src_id_ldate_v2_1)) ) ;

yr__ver_src_id_ldate_v2 := __common__( if(min(sysdate, _ver_src_id_ldate_v22) = NULL, NULL, (sysdate - _ver_src_id_ldate_v22) / 365.25) ) ;

mth__ver_src_id_ldate_v2 := __common__( if(min(sysdate, _ver_src_id_ldate_v22) = NULL, NULL, roundup((sysdate - _ver_src_id_ldate_v22) / 30.5)) ) ;

_ver_src_id_wa_pos := __common__( Models.Common.findw_cpp(ver_src_id_list, 'WA' , '  ,', 'ie') ) ;

_ver_src_id__wa := __common__( _ver_src_id_wa_pos > 0 ) ;

_ver_src_id_fdate_wa := __common__( if(_ver_src_id_wa_pos > 0, Models.Common.getw(ver_src_id_firstseen_list, _ver_src_id_wa_pos), '0') ) ;

_ver_src_id_fdate_wa2 := __common__( common.sas_date((string)(_ver_src_id_fdate_wa)) ) ;

yr__ver_src_id_fdate_wa := __common__( if(min(sysdate, _ver_src_id_fdate_wa2) = NULL, NULL, (sysdate - _ver_src_id_fdate_wa2) / 365.25) ) ;

mth__ver_src_id_fdate_wa := __common__( if(min(sysdate, _ver_src_id_fdate_wa2) = NULL, NULL, roundup((sysdate - _ver_src_id_fdate_wa2) / 30.5)) ) ;

_ver_src_id_ldate_wa := __common__( if(_ver_src_id_wa_pos > 0, Models.Common.getw(ver_src_id_lastseen_list, _ver_src_id_wa_pos), '0') ) ;

_ver_src_id_ldate_wa2 := __common__( common.sas_date((string)(_ver_src_id_ldate_wa)) ) ;

yr__ver_src_id_ldate_wa := __common__( if(min(sysdate, _ver_src_id_ldate_wa2) = NULL, NULL, (sysdate - _ver_src_id_ldate_wa2) / 365.25) ) ;

mth__ver_src_id_ldate_wa := __common__( if(min(sysdate, _ver_src_id_ldate_wa2) = NULL, NULL, roundup((sysdate - _ver_src_id_ldate_wa2) / 30.5)) ) ;

_ver_src_id_by_pos := __common__( Models.Common.findw_cpp(ver_src_id_list, 'BY' , '  ,', 'ie') ) ;

_ver_src_id__by := __common__( _ver_src_id_by_pos > 0 ) ;

_ver_src_id_fdate_by := __common__( if(_ver_src_id_by_pos > 0, Models.Common.getw(ver_src_id_firstseen_list, _ver_src_id_by_pos), '0') ) ;

_ver_src_id_fdate_by2 := __common__( common.sas_date((string)(_ver_src_id_fdate_by)) ) ;

yr__ver_src_id_fdate_by := __common__( if(min(sysdate, _ver_src_id_fdate_by2) = NULL, NULL, (sysdate - _ver_src_id_fdate_by2) / 365.25) ) ;

mth__ver_src_id_fdate_by := __common__( if(min(sysdate, _ver_src_id_fdate_by2) = NULL, NULL, roundup((sysdate - _ver_src_id_fdate_by2) / 30.5)) ) ;

_ver_src_id_ldate_by := __common__( if(_ver_src_id_by_pos > 0, Models.Common.getw(ver_src_id_lastseen_list, _ver_src_id_by_pos), '0') ) ;

_ver_src_id_ldate_by2 := __common__( common.sas_date((string)(_ver_src_id_ldate_by)) ) ;

yr__ver_src_id_ldate_by := __common__( if(min(sysdate, _ver_src_id_ldate_by2) = NULL, NULL, (sysdate - _ver_src_id_ldate_by2) / 365.25) ) ;

mth__ver_src_id_ldate_by := __common__( if(min(sysdate, _ver_src_id_ldate_by2) = NULL, NULL, roundup((sysdate - _ver_src_id_ldate_by2) / 30.5)) ) ;

_ver_src_id_cf_pos := __common__( Models.Common.findw_cpp(ver_src_id_list, 'CF' , '  ,', 'ie') ) ;

_ver_src_id__cf := __common__( _ver_src_id_cf_pos > 0 ) ;

_ver_src_id_fdate_cf := __common__( if(_ver_src_id_cf_pos > 0, Models.Common.getw(ver_src_id_firstseen_list, _ver_src_id_cf_pos), '0') ) ;

_ver_src_id_fdate_cf2 := __common__( common.sas_date((string)(_ver_src_id_fdate_cf)) ) ;

yr__ver_src_id_fdate_cf := __common__( if(min(sysdate, _ver_src_id_fdate_cf2) = NULL, NULL, (sysdate - _ver_src_id_fdate_cf2) / 365.25) ) ;

mth__ver_src_id_fdate_cf := __common__( if(min(sysdate, _ver_src_id_fdate_cf2) = NULL, NULL, roundup((sysdate - _ver_src_id_fdate_cf2) / 30.5)) ) ;

_ver_src_id_ldate_cf := __common__( if(_ver_src_id_cf_pos > 0, Models.Common.getw(ver_src_id_lastseen_list, _ver_src_id_cf_pos), '0') ) ;

_ver_src_id_ldate_cf2 := __common__( common.sas_date((string)(_ver_src_id_ldate_cf)) ) ;

yr__ver_src_id_ldate_cf := __common__( if(min(sysdate, _ver_src_id_ldate_cf2) = NULL, NULL, (sysdate - _ver_src_id_ldate_cf2) / 365.25) ) ;

mth__ver_src_id_ldate_cf := __common__( if(min(sysdate, _ver_src_id_ldate_cf2) = NULL, NULL, roundup((sysdate - _ver_src_id_ldate_cf2) / 30.5)) ) ;

_ver_src_id_e_pos := __common__( Models.Common.findw_cpp(ver_src_id_list, 'E' , '  ,', 'ie') ) ;

_ver_src_id__e := __common__( _ver_src_id_e_pos > 0 ) ;

_ver_src_id_fdate_e := __common__( if(_ver_src_id_e_pos > 0, Models.Common.getw(ver_src_id_firstseen_list, _ver_src_id_e_pos), '0') ) ;

_ver_src_id_fdate_e2 := __common__( common.sas_date((string)(_ver_src_id_fdate_e)) ) ;

yr__ver_src_id_fdate_e := __common__( if(min(sysdate, _ver_src_id_fdate_e2) = NULL, NULL, (sysdate - _ver_src_id_fdate_e2) / 365.25) ) ;

mth__ver_src_id_fdate_e := __common__( if(min(sysdate, _ver_src_id_fdate_e2) = NULL, NULL, roundup((sysdate - _ver_src_id_fdate_e2) / 30.5)) ) ;

_ver_src_id_ldate_e := __common__( if(_ver_src_id_e_pos > 0, Models.Common.getw(ver_src_id_lastseen_list, _ver_src_id_e_pos), '0') ) ;

_ver_src_id_ldate_e2 := __common__( common.sas_date((string)(_ver_src_id_ldate_e)) ) ;

yr__ver_src_id_ldate_e := __common__( if(min(sysdate, _ver_src_id_ldate_e2) = NULL, NULL, (sysdate - _ver_src_id_ldate_e2) / 365.25) ) ;

mth__ver_src_id_ldate_e := __common__( if(min(sysdate, _ver_src_id_ldate_e2) = NULL, NULL, roundup((sysdate - _ver_src_id_ldate_e2) / 30.5)) ) ;

_ver_src_id_ey_pos := __common__( Models.Common.findw_cpp(ver_src_id_list, 'EY' , '  ,', 'ie') ) ;

_ver_src_id__ey := __common__( _ver_src_id_ey_pos > 0 ) ;

_ver_src_id_fdate_ey := __common__( if(_ver_src_id_ey_pos > 0, Models.Common.getw(ver_src_id_firstseen_list, _ver_src_id_ey_pos), '0') ) ;

_ver_src_id_fdate_ey2 := __common__( common.sas_date((string)(_ver_src_id_fdate_ey)) ) ;

yr__ver_src_id_fdate_ey := __common__( if(min(sysdate, _ver_src_id_fdate_ey2) = NULL, NULL, (sysdate - _ver_src_id_fdate_ey2) / 365.25) ) ;

mth__ver_src_id_fdate_ey := __common__( if(min(sysdate, _ver_src_id_fdate_ey2) = NULL, NULL, roundup((sysdate - _ver_src_id_fdate_ey2) / 30.5)) ) ;

_ver_src_id_ldate_ey := __common__( if(_ver_src_id_ey_pos > 0, Models.Common.getw(ver_src_id_lastseen_list, _ver_src_id_ey_pos), '0') ) ;

_ver_src_id_ldate_ey2 := __common__( common.sas_date((string)(_ver_src_id_ldate_ey)) ) ;

yr__ver_src_id_ldate_ey := __common__( if(min(sysdate, _ver_src_id_ldate_ey2) = NULL, NULL, (sysdate - _ver_src_id_ldate_ey2) / 365.25) ) ;

mth__ver_src_id_ldate_ey := __common__( if(min(sysdate, _ver_src_id_ldate_ey2) = NULL, NULL, roundup((sysdate - _ver_src_id_ldate_ey2) / 30.5)) ) ;

_ver_src_id_f_pos := __common__( Models.Common.findw_cpp(ver_src_id_list, 'F' , '  ,', 'ie') ) ;

_ver_src_id__f := __common__( _ver_src_id_f_pos > 0 ) ;

_ver_src_id_fdate_f := __common__( if(_ver_src_id_f_pos > 0, Models.Common.getw(ver_src_id_firstseen_list, _ver_src_id_f_pos), '0') ) ;

_ver_src_id_fdate_f2 := __common__( common.sas_date((string)(_ver_src_id_fdate_f)) ) ;

yr__ver_src_id_fdate_f := __common__( if(min(sysdate, _ver_src_id_fdate_f2) = NULL, NULL, (sysdate - _ver_src_id_fdate_f2) / 365.25) ) ;

mth__ver_src_id_fdate_f := __common__( if(min(sysdate, _ver_src_id_fdate_f2) = NULL, NULL, roundup((sysdate - _ver_src_id_fdate_f2) / 30.5)) ) ;

_ver_src_id_ldate_f := __common__( if(_ver_src_id_f_pos > 0, Models.Common.getw(ver_src_id_lastseen_list, _ver_src_id_f_pos), '0') ) ;

_ver_src_id_ldate_f2 := __common__( common.sas_date((string)(_ver_src_id_ldate_f)) ) ;

yr__ver_src_id_ldate_f := __common__( if(min(sysdate, _ver_src_id_ldate_f2) = NULL, NULL, (sysdate - _ver_src_id_ldate_f2) / 365.25) ) ;

mth__ver_src_id_ldate_f := __common__( if(min(sysdate, _ver_src_id_ldate_f2) = NULL, NULL, roundup((sysdate - _ver_src_id_ldate_f2) / 30.5)) ) ;

_ver_src_id_fk_pos := __common__( Models.Common.findw_cpp(ver_src_id_list, 'FK' , '  ,', 'ie') ) ;

_ver_src_id__fk := __common__( _ver_src_id_fk_pos > 0 ) ;

_ver_src_id_fdate_fk := __common__( if(_ver_src_id_fk_pos > 0, Models.Common.getw(ver_src_id_firstseen_list, _ver_src_id_fk_pos), '0') ) ;

_ver_src_id_fdate_fk2 := __common__( common.sas_date((string)(_ver_src_id_fdate_fk)) ) ;

yr__ver_src_id_fdate_fk := __common__( if(min(sysdate, _ver_src_id_fdate_fk2) = NULL, NULL, (sysdate - _ver_src_id_fdate_fk2) / 365.25) ) ;

mth__ver_src_id_fdate_fk := __common__( if(min(sysdate, _ver_src_id_fdate_fk2) = NULL, NULL, roundup((sysdate - _ver_src_id_fdate_fk2) / 30.5)) ) ;

_ver_src_id_ldate_fk := __common__( if(_ver_src_id_fk_pos > 0, Models.Common.getw(ver_src_id_lastseen_list, _ver_src_id_fk_pos), '0') ) ;

_ver_src_id_ldate_fk2 := __common__( common.sas_date((string)(_ver_src_id_ldate_fk)) ) ;

yr__ver_src_id_ldate_fk := __common__( if(min(sysdate, _ver_src_id_ldate_fk2) = NULL, NULL, (sysdate - _ver_src_id_ldate_fk2) / 365.25) ) ;

mth__ver_src_id_ldate_fk := __common__( if(min(sysdate, _ver_src_id_ldate_fk2) = NULL, NULL, roundup((sysdate - _ver_src_id_ldate_fk2) / 30.5)) ) ;

_ver_src_id_fr_pos := __common__( Models.Common.findw_cpp(ver_src_id_list, 'FR' , '  ,', 'ie') ) ;

_ver_src_id__fr := __common__( _ver_src_id_fr_pos > 0 ) ;

_ver_src_id_fdate_fr := __common__( if(_ver_src_id_fr_pos > 0, Models.Common.getw(ver_src_id_firstseen_list, _ver_src_id_fr_pos), '0') ) ;

_ver_src_id_fdate_fr2 := __common__( common.sas_date((string)(_ver_src_id_fdate_fr)) ) ;

yr__ver_src_id_fdate_fr := __common__( if(min(sysdate, _ver_src_id_fdate_fr2) = NULL, NULL, (sysdate - _ver_src_id_fdate_fr2) / 365.25) ) ;

mth__ver_src_id_fdate_fr := __common__( if(min(sysdate, _ver_src_id_fdate_fr2) = NULL, NULL, roundup((sysdate - _ver_src_id_fdate_fr2) / 30.5)) ) ;

_ver_src_id_ldate_fr := __common__( if(_ver_src_id_fr_pos > 0, Models.Common.getw(ver_src_id_lastseen_list, _ver_src_id_fr_pos), '0') ) ;

_ver_src_id_ldate_fr2 := __common__( common.sas_date((string)(_ver_src_id_ldate_fr)) ) ;

yr__ver_src_id_ldate_fr := __common__( if(min(sysdate, _ver_src_id_ldate_fr2) = NULL, NULL, (sysdate - _ver_src_id_ldate_fr2) / 365.25) ) ;

mth__ver_src_id_ldate_fr := __common__( if(min(sysdate, _ver_src_id_ldate_fr2) = NULL, NULL, roundup((sysdate - _ver_src_id_ldate_fr2) / 30.5)) ) ;

_ver_src_id_ft_pos := __common__( Models.Common.findw_cpp(ver_src_id_list, 'FT' , '  ,', 'ie') ) ;

_ver_src_id__ft := __common__( _ver_src_id_ft_pos > 0 ) ;

_ver_src_id_fdate_ft := __common__( if(_ver_src_id_ft_pos > 0, Models.Common.getw(ver_src_id_firstseen_list, _ver_src_id_ft_pos), '0') ) ;

_ver_src_id_fdate_ft2 := __common__( common.sas_date((string)(_ver_src_id_fdate_ft)) ) ;

yr__ver_src_id_fdate_ft := __common__( if(min(sysdate, _ver_src_id_fdate_ft2) = NULL, NULL, (sysdate - _ver_src_id_fdate_ft2) / 365.25) ) ;

mth__ver_src_id_fdate_ft := __common__( if(min(sysdate, _ver_src_id_fdate_ft2) = NULL, NULL, roundup((sysdate - _ver_src_id_fdate_ft2) / 30.5)) ) ;

_ver_src_id_ldate_ft := __common__( if(_ver_src_id_ft_pos > 0, Models.Common.getw(ver_src_id_lastseen_list, _ver_src_id_ft_pos), '0') ) ;

_ver_src_id_ldate_ft2 := __common__( common.sas_date((string)(_ver_src_id_ldate_ft)) ) ;

yr__ver_src_id_ldate_ft := __common__( if(min(sysdate, _ver_src_id_ldate_ft2) = NULL, NULL, (sysdate - _ver_src_id_ldate_ft2) / 365.25) ) ;

mth__ver_src_id_ldate_ft := __common__( if(min(sysdate, _ver_src_id_ldate_ft2) = NULL, NULL, roundup((sysdate - _ver_src_id_ldate_ft2) / 30.5)) ) ;

_ver_src_id_gr_pos := __common__( Models.Common.findw_cpp(ver_src_id_list, 'GR' , '  ,', 'ie') ) ;

_ver_src_id__gr := __common__( _ver_src_id_gr_pos > 0 ) ;

_ver_src_id_fdate_gr := __common__( if(_ver_src_id_gr_pos > 0, Models.Common.getw(ver_src_id_firstseen_list, _ver_src_id_gr_pos), '0') ) ;

_ver_src_id_fdate_gr2 := __common__( common.sas_date((string)(_ver_src_id_fdate_gr)) ) ;

yr__ver_src_id_fdate_gr := __common__( if(min(sysdate, _ver_src_id_fdate_gr2) = NULL, NULL, (sysdate - _ver_src_id_fdate_gr2) / 365.25) ) ;

mth__ver_src_id_fdate_gr := __common__( if(min(sysdate, _ver_src_id_fdate_gr2) = NULL, NULL, roundup((sysdate - _ver_src_id_fdate_gr2) / 30.5)) ) ;

_ver_src_id_ldate_gr := __common__( if(_ver_src_id_gr_pos > 0, Models.Common.getw(ver_src_id_lastseen_list, _ver_src_id_gr_pos), '0') ) ;

_ver_src_id_ldate_gr2 := __common__( common.sas_date((string)(_ver_src_id_ldate_gr)) ) ;

yr__ver_src_id_ldate_gr := __common__( if(min(sysdate, _ver_src_id_ldate_gr2) = NULL, NULL, (sysdate - _ver_src_id_ldate_gr2) / 365.25) ) ;

mth__ver_src_id_ldate_gr := __common__( if(min(sysdate, _ver_src_id_ldate_gr2) = NULL, NULL, roundup((sysdate - _ver_src_id_ldate_gr2) / 30.5)) ) ;

_ver_src_id_h7_pos := __common__( Models.Common.findw_cpp(ver_src_id_list, 'H7' , '  ,', 'ie') ) ;

_ver_src_id__h7 := __common__( _ver_src_id_h7_pos > 0 ) ;

_ver_src_id_fdate_h7 := __common__( if(_ver_src_id_h7_pos > 0, Models.Common.getw(ver_src_id_firstseen_list, _ver_src_id_h7_pos), '0') ) ;

_ver_src_id_fdate_h72 := __common__( common.sas_date((string)(_ver_src_id_fdate_h7)) ) ;

yr__ver_src_id_fdate_h7 := __common__( if(min(sysdate, _ver_src_id_fdate_h72) = NULL, NULL, (sysdate - _ver_src_id_fdate_h72) / 365.25) ) ;

mth__ver_src_id_fdate_h7 := __common__( if(min(sysdate, _ver_src_id_fdate_h72) = NULL, NULL, roundup((sysdate - _ver_src_id_fdate_h72) / 30.5)) ) ;

_ver_src_id_ldate_h7 := __common__( if(_ver_src_id_h7_pos > 0, Models.Common.getw(ver_src_id_lastseen_list, _ver_src_id_h7_pos), '0') ) ;

_ver_src_id_ldate_h72 := __common__( common.sas_date((string)(_ver_src_id_ldate_h7)) ) ;

yr__ver_src_id_ldate_h7 := __common__( if(min(sysdate, _ver_src_id_ldate_h72) = NULL, NULL, (sysdate - _ver_src_id_ldate_h72) / 365.25) ) ;

mth__ver_src_id_ldate_h7 := __common__( if(min(sysdate, _ver_src_id_ldate_h72) = NULL, NULL, roundup((sysdate - _ver_src_id_ldate_h72) / 30.5)) ) ;

_ver_src_id_ic_pos := __common__( Models.Common.findw_cpp(ver_src_id_list, 'IC' , '  ,', 'ie') ) ;

_ver_src_id__ic := __common__( _ver_src_id_ic_pos > 0 ) ;

_ver_src_id_fdate_ic := __common__( if(_ver_src_id_ic_pos > 0, Models.Common.getw(ver_src_id_firstseen_list, _ver_src_id_ic_pos), '0') ) ;

_ver_src_id_fdate_ic2 := __common__( common.sas_date((string)(_ver_src_id_fdate_ic)) ) ;

yr__ver_src_id_fdate_ic := __common__( if(min(sysdate, _ver_src_id_fdate_ic2) = NULL, NULL, (sysdate - _ver_src_id_fdate_ic2) / 365.25) ) ;

mth__ver_src_id_fdate_ic := __common__( if(min(sysdate, _ver_src_id_fdate_ic2) = NULL, NULL, roundup((sysdate - _ver_src_id_fdate_ic2) / 30.5)) ) ;

_ver_src_id_ldate_ic := __common__( if(_ver_src_id_ic_pos > 0, Models.Common.getw(ver_src_id_lastseen_list, _ver_src_id_ic_pos), '0') ) ;

_ver_src_id_ldate_ic2 := __common__( common.sas_date((string)(_ver_src_id_ldate_ic)) ) ;

yr__ver_src_id_ldate_ic := __common__( if(min(sysdate, _ver_src_id_ldate_ic2) = NULL, NULL, (sysdate - _ver_src_id_ldate_ic2) / 365.25) ) ;

mth__ver_src_id_ldate_ic := __common__( if(min(sysdate, _ver_src_id_ldate_ic2) = NULL, NULL, roundup((sysdate - _ver_src_id_ldate_ic2) / 30.5)) ) ;

_ver_src_id_ip_pos := __common__( Models.Common.findw_cpp(ver_src_id_list, 'IP' , '  ,', 'ie') ) ;

_ver_src_id__ip := __common__( _ver_src_id_ip_pos > 0 ) ;

_ver_src_id_fdate_ip := __common__( if(_ver_src_id_ip_pos > 0, Models.Common.getw(ver_src_id_firstseen_list, _ver_src_id_ip_pos), '0') ) ;

_ver_src_id_fdate_ip2 := __common__( common.sas_date((string)(_ver_src_id_fdate_ip)) ) ;

yr__ver_src_id_fdate_ip := __common__( if(min(sysdate, _ver_src_id_fdate_ip2) = NULL, NULL, (sysdate - _ver_src_id_fdate_ip2) / 365.25) ) ;

mth__ver_src_id_fdate_ip := __common__( if(min(sysdate, _ver_src_id_fdate_ip2) = NULL, NULL, roundup((sysdate - _ver_src_id_fdate_ip2) / 30.5)) ) ;

_ver_src_id_ldate_ip := __common__( if(_ver_src_id_ip_pos > 0, Models.Common.getw(ver_src_id_lastseen_list, _ver_src_id_ip_pos), '0') ) ;

_ver_src_id_ldate_ip2 := __common__( common.sas_date((string)(_ver_src_id_ldate_ip)) ) ;

yr__ver_src_id_ldate_ip := __common__( if(min(sysdate, _ver_src_id_ldate_ip2) = NULL, NULL, (sysdate - _ver_src_id_ldate_ip2) / 365.25) ) ;

mth__ver_src_id_ldate_ip := __common__( if(min(sysdate, _ver_src_id_ldate_ip2) = NULL, NULL, roundup((sysdate - _ver_src_id_ldate_ip2) / 30.5)) ) ;

_ver_src_id_is_pos := __common__( Models.Common.findw_cpp(ver_src_id_list, 'IS' , '  ,', 'ie') ) ;

_ver_src_id__is := __common__( _ver_src_id_is_pos > 0 ) ;

_ver_src_id_fdate_is := __common__( if(_ver_src_id_is_pos > 0, Models.Common.getw(ver_src_id_firstseen_list, _ver_src_id_is_pos), '0') ) ;

_ver_src_id_fdate_is2 := __common__( common.sas_date((string)(_ver_src_id_fdate_is)) ) ;

yr__ver_src_id_fdate_is := __common__( if(min(sysdate, _ver_src_id_fdate_is2) = NULL, NULL, (sysdate - _ver_src_id_fdate_is2) / 365.25) ) ;

mth__ver_src_id_fdate_is := __common__( if(min(sysdate, _ver_src_id_fdate_is2) = NULL, NULL, roundup((sysdate - _ver_src_id_fdate_is2) / 30.5)) ) ;

_ver_src_id_ldate_is := __common__( if(_ver_src_id_is_pos > 0, Models.Common.getw(ver_src_id_lastseen_list, _ver_src_id_is_pos), '0') ) ;

_ver_src_id_ldate_is2 := __common__( common.sas_date((string)(_ver_src_id_ldate_is)) ) ;

yr__ver_src_id_ldate_is := __common__( if(min(sysdate, _ver_src_id_ldate_is2) = NULL, NULL, (sysdate - _ver_src_id_ldate_is2) / 365.25) ) ;

mth__ver_src_id_ldate_is := __common__( if(min(sysdate, _ver_src_id_ldate_is2) = NULL, NULL, roundup((sysdate - _ver_src_id_ldate_is2) / 30.5)) ) ;

_ver_src_id_it_pos := __common__( Models.Common.findw_cpp(ver_src_id_list, 'IT' , '  ,', 'ie') ) ;

_ver_src_id__it := __common__( _ver_src_id_it_pos > 0 ) ;

_ver_src_id_fdate_it := __common__( if(_ver_src_id_it_pos > 0, Models.Common.getw(ver_src_id_firstseen_list, _ver_src_id_it_pos), '0') ) ;

_ver_src_id_fdate_it2 := __common__( common.sas_date((string)(_ver_src_id_fdate_it)) ) ;

yr__ver_src_id_fdate_it := __common__( if(min(sysdate, _ver_src_id_fdate_it2) = NULL, NULL, (sysdate - _ver_src_id_fdate_it2) / 365.25) ) ;

mth__ver_src_id_fdate_it := __common__( if(min(sysdate, _ver_src_id_fdate_it2) = NULL, NULL, roundup((sysdate - _ver_src_id_fdate_it2) / 30.5)) ) ;

_ver_src_id_ldate_it := __common__( if(_ver_src_id_it_pos > 0, Models.Common.getw(ver_src_id_lastseen_list, _ver_src_id_it_pos), '0') ) ;

_ver_src_id_ldate_it2 := __common__( common.sas_date((string)(_ver_src_id_ldate_it)) ) ;

yr__ver_src_id_ldate_it := __common__( if(min(sysdate, _ver_src_id_ldate_it2) = NULL, NULL, (sysdate - _ver_src_id_ldate_it2) / 365.25) ) ;

mth__ver_src_id_ldate_it := __common__( if(min(sysdate, _ver_src_id_ldate_it2) = NULL, NULL, roundup((sysdate - _ver_src_id_ldate_it2) / 30.5)) ) ;

_ver_src_id_j2_pos := __common__( Models.Common.findw_cpp(ver_src_id_list, 'J2' , '  ,', 'ie') ) ;

_ver_src_id__j2 := __common__( _ver_src_id_j2_pos > 0 ) ;

_ver_src_id_fdate_j2 := __common__( if(_ver_src_id_j2_pos > 0, Models.Common.getw(ver_src_id_firstseen_list, _ver_src_id_j2_pos), '0') ) ;

_ver_src_id_fdate_j22 := __common__( common.sas_date((string)(_ver_src_id_fdate_j2)) ) ;

yr__ver_src_id_fdate_j2 := __common__( if(min(sysdate, _ver_src_id_fdate_j22) = NULL, NULL, (sysdate - _ver_src_id_fdate_j22) / 365.25) ) ;

mth__ver_src_id_fdate_j2 := __common__( if(min(sysdate, _ver_src_id_fdate_j22) = NULL, NULL, roundup((sysdate - _ver_src_id_fdate_j22) / 30.5)) ) ;

_ver_src_id_ldate_j2 := __common__( if(_ver_src_id_j2_pos > 0, Models.Common.getw(ver_src_id_lastseen_list, _ver_src_id_j2_pos), '0') ) ;

_ver_src_id_ldate_j22 := __common__( common.sas_date((string)(_ver_src_id_ldate_j2)) ) ;

yr__ver_src_id_ldate_j2 := __common__( if(min(sysdate, _ver_src_id_ldate_j22) = NULL, NULL, (sysdate - _ver_src_id_ldate_j22) / 365.25) ) ;

mth__ver_src_id_ldate_j2 := __common__( if(min(sysdate, _ver_src_id_ldate_j22) = NULL, NULL, roundup((sysdate - _ver_src_id_ldate_j22) / 30.5)) ) ;

_ver_src_id_kc_pos := __common__( Models.Common.findw_cpp(ver_src_id_list, 'KC' , '  ,', 'ie') ) ;

_ver_src_id__kc := __common__( _ver_src_id_kc_pos > 0 ) ;

_ver_src_id_fdate_kc := __common__( if(_ver_src_id_kc_pos > 0, Models.Common.getw(ver_src_id_firstseen_list, _ver_src_id_kc_pos), '0') ) ;

_ver_src_id_fdate_kc2 := __common__( common.sas_date((string)(_ver_src_id_fdate_kc)) ) ;

yr__ver_src_id_fdate_kc := __common__( if(min(sysdate, _ver_src_id_fdate_kc2) = NULL, NULL, (sysdate - _ver_src_id_fdate_kc2) / 365.25) ) ;

mth__ver_src_id_fdate_kc := __common__( if(min(sysdate, _ver_src_id_fdate_kc2) = NULL, NULL, roundup((sysdate - _ver_src_id_fdate_kc2) / 30.5)) ) ;

_ver_src_id_ldate_kc := __common__( if(_ver_src_id_kc_pos > 0, Models.Common.getw(ver_src_id_lastseen_list, _ver_src_id_kc_pos), '0') ) ;

_ver_src_id_ldate_kc2 := __common__( common.sas_date((string)(_ver_src_id_ldate_kc)) ) ;

yr__ver_src_id_ldate_kc := __common__( if(min(sysdate, _ver_src_id_ldate_kc2) = NULL, NULL, (sysdate - _ver_src_id_ldate_kc2) / 365.25) ) ;

mth__ver_src_id_ldate_kc := __common__( if(min(sysdate, _ver_src_id_ldate_kc2) = NULL, NULL, roundup((sysdate - _ver_src_id_ldate_kc2) / 30.5)) ) ;

_ver_src_id_mh_pos := __common__( Models.Common.findw_cpp(ver_src_id_list, 'MH' , '  ,', 'ie') ) ;

_ver_src_id__mh := __common__( _ver_src_id_mh_pos > 0 ) ;

_ver_src_id_fdate_mh := __common__( if(_ver_src_id_mh_pos > 0, Models.Common.getw(ver_src_id_firstseen_list, _ver_src_id_mh_pos), '0') ) ;

_ver_src_id_fdate_mh2 := __common__( common.sas_date((string)(_ver_src_id_fdate_mh)) ) ;

yr__ver_src_id_fdate_mh := __common__( if(min(sysdate, _ver_src_id_fdate_mh2) = NULL, NULL, (sysdate - _ver_src_id_fdate_mh2) / 365.25) ) ;

mth__ver_src_id_fdate_mh := __common__( if(min(sysdate, _ver_src_id_fdate_mh2) = NULL, NULL, roundup((sysdate - _ver_src_id_fdate_mh2) / 30.5)) ) ;

_ver_src_id_ldate_mh := __common__( if(_ver_src_id_mh_pos > 0, Models.Common.getw(ver_src_id_lastseen_list, _ver_src_id_mh_pos), '0') ) ;

_ver_src_id_ldate_mh2 := __common__( common.sas_date((string)(_ver_src_id_ldate_mh)) ) ;

yr__ver_src_id_ldate_mh := __common__( if(min(sysdate, _ver_src_id_ldate_mh2) = NULL, NULL, (sysdate - _ver_src_id_ldate_mh2) / 365.25) ) ;

mth__ver_src_id_ldate_mh := __common__( if(min(sysdate, _ver_src_id_ldate_mh2) = NULL, NULL, roundup((sysdate - _ver_src_id_ldate_mh2) / 30.5)) ) ;

_ver_src_id_mw_pos := __common__( Models.Common.findw_cpp(ver_src_id_list, 'MW' , '  ,', 'ie') ) ;

_ver_src_id__mw := __common__( _ver_src_id_mw_pos > 0 ) ;

_ver_src_id_fdate_mw := __common__( if(_ver_src_id_mw_pos > 0, Models.Common.getw(ver_src_id_firstseen_list, _ver_src_id_mw_pos), '0') ) ;

_ver_src_id_fdate_mw2 := __common__( common.sas_date((string)(_ver_src_id_fdate_mw)) ) ;

yr__ver_src_id_fdate_mw := __common__( if(min(sysdate, _ver_src_id_fdate_mw2) = NULL, NULL, (sysdate - _ver_src_id_fdate_mw2) / 365.25) ) ;

mth__ver_src_id_fdate_mw := __common__( if(min(sysdate, _ver_src_id_fdate_mw2) = NULL, NULL, roundup((sysdate - _ver_src_id_fdate_mw2) / 30.5)) ) ;

_ver_src_id_ldate_mw := __common__( if(_ver_src_id_mw_pos > 0, Models.Common.getw(ver_src_id_lastseen_list, _ver_src_id_mw_pos), '0') ) ;

_ver_src_id_ldate_mw2 := __common__( common.sas_date((string)(_ver_src_id_ldate_mw)) ) ;

yr__ver_src_id_ldate_mw := __common__( if(min(sysdate, _ver_src_id_ldate_mw2) = NULL, NULL, (sysdate - _ver_src_id_ldate_mw2) / 365.25) ) ;

mth__ver_src_id_ldate_mw := __common__( if(min(sysdate, _ver_src_id_ldate_mw2) = NULL, NULL, roundup((sysdate - _ver_src_id_ldate_mw2) / 30.5)) ) ;

_ver_src_id_np_pos := __common__( Models.Common.findw_cpp(ver_src_id_list, 'NP' , '  ,', 'ie') ) ;

_ver_src_id__np := __common__( _ver_src_id_np_pos > 0 ) ;

_ver_src_id_fdate_np := __common__( if(_ver_src_id_np_pos > 0, Models.Common.getw(ver_src_id_firstseen_list, _ver_src_id_np_pos), '0') ) ;

_ver_src_id_fdate_np2 := __common__( common.sas_date((string)(_ver_src_id_fdate_np)) ) ;

yr__ver_src_id_fdate_np := __common__( if(min(sysdate, _ver_src_id_fdate_np2) = NULL, NULL, (sysdate - _ver_src_id_fdate_np2) / 365.25) ) ;

mth__ver_src_id_fdate_np := __common__( if(min(sysdate, _ver_src_id_fdate_np2) = NULL, NULL, roundup((sysdate - _ver_src_id_fdate_np2) / 30.5)) ) ;

_ver_src_id_ldate_np := __common__( if(_ver_src_id_np_pos > 0, Models.Common.getw(ver_src_id_lastseen_list, _ver_src_id_np_pos), '0') ) ;

_ver_src_id_ldate_np2 := __common__( common.sas_date((string)(_ver_src_id_ldate_np)) ) ;

yr__ver_src_id_ldate_np := __common__( if(min(sysdate, _ver_src_id_ldate_np2) = NULL, NULL, (sysdate - _ver_src_id_ldate_np2) / 365.25) ) ;

mth__ver_src_id_ldate_np := __common__( if(min(sysdate, _ver_src_id_ldate_np2) = NULL, NULL, roundup((sysdate - _ver_src_id_ldate_np2) / 30.5)) ) ;

_ver_src_id_nr_pos := __common__( Models.Common.findw_cpp(ver_src_id_list, 'NR' , '  ,', 'ie') ) ;

_ver_src_id__nr := __common__( _ver_src_id_nr_pos > 0 ) ;

_ver_src_id_fdate_nr := __common__( if(_ver_src_id_nr_pos > 0, Models.Common.getw(ver_src_id_firstseen_list, _ver_src_id_nr_pos), '0') ) ;

_ver_src_id_fdate_nr2 := __common__( common.sas_date((string)(_ver_src_id_fdate_nr)) ) ;

yr__ver_src_id_fdate_nr := __common__( if(min(sysdate, _ver_src_id_fdate_nr2) = NULL, NULL, (sysdate - _ver_src_id_fdate_nr2) / 365.25) ) ;

mth__ver_src_id_fdate_nr := __common__( if(min(sysdate, _ver_src_id_fdate_nr2) = NULL, NULL, roundup((sysdate - _ver_src_id_fdate_nr2) / 30.5)) ) ;

_ver_src_id_ldate_nr := __common__( if(_ver_src_id_nr_pos > 0, Models.Common.getw(ver_src_id_lastseen_list, _ver_src_id_nr_pos), '0') ) ;

_ver_src_id_ldate_nr2 := __common__( common.sas_date((string)(_ver_src_id_ldate_nr)) ) ;

yr__ver_src_id_ldate_nr := __common__( if(min(sysdate, _ver_src_id_ldate_nr2) = NULL, NULL, (sysdate - _ver_src_id_ldate_nr2) / 365.25) ) ;

mth__ver_src_id_ldate_nr := __common__( if(min(sysdate, _ver_src_id_ldate_nr2) = NULL, NULL, roundup((sysdate - _ver_src_id_ldate_nr2) / 30.5)) ) ;

_ver_src_id_sa_pos := __common__( Models.Common.findw_cpp(ver_src_id_list, 'SA' , '  ,', 'ie') ) ;

_ver_src_id__sa := __common__( _ver_src_id_sa_pos > 0 ) ;

_ver_src_id_fdate_sa := __common__( if(_ver_src_id_sa_pos > 0, Models.Common.getw(ver_src_id_firstseen_list, _ver_src_id_sa_pos), '0') ) ;

_ver_src_id_fdate_sa2 := __common__( common.sas_date((string)(_ver_src_id_fdate_sa)) ) ;

yr__ver_src_id_fdate_sa := __common__( if(min(sysdate, _ver_src_id_fdate_sa2) = NULL, NULL, (sysdate - _ver_src_id_fdate_sa2) / 365.25) ) ;

mth__ver_src_id_fdate_sa := __common__( if(min(sysdate, _ver_src_id_fdate_sa2) = NULL, NULL, roundup((sysdate - _ver_src_id_fdate_sa2) / 30.5)) ) ;

_ver_src_id_ldate_sa := __common__( if(_ver_src_id_sa_pos > 0, Models.Common.getw(ver_src_id_lastseen_list, _ver_src_id_sa_pos), '0') ) ;

_ver_src_id_ldate_sa2 := __common__( common.sas_date((string)(_ver_src_id_ldate_sa)) ) ;

yr__ver_src_id_ldate_sa := __common__( if(min(sysdate, _ver_src_id_ldate_sa2) = NULL, NULL, (sysdate - _ver_src_id_ldate_sa2) / 365.25) ) ;

mth__ver_src_id_ldate_sa := __common__( if(min(sysdate, _ver_src_id_ldate_sa2) = NULL, NULL, roundup((sysdate - _ver_src_id_ldate_sa2) / 30.5)) ) ;

_ver_src_id_sb_pos := __common__( Models.Common.findw_cpp(ver_src_id_list, 'SB' , '  ,', 'ie') ) ;

_ver_src_id__sb := __common__( _ver_src_id_sb_pos > 0 ) ;

_ver_src_id_fdate_sb := __common__( if(_ver_src_id_sb_pos > 0, Models.Common.getw(ver_src_id_firstseen_list, _ver_src_id_sb_pos), '0') ) ;

_ver_src_id_fdate_sb2 := __common__( common.sas_date((string)(_ver_src_id_fdate_sb)) ) ;

yr__ver_src_id_fdate_sb := __common__( if(min(sysdate, _ver_src_id_fdate_sb2) = NULL, NULL, (sysdate - _ver_src_id_fdate_sb2) / 365.25) ) ;

mth__ver_src_id_fdate_sb := __common__( if(min(sysdate, _ver_src_id_fdate_sb2) = NULL, NULL, roundup((sysdate - _ver_src_id_fdate_sb2) / 30.5)) ) ;

_ver_src_id_ldate_sb := __common__( if(_ver_src_id_sb_pos > 0, Models.Common.getw(ver_src_id_lastseen_list, _ver_src_id_sb_pos), '0') ) ;

_ver_src_id_ldate_sb2 := __common__( common.sas_date((string)(_ver_src_id_ldate_sb)) ) ;

yr__ver_src_id_ldate_sb := __common__( if(min(sysdate, _ver_src_id_ldate_sb2) = NULL, NULL, (sysdate - _ver_src_id_ldate_sb2) / 365.25) ) ;

mth__ver_src_id_ldate_sb := __common__( if(min(sysdate, _ver_src_id_ldate_sb2) = NULL, NULL, roundup((sysdate - _ver_src_id_ldate_sb2) / 30.5)) ) ;

_ver_src_id_sg_pos := __common__( Models.Common.findw_cpp(ver_src_id_list, 'SG' , '  ,', 'ie') ) ;

_ver_src_id__sg := __common__( _ver_src_id_sg_pos > 0 ) ;

_ver_src_id_fdate_sg := __common__( if(_ver_src_id_sg_pos > 0, Models.Common.getw(ver_src_id_firstseen_list, _ver_src_id_sg_pos), '0') ) ;

_ver_src_id_fdate_sg2 := __common__( common.sas_date((string)(_ver_src_id_fdate_sg)) ) ;

yr__ver_src_id_fdate_sg := __common__( if(min(sysdate, _ver_src_id_fdate_sg2) = NULL, NULL, (sysdate - _ver_src_id_fdate_sg2) / 365.25) ) ;

mth__ver_src_id_fdate_sg := __common__( if(min(sysdate, _ver_src_id_fdate_sg2) = NULL, NULL, roundup((sysdate - _ver_src_id_fdate_sg2) / 30.5)) ) ;

_ver_src_id_ldate_sg := __common__( if(_ver_src_id_sg_pos > 0, Models.Common.getw(ver_src_id_lastseen_list, _ver_src_id_sg_pos), '0') ) ;

_ver_src_id_ldate_sg2 := __common__( common.sas_date((string)(_ver_src_id_ldate_sg)) ) ;

yr__ver_src_id_ldate_sg := __common__( if(min(sysdate, _ver_src_id_ldate_sg2) = NULL, NULL, (sysdate - _ver_src_id_ldate_sg2) / 365.25) ) ;

mth__ver_src_id_ldate_sg := __common__( if(min(sysdate, _ver_src_id_ldate_sg2) = NULL, NULL, roundup((sysdate - _ver_src_id_ldate_sg2) / 30.5)) ) ;

_ver_src_id_sj_pos := __common__( Models.Common.findw_cpp(ver_src_id_list, 'SJ' , '  ,', 'ie') ) ;

_ver_src_id__sj := __common__( _ver_src_id_sj_pos > 0 ) ;

_ver_src_id_fdate_sj := __common__( if(_ver_src_id_sj_pos > 0, Models.Common.getw(ver_src_id_firstseen_list, _ver_src_id_sj_pos), '0') ) ;

_ver_src_id_fdate_sj2 := __common__( common.sas_date((string)(_ver_src_id_fdate_sj)) ) ;

yr__ver_src_id_fdate_sj := __common__( if(min(sysdate, _ver_src_id_fdate_sj2) = NULL, NULL, (sysdate - _ver_src_id_fdate_sj2) / 365.25) ) ;

mth__ver_src_id_fdate_sj := __common__( if(min(sysdate, _ver_src_id_fdate_sj2) = NULL, NULL, roundup((sysdate - _ver_src_id_fdate_sj2) / 30.5)) ) ;

_ver_src_id_ldate_sj := __common__( if(_ver_src_id_sj_pos > 0, Models.Common.getw(ver_src_id_lastseen_list, _ver_src_id_sj_pos), '0') ) ;

_ver_src_id_ldate_sj2 := __common__( common.sas_date((string)(_ver_src_id_ldate_sj)) ) ;

yr__ver_src_id_ldate_sj := __common__( if(min(sysdate, _ver_src_id_ldate_sj2) = NULL, NULL, (sysdate - _ver_src_id_ldate_sj2) / 365.25) ) ;

mth__ver_src_id_ldate_sj := __common__( if(min(sysdate, _ver_src_id_ldate_sj2) = NULL, NULL, roundup((sysdate - _ver_src_id_ldate_sj2) / 30.5)) ) ;

_ver_src_id_sp_pos := __common__( Models.Common.findw_cpp(ver_src_id_list, 'SP' , '  ,', 'ie') ) ;

_ver_src_id__sp := __common__( _ver_src_id_sp_pos > 0 ) ;

_ver_src_id_fdate_sp := __common__( if(_ver_src_id_sp_pos > 0, Models.Common.getw(ver_src_id_firstseen_list, _ver_src_id_sp_pos), '0') ) ;

_ver_src_id_fdate_sp2 := __common__( common.sas_date((string)(_ver_src_id_fdate_sp)) ) ;

yr__ver_src_id_fdate_sp := __common__( if(min(sysdate, _ver_src_id_fdate_sp2) = NULL, NULL, (sysdate - _ver_src_id_fdate_sp2) / 365.25) ) ;

mth__ver_src_id_fdate_sp := __common__( if(min(sysdate, _ver_src_id_fdate_sp2) = NULL, NULL, roundup((sysdate - _ver_src_id_fdate_sp2) / 30.5)) ) ;

_ver_src_id_ldate_sp := __common__( if(_ver_src_id_sp_pos > 0, Models.Common.getw(ver_src_id_lastseen_list, _ver_src_id_sp_pos), '0') ) ;

_ver_src_id_ldate_sp2 := __common__( common.sas_date((string)(_ver_src_id_ldate_sp)) ) ;

yr__ver_src_id_ldate_sp := __common__( if(min(sysdate, _ver_src_id_ldate_sp2) = NULL, NULL, (sysdate - _ver_src_id_ldate_sp2) / 365.25) ) ;

mth__ver_src_id_ldate_sp := __common__( if(min(sysdate, _ver_src_id_ldate_sp2) = NULL, NULL, roundup((sysdate - _ver_src_id_ldate_sp2) / 30.5)) ) ;

_ver_src_id_ut_pos := __common__( Models.Common.findw_cpp(ver_src_id_list, 'UT' , '  ,', 'ie') ) ;

_ver_src_id__ut := __common__( _ver_src_id_ut_pos > 0 ) ;

_ver_src_id_fdate_ut := __common__( if(_ver_src_id_ut_pos > 0, Models.Common.getw(ver_src_id_firstseen_list, _ver_src_id_ut_pos), '0') ) ;

_ver_src_id_fdate_ut2 := __common__( common.sas_date((string)(_ver_src_id_fdate_ut)) ) ;

yr__ver_src_id_fdate_ut := __common__( if(min(sysdate, _ver_src_id_fdate_ut2) = NULL, NULL, (sysdate - _ver_src_id_fdate_ut2) / 365.25) ) ;

mth__ver_src_id_fdate_ut := __common__( if(min(sysdate, _ver_src_id_fdate_ut2) = NULL, NULL, roundup((sysdate - _ver_src_id_fdate_ut2) / 30.5)) ) ;

_ver_src_id_ldate_ut := __common__( if(_ver_src_id_ut_pos > 0, Models.Common.getw(ver_src_id_lastseen_list, _ver_src_id_ut_pos), '0') ) ;

_ver_src_id_ldate_ut2 := __common__( common.sas_date((string)(_ver_src_id_ldate_ut)) ) ;

yr__ver_src_id_ldate_ut := __common__( if(min(sysdate, _ver_src_id_ldate_ut2) = NULL, NULL, (sysdate - _ver_src_id_ldate_ut2) / 365.25) ) ;

mth__ver_src_id_ldate_ut := __common__( if(min(sysdate, _ver_src_id_ldate_ut2) = NULL, NULL, roundup((sysdate - _ver_src_id_ldate_ut2) / 30.5)) ) ;

_ver_src_id_v_pos := __common__( Models.Common.findw_cpp(ver_src_id_list, 'V' , '  ,', 'ie') ) ;

_ver_src_id__v := __common__( _ver_src_id_v_pos > 0 ) ;

_ver_src_id_fdate_v := __common__( if(_ver_src_id_v_pos > 0, Models.Common.getw(ver_src_id_firstseen_list, _ver_src_id_v_pos), '0') ) ;

_ver_src_id_fdate_v2 := __common__( common.sas_date((string)(_ver_src_id_fdate_v)) ) ;

yr__ver_src_id_fdate_v := __common__( if(min(sysdate, _ver_src_id_fdate_v2) = NULL, NULL, (sysdate - _ver_src_id_fdate_v2) / 365.25) ) ;

mth__ver_src_id_fdate_v := __common__( if(min(sysdate, _ver_src_id_fdate_v2) = NULL, NULL, roundup((sysdate - _ver_src_id_fdate_v2) / 30.5)) ) ;

_ver_src_id_ldate_v := __common__( if(_ver_src_id_v_pos > 0, Models.Common.getw(ver_src_id_lastseen_list, _ver_src_id_v_pos), '0') ) ;

_ver_src_id_ldate_v2 := __common__( common.sas_date((string)(_ver_src_id_ldate_v)) ) ;

yr__ver_src_id_ldate_v := __common__( if(min(sysdate, _ver_src_id_ldate_v2) = NULL, NULL, (sysdate - _ver_src_id_ldate_v2) / 365.25) ) ;

mth__ver_src_id_ldate_v := __common__( if(min(sysdate, _ver_src_id_ldate_v2) = NULL, NULL, roundup((sysdate - _ver_src_id_ldate_v2) / 30.5)) ) ;

_ver_src_id_wb_pos := __common__( Models.Common.findw_cpp(ver_src_id_list, 'WB' , '  ,', 'ie') ) ;

_ver_src_id__wb := __common__( _ver_src_id_wb_pos > 0 ) ;

_ver_src_id_fdate_wb := __common__( if(_ver_src_id_wb_pos > 0, Models.Common.getw(ver_src_id_firstseen_list, _ver_src_id_wb_pos), '0') ) ;

_ver_src_id_fdate_wb2 := __common__( common.sas_date((string)(_ver_src_id_fdate_wb)) ) ;

yr__ver_src_id_fdate_wb := __common__( if(min(sysdate, _ver_src_id_fdate_wb2) = NULL, NULL, (sysdate - _ver_src_id_fdate_wb2) / 365.25) ) ;

mth__ver_src_id_fdate_wb := __common__( if(min(sysdate, _ver_src_id_fdate_wb2) = NULL, NULL, roundup((sysdate - _ver_src_id_fdate_wb2) / 30.5)) ) ;

_ver_src_id_ldate_wb := __common__( if(_ver_src_id_wb_pos > 0, Models.Common.getw(ver_src_id_lastseen_list, _ver_src_id_wb_pos), '0') ) ;

_ver_src_id_ldate_wb2 := __common__( common.sas_date((string)(_ver_src_id_ldate_wb)) ) ;

yr__ver_src_id_ldate_wb := __common__( if(min(sysdate, _ver_src_id_ldate_wb2) = NULL, NULL, (sysdate - _ver_src_id_ldate_wb2) / 365.25) ) ;

mth__ver_src_id_ldate_wb := __common__( if(min(sysdate, _ver_src_id_ldate_wb2) = NULL, NULL, roundup((sysdate - _ver_src_id_ldate_wb2) / 30.5)) ) ;

_ver_src_id_wc_pos := __common__( Models.Common.findw_cpp(ver_src_id_list, 'WC' , '  ,', 'ie') ) ;

_ver_src_id__wc := __common__( _ver_src_id_wc_pos > 0 ) ;

_ver_src_id_fdate_wc := __common__( if(_ver_src_id_wc_pos > 0, Models.Common.getw(ver_src_id_firstseen_list, _ver_src_id_wc_pos), '0') ) ;

_ver_src_id_fdate_wc2 := __common__( common.sas_date((string)(_ver_src_id_fdate_wc)) ) ;

yr__ver_src_id_fdate_wc := __common__( if(min(sysdate, _ver_src_id_fdate_wc2) = NULL, NULL, (sysdate - _ver_src_id_fdate_wc2) / 365.25) ) ;

mth__ver_src_id_fdate_wc := __common__( if(min(sysdate, _ver_src_id_fdate_wc2) = NULL, NULL, roundup((sysdate - _ver_src_id_fdate_wc2) / 30.5)) ) ;

_ver_src_id_ldate_wc := __common__( if(_ver_src_id_wc_pos > 0, Models.Common.getw(ver_src_id_lastseen_list, _ver_src_id_wc_pos), '0') ) ;

_ver_src_id_ldate_wc2 := __common__( common.sas_date((string)(_ver_src_id_ldate_wc)) ) ;

yr__ver_src_id_ldate_wc := __common__( if(min(sysdate, _ver_src_id_ldate_wc2) = NULL, NULL, (sysdate - _ver_src_id_ldate_wc2) / 365.25) ) ;

mth__ver_src_id_ldate_wc := __common__( if(min(sysdate, _ver_src_id_ldate_wc2) = NULL, NULL, roundup((sysdate - _ver_src_id_ldate_wc2) / 30.5)) ) ;

_ver_src_id_wk_pos := __common__( Models.Common.findw_cpp(ver_src_id_list, 'WK' , '  ,', 'ie') ) ;

_ver_src_id__wk := __common__( _ver_src_id_wk_pos > 0 ) ;

_ver_src_id_fdate_wk := __common__( if(_ver_src_id_wk_pos > 0, Models.Common.getw(ver_src_id_firstseen_list, _ver_src_id_wk_pos), '0') ) ;

_ver_src_id_fdate_wk2 := __common__( common.sas_date((string)(_ver_src_id_fdate_wk)) ) ;

yr__ver_src_id_fdate_wk := __common__( if(min(sysdate, _ver_src_id_fdate_wk2) = NULL, NULL, (sysdate - _ver_src_id_fdate_wk2) / 365.25) ) ;

mth__ver_src_id_fdate_wk := __common__( if(min(sysdate, _ver_src_id_fdate_wk2) = NULL, NULL, roundup((sysdate - _ver_src_id_fdate_wk2) / 30.5)) ) ;

_ver_src_id_ldate_wk := __common__( if(_ver_src_id_wk_pos > 0, Models.Common.getw(ver_src_id_lastseen_list, _ver_src_id_wk_pos), '0') ) ;

_ver_src_id_ldate_wk2 := __common__( common.sas_date((string)(_ver_src_id_ldate_wk)) ) ;

yr__ver_src_id_ldate_wk := __common__( if(min(sysdate, _ver_src_id_ldate_wk2) = NULL, NULL, (sysdate - _ver_src_id_ldate_wk2) / 365.25) ) ;

mth__ver_src_id_ldate_wk := __common__( if(min(sysdate, _ver_src_id_ldate_wk2) = NULL, NULL, roundup((sysdate - _ver_src_id_ldate_wk2) / 30.5)) ) ;

_ver_src_id_wx_pos := __common__( Models.Common.findw_cpp(ver_src_id_list, 'WX' , '  ,', 'ie') ) ;

_ver_src_id__wx := __common__( _ver_src_id_wx_pos > 0 ) ;

_ver_src_id_fdate_wx := __common__( if(_ver_src_id_wx_pos > 0, Models.Common.getw(ver_src_id_firstseen_list, _ver_src_id_wx_pos), '0') ) ;

_ver_src_id_fdate_wx2 := __common__( common.sas_date((string)(_ver_src_id_fdate_wx)) ) ;

yr__ver_src_id_fdate_wx := __common__( if(min(sysdate, _ver_src_id_fdate_wx2) = NULL, NULL, (sysdate - _ver_src_id_fdate_wx2) / 365.25) ) ;

mth__ver_src_id_fdate_wx := __common__( if(min(sysdate, _ver_src_id_fdate_wx2) = NULL, NULL, roundup((sysdate - _ver_src_id_fdate_wx2) / 30.5)) ) ;

_ver_src_id_ldate_wx := __common__( if(_ver_src_id_wx_pos > 0, Models.Common.getw(ver_src_id_lastseen_list, _ver_src_id_wx_pos), '0') ) ;

_ver_src_id_ldate_wx2 := __common__( common.sas_date((string)(_ver_src_id_ldate_wx)) ) ;

yr__ver_src_id_ldate_wx := __common__( if(min(sysdate, _ver_src_id_ldate_wx2) = NULL, NULL, (sysdate - _ver_src_id_ldate_wx2) / 365.25) ) ;

mth__ver_src_id_ldate_wx := __common__( if(min(sysdate, _ver_src_id_ldate_wx2) = NULL, NULL, roundup((sysdate - _ver_src_id_ldate_wx2) / 30.5)) ) ;

_ver_src_id_zo_pos := __common__( Models.Common.findw_cpp(ver_src_id_list, 'ZO' , '  ,', 'ie') ) ;

_ver_src_id__zo := __common__( _ver_src_id_zo_pos > 0 ) ;

_ver_src_id_fdate_zo := __common__( if(_ver_src_id_zo_pos > 0, Models.Common.getw(ver_src_id_firstseen_list, _ver_src_id_zo_pos), '0') ) ;

_ver_src_id_fdate_zo2 := __common__( common.sas_date((string)(_ver_src_id_fdate_zo)) ) ;

yr__ver_src_id_fdate_zo := __common__( if(min(sysdate, _ver_src_id_fdate_zo2) = NULL, NULL, (sysdate - _ver_src_id_fdate_zo2) / 365.25) ) ;

mth__ver_src_id_fdate_zo := __common__( if(min(sysdate, _ver_src_id_fdate_zo2) = NULL, NULL, roundup((sysdate - _ver_src_id_fdate_zo2) / 30.5)) ) ;

_ver_src_id_ldate_zo := __common__( if(_ver_src_id_zo_pos > 0, Models.Common.getw(ver_src_id_lastseen_list, _ver_src_id_zo_pos), '0') ) ;

_ver_src_id_ldate_zo2 := __common__( common.sas_date((string)(_ver_src_id_ldate_zo)) ) ;

yr__ver_src_id_ldate_zo := __common__( if(min(sysdate, _ver_src_id_ldate_zo2) = NULL, NULL, (sysdate - _ver_src_id_ldate_zo2) / 365.25) ) ;

mth__ver_src_id_ldate_zo := __common__( if(min(sysdate, _ver_src_id_ldate_zo2) = NULL, NULL, roundup((sysdate - _ver_src_id_ldate_zo2) / 30.5)) ) ;

_ver_src_id_y_pos := __common__( Models.Common.findw_cpp(ver_src_id_list, 'Y' , '  ,', 'ie') ) ;

_ver_src_id__y := __common__( _ver_src_id_y_pos > 0 ) ;

_ver_src_id_fdate_y := __common__( if(_ver_src_id_y_pos > 0, Models.Common.getw(ver_src_id_firstseen_list, _ver_src_id_y_pos), '0') ) ;

_ver_src_id_fdate_y2 := __common__( common.sas_date((string)(_ver_src_id_fdate_y)) ) ;

yr__ver_src_id_fdate_y := __common__( if(min(sysdate, _ver_src_id_fdate_y2) = NULL, NULL, (sysdate - _ver_src_id_fdate_y2) / 365.25) ) ;

mth__ver_src_id_fdate_y := __common__( if(min(sysdate, _ver_src_id_fdate_y2) = NULL, NULL, roundup((sysdate - _ver_src_id_fdate_y2) / 30.5)) ) ;

_ver_src_id_ldate_y := __common__( if(_ver_src_id_y_pos > 0, Models.Common.getw(ver_src_id_lastseen_list, _ver_src_id_y_pos), '0') ) ;

_ver_src_id_ldate_y2 := __common__( common.sas_date((string)(_ver_src_id_ldate_y)) ) ;

yr__ver_src_id_ldate_y := __common__( if(min(sysdate, _ver_src_id_ldate_y2) = NULL, NULL, (sysdate - _ver_src_id_ldate_y2) / 365.25) ) ;

mth__ver_src_id_ldate_y := __common__( if(min(sysdate, _ver_src_id_ldate_y2) = NULL, NULL, roundup((sysdate - _ver_src_id_ldate_y2) / 30.5)) ) ;

_ver_src_id_gb_pos := __common__( Models.Common.findw_cpp(ver_src_id_list, 'GB' , '  ,', 'ie') ) ;

_ver_src_id__gb := __common__( _ver_src_id_gb_pos > 0 ) ;

_ver_src_id_fdate_gb := __common__( if(_ver_src_id_gb_pos > 0, Models.Common.getw(ver_src_id_firstseen_list, _ver_src_id_gb_pos), '0') ) ;

_ver_src_id_fdate_gb2 := __common__( common.sas_date((string)(_ver_src_id_fdate_gb)) ) ;

yr__ver_src_id_fdate_gb := __common__( if(min(sysdate, _ver_src_id_fdate_gb2) = NULL, NULL, (sysdate - _ver_src_id_fdate_gb2) / 365.25) ) ;

mth__ver_src_id_fdate_gb := __common__( if(min(sysdate, _ver_src_id_fdate_gb2) = NULL, NULL, roundup((sysdate - _ver_src_id_fdate_gb2) / 30.5)) ) ;

_ver_src_id_ldate_gb := __common__( if(_ver_src_id_gb_pos > 0, Models.Common.getw(ver_src_id_lastseen_list, _ver_src_id_gb_pos), '0') ) ;

_ver_src_id_ldate_gb2 := __common__( common.sas_date((string)(_ver_src_id_ldate_gb)) ) ;

yr__ver_src_id_ldate_gb := __common__( if(min(sysdate, _ver_src_id_ldate_gb2) = NULL, NULL, (sysdate - _ver_src_id_ldate_gb2) / 365.25) ) ;

mth__ver_src_id_ldate_gb := __common__( if(min(sysdate, _ver_src_id_ldate_gb2) = NULL, NULL, roundup((sysdate - _ver_src_id_ldate_gb2) / 30.5)) ) ;

_ver_src_id_cs_pos := __common__( Models.Common.findw_cpp(ver_src_id_list, 'C#' , ' ,', 'ie') ) ;

_ver_src_id__cs := __common__( _ver_src_id_cs_pos > 0 ) ;

_ver_src_id_ldate_cs := __common__( if(_ver_src_id_cs_pos > 0, Models.Common.getw(ver_src_id_lastseen_list, _ver_src_id_cs_pos), '0') ) ;

_ver_src_id_ldate_cs2 := __common__( common.sas_date((string)(_ver_src_id_ldate_cs)) ) ;

yr__ver_src_id_ldate_cs := __common__( if(min(sysdate, _ver_src_id_ldate_cs2) = NULL, NULL, (sysdate - _ver_src_id_ldate_cs2) / 365.25) ) ;

mth__ver_src_id_ldate_cs := __common__( if(min(sysdate, _ver_src_id_ldate_cs2) = NULL, NULL, roundup((sysdate - _ver_src_id_ldate_cs2) / 30.5)) ) ;

_ver_src_id_fdate_cs := __common__( if(_ver_src_id_cs_pos > 0, Models.Common.getw(ver_src_id_firstseen_list, _ver_src_id_cs_pos), '0') ) ;

_ver_src_id_fdate_cs2 := __common__( common.sas_date((string)(_ver_src_id_fdate_cs)) ) ;

yr__ver_src_id_fdate_cs := __common__( if(min(sysdate, _ver_src_id_fdate_cs2) = NULL, NULL, (sysdate - _ver_src_id_fdate_cs2) / 365.25) ) ;

mth__ver_src_id_fdate_cs := __common__( if(min(sysdate, _ver_src_id_fdate_cs2) = NULL, NULL, roundup((sysdate - _ver_src_id_fdate_cs2) / 30.5)) ) ;

vs_ver_src_id__gb := __common__( _ver_src_id__gb ) ;

vs_gb_id_mth_fseen := __common__( mth__ver_src_id_fdate_gb ) ;

vs_gb_id_mth_lseen := __common__( mth__ver_src_id_ldate_gb ) ;

vs_ver_src_id__y := __common__( _ver_src_id__y ) ;

vs_y_id_mth_fseen := __common__( mth__ver_src_id_fdate_y ) ;

vs_y_id_mth_lseen := __common__( mth__ver_src_id_ldate_y ) ;

vs_ver_src_id__ut := __common__( (integer) _ver_src_id__ut ) ;

vs_ut_id_mth_fseen := __common__( mth__ver_src_id_fdate_ut ) ;

vs_ut_id_mth_lseen := __common__( mth__ver_src_id_ldate_ut ) ;

vs_ver_src_id__os := __common__( _ver_src_id__os ) ;

vs_os_id_mth_fseen := __common__( mth__ver_src_id_fdate_os ) ;

vs_os_id_mth_lseen := __common__( mth__ver_src_id_ldate_os ) ;

vs_ver_src_id__bm := __common__( (integer) _ver_src_id__bm ) ;

vs_bm_id_mth_fseen := __common__( mth__ver_src_id_fdate_bm ) ;

vs_bm_id_mth_lseen := __common__( mth__ver_src_id_ldate_bm ) ;

vs_ver_src_id__i := __common__( (integer) _ver_src_id__i ) ;

vs_i_id_mth_fseen := __common__( mth__ver_src_id_fdate_i ) ;

vs_i_id_mth_lseen := __common__( mth__ver_src_id_ldate_i ) ;

vs_ver_src_id__in := __common__( (integer) _ver_src_id__in ) ;

vs_in_id_mth_fseen := __common__( mth__ver_src_id_fdate_in ) ;

vs_in_id_mth_lseen := __common__( mth__ver_src_id_ldate_in ) ;

vs_ver_src_id__l0 := __common__( _ver_src_id__l0 ) ;

vs_l0_id_mth_fseen := __common__( mth__ver_src_id_fdate_l0 ) ;

vs_l0_id_mth_lseen := __common__( mth__ver_src_id_ldate_l0 ) ;

vs_ver_src_id__wa := __common__( _ver_src_id__wa ) ;

vs_wa_id_mth_fseen := __common__( mth__ver_src_id_fdate_wa ) ;

vs_wa_id_mth_lseen := __common__( mth__ver_src_id_ldate_wa ) ;

vs_ver_src_id__ar := __common__( _ver_src_id__ar ) ;

vs_ar_id_mth_fseen := __common__( mth__ver_src_id_fdate_ar ) ;

vs_ar_id_mth_lseen := __common__( mth__ver_src_id_ldate_ar ) ;

vs_ver_src_id__v2 := __common__( _ver_src_id__v2 ) ;

vs_v2_id_mth_fseen := __common__( mth__ver_src_id_fdate_v2 ) ;

vs_v2_id_mth_lseen := __common__( mth__ver_src_id_ldate_v2 ) ;

vs_adl_util_i_1 := __common__( if(not(truedid), NULL, NULL) ) ;

vs_adl_util_i := __common__( if(util_adl_type_list = '', -1, (integer) (contains_i(util_adl_type_list, '1') > 0)) ) ;

vs_util_adl_count := __common__( if(not(truedid), NULL, util_adl_count) ) ;

_util_adl_first_seen := __common__( common.sas_date((string)(util_adl_first_seen)) ) ;

vs_util_adl_mths_fs := __common__( map(
    not(truedid)                => NULL,
    _util_adl_first_seen = NULL => -1,
                                   (sysdate - _util_adl_first_seen) / (365.25 / 12)) ) ;

_gong_did_first_seen := __common__( common.sas_date((string)(gong_did_first_seen)) ) ;

_gong_did_last_seen := __common__( common.sas_date((string)(gong_did_last_seen)) ) ;

vs_gong_adl_mths_ls := __common__( map(
    not(truedid)               => NULL,
    _gong_did_last_seen = NULL => -1,
                                  (sysdate - _gong_did_last_seen) / (365.25 / 12)) ) ;

_header_first_seen := __common__( common.sas_date((string)(header_first_seen)) ) ;

vs_header_mths_fs := __common__( map(
    not(truedid)              => NULL,
    _header_first_seen = NULL => -1,
                                 (sysdate - _header_first_seen) / (365.25 / 12)) ) ;

_header_last_seen := __common__( common.sas_date((string)(header_last_seen)) ) ;

_br_first_seen_1 := __common__( common.sas_date((string)(br_First_seen)) ) ;

vs_br_mths_fs := __common__( map(
    not(truedid)            => NULL,
    _br_first_seen_1 = NULL => -1,
                               (sysdate - _br_first_seen_1) / (365.25 / 12)) ) ;

vs_br_business_count := __common__( if(not(truedid), -1, br_business_count) ) ;

vs_br_dead_business_count := __common__( if(not(truedid), -1, br_dead_business_count) ) ;

vs_br_active_phone_count := __common__( if(not(truedid), -1, br_active_phone_count) ) ;

vs_email_count := __common__( if(not(truedid), -1, email_count) ) ;

vs_email_domain_free_count := __common__( if(not(truedid), -1, email_domain_free_count) ) ;

vs_email_domain_edu_count := __common__( if(not(truedid), -1, email_domain_EDU_count) ) ;

vs_historical_count := __common__( if(not(truedid), -1, historical_count) ) ;

vs_college_tier := __common__( map(not(truedid) => -1,
	college_tier = '' => NULL,
	(integer) college_tier) ) ;

vs_prof_license_flag := __common__( if(not(truedid), -1, (integer) prof_license_flag) ) ;

_prof_license_ix_sanct_fs := __common__( common.sas_date((string)(Prof_license_IX_sanct_fs)) ) ;

_prof_license_ix_sanct_ls := __common__( common.sas_date((string)(Prof_license_IX_sanct_ls)) ) ;

ver_src_cons_fsrc_fdate := __common__( Models.Common.getw(ver_sources_first_seen, 1) ) ;

ver_src_cons_fsrc_fdate2 := __common__( common.sas_date((string)(ver_src_cons_fsrc_fdate)) ) ;

yr_ver_src_cons_fsrc_fdate := __common__( if(min(sysdate, ver_src_cons_fsrc_fdate2) = NULL, NULL, (sysdate - ver_src_cons_fsrc_fdate2) / 365.25) ) ;

mth_ver_src_cons_fsrc_fdate := __common__( if(min(sysdate, ver_src_cons_fsrc_fdate2) = NULL, NULL, roundup((sysdate - ver_src_cons_fsrc_fdate2) / 30.5)) ) ;

ver_src_cons_vo_pos := __common__( Models.Common.findw_cpp(ver_sources, 'VO' , '  ,', 'ie') ) ;

ver_src_cons__vo := __common__( ver_src_cons_vo_pos > 0 ) ;

ver_src_cons_fdate_vo := __common__( if(ver_src_cons_vo_pos > 0, Models.Common.getw(ver_sources_first_seen, ver_src_cons_vo_pos), '0') ) ;

ver_src_cons_fdate_vo2 := __common__( common.sas_date((string)(ver_src_cons_fdate_vo)) ) ;

yr_ver_src_cons_fdate_vo := __common__( if(min(sysdate, ver_src_cons_fdate_vo2) = NULL, NULL, (sysdate - ver_src_cons_fdate_vo2) / 365.25) ) ;

mth_ver_src_cons_fdate_vo := __common__( if(min(sysdate, ver_src_cons_fdate_vo2) = NULL, NULL, roundup((sysdate - ver_src_cons_fdate_vo2) / 30.5)) ) ;

ver_src_cons_ldate_vo := __common__( if(ver_src_cons_vo_pos > 0, Models.Common.getw(ver_sources_last_seen, ver_src_cons_vo_pos), '0') ) ;

ver_src_cons_ldate_vo2 := __common__( common.sas_date((string)(ver_src_cons_ldate_vo)) ) ;

yr_ver_src_cons_ldate_vo := __common__( if(min(sysdate, ver_src_cons_ldate_vo2) = NULL, NULL, (sysdate - ver_src_cons_ldate_vo2) / 365.25) ) ;

mth_ver_src_cons_ldate_vo := __common__( if(min(sysdate, ver_src_cons_ldate_vo2) = NULL, NULL, roundup((sysdate - ver_src_cons_ldate_vo2) / 30.5)) ) ;

ver_src_cons_wp_pos := __common__( Models.Common.findw_cpp(ver_sources, 'WP' , '  ,', 'ie') ) ;

ver_src_cons__wp := __common__( ver_src_cons_wp_pos > 0 ) ;

ver_src_cons_fdate_wp := __common__( if(ver_src_cons_wp_pos > 0, Models.Common.getw(ver_sources_first_seen, ver_src_cons_wp_pos), '0') ) ;

ver_src_cons_fdate_wp2 := __common__( common.sas_date((string)(ver_src_cons_fdate_wp)) ) ;

yr_ver_src_cons_fdate_wp := __common__( if(min(sysdate, ver_src_cons_fdate_wp2) = NULL, NULL, (sysdate - ver_src_cons_fdate_wp2) / 365.25) ) ;

mth_ver_src_cons_fdate_wp := __common__( if(min(sysdate, ver_src_cons_fdate_wp2) = NULL, NULL, roundup((sysdate - ver_src_cons_fdate_wp2) / 30.5)) ) ;

ver_src_cons_ldate_wp := __common__( if(ver_src_cons_wp_pos > 0, Models.Common.getw(ver_sources_last_seen, ver_src_cons_wp_pos), '0') ) ;

ver_src_cons_ldate_wp2 := __common__( common.sas_date((string)(ver_src_cons_ldate_wp)) ) ;

yr_ver_src_cons_ldate_wp := __common__( if(min(sysdate, ver_src_cons_ldate_wp2) = NULL, NULL, (sysdate - ver_src_cons_ldate_wp2) / 365.25) ) ;

mth_ver_src_cons_ldate_wp := __common__( if(min(sysdate, ver_src_cons_ldate_wp2) = NULL, NULL, roundup((sysdate - ver_src_cons_ldate_wp2) / 30.5)) ) ;

ver_src_cons_am_pos := __common__( Models.Common.findw_cpp(ver_sources, 'AM' , '  ,', 'ie') ) ;

ver_src_cons__am := __common__( ver_src_cons_am_pos > 0 ) ;

ver_src_cons_fdate_am := __common__( if(ver_src_cons_am_pos > 0, Models.Common.getw(ver_sources_first_seen, ver_src_cons_am_pos), '0') ) ;

ver_src_cons_fdate_am2 := __common__( common.sas_date((string)(ver_src_cons_fdate_am)) ) ;

yr_ver_src_cons_fdate_am := __common__( if(min(sysdate, ver_src_cons_fdate_am2) = NULL, NULL, (sysdate - ver_src_cons_fdate_am2) / 365.25) ) ;

mth_ver_src_cons_fdate_am := __common__( if(min(sysdate, ver_src_cons_fdate_am2) = NULL, NULL, roundup((sysdate - ver_src_cons_fdate_am2) / 30.5)) ) ;

ver_src_cons_ldate_am := __common__( if(ver_src_cons_am_pos > 0, Models.Common.getw(ver_sources_last_seen, ver_src_cons_am_pos), '0') ) ;

ver_src_cons_ldate_am2 := __common__( common.sas_date((string)(ver_src_cons_ldate_am)) ) ;

yr_ver_src_cons_ldate_am := __common__( if(min(sysdate, ver_src_cons_ldate_am2) = NULL, NULL, (sysdate - ver_src_cons_ldate_am2) / 365.25) ) ;

mth_ver_src_cons_ldate_am := __common__( if(min(sysdate, ver_src_cons_ldate_am2) = NULL, NULL, roundup((sysdate - ver_src_cons_ldate_am2) / 30.5)) ) ;

ver_src_cons_e1_pos := __common__( Models.Common.findw_cpp(ver_sources, 'E1' , '  ,', 'ie') ) ;

ver_src_cons__e1 := __common__( ver_src_cons_e1_pos > 0 ) ;

ver_src_cons_fdate_e1 := __common__( if(ver_src_cons_e1_pos > 0, Models.Common.getw(ver_sources_first_seen, ver_src_cons_e1_pos), '0') ) ;

ver_src_cons_fdate_e12 := __common__( common.sas_date((string)(ver_src_cons_fdate_e1)) ) ;

yr_ver_src_cons_fdate_e1 := __common__( if(min(sysdate, ver_src_cons_fdate_e12) = NULL, NULL, (sysdate - ver_src_cons_fdate_e12) / 365.25) ) ;

mth_ver_src_cons_fdate_e1 := __common__( if(min(sysdate, ver_src_cons_fdate_e12) = NULL, NULL, roundup((sysdate - ver_src_cons_fdate_e12) / 30.5)) ) ;

ver_src_cons_ldate_e1 := __common__( if(ver_src_cons_e1_pos > 0, Models.Common.getw(ver_sources_last_seen, ver_src_cons_e1_pos), '0') ) ;

ver_src_cons_ldate_e12 := __common__( common.sas_date((string)(ver_src_cons_ldate_e1)) ) ;

yr_ver_src_cons_ldate_e1 := __common__( if(min(sysdate, ver_src_cons_ldate_e12) = NULL, NULL, (sysdate - ver_src_cons_ldate_e12) / 365.25) ) ;

mth_ver_src_cons_ldate_e1 := __common__( if(min(sysdate, ver_src_cons_ldate_e12) = NULL, NULL, roundup((sysdate - ver_src_cons_ldate_e12) / 30.5)) ) ;

ver_src_cons_e2_pos := __common__( Models.Common.findw_cpp(ver_sources, 'E2' , '  ,', 'ie') ) ;

ver_src_cons__e2 := __common__( ver_src_cons_e2_pos > 0 ) ;

ver_src_cons_fdate_e2 := __common__( if(ver_src_cons_e2_pos > 0, Models.Common.getw(ver_sources_first_seen, ver_src_cons_e2_pos), '0') ) ;

ver_src_cons_fdate_e22 := __common__( common.sas_date((string)(ver_src_cons_fdate_e2)) ) ;

yr_ver_src_cons_fdate_e2 := __common__( if(min(sysdate, ver_src_cons_fdate_e22) = NULL, NULL, (sysdate - ver_src_cons_fdate_e22) / 365.25) ) ;

mth_ver_src_cons_fdate_e2 := __common__( if(min(sysdate, ver_src_cons_fdate_e22) = NULL, NULL, roundup((sysdate - ver_src_cons_fdate_e22) / 30.5)) ) ;

ver_src_cons_ldate_e2 := __common__( if(ver_src_cons_e2_pos > 0, Models.Common.getw(ver_sources_last_seen, ver_src_cons_e2_pos), '0') ) ;

ver_src_cons_ldate_e22 := __common__( common.sas_date((string)(ver_src_cons_ldate_e2)) ) ;

yr_ver_src_cons_ldate_e2 := __common__( if(min(sysdate, ver_src_cons_ldate_e22) = NULL, NULL, (sysdate - ver_src_cons_ldate_e22) / 365.25) ) ;

mth_ver_src_cons_ldate_e2 := __common__( if(min(sysdate, ver_src_cons_ldate_e22) = NULL, NULL, roundup((sysdate - ver_src_cons_ldate_e22) / 30.5)) ) ;

ver_src_cons_e3_pos := __common__( Models.Common.findw_cpp(ver_sources, 'E3' , '  ,', 'ie') ) ;

ver_src_cons__e3 := __common__( ver_src_cons_e3_pos > 0 ) ;

ver_src_cons_fdate_e3 := __common__( if(ver_src_cons_e3_pos > 0, Models.Common.getw(ver_sources_first_seen, ver_src_cons_e3_pos), '0') ) ;

ver_src_cons_fdate_e32 := __common__( common.sas_date((string)(ver_src_cons_fdate_e3)) ) ;

yr_ver_src_cons_fdate_e3 := __common__( if(min(sysdate, ver_src_cons_fdate_e32) = NULL, NULL, (sysdate - ver_src_cons_fdate_e32) / 365.25) ) ;

mth_ver_src_cons_fdate_e3 := __common__( if(min(sysdate, ver_src_cons_fdate_e32) = NULL, NULL, roundup((sysdate - ver_src_cons_fdate_e32) / 30.5)) ) ;

ver_src_cons_ldate_e3 := __common__( if(ver_src_cons_e3_pos > 0, Models.Common.getw(ver_sources_last_seen, ver_src_cons_e3_pos), '0') ) ;

ver_src_cons_ldate_e32 := __common__( common.sas_date((string)(ver_src_cons_ldate_e3)) ) ;

yr_ver_src_cons_ldate_e3 := __common__( if(min(sysdate, ver_src_cons_ldate_e32) = NULL, NULL, (sysdate - ver_src_cons_ldate_e32) / 365.25) ) ;

mth_ver_src_cons_ldate_e3 := __common__( if(min(sysdate, ver_src_cons_ldate_e32) = NULL, NULL, roundup((sysdate - ver_src_cons_ldate_e32) / 30.5)) ) ;

_ver_src_cons_fdate_vo := __common__( common.sas_date((string)(ver_src_cons_fdate_vo)) ) ;

_ver_src_cons_ldate_vo := __common__( common.sas_date((string)(ver_src_cons_ldate_vo)) ) ;

vs_ver_src_cons_vo_mths_ls := __common__( map(
    not(truedid)                  => NULL,
    _ver_src_cons_ldate_vo = NULL => -1,
                                     (sysdate - _ver_src_cons_ldate_vo) / (365.25 / 12)) ) ;

vs_ver_sources_wp_pop := __common__( if(not(truedid), NULL, (integer) (ver_src_cons_wp_pos > 0)) ) ;

_ver_src_cons_fdate_wp := __common__( common.sas_date((string)(ver_src_cons_fdate_wp)) ) ;

_ver_src_cons_ldate_wp := __common__( common.sas_date((string)(ver_src_cons_ldate_wp)) ) ;

vs_ver_sources_am_pop := __common__( if(not(truedid), NULL, (integer) (ver_src_cons_am_pos > 0)) ) ;

_ver_src_cons_fdate_am := __common__( common.sas_date((string)(ver_src_cons_fdate_am)) ) ;

_ver_src_cons_ldate_am := __common__( common.sas_date((string)(ver_src_cons_ldate_am)) ) ;

vs_ver_sources_e1_pop := __common__( if(not(truedid), NULL, (integer) (ver_src_cons_e1_pos > 0)) ) ;

_ver_src_cons_fdate_e1 := __common__( common.sas_date((string)(ver_src_cons_fdate_e1)) ) ;

vs_ver_src_cons_e1_mths_fs := __common__( map(
    not(truedid)                  => NULL,
    _ver_src_cons_fdate_e1 = NULL => -1,
                                     (sysdate - _ver_src_cons_fdate_e1) / (365.25 / 12)) ) ;

_ver_src_cons_ldate_e1 := __common__( common.sas_date((string)(ver_src_cons_ldate_e1)) ) ;

vs_ver_src_cons_e1_mths_ls := __common__( map(
    not(truedid)                  => NULL,
    _ver_src_cons_ldate_e1 = NULL => -1,
                                     (sysdate - _ver_src_cons_ldate_e1) / (365.25 / 12)) ) ;

_ver_src_cons_fdate_e2 := __common__( common.sas_date((string)(ver_src_cons_fdate_e2)) ) ;

vs_ver_src_cons_e2_mths_fs := __common__( map(
    not(truedid)                  => NULL,
    _ver_src_cons_fdate_e2 = NULL => -1,
                                     (sysdate - _ver_src_cons_fdate_e2) / (365.25 / 12)) ) ;

_ver_src_cons_ldate_e2 := __common__( common.sas_date((string)(ver_src_cons_ldate_e2)) ) ;

vs_ver_src_cons_e2_mths_ls := __common__( map(
    not(truedid)                  => NULL,
    _ver_src_cons_ldate_e2 = NULL => -1,
                                     (sysdate - _ver_src_cons_ldate_e2) / (365.25 / 12)) ) ;

_ver_src_cons_fdate_e3 := __common__( common.sas_date((string)(ver_src_cons_fdate_e3)) ) ;

vs_ver_src_cons_e3_mths_fs := __common__( map(
    not(truedid)                  => NULL,
    _ver_src_cons_fdate_e3 = NULL => -1,
                                     (sysdate - _ver_src_cons_fdate_e3) / (365.25 / 12)) ) ;

_ver_src_cons_ldate_e3 := __common__( common.sas_date((string)(ver_src_cons_ldate_e3)) ) ;

vs_ver_src_cons_e3_mths_ls := __common__( map(
    not(truedid)                  => NULL,
    _ver_src_cons_ldate_e3 = NULL => -1,
                                     (sysdate - _ver_src_cons_ldate_e3) / (365.25 / 12)) ) ;

c_vs_gb_id_mth_fseen_w := __common__( map(
    vs_gb_id_mth_fseen = NULL  => 0.00000,
    vs_gb_id_mth_fseen <= 3.5  => 0.91610,
    vs_gb_id_mth_fseen <= 7.5  => 0.88764,
    vs_gb_id_mth_fseen <= 13.5 => 0.76509,
    vs_gb_id_mth_fseen <= 19.5 => 0.60945,
    vs_gb_id_mth_fseen <= 24.5 => 0.35735,
    vs_gb_id_mth_fseen <= 32.5 => 0.22964,
    vs_gb_id_mth_fseen <= 39.5 => 0.21626,
    vs_gb_id_mth_fseen <= 43.5 => 0.08935,
    vs_gb_id_mth_fseen <= 52.5 => 0.05666,
    vs_gb_id_mth_fseen <= 85.5 => -0.00212,
    vs_gb_id_mth_fseen <= 97.5 => -0.19392,
                                  -0.33280) ) ;

c_vs_gb_id_mth_lseen_w := __common__( map(
    vs_gb_id_mth_lseen = NULL   => 0.00000,
    vs_gb_id_mth_lseen <= 13.5  => 0.27213,
    vs_gb_id_mth_lseen <= 38.5  => -0.05875,
    vs_gb_id_mth_lseen <= 50.5  => -0.22762,
    vs_gb_id_mth_lseen <= 125.5 => -0.24205,
    vs_gb_id_mth_lseen <= 136.5 => -0.28738,
                                   -0.44975) ) ;

c_vs_ver_src_id__bm_w := __common__( map(
    vs_ver_src_id__bm = NULL => 0.00000,
    vs_ver_src_id__bm <= 0   => 0.00329,
                                -1.30107) ) ;

c_vs_ver_src_id__in_w := __common__( map(
    vs_ver_src_id__in = NULL => 0.00000,
    vs_ver_src_id__in <= 0.5 => 0.00723,
                                -0.84185) ) ;

c_vs_util_adl_count_w := __common__( map(
    vs_util_adl_count = NULL => 0.00000,
    vs_util_adl_count <= 0.5 => -0.21937,
    vs_util_adl_count <= 1.5 => -0.06067,
    vs_util_adl_count <= 2.5 => 0.15314,
    vs_util_adl_count <= 4.5 => 0.29960,
    vs_util_adl_count <= 6.5 => 0.44774,
    vs_util_adl_count <= 7.5 => 0.53142,
                                0.64580) ) ;

c_vs_util_adl_mths_fs_w := __common__( map(
    vs_util_adl_mths_fs = NULL           => 0.00000,
    vs_util_adl_mths_fs = -1             => -0.17300,
    vs_util_adl_mths_fs <= 18.1190965095 => 0.17201,
    vs_util_adl_mths_fs <= 43.0554414785 => 0.30402,
    vs_util_adl_mths_fs <= 63.09650924   => 0.45759,
                                            0.77814) ) ;

c_vs_gong_adl_mths_ls_w := __common__( map(
    vs_gong_adl_mths_ls = NULL           => 0.00000,
    vs_gong_adl_mths_ls = -1             => 0.18245,
    vs_gong_adl_mths_ls <= 1.1663244353  => -0.25396,
    vs_gong_adl_mths_ls <= 43.6468172485 => 0.12138,
    vs_gong_adl_mths_ls <= 98.316221766  => 0.17905,
    vs_gong_adl_mths_ls <= 131.039014375 => 0.25395,
                                            0.32975) ) ;

c_vs_header_mths_fs_w := __common__( map(
    vs_header_mths_fs = NULL           => 0.00000,
    vs_header_mths_fs = -1             => 0.00000,
    vs_header_mths_fs <= 52.501026694  => 0.98807,
    vs_header_mths_fs <= 77.979466119  => 0.71402,
    vs_header_mths_fs <= 102.981519505 => 0.59182,
    vs_header_mths_fs <= 115.006160165 => 0.42455,
    vs_header_mths_fs <= 125.026694045 => 0.41659,
    vs_header_mths_fs <= 128.016427105 => 0.35482,
    vs_header_mths_fs <= 151.014373715 => 0.29992,
    vs_header_mths_fs <= 233.971252565 => 0.18535,
    vs_header_mths_fs <= 266.480492815 => 0.15573,
    vs_header_mths_fs <= 273.034907595 => 0.11123,
    vs_header_mths_fs <= 286.50513347  => 0.07083,
    vs_header_mths_fs <= 288.476386035 => -0.00697,
    vs_header_mths_fs <= 302.488706365 => -0.04193,
    vs_header_mths_fs <= 337.002053385 => -0.08453,
    vs_header_mths_fs <= 344           => -0.12862,
    vs_header_mths_fs <= 357.010266945 => -0.19123,
    vs_header_mths_fs <= 360.985626285 => -0.23830,
    vs_header_mths_fs <= 403.991786445 => -0.30308,
    vs_header_mths_fs <= 426.989733055 => -0.31986,
                                          -0.46326) ) ;

c_vs_pb_mths_fs_w := __common__( 0.00000 ) ;

c_vs_pb_mths_ls_w := __common__( 0.00000 ) ;

c_vs_pb_number_of_sources_w := __common__( 0.00000 ) ;

c_vs_br_mths_fs_w := __common__( map(
    vs_br_mths_fs = NULL           => 0.00000,
    vs_br_mths_fs = -1             => 0.15995,
    vs_br_mths_fs <= 40.0328542095 => 0.16446,
    vs_br_mths_fs <= 46.045174538  => 0.10620,
    vs_br_mths_fs <= 52.0574948665 => 0.06927,
    vs_br_mths_fs <= 79.9835728955 => -0.02668,
    vs_br_mths_fs <= 113.954825465 => -0.16575,
    vs_br_mths_fs <= 215.047227925 => -0.23042,
    vs_br_mths_fs <= 259.466119095 => -0.32882,
    vs_br_mths_fs <= 288.887063655 => -0.56406,
    vs_br_mths_fs <= 439.03080082  => -0.64676,
                                      -0.90995) ) ;

c_vs_br_dead_business_count_w := __common__( map(
    vs_br_dead_business_count = NULL => 0.00000,
    vs_br_dead_business_count = -1   => 0.00000,
    vs_br_dead_business_count <= 0.5 => -0.03651,
                                        0.11377) ) ;

c_vs_br_active_phone_count_w := __common__( map(
    vs_br_active_phone_count = NULL => 0.00000,
    vs_br_active_phone_count = -1   => 0.00000,
    vs_br_active_phone_count <= 0.5 => 0.14873,
    vs_br_active_phone_count <= 1.5 => -0.14960,
    vs_br_active_phone_count <= 2.5 => -0.31082,
    vs_br_active_phone_count <= 3.5 => -0.39871,
    vs_br_active_phone_count <= 4.5 => -0.47623,
    vs_br_active_phone_count <= 5.5 => -0.82346,
                                       -0.95214) ) ;

c_vs_email_count_w := __common__( map(
    vs_email_count = NULL => 0.00000,
    vs_email_count = -1   => 0.00000,
    vs_email_count <= 0   => 0.12660,
    vs_email_count <= 1   => -0.04445,
    vs_email_count <= 2   => -0.07738,
    vs_email_count <= 5   => -0.10033,
    vs_email_count <= 9.5 => 0.21847,
                             0.58567) ) ;

c_vs_email_domain_free_count_w := __common__( map(
    vs_email_domain_free_count = NULL => 0.00000,
    vs_email_domain_free_count = -1   => 0.00000,
    vs_email_domain_free_count <= 0.5 => -0.06058,
    vs_email_domain_free_count <= 1.5 => 0.02192,
    vs_email_domain_free_count <= 2.5 => 0.09472,
    vs_email_domain_free_count <= 3.5 => 0.17439,
    vs_email_domain_free_count <= 4.5 => 0.37563,
                                         0.51286) ) ;

c_vs_email_domain_edu_count_w := __common__( map(
    vs_email_domain_edu_count = NULL => 0.00000,
    vs_email_domain_edu_count = -1   => 0.00000,
    vs_email_domain_edu_count <= 0.5 => 0.00745,
                                        -0.39425) ) ;

c_vs_college_tier_w := __common__( map(
    vs_college_tier = NULL => 0.00000,
    vs_college_tier = -1   => 1.11226,
    vs_college_tier <= 1.5 => -0.80274,
    vs_college_tier <= 2.5 => -0.31965,
    vs_college_tier <= 3.5 => -0.05275,
    vs_college_tier <= 4.5 => 0.10779,
                              0.54352) ) ;

c_vs_prof_license_flag_w := __common__( map(
    vs_prof_license_flag = NULL => 0.00000,
    vs_prof_license_flag = -1   => 0.00000,
    vs_prof_license_flag <= 0.5 => 0.05818,
                                   -0.38783) ) ;

c_vs_ver_src_cons_vo_mths_ls_w := __common__( map(
    vs_ver_src_cons_vo_mths_ls = NULL          => 0.00000,
    vs_ver_src_cons_vo_mths_ls = -1            => 0.01379,
    vs_ver_src_cons_vo_mths_ls <= 1.0020533881 => -0.24285,
                                                  0.31383) ) ;

c_vs_ver_sources_am_pop_w := __common__( map(
    vs_ver_sources_am_pop = NULL => 0.00000,
    vs_ver_sources_am_pop <= 0.5 => 0.00790,
                                    -0.50074) ) ;

bv_bus_rep_source_profile := __common__( -2.39363071732448 +
    c_vs_gb_id_mth_fseen_w * 0.561921735535521 +
    c_vs_gb_id_mth_lseen_w * 0.446192049813919 +
    c_vs_ver_src_id__bm_w * 0.815988410427249 +
    c_vs_ver_src_id__in_w * 0.722107251116503 +
    c_vs_util_adl_count_w * 0.23652709024066 +
    c_vs_util_adl_mths_fs_w * 0.834215722197455 +
    c_vs_gong_adl_mths_ls_w * 0.642495107692174 +
    c_vs_header_mths_fs_w * 0.45748271601604 +
    c_vs_pb_mths_fs_w * 0.314196492271953 +
    c_vs_pb_mths_ls_w * 0.384212704955365 +
    c_vs_pb_number_of_sources_w * 0.465079988542644 +
    c_vs_br_mths_fs_w * 0.466139725154086 +
    c_vs_br_dead_business_count_w * 1.85569892438593 +
    c_vs_br_active_phone_count_w * 0.432879002285089 +
    c_vs_email_count_w * 0.430921169156664 +
    c_vs_email_domain_free_count_w * 0.866803684901861 +
    c_vs_email_domain_edu_count_w * 1.01800026256824 +
    c_vs_college_tier_w * 0.982093772667627 +
    c_vs_prof_license_flag_w * 0.660765941536277 +
    c_vs_ver_src_cons_vo_mths_ls_w * 0.677134518064185 +
    c_vs_ver_sources_am_pop_w * 0.860183034397654 ) ;

r_vs_adl_util_i_w := __common__( map(
    vs_adl_util_i = NULL => 0.00000,
    vs_adl_util_i = -1   => -0.21442,
    vs_adl_util_i <= 0.5 => 0.16661,
                            0.32090) ) ;

r_vs_util_adl_count_w := __common__( map(
    vs_util_adl_count = NULL  => 0.00000,
    vs_util_adl_count <= 0.5  => -0.21937,
    vs_util_adl_count <= 1.5  => -0.06067,
    vs_util_adl_count <= 2.5  => 0.15314,
    vs_util_adl_count <= 4.5  => 0.29960,
    vs_util_adl_count <= 6.5  => 0.44774,
    vs_util_adl_count <= 7.5  => 0.53142,
    vs_util_adl_count <= 11.5 => 0.58502,
                                 0.80562) ) ;

r_vs_util_adl_mths_fs_w := __common__( map(
    vs_util_adl_mths_fs = NULL           => 0.00000,
    vs_util_adl_mths_fs = -1             => -0.17300,
    vs_util_adl_mths_fs <= 18.1190965095 => 0.17201,
    vs_util_adl_mths_fs <= 43.0554414785 => 0.30402,
    vs_util_adl_mths_fs <= 63.09650924   => 0.45759,
                                            0.77814) ) ;

r_vs_gong_adl_mths_ls_w := __common__( map(
    vs_gong_adl_mths_ls = NULL           => 0.00000,
    vs_gong_adl_mths_ls = -1             => 0.18245,
    vs_gong_adl_mths_ls <= 1.1663244353  => -0.25396,
    vs_gong_adl_mths_ls <= 43.6468172485 => 0.12138,
    vs_gong_adl_mths_ls <= 98.316221766  => 0.17905,
                                            0.26491) ) ;

r_vs_header_mths_fs_w := __common__( map(
    vs_header_mths_fs = NULL           => 0.00000,
    vs_header_mths_fs = -1             => 0.00000,
    vs_header_mths_fs <= 52.501026694  => 0.98807,
    vs_header_mths_fs <= 77.979466119  => 0.71402,
    vs_header_mths_fs <= 102.981519505 => 0.59182,
    vs_header_mths_fs <= 125.026694045 => 0.42053,
    vs_header_mths_fs <= 128.016427105 => 0.35482,
    vs_header_mths_fs <= 151.014373715 => 0.29992,
    vs_header_mths_fs <= 233.971252565 => 0.18535,
    vs_header_mths_fs <= 266.480492815 => 0.15573,
    vs_header_mths_fs <= 273.034907595 => 0.11123,
    vs_header_mths_fs <= 286.50513347  => 0.07083,
    vs_header_mths_fs <= 288.476386035 => -0.00697,
    vs_header_mths_fs <= 302.488706365 => -0.04193,
    vs_header_mths_fs <= 337.002053385 => -0.08453,
    vs_header_mths_fs <= 344           => -0.12862,
    vs_header_mths_fs <= 357.010266945 => -0.19123,
    vs_header_mths_fs <= 360.985626285 => -0.23830,
    vs_header_mths_fs <= 403.991786445 => -0.30308,
    vs_header_mths_fs <= 426.989733055 => -0.31986,
                                          -0.46326) ) ;

r_vs_pb_mths_fs_w := __common__( 0.00000 ) ;

r_vs_pb_mths_ls_w := __common__( 0.00000 ) ;

r_vs_pb_number_of_sources_w := __common__( 0.00000 ) ;

r_vs_br_mths_fs_w := __common__( map(
    vs_br_mths_fs = NULL           => 0.00000,
    vs_br_mths_fs = -1             => 0.15995,
    vs_br_mths_fs <= 17.527720739  => 0.17528,
    vs_br_mths_fs <= 40.0328542095 => 0.15277,
    vs_br_mths_fs <= 46.045174538  => 0.10620,
    vs_br_mths_fs <= 52.0574948665 => 0.06927,
    vs_br_mths_fs <= 71.0143737165 => -0.02151,
    vs_br_mths_fs <= 79.9835728955 => -0.03871,
    vs_br_mths_fs <= 113.954825465 => -0.16575,
    vs_br_mths_fs <= 122.529774125 => -0.21536,
    vs_br_mths_fs <= 215.047227925 => -0.23296,
    vs_br_mths_fs <= 222.899383985 => -0.29299,
    vs_br_mths_fs <= 259.466119095 => -0.33784,
    vs_br_mths_fs <= 288.887063655 => -0.56406,
    vs_br_mths_fs <= 439.03080082  => -0.64676,
                                      -0.90995) ) ;

r_vs_br_business_count_w := __common__( map(
    vs_br_business_count = NULL  => 0.00000,
    vs_br_business_count = -1    => 0.00000,
    vs_br_business_count <= 0.5  => 0.17346,
    vs_br_business_count <= 1.5  => 0.03279,
    vs_br_business_count <= 2.5  => -0.01283,
    vs_br_business_count <= 4.5  => -0.06774,
    vs_br_business_count <= 6.5  => -0.08541,
    vs_br_business_count <= 10.5 => -0.12807,
    vs_br_business_count <= 12.5 => -0.16932,
                                    -0.41378) ) ;

r_vs_br_dead_business_count_w := __common__( map(
    vs_br_dead_business_count = NULL => 0.00000,
    vs_br_dead_business_count = -1   => 0.00000,
    vs_br_dead_business_count <= 0.5 => -0.03651,
    vs_br_dead_business_count <= 8.5 => 0.11186,
                                        0.19728) ) ;

r_vs_br_active_phone_count_w := __common__( map(
    vs_br_active_phone_count = NULL => 0.00000,
    vs_br_active_phone_count = -1   => 0.00000,
    vs_br_active_phone_count <= 0.5 => 0.14873,
    vs_br_active_phone_count <= 1.5 => -0.14960,
    vs_br_active_phone_count <= 2.5 => -0.31082,
    vs_br_active_phone_count <= 3.5 => -0.39871,
    vs_br_active_phone_count <= 4.5 => -0.47623,
    vs_br_active_phone_count <= 5.5 => -0.82346,
                                       -0.95214) ) ;

r_vs_email_count_w := __common__( map(
    vs_email_count = NULL => 0.00000,
    vs_email_count = -1   => 0.00000,
    vs_email_count <= 0   => 0.12660,
    vs_email_count <= 1   => -0.04445,
    vs_email_count <= 2   => -0.07738,
    vs_email_count <= 3   => -0.11055,
    vs_email_count <= 5   => -0.08999,
    vs_email_count <= 9.5 => 0.21847,
                             0.58567) ) ;

r_vs_email_domain_free_count_w := __common__( map(
    vs_email_domain_free_count = NULL => 0.00000,
    vs_email_domain_free_count = -1   => 1.03909,
    vs_email_domain_free_count <= 0.5 => -0.06342,
    vs_email_domain_free_count <= 1.5 => 0.01909,
    vs_email_domain_free_count <= 2.5 => 0.09188,
    vs_email_domain_free_count <= 3.5 => 0.17155,
    vs_email_domain_free_count <= 4.5 => 0.37279,
                                         0.51003) ) ;

r_vs_email_domain_edu_count_w := __common__( map(
    vs_email_domain_edu_count = NULL => 0.00000,
    vs_email_domain_edu_count = -1   => 0.00000,
    vs_email_domain_edu_count <= 0.5 => 0.00745,
                                        -0.39425) ) ;

r_vs_historical_count_w := __common__( map(
    vs_historical_count = NULL  => 0.00000,
    vs_historical_count = -1    => 0.00000,
    vs_historical_count <= 0.5  => -0.06391,
    vs_historical_count <= 23.5 => 0.04499,
                                   0.25088) ) ;

r_vs_college_tier_w := __common__( map(
    vs_college_tier = NULL => 0.00000,
    vs_college_tier = -1   => 1.11226,
    vs_college_tier <= 1.5 => -0.80274,
    vs_college_tier <= 2.5 => -0.31965,
    vs_college_tier <= 3.5 => -0.05275,
    vs_college_tier <= 4.5 => 0.10779,
                              0.54352) ) ;

r_vs_prof_license_flag_w := __common__( map(
    vs_prof_license_flag = NULL => 0.00000,
    vs_prof_license_flag = -1   => 0.00000,
    vs_prof_license_flag <= 0.5 => 0.05818,
                                   -0.38783) ) ;

r_vs_ver_src_cons_vo_mths_ls_w := __common__( map(
    vs_ver_src_cons_vo_mths_ls = NULL          => 0.00000,
    vs_ver_src_cons_vo_mths_ls = -1            => 0.01379,
    vs_ver_src_cons_vo_mths_ls <= 1.0020533881 => -0.24285,
    vs_ver_src_cons_vo_mths_ls <= 12.501026694 => 0.22439,
                                                  0.32655) ) ;

r_vs_ver_sources_wp_pop_w := __common__( map(
    vs_ver_sources_wp_pop = NULL => 0.00000,
    vs_ver_sources_wp_pop <= 0.5 => 0.17600,
                                    -0.07426) ) ;

r_vs_ver_sources_am_pop_w := __common__( map(
    vs_ver_sources_am_pop = NULL => 0.00000,
    vs_ver_sources_am_pop <= 0.5 => 0.00790,
                                    -0.50074) ) ;

r_vs_ver_sources_e1_pop_w := __common__( map(
    vs_ver_sources_e1_pop = NULL => 0.00000,
    vs_ver_sources_e1_pop <= 0.5 => 0.00829,
                                    -0.10771) ) ;

bv_rep_only_source_profile := __common__( -2.39308403795477 +
    r_vs_adl_util_i_w * 0.0145303904477801 +
    r_vs_util_adl_count_w * 0.301080905323183 +
    r_vs_util_adl_mths_fs_w * 0.784719506644756 +
    r_vs_gong_adl_mths_ls_w * 0.630896965014121 +
    r_vs_header_mths_fs_w * 0.53388040642068 +
    r_vs_pb_mths_fs_w * 0.322051661030712 +
    r_vs_pb_mths_ls_w * 0.375041049591824 +
    r_vs_pb_number_of_sources_w * 0.438136773478832 +
    r_vs_br_mths_fs_w * 0.499172726775049 +
    r_vs_br_business_count_w * 0.00539884864031974 +
    r_vs_br_dead_business_count_w * 1.89910108177779 +
    r_vs_br_active_phone_count_w * 0.477752147732435 +
    r_vs_email_count_w * 0.468259946672664 +
    r_vs_email_domain_free_count_w * 0.619360369537691 +
    r_vs_email_domain_edu_count_w * 1.03144544841865 +
    r_vs_historical_count_w * 1.47932630371083 +
    r_vs_college_tier_w * 0.75027291107173 +
    r_vs_prof_license_flag_w * 0.639957001524596 +
    r_vs_ver_src_cons_vo_mths_ls_w * 0.737884857021843 +
    r_vs_ver_sources_wp_pop_w * 0.0574268119550084 +
    r_vs_ver_sources_am_pop_w * 0.854315518533643 +
    r_vs_ver_sources_e1_pop_w * 0.41909038777041 ) ;

b_vs_gb_id_mth_fseen_w := __common__( map(
    vs_gb_id_mth_fseen = NULL   => 0.00000,
    vs_gb_id_mth_fseen <= 3.5   => 1.18469,
    vs_gb_id_mth_fseen <= 5.5   => 1.00816,
    vs_gb_id_mth_fseen <= 7.5   => 0.97594,
    vs_gb_id_mth_fseen <= 16.5  => 0.76821,
    vs_gb_id_mth_fseen <= 19.5  => 0.67103,
    vs_gb_id_mth_fseen <= 24.5  => 0.54833,
    vs_gb_id_mth_fseen <= 38.5  => 0.20462,
    vs_gb_id_mth_fseen <= 83.5  => -0.01942,
    vs_gb_id_mth_fseen <= 101.5 => -0.13725,
                                   -0.25131) ) ;

b_vs_gb_id_mth_lseen_w := __common__( map(
    vs_gb_id_mth_lseen = NULL   => 0.00000,
    vs_gb_id_mth_lseen <= 5     => 0.24469,
    vs_gb_id_mth_lseen <= 14.5  => 0.15837,
    vs_gb_id_mth_lseen <= 32.5  => -0.05135,
    vs_gb_id_mth_lseen <= 37.5  => -0.15769,
    vs_gb_id_mth_lseen <= 136.5 => -0.32490,
    vs_gb_id_mth_lseen <= 142.5 => -0.40067,
                                   -0.44574) ) ;

b_vs_ver_src_id__ut_w := __common__( map(
    vs_ver_src_id__ut = NULL => 0.00000,
    vs_ver_src_id__ut <= 0.5 => -0.00404,
                                0.27518) ) ;

b_vs_ver_src_id__bm_w := __common__( map(
    vs_ver_src_id__bm = NULL => 0.00000,
    vs_ver_src_id__bm <= 0.5 => 0.00709,
                                -1.24297) ) ;

b_vs_ver_src_id__i_w := __common__( map(
    vs_ver_src_id__i = NULL => 0.00000,
    vs_ver_src_id__i <= 0.5 => 0.03682,
                               -0.55654) ) ;

b_vs_v2_id_mth_fseen_w := __common__( map(
    vs_v2_id_mth_fseen = NULL   => 0.00000,
    vs_v2_id_mth_fseen <= 6.5   => 0.66077,
    vs_v2_id_mth_fseen <= 12.5  => 0.51001,
    vs_v2_id_mth_fseen <= 21.5  => 0.33955,
    vs_v2_id_mth_fseen <= 40.5  => 0.23354,
    vs_v2_id_mth_fseen <= 47.5  => 0.19803,
    vs_v2_id_mth_fseen <= 91.5  => 0.06400,
    vs_v2_id_mth_fseen <= 97.5  => -0.06275,
    vs_v2_id_mth_fseen <= 160.5 => -0.15919,
    vs_v2_id_mth_fseen <= 182.5 => -0.17426,
                                   -0.28772) ) ;

b_vs_v2_id_mth_lseen_w := __common__( map(
    vs_v2_id_mth_lseen = NULL => 0.00000,
    vs_v2_id_mth_lseen <= 0.5 => -0.15569,
                                 0.18778) ) ;

bv_bus_only_source_profile := __common__( -2.28659863446935 +
    b_vs_gb_id_mth_fseen_w * 0.731914265073424 +
    b_vs_gb_id_mth_lseen_w * 0.723388216510074 +
    b_vs_ver_src_id__ut_w * 1.35963627629314 +
    b_vs_ver_src_id__bm_w * 0.930806740119904 +
    b_vs_ver_src_id__i_w * 0.811612004655868 +
    b_vs_v2_id_mth_fseen_w * 0.544847340558092 +
    b_vs_v2_id_mth_lseen_w * 0.995501979514548 ) ;

truebiz_ln := __common__( id_seleID != '0' and NOT(((integer)ver_src_id_count in [-1, 0])) ) ;

iv_rv5_unscorable := __common__( if(NAS_Summary <= 4 and NAP_Summary <= 4 and Infutor_NAP <= 4 and Add_Input_NAProp <= 3 and TrueDID = false, 1, 0) ) ;

rv_a46_curr_avm_autoval := __common__( if(not(truedid), NULL, add_curr_avm_auto_val) ) ;

rv_d30_derog_count := __common__( if(not(truedid), NULL, min(if(if(max(criminal_count, attr_bankruptcy_count60, attr_eviction_count, attr_num_unrel_liens60) = NULL, NULL, sum(if(criminal_count = NULL, 0, criminal_count), if(attr_bankruptcy_count60 = NULL, 0, attr_bankruptcy_count60), if(attr_eviction_count = NULL, 0, attr_eviction_count), if(attr_num_unrel_liens60 = NULL, 0, attr_num_unrel_liens60))) = NULL, -NULL, if(max(criminal_count, attr_bankruptcy_count60, attr_eviction_count, attr_num_unrel_liens60) = NULL, NULL, sum(if(criminal_count = NULL, 0, criminal_count), if(attr_bankruptcy_count60 = NULL, 0, attr_bankruptcy_count60), if(attr_eviction_count = NULL, 0, attr_eviction_count), if(attr_num_unrel_liens60 = NULL, 0, attr_num_unrel_liens60)))), 999)) ) ;

bv_assoc_judg_tot := __common__( map(
    not(truebiz_ln) => NULL,
    (integer)assoc_count = 0 => -1,
    (integer) assoc_judg_total) ) ;

rv_i61_inq_collection_recency := __common__( map(
    not(truedid)           => NULL,
    inq_collection_count01 > 0 => 1,
    inq_collection_count03 > 0 => 3,
    inq_collection_count06 > 0 => 6,
    inq_collection_count12 > 0 => 12,
    inq_collection_count24 > 0=> 24,
    inq_collection_count > 0  => 99,
                              0) ) ;

_inq_banko_cm_last_seen := __common__( common.sas_date((string)(Inq_banko_cm_last_seen)) ) ;

nf_mos_inq_banko_cm_lseen := __common__( map(
    not(truedid)                   => NULL,
    _inq_banko_cm_last_seen = NULL => -1,
    min(if(if ((sysdate - _inq_banko_cm_last_seen) / (365.25 / 12) >= 0, truncate((sysdate - _inq_banko_cm_last_seen) / (365.25 / 12)), roundup((sysdate - _inq_banko_cm_last_seen) / (365.25 / 12))) = NULL, -NULL, if ((sysdate - _inq_banko_cm_last_seen) / (365.25 / 12) >= 0, truncate((sysdate - _inq_banko_cm_last_seen) / (365.25 / 12)), roundup((sysdate - _inq_banko_cm_last_seen) / (365.25 / 12)))), 999)) ) ;

bx_addr_assessed_value := __common__( if(not(truebiz_ln) or (integer)pop_bus_addr = 0, NULL, (integer) addr_input_assessed_value) ) ;

bv_sos_current_standing := __common__( map(
    not(truebiz_ln)          => NULL,
    (integer)sos_inc_filing_count = 0 => -1,
    (integer) sos_standing) ) ;

mortgage_type := __common__( if(truedid and add_curr_pop, add_curr_mortgage_type, '') ) ;

mortgage_present := __common__( if(truedid and add_curr_pop, ((add_curr_mortgage_date not in [0, NULL])), false) ) ;

iv_curr_add_mortgage_type := __common__( map(
    not(truedid and add_curr_pop)                         => '               ',
    (mortgage_type in ['CNV', 'N'])                       => 'CONVENTIONAL   ',
    (mortgage_type in ['FHA', 'G', 'VA'])                 => 'GOVERNMENT     ',
    (mortgage_type in ['1', 'D'])                         => 'PIGGYBACK      ',
    (mortgage_type in ['2', 'E', 'R', 'C'])               => 'EQUITY LOAN    ',
    (mortgage_type in ['I', 'K', 'O', 'LHM', 'T', 'SBA']) => 'COMMERCIAL     ',
    (mortgage_type in ['H', 'J'])                         => 'HIGH-RISK      ',
    (mortgage_type in ['PMM', 'PP', 'S', 'L'])            => 'NON-TRADITIONAL',
    (mortgage_type in ['U'])                              => 'UNKNOWN        ',
    not(mortgage_type = '')				                            => 'OTHER          ',
    mortgage_present                                      => 'UNKNOWN        ',
                                                             'NO MORTGAGE') ) ;

source_ar := __common__( Models.Common.findw_cpp(ver_src_list, 'AR' ,  , '') > 0 ) ;

source_ba := __common__( Models.Common.findw_cpp(ver_src_list, 'BA' ,  , '') > 0 ) ;

source_bm := __common__( Models.Common.findw_cpp(ver_src_list, 'BM' ,  , '') > 0 ) ;

source_br := __common__( Models.Common.findw_cpp(ver_src_list, 'BR' ,  , '') > 0 ) ;

source_c := __common__( Models.Common.findw_cpp(ver_src_list, 'C' ,  , '') > 0 ) ;

source_cs := __common__( Models.Common.findw_cpp(ver_src_list, 'C#' ,  , '') > 0 ) ;

source_da := __common__( Models.Common.findw_cpp(ver_src_list, 'DA' ,  , '') > 0 ) ;

source_df := __common__( Models.Common.findw_cpp(ver_src_list, 'DF' ,  , '') > 0 ) ;

source_dn := __common__( Models.Common.findw_cpp(ver_src_list, 'DN' ,  , '') > 0 ) ;

source_ef := __common__( Models.Common.findw_cpp(ver_src_list, 'EF' ,  , '') > 0 ) ;

source_er := __common__( Models.Common.findw_cpp(ver_src_list, 'ER' ,  , '') > 0 ) ;

source_fb := __common__( Models.Common.findw_cpp(ver_src_list, 'FB' ,  , '') > 0 ) ;

source_ft := __common__( Models.Common.findw_cpp(ver_src_list, 'FT' ,  , '') > 0 ) ;

source_gb := __common__( Models.Common.findw_cpp(ver_src_list, 'GB' ,  , '') > 0 ) ;

source_i := __common__( Models.Common.findw_cpp(ver_src_list, 'I' ,  , '') > 0 ) ;

source_ia := __common__( Models.Common.findw_cpp(ver_src_list, 'IA' ,  , '') > 0 ) ;

source_ic := __common__( Models.Common.findw_cpp(ver_src_list, 'IC' ,  , '') > 0 ) ;

source_in := __common__( Models.Common.findw_cpp(ver_src_list, 'IN' ,  , '') > 0 ) ;

source_l0 := __common__( Models.Common.findw_cpp(ver_src_list, 'L0' ,  , '') > 0 ) ;

source_l2 := __common__( Models.Common.findw_cpp(ver_src_list, 'L2' ,  , '') > 0 ) ;

source_os := __common__( Models.Common.findw_cpp(ver_src_list, 'OS' ,  , '') > 0 ) ;

source_p := __common__( Models.Common.findw_cpp(ver_src_list, 'P' ,  , '') > 0 ) ;

source_pp := __common__( Models.Common.findw_cpp(ver_src_list, 'PP' ,  , '') > 0 ) ;

source_q3 := __common__( Models.Common.findw_cpp(ver_src_list, 'Q3' ,  , '') > 0 ) ;

source_tx := __common__( Models.Common.findw_cpp(ver_src_list, 'TX' ,  , '') > 0 ) ;

source_u := __common__( Models.Common.findw_cpp(ver_src_list, 'U' ,  , '') > 0 ) ;

source_ut := __common__( Models.Common.findw_cpp(ver_src_list, 'UT' ,  , '') > 0 ) ;

source_v2 := __common__( Models.Common.findw_cpp(ver_src_list, 'V2' ,  , '') > 0 ) ;

source_wa := __common__( Models.Common.findw_cpp(ver_src_list, 'WA' ,  , '') > 0 ) ;

source_wk := __common__( Models.Common.findw_cpp(ver_src_list, 'WK' ,  , '') > 0 ) ;

num_pos_sources := __common__( if(max((integer)source_ar, (integer)source_bm, (integer)source_c, (integer)source_cs, (integer)source_dn, (integer)source_ef, (integer)source_ft, (integer)source_i, (integer)source_ia, (integer)source_in, (integer)source_p, (integer)source_v2, (integer)source_wk) = NULL, NULL, sum((integer)source_ar, (integer)source_bm, (integer)source_c, (integer)source_cs, (integer)source_dn, (integer)source_ef, (integer)source_ft, (integer)source_i, (integer)source_ia, (integer)source_in, (integer)source_p, (integer)source_v2, (integer)source_wk)) ) ;

num_neg_sources := __common__( if(max((integer)source_ba, (integer)source_l2, (integer)source_ut) = NULL, NULL, sum((integer)source_ba, (integer)source_l2, (integer)source_ut)) ) ;

bv_ver_src_derog_ratio := __common__( map(
    not(truebiz_ln)                                                                                                                                                 => NULL,
    ver_src_list = ''                                                                                                                                             => -1,
    if(max(num_pos_sources, num_neg_sources) = NULL, NULL, 
        sum(if(num_pos_sources = NULL, 0, num_pos_sources), 
            if(num_neg_sources = NULL, 0, num_neg_sources))) = 0 => -2,
    num_neg_sources > 0  => round(((num_neg_sources / 
                                  if(max(num_pos_sources, num_neg_sources) = NULL, NULL, 
                                  sum(if(num_pos_sources = NULL, 0, num_pos_sources), 
                                      if(num_neg_sources = NULL, 0, num_neg_sources)))/.1)*.1),1),
    100 + num_pos_sources) ) ;

bv_mth_ver_src_p_ls_1 := __common__( if(not(truebiz_ln), NULL, NULL) ) ;

bv_mth_ver_src_p_ls := __common__( if(not(_ver_src_id__p), -1, mth__ver_src_id_ldate_p) ) ;

rv_d34_attr_liens_recency := __common__( map(
    not(truedid)                                                              => NULL,
    (boolean)attr_num_rel_liens30 or (boolean)attr_num_unrel_liens30          => 1,
    (boolean)attr_num_rel_liens90 or (boolean)attr_num_unrel_liens90          => 3,
    (boolean)attr_num_rel_liens180 or (boolean)attr_num_unrel_liens180        => 6,
    (boolean)attr_num_rel_liens12 or (boolean)attr_num_unrel_liens12          => 12,
    (boolean)attr_num_rel_liens24 or (boolean)attr_num_unrel_liens24          => 24,
    (boolean)attr_num_rel_liens36 or (boolean)attr_num_unrel_liens36          => 36,
    (boolean)attr_num_rel_liens60 or (boolean)attr_num_unrel_liens60          => 60,
    liens_historical_released_count > 0 or liens_historical_unreleased_ct > 0 => 99,
                                                                                 0) ) ;

bv_lien_avg_amount := __common__( map(
    not(truebiz_ln)       => NULL,
    (integer)lien_filed_count <= 0 => -1,
    (integer) lien_total_amount / (integer) lien_filed_count) ) ;

bv_lien_total_amount := __common__( map(
    not(truebiz_ln)       => NULL,
    (integer)lien_filed_count <= 0 => -1,
    (integer) lien_total_amount) ) ;

nf_fp_varrisktype := __common__( map(
    not(truedid)          => NULL,
    (integer) fp_varrisktype = 0 => NULL,
    (integer) trim(fp_varrisktype, LEFT)) ) ;

bv_ver_src_id_mth_since_fs := __common__( if(not(truebiz_ln), NULL, (integer) ver_src_id_mth_since_fs) ) ;

nf_fp_srchunvrfdssncount := __common__( if(not(truedid), NULL, min(if((integer) fp_srchunvrfdssncount = NULL, -NULL, (integer) fp_srchunvrfdssncount), 999)) ) ;

_judg_filed_firstseen := __common__( common.sas_date((string)(judg_filed_firstseen)) ) ;

bv_judg_filed_mth_fs := __common__( map(
    not(truebiz_ln)              => NULL,
    _judg_filed_firstseen = NULL => -1,
    if ((sysdate - _judg_filed_firstseen) / (365.25 / 12) >= 0, roundup((sysdate - _judg_filed_firstseen) / (365.25 / 12)), truncate((sysdate - _judg_filed_firstseen) / (365.25 / 12)))) ) ;

rv_a41_prop_owner := __common__( map(
    not(truedid)                                                           => NULL,
    add_curr_naprop = 4 or add_prev_naprop = 4 or property_owned_total > 0 => 1,
                                                                              0) ) ;

_sos_agent_change_lastseen := __common__( common.sas_date((string)(sos_agent_change_lastseen)) ) ;

bv_sos_mth_agent_change := __common__( map(
    not(truebiz_ln)                   => NULL,
    _sos_agent_change_lastseen = NULL => -1,
                                         if ((sysdate - _sos_agent_change_lastseen) / (365.25 / 12) >= 0, roundup((sysdate - _sos_agent_change_lastseen) / (365.25 / 12)), truncate((sysdate - _sos_agent_change_lastseen) / (365.25 / 12)))) ) ;

bv_assoc_lien_tot := __common__( map(
    not(truebiz_ln) => NULL,
    (integer)assoc_count = 0 => -1,
    (integer)assoc_lien_total) ) ;

bx_addr_lres := __common__( map(
    not(truebiz_ln) or (integer)pop_bus_addr = 0                                                                       => NULL,
    trim((string)ver_addr_src_firstseen_list, ALL) = '' or 
		trim((string)ver_addr_src_lastseen_list, ALL) = '' => -1,
    (integer) addr_input_lres) ) ;

rv_d32_attr_felonies_recency := __common__( map(
    not(truedid)     => NULL,
    attr_felonies30 >= 1  => 1,
    attr_felonies90 >= 1 => 3,
    attr_felonies180 >= 1=> 6,
    attr_felonies12 >= 1 => 12,
    attr_felonies24 >= 1 => 24,
    attr_felonies36 >= 1 => 36,
    attr_felonies60 >= 1 => 60,
    felony_count > 0 => 99,
                        0) ) ;

rv_ever_asset_owner := __common__( map(
    not(truedid)                                                                                                                                                                         => NULL,
    add_curr_naprop = 4 or add_prev_naprop = 4 or property_owned_total > 0 or Models.Common.findw_cpp(ver_sources, 'P' , ', ', 'E') > 0 or watercraft_count > 0 or attr_num_aircraft > 0 => 1,
                                                                                                                                                                                            0) ) ;

rv_d34_attr_unrel_liens_recency := __common__( map(
    not(truedid)                       => NULL,
    attr_num_unrel_liens30 >=1            => 1,
    attr_num_unrel_liens90 >=1            => 3,
    attr_num_unrel_liens180 >=1         => 6,
    attr_num_unrel_liens12 >=1      => 12,
    attr_num_unrel_liens24 >=1   => 24,
    attr_num_unrel_liens36 >=1=> 36,
    attr_num_unrel_liens60  >=1 => 60,
    liens_historical_unreleased_ct > 0 => 99,
                                          0) ) ;

rv_a44_curr_add_naprop := __common__( if(not(truedid and add_curr_pop), NULL, add_curr_naprop) ) ;

bv_mth_bureau_fs := __common__( map(
    not(truebiz_ln)                  => NULL,
    (integer)ver_src_bureau_mth_since_fs = -1 => -1,
    (integer) ver_src_bureau_mth_since_fs) ) ;

rv_i60_inq_auto_count12 := __common__( if(not(truedid), NULL, min(if(inq_auto_count12 = NULL, -NULL, inq_auto_count12), 999)) ) ;

br_first_seen_char := __common__( br_first_seen ) ;

_br_first_seen := __common__( common.sas_date((string)(br_first_seen_char)) ) ;

rv_mos_since_br_first_seen := __common__( map(
    not(truedid)          => NULL,
    _br_first_seen = NULL => -1,
                             min(if(if ((sysdate - _br_first_seen) / (365.25 / 12) >= 0, truncate((sysdate - _br_first_seen) / (365.25 / 12)), roundup((sysdate - _br_first_seen) / (365.25 / 12))) = NULL, -NULL, if ((sysdate - _br_first_seen) / (365.25 / 12) >= 0, truncate((sysdate - _br_first_seen) / (365.25 / 12)), roundup((sysdate - _br_first_seen) / (365.25 / 12)))), 999)) ) ;

nf_fp_srchvelocityrisktype := __common__( map(
    not(truedid)                   => NULL,
    fp_srchvelocityrisktype = '' => NULL,
    (INTEGER) trim(fp_srchvelocityrisktype, LEFT)) ) ;

rv_d33_eviction_count := __common__( if(not(truedid), NULL, min(if(attr_eviction_count = NULL, -NULL, attr_eviction_count), 999)) ) ;

bv_lien_ft_count := __common__( if(not(truebiz_ln), NULL, (integer) lien_filed_FT_ct) ) ;

rv_d34_unrel_liens_ct := __common__( if(not(truedid), NULL, min(if(liens_recent_unreleased_count = NULL, -NULL, liens_recent_unreleased_count), 999)) ) ;

bv_assoc_derog_pct := __common__( map(
    not(truebiz_ln)  => NULL,
    (integer)assoc_count <= 0 => -1,
     max((integer)assoc_felony_count, (integer)assoc_bankruptcy_count12, (integer)assoc_lien_count, (integer)assoc_judg_count) / (integer)assoc_count) ) ;

nf_fp_srchunvrfdphonecount := __common__( if(not(truedid), NULL, min(if((integer) fp_srchunvrfdphonecount = NULL, -NULL, (integer)fp_srchunvrfdphonecount), 999)) ) ;

rv_i60_inq_comm_recency := __common__( map(
    not(truedid)               => NULL,
    inq_communications_count01 >= 1 => 1,
    inq_communications_count03 >= 1 => 3,
    inq_communications_count06 >= 1 => 6,
    inq_communications_count12 >= 1 => 12,
    inq_communications_count24 >= 1 => 24,
    inq_communications_count   >= 1 => 99,
                                  0) ) ;

nf_fp_srchfraudsrchcountyr := __common__( if(not(truedid), NULL, min(if((integer)fp_srchfraudsrchcountyr = NULL, -NULL, (integer)fp_srchfraudsrchcountyr), 999)) ) ;

bv_ver_src_id_activity12 := __common__( if(not(truebiz_ln), NULL, (integer) ver_src_id_activity12) ) ;

bv_lien_ot_count := __common__( if(not(truebiz_ln), NULL,  (integer)lien_filed_OT_ct) ) ;

bv_judg_avg_amount := __common__( map(
    not(truebiz_ln)       => NULL,
    (integer)judg_filed_count <= 0 => -1,
    (integer)judg_total_amount / (integer)judg_filed_count) ) ;

nf_fp_srchunvrfdaddrcount := __common__( if(not(truedid), NULL, min(if( (integer)fp_srchunvrfdaddrcount = NULL, -NULL,  (integer)fp_srchunvrfdaddrcount), 999)) ) ;

nf_fp_sourcerisktype := __common__( map(
    not(truedid)             => NULL,
    fp_sourcerisktype = '' => NULL,
    (integer) trim(fp_sourcerisktype, LEFT)) ) ;

nf_fp_prevaddrageoldest := __common__( if(not(truedid), NULL, min(if((integer) fp_prevaddrageoldest = NULL, -NULL, (integer) fp_prevaddrageoldest), 999)) ) ;

rv_i60_inq_auto_recency := __common__( map(
    not(truedid)     => NULL,
    inq_auto_count01 >= 1 => 1,
    inq_auto_count03  >= 1 => 3,
    inq_auto_count06 >= 1  => 6,
    inq_auto_count12  >= 1 => 12,
    inq_auto_count24 >= 1  => 24,
    inq_auto_count   >= 1  => 99,
                        0) ) ;

rv_i61_inq_collection_count12 := __common__( if(not(truedid), NULL, min(if((integer) inq_collection_count12 = NULL, -NULL,(integer)  inq_collection_count12), 999)) ) ;

rv_i60_inq_hiriskcred_recency := __common__( map(
    not(truedid)               => NULL,
    inq_highRiskCredit_count01  >= 1 => 1,
    inq_highRiskCredit_count03  >= 1 => 3,
    inq_highRiskCredit_count06 >= 1  => 6,
    inq_highRiskCredit_count12 >= 1  => 12,
    inq_highRiskCredit_count24  >= 1 => 24,
    inq_highRiskCredit_count    >= 1 => 99,
                                  0) ) ;

rv_c14_addrs_per_adl_c6 := __common__( if(not(truedid), NULL, min(if((integer) addrs_per_adl_c6 = NULL, -NULL, (integer) addrs_per_adl_c6), 999)) ) ;

rv_c12_num_nonderogs := __common__( if(not(truedid), NULL, min(if((integer) attr_num_nonderogs = NULL, -NULL, (integer) attr_num_nonderogs), 4)) ) ;

s0_v01_w := __common__( map(
    bv_bus_rep_source_profile = NULL           => 0,
    bv_bus_rep_source_profile = -1             => 0,
    bv_bus_rep_source_profile <= -3.3955322565 => -0.420450712577453,
    bv_bus_rep_source_profile <= -3.1210516065 => -0.332672538469,
    bv_bus_rep_source_profile <= -2.7954245665 => -0.226884632625738,
    bv_bus_rep_source_profile <= -2.690673932  => -0.151015602432734,
    bv_bus_rep_source_profile <= -2.652507892  => -0.127476903187311,
    bv_bus_rep_source_profile <= -2.3596987945 => -0.0383085184992572,
    bv_bus_rep_source_profile <= -2.1244878985 => 0.108909294403979,
    bv_bus_rep_source_profile <= -1.715984092  => 0.184374358350777,
    bv_bus_rep_source_profile <= -1.0046005985 => 0.381875355244527,
                                                  0.652297018639119) ) ;

s0_aa_code_01 := __common__( map(
    s0_v01_w = -0.420450712577453              => '     ',
    bv_bus_rep_source_profile = NULL           => 'B031',
    bv_bus_rep_source_profile = -1             => 'B034',
    bv_bus_rep_source_profile <= -3.3955322565 => 'B034',
    bv_bus_rep_source_profile <= -3.1210516065 => 'B034',
    bv_bus_rep_source_profile <= -2.7954245665 => 'B034',
    bv_bus_rep_source_profile <= -2.690673932  => 'B034',
    bv_bus_rep_source_profile <= -2.652507892  => 'B034',
    bv_bus_rep_source_profile <= -2.3596987945 => 'B034',
    bv_bus_rep_source_profile <= -2.1244878985 => 'B034',
    bv_bus_rep_source_profile <= -1.715984092  => 'B034',
    bv_bus_rep_source_profile <= -1.0046005985 => 'B034',
                                                  'B034') ) ;

s0_aa_dist_01 := __common__( 0 - s0_v01_w ) ;

s0_v02_w := __common__( map(
    rv_a46_curr_avm_autoval = NULL      => 0,
    rv_a46_curr_avm_autoval = -1        => 0,
    rv_a46_curr_avm_autoval <= 0        => 0.0560016662782271,
    rv_a46_curr_avm_autoval <= 74036    => 0.476054334440404,
    rv_a46_curr_avm_autoval <= 140279   => 0.253962623900315,
    rv_a46_curr_avm_autoval <= 164999   => 0.126523026145714,
    rv_a46_curr_avm_autoval <= 200004.5 => 0.0551409985410823,
                                           -0.206958034439097) ) ;

s0_aa_code_02 := __common__( map(
    s0_v02_w = -0.206958034439097       => '     ',
    rv_a46_curr_avm_autoval = NULL      => 'P535',
    rv_a46_curr_avm_autoval = -1        => 'P509',
    rv_a46_curr_avm_autoval <= 0        => 'P509',
    rv_a46_curr_avm_autoval <= 74036    => 'P509',
    rv_a46_curr_avm_autoval <= 140279   => 'P509',
    rv_a46_curr_avm_autoval <= 164999   => 'P509',
    rv_a46_curr_avm_autoval <= 200004.5 => 'P509',
                                           'P509') ) ;

s0_aa_dist_02 := __common__( 0 - s0_v02_w ) ;

s0_v03_w := __common__( map(
    rv_d30_derog_count = NULL => 0,
    rv_d30_derog_count = -1   => 0,
    rv_d30_derog_count <= 0.5 => -0.0881074376235155,
    rv_d30_derog_count <= 1   => 0.0913702617665339,
    rv_d30_derog_count <= 2   => 0.132460577697125,
    rv_d30_derog_count <= 5.5 => 0.241578213192017,
    rv_d30_derog_count <= 6.5 => 0.425834844055478,
                                 0.5329816995126) ) ;

s0_aa_code_03 := __common__( map(
    s0_v03_w = -0.0881074376235155 => '     ',
    rv_d30_derog_count = NULL      => 'P535',
    rv_d30_derog_count = -1        => 'P526',
    rv_d30_derog_count <= 0.5      => 'P526',
    rv_d30_derog_count <= 1        => 'P526',
    rv_d30_derog_count <= 2        => 'P526',
    rv_d30_derog_count <= 5.5      => 'P526',
    rv_d30_derog_count <= 6.5      => 'P526',
                                      'P526') ) ;

s0_aa_dist_03 := __common__( 0 - s0_v03_w ) ;

s0_v04_w := __common__( map(
    bv_rep_only_source_profile = NULL           => 0,
    bv_rep_only_source_profile = -1             => 0,
    bv_rep_only_source_profile <= -3.3087025605 => -0.281258380535393,
    bv_rep_only_source_profile <= -3.207755532  => -0.256076530552618,
    bv_rep_only_source_profile <= -2.851438009  => -0.172479068068911,
    bv_rep_only_source_profile <= -2.761972203  => -0.101602420584594,
    bv_rep_only_source_profile <= -2.598843762  => -0.0593955515773801,
    bv_rep_only_source_profile <= -2.3085220575 => -0.0166410802634012,
    bv_rep_only_source_profile <= -2.034436164  => 0.0795250399991452,
    bv_rep_only_source_profile <= -1.632375088  => 0.143653679711649,
    bv_rep_only_source_profile <= -1.5861383885 => 0.24147982552513,
                                                   0.287465957065813) ) ;

s0_aa_code_04 := __common__( map(
    s0_v04_w = -0.281258380535393               => '     ',
    bv_rep_only_source_profile = NULL           => 'P535',
    bv_rep_only_source_profile = -1             => 'P515',
    bv_rep_only_source_profile <= -3.3087025605 => 'P515',
    bv_rep_only_source_profile <= -3.207755532  => 'P515',
    bv_rep_only_source_profile <= -2.851438009  => 'P515',
    bv_rep_only_source_profile <= -2.761972203  => 'P515',
    bv_rep_only_source_profile <= -2.598843762  => 'P515',
    bv_rep_only_source_profile <= -2.3085220575 => 'P515',
    bv_rep_only_source_profile <= -2.034436164  => 'P515',
    bv_rep_only_source_profile <= -1.632375088  => 'P515',
    bv_rep_only_source_profile <= -1.5861383885 => 'P515',
                                                   'P515') ) ;

s0_aa_dist_04 := __common__( 0 - s0_v04_w ) ;

s0_v05_w := __common__( map(
    bv_assoc_judg_tot = NULL => 0,
    bv_assoc_judg_tot = -1   => 0.0244094712349465,
    bv_assoc_judg_tot <= 0.5 => -0.061231904104776,
    bv_assoc_judg_tot <= 1.5 => 0.329168273901262,
    bv_assoc_judg_tot <= 2   => 0.53168632227103,
                                0.63055536954674) ) ;

s0_aa_code_05 := __common__( map(
    s0_v05_w = -0.061231904104776 => '     ',
    bv_assoc_judg_tot = NULL      => 'B031',
    bv_assoc_judg_tot = -1        => 'B017',
    bv_assoc_judg_tot <= 0.5      => 'B026',
    bv_assoc_judg_tot <= 1.5      => 'B026',
    bv_assoc_judg_tot <= 2        => 'B026',
                                     'B026') ) ;

s0_aa_dist_05 := __common__( 0 - s0_v05_w ) ;

s0_v06_w := __common__( map(
    rv_i61_inq_collection_recency = NULL => 0,
    rv_i61_inq_collection_recency = -1   => 0,
    rv_i61_inq_collection_recency <= 0.5 => -0.107919096830067,
    rv_i61_inq_collection_recency <= 9   => 0.331699094289581,
    rv_i61_inq_collection_recency <= 24  => 0.144892353520593,
                                            -0.107919096830067) ) ;

s0_aa_code_06 := __common__( map(
    s0_v06_w = -0.107919096830067        => '     ',
    rv_i61_inq_collection_recency = NULL => 'P535',
    rv_i61_inq_collection_recency = -1   => 'P540',
    rv_i61_inq_collection_recency <= 0.5 => 'P540',
    rv_i61_inq_collection_recency <= 9   => 'P540',
    rv_i61_inq_collection_recency <= 24  => 'P540',
                                            'P540') ) ;

s0_aa_dist_06 := __common__( 0 - s0_v06_w ) ;

s0_v07_w := __common__( map(
    bv_bus_only_source_profile = NULL           => 0,
    bv_bus_only_source_profile = -1             => 0,
    bv_bus_only_source_profile <= -2.7140256535 => -0.315386297072775,
    bv_bus_only_source_profile <= -2.2563535515 => -0.114270693118023,
    bv_bus_only_source_profile <= -2.255608591  => 0.00860003465733319,
    bv_bus_only_source_profile <= -1.957897059  => 0.0189516900513446,
    bv_bus_only_source_profile <= -1.7091781455 => 0.184402012659872,
    bv_bus_only_source_profile <= -1.2166780885 => 0.354602057146306,
                                                   0.45606398361048) ) ;

s0_aa_code_07 := __common__( map(
    s0_v07_w = -0.315386297072775               => '     ',
    bv_bus_only_source_profile = NULL           => 'B031',
    bv_bus_only_source_profile = -1             => 'B034',
    bv_bus_only_source_profile <= -2.7140256535 => 'B034',
    bv_bus_only_source_profile <= -2.2563535515 => 'B034',
    bv_bus_only_source_profile <= -2.255608591  => 'B034',
    bv_bus_only_source_profile <= -1.957897059  => 'B034',
    bv_bus_only_source_profile <= -1.7091781455 => 'B034',
    bv_bus_only_source_profile <= -1.2166780885 => 'B034',
                                                   'B034') ) ;

s0_aa_dist_07 := __common__( 0 - s0_v07_w ) ;

s0_v08_w := __common__( map(
    nf_mos_inq_banko_cm_lseen = NULL  => 0,
    nf_mos_inq_banko_cm_lseen = -1    => -0.0274238945018624,
    nf_mos_inq_banko_cm_lseen <= 6.5  => 0.466627917528398,
    nf_mos_inq_banko_cm_lseen <= 12.5 => 0.348164490562641,
    nf_mos_inq_banko_cm_lseen <= 59.6 => 0.278040340675528,
                                         -0.0274238945018624) ) ;

s0_aa_code_08 := __common__( map(
    s0_v08_w = -0.0274238945018624    => '     ',
    nf_mos_inq_banko_cm_lseen = NULL  => 'P535',
    nf_mos_inq_banko_cm_lseen = -1    => 'P540',
    nf_mos_inq_banko_cm_lseen <= 6.5  => 'P540',
    nf_mos_inq_banko_cm_lseen <= 12.5 => 'P540',
    nf_mos_inq_banko_cm_lseen <= 59.6 => 'P540',
                                         'P540') ) ;

s0_aa_dist_08 := __common__( 0 - s0_v08_w ) ;

s0_v09_w := __common__( map(
    bx_addr_assessed_value = NULL    => 0,
    bx_addr_assessed_value = -1      => 0,
    bx_addr_assessed_value <= 0      => 0.0814658371628586,
    bx_addr_assessed_value <= 143136 => 0.150531127307204,
    bx_addr_assessed_value <= 192688 => 0.0912812258159474,
    bx_addr_assessed_value <= 219248 => 0.0482266766154843,
    bx_addr_assessed_value <= 266752 => -0.0206059254025205,
                                        -0.0954360671646139) ) ;

s0_aa_code_09 := __common__( map(
    s0_v09_w = -0.0954360671646139   => '     ',
    bx_addr_assessed_value = NULL    => 'B031',
    bx_addr_assessed_value = -1      => 'B069',
    bx_addr_assessed_value <= 0      => 'B069',
    bx_addr_assessed_value <= 143136 => 'B069',
    bx_addr_assessed_value <= 192688 => 'B069',
    bx_addr_assessed_value <= 219248 => 'B069',
    bx_addr_assessed_value <= 266752 => 'B069',
                                        'B069') ) ;

s0_aa_dist_09 := __common__( 0 - s0_v09_w ) ;

s0_v10_w := __common__( map(
    bv_sos_current_standing = NULL => 0,
    bv_sos_current_standing = -1   => -0.0367536943766163,
    bv_sos_current_standing <= 0   => 0,
    bv_sos_current_standing <= 2   => 0.49084339045106,
                                      -0.0367536943766163) ) ;

s0_aa_code_10 := __common__( map(
    s0_v10_w = -0.0367536943766163 => '     ',
    s0_v10_w = 0.49084339045106 => '     ',
		bv_sos_current_standing = NULL => 'B031',
    bv_sos_current_standing = -1   => 'B034',
    bv_sos_current_standing <= 0   => 'B035',
    bv_sos_current_standing <= 1   => 'B059',
    bv_sos_current_standing <= 2.5 => 'B075',
                                      'B034') ) ;

s0_aa_dist_10 := __common__( 0 - s0_v10_w ) ;

s0_v11_w := __common__( map(
    iv_curr_add_mortgage_type = ''                                                          => 0,
    (iv_curr_add_mortgage_type in ['CONVENTIONAL'])                                           => -0.0677291146258545,
    (iv_curr_add_mortgage_type in ['GOVERNMENT', 'NON-TRADITIONAL', 'UNKNOWN', 'COMMERCIAL']) => -0.0120250198819395,
    (iv_curr_add_mortgage_type in ['NO MORTGAGE'])                                            => 0.0463519424827326,
                                                                                                 0) ) ;

s0_aa_code_11 := __common__( map(
    s0_v11_w = -0.0677291146258545                                                            => '     ',
    iv_curr_add_mortgage_type = ''                                                          => 'P535',
    (iv_curr_add_mortgage_type in ['CONVENTIONAL'])                                           => 'P510',
    (iv_curr_add_mortgage_type in ['GOVERNMENT', 'NON-TRADITIONAL', 'UNKNOWN', 'COMMERCIAL']) => 'P510',
    (rv_a44_curr_add_naprop in [0, 1])                                                        => 'P505',
    (iv_curr_add_mortgage_type in ['NO MORTGAGE'])                                            => 'P513',
                                                                                                 'P510') ) ;

s0_aa_dist_11 := __common__( 0 - s0_v11_w ) ;

s0_v12_w := __common__( map(
    bv_ver_src_derog_ratio = NULL   => 0,
    bv_ver_src_derog_ratio = -1     => 0.339906480022536,
    bv_ver_src_derog_ratio <= -1.5  => 0.114518896797613,
    bv_ver_src_derog_ratio <= 0.25  => 0.0080474708861461,
    bv_ver_src_derog_ratio <= 0.35  => 0.230389926510883,
    bv_ver_src_derog_ratio <= 0.6   => 0.254810200353313,
    bv_ver_src_derog_ratio <= 51    => 0.409765153107066,
    bv_ver_src_derog_ratio <= 102.5 => -0.0338802200351155,
    bv_ver_src_derog_ratio <= 103.5 => -0.148619761974858,
                                       -0.334345448926729) ) ;

s0_aa_code_12 := __common__( map(
    s0_v12_w = -0.334345448926729   => '     ',
    bv_ver_src_derog_ratio = NULL   => 'B031',
    bv_ver_src_derog_ratio = -1     => 'B034',
    bv_ver_src_derog_ratio <= -1.5  => 'B034',
    bv_ver_src_derog_ratio <= 0.25  => 'B063',
    bv_ver_src_derog_ratio <= 0.35  => 'B063',
    bv_ver_src_derog_ratio <= 0.6   => 'B063',
    bv_ver_src_derog_ratio <= 51    => 'B063',
    bv_ver_src_derog_ratio <= 102.5 => 'B034',
    bv_ver_src_derog_ratio <= 103.5 => 'B034',
                                       'B034') ) ;

s0_aa_dist_12 := __common__( 0 - s0_v12_w ) ;

s0_v13_w := __common__( map(
    bv_mth_ver_src_p_ls = NULL => 0,
    bv_mth_ver_src_p_ls = -1   => 0.0184795332753227,
    bv_mth_ver_src_p_ls <= 24  => -0.090092200998207,
                                  -0.0241765048470953) ) ;

s0_aa_code_13 := __common__( map(
    s0_v13_w = -0.090092200998207 => '     ',
    bv_mth_ver_src_p_ls = NULL    => 'B076',
    bv_mth_ver_src_p_ls = -1      => 'B052',
    bv_mth_ver_src_p_ls <= 24     => 'B076',
                                     'B076') ) ;

s0_aa_dist_13 := __common__( 0 - s0_v13_w ) ;

s0_v14_w := __common__( map(
    rv_d34_attr_liens_recency = NULL => 0,
    rv_d34_attr_liens_recency = -1   => 0,
    rv_d34_attr_liens_recency <= 0.5 => -0.0804335280617169,
    rv_d34_attr_liens_recency <= 18  => 0.717337078296652,
    rv_d34_attr_liens_recency <= 48  => 0.498216239874925,
    rv_d34_attr_liens_recency <= 60  => 0.37975021013053,
                                        -0.0804335280617169) ) ;

s0_aa_code_14 := __common__( map(
    s0_v14_w = -0.0804335280617169   => '     ',
    rv_d34_attr_liens_recency = NULL => 'P535',
    rv_d34_attr_liens_recency = -1   => 'P526',
    rv_d34_attr_liens_recency <= 0.5 => 'P526',
    rv_d34_attr_liens_recency <= 18  => 'P526',
    rv_d34_attr_liens_recency <= 48  => 'P526',
    rv_d34_attr_liens_recency <= 60  => 'P526',
                                        'P526') ) ;

s0_aa_dist_14 := __common__( 0 - s0_v14_w ) ;

s0_v15_w := __common__( map(
    bv_lien_avg_amount = NULL           => 0,
    bv_lien_avg_amount = -1             => -0.010561496657869,
    bv_lien_avg_amount <= 5389.57142855 => 0.103659081363966,
                                           0.410984457988868) ) ;

s0_aa_code_15 := __common__( map(
    s0_v15_w = -0.010561496657869       => '     ',
    bv_lien_avg_amount = NULL           => 'B031',
    bv_lien_avg_amount = -1             => 'B079',
    bv_lien_avg_amount <= 5389.57142855 => 'B079',
                                           'B079') ) ;

s0_aa_dist_15 := __common__( 0 - s0_v15_w ) ;

s0_v16_w := __common__( map(
    bv_lien_total_amount = NULL     => 0,
    bv_lien_total_amount = -1       => -0.0174364029895024,
    bv_lien_total_amount <= 1687    => -0.0174364029895024,
    bv_lien_total_amount <= 10980.5 => 0.192906716770004,
                                       0.327682607451732) ) ;

s0_aa_code_16 := __common__( map(
    s0_v16_w = -0.0174364029895024  => '     ',
    bv_lien_total_amount = NULL     => 'B031',
    bv_lien_total_amount = -1       => 'B079',
    bv_lien_total_amount <= 1687    => 'B079',
    bv_lien_total_amount <= 10980.5 => 'B079',
                                       'B079') ) ;

s0_aa_dist_16 := __common__( 0 - s0_v16_w ) ;

s0_v17_w := __common__( map(
    nf_fp_varrisktype = NULL => 0,
    nf_fp_varrisktype = -1   => 0,
    nf_fp_varrisktype <= 1   => -0.0245444219580424,
    nf_fp_varrisktype <= 2.5 => 0.0867362378363326,
    nf_fp_varrisktype <= 3.5 => 0.10803615114697,
    nf_fp_varrisktype <= 4.5 => 0.129005916315595,
    nf_fp_varrisktype <= 5.5 => 0.157837490477875,
                                0.209360695332488) ) ;

s0_aa_code_17 := __common__( map(
    s0_v17_w = -0.0245444219580424 => '     ',
    nf_fp_varrisktype = NULL       => 'P535',
    nf_fp_varrisktype = -1         => 'P535',
    nf_fp_varrisktype <= 1         => 'P566',
    nf_fp_varrisktype <= 2.5       => 'P566',
    nf_fp_varrisktype <= 3.5       => 'P566',
    nf_fp_varrisktype <= 4.5       => 'P566',
    nf_fp_varrisktype <= 5.5       => 'P566',
                                      'P566') ) ;

s0_aa_dist_17 := __common__( 0 - s0_v17_w ) ;

s0_v18_w := __common__( map(
    bv_ver_src_id_mth_since_fs = NULL   => 0,
    bv_ver_src_id_mth_since_fs = -1     => -0.111349656811288,
    bv_ver_src_id_mth_since_fs <= 34.5  => 0.0524268547462212,
    bv_ver_src_id_mth_since_fs <= 113.5 => 0.0115589205175429,
    bv_ver_src_id_mth_since_fs <= 146.5 => -0.0367835582317426,
    bv_ver_src_id_mth_since_fs <= 156.5 => -0.0578731663968318,
    bv_ver_src_id_mth_since_fs <= 202.5 => -0.0720855691030857,
                                           -0.111349656811288) ) ;

s0_aa_code_18 := __common__( map(
    s0_v18_w = -0.111349656811288       => '     ',
    bv_ver_src_id_mth_since_fs = NULL   => 'B031',
    bv_ver_src_id_mth_since_fs = -1     => 'B036',
    bv_ver_src_id_mth_since_fs <= 34.5  => 'B036',
    bv_ver_src_id_mth_since_fs <= 113.5 => 'B036',
    bv_ver_src_id_mth_since_fs <= 146.5 => 'B036',
    bv_ver_src_id_mth_since_fs <= 156.5 => 'B036',
    bv_ver_src_id_mth_since_fs <= 202.5 => 'B036',
                                           'B036') ) ;

s0_aa_dist_18 := __common__( 0 - s0_v18_w ) ;

s0_v19_w := __common__( map(
    nf_fp_srchunvrfdssncount = NULL => 0,
    nf_fp_srchunvrfdssncount = -1   => 0,
    nf_fp_srchunvrfdssncount <= 0.5 => -0.0103068553556184,
                                       0.245143824744679) ) ;

s0_aa_code_19 := __common__( map(
    s0_v19_w = -0.0103068553556184  => '     ',
    nf_fp_srchunvrfdssncount = NULL => 'P535',
    nf_fp_srchunvrfdssncount = -1   => 'P539',
    nf_fp_srchunvrfdssncount <= 0.5 => 'P539',
                                       'P539') ) ;

s0_aa_dist_19 := __common__( 0 - s0_v19_w ) ;

s0_v20_w := __common__( map(
    bv_judg_filed_mth_fs = NULL  => 0,
    bv_judg_filed_mth_fs = -1    => -0.00615943462019671,
    bv_judg_filed_mth_fs <= 44.5 => 0.401681015251044,
                                    0.0890731050458654) ) ;

s0_aa_code_20 := __common__( map(
    s0_v20_w = -0.00615943462019671 => '     ',
    bv_judg_filed_mth_fs = NULL     => 'B031',
    bv_judg_filed_mth_fs = -1       => 'B063',
    bv_judg_filed_mth_fs <= 44.5    => 'B063',
                                       'B063') ) ;

s0_aa_dist_20 := __common__( 0 - s0_v20_w ) ;

s0_v21_w := __common__( map(
    rv_a41_prop_owner = NULL => 0,
    rv_a41_prop_owner = -1   => 0,
    rv_a41_prop_owner <= 0.5 => 0.138398913261513,
                                -0.0118702794578432) ) ;

s0_aa_code_21 := __common__( map(
    s0_v21_w = -0.0118702794578432 => '     ',
    rv_a41_prop_owner = NULL       => 'P535',
    rv_a41_prop_owner = -1         => 'P502',
    rv_a41_prop_owner <= 0.5       => 'P502',
                                      'P502') ) ;

s0_aa_dist_21 := __common__( 0 - s0_v21_w ) ;

s0_v22_w := __common__( map(
    bv_assoc_lien_tot = NULL => 0,
    bv_assoc_lien_tot = -1   => 0.00941509845328186,
    bv_assoc_lien_tot <= 0.5 => -0.0198302250581444,
    bv_assoc_lien_tot <= 1.5 => 0.106712263506093,
    bv_assoc_lien_tot <= 2.5 => 0.119155293894942,
                                0.220243070070351) ) ;

s0_aa_code_22 := __common__( map(
    s0_v22_w = -0.0198302250581444 => '     ',
    bv_assoc_lien_tot = NULL       => 'B031',
    bv_assoc_lien_tot = -1         => 'B017',
    bv_assoc_lien_tot <= 0.5       => 'B026',
    bv_assoc_lien_tot <= 1.5       => 'B026',
    bv_assoc_lien_tot <= 2.5       => 'B026',
                                      'B026') ) ;

s0_aa_dist_22 := __common__( 0 - s0_v22_w ) ;

s0_v23_w := __common__( map(
    bx_addr_lres = NULL   => 0,
    bx_addr_lres = -1     => -0.00571039201494675,
    bx_addr_lres <= 11.5  => 0.0567868589732502,
    bx_addr_lres <= 37.5  => 0.0409271324964797,
    bx_addr_lres <= 91.5  => 0.00128520525171766,
    bx_addr_lres <= 109.5 => -0.0344679251706513,
    bx_addr_lres <= 151.5 => -0.0500734616999242,
    bx_addr_lres <= 222.5 => -0.0502267987788971,
    bx_addr_lres <= 275.5 => -0.0888200195638869,
                             -0.117200408130116) ) ;

s0_aa_code_23 := __common__( map(
    s0_v23_w = -0.117200408130116 => '     ',
    bx_addr_lres = NULL           => 'B031',
    bx_addr_lres = -1             => 'B031',
    bx_addr_lres <= 11.5          => 'B070',
    bx_addr_lres <= 37.5          => 'B070',
    bx_addr_lres <= 91.5          => 'B070',
    bx_addr_lres <= 109.5         => 'B070',
    bx_addr_lres <= 151.5         => 'B070',
    bx_addr_lres <= 222.5         => 'B070',
    bx_addr_lres <= 275.5         => 'B070',
                                     'B070') ) ;

s0_aa_dist_23 := __common__( 0 - s0_v23_w ) ;

s0_v24_w := __common__( map(
    rv_d32_attr_felonies_recency = NULL => 0,
    rv_d32_attr_felonies_recency = -1   => 0,
    rv_d32_attr_felonies_recency <= 0   => -0.00259610393939799,
                                           0.178281098267757) ) ;

s0_aa_code_24 := __common__( map(
    s0_v24_w = -0.00259610393939799     => '     ',
    rv_d32_attr_felonies_recency = NULL => 'P535',
    rv_d32_attr_felonies_recency = -1   => 'P526',
    rv_d32_attr_felonies_recency <= 0   => 'P526',
                                           'P526') ) ;

s0_aa_dist_24 := __common__( 0 - s0_v24_w ) ;

s0_v25_w := __common__( map(
    rv_ever_asset_owner = NULL => 0,
    rv_ever_asset_owner = -1   => 0,
    rv_ever_asset_owner <= 0.5 => 0.1055223957361,
                                  -0.006324421228605) ) ;

s0_aa_code_25 := __common__( map(
    s0_v25_w = -0.006324421228605 => '     ',
    rv_ever_asset_owner = NULL    => 'P535',
    rv_ever_asset_owner = -1      => 'P501',
    rv_ever_asset_owner <= 0.5    => 'P501',
                                     'P501') ) ;

s0_aa_dist_25 := __common__( 0 - s0_v25_w ) ;

s0_v26_w := __common__( map(
    rv_d34_attr_unrel_liens_recency = NULL => 0,
    rv_d34_attr_unrel_liens_recency = -1   => 0,
    rv_d34_attr_unrel_liens_recency <= 0.5 => -0.0424733084498656,
    rv_d34_attr_unrel_liens_recency <= 18  => 0.441964246178922,
    rv_d34_attr_unrel_liens_recency <= 48  => 0.300228122588715,
    rv_d34_attr_unrel_liens_recency <= 60  => 0.225251303786368,
                                              -0.0424733084498656) ) ;

s0_aa_code_26 := __common__( map(
    s0_v26_w = -0.0424733084498656         => '     ',
    rv_d34_attr_unrel_liens_recency = NULL => 'P535',
    rv_d34_attr_unrel_liens_recency = -1   => 'P526',
    rv_d34_attr_unrel_liens_recency <= 0.5 => 'P526',
    rv_d34_attr_unrel_liens_recency <= 18  => 'P526',
    rv_d34_attr_unrel_liens_recency <= 48  => 'P526',
    rv_d34_attr_unrel_liens_recency <= 60  => 'P526',
                                              'P526') ) ;

s0_aa_dist_26 := __common__( 0 - s0_v26_w ) ;

s0_v27_w := __common__( map(
    bv_mth_bureau_fs = NULL   => 0,
    bv_mth_bureau_fs = -1     => 0.00521441288617275,
    bv_mth_bureau_fs <= 70.5  => 0.0120762658712951,
    bv_mth_bureau_fs <= 124.5 => -0.0765046550085903,
                                 -0.127560665099968) ) ;

// s0_aa_code_27 := __common__( map(
    // s0_v27_w = -0.127560665099968 => '     ',
    // bv_mth_bureau_fs = NULL       => 'P535',
    // bv_mth_bureau_fs = -1         => 'P523',
    // bv_mth_bureau_fs <= 70.5      => 'P523',
    // bv_mth_bureau_fs <= 124.5     => 'P523',
                                     // 'P523') ) ;
                                     
 s0_aa_code_27 := __common__( map(
    s0_v27_w = -0.127560665099968 => '     ',
    bv_mth_bureau_fs = NULL       => 'P535',
    bv_mth_bureau_fs = -1         => 'B034',
    bv_mth_bureau_fs <= 70.5      => 'B034',
    bv_mth_bureau_fs <= 124.5     => 'B034',
                                     'B034') ) ;                                    
                                     

s0_aa_dist_27 := __common__( 0 - s0_v27_w ) ;

s0_v28_w := __common__( map(
    rv_i60_inq_auto_count12 = NULL => 0,
    rv_i60_inq_auto_count12 = -1   => 0,
    rv_i60_inq_auto_count12 <= 0.5 => -0.00905701902288646,
    rv_i60_inq_auto_count12 <= 2.5 => 0.078265313767785,
                                      0.202657492999427) ) ;

s0_aa_code_28 := __common__( map(
    s0_v28_w = -0.00905701902288646 => '     ',
    rv_i60_inq_auto_count12 = NULL  => 'P535',
    rv_i60_inq_auto_count12 = -1    => 'P539',
    rv_i60_inq_auto_count12 <= 0.5  => 'P539',
    rv_i60_inq_auto_count12 <= 2.5  => 'P539',
                                       'P539') ) ;

s0_aa_dist_28 := __common__( 0 - s0_v28_w ) ;

s0_v29_w := __common__( map(
    rv_mos_since_br_first_seen = NULL   => 0,
    rv_mos_since_br_first_seen = -1     => 0.045176570117496,
    rv_mos_since_br_first_seen <= 49.5  => 0.0288889354526648,
    rv_mos_since_br_first_seen <= 220.5 => -0.0392071764970965,
    rv_mos_since_br_first_seen <= 290.5 => -0.0545689875228921,
                                           -0.122721893792547) ) ;

s0_aa_code_29 := __common__( map(
    s0_v29_w = -0.122721893792547       => '     ',
    rv_mos_since_br_first_seen = NULL   => 'P535',
    rv_mos_since_br_first_seen = -1     => 'P565',
    rv_mos_since_br_first_seen <= 49.5  => 'P565',
    rv_mos_since_br_first_seen <= 220.5 => 'P565',
    rv_mos_since_br_first_seen <= 290.5 => 'P565',
                                           'P565') ) ;

s0_aa_dist_29 := __common__( 0 - s0_v29_w ) ;

s0_v30_w := __common__( map(
    nf_fp_srchvelocityrisktype = NULL => 0,
    nf_fp_srchvelocityrisktype = -1   => 0,
    nf_fp_srchvelocityrisktype <= 3   => -0.00455206860793901,
    nf_fp_srchvelocityrisktype <= 5   => 0.0181118390893505,
                                         0.0646321479958328) ) ;

s0_aa_code_30 := __common__( map(
    s0_v30_w = -0.00455206860793901   => '     ',
    nf_fp_srchvelocityrisktype = NULL => 'P535',
    nf_fp_srchvelocityrisktype = -1   => 'P539',
    nf_fp_srchvelocityrisktype <= 3   => 'P539',
    nf_fp_srchvelocityrisktype <= 5   => 'P539',
                                         'P539') ) ;

s0_aa_dist_30 := __common__( 0 - s0_v30_w ) ;

s0_v31_w := __common__( map(
    rv_d33_eviction_count = NULL => 0,
    rv_d33_eviction_count = -1   => 0,
    rv_d33_eviction_count <= 0.5 => -0.00508112630079548,
    rv_d33_eviction_count <= 1.5 => 0.173209495025751,
                                    0.342544888958172) ) ;

s0_aa_code_31 := __common__( map(
    s0_v31_w = -0.00508112630079548 => '     ',
    rv_d33_eviction_count = NULL    => 'P535',
    rv_d33_eviction_count = -1      => 'P526',
    rv_d33_eviction_count <= 0.5    => 'P526',
    rv_d33_eviction_count <= 1.5    => 'P526',
                                       'P526') ) ;

s0_aa_dist_31 := __common__( 0 - s0_v31_w ) ;

s0_v32_w := __common__( map(
    bv_lien_ft_count = NULL => 0,
    bv_lien_ft_count = -1   => 0,
    bv_lien_ft_count <= 0.5 => -0.00284521739366358,
                               0.205043350550051) ) ;

s0_aa_code_32 := __common__( map(
    s0_v32_w = -0.00284521739366358 => '     ',
    bv_lien_ft_count = NULL         => 'B031',
    bv_lien_ft_count = -1           => 'B063',
    bv_lien_ft_count <= 0.5         => 'B063',
                                       'B063') ) ;

s0_aa_dist_32 := __common__( 0 - s0_v32_w ) ;

s0_v33_w := __common__( map(
    rv_d34_unrel_liens_ct = NULL => 0,
    rv_d34_unrel_liens_ct = -1   => 0,
    rv_d34_unrel_liens_ct <= 0.5 => -0.00405904559458691,
                                    0.15237953221647) ) ;

s0_aa_code_33 := __common__( map(
    s0_v33_w = -0.00405904559458691 => '     ',
    rv_d34_unrel_liens_ct = NULL    => 'P535',
    rv_d34_unrel_liens_ct = -1      => 'P526',
    rv_d34_unrel_liens_ct <= 0.5    => 'P526',
                                       'P526') ) ;

s0_aa_dist_33 := __common__( 0 - s0_v33_w ) ;

s0_v34_w := __common__( map(
    bv_assoc_derog_pct = NULL           => 0,
    bv_assoc_derog_pct = -1             => 0.00815523205088307,
    bv_assoc_derog_pct <= 0             => -0.0305018386597529,
    bv_assoc_derog_pct <= 0.3875        => 0.0463864446016512,
    bv_assoc_derog_pct <= 0.63333333335 => 0.122902562915995,
                                           0.160435669649836) ) ;

s0_aa_code_34 := __common__( map(
    s0_v34_w = -0.0305018386597529      => '     ',
    bv_assoc_derog_pct = NULL           => 'B031',
    bv_assoc_derog_pct = -1             => 'B017',
    bv_assoc_derog_pct <= 0             => 'B026',
    bv_assoc_derog_pct <= 0.3875        => 'B026',
    bv_assoc_derog_pct <= 0.63333333335 => 'B026',
                                           'B026') ) ;

s0_aa_dist_34 := __common__( 0 - s0_v34_w ) ;

s0_v35_w := __common__( map(
    nf_fp_srchunvrfdphonecount = NULL => 0,
    nf_fp_srchunvrfdphonecount = -1   => 0,
    nf_fp_srchunvrfdphonecount <= 0.5 => -0.0117612059881204,
    nf_fp_srchunvrfdphonecount <= 1.5 => 0.0462928784227782,
                                         0.0763295551592002) ) ;

s0_aa_code_35 := __common__( map(
    s0_v35_w = -0.0117612059881204    => '     ',
    nf_fp_srchunvrfdphonecount = NULL => 'P535',
    nf_fp_srchunvrfdphonecount = -1   => 'P539',
    nf_fp_srchunvrfdphonecount <= 0.5 => 'P539',
    nf_fp_srchunvrfdphonecount <= 1.5 => 'P539',
                                         'P539') ) ;

s0_aa_dist_35 := __common__( 0 - s0_v35_w ) ;

s0_v36_w := __common__( map(
    rv_i60_inq_comm_recency = NULL => 0,
    rv_i60_inq_comm_recency = -1   => 0,
    rv_i60_inq_comm_recency <= 0.5 => -0.00432860120266802,
    rv_i60_inq_comm_recency <= 12  => 0.0899804741270784,
                                      -0.00432860120266802) ) ;

s0_aa_code_36 := __common__( map(
    s0_v36_w = -0.00432860120266802 => '     ',
    rv_i60_inq_comm_recency = NULL  => 'P535',
    rv_i60_inq_comm_recency = -1    => 'P539',
    rv_i60_inq_comm_recency <= 0.5  => 'P539',
    rv_i60_inq_comm_recency <= 12   => 'P539',
                                       'P539') ) ;

s0_aa_dist_36 := __common__( 0 - s0_v36_w ) ;

s0_v37_w := __common__( map(
    nf_fp_srchfraudsrchcountyr = NULL => 0,
    nf_fp_srchfraudsrchcountyr = -1   => 0,
    nf_fp_srchfraudsrchcountyr <= 0.5 => -0.0120833658301427,
    nf_fp_srchfraudsrchcountyr <= 1.5 => 0.0345670512861276,
                                         0.0627512162158203) ) ;

s0_aa_code_37 := __common__( map(
    s0_v37_w = -0.0120833658301427    => '     ',
    nf_fp_srchfraudsrchcountyr = NULL => 'P535',
    nf_fp_srchfraudsrchcountyr = -1   => 'P539',
    nf_fp_srchfraudsrchcountyr <= 0.5 => 'P539',
    nf_fp_srchfraudsrchcountyr <= 1.5 => 'P539',
                                         'P539') ) ;

s0_aa_dist_37 := __common__( 0 - s0_v37_w ) ;

s0_v38_w := __common__( map(
    bv_ver_src_id_activity12 = NULL => 0,
    bv_ver_src_id_activity12 = -1   => 0,
    bv_ver_src_id_activity12 <= 0.5 => 0.25430332671837,
    bv_ver_src_id_activity12 <= 1   => 0.00509879592863039,
    bv_ver_src_id_activity12 <= 3   => -0.00530374882607918,
                                       -0.0341400955594518) ) ;

s0_aa_code_38 := __common__( map(
    s0_v38_w = -0.0341400955594518                                 => '     ',
    bv_ver_src_id_activity12 = NULL                                => 'B031',
    bv_ver_src_id_activity12 = -1                                  => 'B034',
    bv_ver_src_id_activity12 <= 0.5                                => 'B063',
    0 <= bv_sos_mth_agent_change AND bv_sos_mth_agent_change <= 12 => 'B056',
    bv_ver_src_id_activity12 <= 1                                  => 'B034',
    bv_ver_src_id_activity12 <= 3                                  => 'B034',
                                                                      'B034') ) ;

s0_aa_dist_38 := __common__( 0 - s0_v38_w ) ;

s0_v39_w := __common__( map(
    bv_lien_ot_count = NULL => 0,
    bv_lien_ot_count = -1   => 0,
    bv_lien_ot_count <= 0   => -0.00427316842003629,
    bv_lien_ot_count <= 1   => 0.0438534932508342,
                               0.161209832767035) ) ;

s0_aa_code_39 := __common__( map(
    s0_v39_w = -0.00427316842003629 => '     ',
    bv_lien_ot_count = NULL         => 'B031',
    bv_lien_ot_count = -1           => 'B063',
    bv_lien_ot_count <= 0           => 'B063',
    bv_lien_ot_count <= 1           => 'B063',
                                       'B063') ) ;

s0_aa_dist_39 := __common__( 0 - s0_v39_w ) ;

s0_v40_w := __common__( map(
    bv_judg_avg_amount = NULL     => 0,
    bv_judg_avg_amount = -1       => -0.00194968863408312,
    bv_judg_avg_amount <= 4159.75 => 0.0416545312655188,
                                     0.131657141296978) ) ;

s0_aa_code_40 := __common__( map(
    s0_v40_w = -0.00194968863408312 => '     ',
    bv_judg_avg_amount = NULL       => 'B031',
    bv_judg_avg_amount = -1         => 'B079',
    bv_judg_avg_amount <= 4159.75   => 'B079',
                                       'B079') ) ;

s0_aa_dist_40 := __common__( 0 - s0_v40_w ) ;

s0_v41_w := __common__( map(
    nf_fp_srchunvrfdaddrcount = NULL => 0,
    nf_fp_srchunvrfdaddrcount = -1   => 0,
    nf_fp_srchunvrfdaddrcount <= 0.5 => -0.00246660169417597,
                                        0.0840434348931558) ) ;

s0_aa_code_41 := __common__( map(
    s0_v41_w = -0.00246660169417597  => '     ',
    nf_fp_srchunvrfdaddrcount = NULL => 'P535',
    nf_fp_srchunvrfdaddrcount = -1   => 'P539',
    nf_fp_srchunvrfdaddrcount <= 0.5 => 'P539',
                                        'P539') ) ;

s0_aa_dist_41 := __common__( 0 - s0_v41_w ) ;

s0_v42_w := __common__( map(
    nf_fp_sourcerisktype = NULL => 0,
    nf_fp_sourcerisktype = -1   => 0,
    nf_fp_sourcerisktype <= 4   => -0.00399945113620758,
    nf_fp_sourcerisktype <= 5   => -0.00215357452658665,
    nf_fp_sourcerisktype <= 6.5 => 0.038745521928441,
                                   0.0669845948828356) ) ;

s0_aa_code_42 := __common__( map(
    s0_v42_w = -0.00399945113620758 => '     ',
    nf_fp_sourcerisktype = NULL     => 'P535',
    nf_fp_sourcerisktype = -1       => 'P515',
    nf_fp_sourcerisktype <= 4       => 'P515',
    nf_fp_sourcerisktype <= 5       => 'P515',
    nf_fp_sourcerisktype <= 6.5     => 'P515',
                                       'P515') ) ;

s0_aa_dist_42 := __common__( 0 - s0_v42_w ) ;

s0_v43_w := __common__( map(
    nf_fp_prevaddrageoldest = NULL   => 0,
    nf_fp_prevaddrageoldest = -1     => 0.00412733255820826,
    nf_fp_prevaddrageoldest <= 16.5  => 0.0248076172010063,
    nf_fp_prevaddrageoldest <= 21.5  => 0.0196840002382658,
    nf_fp_prevaddrageoldest <= 45.5  => 0.0120843953312668,
    nf_fp_prevaddrageoldest <= 99.5  => 0.00763478319687844,
    nf_fp_prevaddrageoldest <= 232.5 => -0.00756138112930466,
                                        -0.0181731976794484) ) ;

s0_aa_code_43 := __common__( map(
    s0_v43_w = -0.0181731976794484   => '     ',
    nf_fp_prevaddrageoldest = NULL   => 'P535',
    nf_fp_prevaddrageoldest = -1     => 'P567',
    nf_fp_prevaddrageoldest <= 16.5  => 'P567',
    nf_fp_prevaddrageoldest <= 21.5  => 'P567',
    nf_fp_prevaddrageoldest <= 45.5  => 'P567',
    nf_fp_prevaddrageoldest <= 99.5  => 'P567',
    nf_fp_prevaddrageoldest <= 232.5 => 'P567',
                                        'P567') ) ;

s0_aa_dist_43 := __common__( 0 - s0_v43_w ) ;

s0_rcvalueb036 := __common__( (integer)(s0_aa_code_01 = 'B036') * s0_aa_dist_01 +
    (integer)(s0_aa_code_02 = 'B036') * s0_aa_dist_02 +
    (integer)(s0_aa_code_03 = 'B036') * s0_aa_dist_03 +
    (integer)(s0_aa_code_04 = 'B036') * s0_aa_dist_04 +
    (integer)(s0_aa_code_05 = 'B036') * s0_aa_dist_05 +
    (integer)(s0_aa_code_06 = 'B036') * s0_aa_dist_06 +
    (integer)(s0_aa_code_07 = 'B036') * s0_aa_dist_07 +
    (integer)(s0_aa_code_08 = 'B036') * s0_aa_dist_08 +
    (integer)(s0_aa_code_09 = 'B036') * s0_aa_dist_09 +
    (integer)(s0_aa_code_10 = 'B036') * s0_aa_dist_10 +
    (integer)(s0_aa_code_11 = 'B036') * s0_aa_dist_11 +
    (integer)(s0_aa_code_12 = 'B036') * s0_aa_dist_12 +
    (integer)(s0_aa_code_13 = 'B036') * s0_aa_dist_13 +
    (integer)(s0_aa_code_14 = 'B036') * s0_aa_dist_14 +
    (integer)(s0_aa_code_15 = 'B036') * s0_aa_dist_15 +
    (integer)(s0_aa_code_16 = 'B036') * s0_aa_dist_16 +
    (integer)(s0_aa_code_17 = 'B036') * s0_aa_dist_17 +
    (integer)(s0_aa_code_18 = 'B036') * s0_aa_dist_18 +
    (integer)(s0_aa_code_19 = 'B036') * s0_aa_dist_19 +
    (integer)(s0_aa_code_20 = 'B036') * s0_aa_dist_20 +
    (integer)(s0_aa_code_21 = 'B036') * s0_aa_dist_21 +
    (integer)(s0_aa_code_22 = 'B036') * s0_aa_dist_22 +
    (integer)(s0_aa_code_23 = 'B036') * s0_aa_dist_23 +
    (integer)(s0_aa_code_24 = 'B036') * s0_aa_dist_24 +
    (integer)(s0_aa_code_25 = 'B036') * s0_aa_dist_25 +
    (integer)(s0_aa_code_26 = 'B036') * s0_aa_dist_26 +
    (integer)(s0_aa_code_27 = 'B036') * s0_aa_dist_27 +
    (integer)(s0_aa_code_28 = 'B036') * s0_aa_dist_28 +
    (integer)(s0_aa_code_29 = 'B036') * s0_aa_dist_29 +
    (integer)(s0_aa_code_30 = 'B036') * s0_aa_dist_30 +
    (integer)(s0_aa_code_31 = 'B036') * s0_aa_dist_31 +
    (integer)(s0_aa_code_32 = 'B036') * s0_aa_dist_32 +
    (integer)(s0_aa_code_33 = 'B036') * s0_aa_dist_33 +
    (integer)(s0_aa_code_34 = 'B036') * s0_aa_dist_34 +
    (integer)(s0_aa_code_35 = 'B036') * s0_aa_dist_35 +
    (integer)(s0_aa_code_36 = 'B036') * s0_aa_dist_36 +
    (integer)(s0_aa_code_37 = 'B036') * s0_aa_dist_37 +
    (integer)(s0_aa_code_38 = 'B036') * s0_aa_dist_38 +
    (integer)(s0_aa_code_39 = 'B036') * s0_aa_dist_39 +
    (integer)(s0_aa_code_40 = 'B036') * s0_aa_dist_40 +
    (integer)(s0_aa_code_41 = 'B036') * s0_aa_dist_41 +
    (integer)(s0_aa_code_42 = 'B036') * s0_aa_dist_42 +
    (integer)(s0_aa_code_43 = 'B036') * s0_aa_dist_43 ) ;

s0_rcvalueb035 := __common__( (integer)(s0_aa_code_01 = 'B035') * s0_aa_dist_01 +
    (integer)(s0_aa_code_02 = 'B035') * s0_aa_dist_02 +
    (integer)(s0_aa_code_03 = 'B035') * s0_aa_dist_03 +
    (integer)(s0_aa_code_04 = 'B035') * s0_aa_dist_04 +
    (integer)(s0_aa_code_05 = 'B035') * s0_aa_dist_05 +
    (integer)(s0_aa_code_06 = 'B035') * s0_aa_dist_06 +
    (integer)(s0_aa_code_07 = 'B035') * s0_aa_dist_07 +
    (integer)(s0_aa_code_08 = 'B035') * s0_aa_dist_08 +
    (integer)(s0_aa_code_09 = 'B035') * s0_aa_dist_09 +
    (integer)(s0_aa_code_10 = 'B035') * s0_aa_dist_10 +
    (integer)(s0_aa_code_11 = 'B035') * s0_aa_dist_11 +
    (integer)(s0_aa_code_12 = 'B035') * s0_aa_dist_12 +
    (integer)(s0_aa_code_13 = 'B035') * s0_aa_dist_13 +
    (integer)(s0_aa_code_14 = 'B035') * s0_aa_dist_14 +
    (integer)(s0_aa_code_15 = 'B035') * s0_aa_dist_15 +
    (integer)(s0_aa_code_16 = 'B035') * s0_aa_dist_16 +
    (integer)(s0_aa_code_17 = 'B035') * s0_aa_dist_17 +
    (integer)(s0_aa_code_18 = 'B035') * s0_aa_dist_18 +
    (integer)(s0_aa_code_19 = 'B035') * s0_aa_dist_19 +
    (integer)(s0_aa_code_20 = 'B035') * s0_aa_dist_20 +
    (integer)(s0_aa_code_21 = 'B035') * s0_aa_dist_21 +
    (integer)(s0_aa_code_22 = 'B035') * s0_aa_dist_22 +
    (integer)(s0_aa_code_23 = 'B035') * s0_aa_dist_23 +
    (integer)(s0_aa_code_24 = 'B035') * s0_aa_dist_24 +
    (integer)(s0_aa_code_25 = 'B035') * s0_aa_dist_25 +
    (integer)(s0_aa_code_26 = 'B035') * s0_aa_dist_26 +
    (integer)(s0_aa_code_27 = 'B035') * s0_aa_dist_27 +
    (integer)(s0_aa_code_28 = 'B035') * s0_aa_dist_28 +
    (integer)(s0_aa_code_29 = 'B035') * s0_aa_dist_29 +
    (integer)(s0_aa_code_30 = 'B035') * s0_aa_dist_30 +
    (integer)(s0_aa_code_31 = 'B035') * s0_aa_dist_31 +
    (integer)(s0_aa_code_32 = 'B035') * s0_aa_dist_32 +
    (integer)(s0_aa_code_33 = 'B035') * s0_aa_dist_33 +
    (integer)(s0_aa_code_34 = 'B035') * s0_aa_dist_34 +
    (integer)(s0_aa_code_35 = 'B035') * s0_aa_dist_35 +
    (integer)(s0_aa_code_36 = 'B035') * s0_aa_dist_36 +
    (integer)(s0_aa_code_37 = 'B035') * s0_aa_dist_37 +
    (integer)(s0_aa_code_38 = 'B035') * s0_aa_dist_38 +
    (integer)(s0_aa_code_39 = 'B035') * s0_aa_dist_39 +
    (integer)(s0_aa_code_40 = 'B035') * s0_aa_dist_40 +
    (integer)(s0_aa_code_41 = 'B035') * s0_aa_dist_41 +
    (integer)(s0_aa_code_42 = 'B035') * s0_aa_dist_42 +
    (integer)(s0_aa_code_43 = 'B035') * s0_aa_dist_43 ) ;

s0_rcvalueb034 := __common__( (integer)(s0_aa_code_01 = 'B034') * s0_aa_dist_01 +
    (integer)(s0_aa_code_02 = 'B034') * s0_aa_dist_02 +
    (integer)(s0_aa_code_03 = 'B034') * s0_aa_dist_03 +
    (integer)(s0_aa_code_04 = 'B034') * s0_aa_dist_04 +
    (integer)(s0_aa_code_05 = 'B034') * s0_aa_dist_05 +
    (integer)(s0_aa_code_06 = 'B034') * s0_aa_dist_06 +
    (integer)(s0_aa_code_07 = 'B034') * s0_aa_dist_07 +
    (integer)(s0_aa_code_08 = 'B034') * s0_aa_dist_08 +
    (integer)(s0_aa_code_09 = 'B034') * s0_aa_dist_09 +
    (integer)(s0_aa_code_10 = 'B034') * s0_aa_dist_10 +
    (integer)(s0_aa_code_11 = 'B034') * s0_aa_dist_11 +
    (integer)(s0_aa_code_12 = 'B034') * s0_aa_dist_12 +
    (integer)(s0_aa_code_13 = 'B034') * s0_aa_dist_13 +
    (integer)(s0_aa_code_14 = 'B034') * s0_aa_dist_14 +
    (integer)(s0_aa_code_15 = 'B034') * s0_aa_dist_15 +
    (integer)(s0_aa_code_16 = 'B034') * s0_aa_dist_16 +
    (integer)(s0_aa_code_17 = 'B034') * s0_aa_dist_17 +
    (integer)(s0_aa_code_18 = 'B034') * s0_aa_dist_18 +
    (integer)(s0_aa_code_19 = 'B034') * s0_aa_dist_19 +
    (integer)(s0_aa_code_20 = 'B034') * s0_aa_dist_20 +
    (integer)(s0_aa_code_21 = 'B034') * s0_aa_dist_21 +
    (integer)(s0_aa_code_22 = 'B034') * s0_aa_dist_22 +
    (integer)(s0_aa_code_23 = 'B034') * s0_aa_dist_23 +
    (integer)(s0_aa_code_24 = 'B034') * s0_aa_dist_24 +
    (integer)(s0_aa_code_25 = 'B034') * s0_aa_dist_25 +
    (integer)(s0_aa_code_26 = 'B034') * s0_aa_dist_26 +
    (integer)(s0_aa_code_27 = 'B034') * s0_aa_dist_27 +
    (integer)(s0_aa_code_28 = 'B034') * s0_aa_dist_28 +
    (integer)(s0_aa_code_29 = 'B034') * s0_aa_dist_29 +
    (integer)(s0_aa_code_30 = 'B034') * s0_aa_dist_30 +
    (integer)(s0_aa_code_31 = 'B034') * s0_aa_dist_31 +
    (integer)(s0_aa_code_32 = 'B034') * s0_aa_dist_32 +
    (integer)(s0_aa_code_33 = 'B034') * s0_aa_dist_33 +
    (integer)(s0_aa_code_34 = 'B034') * s0_aa_dist_34 +
    (integer)(s0_aa_code_35 = 'B034') * s0_aa_dist_35 +
    (integer)(s0_aa_code_36 = 'B034') * s0_aa_dist_36 +
    (integer)(s0_aa_code_37 = 'B034') * s0_aa_dist_37 +
    (integer)(s0_aa_code_38 = 'B034') * s0_aa_dist_38 +
    (integer)(s0_aa_code_39 = 'B034') * s0_aa_dist_39 +
    (integer)(s0_aa_code_40 = 'B034') * s0_aa_dist_40 +
    (integer)(s0_aa_code_41 = 'B034') * s0_aa_dist_41 +
    (integer)(s0_aa_code_42 = 'B034') * s0_aa_dist_42 +
    (integer)(s0_aa_code_43 = 'B034') * s0_aa_dist_43 ) ;

s0_rcvaluep535 := __common__( (integer)(s0_aa_code_01 = 'P535') * s0_aa_dist_01 +
    (integer)(s0_aa_code_02 = 'P535') * s0_aa_dist_02 +
    (integer)(s0_aa_code_03 = 'P535') * s0_aa_dist_03 +
    (integer)(s0_aa_code_04 = 'P535') * s0_aa_dist_04 +
    (integer)(s0_aa_code_05 = 'P535') * s0_aa_dist_05 +
    (integer)(s0_aa_code_06 = 'P535') * s0_aa_dist_06 +
    (integer)(s0_aa_code_07 = 'P535') * s0_aa_dist_07 +
    (integer)(s0_aa_code_08 = 'P535') * s0_aa_dist_08 +
    (integer)(s0_aa_code_09 = 'P535') * s0_aa_dist_09 +
    (integer)(s0_aa_code_10 = 'P535') * s0_aa_dist_10 +
    (integer)(s0_aa_code_11 = 'P535') * s0_aa_dist_11 +
    (integer)(s0_aa_code_12 = 'P535') * s0_aa_dist_12 +
    (integer)(s0_aa_code_13 = 'P535') * s0_aa_dist_13 +
    (integer)(s0_aa_code_14 = 'P535') * s0_aa_dist_14 +
    (integer)(s0_aa_code_15 = 'P535') * s0_aa_dist_15 +
    (integer)(s0_aa_code_16 = 'P535') * s0_aa_dist_16 +
    (integer)(s0_aa_code_17 = 'P535') * s0_aa_dist_17 +
    (integer)(s0_aa_code_18 = 'P535') * s0_aa_dist_18 +
    (integer)(s0_aa_code_19 = 'P535') * s0_aa_dist_19 +
    (integer)(s0_aa_code_20 = 'P535') * s0_aa_dist_20 +
    (integer)(s0_aa_code_21 = 'P535') * s0_aa_dist_21 +
    (integer)(s0_aa_code_22 = 'P535') * s0_aa_dist_22 +
    (integer)(s0_aa_code_23 = 'P535') * s0_aa_dist_23 +
    (integer)(s0_aa_code_24 = 'P535') * s0_aa_dist_24 +
    (integer)(s0_aa_code_25 = 'P535') * s0_aa_dist_25 +
    (integer)(s0_aa_code_26 = 'P535') * s0_aa_dist_26 +
    (integer)(s0_aa_code_27 = 'P535') * s0_aa_dist_27 +
    (integer)(s0_aa_code_28 = 'P535') * s0_aa_dist_28 +
    (integer)(s0_aa_code_29 = 'P535') * s0_aa_dist_29 +
    (integer)(s0_aa_code_30 = 'P535') * s0_aa_dist_30 +
    (integer)(s0_aa_code_31 = 'P535') * s0_aa_dist_31 +
    (integer)(s0_aa_code_32 = 'P535') * s0_aa_dist_32 +
    (integer)(s0_aa_code_33 = 'P535') * s0_aa_dist_33 +
    (integer)(s0_aa_code_34 = 'P535') * s0_aa_dist_34 +
    (integer)(s0_aa_code_35 = 'P535') * s0_aa_dist_35 +
    (integer)(s0_aa_code_36 = 'P535') * s0_aa_dist_36 +
    (integer)(s0_aa_code_37 = 'P535') * s0_aa_dist_37 +
    (integer)(s0_aa_code_38 = 'P535') * s0_aa_dist_38 +
    (integer)(s0_aa_code_39 = 'P535') * s0_aa_dist_39 +
    (integer)(s0_aa_code_40 = 'P535') * s0_aa_dist_40 +
    (integer)(s0_aa_code_41 = 'P535') * s0_aa_dist_41 +
    (integer)(s0_aa_code_42 = 'P535') * s0_aa_dist_42 +
    (integer)(s0_aa_code_43 = 'P535') * s0_aa_dist_43 ) ;

s0_rcvalueb031 := __common__( (integer)(s0_aa_code_01 = 'B031') * s0_aa_dist_01 +
    (integer)(s0_aa_code_02 = 'B031') * s0_aa_dist_02 +
    (integer)(s0_aa_code_03 = 'B031') * s0_aa_dist_03 +
    (integer)(s0_aa_code_04 = 'B031') * s0_aa_dist_04 +
    (integer)(s0_aa_code_05 = 'B031') * s0_aa_dist_05 +
    (integer)(s0_aa_code_06 = 'B031') * s0_aa_dist_06 +
    (integer)(s0_aa_code_07 = 'B031') * s0_aa_dist_07 +
    (integer)(s0_aa_code_08 = 'B031') * s0_aa_dist_08 +
    (integer)(s0_aa_code_09 = 'B031') * s0_aa_dist_09 +
    (integer)(s0_aa_code_10 = 'B031') * s0_aa_dist_10 +
    (integer)(s0_aa_code_11 = 'B031') * s0_aa_dist_11 +
    (integer)(s0_aa_code_12 = 'B031') * s0_aa_dist_12 +
    (integer)(s0_aa_code_13 = 'B031') * s0_aa_dist_13 +
    (integer)(s0_aa_code_14 = 'B031') * s0_aa_dist_14 +
    (integer)(s0_aa_code_15 = 'B031') * s0_aa_dist_15 +
    (integer)(s0_aa_code_16 = 'B031') * s0_aa_dist_16 +
    (integer)(s0_aa_code_17 = 'B031') * s0_aa_dist_17 +
    (integer)(s0_aa_code_18 = 'B031') * s0_aa_dist_18 +
    (integer)(s0_aa_code_19 = 'B031') * s0_aa_dist_19 +
    (integer)(s0_aa_code_20 = 'B031') * s0_aa_dist_20 +
    (integer)(s0_aa_code_21 = 'B031') * s0_aa_dist_21 +
    (integer)(s0_aa_code_22 = 'B031') * s0_aa_dist_22 +
    (integer)(s0_aa_code_23 = 'B031') * s0_aa_dist_23 +
    (integer)(s0_aa_code_24 = 'B031') * s0_aa_dist_24 +
    (integer)(s0_aa_code_25 = 'B031') * s0_aa_dist_25 +
    (integer)(s0_aa_code_26 = 'B031') * s0_aa_dist_26 +
    (integer)(s0_aa_code_27 = 'B031') * s0_aa_dist_27 +
    (integer)(s0_aa_code_28 = 'B031') * s0_aa_dist_28 +
    (integer)(s0_aa_code_29 = 'B031') * s0_aa_dist_29 +
    (integer)(s0_aa_code_30 = 'B031') * s0_aa_dist_30 +
    (integer)(s0_aa_code_31 = 'B031') * s0_aa_dist_31 +
    (integer)(s0_aa_code_32 = 'B031') * s0_aa_dist_32 +
    (integer)(s0_aa_code_33 = 'B031') * s0_aa_dist_33 +
    (integer)(s0_aa_code_34 = 'B031') * s0_aa_dist_34 +
    (integer)(s0_aa_code_35 = 'B031') * s0_aa_dist_35 +
    (integer)(s0_aa_code_36 = 'B031') * s0_aa_dist_36 +
    (integer)(s0_aa_code_37 = 'B031') * s0_aa_dist_37 +
    (integer)(s0_aa_code_38 = 'B031') * s0_aa_dist_38 +
    (integer)(s0_aa_code_39 = 'B031') * s0_aa_dist_39 +
    (integer)(s0_aa_code_40 = 'B031') * s0_aa_dist_40 +
    (integer)(s0_aa_code_41 = 'B031') * s0_aa_dist_41 +
    (integer)(s0_aa_code_42 = 'B031') * s0_aa_dist_42 +
    (integer)(s0_aa_code_43 = 'B031') * s0_aa_dist_43 ) ;

s0_rcvaluep539 := __common__( (integer)(s0_aa_code_01 = 'P539') * s0_aa_dist_01 +
    (integer)(s0_aa_code_02 = 'P539') * s0_aa_dist_02 +
    (integer)(s0_aa_code_03 = 'P539') * s0_aa_dist_03 +
    (integer)(s0_aa_code_04 = 'P539') * s0_aa_dist_04 +
    (integer)(s0_aa_code_05 = 'P539') * s0_aa_dist_05 +
    (integer)(s0_aa_code_06 = 'P539') * s0_aa_dist_06 +
    (integer)(s0_aa_code_07 = 'P539') * s0_aa_dist_07 +
    (integer)(s0_aa_code_08 = 'P539') * s0_aa_dist_08 +
    (integer)(s0_aa_code_09 = 'P539') * s0_aa_dist_09 +
    (integer)(s0_aa_code_10 = 'P539') * s0_aa_dist_10 +
    (integer)(s0_aa_code_11 = 'P539') * s0_aa_dist_11 +
    (integer)(s0_aa_code_12 = 'P539') * s0_aa_dist_12 +
    (integer)(s0_aa_code_13 = 'P539') * s0_aa_dist_13 +
    (integer)(s0_aa_code_14 = 'P539') * s0_aa_dist_14 +
    (integer)(s0_aa_code_15 = 'P539') * s0_aa_dist_15 +
    (integer)(s0_aa_code_16 = 'P539') * s0_aa_dist_16 +
    (integer)(s0_aa_code_17 = 'P539') * s0_aa_dist_17 +
    (integer)(s0_aa_code_18 = 'P539') * s0_aa_dist_18 +
    (integer)(s0_aa_code_19 = 'P539') * s0_aa_dist_19 +
    (integer)(s0_aa_code_20 = 'P539') * s0_aa_dist_20 +
    (integer)(s0_aa_code_21 = 'P539') * s0_aa_dist_21 +
    (integer)(s0_aa_code_22 = 'P539') * s0_aa_dist_22 +
    (integer)(s0_aa_code_23 = 'P539') * s0_aa_dist_23 +
    (integer)(s0_aa_code_24 = 'P539') * s0_aa_dist_24 +
    (integer)(s0_aa_code_25 = 'P539') * s0_aa_dist_25 +
    (integer)(s0_aa_code_26 = 'P539') * s0_aa_dist_26 +
    (integer)(s0_aa_code_27 = 'P539') * s0_aa_dist_27 +
    (integer)(s0_aa_code_28 = 'P539') * s0_aa_dist_28 +
    (integer)(s0_aa_code_29 = 'P539') * s0_aa_dist_29 +
    (integer)(s0_aa_code_30 = 'P539') * s0_aa_dist_30 +
    (integer)(s0_aa_code_31 = 'P539') * s0_aa_dist_31 +
    (integer)(s0_aa_code_32 = 'P539') * s0_aa_dist_32 +
    (integer)(s0_aa_code_33 = 'P539') * s0_aa_dist_33 +
    (integer)(s0_aa_code_34 = 'P539') * s0_aa_dist_34 +
    (integer)(s0_aa_code_35 = 'P539') * s0_aa_dist_35 +
    (integer)(s0_aa_code_36 = 'P539') * s0_aa_dist_36 +
    (integer)(s0_aa_code_37 = 'P539') * s0_aa_dist_37 +
    (integer)(s0_aa_code_38 = 'P539') * s0_aa_dist_38 +
    (integer)(s0_aa_code_39 = 'P539') * s0_aa_dist_39 +
    (integer)(s0_aa_code_40 = 'P539') * s0_aa_dist_40 +
    (integer)(s0_aa_code_41 = 'P539') * s0_aa_dist_41 +
    (integer)(s0_aa_code_42 = 'P539') * s0_aa_dist_42 +
    (integer)(s0_aa_code_43 = 'P539') * s0_aa_dist_43 ) ;

s0_rcvalueb017 := __common__( (integer)(s0_aa_code_01 = 'B017') * s0_aa_dist_01 +
    (integer)(s0_aa_code_02 = 'B017') * s0_aa_dist_02 +
    (integer)(s0_aa_code_03 = 'B017') * s0_aa_dist_03 +
    (integer)(s0_aa_code_04 = 'B017') * s0_aa_dist_04 +
    (integer)(s0_aa_code_05 = 'B017') * s0_aa_dist_05 +
    (integer)(s0_aa_code_06 = 'B017') * s0_aa_dist_06 +
    (integer)(s0_aa_code_07 = 'B017') * s0_aa_dist_07 +
    (integer)(s0_aa_code_08 = 'B017') * s0_aa_dist_08 +
    (integer)(s0_aa_code_09 = 'B017') * s0_aa_dist_09 +
    (integer)(s0_aa_code_10 = 'B017') * s0_aa_dist_10 +
    (integer)(s0_aa_code_11 = 'B017') * s0_aa_dist_11 +
    (integer)(s0_aa_code_12 = 'B017') * s0_aa_dist_12 +
    (integer)(s0_aa_code_13 = 'B017') * s0_aa_dist_13 +
    (integer)(s0_aa_code_14 = 'B017') * s0_aa_dist_14 +
    (integer)(s0_aa_code_15 = 'B017') * s0_aa_dist_15 +
    (integer)(s0_aa_code_16 = 'B017') * s0_aa_dist_16 +
    (integer)(s0_aa_code_17 = 'B017') * s0_aa_dist_17 +
    (integer)(s0_aa_code_18 = 'B017') * s0_aa_dist_18 +
    (integer)(s0_aa_code_19 = 'B017') * s0_aa_dist_19 +
    (integer)(s0_aa_code_20 = 'B017') * s0_aa_dist_20 +
    (integer)(s0_aa_code_21 = 'B017') * s0_aa_dist_21 +
    (integer)(s0_aa_code_22 = 'B017') * s0_aa_dist_22 +
    (integer)(s0_aa_code_23 = 'B017') * s0_aa_dist_23 +
    (integer)(s0_aa_code_24 = 'B017') * s0_aa_dist_24 +
    (integer)(s0_aa_code_25 = 'B017') * s0_aa_dist_25 +
    (integer)(s0_aa_code_26 = 'B017') * s0_aa_dist_26 +
    (integer)(s0_aa_code_27 = 'B017') * s0_aa_dist_27 +
    (integer)(s0_aa_code_28 = 'B017') * s0_aa_dist_28 +
    (integer)(s0_aa_code_29 = 'B017') * s0_aa_dist_29 +
    (integer)(s0_aa_code_30 = 'B017') * s0_aa_dist_30 +
    (integer)(s0_aa_code_31 = 'B017') * s0_aa_dist_31 +
    (integer)(s0_aa_code_32 = 'B017') * s0_aa_dist_32 +
    (integer)(s0_aa_code_33 = 'B017') * s0_aa_dist_33 +
    (integer)(s0_aa_code_34 = 'B017') * s0_aa_dist_34 +
    (integer)(s0_aa_code_35 = 'B017') * s0_aa_dist_35 +
    (integer)(s0_aa_code_36 = 'B017') * s0_aa_dist_36 +
    (integer)(s0_aa_code_37 = 'B017') * s0_aa_dist_37 +
    (integer)(s0_aa_code_38 = 'B017') * s0_aa_dist_38 +
    (integer)(s0_aa_code_39 = 'B017') * s0_aa_dist_39 +
    (integer)(s0_aa_code_40 = 'B017') * s0_aa_dist_40 +
    (integer)(s0_aa_code_41 = 'B017') * s0_aa_dist_41 +
    (integer)(s0_aa_code_42 = 'B017') * s0_aa_dist_42 +
    (integer)(s0_aa_code_43 = 'B017') * s0_aa_dist_43 ) ;

s0_rcvaluep515 := __common__( (integer)(s0_aa_code_01 = 'P515') * s0_aa_dist_01 +
    (integer)(s0_aa_code_02 = 'P515') * s0_aa_dist_02 +
    (integer)(s0_aa_code_03 = 'P515') * s0_aa_dist_03 +
    (integer)(s0_aa_code_04 = 'P515') * s0_aa_dist_04 +
    (integer)(s0_aa_code_05 = 'P515') * s0_aa_dist_05 +
    (integer)(s0_aa_code_06 = 'P515') * s0_aa_dist_06 +
    (integer)(s0_aa_code_07 = 'P515') * s0_aa_dist_07 +
    (integer)(s0_aa_code_08 = 'P515') * s0_aa_dist_08 +
    (integer)(s0_aa_code_09 = 'P515') * s0_aa_dist_09 +
    (integer)(s0_aa_code_10 = 'P515') * s0_aa_dist_10 +
    (integer)(s0_aa_code_11 = 'P515') * s0_aa_dist_11 +
    (integer)(s0_aa_code_12 = 'P515') * s0_aa_dist_12 +
    (integer)(s0_aa_code_13 = 'P515') * s0_aa_dist_13 +
    (integer)(s0_aa_code_14 = 'P515') * s0_aa_dist_14 +
    (integer)(s0_aa_code_15 = 'P515') * s0_aa_dist_15 +
    (integer)(s0_aa_code_16 = 'P515') * s0_aa_dist_16 +
    (integer)(s0_aa_code_17 = 'P515') * s0_aa_dist_17 +
    (integer)(s0_aa_code_18 = 'P515') * s0_aa_dist_18 +
    (integer)(s0_aa_code_19 = 'P515') * s0_aa_dist_19 +
    (integer)(s0_aa_code_20 = 'P515') * s0_aa_dist_20 +
    (integer)(s0_aa_code_21 = 'P515') * s0_aa_dist_21 +
    (integer)(s0_aa_code_22 = 'P515') * s0_aa_dist_22 +
    (integer)(s0_aa_code_23 = 'P515') * s0_aa_dist_23 +
    (integer)(s0_aa_code_24 = 'P515') * s0_aa_dist_24 +
    (integer)(s0_aa_code_25 = 'P515') * s0_aa_dist_25 +
    (integer)(s0_aa_code_26 = 'P515') * s0_aa_dist_26 +
    (integer)(s0_aa_code_27 = 'P515') * s0_aa_dist_27 +
    (integer)(s0_aa_code_28 = 'P515') * s0_aa_dist_28 +
    (integer)(s0_aa_code_29 = 'P515') * s0_aa_dist_29 +
    (integer)(s0_aa_code_30 = 'P515') * s0_aa_dist_30 +
    (integer)(s0_aa_code_31 = 'P515') * s0_aa_dist_31 +
    (integer)(s0_aa_code_32 = 'P515') * s0_aa_dist_32 +
    (integer)(s0_aa_code_33 = 'P515') * s0_aa_dist_33 +
    (integer)(s0_aa_code_34 = 'P515') * s0_aa_dist_34 +
    (integer)(s0_aa_code_35 = 'P515') * s0_aa_dist_35 +
    (integer)(s0_aa_code_36 = 'P515') * s0_aa_dist_36 +
    (integer)(s0_aa_code_37 = 'P515') * s0_aa_dist_37 +
    (integer)(s0_aa_code_38 = 'P515') * s0_aa_dist_38 +
    (integer)(s0_aa_code_39 = 'P515') * s0_aa_dist_39 +
    (integer)(s0_aa_code_40 = 'P515') * s0_aa_dist_40 +
    (integer)(s0_aa_code_41 = 'P515') * s0_aa_dist_41 +
    (integer)(s0_aa_code_42 = 'P515') * s0_aa_dist_42 +
    (integer)(s0_aa_code_43 = 'P515') * s0_aa_dist_43 ) ;

s0_rcvaluep513 := __common__( (integer)(s0_aa_code_01 = 'P513') * s0_aa_dist_01 +
    (integer)(s0_aa_code_02 = 'P513') * s0_aa_dist_02 +
    (integer)(s0_aa_code_03 = 'P513') * s0_aa_dist_03 +
    (integer)(s0_aa_code_04 = 'P513') * s0_aa_dist_04 +
    (integer)(s0_aa_code_05 = 'P513') * s0_aa_dist_05 +
    (integer)(s0_aa_code_06 = 'P513') * s0_aa_dist_06 +
    (integer)(s0_aa_code_07 = 'P513') * s0_aa_dist_07 +
    (integer)(s0_aa_code_08 = 'P513') * s0_aa_dist_08 +
    (integer)(s0_aa_code_09 = 'P513') * s0_aa_dist_09 +
    (integer)(s0_aa_code_10 = 'P513') * s0_aa_dist_10 +
    (integer)(s0_aa_code_11 = 'P513') * s0_aa_dist_11 +
    (integer)(s0_aa_code_12 = 'P513') * s0_aa_dist_12 +
    (integer)(s0_aa_code_13 = 'P513') * s0_aa_dist_13 +
    (integer)(s0_aa_code_14 = 'P513') * s0_aa_dist_14 +
    (integer)(s0_aa_code_15 = 'P513') * s0_aa_dist_15 +
    (integer)(s0_aa_code_16 = 'P513') * s0_aa_dist_16 +
    (integer)(s0_aa_code_17 = 'P513') * s0_aa_dist_17 +
    (integer)(s0_aa_code_18 = 'P513') * s0_aa_dist_18 +
    (integer)(s0_aa_code_19 = 'P513') * s0_aa_dist_19 +
    (integer)(s0_aa_code_20 = 'P513') * s0_aa_dist_20 +
    (integer)(s0_aa_code_21 = 'P513') * s0_aa_dist_21 +
    (integer)(s0_aa_code_22 = 'P513') * s0_aa_dist_22 +
    (integer)(s0_aa_code_23 = 'P513') * s0_aa_dist_23 +
    (integer)(s0_aa_code_24 = 'P513') * s0_aa_dist_24 +
    (integer)(s0_aa_code_25 = 'P513') * s0_aa_dist_25 +
    (integer)(s0_aa_code_26 = 'P513') * s0_aa_dist_26 +
    (integer)(s0_aa_code_27 = 'P513') * s0_aa_dist_27 +
    (integer)(s0_aa_code_28 = 'P513') * s0_aa_dist_28 +
    (integer)(s0_aa_code_29 = 'P513') * s0_aa_dist_29 +
    (integer)(s0_aa_code_30 = 'P513') * s0_aa_dist_30 +
    (integer)(s0_aa_code_31 = 'P513') * s0_aa_dist_31 +
    (integer)(s0_aa_code_32 = 'P513') * s0_aa_dist_32 +
    (integer)(s0_aa_code_33 = 'P513') * s0_aa_dist_33 +
    (integer)(s0_aa_code_34 = 'P513') * s0_aa_dist_34 +
    (integer)(s0_aa_code_35 = 'P513') * s0_aa_dist_35 +
    (integer)(s0_aa_code_36 = 'P513') * s0_aa_dist_36 +
    (integer)(s0_aa_code_37 = 'P513') * s0_aa_dist_37 +
    (integer)(s0_aa_code_38 = 'P513') * s0_aa_dist_38 +
    (integer)(s0_aa_code_39 = 'P513') * s0_aa_dist_39 +
    (integer)(s0_aa_code_40 = 'P513') * s0_aa_dist_40 +
    (integer)(s0_aa_code_41 = 'P513') * s0_aa_dist_41 +
    (integer)(s0_aa_code_42 = 'P513') * s0_aa_dist_42 +
    (integer)(s0_aa_code_43 = 'P513') * s0_aa_dist_43 ) ;

s0_rcvalueb075 := __common__( (integer)(s0_aa_code_01 = 'B075') * s0_aa_dist_01 +
    (integer)(s0_aa_code_02 = 'B075') * s0_aa_dist_02 +
    (integer)(s0_aa_code_03 = 'B075') * s0_aa_dist_03 +
    (integer)(s0_aa_code_04 = 'B075') * s0_aa_dist_04 +
    (integer)(s0_aa_code_05 = 'B075') * s0_aa_dist_05 +
    (integer)(s0_aa_code_06 = 'B075') * s0_aa_dist_06 +
    (integer)(s0_aa_code_07 = 'B075') * s0_aa_dist_07 +
    (integer)(s0_aa_code_08 = 'B075') * s0_aa_dist_08 +
    (integer)(s0_aa_code_09 = 'B075') * s0_aa_dist_09 +
    (integer)(s0_aa_code_10 = 'B075') * s0_aa_dist_10 +
    (integer)(s0_aa_code_11 = 'B075') * s0_aa_dist_11 +
    (integer)(s0_aa_code_12 = 'B075') * s0_aa_dist_12 +
    (integer)(s0_aa_code_13 = 'B075') * s0_aa_dist_13 +
    (integer)(s0_aa_code_14 = 'B075') * s0_aa_dist_14 +
    (integer)(s0_aa_code_15 = 'B075') * s0_aa_dist_15 +
    (integer)(s0_aa_code_16 = 'B075') * s0_aa_dist_16 +
    (integer)(s0_aa_code_17 = 'B075') * s0_aa_dist_17 +
    (integer)(s0_aa_code_18 = 'B075') * s0_aa_dist_18 +
    (integer)(s0_aa_code_19 = 'B075') * s0_aa_dist_19 +
    (integer)(s0_aa_code_20 = 'B075') * s0_aa_dist_20 +
    (integer)(s0_aa_code_21 = 'B075') * s0_aa_dist_21 +
    (integer)(s0_aa_code_22 = 'B075') * s0_aa_dist_22 +
    (integer)(s0_aa_code_23 = 'B075') * s0_aa_dist_23 +
    (integer)(s0_aa_code_24 = 'B075') * s0_aa_dist_24 +
    (integer)(s0_aa_code_25 = 'B075') * s0_aa_dist_25 +
    (integer)(s0_aa_code_26 = 'B075') * s0_aa_dist_26 +
    (integer)(s0_aa_code_27 = 'B075') * s0_aa_dist_27 +
    (integer)(s0_aa_code_28 = 'B075') * s0_aa_dist_28 +
    (integer)(s0_aa_code_29 = 'B075') * s0_aa_dist_29 +
    (integer)(s0_aa_code_30 = 'B075') * s0_aa_dist_30 +
    (integer)(s0_aa_code_31 = 'B075') * s0_aa_dist_31 +
    (integer)(s0_aa_code_32 = 'B075') * s0_aa_dist_32 +
    (integer)(s0_aa_code_33 = 'B075') * s0_aa_dist_33 +
    (integer)(s0_aa_code_34 = 'B075') * s0_aa_dist_34 +
    (integer)(s0_aa_code_35 = 'B075') * s0_aa_dist_35 +
    (integer)(s0_aa_code_36 = 'B075') * s0_aa_dist_36 +
    (integer)(s0_aa_code_37 = 'B075') * s0_aa_dist_37 +
    (integer)(s0_aa_code_38 = 'B075') * s0_aa_dist_38 +
    (integer)(s0_aa_code_39 = 'B075') * s0_aa_dist_39 +
    (integer)(s0_aa_code_40 = 'B075') * s0_aa_dist_40 +
    (integer)(s0_aa_code_41 = 'B075') * s0_aa_dist_41 +
    (integer)(s0_aa_code_42 = 'B075') * s0_aa_dist_42 +
    (integer)(s0_aa_code_43 = 'B075') * s0_aa_dist_43 ) ;

s0_rcvaluep526 := __common__( (integer)(s0_aa_code_01 = 'P526') * s0_aa_dist_01 +
    (integer)(s0_aa_code_02 = 'P526') * s0_aa_dist_02 +
    (integer)(s0_aa_code_03 = 'P526') * s0_aa_dist_03 +
    (integer)(s0_aa_code_04 = 'P526') * s0_aa_dist_04 +
    (integer)(s0_aa_code_05 = 'P526') * s0_aa_dist_05 +
    (integer)(s0_aa_code_06 = 'P526') * s0_aa_dist_06 +
    (integer)(s0_aa_code_07 = 'P526') * s0_aa_dist_07 +
    (integer)(s0_aa_code_08 = 'P526') * s0_aa_dist_08 +
    (integer)(s0_aa_code_09 = 'P526') * s0_aa_dist_09 +
    (integer)(s0_aa_code_10 = 'P526') * s0_aa_dist_10 +
    (integer)(s0_aa_code_11 = 'P526') * s0_aa_dist_11 +
    (integer)(s0_aa_code_12 = 'P526') * s0_aa_dist_12 +
    (integer)(s0_aa_code_13 = 'P526') * s0_aa_dist_13 +
    (integer)(s0_aa_code_14 = 'P526') * s0_aa_dist_14 +
    (integer)(s0_aa_code_15 = 'P526') * s0_aa_dist_15 +
    (integer)(s0_aa_code_16 = 'P526') * s0_aa_dist_16 +
    (integer)(s0_aa_code_17 = 'P526') * s0_aa_dist_17 +
    (integer)(s0_aa_code_18 = 'P526') * s0_aa_dist_18 +
    (integer)(s0_aa_code_19 = 'P526') * s0_aa_dist_19 +
    (integer)(s0_aa_code_20 = 'P526') * s0_aa_dist_20 +
    (integer)(s0_aa_code_21 = 'P526') * s0_aa_dist_21 +
    (integer)(s0_aa_code_22 = 'P526') * s0_aa_dist_22 +
    (integer)(s0_aa_code_23 = 'P526') * s0_aa_dist_23 +
    (integer)(s0_aa_code_24 = 'P526') * s0_aa_dist_24 +
    (integer)(s0_aa_code_25 = 'P526') * s0_aa_dist_25 +
    (integer)(s0_aa_code_26 = 'P526') * s0_aa_dist_26 +
    (integer)(s0_aa_code_27 = 'P526') * s0_aa_dist_27 +
    (integer)(s0_aa_code_28 = 'P526') * s0_aa_dist_28 +
    (integer)(s0_aa_code_29 = 'P526') * s0_aa_dist_29 +
    (integer)(s0_aa_code_30 = 'P526') * s0_aa_dist_30 +
    (integer)(s0_aa_code_31 = 'P526') * s0_aa_dist_31 +
    (integer)(s0_aa_code_32 = 'P526') * s0_aa_dist_32 +
    (integer)(s0_aa_code_33 = 'P526') * s0_aa_dist_33 +
    (integer)(s0_aa_code_34 = 'P526') * s0_aa_dist_34 +
    (integer)(s0_aa_code_35 = 'P526') * s0_aa_dist_35 +
    (integer)(s0_aa_code_36 = 'P526') * s0_aa_dist_36 +
    (integer)(s0_aa_code_37 = 'P526') * s0_aa_dist_37 +
    (integer)(s0_aa_code_38 = 'P526') * s0_aa_dist_38 +
    (integer)(s0_aa_code_39 = 'P526') * s0_aa_dist_39 +
    (integer)(s0_aa_code_40 = 'P526') * s0_aa_dist_40 +
    (integer)(s0_aa_code_41 = 'P526') * s0_aa_dist_41 +
    (integer)(s0_aa_code_42 = 'P526') * s0_aa_dist_42 +
    (integer)(s0_aa_code_43 = 'P526') * s0_aa_dist_43 ) ;

s0_rcvalueb079 := __common__( (integer)(s0_aa_code_01 = 'B079') * s0_aa_dist_01 +
    (integer)(s0_aa_code_02 = 'B079') * s0_aa_dist_02 +
    (integer)(s0_aa_code_03 = 'B079') * s0_aa_dist_03 +
    (integer)(s0_aa_code_04 = 'B079') * s0_aa_dist_04 +
    (integer)(s0_aa_code_05 = 'B079') * s0_aa_dist_05 +
    (integer)(s0_aa_code_06 = 'B079') * s0_aa_dist_06 +
    (integer)(s0_aa_code_07 = 'B079') * s0_aa_dist_07 +
    (integer)(s0_aa_code_08 = 'B079') * s0_aa_dist_08 +
    (integer)(s0_aa_code_09 = 'B079') * s0_aa_dist_09 +
    (integer)(s0_aa_code_10 = 'B079') * s0_aa_dist_10 +
    (integer)(s0_aa_code_11 = 'B079') * s0_aa_dist_11 +
    (integer)(s0_aa_code_12 = 'B079') * s0_aa_dist_12 +
    (integer)(s0_aa_code_13 = 'B079') * s0_aa_dist_13 +
    (integer)(s0_aa_code_14 = 'B079') * s0_aa_dist_14 +
    (integer)(s0_aa_code_15 = 'B079') * s0_aa_dist_15 +
    (integer)(s0_aa_code_16 = 'B079') * s0_aa_dist_16 +
    (integer)(s0_aa_code_17 = 'B079') * s0_aa_dist_17 +
    (integer)(s0_aa_code_18 = 'B079') * s0_aa_dist_18 +
    (integer)(s0_aa_code_19 = 'B079') * s0_aa_dist_19 +
    (integer)(s0_aa_code_20 = 'B079') * s0_aa_dist_20 +
    (integer)(s0_aa_code_21 = 'B079') * s0_aa_dist_21 +
    (integer)(s0_aa_code_22 = 'B079') * s0_aa_dist_22 +
    (integer)(s0_aa_code_23 = 'B079') * s0_aa_dist_23 +
    (integer)(s0_aa_code_24 = 'B079') * s0_aa_dist_24 +
    (integer)(s0_aa_code_25 = 'B079') * s0_aa_dist_25 +
    (integer)(s0_aa_code_26 = 'B079') * s0_aa_dist_26 +
    (integer)(s0_aa_code_27 = 'B079') * s0_aa_dist_27 +
    (integer)(s0_aa_code_28 = 'B079') * s0_aa_dist_28 +
    (integer)(s0_aa_code_29 = 'B079') * s0_aa_dist_29 +
    (integer)(s0_aa_code_30 = 'B079') * s0_aa_dist_30 +
    (integer)(s0_aa_code_31 = 'B079') * s0_aa_dist_31 +
    (integer)(s0_aa_code_32 = 'B079') * s0_aa_dist_32 +
    (integer)(s0_aa_code_33 = 'B079') * s0_aa_dist_33 +
    (integer)(s0_aa_code_34 = 'B079') * s0_aa_dist_34 +
    (integer)(s0_aa_code_35 = 'B079') * s0_aa_dist_35 +
    (integer)(s0_aa_code_36 = 'B079') * s0_aa_dist_36 +
    (integer)(s0_aa_code_37 = 'B079') * s0_aa_dist_37 +
    (integer)(s0_aa_code_38 = 'B079') * s0_aa_dist_38 +
    (integer)(s0_aa_code_39 = 'B079') * s0_aa_dist_39 +
    (integer)(s0_aa_code_40 = 'B079') * s0_aa_dist_40 +
    (integer)(s0_aa_code_41 = 'B079') * s0_aa_dist_41 +
    (integer)(s0_aa_code_42 = 'B079') * s0_aa_dist_42 +
    (integer)(s0_aa_code_43 = 'B079') * s0_aa_dist_43 ) ;

s0_rcvalueb070 := __common__( (integer)(s0_aa_code_01 = 'B070') * s0_aa_dist_01 +
    (integer)(s0_aa_code_02 = 'B070') * s0_aa_dist_02 +
    (integer)(s0_aa_code_03 = 'B070') * s0_aa_dist_03 +
    (integer)(s0_aa_code_04 = 'B070') * s0_aa_dist_04 +
    (integer)(s0_aa_code_05 = 'B070') * s0_aa_dist_05 +
    (integer)(s0_aa_code_06 = 'B070') * s0_aa_dist_06 +
    (integer)(s0_aa_code_07 = 'B070') * s0_aa_dist_07 +
    (integer)(s0_aa_code_08 = 'B070') * s0_aa_dist_08 +
    (integer)(s0_aa_code_09 = 'B070') * s0_aa_dist_09 +
    (integer)(s0_aa_code_10 = 'B070') * s0_aa_dist_10 +
    (integer)(s0_aa_code_11 = 'B070') * s0_aa_dist_11 +
    (integer)(s0_aa_code_12 = 'B070') * s0_aa_dist_12 +
    (integer)(s0_aa_code_13 = 'B070') * s0_aa_dist_13 +
    (integer)(s0_aa_code_14 = 'B070') * s0_aa_dist_14 +
    (integer)(s0_aa_code_15 = 'B070') * s0_aa_dist_15 +
    (integer)(s0_aa_code_16 = 'B070') * s0_aa_dist_16 +
    (integer)(s0_aa_code_17 = 'B070') * s0_aa_dist_17 +
    (integer)(s0_aa_code_18 = 'B070') * s0_aa_dist_18 +
    (integer)(s0_aa_code_19 = 'B070') * s0_aa_dist_19 +
    (integer)(s0_aa_code_20 = 'B070') * s0_aa_dist_20 +
    (integer)(s0_aa_code_21 = 'B070') * s0_aa_dist_21 +
    (integer)(s0_aa_code_22 = 'B070') * s0_aa_dist_22 +
    (integer)(s0_aa_code_23 = 'B070') * s0_aa_dist_23 +
    (integer)(s0_aa_code_24 = 'B070') * s0_aa_dist_24 +
    (integer)(s0_aa_code_25 = 'B070') * s0_aa_dist_25 +
    (integer)(s0_aa_code_26 = 'B070') * s0_aa_dist_26 +
    (integer)(s0_aa_code_27 = 'B070') * s0_aa_dist_27 +
    (integer)(s0_aa_code_28 = 'B070') * s0_aa_dist_28 +
    (integer)(s0_aa_code_29 = 'B070') * s0_aa_dist_29 +
    (integer)(s0_aa_code_30 = 'B070') * s0_aa_dist_30 +
    (integer)(s0_aa_code_31 = 'B070') * s0_aa_dist_31 +
    (integer)(s0_aa_code_32 = 'B070') * s0_aa_dist_32 +
    (integer)(s0_aa_code_33 = 'B070') * s0_aa_dist_33 +
    (integer)(s0_aa_code_34 = 'B070') * s0_aa_dist_34 +
    (integer)(s0_aa_code_35 = 'B070') * s0_aa_dist_35 +
    (integer)(s0_aa_code_36 = 'B070') * s0_aa_dist_36 +
    (integer)(s0_aa_code_37 = 'B070') * s0_aa_dist_37 +
    (integer)(s0_aa_code_38 = 'B070') * s0_aa_dist_38 +
    (integer)(s0_aa_code_39 = 'B070') * s0_aa_dist_39 +
    (integer)(s0_aa_code_40 = 'B070') * s0_aa_dist_40 +
    (integer)(s0_aa_code_41 = 'B070') * s0_aa_dist_41 +
    (integer)(s0_aa_code_42 = 'B070') * s0_aa_dist_42 +
    (integer)(s0_aa_code_43 = 'B070') * s0_aa_dist_43 ) ;

s0_rcvaluep509 := __common__( (integer)(s0_aa_code_01 = 'P509') * s0_aa_dist_01 +
    (integer)(s0_aa_code_02 = 'P509') * s0_aa_dist_02 +
    (integer)(s0_aa_code_03 = 'P509') * s0_aa_dist_03 +
    (integer)(s0_aa_code_04 = 'P509') * s0_aa_dist_04 +
    (integer)(s0_aa_code_05 = 'P509') * s0_aa_dist_05 +
    (integer)(s0_aa_code_06 = 'P509') * s0_aa_dist_06 +
    (integer)(s0_aa_code_07 = 'P509') * s0_aa_dist_07 +
    (integer)(s0_aa_code_08 = 'P509') * s0_aa_dist_08 +
    (integer)(s0_aa_code_09 = 'P509') * s0_aa_dist_09 +
    (integer)(s0_aa_code_10 = 'P509') * s0_aa_dist_10 +
    (integer)(s0_aa_code_11 = 'P509') * s0_aa_dist_11 +
    (integer)(s0_aa_code_12 = 'P509') * s0_aa_dist_12 +
    (integer)(s0_aa_code_13 = 'P509') * s0_aa_dist_13 +
    (integer)(s0_aa_code_14 = 'P509') * s0_aa_dist_14 +
    (integer)(s0_aa_code_15 = 'P509') * s0_aa_dist_15 +
    (integer)(s0_aa_code_16 = 'P509') * s0_aa_dist_16 +
    (integer)(s0_aa_code_17 = 'P509') * s0_aa_dist_17 +
    (integer)(s0_aa_code_18 = 'P509') * s0_aa_dist_18 +
    (integer)(s0_aa_code_19 = 'P509') * s0_aa_dist_19 +
    (integer)(s0_aa_code_20 = 'P509') * s0_aa_dist_20 +
    (integer)(s0_aa_code_21 = 'P509') * s0_aa_dist_21 +
    (integer)(s0_aa_code_22 = 'P509') * s0_aa_dist_22 +
    (integer)(s0_aa_code_23 = 'P509') * s0_aa_dist_23 +
    (integer)(s0_aa_code_24 = 'P509') * s0_aa_dist_24 +
    (integer)(s0_aa_code_25 = 'P509') * s0_aa_dist_25 +
    (integer)(s0_aa_code_26 = 'P509') * s0_aa_dist_26 +
    (integer)(s0_aa_code_27 = 'P509') * s0_aa_dist_27 +
    (integer)(s0_aa_code_28 = 'P509') * s0_aa_dist_28 +
    (integer)(s0_aa_code_29 = 'P509') * s0_aa_dist_29 +
    (integer)(s0_aa_code_30 = 'P509') * s0_aa_dist_30 +
    (integer)(s0_aa_code_31 = 'P509') * s0_aa_dist_31 +
    (integer)(s0_aa_code_32 = 'P509') * s0_aa_dist_32 +
    (integer)(s0_aa_code_33 = 'P509') * s0_aa_dist_33 +
    (integer)(s0_aa_code_34 = 'P509') * s0_aa_dist_34 +
    (integer)(s0_aa_code_35 = 'P509') * s0_aa_dist_35 +
    (integer)(s0_aa_code_36 = 'P509') * s0_aa_dist_36 +
    (integer)(s0_aa_code_37 = 'P509') * s0_aa_dist_37 +
    (integer)(s0_aa_code_38 = 'P509') * s0_aa_dist_38 +
    (integer)(s0_aa_code_39 = 'P509') * s0_aa_dist_39 +
    (integer)(s0_aa_code_40 = 'P509') * s0_aa_dist_40 +
    (integer)(s0_aa_code_41 = 'P509') * s0_aa_dist_41 +
    (integer)(s0_aa_code_42 = 'P509') * s0_aa_dist_42 +
    (integer)(s0_aa_code_43 = 'P509') * s0_aa_dist_43 ) ;

s0_rcvalueb069 := __common__( (integer)(s0_aa_code_01 = 'B069') * s0_aa_dist_01 +
    (integer)(s0_aa_code_02 = 'B069') * s0_aa_dist_02 +
    (integer)(s0_aa_code_03 = 'B069') * s0_aa_dist_03 +
    (integer)(s0_aa_code_04 = 'B069') * s0_aa_dist_04 +
    (integer)(s0_aa_code_05 = 'B069') * s0_aa_dist_05 +
    (integer)(s0_aa_code_06 = 'B069') * s0_aa_dist_06 +
    (integer)(s0_aa_code_07 = 'B069') * s0_aa_dist_07 +
    (integer)(s0_aa_code_08 = 'B069') * s0_aa_dist_08 +
    (integer)(s0_aa_code_09 = 'B069') * s0_aa_dist_09 +
    (integer)(s0_aa_code_10 = 'B069') * s0_aa_dist_10 +
    (integer)(s0_aa_code_11 = 'B069') * s0_aa_dist_11 +
    (integer)(s0_aa_code_12 = 'B069') * s0_aa_dist_12 +
    (integer)(s0_aa_code_13 = 'B069') * s0_aa_dist_13 +
    (integer)(s0_aa_code_14 = 'B069') * s0_aa_dist_14 +
    (integer)(s0_aa_code_15 = 'B069') * s0_aa_dist_15 +
    (integer)(s0_aa_code_16 = 'B069') * s0_aa_dist_16 +
    (integer)(s0_aa_code_17 = 'B069') * s0_aa_dist_17 +
    (integer)(s0_aa_code_18 = 'B069') * s0_aa_dist_18 +
    (integer)(s0_aa_code_19 = 'B069') * s0_aa_dist_19 +
    (integer)(s0_aa_code_20 = 'B069') * s0_aa_dist_20 +
    (integer)(s0_aa_code_21 = 'B069') * s0_aa_dist_21 +
    (integer)(s0_aa_code_22 = 'B069') * s0_aa_dist_22 +
    (integer)(s0_aa_code_23 = 'B069') * s0_aa_dist_23 +
    (integer)(s0_aa_code_24 = 'B069') * s0_aa_dist_24 +
    (integer)(s0_aa_code_25 = 'B069') * s0_aa_dist_25 +
    (integer)(s0_aa_code_26 = 'B069') * s0_aa_dist_26 +
    (integer)(s0_aa_code_27 = 'B069') * s0_aa_dist_27 +
    (integer)(s0_aa_code_28 = 'B069') * s0_aa_dist_28 +
    (integer)(s0_aa_code_29 = 'B069') * s0_aa_dist_29 +
    (integer)(s0_aa_code_30 = 'B069') * s0_aa_dist_30 +
    (integer)(s0_aa_code_31 = 'B069') * s0_aa_dist_31 +
    (integer)(s0_aa_code_32 = 'B069') * s0_aa_dist_32 +
    (integer)(s0_aa_code_33 = 'B069') * s0_aa_dist_33 +
    (integer)(s0_aa_code_34 = 'B069') * s0_aa_dist_34 +
    (integer)(s0_aa_code_35 = 'B069') * s0_aa_dist_35 +
    (integer)(s0_aa_code_36 = 'B069') * s0_aa_dist_36 +
    (integer)(s0_aa_code_37 = 'B069') * s0_aa_dist_37 +
    (integer)(s0_aa_code_38 = 'B069') * s0_aa_dist_38 +
    (integer)(s0_aa_code_39 = 'B069') * s0_aa_dist_39 +
    (integer)(s0_aa_code_40 = 'B069') * s0_aa_dist_40 +
    (integer)(s0_aa_code_41 = 'B069') * s0_aa_dist_41 +
    (integer)(s0_aa_code_42 = 'B069') * s0_aa_dist_42 +
    (integer)(s0_aa_code_43 = 'B069') * s0_aa_dist_43 ) ;

s0_rcvalueb026 := __common__( (integer)(s0_aa_code_01 = 'B026') * s0_aa_dist_01 +
    (integer)(s0_aa_code_02 = 'B026') * s0_aa_dist_02 +
    (integer)(s0_aa_code_03 = 'B026') * s0_aa_dist_03 +
    (integer)(s0_aa_code_04 = 'B026') * s0_aa_dist_04 +
    (integer)(s0_aa_code_05 = 'B026') * s0_aa_dist_05 +
    (integer)(s0_aa_code_06 = 'B026') * s0_aa_dist_06 +
    (integer)(s0_aa_code_07 = 'B026') * s0_aa_dist_07 +
    (integer)(s0_aa_code_08 = 'B026') * s0_aa_dist_08 +
    (integer)(s0_aa_code_09 = 'B026') * s0_aa_dist_09 +
    (integer)(s0_aa_code_10 = 'B026') * s0_aa_dist_10 +
    (integer)(s0_aa_code_11 = 'B026') * s0_aa_dist_11 +
    (integer)(s0_aa_code_12 = 'B026') * s0_aa_dist_12 +
    (integer)(s0_aa_code_13 = 'B026') * s0_aa_dist_13 +
    (integer)(s0_aa_code_14 = 'B026') * s0_aa_dist_14 +
    (integer)(s0_aa_code_15 = 'B026') * s0_aa_dist_15 +
    (integer)(s0_aa_code_16 = 'B026') * s0_aa_dist_16 +
    (integer)(s0_aa_code_17 = 'B026') * s0_aa_dist_17 +
    (integer)(s0_aa_code_18 = 'B026') * s0_aa_dist_18 +
    (integer)(s0_aa_code_19 = 'B026') * s0_aa_dist_19 +
    (integer)(s0_aa_code_20 = 'B026') * s0_aa_dist_20 +
    (integer)(s0_aa_code_21 = 'B026') * s0_aa_dist_21 +
    (integer)(s0_aa_code_22 = 'B026') * s0_aa_dist_22 +
    (integer)(s0_aa_code_23 = 'B026') * s0_aa_dist_23 +
    (integer)(s0_aa_code_24 = 'B026') * s0_aa_dist_24 +
    (integer)(s0_aa_code_25 = 'B026') * s0_aa_dist_25 +
    (integer)(s0_aa_code_26 = 'B026') * s0_aa_dist_26 +
    (integer)(s0_aa_code_27 = 'B026') * s0_aa_dist_27 +
    (integer)(s0_aa_code_28 = 'B026') * s0_aa_dist_28 +
    (integer)(s0_aa_code_29 = 'B026') * s0_aa_dist_29 +
    (integer)(s0_aa_code_30 = 'B026') * s0_aa_dist_30 +
    (integer)(s0_aa_code_31 = 'B026') * s0_aa_dist_31 +
    (integer)(s0_aa_code_32 = 'B026') * s0_aa_dist_32 +
    (integer)(s0_aa_code_33 = 'B026') * s0_aa_dist_33 +
    (integer)(s0_aa_code_34 = 'B026') * s0_aa_dist_34 +
    (integer)(s0_aa_code_35 = 'B026') * s0_aa_dist_35 +
    (integer)(s0_aa_code_36 = 'B026') * s0_aa_dist_36 +
    (integer)(s0_aa_code_37 = 'B026') * s0_aa_dist_37 +
    (integer)(s0_aa_code_38 = 'B026') * s0_aa_dist_38 +
    (integer)(s0_aa_code_39 = 'B026') * s0_aa_dist_39 +
    (integer)(s0_aa_code_40 = 'B026') * s0_aa_dist_40 +
    (integer)(s0_aa_code_41 = 'B026') * s0_aa_dist_41 +
    (integer)(s0_aa_code_42 = 'B026') * s0_aa_dist_42 +
    (integer)(s0_aa_code_43 = 'B026') * s0_aa_dist_43 ) ;

s0_rcvaluep502 := __common__( (integer)(s0_aa_code_01 = 'P502') * s0_aa_dist_01 +
    (integer)(s0_aa_code_02 = 'P502') * s0_aa_dist_02 +
    (integer)(s0_aa_code_03 = 'P502') * s0_aa_dist_03 +
    (integer)(s0_aa_code_04 = 'P502') * s0_aa_dist_04 +
    (integer)(s0_aa_code_05 = 'P502') * s0_aa_dist_05 +
    (integer)(s0_aa_code_06 = 'P502') * s0_aa_dist_06 +
    (integer)(s0_aa_code_07 = 'P502') * s0_aa_dist_07 +
    (integer)(s0_aa_code_08 = 'P502') * s0_aa_dist_08 +
    (integer)(s0_aa_code_09 = 'P502') * s0_aa_dist_09 +
    (integer)(s0_aa_code_10 = 'P502') * s0_aa_dist_10 +
    (integer)(s0_aa_code_11 = 'P502') * s0_aa_dist_11 +
    (integer)(s0_aa_code_12 = 'P502') * s0_aa_dist_12 +
    (integer)(s0_aa_code_13 = 'P502') * s0_aa_dist_13 +
    (integer)(s0_aa_code_14 = 'P502') * s0_aa_dist_14 +
    (integer)(s0_aa_code_15 = 'P502') * s0_aa_dist_15 +
    (integer)(s0_aa_code_16 = 'P502') * s0_aa_dist_16 +
    (integer)(s0_aa_code_17 = 'P502') * s0_aa_dist_17 +
    (integer)(s0_aa_code_18 = 'P502') * s0_aa_dist_18 +
    (integer)(s0_aa_code_19 = 'P502') * s0_aa_dist_19 +
    (integer)(s0_aa_code_20 = 'P502') * s0_aa_dist_20 +
    (integer)(s0_aa_code_21 = 'P502') * s0_aa_dist_21 +
    (integer)(s0_aa_code_22 = 'P502') * s0_aa_dist_22 +
    (integer)(s0_aa_code_23 = 'P502') * s0_aa_dist_23 +
    (integer)(s0_aa_code_24 = 'P502') * s0_aa_dist_24 +
    (integer)(s0_aa_code_25 = 'P502') * s0_aa_dist_25 +
    (integer)(s0_aa_code_26 = 'P502') * s0_aa_dist_26 +
    (integer)(s0_aa_code_27 = 'P502') * s0_aa_dist_27 +
    (integer)(s0_aa_code_28 = 'P502') * s0_aa_dist_28 +
    (integer)(s0_aa_code_29 = 'P502') * s0_aa_dist_29 +
    (integer)(s0_aa_code_30 = 'P502') * s0_aa_dist_30 +
    (integer)(s0_aa_code_31 = 'P502') * s0_aa_dist_31 +
    (integer)(s0_aa_code_32 = 'P502') * s0_aa_dist_32 +
    (integer)(s0_aa_code_33 = 'P502') * s0_aa_dist_33 +
    (integer)(s0_aa_code_34 = 'P502') * s0_aa_dist_34 +
    (integer)(s0_aa_code_35 = 'P502') * s0_aa_dist_35 +
    (integer)(s0_aa_code_36 = 'P502') * s0_aa_dist_36 +
    (integer)(s0_aa_code_37 = 'P502') * s0_aa_dist_37 +
    (integer)(s0_aa_code_38 = 'P502') * s0_aa_dist_38 +
    (integer)(s0_aa_code_39 = 'P502') * s0_aa_dist_39 +
    (integer)(s0_aa_code_40 = 'P502') * s0_aa_dist_40 +
    (integer)(s0_aa_code_41 = 'P502') * s0_aa_dist_41 +
    (integer)(s0_aa_code_42 = 'P502') * s0_aa_dist_42 +
    (integer)(s0_aa_code_43 = 'P502') * s0_aa_dist_43 ) ;

s0_rcvaluep540 := __common__( (integer)(s0_aa_code_01 = 'P540') * s0_aa_dist_01 +
    (integer)(s0_aa_code_02 = 'P540') * s0_aa_dist_02 +
    (integer)(s0_aa_code_03 = 'P540') * s0_aa_dist_03 +
    (integer)(s0_aa_code_04 = 'P540') * s0_aa_dist_04 +
    (integer)(s0_aa_code_05 = 'P540') * s0_aa_dist_05 +
    (integer)(s0_aa_code_06 = 'P540') * s0_aa_dist_06 +
    (integer)(s0_aa_code_07 = 'P540') * s0_aa_dist_07 +
    (integer)(s0_aa_code_08 = 'P540') * s0_aa_dist_08 +
    (integer)(s0_aa_code_09 = 'P540') * s0_aa_dist_09 +
    (integer)(s0_aa_code_10 = 'P540') * s0_aa_dist_10 +
    (integer)(s0_aa_code_11 = 'P540') * s0_aa_dist_11 +
    (integer)(s0_aa_code_12 = 'P540') * s0_aa_dist_12 +
    (integer)(s0_aa_code_13 = 'P540') * s0_aa_dist_13 +
    (integer)(s0_aa_code_14 = 'P540') * s0_aa_dist_14 +
    (integer)(s0_aa_code_15 = 'P540') * s0_aa_dist_15 +
    (integer)(s0_aa_code_16 = 'P540') * s0_aa_dist_16 +
    (integer)(s0_aa_code_17 = 'P540') * s0_aa_dist_17 +
    (integer)(s0_aa_code_18 = 'P540') * s0_aa_dist_18 +
    (integer)(s0_aa_code_19 = 'P540') * s0_aa_dist_19 +
    (integer)(s0_aa_code_20 = 'P540') * s0_aa_dist_20 +
    (integer)(s0_aa_code_21 = 'P540') * s0_aa_dist_21 +
    (integer)(s0_aa_code_22 = 'P540') * s0_aa_dist_22 +
    (integer)(s0_aa_code_23 = 'P540') * s0_aa_dist_23 +
    (integer)(s0_aa_code_24 = 'P540') * s0_aa_dist_24 +
    (integer)(s0_aa_code_25 = 'P540') * s0_aa_dist_25 +
    (integer)(s0_aa_code_26 = 'P540') * s0_aa_dist_26 +
    (integer)(s0_aa_code_27 = 'P540') * s0_aa_dist_27 +
    (integer)(s0_aa_code_28 = 'P540') * s0_aa_dist_28 +
    (integer)(s0_aa_code_29 = 'P540') * s0_aa_dist_29 +
    (integer)(s0_aa_code_30 = 'P540') * s0_aa_dist_30 +
    (integer)(s0_aa_code_31 = 'P540') * s0_aa_dist_31 +
    (integer)(s0_aa_code_32 = 'P540') * s0_aa_dist_32 +
    (integer)(s0_aa_code_33 = 'P540') * s0_aa_dist_33 +
    (integer)(s0_aa_code_34 = 'P540') * s0_aa_dist_34 +
    (integer)(s0_aa_code_35 = 'P540') * s0_aa_dist_35 +
    (integer)(s0_aa_code_36 = 'P540') * s0_aa_dist_36 +
    (integer)(s0_aa_code_37 = 'P540') * s0_aa_dist_37 +
    (integer)(s0_aa_code_38 = 'P540') * s0_aa_dist_38 +
    (integer)(s0_aa_code_39 = 'P540') * s0_aa_dist_39 +
    (integer)(s0_aa_code_40 = 'P540') * s0_aa_dist_40 +
    (integer)(s0_aa_code_41 = 'P540') * s0_aa_dist_41 +
    (integer)(s0_aa_code_42 = 'P540') * s0_aa_dist_42 +
    (integer)(s0_aa_code_43 = 'P540') * s0_aa_dist_43 ) ;

s0_rcvaluep501 := __common__( (integer)(s0_aa_code_01 = 'P501') * s0_aa_dist_01 +
    (integer)(s0_aa_code_02 = 'P501') * s0_aa_dist_02 +
    (integer)(s0_aa_code_03 = 'P501') * s0_aa_dist_03 +
    (integer)(s0_aa_code_04 = 'P501') * s0_aa_dist_04 +
    (integer)(s0_aa_code_05 = 'P501') * s0_aa_dist_05 +
    (integer)(s0_aa_code_06 = 'P501') * s0_aa_dist_06 +
    (integer)(s0_aa_code_07 = 'P501') * s0_aa_dist_07 +
    (integer)(s0_aa_code_08 = 'P501') * s0_aa_dist_08 +
    (integer)(s0_aa_code_09 = 'P501') * s0_aa_dist_09 +
    (integer)(s0_aa_code_10 = 'P501') * s0_aa_dist_10 +
    (integer)(s0_aa_code_11 = 'P501') * s0_aa_dist_11 +
    (integer)(s0_aa_code_12 = 'P501') * s0_aa_dist_12 +
    (integer)(s0_aa_code_13 = 'P501') * s0_aa_dist_13 +
    (integer)(s0_aa_code_14 = 'P501') * s0_aa_dist_14 +
    (integer)(s0_aa_code_15 = 'P501') * s0_aa_dist_15 +
    (integer)(s0_aa_code_16 = 'P501') * s0_aa_dist_16 +
    (integer)(s0_aa_code_17 = 'P501') * s0_aa_dist_17 +
    (integer)(s0_aa_code_18 = 'P501') * s0_aa_dist_18 +
    (integer)(s0_aa_code_19 = 'P501') * s0_aa_dist_19 +
    (integer)(s0_aa_code_20 = 'P501') * s0_aa_dist_20 +
    (integer)(s0_aa_code_21 = 'P501') * s0_aa_dist_21 +
    (integer)(s0_aa_code_22 = 'P501') * s0_aa_dist_22 +
    (integer)(s0_aa_code_23 = 'P501') * s0_aa_dist_23 +
    (integer)(s0_aa_code_24 = 'P501') * s0_aa_dist_24 +
    (integer)(s0_aa_code_25 = 'P501') * s0_aa_dist_25 +
    (integer)(s0_aa_code_26 = 'P501') * s0_aa_dist_26 +
    (integer)(s0_aa_code_27 = 'P501') * s0_aa_dist_27 +
    (integer)(s0_aa_code_28 = 'P501') * s0_aa_dist_28 +
    (integer)(s0_aa_code_29 = 'P501') * s0_aa_dist_29 +
    (integer)(s0_aa_code_30 = 'P501') * s0_aa_dist_30 +
    (integer)(s0_aa_code_31 = 'P501') * s0_aa_dist_31 +
    (integer)(s0_aa_code_32 = 'P501') * s0_aa_dist_32 +
    (integer)(s0_aa_code_33 = 'P501') * s0_aa_dist_33 +
    (integer)(s0_aa_code_34 = 'P501') * s0_aa_dist_34 +
    (integer)(s0_aa_code_35 = 'P501') * s0_aa_dist_35 +
    (integer)(s0_aa_code_36 = 'P501') * s0_aa_dist_36 +
    (integer)(s0_aa_code_37 = 'P501') * s0_aa_dist_37 +
    (integer)(s0_aa_code_38 = 'P501') * s0_aa_dist_38 +
    (integer)(s0_aa_code_39 = 'P501') * s0_aa_dist_39 +
    (integer)(s0_aa_code_40 = 'P501') * s0_aa_dist_40 +
    (integer)(s0_aa_code_41 = 'P501') * s0_aa_dist_41 +
    (integer)(s0_aa_code_42 = 'P501') * s0_aa_dist_42 +
    (integer)(s0_aa_code_43 = 'P501') * s0_aa_dist_43 ) ;

s0_rcvalueb063 := __common__( (integer)(s0_aa_code_01 = 'B063') * s0_aa_dist_01 +
    (integer)(s0_aa_code_02 = 'B063') * s0_aa_dist_02 +
    (integer)(s0_aa_code_03 = 'B063') * s0_aa_dist_03 +
    (integer)(s0_aa_code_04 = 'B063') * s0_aa_dist_04 +
    (integer)(s0_aa_code_05 = 'B063') * s0_aa_dist_05 +
    (integer)(s0_aa_code_06 = 'B063') * s0_aa_dist_06 +
    (integer)(s0_aa_code_07 = 'B063') * s0_aa_dist_07 +
    (integer)(s0_aa_code_08 = 'B063') * s0_aa_dist_08 +
    (integer)(s0_aa_code_09 = 'B063') * s0_aa_dist_09 +
    (integer)(s0_aa_code_10 = 'B063') * s0_aa_dist_10 +
    (integer)(s0_aa_code_11 = 'B063') * s0_aa_dist_11 +
    (integer)(s0_aa_code_12 = 'B063') * s0_aa_dist_12 +
    (integer)(s0_aa_code_13 = 'B063') * s0_aa_dist_13 +
    (integer)(s0_aa_code_14 = 'B063') * s0_aa_dist_14 +
    (integer)(s0_aa_code_15 = 'B063') * s0_aa_dist_15 +
    (integer)(s0_aa_code_16 = 'B063') * s0_aa_dist_16 +
    (integer)(s0_aa_code_17 = 'B063') * s0_aa_dist_17 +
    (integer)(s0_aa_code_18 = 'B063') * s0_aa_dist_18 +
    (integer)(s0_aa_code_19 = 'B063') * s0_aa_dist_19 +
    (integer)(s0_aa_code_20 = 'B063') * s0_aa_dist_20 +
    (integer)(s0_aa_code_21 = 'B063') * s0_aa_dist_21 +
    (integer)(s0_aa_code_22 = 'B063') * s0_aa_dist_22 +
    (integer)(s0_aa_code_23 = 'B063') * s0_aa_dist_23 +
    (integer)(s0_aa_code_24 = 'B063') * s0_aa_dist_24 +
    (integer)(s0_aa_code_25 = 'B063') * s0_aa_dist_25 +
    (integer)(s0_aa_code_26 = 'B063') * s0_aa_dist_26 +
    (integer)(s0_aa_code_27 = 'B063') * s0_aa_dist_27 +
    (integer)(s0_aa_code_28 = 'B063') * s0_aa_dist_28 +
    (integer)(s0_aa_code_29 = 'B063') * s0_aa_dist_29 +
    (integer)(s0_aa_code_30 = 'B063') * s0_aa_dist_30 +
    (integer)(s0_aa_code_31 = 'B063') * s0_aa_dist_31 +
    (integer)(s0_aa_code_32 = 'B063') * s0_aa_dist_32 +
    (integer)(s0_aa_code_33 = 'B063') * s0_aa_dist_33 +
    (integer)(s0_aa_code_34 = 'B063') * s0_aa_dist_34 +
    (integer)(s0_aa_code_35 = 'B063') * s0_aa_dist_35 +
    (integer)(s0_aa_code_36 = 'B063') * s0_aa_dist_36 +
    (integer)(s0_aa_code_37 = 'B063') * s0_aa_dist_37 +
    (integer)(s0_aa_code_38 = 'B063') * s0_aa_dist_38 +
    (integer)(s0_aa_code_39 = 'B063') * s0_aa_dist_39 +
    (integer)(s0_aa_code_40 = 'B063') * s0_aa_dist_40 +
    (integer)(s0_aa_code_41 = 'B063') * s0_aa_dist_41 +
    (integer)(s0_aa_code_42 = 'B063') * s0_aa_dist_42 +
    (integer)(s0_aa_code_43 = 'B063') * s0_aa_dist_43 ) ;

s0_rcvaluep505 := __common__( (integer)(s0_aa_code_01 = 'P505') * s0_aa_dist_01 +
    (integer)(s0_aa_code_02 = 'P505') * s0_aa_dist_02 +
    (integer)(s0_aa_code_03 = 'P505') * s0_aa_dist_03 +
    (integer)(s0_aa_code_04 = 'P505') * s0_aa_dist_04 +
    (integer)(s0_aa_code_05 = 'P505') * s0_aa_dist_05 +
    (integer)(s0_aa_code_06 = 'P505') * s0_aa_dist_06 +
    (integer)(s0_aa_code_07 = 'P505') * s0_aa_dist_07 +
    (integer)(s0_aa_code_08 = 'P505') * s0_aa_dist_08 +
    (integer)(s0_aa_code_09 = 'P505') * s0_aa_dist_09 +
    (integer)(s0_aa_code_10 = 'P505') * s0_aa_dist_10 +
    (integer)(s0_aa_code_11 = 'P505') * s0_aa_dist_11 +
    (integer)(s0_aa_code_12 = 'P505') * s0_aa_dist_12 +
    (integer)(s0_aa_code_13 = 'P505') * s0_aa_dist_13 +
    (integer)(s0_aa_code_14 = 'P505') * s0_aa_dist_14 +
    (integer)(s0_aa_code_15 = 'P505') * s0_aa_dist_15 +
    (integer)(s0_aa_code_16 = 'P505') * s0_aa_dist_16 +
    (integer)(s0_aa_code_17 = 'P505') * s0_aa_dist_17 +
    (integer)(s0_aa_code_18 = 'P505') * s0_aa_dist_18 +
    (integer)(s0_aa_code_19 = 'P505') * s0_aa_dist_19 +
    (integer)(s0_aa_code_20 = 'P505') * s0_aa_dist_20 +
    (integer)(s0_aa_code_21 = 'P505') * s0_aa_dist_21 +
    (integer)(s0_aa_code_22 = 'P505') * s0_aa_dist_22 +
    (integer)(s0_aa_code_23 = 'P505') * s0_aa_dist_23 +
    (integer)(s0_aa_code_24 = 'P505') * s0_aa_dist_24 +
    (integer)(s0_aa_code_25 = 'P505') * s0_aa_dist_25 +
    (integer)(s0_aa_code_26 = 'P505') * s0_aa_dist_26 +
    (integer)(s0_aa_code_27 = 'P505') * s0_aa_dist_27 +
    (integer)(s0_aa_code_28 = 'P505') * s0_aa_dist_28 +
    (integer)(s0_aa_code_29 = 'P505') * s0_aa_dist_29 +
    (integer)(s0_aa_code_30 = 'P505') * s0_aa_dist_30 +
    (integer)(s0_aa_code_31 = 'P505') * s0_aa_dist_31 +
    (integer)(s0_aa_code_32 = 'P505') * s0_aa_dist_32 +
    (integer)(s0_aa_code_33 = 'P505') * s0_aa_dist_33 +
    (integer)(s0_aa_code_34 = 'P505') * s0_aa_dist_34 +
    (integer)(s0_aa_code_35 = 'P505') * s0_aa_dist_35 +
    (integer)(s0_aa_code_36 = 'P505') * s0_aa_dist_36 +
    (integer)(s0_aa_code_37 = 'P505') * s0_aa_dist_37 +
    (integer)(s0_aa_code_38 = 'P505') * s0_aa_dist_38 +
    (integer)(s0_aa_code_39 = 'P505') * s0_aa_dist_39 +
    (integer)(s0_aa_code_40 = 'P505') * s0_aa_dist_40 +
    (integer)(s0_aa_code_41 = 'P505') * s0_aa_dist_41 +
    (integer)(s0_aa_code_42 = 'P505') * s0_aa_dist_42 +
    (integer)(s0_aa_code_43 = 'P505') * s0_aa_dist_43 ) ;

s0_rcvalueb076 := __common__( (integer)(s0_aa_code_01 = 'B076') * s0_aa_dist_01 +
    (integer)(s0_aa_code_02 = 'B076') * s0_aa_dist_02 +
    (integer)(s0_aa_code_03 = 'B076') * s0_aa_dist_03 +
    (integer)(s0_aa_code_04 = 'B076') * s0_aa_dist_04 +
    (integer)(s0_aa_code_05 = 'B076') * s0_aa_dist_05 +
    (integer)(s0_aa_code_06 = 'B076') * s0_aa_dist_06 +
    (integer)(s0_aa_code_07 = 'B076') * s0_aa_dist_07 +
    (integer)(s0_aa_code_08 = 'B076') * s0_aa_dist_08 +
    (integer)(s0_aa_code_09 = 'B076') * s0_aa_dist_09 +
    (integer)(s0_aa_code_10 = 'B076') * s0_aa_dist_10 +
    (integer)(s0_aa_code_11 = 'B076') * s0_aa_dist_11 +
    (integer)(s0_aa_code_12 = 'B076') * s0_aa_dist_12 +
    (integer)(s0_aa_code_13 = 'B076') * s0_aa_dist_13 +
    (integer)(s0_aa_code_14 = 'B076') * s0_aa_dist_14 +
    (integer)(s0_aa_code_15 = 'B076') * s0_aa_dist_15 +
    (integer)(s0_aa_code_16 = 'B076') * s0_aa_dist_16 +
    (integer)(s0_aa_code_17 = 'B076') * s0_aa_dist_17 +
    (integer)(s0_aa_code_18 = 'B076') * s0_aa_dist_18 +
    (integer)(s0_aa_code_19 = 'B076') * s0_aa_dist_19 +
    (integer)(s0_aa_code_20 = 'B076') * s0_aa_dist_20 +
    (integer)(s0_aa_code_21 = 'B076') * s0_aa_dist_21 +
    (integer)(s0_aa_code_22 = 'B076') * s0_aa_dist_22 +
    (integer)(s0_aa_code_23 = 'B076') * s0_aa_dist_23 +
    (integer)(s0_aa_code_24 = 'B076') * s0_aa_dist_24 +
    (integer)(s0_aa_code_25 = 'B076') * s0_aa_dist_25 +
    (integer)(s0_aa_code_26 = 'B076') * s0_aa_dist_26 +
    (integer)(s0_aa_code_27 = 'B076') * s0_aa_dist_27 +
    (integer)(s0_aa_code_28 = 'B076') * s0_aa_dist_28 +
    (integer)(s0_aa_code_29 = 'B076') * s0_aa_dist_29 +
    (integer)(s0_aa_code_30 = 'B076') * s0_aa_dist_30 +
    (integer)(s0_aa_code_31 = 'B076') * s0_aa_dist_31 +
    (integer)(s0_aa_code_32 = 'B076') * s0_aa_dist_32 +
    (integer)(s0_aa_code_33 = 'B076') * s0_aa_dist_33 +
    (integer)(s0_aa_code_34 = 'B076') * s0_aa_dist_34 +
    (integer)(s0_aa_code_35 = 'B076') * s0_aa_dist_35 +
    (integer)(s0_aa_code_36 = 'B076') * s0_aa_dist_36 +
    (integer)(s0_aa_code_37 = 'B076') * s0_aa_dist_37 +
    (integer)(s0_aa_code_38 = 'B076') * s0_aa_dist_38 +
    (integer)(s0_aa_code_39 = 'B076') * s0_aa_dist_39 +
    (integer)(s0_aa_code_40 = 'B076') * s0_aa_dist_40 +
    (integer)(s0_aa_code_41 = 'B076') * s0_aa_dist_41 +
    (integer)(s0_aa_code_42 = 'B076') * s0_aa_dist_42 +
    (integer)(s0_aa_code_43 = 'B076') * s0_aa_dist_43 ) ;

s0_rcvaluep510 := __common__( (integer)(s0_aa_code_01 = 'P510') * s0_aa_dist_01 +
    (integer)(s0_aa_code_02 = 'P510') * s0_aa_dist_02 +
    (integer)(s0_aa_code_03 = 'P510') * s0_aa_dist_03 +
    (integer)(s0_aa_code_04 = 'P510') * s0_aa_dist_04 +
    (integer)(s0_aa_code_05 = 'P510') * s0_aa_dist_05 +
    (integer)(s0_aa_code_06 = 'P510') * s0_aa_dist_06 +
    (integer)(s0_aa_code_07 = 'P510') * s0_aa_dist_07 +
    (integer)(s0_aa_code_08 = 'P510') * s0_aa_dist_08 +
    (integer)(s0_aa_code_09 = 'P510') * s0_aa_dist_09 +
    (integer)(s0_aa_code_10 = 'P510') * s0_aa_dist_10 +
    (integer)(s0_aa_code_11 = 'P510') * s0_aa_dist_11 +
    (integer)(s0_aa_code_12 = 'P510') * s0_aa_dist_12 +
    (integer)(s0_aa_code_13 = 'P510') * s0_aa_dist_13 +
    (integer)(s0_aa_code_14 = 'P510') * s0_aa_dist_14 +
    (integer)(s0_aa_code_15 = 'P510') * s0_aa_dist_15 +
    (integer)(s0_aa_code_16 = 'P510') * s0_aa_dist_16 +
    (integer)(s0_aa_code_17 = 'P510') * s0_aa_dist_17 +
    (integer)(s0_aa_code_18 = 'P510') * s0_aa_dist_18 +
    (integer)(s0_aa_code_19 = 'P510') * s0_aa_dist_19 +
    (integer)(s0_aa_code_20 = 'P510') * s0_aa_dist_20 +
    (integer)(s0_aa_code_21 = 'P510') * s0_aa_dist_21 +
    (integer)(s0_aa_code_22 = 'P510') * s0_aa_dist_22 +
    (integer)(s0_aa_code_23 = 'P510') * s0_aa_dist_23 +
    (integer)(s0_aa_code_24 = 'P510') * s0_aa_dist_24 +
    (integer)(s0_aa_code_25 = 'P510') * s0_aa_dist_25 +
    (integer)(s0_aa_code_26 = 'P510') * s0_aa_dist_26 +
    (integer)(s0_aa_code_27 = 'P510') * s0_aa_dist_27 +
    (integer)(s0_aa_code_28 = 'P510') * s0_aa_dist_28 +
    (integer)(s0_aa_code_29 = 'P510') * s0_aa_dist_29 +
    (integer)(s0_aa_code_30 = 'P510') * s0_aa_dist_30 +
    (integer)(s0_aa_code_31 = 'P510') * s0_aa_dist_31 +
    (integer)(s0_aa_code_32 = 'P510') * s0_aa_dist_32 +
    (integer)(s0_aa_code_33 = 'P510') * s0_aa_dist_33 +
    (integer)(s0_aa_code_34 = 'P510') * s0_aa_dist_34 +
    (integer)(s0_aa_code_35 = 'P510') * s0_aa_dist_35 +
    (integer)(s0_aa_code_36 = 'P510') * s0_aa_dist_36 +
    (integer)(s0_aa_code_37 = 'P510') * s0_aa_dist_37 +
    (integer)(s0_aa_code_38 = 'P510') * s0_aa_dist_38 +
    (integer)(s0_aa_code_39 = 'P510') * s0_aa_dist_39 +
    (integer)(s0_aa_code_40 = 'P510') * s0_aa_dist_40 +
    (integer)(s0_aa_code_41 = 'P510') * s0_aa_dist_41 +
    (integer)(s0_aa_code_42 = 'P510') * s0_aa_dist_42 +
    (integer)(s0_aa_code_43 = 'P510') * s0_aa_dist_43 ) ;

s0_rcvaluep567 := __common__( (integer)(s0_aa_code_01 = 'P567') * s0_aa_dist_01 +
    (integer)(s0_aa_code_02 = 'P567') * s0_aa_dist_02 +
    (integer)(s0_aa_code_03 = 'P567') * s0_aa_dist_03 +
    (integer)(s0_aa_code_04 = 'P567') * s0_aa_dist_04 +
    (integer)(s0_aa_code_05 = 'P567') * s0_aa_dist_05 +
    (integer)(s0_aa_code_06 = 'P567') * s0_aa_dist_06 +
    (integer)(s0_aa_code_07 = 'P567') * s0_aa_dist_07 +
    (integer)(s0_aa_code_08 = 'P567') * s0_aa_dist_08 +
    (integer)(s0_aa_code_09 = 'P567') * s0_aa_dist_09 +
    (integer)(s0_aa_code_10 = 'P567') * s0_aa_dist_10 +
    (integer)(s0_aa_code_11 = 'P567') * s0_aa_dist_11 +
    (integer)(s0_aa_code_12 = 'P567') * s0_aa_dist_12 +
    (integer)(s0_aa_code_13 = 'P567') * s0_aa_dist_13 +
    (integer)(s0_aa_code_14 = 'P567') * s0_aa_dist_14 +
    (integer)(s0_aa_code_15 = 'P567') * s0_aa_dist_15 +
    (integer)(s0_aa_code_16 = 'P567') * s0_aa_dist_16 +
    (integer)(s0_aa_code_17 = 'P567') * s0_aa_dist_17 +
    (integer)(s0_aa_code_18 = 'P567') * s0_aa_dist_18 +
    (integer)(s0_aa_code_19 = 'P567') * s0_aa_dist_19 +
    (integer)(s0_aa_code_20 = 'P567') * s0_aa_dist_20 +
    (integer)(s0_aa_code_21 = 'P567') * s0_aa_dist_21 +
    (integer)(s0_aa_code_22 = 'P567') * s0_aa_dist_22 +
    (integer)(s0_aa_code_23 = 'P567') * s0_aa_dist_23 +
    (integer)(s0_aa_code_24 = 'P567') * s0_aa_dist_24 +
    (integer)(s0_aa_code_25 = 'P567') * s0_aa_dist_25 +
    (integer)(s0_aa_code_26 = 'P567') * s0_aa_dist_26 +
    (integer)(s0_aa_code_27 = 'P567') * s0_aa_dist_27 +
    (integer)(s0_aa_code_28 = 'P567') * s0_aa_dist_28 +
    (integer)(s0_aa_code_29 = 'P567') * s0_aa_dist_29 +
    (integer)(s0_aa_code_30 = 'P567') * s0_aa_dist_30 +
    (integer)(s0_aa_code_31 = 'P567') * s0_aa_dist_31 +
    (integer)(s0_aa_code_32 = 'P567') * s0_aa_dist_32 +
    (integer)(s0_aa_code_33 = 'P567') * s0_aa_dist_33 +
    (integer)(s0_aa_code_34 = 'P567') * s0_aa_dist_34 +
    (integer)(s0_aa_code_35 = 'P567') * s0_aa_dist_35 +
    (integer)(s0_aa_code_36 = 'P567') * s0_aa_dist_36 +
    (integer)(s0_aa_code_37 = 'P567') * s0_aa_dist_37 +
    (integer)(s0_aa_code_38 = 'P567') * s0_aa_dist_38 +
    (integer)(s0_aa_code_39 = 'P567') * s0_aa_dist_39 +
    (integer)(s0_aa_code_40 = 'P567') * s0_aa_dist_40 +
    (integer)(s0_aa_code_41 = 'P567') * s0_aa_dist_41 +
    (integer)(s0_aa_code_42 = 'P567') * s0_aa_dist_42 +
    (integer)(s0_aa_code_43 = 'P567') * s0_aa_dist_43 ) ;

s0_rcvaluep566 := __common__( (integer)(s0_aa_code_01 = 'P566') * s0_aa_dist_01 +
    (integer)(s0_aa_code_02 = 'P566') * s0_aa_dist_02 +
    (integer)(s0_aa_code_03 = 'P566') * s0_aa_dist_03 +
    (integer)(s0_aa_code_04 = 'P566') * s0_aa_dist_04 +
    (integer)(s0_aa_code_05 = 'P566') * s0_aa_dist_05 +
    (integer)(s0_aa_code_06 = 'P566') * s0_aa_dist_06 +
    (integer)(s0_aa_code_07 = 'P566') * s0_aa_dist_07 +
    (integer)(s0_aa_code_08 = 'P566') * s0_aa_dist_08 +
    (integer)(s0_aa_code_09 = 'P566') * s0_aa_dist_09 +
    (integer)(s0_aa_code_10 = 'P566') * s0_aa_dist_10 +
    (integer)(s0_aa_code_11 = 'P566') * s0_aa_dist_11 +
    (integer)(s0_aa_code_12 = 'P566') * s0_aa_dist_12 +
    (integer)(s0_aa_code_13 = 'P566') * s0_aa_dist_13 +
    (integer)(s0_aa_code_14 = 'P566') * s0_aa_dist_14 +
    (integer)(s0_aa_code_15 = 'P566') * s0_aa_dist_15 +
    (integer)(s0_aa_code_16 = 'P566') * s0_aa_dist_16 +
    (integer)(s0_aa_code_17 = 'P566') * s0_aa_dist_17 +
    (integer)(s0_aa_code_18 = 'P566') * s0_aa_dist_18 +
    (integer)(s0_aa_code_19 = 'P566') * s0_aa_dist_19 +
    (integer)(s0_aa_code_20 = 'P566') * s0_aa_dist_20 +
    (integer)(s0_aa_code_21 = 'P566') * s0_aa_dist_21 +
    (integer)(s0_aa_code_22 = 'P566') * s0_aa_dist_22 +
    (integer)(s0_aa_code_23 = 'P566') * s0_aa_dist_23 +
    (integer)(s0_aa_code_24 = 'P566') * s0_aa_dist_24 +
    (integer)(s0_aa_code_25 = 'P566') * s0_aa_dist_25 +
    (integer)(s0_aa_code_26 = 'P566') * s0_aa_dist_26 +
    (integer)(s0_aa_code_27 = 'P566') * s0_aa_dist_27 +
    (integer)(s0_aa_code_28 = 'P566') * s0_aa_dist_28 +
    (integer)(s0_aa_code_29 = 'P566') * s0_aa_dist_29 +
    (integer)(s0_aa_code_30 = 'P566') * s0_aa_dist_30 +
    (integer)(s0_aa_code_31 = 'P566') * s0_aa_dist_31 +
    (integer)(s0_aa_code_32 = 'P566') * s0_aa_dist_32 +
    (integer)(s0_aa_code_33 = 'P566') * s0_aa_dist_33 +
    (integer)(s0_aa_code_34 = 'P566') * s0_aa_dist_34 +
    (integer)(s0_aa_code_35 = 'P566') * s0_aa_dist_35 +
    (integer)(s0_aa_code_36 = 'P566') * s0_aa_dist_36 +
    (integer)(s0_aa_code_37 = 'P566') * s0_aa_dist_37 +
    (integer)(s0_aa_code_38 = 'P566') * s0_aa_dist_38 +
    (integer)(s0_aa_code_39 = 'P566') * s0_aa_dist_39 +
    (integer)(s0_aa_code_40 = 'P566') * s0_aa_dist_40 +
    (integer)(s0_aa_code_41 = 'P566') * s0_aa_dist_41 +
    (integer)(s0_aa_code_42 = 'P566') * s0_aa_dist_42 +
    (integer)(s0_aa_code_43 = 'P566') * s0_aa_dist_43 ) ;

s0_rcvaluep565 := __common__( (integer)(s0_aa_code_01 = 'P565') * s0_aa_dist_01 +
    (integer)(s0_aa_code_02 = 'P565') * s0_aa_dist_02 +
    (integer)(s0_aa_code_03 = 'P565') * s0_aa_dist_03 +
    (integer)(s0_aa_code_04 = 'P565') * s0_aa_dist_04 +
    (integer)(s0_aa_code_05 = 'P565') * s0_aa_dist_05 +
    (integer)(s0_aa_code_06 = 'P565') * s0_aa_dist_06 +
    (integer)(s0_aa_code_07 = 'P565') * s0_aa_dist_07 +
    (integer)(s0_aa_code_08 = 'P565') * s0_aa_dist_08 +
    (integer)(s0_aa_code_09 = 'P565') * s0_aa_dist_09 +
    (integer)(s0_aa_code_10 = 'P565') * s0_aa_dist_10 +
    (integer)(s0_aa_code_11 = 'P565') * s0_aa_dist_11 +
    (integer)(s0_aa_code_12 = 'P565') * s0_aa_dist_12 +
    (integer)(s0_aa_code_13 = 'P565') * s0_aa_dist_13 +
    (integer)(s0_aa_code_14 = 'P565') * s0_aa_dist_14 +
    (integer)(s0_aa_code_15 = 'P565') * s0_aa_dist_15 +
    (integer)(s0_aa_code_16 = 'P565') * s0_aa_dist_16 +
    (integer)(s0_aa_code_17 = 'P565') * s0_aa_dist_17 +
    (integer)(s0_aa_code_18 = 'P565') * s0_aa_dist_18 +
    (integer)(s0_aa_code_19 = 'P565') * s0_aa_dist_19 +
    (integer)(s0_aa_code_20 = 'P565') * s0_aa_dist_20 +
    (integer)(s0_aa_code_21 = 'P565') * s0_aa_dist_21 +
    (integer)(s0_aa_code_22 = 'P565') * s0_aa_dist_22 +
    (integer)(s0_aa_code_23 = 'P565') * s0_aa_dist_23 +
    (integer)(s0_aa_code_24 = 'P565') * s0_aa_dist_24 +
    (integer)(s0_aa_code_25 = 'P565') * s0_aa_dist_25 +
    (integer)(s0_aa_code_26 = 'P565') * s0_aa_dist_26 +
    (integer)(s0_aa_code_27 = 'P565') * s0_aa_dist_27 +
    (integer)(s0_aa_code_28 = 'P565') * s0_aa_dist_28 +
    (integer)(s0_aa_code_29 = 'P565') * s0_aa_dist_29 +
    (integer)(s0_aa_code_30 = 'P565') * s0_aa_dist_30 +
    (integer)(s0_aa_code_31 = 'P565') * s0_aa_dist_31 +
    (integer)(s0_aa_code_32 = 'P565') * s0_aa_dist_32 +
    (integer)(s0_aa_code_33 = 'P565') * s0_aa_dist_33 +
    (integer)(s0_aa_code_34 = 'P565') * s0_aa_dist_34 +
    (integer)(s0_aa_code_35 = 'P565') * s0_aa_dist_35 +
    (integer)(s0_aa_code_36 = 'P565') * s0_aa_dist_36 +
    (integer)(s0_aa_code_37 = 'P565') * s0_aa_dist_37 +
    (integer)(s0_aa_code_38 = 'P565') * s0_aa_dist_38 +
    (integer)(s0_aa_code_39 = 'P565') * s0_aa_dist_39 +
    (integer)(s0_aa_code_40 = 'P565') * s0_aa_dist_40 +
    (integer)(s0_aa_code_41 = 'P565') * s0_aa_dist_41 +
    (integer)(s0_aa_code_42 = 'P565') * s0_aa_dist_42 +
    (integer)(s0_aa_code_43 = 'P565') * s0_aa_dist_43 ) ;

s0_rcvaluep523 := __common__( (integer)(s0_aa_code_01 = 'P523') * s0_aa_dist_01 +
    (integer)(s0_aa_code_02 = 'P523') * s0_aa_dist_02 +
    (integer)(s0_aa_code_03 = 'P523') * s0_aa_dist_03 +
    (integer)(s0_aa_code_04 = 'P523') * s0_aa_dist_04 +
    (integer)(s0_aa_code_05 = 'P523') * s0_aa_dist_05 +
    (integer)(s0_aa_code_06 = 'P523') * s0_aa_dist_06 +
    (integer)(s0_aa_code_07 = 'P523') * s0_aa_dist_07 +
    (integer)(s0_aa_code_08 = 'P523') * s0_aa_dist_08 +
    (integer)(s0_aa_code_09 = 'P523') * s0_aa_dist_09 +
    (integer)(s0_aa_code_10 = 'P523') * s0_aa_dist_10 +
    (integer)(s0_aa_code_11 = 'P523') * s0_aa_dist_11 +
    (integer)(s0_aa_code_12 = 'P523') * s0_aa_dist_12 +
    (integer)(s0_aa_code_13 = 'P523') * s0_aa_dist_13 +
    (integer)(s0_aa_code_14 = 'P523') * s0_aa_dist_14 +
    (integer)(s0_aa_code_15 = 'P523') * s0_aa_dist_15 +
    (integer)(s0_aa_code_16 = 'P523') * s0_aa_dist_16 +
    (integer)(s0_aa_code_17 = 'P523') * s0_aa_dist_17 +
    (integer)(s0_aa_code_18 = 'P523') * s0_aa_dist_18 +
    (integer)(s0_aa_code_19 = 'P523') * s0_aa_dist_19 +
    (integer)(s0_aa_code_20 = 'P523') * s0_aa_dist_20 +
    (integer)(s0_aa_code_21 = 'P523') * s0_aa_dist_21 +
    (integer)(s0_aa_code_22 = 'P523') * s0_aa_dist_22 +
    (integer)(s0_aa_code_23 = 'P523') * s0_aa_dist_23 +
    (integer)(s0_aa_code_24 = 'P523') * s0_aa_dist_24 +
    (integer)(s0_aa_code_25 = 'P523') * s0_aa_dist_25 +
    (integer)(s0_aa_code_26 = 'P523') * s0_aa_dist_26 +
    (integer)(s0_aa_code_27 = 'P523') * s0_aa_dist_27 +
    (integer)(s0_aa_code_28 = 'P523') * s0_aa_dist_28 +
    (integer)(s0_aa_code_29 = 'P523') * s0_aa_dist_29 +
    (integer)(s0_aa_code_30 = 'P523') * s0_aa_dist_30 +
    (integer)(s0_aa_code_31 = 'P523') * s0_aa_dist_31 +
    (integer)(s0_aa_code_32 = 'P523') * s0_aa_dist_32 +
    (integer)(s0_aa_code_33 = 'P523') * s0_aa_dist_33 +
    (integer)(s0_aa_code_34 = 'P523') * s0_aa_dist_34 +
    (integer)(s0_aa_code_35 = 'P523') * s0_aa_dist_35 +
    (integer)(s0_aa_code_36 = 'P523') * s0_aa_dist_36 +
    (integer)(s0_aa_code_37 = 'P523') * s0_aa_dist_37 +
    (integer)(s0_aa_code_38 = 'P523') * s0_aa_dist_38 +
    (integer)(s0_aa_code_39 = 'P523') * s0_aa_dist_39 +
    (integer)(s0_aa_code_40 = 'P523') * s0_aa_dist_40 +
    (integer)(s0_aa_code_41 = 'P523') * s0_aa_dist_41 +
    (integer)(s0_aa_code_42 = 'P523') * s0_aa_dist_42 +
    (integer)(s0_aa_code_43 = 'P523') * s0_aa_dist_43 ) ;

s0_rcvalueb052 := __common__( (integer)(s0_aa_code_01 = 'B052') * s0_aa_dist_01 +
    (integer)(s0_aa_code_02 = 'B052') * s0_aa_dist_02 +
    (integer)(s0_aa_code_03 = 'B052') * s0_aa_dist_03 +
    (integer)(s0_aa_code_04 = 'B052') * s0_aa_dist_04 +
    (integer)(s0_aa_code_05 = 'B052') * s0_aa_dist_05 +
    (integer)(s0_aa_code_06 = 'B052') * s0_aa_dist_06 +
    (integer)(s0_aa_code_07 = 'B052') * s0_aa_dist_07 +
    (integer)(s0_aa_code_08 = 'B052') * s0_aa_dist_08 +
    (integer)(s0_aa_code_09 = 'B052') * s0_aa_dist_09 +
    (integer)(s0_aa_code_10 = 'B052') * s0_aa_dist_10 +
    (integer)(s0_aa_code_11 = 'B052') * s0_aa_dist_11 +
    (integer)(s0_aa_code_12 = 'B052') * s0_aa_dist_12 +
    (integer)(s0_aa_code_13 = 'B052') * s0_aa_dist_13 +
    (integer)(s0_aa_code_14 = 'B052') * s0_aa_dist_14 +
    (integer)(s0_aa_code_15 = 'B052') * s0_aa_dist_15 +
    (integer)(s0_aa_code_16 = 'B052') * s0_aa_dist_16 +
    (integer)(s0_aa_code_17 = 'B052') * s0_aa_dist_17 +
    (integer)(s0_aa_code_18 = 'B052') * s0_aa_dist_18 +
    (integer)(s0_aa_code_19 = 'B052') * s0_aa_dist_19 +
    (integer)(s0_aa_code_20 = 'B052') * s0_aa_dist_20 +
    (integer)(s0_aa_code_21 = 'B052') * s0_aa_dist_21 +
    (integer)(s0_aa_code_22 = 'B052') * s0_aa_dist_22 +
    (integer)(s0_aa_code_23 = 'B052') * s0_aa_dist_23 +
    (integer)(s0_aa_code_24 = 'B052') * s0_aa_dist_24 +
    (integer)(s0_aa_code_25 = 'B052') * s0_aa_dist_25 +
    (integer)(s0_aa_code_26 = 'B052') * s0_aa_dist_26 +
    (integer)(s0_aa_code_27 = 'B052') * s0_aa_dist_27 +
    (integer)(s0_aa_code_28 = 'B052') * s0_aa_dist_28 +
    (integer)(s0_aa_code_29 = 'B052') * s0_aa_dist_29 +
    (integer)(s0_aa_code_30 = 'B052') * s0_aa_dist_30 +
    (integer)(s0_aa_code_31 = 'B052') * s0_aa_dist_31 +
    (integer)(s0_aa_code_32 = 'B052') * s0_aa_dist_32 +
    (integer)(s0_aa_code_33 = 'B052') * s0_aa_dist_33 +
    (integer)(s0_aa_code_34 = 'B052') * s0_aa_dist_34 +
    (integer)(s0_aa_code_35 = 'B052') * s0_aa_dist_35 +
    (integer)(s0_aa_code_36 = 'B052') * s0_aa_dist_36 +
    (integer)(s0_aa_code_37 = 'B052') * s0_aa_dist_37 +
    (integer)(s0_aa_code_38 = 'B052') * s0_aa_dist_38 +
    (integer)(s0_aa_code_39 = 'B052') * s0_aa_dist_39 +
    (integer)(s0_aa_code_40 = 'B052') * s0_aa_dist_40 +
    (integer)(s0_aa_code_41 = 'B052') * s0_aa_dist_41 +
    (integer)(s0_aa_code_42 = 'B052') * s0_aa_dist_42 +
    (integer)(s0_aa_code_43 = 'B052') * s0_aa_dist_43 ) ;

s0_rcvalueb056 := __common__( (integer)(s0_aa_code_01 = 'B056') * s0_aa_dist_01 +
    (integer)(s0_aa_code_02 = 'B056') * s0_aa_dist_02 +
    (integer)(s0_aa_code_03 = 'B056') * s0_aa_dist_03 +
    (integer)(s0_aa_code_04 = 'B056') * s0_aa_dist_04 +
    (integer)(s0_aa_code_05 = 'B056') * s0_aa_dist_05 +
    (integer)(s0_aa_code_06 = 'B056') * s0_aa_dist_06 +
    (integer)(s0_aa_code_07 = 'B056') * s0_aa_dist_07 +
    (integer)(s0_aa_code_08 = 'B056') * s0_aa_dist_08 +
    (integer)(s0_aa_code_09 = 'B056') * s0_aa_dist_09 +
    (integer)(s0_aa_code_10 = 'B056') * s0_aa_dist_10 +
    (integer)(s0_aa_code_11 = 'B056') * s0_aa_dist_11 +
    (integer)(s0_aa_code_12 = 'B056') * s0_aa_dist_12 +
    (integer)(s0_aa_code_13 = 'B056') * s0_aa_dist_13 +
    (integer)(s0_aa_code_14 = 'B056') * s0_aa_dist_14 +
    (integer)(s0_aa_code_15 = 'B056') * s0_aa_dist_15 +
    (integer)(s0_aa_code_16 = 'B056') * s0_aa_dist_16 +
    (integer)(s0_aa_code_17 = 'B056') * s0_aa_dist_17 +
    (integer)(s0_aa_code_18 = 'B056') * s0_aa_dist_18 +
    (integer)(s0_aa_code_19 = 'B056') * s0_aa_dist_19 +
    (integer)(s0_aa_code_20 = 'B056') * s0_aa_dist_20 +
    (integer)(s0_aa_code_21 = 'B056') * s0_aa_dist_21 +
    (integer)(s0_aa_code_22 = 'B056') * s0_aa_dist_22 +
    (integer)(s0_aa_code_23 = 'B056') * s0_aa_dist_23 +
    (integer)(s0_aa_code_24 = 'B056') * s0_aa_dist_24 +
    (integer)(s0_aa_code_25 = 'B056') * s0_aa_dist_25 +
    (integer)(s0_aa_code_26 = 'B056') * s0_aa_dist_26 +
    (integer)(s0_aa_code_27 = 'B056') * s0_aa_dist_27 +
    (integer)(s0_aa_code_28 = 'B056') * s0_aa_dist_28 +
    (integer)(s0_aa_code_29 = 'B056') * s0_aa_dist_29 +
    (integer)(s0_aa_code_30 = 'B056') * s0_aa_dist_30 +
    (integer)(s0_aa_code_31 = 'B056') * s0_aa_dist_31 +
    (integer)(s0_aa_code_32 = 'B056') * s0_aa_dist_32 +
    (integer)(s0_aa_code_33 = 'B056') * s0_aa_dist_33 +
    (integer)(s0_aa_code_34 = 'B056') * s0_aa_dist_34 +
    (integer)(s0_aa_code_35 = 'B056') * s0_aa_dist_35 +
    (integer)(s0_aa_code_36 = 'B056') * s0_aa_dist_36 +
    (integer)(s0_aa_code_37 = 'B056') * s0_aa_dist_37 +
    (integer)(s0_aa_code_38 = 'B056') * s0_aa_dist_38 +
    (integer)(s0_aa_code_39 = 'B056') * s0_aa_dist_39 +
    (integer)(s0_aa_code_40 = 'B056') * s0_aa_dist_40 +
    (integer)(s0_aa_code_41 = 'B056') * s0_aa_dist_41 +
    (integer)(s0_aa_code_42 = 'B056') * s0_aa_dist_42 +
    (integer)(s0_aa_code_43 = 'B056') * s0_aa_dist_43 ) ;

s0_rcvalueb059 := __common__( (integer)(s0_aa_code_01 = 'B059') * s0_aa_dist_01 +
    (integer)(s0_aa_code_02 = 'B059') * s0_aa_dist_02 +
    (integer)(s0_aa_code_03 = 'B059') * s0_aa_dist_03 +
    (integer)(s0_aa_code_04 = 'B059') * s0_aa_dist_04 +
    (integer)(s0_aa_code_05 = 'B059') * s0_aa_dist_05 +
    (integer)(s0_aa_code_06 = 'B059') * s0_aa_dist_06 +
    (integer)(s0_aa_code_07 = 'B059') * s0_aa_dist_07 +
    (integer)(s0_aa_code_08 = 'B059') * s0_aa_dist_08 +
    (integer)(s0_aa_code_09 = 'B059') * s0_aa_dist_09 +
    (integer)(s0_aa_code_10 = 'B059') * s0_aa_dist_10 +
    (integer)(s0_aa_code_11 = 'B059') * s0_aa_dist_11 +
    (integer)(s0_aa_code_12 = 'B059') * s0_aa_dist_12 +
    (integer)(s0_aa_code_13 = 'B059') * s0_aa_dist_13 +
    (integer)(s0_aa_code_14 = 'B059') * s0_aa_dist_14 +
    (integer)(s0_aa_code_15 = 'B059') * s0_aa_dist_15 +
    (integer)(s0_aa_code_16 = 'B059') * s0_aa_dist_16 +
    (integer)(s0_aa_code_17 = 'B059') * s0_aa_dist_17 +
    (integer)(s0_aa_code_18 = 'B059') * s0_aa_dist_18 +
    (integer)(s0_aa_code_19 = 'B059') * s0_aa_dist_19 +
    (integer)(s0_aa_code_20 = 'B059') * s0_aa_dist_20 +
    (integer)(s0_aa_code_21 = 'B059') * s0_aa_dist_21 +
    (integer)(s0_aa_code_22 = 'B059') * s0_aa_dist_22 +
    (integer)(s0_aa_code_23 = 'B059') * s0_aa_dist_23 +
    (integer)(s0_aa_code_24 = 'B059') * s0_aa_dist_24 +
    (integer)(s0_aa_code_25 = 'B059') * s0_aa_dist_25 +
    (integer)(s0_aa_code_26 = 'B059') * s0_aa_dist_26 +
    (integer)(s0_aa_code_27 = 'B059') * s0_aa_dist_27 +
    (integer)(s0_aa_code_28 = 'B059') * s0_aa_dist_28 +
    (integer)(s0_aa_code_29 = 'B059') * s0_aa_dist_29 +
    (integer)(s0_aa_code_30 = 'B059') * s0_aa_dist_30 +
    (integer)(s0_aa_code_31 = 'B059') * s0_aa_dist_31 +
    (integer)(s0_aa_code_32 = 'B059') * s0_aa_dist_32 +
    (integer)(s0_aa_code_33 = 'B059') * s0_aa_dist_33 +
    (integer)(s0_aa_code_34 = 'B059') * s0_aa_dist_34 +
    (integer)(s0_aa_code_35 = 'B059') * s0_aa_dist_35 +
    (integer)(s0_aa_code_36 = 'B059') * s0_aa_dist_36 +
    (integer)(s0_aa_code_37 = 'B059') * s0_aa_dist_37 +
    (integer)(s0_aa_code_38 = 'B059') * s0_aa_dist_38 +
    (integer)(s0_aa_code_39 = 'B059') * s0_aa_dist_39 +
    (integer)(s0_aa_code_40 = 'B059') * s0_aa_dist_40 +
    (integer)(s0_aa_code_41 = 'B059') * s0_aa_dist_41 +
    (integer)(s0_aa_code_42 = 'B059') * s0_aa_dist_42 +
    (integer)(s0_aa_code_43 = 'B059') * s0_aa_dist_43 ) ;

s0_lgt := __common__( -3.95711111699048 +
    s0_v01_w +
    s0_v02_w +
    s0_v03_w +
    s0_v04_w +
    s0_v05_w +
    s0_v06_w +
    s0_v07_w +
    s0_v08_w +
    s0_v09_w +
    s0_v10_w +
    s0_v11_w +
    s0_v12_w +
    s0_v13_w +
    s0_v14_w +
    s0_v15_w +
    s0_v16_w +
    s0_v17_w +
    s0_v18_w +
    s0_v19_w +
    s0_v20_w +
    s0_v21_w +
    s0_v22_w +
    s0_v23_w +
    s0_v24_w +
    s0_v25_w +
    s0_v26_w +
    s0_v27_w +
    s0_v28_w +
    s0_v29_w +
    s0_v30_w +
    s0_v31_w +
    s0_v32_w +
    s0_v33_w +
    s0_v34_w +
    s0_v35_w +
    s0_v36_w +
    s0_v37_w +
    s0_v38_w +
    s0_v39_w +
    s0_v40_w +
    s0_v41_w +
    s0_v42_w +
    s0_v43_w ) ;

s1_v01_w := __common__( map(
    rv_a46_curr_avm_autoval = NULL      => 0,
    rv_a46_curr_avm_autoval = -1        => 0,
    rv_a46_curr_avm_autoval <= 0        => 0.0662218181528626,
    rv_a46_curr_avm_autoval <= 43814.8  => 0.494479491130913,
    rv_a46_curr_avm_autoval <= 123268   => 0.409654143956975,
    rv_a46_curr_avm_autoval <= 139058.5 => 0.131018509186709,
    rv_a46_curr_avm_autoval <= 249883   => -0.0355000439779728,
                                           -0.259310159463757) ) ;

s1_aa_code_01 := __common__( map(
    s1_v01_w = -0.259310159463757       => '      ',
    rv_a46_curr_avm_autoval = NULL      => 'P535',
    rv_a46_curr_avm_autoval = -1        => 'P509',
    rv_a46_curr_avm_autoval <= 0        => 'P509',
    rv_a46_curr_avm_autoval <= 43814.8  => 'P509',
    rv_a46_curr_avm_autoval <= 123268   => 'P509',
    rv_a46_curr_avm_autoval <= 139058.5 => 'P509',
    rv_a46_curr_avm_autoval <= 249883   => 'P509',
                                           'P509') ) ;

s1_aa_dist_01 := __common__( 0 - s1_v01_w ) ;

s1_v02_w := __common__( map(
    bv_bus_rep_source_profile = NULL           => 0,
    bv_bus_rep_source_profile = -1             => 0,
    bv_bus_rep_source_profile <= -3.3427138575 => -0.467658740793298,
    bv_bus_rep_source_profile <= -3.1966337385 => -0.227455782465991,
    bv_bus_rep_source_profile <= -2.6414790745 => -0.212541075941956,
    bv_bus_rep_source_profile <= -2.4403657365 => -0.0920968782411129,
    bv_bus_rep_source_profile <= -2.098319213  => 0.0394005356926672,
    bv_bus_rep_source_profile <= -2.0024716695 => 0.172697773804412,
    bv_bus_rep_source_profile <= -1.909663895  => 0.17744486770283,
    bv_bus_rep_source_profile <= -1.8534513105 => 0.193042523243922,
    bv_bus_rep_source_profile <= -1.274646112  => 0.275856090904245,
                                                  0.464902110391566) ) ;

s1_aa_code_02 := __common__( map(
    s1_v02_w = -0.467658740793298              => '      ',
    bv_bus_rep_source_profile = NULL           => 'P535',
    bv_bus_rep_source_profile = -1             => 'P515',
    bv_bus_rep_source_profile <= -3.3427138575 => 'P515',
    bv_bus_rep_source_profile <= -3.1966337385 => 'P515',
    bv_bus_rep_source_profile <= -2.6414790745 => 'P515',
    bv_bus_rep_source_profile <= -2.4403657365 => 'P515',
    bv_bus_rep_source_profile <= -2.098319213  => 'P515',
    bv_bus_rep_source_profile <= -2.0024716695 => 'P515',
    bv_bus_rep_source_profile <= -1.909663895  => 'P515',
    bv_bus_rep_source_profile <= -1.8534513105 => 'P515',
    bv_bus_rep_source_profile <= -1.274646112  => 'P515',
                                                  'P515') ) ;

s1_aa_dist_02 := __common__( 0 - s1_v02_w ) ;

s1_v03_w := __common__( map(
    bv_rep_only_source_profile = NULL           => 0,
    bv_rep_only_source_profile = -1             => 0,
    bv_rep_only_source_profile <= -3.3419543775 => -0.357314091370433,
    bv_rep_only_source_profile <= -3.0876947025 => -0.209343518653331,
    bv_rep_only_source_profile <= -2.6011619595 => -0.169293076099361,
    bv_rep_only_source_profile <= -2.575901082  => -0.139086200411833,
    bv_rep_only_source_profile <= -2.279210087  => -0.0361683525698684,
    bv_rep_only_source_profile <= -2.0877280905 => 0.0722597456902269,
    bv_rep_only_source_profile <= -1.8927867815 => 0.150189937627071,
    bv_rep_only_source_profile <= -1.5691132945 => 0.231191123228877,
    bv_rep_only_source_profile <= -1.238914958  => 0.255539826296189,
                                                   0.39168566546721) ) ;

s1_aa_code_03 := __common__( map(
    s1_v03_w = -0.357314091370433               => '      ',
    bv_rep_only_source_profile = NULL           => 'P535',
    bv_rep_only_source_profile = -1             => 'P515',
    bv_rep_only_source_profile <= -3.3419543775 => 'P515',
    bv_rep_only_source_profile <= -3.0876947025 => 'P515',
    bv_rep_only_source_profile <= -2.6011619595 => 'P515',
    bv_rep_only_source_profile <= -2.575901082  => 'P515',
    bv_rep_only_source_profile <= -2.279210087  => 'P515',
    bv_rep_only_source_profile <= -2.0877280905 => 'P515',
    bv_rep_only_source_profile <= -1.8927867815 => 'P515',
    bv_rep_only_source_profile <= -1.5691132945 => 'P515',
    bv_rep_only_source_profile <= -1.238914958  => 'P515',
                                                   'P515') ) ;

s1_aa_dist_03 := __common__( 0 - s1_v03_w ) ;

s1_v04_w := __common__( map(
    rv_i61_inq_collection_recency = NULL => 0,
    rv_i61_inq_collection_recency = -1   => 0,
    rv_i61_inq_collection_recency <= 0.5 => -0.121960674918155,
    rv_i61_inq_collection_recency <= 9   => 0.434602123636611,
    rv_i61_inq_collection_recency <= 18  => 0.297663084920067,
    rv_i61_inq_collection_recency <= 24  => 0.184796037313923,
                                            -0.121960674918155) ) ;

s1_aa_code_04 := __common__( map(
    s1_v04_w = -0.121960674918155        => '      ',
    rv_i61_inq_collection_recency = NULL => 'P535',
    rv_i61_inq_collection_recency = -1   => 'P540',
    rv_i61_inq_collection_recency <= 0.5 => 'P540',
    rv_i61_inq_collection_recency <= 9   => 'P540',
    rv_i61_inq_collection_recency <= 18  => 'P540',
    rv_i61_inq_collection_recency <= 24  => 'P540',
                                            'P540') ) ;

s1_aa_dist_04 := __common__( 0 - s1_v04_w ) ;

s1_v05_w := __common__( map(
    rv_d30_derog_count = NULL => 0,
    rv_d30_derog_count = -1   => 0,
    rv_d30_derog_count <= 0.5 => -0.0738995877998049,
    rv_d30_derog_count <= 1.5 => 0.0972775487319652,
    rv_d30_derog_count <= 4.5 => 0.181060252781531,
    rv_d30_derog_count <= 5.5 => 0.246166154457983,
    rv_d30_derog_count <= 7.5 => 0.381372229817378,
                                 0.535722899572138) ) ;

s1_aa_code_05 := __common__( map(
    s1_v05_w = -0.0738995877998049 => '      ',
    rv_d30_derog_count = NULL      => 'P535',
    rv_d30_derog_count = -1        => 'P526',
    rv_d30_derog_count <= 0.5      => 'P526',
    rv_d30_derog_count <= 1.5      => 'P526',
    rv_d30_derog_count <= 4.5      => 'P526',
    rv_d30_derog_count <= 5.5      => 'P526',
    rv_d30_derog_count <= 7.5      => 'P526',
                                      'P526') ) ;

s1_aa_dist_05 := __common__( 0 - s1_v05_w ) ;

s1_v06_w := __common__( map(
    rv_d34_attr_unrel_liens_recency = NULL => 0,
    rv_d34_attr_unrel_liens_recency = -1   => 0,
    rv_d34_attr_unrel_liens_recency <= 0.5 => -0.0596494267599805,
    rv_d34_attr_unrel_liens_recency <= 30  => 0.555630158934244,
    rv_d34_attr_unrel_liens_recency <= 48  => 0.436410245126093,
    rv_d34_attr_unrel_liens_recency <= 60  => 0.37310641375962,
                                              -0.0596494267599805) ) ;

s1_aa_code_06 := __common__( map(
    s1_v06_w = -0.0596494267599805         => '      ',
    rv_d34_attr_unrel_liens_recency = NULL => 'P535',
    rv_d34_attr_unrel_liens_recency = -1   => 'P526',
    rv_d34_attr_unrel_liens_recency <= 0.5 => 'P526',
    rv_d34_attr_unrel_liens_recency <= 30  => 'P526',
    rv_d34_attr_unrel_liens_recency <= 48  => 'P526',
    rv_d34_attr_unrel_liens_recency <= 60  => 'P526',
                                              'P526') ) ;

s1_aa_dist_06 := __common__( 0 - s1_v06_w ) ;

s1_v07_w := __common__( map(
    nf_fp_srchvelocityrisktype = NULL => 0,
    nf_fp_srchvelocityrisktype = -1   => 0,
    nf_fp_srchvelocityrisktype <= 3.5 => -0.0421793118394418,
    nf_fp_srchvelocityrisktype <= 5.5 => 0.18948465287554,
                                         0.472759699969382) ) ;

s1_aa_code_07 := __common__( map(
    s1_v07_w = -0.0421793118394418    => '      ',
    nf_fp_srchvelocityrisktype = NULL => 'P535',
    nf_fp_srchvelocityrisktype = -1   => 'P539',
    nf_fp_srchvelocityrisktype <= 3.5 => 'P539',
    nf_fp_srchvelocityrisktype <= 5.5 => 'P539',
                                         'P539') ) ;

s1_aa_dist_07 := __common__( 0 - s1_v07_w ) ;

s1_v08_w := __common__( map(
    nf_mos_inq_banko_cm_lseen = NULL  => 0,
    nf_mos_inq_banko_cm_lseen = -1    => -0.0270928806494992,
    nf_mos_inq_banko_cm_lseen <= 7    => 0.512695165939598,
    nf_mos_inq_banko_cm_lseen <= 10   => 0.396430290403858,
    nf_mos_inq_banko_cm_lseen <= 49.8 => 0.31122306294174,
                                         -0.0270928806494992) ) ;

s1_aa_code_08 := __common__( map(
    s1_v08_w = -0.0270928806494992    => '      ',
    nf_mos_inq_banko_cm_lseen = NULL  => 'P535',
    nf_mos_inq_banko_cm_lseen = -1    => 'P540',
    nf_mos_inq_banko_cm_lseen <= 7    => 'P540',
    nf_mos_inq_banko_cm_lseen <= 10   => 'P540',
    nf_mos_inq_banko_cm_lseen <= 49.8 => 'P540',
                                         'P540') ) ;

s1_aa_dist_08 := __common__( 0 - s1_v08_w ) ;

s1_v09_w := __common__( map(
    rv_a41_prop_owner = NULL => 0,
    rv_a41_prop_owner = -1   => 0,
    rv_a41_prop_owner <= 0.5 => 0.290797564115243,
                                -0.0340649880445184) ) ;

s1_aa_code_09 := __common__( map(
    s1_v09_w = -0.0340649880445184 => '      ',
    rv_a41_prop_owner = NULL       => 'P535',
    rv_a41_prop_owner = -1         => 'P502',
    rv_a41_prop_owner <= 0.5       => 'P502',
                                      'P502') ) ;

s1_aa_dist_09 := __common__( 0 - s1_v09_w ) ;

s1_v10_w := __common__( map(
    nf_fp_prevaddrageoldest = NULL   => 0,
    nf_fp_prevaddrageoldest = -1     => 0.0315624639137176,
    nf_fp_prevaddrageoldest <= 7.5   => 0.187167870524971,
    nf_fp_prevaddrageoldest <= 17.5  => 0.104790198820826,
    nf_fp_prevaddrageoldest <= 81.5  => 0.0560451180355595,
    nf_fp_prevaddrageoldest <= 94.5  => 0.0141524656761457,
    nf_fp_prevaddrageoldest <= 125.5 => -0.0180326257748619,
    nf_fp_prevaddrageoldest <= 195.5 => -0.0503686663258628,
    nf_fp_prevaddrageoldest <= 238.5 => -0.0698589503784016,
                                        -0.106919528615633) ) ;

s1_aa_code_10 := __common__( map(
    s1_v10_w = -0.106919528615633    => '      ',
    nf_fp_prevaddrageoldest = NULL   => 'P535',
    nf_fp_prevaddrageoldest = -1     => 'P567',
    nf_fp_prevaddrageoldest <= 7.5   => 'P567',
    nf_fp_prevaddrageoldest <= 17.5  => 'P567',
    nf_fp_prevaddrageoldest <= 81.5  => 'P567',
    nf_fp_prevaddrageoldest <= 94.5  => 'P567',
    nf_fp_prevaddrageoldest <= 125.5 => 'P567',
    nf_fp_prevaddrageoldest <= 195.5 => 'P567',
    nf_fp_prevaddrageoldest <= 238.5 => 'P567',
                                        'P567') ) ;

s1_aa_dist_10 := __common__( 0 - s1_v10_w ) ;

s1_v11_w := __common__( map(
    nf_fp_srchunvrfdssncount = NULL => 0,
    nf_fp_srchunvrfdssncount = -1   => 0,
    nf_fp_srchunvrfdssncount <= 0.5 => -0.0150914685024417,
                                       0.320063839227879) ) ;

s1_aa_code_11 := __common__( map(
    s1_v11_w = -0.0150914685024417  => '      ',
    nf_fp_srchunvrfdssncount = NULL => 'P535',
    nf_fp_srchunvrfdssncount = -1   => 'P539',
    nf_fp_srchunvrfdssncount <= 0.5 => 'P539',
                                       'P539') ) ;

s1_aa_dist_11 := __common__( 0 - s1_v11_w ) ;

s1_v12_w := __common__( map(
    rv_i60_inq_auto_count12 = NULL => 0,
    rv_i60_inq_auto_count12 = -1   => 0,
    rv_i60_inq_auto_count12 <= 0.5 => -0.016917071374486,
    rv_i60_inq_auto_count12 <= 2.5 => 0.15523458544694,
                                      0.388242474891784) ) ;

s1_aa_code_12 := __common__( map(
    s1_v12_w = -0.016917071374486  => '      ',
    rv_i60_inq_auto_count12 = NULL => 'P535',
    rv_i60_inq_auto_count12 = -1   => 'P539',
    rv_i60_inq_auto_count12 <= 0.5 => 'P539',
    rv_i60_inq_auto_count12 <= 2.5 => 'P539',
                                      'P539') ) ;

s1_aa_dist_12 := __common__( 0 - s1_v12_w ) ;

s1_v13_w := __common__( map(
    rv_d34_attr_liens_recency = NULL => 0,
    rv_d34_attr_liens_recency = -1   => 0,
    rv_d34_attr_liens_recency <= 0.5 => -0.0322555239970124,
    rv_d34_attr_liens_recency <= 30  => 0.246959818541904,
    rv_d34_attr_liens_recency <= 48  => 0.214561822458599,
    rv_d34_attr_liens_recency <= 60  => 0.171490702778492,
                                        -0.0322555239970124) ) ;

s1_aa_code_13 := __common__( map(
    s1_v13_w = -0.0322555239970124   => '      ',
    rv_d34_attr_liens_recency = NULL => 'P535',
    rv_d34_attr_liens_recency = -1   => 'P526',
    rv_d34_attr_liens_recency <= 0.5 => 'P526',
    rv_d34_attr_liens_recency <= 30  => 'P526',
    rv_d34_attr_liens_recency <= 48  => 'P526',
    rv_d34_attr_liens_recency <= 60  => 'P526',
                                        'P526') ) ;

s1_aa_dist_13 := __common__( 0 - s1_v13_w ) ;

s1_v14_w := __common__( map(
    nf_fp_sourcerisktype = NULL => 0,
    nf_fp_sourcerisktype = -1   => 0,
    nf_fp_sourcerisktype <= 5   => -0.0156948348486841,
    nf_fp_sourcerisktype <= 6   => 0.0236610298204858,
    nf_fp_sourcerisktype <= 7.5 => 0.223609896204516,
                                   0.330101073583405) ) ;

s1_aa_code_14 := __common__( map(
    s1_v14_w = -0.0156948348486841 => '      ',
    nf_fp_sourcerisktype = NULL    => 'P535',
    nf_fp_sourcerisktype = -1      => 'P515',
    nf_fp_sourcerisktype <= 5      => 'P515',
    nf_fp_sourcerisktype <= 6      => 'P515',
    nf_fp_sourcerisktype <= 7.5    => 'P515',
                                      'P515') ) ;

s1_aa_dist_14 := __common__( 0 - s1_v14_w ) ;

s1_v15_w := __common__( map(
    rv_i60_inq_comm_recency = NULL => 0,
    rv_i60_inq_comm_recency = -1   => 0,
    rv_i60_inq_comm_recency <= 0.5 => -0.0182134328771924,
    rv_i60_inq_comm_recency <= 12  => 0.342396608737328,
                                      -0.0182134328771924) ) ;

s1_aa_code_15 := __common__( map(
    s1_v15_w = -0.0182134328771924 => '      ',
    rv_i60_inq_comm_recency = NULL => 'P535',
    rv_i60_inq_comm_recency = -1   => 'P539',
    rv_i60_inq_comm_recency <= 0.5 => 'P539',
    rv_i60_inq_comm_recency <= 12  => 'P539',
                                      'P539') ) ;

s1_aa_dist_15 := __common__( 0 - s1_v15_w ) ;

s1_v16_w := __common__( map(
    rv_d32_attr_felonies_recency = NULL => 0,
    rv_d32_attr_felonies_recency = -1   => 0,
    rv_d32_attr_felonies_recency <= 0   => -0.00458551531924943,
                                           0.310374397834624) ) ;

s1_aa_code_16 := __common__( map(
    s1_v16_w = -0.00458551531924943     => '      ',
    rv_d32_attr_felonies_recency = NULL => 'P535',
    rv_d32_attr_felonies_recency = -1   => 'P526',
    rv_d32_attr_felonies_recency <= 0   => 'P526',
                                           'P526') ) ;

s1_aa_dist_16 := __common__( 0 - s1_v16_w ) ;

s1_v17_w := __common__( map(
    nf_fp_varrisktype = NULL => 0,
    nf_fp_varrisktype = -1   => 0.0659305311929053,
    nf_fp_varrisktype <= 1   => -0.0155876076306679,
    nf_fp_varrisktype <= 2.5 => 0.04678927804608,
    nf_fp_varrisktype <= 3.5 => 0.0550922792779533,
    nf_fp_varrisktype <= 4.5 => 0.0957801498998182,
                                0.124780608855422) ) ;

s1_aa_code_17 := __common__( map(
    s1_v17_w = -0.0155876076306679 => '      ',
    nf_fp_varrisktype = NULL       => 'P535',
    nf_fp_varrisktype = -1         => 'P535',
    nf_fp_varrisktype <= 1         => 'P566',
    nf_fp_varrisktype <= 2.5       => 'P566',
    nf_fp_varrisktype <= 3.5       => 'P566',
    nf_fp_varrisktype <= 4.5       => 'P566',
                                      'P566') ) ;

s1_aa_dist_17 := __common__( 0 - s1_v17_w ) ;

s1_v18_w := __common__( map(
    rv_d33_eviction_count = NULL => 0,
    rv_d33_eviction_count = -1   => 0,
    rv_d33_eviction_count <= 0.5 => -0.00515219927848869,
                                    0.231803129664979) ) ;

s1_aa_code_18 := __common__( map(
    s1_v18_w = -0.00515219927848869 => '      ',
    rv_d33_eviction_count = NULL    => 'P535',
    rv_d33_eviction_count = -1      => 'P526',
    rv_d33_eviction_count <= 0.5    => 'P526',
                                       'P526') ) ;

s1_aa_dist_18 := __common__( 0 - s1_v18_w ) ;

s1_v19_w := __common__( map(
    rv_i60_inq_auto_recency = NULL => 0,
    rv_i60_inq_auto_recency = -1   => 0,
    rv_i60_inq_auto_recency <= 0.5 => -0.0141383134139647,
    rv_i60_inq_auto_recency <= 4.5 => 0.107047139165997,
    rv_i60_inq_auto_recency <= 12  => 0.0664068559746673,
                                      -0.0141383134139647) ) ;

s1_aa_code_19 := __common__( map(
    s1_v19_w = -0.0141383134139647 => '      ',
    rv_i60_inq_auto_recency = NULL => 'P535',
    rv_i60_inq_auto_recency = -1   => 'P539',
    rv_i60_inq_auto_recency <= 0.5 => 'P539',
    rv_i60_inq_auto_recency <= 4.5 => 'P539',
    rv_i60_inq_auto_recency <= 12  => 'P539',
                                      'P539') ) ;

s1_aa_dist_19 := __common__( 0 - s1_v19_w ) ;

s1_v20_w := __common__( map(
    rv_i61_inq_collection_count12 = NULL => 0,
    rv_i61_inq_collection_count12 = -1   => 0,
    rv_i61_inq_collection_count12 <= 0.5 => -0.00679658901451645,
    rv_i61_inq_collection_count12 <= 2.5 => 0.0716072006477226,
                                            0.0913500072012444) ) ;

s1_aa_code_20 := __common__( map(
    s1_v20_w = -0.00679658901451645      => '      ',
    rv_i61_inq_collection_count12 = NULL => 'P535',
    rv_i61_inq_collection_count12 = -1   => 'P540',
    rv_i61_inq_collection_count12 <= 0.5 => 'P540',
    rv_i61_inq_collection_count12 <= 2.5 => 'P540',
                                            'P540') ) ;

s1_aa_dist_20 := __common__( 0 - s1_v20_w ) ;

s1_v21_w := __common__( map(
    rv_i60_inq_hiriskcred_recency = NULL => 0,
    rv_i60_inq_hiriskcred_recency = -1   => 0,
    rv_i60_inq_hiriskcred_recency <= 0.5 => -0.0057000899049818,
    rv_i60_inq_hiriskcred_recency <= 12  => 0.205442175657761,
                                            -0.0057000899049818) ) ;

s1_aa_code_21 := __common__( map(
    s1_v21_w = -0.0057000899049818       => '      ',
    rv_i60_inq_hiriskcred_recency = NULL => 'P535',
    rv_i60_inq_hiriskcred_recency = -1   => 'P539',
    rv_i60_inq_hiriskcred_recency <= 0.5 => 'P539',
    rv_i60_inq_hiriskcred_recency <= 12  => 'P539',
                                            'P539') ) ;

s1_aa_dist_21 := __common__( 0 - s1_v21_w ) ;

s1_v22_w := __common__( map(
    iv_curr_add_mortgage_type = ''                                                                   => 0,
    (iv_curr_add_mortgage_type in ['CONVENTIONAL'])                                                    => -0.020212895633126,
    (iv_curr_add_mortgage_type in ['GOVERNMENT', 'NON-TRADITIONAL', 'UNKNOWN', 'COMMERCIAL', 'OTHER']) => -0.00899345751036937,
    (iv_curr_add_mortgage_type in ['NO MORTGAGE'])                                                     => 0.0168024233107262,
                                                                                                          0) ) ;

s1_aa_code_22 := __common__( map(
    s1_v22_w = -0.020212895633126                                                                      => '      ',
    iv_curr_add_mortgage_type = ''                                                                   => 'P535',
    (iv_curr_add_mortgage_type in ['CONVENTIONAL'])                                                    => 'P510',
    (iv_curr_add_mortgage_type in ['GOVERNMENT', 'NON-TRADITIONAL', 'UNKNOWN', 'COMMERCIAL', 'OTHER']) => 'P510',
    (rv_a44_curr_add_naprop in [0, 1])                                                                 => 'P505',
    (iv_curr_add_mortgage_type in ['NO MORTGAGE'])                                                     => 'P513',
                                                                                                          'P510') ) ;

s1_aa_dist_22 := __common__( 0 - s1_v22_w ) ;

s1_v23_w := __common__( map(
    rv_c14_addrs_per_adl_c6 = NULL => 0,
    rv_c14_addrs_per_adl_c6 = -1   => 0,
    rv_c14_addrs_per_adl_c6 <= 0.5 => -0.00820103475323372,
    rv_c14_addrs_per_adl_c6 <= 1.5 => 0.0689324550421659,
                                      0.148210076831546) ) ;

s1_aa_code_23 := __common__( map(
    s1_v23_w = -0.00820103475323372 => '      ',
    rv_c14_addrs_per_adl_c6 = NULL  => 'P535',
    rv_c14_addrs_per_adl_c6 = -1    => 'P517',
    rv_c14_addrs_per_adl_c6 <= 0.5  => 'P517',
    rv_c14_addrs_per_adl_c6 <= 1.5  => 'P517',
                                       'P517') ) ;

s1_aa_dist_23 := __common__( 0 - s1_v23_w ) ;

s1_v24_w := __common__( map(
    nf_fp_srchunvrfdaddrcount = NULL => 0,
    nf_fp_srchunvrfdaddrcount = -1   => 0,
    nf_fp_srchunvrfdaddrcount <= 0.5 => -0.00226337453888191,
                                        0.0716419489787622) ) ;

s1_aa_code_24 := __common__( map(
    s1_v24_w = -0.00226337453888191  => '      ',
    nf_fp_srchunvrfdaddrcount = NULL => 'P535',
    nf_fp_srchunvrfdaddrcount = -1   => 'P539',
    nf_fp_srchunvrfdaddrcount <= 0.5 => 'P539',
                                        'P539') ) ;

s1_aa_dist_24 := __common__( 0 - s1_v24_w ) ;

s1_v25_w := __common__( map(
    rv_c12_num_nonderogs = NULL => 0,
    rv_c12_num_nonderogs = -1   => 0,
    rv_c12_num_nonderogs <= 1.5 => 0.0402371078365719,
                                   -0.00208812088436208) ) ;

s1_aa_code_25 := __common__( map(
    s1_v25_w = -0.00208812088436208 => '      ',
    rv_c12_num_nonderogs = NULL     => 'P535',
    rv_c12_num_nonderogs = -1       => 'P515',
    rv_c12_num_nonderogs <= 1.5     => 'P515',
                                       'P515') ) ;

s1_aa_dist_25 := __common__( 0 - s1_v25_w ) ;

s1_aa_code_26 := __common__( 'B067' ) ;

s1_aa_dist_26 := __common__( -999 ) ;

s1_rcvaluep509 := __common__( (integer)(s1_aa_code_01 = 'P509') * s1_aa_dist_01 +
    (integer)(s1_aa_code_02 = 'P509') * s1_aa_dist_02 +
    (integer)(s1_aa_code_03 = 'P509') * s1_aa_dist_03 +
    (integer)(s1_aa_code_04 = 'P509') * s1_aa_dist_04 +
    (integer)(s1_aa_code_05 = 'P509') * s1_aa_dist_05 +
    (integer)(s1_aa_code_06 = 'P509') * s1_aa_dist_06 +
    (integer)(s1_aa_code_07 = 'P509') * s1_aa_dist_07 +
    (integer)(s1_aa_code_08 = 'P509') * s1_aa_dist_08 +
    (integer)(s1_aa_code_09 = 'P509') * s1_aa_dist_09 +
    (integer)(s1_aa_code_10 = 'P509') * s1_aa_dist_10 +
    (integer)(s1_aa_code_11 = 'P509') * s1_aa_dist_11 +
    (integer)(s1_aa_code_12 = 'P509') * s1_aa_dist_12 +
    (integer)(s1_aa_code_13 = 'P509') * s1_aa_dist_13 +
    (integer)(s1_aa_code_14 = 'P509') * s1_aa_dist_14 +
    (integer)(s1_aa_code_15 = 'P509') * s1_aa_dist_15 +
    (integer)(s1_aa_code_16 = 'P509') * s1_aa_dist_16 +
    (integer)(s1_aa_code_17 = 'P509') * s1_aa_dist_17 +
    (integer)(s1_aa_code_18 = 'P509') * s1_aa_dist_18 +
    (integer)(s1_aa_code_19 = 'P509') * s1_aa_dist_19 +
    (integer)(s1_aa_code_20 = 'P509') * s1_aa_dist_20 +
    (integer)(s1_aa_code_21 = 'P509') * s1_aa_dist_21 +
    (integer)(s1_aa_code_22 = 'P509') * s1_aa_dist_22 +
    (integer)(s1_aa_code_23 = 'P509') * s1_aa_dist_23 +
    (integer)(s1_aa_code_24 = 'P509') * s1_aa_dist_24 +
    (integer)(s1_aa_code_25 = 'P509') * s1_aa_dist_25 +
    (integer)(s1_aa_code_26 = 'P509') * s1_aa_dist_26 ) ;

s1_rcvaluep502 := __common__( (integer)(s1_aa_code_01 = 'P502') * s1_aa_dist_01 +
    (integer)(s1_aa_code_02 = 'P502') * s1_aa_dist_02 +
    (integer)(s1_aa_code_03 = 'P502') * s1_aa_dist_03 +
    (integer)(s1_aa_code_04 = 'P502') * s1_aa_dist_04 +
    (integer)(s1_aa_code_05 = 'P502') * s1_aa_dist_05 +
    (integer)(s1_aa_code_06 = 'P502') * s1_aa_dist_06 +
    (integer)(s1_aa_code_07 = 'P502') * s1_aa_dist_07 +
    (integer)(s1_aa_code_08 = 'P502') * s1_aa_dist_08 +
    (integer)(s1_aa_code_09 = 'P502') * s1_aa_dist_09 +
    (integer)(s1_aa_code_10 = 'P502') * s1_aa_dist_10 +
    (integer)(s1_aa_code_11 = 'P502') * s1_aa_dist_11 +
    (integer)(s1_aa_code_12 = 'P502') * s1_aa_dist_12 +
    (integer)(s1_aa_code_13 = 'P502') * s1_aa_dist_13 +
    (integer)(s1_aa_code_14 = 'P502') * s1_aa_dist_14 +
    (integer)(s1_aa_code_15 = 'P502') * s1_aa_dist_15 +
    (integer)(s1_aa_code_16 = 'P502') * s1_aa_dist_16 +
    (integer)(s1_aa_code_17 = 'P502') * s1_aa_dist_17 +
    (integer)(s1_aa_code_18 = 'P502') * s1_aa_dist_18 +
    (integer)(s1_aa_code_19 = 'P502') * s1_aa_dist_19 +
    (integer)(s1_aa_code_20 = 'P502') * s1_aa_dist_20 +
    (integer)(s1_aa_code_21 = 'P502') * s1_aa_dist_21 +
    (integer)(s1_aa_code_22 = 'P502') * s1_aa_dist_22 +
    (integer)(s1_aa_code_23 = 'P502') * s1_aa_dist_23 +
    (integer)(s1_aa_code_24 = 'P502') * s1_aa_dist_24 +
    (integer)(s1_aa_code_25 = 'P502') * s1_aa_dist_25 +
    (integer)(s1_aa_code_26 = 'P502') * s1_aa_dist_26 ) ;

s1_rcvaluep535 := __common__( (integer)(s1_aa_code_01 = 'P535') * s1_aa_dist_01 +
    (integer)(s1_aa_code_02 = 'P535') * s1_aa_dist_02 +
    (integer)(s1_aa_code_03 = 'P535') * s1_aa_dist_03 +
    (integer)(s1_aa_code_04 = 'P535') * s1_aa_dist_04 +
    (integer)(s1_aa_code_05 = 'P535') * s1_aa_dist_05 +
    (integer)(s1_aa_code_06 = 'P535') * s1_aa_dist_06 +
    (integer)(s1_aa_code_07 = 'P535') * s1_aa_dist_07 +
    (integer)(s1_aa_code_08 = 'P535') * s1_aa_dist_08 +
    (integer)(s1_aa_code_09 = 'P535') * s1_aa_dist_09 +
    (integer)(s1_aa_code_10 = 'P535') * s1_aa_dist_10 +
    (integer)(s1_aa_code_11 = 'P535') * s1_aa_dist_11 +
    (integer)(s1_aa_code_12 = 'P535') * s1_aa_dist_12 +
    (integer)(s1_aa_code_13 = 'P535') * s1_aa_dist_13 +
    (integer)(s1_aa_code_14 = 'P535') * s1_aa_dist_14 +
    (integer)(s1_aa_code_15 = 'P535') * s1_aa_dist_15 +
    (integer)(s1_aa_code_16 = 'P535') * s1_aa_dist_16 +
    (integer)(s1_aa_code_17 = 'P535') * s1_aa_dist_17 +
    (integer)(s1_aa_code_18 = 'P535') * s1_aa_dist_18 +
    (integer)(s1_aa_code_19 = 'P535') * s1_aa_dist_19 +
    (integer)(s1_aa_code_20 = 'P535') * s1_aa_dist_20 +
    (integer)(s1_aa_code_21 = 'P535') * s1_aa_dist_21 +
    (integer)(s1_aa_code_22 = 'P535') * s1_aa_dist_22 +
    (integer)(s1_aa_code_23 = 'P535') * s1_aa_dist_23 +
    (integer)(s1_aa_code_24 = 'P535') * s1_aa_dist_24 +
    (integer)(s1_aa_code_25 = 'P535') * s1_aa_dist_25 +
    (integer)(s1_aa_code_26 = 'P535') * s1_aa_dist_26 ) ;

s1_rcvaluep539 := __common__( (integer)(s1_aa_code_01 = 'P539') * s1_aa_dist_01 +
    (integer)(s1_aa_code_02 = 'P539') * s1_aa_dist_02 +
    (integer)(s1_aa_code_03 = 'P539') * s1_aa_dist_03 +
    (integer)(s1_aa_code_04 = 'P539') * s1_aa_dist_04 +
    (integer)(s1_aa_code_05 = 'P539') * s1_aa_dist_05 +
    (integer)(s1_aa_code_06 = 'P539') * s1_aa_dist_06 +
    (integer)(s1_aa_code_07 = 'P539') * s1_aa_dist_07 +
    (integer)(s1_aa_code_08 = 'P539') * s1_aa_dist_08 +
    (integer)(s1_aa_code_09 = 'P539') * s1_aa_dist_09 +
    (integer)(s1_aa_code_10 = 'P539') * s1_aa_dist_10 +
    (integer)(s1_aa_code_11 = 'P539') * s1_aa_dist_11 +
    (integer)(s1_aa_code_12 = 'P539') * s1_aa_dist_12 +
    (integer)(s1_aa_code_13 = 'P539') * s1_aa_dist_13 +
    (integer)(s1_aa_code_14 = 'P539') * s1_aa_dist_14 +
    (integer)(s1_aa_code_15 = 'P539') * s1_aa_dist_15 +
    (integer)(s1_aa_code_16 = 'P539') * s1_aa_dist_16 +
    (integer)(s1_aa_code_17 = 'P539') * s1_aa_dist_17 +
    (integer)(s1_aa_code_18 = 'P539') * s1_aa_dist_18 +
    (integer)(s1_aa_code_19 = 'P539') * s1_aa_dist_19 +
    (integer)(s1_aa_code_20 = 'P539') * s1_aa_dist_20 +
    (integer)(s1_aa_code_21 = 'P539') * s1_aa_dist_21 +
    (integer)(s1_aa_code_22 = 'P539') * s1_aa_dist_22 +
    (integer)(s1_aa_code_23 = 'P539') * s1_aa_dist_23 +
    (integer)(s1_aa_code_24 = 'P539') * s1_aa_dist_24 +
    (integer)(s1_aa_code_25 = 'P539') * s1_aa_dist_25 +
    (integer)(s1_aa_code_26 = 'P539') * s1_aa_dist_26 ) ;

s1_rcvaluep540 := __common__( (integer)(s1_aa_code_01 = 'P540') * s1_aa_dist_01 +
    (integer)(s1_aa_code_02 = 'P540') * s1_aa_dist_02 +
    (integer)(s1_aa_code_03 = 'P540') * s1_aa_dist_03 +
    (integer)(s1_aa_code_04 = 'P540') * s1_aa_dist_04 +
    (integer)(s1_aa_code_05 = 'P540') * s1_aa_dist_05 +
    (integer)(s1_aa_code_06 = 'P540') * s1_aa_dist_06 +
    (integer)(s1_aa_code_07 = 'P540') * s1_aa_dist_07 +
    (integer)(s1_aa_code_08 = 'P540') * s1_aa_dist_08 +
    (integer)(s1_aa_code_09 = 'P540') * s1_aa_dist_09 +
    (integer)(s1_aa_code_10 = 'P540') * s1_aa_dist_10 +
    (integer)(s1_aa_code_11 = 'P540') * s1_aa_dist_11 +
    (integer)(s1_aa_code_12 = 'P540') * s1_aa_dist_12 +
    (integer)(s1_aa_code_13 = 'P540') * s1_aa_dist_13 +
    (integer)(s1_aa_code_14 = 'P540') * s1_aa_dist_14 +
    (integer)(s1_aa_code_15 = 'P540') * s1_aa_dist_15 +
    (integer)(s1_aa_code_16 = 'P540') * s1_aa_dist_16 +
    (integer)(s1_aa_code_17 = 'P540') * s1_aa_dist_17 +
    (integer)(s1_aa_code_18 = 'P540') * s1_aa_dist_18 +
    (integer)(s1_aa_code_19 = 'P540') * s1_aa_dist_19 +
    (integer)(s1_aa_code_20 = 'P540') * s1_aa_dist_20 +
    (integer)(s1_aa_code_21 = 'P540') * s1_aa_dist_21 +
    (integer)(s1_aa_code_22 = 'P540') * s1_aa_dist_22 +
    (integer)(s1_aa_code_23 = 'P540') * s1_aa_dist_23 +
    (integer)(s1_aa_code_24 = 'P540') * s1_aa_dist_24 +
    (integer)(s1_aa_code_25 = 'P540') * s1_aa_dist_25 +
    (integer)(s1_aa_code_26 = 'P540') * s1_aa_dist_26 ) ;

s1_rcvaluep515 := __common__( (integer)(s1_aa_code_01 = 'P515') * s1_aa_dist_01 +
    (integer)(s1_aa_code_02 = 'P515') * s1_aa_dist_02 +
    (integer)(s1_aa_code_03 = 'P515') * s1_aa_dist_03 +
    (integer)(s1_aa_code_04 = 'P515') * s1_aa_dist_04 +
    (integer)(s1_aa_code_05 = 'P515') * s1_aa_dist_05 +
    (integer)(s1_aa_code_06 = 'P515') * s1_aa_dist_06 +
    (integer)(s1_aa_code_07 = 'P515') * s1_aa_dist_07 +
    (integer)(s1_aa_code_08 = 'P515') * s1_aa_dist_08 +
    (integer)(s1_aa_code_09 = 'P515') * s1_aa_dist_09 +
    (integer)(s1_aa_code_10 = 'P515') * s1_aa_dist_10 +
    (integer)(s1_aa_code_11 = 'P515') * s1_aa_dist_11 +
    (integer)(s1_aa_code_12 = 'P515') * s1_aa_dist_12 +
    (integer)(s1_aa_code_13 = 'P515') * s1_aa_dist_13 +
    (integer)(s1_aa_code_14 = 'P515') * s1_aa_dist_14 +
    (integer)(s1_aa_code_15 = 'P515') * s1_aa_dist_15 +
    (integer)(s1_aa_code_16 = 'P515') * s1_aa_dist_16 +
    (integer)(s1_aa_code_17 = 'P515') * s1_aa_dist_17 +
    (integer)(s1_aa_code_18 = 'P515') * s1_aa_dist_18 +
    (integer)(s1_aa_code_19 = 'P515') * s1_aa_dist_19 +
    (integer)(s1_aa_code_20 = 'P515') * s1_aa_dist_20 +
    (integer)(s1_aa_code_21 = 'P515') * s1_aa_dist_21 +
    (integer)(s1_aa_code_22 = 'P515') * s1_aa_dist_22 +
    (integer)(s1_aa_code_23 = 'P515') * s1_aa_dist_23 +
    (integer)(s1_aa_code_24 = 'P515') * s1_aa_dist_24 +
    (integer)(s1_aa_code_25 = 'P515') * s1_aa_dist_25 +
    (integer)(s1_aa_code_26 = 'P515') * s1_aa_dist_26 ) ;

s1_rcvaluep505 := __common__( (integer)(s1_aa_code_01 = 'P505') * s1_aa_dist_01 +
    (integer)(s1_aa_code_02 = 'P505') * s1_aa_dist_02 +
    (integer)(s1_aa_code_03 = 'P505') * s1_aa_dist_03 +
    (integer)(s1_aa_code_04 = 'P505') * s1_aa_dist_04 +
    (integer)(s1_aa_code_05 = 'P505') * s1_aa_dist_05 +
    (integer)(s1_aa_code_06 = 'P505') * s1_aa_dist_06 +
    (integer)(s1_aa_code_07 = 'P505') * s1_aa_dist_07 +
    (integer)(s1_aa_code_08 = 'P505') * s1_aa_dist_08 +
    (integer)(s1_aa_code_09 = 'P505') * s1_aa_dist_09 +
    (integer)(s1_aa_code_10 = 'P505') * s1_aa_dist_10 +
    (integer)(s1_aa_code_11 = 'P505') * s1_aa_dist_11 +
    (integer)(s1_aa_code_12 = 'P505') * s1_aa_dist_12 +
    (integer)(s1_aa_code_13 = 'P505') * s1_aa_dist_13 +
    (integer)(s1_aa_code_14 = 'P505') * s1_aa_dist_14 +
    (integer)(s1_aa_code_15 = 'P505') * s1_aa_dist_15 +
    (integer)(s1_aa_code_16 = 'P505') * s1_aa_dist_16 +
    (integer)(s1_aa_code_17 = 'P505') * s1_aa_dist_17 +
    (integer)(s1_aa_code_18 = 'P505') * s1_aa_dist_18 +
    (integer)(s1_aa_code_19 = 'P505') * s1_aa_dist_19 +
    (integer)(s1_aa_code_20 = 'P505') * s1_aa_dist_20 +
    (integer)(s1_aa_code_21 = 'P505') * s1_aa_dist_21 +
    (integer)(s1_aa_code_22 = 'P505') * s1_aa_dist_22 +
    (integer)(s1_aa_code_23 = 'P505') * s1_aa_dist_23 +
    (integer)(s1_aa_code_24 = 'P505') * s1_aa_dist_24 +
    (integer)(s1_aa_code_25 = 'P505') * s1_aa_dist_25 +
    (integer)(s1_aa_code_26 = 'P505') * s1_aa_dist_26 ) ;

s1_rcvaluep513 := __common__( (integer)(s1_aa_code_01 = 'P513') * s1_aa_dist_01 +
    (integer)(s1_aa_code_02 = 'P513') * s1_aa_dist_02 +
    (integer)(s1_aa_code_03 = 'P513') * s1_aa_dist_03 +
    (integer)(s1_aa_code_04 = 'P513') * s1_aa_dist_04 +
    (integer)(s1_aa_code_05 = 'P513') * s1_aa_dist_05 +
    (integer)(s1_aa_code_06 = 'P513') * s1_aa_dist_06 +
    (integer)(s1_aa_code_07 = 'P513') * s1_aa_dist_07 +
    (integer)(s1_aa_code_08 = 'P513') * s1_aa_dist_08 +
    (integer)(s1_aa_code_09 = 'P513') * s1_aa_dist_09 +
    (integer)(s1_aa_code_10 = 'P513') * s1_aa_dist_10 +
    (integer)(s1_aa_code_11 = 'P513') * s1_aa_dist_11 +
    (integer)(s1_aa_code_12 = 'P513') * s1_aa_dist_12 +
    (integer)(s1_aa_code_13 = 'P513') * s1_aa_dist_13 +
    (integer)(s1_aa_code_14 = 'P513') * s1_aa_dist_14 +
    (integer)(s1_aa_code_15 = 'P513') * s1_aa_dist_15 +
    (integer)(s1_aa_code_16 = 'P513') * s1_aa_dist_16 +
    (integer)(s1_aa_code_17 = 'P513') * s1_aa_dist_17 +
    (integer)(s1_aa_code_18 = 'P513') * s1_aa_dist_18 +
    (integer)(s1_aa_code_19 = 'P513') * s1_aa_dist_19 +
    (integer)(s1_aa_code_20 = 'P513') * s1_aa_dist_20 +
    (integer)(s1_aa_code_21 = 'P513') * s1_aa_dist_21 +
    (integer)(s1_aa_code_22 = 'P513') * s1_aa_dist_22 +
    (integer)(s1_aa_code_23 = 'P513') * s1_aa_dist_23 +
    (integer)(s1_aa_code_24 = 'P513') * s1_aa_dist_24 +
    (integer)(s1_aa_code_25 = 'P513') * s1_aa_dist_25 +
    (integer)(s1_aa_code_26 = 'P513') * s1_aa_dist_26 ) ;

s1_rcvaluep510 := __common__( (integer)(s1_aa_code_01 = 'P510') * s1_aa_dist_01 +
    (integer)(s1_aa_code_02 = 'P510') * s1_aa_dist_02 +
    (integer)(s1_aa_code_03 = 'P510') * s1_aa_dist_03 +
    (integer)(s1_aa_code_04 = 'P510') * s1_aa_dist_04 +
    (integer)(s1_aa_code_05 = 'P510') * s1_aa_dist_05 +
    (integer)(s1_aa_code_06 = 'P510') * s1_aa_dist_06 +
    (integer)(s1_aa_code_07 = 'P510') * s1_aa_dist_07 +
    (integer)(s1_aa_code_08 = 'P510') * s1_aa_dist_08 +
    (integer)(s1_aa_code_09 = 'P510') * s1_aa_dist_09 +
    (integer)(s1_aa_code_10 = 'P510') * s1_aa_dist_10 +
    (integer)(s1_aa_code_11 = 'P510') * s1_aa_dist_11 +
    (integer)(s1_aa_code_12 = 'P510') * s1_aa_dist_12 +
    (integer)(s1_aa_code_13 = 'P510') * s1_aa_dist_13 +
    (integer)(s1_aa_code_14 = 'P510') * s1_aa_dist_14 +
    (integer)(s1_aa_code_15 = 'P510') * s1_aa_dist_15 +
    (integer)(s1_aa_code_16 = 'P510') * s1_aa_dist_16 +
    (integer)(s1_aa_code_17 = 'P510') * s1_aa_dist_17 +
    (integer)(s1_aa_code_18 = 'P510') * s1_aa_dist_18 +
    (integer)(s1_aa_code_19 = 'P510') * s1_aa_dist_19 +
    (integer)(s1_aa_code_20 = 'P510') * s1_aa_dist_20 +
    (integer)(s1_aa_code_21 = 'P510') * s1_aa_dist_21 +
    (integer)(s1_aa_code_22 = 'P510') * s1_aa_dist_22 +
    (integer)(s1_aa_code_23 = 'P510') * s1_aa_dist_23 +
    (integer)(s1_aa_code_24 = 'P510') * s1_aa_dist_24 +
    (integer)(s1_aa_code_25 = 'P510') * s1_aa_dist_25 +
    (integer)(s1_aa_code_26 = 'P510') * s1_aa_dist_26 ) ;

s1_rcvalueb067 := __common__( (integer)(s1_aa_code_01 = 'B067') * s1_aa_dist_01 +
    (integer)(s1_aa_code_02 = 'B067') * s1_aa_dist_02 +
    (integer)(s1_aa_code_03 = 'B067') * s1_aa_dist_03 +
    (integer)(s1_aa_code_04 = 'B067') * s1_aa_dist_04 +
    (integer)(s1_aa_code_05 = 'B067') * s1_aa_dist_05 +
    (integer)(s1_aa_code_06 = 'B067') * s1_aa_dist_06 +
    (integer)(s1_aa_code_07 = 'B067') * s1_aa_dist_07 +
    (integer)(s1_aa_code_08 = 'B067') * s1_aa_dist_08 +
    (integer)(s1_aa_code_09 = 'B067') * s1_aa_dist_09 +
    (integer)(s1_aa_code_10 = 'B067') * s1_aa_dist_10 +
    (integer)(s1_aa_code_11 = 'B067') * s1_aa_dist_11 +
    (integer)(s1_aa_code_12 = 'B067') * s1_aa_dist_12 +
    (integer)(s1_aa_code_13 = 'B067') * s1_aa_dist_13 +
    (integer)(s1_aa_code_14 = 'B067') * s1_aa_dist_14 +
    (integer)(s1_aa_code_15 = 'B067') * s1_aa_dist_15 +
    (integer)(s1_aa_code_16 = 'B067') * s1_aa_dist_16 +
    (integer)(s1_aa_code_17 = 'B067') * s1_aa_dist_17 +
    (integer)(s1_aa_code_18 = 'B067') * s1_aa_dist_18 +
    (integer)(s1_aa_code_19 = 'B067') * s1_aa_dist_19 +
    (integer)(s1_aa_code_20 = 'B067') * s1_aa_dist_20 +
    (integer)(s1_aa_code_21 = 'B067') * s1_aa_dist_21 +
    (integer)(s1_aa_code_22 = 'B067') * s1_aa_dist_22 +
    (integer)(s1_aa_code_23 = 'B067') * s1_aa_dist_23 +
    (integer)(s1_aa_code_24 = 'B067') * s1_aa_dist_24 +
    (integer)(s1_aa_code_25 = 'B067') * s1_aa_dist_25 +
    (integer)(s1_aa_code_26 = 'B067') * s1_aa_dist_26 ) ;

s1_rcvaluep517 := __common__( (integer)(s1_aa_code_01 = 'P517') * s1_aa_dist_01 +
    (integer)(s1_aa_code_02 = 'P517') * s1_aa_dist_02 +
    (integer)(s1_aa_code_03 = 'P517') * s1_aa_dist_03 +
    (integer)(s1_aa_code_04 = 'P517') * s1_aa_dist_04 +
    (integer)(s1_aa_code_05 = 'P517') * s1_aa_dist_05 +
    (integer)(s1_aa_code_06 = 'P517') * s1_aa_dist_06 +
    (integer)(s1_aa_code_07 = 'P517') * s1_aa_dist_07 +
    (integer)(s1_aa_code_08 = 'P517') * s1_aa_dist_08 +
    (integer)(s1_aa_code_09 = 'P517') * s1_aa_dist_09 +
    (integer)(s1_aa_code_10 = 'P517') * s1_aa_dist_10 +
    (integer)(s1_aa_code_11 = 'P517') * s1_aa_dist_11 +
    (integer)(s1_aa_code_12 = 'P517') * s1_aa_dist_12 +
    (integer)(s1_aa_code_13 = 'P517') * s1_aa_dist_13 +
    (integer)(s1_aa_code_14 = 'P517') * s1_aa_dist_14 +
    (integer)(s1_aa_code_15 = 'P517') * s1_aa_dist_15 +
    (integer)(s1_aa_code_16 = 'P517') * s1_aa_dist_16 +
    (integer)(s1_aa_code_17 = 'P517') * s1_aa_dist_17 +
    (integer)(s1_aa_code_18 = 'P517') * s1_aa_dist_18 +
    (integer)(s1_aa_code_19 = 'P517') * s1_aa_dist_19 +
    (integer)(s1_aa_code_20 = 'P517') * s1_aa_dist_20 +
    (integer)(s1_aa_code_21 = 'P517') * s1_aa_dist_21 +
    (integer)(s1_aa_code_22 = 'P517') * s1_aa_dist_22 +
    (integer)(s1_aa_code_23 = 'P517') * s1_aa_dist_23 +
    (integer)(s1_aa_code_24 = 'P517') * s1_aa_dist_24 +
    (integer)(s1_aa_code_25 = 'P517') * s1_aa_dist_25 +
    (integer)(s1_aa_code_26 = 'P517') * s1_aa_dist_26 ) ;

s1_rcvaluep567 := __common__( (integer)(s1_aa_code_01 = 'P567') * s1_aa_dist_01 +
    (integer)(s1_aa_code_02 = 'P567') * s1_aa_dist_02 +
    (integer)(s1_aa_code_03 = 'P567') * s1_aa_dist_03 +
    (integer)(s1_aa_code_04 = 'P567') * s1_aa_dist_04 +
    (integer)(s1_aa_code_05 = 'P567') * s1_aa_dist_05 +
    (integer)(s1_aa_code_06 = 'P567') * s1_aa_dist_06 +
    (integer)(s1_aa_code_07 = 'P567') * s1_aa_dist_07 +
    (integer)(s1_aa_code_08 = 'P567') * s1_aa_dist_08 +
    (integer)(s1_aa_code_09 = 'P567') * s1_aa_dist_09 +
    (integer)(s1_aa_code_10 = 'P567') * s1_aa_dist_10 +
    (integer)(s1_aa_code_11 = 'P567') * s1_aa_dist_11 +
    (integer)(s1_aa_code_12 = 'P567') * s1_aa_dist_12 +
    (integer)(s1_aa_code_13 = 'P567') * s1_aa_dist_13 +
    (integer)(s1_aa_code_14 = 'P567') * s1_aa_dist_14 +
    (integer)(s1_aa_code_15 = 'P567') * s1_aa_dist_15 +
    (integer)(s1_aa_code_16 = 'P567') * s1_aa_dist_16 +
    (integer)(s1_aa_code_17 = 'P567') * s1_aa_dist_17 +
    (integer)(s1_aa_code_18 = 'P567') * s1_aa_dist_18 +
    (integer)(s1_aa_code_19 = 'P567') * s1_aa_dist_19 +
    (integer)(s1_aa_code_20 = 'P567') * s1_aa_dist_20 +
    (integer)(s1_aa_code_21 = 'P567') * s1_aa_dist_21 +
    (integer)(s1_aa_code_22 = 'P567') * s1_aa_dist_22 +
    (integer)(s1_aa_code_23 = 'P567') * s1_aa_dist_23 +
    (integer)(s1_aa_code_24 = 'P567') * s1_aa_dist_24 +
    (integer)(s1_aa_code_25 = 'P567') * s1_aa_dist_25 +
    (integer)(s1_aa_code_26 = 'P567') * s1_aa_dist_26 ) ;

s1_rcvaluep566 := __common__( (integer)(s1_aa_code_01 = 'P566') * s1_aa_dist_01 +
    (integer)(s1_aa_code_02 = 'P566') * s1_aa_dist_02 +
    (integer)(s1_aa_code_03 = 'P566') * s1_aa_dist_03 +
    (integer)(s1_aa_code_04 = 'P566') * s1_aa_dist_04 +
    (integer)(s1_aa_code_05 = 'P566') * s1_aa_dist_05 +
    (integer)(s1_aa_code_06 = 'P566') * s1_aa_dist_06 +
    (integer)(s1_aa_code_07 = 'P566') * s1_aa_dist_07 +
    (integer)(s1_aa_code_08 = 'P566') * s1_aa_dist_08 +
    (integer)(s1_aa_code_09 = 'P566') * s1_aa_dist_09 +
    (integer)(s1_aa_code_10 = 'P566') * s1_aa_dist_10 +
    (integer)(s1_aa_code_11 = 'P566') * s1_aa_dist_11 +
    (integer)(s1_aa_code_12 = 'P566') * s1_aa_dist_12 +
    (integer)(s1_aa_code_13 = 'P566') * s1_aa_dist_13 +
    (integer)(s1_aa_code_14 = 'P566') * s1_aa_dist_14 +
    (integer)(s1_aa_code_15 = 'P566') * s1_aa_dist_15 +
    (integer)(s1_aa_code_16 = 'P566') * s1_aa_dist_16 +
    (integer)(s1_aa_code_17 = 'P566') * s1_aa_dist_17 +
    (integer)(s1_aa_code_18 = 'P566') * s1_aa_dist_18 +
    (integer)(s1_aa_code_19 = 'P566') * s1_aa_dist_19 +
    (integer)(s1_aa_code_20 = 'P566') * s1_aa_dist_20 +
    (integer)(s1_aa_code_21 = 'P566') * s1_aa_dist_21 +
    (integer)(s1_aa_code_22 = 'P566') * s1_aa_dist_22 +
    (integer)(s1_aa_code_23 = 'P566') * s1_aa_dist_23 +
    (integer)(s1_aa_code_24 = 'P566') * s1_aa_dist_24 +
    (integer)(s1_aa_code_25 = 'P566') * s1_aa_dist_25 +
    (integer)(s1_aa_code_26 = 'P566') * s1_aa_dist_26 ) ;

s1_rcvaluep526 := __common__( (integer)(s1_aa_code_01 = 'P526') * s1_aa_dist_01 +
    (integer)(s1_aa_code_02 = 'P526') * s1_aa_dist_02 +
    (integer)(s1_aa_code_03 = 'P526') * s1_aa_dist_03 +
    (integer)(s1_aa_code_04 = 'P526') * s1_aa_dist_04 +
    (integer)(s1_aa_code_05 = 'P526') * s1_aa_dist_05 +
    (integer)(s1_aa_code_06 = 'P526') * s1_aa_dist_06 +
    (integer)(s1_aa_code_07 = 'P526') * s1_aa_dist_07 +
    (integer)(s1_aa_code_08 = 'P526') * s1_aa_dist_08 +
    (integer)(s1_aa_code_09 = 'P526') * s1_aa_dist_09 +
    (integer)(s1_aa_code_10 = 'P526') * s1_aa_dist_10 +
    (integer)(s1_aa_code_11 = 'P526') * s1_aa_dist_11 +
    (integer)(s1_aa_code_12 = 'P526') * s1_aa_dist_12 +
    (integer)(s1_aa_code_13 = 'P526') * s1_aa_dist_13 +
    (integer)(s1_aa_code_14 = 'P526') * s1_aa_dist_14 +
    (integer)(s1_aa_code_15 = 'P526') * s1_aa_dist_15 +
    (integer)(s1_aa_code_16 = 'P526') * s1_aa_dist_16 +
    (integer)(s1_aa_code_17 = 'P526') * s1_aa_dist_17 +
    (integer)(s1_aa_code_18 = 'P526') * s1_aa_dist_18 +
    (integer)(s1_aa_code_19 = 'P526') * s1_aa_dist_19 +
    (integer)(s1_aa_code_20 = 'P526') * s1_aa_dist_20 +
    (integer)(s1_aa_code_21 = 'P526') * s1_aa_dist_21 +
    (integer)(s1_aa_code_22 = 'P526') * s1_aa_dist_22 +
    (integer)(s1_aa_code_23 = 'P526') * s1_aa_dist_23 +
    (integer)(s1_aa_code_24 = 'P526') * s1_aa_dist_24 +
    (integer)(s1_aa_code_25 = 'P526') * s1_aa_dist_25 +
    (integer)(s1_aa_code_26 = 'P526') * s1_aa_dist_26 ) ;

s1_lgt := __common__( -3.76884717497182 +
    s1_v01_w +
    s1_v02_w +
    s1_v03_w +
    s1_v04_w +
    s1_v05_w +
    s1_v06_w +
    s1_v07_w +
    s1_v08_w +
    s1_v09_w +
    s1_v10_w +
    s1_v11_w +
    s1_v12_w +
    s1_v13_w +
    s1_v14_w +
    s1_v15_w +
    s1_v16_w +
    s1_v17_w +
    s1_v18_w +
    s1_v19_w +
    s1_v20_w +
    s1_v21_w +
    s1_v22_w +
    s1_v23_w +
    s1_v24_w +
    s1_v25_w ) ;

rep_only := __common__( if(truebiz_ln, 0, 1) ) ;

final_score_1 := __common__( if(rep_only = 0, s0_lgt, NULL) ) ;

final_score := __common__( if(rep_only = 1, s1_lgt, final_score_1) ) ;

base := __common__( 700 ) ;

pts := __common__( -40 ) ;

lgt := __common__( ln(0.018 / (1 - 0.018)) ) ;

SLBB1809_0_0_1 := __common__( round(max((real)501, min(900, if(base + pts * (final_score - lgt) / ln(2) = NULL, -NULL, base + pts * (final_score - lgt) / ln(2))))) ) ;

SLBB1809_0_0 := __common__( if(iv_rv5_unscorable = 1, 222, SLBB1809_0_0_1) ) ;


ds_layout :=  {STRING rc, REAL value}  ;

Null_ds :=  dataset([{'00', NULL}, {'00', NULL}, {'00', NULL}, {'00', NULL}], ds_layout)  ;

//*************************************************************************************//
s_aa_code_set:=  [
s0_aa_code_01,
s0_aa_code_02,
s0_aa_code_03,
s0_aa_code_04,
s0_aa_code_05,
s0_aa_code_06,
s0_aa_code_07,
s0_aa_code_08,
s0_aa_code_09,
s0_aa_code_10,
s0_aa_code_02,
s0_aa_code_11,
s0_aa_code_12,
s0_aa_code_13,
s0_aa_code_14,
s0_aa_code_15,
s0_aa_code_16,
s0_aa_code_17,
s0_aa_code_18,
s0_aa_code_19,
s0_aa_code_20,
s0_aa_code_21,
s0_aa_code_22,
s0_aa_code_23,
s0_aa_code_24,
s0_aa_code_25,
s0_aa_code_26,
s0_aa_code_27,
s0_aa_code_28,
s0_aa_code_29,
s0_aa_code_30,
s0_aa_code_31,
s0_aa_code_32,
s0_aa_code_33,
s0_aa_code_34,
s0_aa_code_35,
s0_aa_code_36,
s0_aa_code_37,
s0_aa_code_38,
s0_aa_code_39,
s0_aa_code_40,
s0_aa_code_41,
s0_aa_code_42,
s0_aa_code_43
]  ;
             
rc_dataset_s0 := __common__( DATASET([
    {'B017', s0_rcvalueB017},
    {'B026', s0_rcvalueB026},
    {'B031', s0_rcvalueB031},
    {'B034', s0_rcvalueB034},
    {'B035', s0_rcvalueB035},
    {'B036', s0_rcvalueB036},
    {'B052', s0_rcvalueB052},
    {'B056', s0_rcvalueB056},
    {'B059', s0_rcvalueB059},
    {'B063', s0_rcvalueB063},
    {'B069', s0_rcvalueB069},
    {'B070', s0_rcvalueB070},
    {'B075', s0_rcvalueB075},
    {'B076', s0_rcvalueB076},
    {'B079', s0_rcvalueB079},
    {'P501', s0_rcvalueP501},
    {'P502', s0_rcvalueP502},
    {'P505', s0_rcvalueP505},
    {'P509', s0_rcvalueP509},
    {'P510', s0_rcvalueP510},
    {'P513', s0_rcvalueP513},
    {'P515', s0_rcvalueP515},
    {'P523', s0_rcvalueP523},
    {'P526', s0_rcvalueP526},
    {'P535', s0_rcvalueP535},
    {'P539', s0_rcvalueP539},
    {'P540', s0_rcvalueP540},
    {'P565', s0_rcvalueP565},
    {'P566', s0_rcvalueP566},
    {'P567', s0_rcvalueP567}
    ], ds_layout)(rc in s_aa_code_set) ) ;

//*************************************************************************************//
// IMPORTANT NOTE:  Select ONLY reason codes with an RCValue < 0.  I'll leave the 
//   implementation of this to the Engineer
//*************************************************************************************//
rc_dataset_0_sorted_new := __common__( sort(rc_dataset_s0, value, rc) ) ;

baseBLS0_rc1  := __common__( rc_dataset_0_sorted_new[1].rc ) ;
baseBLS0_rc2  := __common__( rc_dataset_0_sorted_new[2].rc ) ;
baseBLS0_rc3  := __common__( rc_dataset_0_sorted_new[3].rc ) ;
baseBLS0_rc4  := __common__( rc_dataset_0_sorted_new[4].rc ) ;
baseBLS0_rc5  := __common__( rc_dataset_0_sorted_new[5].rc ) ;
baseBLS0_rc6  := __common__( rc_dataset_0_sorted_new[6].rc ) ;
baseBLS0_rc7  := __common__( rc_dataset_0_sorted_new[7].rc ) ;
baseBLS0_rc8  := __common__( rc_dataset_0_sorted_new[8].rc ) ;
baseBLS0_rc9  := __common__( rc_dataset_0_sorted_new[9].rc ) ;
baseBLS0_rc10  := __common__( rc_dataset_0_sorted_new[10].rc ) ;
baseBLS0_rc11  := __common__( rc_dataset_0_sorted_new[11].rc ) ;
baseBLS0_rc12  := __common__( rc_dataset_0_sorted_new[12].rc ) ;
baseBLS0_rc13  := __common__( rc_dataset_0_sorted_new[13].rc ) ;
baseBLS0_rc14  := __common__( rc_dataset_0_sorted_new[14].rc ) ;
baseBLS0_rc15  := __common__( rc_dataset_0_sorted_new[15].rc ) ;
baseBLS0_rc16  := __common__( rc_dataset_0_sorted_new[16].rc ) ;
baseBLS0_rc17  := __common__( rc_dataset_0_sorted_new[17].rc ) ;
baseBLS0_rc18  := __common__( rc_dataset_0_sorted_new[18].rc ) ;
baseBLS0_rc19  := __common__( rc_dataset_0_sorted_new[19].rc ) ;
baseBLS0_rc20  := __common__( rc_dataset_0_sorted_new[20].rc ) ;
baseBLS0_rc21  := __common__( rc_dataset_0_sorted_new[21].rc ) ;
baseBLS0_rc22  := __common__( rc_dataset_0_sorted_new[22].rc ) ;
baseBLS0_rc23  := __common__( rc_dataset_0_sorted_new[23].rc ) ;
baseBLS0_rc24  := __common__( rc_dataset_0_sorted_new[24].rc ) ;
baseBLS0_rc25  := __common__( rc_dataset_0_sorted_new[25].rc ) ;
baseBLS0_rc26  := __common__( rc_dataset_0_sorted_new[26].rc ) ;
baseBLS0_rc27  := __common__( rc_dataset_0_sorted_new[27].rc ) ;
baseBLS0_rc28  := __common__( rc_dataset_0_sorted_new[28].rc ) ;
baseBLS0_rc29  := __common__( rc_dataset_0_sorted_new[29].rc ) ;
baseBLS0_rc30  := __common__( rc_dataset_0_sorted_new[30].rc ) ;
baseBLS0_rc31  := __common__( rc_dataset_0_sorted_new[31].rc ) ;
baseBLS0_rc32  := __common__( rc_dataset_0_sorted_new[32].rc ) ;
baseBLS0_rc33  := __common__( rc_dataset_0_sorted_new[33].rc ) ;
baseBLS0_rc34  := __common__( rc_dataset_0_sorted_new[34].rc ) ;
baseBLS0_rc35  := __common__( rc_dataset_0_sorted_new[35].rc ) ;
baseBLS0_rc36  := __common__( rc_dataset_0_sorted_new[36].rc ) ;
baseBLS0_rc37  := __common__( rc_dataset_0_sorted_new[37].rc ) ;
baseBLS0_rc38  := __common__( rc_dataset_0_sorted_new[38].rc ) ;
baseBLS0_rc39  := __common__( rc_dataset_0_sorted_new[39].rc ) ;
baseBLS0_rc40  := __common__( rc_dataset_0_sorted_new[40].rc ) ;
baseBLS0_rc41  := __common__( rc_dataset_0_sorted_new[41].rc ) ;
baseBLS0_rc42  := __common__( rc_dataset_0_sorted_new[42].rc ) ;
baseBLS0_rc43  := __common__( rc_dataset_0_sorted_new[43].rc ) ;
baseBLS0_rc44  := __common__( rc_dataset_0_sorted_new[44].rc ) ;
baseBLS0_rc45  := __common__( rc_dataset_0_sorted_new[45].rc ) ;
baseBLS0_rc46  := __common__( rc_dataset_0_sorted_new[46].rc ) ;
baseBLS0_rc47  := __common__( rc_dataset_0_sorted_new[47].rc ) ;
baseBLS0_rc48  := __common__( rc_dataset_0_sorted_new[48].rc ) ;
baseBLS0_rc49  := __common__( rc_dataset_0_sorted_new[49].rc ) ;
baseBLS0_rc50  := __common__( rc_dataset_0_sorted_new[50].rc ) ;
 
//*************************************************************************************//
s1_code_set := __common__( [s1_aa_code_01,
s1_aa_code_02,
s1_aa_code_03,
s1_aa_code_04,
s1_aa_code_05,
s1_aa_code_06,
s1_aa_code_07,
s1_aa_code_08,
s1_aa_code_09,
s1_aa_code_10,
s1_aa_code_02,
s1_aa_code_11,
s1_aa_code_12,
s1_aa_code_13,
s1_aa_code_14,
s1_aa_code_15,
s1_aa_code_16,
s1_aa_code_17,
s1_aa_code_18,
s1_aa_code_19,
s1_aa_code_20,
s1_aa_code_21,
s1_aa_code_22,
s1_aa_code_23,
s1_aa_code_24,
s1_aa_code_25,
s1_aa_code_26] ) ;
rc_dataset_s1 := __common__( DATASET([
    {'B067', s1_rcvalueB067},
    {'P502', s1_rcvalueP502},
    {'P505', s1_rcvalueP505},
    {'P509', s1_rcvalueP509},
    {'P510', s1_rcvalueP510},
    {'P513', s1_rcvalueP513},
    {'P515', s1_rcvalueP515},
    {'P517', s1_rcvalueP517},
    {'P526', s1_rcvalueP526},
    {'P535', s1_rcvalueP535},
    {'P539', s1_rcvalueP539},
    {'P540', s1_rcvalueP540},
    {'P566', s1_rcvalueP566},
    {'P567', s1_rcvalueP567}
    ], ds_layout)(rc in s1_code_set) ) ;

//*************************************************************************************//
// If none of the first four RCs are a business reason code (rc[1] = 'B'), find the first 
// business reason code, and make that the fourh reason code. Then shift everything down
// one position to make room for that reason code.  
//*************************************************************************************//
rc_dataset_s_sorted_new := __common__( sort(rc_dataset_s1, value, rc) ) ;

baseBLS1_rc1  := __common__( rc_dataset_s_sorted_new[1].rc ) ;
baseBLS1_rc2  := __common__( rc_dataset_s_sorted_new[2].rc ) ;
baseBLS1_rc3  := __common__( rc_dataset_s_sorted_new[3].rc ) ;
baseBLS1_rc4  := __common__( rc_dataset_s_sorted_new[4].rc ) ;
baseBLS1_rc5  := __common__( rc_dataset_s_sorted_new[5].rc ) ;
baseBLS1_rc6  := __common__( rc_dataset_s_sorted_new[6].rc ) ;
baseBLS1_rc7  := __common__( rc_dataset_s_sorted_new[7].rc ) ;
baseBLS1_rc8  := __common__( rc_dataset_s_sorted_new[8].rc ) ;
baseBLS1_rc9  := __common__( rc_dataset_s_sorted_new[9].rc ) ;
baseBLS1_rc10  := __common__( rc_dataset_s_sorted_new[10].rc ) ;
baseBLS1_rc11  := __common__( rc_dataset_s_sorted_new[11].rc ) ;
baseBLS1_rc12  := __common__( rc_dataset_s_sorted_new[12].rc ) ;
baseBLS1_rc13  := __common__( rc_dataset_s_sorted_new[13].rc ) ;
baseBLS1_rc14  := __common__( rc_dataset_s_sorted_new[14].rc ) ;
baseBLS1_rc15  := __common__( rc_dataset_s_sorted_new[15].rc ) ;
baseBLS1_rc16  := __common__( rc_dataset_s_sorted_new[16].rc ) ;
baseBLS1_rc17  := __common__( rc_dataset_s_sorted_new[17].rc ) ;
baseBLS1_rc18  := __common__( rc_dataset_s_sorted_new[18].rc ) ;
baseBLS1_rc19  := __common__( rc_dataset_s_sorted_new[19].rc ) ;
baseBLS1_rc20  := __common__( rc_dataset_s_sorted_new[20].rc ) ;
baseBLS1_rc21  := __common__( rc_dataset_s_sorted_new[21].rc ) ;
baseBLS1_rc22  := __common__( rc_dataset_s_sorted_new[22].rc ) ;
baseBLS1_rc23  := __common__( rc_dataset_s_sorted_new[23].rc ) ;
baseBLS1_rc24  := __common__( rc_dataset_s_sorted_new[24].rc ) ;
baseBLS1_rc25  := __common__( rc_dataset_s_sorted_new[25].rc ) ;
baseBLS1_rc26  := __common__( rc_dataset_s_sorted_new[26].rc ) ;
baseBLS1_rc27  := __common__( rc_dataset_s_sorted_new[27].rc ) ;
baseBLS1_rc28  := __common__( rc_dataset_s_sorted_new[28].rc ) ;
baseBLS1_rc29  := __common__( rc_dataset_s_sorted_new[29].rc ) ;
baseBLS1_rc30  := __common__( rc_dataset_s_sorted_new[30].rc ) ;
baseBLS1_rc31  := __common__( rc_dataset_s_sorted_new[31].rc ) ;
baseBLS1_rc32  := __common__( rc_dataset_s_sorted_new[32].rc ) ;
baseBLS1_rc33  := __common__( rc_dataset_s_sorted_new[33].rc ) ;
baseBLS1_rc34  := __common__( rc_dataset_s_sorted_new[34].rc ) ;
baseBLS1_rc35  := __common__( rc_dataset_s_sorted_new[35].rc ) ;
baseBLS1_rc36  := __common__( rc_dataset_s_sorted_new[36].rc ) ;
baseBLS1_rc37  := __common__( rc_dataset_s_sorted_new[37].rc ) ;
baseBLS1_rc38  := __common__( rc_dataset_s_sorted_new[38].rc ) ;
baseBLS1_rc39  := __common__( rc_dataset_s_sorted_new[39].rc ) ;
baseBLS1_rc40  := __common__( rc_dataset_s_sorted_new[40].rc ) ;
baseBLS1_rc41  := __common__( rc_dataset_s_sorted_new[41].rc ) ;
baseBLS1_rc42  := __common__( rc_dataset_s_sorted_new[42].rc ) ;
baseBLS1_rc43  := __common__( rc_dataset_s_sorted_new[43].rc ) ;
baseBLS1_rc44  := __common__( rc_dataset_s_sorted_new[44].rc ) ;
baseBLS1_rc45  := __common__( rc_dataset_s_sorted_new[45].rc ) ;
baseBLS1_rc46  := __common__( rc_dataset_s_sorted_new[46].rc ) ;
baseBLS1_rc47  := __common__( rc_dataset_s_sorted_new[47].rc ) ;
baseBLS1_rc48  := __common__( rc_dataset_s_sorted_new[48].rc ) ;
baseBLS1_rc49  := __common__( rc_dataset_s_sorted_new[49].rc ) ;
baseBLS1_rc50  := __common__( rc_dataset_s_sorted_new[50].rc ) ;


/* Note for Engineering:  I did not implement this logic as described
in the SAS model code:

  If the first business RC is not in the first four RCs, this code does the 
   following:
    1. store the fourth reason code in a temporary variable
    2. put the first business RC in the fourth position
    3. blank out the position it was found in
    4. shift the remaining reason codes to fill in the hole
    5. put the original fourth RC in the fifth position
*/

bus_mod_rc25_tmp := __common__( map(
    iv_rv5_unscorable = 1 => '',
    rep_only = 0          => basebls0_rc25,
                             basebls1_rc25) ) ;

bus_mod_rc31_tmp := __common__( map(
    iv_rv5_unscorable = 1 => '',
    rep_only = 0          => basebls0_rc31,
                             basebls1_rc31) ) ;

bus_mod_rc8_tmp := __common__( map(
    iv_rv5_unscorable = 1 => '',
    rep_only = 0          => basebls0_rc8,
                             basebls1_rc8) ) ;

bus_mod_rc36_tmp := __common__( map(
    iv_rv5_unscorable = 1 => '',
    rep_only = 0          => basebls0_rc36,
                             basebls1_rc36) ) ;

bus_mod_rc41_tmp := __common__( map(
    iv_rv5_unscorable = 1 => '',
    rep_only = 0          => basebls0_rc41,
                             basebls1_rc41) ) ;

bus_mod_rc10_tmp := __common__( map(
    iv_rv5_unscorable = 1 => '',
    rep_only = 0          => basebls0_rc10,
                             basebls1_rc10) ) ;

bus_mod_rc50_tmp := __common__( map(
    iv_rv5_unscorable = 1 => '',
    rep_only = 0          => basebls0_rc50,
                             basebls1_rc50) ) ;

bus_mod_rc46_tmp := __common__( map(
    iv_rv5_unscorable = 1 => '',
    rep_only = 0          => basebls0_rc46,
                             basebls1_rc46) ) ;

bus_mod_rc34_tmp := __common__( map(
    iv_rv5_unscorable = 1 => '',
    rep_only = 0          => basebls0_rc34,
                             basebls1_rc34) ) ;

bus_mod_rc13_tmp := __common__( map(
    iv_rv5_unscorable = 1 => '',
    rep_only = 0          => basebls0_rc13,
                             basebls1_rc13) ) ;

bus_mod_rc30_tmp := __common__( map(
    iv_rv5_unscorable = 1 => '',
    rep_only = 0          => basebls0_rc30,
                             basebls1_rc30) ) ;

bus_mod_rc9_tmp := __common__( map(
    iv_rv5_unscorable = 1 => '',
    rep_only = 0          => basebls0_rc9,
                             basebls1_rc9) ) ;

bus_mod_rc29_tmp := __common__( map(
    iv_rv5_unscorable = 1 => '',
    rep_only = 0          => basebls0_rc29,
                             basebls1_rc29) ) ;

bus_mod_rc24_tmp := __common__( map(
    iv_rv5_unscorable = 1 => '',
    rep_only = 0          => basebls0_rc24,
                             basebls1_rc24) ) ;

bus_mod_rc35_tmp := __common__( map(
    iv_rv5_unscorable = 1 => '',
    rep_only = 0          => basebls0_rc35,
                             basebls1_rc35) ) ;

bus_mod_rc48_tmp := __common__( map(
    iv_rv5_unscorable = 1 => '',
    rep_only = 0          => basebls0_rc48,
                             basebls1_rc48) ) ;

bus_mod_rc2 := __common__( map(
    iv_rv5_unscorable = 1 => '',
    rep_only = 0          => basebls0_rc2,
                             basebls1_rc2) ) ;

bus_mod_rc14_tmp := __common__( map(
    iv_rv5_unscorable = 1 => '',
    rep_only = 0          => basebls0_rc14,
                             basebls1_rc14) ) ;

bus_mod_rc26_tmp := __common__( map(
    iv_rv5_unscorable = 1 => '',
    rep_only = 0          => basebls0_rc26,
                             basebls1_rc26) ) ;

bus_mod_rc6_tmp := __common__( map(
    iv_rv5_unscorable = 1 => '',
    rep_only = 0          => basebls0_rc6,
                             basebls1_rc6) ) ;

bus_mod_rc44_tmp := __common__( map(
    iv_rv5_unscorable = 1 => '',
    rep_only = 0          => basebls0_rc44,
                             basebls1_rc44) ) ;

bus_mod_rc21_tmp := __common__( map(
    iv_rv5_unscorable = 1 => '',
    rep_only = 0          => basebls0_rc21,
                             basebls1_rc21) ) ;

bus_mod_rc43_tmp := __common__( map(
    iv_rv5_unscorable = 1 => '',
    rep_only = 0          => basebls0_rc43,
                             basebls1_rc43) ) ;

bus_mod_rc19_tmp := __common__( map(
    iv_rv5_unscorable = 1 => '',
    rep_only = 0          => basebls0_rc19,
                             basebls1_rc19) ) ;

bus_mod_rc32_tmp := __common__( map(
    iv_rv5_unscorable = 1 => '',
    rep_only = 0          => basebls0_rc32,
                             basebls1_rc32) ) ;

bus_mod_rc38_tmp := __common__( map(
    iv_rv5_unscorable = 1 => '',
    rep_only = 0          => basebls0_rc38,
                             basebls1_rc38) ) ;

bus_mod_rc15_tmp := __common__( map(
    iv_rv5_unscorable = 1 => '',
    rep_only = 0          => basebls0_rc15,
                             basebls1_rc15) ) ;

bus_mod_rc37_tmp := __common__( map(
    iv_rv5_unscorable = 1 => '',
    rep_only = 0          => basebls0_rc37,
                             basebls1_rc37) ) ;

bus_mod_rc33_tmp := __common__( map(
    iv_rv5_unscorable = 1 => '',
    rep_only = 0          => basebls0_rc33,
                             basebls1_rc33) ) ;

bus_mod_rc1 := __common__( map(
    iv_rv5_unscorable = 1 => 'B068',
    rep_only = 0          => basebls0_rc1,
                             basebls1_rc1) ) ;

bus_mod_rc28_tmp := __common__( map(
    iv_rv5_unscorable = 1 => '',
    rep_only = 0          => basebls0_rc28,
                             basebls1_rc28) ) ;

bus_mod_rc22_tmp := __common__( map(
    iv_rv5_unscorable = 1 => '',
    rep_only = 0          => basebls0_rc22,
                             basebls1_rc22) ) ;

bus_mod_rc42_tmp := __common__( map(
    iv_rv5_unscorable = 1 => '',
    rep_only = 0          => basebls0_rc42,
                             basebls1_rc42) ) ;

bus_mod_rc7_tmp := __common__( map(
    iv_rv5_unscorable = 1 => '',
    rep_only = 0          => basebls0_rc7,
                             basebls1_rc7) ) ;

bus_mod_rc18_tmp := __common__( map(
    iv_rv5_unscorable = 1 => '',
    rep_only = 0          => basebls0_rc18,
                             basebls1_rc18) ) ;

bus_mod_rc49_tmp := __common__( map(
    iv_rv5_unscorable = 1 => '',
    rep_only = 0          => basebls0_rc49,
                             basebls1_rc49) ) ;

bus_mod_rc16_tmp := __common__( map(
    iv_rv5_unscorable = 1 => '',
    rep_only = 0          => basebls0_rc16,
                             basebls1_rc16) ) ;

bus_mod_rc27_tmp := __common__( map(
    iv_rv5_unscorable = 1 => '',
    rep_only = 0          => basebls0_rc27,
                             basebls1_rc27) ) ;

bus_mod_rc40_tmp := __common__( map(
    iv_rv5_unscorable = 1 => '',
    rep_only = 0          => basebls0_rc40,
                             basebls1_rc40) ) ;

bus_mod_rc47_tmp := __common__( map(
    iv_rv5_unscorable = 1 => '',
    rep_only = 0          => basebls0_rc47,
                             basebls1_rc47) ) ;

bus_mod_rc45_tmp := __common__( map(
    iv_rv5_unscorable = 1 => '',
    rep_only = 0          => basebls0_rc45,
                             basebls1_rc45) ) ;

bus_mod_rc3 := __common__( map(
    iv_rv5_unscorable = 1 => '',
    rep_only = 0          => basebls0_rc3,
                             basebls1_rc3) ) ;

bus_mod_rc12_tmp := __common__( map(
    iv_rv5_unscorable = 1 => '',
    rep_only = 0          => basebls0_rc12,
                             basebls1_rc12) ) ;

bus_mod_rc11_tmp := __common__( map(
    iv_rv5_unscorable = 1 => '',
    rep_only = 0          => basebls0_rc11,
                             basebls1_rc11) ) ;

bus_mod_rc39_tmp := __common__( map(
    iv_rv5_unscorable = 1 => '',
    rep_only = 0          => basebls0_rc39,
                             basebls1_rc39) ) ;

bus_mod_rc17_tmp := __common__( map(
    iv_rv5_unscorable = 1 => '',
    rep_only = 0          => basebls0_rc17,
                             basebls1_rc17) ) ;

bus_mod_rc4_tmp := __common__( map(
    iv_rv5_unscorable = 1 => '',
    rep_only = 0          => basebls0_rc4,
                             basebls1_rc4) ) ;

bus_mod_rc5_tmp := __common__( map(
    iv_rv5_unscorable = 1 => '',
    rep_only = 0          => basebls0_rc5,
                             basebls1_rc5) ) ;
														 
bus_mod_rc23_tmp := __common__( map(
    iv_rv5_unscorable = 1 => '',
    rep_only = 0          => basebls0_rc23,
                             basebls1_rc23) ) ;

bus_mod_rc20_tmp := __common__( map(
    iv_rv5_unscorable = 1 => '',
    rep_only = 0          => basebls0_rc20,
                             basebls1_rc20) ) ;														 

b_rc_rc := __common__( dataset([
{bus_mod_rc5_tmp, 1},
{bus_mod_rc6_tmp, 2},
{bus_mod_rc7_tmp, 3},
{bus_mod_rc8_tmp, 4},
{bus_mod_rc9_tmp, 5},
{bus_mod_rc10_tmp, 6},
{bus_mod_rc11_tmp, 7},
{bus_mod_rc12_tmp, 8},
{bus_mod_rc13_tmp, 9},
{bus_mod_rc14_tmp, 10},
{bus_mod_rc15_tmp, 11},
{bus_mod_rc16_tmp, 12},
{bus_mod_rc17_tmp, 13},
{bus_mod_rc18_tmp, 14},
{bus_mod_rc19_tmp, 15},
{bus_mod_rc20_tmp, 16},
{bus_mod_rc21_tmp, 17},
{bus_mod_rc22_tmp, 18},
{bus_mod_rc23_tmp, 19},
{bus_mod_rc24_tmp, 20},
{bus_mod_rc25_tmp, 21},
{bus_mod_rc26_tmp, 22},
{bus_mod_rc27_tmp, 23},
{bus_mod_rc28_tmp, 24},
{bus_mod_rc29_tmp, 25},
{bus_mod_rc30_tmp, 26},
{bus_mod_rc31_tmp, 27},
{bus_mod_rc32_tmp, 28},
{bus_mod_rc33_tmp, 29},
{bus_mod_rc34_tmp, 30},
{bus_mod_rc35_tmp, 31},
{bus_mod_rc36_tmp, 32},
{bus_mod_rc37_tmp, 33},
{bus_mod_rc38_tmp, 34},
{bus_mod_rc39_tmp, 35},
{bus_mod_rc40_tmp, 36},
{bus_mod_rc41_tmp, 37},
{bus_mod_rc42_tmp, 38},
{bus_mod_rc43_tmp, 39},
{bus_mod_rc44_tmp, 40},
{bus_mod_rc45_tmp, 41},
{bus_mod_rc46_tmp, 42},
{bus_mod_rc47_tmp, 43},
{bus_mod_rc48_tmp, 44},
{bus_mod_rc49_tmp, 45},
{bus_mod_rc50_tmp, 46}], ds_layout) ) ;

do_new_sort := __common__( bus_mod_rc1[1..1] <> 'B' and bus_mod_rc2[1..1] <> 'B' and 
							 bus_mod_rc3[1..1] <> 'B' and bus_mod_rc4_tmp[1..1] <> 'B' ) ;
rc4_business := __common__( b_rc_rc(rc[1] = 'B')[1] ) ;
brc := __common__( b_rc_rc(rc <> rc4_business.rc) ) ; //gives us all except new B reason code
rc_dataset_s2_sorted_new := __common__( if(do_new_sort, brc, b_rc_rc) ) ; 

bus_mod_rc4  := __common__( if(do_new_sort and rc4_business.rc != '', rc4_business.rc, bus_mod_rc4_tmp) ) ;
bus_mod_rc5  := __common__( if(do_new_sort and rc4_business.rc != '', bus_mod_rc4_tmp, rc_dataset_s2_sorted_new[1].rc) ) ;
bus_mod_rc6  := __common__( if(do_new_sort,rc_dataset_s2_sorted_new[1].rc, rc_dataset_s2_sorted_new[2].rc) ) ;
bus_mod_rc7  := __common__( if(do_new_sort,rc_dataset_s2_sorted_new[2].rc,rc_dataset_s2_sorted_new[3].rc) ) ;
bus_mod_rc8  := __common__( if(do_new_sort,rc_dataset_s2_sorted_new[3].rc,rc_dataset_s2_sorted_new[4].rc) ) ;
bus_mod_rc9  := __common__( if(do_new_sort,rc_dataset_s2_sorted_new[4].rc,rc_dataset_s2_sorted_new[5].rc) ) ;
bus_mod_rc10 := __common__( if(do_new_sort,rc_dataset_s2_sorted_new[5].rc,rc_dataset_s2_sorted_new[6].rc) ) ;
bus_mod_rc11 := __common__( if(do_new_sort,rc_dataset_s2_sorted_new[6].rc,rc_dataset_s2_sorted_new[7].rc) ) ;
bus_mod_rc12 := __common__( if(do_new_sort,rc_dataset_s2_sorted_new[7].rc,rc_dataset_s2_sorted_new[8].rc) ) ;
bus_mod_rc13 := __common__( if(do_new_sort,rc_dataset_s2_sorted_new[8].rc,rc_dataset_s2_sorted_new[9].rc) ) ;
bus_mod_rc14 := __common__( if(do_new_sort,rc_dataset_s2_sorted_new[9].rc,rc_dataset_s2_sorted_new[10].rc) ) ;
bus_mod_rc15 := __common__( if(do_new_sort,rc_dataset_s2_sorted_new[10].rc,rc_dataset_s2_sorted_new[11].rc) ) ;
bus_mod_rc16 := __common__( if(do_new_sort,rc_dataset_s2_sorted_new[11].rc,rc_dataset_s2_sorted_new[12].rc) ) ;
bus_mod_rc17 := __common__( if(do_new_sort,rc_dataset_s2_sorted_new[12].rc,rc_dataset_s2_sorted_new[13].rc) ) ;
bus_mod_rc18 := __common__( if(do_new_sort,rc_dataset_s2_sorted_new[13].rc,rc_dataset_s2_sorted_new[14].rc) ) ;
bus_mod_rc19 := __common__( if(do_new_sort,rc_dataset_s2_sorted_new[14].rc,rc_dataset_s2_sorted_new[15].rc) ) ;
bus_mod_rc20 := __common__( if(do_new_sort,rc_dataset_s2_sorted_new[15].rc,rc_dataset_s2_sorted_new[16].rc) ) ;
bus_mod_rc21 := __common__( if(do_new_sort,rc_dataset_s2_sorted_new[16].rc,rc_dataset_s2_sorted_new[17].rc) ) ;
bus_mod_rc22 := __common__( if(do_new_sort,rc_dataset_s2_sorted_new[17].rc,rc_dataset_s2_sorted_new[18].rc) ) ;
bus_mod_rc23 := __common__( if(do_new_sort,rc_dataset_s2_sorted_new[18].rc,rc_dataset_s2_sorted_new[19].rc) ) ;
bus_mod_rc24 := __common__( if(do_new_sort,rc_dataset_s2_sorted_new[19].rc,rc_dataset_s2_sorted_new[20].rc) ) ;
bus_mod_rc25 := __common__( if(do_new_sort,rc_dataset_s2_sorted_new[20].rc,rc_dataset_s2_sorted_new[21].rc) ) ;
bus_mod_rc26 := __common__( if(do_new_sort,rc_dataset_s2_sorted_new[21].rc,rc_dataset_s2_sorted_new[22].rc) ) ;
bus_mod_rc27 := __common__( if(do_new_sort,rc_dataset_s2_sorted_new[22].rc,rc_dataset_s2_sorted_new[23].rc) ) ;
bus_mod_rc28 := __common__( if(do_new_sort,rc_dataset_s2_sorted_new[23].rc,rc_dataset_s2_sorted_new[24].rc) ) ;
bus_mod_rc29 := __common__( if(do_new_sort,rc_dataset_s2_sorted_new[24].rc,rc_dataset_s2_sorted_new[25].rc) ) ;
bus_mod_rc30 := __common__( if(do_new_sort,rc_dataset_s2_sorted_new[25].rc,rc_dataset_s2_sorted_new[26].rc) ) ;
bus_mod_rc31 := __common__( if(do_new_sort,rc_dataset_s2_sorted_new[26].rc,rc_dataset_s2_sorted_new[271].rc) ) ;
bus_mod_rc32 := __common__( if(do_new_sort,rc_dataset_s2_sorted_new[27].rc,rc_dataset_s2_sorted_new[28].rc) ) ;
bus_mod_rc33 := __common__( if(do_new_sort,rc_dataset_s2_sorted_new[28].rc,rc_dataset_s2_sorted_new[29].rc) ) ;
bus_mod_rc34 := __common__( if(do_new_sort,rc_dataset_s2_sorted_new[29].rc,rc_dataset_s2_sorted_new[30].rc) ) ;
bus_mod_rc35 := __common__( if(do_new_sort,rc_dataset_s2_sorted_new[30].rc,rc_dataset_s2_sorted_new[31].rc) ) ;
bus_mod_rc36 := __common__( if(do_new_sort,rc_dataset_s2_sorted_new[31].rc,rc_dataset_s2_sorted_new[32].rc) ) ;
bus_mod_rc37 := __common__( if(do_new_sort,rc_dataset_s2_sorted_new[32].rc,rc_dataset_s2_sorted_new[33].rc) ) ;
bus_mod_rc38 := __common__( if(do_new_sort,rc_dataset_s2_sorted_new[33].rc,rc_dataset_s2_sorted_new[34].rc) ) ;
bus_mod_rc39 := __common__( if(do_new_sort,rc_dataset_s2_sorted_new[34].rc,rc_dataset_s2_sorted_new[35].rc) ) ;
bus_mod_rc40 := __common__( if(do_new_sort,rc_dataset_s2_sorted_new[35].rc,rc_dataset_s2_sorted_new[36].rc) ) ;
bus_mod_rc41 := __common__( if(do_new_sort,rc_dataset_s2_sorted_new[36].rc,rc_dataset_s2_sorted_new[37].rc) ) ;
bus_mod_rc42 := __common__( if(do_new_sort,rc_dataset_s2_sorted_new[37].rc,rc_dataset_s2_sorted_new[38].rc) ) ;
bus_mod_rc43 := __common__( if(do_new_sort,rc_dataset_s2_sorted_new[38].rc,rc_dataset_s2_sorted_new[39].rc) ) ;
bus_mod_rc44 := __common__( if(do_new_sort,rc_dataset_s2_sorted_new[39].rc,rc_dataset_s2_sorted_new[40].rc) ) ;
bus_mod_rc45 := __common__( if(do_new_sort,rc_dataset_s2_sorted_new[40].rc,rc_dataset_s2_sorted_new[41].rc) ) ;
bus_mod_rc46 := __common__( if(do_new_sort,rc_dataset_s2_sorted_new[41].rc,rc_dataset_s2_sorted_new[42].rc) ) ;
bus_mod_rc47 := __common__( if(do_new_sort,rc_dataset_s2_sorted_new[42].rc,rc_dataset_s2_sorted_new[43].rc) ) ;
bus_mod_rc48 := __common__( if(do_new_sort,rc_dataset_s2_sorted_new[43].rc,rc_dataset_s2_sorted_new[44].rc) ) ;
bus_mod_rc49 := __common__( if(do_new_sort,rc_dataset_s2_sorted_new[44].rc,rc_dataset_s2_sorted_new[45].rc) ) ;
bus_mod_rc50 := __common__( if(do_new_sort,rc_dataset_s2_sorted_new[45].rc,rc_dataset_s2_sorted_new[46].rc) ) ;

slbb_rc1_1 := __common__( bus_mod_rc1 ) ;

slbb_rc2_1 := __common__( bus_mod_rc2 ) ;

slbb_rc3_1 := __common__( bus_mod_rc3 ) ;

slbb_rc4_1 := __common__( bus_mod_rc4 ) ;

slbb_rc2 := __common__( if(SLBB1809_0_0 >= 870, '', slbb_rc2_1) ) ;

slbb_rc3 := __common__( if(SLBB1809_0_0 >= 870, '', slbb_rc3_1) ) ;

slbb_rc1 := __common__( if(SLBB1809_0_0 >= 870, '', slbb_rc1_1) ) ;

slbb_rc4 := __common__( if(SLBB1809_0_0 >= 870, '', slbb_rc4_1) ) ;

//*************************************************************************************//
//                      Reason Code Overrides 
//*************************************************************************************//
HRILayout := RECORD
	STRING5 HRI := '';
END;

reasons := DATASET([{slbb_rc1}, {slbb_rc2}, {slbb_rc3}, {slbb_rc4}], HRILayout);

zeros := DATASET([{'00'}, {'00'}, {'00'}, {'00'}], HRILayout);
reasonCodes := CHOOSEN(reasons & zeros, 4); // Keep up to 4 reason codes

	#if(MODEL_DEBUG)
   self.sysdate                          := sysdate;
                    self._ver_src_id_fsrc_fdate           := _ver_src_id_fsrc_fdate;
                    self._ver_src_id_fsrc_fdate2          := _ver_src_id_fsrc_fdate2;
                    self.yr__ver_src_id_fsrc_fdate        := yr__ver_src_id_fsrc_fdate;
                    self.mth__ver_src_id_fsrc_fdate       := mth__ver_src_id_fsrc_fdate;
                    self._ver_src_id_br_pos               := _ver_src_id_br_pos;
                    self._ver_src_id__br                  := _ver_src_id__br;
                    self._ver_src_id_fdate_br             := _ver_src_id_fdate_br;
                    self._ver_src_id_fdate_br2            := _ver_src_id_fdate_br2;
                    self.yr__ver_src_id_fdate_br          := yr__ver_src_id_fdate_br;
                    self.mth__ver_src_id_fdate_br         := mth__ver_src_id_fdate_br;
                    self._ver_src_id_ldate_br             := _ver_src_id_ldate_br;
                    self._ver_src_id_ldate_br2            := _ver_src_id_ldate_br2;
                    self.yr__ver_src_id_ldate_br          := yr__ver_src_id_ldate_br;
                    self.mth__ver_src_id_ldate_br         := mth__ver_src_id_ldate_br;
                    self._ver_src_id_c_pos                := _ver_src_id_c_pos;
                    self._ver_src_id__c                   := _ver_src_id__c;
                    self._ver_src_id_fdate_c              := _ver_src_id_fdate_c;
                    self._ver_src_id_fdate_c2             := _ver_src_id_fdate_c2;
                    self.yr__ver_src_id_fdate_c           := yr__ver_src_id_fdate_c;
                    self.mth__ver_src_id_fdate_c          := mth__ver_src_id_fdate_c;
                    self._ver_src_id_ldate_c              := _ver_src_id_ldate_c;
                    self._ver_src_id_ldate_c2             := _ver_src_id_ldate_c2;
                    self.yr__ver_src_id_ldate_c           := yr__ver_src_id_ldate_c;
                    self.mth__ver_src_id_ldate_c          := mth__ver_src_id_ldate_c;
                    self._ver_src_id_d_pos                := _ver_src_id_d_pos;
                    self._ver_src_id__d                   := _ver_src_id__d;
                    self._ver_src_id_fdate_d              := _ver_src_id_fdate_d;
                    self._ver_src_id_fdate_d2             := _ver_src_id_fdate_d2;
                    self.yr__ver_src_id_fdate_d           := yr__ver_src_id_fdate_d;
                    self.mth__ver_src_id_fdate_d          := mth__ver_src_id_fdate_d;
                    self._ver_src_id_ldate_d              := _ver_src_id_ldate_d;
                    self._ver_src_id_ldate_d2             := _ver_src_id_ldate_d2;
                    self.yr__ver_src_id_ldate_d           := yr__ver_src_id_ldate_d;
                    self.mth__ver_src_id_ldate_d          := mth__ver_src_id_ldate_d;
                    self._ver_src_id_df_pos               := _ver_src_id_df_pos;
                    self._ver_src_id__df                  := _ver_src_id__df;
                    self._ver_src_id_fdate_df             := _ver_src_id_fdate_df;
                    self._ver_src_id_fdate_df2            := _ver_src_id_fdate_df2;
                    self.yr__ver_src_id_fdate_df          := yr__ver_src_id_fdate_df;
                    self.mth__ver_src_id_fdate_df         := mth__ver_src_id_fdate_df;
                    self._ver_src_id_ldate_df             := _ver_src_id_ldate_df;
                    self._ver_src_id_ldate_df2            := _ver_src_id_ldate_df2;
                    self.yr__ver_src_id_ldate_df          := yr__ver_src_id_ldate_df;
                    self.mth__ver_src_id_ldate_df         := mth__ver_src_id_ldate_df;
                    self._ver_src_id_dn_pos               := _ver_src_id_dn_pos;
                    self._ver_src_id__dn                  := _ver_src_id__dn;
                    self._ver_src_id_fdate_dn             := _ver_src_id_fdate_dn;
                    self._ver_src_id_fdate_dn2            := _ver_src_id_fdate_dn2;
                    self.yr__ver_src_id_fdate_dn          := yr__ver_src_id_fdate_dn;
                    self.mth__ver_src_id_fdate_dn         := mth__ver_src_id_fdate_dn;
                    self._ver_src_id_ldate_dn             := _ver_src_id_ldate_dn;
                    self._ver_src_id_ldate_dn2            := _ver_src_id_ldate_dn2;
                    self.yr__ver_src_id_ldate_dn          := yr__ver_src_id_ldate_dn;
                    self.mth__ver_src_id_ldate_dn         := mth__ver_src_id_ldate_dn;
                    self._ver_src_id_fb_pos               := _ver_src_id_fb_pos;
                    self._ver_src_id__fb                  := _ver_src_id__fb;
                    self._ver_src_id_fdate_fb             := _ver_src_id_fdate_fb;
                    self._ver_src_id_fdate_fb2            := _ver_src_id_fdate_fb2;
                    self.yr__ver_src_id_fdate_fb          := yr__ver_src_id_fdate_fb;
                    self.mth__ver_src_id_fdate_fb         := mth__ver_src_id_fdate_fb;
                    self._ver_src_id_ldate_fb             := _ver_src_id_ldate_fb;
                    self._ver_src_id_ldate_fb2            := _ver_src_id_ldate_fb2;
                    self.yr__ver_src_id_ldate_fb          := yr__ver_src_id_ldate_fb;
                    self.mth__ver_src_id_ldate_fb         := mth__ver_src_id_ldate_fb;
                    self._ver_src_id_l0_pos               := _ver_src_id_l0_pos;
                    self._ver_src_id__l0                  := _ver_src_id__l0;
                    self._ver_src_id_fdate_l0             := _ver_src_id_fdate_l0;
                    self._ver_src_id_fdate_l02            := _ver_src_id_fdate_l02;
                    self.yr__ver_src_id_fdate_l0          := yr__ver_src_id_fdate_l0;
                    self.mth__ver_src_id_fdate_l0         := mth__ver_src_id_fdate_l0;
                    self._ver_src_id_ldate_l0             := _ver_src_id_ldate_l0;
                    self._ver_src_id_ldate_l02            := _ver_src_id_ldate_l02;
                    self.yr__ver_src_id_ldate_l0          := yr__ver_src_id_ldate_l0;
                    self.mth__ver_src_id_ldate_l0         := mth__ver_src_id_ldate_l0;
                    self._ver_src_id_l2_pos               := _ver_src_id_l2_pos;
                    self._ver_src_id__l2                  := _ver_src_id__l2;
                    self._ver_src_id_fdate_l2             := _ver_src_id_fdate_l2;
                    self._ver_src_id_fdate_l22            := _ver_src_id_fdate_l22;
                    self.yr__ver_src_id_fdate_l2          := yr__ver_src_id_fdate_l2;
                    self.mth__ver_src_id_fdate_l2         := mth__ver_src_id_fdate_l2;
                    self._ver_src_id_ldate_l2             := _ver_src_id_ldate_l2;
                    self._ver_src_id_ldate_l22            := _ver_src_id_ldate_l22;
                    self.yr__ver_src_id_ldate_l2          := yr__ver_src_id_ldate_l2;
                    self.mth__ver_src_id_ldate_l2         := mth__ver_src_id_ldate_l2;
                    self._ver_src_id_u2_pos               := _ver_src_id_u2_pos;
                    self._ver_src_id__u2                  := _ver_src_id__u2;
                    self._ver_src_id_fdate_u2             := _ver_src_id_fdate_u2;
                    self._ver_src_id_fdate_u22            := _ver_src_id_fdate_u22;
                    self.yr__ver_src_id_fdate_u2          := yr__ver_src_id_fdate_u2;
                    self.mth__ver_src_id_fdate_u2         := mth__ver_src_id_fdate_u2;
                    self._ver_src_id_ldate_u2             := _ver_src_id_ldate_u2;
                    self._ver_src_id_ldate_u22            := _ver_src_id_ldate_u22;
                    self.yr__ver_src_id_ldate_u2          := yr__ver_src_id_ldate_u2;
                    self.mth__ver_src_id_ldate_u2         := mth__ver_src_id_ldate_u2;
                    self._ver_src_id_ar_pos               := _ver_src_id_ar_pos;
                    self._ver_src_id__ar                  := _ver_src_id__ar;
                    self._ver_src_id_fdate_ar             := _ver_src_id_fdate_ar;
                    self._ver_src_id_fdate_ar2            := _ver_src_id_fdate_ar2;
                    self.yr__ver_src_id_fdate_ar          := yr__ver_src_id_fdate_ar;
                    self.mth__ver_src_id_fdate_ar         := mth__ver_src_id_fdate_ar;
                    self._ver_src_id_ldate_ar             := _ver_src_id_ldate_ar;
                    self._ver_src_id_ldate_ar2            := _ver_src_id_ldate_ar2;
                    self.yr__ver_src_id_ldate_ar          := yr__ver_src_id_ldate_ar;
                    self.mth__ver_src_id_ldate_ar         := mth__ver_src_id_ldate_ar;
                    self._ver_src_id_ba_pos               := _ver_src_id_ba_pos;
                    self._ver_src_id__ba                  := _ver_src_id__ba;
                    self._ver_src_id_fdate_ba             := _ver_src_id_fdate_ba;
                    self._ver_src_id_fdate_ba2            := _ver_src_id_fdate_ba2;
                    self.yr__ver_src_id_fdate_ba          := yr__ver_src_id_fdate_ba;
                    self.mth__ver_src_id_fdate_ba         := mth__ver_src_id_fdate_ba;
                    self._ver_src_id_ldate_ba             := _ver_src_id_ldate_ba;
                    self._ver_src_id_ldate_ba2            := _ver_src_id_ldate_ba2;
                    self.yr__ver_src_id_ldate_ba          := yr__ver_src_id_ldate_ba;
                    self.mth__ver_src_id_ldate_ba         := mth__ver_src_id_ldate_ba;
                    self._ver_src_id_bm_pos               := _ver_src_id_bm_pos;
                    self._ver_src_id__bm                  := _ver_src_id__bm;
                    self._ver_src_id_fdate_bm             := _ver_src_id_fdate_bm;
                    self._ver_src_id_fdate_bm2            := _ver_src_id_fdate_bm2;
                    self.yr__ver_src_id_fdate_bm          := yr__ver_src_id_fdate_bm;
                    self.mth__ver_src_id_fdate_bm         := mth__ver_src_id_fdate_bm;
                    self._ver_src_id_ldate_bm             := _ver_src_id_ldate_bm;
                    self._ver_src_id_ldate_bm2            := _ver_src_id_ldate_bm2;
                    self.yr__ver_src_id_ldate_bm          := yr__ver_src_id_ldate_bm;
                    self.mth__ver_src_id_ldate_bm         := mth__ver_src_id_ldate_bm;
                    self._ver_src_id_bn_pos               := _ver_src_id_bn_pos;
                    self._ver_src_id__bn                  := _ver_src_id__bn;
                    self._ver_src_id_fdate_bn             := _ver_src_id_fdate_bn;
                    self._ver_src_id_fdate_bn2            := _ver_src_id_fdate_bn2;
                    self.yr__ver_src_id_fdate_bn          := yr__ver_src_id_fdate_bn;
                    self.mth__ver_src_id_fdate_bn         := mth__ver_src_id_fdate_bn;
                    self._ver_src_id_ldate_bn             := _ver_src_id_ldate_bn;
                    self._ver_src_id_ldate_bn2            := _ver_src_id_ldate_bn2;
                    self.yr__ver_src_id_ldate_bn          := yr__ver_src_id_ldate_bn;
                    self.mth__ver_src_id_ldate_bn         := mth__ver_src_id_ldate_bn;
                    self._ver_src_id_cu_pos               := _ver_src_id_cu_pos;
                    self._ver_src_id__cu                  := _ver_src_id__cu;
                    self._ver_src_id_fdate_cu             := _ver_src_id_fdate_cu;
                    self._ver_src_id_fdate_cu2            := _ver_src_id_fdate_cu2;
                    self.yr__ver_src_id_fdate_cu          := yr__ver_src_id_fdate_cu;
                    self.mth__ver_src_id_fdate_cu         := mth__ver_src_id_fdate_cu;
                    self._ver_src_id_ldate_cu             := _ver_src_id_ldate_cu;
                    self._ver_src_id_ldate_cu2            := _ver_src_id_ldate_cu2;
                    self.yr__ver_src_id_ldate_cu          := yr__ver_src_id_ldate_cu;
                    self.mth__ver_src_id_ldate_cu         := mth__ver_src_id_ldate_cu;
                    self._ver_src_id_da_pos               := _ver_src_id_da_pos;
                    self._ver_src_id__da                  := _ver_src_id__da;
                    self._ver_src_id_fdate_da             := _ver_src_id_fdate_da;
                    self._ver_src_id_fdate_da2            := _ver_src_id_fdate_da2;
                    self.yr__ver_src_id_fdate_da          := yr__ver_src_id_fdate_da;
                    self.mth__ver_src_id_fdate_da         := mth__ver_src_id_fdate_da;
                    self._ver_src_id_ldate_da             := _ver_src_id_ldate_da;
                    self._ver_src_id_ldate_da2            := _ver_src_id_ldate_da2;
                    self.yr__ver_src_id_ldate_da          := yr__ver_src_id_ldate_da;
                    self.mth__ver_src_id_ldate_da         := mth__ver_src_id_ldate_da;
                    self._ver_src_id_ef_pos               := _ver_src_id_ef_pos;
                    self._ver_src_id__ef                  := _ver_src_id__ef;
                    self._ver_src_id_fdate_ef             := _ver_src_id_fdate_ef;
                    self._ver_src_id_fdate_ef2            := _ver_src_id_fdate_ef2;
                    self.yr__ver_src_id_fdate_ef          := yr__ver_src_id_fdate_ef;
                    self.mth__ver_src_id_fdate_ef         := mth__ver_src_id_fdate_ef;
                    self._ver_src_id_ldate_ef             := _ver_src_id_ldate_ef;
                    self._ver_src_id_ldate_ef2            := _ver_src_id_ldate_ef2;
                    self.yr__ver_src_id_ldate_ef          := yr__ver_src_id_ldate_ef;
                    self.mth__ver_src_id_ldate_ef         := mth__ver_src_id_ldate_ef;
                    self._ver_src_id_fi_pos               := _ver_src_id_fi_pos;
                    self._ver_src_id__fi                  := _ver_src_id__fi;
                    self._ver_src_id_fdate_fi             := _ver_src_id_fdate_fi;
                    self._ver_src_id_fdate_fi2            := _ver_src_id_fdate_fi2;
                    self.yr__ver_src_id_fdate_fi          := yr__ver_src_id_fdate_fi;
                    self.mth__ver_src_id_fdate_fi         := mth__ver_src_id_fdate_fi;
                    self._ver_src_id_ldate_fi             := _ver_src_id_ldate_fi;
                    self._ver_src_id_ldate_fi2            := _ver_src_id_ldate_fi2;
                    self.yr__ver_src_id_ldate_fi          := yr__ver_src_id_ldate_fi;
                    self.mth__ver_src_id_ldate_fi         := mth__ver_src_id_ldate_fi;
                    self._ver_src_id_i_pos                := _ver_src_id_i_pos;
                    self._ver_src_id__i                   := _ver_src_id__i;
                    self._ver_src_id_fdate_i              := _ver_src_id_fdate_i;
                    self._ver_src_id_fdate_i2             := _ver_src_id_fdate_i2;
                    self.yr__ver_src_id_fdate_i           := yr__ver_src_id_fdate_i;
                    self.mth__ver_src_id_fdate_i          := mth__ver_src_id_fdate_i;
                    self._ver_src_id_ldate_i              := _ver_src_id_ldate_i;
                    self._ver_src_id_ldate_i2             := _ver_src_id_ldate_i2;
                    self.yr__ver_src_id_ldate_i           := yr__ver_src_id_ldate_i;
                    self.mth__ver_src_id_ldate_i          := mth__ver_src_id_ldate_i;
                    self._ver_src_id_ia_pos               := _ver_src_id_ia_pos;
                    self._ver_src_id__ia                  := _ver_src_id__ia;
                    self._ver_src_id_fdate_ia             := _ver_src_id_fdate_ia;
                    self._ver_src_id_fdate_ia2            := _ver_src_id_fdate_ia2;
                    self.yr__ver_src_id_fdate_ia          := yr__ver_src_id_fdate_ia;
                    self.mth__ver_src_id_fdate_ia         := mth__ver_src_id_fdate_ia;
                    self._ver_src_id_ldate_ia             := _ver_src_id_ldate_ia;
                    self._ver_src_id_ldate_ia2            := _ver_src_id_ldate_ia2;
                    self.yr__ver_src_id_ldate_ia          := yr__ver_src_id_ldate_ia;
                    self.mth__ver_src_id_ldate_ia         := mth__ver_src_id_ldate_ia;
                    self._ver_src_id_in_pos               := _ver_src_id_in_pos;
                    self._ver_src_id__in                  := _ver_src_id__in;
                    self._ver_src_id_fdate_in             := _ver_src_id_fdate_in;
                    self._ver_src_id_fdate_in2            := _ver_src_id_fdate_in2;
                    self.yr__ver_src_id_fdate_in          := yr__ver_src_id_fdate_in;
                    self.mth__ver_src_id_fdate_in         := mth__ver_src_id_fdate_in;
                    self._ver_src_id_ldate_in             := _ver_src_id_ldate_in;
                    self._ver_src_id_ldate_in2            := _ver_src_id_ldate_in2;
                    self.yr__ver_src_id_ldate_in          := yr__ver_src_id_ldate_in;
                    self.mth__ver_src_id_ldate_in         := mth__ver_src_id_ldate_in;
                    self._ver_src_id_os_pos               := _ver_src_id_os_pos;
                    self._ver_src_id__os                  := _ver_src_id__os;
                    self._ver_src_id_fdate_os             := _ver_src_id_fdate_os;
                    self._ver_src_id_fdate_os2            := _ver_src_id_fdate_os2;
                    self.yr__ver_src_id_fdate_os          := yr__ver_src_id_fdate_os;
                    self.mth__ver_src_id_fdate_os         := mth__ver_src_id_fdate_os;
                    self._ver_src_id_ldate_os             := _ver_src_id_ldate_os;
                    self._ver_src_id_ldate_os2            := _ver_src_id_ldate_os2;
                    self.yr__ver_src_id_ldate_os          := yr__ver_src_id_ldate_os;
                    self.mth__ver_src_id_ldate_os         := mth__ver_src_id_ldate_os;
                    self._ver_src_id_p_pos                := _ver_src_id_p_pos;
                    self._ver_src_id__p                   := _ver_src_id__p;
                    self._ver_src_id_fdate_p              := _ver_src_id_fdate_p;
                    self._ver_src_id_fdate_p2             := _ver_src_id_fdate_p2;
                    self.yr__ver_src_id_fdate_p           := yr__ver_src_id_fdate_p;
                    self.mth__ver_src_id_fdate_p          := mth__ver_src_id_fdate_p;
                    self._ver_src_id_ldate_p              := _ver_src_id_ldate_p;
                    self._ver_src_id_ldate_p2             := _ver_src_id_ldate_p2;
                    self.yr__ver_src_id_ldate_p           := yr__ver_src_id_ldate_p;
                    self.mth__ver_src_id_ldate_p          := mth__ver_src_id_ldate_p;
                    self._ver_src_id_pl_pos               := _ver_src_id_pl_pos;
                    self._ver_src_id__pl                  := _ver_src_id__pl;
                    self._ver_src_id_fdate_pl             := _ver_src_id_fdate_pl;
                    self._ver_src_id_fdate_pl2            := _ver_src_id_fdate_pl2;
                    self.yr__ver_src_id_fdate_pl          := yr__ver_src_id_fdate_pl;
                    self.mth__ver_src_id_fdate_pl         := mth__ver_src_id_fdate_pl;
                    self._ver_src_id_ldate_pl             := _ver_src_id_ldate_pl;
                    self._ver_src_id_ldate_pl2            := _ver_src_id_ldate_pl2;
                    self.yr__ver_src_id_ldate_pl          := yr__ver_src_id_ldate_pl;
                    self.mth__ver_src_id_ldate_pl         := mth__ver_src_id_ldate_pl;
                    self._ver_src_id_q3_pos               := _ver_src_id_q3_pos;
                    self._ver_src_id__q3                  := _ver_src_id__q3;
                    self._ver_src_id_fdate_q3             := _ver_src_id_fdate_q3;
                    self._ver_src_id_fdate_q32            := _ver_src_id_fdate_q32;
                    self.yr__ver_src_id_fdate_q3          := yr__ver_src_id_fdate_q3;
                    self.mth__ver_src_id_fdate_q3         := mth__ver_src_id_fdate_q3;
                    self._ver_src_id_ldate_q3             := _ver_src_id_ldate_q3;
                    self._ver_src_id_ldate_q32            := _ver_src_id_ldate_q32;
                    self.yr__ver_src_id_ldate_q3          := yr__ver_src_id_ldate_q3;
                    self.mth__ver_src_id_ldate_q3         := mth__ver_src_id_ldate_q3;
                    self._ver_src_id_sk_pos               := _ver_src_id_sk_pos;
                    self._ver_src_id__sk                  := _ver_src_id__sk;
                    self._ver_src_id_fdate_sk             := _ver_src_id_fdate_sk;
                    self._ver_src_id_fdate_sk2            := _ver_src_id_fdate_sk2;
                    self.yr__ver_src_id_fdate_sk          := yr__ver_src_id_fdate_sk;
                    self.mth__ver_src_id_fdate_sk         := mth__ver_src_id_fdate_sk;
                    self._ver_src_id_ldate_sk             := _ver_src_id_ldate_sk;
                    self._ver_src_id_ldate_sk2            := _ver_src_id_ldate_sk2;
                    self.yr__ver_src_id_ldate_sk          := yr__ver_src_id_ldate_sk;
                    self.mth__ver_src_id_ldate_sk         := mth__ver_src_id_ldate_sk;
                    self._ver_src_id_tx_pos               := _ver_src_id_tx_pos;
                    self._ver_src_id__tx                  := _ver_src_id__tx;
                    self._ver_src_id_fdate_tx             := _ver_src_id_fdate_tx;
                    self._ver_src_id_fdate_tx2            := _ver_src_id_fdate_tx2;
                    self.yr__ver_src_id_fdate_tx          := yr__ver_src_id_fdate_tx;
                    self.mth__ver_src_id_fdate_tx         := mth__ver_src_id_fdate_tx;
                    self._ver_src_id_ldate_tx             := _ver_src_id_ldate_tx;
                    self._ver_src_id_ldate_tx2            := _ver_src_id_ldate_tx2;
                    self.yr__ver_src_id_ldate_tx          := yr__ver_src_id_ldate_tx;
                    self.mth__ver_src_id_ldate_tx         := mth__ver_src_id_ldate_tx;
                    self._ver_src_id_v2_pos               := _ver_src_id_v2_pos;
                    self._ver_src_id__v2                  := _ver_src_id__v2;
                    self._ver_src_id_fdate_v22            := _ver_src_id_fdate_v22;
                    self.yr__ver_src_id_fdate_v2          := yr__ver_src_id_fdate_v2;
                    self.mth__ver_src_id_fdate_v2         := mth__ver_src_id_fdate_v2;
                    self._ver_src_id_ldate_v22            := _ver_src_id_ldate_v22;
                    self.yr__ver_src_id_ldate_v2          := yr__ver_src_id_ldate_v2;
                    self.mth__ver_src_id_ldate_v2         := mth__ver_src_id_ldate_v2;
                    self._ver_src_id_wa_pos               := _ver_src_id_wa_pos;
                    self._ver_src_id__wa                  := _ver_src_id__wa;
                    self._ver_src_id_fdate_wa             := _ver_src_id_fdate_wa;
                    self._ver_src_id_fdate_wa2            := _ver_src_id_fdate_wa2;
                    self.yr__ver_src_id_fdate_wa          := yr__ver_src_id_fdate_wa;
                    self.mth__ver_src_id_fdate_wa         := mth__ver_src_id_fdate_wa;
                    self._ver_src_id_ldate_wa             := _ver_src_id_ldate_wa;
                    self._ver_src_id_ldate_wa2            := _ver_src_id_ldate_wa2;
                    self.yr__ver_src_id_ldate_wa          := yr__ver_src_id_ldate_wa;
                    self.mth__ver_src_id_ldate_wa         := mth__ver_src_id_ldate_wa;
                    self._ver_src_id_by_pos               := _ver_src_id_by_pos;
                    self._ver_src_id__by                  := _ver_src_id__by;
                    self._ver_src_id_fdate_by             := _ver_src_id_fdate_by;
                    self._ver_src_id_fdate_by2            := _ver_src_id_fdate_by2;
                    self.yr__ver_src_id_fdate_by          := yr__ver_src_id_fdate_by;
                    self.mth__ver_src_id_fdate_by         := mth__ver_src_id_fdate_by;
                    self._ver_src_id_ldate_by             := _ver_src_id_ldate_by;
                    self._ver_src_id_ldate_by2            := _ver_src_id_ldate_by2;
                    self.yr__ver_src_id_ldate_by          := yr__ver_src_id_ldate_by;
                    self.mth__ver_src_id_ldate_by         := mth__ver_src_id_ldate_by;
                    self._ver_src_id_cf_pos               := _ver_src_id_cf_pos;
                    self._ver_src_id__cf                  := _ver_src_id__cf;
                    self._ver_src_id_fdate_cf             := _ver_src_id_fdate_cf;
                    self._ver_src_id_fdate_cf2            := _ver_src_id_fdate_cf2;
                    self.yr__ver_src_id_fdate_cf          := yr__ver_src_id_fdate_cf;
                    self.mth__ver_src_id_fdate_cf         := mth__ver_src_id_fdate_cf;
                    self._ver_src_id_ldate_cf             := _ver_src_id_ldate_cf;
                    self._ver_src_id_ldate_cf2            := _ver_src_id_ldate_cf2;
                    self.yr__ver_src_id_ldate_cf          := yr__ver_src_id_ldate_cf;
                    self.mth__ver_src_id_ldate_cf         := mth__ver_src_id_ldate_cf;
                    self._ver_src_id_e_pos                := _ver_src_id_e_pos;
                    self._ver_src_id__e                   := _ver_src_id__e;
                    self._ver_src_id_fdate_e              := _ver_src_id_fdate_e;
                    self._ver_src_id_fdate_e2             := _ver_src_id_fdate_e2;
                    self.yr__ver_src_id_fdate_e           := yr__ver_src_id_fdate_e;
                    self.mth__ver_src_id_fdate_e          := mth__ver_src_id_fdate_e;
                    self._ver_src_id_ldate_e              := _ver_src_id_ldate_e;
                    self._ver_src_id_ldate_e2             := _ver_src_id_ldate_e2;
                    self.yr__ver_src_id_ldate_e           := yr__ver_src_id_ldate_e;
                    self.mth__ver_src_id_ldate_e          := mth__ver_src_id_ldate_e;
                    self._ver_src_id_ey_pos               := _ver_src_id_ey_pos;
                    self._ver_src_id__ey                  := _ver_src_id__ey;
                    self._ver_src_id_fdate_ey             := _ver_src_id_fdate_ey;
                    self._ver_src_id_fdate_ey2            := _ver_src_id_fdate_ey2;
                    self.yr__ver_src_id_fdate_ey          := yr__ver_src_id_fdate_ey;
                    self.mth__ver_src_id_fdate_ey         := mth__ver_src_id_fdate_ey;
                    self._ver_src_id_ldate_ey             := _ver_src_id_ldate_ey;
                    self._ver_src_id_ldate_ey2            := _ver_src_id_ldate_ey2;
                    self.yr__ver_src_id_ldate_ey          := yr__ver_src_id_ldate_ey;
                    self.mth__ver_src_id_ldate_ey         := mth__ver_src_id_ldate_ey;
                    self._ver_src_id_f_pos                := _ver_src_id_f_pos;
                    self._ver_src_id__f                   := _ver_src_id__f;
                    self._ver_src_id_fdate_f              := _ver_src_id_fdate_f;
                    self._ver_src_id_fdate_f2             := _ver_src_id_fdate_f2;
                    self.yr__ver_src_id_fdate_f           := yr__ver_src_id_fdate_f;
                    self.mth__ver_src_id_fdate_f          := mth__ver_src_id_fdate_f;
                    self._ver_src_id_ldate_f              := _ver_src_id_ldate_f;
                    self._ver_src_id_ldate_f2             := _ver_src_id_ldate_f2;
                    self.yr__ver_src_id_ldate_f           := yr__ver_src_id_ldate_f;
                    self.mth__ver_src_id_ldate_f          := mth__ver_src_id_ldate_f;
                    self._ver_src_id_fk_pos               := _ver_src_id_fk_pos;
                    self._ver_src_id__fk                  := _ver_src_id__fk;
                    self._ver_src_id_fdate_fk             := _ver_src_id_fdate_fk;
                    self._ver_src_id_fdate_fk2            := _ver_src_id_fdate_fk2;
                    self.yr__ver_src_id_fdate_fk          := yr__ver_src_id_fdate_fk;
                    self.mth__ver_src_id_fdate_fk         := mth__ver_src_id_fdate_fk;
                    self._ver_src_id_ldate_fk             := _ver_src_id_ldate_fk;
                    self._ver_src_id_ldate_fk2            := _ver_src_id_ldate_fk2;
                    self.yr__ver_src_id_ldate_fk          := yr__ver_src_id_ldate_fk;
                    self.mth__ver_src_id_ldate_fk         := mth__ver_src_id_ldate_fk;
                    self._ver_src_id_fr_pos               := _ver_src_id_fr_pos;
                    self._ver_src_id__fr                  := _ver_src_id__fr;
                    self._ver_src_id_fdate_fr             := _ver_src_id_fdate_fr;
                    self._ver_src_id_fdate_fr2            := _ver_src_id_fdate_fr2;
                    self.yr__ver_src_id_fdate_fr          := yr__ver_src_id_fdate_fr;
                    self.mth__ver_src_id_fdate_fr         := mth__ver_src_id_fdate_fr;
                    self._ver_src_id_ldate_fr             := _ver_src_id_ldate_fr;
                    self._ver_src_id_ldate_fr2            := _ver_src_id_ldate_fr2;
                    self.yr__ver_src_id_ldate_fr          := yr__ver_src_id_ldate_fr;
                    self.mth__ver_src_id_ldate_fr         := mth__ver_src_id_ldate_fr;
                    self._ver_src_id_ft_pos               := _ver_src_id_ft_pos;
                    self._ver_src_id__ft                  := _ver_src_id__ft;
                    self._ver_src_id_fdate_ft             := _ver_src_id_fdate_ft;
                    self._ver_src_id_fdate_ft2            := _ver_src_id_fdate_ft2;
                    self.yr__ver_src_id_fdate_ft          := yr__ver_src_id_fdate_ft;
                    self.mth__ver_src_id_fdate_ft         := mth__ver_src_id_fdate_ft;
                    self._ver_src_id_ldate_ft             := _ver_src_id_ldate_ft;
                    self._ver_src_id_ldate_ft2            := _ver_src_id_ldate_ft2;
                    self.yr__ver_src_id_ldate_ft          := yr__ver_src_id_ldate_ft;
                    self.mth__ver_src_id_ldate_ft         := mth__ver_src_id_ldate_ft;
                    self._ver_src_id_gr_pos               := _ver_src_id_gr_pos;
                    self._ver_src_id__gr                  := _ver_src_id__gr;
                    self._ver_src_id_fdate_gr             := _ver_src_id_fdate_gr;
                    self._ver_src_id_fdate_gr2            := _ver_src_id_fdate_gr2;
                    self.yr__ver_src_id_fdate_gr          := yr__ver_src_id_fdate_gr;
                    self.mth__ver_src_id_fdate_gr         := mth__ver_src_id_fdate_gr;
                    self._ver_src_id_ldate_gr             := _ver_src_id_ldate_gr;
                    self._ver_src_id_ldate_gr2            := _ver_src_id_ldate_gr2;
                    self.yr__ver_src_id_ldate_gr          := yr__ver_src_id_ldate_gr;
                    self.mth__ver_src_id_ldate_gr         := mth__ver_src_id_ldate_gr;
                    self._ver_src_id_h7_pos               := _ver_src_id_h7_pos;
                    self._ver_src_id__h7                  := _ver_src_id__h7;
                    self._ver_src_id_fdate_h7             := _ver_src_id_fdate_h7;
                    self._ver_src_id_fdate_h72            := _ver_src_id_fdate_h72;
                    self.yr__ver_src_id_fdate_h7          := yr__ver_src_id_fdate_h7;
                    self.mth__ver_src_id_fdate_h7         := mth__ver_src_id_fdate_h7;
                    self._ver_src_id_ldate_h7             := _ver_src_id_ldate_h7;
                    self._ver_src_id_ldate_h72            := _ver_src_id_ldate_h72;
                    self.yr__ver_src_id_ldate_h7          := yr__ver_src_id_ldate_h7;
                    self.mth__ver_src_id_ldate_h7         := mth__ver_src_id_ldate_h7;
                    self._ver_src_id_ic_pos               := _ver_src_id_ic_pos;
                    self._ver_src_id__ic                  := _ver_src_id__ic;
                    self._ver_src_id_fdate_ic             := _ver_src_id_fdate_ic;
                    self._ver_src_id_fdate_ic2            := _ver_src_id_fdate_ic2;
                    self.yr__ver_src_id_fdate_ic          := yr__ver_src_id_fdate_ic;
                    self.mth__ver_src_id_fdate_ic         := mth__ver_src_id_fdate_ic;
                    self._ver_src_id_ldate_ic             := _ver_src_id_ldate_ic;
                    self._ver_src_id_ldate_ic2            := _ver_src_id_ldate_ic2;
                    self.yr__ver_src_id_ldate_ic          := yr__ver_src_id_ldate_ic;
                    self.mth__ver_src_id_ldate_ic         := mth__ver_src_id_ldate_ic;
                    self._ver_src_id_ip_pos               := _ver_src_id_ip_pos;
                    self._ver_src_id__ip                  := _ver_src_id__ip;
                    self._ver_src_id_fdate_ip             := _ver_src_id_fdate_ip;
                    self._ver_src_id_fdate_ip2            := _ver_src_id_fdate_ip2;
                    self.yr__ver_src_id_fdate_ip          := yr__ver_src_id_fdate_ip;
                    self.mth__ver_src_id_fdate_ip         := mth__ver_src_id_fdate_ip;
                    self._ver_src_id_ldate_ip             := _ver_src_id_ldate_ip;
                    self._ver_src_id_ldate_ip2            := _ver_src_id_ldate_ip2;
                    self.yr__ver_src_id_ldate_ip          := yr__ver_src_id_ldate_ip;
                    self.mth__ver_src_id_ldate_ip         := mth__ver_src_id_ldate_ip;
                    self._ver_src_id_is_pos               := _ver_src_id_is_pos;
                    self._ver_src_id__is                  := _ver_src_id__is;
                    self._ver_src_id_fdate_is             := _ver_src_id_fdate_is;
                    self._ver_src_id_fdate_is2            := _ver_src_id_fdate_is2;
                    self.yr__ver_src_id_fdate_is          := yr__ver_src_id_fdate_is;
                    self.mth__ver_src_id_fdate_is         := mth__ver_src_id_fdate_is;
                    self._ver_src_id_ldate_is             := _ver_src_id_ldate_is;
                    self._ver_src_id_ldate_is2            := _ver_src_id_ldate_is2;
                    self.yr__ver_src_id_ldate_is          := yr__ver_src_id_ldate_is;
                    self.mth__ver_src_id_ldate_is         := mth__ver_src_id_ldate_is;
                    self._ver_src_id_it_pos               := _ver_src_id_it_pos;
                    self._ver_src_id__it                  := _ver_src_id__it;
                    self._ver_src_id_fdate_it             := _ver_src_id_fdate_it;
                    self._ver_src_id_fdate_it2            := _ver_src_id_fdate_it2;
                    self.yr__ver_src_id_fdate_it          := yr__ver_src_id_fdate_it;
                    self.mth__ver_src_id_fdate_it         := mth__ver_src_id_fdate_it;
                    self._ver_src_id_ldate_it             := _ver_src_id_ldate_it;
                    self._ver_src_id_ldate_it2            := _ver_src_id_ldate_it2;
                    self.yr__ver_src_id_ldate_it          := yr__ver_src_id_ldate_it;
                    self.mth__ver_src_id_ldate_it         := mth__ver_src_id_ldate_it;
                    self._ver_src_id_j2_pos               := _ver_src_id_j2_pos;
                    self._ver_src_id__j2                  := _ver_src_id__j2;
                    self._ver_src_id_fdate_j2             := _ver_src_id_fdate_j2;
                    self._ver_src_id_fdate_j22            := _ver_src_id_fdate_j22;
                    self.yr__ver_src_id_fdate_j2          := yr__ver_src_id_fdate_j2;
                    self.mth__ver_src_id_fdate_j2         := mth__ver_src_id_fdate_j2;
                    self._ver_src_id_ldate_j2             := _ver_src_id_ldate_j2;
                    self._ver_src_id_ldate_j22            := _ver_src_id_ldate_j22;
                    self.yr__ver_src_id_ldate_j2          := yr__ver_src_id_ldate_j2;
                    self.mth__ver_src_id_ldate_j2         := mth__ver_src_id_ldate_j2;
                    self._ver_src_id_kc_pos               := _ver_src_id_kc_pos;
                    self._ver_src_id__kc                  := _ver_src_id__kc;
                    self._ver_src_id_fdate_kc             := _ver_src_id_fdate_kc;
                    self._ver_src_id_fdate_kc2            := _ver_src_id_fdate_kc2;
                    self.yr__ver_src_id_fdate_kc          := yr__ver_src_id_fdate_kc;
                    self.mth__ver_src_id_fdate_kc         := mth__ver_src_id_fdate_kc;
                    self._ver_src_id_ldate_kc             := _ver_src_id_ldate_kc;
                    self._ver_src_id_ldate_kc2            := _ver_src_id_ldate_kc2;
                    self.yr__ver_src_id_ldate_kc          := yr__ver_src_id_ldate_kc;
                    self.mth__ver_src_id_ldate_kc         := mth__ver_src_id_ldate_kc;
                    self._ver_src_id_mh_pos               := _ver_src_id_mh_pos;
                    self._ver_src_id__mh                  := _ver_src_id__mh;
                    self._ver_src_id_fdate_mh             := _ver_src_id_fdate_mh;
                    self._ver_src_id_fdate_mh2            := _ver_src_id_fdate_mh2;
                    self.yr__ver_src_id_fdate_mh          := yr__ver_src_id_fdate_mh;
                    self.mth__ver_src_id_fdate_mh         := mth__ver_src_id_fdate_mh;
                    self._ver_src_id_ldate_mh             := _ver_src_id_ldate_mh;
                    self._ver_src_id_ldate_mh2            := _ver_src_id_ldate_mh2;
                    self.yr__ver_src_id_ldate_mh          := yr__ver_src_id_ldate_mh;
                    self.mth__ver_src_id_ldate_mh         := mth__ver_src_id_ldate_mh;
                    self._ver_src_id_mw_pos               := _ver_src_id_mw_pos;
                    self._ver_src_id__mw                  := _ver_src_id__mw;
                    self._ver_src_id_fdate_mw             := _ver_src_id_fdate_mw;
                    self._ver_src_id_fdate_mw2            := _ver_src_id_fdate_mw2;
                    self.yr__ver_src_id_fdate_mw          := yr__ver_src_id_fdate_mw;
                    self.mth__ver_src_id_fdate_mw         := mth__ver_src_id_fdate_mw;
                    self._ver_src_id_ldate_mw             := _ver_src_id_ldate_mw;
                    self._ver_src_id_ldate_mw2            := _ver_src_id_ldate_mw2;
                    self.yr__ver_src_id_ldate_mw          := yr__ver_src_id_ldate_mw;
                    self.mth__ver_src_id_ldate_mw         := mth__ver_src_id_ldate_mw;
                    self._ver_src_id_np_pos               := _ver_src_id_np_pos;
                    self._ver_src_id__np                  := _ver_src_id__np;
                    self._ver_src_id_fdate_np             := _ver_src_id_fdate_np;
                    self._ver_src_id_fdate_np2            := _ver_src_id_fdate_np2;
                    self.yr__ver_src_id_fdate_np          := yr__ver_src_id_fdate_np;
                    self.mth__ver_src_id_fdate_np         := mth__ver_src_id_fdate_np;
                    self._ver_src_id_ldate_np             := _ver_src_id_ldate_np;
                    self._ver_src_id_ldate_np2            := _ver_src_id_ldate_np2;
                    self.yr__ver_src_id_ldate_np          := yr__ver_src_id_ldate_np;
                    self.mth__ver_src_id_ldate_np         := mth__ver_src_id_ldate_np;
                    self._ver_src_id_nr_pos               := _ver_src_id_nr_pos;
                    self._ver_src_id__nr                  := _ver_src_id__nr;
                    self._ver_src_id_fdate_nr             := _ver_src_id_fdate_nr;
                    self._ver_src_id_fdate_nr2            := _ver_src_id_fdate_nr2;
                    self.yr__ver_src_id_fdate_nr          := yr__ver_src_id_fdate_nr;
                    self.mth__ver_src_id_fdate_nr         := mth__ver_src_id_fdate_nr;
                    self._ver_src_id_ldate_nr             := _ver_src_id_ldate_nr;
                    self._ver_src_id_ldate_nr2            := _ver_src_id_ldate_nr2;
                    self.yr__ver_src_id_ldate_nr          := yr__ver_src_id_ldate_nr;
                    self.mth__ver_src_id_ldate_nr         := mth__ver_src_id_ldate_nr;
                    self._ver_src_id_sa_pos               := _ver_src_id_sa_pos;
                    self._ver_src_id__sa                  := _ver_src_id__sa;
                    self._ver_src_id_fdate_sa             := _ver_src_id_fdate_sa;
                    self._ver_src_id_fdate_sa2            := _ver_src_id_fdate_sa2;
                    self.yr__ver_src_id_fdate_sa          := yr__ver_src_id_fdate_sa;
                    self.mth__ver_src_id_fdate_sa         := mth__ver_src_id_fdate_sa;
                    self._ver_src_id_ldate_sa             := _ver_src_id_ldate_sa;
                    self._ver_src_id_ldate_sa2            := _ver_src_id_ldate_sa2;
                    self.yr__ver_src_id_ldate_sa          := yr__ver_src_id_ldate_sa;
                    self.mth__ver_src_id_ldate_sa         := mth__ver_src_id_ldate_sa;
                    self._ver_src_id_sb_pos               := _ver_src_id_sb_pos;
                    self._ver_src_id__sb                  := _ver_src_id__sb;
                    self._ver_src_id_fdate_sb             := _ver_src_id_fdate_sb;
                    self._ver_src_id_fdate_sb2            := _ver_src_id_fdate_sb2;
                    self.yr__ver_src_id_fdate_sb          := yr__ver_src_id_fdate_sb;
                    self.mth__ver_src_id_fdate_sb         := mth__ver_src_id_fdate_sb;
                    self._ver_src_id_ldate_sb             := _ver_src_id_ldate_sb;
                    self._ver_src_id_ldate_sb2            := _ver_src_id_ldate_sb2;
                    self.yr__ver_src_id_ldate_sb          := yr__ver_src_id_ldate_sb;
                    self.mth__ver_src_id_ldate_sb         := mth__ver_src_id_ldate_sb;
                    self._ver_src_id_sg_pos               := _ver_src_id_sg_pos;
                    self._ver_src_id__sg                  := _ver_src_id__sg;
                    self._ver_src_id_fdate_sg             := _ver_src_id_fdate_sg;
                    self._ver_src_id_fdate_sg2            := _ver_src_id_fdate_sg2;
                    self.yr__ver_src_id_fdate_sg          := yr__ver_src_id_fdate_sg;
                    self.mth__ver_src_id_fdate_sg         := mth__ver_src_id_fdate_sg;
                    self._ver_src_id_ldate_sg             := _ver_src_id_ldate_sg;
                    self._ver_src_id_ldate_sg2            := _ver_src_id_ldate_sg2;
                    self.yr__ver_src_id_ldate_sg          := yr__ver_src_id_ldate_sg;
                    self.mth__ver_src_id_ldate_sg         := mth__ver_src_id_ldate_sg;
                    self._ver_src_id_sj_pos               := _ver_src_id_sj_pos;
                    self._ver_src_id__sj                  := _ver_src_id__sj;
                    self._ver_src_id_fdate_sj             := _ver_src_id_fdate_sj;
                    self._ver_src_id_fdate_sj2            := _ver_src_id_fdate_sj2;
                    self.yr__ver_src_id_fdate_sj          := yr__ver_src_id_fdate_sj;
                    self.mth__ver_src_id_fdate_sj         := mth__ver_src_id_fdate_sj;
                    self._ver_src_id_ldate_sj             := _ver_src_id_ldate_sj;
                    self._ver_src_id_ldate_sj2            := _ver_src_id_ldate_sj2;
                    self.yr__ver_src_id_ldate_sj          := yr__ver_src_id_ldate_sj;
                    self.mth__ver_src_id_ldate_sj         := mth__ver_src_id_ldate_sj;
                    self._ver_src_id_sp_pos               := _ver_src_id_sp_pos;
                    self._ver_src_id__sp                  := _ver_src_id__sp;
                    self._ver_src_id_fdate_sp             := _ver_src_id_fdate_sp;
                    self._ver_src_id_fdate_sp2            := _ver_src_id_fdate_sp2;
                    self.yr__ver_src_id_fdate_sp          := yr__ver_src_id_fdate_sp;
                    self.mth__ver_src_id_fdate_sp         := mth__ver_src_id_fdate_sp;
                    self._ver_src_id_ldate_sp             := _ver_src_id_ldate_sp;
                    self._ver_src_id_ldate_sp2            := _ver_src_id_ldate_sp2;
                    self.yr__ver_src_id_ldate_sp          := yr__ver_src_id_ldate_sp;
                    self.mth__ver_src_id_ldate_sp         := mth__ver_src_id_ldate_sp;
                    self._ver_src_id_ut_pos               := _ver_src_id_ut_pos;
                    self._ver_src_id__ut                  := _ver_src_id__ut;
                    self._ver_src_id_fdate_ut             := _ver_src_id_fdate_ut;
                    self._ver_src_id_fdate_ut2            := _ver_src_id_fdate_ut2;
                    self.yr__ver_src_id_fdate_ut          := yr__ver_src_id_fdate_ut;
                    self.mth__ver_src_id_fdate_ut         := mth__ver_src_id_fdate_ut;
                    self._ver_src_id_ldate_ut             := _ver_src_id_ldate_ut;
                    self._ver_src_id_ldate_ut2            := _ver_src_id_ldate_ut2;
                    self.yr__ver_src_id_ldate_ut          := yr__ver_src_id_ldate_ut;
                    self.mth__ver_src_id_ldate_ut         := mth__ver_src_id_ldate_ut;
                    self._ver_src_id_v_pos                := _ver_src_id_v_pos;
                    self._ver_src_id__v                   := _ver_src_id__v;
                    self._ver_src_id_fdate_v              := _ver_src_id_fdate_v;
                    self._ver_src_id_fdate_v2             := _ver_src_id_fdate_v2;
                    self.yr__ver_src_id_fdate_v           := yr__ver_src_id_fdate_v;
                    self.mth__ver_src_id_fdate_v          := mth__ver_src_id_fdate_v;
                    self._ver_src_id_ldate_v              := _ver_src_id_ldate_v;
                    self._ver_src_id_ldate_v2             := _ver_src_id_ldate_v2;
                    self.yr__ver_src_id_ldate_v           := yr__ver_src_id_ldate_v;
                    self.mth__ver_src_id_ldate_v          := mth__ver_src_id_ldate_v;
                    self._ver_src_id_wb_pos               := _ver_src_id_wb_pos;
                    self._ver_src_id__wb                  := _ver_src_id__wb;
                    self._ver_src_id_fdate_wb             := _ver_src_id_fdate_wb;
                    self._ver_src_id_fdate_wb2            := _ver_src_id_fdate_wb2;
                    self.yr__ver_src_id_fdate_wb          := yr__ver_src_id_fdate_wb;
                    self.mth__ver_src_id_fdate_wb         := mth__ver_src_id_fdate_wb;
                    self._ver_src_id_ldate_wb             := _ver_src_id_ldate_wb;
                    self._ver_src_id_ldate_wb2            := _ver_src_id_ldate_wb2;
                    self.yr__ver_src_id_ldate_wb          := yr__ver_src_id_ldate_wb;
                    self.mth__ver_src_id_ldate_wb         := mth__ver_src_id_ldate_wb;
                    self._ver_src_id_wc_pos               := _ver_src_id_wc_pos;
                    self._ver_src_id__wc                  := _ver_src_id__wc;
                    self._ver_src_id_fdate_wc             := _ver_src_id_fdate_wc;
                    self._ver_src_id_fdate_wc2            := _ver_src_id_fdate_wc2;
                    self.yr__ver_src_id_fdate_wc          := yr__ver_src_id_fdate_wc;
                    self.mth__ver_src_id_fdate_wc         := mth__ver_src_id_fdate_wc;
                    self._ver_src_id_ldate_wc             := _ver_src_id_ldate_wc;
                    self._ver_src_id_ldate_wc2            := _ver_src_id_ldate_wc2;
                    self.yr__ver_src_id_ldate_wc          := yr__ver_src_id_ldate_wc;
                    self.mth__ver_src_id_ldate_wc         := mth__ver_src_id_ldate_wc;
                    self._ver_src_id_wk_pos               := _ver_src_id_wk_pos;
                    self._ver_src_id__wk                  := _ver_src_id__wk;
                    self._ver_src_id_fdate_wk             := _ver_src_id_fdate_wk;
                    self._ver_src_id_fdate_wk2            := _ver_src_id_fdate_wk2;
                    self.yr__ver_src_id_fdate_wk          := yr__ver_src_id_fdate_wk;
                    self.mth__ver_src_id_fdate_wk         := mth__ver_src_id_fdate_wk;
                    self._ver_src_id_ldate_wk             := _ver_src_id_ldate_wk;
                    self._ver_src_id_ldate_wk2            := _ver_src_id_ldate_wk2;
                    self.yr__ver_src_id_ldate_wk          := yr__ver_src_id_ldate_wk;
                    self.mth__ver_src_id_ldate_wk         := mth__ver_src_id_ldate_wk;
                    self._ver_src_id_wx_pos               := _ver_src_id_wx_pos;
                    self._ver_src_id__wx                  := _ver_src_id__wx;
                    self._ver_src_id_fdate_wx             := _ver_src_id_fdate_wx;
                    self._ver_src_id_fdate_wx2            := _ver_src_id_fdate_wx2;
                    self.yr__ver_src_id_fdate_wx          := yr__ver_src_id_fdate_wx;
                    self.mth__ver_src_id_fdate_wx         := mth__ver_src_id_fdate_wx;
                    self._ver_src_id_ldate_wx             := _ver_src_id_ldate_wx;
                    self._ver_src_id_ldate_wx2            := _ver_src_id_ldate_wx2;
                    self.yr__ver_src_id_ldate_wx          := yr__ver_src_id_ldate_wx;
                    self.mth__ver_src_id_ldate_wx         := mth__ver_src_id_ldate_wx;
                    self._ver_src_id_zo_pos               := _ver_src_id_zo_pos;
                    self._ver_src_id__zo                  := _ver_src_id__zo;
                    self._ver_src_id_fdate_zo             := _ver_src_id_fdate_zo;
                    self._ver_src_id_fdate_zo2            := _ver_src_id_fdate_zo2;
                    self.yr__ver_src_id_fdate_zo          := yr__ver_src_id_fdate_zo;
                    self.mth__ver_src_id_fdate_zo         := mth__ver_src_id_fdate_zo;
                    self._ver_src_id_ldate_zo             := _ver_src_id_ldate_zo;
                    self._ver_src_id_ldate_zo2            := _ver_src_id_ldate_zo2;
                    self.yr__ver_src_id_ldate_zo          := yr__ver_src_id_ldate_zo;
                    self.mth__ver_src_id_ldate_zo         := mth__ver_src_id_ldate_zo;
                    self._ver_src_id_y_pos                := _ver_src_id_y_pos;
                    self._ver_src_id__y                   := _ver_src_id__y;
                    self._ver_src_id_fdate_y              := _ver_src_id_fdate_y;
                    self._ver_src_id_fdate_y2             := _ver_src_id_fdate_y2;
                    self.yr__ver_src_id_fdate_y           := yr__ver_src_id_fdate_y;
                    self.mth__ver_src_id_fdate_y          := mth__ver_src_id_fdate_y;
                    self._ver_src_id_ldate_y              := _ver_src_id_ldate_y;
                    self._ver_src_id_ldate_y2             := _ver_src_id_ldate_y2;
                    self.yr__ver_src_id_ldate_y           := yr__ver_src_id_ldate_y;
                    self.mth__ver_src_id_ldate_y          := mth__ver_src_id_ldate_y;
                    self._ver_src_id_gb_pos               := _ver_src_id_gb_pos;
                    self._ver_src_id__gb                  := _ver_src_id__gb;
                    self._ver_src_id_fdate_gb             := _ver_src_id_fdate_gb;
                    self._ver_src_id_fdate_gb2            := _ver_src_id_fdate_gb2;
                    self.yr__ver_src_id_fdate_gb          := yr__ver_src_id_fdate_gb;
                    self.mth__ver_src_id_fdate_gb         := mth__ver_src_id_fdate_gb;
                    self._ver_src_id_ldate_gb             := _ver_src_id_ldate_gb;
                    self._ver_src_id_ldate_gb2            := _ver_src_id_ldate_gb2;
                    self.yr__ver_src_id_ldate_gb          := yr__ver_src_id_ldate_gb;
                    self.mth__ver_src_id_ldate_gb         := mth__ver_src_id_ldate_gb;
                    self._ver_src_id_cs_pos               := _ver_src_id_cs_pos;
                    self._ver_src_id__cs                  := _ver_src_id__cs;
                    self._ver_src_id_ldate_cs             := _ver_src_id_ldate_cs;
                    self._ver_src_id_ldate_cs2            := _ver_src_id_ldate_cs2;
                    self.yr__ver_src_id_ldate_cs          := yr__ver_src_id_ldate_cs;
                    self.mth__ver_src_id_ldate_cs         := mth__ver_src_id_ldate_cs;
                    self._ver_src_id_fdate_cs             := _ver_src_id_fdate_cs;
                    self._ver_src_id_fdate_cs2            := _ver_src_id_fdate_cs2;
                    self.yr__ver_src_id_fdate_cs          := yr__ver_src_id_fdate_cs;
                    self.mth__ver_src_id_fdate_cs         := mth__ver_src_id_fdate_cs;
                    self.vs_ver_src_id__gb                := vs_ver_src_id__gb;
                    self.vs_gb_id_mth_fseen               := vs_gb_id_mth_fseen;
                    self.vs_gb_id_mth_lseen               := vs_gb_id_mth_lseen;
                    self.vs_ver_src_id__y                 := vs_ver_src_id__y;
                    self.vs_y_id_mth_fseen                := vs_y_id_mth_fseen;
                    self.vs_y_id_mth_lseen                := vs_y_id_mth_lseen;
                    self.vs_ver_src_id__ut                := vs_ver_src_id__ut;
                    self.vs_ut_id_mth_fseen               := vs_ut_id_mth_fseen;
                    self.vs_ut_id_mth_lseen               := vs_ut_id_mth_lseen;
                    self.vs_ver_src_id__os                := vs_ver_src_id__os;
                    self.vs_os_id_mth_fseen               := vs_os_id_mth_fseen;
                    self.vs_os_id_mth_lseen               := vs_os_id_mth_lseen;
                    self.vs_ver_src_id__bm                := vs_ver_src_id__bm;
                    self.vs_bm_id_mth_fseen               := vs_bm_id_mth_fseen;
                    self.vs_bm_id_mth_lseen               := vs_bm_id_mth_lseen;
                    self.vs_ver_src_id__i                 := vs_ver_src_id__i;
                    self.vs_i_id_mth_fseen                := vs_i_id_mth_fseen;
                    self.vs_i_id_mth_lseen                := vs_i_id_mth_lseen;
                    self.vs_ver_src_id__in                := vs_ver_src_id__in;
                    self.vs_in_id_mth_fseen               := vs_in_id_mth_fseen;
                    self.vs_in_id_mth_lseen               := vs_in_id_mth_lseen;
                    self.vs_ver_src_id__l0                := vs_ver_src_id__l0;
                    self.vs_l0_id_mth_fseen               := vs_l0_id_mth_fseen;
                    self.vs_l0_id_mth_lseen               := vs_l0_id_mth_lseen;
                    self.vs_ver_src_id__wa                := vs_ver_src_id__wa;
                    self.vs_wa_id_mth_fseen               := vs_wa_id_mth_fseen;
                    self.vs_wa_id_mth_lseen               := vs_wa_id_mth_lseen;
                    self.vs_ver_src_id__ar                := vs_ver_src_id__ar;
                    self.vs_ar_id_mth_fseen               := vs_ar_id_mth_fseen;
                    self.vs_ar_id_mth_lseen               := vs_ar_id_mth_lseen;
                    self.vs_ver_src_id__v2                := vs_ver_src_id__v2;
                    self.vs_v2_id_mth_fseen               := vs_v2_id_mth_fseen;
                    self.vs_v2_id_mth_lseen               := vs_v2_id_mth_lseen;
                    self.vs_adl_util_i                    := vs_adl_util_i;
                    self.vs_util_adl_count                := vs_util_adl_count;
                    self._util_adl_first_seen             := _util_adl_first_seen;
                    self.vs_util_adl_mths_fs              := vs_util_adl_mths_fs;
                    self._gong_did_first_seen             := _gong_did_first_seen;
                    self._gong_did_last_seen              := _gong_did_last_seen;
                    self.vs_gong_adl_mths_ls              := vs_gong_adl_mths_ls;
                    self._header_first_seen               := _header_first_seen;
                    self.vs_header_mths_fs                := vs_header_mths_fs;
                    self._header_last_seen                := _header_last_seen;
                    self.vs_br_mths_fs                    := vs_br_mths_fs;
                    self.vs_br_business_count             := vs_br_business_count;
                    self.vs_br_dead_business_count        := vs_br_dead_business_count;
                    self.vs_br_active_phone_count         := vs_br_active_phone_count;
                    self.vs_email_count                   := vs_email_count;
                    self.vs_email_domain_free_count       := vs_email_domain_free_count;
                    self.vs_email_domain_edu_count        := vs_email_domain_edu_count;
                    self.vs_historical_count              := vs_historical_count;
                    self.vs_college_tier                  := vs_college_tier;
                    self.vs_prof_license_flag             := vs_prof_license_flag;
                    self._prof_license_ix_sanct_fs        := _prof_license_ix_sanct_fs;
                    self._prof_license_ix_sanct_ls        := _prof_license_ix_sanct_ls;
                    self.ver_src_cons_fsrc_fdate          := ver_src_cons_fsrc_fdate;
                    self.ver_src_cons_fsrc_fdate2         := ver_src_cons_fsrc_fdate2;
                    self.yr_ver_src_cons_fsrc_fdate       := yr_ver_src_cons_fsrc_fdate;
                    self.mth_ver_src_cons_fsrc_fdate      := mth_ver_src_cons_fsrc_fdate;
                    self.ver_src_cons_vo_pos              := ver_src_cons_vo_pos;
                    self.ver_src_cons__vo                 := ver_src_cons__vo;
                    self.ver_src_cons_fdate_vo            := ver_src_cons_fdate_vo;
                    self.ver_src_cons_fdate_vo2           := ver_src_cons_fdate_vo2;
                    self.yr_ver_src_cons_fdate_vo         := yr_ver_src_cons_fdate_vo;
                    self.mth_ver_src_cons_fdate_vo        := mth_ver_src_cons_fdate_vo;
                    self.ver_src_cons_ldate_vo            := ver_src_cons_ldate_vo;
                    self.ver_src_cons_ldate_vo2           := ver_src_cons_ldate_vo2;
                    self.yr_ver_src_cons_ldate_vo         := yr_ver_src_cons_ldate_vo;
                    self.mth_ver_src_cons_ldate_vo        := mth_ver_src_cons_ldate_vo;
                    self.ver_src_cons_wp_pos              := ver_src_cons_wp_pos;
                    self.ver_src_cons__wp                 := ver_src_cons__wp;
                    self.ver_src_cons_fdate_wp            := ver_src_cons_fdate_wp;
                    self.ver_src_cons_fdate_wp2           := ver_src_cons_fdate_wp2;
                    self.yr_ver_src_cons_fdate_wp         := yr_ver_src_cons_fdate_wp;
                    self.mth_ver_src_cons_fdate_wp        := mth_ver_src_cons_fdate_wp;
                    self.ver_src_cons_ldate_wp            := ver_src_cons_ldate_wp;
                    self.ver_src_cons_ldate_wp2           := ver_src_cons_ldate_wp2;
                    self.yr_ver_src_cons_ldate_wp         := yr_ver_src_cons_ldate_wp;
                    self.mth_ver_src_cons_ldate_wp        := mth_ver_src_cons_ldate_wp;
                    self.ver_src_cons_am_pos              := ver_src_cons_am_pos;
                    self.ver_src_cons__am                 := ver_src_cons__am;
                    self.ver_src_cons_fdate_am            := ver_src_cons_fdate_am;
                    self.ver_src_cons_fdate_am2           := ver_src_cons_fdate_am2;
                    self.yr_ver_src_cons_fdate_am         := yr_ver_src_cons_fdate_am;
                    self.mth_ver_src_cons_fdate_am        := mth_ver_src_cons_fdate_am;
                    self.ver_src_cons_ldate_am            := ver_src_cons_ldate_am;
                    self.ver_src_cons_ldate_am2           := ver_src_cons_ldate_am2;
                    self.yr_ver_src_cons_ldate_am         := yr_ver_src_cons_ldate_am;
                    self.mth_ver_src_cons_ldate_am        := mth_ver_src_cons_ldate_am;
                    self.ver_src_cons_e1_pos              := ver_src_cons_e1_pos;
                    self.ver_src_cons__e1                 := ver_src_cons__e1;
                    self.ver_src_cons_fdate_e1            := ver_src_cons_fdate_e1;
                    self.ver_src_cons_fdate_e12           := ver_src_cons_fdate_e12;
                    self.yr_ver_src_cons_fdate_e1         := yr_ver_src_cons_fdate_e1;
                    self.mth_ver_src_cons_fdate_e1        := mth_ver_src_cons_fdate_e1;
                    self.ver_src_cons_ldate_e1            := ver_src_cons_ldate_e1;
                    self.ver_src_cons_ldate_e12           := ver_src_cons_ldate_e12;
                    self.yr_ver_src_cons_ldate_e1         := yr_ver_src_cons_ldate_e1;
                    self.mth_ver_src_cons_ldate_e1        := mth_ver_src_cons_ldate_e1;
                    self.ver_src_cons_e2_pos              := ver_src_cons_e2_pos;
                    self.ver_src_cons__e2                 := ver_src_cons__e2;
                    self.ver_src_cons_fdate_e2            := ver_src_cons_fdate_e2;
                    self.ver_src_cons_fdate_e22           := ver_src_cons_fdate_e22;
                    self.yr_ver_src_cons_fdate_e2         := yr_ver_src_cons_fdate_e2;
                    self.mth_ver_src_cons_fdate_e2        := mth_ver_src_cons_fdate_e2;
                    self.ver_src_cons_ldate_e2            := ver_src_cons_ldate_e2;
                    self.ver_src_cons_ldate_e22           := ver_src_cons_ldate_e22;
                    self.yr_ver_src_cons_ldate_e2         := yr_ver_src_cons_ldate_e2;
                    self.mth_ver_src_cons_ldate_e2        := mth_ver_src_cons_ldate_e2;
                    self.ver_src_cons_e3_pos              := ver_src_cons_e3_pos;
                    self.ver_src_cons__e3                 := ver_src_cons__e3;
                    self.ver_src_cons_fdate_e3            := ver_src_cons_fdate_e3;
                    self.ver_src_cons_fdate_e32           := ver_src_cons_fdate_e32;
                    self.yr_ver_src_cons_fdate_e3         := yr_ver_src_cons_fdate_e3;
                    self.mth_ver_src_cons_fdate_e3        := mth_ver_src_cons_fdate_e3;
                    self.ver_src_cons_ldate_e3            := ver_src_cons_ldate_e3;
                    self.ver_src_cons_ldate_e32           := ver_src_cons_ldate_e32;
                    self.yr_ver_src_cons_ldate_e3         := yr_ver_src_cons_ldate_e3;
                    self.mth_ver_src_cons_ldate_e3        := mth_ver_src_cons_ldate_e3;
                    self._ver_src_cons_fdate_vo           := _ver_src_cons_fdate_vo;
                    self._ver_src_cons_ldate_vo           := _ver_src_cons_ldate_vo;
                    self.vs_ver_src_cons_vo_mths_ls       := vs_ver_src_cons_vo_mths_ls;
                    self.vs_ver_sources_wp_pop            := vs_ver_sources_wp_pop;
                    self._ver_src_cons_fdate_wp           := _ver_src_cons_fdate_wp;
                    self._ver_src_cons_ldate_wp           := _ver_src_cons_ldate_wp;
                    self.vs_ver_sources_am_pop            := vs_ver_sources_am_pop;
                    self._ver_src_cons_fdate_am           := _ver_src_cons_fdate_am;
                    self._ver_src_cons_ldate_am           := _ver_src_cons_ldate_am;
                    self.vs_ver_sources_e1_pop            := vs_ver_sources_e1_pop;
                    self._ver_src_cons_fdate_e1           := _ver_src_cons_fdate_e1;
                    self.vs_ver_src_cons_e1_mths_fs       := vs_ver_src_cons_e1_mths_fs;
                    self._ver_src_cons_ldate_e1           := _ver_src_cons_ldate_e1;
                    self.vs_ver_src_cons_e1_mths_ls       := vs_ver_src_cons_e1_mths_ls;
                    self._ver_src_cons_fdate_e2           := _ver_src_cons_fdate_e2;
                    self.vs_ver_src_cons_e2_mths_fs       := vs_ver_src_cons_e2_mths_fs;
                    self._ver_src_cons_ldate_e2           := _ver_src_cons_ldate_e2;
                    self.vs_ver_src_cons_e2_mths_ls       := vs_ver_src_cons_e2_mths_ls;
                    self._ver_src_cons_fdate_e3           := _ver_src_cons_fdate_e3;
                    self.vs_ver_src_cons_e3_mths_fs       := vs_ver_src_cons_e3_mths_fs;
                    self._ver_src_cons_ldate_e3           := _ver_src_cons_ldate_e3;
                    self.vs_ver_src_cons_e3_mths_ls       := vs_ver_src_cons_e3_mths_ls;
                    self.c_vs_gb_id_mth_fseen_w           := c_vs_gb_id_mth_fseen_w;
                    self.c_vs_gb_id_mth_lseen_w           := c_vs_gb_id_mth_lseen_w;
                    self.c_vs_ver_src_id__bm_w            := c_vs_ver_src_id__bm_w;
                    self.c_vs_ver_src_id__in_w            := c_vs_ver_src_id__in_w;
                    self.c_vs_util_adl_count_w            := c_vs_util_adl_count_w;
                    self.c_vs_util_adl_mths_fs_w          := c_vs_util_adl_mths_fs_w;
                    self.c_vs_gong_adl_mths_ls_w          := c_vs_gong_adl_mths_ls_w;
                    self.c_vs_header_mths_fs_w            := c_vs_header_mths_fs_w;
                    self.c_vs_pb_mths_fs_w                := c_vs_pb_mths_fs_w;
                    self.c_vs_pb_mths_ls_w                := c_vs_pb_mths_ls_w;
                    self.c_vs_pb_number_of_sources_w      := c_vs_pb_number_of_sources_w;
                    self.c_vs_br_mths_fs_w                := c_vs_br_mths_fs_w;
                    self.c_vs_br_dead_business_count_w    := c_vs_br_dead_business_count_w;
                    self.c_vs_br_active_phone_count_w     := c_vs_br_active_phone_count_w;
                    self.c_vs_email_count_w               := c_vs_email_count_w;
                    self.c_vs_email_domain_free_count_w   := c_vs_email_domain_free_count_w;
                    self.c_vs_email_domain_edu_count_w    := c_vs_email_domain_edu_count_w;
                    self.c_vs_college_tier_w              := c_vs_college_tier_w;
                    self.c_vs_prof_license_flag_w         := c_vs_prof_license_flag_w;
                    self.c_vs_ver_src_cons_vo_mths_ls_w   := c_vs_ver_src_cons_vo_mths_ls_w;
                    self.c_vs_ver_sources_am_pop_w        := c_vs_ver_sources_am_pop_w;
                    self.bv_bus_rep_source_profile        := bv_bus_rep_source_profile;
                    self.r_vs_adl_util_i_w                := r_vs_adl_util_i_w;
                    self.r_vs_util_adl_count_w            := r_vs_util_adl_count_w;
                    self.r_vs_util_adl_mths_fs_w          := r_vs_util_adl_mths_fs_w;
                    self.r_vs_gong_adl_mths_ls_w          := r_vs_gong_adl_mths_ls_w;
                    self.r_vs_header_mths_fs_w            := r_vs_header_mths_fs_w;
                    self.r_vs_pb_mths_fs_w                := r_vs_pb_mths_fs_w;
                    self.r_vs_pb_mths_ls_w                := r_vs_pb_mths_ls_w;
                    self.r_vs_pb_number_of_sources_w      := r_vs_pb_number_of_sources_w;
                    self.r_vs_br_mths_fs_w                := r_vs_br_mths_fs_w;
                    self.r_vs_br_business_count_w         := r_vs_br_business_count_w;
                    self.r_vs_br_dead_business_count_w    := r_vs_br_dead_business_count_w;
                    self.r_vs_br_active_phone_count_w     := r_vs_br_active_phone_count_w;
                    self.r_vs_email_count_w               := r_vs_email_count_w;
                    self.r_vs_email_domain_free_count_w   := r_vs_email_domain_free_count_w;
                    self.r_vs_email_domain_edu_count_w    := r_vs_email_domain_edu_count_w;
                    self.r_vs_historical_count_w          := r_vs_historical_count_w;
                    self.r_vs_college_tier_w              := r_vs_college_tier_w;
                    self.r_vs_prof_license_flag_w         := r_vs_prof_license_flag_w;
                    self.r_vs_ver_src_cons_vo_mths_ls_w   := r_vs_ver_src_cons_vo_mths_ls_w;
                    self.r_vs_ver_sources_wp_pop_w        := r_vs_ver_sources_wp_pop_w;
                    self.r_vs_ver_sources_am_pop_w        := r_vs_ver_sources_am_pop_w;
                    self.r_vs_ver_sources_e1_pop_w        := r_vs_ver_sources_e1_pop_w;
                    self.bv_rep_only_source_profile       := bv_rep_only_source_profile;
                    self.b_vs_gb_id_mth_fseen_w           := b_vs_gb_id_mth_fseen_w;
                    self.b_vs_gb_id_mth_lseen_w           := b_vs_gb_id_mth_lseen_w;
                    self.b_vs_ver_src_id__ut_w            := b_vs_ver_src_id__ut_w;
                    self.b_vs_ver_src_id__bm_w            := b_vs_ver_src_id__bm_w;
                    self.b_vs_ver_src_id__i_w             := b_vs_ver_src_id__i_w;
                    self.b_vs_v2_id_mth_fseen_w           := b_vs_v2_id_mth_fseen_w;
                    self.b_vs_v2_id_mth_lseen_w           := b_vs_v2_id_mth_lseen_w;
                    self.bv_bus_only_source_profile       := bv_bus_only_source_profile;
                    self.truebiz_ln                       := truebiz_ln;
                    self.iv_rv5_unscorable                := iv_rv5_unscorable;
                    self.rv_a46_curr_avm_autoval          := rv_a46_curr_avm_autoval;
                    self.rv_d30_derog_count               := rv_d30_derog_count;
                    self.bv_assoc_judg_tot                := bv_assoc_judg_tot;
                    self.rv_i61_inq_collection_recency    := rv_i61_inq_collection_recency;
                    self._inq_banko_cm_last_seen          := _inq_banko_cm_last_seen;
                    self.nf_mos_inq_banko_cm_lseen        := nf_mos_inq_banko_cm_lseen;
                    self.bx_addr_assessed_value           := bx_addr_assessed_value;
                    self.bv_sos_current_standing          := bv_sos_current_standing;
                    self.mortgage_type                    := mortgage_type;
                    self.mortgage_present                 := mortgage_present;
                    self.iv_curr_add_mortgage_type        := iv_curr_add_mortgage_type;
                    self.source_ar                        := source_ar;
                    self.source_ba                        := source_ba;
                    self.source_bm                        := source_bm;
                    self.source_br                        := source_br;
                    self.source_c                         := source_c;
                    self.source_cs                        := source_cs;
                    self.source_da                        := source_da;
                    self.source_df                        := source_df;
                    self.source_dn                        := source_dn;
                    self.source_ef                        := source_ef;
                    self.source_er                        := source_er;
                    self.source_fb                        := source_fb;
                    self.source_ft                        := source_ft;
                    self.source_gb                        := source_gb;
                    self.source_i                         := source_i;
                    self.source_ia                        := source_ia;
                    self.source_ic                        := source_ic;
                    self.source_in                        := source_in;
                    self.source_l0                        := source_l0;
                    self.source_l2                        := source_l2;
                    self.source_os                        := source_os;
                    self.source_p                         := source_p;
                    self.source_pp                        := source_pp;
                    self.source_q3                        := source_q3;
                    self.source_tx                        := source_tx;
                    self.source_u                         := source_u;
                    self.source_ut                        := source_ut;
                    self.source_v2                        := source_v2;
                    self.source_wa                        := source_wa;
                    self.source_wk                        := source_wk;
                    self.num_pos_sources                  := num_pos_sources;
                    self.num_neg_sources                  := num_neg_sources;
                    self.bv_ver_src_derog_ratio           := bv_ver_src_derog_ratio;
                    self.bv_mth_ver_src_p_ls              := bv_mth_ver_src_p_ls;
                    self.rv_d34_attr_liens_recency        := rv_d34_attr_liens_recency;
                    self.bv_lien_avg_amount               := bv_lien_avg_amount;
                    self.bv_lien_total_amount             := bv_lien_total_amount;
                    self.nf_fp_varrisktype                := nf_fp_varrisktype;
                    self.bv_ver_src_id_mth_since_fs       := bv_ver_src_id_mth_since_fs;
                    self.nf_fp_srchunvrfdssncount         := nf_fp_srchunvrfdssncount;
                    self._judg_filed_firstseen            := _judg_filed_firstseen;
                    self.bv_judg_filed_mth_fs             := bv_judg_filed_mth_fs;
                    self.rv_a41_prop_owner                := rv_a41_prop_owner;
                    self._sos_agent_change_lastseen       := _sos_agent_change_lastseen;
                    self.bv_sos_mth_agent_change          := bv_sos_mth_agent_change;
                    self.bv_assoc_lien_tot                := bv_assoc_lien_tot;
                    self.bx_addr_lres                     := bx_addr_lres;
                    self.rv_d32_attr_felonies_recency     := rv_d32_attr_felonies_recency;
                    self.rv_ever_asset_owner              := rv_ever_asset_owner;
                    self.rv_d34_attr_unrel_liens_recency  := rv_d34_attr_unrel_liens_recency;
                    self.rv_a44_curr_add_naprop           := rv_a44_curr_add_naprop;
                    self.bv_mth_bureau_fs                 := bv_mth_bureau_fs;
                    self.rv_i60_inq_auto_count12          := rv_i60_inq_auto_count12;
                    self.br_first_seen_char               := br_first_seen_char;
                    self._br_first_seen                   := _br_first_seen;
                    self.rv_mos_since_br_first_seen       := rv_mos_since_br_first_seen;
                    self.nf_fp_srchvelocityrisktype       := nf_fp_srchvelocityrisktype;
                    self.rv_d33_eviction_count            := rv_d33_eviction_count;
                    self.bv_lien_ft_count                 := bv_lien_ft_count;
                    self.rv_d34_unrel_liens_ct            := rv_d34_unrel_liens_ct;
                    self.bv_assoc_derog_pct               := bv_assoc_derog_pct;
                    self.nf_fp_srchunvrfdphonecount       := nf_fp_srchunvrfdphonecount;
                    self.rv_i60_inq_comm_recency          := rv_i60_inq_comm_recency;
                    self.nf_fp_srchfraudsrchcountyr       := nf_fp_srchfraudsrchcountyr;
                    self.bv_ver_src_id_activity12         := bv_ver_src_id_activity12;
                    self.bv_lien_ot_count                 := bv_lien_ot_count;
                    self.bv_judg_avg_amount               := bv_judg_avg_amount;
                    self.nf_fp_srchunvrfdaddrcount        := nf_fp_srchunvrfdaddrcount;
                    self.nf_fp_sourcerisktype             := nf_fp_sourcerisktype;
                    self.nf_fp_prevaddrageoldest          := nf_fp_prevaddrageoldest;
                    self.rv_i60_inq_auto_recency          := rv_i60_inq_auto_recency;
                    self.rv_i61_inq_collection_count12    := rv_i61_inq_collection_count12;
                    self.rv_i60_inq_hiriskcred_recency    := rv_i60_inq_hiriskcred_recency;
                    self.rv_c14_addrs_per_adl_c6          := rv_c14_addrs_per_adl_c6;
                    self.rv_c12_num_nonderogs             := rv_c12_num_nonderogs;
                    self.s0_v01_w                         := s0_v01_w;
                    self.s0_aa_code_01                    := s0_aa_code_01;
                    self.s0_aa_dist_01                    := s0_aa_dist_01;
                    self.s0_v02_w                         := s0_v02_w;
                    self.s0_aa_code_02                    := s0_aa_code_02;
                    self.s0_aa_dist_02                    := s0_aa_dist_02;
                    self.s0_v03_w                         := s0_v03_w;
                    self.s0_aa_code_03                    := s0_aa_code_03;
                    self.s0_aa_dist_03                    := s0_aa_dist_03;
                    self.s0_v04_w                         := s0_v04_w;
                    self.s0_aa_code_04                    := s0_aa_code_04;
                    self.s0_aa_dist_04                    := s0_aa_dist_04;
                    self.s0_v05_w                         := s0_v05_w;
                    self.s0_aa_code_05                    := s0_aa_code_05;
                    self.s0_aa_dist_05                    := s0_aa_dist_05;
                    self.s0_v06_w                         := s0_v06_w;
                    self.s0_aa_code_06                    := s0_aa_code_06;
                    self.s0_aa_dist_06                    := s0_aa_dist_06;
                    self.s0_v07_w                         := s0_v07_w;
                    self.s0_aa_code_07                    := s0_aa_code_07;
                    self.s0_aa_dist_07                    := s0_aa_dist_07;
                    self.s0_v08_w                         := s0_v08_w;
                    self.s0_aa_code_08                    := s0_aa_code_08;
                    self.s0_aa_dist_08                    := s0_aa_dist_08;
                    self.s0_v09_w                         := s0_v09_w;
                    self.s0_aa_code_09                    := s0_aa_code_09;
                    self.s0_aa_dist_09                    := s0_aa_dist_09;
                    self.s0_v10_w                         := s0_v10_w;
                    self.s0_aa_code_10                    := s0_aa_code_10;
                    self.s0_aa_dist_10                    := s0_aa_dist_10;
                    self.s0_v11_w                         := s0_v11_w;
                    self.s0_aa_code_11                    := s0_aa_code_11;
                    self.s0_aa_dist_11                    := s0_aa_dist_11;
                    self.s0_v12_w                         := s0_v12_w;
                    self.s0_aa_code_12                    := s0_aa_code_12;
                    self.s0_aa_dist_12                    := s0_aa_dist_12;
                    self.s0_v13_w                         := s0_v13_w;
                    self.s0_aa_code_13                    := s0_aa_code_13;
                    self.s0_aa_dist_13                    := s0_aa_dist_13;
                    self.s0_v14_w                         := s0_v14_w;
                    self.s0_aa_code_14                    := s0_aa_code_14;
                    self.s0_aa_dist_14                    := s0_aa_dist_14;
                    self.s0_v15_w                         := s0_v15_w;
                    self.s0_aa_code_15                    := s0_aa_code_15;
                    self.s0_aa_dist_15                    := s0_aa_dist_15;
                    self.s0_v16_w                         := s0_v16_w;
                    self.s0_aa_code_16                    := s0_aa_code_16;
                    self.s0_aa_dist_16                    := s0_aa_dist_16;
                    self.s0_v17_w                         := s0_v17_w;
                    self.s0_aa_code_17                    := s0_aa_code_17;
                    self.s0_aa_dist_17                    := s0_aa_dist_17;
                    self.s0_v18_w                         := s0_v18_w;
                    self.s0_aa_code_18                    := s0_aa_code_18;
                    self.s0_aa_dist_18                    := s0_aa_dist_18;
                    self.s0_v19_w                         := s0_v19_w;
                    self.s0_aa_code_19                    := s0_aa_code_19;
                    self.s0_aa_dist_19                    := s0_aa_dist_19;
                    self.s0_v20_w                         := s0_v20_w;
                    self.s0_aa_code_20                    := s0_aa_code_20;
                    self.s0_aa_dist_20                    := s0_aa_dist_20;
                    self.s0_v21_w                         := s0_v21_w;
                    self.s0_aa_code_21                    := s0_aa_code_21;
                    self.s0_aa_dist_21                    := s0_aa_dist_21;
                    self.s0_v22_w                         := s0_v22_w;
                    self.s0_aa_code_22                    := s0_aa_code_22;
                    self.s0_aa_dist_22                    := s0_aa_dist_22;
                    self.s0_v23_w                         := s0_v23_w;
                    self.s0_aa_code_23                    := s0_aa_code_23;
                    self.s0_aa_dist_23                    := s0_aa_dist_23;
                    self.s0_v24_w                         := s0_v24_w;
                    self.s0_aa_code_24                    := s0_aa_code_24;
                    self.s0_aa_dist_24                    := s0_aa_dist_24;
                    self.s0_v25_w                         := s0_v25_w;
                    self.s0_aa_code_25                    := s0_aa_code_25;
                    self.s0_aa_dist_25                    := s0_aa_dist_25;
                    self.s0_v26_w                         := s0_v26_w;
                    self.s0_aa_code_26                    := s0_aa_code_26;
                    self.s0_aa_dist_26                    := s0_aa_dist_26;
                    self.s0_v27_w                         := s0_v27_w;
                    self.s0_aa_code_27                    := s0_aa_code_27;
                    self.s0_aa_dist_27                    := s0_aa_dist_27;
                    self.s0_v28_w                         := s0_v28_w;
                    self.s0_aa_code_28                    := s0_aa_code_28;
                    self.s0_aa_dist_28                    := s0_aa_dist_28;
                    self.s0_v29_w                         := s0_v29_w;
                    self.s0_aa_code_29                    := s0_aa_code_29;
                    self.s0_aa_dist_29                    := s0_aa_dist_29;
                    self.s0_v30_w                         := s0_v30_w;
                    self.s0_aa_code_30                    := s0_aa_code_30;
                    self.s0_aa_dist_30                    := s0_aa_dist_30;
                    self.s0_v31_w                         := s0_v31_w;
                    self.s0_aa_code_31                    := s0_aa_code_31;
                    self.s0_aa_dist_31                    := s0_aa_dist_31;
                    self.s0_v32_w                         := s0_v32_w;
                    self.s0_aa_code_32                    := s0_aa_code_32;
                    self.s0_aa_dist_32                    := s0_aa_dist_32;
                    self.s0_v33_w                         := s0_v33_w;
                    self.s0_aa_code_33                    := s0_aa_code_33;
                    self.s0_aa_dist_33                    := s0_aa_dist_33;
                    self.s0_v34_w                         := s0_v34_w;
                    self.s0_aa_code_34                    := s0_aa_code_34;
                    self.s0_aa_dist_34                    := s0_aa_dist_34;
                    self.s0_v35_w                         := s0_v35_w;
                    self.s0_aa_code_35                    := s0_aa_code_35;
                    self.s0_aa_dist_35                    := s0_aa_dist_35;
                    self.s0_v36_w                         := s0_v36_w;
                    self.s0_aa_code_36                    := s0_aa_code_36;
                    self.s0_aa_dist_36                    := s0_aa_dist_36;
                    self.s0_v37_w                         := s0_v37_w;
                    self.s0_aa_code_37                    := s0_aa_code_37;
                    self.s0_aa_dist_37                    := s0_aa_dist_37;
                    self.s0_v38_w                         := s0_v38_w;
                    self.s0_aa_code_38                    := s0_aa_code_38;
                    self.s0_aa_dist_38                    := s0_aa_dist_38;
                    self.s0_v39_w                         := s0_v39_w;
                    self.s0_aa_code_39                    := s0_aa_code_39;
                    self.s0_aa_dist_39                    := s0_aa_dist_39;
                    self.s0_v40_w                         := s0_v40_w;
                    self.s0_aa_code_40                    := s0_aa_code_40;
                    self.s0_aa_dist_40                    := s0_aa_dist_40;
                    self.s0_v41_w                         := s0_v41_w;
                    self.s0_aa_code_41                    := s0_aa_code_41;
                    self.s0_aa_dist_41                    := s0_aa_dist_41;
                    self.s0_v42_w                         := s0_v42_w;
                    self.s0_aa_code_42                    := s0_aa_code_42;
                    self.s0_aa_dist_42                    := s0_aa_dist_42;
                    self.s0_v43_w                         := s0_v43_w;
                    self.s0_aa_code_43                    := s0_aa_code_43;
                    self.s0_aa_dist_43                    := s0_aa_dist_43;
                    self.s0_rcvalueb036                   := s0_rcvalueb036;
                    self.s0_rcvalueb035                   := s0_rcvalueb035;
                    self.s0_rcvalueb034                   := s0_rcvalueb034;
                    self.s0_rcvaluep535                   := s0_rcvaluep535;
                    self.s0_rcvalueb031                   := s0_rcvalueb031;
                    self.s0_rcvaluep539                   := s0_rcvaluep539;
                    self.s0_rcvalueb017                   := s0_rcvalueb017;
                    self.s0_rcvaluep515                   := s0_rcvaluep515;
                    self.s0_rcvaluep513                   := s0_rcvaluep513;
                    self.s0_rcvalueb075                   := s0_rcvalueb075;
                    self.s0_rcvaluep526                   := s0_rcvaluep526;
                    self.s0_rcvalueb079                   := s0_rcvalueb079;
                    self.s0_rcvalueb070                   := s0_rcvalueb070;
                    self.s0_rcvaluep509                   := s0_rcvaluep509;
                    self.s0_rcvalueb069                   := s0_rcvalueb069;
                    self.s0_rcvalueb026                   := s0_rcvalueb026;
                    self.s0_rcvaluep502                   := s0_rcvaluep502;
                    self.s0_rcvaluep540                   := s0_rcvaluep540;
                    self.s0_rcvaluep501                   := s0_rcvaluep501;
                    self.s0_rcvalueb063                   := s0_rcvalueb063;
                    self.s0_rcvaluep505                   := s0_rcvaluep505;
                    self.s0_rcvalueb076                   := s0_rcvalueb076;
                    self.s0_rcvaluep510                   := s0_rcvaluep510;
                    self.s0_rcvaluep567                   := s0_rcvaluep567;
                    self.s0_rcvaluep566                   := s0_rcvaluep566;
                    self.s0_rcvaluep565                   := s0_rcvaluep565;
                    self.s0_rcvaluep523                   := s0_rcvaluep523;
                    self.s0_rcvalueb052                   := s0_rcvalueb052;
                    self.s0_rcvalueb056                   := s0_rcvalueb056;
                    self.s0_rcvalueb059                   := s0_rcvalueb059;
                    self.s0_lgt                           := s0_lgt;
                    self.s1_v01_w                         := s1_v01_w;
                    self.s1_aa_code_01                    := s1_aa_code_01;
                    self.s1_aa_dist_01                    := s1_aa_dist_01;
                    self.s1_v02_w                         := s1_v02_w;
                    self.s1_aa_code_02                    := s1_aa_code_02;
                    self.s1_aa_dist_02                    := s1_aa_dist_02;
                    self.s1_v03_w                         := s1_v03_w;
                    self.s1_aa_code_03                    := s1_aa_code_03;
                    self.s1_aa_dist_03                    := s1_aa_dist_03;
                    self.s1_v04_w                         := s1_v04_w;
                    self.s1_aa_code_04                    := s1_aa_code_04;
                    self.s1_aa_dist_04                    := s1_aa_dist_04;
                    self.s1_v05_w                         := s1_v05_w;
                    self.s1_aa_code_05                    := s1_aa_code_05;
                    self.s1_aa_dist_05                    := s1_aa_dist_05;
                    self.s1_v06_w                         := s1_v06_w;
                    self.s1_aa_code_06                    := s1_aa_code_06;
                    self.s1_aa_dist_06                    := s1_aa_dist_06;
                    self.s1_v07_w                         := s1_v07_w;
                    self.s1_aa_code_07                    := s1_aa_code_07;
                    self.s1_aa_dist_07                    := s1_aa_dist_07;
                    self.s1_v08_w                         := s1_v08_w;
                    self.s1_aa_code_08                    := s1_aa_code_08;
                    self.s1_aa_dist_08                    := s1_aa_dist_08;
                    self.s1_v09_w                         := s1_v09_w;
                    self.s1_aa_code_09                    := s1_aa_code_09;
                    self.s1_aa_dist_09                    := s1_aa_dist_09;
                    self.s1_v10_w                         := s1_v10_w;
                    self.s1_aa_code_10                    := s1_aa_code_10;
                    self.s1_aa_dist_10                    := s1_aa_dist_10;
                    self.s1_v11_w                         := s1_v11_w;
                    self.s1_aa_code_11                    := s1_aa_code_11;
                    self.s1_aa_dist_11                    := s1_aa_dist_11;
                    self.s1_v12_w                         := s1_v12_w;
                    self.s1_aa_code_12                    := s1_aa_code_12;
                    self.s1_aa_dist_12                    := s1_aa_dist_12;
                    self.s1_v13_w                         := s1_v13_w;
                    self.s1_aa_code_13                    := s1_aa_code_13;
                    self.s1_aa_dist_13                    := s1_aa_dist_13;
                    self.s1_v14_w                         := s1_v14_w;
                    self.s1_aa_code_14                    := s1_aa_code_14;
                    self.s1_aa_dist_14                    := s1_aa_dist_14;
                    self.s1_v15_w                         := s1_v15_w;
                    self.s1_aa_code_15                    := s1_aa_code_15;
                    self.s1_aa_dist_15                    := s1_aa_dist_15;
                    self.s1_v16_w                         := s1_v16_w;
                    self.s1_aa_code_16                    := s1_aa_code_16;
                    self.s1_aa_dist_16                    := s1_aa_dist_16;
                    self.s1_v17_w                         := s1_v17_w;
                    self.s1_aa_code_17                    := s1_aa_code_17;
                    self.s1_aa_dist_17                    := s1_aa_dist_17;
                    self.s1_v18_w                         := s1_v18_w;
                    self.s1_aa_code_18                    := s1_aa_code_18;
                    self.s1_aa_dist_18                    := s1_aa_dist_18;
                    self.s1_v19_w                         := s1_v19_w;
                    self.s1_aa_code_19                    := s1_aa_code_19;
                    self.s1_aa_dist_19                    := s1_aa_dist_19;
                    self.s1_v20_w                         := s1_v20_w;
                    self.s1_aa_code_20                    := s1_aa_code_20;
                    self.s1_aa_dist_20                    := s1_aa_dist_20;
                    self.s1_v21_w                         := s1_v21_w;
                    self.s1_aa_code_21                    := s1_aa_code_21;
                    self.s1_aa_dist_21                    := s1_aa_dist_21;
                    self.s1_v22_w                         := s1_v22_w;
                    self.s1_aa_code_22                    := s1_aa_code_22;
                    self.s1_aa_dist_22                    := s1_aa_dist_22;
                    self.s1_v23_w                         := s1_v23_w;
                    self.s1_aa_code_23                    := s1_aa_code_23;
                    self.s1_aa_dist_23                    := s1_aa_dist_23;
                    self.s1_v24_w                         := s1_v24_w;
                    self.s1_aa_code_24                    := s1_aa_code_24;
                    self.s1_aa_dist_24                    := s1_aa_dist_24;
                    self.s1_v25_w                         := s1_v25_w;
                    self.s1_aa_code_25                    := s1_aa_code_25;
                    self.s1_aa_dist_25                    := s1_aa_dist_25;
                    self.s1_aa_code_26                    := s1_aa_code_26;
                    self.s1_aa_dist_26                    := s1_aa_dist_26;
                    self.s1_rcvaluep509                   := s1_rcvaluep509;
                    self.s1_rcvaluep502                   := s1_rcvaluep502;
                    self.s1_rcvaluep535                   := s1_rcvaluep535;
                    self.s1_rcvaluep539                   := s1_rcvaluep539;
                    self.s1_rcvaluep540                   := s1_rcvaluep540;
                    self.s1_rcvaluep515                   := s1_rcvaluep515;
                    self.s1_rcvaluep505                   := s1_rcvaluep505;
                    self.s1_rcvaluep513                   := s1_rcvaluep513;
                    self.s1_rcvaluep510                   := s1_rcvaluep510;
                    self.s1_rcvalueb067                   := s1_rcvalueb067;
                    self.s1_rcvaluep517                   := s1_rcvaluep517;
                    self.s1_rcvaluep567                   := s1_rcvaluep567;
                    self.s1_rcvaluep566                   := s1_rcvaluep566;
                    self.s1_rcvaluep526                   := s1_rcvaluep526;
                    self.s1_lgt                           := s1_lgt;
                    self.rep_only                         := rep_only;
                    self.final_score                      := final_score;
                    self.base                             := base;
                    self.pts                              := pts;
                    self.lgt                              := lgt;
                    self.SLBB1809_0_0                     := SLBB1809_0_0;
                    self.basebls0_rc1                     := basebls0_rc1;
                    self.basebls0_rc2                     := basebls0_rc2;
                    self.basebls0_rc3                     := basebls0_rc3;
                    self.basebls0_rc4                     := basebls0_rc4;
                    self.basebls0_rc5                     := basebls0_rc5;
                    self.basebls0_rc6                     := basebls0_rc6;
                    self.basebls0_rc7                     := basebls0_rc7;
                    self.basebls0_rc8                     := basebls0_rc8;
                    self.basebls0_rc9                     := basebls0_rc9;
                    self.basebls0_rc10                    := basebls0_rc10;
                    self.basebls0_rc11                    := basebls0_rc11;
                    self.basebls0_rc12                    := basebls0_rc12;
                    self.basebls0_rc13                    := basebls0_rc13;
                    self.basebls0_rc14                    := basebls0_rc14;
                    self.basebls0_rc15                    := basebls0_rc15;
                    self.basebls0_rc16                    := basebls0_rc16;
                    self.basebls0_rc17                    := basebls0_rc17;
                    self.basebls0_rc18                    := basebls0_rc18;
                    self.basebls0_rc19                    := basebls0_rc19;
                    self.basebls0_rc20                    := basebls0_rc20;
                    self.basebls0_rc21                    := basebls0_rc21;
                    self.basebls0_rc22                    := basebls0_rc22;
                    self.basebls0_rc23                    := basebls0_rc23;
                    self.basebls0_rc24                    := basebls0_rc24;
                    self.basebls0_rc25                    := basebls0_rc25;
                    self.basebls0_rc26                    := basebls0_rc26;
                    self.basebls0_rc27                    := basebls0_rc27;
                    self.basebls0_rc28                    := basebls0_rc28;
                    self.basebls0_rc29                    := basebls0_rc29;
                    self.basebls0_rc30                    := basebls0_rc30;
                    self.basebls0_rc31                    := basebls0_rc31;
                    self.basebls0_rc32                    := basebls0_rc32;
                    self.basebls0_rc33                    := basebls0_rc33;
                    self.basebls0_rc34                    := basebls0_rc34;
                    self.basebls0_rc35                    := basebls0_rc35;
                    self.basebls0_rc36                    := basebls0_rc36;
                    self.basebls0_rc37                    := basebls0_rc37;
                    self.basebls0_rc38                    := basebls0_rc38;
                    self.basebls0_rc39                    := basebls0_rc39;
                    self.basebls0_rc40                    := basebls0_rc40;
                    self.basebls0_rc41                    := basebls0_rc41;
                    self.basebls0_rc42                    := basebls0_rc42;
                    self.basebls0_rc43                    := basebls0_rc43;
                    self.basebls0_rc44                    := basebls0_rc44;
                    self.basebls0_rc45                    := basebls0_rc45;
                    self.basebls0_rc46                    := basebls0_rc46;
                    self.basebls0_rc47                    := basebls0_rc47;
                    self.basebls0_rc48                    := basebls0_rc48;
                    self.basebls0_rc49                    := basebls0_rc49;
                    self.basebls0_rc50                    := basebls0_rc50;
                    self.basebls1_rc1                     := basebls1_rc1;
                    self.basebls1_rc2                     := basebls1_rc2;
                    self.basebls1_rc3                     := basebls1_rc3;
                    self.basebls1_rc4                     := basebls1_rc4;
                    self.basebls1_rc5                     := basebls1_rc5;
                    self.basebls1_rc6                     := basebls1_rc6;
                    self.basebls1_rc7                     := basebls1_rc7;
                    self.basebls1_rc8                     := basebls1_rc8;
                    self.basebls1_rc9                     := basebls1_rc9;
                    self.basebls1_rc10                    := basebls1_rc10;
                    self.basebls1_rc11                    := basebls1_rc11;
                    self.basebls1_rc12                    := basebls1_rc12;
                    self.basebls1_rc13                    := basebls1_rc13;
                    self.basebls1_rc14                    := basebls1_rc14;
                    self.basebls1_rc15                    := basebls1_rc15;
                    self.basebls1_rc16                    := basebls1_rc16;
                    self.basebls1_rc17                    := basebls1_rc17;
                    self.basebls1_rc18                    := basebls1_rc18;
                    self.basebls1_rc19                    := basebls1_rc19;
                    self.basebls1_rc20                    := basebls1_rc20;
                    self.basebls1_rc21                    := basebls1_rc21;
                    self.basebls1_rc22                    := basebls1_rc22;
                    self.basebls1_rc23                    := basebls1_rc23;
                    self.basebls1_rc24                    := basebls1_rc24;
                    self.basebls1_rc25                    := basebls1_rc25;
                    self.basebls1_rc26                    := basebls1_rc26;
                    self.basebls1_rc27                    := basebls1_rc27;
                    self.basebls1_rc28                    := basebls1_rc28;
                    self.basebls1_rc29                    := basebls1_rc29;
                    self.basebls1_rc30                    := basebls1_rc30;
                    self.basebls1_rc31                    := basebls1_rc31;
                    self.basebls1_rc32                    := basebls1_rc32;
                    self.basebls1_rc33                    := basebls1_rc33;
                    self.basebls1_rc34                    := basebls1_rc34;
                    self.basebls1_rc35                    := basebls1_rc35;
                    self.basebls1_rc36                    := basebls1_rc36;
                    self.basebls1_rc37                    := basebls1_rc37;
                    self.basebls1_rc38                    := basebls1_rc38;
                    self.basebls1_rc39                    := basebls1_rc39;
                    self.basebls1_rc40                    := basebls1_rc40;
                    self.basebls1_rc41                    := basebls1_rc41;
                    self.basebls1_rc42                    := basebls1_rc42;
                    self.basebls1_rc43                    := basebls1_rc43;
                    self.basebls1_rc44                    := basebls1_rc44;
                    self.basebls1_rc45                    := basebls1_rc45;
                    self.basebls1_rc46                    := basebls1_rc46;
                    self.basebls1_rc47                    := basebls1_rc47;
                    self.basebls1_rc48                    := basebls1_rc48;
                    self.basebls1_rc49                    := basebls1_rc49;
                    self.basebls1_rc50                    := basebls1_rc50;
                    self.bus_mod_rc14                     := bus_mod_rc14;
                    self.bus_mod_rc3                      := bus_mod_rc3;
                    self.bus_mod_rc50                     := bus_mod_rc50;
                    self.bus_mod_rc40                     := bus_mod_rc40;
                    self.bus_mod_rc30                     := bus_mod_rc30;
                    self.bus_mod_rc27                     := bus_mod_rc27;
                    self.bus_mod_rc11                     := bus_mod_rc11;
                    self.bus_mod_rc36                     := bus_mod_rc36;
                    self.bus_mod_rc9                      := bus_mod_rc9;
                    self.bus_mod_rc47                     := bus_mod_rc47;
                    self.bus_mod_rc38                     := bus_mod_rc38;
                    self.bus_mod_rc46                     := bus_mod_rc46;
                    self.bus_mod_rc20                     := bus_mod_rc20;
                    self.bus_mod_rc1                      := bus_mod_rc1;
                    self.bus_mod_rc10                     := bus_mod_rc10;
                    self.bus_mod_rc2                      := bus_mod_rc2;
                    self.bus_mod_rc13                     := bus_mod_rc13;
                    self.bus_mod_rc15                     := bus_mod_rc15;
                    self.bus_mod_rc34                     := bus_mod_rc34;
                    self.bus_mod_rc33                     := bus_mod_rc33;
                    self.bus_mod_rc42                     := bus_mod_rc42;
                    self.bus_mod_rc24                     := bus_mod_rc24;
                    self.bus_mod_rc41                     := bus_mod_rc41;
                    self.bus_mod_rc28                     := bus_mod_rc28;
                    self.bus_mod_rc8                      := bus_mod_rc8;
                    self.bus_mod_rc7                      := bus_mod_rc7;
                    self.bus_mod_rc31                     := bus_mod_rc31;
                    self.bus_mod_rc32                     := bus_mod_rc32;
                    self.bus_mod_rc37                     := bus_mod_rc37;
                    self.bus_mod_rc39                     := bus_mod_rc39;
                    self.bus_mod_rc19                     := bus_mod_rc19;
                    self.bus_mod_rc26                     := bus_mod_rc26;
                    self.bus_mod_rc12                     := bus_mod_rc12;
                    self.bus_mod_rc22                     := bus_mod_rc22;
                    self.bus_mod_rc49                     := bus_mod_rc49;
                    self.bus_mod_rc44                     := bus_mod_rc44;
                    self.bus_mod_rc17                     := bus_mod_rc17;
                    self.bus_mod_rc29                     := bus_mod_rc29;
                    self.bus_mod_rc16                     := bus_mod_rc16;
                    self.bus_mod_rc21                     := bus_mod_rc21;
                    self.bus_mod_rc25                     := bus_mod_rc25;
                    self.bus_mod_rc43                     := bus_mod_rc43;
                    self.bus_mod_rc4                      := bus_mod_rc4;
                    self.bus_mod_rc23                     := bus_mod_rc23;
                    self.bus_mod_rc6                      := bus_mod_rc6;
                    self.bus_mod_rc35                     := bus_mod_rc35;
                    self.bus_mod_rc18                     := bus_mod_rc18;
                    self.bus_mod_rc5                      := bus_mod_rc5;
                    self.bus_mod_rc45                     := bus_mod_rc45;
                    self.bus_mod_rc48                     := bus_mod_rc48;
                    self.slbb_rc4                         := slbb_rc4;
                    self.slbb_rc1                         := slbb_rc1;
                    self.slbb_rc3                         := slbb_rc3;
                    self.slbb_rc2                         := slbb_rc2;

										SELF.clam := ri;
										SELF.busShell := le;
	#else
		SELF.ri := PROJECT(reasonCodes, TRANSFORM(Risk_Indicators.Layout_Desc,
																							SELF.hri := LEFT.hri,
																							SELF.desc := Risk_Indicators.getHRIDesc(LEFT.hri)
																					));
		SELF.score := (STRING3)SLBB1809_0_0;
		SELF.seq := le.input_echo.seq;
	#end
	END;

		model := JOIN(BusShell, Clam, LEFT.Input_Echo.seq = RIGHT.seq, doModel(LEFT, RIGHT), LEFT OUTER, KEEP(1));
	RETURN(model);
END;
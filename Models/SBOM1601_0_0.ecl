IMPORT Models, Risk_Indicators, RiskWise, RiskWiseFCRA, RiskView, UT, Business_Risk_BIP, std;

EXPORT SBOM1601_0_0 (GROUPED DATASET(Business_Risk_BIP.Layouts.Shell) busShell /*, other parameters?? */) := FUNCTION

	MODEL_DEBUG := FALSE;

	#if(MODEL_DEBUG)
		Layout_Debug := RECORD
			BOOLEAN source_ar;
			BOOLEAN source_ba;
			BOOLEAN source_bm;
			BOOLEAN source_c;
			BOOLEAN source_cs;
			BOOLEAN source_dn;
			BOOLEAN source_ef;
			BOOLEAN source_ft;
			BOOLEAN source_i;
			BOOLEAN source_ia;
			BOOLEAN source_in;
			BOOLEAN source_l2;
			BOOLEAN source_p;
			BOOLEAN source_ut;
			BOOLEAN source_v2;
			BOOLEAN source_wk;
			INTEGER sysdate;
			INTEGER sysdate_days;
			INTEGER _ver_src_id_br_pos;
			BOOLEAN _ver_src_id__br;
			INTEGER _ver_src_id_c_pos;
			BOOLEAN _ver_src_id__c;
			STRING _ver_src_id_fdate_c;
			INTEGER _ver_src_id_fdate_c2;
			INTEGER mth__ver_src_id_fdate_c;
			INTEGER _ver_src_id_d_pos;
			BOOLEAN _ver_src_id__d;
			INTEGER _ver_src_id_df_pos;
			BOOLEAN _ver_src_id__df;
			INTEGER _ver_src_id_dn_pos;
			BOOLEAN _ver_src_id__dn;
			INTEGER _ver_src_id_fb_pos;
			BOOLEAN _ver_src_id__fb;
			INTEGER _ver_src_id_l0_pos;
			BOOLEAN _ver_src_id__l0;
			INTEGER _ver_src_id_l2_pos;
			BOOLEAN _ver_src_id__l2;
			INTEGER _ver_src_id_u2_pos;
			BOOLEAN _ver_src_id__u2;
			INTEGER _ver_src_id_ar_pos;
			BOOLEAN _ver_src_id__ar;
			INTEGER _ver_src_id_ba_pos;
			BOOLEAN _ver_src_id__ba;
			INTEGER _ver_src_id_bm_pos;
			BOOLEAN _ver_src_id__bm;
			INTEGER _ver_src_id_bn_pos;
			BOOLEAN _ver_src_id__bn;
			INTEGER _ver_src_id_cu_pos;
			BOOLEAN _ver_src_id__cu;
			INTEGER _ver_src_id_da_pos;
			BOOLEAN _ver_src_id__da;
			INTEGER _ver_src_id_ef_pos;
			BOOLEAN _ver_src_id__ef;
			INTEGER _ver_src_id_fi_pos;
			BOOLEAN _ver_src_id__fi;
			INTEGER _ver_src_id_i_pos;
			BOOLEAN _ver_src_id__i;
			INTEGER _ver_src_id_ia_pos;
			BOOLEAN _ver_src_id__ia;
			INTEGER _ver_src_id_in_pos;
			BOOLEAN _ver_src_id__in;
			INTEGER _ver_src_id_os_pos;
			BOOLEAN _ver_src_id__os;
			INTEGER _ver_src_id_p_pos;
			BOOLEAN _ver_src_id__p;
			STRING _ver_src_id_ldate_p;
			BOOLEAN _ver_src_id_ldate_p2;
			INTEGER mth__ver_src_id_ldate_p;
			INTEGER _ver_src_id_pl_pos;
			BOOLEAN _ver_src_id__pl;
			INTEGER _ver_src_id_q3_pos;
			BOOLEAN _ver_src_id__q3;
			STRING _ver_src_id_fdate_q3;
			INTEGER _ver_src_id_fdate_q32;
			INTEGER mth__ver_src_id_fdate_q3;
			INTEGER _ver_src_id_sk_pos;
			BOOLEAN _ver_src_id__sk;
			INTEGER _ver_src_id_tx_pos;
			BOOLEAN _ver_src_id__tx;
			INTEGER _ver_src_id_v2_pos;
			BOOLEAN _ver_src_id__v2;
			INTEGER _ver_src_id_fdate_v22;
			INTEGER mth__ver_src_id_fdate_v2;
			INTEGER _ver_src_id_ldate_v22;
			INTEGER mth__ver_src_id_ldate_v2;
			INTEGER _ver_src_id_wa_pos;
			BOOLEAN _ver_src_id__wa;
			INTEGER _ver_src_id_by_pos;
			BOOLEAN _ver_src_id__by;
			INTEGER _ver_src_id_cf_pos;
			BOOLEAN _ver_src_id__cf;
			INTEGER _ver_src_id_e_pos;
			BOOLEAN _ver_src_id__e;
			INTEGER _ver_src_id_ey_pos;
			BOOLEAN _ver_src_id__ey;
			INTEGER _ver_src_id_f_pos;
			BOOLEAN _ver_src_id__f;
			INTEGER _ver_src_id_fk_pos;
			BOOLEAN _ver_src_id__fk;
			INTEGER _ver_src_id_fr_pos;
			BOOLEAN _ver_src_id__fr;
			INTEGER _ver_src_id_ft_pos;
			BOOLEAN _ver_src_id__ft;
			INTEGER _ver_src_id_gr_pos;
			BOOLEAN _ver_src_id__gr;
			INTEGER _ver_src_id_h7_pos;
			BOOLEAN _ver_src_id__h7;
			INTEGER _ver_src_id_ic_pos;
			BOOLEAN _ver_src_id__ic;
			INTEGER _ver_src_id_ip_pos;
			BOOLEAN _ver_src_id__ip;
			INTEGER _ver_src_id_is_pos;
			BOOLEAN _ver_src_id__is;
			INTEGER _ver_src_id_it_pos;
			BOOLEAN _ver_src_id__it;
			INTEGER _ver_src_id_j2_pos;
			BOOLEAN _ver_src_id__j2;
			INTEGER _ver_src_id_kc_pos;
			BOOLEAN _ver_src_id__kc;
			INTEGER _ver_src_id_mh_pos;
			BOOLEAN _ver_src_id__mh;
			INTEGER _ver_src_id_mw_pos;
			BOOLEAN _ver_src_id__mw;
			INTEGER _ver_src_id_np_pos;
			BOOLEAN _ver_src_id__np;
			INTEGER _ver_src_id_nr_pos;
			BOOLEAN _ver_src_id__nr;
			INTEGER _ver_src_id_sa_pos;
			BOOLEAN _ver_src_id__sa;
			INTEGER _ver_src_id_sb_pos;
			BOOLEAN _ver_src_id__sb;
			INTEGER _ver_src_id_sg_pos;
			BOOLEAN _ver_src_id__sg;
			INTEGER _ver_src_id_sj_pos;
			BOOLEAN _ver_src_id__sj;
			INTEGER _ver_src_id_sp_pos;
			BOOLEAN _ver_src_id__sp;
			INTEGER _ver_src_id_ut_pos;
			BOOLEAN _ver_src_id__ut;
			INTEGER _ver_src_id_v_pos;
			BOOLEAN _ver_src_id__v;
			INTEGER _ver_src_id_wb_pos;
			BOOLEAN _ver_src_id__wb;
			INTEGER _ver_src_id_wc_pos;
			BOOLEAN _ver_src_id__wc;
			INTEGER _ver_src_id_wk_pos;
			BOOLEAN _ver_src_id__wk;
			INTEGER _ver_src_id_wx_pos;
			BOOLEAN _ver_src_id__wx;
			INTEGER _ver_src_id_zo_pos;
			BOOLEAN _ver_src_id__zo;
			INTEGER _ver_src_id_y_pos;
			BOOLEAN _ver_src_id__y;
			INTEGER _ver_src_id_gb_pos;
			BOOLEAN _ver_src_id__gb;
			STRING _ver_src_id_fdate_gb;
			INTEGER _ver_src_id_fdate_gb2;
			INTEGER mth__ver_src_id_fdate_gb;
			STRING _ver_src_id_ldate_gb;
			INTEGER _ver_src_id_ldate_gb2;
			INTEGER mth__ver_src_id_ldate_gb;
			INTEGER _ver_src_id_cs_pos;
			BOOLEAN _ver_src_id__cs;
			INTEGER _ne_ver_src_id_count;
			BOOLEAN truebiz;
			STRING ne_bv_truebiz_category;
			STRING seg_business_score;
			INTEGER vs_gb_id_mth_fseen;
			INTEGER vs_gb_id_mth_lseen;
			BOOLEAN vs_ver_src_id__ut;
			BOOLEAN vs_ver_src_id__bm;
			BOOLEAN vs_ver_src_id__i;
			INTEGER vs_v2_id_mth_fseen;
			INTEGER vs_v2_id_mth_lseen;
			REAL b_vs_gb_id_mth_fseen_w;
			REAL b_vs_gb_id_mth_lseen_w;
			REAL b_vs_ver_src_id__ut_w;
			REAL b_vs_ver_src_id__bm_w;
			REAL b_vs_ver_src_id__i_w;
			REAL b_vs_v2_id_mth_fseen_w;
			REAL b_vs_v2_id_mth_lseen_w;
			REAL bv_bus_only_source_profile;
			INTEGER td_sbfe_worst_perf84;
			INTEGER td_sbfe_avg_util_pct06;
			REAL bv_assoc_derog_pct;
			INTEGER td_acct_dpd_1p_recency;
			INTEGER _sbfe_acct_datefirstopen;
			INTEGER td_mth_acct_firstopen;
			INTEGER td_sbfe_avg_util_pct_cc;
			INTEGER td_sbfe_util_pct_cc;
			INTEGER _sos_inc_filing_firstseen;
			INTEGER bv_sos_mth_fs;
			INTEGER bv_sos_index;
			INTEGER td_sbfe_util_pct_oel;
			REAL td_sbfe_closed_pct_invol;
			INTEGER td_acct_dpd_31p_recency;
			INTEGER td_sbfe_satis_cnt_loan;
			INTEGER bv_inq_highrisk_recency;
			INTEGER num_pos_sources;
			INTEGER num_neg_sources;
			REAL bv_ver_src_derog_ratio;
			INTEGER bv_mth_ver_src_q3_fs;
			INTEGER td_sbfe_util_pct_ge75_cnt_cc;
			INTEGER bv_lien_filed_recency;
			REAL td_past_due_pct_of_limit_lse;
			INTEGER td_occ_dpd_31p_cnt24;
			INTEGER _sbfe_datefirstseen;
			REAL td_mth_sbfe_datefirstseen;
			INTEGER bv_judg_filed_recency;
			INTEGER td_acct_dpd_61p_cnt12;
			REAL td_acct_pct_closed;
			INTEGER _sbfe_datelastseen;
			INTEGER td_mth_sbfe_datelastseen;
			INTEGER _sbfe_dlq_datelastseen;
			INTEGER td_mth_dlq_lastseen;
			REAL td_past_due_pct_of_balance;
			INTEGER _inq_lastseen;
			REAL bv_mths_inq_lastseen;
			INTEGER bv_prop_assessed_value;
			INTEGER bv_assoc_judg_tot;
			REAL bv_mth_ver_src_p_ls;
			INTEGER bv_lien_judg_index;
			INTEGER bv_assoc_felony_ct;
			REAL bv_mth_ver_src_c_fs;
			INTEGER bv_inq_highrisk_count;
			INTEGER bv_assoc_lien_tot;
			REAL s_bv_assoc_derog_pct_w;
			REAL s_aa_dist_1;
			STRING s_aa_code_1;
			REAL s_bv_sos_index_w;
			REAL s_aa_dist_2;
			STRING s_aa_code_2;
			REAL s_bv_lien_filed_recency_w;
			REAL s_aa_dist_3;
			STRING s_aa_code_3;
			REAL s_bv_judg_filed_recency_w;
			REAL s_aa_dist_4;
			STRING s_aa_code_4;
			REAL s_bv_inq_highrisk_recency_w;
			REAL s_aa_dist_5;
			STRING s_aa_code_5;
			REAL s_td_mth_sbfe_datefirstseen_w;
			REAL s_aa_dist_6;
			STRING s_aa_code_6;
			REAL s_td_mth_acct_firstopen_w;
			REAL s_aa_dist_7;
			STRING s_aa_code_7;
			REAL s_td_mth_dlq_lastseen_w;
			REAL s_aa_dist_8;
			STRING s_aa_code_8;
			REAL s_td_pd_pct_of_limit_lse_w;
			REAL s_aa_dist_9;
			STRING s_aa_code_9;
			REAL s_td_acct_dpd_1p_recency_w;
			REAL s_aa_dist_10;
			STRING s_aa_code_10;
			REAL s_td_acct_dpd_31p_recency_w;
			REAL s_aa_dist_11;
			STRING s_aa_code_11;
			REAL s_td_sbfe_closed_pct_invol_w;
			REAL s_aa_dist_12;
			STRING s_aa_code_12;
			REAL s_td_sbfe_util_pct_oel_w;
			REAL s_aa_dist_13;
			STRING s_aa_code_13;
			REAL s_td_sbfe_util_pct75_cnt_cc_w;
			REAL s_aa_dist_14;
			STRING s_aa_code_14;
			REAL s_td_sbfe_avg_util_pct06_w;
			REAL s_aa_dist_15;
			STRING s_aa_code_15;
			REAL s_td_sbfe_avg_util_pct_cc_w;
			REAL s_aa_dist_16;
			STRING s_aa_code_16;
			REAL s_bv_mth_ver_src_q3_fs_w;
			REAL s_aa_dist_17;
			STRING s_aa_code_17;
			REAL s_bv_ver_src_derog_ratio_w;
			REAL s_aa_dist_18;
			STRING s_aa_code_18;
			REAL s_bv_bus_only_source_profile_w;
			REAL s_aa_dist_19;
			STRING s_aa_code_19;
			REAL s_td_occ_dpd_31p_cnt24_w;
			REAL s_aa_dist_20;
			STRING s_aa_code_20;
			REAL s_td_sbfe_satis_cnt_loan_w;
			REAL s_aa_dist_21;
			STRING s_aa_code_21;
			REAL s_td_sbfe_util_pct_cc_w;
			REAL s_aa_dist_22;
			STRING s_aa_code_22;
			REAL s_td_mth_sbfe_datelastseen_w;
			REAL s_aa_dist_23;
			STRING s_aa_code_23;
			REAL s_td_past_due_pct_of_balance_w;
			REAL s_aa_dist_24;
			STRING s_aa_code_24;
			REAL s_td_acct_pct_closed_w;
			REAL s_aa_dist_25;
			STRING s_aa_code_25;
			REAL s_td_acct_dpd_61p_cnt12_w;
			REAL s_aa_dist_26;
			STRING s_aa_code_26;
			REAL s_td_sbfe_worst_perf84_w;
			REAL s_aa_dist_27;
			STRING s_aa_code_27;
			REAL s_rcvalueb037;
			REAL s_rcvalueb034;
			REAL s_rcvalueb031;
			REAL s_rcvalueb017;
			REAL s_rcvaluebf142;
			REAL s_rcvaluebf135;
			REAL s_rcvaluebf134;
			REAL s_rcvaluebf136;
			REAL s_rcvaluebf117;
			REAL s_rcvaluebf133;
			REAL s_rcvalueb040;
			REAL s_rcvaluebf141;
			REAL s_rcvalueb026;
			REAL s_rcvaluebf143;
			REAL s_rcvalueb063;
			REAL s_rcvaluebf126;
			REAL s_rcvaluebf127;
			REAL s_rcvaluebf125;
			REAL s_rcvaluebf120;
			REAL s_rcvaluebf105;
			REAL s_rcvaluebf106;
			REAL s_rcvaluebf107;
			REAL s_rcvaluebf128;
			REAL s_rcvaluebf129;
			REAL s_rcvaluebf113;
			REAL s_rcvaluebf110;
			REAL s_rcvalueb055;
			REAL s_rcvalueb057;
			REAL s_rcvalueb059;
			REAL s_final_score;
			REAL l_bv_assoc_felony_ct_w;
			REAL l_aa_dist_1;
			STRING l_aa_code_1;
			REAL l_bv_assoc_lien_tot_w;
			REAL l_aa_dist_2;
			STRING l_aa_code_2;
			REAL l_bv_assoc_judg_tot_w;
			REAL l_aa_dist_3;
			STRING l_aa_code_3;
			REAL l_bv_assoc_derog_pct_w;
			REAL l_aa_dist_4;
			STRING l_aa_code_4;
			REAL l_bv_sos_mth_fs_w;
			REAL l_aa_dist_5;
			STRING l_aa_code_5;
			REAL l_bv_lien_judg_index_w;
			REAL l_aa_dist_6;
			STRING l_aa_code_6;
			REAL l_bv_prop_assessed_value_w;
			REAL l_aa_dist_7;
			STRING l_aa_code_7;
			REAL l_bv_inq_highrisk_count_w;
			REAL l_aa_dist_8;
			STRING l_aa_code_8;
			REAL l_bv_mth_ver_src_c_fs_w;
			REAL l_aa_dist_9;
			STRING l_aa_code_9;
			REAL l_bv_mth_ver_src_p_ls_w;
			REAL l_aa_dist_10;
			STRING l_aa_code_10;
			REAL l_bv_mth_ver_src_q3_fs_w;
			REAL l_aa_dist_11;
			STRING l_aa_code_11;
			REAL l_bv_ver_src_derog_ratio_w;
			REAL l_aa_dist_12;
			STRING l_aa_code_12;
			REAL l_bv_bus_only_source_profile_w;
			REAL l_aa_dist_13;
			STRING l_aa_code_13;
			REAL l_bv_mths_inq_lastseen_w;
			REAL l_aa_dist_14;
			STRING l_aa_code_14;
			STRING l_aa_code_15;
			REAL l_aa_dist_15;
			REAL l_rcvalueb037;
			REAL l_rcvalueb026;
			REAL l_rcvalueb034;
			REAL l_rcvalueb040;
			REAL l_rcvalueb031;
			REAL l_rcvalueb017;
			REAL l_rcvalueb063;
			REAL l_rcvalueb038;
			REAL l_rcvalueb053;
			REAL l_rcvalueb052;
			REAL l_rcvalueb055;
			REAL l_rcvalueb057;
			REAL l_rcvaluebf108;
			REAL l_final_score;
			INTEGER base;
			INTEGER pts;
			REAL lgt;
			REAL bus_mod_final_lgt;
			INTEGER _sbom1601_0_0;
			STRING l_rc1;
			STRING l_rc2;
			STRING l_rc3;
			STRING l_rc4;
			STRING l_rc5;
			STRING l_rc6;
			STRING l_rc7;
			STRING l_rc8;
			STRING l_rc9;
			STRING l_rc10;
			STRING l_rc11;
			STRING l_rc12;
			STRING l_rc13;
			STRING l_rc14;
			STRING l_rc15;
			STRING l_rc16;
			STRING l_rc17;
			STRING l_rc18;
			STRING l_rc19;
			STRING l_rc20;
			STRING l_rc21;
			STRING l_rc22;
			STRING l_rc23;
			STRING l_rc24;
			STRING l_rc25;
			STRING l_rc26;
			STRING l_rc27;
			STRING l_rc28;
			STRING l_rc29;
			STRING l_rc30;
			STRING l_rc31;
			STRING l_rc32;
			STRING l_rc33;
			STRING l_rc34;
			STRING l_rc35;
			STRING l_rc36;
			STRING l_rc37;
			STRING l_rc38;
			STRING l_rc39;
			STRING l_rc40;
			STRING l_rc41;
			STRING l_rc42;
			STRING l_rc43;
			STRING l_rc44;
			STRING l_rc45;
			STRING l_rc46;
			STRING l_rc47;
			STRING l_rc48;
			STRING l_rc49;
			STRING l_rc50;
			STRING s_rc1;
			STRING s_rc2;
			STRING s_rc3;
			STRING s_rc4;
			STRING s_rc5;
			STRING s_rc6;
			STRING s_rc7;
			STRING s_rc8;
			STRING s_rc9;
			STRING s_rc10;
			STRING s_rc11;
			STRING s_rc12;
			STRING s_rc13;
			STRING s_rc14;
			STRING s_rc15;
			STRING s_rc16;
			STRING s_rc17;
			STRING s_rc18;
			STRING s_rc19;
			STRING s_rc20;
			STRING s_rc21;
			STRING s_rc22;
			STRING s_rc23;
			STRING s_rc24;
			STRING s_rc25;
			STRING s_rc26;
			STRING s_rc27;
			STRING s_rc28;
			STRING s_rc29;
			STRING s_rc30;
			STRING s_rc31;
			STRING s_rc32;
			STRING s_rc33;
			STRING s_rc34;
			STRING s_rc35;
			STRING s_rc36;
			STRING s_rc37;
			STRING s_rc38;
			STRING s_rc39;
			STRING s_rc40;
			STRING s_rc41;
			STRING s_rc42;
			STRING s_rc43;
			STRING s_rc44;
			STRING s_rc45;
			STRING s_rc46;
			STRING s_rc47;
			STRING s_rc48;
			STRING s_rc49;
			STRING s_rc50;
			STRING bus_mod_rc16;
			STRING bus_mod_rc42;
			STRING bus_mod_rc8;
			STRING bus_mod_rc29;
			STRING bus_mod_rc44;
			STRING bus_mod_rc3;
			STRING bus_mod_rc45;
			STRING bus_mod_rc17;
			STRING bus_mod_rc21;
			STRING bus_mod_rc22;
			STRING bus_mod_rc34;
			STRING bus_mod_rc9;
			STRING bus_mod_rc23;
			STRING bus_mod_rc2;
			STRING bus_mod_rc36;
			STRING bus_mod_rc35;
			STRING bus_mod_rc50;
			STRING bus_mod_rc10;
			STRING bus_mod_rc6;
			STRING bus_mod_rc26;
			STRING bus_mod_rc25;
			STRING bus_mod_rc48;
			STRING bus_mod_rc40;
			STRING bus_mod_rc28;
			STRING bus_mod_rc4;
			STRING bus_mod_rc33;
			STRING bus_mod_rc13;
			STRING bus_mod_rc41;
			STRING bus_mod_rc43;
			STRING bus_mod_rc31;
			STRING bus_mod_rc27;
			STRING bus_mod_rc37;
			STRING bus_mod_rc49;
			INTEGER sbom1601_0_0;
			STRING bus_mod_rc39;
			STRING bus_mod_rc1;
			STRING bus_mod_rc32;
			STRING bus_mod_rc46;
			STRING bus_mod_rc12;
			STRING bus_mod_rc47;
			STRING bus_mod_rc30;
			STRING bus_mod_rc11;
			STRING bus_mod_rc20;
			STRING bus_mod_rc18;
			STRING bus_mod_rc5;
			STRING bus_mod_rc7;
			STRING bus_mod_rc24;
			STRING bus_mod_rc38;
			STRING bus_mod_rc19;
			STRING bus_mod_rc14;
			STRING bus_mod_rc15;
			STRING sbom_rc2;
			STRING sbom_rc1;
			STRING sbom_rc4;
			STRING sbom_rc3;
			Business_Risk_BIP.Layouts.OutputLayout busShell;
		END;
		Layout_Debug doModel(BusShell le) := TRANSFORM
	#else
		Models.Layout_ModelOut doModel(BusShell le) := TRANSFORM
	#end

	/* ***********************************************************
	 *             Model Input Variable Assignments              *
	 ************************************************************* */
			MaxSASLength := 1000; // Max length for the list fields to be imported into SAS (Technically SAS can handle up to 32,767 - but modeling only wants 1,000 to help with speed of imports)
	
			
	ver_src_list                     := Business_Risk_BIP.Common.truncate_list(le.Verification.sourcelist, MaxSASLength);
	history_date                     := le.Input_Echo.historydate;
	history_datetime                 := le.Input_Echo.historydatetime;
	ver_src_id_firstseen_list        := Business_Risk_BIP.Common.truncate_list(le.Verification.sourcedatefirstseenlistID, MaxSASLength);
	ver_src_id_list                  := Business_Risk_BIP.Common.truncate_list(le.Verification.sourcelistID, MaxSASLength);
	ver_src_id_lastseen_list         := Business_Risk_BIP.Common.truncate_list(le.Verification.sourcedatelastseenlistID, MaxSASLength);
	ver_src_id_count                 := le.Verification.SourceCountID;
	id_seleid                        := le.Verification.inputidmatchseleid;
	sbfe_acct_cnt                    := le.SBFE.SBFEAccountCount;
	sbfe_worst_perf84                := le.SBFE.SBFEWorst84;
	sbfe_avg_util_pct06              := le.SBFE.SBFEUtilizationAve06;
	assoc_count                      := le.Associates.AssociateCount;
	assoc_felony_count               := le.Associates.AssociateCountWithFelony;
	assoc_bankruptcy_count           := le.Associates.AssociateCountWithBankruptcy;
	assoc_lien_count                 := le.Associates.AssociateCountWithLien;
	assoc_judg_count                 := le.Associates.AssociateCountWithJudgment;
	sbfe_acct_dpd_1p_cnt00           := le.SBFE.SBFEDPD1Count;
	sbfe_acct_dpd_1p_cnt06           := le.SBFE.SBFEDPD1Count06;
	sbfe_acct_dpd_1p_cnt12           := le.SBFE.SBFEDPD1Count12;
	sbfe_acct_dpd_1p_cnt24           := le.SBFE.SBFEDPD1Count24;
	sbfe_acct_dpd_1p_cnt36           := le.SBFE.SBFEDPD1Count36;
	sbfe_acct_dpd_1p_cnt60           := le.SBFE.SBFEDPD1Count60;
	sbfe_acct_dpd_1p_cnt84           := le.SBFE.SBFEDPD1Count84;
	sbfe_acct_dpd_1p_cnt             := le.SBFE.SBFEDPD1CountEver;
	sbfe_acct_datefirstopen          := le.SBFE.SBFEDateOpenFirstSeenAll;
	sbfe_avg_util_pct_cc             := le.SBFE.SBFEUtilizationAveEverCard;
	sbfe_util_pct_cc                 := le.SBFE.SBFEUtilizationCurrentCard;
	sos_inc_filing_firstseen         := le.SOS.SOSIncorporationDateFirstSeen;
	sos_ever_defunct                 := le.SOS.soseverdefunct;
	sos_inc_filing_count             := le.SOS.SOSIncorporationCount;
	sbfe_util_pct_oel                := le.SBFE.SBFEUtilizationCurrentOLine;
	sbfe_closed_cnt                  := le.SBFE.SBFEClosedCount;
	sbfe_closed_cnt_invol            := le.SBFE.SBFEClosedCountInvoluntary;
	sbfe_acct_dpd_31p_cnt00          := le.SBFE.SBFEDPD31Count;
	sbfe_acct_dpd_31p_cnt06          := le.SBFE.SBFEDPD31Count06;
	sbfe_acct_dpd_31p_cnt12          := le.SBFE.SBFEDPD31Count12;
	sbfe_acct_dpd_31p_cnt24          := le.SBFE.SBFEDPD31Count24;
	sbfe_acct_dpd_31p_cnt36          := le.SBFE.SBFEDPD31Count36;
	sbfe_acct_dpd_31p_cnt60          := le.SBFE.SBFEDPD31Count60;
	sbfe_acct_dpd_31p_cnt84          := le.SBFE.SBFEDPD31Count84;
	sbfe_acct_dpd_31p_cnt            := le.SBFE.SBFEDPD31CountEver;
	sbfe_satis_cnt_loan              := le.SBFE.SBFESatisfactoryCountLoan;
	inq_highrisk_count03             := le.Inquiry.InquiryHighRisk03Month;
	inq_highrisk_count06             := le.Inquiry.InquiryHighRisk06Month;
	inq_highrisk_count12             := le.Inquiry.InquiryHighRisk12Month;
	inq_highrisk_count24             := le.Inquiry.InquiryHighRisk24Month;
	inq_highrisk_count               := le.Inquiry.InquiryHighRiskCount;
	sbfe_util_pct_ge75_cnt_cc        := le.SBFE.SBFEUtilization75Card;
	lien_filed_count03               := le.Lien_And_Judgment.LienFiledCount03;
	lien_filed_count06               := le.Lien_And_Judgment.LienFiledCount06;
	lien_filed_count12               := le.Lien_And_Judgment.LienFiledCount12;
	lien_filed_count24               := le.Lien_And_Judgment.LienFiledCount24;
	lien_filed_count36               := le.Lien_And_Judgment.LienFiledCount36;
	lien_filed_count60               := le.Lien_And_Judgment.LienFiledCount60;
	lien_filed_count                 := le.Lien_And_Judgment.LienCount;
	sbfe_past_due_amt_lse            := le.SBFE.SBFEDPDAmountLease;
	sbfe_orig_amt_lse                := le.SBFE.SBFEOriginalLimitLease;
	sbfe_occ_dpd_31p_cnt24           := le.SBFE.SBFEDPD31OccurCount24;
	sbfe_datefirstseen               := le.SBFE.SBFEDateFirstCycleAll;
	judg_filed_count03               := le.Lien_And_Judgment.JudgmentFiledCount03;
	judg_filed_count06               := le.Lien_And_Judgment.JudgmentFiledCount06;
	judg_filed_count12               := le.Lien_And_Judgment.JudgmentFiledCount12;
	judg_filed_count24               := le.Lien_And_Judgment.JudgmentFiledCount24;
	judg_filed_count36               := le.Lien_And_Judgment.JudgmentFiledCount36;
	judg_filed_count60               := le.Lien_And_Judgment.JudgmentFiledCount60;
	judg_filed_count                 := le.Lien_And_Judgment.JudgmentCount;
	sbfe_acct_dpd_61p_cnt12          := le.SBFE.SBFEDelinquentCount12;
	sbfe_datelastseen                := le.SBFE.SBFEDateLastCycleAll;
	sbfe_dlq_datelastseen            := le.SBFE.SBFEDPDDateLastSeen;
	sbfe_past_due_amt                := le.SBFE.SBFEDPDAmount;
	sbfe_balance                     := le.SBFE.SBFERecentBalanceAll;
	inq_lastseen                     := le.Inquiry.InquiryDateLastSeen;
	prop_count                       := le.Asset_Information.AssetPropertyCount;
	prop_assessed_value_total        := le.Asset_Information.AssetPropertyAssessedTotal;
	assoc_judg_total                 := le.Associates.AssociateJudgmentCount;
	assoc_lien_total                 := le.Associates.AssociateLienCount;
	sbfe_acct_dpd_91p_cnt84          := le.SBFE.SBFEDPD91Count84;
	sbfe_past_due_amt_91p_lse        := le.SBFE.SBFEDPD91AmountLease;
	sbfe_acct_dpd_91p_cnt06          := le.SBFE.SBFEDPD91Count06;
	sbfe_acct_dpd_91p_cnt00          := le.SBFE.SBFEDPD91Count;
	sbfe_chargeoff_cnt               := le.SBFE.SBFEChargeoffCount;
	sbfe_avg_util_pct06_cc           := le.SBFE.SBFEUtilizationAve06Card;
	sbfe_occ_dpd_91p_cnt24           := le.SBFE.SBFEDPD91OccurCount24;
	sbfe_acct_dpd_91p_cnt00_loan     := le.SBFE.SBFEDPD91CountLoan;
	sbfe_past_due_amt_91p            := le.SBFE.SBFEDPD91Amount;
	sbfe_acct_dpd_91p_cnt12          := le.SBFE.SBFEDPD91Count12;



	/* ***********************************************************
	 *                    Generated ECL                          *
	 ************************************************************* */
NULL := __common__( -999999999 ) ;

source_ar := __common__( Models.Common.findw_cpp(ver_src_list, 'AR' ,  , '') > 0 ) ;

source_ba := __common__( Models.Common.findw_cpp(ver_src_list, 'BA' ,  , '') > 0 ) ;

source_bm := __common__( Models.Common.findw_cpp(ver_src_list, 'BM' ,  , '') > 0 ) ;

source_c := __common__( Models.Common.findw_cpp(ver_src_list, 'C' ,  , '') > 0 ) ;

source_cs := __common__( Models.Common.findw_cpp(ver_src_list, 'C#' ,  , '') > 0 ) ;

source_dn := __common__( Models.Common.findw_cpp(ver_src_list, 'DN' ,  , '') > 0 ) ;

source_ef := __common__( Models.Common.findw_cpp(ver_src_list, 'EF' ,  , '') > 0 ) ;

source_ft := __common__( Models.Common.findw_cpp(ver_src_list, 'FT' ,  , '') > 0 ) ;

source_i := __common__( Models.Common.findw_cpp(ver_src_list, 'I' ,  , '') > 0 ) ;

source_ia := __common__( Models.Common.findw_cpp(ver_src_list, 'IA' ,  , '') > 0 ) ;

source_in := __common__( Models.Common.findw_cpp(ver_src_list, 'IN' ,  , '') > 0 ) ;

source_l2 := __common__( Models.Common.findw_cpp(ver_src_list, 'L2' ,  , '') > 0 ) ;

source_p := __common__( Models.Common.findw_cpp(ver_src_list, 'P' ,  , '') > 0 ) ;

source_ut := __common__( Models.Common.findw_cpp(ver_src_list, 'UT' ,  , '') > 0 ) ;

source_v2 := __common__( Models.Common.findw_cpp(ver_src_list, 'V2' ,  , '') > 0 ) ;

source_wk := __common__( Models.Common.findw_cpp(ver_src_list, 'WK' ,  , '') > 0 ) ;

sysdate := __common__( common.sas_date(if(history_date=999999 or history_date = 0, (STRING)Std.Date.Today(), (string6)history_date+'01')) ) ;

sysdate_days := __common__( common.sas_date(if(((string)history_datetime)[1..6]='999999' or history_datetime = 0, (string)Std.Date.Today(), (string)history_datetime)) ) ;

_ver_src_id_br_pos := __common__( Models.Common.findw_cpp(ver_src_id_list, 'BR' , '  ,', 'ie') ) ;

_ver_src_id__br := __common__( _ver_src_id_br_pos > 0 ) ;

_ver_src_id_c_pos := __common__( Models.Common.findw_cpp(ver_src_id_list, 'C' , '  ,', 'ie') ) ;

_ver_src_id__c := __common__( _ver_src_id_c_pos > 0 ) ;

_ver_src_id_fdate_c := __common__( if(_ver_src_id_c_pos > 0, Models.Common.getw(ver_src_id_firstseen_list, _ver_src_id_c_pos), '0') ) ;

_ver_src_id_fdate_c2 := __common__( common.sas_date((string)(_ver_src_id_fdate_c)) ) ;

mth__ver_src_id_fdate_c := __common__( if(min(sysdate, _ver_src_id_fdate_c2) = NULL, NULL, ROUNDUP((sysdate - _ver_src_id_fdate_c2) / 30.5)) ) ;

_ver_src_id_d_pos := __common__( Models.Common.findw_cpp(ver_src_id_list, 'D' , '  ,', 'ie') ) ;

_ver_src_id__d := __common__( _ver_src_id_d_pos > 0 ) ;

_ver_src_id_df_pos := __common__( Models.Common.findw_cpp(ver_src_id_list, 'DF' , '  ,', 'ie') ) ;

_ver_src_id__df := __common__( _ver_src_id_df_pos > 0 ) ;

_ver_src_id_dn_pos := __common__( Models.Common.findw_cpp(ver_src_id_list, 'DN' , '  ,', 'ie') ) ;

_ver_src_id__dn := __common__( _ver_src_id_dn_pos > 0 ) ;

_ver_src_id_fb_pos := __common__( Models.Common.findw_cpp(ver_src_id_list, 'FB' , '  ,', 'ie') ) ;

_ver_src_id__fb := __common__( _ver_src_id_fb_pos > 0 ) ;

_ver_src_id_l0_pos := __common__( Models.Common.findw_cpp(ver_src_id_list, 'L0' , '  ,', 'ie') ) ;

_ver_src_id__l0 := __common__( _ver_src_id_l0_pos > 0 ) ;

_ver_src_id_l2_pos := __common__( Models.Common.findw_cpp(ver_src_id_list, 'L2' , '  ,', 'ie') ) ;

_ver_src_id__l2 := __common__( _ver_src_id_l2_pos > 0 ) ;

_ver_src_id_u2_pos := __common__( Models.Common.findw_cpp(ver_src_id_list, 'U2' , '  ,', 'ie') ) ;

_ver_src_id__u2 := __common__( _ver_src_id_u2_pos > 0 ) ;

_ver_src_id_ar_pos := __common__( Models.Common.findw_cpp(ver_src_id_list, 'AR' , '  ,', 'ie') ) ;

_ver_src_id__ar := __common__( _ver_src_id_ar_pos > 0 ) ;

_ver_src_id_ba_pos := __common__( Models.Common.findw_cpp(ver_src_id_list, 'BA' , '  ,', 'ie') ) ;

_ver_src_id__ba := __common__( _ver_src_id_ba_pos > 0 ) ;

_ver_src_id_bm_pos := __common__( Models.Common.findw_cpp(ver_src_id_list, 'BM' , '  ,', 'ie') ) ;

_ver_src_id__bm := __common__( _ver_src_id_bm_pos > 0 ) ;

_ver_src_id_bn_pos := __common__( Models.Common.findw_cpp(ver_src_id_list, 'BN' , '  ,', 'ie') ) ;

_ver_src_id__bn := __common__( _ver_src_id_bn_pos > 0 ) ;

_ver_src_id_cu_pos := __common__( Models.Common.findw_cpp(ver_src_id_list, 'CU' , '  ,', 'ie') ) ;

_ver_src_id__cu := __common__( _ver_src_id_cu_pos > 0 ) ;

_ver_src_id_da_pos := __common__( Models.Common.findw_cpp(ver_src_id_list, 'DA' , '  ,', 'ie') ) ;

_ver_src_id__da := __common__( _ver_src_id_da_pos > 0 ) ;

_ver_src_id_ef_pos := __common__( Models.Common.findw_cpp(ver_src_id_list, 'EF' , '  ,', 'ie') ) ;

_ver_src_id__ef := __common__( _ver_src_id_ef_pos > 0 ) ;

_ver_src_id_fi_pos := __common__( Models.Common.findw_cpp(ver_src_id_list, 'FI' , '  ,', 'ie') ) ;

_ver_src_id__fi := __common__( _ver_src_id_fi_pos > 0 ) ;

_ver_src_id_i_pos := __common__( Models.Common.findw_cpp(ver_src_id_list, 'I' , '  ,', 'ie') ) ;

_ver_src_id__i := __common__( _ver_src_id_i_pos > 0 ) ;

_ver_src_id_ia_pos := __common__( Models.Common.findw_cpp(ver_src_id_list, 'IA' , '  ,', 'ie') ) ;

_ver_src_id__ia := __common__( _ver_src_id_ia_pos > 0 ) ;

_ver_src_id_in_pos := __common__( Models.Common.findw_cpp(ver_src_id_list, 'IN' , '  ,', 'ie') ) ;

_ver_src_id__in := __common__( _ver_src_id_in_pos > 0 ) ;

_ver_src_id_os_pos := __common__( Models.Common.findw_cpp(ver_src_id_list, 'OS' , '  ,', 'ie') ) ;

_ver_src_id__os := __common__( _ver_src_id_os_pos > 0 ) ;

_ver_src_id_p_pos := __common__( Models.Common.findw_cpp(ver_src_id_list, 'P' , '  ,', 'ie') ) ;

_ver_src_id__p := __common__( _ver_src_id_p_pos > 0 ) ;

_ver_src_id_ldate_p := __common__( if(_ver_src_id_p_pos > 0, Models.Common.getw(ver_src_id_lastseen_list, _ver_src_id_p_pos), '0') ) ;

_ver_src_id_ldate_p2 := __common__( common.sas_date((string)(_ver_src_id_ldate_p)) ) ;

mth__ver_src_id_ldate_p := __common__( if(min(sysdate, _ver_src_id_ldate_p2) = NULL, NULL, ROUNDUP((sysdate - _ver_src_id_ldate_p2) / 30.5)) ) ;

_ver_src_id_pl_pos := __common__( Models.Common.findw_cpp(ver_src_id_list, 'PL' , '  ,', 'ie') ) ;

_ver_src_id__pl := __common__( _ver_src_id_pl_pos > 0 ) ;

_ver_src_id_q3_pos := __common__( Models.Common.findw_cpp(ver_src_id_list, 'Q3' , '  ,', 'ie') ) ;

_ver_src_id__q3 := __common__( _ver_src_id_q3_pos > 0 ) ;

_ver_src_id_fdate_q3 := __common__( if(_ver_src_id_q3_pos > 0, Models.Common.getw(ver_src_id_firstseen_list, _ver_src_id_q3_pos), '0') ) ;

_ver_src_id_fdate_q32 := __common__( common.sas_date((string)(_ver_src_id_fdate_q3)) ) ;

mth__ver_src_id_fdate_q3 := __common__( if(min(sysdate, _ver_src_id_fdate_q32) = NULL, NULL, ROUNDUP((sysdate - _ver_src_id_fdate_q32) / 30.5)) ) ;

_ver_src_id_sk_pos := __common__( Models.Common.findw_cpp(ver_src_id_list, 'SK' , '  ,', 'ie') ) ;

_ver_src_id__sk := __common__( _ver_src_id_sk_pos > 0 ) ;

_ver_src_id_tx_pos := __common__( Models.Common.findw_cpp(ver_src_id_list, 'TX' , '  ,', 'ie') ) ;

_ver_src_id__tx := __common__( _ver_src_id_tx_pos > 0 ) ;

_ver_src_id_v2_pos := __common__( Models.Common.findw_cpp(ver_src_id_list, 'V2' , '  ,', 'ie') ) ;

_ver_src_id__v2 := __common__( _ver_src_id_v2_pos > 0 ) ;

_ver_src_id_fdate_v2_1 := __common__( if(_ver_src_id_v2_pos > 0, Models.Common.getw(ver_src_id_firstseen_list, _ver_src_id_v2_pos), '0') ) ;

_ver_src_id_fdate_v22 := __common__( common.sas_date((string)(_ver_src_id_fdate_v2_1)) ) ;

mth__ver_src_id_fdate_v2 := __common__( if(min(sysdate, _ver_src_id_fdate_v22) = NULL, NULL, ROUNDUP((sysdate - _ver_src_id_fdate_v22) / 30.5)) ) ;

_ver_src_id_ldate_v2_1 := __common__( if(_ver_src_id_v2_pos > 0, Models.Common.getw(ver_src_id_lastseen_list, _ver_src_id_v2_pos), '0') ) ;

_ver_src_id_ldate_v22 := __common__( common.sas_date((string)(_ver_src_id_ldate_v2_1)) ) ;

mth__ver_src_id_ldate_v2 := __common__( if(min(sysdate, _ver_src_id_ldate_v22) = NULL, NULL, ROUNDUP((sysdate - _ver_src_id_ldate_v22) / 30.5)) ) ;

_ver_src_id_wa_pos := __common__( Models.Common.findw_cpp(ver_src_id_list, 'WA' , '  ,', 'ie') ) ;

_ver_src_id__wa := __common__( _ver_src_id_wa_pos > 0 ) ;

_ver_src_id_by_pos := __common__( Models.Common.findw_cpp(ver_src_id_list, 'BY' , '  ,', 'ie') ) ;

_ver_src_id__by := __common__( _ver_src_id_by_pos > 0 ) ;

_ver_src_id_cf_pos := __common__( Models.Common.findw_cpp(ver_src_id_list, 'CF' , '  ,', 'ie') ) ;

_ver_src_id__cf := __common__( _ver_src_id_cf_pos > 0 ) ;

_ver_src_id_e_pos := __common__( Models.Common.findw_cpp(ver_src_id_list, 'E' , '  ,', 'ie') ) ;

_ver_src_id__e := __common__( _ver_src_id_e_pos > 0 ) ;

_ver_src_id_ey_pos := __common__( Models.Common.findw_cpp(ver_src_id_list, 'EY' , '  ,', 'ie') ) ;

_ver_src_id__ey := __common__( _ver_src_id_ey_pos > 0 ) ;

_ver_src_id_f_pos := __common__( Models.Common.findw_cpp(ver_src_id_list, 'F' , '  ,', 'ie') ) ;

_ver_src_id__f := __common__( _ver_src_id_f_pos > 0 ) ;

_ver_src_id_fk_pos := __common__( Models.Common.findw_cpp(ver_src_id_list, 'FK' , '  ,', 'ie') ) ;

_ver_src_id__fk := __common__( _ver_src_id_fk_pos > 0 ) ;

_ver_src_id_fr_pos := __common__( Models.Common.findw_cpp(ver_src_id_list, 'FR' , '  ,', 'ie') ) ;

_ver_src_id__fr := __common__( _ver_src_id_fr_pos > 0 ) ;

_ver_src_id_ft_pos := __common__( Models.Common.findw_cpp(ver_src_id_list, 'FT' , '  ,', 'ie') ) ;

_ver_src_id__ft := __common__( _ver_src_id_ft_pos > 0 ) ;

_ver_src_id_gr_pos := __common__( Models.Common.findw_cpp(ver_src_id_list, 'GR' , '  ,', 'ie') ) ;

_ver_src_id__gr := __common__( _ver_src_id_gr_pos > 0 ) ;

_ver_src_id_h7_pos := __common__( Models.Common.findw_cpp(ver_src_id_list, 'H7' , '  ,', 'ie') ) ;

_ver_src_id__h7 := __common__( _ver_src_id_h7_pos > 0 ) ;

_ver_src_id_ic_pos := __common__( Models.Common.findw_cpp(ver_src_id_list, 'IC' , '  ,', 'ie') ) ;

_ver_src_id__ic := __common__( _ver_src_id_ic_pos > 0 ) ;

_ver_src_id_ip_pos := __common__( Models.Common.findw_cpp(ver_src_id_list, 'IP' , '  ,', 'ie') ) ;

_ver_src_id__ip := __common__( _ver_src_id_ip_pos > 0 ) ;

_ver_src_id_is_pos := __common__( Models.Common.findw_cpp(ver_src_id_list, 'IS' , '  ,', 'ie') ) ;

_ver_src_id__is := __common__( _ver_src_id_is_pos > 0 ) ;

_ver_src_id_it_pos := __common__( Models.Common.findw_cpp(ver_src_id_list, 'IT' , '  ,', 'ie') ) ;

_ver_src_id__it := __common__( _ver_src_id_it_pos > 0 ) ;

_ver_src_id_j2_pos := __common__( Models.Common.findw_cpp(ver_src_id_list, 'J2' , '  ,', 'ie') ) ;

_ver_src_id__j2 := __common__( _ver_src_id_j2_pos > 0 ) ;

_ver_src_id_kc_pos := __common__( Models.Common.findw_cpp(ver_src_id_list, 'KC' , '  ,', 'ie') ) ;

_ver_src_id__kc := __common__( _ver_src_id_kc_pos > 0 ) ;

_ver_src_id_mh_pos := __common__( Models.Common.findw_cpp(ver_src_id_list, 'MH' , '  ,', 'ie') ) ;

_ver_src_id__mh := __common__( _ver_src_id_mh_pos > 0 ) ;

_ver_src_id_mw_pos := __common__( Models.Common.findw_cpp(ver_src_id_list, 'MW' , '  ,', 'ie') ) ;

_ver_src_id__mw := __common__( _ver_src_id_mw_pos > 0 ) ;

_ver_src_id_np_pos := __common__( Models.Common.findw_cpp(ver_src_id_list, 'NP' , '  ,', 'ie') ) ;

_ver_src_id__np := __common__( _ver_src_id_np_pos > 0 ) ;

_ver_src_id_nr_pos := __common__( Models.Common.findw_cpp(ver_src_id_list, 'NR' , '  ,', 'ie') ) ;

_ver_src_id__nr := __common__( _ver_src_id_nr_pos > 0 ) ;

_ver_src_id_sa_pos := __common__( Models.Common.findw_cpp(ver_src_id_list, 'SA' , '  ,', 'ie') ) ;

_ver_src_id__sa := __common__( _ver_src_id_sa_pos > 0 ) ;

_ver_src_id_sb_pos := __common__( Models.Common.findw_cpp(ver_src_id_list, 'SB' , '  ,', 'ie') ) ;

_ver_src_id__sb := __common__( _ver_src_id_sb_pos > 0 ) ;

_ver_src_id_sg_pos := __common__( Models.Common.findw_cpp(ver_src_id_list, 'SG' , '  ,', 'ie') ) ;

_ver_src_id__sg := __common__( _ver_src_id_sg_pos > 0 ) ;

_ver_src_id_sj_pos := __common__( Models.Common.findw_cpp(ver_src_id_list, 'SJ' , '  ,', 'ie') ) ;

_ver_src_id__sj := __common__( _ver_src_id_sj_pos > 0 ) ;

_ver_src_id_sp_pos := __common__( Models.Common.findw_cpp(ver_src_id_list, 'SP' , '  ,', 'ie') ) ;

_ver_src_id__sp := __common__( _ver_src_id_sp_pos > 0 ) ;

_ver_src_id_ut_pos := __common__( Models.Common.findw_cpp(ver_src_id_list, 'UT' , '  ,', 'ie') ) ;

_ver_src_id__ut := __common__( _ver_src_id_ut_pos > 0 ) ;

_ver_src_id_v_pos := __common__( Models.Common.findw_cpp(ver_src_id_list, 'V' , '  ,', 'ie') ) ;

_ver_src_id__v := __common__( _ver_src_id_v_pos > 0 ) ;

_ver_src_id_wb_pos := __common__( Models.Common.findw_cpp(ver_src_id_list, 'WB' , '  ,', 'ie') ) ;

_ver_src_id__wb := __common__( _ver_src_id_wb_pos > 0 ) ;

_ver_src_id_wc_pos := __common__( Models.Common.findw_cpp(ver_src_id_list, 'WC' , '  ,', 'ie') ) ;

_ver_src_id__wc := __common__( _ver_src_id_wc_pos > 0 ) ;

_ver_src_id_wk_pos := __common__( Models.Common.findw_cpp(ver_src_id_list, 'WK' , '  ,', 'ie') ) ;

_ver_src_id__wk := __common__( _ver_src_id_wk_pos > 0 ) ;

_ver_src_id_wx_pos := __common__( Models.Common.findw_cpp(ver_src_id_list, 'WX' , '  ,', 'ie') ) ;

_ver_src_id__wx := __common__( _ver_src_id_wx_pos > 0 ) ;

_ver_src_id_zo_pos := __common__( Models.Common.findw_cpp(ver_src_id_list, 'ZO' , '  ,', 'ie') ) ;

_ver_src_id__zo := __common__( _ver_src_id_zo_pos > 0 ) ;

_ver_src_id_y_pos := __common__( Models.Common.findw_cpp(ver_src_id_list, 'Y' , '  ,', 'ie') ) ;

_ver_src_id__y := __common__( _ver_src_id_y_pos > 0 ) ;

_ver_src_id_gb_pos := __common__( Models.Common.findw_cpp(ver_src_id_list, 'GB' , '  ,', 'ie') ) ;

_ver_src_id__gb := __common__( _ver_src_id_gb_pos > 0 ) ;

_ver_src_id_fdate_gb := __common__( if(_ver_src_id_gb_pos > 0, Models.Common.getw(ver_src_id_firstseen_list, _ver_src_id_gb_pos), '0') ) ;

_ver_src_id_fdate_gb2 := __common__( common.sas_date((string)(_ver_src_id_fdate_gb)) ) ;

mth__ver_src_id_fdate_gb := __common__( if(min(sysdate, _ver_src_id_fdate_gb2) = NULL, NULL, ROUNDUP((sysdate - _ver_src_id_fdate_gb2) / 30.5)) ) ;

_ver_src_id_ldate_gb := __common__( if(_ver_src_id_gb_pos > 0, Models.Common.getw(ver_src_id_lastseen_list, _ver_src_id_gb_pos), '0') ) ;

_ver_src_id_ldate_gb2 := __common__( common.sas_date((string)(_ver_src_id_ldate_gb)) ) ;

mth__ver_src_id_ldate_gb := __common__( if(min(sysdate, _ver_src_id_ldate_gb2) = NULL, NULL, ROUNDUP((sysdate - _ver_src_id_ldate_gb2) / 30.5)) ) ;

_ver_src_id_cs_pos := __common__( Models.Common.findw_cpp(ver_src_id_list, 'C#' , ' ,', 'ie') ) ;

_ver_src_id__cs := __common__( _ver_src_id_cs_pos > 0 ) ;

_ne_ver_src_id_count_1 := __common__( (integer)_ver_src_id__br +
    (integer)_ver_src_id__c +
    (integer)_ver_src_id__d +
    (integer)_ver_src_id__df +
    (integer)_ver_src_id__dn +
    (integer)_ver_src_id__fb +
    (integer)_ver_src_id__l0 +
    (integer)_ver_src_id__l2 +
    (integer)_ver_src_id__u2 +
    (integer)_ver_src_id__ar +
    (integer)_ver_src_id__ba +
    (integer)_ver_src_id__bm +
    (integer)_ver_src_id__bn +
    (integer)_ver_src_id__cu +
    (integer)_ver_src_id__da +
    (integer)_ver_src_id__ef +
    (integer)_ver_src_id__fi +
    (integer)_ver_src_id__i +
    (integer)_ver_src_id__ia +
    (integer)_ver_src_id__in +
    (integer)_ver_src_id__os +
    (integer)_ver_src_id__p +
    (integer)_ver_src_id__pl +
    (integer)_ver_src_id__q3 +
    (integer)_ver_src_id__sk +
    (integer)_ver_src_id__tx +
    (integer)_ver_src_id__v2 +
    (integer)_ver_src_id__wa +
    (integer)_ver_src_id__by +
    (integer)_ver_src_id__cf +
    (integer)_ver_src_id__e +
    (integer)_ver_src_id__ey +
    (integer)_ver_src_id__f +
    (integer)_ver_src_id__fk +
    (integer)_ver_src_id__fr +
    (integer)_ver_src_id__ft +
    (integer)_ver_src_id__gr +
    (integer)_ver_src_id__h7 +
    (integer)_ver_src_id__ic +
    (integer)_ver_src_id__ip +
    (integer)_ver_src_id__is +
    (integer)_ver_src_id__it +
    (integer)_ver_src_id__j2 +
    (integer)_ver_src_id__kc +
    (integer)_ver_src_id__mh +
    (integer)_ver_src_id__mw +
    (integer)_ver_src_id__np +
    (integer)_ver_src_id__nr +
    (integer)_ver_src_id__sa +
    (integer)_ver_src_id__sb +
    (integer)_ver_src_id__sg +
    (integer)_ver_src_id__sj +
    (integer)_ver_src_id__sp +
    (integer)_ver_src_id__ut +
    (integer)_ver_src_id__v +
    (integer)_ver_src_id__wb +
    (integer)_ver_src_id__wc +
    (integer)_ver_src_id__wk +
    (integer)_ver_src_id__wx +
    (integer)_ver_src_id__zo +
    (integer)_ver_src_id__y +
    (integer)_ver_src_id__gb +
    (integer)_ver_src_id__cs ) ;

_ne_ver_src_id_count := __common__( if((integer)ver_src_id_count = -1, -1, _ne_ver_src_id_count_1) ) ;

truebiz := __common__( id_seleID != '0' and NOT((_ne_ver_src_id_count in [-1, 0]) and (integer)sbfe_acct_cnt < 1) ) ;

ne_bv_truebiz_category := __common__( map(
    id_seleID = '0'                                         				 => '0 NO BIP ID',
    (_ne_ver_src_id_count in [-1, 0]) and (integer)sbfe_acct_cnt < 1 => '1 NOT TRUEBIZ',
    (_ne_ver_src_id_count in [-1, 0])                       				 => '2 SBFE ONLY',
    (integer)sbfe_acct_cnt < 1                                       => '3 LN ONLY',
																																				'4 SBFE AND LN') ) ;

seg_business_score := __common__( map(
    (ne_bv_truebiz_category in ['4 SBFE AND LN', '2 SBFE ONLY']) => 'LN & SBFE',
    ne_bv_truebiz_category = '3 LN ONLY'                         => 'LN ONLY',
                                                                    'UNSCORABLE') ) ;

vs_gb_id_mth_fseen := __common__( mth__ver_src_id_fdate_gb ) ;

vs_gb_id_mth_lseen := __common__( mth__ver_src_id_ldate_gb ) ;

vs_ver_src_id__ut := __common__( _ver_src_id__ut ) ;

vs_ver_src_id__bm := __common__( _ver_src_id__bm ) ;

vs_ver_src_id__i := __common__( _ver_src_id__i ) ;

vs_v2_id_mth_fseen := __common__( mth__ver_src_id_fdate_v2 ) ;

vs_v2_id_mth_lseen := __common__( mth__ver_src_id_ldate_v2 ) ;

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
    (integer)vs_ver_src_id__ut = NULL => 0.00000,
    (integer)vs_ver_src_id__ut <= 0.5 => -0.00404,
                                0.27518) ) ;

b_vs_ver_src_id__bm_w := __common__( map(
    (integer)vs_ver_src_id__bm = NULL => 0.00000,
    (integer)vs_ver_src_id__bm <= 0.5 => 0.00709,
                                -1.24297) ) ;

b_vs_ver_src_id__i_w := __common__( map(
    (integer)vs_ver_src_id__i = NULL => 0.00000,
    (integer)vs_ver_src_id__i <= 0.5 => 0.03682,
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

td_sbfe_worst_perf84 := __common__( if(not(truebiz), NULL, (integer)sbfe_worst_perf84) ) ;

td_sbfe_avg_util_pct06 := __common__( if(not(truebiz), NULL, (integer)sbfe_avg_util_pct06) ) ;

bv_assoc_derog_pct := __common__( map(
    not(truebiz)    					=> NULL,
    (integer)assoc_count <= 0 => -1,
																 max((integer)assoc_felony_count, (integer)assoc_bankruptcy_count, (integer)assoc_lien_count, (integer)assoc_judg_count) / (integer)assoc_count) ) ;

td_acct_dpd_1p_recency := __common__( map(
    not(truebiz)               					=> NULL,
    (integer)sbfe_acct_dpd_1p_cnt00 > 0 => 1,
    (integer)sbfe_acct_dpd_1p_cnt06 > 0 => 6,
    (integer)sbfe_acct_dpd_1p_cnt12 > 0 => 12,
    (integer)sbfe_acct_dpd_1p_cnt24 > 0 => 24,
    (integer)sbfe_acct_dpd_1p_cnt36 > 0 => 36,
    (integer)sbfe_acct_dpd_1p_cnt60 > 0 => 60,
    (integer)sbfe_acct_dpd_1p_cnt84 > 0 => 84,
    (integer)sbfe_acct_dpd_1p_cnt > 0   => 99,
																					 (integer)sbfe_acct_dpd_1p_cnt) ) ;

_sbfe_acct_datefirstopen := __common__( common.sas_date((string)(sbfe_acct_datefirstopen)) ) ;

td_mth_acct_firstopen := __common__( map(
    not(truebiz)                    => NULL,
    _sbfe_acct_datefirstopen = NULL => -1,
    (integer)sbfe_acct_cnt = -99    => -99,
                                       if ((sysdate_days - _sbfe_acct_datefirstopen) / (365.25 / 12) >= 0, roundup((sysdate_days - _sbfe_acct_datefirstopen) / (365.25 / 12)), truncate((sysdate_days - _sbfe_acct_datefirstopen) / (365.25 / 12)))) ) ;

td_sbfe_avg_util_pct_cc := __common__( if(not(truebiz), NULL, (integer)sbfe_avg_util_pct_cc) ) ;

td_sbfe_util_pct_cc := __common__( if(not(truebiz), NULL, (integer)sbfe_util_pct_cc) ) ;

_sos_inc_filing_firstseen := __common__( common.sas_date((string)(sos_inc_filing_firstseen)) ) ;

bv_sos_mth_fs := __common__( map(
    not(truebiz)                     => NULL,
    _sos_inc_filing_firstseen = NULL => -1,
                                        if ((sysdate - _sos_inc_filing_firstseen) / (365.25 / 12) >= 0, roundup((sysdate - _sos_inc_filing_firstseen) / (365.25 / 12)), truncate((sysdate - _sos_inc_filing_firstseen) / (365.25 / 12)))) ) ;

bv_sos_index := __common__( map(
    not(truebiz)                                                                                   									 => NULL,
    (integer)sos_ever_defunct = 2                                                                           				 => 0,
    (integer)sos_inc_filing_count = 0 or 0 <= bv_sos_mth_fs AND bv_sos_mth_fs <= 24 or (integer)sos_ever_defunct = 1 => 1,
    25 <= bv_sos_mth_fs AND bv_sos_mth_fs <= 60                                                   									 => 2,
    61 <= bv_sos_mth_fs AND bv_sos_mth_fs <= 120                                                  									 => 3,
    121 <= bv_sos_mth_fs AND bv_sos_mth_fs <= 180                                                 									 => 4,
																																																												5) ) ;

td_sbfe_util_pct_oel := __common__( if(not(truebiz), NULL, (integeR)sbfe_util_pct_oel) ) ;

td_sbfe_closed_pct_invol := __common__( map(
    not(truebiz)         					=> NULL,
    (integer)sbfe_closed_cnt <= 0 => (integer)sbfe_closed_cnt,
																		 (integer)sbfe_closed_cnt_invol / (integer)sbfe_closed_cnt) ) ;

td_acct_dpd_31p_recency := __common__( map(
    not(truebiz)               					 => NULL,
    (integer)sbfe_acct_dpd_31p_cnt00 > 0 => 1,
    (integer)sbfe_acct_dpd_31p_cnt06 > 0 => 6,
    (integer)sbfe_acct_dpd_31p_cnt12 > 0 => 12,
    (integer)sbfe_acct_dpd_31p_cnt24 > 0 => 24,
    (integer)sbfe_acct_dpd_31p_cnt36 > 0 => 36,
    (integer)sbfe_acct_dpd_31p_cnt60 > 0 => 60,
    (integer)sbfe_acct_dpd_31p_cnt84 > 0 => 84,
    (integer)sbfe_acct_dpd_31p_cnt > 0   => 99,
																						(integer)sbfe_acct_dpd_31p_cnt) ) ;

td_sbfe_satis_cnt_loan := __common__( if(not(truebiz), NULL, (integer)sbfe_satis_cnt_loan) ) ;

bv_inq_highrisk_recency := __common__( map(
    not(truebiz)             					=> NULL,
    (integer)inq_highrisk_count03 > 0 => 3,
    (integer)inq_highrisk_count06 > 0 => 6,
    (integer)inq_highrisk_count12 > 0 => 12,
    (integer)inq_highrisk_count24 > 0 => 24,
    (integer)inq_highrisk_count > 0   => 99,
																				 0) ) ;

num_pos_sources := __common__( if(max((integer)source_ar, (integer)source_bm, (integer)source_c, (integer)source_cs, (integer)source_dn, (integer)source_ef, (integer)source_ft, (integer)source_i, (integer)source_ia, (integer)source_in, (integer)source_p, (integer)source_v2, (integer)source_wk) = NULL, NULL, sum((integer)source_ar, (integer)source_bm, (integer)source_c, (integer)source_cs, (integer)source_dn, (integer)source_ef, (integer)source_ft, (integer)source_i, (integer)source_ia, (integer)source_in, (integer)source_p, (integer)source_v2, (integer)source_wk)) ) ;

num_neg_sources := __common__( if(max((integer)source_ba, (integer)source_l2, (integer)source_ut) = NULL, NULL, sum((integer)source_ba, (integer)source_l2, (integer)source_ut)) ) ;

bv_ver_src_derog_ratio := __common__( map(
    not(truebiz)                                                                                                                                                    => NULL,
    ver_src_list = ''                                                                                                                                             	=> -1,
    if(max(num_pos_sources, num_neg_sources) = NULL, NULL, sum(if(num_pos_sources = NULL, 0, num_pos_sources), if(num_neg_sources = NULL, 0, num_neg_sources))) = 0 => -2,
    num_neg_sources > 0                                                                                                                                             => round(num_neg_sources / if(max(num_pos_sources, num_neg_sources) = NULL, NULL, sum(if(num_pos_sources = NULL, 0, num_pos_sources), if(num_neg_sources = NULL, 0, num_neg_sources)))/.1)*.1,
                                                                                                                                                                       100 + num_pos_sources) ) ;

bv_mth_ver_src_q3_fs := __common__( if(not(_ver_src_id__q3), -1, mth__ver_src_id_fdate_q3) ) ;

td_sbfe_util_pct_ge75_cnt_cc := __common__( if(not(truebiz), NULL, (integer)sbfe_util_pct_ge75_cnt_cc) ) ;

bv_lien_filed_recency := __common__( map(
    not(truebiz)           					=> NULL,
    (integer)lien_filed_count03 > 0 => 3,
    (integer)lien_filed_count06 > 0 => 6,
    (integer)lien_filed_count12 > 0 => 12,
    (integer)lien_filed_count24 > 0 => 24,
    (integer)lien_filed_count36 > 0 => 36,
    (integer)lien_filed_count60 > 0 => 60,
    (integer)lien_filed_count > 0   => 84,
                              0) ) ;

td_past_due_pct_of_limit_lse := __common__( map(
    not(truebiz)                					=> NULL,
    (integer)sbfe_past_due_amt_lse = -97 => -96,
    (integer)sbfe_orig_amt_lse < 0       => (integer)sbfe_orig_amt_lse,
    (integer)sbfe_orig_amt_lse = 0       => -1,
																						(integer)sbfe_past_due_amt_lse / (integer)sbfe_orig_amt_lse) ) ;

td_occ_dpd_31p_cnt24 := __common__( if(not(truebiz), NULL, (integer)sbfe_occ_dpd_31p_cnt24) ) ;

_sbfe_datefirstseen := __common__( common.sas_date((string)(sbfe_datefirstseen)) ) ;

td_mth_sbfe_datefirstseen := __common__( map(
    not(truebiz)              		=> NULL,
    (integer)sbfe_acct_cnt = -99  => -99,
    _sbfe_datefirstseen = NULL 		=> -1,
																		 if ((sysdate_days - _sbfe_datefirstseen) / (365.25 / 12) >= 0, roundup((sysdate_days - _sbfe_datefirstseen) / (365.25 / 12)), truncate((sysdate_days - _sbfe_datefirstseen) / (365.25 / 12)))) ) ;

bv_judg_filed_recency := __common__( map(
    not(truebiz)           					=> NULL,
    (integer)judg_filed_count03 > 0 => 3,
    (integer)judg_filed_count06 > 0 => 6,
    (integer)judg_filed_count12 > 0 => 12,
    (integer)judg_filed_count24 > 0 => 24,
    (integer)judg_filed_count36 > 0 => 36,
    (integer)judg_filed_count60 > 0 => 60,
    (integer)judg_filed_count > 0   => 84,
																			 0) ) ;

td_acct_dpd_61p_cnt12 := __common__( if(not(truebiz), NULL, (integer)sbfe_acct_dpd_61p_cnt12) ) ;

td_acct_pct_closed := __common__( map(
    not(truebiz)        				 => NULL,
    (integer)sbfe_acct_cnt = -99 => -99,
    (integer)sbfe_closed_cnt = 0 => 0,
																		10 * if (10 * (integer)sbfe_closed_cnt / (integer)sbfe_acct_cnt >= 0, roundup(10 * (integer)sbfe_closed_cnt / (integer)sbfe_acct_cnt), truncate(10 * (integer)sbfe_closed_cnt / (integer)sbfe_acct_cnt))) ) ;

_sbfe_datelastseen := __common__( common.sas_date((string)(sbfe_datelastseen)) ) ;

td_mth_sbfe_datelastseen := __common__( map(
    not(truebiz)              		=> NULL,
    (integer)sbfe_acct_cnt = -99  => -99,
    _sbfe_datelastseen = NULL 		=> -1,
																		 if ((sysdate_days - _sbfe_datelastseen) / (365.25 / 12) >= 0, roundup((sysdate_days - _sbfe_datelastseen) / (365.25 / 12)), truncate((sysdate_days - _sbfe_datelastseen) / (365.25 / 12)))) ) ;

_sbfe_dlq_datelastseen := __common__( common.sas_date((string)(sbfe_dlq_datelastseen)) ) ;

td_mth_dlq_lastseen := __common__( map(
    not(truebiz)                  => NULL,
    (integer)sbfe_acct_cnt = -99  => -99,
    _sbfe_dlq_datelastseen = NULL => -1,
                                     if ((sysdate_days - _sbfe_dlq_datelastseen) / (365.25 / 12) >= 0, roundup((sysdate_days - _sbfe_dlq_datelastseen) / (365.25 / 12)), truncate((sysdate_days - _sbfe_dlq_datelastseen) / (365.25 / 12)))) ) ;

td_past_due_pct_of_balance := __common__( map(
    not(truebiz)           					 => NULL,
    (integer)sbfe_past_due_amt = -97 => -96,
    (integer)sbfe_balance < 0        => (integer)sbfe_balance,
    (integer)sbfe_balance = 0        => -1,
																				(integer)sbfe_past_due_amt / (integer)sbfe_balance) ) ;

_inq_lastseen := __common__( common.sas_date((string)(inq_lastseen)) ) ;

bv_mths_inq_lastseen := __common__( map(
    not(truebiz)         => NULL,
    _inq_lastseen = NULL => -1,
                            if ((sysdate - _inq_lastseen) / (365.25 / 12) >= 0, roundup((sysdate - _inq_lastseen) / (365.25 / 12)), truncate((sysdate - _inq_lastseen) / (365.25 / 12)))) ) ;

bv_prop_assessed_value := __common__( map(
    not(truebiz)  				  => NULL,
    (integer)prop_count = 0 => -1,
															 (integer)prop_assessed_value_total) ) ;

bv_assoc_judg_tot := __common__( map(
    not(truebiz)    				 => NULL,
    (integer)assoc_count = 0 => -1,
																(integer)assoc_judg_total) ) ;

bv_mth_ver_src_p_ls := __common__( if(not(_ver_src_id__p), -1, mth__ver_src_id_ldate_p) ) ;

bv_lien_judg_index := __common__( map(
    not(truebiz)                                                                                                                                                         																									   => NULL,
    (integer)lien_filed_count03 > 0                                                                                                                                               																					 => 4,
    (integer)lien_filed_count12 > 0 or (integer)judg_filed_count12 > 0                                                                                                                      																 => 3,
    if(max((integer)lien_filed_count, (integer)judg_filed_count) = 0, NULL, sum(if((integer)lien_filed_count = NULL, 0, (integer)lien_filed_count), if((integer)judg_filed_count = NULL, 0, (integer)judg_filed_count))) > 1 => 2,
    if(max((integer)lien_filed_count, (integer)judg_filed_count) = 0, NULL, sum(if((integer)lien_filed_count = NULL, 0, (integer)lien_filed_count), if((integer)judg_filed_count = NULL, 0, (integer)judg_filed_count))) > 0 => 1,
																																																																																																															  0) ) ;

bv_assoc_felony_ct := __common__( map(
    not(truebiz)    				 => NULL,
    (integer)assoc_count = 0 => -1,
																(integer)assoc_felony_count) ) ;

bv_mth_ver_src_c_fs := __common__( if(not(_ver_src_id__c), -1, mth__ver_src_id_fdate_c) ) ;

bv_inq_highrisk_count := __common__( if(not(truebiz), NULL, (integer)inq_highrisk_count) ) ;

bv_assoc_lien_tot := __common__( map(
    not(truebiz)    				 => NULL,
    (integer)assoc_count = 0 => -1,
															  (integer)assoc_lien_total) ) ;

s_bv_assoc_derog_pct_w := __common__( map(
    bv_assoc_derog_pct = NULL           => 0.00000,
    bv_assoc_derog_pct = -1             => -0.01877,
    bv_assoc_derog_pct <= 0.13484848485 => -0.26652,
    bv_assoc_derog_pct <= 0.2158385093  => 0.16223,
    bv_assoc_derog_pct <= 0.3923076923  => 0.52589,
    bv_assoc_derog_pct <= 0.63333333335 => 0.68335,
                                           0.97715) ) ;

s_aa_dist_1 := __common__( (0.00000 - s_bv_assoc_derog_pct_w) * 0.53956 ) ;

s_aa_code_1 := __common__( map(
    s_bv_assoc_derog_pct_w = -0.26652   => '',
    bv_assoc_derog_pct = NULL           => 'B031',
    bv_assoc_derog_pct = -1             => 'B017',
    bv_assoc_derog_pct <= 0.13484848485 => 'B026',
    bv_assoc_derog_pct <= 0.2158385093  => 'B026',
    bv_assoc_derog_pct <= 0.3923076923  => 'B026',
    bv_assoc_derog_pct <= 0.63333333335 => 'B026',
                                           'B026') ) ;

s_bv_sos_index_w := __common__( map(
    bv_sos_index = NULL => 0.00000,
    bv_sos_index <= 0.5 => 0.64439,
    bv_sos_index <= 4.5 => 0.06744,
                           -0.24185) ) ;

s_aa_dist_2 := __common__( (0.00000 - s_bv_sos_index_w) * 0.75837 ) ;

s_aa_code_2 := __common__( map(
    s_bv_sos_index_w = -0.24185                     				  => '',
    bv_sos_index = NULL                              					=> 'B031',
    bv_sos_index <= 0.5                              					=> 'B059',
    bv_sos_index <= 4.5 and (integer)sos_inc_filing_count = 0 => 'B055',
    bv_sos_index <= 4.5 and (integer)sos_ever_defunct = 1     => 'B059',
																																 'B057') ) ;

s_bv_lien_filed_recency_w := __common__( map(
    bv_lien_filed_recency = NULL => 0.00000,
    bv_lien_filed_recency <= 1.5 => -0.09407,
    bv_lien_filed_recency <= 9   => 1.56771,
    bv_lien_filed_recency <= 48  => 0.96050,
                                    0.31174) ) ;

s_aa_dist_3 := __common__( (0.00000 - s_bv_lien_filed_recency_w) * 0.24999 ) ;

s_aa_code_3 := __common__( map(
    s_bv_lien_filed_recency_w = -0.09407 => '',
    bv_lien_filed_recency = NULL         => 'B031',
    bv_lien_filed_recency <= 1.5         => 'B063',
    bv_lien_filed_recency <= 9           => 'B063',
    bv_lien_filed_recency <= 48          => 'B063',
                                            'B063') ) ;

s_bv_judg_filed_recency_w := __common__( map(
    bv_judg_filed_recency = NULL => 0.00000,
    bv_judg_filed_recency <= 1.5 => -0.05138,
    bv_judg_filed_recency <= 18  => 1.46700,
    bv_judg_filed_recency <= 30  => 1.22872,
    bv_judg_filed_recency <= 48  => 1.01798,
                                    0.43903) ) ;

s_aa_dist_4 := __common__( (0.00000 - s_bv_judg_filed_recency_w) * 0.25961 ) ;

s_aa_code_4 := __common__( map(
    s_bv_judg_filed_recency_w = -0.05138 => '',
    bv_judg_filed_recency = NULL         => 'B031',
    bv_judg_filed_recency <= 1.5         => 'B063',
    bv_judg_filed_recency <= 18          => 'B063',
    bv_judg_filed_recency <= 30          => 'B063',
    bv_judg_filed_recency <= 48          => 'B063',
                                            'B063') ) ;

s_bv_inq_highrisk_recency_w := __common__( map(
    bv_inq_highrisk_recency = NULL  => 0.00000,
    bv_inq_highrisk_recency <= 1.5  => -0.08408,
    bv_inq_highrisk_recency <= 9    => 1.24099,
    bv_inq_highrisk_recency <= 18   => 0.88547,
    bv_inq_highrisk_recency <= 61.5 => 0.65355,
                                       0.48131) ) ;

s_aa_dist_5 := __common__( (0.00000 - s_bv_inq_highrisk_recency_w) * 0.39247 ) ;

s_aa_code_5 := __common__( map(
    s_bv_inq_highrisk_recency_w = -0.08408 => '',
    bv_inq_highrisk_recency = NULL         => 'B031',
    bv_inq_highrisk_recency <= 1.5         => 'B040',
    bv_inq_highrisk_recency <= 9           => 'B040',
    bv_inq_highrisk_recency <= 18          => 'B040',
    bv_inq_highrisk_recency <= 61.5        => 'B040',
                                              'B040') ) ;

s_td_mth_sbfe_datefirstseen_w := __common__( map(
    td_mth_sbfe_datefirstseen = NULL  => 0.00000,
    td_mth_sbfe_datefirstseen = -1    => -0.02129,
    td_mth_sbfe_datefirstseen <= 3.5  => 0.78123,
    td_mth_sbfe_datefirstseen <= 17.5 => 0.31800,
                                         -0.02129) ) ;

s_aa_dist_6 := __common__( (0.00000 - s_td_mth_sbfe_datefirstseen_w) * 0.54694 ) ;

s_aa_code_6 := __common__( map(
    s_td_mth_sbfe_datefirstseen_w = -0.02129 => '',
    td_mth_sbfe_datefirstseen = NULL         => 'BF105',
    td_mth_sbfe_datefirstseen = -1           => 'BF106',
    td_mth_sbfe_datefirstseen <= 3.5         => 'BF106',
    td_mth_sbfe_datefirstseen <= 17.5        => 'BF106',
                                                'BF106') ) ;

s_td_mth_acct_firstopen_w := __common__( map(
    td_mth_acct_firstopen = NULL  => 0.00000,
    td_mth_acct_firstopen = -1    => -0.02604,
    td_mth_acct_firstopen <= 3.5  => 1.00565,
    td_mth_acct_firstopen <= 20.5 => 0.40841,
                                     -0.02604) ) ;

s_aa_dist_7 := __common__( (0.00000 - s_td_mth_acct_firstopen_w) * 1.09360 ) ;

s_aa_code_7 := __common__( map(
    s_td_mth_acct_firstopen_w = -0.02604 => '',
    td_mth_acct_firstopen = NULL         => 'BF105',
    td_mth_acct_firstopen = -1           => 'BF117',
    td_mth_acct_firstopen <= 3.5         => 'BF117',
    td_mth_acct_firstopen <= 20.5        => 'BF117',
                                            'BF117') ) ;

s_td_mth_dlq_lastseen_w := __common__( map(
    td_mth_dlq_lastseen = NULL  => 0.00000,
    td_mth_dlq_lastseen = -1    => -0.19081,
    td_mth_dlq_lastseen <= 1.5  => 1.07000,
    td_mth_dlq_lastseen <= 3.5  => 0.71524,
    td_mth_dlq_lastseen <= 4.5  => 0.38367,
    td_mth_dlq_lastseen <= 27.5 => 0.27180,
    td_mth_dlq_lastseen <= 43.5 => 0.17942,
                                   -0.03349) ) ;

s_aa_dist_8 := __common__( (0.00000 - s_td_mth_dlq_lastseen_w) * 0.12277 ) ;

s_aa_code_8 := __common__( map(
    s_td_mth_dlq_lastseen_w = -0.19081 					=> '',
    td_mth_dlq_lastseen = NULL         					=> 'BF105',
    (integer)sbfe_acct_dpd_91p_cnt84 > 0        => 'BF142',
																									 'BF141') ) ;

s_td_pd_pct_of_limit_lse_w := __common__( map(
    td_past_due_pct_of_limit_lse = NULL          => 0.00000,
    td_past_due_pct_of_limit_lse = -98           => -0.02024,
    td_past_due_pct_of_limit_lse = -97           => -0.23411,
    td_past_due_pct_of_limit_lse = -96           => 0.40777,
    td_past_due_pct_of_limit_lse <= 0.0017306768 => -0.23411,
    td_past_due_pct_of_limit_lse <= 0.0312997246 => 0.94000,
                                                    1.55841) ) ;

s_aa_dist_9 := __common__( (0.00000 - s_td_pd_pct_of_limit_lse_w) * 0.28321 ) ;

s_aa_code_9 := __common__( map(
    s_td_pd_pct_of_limit_lse_w = -0.23411	 => '',
    td_past_due_pct_of_limit_lse = NULL 	 => 'BF105',
    td_past_due_pct_of_limit_lse = -98   	 => 'BF129',
    (integer)sbfe_past_due_amt_91p_lse > 0 => 'BF142',
                                              'BF141') ) ;

s_td_acct_dpd_1p_recency_w := __common__( map(
    td_acct_dpd_1p_recency = NULL => 0.00000,
    td_acct_dpd_1p_recency = -97  => -0.45568,
    td_acct_dpd_1p_recency <= 0.5 => -0.45568,
    td_acct_dpd_1p_recency <= 3.5 => 1.04179,
    td_acct_dpd_1p_recency <= 9   => 0.45431,
                                     -0.03099) ) ;

s_aa_dist_10 := __common__( (0.00000 - s_td_acct_dpd_1p_recency_w) * 0.39631 ) ;

s_aa_code_10 := __common__( map(
    s_td_acct_dpd_1p_recency_w = -0.45568 => '',
    td_acct_dpd_1p_recency = NULL         => 'BF105',
    td_acct_dpd_1p_recency = -97          => 'BF141',
    td_acct_dpd_1p_recency <= 0.5         => 'BF141',
    (integer)sbfe_acct_dpd_91p_cnt06 > 0  => 'BF142',
                                             'BF141') ) ;

s_td_acct_dpd_31p_recency_w := __common__( map(
    td_acct_dpd_31p_recency = NULL => 0.00000,
    td_acct_dpd_31p_recency = -97  => -0.35937,
    td_acct_dpd_31p_recency <= 0.5 => -0.35937,
    td_acct_dpd_31p_recency <= 3.5 => 1.76688,
    td_acct_dpd_31p_recency <= 9   => 1.22270,
    td_acct_dpd_31p_recency <= 18  => 0.81442,
    td_acct_dpd_31p_recency <= 30  => 0.77730,
    td_acct_dpd_31p_recency <= 48  => 0.53807,
                                      0.25630) ) ;

s_aa_dist_11 := __common__( (0.00000 - s_td_acct_dpd_31p_recency_w) * 0.16476 ) ;

s_aa_code_11 := __common__( map(
    s_td_acct_dpd_31p_recency_w = -0.35937 => '',
    td_acct_dpd_31p_recency = NULL         => 'BF105',
    td_acct_dpd_31p_recency = -97          => 'BF141',
    td_acct_dpd_31p_recency <= 0.5         => 'BF141',
    (integer)sbfe_acct_dpd_91p_cnt00 > 0   => 'BF142',
                                              'BF141') ) ;

s_td_sbfe_closed_pct_invol_w := __common__( map(
    td_sbfe_closed_pct_invol = NULL           => 0.00000,
    td_sbfe_closed_pct_invol <= 0.02704678365 => -0.20106,
    td_sbfe_closed_pct_invol <= 0.1519230769  => -0.08111,
    td_sbfe_closed_pct_invol <= 0.3489130435  => 0.04925,
    td_sbfe_closed_pct_invol <= 0.531372549   => 0.21322,
                                                 0.58206) ) ;

s_aa_dist_12 := __common__( (0.00000 - s_td_sbfe_closed_pct_invol_w) * 0.36830 ) ;

s_aa_code_12 := __common__( map(
    s_td_sbfe_closed_pct_invol_w = -0.20106 => '',
    td_sbfe_closed_pct_invol = NULL         => 'BF105',
    (integer)sbfe_chargeoff_cnt > 0         => 'BF143',
                                               'BF120') ) ;

s_td_sbfe_util_pct_oel_w := __common__( map(
    td_sbfe_util_pct_oel = NULL  => 0.00000,
    td_sbfe_util_pct_oel = -98   => 0.02110,
    td_sbfe_util_pct_oel = -97   => -0.30109,
    td_sbfe_util_pct_oel <= 18.5 => -0.30109,
    td_sbfe_util_pct_oel <= 42.5 => -0.03541,
    td_sbfe_util_pct_oel <= 83.5 => 0.33918,
    td_sbfe_util_pct_oel <= 97.5 => 0.72889,
                                    1.29398) ) ;

s_aa_dist_13 := __common__( (0.00000 - s_td_sbfe_util_pct_oel_w) * 0.45264 ) ;

s_aa_code_13 := __common__( map(
    s_td_sbfe_util_pct_oel_w = -0.30109 => '',
    td_sbfe_util_pct_oel = NULL         => 'BF105',
    td_sbfe_util_pct_oel = -98          => 'BF127',
    td_sbfe_util_pct_oel = -97          => 'BF135',
    td_sbfe_util_pct_oel <= 18.5        => 'BF135',
    td_sbfe_util_pct_oel <= 42.5        => 'BF135',
    td_sbfe_util_pct_oel <= 83.5        => 'BF135',
    td_sbfe_util_pct_oel <= 97.5        => 'BF135',
                                           'BF135') ) ;

s_td_sbfe_util_pct75_cnt_cc_w := __common__( map(
    td_sbfe_util_pct_ge75_cnt_cc = NULL => 0.00000,
    td_sbfe_util_pct_ge75_cnt_cc = -98  => 0.30666,
    td_sbfe_util_pct_ge75_cnt_cc = -97  => -0.52175,
    td_sbfe_util_pct_ge75_cnt_cc <= 0.5 => -0.52175,
    td_sbfe_util_pct_ge75_cnt_cc <= 1.5 => 0.71491,
    td_sbfe_util_pct_ge75_cnt_cc <= 2.5 => 1.20973,
                                           1.67831) ) ;

s_aa_dist_14 := __common__( (0.00000 - s_td_sbfe_util_pct75_cnt_cc_w) * 0.14644 ) ;

s_aa_code_14 := __common__( map(
    s_td_sbfe_util_pct75_cnt_cc_w = -0.52175 => '',
    td_sbfe_util_pct_ge75_cnt_cc = NULL      => 'BF105',
    td_sbfe_util_pct_ge75_cnt_cc = -98       => 'BF128',
    td_sbfe_util_pct_ge75_cnt_cc = -97       => 'BF135',
    td_sbfe_util_pct_ge75_cnt_cc <= 0.5      => 'BF135',
    td_sbfe_util_pct_ge75_cnt_cc <= 1.5      => 'BF135',
    td_sbfe_util_pct_ge75_cnt_cc <= 2.5      => 'BF135',
                                                'BF135') ) ;

s_td_sbfe_avg_util_pct06_w := __common__( map(
    td_sbfe_avg_util_pct06 = NULL  => 0.00000,
    td_sbfe_avg_util_pct06 = -98   => 0.31068,
    td_sbfe_avg_util_pct06 = -97   => -0.86103,
    td_sbfe_avg_util_pct06 <= 0.5  => -0.27305,
    td_sbfe_avg_util_pct06 <= 21.5 => -0.86103,
    td_sbfe_avg_util_pct06 <= 36.5 => -0.45904,
    td_sbfe_avg_util_pct06 <= 55.5 => -0.09789,
    td_sbfe_avg_util_pct06 <= 71.5 => 0.29319,
    td_sbfe_avg_util_pct06 <= 81.5 => 0.52712,
    td_sbfe_avg_util_pct06 <= 90.5 => 1.00962,
    td_sbfe_avg_util_pct06 <= 97.5 => 1.33927,
                                      1.72523) ) ;

s_aa_dist_15 := __common__( (0.00000 - s_td_sbfe_avg_util_pct06_w) * 0.43096 ) ;

s_aa_code_15 := __common__( map(
    s_td_sbfe_avg_util_pct06_w = -0.86103                         => '',
    td_sbfe_avg_util_pct06 = NULL                                 => 'BF105',
    td_sbfe_avg_util_pct06 = -98 and (integer)sbfe_avg_util_pct06_cc = -98 => 'BF128',
    td_sbfe_avg_util_pct06 = -98                                  => 'BF127',
    td_sbfe_avg_util_pct06 = -97                                  => 'BF133',
    td_sbfe_avg_util_pct06 <= 0.5                                 => 'BF134',
    td_sbfe_avg_util_pct06 <= 21.5                                => 'BF133',
    td_sbfe_avg_util_pct06 <= 36.5                                => 'BF133',
    td_sbfe_avg_util_pct06 <= 55.5                                => 'BF133',
    td_sbfe_avg_util_pct06 <= 71.5                                => 'BF133',
    td_sbfe_avg_util_pct06 <= 81.5                                => 'BF133',
    td_sbfe_avg_util_pct06 <= 90.5                                => 'BF133',
    td_sbfe_avg_util_pct06 <= 97.5                                => 'BF133',
                                                                     'BF133') ) ;

s_td_sbfe_avg_util_pct_cc_w := __common__( map(
    td_sbfe_avg_util_pct_cc = NULL  => 0.00000,
    td_sbfe_avg_util_pct_cc = -98   => 0.24331,
    td_sbfe_avg_util_pct_cc = -97   => -0.69205,
    td_sbfe_avg_util_pct_cc <= 0.5  => -0.16206,
    td_sbfe_avg_util_pct_cc <= 8.5  => -0.69205,
    td_sbfe_avg_util_pct_cc <= 17.5 => -0.50823,
    td_sbfe_avg_util_pct_cc <= 36.5 => -0.14046,
    td_sbfe_avg_util_pct_cc <= 44.5 => 0.32559,
    td_sbfe_avg_util_pct_cc <= 56.5 => 0.58070,
    td_sbfe_avg_util_pct_cc <= 60.5 => 0.70987,
    td_sbfe_avg_util_pct_cc <= 72.5 => 0.93038,
    td_sbfe_avg_util_pct_cc <= 89.5 => 1.24946,
                                       1.73829) ) ;

s_aa_dist_16 := __common__( (0.00000 - s_td_sbfe_avg_util_pct_cc_w) * 0.23839 ) ;

s_aa_code_16 := __common__( map(
    s_td_sbfe_avg_util_pct_cc_w = -0.69205 => '',
    td_sbfe_avg_util_pct_cc = NULL         => 'BF105',
    td_sbfe_avg_util_pct_cc = -98          => 'BF128',
    td_sbfe_avg_util_pct_cc = -97          => 'BF133',
    td_sbfe_avg_util_pct_cc <= 0.5         => 'BF134',
    td_sbfe_avg_util_pct_cc <= 8.5         => 'BF133',
    td_sbfe_avg_util_pct_cc <= 17.5        => 'BF133',
    td_sbfe_avg_util_pct_cc <= 36.5        => 'BF133',
    td_sbfe_avg_util_pct_cc <= 44.5        => 'BF133',
    td_sbfe_avg_util_pct_cc <= 56.5        => 'BF133',
    td_sbfe_avg_util_pct_cc <= 60.5        => 'BF133',
    td_sbfe_avg_util_pct_cc <= 72.5        => 'BF133',
    td_sbfe_avg_util_pct_cc <= 89.5        => 'BF133',
                                              'BF133') ) ;

s_bv_mth_ver_src_q3_fs_w := __common__( map(
    bv_mth_ver_src_q3_fs = NULL   => 0.00000,
    bv_mth_ver_src_q3_fs = -1     => -0.06493,
    bv_mth_ver_src_q3_fs <= 8.5   => 0.63676,
    bv_mth_ver_src_q3_fs <= 135.5 => 0.13983,
                                     -0.09712) ) ;

s_aa_dist_17 := __common__( (0.00000 - s_bv_mth_ver_src_q3_fs_w) * 0.70147 ) ;

s_aa_code_17 := __common__( map(
    s_bv_mth_ver_src_q3_fs_w = -0.09712 => '',
    bv_mth_ver_src_q3_fs = NULL         => 'B031',
    bv_mth_ver_src_q3_fs = -1           => 'B034',
    bv_mth_ver_src_q3_fs <= 8.5         => 'B037',
    bv_mth_ver_src_q3_fs <= 135.5       => 'B037',
                                           'B037') ) ;

s_bv_ver_src_derog_ratio_w := __common__( map(
    bv_ver_src_derog_ratio = NULL  => 0.00000,
    bv_ver_src_derog_ratio = -1    => 0.00000,
    bv_ver_src_derog_ratio <= 0.15 => 0.03651,
    bv_ver_src_derog_ratio <= 0.25 => 0.44612,
    bv_ver_src_derog_ratio <= 0.35 => 0.59050,
    bv_ver_src_derog_ratio <= 51   => 0.93809,
                                      -0.19458) ) ;

s_aa_dist_18 := __common__( (0.00000 - s_bv_ver_src_derog_ratio_w) * 0.21480 ) ;

s_aa_code_18 := __common__( if(source_ba or source_l2, 'B063', 'B034') ) ;

s_bv_bus_only_source_profile_w := __common__( map(
    bv_bus_only_source_profile = NULL           => 0.00000,
    bv_bus_only_source_profile <= -2.652136749  => -0.40143,
    bv_bus_only_source_profile <= -2.475762209  => -0.15203,
    bv_bus_only_source_profile <= -2.2329991615 => 0.04367,
    bv_bus_only_source_profile <= -1.9190322745 => 0.30249,
    bv_bus_only_source_profile <= -1.558937848  => 0.40306,
    bv_bus_only_source_profile <= -1.468405136  => 0.61720,
                                                   0.68736) ) ;

s_aa_dist_19 := __common__( (0.00000 - s_bv_bus_only_source_profile_w) * 0.75314 ) ;

s_aa_code_19 := __common__( map(
    s_bv_bus_only_source_profile_w = -0.40143   => '',
    bv_bus_only_source_profile = NULL           => 'B031',
    bv_bus_only_source_profile <= -2.652136749  => 'B034',
    bv_bus_only_source_profile <= -2.475762209  => 'B034',
    bv_bus_only_source_profile <= -2.2329991615 => 'B034',
    bv_bus_only_source_profile <= -1.9190322745 => 'B034',
    bv_bus_only_source_profile <= -1.558937848  => 'B034',
    bv_bus_only_source_profile <= -1.468405136  => 'B034',
                                                   'B034') ) ;

s_td_occ_dpd_31p_cnt24_w := __common__( map(
    td_occ_dpd_31p_cnt24 = NULL => 0.00000,
    td_occ_dpd_31p_cnt24 = -98  => 0.24388,
    td_occ_dpd_31p_cnt24 = -97  => -0.26186,
    td_occ_dpd_31p_cnt24 <= 0.5 => -0.26186,
    td_occ_dpd_31p_cnt24 <= 1.5 => 0.80064,
    td_occ_dpd_31p_cnt24 <= 2.5 => 1.03355,
    td_occ_dpd_31p_cnt24 <= 3.5 => 1.46670,
    td_occ_dpd_31p_cnt24 <= 5.5 => 1.75890,
                                   1.97950) ) ;

s_aa_dist_20 := __common__( (0.00000 - s_td_occ_dpd_31p_cnt24_w) * 0.11776 ) ;

s_aa_code_20 := __common__( if((integer)sbfe_occ_dpd_91p_cnt24 > 0, 'BF142', 'BF141') ) ;

s_td_sbfe_satis_cnt_loan_w := __common__( map(
    td_sbfe_satis_cnt_loan = NULL => 0.00000,
    td_sbfe_satis_cnt_loan = -98  => 0.01454,
    td_sbfe_satis_cnt_loan = -97  => -0.47479,
    td_sbfe_satis_cnt_loan <= 0   => 2.42010,
    td_sbfe_satis_cnt_loan <= 1   => -0.18760,
    td_sbfe_satis_cnt_loan <= 2   => -0.26554,
                                     -0.47479) ) ;

s_aa_dist_21 := __common__( (0.00000 - s_td_sbfe_satis_cnt_loan_w) * 0.54827 ) ;

s_aa_code_21 := __common__( map(
    s_td_sbfe_satis_cnt_loan_w = -0.47479			=> '',
    td_sbfe_satis_cnt_loan = NULL        		  => 'BF105',
    td_sbfe_satis_cnt_loan = -98          		=> 'BF126',
    (integer)sbfe_acct_dpd_91p_cnt00_loan > 0 => 'BF142',
																								 'BF141') ) ;

s_td_sbfe_util_pct_cc_w := __common__( map(
    td_sbfe_util_pct_cc = NULL  => 0.00000,
    td_sbfe_util_pct_cc = -98   => 0.30666,
    td_sbfe_util_pct_cc = -97   => -0.87516,
    td_sbfe_util_pct_cc <= 0.5  => -0.26678,
    td_sbfe_util_pct_cc <= 7.5  => -0.87516,
    td_sbfe_util_pct_cc <= 25.5 => -0.71063,
    td_sbfe_util_pct_cc <= 54.5 => -0.23465,
    td_sbfe_util_pct_cc <= 73.5 => 0.28691,
    td_sbfe_util_pct_cc <= 78.5 => 0.61422,
    td_sbfe_util_pct_cc <= 88.5 => 0.81205,
    td_sbfe_util_pct_cc <= 94.5 => 1.22524,
                                   1.46459) ) ;

s_aa_dist_22 := __common__( (0.00000 - s_td_sbfe_util_pct_cc_w) * 0.20701 ) ;

s_aa_code_22 := __common__( map(
    s_td_sbfe_util_pct_cc_w = -0.87516 => '',
    td_sbfe_util_pct_cc = NULL         => 'BF105',
    td_sbfe_util_pct_cc = -98          => 'BF128',
    td_sbfe_util_pct_cc = -97          => 'BF135',
    td_sbfe_util_pct_cc <= 0.5         => 'BF136',
    td_sbfe_util_pct_cc <= 7.5         => 'BF135',
    td_sbfe_util_pct_cc <= 25.5        => 'BF135',
    td_sbfe_util_pct_cc <= 54.5        => 'BF135',
    td_sbfe_util_pct_cc <= 73.5        => 'BF135',
    td_sbfe_util_pct_cc <= 78.5        => 'BF135',
    td_sbfe_util_pct_cc <= 88.5        => 'BF135',
    td_sbfe_util_pct_cc <= 94.5        => 'BF135',
                                          'BF135') ) ;

s_td_mth_sbfe_datelastseen_w := __common__( map(
    td_mth_sbfe_datelastseen = NULL  => 0.00000,
    td_mth_sbfe_datelastseen <= 2.5  => -0.04941,
    td_mth_sbfe_datelastseen <= 35.5 => 0.25085,
                                        0.33192) ) ;

s_aa_dist_23 := __common__( (0.00000 - s_td_mth_sbfe_datelastseen_w) * 0.39758 ) ;

s_aa_code_23 := __common__( map(
    s_td_mth_sbfe_datelastseen_w = -0.04941 => '',
    td_mth_sbfe_datelastseen = NULL         => 'BF105',
    td_mth_sbfe_datelastseen <= 2.5         => 'BF107',
    td_mth_sbfe_datelastseen <= 35.5        => 'BF107',
                                               'BF107') ) ;

s_td_past_due_pct_of_balance_w := __common__( map(
    td_past_due_pct_of_balance = NULL           => 0.00000,
    td_past_due_pct_of_balance = -98            => 0.31468,
    td_past_due_pct_of_balance = -96            => 0.80716,
    td_past_due_pct_of_balance = -1             => -0.26843,
    td_past_due_pct_of_balance <= 0.00010168735 => -0.26843,
    td_past_due_pct_of_balance <= 0.0018256014  => 0.28189,
    td_past_due_pct_of_balance <= 0.0086751307  => 0.73025,
    td_past_due_pct_of_balance <= 0.01618983985 => 0.96882,
    td_past_due_pct_of_balance <= 0.03786943175 => 1.11666,
    td_past_due_pct_of_balance <= 0.89126465465 => 1.38871,
                                                   1.66461) ) ;

s_aa_dist_24 := __common__( (0.00000 - s_td_past_due_pct_of_balance_w) * 0.04557 ) ;

s_aa_code_24 := __common__( map(
    s_td_past_due_pct_of_balance_w = -0.26843 => '',
    td_past_due_pct_of_balance = NULL         => 'BF105',
    td_past_due_pct_of_balance = -98          => 'BF110',
    (integer)sbfe_past_due_amt_91p > 0        => 'BF142',
                                                 'BF141') ) ;

s_td_acct_pct_closed_w := __common__( map(
    td_acct_pct_closed = NULL => 0.00000,
    td_acct_pct_closed <= 35  => -0.19231,
    td_acct_pct_closed <= 45  => -0.02339,
    td_acct_pct_closed <= 75  => 0.12717,
                                 0.45154) ) ;

s_aa_dist_25 := __common__( (0.00000 - s_td_acct_pct_closed_w) * 0.22956 ) ;

s_aa_code_25 := __common__( map(
    s_td_acct_pct_closed_w = -0.19231 => '',
    td_acct_pct_closed = NULL         => 'BF105',
    td_acct_pct_closed <= 35          => 'BF113',
    td_acct_pct_closed <= 45          => 'BF113',
    td_acct_pct_closed <= 75          => 'BF113',
                                         'BF113') ) ;

s_td_acct_dpd_61p_cnt12_w := __common__( map(
    td_acct_dpd_61p_cnt12 = NULL => 0.00000,
    td_acct_dpd_61p_cnt12 = -98  => 0.24407,
    td_acct_dpd_61p_cnt12 = -97  => -0.18254,
    td_acct_dpd_61p_cnt12 <= 0.5 => -0.18254,
    td_acct_dpd_61p_cnt12 <= 1.5 => 1.40222,
                                    2.11940) ) ;

s_aa_dist_26 := __common__( (0.00000 - s_td_acct_dpd_61p_cnt12_w) * 0.10347 ) ;

s_aa_code_26 := __common__( map(
    s_td_acct_dpd_61p_cnt12_w = -0.18254 => '',
    td_acct_dpd_61p_cnt12 = NULL         => 'BF105',
    td_acct_dpd_61p_cnt12 = -98          => 'BF125',
    (integer)sbfe_acct_dpd_91p_cnt12 > 0 => 'BF142',
                                            'BF141') ) ;

s_td_sbfe_worst_perf84_w := __common__( map(
    td_sbfe_worst_perf84 = NULL => 0.00000,
    td_sbfe_worst_perf84 = -98  => -0.06198,
    td_sbfe_worst_perf84 = -97  => -0.45342,
    td_sbfe_worst_perf84 <= 0.5 => -0.45342,
    td_sbfe_worst_perf84 <= 1.5 => -0.36187,
    td_sbfe_worst_perf84 <= 2.5 => -0.21965,
    td_sbfe_worst_perf84 <= 3.5 => 0.27376,
    td_sbfe_worst_perf84 <= 4.5 => 0.75555,
    td_sbfe_worst_perf84 <= 5.5 => 1.07900,
    td_sbfe_worst_perf84 <= 7.5 => 1.15937,
                                   1.37304) ) ;

s_aa_dist_27 := __common__( (0.00000 - s_td_sbfe_worst_perf84_w) * 0.37478 ) ;

s_aa_code_27 := __common__( if((integer)sbfe_worst_perf84 > 8, 'BF143', 'BF142') ) ;

s_rcvalueb037 := __common__( (integer)(s_aa_code_1 = 'B037') * s_aa_dist_1 +
    (integer)(s_aa_code_2 = 'B037') * s_aa_dist_2 +
    (integer)(s_aa_code_3 = 'B037') * s_aa_dist_3 +
    (integer)(s_aa_code_4 = 'B037') * s_aa_dist_4 +
    (integer)(s_aa_code_5 = 'B037') * s_aa_dist_5 +
    (integer)(s_aa_code_6 = 'B037') * s_aa_dist_6 +
    (integer)(s_aa_code_7 = 'B037') * s_aa_dist_7 +
    (integer)(s_aa_code_8 = 'B037') * s_aa_dist_8 +
    (integer)(s_aa_code_9 = 'B037') * s_aa_dist_9 +
    (integer)(s_aa_code_10 = 'B037') * s_aa_dist_10 +
    (integer)(s_aa_code_11 = 'B037') * s_aa_dist_11 +
    (integer)(s_aa_code_12 = 'B037') * s_aa_dist_12 +
    (integer)(s_aa_code_13 = 'B037') * s_aa_dist_13 +
    (integer)(s_aa_code_14 = 'B037') * s_aa_dist_14 +
    (integer)(s_aa_code_15 = 'B037') * s_aa_dist_15 +
    (integer)(s_aa_code_16 = 'B037') * s_aa_dist_16 +
    (integer)(s_aa_code_17 = 'B037') * s_aa_dist_17 +
    (integer)(s_aa_code_18 = 'B037') * s_aa_dist_18 +
    (integer)(s_aa_code_19 = 'B037') * s_aa_dist_19 +
    (integer)(s_aa_code_20 = 'B037') * s_aa_dist_20 +
    (integer)(s_aa_code_21 = 'B037') * s_aa_dist_21 +
    (integer)(s_aa_code_22 = 'B037') * s_aa_dist_22 +
    (integer)(s_aa_code_23 = 'B037') * s_aa_dist_23 +
    (integer)(s_aa_code_24 = 'B037') * s_aa_dist_24 +
    (integer)(s_aa_code_25 = 'B037') * s_aa_dist_25 +
    (integer)(s_aa_code_26 = 'B037') * s_aa_dist_26 +
    (integer)(s_aa_code_27 = 'B037') * s_aa_dist_27 ) ;

s_rcvalueb034 := __common__( (integer)(s_aa_code_1 = 'B034') * s_aa_dist_1 +
    (integer)(s_aa_code_2 = 'B034') * s_aa_dist_2 +
    (integer)(s_aa_code_3 = 'B034') * s_aa_dist_3 +
    (integer)(s_aa_code_4 = 'B034') * s_aa_dist_4 +
    (integer)(s_aa_code_5 = 'B034') * s_aa_dist_5 +
    (integer)(s_aa_code_6 = 'B034') * s_aa_dist_6 +
    (integer)(s_aa_code_7 = 'B034') * s_aa_dist_7 +
    (integer)(s_aa_code_8 = 'B034') * s_aa_dist_8 +
    (integer)(s_aa_code_9 = 'B034') * s_aa_dist_9 +
    (integer)(s_aa_code_10 = 'B034') * s_aa_dist_10 +
    (integer)(s_aa_code_11 = 'B034') * s_aa_dist_11 +
    (integer)(s_aa_code_12 = 'B034') * s_aa_dist_12 +
    (integer)(s_aa_code_13 = 'B034') * s_aa_dist_13 +
    (integer)(s_aa_code_14 = 'B034') * s_aa_dist_14 +
    (integer)(s_aa_code_15 = 'B034') * s_aa_dist_15 +
    (integer)(s_aa_code_16 = 'B034') * s_aa_dist_16 +
    (integer)(s_aa_code_17 = 'B034') * s_aa_dist_17 +
    (integer)(s_aa_code_18 = 'B034') * s_aa_dist_18 +
    (integer)(s_aa_code_19 = 'B034') * s_aa_dist_19 +
    (integer)(s_aa_code_20 = 'B034') * s_aa_dist_20 +
    (integer)(s_aa_code_21 = 'B034') * s_aa_dist_21 +
    (integer)(s_aa_code_22 = 'B034') * s_aa_dist_22 +
    (integer)(s_aa_code_23 = 'B034') * s_aa_dist_23 +
    (integer)(s_aa_code_24 = 'B034') * s_aa_dist_24 +
    (integer)(s_aa_code_25 = 'B034') * s_aa_dist_25 +
    (integer)(s_aa_code_26 = 'B034') * s_aa_dist_26 +
    (integer)(s_aa_code_27 = 'B034') * s_aa_dist_27 ) ;

s_rcvalueb031 := __common__( (integer)(s_aa_code_1 = 'B031') * s_aa_dist_1 +
    (integer)(s_aa_code_2 = 'B031') * s_aa_dist_2 +
    (integer)(s_aa_code_3 = 'B031') * s_aa_dist_3 +
    (integer)(s_aa_code_4 = 'B031') * s_aa_dist_4 +
    (integer)(s_aa_code_5 = 'B031') * s_aa_dist_5 +
    (integer)(s_aa_code_6 = 'B031') * s_aa_dist_6 +
    (integer)(s_aa_code_7 = 'B031') * s_aa_dist_7 +
    (integer)(s_aa_code_8 = 'B031') * s_aa_dist_8 +
    (integer)(s_aa_code_9 = 'B031') * s_aa_dist_9 +
    (integer)(s_aa_code_10 = 'B031') * s_aa_dist_10 +
    (integer)(s_aa_code_11 = 'B031') * s_aa_dist_11 +
    (integer)(s_aa_code_12 = 'B031') * s_aa_dist_12 +
    (integer)(s_aa_code_13 = 'B031') * s_aa_dist_13 +
    (integer)(s_aa_code_14 = 'B031') * s_aa_dist_14 +
    (integer)(s_aa_code_15 = 'B031') * s_aa_dist_15 +
    (integer)(s_aa_code_16 = 'B031') * s_aa_dist_16 +
    (integer)(s_aa_code_17 = 'B031') * s_aa_dist_17 +
    (integer)(s_aa_code_18 = 'B031') * s_aa_dist_18 +
    (integer)(s_aa_code_19 = 'B031') * s_aa_dist_19 +
    (integer)(s_aa_code_20 = 'B031') * s_aa_dist_20 +
    (integer)(s_aa_code_21 = 'B031') * s_aa_dist_21 +
    (integer)(s_aa_code_22 = 'B031') * s_aa_dist_22 +
    (integer)(s_aa_code_23 = 'B031') * s_aa_dist_23 +
    (integer)(s_aa_code_24 = 'B031') * s_aa_dist_24 +
    (integer)(s_aa_code_25 = 'B031') * s_aa_dist_25 +
    (integer)(s_aa_code_26 = 'B031') * s_aa_dist_26 +
    (integer)(s_aa_code_27 = 'B031') * s_aa_dist_27 ) ;

s_rcvalueb017 := __common__( (integer)(s_aa_code_1 = 'B017') * s_aa_dist_1 +
    (integer)(s_aa_code_2 = 'B017') * s_aa_dist_2 +
    (integer)(s_aa_code_3 = 'B017') * s_aa_dist_3 +
    (integer)(s_aa_code_4 = 'B017') * s_aa_dist_4 +
    (integer)(s_aa_code_5 = 'B017') * s_aa_dist_5 +
    (integer)(s_aa_code_6 = 'B017') * s_aa_dist_6 +
    (integer)(s_aa_code_7 = 'B017') * s_aa_dist_7 +
    (integer)(s_aa_code_8 = 'B017') * s_aa_dist_8 +
    (integer)(s_aa_code_9 = 'B017') * s_aa_dist_9 +
    (integer)(s_aa_code_10 = 'B017') * s_aa_dist_10 +
    (integer)(s_aa_code_11 = 'B017') * s_aa_dist_11 +
    (integer)(s_aa_code_12 = 'B017') * s_aa_dist_12 +
    (integer)(s_aa_code_13 = 'B017') * s_aa_dist_13 +
    (integer)(s_aa_code_14 = 'B017') * s_aa_dist_14 +
    (integer)(s_aa_code_15 = 'B017') * s_aa_dist_15 +
    (integer)(s_aa_code_16 = 'B017') * s_aa_dist_16 +
    (integer)(s_aa_code_17 = 'B017') * s_aa_dist_17 +
    (integer)(s_aa_code_18 = 'B017') * s_aa_dist_18 +
    (integer)(s_aa_code_19 = 'B017') * s_aa_dist_19 +
    (integer)(s_aa_code_20 = 'B017') * s_aa_dist_20 +
    (integer)(s_aa_code_21 = 'B017') * s_aa_dist_21 +
    (integer)(s_aa_code_22 = 'B017') * s_aa_dist_22 +
    (integer)(s_aa_code_23 = 'B017') * s_aa_dist_23 +
    (integer)(s_aa_code_24 = 'B017') * s_aa_dist_24 +
    (integer)(s_aa_code_25 = 'B017') * s_aa_dist_25 +
    (integer)(s_aa_code_26 = 'B017') * s_aa_dist_26 +
    (integer)(s_aa_code_27 = 'B017') * s_aa_dist_27 ) ;

s_rcvaluebf142 := __common__( (integer)(s_aa_code_1 = 'BF142') * s_aa_dist_1 +
    (integer)(s_aa_code_2 = 'BF142') * s_aa_dist_2 +
    (integer)(s_aa_code_3 = 'BF142') * s_aa_dist_3 +
    (integer)(s_aa_code_4 = 'BF142') * s_aa_dist_4 +
    (integer)(s_aa_code_5 = 'BF142') * s_aa_dist_5 +
    (integer)(s_aa_code_6 = 'BF142') * s_aa_dist_6 +
    (integer)(s_aa_code_7 = 'BF142') * s_aa_dist_7 +
    (integer)(s_aa_code_8 = 'BF142') * s_aa_dist_8 +
    (integer)(s_aa_code_9 = 'BF142') * s_aa_dist_9 +
    (integer)(s_aa_code_10 = 'BF142') * s_aa_dist_10 +
    (integer)(s_aa_code_11 = 'BF142') * s_aa_dist_11 +
    (integer)(s_aa_code_12 = 'BF142') * s_aa_dist_12 +
    (integer)(s_aa_code_13 = 'BF142') * s_aa_dist_13 +
    (integer)(s_aa_code_14 = 'BF142') * s_aa_dist_14 +
    (integer)(s_aa_code_15 = 'BF142') * s_aa_dist_15 +
    (integer)(s_aa_code_16 = 'BF142') * s_aa_dist_16 +
    (integer)(s_aa_code_17 = 'BF142') * s_aa_dist_17 +
    (integer)(s_aa_code_18 = 'BF142') * s_aa_dist_18 +
    (integer)(s_aa_code_19 = 'BF142') * s_aa_dist_19 +
    (integer)(s_aa_code_20 = 'BF142') * s_aa_dist_20 +
    (integer)(s_aa_code_21 = 'BF142') * s_aa_dist_21 +
    (integer)(s_aa_code_22 = 'BF142') * s_aa_dist_22 +
    (integer)(s_aa_code_23 = 'BF142') * s_aa_dist_23 +
    (integer)(s_aa_code_24 = 'BF142') * s_aa_dist_24 +
    (integer)(s_aa_code_25 = 'BF142') * s_aa_dist_25 +
    (integer)(s_aa_code_26 = 'BF142') * s_aa_dist_26 +
    (integer)(s_aa_code_27 = 'BF142') * s_aa_dist_27 ) ;

s_rcvaluebf135 := __common__( (integer)(s_aa_code_1 = 'BF135') * s_aa_dist_1 +
    (integer)(s_aa_code_2 = 'BF135') * s_aa_dist_2 +
    (integer)(s_aa_code_3 = 'BF135') * s_aa_dist_3 +
    (integer)(s_aa_code_4 = 'BF135') * s_aa_dist_4 +
    (integer)(s_aa_code_5 = 'BF135') * s_aa_dist_5 +
    (integer)(s_aa_code_6 = 'BF135') * s_aa_dist_6 +
    (integer)(s_aa_code_7 = 'BF135') * s_aa_dist_7 +
    (integer)(s_aa_code_8 = 'BF135') * s_aa_dist_8 +
    (integer)(s_aa_code_9 = 'BF135') * s_aa_dist_9 +
    (integer)(s_aa_code_10 = 'BF135') * s_aa_dist_10 +
    (integer)(s_aa_code_11 = 'BF135') * s_aa_dist_11 +
    (integer)(s_aa_code_12 = 'BF135') * s_aa_dist_12 +
    (integer)(s_aa_code_13 = 'BF135') * s_aa_dist_13 +
    (integer)(s_aa_code_14 = 'BF135') * s_aa_dist_14 +
    (integer)(s_aa_code_15 = 'BF135') * s_aa_dist_15 +
    (integer)(s_aa_code_16 = 'BF135') * s_aa_dist_16 +
    (integer)(s_aa_code_17 = 'BF135') * s_aa_dist_17 +
    (integer)(s_aa_code_18 = 'BF135') * s_aa_dist_18 +
    (integer)(s_aa_code_19 = 'BF135') * s_aa_dist_19 +
    (integer)(s_aa_code_20 = 'BF135') * s_aa_dist_20 +
    (integer)(s_aa_code_21 = 'BF135') * s_aa_dist_21 +
    (integer)(s_aa_code_22 = 'BF135') * s_aa_dist_22 +
    (integer)(s_aa_code_23 = 'BF135') * s_aa_dist_23 +
    (integer)(s_aa_code_24 = 'BF135') * s_aa_dist_24 +
    (integer)(s_aa_code_25 = 'BF135') * s_aa_dist_25 +
    (integer)(s_aa_code_26 = 'BF135') * s_aa_dist_26 +
    (integer)(s_aa_code_27 = 'BF135') * s_aa_dist_27 ) ;

s_rcvaluebf134 := __common__( (integer)(s_aa_code_1 = 'BF134') * s_aa_dist_1 +
    (integer)(s_aa_code_2 = 'BF134') * s_aa_dist_2 +
    (integer)(s_aa_code_3 = 'BF134') * s_aa_dist_3 +
    (integer)(s_aa_code_4 = 'BF134') * s_aa_dist_4 +
    (integer)(s_aa_code_5 = 'BF134') * s_aa_dist_5 +
    (integer)(s_aa_code_6 = 'BF134') * s_aa_dist_6 +
    (integer)(s_aa_code_7 = 'BF134') * s_aa_dist_7 +
    (integer)(s_aa_code_8 = 'BF134') * s_aa_dist_8 +
    (integer)(s_aa_code_9 = 'BF134') * s_aa_dist_9 +
    (integer)(s_aa_code_10 = 'BF134') * s_aa_dist_10 +
    (integer)(s_aa_code_11 = 'BF134') * s_aa_dist_11 +
    (integer)(s_aa_code_12 = 'BF134') * s_aa_dist_12 +
    (integer)(s_aa_code_13 = 'BF134') * s_aa_dist_13 +
    (integer)(s_aa_code_14 = 'BF134') * s_aa_dist_14 +
    (integer)(s_aa_code_15 = 'BF134') * s_aa_dist_15 +
    (integer)(s_aa_code_16 = 'BF134') * s_aa_dist_16 +
    (integer)(s_aa_code_17 = 'BF134') * s_aa_dist_17 +
    (integer)(s_aa_code_18 = 'BF134') * s_aa_dist_18 +
    (integer)(s_aa_code_19 = 'BF134') * s_aa_dist_19 +
    (integer)(s_aa_code_20 = 'BF134') * s_aa_dist_20 +
    (integer)(s_aa_code_21 = 'BF134') * s_aa_dist_21 +
    (integer)(s_aa_code_22 = 'BF134') * s_aa_dist_22 +
    (integer)(s_aa_code_23 = 'BF134') * s_aa_dist_23 +
    (integer)(s_aa_code_24 = 'BF134') * s_aa_dist_24 +
    (integer)(s_aa_code_25 = 'BF134') * s_aa_dist_25 +
    (integer)(s_aa_code_26 = 'BF134') * s_aa_dist_26 +
    (integer)(s_aa_code_27 = 'BF134') * s_aa_dist_27 ) ;

s_rcvaluebf136 := __common__( (integer)(s_aa_code_1 = 'BF136') * s_aa_dist_1 +
    (integer)(s_aa_code_2 = 'BF136') * s_aa_dist_2 +
    (integer)(s_aa_code_3 = 'BF136') * s_aa_dist_3 +
    (integer)(s_aa_code_4 = 'BF136') * s_aa_dist_4 +
    (integer)(s_aa_code_5 = 'BF136') * s_aa_dist_5 +
    (integer)(s_aa_code_6 = 'BF136') * s_aa_dist_6 +
    (integer)(s_aa_code_7 = 'BF136') * s_aa_dist_7 +
    (integer)(s_aa_code_8 = 'BF136') * s_aa_dist_8 +
    (integer)(s_aa_code_9 = 'BF136') * s_aa_dist_9 +
    (integer)(s_aa_code_10 = 'BF136') * s_aa_dist_10 +
    (integer)(s_aa_code_11 = 'BF136') * s_aa_dist_11 +
    (integer)(s_aa_code_12 = 'BF136') * s_aa_dist_12 +
    (integer)(s_aa_code_13 = 'BF136') * s_aa_dist_13 +
    (integer)(s_aa_code_14 = 'BF136') * s_aa_dist_14 +
    (integer)(s_aa_code_15 = 'BF136') * s_aa_dist_15 +
    (integer)(s_aa_code_16 = 'BF136') * s_aa_dist_16 +
    (integer)(s_aa_code_17 = 'BF136') * s_aa_dist_17 +
    (integer)(s_aa_code_18 = 'BF136') * s_aa_dist_18 +
    (integer)(s_aa_code_19 = 'BF136') * s_aa_dist_19 +
    (integer)(s_aa_code_20 = 'BF136') * s_aa_dist_20 +
    (integer)(s_aa_code_21 = 'BF136') * s_aa_dist_21 +
    (integer)(s_aa_code_22 = 'BF136') * s_aa_dist_22 +
    (integer)(s_aa_code_23 = 'BF136') * s_aa_dist_23 +
    (integer)(s_aa_code_24 = 'BF136') * s_aa_dist_24 +
    (integer)(s_aa_code_25 = 'BF136') * s_aa_dist_25 +
    (integer)(s_aa_code_26 = 'BF136') * s_aa_dist_26 +
    (integer)(s_aa_code_27 = 'BF136') * s_aa_dist_27 ) ;

s_rcvaluebf117 := __common__( (integer)(s_aa_code_1 = 'BF117') * s_aa_dist_1 +
    (integer)(s_aa_code_2 = 'BF117') * s_aa_dist_2 +
    (integer)(s_aa_code_3 = 'BF117') * s_aa_dist_3 +
    (integer)(s_aa_code_4 = 'BF117') * s_aa_dist_4 +
    (integer)(s_aa_code_5 = 'BF117') * s_aa_dist_5 +
    (integer)(s_aa_code_6 = 'BF117') * s_aa_dist_6 +
    (integer)(s_aa_code_7 = 'BF117') * s_aa_dist_7 +
    (integer)(s_aa_code_8 = 'BF117') * s_aa_dist_8 +
    (integer)(s_aa_code_9 = 'BF117') * s_aa_dist_9 +
    (integer)(s_aa_code_10 = 'BF117') * s_aa_dist_10 +
    (integer)(s_aa_code_11 = 'BF117') * s_aa_dist_11 +
    (integer)(s_aa_code_12 = 'BF117') * s_aa_dist_12 +
    (integer)(s_aa_code_13 = 'BF117') * s_aa_dist_13 +
    (integer)(s_aa_code_14 = 'BF117') * s_aa_dist_14 +
    (integer)(s_aa_code_15 = 'BF117') * s_aa_dist_15 +
    (integer)(s_aa_code_16 = 'BF117') * s_aa_dist_16 +
    (integer)(s_aa_code_17 = 'BF117') * s_aa_dist_17 +
    (integer)(s_aa_code_18 = 'BF117') * s_aa_dist_18 +
    (integer)(s_aa_code_19 = 'BF117') * s_aa_dist_19 +
    (integer)(s_aa_code_20 = 'BF117') * s_aa_dist_20 +
    (integer)(s_aa_code_21 = 'BF117') * s_aa_dist_21 +
    (integer)(s_aa_code_22 = 'BF117') * s_aa_dist_22 +
    (integer)(s_aa_code_23 = 'BF117') * s_aa_dist_23 +
    (integer)(s_aa_code_24 = 'BF117') * s_aa_dist_24 +
    (integer)(s_aa_code_25 = 'BF117') * s_aa_dist_25 +
    (integer)(s_aa_code_26 = 'BF117') * s_aa_dist_26 +
    (integer)(s_aa_code_27 = 'BF117') * s_aa_dist_27 ) ;

s_rcvaluebf133 := __common__( (integer)(s_aa_code_1 = 'BF133') * s_aa_dist_1 +
    (integer)(s_aa_code_2 = 'BF133') * s_aa_dist_2 +
    (integer)(s_aa_code_3 = 'BF133') * s_aa_dist_3 +
    (integer)(s_aa_code_4 = 'BF133') * s_aa_dist_4 +
    (integer)(s_aa_code_5 = 'BF133') * s_aa_dist_5 +
    (integer)(s_aa_code_6 = 'BF133') * s_aa_dist_6 +
    (integer)(s_aa_code_7 = 'BF133') * s_aa_dist_7 +
    (integer)(s_aa_code_8 = 'BF133') * s_aa_dist_8 +
    (integer)(s_aa_code_9 = 'BF133') * s_aa_dist_9 +
    (integer)(s_aa_code_10 = 'BF133') * s_aa_dist_10 +
    (integer)(s_aa_code_11 = 'BF133') * s_aa_dist_11 +
    (integer)(s_aa_code_12 = 'BF133') * s_aa_dist_12 +
    (integer)(s_aa_code_13 = 'BF133') * s_aa_dist_13 +
    (integer)(s_aa_code_14 = 'BF133') * s_aa_dist_14 +
    (integer)(s_aa_code_15 = 'BF133') * s_aa_dist_15 +
    (integer)(s_aa_code_16 = 'BF133') * s_aa_dist_16 +
    (integer)(s_aa_code_17 = 'BF133') * s_aa_dist_17 +
    (integer)(s_aa_code_18 = 'BF133') * s_aa_dist_18 +
    (integer)(s_aa_code_19 = 'BF133') * s_aa_dist_19 +
    (integer)(s_aa_code_20 = 'BF133') * s_aa_dist_20 +
    (integer)(s_aa_code_21 = 'BF133') * s_aa_dist_21 +
    (integer)(s_aa_code_22 = 'BF133') * s_aa_dist_22 +
    (integer)(s_aa_code_23 = 'BF133') * s_aa_dist_23 +
    (integer)(s_aa_code_24 = 'BF133') * s_aa_dist_24 +
    (integer)(s_aa_code_25 = 'BF133') * s_aa_dist_25 +
    (integer)(s_aa_code_26 = 'BF133') * s_aa_dist_26 +
    (integer)(s_aa_code_27 = 'BF133') * s_aa_dist_27 ) ;

s_rcvalueb040 := __common__( (integer)(s_aa_code_1 = 'B040') * s_aa_dist_1 +
    (integer)(s_aa_code_2 = 'B040') * s_aa_dist_2 +
    (integer)(s_aa_code_3 = 'B040') * s_aa_dist_3 +
    (integer)(s_aa_code_4 = 'B040') * s_aa_dist_4 +
    (integer)(s_aa_code_5 = 'B040') * s_aa_dist_5 +
    (integer)(s_aa_code_6 = 'B040') * s_aa_dist_6 +
    (integer)(s_aa_code_7 = 'B040') * s_aa_dist_7 +
    (integer)(s_aa_code_8 = 'B040') * s_aa_dist_8 +
    (integer)(s_aa_code_9 = 'B040') * s_aa_dist_9 +
    (integer)(s_aa_code_10 = 'B040') * s_aa_dist_10 +
    (integer)(s_aa_code_11 = 'B040') * s_aa_dist_11 +
    (integer)(s_aa_code_12 = 'B040') * s_aa_dist_12 +
    (integer)(s_aa_code_13 = 'B040') * s_aa_dist_13 +
    (integer)(s_aa_code_14 = 'B040') * s_aa_dist_14 +
    (integer)(s_aa_code_15 = 'B040') * s_aa_dist_15 +
    (integer)(s_aa_code_16 = 'B040') * s_aa_dist_16 +
    (integer)(s_aa_code_17 = 'B040') * s_aa_dist_17 +
    (integer)(s_aa_code_18 = 'B040') * s_aa_dist_18 +
    (integer)(s_aa_code_19 = 'B040') * s_aa_dist_19 +
    (integer)(s_aa_code_20 = 'B040') * s_aa_dist_20 +
    (integer)(s_aa_code_21 = 'B040') * s_aa_dist_21 +
    (integer)(s_aa_code_22 = 'B040') * s_aa_dist_22 +
    (integer)(s_aa_code_23 = 'B040') * s_aa_dist_23 +
    (integer)(s_aa_code_24 = 'B040') * s_aa_dist_24 +
    (integer)(s_aa_code_25 = 'B040') * s_aa_dist_25 +
    (integer)(s_aa_code_26 = 'B040') * s_aa_dist_26 +
    (integer)(s_aa_code_27 = 'B040') * s_aa_dist_27 ) ;

s_rcvaluebf141 := __common__( (integer)(s_aa_code_1 = 'BF141') * s_aa_dist_1 +
    (integer)(s_aa_code_2 = 'BF141') * s_aa_dist_2 +
    (integer)(s_aa_code_3 = 'BF141') * s_aa_dist_3 +
    (integer)(s_aa_code_4 = 'BF141') * s_aa_dist_4 +
    (integer)(s_aa_code_5 = 'BF141') * s_aa_dist_5 +
    (integer)(s_aa_code_6 = 'BF141') * s_aa_dist_6 +
    (integer)(s_aa_code_7 = 'BF141') * s_aa_dist_7 +
    (integer)(s_aa_code_8 = 'BF141') * s_aa_dist_8 +
    (integer)(s_aa_code_9 = 'BF141') * s_aa_dist_9 +
    (integer)(s_aa_code_10 = 'BF141') * s_aa_dist_10 +
    (integer)(s_aa_code_11 = 'BF141') * s_aa_dist_11 +
    (integer)(s_aa_code_12 = 'BF141') * s_aa_dist_12 +
    (integer)(s_aa_code_13 = 'BF141') * s_aa_dist_13 +
    (integer)(s_aa_code_14 = 'BF141') * s_aa_dist_14 +
    (integer)(s_aa_code_15 = 'BF141') * s_aa_dist_15 +
    (integer)(s_aa_code_16 = 'BF141') * s_aa_dist_16 +
    (integer)(s_aa_code_17 = 'BF141') * s_aa_dist_17 +
    (integer)(s_aa_code_18 = 'BF141') * s_aa_dist_18 +
    (integer)(s_aa_code_19 = 'BF141') * s_aa_dist_19 +
    (integer)(s_aa_code_20 = 'BF141') * s_aa_dist_20 +
    (integer)(s_aa_code_21 = 'BF141') * s_aa_dist_21 +
    (integer)(s_aa_code_22 = 'BF141') * s_aa_dist_22 +
    (integer)(s_aa_code_23 = 'BF141') * s_aa_dist_23 +
    (integer)(s_aa_code_24 = 'BF141') * s_aa_dist_24 +
    (integer)(s_aa_code_25 = 'BF141') * s_aa_dist_25 +
    (integer)(s_aa_code_26 = 'BF141') * s_aa_dist_26 +
    (integer)(s_aa_code_27 = 'BF141') * s_aa_dist_27 ) ;

s_rcvalueb026 := __common__( (integer)(s_aa_code_1 = 'B026') * s_aa_dist_1 +
    (integer)(s_aa_code_2 = 'B026') * s_aa_dist_2 +
    (integer)(s_aa_code_3 = 'B026') * s_aa_dist_3 +
    (integer)(s_aa_code_4 = 'B026') * s_aa_dist_4 +
    (integer)(s_aa_code_5 = 'B026') * s_aa_dist_5 +
    (integer)(s_aa_code_6 = 'B026') * s_aa_dist_6 +
    (integer)(s_aa_code_7 = 'B026') * s_aa_dist_7 +
    (integer)(s_aa_code_8 = 'B026') * s_aa_dist_8 +
    (integer)(s_aa_code_9 = 'B026') * s_aa_dist_9 +
    (integer)(s_aa_code_10 = 'B026') * s_aa_dist_10 +
    (integer)(s_aa_code_11 = 'B026') * s_aa_dist_11 +
    (integer)(s_aa_code_12 = 'B026') * s_aa_dist_12 +
    (integer)(s_aa_code_13 = 'B026') * s_aa_dist_13 +
    (integer)(s_aa_code_14 = 'B026') * s_aa_dist_14 +
    (integer)(s_aa_code_15 = 'B026') * s_aa_dist_15 +
    (integer)(s_aa_code_16 = 'B026') * s_aa_dist_16 +
    (integer)(s_aa_code_17 = 'B026') * s_aa_dist_17 +
    (integer)(s_aa_code_18 = 'B026') * s_aa_dist_18 +
    (integer)(s_aa_code_19 = 'B026') * s_aa_dist_19 +
    (integer)(s_aa_code_20 = 'B026') * s_aa_dist_20 +
    (integer)(s_aa_code_21 = 'B026') * s_aa_dist_21 +
    (integer)(s_aa_code_22 = 'B026') * s_aa_dist_22 +
    (integer)(s_aa_code_23 = 'B026') * s_aa_dist_23 +
    (integer)(s_aa_code_24 = 'B026') * s_aa_dist_24 +
    (integer)(s_aa_code_25 = 'B026') * s_aa_dist_25 +
    (integer)(s_aa_code_26 = 'B026') * s_aa_dist_26 +
    (integer)(s_aa_code_27 = 'B026') * s_aa_dist_27 ) ;

s_rcvaluebf143 := __common__( (integer)(s_aa_code_1 = 'BF143') * s_aa_dist_1 +
    (integer)(s_aa_code_2 = 'BF143') * s_aa_dist_2 +
    (integer)(s_aa_code_3 = 'BF143') * s_aa_dist_3 +
    (integer)(s_aa_code_4 = 'BF143') * s_aa_dist_4 +
    (integer)(s_aa_code_5 = 'BF143') * s_aa_dist_5 +
    (integer)(s_aa_code_6 = 'BF143') * s_aa_dist_6 +
    (integer)(s_aa_code_7 = 'BF143') * s_aa_dist_7 +
    (integer)(s_aa_code_8 = 'BF143') * s_aa_dist_8 +
    (integer)(s_aa_code_9 = 'BF143') * s_aa_dist_9 +
    (integer)(s_aa_code_10 = 'BF143') * s_aa_dist_10 +
    (integer)(s_aa_code_11 = 'BF143') * s_aa_dist_11 +
    (integer)(s_aa_code_12 = 'BF143') * s_aa_dist_12 +
    (integer)(s_aa_code_13 = 'BF143') * s_aa_dist_13 +
    (integer)(s_aa_code_14 = 'BF143') * s_aa_dist_14 +
    (integer)(s_aa_code_15 = 'BF143') * s_aa_dist_15 +
    (integer)(s_aa_code_16 = 'BF143') * s_aa_dist_16 +
    (integer)(s_aa_code_17 = 'BF143') * s_aa_dist_17 +
    (integer)(s_aa_code_18 = 'BF143') * s_aa_dist_18 +
    (integer)(s_aa_code_19 = 'BF143') * s_aa_dist_19 +
    (integer)(s_aa_code_20 = 'BF143') * s_aa_dist_20 +
    (integer)(s_aa_code_21 = 'BF143') * s_aa_dist_21 +
    (integer)(s_aa_code_22 = 'BF143') * s_aa_dist_22 +
    (integer)(s_aa_code_23 = 'BF143') * s_aa_dist_23 +
    (integer)(s_aa_code_24 = 'BF143') * s_aa_dist_24 +
    (integer)(s_aa_code_25 = 'BF143') * s_aa_dist_25 +
    (integer)(s_aa_code_26 = 'BF143') * s_aa_dist_26 +
    (integer)(s_aa_code_27 = 'BF143') * s_aa_dist_27 ) ;

s_rcvalueb063 := __common__( (integer)(s_aa_code_1 = 'B063') * s_aa_dist_1 +
    (integer)(s_aa_code_2 = 'B063') * s_aa_dist_2 +
    (integer)(s_aa_code_3 = 'B063') * s_aa_dist_3 +
    (integer)(s_aa_code_4 = 'B063') * s_aa_dist_4 +
    (integer)(s_aa_code_5 = 'B063') * s_aa_dist_5 +
    (integer)(s_aa_code_6 = 'B063') * s_aa_dist_6 +
    (integer)(s_aa_code_7 = 'B063') * s_aa_dist_7 +
    (integer)(s_aa_code_8 = 'B063') * s_aa_dist_8 +
    (integer)(s_aa_code_9 = 'B063') * s_aa_dist_9 +
    (integer)(s_aa_code_10 = 'B063') * s_aa_dist_10 +
    (integer)(s_aa_code_11 = 'B063') * s_aa_dist_11 +
    (integer)(s_aa_code_12 = 'B063') * s_aa_dist_12 +
    (integer)(s_aa_code_13 = 'B063') * s_aa_dist_13 +
    (integer)(s_aa_code_14 = 'B063') * s_aa_dist_14 +
    (integer)(s_aa_code_15 = 'B063') * s_aa_dist_15 +
    (integer)(s_aa_code_16 = 'B063') * s_aa_dist_16 +
    (integer)(s_aa_code_17 = 'B063') * s_aa_dist_17 +
    (integer)(s_aa_code_18 = 'B063') * s_aa_dist_18 +
    (integer)(s_aa_code_19 = 'B063') * s_aa_dist_19 +
    (integer)(s_aa_code_20 = 'B063') * s_aa_dist_20 +
    (integer)(s_aa_code_21 = 'B063') * s_aa_dist_21 +
    (integer)(s_aa_code_22 = 'B063') * s_aa_dist_22 +
    (integer)(s_aa_code_23 = 'B063') * s_aa_dist_23 +
    (integer)(s_aa_code_24 = 'B063') * s_aa_dist_24 +
    (integer)(s_aa_code_25 = 'B063') * s_aa_dist_25 +
    (integer)(s_aa_code_26 = 'B063') * s_aa_dist_26 +
    (integer)(s_aa_code_27 = 'B063') * s_aa_dist_27 ) ;

s_rcvaluebf126 := __common__( (integer)(s_aa_code_1 = 'BF126') * s_aa_dist_1 +
    (integer)(s_aa_code_2 = 'BF126') * s_aa_dist_2 +
    (integer)(s_aa_code_3 = 'BF126') * s_aa_dist_3 +
    (integer)(s_aa_code_4 = 'BF126') * s_aa_dist_4 +
    (integer)(s_aa_code_5 = 'BF126') * s_aa_dist_5 +
    (integer)(s_aa_code_6 = 'BF126') * s_aa_dist_6 +
    (integer)(s_aa_code_7 = 'BF126') * s_aa_dist_7 +
    (integer)(s_aa_code_8 = 'BF126') * s_aa_dist_8 +
    (integer)(s_aa_code_9 = 'BF126') * s_aa_dist_9 +
    (integer)(s_aa_code_10 = 'BF126') * s_aa_dist_10 +
    (integer)(s_aa_code_11 = 'BF126') * s_aa_dist_11 +
    (integer)(s_aa_code_12 = 'BF126') * s_aa_dist_12 +
    (integer)(s_aa_code_13 = 'BF126') * s_aa_dist_13 +
    (integer)(s_aa_code_14 = 'BF126') * s_aa_dist_14 +
    (integer)(s_aa_code_15 = 'BF126') * s_aa_dist_15 +
    (integer)(s_aa_code_16 = 'BF126') * s_aa_dist_16 +
    (integer)(s_aa_code_17 = 'BF126') * s_aa_dist_17 +
    (integer)(s_aa_code_18 = 'BF126') * s_aa_dist_18 +
    (integer)(s_aa_code_19 = 'BF126') * s_aa_dist_19 +
    (integer)(s_aa_code_20 = 'BF126') * s_aa_dist_20 +
    (integer)(s_aa_code_21 = 'BF126') * s_aa_dist_21 +
    (integer)(s_aa_code_22 = 'BF126') * s_aa_dist_22 +
    (integer)(s_aa_code_23 = 'BF126') * s_aa_dist_23 +
    (integer)(s_aa_code_24 = 'BF126') * s_aa_dist_24 +
    (integer)(s_aa_code_25 = 'BF126') * s_aa_dist_25 +
    (integer)(s_aa_code_26 = 'BF126') * s_aa_dist_26 +
    (integer)(s_aa_code_27 = 'BF126') * s_aa_dist_27 ) ;

s_rcvaluebf127 := __common__( (integer)(s_aa_code_1 = 'BF127') * s_aa_dist_1 +
    (integer)(s_aa_code_2 = 'BF127') * s_aa_dist_2 +
    (integer)(s_aa_code_3 = 'BF127') * s_aa_dist_3 +
    (integer)(s_aa_code_4 = 'BF127') * s_aa_dist_4 +
    (integer)(s_aa_code_5 = 'BF127') * s_aa_dist_5 +
    (integer)(s_aa_code_6 = 'BF127') * s_aa_dist_6 +
    (integer)(s_aa_code_7 = 'BF127') * s_aa_dist_7 +
    (integer)(s_aa_code_8 = 'BF127') * s_aa_dist_8 +
    (integer)(s_aa_code_9 = 'BF127') * s_aa_dist_9 +
    (integer)(s_aa_code_10 = 'BF127') * s_aa_dist_10 +
    (integer)(s_aa_code_11 = 'BF127') * s_aa_dist_11 +
    (integer)(s_aa_code_12 = 'BF127') * s_aa_dist_12 +
    (integer)(s_aa_code_13 = 'BF127') * s_aa_dist_13 +
    (integer)(s_aa_code_14 = 'BF127') * s_aa_dist_14 +
    (integer)(s_aa_code_15 = 'BF127') * s_aa_dist_15 +
    (integer)(s_aa_code_16 = 'BF127') * s_aa_dist_16 +
    (integer)(s_aa_code_17 = 'BF127') * s_aa_dist_17 +
    (integer)(s_aa_code_18 = 'BF127') * s_aa_dist_18 +
    (integer)(s_aa_code_19 = 'BF127') * s_aa_dist_19 +
    (integer)(s_aa_code_20 = 'BF127') * s_aa_dist_20 +
    (integer)(s_aa_code_21 = 'BF127') * s_aa_dist_21 +
    (integer)(s_aa_code_22 = 'BF127') * s_aa_dist_22 +
    (integer)(s_aa_code_23 = 'BF127') * s_aa_dist_23 +
    (integer)(s_aa_code_24 = 'BF127') * s_aa_dist_24 +
    (integer)(s_aa_code_25 = 'BF127') * s_aa_dist_25 +
    (integer)(s_aa_code_26 = 'BF127') * s_aa_dist_26 +
    (integer)(s_aa_code_27 = 'BF127') * s_aa_dist_27 ) ;

s_rcvaluebf125 := __common__( (integer)(s_aa_code_1 = 'BF125') * s_aa_dist_1 +
    (integer)(s_aa_code_2 = 'BF125') * s_aa_dist_2 +
    (integer)(s_aa_code_3 = 'BF125') * s_aa_dist_3 +
    (integer)(s_aa_code_4 = 'BF125') * s_aa_dist_4 +
    (integer)(s_aa_code_5 = 'BF125') * s_aa_dist_5 +
    (integer)(s_aa_code_6 = 'BF125') * s_aa_dist_6 +
    (integer)(s_aa_code_7 = 'BF125') * s_aa_dist_7 +
    (integer)(s_aa_code_8 = 'BF125') * s_aa_dist_8 +
    (integer)(s_aa_code_9 = 'BF125') * s_aa_dist_9 +
    (integer)(s_aa_code_10 = 'BF125') * s_aa_dist_10 +
    (integer)(s_aa_code_11 = 'BF125') * s_aa_dist_11 +
    (integer)(s_aa_code_12 = 'BF125') * s_aa_dist_12 +
    (integer)(s_aa_code_13 = 'BF125') * s_aa_dist_13 +
    (integer)(s_aa_code_14 = 'BF125') * s_aa_dist_14 +
    (integer)(s_aa_code_15 = 'BF125') * s_aa_dist_15 +
    (integer)(s_aa_code_16 = 'BF125') * s_aa_dist_16 +
    (integer)(s_aa_code_17 = 'BF125') * s_aa_dist_17 +
    (integer)(s_aa_code_18 = 'BF125') * s_aa_dist_18 +
    (integer)(s_aa_code_19 = 'BF125') * s_aa_dist_19 +
    (integer)(s_aa_code_20 = 'BF125') * s_aa_dist_20 +
    (integer)(s_aa_code_21 = 'BF125') * s_aa_dist_21 +
    (integer)(s_aa_code_22 = 'BF125') * s_aa_dist_22 +
    (integer)(s_aa_code_23 = 'BF125') * s_aa_dist_23 +
    (integer)(s_aa_code_24 = 'BF125') * s_aa_dist_24 +
    (integer)(s_aa_code_25 = 'BF125') * s_aa_dist_25 +
    (integer)(s_aa_code_26 = 'BF125') * s_aa_dist_26 +
    (integer)(s_aa_code_27 = 'BF125') * s_aa_dist_27 ) ;

s_rcvaluebf120 := __common__( (integer)(s_aa_code_1 = 'BF120') * s_aa_dist_1 +
    (integer)(s_aa_code_2 = 'BF120') * s_aa_dist_2 +
    (integer)(s_aa_code_3 = 'BF120') * s_aa_dist_3 +
    (integer)(s_aa_code_4 = 'BF120') * s_aa_dist_4 +
    (integer)(s_aa_code_5 = 'BF120') * s_aa_dist_5 +
    (integer)(s_aa_code_6 = 'BF120') * s_aa_dist_6 +
    (integer)(s_aa_code_7 = 'BF120') * s_aa_dist_7 +
    (integer)(s_aa_code_8 = 'BF120') * s_aa_dist_8 +
    (integer)(s_aa_code_9 = 'BF120') * s_aa_dist_9 +
    (integer)(s_aa_code_10 = 'BF120') * s_aa_dist_10 +
    (integer)(s_aa_code_11 = 'BF120') * s_aa_dist_11 +
    (integer)(s_aa_code_12 = 'BF120') * s_aa_dist_12 +
    (integer)(s_aa_code_13 = 'BF120') * s_aa_dist_13 +
    (integer)(s_aa_code_14 = 'BF120') * s_aa_dist_14 +
    (integer)(s_aa_code_15 = 'BF120') * s_aa_dist_15 +
    (integer)(s_aa_code_16 = 'BF120') * s_aa_dist_16 +
    (integer)(s_aa_code_17 = 'BF120') * s_aa_dist_17 +
    (integer)(s_aa_code_18 = 'BF120') * s_aa_dist_18 +
    (integer)(s_aa_code_19 = 'BF120') * s_aa_dist_19 +
    (integer)(s_aa_code_20 = 'BF120') * s_aa_dist_20 +
    (integer)(s_aa_code_21 = 'BF120') * s_aa_dist_21 +
    (integer)(s_aa_code_22 = 'BF120') * s_aa_dist_22 +
    (integer)(s_aa_code_23 = 'BF120') * s_aa_dist_23 +
    (integer)(s_aa_code_24 = 'BF120') * s_aa_dist_24 +
    (integer)(s_aa_code_25 = 'BF120') * s_aa_dist_25 +
    (integer)(s_aa_code_26 = 'BF120') * s_aa_dist_26 +
    (integer)(s_aa_code_27 = 'BF120') * s_aa_dist_27 ) ;

s_rcvaluebf105 := __common__( (integer)(s_aa_code_1 = 'BF105') * s_aa_dist_1 +
    (integer)(s_aa_code_2 = 'BF105') * s_aa_dist_2 +
    (integer)(s_aa_code_3 = 'BF105') * s_aa_dist_3 +
    (integer)(s_aa_code_4 = 'BF105') * s_aa_dist_4 +
    (integer)(s_aa_code_5 = 'BF105') * s_aa_dist_5 +
    (integer)(s_aa_code_6 = 'BF105') * s_aa_dist_6 +
    (integer)(s_aa_code_7 = 'BF105') * s_aa_dist_7 +
    (integer)(s_aa_code_8 = 'BF105') * s_aa_dist_8 +
    (integer)(s_aa_code_9 = 'BF105') * s_aa_dist_9 +
    (integer)(s_aa_code_10 = 'BF105') * s_aa_dist_10 +
    (integer)(s_aa_code_11 = 'BF105') * s_aa_dist_11 +
    (integer)(s_aa_code_12 = 'BF105') * s_aa_dist_12 +
    (integer)(s_aa_code_13 = 'BF105') * s_aa_dist_13 +
    (integer)(s_aa_code_14 = 'BF105') * s_aa_dist_14 +
    (integer)(s_aa_code_15 = 'BF105') * s_aa_dist_15 +
    (integer)(s_aa_code_16 = 'BF105') * s_aa_dist_16 +
    (integer)(s_aa_code_17 = 'BF105') * s_aa_dist_17 +
    (integer)(s_aa_code_18 = 'BF105') * s_aa_dist_18 +
    (integer)(s_aa_code_19 = 'BF105') * s_aa_dist_19 +
    (integer)(s_aa_code_20 = 'BF105') * s_aa_dist_20 +
    (integer)(s_aa_code_21 = 'BF105') * s_aa_dist_21 +
    (integer)(s_aa_code_22 = 'BF105') * s_aa_dist_22 +
    (integer)(s_aa_code_23 = 'BF105') * s_aa_dist_23 +
    (integer)(s_aa_code_24 = 'BF105') * s_aa_dist_24 +
    (integer)(s_aa_code_25 = 'BF105') * s_aa_dist_25 +
    (integer)(s_aa_code_26 = 'BF105') * s_aa_dist_26 +
    (integer)(s_aa_code_27 = 'BF105') * s_aa_dist_27 ) ;

s_rcvaluebf106 := __common__( (integer)(s_aa_code_1 = 'BF106') * s_aa_dist_1 +
    (integer)(s_aa_code_2 = 'BF106') * s_aa_dist_2 +
    (integer)(s_aa_code_3 = 'BF106') * s_aa_dist_3 +
    (integer)(s_aa_code_4 = 'BF106') * s_aa_dist_4 +
    (integer)(s_aa_code_5 = 'BF106') * s_aa_dist_5 +
    (integer)(s_aa_code_6 = 'BF106') * s_aa_dist_6 +
    (integer)(s_aa_code_7 = 'BF106') * s_aa_dist_7 +
    (integer)(s_aa_code_8 = 'BF106') * s_aa_dist_8 +
    (integer)(s_aa_code_9 = 'BF106') * s_aa_dist_9 +
    (integer)(s_aa_code_10 = 'BF106') * s_aa_dist_10 +
    (integer)(s_aa_code_11 = 'BF106') * s_aa_dist_11 +
    (integer)(s_aa_code_12 = 'BF106') * s_aa_dist_12 +
    (integer)(s_aa_code_13 = 'BF106') * s_aa_dist_13 +
    (integer)(s_aa_code_14 = 'BF106') * s_aa_dist_14 +
    (integer)(s_aa_code_15 = 'BF106') * s_aa_dist_15 +
    (integer)(s_aa_code_16 = 'BF106') * s_aa_dist_16 +
    (integer)(s_aa_code_17 = 'BF106') * s_aa_dist_17 +
    (integer)(s_aa_code_18 = 'BF106') * s_aa_dist_18 +
    (integer)(s_aa_code_19 = 'BF106') * s_aa_dist_19 +
    (integer)(s_aa_code_20 = 'BF106') * s_aa_dist_20 +
    (integer)(s_aa_code_21 = 'BF106') * s_aa_dist_21 +
    (integer)(s_aa_code_22 = 'BF106') * s_aa_dist_22 +
    (integer)(s_aa_code_23 = 'BF106') * s_aa_dist_23 +
    (integer)(s_aa_code_24 = 'BF106') * s_aa_dist_24 +
    (integer)(s_aa_code_25 = 'BF106') * s_aa_dist_25 +
    (integer)(s_aa_code_26 = 'BF106') * s_aa_dist_26 +
    (integer)(s_aa_code_27 = 'BF106') * s_aa_dist_27 ) ;

s_rcvaluebf107 := __common__( (integer)(s_aa_code_1 = 'BF107') * s_aa_dist_1 +
    (integer)(s_aa_code_2 = 'BF107') * s_aa_dist_2 +
    (integer)(s_aa_code_3 = 'BF107') * s_aa_dist_3 +
    (integer)(s_aa_code_4 = 'BF107') * s_aa_dist_4 +
    (integer)(s_aa_code_5 = 'BF107') * s_aa_dist_5 +
    (integer)(s_aa_code_6 = 'BF107') * s_aa_dist_6 +
    (integer)(s_aa_code_7 = 'BF107') * s_aa_dist_7 +
    (integer)(s_aa_code_8 = 'BF107') * s_aa_dist_8 +
    (integer)(s_aa_code_9 = 'BF107') * s_aa_dist_9 +
    (integer)(s_aa_code_10 = 'BF107') * s_aa_dist_10 +
    (integer)(s_aa_code_11 = 'BF107') * s_aa_dist_11 +
    (integer)(s_aa_code_12 = 'BF107') * s_aa_dist_12 +
    (integer)(s_aa_code_13 = 'BF107') * s_aa_dist_13 +
    (integer)(s_aa_code_14 = 'BF107') * s_aa_dist_14 +
    (integer)(s_aa_code_15 = 'BF107') * s_aa_dist_15 +
    (integer)(s_aa_code_16 = 'BF107') * s_aa_dist_16 +
    (integer)(s_aa_code_17 = 'BF107') * s_aa_dist_17 +
    (integer)(s_aa_code_18 = 'BF107') * s_aa_dist_18 +
    (integer)(s_aa_code_19 = 'BF107') * s_aa_dist_19 +
    (integer)(s_aa_code_20 = 'BF107') * s_aa_dist_20 +
    (integer)(s_aa_code_21 = 'BF107') * s_aa_dist_21 +
    (integer)(s_aa_code_22 = 'BF107') * s_aa_dist_22 +
    (integer)(s_aa_code_23 = 'BF107') * s_aa_dist_23 +
    (integer)(s_aa_code_24 = 'BF107') * s_aa_dist_24 +
    (integer)(s_aa_code_25 = 'BF107') * s_aa_dist_25 +
    (integer)(s_aa_code_26 = 'BF107') * s_aa_dist_26 +
    (integer)(s_aa_code_27 = 'BF107') * s_aa_dist_27 ) ;

s_rcvaluebf128 := __common__( (integer)(s_aa_code_1 = 'BF128') * s_aa_dist_1 +
    (integer)(s_aa_code_2 = 'BF128') * s_aa_dist_2 +
    (integer)(s_aa_code_3 = 'BF128') * s_aa_dist_3 +
    (integer)(s_aa_code_4 = 'BF128') * s_aa_dist_4 +
    (integer)(s_aa_code_5 = 'BF128') * s_aa_dist_5 +
    (integer)(s_aa_code_6 = 'BF128') * s_aa_dist_6 +
    (integer)(s_aa_code_7 = 'BF128') * s_aa_dist_7 +
    (integer)(s_aa_code_8 = 'BF128') * s_aa_dist_8 +
    (integer)(s_aa_code_9 = 'BF128') * s_aa_dist_9 +
    (integer)(s_aa_code_10 = 'BF128') * s_aa_dist_10 +
    (integer)(s_aa_code_11 = 'BF128') * s_aa_dist_11 +
    (integer)(s_aa_code_12 = 'BF128') * s_aa_dist_12 +
    (integer)(s_aa_code_13 = 'BF128') * s_aa_dist_13 +
    (integer)(s_aa_code_14 = 'BF128') * s_aa_dist_14 +
    (integer)(s_aa_code_15 = 'BF128') * s_aa_dist_15 +
    (integer)(s_aa_code_16 = 'BF128') * s_aa_dist_16 +
    (integer)(s_aa_code_17 = 'BF128') * s_aa_dist_17 +
    (integer)(s_aa_code_18 = 'BF128') * s_aa_dist_18 +
    (integer)(s_aa_code_19 = 'BF128') * s_aa_dist_19 +
    (integer)(s_aa_code_20 = 'BF128') * s_aa_dist_20 +
    (integer)(s_aa_code_21 = 'BF128') * s_aa_dist_21 +
    (integer)(s_aa_code_22 = 'BF128') * s_aa_dist_22 +
    (integer)(s_aa_code_23 = 'BF128') * s_aa_dist_23 +
    (integer)(s_aa_code_24 = 'BF128') * s_aa_dist_24 +
    (integer)(s_aa_code_25 = 'BF128') * s_aa_dist_25 +
    (integer)(s_aa_code_26 = 'BF128') * s_aa_dist_26 +
    (integer)(s_aa_code_27 = 'BF128') * s_aa_dist_27 ) ;

s_rcvaluebf129 := __common__( (integer)(s_aa_code_1 = 'BF129') * s_aa_dist_1 +
    (integer)(s_aa_code_2 = 'BF129') * s_aa_dist_2 +
    (integer)(s_aa_code_3 = 'BF129') * s_aa_dist_3 +
    (integer)(s_aa_code_4 = 'BF129') * s_aa_dist_4 +
    (integer)(s_aa_code_5 = 'BF129') * s_aa_dist_5 +
    (integer)(s_aa_code_6 = 'BF129') * s_aa_dist_6 +
    (integer)(s_aa_code_7 = 'BF129') * s_aa_dist_7 +
    (integer)(s_aa_code_8 = 'BF129') * s_aa_dist_8 +
    (integer)(s_aa_code_9 = 'BF129') * s_aa_dist_9 +
    (integer)(s_aa_code_10 = 'BF129') * s_aa_dist_10 +
    (integer)(s_aa_code_11 = 'BF129') * s_aa_dist_11 +
    (integer)(s_aa_code_12 = 'BF129') * s_aa_dist_12 +
    (integer)(s_aa_code_13 = 'BF129') * s_aa_dist_13 +
    (integer)(s_aa_code_14 = 'BF129') * s_aa_dist_14 +
    (integer)(s_aa_code_15 = 'BF129') * s_aa_dist_15 +
    (integer)(s_aa_code_16 = 'BF129') * s_aa_dist_16 +
    (integer)(s_aa_code_17 = 'BF129') * s_aa_dist_17 +
    (integer)(s_aa_code_18 = 'BF129') * s_aa_dist_18 +
    (integer)(s_aa_code_19 = 'BF129') * s_aa_dist_19 +
    (integer)(s_aa_code_20 = 'BF129') * s_aa_dist_20 +
    (integer)(s_aa_code_21 = 'BF129') * s_aa_dist_21 +
    (integer)(s_aa_code_22 = 'BF129') * s_aa_dist_22 +
    (integer)(s_aa_code_23 = 'BF129') * s_aa_dist_23 +
    (integer)(s_aa_code_24 = 'BF129') * s_aa_dist_24 +
    (integer)(s_aa_code_25 = 'BF129') * s_aa_dist_25 +
    (integer)(s_aa_code_26 = 'BF129') * s_aa_dist_26 +
    (integer)(s_aa_code_27 = 'BF129') * s_aa_dist_27 ) ;

s_rcvaluebf113 := __common__( (integer)(s_aa_code_1 = 'BF113') * s_aa_dist_1 +
    (integer)(s_aa_code_2 = 'BF113') * s_aa_dist_2 +
    (integer)(s_aa_code_3 = 'BF113') * s_aa_dist_3 +
    (integer)(s_aa_code_4 = 'BF113') * s_aa_dist_4 +
    (integer)(s_aa_code_5 = 'BF113') * s_aa_dist_5 +
    (integer)(s_aa_code_6 = 'BF113') * s_aa_dist_6 +
    (integer)(s_aa_code_7 = 'BF113') * s_aa_dist_7 +
    (integer)(s_aa_code_8 = 'BF113') * s_aa_dist_8 +
    (integer)(s_aa_code_9 = 'BF113') * s_aa_dist_9 +
    (integer)(s_aa_code_10 = 'BF113') * s_aa_dist_10 +
    (integer)(s_aa_code_11 = 'BF113') * s_aa_dist_11 +
    (integer)(s_aa_code_12 = 'BF113') * s_aa_dist_12 +
    (integer)(s_aa_code_13 = 'BF113') * s_aa_dist_13 +
    (integer)(s_aa_code_14 = 'BF113') * s_aa_dist_14 +
    (integer)(s_aa_code_15 = 'BF113') * s_aa_dist_15 +
    (integer)(s_aa_code_16 = 'BF113') * s_aa_dist_16 +
    (integer)(s_aa_code_17 = 'BF113') * s_aa_dist_17 +
    (integer)(s_aa_code_18 = 'BF113') * s_aa_dist_18 +
    (integer)(s_aa_code_19 = 'BF113') * s_aa_dist_19 +
    (integer)(s_aa_code_20 = 'BF113') * s_aa_dist_20 +
    (integer)(s_aa_code_21 = 'BF113') * s_aa_dist_21 +
    (integer)(s_aa_code_22 = 'BF113') * s_aa_dist_22 +
    (integer)(s_aa_code_23 = 'BF113') * s_aa_dist_23 +
    (integer)(s_aa_code_24 = 'BF113') * s_aa_dist_24 +
    (integer)(s_aa_code_25 = 'BF113') * s_aa_dist_25 +
    (integer)(s_aa_code_26 = 'BF113') * s_aa_dist_26 +
    (integer)(s_aa_code_27 = 'BF113') * s_aa_dist_27 ) ;

s_rcvaluebf110 := __common__( (integer)(s_aa_code_1 = 'BF110') * s_aa_dist_1 +
    (integer)(s_aa_code_2 = 'BF110') * s_aa_dist_2 +
    (integer)(s_aa_code_3 = 'BF110') * s_aa_dist_3 +
    (integer)(s_aa_code_4 = 'BF110') * s_aa_dist_4 +
    (integer)(s_aa_code_5 = 'BF110') * s_aa_dist_5 +
    (integer)(s_aa_code_6 = 'BF110') * s_aa_dist_6 +
    (integer)(s_aa_code_7 = 'BF110') * s_aa_dist_7 +
    (integer)(s_aa_code_8 = 'BF110') * s_aa_dist_8 +
    (integer)(s_aa_code_9 = 'BF110') * s_aa_dist_9 +
    (integer)(s_aa_code_10 = 'BF110') * s_aa_dist_10 +
    (integer)(s_aa_code_11 = 'BF110') * s_aa_dist_11 +
    (integer)(s_aa_code_12 = 'BF110') * s_aa_dist_12 +
    (integer)(s_aa_code_13 = 'BF110') * s_aa_dist_13 +
    (integer)(s_aa_code_14 = 'BF110') * s_aa_dist_14 +
    (integer)(s_aa_code_15 = 'BF110') * s_aa_dist_15 +
    (integer)(s_aa_code_16 = 'BF110') * s_aa_dist_16 +
    (integer)(s_aa_code_17 = 'BF110') * s_aa_dist_17 +
    (integer)(s_aa_code_18 = 'BF110') * s_aa_dist_18 +
    (integer)(s_aa_code_19 = 'BF110') * s_aa_dist_19 +
    (integer)(s_aa_code_20 = 'BF110') * s_aa_dist_20 +
    (integer)(s_aa_code_21 = 'BF110') * s_aa_dist_21 +
    (integer)(s_aa_code_22 = 'BF110') * s_aa_dist_22 +
    (integer)(s_aa_code_23 = 'BF110') * s_aa_dist_23 +
    (integer)(s_aa_code_24 = 'BF110') * s_aa_dist_24 +
    (integer)(s_aa_code_25 = 'BF110') * s_aa_dist_25 +
    (integer)(s_aa_code_26 = 'BF110') * s_aa_dist_26 +
    (integer)(s_aa_code_27 = 'BF110') * s_aa_dist_27 ) ;

s_rcvalueb055 := __common__( (integer)(s_aa_code_1 = 'B055') * s_aa_dist_1 +
    (integer)(s_aa_code_2 = 'B055') * s_aa_dist_2 +
    (integer)(s_aa_code_3 = 'B055') * s_aa_dist_3 +
    (integer)(s_aa_code_4 = 'B055') * s_aa_dist_4 +
    (integer)(s_aa_code_5 = 'B055') * s_aa_dist_5 +
    (integer)(s_aa_code_6 = 'B055') * s_aa_dist_6 +
    (integer)(s_aa_code_7 = 'B055') * s_aa_dist_7 +
    (integer)(s_aa_code_8 = 'B055') * s_aa_dist_8 +
    (integer)(s_aa_code_9 = 'B055') * s_aa_dist_9 +
    (integer)(s_aa_code_10 = 'B055') * s_aa_dist_10 +
    (integer)(s_aa_code_11 = 'B055') * s_aa_dist_11 +
    (integer)(s_aa_code_12 = 'B055') * s_aa_dist_12 +
    (integer)(s_aa_code_13 = 'B055') * s_aa_dist_13 +
    (integer)(s_aa_code_14 = 'B055') * s_aa_dist_14 +
    (integer)(s_aa_code_15 = 'B055') * s_aa_dist_15 +
    (integer)(s_aa_code_16 = 'B055') * s_aa_dist_16 +
    (integer)(s_aa_code_17 = 'B055') * s_aa_dist_17 +
    (integer)(s_aa_code_18 = 'B055') * s_aa_dist_18 +
    (integer)(s_aa_code_19 = 'B055') * s_aa_dist_19 +
    (integer)(s_aa_code_20 = 'B055') * s_aa_dist_20 +
    (integer)(s_aa_code_21 = 'B055') * s_aa_dist_21 +
    (integer)(s_aa_code_22 = 'B055') * s_aa_dist_22 +
    (integer)(s_aa_code_23 = 'B055') * s_aa_dist_23 +
    (integer)(s_aa_code_24 = 'B055') * s_aa_dist_24 +
    (integer)(s_aa_code_25 = 'B055') * s_aa_dist_25 +
    (integer)(s_aa_code_26 = 'B055') * s_aa_dist_26 +
    (integer)(s_aa_code_27 = 'B055') * s_aa_dist_27 ) ;

s_rcvalueb057 := __common__( (integer)(s_aa_code_1 = 'B057') * s_aa_dist_1 +
    (integer)(s_aa_code_2 = 'B057') * s_aa_dist_2 +
    (integer)(s_aa_code_3 = 'B057') * s_aa_dist_3 +
    (integer)(s_aa_code_4 = 'B057') * s_aa_dist_4 +
    (integer)(s_aa_code_5 = 'B057') * s_aa_dist_5 +
    (integer)(s_aa_code_6 = 'B057') * s_aa_dist_6 +
    (integer)(s_aa_code_7 = 'B057') * s_aa_dist_7 +
    (integer)(s_aa_code_8 = 'B057') * s_aa_dist_8 +
    (integer)(s_aa_code_9 = 'B057') * s_aa_dist_9 +
    (integer)(s_aa_code_10 = 'B057') * s_aa_dist_10 +
    (integer)(s_aa_code_11 = 'B057') * s_aa_dist_11 +
    (integer)(s_aa_code_12 = 'B057') * s_aa_dist_12 +
    (integer)(s_aa_code_13 = 'B057') * s_aa_dist_13 +
    (integer)(s_aa_code_14 = 'B057') * s_aa_dist_14 +
    (integer)(s_aa_code_15 = 'B057') * s_aa_dist_15 +
    (integer)(s_aa_code_16 = 'B057') * s_aa_dist_16 +
    (integer)(s_aa_code_17 = 'B057') * s_aa_dist_17 +
    (integer)(s_aa_code_18 = 'B057') * s_aa_dist_18 +
    (integer)(s_aa_code_19 = 'B057') * s_aa_dist_19 +
    (integer)(s_aa_code_20 = 'B057') * s_aa_dist_20 +
    (integer)(s_aa_code_21 = 'B057') * s_aa_dist_21 +
    (integer)(s_aa_code_22 = 'B057') * s_aa_dist_22 +
    (integer)(s_aa_code_23 = 'B057') * s_aa_dist_23 +
    (integer)(s_aa_code_24 = 'B057') * s_aa_dist_24 +
    (integer)(s_aa_code_25 = 'B057') * s_aa_dist_25 +
    (integer)(s_aa_code_26 = 'B057') * s_aa_dist_26 +
    (integer)(s_aa_code_27 = 'B057') * s_aa_dist_27 ) ;

s_rcvalueb059 := __common__( (integer)(s_aa_code_1 = 'B059') * s_aa_dist_1 +
    (integer)(s_aa_code_2 = 'B059') * s_aa_dist_2 +
    (integer)(s_aa_code_3 = 'B059') * s_aa_dist_3 +
    (integer)(s_aa_code_4 = 'B059') * s_aa_dist_4 +
    (integer)(s_aa_code_5 = 'B059') * s_aa_dist_5 +
    (integer)(s_aa_code_6 = 'B059') * s_aa_dist_6 +
    (integer)(s_aa_code_7 = 'B059') * s_aa_dist_7 +
    (integer)(s_aa_code_8 = 'B059') * s_aa_dist_8 +
    (integer)(s_aa_code_9 = 'B059') * s_aa_dist_9 +
    (integer)(s_aa_code_10 = 'B059') * s_aa_dist_10 +
    (integer)(s_aa_code_11 = 'B059') * s_aa_dist_11 +
    (integer)(s_aa_code_12 = 'B059') * s_aa_dist_12 +
    (integer)(s_aa_code_13 = 'B059') * s_aa_dist_13 +
    (integer)(s_aa_code_14 = 'B059') * s_aa_dist_14 +
    (integer)(s_aa_code_15 = 'B059') * s_aa_dist_15 +
    (integer)(s_aa_code_16 = 'B059') * s_aa_dist_16 +
    (integer)(s_aa_code_17 = 'B059') * s_aa_dist_17 +
    (integer)(s_aa_code_18 = 'B059') * s_aa_dist_18 +
    (integer)(s_aa_code_19 = 'B059') * s_aa_dist_19 +
    (integer)(s_aa_code_20 = 'B059') * s_aa_dist_20 +
    (integer)(s_aa_code_21 = 'B059') * s_aa_dist_21 +
    (integer)(s_aa_code_22 = 'B059') * s_aa_dist_22 +
    (integer)(s_aa_code_23 = 'B059') * s_aa_dist_23 +
    (integer)(s_aa_code_24 = 'B059') * s_aa_dist_24 +
    (integer)(s_aa_code_25 = 'B059') * s_aa_dist_25 +
    (integer)(s_aa_code_26 = 'B059') * s_aa_dist_26 +
    (integer)(s_aa_code_27 = 'B059') * s_aa_dist_27 ) ;

s_final_score := __common__( -2.48990114633285 +
    s_bv_assoc_derog_pct_w * 0.539564237259633 +
    s_bv_sos_index_w * 0.758370807287444 +
    s_bv_lien_filed_recency_w * 0.249985293520185 +
    s_bv_judg_filed_recency_w * 0.259607827036718 +
    s_bv_inq_highrisk_recency_w * 0.392468815306143 +
    s_td_mth_sbfe_datefirstseen_w * 0.546942248756054 +
    s_td_mth_acct_firstopen_w * 1.09359766647017 +
    s_td_mth_dlq_lastseen_w * 0.122765231509011 +
    s_td_pd_pct_of_limit_lse_w * 0.28320855424132 +
    s_td_acct_dpd_1p_recency_w * 0.396313719534803 +
    s_td_acct_dpd_31p_recency_w * 0.164760000272815 +
    s_td_sbfe_closed_pct_invol_w * 0.368297248095492 +
    s_td_sbfe_util_pct_oel_w * 0.452642515333033 +
    s_td_sbfe_util_pct75_cnt_cc_w * 0.146437233537952 +
    s_td_sbfe_avg_util_pct06_w * 0.430962807877172 +
    s_td_sbfe_avg_util_pct_cc_w * 0.238386977051077 +
    s_bv_mth_ver_src_q3_fs_w * 0.701474260001985 +
    s_bv_ver_src_derog_ratio_w * 0.21480082074523 +
    s_bv_bus_only_source_profile_w * 0.753142786747758 +
    s_td_occ_dpd_31p_cnt24_w * 0.1177579146639 +
    s_td_sbfe_satis_cnt_loan_w * 0.548267406483056 +
    s_td_sbfe_util_pct_cc_w * 0.20701269646453 +
    s_td_mth_sbfe_datelastseen_w * 0.397577282743672 +
    s_td_past_due_pct_of_balance_w * 0.0455680325297597 +
    s_td_acct_pct_closed_w * 0.229562223080657 +
    s_td_acct_dpd_61p_cnt12_w * 0.103469714110827 +
    s_td_sbfe_worst_perf84_w * 0.374780833629907 ) ;

l_bv_assoc_felony_ct_w := __common__( map(
    bv_assoc_felony_ct = NULL => 0.00000,
    bv_assoc_felony_ct = -1   => -0.02183,
    bv_assoc_felony_ct <= 0.5 => -0.00337,
                                 1.28402) ) ;

l_aa_dist_1 := __common__( (0.00000 - l_bv_assoc_felony_ct_w) * 0.48146 ) ;

l_aa_code_1 := __common__( map(
    l_bv_assoc_felony_ct_w = -0.02183 => '',
    bv_assoc_felony_ct = NULL         => 'B031',
    bv_assoc_felony_ct = -1           => 'B017',
    bv_assoc_felony_ct <= 0.5         => 'B026',
                                         'B026') ) ;

l_bv_assoc_lien_tot_w := __common__( map(
    bv_assoc_lien_tot = NULL => 0.00000,
    bv_assoc_lien_tot = -1   => -0.02183,
    bv_assoc_lien_tot <= 0.5 => -0.06761,
    bv_assoc_lien_tot <= 1.5 => 0.82571,
                                1.09102) ) ;

l_aa_dist_2 := __common__( (0.00000 - l_bv_assoc_lien_tot_w) * 0.20694 ) ;

l_aa_code_2 := __common__( map(
    l_bv_assoc_lien_tot_w = -0.06761 => '',
    bv_assoc_lien_tot = NULL         => 'B031',
    bv_assoc_lien_tot = -1           => 'B017',
    bv_assoc_lien_tot <= 0.5         => 'B026',
    bv_assoc_lien_tot <= 1.5         => 'B026',
                                        'B026') ) ;

l_bv_assoc_judg_tot_w := __common__( map(
    bv_assoc_judg_tot = NULL => 0.00000,
    bv_assoc_judg_tot = -1   => -0.02183,
    bv_assoc_judg_tot <= 0.5 => -0.10435,
    bv_assoc_judg_tot <= 1.5 => 0.96380,
    bv_assoc_judg_tot <= 2.5 => 1.28702,
                                1.48073) ) ;

l_aa_dist_3 := __common__( (0.00000 - l_bv_assoc_judg_tot_w) * 0.41575 ) ;

l_aa_code_3 := __common__( map(
    l_bv_assoc_judg_tot_w = -0.10435 => '',
    bv_assoc_judg_tot = NULL         => 'B031',
    bv_assoc_judg_tot = -1           => 'B017',
    bv_assoc_judg_tot <= 0.5         => 'B026',
    bv_assoc_judg_tot <= 1.5         => 'B026',
    bv_assoc_judg_tot <= 2.5         => 'B026',
                                        'B026') ) ;

l_bv_assoc_derog_pct_w := __common__( map(
    bv_assoc_derog_pct = NULL           => 0.00000,
    bv_assoc_derog_pct = -1             => -0.02183,
    bv_assoc_derog_pct <= 0.13392857145 => -0.25770,
    bv_assoc_derog_pct <= 0.2792207792  => 0.43053,
    bv_assoc_derog_pct <= 0.3875        => 0.60956,
    bv_assoc_derog_pct <= 0.5357142857  => 0.67841,
                                           1.02203) ) ;

l_aa_dist_4 := __common__( (0.00000 - l_bv_assoc_derog_pct_w) * 0.60949 ) ;

l_aa_code_4 := __common__( map(
    l_bv_assoc_derog_pct_w = -0.25770   => '',
    bv_assoc_derog_pct = NULL           => 'B031',
    bv_assoc_derog_pct = -1             => 'B017',
    bv_assoc_derog_pct <= 0.13392857145 => 'B026',
    bv_assoc_derog_pct <= 0.2792207792  => 'B026',
    bv_assoc_derog_pct <= 0.3875        => 'B026',
    bv_assoc_derog_pct <= 0.5357142857  => 'B026',
                                           'B026') ) ;

l_bv_sos_mth_fs_w := __common__( map(
    bv_sos_mth_fs = NULL => 0.00000,
    bv_sos_mth_fs = -1   => 0.01929,
    bv_sos_mth_fs <= 25  => 0.11196,
    bv_sos_mth_fs <= 50  => -0.02927,
    bv_sos_mth_fs <= 125 => -0.18953,
                            -0.79352) ) ;

l_aa_dist_5 := __common__( (0.00000 - l_bv_sos_mth_fs_w) * 0.43059 ) ;

l_aa_code_5 := __common__( map(
    l_bv_sos_mth_fs_w = -0.79352 => '',
    bv_sos_mth_fs = NULL         => 'B031',
    bv_sos_mth_fs = -1           => 'B055',
    bv_sos_mth_fs <= 25          => 'B057',
    bv_sos_mth_fs <= 50          => 'B057',
    bv_sos_mth_fs <= 125         => 'B057',
                                    'B057') ) ;

l_bv_lien_judg_index_w := __common__( map(
    bv_lien_judg_index = NULL => 0.00000,
    bv_lien_judg_index <= 1.5 => -0.02011,
                                 1.24429) ) ;

l_aa_dist_6 := __common__( (0.00000 - l_bv_lien_judg_index_w) * 0.39611 ) ;

l_aa_code_6 := __common__( map(
    l_bv_lien_judg_index_w = -0.02011 => '',
    bv_lien_judg_index = NULL         => 'B031',
    bv_lien_judg_index <= 1.5         => 'B063',
                                         'B063') ) ;

l_bv_prop_assessed_value_w := __common__( map(
    bv_prop_assessed_value = NULL    => 0.00000,
    bv_prop_assessed_value = -1      => 0.09588,
    bv_prop_assessed_value <= 0      => -0.21773,
    bv_prop_assessed_value <= 78864  => -0.35792,
    bv_prop_assessed_value <= 236560 => -0.88974,
                                        -1.19499) ) ;

l_aa_dist_7 := __common__( (0.00000 - l_bv_prop_assessed_value_w) * 0.47193 ) ;

l_aa_code_7 := __common__( map(
    l_bv_prop_assessed_value_w = -1.19499 => '',
    bv_prop_assessed_value = NULL         => 'B031',
    bv_prop_assessed_value = -1           => 'B052',
    bv_prop_assessed_value <= 0           => 'B053',
    bv_prop_assessed_value <= 78864       => 'B053',
    bv_prop_assessed_value <= 236560      => 'B053',
                                             'B053') ) ;

l_bv_inq_highrisk_count_w := __common__( map(
    bv_inq_highrisk_count = NULL => 0.00000,
    bv_inq_highrisk_count <= 0.5 => -0.01773,
    bv_inq_highrisk_count <= 1.5 => 0.79491,
                                    1.03469) ) ;

l_aa_dist_8 := __common__( (0.00000 - l_bv_inq_highrisk_count_w) * 0.48735 ) ;

l_aa_code_8 := __common__( map(
    l_bv_inq_highrisk_count_w = -0.01773 => '',
    bv_inq_highrisk_count = NULL         => 'B031',
    bv_inq_highrisk_count <= 0.5         => 'B040',
    bv_inq_highrisk_count <= 1.5         => 'B040',
                                            'B040') ) ;

l_bv_mth_ver_src_c_fs_w := __common__( map(
    bv_mth_ver_src_c_fs = NULL   => 0.00000,
    bv_mth_ver_src_c_fs = -1     => 0.03239,
    bv_mth_ver_src_c_fs <= 35.5  => 0.08030,
    bv_mth_ver_src_c_fs <= 76.5  => -0.23395,
    bv_mth_ver_src_c_fs <= 132.5 => -0.48602,
                                    -0.82094) ) ;

l_aa_dist_9 := __common__( (0.00000 - l_bv_mth_ver_src_c_fs_w) * 0.54544 ) ;

l_aa_code_9 := __common__( map(
    l_bv_mth_ver_src_c_fs_w = -0.82094 => '',
    bv_mth_ver_src_c_fs = NULL         => 'B031',
    bv_mth_ver_src_c_fs = -1           => 'B055',
    bv_mth_ver_src_c_fs <= 35.5        => 'B057',
    bv_mth_ver_src_c_fs <= 76.5        => 'B057',
    bv_mth_ver_src_c_fs <= 132.5       => 'B057',
                                          'B057') ) ;

l_bv_mth_ver_src_p_ls_w := __common__( map(
    bv_mth_ver_src_p_ls = NULL   => 0.00000,
    bv_mth_ver_src_p_ls = -1     => 0.10650,
    bv_mth_ver_src_p_ls <= 1.5   => -1.02645,
    bv_mth_ver_src_p_ls <= 11.5  => -0.88537,
    bv_mth_ver_src_p_ls <= 23.5  => -0.77560,
    bv_mth_ver_src_p_ls <= 138.5 => -0.47651,
                                    -0.42151) ) ;

l_aa_dist_10 := __common__( (0.00000 - l_bv_mth_ver_src_p_ls_w) * 0.38799 ) ;

l_aa_code_10 := __common__( map(
    l_bv_mth_ver_src_p_ls_w = -1.02645 => '',
    bv_mth_ver_src_p_ls = NULL         => 'B038',
    bv_mth_ver_src_p_ls = -1           => 'B052',
    bv_mth_ver_src_p_ls <= 1.5         => 'B038',
    bv_mth_ver_src_p_ls <= 11.5        => 'B038',
    bv_mth_ver_src_p_ls <= 23.5        => 'B038',
    bv_mth_ver_src_p_ls <= 138.5       => 'B038',
                                          'B038') ) ;

l_bv_mth_ver_src_q3_fs_w := __common__( map(
    bv_mth_ver_src_q3_fs = NULL  => 0.00000,
    bv_mth_ver_src_q3_fs = -1    => -0.14747,
    bv_mth_ver_src_q3_fs <= 8.5  => 0.49839,
    bv_mth_ver_src_q3_fs <= 12.5 => 0.43465,
    bv_mth_ver_src_q3_fs <= 31.5 => 0.28559,
                                    -0.03866) ) ;

l_aa_dist_11 := __common__( (0.00000 - l_bv_mth_ver_src_q3_fs_w) * 0.60076 ) ;

l_aa_code_11 := __common__( map(
    l_bv_mth_ver_src_q3_fs_w = -0.14747 => '',
    bv_mth_ver_src_q3_fs = NULL         => 'B031',
    bv_mth_ver_src_q3_fs = -1           => 'B034',
    bv_mth_ver_src_q3_fs <= 8.5         => 'B037',
    bv_mth_ver_src_q3_fs <= 12.5        => 'B037',
    bv_mth_ver_src_q3_fs <= 31.5        => 'B037',
                                           'B037') ) ;

l_bv_ver_src_derog_ratio_w := __common__( map(
    bv_ver_src_derog_ratio = NULL  => 0.00000,
    bv_ver_src_derog_ratio = -1    => 0.00000,
    bv_ver_src_derog_ratio <= 0.25 => 0.11075,
    bv_ver_src_derog_ratio <= 0.35 => 0.71648,
    bv_ver_src_derog_ratio <= 51   => 0.95132,
                                      -0.14317) ) ;

l_aa_dist_12 := __common__( (0.00000 - l_bv_ver_src_derog_ratio_w) * 0.65200 ) ;

l_aa_code_12 := __common__( map(
    l_bv_ver_src_derog_ratio_w = -0.14317 => '',
    bv_ver_src_derog_ratio = NULL         => 'B031',
    bv_ver_src_derog_ratio = -1           => 'B034',
    source_ba or source_l2        				=> 'B063',
                                             'B034') ) ;

l_bv_bus_only_source_profile_w := __common__( map(
    bv_bus_only_source_profile = NULL           => 0.00000,
    bv_bus_only_source_profile <= -2.6139815605 => -0.53536,
    bv_bus_only_source_profile <= -2.56388976   => -0.38559,
    bv_bus_only_source_profile <= -2.4522426715 => -0.33533,
    bv_bus_only_source_profile <= -1.894348904  => -0.02301,
    bv_bus_only_source_profile <= -1.651189507  => 0.47068,
    bv_bus_only_source_profile <= -1.4190633985 => 0.62232,
    bv_bus_only_source_profile <= -1.213989893  => 0.89257,
                                                   1.21166) ) ;

l_aa_dist_13 := __common__( (0.00000 - l_bv_bus_only_source_profile_w) * 0.82690 ) ;

l_aa_code_13 := __common__( map(
    l_bv_bus_only_source_profile_w = -0.53536   => '',
    bv_bus_only_source_profile = NULL           => 'B031',
    bv_bus_only_source_profile <= -2.6139815605 => 'B034',
    bv_bus_only_source_profile <= -2.56388976   => 'B034',
    bv_bus_only_source_profile <= -2.4522426715 => 'B034',
    bv_bus_only_source_profile <= -1.894348904  => 'B034',
    bv_bus_only_source_profile <= -1.651189507  => 'B034',
    bv_bus_only_source_profile <= -1.4190633985 => 'B034',
    bv_bus_only_source_profile <= -1.213989893  => 'B034',
                                                   'B034') ) ;

l_bv_mths_inq_lastseen_w := __common__( map(
    bv_mths_inq_lastseen = NULL  => 0.00000,
    bv_mths_inq_lastseen = -1    => -0.09073,
    bv_mths_inq_lastseen <= 17.5 => 0.55175,
                                    0.30319) ) ;

l_aa_dist_14 := __common__( (0.00000 - l_bv_mths_inq_lastseen_w) * 0.63326 ) ;

l_aa_code_14 := __common__( map(
    l_bv_mths_inq_lastseen_w = -0.09073 => '',
    bv_mths_inq_lastseen = NULL         => 'B031',
    bv_mths_inq_lastseen = -1           => 'B040',
    bv_mths_inq_lastseen <= 17.5        => 'B040',
                                           'B040') ) ;

l_aa_code_15 := __common__( 'BF108' ) ;

l_aa_dist_15 := __common__( -999 ) ;

l_rcvalueb037 := __common__( (integer)(l_aa_code_1 = 'B037') * l_aa_dist_1 +
    (integer)(l_aa_code_2 = 'B037') * l_aa_dist_2 +
    (integer)(l_aa_code_3 = 'B037') * l_aa_dist_3 +
    (integer)(l_aa_code_4 = 'B037') * l_aa_dist_4 +
    (integer)(l_aa_code_5 = 'B037') * l_aa_dist_5 +
    (integer)(l_aa_code_6 = 'B037') * l_aa_dist_6 +
    (integer)(l_aa_code_7 = 'B037') * l_aa_dist_7 +
    (integer)(l_aa_code_8 = 'B037') * l_aa_dist_8 +
    (integer)(l_aa_code_9 = 'B037') * l_aa_dist_9 +
    (integer)(l_aa_code_10 = 'B037') * l_aa_dist_10 +
    (integer)(l_aa_code_11 = 'B037') * l_aa_dist_11 +
    (integer)(l_aa_code_12 = 'B037') * l_aa_dist_12 +
    (integer)(l_aa_code_13 = 'B037') * l_aa_dist_13 +
    (integer)(l_aa_code_14 = 'B037') * l_aa_dist_14 +
    (integer)(l_aa_code_15 = 'B037') * l_aa_dist_15 ) ;

l_rcvalueb026 := __common__( (integer)(l_aa_code_1 = 'B026') * l_aa_dist_1 +
    (integer)(l_aa_code_2 = 'B026') * l_aa_dist_2 +
    (integer)(l_aa_code_3 = 'B026') * l_aa_dist_3 +
    (integer)(l_aa_code_4 = 'B026') * l_aa_dist_4 +
    (integer)(l_aa_code_5 = 'B026') * l_aa_dist_5 +
    (integer)(l_aa_code_6 = 'B026') * l_aa_dist_6 +
    (integer)(l_aa_code_7 = 'B026') * l_aa_dist_7 +
    (integer)(l_aa_code_8 = 'B026') * l_aa_dist_8 +
    (integer)(l_aa_code_9 = 'B026') * l_aa_dist_9 +
    (integer)(l_aa_code_10 = 'B026') * l_aa_dist_10 +
    (integer)(l_aa_code_11 = 'B026') * l_aa_dist_11 +
    (integer)(l_aa_code_12 = 'B026') * l_aa_dist_12 +
    (integer)(l_aa_code_13 = 'B026') * l_aa_dist_13 +
    (integer)(l_aa_code_14 = 'B026') * l_aa_dist_14 +
    (integer)(l_aa_code_15 = 'B026') * l_aa_dist_15 ) ;

l_rcvalueb034 := __common__( (integer)(l_aa_code_1 = 'B034') * l_aa_dist_1 +
    (integer)(l_aa_code_2 = 'B034') * l_aa_dist_2 +
    (integer)(l_aa_code_3 = 'B034') * l_aa_dist_3 +
    (integer)(l_aa_code_4 = 'B034') * l_aa_dist_4 +
    (integer)(l_aa_code_5 = 'B034') * l_aa_dist_5 +
    (integer)(l_aa_code_6 = 'B034') * l_aa_dist_6 +
    (integer)(l_aa_code_7 = 'B034') * l_aa_dist_7 +
    (integer)(l_aa_code_8 = 'B034') * l_aa_dist_8 +
    (integer)(l_aa_code_9 = 'B034') * l_aa_dist_9 +
    (integer)(l_aa_code_10 = 'B034') * l_aa_dist_10 +
    (integer)(l_aa_code_11 = 'B034') * l_aa_dist_11 +
    (integer)(l_aa_code_12 = 'B034') * l_aa_dist_12 +
    (integer)(l_aa_code_13 = 'B034') * l_aa_dist_13 +
    (integer)(l_aa_code_14 = 'B034') * l_aa_dist_14 +
    (integer)(l_aa_code_15 = 'B034') * l_aa_dist_15 ) ;

l_rcvalueb040 := __common__( (integer)(l_aa_code_1 = 'B040') * l_aa_dist_1 +
    (integer)(l_aa_code_2 = 'B040') * l_aa_dist_2 +
    (integer)(l_aa_code_3 = 'B040') * l_aa_dist_3 +
    (integer)(l_aa_code_4 = 'B040') * l_aa_dist_4 +
    (integer)(l_aa_code_5 = 'B040') * l_aa_dist_5 +
    (integer)(l_aa_code_6 = 'B040') * l_aa_dist_6 +
    (integer)(l_aa_code_7 = 'B040') * l_aa_dist_7 +
    (integer)(l_aa_code_8 = 'B040') * l_aa_dist_8 +
    (integer)(l_aa_code_9 = 'B040') * l_aa_dist_9 +
    (integer)(l_aa_code_10 = 'B040') * l_aa_dist_10 +
    (integer)(l_aa_code_11 = 'B040') * l_aa_dist_11 +
    (integer)(l_aa_code_12 = 'B040') * l_aa_dist_12 +
    (integer)(l_aa_code_13 = 'B040') * l_aa_dist_13 +
    (integer)(l_aa_code_14 = 'B040') * l_aa_dist_14 +
    (integer)(l_aa_code_15 = 'B040') * l_aa_dist_15 ) ;

l_rcvalueb031 := __common__( (integer)(l_aa_code_1 = 'B031') * l_aa_dist_1 +
    (integer)(l_aa_code_2 = 'B031') * l_aa_dist_2 +
    (integer)(l_aa_code_3 = 'B031') * l_aa_dist_3 +
    (integer)(l_aa_code_4 = 'B031') * l_aa_dist_4 +
    (integer)(l_aa_code_5 = 'B031') * l_aa_dist_5 +
    (integer)(l_aa_code_6 = 'B031') * l_aa_dist_6 +
    (integer)(l_aa_code_7 = 'B031') * l_aa_dist_7 +
    (integer)(l_aa_code_8 = 'B031') * l_aa_dist_8 +
    (integer)(l_aa_code_9 = 'B031') * l_aa_dist_9 +
    (integer)(l_aa_code_10 = 'B031') * l_aa_dist_10 +
    (integer)(l_aa_code_11 = 'B031') * l_aa_dist_11 +
    (integer)(l_aa_code_12 = 'B031') * l_aa_dist_12 +
    (integer)(l_aa_code_13 = 'B031') * l_aa_dist_13 +
    (integer)(l_aa_code_14 = 'B031') * l_aa_dist_14 +
    (integer)(l_aa_code_15 = 'B031') * l_aa_dist_15 ) ;

l_rcvalueb017 := __common__( (integer)(l_aa_code_1 = 'B017') * l_aa_dist_1 +
    (integer)(l_aa_code_2 = 'B017') * l_aa_dist_2 +
    (integer)(l_aa_code_3 = 'B017') * l_aa_dist_3 +
    (integer)(l_aa_code_4 = 'B017') * l_aa_dist_4 +
    (integer)(l_aa_code_5 = 'B017') * l_aa_dist_5 +
    (integer)(l_aa_code_6 = 'B017') * l_aa_dist_6 +
    (integer)(l_aa_code_7 = 'B017') * l_aa_dist_7 +
    (integer)(l_aa_code_8 = 'B017') * l_aa_dist_8 +
    (integer)(l_aa_code_9 = 'B017') * l_aa_dist_9 +
    (integer)(l_aa_code_10 = 'B017') * l_aa_dist_10 +
    (integer)(l_aa_code_11 = 'B017') * l_aa_dist_11 +
    (integer)(l_aa_code_12 = 'B017') * l_aa_dist_12 +
    (integer)(l_aa_code_13 = 'B017') * l_aa_dist_13 +
    (integer)(l_aa_code_14 = 'B017') * l_aa_dist_14 +
    (integer)(l_aa_code_15 = 'B017') * l_aa_dist_15 ) ;

l_rcvalueb063 := __common__( (integer)(l_aa_code_1 = 'B063') * l_aa_dist_1 +
    (integer)(l_aa_code_2 = 'B063') * l_aa_dist_2 +
    (integer)(l_aa_code_3 = 'B063') * l_aa_dist_3 +
    (integer)(l_aa_code_4 = 'B063') * l_aa_dist_4 +
    (integer)(l_aa_code_5 = 'B063') * l_aa_dist_5 +
    (integer)(l_aa_code_6 = 'B063') * l_aa_dist_6 +
    (integer)(l_aa_code_7 = 'B063') * l_aa_dist_7 +
    (integer)(l_aa_code_8 = 'B063') * l_aa_dist_8 +
    (integer)(l_aa_code_9 = 'B063') * l_aa_dist_9 +
    (integer)(l_aa_code_10 = 'B063') * l_aa_dist_10 +
    (integer)(l_aa_code_11 = 'B063') * l_aa_dist_11 +
    (integer)(l_aa_code_12 = 'B063') * l_aa_dist_12 +
    (integer)(l_aa_code_13 = 'B063') * l_aa_dist_13 +
    (integer)(l_aa_code_14 = 'B063') * l_aa_dist_14 +
    (integer)(l_aa_code_15 = 'B063') * l_aa_dist_15 ) ;

l_rcvalueb038 := __common__( (integer)(l_aa_code_1 = 'B038') * l_aa_dist_1 +
    (integer)(l_aa_code_2 = 'B038') * l_aa_dist_2 +
    (integer)(l_aa_code_3 = 'B038') * l_aa_dist_3 +
    (integer)(l_aa_code_4 = 'B038') * l_aa_dist_4 +
    (integer)(l_aa_code_5 = 'B038') * l_aa_dist_5 +
    (integer)(l_aa_code_6 = 'B038') * l_aa_dist_6 +
    (integer)(l_aa_code_7 = 'B038') * l_aa_dist_7 +
    (integer)(l_aa_code_8 = 'B038') * l_aa_dist_8 +
    (integer)(l_aa_code_9 = 'B038') * l_aa_dist_9 +
    (integer)(l_aa_code_10 = 'B038') * l_aa_dist_10 +
    (integer)(l_aa_code_11 = 'B038') * l_aa_dist_11 +
    (integer)(l_aa_code_12 = 'B038') * l_aa_dist_12 +
    (integer)(l_aa_code_13 = 'B038') * l_aa_dist_13 +
    (integer)(l_aa_code_14 = 'B038') * l_aa_dist_14 +
    (integer)(l_aa_code_15 = 'B038') * l_aa_dist_15 ) ;

l_rcvalueb053 := __common__( (integer)(l_aa_code_1 = 'B053') * l_aa_dist_1 +
    (integer)(l_aa_code_2 = 'B053') * l_aa_dist_2 +
    (integer)(l_aa_code_3 = 'B053') * l_aa_dist_3 +
    (integer)(l_aa_code_4 = 'B053') * l_aa_dist_4 +
    (integer)(l_aa_code_5 = 'B053') * l_aa_dist_5 +
    (integer)(l_aa_code_6 = 'B053') * l_aa_dist_6 +
    (integer)(l_aa_code_7 = 'B053') * l_aa_dist_7 +
    (integer)(l_aa_code_8 = 'B053') * l_aa_dist_8 +
    (integer)(l_aa_code_9 = 'B053') * l_aa_dist_9 +
    (integer)(l_aa_code_10 = 'B053') * l_aa_dist_10 +
    (integer)(l_aa_code_11 = 'B053') * l_aa_dist_11 +
    (integer)(l_aa_code_12 = 'B053') * l_aa_dist_12 +
    (integer)(l_aa_code_13 = 'B053') * l_aa_dist_13 +
    (integer)(l_aa_code_14 = 'B053') * l_aa_dist_14 +
    (integer)(l_aa_code_15 = 'B053') * l_aa_dist_15 ) ;

l_rcvalueb052 := __common__( (integer)(l_aa_code_1 = 'B052') * l_aa_dist_1 +
    (integer)(l_aa_code_2 = 'B052') * l_aa_dist_2 +
    (integer)(l_aa_code_3 = 'B052') * l_aa_dist_3 +
    (integer)(l_aa_code_4 = 'B052') * l_aa_dist_4 +
    (integer)(l_aa_code_5 = 'B052') * l_aa_dist_5 +
    (integer)(l_aa_code_6 = 'B052') * l_aa_dist_6 +
    (integer)(l_aa_code_7 = 'B052') * l_aa_dist_7 +
    (integer)(l_aa_code_8 = 'B052') * l_aa_dist_8 +
    (integer)(l_aa_code_9 = 'B052') * l_aa_dist_9 +
    (integer)(l_aa_code_10 = 'B052') * l_aa_dist_10 +
    (integer)(l_aa_code_11 = 'B052') * l_aa_dist_11 +
    (integer)(l_aa_code_12 = 'B052') * l_aa_dist_12 +
    (integer)(l_aa_code_13 = 'B052') * l_aa_dist_13 +
    (integer)(l_aa_code_14 = 'B052') * l_aa_dist_14 +
    (integer)(l_aa_code_15 = 'B052') * l_aa_dist_15 ) ;

l_rcvalueb055 := __common__( (integer)(l_aa_code_1 = 'B055') * l_aa_dist_1 +
    (integer)(l_aa_code_2 = 'B055') * l_aa_dist_2 +
    (integer)(l_aa_code_3 = 'B055') * l_aa_dist_3 +
    (integer)(l_aa_code_4 = 'B055') * l_aa_dist_4 +
    (integer)(l_aa_code_5 = 'B055') * l_aa_dist_5 +
    (integer)(l_aa_code_6 = 'B055') * l_aa_dist_6 +
    (integer)(l_aa_code_7 = 'B055') * l_aa_dist_7 +
    (integer)(l_aa_code_8 = 'B055') * l_aa_dist_8 +
    (integer)(l_aa_code_9 = 'B055') * l_aa_dist_9 +
    (integer)(l_aa_code_10 = 'B055') * l_aa_dist_10 +
    (integer)(l_aa_code_11 = 'B055') * l_aa_dist_11 +
    (integer)(l_aa_code_12 = 'B055') * l_aa_dist_12 +
    (integer)(l_aa_code_13 = 'B055') * l_aa_dist_13 +
    (integer)(l_aa_code_14 = 'B055') * l_aa_dist_14 +
    (integer)(l_aa_code_15 = 'B055') * l_aa_dist_15 ) ;

l_rcvalueb057 := __common__( (integer)(l_aa_code_1 = 'B057') * l_aa_dist_1 +
    (integer)(l_aa_code_2 = 'B057') * l_aa_dist_2 +
    (integer)(l_aa_code_3 = 'B057') * l_aa_dist_3 +
    (integer)(l_aa_code_4 = 'B057') * l_aa_dist_4 +
    (integer)(l_aa_code_5 = 'B057') * l_aa_dist_5 +
    (integer)(l_aa_code_6 = 'B057') * l_aa_dist_6 +
    (integer)(l_aa_code_7 = 'B057') * l_aa_dist_7 +
    (integer)(l_aa_code_8 = 'B057') * l_aa_dist_8 +
    (integer)(l_aa_code_9 = 'B057') * l_aa_dist_9 +
    (integer)(l_aa_code_10 = 'B057') * l_aa_dist_10 +
    (integer)(l_aa_code_11 = 'B057') * l_aa_dist_11 +
    (integer)(l_aa_code_12 = 'B057') * l_aa_dist_12 +
    (integer)(l_aa_code_13 = 'B057') * l_aa_dist_13 +
    (integer)(l_aa_code_14 = 'B057') * l_aa_dist_14 +
    (integer)(l_aa_code_15 = 'B057') * l_aa_dist_15 ) ;

l_rcvaluebf108 := __common__( (integer)(l_aa_code_1 = 'BF108') * l_aa_dist_1 +
    (integer)(l_aa_code_2 = 'BF108') * l_aa_dist_2 +
    (integer)(l_aa_code_3 = 'BF108') * l_aa_dist_3 +
    (integer)(l_aa_code_4 = 'BF108') * l_aa_dist_4 +
    (integer)(l_aa_code_5 = 'BF108') * l_aa_dist_5 +
    (integer)(l_aa_code_6 = 'BF108') * l_aa_dist_6 +
    (integer)(l_aa_code_7 = 'BF108') * l_aa_dist_7 +
    (integer)(l_aa_code_8 = 'BF108') * l_aa_dist_8 +
    (integer)(l_aa_code_9 = 'BF108') * l_aa_dist_9 +
    (integer)(l_aa_code_10 = 'BF108') * l_aa_dist_10 +
    (integer)(l_aa_code_11 = 'BF108') * l_aa_dist_11 +
    (integer)(l_aa_code_12 = 'BF108') * l_aa_dist_12 +
    (integer)(l_aa_code_13 = 'BF108') * l_aa_dist_13 +
    (integer)(l_aa_code_14 = 'BF108') * l_aa_dist_14 +
    (integer)(l_aa_code_15 = 'BF108') * l_aa_dist_15 ) ;

l_final_score := __common__( -2.09257543343286 +
    l_bv_assoc_felony_ct_w * 0.481459313085698 +
    l_bv_assoc_lien_tot_w * 0.206942146569191 +
    l_bv_assoc_judg_tot_w * 0.415748677475895 +
    l_bv_assoc_derog_pct_w * 0.609487247516107 +
    l_bv_sos_mth_fs_w * 0.430593732407108 +
    l_bv_lien_judg_index_w * 0.39610909161421 +
    l_bv_prop_assessed_value_w * 0.471934198872879 +
    l_bv_inq_highrisk_count_w * 0.487352369914397 +
    l_bv_mth_ver_src_c_fs_w * 0.545440842362057 +
    l_bv_mth_ver_src_p_ls_w * 0.387992170449689 +
    l_bv_mth_ver_src_q3_fs_w * 0.600760515451944 +
    l_bv_ver_src_derog_ratio_w * 0.652000269035884 +
    l_bv_bus_only_source_profile_w * 0.826901638448579 +
    l_bv_mths_inq_lastseen_w * 0.633257769541027 ) ;

base := __common__( 700 ) ;

pts := __common__( -40 ) ;

lgt := __common__( ln(0.10) ) ;

bus_mod_final_lgt := __common__( map(
    seg_business_score = 'LN & SBFE' => s_final_score,
    seg_business_score = 'LN ONLY'   => l_final_score,
                                        -1) ) ;

_sbom1601_0_0 := __common__( round(base + pts * (bus_mod_final_lgt - lgt) / ln(2)) ) ;

//*************************************************************************************//
// I have no idea how the reason code logic gets implemented in ECL, so everything below 
// probably needs to get changed or replaced.  The methodology for creating the reason codes is
// very similar to the logic used by the RiskView 4.0 scores, so you might want to consult
// that model code for guidance on implementing reason codes. 
//*************************************************************************************//

ds_layout := {STRING rc, REAL value}  ;


 
//*************************************************************************************//

l_code_set := [l_aa_code_1,
							 l_aa_code_2,
							 l_aa_code_3,
							 l_aa_code_4,
							 l_aa_code_5,
							 l_aa_code_6,
							 l_aa_code_7,
							 l_aa_code_8,
							 l_aa_code_9,
							 l_aa_code_10,
							 l_aa_code_11,
							 l_aa_code_12,
							 l_aa_code_13,
							 l_aa_code_14,
							 l_aa_code_15]  ;


rc_dataset_l := __common__( DATASET([
    {'B017', l_rcvalueB017},
    {'B026', l_rcvalueB026},
    {'B031', l_rcvalueB031},
    {'B034', l_rcvalueB034},
    {'B037', l_rcvalueB037},
    {'B038', l_rcvalueB038},
    {'B040', l_rcvalueB040},
    {'B052', l_rcvalueB052},
    {'B053', l_rcvalueB053},
    {'B055', l_rcvalueB055},
    {'B057', l_rcvalueB057},
    {'B063', l_rcvalueB063},
    {'BF108', l_rcvalueBF108}
    ], ds_layout)(rc in l_code_set)  ) ;

//*************************************************************************************//
// IMPORTANT NOTE:  Select ONLY reason codes with an RC in rc_code_set
//*************************************************************************************//
rc_dataset_l_sorted := __common__( sort(rc_dataset_l, rc_dataset_l.value) ) ;


l_rc1  := __common__( rc_dataset_l_sorted[1].rc ) ;
l_rc2  := __common__( rc_dataset_l_sorted[2].rc ) ;
l_rc3  := __common__( rc_dataset_l_sorted[3].rc ) ;
l_rc4  := __common__( rc_dataset_l_sorted[4].rc ) ;
l_rc5  := __common__( rc_dataset_l_sorted[5].rc ) ;
l_rc6  := __common__( rc_dataset_l_sorted[6].rc ) ;
l_rc7  := __common__( rc_dataset_l_sorted[7].rc ) ;
l_rc8  := __common__( rc_dataset_l_sorted[8].rc ) ;
l_rc9  := __common__( rc_dataset_l_sorted[9].rc ) ;
l_rc10  := __common__( rc_dataset_l_sorted[10].rc ) ;
l_rc11  := __common__( rc_dataset_l_sorted[11].rc ) ;
l_rc12  := __common__( rc_dataset_l_sorted[12].rc ) ;
l_rc13  := __common__( rc_dataset_l_sorted[13].rc ) ;
l_rc14  := __common__( rc_dataset_l_sorted[14].rc ) ;
l_rc15  := __common__( rc_dataset_l_sorted[15].rc ) ;
l_rc16  := __common__( rc_dataset_l_sorted[16].rc ) ;
l_rc17  := __common__( rc_dataset_l_sorted[17].rc ) ;
l_rc18  := __common__( rc_dataset_l_sorted[18].rc ) ;
l_rc19  := __common__( rc_dataset_l_sorted[19].rc ) ;
l_rc20  := __common__( rc_dataset_l_sorted[20].rc ) ;
l_rc21  := __common__( rc_dataset_l_sorted[21].rc ) ;
l_rc22  := __common__( rc_dataset_l_sorted[22].rc ) ;
l_rc23  := __common__( rc_dataset_l_sorted[23].rc ) ;
l_rc24  := __common__( rc_dataset_l_sorted[24].rc ) ;
l_rc25  := __common__( rc_dataset_l_sorted[25].rc ) ;
l_rc26  := __common__( rc_dataset_l_sorted[26].rc ) ;
l_rc27  := __common__( rc_dataset_l_sorted[27].rc ) ;
l_rc28  := __common__( rc_dataset_l_sorted[28].rc ) ;
l_rc29  := __common__( rc_dataset_l_sorted[29].rc ) ;
l_rc30  := __common__( rc_dataset_l_sorted[30].rc ) ;
l_rc31  := __common__( rc_dataset_l_sorted[31].rc ) ;
l_rc32  := __common__( rc_dataset_l_sorted[32].rc ) ;
l_rc33  := __common__( rc_dataset_l_sorted[33].rc ) ;
l_rc34  := __common__( rc_dataset_l_sorted[34].rc ) ;
l_rc35  := __common__( rc_dataset_l_sorted[35].rc ) ;
l_rc36  := __common__( rc_dataset_l_sorted[36].rc ) ;
l_rc37  := __common__( rc_dataset_l_sorted[37].rc ) ;
l_rc38  := __common__( rc_dataset_l_sorted[38].rc ) ;
l_rc39  := __common__( rc_dataset_l_sorted[39].rc ) ;
l_rc40  := __common__( rc_dataset_l_sorted[40].rc ) ;
l_rc41  := __common__( rc_dataset_l_sorted[41].rc ) ;
l_rc42  := __common__( rc_dataset_l_sorted[42].rc ) ;
l_rc43  := __common__( rc_dataset_l_sorted[43].rc ) ;
l_rc44  := __common__( rc_dataset_l_sorted[44].rc ) ;
l_rc45  := __common__( rc_dataset_l_sorted[45].rc ) ;
l_rc46  := __common__( rc_dataset_l_sorted[46].rc ) ;
l_rc47  := __common__( rc_dataset_l_sorted[47].rc ) ;
l_rc48  := __common__( rc_dataset_l_sorted[48].rc ) ;
l_rc49  := __common__( rc_dataset_l_sorted[49].rc ) ;
l_rc50  := __common__( rc_dataset_l_sorted[50].rc ) ;
 
//*************************************************************************************//

s_code_set := __common__( [s_aa_code_1,
							 s_aa_code_2,
							 s_aa_code_3,
							 s_aa_code_4,
							 s_aa_code_5,
							 s_aa_code_6,
							 s_aa_code_7,
							 s_aa_code_8,
							 s_aa_code_9,
							 s_aa_code_10,
							 s_aa_code_11,
							 s_aa_code_12,
							 s_aa_code_13,
							 s_aa_code_14,
							 s_aa_code_15,
							 s_aa_code_16,
							 s_aa_code_17,
							 s_aa_code_18,
							 s_aa_code_19,
							 s_aa_code_20,
							 s_aa_code_21,
							 s_aa_code_22,
							 s_aa_code_23,
							 s_aa_code_24,
							 s_aa_code_25,
							 s_aa_code_26,
							 s_aa_code_27] ) ;
							 
rc_dataset_s := __common__( DATASET([
    {'B017', s_rcvalueB017},
    {'B026', s_rcvalueB026},
    {'B031', s_rcvalueB031},
    {'B034', s_rcvalueB034},
    {'B037', s_rcvalueB037},
    {'B040', s_rcvalueB040},
    {'B055', s_rcvalueB055},
    {'B057', s_rcvalueB057},
    {'B059', s_rcvalueB059},
    {'B063', s_rcvalueB063},
    {'BF105', s_rcvalueBF105},
    {'BF106', s_rcvalueBF106},
    {'BF107', s_rcvalueBF107},
    {'BF110', s_rcvalueBF110},
    {'BF113', s_rcvalueBF113},
    {'BF117', s_rcvalueBF117},
    {'BF120', s_rcvalueBF120},
    {'BF125', s_rcvalueBF125},
    {'BF126', s_rcvalueBF126},
    {'BF127', s_rcvalueBF127},
    {'BF128', s_rcvalueBF128},
    {'BF129', s_rcvalueBF129},
    {'BF133', s_rcvalueBF133},
    {'BF134', s_rcvalueBF134},
    {'BF135', s_rcvalueBF135},
    {'BF136', s_rcvalueBF136},
    {'BF141', s_rcvalueBF141},
    {'BF142', s_rcvalueBF142},
    {'BF143', s_rcvalueBF143}
    ], ds_layout)(rc in s_code_set) ) ;

//*************************************************************************************//
// IMPORTANT NOTE:  Select ONLY reason codes with an RC in rc_code_set
//*************************************************************************************//

rc_dataset_s_sorted := __common__( sort(rc_dataset_s, rc_dataset_s.value) ) ;


s_rc1  := __common__( rc_dataset_s_sorted[1].rc ) ;
s_rc2  := __common__( rc_dataset_s_sorted[2].rc ) ;
s_rc3  := __common__( rc_dataset_s_sorted[3].rc ) ;
s_rc4  := __common__( rc_dataset_s_sorted[4].rc ) ;
s_rc5  := __common__( rc_dataset_s_sorted[5].rc ) ;
s_rc6  := __common__( rc_dataset_s_sorted[6].rc ) ;
s_rc7  := __common__( rc_dataset_s_sorted[7].rc ) ;
s_rc8  := __common__( rc_dataset_s_sorted[8].rc ) ;
s_rc9  := __common__( rc_dataset_s_sorted[9].rc ) ;
s_rc10  := __common__( rc_dataset_s_sorted[10].rc ) ;
s_rc11  := __common__( rc_dataset_s_sorted[11].rc ) ;
s_rc12  := __common__( rc_dataset_s_sorted[12].rc ) ;
s_rc13  := __common__( rc_dataset_s_sorted[13].rc ) ;
s_rc14  := __common__( rc_dataset_s_sorted[14].rc ) ;
s_rc15  := __common__( rc_dataset_s_sorted[15].rc ) ;
s_rc16  := __common__( rc_dataset_s_sorted[16].rc ) ;
s_rc17  := __common__( rc_dataset_s_sorted[17].rc ) ;
s_rc18  := __common__( rc_dataset_s_sorted[18].rc ) ;
s_rc19  := __common__( rc_dataset_s_sorted[19].rc ) ;
s_rc20  := __common__( rc_dataset_s_sorted[20].rc ) ;
s_rc21  := __common__( rc_dataset_s_sorted[21].rc ) ;
s_rc22  := __common__( rc_dataset_s_sorted[22].rc ) ;
s_rc23  := __common__( rc_dataset_s_sorted[23].rc ) ;
s_rc24  := __common__( rc_dataset_s_sorted[24].rc ) ;
s_rc25  := __common__( rc_dataset_s_sorted[25].rc ) ;
s_rc26  := __common__( rc_dataset_s_sorted[26].rc ) ;
s_rc27  := __common__( rc_dataset_s_sorted[27].rc ) ;
s_rc28  := __common__( rc_dataset_s_sorted[28].rc ) ;
s_rc29  := __common__( rc_dataset_s_sorted[29].rc ) ;
s_rc30  := __common__( rc_dataset_s_sorted[30].rc ) ;
s_rc31  := __common__( rc_dataset_s_sorted[31].rc ) ;
s_rc32  := __common__( rc_dataset_s_sorted[32].rc ) ;
s_rc33  := __common__( rc_dataset_s_sorted[33].rc ) ;
s_rc34  := __common__( rc_dataset_s_sorted[34].rc ) ;
s_rc35  := __common__( rc_dataset_s_sorted[35].rc ) ;
s_rc36  := __common__( rc_dataset_s_sorted[36].rc ) ;
s_rc37  := __common__( rc_dataset_s_sorted[37].rc ) ;
s_rc38  := __common__( rc_dataset_s_sorted[38].rc ) ;
s_rc39  := __common__( rc_dataset_s_sorted[39].rc ) ;
s_rc40  := __common__( rc_dataset_s_sorted[40].rc ) ;
s_rc41  := __common__( rc_dataset_s_sorted[41].rc ) ;
s_rc42  := __common__( rc_dataset_s_sorted[42].rc ) ;
s_rc43  := __common__( rc_dataset_s_sorted[43].rc ) ;
s_rc44  := __common__( rc_dataset_s_sorted[44].rc ) ;
s_rc45  := __common__( rc_dataset_s_sorted[45].rc ) ;
s_rc46  := __common__( rc_dataset_s_sorted[46].rc ) ;
s_rc47  := __common__( rc_dataset_s_sorted[47].rc ) ;
s_rc48  := __common__( rc_dataset_s_sorted[48].rc ) ;
s_rc49  := __common__( rc_dataset_s_sorted[49].rc ) ;
s_rc50  := __common__( rc_dataset_s_sorted[50].rc ) ;

bus_mod_rc28_1 := __common__( if(seg_business_score = 'LN & SBFE', s_rc28, l_rc28) ) ;

bus_mod_rc29_1 := __common__( if(seg_business_score = 'LN & SBFE', s_rc29, l_rc29) ) ;

bus_mod_rc12_1 := __common__( if(seg_business_score = 'LN & SBFE', s_rc12, l_rc12) ) ;

bus_mod_rc34_1 := __common__( if(seg_business_score = 'LN & SBFE', s_rc34, l_rc34) ) ;

bus_mod_rc46_1 := __common__( if(seg_business_score = 'LN & SBFE', s_rc46, l_rc46) ) ;

bus_mod_rc35_1 := __common__( if(seg_business_score = 'LN & SBFE', s_rc35, l_rc35) ) ;

bus_mod_rc40_1 := __common__( if(seg_business_score = 'LN & SBFE', s_rc40, l_rc40) ) ;

bus_mod_rc30_1 := __common__( if(seg_business_score = 'LN & SBFE', s_rc30, l_rc30) ) ;

bus_mod_rc18_1 := __common__( if(seg_business_score = 'LN & SBFE', s_rc18, l_rc18) ) ;

bus_mod_rc8_1 := __common__( if(seg_business_score = 'LN & SBFE', s_rc8, l_rc8) ) ;

bus_mod_rc44_1 := __common__( if(seg_business_score = 'LN & SBFE', s_rc44, l_rc44) ) ;

bus_mod_rc43_1 := __common__( if(seg_business_score = 'LN & SBFE', s_rc43, l_rc43) ) ;

bus_mod_rc33_1 := __common__( if(seg_business_score = 'LN & SBFE', s_rc33, l_rc33) ) ;

bus_mod_rc20_1 := __common__( if(seg_business_score = 'LN & SBFE', s_rc20, l_rc20) ) ;

bus_mod_rc24_1 := __common__( if(seg_business_score = 'LN & SBFE', s_rc24, l_rc24) ) ;

bus_mod_rc16_1 := __common__( if(seg_business_score = 'LN & SBFE', s_rc16, l_rc16) ) ;

bus_mod_rc39_1 := __common__( if(seg_business_score = 'LN & SBFE', s_rc39, l_rc39) ) ;

bus_mod_rc11_1 := __common__( if(seg_business_score = 'LN & SBFE', s_rc11, l_rc11) ) ;

bus_mod_rc26_1 := __common__( if(seg_business_score = 'LN & SBFE', s_rc26, l_rc26) ) ;

bus_mod_rc31_1 := __common__( if(seg_business_score = 'LN & SBFE', s_rc31, l_rc31) ) ;

bus_mod_rc7_1 := __common__( if(seg_business_score = 'LN & SBFE', s_rc7, l_rc7) ) ;

bus_mod_rc41_1 := __common__( if(seg_business_score = 'LN & SBFE', s_rc41, l_rc41) ) ;

bus_mod_rc45_1 := __common__( if(seg_business_score = 'LN & SBFE', s_rc45, l_rc45) ) ;

bus_mod_rc37_1 := __common__( if(seg_business_score = 'LN & SBFE', s_rc37, l_rc37) ) ;

bus_mod_rc3_1 := __common__( if(seg_business_score = 'LN & SBFE', s_rc3, l_rc3) ) ;

bus_mod_rc36_1 := __common__( if(seg_business_score = 'LN & SBFE', s_rc36, l_rc36) ) ;

bus_mod_rc17_1 := __common__( if(seg_business_score = 'LN & SBFE', s_rc17, l_rc17) ) ;

bus_mod_rc15_1 := __common__( if(seg_business_score = 'LN & SBFE', s_rc15, l_rc15) ) ;

bus_mod_rc10_1 := __common__( if(seg_business_score = 'LN & SBFE', s_rc10, l_rc10) ) ;

bus_mod_rc48_1 := __common__( if(seg_business_score = 'LN & SBFE', s_rc48, l_rc48) ) ;

bus_mod_rc5_1 := __common__( if(seg_business_score = 'LN & SBFE', s_rc5, l_rc5) ) ;

bus_mod_rc25_1 := __common__( if(seg_business_score = 'LN & SBFE', s_rc25, l_rc25) ) ;

bus_mod_rc9_1 := __common__( if(seg_business_score = 'LN & SBFE', s_rc9, l_rc9) ) ;

bus_mod_rc42_1 := __common__( if(seg_business_score = 'LN & SBFE', s_rc42, l_rc42) ) ;

bus_mod_rc14_1 := __common__( if(seg_business_score = 'LN & SBFE', s_rc14, l_rc14) ) ;

bus_mod_rc38_1 := __common__( if(seg_business_score = 'LN & SBFE', s_rc38, l_rc38) ) ;

bus_mod_rc2_1 := __common__( if(seg_business_score = 'LN & SBFE', s_rc2, l_rc2) ) ;

bus_mod_rc47_1 := __common__( if(seg_business_score = 'LN & SBFE', s_rc47, l_rc47) ) ;

bus_mod_rc27_1 := __common__( if(seg_business_score = 'LN & SBFE', s_rc27, l_rc27) ) ;

bus_mod_rc1_1 := __common__( if(seg_business_score = 'LN & SBFE', s_rc1, l_rc1) ) ;

bus_mod_rc4_1 := __common__( if(seg_business_score = 'LN & SBFE', s_rc4, l_rc4) ) ;

bus_mod_rc32_1 := __common__( if(seg_business_score = 'LN & SBFE', s_rc32, l_rc32) ) ;

bus_mod_rc19_1 := __common__( if(seg_business_score = 'LN & SBFE', s_rc19, l_rc19) ) ;

bus_mod_rc49_1 := __common__( if(seg_business_score = 'LN & SBFE', s_rc49, l_rc49) ) ;

bus_mod_rc22_1 := __common__( if(seg_business_score = 'LN & SBFE', s_rc22, l_rc22) ) ;

bus_mod_rc21_1 := __common__( if(seg_business_score = 'LN & SBFE', s_rc21, l_rc21) ) ;

bus_mod_rc13_1 := __common__( if(seg_business_score = 'LN & SBFE', s_rc13, l_rc13) ) ;

bus_mod_rc50_1 := __common__( if(seg_business_score = 'LN & SBFE', s_rc50, l_rc50) ) ;

bus_mod_rc6_1 := __common__( if(seg_business_score = 'LN & SBFE', s_rc6, l_rc6) ) ;

bus_mod_rc23_1 := __common__( if(seg_business_score = 'LN & SBFE', s_rc23, l_rc23) ) ;

bus_mod_rc30 := __common__( if(bus_mod_final_lgt = -1, ' ', bus_mod_rc30_1) ) ;

bus_mod_rc18 := __common__( if(bus_mod_final_lgt = -1, ' ', bus_mod_rc18_1) ) ;

bus_mod_rc8 := __common__( if(bus_mod_final_lgt = -1, ' ', bus_mod_rc8_1) ) ;

bus_mod_rc44 := __common__( if(bus_mod_final_lgt = -1, ' ', bus_mod_rc44_1) ) ;

bus_mod_rc43 := __common__( if(bus_mod_final_lgt = -1, ' ', bus_mod_rc43_1) ) ;

bus_mod_rc28 := __common__( if(bus_mod_final_lgt = -1, ' ', bus_mod_rc28_1) ) ;

bus_mod_rc12 := __common__( if(bus_mod_final_lgt = -1, ' ', bus_mod_rc12_1) ) ;

bus_mod_rc29 := __common__( if(bus_mod_final_lgt = -1, ' ', bus_mod_rc29_1) ) ;

bus_mod_rc34 := __common__( if(bus_mod_final_lgt = -1, ' ', bus_mod_rc34_1) ) ;

bus_mod_rc46 := __common__( if(bus_mod_final_lgt = -1, ' ', bus_mod_rc46_1) ) ;

bus_mod_rc35 := __common__( if(bus_mod_final_lgt = -1, ' ', bus_mod_rc35_1) ) ;

bus_mod_rc40 := __common__( if(bus_mod_final_lgt = -1, ' ', bus_mod_rc40_1) ) ;

bus_mod_rc26 := __common__( if(bus_mod_final_lgt = -1, ' ', bus_mod_rc26_1) ) ;

bus_mod_rc31 := __common__( if(bus_mod_final_lgt = -1, ' ', bus_mod_rc31_1) ) ;

bus_mod_rc41 := __common__( if(bus_mod_final_lgt = -1, ' ', bus_mod_rc41_1) ) ;

bus_mod_rc7 := __common__( if(bus_mod_final_lgt = -1, ' ', bus_mod_rc7_1) ) ;

bus_mod_rc45 := __common__( if(bus_mod_final_lgt = -1, ' ', bus_mod_rc45_1) ) ;

bus_mod_rc37 := __common__( if(bus_mod_final_lgt = -1, ' ', bus_mod_rc37_1) ) ;

sbom1601_0_0 := __common__( if(bus_mod_final_lgt = -1, 222, min(if(max(_sbom1601_0_0, 501) = NULL, -NULL, max(_sbom1601_0_0, 501)), 900)) ) ;

bus_mod_rc3 := __common__( if(bus_mod_final_lgt = -1, ' ', bus_mod_rc3_1) ) ;

bus_mod_rc33 := __common__( if(bus_mod_final_lgt = -1, ' ', bus_mod_rc33_1) ) ;

bus_mod_rc20 := __common__( if(bus_mod_final_lgt = -1, ' ', bus_mod_rc20_1) ) ;

bus_mod_rc24 := __common__( if(bus_mod_final_lgt = -1, ' ', bus_mod_rc24_1) ) ;

bus_mod_rc16 := __common__( if(bus_mod_final_lgt = -1, ' ', bus_mod_rc16_1) ) ;

bus_mod_rc39 := __common__( if(bus_mod_final_lgt = -1, ' ', bus_mod_rc39_1) ) ;

bus_mod_rc11 := __common__( if(bus_mod_final_lgt = -1, ' ', bus_mod_rc11_1) ) ;

bus_mod_rc10 := __common__( if(bus_mod_final_lgt = -1, ' ', bus_mod_rc10_1) ) ;

bus_mod_rc48 := __common__( if(bus_mod_final_lgt = -1, ' ', bus_mod_rc48_1) ) ;

bus_mod_rc5 := __common__( if(bus_mod_final_lgt = -1, ' ', bus_mod_rc5_1) ) ;

bus_mod_rc25 := __common__( if(bus_mod_final_lgt = -1, ' ', bus_mod_rc25_1) ) ;

bus_mod_rc9 := __common__( if(bus_mod_final_lgt = -1, ' ', bus_mod_rc9_1) ) ;

bus_mod_rc42 := __common__( if(bus_mod_final_lgt = -1, ' ', bus_mod_rc42_1) ) ;

bus_mod_rc15 := __common__( if(bus_mod_final_lgt = -1, ' ', bus_mod_rc15_1) ) ;

bus_mod_rc17 := __common__( if(bus_mod_final_lgt = -1, ' ', bus_mod_rc17_1) ) ;

bus_mod_rc36 := __common__( if(bus_mod_final_lgt = -1, ' ', bus_mod_rc36_1) ) ;

bus_mod_rc21 := __common__( if(bus_mod_final_lgt = -1, ' ', bus_mod_rc21_1) ) ;

bus_mod_rc13 := __common__( if(bus_mod_final_lgt = -1, ' ', bus_mod_rc13_1) ) ;

bus_mod_rc50 := __common__( if(bus_mod_final_lgt = -1, ' ', bus_mod_rc50_1) ) ;

bus_mod_rc6 := __common__( if(bus_mod_final_lgt = -1, ' ', bus_mod_rc6_1) ) ;

bus_mod_rc23 := __common__( if(bus_mod_final_lgt = -1, ' ', bus_mod_rc23_1) ) ;

bus_mod_rc14 := __common__( if(bus_mod_final_lgt = -1, ' ', bus_mod_rc14_1) ) ;

bus_mod_rc38 := __common__( if(bus_mod_final_lgt = -1, ' ', bus_mod_rc38_1) ) ;

bus_mod_rc47 := __common__( if(bus_mod_final_lgt = -1, ' ', bus_mod_rc47_1) ) ;

bus_mod_rc2 := __common__( if(bus_mod_final_lgt = -1, ' ', bus_mod_rc2_1) ) ;

bus_mod_rc27 := __common__( if(bus_mod_final_lgt = -1, ' ', bus_mod_rc27_1) ) ;

bus_mod_rc4 := __common__( if(bus_mod_final_lgt = -1, ' ', bus_mod_rc4_1) ) ;

bus_mod_rc1 := __common__( if(bus_mod_final_lgt = -1, 'B068', bus_mod_rc1_1) ) ;

bus_mod_rc32 := __common__( if(bus_mod_final_lgt = -1, ' ', bus_mod_rc32_1) ) ;

bus_mod_rc19 := __common__( if(bus_mod_final_lgt = -1, ' ', bus_mod_rc19_1) ) ;

bus_mod_rc49 := __common__( if(bus_mod_final_lgt = -1, ' ', bus_mod_rc49_1) ) ;

bus_mod_rc22 := __common__( if(bus_mod_final_lgt = -1, ' ', bus_mod_rc22_1) ) ;

sbom_rc1_1 := __common__( bus_mod_rc1 ) ;

sbom_rc2_1 := __common__( bus_mod_rc2 ) ;

sbom_rc3_1 := __common__( bus_mod_rc3 ) ;

sbom_rc4_1 := __common__( bus_mod_rc4 ) ;

sbom_rc3 := __common__( if(sbom1601_0_0 = 900, ' ', sbom_rc3_1) ) ;

sbom_rc1 := __common__( if(sbom1601_0_0 = 900, ' ', sbom_rc1_1) ) ;

sbom_rc4 := __common__( if(sbom1601_0_0 = 900, ' ', sbom_rc4_1) ) ;

sbom_rc2 := __common__( if(sbom1601_0_0 = 900, ' ', sbom_rc2_1) ) ;



//*************************************************************************************//
//                      Reason Code Overrides 
//*************************************************************************************//
HRILayout := RECORD
	STRING5 HRI := '';
END;

reasons := DATASET([{sbom_rc1}, {sbom_rc2}, {sbom_rc3}, {sbom_rc4}], HRILayout);

zeros := DATASET([{'00'}, {'00'}, {'00'}, {'00'}], HRILayout);
reasonCodes := CHOOSEN(reasons & zeros, 4); // Keep up to 4 reason codes

 
	#if(MODEL_DEBUG)
                    self.source_ar                        := source_ar;
                    self.source_ba                        := source_ba;
                    self.source_bm                        := source_bm;
                    self.source_c                         := source_c;
                    self.source_cs                        := source_cs;
                    self.source_dn                        := source_dn;
                    self.source_ef                        := source_ef;
                    self.source_ft                        := source_ft;
                    self.source_i                         := source_i;
                    self.source_ia                        := source_ia;
                    self.source_in                        := source_in;
                    self.source_l2                        := source_l2;
                    self.source_p                         := source_p;
                    self.source_ut                        := source_ut;
                    self.source_v2                        := source_v2;
                    self.source_wk                        := source_wk;
                    self.sysdate                          := sysdate;
                    self.sysdate_days                     := sysdate_days;
                    self._ver_src_id_br_pos               := _ver_src_id_br_pos;
                    self._ver_src_id__br                  := _ver_src_id__br;
                    self._ver_src_id_c_pos                := _ver_src_id_c_pos;
                    self._ver_src_id__c                   := _ver_src_id__c;
                    self._ver_src_id_fdate_c              := _ver_src_id_fdate_c;
                    self._ver_src_id_fdate_c2             := _ver_src_id_fdate_c2;
                    self.mth__ver_src_id_fdate_c          := mth__ver_src_id_fdate_c;
                    self._ver_src_id_d_pos                := _ver_src_id_d_pos;
                    self._ver_src_id__d                   := _ver_src_id__d;
                    self._ver_src_id_df_pos               := _ver_src_id_df_pos;
                    self._ver_src_id__df                  := _ver_src_id__df;
                    self._ver_src_id_dn_pos               := _ver_src_id_dn_pos;
                    self._ver_src_id__dn                  := _ver_src_id__dn;
                    self._ver_src_id_fb_pos               := _ver_src_id_fb_pos;
                    self._ver_src_id__fb                  := _ver_src_id__fb;
                    self._ver_src_id_l0_pos               := _ver_src_id_l0_pos;
                    self._ver_src_id__l0                  := _ver_src_id__l0;
                    self._ver_src_id_l2_pos               := _ver_src_id_l2_pos;
                    self._ver_src_id__l2                  := _ver_src_id__l2;
                    self._ver_src_id_u2_pos               := _ver_src_id_u2_pos;
                    self._ver_src_id__u2                  := _ver_src_id__u2;
                    self._ver_src_id_ar_pos               := _ver_src_id_ar_pos;
                    self._ver_src_id__ar                  := _ver_src_id__ar;
                    self._ver_src_id_ba_pos               := _ver_src_id_ba_pos;
                    self._ver_src_id__ba                  := _ver_src_id__ba;
                    self._ver_src_id_bm_pos               := _ver_src_id_bm_pos;
                    self._ver_src_id__bm                  := _ver_src_id__bm;
                    self._ver_src_id_bn_pos               := _ver_src_id_bn_pos;
                    self._ver_src_id__bn                  := _ver_src_id__bn;
                    self._ver_src_id_cu_pos               := _ver_src_id_cu_pos;
                    self._ver_src_id__cu                  := _ver_src_id__cu;
                    self._ver_src_id_da_pos               := _ver_src_id_da_pos;
                    self._ver_src_id__da                  := _ver_src_id__da;
                    self._ver_src_id_ef_pos               := _ver_src_id_ef_pos;
                    self._ver_src_id__ef                  := _ver_src_id__ef;
                    self._ver_src_id_fi_pos               := _ver_src_id_fi_pos;
                    self._ver_src_id__fi                  := _ver_src_id__fi;
                    self._ver_src_id_i_pos                := _ver_src_id_i_pos;
                    self._ver_src_id__i                   := _ver_src_id__i;
                    self._ver_src_id_ia_pos               := _ver_src_id_ia_pos;
                    self._ver_src_id__ia                  := _ver_src_id__ia;
                    self._ver_src_id_in_pos               := _ver_src_id_in_pos;
                    self._ver_src_id__in                  := _ver_src_id__in;
                    self._ver_src_id_os_pos               := _ver_src_id_os_pos;
                    self._ver_src_id__os                  := _ver_src_id__os;
                    self._ver_src_id_p_pos                := _ver_src_id_p_pos;
                    self._ver_src_id__p                   := _ver_src_id__p;
                    self._ver_src_id_ldate_p              := _ver_src_id_ldate_p;
                    self._ver_src_id_ldate_p2             := _ver_src_id_ldate_p2;
                    self.mth__ver_src_id_ldate_p          := mth__ver_src_id_ldate_p;
                    self._ver_src_id_pl_pos               := _ver_src_id_pl_pos;
                    self._ver_src_id__pl                  := _ver_src_id__pl;
                    self._ver_src_id_q3_pos               := _ver_src_id_q3_pos;
                    self._ver_src_id__q3                  := _ver_src_id__q3;
                    self._ver_src_id_fdate_q3             := _ver_src_id_fdate_q3;
                    self._ver_src_id_fdate_q32            := _ver_src_id_fdate_q32;
                    self.mth__ver_src_id_fdate_q3         := mth__ver_src_id_fdate_q3;
                    self._ver_src_id_sk_pos               := _ver_src_id_sk_pos;
                    self._ver_src_id__sk                  := _ver_src_id__sk;
                    self._ver_src_id_tx_pos               := _ver_src_id_tx_pos;
                    self._ver_src_id__tx                  := _ver_src_id__tx;
                    self._ver_src_id_v2_pos               := _ver_src_id_v2_pos;
                    self._ver_src_id__v2                  := _ver_src_id__v2;
                    self._ver_src_id_fdate_v22            := _ver_src_id_fdate_v22;
                    self.mth__ver_src_id_fdate_v2         := mth__ver_src_id_fdate_v2;
                    self._ver_src_id_ldate_v22            := _ver_src_id_ldate_v22;
                    self.mth__ver_src_id_ldate_v2         := mth__ver_src_id_ldate_v2;
                    self._ver_src_id_wa_pos               := _ver_src_id_wa_pos;
                    self._ver_src_id__wa                  := _ver_src_id__wa;
                    self._ver_src_id_by_pos               := _ver_src_id_by_pos;
                    self._ver_src_id__by                  := _ver_src_id__by;
                    self._ver_src_id_cf_pos               := _ver_src_id_cf_pos;
                    self._ver_src_id__cf                  := _ver_src_id__cf;
                    self._ver_src_id_e_pos                := _ver_src_id_e_pos;
                    self._ver_src_id__e                   := _ver_src_id__e;
                    self._ver_src_id_ey_pos               := _ver_src_id_ey_pos;
                    self._ver_src_id__ey                  := _ver_src_id__ey;
                    self._ver_src_id_f_pos                := _ver_src_id_f_pos;
                    self._ver_src_id__f                   := _ver_src_id__f;
                    self._ver_src_id_fk_pos               := _ver_src_id_fk_pos;
                    self._ver_src_id__fk                  := _ver_src_id__fk;
                    self._ver_src_id_fr_pos               := _ver_src_id_fr_pos;
                    self._ver_src_id__fr                  := _ver_src_id__fr;
                    self._ver_src_id_ft_pos               := _ver_src_id_ft_pos;
                    self._ver_src_id__ft                  := _ver_src_id__ft;
                    self._ver_src_id_gr_pos               := _ver_src_id_gr_pos;
                    self._ver_src_id__gr                  := _ver_src_id__gr;
                    self._ver_src_id_h7_pos               := _ver_src_id_h7_pos;
                    self._ver_src_id__h7                  := _ver_src_id__h7;
                    self._ver_src_id_ic_pos               := _ver_src_id_ic_pos;
                    self._ver_src_id__ic                  := _ver_src_id__ic;
                    self._ver_src_id_ip_pos               := _ver_src_id_ip_pos;
                    self._ver_src_id__ip                  := _ver_src_id__ip;
                    self._ver_src_id_is_pos               := _ver_src_id_is_pos;
                    self._ver_src_id__is                  := _ver_src_id__is;
                    self._ver_src_id_it_pos               := _ver_src_id_it_pos;
                    self._ver_src_id__it                  := _ver_src_id__it;
                    self._ver_src_id_j2_pos               := _ver_src_id_j2_pos;
                    self._ver_src_id__j2                  := _ver_src_id__j2;
                    self._ver_src_id_kc_pos               := _ver_src_id_kc_pos;
                    self._ver_src_id__kc                  := _ver_src_id__kc;
                    self._ver_src_id_mh_pos               := _ver_src_id_mh_pos;
                    self._ver_src_id__mh                  := _ver_src_id__mh;
                    self._ver_src_id_mw_pos               := _ver_src_id_mw_pos;
                    self._ver_src_id__mw                  := _ver_src_id__mw;
                    self._ver_src_id_np_pos               := _ver_src_id_np_pos;
                    self._ver_src_id__np                  := _ver_src_id__np;
                    self._ver_src_id_nr_pos               := _ver_src_id_nr_pos;
                    self._ver_src_id__nr                  := _ver_src_id__nr;
                    self._ver_src_id_sa_pos               := _ver_src_id_sa_pos;
                    self._ver_src_id__sa                  := _ver_src_id__sa;
                    self._ver_src_id_sb_pos               := _ver_src_id_sb_pos;
                    self._ver_src_id__sb                  := _ver_src_id__sb;
                    self._ver_src_id_sg_pos               := _ver_src_id_sg_pos;
                    self._ver_src_id__sg                  := _ver_src_id__sg;
                    self._ver_src_id_sj_pos               := _ver_src_id_sj_pos;
                    self._ver_src_id__sj                  := _ver_src_id__sj;
                    self._ver_src_id_sp_pos               := _ver_src_id_sp_pos;
                    self._ver_src_id__sp                  := _ver_src_id__sp;
                    self._ver_src_id_ut_pos               := _ver_src_id_ut_pos;
                    self._ver_src_id__ut                  := _ver_src_id__ut;
                    self._ver_src_id_v_pos                := _ver_src_id_v_pos;
                    self._ver_src_id__v                   := _ver_src_id__v;
                    self._ver_src_id_wb_pos               := _ver_src_id_wb_pos;
                    self._ver_src_id__wb                  := _ver_src_id__wb;
                    self._ver_src_id_wc_pos               := _ver_src_id_wc_pos;
                    self._ver_src_id__wc                  := _ver_src_id__wc;
                    self._ver_src_id_wk_pos               := _ver_src_id_wk_pos;
                    self._ver_src_id__wk                  := _ver_src_id__wk;
                    self._ver_src_id_wx_pos               := _ver_src_id_wx_pos;
                    self._ver_src_id__wx                  := _ver_src_id__wx;
                    self._ver_src_id_zo_pos               := _ver_src_id_zo_pos;
                    self._ver_src_id__zo                  := _ver_src_id__zo;
                    self._ver_src_id_y_pos                := _ver_src_id_y_pos;
                    self._ver_src_id__y                   := _ver_src_id__y;
                    self._ver_src_id_gb_pos               := _ver_src_id_gb_pos;
                    self._ver_src_id__gb                  := _ver_src_id__gb;
                    self._ver_src_id_fdate_gb             := _ver_src_id_fdate_gb;
                    self._ver_src_id_fdate_gb2            := _ver_src_id_fdate_gb2;
                    self.mth__ver_src_id_fdate_gb         := mth__ver_src_id_fdate_gb;
                    self._ver_src_id_ldate_gb             := _ver_src_id_ldate_gb;
                    self._ver_src_id_ldate_gb2            := _ver_src_id_ldate_gb2;
                    self.mth__ver_src_id_ldate_gb         := mth__ver_src_id_ldate_gb;
                    self._ver_src_id_cs_pos               := _ver_src_id_cs_pos;
                    self._ver_src_id__cs                  := _ver_src_id__cs;
                    self._ne_ver_src_id_count             := _ne_ver_src_id_count;
                    self.truebiz                          := truebiz;
                    self.ne_bv_truebiz_category           := ne_bv_truebiz_category;
                    self.seg_business_score               := seg_business_score;
                    self.vs_gb_id_mth_fseen               := vs_gb_id_mth_fseen;
                    self.vs_gb_id_mth_lseen               := vs_gb_id_mth_lseen;
                    self.vs_ver_src_id__ut                := vs_ver_src_id__ut;
                    self.vs_ver_src_id__bm                := vs_ver_src_id__bm;
                    self.vs_ver_src_id__i                 := vs_ver_src_id__i;
                    self.vs_v2_id_mth_fseen               := vs_v2_id_mth_fseen;
                    self.vs_v2_id_mth_lseen               := vs_v2_id_mth_lseen;
                    self.b_vs_gb_id_mth_fseen_w           := b_vs_gb_id_mth_fseen_w;
                    self.b_vs_gb_id_mth_lseen_w           := b_vs_gb_id_mth_lseen_w;
                    self.b_vs_ver_src_id__ut_w            := b_vs_ver_src_id__ut_w;
                    self.b_vs_ver_src_id__bm_w            := b_vs_ver_src_id__bm_w;
                    self.b_vs_ver_src_id__i_w             := b_vs_ver_src_id__i_w;
                    self.b_vs_v2_id_mth_fseen_w           := b_vs_v2_id_mth_fseen_w;
                    self.b_vs_v2_id_mth_lseen_w           := b_vs_v2_id_mth_lseen_w;
                    self.bv_bus_only_source_profile       := bv_bus_only_source_profile;
                    self.td_sbfe_worst_perf84             := td_sbfe_worst_perf84;
                    self.td_sbfe_avg_util_pct06           := td_sbfe_avg_util_pct06;
                    self.bv_assoc_derog_pct               := bv_assoc_derog_pct;
                    self.td_acct_dpd_1p_recency           := td_acct_dpd_1p_recency;
                    self._sbfe_acct_datefirstopen         := _sbfe_acct_datefirstopen;
                    self.td_mth_acct_firstopen            := td_mth_acct_firstopen;
                    self.td_sbfe_avg_util_pct_cc          := td_sbfe_avg_util_pct_cc;
                    self.td_sbfe_util_pct_cc              := td_sbfe_util_pct_cc;
                    self._sos_inc_filing_firstseen        := _sos_inc_filing_firstseen;
                    self.bv_sos_mth_fs                    := bv_sos_mth_fs;
                    self.bv_sos_index                     := bv_sos_index;
                    self.td_sbfe_util_pct_oel             := td_sbfe_util_pct_oel;
                    self.td_sbfe_closed_pct_invol         := td_sbfe_closed_pct_invol;
                    self.td_acct_dpd_31p_recency          := td_acct_dpd_31p_recency;
                    self.td_sbfe_satis_cnt_loan           := td_sbfe_satis_cnt_loan;
                    self.bv_inq_highrisk_recency          := bv_inq_highrisk_recency;
                    self.num_pos_sources                  := num_pos_sources;
                    self.num_neg_sources                  := num_neg_sources;
                    self.bv_ver_src_derog_ratio           := bv_ver_src_derog_ratio;
                    self.bv_mth_ver_src_q3_fs             := bv_mth_ver_src_q3_fs;
                    self.td_sbfe_util_pct_ge75_cnt_cc     := td_sbfe_util_pct_ge75_cnt_cc;
                    self.bv_lien_filed_recency            := bv_lien_filed_recency;
                    self.td_past_due_pct_of_limit_lse     := td_past_due_pct_of_limit_lse;
                    self.td_occ_dpd_31p_cnt24             := td_occ_dpd_31p_cnt24;
                    self._sbfe_datefirstseen              := _sbfe_datefirstseen;
                    self.td_mth_sbfe_datefirstseen        := td_mth_sbfe_datefirstseen;
                    self.bv_judg_filed_recency            := bv_judg_filed_recency;
                    self.td_acct_dpd_61p_cnt12            := td_acct_dpd_61p_cnt12;
                    self.td_acct_pct_closed               := td_acct_pct_closed;
                    self._sbfe_datelastseen               := _sbfe_datelastseen;
                    self.td_mth_sbfe_datelastseen         := td_mth_sbfe_datelastseen;
                    self._sbfe_dlq_datelastseen           := _sbfe_dlq_datelastseen;
                    self.td_mth_dlq_lastseen              := td_mth_dlq_lastseen;
                    self.td_past_due_pct_of_balance       := td_past_due_pct_of_balance;
                    self._inq_lastseen                    := _inq_lastseen;
                    self.bv_mths_inq_lastseen             := bv_mths_inq_lastseen;
                    self.bv_prop_assessed_value           := bv_prop_assessed_value;
                    self.bv_assoc_judg_tot                := bv_assoc_judg_tot;
                    self.bv_mth_ver_src_p_ls              := bv_mth_ver_src_p_ls;
                    self.bv_lien_judg_index               := bv_lien_judg_index;
                    self.bv_assoc_felony_ct               := bv_assoc_felony_ct;
                    self.bv_mth_ver_src_c_fs              := bv_mth_ver_src_c_fs;
                    self.bv_inq_highrisk_count            := bv_inq_highrisk_count;
                    self.bv_assoc_lien_tot                := bv_assoc_lien_tot;
                    self.s_bv_assoc_derog_pct_w           := s_bv_assoc_derog_pct_w;
                    self.s_aa_dist_1                      := s_aa_dist_1;
                    self.s_aa_code_1                      := s_aa_code_1;
                    self.s_bv_sos_index_w                 := s_bv_sos_index_w;
                    self.s_aa_dist_2                      := s_aa_dist_2;
                    self.s_aa_code_2                      := s_aa_code_2;
                    self.s_bv_lien_filed_recency_w        := s_bv_lien_filed_recency_w;
                    self.s_aa_dist_3                      := s_aa_dist_3;
                    self.s_aa_code_3                      := s_aa_code_3;
                    self.s_bv_judg_filed_recency_w        := s_bv_judg_filed_recency_w;
                    self.s_aa_dist_4                      := s_aa_dist_4;
                    self.s_aa_code_4                      := s_aa_code_4;
                    self.s_bv_inq_highrisk_recency_w      := s_bv_inq_highrisk_recency_w;
                    self.s_aa_dist_5                      := s_aa_dist_5;
                    self.s_aa_code_5                      := s_aa_code_5;
                    self.s_td_mth_sbfe_datefirstseen_w    := s_td_mth_sbfe_datefirstseen_w;
                    self.s_aa_dist_6                      := s_aa_dist_6;
                    self.s_aa_code_6                      := s_aa_code_6;
                    self.s_td_mth_acct_firstopen_w        := s_td_mth_acct_firstopen_w;
                    self.s_aa_dist_7                      := s_aa_dist_7;
                    self.s_aa_code_7                      := s_aa_code_7;
                    self.s_td_mth_dlq_lastseen_w          := s_td_mth_dlq_lastseen_w;
                    self.s_aa_dist_8                      := s_aa_dist_8;
                    self.s_aa_code_8                      := s_aa_code_8;
                    self.s_td_pd_pct_of_limit_lse_w       := s_td_pd_pct_of_limit_lse_w;
                    self.s_aa_dist_9                      := s_aa_dist_9;
                    self.s_aa_code_9                      := s_aa_code_9;
                    self.s_td_acct_dpd_1p_recency_w       := s_td_acct_dpd_1p_recency_w;
                    self.s_aa_dist_10                     := s_aa_dist_10;
                    self.s_aa_code_10                     := s_aa_code_10;
                    self.s_td_acct_dpd_31p_recency_w      := s_td_acct_dpd_31p_recency_w;
                    self.s_aa_dist_11                     := s_aa_dist_11;
                    self.s_aa_code_11                     := s_aa_code_11;
                    self.s_td_sbfe_closed_pct_invol_w     := s_td_sbfe_closed_pct_invol_w;
                    self.s_aa_dist_12                     := s_aa_dist_12;
                    self.s_aa_code_12                     := s_aa_code_12;
                    self.s_td_sbfe_util_pct_oel_w         := s_td_sbfe_util_pct_oel_w;
                    self.s_aa_dist_13                     := s_aa_dist_13;
                    self.s_aa_code_13                     := s_aa_code_13;
                    self.s_td_sbfe_util_pct75_cnt_cc_w    := s_td_sbfe_util_pct75_cnt_cc_w;
                    self.s_aa_dist_14                     := s_aa_dist_14;
                    self.s_aa_code_14                     := s_aa_code_14;
                    self.s_td_sbfe_avg_util_pct06_w       := s_td_sbfe_avg_util_pct06_w;
                    self.s_aa_dist_15                     := s_aa_dist_15;
                    self.s_aa_code_15                     := s_aa_code_15;
                    self.s_td_sbfe_avg_util_pct_cc_w      := s_td_sbfe_avg_util_pct_cc_w;
                    self.s_aa_dist_16                     := s_aa_dist_16;
                    self.s_aa_code_16                     := s_aa_code_16;
                    self.s_bv_mth_ver_src_q3_fs_w         := s_bv_mth_ver_src_q3_fs_w;
                    self.s_aa_dist_17                     := s_aa_dist_17;
                    self.s_aa_code_17                     := s_aa_code_17;
                    self.s_bv_ver_src_derog_ratio_w       := s_bv_ver_src_derog_ratio_w;
                    self.s_aa_dist_18                     := s_aa_dist_18;
                    self.s_aa_code_18                     := s_aa_code_18;
                    self.s_bv_bus_only_source_profile_w   := s_bv_bus_only_source_profile_w;
                    self.s_aa_dist_19                     := s_aa_dist_19;
                    self.s_aa_code_19                     := s_aa_code_19;
                    self.s_td_occ_dpd_31p_cnt24_w         := s_td_occ_dpd_31p_cnt24_w;
                    self.s_aa_dist_20                     := s_aa_dist_20;
                    self.s_aa_code_20                     := s_aa_code_20;
                    self.s_td_sbfe_satis_cnt_loan_w       := s_td_sbfe_satis_cnt_loan_w;
                    self.s_aa_dist_21                     := s_aa_dist_21;
                    self.s_aa_code_21                     := s_aa_code_21;
                    self.s_td_sbfe_util_pct_cc_w          := s_td_sbfe_util_pct_cc_w;
                    self.s_aa_dist_22                     := s_aa_dist_22;
                    self.s_aa_code_22                     := s_aa_code_22;
                    self.s_td_mth_sbfe_datelastseen_w     := s_td_mth_sbfe_datelastseen_w;
                    self.s_aa_dist_23                     := s_aa_dist_23;
                    self.s_aa_code_23                     := s_aa_code_23;
                    self.s_td_past_due_pct_of_balance_w   := s_td_past_due_pct_of_balance_w;
                    self.s_aa_dist_24                     := s_aa_dist_24;
                    self.s_aa_code_24                     := s_aa_code_24;
                    self.s_td_acct_pct_closed_w           := s_td_acct_pct_closed_w;
                    self.s_aa_dist_25                     := s_aa_dist_25;
                    self.s_aa_code_25                     := s_aa_code_25;
                    self.s_td_acct_dpd_61p_cnt12_w        := s_td_acct_dpd_61p_cnt12_w;
                    self.s_aa_dist_26                     := s_aa_dist_26;
                    self.s_aa_code_26                     := s_aa_code_26;
                    self.s_td_sbfe_worst_perf84_w         := s_td_sbfe_worst_perf84_w;
                    self.s_aa_dist_27                     := s_aa_dist_27;
                    self.s_aa_code_27                     := s_aa_code_27;
                    self.s_rcvalueb037                    := s_rcvalueb037;
                    self.s_rcvalueb034                    := s_rcvalueb034;
                    self.s_rcvalueb031                    := s_rcvalueb031;
                    self.s_rcvalueb017                    := s_rcvalueb017;
                    self.s_rcvaluebf142                   := s_rcvaluebf142;
                    self.s_rcvaluebf135                   := s_rcvaluebf135;
                    self.s_rcvaluebf134                   := s_rcvaluebf134;
                    self.s_rcvaluebf136                   := s_rcvaluebf136;
                    self.s_rcvaluebf117                   := s_rcvaluebf117;
                    self.s_rcvaluebf133                   := s_rcvaluebf133;
                    self.s_rcvalueb040                    := s_rcvalueb040;
                    self.s_rcvaluebf141                   := s_rcvaluebf141;
                    self.s_rcvalueb026                    := s_rcvalueb026;
                    self.s_rcvaluebf143                   := s_rcvaluebf143;
                    self.s_rcvalueb063                    := s_rcvalueb063;
                    self.s_rcvaluebf126                   := s_rcvaluebf126;
                    self.s_rcvaluebf127                   := s_rcvaluebf127;
                    self.s_rcvaluebf125                   := s_rcvaluebf125;
                    self.s_rcvaluebf120                   := s_rcvaluebf120;
                    self.s_rcvaluebf105                   := s_rcvaluebf105;
                    self.s_rcvaluebf106                   := s_rcvaluebf106;
                    self.s_rcvaluebf107                   := s_rcvaluebf107;
                    self.s_rcvaluebf128                   := s_rcvaluebf128;
                    self.s_rcvaluebf129                   := s_rcvaluebf129;
                    self.s_rcvaluebf113                   := s_rcvaluebf113;
                    self.s_rcvaluebf110                   := s_rcvaluebf110;
                    self.s_rcvalueb055                    := s_rcvalueb055;
                    self.s_rcvalueb057                    := s_rcvalueb057;
                    self.s_rcvalueb059                    := s_rcvalueb059;
                    self.s_final_score                    := s_final_score;
                    self.l_bv_assoc_felony_ct_w           := l_bv_assoc_felony_ct_w;
                    self.l_aa_dist_1                      := l_aa_dist_1;
                    self.l_aa_code_1                      := l_aa_code_1;
                    self.l_bv_assoc_lien_tot_w            := l_bv_assoc_lien_tot_w;
                    self.l_aa_dist_2                      := l_aa_dist_2;
                    self.l_aa_code_2                      := l_aa_code_2;
                    self.l_bv_assoc_judg_tot_w            := l_bv_assoc_judg_tot_w;
                    self.l_aa_dist_3                      := l_aa_dist_3;
                    self.l_aa_code_3                      := l_aa_code_3;
                    self.l_bv_assoc_derog_pct_w           := l_bv_assoc_derog_pct_w;
                    self.l_aa_dist_4                      := l_aa_dist_4;
                    self.l_aa_code_4                      := l_aa_code_4;
                    self.l_bv_sos_mth_fs_w                := l_bv_sos_mth_fs_w;
                    self.l_aa_dist_5                      := l_aa_dist_5;
                    self.l_aa_code_5                      := l_aa_code_5;
                    self.l_bv_lien_judg_index_w           := l_bv_lien_judg_index_w;
                    self.l_aa_dist_6                      := l_aa_dist_6;
                    self.l_aa_code_6                      := l_aa_code_6;
                    self.l_bv_prop_assessed_value_w       := l_bv_prop_assessed_value_w;
                    self.l_aa_dist_7                      := l_aa_dist_7;
                    self.l_aa_code_7                      := l_aa_code_7;
                    self.l_bv_inq_highrisk_count_w        := l_bv_inq_highrisk_count_w;
                    self.l_aa_dist_8                      := l_aa_dist_8;
                    self.l_aa_code_8                      := l_aa_code_8;
                    self.l_bv_mth_ver_src_c_fs_w          := l_bv_mth_ver_src_c_fs_w;
                    self.l_aa_dist_9                      := l_aa_dist_9;
                    self.l_aa_code_9                      := l_aa_code_9;
                    self.l_bv_mth_ver_src_p_ls_w          := l_bv_mth_ver_src_p_ls_w;
                    self.l_aa_dist_10                     := l_aa_dist_10;
                    self.l_aa_code_10                     := l_aa_code_10;
                    self.l_bv_mth_ver_src_q3_fs_w         := l_bv_mth_ver_src_q3_fs_w;
                    self.l_aa_dist_11                     := l_aa_dist_11;
                    self.l_aa_code_11                     := l_aa_code_11;
                    self.l_bv_ver_src_derog_ratio_w       := l_bv_ver_src_derog_ratio_w;
                    self.l_aa_dist_12                     := l_aa_dist_12;
                    self.l_aa_code_12                     := l_aa_code_12;
                    self.l_bv_bus_only_source_profile_w   := l_bv_bus_only_source_profile_w;
                    self.l_aa_dist_13                     := l_aa_dist_13;
                    self.l_aa_code_13                     := l_aa_code_13;
                    self.l_bv_mths_inq_lastseen_w         := l_bv_mths_inq_lastseen_w;
                    self.l_aa_dist_14                     := l_aa_dist_14;
                    self.l_aa_code_14                     := l_aa_code_14;
                    self.l_aa_code_15                     := l_aa_code_15;
                    self.l_aa_dist_15                     := l_aa_dist_15;
                    self.l_rcvalueb037                    := l_rcvalueb037;
                    self.l_rcvalueb026                    := l_rcvalueb026;
                    self.l_rcvalueb034                    := l_rcvalueb034;
                    self.l_rcvalueb040                    := l_rcvalueb040;
                    self.l_rcvalueb031                    := l_rcvalueb031;
                    self.l_rcvalueb017                    := l_rcvalueb017;
                    self.l_rcvalueb063                    := l_rcvalueb063;
                    self.l_rcvalueb038                    := l_rcvalueb038;
                    self.l_rcvalueb053                    := l_rcvalueb053;
                    self.l_rcvalueb052                    := l_rcvalueb052;
                    self.l_rcvalueb055                    := l_rcvalueb055;
                    self.l_rcvalueb057                    := l_rcvalueb057;
                    self.l_rcvaluebf108                   := l_rcvaluebf108;
                    self.l_final_score                    := l_final_score;
                    self.base                             := base;
                    self.pts                              := pts;
                    self.lgt                              := lgt;
                    self.bus_mod_final_lgt                := bus_mod_final_lgt;
                    self._sbom1601_0_0                    := _sbom1601_0_0;
                    self.l_rc1                            := l_rc1;
                    self.l_rc2                            := l_rc2;
                    self.l_rc3                            := l_rc3;
                    self.l_rc4                            := l_rc4;
                    self.l_rc5                            := l_rc5;
                    self.l_rc6                            := l_rc6;
                    self.l_rc7                            := l_rc7;
                    self.l_rc8                            := l_rc8;
                    self.l_rc9                            := l_rc9;
                    self.l_rc10                           := l_rc10;
                    self.l_rc11                           := l_rc11;
                    self.l_rc12                           := l_rc12;
                    self.l_rc13                           := l_rc13;
                    self.l_rc14                           := l_rc14;
                    self.l_rc15                           := l_rc15;
                    self.l_rc16                           := l_rc16;
                    self.l_rc17                           := l_rc17;
                    self.l_rc18                           := l_rc18;
                    self.l_rc19                           := l_rc19;
                    self.l_rc20                           := l_rc20;
                    self.l_rc21                           := l_rc21;
                    self.l_rc22                           := l_rc22;
                    self.l_rc23                           := l_rc23;
                    self.l_rc24                           := l_rc24;
                    self.l_rc25                           := l_rc25;
                    self.l_rc26                           := l_rc26;
                    self.l_rc27                           := l_rc27;
                    self.l_rc28                           := l_rc28;
                    self.l_rc29                           := l_rc29;
                    self.l_rc30                           := l_rc30;
                    self.l_rc31                           := l_rc31;
                    self.l_rc32                           := l_rc32;
                    self.l_rc33                           := l_rc33;
                    self.l_rc34                           := l_rc34;
                    self.l_rc35                           := l_rc35;
                    self.l_rc36                           := l_rc36;
                    self.l_rc37                           := l_rc37;
                    self.l_rc38                           := l_rc38;
                    self.l_rc39                           := l_rc39;
                    self.l_rc40                           := l_rc40;
                    self.l_rc41                           := l_rc41;
                    self.l_rc42                           := l_rc42;
                    self.l_rc43                           := l_rc43;
                    self.l_rc44                           := l_rc44;
                    self.l_rc45                           := l_rc45;
                    self.l_rc46                           := l_rc46;
                    self.l_rc47                           := l_rc47;
                    self.l_rc48                           := l_rc48;
                    self.l_rc49                           := l_rc49;
                    self.l_rc50                           := l_rc50;
                    self.s_rc1                            := s_rc1;
                    self.s_rc2                            := s_rc2;
                    self.s_rc3                            := s_rc3;
                    self.s_rc4                            := s_rc4;
                    self.s_rc5                            := s_rc5;
                    self.s_rc6                            := s_rc6;
                    self.s_rc7                            := s_rc7;
                    self.s_rc8                            := s_rc8;
                    self.s_rc9                            := s_rc9;
                    self.s_rc10                           := s_rc10;
                    self.s_rc11                           := s_rc11;
                    self.s_rc12                           := s_rc12;
                    self.s_rc13                           := s_rc13;
                    self.s_rc14                           := s_rc14;
                    self.s_rc15                           := s_rc15;
                    self.s_rc16                           := s_rc16;
                    self.s_rc17                           := s_rc17;
                    self.s_rc18                           := s_rc18;
                    self.s_rc19                           := s_rc19;
                    self.s_rc20                           := s_rc20;
                    self.s_rc21                           := s_rc21;
                    self.s_rc22                           := s_rc22;
                    self.s_rc23                           := s_rc23;
                    self.s_rc24                           := s_rc24;
                    self.s_rc25                           := s_rc25;
                    self.s_rc26                           := s_rc26;
                    self.s_rc27                           := s_rc27;
                    self.s_rc28                           := s_rc28;
                    self.s_rc29                           := s_rc29;
                    self.s_rc30                           := s_rc30;
                    self.s_rc31                           := s_rc31;
                    self.s_rc32                           := s_rc32;
                    self.s_rc33                           := s_rc33;
                    self.s_rc34                           := s_rc34;
                    self.s_rc35                           := s_rc35;
                    self.s_rc36                           := s_rc36;
                    self.s_rc37                           := s_rc37;
                    self.s_rc38                           := s_rc38;
                    self.s_rc39                           := s_rc39;
                    self.s_rc40                           := s_rc40;
                    self.s_rc41                           := s_rc41;
                    self.s_rc42                           := s_rc42;
                    self.s_rc43                           := s_rc43;
                    self.s_rc44                           := s_rc44;
                    self.s_rc45                           := s_rc45;
                    self.s_rc46                           := s_rc46;
                    self.s_rc47                           := s_rc47;
                    self.s_rc48                           := s_rc48;
                    self.s_rc49                           := s_rc49;
                    self.s_rc50                           := s_rc50;
                    self.bus_mod_rc16                     := bus_mod_rc16;
                    self.bus_mod_rc42                     := bus_mod_rc42;
                    self.bus_mod_rc8                      := bus_mod_rc8;
                    self.bus_mod_rc29                     := bus_mod_rc29;
                    self.bus_mod_rc44                     := bus_mod_rc44;
                    self.bus_mod_rc3                      := bus_mod_rc3;
                    self.bus_mod_rc45                     := bus_mod_rc45;
                    self.bus_mod_rc17                     := bus_mod_rc17;
                    self.bus_mod_rc21                     := bus_mod_rc21;
                    self.bus_mod_rc22                     := bus_mod_rc22;
                    self.bus_mod_rc34                     := bus_mod_rc34;
                    self.bus_mod_rc9                      := bus_mod_rc9;
                    self.bus_mod_rc23                     := bus_mod_rc23;
                    self.bus_mod_rc2                      := bus_mod_rc2;
                    self.bus_mod_rc36                     := bus_mod_rc36;
                    self.bus_mod_rc35                     := bus_mod_rc35;
                    self.bus_mod_rc50                     := bus_mod_rc50;
                    self.bus_mod_rc10                     := bus_mod_rc10;
                    self.bus_mod_rc6                      := bus_mod_rc6;
                    self.bus_mod_rc26                     := bus_mod_rc26;
                    self.bus_mod_rc25                     := bus_mod_rc25;
                    self.bus_mod_rc48                     := bus_mod_rc48;
                    self.bus_mod_rc40                     := bus_mod_rc40;
                    self.bus_mod_rc28                     := bus_mod_rc28;
                    self.bus_mod_rc4                      := bus_mod_rc4;
                    self.bus_mod_rc33                     := bus_mod_rc33;
                    self.bus_mod_rc13                     := bus_mod_rc13;
                    self.bus_mod_rc41                     := bus_mod_rc41;
                    self.bus_mod_rc43                     := bus_mod_rc43;
                    self.bus_mod_rc31                     := bus_mod_rc31;
                    self.bus_mod_rc27                     := bus_mod_rc27;
                    self.bus_mod_rc37                     := bus_mod_rc37;
                    self.bus_mod_rc49                     := bus_mod_rc49;
                    self.sbom1601_0_0                     := sbom1601_0_0;
                    self.bus_mod_rc39                     := bus_mod_rc39;
                    self.bus_mod_rc1                      := bus_mod_rc1;
                    self.bus_mod_rc32                     := bus_mod_rc32;
                    self.bus_mod_rc46                     := bus_mod_rc46;
                    self.bus_mod_rc12                     := bus_mod_rc12;
                    self.bus_mod_rc47                     := bus_mod_rc47;
                    self.bus_mod_rc30                     := bus_mod_rc30;
                    self.bus_mod_rc11                     := bus_mod_rc11;
                    self.bus_mod_rc20                     := bus_mod_rc20;
                    self.bus_mod_rc18                     := bus_mod_rc18;
                    self.bus_mod_rc5                      := bus_mod_rc5;
                    self.bus_mod_rc7                      := bus_mod_rc7;
                    self.bus_mod_rc24                     := bus_mod_rc24;
                    self.bus_mod_rc38                     := bus_mod_rc38;
                    self.bus_mod_rc19                     := bus_mod_rc19;
                    self.bus_mod_rc14                     := bus_mod_rc14;
                    self.bus_mod_rc15                     := bus_mod_rc15;
                    self.sbom_rc2                         := sbom_rc2;
                    self.sbom_rc1                         := sbom_rc1;
                    self.sbom_rc4                         := sbom_rc4;
                    self.sbom_rc3                         := sbom_rc3;

										SELF.busShell := le;
	#else
		SELF.ri := PROJECT(reasonCodes, TRANSFORM(Risk_Indicators.Layout_Desc,
																							SELF.hri := LEFT.hri,
																							SELF.desc := Risk_Indicators.getHRIDesc(LEFT.hri)));
		SELF.score := (STRING3)sbom1601_0_0;
		SELF.seq := le.input_echo.seq;
	#end
	END;

		model := PROJECT(BusShell, doModel(LEFT));
	RETURN(model);
END;

IMPORT Models, Risk_Indicators, STD, Business_Risk_BIP;

EXPORT SLBO1702_0_2 (GROUPED DATASET(Business_Risk_BIP.Layouts.Shell) busShell) := FUNCTION

	MODEL_DEBUG := FALSE;

	#if(MODEL_DEBUG)
		Layout_Debug := RECORD
      INTEGER sysdate                          	;
			INTEGER _ver_src_id_br_pos               	;
			BOOLEAN _ver_src_id__br                  	;
			string _ver_src_id_fdate_br             	;
			BOOLEAN _ver_src_id_fdate_br2            	;
			REAL mth__ver_src_id_fdate_br         	;
			INTEGER _ver_src_id_bm_pos               	;
			BOOLEAN _ver_src_id__bm                  	;
			INTEGER _ver_src_id_i_pos                	;
			boolean _ver_src_id__i                   	;
			INTEGER _ver_src_id_p_pos                	;
			BOOLEAN _ver_src_id__p                   	;
			string _ver_src_id_ldate_p              	;
			BOOLEAN _ver_src_id_ldate_p2             	;
			INTEGER mth__ver_src_id_ldate_p          	;
			INTEGER _ver_src_id_v2_pos               	;
			integer _ver_src_id_fdate_v22            	;
			REAL mth__ver_src_id_fdate_v2         	;
			integer _ver_src_id_ldate_v22            	;
			REAL mth__ver_src_id_ldate_v2         	;
			INTEGER _ver_src_id_ut_pos               	;
			BOOLEAN _ver_src_id__ut                  	;
			INTEGER _ver_src_id_gb_pos               	;
			string _ver_src_id_fdate_gb             	;
			INTEGER _ver_src_id_fdate_gb2            	;
			REAL mth__ver_src_id_fdate_gb         	;
			string _ver_src_id_ldate_gb             	;
			INTEGER _ver_src_id_ldate_gb2            	;
			REAL mth__ver_src_id_ldate_gb         	;
			REAL vs_gb_id_mth_fseen               	;
			REAL vs_gb_id_mth_lseen               	;
			INTEGER vs_ver_src_id__ut                	;
			INTEGER vs_ver_src_id__bm                	;
			INTEGER vs_ver_src_id__i                 	;
			REAL vs_v2_id_mth_fseen               	;
			REAL vs_v2_id_mth_lseen               	;
			REAL b_vs_gb_id_mth_fseen_w           	;
			REAL b_vs_gb_id_mth_lseen_w           	;
			REAL b_vs_ver_src_id__ut_w            	;
			REAL b_vs_ver_src_id__bm_w            	;
			REAL b_vs_ver_src_id__i_w             	;
			REAL b_vs_v2_id_mth_fseen_w           	;
			REAL b_vs_v2_id_mth_lseen_w           	;
			REAL bv_bus_only_source_profile       	;
			BOOLEAN truebiz_ln                       	;
			INTEGER bx_addr_assessed_value           	;
			real bv_assoc_derog_pct               	;
			INTEGER _lien_filed_lastseen             	;
			INTEGER bv_lien_filed_mth_ls             	;
			INTEGER bv_sos_current_standing          	;
			INTEGER _sos_agent_change_lastseen       	;
			INTEGER bv_sos_mth_agent_change          	;
			INTEGER bv_assoc_derog_type_count        	;
			INTEGER bx_addr_lres                     	;
			BOOLEAN source_ar                        	;
			BOOLEAN source_ba                        	;
			BOOLEAN source_bm                        	;
			BOOLEAN source_c                         	;
			BOOLEAN source_cs                        	;
			BOOLEAN source_dn                        	;
			BOOLEAN source_ef                        	;
			BOOLEAN source_ft                        	;
			BOOLEAN source_i                         	;
			BOOLEAN source_ia                        	;
			BOOLEAN source_in                        	;
			BOOLEAN source_l2                        	;
			BOOLEAN source_p                         	;
			BOOLEAN source_ut                        	;
			BOOLEAN source_v2                        	;
			BOOLEAN source_wk                        	;
			INTEGER num_pos_sources                  	;
			INTEGER num_neg_sources                  	;
			REAL bv_ver_src_derog_ratio           	;
			REAL bv_ver_src_id_mth_since_fs       	;
			integer _judg_filed_lastseen             	;
			INTEGER bv_judg_filed_mth_ls             	;
			INTEGER bv_mth_ver_src_br_fs             	;
			INTEGER bv_mth_ver_src_p_ls              	;
			INTEGER bv_lien_ft_count                 	;
			INTEGER bv_assoc_judg_tot                	;
			integer _judg_filed_firstseen            	;
			INTEGER bv_judg_filed_mth_fs             	;
			INTEGER bv_lien_total_amount             	;
			INTEGER bv_assoc_felony_tot              	;
			INTEGER bv_ver_src_id_activity12         	;
			integer _ucc_firstseen                   	;
			integer bv_ucc_mth_fs                    	;
			REAL bo_v01_w                         	;
			string bo_aa_code_01                    	;
			REAL bo_aa_dist_01                    	;
			REAL bo_v02_w                         	;
			string bo_aa_code_02                    	;
			REAL bo_aa_dist_02                    	;
			REAL bo_v03_w                         	;
			string bo_aa_code_03                    	;
			REAL bo_aa_dist_03                    	;
			REAL bo_v04_w                         	;
			string bo_aa_code_04                    	;
			REAL bo_aa_dist_04                    	;
			REAL bo_v05_w                         	;
			string bo_aa_code_05                    	;
			REAL bo_aa_dist_05                    	;
			REAL bo_v06_w                         	;
			string bo_aa_code_06                    	;
			REAL bo_aa_dist_06                    	;
			REAL bo_v07_w                         	;
			string bo_aa_code_07                    	;
			REAL bo_aa_dist_07                    	;
			REAL bo_v08_w                         	;
			string bo_aa_code_08                    	;
			REAL bo_aa_dist_08                    	;
			REAL bo_v09_w                         	;
			string bo_aa_code_09                    	;
			REAL bo_aa_dist_09                    	;
			REAL bo_v10_w                         	;
			string bo_aa_code_10                    	;
			REAL bo_aa_dist_10                    	;
			REAL bo_v11_w                         	;
			string bo_aa_code_11                    	;
			REAL bo_aa_dist_11                    	;
			REAL bo_v12_w                         	;
			string bo_aa_code_12                    	;
			REAL bo_aa_dist_12                    	;
			REAL bo_v13_w                         	;
			string bo_aa_code_13                    	;
			REAL bo_aa_dist_13                    	;
			REAL bo_v14_w                         	;
			string bo_aa_code_14                    	;
			REAL bo_aa_dist_14                    	;
			REAL bo_v15_w                         	;
			string bo_aa_code_15                    	;
			REAL bo_aa_dist_15                    	;
			REAL bo_v16_w                         	;
			string bo_aa_code_16                    	;
			REAL bo_aa_dist_16                    	;
			REAL bo_v17_w                         	;
			string bo_aa_code_17                    	;
			REAL bo_aa_dist_17                    	;
			REAL bo_v18_w                         	;
			string bo_aa_code_18                    	;
			REAL bo_aa_dist_18                    	;
			REAL bo_v19_w                         	;
			string bo_aa_code_19                    	;
			REAL bo_aa_dist_19                    	;
			REAL bo_rcvalueb037                   	;
			REAL bo_rcvalueb069                   	;
			REAL bo_rcvalueb026                   	;
			REAL bo_rcvalueb034                   	;
			REAL bo_rcvalueb052                   	;
			REAL bo_rcvalueb031                   	;
			REAL bo_rcvalueb036                   	;
			REAL bo_rcvalueb017                   	;
			REAL bo_rcvalueb063                   	;
			REAL bo_rcvalueb035                   	;
			REAL bo_rcvalueb075                   	;
			REAL bo_rcvalueb074                   	;
			REAL bo_rcvalueb079                   	;
			REAL bo_rcvalueb078                   	;
			REAL bo_rcvalueb076                   	;
			REAL bo_rcvalueb066                   	;
			REAL bo_rcvalueb056                   	;
			REAL bo_rcvalueb059                   	;
			REAL bo_rcvalueb070                   	;
			REAL bo_lgt                           	;
			INTEGER base                             	;
			INTEGER pts                              	;
			REAL lgt                              	;
			INTEGER slbo1702_0_2                     	;
			string finalbo_rc1                      	;
			string finalbo_rc2                      	;
			string finalbo_rc3                      	;
			string finalbo_rc4                      	;
			string finalbo_rc5                      	;
			string finalbo_rc6                      	;
			string finalbo_rc7                      	;
			string finalbo_rc8                      	;
			string finalbo_rc9                      	;
			string finalbo_rc10                     	;
			string finalbo_rc11                     	;
			string finalbo_rc12                     	;
			string finalbo_rc13                     	;
			string finalbo_rc14                     	;
			string finalbo_rc15                     	;
			string finalbo_rc16                     	;
			string finalbo_rc17                     	;
			string finalbo_rc18                     	;
			string finalbo_rc19                     	;
			string finalbo_rc20                     	;
			string finalbo_rc21                     	;
			string finalbo_rc22                     	;
			string finalbo_rc23                     	;
			string finalbo_rc24                     	;
			string finalbo_rc25                     	;
			string finalbo_rc26                     	;
			string finalbo_rc27                     	;
			string finalbo_rc28                     	;
			string finalbo_rc29                     	;
			string finalbo_rc30                     	;
			string finalbo_rc31                     	;
			string finalbo_rc32                     	;
			string finalbo_rc33                     	;
			string finalbo_rc34                     	;
			string finalbo_rc35                     	;
			string finalbo_rc36                     	;
			string finalbo_rc37                     	;
			string finalbo_rc38                     	;
			string finalbo_rc39                     	;
			string finalbo_rc40                     	;
			string finalbo_rc41                     	;
			string finalbo_rc42                     	;
			string finalbo_rc43                     	;
			string finalbo_rc44                     	;
			string finalbo_rc45                     	;
			string finalbo_rc46                     	;
			string finalbo_rc47                     	;
			string finalbo_rc48                     	;
			string finalbo_rc49                     	;
			string finalbo_rc50                     	;
			string bo_rc28                          	;
			string bo_rc27                          	;
			string bo_rc25                          	;
			string bo_rc8                           	;
			string bo_rc29                          	;
			string bo_rc23                          	;
			string bo_rc15                          	;
			string bo_rc16                          	;
			string bo_rc12                          	;
			string bo_rc41                          	;
			string bo_rc30                          	;
			string bo_rc36                          	;
			string bo_rc18                          	;
			string bo_rc19                          	;
			string bo_rc31                          	;
			string bo_rc3                           	;
			string bo_rc34                          	;
			string bo_rc44                          	;
			string bo_rc50                          	;
			string bo_rc2                           	;
			string bo_rc26                          	;
			string bo_rc33                          	;
			string bo_rc21                          	;
			string bo_rc22                          	;
			string bo_rc43                          	;
			string bo_rc48                          	;
			string bo_rc1                           	;
			string bo_rc46                          	;
			string bo_rc40                          	;
			string bo_rc10                          	;
			string bo_rc4                           	;
			string bo_rc42                          	;
			string bo_rc20                          	;
			string bo_rc24                          	;
			string bo_rc11                          	;
			string bo_rc14                          	;
			string bo_rc32                          	;
			string bo_rc35                          	;
			string bo_rc13                          	;
			string bo_rc49                          	;
			string bo_rc47                          	;
			string bo_rc9                           	;
			string bo_rc7                           	;
			string bo_rc37                          	;
			string bo_rc6                           	;
			string bo_rc38                          	;
			string bo_rc17                          	;
			string bo_rc39                          	;
			string bo_rc45                          	;
			string bo_rc5                           	;
			string slbo_rc1                         	;
			string slbo_rc3                         	;
			string slbo_rc2                         	;
			string slbo_rc4                         	; 

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
			

	id_seleid                        := le.Verification.inputidmatchseleid;
	pop_bus_addr                     := le.Input.InputCheckBusAddr;
	ver_src_id_mth_since_fs          := le.Business_Activity.SourceBusinessRecordTimeOldestID;
	ver_src_id_count                 := le.Verification.SourceCountID;
	ver_src_id_activity12            := le.Business_Activity.BusinessActivity12MonthID;
	ver_src_id_list                  := Business_Risk_BIP.Common.truncate_list(le.Verification.sourcelistID, MaxSASLength);
	ver_src_id_firstseen_list        := Business_Risk_BIP.Common.truncate_list(le.Verification.sourcedatefirstseenlistID, MaxSASLength);
	ver_src_id_lastseen_list         := Business_Risk_BIP.Common.truncate_list(le.Verification.sourcedatelastseenlistID, MaxSASLength);
	ver_src_list                     := Business_Risk_BIP.Common.truncate_list(le.Verification.sourcelist, MaxSASLength);
	ver_addr_src_firstseen_list      := Business_Risk_BIP.Common.truncate_list(le.Verification.AddrVerificationDateFirstSeenList, MaxSASLength);
	ver_addr_src_lastseen_list       := Business_Risk_BIP.Common.truncate_list(le.Verification.AddrVerificationDateLastSeenList, MaxSASLength);
	addr_input_lres                  := le.Verification.InputAddrLengthOfResidence;
	addr_input_assessed_value        := le.Input_Characteristics.InputAddrAssessedTotal;
	assoc_count                      := le.Associates.AssociateCount;
	assoc_felony_total               := le.Associates.AssociateFelonyCount;
	assoc_felony_count               := le.Associates.AssociateCountWithFelony;
	assoc_bankruptcy_count12         := le.Associates.AssociateBankrupt1YearCount;
	assoc_lien_count                 := le.Associates.AssociateCountWithLien;
	assoc_judg_total                 := le.Associates.AssociateJudgmentCount;
	assoc_judg_count                 := le.Associates.AssociateCountWithJudgment;
	sos_inc_filing_count             := le.SOS.SOSIncorporationCount;
	sos_standing                     := le.SOS.SOSStanding;
	sos_agent_change_lastseen        := le.SOS.SOSRegisterAgentChangeDateLastSeen;
	lien_filed_count                 := le.Lien_And_Judgment.LienCount;
	lien_total_amount                := le.Lien_And_Judgment.LienDollarTotal;
	lien_filed_lastseen              := le.Lien_And_Judgment.LienFiledDateLastSeen;
	lien_filed_ft_ct                 := le.Lien_And_Judgment.LienFiledFTCount;
	judg_filed_firstseen             := le.Lien_And_Judgment.JudgFiledDateFirstSeen;
	judg_filed_lastseen              := le.Lien_And_Judgment.JudgFiledDateLastSeen;
	ucc_firstseen                    := le.Public_Record.UCCInitialFilingDateFirstSeen;
	historydatetime                 := le.Input_Echo.historydatetime;
	historydate                     := le.Input_Echo.historydate;
	
	/* ***********************************************************
	 *                    Generated ECL                          *
	 ************************************************************* */

INTEGER contains_i( string haystack, string needle ) := (INTEGER)(StringLib.StringFind(haystack, needle, 1) > 0);

NULL := __common__( -999999999 ) ;

sysdate      := __common__( common.sas_date(if(historydate=999999, (string)std.date.today(), (string6)historydate+'01')) ) ;

_ver_src_id_br_pos := __common__( Models.Common.findw_cpp(ver_src_id_list, 'BR' , '  ,', 'ie') ) ;

_ver_src_id__br := __common__( _ver_src_id_br_pos > 0 ) ;

_ver_src_id_fdate_br := __common__( if(_ver_src_id_br_pos > 0, Models.Common.getw(ver_src_id_firstseen_list, _ver_src_id_br_pos), '0') ) ;

_ver_src_id_fdate_br2 := __common__( common.sas_date((string)(_ver_src_id_fdate_br)) ) ;

mth__ver_src_id_fdate_br := __common__( roundup(if(min(sysdate, _ver_src_id_fdate_br2) = NULL, NULL, (sysdate - _ver_src_id_fdate_br2) / 30.5)) ) ;

_ver_src_id_bm_pos := __common__( Models.Common.findw_cpp(ver_src_id_list, 'BM' , '  ,', 'ie') ) ;

_ver_src_id__bm := __common__( _ver_src_id_bm_pos > 0 ) ;

_ver_src_id_i_pos := __common__( Models.Common.findw_cpp(ver_src_id_list, 'I' , '  ,', 'ie') ) ;

_ver_src_id__i := __common__( _ver_src_id_i_pos > 0 ) ;

_ver_src_id_p_pos := __common__( Models.Common.findw_cpp(ver_src_id_list, 'P' , '  ,', 'ie') ) ;

_ver_src_id__p := __common__( _ver_src_id_p_pos > 0 ) ;

_ver_src_id_ldate_p := __common__( if(_ver_src_id_p_pos > 0, Models.Common.getw(ver_src_id_lastseen_list, _ver_src_id_p_pos), '0') ) ;

_ver_src_id_ldate_p2 := __common__( common.sas_date((string)(_ver_src_id_ldate_p)) ) ;

mth__ver_src_id_ldate_p := __common__( if(min(sysdate, _ver_src_id_ldate_p2) = NULL, NULL, roundup((sysdate - _ver_src_id_ldate_p2) / 30.5)) ) ;

_ver_src_id_v2_pos := __common__( Models.Common.findw_cpp(ver_src_id_list, 'V2' , '  ,', 'ie') ) ;

_ver_src_id_fdate_v2_1 := __common__( if(_ver_src_id_v2_pos > 0, Models.Common.getw(ver_src_id_firstseen_list, _ver_src_id_v2_pos), '0') ) ;

_ver_src_id_fdate_v22 := __common__( common.sas_date((string)(_ver_src_id_fdate_v2_1)) ) ;

mth__ver_src_id_fdate_v2 := __common__( if(min(sysdate, _ver_src_id_fdate_v22) = NULL, NULL, roundUP((sysdate - _ver_src_id_fdate_v22) / 30.5)) ) ;

_ver_src_id_ldate_v2_1 := __common__( if(_ver_src_id_v2_pos > 0, Models.Common.getw(ver_src_id_lastseen_list, _ver_src_id_v2_pos), '0') ) ;

_ver_src_id_ldate_v22 := __common__( common.sas_date((string)(_ver_src_id_ldate_v2_1)) ) ;

mth__ver_src_id_ldate_v2 := __common__( if(min(sysdate, _ver_src_id_ldate_v22) = NULL, NULL, roundup((sysdate - _ver_src_id_ldate_v22) / 30.5)) ) ;

_ver_src_id_ut_pos := __common__( Models.Common.findw_cpp(ver_src_id_list, 'UT' , '  ,', 'ie') ) ;

_ver_src_id__ut := __common__( _ver_src_id_ut_pos > 0 ) ;

_ver_src_id_gb_pos := __common__( Models.Common.findw_cpp(ver_src_id_list, 'GB' , '  ,', 'ie') ) ;

_ver_src_id_fdate_gb := __common__( if(_ver_src_id_gb_pos > 0, Models.Common.getw(ver_src_id_firstseen_list, _ver_src_id_gb_pos), '0') ) ;

_ver_src_id_fdate_gb2 := __common__( common.sas_date((string)(_ver_src_id_fdate_gb)) ) ;

mth__ver_src_id_fdate_gb := __common__( if(min(sysdate, _ver_src_id_fdate_gb2) = NULL, NULL, roundup((sysdate - _ver_src_id_fdate_gb2) / 30.5)) ) ;

_ver_src_id_ldate_gb := __common__( if(_ver_src_id_gb_pos > 0, Models.Common.getw(ver_src_id_lastseen_list, _ver_src_id_gb_pos), '0') ) ;

_ver_src_id_ldate_gb2 := __common__( common.sas_date((string)(_ver_src_id_ldate_gb)) ) ;

mth__ver_src_id_ldate_gb := __common__( if(min(sysdate, _ver_src_id_ldate_gb2) = NULL, NULL, roundUp((sysdate - _ver_src_id_ldate_gb2) / 30.5)) ) ;

vs_gb_id_mth_fseen := __common__( mth__ver_src_id_fdate_gb ) ;

vs_gb_id_mth_lseen := __common__( mth__ver_src_id_ldate_gb ) ;

vs_ver_src_id__ut := __common__( (INTEGER) _ver_src_id__ut ) ;

vs_ver_src_id__bm := __common__( (INTEGER) _ver_src_id__bm ) ;

vs_ver_src_id__i := __common__( (INTEGER) _ver_src_id__i ) ;

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

bx_addr_assessed_value := __common__( if(not(truebiz_ln) or (integer)pop_bus_addr = 0, NULL, (integer) addr_input_assessed_value) ) ;

bv_assoc_derog_pct := __common__( map(
    not(truebiz_ln)  => NULL,
    (integer)assoc_count <= 0 => -1,
    max((integer)assoc_felony_count, (integer)assoc_bankruptcy_count12, (integer)assoc_lien_count, (integer)assoc_judg_count) / (integer)assoc_count) ) ;

_lien_filed_lastseen := __common__( common.sas_date((string)(lien_filed_lastseen)) ) ;

bv_lien_filed_mth_ls := __common__( map(
    not(truebiz_ln)             => NULL,
    _lien_filed_lastseen = NULL => -1,
                                   if ((sysdate - _lien_filed_lastseen) / (365.25 / 12) >= 0, roundup((sysdate - _lien_filed_lastseen) / (365.25 / 12)), truncate((sysdate - _lien_filed_lastseen) / (365.25 / 12)))) ) ;

bv_sos_current_standing := __common__( map(
    not(truebiz_ln)          => NULL,
    (integer)sos_inc_filing_count = 0 => -1,
                              (integer) sos_standing) ) ;

_sos_agent_change_lastseen := __common__( common.sas_date((string)(sos_agent_change_lastseen)) ) ;

bv_sos_mth_agent_change := __common__( map(
    not(truebiz_ln)                   => NULL,
    _sos_agent_change_lastseen = NULL => -1,
    if ((sysdate - _sos_agent_change_lastseen) / (365.25 / 12) >= 0, roundup((sysdate - _sos_agent_change_lastseen) / (365.25 / 12)), truncate((sysdate - _sos_agent_change_lastseen) / (365.25 / 12)))) ) ;

bv_assoc_derog_type_count := __common__( map(
    not(truebiz_ln) => NULL,
    (integer)assoc_count = 0 => -1,
					sum((integer)((integer)assoc_felony_count > 0),
						(integer)((integer)assoc_bankruptcy_count12 > 0), 
						(integer)((integer)assoc_lien_count > 0), 
						(integer)((integer)assoc_judg_count > 0))
						) ) ;

bx_addr_lres := __common__( map(
    not(truebiz_ln) or (integer)pop_bus_addr = 0                                                                       => NULL,
    trim((string)ver_addr_src_firstseen_list, ALL) = '' or trim((string)ver_addr_src_lastseen_list, ALL) = '' => -1,
    (integer) addr_input_lres) ) ;

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

num_pos_sources := __common__( if(max((integer)source_ar, (integer)source_bm, (integer)source_c, (integer)source_cs, (integer)source_dn, (integer)source_ef, (integer)source_ft, (integer)source_i, (integer)source_ia, (integer)source_in, (integer)source_p, (integer)source_v2, (integer)source_wk) = NULL, NULL, sum((integer)source_ar, (integer)source_bm, (integer)source_c, (integer)source_cs, (integer)source_dn, (integer)source_ef, (integer)source_ft, (integer)source_i, (integer)source_ia, (integer)source_in, (integer)source_p, (integer)source_v2, (integer)source_wk)) ) ;

num_neg_sources := __common__( if(max((integer)source_ba, (integer)source_l2, (integer)source_ut) = NULL, NULL, sum((integer)source_ba, (integer)source_l2, (integer)source_ut)) ) ;

bv_ver_src_derog_ratio := __common__( map(
    not(truebiz_ln)                                                                                                                                                 => NULL,
    ver_src_list = ''                                                                                                                                             => -1,
    if(max(num_pos_sources, num_neg_sources) = NULL, NULL, sum(if(num_pos_sources = NULL, 0, num_pos_sources), if(num_neg_sources = NULL, 0, num_neg_sources))) = 0 => -2,
    num_neg_sources > 0                                                                                                                                             => round(num_neg_sources / if(max(num_pos_sources, num_neg_sources) = NULL, NULL, sum(if(num_pos_sources = NULL, 0, num_pos_sources), if(num_neg_sources = NULL, 0, num_neg_sources)))/.1)*.1,
                                                                                                                                                                       100 + num_pos_sources) ) ;

bv_ver_src_id_mth_since_fs := __common__( if(not(truebiz_ln), NULL, (REAL) ver_src_id_mth_since_fs) ) ;

_judg_filed_lastseen:= __common__( common.sas_date((string)(judg_filed_lastseen)) ) ;

bv_judg_filed_mth_ls := __common__( map(
    not(truebiz_ln)             => NULL,
     _judg_filed_lastseen = NULL => -1,
     if ((sysdate - _judg_filed_lastseen) / (365.25 / 12) >= 0, roundup((sysdate - (integer) _judg_filed_lastseen) / (365.25 / 12)), truncate((sysdate - _judg_filed_lastseen) / (365.25 / 12)))) ) ;

bv_mth_ver_src_br_fs := __common__( if(not(_ver_src_id__br), -1, mth__ver_src_id_fdate_br) ) ;

bv_mth_ver_src_p_ls := __common__( if(not(_ver_src_id__p), -1, mth__ver_src_id_ldate_p) ) ;

bv_lien_ft_count := __common__( if(not(truebiz_ln), NULL, (integer) lien_filed_FT_ct) ) ;

bv_assoc_judg_tot := __common__( map(
    not(truebiz_ln) => NULL,
    (integer) assoc_count = 0 => -1,
    (integer) assoc_judg_total) ) ;
_judg_filed_firstseen := __common__( common.sas_date((string)(judg_filed_firstseen)) ) ;

bv_judg_filed_mth_fs := __common__( map(
    not(truebiz_ln)              => NULL,
     _judg_filed_firstseen = NULL => -1,
     if ((sysdate - _judg_filed_firstseen) / (365.25 / 12) >= 0, roundup((sysdate - _judg_filed_firstseen) / (365.25 / 12)), truncate((sysdate - _judg_filed_firstseen) / (365.25 / 12)))) ) ;

bv_lien_total_amount := __common__( map(
    not(truebiz_ln)       => NULL,
    (integer) lien_filed_count <= 0 => -1,
    (integer) lien_total_amount) ) ;

bv_assoc_felony_tot := __common__( map(
    not(truebiz_ln) => NULL,
    (integer) assoc_count = 0 => -1,
    (integer) assoc_felony_total) ) ;

bv_ver_src_id_activity12 := __common__( if(not(truebiz_ln), NULL, (integer) ver_src_id_activity12) ) ;

_ucc_firstseen := __common__( common.sas_date((string)(ucc_firstseen)) ) ;

bv_ucc_mth_fs := __common__( map(
    not(truebiz_ln)       => NULL,
    _ucc_firstseen = NULL => -1,
     if ((sysdate - _ucc_firstseen) / (365.25 / 12) >= 0, roundup((sysdate - _ucc_firstseen) / (365.25 / 12)), truncate((sysdate - _ucc_firstseen) / (365.25 / 12)))) ) ;

bo_v01_w := __common__( map(
    bv_bus_only_source_profile = NULL           => 0,
    bv_bus_only_source_profile = -1             => 0,
    bv_bus_only_source_profile <= -3.421871352  => -0.883303646356183,
    bv_bus_only_source_profile <= -2.719242807  => -0.459323647151645,
    bv_bus_only_source_profile <= -2.255608591  => -0.0525406023330205,
    bv_bus_only_source_profile <= -1.873129815  => 0.155551154086485,
    bv_bus_only_source_profile <= -1.517124165  => 0.481454751704426,
    bv_bus_only_source_profile <= -1.2166780885 => 0.700797112906347,
                                                   1.0373444519994) ) ;

bo_aa_code_01 := __common__( map(
    bo_v01_w = -0.883303646356183               => '     ',
    bv_bus_only_source_profile = NULL           => 'B031',
    bv_bus_only_source_profile = -1             => 'B034',
    bv_bus_only_source_profile <= -3.421871352  => 'B034',
    bv_bus_only_source_profile <= -2.719242807  => 'B034',
    bv_bus_only_source_profile <= -2.255608591  => 'B034',
    bv_bus_only_source_profile <= -1.873129815  => 'B034',
    bv_bus_only_source_profile <= -1.517124165  => 'B034',
    bv_bus_only_source_profile <= -1.2166780885 => 'B034',
                                                   'B034') ) ;

bo_aa_dist_01 := __common__( 0 - bo_v01_w ) ;

bo_v02_w := __common__( map(
    bx_addr_assessed_value = NULL    => 0,
    bx_addr_assessed_value = -1      => 0,
    bx_addr_assessed_value <= 0      => 0.159634991565604,
    bx_addr_assessed_value <= 129040 => 0.285973775875255,
    bx_addr_assessed_value <= 192784 => 0.143621599265048,
    bx_addr_assessed_value <= 288288 => -0.0602411164401078,
    bx_addr_assessed_value <= 325088 => -0.140630328837249,
    bx_addr_assessed_value <= 393376 => -0.190557215667258,
                                        -0.21755059271406) ) ;

bo_aa_code_02 := __common__( map(
    bo_v02_w = -0.21755059271406     => '     ',
    bx_addr_assessed_value = NULL    => 'B031',
    bx_addr_assessed_value = -1      => 'B069',
    bx_addr_assessed_value <= 0      => 'B069',
    bx_addr_assessed_value <= 129040 => 'B069',
    bx_addr_assessed_value <= 192784 => 'B069',
    bx_addr_assessed_value <= 288288 => 'B069',
    bx_addr_assessed_value <= 325088 => 'B069',
    bx_addr_assessed_value <= 393376 => 'B069',
                                        'B069') ) ;

bo_aa_dist_02 := __common__( 0 - bo_v02_w ) ;

bo_v03_w := __common__( map(
    bv_assoc_derog_pct = NULL           => 0,
    bv_assoc_derog_pct = -1             => 0.0313113020504159,
    bv_assoc_derog_pct <= 0             => -0.117636124752011,
    bv_assoc_derog_pct <= 0.2426470588  => -0.0154361747120441,
    bv_assoc_derog_pct <= 0.36038961035 => 0.25975269020661,
    bv_assoc_derog_pct <= 0.5857142857  => 0.36162618962571,
                                           0.523522162897031) ) ;

bo_aa_code_03 := __common__( map(
    bo_v03_w = -0.117636124752011       => '     ',
    bv_assoc_derog_pct = NULL           => 'B031',
    bv_assoc_derog_pct = -1             => 'B017',
    bv_assoc_derog_pct <= 0             => 'B026',
    bv_assoc_derog_pct <= 0.2426470588  => 'B026',
    bv_assoc_derog_pct <= 0.36038961035 => 'B026',
    bv_assoc_derog_pct <= 0.5857142857  => 'B026',
                                           'B026') ) ;

bo_aa_dist_03 := __common__( 0 - bo_v03_w ) ;

bo_v04_w := __common__( map(
    bv_lien_filed_mth_ls = NULL  => 0,
    bv_lien_filed_mth_ls = -1    => -0.0320289409869215,
    bv_lien_filed_mth_ls <= 6.5  => 0.771500654573043,
    bv_lien_filed_mth_ls <= 8.5  => 0.698844622071644,
    bv_lien_filed_mth_ls <= 30.5 => 0.427705185042728,
    bv_lien_filed_mth_ls <= 41.5 => 0.259640571882455,
                                    0.0266211412910996) ) ;

bo_aa_code_04 := __common__( map(
    bo_v04_w = -0.0320289409869215 => '     ',
    bv_lien_filed_mth_ls = NULL    => 'B031',
    bv_lien_filed_mth_ls = -1      => 'B078',
    bv_lien_filed_mth_ls <= 6.5    => 'B078',
    bv_lien_filed_mth_ls <= 8.5    => 'B078',
    bv_lien_filed_mth_ls <= 30.5   => 'B078',
    bv_lien_filed_mth_ls <= 41.5   => 'B063',
                                      'B063') ) ;

bo_aa_dist_04 := __common__( 0 - bo_v04_w ) ;

bo_v05_w := __common__( map(
    bv_sos_current_standing = NULL => 0,
    bv_sos_current_standing = -1   => -0.0412437810031956,
    bv_sos_current_standing <= 0   => 0,
    bv_sos_current_standing <= 1   => 0.878122294396212,
    bv_sos_current_standing <= 2.5 => 0.817227410641303,
                                      -0.0412437810031956) ) ;

bo_aa_code_05 := __common__( map(
    bo_v05_w = -0.0412437810031956 => '     ',
    bv_sos_current_standing = NULL => 'B031',
    bv_sos_current_standing = -1   => 'B034',
    bv_sos_current_standing <= 0   => 'B035',
    bv_sos_current_standing <= 1   => 'B059',
    bv_sos_current_standing <= 2.5 => 'B075',
                                      'B034') ) ;

bo_aa_dist_05 := __common__( 0 - bo_v05_w ) ;

bo_v06_w := __common__( map(
    bv_assoc_derog_type_count = NULL => 0,
    bv_assoc_derog_type_count = -1   => 0.0193896649204749,
    bv_assoc_derog_type_count <= 0.5 => -0.0728467004601743,
    bv_assoc_derog_type_count <= 1.5 => 0.197041801200879,
    bv_assoc_derog_type_count <= 2.5 => 0.328692399026065,
                                        0.465848472913132) ) ;

bo_aa_code_06 := __common__( map(
    bo_v06_w = -0.0728467004601743   => '     ',
    bv_assoc_derog_type_count = NULL => 'B031',
    bv_assoc_derog_type_count = -1   => 'B017',
    bv_assoc_derog_type_count <= 0.5 => 'B026',
    bv_assoc_derog_type_count <= 1.5 => 'B026',
    bv_assoc_derog_type_count <= 2.5 => 'B074',
                                        'B074') ) ;

bo_aa_dist_06 := __common__( 0 - bo_v06_w ) ;

bo_v07_w := __common__( map(
    bx_addr_lres = NULL   => 0,
    bx_addr_lres = -1     => 0.045689306885469,
    bx_addr_lres <= 11.5  => 0.151610855000195,
    bx_addr_lres <= 27.5  => 0.107218002376776,
    bx_addr_lres <= 55.5  => 0.0225033957970236,
    bx_addr_lres <= 92.5  => -0.0151982700477594,
    bx_addr_lres <= 135.5 => -0.0858350259297924,
    bx_addr_lres <= 204.5 => -0.107777041669411,
    bx_addr_lres <= 278.5 => -0.159935319903428,
                             -0.26559075828635) ) ;

bo_aa_code_07 := __common__( map(
    bo_v07_w = -0.26559075828635 => '     ',
    bx_addr_lres = NULL          => 'B031',
    bx_addr_lres = -1            => 'B031',
    bx_addr_lres <= 11.5         => 'B070',
    bx_addr_lres <= 27.5         => 'B070',
    bx_addr_lres <= 55.5         => 'B070',
    bx_addr_lres <= 92.5         => 'B070',
    bx_addr_lres <= 135.5        => 'B070',
    bx_addr_lres <= 204.5        => 'B070',
    bx_addr_lres <= 278.5        => 'B070',
                                    'B070') ) ;

bo_aa_dist_07 := __common__( 0 - bo_v07_w ) ;

bo_v08_w := __common__( map(
    bv_ver_src_derog_ratio = NULL   => 0,
    bv_ver_src_derog_ratio = -1     => 0.29975401859946,
    bv_ver_src_derog_ratio <= -1.5  => 0.0911487454448132,
    bv_ver_src_derog_ratio <= 0.25  => 0.0509545602019438,
    bv_ver_src_derog_ratio <= 0.35  => 0.142942429010894,
    bv_ver_src_derog_ratio <= 0.6   => 0.221127980249123,
    bv_ver_src_derog_ratio <= 51    => 0.311062657011764,
    bv_ver_src_derog_ratio <= 101.5 => -0.00722313426429199,
    bv_ver_src_derog_ratio <= 102.5 => -0.0584017121975249,
    bv_ver_src_derog_ratio <= 103.5 => -0.0960839974167672,
    bv_ver_src_derog_ratio <= 104.5 => -0.197780299664654,
                                       -0.239609244057438) ) ;

bo_aa_code_08 := __common__( map(
    bo_v08_w = -0.239609244057438   => '     ',
    bv_ver_src_derog_ratio = NULL   => 'B031',
    bv_ver_src_derog_ratio = -1     => 'B034',
    bv_ver_src_derog_ratio <= -1.5  => 'B034',
    bv_ver_src_derog_ratio <= 0.25  => 'B063',
    bv_ver_src_derog_ratio <= 0.35  => 'B063',
    bv_ver_src_derog_ratio <= 0.6   => 'B063',
    bv_ver_src_derog_ratio <= 51    => 'B063',
    bv_ver_src_derog_ratio <= 101.5 => 'B034',
    bv_ver_src_derog_ratio <= 102.5 => 'B034',
    bv_ver_src_derog_ratio <= 103.5 => 'B034',
    bv_ver_src_derog_ratio <= 104.5 => 'B034',
                                       'B034') ) ;

bo_aa_dist_08 := __common__( 0 - bo_v08_w ) ;

bo_v09_w := __common__( map(
    bv_ver_src_id_mth_since_fs = NULL   => 0,
    bv_ver_src_id_mth_since_fs = -1     => 0,
    bv_ver_src_id_mth_since_fs <= 8.5   => 0.110814518053337,
    bv_ver_src_id_mth_since_fs <= 18.5  => 0.106180065865153,
    bv_ver_src_id_mth_since_fs <= 35.5  => 0.0770087162753744,
    bv_ver_src_id_mth_since_fs <= 75    => 0.0185108233348364,
    bv_ver_src_id_mth_since_fs <= 125   => 0.0075240912319579,
    bv_ver_src_id_mth_since_fs <= 173.5 => -0.0514812192994325,
    bv_ver_src_id_mth_since_fs <= 295.5 => -0.085828152941259,
                                           -0.175189997475895) ) ;

bo_aa_code_09 := __common__( map(
    bo_v09_w = -0.175189997475895       => '     ',
    bv_ver_src_id_mth_since_fs = NULL   => 'B031',
    bv_ver_src_id_mth_since_fs = -1     => 'B036',
    bv_ver_src_id_mth_since_fs <= 8.5   => 'B036',
    bv_ver_src_id_mth_since_fs <= 18.5  => 'B036',
    bv_ver_src_id_mth_since_fs <= 35.5  => 'B036',
    bv_ver_src_id_mth_since_fs <= 75    => 'B036',
    bv_ver_src_id_mth_since_fs <= 125   => 'B036',
    bv_ver_src_id_mth_since_fs <= 173.5 => 'B036',
    bv_ver_src_id_mth_since_fs <= 295.5 => 'B036',
                                           'B036') ) ;

bo_aa_dist_09 := __common__( 0 - bo_v09_w ) ;

bo_v10_w := __common__( map(
    bv_judg_filed_mth_ls = NULL  => 0,
    bv_judg_filed_mth_ls = -1    => -0.010783223999512,
    bv_judg_filed_mth_ls <= 16.5 => 0.491284160226666,
    bv_judg_filed_mth_ls <= 54.5 => 0.28250209436844,
                                    0.00359313841976347) ) ;

bo_aa_code_10 := __common__( map(
    bo_v10_w = -0.010783223999512 => '     ',
    bv_judg_filed_mth_ls = NULL   => 'B031',
    bv_judg_filed_mth_ls = -1     => 'B078',
    bv_judg_filed_mth_ls <= 16.5  => 'B078',
    bv_judg_filed_mth_ls <= 54.5  => 'B078',
                                     'B078') ) ;

bo_aa_dist_10 := __common__( 0 - bo_v10_w ) ;

bo_v11_w := __common__( map(
    bv_mth_ver_src_br_fs = NULL  => 0,
    bv_mth_ver_src_br_fs = -1    => -0.0430138431318714,
    bv_mth_ver_src_br_fs <= 26.5 => 0.105865997656718,
    bv_mth_ver_src_br_fs <= 30.5 => 0.0572557336292415,
    bv_mth_ver_src_br_fs <= 72   => 0.0140448848000821,
    bv_mth_ver_src_br_fs <= 96   => -0.00286740117973398,
    bv_mth_ver_src_br_fs <= 120  => -0.0234712782552121,
                                    -0.0430138431318714) ) ;

bo_aa_code_11 := __common__( map(
    bo_v11_w = -0.0430138431318714 => '     ',
    bv_mth_ver_src_br_fs = NULL    => 'B076',
    bv_mth_ver_src_br_fs = -1      => 'B037',
    bv_mth_ver_src_br_fs <= 26.5   => 'B037',
    bv_mth_ver_src_br_fs <= 30.5   => 'B037',
    bv_mth_ver_src_br_fs <= 72     => 'B037',
    bv_mth_ver_src_br_fs <= 96     => 'B037',
    bv_mth_ver_src_br_fs <= 120    => 'B037',
                                      'B037') ) ;

bo_aa_dist_11 := __common__( 0 - bo_v11_w ) ;

bo_v12_w := __common__( map(
    bv_mth_ver_src_p_ls = NULL => 0,
    bv_mth_ver_src_p_ls = -1   => 0.0322986665045086,
    bv_mth_ver_src_p_ls <= 23  => -0.100471865026256,
                                  -0.0605801022605013) ) ;

bo_aa_code_12 := __common__( map(
    bo_v12_w = -0.0605801022605013 => '     ',
    bv_mth_ver_src_p_ls = NULL     => 'B076',
    bv_mth_ver_src_p_ls = -1       => 'B052',
    bv_mth_ver_src_p_ls <= 23      => 'B076',
                                      'B076') ) ;

bo_aa_dist_12 := __common__( 0 - bo_v12_w ) ;

bo_v13_w := __common__( map(
    bv_lien_ft_count = NULL => 0,
    bv_lien_ft_count = -1   => 0,
    bv_lien_ft_count <= 0.5 => -0.00394720183562159,
                               0.185912207195916) ) ;

bo_aa_code_13 := __common__( map(
    bo_v13_w = -0.00394720183562159 => '     ',
    bv_lien_ft_count = NULL         => 'B031',
    bv_lien_ft_count = -1           => 'B063',
    bv_lien_ft_count <= 0.5         => 'B063',
                                       'B063') ) ;

bo_aa_dist_13 := __common__( 0 - bo_v13_w ) ;

bo_v14_w := __common__( map(
    bv_assoc_judg_tot = NULL => 0,
    bv_assoc_judg_tot = -1   => 0.0158221280992534,
    bv_assoc_judg_tot <= 0.5 => -0.0370850727343907,
    bv_assoc_judg_tot <= 1.5 => 0.16944190701807,
    bv_assoc_judg_tot <= 2.5 => 0.234627929292538,
    bv_assoc_judg_tot <= 3.5 => 0.252083672567192,
    bv_assoc_judg_tot <= 4.5 => 0.280313664610002,
                                0.318094204416782) ) ;

bo_aa_code_14 := __common__( map(
    bo_v14_w = -0.0370850727343907 => '     ',
    bv_assoc_judg_tot = NULL       => 'B031',
    bv_assoc_judg_tot = -1         => 'B017',
    bv_assoc_judg_tot <= 0.5       => 'B026',
    bv_assoc_judg_tot <= 1.5       => 'B026',
    bv_assoc_judg_tot <= 2.5       => 'B026',
    bv_assoc_judg_tot <= 3.5       => 'B026',
    bv_assoc_judg_tot <= 4.5       => 'B026',
                                      'B026') ) ;

bo_aa_dist_14 := __common__( 0 - bo_v14_w ) ;

bo_v15_w := __common__( map(
    bv_judg_filed_mth_fs = NULL  => 0,
    bv_judg_filed_mth_fs = -1    => -0.00599664473764123,
    bv_judg_filed_mth_fs <= 16.5 => 0.297177115915711,
    bv_judg_filed_mth_fs <= 34.5 => 0.196124353851128,
    bv_judg_filed_mth_fs <= 55.5 => 0.161449457531984,
                                    0.0428629452229592) ) ;

bo_aa_code_15 := __common__( map(
    bo_v15_w = -0.00599664473764123 => '     ',
    bv_judg_filed_mth_fs = NULL     => 'B031',
    bv_judg_filed_mth_fs = -1       => 'B063',
    bv_judg_filed_mth_fs <= 16.5    => 'B063',
    bv_judg_filed_mth_fs <= 34.5    => 'B063',
    bv_judg_filed_mth_fs <= 55.5    => 'B063',
                                       'B063') ) ;

bo_aa_dist_15 := __common__( 0 - bo_v15_w ) ;

bo_v16_w := __common__( map(
    bv_lien_total_amount = NULL   => 0,
    bv_lien_total_amount = -1     => -0.00708284660310057,
    bv_lien_total_amount <= 19624 => 0.0661391537748356,
                                     0.149710450511112) ) ;

bo_aa_code_16 := __common__( map(
    bo_v16_w = -0.00708284660310057 => '     ',
    bv_lien_total_amount = NULL     => 'B031',
    bv_lien_total_amount = -1       => 'B079',
    bv_lien_total_amount <= 19624   => 'B079',
                                       'B079') ) ;

bo_aa_dist_16 := __common__( 0 - bo_v16_w ) ;

bo_v17_w := __common__( map(
    bv_assoc_felony_tot = NULL => 0,
    bv_assoc_felony_tot = -1   => 0.0123864249480587,
    bv_assoc_felony_tot <= 0.5 => -0.0102795602179018,
    bv_assoc_felony_tot <= 2.5 => 0.13635043313609,
    bv_assoc_felony_tot <= 4.5 => 0.212014220692776,
                                  0.244694223923211) ) ;

bo_aa_code_17 := __common__( map(
    bo_v17_w = -0.0102795602179018 => '     ',
    bv_assoc_felony_tot = NULL     => 'B031',
    bv_assoc_felony_tot = -1       => 'B017',
    bv_assoc_felony_tot <= 0.5     => 'B026',
    bv_assoc_felony_tot <= 2.5     => 'B026',
    bv_assoc_felony_tot <= 4.5     => 'B026',
                                      'B026') ) ;

bo_aa_dist_17 := __common__( 0 - bo_v17_w ) ;

bo_v18_w := __common__( map(
    bv_ver_src_id_activity12 = NULL => 0,
    bv_ver_src_id_activity12 = -1   => 0.0404734088386745,
    bv_ver_src_id_activity12 <= 0.5 => 0.0705917449486271,
    bv_ver_src_id_activity12 <= 3   => -0.000954005085595083,
    bv_ver_src_id_activity12 <= 4   => -0.00725570832797639,
                                       -0.0155212826782623) ) ;

bo_aa_code_18 := __common__( map(
    bo_v18_w = -0.0155212826782623                                 => '     ',
    bv_ver_src_id_activity12 = NULL                                => 'B031',
    bv_ver_src_id_activity12 = -1                                  => 'B034',
    bv_ver_src_id_activity12 <= 0.5                                => 'B063',
    0 <= bv_sos_mth_agent_change AND bv_sos_mth_agent_change <= 12 => 'B056',
    bv_ver_src_id_activity12 <= 3                                  => 'B034',
    bv_ver_src_id_activity12 <= 4                                  => 'B034',
                                                                      'B034') ) ;

bo_aa_dist_18 := __common__( 0 - bo_v18_w ) ;

bo_v19_w := __common__( map(
    bv_ucc_mth_fs = NULL => 0,
    bv_ucc_mth_fs = -1   => 0.000614873055735271,
    bv_ucc_mth_fs <= 14  => 0.0365332080454301,
    bv_ucc_mth_fs <= 68  => 0.0134814045357022,
    bv_ucc_mth_fs <= 96  => 0.00687791972145683,
    bv_ucc_mth_fs <= 162 => -0.0109009835699868,
    bv_ucc_mth_fs <= 200 => -0.0274568761372206,
                            -0.0334147097420306) ) ;

bo_aa_code_19 := __common__( map(
    bo_v19_w = -0.0334147097420306 => '     ',
    bv_ucc_mth_fs = NULL           => 'B031',
    bv_ucc_mth_fs = -1             => 'B066',
    bv_ucc_mth_fs <= 14            => 'B066',
    bv_ucc_mth_fs <= 68            => 'B066',
    bv_ucc_mth_fs <= 96            => 'B066',
    bv_ucc_mth_fs <= 162           => 'B066',
    bv_ucc_mth_fs <= 200           => 'B066',
                                      'B066') ) ;

bo_aa_dist_19 := __common__( 0 - bo_v19_w ) ;

bo_rcvalueb037 := __common__( (integer)(bo_aa_code_01 = 'B037') * bo_aa_dist_01 +
    (integer)(bo_aa_code_02 = 'B037') * bo_aa_dist_02 +
    (integer)(bo_aa_code_03 = 'B037') * bo_aa_dist_03 +
    (integer)(bo_aa_code_04 = 'B037') * bo_aa_dist_04 +
    (integer)(bo_aa_code_05 = 'B037') * bo_aa_dist_05 +
    (integer)(bo_aa_code_06 = 'B037') * bo_aa_dist_06 +
    (integer)(bo_aa_code_07 = 'B037') * bo_aa_dist_07 +
    (integer)(bo_aa_code_08 = 'B037') * bo_aa_dist_08 +
    (integer)(bo_aa_code_09 = 'B037') * bo_aa_dist_09 +
    (integer)(bo_aa_code_10 = 'B037') * bo_aa_dist_10 +
    (integer)(bo_aa_code_11 = 'B037') * bo_aa_dist_11 +
    (integer)(bo_aa_code_12 = 'B037') * bo_aa_dist_12 +
    (integer)(bo_aa_code_13 = 'B037') * bo_aa_dist_13 +
    (integer)(bo_aa_code_14 = 'B037') * bo_aa_dist_14 +
    (integer)(bo_aa_code_15 = 'B037') * bo_aa_dist_15 +
    (integer)(bo_aa_code_16 = 'B037') * bo_aa_dist_16 +
    (integer)(bo_aa_code_17 = 'B037') * bo_aa_dist_17 +
    (integer)(bo_aa_code_18 = 'B037') * bo_aa_dist_18 +
    (integer)(bo_aa_code_19 = 'B037') * bo_aa_dist_19 ) ;

bo_rcvalueb069 := __common__( (integer)(bo_aa_code_01 = 'B069') * bo_aa_dist_01 +
    (integer)(bo_aa_code_02 = 'B069') * bo_aa_dist_02 +
    (integer)(bo_aa_code_03 = 'B069') * bo_aa_dist_03 +
    (integer)(bo_aa_code_04 = 'B069') * bo_aa_dist_04 +
    (integer)(bo_aa_code_05 = 'B069') * bo_aa_dist_05 +
    (integer)(bo_aa_code_06 = 'B069') * bo_aa_dist_06 +
    (integer)(bo_aa_code_07 = 'B069') * bo_aa_dist_07 +
    (integer)(bo_aa_code_08 = 'B069') * bo_aa_dist_08 +
    (integer)(bo_aa_code_09 = 'B069') * bo_aa_dist_09 +
    (integer)(bo_aa_code_10 = 'B069') * bo_aa_dist_10 +
    (integer)(bo_aa_code_11 = 'B069') * bo_aa_dist_11 +
    (integer)(bo_aa_code_12 = 'B069') * bo_aa_dist_12 +
    (integer)(bo_aa_code_13 = 'B069') * bo_aa_dist_13 +
    (integer)(bo_aa_code_14 = 'B069') * bo_aa_dist_14 +
    (integer)(bo_aa_code_15 = 'B069') * bo_aa_dist_15 +
    (integer)(bo_aa_code_16 = 'B069') * bo_aa_dist_16 +
    (integer)(bo_aa_code_17 = 'B069') * bo_aa_dist_17 +
    (integer)(bo_aa_code_18 = 'B069') * bo_aa_dist_18 +
    (integer)(bo_aa_code_19 = 'B069') * bo_aa_dist_19 ) ;

bo_rcvalueb026 := __common__( (integer)(bo_aa_code_01 = 'B026') * bo_aa_dist_01 +
    (integer)(bo_aa_code_02 = 'B026') * bo_aa_dist_02 +
    (integer)(bo_aa_code_03 = 'B026') * bo_aa_dist_03 +
    (integer)(bo_aa_code_04 = 'B026') * bo_aa_dist_04 +
    (integer)(bo_aa_code_05 = 'B026') * bo_aa_dist_05 +
    (integer)(bo_aa_code_06 = 'B026') * bo_aa_dist_06 +
    (integer)(bo_aa_code_07 = 'B026') * bo_aa_dist_07 +
    (integer)(bo_aa_code_08 = 'B026') * bo_aa_dist_08 +
    (integer)(bo_aa_code_09 = 'B026') * bo_aa_dist_09 +
    (integer)(bo_aa_code_10 = 'B026') * bo_aa_dist_10 +
    (integer)(bo_aa_code_11 = 'B026') * bo_aa_dist_11 +
    (integer)(bo_aa_code_12 = 'B026') * bo_aa_dist_12 +
    (integer)(bo_aa_code_13 = 'B026') * bo_aa_dist_13 +
    (integer)(bo_aa_code_14 = 'B026') * bo_aa_dist_14 +
    (integer)(bo_aa_code_15 = 'B026') * bo_aa_dist_15 +
    (integer)(bo_aa_code_16 = 'B026') * bo_aa_dist_16 +
    (integer)(bo_aa_code_17 = 'B026') * bo_aa_dist_17 +
    (integer)(bo_aa_code_18 = 'B026') * bo_aa_dist_18 +
    (integer)(bo_aa_code_19 = 'B026') * bo_aa_dist_19 ) ;

bo_rcvalueb034 := __common__( (integer)(bo_aa_code_01 = 'B034') * bo_aa_dist_01 +
    (integer)(bo_aa_code_02 = 'B034') * bo_aa_dist_02 +
    (integer)(bo_aa_code_03 = 'B034') * bo_aa_dist_03 +
    (integer)(bo_aa_code_04 = 'B034') * bo_aa_dist_04 +
    (integer)(bo_aa_code_05 = 'B034') * bo_aa_dist_05 +
    (integer)(bo_aa_code_06 = 'B034') * bo_aa_dist_06 +
    (integer)(bo_aa_code_07 = 'B034') * bo_aa_dist_07 +
    (integer)(bo_aa_code_08 = 'B034') * bo_aa_dist_08 +
    (integer)(bo_aa_code_09 = 'B034') * bo_aa_dist_09 +
    (integer)(bo_aa_code_10 = 'B034') * bo_aa_dist_10 +
    (integer)(bo_aa_code_11 = 'B034') * bo_aa_dist_11 +
    (integer)(bo_aa_code_12 = 'B034') * bo_aa_dist_12 +
    (integer)(bo_aa_code_13 = 'B034') * bo_aa_dist_13 +
    (integer)(bo_aa_code_14 = 'B034') * bo_aa_dist_14 +
    (integer)(bo_aa_code_15 = 'B034') * bo_aa_dist_15 +
    (integer)(bo_aa_code_16 = 'B034') * bo_aa_dist_16 +
    (integer)(bo_aa_code_17 = 'B034') * bo_aa_dist_17 +
    (integer)(bo_aa_code_18 = 'B034') * bo_aa_dist_18 +
    (integer)(bo_aa_code_19 = 'B034') * bo_aa_dist_19 ) ;

bo_rcvalueb052 := __common__( (integer)(bo_aa_code_01 = 'B052') * bo_aa_dist_01 +
    (integer)(bo_aa_code_02 = 'B052') * bo_aa_dist_02 +
    (integer)(bo_aa_code_03 = 'B052') * bo_aa_dist_03 +
    (integer)(bo_aa_code_04 = 'B052') * bo_aa_dist_04 +
    (integer)(bo_aa_code_05 = 'B052') * bo_aa_dist_05 +
    (integer)(bo_aa_code_06 = 'B052') * bo_aa_dist_06 +
    (integer)(bo_aa_code_07 = 'B052') * bo_aa_dist_07 +
    (integer)(bo_aa_code_08 = 'B052') * bo_aa_dist_08 +
    (integer)(bo_aa_code_09 = 'B052') * bo_aa_dist_09 +
    (integer)(bo_aa_code_10 = 'B052') * bo_aa_dist_10 +
    (integer)(bo_aa_code_11 = 'B052') * bo_aa_dist_11 +
    (integer)(bo_aa_code_12 = 'B052') * bo_aa_dist_12 +
    (integer)(bo_aa_code_13 = 'B052') * bo_aa_dist_13 +
    (integer)(bo_aa_code_14 = 'B052') * bo_aa_dist_14 +
    (integer)(bo_aa_code_15 = 'B052') * bo_aa_dist_15 +
    (integer)(bo_aa_code_16 = 'B052') * bo_aa_dist_16 +
    (integer)(bo_aa_code_17 = 'B052') * bo_aa_dist_17 +
    (integer)(bo_aa_code_18 = 'B052') * bo_aa_dist_18 +
    (integer)(bo_aa_code_19 = 'B052') * bo_aa_dist_19 ) ;

bo_rcvalueb031 := __common__( (integer)(bo_aa_code_01 = 'B031') * bo_aa_dist_01 +
    (integer)(bo_aa_code_02 = 'B031') * bo_aa_dist_02 +
    (integer)(bo_aa_code_03 = 'B031') * bo_aa_dist_03 +
    (integer)(bo_aa_code_04 = 'B031') * bo_aa_dist_04 +
    (integer)(bo_aa_code_05 = 'B031') * bo_aa_dist_05 +
    (integer)(bo_aa_code_06 = 'B031') * bo_aa_dist_06 +
    (integer)(bo_aa_code_07 = 'B031') * bo_aa_dist_07 +
    (integer)(bo_aa_code_08 = 'B031') * bo_aa_dist_08 +
    (integer)(bo_aa_code_09 = 'B031') * bo_aa_dist_09 +
    (integer)(bo_aa_code_10 = 'B031') * bo_aa_dist_10 +
    (integer)(bo_aa_code_11 = 'B031') * bo_aa_dist_11 +
    (integer)(bo_aa_code_12 = 'B031') * bo_aa_dist_12 +
    (integer)(bo_aa_code_13 = 'B031') * bo_aa_dist_13 +
    (integer)(bo_aa_code_14 = 'B031') * bo_aa_dist_14 +
    (integer)(bo_aa_code_15 = 'B031') * bo_aa_dist_15 +
    (integer)(bo_aa_code_16 = 'B031') * bo_aa_dist_16 +
    (integer)(bo_aa_code_17 = 'B031') * bo_aa_dist_17 +
    (integer)(bo_aa_code_18 = 'B031') * bo_aa_dist_18 +
    (integer)(bo_aa_code_19 = 'B031') * bo_aa_dist_19 ) ;

bo_rcvalueb036 := __common__( (integer)(bo_aa_code_01 = 'B036') * bo_aa_dist_01 +
    (integer)(bo_aa_code_02 = 'B036') * bo_aa_dist_02 +
    (integer)(bo_aa_code_03 = 'B036') * bo_aa_dist_03 +
    (integer)(bo_aa_code_04 = 'B036') * bo_aa_dist_04 +
    (integer)(bo_aa_code_05 = 'B036') * bo_aa_dist_05 +
    (integer)(bo_aa_code_06 = 'B036') * bo_aa_dist_06 +
    (integer)(bo_aa_code_07 = 'B036') * bo_aa_dist_07 +
    (integer)(bo_aa_code_08 = 'B036') * bo_aa_dist_08 +
    (integer)(bo_aa_code_09 = 'B036') * bo_aa_dist_09 +
    (integer)(bo_aa_code_10 = 'B036') * bo_aa_dist_10 +
    (integer)(bo_aa_code_11 = 'B036') * bo_aa_dist_11 +
    (integer)(bo_aa_code_12 = 'B036') * bo_aa_dist_12 +
    (integer)(bo_aa_code_13 = 'B036') * bo_aa_dist_13 +
    (integer)(bo_aa_code_14 = 'B036') * bo_aa_dist_14 +
    (integer)(bo_aa_code_15 = 'B036') * bo_aa_dist_15 +
    (integer)(bo_aa_code_16 = 'B036') * bo_aa_dist_16 +
    (integer)(bo_aa_code_17 = 'B036') * bo_aa_dist_17 +
    (integer)(bo_aa_code_18 = 'B036') * bo_aa_dist_18 +
    (integer)(bo_aa_code_19 = 'B036') * bo_aa_dist_19 ) ;

bo_rcvalueb017 := __common__( (integer)(bo_aa_code_01 = 'B017') * bo_aa_dist_01 +
    (integer)(bo_aa_code_02 = 'B017') * bo_aa_dist_02 +
    (integer)(bo_aa_code_03 = 'B017') * bo_aa_dist_03 +
    (integer)(bo_aa_code_04 = 'B017') * bo_aa_dist_04 +
    (integer)(bo_aa_code_05 = 'B017') * bo_aa_dist_05 +
    (integer)(bo_aa_code_06 = 'B017') * bo_aa_dist_06 +
    (integer)(bo_aa_code_07 = 'B017') * bo_aa_dist_07 +
    (integer)(bo_aa_code_08 = 'B017') * bo_aa_dist_08 +
    (integer)(bo_aa_code_09 = 'B017') * bo_aa_dist_09 +
    (integer)(bo_aa_code_10 = 'B017') * bo_aa_dist_10 +
    (integer)(bo_aa_code_11 = 'B017') * bo_aa_dist_11 +
    (integer)(bo_aa_code_12 = 'B017') * bo_aa_dist_12 +
    (integer)(bo_aa_code_13 = 'B017') * bo_aa_dist_13 +
    (integer)(bo_aa_code_14 = 'B017') * bo_aa_dist_14 +
    (integer)(bo_aa_code_15 = 'B017') * bo_aa_dist_15 +
    (integer)(bo_aa_code_16 = 'B017') * bo_aa_dist_16 +
    (integer)(bo_aa_code_17 = 'B017') * bo_aa_dist_17 +
    (integer)(bo_aa_code_18 = 'B017') * bo_aa_dist_18 +
    (integer)(bo_aa_code_19 = 'B017') * bo_aa_dist_19 ) ;

bo_rcvalueb063 := __common__( (integer)(bo_aa_code_01 = 'B063') * bo_aa_dist_01 +
    (integer)(bo_aa_code_02 = 'B063') * bo_aa_dist_02 +
    (integer)(bo_aa_code_03 = 'B063') * bo_aa_dist_03 +
    (integer)(bo_aa_code_04 = 'B063') * bo_aa_dist_04 +
    (integer)(bo_aa_code_05 = 'B063') * bo_aa_dist_05 +
    (integer)(bo_aa_code_06 = 'B063') * bo_aa_dist_06 +
    (integer)(bo_aa_code_07 = 'B063') * bo_aa_dist_07 +
    (integer)(bo_aa_code_08 = 'B063') * bo_aa_dist_08 +
    (integer)(bo_aa_code_09 = 'B063') * bo_aa_dist_09 +
    (integer)(bo_aa_code_10 = 'B063') * bo_aa_dist_10 +
    (integer)(bo_aa_code_11 = 'B063') * bo_aa_dist_11 +
    (integer)(bo_aa_code_12 = 'B063') * bo_aa_dist_12 +
    (integer)(bo_aa_code_13 = 'B063') * bo_aa_dist_13 +
    (integer)(bo_aa_code_14 = 'B063') * bo_aa_dist_14 +
    (integer)(bo_aa_code_15 = 'B063') * bo_aa_dist_15 +
    (integer)(bo_aa_code_16 = 'B063') * bo_aa_dist_16 +
    (integer)(bo_aa_code_17 = 'B063') * bo_aa_dist_17 +
    (integer)(bo_aa_code_18 = 'B063') * bo_aa_dist_18 +
    (integer)(bo_aa_code_19 = 'B063') * bo_aa_dist_19 ) ;

bo_rcvalueb035 := __common__( (integer)(bo_aa_code_01 = 'B035') * bo_aa_dist_01 +
    (integer)(bo_aa_code_02 = 'B035') * bo_aa_dist_02 +
    (integer)(bo_aa_code_03 = 'B035') * bo_aa_dist_03 +
    (integer)(bo_aa_code_04 = 'B035') * bo_aa_dist_04 +
    (integer)(bo_aa_code_05 = 'B035') * bo_aa_dist_05 +
    (integer)(bo_aa_code_06 = 'B035') * bo_aa_dist_06 +
    (integer)(bo_aa_code_07 = 'B035') * bo_aa_dist_07 +
    (integer)(bo_aa_code_08 = 'B035') * bo_aa_dist_08 +
    (integer)(bo_aa_code_09 = 'B035') * bo_aa_dist_09 +
    (integer)(bo_aa_code_10 = 'B035') * bo_aa_dist_10 +
    (integer)(bo_aa_code_11 = 'B035') * bo_aa_dist_11 +
    (integer)(bo_aa_code_12 = 'B035') * bo_aa_dist_12 +
    (integer)(bo_aa_code_13 = 'B035') * bo_aa_dist_13 +
    (integer)(bo_aa_code_14 = 'B035') * bo_aa_dist_14 +
    (integer)(bo_aa_code_15 = 'B035') * bo_aa_dist_15 +
    (integer)(bo_aa_code_16 = 'B035') * bo_aa_dist_16 +
    (integer)(bo_aa_code_17 = 'B035') * bo_aa_dist_17 +
    (integer)(bo_aa_code_18 = 'B035') * bo_aa_dist_18 +
    (integer)(bo_aa_code_19 = 'B035') * bo_aa_dist_19 ) ;

bo_rcvalueb075 := __common__( (integer)(bo_aa_code_01 = 'B075') * bo_aa_dist_01 +
    (integer)(bo_aa_code_02 = 'B075') * bo_aa_dist_02 +
    (integer)(bo_aa_code_03 = 'B075') * bo_aa_dist_03 +
    (integer)(bo_aa_code_04 = 'B075') * bo_aa_dist_04 +
    (integer)(bo_aa_code_05 = 'B075') * bo_aa_dist_05 +
    (integer)(bo_aa_code_06 = 'B075') * bo_aa_dist_06 +
    (integer)(bo_aa_code_07 = 'B075') * bo_aa_dist_07 +
    (integer)(bo_aa_code_08 = 'B075') * bo_aa_dist_08 +
    (integer)(bo_aa_code_09 = 'B075') * bo_aa_dist_09 +
    (integer)(bo_aa_code_10 = 'B075') * bo_aa_dist_10 +
    (integer)(bo_aa_code_11 = 'B075') * bo_aa_dist_11 +
    (integer)(bo_aa_code_12 = 'B075') * bo_aa_dist_12 +
    (integer)(bo_aa_code_13 = 'B075') * bo_aa_dist_13 +
    (integer)(bo_aa_code_14 = 'B075') * bo_aa_dist_14 +
    (integer)(bo_aa_code_15 = 'B075') * bo_aa_dist_15 +
    (integer)(bo_aa_code_16 = 'B075') * bo_aa_dist_16 +
    (integer)(bo_aa_code_17 = 'B075') * bo_aa_dist_17 +
    (integer)(bo_aa_code_18 = 'B075') * bo_aa_dist_18 +
    (integer)(bo_aa_code_19 = 'B075') * bo_aa_dist_19 ) ;

bo_rcvalueb074 := __common__( (integer)(bo_aa_code_01 = 'B074') * bo_aa_dist_01 +
    (integer)(bo_aa_code_02 = 'B074') * bo_aa_dist_02 +
    (integer)(bo_aa_code_03 = 'B074') * bo_aa_dist_03 +
    (integer)(bo_aa_code_04 = 'B074') * bo_aa_dist_04 +
    (integer)(bo_aa_code_05 = 'B074') * bo_aa_dist_05 +
    (integer)(bo_aa_code_06 = 'B074') * bo_aa_dist_06 +
    (integer)(bo_aa_code_07 = 'B074') * bo_aa_dist_07 +
    (integer)(bo_aa_code_08 = 'B074') * bo_aa_dist_08 +
    (integer)(bo_aa_code_09 = 'B074') * bo_aa_dist_09 +
    (integer)(bo_aa_code_10 = 'B074') * bo_aa_dist_10 +
    (integer)(bo_aa_code_11 = 'B074') * bo_aa_dist_11 +
    (integer)(bo_aa_code_12 = 'B074') * bo_aa_dist_12 +
    (integer)(bo_aa_code_13 = 'B074') * bo_aa_dist_13 +
    (integer)(bo_aa_code_14 = 'B074') * bo_aa_dist_14 +
    (integer)(bo_aa_code_15 = 'B074') * bo_aa_dist_15 +
    (integer)(bo_aa_code_16 = 'B074') * bo_aa_dist_16 +
    (integer)(bo_aa_code_17 = 'B074') * bo_aa_dist_17 +
    (integer)(bo_aa_code_18 = 'B074') * bo_aa_dist_18 +
    (integer)(bo_aa_code_19 = 'B074') * bo_aa_dist_19 ) ;

bo_rcvalueb079 := __common__( (integer)(bo_aa_code_01 = 'B079') * bo_aa_dist_01 +
    (integer)(bo_aa_code_02 = 'B079') * bo_aa_dist_02 +
    (integer)(bo_aa_code_03 = 'B079') * bo_aa_dist_03 +
    (integer)(bo_aa_code_04 = 'B079') * bo_aa_dist_04 +
    (integer)(bo_aa_code_05 = 'B079') * bo_aa_dist_05 +
    (integer)(bo_aa_code_06 = 'B079') * bo_aa_dist_06 +
    (integer)(bo_aa_code_07 = 'B079') * bo_aa_dist_07 +
    (integer)(bo_aa_code_08 = 'B079') * bo_aa_dist_08 +
    (integer)(bo_aa_code_09 = 'B079') * bo_aa_dist_09 +
    (integer)(bo_aa_code_10 = 'B079') * bo_aa_dist_10 +
    (integer)(bo_aa_code_11 = 'B079') * bo_aa_dist_11 +
    (integer)(bo_aa_code_12 = 'B079') * bo_aa_dist_12 +
    (integer)(bo_aa_code_13 = 'B079') * bo_aa_dist_13 +
    (integer)(bo_aa_code_14 = 'B079') * bo_aa_dist_14 +
    (integer)(bo_aa_code_15 = 'B079') * bo_aa_dist_15 +
    (integer)(bo_aa_code_16 = 'B079') * bo_aa_dist_16 +
    (integer)(bo_aa_code_17 = 'B079') * bo_aa_dist_17 +
    (integer)(bo_aa_code_18 = 'B079') * bo_aa_dist_18 +
    (integer)(bo_aa_code_19 = 'B079') * bo_aa_dist_19 ) ;

bo_rcvalueb078 := __common__( (integer)(bo_aa_code_01 = 'B078') * bo_aa_dist_01 +
    (integer)(bo_aa_code_02 = 'B078') * bo_aa_dist_02 +
    (integer)(bo_aa_code_03 = 'B078') * bo_aa_dist_03 +
    (integer)(bo_aa_code_04 = 'B078') * bo_aa_dist_04 +
    (integer)(bo_aa_code_05 = 'B078') * bo_aa_dist_05 +
    (integer)(bo_aa_code_06 = 'B078') * bo_aa_dist_06 +
    (integer)(bo_aa_code_07 = 'B078') * bo_aa_dist_07 +
    (integer)(bo_aa_code_08 = 'B078') * bo_aa_dist_08 +
    (integer)(bo_aa_code_09 = 'B078') * bo_aa_dist_09 +
    (integer)(bo_aa_code_10 = 'B078') * bo_aa_dist_10 +
    (integer)(bo_aa_code_11 = 'B078') * bo_aa_dist_11 +
    (integer)(bo_aa_code_12 = 'B078') * bo_aa_dist_12 +
    (integer)(bo_aa_code_13 = 'B078') * bo_aa_dist_13 +
    (integer)(bo_aa_code_14 = 'B078') * bo_aa_dist_14 +
    (integer)(bo_aa_code_15 = 'B078') * bo_aa_dist_15 +
    (integer)(bo_aa_code_16 = 'B078') * bo_aa_dist_16 +
    (integer)(bo_aa_code_17 = 'B078') * bo_aa_dist_17 +
    (integer)(bo_aa_code_18 = 'B078') * bo_aa_dist_18 +
    (integer)(bo_aa_code_19 = 'B078') * bo_aa_dist_19 ) ;

bo_rcvalueb076 := __common__( (integer)(bo_aa_code_01 = 'B076') * bo_aa_dist_01 +
    (integer)(bo_aa_code_02 = 'B076') * bo_aa_dist_02 +
    (integer)(bo_aa_code_03 = 'B076') * bo_aa_dist_03 +
    (integer)(bo_aa_code_04 = 'B076') * bo_aa_dist_04 +
    (integer)(bo_aa_code_05 = 'B076') * bo_aa_dist_05 +
    (integer)(bo_aa_code_06 = 'B076') * bo_aa_dist_06 +
    (integer)(bo_aa_code_07 = 'B076') * bo_aa_dist_07 +
    (integer)(bo_aa_code_08 = 'B076') * bo_aa_dist_08 +
    (integer)(bo_aa_code_09 = 'B076') * bo_aa_dist_09 +
    (integer)(bo_aa_code_10 = 'B076') * bo_aa_dist_10 +
    (integer)(bo_aa_code_11 = 'B076') * bo_aa_dist_11 +
    (integer)(bo_aa_code_12 = 'B076') * bo_aa_dist_12 +
    (integer)(bo_aa_code_13 = 'B076') * bo_aa_dist_13 +
    (integer)(bo_aa_code_14 = 'B076') * bo_aa_dist_14 +
    (integer)(bo_aa_code_15 = 'B076') * bo_aa_dist_15 +
    (integer)(bo_aa_code_16 = 'B076') * bo_aa_dist_16 +
    (integer)(bo_aa_code_17 = 'B076') * bo_aa_dist_17 +
    (integer)(bo_aa_code_18 = 'B076') * bo_aa_dist_18 +
    (integer)(bo_aa_code_19 = 'B076') * bo_aa_dist_19 ) ;

bo_rcvalueb066 := __common__( (integer)(bo_aa_code_01 = 'B066') * bo_aa_dist_01 +
    (integer)(bo_aa_code_02 = 'B066') * bo_aa_dist_02 +
    (integer)(bo_aa_code_03 = 'B066') * bo_aa_dist_03 +
    (integer)(bo_aa_code_04 = 'B066') * bo_aa_dist_04 +
    (integer)(bo_aa_code_05 = 'B066') * bo_aa_dist_05 +
    (integer)(bo_aa_code_06 = 'B066') * bo_aa_dist_06 +
    (integer)(bo_aa_code_07 = 'B066') * bo_aa_dist_07 +
    (integer)(bo_aa_code_08 = 'B066') * bo_aa_dist_08 +
    (integer)(bo_aa_code_09 = 'B066') * bo_aa_dist_09 +
    (integer)(bo_aa_code_10 = 'B066') * bo_aa_dist_10 +
    (integer)(bo_aa_code_11 = 'B066') * bo_aa_dist_11 +
    (integer)(bo_aa_code_12 = 'B066') * bo_aa_dist_12 +
    (integer)(bo_aa_code_13 = 'B066') * bo_aa_dist_13 +
    (integer)(bo_aa_code_14 = 'B066') * bo_aa_dist_14 +
    (integer)(bo_aa_code_15 = 'B066') * bo_aa_dist_15 +
    (integer)(bo_aa_code_16 = 'B066') * bo_aa_dist_16 +
    (integer)(bo_aa_code_17 = 'B066') * bo_aa_dist_17 +
    (integer)(bo_aa_code_18 = 'B066') * bo_aa_dist_18 +
    (integer)(bo_aa_code_19 = 'B066') * bo_aa_dist_19 ) ;

bo_rcvalueb056 := __common__( (integer)(bo_aa_code_01 = 'B056') * bo_aa_dist_01 +
    (integer)(bo_aa_code_02 = 'B056') * bo_aa_dist_02 +
    (integer)(bo_aa_code_03 = 'B056') * bo_aa_dist_03 +
    (integer)(bo_aa_code_04 = 'B056') * bo_aa_dist_04 +
    (integer)(bo_aa_code_05 = 'B056') * bo_aa_dist_05 +
    (integer)(bo_aa_code_06 = 'B056') * bo_aa_dist_06 +
    (integer)(bo_aa_code_07 = 'B056') * bo_aa_dist_07 +
    (integer)(bo_aa_code_08 = 'B056') * bo_aa_dist_08 +
    (integer)(bo_aa_code_09 = 'B056') * bo_aa_dist_09 +
    (integer)(bo_aa_code_10 = 'B056') * bo_aa_dist_10 +
    (integer)(bo_aa_code_11 = 'B056') * bo_aa_dist_11 +
    (integer)(bo_aa_code_12 = 'B056') * bo_aa_dist_12 +
    (integer)(bo_aa_code_13 = 'B056') * bo_aa_dist_13 +
    (integer)(bo_aa_code_14 = 'B056') * bo_aa_dist_14 +
    (integer)(bo_aa_code_15 = 'B056') * bo_aa_dist_15 +
    (integer)(bo_aa_code_16 = 'B056') * bo_aa_dist_16 +
    (integer)(bo_aa_code_17 = 'B056') * bo_aa_dist_17 +
    (integer)(bo_aa_code_18 = 'B056') * bo_aa_dist_18 +
    (integer)(bo_aa_code_19 = 'B056') * bo_aa_dist_19 ) ;

bo_rcvalueb059 := __common__( (integer)(bo_aa_code_01 = 'B059') * bo_aa_dist_01 +
    (integer)(bo_aa_code_02 = 'B059') * bo_aa_dist_02 +
    (integer)(bo_aa_code_03 = 'B059') * bo_aa_dist_03 +
    (integer)(bo_aa_code_04 = 'B059') * bo_aa_dist_04 +
    (integer)(bo_aa_code_05 = 'B059') * bo_aa_dist_05 +
    (integer)(bo_aa_code_06 = 'B059') * bo_aa_dist_06 +
    (integer)(bo_aa_code_07 = 'B059') * bo_aa_dist_07 +
    (integer)(bo_aa_code_08 = 'B059') * bo_aa_dist_08 +
    (integer)(bo_aa_code_09 = 'B059') * bo_aa_dist_09 +
    (integer)(bo_aa_code_10 = 'B059') * bo_aa_dist_10 +
    (integer)(bo_aa_code_11 = 'B059') * bo_aa_dist_11 +
    (integer)(bo_aa_code_12 = 'B059') * bo_aa_dist_12 +
    (integer)(bo_aa_code_13 = 'B059') * bo_aa_dist_13 +
    (integer)(bo_aa_code_14 = 'B059') * bo_aa_dist_14 +
    (integer)(bo_aa_code_15 = 'B059') * bo_aa_dist_15 +
    (integer)(bo_aa_code_16 = 'B059') * bo_aa_dist_16 +
    (integer)(bo_aa_code_17 = 'B059') * bo_aa_dist_17 +
    (integer)(bo_aa_code_18 = 'B059') * bo_aa_dist_18 +
    (integer)(bo_aa_code_19 = 'B059') * bo_aa_dist_19 ) ;

bo_rcvalueb070 := __common__( (integer)(bo_aa_code_01 = 'B070') * bo_aa_dist_01 +
    (integer)(bo_aa_code_02 = 'B070') * bo_aa_dist_02 +
    (integer)(bo_aa_code_03 = 'B070') * bo_aa_dist_03 +
    (integer)(bo_aa_code_04 = 'B070') * bo_aa_dist_04 +
    (integer)(bo_aa_code_05 = 'B070') * bo_aa_dist_05 +
    (integer)(bo_aa_code_06 = 'B070') * bo_aa_dist_06 +
    (integer)(bo_aa_code_07 = 'B070') * bo_aa_dist_07 +
    (integer)(bo_aa_code_08 = 'B070') * bo_aa_dist_08 +
    (integer)(bo_aa_code_09 = 'B070') * bo_aa_dist_09 +
    (integer)(bo_aa_code_10 = 'B070') * bo_aa_dist_10 +
    (integer)(bo_aa_code_11 = 'B070') * bo_aa_dist_11 +
    (integer)(bo_aa_code_12 = 'B070') * bo_aa_dist_12 +
    (integer)(bo_aa_code_13 = 'B070') * bo_aa_dist_13 +
    (integer)(bo_aa_code_14 = 'B070') * bo_aa_dist_14 +
    (integer)(bo_aa_code_15 = 'B070') * bo_aa_dist_15 +
    (integer)(bo_aa_code_16 = 'B070') * bo_aa_dist_16 +
    (integer)(bo_aa_code_17 = 'B070') * bo_aa_dist_17 +
    (integer)(bo_aa_code_18 = 'B070') * bo_aa_dist_18 +
    (integer)(bo_aa_code_19 = 'B070') * bo_aa_dist_19 ) ;

bo_lgt := __common__( -3.86916130258726 +
    bo_v01_w +
    bo_v02_w +
    bo_v03_w +
    bo_v04_w +
    bo_v05_w +
    bo_v06_w +
    bo_v07_w +
    bo_v08_w +
    bo_v09_w +
    bo_v10_w +
    bo_v11_w +
    bo_v12_w +
    bo_v13_w +
    bo_v14_w +
    bo_v15_w +
    bo_v16_w +
    bo_v17_w +
    bo_v18_w +
    bo_v19_w ) ;

base := __common__( 700 ) ;

pts := __common__( -40 ) ;

lgt := __common__( ln(0.02 / (1 - 0.02)) ) ;

slbo1702_0_2_1 := __common__( round(max((real)501, min(900, if(base + pts * (bo_lgt - lgt) / ln(2) = NULL, -NULL, base + pts * (bo_lgt - lgt) / ln(2))))) ) ;

slbo1702_0_2 := __common__( if((integer)ver_src_id_count <= 0, 222, slbo1702_0_2_1) ) ;

//*************************************************************************************//
// reason code logic
//*************************************************************************************//

ds_layout := {STRING rc, REAL value}  ;
l_code_set := [bo_aa_code_01,
							 bo_aa_code_02,
							 bo_aa_code_03,
							 bo_aa_code_04,
							 bo_aa_code_05,
							 bo_aa_code_06,
							 bo_aa_code_07,
							 bo_aa_code_08,
							 bo_aa_code_09,
							 bo_aa_code_10,
							 bo_aa_code_11,
							 bo_aa_code_12,
							 bo_aa_code_13,
							 bo_aa_code_14,
							 bo_aa_code_15,
							 bo_aa_code_16,
							 bo_aa_code_17,	
							 bo_aa_code_18,
							 bo_aa_code_19]  ;

 
//*************************************************************************************//
rc_dataset_bo := __common__( DATASET([
    {'B017', bo_rcvalueB017},
    {'B026', bo_rcvalueB026},
    {'B031', bo_rcvalueB031},
    {'B034', bo_rcvalueB034},
    {'B035', bo_rcvalueB035},
    {'B036', bo_rcvalueB036},
    {'B037', bo_rcvalueB037},
    {'B052', bo_rcvalueB052},
    {'B056', bo_rcvalueB056},
    {'B059', bo_rcvalueB059},
    {'B063', bo_rcvalueB063},
    {'B066', bo_rcvalueB066},
    {'B069', bo_rcvalueB069},
    {'B070', bo_rcvalueB070},
    {'B074', bo_rcvalueB074},
    {'B075', bo_rcvalueB075},
    {'B076', bo_rcvalueB076},
    {'B078', bo_rcvalueB078},
    {'B079', bo_rcvalueB079}
    ], ds_layout)(rc in l_code_set)  ) ;

rc_dataset_bo_sorted := __common__( sort(rc_dataset_bo, rc_dataset_bo.value) ) ;

finalbo_rc1  := __common__( rc_dataset_bo_sorted[1].rc ) ;
finalbo_rc2  := __common__( rc_dataset_bo_sorted[2].rc ) ;
finalbo_rc3  := __common__( rc_dataset_bo_sorted[3].rc ) ;
finalbo_rc4  := __common__( rc_dataset_bo_sorted[4].rc ) ;
finalbo_rc5  := __common__( rc_dataset_bo_sorted[5].rc ) ;
finalbo_rc6  := __common__( rc_dataset_bo_sorted[6].rc ) ;
finalbo_rc7  := __common__( rc_dataset_bo_sorted[7].rc ) ;
finalbo_rc8  := __common__( rc_dataset_bo_sorted[8].rc ) ;
finalbo_rc9  := __common__( rc_dataset_bo_sorted[9].rc ) ;
finalbo_rc10  := __common__( rc_dataset_bo_sorted[10].rc ) ;
finalbo_rc11  := __common__( rc_dataset_bo_sorted[11].rc ) ;
finalbo_rc12  := __common__( rc_dataset_bo_sorted[12].rc ) ;
finalbo_rc13  := __common__( rc_dataset_bo_sorted[13].rc ) ;
finalbo_rc14  := __common__( rc_dataset_bo_sorted[14].rc ) ;
finalbo_rc15  := __common__( rc_dataset_bo_sorted[15].rc ) ;
finalbo_rc16  := __common__( rc_dataset_bo_sorted[16].rc ) ;
finalbo_rc17  := __common__( rc_dataset_bo_sorted[17].rc ) ;
finalbo_rc18  := __common__( rc_dataset_bo_sorted[18].rc ) ;
finalbo_rc19  := __common__( rc_dataset_bo_sorted[19].rc ) ;
finalbo_rc20  := __common__( rc_dataset_bo_sorted[20].rc ) ;
finalbo_rc21  := __common__( rc_dataset_bo_sorted[21].rc ) ;
finalbo_rc22  := __common__( rc_dataset_bo_sorted[22].rc ) ;
finalbo_rc23  := __common__( rc_dataset_bo_sorted[23].rc ) ;
finalbo_rc24  := __common__( rc_dataset_bo_sorted[24].rc ) ;
finalbo_rc25  := __common__( rc_dataset_bo_sorted[25].rc ) ;
finalbo_rc26  := __common__( rc_dataset_bo_sorted[26].rc ) ;
finalbo_rc27  := __common__( rc_dataset_bo_sorted[27].rc ) ;
finalbo_rc28  := __common__( rc_dataset_bo_sorted[28].rc ) ;
finalbo_rc29  := __common__( rc_dataset_bo_sorted[29].rc ) ;
finalbo_rc30  := __common__( rc_dataset_bo_sorted[30].rc ) ;
finalbo_rc31  := __common__( rc_dataset_bo_sorted[31].rc ) ;
finalbo_rc32  := __common__( rc_dataset_bo_sorted[32].rc ) ;
finalbo_rc33  := __common__( rc_dataset_bo_sorted[33].rc ) ;
finalbo_rc34  := __common__( rc_dataset_bo_sorted[34].rc ) ;
finalbo_rc35  := __common__( rc_dataset_bo_sorted[35].rc ) ;
finalbo_rc36  := __common__( rc_dataset_bo_sorted[36].rc ) ;
finalbo_rc37  := __common__( rc_dataset_bo_sorted[37].rc ) ;
finalbo_rc38  := __common__( rc_dataset_bo_sorted[38].rc ) ;
finalbo_rc39  := __common__( rc_dataset_bo_sorted[39].rc ) ;
finalbo_rc40  := __common__( rc_dataset_bo_sorted[40].rc ) ;
finalbo_rc41  := __common__( rc_dataset_bo_sorted[41].rc ) ;
finalbo_rc42  := __common__( rc_dataset_bo_sorted[42].rc ) ;
finalbo_rc43  := __common__( rc_dataset_bo_sorted[43].rc ) ;
finalbo_rc44  := __common__( rc_dataset_bo_sorted[44].rc ) ;
finalbo_rc45  := __common__( rc_dataset_bo_sorted[45].rc ) ;
finalbo_rc46  := __common__( rc_dataset_bo_sorted[46].rc ) ;
finalbo_rc47  := __common__( rc_dataset_bo_sorted[47].rc ) ;
finalbo_rc48  := __common__( rc_dataset_bo_sorted[48].rc ) ;
finalbo_rc49  := __common__( rc_dataset_bo_sorted[49].rc ) ;
finalbo_rc50  := __common__( rc_dataset_bo_sorted[50].rc ) ;

bo_rc14 := __common__( if((integer)ver_src_id_count <= 0, '', finalbo_rc14) ) ;

bo_rc11 := __common__( if((integer)ver_src_id_count <= 0, '', finalbo_rc11) ) ;

bo_rc12 := __common__( if((integer)ver_src_id_count <= 0, '', finalbo_rc12) ) ;

bo_rc21 := __common__( if((integer)ver_src_id_count <= 0, '', finalbo_rc21) ) ;

bo_rc34 := __common__( if((integer)ver_src_id_count <= 0, '', finalbo_rc34) ) ;

bo_rc38 := __common__( if((integer)ver_src_id_count <= 0, '', finalbo_rc38) ) ;

bo_rc13 := __common__( if((integer)ver_src_id_count <= 0, '', finalbo_rc13) ) ;

bo_rc17 := __common__( if((integer)ver_src_id_count <= 0, '', finalbo_rc17) ) ;

bo_rc32 := __common__( if((integer)ver_src_id_count <= 0, '', finalbo_rc32) ) ;

bo_rc31 := __common__( if((integer)ver_src_id_count <= 0, '', finalbo_rc31) ) ;

bo_rc49 := __common__( if((integer)ver_src_id_count <= 0, '', finalbo_rc49) ) ;

bo_rc5 := __common__( if((integer)ver_src_id_count <= 0, '', finalbo_rc5) ) ;

bo_rc25 := __common__( if((integer)ver_src_id_count <= 0, '', finalbo_rc25) ) ;

bo_rc26 := __common__( if((integer)ver_src_id_count <= 0, '', finalbo_rc26) ) ;

bo_rc43 := __common__( if((integer)ver_src_id_count <= 0, '', finalbo_rc43) ) ;

bo_rc50 := __common__( if((integer)ver_src_id_count <= 0, '', finalbo_rc50) ) ;

bo_rc2 := __common__( if((integer)ver_src_id_count <= 0, '', finalbo_rc2) ) ;

bo_rc42 := __common__( if((integer)ver_src_id_count <= 0, '', finalbo_rc42) ) ;

bo_rc48 := __common__( if((integer)ver_src_id_count <= 0, '', finalbo_rc48) ) ;

bo_rc7 := __common__( if((integer)ver_src_id_count <= 0, '', finalbo_rc7) ) ;

bo_rc30 := __common__( if((integer)ver_src_id_count <= 0, '', finalbo_rc30) ) ;

bo_rc10 := __common__( if((integer)ver_src_id_count <= 0, '', finalbo_rc10) ) ;

bo_rc46 := __common__( if((integer)ver_src_id_count <= 0, '', finalbo_rc46) ) ;

bo_rc47 := __common__( if((integer)ver_src_id_count <= 0, '', finalbo_rc47) ) ;

bo_rc37 := __common__( if((integer)ver_src_id_count <= 0, '', finalbo_rc37) ) ;

bo_rc1 := __common__( if((integer)ver_src_id_count <= 0, 'B068', finalbo_rc1) ) ;

bo_rc36 := __common__( if((integer)ver_src_id_count <= 0, '', finalbo_rc36) ) ;

bo_rc40 := __common__( if((integer)ver_src_id_count <= 0, '', finalbo_rc40) ) ;

bo_rc19 := __common__( if((integer)ver_src_id_count <= 0, '', finalbo_rc19) ) ;

bo_rc44 := __common__( if((integer)ver_src_id_count <= 0, '', finalbo_rc44) ) ;

bo_rc4 := __common__( if((integer)ver_src_id_count <= 0, '', finalbo_rc4) ) ;

bo_rc6 := __common__( if((integer)ver_src_id_count <= 0, '', finalbo_rc6) ) ;

bo_rc45 := __common__( if((integer)ver_src_id_count <= 0, '', finalbo_rc45) ) ;

bo_rc22 := __common__( if((integer)ver_src_id_count <= 0, '', finalbo_rc22) ) ;

bo_rc35 := __common__( if((integer)ver_src_id_count <= 0, '', finalbo_rc35) ) ;

bo_rc28 := __common__( if((integer)ver_src_id_count <= 0, '', finalbo_rc28) ) ;

bo_rc3 := __common__( if((integer)ver_src_id_count <= 0, '', finalbo_rc3) ) ;

bo_rc29 := __common__( if((integer)ver_src_id_count <= 0, '', finalbo_rc29) ) ;

bo_rc16 := __common__( if((integer)ver_src_id_count <= 0, '', finalbo_rc16) ) ;

bo_rc24 := __common__( if((integer)ver_src_id_count <= 0, '', finalbo_rc24) ) ;

bo_rc20 := __common__( if((integer)ver_src_id_count <= 0, '', finalbo_rc20) ) ;

bo_rc33 := __common__( if((integer)ver_src_id_count <= 0, '', finalbo_rc33) ) ;

bo_rc27 := __common__( if((integer)ver_src_id_count <= 0, '', finalbo_rc27) ) ;

bo_rc18 := __common__( if((integer)ver_src_id_count <= 0, '', finalbo_rc18) ) ;

bo_rc39 := __common__( if((integer)ver_src_id_count <= 0, '', finalbo_rc39) ) ;

bo_rc9 := __common__( if((integer)ver_src_id_count <= 0, '', finalbo_rc9) ) ;

bo_rc15 := __common__( if((integer)ver_src_id_count <= 0, '', finalbo_rc15) ) ;

bo_rc23 := __common__( if((integer)ver_src_id_count <= 0, '', finalbo_rc23) ) ;

bo_rc8 := __common__( if((integer)ver_src_id_count <= 0, '', finalbo_rc8) ) ;

bo_rc41 := __common__( if((integer)ver_src_id_count <= 0, '', finalbo_rc41) ) ;

slbo_rc1_1 := __common__( bo_rc1 ) ;

slbo_rc2_1 := __common__( bo_rc2 ) ;

slbo_rc3_1 := __common__( bo_rc3 ) ;

slbo_rc4_1 := __common__( bo_rc4 ) ;

slbo_rc4 := __common__( if(slbo1702_0_2 >= 832, '', slbo_rc4_1) ) ;

slbo_rc2 := __common__( if(slbo1702_0_2 >= 832, '', slbo_rc2_1) ) ;

slbo_rc1 := __common__( if(slbo1702_0_2 >= 832, '', slbo_rc1_1) ) ;

slbo_rc3 := __common__( if(slbo1702_0_2 >= 832, '', slbo_rc3_1) ) ;



//*************************************************************************************//
//                      Reason Code Overrides 
//*************************************************************************************//
HRILayout := RECORD
	STRING5 HRI := '';
END;

reasons := DATASET([{slbo_rc1}, {slbo_rc2}, {slbo_rc3}, {slbo_rc4}], HRILayout);

zeros := DATASET([{'00'}, {'00'}, {'00'}, {'00'}], HRILayout);
reasonCodes := CHOOSEN(reasons & zeros, 4); // Keep up to 4 reason codes

	#if(MODEL_DEBUG)
                    self.sysdate                          := sysdate;
                    self._ver_src_id_br_pos               := _ver_src_id_br_pos;
                    self._ver_src_id__br                  := _ver_src_id__br;
                    self._ver_src_id_fdate_br             := _ver_src_id_fdate_br;
                    self._ver_src_id_fdate_br2            := _ver_src_id_fdate_br2;
                    self.mth__ver_src_id_fdate_br         := mth__ver_src_id_fdate_br;
                    self._ver_src_id_bm_pos               := _ver_src_id_bm_pos;
                    self._ver_src_id__bm                  := _ver_src_id__bm;
                    self._ver_src_id_i_pos                := _ver_src_id_i_pos;
                    self._ver_src_id__i                   := _ver_src_id__i;
                    self._ver_src_id_p_pos                := _ver_src_id_p_pos;
                    self._ver_src_id__p                   := _ver_src_id__p;
                    self._ver_src_id_ldate_p              := _ver_src_id_ldate_p;
                    self._ver_src_id_ldate_p2             := _ver_src_id_ldate_p2;
                    self.mth__ver_src_id_ldate_p          := mth__ver_src_id_ldate_p;
                    self._ver_src_id_v2_pos               := _ver_src_id_v2_pos;
                    self._ver_src_id_fdate_v22            := _ver_src_id_fdate_v22;
                    self.mth__ver_src_id_fdate_v2         := mth__ver_src_id_fdate_v2;
                    self._ver_src_id_ldate_v22            := _ver_src_id_ldate_v22;
                    self.mth__ver_src_id_ldate_v2         := mth__ver_src_id_ldate_v2;
                    self._ver_src_id_ut_pos               := _ver_src_id_ut_pos;
                    self._ver_src_id__ut                  := _ver_src_id__ut;
                    self._ver_src_id_gb_pos               := _ver_src_id_gb_pos;
                    self._ver_src_id_fdate_gb             := _ver_src_id_fdate_gb;
                    self._ver_src_id_fdate_gb2            := _ver_src_id_fdate_gb2;
                    self.mth__ver_src_id_fdate_gb         := mth__ver_src_id_fdate_gb;
                    self._ver_src_id_ldate_gb             := _ver_src_id_ldate_gb;
                    self._ver_src_id_ldate_gb2            := _ver_src_id_ldate_gb2;
                    self.mth__ver_src_id_ldate_gb         := mth__ver_src_id_ldate_gb;
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
                    self.truebiz_ln                       := truebiz_ln;
                    self.bx_addr_assessed_value           := bx_addr_assessed_value;
                    self.bv_assoc_derog_pct               := bv_assoc_derog_pct;
                    self._lien_filed_lastseen             := _lien_filed_lastseen;
                    self.bv_lien_filed_mth_ls             := bv_lien_filed_mth_ls;
                    self.bv_sos_current_standing          := bv_sos_current_standing;
                    self._sos_agent_change_lastseen       := _sos_agent_change_lastseen;
                    self.bv_sos_mth_agent_change          := bv_sos_mth_agent_change;
                    self.bv_assoc_derog_type_count        := bv_assoc_derog_type_count;
                    self.bx_addr_lres                     := bx_addr_lres;
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
                    self.num_pos_sources                  := num_pos_sources;
                    self.num_neg_sources                  := num_neg_sources;
                    self.bv_ver_src_derog_ratio           := bv_ver_src_derog_ratio;
                    self.bv_ver_src_id_mth_since_fs       := bv_ver_src_id_mth_since_fs;
                    self._judg_filed_lastseen             := _judg_filed_lastseen;
                    self.bv_judg_filed_mth_ls             := bv_judg_filed_mth_ls;
                    self.bv_mth_ver_src_br_fs             := bv_mth_ver_src_br_fs;
                    self.bv_mth_ver_src_p_ls              := bv_mth_ver_src_p_ls;
                    self.bv_lien_ft_count                 := bv_lien_ft_count;
                    self.bv_assoc_judg_tot                := bv_assoc_judg_tot;
                    self._judg_filed_firstseen            := _judg_filed_firstseen;
                    self.bv_judg_filed_mth_fs             := bv_judg_filed_mth_fs;
                    self.bv_lien_total_amount             := bv_lien_total_amount;
                    self.bv_assoc_felony_tot              := bv_assoc_felony_tot;
                    self.bv_ver_src_id_activity12         := bv_ver_src_id_activity12;
                    self._ucc_firstseen                   := _ucc_firstseen;
                    self.bv_ucc_mth_fs                    := bv_ucc_mth_fs;
                    self.bo_v01_w                         := bo_v01_w;
                    self.bo_aa_code_01                    := bo_aa_code_01;
                    self.bo_aa_dist_01                    := bo_aa_dist_01;
                    self.bo_v02_w                         := bo_v02_w;
                    self.bo_aa_code_02                    := bo_aa_code_02;
                    self.bo_aa_dist_02                    := bo_aa_dist_02;
                    self.bo_v03_w                         := bo_v03_w;
                    self.bo_aa_code_03                    := bo_aa_code_03;
                    self.bo_aa_dist_03                    := bo_aa_dist_03;
                    self.bo_v04_w                         := bo_v04_w;
                    self.bo_aa_code_04                    := bo_aa_code_04;
                    self.bo_aa_dist_04                    := bo_aa_dist_04;
                    self.bo_v05_w                         := bo_v05_w;
                    self.bo_aa_code_05                    := bo_aa_code_05;
                    self.bo_aa_dist_05                    := bo_aa_dist_05;
                    self.bo_v06_w                         := bo_v06_w;
                    self.bo_aa_code_06                    := bo_aa_code_06;
                    self.bo_aa_dist_06                    := bo_aa_dist_06;
                    self.bo_v07_w                         := bo_v07_w;
                    self.bo_aa_code_07                    := bo_aa_code_07;
                    self.bo_aa_dist_07                    := bo_aa_dist_07;
                    self.bo_v08_w                         := bo_v08_w;
                    self.bo_aa_code_08                    := bo_aa_code_08;
                    self.bo_aa_dist_08                    := bo_aa_dist_08;
                    self.bo_v09_w                         := bo_v09_w;
                    self.bo_aa_code_09                    := bo_aa_code_09;
                    self.bo_aa_dist_09                    := bo_aa_dist_09;
                    self.bo_v10_w                         := bo_v10_w;
                    self.bo_aa_code_10                    := bo_aa_code_10;
                    self.bo_aa_dist_10                    := bo_aa_dist_10;
                    self.bo_v11_w                         := bo_v11_w;
                    self.bo_aa_code_11                    := bo_aa_code_11;
                    self.bo_aa_dist_11                    := bo_aa_dist_11;
                    self.bo_v12_w                         := bo_v12_w;
                    self.bo_aa_code_12                    := bo_aa_code_12;
                    self.bo_aa_dist_12                    := bo_aa_dist_12;
                    self.bo_v13_w                         := bo_v13_w;
                    self.bo_aa_code_13                    := bo_aa_code_13;
                    self.bo_aa_dist_13                    := bo_aa_dist_13;
                    self.bo_v14_w                         := bo_v14_w;
                    self.bo_aa_code_14                    := bo_aa_code_14;
                    self.bo_aa_dist_14                    := bo_aa_dist_14;
                    self.bo_v15_w                         := bo_v15_w;
                    self.bo_aa_code_15                    := bo_aa_code_15;
                    self.bo_aa_dist_15                    := bo_aa_dist_15;
                    self.bo_v16_w                         := bo_v16_w;
                    self.bo_aa_code_16                    := bo_aa_code_16;
                    self.bo_aa_dist_16                    := bo_aa_dist_16;
                    self.bo_v17_w                         := bo_v17_w;
                    self.bo_aa_code_17                    := bo_aa_code_17;
                    self.bo_aa_dist_17                    := bo_aa_dist_17;
                    self.bo_v18_w                         := bo_v18_w;
                    self.bo_aa_code_18                    := bo_aa_code_18;
                    self.bo_aa_dist_18                    := bo_aa_dist_18;
                    self.bo_v19_w                         := bo_v19_w;
                    self.bo_aa_code_19                    := bo_aa_code_19;
                    self.bo_aa_dist_19                    := bo_aa_dist_19;
                    self.bo_rcvalueb037                   := bo_rcvalueb037;
                    self.bo_rcvalueb069                   := bo_rcvalueb069;
                    self.bo_rcvalueb026                   := bo_rcvalueb026;
                    self.bo_rcvalueb034                   := bo_rcvalueb034;
                    self.bo_rcvalueb052                   := bo_rcvalueb052;
                    self.bo_rcvalueb031                   := bo_rcvalueb031;
                    self.bo_rcvalueb036                   := bo_rcvalueb036;
                    self.bo_rcvalueb017                   := bo_rcvalueb017;
                    self.bo_rcvalueb063                   := bo_rcvalueb063;
                    self.bo_rcvalueb035                   := bo_rcvalueb035;
                    self.bo_rcvalueb075                   := bo_rcvalueb075;
                    self.bo_rcvalueb074                   := bo_rcvalueb074;
                    self.bo_rcvalueb079                   := bo_rcvalueb079;
                    self.bo_rcvalueb078                   := bo_rcvalueb078;
                    self.bo_rcvalueb076                   := bo_rcvalueb076;
                    self.bo_rcvalueb066                   := bo_rcvalueb066;
                    self.bo_rcvalueb056                   := bo_rcvalueb056;
                    self.bo_rcvalueb059                   := bo_rcvalueb059;
                    self.bo_rcvalueb070                   := bo_rcvalueb070;
                    self.bo_lgt                           := bo_lgt;
                    self.base                             := base;
                    self.pts                              := pts;
                    self.lgt                              := lgt;
                    self.slbo1702_0_2                     := slbo1702_0_2;
                    self.finalbo_rc1                      := finalbo_rc1;
                    self.finalbo_rc2                      := finalbo_rc2;
                    self.finalbo_rc3                      := finalbo_rc3;
                    self.finalbo_rc4                      := finalbo_rc4;
                    self.finalbo_rc5                      := finalbo_rc5;
                    self.finalbo_rc6                      := finalbo_rc6;
                    self.finalbo_rc7                      := finalbo_rc7;
                    self.finalbo_rc8                      := finalbo_rc8;
                    self.finalbo_rc9                      := finalbo_rc9;
                    self.finalbo_rc10                     := finalbo_rc10;
                    self.finalbo_rc11                     := finalbo_rc11;
                    self.finalbo_rc12                     := finalbo_rc12;
                    self.finalbo_rc13                     := finalbo_rc13;
                    self.finalbo_rc14                     := finalbo_rc14;
                    self.finalbo_rc15                     := finalbo_rc15;
                    self.finalbo_rc16                     := finalbo_rc16;
                    self.finalbo_rc17                     := finalbo_rc17;
                    self.finalbo_rc18                     := finalbo_rc18;
                    self.finalbo_rc19                     := finalbo_rc19;
                    self.finalbo_rc20                     := finalbo_rc20;
                    self.finalbo_rc21                     := finalbo_rc21;
                    self.finalbo_rc22                     := finalbo_rc22;
                    self.finalbo_rc23                     := finalbo_rc23;
                    self.finalbo_rc24                     := finalbo_rc24;
                    self.finalbo_rc25                     := finalbo_rc25;
                    self.finalbo_rc26                     := finalbo_rc26;
                    self.finalbo_rc27                     := finalbo_rc27;
                    self.finalbo_rc28                     := finalbo_rc28;
                    self.finalbo_rc29                     := finalbo_rc29;
                    self.finalbo_rc30                     := finalbo_rc30;
                    self.finalbo_rc31                     := finalbo_rc31;
                    self.finalbo_rc32                     := finalbo_rc32;
                    self.finalbo_rc33                     := finalbo_rc33;
                    self.finalbo_rc34                     := finalbo_rc34;
                    self.finalbo_rc35                     := finalbo_rc35;
                    self.finalbo_rc36                     := finalbo_rc36;
                    self.finalbo_rc37                     := finalbo_rc37;
                    self.finalbo_rc38                     := finalbo_rc38;
                    self.finalbo_rc39                     := finalbo_rc39;
                    self.finalbo_rc40                     := finalbo_rc40;
                    self.finalbo_rc41                     := finalbo_rc41;
                    self.finalbo_rc42                     := finalbo_rc42;
                    self.finalbo_rc43                     := finalbo_rc43;
                    self.finalbo_rc44                     := finalbo_rc44;
                    self.finalbo_rc45                     := finalbo_rc45;
                    self.finalbo_rc46                     := finalbo_rc46;
                    self.finalbo_rc47                     := finalbo_rc47;
                    self.finalbo_rc48                     := finalbo_rc48;
                    self.finalbo_rc49                     := finalbo_rc49;
                    self.finalbo_rc50                     := finalbo_rc50;
                    self.bo_rc28                          := bo_rc28;
                    self.bo_rc27                          := bo_rc27;
                    self.bo_rc25                          := bo_rc25;
                    self.bo_rc8                           := bo_rc8;
                    self.bo_rc29                          := bo_rc29;
                    self.bo_rc23                          := bo_rc23;
                    self.bo_rc15                          := bo_rc15;
                    self.bo_rc16                          := bo_rc16;
                    self.bo_rc12                          := bo_rc12;
                    self.bo_rc41                          := bo_rc41;
                    self.bo_rc30                          := bo_rc30;
                    self.bo_rc36                          := bo_rc36;
                    self.bo_rc18                          := bo_rc18;
                    self.bo_rc19                          := bo_rc19;
                    self.bo_rc31                          := bo_rc31;
                    self.bo_rc3                           := bo_rc3;
                    self.bo_rc34                          := bo_rc34;
                    self.bo_rc44                          := bo_rc44;
                    self.bo_rc50                          := bo_rc50;
                    self.bo_rc2                           := bo_rc2;
                    self.bo_rc26                          := bo_rc26;
                    self.bo_rc33                          := bo_rc33;
                    self.bo_rc21                          := bo_rc21;
                    self.bo_rc22                          := bo_rc22;
                    self.bo_rc43                          := bo_rc43;
                    self.bo_rc48                          := bo_rc48;
                    self.bo_rc1                           := bo_rc1;
                    self.bo_rc46                          := bo_rc46;
                    self.bo_rc40                          := bo_rc40;
                    self.bo_rc10                          := bo_rc10;
                    self.bo_rc4                           := bo_rc4;
                    self.bo_rc42                          := bo_rc42;
                    self.bo_rc20                          := bo_rc20;
                    self.bo_rc24                          := bo_rc24;
                    self.bo_rc11                          := bo_rc11;
                    self.bo_rc14                          := bo_rc14;
                    self.bo_rc32                          := bo_rc32;
                    self.bo_rc35                          := bo_rc35;
                    self.bo_rc13                          := bo_rc13;
                    self.bo_rc49                          := bo_rc49;
                    self.bo_rc47                          := bo_rc47;
                    self.bo_rc9                           := bo_rc9;
                    self.bo_rc7                           := bo_rc7;
                    self.bo_rc37                          := bo_rc37;
                    self.bo_rc6                           := bo_rc6;
                    self.bo_rc38                          := bo_rc38;
                    self.bo_rc17                          := bo_rc17;
                    self.bo_rc39                          := bo_rc39;
                    self.bo_rc45                          := bo_rc45;
                    self.bo_rc5                           := bo_rc5;
                    self.slbo_rc1                         := slbo_rc1;
                    self.slbo_rc3                         := slbo_rc3;
                    self.slbo_rc2                         := slbo_rc2;
                    self.slbo_rc4                         := slbo_rc4;               

										SELF.busShell := le;
	#else
		SELF.ri := PROJECT(reasonCodes, TRANSFORM(Risk_Indicators.Layout_Desc,
																							SELF.hri := LEFT.hri,
																							SELF.desc := Risk_Indicators.getHRIDesc(LEFT.hri)
																					));
		SELF.score := (STRING3)SLBO1702_0_2;
		SELF.seq := le.input_echo.seq;
	#end
	END;

		model := project(BusShell, doModel(LEFT));
		
		RETURN(model);
END;
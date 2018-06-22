import Std, risk_indicators, riskwise, riskwisefcra, ut, easi, Models;

blank_ip := dataset( [{0}], riskwise.Layout_IP2O )[1];

export FP1801_1_0(dataset(risk_indicators.Layout_Boca_Shell) clam,
                  integer1 num_reasons)
									 := FUNCTION
									
		// FP_DEBUG := True;
		FP_DEBUG := False;
		
		isFCRA := False;

	#if(FP_DEBUG)
	Layout_Debug := RECORD
	
	/* Model Intermediate Variables */
	//STRING NULL;
                    integer sysdate                          ; // := sysdate;
                    integer ver_src_am_pos                   ; // := ver_src_am_pos;
                    string _ver_src_fdate_am                ; // := _ver_src_fdate_am;
                    integer ver_src_fdate_am                 ; // := ver_src_fdate_am;
                    integer ver_src_ar_pos                   ; // := ver_src_ar_pos;
                    string _ver_src_fdate_ar                ; // := _ver_src_fdate_ar;
                    integer ver_src_fdate_ar                 ; // := ver_src_fdate_ar;
                    integer ver_src_ba_pos                   ; // := ver_src_ba_pos;
                    string _ver_src_fdate_ba                ; // := _ver_src_fdate_ba;
                    integer ver_src_fdate_ba                 ; // := ver_src_fdate_ba;
                    integer ver_src_cg_pos                   ; // := ver_src_cg_pos;
                    string _ver_src_fdate_cg                ; // := _ver_src_fdate_cg;
                    integer ver_src_fdate_cg                 ; // := ver_src_fdate_cg;
                    integer ver_src_da_pos                   ; // := ver_src_da_pos;
                    string _ver_src_fdate_da                ; // := _ver_src_fdate_da;
                    integer ver_src_fdate_da                 ; // := ver_src_fdate_da;
                    integer ver_src_d_pos                    ; // := ver_src_d_pos;
                    string _ver_src_fdate_d                 ; // := _ver_src_fdate_d;
                    integer ver_src_fdate_d                  ; // := ver_src_fdate_d;
                    integer ver_src_dl_pos                   ; // := ver_src_dl_pos;
                    string _ver_src_fdate_dl                ; // := _ver_src_fdate_dl;
                    integer ver_src_fdate_dl                 ; // := ver_src_fdate_dl;
                    integer ver_src_eb_pos                   ; // := ver_src_eb_pos;
                    string _ver_src_fdate_eb                ; // := _ver_src_fdate_eb;
                    integer ver_src_fdate_eb                 ; // := ver_src_fdate_eb;
                    integer ver_src_e1_pos                   ; // := ver_src_e1_pos;
                    string _ver_src_fdate_e1                ; // := _ver_src_fdate_e1;
                    integer ver_src_fdate_e1                 ; // := ver_src_fdate_e1;
                    integer ver_src_e2_pos                   ; // := ver_src_e2_pos;
                    string _ver_src_fdate_e2                ; // := _ver_src_fdate_e2;
                    integer ver_src_fdate_e2                 ; // := ver_src_fdate_e2;
                    integer ver_src_e3_pos                   ; // := ver_src_e3_pos;
                    string _ver_src_fdate_e3                ; // := _ver_src_fdate_e3;
                    integer ver_src_fdate_e3                 ; // := ver_src_fdate_e3;
                    integer ver_src_fe_pos                   ; // := ver_src_fe_pos;
                    string _ver_src_fdate_fe                ; // := _ver_src_fdate_fe;
                    integer ver_src_fdate_fe                 ; // := ver_src_fdate_fe;
                    integer ver_src_ff_pos                   ; // := ver_src_ff_pos;
                    string _ver_src_fdate_ff                ; // := _ver_src_fdate_ff;
                    integer ver_src_fdate_ff                 ; // := ver_src_fdate_ff;
                    integer ver_src_p_pos                    ; // := ver_src_p_pos;
                    string _ver_src_fdate_p                 ; // := _ver_src_fdate_p;
                    integer ver_src_fdate_p                  ; // := ver_src_fdate_p;
                    integer ver_src_pl_pos                   ; // := ver_src_pl_pos;
                    string _ver_src_fdate_pl                ; // := _ver_src_fdate_pl;
                    integer ver_src_fdate_pl                 ; // := ver_src_fdate_pl;
                    integer ver_src_sl_pos                   ; // := ver_src_sl_pos;
                    string _ver_src_fdate_sl                ; // := _ver_src_fdate_sl;
                    integer ver_src_fdate_sl                 ; // := ver_src_fdate_sl;
                    integer ver_src_v_pos                    ; // := ver_src_v_pos;
                    string _ver_src_fdate_v                 ; // := _ver_src_fdate_v;
                    integer ver_src_fdate_v                  ; // := ver_src_fdate_v;
                    integer ver_src_vo_pos                   ; // := ver_src_vo_pos;
                    string _ver_src_fdate_vo                ; // := _ver_src_fdate_vo;
                    integer ver_src_fdate_vo                 ; // := ver_src_fdate_vo;
                    integer ver_src_w_pos                    ; // := ver_src_w_pos;
                    string _ver_src_fdate_w                 ; // := _ver_src_fdate_w;
                    integer ver_src_fdate_w                  ; // := ver_src_fdate_w;
                    string iv_add_apt                       ; // := iv_add_apt;
                    integer nf_average_rel_home_val          ; // := nf_average_rel_home_val;
                    integer nf_fp_prevaddrmurderindex        ; // := nf_fp_prevaddrmurderindex;
                    integer earliest_cred_date_all           ; // := earliest_cred_date_all;
                    integer nf_m_src_credentialed_fs         ; // := nf_m_src_credentialed_fs;
                    integer iv_prv_addr_lres                 ; // := iv_prv_addr_lres;
                    integer nf_inq_mortgage_count            ; // := nf_inq_mortgage_count;
                    integer nf_inq_count24                   ; // := nf_inq_count24;
                    integer rv_l79_adls_per_sfd_addr         ; // := rv_l79_adls_per_sfd_addr;
                    real nonfcra_v01_w                    ; // := nonfcra_v01_w;
                    real nonfcra_v02_w                    ; // := nonfcra_v02_w;
                    real nonfcra_v03_w                    ; // := nonfcra_v03_w;
                    real nonfcra_v04_w                    ; // := nonfcra_v04_w;
                    real nonfcra_v05_w                    ; // := nonfcra_v05_w;
                    real nonfcra_v06_w                    ; // := nonfcra_v06_w;
                    real nonfcra_v07_w                    ; // := nonfcra_v07_w;
                    real nonfcra_lgt                      ; // := nonfcra_lgt;
                    integer base                             ; // := base;
                    integer pts                              ; // := pts;
                    integer odds                             ; // := odds;
                    integer fp1801_1_0                       ; // := fp1801_1_0;
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
	truedid                          := le.truedid;
	out_unit_desig                   := le.shell_input.unit_desig;
	out_sec_range                    := le.shell_input.sec_range;
	out_addr_type                    := le.shell_input.addr_type;
	rc_dwelltype                     := le.iid.dwelltype;
	ver_sources                      := le.header_summary.ver_sources;
	ver_sources_first_seen           := le.header_summary.ver_sources_first_seen_date;
	addrpop                          := le.input_validation.address;
	add_prev_lres                    := le.lres3;
	add_prev_pop                     := le.addrPop3;
	adls_per_addr_curr               := le.velocity_counters.adls_per_addr_current;
	inq_count24                      := le.acc_logs.inquiries.count24;
	inq_mortgage_count               := le.acc_logs.mortgage.counttotal;
	fp_prevaddrmurderindex           := le.fdattributesv2.prevaddrmurderindex;
	rel_count                        := le.relatives.relative_count;
	rel_homeunder50_count            := le.relatives.relative_homeunder50_count;
	rel_homeunder100_count           := le.relatives.relative_homeunder100_count;
	rel_homeunder150_count           := le.relatives.relative_homeunder150_count;
	rel_homeunder200_count           := le.relatives.relative_homeunder200_count;
	rel_homeunder300_count           := le.relatives.relative_homeunder300_count;
	rel_homeunder500_count           := le.relatives.relative_homeunder500_count;
	rel_homeover500_count            := le.relatives.relative_homeover500_count;


	/* ***********************************************************
	 *   Generated ECL         *
	 ************************************************************* */


NULL := -999999999;

sysdate := common.sas_date(if(le.historydate=999999, (STRING8)Std.Date.Today(), (string6)le.historydate+'01'));

ver_src_am_pos := Models.Common.findw_cpp(ver_sources, 'AM' , '  ,', 'ie');

_ver_src_fdate_am := if(ver_src_am_pos > 0, Models.Common.getw(ver_sources_first_seen, ver_src_am_pos), '0');

ver_src_fdate_am := common.sas_date((string)(_ver_src_fdate_am));

ver_src_ar_pos := Models.Common.findw_cpp(ver_sources, 'AR' , '  ,', 'ie');

_ver_src_fdate_ar := if(ver_src_ar_pos > 0, Models.Common.getw(ver_sources_first_seen, ver_src_ar_pos), '0');

ver_src_fdate_ar := common.sas_date((string)(_ver_src_fdate_ar));

ver_src_ba_pos := Models.Common.findw_cpp(ver_sources, 'BA' , '  ,', 'ie');

_ver_src_fdate_ba := if(ver_src_ba_pos > 0, Models.Common.getw(ver_sources_first_seen, ver_src_ba_pos), '0');

ver_src_fdate_ba := common.sas_date((string)(_ver_src_fdate_ba));

ver_src_cg_pos := Models.Common.findw_cpp(ver_sources, 'CG' , '  ,', 'ie');

_ver_src_fdate_cg := if(ver_src_cg_pos > 0, Models.Common.getw(ver_sources_first_seen, ver_src_cg_pos), '0');

ver_src_fdate_cg := common.sas_date((string)(_ver_src_fdate_cg));

ver_src_da_pos := Models.Common.findw_cpp(ver_sources, 'DA' , '  ,', 'ie');

_ver_src_fdate_da := if(ver_src_da_pos > 0, Models.Common.getw(ver_sources_first_seen, ver_src_da_pos), '0');

ver_src_fdate_da := common.sas_date((string)(_ver_src_fdate_da));

ver_src_d_pos := Models.Common.findw_cpp(ver_sources, 'D' , '  ,', 'ie');

_ver_src_fdate_d := if(ver_src_d_pos > 0, Models.Common.getw(ver_sources_first_seen, ver_src_d_pos), '0');

ver_src_fdate_d := common.sas_date((string)(_ver_src_fdate_d));

ver_src_dl_pos := Models.Common.findw_cpp(ver_sources, 'DL' , '  ,', 'ie');

_ver_src_fdate_dl := if(ver_src_dl_pos > 0, Models.Common.getw(ver_sources_first_seen, ver_src_dl_pos), '0');

ver_src_fdate_dl := common.sas_date((string)(_ver_src_fdate_dl));

ver_src_eb_pos := Models.Common.findw_cpp(ver_sources, 'EB' , '  ,', 'ie');

_ver_src_fdate_eb := if(ver_src_eb_pos > 0, Models.Common.getw(ver_sources_first_seen, ver_src_eb_pos), '0');

ver_src_fdate_eb := common.sas_date((string)(_ver_src_fdate_eb));

ver_src_e1_pos := Models.Common.findw_cpp(ver_sources, 'E1' , '  ,', 'ie');

_ver_src_fdate_e1 := if(ver_src_e1_pos > 0, Models.Common.getw(ver_sources_first_seen, ver_src_e1_pos), '0');

ver_src_fdate_e1 := common.sas_date((string)(_ver_src_fdate_e1));

ver_src_e2_pos := Models.Common.findw_cpp(ver_sources, 'E2' , '  ,', 'ie');

_ver_src_fdate_e2 := if(ver_src_e2_pos > 0, Models.Common.getw(ver_sources_first_seen, ver_src_e2_pos), '0');

ver_src_fdate_e2 := common.sas_date((string)(_ver_src_fdate_e2));

ver_src_e3_pos := Models.Common.findw_cpp(ver_sources, 'E3' , '  ,', 'ie');

_ver_src_fdate_e3 := if(ver_src_e3_pos > 0, Models.Common.getw(ver_sources_first_seen, ver_src_e3_pos), '0');

ver_src_fdate_e3 := common.sas_date((string)(_ver_src_fdate_e3));

ver_src_fe_pos := Models.Common.findw_cpp(ver_sources, 'FE' , '  ,', 'ie');

_ver_src_fdate_fe := if(ver_src_fe_pos > 0, Models.Common.getw(ver_sources_first_seen, ver_src_fe_pos), '0');

ver_src_fdate_fe := common.sas_date((string)(_ver_src_fdate_fe));

ver_src_ff_pos := Models.Common.findw_cpp(ver_sources, 'FF' , '  ,', 'ie');

_ver_src_fdate_ff := if(ver_src_ff_pos > 0, Models.Common.getw(ver_sources_first_seen, ver_src_ff_pos), '0');

ver_src_fdate_ff := common.sas_date((string)(_ver_src_fdate_ff));

ver_src_p_pos := Models.Common.findw_cpp(ver_sources, 'P' , '  ,', 'ie');

_ver_src_fdate_p := if(ver_src_p_pos > 0, Models.Common.getw(ver_sources_first_seen, ver_src_p_pos), '0');

ver_src_fdate_p := common.sas_date((string)(_ver_src_fdate_p));

ver_src_pl_pos := Models.Common.findw_cpp(ver_sources, 'PL' , '  ,', 'ie');

_ver_src_fdate_pl := if(ver_src_pl_pos > 0, Models.Common.getw(ver_sources_first_seen, ver_src_pl_pos), '0');

ver_src_fdate_pl := common.sas_date((string)(_ver_src_fdate_pl));

ver_src_sl_pos := Models.Common.findw_cpp(ver_sources, 'SL' , '  ,', 'ie');

_ver_src_fdate_sl := if(ver_src_sl_pos > 0, Models.Common.getw(ver_sources_first_seen, ver_src_sl_pos), '0');

ver_src_fdate_sl := common.sas_date((string)(_ver_src_fdate_sl));

ver_src_v_pos := Models.Common.findw_cpp(ver_sources, 'V' , '  ,', 'ie');

_ver_src_fdate_v := if(ver_src_v_pos > 0, Models.Common.getw(ver_sources_first_seen, ver_src_v_pos), '0');

ver_src_fdate_v := common.sas_date((string)(_ver_src_fdate_v));

ver_src_vo_pos := Models.Common.findw_cpp(ver_sources, 'VO' , '  ,', 'ie');

_ver_src_fdate_vo := if(ver_src_vo_pos > 0, Models.Common.getw(ver_sources_first_seen, ver_src_vo_pos), '0');

ver_src_fdate_vo := common.sas_date((string)(_ver_src_fdate_vo));

ver_src_w_pos := Models.Common.findw_cpp(ver_sources, 'W' , '  ,', 'ie');

_ver_src_fdate_w := if(ver_src_w_pos > 0, Models.Common.getw(ver_sources_first_seen, ver_src_w_pos), '0');

ver_src_fdate_w := common.sas_date((string)(_ver_src_fdate_w));

iv_add_apt := __common__( if(StringLib.StringToUpperCase(trim(rc_dwelltype, LEFT, RIGHT)) = 'A' or StringLib.StringToUpperCase(trim(out_addr_type, LEFT, RIGHT)) = 'H' or not(out_unit_desig = '') or not(out_sec_range = ''), '1', '0'));

nf_average_rel_home_val := map(
    not(truedid)                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      => NULL,
    rel_count = 0                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                     => -1,
    if(max(rel_homeunder50_count, rel_homeunder100_count, rel_homeunder150_count, rel_homeunder200_count, rel_homeunder300_count, rel_homeunder500_count, rel_homeover500_count) = NULL, NULL, sum(if(rel_homeunder50_count = NULL, 0, rel_homeunder50_count), if(rel_homeunder100_count = NULL, 0, rel_homeunder100_count), if(rel_homeunder150_count = NULL, 0, rel_homeunder150_count), if(rel_homeunder200_count = NULL, 0, rel_homeunder200_count), if(rel_homeunder300_count = NULL, 0, rel_homeunder300_count), if(rel_homeunder500_count = NULL, 0, rel_homeunder500_count), if(rel_homeover500_count = NULL, 0, rel_homeover500_count))) = 0 => 0,
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                         if (if(max(rel_homeunder50_count * 50, rel_homeunder100_count * 100, rel_homeunder150_count * 150, rel_homeunder200_count * 200, rel_homeunder300_count * 300, rel_homeunder500_count * 500, rel_homeover500_count * 750) = NULL, NULL, sum(if(rel_homeunder50_count * 50 = NULL, 0, rel_homeunder50_count * 50), if(rel_homeunder100_count * 100 = NULL, 0, rel_homeunder100_count * 100), if(rel_homeunder150_count * 150 = NULL, 0, rel_homeunder150_count * 150), if(rel_homeunder200_count * 200 = NULL, 0, rel_homeunder200_count * 200), if(rel_homeunder300_count * 300 = NULL, 0, rel_homeunder300_count * 300), if(rel_homeunder500_count * 500 = NULL, 0, rel_homeunder500_count * 500), if(rel_homeover500_count * 750 = NULL, 0, rel_homeover500_count * 750))) / if(max(rel_homeunder50_count, rel_homeunder100_count, rel_homeunder150_count, rel_homeunder200_count, rel_homeunder300_count, rel_homeunder500_count, rel_homeover500_count) = NULL, NULL, sum(if(rel_homeunder50_count = NULL, 0, rel_homeunder50_count), if(rel_homeunder100_count = NULL, 0, rel_homeunder100_count), if(rel_homeunder150_count = NULL, 0, rel_homeunder150_count), if(rel_homeunder200_count = NULL, 0, rel_homeunder200_count), if(rel_homeunder300_count = NULL, 0, rel_homeunder300_count), if(rel_homeunder500_count = NULL, 0, rel_homeunder500_count), if(rel_homeover500_count = NULL, 0, rel_homeover500_count))) >= 0, truncate(if(max(rel_homeunder50_count * 50, rel_homeunder100_count * 100, rel_homeunder150_count * 150, rel_homeunder200_count * 200, rel_homeunder300_count * 300, rel_homeunder500_count * 500, rel_homeover500_count * 750) = NULL, NULL, sum(if(rel_homeunder50_count * 50 = NULL, 0, rel_homeunder50_count * 50), if(rel_homeunder100_count * 100 = NULL, 0, rel_homeunder100_count * 100), if(rel_homeunder150_count * 150 = NULL, 0, rel_homeunder150_count * 150), if(rel_homeunder200_count * 200 = NULL, 0, rel_homeunder200_count * 200), if(rel_homeunder300_count * 300 = NULL, 0, rel_homeunder300_count * 300), if(rel_homeunder500_count * 500 = NULL, 0, rel_homeunder500_count * 500), if(rel_homeover500_count * 750 = NULL, 0, rel_homeover500_count * 750))) / if(max(rel_homeunder50_count, rel_homeunder100_count, rel_homeunder150_count, rel_homeunder200_count, rel_homeunder300_count, rel_homeunder500_count, rel_homeover500_count) = NULL, NULL, sum(if(rel_homeunder50_count = NULL, 0, rel_homeunder50_count), if(rel_homeunder100_count = NULL, 0, rel_homeunder100_count), if(rel_homeunder150_count = NULL, 0, rel_homeunder150_count), if(rel_homeunder200_count = NULL, 0, rel_homeunder200_count), if(rel_homeunder300_count = NULL, 0, rel_homeunder300_count), if(rel_homeunder500_count = NULL, 0, rel_homeunder500_count), if(rel_homeover500_count = NULL, 0, rel_homeover500_count)))), roundup(if(max(rel_homeunder50_count * 50, rel_homeunder100_count * 100, rel_homeunder150_count * 150, rel_homeunder200_count * 200, rel_homeunder300_count * 300, rel_homeunder500_count * 500, rel_homeover500_count * 750) = NULL, NULL, sum(if(rel_homeunder50_count * 50 = NULL, 0, rel_homeunder50_count * 50), if(rel_homeunder100_count * 100 = NULL, 0, rel_homeunder100_count * 100), if(rel_homeunder150_count * 150 = NULL, 0, rel_homeunder150_count * 150), if(rel_homeunder200_count * 200 = NULL, 0, rel_homeunder200_count * 200), if(rel_homeunder300_count * 300 = NULL, 0, rel_homeunder300_count * 300), if(rel_homeunder500_count * 500 = NULL, 0, rel_homeunder500_count * 500), if(rel_homeover500_count * 750 = NULL, 0, rel_homeover500_count * 750))) / if(max(rel_homeunder50_count, rel_homeunder100_count, rel_homeunder150_count, rel_homeunder200_count, rel_homeunder300_count, rel_homeunder500_count, rel_homeover500_count) = NULL, NULL, sum(if(rel_homeunder50_count = NULL, 0, rel_homeunder50_count), if(rel_homeunder100_count = NULL, 0, rel_homeunder100_count), if(rel_homeunder150_count = NULL, 0, rel_homeunder150_count), if(rel_homeunder200_count = NULL, 0, rel_homeunder200_count), if(rel_homeunder300_count = NULL, 0, rel_homeunder300_count), if(rel_homeunder500_count = NULL, 0, rel_homeunder500_count), if(rel_homeover500_count = NULL, 0, rel_homeover500_count))))) * 1000);

nf_fp_prevaddrmurderindex := __common__(if(not(truedid), NULL, (integer)fp_prevaddrmurderindex));

earliest_cred_date_all := if(ver_src_fdate_ar = NULL and ver_src_fdate_am = NULL and ver_src_fdate_ba = NULL and ver_src_fdate_cg = NULL and ver_src_fdate_da = NULL and ver_src_fdate_d = NULL and ver_src_fdate_dl = NULL and ver_src_fdate_eb = NULL and ver_src_fdate_e1 = NULL and ver_src_fdate_e2 = NULL and ver_src_fdate_e3 = NULL and ver_src_fdate_fe = NULL and ver_src_fdate_ff = NULL and ver_src_fdate_p = NULL and ver_src_fdate_pl = NULL and ver_src_fdate_sl = NULL and ver_src_fdate_v = NULL and ver_src_fdate_vo = NULL and ver_src_fdate_w = NULL, NULL, if(max(ver_src_fdate_ar, ver_src_fdate_am, ver_src_fdate_ba, ver_src_fdate_cg, ver_src_fdate_da, ver_src_fdate_d, ver_src_fdate_dl, ver_src_fdate_eb, ver_src_fdate_e1, ver_src_fdate_e2, ver_src_fdate_e3, ver_src_fdate_fe, ver_src_fdate_ff, ver_src_fdate_p, ver_src_fdate_pl, ver_src_fdate_sl, ver_src_fdate_v, ver_src_fdate_vo, ver_src_fdate_w) = NULL, NULL, min(if(ver_src_fdate_ar = NULL, -NULL, ver_src_fdate_ar), if(ver_src_fdate_am = NULL, -NULL, ver_src_fdate_am), if(ver_src_fdate_ba = NULL, -NULL, ver_src_fdate_ba), if(ver_src_fdate_cg = NULL, -NULL, ver_src_fdate_cg), if(ver_src_fdate_da = NULL, -NULL, ver_src_fdate_da), if(ver_src_fdate_d = NULL, -NULL, ver_src_fdate_d), if(ver_src_fdate_dl = NULL, -NULL, ver_src_fdate_dl), if(ver_src_fdate_eb = NULL, -NULL, ver_src_fdate_eb), if(ver_src_fdate_e1 = NULL, -NULL, ver_src_fdate_e1), if(ver_src_fdate_e2 = NULL, -NULL, ver_src_fdate_e2), if(ver_src_fdate_e3 = NULL, -NULL, ver_src_fdate_e3), if(ver_src_fdate_fe = NULL, -NULL, ver_src_fdate_fe), if(ver_src_fdate_ff = NULL, -NULL, ver_src_fdate_ff), if(ver_src_fdate_p = NULL, -NULL, ver_src_fdate_p), if(ver_src_fdate_pl = NULL, -NULL, ver_src_fdate_pl), if(ver_src_fdate_sl = NULL, -NULL, ver_src_fdate_sl), if(ver_src_fdate_v = NULL, -NULL, ver_src_fdate_v), if(ver_src_fdate_vo = NULL, -NULL, ver_src_fdate_vo), if(ver_src_fdate_w = NULL, -NULL, ver_src_fdate_w))));

nf_m_src_credentialed_fs := map(
    not(truedid)                  => NULL,
    earliest_cred_date_all = NULL => -1,
                                     min(if(if ((sysdate - earliest_cred_date_all) / (365.25 / 12) >= 0, truncate((sysdate - earliest_cred_date_all) / (365.25 / 12)), roundup((sysdate - earliest_cred_date_all) / (365.25 / 12))) = NULL, -NULL, if ((sysdate - earliest_cred_date_all) / (365.25 / 12) >= 0, truncate((sysdate - earliest_cred_date_all) / (365.25 / 12)), roundup((sysdate - earliest_cred_date_all) / (365.25 / 12)))), 999));

iv_prv_addr_lres := if(not(truedid and add_prev_pop), NULL, min(if(add_prev_lres = NULL, -NULL, add_prev_lres), 999));

nf_inq_mortgage_count := if(not(truedid), NULL, min(if(inq_Mortgage_count = NULL, -NULL, inq_Mortgage_count), 999));

nf_inq_count24 := if(not(truedid), NULL, min(if(inq_count24 = NULL, -NULL, inq_count24), 999));

rv_l79_adls_per_sfd_addr := __common__(map(
    not(addrpop)   => NULL,
    iv_add_apt = '1' => -1,
                      min(if(adls_per_addr_curr = NULL, -NULL, adls_per_addr_curr), 999)));

nonfcra_v01_w := map(
    nf_average_rel_home_val = NULL    => 0,
    nf_average_rel_home_val = -1      => 1.33602785951704,
    nf_average_rel_home_val <= 335500 => -0.59921488742981,
    nf_average_rel_home_val <= 455500 => -0.024709081415314,
                                         0.285555548665802);

nonfcra_v02_w := map(
    nf_fp_prevaddrmurderindex = NULL  => 0,
    nf_fp_prevaddrmurderindex = -1    => -0.460815253366067,
    nf_fp_prevaddrmurderindex <= 24.5 => -0.60824714375431,
    nf_fp_prevaddrmurderindex <= 99.5 => -0.0367644028027679,
    nf_fp_prevaddrmurderindex <= 118  => 0.4191342605193,
                                         0.591827703566074);

nonfcra_v03_w := map(
    nf_m_src_credentialed_fs = NULL   => 0,
    nf_m_src_credentialed_fs = -1     => -0.0632725871149518,
    nf_m_src_credentialed_fs <= 189.5 => 0.525938352556481,
    nf_m_src_credentialed_fs <= 273.5 => -0.270148055043535,
                                         -0.367016260684704);

nonfcra_v04_w := map(
    iv_prv_addr_lres = NULL   => 0,
    iv_prv_addr_lres = -1     => 0,
    iv_prv_addr_lres <= 14.5  => 0.689558839199629,
    iv_prv_addr_lres <= 39.5  => 0.145066544731036,
    iv_prv_addr_lres <= 107.5 => -0.0752657631704129,
                                 -0.461962654362948);

nonfcra_v05_w := map(
    nf_inq_mortgage_count = NULL => 0,
    nf_inq_mortgage_count = -1   => 0,
    nf_inq_mortgage_count <= 0.5 => -0.160401741378187,
    nf_inq_mortgage_count <= 5.5 => -0.0443167969528901,
                                    1.34713241064345);

nonfcra_v06_w := map(
    nf_inq_count24 = NULL => 0,
    nf_inq_count24 = -1   => 0,
    nf_inq_count24 <= 0.5 => -0.438076892472799,
    nf_inq_count24 <= 6.5 => 0.134631221497813,
                             0.673473787438213);

nonfcra_v07_w := map(
    rv_l79_adls_per_sfd_addr = NULL => 0,
    rv_l79_adls_per_sfd_addr = -1   => -0.424314080111201,
    rv_l79_adls_per_sfd_addr <= 1.5 => 0.360131699743525,
    rv_l79_adls_per_sfd_addr <= 4.5 => 0.185236924859409,
                                       -0.17282136203568);

nonfcra_lgt := -4.45528750713784 +
    nonfcra_v01_w +
    nonfcra_v02_w +
    nonfcra_v03_w +
    nonfcra_v04_w +
    nonfcra_v05_w +
    nonfcra_v06_w +
    nonfcra_v07_w;

base := 700;

pts := -50;

odds := 55 / (3980 - 55);

fp1801_1_0 := min(if(max(round(pts * (nonfcra_lgt - ln(odds)) / ln(2) + base), 300) = NULL, -NULL, max(round(pts * (nonfcra_lgt - ln(odds)) / ln(2) + base), 300)), 999);

custstolidindex := 1;

custmanipidindex := 1;

custsynthidindex := 1;

custsuspactindex := 1;

custvulnvicindex := 1;

custfriendfrdindex := 1;



																																	 
//*************************************************************************************//
//     End Generated ECL Code
//*************************************************************************************//

	#if(FP_DEBUG)
		/* Model Input Variables */
								//		self.seq 															:= le.seq
                    self.sysdate                          := sysdate;
                    self.ver_src_am_pos                   := ver_src_am_pos;
                    self._ver_src_fdate_am                := _ver_src_fdate_am;
                    self.ver_src_fdate_am                 := ver_src_fdate_am;
                    self.ver_src_ar_pos                   := ver_src_ar_pos;
                    self._ver_src_fdate_ar                := _ver_src_fdate_ar;
                    self.ver_src_fdate_ar                 := ver_src_fdate_ar;
                    self.ver_src_ba_pos                   := ver_src_ba_pos;
                    self._ver_src_fdate_ba                := _ver_src_fdate_ba;
                    self.ver_src_fdate_ba                 := ver_src_fdate_ba;
                    self.ver_src_cg_pos                   := ver_src_cg_pos;
                    self._ver_src_fdate_cg                := _ver_src_fdate_cg;
                    self.ver_src_fdate_cg                 := ver_src_fdate_cg;
                    self.ver_src_da_pos                   := ver_src_da_pos;
                    self._ver_src_fdate_da                := _ver_src_fdate_da;
                    self.ver_src_fdate_da                 := ver_src_fdate_da;
                    self.ver_src_d_pos                    := ver_src_d_pos;
                    self._ver_src_fdate_d                 := _ver_src_fdate_d;
                    self.ver_src_fdate_d                  := ver_src_fdate_d;
                    self.ver_src_dl_pos                   := ver_src_dl_pos;
                    self._ver_src_fdate_dl                := _ver_src_fdate_dl;
                    self.ver_src_fdate_dl                 := ver_src_fdate_dl;
                    self.ver_src_eb_pos                   := ver_src_eb_pos;
                    self._ver_src_fdate_eb                := _ver_src_fdate_eb;
                    self.ver_src_fdate_eb                 := ver_src_fdate_eb;
                    self.ver_src_e1_pos                   := ver_src_e1_pos;
                    self._ver_src_fdate_e1                := _ver_src_fdate_e1;
                    self.ver_src_fdate_e1                 := ver_src_fdate_e1;
                    self.ver_src_e2_pos                   := ver_src_e2_pos;
                    self._ver_src_fdate_e2                := _ver_src_fdate_e2;
                    self.ver_src_fdate_e2                 := ver_src_fdate_e2;
                    self.ver_src_e3_pos                   := ver_src_e3_pos;
                    self._ver_src_fdate_e3                := _ver_src_fdate_e3;
                    self.ver_src_fdate_e3                 := ver_src_fdate_e3;
                    self.ver_src_fe_pos                   := ver_src_fe_pos;
                    self._ver_src_fdate_fe                := _ver_src_fdate_fe;
                    self.ver_src_fdate_fe                 := ver_src_fdate_fe;
                    self.ver_src_ff_pos                   := ver_src_ff_pos;
                    self._ver_src_fdate_ff                := _ver_src_fdate_ff;
                    self.ver_src_fdate_ff                 := ver_src_fdate_ff;
                    self.ver_src_p_pos                    := ver_src_p_pos;
                    self._ver_src_fdate_p                 := _ver_src_fdate_p;
                    self.ver_src_fdate_p                  := ver_src_fdate_p;
                    self.ver_src_pl_pos                   := ver_src_pl_pos;
                    self._ver_src_fdate_pl                := _ver_src_fdate_pl;
                    self.ver_src_fdate_pl                 := ver_src_fdate_pl;
                    self.ver_src_sl_pos                   := ver_src_sl_pos;
                    self._ver_src_fdate_sl                := _ver_src_fdate_sl;
                    self.ver_src_fdate_sl                 := ver_src_fdate_sl;
                    self.ver_src_v_pos                    := ver_src_v_pos;
                    self._ver_src_fdate_v                 := _ver_src_fdate_v;
                    self.ver_src_fdate_v                  := ver_src_fdate_v;
                    self.ver_src_vo_pos                   := ver_src_vo_pos;
                    self._ver_src_fdate_vo                := _ver_src_fdate_vo;
                    self.ver_src_fdate_vo                 := ver_src_fdate_vo;
                    self.ver_src_w_pos                    := ver_src_w_pos;
                    self._ver_src_fdate_w                 := _ver_src_fdate_w;
                    self.ver_src_fdate_w                  := ver_src_fdate_w;
                    self.iv_add_apt                       := iv_add_apt;
                    self.nf_average_rel_home_val          := nf_average_rel_home_val;
                    self.nf_fp_prevaddrmurderindex        := nf_fp_prevaddrmurderindex;
                    self.earliest_cred_date_all           := earliest_cred_date_all;
                    self.nf_m_src_credentialed_fs         := nf_m_src_credentialed_fs;
                    self.iv_prv_addr_lres                 := iv_prv_addr_lres;
                    self.nf_inq_mortgage_count            := nf_inq_mortgage_count;
                    self.nf_inq_count24                   := nf_inq_count24;
                    self.rv_l79_adls_per_sfd_addr         := rv_l79_adls_per_sfd_addr;
                    self.nonfcra_v01_w                    := nonfcra_v01_w;
                    self.nonfcra_v02_w                    := nonfcra_v02_w;
                    self.nonfcra_v03_w                    := nonfcra_v03_w;
                    self.nonfcra_v04_w                    := nonfcra_v04_w;
                    self.nonfcra_v05_w                    := nonfcra_v05_w;
                    self.nonfcra_v06_w                    := nonfcra_v06_w;
                    self.nonfcra_v07_w                    := nonfcra_v07_w;
                    self.nonfcra_lgt                      := nonfcra_lgt;
                    self.base                             := base;
                    self.pts                              := pts;
                    self.odds                             := odds;
                    self.fp1801_1_0                       := fp1801_1_0;
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
	 reasons := Models.Common.checkFraudPointRC34(FP1801_1_0, ritmp, num_reasons);
	self.ri := reasons;
	self.score := (string)FP1801_1_0;
	self := [];
	
END;

model :=   project(clam, doModel(left) );
	
	return model;
END;



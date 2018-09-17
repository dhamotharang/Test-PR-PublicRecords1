//***                                                           ****
//***THIS WILL BE CONSIDERED THE FLAGSHIP MODEL FOR CITIZENSHIP ****
//***                                                           ****
import Std, risk_indicators, riskwise, Citizenship, ut, Models, easi;



export cit1808_0_0(dataset(risk_indicators.Layout_Boca_Shell) clam)
									 := FUNCTION
									
		FP_DEBUG := True;        //***Set to True for both Round 1 and Round 2 validation
		// FP_DEBUG := False;            //***Make sure this is set to FALSE before promoting this to PROD
		// ROUND1VALIDATION := True;
		ROUND1VALIDATION := False;    //***Make sure this is set to FALSE before promoting this to PROD
		isFCRA := False;

	#if(FP_DEBUG)
Layout_Debug := RECORD
  /* Layout of the Debug/Validation record */
    STRING10 model_name;
    unsigned4 seq;
    INTEGER sysdate;
    INTEGER ver_src_ak_pos;
    STRING _ver_src_fdate_ak;
    INTEGER ver_src_fdate_ak;
    INTEGER ver_src_am_pos;
    STRING _ver_src_fdate_am;
    INTEGER ver_src_fdate_am;
    INTEGER ver_src_ar_pos;
    STRING _ver_src_fdate_ar;
    INTEGER ver_src_fdate_ar;
    INTEGER ver_src_ba_pos;
    STRING _ver_src_fdate_ba;
    INTEGER ver_src_fdate_ba;
    INTEGER ver_src_cg_pos;
    STRING _ver_src_fdate_cg;
    INTEGER ver_src_fdate_cg;
    INTEGER ver_src_co_pos;
    STRING _ver_src_fdate_co;
    INTEGER ver_src_fdate_co;
    INTEGER ver_src_cy_pos;
    STRING _ver_src_fdate_cy;
    INTEGER ver_src_fdate_cy;
    INTEGER ver_src_da_pos;
    STRING _ver_src_fdate_da;
    INTEGER ver_src_fdate_da;
    INTEGER ver_src_d_pos;
    STRING _ver_src_fdate_d;
    INTEGER ver_src_fdate_d;
    INTEGER ver_src_dl_pos;
    STRING _ver_src_fdate_dl;
    INTEGER ver_src_fdate_dl;
    INTEGER ver_src_ds_pos;
    STRING _ver_src_fdate_ds;
    INTEGER ver_src_fdate_ds;
    INTEGER ver_src_de_pos;
    STRING _ver_src_fdate_de;
    INTEGER ver_src_fdate_de;
    INTEGER ver_src_eb_pos;
    STRING _ver_src_fdate_eb;
    INTEGER ver_src_fdate_eb;
    INTEGER ver_src_em_pos;
    STRING _ver_src_fdate_em;
    INTEGER ver_src_fdate_em;
    INTEGER ver_src_e1_pos;
    STRING _ver_src_fdate_e1;
    INTEGER ver_src_fdate_e1;
    INTEGER ver_src_e2_pos;
    STRING _ver_src_fdate_e2;
    INTEGER ver_src_fdate_e2;
    INTEGER ver_src_e3_pos;
    STRING _ver_src_fdate_e3;
    INTEGER ver_src_fdate_e3;
    INTEGER ver_src_e4_pos;
    STRING _ver_src_fdate_e4;
    INTEGER ver_src_fdate_e4;
    INTEGER ver_src_en_pos;
    BOOLEAN ver_src_en;
    STRING _ver_src_fdate_en;
    INTEGER ver_src_fdate_en;
    INTEGER ver_src_eq_pos;
    BOOLEAN ver_src_eq;
    STRING _ver_src_fdate_eq;
    INTEGER ver_src_fdate_eq;
    INTEGER ver_src_fe_pos;
    STRING _ver_src_fdate_fe;
    INTEGER ver_src_fdate_fe;
    INTEGER ver_src_ff_pos;
    STRING _ver_src_fdate_ff;
    INTEGER ver_src_fdate_ff;
    INTEGER ver_src_fr_pos;
    STRING _ver_src_fdate_fr;
    INTEGER ver_src_fdate_fr;
    INTEGER ver_src_l2_pos;
    STRING _ver_src_fdate_l2;
    INTEGER ver_src_fdate_l2;
    INTEGER ver_src_li_pos;
    STRING _ver_src_fdate_li;
    INTEGER ver_src_fdate_li;
    INTEGER ver_src_mw_pos;
    STRING _ver_src_fdate_mw;
    INTEGER ver_src_fdate_mw;
    INTEGER ver_src_nt_pos;
    STRING _ver_src_fdate_nt;
    INTEGER ver_src_fdate_nt;
    INTEGER ver_src_p_pos;
    STRING _ver_src_fdate_p;
    INTEGER ver_src_fdate_p;
    INTEGER ver_src_pl_pos;
    STRING _ver_src_fdate_pl;
    INTEGER ver_src_fdate_pl;
    INTEGER ver_src_tn_pos;
    BOOLEAN ver_src_tn;
    STRING _ver_src_fdate_tn;
    INTEGER ver_src_fdate_tn;
    INTEGER ver_src_ts_pos;
    BOOLEAN ver_src_ts;
    STRING _ver_src_fdate_ts;
    INTEGER ver_src_fdate_ts;
    INTEGER ver_src_tu_pos;
    BOOLEAN ver_src_tu;
    STRING _ver_src_fdate_tu;
    INTEGER ver_src_fdate_tu;
    INTEGER ver_src_sl_pos;
    REAL ver_src_nas_sl;
    STRING _ver_src_fdate_sl;
    INTEGER ver_src_fdate_sl;
    INTEGER ver_src_v_pos;
    STRING _ver_src_fdate_v;
    INTEGER ver_src_fdate_v;
    INTEGER ver_src_vo_pos;
    STRING _ver_src_fdate_vo;
    INTEGER ver_src_fdate_vo;
    INTEGER ver_src_w_pos;
    STRING _ver_src_fdate_w;
    INTEGER ver_src_fdate_w;
    INTEGER ver_src_wp_pos;
    STRING _ver_src_fdate_wp;
    INTEGER ver_src_fdate_wp;
    INTEGER ver_lname_src_sl_pos;
    BOOLEAN ver_lname_src_sl;
    INTEGER ver_dob_src_sl_pos;
    BOOLEAN ver_dob_src_sl;
    INTEGER ver_dob_src_vo_pos;
    BOOLEAN ver_dob_src_vo;
    INTEGER rv_s65_ssn_prior_dob;
    INTEGER rv_s65_ssn_invalid;
    INTEGER _rc_ssnlowissue;
    INTEGER _in_dob;
    INTEGER ssn_years;
    INTEGER calc_dob;
    INTEGER nf_age_at_ssn_issuance;
    INTEGER iv_phn_cell;
    INTEGER rv_c14_addrs_10yr;
    INTEGER nf_inq_adlsperssn_recency;
    INTEGER nf_inq_adlsperphone_recency;
    INTEGER iv_add_apt;
    INTEGER rv_l79_adls_per_apt_addr;
    INTEGER rv_l79_adls_per_addr_c6;
    BOOLEAN iv_nap_nothing_found;
    INTEGER nf_phone_ver_insurance;
    INTEGER iv_input_best_name_match;
    INTEGER nf_adls_per_phone_c6;
    INTEGER nf_fp_divrisktype;
    INTEGER earliest_header_date;
    INTEGER earliest_header_yrs;
    INTEGER iv_header_emergence_age;
    INTEGER num_bureau_srcs;
    INTEGER num_sources;
    INTEGER nf_bureau_only_rel_count;
    INTEGER rv_c16_inv_ssn_per_adl;
    INTEGER iv_phn_pcs;
    INTEGER nf_inq_perbestssn_count12;
    INTEGER rv_l79_adls_per_addr_curr;
    BOOLEAN iv_nap_lname_verd;
    BOOLEAN iv_inf_lname_verd;
    INTEGER nf_recent_disconnects;
    INTEGER iv_best_ssn_invalid;
    REAL nf_add_input_mobility_index;
    INTEGER nhood_ct;
    REAL nf_add_input_nhood_bus_pct;
    INTEGER nf_phones_per_apt_addr_curr;
    REAL nf_hh_members_w_derog_pct;
    REAL nf_pct_rel_with_bk;
    INTEGER vo_pos;
    INTEGER iv_src_voter_adl_count;
    STRING nf_linkstab_max_weight_element;
    STRING c_professional;  
    STRING c_asian_lang;
    STRING c_span_lang;
    REAL mod1_v01_w;
    REAL mod1_v02_w;
    REAL mod1_v03_w;
    REAL mod1_v04_w;
    REAL mod1_v05_w;
    REAL mod1_v06_w;
    REAL mod1_v07_w;
    REAL mod1_v08_w;
    REAL mod1_v09_w;
    REAL mod1_v10_w;
    REAL mod1_v11_w;
    REAL mod1_v12_w;
    REAL mod1_v13_w;
    REAL mod1_v14_w;
    REAL mod1_v15_w;
    REAL mod1_v16_w;
    REAL mod1_v17_w;
    REAL mod1_v18_w;
    REAL mod1_v19_w;
    REAL mod1_v20_w;
    REAL mod1_v21_w;
    REAL mod1_lgt;
    REAL mod2_v01_w;
    REAL mod2_v02_w;
    REAL mod2_v03_w;
    REAL mod2_v04_w;
    REAL mod2_v05_w;
    REAL mod2_v06_w;
    REAL mod2_v07_w;
    REAL mod2_v08_w;
    REAL mod2_v09_w;
    REAL mod2_v10_w;
    REAL mod2_v11_w;
    REAL mod2_v12_w;
    REAL mod2_v13_w;
    REAL mod2_v14_w;
    REAL mod2_v15_w;
    REAL mod2_v16_w;
    REAL mod2_v17_w;
    REAL mod2_v18_w;
    REAL mod2_v19_w;
    REAL mod2_v20_w;
    REAL mod2_v21_w;
    REAL mod2_v22_w;
    REAL mod2_v23_w;
    REAL mod2_v24_w;
    REAL mod2_v25_w;
    REAL mod2_lgt;
    INTEGER base;
    INTEGER pts;
    REAL lgt;
    INTEGER citizen_score;
     Citizenship.Layouts.ModelOutput_Layout; 
		 Risk_Indicators.Layout_Boca_Shell clam;
		END;  
    
//=============================================
//===  IF the MODEL_DEBUG = TRUE            ===
//===    transform using the debug layout   ===	
//=============================================	
		 layout_debug doModel( clam le, easi.Key_Easi_Census rt ) := TRANSFORM
		 
	#else
	
//=============================================
//===  ELSE                                 ===
//===    transform using the model layout   ===	
//=============================================			 
		 
		 Citizenship.Layouts.ModelOutput_Layout doModel( clam le, easi.Key_Easi_Census rt ) := TRANSFORM
	#end

		
  /* Input Variable Assignments  */

  inq_adlsperssn_count01           := le.acc_logs.inq_adlsperssn_count01;
	inq_adlsperssn_count03           := le.acc_logs.inq_adlsperssn_count03;
	inq_adlsperssn_count06           := le.acc_logs.inq_adlsperssn_count06;
	inq_adlsperphone_count01         := le.acc_logs.inq_adlsperphone_count01;
	inq_adlsperphone_count03         := le.acc_logs.inq_adlsperphone_count03;
	inq_adlsperphone_count06         := le.acc_logs.inq_adlsperphone_count06;
	input_fname_isbestmatch          := le.best_flags.input_fname_isbestmatch;
	input_lname_isbestmatch          := le.best_flags.input_lname_isbestmatch;
	inq_perbestssn                   := le.best_flags.inq_perbestssn;
	best_ssn_valid                   := le.best_flags.best_ssn_valid;
	link_max_weight_element          := le.PII_Stability.link_max_weight_element;
	truedid                          := le.truedid;
	out_unit_desig                   := le.shell_input.unit_desig;
	out_sec_range                    := le.shell_input.sec_range;
	out_addr_type                    := le.shell_input.addr_type;
	in_dob                           := le.shell_input.dob;
	nap_summary                      := le.iid.nap_summary;
	rc_hriskphoneflag                := le.iid.hriskphoneflag;
	rc_hphonetypeflag                := le.iid.hphonetypeflag;
	rc_ssndobflag                    := le.iid.socsdobflag;
	rc_pwssndobflag                  := le.iid.pwsocsdobflag;
	rc_ssnvalflag                    := le.iid.socsvalflag;
	rc_pwssnvalflag                  := le.iid.pwsocsvalflag;
	rc_ssnlowissue                   := (unsigned)le.iid.socllowissue;
	rc_dwelltype                     := le.iid.dwelltype;
	ver_sources                      := le.header_summary.ver_sources;
	ver_sources_nas                  := le.header_summary.ver_sources_nas;
	ver_sources_first_seen           := le.header_summary.ver_sources_first_seen_date;
	ver_sources_count                := le.header_summary.ver_sources_recordcount;
	ver_lname_sources                := le.header_summary.ver_lname_sources;
	ver_dob_sources                  := le.header_summary.ver_dob_sources;
	voter_avail                      := le.available_sources.voter;
	addrpop                          := le.input_validation.address;
	ssnlength                        := le.input_validation.ssn_length;
	dobpop                           := le.input_validation.dateofbirth;
	hphnpop                          := le.input_validation.homephone;
	add_input_occupants_1yr          := le.addr_risk_summary.occupants_1yr;
	add_input_turnover_1yr_in        := le.addr_risk_summary.turnover_1yr_in;
	add_input_turnover_1yr_out       := le.addr_risk_summary.turnover_1yr_out;
	add_input_nhood_bus_ct           := le.addr_risk_summary.N_Business_Count;
	add_input_nhood_sfd_ct           := le.addr_risk_summary.N_SFD_Count;
	add_input_nhood_mfd_ct           := le.addr_risk_summary.N_MFD_Count;
	add_curr_pop                     := le.addrPop2;
	addrs_10yr                       := le.other_address_info.addrs_last_10years;
	telcordia_type                   := le.phone_verification.telcordia_type;
	recent_disconnects               := if(isFCRA, 0, le.phone_verification.recent_disconnects);
	phone_ver_insurance              := le.insurance_phones_summary.Insurance_Phone_Verification;
	inputssncharflag                 := le.ssn_verification.validation.inputsocscharflag;
	adls_per_addr_curr               := le.velocity_counters.adls_per_addr_current;
	phones_per_addr_curr             := le.velocity_counters.phones_per_addr_current;
	adls_per_addr_c6                 := le.velocity_counters.adls_per_addr_created_6months;
	adls_per_phone_c6                := if(isFCRA, 0, le.velocity_counters.adls_per_phone_created_6months );
	invalid_ssns_per_adl             := le.velocity_counters.invalid_ssns_per_adl;
	inq_adlsperssn                   := if(isFCRA, 0, le.acc_logs.inquiryADLsPerSSN );
	inq_adlsperphone                 := if(isFCRA, 0, le.acc_logs.inquiryADLsPerPhone );
	infutor_nap                      := le.infutor_phone.infutor_nap;
	fp_divrisktype                   := le.fdattributesv2.divrisklevel;
	hh_members_ct                    := le.hhid_summary.hh_members_ct;
	hh_members_w_derog               := le.hhid_summary.hh_members_w_derog;
	rel_count                        := le.relatives.relative_count;
	rel_bankrupt_count               := le.relatives.relative_bankrupt_count;
	inferred_age                     := le.inferred_age;
  //***Fields from the Census Keys***
	c_professional                   := rt.PROFESSIONAL;
	c_asian_lang                     := rt.ASIAN_LANG;                               //***things from the right are from the Census Key
	c_burglary                       := rt.BURGLARY;
	c_span_lang                      := rt.SPAN_LANG;


//***Begin of converted code
NULL := -999999999;

//============================================================================================ 
//===   for round 1 validation set the sysdate to the same value seen in the validation file
#if(ROUND1VALIDATION)
     sysdate := common.sas_date('20160501');	 
#else
    sysdate := common.sas_date(if(le.historydate=999999, (STRING)std.date.today(), (STRING6)le.historydate+'01'));
#end
//========================================================================================

ver_src_ak_pos := Models.Common.findw_cpp(ver_sources, 'AK' , '  ,', 'ie');

_ver_src_fdate_ak := if(ver_src_ak_pos > 0, Models.Common.getw(ver_sources_first_seen, ver_src_ak_pos), '0');

ver_src_fdate_ak := common.sas_date((    STRING)(_ver_src_fdate_ak));

ver_src_am_pos := Models.Common.findw_cpp(ver_sources, 'AM' , '  ,', 'ie');

_ver_src_fdate_am := if(ver_src_am_pos > 0, Models.Common.getw(ver_sources_first_seen, ver_src_am_pos), '0');

ver_src_fdate_am := common.sas_date((    STRING)(_ver_src_fdate_am));

ver_src_ar_pos := Models.Common.findw_cpp(ver_sources, 'AR' , '  ,', 'ie');

_ver_src_fdate_ar := if(ver_src_ar_pos > 0, Models.Common.getw(ver_sources_first_seen, ver_src_ar_pos), '0');

ver_src_fdate_ar := common.sas_date((    STRING)(_ver_src_fdate_ar));

ver_src_ba_pos := Models.Common.findw_cpp(ver_sources, 'BA' , '  ,', 'ie');

_ver_src_fdate_ba := if(ver_src_ba_pos > 0, Models.Common.getw(ver_sources_first_seen, ver_src_ba_pos), '0');

ver_src_fdate_ba := common.sas_date((    STRING)(_ver_src_fdate_ba));

ver_src_cg_pos := Models.Common.findw_cpp(ver_sources, 'CG' , '  ,', 'ie');

_ver_src_fdate_cg := if(ver_src_cg_pos > 0, Models.Common.getw(ver_sources_first_seen, ver_src_cg_pos), '0');

ver_src_fdate_cg := common.sas_date((    STRING)(_ver_src_fdate_cg));

ver_src_co_pos := Models.Common.findw_cpp(ver_sources, 'CO' , '  ,', 'ie');

_ver_src_fdate_co := if(ver_src_co_pos > 0, Models.Common.getw(ver_sources_first_seen, ver_src_co_pos), '0');

ver_src_fdate_co := common.sas_date((    STRING)(_ver_src_fdate_co));

ver_src_cy_pos := Models.Common.findw_cpp(ver_sources, 'CY' , '  ,', 'ie');

_ver_src_fdate_cy := if(ver_src_cy_pos > 0, Models.Common.getw(ver_sources_first_seen, ver_src_cy_pos), '0');

ver_src_fdate_cy := common.sas_date((    STRING)(_ver_src_fdate_cy));

ver_src_da_pos := Models.Common.findw_cpp(ver_sources, 'DA' , '  ,', 'ie');

_ver_src_fdate_da := if(ver_src_da_pos > 0, Models.Common.getw(ver_sources_first_seen, ver_src_da_pos), '0');

ver_src_fdate_da := common.sas_date((    STRING)(_ver_src_fdate_da));

ver_src_d_pos := Models.Common.findw_cpp(ver_sources, 'D' , '  ,', 'ie');

_ver_src_fdate_d := if(ver_src_d_pos > 0, Models.Common.getw(ver_sources_first_seen, ver_src_d_pos), '0');

ver_src_fdate_d := common.sas_date((    STRING)(_ver_src_fdate_d));

ver_src_dl_pos := Models.Common.findw_cpp(ver_sources, 'DL' , '  ,', 'ie');

_ver_src_fdate_dl := if(ver_src_dl_pos > 0, Models.Common.getw(ver_sources_first_seen, ver_src_dl_pos), '0');

ver_src_fdate_dl := common.sas_date((    STRING)(_ver_src_fdate_dl));

ver_src_ds_pos := Models.Common.findw_cpp(ver_sources, 'DS' , '  ,', 'ie');

_ver_src_fdate_ds := if(ver_src_ds_pos > 0, Models.Common.getw(ver_sources_first_seen, ver_src_ds_pos), '0');

ver_src_fdate_ds := common.sas_date((    STRING)(_ver_src_fdate_ds));

ver_src_de_pos := Models.Common.findw_cpp(ver_sources, 'DE' , '  ,', 'ie');

_ver_src_fdate_de := if(ver_src_de_pos > 0, Models.Common.getw(ver_sources_first_seen, ver_src_de_pos), '0');

ver_src_fdate_de := common.sas_date((    STRING)(_ver_src_fdate_de));

ver_src_eb_pos := Models.Common.findw_cpp(ver_sources, 'EB' , '  ,', 'ie');

_ver_src_fdate_eb := if(ver_src_eb_pos > 0, Models.Common.getw(ver_sources_first_seen, ver_src_eb_pos), '0');

ver_src_fdate_eb := common.sas_date((    STRING)(_ver_src_fdate_eb));

ver_src_em_pos := Models.Common.findw_cpp(ver_sources, 'EM' , '  ,', 'ie');

_ver_src_fdate_em := if(ver_src_em_pos > 0, Models.Common.getw(ver_sources_first_seen, ver_src_em_pos), '0');

ver_src_fdate_em := common.sas_date((    STRING)(_ver_src_fdate_em));

ver_src_e1_pos := Models.Common.findw_cpp(ver_sources, 'E1' , '  ,', 'ie');

_ver_src_fdate_e1 := if(ver_src_e1_pos > 0, Models.Common.getw(ver_sources_first_seen, ver_src_e1_pos), '0');

ver_src_fdate_e1 := common.sas_date((    STRING)(_ver_src_fdate_e1));

ver_src_e2_pos := Models.Common.findw_cpp(ver_sources, 'E2' , '  ,', 'ie');

_ver_src_fdate_e2 := if(ver_src_e2_pos > 0, Models.Common.getw(ver_sources_first_seen, ver_src_e2_pos), '0');

ver_src_fdate_e2 := common.sas_date((    STRING)(_ver_src_fdate_e2));

ver_src_e3_pos := Models.Common.findw_cpp(ver_sources, 'E3' , '  ,', 'ie');

_ver_src_fdate_e3 := if(ver_src_e3_pos > 0, Models.Common.getw(ver_sources_first_seen, ver_src_e3_pos), '0');

ver_src_fdate_e3 := common.sas_date((    STRING)(_ver_src_fdate_e3));

ver_src_e4_pos := Models.Common.findw_cpp(ver_sources, 'E4' , '  ,', 'ie');

_ver_src_fdate_e4 := if(ver_src_e4_pos > 0, Models.Common.getw(ver_sources_first_seen, ver_src_e4_pos), '0');

ver_src_fdate_e4 := common.sas_date((    STRING)(_ver_src_fdate_e4));

ver_src_en_pos := Models.Common.findw_cpp(ver_sources, 'EN' , '  ,', 'ie');

ver_src_en := ver_src_en_pos > 0;

_ver_src_fdate_en := if(ver_src_en_pos > 0, Models.Common.getw(ver_sources_first_seen, ver_src_en_pos), '0');

ver_src_fdate_en := common.sas_date((    STRING)(_ver_src_fdate_en));

ver_src_eq_pos := Models.Common.findw_cpp(ver_sources, 'EQ' , '  ,', 'ie');

ver_src_eq := ver_src_eq_pos > 0;

_ver_src_fdate_eq := if(ver_src_eq_pos > 0, Models.Common.getw(ver_sources_first_seen, ver_src_eq_pos), '0');

ver_src_fdate_eq := common.sas_date((    STRING)(_ver_src_fdate_eq));

ver_src_fe_pos := Models.Common.findw_cpp(ver_sources, 'FE' , '  ,', 'ie');

_ver_src_fdate_fe := if(ver_src_fe_pos > 0, Models.Common.getw(ver_sources_first_seen, ver_src_fe_pos), '0');

ver_src_fdate_fe := common.sas_date((    STRING)(_ver_src_fdate_fe));

ver_src_ff_pos := Models.Common.findw_cpp(ver_sources, 'FF' , '  ,', 'ie');

_ver_src_fdate_ff := if(ver_src_ff_pos > 0, Models.Common.getw(ver_sources_first_seen, ver_src_ff_pos), '0');

ver_src_fdate_ff := common.sas_date((    STRING)(_ver_src_fdate_ff));

ver_src_fr_pos := Models.Common.findw_cpp(ver_sources, 'FR' , '  ,', 'ie');

_ver_src_fdate_fr := if(ver_src_fr_pos > 0, Models.Common.getw(ver_sources_first_seen, ver_src_fr_pos), '0');

ver_src_fdate_fr := common.sas_date((    STRING)(_ver_src_fdate_fr));

ver_src_l2_pos := Models.Common.findw_cpp(ver_sources, 'L2' , '  ,', 'ie');

_ver_src_fdate_l2 := if(ver_src_l2_pos > 0, Models.Common.getw(ver_sources_first_seen, ver_src_l2_pos), '0');

ver_src_fdate_l2 := common.sas_date((    STRING)(_ver_src_fdate_l2));

ver_src_li_pos := Models.Common.findw_cpp(ver_sources, 'LI' , '  ,', 'ie');

_ver_src_fdate_li := if(ver_src_li_pos > 0, Models.Common.getw(ver_sources_first_seen, ver_src_li_pos), '0');

ver_src_fdate_li := common.sas_date((    STRING)(_ver_src_fdate_li));

ver_src_mw_pos := Models.Common.findw_cpp(ver_sources, 'MW' , '  ,', 'ie');

_ver_src_fdate_mw := if(ver_src_mw_pos > 0, Models.Common.getw(ver_sources_first_seen, ver_src_mw_pos), '0');

ver_src_fdate_mw := common.sas_date((    STRING)(_ver_src_fdate_mw));

ver_src_nt_pos := Models.Common.findw_cpp(ver_sources, 'NT' , '  ,', 'ie');

_ver_src_fdate_nt := if(ver_src_nt_pos > 0, Models.Common.getw(ver_sources_first_seen, ver_src_nt_pos), '0');

ver_src_fdate_nt := common.sas_date((    STRING)(_ver_src_fdate_nt));

ver_src_p_pos := Models.Common.findw_cpp(ver_sources, 'P' , '  ,', 'ie');

_ver_src_fdate_p := if(ver_src_p_pos > 0, Models.Common.getw(ver_sources_first_seen, ver_src_p_pos), '0');

ver_src_fdate_p := common.sas_date((    STRING)(_ver_src_fdate_p));

ver_src_pl_pos := Models.Common.findw_cpp(ver_sources, 'PL' , '  ,', 'ie');

_ver_src_fdate_pl := if(ver_src_pl_pos > 0, Models.Common.getw(ver_sources_first_seen, ver_src_pl_pos), '0');

ver_src_fdate_pl := common.sas_date((    STRING)(_ver_src_fdate_pl));

ver_src_tn_pos := Models.Common.findw_cpp(ver_sources, 'TN' , '  ,', 'ie');

ver_src_tn := ver_src_tn_pos > 0;

_ver_src_fdate_tn := if(ver_src_tn_pos > 0, Models.Common.getw(ver_sources_first_seen, ver_src_tn_pos), '0');

ver_src_fdate_tn := common.sas_date((    STRING)(_ver_src_fdate_tn));

ver_src_ts_pos := Models.Common.findw_cpp(ver_sources, 'TS' , '  ,', 'ie');

ver_src_ts := ver_src_ts_pos > 0;

_ver_src_fdate_ts := if(ver_src_ts_pos > 0, Models.Common.getw(ver_sources_first_seen, ver_src_ts_pos), '0');

ver_src_fdate_ts := common.sas_date((    STRING)(_ver_src_fdate_ts));

ver_src_tu_pos := Models.Common.findw_cpp(ver_sources, 'TU' , '  ,', 'ie');

ver_src_tu := ver_src_tu_pos > 0;

_ver_src_fdate_tu := if(ver_src_tu_pos > 0, Models.Common.getw(ver_sources_first_seen, ver_src_tu_pos), '0');

ver_src_fdate_tu := common.sas_date((    STRING)(_ver_src_fdate_tu));

ver_src_sl_pos := Models.Common.findw_cpp(ver_sources, 'SL' , '  ,', 'ie');

ver_src_nas_sl := if(ver_src_sl_pos > 0, (real)Models.Common.getw(ver_sources_NAS, ver_src_sl_pos), 0);

_ver_src_fdate_sl := if(ver_src_sl_pos > 0, Models.Common.getw(ver_sources_first_seen, ver_src_sl_pos), '0');

ver_src_fdate_sl := common.sas_date((    STRING)(_ver_src_fdate_sl));

ver_src_v_pos := Models.Common.findw_cpp(ver_sources, 'V' , '  ,', 'ie');

_ver_src_fdate_v := if(ver_src_v_pos > 0, Models.Common.getw(ver_sources_first_seen, ver_src_v_pos), '0');

ver_src_fdate_v := common.sas_date((    STRING)(_ver_src_fdate_v));

ver_src_vo_pos := Models.Common.findw_cpp(ver_sources, 'VO' , '  ,', 'ie');

_ver_src_fdate_vo := if(ver_src_vo_pos > 0, Models.Common.getw(ver_sources_first_seen, ver_src_vo_pos), '0');

ver_src_fdate_vo := common.sas_date((    STRING)(_ver_src_fdate_vo));

ver_src_w_pos := Models.Common.findw_cpp(ver_sources, 'W' , '  ,', 'ie');

_ver_src_fdate_w := if(ver_src_w_pos > 0, Models.Common.getw(ver_sources_first_seen, ver_src_w_pos), '0');

ver_src_fdate_w := common.sas_date((    STRING)(_ver_src_fdate_w));

ver_src_wp_pos := Models.Common.findw_cpp(ver_sources, 'WP' , '  ,', 'ie');

_ver_src_fdate_wp := if(ver_src_wp_pos > 0, Models.Common.getw(ver_sources_first_seen, ver_src_wp_pos), '0');

ver_src_fdate_wp := common.sas_date((    STRING)(_ver_src_fdate_wp));

ver_lname_src_sl_pos := Models.Common.findw_cpp(ver_lname_sources, 'SL' , '  ,', 'ie');

ver_lname_src_sl := ver_lname_src_sl_pos > 0;

ver_dob_src_sl_pos := Models.Common.findw_cpp(ver_dob_sources, 'SL' , '  ,', 'ie');

ver_dob_src_sl := ver_dob_src_sl_pos > 0;

ver_dob_src_vo_pos := Models.Common.findw_cpp(ver_dob_sources, 'VO' , '  ,', 'ie');

ver_dob_src_vo := ver_dob_src_vo_pos > 0;

rv_s65_ssn_prior_dob := map(
    not(ssnlength > '0' and dobpop)              => NULL,
    rc_ssndobflag = '1' or rc_pwssndobflag = '1' => 1,
    rc_ssndobflag = '0' or rc_pwssndobflag = '0' => 0,
                                                   NULL);

rv_s65_ssn_invalid := map(
    not(ssnlength > '0')                                                                                 => NULL,
    rc_ssnvalflag = '1' or (rc_pwssnvalflag in ['1', '2', '3']) or (inputssncharflag in ['1', '2', '3']) => 1,
    rc_ssnvalflag = '0' or (rc_pwssnvalflag in ['0', '4', '5']) or (inputssncharflag in ['0', '4', '5']) => 0,
                                                                                                          NULL);

_rc_ssnlowissue := common.sas_date((    STRING)(rc_ssnlowissue));

_in_dob := common.sas_date((    STRING)(in_dob));

ssn_years := if(_rc_ssnlowissue = NULL or sysdate = NULL, NULL, if ((sysdate - _rc_ssnlowissue) / 365.25 >= 0, roundup((sysdate - _rc_ssnlowissue) / 365.25), truncate((sysdate - _rc_ssnlowissue) / 365.25)));

calc_dob := if(_in_dob = NULL or sysdate = NULL, NULL, if ((sysdate - _in_dob) / 365.25 >= 0, roundup((sysdate - _in_dob) / 365.25), truncate((sysdate - _in_dob) / 365.25)));

nf_age_at_ssn_issuance := map(
    not(truedid and (ssnlength in ['4', '9'])) or sysdate = NULL or ssn_years = NULL => NULL,
    rc_ssnlowissue = 20110625                                                        => NULL,
    not(calc_dob = NULL)                                                             => calc_dob - ssn_years,
    inferred_age = 0                                                                 => NULL,
                                                                                        inferred_age - ssn_years);

iv_phn_cell := map(
    not(hphnpop)                                              => NULL,
    rc_hriskphoneflag = '1' or 
    trim(trim(rc_hphonetypeflag, LEFT), LEFT, RIGHT) = '1' or 
    trim(trim(telcordia_type, LEFT), LEFT, RIGHT) = '04' or 
    trim(trim(telcordia_type, LEFT), LEFT, RIGHT) = '55' or 
    trim(trim(telcordia_type, LEFT), LEFT, RIGHT) = '60'      => 1,
   
                                                              0);

rv_c14_addrs_10yr := map(
    not(truedid)     => NULL,
    (integer)add_curr_pop = 0 => -1,
                        min(if(addrs_10yr = NULL, -NULL, addrs_10yr), 999));

nf_inq_adlsperssn_recency := map(
    not(truedid)                    => NULL,
    (boolean)inq_adlsperssn_count01 => 1,
    (boolean)inq_adlsperssn_count03 => 3,
    (boolean)inq_adlsperssn_count06 => 6,
    (boolean)Inq_ADLsPerSSN         => 12,
                              0);

nf_inq_adlsperphone_recency := map(
    not(truedid)                      => NULL,
    (boolean)inq_adlsperphone_count01 => 1,
    (boolean)inq_adlsperphone_count03 => 3,
    (boolean)inq_adlsperphone_count06 => 6,
    (boolean)Inq_ADLsPerPhone         => 12,
                                0);

// iv_add_apt := if(STRINGLib.STRINGToUpperCase(trim(rc_dwelltype, LEFT, RIGHT)) = 'A' or  
                 // STRINGLib.STRINGToUpperCase(trim(out_addr_type, LEFT, RIGHT)) = 'H' or 
                 // not((integer)out_unit_desig = NULL) or not((integer)out_sec_range = NULL), 1, 0);
                 
iv_add_apt := if(STRINGLib.STRINGToUpperCase(trim(rc_dwelltype, LEFT, RIGHT)) = 'A' or  
                 STRINGLib.STRINGToUpperCase(trim(out_addr_type, LEFT, RIGHT)) = 'H' or 
                 (out_unit_desig <> '') or (out_sec_range <> ''), 1, 0);
                 

rv_l79_adls_per_apt_addr := map(
    not(addrpop)   => NULL,
    iv_add_apt = 0 => -1,
                      min(if(adls_per_addr_curr = NULL, -NULL, adls_per_addr_curr), 999));

rv_l79_adls_per_addr_c6 := if(not(addrpop), NULL, min(if(adls_per_addr_c6 = NULL, -NULL, adls_per_addr_c6), 999));

iv_nap_nothing_found := (nap_summary in [0]);

nf_phone_ver_insurance := if(not(truedid), NULL, (integer)phone_ver_insurance);

iv_input_best_name_match := map(
    not(truedid) or input_fname_isbestmatch = '-3' or input_lname_isbestmatch = '-3' => NULL,
    input_fname_isbestmatch = '1' and input_lname_isbestmatch = '1'                  => 3,
    input_lname_isbestmatch = '1'                                                    => 2,
    input_fname_isbestmatch = '1'                                                    => 1,
    input_fname_isbestmatch = '0' and input_lname_isbestmatch = '0'                  => 0,
    input_fname_isbestmatch = '-2' or input_lname_isbestmatch = '-2'                 => -1,
                                                                                    NULL);

nf_adls_per_phone_c6 := if(not(hphnpop), NULL, min(if(adls_per_phone_c6 = NULL, -NULL, adls_per_phone_c6), 999));

nf_fp_divrisktype := if(not(truedid), NULL, (integer)fp_divrisktype);

earliest_header_date := if(max(ver_src_fdate_de, 
                               ver_src_fdate_e4, 
                               ver_src_fdate_ar, 
                               ver_src_fdate_co, 
                               ver_src_fdate_em, 
                               ver_src_fdate_pl, 
                               ver_src_fdate_ds, 
                               ver_src_fdate_en, 
                               ver_src_fdate_mw, 
                               ver_src_fdate_ba, 
                               ver_src_fdate_da, 
                               ver_src_fdate_vo, 
                               ver_src_fdate_eq, 
                               ver_src_fdate_cy, 
                               ver_src_fdate_dl, 
                               ver_src_fdate_tu, 
                               ver_src_fdate_d, 
                               ver_src_fdate_e1, 
                               ver_src_fdate_ts, 
                               ver_src_fdate_wp, 
                               ver_src_fdate_ak, 
                               ver_src_fdate_am, 
                               ver_src_fdate_e2, 
                               ver_src_fdate_nt, 
                               ver_src_fdate_fr, 
                               ver_src_fdate_v, 
                               ver_src_fdate_p, 
                               ver_src_fdate_ff, 
                               ver_src_fdate_cg, 
                               ver_src_fdate_eb, 
                               ver_src_fdate_sl, 
                               ver_src_fdate_e3, 
                               ver_src_fdate_l2, 
                               ver_src_fdate_w, 
                               ver_src_fdate_fe,
                               ver_src_fdate_li, 
                               ver_src_fdate_tn) = NULL, NULL, 
                        min(if(ver_src_fdate_de = NULL, -NULL, ver_src_fdate_de), 
                            if(ver_src_fdate_e4 = NULL, -NULL, ver_src_fdate_e4), 
                            if(ver_src_fdate_ar = NULL, -NULL, ver_src_fdate_ar), 
                            if(ver_src_fdate_co = NULL, -NULL, ver_src_fdate_co), 
                            if(ver_src_fdate_em = NULL, -NULL, ver_src_fdate_em), 
                            if(ver_src_fdate_pl = NULL, -NULL, ver_src_fdate_pl), 
                            if(ver_src_fdate_ds = NULL, -NULL, ver_src_fdate_ds), 
                            if(ver_src_fdate_en = NULL, -NULL, ver_src_fdate_en), 
                            if(ver_src_fdate_mw = NULL, -NULL, ver_src_fdate_mw), 
                            if(ver_src_fdate_ba = NULL, -NULL, ver_src_fdate_ba), 
                            if(ver_src_fdate_da = NULL, -NULL, ver_src_fdate_da), 
                            if(ver_src_fdate_vo = NULL, -NULL, ver_src_fdate_vo), 
                            if(ver_src_fdate_eq = NULL, -NULL, ver_src_fdate_eq), 
                            if(ver_src_fdate_cy = NULL, -NULL, ver_src_fdate_cy), 
                            if(ver_src_fdate_dl = NULL, -NULL, ver_src_fdate_dl), 
                            if(ver_src_fdate_tu = NULL, -NULL, ver_src_fdate_tu), 
                            if(ver_src_fdate_d = NULL, -NULL, ver_src_fdate_d), 
                            if(ver_src_fdate_e1 = NULL, -NULL, ver_src_fdate_e1), 
                            if(ver_src_fdate_ts = NULL, -NULL, ver_src_fdate_ts), 
                            if(ver_src_fdate_wp = NULL, -NULL, ver_src_fdate_wp), 
                            if(ver_src_fdate_ak = NULL, -NULL, ver_src_fdate_ak), 
                            if(ver_src_fdate_am = NULL, -NULL, ver_src_fdate_am), 
                            if(ver_src_fdate_e2 = NULL, -NULL, ver_src_fdate_e2), 
                            if(ver_src_fdate_nt = NULL, -NULL, ver_src_fdate_nt), 
                            if(ver_src_fdate_fr = NULL, -NULL, ver_src_fdate_fr), 
                            if(ver_src_fdate_v = NULL, -NULL, ver_src_fdate_v),
                            if(ver_src_fdate_p = NULL, -NULL, ver_src_fdate_p),
                            if(ver_src_fdate_ff = NULL, -NULL, ver_src_fdate_ff), 
                            if(ver_src_fdate_cg = NULL, -NULL, ver_src_fdate_cg), 
                            if(ver_src_fdate_eb = NULL, -NULL, ver_src_fdate_eb), 
                            if(ver_src_fdate_sl = NULL, -NULL, ver_src_fdate_sl), 
                            if(ver_src_fdate_e3 = NULL, -NULL, ver_src_fdate_e3), 
                            if(ver_src_fdate_l2 = NULL, -NULL, ver_src_fdate_l2), 
                            if(ver_src_fdate_w = NULL, -NULL, ver_src_fdate_w), 
                            if(ver_src_fdate_fe = NULL, -NULL, ver_src_fdate_fe), 
                            if(ver_src_fdate_li = NULL, -NULL, ver_src_fdate_li), 
                            if(ver_src_fdate_tn = NULL, -NULL, ver_src_fdate_tn)));

earliest_header_yrs := if(min(sysdate, earliest_header_date) = NULL, NULL, if ((sysdate - earliest_header_date) / 365.25 >= 0, roundup((sysdate - earliest_header_date) / 365.25), truncate((sysdate - earliest_header_date) / 365.25)));

iv_header_emergence_age := map(
    not(truedid)               => NULL,
    earliest_header_yrs = NULL => NULL,   //***added
    not(_in_dob = NULL)        => calc_dob - earliest_header_yrs,
    inferred_age = 0            => NULL,
                                  inferred_age - earliest_header_yrs);

num_bureau_srcs := if(max((integer)ver_src_eq, (integer)ver_src_en, (integer)ver_src_tn, (integer)ver_src_tu, (integer)ver_src_ts) = NULL, NULL, sum((integer)ver_src_eq, (integer)ver_src_en, (integer)ver_src_tn, (integer)ver_src_tu, (integer)ver_src_ts));

//num_sources := length(    STRINGLib.    STRINGFilterOut(ver_sources, ','));
   num_sources_temp := Models.common.countw(ver_sources, ',');
   num_sources      := IF(num_sources_temp = 0, 1, num_sources_temp);   
   
nf_bureau_only_rel_count := map(
    not(truedid)                  => NULL,
    num_sources > num_bureau_srcs => -1,
                                     min(if(rel_count = NULL, -NULL, rel_count), 5));

rv_c16_inv_ssn_per_adl := if(not(truedid), NULL, min(if(invalid_ssns_per_adl = NULL, -NULL, invalid_ssns_per_adl), 999));

iv_phn_pcs := map(
    not(hphnpop)                                                                                                                                                                                                                                                                                                                                                            => NULL,
    rc_hriskphoneflag = '3' or trim(trim(rc_hphonetypeflag, LEFT), LEFT, RIGHT) = '3' or trim(trim(telcordia_type, LEFT), LEFT, RIGHT) = '64' or trim(trim(telcordia_type, LEFT), LEFT, RIGHT) = '65' or trim(trim(telcordia_type, LEFT), LEFT, RIGHT) = '66' or trim(trim(telcordia_type, LEFT), LEFT, RIGHT) = '67' or trim(trim(telcordia_type, LEFT), LEFT, RIGHT) = '68' => 1,
                                                                                                                                                                                                                                                                                                                                                                               0);

nf_inq_perbestssn_count12 := if(not(truedid), NULL, min(if(inq_perbestssn = NULL, -NULL, inq_perbestssn), 999));

rv_l79_adls_per_addr_curr := if(not(addrpop), NULL, min(if(adls_per_addr_curr = NULL, -NULL, adls_per_addr_curr), 999));

iv_nap_lname_verd := (nap_summary in [2, 5, 7, 8, 9, 11, 12]);

iv_inf_lname_verd := (infutor_nap in [2, 5, 7, 8, 9, 11, 12]);

nf_recent_disconnects := if(not(hphnpop), NULL, min(if(recent_disconnects = NULL, -NULL, recent_disconnects), 999));

iv_best_ssn_invalid := map(
     best_ssn_valid = '6' or best_ssn_valid = '7' or not(truedid)      => NULL,
    (best_ssn_valid in ['1', '2', '3'])                                => 1,
    (best_ssn_valid in ['0', '4', '5'])                                => 0,
                                                                          NULL);

nf_add_input_mobility_index := map(
    not(addrpop)                 => NULL,
    add_input_occupants_1yr <= 0 => -1,
                                    round(if(max(add_input_turnover_1yr_in, add_input_turnover_1yr_out) = NULL, NULL, sum(if(add_input_turnover_1yr_in = NULL, 0, add_input_turnover_1yr_in), if(add_input_turnover_1yr_out = NULL, 0, add_input_turnover_1yr_out))) / add_input_occupants_1yr/0.1)*0.1);

nhood_ct := if(max(add_input_nhood_BUS_ct, add_input_nhood_SFD_ct, add_input_nhood_MFD_ct) = NULL, NULL, sum(if(add_input_nhood_BUS_ct = NULL, 0, add_input_nhood_BUS_ct), if(add_input_nhood_SFD_ct = NULL, 0, add_input_nhood_SFD_ct), if(add_input_nhood_MFD_ct = NULL, 0, add_input_nhood_MFD_ct)));

nf_add_input_nhood_bus_pct := map(
    not(addrpop)  => NULL,
    nhood_ct <= 0 => -1,
                     round(add_input_nhood_BUS_ct / nhood_ct/0.1)*0.1);

nf_phones_per_apt_addr_curr := map(
    not(addrpop)                      => NULL,
    not((boolean)(integer)iv_add_apt) => -1,
                                         min(if(phones_per_addr_curr = NULL, -NULL, phones_per_addr_curr), 999));

nf_hh_members_w_derog_pct := map(
    not(truedid)      => NULL,
    hh_members_ct = 0 => -1,
                         hh_members_w_derog / hh_members_ct);

nf_pct_rel_with_bk := map(
    not(truedid)  => NULL,
    rel_count = 0 => -1,
                     rel_bankrupt_count / rel_count);

vo_pos := Models.Common.findw_cpp(ver_sources, 'VO' , ', ', 'E');

iv_src_voter_adl_count := map(
    not(truedid)     => NULL,
    not(voter_avail) => -1,
    vo_pos <= 0      => 0,
                        (integer)Models.Common.getw(ver_sources_count, vo_pos, ','));

nf_linkstab_max_weight_element := if(not(truedid), '', link_max_weight_element);

mod1_v01_w := map(
    ver_src_nas_sl = NULL => 0,
    ver_src_nas_sl = -1   => 0,
    ver_src_nas_sl <= 1   => 0.133414315368231,
    ver_src_nas_sl <= 4   => -0.730982094499965,
                             -0.797600851454837);

mod1_v02_w := map(
    (integer)ver_dob_src_vo = NULL => 0,
    (integer)ver_dob_src_vo = -1   => 0,
    (integer)ver_dob_src_vo <= 0.5 => 0.147743213409716,
                                     -1.56189418207873);

mod1_v03_w := map(
    (integer)rv_s65_ssn_prior_dob = NULL => 0,
    (integer)rv_s65_ssn_prior_dob = -1   => 0,
    (integer)rv_s65_ssn_prior_dob <= 0.5 => -0.0106196519210984,
                                            2.23814892371517);

mod1_v04_w := map(
    rv_s65_ssn_invalid = NULL => 0,
    rv_s65_ssn_invalid = -1   => 0,
    rv_s65_ssn_invalid <= 0.5 => -0.16576895497634,
                                 4.62883177851602);

mod1_v05_w := map(
    nf_age_at_ssn_issuance = NULL  => 0,
    nf_age_at_ssn_issuance = -1    => -1.10505941242613,
    nf_age_at_ssn_issuance <= 1.5  => -1.10505941242613,
    nf_age_at_ssn_issuance <= 15.5 => -0.571734201840497,
    nf_age_at_ssn_issuance <= 18.5 => -0.52548859478283,
    nf_age_at_ssn_issuance <= 37.5 => 0.308942793320092,
                                      0.504310620157072);

mod1_v06_w := map(
    ssn_years = NULL  => 0,
    ssn_years = -1    => 0,
    ssn_years <= 6.5  => 2.87870848305465,
    ssn_years <= 10.5 => 1.73404932586121,
    ssn_years <= 16.5 => 1.06330317939349,
    ssn_years <= 17.5 => -0.530018395640955,
    ssn_years <= 26.5 => -1.3468985455907,
    ssn_years <= 30.5 => -1.67492733750293,
                         -2.64377989421383);

mod1_v07_w := map(
    iv_phn_cell = NULL => 0,
    iv_phn_cell = -1   => 0,
    iv_phn_cell <= 0.5 => -0.214441303805163,
                          0.0828074775900735);

mod1_v08_w := map(
    rv_c14_addrs_10yr = NULL => 0,
    rv_c14_addrs_10yr = -1   => -0.00170657699075395,
    rv_c14_addrs_10yr <= 1.5 => -0.00170657699075395,
    rv_c14_addrs_10yr <= 3.5 => -0.0350969365128602,
    rv_c14_addrs_10yr <= 4.5 => -0.0782328512478295,
    rv_c14_addrs_10yr <= 6.5 => -0.105171164636239,
    rv_c14_addrs_10yr <= 7.5 => -0.125663014268935,
                                -0.229606469088872);

mod1_v09_w := map(
    nf_inq_adlsperssn_recency = NULL => 0,
    nf_inq_adlsperssn_recency = -1   => 0,
    nf_inq_adlsperssn_recency <= 0.5 => -0.00187907153833979,
    nf_inq_adlsperssn_recency <= 2   => -1.44891374157798,
    nf_inq_adlsperssn_recency <= 4.5 => -0.699043361707451,
    nf_inq_adlsperssn_recency <= 9   => -0.65559314208799,
                                        -0.57652044627119);

mod1_v10_w := map(
    nf_inq_adlsperphone_recency = NULL => 0,
    nf_inq_adlsperphone_recency = -1   => 0,
    nf_inq_adlsperphone_recency <= 9   => -0.185049576497065,
                                          -0.0305406865749275);

mod1_v11_w := map(
    rv_l79_adls_per_apt_addr = NULL => 0,
    rv_l79_adls_per_apt_addr = -1   => -0.16363442231983,
    rv_l79_adls_per_apt_addr <= 0.5 => 0.573886378653577,
    rv_l79_adls_per_apt_addr <= 1.5 => 0.0675470178821692,
    rv_l79_adls_per_apt_addr <= 2.5 => 0.295874428471658,
    rv_l79_adls_per_apt_addr <= 3.5 => 0.394181310230234,
                                       0.722741619373798);

mod1_v12_w := map(
    rv_l79_adls_per_addr_c6 = NULL => 0,
    rv_l79_adls_per_addr_c6 = -1   => 0,
    rv_l79_adls_per_addr_c6 <= 0.5 => -0.090558165405339,
    rv_l79_adls_per_addr_c6 <= 1.5 => 0.02652692103672,
    rv_l79_adls_per_addr_c6 <= 2.5 => 0.278157310162205,
    rv_l79_adls_per_addr_c6 <= 3.5 => 0.402821497885686,
                                      0.517469954512544);

mod1_v13_w := map(
    (integer)iv_nap_nothing_found = NULL => 0,
    (integer)iv_nap_nothing_found = -1   => 0,
    (integer)iv_nap_nothing_found <= 0.5 => -0.0541094808843762,
                                             0.396974837094081);

mod1_v14_w := map(
    nf_phone_ver_insurance = NULL => 0,
    nf_phone_ver_insurance = -1   => 0,
    nf_phone_ver_insurance <= 0.5 => 0.284864268447844,
    nf_phone_ver_insurance <= 1.5 => 0.249742422272658,
    nf_phone_ver_insurance <= 3.5 => -0.0824565240214035,
                                     -0.14838361520868);

mod1_v15_w := map(
    iv_input_best_name_match = NULL => 0,
    iv_input_best_name_match = -1   => 0,
    iv_input_best_name_match <= 0.5 => 0.606794145590027,
    iv_input_best_name_match <= 2.5 => 0.0341178520968957,
                                       -0.16640606510316);

mod1_v16_w := map(
    nf_adls_per_phone_c6 = NULL => 0,
    nf_adls_per_phone_c6 = -1   => 0,
    nf_adls_per_phone_c6 <= 0.5 => 0.0240543935368475,
                                   -0.225231292761809);

mod1_v17_w := map(
    nf_fp_divrisktype = NULL => 0,
    nf_fp_divrisktype = -1   => 0,
    nf_fp_divrisktype <= 1.5 => -0.0450120427819867,
    nf_fp_divrisktype <= 2.5 => -0.022015173441876,
    nf_fp_divrisktype <= 3.5 => 0.0446901419736928,
                                0.0817844373517985);

mod1_v18_w := map(
    iv_header_emergence_age = NULL  => 0,
    iv_header_emergence_age = -1    => 0.639561242548352,
    iv_header_emergence_age <= 18.5 => -0.592305225824032,
    iv_header_emergence_age <= 19.5 => -0.398880149839118,
    iv_header_emergence_age <= 20.5 => -0.169728644465365,
    iv_header_emergence_age <= 21.5 => -0.0909814546852004,
    iv_header_emergence_age <= 25.5 => 0.13764835799849,
    iv_header_emergence_age <= 40.5 => 0.245133674782634,
                                       0.462669232313884);

mod1_v19_w := map(
    nf_bureau_only_rel_count = NULL => 0,
    nf_bureau_only_rel_count = -1   => -0.167183400546599,
    nf_bureau_only_rel_count <= 2.5 => 0.48096107307856,
                                       0.043563340804261);

mod1_v20_w := map(
    (real)c_professional = NULL   => 0,
          c_professional = ''     => 0,
    (real)c_professional = -1     => -0.389607059082325,
    (real)c_professional <= 1.05  => -0.203894454114104,
    (real)c_professional <= 5.35  => -0.17223268716834,
    (real)c_professional <= 13.15 => -0.116777119491344,
    (real)c_professional <= 17.15 => 0.0244168772396622,
    (real)c_professional <= 21.45 => 0.0306052083087355,
    (real)c_professional <= 33.65 => 0.127473680366716,
                                     0.304321275868335);

mod1_v21_w := map(
    (real)c_asian_lang = NULL   => 0,
          c_asian_lang = ''      => 0,   //***IF MISSING
    (real)c_asian_lang = -1     => 0,
    (real)c_asian_lang <= 120.5 => -0.185238011328644,
    (real)c_asian_lang <= 148.5 => -0.128908440197799,
    (real)c_asian_lang <= 150.5 => -0.121215577280202,
    (real)c_asian_lang <= 155.5 => -0.0535324943968244,
    (real)c_asian_lang <= 171.5 => -0.00577330341860405,
    (real)c_asian_lang <= 181.5 => 0.10697251362266,
    (real)c_asian_lang <= 184.5 => 0.114341890055913,
    (real)c_asian_lang <= 195.5 => 0.217520239041826,
                                   0.522751945163844);

mod1_lgt := -1.17179481756166 +
    mod1_v01_w +
    mod1_v02_w +
    mod1_v03_w +
    mod1_v04_w +
    mod1_v05_w +
    mod1_v06_w +
    mod1_v07_w +
    mod1_v08_w +
    mod1_v09_w +
    mod1_v10_w +
    mod1_v11_w +
    mod1_v12_w +
    mod1_v13_w +
    mod1_v14_w +
    mod1_v15_w +
    mod1_v16_w +
    mod1_v17_w +
    mod1_v18_w +
    mod1_v19_w +
    mod1_v20_w +
    mod1_v21_w;

mod2_v01_w := map(
    (real)ver_lname_src_sl = NULL => 0,
    //(real)ver_lname_src_sl = 0.0  => 0,  //***IF MISSING in SAS
    (real)ver_lname_src_sl = -1   => 0,
    (real)ver_lname_src_sl <= 0.5 => 0.0586787533576019,
                                    -0.344481063278993);

mod2_v02_w := map(
    (real)ver_dob_src_sl = NULL => 0,
   // (real)ver_dob_src_sl = 0    => 0,    //***IF MISSING in SAS
    (real)ver_dob_src_sl = -1   => 0,
    (real)ver_dob_src_sl <= 0.5 => 0.0432519627030472,
                             -0.31047665900779);

mod2_v03_w := map(
    (real)ver_dob_src_vo = NULL => 0,
   // (real)ver_dob_src_vo = 0    => 0,   //***IF MISSING in SAS
    (real)ver_dob_src_vo = -1   => 0,
    (real)ver_dob_src_vo <= 0.5 => 0.0955375678027957,
                                   -1.04368965216539);

mod2_v04_w := map(
    rv_c16_inv_ssn_per_adl = NULL => 0,
   // rv_c16_inv_ssn_per_adl = 0    => 0,  //***IF MISSING in SAS
    rv_c16_inv_ssn_per_adl = -1   => 0,
    rv_c16_inv_ssn_per_adl <= 0.5 => -0.536318776373581,
                                     1.53932994800122);

mod2_v05_w := map(
    iv_phn_pcs = NULL => 0,
   // iv_phn_pcs = 0    => 0,  //***IF MISSING
    iv_phn_pcs = -1   => 0,
    iv_phn_pcs <= 0.5 => 0.0416220681514677,
                         -0.248220859042921);

mod2_v06_w := map(
    nf_inq_perbestssn_count12 = NULL  => 0,
  //  nf_inq_perbestssn_count12 = 0     => 0,   //***IF MISSING
    nf_inq_perbestssn_count12 = -1    => 0,
    nf_inq_perbestssn_count12 <= 0.5  => -0.0990937562049296,
    nf_inq_perbestssn_count12 <= 2.5  => -0.530712551993831,
    nf_inq_perbestssn_count12 <= 11.5 => -0.589863647939843,
                                         -0.733455564346077);

mod2_v07_w := map(
    rv_l79_adls_per_addr_curr = NULL  => 0,
  //  rv_l79_adls_per_addr_curr = 0     => 0,   //***IF missing
    rv_l79_adls_per_addr_curr = -1    => 0,
    rv_l79_adls_per_addr_curr <= 0.5  => 0.555424155473212,
    rv_l79_adls_per_addr_curr <= 5.5  => -0.148943957975633,
    rv_l79_adls_per_addr_curr <= 6.5  => -0.0925847242880807,
    rv_l79_adls_per_addr_curr <= 8.5  => 0.0953095473920852,
    rv_l79_adls_per_addr_curr <= 10.5 => 0.324417917537663,
                                         0.701607266118354);

mod2_v08_w := map(
    rv_l79_adls_per_addr_c6 = NULL => 0,
  //  rv_l79_adls_per_addr_c6 = 0    => 0,  //***IF MISSING
    rv_l79_adls_per_addr_c6 = -1   => 0,
    rv_l79_adls_per_addr_c6 <= 0.5 => -0.123309871090273,
    rv_l79_adls_per_addr_c6 <= 1.5 => -0.00188898793183386,
    rv_l79_adls_per_addr_c6 <= 2.5 => 0.150621179251448,
    rv_l79_adls_per_addr_c6 <= 3.5 => 0.467549612998875,
                                      0.650687109422739);

mod2_v09_w := map(
    (real)iv_nap_lname_verd = NULL => 0,
  //  (real)iv_nap_lname_verd = 0    => 0,  //***IF MISSING
    (real)iv_nap_lname_verd = -1   => 0,
    (real)iv_nap_lname_verd <= 0.5 => 0.74412452801073,
                                     -0.27116099761824);

mod2_v10_w := map(
    (real)iv_inf_lname_verd = NULL => 0,
  //  (real)iv_inf_lname_verd = 0    => 0,  //***IF MISSING
    (real)iv_inf_lname_verd = -1   => 0,
    (real)iv_inf_lname_verd <= 0.5 => 0.072983771818681,
                                     -0.286700058879536);
 
mod2_v11_w := map(
    nf_recent_disconnects = NULL => 0,
 //   nf_recent_disconnects = 0    => 0,   //***IF MISSING
    nf_recent_disconnects = -1   => 0,
    nf_recent_disconnects <= 0.5 => 0.0239900910043361,
                                    -1.0479090962134);

mod2_v12_w := map(
    iv_best_ssn_invalid = NULL => 0,
  //  iv_best_ssn_invalid = 0    => 0,  //***IF MISSING
    iv_best_ssn_invalid = -1   => 0,
    iv_best_ssn_invalid <= 0.5 => -0.274686721315829,
                                  1.20482707016202);

mod2_v13_w := map(
    nf_add_input_mobility_index = NULL  => 0,
    nf_add_input_mobility_index = -1    => 0.387336693326749,
    nf_add_input_mobility_index <= 0.15 => -0.633885897086847,
    nf_add_input_mobility_index <= 0.25 => -0.384853931122546,
    nf_add_input_mobility_index <= 0.35 => -0.00634919282919499,
    nf_add_input_mobility_index <= 0.45 => 0.106060909504929,
    nf_add_input_mobility_index <= 0.55 => 0.38799485371483,
                                           0.735865703310048);

mod2_v14_w := map(
    nf_add_input_nhood_bus_pct = NULL  => 0,
    nf_add_input_nhood_bus_pct = -1    => 0.648896249289814,
    nf_add_input_nhood_bus_pct <= 0.05 => -0.0650583973517668,
    nf_add_input_nhood_bus_pct <= 0.15 => 0.0300338154905962,
    nf_add_input_nhood_bus_pct <= 0.25 => 0.0806267454845044,
                                          0.284515340146871);

mod2_v15_w := map(
    nf_phones_per_apt_addr_curr = NULL => 0,
    nf_phones_per_apt_addr_curr = -1   => -0.299507978091097,
    nf_phones_per_apt_addr_curr <= 0.5 => 1.02611144928578,
                                          0.487867006278259);

mod2_v16_w := map(
    nf_hh_members_w_derog_pct = NULL          => 0,
    nf_hh_members_w_derog_pct = -1            => 0.118555590416513,
    nf_hh_members_w_derog_pct <= 0.0801282051 => 0.0582947407525504,
    nf_hh_members_w_derog_pct <= 0.1558704453 => -0.0293417719158854,
    nf_hh_members_w_derog_pct <= 0.1846590909 => -0.13235995406966,
    nf_hh_members_w_derog_pct <= 0.3660287081 => -0.140010143000968,
    nf_hh_members_w_derog_pct <= 0.541958042  => -0.174774068682116,
                                                 -0.260442786443943);

mod2_v17_w := map(
    nf_pct_rel_with_bk = NULL           => 0,
    nf_pct_rel_with_bk = -1             => 0.325716166188564,
    nf_pct_rel_with_bk <= 0.04083333335 => -0.0825872216637277,
    nf_pct_rel_with_bk <= 0.0875959079  => -0.328181619353643,
    nf_pct_rel_with_bk <= 0.1867732558  => -0.450082255692796,
    nf_pct_rel_with_bk <= 0.21132376395 => -0.490891352279097,
                                           -0.502172083388974);

mod2_v18_w := map(
    iv_header_emergence_age = NULL  => 0,
    iv_header_emergence_age = -1    => 0.0888071764261049,
    iv_header_emergence_age <= 18.5 => -1.35950695981757,
    iv_header_emergence_age <= 19.5 => -1.11426108583525,
    iv_header_emergence_age <= 20.5 => -0.441218355133442,
    iv_header_emergence_age <= 21.5 => -0.262391849846109,
    iv_header_emergence_age <= 23.5 => 0.133464527021855,
    iv_header_emergence_age <= 25.5 => 0.20674662880644,
    iv_header_emergence_age <= 31.5 => 0.300097304999706,
    iv_header_emergence_age <= 40.5 => 0.372010949198566,
                                       0.766666209375442);

mod2_v19_w := map(
    nf_bureau_only_rel_count = NULL => 0,
    nf_bureau_only_rel_count = -1   => -0.422408500016196,
    nf_bureau_only_rel_count <= 0.5 => 0.912126201058127,
    nf_bureau_only_rel_count <= 2.5 => 0.744531963306418,
    nf_bureau_only_rel_count <= 4.5 => 0.0703198312569576,
                                       -0.145973756434204);

mod2_v20_w := map(
    iv_src_voter_adl_count = NULL => 0,
    iv_src_voter_adl_count = -1   => -0.264364187940607,
    iv_src_voter_adl_count <= 0.5 => 0.338196143062739,
                                     -2.63807499753993);

mod2_v21_w := map(
    nf_linkstab_max_weight_element = ''                => 0,
    nf_linkstab_max_weight_element in ['dob']          => -0.274403185441914,
    (nf_linkstab_max_weight_element in ['fname'])      => 0.281045417264736,
    (nf_linkstab_max_weight_element in ['lname'])      => 0.245360573687886,
    (nf_linkstab_max_weight_element in ['phone'])      => 0.129464314080282,
    (nf_linkstab_max_weight_element in ['prim_name'])  => 0,
    (nf_linkstab_max_weight_element in ['prim_range']) => 0,
                                                          0);

mod2_v22_w := map(
    (real)c_burglary = NULL   => 0,
          c_burglary = ''     => 0,  //***IF MISSING
    (real)c_burglary = -1     => 0,
    (real)c_burglary <= 4     => -0.716136981307169,
    (real)c_burglary <= 47    => -0.542509960425471,
    (real)c_burglary <= 188.5 => -0.501307563544855,
    (real)c_burglary <= 192.5 => -0.180147763310099,
                           0.24732797821806);

mod2_v23_w := map(
    (real)c_professional = NULL   => 0,
          c_professional = ''     => 0,   //***IF MISSING
    (real)c_professional = -1     => -0.336752149167171,
    (real)c_professional <= 1.15  => -0.188756455770133,
    (real)c_professional <= 5.45  => -0.155717640830242,
    (real)c_professional <= 12.75 => -0.132018581276135,
    (real)c_professional <= 16.25 => -0.078801416120627,
    (real)c_professional <= 23.65 => -0.0318996643999069,
    (real)c_professional <= 33.65 => 0.0315074448597845,
                                     0.0973007307112895);

mod2_v24_w := map(
    (real)c_asian_lang = NULL   => 0,
          c_asian_lang = ''     => 0,     //****IF MISSING
    (real)c_asian_lang = -1     => 0,
    (real)c_asian_lang <= 120.5 => -0.559807494983991,
    (real)c_asian_lang <= 141.5 => -0.421947935498169,
    (real)c_asian_lang <= 156.5 => -0.285862304145907,
    (real)c_asian_lang <= 171.5 => -0.214656766773124,
    (real)c_asian_lang <= 183.5 => 0.0552078176654333,
    (real)c_asian_lang <= 192.5 => 0.192783452257107,
    (real)c_asian_lang <= 195.5 => 0.458449476853622,
                             0.917612776169251);

mod2_v25_w := map(
    (real)c_span_lang = NULL   => 0,
          c_span_lang = ''     => 0,      //****IF MISSING
    (real)c_span_lang = -1     => 0,
    (real)c_span_lang <= 49.5  => -0.696490747583169,
    (real)c_span_lang <= 84.5  => -0.623110568783147,
    (real)c_span_lang <= 121.5 => -0.373580961344605,
    (real)c_span_lang <= 128.5 => -0.333304434163264,
    (real)c_span_lang <= 150.5 => -0.288185813367836,
    (real)c_span_lang <= 172.5 => 0.0225810898028596,
    (real)c_span_lang <= 190.5 => 0.332649804194577,
                            0.562490177756968);

mod2_lgt := -0.110431569161878 +
    mod2_v01_w +
    mod2_v02_w +
    mod2_v03_w +
    mod2_v04_w +
    mod2_v05_w +
    mod2_v06_w +
    mod2_v07_w +
    mod2_v08_w +
    mod2_v09_w +
    mod2_v10_w +
    mod2_v11_w +
    mod2_v12_w +
    mod2_v13_w +
    mod2_v14_w +
    mod2_v15_w +
    mod2_v16_w +
    mod2_v17_w +
    mod2_v18_w +
    mod2_v19_w +
    mod2_v20_w +
    mod2_v21_w +
    mod2_v22_w +
    mod2_v23_w +
    mod2_v24_w +
    mod2_v25_w;

base := 650;

pts := -30;

lgt := ln(0.0886 / (1 - 0.0886));

citizen_score := if('0' <= rc_ssnvalflag AND rc_ssnvalflag <= '2', round(max((real)300, min(999, if(base + pts * (mod1_lgt - lgt) / ln(2) = NULL, -NULL, base + pts * (mod1_lgt - lgt) / ln(2))))), round(max((real)300, min(999, if(base + pts * (mod2_lgt - lgt) / ln(2) = NULL, -NULL, base + pts * (mod2_lgt - lgt) / ln(2))))));


//*************************************************************************************//
//     End Generated ECL Code
//*************************************************************************************//

	#if(FP_DEBUG)
		/* Model Input Variables */

    /*  Finish up the TRANSFORM by populating the results  */
         
         self.sysdate                          := sysdate;
				 self.model_name                       := 'CIT1808_0_0';                      
         self.ver_src_ak_pos                   := ver_src_ak_pos;
         self._ver_src_fdate_ak                := _ver_src_fdate_ak;
         self.ver_src_fdate_ak                 := ver_src_fdate_ak;
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
         self.ver_src_co_pos                   := ver_src_co_pos;
         self._ver_src_fdate_co                := _ver_src_fdate_co;
         self.ver_src_fdate_co                 := ver_src_fdate_co;
         self.ver_src_cy_pos                   := ver_src_cy_pos;
         self._ver_src_fdate_cy                := _ver_src_fdate_cy;
         self.ver_src_fdate_cy                 := ver_src_fdate_cy;
         self.ver_src_da_pos                   := ver_src_da_pos;
         self._ver_src_fdate_da                := _ver_src_fdate_da;
         self.ver_src_fdate_da                 := ver_src_fdate_da;
         self.ver_src_d_pos                    := ver_src_d_pos;
         self._ver_src_fdate_d                 := _ver_src_fdate_d;
         self.ver_src_fdate_d                  := ver_src_fdate_d;
         self.ver_src_dl_pos                   := ver_src_dl_pos;
         self._ver_src_fdate_dl                := _ver_src_fdate_dl;
         self.ver_src_fdate_dl                 := ver_src_fdate_dl;
         self.ver_src_ds_pos                   := ver_src_ds_pos;
         self._ver_src_fdate_ds                := _ver_src_fdate_ds;
         self.ver_src_fdate_ds                 := ver_src_fdate_ds;
         self.ver_src_de_pos                   := ver_src_de_pos;
         self._ver_src_fdate_de                := _ver_src_fdate_de;
         self.ver_src_fdate_de                 := ver_src_fdate_de;
         self.ver_src_eb_pos                   := ver_src_eb_pos;
         self._ver_src_fdate_eb                := _ver_src_fdate_eb;
         self.ver_src_fdate_eb                 := ver_src_fdate_eb;
         self.ver_src_em_pos                   := ver_src_em_pos;
         self._ver_src_fdate_em                := _ver_src_fdate_em;
         self.ver_src_fdate_em                 := ver_src_fdate_em;
         self.ver_src_e1_pos                   := ver_src_e1_pos;
         self._ver_src_fdate_e1                := _ver_src_fdate_e1;
         self.ver_src_fdate_e1                 := ver_src_fdate_e1;
         self.ver_src_e2_pos                   := ver_src_e2_pos;
         self._ver_src_fdate_e2                := _ver_src_fdate_e2;
         self.ver_src_fdate_e2                 := ver_src_fdate_e2;
         self.ver_src_e3_pos                   := ver_src_e3_pos;
         self._ver_src_fdate_e3                := _ver_src_fdate_e3;
         self.ver_src_fdate_e3                 := ver_src_fdate_e3;
         self.ver_src_e4_pos                   := ver_src_e4_pos;
         self._ver_src_fdate_e4                := _ver_src_fdate_e4;
         self.ver_src_fdate_e4                 := ver_src_fdate_e4;
         self.ver_src_en_pos                   := ver_src_en_pos;
         self.ver_src_en                       := ver_src_en;
         self._ver_src_fdate_en                := _ver_src_fdate_en;
         self.ver_src_fdate_en                 := ver_src_fdate_en;
         self.ver_src_eq_pos                   := ver_src_eq_pos;
         self.ver_src_eq                       := ver_src_eq;
         self._ver_src_fdate_eq                := _ver_src_fdate_eq;
         self.ver_src_fdate_eq                 := ver_src_fdate_eq;
         self.ver_src_fe_pos                   := ver_src_fe_pos;
         self._ver_src_fdate_fe                := _ver_src_fdate_fe;
         self.ver_src_fdate_fe                 := ver_src_fdate_fe;
         self.ver_src_ff_pos                   := ver_src_ff_pos;
         self._ver_src_fdate_ff                := _ver_src_fdate_ff;
         self.ver_src_fdate_ff                 := ver_src_fdate_ff;
         self.ver_src_fr_pos                   := ver_src_fr_pos;
         self._ver_src_fdate_fr                := _ver_src_fdate_fr;
         self.ver_src_fdate_fr                 := ver_src_fdate_fr;
         self.ver_src_l2_pos                   := ver_src_l2_pos;
         self._ver_src_fdate_l2                := _ver_src_fdate_l2;
         self.ver_src_fdate_l2                 := ver_src_fdate_l2;
         self.ver_src_li_pos                   := ver_src_li_pos;
         self._ver_src_fdate_li                := _ver_src_fdate_li;
         self.ver_src_fdate_li                 := ver_src_fdate_li;
         self.ver_src_mw_pos                   := ver_src_mw_pos;
         self._ver_src_fdate_mw                := _ver_src_fdate_mw;
         self.ver_src_fdate_mw                 := ver_src_fdate_mw;
         self.ver_src_nt_pos                   := ver_src_nt_pos;
         self._ver_src_fdate_nt                := _ver_src_fdate_nt;
         self.ver_src_fdate_nt                 := ver_src_fdate_nt;
         self.ver_src_p_pos                    := ver_src_p_pos;
         self._ver_src_fdate_p                 := _ver_src_fdate_p;
         self.ver_src_fdate_p                  := ver_src_fdate_p;
         self.ver_src_pl_pos                   := ver_src_pl_pos;
         self._ver_src_fdate_pl                := _ver_src_fdate_pl;
         self.ver_src_fdate_pl                 := ver_src_fdate_pl;
         self.ver_src_tn_pos                   := ver_src_tn_pos;
         self.ver_src_tn                       := ver_src_tn;
         self._ver_src_fdate_tn                := _ver_src_fdate_tn;
         self.ver_src_fdate_tn                 := ver_src_fdate_tn;
         self.ver_src_ts_pos                   := ver_src_ts_pos;
         self.ver_src_ts                       := ver_src_ts;
         self._ver_src_fdate_ts                := _ver_src_fdate_ts;
         self.ver_src_fdate_ts                 := ver_src_fdate_ts;
         self.ver_src_tu_pos                   := ver_src_tu_pos;
         self.ver_src_tu                       := ver_src_tu;
         self._ver_src_fdate_tu                := _ver_src_fdate_tu;
         self.ver_src_fdate_tu                 := ver_src_fdate_tu;
         self.ver_src_sl_pos                   := ver_src_sl_pos;
         self.ver_src_nas_sl                   := ver_src_nas_sl;
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
         self.ver_src_wp_pos                   := ver_src_wp_pos;
         self._ver_src_fdate_wp                := _ver_src_fdate_wp;
         self.ver_src_fdate_wp                 := ver_src_fdate_wp;
         self.ver_lname_src_sl_pos             := ver_lname_src_sl_pos;
         self.ver_lname_src_sl                 := ver_lname_src_sl;
         self.ver_dob_src_sl_pos               := ver_dob_src_sl_pos;
         self.ver_dob_src_sl                   := ver_dob_src_sl;
         self.ver_dob_src_vo_pos               := ver_dob_src_vo_pos;
         self.ver_dob_src_vo                   := ver_dob_src_vo;
         self.rv_s65_ssn_prior_dob             := rv_s65_ssn_prior_dob;
         self.rv_s65_ssn_invalid               := rv_s65_ssn_invalid;
         self._rc_ssnlowissue                  := _rc_ssnlowissue;
         self._in_dob                          := _in_dob;
         self.ssn_years                        := ssn_years;
         self.calc_dob                         := calc_dob;
         self.nf_age_at_ssn_issuance           := nf_age_at_ssn_issuance;
         self.iv_phn_cell                      := iv_phn_cell;
         self.rv_c14_addrs_10yr                := rv_c14_addrs_10yr;
         self.nf_inq_adlsperssn_recency        := nf_inq_adlsperssn_recency;
         self.nf_inq_adlsperphone_recency      := nf_inq_adlsperphone_recency;
         self.iv_add_apt                       := iv_add_apt;
         self.rv_l79_adls_per_apt_addr         := rv_l79_adls_per_apt_addr;
         self.rv_l79_adls_per_addr_c6          := rv_l79_adls_per_addr_c6;
         self.iv_nap_nothing_found             := iv_nap_nothing_found;
         self.nf_phone_ver_insurance           := nf_phone_ver_insurance;
         self.iv_input_best_name_match         := iv_input_best_name_match;
         self.nf_adls_per_phone_c6             := nf_adls_per_phone_c6;
         self.nf_fp_divrisktype                := nf_fp_divrisktype;
         self.earliest_header_date             := earliest_header_date;
         self.earliest_header_yrs              := earliest_header_yrs;
         self.iv_header_emergence_age          := iv_header_emergence_age;
         self.num_bureau_srcs                  := num_bureau_srcs;
         self.num_sources                      := num_sources;
         self.nf_bureau_only_rel_count         := nf_bureau_only_rel_count;
         self.rv_c16_inv_ssn_per_adl           := rv_c16_inv_ssn_per_adl;
         self.iv_phn_pcs                       := iv_phn_pcs;
         self.nf_inq_perbestssn_count12        := nf_inq_perbestssn_count12;
         self.rv_l79_adls_per_addr_curr        := rv_l79_adls_per_addr_curr;
         self.iv_nap_lname_verd                := iv_nap_lname_verd;
         self.iv_inf_lname_verd                := iv_inf_lname_verd;
         self.nf_recent_disconnects            := nf_recent_disconnects;
         self.iv_best_ssn_invalid              := iv_best_ssn_invalid;
         self.nf_add_input_mobility_index      := nf_add_input_mobility_index;
         self.nhood_ct                         := nhood_ct;
         self.nf_add_input_nhood_bus_pct       := nf_add_input_nhood_bus_pct;
         self.nf_phones_per_apt_addr_curr      := nf_phones_per_apt_addr_curr;
         self.nf_hh_members_w_derog_pct        := nf_hh_members_w_derog_pct;
         self.nf_pct_rel_with_bk               := nf_pct_rel_with_bk;
         self.vo_pos                           := vo_pos;
         self.iv_src_voter_adl_count           := iv_src_voter_adl_count;
         self.nf_linkstab_max_weight_element   := nf_linkstab_max_weight_element;
         self.c_professional                   := c_professional; 
         self.c_asian_lang                     := c_asian_lang; 
         self.c_span_lang                      := c_span_lang; 
         self.mod1_v01_w                       := mod1_v01_w;
         self.mod1_v02_w                       := mod1_v02_w;
         self.mod1_v03_w                       := mod1_v03_w;
         self.mod1_v04_w                       := mod1_v04_w;
         self.mod1_v05_w                       := mod1_v05_w;
         self.mod1_v06_w                       := mod1_v06_w;
         self.mod1_v07_w                       := mod1_v07_w;
         self.mod1_v08_w                       := mod1_v08_w;
         self.mod1_v09_w                       := mod1_v09_w;
         self.mod1_v10_w                       := mod1_v10_w;
         self.mod1_v11_w                       := mod1_v11_w;
         self.mod1_v12_w                       := mod1_v12_w;
         self.mod1_v13_w                       := mod1_v13_w;
         self.mod1_v14_w                       := mod1_v14_w;
         self.mod1_v15_w                       := mod1_v15_w;
         self.mod1_v16_w                       := mod1_v16_w;
         self.mod1_v17_w                       := mod1_v17_w;
         self.mod1_v18_w                       := mod1_v18_w;
         self.mod1_v19_w                       := mod1_v19_w;
         self.mod1_v20_w                       := mod1_v20_w;
         self.mod1_v21_w                       := mod1_v21_w;
         self.mod1_lgt                         := mod1_lgt;
         self.mod2_v01_w                       := mod2_v01_w;
         self.mod2_v02_w                       := mod2_v02_w;
         self.mod2_v03_w                       := mod2_v03_w;
         self.mod2_v04_w                       := mod2_v04_w;
         self.mod2_v05_w                       := mod2_v05_w;
         self.mod2_v06_w                       := mod2_v06_w;
         self.mod2_v07_w                       := mod2_v07_w;
         self.mod2_v08_w                       := mod2_v08_w;
         self.mod2_v09_w                       := mod2_v09_w;
         self.mod2_v10_w                       := mod2_v10_w;
         self.mod2_v11_w                       := mod2_v11_w;
         self.mod2_v12_w                       := mod2_v12_w;
         self.mod2_v13_w                       := mod2_v13_w;
         self.mod2_v14_w                       := mod2_v14_w;
         self.mod2_v15_w                       := mod2_v15_w;
         self.mod2_v16_w                       := mod2_v16_w;
         self.mod2_v17_w                       := mod2_v17_w;
         self.mod2_v18_w                       := mod2_v18_w;
         self.mod2_v19_w                       := mod2_v19_w;
         self.mod2_v20_w                       := mod2_v20_w;
         self.mod2_v21_w                       := mod2_v21_w;
         self.mod2_v22_w                       := mod2_v22_w;
         self.mod2_v23_w                       := mod2_v23_w;
         self.mod2_v24_w                       := mod2_v24_w;
         self.mod2_v25_w                       := mod2_v25_w;
         self.mod2_lgt                         := mod2_lgt;
         self.base                             := base;
         self.pts                              := pts;
         self.lgt                              := lgt;
         self.citizen_score                    := citizen_score; 
         self.citizenshipScore                 := (STRING)citizen_score;
         self.seq                              := le.seq;
	       self.clam                             := le;                     //***Attach the entire Boca Shell when DEBUG MODE is TRUE
#else																															
		     self.citizenshipScore                 := (STRING3)citizen_score;
		     self.seq                              := le.seq;
#end

	END;   //***End of the doModel TRANSFORM  


//===========================================================================================
//=== The Clam(Boca Shell) are joined together to get all of the intermediate variables  ====
//=== needed for this model.                                                             ====
//=== To match the modeler's code for picking Census Data:                               ====
//===  There are 2 versions of the JOIN to pick up the CENSUS Data.                      ====
//===  This is a discussion between the ECL Engineer and the Modeling team               ====
//===  Version 1 does a                                                                  ====
//===  join/search by input address                                                      ====
//===  Version 2 does a                                                                  ====
//===  join/search by 'input' address first and then by 'current' address (stored        ====
//===  Adress_Verification.Address_History_1                                             ====
//===========================================================================================	
  
  // model :=   JOIN(clam, Easi.Key_Easi_Census,
		             // (LEFT.shell_input.st <> '' AND 
                  // LEFT.shell_input.county <> ''	AND 
                  // LEFT.shell_input.geo_blk <> '' AND 
		              // LEFT.addrpop AND
		            // KEYED(RIGHT.geolink = LEFT.shell_input.st + LEFT.shell_input.county + LEFT.shell_input.geo_blk)) OR
		             // (LEFT.addrpop2 AND 
                 // ~LEFT.addrpop AND
		              // LEFT.Address_Verification.Address_History_1.st <> '' AND 
                  // LEFT.Address_Verification.Address_History_1.county <>''	AND 
                  // LEFT.Address_Verification.Address_History_1.geo_blk <> '' AND 
		            // KEYED(RIGHT.geolink = LEFT.Address_Verification.Address_History_1.st + LEFT.Address_Verification.Address_History_1.county + LEFT.Address_Verification.Address_History_1.geo_blk)), 
		              // doModel(LEFT, RIGHT), LEFT OUTER,
		            // ATMOST(RiskWise.max_atmost), KEEP(1));


       // model :=   join(clam, Easi.Key_Easi_Census,
	                     // left.shell_input.st<>''
		               // and left.shell_input.county <>''
		               // and left.shell_input.geo_blk <> ''
		               // and keyed(right.geolink=left.shell_input.st+left.shell_input.county+left.shell_input.geo_blk),
	                     // doModel(left, right), left outer,
	                // atmost(RiskWise.max_atmost)
	               // ,keep(1));
                 
                 
      model :=   join(clam, Easi.Key_Easi_Census,
	                     left.Address_Verification.Address_History_1.st <> ''
		               and left.Address_Verification.Address_History_1.county <> ''
		               and left.Address_Verification.Address_History_1.geo_blk  <> ''
		               and keyed(right.geolink = left.Address_Verification.Address_History_1.st + left.Address_Verification.Address_History_1.county 
                                                                                            + left.Address_Verification.Address_History_1.geo_blk),
	                     doModel(left, right), left outer,
	                atmost(RiskWise.max_atmost)
	               ,keep(1));
 

	
  RETURN(model);   //***Return the answer back to the calling module
END;



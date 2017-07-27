
import risk_indicators, riskwise, ut, easi;

blank_ip := dataset( [{0}], riskwise.Layout_IP2O )[1];

results_layout := RECORD
	RiskWise.Layout_NP2O;
	dataset(Risk_Indicators.Layout_Desc) ri;
	dataset(Risk_Indicators.Layout_Desc) fua;
	unsigned4 seq;
	string verlast := '';
	string veraddr := '';
	RiskWise.Layout_for_Royalties;
END;

export FP1403_1_0( grouped dataset(Risk_Indicators.Layout_Boca_Shell) clam1, dataset(results_layout) mapped_results, integer1 num_reasons) := FUNCTION

cvi_layout := Record
	risk_indicators.Layout_Boca_Shell;
	STRING3 np31_cvi_score;
End;

cvi_layout get_cvi(risk_indicators.Layout_Boca_Shell le, results_layout ri) := TRANSFORM
	self.np31_cvi_score := ri.score;
	self := le;
END;

clam := join(clam1, mapped_results, left.seq = right.seq, get_cvi(left, right), left outer);


FP_DEBUG := False;
	
	#if(FP_DEBUG)
Layout_Debug := RECORD
		/* Model Input Variables */
Integer sysdate                       ;
Boolean ver_src_ds                    ;
Boolean ver_src_eq                    ;
Boolean ver_src_en                    ;
Boolean ver_src_tn                    ;
Boolean ver_src_tu                    ;
Integer ver_src_cnt                   ;
Integer credit_source_cnt             ;
Boolean bureauonly2                   ;
Boolean _derog                        ;
String target_fp_segment              ;
String iv_vs002_ssn_prior_dob         ;
String iv_vs003_ssn_invalid           ;
String iv_vs001_ssn_deceased          ;
String iv_vp091_phnzip_mismatch       ;
String iv_va002_add_invalid           ;
Boolean email_src_im                  ;
Integer iv_ds001_impulse_count        ;
Integer bureau_adl_tn_fseen_pos       ;
String bureau_adl_fseen_tn            ;
Integer _bureau_adl_fseen_tn          ;
Integer bureau_adl_ts_fseen_pos       ;
String bureau_adl_fseen_ts            ;
Integer _bureau_adl_fseen_ts          ;
Integer bureau_adl_tu_fseen_pos       ;
String bureau_adl_fseen_tu            ;
Integer _bureau_adl_fseen_tu          ;
Integer bureau_adl_en_fseen_pos       ;
String bureau_adl_fseen_en            ;
Integer _bureau_adl_fseen_en          ;
Integer bureau_adl_eq_fseen_pos       ;
String bureau_adl_fseen_eq            ;
Integer _bureau_adl_fseen_eq          ;
Integer _src_bureau_adl_fseen         ;
Integer iv_sr001_m_bureau_adl_fs      ;
Integer iv_pl002_avg_mo_per_addr      ;
String iv_ed001_college_ind           ;
String iv_nas_summary                 ;
String iv_bst_own_prop_x_addr_naprop  ;
Integer iv_ssns_per_addr_c6           ;
Integer iv_inq_collection_recency     ;
Integer iv_inq_highriskcredit_recency ;
Integer iv_inq_communications_recency ;
Integer iv_inq_per_ssn                ;
Boolean ver_phn_inf                   ;
Boolean ver_phn_nap                   ;
Integer inf_phn_ver_lvl               ;
Integer nap_phn_ver_lvl               ;
String iv_nap_phn_ver_x_inf_phn_ver   ;
Integer iv_eviction_count             ;
String iv_criminal_x_felony           ;
String iv_pb_order_freq               ;
Integer nf_fp_srchaddrsrchcountmo     ;
String iv_add_apt                     ;
String iv_db001_bankruptcy            ;
Integer iv_de001_eviction_recency     ;
Integer bureau_ssn_tn_fseen_pos       ;
String bureau_ssn_fseen_tn            ;
Integer _bureau_ssn_fseen_tn          ;
Integer bureau_ssn_ts_fseen_pos       ;
String bureau_ssn_fseen_ts            ;
Integer _bureau_ssn_fseen_ts          ;
Integer bureau_ssn_tu_fseen_pos       ;
String bureau_ssn_fseen_tu            ;
Integer _bureau_ssn_fseen_tu          ;
Integer bureau_ssn_en_fseen_pos       ;
String bureau_ssn_fseen_en            ;
Integer _bureau_ssn_fseen_en          ;
Integer bureau_ssn_eq_fseen_pos       ;
String bureau_ssn_fseen_eq            ;
Integer _bureau_ssn_fseen_eq          ;
Integer _src_bureau_ssn_fseen         ;
Integer iv_mos_src_bureau_ssn_fseen   ;
String iv_inp_own_prop_x_addr_naprop  ;
Integer iv_ssns_per_sfd_addr_c6       ;
Integer iv_inq_per_addr               ;
Integer iv_liens_unrel_sc_ct          ;
Real sum_dols                         ;
Real pct_offline_dols                 ;
Real pct_retail_dols                  ;
Real pct_online_dols                  ;
String iv_pb_profile                  ;
String iv_input_addr_not_most_recent  ;
Integer iv_criminal_count             ;
String iv_prof_license_category       ;
Integer nf_fp_assoccredbureaucount    ;
Real s0_subscore0                     ;
Real s0_subscore1                     ;
Real s0_subscore2                     ;
Real s0_subscore3                     ;
Real s0_subscore4                     ;
Real s0_subscore5                     ;
Real s0_subscore6                     ;
Real s0_subscore7                     ;
Real s0_subscore8                     ;
Real s0_subscore9                     ;
Real s0_subscore10                    ;
Real s0_subscore11                    ;
Real s0_subscore12                    ;
Real s0_subscore13                    ;
Real s0_subscore14                    ;
Real s0_subscore15                    ;
Real s0_subscore16                    ;
Real s0_subscore17                    ;
Real s0_subscore18                    ;
Real s0_subscore19                    ;
Real s0_rawscore                      ;
Real s0_lnoddsscore                   ;
Real s0_probscore                     ;
Real s1_subscore0                     ;
Real s1_subscore1                     ;
Real s1_subscore2                     ;
Real s1_subscore3                     ;
Real s1_subscore4                     ;
Real s1_subscore5                     ;
Real s1_subscore6                     ;
Real s1_subscore7                     ;
Real s1_subscore8                     ;
Real s1_subscore9                     ;
Real s1_subscore10                    ;
Real s1_subscore11                    ;
Real s1_subscore12                    ;
Real s1_subscore13                    ;
Real s1_subscore14                    ;
Real s1_subscore15                    ;
Real s1_rawscore                      ;
Real s1_lnoddsscore                   ;
Real s1_probscore                     ;
Real s2_subscore0                     ;
Real s2_subscore1                     ;
Real s2_subscore2                     ;
Real s2_subscore3                     ;
Real s2_subscore4                     ;
Real s2_subscore5                     ;
Real s2_subscore6                     ;
Real s2_subscore7                     ;
Real s2_subscore8                     ;
Real s2_subscore9                     ;
Real s2_subscore10                    ;
Real s2_subscore11                    ;
Real s2_subscore12                    ;
Real s2_subscore13                    ;
Real s2_subscore14                    ;
Real s2_rawscore                      ;
Real s2_lnoddsscore                   ;
Real s2_probscore                     ;
Real probscore                        ;
Integer base                          ;
Integer pts                           ;
Real odds                             ;
Integer cust_fp_score_3_4             ;
Integer cust_fp_score_3_3             ;
Integer cust_fp_score_3_2             ;
Integer cust_fp_score_3_1             ;
Integer cust_fp_score_3               ;
String cust_fp_score_2                ;
String np31_cvi                       ;
String fp1403_1_0                    ;
		
		models.layout_modelout;
		risk_indicators.Layout_Boca_Shell clam;
		END;
		layout_debug doModel( clam le, easi.Key_Easi_Census ri ) :=  TRANSFORM
#else
		models.layout_modelout doModel( clam le, easi.Key_Easi_Census ri  ) := TRANSFORM
#end

	/* ***********************************************************
	 *             Model Input Variable Assignments              *
	 ************************************************************* */
	truedid                          := le.truedid;
	out_unit_desig                   := le.shell_input.unit_desig;
	out_sec_range                    := le.shell_input.sec_range;
	out_z5                           := le.shell_input.z5;
	out_addr_type                    := le.shell_input.addr_type;
	nas_summary                      := le.iid.nas_summary;
	nap_summary                      := le.iid.nap_summary;
	nap_type                         := le.iid.nap_type;
	rc_input_addr_not_most_recent    := le.iid.inputaddrnotmostrecent;
	rc_phonezipflag                  := le.iid.phonezipflag;
	rc_pwphonezipflag                := le.iid.pwphonezipflag;
	rc_decsflag                      := le.iid.decsflag;
	rc_ssndobflag                    := le.iid.socsdobflag;
	rc_pwssndobflag                  := le.iid.pwsocsdobflag;
	rc_ssnvalflag                    := le.iid.socsvalflag;
	rc_pwssnvalflag                  := le.iid.pwsocsvalflag;
	rc_addrvalflag                   := le.iid.addrvalflag;
	rc_dwelltype                     := le.iid.dwelltype;
	rc_bansflag                      := le.iid.bansflag;
	ver_sources                      := le.header_summary.ver_sources;
	ver_sources_first_seen           := le.header_summary.ver_sources_first_seen_date;
	ver_ssn_sources                  := le.header_summary.ver_ssn_sources;
	ver_ssn_sources_first_seen       := le.header_summary.ver_ssn_sources_first_seen_date;
	addrpop                          := le.input_validation.address;
	ssnlength                        := le.input_validation.ssn_length;
	dobpop                           := le.input_validation.dateofbirth;
	hphnpop                          := le.input_validation.homephone;
	add1_isbestmatch                 := le.address_verification.input_address_information.isbestmatch;
	add1_naprop                      := le.address_verification.input_address_information.naprop;
	add1_pop                         := le.addrpop;
	property_owned_total             := le.address_verification.owned.property_total;
	add2_naprop                      := le.address_verification.address_history_1.naprop;
	addrs_prison_history             := le.other_address_info.isprison;
	unique_addr_count                := le.address_history_summary.unique_addr_cnt;
	avg_mo_per_addr                  := le.address_history_summary.avg_mo_per_addr;
	inputssncharflag                 := le.ssn_verification.validation.inputsocscharflag;
	ssns_per_addr_c6                 := le.velocity_counters.ssns_per_addr_created_6months;
	inq_collection_count             := le.acc_logs.collection.counttotal;
	inq_collection_count01           := le.acc_logs.collection.count01;
	inq_collection_count03           := le.acc_logs.collection.count03;
	inq_collection_count06           := le.acc_logs.collection.count06;
	inq_collection_count12           := le.acc_logs.collection.count12;
	inq_collection_count24           := le.acc_logs.collection.count24;
	inq_highriskcredit_count         := le.acc_logs.highriskcredit.counttotal;
	inq_highriskcredit_count01       := le.acc_logs.highriskcredit.count01;
	inq_highriskcredit_count03       := le.acc_logs.highriskcredit.count03;
	inq_highriskcredit_count06       := le.acc_logs.highriskcredit.count06;
	inq_highriskcredit_count12       := le.acc_logs.highriskcredit.count12;
	inq_highriskcredit_count24       := le.acc_logs.highriskcredit.count24;
	inq_communications_count         := le.acc_logs.communications.counttotal;
	inq_communications_count01       := le.acc_logs.communications.count01;
	inq_communications_count03       := le.acc_logs.communications.count03;
	inq_communications_count06       := le.acc_logs.communications.count06;
	inq_communications_count12       := le.acc_logs.communications.count12;
	inq_communications_count24       := le.acc_logs.communications.count24;
	inq_perssn                       := le.acc_logs.inquiryperssn;
	inq_peraddr                      := le.acc_logs.inquiryperaddr;
	pb_number_of_sources             := le.ibehavior.number_of_sources;
	pb_average_days_bt_orders        := le.ibehavior.average_days_between_orders;
	pb_offline_dollars               := le.ibehavior.offline_dollars;
	pb_online_dollars                := le.ibehavior.online_dollars;
	pb_retail_dollars                := le.ibehavior.retail_dollars;
	infutor_nap                      := le.infutor_phone.infutor_nap;
	impulse_count                    := le.impulse.count;
	email_source_list                := le.email_summary.email_source_list;
	attr_num_unrel_liens60           := le.bjl.liens_unreleased_count60;
	attr_eviction_count              := le.bjl.eviction_count;
	attr_eviction_count90            := le.bjl.eviction_count90;
	attr_eviction_count180           := le.bjl.eviction_count180;
	attr_eviction_count12            := le.bjl.eviction_count12;
	attr_eviction_count24            := le.bjl.eviction_count24;
	attr_eviction_count36            := le.bjl.eviction_count36;
	attr_eviction_count60            := le.bjl.eviction_count60;
	fp_assoccredbureaucount          := le.fdattributesv2.assoccreditbureauonlycount;
	fp_srchaddrsrchcountmo           := le.fdattributesv2.searchaddrsearchcountmonth;
	bankrupt                         := le.bjl.bankrupt;
	disposition                      := le.bjl.disposition;
	filing_count                     := le.bjl.filing_count;
	bk_recent_count                  := le.bjl.bk_recent_count;
	liens_unrel_sc_ct                := le.liens.liens_unreleased_small_claims.count;
	criminal_count                   := le.bjl.criminal_count;
	felony_count                     := le.bjl.felony_count;
	ams_class                        := le.student.class;
	ams_college_code                 := le.student.college_code;
	ams_college_type                 := le.student.college_type;
	ams_income_level_code            := le.student.income_level_code;
	ams_file_type                    := le.student.file_type2;
	ams_college_tier                 := le.student.college_tier;
	ams_college_major                := le.student.college_major;
	prof_license_category            := le.professional_license.plcategory;
	c_fammar_p                       := ri.fammar_p;
	c_white_col                      := ri.white_col;


/* ***********************************************************
*                    Generated ECL                          *
************************************************************** */

NULL := -999999999;


INTEGER contains_i( string haystack, string needle ) := (INTEGER)(StringLib.StringFind(haystack, needle, 1) > 0);

sysdate := common.sas_date(if(le.historydate=999999, (string)ut.getdate, (string6)le.historydate+'01'));

ver_src_ds := Models.Common.findw_cpp(ver_sources, 'DS' , ', ', 'E') > 0;

ver_src_eq := Models.Common.findw_cpp(ver_sources, 'EQ' , ', ', 'E') > 0;

ver_src_en := Models.Common.findw_cpp(ver_sources, 'EN' , ', ', 'E') > 0;

ver_src_tn := Models.Common.findw_cpp(ver_sources, 'TN' , ', ', 'E') > 0;

ver_src_tu := Models.Common.findw_cpp(ver_sources, 'TU' , ', ', 'E') > 0;

// ver_src_cnt := sum(if((Integer)ver_sources = NULL, 0, 1), if(',' = (String)NULL, 0, 1));
ver_src_cnt := if((Integer)ver_sources = NULL, 0, StringLib.StringFindCount(ver_sources, ','));

credit_source_cnt := if(max((integer)ver_src_eq, (integer)ver_src_en, (integer)ver_src_tn, (integer)ver_src_tu) = NULL, NULL, sum((integer)ver_src_eq, (integer)ver_src_en, (integer)ver_src_tn, (integer)ver_src_tu));

bureauonly2 := credit_source_cnt > 0 and credit_source_cnt = ver_src_cnt and (StringLib.StringToUpperCase(nap_type) = 'U' or (nap_summary in [0, 1, 2, 3, 4, 6]));

_derog := felony_count > 0 or (Integer)addrs_prison_history > 0 or attr_num_unrel_liens60 > 0 or attr_eviction_count > 0 or impulse_count > 0;

target_fp_segment := map(
    (Integer)ver_src_ds = 1 or (Integer)rc_decsflag = 1 or (Integer)rc_ssndobflag = 1 or (Integer)rc_pwssndobflag = 1 => '0 ID Prob',
    (nas_summary in [4, 7, 9])                                                                                        => '0 ID Prob',
    nap_summary <= 4 and nas_summary <= 4 or ver_src_cnt = 0                                                          => '0 ID Prob',
    bureauonly2                                                                                                       => '0 ID Prob',
    _derog                                                                                                            => '1 Derog  ',
                                                                                                                         '2 Other  ');

iv_vs002_ssn_prior_dob := map(
    not((Integer)ssnlength > 0 and dobpop)                     => ' ',
    (Integer)rc_ssndobflag = 1 or (Integer)rc_pwssndobflag = 1 => '1',
    (Integer)rc_ssndobflag = 0 or (Integer)rc_pwssndobflag = 0 => '0',
                                                                  ' ');

iv_vs003_ssn_invalid := map(
    not((Integer)ssnlength > 0)                                                                                 => ' ',
    (Integer)rc_ssnvalflag = 1 or (rc_pwssnvalflag in ['1', '2', '3']) or (inputssncharflag in ['1', '2', '3']) => '1',
    (Integer)rc_ssnvalflag = 0 or (rc_pwssnvalflag in ['0', '4', '5']) or (inputssncharflag in ['0', '4', '5']) => '0',
                                                                                                          ' ');

iv_vs001_ssn_deceased := map(
    not(truedid or (Integer)ssnlength > 0)                                 => ' ',
    (Integer)rc_decsflag = 1                                               => '1',
    contains_i(ver_sources, 'DE') > 0 or contains_i(ver_sources, 'DS') > 0 => '1',
    (Integer)rc_decsflag = 0                                               => '0',
                                                                              ' ');

iv_vp091_phnzip_mismatch := map(
    not(hphnpop and not(out_z5 = ''))                              => ' ',
    (Integer)rc_phonezipflag = 1 or (Integer)rc_pwphonezipflag = 1 => '1',
    (Integer)rc_phonezipflag = 0 or (Integer)rc_pwphonezipflag = 0 => '0',
                                                                      ' ');

iv_va002_add_invalid := map(
    not(add1_pop)                                       => ' ',
    trim(trim(rc_addrvalflag, LEFT), LEFT, RIGHT) = 'N' => '1',
                                                           '0');

email_src_im := Models.Common.findw_cpp(email_source_list, 'IM' , ', ', 'E') > 0;

iv_ds001_impulse_count := map(
    not(truedid)                                    => NULL,
    impulse_count = 0 and (Integer)email_src_im > 0 => 1,
                                                       impulse_count);

bureau_adl_tn_fseen_pos := Models.Common.findw_cpp(ver_sources, 'TN' , ', ', 'E');

bureau_adl_fseen_tn := if(bureau_adl_tn_fseen_pos = 0, '       0', Models.Common.getw(ver_sources_first_seen, bureau_adl_tn_fseen_pos, ','));

_bureau_adl_fseen_tn := common.sas_date((string)(bureau_adl_fseen_tn));

bureau_adl_ts_fseen_pos := Models.Common.findw_cpp(ver_sources, 'TS' , ', ', 'E');

bureau_adl_fseen_ts := if(bureau_adl_ts_fseen_pos = 0, '       0', Models.Common.getw(ver_sources_first_seen, bureau_adl_ts_fseen_pos, ','));

_bureau_adl_fseen_ts := common.sas_date((string)(bureau_adl_fseen_ts));

bureau_adl_tu_fseen_pos := Models.Common.findw_cpp(ver_sources, 'TU' , ', ', 'E');

bureau_adl_fseen_tu := if(bureau_adl_tu_fseen_pos = 0, '       0', Models.Common.getw(ver_sources_first_seen, bureau_adl_tu_fseen_pos, ','));

_bureau_adl_fseen_tu := common.sas_date((string)(bureau_adl_fseen_tu));

bureau_adl_en_fseen_pos := Models.Common.findw_cpp(ver_sources, 'EN' , ', ', 'E');

bureau_adl_fseen_en := if(bureau_adl_en_fseen_pos = 0, '       0', Models.Common.getw(ver_sources_first_seen, bureau_adl_en_fseen_pos, ','));

_bureau_adl_fseen_en := common.sas_date((string)(bureau_adl_fseen_en));

bureau_adl_eq_fseen_pos := Models.Common.findw_cpp(ver_sources, 'EQ' , ', ', 'E');

bureau_adl_fseen_eq := if(bureau_adl_eq_fseen_pos = 0, '       0', Models.Common.getw(ver_sources_first_seen, bureau_adl_eq_fseen_pos, ','));

_bureau_adl_fseen_eq := common.sas_date((string)(bureau_adl_fseen_eq));

_src_bureau_adl_fseen := min(if(_bureau_adl_fseen_tn = NULL, -NULL, _bureau_adl_fseen_tn), if(_bureau_adl_fseen_ts = NULL, -NULL, _bureau_adl_fseen_ts), if(_bureau_adl_fseen_tu = NULL, -NULL, _bureau_adl_fseen_tu), if(_bureau_adl_fseen_en = NULL, -NULL, _bureau_adl_fseen_en), if(_bureau_adl_fseen_eq = NULL, -NULL, _bureau_adl_fseen_eq), 999999);

iv_sr001_m_bureau_adl_fs := map(
    not(truedid)                   => NULL,
    _src_bureau_adl_fseen = 999999 => -1,
                                      if ((sysdate - _src_bureau_adl_fseen) / (365.25 / 12) >= 0, truncate((sysdate - _src_bureau_adl_fseen) / (365.25 / 12)), roundup((sysdate - _src_bureau_adl_fseen) / (365.25 / 12))));

iv_pl002_avg_mo_per_addr := map(
    not(truedid)            => NULL,
    avg_mo_per_addr = -9999 => -1,
    unique_addr_count = 0   => -1,
                               avg_mo_per_addr);

iv_ed001_college_ind := map(
    not(truedid)                                                                                                                                       => ' ',
    // not((Integer)ams_college_code = NULL) or not((Integer)ams_college_type = NULL) or (integer)ams_college_tier >= 0 or not((Integer)ams_college_major = NULL) or (ams_file_type in ['H', 'C', 'A']) => '1',
    ams_college_code != '' or ams_college_type != '' or (Integer)ams_college_tier > 0 or ams_college_major != '' or (ams_file_type in ['H', 'C', 'A']) => '1',
    ams_file_type = 'M'                                                                                                                                => '0',
    // not((Integer)ams_class = NULL) or not((Integer)ams_income_level_code = NULL)                                                                    => '1',
    ams_class != '' or ams_income_level_code != ''                                                                                                     => '1',
                                                                                                                                                          '0');

iv_nas_summary := if(not(truedid or (Integer)ssnlength > 0), '  ', if(nas_summary < 10, '0' + (String)nas_summary, (String)nas_summary));//(trim('0' || (string)nas_summary, LEFT))[-2..]);

iv_bst_own_prop_x_addr_naprop_c18 := if(property_owned_total > 0, (string)(add1_naprop + 10), ('0' + (string)add1_naprop)[-2..]); //('0' + (string)add1_naprop)[-2:]);

iv_bst_own_prop_x_addr_naprop_c19 := if(property_owned_total > 0, (string)(add2_naprop + 10), ('0' + (string)add2_naprop)[-2..]); //('0' + (string)add2_naprop)[-2:]);

iv_bst_own_prop_x_addr_naprop := map(
    not(truedid)     => '  ',
    add1_isbestmatch => iv_bst_own_prop_x_addr_naprop_c18,
                        iv_bst_own_prop_x_addr_naprop_c19);

iv_ssns_per_addr_c6 := if(not(add1_pop), NULL, ssns_per_addr_c6);

iv_inq_collection_recency := map(
    not(truedid)                    => NULL,
    (BOOLEAN)inq_collection_count01 => 1,
    (BOOLEAN)inq_collection_count03 => 3,
    (BOOLEAN)inq_collection_count06 => 6,
    (BOOLEAN)inq_collection_count12 => 12,
    (BOOLEAN)inq_collection_count24 => 24,
    (BOOLEAN)inq_collection_count   => 99,
                                       0);

iv_inq_highriskcredit_recency := map(
    not(truedid)                        => NULL,
    (BOOLEAN)inq_highRiskCredit_count01 => 1,
    (BOOLEAN)inq_highRiskCredit_count03 => 3,
    (BOOLEAN)inq_highRiskCredit_count06 => 6,
    (BOOLEAN)inq_highRiskCredit_count12 => 12,
    (BOOLEAN)inq_highRiskCredit_count24 => 24,
    (BOOLEAN)inq_highRiskCredit_count   => 99,
                                           0);

iv_inq_communications_recency := map(
    not(truedid)                        => NULL,
    (BOOLEAN)inq_communications_count01 => 1,
    (BOOLEAN)inq_communications_count03 => 3,
    (BOOLEAN)inq_communications_count06 => 6,
    (BOOLEAN)inq_communications_count12 => 12,
    (BOOLEAN)inq_communications_count24 => 24,
    (BOOLEAN)inq_communications_count   => 99,
                                           0);

iv_inq_per_ssn := if(not((Integer)ssnlength > 0), NULL, inq_perssn);

ver_phn_inf := (infutor_nap in [4, 6, 7, 9, 10, 11, 12]);

ver_phn_nap := (nap_summary in [4, 6, 7, 9, 10, 11, 12]);

inf_phn_ver_lvl := map(
    ver_phn_inf     => 3,
    infutor_nap = 1 => 1,
    infutor_nap = 0 => 0,
                       2);

nap_phn_ver_lvl := map(
    ver_phn_nap     => 3,
    nap_summary = 1 => 1,
    nap_summary = 0 => 0,
                       2);

iv_nap_phn_ver_x_inf_phn_ver := map(
    not(addrpop or hphnpop) => '   ',
    not(hphnpop)            => ' -1',
                               trim((String)nap_phn_ver_lvl, LEFT, RIGHT) + trim(' - ', LEFT, RIGHT) + trim((String)inf_phn_ver_lvl, LEFT, RIGHT));

iv_eviction_count := if(not(truedid), NULL, attr_eviction_count);

criminal_count_var := min(if((Integer)criminal_count = NULL, NULL, criminal_count), 3);
felony_count_var := min(if(felony_count = NULL, NULL, felony_count), 3);

// iv_criminal_x_felony := if(not(truedid), '   ', trim(min(if(criminal_count = NULL, -NULL, criminal_count), 3), LEFT, RIGHT) + trim(' - ', LEFT, RIGHT) + trim(min(if(felony_count = NULL, -NULL, felony_count), 3), LEFT, RIGHT));
iv_criminal_x_felony := if(not(truedid), '   ', (String)criminal_count_var + '-' + (String)felony_count_var);

iv_pb_order_freq := map(
    not(truedid)                              => '                ',
    pb_number_of_sources = ''      => '0 No Purch Data ',
    pb_average_days_bt_orders = '' => '1 Cant Calculate',
    (Integer)pb_average_days_bt_orders <= 7   => '2 Weekly        ',
    (Integer)pb_average_days_bt_orders <= 30  => '3 Monthly       ',
    (Integer)pb_average_days_bt_orders <= 60  => '4 Semi-monthly  ',
    (Integer)pb_average_days_bt_orders <= 90  => '5 Quarterly     ',
    (Integer)pb_average_days_bt_orders <= 180 => '6 Semi-yearly   ',
    (Integer)pb_average_days_bt_orders <= 365 => '7 Yearly        ',
                                                 '8 Rarely        ');

nf_fp_srchaddrsrchcountmo := if(not(truedid), NULL, (Integer)fp_srchaddrsrchcountmo);

iv_add_apt := if(StringLib.StringToUpperCase(trim(rc_dwelltype, LEFT, RIGHT)) = 'A' or StringLib.StringToUpperCase(trim(out_addr_type, LEFT, RIGHT)) = 'H' or (out_unit_desig != '') or (out_sec_range != ''), '1', '0');

iv_db001_bankruptcy := map(
    not(truedid or (Integer)ssnlength > 0)                                                                                               => '                 ',
    (disposition in ['Discharge NA', 'Discharged'])                                                                                      => '1 - BK Discharged',
    (disposition in ['Dismissed'])                                                                                                       => '2 - BK Dismissed ',
    (rc_bansflag in ['1', '2']) or (Integer)bankrupt = 1 or contains_i(ver_sources, 'BA') > 0 or filing_count > 0 or bk_recent_count > 0 => '3 - BK Other     ',
                                                                                                                                            '0 - No BK        ');

iv_de001_eviction_recency := map(
    not(truedid)                                                => NULL,
    (boolean)attr_eviction_count90                              => 3,
    (boolean)attr_eviction_count180                             => 6,
    (boolean)attr_eviction_count12                              => 12,
    (boolean)attr_eviction_count24 and attr_eviction_count >= 2 => 24,
    (boolean)attr_eviction_count24                              => 25,
    (boolean)attr_eviction_count36 and attr_eviction_count >= 2 => 36,
    (boolean)attr_eviction_count36                              => 37,
    (boolean)attr_eviction_count60 and attr_eviction_count >= 2 => 60,
    (boolean)attr_eviction_count60                              => 61,
    attr_eviction_count >= 2                                    => 98,
    attr_eviction_count >= 1                                    => 99,
                                                                   0);

bureau_ssn_tn_fseen_pos := Models.Common.findw_cpp(ver_ssn_sources, 'TN' , ', ', 'E');

bureau_ssn_fseen_tn := if(bureau_ssn_tn_fseen_pos = 0, '       0', Models.Common.getw(ver_ssn_sources_first_seen, bureau_ssn_tn_fseen_pos, ','));

_bureau_ssn_fseen_tn := common.sas_date((string)(bureau_ssn_fseen_tn));

bureau_ssn_ts_fseen_pos := Models.Common.findw_cpp(ver_ssn_sources, 'TS' , ', ', 'E');

bureau_ssn_fseen_ts := if(bureau_ssn_ts_fseen_pos = 0, '       0', Models.Common.getw(ver_ssn_sources_first_seen, bureau_ssn_ts_fseen_pos, ','));

_bureau_ssn_fseen_ts := common.sas_date((string)(bureau_ssn_fseen_ts));

bureau_ssn_tu_fseen_pos := Models.Common.findw_cpp(ver_ssn_sources, 'TU' , ', ', 'E');

bureau_ssn_fseen_tu := if(bureau_ssn_tu_fseen_pos = 0, '       0', Models.Common.getw(ver_ssn_sources_first_seen, bureau_ssn_tu_fseen_pos, ','));

_bureau_ssn_fseen_tu := common.sas_date((string)(bureau_ssn_fseen_tu));

bureau_ssn_en_fseen_pos := Models.Common.findw_cpp(ver_ssn_sources, 'EN' , ', ', 'E');

bureau_ssn_fseen_en := if(bureau_ssn_en_fseen_pos = 0, '       0', Models.Common.getw(ver_ssn_sources_first_seen, bureau_ssn_en_fseen_pos, ','));

_bureau_ssn_fseen_en := common.sas_date((string)(bureau_ssn_fseen_en));

bureau_ssn_eq_fseen_pos := Models.Common.findw_cpp(ver_ssn_sources, 'EQ' , ', ', 'E');

bureau_ssn_fseen_eq := if(bureau_ssn_eq_fseen_pos = 0, '       0', Models.Common.getw(ver_ssn_sources_first_seen, bureau_ssn_eq_fseen_pos, ','));

_bureau_ssn_fseen_eq := common.sas_date((string)(bureau_ssn_fseen_eq));

_src_bureau_ssn_fseen := if(max(_bureau_ssn_fseen_tn, _bureau_ssn_fseen_ts, _bureau_ssn_fseen_tu, _bureau_ssn_fseen_en, _bureau_ssn_fseen_eq) = NULL, NULL,
							min(if(_bureau_ssn_fseen_tn = NULL, -NULL, _bureau_ssn_fseen_tn),
								if(_bureau_ssn_fseen_ts = NULL, -NULL, _bureau_ssn_fseen_ts),
								if(_bureau_ssn_fseen_tu = NULL, -NULL, _bureau_ssn_fseen_tu),
								if(_bureau_ssn_fseen_en = NULL, -NULL, _bureau_ssn_fseen_en),
								if(_bureau_ssn_fseen_eq = NULL, -NULL, _bureau_ssn_fseen_eq)));

iv_mos_src_bureau_ssn_fseen := map(
    not(truedid)                 => NULL,
    _src_bureau_ssn_fseen = NULL => -1,
                                    if ((sysdate - _src_bureau_ssn_fseen) / (365.25 / 12) >= 0, truncate((sysdate - _src_bureau_ssn_fseen) / (365.25 / 12)), roundup((sysdate - _src_bureau_ssn_fseen) / (365.25 / 12))));

iv_inp_own_prop_x_addr_naprop := map(
    not(add1_pop)            => '  ',
    property_owned_total > 0 => (string)(add1_naprop + 10),
								('0' + (string)add1_naprop)[-2..]);

iv_ssns_per_sfd_addr_c6 := map(
    not(add1_pop)    => NULL,
    iv_add_apt = '1' => -1,
                        ssns_per_addr_c6);

iv_inq_per_addr := if(not(add1_pop), NULL, inq_peraddr);

iv_liens_unrel_sc_ct := if(not(truedid), NULL, liens_unrel_SC_ct);

sum_dols := if(max((Real)pb_offline_dollars, (Real)pb_online_dollars, (Real)pb_retail_dollars) = NULL, NULL,
                sum(if((Real)pb_offline_dollars = NULL, 0, (Real)pb_offline_dollars), if((Real)pb_online_dollars = NULL, 0, (Real)pb_online_dollars), if((Real)pb_retail_dollars = NULL, 0, (Real)pb_retail_dollars)));

pct_offline_dols := if(sum_dols > 0, (Real)pb_offline_dollars / sum_dols, -1);

pct_retail_dols := if(sum_dols > 0, (Real)pb_retail_dollars / sum_dols, -1);

pct_online_dols := if(sum_dols > 0, (Real)pb_online_dollars / sum_dols, -1);

iv_pb_profile := map(
    not(truedid)              => '                 ',
    pb_number_of_sources = '' => '0 No Purch Data  ',
    pct_offline_dols > .50    => '1 Offline Shopper',
    pct_online_dols > .50     => '2 Online Shopper ',
    pct_retail_dols > .50     => '3 Retail Shopper ',
                                 '4 Other');

iv_input_addr_not_most_recent := if(not(truedid), '', (string)((Integer)((boolean)rc_input_addr_not_most_recent)));

iv_criminal_count := if(not(truedid), NULL, criminal_count);

iv_prof_license_category := map(
    not(truedid)               => '  ',
    prof_license_category = '' => '-1',
                                  prof_license_category);

nf_fp_assoccredbureaucount := if(not(truedid), NULL, (Integer)fp_assoccredbureaucount);

s0_subscore0 := map(
    NULL < iv_inq_highriskcredit_recency AND iv_inq_highriskcredit_recency < 1 => 0.250075,
    1 <= iv_inq_highriskcredit_recency AND iv_inq_highriskcredit_recency < 12  => -0.833106,
    12 <= iv_inq_highriskcredit_recency AND iv_inq_highriskcredit_recency < 99 => -0.554484,
    99 <= iv_inq_highriskcredit_recency                                        => -0.029493,
                                                                                  0.000000);

s0_subscore1 := map(
    (iv_pb_order_freq in [' '])                                                    => 0.000000,
    (iv_pb_order_freq in ['0 No Purch Data'])                                      => -0.393339,
    (iv_pb_order_freq in ['1 Cant Calculate'])                                     => 0.133761,
    (iv_pb_order_freq in ['2 Weekly', '3 Monthly', '4 Semi-monthly'])              => 0.136341,
    (iv_pb_order_freq in ['5 Quarterly', '6 Semi-yearly', '7 Yearly', '8 Rarely']) => 0.535884,
                                                                                      0.000000);

s0_subscore2 := map(
    NULL < iv_inq_per_ssn AND iv_inq_per_ssn < 1 => 0.265103,
    1 <= iv_inq_per_ssn AND iv_inq_per_ssn < 2   => 0.095647,
    2 <= iv_inq_per_ssn AND iv_inq_per_ssn < 5   => -0.003209,
    5 <= iv_inq_per_ssn AND iv_inq_per_ssn < 13  => -0.724015,
    13 <= iv_inq_per_ssn                         => -1.111468,
                                                    0.000000);

s0_subscore3 := map(
    NULL < iv_inq_communications_recency AND iv_inq_communications_recency < 1 => 0.197126,
    1 <= iv_inq_communications_recency AND iv_inq_communications_recency < 6   => -0.818632,
    6 <= iv_inq_communications_recency AND iv_inq_communications_recency < 24  => -0.590979,
    24 <= iv_inq_communications_recency                                        => -0.367729,
                                                                                  -0.000000);

s0_subscore4 := map(
    NULL < iv_sr001_m_bureau_adl_fs AND iv_sr001_m_bureau_adl_fs < 1   => -0.000000,
    1 <= iv_sr001_m_bureau_adl_fs AND iv_sr001_m_bureau_adl_fs < 18    => -0.435191,
    18 <= iv_sr001_m_bureau_adl_fs AND iv_sr001_m_bureau_adl_fs < 292  => -0.083875,
    292 <= iv_sr001_m_bureau_adl_fs AND iv_sr001_m_bureau_adl_fs < 340 => 0.129303,
    340 <= iv_sr001_m_bureau_adl_fs                                    => 0.687478,
                                                                          -0.000000);

s0_subscore5 := map(
    (iv_nap_phn_ver_x_inf_phn_ver in [' '])                               => -0.000000,
    (iv_nap_phn_ver_x_inf_phn_ver in ['-1'])                              => -0.000000,
    (iv_nap_phn_ver_x_inf_phn_ver in ['0-1', '1-0', '1-1', '2-0', '2-1']) => -0.224114,
    (iv_nap_phn_ver_x_inf_phn_ver in ['0-0'])                             => -0.099636,
    (iv_nap_phn_ver_x_inf_phn_ver in ['1-3', '2-3', '3-1', '3-3'])        => 0.167664,
    (iv_nap_phn_ver_x_inf_phn_ver in ['0-3'])                             => 0.396461,
    (iv_nap_phn_ver_x_inf_phn_ver in ['3-0'])                             => 0.476172,
                                                                             -0.000000);

s0_subscore6 := map(
    (iv_nas_summary in [' '])                                      => 0.000000,
    (iv_nas_summary in ['01'])                                     => -0.879377,
    (iv_nas_summary in ['00', '02', '03', '04', '06', '07', '08']) => -0.398387,
    (iv_nas_summary in ['09', '10', '11'])                         => 0.054922,
    (iv_nas_summary in ['12'])                                     => 0.197444,
                                                                      0.000000);

s0_subscore7 := map(
    NULL < iv_eviction_count AND iv_eviction_count < 1 => 0.103721,
    1 <= iv_eviction_count                             => -0.705374,
                                                          0.000000);

s0_subscore8 := map(
	(String)c_white_col = ''                               => -0.000000,
    NULL < (Real)c_white_col AND (Real)c_white_col < 0     => -0.000000,
    0 <= (Real)c_white_col AND (Real)c_white_col < 22.1    => -0.490092,
    22.1 <= (Real)c_white_col AND (Real)c_white_col < 28.8 => -0.191372,
    28.8 <= (Real)c_white_col AND (Real)c_white_col < 36.1 => -0.058582,
    36.1 <= (Real)c_white_col AND (Real)c_white_col < 45.9 => -0.005459,
    45.9 <= (Real)c_white_col                              => 0.333910,
                                                              -0.000000);

s0_subscore9 := map(
    NULL < iv_inq_collection_recency AND iv_inq_collection_recency < 1 => 0.236163,
    1 <= iv_inq_collection_recency AND iv_inq_collection_recency < 6   => -0.353236,
    6 <= iv_inq_collection_recency AND iv_inq_collection_recency < 99  => -0.290092,
    99 <= iv_inq_collection_recency                                    => -0.069704,
                                                                          -0.000000);

s0_subscore10 := map(
    (iv_criminal_x_felony in [' '])                                      => -0.000000,
    (iv_criminal_x_felony in ['0-0'])                                    => 0.085873,
    (iv_criminal_x_felony in ['1-0', '2-0', '3-0'])                      => -0.146963,
    (iv_criminal_x_felony in ['1-1', '2-1', '2-2', '3-1', '3-2', '3-3']) => -1.339768,
                                                                            -0.000000);

s0_subscore11 := map(
    NULL < iv_pl002_avg_mo_per_addr AND iv_pl002_avg_mo_per_addr < 1 => -0.690454,
    1 <= iv_pl002_avg_mo_per_addr AND iv_pl002_avg_mo_per_addr < 11  => -0.380960,
    11 <= iv_pl002_avg_mo_per_addr AND iv_pl002_avg_mo_per_addr < 14 => -0.113310,
    14 <= iv_pl002_avg_mo_per_addr AND iv_pl002_avg_mo_per_addr < 18 => 0.070547,
    18 <= iv_pl002_avg_mo_per_addr AND iv_pl002_avg_mo_per_addr < 25 => 0.071630,
    25 <= iv_pl002_avg_mo_per_addr AND iv_pl002_avg_mo_per_addr < 45 => 0.163814,
    45 <= iv_pl002_avg_mo_per_addr                                   => 0.167702,
                                                                        -0.000000);

s0_subscore12 := map(
    (iv_bst_own_prop_x_addr_naprop in [' '])                          => -0.000000,
    (iv_bst_own_prop_x_addr_naprop in ['01'])                         => -0.205909,
    (iv_bst_own_prop_x_addr_naprop in ['00', '02'])                   => -0.034913,
    (iv_bst_own_prop_x_addr_naprop in ['03'])                         => 0.058065,
    (iv_bst_own_prop_x_addr_naprop in ['04', '10', '11', '12', '13']) => 0.355503,
    (iv_bst_own_prop_x_addr_naprop in ['14'])                         => 0.417860,
                                                                         -0.000000);

s0_subscore13 := map(
    (iv_vp091_phnzip_mismatch in [' ']) => -0.000000,
    (iv_vp091_phnzip_mismatch in ['0']) => 0.051226,
    (iv_vp091_phnzip_mismatch in ['1']) => -0.861907,
                                           -0.000000);

s0_subscore14 := map(
    NULL < iv_ds001_impulse_count AND iv_ds001_impulse_count < 1 => 0.062082,
    1 <= iv_ds001_impulse_count                                  => -0.745890,
                                                                    0.000000);

s0_subscore15 := map(
    (iv_va002_add_invalid in [' ']) => -0.000000,
    (iv_va002_add_invalid in ['0']) => 0.064427,
    (iv_va002_add_invalid in ['1']) => -0.593539,
                                       -0.000000);

s0_subscore16 := map(
    NULL < iv_ssns_per_addr_c6 AND iv_ssns_per_addr_c6 < 1 => 0.128139,
    1 <= iv_ssns_per_addr_c6 AND iv_ssns_per_addr_c6 < 2   => -0.203238,
    2 <= iv_ssns_per_addr_c6                               => -0.322374,
                                                              0.000000);

s0_subscore17 := map(
    (iv_ed001_college_ind in [' ']) => -0.000000,
    (iv_ed001_college_ind in ['0']) => -0.053055,
    (iv_ed001_college_ind in ['1']) => 0.480676,
                                       -0.000000);

s0_subscore18 := map(
    NULL < nf_fp_srchaddrsrchcountmo AND nf_fp_srchaddrsrchcountmo < 0 => -0.000000,
    0 <= nf_fp_srchaddrsrchcountmo AND nf_fp_srchaddrsrchcountmo < 1   => 0.068592,
    1 <= nf_fp_srchaddrsrchcountmo AND nf_fp_srchaddrsrchcountmo < 2   => -0.037409,
    2 <= nf_fp_srchaddrsrchcountmo                                     => -0.403696,
                                                                          -0.000000);

s0_subscore19 := map(
    (iv_vs002_ssn_prior_dob in [' ']) => 0.000000,
    (iv_vs002_ssn_prior_dob in ['0']) => 0.025854,
    (iv_vs002_ssn_prior_dob in ['1']) => -0.804293,
                                         0.000000);

s0_rawscore := s0_subscore0 +
    s0_subscore1 +
    s0_subscore2 +
    s0_subscore3 +
    s0_subscore4 +
    s0_subscore5 +
    s0_subscore6 +
    s0_subscore7 +
    s0_subscore8 +
    s0_subscore9 +
    s0_subscore10 +
    s0_subscore11 +
    s0_subscore12 +
    s0_subscore13 +
    s0_subscore14 +
    s0_subscore15 +
    s0_subscore16 +
    s0_subscore17 +
    s0_subscore18 +
    s0_subscore19;

s0_lnoddsscore := s0_rawscore + 3.227101;

s0_probscore := exp(s0_lnoddsscore) / (1 + exp(s0_lnoddsscore));

s1_subscore0 := map(
    NULL < iv_inq_highriskcredit_recency AND iv_inq_highriskcredit_recency < 1 => 0.544516,
    1 <= iv_inq_highriskcredit_recency AND iv_inq_highriskcredit_recency < 3   => -0.653050,
    3 <= iv_inq_highriskcredit_recency AND iv_inq_highriskcredit_recency < 99  => -0.467911,
    99 <= iv_inq_highriskcredit_recency                                        => -0.121090,
                                                                                  -0.000000);

s1_subscore1 := map(
    NULL < iv_mos_src_bureau_ssn_fseen AND iv_mos_src_bureau_ssn_fseen < 1   => -1.193502,
    1 <= iv_mos_src_bureau_ssn_fseen AND iv_mos_src_bureau_ssn_fseen < 102   => -0.482432,
    102 <= iv_mos_src_bureau_ssn_fseen AND iv_mos_src_bureau_ssn_fseen < 164 => -0.197830,
    164 <= iv_mos_src_bureau_ssn_fseen AND iv_mos_src_bureau_ssn_fseen < 210 => -0.173324,
    210 <= iv_mos_src_bureau_ssn_fseen AND iv_mos_src_bureau_ssn_fseen < 299 => -0.008308,
    299 <= iv_mos_src_bureau_ssn_fseen AND iv_mos_src_bureau_ssn_fseen < 329 => 0.258023,
    329 <= iv_mos_src_bureau_ssn_fseen AND iv_mos_src_bureau_ssn_fseen < 367 => 0.327588,
    367 <= iv_mos_src_bureau_ssn_fseen                                       => 0.582226,
                                                                                0.000000);

s1_subscore2 := map(
    NULL < iv_inq_communications_recency AND iv_inq_communications_recency < 1 => 0.228465,
    1 <= iv_inq_communications_recency AND iv_inq_communications_recency < 6   => -0.609395,
    6 <= iv_inq_communications_recency AND iv_inq_communications_recency < 99  => -0.477241,
    99 <= iv_inq_communications_recency                                        => -0.081892,
                                                                                  -0.000000);

s1_subscore3 := map(
    NULL < iv_inq_per_ssn AND iv_inq_per_ssn < 1 => 0.324721,
    1 <= iv_inq_per_ssn AND iv_inq_per_ssn < 4   => 0.078409,
    4 <= iv_inq_per_ssn AND iv_inq_per_ssn < 9   => -0.311303,
    9 <= iv_inq_per_ssn                          => -0.447740,
                                                    -0.000000);

s1_subscore4 := map(
    NULL < iv_inq_per_addr AND iv_inq_per_addr < 1 => 0.364274,
    1 <= iv_inq_per_addr AND iv_inq_per_addr < 4   => 0.081573,
    4 <= iv_inq_per_addr AND iv_inq_per_addr < 10  => -0.108190,
    10 <= iv_inq_per_addr                          => -0.399205,
                                                      -0.000000);

s1_subscore5 := map(
    NULL < iv_inq_collection_recency AND iv_inq_collection_recency < 1 => 0.427117,
    1 <= iv_inq_collection_recency AND iv_inq_collection_recency < 6   => -0.485984,
    6 <= iv_inq_collection_recency AND iv_inq_collection_recency < 99  => -0.158104,
    99 <= iv_inq_collection_recency                                    => 0.157007,
                                                                          -0.000000);

s1_subscore6 := map(
    (iv_criminal_x_felony in ['0-0'])                      => 0.094843,
    (iv_criminal_x_felony in ['1-0', '2-0'])               => 0.131660,
    (iv_criminal_x_felony in ['1-1', '2-1', '3-0'])        => -0.299196,
    (iv_criminal_x_felony in ['2-2', '3-1', '3-2', '3-3']) => -0.840771,
                                                              -0.000000);

s1_subscore7 := map(
    (iv_pb_profile in ['0 No Purch Data'])                       => -0.418954,
    (iv_pb_profile in ['1 Offline Shopper', '2 Online Shopper']) => 0.095489,
    (iv_pb_profile in ['3 Retail Shopper', '4 Other'])           => 0.188501,
                                                                    -0.000000);

s1_subscore8 := map(
    NULL < iv_de001_eviction_recency AND iv_de001_eviction_recency < 1 => 0.125572,
    1 <= iv_de001_eviction_recency AND iv_de001_eviction_recency < 25  => -0.645176,
    25 <= iv_de001_eviction_recency AND iv_de001_eviction_recency < 98 => -0.204047,
    98 <= iv_de001_eviction_recency AND iv_de001_eviction_recency < 99 => -0.168939,
    99 <= iv_de001_eviction_recency                                    => 0.132081,
                                                                          -0.000000);

s1_subscore9 := map(
    NULL < iv_ds001_impulse_count AND iv_ds001_impulse_count < 1 => 0.122232,
    1 <= iv_ds001_impulse_count AND iv_ds001_impulse_count < 2   => -0.265907,
    2 <= iv_ds001_impulse_count AND iv_ds001_impulse_count < 3   => -0.435272,
    3 <= iv_ds001_impulse_count                                  => -0.612725,
                                                                    0.000000);

s1_subscore10 := map(
    (iv_inp_own_prop_x_addr_naprop in ['01'])             => -0.148872,
    (iv_inp_own_prop_x_addr_naprop in ['00', '02', '03']) => -0.119195,
    (iv_inp_own_prop_x_addr_naprop in ['10', '11', '12']) => 0.100417,
    (iv_inp_own_prop_x_addr_naprop in ['04', '13', '14']) => 0.362958,
                                                             0.000000);

s1_subscore11 := map(
    (iv_nap_phn_ver_x_inf_phn_ver in ['-1'])                                            => -0.000000,
    (iv_nap_phn_ver_x_inf_phn_ver in ['0-0'])                                           => -0.210896,
    (iv_nap_phn_ver_x_inf_phn_ver in ['0-1', '1-0', '1-1', '1-3', '2-0', '2-1', '3-1']) => -0.113860,
    (iv_nap_phn_ver_x_inf_phn_ver in ['0-3', '2-3', '3-0', '3-3'])                      => 0.180380,
                                                                                           -0.000000);

s1_subscore12 := map(
    NULL < iv_liens_unrel_sc_ct AND iv_liens_unrel_sc_ct < 1 => 0.084398,
    1 <= iv_liens_unrel_sc_ct AND iv_liens_unrel_sc_ct < 2   => -0.207665,
    2 <= iv_liens_unrel_sc_ct                                => -0.313609,
                                                                0.000000);

s1_subscore13 := map(
    (iv_db001_bankruptcy in ['2 - BK Dismissed'])  => -0.321515,
    (iv_db001_bankruptcy in ['0 - No BK'])         => -0.060983,
    (iv_db001_bankruptcy in ['3 - BK Other'])      => 0.062525,
    (iv_db001_bankruptcy in ['1 - BK Discharged']) => 0.223509,
                                                      0.000000);

s1_subscore14 := map(
    NULL < iv_ssns_per_sfd_addr_c6 AND iv_ssns_per_sfd_addr_c6 < 0 => 0.078327,
    0 <= iv_ssns_per_sfd_addr_c6 AND iv_ssns_per_sfd_addr_c6 < 1   => 0.075123,
    1 <= iv_ssns_per_sfd_addr_c6 AND iv_ssns_per_sfd_addr_c6 < 2   => -0.016603,
    2 <= iv_ssns_per_sfd_addr_c6 AND iv_ssns_per_sfd_addr_c6 < 3   => -0.178824,
    3 <= iv_ssns_per_sfd_addr_c6 AND iv_ssns_per_sfd_addr_c6 < 4   => -0.298830,
    4 <= iv_ssns_per_sfd_addr_c6                                   => -0.751915,
                                                                      -0.000000);

s1_subscore15 := map(
    (iv_ed001_college_ind in ['0']) => -0.046062,
    (iv_ed001_college_ind in ['1']) => 0.367676,
                                       0.000000);

s1_rawscore := s1_subscore0 +
    s1_subscore1 +
    s1_subscore2 +
    s1_subscore3 +
    s1_subscore4 +
    s1_subscore5 +
    s1_subscore6 +
    s1_subscore7 +
    s1_subscore8 +
    s1_subscore9 +
    s1_subscore10 +
    s1_subscore11 +
    s1_subscore12 +
    s1_subscore13 +
    s1_subscore14 +
    s1_subscore15;

s1_lnoddsscore := s1_rawscore + 2.931012;

s1_probscore := exp(s1_lnoddsscore) / (1 + exp(s1_lnoddsscore));

s2_subscore0 := map(
    NULL < iv_mos_src_bureau_ssn_fseen AND iv_mos_src_bureau_ssn_fseen < 1   => -1.314240,
    1 <= iv_mos_src_bureau_ssn_fseen AND iv_mos_src_bureau_ssn_fseen < 64    => -1.005156,
    64 <= iv_mos_src_bureau_ssn_fseen AND iv_mos_src_bureau_ssn_fseen < 96   => -0.554249,
    96 <= iv_mos_src_bureau_ssn_fseen AND iv_mos_src_bureau_ssn_fseen < 193  => -0.062378,
    193 <= iv_mos_src_bureau_ssn_fseen AND iv_mos_src_bureau_ssn_fseen < 259 => -0.058139,
    259 <= iv_mos_src_bureau_ssn_fseen AND iv_mos_src_bureau_ssn_fseen < 328 => 0.451615,
    328 <= iv_mos_src_bureau_ssn_fseen AND iv_mos_src_bureau_ssn_fseen < 364 => 0.703742,
    364 <= iv_mos_src_bureau_ssn_fseen                                       => 0.801509,
                                                                                0.000000);

s2_subscore1 := map(
    NULL < iv_inq_highriskcredit_recency AND iv_inq_highriskcredit_recency < 1 => 0.312958,
    1 <= iv_inq_highriskcredit_recency AND iv_inq_highriskcredit_recency < 3   => -1.497227,
    3 <= iv_inq_highriskcredit_recency AND iv_inq_highriskcredit_recency < 12  => -1.126647,
    12 <= iv_inq_highriskcredit_recency                                        => -0.651964,
                                                                                  -0.000000);

s2_subscore2 := map(
    NULL < iv_inq_collection_recency AND iv_inq_collection_recency < 1 => 0.320530,
    1 <= iv_inq_collection_recency AND iv_inq_collection_recency < 24  => -0.587121,
    24 <= iv_inq_collection_recency AND iv_inq_collection_recency < 99 => -0.413167,
    99 <= iv_inq_collection_recency                                    => -0.068720,
                                                                          0.000000);

s2_subscore3 := map(
    (iv_pb_order_freq in ['0 No Purch Data'])                                                                                 => -0.413479,
    (iv_pb_order_freq in ['1 Cant Calculate'])                                                                                => 0.129689,
    (iv_pb_order_freq in ['2 Weekly', '3 Monthly', '4 Semi-monthly', '5 Quarterly', '6 Semi-yearly', '7 Yearly', '8 Rarely']) => 0.162470,
                                                                                                                                 0.000000);

s2_subscore4 := map(
    NULL < iv_inq_communications_recency AND iv_inq_communications_recency < 1 => 0.130338,
    1 <= iv_inq_communications_recency AND iv_inq_communications_recency < 24  => -0.736614,
    24 <= iv_inq_communications_recency AND iv_inq_communications_recency < 99 => -0.456141,
    99 <= iv_inq_communications_recency                                        => -0.234012,
                                                                                  0.000000);

s2_subscore5 := map(
    (iv_inp_own_prop_x_addr_naprop in [' '])                          => 0.000000,
    (iv_inp_own_prop_x_addr_naprop in ['00', '01', '02', '03'])       => -0.174461,
    (iv_inp_own_prop_x_addr_naprop in ['04', '10', '11', '12', '13']) => -0.047154,
    (iv_inp_own_prop_x_addr_naprop in ['14'])                         => 0.318023,
                                                                         0.000000);

s2_subscore6 := map(
    NULL < iv_inq_per_addr AND iv_inq_per_addr < 1 => 0.252632,
    1 <= iv_inq_per_addr AND iv_inq_per_addr < 2   => 0.026533,
    2 <= iv_inq_per_addr AND iv_inq_per_addr < 4   => -0.081316,
    4 <= iv_inq_per_addr AND iv_inq_per_addr < 9   => -0.085122,
    9 <= iv_inq_per_addr                           => -0.459906,
                                                      0.000000);

s2_subscore7 := map(
    NULL < iv_inq_per_ssn AND iv_inq_per_ssn < 1 => 0.091524,
    1 <= iv_inq_per_ssn AND iv_inq_per_ssn < 3   => 0.172049,
    3 <= iv_inq_per_ssn AND iv_inq_per_ssn < 6   => -0.172476,
    6 <= iv_inq_per_ssn AND iv_inq_per_ssn < 13  => -0.683136,
    13 <= iv_inq_per_ssn                         => -0.816022,
                                                    0.000000);

s2_subscore8 := map(
    NULL < iv_criminal_count AND iv_criminal_count < 1 => 0.097625,
    1 <= iv_criminal_count AND iv_criminal_count < 2   => -0.300617,
    2 <= iv_criminal_count AND iv_criminal_count < 3   => -0.321844,
    3 <= iv_criminal_count AND iv_criminal_count < 5   => -0.548900,
    5 <= iv_criminal_count                             => -0.572469,
                                                          0.000000);

s2_subscore9 := map(
    NULL < nf_fp_assoccredbureaucount AND nf_fp_assoccredbureaucount < 1 => 0.155746,
    1 <= nf_fp_assoccredbureaucount AND nf_fp_assoccredbureaucount < 2   => -0.034677,
    2 <= nf_fp_assoccredbureaucount AND nf_fp_assoccredbureaucount < 3   => -0.272232,
    3 <= nf_fp_assoccredbureaucount AND nf_fp_assoccredbureaucount < 4   => -0.280236,
    4 <= nf_fp_assoccredbureaucount                                      => -0.416340,
                                                                            -0.000000);

s2_subscore10 := map(
    (iv_nap_phn_ver_x_inf_phn_ver in ['-1'])                                     => -0.000000,
    (iv_nap_phn_ver_x_inf_phn_ver in ['0-0', '0-1', '1-0', '1-1', '2-0', '2-1']) => -0.166746,
    (iv_nap_phn_ver_x_inf_phn_ver in ['0-3', '1-3', '2-3', '3-1'])               => 0.057444,
    (iv_nap_phn_ver_x_inf_phn_ver in ['3-3'])                                    => 0.203856,
    (iv_nap_phn_ver_x_inf_phn_ver in ['3-0'])                                    => 0.332002,
                                                                                    -0.000000);

s2_subscore11 := map(
	(String)c_fammar_p = ''                            => -0.000000,
    NULL < (Real)c_fammar_p AND (Real)c_fammar_p < 0   => -0.000000,
    0 <= (Real)c_fammar_p AND (Real)c_fammar_p < 45.5  => -0.508960,
    45.5 <= (Real)c_fammar_p AND (Real)c_fammar_p < 62 => -0.185955,
    62 <= (Real)c_fammar_p AND (Real)c_fammar_p < 76.5 => -0.043238,
    76.5 <= (Real)c_fammar_p                           => 0.120804,
                                                          -0.000000);

s2_subscore12 := map(
    (iv_prof_license_category in ['-1'])          => -0.042149,
    (iv_prof_license_category in ['0', '1', '2']) => 0.190105,
    (iv_prof_license_category in ['3', '4', '5']) => 0.626337,
                                                     -0.000000);

s2_subscore13 := map(
    (iv_ed001_college_ind in ['0']) => -0.052890,
    (iv_ed001_college_ind in ['1']) => 0.272957,
                                       0.000000);

s2_subscore14 := map(
    (iv_input_addr_not_most_recent in ['0']) => 0.054324,
    (iv_input_addr_not_most_recent in ['1']) => -0.136897,
                                                0.000000);

s2_rawscore := s2_subscore0 +
    s2_subscore1 +
    s2_subscore2 +
    s2_subscore3 +
    s2_subscore4 +
    s2_subscore5 +
    s2_subscore6 +
    s2_subscore7 +
    s2_subscore8 +
    s2_subscore9 +
    s2_subscore10 +
    s2_subscore11 +
    s2_subscore12 +
    s2_subscore13 +
    s2_subscore14;

s2_lnoddsscore := s2_rawscore + 4.725886;

s2_probscore := exp(s2_lnoddsscore) / (1 + exp(s2_lnoddsscore));

probscore := map(
    target_fp_segment = '0 ID Prob' => s0_probscore,
    target_fp_segment = '1 Derog'   => s1_probscore,
                                       s2_probscore);

base := 680;

pts := 45;

odds := (1 - .0155) / .0155;

// previous:
//   fp1403_1_0_4 := min(if(max(round(pts * (ln(probscore / (1 - probscore)) - ln(odds)) / ln(2) + base), 301) = NULL, -NULL, max(round(pts * (ln(probscore / (1 - probscore)) - ln(odds)) / ln(2) + base), 301)), 999);

cust_fp_score_3_4 := min(if(max(round(pts * (ln(probScore / (1 - probScore)) - ln(odds)) / ln(2) + base), 301) = NULL, -NULL, max(round(pts * (ln(probScore / (1 - probScore)) - ln(odds)) / ln(2) + base), 301)), 999);

cust_fp_score_3_3 := if(iv_VS002_SSN_Prior_DoB = '1', min(if(cust_fp_score_3_4 = NULL, -NULL, cust_fp_score_3_4), 300), cust_fp_score_3_4);

cust_fp_score_3_2 := if(iv_VS003_SSN_Invalid = '1', min(if(cust_fp_score_3_3 = NULL, -NULL, cust_fp_score_3_3), 300), cust_fp_score_3_3);

cust_fp_score_3_1 := if(iv_VS001_SSN_Deceased = '1', min(if(cust_fp_score_3_2 = NULL, -NULL, cust_fp_score_3_2), 300), cust_fp_score_3_2);

cust_fp_score_3 := if(nas_summary = 1, min(if(cust_fp_score_3_1 = NULL, -NULL, cust_fp_score_3_1), 300), cust_fp_score_3_1);

cust_fp_score_2 := map(
    cust_fp_score_3 = 300  => '00',
    cust_fp_score_3 <= 305 => '01',
    cust_fp_score_3 <= 310 => '02',
    cust_fp_score_3 <= 315 => '03',
    cust_fp_score_3 <= 320 => '04',
    cust_fp_score_3 <= 325 => '05',
    cust_fp_score_3 <= 330 => '06',
    cust_fp_score_3 <= 335 => '07',
    cust_fp_score_3 <= 340 => '08',
    cust_fp_score_3 <= 345 => '09',
    cust_fp_score_3 <= 350 => '11',
    cust_fp_score_3 <= 355 => '12',
    cust_fp_score_3 <= 360 => '13',
    cust_fp_score_3 <= 365 => '14',
    cust_fp_score_3 <= 370 => '15',
    cust_fp_score_3 <= 375 => '16',
    cust_fp_score_3 <= 380 => '17',
    cust_fp_score_3 <= 385 => '18',
    cust_fp_score_3 <= 390 => '19',
    cust_fp_score_3 <= 395 => '21',
    cust_fp_score_3 <= 400 => '22',
    cust_fp_score_3 <= 405 => '23',
    cust_fp_score_3 <= 410 => '24',
    cust_fp_score_3 <= 415 => '25',
    cust_fp_score_3 <= 420 => '26',
    cust_fp_score_3 <= 425 => '27',
    cust_fp_score_3 <= 430 => '28',
    cust_fp_score_3 <= 435 => '29',
    cust_fp_score_3 <= 440 => '31',
    cust_fp_score_3 <= 445 => '32',
    cust_fp_score_3 <= 450 => '33',
    cust_fp_score_3 <= 455 => '34',
    cust_fp_score_3 <= 460 => '35',
    cust_fp_score_3 <= 465 => '36',
    cust_fp_score_3 <= 470 => '37',
    cust_fp_score_3 <= 475 => '38',
    cust_fp_score_3 <= 480 => '39',
    cust_fp_score_3 <= 485 => '41',
    cust_fp_score_3 <= 490 => '42',
    cust_fp_score_3 <= 495 => '43',
    cust_fp_score_3 <= 500 => '44',
    cust_fp_score_3 <= 505 => '45',
    cust_fp_score_3 <= 510 => '46',
    cust_fp_score_3 <= 515 => '47',
    cust_fp_score_3 <= 520 => '48',
    cust_fp_score_3 <= 525 => '49',
    cust_fp_score_3 <= 530 => '51',
    cust_fp_score_3 <= 535 => '52',
    cust_fp_score_3 <= 540 => '53',
    cust_fp_score_3 <= 545 => '54',
    cust_fp_score_3 <= 550 => '55',
    cust_fp_score_3 <= 555 => '56',
    cust_fp_score_3 <= 560 => '57',
    cust_fp_score_3 <= 565 => '58',
    cust_fp_score_3 <= 570 => '59',
    cust_fp_score_3 <= 575 => '60',
    cust_fp_score_3 <= 580 => '61',
    cust_fp_score_3 <= 585 => '62',
    cust_fp_score_3 <= 590 => '63',
    cust_fp_score_3 <= 595 => '64',
    cust_fp_score_3 <= 600 => '65',
    cust_fp_score_3 <= 605 => '66',
    cust_fp_score_3 <= 610 => '67',
    cust_fp_score_3 <= 615 => '68',
    cust_fp_score_3 <= 620 => '69',
    cust_fp_score_3 <= 625 => '70',
    cust_fp_score_3 <= 630 => '71',
    cust_fp_score_3 <= 635 => '72',
    cust_fp_score_3 <= 640 => '73',
    cust_fp_score_3 <= 645 => '74',
    cust_fp_score_3 <= 650 => '75',
    cust_fp_score_3 <= 655 => '76',
    cust_fp_score_3 <= 660 => '77',
    cust_fp_score_3 <= 665 => '78',
    cust_fp_score_3 <= 670 => '79',
    cust_fp_score_3 <= 675 => '80',
    cust_fp_score_3 <= 680 => '81',
    cust_fp_score_3 <= 685 => '82',
    cust_fp_score_3 <= 690 => '83',
    cust_fp_score_3 <= 695 => '84',
    cust_fp_score_3 <= 700 => '85',
    cust_fp_score_3 <= 705 => '86',
    cust_fp_score_3 <= 710 => '87',
    cust_fp_score_3 <= 715 => '88',
    cust_fp_score_3 <= 720 => '89',
    cust_fp_score_3 <= 725 => '90',
    cust_fp_score_3 <= 730 => '91',
    cust_fp_score_3 <= 735 => '92',
    cust_fp_score_3 <= 740 => '93',
    cust_fp_score_3 <= 745 => '94',
    cust_fp_score_3 <= 750 => '95',
    cust_fp_score_3 <= 800 => '96',
    cust_fp_score_3 <= 850 => '97',
    cust_fp_score_3 <= 900 => '98',
                              '99');

np31_cvi := le.np31_cvi_score;

fp1403_1_0 := Intformat((Integer)(trim((String)np31_cvi[1..1], LEFT, RIGHT) + trim(cust_fp_score_2, LEFT, RIGHT)), 3, 1);

#if(FP_DEBUG)
		/* Model Input Variables */
	self.clam                            := le;
	self.sysdate                          := sysdate;
	self.ver_src_ds                       := ver_src_ds;
	self.ver_src_eq                       := ver_src_eq;
	self.ver_src_en                       := ver_src_en;
	self.ver_src_tn                       := ver_src_tn;
	self.ver_src_tu                       := ver_src_tu;
	self.ver_src_cnt                      := ver_src_cnt;
	self.credit_source_cnt                := credit_source_cnt;
	self.bureauonly2                      := bureauonly2;
	self._derog                           := _derog;
	self.target_fp_segment                := target_fp_segment;
	self.iv_vs002_ssn_prior_dob           := iv_vs002_ssn_prior_dob;
	self.iv_vs003_ssn_invalid             := iv_vs003_ssn_invalid;
	self.iv_vs001_ssn_deceased            := iv_vs001_ssn_deceased;
	self.iv_vp091_phnzip_mismatch         := iv_vp091_phnzip_mismatch;
	self.iv_va002_add_invalid             := iv_va002_add_invalid;
	self.email_src_im                     := email_src_im;
	self.iv_ds001_impulse_count           := iv_ds001_impulse_count;
	self.bureau_adl_tn_fseen_pos          := bureau_adl_tn_fseen_pos;
	self.bureau_adl_fseen_tn              := bureau_adl_fseen_tn;
	self._bureau_adl_fseen_tn             := _bureau_adl_fseen_tn;
	self.bureau_adl_ts_fseen_pos          := bureau_adl_ts_fseen_pos;
	self.bureau_adl_fseen_ts              := bureau_adl_fseen_ts;
	self._bureau_adl_fseen_ts             := _bureau_adl_fseen_ts;
	self.bureau_adl_tu_fseen_pos          := bureau_adl_tu_fseen_pos;
	self.bureau_adl_fseen_tu              := bureau_adl_fseen_tu;
	self._bureau_adl_fseen_tu             := _bureau_adl_fseen_tu;
	self.bureau_adl_en_fseen_pos          := bureau_adl_en_fseen_pos;
	self.bureau_adl_fseen_en              := bureau_adl_fseen_en;
	self._bureau_adl_fseen_en             := _bureau_adl_fseen_en;
	self.bureau_adl_eq_fseen_pos          := bureau_adl_eq_fseen_pos;
	self.bureau_adl_fseen_eq              := bureau_adl_fseen_eq;
	self._bureau_adl_fseen_eq             := _bureau_adl_fseen_eq;
	self._src_bureau_adl_fseen            := _src_bureau_adl_fseen;
	self.iv_sr001_m_bureau_adl_fs         := iv_sr001_m_bureau_adl_fs;
	self.iv_pl002_avg_mo_per_addr         := iv_pl002_avg_mo_per_addr;
	self.iv_ed001_college_ind             := iv_ed001_college_ind;
	self.iv_nas_summary                   := iv_nas_summary;
	self.iv_bst_own_prop_x_addr_naprop    := iv_bst_own_prop_x_addr_naprop;
	self.iv_ssns_per_addr_c6              := iv_ssns_per_addr_c6;
	self.iv_inq_collection_recency        := iv_inq_collection_recency;
	self.iv_inq_highriskcredit_recency    := iv_inq_highriskcredit_recency;
	self.iv_inq_communications_recency    := iv_inq_communications_recency;
	self.iv_inq_per_ssn                   := iv_inq_per_ssn;
	self.ver_phn_inf                      := ver_phn_inf;
	self.ver_phn_nap                      := ver_phn_nap;
	self.inf_phn_ver_lvl                  := inf_phn_ver_lvl;
	self.nap_phn_ver_lvl                  := nap_phn_ver_lvl;
	self.iv_nap_phn_ver_x_inf_phn_ver     := iv_nap_phn_ver_x_inf_phn_ver;
	self.iv_eviction_count                := iv_eviction_count;
	self.iv_criminal_x_felony             := iv_criminal_x_felony;
	self.iv_pb_order_freq                 := iv_pb_order_freq;
	self.nf_fp_srchaddrsrchcountmo        := nf_fp_srchaddrsrchcountmo;
	self.iv_add_apt                       := iv_add_apt;
	self.iv_db001_bankruptcy              := iv_db001_bankruptcy;
	self.iv_de001_eviction_recency        := iv_de001_eviction_recency;
	self.bureau_ssn_tn_fseen_pos          := bureau_ssn_tn_fseen_pos;
	self.bureau_ssn_fseen_tn              := bureau_ssn_fseen_tn;
	self._bureau_ssn_fseen_tn             := _bureau_ssn_fseen_tn;
	self.bureau_ssn_ts_fseen_pos          := bureau_ssn_ts_fseen_pos;
	self.bureau_ssn_fseen_ts              := bureau_ssn_fseen_ts;
	self._bureau_ssn_fseen_ts             := _bureau_ssn_fseen_ts;
	self.bureau_ssn_tu_fseen_pos          := bureau_ssn_tu_fseen_pos;
	self.bureau_ssn_fseen_tu              := bureau_ssn_fseen_tu;
	self._bureau_ssn_fseen_tu             := _bureau_ssn_fseen_tu;
	self.bureau_ssn_en_fseen_pos          := bureau_ssn_en_fseen_pos;
	self.bureau_ssn_fseen_en              := bureau_ssn_fseen_en;
	self._bureau_ssn_fseen_en             := _bureau_ssn_fseen_en;
	self.bureau_ssn_eq_fseen_pos          := bureau_ssn_eq_fseen_pos;
	self.bureau_ssn_fseen_eq              := bureau_ssn_fseen_eq;
	self._bureau_ssn_fseen_eq             := _bureau_ssn_fseen_eq;
	self._src_bureau_ssn_fseen            := _src_bureau_ssn_fseen;
	self.iv_mos_src_bureau_ssn_fseen      := iv_mos_src_bureau_ssn_fseen;
	self.iv_inp_own_prop_x_addr_naprop    := iv_inp_own_prop_x_addr_naprop;
	self.iv_ssns_per_sfd_addr_c6          := iv_ssns_per_sfd_addr_c6;
	self.iv_inq_per_addr                  := iv_inq_per_addr;
	self.iv_liens_unrel_sc_ct             := iv_liens_unrel_sc_ct;
	self.sum_dols                         := sum_dols;
	self.pct_offline_dols                 := pct_offline_dols;
	self.pct_retail_dols                  := pct_retail_dols;
	self.pct_online_dols                  := pct_online_dols;
	self.iv_pb_profile                    := iv_pb_profile;
	self.iv_input_addr_not_most_recent    := iv_input_addr_not_most_recent;
	self.iv_criminal_count                := iv_criminal_count;
	self.iv_prof_license_category         := iv_prof_license_category;
	self.nf_fp_assoccredbureaucount       := nf_fp_assoccredbureaucount;
	self.s0_subscore0                     := s0_subscore0;
	self.s0_subscore1                     := s0_subscore1;
	self.s0_subscore2                     := s0_subscore2;
	self.s0_subscore3                     := s0_subscore3;
	self.s0_subscore4                     := s0_subscore4;
	self.s0_subscore5                     := s0_subscore5;
	self.s0_subscore6                     := s0_subscore6;
	self.s0_subscore7                     := s0_subscore7;
	self.s0_subscore8                     := s0_subscore8;
	self.s0_subscore9                     := s0_subscore9;
	self.s0_subscore10                    := s0_subscore10;
	self.s0_subscore11                    := s0_subscore11;
	self.s0_subscore12                    := s0_subscore12;
	self.s0_subscore13                    := s0_subscore13;
	self.s0_subscore14                    := s0_subscore14;
	self.s0_subscore15                    := s0_subscore15;
	self.s0_subscore16                    := s0_subscore16;
	self.s0_subscore17                    := s0_subscore17;
	self.s0_subscore18                    := s0_subscore18;
	self.s0_subscore19                    := s0_subscore19;
	self.s0_rawscore                      := s0_rawscore;
	self.s0_lnoddsscore                   := s0_lnoddsscore;
	self.s0_probscore                     := s0_probscore;
	self.s1_subscore0                     := s1_subscore0;
	self.s1_subscore1                     := s1_subscore1;
	self.s1_subscore2                     := s1_subscore2;
	self.s1_subscore3                     := s1_subscore3;
	self.s1_subscore4                     := s1_subscore4;
	self.s1_subscore5                     := s1_subscore5;
	self.s1_subscore6                     := s1_subscore6;
	self.s1_subscore7                     := s1_subscore7;
	self.s1_subscore8                     := s1_subscore8;
	self.s1_subscore9                     := s1_subscore9;
	self.s1_subscore10                    := s1_subscore10;
	self.s1_subscore11                    := s1_subscore11;
	self.s1_subscore12                    := s1_subscore12;
	self.s1_subscore13                    := s1_subscore13;
	self.s1_subscore14                    := s1_subscore14;
	self.s1_subscore15                    := s1_subscore15;
	self.s1_rawscore                      := s1_rawscore;
	self.s1_lnoddsscore                   := s1_lnoddsscore;
	self.s1_probscore                     := s1_probscore;
	self.s2_subscore0                     := s2_subscore0;
	self.s2_subscore1                     := s2_subscore1;
	self.s2_subscore2                     := s2_subscore2;
	self.s2_subscore3                     := s2_subscore3;
	self.s2_subscore4                     := s2_subscore4;
	self.s2_subscore5                     := s2_subscore5;
	self.s2_subscore6                     := s2_subscore6;
	self.s2_subscore7                     := s2_subscore7;
	self.s2_subscore8                     := s2_subscore8;
	self.s2_subscore9                     := s2_subscore9;
	self.s2_subscore10                    := s2_subscore10;
	self.s2_subscore11                    := s2_subscore11;
	self.s2_subscore12                    := s2_subscore12;
	self.s2_subscore13                    := s2_subscore13;
	self.s2_subscore14                    := s2_subscore14;
	self.s2_rawscore                      := s2_rawscore;
	self.s2_lnoddsscore                   := s2_lnoddsscore;
	self.s2_probscore                     := s2_probscore;
	self.probscore                        := probscore;
	self.base                             := base;
	self.pts                              := pts;
	self.odds                             := odds;
	self.cust_fp_score_3_4                := cust_fp_score_3_4;
	self.cust_fp_score_3_3                := cust_fp_score_3_3;
	self.cust_fp_score_3_2                := cust_fp_score_3_2;
	self.cust_fp_score_3_1                := cust_fp_score_3_1;
	self.cust_fp_score_3                  := cust_fp_score_3;
	self.cust_fp_score_2                  := cust_fp_score_2;
	self.np31_cvi                         := np31_cvi;
	self.fp1403_1_0                       := fp1403_1_0;
#end
	self.seq := le.seq;
	ritmp :=  Models.fraudpoint_reasons(le, blank_ip, num_reasons );
	reasons := Models.Common.checkFraudPointRC34((Integer)FP1403_1_0, ritmp, num_reasons);
	self.ri := reasons;
	self.score := (string)fp1403_1_0;
	self := [];
END;

model :=   join(clam, Easi.Key_Easi_Census,
	left.shell_input.st<>''
		and left.shell_input.county <>''
		and left.shell_input.geo_blk <> ''
		and keyed(right.geolink=left.shell_input.st+left.shell_input.county+left.shell_input.geo_blk),
	doModel(left, right), left outer,
	atmost(RiskWise.max_atmost)
	,keep(1)
);
	return model;
END;
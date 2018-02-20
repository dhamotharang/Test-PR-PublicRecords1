import risk_indicators, riskwise, ut, easi, std;

blank_ip := dataset( [{0}], riskwise.Layout_IP2O )[1];

export FP1307_1_0( dataset(risk_indicators.Layout_Boca_Shell) clam,  integer1 num_reasons) := FUNCTION

FP_DEBUG := False;

#if(FP_DEBUG)
	Layout_Debug := RECORD
	/* Model Input Variables */
	INTEGER sysdate;
	STRING iv_db001_bankruptcy;
	INTEGER bureau_adl_vo_fseen_pos;
	STRING bureau_adl_fseen_vo;
	INTEGER _bureau_adl_fseen_vo;
	INTEGER _src_bureau_adl_fseen;
	INTEGER mth_ver_src_fdate_vo;
	INTEGER bureau_adl_vo_lseen_pos;
	STRING bureau_adl_lseen_vo;
	INTEGER _bureau_adl_lseen_vo;
	INTEGER mth_ver_src_ldate_vo;
	BOOLEAN mth_ver_src_fdate_vo60;
	BOOLEAN mth_ver_src_ldate_vo0;
	INTEGER bureau_adl_w_lseen_pos;
	STRING bureau_adl_lseen_w;
	INTEGER _bureau_adl_lseen_w;
	INTEGER mth_ver_src_ldate_w;
	BOOLEAN mth_ver_src_ldate_w0;
	INTEGER bureau_adl_wp_lseen_pos;
	STRING bureau_adl_lseen_wp;
	INTEGER _bureau_adl_lseen_wp;
	INTEGER _src_bureau_adl_lseen;
	INTEGER mth_ver_src_ldate_wp;
	BOOLEAN mth_ver_src_ldate_wp0;
	INTEGER _paw_first_seen;
	INTEGER mth_paw_first_seen;
	INTEGER mth_paw_first_seen2;
	BOOLEAN ver_src_am;
	BOOLEAN ver_src_e1;
	BOOLEAN ver_src_e2;
	BOOLEAN ver_src_e3;
	BOOLEAN ver_src_pl;
	BOOLEAN ver_src_w;
	BOOLEAN paw_dead_business_count_gt3;
	BOOLEAN paw_active_phone_count_0;
	INTEGER _infutor_first_seen;
	INTEGER mth_infutor_first_seen;
	INTEGER _infutor_last_seen;
	INTEGER mth_infutor_last_seen;
	INTEGER infutor_i;
	Real infutor_im;
	INTEGER white_pages_adl_wp_fseen_pos;
	STRING white_pages_adl_fseen_wp;
	INTEGER _white_pages_adl_fseen_wp;
	INTEGER _src_white_pages_adl_fseen;
	INTEGER iv_sr001_m_wp_adl_fs;
	INTEGER src_m_wp_adl_fs;
	INTEGER _header_first_seen;
	INTEGER iv_sr001_m_hdr_fs;
	INTEGER src_m_hdr_fs;
	REAL source_mod6;
	REAL iv_sr001_source_profile;
	REAL iv_sr001_source_profile_index;
	INTEGER bureau_addr_tn_count_pos;
	INTEGER bureau_addr_count_tn;
	INTEGER bureau_addr_ts_count_pos;
	INTEGER bureau_addr_count_ts;
	INTEGER bureau_addr_tu_count_pos;
	INTEGER bureau_addr_count_tu;
	INTEGER bureau_addr_en_count_pos;
	INTEGER bureau_addr_count_en;
	INTEGER bureau_addr_eq_count_pos;
	INTEGER bureau_addr_count_eq;
	REAL _src_bureau_addr_count;
	REAL iv_src_bureau_addr_count;
	INTEGER _reported_dob;
	INTEGER reported_age;
	INTEGER iv_combined_age;
	STRING iv_best_match_address;
	STRING mortgage_type;
	BOOLEAN mortgage_present;
	STRING iv_bst_addr_mortgage_type;
	INTEGER iv_inq_collection_recency;
	INTEGER iv_inq_banking_recency;
	INTEGER iv_inq_highriskcredit_recency;
	INTEGER iv_pb_average_dollars;
	INTEGER nf_fp_corrrisktype;
	INTEGER iv_inq_addrs_phns_peradl_level;
	REAL subscore0;
	REAL subscore1;
	REAL subscore2;
	REAL subscore3;
	REAL subscore4;
	REAL subscore5;
	REAL subscore6;
	REAL subscore7;
	REAL subscore8;
	REAL subscore9;
	REAL subscore10;
	REAL subscore11;
	REAL rawscore;
	REAL lnoddsscore;
	REAL probscore;
	INTEGER base;
	INTEGER point;
	REAL odds;
	INTEGER or_ssn_deceased;
	INTEGER or_ssn_prior_dob;
	INTEGER or_prison_address;
	INTEGER or_ssn_invalid;
	INTEGER fp1307_1_0;
		
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
	rc_decsflag                      := le.iid.decsflag;
	rc_ssndobflag                    := le.iid.socsdobflag;
	rc_pwssndobflag                  := le.iid.pwsocsdobflag;
	rc_ssnvalflag                    := le.iid.socsvalflag;
	rc_pwssnvalflag                  := le.iid.pwsocsvalflag;
	rc_bansflag                      := le.iid.bansflag;
	rc_hrisksic                      := le.iid.hrisksic;
	ver_sources                      := le.header_summary.ver_sources;
	ver_sources_first_seen           := le.header_summary.ver_sources_first_seen_date;
	ver_sources_last_seen            := le.header_summary.ver_sources_last_seen_date;
	ver_addr_sources                 := le.header_summary.ver_addr_sources;
	ver_addr_sources_count           := le.header_summary.ver_addr_sources_recordcount;
	ssnlength                        := le.input_validation.ssn_length;
	dobpop                           := le.input_validation.dateofbirth;
	age                              := le.name_verification.age;
	add1_isbestmatch                 := le.address_verification.input_address_information.isbestmatch;
	add1_mortgage_date               := le.address_verification.input_address_information.mortgage_date;
	add1_mortgage_type               := le.address_verification.input_address_information.mortgage_type;
	add2_isbestmatch                 := le.address_verification.address_history_1.isbestmatch;
	add2_mortgage_date               := le.address_verification.address_history_1.mortgage_date;
	add2_mortgage_type               := le.address_verification.address_history_1.mortgage_type;
	add3_isbestmatch                 := le.address_verification.address_history_2.isbestmatch;
	header_first_seen                := le.ssn_verification.header_first_seen;
	inputssncharflag                 := le.ssn_verification.validation.inputsocscharflag;
	inq_collection_count             := le.acc_logs.collection.counttotal;
	inq_collection_count01           := le.acc_logs.collection.count01;
	inq_collection_count03           := le.acc_logs.collection.count03;
	inq_collection_count06           := le.acc_logs.collection.count06;
	inq_collection_count12           := le.acc_logs.collection.count12;
	inq_collection_count24           := le.acc_logs.collection.count24;
	inq_banking_count                := le.acc_logs.banking.counttotal;
	inq_banking_count01              := le.acc_logs.banking.count01;
	inq_banking_count03              := le.acc_logs.banking.count03;
	inq_banking_count06              := le.acc_logs.banking.count06;
	inq_banking_count12              := le.acc_logs.banking.count12;
	inq_banking_count24              := le.acc_logs.banking.count24;
	inq_highriskcredit_count         := le.acc_logs.highriskcredit.counttotal;
	inq_highriskcredit_count01       := le.acc_logs.highriskcredit.count01;
	inq_highriskcredit_count03       := le.acc_logs.highriskcredit.count03;
	inq_highriskcredit_count06       := le.acc_logs.highriskcredit.count06;
	inq_highriskcredit_count12       := le.acc_logs.highriskcredit.count12;
	inq_highriskcredit_count24       := le.acc_logs.highriskcredit.count24;
	inq_addrsperadl                  := le.acc_logs.inquiryaddrsperadl;
	inq_phonesperadl                 := le.acc_logs.inquiryphonesperadl;
	pb_average_dollars               := le.ibehavior.average_amount_per_order;
	paw_first_seen                   := le.employment.first_seen_date;
	paw_dead_business_count          := le.employment.dead_business_ct;
	paw_active_phone_count           := le.employment.business_active_phone_ct;
	infutor_first_seen               := le.infutor_phone.infutor_date_first_seen;
	infutor_last_seen                := le.infutor_phone.infutor_date_last_seen;
	infutor_nap                      := le.infutor_phone.infutor_nap;
	fp_corrrisktype                  := le.fdattributesv2.correlationrisklevel;
	bankrupt                         := le.bjl.bankrupt;
	disposition                      := le.bjl.disposition;
	filing_count                     := le.bjl.filing_count;
	bk_recent_count                  := le.bjl.bk_recent_count;
	ams_age                          := le.student.age;
	input_dob_age                    := le.shell_input.age;
	inferred_age                     := le.inferred_age;
	reported_dob                     := le.reported_dob;


/* ***********************************************************
*                    Generated ECL                          *
************************************************************** */

NULL := __common__( -999999999 ) ;


INTEGER contains_i( string haystack, string needle ) := __common__( (INTEGER)(StringLib.StringFind(haystack, needle, 1) > 0) ) ;

sysdate := __common__( common.sas_date(if(le.historydate=999999, (STRING)Std.Date.Today(), (string6)le.historydate+'01')) ) ;

iv_db001_bankruptcy := __common__( map(
    not(truedid or (Integer)ssnlength > 0)                                                                                               => '                 ',
    (disposition in ['Discharge NA', 'Discharged'])                                                                                      => '1 - BK Discharged',
    (disposition in ['Dismissed'])                                                                                                       => '2 - BK Dismissed ',
    (rc_bansflag in ['1', '2']) or bankrupt = (Boolean)1 or contains_i(ver_sources, 'BA') > 0 or filing_count > 0 or bk_recent_count > 0 => '3 - BK Other     ',
                                                                                                                                            '0 - No BK        ') ) ;

bureau_adl_vo_fseen_pos := __common__( Models.Common.findw_cpp(ver_sources, 'VO' , ', ', 'E') ) ;

bureau_adl_fseen_vo := __common__( if(bureau_adl_vo_fseen_pos = 0, '       0', Models.Common.getw(ver_sources_first_seen, bureau_adl_vo_fseen_pos, ',')) ) ;

_bureau_adl_fseen_vo := __common__( common.sas_date((string)(bureau_adl_fseen_vo)) ) ;

_src_bureau_adl_fseen := __common__( _bureau_adl_fseen_vo ) ;

mth_ver_src_fdate_vo := __common__( map(
    not(truedid)                 => NULL,
    _src_bureau_adl_fseen = NULL => -1,
                                    if ((sysdate - _src_bureau_adl_fseen) / (365.25 / 12) >= 0, truncate((sysdate - _src_bureau_adl_fseen) / (365.25 / 12)), roundup((sysdate - _src_bureau_adl_fseen) / (365.25 / 12)))) ) ;

bureau_adl_vo_lseen_pos := __common__( Models.Common.findw_cpp(ver_sources, 'VO' , ', ', 'E') ) ;

bureau_adl_lseen_vo := __common__( if(bureau_adl_vo_lseen_pos = 0, '       0', Models.Common.getw(ver_sources_last_seen, bureau_adl_vo_lseen_pos, ',')) ) ;

_bureau_adl_lseen_vo := __common__( common.sas_date((string)(bureau_adl_lseen_vo)) ) ;

_src_bureau_adl_lseen_2 := __common__( _bureau_adl_lseen_vo ) ;

mth_ver_src_ldate_vo := __common__( map(
    not(truedid)                   => NULL,
    _src_bureau_adl_lseen_2 = NULL => -1,
                                      if ((sysdate - _src_bureau_adl_lseen_2) / (365.25 / 12) >= 0, truncate((sysdate - _src_bureau_adl_lseen_2) / (365.25 / 12)), roundup((sysdate - _src_bureau_adl_lseen_2) / (365.25 / 12)))) ) ;

mth_ver_src_fdate_vo60 := __common__( mth_ver_src_fdate_vo > 60 ) ;

mth_ver_src_ldate_vo0 := __common__( mth_ver_src_ldate_vo = 0 ) ;

bureau_adl_w_lseen_pos := __common__( Models.Common.findw_cpp(ver_sources, 'W' , ', ', 'E') ) ;

bureau_adl_lseen_w := __common__( if(bureau_adl_w_lseen_pos = 0, '       0', Models.Common.getw(ver_sources_last_seen, bureau_adl_w_lseen_pos, ',')) ) ;

_bureau_adl_lseen_w := __common__( common.sas_date((string)(bureau_adl_lseen_w)) ) ;

_src_bureau_adl_lseen_1 := __common__( _bureau_adl_lseen_w ) ;

mth_ver_src_ldate_w := __common__( map(
    not(truedid)                   => NULL,
    _src_bureau_adl_lseen_1 = NULL => -1,
                                      if ((sysdate - _src_bureau_adl_lseen_1) / (365.25 / 12) >= 0, truncate((sysdate - _src_bureau_adl_lseen_1) / (365.25 / 12)), roundup((sysdate - _src_bureau_adl_lseen_1) / (365.25 / 12)))) ) ;

mth_ver_src_ldate_w0 := __common__( mth_ver_src_ldate_w = 0 ) ;

bureau_adl_wp_lseen_pos := __common__( Models.Common.findw_cpp(ver_sources, 'WP' , ', ', 'E') ) ;

bureau_adl_lseen_wp := __common__( if(bureau_adl_wp_lseen_pos = 0, '       0', Models.Common.getw(ver_sources_last_seen, bureau_adl_wp_lseen_pos, ',')) ) ;

_bureau_adl_lseen_wp := __common__( common.sas_date((string)(bureau_adl_lseen_wp)) ) ;

_src_bureau_adl_lseen := __common__( _bureau_adl_lseen_wp ) ;

mth_ver_src_ldate_wp := __common__( map(
    not(truedid)                 => NULL,
    _src_bureau_adl_lseen = NULL => -1,
                                    if ((sysdate - _src_bureau_adl_lseen) / (365.25 / 12) >= 0, truncate((sysdate - _src_bureau_adl_lseen) / (365.25 / 12)), roundup((sysdate - _src_bureau_adl_lseen) / (365.25 / 12)))) ) ;

mth_ver_src_ldate_wp0 := __common__( mth_ver_src_ldate_wp = 0 ) ;

_paw_first_seen := __common__( common.sas_date1800s((string)(PAW_first_seen)) ) ;

mth_paw_first_seen := __common__( map(
    not(truedid)           => NULL,
    _paw_first_seen = NULL => -1,
                              if ((sysdate - _paw_first_seen) / (365.25 / 12) >= 0, truncate((sysdate - _paw_first_seen) / (365.25 / 12)), roundup((sysdate - _paw_first_seen) / (365.25 / 12)))) ) ;

mth_paw_first_seen2 := __common__( if(mth_paw_first_seen = NULL or mth_paw_first_seen < 6, 6, min(360, if(mth_paw_first_seen = NULL, -NULL, mth_paw_first_seen))) ) ;

ver_src_am := __common__( Models.Common.findw_cpp(ver_sources, 'AM' , ', ', 'E') > 0 ) ;

ver_src_e1 := __common__( Models.Common.findw_cpp(ver_sources, 'E1' , ', ', 'E') > 0 ) ;

ver_src_e2 := __common__( Models.Common.findw_cpp(ver_sources, 'E2' , ', ', 'E') > 0 ) ;

ver_src_e3 := __common__( Models.Common.findw_cpp(ver_sources, 'E3' , ', ', 'E') > 0 ) ;

ver_src_pl := __common__( Models.Common.findw_cpp(ver_sources, 'PL' , ', ', 'E') > 0 ) ;

ver_src_w := __common__( Models.Common.findw_cpp(ver_sources, 'W' , ', ', 'E') > 0 ) ;

paw_dead_business_count_gt3 := __common__( paw_dead_business_count > 3 ) ;

paw_active_phone_count_0 := __common__( paw_active_phone_count <= 0 ) ;

_infutor_first_seen := __common__( common.sas_date((string)(infutor_first_seen)) ) ;

mth_infutor_first_seen := __common__( map(
    not(truedid)               => NULL,
    _infutor_first_seen = NULL => NULL,
                                  if ((sysdate - _infutor_first_seen) / (365.25 / 12) >= 0, truncate((sysdate - _infutor_first_seen) / (365.25 / 12)), roundup((sysdate - _infutor_first_seen) / (365.25 / 12)))) ) ;

_infutor_last_seen := __common__( common.sas_date((string)(infutor_last_seen)) ) ;

mth_infutor_last_seen := __common__( map(
    not(truedid)              => NULL,
    _infutor_last_seen = NULL => NULL,
                                 if ((sysdate - _infutor_last_seen) / (365.25 / 12) >= 0, truncate((sysdate - _infutor_last_seen) / (365.25 / 12)), roundup((sysdate - _infutor_last_seen) / (365.25 / 12)))) ) ;

infutor_i := __common__( map(
    infutor_nap = 12 and (mth_infutor_first_seen >= 36 or mth_infutor_last_seen = 0) => 1,
    infutor_nap = 12                                                                 => 4,
    infutor_nap = 11 and (mth_infutor_first_seen >= 36 or mth_infutor_last_seen = 0) => 3,
    infutor_nap = 11                                                                 => 5,
    infutor_nap >= 7 and (mth_infutor_first_seen >= 36 or mth_infutor_last_seen = 0) => 6,
    infutor_nap >= 7                                                                 => 7,
    (infutor_nap in [1, 6])                                                          => 8,
    (infutor_nap in [0])                                                             => 2,
                                                                                        7) ) ;

infutor_im := __common__( map(
    infutor_i = 1 => 7.77,
    infutor_i = 2 => 8.06,
    infutor_i = 3 => 8.38,
    infutor_i = 4 => 8.96,
    infutor_i = 5 => 9.35,
    infutor_i = 6 => 10.19,
    infutor_i = 7 => 13.13,
    infutor_i = 8 => 14.77,
                     9.03) ) ;

white_pages_adl_wp_fseen_pos := __common__( Models.Common.findw_cpp(ver_sources, 'WP' , ', ', 'E') ) ;

white_pages_adl_fseen_wp := __common__( if(white_pages_adl_wp_fseen_pos = 0, '       0', Models.Common.getw(ver_sources_first_seen, white_pages_adl_wp_fseen_pos, ',')) ) ;

_white_pages_adl_fseen_wp := __common__( common.sas_date((string)(white_pages_adl_fseen_wp)) ) ;

_src_white_pages_adl_fseen := __common__( _white_pages_adl_fseen_wp ) ;

iv_sr001_m_wp_adl_fs := __common__( map(
    not(truedid)                      => NULL,
    _src_white_pages_adl_fseen = NULL => -1,
                                         if ((sysdate - _src_white_pages_adl_fseen) / (365.25 / 12) >= 0, truncate((sysdate - _src_white_pages_adl_fseen) / (365.25 / 12)), roundup((sysdate - _src_white_pages_adl_fseen) / (365.25 / 12)))) ) ;

src_m_wp_adl_fs := __common__( map(
    iv_sr001_m_wp_adl_fs = NULL => -1,
    iv_sr001_m_wp_adl_fs = -1   => 10,
    iv_sr001_m_wp_adl_fs >= 24  => 24,
                                   iv_sr001_m_wp_adl_fs) ) ;

_header_first_seen := __common__( common.sas_date((string)(header_first_seen)) ) ;

iv_sr001_m_hdr_fs := __common__( map(
    not(truedid)                   => NULL,
    not(_header_first_seen = NULL) => if ((sysdate - _header_first_seen) / (365.25 / 12) >= 0, truncate((sysdate - _header_first_seen) / (365.25 / 12)), roundup((sysdate - _header_first_seen) / (365.25 / 12))),
                                      -1) ) ;

src_m_hdr_fs := __common__( map(
    iv_sr001_m_hdr_fs = NULL => 15,
    iv_sr001_m_hdr_fs = -1   => 40,
    iv_sr001_m_hdr_fs >= 260 => 260,
                                iv_sr001_m_hdr_fs) ) ;

source_mod6_1 := __common__( -2.350792319 +
    (integer)ver_src_am * -0.611853123 +
    (integer)ver_src_e1 * -0.208450798 +
    (integer)ver_src_e2 * -0.23159296 +
    (integer)ver_src_e3 * -0.415443106 +
    (integer)ver_src_pl * -0.275168358 +
    (integer)mth_ver_src_fdate_vo60 * -0.119660071 +
    (integer)mth_ver_src_ldate_vo0 * -0.322346162 +
    (integer)ver_src_w * -0.232332713 +
    (integer)mth_ver_src_ldate_w0 * -0.371580672 +
    (integer)mth_ver_src_ldate_wp0 * -0.149556634 +
    mth_paw_first_seen2 * -0.002615342 +
    (integer)paw_dead_business_count_gt3 * 1.3423068152 +
    (integer)paw_active_phone_count_0 * 0.3754685927 +
    infutor_im * 0.061827139 +
    src_m_wp_adl_fs * -0.006650973 +
    src_m_hdr_fs * -0.004903484 ) ;

source_mod6 := __common__( exp(source_mod6_1) / (1 + exp(source_mod6_1)) ) ;

// iv_sr001_source_profile := __common__( if(not(truedid), NULL, max((real)0, round(100 - 500 * source_mod6/0.1)*0.1)) ) ;
source_profile_temp := __common__( (100 - (500 * source_mod6)) ) ;
iv_sr001_source_profile := __common__( if(not(truedid), NULL, max(0, round(source_profile_temp * 10) / 10)) ) ;


iv_sr001_source_profile_index := __common__( map(
    not(truedid)                  => -1,
    iv_sr001_source_profile <= 9  => 0,
    iv_sr001_source_profile <= 18 => 1,
    iv_sr001_source_profile <= 23 => 2,
    iv_sr001_source_profile <= 35 => 3,
    iv_sr001_source_profile <= 60 => 4,
    iv_sr001_source_profile <= 72 => 5,
    iv_sr001_source_profile <= 79 => 6,
    iv_sr001_source_profile <= 82 => 7,
    iv_sr001_source_profile <= 86 => 8,
                                     9) ) ;

bureau_addr_tn_count_pos := __common__( Models.Common.findw_cpp(ver_Addr_sources, 'TN' , ', ', 'E') ) ;

bureau_addr_count_tn := __common__( if(bureau_addr_tn_count_pos = 0, NULL, (integer)Models.Common.getw(ver_Addr_sources_count, bureau_addr_tn_count_pos, ',')) ) ;

bureau_addr_ts_count_pos := __common__( Models.Common.findw_cpp(ver_Addr_sources, 'TS' , ', ', 'E') ) ;

bureau_addr_count_ts := __common__( if(bureau_addr_ts_count_pos = 0, NULL, (integer)Models.Common.getw(ver_Addr_sources_count, bureau_addr_ts_count_pos, ',')) ) ;

bureau_addr_tu_count_pos := __common__( Models.Common.findw_cpp(ver_Addr_sources, 'TU' , ', ', 'E') ) ;

bureau_addr_count_tu := __common__( if(bureau_addr_tu_count_pos = 0, NULL, (integer)Models.Common.getw(ver_Addr_sources_count, bureau_addr_tu_count_pos, ',')) ) ;

bureau_addr_en_count_pos := __common__( Models.Common.findw_cpp(ver_Addr_sources, 'EN' , ', ', 'E') ) ;

bureau_addr_count_en := __common__( if(bureau_addr_en_count_pos = 0, NULL, (integer)Models.Common.getw(ver_Addr_sources_count, bureau_addr_en_count_pos, ',')) ) ;

bureau_addr_eq_count_pos := __common__( Models.Common.findw_cpp(ver_Addr_sources, 'EQ' , ', ', 'E') ) ;

bureau_addr_count_eq := __common__( if(bureau_addr_eq_count_pos = 0, NULL, (integer)Models.Common.getw(ver_Addr_sources_count, bureau_addr_eq_count_pos, ',')) ) ;

_src_bureau_addr_count := __common__( max(if(max(bureau_addr_count_tn, bureau_addr_count_ts, bureau_addr_count_tu, bureau_addr_count_en, bureau_addr_count_eq) = NULL, NULL, sum(if(bureau_addr_count_tn = NULL, 0, bureau_addr_count_tn), if(bureau_addr_count_ts = NULL, 0, bureau_addr_count_ts), if(bureau_addr_count_tu = NULL, 0, bureau_addr_count_tu), if(bureau_addr_count_en = NULL, 0, bureau_addr_count_en), if(bureau_addr_count_eq = NULL, 0, bureau_addr_count_eq))), (real)0) ) ;

iv_src_bureau_addr_count := __common__( map(
    not(truedid)                  => NULL,
    _src_bureau_addr_count = NULL => -1,
                                     _src_bureau_addr_count) ) ;

_reported_dob := __common__( common.sas_date((string)(reported_dob)) ) ;

reported_age := __common__( if(min(sysdate, _reported_dob) = NULL, NULL, truncate((sysdate - _reported_dob) / 365.25)) ) ;

iv_combined_age := __common__( map(
    not(truedid or dobpop)     => NULL,
    age > 0                    => age,
    (Integer)input_dob_age > 0 => (Integer)input_dob_age,
    inferred_age > 0           => inferred_age,
    reported_age > 0           => reported_age,
    (Integer)ams_age > 0       => (Integer)ams_age,
                                  -1) ) ;

iv_best_match_address := __common__( map(
    add1_isbestmatch => 'ADD1',
    add2_isbestmatch => 'ADD2',
    add3_isbestmatch => 'ADD3',
                        'NONE') ) ;

mortgage_type := __common__( if(add1_isbestmatch, add1_mortgage_type, add2_mortgage_type) ) ;

mortgage_present := __common__( if(add1_isbestmatch, not(((String)add1_mortgage_date in ['0', ' '])), not(((String)add2_mortgage_date in ['0', ' ']))) ) ;

iv_bst_addr_mortgage_type := __common__( map(
    not(truedid)                                          => '               ',
    (mortgage_type in ['CNV', 'N'])                       => 'Conventional   ',
    (mortgage_type in ['FHA', 'G', 'VA'])                 => 'Government     ',
    (mortgage_type in ['1', 'D'])                         => 'Piggyback      ',
    (mortgage_type in ['2', 'E', 'R', 'C'])               => 'Equity Loan    ',
    (mortgage_type in ['I', 'K', 'O', 'LHM', 'T', 'SBA']) => 'Commercial     ',
    (mortgage_type in ['H', 'J'])                         => 'High-Risk      ',
    (mortgage_type in ['PMM', 'PP', 'S', 'L'])            => 'Non-Traditional',
    (mortgage_type in ['U'])                              => 'Unknown        ',
	mortgage_type != ''                                   => 'Other          ',
    mortgage_present                                      => 'Unknown        ',
                                                             'No Mortgage') ) ;

iv_inq_collection_recency := __common__( map(
    not(truedid)                    => NULL,
    (Boolean)inq_collection_count01 => 1,
    (Boolean)inq_collection_count03 => 3,
    (Boolean)inq_collection_count06 => 6,
    (Boolean)inq_collection_count12 => 12,
    (Boolean)inq_collection_count24 => 24,
    (Boolean)inq_collection_count   => 99,
                                       0) ) ;

iv_inq_banking_recency := __common__( map(
    not(truedid)                 => NULL,
    (Boolean)inq_banking_count01 => 1,
    (Boolean)inq_banking_count03 => 3,
    (Boolean)inq_banking_count06 => 6,
    (Boolean)inq_banking_count12 => 12,
    (Boolean)inq_banking_count24 => 24,
    (Boolean)inq_banking_count   => 99,
                                    0) ) ;

iv_inq_highriskcredit_recency := __common__( map(
    not(truedid)                        => NULL,
    (Boolean)inq_highRiskCredit_count01 => 1,
    (Boolean)inq_highRiskCredit_count03 => 3,
    (Boolean)inq_highRiskCredit_count06 => 6,
    (Boolean)inq_highRiskCredit_count12 => 12,
    (Boolean)inq_highRiskCredit_count24 => 24,
    (Boolean)inq_highRiskCredit_count   => 99,
                                           0) ) ;

iv_pb_average_dollars := __common__( map(
    not(truedid)            => NULL,
    pb_average_dollars = '' => -1,
                              (Integer)pb_average_dollars) ) ;

nf_fp_corrrisktype := __common__( if(not(truedid) or (Integer)fp_corrrisktype = NULL, NULL, (Integer)fp_corrrisktype) ) ;

iv_inq_addrs_phns_peradl_level := __common__( map(
    not(truedid)                                   => NULL,
    Inq_AddrsPerADL <= 0                           => 0,
    Inq_AddrsPerADL <= 1 and Inq_PhonesPerADL <= 1 => 1,
    Inq_AddrsPerADL <= 1                           => 2,
    Inq_AddrsPerADL <= 2 and Inq_PhonesPerADL <= 2 => 2,
                                                      3) ) ;

subscore0 := __common__( map(
    NULL < iv_inq_collection_recency AND iv_inq_collection_recency < 1 => 0.063524,
    1 <= iv_inq_collection_recency AND iv_inq_collection_recency < 3   => -0.601494,
    3 <= iv_inq_collection_recency AND iv_inq_collection_recency < 12  => -0.520567,
    12 <= iv_inq_collection_recency AND iv_inq_collection_recency < 24 => 0.076852,
    24 <= iv_inq_collection_recency AND iv_inq_collection_recency < 99 => 0.232680,
    99 <= iv_inq_collection_recency                                    => 0.317173,
                                                                          0.000000) ) ;

subscore1 := __common__( map(
    NULL < iv_inq_banking_recency AND iv_inq_banking_recency < 1 => -0.023838,
    1 <= iv_inq_banking_recency AND iv_inq_banking_recency < 3   => -0.463367,
    3 <= iv_inq_banking_recency AND iv_inq_banking_recency < 6   => -0.113533,
    6 <= iv_inq_banking_recency AND iv_inq_banking_recency < 99  => 0.237555,
    99 <= iv_inq_banking_recency                                 => 0.324695,
                                                                    0.000000) ) ;

subscore2 := __common__( map(
    NULL < iv_combined_age AND iv_combined_age < 32 => -0.215416,
    32 <= iv_combined_age AND iv_combined_age < 39  => -0.114387,
    39 <= iv_combined_age AND iv_combined_age < 49  => -0.098423,
    49 <= iv_combined_age AND iv_combined_age < 55  => 0.203045,
    55 <= iv_combined_age                           => 0.422018,
                                                       0.000000) ) ;

subscore3 := __common__( map(
    NULL < iv_inq_addrs_phns_peradl_level AND iv_inq_addrs_phns_peradl_level < 1 => 0.189336,
    1 <= iv_inq_addrs_phns_peradl_level AND iv_inq_addrs_phns_peradl_level < 2   => 0.176228,
    2 <= iv_inq_addrs_phns_peradl_level AND iv_inq_addrs_phns_peradl_level < 3   => -0.063773,
    3 <= iv_inq_addrs_phns_peradl_level                                          => -0.427511,
                                                                                    -0.000000) ) ;

subscore4 := __common__( map(
    NULL < iv_inq_highriskcredit_recency AND iv_inq_highriskcredit_recency < 1 => 0.036554,
    1 <= iv_inq_highriskcredit_recency AND iv_inq_highriskcredit_recency < 3   => -0.309910,
    3 <= iv_inq_highriskcredit_recency AND iv_inq_highriskcredit_recency < 12  => 0.029206,
    12 <= iv_inq_highriskcredit_recency AND iv_inq_highriskcredit_recency < 99 => 0.218901,
    99 <= iv_inq_highriskcredit_recency                                        => 0.401031,
                                                                                  -0.000000) ) ;

subscore5 := __common__( map(
    NULL < iv_pb_average_dollars AND iv_pb_average_dollars < 0 => -0.227602,
    0 <= iv_pb_average_dollars AND iv_pb_average_dollars < 25  => -0.075787,
    25 <= iv_pb_average_dollars AND iv_pb_average_dollars < 84 => 0.070566,
    84 <= iv_pb_average_dollars                                => 0.314802,
                                                                  -0.000000) ) ;

subscore6 := __common__( map(
    (iv_db001_bankruptcy in ['2 - BK Dismissed'])  => -1.019373,
    (iv_db001_bankruptcy in ['3 - BK Other'])      => -0.432996,
    (iv_db001_bankruptcy in ['0 - No BK'])         => -0.019950,
    (iv_db001_bankruptcy in ['1 - BK Discharged']) => 0.145583,
                                                      0.000000) ) ;

subscore7 := __common__( map(
    NULL < iv_sr001_source_profile_index AND iv_sr001_source_profile_index < 0 => 0.000000,
    0 <= iv_sr001_source_profile_index AND iv_sr001_source_profile_index < 5   => -0.202890,
    5 <= iv_sr001_source_profile_index AND iv_sr001_source_profile_index < 7   => -0.009025,
    7 <= iv_sr001_source_profile_index                                         => 0.278904,
                                                                                  0.000000) ) ;

subscore8 := __common__( map(
    (iv_bst_addr_mortgage_type in ['Other'])                                                                           => -0.000000,
    (iv_bst_addr_mortgage_type in ['Conventional'])                                                                    => 0.368992,
    (iv_bst_addr_mortgage_type in ['Government'])                                                                      => 0.145476,
    (iv_bst_addr_mortgage_type in ['Unknown'])                                                                         => -0.007963,
    (iv_bst_addr_mortgage_type in ['No Mortgage'])                                                                     => -0.011011,
    (iv_bst_addr_mortgage_type in ['Commercial', 'Equity Loan', 'High-Risk', 'Non-Traditional', 'Other', 'Piggyback']) => -0.432272,
                                                                                                                          -0.000000) ) ;

subscore9 := __common__( map(
    (iv_best_match_address in ['ADD1']) => 0.029572,
    (iv_best_match_address in ['ADD2']) => 0.070396,
    (iv_best_match_address in ['ADD3']) => -0.225747,
    (iv_best_match_address in ['NONE']) => -1.060700,
                                           0.000000) ) ;

subscore10 := __common__( map(
    ((String)nf_fp_corrrisktype in ['Other'])       => -0.000000,
    ((String)nf_fp_corrrisktype in ['1'])           => 0.507735,
    ((String)nf_fp_corrrisktype in ['2', '3'])      => 0.021839,
    ((String)nf_fp_corrrisktype in ['4', '5', '6']) => 0.019184,
    ((String)nf_fp_corrrisktype in ['7', '8', '9']) => -0.192050,
                                                       -0.000000) ) ;

subscore11 := __common__( map(
    NULL < iv_src_bureau_addr_count AND iv_src_bureau_addr_count < 1 => -0.312550,
    1 <= iv_src_bureau_addr_count AND iv_src_bureau_addr_count < 4   => -0.311764,
    4 <= iv_src_bureau_addr_count AND iv_src_bureau_addr_count < 6   => 0.006527,
    6 <= iv_src_bureau_addr_count AND iv_src_bureau_addr_count < 7   => 0.116521,
    7 <= iv_src_bureau_addr_count                                    => 0.226516,
                                                                        -0.000000) ) ;

rawscore := __common__( subscore0 +
    subscore1 +
    subscore2 +
    subscore3 +
    subscore4 +
    subscore5 +
    subscore6 +
    subscore7 +
    subscore8 +
    subscore9 +
    subscore10 +
    subscore11 ) ;

lnoddsscore := __common__( rawscore + 5.014427 ) ;

probscore := __common__( exp(lnoddsscore) / (1 + exp(lnoddsscore)) ) ;

base := __common__( 700 ) ;

point := __common__( 50 ) ;

odds := __common__( (1 - .0065) / .0065 ) ;

fp1307_1_0_4 := __common__( min(if(max(round(point * (ln(probscore / (1 - probscore)) - ln(odds)) / ln(2) + base), 300) = NULL, -NULL, max(round(point * (ln(probscore / (1 - probscore)) - ln(odds)) / ln(2) + base), 300)), 999) ) ;

or_ssn_deceased := __common__( map(
    not(truedid or (Integer)ssnlength > 0)                                 => 0,
    (Integer)rc_decsflag = 1                                               => 1,
    contains_i(ver_sources, 'DE') > 0 or contains_i(ver_sources, 'DS') > 0 => 1,
    (Integer)rc_decsflag = 0                                               => 0,
                                                                              0) ) ;

or_ssn_prior_dob := __common__( map(
    not((Integer)ssnlength > 0 and dobpop)                     => 0,
    (Integer)rc_ssndobflag = 1 or (Integer)rc_pwssndobflag = 1 => 1,
    (Integer)rc_ssndobflag = 0 or (Integer)rc_pwssndobflag = 0 => 0,
                                                                  0) ) ;

or_prison_address := __common__( if((Integer)rc_hrisksic = 2225, 1, 0) ) ;

or_ssn_invalid := __common__( map(
    not((Integer)ssnlength > 0)                                                                                 => 0,
    (Integer)rc_ssnvalflag = 1 or (rc_pwssnvalflag in ['1', '2', '3']) or (inputssncharflag in ['1', '2', '3']) => 1,
    (Integer)rc_ssnvalflag = 0 or (rc_pwssnvalflag in ['0', '4', '5']) or (inputssncharflag in ['0', '4', '5']) => 0,
                                                                                                                   0) ) ;

fp1307_1_0_3 := __common__( if(or_ssn_deceased = 1, min(if(fp1307_1_0_4 = NULL, -NULL, fp1307_1_0_4), 500), fp1307_1_0_4) ) ;

fp1307_1_0_2 := __common__( if(or_ssn_prior_dob = 1, min(if(fp1307_1_0_3 = NULL, -NULL, fp1307_1_0_3), 500), fp1307_1_0_3) ) ;

fp1307_1_0_1 := __common__( if(or_prison_address = 1, min(if(fp1307_1_0_2 = NULL, -NULL, fp1307_1_0_2), 500), fp1307_1_0_2) ) ;

fp1307_1_0 := __common__( if(or_ssn_invalid = 1, min(if(fp1307_1_0_1 = NULL, -NULL, fp1307_1_0_1), 500), fp1307_1_0_1) ) ;

#if(FP_DEBUG)
		/* Model Input Variables */
	self.clam							  := le;
	self.sysdate                          := sysdate;
	self.iv_db001_bankruptcy              := iv_db001_bankruptcy;
	self.bureau_adl_vo_fseen_pos          := bureau_adl_vo_fseen_pos;
	self.bureau_adl_fseen_vo              := bureau_adl_fseen_vo;
	self._bureau_adl_fseen_vo             := _bureau_adl_fseen_vo;
	self._src_bureau_adl_fseen            := _src_bureau_adl_fseen;
	self.mth_ver_src_fdate_vo             := mth_ver_src_fdate_vo;
	self.bureau_adl_vo_lseen_pos          := bureau_adl_vo_lseen_pos;
	self.bureau_adl_lseen_vo              := bureau_adl_lseen_vo;
	self._bureau_adl_lseen_vo             := _bureau_adl_lseen_vo;
	self.mth_ver_src_ldate_vo             := mth_ver_src_ldate_vo;
	self.mth_ver_src_fdate_vo60           := mth_ver_src_fdate_vo60;
	self.mth_ver_src_ldate_vo0            := mth_ver_src_ldate_vo0;
	self.bureau_adl_w_lseen_pos           := bureau_adl_w_lseen_pos;
	self.bureau_adl_lseen_w               := bureau_adl_lseen_w;
	self._bureau_adl_lseen_w              := _bureau_adl_lseen_w;
	self.mth_ver_src_ldate_w              := mth_ver_src_ldate_w;
	self.mth_ver_src_ldate_w0             := mth_ver_src_ldate_w0;
	self.bureau_adl_wp_lseen_pos          := bureau_adl_wp_lseen_pos;
	self.bureau_adl_lseen_wp              := bureau_adl_lseen_wp;
	self._bureau_adl_lseen_wp             := _bureau_adl_lseen_wp;
	self._src_bureau_adl_lseen            := _src_bureau_adl_lseen;
	self.mth_ver_src_ldate_wp             := mth_ver_src_ldate_wp;
	self.mth_ver_src_ldate_wp0            := mth_ver_src_ldate_wp0;
	self._paw_first_seen                  := _paw_first_seen;
	self.mth_paw_first_seen               := mth_paw_first_seen;
	self.mth_paw_first_seen2              := mth_paw_first_seen2;
	self.ver_src_am                       := ver_src_am;
	self.ver_src_e1                       := ver_src_e1;
	self.ver_src_e2                       := ver_src_e2;
	self.ver_src_e3                       := ver_src_e3;
	self.ver_src_pl                       := ver_src_pl;
	self.ver_src_w                        := ver_src_w;
	self.paw_dead_business_count_gt3      := paw_dead_business_count_gt3;
	self.paw_active_phone_count_0         := paw_active_phone_count_0;
	self._infutor_first_seen              := _infutor_first_seen;
	self.mth_infutor_first_seen           := mth_infutor_first_seen;
	self._infutor_last_seen               := _infutor_last_seen;
	self.mth_infutor_last_seen            := mth_infutor_last_seen;
	self.infutor_i                        := infutor_i;
	self.infutor_im                       := infutor_im;
	self.white_pages_adl_wp_fseen_pos     := white_pages_adl_wp_fseen_pos;
	self.white_pages_adl_fseen_wp         := white_pages_adl_fseen_wp;
	self._white_pages_adl_fseen_wp        := _white_pages_adl_fseen_wp;
	self._src_white_pages_adl_fseen       := _src_white_pages_adl_fseen;
	self.iv_sr001_m_wp_adl_fs             := iv_sr001_m_wp_adl_fs;
	self.src_m_wp_adl_fs                  := src_m_wp_adl_fs;
	self._header_first_seen               := _header_first_seen;
	self.iv_sr001_m_hdr_fs                := iv_sr001_m_hdr_fs;
	self.src_m_hdr_fs                     := src_m_hdr_fs;
	self.source_mod6                      := source_mod6;
	self.iv_sr001_source_profile          := iv_sr001_source_profile;
	self.iv_sr001_source_profile_index    := iv_sr001_source_profile_index;
	self.bureau_addr_tn_count_pos         := bureau_addr_tn_count_pos;
	self.bureau_addr_count_tn             := bureau_addr_count_tn;
	self.bureau_addr_ts_count_pos         := bureau_addr_ts_count_pos;
	self.bureau_addr_count_ts             := bureau_addr_count_ts;
	self.bureau_addr_tu_count_pos         := bureau_addr_tu_count_pos;
	self.bureau_addr_count_tu             := bureau_addr_count_tu;
	self.bureau_addr_en_count_pos         := bureau_addr_en_count_pos;
	self.bureau_addr_count_en             := bureau_addr_count_en;
	self.bureau_addr_eq_count_pos         := bureau_addr_eq_count_pos;
	self.bureau_addr_count_eq             := bureau_addr_count_eq;
	self._src_bureau_addr_count           := _src_bureau_addr_count;
	self.iv_src_bureau_addr_count         := iv_src_bureau_addr_count;
	self._reported_dob                    := _reported_dob;
	self.reported_age                     := reported_age;
	self.iv_combined_age                  := iv_combined_age;
	self.iv_best_match_address            := iv_best_match_address;
	self.mortgage_type                    := mortgage_type;
	self.mortgage_present                 := mortgage_present;
	self.iv_bst_addr_mortgage_type        := iv_bst_addr_mortgage_type;
	self.iv_inq_collection_recency        := iv_inq_collection_recency;
	self.iv_inq_banking_recency           := iv_inq_banking_recency;
	self.iv_inq_highriskcredit_recency    := iv_inq_highriskcredit_recency;
	self.iv_pb_average_dollars            := iv_pb_average_dollars;
	self.nf_fp_corrrisktype               := nf_fp_corrrisktype;
	self.iv_inq_addrs_phns_peradl_level   := iv_inq_addrs_phns_peradl_level;
	self.subscore0                        := subscore0;
	self.subscore1                        := subscore1;
	self.subscore2                        := subscore2;
	self.subscore3                        := subscore3;
	self.subscore4                        := subscore4;
	self.subscore5                        := subscore5;
	self.subscore6                        := subscore6;
	self.subscore7                        := subscore7;
	self.subscore8                        := subscore8;
	self.subscore9                        := subscore9;
	self.subscore10                       := subscore10;
	self.subscore11                       := subscore11;
	self.rawscore                         := rawscore;
	self.lnoddsscore                      := lnoddsscore;
	self.probscore                        := probscore;
	self.base                             := base;
	self.point                            := point;
	self.odds                             := odds;
	self.or_ssn_deceased                  := or_ssn_deceased;
	self.or_ssn_prior_dob                 := or_ssn_prior_dob;
	self.or_prison_address                := or_prison_address;
	self.or_ssn_invalid                   := or_ssn_invalid;
	self.fp1307_1_0                       := fp1307_1_0;

#end
	self.seq := le.seq;
	ritmp :=  Models.fraudpoint_reasons(le, blank_ip, num_reasons );
	reasons := Models.Common.checkFraudPointRC34(FP1307_1_0, ritmp, num_reasons);
	self.ri := reasons;
	self.score := (string)fp1307_1_0;
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
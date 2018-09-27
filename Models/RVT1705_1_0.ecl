IMPORT ut, Std, RiskWise, RiskWiseFCRA, Risk_Indicators, riskview;

EXPORT RVT1705_1_0 (GROUPED DATASET(Risk_Indicators.Layout_Boca_Shell) clam, Boolean isCalifornia = False) := FUNCTION

		//MODEL_DEBUG := TRUE;
	  MODEL_DEBUG := FALSE;

	#if(MODEL_DEBUG)
Layout_Debug := RECORD
			/* Model Input Variables */
INTEGER      seq;
INTEGER      sysdate;
STRING       iv_add_apt;
INTEGER      iv_va040_add_prison_hist;
STRING       iv_db001_bankruptcy;
integer      bureau_adl_vo_fseen_pos;
string       bureau_adl_fseen_vo;
integer      _bureau_adl_fseen_vo;
REAL         _src_bureau_adl_fseen;
integer      mth_ver_src_fdate_vo;
integer      bureau_adl_vo_lseen_pos;
string       bureau_adl_lseen_vo;
integer      _bureau_adl_lseen_vo;
integer      mth_ver_src_ldate_vo;
boolean      mth_ver_src_fdate_vo60;
boolean      mth_ver_src_ldate_vo0;
integer      bureau_adl_w_lseen_pos;
string       bureau_adl_lseen_w;
integer      _bureau_adl_lseen_w;
integer      mth_ver_src_ldate_w;
boolean      mth_ver_src_ldate_w0;
integer      bureau_adl_wp_lseen_pos;
string       bureau_adl_lseen_wp;
integer      _bureau_adl_lseen_wp;
integer      _src_bureau_adl_lseen;
integer      mth_ver_src_ldate_wp;
boolean      mth_ver_src_ldate_wp0;
integer      _paw_first_seen;
integer      mth_paw_first_seen;
integer      mth_paw_first_seen2;
boolean      ver_src_am;
boolean      ver_src_e1;
boolean      ver_src_e2;
boolean      ver_src_e3;
boolean      ver_src_pl;
boolean      ver_src_w;
boolean      paw_dead_business_count_gt3;
boolean      paw_active_phone_count_0;
integer      _infutor_first_seen;
integer      mth_infutor_first_seen;
integer      _infutor_last_seen;
integer      mth_infutor_last_seen;
integer      infutor_i;
real         infutor_im;
integer      white_pages_adl_wp_fseen_pos;
STRING       white_pages_adl_fseen_wp;
integer      _white_pages_adl_fseen_wp;
integer      _src_white_pages_adl_fseen;
integer      iv_sr001_m_wp_adl_fs;
integer      src_m_wp_adl_fs;
INTEGER      _header_first_seen;
INTEGER      iv_sr001_m_hdr_fs;
INTEGER      src_m_hdr_fs;
REAL         source_mod6;
REAL         iv_sr001_source_profile;
Integer      iv_ms001_ssns_per_adl;
INTEGER      iv_pv001_inp_avm_autoval;
INTEGER      iv_pv001_bst_avm_autoval;
STRING       iv_ed001_college_ind;
STRING      iv_input_addr_not_most_recent;
INTEGER      prop_adl_p_count_pos;
INTEGER      prop_adl_count_p;
REAL         _src_prop_adl_count;
REAL         iv_src_property_adl_count;
STRING       iv_bst_addr_naprop;
BOOLEAN      mortgage_present;
STRING       mortgage_type;
STRING       iv_bst_addr_mortgage_type;
REAL         iv_prv_addr_avm_auto_val;
INTEGER      iv_addrs_10yr;
INTEGER      iv_adls_per_sfd_addr;
INTEGER      iv_inq_highriskcredit_count12;
INTEGER      iv_inq_communications_count12;
INTEGER      iv_inq_other_count12;
INTEGER      iv_inq_addrs_per_adl;
INTEGER      iv_inq_adls_per_addr;
INTEGER      iv_eviction_count;
INTEGER      iv_unreleased_liens_ct;
STRING       iv_criminal_x_felony;
STRING      iv_prof_license_flag;
REAL         o_subscore0;
REAL         o_subscore1;
REAL         o_subscore2;
REAL         o_subscore3;
REAL         o_subscore4;
REAL         o_subscore5;
REAL         o_subscore6;
REAL         o_subscore7;
REAL         o_subscore8;
REAL         o_subscore9;
REAL         o_subscore10;
REAL         o_subscore11;
REAL         o_subscore12;
REAL         o_subscore13;
REAL         o_subscore14;
REAL         o_subscore15;
REAL         o_subscore16;
REAL         o_subscore17;
REAL         o_subscore18;
REAL         o_subscore19;
REAL         o_subscore20;
REAL         o_subscore21;
REAL         o_subscore22;
REAL         o_subscore23;
REAL         o_rawscore;
REAL         o_lnoddsscore;
REAL         o_probscore;
STRING       o_aacd_0;
REAL         o_dist_0;
STRING       o_aacd_1;
REAL         o_dist_1;
STRING       o_aacd_2;
REAL         o_dist_2;
STRING       o_aacd_3;
REAL         o_dist_3;
STRING       o_aacd_4;
REAL         o_dist_4;
STRING       o_aacd_5;
REAL         o_dist_5;
STRING       o_aacd_6; 
REAL         o_dist_6;
STRING       o_aacd_7;
REAL         o_dist_7;
STRING       o_aacd_8;
REAL         o_dist_8;
STRING       o_aacd_9;
REAL         o_dist_9;
STRING       o_aacd_10;
REAL         o_dist_10;
STRING       o_aacd_11;
REAL         o_dist_11;
STRING       o_aacd_12;
REAL         o_dist_12;
STRING       o_aacd_13;
REAL         o_dist_13;
STRING       o_aacd_14;
REAL         o_dist_14;
STRING       o_aacd_15;
REAL         o_dist_15;
STRING       o_aacd_16;
REAL         o_dist_16;
STRING       o_aacd_17;
REAL         o_dist_17;
STRING       o_aacd_18;
REAL         o_dist_18;
STRING       o_aacd_19;
REAL         o_dist_19;
STRING       o_aacd_20;
REAL         o_dist_20;
STRING       o_aacd_21;
REAL         o_dist_21;
STRING       o_aacd_22;
REAL         o_dist_22;
STRING       o_aacd_23;
REAL         o_dist_23;
REAL         o_rcvalue9i;
REAL         o_rcvalue9j;
REAL         o_rcvaluepv;
REAL         o_rcvalue9a;
REAL         o_rcvalue9d;
REAL         o_rcvalue36;
REAL         o_rcvalue99;
REAL         o_rcvalue98;
REAL         o_rcvalue9w;
REAL         o_rcvaluems;
REAL         o_rcvalue9q;
REAL         o_rcvalue9p;
REAL         o_rcvalueev;
REAL         o_rcvalue97;
REAL         o_rcvalue50;
Boolean      ssn_deceased;
BOOLEAN      riskview_222s;
INTEGER      base;
INTEGER      pts;
REAL      odds;
INTEGER      rvt1705_1_0;
STRING       o_rc1;
STRING       o_rc2;
STRING       o_rc3;
STRING       o_rc4;
REAL         o_vl1;
REAL         o_vl2;
REAL         o_vl3;
REAL         o_vl4;
STRING       _rc_inq;
STRING       rc2;
STRING       rc4;
STRING       rc3;
STRING       rc1;
STRING       rc5;

			Risk_Indicators.Layout_Boca_Shell clam;
		END;
		Layout_Debug doModel(clam le) := TRANSFORM
	#else
		Models.Layout_ModelOut doModel(clam le) := TRANSFORM
	#end

 //* ***********************************************************
 //*             Model Input Variable Assignments              *
 //************************************************************* 
	truedid                          := le.truedid;
	out_unit_desig                   := le.shell_input.unit_desig;
	out_sec_range                    := le.shell_input.sec_range;
	out_addr_type                    := le.shell_input.addr_type;
	nas_summary                      := le.iid.nas_summary;
	nap_summary                      := le.iid.nap_summary;
	rc_input_addr_not_most_recent    := le.iid.inputaddrnotmostrecent;
	rc_decsflag                      := le.iid.decsflag;
	rc_dwelltype                     := le.iid.dwelltype;
	rc_bansflag                      := le.iid.bansflag;
	combo_dobscore                   := le.iid.combo_dobscore;
	ver_sources                      := (STRING)le.header_summary.ver_sources;
	ver_sources_first_seen           := le.header_summary.ver_sources_first_seen_date;
	ver_sources_last_seen            := le.header_summary.ver_sources_last_seen_date;
	ver_sources_count                := le.header_summary.ver_sources_recordcount;
	ssnlength                        := le.input_validation.ssn_length;
	add1_isbestmatch                 := le.address_verification.input_address_information.isbestmatch;
	add1_avm_automated_valuation     := le.avm.input_address_information.avm_automated_valuation;
	add1_naprop                      := le.address_verification.input_address_information.naprop;
	add1_mortgage_date               := le.address_verification.input_address_information.mortgage_date;
	add1_mortgage_type               := le.address_verification.input_address_information.mortgage_type;
	add1_pop                         := le.addrpop;
	property_owned_total             := le.address_verification.owned.property_total;
	property_sold_total              := le.address_verification.sold.property_total;
	add2_avm_automated_valuation     := le.avm.address_history_1.avm_automated_valuation;
	add2_naprop                      := le.address_verification.address_history_1.naprop;
	add2_mortgage_date               := le.address_verification.address_history_1.mortgage_date;
	add2_mortgage_type               := le.address_verification.address_history_1.mortgage_type;
	add3_avm_automated_valuation     := le.avm.address_history_2.avm_automated_valuation;
	addrs_10yr                       := le.other_address_info.addrs_last_10years;
	addrs_prison_history             := le.other_address_info.isprison;
	unique_addr_count                := le.address_history_summary.unique_addr_cnt;
	header_first_seen                := le.ssn_verification.header_first_seen;
	ssns_per_adl                     := le.velocity_counters.ssns_per_adl;
	adls_per_addr                    := le.velocity_counters.adls_per_addr;
	inq_highriskcredit_count12       := le.acc_logs.highriskcredit.count12;
	inq_communications_count12       := le.acc_logs.communications.count12;
	inq_other_count12                := le.acc_logs.other.count12;
	inq_addrsperadl                  := le.acc_logs.inquiryaddrsperadl;
	inq_adlsperaddr                  := le.acc_logs.inquiryadlsperaddr;
	paw_first_seen                   := le.employment.first_seen_date;
	paw_dead_business_count          := le.employment.dead_business_ct;
	paw_active_phone_count           := le.employment.business_active_phone_ct;
	infutor_first_seen               := le.infutor_phone.infutor_date_first_seen;
	infutor_last_seen                := le.infutor_phone.infutor_date_last_seen;
	infutor_nap                      := le.infutor_phone.infutor_nap;
	attr_eviction_count              := le.bjl.eviction_count;
	bankrupt                         := le.bjl.bankrupt;
	disposition                      := le.bjl.disposition;
	filing_count                     := le.bjl.filing_count;
	bk_recent_count                  := le.bjl.bk_recent_count;
	liens_recent_unreleased_count    := le.bjl.liens_recent_unreleased_count;
	liens_historical_unreleased_ct   := le.bjl.liens_historical_unreleased_count;
	criminal_count                   := le.bjl.criminal_count;
	felony_count                     := le.bjl.felony_count;
	ams_class                        := le.student.class;
	ams_college_code                 := le.student.college_code;
	ams_college_type                 := le.student.college_type;
	ams_income_level_code            := le.student.income_level_code;
	ams_file_type                    := le.student.file_type2;
	ams_college_tier                 := le.student.college_tier;
	ams_college_major                := le.student.college_major;
	prof_license_flag                := le.professional_license.professional_license_flag;


 //*************************************************************
 //*                    Generated ECL                          *
 //************************************************************* 

NULL := -999999999;


INTEGER contains_i( string haystack, string needle ) := (INTEGER)(StringLib.StringFind(haystack, needle, 1) > 0);


BOOLEAN indexw(string source, string target, string delim) :=
	(source = target) OR
	(StringLib.StringFind(source, delim + target + delim, 1) > 0) OR
	(source[1..length(target)+1] = target + delim) OR
	(StringLib.StringReverse(source)[1..length(target)+1] = StringLib.StringReverse(target) + delim);

sysdate := common.sas_date(if(le.historydate=999999, (string8)Std.Date.Today(), (string6)le.historydate+'01'));

// iv_add_apt := if(StringLib.StringToUpperCase(trim(rc_dwelltype, LEFT, RIGHT)) = 'A' or StringLib.StringToUpperCase(trim(out_addr_type, LEFT, RIGHT)) = 'H' or not((INTEGER)out_unit_desig = NULL) or not((INTEGER)out_sec_range = NULL), '1', '0');
iv_add_apt := if(StringLib.StringToUpperCase(trim(rc_dwelltype, LEFT, RIGHT)) = 'A' or StringLib.StringToUpperCase(trim(out_addr_type, LEFT, RIGHT)) = 'H' or not(out_unit_desig = '') or not(out_sec_range = ''), '1', '0');

iv_va040_add_prison_hist := if(not(truedid), NULL, (integer)addrs_prison_history);

iv_db001_bankruptcy := map(
	    not(truedid or ssnlength > '0')                                                                                               => '                 ',
	    (disposition in ['Discharge NA', 'Discharged'])                                                                             => '1 - BK Discharged',
	    (disposition in ['Dismissed'])                                                                                              => '2 - BK Dismissed ',
	    (rc_bansflag in ['1', '2']) or (INTEGER)bankrupt = 1 or contains_i(ver_sources, 'BA') > 0 or filing_count > 0 or bk_recent_count > 0 => '3 - BK Other     ',
	                                                                                                                                   '0 - No BK        ');




_header_first_seen_1 := common.sas_date((string)(header_first_seen));

iv_sr001_m_hdr_fs_1 := map(
    not(truedid)                     => NULL,
    not(_header_first_seen_1 = NULL) => if ((sysdate - _header_first_seen_1) / (365.25 / 12) >= 0, truncate((sysdate - _header_first_seen_1) / (365.25 / 12)), roundup((sysdate - _header_first_seen_1) / (365.25 / 12))),
                                        -1);

// bureau_adl_vo_fseen_pos := Models.Common.findw_cpp(ver_sources, 'VO' , ", ", "E");
bureau_adl_vo_fseen_pos := Models.Common.findw_cpp(ver_sources, 'VO' , ', ', 'E');

bureau_adl_fseen_vo := if(bureau_adl_vo_fseen_pos = 0, '       0', Models.Common.getw(ver_sources_first_seen, bureau_adl_vo_fseen_pos, ','));

_bureau_adl_fseen_vo := common.sas_date((string)(bureau_adl_fseen_vo));

_src_bureau_adl_fseen := _bureau_adl_fseen_vo;

mth_ver_src_fdate_vo := map(
    not(truedid)                 => NULL,
    _src_bureau_adl_fseen = NULL => -1,
                                    if ((sysdate - _src_bureau_adl_fseen) / (365.25 / 12) >= 0, truncate((sysdate - _src_bureau_adl_fseen) / (365.25 / 12)), roundup((sysdate - _src_bureau_adl_fseen) / (365.25 / 12))));

// bureau_adl_vo_lseen_pos := Models.Common.findw_cpp(ver_sources, 'VO' , ", ", "E");
bureau_adl_vo_lseen_pos := Models.Common.findw_cpp(ver_sources, 'VO' , ', ', 'E');

bureau_adl_lseen_vo := if(bureau_adl_vo_lseen_pos = 0, '       0', Models.Common.getw(ver_sources_last_seen, bureau_adl_vo_lseen_pos, ','));

_bureau_adl_lseen_vo := common.sas_date((string)(bureau_adl_lseen_vo));

_src_bureau_adl_lseen_2 := _bureau_adl_lseen_vo;

mth_ver_src_ldate_vo := map(
    not(truedid)                   => NULL,
    _src_bureau_adl_lseen_2 = NULL => -1,
                                      if ((sysdate - _src_bureau_adl_lseen_2) / (365.25 / 12) >= 0, truncate((sysdate - _src_bureau_adl_lseen_2) / (365.25 / 12)), roundup((sysdate - _src_bureau_adl_lseen_2) / (365.25 / 12))));

mth_ver_src_fdate_vo60 := mth_ver_src_fdate_vo > 60;

mth_ver_src_ldate_vo0 := mth_ver_src_ldate_vo = 0;

// bureau_adl_w_lseen_pos := Models.Common.findw_cpp(ver_sources, 'W' , ", ", "E");
bureau_adl_w_lseen_pos := Models.Common.findw_cpp(ver_sources, 'W' , ', ', 'E');

bureau_adl_lseen_w := if(bureau_adl_w_lseen_pos = 0, '       0', Models.Common.getw(ver_sources_last_seen, bureau_adl_w_lseen_pos, ','));

_bureau_adl_lseen_w := common.sas_date((string)(bureau_adl_lseen_w));

_src_bureau_adl_lseen_1 := _bureau_adl_lseen_w;

mth_ver_src_ldate_w := map(
    not(truedid)                   => NULL,
    _src_bureau_adl_lseen_1 = NULL => -1,
                                      if ((sysdate - _src_bureau_adl_lseen_1) / (365.25 / 12) >= 0, truncate((sysdate - _src_bureau_adl_lseen_1) / (365.25 / 12)), roundup((sysdate - _src_bureau_adl_lseen_1) / (365.25 / 12))));

mth_ver_src_ldate_w0 := mth_ver_src_ldate_w = 0;

// bureau_adl_wp_lseen_pos := Models.Common.findw_cpp(ver_sources, 'WP' , ", ", "E");
bureau_adl_wp_lseen_pos := Models.Common.findw_cpp(ver_sources, 'WP' , ', ', 'E');

bureau_adl_lseen_wp := if(bureau_adl_wp_lseen_pos = 0, '       0', Models.Common.getw(ver_sources_last_seen, bureau_adl_wp_lseen_pos, ','));

_bureau_adl_lseen_wp := common.sas_date((string)(bureau_adl_lseen_wp));

_src_bureau_adl_lseen := _bureau_adl_lseen_wp;

mth_ver_src_ldate_wp := map(
    not(truedid)                 => NULL,
    _src_bureau_adl_lseen = NULL => -1,
                                    if ((sysdate - _src_bureau_adl_lseen) / (365.25 / 12) >= 0, truncate((sysdate - _src_bureau_adl_lseen) / (365.25 / 12)), roundup((sysdate - _src_bureau_adl_lseen) / (365.25 / 12))));

mth_ver_src_ldate_wp0 := mth_ver_src_ldate_wp = 0;

_paw_first_seen := common.sas_date((string)(PAW_first_seen));

mth_paw_first_seen := map(
    not(truedid)           => NULL,
    _paw_first_seen = NULL => -1,
                              if ((sysdate - _paw_first_seen) / (365.25 / 12) >= 0, truncate((sysdate - _paw_first_seen) / (365.25 / 12)), roundup((sysdate - _paw_first_seen) / (365.25 / 12))));

mth_paw_first_seen2 := if(mth_paw_first_seen = NULL or mth_paw_first_seen < 6, 6, min(360, if(mth_paw_first_seen = NULL, -NULL, mth_paw_first_seen)));

ver_src_am := Models.Common.findw_cpp(ver_sources, 'AM' , ', ', 'E') > 0;

ver_src_e1 := Models.Common.findw_cpp(ver_sources, 'E1' , ', ', 'E') > 0;

ver_src_e2 := Models.Common.findw_cpp(ver_sources, 'E2' , ', ', 'E') > 0;

ver_src_e3 := Models.Common.findw_cpp(ver_sources, 'E3' , ', ', 'E') > 0;

ver_src_pl := Models.Common.findw_cpp(ver_sources, 'PL' , ', ', 'E') > 0;

ver_src_w := Models.Common.findw_cpp(ver_sources, 'W' , ', ', 'E') > 0;

paw_dead_business_count_gt3 := paw_dead_business_count > 3;

paw_active_phone_count_0 := paw_active_phone_count <= 0;

_infutor_first_seen := common.sas_date((string)(infutor_first_seen));

mth_infutor_first_seen := map(
    not(truedid)               => NULL,
    _infutor_first_seen = NULL => NULL,
                                  if ((sysdate - _infutor_first_seen) / (365.25 / 12) >= 0, truncate((sysdate - _infutor_first_seen) / (365.25 / 12)), roundup((sysdate - _infutor_first_seen) / (365.25 / 12))));

_infutor_last_seen := common.sas_date((string)(infutor_last_seen));

mth_infutor_last_seen := map(
    not(truedid)              => NULL,
    _infutor_last_seen = NULL => NULL,
                                 if ((sysdate - _infutor_last_seen) / (365.25 / 12) >= 0, truncate((sysdate - _infutor_last_seen) / (365.25 / 12)), roundup((sysdate - _infutor_last_seen) / (365.25 / 12))));

infutor_i := map(
    infutor_nap = 12 and (mth_infutor_first_seen >= 36 or mth_infutor_last_seen = 0) => 1,
    infutor_nap = 12                                                                 => 4,
    infutor_nap = 11 and (mth_infutor_first_seen >= 36 or mth_infutor_last_seen = 0) => 3,
    infutor_nap = 11                                                                 => 5,
    infutor_nap >= 7 and (mth_infutor_first_seen >= 36 or mth_infutor_last_seen = 0) => 6,
    infutor_nap >= 7                                                                 => 7,
    (infutor_nap in [1, 6])                                                          => 8,
    (infutor_nap in [0])                                                             => 2,
                                                                                        7);

infutor_im := map(
    infutor_i = 1 => 7.77,
    infutor_i = 2 => 8.06,
    infutor_i = 3 => 8.38,
    infutor_i = 4 => 8.96,
    infutor_i = 5 => 9.35,
    infutor_i = 6 => 10.19,
    infutor_i = 7 => 13.13,
    infutor_i = 8 => 14.77,
                     9.03);

// white_pages_adl_wp_fseen_pos := Models.Common.findw_cpp(ver_sources, 'WP' , ", ", "E");
white_pages_adl_wp_fseen_pos := Models.Common.findw_cpp(ver_sources, 'WP' , ', ', 'E');

white_pages_adl_fseen_wp := if(white_pages_adl_wp_fseen_pos = 0, '       0', Models.Common.getw(ver_sources_first_seen, white_pages_adl_wp_fseen_pos, ','));

_white_pages_adl_fseen_wp := common.sas_date((string)(white_pages_adl_fseen_wp));

_src_white_pages_adl_fseen := _white_pages_adl_fseen_wp;

iv_sr001_m_wp_adl_fs := map(
    not(truedid)                      => NULL,
    _src_white_pages_adl_fseen = NULL => -1,
                                         if ((sysdate - _src_white_pages_adl_fseen) / (365.25 / 12) >= 0, truncate((sysdate - _src_white_pages_adl_fseen) / (365.25 / 12)), roundup((sysdate - _src_white_pages_adl_fseen) / (365.25 / 12))));

src_m_wp_adl_fs := map(
    iv_sr001_m_wp_adl_fs = NULL => -1,
    iv_sr001_m_wp_adl_fs = -1   => 10,
    iv_sr001_m_wp_adl_fs >= 24  => 24,
                                   iv_sr001_m_wp_adl_fs);

_header_first_seen := common.sas_date((string)(header_first_seen));

iv_sr001_m_hdr_fs := map(
    not(truedid)                   => NULL,
    not(_header_first_seen = NULL) => if ((sysdate - _header_first_seen) / (365.25 / 12) >= 0, truncate((sysdate - _header_first_seen) / (365.25 / 12)), roundup((sysdate - _header_first_seen) / (365.25 / 12))),
                                      -1);

src_m_hdr_fs := map(
    iv_sr001_m_hdr_fs = NULL => 15,
    iv_sr001_m_hdr_fs = -1   => 40,
    iv_sr001_m_hdr_fs >= 260 => 260,
                                iv_sr001_m_hdr_fs);

source_mod6_1 := -2.350792319 +
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
    src_m_hdr_fs * -0.004903484;

source_mod6 := exp(source_mod6_1) / (1 + exp(source_mod6_1));

// iv_sr001_source_profile := if(not(truedid), NULL, max((real)0, round(100 - 500 * source_mod6/0.1)*0.1));
source_profile_temp := __common__( (100 - (500 * source_mod6)) ) ;
iv_sr001_source_profile := __common__( if(not(truedid), NULL, max(0, round(source_profile_temp * 10) / 10)) ) ;

iv_ms001_ssns_per_adl := map(
    not(truedid)     => NULL,
    ssns_per_adl = 0 => 1,
                        ssns_per_adl);

iv_pv001_inp_avm_autoval := if(not(add1_pop), NULL, add1_avm_automated_valuation);

iv_pv001_bst_avm_autoval := map(
    not(truedid)     => NULL,
    add1_isbestmatch => add1_avm_automated_valuation,
                        add2_avm_automated_valuation);

// iv_ed001_college_ind := map(
    // not(truedid)                                                                                                                                                          => ' ',
    // not((INTEGER)ams_college_code = NULL) or not((INTEGER)ams_college_type = NULL) or 
    // (integer)ams_college_tier >= 0 or not((INTEGER)ams_college_major = NULL) or (ams_file_type in ['H', 'C', 'A']) => '1',
    // ams_file_type = 'M'                                                                                                                                                   => '0',
    // not((INTEGER)ams_class = NULL) or not((INTEGER)ams_income_level_code = NULL)                                                                                                            => '1',
                                                                                                                                                                             // '0');

iv_ed001_college_ind := map(
    not(truedid)                                                                                                                                                          => ' ',
    not(ams_college_code = '') or not(ams_college_type = '') or (integer)ams_college_tier > 0 or not(ams_college_major = '') or (ams_file_type in ['H', 'C', 'A']) => '1',
    ams_file_type = 'M'                                                                                                                                                   => '0',
    not(ams_class = '') or not(ams_income_level_code = '')                                                                                                            => '1',
                                                                                                                                                                             '0');

// iv_input_addr_not_most_recent := if(not(truedid), NULL, rc_input_addr_not_most_recent);
// iv_input_addr_not_most_recent    := if(not(truedid), (INTEGER)(STRING)'', (integer)rc_input_addr_not_most_recent);
//// iv_input_addr_not_most_recent1 := if(not(truedid), NULL, (integer)rc_input_addr_not_most_recent);
// iv_input_addr_not_most_recent := if(not(truedid), NULL, if(rc_input_addr_not_most_recent, 1, 0));
//// iv_input_addr_not_most_recent := if(iv_input_addr_not_most_recent1 = NULL,0,iv_input_addr_not_most_recent1);
iv_input_addr_not_most_recent := if(not(truedid), ' ', (STRING)(INTEGER)rc_input_addr_not_most_recent);



// prop_adl_p_count_pos := Models.Common.findw_cpp(ver_sources, 'P' , ", ", "E");
prop_adl_p_count_pos := Models.Common.findw_cpp(ver_sources, 'P' , ', ', 'E');

prop_adl_count_p := if(prop_adl_p_count_pos = 0, NULL, (integer)Models.Common.getw(ver_sources_count, prop_adl_p_count_pos, ','));

_src_prop_adl_count := max(prop_adl_count_p, (real)0);

iv_src_property_adl_count := map(
    not(truedid)               => NULL,
    _src_prop_adl_count = NULL => -1,
                                  _src_prop_adl_count);

// iv_bst_addr_naprop := map(
    // not(truedid)     => ' ',
    // add1_isbestmatch => add1_naprop,
                        // add2_naprop);
iv_bst_addr_naprop := map(
    not(truedid)     => ' ',
    add1_isbestmatch => (string)add1_naprop,
                        (string)add2_naprop);                        

// mortgage_present := if(add1_isbestmatch, not((add1_mortgage_date in ['0', ' '])), not((add2_mortgage_date in ['0', ' '])));
mortgage_present := if(add1_isbestmatch, not((add1_mortgage_date in [0, NULL])), not((add2_mortgage_date in [0, NULL])));

mortgage_type := if(add1_isbestmatch, add1_mortgage_type, add2_mortgage_type);

// iv_bst_addr_mortgage_type := map(
    // not(truedid)                                          => '               ',
    // (mortgage_type in ['CNV', 'N'])                       => 'Conventional   ',
    // (mortgage_type in ['FHA', 'G', 'VA'])                 => 'Government     ',
    // (mortgage_type in ['1', 'D'])                         => 'Piggyback      ',
    // (mortgage_type in ['2', 'E', 'R', 'C'])               => 'Equity Loan    ',
    // (mortgage_type in ['I', 'K', 'O', 'LHM', 'T', 'SBA']) => 'Commercial     ',
    // (mortgage_type in ['H', 'J'])                         => 'High-Risk      ',
    // (mortgage_type in ['PMM', 'PP', 'S', 'L'])            => 'Non-Traditional',
    // (mortgage_type in ['U'])                              => 'Unknown        ',
    // not(mortgage_type = NULL)                             => 'Other          ',
    // mortgage_present                                      => 'Unknown        ',
                                                             // 'No Mortgage');
iv_bst_addr_mortgage_type := map(
    not(truedid)                                          => '               ',
    (mortgage_type in ['CNV', 'N'])                       => 'Conventional   ',
    (mortgage_type in ['FHA', 'G', 'VA'])                 => 'Government     ',
    (mortgage_type in ['1', 'D'])                         => 'Piggyback      ',
    (mortgage_type in ['2', 'E', 'R', 'C'])               => 'Equity Loan    ',
    (mortgage_type in ['I', 'K', 'O', 'LHM', 'T', 'SBA']) => 'Commercial     ',
    (mortgage_type in ['H', 'J'])                         => 'High-Risk      ',
    (mortgage_type in ['PMM', 'PP', 'S', 'L'])            => 'Non-Traditional',
    (mortgage_type in ['U'])                              => 'Unknown        ',
    not(mortgage_type = '')                             => 'Other          ',
    mortgage_present                                      => 'Unknown        ',
                                                             'No Mortgage');


iv_prv_addr_avm_auto_val := map(
    not(truedid)     => NULL,
    add1_isbestmatch => add2_avm_automated_valuation,
                        add3_avm_automated_valuation);

iv_addrs_10yr := map(
    not(truedid)          => NULL,
    unique_addr_count = 0 => -1,
                             addrs_10yr);

iv_adls_per_sfd_addr := map(
    not(add1_pop)    => NULL,
    iv_add_apt = '1' => -1,
                        adls_per_addr);

iv_inq_highriskcredit_count12 := if(not(truedid), NULL, inq_highRiskCredit_count12);

iv_inq_communications_count12 := if(not(truedid), NULL, inq_communications_count12);

iv_inq_other_count12 := if(not(truedid), NULL, inq_other_count12);

iv_inq_addrs_per_adl := if(not(truedid), NULL, inq_addrsperadl);

iv_inq_adls_per_addr := if(not(add1_pop), NULL, inq_adlsperaddr);

iv_eviction_count := if(not(truedid), NULL, attr_eviction_count);

iv_unreleased_liens_ct := if(not(truedid), NULL, if(max(liens_recent_unreleased_count, liens_historical_unreleased_ct) = NULL, NULL, sum(if(liens_recent_unreleased_count = NULL, 0, liens_recent_unreleased_count), if(liens_historical_unreleased_ct = NULL, 0, liens_historical_unreleased_ct))));

// iv_criminal_x_felony := if(not(truedid), '   ', (string)min(if(criminal_count = NULL, -NULL, criminal_count), 3) || ' - ' || (string)min(if(felony_count = NULL, -NULL, felony_count), 3));
iv_criminal_x_felony := if(not(truedid), '   ', (string)min(if(criminal_count = NULL, -NULL, criminal_count), 3) + '-' + (string)min(if(felony_count = NULL, -NULL, felony_count), 3));

 // iv_prof_license_flag := if(not(truedid), NULL, prof_license_flag);
// iv_prof_license_flag    := if(not(truedid), '', (STRING)prof_license_flag);
//// iv_prof_license_flag1 := if(not(truedid), NULL, (integer)prof_license_flag);
 // iv_prof_license_flag    := if(not(truedid), (INTEGER)(STRING)0, (integer)prof_license_flag);
// iv_prof_license_flag := if(not(truedid), NULL, if(prof_license_flag, 1, 0));
////iv_prof_license_flag := if(iv_prof_license_flag1 = NULL,0,iv_prof_license_flag1);
	iv_prof_license_flag := if(not(truedid), ' ', (STRING)(INTEGER)prof_license_flag);
  
  

o_subscore0 := map(
    NULL < iv_src_property_adl_count AND iv_src_property_adl_count < 1 => -0.163551,
    1 <= iv_src_property_adl_count AND iv_src_property_adl_count < 2   => 0.164417,
    2 <= iv_src_property_adl_count AND iv_src_property_adl_count < 3   => 0.31376,
    3 <= iv_src_property_adl_count AND iv_src_property_adl_count < 4   => 0.412722,
    4 <= iv_src_property_adl_count AND iv_src_property_adl_count < 5   => 0.460265,
    5 <= iv_src_property_adl_count                                     => 0.625396,
                                                                          0);

o_subscore1 := map(
    NULL < iv_sr001_source_profile AND iv_sr001_source_profile < 76.7  => -0.104206,
    76.7 <= iv_sr001_source_profile AND iv_sr001_source_profile < 81.6 => 0.132946,
    81.6 <= iv_sr001_source_profile AND iv_sr001_source_profile < 83.4 => 0.233775,
    83.4 <= iv_sr001_source_profile AND iv_sr001_source_profile < 85.6 => 0.384147,
    85.6 <= iv_sr001_source_profile AND iv_sr001_source_profile < 87.7 => 0.386219,
    87.7 <= iv_sr001_source_profile AND iv_sr001_source_profile < 89.2 => 0.455434,
    89.2 <= iv_sr001_source_profile                                    => 0.655823,
                                                                          0);

o_subscore2 := map(
    NULL < iv_inq_adls_per_addr AND iv_inq_adls_per_addr < 1 => 0.121244,
    1 <= iv_inq_adls_per_addr AND iv_inq_adls_per_addr < 2   => -0.149243,
    2 <= iv_inq_adls_per_addr AND iv_inq_adls_per_addr < 3   => -0.195316,
    3 <= iv_inq_adls_per_addr                                => -0.39338,
                                                                0);

o_subscore3 := map(
    NULL < iv_inq_addrs_per_adl AND iv_inq_addrs_per_adl < 1 => 0.138493,
    1 <= iv_inq_addrs_per_adl AND iv_inq_addrs_per_adl < 2   => -0.062304,
    2 <= iv_inq_addrs_per_adl AND iv_inq_addrs_per_adl < 3   => -0.216781,
    3 <= iv_inq_addrs_per_adl AND iv_inq_addrs_per_adl < 4   => -0.307882,
    4 <= iv_inq_addrs_per_adl                                => -0.376953,
                                                                0);

o_subscore4 := map(
    NULL < iv_sr001_m_hdr_fs AND iv_sr001_m_hdr_fs < 0   => 0,
    0 <= iv_sr001_m_hdr_fs AND iv_sr001_m_hdr_fs < 225   => -0.078057,
    225 <= iv_sr001_m_hdr_fs AND iv_sr001_m_hdr_fs < 261 => -0.07803,
    261 <= iv_sr001_m_hdr_fs AND iv_sr001_m_hdr_fs < 300 => -0.07789,
    300 <= iv_sr001_m_hdr_fs AND iv_sr001_m_hdr_fs < 311 => -0.076723,
    311 <= iv_sr001_m_hdr_fs AND iv_sr001_m_hdr_fs < 321 => 0.121215,
    321 <= iv_sr001_m_hdr_fs AND iv_sr001_m_hdr_fs < 338 => 0.189857,
    338 <= iv_sr001_m_hdr_fs AND iv_sr001_m_hdr_fs < 353 => 0.276193,
    353 <= iv_sr001_m_hdr_fs AND iv_sr001_m_hdr_fs < 398 => 0.43954,
    398 <= iv_sr001_m_hdr_fs                             => 0.44398,
                                                            0);

o_subscore5 := map(
    NULL < iv_unreleased_liens_ct AND iv_unreleased_liens_ct < 1 => 0.093466,
    1 <= iv_unreleased_liens_ct AND iv_unreleased_liens_ct < 2   => -0.206249,
    2 <= iv_unreleased_liens_ct AND iv_unreleased_liens_ct < 3   => -0.208783,
    3 <= iv_unreleased_liens_ct                                  => -0.335236,
                                                                    0);

o_subscore6 := map(
    NULL < iv_addrs_10yr AND iv_addrs_10yr < 0 => 0.037235,
    0 <= iv_addrs_10yr AND iv_addrs_10yr < 1   => 0.336626,
    1 <= iv_addrs_10yr AND iv_addrs_10yr < 2   => 0.099741,
    2 <= iv_addrs_10yr AND iv_addrs_10yr < 3   => -0.060743,
    3 <= iv_addrs_10yr AND iv_addrs_10yr < 5   => -0.062352,
    5 <= iv_addrs_10yr AND iv_addrs_10yr < 6   => -0.132459,
    6 <= iv_addrs_10yr AND iv_addrs_10yr < 8   => -0.136868,
    8 <= iv_addrs_10yr AND iv_addrs_10yr < 9   => -0.166022,
    9 <= iv_addrs_10yr                         => -0.230181,
                                                  0);

o_subscore7 := map(
    NULL < iv_pv001_inp_avm_autoval AND iv_pv001_inp_avm_autoval < 1         => -0.052705,
    1 <= iv_pv001_inp_avm_autoval AND iv_pv001_inp_avm_autoval < 19825       => -0.283932,
    19825 <= iv_pv001_inp_avm_autoval AND iv_pv001_inp_avm_autoval < 53166   => -0.098117,
    53166 <= iv_pv001_inp_avm_autoval AND iv_pv001_inp_avm_autoval < 70096   => 0.014316,
    70096 <= iv_pv001_inp_avm_autoval AND iv_pv001_inp_avm_autoval < 113859  => 0.067161,
    113859 <= iv_pv001_inp_avm_autoval AND iv_pv001_inp_avm_autoval < 157803 => 0.133652,
    157803 <= iv_pv001_inp_avm_autoval AND iv_pv001_inp_avm_autoval < 232097 => 0.296647,
    232097 <= iv_pv001_inp_avm_autoval                                       => 0.32492,
                                                                                0);

o_subscore8 := map(
    (iv_bst_addr_naprop in [' '])      => 0,
    (iv_bst_addr_naprop in ['1'])      => -0.110899,
    (iv_bst_addr_naprop in ['0', '2']) => -0.027979,
    (iv_bst_addr_naprop in ['3'])      => 0.135942,
    (iv_bst_addr_naprop in ['4'])      => 0.263711,
                                          0);

o_subscore9 := map(
    NULL < iv_inq_highriskcredit_count12 AND iv_inq_highriskcredit_count12 < 1 => 0.045169,
    1 <= iv_inq_highriskcredit_count12                                         => -0.424223,
                                                                                  0);

o_subscore10 := map(
    NULL < iv_adls_per_sfd_addr AND iv_adls_per_sfd_addr < 0 => -0.052027,
    0 <= iv_adls_per_sfd_addr AND iv_adls_per_sfd_addr < 2   => -0.053285,
    2 <= iv_adls_per_sfd_addr AND iv_adls_per_sfd_addr < 6   => 0.251167,
    6 <= iv_adls_per_sfd_addr AND iv_adls_per_sfd_addr < 7   => 0.189164,
    7 <= iv_adls_per_sfd_addr AND iv_adls_per_sfd_addr < 10  => 0.175718,
    10 <= iv_adls_per_sfd_addr AND iv_adls_per_sfd_addr < 12 => 0.041345,
    12 <= iv_adls_per_sfd_addr AND iv_adls_per_sfd_addr < 17 => 0.03953,
    17 <= iv_adls_per_sfd_addr AND iv_adls_per_sfd_addr < 21 => -0.089743,
    21 <= iv_adls_per_sfd_addr AND iv_adls_per_sfd_addr < 33 => -0.093738,
    33 <= iv_adls_per_sfd_addr                               => -0.222744,
                                                                0);

o_subscore11 := map(
    (iv_criminal_x_felony in [' '])                                      => 0,
    (iv_criminal_x_felony in ['0-0'])                                    => 0.035752,
    (iv_criminal_x_felony in ['1-0'])                                    => -0.263306,
    (iv_criminal_x_felony in ['2-0', '3-0'])                             => -0.53774,
    (iv_criminal_x_felony in ['1-1', '2-1', '2-2', '3-1', '3-2', '3-3']) => -0.663749,
                                                                            0);

o_subscore12 := map(
    NULL < iv_prv_addr_avm_auto_val AND iv_prv_addr_avm_auto_val < 1        => 0.017602,
    1 <= iv_prv_addr_avm_auto_val AND iv_prv_addr_avm_auto_val < 13205      => -0.385427,
    13205 <= iv_prv_addr_avm_auto_val AND iv_prv_addr_avm_auto_val < 38699  => -0.196918,
    38699 <= iv_prv_addr_avm_auto_val AND iv_prv_addr_avm_auto_val < 62342  => -0.108911,
    62342 <= iv_prv_addr_avm_auto_val AND iv_prv_addr_avm_auto_val < 98085  => 0.042367,
    98085 <= iv_prv_addr_avm_auto_val AND iv_prv_addr_avm_auto_val < 192099 => 0.090419,
    192099 <= iv_prv_addr_avm_auto_val                                      => 0.253403,
                                                                               0);

o_subscore13 := map(
    (iv_ed001_college_ind in [' ']) => 0,
    (iv_ed001_college_ind in ['0']) => -0.042434,
    (iv_ed001_college_ind in ['1']) => 0.293109,
                                       0);

o_subscore14 := map(
    // (TRIM(TRIM((STRING)iv_input_addr_not_most_recent,LEFT),RIGHT) in ['']) => 0, // AJ
    (iv_input_addr_not_most_recent in ['0']) => 0.053466,  //Chad
    (iv_input_addr_not_most_recent in ['1']) => -0.189011,
                                                0);
// o_subscore14 := map(
    // ((STRING)iv_input_addr_not_most_recent in [' ']) => 0,
    // (iv_input_addr_not_most_recent in [NULL]) => 0,
    // ((STRING)iv_input_addr_not_most_recent in ['0']) => 0.053466,
    // ((STRING)iv_input_addr_not_most_recent in ['1']) => -0.189011,
                                                // 0);

o_subscore15 := map(
    NULL < iv_pv001_bst_avm_autoval AND iv_pv001_bst_avm_autoval < 1         => 0.004241,
    1 <= iv_pv001_bst_avm_autoval AND iv_pv001_bst_avm_autoval < 26799       => -0.166521,
    26799 <= iv_pv001_bst_avm_autoval AND iv_pv001_bst_avm_autoval < 40320   => -0.076654,
    40320 <= iv_pv001_bst_avm_autoval AND iv_pv001_bst_avm_autoval < 70278   => -0.072986,
    70278 <= iv_pv001_bst_avm_autoval AND iv_pv001_bst_avm_autoval < 96426   => -0.04742,
    96426 <= iv_pv001_bst_avm_autoval AND iv_pv001_bst_avm_autoval < 167043  => 0.072123,
    167043 <= iv_pv001_bst_avm_autoval AND iv_pv001_bst_avm_autoval < 242033 => 0.096962,
    242033 <= iv_pv001_bst_avm_autoval                                       => 0.299037,
                                                                                0);

o_subscore16 := map(
    NULL < iv_ms001_ssns_per_adl AND iv_ms001_ssns_per_adl < 2 => 0.04166,
    2 <= iv_ms001_ssns_per_adl AND iv_ms001_ssns_per_adl < 3   => -0.1306,
    3 <= iv_ms001_ssns_per_adl AND iv_ms001_ssns_per_adl < 4   => -0.26923,
    4 <= iv_ms001_ssns_per_adl                                 => -0.431102,
                                                                  0);

o_subscore17 := map(
    NULL < iv_eviction_count AND iv_eviction_count < 1 => 0.029495,
    1 <= iv_eviction_count AND iv_eviction_count < 2   => -0.161212,
    2 <= iv_eviction_count AND iv_eviction_count < 3   => -0.219266,
    3 <= iv_eviction_count                             => -0.245545,
                                                          0);

o_subscore18 := map(
    NULL < iv_inq_communications_count12 AND iv_inq_communications_count12 < 1 => 0.019662,
    1 <= iv_inq_communications_count12                                         => -0.282041,
                                                                                  0);

o_subscore19 := map(
    (iv_bst_addr_mortgage_type in [' '])                                                                                                                       => 0,
    (iv_bst_addr_mortgage_type in ['Conventional'])                                                                                                            => 0.205288,
    (iv_bst_addr_mortgage_type in ['Commercial', 'Equity Loan', 'Government', 'High-Risk', 'No Mortgage', 'Non-Traditional', 'Other', 'Piggyback', 'Unknown']) => -0.01357,
                                                                                                                                                                  0);

o_subscore20 := map(
    NULL < iv_va040_add_prison_hist AND iv_va040_add_prison_hist < 1 => 0.00603,
    1 <= iv_va040_add_prison_hist                                    => -0.479928,
                                                                        0);

o_subscore21 := map(
    (iv_db001_bankruptcy in [' '])                                              => 0,
    (iv_db001_bankruptcy in ['0 - No BK', '1 - BK Discharged', '3 - BK Other']) => 0.004035,
    (iv_db001_bankruptcy in ['2 - BK Dismissed'])                               => -0.483838,
                                                                                   0);

o_subscore22 := map(
    // (iv_prof_license_flag in [NULL]) => 0, //AJ
    (iv_prof_license_flag in ['0']) => -0.010246, //CHAD
    (iv_prof_license_flag in ['1']) => 0.207157,
                                       0);

// o_subscore22 := map(
    // (iv_prof_license_flag in [' ']) => 0,
    // (iv_prof_license_flag in ['0']) => -0.010246,
    // (iv_prof_license_flag in ['1']) => 0.207157,
                                       // 0);

// o_subscore22 := map(
    // (TRIM(TRIM((STRING)iv_prof_license_flag,LEFT),RIGHT) in ['']) => 0,
    // (iv_prof_license_flag in [0]) => -0.010246,
    // (iv_prof_license_flag in [1]) => 0.207157,
                                       // 0);


o_subscore23 := map(
    NULL < iv_inq_other_count12 AND iv_inq_other_count12 < 1 => 0.007036,
    1 <= iv_inq_other_count12                                => -0.137272,
                                                                0);

o_rawscore := o_subscore0 +
    o_subscore1 +
    o_subscore2 +
    o_subscore3 +
    o_subscore4 +
    o_subscore5 +
    o_subscore6 +
    o_subscore7 +
    o_subscore8 +
    o_subscore9 +
    o_subscore10 +
    o_subscore11 +
    o_subscore12 +
    o_subscore13 +
    o_subscore14 +
    o_subscore15 +
    o_subscore16 +
    o_subscore17 +
    o_subscore18 +
    o_subscore19 +
    o_subscore20 +
    o_subscore21 +
    o_subscore22 +
    o_subscore23;

o_lnoddsscore := o_rawscore + 2.411134;

o_probscore := exp(o_lnoddsscore) / (1 + exp(o_lnoddsscore));

o_aacd_0 := map(
    NULL < iv_src_property_adl_count AND iv_src_property_adl_count < 1 => '9A',
    1 <= iv_src_property_adl_count AND iv_src_property_adl_count < 2   => '',
    2 <= iv_src_property_adl_count AND iv_src_property_adl_count < 3   => '',
    3 <= iv_src_property_adl_count AND iv_src_property_adl_count < 4   => '',
    4 <= iv_src_property_adl_count AND iv_src_property_adl_count < 5   => '',
    5 <= iv_src_property_adl_count                                     => '',
                                                                          '');

o_dist_0 := o_subscore0 - 0.625396;

o_aacd_1 := map(
    NULL < iv_sr001_source_profile AND iv_sr001_source_profile < 76.7  => '36',
    76.7 <= iv_sr001_source_profile AND iv_sr001_source_profile < 81.6 => '36',
    81.6 <= iv_sr001_source_profile AND iv_sr001_source_profile < 83.4 => '36',
    83.4 <= iv_sr001_source_profile AND iv_sr001_source_profile < 85.6 => '36',
    85.6 <= iv_sr001_source_profile AND iv_sr001_source_profile < 87.7 => '36',
    87.7 <= iv_sr001_source_profile AND iv_sr001_source_profile < 89.2 => '36',
    89.2 <= iv_sr001_source_profile                                    => '36',
                                                                          '');

o_dist_1 := o_subscore1 - 0.655823;

o_aacd_2 := map(
    NULL < iv_inq_adls_per_addr AND iv_inq_adls_per_addr < 1 => '9Q',
    1 <= iv_inq_adls_per_addr AND iv_inq_adls_per_addr < 2   => '9Q',
    2 <= iv_inq_adls_per_addr AND iv_inq_adls_per_addr < 3   => '9Q',
    3 <= iv_inq_adls_per_addr                                => '9Q',
                                                                '');

o_dist_2 := o_subscore2 - 0.121244;

o_aacd_3 := map(
    NULL < iv_inq_addrs_per_adl AND iv_inq_addrs_per_adl < 1 => '9Q',
    1 <= iv_inq_addrs_per_adl AND iv_inq_addrs_per_adl < 2   => '9Q',
    2 <= iv_inq_addrs_per_adl AND iv_inq_addrs_per_adl < 3   => '9Q',
    3 <= iv_inq_addrs_per_adl AND iv_inq_addrs_per_adl < 4   => '9Q',
    4 <= iv_inq_addrs_per_adl                                => '9Q',
                                                                '');

o_dist_3 := o_subscore3 - 0.138493;

o_aacd_4 := map(
    NULL < iv_sr001_m_hdr_fs AND iv_sr001_m_hdr_fs < 0   => '9J',
    0 <= iv_sr001_m_hdr_fs AND iv_sr001_m_hdr_fs < 225   => '9J',
    225 <= iv_sr001_m_hdr_fs AND iv_sr001_m_hdr_fs < 261 => '9J',
    261 <= iv_sr001_m_hdr_fs AND iv_sr001_m_hdr_fs < 300 => '9J',
    300 <= iv_sr001_m_hdr_fs AND iv_sr001_m_hdr_fs < 311 => '9J',
    311 <= iv_sr001_m_hdr_fs AND iv_sr001_m_hdr_fs < 321 => '9J',
    321 <= iv_sr001_m_hdr_fs AND iv_sr001_m_hdr_fs < 338 => '9J',
    338 <= iv_sr001_m_hdr_fs AND iv_sr001_m_hdr_fs < 353 => '9J',
    353 <= iv_sr001_m_hdr_fs AND iv_sr001_m_hdr_fs < 398 => '9J',
    398 <= iv_sr001_m_hdr_fs                             => '9J',
                                                            '');

o_dist_4 := o_subscore4 - 0.44398;

o_aacd_5 := map(
    NULL < iv_unreleased_liens_ct AND iv_unreleased_liens_ct < 1 => '98',
    1 <= iv_unreleased_liens_ct AND iv_unreleased_liens_ct < 2   => '98',
    2 <= iv_unreleased_liens_ct AND iv_unreleased_liens_ct < 3   => '98',
    3 <= iv_unreleased_liens_ct                                  => '98',
                                                                    '');

o_dist_5 := o_subscore5 - 0.093466;

o_aacd_6 := map(
    NULL < iv_addrs_10yr AND iv_addrs_10yr < 0 => '',
    0 <= iv_addrs_10yr AND iv_addrs_10yr < 1   => '9D',
    1 <= iv_addrs_10yr AND iv_addrs_10yr < 2   => '9D',
    2 <= iv_addrs_10yr AND iv_addrs_10yr < 3   => '9D',
    3 <= iv_addrs_10yr AND iv_addrs_10yr < 5   => '9D',
    5 <= iv_addrs_10yr AND iv_addrs_10yr < 6   => '9D',
    6 <= iv_addrs_10yr AND iv_addrs_10yr < 8   => '9D',
    8 <= iv_addrs_10yr AND iv_addrs_10yr < 9   => '9D',
    9 <= iv_addrs_10yr                         => '9D',
                                                  '');

o_dist_6 := o_subscore6 - 0.336626;

o_aacd_7 := map(
    NULL < iv_pv001_inp_avm_autoval AND iv_pv001_inp_avm_autoval < 1         => 'PV',
    1 <= iv_pv001_inp_avm_autoval AND iv_pv001_inp_avm_autoval < 19825       => 'PV',
    19825 <= iv_pv001_inp_avm_autoval AND iv_pv001_inp_avm_autoval < 53166   => 'PV',
    53166 <= iv_pv001_inp_avm_autoval AND iv_pv001_inp_avm_autoval < 70096   => 'PV',
    70096 <= iv_pv001_inp_avm_autoval AND iv_pv001_inp_avm_autoval < 113859  => 'PV',
    113859 <= iv_pv001_inp_avm_autoval AND iv_pv001_inp_avm_autoval < 157803 => 'PV',
    157803 <= iv_pv001_inp_avm_autoval AND iv_pv001_inp_avm_autoval < 232097 => 'PV',
    232097 <= iv_pv001_inp_avm_autoval                                       => 'PV',
                                                                                '');

o_dist_7 := o_subscore7 - 0.32492;

o_aacd_8 := map(
    (iv_bst_addr_naprop in [' '])                                   => '36',
    (iv_bst_addr_naprop in ['1']) and property_owned_total = 0      => '9A',
    (iv_bst_addr_naprop in ['1'])                                   => '',
    (iv_bst_addr_naprop in ['0', '2']) and property_owned_total = 0 => '9A',
    (iv_bst_addr_naprop in ['0', '2'])                              => '',
    (iv_bst_addr_naprop in ['3'])                                   => '',
    (iv_bst_addr_naprop in ['4'])                                   => '',
                                                                       '');

o_dist_8 := o_subscore8 - 0.263711;

o_aacd_9 := map(
    NULL < iv_inq_highriskcredit_count12 AND iv_inq_highriskcredit_count12 < 1 => '9P',
    1 <= iv_inq_highriskcredit_count12                                         => '9P',
                                                                                  '');

o_dist_9 := o_subscore9 - 0.045169;

o_aacd_10 := map(
    NULL < iv_adls_per_sfd_addr AND iv_adls_per_sfd_addr < 0 => '',
    0 <= iv_adls_per_sfd_addr AND iv_adls_per_sfd_addr < 2   => '',
    2 <= iv_adls_per_sfd_addr AND iv_adls_per_sfd_addr < 6   => '',
    6 <= iv_adls_per_sfd_addr AND iv_adls_per_sfd_addr < 7   => '',
    7 <= iv_adls_per_sfd_addr AND iv_adls_per_sfd_addr < 10  => '',
    10 <= iv_adls_per_sfd_addr AND iv_adls_per_sfd_addr < 12 => '',
    12 <= iv_adls_per_sfd_addr AND iv_adls_per_sfd_addr < 17 => '',
    17 <= iv_adls_per_sfd_addr AND iv_adls_per_sfd_addr < 21 => '',
    21 <= iv_adls_per_sfd_addr AND iv_adls_per_sfd_addr < 33 => '',
    33 <= iv_adls_per_sfd_addr                               => '',
                                                                '');

o_dist_10 := o_subscore10 - 0.251167;

o_aacd_11 := map(
    (iv_criminal_x_felony in [' '])                                      => '36',
    (iv_criminal_x_felony in ['0-0'])                                    => '97',
    (iv_criminal_x_felony in ['1-0'])                                    => '97',
    (iv_criminal_x_felony in ['2-0', '3-0'])                             => '97',
    (iv_criminal_x_felony in ['1-1', '2-1', '2-2', '3-1', '3-2', '3-3']) => '97',
                                                                            '');

o_dist_11 := o_subscore11 - 0.035752;

o_aacd_12 := map(
    NULL < iv_prv_addr_avm_auto_val AND iv_prv_addr_avm_auto_val < 1        => 'PV',
    1 <= iv_prv_addr_avm_auto_val AND iv_prv_addr_avm_auto_val < 13205      => 'PV',
    13205 <= iv_prv_addr_avm_auto_val AND iv_prv_addr_avm_auto_val < 38699  => 'PV',
    38699 <= iv_prv_addr_avm_auto_val AND iv_prv_addr_avm_auto_val < 62342  => 'PV',
    62342 <= iv_prv_addr_avm_auto_val AND iv_prv_addr_avm_auto_val < 98085  => 'PV',
    98085 <= iv_prv_addr_avm_auto_val AND iv_prv_addr_avm_auto_val < 192099 => 'PV',
    192099 <= iv_prv_addr_avm_auto_val                                      => 'PV',
                                                                               '');

o_dist_12 := o_subscore12 - 0.253403;

o_aacd_13 := map(
    (iv_ed001_college_ind in [' ']) => '36',
    (iv_ed001_college_ind in ['0']) => '9I',
    (iv_ed001_college_ind in ['1']) => '9I',
                                       '');

o_dist_13 := o_subscore13 - 0.293109;

o_aacd_14 := map(
    ((STRING)iv_input_addr_not_most_recent in [' ']) => '36',
    (iv_input_addr_not_most_recent in ['0']) => '99',
    (iv_input_addr_not_most_recent in ['1']) => '99',
                                                '');
// o_aacd_14 := map(
    // ((STRING)iv_input_addr_not_most_recent in [' ']) => '36',
    // (iv_input_addr_not_most_recent in [NULL]) => '36',
    // ((STRING)iv_input_addr_not_most_recent in ['0']) => '99',
    // ((STRING)iv_input_addr_not_most_recent in ['1']) => '99',
                                                // '');

o_dist_14 := o_subscore14 - 0.053466;

o_aacd_15 := map(
    NULL < iv_pv001_bst_avm_autoval AND iv_pv001_bst_avm_autoval < 1         => 'PV',
    1 <= iv_pv001_bst_avm_autoval AND iv_pv001_bst_avm_autoval < 26799       => 'PV',
    26799 <= iv_pv001_bst_avm_autoval AND iv_pv001_bst_avm_autoval < 40320   => 'PV',
    40320 <= iv_pv001_bst_avm_autoval AND iv_pv001_bst_avm_autoval < 70278   => 'PV',
    70278 <= iv_pv001_bst_avm_autoval AND iv_pv001_bst_avm_autoval < 96426   => 'PV',
    96426 <= iv_pv001_bst_avm_autoval AND iv_pv001_bst_avm_autoval < 167043  => 'PV',
    167043 <= iv_pv001_bst_avm_autoval AND iv_pv001_bst_avm_autoval < 242033 => 'PV',
    242033 <= iv_pv001_bst_avm_autoval                                       => 'PV',
                                                                                '');

o_dist_15 := o_subscore15 - 0.299037;

o_aacd_16 := map(
    NULL < iv_ms001_ssns_per_adl AND iv_ms001_ssns_per_adl < 2 => 'MS',
    2 <= iv_ms001_ssns_per_adl AND iv_ms001_ssns_per_adl < 3   => 'MS',
    3 <= iv_ms001_ssns_per_adl AND iv_ms001_ssns_per_adl < 4   => 'MS',
    4 <= iv_ms001_ssns_per_adl                                 => 'MS',
                                                                  '');

o_dist_16 := o_subscore16 - 0.04166;

o_aacd_17 := map(
    NULL < iv_eviction_count AND iv_eviction_count < 1 => 'EV',
    1 <= iv_eviction_count AND iv_eviction_count < 2   => 'EV',
    2 <= iv_eviction_count AND iv_eviction_count < 3   => 'EV',
    3 <= iv_eviction_count                             => 'EV',
                                                          '');

o_dist_17 := o_subscore17 - 0.029495;

o_aacd_18 := map(
    NULL < iv_inq_communications_count12 AND iv_inq_communications_count12 < 1 => '9Q',
    1 <= iv_inq_communications_count12                                         => '9Q',
                                                                                  '');

o_dist_18 := o_subscore18 - 0.019662;

o_aacd_19 := map(
    (iv_bst_addr_mortgage_type in [' '])                                                                                                                       => '36',
    (iv_bst_addr_mortgage_type in ['Conventional'])                                                                                                            => '',
    (iv_bst_addr_mortgage_type in ['Commercial', 'Equity Loan', 'Government', 'High-Risk', 'No Mortgage', 'Non-Traditional', 'Other', 'Piggyback', 'Unknown']) => '',
                                                                                                                                                                  '');

o_dist_19 := o_subscore19 - 0.205288;

o_aacd_20 := map(
    NULL < iv_va040_add_prison_hist AND iv_va040_add_prison_hist < 1 => '50',
    1 <= iv_va040_add_prison_hist                                    => '50',
                                                                        '');

o_dist_20 := o_subscore20 - 0.00603;

o_aacd_21 := map(
    (iv_db001_bankruptcy in [' '])                                              => '36',
    (iv_db001_bankruptcy in ['0 - No BK', '1 - BK Discharged', '3 - BK Other']) => '9W',
    (iv_db001_bankruptcy in ['2 - BK Dismissed'])                               => '9W',
                                                                                   '');

o_dist_21 := o_subscore21 - 0.004035;

o_aacd_22 := map(
    ((STRING)iv_prof_license_flag in [' ']) => '36',
    (iv_prof_license_flag in ['0']) => '36',
    (iv_prof_license_flag in ['1']) => '36',
                                       '');
// o_aacd_22 := map(
    // ((STRING)iv_prof_license_flag in [' ']) => '36',
    // (iv_prof_license_flag in [NULL]) => '36',
    // ((STRING)iv_prof_license_flag in ['0']) => '36',
    // ((STRING)iv_prof_license_flag in ['1']) => '36',
                                       // '');

o_dist_22 := o_subscore22 - 0.207157;

o_aacd_23 := map(
    NULL < iv_inq_other_count12 AND iv_inq_other_count12 < 1 => '9Q',
    1 <= iv_inq_other_count12                                => '9Q',
                                                                '');

o_dist_23 := o_subscore23 - 0.007036;

o_rcvalue9i := (integer)(o_aacd_0 = '9I') * o_dist_0 +
    (integer)(o_aacd_1 = '9I') * o_dist_1 +
    (integer)(o_aacd_2 = '9I') * o_dist_2 +
    (integer)(o_aacd_3 = '9I') * o_dist_3 +
    (integer)(o_aacd_4 = '9I') * o_dist_4 +
    (integer)(o_aacd_5 = '9I') * o_dist_5 +
    (integer)(o_aacd_6 = '9I') * o_dist_6 +
    (integer)(o_aacd_7 = '9I') * o_dist_7 +
    (integer)(o_aacd_8 = '9I') * o_dist_8 +
    (integer)(o_aacd_9 = '9I') * o_dist_9 +
    (integer)(o_aacd_10 = '9I') * o_dist_10 +
    (integer)(o_aacd_11 = '9I') * o_dist_11 +
    (integer)(o_aacd_12 = '9I') * o_dist_12 +
    (integer)(o_aacd_13 = '9I') * o_dist_13 +
    (integer)(o_aacd_14 = '9I') * o_dist_14 +
    (integer)(o_aacd_15 = '9I') * o_dist_15 +
    (integer)(o_aacd_16 = '9I') * o_dist_16 +
    (integer)(o_aacd_17 = '9I') * o_dist_17 +
    (integer)(o_aacd_18 = '9I') * o_dist_18 +
    (integer)(o_aacd_19 = '9I') * o_dist_19 +
    (integer)(o_aacd_20 = '9I') * o_dist_20 +
    (integer)(o_aacd_21 = '9I') * o_dist_21 +
    (integer)(o_aacd_22 = '9I') * o_dist_22 +
    (integer)(o_aacd_23 = '9I') * o_dist_23;

o_rcvalue9j := (integer)(o_aacd_0 = '9J') * o_dist_0 +
    (integer)(o_aacd_1 = '9J') * o_dist_1 +
    (integer)(o_aacd_2 = '9J') * o_dist_2 +
    (integer)(o_aacd_3 = '9J') * o_dist_3 +
    (integer)(o_aacd_4 = '9J') * o_dist_4 +
    (integer)(o_aacd_5 = '9J') * o_dist_5 +
    (integer)(o_aacd_6 = '9J') * o_dist_6 +
    (integer)(o_aacd_7 = '9J') * o_dist_7 +
    (integer)(o_aacd_8 = '9J') * o_dist_8 +
    (integer)(o_aacd_9 = '9J') * o_dist_9 +
    (integer)(o_aacd_10 = '9J') * o_dist_10 +
    (integer)(o_aacd_11 = '9J') * o_dist_11 +
    (integer)(o_aacd_12 = '9J') * o_dist_12 +
    (integer)(o_aacd_13 = '9J') * o_dist_13 +
    (integer)(o_aacd_14 = '9J') * o_dist_14 +
    (integer)(o_aacd_15 = '9J') * o_dist_15 +
    (integer)(o_aacd_16 = '9J') * o_dist_16 +
    (integer)(o_aacd_17 = '9J') * o_dist_17 +
    (integer)(o_aacd_18 = '9J') * o_dist_18 +
    (integer)(o_aacd_19 = '9J') * o_dist_19 +
    (integer)(o_aacd_20 = '9J') * o_dist_20 +
    (integer)(o_aacd_21 = '9J') * o_dist_21 +
    (integer)(o_aacd_22 = '9J') * o_dist_22 +
    (integer)(o_aacd_23 = '9J') * o_dist_23;

o_rcvaluepv := (integer)(o_aacd_0 = 'PV') * o_dist_0 +
    (integer)(o_aacd_1 = 'PV') * o_dist_1 +
    (integer)(o_aacd_2 = 'PV') * o_dist_2 +
    (integer)(o_aacd_3 = 'PV') * o_dist_3 +
    (integer)(o_aacd_4 = 'PV') * o_dist_4 +
    (integer)(o_aacd_5 = 'PV') * o_dist_5 +
    (integer)(o_aacd_6 = 'PV') * o_dist_6 +
    (integer)(o_aacd_7 = 'PV') * o_dist_7 +
    (integer)(o_aacd_8 = 'PV') * o_dist_8 +
    (integer)(o_aacd_9 = 'PV') * o_dist_9 +
    (integer)(o_aacd_10 = 'PV') * o_dist_10 +
    (integer)(o_aacd_11 = 'PV') * o_dist_11 +
    (integer)(o_aacd_12 = 'PV') * o_dist_12 +
    (integer)(o_aacd_13 = 'PV') * o_dist_13 +
    (integer)(o_aacd_14 = 'PV') * o_dist_14 +
    (integer)(o_aacd_15 = 'PV') * o_dist_15 +
    (integer)(o_aacd_16 = 'PV') * o_dist_16 +
    (integer)(o_aacd_17 = 'PV') * o_dist_17 +
    (integer)(o_aacd_18 = 'PV') * o_dist_18 +
    (integer)(o_aacd_19 = 'PV') * o_dist_19 +
    (integer)(o_aacd_20 = 'PV') * o_dist_20 +
    (integer)(o_aacd_21 = 'PV') * o_dist_21 +
    (integer)(o_aacd_22 = 'PV') * o_dist_22 +
    (integer)(o_aacd_23 = 'PV') * o_dist_23;

o_rcvalue9a := (integer)(o_aacd_0 = '9A') * o_dist_0 +
    (integer)(o_aacd_1 = '9A') * o_dist_1 +
    (integer)(o_aacd_2 = '9A') * o_dist_2 +
    (integer)(o_aacd_3 = '9A') * o_dist_3 +
    (integer)(o_aacd_4 = '9A') * o_dist_4 +
    (integer)(o_aacd_5 = '9A') * o_dist_5 +
    (integer)(o_aacd_6 = '9A') * o_dist_6 +
    (integer)(o_aacd_7 = '9A') * o_dist_7 +
    (integer)(o_aacd_8 = '9A') * o_dist_8 +
    (integer)(o_aacd_9 = '9A') * o_dist_9 +
    (integer)(o_aacd_10 = '9A') * o_dist_10 +
    (integer)(o_aacd_11 = '9A') * o_dist_11 +
    (integer)(o_aacd_12 = '9A') * o_dist_12 +
    (integer)(o_aacd_13 = '9A') * o_dist_13 +
    (integer)(o_aacd_14 = '9A') * o_dist_14 +
    (integer)(o_aacd_15 = '9A') * o_dist_15 +
    (integer)(o_aacd_16 = '9A') * o_dist_16 +
    (integer)(o_aacd_17 = '9A') * o_dist_17 +
    (integer)(o_aacd_18 = '9A') * o_dist_18 +
    (integer)(o_aacd_19 = '9A') * o_dist_19 +
    (integer)(o_aacd_20 = '9A') * o_dist_20 +
    (integer)(o_aacd_21 = '9A') * o_dist_21 +
    (integer)(o_aacd_22 = '9A') * o_dist_22 +
    (integer)(o_aacd_23 = '9A') * o_dist_23;

o_rcvalue9d := (integer)(o_aacd_0 = '9D') * o_dist_0 +
    (integer)(o_aacd_1 = '9D') * o_dist_1 +
    (integer)(o_aacd_2 = '9D') * o_dist_2 +
    (integer)(o_aacd_3 = '9D') * o_dist_3 +
    (integer)(o_aacd_4 = '9D') * o_dist_4 +
    (integer)(o_aacd_5 = '9D') * o_dist_5 +
    (integer)(o_aacd_6 = '9D') * o_dist_6 +
    (integer)(o_aacd_7 = '9D') * o_dist_7 +
    (integer)(o_aacd_8 = '9D') * o_dist_8 +
    (integer)(o_aacd_9 = '9D') * o_dist_9 +
    (integer)(o_aacd_10 = '9D') * o_dist_10 +
    (integer)(o_aacd_11 = '9D') * o_dist_11 +
    (integer)(o_aacd_12 = '9D') * o_dist_12 +
    (integer)(o_aacd_13 = '9D') * o_dist_13 +
    (integer)(o_aacd_14 = '9D') * o_dist_14 +
    (integer)(o_aacd_15 = '9D') * o_dist_15 +
    (integer)(o_aacd_16 = '9D') * o_dist_16 +
    (integer)(o_aacd_17 = '9D') * o_dist_17 +
    (integer)(o_aacd_18 = '9D') * o_dist_18 +
    (integer)(o_aacd_19 = '9D') * o_dist_19 +
    (integer)(o_aacd_20 = '9D') * o_dist_20 +
    (integer)(o_aacd_21 = '9D') * o_dist_21 +
    (integer)(o_aacd_22 = '9D') * o_dist_22 +
    (integer)(o_aacd_23 = '9D') * o_dist_23;

o_rcvalue36 := (integer)(o_aacd_0 = '36') * o_dist_0 +
    (integer)(o_aacd_1 = '36') * o_dist_1 +
    (integer)(o_aacd_2 = '36') * o_dist_2 +
    (integer)(o_aacd_3 = '36') * o_dist_3 +
    (integer)(o_aacd_4 = '36') * o_dist_4 +
    (integer)(o_aacd_5 = '36') * o_dist_5 +
    (integer)(o_aacd_6 = '36') * o_dist_6 +
    (integer)(o_aacd_7 = '36') * o_dist_7 +
    (integer)(o_aacd_8 = '36') * o_dist_8 +
    (integer)(o_aacd_9 = '36') * o_dist_9 +
    (integer)(o_aacd_10 = '36') * o_dist_10 +
    (integer)(o_aacd_11 = '36') * o_dist_11 +
    (integer)(o_aacd_12 = '36') * o_dist_12 +
    (integer)(o_aacd_13 = '36') * o_dist_13 +
    (integer)(o_aacd_14 = '36') * o_dist_14 +
    (integer)(o_aacd_15 = '36') * o_dist_15 +
    (integer)(o_aacd_16 = '36') * o_dist_16 +
    (integer)(o_aacd_17 = '36') * o_dist_17 +
    (integer)(o_aacd_18 = '36') * o_dist_18 +
    (integer)(o_aacd_19 = '36') * o_dist_19 +
    (integer)(o_aacd_20 = '36') * o_dist_20 +
    (integer)(o_aacd_21 = '36') * o_dist_21 +
    (integer)(o_aacd_22 = '36') * o_dist_22 +
    (integer)(o_aacd_23 = '36') * o_dist_23;

o_rcvalue99 := (integer)(o_aacd_0 = '99') * o_dist_0 +
    (integer)(o_aacd_1 = '99') * o_dist_1 +
    (integer)(o_aacd_2 = '99') * o_dist_2 +
    (integer)(o_aacd_3 = '99') * o_dist_3 +
    (integer)(o_aacd_4 = '99') * o_dist_4 +
    (integer)(o_aacd_5 = '99') * o_dist_5 +
    (integer)(o_aacd_6 = '99') * o_dist_6 +
    (integer)(o_aacd_7 = '99') * o_dist_7 +
    (integer)(o_aacd_8 = '99') * o_dist_8 +
    (integer)(o_aacd_9 = '99') * o_dist_9 +
    (integer)(o_aacd_10 = '99') * o_dist_10 +
    (integer)(o_aacd_11 = '99') * o_dist_11 +
    (integer)(o_aacd_12 = '99') * o_dist_12 +
    (integer)(o_aacd_13 = '99') * o_dist_13 +
    (integer)(o_aacd_14 = '99') * o_dist_14 +
    (integer)(o_aacd_15 = '99') * o_dist_15 +
    (integer)(o_aacd_16 = '99') * o_dist_16 +
    (integer)(o_aacd_17 = '99') * o_dist_17 +
    (integer)(o_aacd_18 = '99') * o_dist_18 +
    (integer)(o_aacd_19 = '99') * o_dist_19 +
    (integer)(o_aacd_20 = '99') * o_dist_20 +
    (integer)(o_aacd_21 = '99') * o_dist_21 +
    (integer)(o_aacd_22 = '99') * o_dist_22 +
    (integer)(o_aacd_23 = '99') * o_dist_23;

o_rcvalue98 := (integer)(o_aacd_0 = '98') * o_dist_0 +
    (integer)(o_aacd_1 = '98') * o_dist_1 +
    (integer)(o_aacd_2 = '98') * o_dist_2 +
    (integer)(o_aacd_3 = '98') * o_dist_3 +
    (integer)(o_aacd_4 = '98') * o_dist_4 +
    (integer)(o_aacd_5 = '98') * o_dist_5 +
    (integer)(o_aacd_6 = '98') * o_dist_6 +
    (integer)(o_aacd_7 = '98') * o_dist_7 +
    (integer)(o_aacd_8 = '98') * o_dist_8 +
    (integer)(o_aacd_9 = '98') * o_dist_9 +
    (integer)(o_aacd_10 = '98') * o_dist_10 +
    (integer)(o_aacd_11 = '98') * o_dist_11 +
    (integer)(o_aacd_12 = '98') * o_dist_12 +
    (integer)(o_aacd_13 = '98') * o_dist_13 +
    (integer)(o_aacd_14 = '98') * o_dist_14 +
    (integer)(o_aacd_15 = '98') * o_dist_15 +
    (integer)(o_aacd_16 = '98') * o_dist_16 +
    (integer)(o_aacd_17 = '98') * o_dist_17 +
    (integer)(o_aacd_18 = '98') * o_dist_18 +
    (integer)(o_aacd_19 = '98') * o_dist_19 +
    (integer)(o_aacd_20 = '98') * o_dist_20 +
    (integer)(o_aacd_21 = '98') * o_dist_21 +
    (integer)(o_aacd_22 = '98') * o_dist_22 +
    (integer)(o_aacd_23 = '98') * o_dist_23;

o_rcvalue9w := (integer)(o_aacd_0 = '9W') * o_dist_0 +
    (integer)(o_aacd_1 = '9W') * o_dist_1 +
    (integer)(o_aacd_2 = '9W') * o_dist_2 +
    (integer)(o_aacd_3 = '9W') * o_dist_3 +
    (integer)(o_aacd_4 = '9W') * o_dist_4 +
    (integer)(o_aacd_5 = '9W') * o_dist_5 +
    (integer)(o_aacd_6 = '9W') * o_dist_6 +
    (integer)(o_aacd_7 = '9W') * o_dist_7 +
    (integer)(o_aacd_8 = '9W') * o_dist_8 +
    (integer)(o_aacd_9 = '9W') * o_dist_9 +
    (integer)(o_aacd_10 = '9W') * o_dist_10 +
    (integer)(o_aacd_11 = '9W') * o_dist_11 +
    (integer)(o_aacd_12 = '9W') * o_dist_12 +
    (integer)(o_aacd_13 = '9W') * o_dist_13 +
    (integer)(o_aacd_14 = '9W') * o_dist_14 +
    (integer)(o_aacd_15 = '9W') * o_dist_15 +
    (integer)(o_aacd_16 = '9W') * o_dist_16 +
    (integer)(o_aacd_17 = '9W') * o_dist_17 +
    (integer)(o_aacd_18 = '9W') * o_dist_18 +
    (integer)(o_aacd_19 = '9W') * o_dist_19 +
    (integer)(o_aacd_20 = '9W') * o_dist_20 +
    (integer)(o_aacd_21 = '9W') * o_dist_21 +
    (integer)(o_aacd_22 = '9W') * o_dist_22 +
    (integer)(o_aacd_23 = '9W') * o_dist_23;

o_rcvaluems := (integer)(o_aacd_0 = 'MS') * o_dist_0 +
    (integer)(o_aacd_1 = 'MS') * o_dist_1 +
    (integer)(o_aacd_2 = 'MS') * o_dist_2 +
    (integer)(o_aacd_3 = 'MS') * o_dist_3 +
    (integer)(o_aacd_4 = 'MS') * o_dist_4 +
    (integer)(o_aacd_5 = 'MS') * o_dist_5 +
    (integer)(o_aacd_6 = 'MS') * o_dist_6 +
    (integer)(o_aacd_7 = 'MS') * o_dist_7 +
    (integer)(o_aacd_8 = 'MS') * o_dist_8 +
    (integer)(o_aacd_9 = 'MS') * o_dist_9 +
    (integer)(o_aacd_10 = 'MS') * o_dist_10 +
    (integer)(o_aacd_11 = 'MS') * o_dist_11 +
    (integer)(o_aacd_12 = 'MS') * o_dist_12 +
    (integer)(o_aacd_13 = 'MS') * o_dist_13 +
    (integer)(o_aacd_14 = 'MS') * o_dist_14 +
    (integer)(o_aacd_15 = 'MS') * o_dist_15 +
    (integer)(o_aacd_16 = 'MS') * o_dist_16 +
    (integer)(o_aacd_17 = 'MS') * o_dist_17 +
    (integer)(o_aacd_18 = 'MS') * o_dist_18 +
    (integer)(o_aacd_19 = 'MS') * o_dist_19 +
    (integer)(o_aacd_20 = 'MS') * o_dist_20 +
    (integer)(o_aacd_21 = 'MS') * o_dist_21 +
    (integer)(o_aacd_22 = 'MS') * o_dist_22 +
    (integer)(o_aacd_23 = 'MS') * o_dist_23;

o_rcvalue9q := (integer)(o_aacd_0 = '9Q') * o_dist_0 +
    (integer)(o_aacd_1 = '9Q') * o_dist_1 +
    (integer)(o_aacd_2 = '9Q') * o_dist_2 +
    (integer)(o_aacd_3 = '9Q') * o_dist_3 +
    (integer)(o_aacd_4 = '9Q') * o_dist_4 +
    (integer)(o_aacd_5 = '9Q') * o_dist_5 +
    (integer)(o_aacd_6 = '9Q') * o_dist_6 +
    (integer)(o_aacd_7 = '9Q') * o_dist_7 +
    (integer)(o_aacd_8 = '9Q') * o_dist_8 +
    (integer)(o_aacd_9 = '9Q') * o_dist_9 +
    (integer)(o_aacd_10 = '9Q') * o_dist_10 +
    (integer)(o_aacd_11 = '9Q') * o_dist_11 +
    (integer)(o_aacd_12 = '9Q') * o_dist_12 +
    (integer)(o_aacd_13 = '9Q') * o_dist_13 +
    (integer)(o_aacd_14 = '9Q') * o_dist_14 +
    (integer)(o_aacd_15 = '9Q') * o_dist_15 +
    (integer)(o_aacd_16 = '9Q') * o_dist_16 +
    (integer)(o_aacd_17 = '9Q') * o_dist_17 +
    (integer)(o_aacd_18 = '9Q') * o_dist_18 +
    (integer)(o_aacd_19 = '9Q') * o_dist_19 +
    (integer)(o_aacd_20 = '9Q') * o_dist_20 +
    (integer)(o_aacd_21 = '9Q') * o_dist_21 +
    (integer)(o_aacd_22 = '9Q') * o_dist_22 +
    (integer)(o_aacd_23 = '9Q') * o_dist_23;

o_rcvalue9p := (integer)(o_aacd_0 = '9P') * o_dist_0 +
    (integer)(o_aacd_1 = '9P') * o_dist_1 +
    (integer)(o_aacd_2 = '9P') * o_dist_2 +
    (integer)(o_aacd_3 = '9P') * o_dist_3 +
    (integer)(o_aacd_4 = '9P') * o_dist_4 +
    (integer)(o_aacd_5 = '9P') * o_dist_5 +
    (integer)(o_aacd_6 = '9P') * o_dist_6 +
    (integer)(o_aacd_7 = '9P') * o_dist_7 +
    (integer)(o_aacd_8 = '9P') * o_dist_8 +
    (integer)(o_aacd_9 = '9P') * o_dist_9 +
    (integer)(o_aacd_10 = '9P') * o_dist_10 +
    (integer)(o_aacd_11 = '9P') * o_dist_11 +
    (integer)(o_aacd_12 = '9P') * o_dist_12 +
    (integer)(o_aacd_13 = '9P') * o_dist_13 +
    (integer)(o_aacd_14 = '9P') * o_dist_14 +
    (integer)(o_aacd_15 = '9P') * o_dist_15 +
    (integer)(o_aacd_16 = '9P') * o_dist_16 +
    (integer)(o_aacd_17 = '9P') * o_dist_17 +
    (integer)(o_aacd_18 = '9P') * o_dist_18 +
    (integer)(o_aacd_19 = '9P') * o_dist_19 +
    (integer)(o_aacd_20 = '9P') * o_dist_20 +
    (integer)(o_aacd_21 = '9P') * o_dist_21 +
    (integer)(o_aacd_22 = '9P') * o_dist_22 +
    (integer)(o_aacd_23 = '9P') * o_dist_23;

o_rcvalueev := (integer)(o_aacd_0 = 'EV') * o_dist_0 +
    (integer)(o_aacd_1 = 'EV') * o_dist_1 +
    (integer)(o_aacd_2 = 'EV') * o_dist_2 +
    (integer)(o_aacd_3 = 'EV') * o_dist_3 +
    (integer)(o_aacd_4 = 'EV') * o_dist_4 +
    (integer)(o_aacd_5 = 'EV') * o_dist_5 +
    (integer)(o_aacd_6 = 'EV') * o_dist_6 +
    (integer)(o_aacd_7 = 'EV') * o_dist_7 +
    (integer)(o_aacd_8 = 'EV') * o_dist_8 +
    (integer)(o_aacd_9 = 'EV') * o_dist_9 +
    (integer)(o_aacd_10 = 'EV') * o_dist_10 +
    (integer)(o_aacd_11 = 'EV') * o_dist_11 +
    (integer)(o_aacd_12 = 'EV') * o_dist_12 +
    (integer)(o_aacd_13 = 'EV') * o_dist_13 +
    (integer)(o_aacd_14 = 'EV') * o_dist_14 +
    (integer)(o_aacd_15 = 'EV') * o_dist_15 +
    (integer)(o_aacd_16 = 'EV') * o_dist_16 +
    (integer)(o_aacd_17 = 'EV') * o_dist_17 +
    (integer)(o_aacd_18 = 'EV') * o_dist_18 +
    (integer)(o_aacd_19 = 'EV') * o_dist_19 +
    (integer)(o_aacd_20 = 'EV') * o_dist_20 +
    (integer)(o_aacd_21 = 'EV') * o_dist_21 +
    (integer)(o_aacd_22 = 'EV') * o_dist_22 +
    (integer)(o_aacd_23 = 'EV') * o_dist_23;

o_rcvalue97 := (integer)(o_aacd_0 = '97') * o_dist_0 +
    (integer)(o_aacd_1 = '97') * o_dist_1 +
    (integer)(o_aacd_2 = '97') * o_dist_2 +
    (integer)(o_aacd_3 = '97') * o_dist_3 +
    (integer)(o_aacd_4 = '97') * o_dist_4 +
    (integer)(o_aacd_5 = '97') * o_dist_5 +
    (integer)(o_aacd_6 = '97') * o_dist_6 +
    (integer)(o_aacd_7 = '97') * o_dist_7 +
    (integer)(o_aacd_8 = '97') * o_dist_8 +
    (integer)(o_aacd_9 = '97') * o_dist_9 +
    (integer)(o_aacd_10 = '97') * o_dist_10 +
    (integer)(o_aacd_11 = '97') * o_dist_11 +
    (integer)(o_aacd_12 = '97') * o_dist_12 +
    (integer)(o_aacd_13 = '97') * o_dist_13 +
    (integer)(o_aacd_14 = '97') * o_dist_14 +
    (integer)(o_aacd_15 = '97') * o_dist_15 +
    (integer)(o_aacd_16 = '97') * o_dist_16 +
    (integer)(o_aacd_17 = '97') * o_dist_17 +
    (integer)(o_aacd_18 = '97') * o_dist_18 +
    (integer)(o_aacd_19 = '97') * o_dist_19 +
    (integer)(o_aacd_20 = '97') * o_dist_20 +
    (integer)(o_aacd_21 = '97') * o_dist_21 +
    (integer)(o_aacd_22 = '97') * o_dist_22 +
    (integer)(o_aacd_23 = '97') * o_dist_23;

o_rcvalue50 := (integer)(o_aacd_0 = '50') * o_dist_0 +
    (integer)(o_aacd_1 = '50') * o_dist_1 +
    (integer)(o_aacd_2 = '50') * o_dist_2 +
    (integer)(o_aacd_3 = '50') * o_dist_3 +
    (integer)(o_aacd_4 = '50') * o_dist_4 +
    (integer)(o_aacd_5 = '50') * o_dist_5 +
    (integer)(o_aacd_6 = '50') * o_dist_6 +
    (integer)(o_aacd_7 = '50') * o_dist_7 +
    (integer)(o_aacd_8 = '50') * o_dist_8 +
    (integer)(o_aacd_9 = '50') * o_dist_9 +
    (integer)(o_aacd_10 = '50') * o_dist_10 +
    (integer)(o_aacd_11 = '50') * o_dist_11 +
    (integer)(o_aacd_12 = '50') * o_dist_12 +
    (integer)(o_aacd_13 = '50') * o_dist_13 +
    (integer)(o_aacd_14 = '50') * o_dist_14 +
    (integer)(o_aacd_15 = '50') * o_dist_15 +
    (integer)(o_aacd_16 = '50') * o_dist_16 +
    (integer)(o_aacd_17 = '50') * o_dist_17 +
    (integer)(o_aacd_18 = '50') * o_dist_18 +
    (integer)(o_aacd_19 = '50') * o_dist_19 +
    (integer)(o_aacd_20 = '50') * o_dist_20 +
    (integer)(o_aacd_21 = '50') * o_dist_21 +
    (integer)(o_aacd_22 = '50') * o_dist_22 +
    (integer)(o_aacd_23 = '50') * o_dist_23;

// ssn_deceased := rc_decsflag = 1 or indexw(StringLib.StringToUpperCase(trim(ver_sources, ALL)), 'DS', ',') > 0;
ssn_deceased := (integer)rc_decsflag = 1 or (integer)indexw(StringLib.StringToUpperCase(trim(ver_sources, ALL)), 'DS', ',') > 0;

riskview_222s := riskview.constants.noscore(nas_summary,nap_summary, add1_naprop, le.truedid);

base := 700;

pts := 40;

odds := (REAL)((1 - .0857) / .0857);

// rvt1705_1_0 := map(
    // ssn_deceased = 1  => 200,
    // riskview_222s = 1 => 222,
       // min(if(max(round(pts * (ln(o_probscore / (1 - o_probscore)) - ln(odds)) / ln(2) + base), 501) = NULL, -NULL, max(round(pts * (ln(o_probscore / (1 - o_probscore)) - ln(odds)) / ln(2) + base), 501)), 900));
rvt1705_1_0 := map(
    (INTEGER)ssn_deceased = 1  => 200,
    (INTEGER)riskview_222s = 1 => 222,
       min(if(max(round(pts * (ln(o_probscore / (1 - o_probscore)) - ln(odds)) / ln(2) + base), 501) = NULL, -NULL, max(round(pts * (ln(o_probscore / (1 - o_probscore)) - ln(odds)) / ln(2) + base), 501)), 900));



//*************************************************************************************//
// I have no idea how the reason code logic gets implemented in ECL, so everything below 
// probably needs to get changed or replaced.  The methodology for creating the reason codes is
// very similar to the logic used by the RiskView 4.0 scores, so you might want to consult
// that model code for guidance on implementing reason codes. 
//*************************************************************************************//

ds_layout := {STRING rc, REAL value};


 
//*************************************************************************************//
rc_dataset_o := DATASET([
    {'9I', o_rcvalue9I},
    {'9J', o_rcvalue9J},
    {'PV', o_rcvaluePV},
    {'9A', o_rcvalue9A},
    {'9D', o_rcvalue9D},
    {'36', o_rcvalue36},
    {'99', o_rcvalue99},
    {'98', o_rcvalue98},
    {'9W', o_rcvalue9W},
    {'MS', o_rcvalueMS},
    {'9Q', o_rcvalue9Q},
    {'9P', o_rcvalue9P},
    {'EV', o_rcvalueEV},
    {'97', o_rcvalue97},
    {'50', o_rcvalue50}
    ], ds_layout)(value < 0);

//*************************************************************************************//
// IMPORTANT NOTE:  Select ONLY reason codes with an RCValue < 0.  I'll leave the 
//   implementation of this to the Engineer
//*************************************************************************************//
rc_dataset_o_sorted := sort(rc_dataset_o, rc_dataset_o.value);

o_rc1 := rc_dataset_o_sorted[1].rc;
o_rc2 := rc_dataset_o_sorted[2].rc;
o_rc3 := rc_dataset_o_sorted[3].rc;
o_rc4 := rc_dataset_o_sorted[4].rc;

o_vl1 := rc_dataset_o_sorted[1].value;
o_vl2 := rc_dataset_o_sorted[2].value;
o_vl3 := rc_dataset_o_sorted[3].value;
o_vl4 := rc_dataset_o_sorted[4].value;
//*************************************************************************************//

rc1_2 := o_rc1;

rc2_2 := o_rc2;

rc3_2 := o_rc3;

rc4_2 := o_rc4;

_rc_inq := map(
    iv_inq_adls_per_addr > 0          => '9Q',
    iv_inq_addrs_per_adl > 0          => '9Q',
    iv_inq_highriskcredit_count12 > 0 => '9P',
    iv_inq_communications_count12 > 0 => '9Q',
    iv_inq_other_count12 > 0          => '9Q',
                                         '');

// rc4_c98 := map(
    // trim((string)rc1_2, LEFT, RIGHT) = '' => '',
    // trim((string)rc2_2, LEFT, RIGHT) = '' => '',
    // trim((string)rc3_2, LEFT, RIGHT) = '' => '',
    // trim((string)rc4_2, LEFT, RIGHT) = '' => _rc_inq,
                                             // '');

// rc3_c98 := map(
    // trim((string)rc1_2, LEFT, RIGHT) = '' => '',
    // trim((string)rc2_2, LEFT, RIGHT) = '' => '',
    // trim((string)rc3_2, LEFT, RIGHT) = '' => _rc_inq,
    // trim((string)rc4_2, LEFT, RIGHT) = '' => '',
                                             // '');

// rc1_c98 := map(
    // trim((string)rc1_2, LEFT, RIGHT) = '' => _rc_inq,
    // trim((string)rc2_2, LEFT, RIGHT) = '' => '',
    // trim((string)rc3_2, LEFT, RIGHT) = '' => '',
    // trim((string)rc4_2, LEFT, RIGHT) = '' => '',
                                             // '');

// rc2_c98 := map(
    // trim((string)rc1_2, LEFT, RIGHT) = '' => '',
    // trim((string)rc2_2, LEFT, RIGHT) = '' => _rc_inq,
    // trim((string)rc3_2, LEFT, RIGHT) = '' => '',
    // trim((string)rc4_2, LEFT, RIGHT) = '' => '',
                                             // '');

rc5_c98 := map(
    trim((string)rc1_2, LEFT, RIGHT) = '' => '',
    trim((string)rc2_2, LEFT, RIGHT) = '' => '',
    trim((string)rc3_2, LEFT, RIGHT) = '' => '',
    trim((string)rc4_2, LEFT, RIGHT) = '' => '',
                                             _rc_inq);

// rc3_1 := if(not((rc1_2 in ['9Q', '9P'])) and not((rc2_2 in ['9Q', '9P'])) and not((rc3_2 in ['9Q', '9P'])) and not((rc4_2 in ['9Q', '9P'])), rc3_c98, rc3_2);

// rc4_1 := if(not((rc1_2 in ['9Q', '9P'])) and not((rc2_2 in ['9Q', '9P'])) and not((rc3_2 in ['9Q', '9P'])) and not((rc4_2 in ['9Q', '9P'])), rc4_c98, rc4_2);

// rc1_1 := if(not((rc1_2 in ['9Q', '9P'])) and not((rc2_2 in ['9Q', '9P'])) and not((rc3_2 in ['9Q', '9P'])) and not((rc4_2 in ['9Q', '9P'])), rc1_c98, rc1_2);

rc5_1 := if(not((rc1_2 in ['9Q', '9P'])) and not((rc2_2 in ['9Q', '9P'])) and not((rc3_2 in ['9Q', '9P'])) and not((rc4_2 in ['9Q', '9P'])), rc5_c98, '');

// rc2_1 := if(not((rc1_2 in ['9Q', '9P'])) and not((rc2_2 in ['9Q', '9P'])) and not((rc3_2 in ['9Q', '9P'])) and not((rc4_2 in ['9Q', '9P'])), rc2_c98, rc2_2);

rc2 := map(
    rvt1705_1_0 = 200 => '',
    rvt1705_1_0 = 222 => '',
    rvt1705_1_0 = 900 => '',
                         rc2_2);

rc5 := map(
    rvt1705_1_0 = 200 => '',
    rvt1705_1_0 = 222 => '',
    rvt1705_1_0 = 900 => '',
                         rc5_1);

rc1 := map(
    rvt1705_1_0 = 200 => '02',
    rvt1705_1_0 = 222 => '9X',
    rvt1705_1_0 = 900 => '',
                         rc1_2);

rc3 := map(
    rvt1705_1_0 = 200 => '',
    rvt1705_1_0 = 222 => '',
    rvt1705_1_0 = 900 => '',
                         rc3_2);

rc4 := map(
    rvt1705_1_0 = 200 => '',
    rvt1705_1_0 = 222 => '',
    rvt1705_1_0 = 900 => '',
                         rc4_2);




	//*************************************************************************************//
	//                       End RiskView Version 4.1 Reason Code Logic
	//*************************************************************************************//


	//*************************************************************************************//
	//                      RiskView Version 4.1 Reason Code Overrides 
	//             ECL DEVELOPERS, MAKE SURE ALL RiskView V4.1 MODELS HAVE THIS
	//*************************************************************************************//
	HRILayout := RECORD
		STRING4 HRI := '';
	END;
	
	inCalif := isCalifornia AND (
				(integer)(boolean)le.iid.combo_firstcount+(integer)(boolean)le.iid.combo_lastcount
				+(integer)(boolean)le.iid.combo_addrcount+(integer)(boolean)le.iid.combo_hphonecount
				+(integer)(boolean)le.iid.combo_ssncount+(integer)(boolean)le.iid.combo_dobcount) < 3;
	
	reasonsTemp := DATASET([{rc1}, {rc2}, {rc3}, {rc4}, {rc5}], HRILayout)(HRI NOT IN ['', '00']);
	reasons := IF(ut.Exists2(reasonsTemp), reasonsTemp, DATASET([{'36'}], HRILayout));
	
	riCorrectionsTemp := PROJECT(RiskWiseFCRA.corrReasonCodes(le.consumerflags, 4), TRANSFORM(HRILayout, SELF.HRI := LEFT.hri)) (HRI NOT IN ['', '00']);

	reasonsOverrides := MAP(
													inCalif           =>	DATASET([{'35'}], HRILayout),
													rvt1705_1_0 = 200 =>	DATASET([{'02'}], HRILayout),
													rvt1705_1_0 = 222 =>	DATASET([{'9X'}], HRILayout),
													rvt1705_1_0 = 900 =>	DATASET([{' '}], HRILayout),
													rvt1705_1_0 BETWEEN 501 AND 720 AND reasons[1].HRI NOT IN ['', '36'] AND reasons[2].HRI = '' => DATASET([{reasons[1].HRI}, {'36'}], HRILayout),
													rvt1705_1_0 BETWEEN 501 AND 720 AND reasons[1].HRI != '9E' AND reasons[2].HRI = ''					 => DATASET([{reasons[1].HRI}, {'9E'}], HRILayout),
																								DATASET([], HRILayout)
													);
	// If we have corrections reason codes, use them, otherwise if we have score overrides use them, else use the normal reason codes
	reasonsFinalTemp := MAP(ut.Exists2(riCorrectionsTemp(trim(hri)<>''))	=> riCorrectionsTemp,
													ut.Exists2(reasonsOverrides(trim(hri)<>''))	=> reasonsOverrides, 
																													 reasons(trim(HRI) <> '')) (trim(HRI) <> '');
																													 
																													 
	zeros := DATASET([{'00'}, {'00'}, {'00'}, {'00'}, {'00'}], HRILayout);
	
	reasonCodes := CHOOSEN(reasonsFinalTemp & zeros, 5); // Keep up to 5 reason codes
	// reasonCodes := CHOOSEN(reasons, 5); // Keep up to 5 reason codes

	//*************************************************************************************
	//                   End RiskView Version 4.1 Reason Code Overrides
	//*************************************************************************************

	#if(MODEL_DEBUG)
                    self.sysdate                          := sysdate;
                    self.iv_add_apt                       := iv_add_apt;
                    self.iv_va040_add_prison_hist         := iv_va040_add_prison_hist;
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
                    self.iv_ms001_ssns_per_adl            := iv_ms001_ssns_per_adl;
                    self.iv_pv001_inp_avm_autoval         := iv_pv001_inp_avm_autoval;
                    self.iv_pv001_bst_avm_autoval         := iv_pv001_bst_avm_autoval;
                    self.iv_ed001_college_ind             := iv_ed001_college_ind;
                    self.iv_input_addr_not_most_recent    := iv_input_addr_not_most_recent;
                    self.prop_adl_p_count_pos             := prop_adl_p_count_pos;
                    self.prop_adl_count_p                 := prop_adl_count_p;
                    self._src_prop_adl_count              := _src_prop_adl_count;
                    self.iv_src_property_adl_count        := iv_src_property_adl_count;
                    self.iv_bst_addr_naprop               := iv_bst_addr_naprop;
                    self.mortgage_present                 := mortgage_present;
                    self.mortgage_type                    := mortgage_type;
                    self.iv_bst_addr_mortgage_type        := iv_bst_addr_mortgage_type;
                    self.iv_prv_addr_avm_auto_val         := iv_prv_addr_avm_auto_val;
                    self.iv_addrs_10yr                    := iv_addrs_10yr;
                    self.iv_adls_per_sfd_addr             := iv_adls_per_sfd_addr;
                    self.iv_inq_highriskcredit_count12    := iv_inq_highriskcredit_count12;
                    self.iv_inq_communications_count12    := iv_inq_communications_count12;
                    self.iv_inq_other_count12             := iv_inq_other_count12;
                    self.iv_inq_addrs_per_adl             := iv_inq_addrs_per_adl;
                    self.iv_inq_adls_per_addr             := iv_inq_adls_per_addr;
                    self.iv_eviction_count                := iv_eviction_count;
                    self.iv_unreleased_liens_ct           := iv_unreleased_liens_ct;
                    self.iv_criminal_x_felony             := iv_criminal_x_felony;
                    self.iv_prof_license_flag             := (STRING)iv_prof_license_flag;
                    self.o_subscore0                      := o_subscore0;
                    self.o_subscore1                      := o_subscore1;
                    self.o_subscore2                      := o_subscore2;
                    self.o_subscore3                      := o_subscore3;
                    self.o_subscore4                      := o_subscore4;
                    self.o_subscore5                      := o_subscore5;
                    self.o_subscore6                      := o_subscore6;
                    self.o_subscore7                      := o_subscore7;
                    self.o_subscore8                      := o_subscore8;
                    self.o_subscore9                      := o_subscore9;
                    self.o_subscore10                     := o_subscore10;
                    self.o_subscore11                     := o_subscore11;
                    self.o_subscore12                     := o_subscore12;
                    self.o_subscore13                     := o_subscore13;
                    self.o_subscore14                     := o_subscore14;
                    self.o_subscore15                     := o_subscore15;
                    self.o_subscore16                     := o_subscore16;
                    self.o_subscore17                     := o_subscore17;
                    self.o_subscore18                     := o_subscore18;
                    self.o_subscore19                     := o_subscore19;
                    self.o_subscore20                     := o_subscore20;
                    self.o_subscore21                     := o_subscore21;
                    self.o_subscore22                     := o_subscore22;
                    self.o_subscore23                     := o_subscore23;
                    self.o_rawscore                       := o_rawscore;
                    self.o_lnoddsscore                    := o_lnoddsscore;
                    self.o_probscore                      := o_probscore;
                    self.o_aacd_0                         := o_aacd_0;
                    self.o_dist_0                         := o_dist_0;
                    self.o_aacd_1                         := o_aacd_1;
                    self.o_dist_1                         := o_dist_1;
                    self.o_aacd_2                         := o_aacd_2;
                    self.o_dist_2                         := o_dist_2;
                    self.o_aacd_3                         := o_aacd_3;
                    self.o_dist_3                         := o_dist_3;
                    self.o_aacd_4                         := o_aacd_4;
                    self.o_dist_4                         := o_dist_4;
                    self.o_aacd_5                         := o_aacd_5;
                    self.o_dist_5                         := o_dist_5;
                    self.o_aacd_6                         := o_aacd_6;
                    self.o_dist_6                         := o_dist_6;
                    self.o_aacd_7                         := o_aacd_7;
                    self.o_dist_7                         := o_dist_7;
                    self.o_aacd_8                         := o_aacd_8;
                    self.o_dist_8                         := o_dist_8;
                    self.o_aacd_9                         := o_aacd_9;
                    self.o_dist_9                         := o_dist_9;
                    self.o_aacd_10                        := o_aacd_10;
                    self.o_dist_10                        := o_dist_10;
                    self.o_aacd_11                        := o_aacd_11;
                    self.o_dist_11                        := o_dist_11;
                    self.o_aacd_12                        := o_aacd_12;
                    self.o_dist_12                        := o_dist_12;
                    self.o_aacd_13                        := o_aacd_13;
                    self.o_dist_13                        := o_dist_13;
                    self.o_aacd_14                        := o_aacd_14;
                    self.o_dist_14                        := o_dist_14;
                    self.o_aacd_15                        := o_aacd_15;
                    self.o_dist_15                        := o_dist_15;
                    self.o_aacd_16                        := o_aacd_16;
                    self.o_dist_16                        := o_dist_16;
                    self.o_aacd_17                        := o_aacd_17;
                    self.o_dist_17                        := o_dist_17;
                    self.o_aacd_18                        := o_aacd_18;
                    self.o_dist_18                        := o_dist_18;
                    self.o_aacd_19                        := o_aacd_19;
                    self.o_dist_19                        := o_dist_19;
                    self.o_aacd_20                        := o_aacd_20;
                    self.o_dist_20                        := o_dist_20;
                    self.o_aacd_21                        := o_aacd_21;
                    self.o_dist_21                        := o_dist_21;
                    self.o_aacd_22                        := o_aacd_22;
                    self.o_dist_22                        := o_dist_22;
                    self.o_aacd_23                        := o_aacd_23;
                    self.o_dist_23                        := o_dist_23;
                    self.o_rcvalue9i                      := o_rcvalue9i;
                    self.o_rcvalue9j                      := o_rcvalue9j;
                    self.o_rcvaluepv                      := o_rcvaluepv;
                    self.o_rcvalue9a                      := o_rcvalue9a;
                    self.o_rcvalue9d                      := o_rcvalue9d;
                    self.o_rcvalue36                      := o_rcvalue36;
                    self.o_rcvalue99                      := o_rcvalue99;
                    self.o_rcvalue98                      := o_rcvalue98;
                    self.o_rcvalue9w                      := o_rcvalue9w;
                    self.o_rcvaluems                      := o_rcvaluems;
                    self.o_rcvalue9q                      := o_rcvalue9q;
                    self.o_rcvalue9p                      := o_rcvalue9p;
                    self.o_rcvalueev                      := o_rcvalueev;
                    self.o_rcvalue97                      := o_rcvalue97;
                    self.o_rcvalue50                      := o_rcvalue50;
                    self.ssn_deceased                     := ssn_deceased;
                    self.riskview_222s                    := riskview_222s;
                    self.base                             := base;
                    self.pts                              := pts;
                    self.odds                             := odds;
                    self.rvt1705_1_0                      := rvt1705_1_0;
                    self.o_rc1                            := o_rc1;
                    self.o_rc2                            := o_rc2;
                    self.o_rc3                            := o_rc3;
                    self.o_rc4                            := o_rc4;
                    self.o_vl1                            := o_vl1;
                    self.o_vl2                            := o_vl2;
                    self.o_vl3                            := o_vl3;
                    self.o_vl4                            := o_vl4;
                    self._rc_inq                          := _rc_inq;
                    self.rc2                              := rc2;
                    self.rc4                              := rc4;
                    self.rc3                              := rc3;
                    self.rc1                              := rc1;
                    self.rc5                              := rc5;
                    SELF.seq                              := le.seq;



		SELF.clam := le;

	#else

		SELF.ri := PROJECT(reasonCodes, TRANSFORM(Risk_Indicators.Layout_Desc,
																							SELF.hri := IF(LEFT.hri = '', '00', LEFT.hri),
																							SELF.desc := Risk_Indicators.getHRIDesc(LEFT.hri)
																					));
		SELF.score := MAP(reasonCodes[1].HRI IN ['91','92','93','94'] => (STRING3)((INTEGER)reasonCodes[1].HRI + 10),
											reasonCodes[1].HRI = '35'										=> '100',
																																		 (STRING)RVT1705_1_0);	
  
  SELF.seq := le.seq;
  #end
	END;

	model := PROJECT(clam, doModel(LEFT));

	RETURN(model);
END; 

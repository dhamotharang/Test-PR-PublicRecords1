//Strategic Link Consulting Score - New customers

import risk_indicators, riskwise, riskwisefcra, ut, std, riskview;

export RVG1304_2_0( grouped dataset(risk_indicators.Layout_Boca_Shell) clam, BOOLEAN isCalifornia = FALSE) := FUNCTION

  RVG_DEBUG := false;

  #if(RVG_DEBUG)
    layout_debug := record
			integer sysdate                          ; //  sysdate;
			string  src_bureau_vo_fseen              ; //  src_bureau_vo_fseen;
			integer _src_bureau_vo_fseen             ; //  _src_bureau_vo_fseen;
			integer mth_ver_src_fdate_vo             ; //  mth_ver_src_fdate_vo;
			string  src_bureau_vo_lseen              ; //  src_bureau_vo_lseen;
			integer _src_bureau_vo_lseen             ; //  _src_bureau_vo_lseen;
			integer mth_ver_src_ldate_vo             ; //  mth_ver_src_ldate_vo;
			boolean mth_ver_src_fdate_vo60           ; //  mth_ver_src_fdate_vo60;
			boolean mth_ver_src_ldate_vo0            ; //  mth_ver_src_ldate_vo0;
			string  src_bureau_w_lseen               ; //  src_bureau_w_lseen;
			integer _src_bureau_w_lseen              ; //  _src_bureau_w_lseen;
			integer mth_ver_src_ldate_w              ; //  mth_ver_src_ldate_w;
			boolean mth_ver_src_ldate_w0             ; //  mth_ver_src_ldate_w0;
			string  src_bureau_wp_lseen              ; //  src_bureau_wp_lseen;
			integer _src_bureau_wp_lseen             ; //  _src_bureau_wp_lseen;
			integer mth_ver_src_ldate_wp             ; //  mth_ver_src_ldate_wp;
			boolean mth_ver_src_ldate_wp0            ; //  mth_ver_src_ldate_wp0;
			integer _paw_first_seen                  ; //  _paw_first_seen;
			integer mth_paw_first_seen               ; //  mth_paw_first_seen;
			integer mth_paw_first_seen2              ; //  mth_paw_first_seen2;
			boolean ver_src_am                       ; //  ver_src_am;
			boolean ver_src_e1                       ; //  ver_src_e1;
			boolean ver_src_e2                       ; //  ver_src_e2;
			boolean ver_src_e3                       ; //  ver_src_e3;
			boolean ver_src_pl                       ; //  ver_src_pl;
			boolean ver_src_w                        ; //  ver_src_w;
			boolean paw_dead_business_count_gt3      ; //  paw_dead_business_count_gt3;
			boolean paw_active_phone_count_0         ; //  paw_active_phone_count_0;
			integer _infutor_first_seen              ; //  _infutor_first_seen;
			integer mth_infutor_first_seen           ; //  mth_infutor_first_seen;
			integer _infutor_last_seen               ; //  _infutor_last_seen;
			integer mth_infutor_last_seen            ; //  mth_infutor_last_seen;
			integer infutor_i                        ; //  infutor_i;
			real    infutor_im                       ; //  infutor_im;
			string  src_white_pages_adl_fseen        ; //  src_white_pages_adl_fseen;
			integer _src_white_pages_adl_fseen       ; //  _src_white_pages_adl_fseen;
			integer iv_sr001_m_wp_adl_fs             ; //  iv_sr001_m_wp_adl_fs;
			integer src_m_wp_adl_fs                  ; //  src_m_wp_adl_fs;
			integer _header_first_seen               ; //  _header_first_seen;
			integer iv_sr001_m_hdr_fs                ; //  iv_sr001_m_hdr_fs;
			integer src_m_hdr_fs                     ; //  src_m_hdr_fs;
			real    source_mod6                      ; //  source_mod6;
			real	  iv_sr001_source_profile          ; //  iv_sr001_source_profile;
			boolean email_src_im                     ; //  email_src_im;
			integer iv_ds001_impulse_count           ; //  iv_ds001_impulse_count;
			integer iv_ms001_ssns_per_adl            ; //  iv_ms001_ssns_per_adl;
			integer iv_pv001_inp_avm_autoval         ; //  iv_pv001_inp_avm_autoval;
			integer iv_src_property_adl_count        ; //  iv_src_property_adl_count;
			string  iv_inp_addr_ownership_lvl        ; //  iv_inp_addr_ownership_lvl;
			integer iv_recent_disconnects            ; //  iv_recent_disconnects;
			integer iv_inq_recency                   ; //  iv_inq_recency;
			boolean ver_phn_inf                      ; //  ver_phn_inf;
			boolean ver_phn_nap                      ; //  ver_phn_nap;
			integer inf_phn_ver_lvl                  ; //  inf_phn_ver_lvl;
			integer nap_phn_ver_lvl                  ; //  nap_phn_ver_lvl;
			string  iv_nap_phn_ver_x_inf_phn_ver     ; //  iv_nap_phn_ver_x_inf_phn_ver;
			integer iv_attr_addrs_recency            ; //  iv_attr_addrs_recency;
			integer iv_eviction_count                ; //  iv_eviction_count;
			integer iv_derog_diff                    ; //  iv_derog_diff;
			integer iv_criminal_count                ; //  iv_criminal_count;
			string  iv_ams_college_code              ; //  iv_ams_college_code;
			string  iv_prof_license_category         ; //  iv_prof_license_category;
			integer iv_pb_total_orders               ; //  iv_pb_total_orders;
			real    subscore0                        ; //  subscore0;
			real    subscore1                        ; //  subscore1;
			real    subscore2                        ; //  subscore2;
			real    subscore3                        ; //  subscore3;
			real    subscore4                        ; //  subscore4;
			real    subscore5                        ; //  subscore5;
			real    subscore6                        ; //  subscore6;
			real    subscore7                        ; //  subscore7;
			real    subscore8                        ; //  subscore8;
			real    subscore9                        ; //  subscore9;
			real    subscore10                       ; //  subscore10;
			real    subscore11                       ; //  subscore11;
			real    subscore12                       ; //  subscore12;
			real    subscore13                       ; //  subscore13;
			real    subscore14                       ; //  subscore14;
			real    subscore15                       ; //  subscore15;
			real    rawscore                         ; //  rawscore;
			real    lnoddsscore                      ; //  lnoddsscore;
			real    probscore                        ; //  probscore;
			integer base                             ; //  base;
			integer point                            ; //  point;
			real    odds                             ; //  odds;
			boolean iv_riskview_222s                 ; //  iv_riskview_222s;
			boolean iv_ssn_deceased                  ; //  iv_ssn_deceased;
			integer rvg1304_2                        ; //  rvg1304_2;
			integer iv_combined_age                  ; //  iv_combined_age;
			boolean bk_flag                          ; //  bk_flag;
			boolean crim_flag                        ; //  crim_flag;
			boolean lien_flag                        ; //  lien_flag;
			integer iv_pots_phone                    ; //  iv_pots_phone;
			boolean glrc9q                           ; //  glrc9q;
			boolean glrc9h                           ; //  glrc9h;
			boolean glrc9w                           ; //  glrc9w;
			boolean glrc97                           ; //  glrc97;
			boolean glrc98                           ; //  glrc98;
			boolean glrc9e                           ; //  glrc9e;
			boolean glrcms                           ; //  glrcms;
			boolean glrc9a                           ; //  glrc9a;
			boolean glrc9b                           ; //  glrc9b;
			boolean glrc9o                           ; //  glrc9o;
			boolean glrc9d                           ; //  glrc9d;
			boolean glrcev                           ; //  glrcev;
			boolean glrc07                           ; //  glrc07;
			boolean glrcpv                           ; //  glrcpv;
			boolean glrc9f                           ; //  glrc9f;
			boolean glrc9i                           ; //  glrc9i;
			boolean glrcbl                           ; //  glrcbl;
			real    rcvalue9q_1                      ; //  rcvalue9q_1;
			real    rcvalue9q                        ; //  rcvalue9q;
			real    rcvalue9h_1                      ; //  rcvalue9h_1;
			real    rcvalue9h                        ; //  rcvalue9h;
			real    rcvaluems_1                      ; //  rcvaluems_1;
			real    rcvaluems                        ; //  rcvaluems;
			real    rcvalue9a_1                      ; //  rcvalue9a_1;
			real    rcvalue9a_2                      ; //  rcvalue9a_2;
			real    rcvalue9a                        ; //  rcvalue9a;
			real    rcvalue9b_1                      ; //  rcvalue9b_1;
			real    rcvalue9b                        ; //  rcvalue9b;
			real    rcvalue9o_1                      ; //  rcvalue9o_1;
			real    rcvalue9o                        ; //  rcvalue9o;
			real    rcvalue9d_1                      ; //  rcvalue9d_1;
			real    rcvalue9d                        ; //  rcvalue9d;
			real    rcvalueev_1                      ; //  rcvalueev_1;
			real    rcvalueev                        ; //  rcvalueev;
			real    rcvalue07_1                      ; //  rcvalue07_1;
			real    rcvalue07                        ; //  rcvalue07;
			real    rcvaluepv_1                      ; //  rcvaluepv_1;
			real    rcvaluepv                        ; //  rcvaluepv;
			real    rcvalue9f_1                      ; //  rcvalue9f_1;
			real    rcvalue9f                        ; //  rcvalue9f;
			real    rcvalue9i_1                      ; //  rcvalue9i_1;
			real    rcvalue9i                        ; //  rcvalue9i;
			real    rcvalue9e_1                      ; //  rcvalue9e_1;
			real    rcvalue9e                        ; //  rcvalue9e;
			real    rcvalue98_1                      ; //  rcvalue98_1;
			real    rcvalue98                        ; //  rcvalue98;
			real    rcvalue9w_1                      ; //  rcvalue9w_1;
			real    rcvalue9w                        ; //  rcvalue9w;
			real    rcvalue97_1                      ; //  rcvalue97_1;
			real    rcvalue97_2                      ; //  rcvalue97_2;
			real    rcvalue97                        ; //  rcvalue97;
			real    rcvaluebl_1                      ; //  rcvaluebl_1;
			real    rcvaluebl_2                      ; //  rcvaluebl_2;
			real    rcvaluebl                        ; //  rcvaluebl;
			string  rc1                              ; //  rc1;
			string  rc2                              ; //  rc2;
			string  rc3                              ; //  rc3;
			string  rc4                              ; //  rc4;
			string  rc5                              ; //  rc5;
			models.layout_modelout;
			risk_indicators.Layout_Boca_Shell clam;
    END;
    layout_debug doModel( clam le ) := TRANSFORM
  #else
    models.layout_modelout doModel( clam le ) := TRANSFORM
  #end
		truedid                          := le.truedid;
		nas_summary                      := le.iid.nas_summary;
		nap_summary                      := le.iid.nap_summary;
		nap_status                       := le.iid.nap_status;
		rc_hriskphoneflag                := le.iid.hriskphoneflag;
		rc_decsflag                      := le.iid.decsflag;
		rc_bansflag                      := le.iid.bansflag;
		combo_dobscore                   := le.iid.combo_dobscore;
		ver_sources                      := le.header_summary.ver_sources;
		ver_sources_first_seen           := le.header_summary.ver_sources_first_seen_date;
		ver_sources_last_seen            := le.header_summary.ver_sources_last_seen_date;
		ver_sources_count                := le.header_summary.ver_sources_recordcount;
		addrpop                          := le.input_validation.address;
		dobpop                           := le.input_validation.dateofbirth;
		hphnpop                          := le.input_validation.homephone;
		age                              := le.name_verification.age;
		add1_avm_automated_valuation     := le.avm.input_address_information.avm_automated_valuation;
		add1_applicant_owned             := le.address_verification.input_address_information.applicant_owned;
		add1_occupant_owned              := le.address_verification.input_address_information.occupant_owned;
		add1_family_owned                := le.address_verification.input_address_information.family_owned;
		add1_naprop                      := le.address_verification.input_address_information.naprop;
		add1_pop                         := le.addrpop;
		property_owned_total             := le.address_verification.owned.property_total;
		property_sold_total              := le.address_verification.sold.property_total;
		addrs_5yr                        := le.other_address_info.addrs_last_5years;
		addrs_10yr                       := le.other_address_info.addrs_last_10years;
		addrs_15yr                       := le.other_address_info.addrs_last_15years;
		telcordia_type                   := le.phone_verification.telcordia_type;
		recent_disconnects               := le.phone_verification.recent_disconnects;
		header_first_seen                := le.ssn_verification.header_first_seen;
		ssns_per_adl                     := le.velocity_counters.ssns_per_adl;
		addrs_per_adl                    := le.velocity_counters.addrs_per_adl;
		inq_count                        := le.acc_logs.inquiries.counttotal;
		inq_count01                      := le.acc_logs.inquiries.count01;
		inq_count03                      := le.acc_logs.inquiries.count03;
		inq_count06                      := le.acc_logs.inquiries.count06;
		inq_count12                      := le.acc_logs.inquiries.count12;
		inq_count24                      := le.acc_logs.inquiries.count24;
		pb_total_orders                  := le.ibehavior.total_number_of_orders;
		paw_first_seen                   := le.employment.first_seen_date;
		paw_dead_business_count          := le.employment.dead_business_ct;
		paw_active_phone_count           := le.employment.business_active_phone_ct;
		infutor_first_seen               := le.infutor_phone.infutor_date_first_seen;
		infutor_last_seen                := le.infutor_phone.infutor_date_last_seen;
		infutor_nap                      := le.infutor_phone.infutor_nap;
		impulse_count                    := le.impulse.count;
		email_source_list                := le.email_summary.email_source_list;
		attr_addrs_last30                := le.other_address_info.addrs_last30;
		attr_addrs_last90                := le.other_address_info.addrs_last90;
		attr_addrs_last12                := le.other_address_info.addrs_last12;
		attr_addrs_last24                := le.other_address_info.addrs_last24;
		attr_addrs_last36                := le.other_address_info.addrs_last36;
		attr_total_number_derogs         := le.total_number_derogs;
		attr_eviction_count              := le.bjl.eviction_count;
		attr_num_nonderogs               := le.source_verification.num_nonderogs;
		bankrupt                         := le.bjl.bankrupt;
		filing_count                     := le.bjl.filing_count;
		bk_recent_count                  := le.bjl.bk_recent_count;
		liens_recent_unreleased_count    := le.bjl.liens_recent_unreleased_count;
		liens_historical_unreleased_ct   := le.bjl.liens_historical_unreleased_count;
		criminal_count                   := le.bjl.criminal_count;
		ams_age                          := le.student.age;
		ams_college_code                 := le.student.college_code;
		prof_license_category            := le.professional_license.plcategory;
		input_dob_age                    := le.shell_input.age;
		inferred_age                     := le.inferred_age;

NULL := -999999999;


INTEGER contains_i( string haystack, string needle ) := (INTEGER)(StringLib.StringFind(haystack, needle, 1) > 0);


BOOLEAN indexw(string source, string target, string delim) :=
	(source = target) OR
	(StringLib.StringFind(source, delim + target + delim, 1) > 0) OR
	(source[1..length(target)+1] = target + delim) OR
	(StringLib.StringReverse(source)[1..length(target)+1] = StringLib.StringReverse(target) + delim);

sysdate := common.sas_date(if(le.historydate=999999, (STRING)Std.Date.Today(), (string6)le.historydate+'01'));

src_bureau_vo_fseen := map(
    Models.Common.findw_cpp(ver_sources, 'VO' , ', ', 'E') = 0                                                    => '',
    Models.Common.getw(ver_sources_first_seen, Models.Common.findw_cpp(ver_sources, 'VO' , ', ', 'E'), ',') = '0' => '',
                                                                                                                     Models.Common.getw(ver_sources_first_seen, Models.Common.findw_cpp(ver_sources, 'VO' , ', ', 'E'), ','));

_src_bureau_vo_fseen := common.sas_date(src_bureau_vo_fseen);

mth_ver_src_fdate_vo := map(
    not(truedid)                => NULL,
    _src_bureau_vo_fseen = NULL => -1,
                                   if ((sysdate - _src_bureau_vo_fseen) / (365.25 / 12) >= 0, truncate((sysdate - _src_bureau_vo_fseen) / (365.25 / 12)), roundup((sysdate - _src_bureau_vo_fseen) / (365.25 / 12))));

src_bureau_vo_lseen := map(
    Models.Common.findw_cpp(ver_sources, 'VO' , ', ', 'E') = 0                                                   => '',
    Models.Common.getw(ver_sources_last_seen, Models.Common.findw_cpp(ver_sources, 'VO' , ', ', 'E'), ',') = '0' => '',
                                                                                                                    Models.Common.getw(ver_sources_last_seen, Models.Common.findw_cpp(ver_sources, 'VO' , ', ', 'E'), ','));

_src_bureau_vo_lseen := common.sas_date(src_bureau_vo_lseen);

mth_ver_src_ldate_vo := map(
    not(truedid)                => NULL,
    _src_bureau_vo_lseen = NULL => -1,
                                   if ((sysdate - _src_bureau_vo_lseen) / (365.25 / 12) >= 0, truncate((sysdate - _src_bureau_vo_lseen) / (365.25 / 12)), roundup((sysdate - _src_bureau_vo_lseen) / (365.25 / 12))));

mth_ver_src_fdate_vo60 := mth_ver_src_fdate_vo > 60;

mth_ver_src_ldate_vo0 := mth_ver_src_ldate_vo = 0;

src_bureau_w_lseen := map(
    Models.Common.findw_cpp(ver_sources, 'W' , ', ', 'E') = 0                                                   => '',
    Models.Common.getw(ver_sources_last_seen, Models.Common.findw_cpp(ver_sources, 'W' , ', ', 'E'), ',') = '0' => '',
                                                                                                                   Models.Common.getw(ver_sources_last_seen, Models.Common.findw_cpp(ver_sources, 'W' , ', ', 'E'), ','));

_src_bureau_w_lseen := common.sas_date(src_bureau_w_lseen);

mth_ver_src_ldate_w := map(
    not(truedid)               => NULL,
    _src_bureau_w_lseen = NULL => -1,
                                  if ((sysdate - _src_bureau_w_lseen) / (365.25 / 12) >= 0, truncate((sysdate - _src_bureau_w_lseen) / (365.25 / 12)), roundup((sysdate - _src_bureau_w_lseen) / (365.25 / 12))));

mth_ver_src_ldate_w0 := mth_ver_src_ldate_w = 0;

src_bureau_wp_lseen := map(
    Models.Common.findw_cpp(ver_sources, 'WP' , ', ', 'E') = 0                                                   => '',
    Models.Common.getw(ver_sources_last_seen, Models.Common.findw_cpp(ver_sources, 'WP' , ', ', 'E'), ',') = '0' => '',
                                                                                                                    Models.Common.getw(ver_sources_last_seen, Models.Common.findw_cpp(ver_sources, 'WP' , ', ', 'E'), ','));

_src_bureau_wp_lseen := common.sas_date(src_bureau_wp_lseen);

mth_ver_src_ldate_wp := map(
    not(truedid)                => NULL,
    _src_bureau_wp_lseen = NULL => -1,
                                   if ((sysdate - _src_bureau_wp_lseen) / (365.25 / 12) >= 0, truncate((sysdate - _src_bureau_wp_lseen) / (365.25 / 12)), roundup((sysdate - _src_bureau_wp_lseen) / (365.25 / 12))));

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

src_white_pages_adl_fseen := map(
    Models.Common.findw_cpp(ver_sources, 'WP' , ', ', 'E') = 0                                                    => '',
    Models.Common.getw(ver_sources_first_seen, Models.Common.findw_cpp(ver_sources, 'WP' , ', ', 'E'), ',') = '0' => '',
                                                                                                                     Models.Common.getw(ver_sources_first_seen, Models.Common.findw_cpp(ver_sources, 'WP' , ', ', 'E'), ','));

_src_white_pages_adl_fseen := common.sas_date(src_white_pages_adl_fseen);

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

// iv_sr001_source_profile := if(not(truedid), NULL, max((real)0, round(100 - 500 * source_mod6/0.1)*0.1));  // original converted ecl

source_temp := round(500 * source_mod6/0.1) * 0.1;
iv_sr001_source_profile := if(not(truedid), NULL, max((real)0, round((100 - source_temp) * 10) / 10));
																															 
email_src_im := Models.Common.findw_cpp(email_source_list, 'IM' , ', ', 'E') > 0;

iv_ds001_impulse_count := map(
    not(truedid)                           => NULL,
    impulse_count = 0 and email_src_im     => 1,
                                              impulse_count);

iv_ms001_ssns_per_adl := map(
    not(truedid)     => NULL,
    ssns_per_adl = 0 => 1,
                        ssns_per_adl);

iv_pv001_inp_avm_autoval := if(not(add1_pop), NULL, add1_avm_automated_valuation);

iv_src_property_adl_count := if(not(truedid), NULL, max(if(max((integer)Models.Common.getw(ver_sources_count, Models.Common.findw_cpp(ver_sources, 'P' , ', ', 'E'), ',')) = NULL, NULL, sum(if((integer)Models.Common.getw(ver_sources_count, Models.Common.findw_cpp(ver_sources, 'P' , ', ', 'E'), ',') = NULL, 0, (integer)Models.Common.getw(ver_sources_count, Models.Common.findw_cpp(ver_sources, 'P' , ', ', 'E'), ',')))), 0));

iv_inp_addr_ownership_lvl := map(
    not(add1_pop)        => '            ',
    add1_applicant_owned => 'Applicant   ',
    add1_family_owned    => 'Family      ',
    add1_occupant_owned  => 'Occupant    ',
                            'No Ownership');

iv_recent_disconnects := if(not(hphnpop), NULL, recent_disconnects);

iv_inq_recency := map(
    not(truedid) 		=> NULL,
    inq_count01 >0 	=> 1,
    inq_count03 >0  => 3,
    inq_count06 >0  => 6,
    inq_count12 >0  => 12,
    inq_count24 >0  => 24,
    inq_count   >0  => 99,
											 0);

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
                               trim((string)nap_phn_ver_lvl, LEFT, RIGHT) + trim(' - ', LEFT, RIGHT) + trim((string)inf_phn_ver_lvl, LEFT, RIGHT));

iv_attr_addrs_recency := map(
    not(truedid)      		=> NULL,
    attr_addrs_last30 >0 	=> 1,
    attr_addrs_last90 >0 	=> 3,
    attr_addrs_last12 >0 	=> 12,
    attr_addrs_last24 >0 	=> 24,
    attr_addrs_last36 >0 	=> 36,
    addrs_5yr         >0 	=> 60,
    addrs_10yr        >0 	=> 120,
    addrs_15yr        >0 	=> 180,
    addrs_per_adl > 0 		=> 999,
														 0);

iv_eviction_count := if(not(truedid), NULL, attr_eviction_count);

iv_derog_diff := if(not(truedid), NULL, min(if(max(attr_num_nonderogs - attr_total_number_derogs, -10) = NULL, -NULL, max(attr_num_nonderogs - attr_total_number_derogs, -10)), 10));

iv_criminal_count := if(not(truedid), NULL, criminal_count);

iv_ams_college_code := map(
    not(truedid)            => '  ',
    ams_college_code = ''	  => '-1',
                               trim(ams_college_code, LEFT));

iv_prof_license_category := map(
    not(truedid)                 => '  ',
    prof_license_category = '' 	 => '-1',
                                    prof_license_category);

iv_pb_total_orders := map(
    not(truedid)           						=> NULL,
    (integer)pb_total_orders = 0 			=> -1,
																				 (integer)pb_total_orders);

subscore0 := map(
    (iv_inq_recency in [1])  => -0.525445,
    (iv_inq_recency in [3])  => -0.293101,
    (iv_inq_recency in [6])  => -0.082839,
    (iv_inq_recency in [12]) => 0.099609,
    (iv_inq_recency in [0])  => 0.152623,
                                0.000000);

subscore1 := map(
    NULL < iv_ds001_impulse_count AND iv_ds001_impulse_count < 1 => 0.060639,
    1 <= iv_ds001_impulse_count                                  => -0.444870,
                                                                    -0.000000);

subscore2 := map(
    NULL < iv_derog_diff AND iv_derog_diff < -3 => -0.457099,
    -3 <= iv_derog_diff AND iv_derog_diff < -2  => -0.254680,
    -2 <= iv_derog_diff AND iv_derog_diff < -1  => -0.189784,
    -1 <= iv_derog_diff AND iv_derog_diff < 1   => -0.136305,
    1 <= iv_derog_diff AND iv_derog_diff < 2    => -0.054528,
    2 <= iv_derog_diff AND iv_derog_diff < 3    => 0.046926,
    3 <= iv_derog_diff AND iv_derog_diff < 4    => 0.074958,
    4 <= iv_derog_diff AND iv_derog_diff < 5    => 0.081217,
    5 <= iv_derog_diff                          => 0.108357,
                                                   0.000000);

subscore3 := map(
    NULL < iv_pb_total_orders AND iv_pb_total_orders < 1 => -0.134032,
    1 <= iv_pb_total_orders AND iv_pb_total_orders < 2   => -0.037656,
    2 <= iv_pb_total_orders AND iv_pb_total_orders < 4   => -0.023816,
    4 <= iv_pb_total_orders AND iv_pb_total_orders < 7   => 0.074920,
    7 <= iv_pb_total_orders AND iv_pb_total_orders < 22  => 0.161684,
    22 <= iv_pb_total_orders                             => 0.229270,
                                                            -0.000000);

subscore4 := map(
    NULL < iv_ms001_ssns_per_adl AND iv_ms001_ssns_per_adl < 2 => 0.058296,
    2 <= iv_ms001_ssns_per_adl AND iv_ms001_ssns_per_adl < 3   => -0.055018,
    3 <= iv_ms001_ssns_per_adl AND iv_ms001_ssns_per_adl < 4   => -0.202350,
    4 <= iv_ms001_ssns_per_adl AND iv_ms001_ssns_per_adl < 5   => -0.328530,
    5 <= iv_ms001_ssns_per_adl                                 => -0.651012,
                                                                  0.000000);

subscore5 := map(
    NULL < iv_src_property_adl_count AND iv_src_property_adl_count < 1 => -0.098445,
    1 <= iv_src_property_adl_count AND iv_src_property_adl_count < 2   => 0.019743,
    2 <= iv_src_property_adl_count AND iv_src_property_adl_count < 3   => 0.055910,
    3 <= iv_src_property_adl_count AND iv_src_property_adl_count < 6   => 0.094462,
    6 <= iv_src_property_adl_count                                     => 0.269872,
                                                                          -0.000000);

subscore6 := map(
    (iv_inp_addr_ownership_lvl in ['Other'])              => 0.000000,
    (iv_inp_addr_ownership_lvl in ['Applicant'])          => 0.111580,
    (iv_inp_addr_ownership_lvl in ['No Ownership'])       => 0.005857,
    (iv_inp_addr_ownership_lvl in ['Family', 'Occupant']) => -0.103552,
                                                             0.000000);

subscore7 := map(
    (iv_nap_phn_ver_x_inf_phn_ver in ['-1'])                                                          => 0.000000,
    (iv_nap_phn_ver_x_inf_phn_ver in ['0-0', '0-1', '1-0', '1-1', '1-3', '2-0', '2-1', '3-1', '3-3']) => -0.068788,
    (iv_nap_phn_ver_x_inf_phn_ver in ['0-3', '2-3'])                                                  => 0.060212,
    (iv_nap_phn_ver_x_inf_phn_ver in ['3-0'])                                                         => 0.161740,
                                                                                                         0.000000);

subscore8 := map(
    (iv_attr_addrs_recency in [1])                 => -0.174565,
    (iv_attr_addrs_recency in [3])                 => -0.089096,
    (iv_attr_addrs_recency in [12])                => -0.062673,
    (iv_attr_addrs_recency in [24])                => 0.028419,
    (iv_attr_addrs_recency in [36])                => 0.033985,
    (iv_attr_addrs_recency in [60, 120, 180, 999]) => 0.111885,
                                                      0.000000);

subscore9 := map(
    NULL < iv_eviction_count AND iv_eviction_count < 1 => 0.020887,
    1 <= iv_eviction_count                             => -0.199195,
                                                          0.000000);

subscore10 := map(
    NULL < iv_recent_disconnects AND iv_recent_disconnects < 1 => 0.020439,
    1 <= iv_recent_disconnects                                 => -0.191400,
                                                                  0.000000);

subscore11 := map(
    NULL < iv_criminal_count AND iv_criminal_count < 1 => 0.012074,
    1 <= iv_criminal_count                             => -0.323016,
                                                          0.000000);

subscore12 := map(
    NULL < iv_pv001_inp_avm_autoval AND iv_pv001_inp_avm_autoval < 1        => 0.006826,
    1 <= iv_pv001_inp_avm_autoval AND iv_pv001_inp_avm_autoval < 72681      => -0.112852,
    72681 <= iv_pv001_inp_avm_autoval AND iv_pv001_inp_avm_autoval < 136332 => -0.077126,
    136332 <= iv_pv001_inp_avm_autoval                                      => 0.060884,
                                                                               0.000000);

subscore13 := map(
    NULL < iv_sr001_source_profile AND iv_sr001_source_profile < 0.1   => 0.000000,
    0.1 <= iv_sr001_source_profile AND iv_sr001_source_profile < 52    => -0.059635,
    52 <= iv_sr001_source_profile AND iv_sr001_source_profile < 66.4   => -0.032387,
    66.4 <= iv_sr001_source_profile AND iv_sr001_source_profile < 75.3 => -0.018703,
    75.3 <= iv_sr001_source_profile AND iv_sr001_source_profile < 80.3 => 0.031199,
    80.3 <= iv_sr001_source_profile                                    => 0.086772,
                                                                          0.000000);

subscore14 := map(
    (iv_ams_college_code in ['Other'])   => 0.000000,
    (iv_ams_college_code in ['-1', '2']) => -0.010661,
    (iv_ams_college_code in ['1', '4'])  => 0.137352,
                                            0.000000);

subscore15 := map(
    (iv_prof_license_category in ['Other'])             => 0.000000,
    (iv_prof_license_category in ['-1', '0', '1', '2']) => -0.005907,
    (iv_prof_license_category in ['3', '4', '5'])       => 0.093345,
                                                           0.000000);

rawscore := subscore0 +
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
    subscore11 +
    subscore12 +
    subscore13 +
    subscore14 +
    subscore15;

lnoddsscore := rawscore + 0.255101;

probscore := exp(lnoddsscore) / (1 + exp(lnoddsscore));

base := 700;

point := 40;

odds := (1 - 0.437) / 0.437;

iv_riskview_222s := riskview.constants.noscore(le.iid.nas_summary,le.iid.nap_summary, le.address_verification.input_address_information.naprop, le.truedid);

iv_ssn_deceased := rc_decsflag = '1' or contains_i(ver_sources, 'DS') > 0;

rvg1304_2 := map(
    iv_ssn_deceased 		=> 200,
    iv_riskview_222s    => 222,
                           min(if(max(round(point * (ln(probscore / (1 - probscore)) - ln(odds)) / ln(2) + base), 501) = NULL, -NULL, max(round(point * (ln(probscore / (1 - probscore)) - ln(odds)) / ln(2) + base), 501)), 900));

iv_combined_age := map(
    not(truedid or dobpop) 					=> NULL,
    age > 0                					=> age,
    (integer)input_dob_age > 0      => (integer)input_dob_age,
    inferred_age > 0       					=> inferred_age,
    (integer)ams_age > 0            => (integer)ams_age,
																			 -1);

bk_flag := filing_count > 0;

crim_flag := criminal_count > 0;

lien_flag := liens_recent_unreleased_count > 0 or liens_historical_unreleased_ct > 0;

iv_pots_phone := if((telcordia_type in ['00', '50', '51', '52', '54']), 1, 0);

glrc9q := truedid and inq_count12 > 0;

glrc9h := truedid and impulse_count > 0;

glrc9w := truedid and bankrupt;

glrc97 := truedid and criminal_count > 0;

glrc98 := truedid and (liens_recent_unreleased_count > 0 or liens_historical_unreleased_ct > 0);

glrc9e := truedid and addrpop and attr_total_number_derogs = 0 and attr_num_nonderogs < 4;

glrcms := truedid and ssns_per_adl > 2;

glrc9a := truedid and property_owned_total = 0 and (add1_naprop in [0, 1, 2]) and iv_src_property_adl_count = 0;

glrc9b := truedid and property_owned_total = 0 and (add1_naprop in [0, 1, 2]) and iv_src_property_adl_count > 0;

glrc9o := hphnpop and addrpop and (nap_summary in [0, 1, 2, 3, 4]) and iv_pots_phone = 1;

glrc9d := truedid and attr_addrs_last12 > 0;

glrcev := truedid and attr_eviction_count > 0;

glrc07 := hphnpop and (rc_hriskphoneflag = '5' or trim(trim(nap_status, LEFT), LEFT, RIGHT) = 'D');

glrcpv := truedid and addrpop and add1_avm_automated_valuation > 0;

glrc9f := truedid and iv_sr001_source_profile < 70;

glrc9i := truedid and 0 < iv_combined_age AND iv_combined_age < 30 and not((ams_college_code in ['1', '2', '4']));

glrcbl := 0;

rcvalue9q_1 := 0.152623 - subscore0;

rcvalue9q := (integer)glrc9q * if(max(rcvalue9q_1) = NULL, NULL, sum(if(rcvalue9q_1 = NULL, 0, rcvalue9q_1)));

rcvalue9h_1 := 0.060639 - subscore1;

rcvalue9h := (integer)glrc9h * if(max(rcvalue9h_1) = NULL, NULL, sum(if(rcvalue9h_1 = NULL, 0, rcvalue9h_1)));

rcvaluems_1 := 0.058296 - subscore4;

rcvaluems := (integer)glrcms * if(max(rcvaluems_1) = NULL, NULL, sum(if(rcvaluems_1 = NULL, 0, rcvaluems_1)));

rcvalue9a_1 := 0.269872 - subscore5;

rcvalue9a_2 := 0.11158 - subscore6;

rcvalue9a := (integer)glrc9a * if(max(rcvalue9a_1, rcvalue9a_2) = NULL, NULL, sum(if(rcvalue9a_1 = NULL, 0, rcvalue9a_1), if(rcvalue9a_2 = NULL, 0, rcvalue9a_2)));

rcvalue9b_1 := 0.269872 - subscore5;

rcvalue9b := (integer)glrc9b * if(max(rcvalue9b_1) = NULL, NULL, sum(if(rcvalue9b_1 = NULL, 0, rcvalue9b_1)));

rcvalue9o_1 := 0.16174 - subscore7;

rcvalue9o := (integer)glrc9o * if(max(rcvalue9o_1) = NULL, NULL, sum(if(rcvalue9o_1 = NULL, 0, rcvalue9o_1)));

rcvalue9d_1 := 0.111885 - subscore8;

rcvalue9d := (integer)glrc9d * if(max(rcvalue9d_1) = NULL, NULL, sum(if(rcvalue9d_1 = NULL, 0, rcvalue9d_1)));

rcvalueev_1 := 0.020887 - subscore9;

rcvalueev := (integer)glrcev * if(max(rcvalueev_1) = NULL, NULL, sum(if(rcvalueev_1 = NULL, 0, rcvalueev_1)));

rcvalue07_1 := 0.020439 - subscore10;

rcvalue07 := (integer)glrc07 * if(max(rcvalue07_1) = NULL, NULL, sum(if(rcvalue07_1 = NULL, 0, rcvalue07_1)));

rcvaluepv_1 := 0.060884 - subscore12;

rcvaluepv := (integer)glrcpv * if(max(rcvaluepv_1) = NULL, NULL, sum(if(rcvaluepv_1 = NULL, 0, rcvaluepv_1)));

rcvalue9f_1 := 0.086772 - subscore13;

rcvalue9f := (integer)glrc9f * if(max(rcvalue9f_1) = NULL, NULL, sum(if(rcvalue9f_1 = NULL, 0, rcvalue9f_1)));

rcvalue9i_1 := 0.137352 - subscore14;

rcvalue9i := (integer)glrc9i * if(max(rcvalue9i_1) = NULL, NULL, sum(if(rcvalue9i_1 = NULL, 0, rcvalue9i_1)));

rcvalue9e_1 := 0.108357 - subscore2;

rcvalue9e := (integer)glrc9e * if(max(rcvalue9e_1) = NULL, NULL, sum(if(rcvalue9e_1 = NULL, 0, rcvalue9e_1)));

rcvalue98_1 := if(lien_flag, (integer)lien_flag / if(max((integer)bk_flag, (integer)crim_flag, (integer)lien_flag) = NULL, NULL, sum((integer)bk_flag, (integer)crim_flag, (integer)lien_flag)) * (0.108357 - subscore2), 0);

rcvalue98 := (integer)glrc98 * if(max(rcvalue98_1) = NULL, NULL, sum(if(rcvalue98_1 = NULL, 0, rcvalue98_1)));

rcvalue9w_1 := if(bk_flag, (integer)bk_flag / if(max((integer)bk_flag, (integer)crim_flag, (integer)lien_flag) = NULL, NULL, sum((integer)bk_flag, (integer)crim_flag, (integer)lien_flag)) * (0.108357 - subscore2), 0);

rcvalue9w := (integer)glrc9w * if(max(rcvalue9w_1) = NULL, NULL, sum(if(rcvalue9w_1 = NULL, 0, rcvalue9w_1)));

rcvalue97_1 := if(crim_flag, (integer)crim_flag / if(max((integer)bk_flag, (integer)crim_flag, (integer)lien_flag) = NULL, NULL, sum((integer)bk_flag, (integer)crim_flag, (integer)lien_flag)) * (0.108357 - subscore2), 0);

rcvalue97_2 := 0.012074 - subscore11;

rcvalue97 := (integer)glrc97 * if(max(rcvalue97_1, rcvalue97_2) = NULL, NULL, sum(if(rcvalue97_1 = NULL, 0, rcvalue97_1), if(rcvalue97_2 = NULL, 0, rcvalue97_2)));

rcvaluebl_1 := 0.22927 - subscore3;

rcvaluebl_2 := 0.093345 - subscore15;

rcvaluebl := glrcbl * if(max(rcvaluebl_1, rcvaluebl_2) = NULL, NULL, sum(if(rcvaluebl_1 = NULL, 0, rcvaluebl_1), if(rcvaluebl_2 = NULL, 0, rcvaluebl_2)));

//*************************************************************************************//
// I have no idea how the reason code logic gets implemented in ECL, so everything below 
// probably needs to get changed or replaced.  The methodology for creating the reason codes is
// very similar to the logic used by the RiskView 4.0 scores, so you might want to consult
// that model code for guidance on implementing reason codes. 
//*************************************************************************************//

ds_layout := {STRING rc, REAL value};
rc_dataset := DATASET([
    {'9Q', RCValue9Q},
    {'9H', RCValue9H},
    {'MS', RCValueMS},
    {'9A', RCValue9A},
    {'9B', RCValue9B},
    {'9O', RCValue9O},
    {'9D', RCValue9D},
    {'EV', RCValueEV},
    {'07', RCValue07},
    {'PV', RCValuePV},
    {'9F', RCValue9F},
    {'9I', RCValue9I},
    {'9E', RCValue9E},
    {'98', RCValue98},
    {'9W', RCValue9W},
    {'97', RCValue97},
    {'BL', RCValueBL}
    ], ds_layout)(value > 0);

rcs_top4 := CHOOSEN(SORT(rc_dataset, -value), 4); // Take the top four reason codes
	
	rcs_9q1 := rcs_top4[1];
	rcs_9q2 := IF(rcs_top4[2].rc = '' and rcs_top4[1].rc not in ['', '36'], 		//If only one reason code is set and it's not '36', set RC2 to '36'
								ROW({'36', NULL}, ds_layout), 
								rcs_top4[2]);
	rcs_9q3 := rcs_top4[3];
	rcs_9q4 := rcs_top4[4];
	rcs_9q5 := IF(glrc9q and inq_count12 > 0 AND NOT EXISTS(rcs_top4 (rc in ['9Q'])),  	// Check to see if RC 9Q is a part of the score, but not in the first 4 RC's
								ROW({'9Q', NULL}, ds_layout)); 																				// If so - make it the 5th reason code.
	
	
	rcs_9q := rcs_9q1 & rcs_9q2 & rcs_9q3 & rcs_9q4 & rcs_9q5;
	
	rcs_override := MAP(
											rvg1304_2 = 200 							=> DATASET([{'02', NULL}], ds_layout),
											rvg1304_2 = 222 							=> DATASET([{'9X', NULL}], ds_layout),
											rvg1304_2 = 900 							=> DATASET([{'  ', NULL}], ds_layout),
											NOT EXISTS(rcs_9q(rc != '')) 	=> DATASET([{'36', NULL}], ds_layout),
																											 rcs_9q
										 );

	riTemp := RiskWiseFCRA.corrReasonCodes(le.consumerflags, 4);

	rcs_final := PROJECT(rcs_override, TRANSFORM(Risk_Indicators.Layout_Desc,
				SELF.hri := LEFT.rc,
				SELF.desc := Risk_Indicators.getHRIDesc(LEFT.rc)
			));

	inCalif := isCalifornia AND (
				(integer)(boolean)le.iid.combo_firstcount+(integer)(boolean)le.iid.combo_lastcount
				+(integer)(boolean)le.iid.combo_addrcount+(integer)(boolean)le.iid.combo_hphonecount
				+(integer)(boolean)le.iid.combo_ssncount+(integer)(boolean)le.iid.combo_dobcount) < 3;
			
	ri := MAP(
						riTemp[1].hri <> '00' => riTemp,
						inCalif => DATASET([{'35', Risk_Indicators.getHRIDesc('35')}, {'00',''}, {'00',''}, {'00',''}, {'00',''}], Risk_Indicators.Layout_Desc),
						rcs_final
						);
					
	zeros := DATASET([{'00',''}, {'00',''}, {'00',''}, {'00',''}, {'00',''}], Risk_Indicators.Layout_Desc);
	
	reasons := CHOOSEN(ri & zeros, 5); // Keep up to 5 reason codes

//Intermediate variables
	#if(RVG_DEBUG)
	  self.clam															:= le;
		self.sysdate                          := sysdate;
		self.src_bureau_vo_fseen              := src_bureau_vo_fseen;
		self._src_bureau_vo_fseen             := _src_bureau_vo_fseen;
		self.mth_ver_src_fdate_vo             := mth_ver_src_fdate_vo;
		self.src_bureau_vo_lseen              := src_bureau_vo_lseen;
		self._src_bureau_vo_lseen             := _src_bureau_vo_lseen;
		self.mth_ver_src_ldate_vo             := mth_ver_src_ldate_vo;
		self.mth_ver_src_fdate_vo60           := mth_ver_src_fdate_vo60;
		self.mth_ver_src_ldate_vo0            := mth_ver_src_ldate_vo0;
		self.src_bureau_w_lseen               := src_bureau_w_lseen;
		self._src_bureau_w_lseen              := _src_bureau_w_lseen;
		self.mth_ver_src_ldate_w              := mth_ver_src_ldate_w;
		self.mth_ver_src_ldate_w0             := mth_ver_src_ldate_w0;
		self.src_bureau_wp_lseen              := src_bureau_wp_lseen;
		self._src_bureau_wp_lseen             := _src_bureau_wp_lseen;
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
		self.src_white_pages_adl_fseen        := src_white_pages_adl_fseen;
		self._src_white_pages_adl_fseen       := _src_white_pages_adl_fseen;
		self.iv_sr001_m_wp_adl_fs             := iv_sr001_m_wp_adl_fs;
		self.src_m_wp_adl_fs                  := src_m_wp_adl_fs;
		self._header_first_seen               := _header_first_seen;
		self.iv_sr001_m_hdr_fs                := iv_sr001_m_hdr_fs;
		self.src_m_hdr_fs                     := src_m_hdr_fs;
		self.source_mod6                      := source_mod6;
		self.iv_sr001_source_profile          := iv_sr001_source_profile;
		self.email_src_im                     := email_src_im;
		self.iv_ds001_impulse_count           := iv_ds001_impulse_count;
		self.iv_ms001_ssns_per_adl            := iv_ms001_ssns_per_adl;
		self.iv_pv001_inp_avm_autoval         := iv_pv001_inp_avm_autoval;
		self.iv_src_property_adl_count        := iv_src_property_adl_count;
		self.iv_inp_addr_ownership_lvl        := iv_inp_addr_ownership_lvl;
		self.iv_recent_disconnects            := iv_recent_disconnects;
		self.iv_inq_recency                   := iv_inq_recency;
		self.ver_phn_inf                      := ver_phn_inf;
		self.ver_phn_nap                      := ver_phn_nap;
		self.inf_phn_ver_lvl                  := inf_phn_ver_lvl;
		self.nap_phn_ver_lvl                  := nap_phn_ver_lvl;
		self.iv_nap_phn_ver_x_inf_phn_ver     := iv_nap_phn_ver_x_inf_phn_ver;
		self.iv_attr_addrs_recency            := iv_attr_addrs_recency;
		self.iv_eviction_count                := iv_eviction_count;
		self.iv_derog_diff                    := iv_derog_diff;
		self.iv_criminal_count                := iv_criminal_count;
		self.iv_ams_college_code              := iv_ams_college_code;
		self.iv_prof_license_category         := iv_prof_license_category;
		self.iv_pb_total_orders               := iv_pb_total_orders;
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
		self.subscore12                       := subscore12;
		self.subscore13                       := subscore13;
		self.subscore14                       := subscore14;
		self.subscore15                       := subscore15;
		self.rawscore                         := rawscore;
		self.lnoddsscore                      := lnoddsscore;
		self.probscore                        := probscore;
		self.base                             := base;
		self.point                            := point;
		self.odds                             := odds;
		self.iv_riskview_222s                 := iv_riskview_222s;
		self.iv_ssn_deceased                  := iv_ssn_deceased;
		self.rvg1304_2                        := rvg1304_2;
		self.iv_combined_age                  := iv_combined_age;
		self.bk_flag                          := bk_flag;
		self.crim_flag                        := crim_flag;
		self.lien_flag                        := lien_flag;
		self.iv_pots_phone                    := iv_pots_phone;
		self.glrc9q                           := glrc9q;
		self.glrc9h                           := glrc9h;
		self.glrc9w                           := glrc9w;
		self.glrc97                           := glrc97;
		self.glrc98                           := glrc98;
		self.glrc9e                           := glrc9e;
		self.glrcms                           := glrcms;
		self.glrc9a                           := glrc9a;
		self.glrc9b                           := glrc9b;
		self.glrc9o                           := glrc9o;
		self.glrc9d                           := glrc9d;
		self.glrcev                           := glrcev;
		self.glrc07                           := glrc07;
		self.glrcpv                           := glrcpv;
		self.glrc9f                           := glrc9f;
		self.glrc9i                           := glrc9i;
		self.glrcbl                           := glrcbl;
		self.rcvalue9q_1                      := rcvalue9q_1;
		self.rcvalue9q                        := rcvalue9q;
		self.rcvalue9h_1                      := rcvalue9h_1;
		self.rcvalue9h                        := rcvalue9h;
		self.rcvaluems_1                      := rcvaluems_1;
		self.rcvaluems                        := rcvaluems;
		self.rcvalue9a_1                      := rcvalue9a_1;
		self.rcvalue9a_2                      := rcvalue9a_2;
		self.rcvalue9a                        := rcvalue9a;
		self.rcvalue9b_1                      := rcvalue9b_1;
		self.rcvalue9b                        := rcvalue9b;
		self.rcvalue9o_1                      := rcvalue9o_1;
		self.rcvalue9o                        := rcvalue9o;
		self.rcvalue9d_1                      := rcvalue9d_1;
		self.rcvalue9d                        := rcvalue9d;
		self.rcvalueev_1                      := rcvalueev_1;
		self.rcvalueev                        := rcvalueev;
		self.rcvalue07_1                      := rcvalue07_1;
		self.rcvalue07                        := rcvalue07;
		self.rcvaluepv_1                      := rcvaluepv_1;
		self.rcvaluepv                        := rcvaluepv;
		self.rcvalue9f_1                      := rcvalue9f_1;
		self.rcvalue9f                        := rcvalue9f;
		self.rcvalue9i_1                      := rcvalue9i_1;
		self.rcvalue9i                        := rcvalue9i;
		self.rcvalue9e_1                      := rcvalue9e_1;
		self.rcvalue9e                        := rcvalue9e;
		self.rcvalue98_1                      := rcvalue98_1;
		self.rcvalue98                        := rcvalue98;
		self.rcvalue9w_1                      := rcvalue9w_1;
		self.rcvalue9w                        := rcvalue9w;
		self.rcvalue97_1                      := rcvalue97_1;
		self.rcvalue97_2                      := rcvalue97_2;
		self.rcvalue97                        := rcvalue97;
		self.rcvaluebl_1                      := rcvaluebl_1;
		self.rcvaluebl_2                      := rcvaluebl_2;
		self.rcvaluebl                        := rcvaluebl;
		self.rc1                              := reasons[1].hri;
		self.rc2                              := reasons[2].hri;
		self.rc3                              := reasons[3].hri;
		self.rc4                              := reasons[4].hri;
		self.rc5                              := reasons[5].hri;
	#end
		SELF.ri := PROJECT(reasons, TRANSFORM(Risk_Indicators.Layout_Desc,
																							SELF.hri := if(LEFT.hri='', '00', left.hri),
																							SELF.desc := Risk_Indicators.getHRIDesc(LEFT.hri)
																					));
		self.seq := le.seq;
		
		self.score := MAP(
											reasons[1].hri IN ['91','92','93','94'] 			=> (STRING3)((INTEGER)reasons[1].hri + 10),
											reasons[1].hri='35' => '100',
											(string3)RVG1304_2
										);
END;

		model := project( clam, doModel(left) );

		return model;
END;
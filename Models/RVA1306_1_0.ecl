// RVA1306_1: CIG Financial      

import risk_indicators, riskwise, riskwisefcra, ut, std, riskview;

export RVA1306_1_0( grouped dataset(risk_indicators.Layout_Boca_Shell) clam, BOOLEAN isCalifornia = FALSE) := FUNCTION

  RVA_DEBUG := false;

  #if(RVA_DEBUG)
    layout_debug := record										 
			integer sysdate														; // sysdate
			string	 iv_vp003_phn_invalid							; // iv_vp003_phn_invalid
			string 	iv_db001_bankruptcy								; // iv_db001_bankruptcy
			boolean email_src_im											; // email_src_im
			integer iv_ds001_impulse_count						; // iv_ds001_impulse_count
			string	src_bureau_vo_fseen								; // src_bureau_vo_fseen
			integer _src_bureau_vo_fseen							; // _src_bureau_vo_fseen
			integer mth_ver_src_fdate_vo							; // mth_ver_src_fdate_vo
			string 	src_bureau_vo_lseen								; // src_bureau_vo_lseen
			integer _src_bureau_vo_lseen							; // _src_bureau_vo_lseen
			integer mth_ver_src_ldate_vo							; // mth_ver_src_ldate_vo
			boolean mth_ver_src_fdate_vo60						; // mth_ver_src_fdate_vo60
			boolean mth_ver_src_ldate_vo0							; // mth_ver_src_ldate_vo0
			string	src_bureau_w_lseen								; // src_bureau_w_lseen
			integer _src_bureau_w_lseen								; // _src_bureau_w_lseen
			integer mth_ver_src_ldate_w								; // mth_ver_src_ldate_w
			boolean mth_ver_src_ldate_w0							; // mth_ver_src_ldate_w0
			string 	src_bureau_wp_lseen								; // src_bureau_wp_lseen
			integer _src_bureau_wp_lseen							; // _src_bureau_wp_lseen
			integer mth_ver_src_ldate_wp							; // mth_ver_src_ldate_wp
			boolean mth_ver_src_ldate_wp0							; // mth_ver_src_ldate_wp0
			integer _paw_first_seen										; // _paw_first_seen
			integer mth_paw_first_seen								; // mth_paw_first_seen
			integer mth_paw_first_seen2								; // mth_paw_first_seen2
			boolean ver_src_am												; // ver_src_am
			boolean ver_src_e1												; // ver_src_e1
			boolean ver_src_e2												; // ver_src_e2
			boolean ver_src_e3												; // ver_src_e3
			boolean ver_src_pl												; // ver_src_pl
			boolean ver_src_w													; // ver_src_w
			boolean paw_dead_business_count_gt3				; // paw_dead_business_count_gt3
			boolean paw_active_phone_count_0					; // paw_active_phone_count_0
			integer _infutor_first_seen								; // _infutor_first_seen
			integer mth_infutor_first_seen						; // mth_infutor_first_seen
			integer _infutor_last_seen								; // _infutor_last_seen
			integer mth_infutor_last_seen							; // mth_infutor_last_seen
			integer infutor_i													; // infutor_i
			real 		infutor_im												; // infutor_im
			string 	src_white_pages_adl_fseen					; // src_white_pages_adl_fseen
			integer _src_white_pages_adl_fseen				; // _src_white_pages_adl_fseen
			integer iv_sr001_m_wp_adl_fs							; // iv_sr001_m_wp_adl_fs
			integer src_m_wp_adl_fs										; // src_m_wp_adl_fs
			integer _header_first_seen								; // _header_first_seen
			integer iv_sr001_m_hdr_fs									; // iv_sr001_m_hdr_fs
			integer src_m_hdr_fs											; // src_m_hdr_fs
			real 		source_mod6												; // source_mod6
			real 		iv_sr001_source_profile						; // iv_sr001_source_profile
			integer iv_sr001_source_profile_index			; // iv_sr001_source_profile_index
			integer iv_ms001_ssns_per_adl							; // iv_ms001_ssns_per_adl
			integer iv_po001_prop_own_tot							; // iv_po001_prop_own_tot
			integer iv_in001_estimated_income					; // iv_in001_estimated_income
			integer iv_iq001_inq_count12							; // iv_iq001_inq_count12
			integer iv_src_bureau_addr_count					; // iv_src_bureau_addr_count
			integer iv_addrs_5yr											; // iv_addrs_5yr
			integer iv_addr_lres_12mo_count						; // iv_addr_lres_12mo_count
			integer iv_inq_highriskcredit_recency			; // iv_inq_highriskcredit_recency
			boolean ver_phn_inf												; // ver_phn_inf
			boolean ver_phn_nap												; // ver_phn_nap
			integer inf_phn_ver_lvl										; // inf_phn_ver_lvl
			integer nap_phn_ver_lvl										; // nap_phn_ver_lvl
			string 	iv_nap_phn_ver_x_inf_phn_ver			; // iv_nap_phn_ver_x_inf_phn_ver
			integer iv_eviction_count									; // iv_eviction_count
			integer iv_unreleased_liens_ct						; // iv_unreleased_liens_ct
			real 		subscore0													; // subscore0
			real 		subscore1													; // subscore1
			real 		subscore2													; // subscore2
			real 		subscore3													; // subscore3
			real 		subscore4													; // subscore4
			real 		subscore5													; // subscore5
			real 		subscore6													; // subscore6
			real 		subscore7													; // subscore7
			real 		subscore8													; // subscore8
			real 		subscore9													; // subscore9
			real 		subscore10												; // subscore10
			real 		subscore11												; // subscore11
			real 		subscore12												; // subscore12
			real 		subscore13												; // subscore13
			real 		subscore14												; // subscore14
			real 		rawscore													; // rawscore
			real 		lnoddsscore												; // lnoddsscore
			real 		probscore													; // probscore
			real 		base															; // base
			real 		odds															; // odds
			real 		point															; // point
			boolean ssn_deceased											; // ssn_deceased
			boolean iv_riskview_222s									; // iv_riskview_222s
			integer 		rva1306_1													; // rva1306_1
			boolean glrc08														; // glrc08
			boolean glrc98														; // glrc98
			boolean glrc9a														; // glrc9a
			boolean glrc9d														; // glrc9d
			boolean glrc9e														; // glrc9e
			boolean glrc9f														; // glrc9f
			boolean glrc9h														; // glrc9h
			boolean glrc9m														; // glrc9m
			integer iv_pots_phone											; // iv_pots_phone
			boolean glrc9o														; // glrc9o
			boolean glrc9p														; // glrc9p
			boolean glrc9q														; // glrc9q
			boolean glrc9w														; // glrc9w
			boolean glrcev														; // glrcev
			boolean glrcms														; // glrcms
			boolean glrcbl														; // glrcbl
			real 		rcvalue08_1												; // rcvalue08_1
			real 		rcvalue08													; // rcvalue08
			real 		rcvalue98_1												; // rcvalue98_1
			real 		rcvalue98													; // rcvalue98
			real 		rcvalue9a_1												; // rcvalue9a_1
			real 		rcvalue9a													; // rcvalue9a
			real 		rcvalue9d_1												; // rcvalue9d_1
			real 		rcvalue9d													; // rcvalue9d
			real 		rcvalue9e_1												; // rcvalue9e_1
			real 		rcvalue9e													; // rcvalue9e
			real 		rcvalue9f_1												; // rcvalue9f_1
			real 		rcvalue9f													; // rcvalue9f
			real 		rcvalue9h_1												; // rcvalue9h_1
			real 		rcvalue9h													; // rcvalue9h
			real 		rcvalue9m_1												; // rcvalue9m_1
			real 		rcvalue9m													; // rcvalue9m
			real 		rcvalue9o_1												; // rcvalue9o_1
			real 		rcvalue9o													; // rcvalue9o
			real 		rcvalue9p_1												; // rcvalue9p_1
			real 		rcvalue9p													; // rcvalue9p
			real 		rcvalue9q_1												; // rcvalue9q_1
			real 		rcvalue9q													; // rcvalue9q
			real 		rcvalue9w_1												; // rcvalue9w_1
			real 		rcvalue9w													; // rcvalue9w
			real 		rcvalueev_1												; // rcvalueev_1
			real 		rcvalueev													; // rcvalueev
			real 		rcvaluems_1												; // rcvaluems_1
			real 		rcvaluems													; // rcvaluems
			real 		rcvaluebl_1												; // rcvaluebl_1
			real 		rcvaluebl													; // rcvaluebl
			string 	rc1																; // rc1
			string 	rc2																; // rc2
			string 	rc3																; // rc3
			string 	rc4																; // rc4
			string 	rc5																; // rc5
			
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
	rc_phonevalflag                  := le.iid.phonevalflag;
	rc_hphonevalflag                 := le.iid.hphonevalflag;
	rc_decsflag                      := le.iid.decsflag;
	rc_bansflag                      := le.iid.bansflag;
	rc_phonetype                     := le.iid.phonetype;
	combo_dobscore                   := le.iid.combo_dobscore;
	ver_sources                      := le.header_summary.ver_sources;
	ver_sources_first_seen           := le.header_summary.ver_sources_first_seen_date;
	ver_sources_last_seen            := le.header_summary.ver_sources_last_seen_date;
	ver_addr_sources                 := le.header_summary.ver_addr_sources;
	ver_addr_sources_count           := le.header_summary.ver_addr_sources_recordcount;
	addrpop                          := le.input_validation.address;
	ssnlength                        := le.input_validation.ssn_length;
	hphnpop                          := le.input_validation.homephone;
	add1_naprop                      := le.address_verification.input_address_information.naprop;
	add1_pop                         := le.addrpop;
	property_owned_total             := le.address_verification.owned.property_total;
	property_sold_total              := le.address_verification.sold.property_total;
	addrs_5yr                        := le.other_address_info.addrs_last_5years;
	unique_addr_count                := le.address_history_summary.unique_addr_cnt;
	addr_lres_12mo_count             := le.address_history_summary.lres_12mo_count;
	telcordia_type                   := le.phone_verification.telcordia_type;
	header_first_seen                := le.ssn_verification.header_first_seen;
	ssns_per_adl                     := le.velocity_counters.ssns_per_adl;
	inq_count12                      := le.acc_logs.inquiries.count12;
	inq_highriskcredit_count01       := le.acc_logs.highriskcredit.count01;
	inq_highriskcredit_count03       := le.acc_logs.highriskcredit.count03;
	inq_highriskcredit_count06       := le.acc_logs.highriskcredit.count06;
	inq_highriskcredit_count12       := le.acc_logs.highriskcredit.count12;
	paw_first_seen                   := le.employment.first_seen_date;
	paw_dead_business_count          := le.employment.dead_business_ct;
	paw_active_phone_count           := le.employment.business_active_phone_ct;
	infutor_first_seen               := le.infutor_phone.infutor_date_first_seen;
	infutor_last_seen                := le.infutor_phone.infutor_date_last_seen;
	infutor_nap                      := le.infutor_phone.infutor_nap;
	impulse_count                    := le.impulse.count;
	email_source_list                := le.email_summary.email_source_list;
	attr_eviction_count              := le.bjl.eviction_count;
	bankrupt                         := le.bjl.bankrupt;
	disposition                      := le.bjl.disposition;
	filing_count                     := le.bjl.filing_count;
	bk_recent_count                  := le.bjl.bk_recent_count;
	liens_recent_unreleased_count    := le.bjl.liens_recent_unreleased_count;
	liens_historical_unreleased_ct   := le.bjl.liens_historical_unreleased_count;
	criminal_count                   := le.bjl.criminal_count;
	estimated_income                 := le.estimated_income;

	NULL := -999999999;


	INTEGER contains_i( string haystack, string needle ) := (INTEGER)(StringLib.StringFind(haystack, needle, 1) > 0);


	BOOLEAN indexw(string source, string target, string delim) :=
		(source = target) OR
		(StringLib.StringFind(source, delim + target + delim, 1) > 0) OR
		(source[1..length(target)+1] = target + delim) OR
		(StringLib.StringReverse(source)[1..length(target)+1] = StringLib.StringReverse(target) + delim);

	sysdate := common.sas_date(if(le.historydate=999999, (STRING)Std.Date.Today(), (string6)le.historydate+'01'));

	iv_vp003_phn_invalid := map(
			not(hphnpop)                                                    => ' ',
			rc_phonevalflag = '0' or rc_hphonevalflag = '0' or rc_phonetype = '5' => '1',
																																				 '0');

	iv_db001_bankruptcy := map(
			not(truedid or (integer)ssnlength > 0)                                                                                               => '                 ',
			(disposition in ['Discharge NA', 'Discharged'])                                                                             => '1 - BK Discharged',
			(disposition in ['Dismissed'])                                                                                              => '2 - BK Dismissed ',
			(rc_bansflag in ['1', '2']) or bankrupt or contains_i(ver_sources, 'BA') > 0 or filing_count > 0 or bk_recent_count > 0 => '3 - BK Other     ',
																																																																		 '0 - No BK        ');

	email_src_im := Models.Common.findw_cpp(email_source_list, 'IM' , ', ', 'E') > 0;

	iv_ds001_impulse_count := map(
			not(truedid)                           => NULL,
			impulse_count = 0 and email_src_im 		 => 1,
																								impulse_count);

	src_bureau_vo_fseen := if(Models.Common.getw(ver_sources_first_seen, Models.Common.findw_cpp(ver_sources, 'VO' , ', ', 'E'), ',') = '0', '', Models.Common.getw(ver_sources_first_seen, Models.Common.findw_cpp(ver_sources, 'VO' , ', ', 'E'), ','));

	_src_bureau_vo_fseen := common.sas_date((string)(src_bureau_vo_fseen));

	mth_ver_src_fdate_vo := map(
			not(truedid)                => NULL,
			_src_bureau_vo_fseen = NULL => -1,
																		 if ((sysdate - _src_bureau_vo_fseen) / (365.25 / 12) >= 0, truncate((sysdate - _src_bureau_vo_fseen) / (365.25 / 12)), roundup((sysdate - _src_bureau_vo_fseen) / (365.25 / 12))));

	src_bureau_vo_lseen := if(Models.Common.getw(ver_sources_last_seen, Models.Common.findw_cpp(ver_sources, 'VO' , ', ', 'E'), ',') = '0', '', Models.Common.getw(ver_sources_last_seen, Models.Common.findw_cpp(ver_sources, 'VO' , ', ', 'E'), ','));

	_src_bureau_vo_lseen := common.sas_date((string)(src_bureau_vo_lseen));

	mth_ver_src_ldate_vo := map(
			not(truedid)                => NULL,
			_src_bureau_vo_lseen = NULL => -1,
																		 if ((sysdate - _src_bureau_vo_lseen) / (365.25 / 12) >= 0, truncate((sysdate - _src_bureau_vo_lseen) / (365.25 / 12)), roundup((sysdate - _src_bureau_vo_lseen) / (365.25 / 12))));

	mth_ver_src_fdate_vo60 := mth_ver_src_fdate_vo > 60;

	mth_ver_src_ldate_vo0 := mth_ver_src_ldate_vo = 0;

	src_bureau_w_lseen := if(Models.Common.getw(ver_sources_last_seen, Models.Common.findw_cpp(ver_sources, 'W' , ', ', 'E'), ',') = '0', '', Models.Common.getw(ver_sources_last_seen, Models.Common.findw_cpp(ver_sources, 'W' , ', ', 'E'), ','));

	_src_bureau_w_lseen := common.sas_date((string)(src_bureau_w_lseen));

	mth_ver_src_ldate_w := map(
			not(truedid)               => NULL,
			_src_bureau_w_lseen = NULL => -1,
																		if ((sysdate - _src_bureau_w_lseen) / (365.25 / 12) >= 0, truncate((sysdate - _src_bureau_w_lseen) / (365.25 / 12)), roundup((sysdate - _src_bureau_w_lseen) / (365.25 / 12))));

	mth_ver_src_ldate_w0 := mth_ver_src_ldate_w = 0;

	src_bureau_wp_lseen := if(Models.Common.getw(ver_sources_last_seen, Models.Common.findw_cpp(ver_sources, 'WP' , ', ', 'E'), ',') = '0', '', Models.Common.getw(ver_sources_last_seen, Models.Common.findw_cpp(ver_sources, 'WP' , ', ', 'E'), ','));

	_src_bureau_wp_lseen := common.sas_date((string)(src_bureau_wp_lseen));

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

	src_white_pages_adl_fseen := if(Models.Common.getw(ver_sources_first_seen, Models.Common.findw_cpp(ver_sources, 'WP' , ', ', 'E'), ',') = '0', '', Models.Common.getw(ver_sources_first_seen, Models.Common.findw_cpp(ver_sources, 'WP' , ', ', 'E'), ','));

	_src_white_pages_adl_fseen := common.sas_date((string)(src_white_pages_adl_fseen));

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

	iv_sr001_source_profile := if(not(truedid), NULL, max(0.0, round((100.0 - 500.0 * source_mod6)/0.1)*0.1));

	iv_sr001_source_profile_index := map(
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
																			 9);

	iv_ms001_ssns_per_adl := map(
			not(truedid)     => NULL,
			ssns_per_adl = 0 => 1,
													ssns_per_adl);

	iv_po001_prop_own_tot := if(not(truedid or add1_pop), NULL, property_owned_total);

	iv_in001_estimated_income := if(not(truedid), NULL, estimated_income);

	iv_iq001_inq_count12 := if(not(truedid), NULL, inq_count12);

	iv_src_bureau_addr_count := if(not(truedid), NULL, 
																	max(if(
																					max((integer)Models.Common.getw(ver_addr_sources_count, Models.Common.findw_cpp(ver_addr_sources, 'TN' , ', ', 'E'), ','), 
																							(integer)Models.Common.getw(ver_addr_sources_count, Models.Common.findw_cpp(ver_addr_sources, 'TS' , ', ', 'E'), ','), 
																							(integer)Models.Common.getw(ver_addr_sources_count, Models.Common.findw_cpp(ver_addr_sources, 'TU' , ', ', 'E'), ','), 
																							(integer)Models.Common.getw(ver_addr_sources_count, Models.Common.findw_cpp(ver_addr_sources, 'EN' , ', ', 'E'), ','), 
																							(integer)Models.Common.getw(ver_addr_sources_count, Models.Common.findw_cpp(ver_addr_sources, 'EQ' , ', ', 'E'), ',')) = NULL, NULL, 
																							sum(if(
																											(integer)Models.Common.getw(ver_addr_sources_count, Models.Common.findw_cpp(ver_addr_sources, 'TN' , ', ', 'E'), ',') = NULL, 0, 
																												(integer)Models.Common.getw(ver_addr_sources_count, Models.Common.findw_cpp(ver_addr_sources, 'TN' , ', ', 'E'), ',')
																										 ), 
																									if(
																											(integer)Models.Common.getw(ver_addr_sources_count, Models.Common.findw_cpp(ver_addr_sources, 'TS' , ', ', 'E'), ',') = NULL, 0, 
																												(integer)Models.Common.getw(ver_addr_sources_count, Models.Common.findw_cpp(ver_addr_sources, 'TS' , ', ', 'E'), ',')), 
																									if(
																											(integer)Models.Common.getw(ver_addr_sources_count, Models.Common.findw_cpp(ver_addr_sources, 'TU' , ', ', 'E'), ',') = NULL, 0, 
																												(integer)Models.Common.getw(ver_addr_sources_count, Models.Common.findw_cpp(ver_addr_sources, 'TU' , ', ', 'E'), ',')
																										), 
																									if(
																											(integer)Models.Common.getw(ver_addr_sources_count, Models.Common.findw_cpp(ver_addr_sources, 'EN' , ', ', 'E'), ',') = NULL, 0, 
																												(integer)Models.Common.getw(ver_addr_sources_count, Models.Common.findw_cpp(ver_addr_sources, 'EN' , ', ', 'E'), ',')
																										), 
																									if(
																											(integer)Models.Common.getw(ver_addr_sources_count, Models.Common.findw_cpp(ver_addr_sources, 'EQ' , ', ', 'E'), ',') = NULL, 0, 
																												(integer)Models.Common.getw(ver_addr_sources_count, Models.Common.findw_cpp(ver_addr_sources, 'EQ' , ', ', 'E'), ',')
																										)
																									)
																						)
																				 , 0));

	iv_addrs_5yr := map(
			not(truedid)          => NULL,
			unique_addr_count = 0 => -1,
															 addrs_5yr);

	iv_addr_lres_12mo_count := map(
			not(truedid)                 => NULL,
			addr_lres_12mo_count = -9999 => -1,
																			addr_lres_12mo_count);

	iv_inq_highriskcredit_recency := map(
			not(truedid)               		 => NULL,
			inq_highRiskCredit_count01 > 0 => 1,
			inq_highRiskCredit_count03 > 0 => 3,
			inq_highRiskCredit_count06 > 0 => 6,
			inq_highRiskCredit_count12 > 0 => 12,
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

	iv_eviction_count := if(not(truedid), NULL, attr_eviction_count);

	iv_unreleased_liens_ct := if(not(truedid), NULL, if(max(liens_recent_unreleased_count, liens_historical_unreleased_ct) = NULL, NULL, sum(if(liens_recent_unreleased_count = NULL, 0, liens_recent_unreleased_count), if(liens_historical_unreleased_ct = NULL, 0, liens_historical_unreleased_ct))));

	subscore0 := map(
			NULL < iv_src_bureau_addr_count AND iv_src_bureau_addr_count < 1 => -0.164825,
			1 <= iv_src_bureau_addr_count AND iv_src_bureau_addr_count < 2   => -0.013994,
			2 <= iv_src_bureau_addr_count                                    => 0.283778,
																																					-0.000000);

	subscore1 := map(
			(iv_vp003_phn_invalid in ['Other']) => 0.000000,
			(iv_vp003_phn_invalid in ['0'])     => 0.040570,
			(iv_vp003_phn_invalid in ['1'])     => -0.788742,
																						 0.000000);

	subscore2 := map(
			NULL < iv_ds001_impulse_count AND iv_ds001_impulse_count < 1 => 0.061705,
			1 <= iv_ds001_impulse_count                                  => -0.468068,
																																			0.000000);

	subscore3 := map(
			(iv_db001_bankruptcy in ['1 - BK Discharged']) => 0.305142,
			(iv_db001_bankruptcy in ['0 - No BK'])         => -0.024928,
			(iv_db001_bankruptcy in ['2 - BK Dismissed'])  => -0.256787,
			(iv_db001_bankruptcy in ['3 - BK Other'])      => -0.315829,
																												-0.000000);

	subscore4 := map(
			NULL < iv_unreleased_liens_ct AND iv_unreleased_liens_ct < 1 => 0.098014,
			1 <= iv_unreleased_liens_ct                                  => -0.180446,
																																			0.000000);

	subscore5 := map(
			(iv_nap_phn_ver_x_inf_phn_ver in ['-1'])                                     => -0.000000,
			(iv_nap_phn_ver_x_inf_phn_ver in ['0-0', '0-1', '1-0', '1-1', '1-3', '2-1']) => -0.077059,
			(iv_nap_phn_ver_x_inf_phn_ver in ['2-0', '2-3'])                             => 0.000377,
			(iv_nap_phn_ver_x_inf_phn_ver in ['0-3', '3-0', '3-1', '3-3'])               => 0.234437,
																																											-0.000000);

	subscore6 := map(
			NULL < iv_iq001_inq_count12 AND iv_iq001_inq_count12 < 1 => 0.091751,
			1 <= iv_iq001_inq_count12 AND iv_iq001_inq_count12 < 3   => -0.047047,
			3 <= iv_iq001_inq_count12 AND iv_iq001_inq_count12 < 4   => -0.121751,
			4 <= iv_iq001_inq_count12 AND iv_iq001_inq_count12 < 5   => -0.231381,
			5 <= iv_iq001_inq_count12                                => -0.270361,
																																	0.000000);

	subscore7 := map(
			(iv_sr001_source_profile_index in [-1])         => 0.000000,
			(iv_sr001_source_profile_index in [0, 1, 2, 3]) => -0.165820,
			(iv_sr001_source_profile_index in [4, 5])       => -0.026306,
			(iv_sr001_source_profile_index in [6])          => 0.102407,
			(iv_sr001_source_profile_index in [7, 8, 9])    => 0.483257,
																												 0.000000);

	subscore8 := map(
			NULL < iv_addr_lres_12mo_count AND iv_addr_lres_12mo_count < 0 => -0.000000,
			0 <= iv_addr_lres_12mo_count AND iv_addr_lres_12mo_count < 1   => 0.095306,
			1 <= iv_addr_lres_12mo_count AND iv_addr_lres_12mo_count < 2   => 0.042204,
			2 <= iv_addr_lres_12mo_count AND iv_addr_lres_12mo_count < 7   => -0.050102,
			7 <= iv_addr_lres_12mo_count                                   => -0.343415,
																																				-0.000000);

	subscore9 := map(
			NULL < iv_in001_estimated_income AND iv_in001_estimated_income < 19999   => -0.000000,
			19999 <= iv_in001_estimated_income AND iv_in001_estimated_income < 27000 => -0.068236,
			27000 <= iv_in001_estimated_income AND iv_in001_estimated_income < 32000 => -0.059831,
			32000 <= iv_in001_estimated_income AND iv_in001_estimated_income < 37000 => -0.026238,
			37000 <= iv_in001_estimated_income AND iv_in001_estimated_income < 74000 => 0.062825,
			74000 <= iv_in001_estimated_income                                       => 0.327621,
																																									-0.000000);

	subscore10 := map(
			NULL < iv_eviction_count AND iv_eviction_count < 1 => 0.037700,
			1 <= iv_eviction_count AND iv_eviction_count < 2   => -0.226969,
			2 <= iv_eviction_count                             => -0.368174,
																														-0.000000);

	subscore11 := map(
			NULL < iv_po001_prop_own_tot AND iv_po001_prop_own_tot < 1 => -0.033282,
			1 <= iv_po001_prop_own_tot AND iv_po001_prop_own_tot < 2   => 0.107633,
			2 <= iv_po001_prop_own_tot                                 => 0.395353,
																																		-0.000000);

	subscore12 := map(
			NULL < iv_addrs_5yr AND iv_addrs_5yr < 0 => 0.000000,
			0 <= iv_addrs_5yr AND iv_addrs_5yr < 1   => 0.132893,
			1 <= iv_addrs_5yr AND iv_addrs_5yr < 3   => 0.070637,
			3 <= iv_addrs_5yr AND iv_addrs_5yr < 5   => -0.026807,
			5 <= iv_addrs_5yr                        => -0.104212,
																									0.000000);

	subscore13 := map(
			(iv_inq_highriskcredit_recency in [1, 3, 6]) => -0.401455,
			(iv_inq_highriskcredit_recency in [12])      => -0.100176,
			(iv_inq_highriskcredit_recency in [0])       => 0.016918,
																											-0.000000);

	subscore14 := map(
			NULL < iv_ms001_ssns_per_adl AND iv_ms001_ssns_per_adl < 3 => 0.021447,
			3 <= iv_ms001_ssns_per_adl AND iv_ms001_ssns_per_adl < 4   => -0.058733,
			4 <= iv_ms001_ssns_per_adl AND iv_ms001_ssns_per_adl < 5   => -0.235071,
			5 <= iv_ms001_ssns_per_adl                                 => -0.362885,
																																		-0.000000);

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
			subscore14;

	lnoddsscore := rawscore + 1.573378;

	probscore := exp(lnoddsscore) / (1 + exp(lnoddsscore));

	base := 700;

	odds := (1 - 0.171) / 0.171;

	point := 40;

	ssn_deceased := rc_decsflag ='1' or indexw(StringLib.StringToUpperCase(trim(ver_sources, ALL)), 'DS', ',');

	iv_riskview_222s := riskview.constants.noscore(le.iid.nas_summary,le.iid.nap_summary, le.address_verification.input_address_information.naprop, le.truedid); 

	rva1306_1 := map(
			ssn_deceased     => 200,
			iv_riskview_222s => 222,
													min(if(max(round(point * (ln(probscore / (1 - probscore)) - ln(odds)) / ln(2) + base), 501) = NULL, -NULL, max(round(point * (ln(probscore / (1 - probscore)) - ln(odds)) / ln(2) + base), 501)), 900));

	glrc08 := hphnpop;

	glrc98 := truedid and (liens_recent_unreleased_count > 0 or liens_historical_unreleased_ct > 0);

	glrc9a := truedid and property_owned_total = 0 and not((add1_naprop in [3, 4]));

	glrc9d := truedid and addrs_5yr > 2;

	glrc9e := truedid and addrpop;

	glrc9f := truedid and (iv_sr001_source_profile_index in [0, 1, 2, 3, 4]);

	glrc9h := truedid and impulse_count > 0;

	glrc9m := truedid and 0 < estimated_income AND estimated_income < 27000;

	iv_pots_phone := if((telcordia_type in ['00', '50', '51', '52', '54']), 1, 0);

	glrc9o := hphnpop and addrpop and iv_pots_phone = 1 and (nap_summary in [0, 1, 2, 3, 4]);

	glrc9p := truedid and inq_highriskcredit_count12 > 0;

	glrc9q := truedid and inq_count12 > 0;

	glrc9w := truedid and filing_count > 0;

	glrcev := truedid and attr_eviction_count > 0;

	glrcms := truedid and ssns_per_adl > 2;

	glrcbl := 0;

	rcvalue08_1 := 0.04057 - subscore1;

	rcvalue08 := (integer)glrc08 * if(max(rcvalue08_1) = NULL, NULL, sum(if(rcvalue08_1 = NULL, 0, rcvalue08_1)));

	rcvalue98_1 := 0.098014 - subscore4;

	rcvalue98 := (integer)glrc98 * if(max(rcvalue98_1) = NULL, NULL, sum(if(rcvalue98_1 = NULL, 0, rcvalue98_1)));

	rcvalue9a_1 := 0.395353 - subscore11;

	rcvalue9a := (integer)glrc9a * if(max(rcvalue9a_1) = NULL, NULL, sum(if(rcvalue9a_1 = NULL, 0, rcvalue9a_1)));

	rcvalue9d_1 := 0.132893 - subscore12;

	rcvalue9d := (integer)glrc9d * if(max(rcvalue9d_1) = NULL, NULL, sum(if(rcvalue9d_1 = NULL, 0, rcvalue9d_1)));

	rcvalue9e_1 := 0.283778 - subscore0;

	rcvalue9e := (integer)glrc9e * if(max(rcvalue9e_1) = NULL, NULL, sum(if(rcvalue9e_1 = NULL, 0, rcvalue9e_1)));

	rcvalue9f_1 := 0.483257 - subscore7;

	rcvalue9f := (integer)glrc9f * if(max(rcvalue9f_1) = NULL, NULL, sum(if(rcvalue9f_1 = NULL, 0, rcvalue9f_1)));

	rcvalue9h_1 := 0.061705 - subscore2;

	rcvalue9h := (integer)glrc9h * if(max(rcvalue9h_1) = NULL, NULL, sum(if(rcvalue9h_1 = NULL, 0, rcvalue9h_1)));

	rcvalue9m_1 := 0.327621 - subscore9;

	rcvalue9m := (integer)glrc9m * if(max(rcvalue9m_1) = NULL, NULL, sum(if(rcvalue9m_1 = NULL, 0, rcvalue9m_1)));

	rcvalue9o_1 := 0.234437 - subscore5;

	rcvalue9o := (integer)glrc9o * if(max(rcvalue9o_1) = NULL, NULL, sum(if(rcvalue9o_1 = NULL, 0, rcvalue9o_1)));

	rcvalue9p_1 := 0.016918 - subscore13;

	rcvalue9p := (integer)glrc9p * if(max(rcvalue9p_1) = NULL, NULL, sum(if(rcvalue9p_1 = NULL, 0, rcvalue9p_1)));

	rcvalue9q_1 := 0.091751 - subscore6;

	rcvalue9q := (integer)glrc9q * if(max(rcvalue9q_1) = NULL, NULL, sum(if(rcvalue9q_1 = NULL, 0, rcvalue9q_1)));

	rcvalue9w_1 := 0.305142 - subscore3;

	rcvalue9w := (integer)glrc9w * if(max(rcvalue9w_1) = NULL, NULL, sum(if(rcvalue9w_1 = NULL, 0, rcvalue9w_1)));

	rcvalueev_1 := 0.0377 - subscore10;

	rcvalueev := (integer)glrcev * if(max(rcvalueev_1) = NULL, NULL, sum(if(rcvalueev_1 = NULL, 0, rcvalueev_1)));

	rcvaluems_1 := 0.021447 - subscore14;

	rcvaluems := (integer)glrcms * if(max(rcvaluems_1) = NULL, NULL, sum(if(rcvaluems_1 = NULL, 0, rcvaluems_1)));

	rcvaluebl_1 := 0.095306 - subscore8;

	rcvaluebl := glrcbl * if(max(rcvaluebl_1) = NULL, NULL, sum(if(rcvaluebl_1 = NULL, 0, rcvaluebl_1)));

	//*************************************************************************************//
	// I have no idea how the reason code logic gets implemented in ECL, so everything below 
	// probably needs to get changed or replaced.  The methodology for creating the reason codes is
	// very similar to the logic used by the RiskView 4.0 scores, so you might want to consult
	// that model code for guidance on implementing reason codes. 
	//*************************************************************************************//

	ds_layout := {STRING rc, REAL value};
	rc_dataset := DATASET([
			{'08', RCValue08},
			{'98', RCValue98},
			{'9A', RCValue9A},
			{'9D', RCValue9D},
			{'9E', RCValue9E},
			{'9F', RCValue9F},
			{'9H', RCValue9H},
			{'9M', RCValue9M},
			{'9O', RCValue9O},
			{'9P', RCValue9P},
			{'9Q', RCValue9Q},
			{'9W', RCValue9W},
			{'EV', RCValueEV},
			{'MS', RCValueMS},
			{'BL', RCValueBL}
			], ds_layout)(value>0);
			
	rcs_top4 := CHOOSEN(SORT(rc_dataset, -value), 4); // Take the top four reason codes

	rcs_9p1 := if(count(rcs_top4)<1, ROW({'36', NULL}, ds_layout), rcs_top4[1]);
	rcs_9p2 := IF(count(rcs_top4)<2,
									if( rcs_9p1.rc not in ['', '36'] and 500 < rva1306_1 AND rva1306_1 < 720, ROW({'36', NULL}, ds_layout), 
											    if( rcs_9p1.rc in ['36'] and 500 < rva1306_1 AND rva1306_1 < 720, ROW({'9E', NULL}, ds_layout),rcs_top4[2])),
										rcs_top4[2]);
	rcs_9p3 := rcs_top4[3];
	rcs_9p4 := rcs_top4[4];
	rcs_9p5 := IF(glrc9q and inq_count12 > 0 AND NOT EXISTS(rcs_top4 (rc in ['9Q'])),  	// Check to see if RC 9Q is a part of the score, but not in the first 4 RC's
								ROW({'9Q', NULL}, ds_layout)); 																				// If so - make it the 5th reason code.
	
	
	rcs_9p := rcs_9p1 & rcs_9p2 & rcs_9p3 & rcs_9p4 & rcs_9p5;
	
	rcs_override := MAP(
											rva1306_1 = 200 							=> DATASET([{'02', NULL}], ds_layout),
											rva1306_1 = 222 							=> DATASET([{'9X', NULL}], ds_layout),
											rva1306_1 = 900 							=> DATASET([{'  ', NULL}], ds_layout),
											NOT EXISTS(rcs_9p(rc != '')) 	=> DATASET([{'36', NULL}], ds_layout),
																											 rcs_9p
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
	#if(RVA_DEBUG)
	  self.clam															:= le;
		self.sysdate                          := sysdate;
		self.iv_vp003_phn_invalid             := iv_vp003_phn_invalid;
		self.iv_db001_bankruptcy              := iv_db001_bankruptcy;
		self.email_src_im                     := email_src_im;
		self.iv_ds001_impulse_count           := iv_ds001_impulse_count;
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
		self.iv_sr001_source_profile_index    := iv_sr001_source_profile_index;
		self.iv_ms001_ssns_per_adl            := iv_ms001_ssns_per_adl;
		self.iv_po001_prop_own_tot            := iv_po001_prop_own_tot;
		self.iv_in001_estimated_income        := iv_in001_estimated_income;
		self.iv_iq001_inq_count12             := iv_iq001_inq_count12;
		self.iv_src_bureau_addr_count         := iv_src_bureau_addr_count;
		self.iv_addrs_5yr                     := iv_addrs_5yr;
		self.iv_addr_lres_12mo_count          := iv_addr_lres_12mo_count;
		self.iv_inq_highriskcredit_recency    := iv_inq_highriskcredit_recency;
		self.ver_phn_inf                      := ver_phn_inf;
		self.ver_phn_nap                      := ver_phn_nap;
		self.inf_phn_ver_lvl                  := inf_phn_ver_lvl;
		self.nap_phn_ver_lvl                  := nap_phn_ver_lvl;
		self.iv_nap_phn_ver_x_inf_phn_ver     := iv_nap_phn_ver_x_inf_phn_ver;
		self.iv_eviction_count                := iv_eviction_count;
		self.iv_unreleased_liens_ct           := iv_unreleased_liens_ct;
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
		self.rawscore                         := rawscore;
		self.lnoddsscore                      := lnoddsscore;
		self.probscore                        := probscore;
		self.base                             := base;
		self.odds                             := odds;
		self.point                            := point;
		self.ssn_deceased                     := ssn_deceased;
		self.iv_riskview_222s                 := iv_riskview_222s;
		self.rva1306_1                        := rva1306_1;
		self.glrc08                           := glrc08;
		self.glrc98                           := glrc98;
		self.glrc9a                           := glrc9a;
		self.glrc9d                           := glrc9d;
		self.glrc9e                           := glrc9e;
		self.glrc9f                           := glrc9f;
		self.glrc9h                           := glrc9h;
		self.glrc9m                           := glrc9m;
		self.iv_pots_phone                    := iv_pots_phone;
		self.glrc9o                           := glrc9o;
		self.glrc9p                           := glrc9p;
		self.glrc9q                           := glrc9q;
		self.glrc9w                           := glrc9w;
		self.glrcev                           := glrcev;
		self.glrcms                           := glrcms;
		self.glrcbl                           := glrcbl;
		self.rcvalue08_1                      := rcvalue08_1;
		self.rcvalue08                        := rcvalue08;
		self.rcvalue98_1                      := rcvalue98_1;
		self.rcvalue98                        := rcvalue98;
		self.rcvalue9a_1                      := rcvalue9a_1;
		self.rcvalue9a                        := rcvalue9a;
		self.rcvalue9d_1                      := rcvalue9d_1;
		self.rcvalue9d                        := rcvalue9d;
		self.rcvalue9e_1                      := rcvalue9e_1;
		self.rcvalue9e                        := rcvalue9e;
		self.rcvalue9f_1                      := rcvalue9f_1;
		self.rcvalue9f                        := rcvalue9f;
		self.rcvalue9h_1                      := rcvalue9h_1;
		self.rcvalue9h                        := rcvalue9h;
		self.rcvalue9m_1                      := rcvalue9m_1;
		self.rcvalue9m                        := rcvalue9m;
		self.rcvalue9o_1                      := rcvalue9o_1;
		self.rcvalue9o                        := rcvalue9o;
		self.rcvalue9p_1                      := rcvalue9p_1;
		self.rcvalue9p                        := rcvalue9p;
		self.rcvalue9q_1                      := rcvalue9q_1;
		self.rcvalue9q                        := rcvalue9q;
		self.rcvalue9w_1                      := rcvalue9w_1;
		self.rcvalue9w                        := rcvalue9w;
		self.rcvalueev_1                      := rcvalueev_1;
		self.rcvalueev                        := rcvalueev;
		self.rcvaluems_1                      := rcvaluems_1;
		self.rcvaluems                        := rcvaluems;
		self.rcvaluebl_1                      := rcvaluebl_1;
		self.rcvaluebl                        := rcvaluebl;
		self.rc1                              := if(reasons[1].hri = '00', '', reasons[1].hri);
		self.rc2                              := if(reasons[2].hri = '00', '', reasons[2].hri);
		self.rc3                              := if(reasons[3].hri = '00', '', reasons[3].hri);
		self.rc4                              := if(reasons[4].hri = '00', '', reasons[4].hri);
		self.rc5                              := if(reasons[5].hri = '00', '', reasons[5].hri);
	#end
		SELF.ri := PROJECT(reasons, TRANSFORM(Risk_Indicators.Layout_Desc,
																							SELF.hri := if(LEFT.hri='', '00', left.hri),
																							SELF.desc := Risk_Indicators.getHRIDesc(LEFT.hri)
																					));
		self.seq := le.seq;
		
		self.score := MAP(
											reasons[1].hri IN ['91','92','93','94'] 			=> (STRING3)((INTEGER)reasons[1].hri + 10),
											reasons[1].hri='35' => '100',
											(string3)rva1306_1
										);
	END;

	model := project( clam, doModel(left) );

	return model;
END;
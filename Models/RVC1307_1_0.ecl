// Rossman & Co 
import risk_indicators, riskwise, riskwisefcra, ut, std, riskview;

export RVC1307_1_0( grouped dataset(risk_indicators.Layout_Boca_Shell) clam, BOOLEAN isCalifornia = FALSE) := FUNCTION

  RVC_DEBUG := FALSE;

  #if(RVC_DEBUG)
    layout_debug := record
			integer sysdate                       ; // := sysdate;
			boolean email_src_im                  ; // := email_src_im;
			integer iv_ds001_impulse_count        ; // := iv_ds001_impulse_count;
			integer _in_dob                       ; // := _in_dob;
			real yr_in_dob                    		 ; // := yr_in_dob;
			integer yr_in_dob_int                 ; // := yr_in_dob_int;
			integer age_estimate                  ; // := age_estimate;
			integer iv_ag001_age                  ; // := iv_ag001_age;
			integer iv_pv001_bst_avm_autoval      ; // := iv_pv001_bst_avm_autoval;
			integer iv_addr_non_phn_src_ct        ; // := iv_addr_non_phn_src_ct;
			integer iv_addrs_5yr                  ; // := iv_addrs_5yr;
			integer _gong_did_first_seen          ; // := _gong_did_first_seen;
			integer iv_mos_since_gong_did_fst_seen; // := iv_mos_since_gong_did_fst_seen;
			integer iv_non_derog_count            ; // := iv_non_derog_count;
			integer iv_liens_rel_cj_ct            ; // := iv_liens_rel_cj_ct;
			integer iv_criminal_count             ; // := iv_criminal_count;
			string iv_ams_college_code           ; // := iv_ams_college_code;
			integer iv_pb_total_orders            ; // := iv_pb_total_orders;
			integer bureau_adl_vo_fseen_pos       ; // := bureau_adl_vo_fseen_pos;
			string bureau_adl_fseen_vo            ; // := bureau_adl_fseen_vo;
			integer _bureau_adl_fseen_vo          ; // := _bureau_adl_fseen_vo;
			integer _src_bureau_adl_fseen         ; // := _src_bureau_adl_fseen;
			integer mth_ver_src_fdate_vo          ; // := mth_ver_src_fdate_vo;
			integer bureau_adl_vo_lseen_pos       ; // := bureau_adl_vo_lseen_pos;
			string bureau_adl_lseen_vo           ; // := bureau_adl_lseen_vo;
			integer _bureau_adl_lseen_vo          ; // := _bureau_adl_lseen_vo;
			integer mth_ver_src_ldate_vo          ; // := mth_ver_src_ldate_vo;
			boolean mth_ver_src_fdate_vo60        ; // := mth_ver_src_fdate_vo60;
			boolean mth_ver_src_ldate_vo0         ; // := mth_ver_src_ldate_vo0;
			integer bureau_adl_w_lseen_pos        ; // := bureau_adl_w_lseen_pos;
			string bureau_adl_lseen_w            ; // := bureau_adl_lseen_w;
			integer _bureau_adl_lseen_w           ; // := _bureau_adl_lseen_w;
			integer mth_ver_src_ldate_w           ; // := mth_ver_src_ldate_w;
			boolean mth_ver_src_ldate_w0          ; // := mth_ver_src_ldate_w0;
			integer bureau_adl_wp_lseen_pos       ; // := bureau_adl_wp_lseen_pos;
			string bureau_adl_lseen_wp           ; // := bureau_adl_lseen_wp;
			integer _bureau_adl_lseen_wp          ; // := _bureau_adl_lseen_wp;
			integer _src_bureau_adl_lseen         ; // := _src_bureau_adl_lseen;
			integer mth_ver_src_ldate_wp          ; // := mth_ver_src_ldate_wp;
			boolean mth_ver_src_ldate_wp0         ; // := mth_ver_src_ldate_wp0;
			integer _paw_first_seen               ; // := _paw_first_seen;
			integer mth_paw_first_seen            ; // := mth_paw_first_seen;
			integer mth_paw_first_seen2           ; // := mth_paw_first_seen2;
			boolean ver_src_am                    ; // := ver_src_am;
			boolean ver_src_e1                    ; // := ver_src_e1;
			boolean ver_src_e2                    ; // := ver_src_e2;
			boolean ver_src_e3                    ; // := ver_src_e3;
			boolean ver_src_pl                    ; // := ver_src_pl;
			boolean ver_src_w                     ; // := ver_src_w;
			boolean paw_dead_business_count_gt3   ; // := paw_dead_business_count_gt3;
			boolean paw_active_phone_count_0      ; // := paw_active_phone_count_0;
			integer _infutor_first_seen           ; // := _infutor_first_seen;
			integer mth_infutor_first_seen        ; // := mth_infutor_first_seen;
			integer _infutor_last_seen            ; // := _infutor_last_seen;
			integer mth_infutor_last_seen         ; // := mth_infutor_last_seen;
			integer infutor_i                     ; // := infutor_i;
			real infutor_im                    ; // := infutor_im;
			integer white_pages_adl_wp_fseen_pos  ; // := white_pages_adl_wp_fseen_pos;
			string white_pages_adl_fseen_wp      ; // := white_pages_adl_fseen_wp;
			integer _white_pages_adl_fseen_wp     ; // := _white_pages_adl_fseen_wp;
			integer _src_white_pages_adl_fseen    ; // := _src_white_pages_adl_fseen;
			integer iv_sr001_m_wp_adl_fs          ; // := iv_sr001_m_wp_adl_fs;
			integer src_m_wp_adl_fs               ; // := src_m_wp_adl_fs;
			integer _header_first_seen            ; // := _header_first_seen;
			integer iv_sr001_m_hdr_fs             ; // := iv_sr001_m_hdr_fs;
			integer src_m_hdr_fs                  ; // := src_m_hdr_fs;
			real source_mod6                   	 ; // := source_mod6;
			real iv_sr001_source_profile       	 ; // := iv_sr001_source_profile;
			real s_subscore0                   	 ; // := s_subscore0;
			real s_subscore1                   	 ; // := s_subscore1;
			real s_subscore2                   	 ; // := s_subscore2;
			real s_subscore3                   	 ; // := s_subscore3;
			real s_subscore4                   	 ; // := s_subscore4;
			real s_subscore5                   	 ; // := s_subscore5;
			real s_subscore6                   	 ; // := s_subscore6;
			real s_subscore7                   	 ; // := s_subscore7;
			real s_subscore8                   	 ; // := s_subscore8;
			real s_subscore9                  	   ; // := s_subscore9;
			real s_subscore10                  	 ; // := s_subscore10;
			real s_subscore11                  	 ; // := s_subscore11;
			real s_rawscore                    	 ; // := s_rawscore;
			real s_lnoddsscore                 	 ; // := s_lnoddsscore;
			real s_probscore                   	 ; // := s_probscore;
			integer base                          ; // := base;
			real odds                             ; // := odds;
			integer point                         ; // := point;
			boolean ssn_deceased                  ; // := ssn_deceased;
			boolean iv_riskview_222s              ; // := iv_riskview_222s;
			integer rvc1307_1                     ; // := rvc1307_1;
			string rc1                    				 ; // := rc1;
			string rc2                  			  	 ; // := rc2;
			string rc3                   				 	; // := rc3;
			string rc4                    				 ; // := rc4;
			string rc5                   				 ; // := rc5;
			boolean glrc36                        ; // := glrc36;
			boolean glrc97                        ; // := glrc97;
			boolean glrc9d                        ; // := glrc9d;
			boolean glrc9e                        ; // := glrc9e;
			boolean glrc9f                        ; // := glrc9f;
			boolean glrc9g                        ; // := glrc9g;
			boolean glrc9h                        ; // := glrc9h;
			boolean glrc9i                        ; // := glrc9i;
			boolean glrc9r                        ; // := glrc9r;
			// boolean glrc9y                        ; // := glrc9y;
			boolean glrcpv                        ; // := glrcpv;
			boolean glrcbl                        ; // := glrcbl;
			real rcvalue36_1                  	   ; // := rcvalue36_1;
			real rcvalue36                     	 ; // := rcvalue36;
			real rcvalue97_1                   	 ; // := rcvalue97_1;
			real rcvalue97                     	 ; // := rcvalue97;
			real rcvalue9d_1                   	 ; // := rcvalue9d_1;
			real rcvalue9d                     	 ; // := rcvalue9d;
			real rcvalue9e_1                   	 ; // := rcvalue9e_1;
			real rcvalue9e                     	 ; // := rcvalue9e;
			real rcvalue9f_1                   	 ; // := rcvalue9f_1;
			real rcvalue9f                     	 ; // := rcvalue9f;
			real rcvalue9g_1                   	 ; // := rcvalue9g_1;
			real rcvalue9g                     	 ; // := rcvalue9g;
			real rcvalue9h_1                   	 ; // := rcvalue9h_1;
			real rcvalue9h                     	 ; // := rcvalue9h;
			real rcvalue9i_1                   	 ; // := rcvalue9i_1;
			real rcvalue9i                     	 ; // := rcvalue9i;
			real rcvalue9r_1                   	 ; // := rcvalue9r_1;
			real rcvalue9r                     	 ; // := rcvalue9r;
			// real rcvalue9y_1                   	 ; // := rcvalue9y_1;
			// real rcvalue9y                     	 ; // := rcvalue9y;
			real rcvaluepv_1                   	 ; // := rcvaluepv_1;
			real rcvaluepv                     	 ; // := rcvaluepv;
			real rcvaluebl_1                   	 ; // := rcvaluebl_1;
			real rcvaluebl                     	 ; // := rcvaluebl;
			models.layout_modelout;
			risk_indicators.Layout_Boca_Shell clam;
    END;
    layout_debug doModel( clam le ) := TRANSFORM
  #else
    models.layout_modelout doModel( clam le ) := TRANSFORM
  #end
	truedid                          := le.truedid;
	in_dob                           := le.shell_input.dob;
	nas_summary                      := le.iid.nas_summary;
	nap_summary                      := le.iid.nap_summary;
	rc_decsflag                      := le.iid.decsflag;
	rc_bansflag                      := le.iid.bansflag;
	rc_addrcount                     := le.iid.addrcount;
	combo_dobscore                   := le.iid.combo_dobscore;
	ver_sources                      := le.header_summary.ver_sources;
	ver_sources_first_seen           := le.header_summary.ver_sources_first_seen_date;
	ver_sources_last_seen            := le.header_summary.ver_sources_last_seen_date;
	addrpop                          := le.input_validation.address;
	dobpop                           := le.input_validation.dateofbirth;
	add1_isbestmatch                 := le.address_verification.input_address_information.isbestmatch;
	add1_avm_automated_valuation     := le.avm.input_address_information.avm_automated_valuation;
	add1_naprop                      := le.address_verification.input_address_information.naprop;
	add1_pop                         := le.addrpop;
	property_owned_total             := le.address_verification.owned.property_total;
	property_sold_total              := le.address_verification.sold.property_total;
	add2_avm_automated_valuation     := le.avm.address_history_1.avm_automated_valuation;
	addrs_5yr                        := le.other_address_info.addrs_last_5years;
	unique_addr_count                := le.address_history_summary.unique_addr_cnt;
	gong_did_first_seen              := le.phone_verification.gong_did.gong_adl_dt_first_seen_full;
	header_first_seen                := le.ssn_verification.header_first_seen;
	pb_total_orders                  := le.ibehavior.total_number_of_orders;
	paw_dead_business_count          := le.employment.dead_business_ct;
	paw_active_phone_count           := le.employment.business_active_phone_ct;
	infutor_nap                      := le.infutor_phone.infutor_nap;
	impulse_count                    := le.impulse.count;
	email_source_list                := le.email_summary.email_source_list;
	attr_num_nonderogs               := le.source_verification.num_nonderogs;
	bankrupt                         := le.bjl.bankrupt;
	filing_count                     := le.bjl.filing_count;
	bk_recent_count                  := le.bjl.bk_recent_count;
	liens_recent_unreleased_count    := le.bjl.liens_recent_unreleased_count;
	liens_historical_unreleased_ct   := le.bjl.liens_historical_unreleased_count;
	liens_rel_cj_ct                  := le.liens.liens_released_civil_judgment.count;
	criminal_count                   := le.bjl.criminal_count;
	ams_college_code                 := le.student.college_code;
	inferred_age                     := le.inferred_age;
	paw_first_seen                   := le.employment.first_seen_date;
	infutor_first_seen               := le.infutor_phone.infutor_date_first_seen;
	infutor_last_seen                := le.infutor_phone.infutor_date_last_seen;
	NULL := -999999999;

	BOOLEAN indexw(string source, string target, string delim) :=
		(source = target) OR
		(StringLib.StringFind(source, delim + target + delim, 1) > 0) OR
		(source[1..length(target)+1] = target + delim) OR
		(StringLib.StringReverse(source)[1..length(target)+1] = StringLib.StringReverse(target) + delim);

	sysdate := common.sas_date(if(le.historydate=999999, (STRING)Std.Date.Today(), (string6)le.historydate+'01'));

	email_src_im := Models.Common.findw_cpp(email_source_list, 'IM' , ' ,', 'E') > 0;

	iv_ds001_impulse_count := map(
			not(truedid)  => NULL,
			impulse_count = 0 and email_src_im => 1,
			impulse_count);

	_in_dob := common.sas_date((string)(in_dob));

	yr_in_dob := map(in_dob = '' => -1, 
								   in_dob = '0'	 => 0, 
									 _in_dob = -999999999 => 0,
									 (sysdate - _in_dob) / 365.25);

	yr_in_dob_int := if (yr_in_dob >= 0, roundup(yr_in_dob), truncate(yr_in_dob));

	age_estimate := map(
			yr_in_dob_int > 0 => yr_in_dob_int,
			inferred_age > 0  => inferred_age,
													 -1);

	iv_ag001_age := if(not(truedid or dobpop), NULL, min(62, if(age_estimate = NULL, -NULL, age_estimate)));

	iv_pv001_bst_avm_autoval := map(
			not(truedid)     => NULL,
			add1_isbestmatch => add1_avm_automated_valuation,
													add2_avm_automated_valuation);

	iv_addr_non_phn_src_ct := if(not(truedid) and add1_pop, NULL, rc_addrcount);

	iv_addrs_5yr := map(
			not(truedid)          => NULL,
			unique_addr_count = 0 => -1,
															 addrs_5yr);

	_gong_did_first_seen := common.sas_date((string)(gong_did_first_seen));

	iv_mos_since_gong_did_fst_seen := map(
			not(truedid)                     => NULL,
			not(_gong_did_first_seen = NULL) => if ((sysdate - _gong_did_first_seen) / (365.25 / 12) >= 0, truncate((sysdate - _gong_did_first_seen) / (365.25 / 12)), roundup((sysdate - _gong_did_first_seen) / (365.25 / 12))),
																					-1);

	iv_non_derog_count := if(not(truedid), NULL, attr_num_nonderogs);

	iv_liens_rel_cj_ct := if(not(truedid), NULL, liens_rel_CJ_ct);

	iv_criminal_count := if(not(truedid), NULL, criminal_count);

	iv_ams_college_code := map(
			not(truedid)            => '  ',
			ams_college_code = '' => '-1',
			trim((string) ams_college_code, LEFT));

	iv_pb_total_orders := map(
			not(truedid)           => NULL,
			pb_total_orders = '' => -1,
			(integer) pb_total_orders);

	bureau_adl_vo_fseen_pos := Models.Common.findw_cpp(ver_sources, 'VO' , ', ', 'E');

	bureau_adl_fseen_vo := if(bureau_adl_vo_fseen_pos = 0, '       0', Models.Common.getw(ver_sources_first_seen, bureau_adl_vo_fseen_pos, ','));

	_bureau_adl_fseen_vo := common.sas_date((string)(bureau_adl_fseen_vo));

	_src_bureau_adl_fseen := _bureau_adl_fseen_vo;

	mth_ver_src_fdate_vo := map(
			not(truedid)                 => NULL,
			_src_bureau_adl_fseen = NULL => -1,
			if ((sysdate - _src_bureau_adl_fseen) / (365.25 / 12) >= 0, 
						truncate((sysdate - _src_bureau_adl_fseen) / (365.25 / 12)), 
						roundup((sysdate - _src_bureau_adl_fseen) / (365.25 / 12))));

	bureau_adl_vo_lseen_pos := Models.Common.findw_cpp(ver_sources, 'VO' ,  ' ,', 'E');

	bureau_adl_lseen_vo := if(bureau_adl_vo_lseen_pos = 0, '       0', Models.Common.getw(ver_sources_last_seen, bureau_adl_vo_lseen_pos, ','));

	_bureau_adl_lseen_vo := common.sas_date((string)(bureau_adl_lseen_vo));

	_src_bureau_adl_lseen_2 := _bureau_adl_lseen_vo;

	mth_ver_src_ldate_vo := map(
			not(truedid)                   => NULL,
			_src_bureau_adl_lseen_2 = NULL => -1,
			if ((sysdate - _src_bureau_adl_lseen_2) / (365.25 / 12) >= 0, truncate((sysdate - _src_bureau_adl_lseen_2) / (365.25 / 12)), roundup((sysdate - _src_bureau_adl_lseen_2) / (365.25 / 12))));

	mth_ver_src_fdate_vo60 := mth_ver_src_fdate_vo > 60;

	mth_ver_src_ldate_vo0 := mth_ver_src_ldate_vo = 0;

	bureau_adl_w_lseen_pos := Models.Common.findw_cpp(ver_sources, 'W' , ' ,', 'E');

	bureau_adl_lseen_w := if(bureau_adl_w_lseen_pos = 0, '       0', Models.Common.getw(ver_sources_last_seen, bureau_adl_w_lseen_pos, ','));

	_bureau_adl_lseen_w := common.sas_date((string)(bureau_adl_lseen_w));

	_src_bureau_adl_lseen_1 := _bureau_adl_lseen_w;

	mth_ver_src_ldate_w := map(
			not(truedid)                   => NULL,
			_src_bureau_adl_lseen_1 = NULL => -1,
			//_src_bureau_adl_lseen_1 = 0 => 0,
			if ((sysdate - _src_bureau_adl_lseen_1) / (365.25 / 12) >= 0, truncate((sysdate - _src_bureau_adl_lseen_1) / (365.25 / 12)), roundup((sysdate - _src_bureau_adl_lseen_1) / (365.25 / 12))));

	mth_ver_src_ldate_w0 := mth_ver_src_ldate_w = 0;

	bureau_adl_wp_lseen_pos := Models.Common.findw_cpp(ver_sources, 'WP' , ' ,', 'E');

	bureau_adl_lseen_wp := if(bureau_adl_wp_lseen_pos = 0, '       0', Models.Common.getw(ver_sources_last_seen, bureau_adl_wp_lseen_pos, ','));

	_bureau_adl_lseen_wp := common.sas_date((string)(bureau_adl_lseen_wp));

	_src_bureau_adl_lseen := _bureau_adl_lseen_wp;

	mth_ver_src_ldate_wp := map(
			not(truedid)                 => NULL,
			_src_bureau_adl_lseen = NULL => -1,
		 if ((sysdate - _src_bureau_adl_lseen) / (365.25 / 12) >= 0, 
				truncate((sysdate - _src_bureau_adl_lseen) / (365.25 / 12)), 
				roundup((sysdate - _src_bureau_adl_lseen) / (365.25 / 12))));

	mth_ver_src_ldate_wp0 := mth_ver_src_ldate_wp = 0;

	_paw_first_seen := common.sas_date((string)(paw_first_seen));//ARRAY(0x2a16018)

	mth_paw_first_seen := map(
			not(truedid)           => NULL,
			_paw_first_seen = NULL => -1,
																if ((sysdate - _paw_first_seen) / (365.25 / 12) >= 0, truncate((sysdate - _paw_first_seen) / (365.25 / 12)), roundup((sysdate - _paw_first_seen) / (365.25 / 12))));

	mth_paw_first_seen2 := if(mth_paw_first_seen = NULL or mth_paw_first_seen < 6, 6, min(360, if(mth_paw_first_seen = NULL, -NULL, mth_paw_first_seen)));

	ver_src_am := Models.Common.findw_cpp(ver_sources, 'AM' , ' ,', 'E') > 0;

	ver_src_e1 := Models.Common.findw_cpp(ver_sources, 'E1' , ' ,', 'E') > 0;

	ver_src_e2 := Models.Common.findw_cpp(ver_sources, 'E2' , ' ,', 'E') > 0;

	ver_src_e3 := Models.Common.findw_cpp(ver_sources, 'E3' , ' ,', 'E') > 0;

	ver_src_pl := Models.Common.findw_cpp(ver_sources, 'PL' , ', ', 'E') > 0;

	ver_src_w := Models.Common.findw_cpp(ver_sources, 'W' , ' ,', 'E') > 0;

	paw_dead_business_count_gt3 := paw_dead_business_count > 3;

	paw_active_phone_count_0 := paw_active_phone_count <= 0;

	_infutor_first_seen := common.sas_date((string)(infutor_first_seen));//ARRAY(0x2a1a298)

	mth_infutor_first_seen := map(
			not(truedid)               => NULL,
			_infutor_first_seen = NULL => NULL,
																		if ((sysdate - _infutor_first_seen) / (365.25 / 12) >= 0, truncate((sysdate - _infutor_first_seen) / (365.25 / 12)), roundup((sysdate - _infutor_first_seen) / (365.25 / 12))));

	_infutor_last_seen := common.sas_date((string)(infutor_last_seen));//ARRAY(0x2a1bb80)

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

	white_pages_adl_wp_fseen_pos := Models.Common.findw_cpp(ver_sources, 'WP' , ' ,', 'E');

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

	source_temp := round(500 * source_mod6/0.1) * 0.1;
	iv_sr001_source_profile := if(not(truedid), NULL, max((real)0, round((100 - source_temp) * 10) / 10));
	
	s_subscore0 := map(
			NULL < iv_non_derog_count AND iv_non_derog_count < 3 => -0.444062,
			3 <= iv_non_derog_count AND iv_non_derog_count < 4   => 0.028770,
			4 <= iv_non_derog_count AND iv_non_derog_count < 5   => 0.181939,
			5 <= iv_non_derog_count AND iv_non_derog_count < 6   => 0.289776,
			6 <= iv_non_derog_count                              => 0.529675,
																															0.000000);

	s_subscore1 := map(
			NULL < iv_pv001_bst_avm_autoval AND iv_pv001_bst_avm_autoval < 1        => -0.202254,
			1 <= iv_pv001_bst_avm_autoval AND iv_pv001_bst_avm_autoval < 26700      => -0.078334,
			26700 <= iv_pv001_bst_avm_autoval AND iv_pv001_bst_avm_autoval < 51335  => 0.018647,
			51335 <= iv_pv001_bst_avm_autoval AND iv_pv001_bst_avm_autoval < 64580  => 0.104197,
			64580 <= iv_pv001_bst_avm_autoval AND iv_pv001_bst_avm_autoval < 95489  => 0.246179,
			95489 <= iv_pv001_bst_avm_autoval AND iv_pv001_bst_avm_autoval < 145062 => 0.357488,
			145062 <= iv_pv001_bst_avm_autoval                                      => 0.567358,
																																								 0.000000);

	s_subscore2 := map(
			NULL < iv_sr001_source_profile AND iv_sr001_source_profile < 0.1   => 0.000000,
			0.1 <= iv_sr001_source_profile AND iv_sr001_source_profile < 58.4  => -0.209643,
			58.4 <= iv_sr001_source_profile AND iv_sr001_source_profile < 67.2 => -0.203153,
			67.2 <= iv_sr001_source_profile AND iv_sr001_source_profile < 77.9 => 0.001834,
			77.9 <= iv_sr001_source_profile AND iv_sr001_source_profile < 81.2 => 0.106554,
			81.2 <= iv_sr001_source_profile AND iv_sr001_source_profile < 89.2 => 0.318870,
			89.2 <= iv_sr001_source_profile                                    => 0.848786,
																																						0.000000);

	s_subscore3 := map(
			(iv_ams_college_code in ['Other'])       => 0.000000,
			(iv_ams_college_code in ['-1'])          => -0.078066,
			(iv_ams_college_code in ['1', '2', '4']) => 0.595129,
																									0.000000);

	s_subscore4 := map(
			NULL < iv_addrs_5yr AND iv_addrs_5yr < 0 => -0.000000,
			0 <= iv_addrs_5yr AND iv_addrs_5yr < 1   => 0.249424,
			1 <= iv_addrs_5yr AND iv_addrs_5yr < 2   => 0.169532,
			2 <= iv_addrs_5yr AND iv_addrs_5yr < 3   => 0.037785,
			3 <= iv_addrs_5yr AND iv_addrs_5yr < 4   => 0.002569,
			4 <= iv_addrs_5yr AND iv_addrs_5yr < 6   => -0.194841,
			6 <= iv_addrs_5yr AND iv_addrs_5yr < 7   => -0.218285,
			7 <= iv_addrs_5yr                        => -0.656755,
																									-0.000000);

	s_subscore5 := map(
			NULL < iv_criminal_count AND iv_criminal_count < 1 => 0.045756,
			1 <= iv_criminal_count                             => -0.852940,
																														0.000000);

	s_subscore6 := map(
			NULL < iv_pb_total_orders AND iv_pb_total_orders < 1 => -0.150849,
			1 <= iv_pb_total_orders AND iv_pb_total_orders < 2   => -0.000027,
			2 <= iv_pb_total_orders                              => 0.234727,
																															0.000000);

	s_subscore7 := map(
			NULL < iv_liens_rel_cj_ct AND iv_liens_rel_cj_ct < 1 => -0.048928,
			1 <= iv_liens_rel_cj_ct                              => 0.513169,
																															0.000000);

	s_subscore8 := map(
			NULL < iv_mos_since_gong_did_fst_seen AND iv_mos_since_gong_did_fst_seen < 0  => 0.111823,
			0 <= iv_mos_since_gong_did_fst_seen AND iv_mos_since_gong_did_fst_seen < 42   => -0.392843,
			42 <= iv_mos_since_gong_did_fst_seen AND iv_mos_since_gong_did_fst_seen < 54  => -0.314867,
			54 <= iv_mos_since_gong_did_fst_seen AND iv_mos_since_gong_did_fst_seen < 68  => -0.121455,
			68 <= iv_mos_since_gong_did_fst_seen AND iv_mos_since_gong_did_fst_seen < 123 => 0.036806,
			123 <= iv_mos_since_gong_did_fst_seen                                         => 0.152566,
																																											 0.000000);

	s_subscore9 := map(
			NULL < iv_ag001_age AND iv_ag001_age < 18 => -0.000000,
			18 <= iv_ag001_age AND iv_ag001_age < 30  => -0.112413,
			30 <= iv_ag001_age AND iv_ag001_age < 34  => -0.083422,
			34 <= iv_ag001_age AND iv_ag001_age < 58  => -0.028884,
			58 <= iv_ag001_age                        => 0.334625,
																									 -0.000000);

	s_subscore10 := map(
			NULL < iv_addr_non_phn_src_ct AND iv_addr_non_phn_src_ct < 2 => -0.110289,
			2 <= iv_addr_non_phn_src_ct AND iv_addr_non_phn_src_ct < 3   => 0.150749,
			3 <= iv_addr_non_phn_src_ct                                  => 0.205892,
																																			0.000000);

	s_subscore11 := map(
			NULL < iv_ds001_impulse_count AND iv_ds001_impulse_count < 1 => 0.026024,
			1 <= iv_ds001_impulse_count                                  => -0.504884,
																																			-0.000000);

	s_rawscore := s_subscore0 +
			s_subscore1 +
			s_subscore2 +
			s_subscore3 +
			s_subscore4 +
			s_subscore5 +
			s_subscore6 +
			s_subscore7 +
			s_subscore8 +
			s_subscore9 +
			s_subscore10 +
			s_subscore11;

	s_lnoddsscore := s_rawscore + -0.831586;

	s_probscore := exp(s_lnoddsscore) / (1 + exp(s_lnoddsscore));

	base := 700;

	odds := 0.315 / (1 - 0.315);

	point := 40;

	ssn_deceased := rc_decsflag = '1' or indexw(StringLib.StringToUpperCase(trim(ver_sources, ALL)), 'DS', ',');

	iv_riskview_222s := riskview.constants.noscore(le.iid.nas_summary,le.iid.nap_summary, le.address_verification.input_address_information.naprop, le.truedid);

	rvc1307_1 := map(
			ssn_deceased     => 200,
			iv_riskview_222s => 222,
													min(if(max(round(point * (ln(s_probscore / (1 - s_probscore)) - ln(odds)) / ln(2) + base), 501) = NULL,
													-NULL, max(round(point * (ln(s_probscore / (1 - s_probscore)) - ln(odds)) / ln(2) + base), 501)), 900));

	glrc36 := truedid and attr_num_nonderogs < 3;

	glrc97 := truedid and criminal_count > 0;

	glrc9d := truedid and addrs_5yr > 2;

	glrc9e := truedid and addrpop and rc_addrcount < 2;

	glrc9f := truedid and 0 <= iv_mos_since_gong_did_fst_seen AND iv_mos_since_gong_did_fst_seen < 84;

	glrc9g := truedid and 18 <= iv_ag001_age AND iv_ag001_age < 34;

	glrc9h := truedid and impulse_count > 0;

	glrc9i := truedid and not((ams_college_code in ['1', '2', '4'])) and 18 <= iv_ag001_age AND iv_ag001_age < 30;

	glrc9r := truedid  and 0 < iv_sr001_source_profile AND iv_sr001_source_profile < 70;

	// glrc9y := truedid and pb_total_orders = '';

	glrcpv := truedid and addrpop and 0 < add1_avm_automated_valuation AND add1_avm_automated_valuation < 100000;

	glrcbl := 0;

	rcvalue36_1 := 0.529675 - s_subscore0;

	rcvalue36 := (integer)glrc36 * if(max(rcvalue36_1) = NULL, NULL, sum(if(rcvalue36_1 = NULL, 0, rcvalue36_1)));

	rcvalue97_1 := 0.045756 - s_subscore5;

	rcvalue97 := (integer)glrc97 * if(max(rcvalue97_1) = NULL, NULL, sum(if(rcvalue97_1 = NULL, 0, rcvalue97_1)));

	rcvalue9d_1 := 0.249424 - s_subscore4;

	rcvalue9d := (integer)glrc9d * if(max(rcvalue9d_1) = NULL, NULL, sum(if(rcvalue9d_1 = NULL, 0, rcvalue9d_1)));

	rcvalue9e_1 := 0.205892 - s_subscore10;

	rcvalue9e := (integer)glrc9e * if(max(rcvalue9e_1) = NULL, NULL, sum(if(rcvalue9e_1 = NULL, 0, rcvalue9e_1)));

	rcvalue9f_1 := 0.152566 - s_subscore8;

	rcvalue9f := (integer)glrc9f * if(max(rcvalue9f_1) = NULL, NULL, sum(if(rcvalue9f_1 = NULL, 0, rcvalue9f_1)));

	rcvalue9g_1 := 0.334625 - s_subscore9;

	rcvalue9g := (integer)glrc9g * if(max(rcvalue9g_1) = NULL, NULL, sum(if(rcvalue9g_1 = NULL, 0, rcvalue9g_1)));

	rcvalue9h_1 := 0.026024 - s_subscore11;

	rcvalue9h := (integer)glrc9h * if(max(rcvalue9h_1) = NULL, NULL, sum(if(rcvalue9h_1 = NULL, 0, rcvalue9h_1)));

	rcvalue9i_1 := 0.595129 - s_subscore3;

	rcvalue9i := (integer)glrc9i * if(max(rcvalue9i_1) = NULL, NULL, sum(if(rcvalue9i_1 = NULL, 0, rcvalue9i_1)));

	rcvalue9r_1 := 0.848786 - s_subscore2;

	rcvalue9r := (integer)glrc9r * if(max(rcvalue9r_1) = NULL, NULL, sum(if(rcvalue9r_1 = NULL, 0, rcvalue9r_1)));

	// rcvalue9y_1 := 0.234727 - s_subscore6;

	// rcvalue9y := (integer)glrc9y * if(max(rcvalue9y_1) = NULL, NULL, sum(if(rcvalue9y_1 = NULL, 0, rcvalue9y_1)));

	rcvaluepv_1 := 0.567358 - s_subscore1;

	rcvaluepv := (integer)glrcpv * if(max(rcvaluepv_1) = NULL, NULL, sum(if(rcvaluepv_1 = NULL, 0, rcvaluepv_1)));

	rcvaluebl_1 := 0.513169 - s_subscore7;

	rcvaluebl := glrcbl * if(max(rcvaluebl_1) = NULL, NULL, sum(if(rcvaluebl_1 = NULL, 0, rcvaluebl_1)));

	
//*************************************************************************************//
// I have no idea how the reason code logic gets implemented in ECL, so everything below 
// probably needs to get changed or replaced.  The methodology for creating the reason codes is
// very similar to the logic used by the RiskView 4.0 scores, so you might want to consult
// that model code for guidance on implementing reason codes. 
//*************************************************************************************/

ds_layout := {STRING rc, REAL value};
rc_dataset := DATASET([
	  {'36', RCValue36},
    {'97', RCValue97},
    {'9D', RCValue9D},
    {'9E', RCValue9E},
    {'9F', RCValue9F},
    {'9G', RCValue9G},
    {'9H', RCValue9H},
    {'9I', RCValue9I},
    {'9R', RCValue9R},
    // {'9Y', RCValue9Y},
    {'PV', RCValuePV},
    {'BL', RCValueBL}
    ], ds_layout)(value > 0);

		rcs_top4 := CHOOSEN(SORT(rc_dataset, -value), 4); // Take the top four reason codes
		
	rcs_9p1 := if(rcs_top4[1].rc = '', ROW({'36', NULL}, ds_layout), rcs_top4[1]);
	rcs_9p2 := MAP(rcs_9p1.rc not in ['36'] AND rcs_top4[2].rc = '' and 500 < rvc1307_1 AND rvc1307_1 <= 720 => ROW({'36', NULL}, ds_layout),
								 rcs_9p1.rc in ['36'] AND rcs_top4[2].rc = '' and 500 < rvc1307_1 AND rvc1307_1 <= 720 => ROW({'9E ', NULL}, ds_layout),
								 rcs_top4[2]);
	rcs_9p3 := rcs_top4[3];
	rcs_9p4 := rcs_top4[4];
	
	rcs_9p := rcs_9p1 & rcs_9p2 & rcs_9p3 & rcs_9p4;

	rcs_override := MAP(
											rvc1307_1 = 200 => DATASET([{'02', NULL}], ds_layout),
											rvc1307_1 = 222 => DATASET([{'9X', NULL}], ds_layout),
											rvc1307_1 = 900 => DATASET([{'  ', NULL}], ds_layout),
											NOT EXISTS(rcs_9p(rc != '')) => DATASET([{'36', NULL}], ds_layout),
											rcs_9p);
	
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
						inCalif => DATASET([{'35', Risk_Indicators.getHRIDesc('35')}, {'00',''}, {'00',''}, {'00',''}], Risk_Indicators.Layout_Desc),
						rcs_final
						);
					
	zeros := DATASET([{'00',''}, {'00',''}, {'00',''}, {'00',''}], Risk_Indicators.Layout_Desc);
	
	reasons := CHOOSEN(ri & zeros, 4); // Keep up to 4 reason codes

	//Intermediate variables

	#if(RVC_DEBUG)
		 self.clam															:= le;
		 self.sysdate                          := sysdate;
		 self.email_src_im                     := email_src_im;
		 self.iv_ds001_impulse_count           := iv_ds001_impulse_count;
		 self._in_dob                          := _in_dob;
		 self.yr_in_dob                        := yr_in_dob;
		 self.yr_in_dob_int                    := yr_in_dob_int;
		 self.age_estimate                     := age_estimate;
		 self.iv_ag001_age                     := iv_ag001_age;
		 self.iv_pv001_bst_avm_autoval         := iv_pv001_bst_avm_autoval;
		 self.iv_addr_non_phn_src_ct           := iv_addr_non_phn_src_ct;
		 self.iv_addrs_5yr                     := iv_addrs_5yr;
		 self._gong_did_first_seen             := _gong_did_first_seen;
		 self.iv_mos_since_gong_did_fst_seen   := iv_mos_since_gong_did_fst_seen;
		 self.iv_non_derog_count               := iv_non_derog_count;
		 self.iv_liens_rel_cj_ct               := iv_liens_rel_cj_ct;
		 self.iv_criminal_count                := iv_criminal_count;
		 self.iv_ams_college_code              := iv_ams_college_code;
		 self.iv_pb_total_orders               := iv_pb_total_orders;
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
		 self.s_subscore0                      := s_subscore0;
		 self.s_subscore1                      := s_subscore1;
		 self.s_subscore2                      := s_subscore2;
		 self.s_subscore3                      := s_subscore3;
		 self.s_subscore4                      := s_subscore4;
		 self.s_subscore5                      := s_subscore5;
		 self.s_subscore6                      := s_subscore6;
		 self.s_subscore7                      := s_subscore7;
		 self.s_subscore8                      := s_subscore8;
		 self.s_subscore9                      := s_subscore9;
		 self.s_subscore10                     := s_subscore10;
		 self.s_subscore11                     := s_subscore11;
		 self.s_rawscore                       := s_rawscore;
		 self.s_lnoddsscore                    := s_lnoddsscore;
		 self.s_probscore                      := s_probscore;
		 self.base                             := base;
		 self.odds                             := odds;
		 self.point                            := point;
		 self.ssn_deceased                     := ssn_deceased;
		 self.iv_riskview_222s                 := iv_riskview_222s;
		 self.rvc1307_1                        := rvc1307_1;
		 self.glrc36                           := glrc36;
		 self.glrc97                           := glrc97;
		 self.glrc9d                           := glrc9d;
		 self.glrc9e                           := glrc9e;
		 self.glrc9f                           := glrc9f;
		 self.glrc9g                           := glrc9g;
		 self.glrc9h                           := glrc9h;
		 self.glrc9i                           := glrc9i;
		 self.glrc9r                           := glrc9r;
		 // self.glrc9y                           := glrc9y;
		 self.glrcpv                           := glrcpv;
		 self.glrcbl                           := glrcbl;
		 self.rcvalue36_1                      := rcvalue36_1;
		 self.rcvalue36                        := rcvalue36;
		 self.rcvalue97_1                      := rcvalue97_1;
		 self.rcvalue97                        := rcvalue97;
		 self.rcvalue9d_1                      := rcvalue9d_1;
		 self.rcvalue9d                        := rcvalue9d;
		 self.rcvalue9e_1                      := rcvalue9e_1;
		 self.rcvalue9e                        := rcvalue9e;
		 self.rcvalue9f_1                      := rcvalue9f_1;
		 self.rcvalue9f                        := rcvalue9f;
		 self.rcvalue9g_1                      := rcvalue9g_1;
		 self.rcvalue9g                        := rcvalue9g;
		 self.rcvalue9h_1                      := rcvalue9h_1;
		 self.rcvalue9h                        := rcvalue9h;
		 self.rcvalue9i_1                      := rcvalue9i_1;
		 self.rcvalue9i                        := rcvalue9i;
		 self.rcvalue9r_1                      := rcvalue9r_1;
		 self.rcvalue9r                        := rcvalue9r;
		 // self.rcvalue9y_1                      := rcvalue9y_1;
		 // self.rcvalue9y                        := rcvalue9y;
		 self.rcvaluepv_1                      := rcvaluepv_1;
		 self.rcvaluepv                        := rcvaluepv;
		 self.rcvaluebl_1                      := rcvaluebl_1;
		 self.rcvaluebl                        := rcvaluebl;
		 self.rc1                              := rcs_override[1].rc;
		 self.rc2                              := rcs_override[2].rc;
		 self.rc3                              := rcs_override[3].rc;
		 self.rc4                              := rcs_override[4].rc;
		 self.rc5                              := rcs_override[5].rc;
		#end
		SELF.ri := PROJECT(reasons, TRANSFORM(Risk_Indicators.Layout_Desc,
																							SELF.hri := if(LEFT.hri='', '00', left.hri),
																							SELF.desc := Risk_Indicators.getHRIDesc(LEFT.hri)
																					));
		self.seq := le.seq;
		self.score := if(reasons[1].hri IN ['91','92','93','94'],(STRING3)((INTEGER)reasons[1].hri + 10),(string3)rvc1307_1);
END;

		model := project( clam, doModel(left) );

		return model;

END;
import risk_indicators, riskwise, riskwisefcra, ut, std, riskview;

export RVC1405_1_0( grouped dataset(risk_indicators.Layout_Bocashell_with_Custom) clam, BOOLEAN isCalifornia = FALSE) := FUNCTION

  RVC_DEBUG := False;

	#if(RVC_DEBUG)
		layout_debug := record
			INTEGER sysdate                     ;
			String adl_addr;
			Integer slc_num_loans                ;
			String num_appl_nos;
			STRING iv_vp002_phn_disconnected    ;
			INTEGER bureau_adl_tn_fseen_pos     ;
			STRING bureau_adl_fseen_tn          ;
			INTEGER _bureau_adl_fseen_tn        ;
			INTEGER bureau_adl_ts_fseen_pos     ;
			STRING bureau_adl_fseen_ts          ;
			INTEGER _bureau_adl_fseen_ts        ;
			INTEGER bureau_adl_tu_fseen_pos     ;
			STRING bureau_adl_fseen_tu          ;
			INTEGER _bureau_adl_fseen_tu        ;
			INTEGER bureau_adl_en_fseen_pos     ;
			STRING bureau_adl_fseen_en          ;
			INTEGER _bureau_adl_fseen_en        ;
			INTEGER bureau_adl_eq_fseen_pos     ;
			STRING bureau_adl_fseen_eq          ;
			INTEGER _bureau_adl_fseen_eq        ;
			INTEGER _src_bureau_adl_fseen        ;
			INTEGER iv_sr001_m_bureau_adl_fs     ;
			INTEGER iv_ms001_ssns_per_adl        ;
			INTEGER iv_pl002_addrs_per_adl_c6    ;
			INTEGER iv_pl002_addrs_15yr          ;
			STRING iv_in001_wealth_index        ;
			INTEGER iv_attr_rel_liens_recency    ;
			INTEGER iv_liens_unrel_sc_ct         ;
			STRING iv_ams_college_code          ;
			STRING iv_db001_bankruptcy          ;
			INTEGER iv_pv001_inp_avm_autoval     ;
			INTEGER _reported_dob                ;
			Integer reported_age                 ;
			INTEGER iv_combined_age              ;
			STRING iv_inp_own_prop_x_addr_naprop;
			INTEGER iv_addrs_10yr                ;
			INTEGER iv_adls_per_addr_c6          ;
			INTEGER iv_paw_source_count          ;
			INTEGER iv_unreleased_liens_ct       ;
			INTEGER iv_pb_total_orders           ;
			REAL n_subscore0                    ;
			REAL n_subscore1                    ;
			REAL n_subscore2                    ;
			REAL n_subscore3                    ;
			REAL n_subscore4                    ;
			REAL n_subscore5                    ;
			REAL n_subscore6                    ;
			REAL n_subscore7                    ;
			REAL n_subscore8                    ;
			REAL n_subscore9                    ;
			REAL n_subscore10                   ;
			REAL e_subscore0                    ;
			REAL e_subscore1                    ;
			REAL e_subscore2                    ;
			REAL e_subscore3                    ;
			REAL e_subscore4                    ;
			REAL e_subscore5                    ;
			REAL e_subscore6                    ;
			REAL e_subscore7                    ;
			REAL e_subscore8                    ;
			REAL e_subscore9                    ;
			REAL e_subscore10                   ;
			REAL e_subscore11                   ;
			REAL e_subscore12                   ;
			REAL e_subscore13                   ;
			REAL n_rawscore                     ;
			REAL n_lnoddsscore                  ;
			REAL n_probscore                    ;
			REAL e_rawscore                     ;
			REAL e_lnoddsscore                  ;
			REAL e_probscore                    ;
			INTEGER base                        ;
			INTEGER pts                         ;
			REAL odds                           ;
			BOOLEAN ssn_deceased                ;
			BOOLEAN iv_riskview_222s            ;
			INTEGER n_ps_custom                  ;
			INTEGER e_ps_custom                  ;
			INTEGER rvc1405_1_0                 ;
			BOOLEAN n_glrc07                    ;
			BOOLEAN n_glrc25                    ;
			BOOLEAN n_glrc98                    ;
			BOOLEAN n_glrc9d                    ;
			BOOLEAN n_glrc9i                    ;
			BOOLEAN n_glrc9m                    ;
			BOOLEAN n_glrc9r                    ;
			BOOLEAN n_glrcms                    ;
			BOOLEAN n_glrcbl                    ;
			BOOLEAN e_glrc25                    ;
			BOOLEAN e_glrc98                    ;
			BOOLEAN e_glrc9a                    ;
			BOOLEAN e_glrc9d                    ;
			BOOLEAN e_glrc9i                    ;
			BOOLEAN e_glrc9m                    ;
			BOOLEAN e_glrc9r                    ;
			BOOLEAN e_glrc9w                    ;
			// BOOLEAN e_glrc9y                    ;
			BOOLEAN e_glrcms                    ;
			BOOLEAN e_glrcpv                    ;
			BOOLEAN e_glrcbl                    ;
			REAL rcvalue07_1                    ;
			REAL rcvalue07                      ;
			REAL rcvalue25_1                    ;
			REAL rcvalue25_2                    ;
			REAL rcvalue25                      ;
			REAL rcvalue98_1                    ;
			REAL rcvalue98_2                    ;
			REAL rcvalue98_3                    ;
			REAL rcvalue98                      ;
			REAL rcvalue9a_1                    ;
			REAL rcvalue9a                      ;
			REAL rcvalue9d_1                    ;
			REAL rcvalue9d_2                    ;
			REAL rcvalue9d_3                    ;
			REAL rcvalue9d_4                    ;
			REAL rcvalue9d                      ;
			REAL rcvalue9i_1                    ;
			REAL rcvalue9i_2                    ;
			REAL rcvalue9i                      ;
			REAL rcvalue9m_1                    ;
			REAL rcvalue9m_2                    ;
			REAL rcvalue9m                      ;
			REAL rcvalue9r_1                    ;
			REAL rcvalue9r_2                    ;
			REAL rcvalue9r                      ;
			REAL rcvalue9w_1                    ;
			REAL rcvalue9w                      ;
			REAL rcvalue9y_1                    ;
			REAL rcvalue9y                      ;
			REAL rcvaluems_1                    ;
			REAL rcvaluems_2                    ;
			REAL rcvaluems                      ;
			REAL rcvaluepv_1                    ;
			REAL rcvaluepv                      ;
			STRING rc1                          ;
			STRING rc2                          ;
			STRING rc3                          ;
			STRING rc4                          ;
			STRING rc5                          ;
			models.layout_modelout;
			risk_indicators.Layout_Boca_Shell clam;
    END;
    layout_debug doModel( clam le ) := TRANSFORM
  #else
    models.layout_modelout doModel( clam le ) := TRANSFORM
  #end
	num_appl_nos                     := le.custom_input1;
	adl_addr                         := le.adl_shell_flags.adl_addr;
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
	ssnlength                        := le.input_validation.ssn_length;
	dobpop                           := le.input_validation.dateofbirth;
	hphnpop                          := le.input_validation.homephone;
	age                              := le.name_verification.age;
	add1_avm_automated_valuation     := le.avm.input_address_information.avm_automated_valuation;
	add1_naprop                      := le.address_verification.input_address_information.naprop;
	add1_pop                         := le.addrpop;
	property_owned_total             := le.address_verification.owned.property_total;
	property_sold_total              := le.address_verification.sold.property_total;
	addrs_10yr                       := le.other_address_info.addrs_last_10years;
	addrs_15yr                       := le.other_address_info.addrs_last_15years;
	unique_addr_count                := le.address_history_summary.unique_addr_cnt;
	ssns_per_adl                     := le.velocity_counters.ssns_per_adl;
	addrs_per_adl_c6                 := le.velocity_counters.addrs_per_adl_created_6months;
	adls_per_addr_c6                 := le.velocity_counters.adls_per_addr_created_6months;
	pb_total_orders                  := le.ibehavior.total_number_of_orders;
	paw_source_count                 := le.employment.source_ct;
	attr_num_rel_liens30             := (Boolean)le.bjl.liens_released_count30;
	attr_num_rel_liens90             := (Boolean)le.bjl.liens_released_count90;
	attr_num_rel_liens180            := (Boolean)le.bjl.liens_released_count180;
	attr_num_rel_liens12             := (Boolean)le.bjl.liens_released_count12;
	attr_num_rel_liens24             := (Boolean)le.bjl.liens_released_count24;
	attr_num_rel_liens36             := (Boolean)le.bjl.liens_released_count36;
	attr_num_rel_liens60             := (Boolean)le.bjl.liens_released_count60;
	bankrupt                         := le.bjl.bankrupt;
	disposition                      := le.bjl.disposition;
	filing_count                     := le.bjl.filing_count;
	bk_recent_count                  := le.bjl.bk_recent_count;
	liens_recent_unreleased_count    := le.bjl.liens_recent_unreleased_count;
	liens_historical_unreleased_ct   := le.bjl.liens_historical_unreleased_count;
	liens_historical_released_count  := le.bjl.liens_historical_released_count;
	liens_unrel_sc_ct                := le.liens.liens_unreleased_small_claims.count;
	criminal_count                   := le.bjl.criminal_count;
	ams_age                          := (Integer)le.student.age;
	ams_college_code                 := le.student.college_code;
	wealth_index                     := le.wealth_indicator;
	input_dob_age                    := (Integer)le.shell_input.age;
	inferred_age                     := (Integer)le.inferred_age;
	reported_dob                     := le.reported_dob;


NULL := -999999999;

INTEGER contains_i( string haystack, string needle ) := (INTEGER)(StringLib.StringFind(haystack, needle, 1) > 0);

BOOLEAN indexw(string source, string target, string delim) :=
	(source = target) OR
	(StringLib.StringFind(source, delim + target + delim, 1) > 0) OR
	(source[1..length(target)+1] = target + delim) OR
	(StringLib.StringReverse(source)[1..length(target)+1] = StringLib.StringReverse(target) + delim);

sysdate := common.sas_date(if(le.historydate=999999, (STRING)Std.Date.Today(), (string6)le.historydate+'01'));

slc_num_loans := if(num_appl_nos = '', NULL, (Integer)num_appl_nos);

iv_vp002_phn_disconnected := map(
    not(hphnpop)                                                                      => ' ',
    (Integer)rc_hriskphoneflag = 5 or trim(trim(nap_status, LEFT), LEFT, RIGHT) = 'D' => '1',
                                                                                         '0');

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

iv_ms001_ssns_per_adl := map(
    not(truedid)     => NULL,
    ssns_per_adl = 0 => 1,
                        ssns_per_adl);

iv_pl002_addrs_per_adl_c6 := if(not(truedid), NULL, addrs_per_adl_c6);

iv_pl002_addrs_15yr := if(not(truedid), NULL, addrs_15yr);

iv_in001_wealth_index := if(not(truedid), ' ', (string)wealth_index);

iv_attr_rel_liens_recency := map(
    not(truedid)                        => NULL,
    attr_num_rel_liens30                => 1,
    attr_num_rel_liens90                => 3,
    attr_num_rel_liens180               => 6,
    attr_num_rel_liens12                => 12,
    attr_num_rel_liens24                => 24,
    attr_num_rel_liens36                => 36,
    attr_num_rel_liens60                => 60,
    liens_historical_released_count > 0 => 99,
                                           0);

iv_liens_unrel_sc_ct := if(not(truedid), NULL, liens_unrel_SC_ct);

iv_ams_college_code := map(
    not(truedid)            => '  ',
    ams_college_code = ''   => '-1',
                               trim(ams_college_code, LEFT));

iv_db001_bankruptcy := map(
    not(truedid or (Integer)ssnlength > 0)                                                                                                                 => '                 ',
    (disposition in ['Discharge NA', 'Discharged'])                                                                                                        => '1 - BK Discharged',
    (disposition in ['Dismissed'])                                                                                                                         => '2 - BK Dismissed ',
    (rc_bansflag in ['1', '2']) or (Integer)bankrupt = 1 or contains_i(ver_sources, 'BA') > 0 or (Integer)filing_count > 0 or (Integer)bk_recent_count > 0 => '3 - BK Other     ',
                                                                                                                                                              '0 - No BK        ');

iv_pv001_inp_avm_autoval := if(not(add1_pop), NULL, add1_avm_automated_valuation);

_reported_dob := common.sas_date((string)(reported_dob));

reported_age := if(min(sysdate, _reported_dob) = NULL, NULL, truncate((sysdate - _reported_dob) / 365.25));

iv_combined_age := map(
    not(truedid or dobpop) => NULL,
    age > 0                => age,
    input_dob_age > 0      => input_dob_age,
    inferred_age > 0       => inferred_age,
    reported_age > 0       => reported_age,
    ams_age > 0            => ams_age,
                              -1);

iv_inp_own_prop_x_addr_naprop := map(
    not(add1_pop)            => '  ',
    property_owned_total > 0 => (string)(add1_naprop + 10),
                                if(length((string)add1_naprop) < 2, '0' + (string)add1_naprop, (string)add1_naprop));

iv_addrs_10yr := map(
    not(truedid)          => NULL,
    unique_addr_count = 0 => -1,
                             addrs_10yr);

iv_adls_per_addr_c6 := if(not(add1_pop), NULL, adls_per_addr_c6);

iv_paw_source_count := if(not(truedid), NULL, paw_source_count);

iv_unreleased_liens_ct := if(not(truedid), NULL, if(max(liens_recent_unreleased_count, liens_historical_unreleased_ct) = NULL, NULL, sum(if(liens_recent_unreleased_count = NULL, 0, liens_recent_unreleased_count), if(liens_historical_unreleased_ct = NULL, 0, liens_historical_unreleased_ct))));

iv_pb_total_orders := map(
    not(truedid)         => NULL,
    pb_total_orders = '' => -1,
                            (INTEGER)pb_total_orders);

n_subscore0 := map(
    NULL < slc_num_loans AND slc_num_loans < 2 => -1.028332,
    2 <= slc_num_loans AND slc_num_loans < 3   => -0.182152,
    3 <= slc_num_loans AND slc_num_loans < 4   => -0.042821,
    4 <= slc_num_loans AND slc_num_loans < 5   => 0.095537,
    5 <= slc_num_loans                         => 0.519863,
                                                  0);

n_subscore1 := map(
    (iv_in001_wealth_index in [' '])      => 0,
    (iv_in001_wealth_index in ['0'])      => -0.077429,
    (iv_in001_wealth_index in ['1'])      => -0.372943,
    (iv_in001_wealth_index in ['2'])      => -0.280386,
    (iv_in001_wealth_index in ['3'])      => -0.009683,
    (iv_in001_wealth_index in ['4'])      => 0.162428,
    (iv_in001_wealth_index in ['5', '6']) => 0.39566,
                                             0);

n_subscore2 := map(
    NULL < iv_liens_unrel_sc_ct AND iv_liens_unrel_sc_ct < 1 => 0.034532,
    1 <= iv_liens_unrel_sc_ct                                => -0.291474,
                                                                0);

n_subscore3 := map(
    (iv_ams_college_code in [' '])       => 0,
    (iv_ams_college_code in ['-1', '2']) => -0.02861,
    (iv_ams_college_code in ['1', '4'])  => 0.305837,
                                            0);

n_subscore4 := map(
    (iv_attr_rel_liens_recency in [1, 3, 6, 12, 24, 36]) => 0.308146,
    (iv_attr_rel_liens_recency in [0, 60, 99])           => -0.023712,
                                                            0);

n_subscore5 := map(
    NULL < iv_sr001_m_bureau_adl_fs AND iv_sr001_m_bureau_adl_fs < 228 => -0.077793,
    228 <= iv_sr001_m_bureau_adl_fs AND iv_sr001_m_bureau_adl_fs < 307 => -0.043745,
    307 <= iv_sr001_m_bureau_adl_fs AND iv_sr001_m_bureau_adl_fs < 340 => -0.005777,
    340 <= iv_sr001_m_bureau_adl_fs                                    => 0.221781,
                                                                          0);

n_subscore6 := map(
    NULL < iv_pl002_addrs_15yr AND iv_pl002_addrs_15yr < 4 => 0.143396,
    4 <= iv_pl002_addrs_15yr AND iv_pl002_addrs_15yr < 5   => 0.070324,
    5 <= iv_pl002_addrs_15yr AND iv_pl002_addrs_15yr < 6   => -0.031082,
    6 <= iv_pl002_addrs_15yr AND iv_pl002_addrs_15yr < 7   => -0.09618,
    7 <= iv_pl002_addrs_15yr                               => -0.152936,
                                                              0);

n_subscore7 := map(
    NULL < iv_ms001_ssns_per_adl AND iv_ms001_ssns_per_adl < 2 => 0.057758,
    2 <= iv_ms001_ssns_per_adl AND iv_ms001_ssns_per_adl < 3   => -0.090697,
    3 <= iv_ms001_ssns_per_adl                                 => -0.176937,
                                                                  0);

n_subscore8 := map(
    ((String)adl_addr in ['0', '3']) => -0.142203,
    ((String)adl_addr in ['1', '2']) => 0.056683,
                                        0);

n_subscore9 := map(
    (iv_vp002_phn_disconnected in [' ']) => 0,
    (iv_vp002_phn_disconnected in ['0']) => 0.01731,
    (iv_vp002_phn_disconnected in ['1']) => -0.172677,
                                            0);

n_subscore10 := map(
    NULL < iv_pl002_addrs_per_adl_c6 AND iv_pl002_addrs_per_adl_c6 < 1 => 0.024707,
    1 <= iv_pl002_addrs_per_adl_c6                                     => -0.235281,
                                                                          0);

e_subscore0 := map(
    NULL < slc_num_loans AND slc_num_loans < 7 => -0.496159,
    7 <= slc_num_loans AND slc_num_loans < 8   => -0.357954,
    8 <= slc_num_loans AND slc_num_loans < 9   => -0.162273,
    9 <= slc_num_loans AND slc_num_loans < 10  => -0.05413,
    10 <= slc_num_loans AND slc_num_loans < 12 => 0.110859,
    12 <= slc_num_loans AND slc_num_loans < 14 => 0.195111,
    14 <= slc_num_loans AND slc_num_loans < 17 => 0.425269,
    17 <= slc_num_loans AND slc_num_loans < 23 => 0.552107,
    23 <= slc_num_loans                        => 0.933831,
                                                  0);

e_subscore1 := map(
    NULL < iv_addrs_10yr AND iv_addrs_10yr < 0 => 0,
    0 <= iv_addrs_10yr AND iv_addrs_10yr < 1   => 0.148848,
    1 <= iv_addrs_10yr AND iv_addrs_10yr < 2   => 0.069351,
    2 <= iv_addrs_10yr AND iv_addrs_10yr < 3   => 0.036989,
    3 <= iv_addrs_10yr AND iv_addrs_10yr < 4   => -0.042068,
    4 <= iv_addrs_10yr AND iv_addrs_10yr < 5   => -0.092608,
    5 <= iv_addrs_10yr                         => -0.113348,
                                                  0);

e_subscore2 := map(
    NULL < iv_unreleased_liens_ct AND iv_unreleased_liens_ct < 1 => 0.054524,
    1 <= iv_unreleased_liens_ct AND iv_unreleased_liens_ct < 2   => -0.034011,
    2 <= iv_unreleased_liens_ct AND iv_unreleased_liens_ct < 3   => -0.046734,
    3 <= iv_unreleased_liens_ct AND iv_unreleased_liens_ct < 5   => -0.100145,
    5 <= iv_unreleased_liens_ct                                  => -0.229826,
                                                                    0);

e_subscore3 := map(
    (iv_in001_wealth_index in [' '])      => 0,
    (iv_in001_wealth_index in ['0'])      => -0.0196,
    (iv_in001_wealth_index in ['1'])      => -0.335545,
    (iv_in001_wealth_index in ['2'])      => -0.104018,
    (iv_in001_wealth_index in ['3'])      => -0.069474,
    (iv_in001_wealth_index in ['4'])      => 0.068438,
    (iv_in001_wealth_index in ['5', '6']) => 0.26696,
                                             0);

e_subscore4 := map(
    NULL < iv_combined_age AND iv_combined_age < 45 => -0.057771,
    45 <= iv_combined_age AND iv_combined_age < 51  => 0.015268,
    51 <= iv_combined_age AND iv_combined_age < 59  => 0.04532,
    59 <= iv_combined_age                           => 0.169602,
                                                       0);

e_subscore5 := map(
    (iv_inp_own_prop_x_addr_naprop in [' '])                                => 0,
    (iv_inp_own_prop_x_addr_naprop in ['00', '01', '02', '11'])             => -0.061848,
    (iv_inp_own_prop_x_addr_naprop in ['03', '04', '10', '12', '13', '14']) => 0.091902,
                                                                               0);

e_subscore6 := map(
    NULL < iv_pv001_inp_avm_autoval AND iv_pv001_inp_avm_autoval < 1         => 0.002745,
    1 <= iv_pv001_inp_avm_autoval AND iv_pv001_inp_avm_autoval < 107428      => -0.112479,
    107428 <= iv_pv001_inp_avm_autoval AND iv_pv001_inp_avm_autoval < 189996 => -0.033875,
    189996 <= iv_pv001_inp_avm_autoval                                       => 0.135893,
                                                                                0);

e_subscore7 := map(
    (iv_db001_bankruptcy in [' '])                                => 0,
    (iv_db001_bankruptcy in ['0 - No BK'])                        => 0.016545,
    (iv_db001_bankruptcy in ['1 - BK Discharged'])                => -0.048534,
    (iv_db001_bankruptcy in ['2 - BK Dismissed', '3 - BK Other']) => -0.200114,
                                                                     0);

e_subscore8 := map(
    ((String)adl_addr in ['0', '3']) => -0.073851,
    ((String)adl_addr in ['1', '2']) => 0.028518,
                                        0);

e_subscore9 := map(
    NULL < iv_ms001_ssns_per_adl AND iv_ms001_ssns_per_adl < 2 => 0.019258,
    2 <= iv_ms001_ssns_per_adl AND iv_ms001_ssns_per_adl < 3   => -0.023106,
    3 <= iv_ms001_ssns_per_adl                                 => -0.085618,
                                                                  0);

e_subscore10 := map(
    NULL < iv_adls_per_addr_c6 AND iv_adls_per_addr_c6 < 1 => 0.023328,
    1 <= iv_adls_per_addr_c6                               => -0.054554,
                                                              0);

e_subscore11 := map(
    (iv_ams_college_code in [' '])       => 0,
    (iv_ams_college_code in ['-1', '2']) => -0.012609,
    (iv_ams_college_code in ['1', '4'])  => 0.137287,
                                            0);

e_subscore12 := map(
    NULL < iv_paw_source_count AND iv_paw_source_count < 1 => -0.027601,
    1 <= iv_paw_source_count                               => 0.161501,
                                                              0);

e_subscore13 := map(
    NULL < iv_pb_total_orders AND iv_pb_total_orders < 1 => -0.088281,
    1 <= iv_pb_total_orders AND iv_pb_total_orders < 2   => -0.00389,
    2 <= iv_pb_total_orders                              => 0.041166,
                                                            0);

n_rawscore := n_subscore0 +
    n_subscore1 +
    n_subscore2 +
    n_subscore3 +
    n_subscore4 +
    n_subscore5 +
    n_subscore6 +
    n_subscore7 +
    n_subscore8 +
    n_subscore9 +
    n_subscore10;

n_lnoddsscore := n_rawscore + -0.854487;

n_probscore := exp(n_lnoddsscore) / (1 + exp(n_lnoddsscore));

e_rawscore := e_subscore0 +
    e_subscore1 +
    e_subscore2 +
    e_subscore3 +
    e_subscore4 +
    e_subscore5 +
    e_subscore6 +
    e_subscore7 +
    e_subscore8 +
    e_subscore9 +
    e_subscore10 +
    e_subscore11 +
    e_subscore12 +
    e_subscore13;

e_lnoddsscore := e_rawscore + 0.393654;

e_probscore := exp(e_lnoddsscore) / (1 + exp(e_lnoddsscore));

base := 700;

pts := 40;

odds := 0.44 / (1 - 0.44);

ssn_deceased := (Integer)rc_decsflag = 1 or (Integer)indexw(StringLib.StringToUpperCase(trim(ver_sources, ALL)), 'DS', ',') > 0;

iv_riskview_222s := riskview.constants.noscore(le.iid.nas_summary,le.iid.nap_summary, le.address_verification.input_address_information.naprop, le.truedid);

n_ps_custom := map(
    ssn_deceased     => 200,
    iv_riskview_222s => 222,
                        min(if(max(round(pts * (n_lnoddsscore - ln(odds)) / ln(2) + base), 501) = NULL, -NULL, max(round(pts * (n_lnoddsscore - ln(odds)) / ln(2) + base), 501)), 900));

e_ps_custom := map(
    ssn_deceased     => 200,
    iv_riskview_222s => 222,
                        min(if(max(round(pts * (e_lnoddsscore - ln(odds)) / ln(2) + base), 501) = NULL, -NULL, max(round(pts * (e_lnoddsscore - ln(odds)) / ln(2) + base), 501)), 900));

rvc1405_1_0 := map(
    slc_num_loans <= 5 => n_ps_custom,
                          e_ps_custom);

rc5_2 := '';

n_glrc07 := (Integer)hphnpop = 1 and ((Integer)rc_hriskphoneflag = 5 or nap_status = 'D');

n_glrc25 := not((nas_summary in [3, 5, 6, 8, 10, 11, 12])) and not((nap_summary in [3, 5, 6, 8, 10, 11, 12]));

n_glrc98 := liens_unrel_SC_ct > 0 or if(max(liens_recent_unreleased_count, liens_historical_unreleased_ct) = NULL, NULL, sum(if(liens_recent_unreleased_count = NULL, 0, liens_recent_unreleased_count), if(liens_historical_unreleased_ct = NULL, 0, liens_historical_unreleased_ct))) > 0;

n_glrc9d := addrs_15yr > 4 or addrs_per_adl_c6 > 0;

n_glrc9i := 0 < iv_combined_age AND iv_combined_age < 35 and not((iv_ams_college_code in ['1', '2', '4']));

n_glrc9m := not((iv_in001_wealth_index in ['4', '5', '6']));

n_glrc9r := 0 <= iv_sr001_m_bureau_adl_fs AND iv_sr001_m_bureau_adl_fs < 307;

n_glrcms := ssns_per_adl > 2;

n_glrcbl := 0;

e_glrc25 := not((nas_summary in [3, 5, 6, 8, 10, 11, 12])) and not((nap_summary in [3, 5, 6, 8, 10, 11, 12]));

e_glrc98 := if(max(liens_recent_unreleased_count, liens_historical_unreleased_ct) = NULL, NULL, sum(if(liens_recent_unreleased_count = NULL, 0, liens_recent_unreleased_count), if(liens_historical_unreleased_ct = NULL, 0, liens_historical_unreleased_ct))) > 0;

e_glrc9a := (Integer)add1_pop = 1 and property_owned_total = 0 and add1_naprop != 4;

e_glrc9d := addrs_10yr > 2 or addrs_per_adl_c6 > 0;

e_glrc9i := not((iv_ams_college_code in ['1', '2', '4']));

e_glrc9m := not((iv_in001_wealth_index in ['4', '5', '6']));

e_glrc9r := ((Integer)truedid = 1 or (Integer)dobpop = 1) and iv_combined_age < 45;

e_glrc9w := filing_count > 0;

// e_glrc9y := pb_total_orders = '';

e_glrcms := ssns_per_adl > 2;

e_glrcpv := (Integer)add1_pop = 1 and add1_avm_automated_valuation < 150000;

e_glrcbl := 0;

rcvalue07_1 := (integer)n_glrc07 * (0.01731 - n_subscore9);

rcvalue07 := if(max(rcvalue07_1) = NULL, NULL, sum(if(rcvalue07_1 = NULL, 0, rcvalue07_1)));

rcvalue25_1 := (integer)n_glrc25 * (0.056683 - n_subscore8);

rcvalue25_2 := (integer)e_glrc25 * (0.028518 - e_subscore8);

rcvalue25 := if(max(rcvalue25_1, rcvalue25_2) = NULL, NULL, sum(if(rcvalue25_1 = NULL, 0, rcvalue25_1), if(rcvalue25_2 = NULL, 0, rcvalue25_2)));

rcvalue98_1 := (integer)n_glrc98 * (0.034532 - n_subscore2);

rcvalue98_2 := (integer)n_glrc98 * (0.308146 - n_subscore4);

rcvalue98_3 := (integer)e_glrc98 * (0.054524 - e_subscore2);

rcvalue98 := if(max(rcvalue98_1, rcvalue98_2, rcvalue98_3) = NULL, NULL, sum(if(rcvalue98_1 = NULL, 0, rcvalue98_1), if(rcvalue98_2 = NULL, 0, rcvalue98_2), if(rcvalue98_3 = NULL, 0, rcvalue98_3)));

rcvalue9a_1 := (integer)e_glrc9a * (0.091902 - e_subscore5);

rcvalue9a := if(max(rcvalue9a_1) = NULL, NULL, sum(if(rcvalue9a_1 = NULL, 0, rcvalue9a_1)));

rcvalue9d_1 := (integer)n_glrc9d * (0.143396 - n_subscore6);

rcvalue9d_2 := (integer)n_glrc9d * (0.024707 - n_subscore10);

rcvalue9d_3 := (integer)e_glrc9d * (0.148848 - e_subscore1);

rcvalue9d_4 := (integer)e_glrc9d * (0.023328 - e_subscore10);

rcvalue9d := if(max(rcvalue9d_1, rcvalue9d_2, rcvalue9d_3, rcvalue9d_4) = NULL, NULL, sum(if(rcvalue9d_1 = NULL, 0, rcvalue9d_1), if(rcvalue9d_2 = NULL, 0, rcvalue9d_2), if(rcvalue9d_3 = NULL, 0, rcvalue9d_3), if(rcvalue9d_4 = NULL, 0, rcvalue9d_4)));

rcvalue9i_1 := (integer)n_glrc9i * (0.305837 - n_subscore3);

rcvalue9i_2 := (integer)e_glrc9i * (0.137287 - e_subscore11);

rcvalue9i := if(max(rcvalue9i_1, rcvalue9i_2) = NULL, NULL, sum(if(rcvalue9i_1 = NULL, 0, rcvalue9i_1), if(rcvalue9i_2 = NULL, 0, rcvalue9i_2)));

rcvalue9m_1 := (integer)n_glrc9m * (0.39566 - n_subscore1);

rcvalue9m_2 := (integer)e_glrc9m * (0.26696 - e_subscore3);

rcvalue9m := if(max(rcvalue9m_1, rcvalue9m_2) = NULL, NULL, sum(if(rcvalue9m_1 = NULL, 0, rcvalue9m_1), if(rcvalue9m_2 = NULL, 0, rcvalue9m_2)));

rcvalue9r_1 := (integer)n_glrc9r * (0.221781 - n_subscore5);

rcvalue9r_2 := (integer)e_glrc9r * (0.169602 - e_subscore4);

rcvalue9r := if(max(rcvalue9r_1, rcvalue9r_2) = NULL, NULL, sum(if(rcvalue9r_1 = NULL, 0, rcvalue9r_1), if(rcvalue9r_2 = NULL, 0, rcvalue9r_2)));

rcvalue9w_1 := (integer)e_glrc9w * (0.016545 - e_subscore7);

rcvalue9w := if(max(rcvalue9w_1) = NULL, NULL, sum(if(rcvalue9w_1 = NULL, 0, rcvalue9w_1)));

// rcvalue9y_1 := (integer)e_glrc9y * (0.041166 - e_subscore13);

// rcvalue9y := if(max(rcvalue9y_1) = NULL, NULL, sum(if(rcvalue9y_1 = NULL, 0, rcvalue9y_1)));
rcvalue9y := 0;

rcvaluems_1 := (integer)n_glrcms * (0.057758 - n_subscore7);

rcvaluems_2 := (integer)e_glrcms * (0.019258 - e_subscore9);

rcvaluems := if(max(rcvaluems_1, rcvaluems_2) = NULL, NULL, sum(if(rcvaluems_1 = NULL, 0, rcvaluems_1), if(rcvaluems_2 = NULL, 0, rcvaluems_2)));

rcvaluepv_1 := (integer)e_glrcpv * (0.135893 - e_subscore6);

rcvaluepv := if(max(rcvaluepv_1) = NULL, NULL, sum(if(rcvaluepv_1 = NULL, 0, rcvaluepv_1)));

//*************************************************************************************//
// I have no idea how the reason code logic gets implemented in ECL, so everything below 
// probably needs to get changed or replaced.  The methodology for creating the reason codes is
// very similar to the logic used by the RiskView 4.0 scores, so you might want to consult
// that model code for guidance on implementing reason codes. 
//*************************************************************************************//

ds_layout := {STRING rc, REAL value};
rc_dataset := DATASET([
    {'07', RCValue07},
    {'25', RCValue25},
    {'98', RCValue98},
    {'9A', RCValue9A},
    {'9D', RCValue9D},
    {'9I', RCValue9I},
    {'9M', RCValue9M},
    {'9R', RCValue9R},
    {'9W', RCValue9W},
    {'9Y', RCValue9Y},
    {'MS', RCValueMS},
    {'PV', RCValuePV}
    ], ds_layout)(value > 0);

rcs_top4 := CHOOSEN(SORT(rc_dataset, -value), 4); // Take the top four reason codes

rcs_9p1 := if(rcs_top4[1].rc = '', ROW({'36', NULL}, ds_layout), rcs_top4[1]);
rcs_9p2 := MAP(rcs_9p1.rc != '36' AND rcs_top4[2].rc = '' and 500 < rvc1405_1_0 AND rvc1405_1_0 <= 720 => ROW({'36', NULL}, ds_layout),
               rcs_9p1.rc = '36' AND rcs_top4[2].rc = '' and 500 < rvc1405_1_0 AND rvc1405_1_0 <= 720 => ROW({'9E ', NULL}, ds_layout),
               rcs_top4[2]);
rcs_9p3 := rcs_top4[3];
rcs_9p4 := rcs_top4[4];
	
rcs_9p := rcs_9p1 & rcs_9p2 & rcs_9p3 & rcs_9p4;

rcs_override := MAP( rvc1405_1_0 = 200 => DATASET([{'02', NULL}], ds_layout),
                     rvc1405_1_0 = 222 => DATASET([{'9X', NULL}], ds_layout),
                     rvc1405_1_0 = 900 => DATASET([{'  ', NULL}], ds_layout),
                     NOT EXISTS(rcs_9p(rc != '')) => DATASET([{'36', NULL}], ds_layout),
                     rcs_9p);
										 
riTemp := RiskWiseFCRA.corrReasonCodes(le.consumerflags, 4);
	
rcs_final := PROJECT(rcs_override, TRANSFORM(Risk_Indicators.Layout_Desc,
                                             SELF.hri := LEFT.rc,
                                             SELF.desc := Risk_Indicators.getHRIDesc(LEFT.rc)));

inCalif := isCalifornia AND (
           (integer)(boolean)le.iid.combo_firstcount+(integer)(boolean)le.iid.combo_lastcount
           +(integer)(boolean)le.iid.combo_addrcount+(integer)(boolean)le.iid.combo_hphonecount
           +(integer)(boolean)le.iid.combo_ssncount+(integer)(boolean)le.iid.combo_dobcount) < 3;
		
ri := MAP( riTemp[1].hri <> '00' => riTemp,
           inCalif => DATASET([{'35', Risk_Indicators.getHRIDesc('35')}, {'00',''}, {'00',''}, {'00',''}], Risk_Indicators.Layout_Desc),
           rcs_final
           );
				
zeros := DATASET([{'00',''}, {'00',''}, {'00',''}, {'00',''}], Risk_Indicators.Layout_Desc);

reasons := CHOOSEN(ri & zeros, 4); // Keep up to 4 reason codes


//Intermediate variables

	#if(RVC_DEBUG)
		self.clam															:= le;
		self.sysdate                          := sysdate;
		self.adl_addr                         := (String)adl_addr;
		self.slc_num_loans                    := slc_num_loans;
		self.num_appl_nos                     := num_appl_nos;
		self.iv_vp002_phn_disconnected        := iv_vp002_phn_disconnected;
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
		self.iv_ms001_ssns_per_adl            := iv_ms001_ssns_per_adl;
		self.iv_pl002_addrs_per_adl_c6        := iv_pl002_addrs_per_adl_c6;
		self.iv_pl002_addrs_15yr              := iv_pl002_addrs_15yr;
		self.iv_in001_wealth_index            := iv_in001_wealth_index;
		self.iv_attr_rel_liens_recency        := iv_attr_rel_liens_recency;
		self.iv_liens_unrel_sc_ct             := iv_liens_unrel_sc_ct;
		self.iv_ams_college_code              := iv_ams_college_code;
		self.iv_db001_bankruptcy              := iv_db001_bankruptcy;
		self.iv_pv001_inp_avm_autoval         := iv_pv001_inp_avm_autoval;
		self._reported_dob                    := _reported_dob;
		self.reported_age                     := reported_age;
		self.iv_combined_age                  := iv_combined_age;
		self.iv_inp_own_prop_x_addr_naprop    := iv_inp_own_prop_x_addr_naprop;
		self.iv_addrs_10yr                    := iv_addrs_10yr;
		self.iv_adls_per_addr_c6              := iv_adls_per_addr_c6;
		self.iv_paw_source_count              := iv_paw_source_count;
		self.iv_unreleased_liens_ct           := iv_unreleased_liens_ct;
		self.iv_pb_total_orders               := iv_pb_total_orders;
		self.n_subscore0                      := n_subscore0;
		self.n_subscore1                      := n_subscore1;
		self.n_subscore2                      := n_subscore2;
		self.n_subscore3                      := n_subscore3;
		self.n_subscore4                      := n_subscore4;
		self.n_subscore5                      := n_subscore5;
		self.n_subscore6                      := n_subscore6;
		self.n_subscore7                      := n_subscore7;
		self.n_subscore8                      := n_subscore8;
		self.n_subscore9                      := n_subscore9;
		self.n_subscore10                     := n_subscore10;
		self.e_subscore0                      := e_subscore0;
		self.e_subscore1                      := e_subscore1;
		self.e_subscore2                      := e_subscore2;
		self.e_subscore3                      := e_subscore3;
		self.e_subscore4                      := e_subscore4;
		self.e_subscore5                      := e_subscore5;
		self.e_subscore6                      := e_subscore6;
		self.e_subscore7                      := e_subscore7;
		self.e_subscore8                      := e_subscore8;
		self.e_subscore9                      := e_subscore9;
		self.e_subscore10                     := e_subscore10;
		self.e_subscore11                     := e_subscore11;
		self.e_subscore12                     := e_subscore12;
		self.e_subscore13                     := e_subscore13;
		// self.n_scaledScore                    := n_scaledScore;
		self.n_rawscore                       := n_rawscore;
		self.n_lnoddsscore                    := n_lnoddsscore;
		self.n_probscore                      := n_probscore;
		// self.e_scaledScore                    := e_scaledScore;
		self.e_rawscore                       := e_rawscore;
		self.e_lnoddsscore                    := e_lnoddsscore;
		self.e_probscore                      := e_probscore;
		self.base                             := base;
		self.pts                              := pts;
		self.odds                             := odds;
		self.ssn_deceased                     := ssn_deceased;
		self.iv_riskview_222s                 := iv_riskview_222s;
		self.n_ps_custom                      := n_ps_custom;
		self.e_ps_custom                      := e_ps_custom;
		self.rvc1405_1_0                      := rvc1405_1_0;
		self.n_glrc07                         := n_glrc07;
		self.n_glrc25                         := n_glrc25;
		self.n_glrc98                         := n_glrc98;
		self.n_glrc9d                         := n_glrc9d;
		self.n_glrc9i                         := n_glrc9i;
		self.n_glrc9m                         := n_glrc9m;
		self.n_glrc9r                         := n_glrc9r;
		self.n_glrcms                         := n_glrcms;
		self.n_glrcbl                         := n_glrcbl;
		self.e_glrc25                         := e_glrc25;
		self.e_glrc98                         := e_glrc98;
		self.e_glrc9a                         := e_glrc9a;
		self.e_glrc9d                         := e_glrc9d;
		self.e_glrc9i                         := e_glrc9i;
		self.e_glrc9m                         := e_glrc9m;
		self.e_glrc9r                         := e_glrc9r;
		self.e_glrc9w                         := e_glrc9w;
		// self.e_glrc9y                         := e_glrc9y;
		self.e_glrcms                         := e_glrcms;
		self.e_glrcpv                         := e_glrcpv;
		self.e_glrcbl                         := e_glrcbl;
		self.rcvalue07_1                      := rcvalue07_1;
		self.rcvalue07                        := rcvalue07;
		self.rcvalue25_1                      := rcvalue25_1;
		self.rcvalue25_2                      := rcvalue25_2;
		self.rcvalue25                        := rcvalue25;
		self.rcvalue98_1                      := rcvalue98_1;
		self.rcvalue98_2                      := rcvalue98_2;
		self.rcvalue98_3                      := rcvalue98_3;
		self.rcvalue98                        := rcvalue98;
		self.rcvalue9a_1                      := rcvalue9a_1;
		self.rcvalue9a                        := rcvalue9a;
		self.rcvalue9d_1                      := rcvalue9d_1;
		self.rcvalue9d_2                      := rcvalue9d_2;
		self.rcvalue9d_3                      := rcvalue9d_3;
		self.rcvalue9d_4                      := rcvalue9d_4;
		self.rcvalue9d                        := rcvalue9d;
		self.rcvalue9i_1                      := rcvalue9i_1;
		self.rcvalue9i_2                      := rcvalue9i_2;
		self.rcvalue9i                        := rcvalue9i;
		self.rcvalue9m_1                      := rcvalue9m_1;
		self.rcvalue9m_2                      := rcvalue9m_2;
		self.rcvalue9m                        := rcvalue9m;
		self.rcvalue9r_1                      := rcvalue9r_1;
		self.rcvalue9r_2                      := rcvalue9r_2;
		self.rcvalue9r                        := rcvalue9r;
		self.rcvalue9w_1                      := rcvalue9w_1;
		self.rcvalue9w                        := rcvalue9w;
		self.rcvalue9y_1                      := rcvalue9y_1;
		self.rcvalue9y                        := rcvalue9y;
		self.rcvaluems_1                      := rcvaluems_1;
		self.rcvaluems_2                      := rcvaluems_2;
		self.rcvaluems                        := rcvaluems;
		self.rcvaluepv_1                      := rcvaluepv_1;
		self.rcvaluepv                        := rcvaluepv;
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
		self.score := if(reasons[1].hri IN ['91','92','93','94'],(STRING3)((INTEGER)reasons[1].hri + 10),(string3)rvc1405_1_0);
END;

		model := project( clam, doModel(left) );

		return model;

END;
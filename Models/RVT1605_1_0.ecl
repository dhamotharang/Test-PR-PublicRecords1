IMPORT ut, Std, RiskWise, RiskWiseFCRA, Risk_Indicators, riskview;

EXPORT rvt1605_1_0 (GROUPED DATASET(Risk_Indicators.Layout_Boca_Shell) clam, Boolean isCalifornia = False) := FUNCTION

	MODEL_DEBUG := False;

	#if(MODEL_DEBUG)
	Layout_Debug := RECORD
	
	/* Model Intermediate Variables */
	//STRING NULL;
	 Integer seq;
   Integer sysdate;
   Integer wp_adl_wp_fseen_pos;
   String wp_adl_fseen_wp;
   Real _wp_adl_fseen_wp;
   Real _src_wp_adl_fseen;
   Integer iv_sr001_m_wp_adl_fs;
   Integer iv_ms001_ssns_per_adl;
   Integer iv_pv001_inp_avm_autoval;
   Integer iv_pv001_bst_avm_autoval;
   String iv_po001_inp_addr_naprop;
   String iv_ed001_college_ind;
   Integer iv_iq001_inq_count12;
   Integer prop_adl_p_lseen_pos;
   String prop_adl_lseen_p;
   Integer _prop_adl_lseen_p;
   Integer _src_prop_adl_lseen;
   Real iv_mos_src_property_adl_lseen;
   String iv_full_name_ver_sources;
   Real iv_dob_score;
   Integer iv_bst_addr_assessed_total_val;
   Integer iv_prv_addr_avm_auto_val;
   Integer iv_addr_lres_12mo_count;
   Integer iv_ssns_per_addr_c6;
   Real iv_paw_source_count;
   String iv_criminal_x_felony;
   Real t_subscore0;
   Real t_subscore1;
   Real t_subscore2;
   Real t_subscore3;
   Real t_subscore4;
   Real t_subscore5;
   Real t_subscore6;
   Real t_subscore7;
   Real t_subscore8;
   Real t_subscore9;
   Real t_subscore10;
   Real t_subscore11;
   Real t_subscore12;
   Real t_subscore13;
   Real t_subscore14;
   Real t_subscore15;
   Real t_rawscore;
   Real t_lnoddsscore;
   Real t_probscore;
   String t_aacd_0;
   Real t_dist_0;
   String t_aacd_1;
   Real t_dist_1;
   String t_aacd_2;
   Real t_dist_2;
   String t_aacd_3;
   Real t_dist_3;
   String t_aacd_4;
   Real t_dist_4;
   String t_aacd_5;
   Real t_dist_5;
   String t_aacd_6;
   Real t_dist_6;
   String t_aacd_7;
   Real t_dist_7;
   String t_aacd_8;
   Real t_dist_8;
   String t_aacd_9;
   Real t_dist_9;
   String t_aacd_10;
   Real t_dist_10;
   String t_aacd_11;
   Real t_dist_11;
   String t_aacd_12;
   Real t_dist_12;
   String t_aacd_13;
   Real t_dist_13;
   String t_aacd_14;
   Real t_dist_14;
   String t_aacd_15;
   Real t_dist_15;
   Real t_rcvalue9i;
   Real t_rcvaluepv;
   Real t_rcvalue9a;
   Real t_rcvalue36;
   Real t_rcvalue9d;
   Real t_rcvaluems;
   Real t_rcvalue9q;
   Real t_rcvalue9r;
   Real t_rcvalue97;
   Integer base;
   Real odds;
   Real point;
   Boolean ssn_deceased;
   Boolean iv_riskview_222s;
   Integer rvt1605_1_1;
   String t_rc1;
   String t_rc2;
   String t_rc3;
   String t_rc4;
   Real t_vl1;
   Real t_vl2;
   Real t_vl3;
   Real t_vl4;
   String _rc_inq;
   String rc4;
   String rc3;
   String rc2;
   String rc1;
   String rc5;



			Risk_Indicators.Layout_Boca_Shell clam;
			END;
			
		Layout_Debug doModel(clam le) := TRANSFORM
	#else
		Layout_ModelOut doModel(clam le) := TRANSFORM
	#end

	/* ***********************************************************
	 *             Model Input Variable Assignments              *
	 ************************************************************* */
	
	truedid                          := le.truedid;
	nas_summary                      := le.iid.nas_summary;
	nap_summary                      := le.iid.nap_summary;
	rc_decsflag                      := le.iid.decsflag;
	rc_bansflag                      := le.iid.bansflag;
	combo_dobscore                   := le.iid.combo_dobscore;
	ver_sources                      := le.header_summary.ver_sources;
	ver_sources_first_seen           := le.header_summary.ver_sources_first_seen_date;
	ver_sources_last_seen            := le.header_summary.ver_sources_last_seen_date;
	fnamepop                         := le.input_validation.firstname;
	lnamepop                         := le.input_validation.lastname;
	addrpop                          := le.input_validation.address;
	dobpop                           := le.input_validation.dateofbirth;
	hphnpop                          := le.input_validation.homephone;
	source_count                     := le.name_verification.source_count;
	fname_eda_sourced_type           := le.name_verification.fname_eda_sourced_type;
	lname_eda_sourced_type           := le.name_verification.lname_eda_sourced_type;
	add1_isbestmatch                 := le.address_verification.input_address_information.isbestmatch;
	add1_avm_automated_valuation     := le.avm.input_address_information.avm_automated_valuation;
	add1_naprop                      := le.address_verification.input_address_information.naprop;
	add1_assessed_total_value        := le.address_verification.input_address_information.assessed_total_value;
	add1_pop                         := le.addrpop;
	property_owned_total             := le.address_verification.owned.property_total;
	property_sold_total              := le.address_verification.sold.property_total;
	add2_avm_automated_valuation     := le.avm.address_history_1.avm_automated_valuation;
	add2_assessed_total_value        := le.address_verification.address_history_1.assessed_total_value;
	add3_avm_automated_valuation     := le.avm.address_history_2.avm_automated_valuation;
	addr_lres_12mo_count             := le.address_history_summary.lres_12mo_count;
	ssns_per_adl                     := le.velocity_counters.ssns_per_adl;
	ssns_per_addr_c6                 := le.velocity_counters.ssns_per_addr_created_6months;
	inq_count12                      := le.acc_logs.inquiries.count12;
	paw_source_count                 := le.employment.source_ct;
	bankrupt                         := le.bjl.bankrupt;
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


	/* ***********************************************************
	 *   Generated ECL         *
	 ************************************************************* */


NULL := -999999999;


BOOLEAN indexw(string source, string target, string delim) :=
	(source = target) OR
	(StringLib.StringFind(source, delim + target + delim, 1) > 0) OR
	(source[1..length(target)+1] = target + delim) OR
	(StringLib.StringReverse(source)[1..length(target)+1] = StringLib.StringReverse(target) + delim);

sysdate := common.sas_date(if(le.historydate=999999, (string8)Std.Date.Today(), (string6)le.historydate+'01'));

wp_adl_wp_fseen_pos := Models.Common.findw_cpp(ver_sources, 'WP' , ', ', 'E');

wp_adl_fseen_wp := if(wp_adl_wp_fseen_pos = 0, '       0', Models.Common.getw(ver_sources_first_seen, wp_adl_wp_fseen_pos, ','));

_wp_adl_fseen_wp := common.sas_date((string)(wp_adl_fseen_wp));

_src_wp_adl_fseen := _wp_adl_fseen_wp;

iv_sr001_m_wp_adl_fs := map(
    not(truedid)             => NULL,
    _src_wp_adl_fseen = NULL => -1,
               if ((sysdate - _src_wp_adl_fseen) / (365.25 / 12) >= 0, truncate((sysdate - _src_wp_adl_fseen) / (365.25 / 12)), roundup((sysdate - _src_wp_adl_fseen) / (365.25 / 12))));

iv_ms001_ssns_per_adl := map(
    not(truedid)     => NULL,
    ssns_per_adl = 0 => 1,
       ssns_per_adl);

iv_pv001_inp_avm_autoval := if(not(add1_pop), NULL, add1_avm_automated_valuation);

iv_pv001_bst_avm_autoval := map(
    not(truedid)     => NULL,
    add1_isbestmatch => add1_avm_automated_valuation,
       add2_avm_automated_valuation);

iv_po001_inp_addr_naprop := if(not(add1_pop), '', (String)add1_naprop);

iv_ed001_college_ind := map(
    not(truedid)                                                                                                                                                          => ' ',
    not(ams_college_code = '') or not(ams_college_type = '') or (integer)ams_college_tier > 0 or not(ams_college_major = '') or (ams_file_type in ['H', 'C', 'A']) => '1',
    ams_file_type = 'M'                                                                                                                                                   => '0',
    not(ams_class = '') or not(ams_income_level_code = '')                                                                                                            => '1',
                                                                                                                                                                             '0');

iv_iq001_inq_count12 := if(not(truedid), NULL, inq_count12);

prop_adl_p_lseen_pos := Models.Common.findw_cpp(ver_sources, 'P' , ', ', 'E');

prop_adl_lseen_p := if(prop_adl_p_lseen_pos = 0, '       0', Models.Common.getw(ver_sources_last_seen, prop_adl_p_lseen_pos, ','));

_prop_adl_lseen_p := common.sas_date((string)(prop_adl_lseen_p));

_src_prop_adl_lseen := _prop_adl_lseen_p;

iv_mos_src_property_adl_lseen := map(
    not(truedid)               => NULL,
    _src_prop_adl_lseen = NULL => -1,
                 if ((sysdate - _src_prop_adl_lseen) / (365.25 / 12) >= 0, truncate((sysdate - _src_prop_adl_lseen) / (365.25 / 12)), roundup((sysdate - _src_prop_adl_lseen) / (365.25 / 12))));

iv_full_name_ver_sources := map(
    not((hphnpop or addrpop) and lnamepop and fnamepop)          => '             ',
    source_count > 0 and not(fname_eda_sourced_type = '') and not(lname_eda_sourced_type = '') => 'Phn & NonPhn ',
    source_count > 0                            => 'NonPhn Only  ',
    not(fname_eda_sourced_type = '') and not(lname_eda_sourced_type = '')     => 'Phn Only     ',
                 'Name not Verd');

iv_dob_score := if(not(truedid and dobpop), NULL, combo_dobscore);

iv_bst_addr_assessed_total_val := map(
    not(truedid)     => NULL,
    add1_isbestmatch => add1_assessed_total_value,
       add2_assessed_total_value);

iv_prv_addr_avm_auto_val := map(
    not(truedid)     => NULL,
    add1_isbestmatch => add2_avm_automated_valuation,
       add3_avm_automated_valuation);

iv_addr_lres_12mo_count := map(
    not(truedid)                 => NULL,
    addr_lres_12mo_count = -9999 => -1,
                   addr_lres_12mo_count);

iv_ssns_per_addr_c6 := if(not(add1_pop), NULL, ssns_per_addr_c6);

iv_paw_source_count := if(not(truedid), NULL, paw_source_count);

iv_criminal_x_felony := if(not(truedid), '   ', trim((String)min(if(criminal_count = NULL, -NULL, criminal_count), 3), LEFT, RIGHT) + trim(' - ', LEFT, RIGHT) + trim((String)min(if(felony_count = NULL, -NULL, felony_count), 3), LEFT, RIGHT));

t_subscore0 := map(
    NULL < iv_mos_src_property_adl_lseen AND iv_mos_src_property_adl_lseen < 0 => -0.149438,
    0 <= iv_mos_src_property_adl_lseen AND iv_mos_src_property_adl_lseen < 59  => 1.310834,
    59 <= iv_mos_src_property_adl_lseen      => 0.23864,
              0);

t_subscore1 := map(
    (iv_full_name_ver_sources in [' '])             => 0,
    (iv_full_name_ver_sources in ['Name not Verd']) => -0.400012,
    (iv_full_name_ver_sources in ['NonPhn Only'])   => -0.054891,
    (iv_full_name_ver_sources in ['Phn & NonPhn'])  => 0.586855,
    (iv_full_name_ver_sources in ['Phn Only'])      => 0.43772,
                     0);

t_subscore2 := map(
    NULL < iv_pv001_inp_avm_autoval AND iv_pv001_inp_avm_autoval < 1         => -0.05397,
    1 <= iv_pv001_inp_avm_autoval AND iv_pv001_inp_avm_autoval < 26000       => -0.59073,
    26000 <= iv_pv001_inp_avm_autoval AND iv_pv001_inp_avm_autoval < 74000   => -0.432992,
    74000 <= iv_pv001_inp_avm_autoval AND iv_pv001_inp_avm_autoval < 95192   => -0.197552,
    95192 <= iv_pv001_inp_avm_autoval AND iv_pv001_inp_avm_autoval < 208457  => -0.154408,
    208457 <= iv_pv001_inp_avm_autoval AND iv_pv001_inp_avm_autoval < 258237 => 0.075864,
    258237 <= iv_pv001_inp_avm_autoval AND iv_pv001_inp_avm_autoval < 368000 => 0.268932,
    368000 <= iv_pv001_inp_avm_autoval AND iv_pv001_inp_avm_autoval < 431516 => 0.445642,
    431516 <= iv_pv001_inp_avm_autoval                      => 0.7597,
            0);

t_subscore3 := map(
    (iv_ed001_college_ind in [' ']) => 0.058388,
    (iv_ed001_college_ind in ['0']) => -0.061685,
    (iv_ed001_college_ind in ['1']) => 1.118732,
                      0);

t_subscore4 := map(
    (iv_po001_inp_addr_naprop in [' ']) => -0.006522,
    (iv_po001_inp_addr_naprop in ['1']) => -0.140799,
    (iv_po001_inp_addr_naprop in ['0']) => -0.042779,
    (iv_po001_inp_addr_naprop in ['2']) => 0.104672,
    (iv_po001_inp_addr_naprop in ['3']) => 0.502591,
    (iv_po001_inp_addr_naprop in ['4']) => 0.76458,
         0);

t_subscore5 := map(
    NULL < iv_pv001_bst_avm_autoval AND iv_pv001_bst_avm_autoval < 1         => -0.030924,
    1 <= iv_pv001_bst_avm_autoval AND iv_pv001_bst_avm_autoval < 32428       => -0.375846,
    32428 <= iv_pv001_bst_avm_autoval AND iv_pv001_bst_avm_autoval < 94458   => -0.372104,
    94458 <= iv_pv001_bst_avm_autoval AND iv_pv001_bst_avm_autoval < 174479  => -0.144044,
    174479 <= iv_pv001_bst_avm_autoval AND iv_pv001_bst_avm_autoval < 269500 => -0.024386,
    269500 <= iv_pv001_bst_avm_autoval AND iv_pv001_bst_avm_autoval < 340374 => 0.089167,
    340374 <= iv_pv001_bst_avm_autoval AND iv_pv001_bst_avm_autoval < 416111 => 0.220216,
    416111 <= iv_pv001_bst_avm_autoval                      => 0.620505,
            0);

t_subscore6 := map(
    NULL < iv_ssns_per_addr_c6 AND iv_ssns_per_addr_c6 < 1 => 0.096147,
    1 <= iv_ssns_per_addr_c6 AND iv_ssns_per_addr_c6 < 2   => -0.29931,
    2 <= iv_ssns_per_addr_c6 AND iv_ssns_per_addr_c6 < 3   => -0.366171,
    3 <= iv_ssns_per_addr_c6              => -0.463159,
           0);

t_subscore7 := map(
    NULL < iv_iq001_inq_count12 AND iv_iq001_inq_count12 < 1 => 0.064706,
    1 <= iv_iq001_inq_count12 AND iv_iq001_inq_count12 < 2   => -0.404559,
    2 <= iv_iq001_inq_count12 AND iv_iq001_inq_count12 < 3   => -0.447366,
    3 <= iv_iq001_inq_count12               => -0.719385,
             0);

t_subscore8 := map(
    (iv_criminal_x_felony in [' '])                => -0.019492,
    (iv_criminal_x_felony in ['0-0'])                               => 0.024889,
    (iv_criminal_x_felony in ['0-1', '0-2', '0-3', '1-0', '1-1', '1-2', '1-3', '2-0', '2-1', '2-2', '2-3', '3-0', '3-1', '3-2', '3-3']) => -0.860688,
                                     0);

t_subscore9 := map(
    NULL < iv_sr001_m_wp_adl_fs AND iv_sr001_m_wp_adl_fs < 0  => -0.009735,
    0 <= iv_sr001_m_wp_adl_fs AND iv_sr001_m_wp_adl_fs < 10   => -0.702816,
    10 <= iv_sr001_m_wp_adl_fs AND iv_sr001_m_wp_adl_fs < 20  => -0.276486,
    20 <= iv_sr001_m_wp_adl_fs AND iv_sr001_m_wp_adl_fs < 31  => -0.187214,
    31 <= iv_sr001_m_wp_adl_fs AND iv_sr001_m_wp_adl_fs < 105 => 0.048664,
    105 <= iv_sr001_m_wp_adl_fs              => 0.337639,
              0);

t_subscore10 := map(
    NULL < iv_paw_source_count AND iv_paw_source_count < 1 => -0.038065,
    1 <= iv_paw_source_count              => 0.664937,
           0);

t_subscore11 := map(
    NULL < iv_bst_addr_assessed_total_val AND iv_bst_addr_assessed_total_val < 1         => -0.058171,
    1 <= iv_bst_addr_assessed_total_val AND iv_bst_addr_assessed_total_val < 17920       => -0.255793,
    17920 <= iv_bst_addr_assessed_total_val AND iv_bst_addr_assessed_total_val < 201510  => 0.047261,
    201510 <= iv_bst_addr_assessed_total_val AND iv_bst_addr_assessed_total_val < 221800 => 0.064325,
    221800 <= iv_bst_addr_assessed_total_val AND iv_bst_addr_assessed_total_val < 354767 => 0.228654,
    354767 <= iv_bst_addr_assessed_total_val           => 0.298443,
                        0);

t_subscore12 := map(
    NULL < iv_prv_addr_avm_auto_val AND iv_prv_addr_avm_auto_val < 1         => -0.026856,
    1 <= iv_prv_addr_avm_auto_val AND iv_prv_addr_avm_auto_val < 45654       => -0.433482,
    45654 <= iv_prv_addr_avm_auto_val AND iv_prv_addr_avm_auto_val < 182914  => -0.114821,
    182914 <= iv_prv_addr_avm_auto_val AND iv_prv_addr_avm_auto_val < 234500 => 0.024166,
    234500 <= iv_prv_addr_avm_auto_val AND iv_prv_addr_avm_auto_val < 357000 => 0.142417,
    357000 <= iv_prv_addr_avm_auto_val                      => 0.546524,
            0);

t_subscore13 := map(
    NULL < iv_ms001_ssns_per_adl AND iv_ms001_ssns_per_adl < 2 => 0.040523,
    2 <= iv_ms001_ssns_per_adl AND iv_ms001_ssns_per_adl < 3   => -0.389726,
    3 <= iv_ms001_ssns_per_adl                => -0.456926,
               0);

t_subscore14 := map(
    NULL < iv_dob_score AND iv_dob_score < 100 => -0.371725,
    100 <= iv_dob_score AND iv_dob_score < 255 => 0.056518,
    255 <= iv_dob_score       => 0,
                0);

t_subscore15 := map(
    NULL < iv_addr_lres_12mo_count AND iv_addr_lres_12mo_count < 0 => -0.135431,
    0 <= iv_addr_lres_12mo_count AND iv_addr_lres_12mo_count < 1   => 0.071095,
    1 <= iv_addr_lres_12mo_count                  => -0.057569,
                   0);

t_rawscore := t_subscore0 +
    t_subscore1 +
    t_subscore2 +
    t_subscore3 +
    t_subscore4 +
    t_subscore5 +
    t_subscore6 +
    t_subscore7 +
    t_subscore8 +
    t_subscore9 +
    t_subscore10 +
    t_subscore11 +
    t_subscore12 +
    t_subscore13 +
    t_subscore14 +
    t_subscore15;

t_lnoddsscore := t_rawscore + 1.769423;

t_probscore := exp(t_lnoddsscore) / (1 + exp(t_lnoddsscore));

t_aacd_0 := map(
    NULL < iv_mos_src_property_adl_lseen AND iv_mos_src_property_adl_lseen < 0 => '36',
    0 <= iv_mos_src_property_adl_lseen AND iv_mos_src_property_adl_lseen < 59  => '36',
    59 <= iv_mos_src_property_adl_lseen      => '36',
              '');

t_dist_0 := t_subscore0 - 1.310834;

t_aacd_1 := map(
    (iv_full_name_ver_sources in [' '])             => '36',
    (iv_full_name_ver_sources in ['Name not Verd']) => '36',
    (iv_full_name_ver_sources in ['NonPhn Only'])   => '36',
    (iv_full_name_ver_sources in ['Phn & NonPhn'])  => '36',
    (iv_full_name_ver_sources in ['Phn Only'])      => '36',
                     '');

t_dist_1 := t_subscore1 - 0.586855;

t_aacd_2 := map(
    NULL < iv_pv001_inp_avm_autoval AND iv_pv001_inp_avm_autoval < 1         => 'PV',
    1 <= iv_pv001_inp_avm_autoval AND iv_pv001_inp_avm_autoval < 26000       => 'PV',
    26000 <= iv_pv001_inp_avm_autoval AND iv_pv001_inp_avm_autoval < 74000   => 'PV',
    74000 <= iv_pv001_inp_avm_autoval AND iv_pv001_inp_avm_autoval < 95192   => 'PV',
    95192 <= iv_pv001_inp_avm_autoval AND iv_pv001_inp_avm_autoval < 208457  => 'PV',
    208457 <= iv_pv001_inp_avm_autoval AND iv_pv001_inp_avm_autoval < 258237 => 'PV',
    258237 <= iv_pv001_inp_avm_autoval AND iv_pv001_inp_avm_autoval < 368000 => 'PV',
    368000 <= iv_pv001_inp_avm_autoval AND iv_pv001_inp_avm_autoval < 431516 => 'PV',
    431516 <= iv_pv001_inp_avm_autoval                      => 'PV',
            '');

t_dist_2 := t_subscore2 - 0.7597;

t_aacd_3 := map(
    (iv_ed001_college_ind in [' ']) => '36',
    (iv_ed001_college_ind in ['0']) => '9I',
    (iv_ed001_college_ind in ['1']) => '9I',
                      '');

t_dist_3 := t_subscore3 - 1.118732;

t_aacd_4 := map(
    (iv_po001_inp_addr_naprop in [' ']) => '36',
    (iv_po001_inp_addr_naprop in ['1']) => '9A',
    (iv_po001_inp_addr_naprop in ['0']) => '9A',
    (iv_po001_inp_addr_naprop in ['2']) => '9A',
    (iv_po001_inp_addr_naprop in ['3']) => '9A',
    (iv_po001_inp_addr_naprop in ['4']) => '9A',
         '');

t_dist_4 := t_subscore4 - 0.76458;

t_aacd_5 := map(
    NULL < iv_pv001_bst_avm_autoval AND iv_pv001_bst_avm_autoval < 1         => 'PV',
    1 <= iv_pv001_bst_avm_autoval AND iv_pv001_bst_avm_autoval < 32428       => 'PV',
    32428 <= iv_pv001_bst_avm_autoval AND iv_pv001_bst_avm_autoval < 94458   => 'PV',
    94458 <= iv_pv001_bst_avm_autoval AND iv_pv001_bst_avm_autoval < 174479  => 'PV',
    174479 <= iv_pv001_bst_avm_autoval AND iv_pv001_bst_avm_autoval < 269500 => 'PV',
    269500 <= iv_pv001_bst_avm_autoval AND iv_pv001_bst_avm_autoval < 340374 => 'PV',
    340374 <= iv_pv001_bst_avm_autoval AND iv_pv001_bst_avm_autoval < 416111 => 'PV',
    416111 <= iv_pv001_bst_avm_autoval                      => 'PV',
            '');

t_dist_5 := t_subscore5 - 0.620505;

t_aacd_6 := map(
    NULL < iv_ssns_per_addr_c6 AND iv_ssns_per_addr_c6 < 1 => '',
    1 <= iv_ssns_per_addr_c6 AND iv_ssns_per_addr_c6 < 2   => '',
    2 <= iv_ssns_per_addr_c6 AND iv_ssns_per_addr_c6 < 3   => '',
    3 <= iv_ssns_per_addr_c6              => '',
           '');

t_dist_6 := t_subscore6 - 0.096147;

t_aacd_7 := map(
    NULL < iv_iq001_inq_count12 AND iv_iq001_inq_count12 < 1 => '9Q',
    1 <= iv_iq001_inq_count12 AND iv_iq001_inq_count12 < 2   => '9Q',
    2 <= iv_iq001_inq_count12 AND iv_iq001_inq_count12 < 3   => '9Q',
    3 <= iv_iq001_inq_count12               => '9Q',
             '');

t_dist_7 := t_subscore7 - 0.064706;

t_aacd_8 := map(
    (iv_criminal_x_felony in [' '])                => '36',
    (iv_criminal_x_felony in ['0-0'])                               => '97',
    (iv_criminal_x_felony in ['0-1', '0-2', '0-3', '1-0', '1-1', '1-2', '1-3', '2-0', '2-1', '2-2', '2-3', '3-0', '3-1', '3-2', '3-3']) => '97',
                                     '');

t_dist_8 := t_subscore8 - 0.024889;

t_aacd_9 := map(
    NULL < iv_sr001_m_wp_adl_fs AND iv_sr001_m_wp_adl_fs < 0  => '9R',
    0 <= iv_sr001_m_wp_adl_fs AND iv_sr001_m_wp_adl_fs < 10   => '9R',
    10 <= iv_sr001_m_wp_adl_fs AND iv_sr001_m_wp_adl_fs < 20  => '9R',
    20 <= iv_sr001_m_wp_adl_fs AND iv_sr001_m_wp_adl_fs < 31  => '9R',
    31 <= iv_sr001_m_wp_adl_fs AND iv_sr001_m_wp_adl_fs < 105 => '9R',
    105 <= iv_sr001_m_wp_adl_fs              => '9R',
              '');

t_dist_9 := t_subscore9 - 0.337639;

t_aacd_10 := map(
    NULL < iv_paw_source_count AND iv_paw_source_count < 1 => '36',
    1 <= iv_paw_source_count              => '36',
           '');

t_dist_10 := t_subscore10 - 0.664937;

t_aacd_11 := map(
    NULL < iv_bst_addr_assessed_total_val AND iv_bst_addr_assessed_total_val < 1         => 'PV',
    1 <= iv_bst_addr_assessed_total_val AND iv_bst_addr_assessed_total_val < 17920       => 'PV',
    17920 <= iv_bst_addr_assessed_total_val AND iv_bst_addr_assessed_total_val < 201510  => 'PV',
    201510 <= iv_bst_addr_assessed_total_val AND iv_bst_addr_assessed_total_val < 221800 => 'PV',
    221800 <= iv_bst_addr_assessed_total_val AND iv_bst_addr_assessed_total_val < 354767 => 'PV',
    354767 <= iv_bst_addr_assessed_total_val           => 'PV',
                        '');

t_dist_11 := t_subscore11 - 0.298443;

t_aacd_12 := map(
    NULL < iv_prv_addr_avm_auto_val AND iv_prv_addr_avm_auto_val < 1         => 'PV',
    1 <= iv_prv_addr_avm_auto_val AND iv_prv_addr_avm_auto_val < 45654       => 'PV',
    45654 <= iv_prv_addr_avm_auto_val AND iv_prv_addr_avm_auto_val < 182914  => 'PV',
    182914 <= iv_prv_addr_avm_auto_val AND iv_prv_addr_avm_auto_val < 234500 => 'PV',
    234500 <= iv_prv_addr_avm_auto_val AND iv_prv_addr_avm_auto_val < 357000 => 'PV',
    357000 <= iv_prv_addr_avm_auto_val                      => 'PV',
            '');

t_dist_12 := t_subscore12 - 0.546524;

t_aacd_13 := map(
    NULL < iv_ms001_ssns_per_adl AND iv_ms001_ssns_per_adl < 2 => 'MS',
    2 <= iv_ms001_ssns_per_adl AND iv_ms001_ssns_per_adl < 3   => 'MS',
    3 <= iv_ms001_ssns_per_adl                => 'MS',
               '');

t_dist_13 := t_subscore13 - 0.040523;

t_aacd_14 := map(
    NULL < iv_dob_score AND iv_dob_score < 100 => '36',
    100 <= iv_dob_score AND iv_dob_score < 255 => '36',
    255 <= iv_dob_score       => '36',
                '');

t_dist_14 := t_subscore14 - 0.056518;

t_aacd_15 := map(
    NULL < iv_addr_lres_12mo_count AND iv_addr_lres_12mo_count < 0 => '9D',
    0 <= iv_addr_lres_12mo_count AND iv_addr_lres_12mo_count < 1   => '9D',
    1 <= iv_addr_lres_12mo_count                  => '9D',
                   '');

t_dist_15 := t_subscore15 - 0.071095;

t_rcvalue9i := (integer)(t_aacd_0 = '9I') * t_dist_0 +
    (integer)(t_aacd_1 = '9I') * t_dist_1 +
    (integer)(t_aacd_2 = '9I') * t_dist_2 +
    (integer)(t_aacd_3 = '9I') * t_dist_3 +
    (integer)(t_aacd_4 = '9I') * t_dist_4 +
    (integer)(t_aacd_5 = '9I') * t_dist_5 +
    (integer)(t_aacd_6 = '9I') * t_dist_6 +
    (integer)(t_aacd_7 = '9I') * t_dist_7 +
    (integer)(t_aacd_8 = '9I') * t_dist_8 +
    (integer)(t_aacd_9 = '9I') * t_dist_9 +
    (integer)(t_aacd_10 = '9I') * t_dist_10 +
    (integer)(t_aacd_11 = '9I') * t_dist_11 +
    (integer)(t_aacd_12 = '9I') * t_dist_12 +
    (integer)(t_aacd_13 = '9I') * t_dist_13 +
    (integer)(t_aacd_14 = '9I') * t_dist_14 +
    (integer)(t_aacd_15 = '9I') * t_dist_15;

t_rcvaluepv := (integer)(t_aacd_0 = 'PV') * t_dist_0 +
    (integer)(t_aacd_1 = 'PV') * t_dist_1 +
    (integer)(t_aacd_2 = 'PV') * t_dist_2 +
    (integer)(t_aacd_3 = 'PV') * t_dist_3 +
    (integer)(t_aacd_4 = 'PV') * t_dist_4 +
    (integer)(t_aacd_5 = 'PV') * t_dist_5 +
    (integer)(t_aacd_6 = 'PV') * t_dist_6 +
    (integer)(t_aacd_7 = 'PV') * t_dist_7 +
    (integer)(t_aacd_8 = 'PV') * t_dist_8 +
    (integer)(t_aacd_9 = 'PV') * t_dist_9 +
    (integer)(t_aacd_10 = 'PV') * t_dist_10 +
    (integer)(t_aacd_11 = 'PV') * t_dist_11 +
    (integer)(t_aacd_12 = 'PV') * t_dist_12 +
    (integer)(t_aacd_13 = 'PV') * t_dist_13 +
    (integer)(t_aacd_14 = 'PV') * t_dist_14 +
    (integer)(t_aacd_15 = 'PV') * t_dist_15;

t_rcvalue9a := (integer)(t_aacd_0 = '9A') * t_dist_0 +
    (integer)(t_aacd_1 = '9A') * t_dist_1 +
    (integer)(t_aacd_2 = '9A') * t_dist_2 +
    (integer)(t_aacd_3 = '9A') * t_dist_3 +
    (integer)(t_aacd_4 = '9A') * t_dist_4 +
    (integer)(t_aacd_5 = '9A') * t_dist_5 +
    (integer)(t_aacd_6 = '9A') * t_dist_6 +
    (integer)(t_aacd_7 = '9A') * t_dist_7 +
    (integer)(t_aacd_8 = '9A') * t_dist_8 +
    (integer)(t_aacd_9 = '9A') * t_dist_9 +
    (integer)(t_aacd_10 = '9A') * t_dist_10 +
    (integer)(t_aacd_11 = '9A') * t_dist_11 +
    (integer)(t_aacd_12 = '9A') * t_dist_12 +
    (integer)(t_aacd_13 = '9A') * t_dist_13 +
    (integer)(t_aacd_14 = '9A') * t_dist_14 +
    (integer)(t_aacd_15 = '9A') * t_dist_15;

t_rcvalue36 := (integer)(t_aacd_0 = '36') * t_dist_0 +
    (integer)(t_aacd_1 = '36') * t_dist_1 +
    (integer)(t_aacd_2 = '36') * t_dist_2 +
    (integer)(t_aacd_3 = '36') * t_dist_3 +
    (integer)(t_aacd_4 = '36') * t_dist_4 +
    (integer)(t_aacd_5 = '36') * t_dist_5 +
    (integer)(t_aacd_6 = '36') * t_dist_6 +
    (integer)(t_aacd_7 = '36') * t_dist_7 +
    (integer)(t_aacd_8 = '36') * t_dist_8 +
    (integer)(t_aacd_9 = '36') * t_dist_9 +
    (integer)(t_aacd_10 = '36') * t_dist_10 +
    (integer)(t_aacd_11 = '36') * t_dist_11 +
    (integer)(t_aacd_12 = '36') * t_dist_12 +
    (integer)(t_aacd_13 = '36') * t_dist_13 +
    (integer)(t_aacd_14 = '36') * t_dist_14 +
    (integer)(t_aacd_15 = '36') * t_dist_15;

t_rcvalue9d := (integer)(t_aacd_0 = '9D') * t_dist_0 +
    (integer)(t_aacd_1 = '9D') * t_dist_1 +
    (integer)(t_aacd_2 = '9D') * t_dist_2 +
    (integer)(t_aacd_3 = '9D') * t_dist_3 +
    (integer)(t_aacd_4 = '9D') * t_dist_4 +
    (integer)(t_aacd_5 = '9D') * t_dist_5 +
    (integer)(t_aacd_6 = '9D') * t_dist_6 +
    (integer)(t_aacd_7 = '9D') * t_dist_7 +
    (integer)(t_aacd_8 = '9D') * t_dist_8 +
    (integer)(t_aacd_9 = '9D') * t_dist_9 +
    (integer)(t_aacd_10 = '9D') * t_dist_10 +
    (integer)(t_aacd_11 = '9D') * t_dist_11 +
    (integer)(t_aacd_12 = '9D') * t_dist_12 +
    (integer)(t_aacd_13 = '9D') * t_dist_13 +
    (integer)(t_aacd_14 = '9D') * t_dist_14 +
    (integer)(t_aacd_15 = '9D') * t_dist_15;

t_rcvaluems := (integer)(t_aacd_0 = 'MS') * t_dist_0 +
    (integer)(t_aacd_1 = 'MS') * t_dist_1 +
    (integer)(t_aacd_2 = 'MS') * t_dist_2 +
    (integer)(t_aacd_3 = 'MS') * t_dist_3 +
    (integer)(t_aacd_4 = 'MS') * t_dist_4 +
    (integer)(t_aacd_5 = 'MS') * t_dist_5 +
    (integer)(t_aacd_6 = 'MS') * t_dist_6 +
    (integer)(t_aacd_7 = 'MS') * t_dist_7 +
    (integer)(t_aacd_8 = 'MS') * t_dist_8 +
    (integer)(t_aacd_9 = 'MS') * t_dist_9 +
    (integer)(t_aacd_10 = 'MS') * t_dist_10 +
    (integer)(t_aacd_11 = 'MS') * t_dist_11 +
    (integer)(t_aacd_12 = 'MS') * t_dist_12 +
    (integer)(t_aacd_13 = 'MS') * t_dist_13 +
    (integer)(t_aacd_14 = 'MS') * t_dist_14 +
    (integer)(t_aacd_15 = 'MS') * t_dist_15;

t_rcvalue9q := (integer)(t_aacd_0 = '9Q') * t_dist_0 +
    (integer)(t_aacd_1 = '9Q') * t_dist_1 +
    (integer)(t_aacd_2 = '9Q') * t_dist_2 +
    (integer)(t_aacd_3 = '9Q') * t_dist_3 +
    (integer)(t_aacd_4 = '9Q') * t_dist_4 +
    (integer)(t_aacd_5 = '9Q') * t_dist_5 +
    (integer)(t_aacd_6 = '9Q') * t_dist_6 +
    (integer)(t_aacd_7 = '9Q') * t_dist_7 +
    (integer)(t_aacd_8 = '9Q') * t_dist_8 +
    (integer)(t_aacd_9 = '9Q') * t_dist_9 +
    (integer)(t_aacd_10 = '9Q') * t_dist_10 +
    (integer)(t_aacd_11 = '9Q') * t_dist_11 +
    (integer)(t_aacd_12 = '9Q') * t_dist_12 +
    (integer)(t_aacd_13 = '9Q') * t_dist_13 +
    (integer)(t_aacd_14 = '9Q') * t_dist_14 +
    (integer)(t_aacd_15 = '9Q') * t_dist_15;

t_rcvalue9r := (integer)(t_aacd_0 = '9R') * t_dist_0 +
    (integer)(t_aacd_1 = '9R') * t_dist_1 +
    (integer)(t_aacd_2 = '9R') * t_dist_2 +
    (integer)(t_aacd_3 = '9R') * t_dist_3 +
    (integer)(t_aacd_4 = '9R') * t_dist_4 +
    (integer)(t_aacd_5 = '9R') * t_dist_5 +
    (integer)(t_aacd_6 = '9R') * t_dist_6 +
    (integer)(t_aacd_7 = '9R') * t_dist_7 +
    (integer)(t_aacd_8 = '9R') * t_dist_8 +
    (integer)(t_aacd_9 = '9R') * t_dist_9 +
    (integer)(t_aacd_10 = '9R') * t_dist_10 +
    (integer)(t_aacd_11 = '9R') * t_dist_11 +
    (integer)(t_aacd_12 = '9R') * t_dist_12 +
    (integer)(t_aacd_13 = '9R') * t_dist_13 +
    (integer)(t_aacd_14 = '9R') * t_dist_14 +
    (integer)(t_aacd_15 = '9R') * t_dist_15;

t_rcvalue97 := (integer)(t_aacd_0 = '97') * t_dist_0 +
    (integer)(t_aacd_1 = '97') * t_dist_1 +
    (integer)(t_aacd_2 = '97') * t_dist_2 +
    (integer)(t_aacd_3 = '97') * t_dist_3 +
    (integer)(t_aacd_4 = '97') * t_dist_4 +
    (integer)(t_aacd_5 = '97') * t_dist_5 +
    (integer)(t_aacd_6 = '97') * t_dist_6 +
    (integer)(t_aacd_7 = '97') * t_dist_7 +
    (integer)(t_aacd_8 = '97') * t_dist_8 +
    (integer)(t_aacd_9 = '97') * t_dist_9 +
    (integer)(t_aacd_10 = '97') * t_dist_10 +
    (integer)(t_aacd_11 = '97') * t_dist_11 +
    (integer)(t_aacd_12 = '97') * t_dist_12 +
    (integer)(t_aacd_13 = '97') * t_dist_13 +
    (integer)(t_aacd_14 = '97') * t_dist_14 +
    (integer)(t_aacd_15 = '97') * t_dist_15;

base := 700;

odds := (1 - 0.1530) / 0.1530;

point := 40;

ssn_deceased := rc_decsflag = '1' or (Integer)indexw(StringLib.StringToUpperCase(trim(ver_sources, ALL)), 'DS', ',') > 0;

iv_riskview_222s := riskview.constants.noscore(le.iid.nas_summary,le.iid.nap_summary, le.address_verification.input_address_information.naprop, le.truedid);

rvt1605_1_1 := map(
    ssn_deceased     => 200,
    iv_riskview_222s => 222,
       min(if(max(round(point * (t_lnoddsscore - ln(odds)) / ln(2) + base), 501) = NULL, -NULL, max(round(point * (t_lnoddsscore - ln(odds)) / ln(2) + base), 501)), 900));


//*************************************************************************************//
// I have no idea how the reason code logic gets implemented in ECL, so everything below 
// probably needs to get changed or replaced.  The methodology for creating the reason codes is
// very similar to the logic used by the RiskView 4.0 scores, so you might want to consult
// that model code for guidance on implementing reason codes. 
//*************************************************************************************//

ds_layout := {STRING rc, REAL value};


 
//*************************************************************************************//
rc_dataset_t := DATASET([
    {'9I', t_rcvalue9I},
    {'PV', t_rcvaluePV},
    {'9A', t_rcvalue9A},
    {'36', t_rcvalue36},
    {'9D', t_rcvalue9D},
    {'MS', t_rcvalueMS},
    {'9Q', t_rcvalue9Q},
    {'9R', t_rcvalue9R},
    {'97', t_rcvalue97}
    ], ds_layout)(value < 0);

//*************************************************************************************//
// IMPORTANT NOTE:  Select ONLY reason codes with an RCValue < 0.  I'll leave the 
//   implementation of this to the Engineer
//*************************************************************************************//
rc_dataset_t_sorted := sort(rc_dataset_t, rc_dataset_t.value);

t_rc1 := rc_dataset_t_sorted[1].rc;
t_rc2 := rc_dataset_t_sorted[2].rc;
t_rc3 := rc_dataset_t_sorted[3].rc;
t_rc4 := rc_dataset_t_sorted[4].rc;

t_vl1 := rc_dataset_t_sorted[1].value;
t_vl2 := rc_dataset_t_sorted[2].value;
t_vl3 := rc_dataset_t_sorted[3].value;
t_vl4 := rc_dataset_t_sorted[4].value;
//*************************************************************************************//

rc1_2 := t_RC1;

rc2_2 := t_RC2;

rc3_2 := t_RC3;

rc4_2 := t_RC4;

_rc_inq := if(iv_iq001_inq_count12 > 0, '9Q', '');

rc5_c54 := map(
    trim((string)rc1_2, LEFT, RIGHT) = '' => '',
    trim((string)rc2_2, LEFT, RIGHT) = '' => '',
    trim((string)rc3_2, LEFT, RIGHT) = '' => '',
    trim((string)rc4_2, LEFT, RIGHT) = '' => '',
           _rc_inq);

// rc2_c54 := map(
    // trim((string)rc1_2, LEFT, RIGHT) = '' => '',
    // trim((string)rc2_2, LEFT, RIGHT) = '' => _rc_inq,
    // trim((string)rc3_2, LEFT, RIGHT) = '' => '',
    // trim((string)rc4_2, LEFT, RIGHT) = '' => '',
           // '');

// rc4_c54 := map(
    // trim((string)rc1_2, LEFT, RIGHT) = '' => '',
    // trim((string)rc2_2, LEFT, RIGHT) = '' => '',
    // trim((string)rc3_2, LEFT, RIGHT) = '' => '',
    // trim((string)rc4_2, LEFT, RIGHT) = '' => _rc_inq,
           // '');

// rc3_c54 := map(
    // trim((string)rc1_2, LEFT, RIGHT) = '' => '',
    // trim((string)rc2_2, LEFT, RIGHT) = '' => '',
    // trim((string)rc3_2, LEFT, RIGHT) = '' => _rc_inq,
    // trim((string)rc4_2, LEFT, RIGHT) = '' => '',
           // '');

// rc1_c54 := map(
    // trim((string)rc1_2, LEFT, RIGHT) = '' => _rc_inq,
    // trim((string)rc2_2, LEFT, RIGHT) = '' => '',
    // trim((string)rc3_2, LEFT, RIGHT) = '' => '',
    // trim((string)rc4_2, LEFT, RIGHT) = '' => '',
           // '');

rc5_1 := if(not((rc1_2 in ['9Q'])) and not((rc2_2 in ['9Q'])) and not((rc3_2 in ['9Q'])) and not((rc4_2 in ['9Q'])), rc5_c54, '');

// rc2_1 := if(not((rc1_2 in ['9Q'])) and not((rc2_2 in ['9Q'])) and not((rc3_2 in ['9Q'])) and not((rc4_2 in ['9Q'])), rc2_c54, rc2_2);

// rc3_1 := if(not((rc1_2 in ['9Q'])) and not((rc2_2 in ['9Q'])) and not((rc3_2 in ['9Q'])) and not((rc4_2 in ['9Q'])), rc3_c54, rc3_2);

// rc1_1 := if(not((rc1_2 in ['9Q'])) and not((rc2_2 in ['9Q'])) and not((rc3_2 in ['9Q'])) and not((rc4_2 in ['9Q'])), rc1_c54, rc1_2);

// rc4_1 := if(not((rc1_2 in ['9Q'])) and not((rc2_2 in ['9Q'])) and not((rc3_2 in ['9Q'])) and not((rc4_2 in ['9Q'])), rc4_c54, rc4_2);

rc2 := map(
    rvt1605_1_1 = 200 => '',
    rvt1605_1_1 = 222 => '',
        rc2_2);

rc5 := map(
    rvt1605_1_1 = 200 => '',
    rvt1605_1_1 = 222 => '',
        rc5_1);

rc1 := map(
    rvt1605_1_1 = 200 => '02',
    rvt1605_1_1 = 222 => '9X',
        rc1_2);

rc3 := map(
    rvt1605_1_1 = 200 => '',
    rvt1605_1_1 = 222 => '',
        rc3_2);

rc4 := map(
    rvt1605_1_1 = 200 => '',
    rvt1605_1_1 = 222 => '',
        rc4_2);

//*************************************************************************************//
	//     RiskView Version 4.1 Reason Code Overrides 
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
													rvt1605_1_1 = 200 =>	DATASET([{'02'}], HRILayout),
													rvt1605_1_1 = 222 =>	DATASET([{'9X'}], HRILayout),
													rvt1605_1_1 = 900 =>	DATASET([{' '}], HRILayout),
													rvt1605_1_1 BETWEEN 501 AND 720 AND reasons[1].HRI NOT IN ['', '36'] AND reasons[2].HRI = '' => DATASET([{reasons[1].HRI}, {'36'}], HRILayout),
													rvt1605_1_1 BETWEEN 501 AND 720 AND reasons[1].HRI != '9E' AND reasons[2].HRI = ''					 => DATASET([{reasons[1].HRI}, {'9E'}], HRILayout),
																								DATASET([], HRILayout)
													);
	// If we have corrections reason codes, use them, otherwise if we have score overrides use them, else use the normal reason codes
	reasonsFinalTemp := MAP(ut.Exists2(riCorrectionsTemp(trim(hri)<>''))	=> riCorrectionsTemp,
													ut.Exists2(reasonsOverrides(trim(hri)<>''))	=> reasonsOverrides, 
																													 reasons(trim(HRI) <> '')) (trim(HRI) <> '');
																													 
																													 
	zeros := DATASET([{'00'}, {'00'}, {'00'}, {'00'}, {'00'}], HRILayout);
	
	reasonCodes := CHOOSEN(reasonsFinalTemp & zeros, 5); // Keep up to 5 reason codes
	// reasonCodes := CHOOSEN(reasons, 5); // Keep up to 5 reason codes


//*************************************************************************************//
//                   End RiskView Version 5 Reason Code Overrides
//*************************************************************************************//

	#if(MODEL_DEBUG)
		/* Model Input Variables */
	 self.seq             := le.seq;
   self.sysdate         := sysdate;
   self.wp_adl_wp_fseen_pos              := wp_adl_wp_fseen_pos;
   self.wp_adl_fseen_wp                  := wp_adl_fseen_wp;
   self._wp_adl_fseen_wp                 := _wp_adl_fseen_wp;
   self._src_wp_adl_fseen                := _src_wp_adl_fseen;
   self.iv_sr001_m_wp_adl_fs             := iv_sr001_m_wp_adl_fs;
   self.iv_ms001_ssns_per_adl            := iv_ms001_ssns_per_adl;
   self.iv_pv001_inp_avm_autoval         := iv_pv001_inp_avm_autoval;
   self.iv_pv001_bst_avm_autoval         := iv_pv001_bst_avm_autoval;
   self.iv_po001_inp_addr_naprop         := iv_po001_inp_addr_naprop;
   self.iv_ed001_college_ind             := iv_ed001_college_ind;
   self.iv_iq001_inq_count12             := iv_iq001_inq_count12;
   self.prop_adl_p_lseen_pos             := prop_adl_p_lseen_pos;
   self.prop_adl_lseen_p                 := prop_adl_lseen_p;
   self._prop_adl_lseen_p                := _prop_adl_lseen_p;
   self._src_prop_adl_lseen              := _src_prop_adl_lseen;
   self.iv_mos_src_property_adl_lseen    := iv_mos_src_property_adl_lseen;
   self.iv_full_name_ver_sources         := iv_full_name_ver_sources;
   self.iv_dob_score    := iv_dob_score;
   self.iv_bst_addr_assessed_total_val   := iv_bst_addr_assessed_total_val;
   self.iv_prv_addr_avm_auto_val         := iv_prv_addr_avm_auto_val;
   self.iv_addr_lres_12mo_count          := iv_addr_lres_12mo_count;
   self.iv_ssns_per_addr_c6              := iv_ssns_per_addr_c6;
   self.iv_paw_source_count              := iv_paw_source_count;
   self.iv_criminal_x_felony             := iv_criminal_x_felony;
   self.t_subscore0     := t_subscore0;
   self.t_subscore1     := t_subscore1;
   self.t_subscore2     := t_subscore2;
   self.t_subscore3     := t_subscore3;
   self.t_subscore4     := t_subscore4;
   self.t_subscore5     := t_subscore5;
   self.t_subscore6     := t_subscore6;
   self.t_subscore7     := t_subscore7;
   self.t_subscore8     := t_subscore8;
   self.t_subscore9     := t_subscore9;
   self.t_subscore10    := t_subscore10;
   self.t_subscore11    := t_subscore11;
   self.t_subscore12    := t_subscore12;
   self.t_subscore13    := t_subscore13;
   self.t_subscore14    := t_subscore14;
   self.t_subscore15    := t_subscore15;
   self.t_rawscore      := t_rawscore;
   self.t_lnoddsscore   := t_lnoddsscore;
   self.t_probscore     := t_probscore;
   self.t_aacd_0        := t_aacd_0;
   self.t_dist_0        := t_dist_0;
   self.t_aacd_1        := t_aacd_1;
   self.t_dist_1        := t_dist_1;
   self.t_aacd_2        := t_aacd_2;
   self.t_dist_2        := t_dist_2;
   self.t_aacd_3        := t_aacd_3;
   self.t_dist_3        := t_dist_3;
   self.t_aacd_4        := t_aacd_4;
   self.t_dist_4        := t_dist_4;
   self.t_aacd_5        := t_aacd_5;
   self.t_dist_5        := t_dist_5;
   self.t_aacd_6        := t_aacd_6;
   self.t_dist_6        := t_dist_6;
   self.t_aacd_7        := t_aacd_7;
   self.t_dist_7        := t_dist_7;
   self.t_aacd_8        := t_aacd_8;
   self.t_dist_8        := t_dist_8;
   self.t_aacd_9        := t_aacd_9;
   self.t_dist_9        := t_dist_9;
   self.t_aacd_10       := t_aacd_10;
   self.t_dist_10       := t_dist_10;
   self.t_aacd_11       := t_aacd_11;
   self.t_dist_11       := t_dist_11;
   self.t_aacd_12       := t_aacd_12;
   self.t_dist_12       := t_dist_12;
   self.t_aacd_13       := t_aacd_13;
   self.t_dist_13       := t_dist_13;
   self.t_aacd_14       := t_aacd_14;
   self.t_dist_14       := t_dist_14;
   self.t_aacd_15       := t_aacd_15;
   self.t_dist_15       := t_dist_15;
   self.t_rcvalue9i     := t_rcvalue9i;
   self.t_rcvaluepv     := t_rcvaluepv;
   self.t_rcvalue9a     := t_rcvalue9a;
   self.t_rcvalue36     := t_rcvalue36;
   self.t_rcvalue9d     := t_rcvalue9d;
   self.t_rcvaluems     := t_rcvaluems;
   self.t_rcvalue9q     := t_rcvalue9q;
   self.t_rcvalue9r     := t_rcvalue9r;
   self.t_rcvalue97     := t_rcvalue97;
   self.base            := base;
   self.odds            := odds;
   self.point           := point;
   self.ssn_deceased    := ssn_deceased;
   self.iv_riskview_222s                 := iv_riskview_222s;
   self.rvt1605_1_1     := rvt1605_1_1;
   self.t_rc1           := t_rc1;
   self.t_rc2           := t_rc2;
   self.t_rc3           := t_rc3;
   self.t_rc4           := t_rc4;
   self.t_vl1           := t_vl1;
   self.t_vl2           := t_vl2;
   self.t_vl3           := t_vl3;
   self.t_vl4           := t_vl4;
   self._rc_inq         := _rc_inq;
   self.rc4             := rc4;
   self.rc3             := rc3;
   self.rc2             := rc2;
   self.rc1             := rc1;
   self.rc5             := rc5;


		SELF.clam := le;
	#else
		SELF.ri := PROJECT(reasonCodes, TRANSFORM(Risk_Indicators.Layout_Desc,
																							SELF.hri := IF(LEFT.hri = '', '00', LEFT.hri),
																							SELF.desc := Risk_Indicators.getHRIDesc(LEFT.hri)
																					));
		SELF.score := MAP(reasonCodes[1].HRI IN ['91','92','93','94'] => (STRING3)((INTEGER)reasonCodes[1].HRI + 10),
											reasonCodes[1].HRI = '35'										=> '100',
																																		 (STRING)rvt1605_1_1);

		SELF.seq := le.seq;
	#end
	END;

	model := PROJECT(clam, doModel(LEFT));

	RETURN(model);
END;

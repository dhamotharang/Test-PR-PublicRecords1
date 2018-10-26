IMPORT ut, Std, RiskWise, RiskWiseFCRA, Risk_Indicators, riskview;

EXPORT RVG1702_1_0 (GROUPED DATASET(Risk_Indicators.Layout_Boca_Shell) clam) := FUNCTION

	MODEL_DEBUG := False;

	#if(MODEL_DEBUG)
	Layout_Debug := RECORD
	
	/* Model Intermediate Variables */
	//STRING NULL;
	 Integer seq;
   Integer	 sysdate;
   String	 rv_s65_ssn_prior_dob;
   String	 rv_l71_add_business;
   Integer	 rv_d33_eviction_count;
   Integer	 _header_first_seen;
   Integer	 rv_c10_m_hdr_fs;
   Integer	 _in_dob;
   Real	 yr_in_dob;
   Integer	 yr_in_dob_int;
   Integer	 rv_comb_age;
   Integer rv_c14_addrs_10yr;
   String	 rv_a41_a42_prop_owner_history;
   Integer	 rv_i60_inq_auto_count12;
   Integer	 rv_i60_inq_hiriskcred_count12;
   Boolean	 _nap_ver;
   Boolean	 _inf_ver;
   String	 iv_phn_addr_verified;
   Integer	 rv_c12_inp_addr_source_count;
   Integer	 custom_derog_index;
   Integer	 custom_1mth_inq;
   Integer	 cust_pii_variations;
   Real	 k_subscore0;
   Real	 k_subscore1;
   Real	 k_subscore2;
   Real	 k_subscore3;
   Real	 k_subscore4;
   Real	 k_subscore5;
   Real	 k_subscore6;
   Real	 k_subscore7;
   Real	 k_subscore8;
   Real	 k_subscore9;
   Real	 k_subscore10;
   Real	 k_subscore11;
   Real	 k_subscore12;
   Real	 k_subscore13;
   Real	 k_rawscore;
   Real	 k_predprob;
   String	 k_aacd_0;
   Real	 k_dist_0;
   String	 k_aacd_1;
   Real	 k_dist_1;
   String	 k_aacd_2;
   Real	 k_dist_2;
   String	 k_aacd_3;
   Real	 k_dist_3;
   String	 k_aacd_4;
   Real	 k_dist_4;
   String	 k_aacd_5;
   Real	 k_dist_5;
   String	 k_aacd_6;
   Real	 k_dist_6;
   String	 k_aacd_7;
   Real	 k_dist_7;
   String	 k_aacd_8;
   Real	 k_dist_8;
   String	 k_aacd_9;
   Real	 k_dist_9;
   String	 k_aacd_10;
   Real	 k_dist_10;
   String	 k_aacd_11;
   Real	 k_dist_11;
   String	 k_aacd_12;
   Real	 k_dist_12;
   String	 k_aacd_13;
   Real	 k_dist_13;
   Real	 k_rcvalues65;
   Real	 k_rcvalued34;
   Real	 k_rcvaluel71;
   Real	 k_rcvalued32;
   Real	 k_rcvalued33;
   Real	 k_rcvalued30;
   Real	 k_rcvalued31;
   Real	 k_rcvaluei60;
   Real	 k_rcvaluea42;
   Real	 k_rcvaluei62;
   Real	 k_rcvaluea41;
   Real	 k_rcvaluec12;
   Real	 k_rcvaluec10;
   Real	 k_rcvaluec14;
   Integer	 base;
   Integer	 pdo;
   Real	 odds;
   Boolean	 iv_rv5_deceased;
   String	 iv_rv5_unscorable;
   Integer	 rvg1702_1_0;
   String	 k_rc1;
   String	 k_rc2;
   String	 k_rc3;
   String	 k_rc4;
   Real	 k_vl1;
   Real	 k_vl2;
   Real	 k_vl3;
   Real	 k_vl4;
   String	 _rc_inq;
   String	 rc1;
   String	 rc2;
   String	 rc3;
   String	 rc4;
   String	 rc5;

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
	in_dob                           := le.shell_input.dob;
	nas_summary                      := le.iid.nas_summary;
	nap_summary                      := le.iid.nap_summary;
	rc_ssndod                        := le.ssn_verification.validation.deceasedDate;
	rc_decsflag                      := le.iid.decsflag;
	rc_ssndobflag                    := le.iid.socsdobflag;
	rc_pwssndobflag                  := le.iid.pwsocsdobflag;
	ver_sources                      := le.header_summary.ver_sources;
	ssnlength                        := le.input_validation.ssn_length;
	dobpop                           := le.input_validation.dateofbirth;
	add_input_advo_res_or_bus        := le.advo_input_addr.Residential_or_Business_Ind;
	add_input_source_count           := le.address_verification.input_address_information.source_count;
	add_input_naprop                 := le.address_verification.input_address_information.naprop;
	add_input_pop                    := le.addrPop;
	property_owned_total             := le.address_verification.owned.property_total;
	add_curr_naprop                  := le.address_verification.address_history_1.naprop;
	add_curr_pop                     := le.addrPop2;
	add_prev_naprop                  := le.address_verification.address_history_2.naprop;
	addrs_10yr                       := le.other_address_info.addrs_last_10years;
	addrs_prison_history             := le.other_address_info.isprison;
	header_first_seen                := le.ssn_verification.header_first_seen;
	inq_auto_count01                 := le.acc_logs.auto.count01;
	inq_auto_count12                 := le.acc_logs.auto.count12;
	inq_banking_count01              := le.acc_logs.banking.count01;
	inq_communications_count01       := le.acc_logs.communications.count01;
	inq_highriskcredit_count01       := le.acc_logs.highriskcredit.count01;
	inq_highriskcredit_count12       := le.acc_logs.highriskcredit.count12;
	inq_retail_count01               := le.acc_logs.retail.count01;
	inq_ssnsperadl                   := le.acc_logs.inquiryssnsperadl;
	inq_addrsperadl                  := le.acc_logs.inquiryaddrsperadl;
	inq_fnamesperadl                 := le.acc_logs.inquiryfnamesperadl;
	inq_phonesperadl                 := le.acc_logs.inquiryphonesperadl;
	inq_dobsperadl                   := le.acc_logs.inquirydobsperadl;
	infutor_nap                      := le.infutor_phone.infutor_nap;
	attr_bankruptcy_count30          := le.bjl.bk_count30;
	attr_bankruptcy_count90          := le.bjl.bk_count90;
	attr_eviction_count              := le.bjl.eviction_count;
	liens_recent_unreleased_count    := le.bjl.liens_recent_unreleased_count;
	liens_historical_unreleased_ct   := le.bjl.liens_historical_unreleased_count;
	liens_recent_released_count      := le.bjl.liens_recent_released_count;
	liens_historical_released_count  := le.bjl.liens_historical_released_count;
	criminal_count                   := le.bjl.criminal_count;
	felony_count                     := le.bjl.felony_count;
	inferred_age                     := le.inferred_age;
	
	/* ***********************************************************
	 *                    Generated ECL                          *
	 ************************************************************* */


NULL := -999999999;


BOOLEAN indexw(string source, string target, string delim) :=
	(source = target) OR
	(StringLib.StringFind(source, delim + target + delim, 1) > 0) OR
	(source[1..length(target)+1] = target + delim) OR
	(StringLib.StringReverse(source)[1..length(target)+1] = StringLib.StringReverse(target) + delim);

sysdate := common.sas_date(if(le.historydate=999999, (string8)Std.Date.Today(), (string6)le.historydate+'01'));

rv_s65_ssn_prior_dob := map(
    not(ssnlength > '0' and dobpop)            => ' ',
    rc_ssndobflag = '1' or rc_pwssndobflag = '1' => '1',
    rc_ssndobflag = '0' or rc_pwssndobflag = '0' => '0',
                                                ' ');

rv_l71_add_business := map(
    not(add_input_pop)                                                       => ' ',
    (trim(trim(add_input_advo_res_or_bus, LEFT), LEFT, RIGHT) in ['B', 'D']) => '1',
                                                                                '0');

rv_d33_eviction_count := if(not(truedid), NULL, min(if(attr_eviction_count = NULL, -NULL, attr_eviction_count), 999));

_header_first_seen := common.sas_date((string)(header_first_seen));

rv_c10_m_hdr_fs := map(
    not(truedid)              => NULL,
    _header_first_seen = NULL => -1,
                                 min(if(if ((sysdate - _header_first_seen) / (365.25 / 12) >= 0, truncate((sysdate - _header_first_seen) / (365.25 / 12)), roundup((sysdate - _header_first_seen) / (365.25 / 12))) = NULL, -NULL, if ((sysdate - _header_first_seen) / (365.25 / 12) >= 0, truncate((sysdate - _header_first_seen) / (365.25 / 12)), roundup((sysdate - _header_first_seen) / (365.25 / 12)))), 999));

_in_dob := common.sas_date((string)(in_dob));

yr_in_dob := if(_in_dob = NULL, -1, (sysdate - _in_dob) / 365.25);

yr_in_dob_int := if (yr_in_dob >= 0, roundup(yr_in_dob), truncate(yr_in_dob));

rv_comb_age := map(
    yr_in_dob_int > 0            => yr_in_dob_int,
    inferred_age > 0 and truedid => inferred_age,
                                    NULL);

rv_c14_addrs_10yr := map(
    not(truedid)     => NULL,
    (Integer)add_curr_pop = 0 => -1,
                        min(if(addrs_10yr = NULL, -NULL, addrs_10yr), 999));

rv_a41_a42_prop_owner_history := map(
    not(truedid)                                                                     => '',
    add_input_naprop = 4 or add_curr_naprop = 4 or property_owned_total > 0          => 'CURRENT',
    add_prev_naprop = 4 or Models.Common.findw_cpp(ver_sources, 'P' , ', ', 'E') > 0 => 'HISTORICAL',
                                                                                        'NEVER');

rv_i60_inq_auto_count12 := if(not(truedid), NULL, min(if(inq_auto_count12 = NULL, -NULL, inq_auto_count12), 999));

rv_i60_inq_hiriskcred_count12 := if(not(truedid), NULL, min(if(inq_highRiskCredit_count12 = NULL, -NULL, inq_highRiskCredit_count12), 999));

_nap_ver := (nap_summary in [6, 10, 11, 12]);

_inf_ver := (infutor_nap in [6, 10, 11, 12]);

iv_phn_addr_verified := map(
    not(_nap_ver) and not(_inf_ver) => '0 NONE VERD',
    not(_nap_ver) and _inf_ver      => '1 INF ONLY ',
    _nap_ver and not(_inf_ver)      => '2 NAP ONLY ',
                                       '3 BOTH VERD');

rv_c12_inp_addr_source_count := if(not(add_input_pop and truedid), NULL, min(if(add_input_source_count = NULL, -NULL, add_input_source_count), 999));

custom_derog_index := map(
    not(truedid)                                                              => NULL,
    criminal_count >= 1 or (Integer)addrs_prison_history = 1                           => 3,
    felony_count >= 1                                                         => 3,
    attr_bankruptcy_count30 >= 1 or attr_bankruptcy_count90 >= 1              => 2,
    liens_recent_unreleased_count >= 1 or liens_historical_unreleased_ct >= 1 => 1,
    liens_recent_released_count >= 1 or liens_historical_released_count >= 1  => 1,
                                                                                 0);

custom_1mth_inq := map(
    not(truedid)                    => NULL,
    inq_auto_count01 >= 1           => 1,
    inq_banking_count01 >= 1        => 1,
    inq_highRiskCredit_count01 >= 1 => 1,
    inq_retail_count01 >= 1         => 1,
    inq_communications_count01 >= 1 => 1,
                                       0);

cust_pii_variations := map(
    not(truedid)                                    => NULL,
    inq_ssnsperadl >= 3                             => 3,
    inq_addrsperadl >= 3                            => 3,
    inq_phonesperadl >= 4                           => 3,
    inq_dobsperadl >= 3                             => 2,
    2 <= inq_phonesperadl AND inq_phonesperadl <= 3 => 2,
    inq_ssnsperadl = 2                              => 1,
    inq_fnamesperadl >= 2                           => 1,
                                                       0);

k_subscore0 := map(
    NULL < rv_i60_inq_hiriskcred_count12 AND rv_i60_inq_hiriskcred_count12 < 1 => -0.035548,
    1 <= rv_i60_inq_hiriskcred_count12 AND rv_i60_inq_hiriskcred_count12 < 2   => 0.038806,
    2 <= rv_i60_inq_hiriskcred_count12 AND rv_i60_inq_hiriskcred_count12 < 5   => 0.049774,
    5 <= rv_i60_inq_hiriskcred_count12                                         => 0.055317,
                                                                                  0);

k_subscore1 := map(
    NULL < rv_d33_eviction_count AND rv_d33_eviction_count < 1 => -0.005857,
    1 <= rv_d33_eviction_count                                 => 0.086163,
                                                                  0);

k_subscore2 := map(
    NULL < rv_c12_inp_addr_source_count AND rv_c12_inp_addr_source_count < 1 => 0.026634,
    1 <= rv_c12_inp_addr_source_count AND rv_c12_inp_addr_source_count < 2   => 0.011251,
    2 <= rv_c12_inp_addr_source_count AND rv_c12_inp_addr_source_count < 3   => -0.015151,
    3 <= rv_c12_inp_addr_source_count                                        => -0.026045,
                                                                                0);

k_subscore3 := map(
    NULL < rv_c14_addrs_10yr AND rv_c14_addrs_10yr < 1 => -0.01485,
    1 <= rv_c14_addrs_10yr AND rv_c14_addrs_10yr < 2   => -0.014394,
    2 <= rv_c14_addrs_10yr AND rv_c14_addrs_10yr < 3   => -0.00065,
    3 <= rv_c14_addrs_10yr AND rv_c14_addrs_10yr < 5   => 0.008578,
    5 <= rv_c14_addrs_10yr                             => 0.043026,
                                                          0);

k_subscore4 := map(
    (custom_derog_index in [0])    => -0.005897,
    (custom_derog_index in [1])    => 0.029211,
    (custom_derog_index in [2, 3]) => 0.120053,
                                      0);

k_subscore5 := map(
    NULL < rv_c10_m_hdr_fs AND rv_c10_m_hdr_fs < 0   => 0,
    0 <= rv_c10_m_hdr_fs AND rv_c10_m_hdr_fs < 57    => 0.02385,
    57 <= rv_c10_m_hdr_fs AND rv_c10_m_hdr_fs < 115  => 0.023423,
    115 <= rv_c10_m_hdr_fs AND rv_c10_m_hdr_fs < 174 => 0.002711,
    174 <= rv_c10_m_hdr_fs AND rv_c10_m_hdr_fs < 233 => 0.001565,
    233 <= rv_c10_m_hdr_fs AND rv_c10_m_hdr_fs < 355 => -0.004624,
    355 <= rv_c10_m_hdr_fs                           => -0.022004,
                                                        0);

k_subscore6 := map(
    (iv_phn_addr_verified in ['0 NONE VERD'])              => 0.008653,
    (iv_phn_addr_verified in ['1 INF ONLY', '2 NAP ONLY']) => -0.019378,
    (iv_phn_addr_verified in ['3 BOTH VERD'])              => -0.036309,
                                                              0);

k_subscore7 := map(
    (rv_a41_a42_prop_owner_history in [' '])          => 0.024306,
    (rv_a41_a42_prop_owner_history in ['CURRENT'])    => -0.020023,
    (rv_a41_a42_prop_owner_history in ['HISTORICAL']) => -0.019441,
    (rv_a41_a42_prop_owner_history in ['NEVER'])      => 0.00892,
                                                         0);

k_subscore8 := map(
    NULL < rv_comb_age AND rv_comb_age < 35 => 0.017716,
    35 <= rv_comb_age                       => -0.00956,
                                               0);

k_subscore9 := map(
    (custom_1mth_inq in [0]) => -0.007046,
    (custom_1mth_inq in [1]) => 0.019047,
                                0);

k_subscore10 := map(
    NULL < rv_i60_inq_auto_count12 AND rv_i60_inq_auto_count12 < 1 => -0.006565,
    1 <= rv_i60_inq_auto_count12 AND rv_i60_inq_auto_count12 < 2   => 0.020728,
    2 <= rv_i60_inq_auto_count12                                   => 0.022609,
                                                                      0);

k_subscore11 := map(
    (cust_pii_variations in [0]) => -0.00743,
    (cust_pii_variations in [1]) => 0.009538,
    (cust_pii_variations in [2]) => 0.010372,
    (cust_pii_variations in [3]) => 0.016278,
                                    0);

k_subscore12 := map(
    (rv_l71_add_business in ['0']) => -0.001441,
    (rv_l71_add_business in ['1']) => 0.037828,
                                      0);

k_subscore13 := map(
    (rv_s65_ssn_prior_dob in ['0']) => -0.000483,
    (rv_s65_ssn_prior_dob in ['1']) => 0.082364,
                                       0);

k_rawscore := k_subscore0 +
    k_subscore1 +
    k_subscore2 +
    k_subscore3 +
    k_subscore4 +
    k_subscore5 +
    k_subscore6 +
    k_subscore7 +
    k_subscore8 +
    k_subscore9 +
    k_subscore10 +
    k_subscore11 +
    k_subscore12 +
    k_subscore13;

k_predprob := k_rawscore + 0.254158;

k_aacd_0 := map(
    NULL < rv_i60_inq_hiriskcred_count12 AND rv_i60_inq_hiriskcred_count12 < 1 => 'I60',
    1 <= rv_i60_inq_hiriskcred_count12 AND rv_i60_inq_hiriskcred_count12 < 2   => 'I60',
    2 <= rv_i60_inq_hiriskcred_count12 AND rv_i60_inq_hiriskcred_count12 < 5   => 'I60',
    5 <= rv_i60_inq_hiriskcred_count12                                         => 'I60',
                                                                                  '');

k_dist_0 := k_subscore0 - -0.035548;

k_aacd_1 := map(
    NULL < rv_d33_eviction_count AND rv_d33_eviction_count < 1 => 'D33',
    1 <= rv_d33_eviction_count                                 => 'D33',
                                                                  '');

k_dist_1 := k_subscore1 - -0.005857;

k_aacd_2 := map(
    NULL < rv_c12_inp_addr_source_count AND rv_c12_inp_addr_source_count < 1 => 'C12',
    1 <= rv_c12_inp_addr_source_count AND rv_c12_inp_addr_source_count < 2   => 'C12',
    2 <= rv_c12_inp_addr_source_count AND rv_c12_inp_addr_source_count < 3   => 'C12',
    3 <= rv_c12_inp_addr_source_count                                        => 'C12',
                                                                                '');

k_dist_2 := k_subscore2 - -0.026045;

k_aacd_3 := map(
    NULL < rv_c14_addrs_10yr AND rv_c14_addrs_10yr < 1 => 'C14',
    1 <= rv_c14_addrs_10yr AND rv_c14_addrs_10yr < 2   => 'C14',
    2 <= rv_c14_addrs_10yr AND rv_c14_addrs_10yr < 3   => 'C14',
    3 <= rv_c14_addrs_10yr AND rv_c14_addrs_10yr < 5   => 'C14',
    5 <= rv_c14_addrs_10yr                             => 'C14',
                                                          '');

k_dist_3 := k_subscore3 - -0.01485;

k_aacd_4 := map(
    (custom_derog_index in [0]) => 'D30',
    (custom_derog_index in [1]) => 'D34',
    (custom_derog_index in [2]) => 'D31',
    (custom_derog_index in [3]) => 'D32',
                                   '');

k_dist_4 := k_subscore4 - -0.005897;

k_aacd_5 := map(
    NULL < rv_c10_m_hdr_fs AND rv_c10_m_hdr_fs < 0   => 'C10',
    0 <= rv_c10_m_hdr_fs AND rv_c10_m_hdr_fs < 57    => 'C10',
    57 <= rv_c10_m_hdr_fs AND rv_c10_m_hdr_fs < 115  => 'C10',
    115 <= rv_c10_m_hdr_fs AND rv_c10_m_hdr_fs < 174 => 'C10',
    174 <= rv_c10_m_hdr_fs AND rv_c10_m_hdr_fs < 233 => 'C10',
    233 <= rv_c10_m_hdr_fs AND rv_c10_m_hdr_fs < 355 => 'C10',
    355 <= rv_c10_m_hdr_fs                           => 'C10',
                                                        '');

k_dist_5 := k_subscore5 - -0.022004;

k_aacd_6 := map(
    (iv_phn_addr_verified in ['0 NONE VERD'])              => 'C12',
    (iv_phn_addr_verified in ['1 INF ONLY', '2 NAP ONLY']) => 'C12',
    (iv_phn_addr_verified in ['3 BOTH VERD'])              => 'C12',
                                                              '');

k_dist_6 := k_subscore6 - -0.036309;

k_aacd_7 := map(
    (rv_a41_a42_prop_owner_history in [' '])          => 'A41',
    (rv_a41_a42_prop_owner_history in ['CURRENT'])    => 'A41',
    (rv_a41_a42_prop_owner_history in ['HISTORICAL']) => 'A42',
    (rv_a41_a42_prop_owner_history in ['NEVER'])      => 'A41',
                                                         '');

k_dist_7 := k_subscore7 - -0.020023;

k_aacd_8 := map(
    NULL < rv_comb_age AND rv_comb_age < 35 => 'C10',
    35 <= rv_comb_age                       => 'C10',
                                               '');

k_dist_8 := k_subscore8 - -0.00956;

k_aacd_9 := map(
    (custom_1mth_inq in [0]) => 'I60',
    (custom_1mth_inq in [1]) => 'I60',
                                '');

k_dist_9 := k_subscore9 - -0.007046;

k_aacd_10 := map(
    NULL < rv_i60_inq_auto_count12 AND rv_i60_inq_auto_count12 < 1 => 'I60',
    1 <= rv_i60_inq_auto_count12 AND rv_i60_inq_auto_count12 < 2   => 'I60',
    2 <= rv_i60_inq_auto_count12                                   => 'I60',
                                                                      '');

k_dist_10 := k_subscore10 - -0.006565;

k_aacd_11 := map(
    (cust_pii_variations in [0]) => 'I62',
    (cust_pii_variations in [1]) => 'I62',
    (cust_pii_variations in [2]) => 'I62',
    (cust_pii_variations in [3]) => 'I62',
                                    '');

k_dist_11 := k_subscore11 - -0.00743;

k_aacd_12 := map(
    (rv_l71_add_business in ['0']) => 'L71',
    (rv_l71_add_business in ['1']) => 'L71',
                                      '');

k_dist_12 := k_subscore12 - -0.001441;

k_aacd_13 := map(
    (rv_s65_ssn_prior_dob in ['0']) => 'S65',
    (rv_s65_ssn_prior_dob in ['1']) => 'S65',
                                       '');

k_dist_13 := k_subscore13 - -0.000483;

k_rcvalues65 := (integer)(k_aacd_0 = 'S65') * k_dist_0 +
    (integer)(k_aacd_1 = 'S65') * k_dist_1 +
    (integer)(k_aacd_2 = 'S65') * k_dist_2 +
    (integer)(k_aacd_3 = 'S65') * k_dist_3 +
    (integer)(k_aacd_4 = 'S65') * k_dist_4 +
    (integer)(k_aacd_5 = 'S65') * k_dist_5 +
    (integer)(k_aacd_6 = 'S65') * k_dist_6 +
    (integer)(k_aacd_7 = 'S65') * k_dist_7 +
    (integer)(k_aacd_8 = 'S65') * k_dist_8 +
    (integer)(k_aacd_9 = 'S65') * k_dist_9 +
    (integer)(k_aacd_10 = 'S65') * k_dist_10 +
    (integer)(k_aacd_11 = 'S65') * k_dist_11 +
    (integer)(k_aacd_12 = 'S65') * k_dist_12 +
    (integer)(k_aacd_13 = 'S65') * k_dist_13;

k_rcvalued34 := (integer)(k_aacd_0 = 'D34') * k_dist_0 +
    (integer)(k_aacd_1 = 'D34') * k_dist_1 +
    (integer)(k_aacd_2 = 'D34') * k_dist_2 +
    (integer)(k_aacd_3 = 'D34') * k_dist_3 +
    (integer)(k_aacd_4 = 'D34') * k_dist_4 +
    (integer)(k_aacd_5 = 'D34') * k_dist_5 +
    (integer)(k_aacd_6 = 'D34') * k_dist_6 +
    (integer)(k_aacd_7 = 'D34') * k_dist_7 +
    (integer)(k_aacd_8 = 'D34') * k_dist_8 +
    (integer)(k_aacd_9 = 'D34') * k_dist_9 +
    (integer)(k_aacd_10 = 'D34') * k_dist_10 +
    (integer)(k_aacd_11 = 'D34') * k_dist_11 +
    (integer)(k_aacd_12 = 'D34') * k_dist_12 +
    (integer)(k_aacd_13 = 'D34') * k_dist_13;

k_rcvaluel71 := (integer)(k_aacd_0 = 'L71') * k_dist_0 +
    (integer)(k_aacd_1 = 'L71') * k_dist_1 +
    (integer)(k_aacd_2 = 'L71') * k_dist_2 +
    (integer)(k_aacd_3 = 'L71') * k_dist_3 +
    (integer)(k_aacd_4 = 'L71') * k_dist_4 +
    (integer)(k_aacd_5 = 'L71') * k_dist_5 +
    (integer)(k_aacd_6 = 'L71') * k_dist_6 +
    (integer)(k_aacd_7 = 'L71') * k_dist_7 +
    (integer)(k_aacd_8 = 'L71') * k_dist_8 +
    (integer)(k_aacd_9 = 'L71') * k_dist_9 +
    (integer)(k_aacd_10 = 'L71') * k_dist_10 +
    (integer)(k_aacd_11 = 'L71') * k_dist_11 +
    (integer)(k_aacd_12 = 'L71') * k_dist_12 +
    (integer)(k_aacd_13 = 'L71') * k_dist_13;

k_rcvalued32 := (integer)(k_aacd_0 = 'D32') * k_dist_0 +
    (integer)(k_aacd_1 = 'D32') * k_dist_1 +
    (integer)(k_aacd_2 = 'D32') * k_dist_2 +
    (integer)(k_aacd_3 = 'D32') * k_dist_3 +
    (integer)(k_aacd_4 = 'D32') * k_dist_4 +
    (integer)(k_aacd_5 = 'D32') * k_dist_5 +
    (integer)(k_aacd_6 = 'D32') * k_dist_6 +
    (integer)(k_aacd_7 = 'D32') * k_dist_7 +
    (integer)(k_aacd_8 = 'D32') * k_dist_8 +
    (integer)(k_aacd_9 = 'D32') * k_dist_9 +
    (integer)(k_aacd_10 = 'D32') * k_dist_10 +
    (integer)(k_aacd_11 = 'D32') * k_dist_11 +
    (integer)(k_aacd_12 = 'D32') * k_dist_12 +
    (integer)(k_aacd_13 = 'D32') * k_dist_13;

k_rcvalued33 := (integer)(k_aacd_0 = 'D33') * k_dist_0 +
    (integer)(k_aacd_1 = 'D33') * k_dist_1 +
    (integer)(k_aacd_2 = 'D33') * k_dist_2 +
    (integer)(k_aacd_3 = 'D33') * k_dist_3 +
    (integer)(k_aacd_4 = 'D33') * k_dist_4 +
    (integer)(k_aacd_5 = 'D33') * k_dist_5 +
    (integer)(k_aacd_6 = 'D33') * k_dist_6 +
    (integer)(k_aacd_7 = 'D33') * k_dist_7 +
    (integer)(k_aacd_8 = 'D33') * k_dist_8 +
    (integer)(k_aacd_9 = 'D33') * k_dist_9 +
    (integer)(k_aacd_10 = 'D33') * k_dist_10 +
    (integer)(k_aacd_11 = 'D33') * k_dist_11 +
    (integer)(k_aacd_12 = 'D33') * k_dist_12 +
    (integer)(k_aacd_13 = 'D33') * k_dist_13;

k_rcvalued30 := (integer)(k_aacd_0 = 'D30') * k_dist_0 +
    (integer)(k_aacd_1 = 'D30') * k_dist_1 +
    (integer)(k_aacd_2 = 'D30') * k_dist_2 +
    (integer)(k_aacd_3 = 'D30') * k_dist_3 +
    (integer)(k_aacd_4 = 'D30') * k_dist_4 +
    (integer)(k_aacd_5 = 'D30') * k_dist_5 +
    (integer)(k_aacd_6 = 'D30') * k_dist_6 +
    (integer)(k_aacd_7 = 'D30') * k_dist_7 +
    (integer)(k_aacd_8 = 'D30') * k_dist_8 +
    (integer)(k_aacd_9 = 'D30') * k_dist_9 +
    (integer)(k_aacd_10 = 'D30') * k_dist_10 +
    (integer)(k_aacd_11 = 'D30') * k_dist_11 +
    (integer)(k_aacd_12 = 'D30') * k_dist_12 +
    (integer)(k_aacd_13 = 'D30') * k_dist_13;

k_rcvalued31 := (integer)(k_aacd_0 = 'D31') * k_dist_0 +
    (integer)(k_aacd_1 = 'D31') * k_dist_1 +
    (integer)(k_aacd_2 = 'D31') * k_dist_2 +
    (integer)(k_aacd_3 = 'D31') * k_dist_3 +
    (integer)(k_aacd_4 = 'D31') * k_dist_4 +
    (integer)(k_aacd_5 = 'D31') * k_dist_5 +
    (integer)(k_aacd_6 = 'D31') * k_dist_6 +
    (integer)(k_aacd_7 = 'D31') * k_dist_7 +
    (integer)(k_aacd_8 = 'D31') * k_dist_8 +
    (integer)(k_aacd_9 = 'D31') * k_dist_9 +
    (integer)(k_aacd_10 = 'D31') * k_dist_10 +
    (integer)(k_aacd_11 = 'D31') * k_dist_11 +
    (integer)(k_aacd_12 = 'D31') * k_dist_12 +
    (integer)(k_aacd_13 = 'D31') * k_dist_13;

k_rcvaluei60 := (integer)(k_aacd_0 = 'I60') * k_dist_0 +
    (integer)(k_aacd_1 = 'I60') * k_dist_1 +
    (integer)(k_aacd_2 = 'I60') * k_dist_2 +
    (integer)(k_aacd_3 = 'I60') * k_dist_3 +
    (integer)(k_aacd_4 = 'I60') * k_dist_4 +
    (integer)(k_aacd_5 = 'I60') * k_dist_5 +
    (integer)(k_aacd_6 = 'I60') * k_dist_6 +
    (integer)(k_aacd_7 = 'I60') * k_dist_7 +
    (integer)(k_aacd_8 = 'I60') * k_dist_8 +
    (integer)(k_aacd_9 = 'I60') * k_dist_9 +
    (integer)(k_aacd_10 = 'I60') * k_dist_10 +
    (integer)(k_aacd_11 = 'I60') * k_dist_11 +
    (integer)(k_aacd_12 = 'I60') * k_dist_12 +
    (integer)(k_aacd_13 = 'I60') * k_dist_13;

k_rcvaluea42 := (integer)(k_aacd_0 = 'A42') * k_dist_0 +
    (integer)(k_aacd_1 = 'A42') * k_dist_1 +
    (integer)(k_aacd_2 = 'A42') * k_dist_2 +
    (integer)(k_aacd_3 = 'A42') * k_dist_3 +
    (integer)(k_aacd_4 = 'A42') * k_dist_4 +
    (integer)(k_aacd_5 = 'A42') * k_dist_5 +
    (integer)(k_aacd_6 = 'A42') * k_dist_6 +
    (integer)(k_aacd_7 = 'A42') * k_dist_7 +
    (integer)(k_aacd_8 = 'A42') * k_dist_8 +
    (integer)(k_aacd_9 = 'A42') * k_dist_9 +
    (integer)(k_aacd_10 = 'A42') * k_dist_10 +
    (integer)(k_aacd_11 = 'A42') * k_dist_11 +
    (integer)(k_aacd_12 = 'A42') * k_dist_12 +
    (integer)(k_aacd_13 = 'A42') * k_dist_13;

k_rcvaluei62 := (integer)(k_aacd_0 = 'I62') * k_dist_0 +
    (integer)(k_aacd_1 = 'I62') * k_dist_1 +
    (integer)(k_aacd_2 = 'I62') * k_dist_2 +
    (integer)(k_aacd_3 = 'I62') * k_dist_3 +
    (integer)(k_aacd_4 = 'I62') * k_dist_4 +
    (integer)(k_aacd_5 = 'I62') * k_dist_5 +
    (integer)(k_aacd_6 = 'I62') * k_dist_6 +
    (integer)(k_aacd_7 = 'I62') * k_dist_7 +
    (integer)(k_aacd_8 = 'I62') * k_dist_8 +
    (integer)(k_aacd_9 = 'I62') * k_dist_9 +
    (integer)(k_aacd_10 = 'I62') * k_dist_10 +
    (integer)(k_aacd_11 = 'I62') * k_dist_11 +
    (integer)(k_aacd_12 = 'I62') * k_dist_12 +
    (integer)(k_aacd_13 = 'I62') * k_dist_13;

k_rcvaluea41 := (integer)(k_aacd_0 = 'A41') * k_dist_0 +
    (integer)(k_aacd_1 = 'A41') * k_dist_1 +
    (integer)(k_aacd_2 = 'A41') * k_dist_2 +
    (integer)(k_aacd_3 = 'A41') * k_dist_3 +
    (integer)(k_aacd_4 = 'A41') * k_dist_4 +
    (integer)(k_aacd_5 = 'A41') * k_dist_5 +
    (integer)(k_aacd_6 = 'A41') * k_dist_6 +
    (integer)(k_aacd_7 = 'A41') * k_dist_7 +
    (integer)(k_aacd_8 = 'A41') * k_dist_8 +
    (integer)(k_aacd_9 = 'A41') * k_dist_9 +
    (integer)(k_aacd_10 = 'A41') * k_dist_10 +
    (integer)(k_aacd_11 = 'A41') * k_dist_11 +
    (integer)(k_aacd_12 = 'A41') * k_dist_12 +
    (integer)(k_aacd_13 = 'A41') * k_dist_13;

k_rcvaluec12 := (integer)(k_aacd_0 = 'C12') * k_dist_0 +
    (integer)(k_aacd_1 = 'C12') * k_dist_1 +
    (integer)(k_aacd_2 = 'C12') * k_dist_2 +
    (integer)(k_aacd_3 = 'C12') * k_dist_3 +
    (integer)(k_aacd_4 = 'C12') * k_dist_4 +
    (integer)(k_aacd_5 = 'C12') * k_dist_5 +
    (integer)(k_aacd_6 = 'C12') * k_dist_6 +
    (integer)(k_aacd_7 = 'C12') * k_dist_7 +
    (integer)(k_aacd_8 = 'C12') * k_dist_8 +
    (integer)(k_aacd_9 = 'C12') * k_dist_9 +
    (integer)(k_aacd_10 = 'C12') * k_dist_10 +
    (integer)(k_aacd_11 = 'C12') * k_dist_11 +
    (integer)(k_aacd_12 = 'C12') * k_dist_12 +
    (integer)(k_aacd_13 = 'C12') * k_dist_13;

k_rcvaluec10 := (integer)(k_aacd_0 = 'C10') * k_dist_0 +
    (integer)(k_aacd_1 = 'C10') * k_dist_1 +
    (integer)(k_aacd_2 = 'C10') * k_dist_2 +
    (integer)(k_aacd_3 = 'C10') * k_dist_3 +
    (integer)(k_aacd_4 = 'C10') * k_dist_4 +
    (integer)(k_aacd_5 = 'C10') * k_dist_5 +
    (integer)(k_aacd_6 = 'C10') * k_dist_6 +
    (integer)(k_aacd_7 = 'C10') * k_dist_7 +
    (integer)(k_aacd_8 = 'C10') * k_dist_8 +
    (integer)(k_aacd_9 = 'C10') * k_dist_9 +
    (integer)(k_aacd_10 = 'C10') * k_dist_10 +
    (integer)(k_aacd_11 = 'C10') * k_dist_11 +
    (integer)(k_aacd_12 = 'C10') * k_dist_12 +
    (integer)(k_aacd_13 = 'C10') * k_dist_13;

k_rcvaluec14 := (integer)(k_aacd_0 = 'C14') * k_dist_0 +
    (integer)(k_aacd_1 = 'C14') * k_dist_1 +
    (integer)(k_aacd_2 = 'C14') * k_dist_2 +
    (integer)(k_aacd_3 = 'C14') * k_dist_3 +
    (integer)(k_aacd_4 = 'C14') * k_dist_4 +
    (integer)(k_aacd_5 = 'C14') * k_dist_5 +
    (integer)(k_aacd_6 = 'C14') * k_dist_6 +
    (integer)(k_aacd_7 = 'C14') * k_dist_7 +
    (integer)(k_aacd_8 = 'C14') * k_dist_8 +
    (integer)(k_aacd_9 = 'C14') * k_dist_9 +
    (integer)(k_aacd_10 = 'C14') * k_dist_10 +
    (integer)(k_aacd_11 = 'C14') * k_dist_11 +
    (integer)(k_aacd_12 = 'C14') * k_dist_12 +
    (integer)(k_aacd_13 = 'C14') * k_dist_13;

base := 600;

pdo := 40;

odds := (1 - 0.255) / 0.255;

iv_rv5_deceased := rc_decsflag = '1' or rc_ssndod != 0 or (Integer)indexw(StringLib.StringToUpperCase(trim(ver_sources, ALL)), 'DS', ',') > 0 or (Integer)indexw(StringLib.StringToUpperCase(trim(ver_sources, ALL)), 'DE', ',') > 0;

iv_rv5_unscorable := if(riskview.constants.noscore(le.iid.nas_summary,le.iid.nap_summary, le.address_verification.input_address_information.naprop, le.truedid), '1', '0');

rvg1702_1_0 := map(
    (Integer)iv_rv5_deceased > 0     => 200,
    iv_rv5_unscorable = '1' => 222,
                               max(min(if(round(pdo * (ln((1 - k_predprob) / k_predprob) - ln(odds)) / ln(2) + base) = NULL, -NULL, round(pdo * (ln((1 - k_predprob) / k_predprob) - ln(odds)) / ln(2) + base)), 900), 501));



//*************************************************************************************//
// I have no idea how the reason code logic gets implemented in ECL, so everything below 
// probably needs to get changed or replaced.  The methodology for creating the reason codes is
// very similar to the logic used by the RiskView 4.0 scores, so you might want to consult
// that model code for guidance on implementing reason codes. 
//*************************************************************************************//

ds_layout := {STRING rc, REAL value};


 
//*************************************************************************************//
rc_dataset_k := DATASET([
    {'S65', k_rcvalueS65},
    {'D34', k_rcvalueD34},
    {'L71', k_rcvalueL71},
    {'D32', k_rcvalueD32},
    {'D33', k_rcvalueD33},
    {'D30', k_rcvalueD30},
    {'D31', k_rcvalueD31},
    {'I60', k_rcvalueI60},
    {'A42', k_rcvalueA42},
    {'I62', k_rcvalueI62},
    {'A41', k_rcvalueA41},
    {'C12', k_rcvalueC12},
    {'C10', k_rcvalueC10},
    {'C14', k_rcvalueC14}
    ], ds_layout)(value > 0);

//*************************************************************************************//
// IMPORTANT NOTE:  Select ONLY reason codes with an RCValue < 0.  I'll leave the 
//   implementation of this to the Engineer
//*************************************************************************************//
rc_dataset_k_sorted := sort(rc_dataset_k, rc_dataset_k.value);

k_rc1 := rc_dataset_k_sorted[1].rc;
k_rc2 := rc_dataset_k_sorted[2].rc;
k_rc3 := rc_dataset_k_sorted[3].rc;
k_rc4 := rc_dataset_k_sorted[4].rc;

k_vl1 := rc_dataset_k_sorted[1].value;
k_vl2 := rc_dataset_k_sorted[2].value;
k_vl3 := rc_dataset_k_sorted[3].value;
k_vl4 := rc_dataset_k_sorted[4].value;
//*************************************************************************************//

rc1_3 := k_rc1;

rc2_2 := k_rc2;

rc3_2 := k_rc3;

rc4_2 := k_rc4;

_rc_inq := map(
    rv_i60_inq_hiriskcred_count12 > 0  => 'I60',
    rv_i60_inq_auto_count12 > 0        => 'I60',
    custom_1mth_inq > 0                => 'I60',
    (cust_pii_variations in [1, 2, 3]) => 'I62',
                                          '   ');

rc5_c49 := map(
    trim((string)rc1_3, LEFT, RIGHT) = '' => '',
    trim((string)rc2_2, LEFT, RIGHT) = '' => '',
    trim((string)rc3_2, LEFT, RIGHT) = '' => '',
    trim((string)rc4_2, LEFT, RIGHT) = '' => '',
                                             _rc_inq);

rc5_1 := if(not((rc1_3 in ['I60', 'I62'])) and not((rc2_2 in ['I60', 'I62'])) and not((rc3_2 in ['I60', 'I62'])) and not((rc4_2 in ['I60', 'I62'])), rc5_c49, '');

rc1_1 := if(trim(rc1_3) = '', 'C12', rc1_3);

rc1 := if((rvg1702_1_0 in [200, 222]), '', rc1_1);

rc2 := if((rvg1702_1_0 in [200, 222]), '', rc2_2);

rc3 := if((rvg1702_1_0 in [200, 222]), '', rc3_2);

rc4 := if((rvg1702_1_0 in [200, 222]), '', rc4_2);

rc5 := if((rvg1702_1_0 in [200, 222]), '', rc5_1);



//*************************************************************************************//
//                      RiskView Version 5 Reason Code Overrides 
//             ECL DEVELOPERS, MAKE SURE ALL RiskView V5 MODELS HAVE THIS
//*************************************************************************************//
	
HRILayout := RECORD
	STRING4 HRI := '';
END;
reasonsOverrides := MAP(
													// In Version 5 200 and 222 scores will not return reason codes, the will instead return alert codes
													RVG1702_1_0 = 200 => DATASET([{'00'}], HRILayout),
													RVG1702_1_0 = 222 => DATASET([{'00'}], HRILayout),
													RVG1702_1_0 = 900 => DATASET([{'00'}], HRILayout),
																							 DATASET([], HRILayout)
													);
reasons := DATASET([{rc1}, {rc2}, {rc3}, {rc4}, {rc5}], HRILayout);
// If we have score overrides use them, else use the normal reason codes
reasonsFinalTemp := IF(ut.Exists2(reasonsOverrides), 
										reasonsOverrides, 
										reasons) (HRI NOT IN ['', '00']);
zeros := DATASET([{'00'}, {'00'}, {'00'}, {'00'}, {'00'}], HRILayout);
reasonCodes := CHOOSEN(reasonsFinalTemp, 5); // Keep up to 5 reason codes

//*************************************************************************************//
//                   End RiskView Version 5 Reason Code Overrides
//*************************************************************************************//

	#if(MODEL_DEBUG)
		/* Model Input Variables */
	 self.seq                              := le.seq;
   self.sysdate                          := sysdate;
   self.rv_s65_ssn_prior_dob             := rv_s65_ssn_prior_dob;
   self.rv_l71_add_business              := rv_l71_add_business;
   self.rv_d33_eviction_count            := rv_d33_eviction_count;
   self._header_first_seen               := _header_first_seen;
   self.rv_c10_m_hdr_fs                  := rv_c10_m_hdr_fs;
   self._in_dob                          := _in_dob;
   self.yr_in_dob                        := yr_in_dob;
   self.yr_in_dob_int                    := yr_in_dob_int;
   self.rv_comb_age                      := rv_comb_age;
   self.rv_c14_addrs_10yr                := rv_c14_addrs_10yr;
   self.rv_a41_a42_prop_owner_history    := rv_a41_a42_prop_owner_history;
   self.rv_i60_inq_auto_count12          := rv_i60_inq_auto_count12;
   self.rv_i60_inq_hiriskcred_count12    := rv_i60_inq_hiriskcred_count12;
   self._nap_ver                         := _nap_ver;
   self._inf_ver                         := _inf_ver;
   self.iv_phn_addr_verified             := iv_phn_addr_verified;
   self.rv_c12_inp_addr_source_count     := rv_c12_inp_addr_source_count;
   self.custom_derog_index               := custom_derog_index;
   self.custom_1mth_inq                  := custom_1mth_inq;
   self.cust_pii_variations              := cust_pii_variations;
   self.k_subscore0     := k_subscore0;
   self.k_subscore1     := k_subscore1;
   self.k_subscore2     := k_subscore2;
   self.k_subscore3     := k_subscore3;
   self.k_subscore4     := k_subscore4;
   self.k_subscore5     := k_subscore5;
   self.k_subscore6     := k_subscore6;
   self.k_subscore7     := k_subscore7;
   self.k_subscore8     := k_subscore8;
   self.k_subscore9     := k_subscore9;
   self.k_subscore10    := k_subscore10;
   self.k_subscore11    := k_subscore11;
   self.k_subscore12    := k_subscore12;
   self.k_subscore13    := k_subscore13;
   self.k_rawscore      := k_rawscore;
   self.k_predprob      := k_predprob;
   self.k_aacd_0        := k_aacd_0;
   self.k_dist_0        := k_dist_0;
   self.k_aacd_1        := k_aacd_1;
   self.k_dist_1        := k_dist_1;
   self.k_aacd_2        := k_aacd_2;
   self.k_dist_2        := k_dist_2;
   self.k_aacd_3        := k_aacd_3;
   self.k_dist_3        := k_dist_3;
   self.k_aacd_4        := k_aacd_4;
   self.k_dist_4        := k_dist_4;
   self.k_aacd_5        := k_aacd_5;
   self.k_dist_5        := k_dist_5;
   self.k_aacd_6        := k_aacd_6;
   self.k_dist_6        := k_dist_6;
   self.k_aacd_7        := k_aacd_7;
   self.k_dist_7        := k_dist_7;
   self.k_aacd_8        := k_aacd_8;
   self.k_dist_8        := k_dist_8;
   self.k_aacd_9        := k_aacd_9;
   self.k_dist_9        := k_dist_9;
   self.k_aacd_10       := k_aacd_10;
   self.k_dist_10       := k_dist_10;
   self.k_aacd_11       := k_aacd_11;
   self.k_dist_11       := k_dist_11;
   self.k_aacd_12       := k_aacd_12;
   self.k_dist_12       := k_dist_12;
   self.k_aacd_13       := k_aacd_13;
   self.k_dist_13       := k_dist_13;
   self.k_rcvalues65    := k_rcvalues65;
   self.k_rcvalued34    := k_rcvalued34;
   self.k_rcvaluel71    := k_rcvaluel71;
   self.k_rcvalued32    := k_rcvalued32;
   self.k_rcvalued33    := k_rcvalued33;
   self.k_rcvalued30    := k_rcvalued30;
   self.k_rcvalued31    := k_rcvalued31;
   self.k_rcvaluei60    := k_rcvaluei60;
   self.k_rcvaluea42    := k_rcvaluea42;
   self.k_rcvaluei62    := k_rcvaluei62;
   self.k_rcvaluea41    := k_rcvaluea41;
   self.k_rcvaluec12    := k_rcvaluec12;
   self.k_rcvaluec10    := k_rcvaluec10;
   self.k_rcvaluec14    := k_rcvaluec14;
   self.base            := base;
   self.pdo             := pdo;
   self.odds            := odds;
   self.iv_rv5_deceased                  := iv_rv5_deceased;
   self.iv_rv5_unscorable                := iv_rv5_unscorable;
   self.rvg1702_1_0     := rvg1702_1_0;
   self.k_rc1           := k_rc1;
   self.k_rc2           := k_rc2;
   self.k_rc3           := k_rc3;
   self.k_rc4           := k_rc4;
   self.k_vl1           := k_vl1;
   self.k_vl2           := k_vl2;
   self.k_vl3           := k_vl3;
   self.k_vl4           := k_vl4;
   self._rc_inq         := _rc_inq;
   self.rc3             := rc3;
   self.rc4             := rc4;
   self.rc5             := rc5;
   self.rc1             := rc1;
   self.rc2             := rc2;

		SELF.clam := le;
	#else
		SELF.ri := PROJECT(reasonCodes, TRANSFORM(Risk_Indicators.Layout_Desc,
																							SELF.hri := LEFT.hri,
																							SELF.desc := Risk_Indicators.getHRIDesc(LEFT.hri)
																					));
		SELF.score := (STRING3)rvg1702_1_0;
		SELF.seq := le.seq;
	#end
	END;

	model := PROJECT(clam, doModel(LEFT));
	

	RETURN(model);
END;




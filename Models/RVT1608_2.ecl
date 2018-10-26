IMPORT Models, Risk_Indicators, RiskWise, RiskWiseFCRA, RiskView, UT, Std, riskview;

EXPORT RVT1608_2 (GROUPED DATASET(Risk_Indicators.Layout_Boca_Shell) clam) := FUNCTION

	MODEL_DEBUG        := FALSE;

	#if(MODEL_DEBUG)
Layout_Debug := RECORD
			
			unsigned4 seq;
			INTEGER sysdate; 
	INTEGER rv_F00_dob_score; INTEGER rv_F01_inp_addr_address_score; INTEGER rv_C21_stl_inq_Count; 
	STRING rv_D33_Eviction_Recency; INTEGER rv_D34_unrel_liens_ct; INTEGER rv_A46_Curr_AVM_AutoVal; 
	INTEGER rv_C14_addrs_15yr; 
	STRING rv_A41_A42_Prop_Owner_History; 
	INTEGER rv_I61_inq_collection_count12; INTEGER rv_I60_inq_hiRiskCred_count12; INTEGER rv_C18_invalid_addrs_per_adl; 
	BOOLEAN rv_truedid; 
	INTEGER rv_I62_inq_addrs_per_adl; INTEGER rv_I62_inq_phones_per_adl; 
	REAL f_subScore0; REAL f_subScore1; REAL f_subScore2; REAL f_subScore3; REAL f_subScore4; REAL f_subScore5; 
	REAL f_subScore6; REAL f_subScore7; REAL f_subScore8; REAL f_subScore9; REAL f_subScore10; REAL f_subScore11; 
	REAL f_subScore12; REAL f_subScore13; /*REAL f_scaledScore;*/ REAL f_rawScore; REAL f_lnOddsScore; REAL f_probScore; 
	STRING f_AACD_0; REAL f_DIST_0; STRING f_AACD_1; REAL f_DIST_1; STRING f_AACD_2; REAL f_DIST_2; 
	STRING f_AACD_3; REAL f_DIST_3; STRING f_AACD_4; REAL f_DIST_4; STRING f_AACD_5; REAL f_DIST_5; 
	STRING f_AACD_6; REAL f_DIST_6; STRING f_AACD_7; REAL f_DIST_7; STRING f_AACD_8; REAL f_DIST_8; 
	STRING f_AACD_9; REAL f_DIST_9; STRING f_AACD_10; REAL f_DIST_10; STRING f_AACD_11; REAL f_DIST_11; 
	STRING f_AACD_12; REAL f_DIST_12; STRING f_AACD_13; REAL f_DIST_13; 
	/*STRING i; STRING _rc; STRING rc; REAL tmp_dist; REAL _dst;*/ 
	STRING f_RC1; STRING f_RC2; STRING f_RC3; STRING f_RC4; /*STRING f_RC5; STRING f_RC6; STRING f_RC7; 
	STRING f_RC8; STRING f_RC9; STRING f_RC10; STRING f_RC11; STRING f_RC12; STRING f_RC13; */
	REAL f_VL1; REAL f_VL2; REAL f_VL3; REAL f_VL4; /*REAL f_VL5; REAL f_VL6; REAL f_VL7; 
	REAL f_VL8; REAL f_VL9; REAL f_VL10; REAL f_VL11; REAL f_VL12; REAL f_VL13; */
	/*INTEGER _NUM_RCS;*/ INTEGER base; REAL odds; INTEGER point; 
	BOOLEAN iv_rv5_deceased; STRING iv_rv5_unscorable; 
	INTEGER RVT1608_2_1; 
	STRING rc1; STRING rc2; STRING rc3; STRING rc4; STRING rc5; STRING _rc_inq;
			Risk_Indicators.Layout_Boca_Shell clam;
		END;
		Layout_Debug doModel(clam le) := TRANSFORM
	#else
		Models.Layout_ModelOut doModel(clam le) := TRANSFORM
	#end

	/* ***********************************************************
	 *             Model Input Variable Assignments              *
	 ************************************************************* */
	seq                              := le.seq;
	truedid                          := le.truedid;
	nas_summary                      := le.iid.nas_summary;
	nap_summary                      := le.iid.nap_summary;
	rc_ssndod                        := le.ssn_verification.validation.deceasedDate;
	rc_decsflag                      := le.iid.decsflag;
	combo_dobscore                   := le.iid.combo_dobscore;
	ver_sources                      := le.header_summary.ver_sources;
	dobpop                           := le.input_validation.dateofbirth;
	add_input_address_score          := le.address_verification.input_address_information.address_score;
	add_input_naprop                 := le.address_verification.input_address_information.naprop;
	add_input_pop                    := le.addrPop;
	property_owned_total             := le.address_verification.owned.property_total;
	add_curr_avm_auto_val            := le.avm.address_history_1.avm_automated_valuation;
	add_curr_naprop                  := le.address_verification.address_history_1.naprop;
	add_prev_naprop                  := le.address_verification.address_history_2.naprop;
	addrs_15yr                       := le.other_address_info.addrs_last_15years;
	invalid_addrs_per_adl            := le.velocity_counters.invalid_addrs_per_adl;
	inq_collection_count12           := le.acc_logs.collection.count12;
	inq_highriskcredit_count12       := le.acc_logs.highriskcredit.count12;
	inq_addrsperadl                  := le.acc_logs.inquiryaddrsperadl;
	inq_phonesperadl                 := le.acc_logs.inquiryphonesperadl;
	infutor_nap                      := le.infutor_phone.infutor_nap;
	stl_inq_count                    := le.impulse.count;
	attr_eviction_count              := le.bjl.eviction_count;
	attr_eviction_count90            := le.bjl.eviction_count90;
	attr_eviction_count180           := le.bjl.eviction_count180;
	attr_eviction_count12            := le.bjl.eviction_count12;
	attr_eviction_count24            := le.bjl.eviction_count24;
	attr_eviction_count36            := le.bjl.eviction_count36;
	attr_eviction_count60            := le.bjl.eviction_count60;
	liens_recent_unreleased_count    := le.bjl.liens_recent_unreleased_count;
	liens_historical_unreleased_ct   := le.bjl.liens_historical_unreleased_count;


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

rv_f00_dob_score := if(not(truedid and dobpop), NULL, min(if(combo_dobscore = NULL, -NULL, combo_dobscore), 999));

rv_f01_inp_addr_address_score := if(not(add_input_pop and truedid), NULL, min(if(add_input_address_score = NULL, -NULL, add_input_address_score), 999));

rv_c21_stl_inq_count := if(not(truedid), NULL, min(if(STL_Inq_count = NULL, -NULL, STL_Inq_count), 999));

rv_d33_eviction_recency := map(
    not(truedid)                                                => '  ',
    (boolean)attr_eviction_count90                              => '03',
    (boolean)attr_eviction_count180                             => '06',
    (boolean)attr_eviction_count12                              => '12',
    (boolean)attr_eviction_count24 and attr_eviction_count >= 2 => '24',
    (boolean)attr_eviction_count24                              => '25',
    (boolean)attr_eviction_count36 and attr_eviction_count >= 2 => '36',
    (boolean)attr_eviction_count36                              => '37',
    (boolean)attr_eviction_count60 and attr_eviction_count >= 2 => '60',
    (boolean)attr_eviction_count60                              => '61',
    attr_eviction_count >= 2                                    => '98',
    attr_eviction_count >= 1                                    => '99',
                                                                   '00');

rv_d34_unrel_liens_ct := if(not(truedid), NULL, min(if(liens_recent_unreleased_count + liens_historical_unreleased_ct = NULL, -NULL, liens_recent_unreleased_count + liens_historical_unreleased_ct), 999));

rv_a46_curr_avm_autoval := if(not(truedid), NULL, add_curr_avm_auto_val);

rv_c14_addrs_15yr := if(not(truedid), NULL, min(if(addrs_15yr = NULL, -NULL, addrs_15yr), 999));

rv_a41_a42_prop_owner_history := map(
    not(truedid)                                                                     => '',
    add_input_naprop = 4 or add_curr_naprop = 4 or property_owned_total > 0          => 'CURRENT',
    add_prev_naprop = 4 or Models.Common.findw_cpp(ver_sources, 'P' , ', ', 'E') > 0 => 'HISTORICAL',
                                                                                        'NEVER');

rv_i61_inq_collection_count12 := if(not(truedid), NULL, min(if(inq_collection_count12 = NULL, -NULL, inq_collection_count12), 999));

rv_i60_inq_hiriskcred_count12 := if(not(truedid), NULL, min(if(inq_highRiskCredit_count12 = NULL, -NULL, inq_highRiskCredit_count12), 999));

rv_c18_invalid_addrs_per_adl := if(not(truedid), NULL, min(if(invalid_addrs_per_adl = NULL, -NULL, invalid_addrs_per_adl), 999));

rv_truedid := truedid;

rv_i62_inq_addrs_per_adl := if(not(truedid), NULL, min(if(inq_addrsperadl = NULL, -NULL, inq_addrsperadl), 999));

rv_i62_inq_phones_per_adl := if(not(truedid), NULL, min(if(inq_phonesperadl = NULL, -NULL, inq_phonesperadl), 999));

f_subscore0 := map(
    NULL < rv_f01_inp_addr_address_score AND rv_f01_inp_addr_address_score < 50  => -0.481009,
    50 <= rv_f01_inp_addr_address_score AND rv_f01_inp_addr_address_score < 100  => -0.011592,
    100 <= rv_f01_inp_addr_address_score AND rv_f01_inp_addr_address_score < 255 => 0.134341,
    255 <= rv_f01_inp_addr_address_score                                         => 0,
                                                                                    0);

f_subscore1 := map(
    NULL < rv_a46_curr_avm_autoval AND rv_a46_curr_avm_autoval < 1         => -0.02847,
    1 <= rv_a46_curr_avm_autoval AND rv_a46_curr_avm_autoval < 34707       => -0.546203,
    34707 <= rv_a46_curr_avm_autoval AND rv_a46_curr_avm_autoval < 56923   => -0.331872,
    56923 <= rv_a46_curr_avm_autoval AND rv_a46_curr_avm_autoval < 93240   => -0.269707,
    93240 <= rv_a46_curr_avm_autoval AND rv_a46_curr_avm_autoval < 124424  => -0.130374,
    124424 <= rv_a46_curr_avm_autoval AND rv_a46_curr_avm_autoval < 173966 => -0.040293,
    173966 <= rv_a46_curr_avm_autoval AND rv_a46_curr_avm_autoval < 249582 => 0.085126,
    249582 <= rv_a46_curr_avm_autoval AND rv_a46_curr_avm_autoval < 276583 => 0.159857,
    276583 <= rv_a46_curr_avm_autoval                                      => 0.406746,
                                                                              0);

f_subscore2 := map(
    NULL < rv_i62_inq_phones_per_adl AND rv_i62_inq_phones_per_adl < 1 => 0.095236,
    1 <= rv_i62_inq_phones_per_adl AND rv_i62_inq_phones_per_adl < 2   => -0.123172,
    2 <= rv_i62_inq_phones_per_adl AND rv_i62_inq_phones_per_adl < 4   => -0.42561,
    4 <= rv_i62_inq_phones_per_adl                                     => -1.133589,
                                                                          0);

f_subscore3 := map(
    (rv_a41_a42_prop_owner_history in [' '])          => -0.042406,
    (rv_a41_a42_prop_owner_history in ['CURRENT'])    => 0.24058,
    (rv_a41_a42_prop_owner_history in ['HISTORICAL']) => 0.126943,
    (rv_a41_a42_prop_owner_history in ['NEVER'])      => -0.125157,
                                                         0);

f_subscore4 := map(
    (rv_d33_eviction_recency in [' '])                          => 0,
    (rv_d33_eviction_recency in ['00'])                         => 0.042161,
    (rv_d33_eviction_recency in ['03'])                         => -0.981041,
    (rv_d33_eviction_recency in ['06'])                         => -0.622884,
    (rv_d33_eviction_recency in ['12', '24'])                   => -0.570408,
    (rv_d33_eviction_recency in ['25', '36'])                   => -0.442655,
    (rv_d33_eviction_recency in ['37', '60', '61', '98', '99']) => -0.348981,
                                                                   0);

f_subscore5 := map(
    NULL < rv_d34_unrel_liens_ct AND rv_d34_unrel_liens_ct < 1 => 0.052981,
    1 <= rv_d34_unrel_liens_ct                                 => -0.37468,
                                                                  0);

f_subscore6 := map(
    NULL < rv_i60_inq_hiriskcred_count12 AND rv_i60_inq_hiriskcred_count12 < 1 => 0.032514,
    1 <= rv_i60_inq_hiriskcred_count12                                         => -0.50987,
                                                                                  0);

f_subscore7 := map(
    NULL < rv_i62_inq_addrs_per_adl AND rv_i62_inq_addrs_per_adl < 1 => 0.112922,
    1 <= rv_i62_inq_addrs_per_adl AND rv_i62_inq_addrs_per_adl < 2   => -0.088667,
    2 <= rv_i62_inq_addrs_per_adl AND rv_i62_inq_addrs_per_adl < 3   => -0.113758,
    3 <= rv_i62_inq_addrs_per_adl                                    => -0.20427,
                                                                        0);

f_subscore8 := map(
    NULL < rv_f00_dob_score AND rv_f00_dob_score < 50  => -1.002085,
    50 <= rv_f00_dob_score AND rv_f00_dob_score < 70   => -0.619885,
    70 <= rv_f00_dob_score AND rv_f00_dob_score < 100  => -0.173614,
    100 <= rv_f00_dob_score AND rv_f00_dob_score < 255 => 0.02214,
    255 <= rv_f00_dob_score                            => 0,
                                                          0);

f_subscore9 := map(
    NULL < rv_c21_stl_inq_count AND rv_c21_stl_inq_count < 1 => 0.012983,
    1 <= rv_c21_stl_inq_count AND rv_c21_stl_inq_count < 3   => -0.305459,
    3 <= rv_c21_stl_inq_count                                => -0.4491,
                                                                0);

f_subscore10 := map(
    NULL < rv_i61_inq_collection_count12 AND rv_i61_inq_collection_count12 < 1 => 0.010514,
    1 <= rv_i61_inq_collection_count12                                         => -0.345522,
                                                                                  0);

f_subscore11 := map(
    NULL < rv_c18_invalid_addrs_per_adl AND rv_c18_invalid_addrs_per_adl < 1 => 0.036799,
    1 <= rv_c18_invalid_addrs_per_adl                                        => -0.078887,
                                                                                0);

f_subscore12 := map(
    NULL < rv_c14_addrs_15yr AND rv_c14_addrs_15yr < 2 => 0.032865,
    2 <= rv_c14_addrs_15yr AND rv_c14_addrs_15yr < 3   => 0.008553,
    3 <= rv_c14_addrs_15yr AND rv_c14_addrs_15yr < 5   => 0.008039,
    5 <= rv_c14_addrs_15yr AND rv_c14_addrs_15yr < 6   => -0.021465,
    6 <= rv_c14_addrs_15yr                             => -0.0594,
                                                          0);

f_subscore13 := map(
    ((integer)rv_truedid in [0]) => -0.108654,
    ((integer)rv_truedid in [1]) => 0.000468,
                             0);

f_rawscore := f_subscore0 +
    f_subscore1 +
    f_subscore2 +
    f_subscore3 +
    f_subscore4 +
    f_subscore5 +
    f_subscore6 +
    f_subscore7 +
    f_subscore8 +
    f_subscore9 +
    f_subscore10 +
    f_subscore11 +
    f_subscore12 +
    f_subscore13;

f_lnoddsscore := f_rawscore + 1.936726;

f_probscore := exp(f_lnoddsscore) / (1 + exp(f_lnoddsscore));

f_aacd_0 := map(
    NULL < rv_f01_inp_addr_address_score AND rv_f01_inp_addr_address_score < 50  => 'F01',
    50 <= rv_f01_inp_addr_address_score AND rv_f01_inp_addr_address_score < 100  => 'F01',
    100 <= rv_f01_inp_addr_address_score AND rv_f01_inp_addr_address_score < 255 => 'F01',
    255 <= rv_f01_inp_addr_address_score                                         => 'F01',
                                                                                    '');

f_dist_0 := f_subscore0 - 0.134341;

f_aacd_1 := map(
    NULL < rv_a46_curr_avm_autoval AND rv_a46_curr_avm_autoval < 1         => 'A51',
    1 <= rv_a46_curr_avm_autoval AND rv_a46_curr_avm_autoval < 34707       => 'A46',
    34707 <= rv_a46_curr_avm_autoval AND rv_a46_curr_avm_autoval < 56923   => 'A46',
    56923 <= rv_a46_curr_avm_autoval AND rv_a46_curr_avm_autoval < 93240   => 'A46',
    93240 <= rv_a46_curr_avm_autoval AND rv_a46_curr_avm_autoval < 124424  => 'A46',
    124424 <= rv_a46_curr_avm_autoval AND rv_a46_curr_avm_autoval < 173966 => 'A46',
    173966 <= rv_a46_curr_avm_autoval AND rv_a46_curr_avm_autoval < 249582 => 'A46',
    249582 <= rv_a46_curr_avm_autoval AND rv_a46_curr_avm_autoval < 276583 => 'A46',
    276583 <= rv_a46_curr_avm_autoval                                      => 'A46',
                                                                              '');

f_dist_1 := f_subscore1 - 0.406746;

f_aacd_2 := map(
    NULL < rv_i62_inq_phones_per_adl AND rv_i62_inq_phones_per_adl < 1 => 'I62',
    1 <= rv_i62_inq_phones_per_adl AND rv_i62_inq_phones_per_adl < 2   => 'I62',
    2 <= rv_i62_inq_phones_per_adl AND rv_i62_inq_phones_per_adl < 4   => 'I62',
    4 <= rv_i62_inq_phones_per_adl                                     => 'I62',
                                                                          '');

f_dist_2 := f_subscore2 - 0.095236;

f_aacd_3 := map(
    (rv_a41_a42_prop_owner_history in [' '])          => '',
    (rv_a41_a42_prop_owner_history in ['CURRENT'])    => 'A42',
    (rv_a41_a42_prop_owner_history in ['HISTORICAL']) => 'A42',
    (rv_a41_a42_prop_owner_history in ['NEVER'])      => 'A42',
                                                         '');

f_dist_3 := f_subscore3 - 0.24058;

f_aacd_4 := map(
    (rv_d33_eviction_recency in [' '])                          => '',
    (rv_d33_eviction_recency in ['00'])                         => 'D33',
    (rv_d33_eviction_recency in ['03'])                         => 'D33',
    (rv_d33_eviction_recency in ['06'])                         => 'D33',
    (rv_d33_eviction_recency in ['12', '24'])                   => 'D33',
    (rv_d33_eviction_recency in ['25', '36'])                   => 'D33',
    (rv_d33_eviction_recency in ['37', '60', '61', '98', '99']) => 'D33',
                                                                   '');

f_dist_4 := f_subscore4 - 0.042161;

f_aacd_5 := map(
    NULL < rv_d34_unrel_liens_ct AND rv_d34_unrel_liens_ct < 1 => 'D34',
    1 <= rv_d34_unrel_liens_ct                                 => 'D34',
                                                                  '');

f_dist_5 := f_subscore5 - 0.052981;

f_aacd_6 := map(
    NULL < rv_i60_inq_hiriskcred_count12 AND rv_i60_inq_hiriskcred_count12 < 1 => 'I60',
    1 <= rv_i60_inq_hiriskcred_count12                                         => 'I60',
                                                                                  '');

f_dist_6 := f_subscore6 - 0.032514;

f_aacd_7 := map(
    NULL < rv_i62_inq_addrs_per_adl AND rv_i62_inq_addrs_per_adl < 1 => 'I62',
    1 <= rv_i62_inq_addrs_per_adl AND rv_i62_inq_addrs_per_adl < 2   => 'I62',
    2 <= rv_i62_inq_addrs_per_adl AND rv_i62_inq_addrs_per_adl < 3   => 'I62',
    3 <= rv_i62_inq_addrs_per_adl                                    => 'I62',
                                                                        '');

f_dist_7 := f_subscore7 - 0.112922;

f_aacd_8 := map(
    NULL < rv_f00_dob_score AND rv_f00_dob_score < 50  => '',
    50 <= rv_f00_dob_score AND rv_f00_dob_score < 70   => '',
    70 <= rv_f00_dob_score AND rv_f00_dob_score < 100  => '',
    100 <= rv_f00_dob_score AND rv_f00_dob_score < 255 => '',
    255 <= rv_f00_dob_score                            => '',
                                                          '');

f_dist_8 := f_subscore8 - 0.02214;

f_aacd_9 := map(
    NULL < rv_c21_stl_inq_count AND rv_c21_stl_inq_count < 1 => 'C21',
    1 <= rv_c21_stl_inq_count AND rv_c21_stl_inq_count < 3   => 'C21',
    3 <= rv_c21_stl_inq_count                                => 'C21',
                                                                '');

f_dist_9 := f_subscore9 - 0.012983;

f_aacd_10 := map(
    NULL < rv_i61_inq_collection_count12 AND rv_i61_inq_collection_count12 < 1 => 'I61',
    1 <= rv_i61_inq_collection_count12                                         => 'I61',
                                                                                  '');

f_dist_10 := f_subscore10 - 0.010514;

f_aacd_11 := map(
    NULL < rv_c18_invalid_addrs_per_adl AND rv_c18_invalid_addrs_per_adl < 1 => 'C18',
    1 <= rv_c18_invalid_addrs_per_adl                                        => 'C18',
                                                                                '');

f_dist_11 := f_subscore11 - 0.036799;

f_aacd_12 := map(
    NULL < rv_c14_addrs_15yr AND rv_c14_addrs_15yr < 2 => 'C13',
    2 <= rv_c14_addrs_15yr AND rv_c14_addrs_15yr < 3   => 'C14',
    3 <= rv_c14_addrs_15yr AND rv_c14_addrs_15yr < 5   => 'C14',
    5 <= rv_c14_addrs_15yr AND rv_c14_addrs_15yr < 6   => 'C14',
    6 <= rv_c14_addrs_15yr                             => 'C14',
                                                          'C13');

f_dist_12 := f_subscore12 - 0.032865;

f_aacd_13 := map(
    ((integer)rv_truedid in [0]) => 'C22',
    ((integer)rv_truedid in [1]) => '',
                                    'C22');

f_dist_13 := f_subscore13 - 0.000468;

f_rcvaluec22 := (integer)(f_aacd_0 = 'C22') * f_dist_0 +
    (integer)(f_aacd_1 = 'C22') * f_dist_1 +
    (integer)(f_aacd_2 = 'C22') * f_dist_2 +
    (integer)(f_aacd_3 = 'C22') * f_dist_3 +
    (integer)(f_aacd_4 = 'C22') * f_dist_4 +
    (integer)(f_aacd_5 = 'C22') * f_dist_5 +
    (integer)(f_aacd_6 = 'C22') * f_dist_6 +
    (integer)(f_aacd_7 = 'C22') * f_dist_7 +
    (integer)(f_aacd_8 = 'C22') * f_dist_8 +
    (integer)(f_aacd_9 = 'C22') * f_dist_9 +
    (integer)(f_aacd_10 = 'C22') * f_dist_10 +
    (integer)(f_aacd_11 = 'C22') * f_dist_11 +
    (integer)(f_aacd_12 = 'C22') * f_dist_12 +
    (integer)(f_aacd_13 = 'C22') * f_dist_13;

f_rcvaluea46 := (integer)(f_aacd_0 = 'A46') * f_dist_0 +
    (integer)(f_aacd_1 = 'A46') * f_dist_1 +
    (integer)(f_aacd_2 = 'A46') * f_dist_2 +
    (integer)(f_aacd_3 = 'A46') * f_dist_3 +
    (integer)(f_aacd_4 = 'A46') * f_dist_4 +
    (integer)(f_aacd_5 = 'A46') * f_dist_5 +
    (integer)(f_aacd_6 = 'A46') * f_dist_6 +
    (integer)(f_aacd_7 = 'A46') * f_dist_7 +
    (integer)(f_aacd_8 = 'A46') * f_dist_8 +
    (integer)(f_aacd_9 = 'A46') * f_dist_9 +
    (integer)(f_aacd_10 = 'A46') * f_dist_10 +
    (integer)(f_aacd_11 = 'A46') * f_dist_11 +
    (integer)(f_aacd_12 = 'A46') * f_dist_12 +
    (integer)(f_aacd_13 = 'A46') * f_dist_13;

f_rcvaluec21 := (integer)(f_aacd_0 = 'C21') * f_dist_0 +
    (integer)(f_aacd_1 = 'C21') * f_dist_1 +
    (integer)(f_aacd_2 = 'C21') * f_dist_2 +
    (integer)(f_aacd_3 = 'C21') * f_dist_3 +
    (integer)(f_aacd_4 = 'C21') * f_dist_4 +
    (integer)(f_aacd_5 = 'C21') * f_dist_5 +
    (integer)(f_aacd_6 = 'C21') * f_dist_6 +
    (integer)(f_aacd_7 = 'C21') * f_dist_7 +
    (integer)(f_aacd_8 = 'C21') * f_dist_8 +
    (integer)(f_aacd_9 = 'C21') * f_dist_9 +
    (integer)(f_aacd_10 = 'C21') * f_dist_10 +
    (integer)(f_aacd_11 = 'C21') * f_dist_11 +
    (integer)(f_aacd_12 = 'C21') * f_dist_12 +
    (integer)(f_aacd_13 = 'C21') * f_dist_13;

f_rcvalued34 := (integer)(f_aacd_0 = 'D34') * f_dist_0 +
    (integer)(f_aacd_1 = 'D34') * f_dist_1 +
    (integer)(f_aacd_2 = 'D34') * f_dist_2 +
    (integer)(f_aacd_3 = 'D34') * f_dist_3 +
    (integer)(f_aacd_4 = 'D34') * f_dist_4 +
    (integer)(f_aacd_5 = 'D34') * f_dist_5 +
    (integer)(f_aacd_6 = 'D34') * f_dist_6 +
    (integer)(f_aacd_7 = 'D34') * f_dist_7 +
    (integer)(f_aacd_8 = 'D34') * f_dist_8 +
    (integer)(f_aacd_9 = 'D34') * f_dist_9 +
    (integer)(f_aacd_10 = 'D34') * f_dist_10 +
    (integer)(f_aacd_11 = 'D34') * f_dist_11 +
    (integer)(f_aacd_12 = 'D34') * f_dist_12 +
    (integer)(f_aacd_13 = 'D34') * f_dist_13;

f_rcvalued33 := (integer)(f_aacd_0 = 'D33') * f_dist_0 +
    (integer)(f_aacd_1 = 'D33') * f_dist_1 +
    (integer)(f_aacd_2 = 'D33') * f_dist_2 +
    (integer)(f_aacd_3 = 'D33') * f_dist_3 +
    (integer)(f_aacd_4 = 'D33') * f_dist_4 +
    (integer)(f_aacd_5 = 'D33') * f_dist_5 +
    (integer)(f_aacd_6 = 'D33') * f_dist_6 +
    (integer)(f_aacd_7 = 'D33') * f_dist_7 +
    (integer)(f_aacd_8 = 'D33') * f_dist_8 +
    (integer)(f_aacd_9 = 'D33') * f_dist_9 +
    (integer)(f_aacd_10 = 'D33') * f_dist_10 +
    (integer)(f_aacd_11 = 'D33') * f_dist_11 +
    (integer)(f_aacd_12 = 'D33') * f_dist_12 +
    (integer)(f_aacd_13 = 'D33') * f_dist_13;

f_rcvaluea51 := (integer)(f_aacd_0 = 'A51') * f_dist_0 +
    (integer)(f_aacd_1 = 'A51') * f_dist_1 +
    (integer)(f_aacd_2 = 'A51') * f_dist_2 +
    (integer)(f_aacd_3 = 'A51') * f_dist_3 +
    (integer)(f_aacd_4 = 'A51') * f_dist_4 +
    (integer)(f_aacd_5 = 'A51') * f_dist_5 +
    (integer)(f_aacd_6 = 'A51') * f_dist_6 +
    (integer)(f_aacd_7 = 'A51') * f_dist_7 +
    (integer)(f_aacd_8 = 'A51') * f_dist_8 +
    (integer)(f_aacd_9 = 'A51') * f_dist_9 +
    (integer)(f_aacd_10 = 'A51') * f_dist_10 +
    (integer)(f_aacd_11 = 'A51') * f_dist_11 +
    (integer)(f_aacd_12 = 'A51') * f_dist_12 +
    (integer)(f_aacd_13 = 'A51') * f_dist_13;

f_rcvaluei60 := (integer)(f_aacd_0 = 'I60') * f_dist_0 +
    (integer)(f_aacd_1 = 'I60') * f_dist_1 +
    (integer)(f_aacd_2 = 'I60') * f_dist_2 +
    (integer)(f_aacd_3 = 'I60') * f_dist_3 +
    (integer)(f_aacd_4 = 'I60') * f_dist_4 +
    (integer)(f_aacd_5 = 'I60') * f_dist_5 +
    (integer)(f_aacd_6 = 'I60') * f_dist_6 +
    (integer)(f_aacd_7 = 'I60') * f_dist_7 +
    (integer)(f_aacd_8 = 'I60') * f_dist_8 +
    (integer)(f_aacd_9 = 'I60') * f_dist_9 +
    (integer)(f_aacd_10 = 'I60') * f_dist_10 +
    (integer)(f_aacd_11 = 'I60') * f_dist_11 +
    (integer)(f_aacd_12 = 'I60') * f_dist_12 +
    (integer)(f_aacd_13 = 'I60') * f_dist_13;

f_rcvaluec18 := (integer)(f_aacd_0 = 'C18') * f_dist_0 +
    (integer)(f_aacd_1 = 'C18') * f_dist_1 +
    (integer)(f_aacd_2 = 'C18') * f_dist_2 +
    (integer)(f_aacd_3 = 'C18') * f_dist_3 +
    (integer)(f_aacd_4 = 'C18') * f_dist_4 +
    (integer)(f_aacd_5 = 'C18') * f_dist_5 +
    (integer)(f_aacd_6 = 'C18') * f_dist_6 +
    (integer)(f_aacd_7 = 'C18') * f_dist_7 +
    (integer)(f_aacd_8 = 'C18') * f_dist_8 +
    (integer)(f_aacd_9 = 'C18') * f_dist_9 +
    (integer)(f_aacd_10 = 'C18') * f_dist_10 +
    (integer)(f_aacd_11 = 'C18') * f_dist_11 +
    (integer)(f_aacd_12 = 'C18') * f_dist_12 +
    (integer)(f_aacd_13 = 'C18') * f_dist_13;

f_rcvaluef01 := (integer)(f_aacd_0 = 'F01') * f_dist_0 +
    (integer)(f_aacd_1 = 'F01') * f_dist_1 +
    (integer)(f_aacd_2 = 'F01') * f_dist_2 +
    (integer)(f_aacd_3 = 'F01') * f_dist_3 +
    (integer)(f_aacd_4 = 'F01') * f_dist_4 +
    (integer)(f_aacd_5 = 'F01') * f_dist_5 +
    (integer)(f_aacd_6 = 'F01') * f_dist_6 +
    (integer)(f_aacd_7 = 'F01') * f_dist_7 +
    (integer)(f_aacd_8 = 'F01') * f_dist_8 +
    (integer)(f_aacd_9 = 'F01') * f_dist_9 +
    (integer)(f_aacd_10 = 'F01') * f_dist_10 +
    (integer)(f_aacd_11 = 'F01') * f_dist_11 +
    (integer)(f_aacd_12 = 'F01') * f_dist_12 +
    (integer)(f_aacd_13 = 'F01') * f_dist_13;

f_rcvaluei61 := (integer)(f_aacd_0 = 'I61') * f_dist_0 +
    (integer)(f_aacd_1 = 'I61') * f_dist_1 +
    (integer)(f_aacd_2 = 'I61') * f_dist_2 +
    (integer)(f_aacd_3 = 'I61') * f_dist_3 +
    (integer)(f_aacd_4 = 'I61') * f_dist_4 +
    (integer)(f_aacd_5 = 'I61') * f_dist_5 +
    (integer)(f_aacd_6 = 'I61') * f_dist_6 +
    (integer)(f_aacd_7 = 'I61') * f_dist_7 +
    (integer)(f_aacd_8 = 'I61') * f_dist_8 +
    (integer)(f_aacd_9 = 'I61') * f_dist_9 +
    (integer)(f_aacd_10 = 'I61') * f_dist_10 +
    (integer)(f_aacd_11 = 'I61') * f_dist_11 +
    (integer)(f_aacd_12 = 'I61') * f_dist_12 +
    (integer)(f_aacd_13 = 'I61') * f_dist_13;

f_rcvaluei62 := (integer)(f_aacd_0 = 'I62') * f_dist_0 +
    (integer)(f_aacd_1 = 'I62') * f_dist_1 +
    (integer)(f_aacd_2 = 'I62') * f_dist_2 +
    (integer)(f_aacd_3 = 'I62') * f_dist_3 +
    (integer)(f_aacd_4 = 'I62') * f_dist_4 +
    (integer)(f_aacd_5 = 'I62') * f_dist_5 +
    (integer)(f_aacd_6 = 'I62') * f_dist_6 +
    (integer)(f_aacd_7 = 'I62') * f_dist_7 +
    (integer)(f_aacd_8 = 'I62') * f_dist_8 +
    (integer)(f_aacd_9 = 'I62') * f_dist_9 +
    (integer)(f_aacd_10 = 'I62') * f_dist_10 +
    (integer)(f_aacd_11 = 'I62') * f_dist_11 +
    (integer)(f_aacd_12 = 'I62') * f_dist_12 +
    (integer)(f_aacd_13 = 'I62') * f_dist_13;

f_rcvaluec13 := (integer)(f_aacd_0 = 'C13') * f_dist_0 +
    (integer)(f_aacd_1 = 'C13') * f_dist_1 +
    (integer)(f_aacd_2 = 'C13') * f_dist_2 +
    (integer)(f_aacd_3 = 'C13') * f_dist_3 +
    (integer)(f_aacd_4 = 'C13') * f_dist_4 +
    (integer)(f_aacd_5 = 'C13') * f_dist_5 +
    (integer)(f_aacd_6 = 'C13') * f_dist_6 +
    (integer)(f_aacd_7 = 'C13') * f_dist_7 +
    (integer)(f_aacd_8 = 'C13') * f_dist_8 +
    (integer)(f_aacd_9 = 'C13') * f_dist_9 +
    (integer)(f_aacd_10 = 'C13') * f_dist_10 +
    (integer)(f_aacd_11 = 'C13') * f_dist_11 +
    (integer)(f_aacd_12 = 'C13') * f_dist_12 +
    (integer)(f_aacd_13 = 'C13') * f_dist_13;

f_rcvaluea42 := (integer)(f_aacd_0 = 'A42') * f_dist_0 +
    (integer)(f_aacd_1 = 'A42') * f_dist_1 +
    (integer)(f_aacd_2 = 'A42') * f_dist_2 +
    (integer)(f_aacd_3 = 'A42') * f_dist_3 +
    (integer)(f_aacd_4 = 'A42') * f_dist_4 +
    (integer)(f_aacd_5 = 'A42') * f_dist_5 +
    (integer)(f_aacd_6 = 'A42') * f_dist_6 +
    (integer)(f_aacd_7 = 'A42') * f_dist_7 +
    (integer)(f_aacd_8 = 'A42') * f_dist_8 +
    (integer)(f_aacd_9 = 'A42') * f_dist_9 +
    (integer)(f_aacd_10 = 'A42') * f_dist_10 +
    (integer)(f_aacd_11 = 'A42') * f_dist_11 +
    (integer)(f_aacd_12 = 'A42') * f_dist_12 +
    (integer)(f_aacd_13 = 'A42') * f_dist_13;

f_rcvaluec14 := (integer)(f_aacd_0 = 'C14') * f_dist_0 +
    (integer)(f_aacd_1 = 'C14') * f_dist_1 +
    (integer)(f_aacd_2 = 'C14') * f_dist_2 +
    (integer)(f_aacd_3 = 'C14') * f_dist_3 +
    (integer)(f_aacd_4 = 'C14') * f_dist_4 +
    (integer)(f_aacd_5 = 'C14') * f_dist_5 +
    (integer)(f_aacd_6 = 'C14') * f_dist_6 +
    (integer)(f_aacd_7 = 'C14') * f_dist_7 +
    (integer)(f_aacd_8 = 'C14') * f_dist_8 +
    (integer)(f_aacd_9 = 'C14') * f_dist_9 +
    (integer)(f_aacd_10 = 'C14') * f_dist_10 +
    (integer)(f_aacd_11 = 'C14') * f_dist_11 +
    (integer)(f_aacd_12 = 'C14') * f_dist_12 +
    (integer)(f_aacd_13 = 'C14') * f_dist_13;


//*************************************************************************************//
// I have no idea how the reason code logic gets implemented in ECL, so everything below 
// probably needs to get changed or replaced.  The methodology for creating the reason codes is
// very similar to the logic used by the RiskView 4.0 scores, so you might want to consult
// that model code for guidance on implementing reason codes. 
//*************************************************************************************//

ds_layout := {STRING rc, REAL value};


 
//*************************************************************************************//
rc_dataset_f := DATASET([
    {'C22', f_rcvalueC22},
    {'A46', f_rcvalueA46},
    {'C21', f_rcvalueC21},
    {'D34', f_rcvalueD34},
    {'D33', f_rcvalueD33},
    {'A51', f_rcvalueA51},
    {'I60', f_rcvalueI60},
    {'C18', f_rcvalueC18},
    {'F01', f_rcvalueF01},
    {'I61', f_rcvalueI61},
    {'I62', f_rcvalueI62},
    {'C13', f_rcvalueC13},
    {'A42', f_rcvalueA42},
    {'C14', f_rcvalueC14}
    ], ds_layout)(value < 0);

//*************************************************************************************//
// IMPORTANT NOTE:  Select ONLY reason codes with an RCValue < 0.  I'll leave the 
//   implementation of this to the Engineer
//*************************************************************************************//
rc_dataset_f_sorted := sort(rc_dataset_f, rc_dataset_f.value);

f_rc1 := rc_dataset_f_sorted[1].rc;
f_rc2 := rc_dataset_f_sorted[2].rc;
f_rc3 := rc_dataset_f_sorted[3].rc;
f_rc4 := rc_dataset_f_sorted[4].rc;

f_vl1 := rc_dataset_f_sorted[1].value;
f_vl2 := rc_dataset_f_sorted[2].value;
f_vl3 := rc_dataset_f_sorted[3].value;
f_vl4 := rc_dataset_f_sorted[4].value;
//*************************************************************************************//

base := 700;

odds := (1 - 0.1118) / 0.1118;

point := 60;

iv_rv5_deceased := rc_decsflag = '1' 
                or rc_ssndod != 0 
								or (integer)indexw(StringLib.StringToUpperCase(trim(ver_sources, ALL)), 'DS', ',') > 0 
								or (integer)indexw(StringLib.StringToUpperCase(trim(ver_sources, ALL)), 'DE', ',') > 0;

iv_rv5_unscorable := if(riskview.constants.noscore(le.iid.nas_summary,le.iid.nap_summary, le.address_verification.input_address_information.naprop, le.truedid), '1', '0');

rvt1608_2_1 := map(
    (integer)iv_rv5_deceased > 0      => 200,
    (integer)iv_rv5_unscorable = 1    => 222,
                               min(if(max(round(point * (f_lnoddsscore - ln(odds)) / ln(2) + base), 501) = NULL, 
															        -NULL, 
																			max(round(point * (f_lnoddsscore - ln(odds)) / ln(2) + base), 501)
																		 ), 900)
								  );

rc1_2 := f_rc1;

rc2_2 := f_rc2;

rc3_2 := f_rc3;

rc4_2 := f_rc4;

_rc_inq := map(
    rv_i62_inq_addrs_per_adl > 0      => 'I62',
    rv_i62_inq_phones_per_adl > 0     => 'I62',
    rv_i61_inq_collection_count12 > 0 => 'I61',
    rv_i60_inq_hiriskcred_count12 > 0 => 'I60',
                                         '');

rc5_c46 := map(
    trim((string)rc1_2, LEFT, RIGHT) = '' => ' ',
    trim((string)rc2_2, LEFT, RIGHT) = '' => ' ',
    trim((string)rc3_2, LEFT, RIGHT) = '' => ' ',
    trim((string)rc4_2, LEFT, RIGHT) = '' => ' ',
                                             _rc_inq);

rc2_c46 := map(
    trim((string)rc1_2, LEFT, RIGHT) = '' => ' ',
    trim((string)rc2_2, LEFT, RIGHT) = '' => _rc_inq,
    trim((string)rc3_2, LEFT, RIGHT) = '' => ' ',
    trim((string)rc4_2, LEFT, RIGHT) = '' => ' ',
                                             ' ');

rc3_c46 := map(
    trim((string)rc1_2, LEFT, RIGHT) = '' => ' ',
    trim((string)rc2_2, LEFT, RIGHT) = '' => ' ',
    trim((string)rc3_2, LEFT, RIGHT) = '' => _rc_inq,
    trim((string)rc4_2, LEFT, RIGHT) = '' => ' ',
                                             ' ');

rc1_c46 := map(
    trim((string)rc1_2, LEFT, RIGHT) = '' => _rc_inq,
    trim((string)rc2_2, LEFT, RIGHT) = '' => ' ',
    trim((string)rc3_2, LEFT, RIGHT) = '' => ' ',
    trim((string)rc4_2, LEFT, RIGHT) = '' => ' ',
                                             ' ');

rc4_c46 := map(
    trim((string)rc1_2, LEFT, RIGHT) = '' => ' ',
    trim((string)rc2_2, LEFT, RIGHT) = '' => ' ',
    trim((string)rc3_2, LEFT, RIGHT) = '' => ' ',
    trim((string)rc4_2, LEFT, RIGHT) = '' => _rc_inq,
                                             ' ');

rc5_1 := if(rc5_c46 != '' and not((rc1_2 in ['I60', 'I61', 'I62'])) and not((rc2_2 in ['I60', 'I61', 'I62'])) and not((rc3_2 in ['I60', 'I61', 'I62'])) and not((rc4_2 in ['I60', 'I61', 'I62'])), rc5_c46, ' ');

rc2_1 := if(rc2_c46 != '' and not((rc1_2 in ['I60', 'I61', 'I62'])) and not((rc2_2 in ['I60', 'I61', 'I62'])) and not((rc3_2 in ['I60', 'I61', 'I62'])) and not((rc4_2 in ['I60', 'I61', 'I62'])), rc2_c46, rc2_2);

rc4_1 := if(rc4_c46 != '' and not((rc1_2 in ['I60', 'I61', 'I62'])) and not((rc2_2 in ['I60', 'I61', 'I62'])) and not((rc3_2 in ['I60', 'I61', 'I62'])) and not((rc4_2 in ['I60', 'I61', 'I62'])), rc4_c46, rc4_2);

rc3_1 := if(rc3_c46 != '' and not((rc1_2 in ['I60', 'I61', 'I62'])) and not((rc2_2 in ['I60', 'I61', 'I62'])) and not((rc3_2 in ['I60', 'I61', 'I62'])) and not((rc4_2 in ['I60', 'I61', 'I62'])), rc3_c46, rc3_2);

rc1_1 := if(rc1_c46 != '' and not((rc1_2 in ['I60', 'I61', 'I62'])) and not((rc2_2 in ['I60', 'I61', 'I62'])) and not((rc3_2 in ['I60', 'I61', 'I62'])) and not((rc4_2 in ['I60', 'I61', 'I62'])), rc1_c46, rc1_2);

rc5 := if((rvt1608_2_1 in [200, 222]), ' ', rc5_1);

rc2 := if((rvt1608_2_1 in [200, 222]), ' ', rc2_1);

rc4 := if((rvt1608_2_1 in [200, 222]), ' ', rc4_1);

rc1 := if((rvt1608_2_1 in [200, 222]), ' ', rc1_1);

rc3 := if((rvt1608_2_1 in [200, 222]), ' ', rc3_1);



	//*************************************************************************************//
	//                     RiskView Version 5 - RVT1608_2 Score Overrides
	//*************************************************************************************//
	// Deceased = 200
	// Unscorable = 222
	// Score Range: 501 - 900
	//*************************************************************************************//


//*************************************************************************************//
//                      RiskView Version 5 Reason Code Overrides 
//             ECL DEVELOPERS, MAKE SURE ALL RiskView V5 MODELS HAVE THIS
//*************************************************************************************//
HRILayout := RECORD
	STRING4 HRI := '';
END;
reasonsOverrides := MAP(
													// In Version 5 200 and 222 scores will not return reason codes, the will instead return alert codes
													RVT1608_2_1 = 200 => DATASET([{'00'}], HRILayout),
													RVT1608_2_1 = 222 => DATASET([{'00'}], HRILayout),
													RVT1608_2_1 = 900 => DATASET([{'00'}], HRILayout),
																				 			 DATASET([], HRILayout)
													);
reasons := DATASET([{rc1}, {rc2}, {rc3}, {rc4}, {rc5}], HRILayout);
// If we have score overrides use them, else use the normal reason codes
reasonsFinalTemp := IF(ut.Exists2(reasonsOverrides), 
										reasonsOverrides, 
										reasons) (HRI <> '');
zeros := DATASET([{'00'}, {'00'}, {'00'}, {'00'}, {'00'}], HRILayout);
reasonCodes := CHOOSEN(reasonsFinalTemp & zeros, 5);                             // Keep up to 5 reason codes

//*************************************************************************************//
//                   End RiskView Version 5 Reason Code Overrides
//*************************************************************************************//

	#if(MODEL_DEBUG)
		
		SELF.seq     := seq;

		SELF.sysdate := sysdate;
		
		self.rv_f00_dob_score                 := rv_f00_dob_score;
		
		SELF.rv_f01_inp_addr_address_score := rv_f01_inp_addr_address_score;
		SELF.rv_c21_stl_inq_count := rv_c21_stl_inq_count;
		SELF.rv_d33_eviction_recency := rv_d33_eviction_recency;
		SELF.rv_d34_unrel_liens_ct := rv_d34_unrel_liens_ct;
		SELF.rv_a46_curr_avm_autoval := rv_a46_curr_avm_autoval;
		SELF.rv_c14_addrs_15yr := rv_c14_addrs_15yr;
		SELF.rv_a41_a42_prop_owner_history := rv_a41_a42_prop_owner_history;
		SELF.rv_i61_inq_collection_count12 := rv_i61_inq_collection_count12;
		SELF.rv_i60_inq_hiriskcred_count12 := rv_i60_inq_hiriskcred_count12;
		SELF.rv_c18_invalid_addrs_per_adl := rv_c18_invalid_addrs_per_adl;
		
		SELF.rv_truedid := rv_truedid;
		SELF.rv_i62_inq_addrs_per_adl := rv_i62_inq_addrs_per_adl;
		SELF.rv_i62_inq_phones_per_adl := rv_i62_inq_phones_per_adl;
		SELF.f_subscore0 := f_subscore0;
		SELF.f_subscore1 := f_subscore1;
		SELF.f_subscore2 := f_subscore2;
		SELF.f_subscore3 := f_subscore3;
		SELF.f_subscore4 := f_subscore4;
		SELF.f_subscore5 := f_subscore5;
		SELF.f_subscore6 := f_subscore6;
		SELF.f_subscore7 := f_subscore7;
		SELF.f_subscore8 := f_subscore8;
		SELF.f_subscore9 := f_subscore9;
		SELF.f_subscore10 := f_subscore10;
		SELF.f_subscore11 := f_subscore11;
		SELF.f_subscore12 := f_subscore12;
		SELF.f_subscore13 := f_subscore13;
		SELF.f_rawscore := f_rawscore;
		SELF.f_lnoddsscore := f_lnoddsscore;
		SELF.f_probscore := f_probscore;
		SELF.f_aacd_0 := f_aacd_0;
		SELF.f_dist_0 := f_dist_0;
		SELF.f_aacd_1 := f_aacd_1;
		SELF.f_dist_1 := f_dist_1;
		SELF.f_aacd_2 := f_aacd_2;
		SELF.f_dist_2 := f_dist_2;
		SELF.f_aacd_3 := f_aacd_3;
		SELF.f_dist_3 := f_dist_3;
		SELF.f_aacd_4 := f_aacd_4;
		SELF.f_dist_4 := f_dist_4;
		SELF.f_aacd_5 := f_aacd_5;
		SELF.f_dist_5 := f_dist_5;
		SELF.f_aacd_6 := f_aacd_6;
		SELF.f_dist_6 := f_dist_6;
		SELF.f_aacd_7 := f_aacd_7;
		SELF.f_dist_7 := f_dist_7;
		SELF.f_aacd_8 := f_aacd_8;
		SELF.f_dist_8 := f_dist_8;
		SELF.f_aacd_9 := f_aacd_9;
		SELF.f_dist_9 := f_dist_9;
		SELF.f_aacd_10 := f_aacd_10;
		SELF.f_dist_10 := f_dist_10;
		SELF.f_aacd_11 := f_aacd_11;
		SELF.f_dist_11 := f_dist_11;
		SELF.f_aacd_12 := f_aacd_12;
		SELF.f_dist_12 := f_dist_12;
		SELF.f_aacd_13 := f_aacd_13;
		SELF.f_dist_13 := f_dist_13;

		SELF.base := base;
		SELF.odds := odds;
		SELF.point := point;
		SELF.iv_rv5_deceased := iv_rv5_deceased;
		SELF.iv_rv5_unscorable := iv_rv5_unscorable;
		SELF.rvt1608_2_1 := rvt1608_2_1;
	
	/* Reason codes */	
	
		SELF.f_rc1 := f_rc1;
		SELF.f_rc2 := f_rc2;
		SELF.f_rc3 := f_rc3;
		SELF.f_rc4 := f_rc4;
		SELF.f_vl1 := f_vl1;
		SELF.f_vl2 := f_vl2;
		SELF.f_vl3 := f_vl3;
		SELF.f_vl4 := f_vl4;

		SELF._rc_inq := _rc_inq;
		
		SELF.rc3 := rc3;
		SELF.rc2 := rc2;
		SELF.rc5 := rc5;
		SELF.rc4 := rc4;
		SELF.rc1 := rc1;

		SELF.clam := le;
	#else
		SELF.ri := PROJECT(reasonCodes, TRANSFORM(Risk_Indicators.Layout_Desc,
																							SELF.hri := LEFT.hri,
																							SELF.desc := Risk_Indicators.getHRIDesc(LEFT.hri)
																					));
		SELF.score := (STRING3)rvt1608_2_1;
		SELF.seq := le.seq;
	#end
	END;

	model := PROJECT(clam, doModel(LEFT));

	RETURN(model);
END;


IMPORT Models, Risk_Indicators, RiskWise, RiskWiseFCRA, RiskView, UT, riskview;

EXPORT RVT1608_1_0 (GROUPED DATASET(Risk_Indicators.Layout_Boca_Shell) clam) := FUNCTION

	MODEL_DEBUG := FALSE;

	#if(MODEL_DEBUG)
Layout_Debug := RECORD
			/* Model Input Variables */
			unsigned4 seq;
			BOOLEAN truedid;
			INTEGER nas_summary;
			INTEGER nap_summary;
			INTEGER rc_ssndod;
			STRING rc_decsflag;
			STRING ver_sources;
			BOOLEAN addrpop;
			INTEGER add_input_naprop;
			INTEGER add_curr_avm_auto_val;
			INTEGER addrs_15yr;
			INTEGER adls_per_addr_c6;
			INTEGER inq_collection_count12;
			INTEGER inq_other_count12;
			INTEGER inq_phonesperadl;
			INTEGER infutor_nap;
			INTEGER stl_inq_count;
			INTEGER attr_eviction_count;
			INTEGER attr_eviction_count90;
			INTEGER attr_eviction_count180;
			INTEGER attr_eviction_count12;
			INTEGER attr_eviction_count24;
			INTEGER attr_eviction_count36;
			INTEGER attr_eviction_count60;

			/* Model Intermediate Variables */

			INTEGER sysdate;
			INTEGER rv_c21_stl_inq_count;
			STRING rv_d33_eviction_recency;
			INTEGER rv_a46_curr_avm_autoval;
			INTEGER rv_c14_addrs_15yr;
			INTEGER rv_i61_inq_collection_count12;
			INTEGER rv_l79_adls_per_addr_c6;
			STRING rv_truedid;
			INTEGER rv_i60_inq_other_count12;
			INTEGER rv_i62_inq_phones_per_adl;
			REAL t_subscore0;
			REAL t_subscore1;
			REAL t_subscore2;
			REAL t_subscore3;
			REAL t_subscore4;
			REAL t_subscore5;
			REAL t_subscore6;
			REAL t_subscore7;
			REAL t_subscore8;
			REAL t_rawscore;
			REAL t_lnoddsscore;
			REAL t_probscore;
			STRING t_aacd_0;
			REAL t_dist_0;
			STRING t_aacd_1;
			REAL t_dist_1;
			STRING t_aacd_2;
			REAL t_dist_2;
			STRING t_aacd_3;
			REAL t_dist_3;
			STRING t_aacd_4;
			REAL t_dist_4;
			STRING t_aacd_5;
			REAL t_dist_5;
			STRING t_aacd_6;
			REAL t_dist_6;
			STRING t_aacd_7;
			REAL t_dist_7;
			STRING t_aacd_8;
			REAL t_dist_8;
			REAL t_rcvaluec22;
			REAL t_rcvaluea46;
			REAL t_rcvaluel79;
			REAL t_rcvalued33;
			REAL t_rcvaluea51;
			REAL t_rcvaluec21;
			REAL t_rcvaluei60;
			REAL t_rcvaluei61;
			REAL t_rcvaluei62;
			REAL t_rcvaluec13;
			REAL t_rcvaluec14;
			INTEGER base;
			REAL odds;
			INTEGER point;
			BOOLEAN iv_rv5_deceased;
			STRING iv_rv5_unscorable;
			INTEGER rvt1608_1_0;

			// STRING rc_dataset_t;
			// STRING rc_dataset_t_sorted;
			STRING t_rc1;
			STRING t_rc2;
			STRING t_rc3;
			STRING t_rc4;
			REAL t_vl1;
			REAL t_vl2;
			REAL t_vl3;
			REAL t_vl4;
			STRING rc1_2;
			STRING rc2_2;
			STRING rc3_2;
			STRING rc4_2;
			STRING _rc_inq;
			STRING rc2_c31;
			STRING rc4_c31;
			STRING rc1_c31;
			STRING rc3_c31;
			STRING rc5_c31;
			STRING rc2_1;
			STRING rc4_1;
			STRING rc1_1;
			STRING rc3_1;
			STRING rc5_1;
			STRING rc4;
			STRING rc2;
			STRING rc3;
			STRING rc5;
			STRING rc1;

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
	ver_sources                      := le.header_summary.ver_sources;
	addrpop                          := le.input_validation.address;
	add_input_naprop                 := le.address_verification.input_address_information.naprop;
	add_curr_avm_auto_val            := le.avm.address_history_1.avm_automated_valuation;
	addrs_15yr                       := le.other_address_info.addrs_last_15years;
	adls_per_addr_c6                 := le.velocity_counters.adls_per_addr_created_6months;
	inq_collection_count12           := le.acc_logs.collection.count12;
	inq_other_count12                := le.acc_logs.other.count12;
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

	/* ***********************************************************
	 *                    Generated ECL                          *
	 ************************************************************* */

	NULL := -999999999;
	
	
	BOOLEAN indexw(string source, string target, string delim) :=
		(source = target) OR
		(StringLib.StringFind(source, delim + target + delim, 1) > 0) OR
		(source[1..length(target)+1] = target + delim) OR
		(StringLib.StringReverse(source)[1..length(target)+1] = StringLib.StringReverse(target) + delim);
	
	sysdate := common.sas_date(if(le.historydate=999999, (string)ut.getdate, (string6)le.historydate+'01'));
	
	rv_c21_stl_inq_count := if(not(truedid), NULL, min(if(STL_Inq_count = NULL, -NULL, STL_Inq_count), 999));
	
	rv_d33_eviction_recency := map(
	    not(truedid)                                                => '  ',
	    attr_eviction_count90  > 0                                  => '03',
	    attr_eviction_count180  > 0                                 => '06',
	    attr_eviction_count12  > 0                                  => '12',
	    attr_eviction_count24 > 0 and attr_eviction_count >= 2 			=> '24',
	    attr_eviction_count24  > 0                                  => '25',
	    attr_eviction_count36 > 0 and attr_eviction_count >= 2 			=> '36',
	    attr_eviction_count36  > 0                                  => '37',
	    attr_eviction_count60 > 0 and attr_eviction_count >= 2 			=> '60',
	    attr_eviction_count60  > 0                                  => '61',
	    attr_eviction_count >= 2                                    => '98',
	    attr_eviction_count >= 1                                    => '99',
	                                                                   '00');
	
	rv_a46_curr_avm_autoval := if(not(truedid), NULL, add_curr_avm_auto_val);
	
	rv_c14_addrs_15yr := if(not(truedid), NULL, min(if(addrs_15yr = NULL, -NULL, addrs_15yr), 999));
	
	rv_i61_inq_collection_count12 := if(not(truedid), NULL, min(if(inq_collection_count12 = NULL, -NULL, inq_collection_count12), 999));
	
	rv_l79_adls_per_addr_c6 := if(not(addrpop), NULL, min(if(adls_per_addr_c6 = NULL, -NULL, adls_per_addr_c6), 999));
	
	rv_truedid := Map(truedid => '1',
										~truedid => '0',
										'0');
	
	rv_i60_inq_other_count12 := if(not(truedid), NULL, min(if(inq_other_count12 = NULL, -NULL, inq_other_count12), 999));
	
	rv_i62_inq_phones_per_adl := if(not(truedid), NULL, min(if(inq_phonesperadl = NULL, -NULL, inq_phonesperadl), 999));
	
	t_subscore0 := map(
	    NULL < rv_c14_addrs_15yr AND rv_c14_addrs_15yr < 1 => 0.373693,
	    1 <= rv_c14_addrs_15yr AND rv_c14_addrs_15yr < 2   => 0.26725,
	    2 <= rv_c14_addrs_15yr AND rv_c14_addrs_15yr < 3   => -0.111006,
	    3 <= rv_c14_addrs_15yr                             => -0.2515,
	                                                          0);
	
	t_subscore1 := map(
	    NULL < rv_a46_curr_avm_autoval AND rv_a46_curr_avm_autoval < 1         => 0.02313,
	    1 <= rv_a46_curr_avm_autoval AND rv_a46_curr_avm_autoval < 66110       => -0.348615,
	    66110 <= rv_a46_curr_avm_autoval AND rv_a46_curr_avm_autoval < 92456   => -0.240688,
	    92456 <= rv_a46_curr_avm_autoval AND rv_a46_curr_avm_autoval < 167877  => -0.055999,
	    167877 <= rv_a46_curr_avm_autoval AND rv_a46_curr_avm_autoval < 207187 => 0.050647,
	    207187 <= rv_a46_curr_avm_autoval AND rv_a46_curr_avm_autoval < 243166 => 0.193929,
	    243166 <= rv_a46_curr_avm_autoval AND rv_a46_curr_avm_autoval < 303221 => 0.369711,
	    303221 <= rv_a46_curr_avm_autoval                                      => 0.464795,
	                                                                              0);
	
	t_subscore2 := map(
	    NULL < rv_i62_inq_phones_per_adl AND rv_i62_inq_phones_per_adl < 1 => 0.096805,
	    1 <= rv_i62_inq_phones_per_adl AND rv_i62_inq_phones_per_adl < 2   => -0.168298,
	    2 <= rv_i62_inq_phones_per_adl AND rv_i62_inq_phones_per_adl < 3   => -0.371373,
	    3 <= rv_i62_inq_phones_per_adl                                     => -0.596167,
	                                                                          0);
	
	t_subscore3 := map(
	    (rv_truedid in ['0']) => 1.036479,
	    (rv_truedid in ['1']) => -0.027155,
	                             0);
	
	t_subscore4 := map(
	    (rv_d33_eviction_recency in [' '])                          => 0,
	    (rv_d33_eviction_recency in ['00'])                         => 0.042777,
	    (rv_d33_eviction_recency in ['03', '06', '12'])             => -0.594852,
	    (rv_d33_eviction_recency in ['24'])                         => -0.340746,
	    (rv_d33_eviction_recency in ['25', '36'])                   => -0.233208,
	    (rv_d33_eviction_recency in ['37', '60', '61', '98', '99']) => -0.217826,
	                                                                   0);
	
	t_subscore5 := map(
	    NULL < rv_l79_adls_per_addr_c6 AND rv_l79_adls_per_addr_c6 < 1 => 0.056481,
	    1 <= rv_l79_adls_per_addr_c6 AND rv_l79_adls_per_addr_c6 < 2   => -0.030381,
	    2 <= rv_l79_adls_per_addr_c6                                   => -0.123507,
	                                                                      0);
	
	t_subscore6 := map(
	    NULL < rv_c21_stl_inq_count AND rv_c21_stl_inq_count < 1 => 0.01462,
	    1 <= rv_c21_stl_inq_count                                => -0.222673,
	                                                                0);
	
	t_subscore7 := map(
	    NULL < rv_i60_inq_other_count12 AND rv_i60_inq_other_count12 < 1 => 0.012787,
	    1 <= rv_i60_inq_other_count12                                    => -0.248169,
	                                                                        0);
	
	t_subscore8 := map(
	    NULL < rv_i61_inq_collection_count12 AND rv_i61_inq_collection_count12 < 1 => 0.007026,
	    1 <= rv_i61_inq_collection_count12                                         => -0.209995,
	                                                                                  0);
	
	t_rawscore := t_subscore0 +
	    t_subscore1 +
	    t_subscore2 +
	    t_subscore3 +
	    t_subscore4 +
	    t_subscore5 +
	    t_subscore6 +
	    t_subscore7 +
	    t_subscore8;
	
	t_lnoddsscore := t_rawscore + 0.832921;
	
	t_probscore := exp(t_lnoddsscore) / (1 + exp(t_lnoddsscore));
	
	t_aacd_0 := map(
	    NULL < rv_c14_addrs_15yr AND rv_c14_addrs_15yr < 1 => 'C13',
	    1 <= rv_c14_addrs_15yr AND rv_c14_addrs_15yr < 2   => 'C14',
	    2 <= rv_c14_addrs_15yr AND rv_c14_addrs_15yr < 3   => 'C14',
	    3 <= rv_c14_addrs_15yr                             => 'C14',
	                                                          'C13');
	
	t_dist_0 := t_subscore0 - 0.373693;
	
	t_aacd_1 := map(
	    NULL < rv_a46_curr_avm_autoval AND rv_a46_curr_avm_autoval < 1         => 'A51',
	    1 <= rv_a46_curr_avm_autoval AND rv_a46_curr_avm_autoval < 66110       => 'A46',
	    66110 <= rv_a46_curr_avm_autoval AND rv_a46_curr_avm_autoval < 92456   => 'A46',
	    92456 <= rv_a46_curr_avm_autoval AND rv_a46_curr_avm_autoval < 167877  => 'A46',
	    167877 <= rv_a46_curr_avm_autoval AND rv_a46_curr_avm_autoval < 207187 => 'A46',
	    207187 <= rv_a46_curr_avm_autoval AND rv_a46_curr_avm_autoval < 243166 => 'A46',
	    243166 <= rv_a46_curr_avm_autoval AND rv_a46_curr_avm_autoval < 303221 => 'A46',
	    303221 <= rv_a46_curr_avm_autoval                                      => 'A46',
	                                                                              '');
	
	t_dist_1 := t_subscore1 - 0.464795;
	
	t_aacd_2 := map(
	    NULL < rv_i62_inq_phones_per_adl AND rv_i62_inq_phones_per_adl < 1 => 'I62',
	    1 <= rv_i62_inq_phones_per_adl AND rv_i62_inq_phones_per_adl < 2   => 'I62',
	    2 <= rv_i62_inq_phones_per_adl AND rv_i62_inq_phones_per_adl < 3   => 'I62',
	    3 <= rv_i62_inq_phones_per_adl                                     => 'I62',
	                                                                          '');
	
	t_dist_2 := t_subscore2 - 0.096805;
	
	t_aacd_3 := map(
	    (rv_truedid in ['0']) => 'C22',
	    (rv_truedid in ['1']) => '',
	                             'C22');
	
	t_dist_3 := t_subscore3 - 1.036479;
	
	t_aacd_4 := map(
	    (rv_d33_eviction_recency in [' '])                          => '',
	    (rv_d33_eviction_recency in ['00'])                         => 'D33',
	    (rv_d33_eviction_recency in ['03', '06', '12'])             => 'D33',
	    (rv_d33_eviction_recency in ['24'])                         => 'D33',
	    (rv_d33_eviction_recency in ['25', '36'])                   => 'D33',
	    (rv_d33_eviction_recency in ['37', '60', '61', '98', '99']) => 'D33',
	                                                                   '');
	
	t_dist_4 := t_subscore4 - 0.042777;
	
	t_aacd_5 := map(
	    NULL < rv_l79_adls_per_addr_c6 AND rv_l79_adls_per_addr_c6 < 1 => 'L79',
	    1 <= rv_l79_adls_per_addr_c6 AND rv_l79_adls_per_addr_c6 < 2   => 'L79',
	    2 <= rv_l79_adls_per_addr_c6                                   => 'L79',
	                                                                      '');
	
	t_dist_5 := t_subscore5 - 0.056481;
	
	t_aacd_6 := map(
	    NULL < rv_c21_stl_inq_count AND rv_c21_stl_inq_count < 1 => 'C21',
	    1 <= rv_c21_stl_inq_count                                => 'C21',
	                                                                '');
	
	t_dist_6 := t_subscore6 - 0.01462;
	
	t_aacd_7 := map(
	    NULL < rv_i60_inq_other_count12 AND rv_i60_inq_other_count12 < 1 => 'I60',
	    1 <= rv_i60_inq_other_count12                                    => 'I60',
	                                                                        '');
	
	t_dist_7 := t_subscore7 - 0.012787;
	
	t_aacd_8 := map(
	    NULL < rv_i61_inq_collection_count12 AND rv_i61_inq_collection_count12 < 1 => 'I61',
	    1 <= rv_i61_inq_collection_count12                                         => 'I61',
	                                                                                  '');
	
	t_dist_8 := t_subscore8 - 0.007026;
	
	t_rcvaluec22 := (integer)(t_aacd_0 = 'C22') * t_dist_0 +
	    (integer)(t_aacd_1 = 'C22') * t_dist_1 +
	    (integer)(t_aacd_2 = 'C22') * t_dist_2 +
	    (integer)(t_aacd_3 = 'C22') * t_dist_3 +
	    (integer)(t_aacd_4 = 'C22') * t_dist_4 +
	    (integer)(t_aacd_5 = 'C22') * t_dist_5 +
	    (integer)(t_aacd_6 = 'C22') * t_dist_6 +
	    (integer)(t_aacd_7 = 'C22') * t_dist_7 +
	    (integer)(t_aacd_8 = 'C22') * t_dist_8;
	
	t_rcvaluea46 := (integer)(t_aacd_0 = 'A46') * t_dist_0 +
	    (integer)(t_aacd_1 = 'A46') * t_dist_1 +
	    (integer)(t_aacd_2 = 'A46') * t_dist_2 +
	    (integer)(t_aacd_3 = 'A46') * t_dist_3 +
	    (integer)(t_aacd_4 = 'A46') * t_dist_4 +
	    (integer)(t_aacd_5 = 'A46') * t_dist_5 +
	    (integer)(t_aacd_6 = 'A46') * t_dist_6 +
	    (integer)(t_aacd_7 = 'A46') * t_dist_7 +
	    (integer)(t_aacd_8 = 'A46') * t_dist_8;
	
	t_rcvaluel79 := (integer)(t_aacd_0 = 'L79') * t_dist_0 +
	    (integer)(t_aacd_1 = 'L79') * t_dist_1 +
	    (integer)(t_aacd_2 = 'L79') * t_dist_2 +
	    (integer)(t_aacd_3 = 'L79') * t_dist_3 +
	    (integer)(t_aacd_4 = 'L79') * t_dist_4 +
	    (integer)(t_aacd_5 = 'L79') * t_dist_5 +
	    (integer)(t_aacd_6 = 'L79') * t_dist_6 +
	    (integer)(t_aacd_7 = 'L79') * t_dist_7 +
	    (integer)(t_aacd_8 = 'L79') * t_dist_8;
	
	t_rcvalued33 := (integer)(t_aacd_0 = 'D33') * t_dist_0 +
	    (integer)(t_aacd_1 = 'D33') * t_dist_1 +
	    (integer)(t_aacd_2 = 'D33') * t_dist_2 +
	    (integer)(t_aacd_3 = 'D33') * t_dist_3 +
	    (integer)(t_aacd_4 = 'D33') * t_dist_4 +
	    (integer)(t_aacd_5 = 'D33') * t_dist_5 +
	    (integer)(t_aacd_6 = 'D33') * t_dist_6 +
	    (integer)(t_aacd_7 = 'D33') * t_dist_7 +
	    (integer)(t_aacd_8 = 'D33') * t_dist_8;
	
	t_rcvaluea51 := (integer)(t_aacd_0 = 'A51') * t_dist_0 +
	    (integer)(t_aacd_1 = 'A51') * t_dist_1 +
	    (integer)(t_aacd_2 = 'A51') * t_dist_2 +
	    (integer)(t_aacd_3 = 'A51') * t_dist_3 +
	    (integer)(t_aacd_4 = 'A51') * t_dist_4 +
	    (integer)(t_aacd_5 = 'A51') * t_dist_5 +
	    (integer)(t_aacd_6 = 'A51') * t_dist_6 +
	    (integer)(t_aacd_7 = 'A51') * t_dist_7 +
	    (integer)(t_aacd_8 = 'A51') * t_dist_8;
	
	t_rcvaluec21 := (integer)(t_aacd_0 = 'C21') * t_dist_0 +
	    (integer)(t_aacd_1 = 'C21') * t_dist_1 +
	    (integer)(t_aacd_2 = 'C21') * t_dist_2 +
	    (integer)(t_aacd_3 = 'C21') * t_dist_3 +
	    (integer)(t_aacd_4 = 'C21') * t_dist_4 +
	    (integer)(t_aacd_5 = 'C21') * t_dist_5 +
	    (integer)(t_aacd_6 = 'C21') * t_dist_6 +
	    (integer)(t_aacd_7 = 'C21') * t_dist_7 +
	    (integer)(t_aacd_8 = 'C21') * t_dist_8;
	
	t_rcvaluei60 := (integer)(t_aacd_0 = 'I60') * t_dist_0 +
	    (integer)(t_aacd_1 = 'I60') * t_dist_1 +
	    (integer)(t_aacd_2 = 'I60') * t_dist_2 +
	    (integer)(t_aacd_3 = 'I60') * t_dist_3 +
	    (integer)(t_aacd_4 = 'I60') * t_dist_4 +
	    (integer)(t_aacd_5 = 'I60') * t_dist_5 +
	    (integer)(t_aacd_6 = 'I60') * t_dist_6 +
	    (integer)(t_aacd_7 = 'I60') * t_dist_7 +
	    (integer)(t_aacd_8 = 'I60') * t_dist_8;
	
	t_rcvaluei61 := (integer)(t_aacd_0 = 'I61') * t_dist_0 +
	    (integer)(t_aacd_1 = 'I61') * t_dist_1 +
	    (integer)(t_aacd_2 = 'I61') * t_dist_2 +
	    (integer)(t_aacd_3 = 'I61') * t_dist_3 +
	    (integer)(t_aacd_4 = 'I61') * t_dist_4 +
	    (integer)(t_aacd_5 = 'I61') * t_dist_5 +
	    (integer)(t_aacd_6 = 'I61') * t_dist_6 +
	    (integer)(t_aacd_7 = 'I61') * t_dist_7 +
	    (integer)(t_aacd_8 = 'I61') * t_dist_8;
	
	t_rcvaluei62 := (integer)(t_aacd_0 = 'I62') * t_dist_0 +
	    (integer)(t_aacd_1 = 'I62') * t_dist_1 +
	    (integer)(t_aacd_2 = 'I62') * t_dist_2 +
	    (integer)(t_aacd_3 = 'I62') * t_dist_3 +
	    (integer)(t_aacd_4 = 'I62') * t_dist_4 +
	    (integer)(t_aacd_5 = 'I62') * t_dist_5 +
	    (integer)(t_aacd_6 = 'I62') * t_dist_6 +
	    (integer)(t_aacd_7 = 'I62') * t_dist_7 +
	    (integer)(t_aacd_8 = 'I62') * t_dist_8;
	
	t_rcvaluec13 := (integer)(t_aacd_0 = 'C13') * t_dist_0 +
	    (integer)(t_aacd_1 = 'C13') * t_dist_1 +
	    (integer)(t_aacd_2 = 'C13') * t_dist_2 +
	    (integer)(t_aacd_3 = 'C13') * t_dist_3 +
	    (integer)(t_aacd_4 = 'C13') * t_dist_4 +
	    (integer)(t_aacd_5 = 'C13') * t_dist_5 +
	    (integer)(t_aacd_6 = 'C13') * t_dist_6 +
	    (integer)(t_aacd_7 = 'C13') * t_dist_7 +
	    (integer)(t_aacd_8 = 'C13') * t_dist_8;
	
	t_rcvaluec14 := (integer)(t_aacd_0 = 'C14') * t_dist_0 +
	    (integer)(t_aacd_1 = 'C14') * t_dist_1 +
	    (integer)(t_aacd_2 = 'C14') * t_dist_2 +
	    (integer)(t_aacd_3 = 'C14') * t_dist_3 +
	    (integer)(t_aacd_4 = 'C14') * t_dist_4 +
	    (integer)(t_aacd_5 = 'C14') * t_dist_5 +
	    (integer)(t_aacd_6 = 'C14') * t_dist_6 +
	    (integer)(t_aacd_7 = 'C14') * t_dist_7 +
	    (integer)(t_aacd_8 = 'C14') * t_dist_8;
	
	base := 700;
	
	odds := (1 - 0.2505) / 0.2505;
	
	point := 60;
	
	iv_rv5_deceased := rc_decsflag = '1' or rc_ssndod != 0 or (integer)indexw(StringLib.StringToUpperCase(trim(ver_sources, ALL)), 'DS', ',') > 0 or (integer)indexw(StringLib.StringToUpperCase(trim(ver_sources, ALL)), 'DE', ',') > 0;
	
	iv_rv5_unscorable := if(riskview.constants.noscore(le.iid.nas_summary,le.iid.nap_summary, le.address_verification.input_address_information.naprop, le.truedid), '1', '0');
	
	rvt1608_1_0 := map(
	    iv_rv5_deceased 		     	=> 200,
	    iv_rv5_unscorable = '1' 	=> 222,
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
	    {'C22', t_rcvalueC22},
	    {'A46', t_rcvalueA46},
	    {'L79', t_rcvalueL79},
	    {'D33', t_rcvalueD33},
	    {'A51', t_rcvalueA51},
	    {'C21', t_rcvalueC21},
	    {'I60', t_rcvalueI60},
	    {'I61', t_rcvalueI61},
	    {'I62', t_rcvalueI62},
	    {'C13', t_rcvalueC13},
	    {'C14', t_rcvalueC14}
	    ], ds_layout)(value < 0);  // (value < 0);
	
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
	
	rc1_2 := t_rc1;
	
	rc2_2 := t_rc2;
	
	rc3_2 := t_rc3;
	
	rc4_2 := t_rc4;
	
	_rc_inq := map(
	    rv_i62_inq_phones_per_adl > 0     => 'I62',
	    rv_i61_inq_collection_count12 > 0 => 'I61',
	    rv_i60_inq_other_count12 > 0      => 'I60',
	                                         '');
	
	rc2_c31 := map(
	    trim((string)rc1_2, LEFT, RIGHT) = '' => '',
	    trim((string)rc2_2, LEFT, RIGHT) = '' => _rc_inq,
	    trim((string)rc3_2, LEFT, RIGHT) = '' => '',
	    trim((string)rc4_2, LEFT, RIGHT) = '' => '',
	                                             '');
	
	rc4_c31 := map(
	    trim((string)rc1_2, LEFT, RIGHT) = '' => '',
	    trim((string)rc2_2, LEFT, RIGHT) = '' => '',
	    trim((string)rc3_2, LEFT, RIGHT) = '' => '',
	    trim((string)rc4_2, LEFT, RIGHT) = '' => _rc_inq,
	                                             '');
	
	rc1_c31 := map(
	    trim((string)rc1_2, LEFT, RIGHT) = '' => _rc_inq,
	    trim((string)rc2_2, LEFT, RIGHT) = '' => '',
	    trim((string)rc3_2, LEFT, RIGHT) = '' => '',
	    trim((string)rc4_2, LEFT, RIGHT) = '' => '',
	                                             '');
	
	rc3_c31 := map(
	    trim((string)rc1_2, LEFT, RIGHT) = '' => '',
	    trim((string)rc2_2, LEFT, RIGHT) = '' => '',
	    trim((string)rc3_2, LEFT, RIGHT) = '' => _rc_inq,
	    trim((string)rc4_2, LEFT, RIGHT) = '' => '',
	                                             '');
	
	rc5_c31 := map(
	    trim((string)rc1_2, LEFT, RIGHT) = '' => '',
	    trim((string)rc2_2, LEFT, RIGHT) = '' => '',
	    trim((string)rc3_2, LEFT, RIGHT) = '' => '',
	    trim((string)rc4_2, LEFT, RIGHT) = '' => '',
	                                             _rc_inq);
	
	rc2_1 := if(not((rc1_2 in ['I60', 'I61', 'I62'])) and 
							not((rc2_2 in ['I60', 'I61', 'I62'])) and 
							not((rc3_2 in ['I60', 'I61', 'I62'])) and 
							not((rc4_2 in ['I60', 'I61', 'I62'])) and  
							rc2_c31 <> '', rc2_c31, rc2_2);
	
	rc4_1 := if(not((rc1_2 in ['I60', 'I61', 'I62'])) and 
							not((rc2_2 in ['I60', 'I61', 'I62'])) and 
							not((rc3_2 in ['I60', 'I61', 'I62'])) and 
							not((rc4_2 in ['I60', 'I61', 'I62'])) and 
							rc4_c31  <> '', rc4_c31, rc4_2);
	
	rc1_1 := if(not((rc1_2 in ['I60', 'I61', 'I62'])) and 
							not((rc2_2 in ['I60', 'I61', 'I62'])) and 
							not((rc3_2 in ['I60', 'I61', 'I62'])) and 
							not((rc4_2 in ['I60', 'I61', 'I62'])) and
							rc1_c31  <> '', rc1_c31, rc1_2);
	
	rc3_1 := if(not((rc1_2 in ['I60', 'I61', 'I62'])) and 
							not((rc2_2 in ['I60', 'I61', 'I62'])) and 
							not((rc3_2 in ['I60', 'I61', 'I62'])) and 
							not((rc4_2 in ['I60', 'I61', 'I62'])) and 
							rc3_c31  <> '', rc3_c31, rc3_2);
	
	rc5_1 := if(not((rc1_2 in ['I60', 'I61', 'I62'])) and 
							not((rc2_2 in ['I60', 'I61', 'I62'])) and 
							not((rc3_2 in ['I60', 'I61', 'I62'])) and 
							not((rc4_2 in ['I60', 'I61', 'I62'])) and 
							rc5_c31  <> '', rc5_c31, '');
	
	rc4 := if((rvt1608_1_0 in [200, 222]), '', rc4_1);
	
	rc2 := if((rvt1608_1_0 in [200, 222]), '', rc2_1);
	
	rc3 := if((rvt1608_1_0 in [200, 222]), '', rc3_1);
	
	rc5 := if((rvt1608_1_0 in [200, 222]), '', rc5_1);
	
	rc1 := if((rvt1608_1_0 in [200, 222]), '', rc1_1);
	


	//*************************************************************************************//
	//                     RiskView Version 5 - RVT1608_1 Score Overrides
	//*************************************************************************************//
	// Deceased = 200
	// Unscorable = 222
	// Score Range: 501 - 900
	//*************************************************************************************//


//*************************************************************************************//
//                      RiskView Version 5 Reason Code Overrides 
//*************************************************************************************//
HRILayout := RECORD
	STRING4 HRI := '';
END;
reasonsOverrides := MAP(
													// In Version 5 200 and 222 scores will not return reason codes, the will instead return alert codes
													RVT1608_1_0 = 200 => DATASET([{'00'}], HRILayout),
													RVT1608_1_0 = 222 => DATASET([{'00'}], HRILayout),
													RVT1608_1_0 = 900 => DATASET([{'00'}], HRILayout),
																							DATASET([], HRILayout)
													);
reasons := DATASET([{rc1}, {rc2}, {rc3}, {rc4}, {rc5}], HRILayout);
// If we have score overrides use them, else use the normal reason codes
reasonsFinalTemp := IF(ut.Exists2(reasonsOverrides), 
										reasonsOverrides, 
										reasons) (HRI <> '');
zeros := DATASET([{'00'}, {'00'}, {'00'}, {'00'}, {'00'}], HRILayout);
reasonCodes := CHOOSEN(reasonsFinalTemp & zeros, 5); // Keep up to 5 reason codes

//*************************************************************************************//
//                   End RiskView Version 5 Reason Code Overrides
//*************************************************************************************//

	#if(MODEL_DEBUG)
		/* Model Input Variables */
		SELF.seq     := seq;
		SELF.truedid := truedid;
		SELF.nas_summary := nas_summary;
		SELF.nap_summary := nap_summary;
		SELF.rc_ssndod := rc_ssndod;
		SELF.rc_decsflag := rc_decsflag;
		SELF.ver_sources := ver_sources;
		SELF.addrpop := addrpop;
		SELF.add_input_naprop := add_input_naprop;
		SELF.add_curr_avm_auto_val := add_curr_avm_auto_val;
		SELF.addrs_15yr := addrs_15yr;
		SELF.adls_per_addr_c6 := adls_per_addr_c6;
		SELF.inq_collection_count12 := inq_collection_count12;
		SELF.inq_other_count12 := inq_other_count12;
		SELF.inq_phonesperadl := inq_phonesperadl;
		SELF.infutor_nap := infutor_nap;
		SELF.stl_inq_count := stl_inq_count;
		SELF.attr_eviction_count := attr_eviction_count;
		SELF.attr_eviction_count90 := attr_eviction_count90;
		SELF.attr_eviction_count180 := attr_eviction_count180;
		SELF.attr_eviction_count12 := attr_eviction_count12;
		SELF.attr_eviction_count24 := attr_eviction_count24;
		SELF.attr_eviction_count36 := attr_eviction_count36;
		SELF.attr_eviction_count60 := attr_eviction_count60;

		/* Model Intermediate Variables */
		// SELF.NULL := NULL;
		// SELF.BOOLEAN indexw(string source, string target, string delim) := BOOLEAN indexw(string source, string target, string delim);
		SELF.sysdate := sysdate;
		SELF.rv_c21_stl_inq_count := rv_c21_stl_inq_count;
		SELF.rv_d33_eviction_recency := rv_d33_eviction_recency;
		SELF.rv_a46_curr_avm_autoval := rv_a46_curr_avm_autoval;
		SELF.rv_c14_addrs_15yr := rv_c14_addrs_15yr;
		SELF.rv_i61_inq_collection_count12 := rv_i61_inq_collection_count12;
		SELF.rv_l79_adls_per_addr_c6 := rv_l79_adls_per_addr_c6;
		SELF.rv_truedid := rv_truedid;
		SELF.rv_i60_inq_other_count12 := rv_i60_inq_other_count12;
		SELF.rv_i62_inq_phones_per_adl := rv_i62_inq_phones_per_adl;
		SELF.t_subscore0 := t_subscore0;
		SELF.t_subscore1 := t_subscore1;
		SELF.t_subscore2 := t_subscore2;
		SELF.t_subscore3 := t_subscore3;
		SELF.t_subscore4 := t_subscore4;
		SELF.t_subscore5 := t_subscore5;
		SELF.t_subscore6 := t_subscore6;
		SELF.t_subscore7 := t_subscore7;
		SELF.t_subscore8 := t_subscore8;
		SELF.t_rawscore := t_rawscore;
		SELF.t_lnoddsscore := t_lnoddsscore;
		SELF.t_probscore := t_probscore;
		SELF.t_aacd_0 := t_aacd_0;
		SELF.t_dist_0 := t_dist_0;
		SELF.t_aacd_1 := t_aacd_1;
		SELF.t_dist_1 := t_dist_1;
		SELF.t_aacd_2 := t_aacd_2;
		SELF.t_dist_2 := t_dist_2;
		SELF.t_aacd_3 := t_aacd_3;
		SELF.t_dist_3 := t_dist_3;
		SELF.t_aacd_4 := t_aacd_4;
		SELF.t_dist_4 := t_dist_4;
		SELF.t_aacd_5 := t_aacd_5;
		SELF.t_dist_5 := t_dist_5;
		SELF.t_aacd_6 := t_aacd_6;
		SELF.t_dist_6 := t_dist_6;
		SELF.t_aacd_7 := t_aacd_7;
		SELF.t_dist_7 := t_dist_7;
		SELF.t_aacd_8 := t_aacd_8;
		SELF.t_dist_8 := t_dist_8;
		SELF.t_rcvaluec22 := t_rcvaluec22;
		SELF.t_rcvaluea46 := t_rcvaluea46;
		SELF.t_rcvaluel79 := t_rcvaluel79;
		SELF.t_rcvalued33 := t_rcvalued33;
		SELF.t_rcvaluea51 := t_rcvaluea51;
		SELF.t_rcvaluec21 := t_rcvaluec21;
		SELF.t_rcvaluei60 := t_rcvaluei60;
		SELF.t_rcvaluei61 := t_rcvaluei61;
		SELF.t_rcvaluei62 := t_rcvaluei62;
		SELF.t_rcvaluec13 := t_rcvaluec13;
		SELF.t_rcvaluec14 := t_rcvaluec14;
		SELF.base := base;
		SELF.odds := odds;
		SELF.point := point;
		SELF.iv_rv5_deceased := iv_rv5_deceased;
		SELF.iv_rv5_unscorable := iv_rv5_unscorable;
		SELF.rvt1608_1_0 := rvt1608_1_0;
		// SELF.ds_layout := ds_layout;
		// SELF.rc_dataset_t := rc_dataset_t;
		// SELF.rc_dataset_t_sorted := rc_dataset_t_sorted;
		SELF.t_rc1 := t_rc1;
		SELF.t_rc2 := t_rc2;
		SELF.t_rc3 := t_rc3;
		SELF.t_rc4 := t_rc4;
		SELF.t_vl1 := t_vl1;
		SELF.t_vl2 := t_vl2;
		SELF.t_vl3 := t_vl3;
		SELF.t_vl4 := t_vl4;
		SELF.rc1_2 := rc1_2;
		SELF.rc2_2 := rc2_2;
		SELF.rc3_2 := rc3_2;
		SELF.rc4_2 := rc4_2;
		SELF._rc_inq := _rc_inq;
		SELF.rc2_c31 := rc2_c31;
		SELF.rc4_c31 := rc4_c31;
		SELF.rc1_c31 := rc1_c31;
		SELF.rc3_c31 := rc3_c31;
		SELF.rc5_c31 := rc5_c31;
		SELF.rc2_1 := rc2_1;
		SELF.rc4_1 := rc4_1;
		SELF.rc1_1 := rc1_1;
		SELF.rc3_1 := rc3_1;
		SELF.rc5_1 := rc5_1;
		SELF.rc4 := rc4;
		SELF.rc2 := rc2;
		SELF.rc3 := rc3;
		SELF.rc5 := rc5;
		SELF.rc1 := rc1;

		// SELF.rc1 := reasonCodes[1].hri;
		// SELF.rc2 := reasonCodes[2].hri;
		// SELF.rc3 := reasonCodes[3].hri;
		// SELF.rc4 := reasonCodes[4].hri;
		// SELF.rc5 := reasonCodes[5].hri;

		SELF.clam := le;
	#else
		SELF.ri := PROJECT(reasonCodes, TRANSFORM(Risk_Indicators.Layout_Desc,
																							SELF.hri := LEFT.hri,
																							SELF.desc := Risk_Indicators.getHRIDesc(LEFT.hri)
																					));
		SELF.score := (STRING3)rvt1608_1_0;
		SELF.seq := le.seq;
	#end
	END;

	model := PROJECT(clam, doModel(LEFT));

	RETURN(model);
END;

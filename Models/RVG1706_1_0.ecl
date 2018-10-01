IMPORT Models, Risk_Indicators, RiskWise, RiskWiseFCRA, RiskView, UT, Std,riskview;

EXPORT RVG1706_1_0 (GROUPED DATASET(Risk_Indicators.Layout_Boca_Shell) clam) := FUNCTION

	MODEL_DEBUG        := FALSE;

	#if(MODEL_DEBUG)
Layout_Debug := RECORD
			
			unsigned4 seq;
			string firstname; string lastname; string ssn;
			
					integer sysdate                         ;// := sysdate;
          integer rv_d30_derog_count              ;// := rv_d30_derog_count;
          integer rv_a49_curr_avm_chg_1yr         ;// := rv_a49_curr_avm_chg_1yr;
          integer rv_c22_inp_addr_owned_not_occ   ;// := rv_c22_inp_addr_owned_not_occ;
          string rv_a41_a42_prop_owner_history    ;// := rv_a41_a42_prop_owner_history;
          integer rv_e57_prof_license_br_flag     ;// := rv_e57_prof_license_br_flag;
          integer rv_i60_inq_count12              ;// := rv_i60_inq_count12;
          integer rv_i60_inq_banking_recency      ;// := rv_i60_inq_banking_recency;
          integer rv_i60_inq_hiriskcred_count12   ;// := rv_i60_inq_hiriskcred_count12;
          integer rv_l79_adls_per_addr_curr       ;// := rv_l79_adls_per_addr_curr;
          integer rv_l79_adls_per_addr_c6         ;// := rv_l79_adls_per_addr_c6;
          integer rv_f01_inp_add_house_num_match  ;// := rv_f01_inp_add_house_num_match;
          integer rv_c12_inp_addr_source_count    ;// := rv_c12_inp_addr_source_count;
          integer rv_i62_inq_ssns_per_adl         ;// := rv_i62_inq_ssns_per_adl;
          integer rv_i62_inq_phones_per_adl       ;// := rv_i62_inq_phones_per_adl;
          real o_subscore0                        ;// := o_subscore0;
          real o_subscore1                        ;// := o_subscore1;
          real o_subscore2                        ;// := o_subscore2;
          real o_subscore3                        ;// := o_subscore3;
          real o_subscore4                        ;// := o_subscore4;
          real o_subscore5                        ;// := o_subscore5;
          real o_subscore6                        ;// := o_subscore6;
          real o_subscore7                        ;// := o_subscore7;
          real o_subscore8                        ;// := o_subscore8;
          real o_subscore9                        ;// := o_subscore9;
          real o_subscore10                       ;// := o_subscore10;
          real o_subscore11                       ;// := o_subscore11;
          real o_subscore12                       ;// := o_subscore12;
          real o_subscore13                       ;// := o_subscore13;
          real o_rawscore                         ;// := o_rawscore;
          real o_lnoddsscore                      ;// := o_lnoddsscore;
          real o_probscore                        ;// := o_probscore;
          string o_aacd_0                         ;// := o_aacd_0;
          real o_dist_0                           ;// := o_dist_0;
          string o_aacd_1                         ;// := o_aacd_1;
          real o_dist_1                           ;// := o_dist_1;
          string o_aacd_2                         ;// := o_aacd_2;
          real o_dist_2                           ;// := o_dist_2;
          string o_aacd_3                         ;// := o_aacd_3;
          real o_dist_3                           ;// := o_dist_3;
          string o_aacd_4                         ;// := o_aacd_4;
          real o_dist_4                           ;// := o_dist_4;
          string o_aacd_5                         ;// := o_aacd_5;
          real o_dist_5                           ;// := o_dist_5;
          string o_aacd_6                         ;// := o_aacd_6;
          real o_dist_6                           ;// := o_dist_6;
          string o_aacd_7                         ;// := o_aacd_7;
          real o_dist_7                           ;// := o_dist_7;
          string o_aacd_8                         ;// := o_aacd_8;
          real o_dist_8                           ;// := o_dist_8;
          string o_aacd_9                         ;// := o_aacd_9;
          real o_dist_9                           ;// := o_dist_9;
          string o_aacd_10                        ;// := o_aacd_10;
          real o_dist_10                          ;// := o_dist_10;
          string o_aacd_11                        ;// := o_aacd_11;
          real o_dist_11                          ;// := o_dist_11;
          string o_aacd_12                        ;// := o_aacd_12;
          real o_dist_12                          ;// := o_dist_12;
          string o_aacd_13                        ;// := o_aacd_13;
          real o_dist_13                          ;// := o_dist_13;
          real o_rcvaluec22                       ;// := o_rcvaluec22;
          real o_rcvaluel79                       ;// := o_rcvaluel79;
          real o_rcvaluec12                       ;// := o_rcvaluec12;
          real o_rcvalued30                       ;// := o_rcvalued30;
          real o_rcvaluei60                       ;// := o_rcvaluei60;
          real o_rcvaluei62                       ;// := o_rcvaluei62;
          real o_rcvaluea41                       ;// := o_rcvaluea41;
          real o_rcvaluef01                       ;// := o_rcvaluef01;
          real o_rcvaluee57                       ;// := o_rcvaluee57;
          real o_rcvaluec10                       ;// := o_rcvaluec10;
          real o_rcvaluea49                       ;// := o_rcvaluea49;
          integer base                            ;// := base;
          real odds                               ;// := odds;
          integer point                           ;// := point;
          boolean iv_rv5_deceased                 ;// := iv_rv5_deceased;
          string iv_rv5_unscorable                ;// := iv_rv5_unscorable;
          integer rvg1706_1_0                     ;// := rvg1706_1_0;
          string o_rc1                            ;// := o_rc1;
          string o_rc2                            ;// := o_rc2;
          string o_rc3                            ;// := o_rc3;
          string o_rc4                            ;// := o_rc4;
          real o_vl1                              ;// := o_vl1;
          real o_vl2                              ;// := o_vl2;
          real o_vl3                              ;// := o_vl3;
          real o_vl4                              ;// := o_vl4;
          string _rc_inq                          ;// := _rc_inq;
          string rc1                              ;// := rc1;
          string rc2                              ;// := rc2;
          string rc3                              ;// := rc3;
          string rc4                              ;// := rc4;
          string rc5                              ;// := rc5;

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
	ssn := le.shell_input.ssn;
	firstname := le.shell_input.fname;
	lastname := le.shell_input.lname;
	
	truedid                          := le.truedid;
	nas_summary                      := le.iid.nas_summary;
	nap_summary                      := le.iid.nap_summary;
	rc_ssndod                        := le.ssn_verification.validation.deceasedDate;
	rc_decsflag                      := le.iid.decsflag;
	ver_sources                      := le.header_summary.ver_sources;
	addrpop                          := le.input_validation.address;
	add_input_house_number_match     := le.address_verification.input_address_information.house_number_match;
	add_input_owned_not_occ          := le.address_verification.inputaddr_owned_not_occupied;
	add_input_source_count           := le.address_verification.input_address_information.source_count;
	add_input_naprop                 := le.address_verification.input_address_information.naprop;
	add_input_pop                    := le.addrPop;
	property_owned_total             := le.address_verification.owned.property_total;
	add_curr_lres                    := le.lres2;
	add_curr_avm_auto_val            := le.avm.address_history_1.avm_automated_valuation;
	add_curr_avm_auto_val_2          := le.avm.address_history_1.avm_automated_valuation2;
	add_curr_naprop                  := le.address_verification.address_history_1.naprop;
	add_prev_naprop                  := le.address_verification.address_history_2.naprop;
	adls_per_addr_curr               := le.velocity_counters.adls_per_addr_current;
	adls_per_addr_c6                 := le.velocity_counters.adls_per_addr_created_6months;
	inq_count12                      := le.acc_logs.inquiries.count12;
	inq_banking_count                := le.acc_logs.banking.counttotal;
	inq_banking_count01              := le.acc_logs.banking.count01;
	inq_banking_count03              := le.acc_logs.banking.count03;
	inq_banking_count06              := le.acc_logs.banking.count06;
	inq_banking_count12              := le.acc_logs.banking.count12;
	inq_banking_count24              := le.acc_logs.banking.count24;
	inq_highriskcredit_count12       := le.acc_logs.highriskcredit.count12;
	inq_ssnsperadl                   := le.acc_logs.inquiryssnsperadl;
	inq_phonesperadl                 := le.acc_logs.inquiryphonesperadl;
	br_source_count                  := le.employment.source_ct;
	infutor_nap                      := le.infutor_phone.infutor_nap;
	attr_total_number_derogs         := le.total_number_derogs;
	prof_license_flag                := le.professional_license.professional_license_flag;

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

rv_d30_derog_count := if(not(truedid), NULL, min(if(attr_total_number_derogs = NULL, -NULL, attr_total_number_derogs), 999));

rv_a49_curr_avm_chg_1yr := map(
    not(truedid)                                              => NULL,
    add_curr_lres < 12                                        => NULL,
    add_curr_avm_auto_val > 0 and add_curr_avm_auto_val_2 > 0 => add_curr_avm_auto_val - add_curr_avm_auto_val_2,
                                                                 NULL);

rv_c22_inp_addr_owned_not_occ := if(not(add_input_pop and truedid), NULL, (integer)add_input_owned_not_occ);

rv_a41_a42_prop_owner_history := map(
    not(truedid)                                                                     => '',
    add_input_naprop = 4 or add_curr_naprop = 4 or property_owned_total > 0          => 'CURRENT',
    add_prev_naprop = 4 or Models.Common.findw_cpp(ver_sources, 'P' , ', ', 'E') > 0 => 'HISTORICAL',
                                                                                        'NEVER');

rv_e57_prof_license_br_flag := if(not(truedid), 
                                  NULL, 
																	(integer)(if(max((integer)prof_license_flag, br_source_count) = NULL, 
																	          NULL, 
																						sum((integer)prof_license_flag, 
																						    if(br_source_count = NULL, 0, br_source_count)
																							 ) 
																						  )
																						> 0)
																	);

rv_i60_inq_count12 := if(not(truedid), NULL, min(if(inq_count12 = NULL, -NULL, inq_count12), 999));

rv_i60_inq_banking_recency := map(
    not(truedid)        => NULL,
    inq_banking_count01 > 0 => 1,
    inq_banking_count03 > 0 => 3,
    inq_banking_count06 > 0 => 6,
    inq_banking_count12 > 0 => 12,
    inq_banking_count24 > 0 => 24,
    inq_banking_count   > 0 => 99,
                           0);

rv_i60_inq_hiriskcred_count12 := if(not(truedid), NULL, min(if(inq_highRiskCredit_count12 = NULL, -NULL, inq_highRiskCredit_count12), 999));

rv_l79_adls_per_addr_curr := if(not(addrpop), NULL, min(if(adls_per_addr_curr = NULL, -NULL, adls_per_addr_curr), 999));

rv_l79_adls_per_addr_c6 := if(not(addrpop), NULL, min(if(adls_per_addr_c6 = NULL, -NULL, adls_per_addr_c6), 999));

rv_f01_inp_add_house_num_match := if(not(add_input_pop and truedid), NULL, (integer)add_input_house_number_match);

rv_c12_inp_addr_source_count := if(not(add_input_pop and truedid), 
                                   NULL, 
																	 min((integer)(if(add_input_source_count = NULL, 
																	               -NULL, 
																								 add_input_source_count)), 
																				999)
																	);

rv_i62_inq_ssns_per_adl := if(not(truedid), NULL, min(if(inq_ssnsperadl = NULL, -NULL, inq_ssnsperadl), 999));

rv_i62_inq_phones_per_adl := if(not(truedid), NULL, min(if(inq_phonesperadl = NULL, -NULL, inq_phonesperadl), 999));

o_subscore0 := map(
    NULL < rv_d30_derog_count AND rv_d30_derog_count < 1 => 0.097282,
    1 <= rv_d30_derog_count AND rv_d30_derog_count < 2   => -0.002397,
    2 <= rv_d30_derog_count AND rv_d30_derog_count < 3   => -0.423075,
    3 <= rv_d30_derog_count                              => -0.863554,
                                                            -0.000000);

o_subscore1 := map(
    NULL < rv_i60_inq_hiriskcred_count12 AND rv_i60_inq_hiriskcred_count12 < 1 => 0.086435,
    1 <= rv_i60_inq_hiriskcred_count12 AND rv_i60_inq_hiriskcred_count12 < 3   => -0.655529,
    3 <= rv_i60_inq_hiriskcred_count12                                         => -1.147090,
                                                                                  -0.000000);

o_subscore2 := map(
    (rv_a41_a42_prop_owner_history in [''])                      => 0.003844,
    (rv_a41_a42_prop_owner_history in ['CURRENT', 'HISTORICAL']) => 0.179419,
    (rv_a41_a42_prop_owner_history in ['NEVER'])                 => -0.262687,
                                                                    0.000000);

o_subscore3 := map(
    NULL < rv_i60_inq_count12 AND rv_i60_inq_count12 < 1 => 0.062032,
    1 <= rv_i60_inq_count12 AND rv_i60_inq_count12 < 2   => -0.042881,
    2 <= rv_i60_inq_count12 AND rv_i60_inq_count12 < 3   => -0.307960,
    3 <= rv_i60_inq_count12                              => -0.448643,
                                                            0.000000);

o_subscore4 := map(
    (rv_e57_prof_license_br_flag in [NULL]) => -0.047391,
    (rv_e57_prof_license_br_flag in [0]) => -0.065185,
    (rv_e57_prof_license_br_flag in [1]) => 0.188248,
                                              0.000000);

o_subscore5 := map(
    (rv_c22_inp_addr_owned_not_occ in [NULL]) => 0.000000,
    (rv_c22_inp_addr_owned_not_occ in [0]) => 0.026405,
    (rv_c22_inp_addr_owned_not_occ in [1]) => -0.471728,
                                                0.000000);

o_subscore6 := map(
    NULL < rv_l79_adls_per_addr_curr AND rv_l79_adls_per_addr_curr < 1 => -0.094649,
    1 <= rv_l79_adls_per_addr_curr AND rv_l79_adls_per_addr_curr < 2   => 0.114590,
    2 <= rv_l79_adls_per_addr_curr AND rv_l79_adls_per_addr_curr < 3   => 0.069487,
    3 <= rv_l79_adls_per_addr_curr AND rv_l79_adls_per_addr_curr < 4   => 0.023650,
    4 <= rv_l79_adls_per_addr_curr AND rv_l79_adls_per_addr_curr < 5   => -0.033859,
    5 <= rv_l79_adls_per_addr_curr AND rv_l79_adls_per_addr_curr < 6   => -0.103039,
    6 <= rv_l79_adls_per_addr_curr AND rv_l79_adls_per_addr_curr < 7   => -0.185823,
    7 <= rv_l79_adls_per_addr_curr                                     => -0.307874,
                                                                          0.000000);

o_subscore7 := map(
    NULL < rv_i62_inq_phones_per_adl AND rv_i62_inq_phones_per_adl < 2 => 0.027425,
    2 <= rv_i62_inq_phones_per_adl AND rv_i62_inq_phones_per_adl < 3   => -0.053725,
    3 <= rv_i62_inq_phones_per_adl                                     => -0.769479,
                                                                          0.000000);

o_subscore8 := map(
    (rv_f01_inp_add_house_num_match in [NULL]) => 0.029901,
    (rv_f01_inp_add_house_num_match in [0]) => -0.241789,
    (rv_f01_inp_add_house_num_match in [1]) => 0.031181,
                                                 0.000000);

o_subscore9 := map(
    NULL < rv_a49_curr_avm_chg_1yr AND rv_a49_curr_avm_chg_1yr < -5880   => -0.251099,
    -5880 <= rv_a49_curr_avm_chg_1yr AND rv_a49_curr_avm_chg_1yr < 44224 => 0.031298,
    44224 <= rv_a49_curr_avm_chg_1yr                                     => 0.164300,
                                                                            -0.000000);

o_subscore10 := map(
    NULL < rv_i62_inq_ssns_per_adl AND rv_i62_inq_ssns_per_adl < 2 => 0.024498,
    2 <= rv_i62_inq_ssns_per_adl AND rv_i62_inq_ssns_per_adl < 3   => -0.241744,
    3 <= rv_i62_inq_ssns_per_adl                                   => -0.500906,
                                                                      0.000000);

o_subscore11 := map(
    NULL < rv_l79_adls_per_addr_c6 AND rv_l79_adls_per_addr_c6 < 1 => 0.047331,
    1 <= rv_l79_adls_per_addr_c6 AND rv_l79_adls_per_addr_c6 < 2   => -0.047011,
    2 <= rv_l79_adls_per_addr_c6 AND rv_l79_adls_per_addr_c6 < 4   => -0.154172,
    4 <= rv_l79_adls_per_addr_c6 AND rv_l79_adls_per_addr_c6 < 6   => -0.206274,
    6 <= rv_l79_adls_per_addr_c6                                   => -0.353942,
                                                                      0.000000);

o_subscore12 := map(
    NULL < rv_i60_inq_banking_recency AND rv_i60_inq_banking_recency < 1 => 0.019840,
    1 <= rv_i60_inq_banking_recency                                      => -0.451301,
                                                                            0.000000);

o_subscore13 := map(
    NULL < rv_c12_inp_addr_source_count AND rv_c12_inp_addr_source_count < 1 => -0.254676,
    1 <= rv_c12_inp_addr_source_count AND rv_c12_inp_addr_source_count < 4   => -0.000935,
    4 <= rv_c12_inp_addr_source_count                                        => 0.073710,
                                                                                0.000000);

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
    o_subscore13;

o_lnoddsscore := o_rawscore + 4.049699;

o_probscore := exp(o_lnoddsscore) / (1 + exp(o_lnoddsscore));

o_aacd_0 := map(
    NULL < rv_d30_derog_count AND rv_d30_derog_count < 1 => 'D30',
    1 <= rv_d30_derog_count AND rv_d30_derog_count < 2   => 'D30',
    2 <= rv_d30_derog_count AND rv_d30_derog_count < 3   => 'D30',
    3 <= rv_d30_derog_count                              => 'D30',
                                                            'C10');

o_dist_0 := o_subscore0 - 0.097282;

o_aacd_1 := map(
    NULL < rv_i60_inq_hiriskcred_count12 AND rv_i60_inq_hiriskcred_count12 < 1 => 'I60',
    1 <= rv_i60_inq_hiriskcred_count12 AND rv_i60_inq_hiriskcred_count12 < 3   => 'I60',
    3 <= rv_i60_inq_hiriskcred_count12                                         => 'I60',
                                                                                  '');

o_dist_1 := o_subscore1 - 0.086435;

o_aacd_2 := map(
    (rv_a41_a42_prop_owner_history in [''])                      => '',
    (rv_a41_a42_prop_owner_history in ['CURRENT', 'HISTORICAL']) => 'A41',
    (rv_a41_a42_prop_owner_history in ['NEVER'])                 => 'A41',
                                                                    '');

o_dist_2 := o_subscore2 - 0.179419;

o_aacd_3 := map(
    NULL < rv_i60_inq_count12 AND rv_i60_inq_count12 < 1 => 'I60',
    1 <= rv_i60_inq_count12 AND rv_i60_inq_count12 < 2   => 'I60',
    2 <= rv_i60_inq_count12 AND rv_i60_inq_count12 < 3   => 'I60',
    3 <= rv_i60_inq_count12                              => 'I60',
                                                            '');

o_dist_3 := o_subscore3 - 0.062032;

o_aacd_4 := map(
    (rv_e57_prof_license_br_flag in [NULL]) => '',
    (rv_e57_prof_license_br_flag in [0]) => 'E57',
    (rv_e57_prof_license_br_flag in [1]) => 'E57',
                                              '');

o_dist_4 := o_subscore4 - 0.188248;

o_aacd_5 := map(
    (rv_c22_inp_addr_owned_not_occ in [NULL]) => '',
    (rv_c22_inp_addr_owned_not_occ in [0]) => 'C22',
    (rv_c22_inp_addr_owned_not_occ in [1]) => 'C22',
                                                '');

o_dist_5 := o_subscore5 - 0.026405;

o_aacd_6 := map(
    NULL < rv_l79_adls_per_addr_curr AND rv_l79_adls_per_addr_curr < 1 => 'L79',
    1 <= rv_l79_adls_per_addr_curr AND rv_l79_adls_per_addr_curr < 2   => 'L79',
    2 <= rv_l79_adls_per_addr_curr AND rv_l79_adls_per_addr_curr < 3   => 'L79',
    3 <= rv_l79_adls_per_addr_curr AND rv_l79_adls_per_addr_curr < 4   => 'L79',
    4 <= rv_l79_adls_per_addr_curr AND rv_l79_adls_per_addr_curr < 5   => 'L79',
    5 <= rv_l79_adls_per_addr_curr AND rv_l79_adls_per_addr_curr < 6   => 'L79',
    6 <= rv_l79_adls_per_addr_curr AND rv_l79_adls_per_addr_curr < 7   => 'L79',
    7 <= rv_l79_adls_per_addr_curr                                     => 'L79',
                                                                          '');

o_dist_6 := o_subscore6 - 0.11459;

o_aacd_7 := map(
    NULL < rv_i62_inq_phones_per_adl AND rv_i62_inq_phones_per_adl < 2 => 'I62',
    2 <= rv_i62_inq_phones_per_adl AND rv_i62_inq_phones_per_adl < 3   => 'I62',
    3 <= rv_i62_inq_phones_per_adl                                     => 'I62',
                                                                          '');

o_dist_7 := o_subscore7 - 0.027425;

o_aacd_8 := map(
    (rv_f01_inp_add_house_num_match in [NULL]) => '',
    (rv_f01_inp_add_house_num_match in [0]) => 'F01',
    (rv_f01_inp_add_house_num_match in [1]) => 'F01',
                                                 '');

o_dist_8 := o_subscore8 - 0.031181;

o_aacd_9 := map(
    NULL < rv_a49_curr_avm_chg_1yr AND rv_a49_curr_avm_chg_1yr < -5880   => 'A49',
    -5880 <= rv_a49_curr_avm_chg_1yr AND rv_a49_curr_avm_chg_1yr < 44224 => 'A49',
    44224 <= rv_a49_curr_avm_chg_1yr                                     => 'A49',
                                                                            '');

o_dist_9 := o_subscore9 - 0.1643;

o_aacd_10 := map(
    NULL < rv_i62_inq_ssns_per_adl AND rv_i62_inq_ssns_per_adl < 2 => 'I62',
    2 <= rv_i62_inq_ssns_per_adl AND rv_i62_inq_ssns_per_adl < 3   => 'I62',
    3 <= rv_i62_inq_ssns_per_adl                                   => 'I62',
                                                                      '');

o_dist_10 := o_subscore10 - 0.024498;

o_aacd_11 := map(
    NULL < rv_l79_adls_per_addr_c6 AND rv_l79_adls_per_addr_c6 < 1 => 'L79',
    1 <= rv_l79_adls_per_addr_c6 AND rv_l79_adls_per_addr_c6 < 2   => 'L79',
    2 <= rv_l79_adls_per_addr_c6 AND rv_l79_adls_per_addr_c6 < 4   => 'L79',
    4 <= rv_l79_adls_per_addr_c6 AND rv_l79_adls_per_addr_c6 < 6   => 'L79',
    6 <= rv_l79_adls_per_addr_c6                                   => 'L79',
                                                                      '');

o_dist_11 := o_subscore11 - 0.047331;

o_aacd_12 := map(
    NULL < rv_i60_inq_banking_recency AND rv_i60_inq_banking_recency < 1 => 'I60',
    1 <= rv_i60_inq_banking_recency                                      => 'I60',
                                                                            '');

o_dist_12 := o_subscore12 - 0.01984;

o_aacd_13 := map(
    NULL < rv_c12_inp_addr_source_count AND rv_c12_inp_addr_source_count < 1 => 'C12',
    1 <= rv_c12_inp_addr_source_count AND rv_c12_inp_addr_source_count < 4   => 'C12',
    4 <= rv_c12_inp_addr_source_count                                        => 'C12',
                                                                                '');

o_dist_13 := o_subscore13 - 0.07371;

o_rcvaluec22 := (integer)(o_aacd_0 = 'C22') * o_dist_0 +
    (integer)(o_aacd_1 = 'C22') * o_dist_1 +
    (integer)(o_aacd_2 = 'C22') * o_dist_2 +
    (integer)(o_aacd_3 = 'C22') * o_dist_3 +
    (integer)(o_aacd_4 = 'C22') * o_dist_4 +
    (integer)(o_aacd_5 = 'C22') * o_dist_5 +
    (integer)(o_aacd_6 = 'C22') * o_dist_6 +
    (integer)(o_aacd_7 = 'C22') * o_dist_7 +
    (integer)(o_aacd_8 = 'C22') * o_dist_8 +
    (integer)(o_aacd_9 = 'C22') * o_dist_9 +
    (integer)(o_aacd_10 = 'C22') * o_dist_10 +
    (integer)(o_aacd_11 = 'C22') * o_dist_11 +
    (integer)(o_aacd_12 = 'C22') * o_dist_12 +
    (integer)(o_aacd_13 = 'C22') * o_dist_13;

o_rcvaluel79 := (integer)(o_aacd_0 = 'L79') * o_dist_0 +
    (integer)(o_aacd_1 = 'L79') * o_dist_1 +
    (integer)(o_aacd_2 = 'L79') * o_dist_2 +
    (integer)(o_aacd_3 = 'L79') * o_dist_3 +
    (integer)(o_aacd_4 = 'L79') * o_dist_4 +
    (integer)(o_aacd_5 = 'L79') * o_dist_5 +
    (integer)(o_aacd_6 = 'L79') * o_dist_6 +
    (integer)(o_aacd_7 = 'L79') * o_dist_7 +
    (integer)(o_aacd_8 = 'L79') * o_dist_8 +
    (integer)(o_aacd_9 = 'L79') * o_dist_9 +
    (integer)(o_aacd_10 = 'L79') * o_dist_10 +
    (integer)(o_aacd_11 = 'L79') * o_dist_11 +
    (integer)(o_aacd_12 = 'L79') * o_dist_12 +
    (integer)(o_aacd_13 = 'L79') * o_dist_13;

o_rcvaluec12 := (integer)(o_aacd_0 = 'C12') * o_dist_0 +
    (integer)(o_aacd_1 = 'C12') * o_dist_1 +
    (integer)(o_aacd_2 = 'C12') * o_dist_2 +
    (integer)(o_aacd_3 = 'C12') * o_dist_3 +
    (integer)(o_aacd_4 = 'C12') * o_dist_4 +
    (integer)(o_aacd_5 = 'C12') * o_dist_5 +
    (integer)(o_aacd_6 = 'C12') * o_dist_6 +
    (integer)(o_aacd_7 = 'C12') * o_dist_7 +
    (integer)(o_aacd_8 = 'C12') * o_dist_8 +
    (integer)(o_aacd_9 = 'C12') * o_dist_9 +
    (integer)(o_aacd_10 = 'C12') * o_dist_10 +
    (integer)(o_aacd_11 = 'C12') * o_dist_11 +
    (integer)(o_aacd_12 = 'C12') * o_dist_12 +
    (integer)(o_aacd_13 = 'C12') * o_dist_13;

o_rcvalued30 := (integer)(o_aacd_0 = 'D30') * o_dist_0 +
    (integer)(o_aacd_1 = 'D30') * o_dist_1 +
    (integer)(o_aacd_2 = 'D30') * o_dist_2 +
    (integer)(o_aacd_3 = 'D30') * o_dist_3 +
    (integer)(o_aacd_4 = 'D30') * o_dist_4 +
    (integer)(o_aacd_5 = 'D30') * o_dist_5 +
    (integer)(o_aacd_6 = 'D30') * o_dist_6 +
    (integer)(o_aacd_7 = 'D30') * o_dist_7 +
    (integer)(o_aacd_8 = 'D30') * o_dist_8 +
    (integer)(o_aacd_9 = 'D30') * o_dist_9 +
    (integer)(o_aacd_10 = 'D30') * o_dist_10 +
    (integer)(o_aacd_11 = 'D30') * o_dist_11 +
    (integer)(o_aacd_12 = 'D30') * o_dist_12 +
    (integer)(o_aacd_13 = 'D30') * o_dist_13;

o_rcvaluei60 := (integer)(o_aacd_0 = 'I60') * o_dist_0 +
    (integer)(o_aacd_1 = 'I60') * o_dist_1 +
    (integer)(o_aacd_2 = 'I60') * o_dist_2 +
    (integer)(o_aacd_3 = 'I60') * o_dist_3 +
    (integer)(o_aacd_4 = 'I60') * o_dist_4 +
    (integer)(o_aacd_5 = 'I60') * o_dist_5 +
    (integer)(o_aacd_6 = 'I60') * o_dist_6 +
    (integer)(o_aacd_7 = 'I60') * o_dist_7 +
    (integer)(o_aacd_8 = 'I60') * o_dist_8 +
    (integer)(o_aacd_9 = 'I60') * o_dist_9 +
    (integer)(o_aacd_10 = 'I60') * o_dist_10 +
    (integer)(o_aacd_11 = 'I60') * o_dist_11 +
    (integer)(o_aacd_12 = 'I60') * o_dist_12 +
    (integer)(o_aacd_13 = 'I60') * o_dist_13;

o_rcvaluei62 := (integer)(o_aacd_0 = 'I62') * o_dist_0 +
    (integer)(o_aacd_1 = 'I62') * o_dist_1 +
    (integer)(o_aacd_2 = 'I62') * o_dist_2 +
    (integer)(o_aacd_3 = 'I62') * o_dist_3 +
    (integer)(o_aacd_4 = 'I62') * o_dist_4 +
    (integer)(o_aacd_5 = 'I62') * o_dist_5 +
    (integer)(o_aacd_6 = 'I62') * o_dist_6 +
    (integer)(o_aacd_7 = 'I62') * o_dist_7 +
    (integer)(o_aacd_8 = 'I62') * o_dist_8 +
    (integer)(o_aacd_9 = 'I62') * o_dist_9 +
    (integer)(o_aacd_10 = 'I62') * o_dist_10 +
    (integer)(o_aacd_11 = 'I62') * o_dist_11 +
    (integer)(o_aacd_12 = 'I62') * o_dist_12 +
    (integer)(o_aacd_13 = 'I62') * o_dist_13;

o_rcvaluea41 := (integer)(o_aacd_0 = 'A41') * o_dist_0 +
    (integer)(o_aacd_1 = 'A41') * o_dist_1 +
    (integer)(o_aacd_2 = 'A41') * o_dist_2 +
    (integer)(o_aacd_3 = 'A41') * o_dist_3 +
    (integer)(o_aacd_4 = 'A41') * o_dist_4 +
    (integer)(o_aacd_5 = 'A41') * o_dist_5 +
    (integer)(o_aacd_6 = 'A41') * o_dist_6 +
    (integer)(o_aacd_7 = 'A41') * o_dist_7 +
    (integer)(o_aacd_8 = 'A41') * o_dist_8 +
    (integer)(o_aacd_9 = 'A41') * o_dist_9 +
    (integer)(o_aacd_10 = 'A41') * o_dist_10 +
    (integer)(o_aacd_11 = 'A41') * o_dist_11 +
    (integer)(o_aacd_12 = 'A41') * o_dist_12 +
    (integer)(o_aacd_13 = 'A41') * o_dist_13;

o_rcvaluef01 := (integer)(o_aacd_0 = 'F01') * o_dist_0 +
    (integer)(o_aacd_1 = 'F01') * o_dist_1 +
    (integer)(o_aacd_2 = 'F01') * o_dist_2 +
    (integer)(o_aacd_3 = 'F01') * o_dist_3 +
    (integer)(o_aacd_4 = 'F01') * o_dist_4 +
    (integer)(o_aacd_5 = 'F01') * o_dist_5 +
    (integer)(o_aacd_6 = 'F01') * o_dist_6 +
    (integer)(o_aacd_7 = 'F01') * o_dist_7 +
    (integer)(o_aacd_8 = 'F01') * o_dist_8 +
    (integer)(o_aacd_9 = 'F01') * o_dist_9 +
    (integer)(o_aacd_10 = 'F01') * o_dist_10 +
    (integer)(o_aacd_11 = 'F01') * o_dist_11 +
    (integer)(o_aacd_12 = 'F01') * o_dist_12 +
    (integer)(o_aacd_13 = 'F01') * o_dist_13;

o_rcvaluee57 := (integer)(o_aacd_0 = 'E57') * o_dist_0 +
    (integer)(o_aacd_1 = 'E57') * o_dist_1 +
    (integer)(o_aacd_2 = 'E57') * o_dist_2 +
    (integer)(o_aacd_3 = 'E57') * o_dist_3 +
    (integer)(o_aacd_4 = 'E57') * o_dist_4 +
    (integer)(o_aacd_5 = 'E57') * o_dist_5 +
    (integer)(o_aacd_6 = 'E57') * o_dist_6 +
    (integer)(o_aacd_7 = 'E57') * o_dist_7 +
    (integer)(o_aacd_8 = 'E57') * o_dist_8 +
    (integer)(o_aacd_9 = 'E57') * o_dist_9 +
    (integer)(o_aacd_10 = 'E57') * o_dist_10 +
    (integer)(o_aacd_11 = 'E57') * o_dist_11 +
    (integer)(o_aacd_12 = 'E57') * o_dist_12 +
    (integer)(o_aacd_13 = 'E57') * o_dist_13;

o_rcvaluec10 := (integer)(o_aacd_0 = 'C10') * o_dist_0 +
    (integer)(o_aacd_1 = 'C10') * o_dist_1 +
    (integer)(o_aacd_2 = 'C10') * o_dist_2 +
    (integer)(o_aacd_3 = 'C10') * o_dist_3 +
    (integer)(o_aacd_4 = 'C10') * o_dist_4 +
    (integer)(o_aacd_5 = 'C10') * o_dist_5 +
    (integer)(o_aacd_6 = 'C10') * o_dist_6 +
    (integer)(o_aacd_7 = 'C10') * o_dist_7 +
    (integer)(o_aacd_8 = 'C10') * o_dist_8 +
    (integer)(o_aacd_9 = 'C10') * o_dist_9 +
    (integer)(o_aacd_10 = 'C10') * o_dist_10 +
    (integer)(o_aacd_11 = 'C10') * o_dist_11 +
    (integer)(o_aacd_12 = 'C10') * o_dist_12 +
    (integer)(o_aacd_13 = 'C10') * o_dist_13;

o_rcvaluea49 := (integer)(o_aacd_0 = 'A49') * o_dist_0 +
    (integer)(o_aacd_1 = 'A49') * o_dist_1 +
    (integer)(o_aacd_2 = 'A49') * o_dist_2 +
    (integer)(o_aacd_3 = 'A49') * o_dist_3 +
    (integer)(o_aacd_4 = 'A49') * o_dist_4 +
    (integer)(o_aacd_5 = 'A49') * o_dist_5 +
    (integer)(o_aacd_6 = 'A49') * o_dist_6 +
    (integer)(o_aacd_7 = 'A49') * o_dist_7 +
    (integer)(o_aacd_8 = 'A49') * o_dist_8 +
    (integer)(o_aacd_9 = 'A49') * o_dist_9 +
    (integer)(o_aacd_10 = 'A49') * o_dist_10 +
    (integer)(o_aacd_11 = 'A49') * o_dist_11 +
    (integer)(o_aacd_12 = 'A49') * o_dist_12 +
    (integer)(o_aacd_13 = 'A49') * o_dist_13;

base := 700;

odds := (1 - 0.0186) / 0.0186;

point := 75;

iv_rv5_deceased := rc_decsflag = '1' or rc_ssndod != 0 or indexw(StringLib.StringToUpperCase(trim(ver_sources, ALL)), 'DS', ',') or indexw(StringLib.StringToUpperCase(trim(ver_sources, ALL)), 'DE', ',');

iv_rv5_unscorable := if(riskview.constants.noscore(le.iid.nas_summary,le.iid.nap_summary, le.address_verification.input_address_information.naprop, le.truedid), '1', '0');

rvg1706_1_0 := map(
    iv_rv5_deceased         => 200,
    iv_rv5_unscorable = '1' => 222,
                               min(if(max(round(point * (o_lnoddsscore - ln(odds)) / ln(2) + base), 501) = NULL, -NULL, max(round(point * (o_lnoddsscore - ln(odds)) / ln(2) + base), 501)), 900));


//*************************************************************************************//
// I have no idea how the reason code logic gets implemented in ECL, so everything below 
// probably needs to get changed or replaced.  The methodology for creating the reason codes is
// very similar to the logic used by the RiskView 4.0 scores, so you might want to consult
// that model code for guidance on implementing reason codes. 
//*************************************************************************************//

ds_layout := {STRING rc, REAL value};


 
//*************************************************************************************//
rc_dataset_o := DATASET([
    {'C22', o_rcvalueC22},
    {'L79', o_rcvalueL79},
    {'C12', o_rcvalueC12},
    {'D30', o_rcvalueD30},
    {'I60', o_rcvalueI60},
    {'I62', o_rcvalueI62},
    {'A41', o_rcvalueA41},
    {'F01', o_rcvalueF01},
    {'E57', o_rcvalueE57},
    {'C10', o_rcvalueC10},
    {'A49', o_rcvalueA49}
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
    inq_count12 > 0                => 'I60',
    inq_banking_count > 0          => 'I60',
    inq_highRiskCredit_count12 > 0 => 'I60',
                                      ' ');

rc3_c48 := map(
    trim((string)rc1_2, LEFT, RIGHT) = '' => '',
    trim((string)rc2_2, LEFT, RIGHT) = '' => '',
    trim((string)rc3_2, LEFT, RIGHT) = '' => _rc_inq,
    trim((string)rc4_2, LEFT, RIGHT) = '' => '',
                                             '');

rc2_c48 := map(
    trim((string)rc1_2, LEFT, RIGHT) = '' => '',
    trim((string)rc2_2, LEFT, RIGHT) = '' => _rc_inq,
    trim((string)rc3_2, LEFT, RIGHT) = '' => '',
    trim((string)rc4_2, LEFT, RIGHT) = '' => '',
                                             '');

rc4_c48 := map(
    trim((string)rc1_2, LEFT, RIGHT) = '' => '',
    trim((string)rc2_2, LEFT, RIGHT) = '' => '',
    trim((string)rc3_2, LEFT, RIGHT) = '' => '',
    trim((string)rc4_2, LEFT, RIGHT) = '' => _rc_inq,
                                             '');

rc5_c48 := map(
    trim((string)rc1_2, LEFT, RIGHT) = '' => '',
    trim((string)rc2_2, LEFT, RIGHT) = '' => '',
    trim((string)rc3_2, LEFT, RIGHT) = '' => '',
    trim((string)rc4_2, LEFT, RIGHT) = '' => '',
                                             _rc_inq);

rc1_c48 := map(
    trim((string)rc1_2, LEFT, RIGHT) = '' => _rc_inq,
    trim((string)rc2_2, LEFT, RIGHT) = '' => '',
    trim((string)rc3_2, LEFT, RIGHT) = '' => '',
    trim((string)rc4_2, LEFT, RIGHT) = '' => '',
                                             '');

rc5_1 := if(rc5_c48 != '' and not((rc1_2 in ['I60'])) and not((rc2_2 in ['I60'])) and not((rc3_2 in ['I60'])) and not((rc4_2 in ['I60'])), rc5_c48, '');

rc1_1 := if(rc1_c48 != '' and not((rc1_2 in ['I60'])) and not((rc2_2 in ['I60'])) and not((rc3_2 in ['I60'])) and not((rc4_2 in ['I60'])), rc1_c48, rc1_2);

rc3_1 := if(rc3_c48 != '' and not((rc1_2 in ['I60'])) and not((rc2_2 in ['I60'])) and not((rc3_2 in ['I60'])) and not((rc4_2 in ['I60'])), rc3_c48, rc3_2);

rc4_1 := if(rc4_c48 != '' and not((rc1_2 in ['I60'])) and not((rc2_2 in ['I60'])) and not((rc3_2 in ['I60'])) and not((rc4_2 in ['I60'])), rc4_c48, rc4_2);

rc2_1 := if(rc2_c48 != '' and not((rc1_2 in ['I60'])) and not((rc2_2 in ['I60'])) and not((rc3_2 in ['I60'])) and not((rc4_2 in ['I60'])), rc2_c48, rc2_2);

rc1 := if((rvg1706_1_0 in [200, 222]), '', rc1_1);

rc5 := if((rvg1706_1_0 in [200, 222]), '', rc5_1);

rc4 := if((rvg1706_1_0 in [200, 222]), '', rc4_1);

rc2 := if((rvg1706_1_0 in [200, 222]), '', rc2_1);

rc3 := if((rvg1706_1_0 in [200, 222]), '', rc3_1);


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
													RVG1706_1_0 = 200 => DATASET([{'00'}], HRILayout),
													RVG1706_1_0 = 222 => DATASET([{'00'}], HRILayout),
													RVG1706_1_0 = 900 => DATASET([{'00'}], HRILayout),
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
		self.firstname := firstname; self.lastname := lastname; self.ssn := ssn;
		
										self.sysdate                          := sysdate;
                    self.rv_d30_derog_count               := rv_d30_derog_count;
                    self.rv_a49_curr_avm_chg_1yr          := rv_a49_curr_avm_chg_1yr;
                    self.rv_c22_inp_addr_owned_not_occ    := rv_c22_inp_addr_owned_not_occ;
                    self.rv_a41_a42_prop_owner_history    := rv_a41_a42_prop_owner_history;
                    self.rv_e57_prof_license_br_flag      := rv_e57_prof_license_br_flag;
                    self.rv_i60_inq_count12               := rv_i60_inq_count12;
                    self.rv_i60_inq_banking_recency       := rv_i60_inq_banking_recency;
                    self.rv_i60_inq_hiriskcred_count12    := rv_i60_inq_hiriskcred_count12;
                    self.rv_l79_adls_per_addr_curr        := rv_l79_adls_per_addr_curr;
                    self.rv_l79_adls_per_addr_c6          := rv_l79_adls_per_addr_c6;
                    self.rv_f01_inp_add_house_num_match   := rv_f01_inp_add_house_num_match;
                    self.rv_c12_inp_addr_source_count     := rv_c12_inp_addr_source_count;
                    self.rv_i62_inq_ssns_per_adl          := rv_i62_inq_ssns_per_adl;
                    self.rv_i62_inq_phones_per_adl        := rv_i62_inq_phones_per_adl;
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
                    self.o_rcvaluec22                     := o_rcvaluec22;
                    self.o_rcvaluel79                     := o_rcvaluel79;
                    self.o_rcvaluec12                     := o_rcvaluec12;
                    self.o_rcvalued30                     := o_rcvalued30;
                    self.o_rcvaluei60                     := o_rcvaluei60;
                    self.o_rcvaluei62                     := o_rcvaluei62;
                    self.o_rcvaluea41                     := o_rcvaluea41;
                    self.o_rcvaluef01                     := o_rcvaluef01;
                    self.o_rcvaluee57                     := o_rcvaluee57;
                    self.o_rcvaluec10                     := o_rcvaluec10;
                    self.o_rcvaluea49                     := o_rcvaluea49;
                    self.base                             := base;
                    self.odds                             := odds;
                    self.point                            := point;
                    self.iv_rv5_deceased                  := iv_rv5_deceased;
                    self.iv_rv5_unscorable                := iv_rv5_unscorable;
                    self.rvg1706_1_0                      := rvg1706_1_0;
                    self.o_rc1                            := o_rc1;
                    self.o_rc2                            := o_rc2;
                    self.o_rc3                            := o_rc3;
                    self.o_rc4                            := o_rc4;
                    self.o_vl1                            := o_vl1;
                    self.o_vl2                            := o_vl2;
                    self.o_vl3                            := o_vl3;
                    self.o_vl4                            := o_vl4;
                    self._rc_inq                          := _rc_inq;
                    self.rc1                              := rc1;
                    self.rc2                              := rc2;
                    self.rc3                              := rc3;
                    self.rc4                              := rc4;
                    self.rc5                              := rc5;

		SELF.clam := le;
	#else
		SELF.ri := PROJECT(reasonCodes, TRANSFORM(Risk_Indicators.Layout_Desc,
																							SELF.hri := LEFT.hri,
																							SELF.desc := Risk_Indicators.getHRIDesc(LEFT.hri)
																					));
		SELF.score := (STRING3)rvg1706_1_0;
		SELF.seq := le.seq;
	#end
	END;

	model := PROJECT(clam, doModel(LEFT));

	RETURN(model);
END;

